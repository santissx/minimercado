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
        ]);

        DB::table('promociones')->insert([
            'nombre' => $request->input('nombre'),
            'descripcion' => $request->input('descripcion'),
            'fecha_inicio' => $request->input('fecha_inicio'),
            'fecha_fin' => $request->input('fecha_fin'),
            'descuento' => $request->input('descuento'),

        ]);

          // Redirigir a la vista de promociones (quizás con un mensaje de éxito)
          return redirect()->route('views.promo')->with('success', 'Promoción agregada correctamente.');

    }
    public function modificar(Request $request)
    {

       
        // Validación de datos
        $request->validate([
            'modal_id_promocion' => 'required|exists:promociones,id_promocion|int', // Asegúrate de que el id exista
            'modal_nombre' => 'required|string|max:255',
            'modal_descripcion' => 'nullable|string|max:255',
            'modal_fecha_inicio' => 'required|date',
            'modal_fecha_fin' => 'required|date|after_or_equal:fecha_inicio',
            'modal_descuento' => 'required|numeric|min:0',
            'modal_estado' => 'required|int|in:0,1', // Asegúrate de que el estado sea un entero
        ]);

        DB::table('promociones')
        ->where('id_promocion', $request->input('modal_id_promocion'))
        ->update([
            'nombre' => $request->input('modal_nombre'),
            'descripcion' => $request->input('modal_descripcion'),
            'fecha_inicio' => $request->input('modal_fecha_inicio'),
            'fecha_fin' => $request->input('modal_fecha_fin'),
            'descuento' => $request->input('modal_descuento'),
            'estado' => $request->input('modal_estado'),
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

