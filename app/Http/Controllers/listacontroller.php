<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\Promocion;



class listacontroller extends Controller
{
    public function mostrar()
    {
        $productos = DB::table('productos')->get();
    
        return view('lista',['productos' => $productos]);
    }
    public function agregar(Request $request)
    {
        // Validación de datos
        $request->validate([
            'nombre' => 'required|string|max:255',
            'codigo' => 'nullable|string|max:255',
            'codigo_barra' => 'required|string|max:255',
            'precio' => 'required|numeric||regex:/^\d{1,10}(\.\d{0,2})?$/',
            'id_proveedor' => 'required|int|min:1',
            'stock' => 'required|int',
        ]);

        DB::table('productos')->insert([
            'nombre' => $request->input('nombre'),
            'codigo' => $request->input('codigo'),
            'codigo_barra' => $request->input('codigo_barra'),
            'precio' => $request->input('precio'),
            'id_proveedor' => $request->input('id_proveedor'),
            'stock' => $request->input('stock'),

        ]);

          // Redirigir a la vista de promociones (quizás con un mensaje de éxito)
          return redirect()->route('views.lista')->with('success', 'Promoción agregada correctamente.');

    }
    public function modificar(Request $request)
    {

       
        // Validación de datos
        $request->validate([
            'id_producto' => 'required|exists:productos,id_producto|int', // Asegúrate de que el id exista
            'nombre' => 'required|string|max:255',
            'codigo' => 'nullable|string|max:255',
            'codigo_barra' => 'required|string|max:255',
            'precio' => 'required|numeric||regex:/^\d{1,10}(\.\d{0,2})?$/',
            'id_proveedor' => 'required|int|min:1',
            'stock' => 'required|int',
        ]);

        DB::table('productos')
        ->where('id_producto', $request->input('id_producto'))
        ->update([
            'nombre' => 'required|string|max:255',
            'codigo' => 'nullable|string|max:255',
            'codigo_barra' => 'required|string|max:255',
            'precio' => 'required|numeric||regex:/^\d{1,10}(\.\d{0,2})?$/',
            'id_proveedor' => 'required|int|min:1',
            'stock' => 'required|int',
        ]);
          return redirect()->route('views.lista')->with('success', 'Producto modificada correctamente.');

    }

    public function borrar($id_producto)
    {
     
        DB::table('productos')
        ->where('id_producto', $id_producto)
        ->delete();
        return redirect()->route('views.lista')->with('success', 'Producto eliminado correctamente.');

    }
}
