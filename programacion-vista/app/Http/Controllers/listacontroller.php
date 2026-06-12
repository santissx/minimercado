<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class listacontroller extends Controller
{
    public function mostrar(Request $request)
    {
        $search = $request->input('search');
        $sort   = $request->input('sort'); // ✨ Nuevo: Captura el orden deseado

        $query = DB::table('productos')
            ->join('categorias', 'productos.id_categoria', '=', 'categorias.id_categoria')
            ->join('proveedores', 'productos.id_proveedor', '=', 'proveedores.id_proveedor')
            ->select('productos.*', 'categorias.categoria as categoria', 'proveedores.nombre as nombre_proveedor');

        // Filtro de búsqueda por texto/código
        if ($search) {
            $query->where(function($q) use ($search) {
                $q->where('productos.nombre', 'LIKE', "%{$search}%")
                  ->orWhere('productos.codigo', 'LIKE', "%{$search}%")
                  ->orWhere('productos.codigo_barra', 'LIKE', "%{$search}%");
            });
        }

        // ✨ Nuevo: Ordenar por stock si el usuario lo solicita
        if ($sort === 'stock_asc') {
            $query->orderBy('productos.stock', 'asc');
        } elseif ($sort === 'stock_desc') {
            $query->orderBy('productos.stock', 'desc');
        }

        $productos = $query->get();

        $proveedores = DB::table('proveedores')
            ->where('estado', 'activo')
            ->get();

        $categorias = DB::table('categorias')->get();

        return view('lista', [
            'productos'   => $productos,
            'proveedores' => $proveedores,
            'categorias'  => $categorias,
            'search'      => $search,
            'sort'        => $sort, // ✨ Nuevo: Pasa el estado del orden a la vista
        ]);
    }   

    public function agregar(Request $request)
    {
        $request->validate([
            'nombre'       => 'required|string|max:255',
            'codigo'       => 'nullable|string|max:255',
            'codigo_barra' => 'required|string|max:255',
            'precio_lista' => 'required|numeric|regex:/^\d{1,10}(\.\d{0,2})?$/',
            'precio_venta' => 'required|numeric|regex:/^\d{1,10}(\.\d{0,2})?$/',
            'id_proveedor' => 'required|int|min:1',
            'id_categoria' => 'required|int|min:1',
            'stock'        => 'required|int',
        ]);

        DB::table('productos')->insert([
            'nombre'       => $request->input('nombre'),
            'codigo'       => $request->input('codigo'),
            'codigo_barra' => $request->input('codigo_barra'),
            'precio_lista' => $request->input('precio_lista'),
            'precio_venta' => $request->input('precio_venta'),
            'id_proveedor' => $request->input('id_proveedor'),
            'id_categoria' => $request->input('id_categoria'),
            'stock'        => $request->input('stock'),
        ]);

        return redirect()->route('views.lista')->with('success', 'Producto agregado correctamente.');
    }

    public function modificar(Request $request)
    {
        $request->validate([
            'id_producto'  => 'required|exists:productos,id_producto|int',
            'nombre'       => 'required|string|max:255',
            'codigo'       => 'nullable|string|max:255',
            'codigo_barra' => 'required|string|max:255',
            'precio_lista' => 'required|numeric|regex:/^\d{1,10}(\.\d{0,2})?$/',
            'precio_venta' => 'required|numeric|regex:/^\d{1,10}(\.\d{0,2})?$/',
            'id_proveedor' => 'required|int|min:1',
            'id_categoria' => 'required|int|min:1',
            'stock'        => 'required|int',
            'estado'       => 'nullable|string|max:255',
        ]);

        DB::table('productos')
            ->where('id_producto', $request->input('id_producto'))
            ->update([
                'nombre'       => $request->input('nombre'),
                'codigo'       => $request->input('codigo'),
                'codigo_barra' => $request->input('codigo_barra'),
                'precio_lista' => $request->input('precio_lista'),
                'precio_venta' => $request->input('precio_venta'),
                'id_proveedor' => $request->input('id_proveedor'),
                'id_categoria' => $request->input('id_categoria'),
                'stock'        => $request->input('stock'),
                'estado'       => $request->input('estado'),
            ]);

        return redirect()->route('views.lista')->with('success', 'Producto modificado correctamente.');
    }

    public function borrar($id_producto)
    {
        DB::table('productos')
            ->where('id_producto', $id_producto)
            ->update(['estado' => 'desactivado']);

        return redirect()->route('views.lista')->with('success', 'Producto Eliminado correctamente.');
    }

    public function aumentarPrecioPorProveedor(Request $request)
    {
        $validated = $request->validate([
            'id_proveedor' => 'required|exists:proveedores,id_proveedor',
            'porcentaje'   => 'required|numeric|min:0',
        ]);

        $porcentaje = $validated['porcentaje'];

        DB::table('productos')
            ->where('id_proveedor', $request->input('id_proveedor'))
            ->update(['precio_venta' => DB::raw('precio_venta * (1 + ' . ($porcentaje / 100) . ')')]);

        return redirect()->back()->with('success', 'Los precios se han actualizado correctamente.');
    }

    public function aumentarPreciolistaPorProveedor(Request $request)
    {
        $validated = $request->validate([
            'id_proveedor' => 'required|exists:proveedores,id_proveedor',
            'porcentaje'   => 'required|numeric|min:0',
        ]);

        $porcentaje = $validated['porcentaje'];

        DB::table('productos')
            ->where('id_proveedor', $request->input('id_proveedor'))
            ->update(['precio_lista' => DB::raw('precio_lista * (1 + ' . ($porcentaje / 100) . ')')]);

        return redirect()->back()->with('success', 'Los precios se han actualizado correctamente.');
    }
}