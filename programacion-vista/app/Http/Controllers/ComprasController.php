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

    // Calcular el total de compras
    $totalcompras = DB::table('compras')
    ->sum('monto_compra');

    // Pasar los datos a la vista
    return view('compras', [
        'compras' => $comprasAgrupadas,
        'proveedores' => $proveedores,
        'totalcompras' => $totalcompras,
    ]);

    }
    public function getProductosPorProveedor($id)
{
    // Obtener productos del proveedor seleccionado
    $productos = DB::table('productos')
        ->where('id_proveedor', $id)
        ->get();

    return response()->json($productos);
}
public function agregar(Request $request)
{
    // Validar los datos
    $validated = $request->validate([
        'id_proveedor' => 'required|exists:proveedores,id_proveedor',
        'monto' => 'required|numeric||regex:/^\d{1,10}(\.\d{0,2})?$/',
        'productos' => 'required|array',
        'productos.*.id_producto' => 'required|exists:productos,id_producto',
        'productos.*.cantidad' => 'required|integer|min:1',
    ]);

    //crear la compra y guardar el id que se genero
    $id_compra = \DB::table('compras')->insertGetId([
        'monto_compra' => $validated['monto'],
        'fecha' => now(),
        'id_proveedor' => $validated['id_proveedor'],
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
    // Eliminar los registros relacionados en productosxcompras
    DB::table('productosxcompras')->where('id_compra', $id_compra)->delete();

    // Eliminar la compra
    DB::table('compras')->where('id_compra', $id_compra)->delete();

    // Redirigir con un mensaje de éxito
    return redirect()->route('views.compras')->with('success', 'Compra eliminada correctamente.');
}
}
