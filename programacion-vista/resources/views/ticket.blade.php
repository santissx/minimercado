@extends('layouts.nav')

@section('title', 'Ticket de Venta')

@section('content')
<button class="btn btn-primary d-print-none" onclick="history.back();">VOLVER</button> 
<h1 class="mb-3 d-print-none">Ticket de Venta</h1> <!-- Ocultar título en impresión -->

    <!-- Contenido imprimible -->
    <div class="printable-area">
        <div class="card-body">
            <ul class="list-group mb-4">
                
                <li class="list-group-item">
                <h2 class="card-title">Venta #{{ $venta->id_venta }}</h2>
                <p><strong>Vendedor:</strong> {{ $venta->vendedor_name }}</p>
                <p><strong>Monto Total:</strong> ${{ number_format($venta->monto_total, 2) }}</p>
                <p><strong>Descuento:</strong> ${{ number_format($venta->descuento, 2) }}</p>
                <p><strong>Fecha de Venta:</strong> {{ $venta->fecha_venta }}</p>
                <p><strong>Método de Pago:</strong> {{ $venta->metodo_pago }}</p>
                <P><strong>Cliente Corriente:</strong> @if($venta->clientec)
                    {{ $venta->clientec }} - {{ $venta->nombre_clientec }}
                    @else
                    N/A
                    @endif
                </td> </P>
                <h3>Productos</h3>
            <ul class="list-group mb-4">
                @foreach ($productos as $producto)
                    <li class="list-group-item">
                        <strong>Producto:</strong> {{ $producto->producto }} <br>
                        <strong>Cantidad:</strong> {{ $producto->cantidad }} <br>
                        <strong>Precio:</strong> ${{ number_format($producto->precio, 2) }}
                    </li>
                @endforeach
            </ul>
            </li>
            </ul>
            
        </div>
    </div>

    <!-- Botón para imprimir -->
    <button class="btn btn-primary d-print-none" onclick="window.print()">Imprimir Ticket</button>
</div>
@endsection
