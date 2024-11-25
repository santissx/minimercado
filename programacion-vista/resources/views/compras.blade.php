@extends('layouts.nav')

@section('title', 'Compras')

@section('ladoizq')
<div class="row h-100">
    <div class="col-lg-8 d-flex flex-column">
        <!-- Cuadro de Compras -->
        <div class="card mb-3 flex-grow-1 left-table position-relative">
            <div class="card-body d-flex flex-column">
                <h5 class="card-title">Lista de Compras</h5>
                <div class="table-responsive flex-grow-1">
                    <table class="table table-dark table-striped">
                        <thead>
                            <tr>
                                <th>ID Compra</th>
                                <th>Monto Compra</th>
                                <th>Fecha</th>
                                <th>Productos</th>
                                <th>Proveedor</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            @php $currentCompra = null; @endphp
                            @foreach($compras as $idCompra => $compraGroup)
                                @php
                                    $compra = $compraGroup->first();  // Obtener la primera compra de este grupo
                                @endphp
                                <tr>
                                    <td>{{ $compra->id_compra }}</td>
                                    <td>${{ number_format($compra->monto_compra, 2) }}</td>
                                    <td>{{ $compra->fecha }}</td>
                                    <td>
                                        <select class="onlyread styled-select">
                                            @foreach($compraGroup as $producto)
                                                <option>
                                                    {{ $producto->producto }} - Cantidad: {{ $producto->cantidad_agregada }}
                                                </option>
                                            @endforeach
                                        </select>
                                    </td>
                                    <td>{{ $compra->id_proveedor }} - {{ $compra->proveedor }}</td>
                                    <td class="d-flex justify-content-center align-items-center gap-2">
                                        <form action="{{ route('compras.eliminar', $compra->id_compra) }}" method="POST" >
                                            @csrf
                                            @method('DELETE')
                                            <button type="submit" class="btn btn-danger">Eliminar</button>
                                        </form>
                                    </td>
                                </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>
                <div class="action-buttons">
                    <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#agregarCompraModal">Agregar Compra</button>
                </div>
            </div>
        </div>
    </div>

    <div class="col-lg-4 right-column">
        @include('parciales.columna_derecha')
    </div>
</div>

<!-- Modal Agregar Compra -->
<div class="modal fade" id="agregarCompraModal" tabindex="-1" aria-labelledby="agregarCompraLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content bg-dark">
            <div class="modal-header">
                <h5 class="modal-title" id="agregarCompraLabel">Agregar Compra</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="{{ route('compras.agregar') }}" method="POST">
                    @csrf
                <div class="mb-3">
                    <label for="monto" class="form-label">Monto de la compra</label>
                    <input type="int" class="form-control" id="monto" name="monto" required>
                </div>

                <!-- Select Proveedor -->
                <div class="mb-3">
                    <label for="id_proveedor" class="form-label">Proveedor</label>
                    <select id="id_proveedor" class="form-select" name="id_proveedor" required>
                        <option value="">Seleccione un proveedor</option>
                        @foreach($proveedores as $proveedor)
                            <option value="{{ $proveedor->id_proveedor }}">{{ $proveedor->nombre }}</option>
                        @endforeach
                    </select>
                </div>

                <!-- Select Productos dependientes -->
                <div id="productosContainer">
                    <div class="row mb-3 producto-item">
                        <div class="col-7">
                            <label for="id_producto" class="form-label">Producto</label>
                            <select name="productos[0][id_producto]" class="form-select producto" required>
                                <option value="">Seleccione un producto</option>
                            </select>
                        </div>
                        <div class="col-3">
                            <label for="cantidad" class="form-label">Cantidad</label>
                            <input type="number" name="productos[0][cantidad]" class="form-control" min="1" required>
                        </div>
                        <div class="col-1 d-flex align-items-end">
                            <button type="button" class="btn btn-danger remove-producto">×</button>
                        </div>
                    </div>
                </div>

                <!-- Botón para agregar más productos -->
                <button type="button" id="addProducto" class="btn btn-primary">Agregar otro producto</button>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button type="submit" class="btn btn-success">Guardar</button>
            </div>
        </form>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', () => {
        const proveedorSelect = document.getElementById('id_proveedor');
        const productosContainer = document.getElementById('productosContainer');
        let productoCount = 1; // Contador para los productos adicionales

        // Evento para agregar otro producto
        document.getElementById('addProducto').addEventListener('click', () => {
            // Crear un nuevo item de producto
            const newProductDiv = document.createElement('div');
            newProductDiv.classList.add('row', 'mb-3', 'producto-item');

            newProductDiv.innerHTML = `
                <div class="col-7">
                    <label for="id_producto" class="form-label">Producto</label>
                    <select name="productos[${productoCount}][id_producto]" class="form-select producto" required>
                        <option value="">Seleccione un producto</option>
                    </select>
                </div>
                <div class="col-3">
                    <label for="cantidad" class="form-label">Cantidad</label>
                    <input type="number" name="productos[${productoCount}][cantidad]" class="form-control" min="1" required>
                </div>
                <div class="col-1 d-flex align-items-end">
                    <button type="button" class="btn btn-danger remove-producto">×</button>
                </div>
            `;

            productosContainer.appendChild(newProductDiv);
            productoCount++; // Incrementar el contador de productos

            // Actualizar el select de productos según el proveedor
            actualizarProductos();
        });

        // Función para actualizar el select de productos al seleccionar un proveedor
        proveedorSelect.addEventListener('change', async (event) => {
            await actualizarProductos();
        });

        // Actualizar los productos para todos los selects
        async function actualizarProductos() {
            const proveedorId = proveedorSelect.value;
            const productoSelects = document.querySelectorAll('.producto');

            if (proveedorId) {
                const response = await fetch(`/productos-por-proveedor/${proveedorId}`);
                const productos = await response.json();

                // Actualizar las opciones de todos los selects de productos
                productoSelects.forEach(select => {
                    select.innerHTML = '<option value="">Seleccione un producto</option>';
                    productos.forEach(producto => {
                        const option = document.createElement('option');
                        option.value = producto.id_producto;
                        option.textContent = producto.nombre;
                        select.appendChild(option);
                    });
                });
            } else {
                // Limpiar las opciones de productos si no se selecciona un proveedor
                productoSelects.forEach(select => {
                    select.innerHTML = '<option value="">Seleccione un producto</option>';
                });
            }
            }
        // Eliminar un producto
        productosContainer.addEventListener('click', (event) => {
            if (event.target.classList.contains('remove-producto')) {
                const productoItem = event.target.closest('.producto-item');
                productoItem.remove();
            }
        });
    });
</script>
@endsection
