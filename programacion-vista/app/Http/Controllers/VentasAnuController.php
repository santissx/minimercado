<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class VentasAnuController extends Controller
{
    // Muestra el historial de ventas anuladas
    public function index()
    {
        // Recuperamos todas las anulaciones de ventas
        $ventas = DB::table('ventas_anuladas')
            ->join('ventas', 'ventas_anuladas.id_venta', '=', 'ventas.id_venta')
            ->join('users', 'ventas_anuladas.id_usuario_anulador', '=', 'users.id')
            ->select('ventas_anuladas.id_venta_anulada', 'ventas_anuladas.id_venta', 'users.name as vendedor_name', 'ventas_anuladas.descripcion')
            ->get();
    
        // Verifica si $ventas tiene datos (opcional para depuración)
        // dd($ventas);
    
        // Retornamos la vista con los datos de las anulaciones
        return view('ventas_anu', compact('ventas'));  // Pasando la variable $ventas
    }
}