<?php

namespace App\Exports;

use Illuminate\Support\Facades\DB;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;

class VentasProductosExport implements FromCollection, WithHeadings
{
    protected $filtros;

    public function __construct($filtros)
    {
        $this->filtros = $filtros;
    }

    public function collection()
    {
        $query = DB::table('ventas')
            ->join('ventas_productos', 'ventas.id_venta', '=', 'ventas_productos.id_venta')
            ->join('productos', 'ventas_productos.id_producto', '=', 'productos.id_producto')
            ->join('users', 'ventas.id_usuario', '=', 'users.id')
            ->join('metodos_pago', 'ventas.id_metodo_pago', '=', 'metodos_pago.id_metodo_pago')
            ->leftJoin('clientes_corrientes', 'ventas.id_cliente', '=', 'clientes_corrientes.id_cliente')
            ->leftJoin('ventas_anuladas', 'ventas.id_venta', '=', 'ventas_anuladas.id_venta')
            ->whereNull('ventas_anuladas.id_venta');

        if (!empty($this->filtros['vendedor'])) {
            $query->where('users.id', $this->filtros['vendedor']);
        }

        if (!empty($this->filtros['id_cliente'])) {
            $query->where('ventas.id_cliente', $this->filtros['id_cliente']);
        }

        if (!empty($this->filtros['fechainicio']) && !empty($this->filtros['fechafin'])) {
            $query->whereBetween('ventas.fecha_venta', [
                $this->filtros['fechainicio'] . ' 00:00:00',
                $this->filtros['fechafin'] . ' 23:59:59'
            ]);
        } elseif (!empty($this->filtros['fechainicio'])) {
            $query->where(
                'ventas.fecha_venta',
                '>=',
                $this->filtros['fechainicio'] . ' 00:00:00'
            );
        } elseif (!empty($this->filtros['fechafin'])) {
            $query->where(
                'ventas.fecha_venta',
                '<=',
                $this->filtros['fechafin'] . ' 23:59:59'
            );
        }

        return $query->select(
            'ventas.id_venta',
            'ventas.fecha_venta',
            'productos.nombre as producto',
            'productos.codigo_barra',
            'ventas_productos.cantidad',
            'ventas_productos.precio as precio_unitario',
            DB::raw('(ventas_productos.cantidad * ventas_productos.precio) as total_producto'),
            'metodos_pago.nombre as metodo_pago',
            'users.name as vendedor',
            DB::raw("COALESCE(clientes_corrientes.nombre_y_apellido, ventas.cliente_nombre, 'Consumidor Final') as cliente")
        )
        ->orderBy('ventas.fecha_venta', 'desc')
        ->orderBy('ventas.id_venta', 'desc')
        ->get();
    }

    public function headings(): array
    {
        return [
            'ID Venta',
            'Fecha y Hora',
            'Producto',
            'Código de Barra',
            'Cantidad',
            'Precio Unitario ($)',
            'Total Producto ($)',
            'Método de Pago',
            'Vendedor',
            'Cliente'
        ];
    }
}