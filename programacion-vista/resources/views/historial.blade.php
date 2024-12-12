
@extends('layouts.nav')

@section('title', 'Historial')

@section('ladoizq')
<div class="row h-100">
    <div class="col-lg-8 d-flex flex-column">
        <!-- Cuadro de historial -->
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
                                <th>Acciones</th>
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
                                <td>  @if($venta->clientec)
                                    {{ $venta->clientec }} - {{ $venta->nombre_clientec }}
                                    @else
                                    N/A
                                    @endif
                                </td>
                                <td class="d-flex justify-content-center align-items-center gap-2">
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

                                </td>
                            </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>
                <div class="filtros mb-3">
                    <form method="GET" action="{{ route('views.historial') }}">
                        <label for="selectVendedor" class="form-label">Filtrar por vendedor</label>
                        <select class="form-select" id="selectVendedor" name="vendedor">
                            <option value="">Selecciona un vendedor</option>
                            @foreach ($vendedores as $vendedor)
                                <option value="{{ $vendedor->id }}">{{ $vendedor->name }}</option>
                            @endforeach
                        </select>

                     
                        <label for="rango" class="form-label">Filtrar por rango de fechas</label>
                        <div class="input-group">
                            <input type="date" class="form-control" name="fechainicio" placeholder="Fecha inicio">
                            <span class="input-group-text">a</span>
                            <input type="date" class="form-control" name="fechafin" placeholder="Fecha fin">
                        </div>
                        <button type="submit" class="btn btn-primary mt-3">Aplicar filtros</button>
                    </form>
                    <label for="total_ventas">Venta total: ${{ number_format($totalVentas, 2) }}</label>  

                        
                </div>
                
            </div>
        </div>
    </div>

    <!-- Columna derecha superior -->
    <div class="col-lg-4 right-column">
        @include('parciales.columna_derecha')
    </div>
</div>
@endsection 
<!-- Modal ver detalle -->
<div class="modal fade " id="verdetalleventa" tabindex="-1" aria-labelledby="verdetalleventaLabel" aria-hidden="true">
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
                                    <!-- Aquí irán las filas de productos dinámicamente -->
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

<!-- modal anular venta -->
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
                        <input type="text" name="descripcion" id="descripcion " class="form-control" required>
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
        // Escuchar el clic en el botón "Ver Detalle"
        document.querySelectorAll('.ver-detalle-venta').forEach(button => {
            button.addEventListener('click', function () {
                const idVenta = this.getAttribute('data-id'); // Obtener el id_venta
                
                // Realizar solicitud AJAX para obtener el detalle de la venta
                fetch(`/detalle-venta/${idVenta}`)
                    .then(response => response.json())
                    .then(data => {
                        const tbody = document.querySelector('#verdetalleventa table tbody');
                        
                        // Limpiar las filas existentes
                        tbody.innerHTML = '';

                        // Agregar las filas de los productos
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
    });
</script>
<!-- script para pasar id_venta  a el modal -->
    <script>
    document.addEventListener('DOMContentLoaded', function () {
        const modalAnularVenta = document.getElementById('modalAnularVenta');
        const inputIdVenta = modalAnularVenta.querySelector('#id_venta');

        // Escuchar el evento de clic en los botones "Anular"
        document.querySelectorAll('.btn-anular-venta').forEach(button => {
            button.addEventListener('click', function () {
                const idVenta = this.getAttribute('data-id');
                inputIdVenta.value = idVenta; // Asignar el ID de la venta al campo oculto
            });
        });
    });
</script>