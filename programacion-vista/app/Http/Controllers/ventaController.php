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

        // Obtener promociones activas con sus productos desglosados
        $promociones = DB::table('promociones')
            ->where('estado', 'activo')
            ->get();

        foreach ($promociones as $promo) {
            $promo->productos = DB::table('promocion_productos as pp')
                ->join('productos as p', 'pp.id_producto', '=', 'p.id_producto')
                ->where('pp.id_promocion', $promo->id_promocion)
                ->select('p.id_producto', 'p.nombre', 'p.codigo_barra', 'p.precio_venta', 'p.stock', 'pp.cantidad')
                ->get();
        }

        return view('welcome', ['metodosDePago' => $metodosDePago, 'promociones' => $promociones]);
    }

    public function obtenerClientesCorrientes()
    {
        $clientesCorrientes = DB::table('clientes_corrientes')
            ->select('id_cliente', 'nombre_y_apellido', 'dni')
            ->where('estado', 'activo')
            ->get();
         
        return response()->json($clientesCorrientes);
    }

    public function buscarProductos(Request $request)
    {
        $queryStr = $request->get('q');
    
        $consulta = DB::table('productos');

        if (!empty($queryStr)) {
            
            $palabras = array_filter(explode(' ', $queryStr));

            $consulta->where(function ($q) use ($palabras) {
                foreach ($palabras as $palabra) {
                    $q->where(function ($subQ) use ($palabra) {
                        $subQ->where('nombre', 'LIKE', '%' . $palabra . '%')
                             ->orWhere('codigo_barra', 'LIKE', '%' . $palabra . '%');
                    });
                }
            });
        }

        $productos = $consulta->take(30)->get();

        return response()->json($productos);
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
            'cliente_nombre' => 'nullable|string|max:255',
            'cliente_telefono' => 'nullable|string|max:50',
            'observaciones' => 'nullable|string|max:1000',
        ]);

        DB::beginTransaction();

        try {
            // 1. Agrupar la cantidad total requerida por cada id_producto (Normal + Promo)
            $cantidadesTotales = [];
            foreach ($request->productos as $producto) {
                $id = $producto['id_producto'];
                $cantidadesTotales[$id] = ($cantidadesTotales[$id] ?? 0) + $producto['cantidad'];
            }

            // 2. Validar que haya stock suficiente para el acumulado total
            foreach ($cantidadesTotales as $idProducto => $cantidadTotalRequerida) {
                $productoInfo = DB::table('productos')
                    ->where('id_producto', $idProducto)
                    ->first();

                if (!$productoInfo || $productoInfo->stock < $cantidadTotalRequerida) {
                    DB::rollBack();
                    return redirect()->back()->with('error', 'Stock insuficiente para el producto: ' . ($productoInfo ? $productoInfo->nombre : 'Desconocido') . " (Solicitado total: {$cantidadTotalRequerida}, Disponible: " . ($productoInfo->stock ?? 0) . ')');
                }
            }

            // 3. Calcular monto total sumando cada ítem enviado
            $montoTotal = 0;
            foreach ($request->productos as $producto) {
                $montoTotal += $producto['precio'] * $producto['cantidad'];
            }

            $descuento = $request->descuento ?? 0;

            if ($descuento > $montoTotal) {
                DB::rollBack();
                return redirect()->back()->with('error', 'Error comercial: El descuento ingresado no puede superar el monto total de los productos.');
            }

            $montoTotal -= $descuento;
            $esClienteCorriente = ($request->metodo_pago == 3);

            // 4. Crear la cabecera de la venta
            $idVenta = DB::table('ventas')
                ->insertGetId([
                    'id_usuario' => Auth::id(),
                    'fecha_venta' => now()->format('Y-m-d H:i:s'), 
                    'monto_total' => $montoTotal,
                    'id_metodo_pago' => $request->metodo_pago,
                    'descuento' => $descuento,
                    'id_cliente' => $esClienteCorriente ? $request->id_cliente : null,
                    'cliente_nombre' => !$esClienteCorriente ? $request->cliente_nombre : null,
                    'cliente_telefono' => !$esClienteCorriente ? $request->cliente_telefono : null,
                    'observaciones' => $request->observaciones,
                ]);

            // 5. Insertar cada línea de producto (guardará tanto la fila normal como las filas de promociones)
            foreach ($request->productos as $producto) {
                $precioListaDB = DB::table('productos')
                    ->where('id_producto', $producto['id_producto'])
                    ->value('precio_lista');
                
                DB::table('ventas_productos')->insert([
                    'id_venta' => $idVenta,
                    'id_producto' => $producto['id_producto'],
                    'cantidad' => $producto['cantidad'],
                    'precio' => $producto['precio'],
                    'precio_lista' => $precioListaDB ?? 0.00, 
                ]);

                // Descontar el stock de esta línea
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
            return redirect()->back()->with('error', 'No se pudo guardar la venta: ' . $e->getMessage());
        }
    }
}