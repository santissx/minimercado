<?php

namespace App\Exports;

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth; // Necesario para verificar el rol
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;

class StockExport implements FromCollection, WithHeadings
{
    public function collection()
    {
        // Verificamos si el usuario es administrador
        $esAdmin = Auth::user()->rol === 'administrador';

        // Armamos el arreglo de campos base
        $selectFields = [
            'productos.codigo',
            'productos.codigo_barra',
            'productos.nombre',
            'categorias.categoria as nombre_categoria',
            'proveedores.nombre as nombre_proveedor',
            'productos.stock',
        ];

        // Agregamos el precio de lista solo si es administrador
        if ($esAdmin) {
            $selectFields[] = 'productos.precio_lista';
        }

        // Siempre agregamos el precio de venta al final
        $selectFields[] = 'productos.precio_venta';

        return DB::table('productos')
            ->leftJoin('categorias', 'productos.id_categoria', '=', 'categorias.id_categoria')
            ->leftJoin('proveedores', 'productos.id_proveedor', '=', 'proveedores.id_proveedor')
            ->where('productos.estado', 'activo')
            ->select($selectFields)
            ->orderBy('productos.nombre', 'asc')
            ->get();
    }

    public function headings(): array
    {
        $esAdmin = Auth::user()->rol === 'administrador';

        // Armamos el arreglo de cabeceras base
        $cabeceras = [
            'Código Interno',
            'Código de Barras',
            'Nombre del Producto',
            'Categoría',
            'Proveedor',
            'Stock Actual',
        ];

        // Agregamos la cabecera de precio de lista solo si es administrador
        if ($esAdmin) {
            $cabeceras[] = 'Precio de Lista ($)';
        }

        // Siempre agregamos la cabecera de precio de venta al final
        $cabeceras[] = 'Precio de Venta ($)';

        return $cabeceras;
    }
}