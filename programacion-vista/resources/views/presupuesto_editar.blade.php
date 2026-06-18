@extends('layouts.nav')
@section('title', 'Modificar Presupuesto')
@section('ladoizq')

    @if (session('error'))
        <div class="alert alert-danger">{{ session('error') }}</div>
    @endif

    <form method="POST" action="{{ route('presupuesto.actualizar', $presupuesto->id_presupuesto) }}">
        @csrf
        @method('PUT')
        <div class="row h-100">
            <div class="col-lg-8 d-flex flex-column">
                <div class="card mb-3 flex-grow-1 left-table position-relative">
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title text-warning">Editando Presupuesto #{{ $presupuesto->id_presupuesto }}</h5>
                        <div class="table-responsive flex-grow-1 table-scroll">
                            <table class="table table-dark table-striped">
                                <thead>
                                    <tr>
                                        <th>Código</th>
                                        <th>Nombre</th>
                                        <th>Cantidad</th>
                                        <th>Precio unitario</th>
                                        <th>Total</th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody id="tablaPresupuesto"></tbody>
                            </table>
                        </div>
                    </div>
                    <div class="action-buttons p-3 border-top border-secondary">
                        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#buscarProductoPresupuestoModal">
                            Agregar Producto
                        </button>
                        <button type="submit" class="btn btn-warning">Guardar Cambios</button>
                    </div>
                </div>

                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Datos del cliente</h5>
                        <div class="mb-3">
                            <input type="text" name="nombre_cliente" class="form-control mb-2" value="{{ $presupuesto->nombre_cliente }}" placeholder="Nombre del cliente">
                            <input type="text" name="telefono_cliente" class="form-control" value="{{ $presupuesto->telefono_cliente }}" placeholder="Teléfono">
                        </div>
                        <div class="d-flex justify-content-between mb-2 align-items-center">
                            <label class="me-2 fw-bold">Descuento ($):</label>
                            <input type="number" id="descuento" name="descuento" class="form-control w-25" value="{{ $presupuesto->descuento }}" step="0.01" min="0" oninput="calcularTotalPresupuesto()">
                        </div>
                        <div class="d-flex justify-content-between fs-5 fw-bold">
                            <span>Total:</span>
                            <span id="totalPresupuesto" class="text-warning">${{ number_format($presupuesto->monto_total, 2) }}</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-4 right-column">
                @include('parciales.columna_derecha')
            </div>
        </div>
    </form>

    {{-- MODAL BUSCAR PRODUCTO (Igual al de crear) --}}
    <div class="modal fade" id="buscarProductoPresupuestoModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content bg-dark text-white">
                <div class="modal-header">
                    <h5 class="modal-title">Buscar Producto</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <input type="text" id="buscadorPresupuesto" class="form-control mb-3" placeholder="Buscar por nombre o código...">
                    <div class="table-responsive" style="max-height: 400px; overflow-y: auto;">
                        <table class="table table-dark table-hover">
                            <thead><tr><th>Código</th><th>Nombre</th><th>Stock</th><th>Precio</th><th>Acción</th></tr></thead>
                            <tbody id="listaProductosPresupuesto">
                                @foreach ($productos as $p)
                                    @php $nombreEscapado = str_replace(['"', "'"], ['\\"', "\\'"], $p->nombre); @endphp
                                    <tr class="item-producto-presupuesto">
                                        <td>{{ $p->codigo ?: $p->codigo_barra }}</td>
                                        <td class="nombre-prod">{{ $p->nombre }}</td>
                                        <td>{{ $p->stock }}</td>
                                        <td>${{ number_format($p->precio_venta, 2) }}</td>
                                        <td><button type="button" class="btn btn-sm btn-success" onclick="agregarProductoPresupuesto('{{ $p->id_producto }}', '{{ $nombreEscapado }}', '{{ $p->codigo ?: $p->codigo_barra }}', '{{ $p->precio_venta }}')">Seleccionar</button></td>
                                    </tr>
                                @endforeach
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.getElementById('buscadorPresupuesto').addEventListener('keyup', function() {
            const filtro = this.value.toLowerCase();
            document.querySelectorAll('.item-producto-presupuesto').forEach(fila => {
                fila.style.display = fila.textContent.toLowerCase().includes(filtro) ? '' : 'none';
            });
        });

        function agregarProductoPresupuesto(id, nombre, codigo, precio, cantidadInicial = 1) {
            const tbody = document.getElementById('tablaPresupuesto');
            if (document.getElementById(`cant_${id}`)) {
                alert('Este producto ya está. Modifique su cantidad.');
                return;
            }

            const subtotalLinea = (cantidadInicial * parseFloat(precio)).toFixed(2);
            const tr = document.createElement('tr');
            tr.innerHTML = `
                <td>${codigo}</td>
                <td>${nombre}<input type="hidden" name="productos[${id}][id_producto]" value="${id}"></td>
                <td><input type="number" id="cant_${id}" name="productos[${id}][cantidad]" class="form-control form-control-sm w-75" value="${cantidadInicial}" min="1" data-precio="${precio}" oninput="actualizarFilaPresupuesto(this)"></td>
                <td>$${parseFloat(precio).toFixed(2)}</td>
                <td class="total-linea">$${subtotalLinea}</td>
                <td><button type="button" class="btn btn-danger btn-sm" onclick="eliminarFilaPresupuesto(this)">✕</button></td>
            `;
            tbody.appendChild(tr);

            const modalElement = document.getElementById('buscarProductoPresupuestoModal');
            const modal = bootstrap.Modal.getInstance(modalElement);
            if(modal) modal.hide();
            calcularTotalPresupuesto();
        }

        function actualizarFilaPresupuesto(input) {
            const cant = parseInt(input.value) || 0;
            const prec = parseFloat(input.getAttribute('data-precio')) || 0;
            input.closest('tr').querySelector('.total-linea').textContent = '$' + (cant * prec).toFixed(2);
            calcularTotalPresupuesto();
        }

        function eliminarFilaPresupuesto(btn) {
            btn.closest('tr').remove();
            calcularTotalPresupuesto();
        }

        function calcularTotalPresupuesto() {
            let subtotal = 0;
            document.querySelectorAll('#tablaPresupuesto .total-linea').forEach(celda => {
                subtotal += parseFloat(celda.textContent.replace('$', '')) || 0;
            });
            const desc = parseFloat(document.getElementById('descuento').value) || 0;
            document.getElementById('totalPresupuesto').textContent = '$' + Math.max(0, subtotal - desc).toFixed(2);
        }

        // Auto-carga de los productos que el presupuesto ya tenía guardados
        document.addEventListener('DOMContentLoaded', function() {
            @foreach($productosSeleccionados as $prod)
                @php 
                    $cod = $prod->codigo ?: $prod->codigo_barra;
                    $nom = str_replace(['"', "'"], ['\\"', "\\'"], $prod->nombre);
                @endphp
                agregarProductoPresupuesto('{{ $prod->id_producto }}', '{!! $nom !!}', '{{ $cod }}', '{{ $prod->precio_guardado }}', {{ $prod->cantidad }});
            @endforeach
        });
    </script>
@endsection