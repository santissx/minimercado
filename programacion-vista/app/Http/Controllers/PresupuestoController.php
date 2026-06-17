<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class PresupuestoController extends Controller
{
    public function mostrar()
    {
        $productos = DB::table('productos')
            ->join('proveedores', 'productos.id_proveedor', '=', 'proveedores.id_proveedor')
            ->select('productos.*', 'proveedores.nombre as nombre_proveedor')
            ->where('productos.estado', 'activo')
            ->orderBy('productos.nombre', 'asc')
            ->get();

        $local = [
            'nombre'    => 'Soluciones Eléctricas',
            'telefono'  => '3705033180',
            'direccion' => 'AV. Cabral 586 - Formosa Capital',
            'facebook'  => 'Soluciones Eléctricas Fsa',
            'instagram' => '@solucioneselectricasfsa',
        ];

        return view('presupuesto', compact('productos', 'local'));
    }

    public function generar(Request $request)
    {
        $request->validate([
            'nombre_cliente' => 'nullable|string|max:255',
            'telefono_cliente' => 'nullable|string|max:255',
            'productos' => 'required|array|min:1',
        ]);

        $productosSeleccionados = [];
        $subtotal = 0;

        foreach ($request->productos as $id => $datos) {
            if (isset($datos['cantidad']) && $datos['cantidad'] > 0) {
                $producto = DB::table('productos')
                    ->where('id_producto', $id)
                    ->first();

                if ($producto) {
                    $total_linea = $producto->precio_venta * $datos['cantidad'];
                    $subtotal += $total_linea;

                    $productosSeleccionados[] = [
                        'codigo'      => $producto->codigo ?: $producto->codigo_barra,
                        'nombre'      => $producto->nombre,
                        'cantidad'    => $datos['cantidad'],
                        'precio'      => $producto->precio_venta,
                        'total_linea' => $total_linea,
                    ];
                }
            }
        }

        $descuento = $request->descuento ?? 0;
        $total = $subtotal - $descuento;

        $local = [
            'nombre'    => 'Soluciones Eléctricas',
            'telefono'  => '3705033180',
            'direccion' => 'AV. Cabral 586 - Formosa Capital',
            'facebook'  => 'Soluciones Eléctricas Fsa',
            'instagram' => '@solucioneselectricasfsa',
        ];

        $datos = [
            'local'              => $local,
            'nombre_cliente'     => $request->nombre_cliente,
            'telefono_cliente'   => $request->telefono_cliente,
            'productos'          => $productosSeleccionados,
            'subtotal'           => $subtotal,
            'descuento'          => $descuento,
            'total'              => $total,
            'fecha'              => now()->format('d/m/Y H:i'),
        ];

        return view('presupuesto_print', $datos);
    }
}
