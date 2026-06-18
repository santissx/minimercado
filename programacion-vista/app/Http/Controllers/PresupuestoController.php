<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

class PresupuestoController extends Controller
{
    public function mostrar()
    {
        $productos = DB::table('productos')
            ->join('proveedores', 'productos.id_proveedor', '=', 'proveedores.id_proveedor')
            ->select('productos.*', 'proveedores.nombre as nombre_proveedor')
            ->where('productos.estado', 'activo')
            ->orderBy('productos.nombre', 'asc')
            ->get();

        $local = [
            'nombre'    => 'Soluciones Eléctricas',
            'telefono'  => '3705033180',
            'direccion' => 'AV. Cabral 586 - Formosa Capital',
            'facebook'  => 'Soluciones Eléctricas Fsa',
            'instagram' => '@solucioneselectricasfsa',
        ];

        return view('presupuesto', compact('productos', 'local'));
    }

    public function generar(Request $request)
    {
        $request->validate([
            'nombre_cliente' => 'nullable|string|max:255',
            'telefono_cliente' => 'nullable|string|max:255',
            'productos' => 'required|array|min:1',
        ]);

        DB::beginTransaction();

        try {
            $subtotal = 0;
            $descuento = $request->descuento ?? 0;

            // 1. Calculamos el subtotal leyendo precios reales por seguridad
            foreach ($request->productos as $id => $datos) {
                if (isset($datos['cantidad']) && $datos['cantidad'] > 0) {
                    $precio = DB::table('productos')->where('id_producto', $id)->value('precio_venta');
                    $subtotal += ($precio * $datos['cantidad']);
                }
            }

            $total = $subtotal - $descuento;

            // 2. Guardamos el registro principal en la tabla presupuestos
            $idPresupuesto = DB::table('presupuestos')->insertGetId([
                'id_usuario' => Auth::id(),
                'fecha' => now()->format('Y-m-d H:i:s'),
                'monto_total' => $total,
                'descuento' => $descuento,
                'nombre_cliente' => $request->nombre_cliente,
                'telefono_cliente' => $request->telefono_cliente,
                'estado' => 'pendiente',
            ]);

            // 3. Guardamos el detalle de los productos
            foreach ($request->productos as $id => $datos) {
                if (isset($datos['cantidad']) && $datos['cantidad'] > 0) {
                    $precio = DB::table('productos')->where('id_producto', $id)->value('precio_venta');
                    
                    DB::table('presupuestos_productos')->insert([
                        'id_presupuesto' => $idPresupuesto,
                        'id_producto' => $id,
                        'cantidad' => $datos['cantidad'],
                        'precio' => $precio,
                    ]);
                }
            }

            DB::commit();

            // Redirigimos con la ID del presupuesto recién creado para abrir el modal
            return redirect()->route('views.presupuesto')
                ->with('success', 'Presupuesto guardado con éxito')
                ->with('nuevo_presupuesto_id', $idPresupuesto);

        } catch (\Exception $e) {
            DB::rollBack();
            return redirect()->back()->with('error', 'Hubo un error al guardar el presupuesto: ' . $e->getMessage());
        }
    }

