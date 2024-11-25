
@extends('layouts.nav')

@section('title', 'Venta')

@section('ladoizq')
<form >
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
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                    <div class="action-buttons">
                        <!--  <button type="button" class="btn btn-light me-2">Abrir caja</button>
                        <button type="button" class="btn btn-danger me-2">Cerrar caja</button> -->
                        <button type="button" class="btn btn-primary me-2" data-bs-toggle="modal" data-bs-target="#buscarProductoModal">
                            Agregar Producto
                        </button>
                        <button type="button" class="btn btn-primary me-2" data-bs-toggle="modal" data-bs-target="#buscarPromocionModal">
                            Agregar Promoción
                        </button>
                        <button type="submit" class="btn btn-success">Guardar venta</button>
                    </div>
                </div>
            </div>

            <!-- Cuadro de Ventas Totales -->
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Ventas Totales</h5>
                    <select class="form-select mb-3" name="metodo_pago">
                        <option selected>Método de pago</option>
                        <!-- Opciones de método de pago -->
                    </select>
                    <div class="d-flex justify-content-between mb-2">
                        <label for="descuento" class="me-2">Descuento:</label>
                        <input type="number" id="descuento" name="descuento_manual" class="form-control w-25" placeholder="$0.00" step="0.01" min="0">
                    </div>
                    <div class="d-flex justify-content-between mb-2">
                        <span>Descuento:</span>
                        <span>$...</span>
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


<!-- Modal para buscar promociones -->
<div class="modal fade" id="buscarPromocionModal" tabindex="-1" aria-labelledby="buscarPromocionModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content bg-dark">
            <div class="modal-header">
                <h5 class="modal-title" id="buscarPromocionModalLabel">Buscar Promoción</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <input type="text" id="buscarPromocionInput" class="form-control" placeholder="Buscar por nombre o código...">
                <table class="table table-dark table-striped mt-3">
                    <thead>
                        <tr>
                            <th>Nombre</th>
                            <th>Descripcion</th>
                            <th>Descuento</th>

                        </tr>
                    </thead>
                    <tbody id="resultadosPromociones">
                        <!-- Aquí se mostrarán los resultados -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>


<script>
    document.getElementById('buscarProducto').addEventListener('input', function() {
    const query = this.value;

    // Realizar la solicitud AJAX
    fetch(`/productos/buscar?q=${query}`)
        .then(response => response.json())
        .then(data => {
            const resultados = document.getElementById('resultadoProductos');
            resultados.innerHTML = ''; // Limpiar resultados anteriores

            // Renderizar resultados
            data.forEach(producto => {
                const fila = document.createElement('tr');
                fila.innerHTML = `
                    <td>${producto.id_producto}</td>
                    <td>${producto.nombre}</td>
                    <td>${producto.stock}</td>
                    <td>$${producto.precio_venta}</td>
                    <td>
                        <button type="button" class="btn btn-success btn-sm" onclick="agregarProducto(${producto.id_producto}, '${producto.nombre}', ${producto.precio_venta})">
                            Agregar
                        </button>
                    </td>
                `;
                resultados.appendChild(fila);
            });
        });
});

function agregarProducto(id, nombre, precio_venta) {
    const tablaBody = document.querySelector('table tbody');
    const fila = document.createElement('tr');
    
    fila.innerHTML = `
        <td>${id}</td>
        <td>${nombre}</td>
        <td><input type="number" class="form-control cantidad" value="1" min="1" data-precio="${precio_venta}" onchange="actualizarTotal(this)"></td>
        <td>$${precio_venta.toFixed(2)}</td>
        <td class="precio-total">$${precio_venta.toFixed(2)}</td>
    `;
    
    tablaBody.appendChild(fila);
    calcularTotalVenta();  // Recalcular el total de la venta
}

function actualizarTotal(input) {
    const cantidad = parseInt(input.value, 10) || 0;
    const precioUnitario = parseFloat(input.getAttribute('data-precio')) || 0;
    const precioTotal = cantidad * precioUnitario;

    // Actualizar el precio total de la fila
    const fila = input.closest('tr');
    fila.querySelector('.precio-total').textContent = `$${precioTotal.toFixed(2)}`;

    calcularTotalVenta(); // Recalcular el total de la venta
}

