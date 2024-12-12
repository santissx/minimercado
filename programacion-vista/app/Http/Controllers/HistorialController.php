<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class HistorialController extends Controller
{
    public function mostrar(Request $request)
    {
        // Obtener parámetros de filtro
        $vendedorId = $request->input('vendedor');
        $fechaInicio = $request->input('fechainicio');
        $fechaFin = $request->input('fechafin');

        
    
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
                'clientes_corrientes.nombre_y_apellido as nombre_clientec'

            )
            ->whereNull('ventas_anuladas.id_venta'); // Excluir ventas anuladas
    
        // Aplicar filtros si existen
        if ($vendedorId) {
            $query->where('users.id', $vendedorId);
        }
    
        if ($fechaInicio || $fechaFin) {
            if (!$fechaFin) {
                $fechaFin = now(); // Asignar la fecha actual si fechaFin es null
            }
            $query->whereBetween('ventas.fecha_venta', [$fechaInicio, $fechaFin]);
        }
    
        // Obtener los resultados
        $ventas = $query->orderBy('ventas.fecha_venta', 'desc')->get();
    
        // Obtener lista de vendedores para el filtro
        $vendedores = DB::table('users')->select('id', 'name')->where('rol', 'empleado')->get();
    
        // Calcular el total de ventas
        $totalVentas = $ventas->sum('monto_total');

        // Retornar la vista con los datos
        return view('historial', [
            'ventas' => $ventas,
            'vendedores' => $vendedores,
            'totalVentas' => $totalVentas, 
        ]);
    }

   

    public function obtenerDetalleVenta($idVenta)
{
    // Obtener los productos asociados a la venta
    $productos = DB::table('ventas_productos')
        ->join('productos', 'ventas_productos.id_producto', '=', 'productos.id_producto')
        ->select(
            'productos.nombre as producto',
            'ventas_productos.cantidad',
            'ventas_productos.precio'
        )
        ->where('ventas_productos.id_venta', $idVenta)
        ->get();

    // Retornar los datos como JSON
    return response()->json($productos);
}

public function anularVenta(Request $request)
{
    $validated = $request->validate([
        'id_venta' => 'required|exists:ventas,id_venta',
        'id_usuario_anulador' => 'required|exists:users,id',
        'descripcion' => 'required|string|max:255',
    ]);

     // Obtener los productos asociados a la venta anulada
     $productos = DB::table('ventas_productos')
     ->join('productos', 'ventas_productos.id_producto', '=', 'productos.id_producto')
     ->select(
         'productos.id_producto',
         'ventas_productos.cantidad'
     )
     ->where('ventas_productos.id_venta', $validated['id_venta'])
     ->get();

 // Actualizar el stock de los productos
 foreach ($productos as $producto) {
     DB::table('productos')
         ->where('id_producto', $producto->id_producto)
         ->increment('stock', $producto->cantidad);
 }
    
    // Registrar la venta anulada
    DB::table('ventas_anuladas')->insert([
        'id_venta' => $validated['id_venta'],
        'id_usuario_anulador' => $validated['id_usuario_anulador'],
        'descripcion' => $validated['descripcion'],
    ]);

    // Retornar con mensaje de éxito
    return redirect()->back()->with('success', 'Venta anulada correctamente.');
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
            'clientes_corrientes.nombre_y_apellido as nombre_clientec'
        )
        ->where('ventas.id_venta', $idVenta)
        ->first();

    $productos = DB::table('ventas_productos')
        ->join('productos', 'ventas_productos.id_producto', '=', 'productos.id_producto')
        ->select(
            'productos.nombre as producto',
            'ventas_productos.cantidad',
            'ventas_productos.precio'
        )
        ->where('ventas_productos.id_venta', $idVenta)
        ->get();

        return view('ticket', compact('venta', 'productos'));
}
}