    // Nueva función exclusiva para imprimir presupuestos guardados
    public function imprimir($id)
    {
        $presupuesto = DB::table('presupuestos')->where('id_presupuesto', $id)->first();

        if (!$presupuesto) {
            return redirect()->back()->with('error', 'Presupuesto no encontrado.');
        }

        $productosDB = DB::table('presupuestos_productos')
            ->join('productos', 'presupuestos_productos.id_producto', '=', 'productos.id_producto')
            ->select('productos.nombre', 'productos.codigo', 'productos.codigo_barra', 'presupuestos_productos.cantidad', 'presupuestos_productos.precio')
            ->where('id_presupuesto', $id)
            ->get();

        // Formateamos los productos como los espera tu vista presupuesto_print.blade.php
        $productosFormateados = [];
        foreach ($productosDB as $p) {
            $productosFormateados[] = [
                'codigo'      => $p->codigo ?: $p->codigo_barra,
                'nombre'      => $p->nombre,
                'cantidad'    => $p->cantidad,
                'precio'      => $p->precio,
                'total_linea' => $p->cantidad * $p->precio,
            ];
        }

        $local = [
            'nombre'    => 'SOLUCIONES ELÉCTRICAS',
            'telefono'  => '3705033180',
            'direccion' => 'AV. Cabral 586 - Formosa Capital',
            'facebook'  => 'Soluciones Eléctricas Fsa',
            'instagram' => '@solucioneselectricasfsa',
        ];

        return view('presupuesto_print', [
            'local'            => $local,
            'fecha'            => \Carbon\Carbon::parse($presupuesto->fecha)->format('d/m/Y H:i'),
            'nombre_cliente'   => $presupuesto->nombre_cliente,
            'telefono_cliente' => $presupuesto->telefono_cliente,
            'productos'        => $productosFormateados,
            'subtotal'         => $presupuesto->monto_total + $presupuesto->descuento,
            'descuento'        => $presupuesto->descuento,
            'total'            => $presupuesto->monto_total,
        ]);
    }

    public function editar($id)
    {
        $presupuesto = DB::table('presupuestos')->where('id_presupuesto', $id)->first();
        if (!$presupuesto || $presupuesto->estado === 'convertido') {
            return redirect()->route('views.historial_presupuestos')->with('error', 'Este presupuesto no se puede editar.');
        }

        $productos = DB::table('productos')->where('estado', 'activo')->get();

        // Traemos los productos guardados en este presupuesto
        $productosSeleccionados = DB::table('presupuestos_productos')
            ->join('productos', 'presupuestos_productos.id_producto', '=', 'productos.id_producto')
            ->select('productos.id_producto', 'productos.nombre', 'productos.codigo', 'productos.codigo_barra', 'presupuestos_productos.cantidad', 'presupuestos_productos.precio as precio_guardado')
            ->where('id_presupuesto', $id)
            ->get();

        return view('presupuesto_editar', compact('presupuesto', 'productos', 'productosSeleccionados'));
    }

    public function actualizar(Request $request, $id)
    {
        $request->validate([
            'productos' => 'required|array|min:1',
        ]);

        DB::beginTransaction();
        try {
            $subtotal = 0;
            $descuento = $request->descuento ?? 0;

            // Borramos los productos viejos y cargamos los nuevos que mandó el formulario
            DB::table('presupuestos_productos')->where('id_presupuesto', $id)->delete();

            foreach ($request->productos as $prodId => $datos) {
                if (isset($datos['cantidad']) && $datos['cantidad'] > 0) {
                    $precioActual = DB::table('productos')->where('id_producto', $prodId)->value('precio_venta');
                    
                    DB::table('presupuestos_productos')->insert([
                        'id_presupuesto' => $id,
                        'id_producto' => $prodId,
                        'cantidad' => $datos['cantidad'],
                        'precio' => $precioActual,
                    ]);
                    
                    $subtotal += ($precioActual * $datos['cantidad']);
                }
            }

            $total = max(0, $subtotal - $descuento);

            DB::table('presupuestos')->where('id_presupuesto', $id)->update([
                'monto_total' => $total,
                'descuento' => $descuento,
                'nombre_cliente' => $request->nombre_cliente,
                'telefono_cliente' => $request->telefono_cliente,
                'fecha' => now()->format('Y-m-d H:i:s'), 
            ]);

            DB::commit();
            return redirect()->route('views.historial_presupuestos')->with('success', 'Presupuesto modificado con éxito.');

        } catch (\Exception $e) {
            DB::rollBack();
            return redirect()->back()->with('error', 'Hubo un error al modificar: ' . $e->getMessage());
        }
    }
}