function calcularTotalVenta() {
    let total = 0;
    let descuentoTotal = 0;

    // Iterar sobre las celdas con la clase 'precio-total'
    document.querySelectorAll('.precio-total').forEach(celda => {
        const precio = parseFloat(celda.textContent.replace('$', '').replace('%', '')) || 0; // Convierte el texto a número
        
        // Si la celda contiene un signo de porcentaje, es una promoción que representa un monto de descuento
        if (celda.textContent.includes('$')) {
            descuentoTotal += precio;  // Sumar el monto de descuento
        } else {
            total += precio;  // Sumar el precio normal del producto
        }
    });

    // Aplicar el descuento total al precio total
    total = total - descuentoTotal; // Resta el monto total de descuento

    // Actualizar el total general en la interfaz
    document.querySelector('#totalVenta').textContent = `$${total.toFixed(2)}`;
}
</script>



 <!-- script de buscar producto -->
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
                            <button class="btn btn-success btn-sm agregar-producto" data-id="${producto.id}">
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
        const codigo_barra = fila.cells[0].textContent.trim();
        const nombre = fila.cells[1].textContent.trim();
        const precio = parseFloat(fila.cells[2].textContent.trim()); // Asegúrate de convertir a número

        // Añadir producto a la tabla de ventas
        const tablaVentas = document.querySelector('.table tbody');
        const nuevaFila = document.createElement('tr');
        nuevaFila.innerHTML = `
            <td>${codigo_barra}</td>
            <td>${nombre}</td>
            <td><input type="number" value="1" min="1" class="form-control cantidad" data-precio="${precio}" onchange="actualizarTotal(this)"></td>
            <td>$${precio.toFixed(2)}</td>
            <td class="precio-total">$${precio.toFixed(2)}</td>
        `;
        tablaVentas.appendChild(nuevaFila);

        // Cierra el modal
        const modal = bootstrap.Modal.getInstance(document.getElementById('buscarProductoModal'));
        modal.hide();
    }
});
</script>

<!-- script para modal de agregar promocion -->
<script>
    // Buscar promociones al escribir en el input
    document.getElementById('buscarPromocionInput').addEventListener('input', function () {
    const termino = this.value;

    if (termino.length > 1) {
        fetch(`/buscar-promociones?q=${encodeURIComponent(termino)}`)
            .then(response => response.json())
            .then(data => {
                console.log(data);  // Añade este console log para verificar los datos recibidos

                const resultados = document.getElementById('resultadosPromociones');
                resultados.innerHTML = ''; // Limpia los resultados previos

                // Verifica si se encontraron promociones
                if (data.length === 0) {
                    resultados.innerHTML = '<tr><td colspan="4">No se encontraron promociones.</td></tr>';
                } else {
                    data.forEach(promocion => {
                        const fila = document.createElement('tr');
                        fila.innerHTML = `
                            <td>${promocion.nombre}</td>
                            <td>${promocion.descripcion}</td>
                            <td>${promocion.descuento}%</td>
                            <td>
                                <button class="btn btn-success btn-sm agregar-promocion" data-id="${promocion.id_promocion}">
                                    Agregar
                                </button>
                            </td>
                        `;
                        resultados.appendChild(fila);
                    });
                }
            })
            .catch(error => {
                console.error('Error en la búsqueda de promociones:', error);
                alert('Hubo un error al buscar promociones');
            });
    }
});
// Capturar evento de agregar promoción
document.addEventListener('click', function (e) {
    if (e.target.classList.contains('agregar-promocion')) {
        const fila = e.target.closest('tr');
        const nombre = fila.cells[1].textContent.trim();
        const descuento = parseFloat(fila.cells[2].textContent.trim()); // Asegúrate de convertir a número

        // Añadir promoción a la tabla de ventas
        const tablaVentas = document.querySelector('.table tbody');
        const nuevaFila = document.createElement('tr');
        nuevaFila.innerHTML = `
            <td>Promoción</td>
            <td>${nombre}</td>
            <td>1</td> <!-- La cantidad de la promoción siempre es 1 -->
            <td>--</td> <!-- No se necesita precio unitario -->
            <td class="precio-total">-${descuento}%</td> <!-- Aplicar descuento directo -->
        `;
        tablaVentas.appendChild(nuevaFila);

        // Cierra el modal
        const modal = bootstrap.Modal.getInstance(document.getElementById('buscarPromocionModal'));
        modal.hide();

        // Recalcular el total de la venta con el descuento
        calcularTotalVenta();
    }
});
</script>
@endsection



