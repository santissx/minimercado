@extends('layouts.nav')

@section('title', 'Generar Presupuesto')

@section('ladoizq')

    @if (session('error'))
        <div class="alert alert-danger">{{ session('error') }}</div>
    @endif

    <form method="POST" action="{{ route('presupuesto.generar') }}">
        @csrf
        <div class="row h-100">
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
                                    {{-- productos se agregan dinámicamente --}}
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="action-buttons">
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
                        <div class="d-flex justify-content-between mb-2">
                            <label class="me-2">Descuento:</label>
                            <input type="number" id="descuento" name="descuento" class="form-control w-25"
                                placeholder="$0.00" step="0.01" min="0" onchange="calcularTotalPresupuesto()">
                        </div>
                        <div class="d-flex justify-content-between">
                            <span>Total:</span>
                            <span id="totalPresupuesto">$0.00</span>
                        </div>
                    </div>
                </div>

            </div>
    </form>

    {{-- Columna derecha --}}
    <div class="col-lg-4 right-column">
        @include('parciales.columna_derecha')
    </div>
    </div>

    {{-- Modal buscar producto --}}
    <div class="modal fade" id="buscarProductoPresupuestoModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content bg-dark">
                <div class="modal-header">
                    <h5 class="modal-title">Buscar Producto</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <input type="text" id="buscarInputPresupuesto" class="form-control mb-3"
                        placeholder="Buscar por nombre o código...">
                    <table class="table table-dark table-striped">
                        <thead>
                            <tr>
                                <th>Código</th>
                                <th>Nombre</th>
                                <th>Precio</th>
                                <th>Acción</th>
                            </tr>
                        </thead>
                        <tbody id="resultadosPresupuesto"></tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Búsqueda de productos en el modal
        document.getElementById('buscarInputPresupuesto').addEventListener('input', function() {
            const termino = this.value.toLowerCase();
            const filas = document.querySelectorAll('#resultadosPresupuesto tr');

            if (termino.length < 1) {
                cargarTodosLosProductos();
                return;
            }

            filas.forEach(fila => {
                const texto = fila.textContent.toLowerCase();
                fila.style.display = texto.includes(termino) ? '' : 'none';
            });
        });

        // Cargar todos los productos al abrir el modal
        function cargarTodosLosProductos() {
            const productos = @json($productos);
            const tbody = document.getElementById('resultadosPresupuesto');
            tbody.innerHTML = '';

            productos.forEach(p => {
                const codigo = p.codigo || p.codigo_barra;
                const tr = document.createElement('tr');
                tr.innerHTML = `
                <td>${codigo}</td>
                <td>${p.nombre}</td>
                <td>$${parseFloat(p.precio_venta).toFixed(2)}</td>
                <td>
                    <button type="button" class="btn btn-success btn-sm"
                        onclick="agregarProductoPresupuesto('${p.id_producto}', '${codigo}', '${p.nombre.replace(/'/g, "\\'")}', ${p.precio_venta})">
                        Agregar
                    </button>
                </td>
            `;
                tbody.appendChild(tr);
            });
        }

        document.getElementById('buscarProductoPresupuestoModal')
            .addEventListener('show.bs.modal', cargarTodosLosProductos);

        // Agregar producto a la tabla
        function agregarProductoPresupuesto(id, codigo, nombre, precio) {
            // Si ya existe, solo suma cantidad
            const filaExistente = document.querySelector(`#tablaPresupuesto tr[data-id="${id}"]`);
            if (filaExistente) {
                const input = filaExistente.querySelector('.cantidad-input');
                input.value = parseInt(input.value) + 1;
                actualizarFilaPresupuesto(input);

                const modal = bootstrap.Modal.getInstance(document.getElementById('buscarProductoPresupuestoModal'));
                modal.hide();
                return;
            }

            const tbody = document.getElementById('tablaPresupuesto');
            const tr = document.createElement('tr');
            tr.setAttribute('data-id', id);
            tr.innerHTML = `
            <td>${codigo}</td>
            <td>${nombre}
                <input type="hidden" name="productos[${id}][id_producto]" value="${id}">
            </td>
            <td>
                <input type="number" name="productos[${id}][cantidad]" value="1" min="1"
                    class="form-control cantidad-input" style="width:80px"
                    data-precio="${precio}"
                    oninput="actualizarFilaPresupuesto(this)">
            </td>
            <td>$${parseFloat(precio).toFixed(2)}</td>
            <td class="total-linea">$${parseFloat(precio).toFixed(2)}</td>
            <td>
                <button type="button" class="btn btn-danger btn-sm" onclick="eliminarFilaPresupuesto(this)">✕</button>
            </td>
        `;
            tbody.appendChild(tr);

            const modal = bootstrap.Modal.getInstance(document.getElementById('buscarProductoPresupuestoModal'));
            modal.hide();

            calcularTotalPresupuesto();
        }

        function actualizarFilaPresupuesto(input) {
            const cantidad = parseInt(input.value) || 1;
            const precio = parseFloat(input.getAttribute('data-precio'));
            const fila = input.closest('tr');
            fila.querySelector('.total-linea').textContent = '$' + (cantidad * precio).toFixed(2);
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
            const descuento = parseFloat(document.getElementById('descuento').value) || 0;
            document.getElementById('totalPresupuesto').textContent = '$' + (subtotal - descuento).toFixed(2);
        }
    </script>

@endsection
