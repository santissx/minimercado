<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use Illuminate\Support\Facades\DB;


class gastoscontroller extends Controller
{
    public function mostrar()
    {
        $gastos = DB::table('gastos')->get();
    
        return view('gastos',['gastos' => $gastos]);
    }


    public function agregar(Request $request)
    {
        // Validación de datos
        $request->validate([
            'descripcion' => 'required|string|max:255',
            'monto' => 'required|numeric||regex:/^\d{1,10}(\.\d{0,2})?$/',
            'categoria' => 'required|in:administrativo,logistico,cotidiano,deudas',
            'id_proveedor' => 'required|int|min:0',
            'id_usuario' => 'required|int|min:0',
        ]);

        DB::table('gastos')->insert([
            'descripcion' => $request->input('descripcion'),
            'monto' => $request->input('monto'),
            'categoria' => $request->input('categoria'),
            'id_proveedor' => $request->input('id_proveedor'),
            'id_usuario' => $request->input('id_usuario'),
        ]);

          // Redirigir a la vista de promociones (quizás con un mensaje de éxito)
          return redirect()->route('views.gastos')->with('success', 'Gasto agregado correctamente.');

    }
    public function modificar(Request $request)
    {

       
        // Validación de datos
        $request->validate([
            'id_gasto' => 'required|exists:gastos,id_gasto|int', // Asegúrate de que el id exista
            'descripcion' => 'required|string|max:255',
            'monto' => 'required|numeric||regex:/^\d{1,10}(\.\d{0,2})?$/',
            'categoria' => 'required|in:administrativo,logistico,cotidiano,deudas',
            'id_proveedor' => 'required|int|min:0',
            'id_usuario' => 'required|int|min:0',
        ]);

        DB::table('gastos')
        ->where('id_gasto', $request->input('id_gasto'))
        ->update([
          
            'descripcion' => $request->input('descripcion'),
            'monto' => $request->input('monto'),
            'categoria' => $request->input('categoria'),
            'id_proveedor' => $request->input('id_proveedor'),
            'id_usuario' => $request->input('id_usuario'),

        ]);
          return redirect()->route('views.gastos')->with('success', 'Promoción modificada correctamente.');

    }
    public function borrar($id_gasto)
    {
     
        DB::table('gastos')
        ->where('id_gasto', $id_gasto)
    ->delete();
        return redirect()->route('views.gastos')->with('success', 'Gasto eliminado correctamente.');

    }

}