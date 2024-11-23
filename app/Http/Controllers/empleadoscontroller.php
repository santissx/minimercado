<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;


use Illuminate\Support\Facades\DB;

class empleadoscontroller extends Controller
{
    public function mostrar()
    {


        $users = DB::table('users')->get();
    
        return view('empleados',['users' => $users]);
    }


    public function agregar(Request $request)
{
    // Validación de los datos recibidos
    $request->validate([
        'name' => 'required|string|max:255',
        'email' => 'required|string|email|max:255|unique:users,email',
        'password' => 'required|string|confirmed|min:8', 
        'rol' => 'required|in:administrador,empleado',
    ]);

    \DB::table('users')->insert([
        'name' => $request->input('name'),
        'email' => $request->input('email'),
        'password' => bcrypt($request->input('password')),  // Usar bcrypt para encriptar la contraseña
        'rol' => $request->input('rol'),
    ]);

    // Redirigir con un mensaje de éxito
    return redirect()->route('views.empleados')->with('success', 'Usuario agregado correctamente.');
}

    public function modificar(Request $request)
    {

       
        // Validación de datos
        $request->validate([
            'id' => 'required|exists:users,id|int',
            'name' => 'required|string|max:255', 
            'email' => 'required|string|email|max:255|unique:users,email,' . $request->input('id'), 
            'rol' => 'required|in:administrador,empleado', 
        ]);

        DB::table('users')
        ->where('id', $request->input('id'))
        ->update([
          
            'name' => $request->input('name'),
            'email' => $request->input('email'),
            'rol' => $request->input('rol'),

        ]);
          return redirect()->route('views.empleados')->with('success', 'Empleado modificado correctamente.');

    }
    public function borrar($id)
    {
     
        DB::table('users')
        ->where('id', $id)
    ->delete();
        return redirect()->route('views.empleados')->with('success', 'Empleado eliminado correctamente.');

    }
}
