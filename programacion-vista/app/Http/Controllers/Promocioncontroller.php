<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;



class PromocionController extends Controller
{
    public function mostrar()
    {
        $promociones = DB::table('promociones')->get();
    
        return view('promociones',['promociones' => $promociones]);
    }


    public function agregar(Request $request)
    {
        // Validación de datos
        $request->validate([
            'nombre' => 'required|string|max:255',
            'descripcion' => 'nullable|string|max:255',
            'fecha_inicio' => 'required|date',
            'fecha_fin' => 'required|date|after_or_equal:fecha_inicio',
            'descuento' => 'required|numeric|min:0',
            'tipo_descuento' => 'required|in:porcentaje,monto',
        ]);

        DB::table('promociones')->insert([
            'nombre' => $request->input('nombre'),
            'descripcion' => $request->input('descripcion'),
            'fecha_inicio' => $request->input('fecha_inicio'),
            'fecha_fin' => $request->input('fecha_fin'),
            'descuento' => $request->input('descuento'),
            'tipo_descuento' => $request->input('tipo_descuento'),

        ]);

          // Redirigir a la vista de promociones (quizás con un mensaje de éxito)
          return redirect()->route('views.promo')->with('success', 'Promoción agregada correctamente.');

    }
    public function modificar(Request $request)
    {

       
        // Validación de datos
        $request->validate([
            'id_promocion' => 'required|exists:promociones,id_promocion|int', // Asegúrate de que el id exista
            'nombre' => 'required|string|max:255',
            'descripcion' => 'nullable|string|max:255',
            'fecha_inicio' => 'required|date',
            'fecha_fin' => 'required|date|after_or_equal:fecha_inicio',
            'descuento' => 'required|numeric|min:0',
            'estado' => 'required|int|in:0,1', // Asegúrate de que el estado sea un entero
            'tipo_descuento' => 'required|in:porcentaje,monto', // Puede ser 'porcentaje' o 'monto'
        ]);

        DB::table('promociones')
        ->where('id_promocion', $request->input('id_promocion'))
        ->update([
            'nombre' => $request->input('nombre'),
            'descripcion' => $request->input('descripcion'),
            'fecha_inicio' => $request->input('fecha_inicio'),
            'fecha_fin' => $request->input('fecha_fin'),
            'descuento' => $request->input('descuento'),
            'estado' => $request->input('estado'),
            'tipo_descuento' => $request->input('tipo_descuento'),
        ]);
          return redirect()->route('views.promo')->with('success', 'Promoción modificada correctamente.');

    }
    public function borrar($id_promocion)
    {
     
        DB::table('promociones')
        ->where('id_promocion', $id_promocion)
        ->delete();
        return redirect()->route('views.promo')->with('success', 'Promoción eliminada correctamente.');

    }

}

