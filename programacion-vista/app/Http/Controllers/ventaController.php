<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

class VentaController extends Controller
{
    public function mostrar()
    {
        // Consultar los métodos de pago
        $metodosDePago = DB::table('metodos_pago')->select('id_metodo_pago', 'nombre')->get();

        // Retornar la vista con los métodos de pago
        return view('welcome', ['metodosDePago' => $metodosDePago]);
    }

    
    public function obtenerClientesCorrientes()
    {
        $clientesCorrientes = DB::table('clientes_corrientes')
            ->select('id_cliente', 'nombre_y_apellido', 'dni')
            ->where('estado', 'activo')
            ->get();
         
        return response()->json($clientesCorrientes);
    }
  
    public function guardar(Request $request)
    {

        // Validar los datos de entrada
        $request->validate([
            'metodo_pago' => 'required|exists:metodos_pago,id_metodo_pago',
            'descuento' => 'nullable|numeric|min:0',
            'productos' => 'required|array',
            'productos.*' => 'required|array',
            'productos.*.id_producto' => 'required|exists:productos,id_producto',
            'productos.*.cantidad' => 'required|integer|min:1',
            'productos.*.precio' => 'required|numeric|min:0',
            'id_cliente' => 'required_if:metodo_pago,3|exists:clientes_corrientes,id_cliente',
        ]);

        // Iniciar una transacción de base de datos
        DB::beginTransaction();

        try {
            $montoTotal = 0;

            // Calcular el monto total y verificar el stock
            foreach ($request->productos as $producto) {
                $productoInfo = DB::table('productos')
                    ->where('id_producto', $producto['id_producto'])
                    ->first();

                    if (!$productoInfo || $productoInfo->stock < $producto['cantidad']) {
                        // Si no hay suficiente stock, redirigir con un mensaje de error específico
                        return redirect()->back()->with('error', 'Stock insuficiente para el producto: ' . $productoInfo->nombre);
                    }
    
                    $montoTotal += $producto['precio'] * $producto['cantidad'];
            }

            // Aplicar descuento si existe
            $descuento = $request->descuento ?? 0;
            $montoTotal -= $descuento;

            $idVenta = DB::table('ventas')
            ->insertGetId([
                'id_usuario' => Auth::id(),
                'fecha_venta' => now(),
                'monto_total' => $montoTotal,
                'id_metodo_pago' => $request->metodo_pago,
                'descuento' => $descuento,
                'id_cliente' => $request->metodo_pago == 3 ? $request->id_cliente : null,
            ]);

            // Insertar los productos de la venta
            foreach ($request->productos as $producto) {
                DB::table('ventas_productos')->insert([
                    'id_venta' => $idVenta,
                    'id_producto' => $producto['id_producto'],
                    'cantidad' => $producto['cantidad'],
                    'precio' => $producto['precio']
                ]);

                // Actualizar el stock del producto
                DB::table('productos')
                    ->where('id_producto', $producto['id_producto'])
                    ->decrement('stock', $producto['cantidad']);
            }

            // Confirmar la transacción
            DB::commit();

            return redirect()->route('ventas.index')->with('success', 'Venta guardada con éxito');
        } catch (\Exception $e) {
            // Si algo sale mal, deshacer la transacción
            DB::rollBack();
            return redirect()->back()->with('error', 'No se pudo guardar la venta. Inténtalo nuevamente.');
        }
    }
}