@extends('layouts.nav')

@section('title', 'Venta')

@section('ladoizq')
<form method="POST" action="{{ route('ventas.guardar') }}">
    @csrf
    <div class="row h-100">
        <div class="col-lg-8 d-flex flex-column">
            <!-- Cuadro de Venta -->
            <div class="card mb-3 flex-grow-1 left-table position-relative">
                <div class="card-body d-flex flex-column">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5 class="card-title">Venta</h5>
                    </div>

                    <div class="table-responsive flex-grow-1">
                        <table class="table table-dark table-striped">
                            <thead>
                                <tr>
                                    <th>Código del producto</th>
                                    <th>Nombre del producto</th>
                                    <th>Cantidad</th>
                                    <th>Precio Unitario</th>
                                    <th>Precio Total</th>
                                </tr>
                            </thead>
                            <tbody id="tablaVentas">
                                <!-- Aquí se agregarán los productos dinámicamente -->
                            </tbody>
                        </table>
                    </div>

                    <div class="action-buttons">
                        <button type="button" class="btn btn-primary me-2" data-bs-toggle="modal" data-bs-target="#buscarProductoModal">
                            Agregar Producto
                        </button>
                        <button type="submit" class="btn btn-success">Guardar venta</button>
                    </div>
                </div>
            </div>

            <!-- Cuadro de Ventas Totales -->
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Ventas Totales</h5>
                    <select class="form-select mb-3" name="metodo_pago" id="metodo_pago" required onchange="toggleClientesCorrientes()">
                    <option selected disabled>Método de pago</option>
                    @foreach($metodosDePago as $metodo)
                        <option value="{{ $metodo->id_metodo_pago }}">{{ $metodo->nombre }}</option>
                    @endforeach
                </select>

                <div id="clientes_corrientes_container" style="display: none;">
                    <select class="form-select mb-3" name="id_cliente" id="id_cliente" required>
                        <option selected disabled>Seleccione un cliente</option>
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

    <!-- Columna derecha superior -->
    <div class="col-lg-4 right-column">
        @include('parciales.columna_derecha')
    </div>
</div>

<!-- Modal para buscar productos -->
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
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody id="resultadosProductos">
                        <!-- Aquí se mostrarán los resultados -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script>
    document.getElementById('buscarProductoInput').addEventListener('input', function () {
        const termino = this.value;

        if (termino.length > 2) { // Realiza la búsqueda después de 3 caracteres
            fetch(`/buscar-productos?q=${encodeURIComponent(termino)}`)
                .then(response => response.json())
                .then(data => {
                    const resultados = document.getElementById('resultadosProductos');
                    resultados.innerHTML = ''; // Limpia los resultados previos

                    data.forEach(producto => {
                        const fila = document.createElement('tr');
                        fila.innerHTML = `
                            <td>${producto.codigo_barra}</td>
                            <td>${producto.nombre}</td>
                            <td>${producto.precio_venta}</td>
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

    //capturar evento agregar y agregar el producto:
    document.addEventListener('click', function (e) {
    if (e.target.classList.contains('agregar-producto')) {
        const fila = e.target.closest('tr'); // Encuentra la fila del producto
        const id_producto = e.target.dataset.id;
        if (!id_producto) {
            console.error('ID del producto es inválido.');
            return;
        }
        const codigo_barra = fila.cells[0].textContent.trim();
        const nombre = fila.cells[1].textContent.trim();
        const precio = parseFloat(fila.cells[2].textContent.trim()); // Convertir a número

        if (!id_producto) {
            console.error('ID del producto es inválido.');
            return;
        }

        // Añadir producto a la tabla de ventas
        const tablaVentas = document.querySelector('.table tbody');
        const nuevaFila = document.createElement('tr');

        nuevaFila.innerHTML = `
            <td>${codigo_barra}</td>
            <td>${nombre}</td>
            <td>
                <input type="number" name="productos[${id_producto}][cantidad]" value="1" min="1" class="form-control cantidad" data-precio="${precio}" onchange="actualizarTotal(this)">
                <input type="hidden" name="productos[${id_producto}][id_producto]" value="${id_producto}">
                <input type="hidden" name="productos[${id_producto}][precio]" value="${precio}">
            </td>
            <td>$${precio.toFixed(2)}</td>
            <td class="precio-total">$${precio.toFixed(2)}</td>`;
        tablaVentas.appendChild(nuevaFila);

        // Cierra el modal
        const modal = bootstrap.Modal.getInstance(document.getElementById('buscarProductoModal'));
        modal.hide();

        // Recalcular el total
        calcularTotalVenta();
    }
});

    function actualizarTotal(input) {
        const cantidad = parseInt(input.value, 10) || 0;
        const precioUnitario = parseFloat(input.getAttribute('data-precio')) || 0;
        const precioTotal = cantidad * precioUnitario;

        // Actualizar el precio total de la fila
        const fila = input.closest('tr');
        fila.querySelector('.precio-total').textContent = `$${precioTotal.toFixed(2)}`;

        // Recalcular el total de la venta
        const descuento = parseFloat(document.getElementById('descuento').value) || 0;
        calcularTotalVenta(descuento);
    }

    // Función para aplicar el descuento
    function aplicarDescuento() {
        const descuento = parseFloat(document.getElementById('descuento').value) || 0;
        calcularTotalVenta(descuento);
    }

    // Función para recalcular el total de la venta
    function calcularTotalVenta(descuento = 0) {
        let total = 0;

        // Iterar sobre las celdas con la clase 'precio-total' y sumar los precios de los productos
        document.querySelectorAll('.precio-total').forEach(celda => {
            const precio = parseFloat(celda.textContent.replace('$', '').trim()) || 0;
            total += precio;
        });

        // Aplicar descuento
        total -= descuento;

        // Mostrar el total final
        const totalVentaElement = document.querySelector('#totalVenta');
        if (totalVentaElement) {
            totalVentaElement.textContent = `$${total.toFixed(2)}`;
        }
    }
</script>

<!-- script para clientes corrientes -->
<script>
function toggleClientesCorrientes() {
    const metodoPago = document.getElementById('metodo_pago');
    const clientesCorrientesContainer = document.getElementById('clientes_corrientes_container');
    
    if (metodoPago.value === '3') { // Assuming '3' is the id for 'Cliente Corriente'
        clientesCorrientesContainer.style.display = 'block';
        cargarClientesCorrientes();
    } else {
        clientesCorrientesContainer.style.display = 'none';
    }
}

function cargarClientesCorrientes() {
    fetch('/obtener-clientes-corrientes')
        .then(response => response.json())
        .then(data => {
            const selectClientes = document.getElementById('id_cliente');
            selectClientes.innerHTML = '<option selected disabled>Seleccione un cliente</option>';
            
            data.forEach(cliente => {
                const option = document.createElement('option');
                option.value = cliente.id_cliente;
                option.textContent = `${cliente.nombre_y_apellido} - DNI: ${cliente.dni}`;
                selectClientes.appendChild(option);
            });
        })
        .catch(error => console.error('Error:', error));
}

// Add this line to ensure the initial state is correct when the page loads
document.addEventListener('DOMContentLoaded', toggleClientesCorrientes);
</script>
@endsection
