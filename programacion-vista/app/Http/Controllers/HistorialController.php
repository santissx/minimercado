<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class HistorialController extends Controller
{
    public function mostrar(Request $request)
    {
        // Construir la consulta base
        $query = DB::table('ventas')
            ->leftJoin('ventas_anuladas', 'ventas.id_venta', '=', 'ventas_anuladas.id_venta') // Unión para identificar anuladas
            ->join('users', 'ventas.id_usuario', '=', 'users.id')
            ->join('metodos_pago', 'ventas.id_metodo_pago', '=', 'metodos_pago.id_metodo_pago')
            ->leftJoin('clientes_corrientes', 'ventas.id_cliente', '=', 'clientes_corrientes.id_cliente')
            ->select(
                'ventas.id_venta',
                'users.id as vendedor_id',
                'users.name as vendedor_name',
                'ventas.monto_total',
                'ventas.descuento',
                'metodos_pago.nombre as metodo_pago',
                'ventas.fecha_venta',
                'clientes_corrientes.id_cliente as clientec',
                'clientes_corrientes.nombre_y_apellido as nombre_clientec',
                'clientes_corrientes.telefono as telefono_clientec', 
                'ventas.cliente_nombre',
                'ventas.cliente_telefono',
                'ventas.observaciones'
            )
            ->whereNull('ventas_anuladas.id_venta'); // Excluir ventas anuladas
    
        // 1. Filtro por Vendedor
        if ($request->filled('vendedor')) {
            $query->where('users.id', $request->input('vendedor'));
        }

        // 2. Filtro por Cliente (Funcionalidad Tuya)
        if ($request->filled('id_cliente')) {
            $query->where('ventas.id_cliente', $request->input('id_cliente'));
        }
    
        // 3. Filtro de Fechas adaptado para DATETIME (Tu lógica segura anti-errores)
        if ($request->filled('fechainicio') && $request->filled('fechafin')) {
            $query->whereBetween('ventas.fecha_venta', [
                $request->input('fechainicio') . ' 00:00:00', 
                $request->input('fechafin') . ' 23:59:59'
            ]);
        } elseif ($request->filled('fechainicio')) {
            $query->where('ventas.fecha_venta', '>=', $request->input('fechainicio') . ' 00:00:00');
        } elseif ($request->filled('fechafin')) {
            $query->where('ventas.fecha_venta', '<=', $request->input('fechafin') . ' 23:59:59');
        }
    
        // Obtener los resultados ordenados
        $ventas = $query->orderBy('ventas.fecha_venta', 'desc')->get();
    
        // Obtener listas para los menús desplegables (Trayendo a todos los estados activos sin discriminar administrador/empleado)
        $vendedores = DB::table('users')->select('id', 'name')->where('estado', 'activo')->get();
        $clientes = DB::table('clientes_corrientes')->where('estado', 'activo')->get(); 
    
        // Calcular el total de ventas filtradas
        $totalVentas = $ventas->sum('monto_total');

        // Retornar la vista con los datos unificados
        return view('historial', [
            'ventas' => $ventas,
            'vendedores' => $vendedores,
            'clientes' => $clientes, 
            'totalVentas' => $totalVentas, 
        ]);
    }

    public function obtenerDetalleVenta($idVenta)
    {
        $productos = DB::table('ventas_productos')
            ->join('productos', 'ventas_productos.id_producto', '=', 'productos.id_producto')
            ->select(
                'ventas_productos.id_venta_producto',
                'productos.id_producto',
                'productos.nombre as producto',
                'ventas_productos.cantidad',
                'ventas_productos.precio',
                'ventas_productos.precio_lista'
            )
            ->where('ventas_productos.id_venta', $idVenta)
            ->get();

        foreach ($productos as $p) {
            $anulado = DB::table('ventas_productos_anulados')
                ->where('id_venta_producto', $p->id_venta_producto)
                ->sum('cantidad_anulada');

            $p->cantidad_anulada = (int) $anulado; // Enviamos cuánto se anuló
            $p->cantidad_disponible = $p->cantidad - $anulado;

            if (isset($p->precio_lista) && $p->precio < $p->precio_lista) {
                $p->producto .= ' - Promo';
            }
        }

        return response()->json($productos);
    }

    public function anularVenta(Request $request)
    {
        $validated = $request->validate([
            'id_venta' => 'required|exists:ventas,id_venta',
            'descripcion' => 'required|string|max:255',
            'productos' => 'required|array|min:1',
            'productos.*.id_venta_producto' => 'required|integer',
            'productos.*.cantidad' => 'required|integer|min:1',
        ]);

        DB::beginTransaction();

        try {
            $venta = DB::table('ventas')
                ->where('id_venta', $validated['id_venta'])
                ->lockForUpdate()
                ->first();

            if (!$venta) {
                throw new \Exception('La venta no existe.');
            }

            $ventaAnulada = DB::table('ventas_anuladas')
                ->where('id_venta', $venta->id_venta)
                ->exists();

            if ($ventaAnulada) {
                throw new \Exception('Esta venta ya fue anulada completamente.');
            }

            $lineas = DB::table('ventas_productos')
                ->where('id_venta', $venta->id_venta)
                ->lockForUpdate()
                ->get();

            $subtotalOriginal = $lineas->sum(function ($item) {
                return $item->cantidad * $item->precio;
            });

            foreach ($validated['productos'] as $item) {

                $linea = $lineas->firstWhere(
                    'id_venta_producto',
                    $item['id_venta_producto']
                );

                if (!$linea) {
                    throw new \Exception('Uno de los productos no pertenece a esta venta.');
                }

                $cantidadAnuladaAnterior = DB::table('ventas_productos_anulados')
                    ->where('id_venta_producto', $linea->id_venta_producto)
                    ->sum('cantidad_anulada');

                $cantidadDisponible = $linea->cantidad - $cantidadAnuladaAnterior;

                if ($item['cantidad'] > $cantidadDisponible) {
                    throw new \Exception('La cantidad a anular supera las unidades disponibles.');
                }

                DB::table('ventas_productos_anulados')->insert([
                    'id_venta' => $venta->id_venta,
                    'id_venta_producto' => $linea->id_venta_producto,
                    'id_producto' => $linea->id_producto,
                    'id_usuario_anulador' => $request->user()->id,
                    'cantidad_anulada' => $item['cantidad'],
                    'precio_unitario' => $linea->precio,
                    'descripcion' => $validated['descripcion'],
                    'fecha_anulacion' => now(),
                ]);

                DB::table('productos')
                    ->where('id_producto', $linea->id_producto)
                    ->increment('stock', $item['cantidad']);
            }

            $cantidadRestante = 0;
            $subtotalRestante = 0;

            foreach ($lineas as $linea) {

                $anulada = DB::table('ventas_productos_anulados')
                    ->where('id_venta_producto', $linea->id_venta_producto)
                    ->sum('cantidad_anulada');

                $restante = $linea->cantidad - $anulada;

                $cantidadRestante += $restante;
                $subtotalRestante += $restante * $linea->precio;
            }

            $descuentoOriginal = (float) $venta->descuento;
            $descuentoRestante = $subtotalOriginal > 0
                ? round($descuentoOriginal * ($subtotalRestante / $subtotalOriginal), 2)
                : 0;

            $montoRestante = max(0, $subtotalRestante - $descuentoRestante);

            DB::table('ventas')
                ->where('id_venta', $venta->id_venta)
                ->update([
                    'monto_total' => $montoRestante,
                ]);

            if ($cantidadRestante === 0) {
                DB::table('ventas_anuladas')->insert([
                    'id_venta' => $venta->id_venta,
                    'id_usuario_anulador' => $request->user()->id,
                    'descripcion' => $validated['descripcion'],
                ]);
            }

            DB::commit();

            return redirect()->back()->with(
                'success',
                'Anulación realizada correctamente.'
            );

        } catch (\Exception $e) {

            DB::rollBack();

            return redirect()->back()->with(
                'error',
                'No se pudo realizar la anulación: ' . $e->getMessage()
            );
        }
    }

    public function generarTicket($idVenta)
    {
        $venta = DB::table('ventas')
            ->join('users', 'ventas.id_usuario', '=', 'users.id')
            ->join('metodos_pago', 'ventas.id_metodo_pago', '=', 'metodos_pago.id_metodo_pago')
            ->leftJoin('clientes_corrientes', 'ventas.id_cliente', '=', 'clientes_corrientes.id_cliente')
            ->select(
                'ventas.id_venta',
                'users.name as vendedor_name',
                'ventas.monto_total',
                'ventas.descuento',
                'metodos_pago.nombre as metodo_pago',
                'ventas.fecha_venta',
                'clientes_corrientes.id_cliente as clientec',
                'clientes_corrientes.nombre_y_apellido as nombre_clientec',
                'clientes_corrientes.telefono as telefono_clientec', 
                'ventas.cliente_nombre',
                'ventas.cliente_telefono'
            )
            ->where('ventas.id_venta', $idVenta)
            ->first();

        // Agregamos id_venta_producto al select
        $productos = DB::table('ventas_productos')
            ->join('productos', 'ventas_productos.id_producto', '=', 'productos.id_producto')
            ->leftJoin('categorias', 'productos.id_categoria', '=', 'categorias.id_categoria')
            ->select(
                'ventas_productos.id_venta_producto',
                'productos.nombre as producto',
                'productos.codigo',
                'productos.codigo_barra',
                'productos.id_categoria',
                'categorias.categoria as nombre_categoria',
                'ventas_productos.cantidad',
                'ventas_productos.precio',
                'ventas_productos.precio_lista'
            )
            ->where('ventas_productos.id_venta', $idVenta)
            ->get();

        foreach ($productos as $p) {
            $anulado = DB::table('ventas_productos_anulados')
                ->where('id_venta_producto', $p->id_venta_producto)
                ->sum('cantidad_anulada');

            // Calculamos la cantidad real que quedó después de las anulaciones
            $p->cantidad_final = $p->cantidad - $anulado;
            $p->cantidad_anulada = $anulado;

            if (isset($p->precio_lista) && $p->precio < $p->precio_lista) {
                $p->producto .= ' - Promo';
            }
        }

        $local = [
            'nombre'    => 'SOLUCIONES ELÉCTRICAS',
            'telefono'  => '3705033180',
            'direccion' => 'AV. Cabral 586 - Formosa Capital',
            'facebook'  => 'Soluciones Eléctricas Fsa',
            'instagram' => '@solucioneselectricasfsa',
        ];

        return view('ticket', compact('venta', 'productos', 'local'));
    }
}