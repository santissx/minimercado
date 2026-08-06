<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ComprasController extends Controller
{
    public function mostrar(Request $request)
    {

        $proveedorId = $request->input('proveedor');
        $fechaInicio = $request->input('fechainicio');
        $fechaFin = $request->input('fechafin');

        if ($fechaInicio) {
            $fechaInicio = date('Y-m-d 00:00:00', strtotime($fechaInicio)); // Desde la medianoche
        }
        if ($fechaFin) {
            $fechaFin = date('Y-m-d 23:59:59', strtotime($fechaFin)); // Hasta el final del día
        }

        // Obtener las compras con sus productos asociados y sus proveedores
        $query = DB::table('compras')
            ->leftJoin('productosxcompras', 'compras.id_compra', '=', 'productosxcompras.id_compra')
            ->leftJoin('productos', 'productosxcompras.id_producto', '=', 'productos.id_producto')
            ->leftJoin('proveedores', 'productos.id_proveedor', '=', 'proveedores.id_proveedor')
            ->select(
                'compras.id_compra',
                'compras.monto_compra',
                'compras.fecha',
                'productos.nombre as producto',
                'productosxcompras.cantidad_agregada',
                'proveedores.id_proveedor as id_proveedor',
                'proveedores.nombre as proveedor'
            );
           
            if ($proveedorId) {
                $query->where('proveedores.id_proveedor', $proveedorId);
            }

            if ($fechaInicio && $fechaFin) {
                $query->whereBetween('compras.fecha', [$fechaInicio, $fechaFin]);
            } elseif ($fechaInicio) {
                $query->where('compras.fecha', '>=', $fechaInicio);
            } elseif ($fechaFin) {
                $query->where('compras.fecha', '<=', $fechaFin);
            }
            $compras = $query->get();
    // Agrupar los productos por compra
    $comprasAgrupadas = $compras->groupBy('id_compra');

    // Obtener la lista de proveedores
    $proveedores = DB::table('proveedores')->get();

    // Obtener todos los productos con nombre de su proveedor para el modal
    $todosLosProductos = DB::table('productos')
        ->leftJoin('proveedores', 'productos.id_proveedor', '=', 'proveedores.id_proveedor')
        ->select('productos.*', 'proveedores.nombre as proveedor_nombre')
        ->orderBy('productos.nombre', 'asc')
        ->get();

    // Calcular el total de compras
    $totalcompras = DB::table('compras')
    ->sum('monto_compra');

    // Pasar los datos a la vista
    return view('compras', [
        'compras' => $comprasAgrupadas,
        'proveedores' => $proveedores,
        'todosLosProductos' => $todosLosProductos,
        'totalcompras' => $totalcompras,
    ]);

    }

    public function getProductosPorProveedor($id)
    {
        $query = DB::table('productos')
            ->leftJoin('proveedores', 'productos.id_proveedor', '=', 'proveedores.id_proveedor')
            ->select('productos.*', 'proveedores.nombre as proveedor_nombre');

        if ($id && $id !== 'todos' && $id !== '0') {
            $query->where('productos.id_proveedor', $id);
        }

        $productos = $query->orderBy('productos.nombre', 'asc')->get();

        return response()->json($productos);
    }

    public function agregar(Request $request)
    {
        // Validar los datos
        $validated = $request->validate([
            'id_proveedor' => 'nullable',
            'monto' => 'required|numeric|regex:/^\d{1,10}(\.\d{0,2})?$/',
            'productos' => 'required|array',
            'productos.*.id_producto' => 'required|exists:productos,id_producto',
            'productos.*.cantidad' => 'required|integer|min:1',
        ]);

        $id_proveedor = $request->input('id_proveedor');
        if ($id_proveedor === 'todos' || empty($id_proveedor)) {
            $id_proveedor = null;
        }

        // Si id_proveedor es nulo, verificar si todos los productos pertenecen a un mismo proveedor
        if (!$id_proveedor && !empty($validated['productos'])) {
            $productIds = array_column($validated['productos'], 'id_producto');
            $proveedoresIds = DB::table('productos')
                ->whereIn('id_producto', $productIds)
                ->pluck('id_proveedor')
                ->unique();
            if ($proveedoresIds->count() === 1) {
                $id_proveedor = $proveedoresIds->first();
            }
        }

        // Crear la compra y guardar el id que se genero
        $id_compra = DB::table('compras')->insertGetId([
            'monto_compra' => $validated['monto'],
            'fecha' => now(),
            'id_proveedor' => $id_proveedor,
        ]);

        // Guardar los productos según el id_compra obtenido
        foreach ($validated['productos'] as $producto) {
            DB::table('productosxcompras')->insert([
                'id_compra' => $id_compra,
                'id_producto' => $producto['id_producto'],
                'cantidad_agregada' => $producto['cantidad'],
            ]);

            // Actualizar el stock del producto
            DB::table('productos')
                ->where('id_producto', $producto['id_producto'])
                ->increment('stock', $producto['cantidad']);
        }
        // Redirigir a la lista de compras con un mensaje de éxito
        return redirect()->route('views.compras')->with('success', 'Compra agregada correctamente.');
    }

public function eliminar($id_compra)
    {
        DB::beginTransaction();

        try {
            // 1. Obtener los productos de esta compra ANTES de borrarlos
            $productosCompra = DB::table('productosxcompras')
                ->where('id_compra', $id_compra)
                ->get();

            // 2. Restar la cantidad agregada del stock actual de cada producto
            foreach ($productosCompra as $item) {
                DB::table('productos')
                    ->where('id_producto', $item->id_producto)
                    ->decrement('stock', $item->cantidad_agregada);
            }

            // 3. Eliminar los registros relacionados en la tabla intermedia
            DB::table('productosxcompras')->where('id_compra', $id_compra)->delete();

            // 4. Eliminar la compra de la tabla principal
            DB::table('compras')->where('id_compra', $id_compra)->delete();

            DB::commit();

            return redirect()->route('views.compras')->with('success', 'Compra eliminada y stock revertido correctamente.');

        } catch (\Exception $e) {
            DB::rollBack();
            return redirect()->route('views.compras')->with('error', 'Hubo un error al eliminar la compra: ' . $e->getMessage());
        }
    }
}
