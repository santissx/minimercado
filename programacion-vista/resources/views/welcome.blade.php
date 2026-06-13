@extends('layouts.nav')

@section('title', 'Venta')

@section('ladoizq')
@if ($errors->any())
    <div class="alert alert-danger">
        @foreach ($errors->all() as $error)
            <p>{{ $error }}</p>
        @endforeach
    </div>
@endif

<form id="formVentaPrincipal" method="POST" action="{{ route('ventas.guardar') }}">
    @csrf
    <div class="row h-100">
        <div class="col-lg-8 d-flex flex-column">
            <div class="card mb-3 flex-grow-1 left-table position-relative">
                
                <div class="card-body d-flex flex-column ">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5 class="card-title">Venta</h5>
                    </div>

                    <div class="table-responsive flex-grow-1 table-scroll">
                        <table class="table table-dark table-striped ">
                            <thead>
                                <tr>
                                    <th>Código del producto</th>
                                    <th>Nombre del producto</th>
                                    <th>Cantidad</th>
                                    <th>Precio Unitario</th>
                                    <th>Precio Total</th>
                                    <th class="text-center">Quitar</th> 
                                </tr>
                            </thead>
                            <tbody id="tablaVentas">
                                </tbody>
                        </table>
                    </div>

                </div>
                <div class="action-buttons">
                    <button type="button" class="btn btn-primary me-2" data-bs-toggle="modal" data-bs-target="#buscarProductoModal">
                        Agregar Producto
                    </button>
                    <button type="submit" class="btn btn-success">Guardar venta</button>
                </div>
            </div>
            
            <div class="filtros mb-3 p-3 bg-dark rounded border border-secondary">
                <div class="card-body">
                    <h5 class="card-title">Ventas Totales</h5>
                    <select class="form-select mb-3" name="metodo_pago" id="metodo_pago" required onchange="toggleClientesCorrientes()">
                        <option selected disabled value="">Método de pago</option>
                        @foreach($metodosDePago as $metodo)
                            <option value="{{ $metodo->id_metodo_pago }}">{{ $metodo->nombre }}</option>
                        @endforeach
                    </select>

                    <div id="clientes_corrientes_container" style="display: none;">
                        <select class="form-select mb-3" name="id_cliente" id="id_cliente">
                            <option selected disabled value="">Seleccione un cliente</option>
                        </select>
                    </div>
                    <div class="d-flex justify-content-between mb-2">
                        <label for="descuento" class="me-2">Descuento:</label>
                        <input type="number" id="descuento" name="descuento" class="form-control w-25" placeholder="$0.00" step="0.01" min="0" onchange="aplicarDescuento()">
                    </div>
                    <div class="d-flex justify-content-between">
                        <span>Total:</span>
                        <span id="totalVenta">$0.00</span>
                    </div>
                </div>
            </div>
        </div>
</form>

    <div class="col-lg-4 right-column">
        @include('parciales.columna_derecha')
        <div class="mt-4">
            <a href="{{ route('backup.db') }}" class="btn btn-outline-info w-100 shadow-sm d-flex justify-content-center align-items-center gap-2">
                <i class="fas fa-database"></i> Descargar Backup Completo
            </a>
        </div>
    </div>
</div>

<div class="modal fade" id="buscarProductoModal" tabindex="-1" aria-labelledby="buscarProductoModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content bg-dark">
            <div class="modal-header">
                <h5 class="modal-title" id="buscarProductoModalLabel">Buscar Producto</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <input type="text" id="buscarProductoInput" class="form-control" placeholder="Buscar por nombre o código...">
                <table class="table table-dark table-striped mt-3">
                    <thead>
                        <tr>
                            <th>Código de barra</th>
                            <th>Nombre</th>
                            <th>Precio</th>
                            <th>Stock</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody id="resultadosProductos">
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

