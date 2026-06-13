<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

class VentaController extends Controller
{
    public function mostrar()
    {
        $metodosDePago = DB::table('metodos_pago')->select('id_metodo_pago', 'nombre')->get();
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

        DB::beginTransaction();

        try {
            $montoTotal = 0;

            // Calcular el subtotal bruto acumulado y verificar existencias
            foreach ($request->productos as $producto) {
                $productoInfo = DB::table('productos')
                    ->where('id_producto', $producto['id_producto'])
                    ->first();

                if (!$productoInfo || $productoInfo->stock < $producto['cantidad']) {
                    DB::rollBack();
                    return redirect()->back()->with('error', 'Stock insuficiente para el producto: ' . $productoInfo->nombre);
                }
    
                $montoTotal += $producto['precio'] * $producto['cantidad'];
            }

            $descuento = $request->descuento ?? 0;

            // CONTROL DE SEGURIDAD BACKEND: El descuento no puede superar la suma de la mercadería
            if ($descuento > $montoTotal) {
                DB::rollBack();
                return redirect()->back()->with('error', 'Error comercial: El descuento ingresado no puede superar el monto total de los productos.');
            }

            // Aplicar descuento de forma segura
            $montoTotal -= $descuento;

            $idVenta = DB::table('ventas')
                ->insertGetId([
                    'id_usuario' => Auth::id(),
                    'fecha_venta' => now()->format('Y-m-d H:i:s'), 
                    'monto_total' => $montoTotal,
                    'id_metodo_pago' => $request->metodo_pago,
                    'descuento' => $descuento,
                    'id_cliente' => $request->metodo_pago == 3 ? $request->id_cliente : null,
                ]);

            foreach ($request->productos as $producto) {
                DB::table('ventas_productos')->insert([
                    'id_venta' => $idVenta,
                    'id_producto' => $producto['id_producto'],
                    'cantidad' => $producto['cantidad'],
                    'precio' => $producto['precio']
                ]);

                DB::table('productos')
                    ->where('id_producto', $producto['id_producto'])
                    ->decrement('stock', $producto['cantidad']);
            }

            DB::commit();

            return redirect()->route('views.ventas')
                ->with('success', 'Venta guardada con éxito')
                ->with('nueva_venta_id', $idVenta);

        } catch (\Exception $e) {
            DB::rollBack();
            return redirect()->back()->with('error', 'No se pudo guardar la venta. Inténtalo nuevamente.');
        }
    }
}