<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class PromocionController extends Controller
{
    public function index()
    {
        // 1. Obtener promociones solo activas
        $promociones = DB::table('promociones')
            ->where('estado', 'activo')
            ->get();

        // 2. Adjuntar los productos correspondientes a cada promoción
        foreach ($promociones as $promo) {
            $promo->productos = DB::table('promocion_productos as pp')
                ->join('productos as p', 'pp.id_producto', '=', 'p.id_producto')
                ->where('pp.id_promocion', $promo->id_promocion)
                ->select('p.id_producto', 'p.nombre', 'p.precio_venta', 'pp.cantidad')
                ->get();
        }

        // 3. Obtener productos activos para los buscadores (Crear/Editar)
        $productos = DB::table('productos')
            ->where('estado', 'activo')
            ->get();

        return view('promociones', compact('promociones', 'productos'));
    }

    public function store(Request $request)
    {
        $request->validate([
            'nombre' => 'required|string|max:255',
            'precio' => 'required|numeric|min:0',
            'productos' => 'required|array|min:1',
            'productos.*.id_producto' => 'required|integer',
            'productos.*.cantidad' => 'required|integer|min:1',
        ]);

        DB::beginTransaction();
        try {
            $id_promocion = DB::table('promociones')->insertGetId([
                'nombre' => $request->nombre,
                'precio' => $request->precio,
                'estado' => 'activo'
            ]);

            foreach ($request->productos as $item) {
                DB::table('promocion_productos')->insert([
                    'id_promocion' => $id_promocion,
                    'id_producto'  => $item['id_producto'],
                    'cantidad'     => $item['cantidad']
                ]);
            }

            DB::commit();
            return redirect()->back()->with('success', 'Promoción creada con éxito.');
        } catch (\Exception $e) {
            DB::rollBack();
            return redirect()->back()->with('error', 'Error al crear la promoción: ' . $e->getMessage());
        }
    }

    public function update(Request $request, $id)
    {
        $request->validate([
            'nombre' => 'required|string|max:255',
            'precio' => 'required|numeric|min:0',
            'productos' => 'required|array|min:1',
            'productos.*.id_producto' => 'required|integer',
            'productos.*.cantidad' => 'required|integer|min:1',
        ]);

        DB::beginTransaction();
        try {
            // Actualizar datos de la cabecera
            DB::table('promociones')
                ->where('id_promocion', $id)
                ->update([
                    'nombre' => $request->nombre,
                    'precio' => $request->precio,
                ]);

            // Eliminar detalle de productos anterior y reinsertar los nuevos
            DB::table('promocion_productos')
                ->where('id_promocion', $id)
                ->delete();

            foreach ($request->productos as $item) {
                DB::table('promocion_productos')->insert([
                    'id_promocion' => $id,
                    'id_producto'  => $item['id_producto'],
                    'cantidad'     => $item['cantidad']
                ]);
            }

            DB::commit();
            return redirect()->back()->with('success', 'Promoción actualizada con éxito.');
        } catch (\Exception $e) {
            DB::rollBack();
            return redirect()->back()->with('error', 'Error al actualizar la promoción: ' . $e->getMessage());
        }
    }

    public function destroy($id)
    {
        // Borrado Lógico: Cambia estado a 'inactivo' para preservar auditorías
        DB::table('promociones')
            ->where('id_promocion', $id)
            ->update(['estado' => 'inactivo']);

        return redirect()->back()->with('success', 'Promoción desactivada.');
    }
}