@extends('layouts.nav')

@section('title', 'Historial')

@section('ladoizq')
<div class="row h-100">
    <div class="col-lg-8 d-flex flex-column">
        <div class="card mb-3 flex-grow-1 left-table position-relative">
            <div class="card-body d-flex flex-column">
                <h5 class="card-title">Historial de ventas</h5>
                
                <div class="table-responsive flex-grow-1 table-scrollhist">
                    <table class="table table-dark table-striped">
                        <thead>
                            <tr>
                                <th>id_venta</th>
                                <th>vendedor</th>
                                <th>fecha venta (A-M-D)</th>
                                <th>monto con descuento</th>
                                <th>descuento</th>
                                <th>metodo de pago</th>
                                <th>Cliente</th>
                                <th class="text-center">Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            @foreach ($ventas as $venta)
                            <tr>
                                <td>{{ $venta->id_venta }}</td>
                                <td>{{ $venta->vendedor_id ?? 'N/A' }} - {{ $venta->vendedor_name ?? 'Sin nombre' }}</td>
                                <td>{{ $venta->fecha_venta }}</td>
                                <td>{{ $venta->monto_total }}</td>
                                <td>{{ $venta->descuento }}</td>
                                <td>{{ $venta->metodo_pago }}</td>
                                <td>
                                    @if($venta->clientec)
                                        {{ $venta->clientec }} - {{ $venta->nombre_clientec }}
                                    @else
                                        N/A
                                    @endif
                                </td>
                                <td class="text-center">
                                    <div class="d-flex justify-content-center align-items-center gap-2">
                                        <button name="boton detalle"
                                                type="button" 
                                                class="btn btn-primary ver-detalle-venta" 
                                                data-id="{{ $venta->id_venta }}" 
                                                data-bs-toggle="modal" 
                                                data-bs-target="#verdetalleventa">
                                            Ver Detalle
                                        </button>
                                        <button name="boton anular" 
                                                type="button" 
                                                class="btn btn-danger btn-anular-venta" 
                                                data-id="{{ $venta->id_venta }}" 
                                                data-bs-toggle="modal" 
                                                data-bs-target="#modalAnularVenta">
                                            Anular
                                        </button>
                                        <a href="{{ route('ventas.ticket', $venta->id_venta) }}" class="btn btn-sm btn-secondary">Ver Ticket</a>
                                    </div>
                                </td>
                            </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>

                <div class="filtros mb-3 p-3 bg-dark rounded border border-secondary">
                    <form method="GET" action="{{ route('views.historial') }}">
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="selectVendedor" class="form-label text-white">Filtrar por vendedor</label>
                                <select class="form-select" id="selectVendedor" name="vendedor">
                                    <option value="">Selecciona un vendedor</option>
                                    @foreach ($vendedores as $vendedor)
                                        <option value="{{ $vendedor->id }}" {{ request('vendedor') == $vendedor->id ? 'selected' : '' }}>
                                            {{ $vendedor->name }}
                                        </option>
                                    @endforeach
                                </select>
                            </div>

                            <div class="col-md-6 mb-3">
                                <label for="id_cliente" class="form-label text-white">Filtrar por Cliente Corriente</label>
                                <select class="form-select" name="id_cliente" id="id_cliente">
                                    <option value="">Todos los movimientos (Sin filtro)</option>
                                    @foreach($clientes as $cliente)
                                        <option value="{{ $cliente->id_cliente }}" {{ request('id_cliente') == $cliente->id_cliente ? 'selected' : '' }}>
                                            {{ $cliente->nombre_y_apellido }}
                                        </option>
                                    @endforeach
                                </select>
                            </div>
                        </div>

                        <label for="rango" class="form-label text-white">Filtrar por rango de fechas</label>
                        <div class="input-group mb-3">
                            <input type="date" class="form-control" name="fechainicio" value="{{ request('fechainicio') }}" placeholder="Fecha inicio">
                            <span class="input-group-text">a</span>
                            <input type="date" class="form-control" name="fechafin" value="{{ request('fechafin') }}" placeholder="Fecha fin">
                        </div>
                        
                        <div class="d-flex justify-content-between align-items-center mt-3">
                            <div class="d-flex gap-2">
                                <button type="submit" class="btn btn-primary">Aplicar filtros</button>
                                
                                <button type="submit" formaction="{{ route('exportar.ventas') }}" class="btn btn-success">
                                    <i class="fas fa-file-excel text-white me-1"></i> Exportar Resultados a Excel
                                </button>
                            </div>
                            
                            <h5 class="text-white m-0">
                                <strong>Venta total: <span class="text-success">${{ number_format($totalVentas, 2) }}</span></strong>
                            </h5>
                        </div>

                    </form>
                </div>
                
            </div>
        </div>
    </div>

    <div class="col-lg-4 right-column">
        @include('parciales.columna_derecha')
    </div>
</div>
@endsection 

<div class="modal fade" id="verdetalleventa" tabindex="-1" aria-labelledby="verdetalleventaLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content bg-dark">
            <div class="modal-header">
                <h5 class="modal-title" id="verdetalleventaLabel">Detalle de la venta</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="card mb-3 flex-grow-1 left-table position-relative">
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title">Productos vendidos</h5>
                        <div class="table-responsive flex-grow-1">
                            <table class="table table-dark table-striped">
                                <thead>
                                    <tr>
                                        <th>ID Venta</th>
                                        <th>Producto</th>
                                        <th>Cantidad</th>
                                        <th>Precio</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modalAnularVenta" tabindex="-1" aria-labelledby="modalAnularVentaLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content bg-dark text-light">
            <div class="modal-header">
                <h5 class="modal-title" id="modalAnularVentaLabel">Anular Venta</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="formAnularVenta" action="{{ route('ventas.anular') }}" method="POST">
                    @csrf
                    <input type="hidden" name="id_venta" id="id_venta" readonly>
                    <input type="hidden" name="id_usuario_anulador" value="{{ auth()->id() }}">
                    <div class="mb-3">
                        <label for="descripcion" class="form-label">Motivo de Anulación</label>
                        <input type="text" name="descripcion" id="descripcion" class="form-control" required>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button type="submit" class="btn btn-danger" form="formAnularVenta">Confirmar Anulación</button>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        // Carga asíncrona de los productos del Detalle de Venta
        document.querySelectorAll('.ver-detalle-venta').forEach(button => {
            button.addEventListener('click', function () {
                const idVenta = this.getAttribute('data-id');
                
                fetch(`/detalle-venta/${idVenta}`)
                    .then(response => response.json())
                    .then(data => {
                        const tbody = document.querySelector('#verdetalleventa table tbody');
                        tbody.innerHTML = '';

                        data.forEach(producto => {
                            const row = `
                                <tr>
                                    <td>${idVenta}</td>
                                    <td>${producto.producto}</td>
                                    <td>${producto.cantidad}</td>
                                    <td>${producto.precio}</td>
                                </tr>
                            `;
                            tbody.innerHTML += row;
                        });
                    })
                    .catch(error => console.error('Error al cargar los detalles de la venta:', error));
            });
        });

        // Inyección dinámica de la ID de venta al Modal de Anulación
        const modalAnularVenta = document.getElementById('modalAnularVenta');
        const inputIdVenta = modalAnularVenta.querySelector('#id_venta');

        document.querySelectorAll('.btn-anular-venta').forEach(button => {
            button.addEventListener('click', function () {
                const idVenta = this.getAttribute('data-id');
                inputIdVenta.value = idVenta;
            });
        });
    });
</script>