<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class VentasAnuController extends Controller
{
    // Muestra el historial de ventas anuladas
    public function index(Request $request)
    {

        $fechaInicio = $request->input('fechainicio');
        $fechaFin = $request->input('fechafin');


        $query = DB::table('ventas_anuladas')
            ->join('ventas', 'ventas_anuladas.id_venta', '=', 'ventas.id_venta')
            ->join('users', 'ventas_anuladas.id_usuario_anulador', '=', 'users.id')
            ->select('ventas_anuladas.id_venta_anulada', 'ventas_anuladas.id_venta', 'users.name as vendedor_name', 'ventas_anuladas.descripcion', 'ventas_anuladas.fecha_anu' );
            if ($fechaInicio || $fechaFin) {
            if (!$fechaFin) {
                $fechaFin = now(); // Asignar la fecha actual si fechaFin es null
            }
            $query->whereBetween('ventas_anuladas.fecha_anu', [$fechaInicio, $fechaFin]);
        }
            $ventas = $query->get();
    

        return view('ventas_anu', compact('ventas'));  
    }
}