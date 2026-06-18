@extends('layouts.nav')

@section('title', 'Generar Presupuesto')

@section('ladoizq')

    @if (session('error'))
        <div class="alert alert-danger">{{ session('error') }}</div>
    @endif

    {{-- Formulario principal: Enmarca toda la estructura row/col --}}
    <form method="POST" action="{{ route('presupuesto.generar') }}">
        @csrf
        <div class="row h-100">
            
            {{-- Columna Izquierda: Tablas y Datos del Cliente --}}
            <div class="col-lg-8 d-flex flex-column">

                {{-- Tabla de productos seleccionados --}}
                <div class="card mb-3 flex-grow-1 left-table position-relative">
                    <div class="card-body d-flex flex-column">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h5 class="card-title">Presupuesto</h5>
                        </div>
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
                                <tbody id="tablaPresupuesto">
                                    {{-- Los productos se agregan dinámicamente aquí --}}
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="action-buttons p-3 border-top border-secondary">
                        <button type="button" class="btn btn-primary" data-bs-toggle="modal"
                            data-bs-target="#buscarProductoPresupuestoModal">
                            Agregar Producto
                        </button>
                        <button type="submit" class="btn btn-success">Generar Presupuesto</button>
                    </div>
                </div>

                {{-- Datos del cliente y totales --}}
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Datos del cliente</h5>
                        <div class="mb-3">
                            <input type="text" name="nombre_cliente" class="form-control mb-2"
                                placeholder="Nombre del cliente (opcional)">
                            <input type="text" name="telefono_cliente" class="form-control"
                                placeholder="Teléfono (opcional)">
                        </div>
                        <div class="d-flex justify-content-between mb-2 align-items-center">
                            <label class="me-2 fw-bold">Descuento ($):</label>
                            <input type="number" id="descuento" name="descuento" class="form-control w-25"
                                placeholder="0.00" step="0.01" min="0" oninput="calcularTotalPresupuesto()">
                        </div>
                        <div class="d-flex justify-content-between fs-5 fw-bold">
                            <span>Total:</span>
                            <span id="totalPresupuesto" class="text-success">$0.00</span>
                        </div>
                    </div>
                </div>

            </div> {{-- Fin col-lg-8 --}}

            {{-- Columna derecha --}}
            <div class="col-lg-4 right-column">
                @include('parciales.columna_derecha')
            </div>

        </div> {{-- Fin row --}}
    </form>

    {{-- MODAL: Buscar Producto para Presupuesto --}}
    <div class="modal fade" id="buscarProductoPresupuestoModal" tabindex="-1" aria-labelledby="buscarProductoPresupuestoModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content bg-dark text-white">
                <div class="modal-header">
                    <h5 class="modal-title" id="buscarProductoPresupuestoModalLabel">Buscar Producto</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <input type="text" id="buscadorPresupuesto" class="form-control mb-3" placeholder="Buscar por nombre o código...">
                    
                    <div class="table-responsive" style="max-height: 400px; overflow-y: auto;">
                        <table class="table table-dark table-hover">
                            <thead>
                                <tr>
                                    <th>Código</th>
                                    <th>Nombre</th>
                                    <th>Stock</th>
                                    <th>Precio</th>
                                    <th>Acción</th>
                                </tr>
                            </thead>
                            <tbody id="listaProductosPresupuesto">
                                @foreach ($productos as $p)
                                    @php
                                        // Escapamos tanto comillas simples como dobles para evitar fallos de sintaxis en el HTML inline de JS
                                        $nombreEscapado = str_replace(['"', "'"], ['\\"', "\\'"], $p->nombre);
                                    @endphp
                                    <tr class="item-producto-presupuesto">
                                        <td>{{ $p->codigo ?: $p->codigo_barra }}</td>
                                        <td class="nombre-prod">{{ $p->nombre }}</td>
                                        <td>{{ $p->stock }}</td>
                                        <td>${{ number_format($p->precio_venta, 2) }}</td>
                                        <td>
                                            <button type="button" class="btn btn-sm btn-success" 
                                                onclick="agregarProductoPresupuesto('{{ $p->id_producto }}', '{{ $nombreEscapado }}', '{{ $p->codigo ?: $p->codigo_barra }}', '{{ $p->precio_venta }}')">
                                                Seleccionar
                                            </button>
                                        </td>
                                    </tr>
                                @endforeach
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    {{-- SCRIPTS DE JAVASCRIPT --}}
    <script>
        // Buscador interno del modal
        document.getElementById('buscadorPresupuesto').addEventListener('keyup', function() {
            const filtro = this.value.toLowerCase();
            const filas = document.querySelectorAll('.item-producto-presupuesto');

            filas.forEach(fila => {
                const texto = fila.textContent.toLowerCase();
                fila.style.display = texto.includes(filtro) ? '' : 'none';
            });
        });

        // Agregar un producto a la tabla de presupuestos
        function agregarProductoPresupuesto(id, nombre, codigo, precio) {
            const tbody = document.getElementById('tablaPresupuesto');

            // Validar si el producto ya fue agregado antes
            if (document.getElementById(`cant_${id}`)) {
                alert('Este producto ya está en el presupuesto. Modifique su cantidad directamente.');
                return;
            }

            const tr = document.createElement('tr');
            tr.innerHTML = `
                <td>${codigo}</td>
                <td>
                    ${nombre}
                    <input type="hidden" name="productos[${id}][id_producto]" value="${id}">
                </td>
                <td>
                    <input type="number" id="cant_${id}" name="productos[${id}][cantidad]" class="form-control form-control-sm w-75" 
                        value="1" min="1" data-precio="${precio}" oninput="actualizarFilaPresupuesto(this)">
                </td>
                <td>$${parseFloat(precio).toFixed(2)}</td>
                <td class="total-linea">$${parseFloat(precio).toFixed(2)}</td>
                <td>
                    <button type="button" class="btn btn-danger btn-sm" onclick="eliminarFilaPresupuesto(this)">✕</button>
                </td>
            `;
            tbody.appendChild(tr);

            // Cerrar el modal correctamente usando la API de Bootstrap
            const modalElement = document.getElementById('buscarProductoPresupuestoModal');
            const modal = bootstrap.Modal.getInstance(modalElement) || new bootstrap.Modal(modalElement);
            modal.hide();

            calcularTotalPresupuesto();
        }

        // Modificar la cantidad en una fila
        function actualizarFilaPresupuesto(input) {
            const cantidad = parseInt(input.value) || 0;
            const precio = parseFloat(input.getAttribute('data-precio')) || 0;
            const fila = input.closest('tr');
            
            fila.querySelector('.total-linea').textContent = '$' + (cantidad * precio).toFixed(2);
            calcularTotalPresupuesto();
        }

        // Eliminar fila de la tabla
        function eliminarFilaPresupuesto(btn) {
            btn.closest('tr').remove();
            calcularTotalPresupuesto();
        }

        // Recalcular el total general
        function calcularTotalPresupuesto() {
            let subtotal = 0;
            document.querySelectorAll('#tablaPresupuesto .total-linea').forEach(celda => {
                subtotal += parseFloat(celda.textContent.replace('$', '')) || 0;
            });
            
            const descuento = parseFloat(document.getElementById('descuento').value) || 0;
            const totalFinal = Math.max(0, subtotal - descuento); // Evita que dé números negativos si el descuento supera el subtotal

            document.getElementById('totalPresupuesto').textContent = '$' + totalFinal.toFixed(2);
        }
    </script>
@if (session('nuevo_presupuesto_id'))
        <div class="modal fade" id="presupuestoGuardadoModal" tabindex="-1" aria-hidden="true" data-bs-backdrop="static">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content bg-dark text-white border border-secondary">
                    <div class="modal-header border-secondary">
                        <h5 class="modal-title">¡Presupuesto Generado con Éxito!</h5>
                    </div>
                    <div class="modal-body text-center">
                        <p class="mb-0">El presupuesto se ha guardado en el historial.</p>
                        <p class="mt-2">¿Deseás imprimir el comprobante ahora?</p>
                    </div>
                    <div class="modal-footer justify-content-center border-0">
                        <a href="{{ route('presupuesto.imprimir', ['id' => session('nuevo_presupuesto_id')]) }}" class="btn btn-success">
                            <i class="fas fa-print me-1"></i> Sí, imprimir
                        </a>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                            No, seguir trabajando
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <script>
            document.addEventListener('DOMContentLoaded', function() {
                const modal = new bootstrap.Modal(document.getElementById('presupuestoGuardadoModal'));
                modal.show();
            });
        </script>
    @endif

@endsection