@if (session('nueva_venta_id'))
    <div class="modal fade" id="ticketModal" tabindex="-1" aria-hidden="true" data-bs-backdrop="static">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content bg-dark text-white border border-secondary">
                <div class="modal-header border-secondary">
                    <h5 class="modal-title">¡Venta Procesada con éxito!</h5>
                </div>
                <div class="modal-body text-center">
                    <p class="mb-0">¿Deseás imprimir o visualizar el ticket de esta venta?</p>
                </div>
                <div class="modal-footer justify-content-center border-0">
                    <a href="{{ route('ventas.ticket', ['idVenta' => session('nueva_venta_id')]) }}" class="btn btn-success">
                        <i class="fas fa-print me-1"></i> Sí, ver ticket
                    </a>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                        No, continuar vendiendo
                    </button>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const ticketModal = new bootstrap.Modal(document.getElementById('ticketModal'));
            ticketModal.show();
        });
    </script>
@endif

<script>
    document.getElementById('buscarProductoInput').addEventListener('input', function () {
        const termino = this.value;

        if (termino.length > 1) { 
            fetch(`/buscar-productos?q=${encodeURIComponent(termino)}`)
                .then(response => response.json())
                .then(data => {
                    const resultados = document.getElementById('resultadosProductos');
                    resultados.innerHTML = '';

                    data.forEach(producto => {
                        const fila = document.createElement('tr');
                        fila.innerHTML = `
                            <td>${producto.codigo_barra}</td>
                            <td>${producto.nombre}</td>
                            <td>${producto.precio_venta}</td>
                            <td>${producto.stock}</td>
                            <td>
                                <button class="btn btn-success btn-sm agregar-producto" data-id="${producto.id_producto}">
                                    Agregar
                                </button>
                            </td>
                        `;
                        resultados.appendChild(fila);
                    });
                })
                .catch(error => console.error('Error en la búsqueda:', error));
        }
    });

    document.addEventListener('click', function (e) {
        if (e.target.classList.contains('agregar-producto')) {
            const fila = e.target.closest('tr');
            const id_producto = e.target.dataset.id;
            if (!id_producto) return;
            
            const codigo_barra = fila.cells[0].textContent.trim();
            const nombre = fila.cells[1].textContent.trim();
            const precio = parseFloat(fila.cells[2].textContent.trim());
            const stock = parseInt(fila.cells[3].textContent.trim());

            const tablaVentas = document.getElementById('tablaVentas');
            const nuevaFila = document.createElement('tr');

            nuevaFila.innerHTML = `
                <td>${codigo_barra}</td>
                <td>${nombre}</td>
                <td>
                    <input type="number" name="productos[${id_producto}][cantidad]" value="1" min="1" max="${stock}" class="form-control cantidad" data-precio="${precio}" data-stock="${stock}" oninput="actualizarTotal(this)">
                    <input type="hidden" name="productos[${id_producto}][id_producto]" value="${id_producto}">
                    <input type="hidden" name="productos[${id_producto}][precio]" value="${precio}">
                </td>
                <td>$${precio.toFixed(2)}</td>
                <td class="precio-total">$${precio.toFixed(2)}</td>
                <td class="text-center">
                    <button type="button" class="btn btn-danger btn-sm px-2 py-1" onclick="quitarProductoDelCarrito(this)">
                        ×
                    </button>
                </td>`;
            tablaVentas.appendChild(nuevaFila);

            const modal = bootstrap.Modal.getInstance(document.getElementById('buscarProductoModal'));
            modal.hide();

            calcularTotalVenta();
        }
    });

    function quitarProductoDelCarrito(boton) {
        const fila = boton.closest('tr');
        if (fila) {
            fila.remove();
            calcularTotalVenta();
        }
    }

    function actualizarTotal(input) {
        const cantidad = parseInt(input.value, 10) || 0;
        const precioUnitario = parseFloat(input.getAttribute('data-precio')) || 0;
        const precioTotal = cantidad * precioUnitario;

        const fila = input.closest('tr');
        fila.querySelector('.precio-total').textContent = `$${precioTotal.toFixed(2)}`;

        calcularTotalVenta();
    }

    function aplicarDescuento() {
        calcularTotalVenta();
    }

    function calcularTotalVenta() {
        let total = 0;
        const descuento = parseFloat(document.getElementById('descuento').value) || 0;

        document.querySelectorAll('.precio-total').forEach(celda => {
            const precio = parseFloat(celda.textContent.replace('$', '').trim()) || 0;
            total += precio;
        });

        // CORRECCIÓN VISUAL: Si el descuento es más grande que los productos, mostramos $0.00 en lugar de un número negativo
        let totalConDescuento = total - descuento;
        if (totalConDescuento < 0) {
            totalConDescuento = 0;
        }

        const totalVentaElement = document.querySelector('#totalVenta');
        if (totalVentaElement) {
            totalVentaElement.textContent = `$${totalConDescuento.toFixed(2)}`;
        }
    }

    // CONTROL JS ANTI-RELOAD (ACTUALIZADO CON VALIDACIÓN DE DESCUENTO)
    document.getElementById('formVentaPrincipal').addEventListener('submit', function (e) {
        const tablaVentas = document.getElementById('tablaVentas');
        const metodoPago = document.getElementById('metodo_pago').value;
        const idCliente = document.getElementById('id_cliente').value;
        const descuentoInput = parseFloat(document.getElementById('descuento').value) || 0;

        // 1. Validar carrito vacío
        if (tablaVentas.children.length === 0) {
            e.preventDefault();
            alert('¡Atención! No podés guardar una venta vacía. Agregá al menos un producto al listado.');
            return;
        }

        // 2. Calcular subtotal bruto actual en el carrito para auditar el descuento
        let subtotalProductos = 0;
        document.querySelectorAll('.precio-total').forEach(celda => {
            const precio = parseFloat(celda.textContent.replace('$', '').trim()) || 0;
            subtotalProductos += precio;
        });

        // 3. NUEVA VALIDACIÓN: Detener el envío si el descuento supera la mercadería
        if (descuentoInput > subtotalProductos) {
            e.preventDefault(); // Evitamos que la página se recargue y se borre el carrito
            alert('¡Atención! El descuento ingresado ($' + descuentoInput.toFixed(2) + ') no puede ser mayor al total acumulado de los productos ($' + subtotalProductos.toFixed(2) + '). Por favor, corregilo.');
            document.getElementById('descuento').focus();
            return;
        }

        // 4. Validar método de pago seleccionado
        if (!metodoPago) {
            e.preventDefault();
            alert('¡Atención! Es obligatorio que selecciones un Método de pago válido para guardar el registro.');
            document.getElementById('metodo_pago').focus();
            return;
        }

        // 5. Validar asociación de cliente corriente obligatorio
        if (metodoPago === '3' && !idCliente) {
            e.preventDefault();
            alert('¡Atención! Seleccionaste la opción "Cliente Corriente". Por lo tanto, debes indicar el cliente titular de la cuenta obligatoriamente.');
            document.getElementById('id_cliente').focus();
            return;
        }
    });
</script>

<script>
function toggleClientesCorrientes() {
    const metodoPago = document.getElementById('metodo_pago');
    const clientesCorrientesContainer = document.getElementById('clientes_corrientes_container');
    const selectClientes = document.getElementById('id_cliente');
    
    if (metodoPago.value === '3') { 
        clientesCorrientesContainer.style.display = 'block';
        selectClientes.setAttribute('required', 'required');
        cargarClientesCorrientes();
    } else {
        clientesCorrientesContainer.style.display = 'none';
        selectClientes.removeAttribute('required');
    }
}

function cargarClientesCorrientes() {
    fetch('/obtener-clientes-corrientes')
        .then(response => response.json())
        .then(data => {
            const selectClientes = document.getElementById('id_cliente');
            selectClientes.innerHTML = '<option selected disabled value="">Seleccione un cliente</option>';
            
            data.forEach(cliente => {
                const option = document.createElement('option');
                option.value = cliente.id_cliente;
                option.textContent = `${cliente.nombre_y_apellido} - DNI: ${cliente.dni}`;
                selectClientes.appendChild(option);
            });
        })
        .catch(error => console.error('Error:', error));
}
document.addEventListener('DOMContentLoaded', toggleClientesCorrientes);
</script>
@endsection