<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class proveedorescontroller extends Controller
{
    public function mostrar()
    {
        $proveedores = DB::table('proveedores')->get();
    
        return view('proveedores',['proveedores' => $proveedores]);
    }


    public function agregar(Request $request)
    {
        // Validación de datos
        $request->validate([
            'nombre' => 'required|string|max:255',
            'telefono' => 'nullable|int',
            'direccion' => 'required|string|max:255',
            'email' => 'required|string|max:255',
            'nom_preventista' => 'required|string|max:255',
            'num_preventista' => 'required|int|max:15',
        ]);

        DB::table('proveedores')->insert([
            'nombre' => $request->input('nombre'),
            'telefono' => $request->input('telefono'),
            'direccion' => $request->input('direccion'),
            'email' => $request->input('email'),
            'nombre_preventista' => $request->input('nombre_preventista'),
            'num_preventista' => $request->input('num_preventista'),
        ]);

          // Redirigir a la vista de promociones (quizás con un mensaje de éxito)
          return redirect()->route('views.proveedores')->with('success', 'Proveedor agregada correctamente.');

    }
    public function modificar(Request $request)
    {

       
        // Validación de datos
        $request->validate([
            'id_proveedor' => 'required|exists:proveedores,id_proveedor|int', // Asegúrate de que el id exista
            'nombre' => 'required|string|max:255',
            'telefono' => 'nullable|int',
            'direccion' => 'required|string|max:255',
            'email' => 'required|string|max:255',
            'nom_preventista' => 'required|string|max:255',
            'num_preventista' => 'required|int|max:15',
        ]);

        DB::table('proveedores')
        ->where('id_proveedor', $request->input('id_proveedor'))
        ->update([
            'nombre' => $request->input('nombre'),
            'telefono' => $request->input('telefono'),
            'direccion' => $request->input('direccion'),
            'email' => $request->input('email'),
            'nombre_preventista' => $request->input('nombre_preventista'),
            'num_preventista' => $request->input('num_preventista'),
        ]);
          return redirect()->route('views.proveedores')->with('success', 'Proveedor modificado correctamente.');

    }
    public function borrar($id_proveedor)
    {
     
        DB::table('proveedores')
        ->where('id_proveedor', $id_proveedor)
        ->delete();
        return redirect()->route('views.proveedores')->with('success', 'Proveedor eliminado correctamente.');

    }
}
