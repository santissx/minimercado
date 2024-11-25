@extends('layouts.nav')

@section('title', 'Lista')

@section('ladoizq')
<div class="row h-100">
    <div class="col-lg-8 d-flex flex-column">
        <!-- Cuadro de promociones -->
        <div class="card mb-3 flex-grow-1 left-table position-relative">
            <div class="card-body d-flex flex-column">
                <h5 class="card-title">Lista de Productos</h5>
                <div class="table-responsive flex-grow-1">
                    <table class="table table-dark table-striped">
                        <thead>
                            <tr>
                                <th>id</th>
                                <th>Nombre</th>
                                <th>Codigo</th>
                                <th>Codigo de barra</th>
                                <th>Precio lista</th>
                                <th>Precio venta</th>
                                <th>Stock</th>
                                <th>Proveedor</th>
                                <th>Categoria</th>
                                <th style="text-align: center">acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            @foreach ($productos as $producto)
                            <tr>
                                <td>{{ $producto->id_producto }}</td>
                                <td>{{ $producto->nombre }}</td>
                                <td>{{ $producto->codigo }}</td>
                                <td>{{ $producto->codigo_barra }}</td>
                                <td>{{ $producto->precio_lista }}</td>
                                <td>{{ $producto->precio_venta }}</td>
                                <td>{{ $producto->stock }}</td>
                                <td>{{ $producto->id_proveedor }} - {{ $producto->nombre_proveedor }}</td>
                                <td>{{ $producto->id_categoria }} - {{ $producto->categoria }}</td>
                                <td class="d-flex justify-content-center align-items-center gap-2 ">
                                    <button class="btn btn-primary" 
                                    data-bs-toggle="modal" 
                                    data-bs-target="#vermodificarproducModal"
                                    data-id="{{ $producto->id_producto }}"
                                    data-nombre="{{ $producto->nombre }}"
                                    data-codigo="{{ $producto->codigo }}"
                                    data-codigo_barra="{{ $producto->codigo_barra }}"
                                    data-precio_lista="{{ $producto->precio_lista }}"
                                    data-precio_venta="{{ $producto->precio_venta }}"
                                    data-stock="{{ $producto->stock }}"
                                    data-id_proveedor="{{ $producto->id_proveedor }}"
                                    data-id_categoria="{{ $producto->id_categoria }}">
                                    Modificar
                                   </button>
                                    <form class="m-0 d-flex" action="{{route('lista.borrar' , ['id_producto' => $producto->id_producto])}}" method="POST">
                                        @csrf
                                        @method('DELETE')
                                        <button type="submit" class="btn btn-danger ">Eliminar</button>
                                    </form>
                                </td>
                            </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>
                <div class="action-buttons">
                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#aumentarPreciosventaModal">
                        Aumentar precios de venta por proveedor
                    </button>
                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#aumentarPrecioslistaModal">
                        Aumentar precios de lista por proveedor
                    </button>
                    <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#agregarModal">Agregar Producto</button>
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


<!-- Modal agregar -->
<div class="modal fade" id="agregarModal" tabindex="-1" aria-labelledby="veragregarLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content bg-dark">
            <form action="{{route ('lista.agregar')}}" method="POST">
                @csrf 
                <div class="modal-header">
                    <h5 class="modal-title" id="verlistaLabel">Agregar Producto</h5>
                </div>
                <div class="modal-body">
                    <!-- Campos para agregar productos -->
                    <div class="mb-3">
                        <label for="nombre" class="form-label">Nombre</label>
                        <input type="text" class="form-control" id="nombre" name="nombre" required>
                    </div>
                    <div class="mb-3">
                        <label for="codigo" class="form-label">Código</label>
                        <input type="text" class="form-control" id="codigo" name="codigo" required>
                    </div>
                    <div class="mb-3">
                        <label for="codigo_barra" class="form-label">Código de Barra</label>
                        <input type="text" class="form-control" id="codigo_barra" name="codigo_barra" required>
                    </div>
                    <div class="mb-3">
                        <label for="precio_lista" class="form-label">Precio lista</label>
                        <input type="number" class="form-control" id="precio_lista" name="precio_lista" step="0.01" min="0" required>
                    </div>
                    <div class="mb-3">
                        <label for="precio_venta" class="form-label">Precio venta</label>
                        <input type="number" class="form-control" id="precio_venta" name="precio_venta" step="0.01" min="0" required>
                    </div>
                    <div class="mb-3">
                        <label for="id_proveedor" class="form-label">Proveedor</label>
                        <select class="form-control" id="id_proveedor" name="id_proveedor" required>
                            <option value="" disabled selected>Seleccione un proveedor</option>
                            @foreach($proveedores as $proveedor)
                                <option value="{{ $proveedor->id_proveedor }}">
                                    {{ $proveedor->id_proveedor }} - {{ $proveedor->nombre }}
                                </option>
                            @endforeach
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="id_categoria" class="form-label">categoria</label>
                        <select class="form-control" id="id_categoria" name="id_categoria" required>
                            <option value="" disabled selected>Seleccione una categoria</option>
                            @foreach($categorias as $categoria)
                                <option value="{{ $categoria->id_categoria }}">
                                    {{ $categoria->id_categoria }} - {{ $categoria->categoria }}
                                </option>
                            @endforeach
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="stock" class="form-label">Stock</label>
                        <input type="number" class="form-control" id="stock" name="stock" min="0" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-success">Guardar Producto</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Modal modificar -->
<div class="modal fade" id="vermodificarproducModal" tabindex="-1" aria-labelledby="vermodificarproducLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content bg-dark">
            <form action="{{ route('lista.modificar') }}" method="POST">
                @csrf 
                <input type="hidden" name="id_producto" id="id_producto">
                <div class="modal-header">
                    <h5 class="modal-title" id="verlistaLabel">Modificar Producto</h5>
                </div>
                <div class="modal-body">
                    <!-- Campos para modificar productos -->
                    <div class="mb-3">
                        <label for="nombre" class="form-label">Nombre</label>
                        <input type="text" class="form-control" id="nombre" name="nombre" required>
                    </div>
                    <div class="mb-3">
                        <label for="codigo" class="form-label">Código</label>
                        <input type="text" class="form-control" id="codigo" name="codigo" required>
                    </div>
                    <div class="mb-3">
                        <label for="codigo_barra" class="form-label">Código de Barra</label>
                        <input type="text" class="form-control" id="codigo_barra" name="codigo_barra" required>
                    </div>
                    <div class="mb-3">
                        <label for="precio_lista" class="form-label">Precio lista</label>
                        <input type="number" class="form-control" id="precio_lista" name="precio_lista" step="0.01" min="0" required>
                    </div>
                    <div class="mb-3">
                        <label for="precio_venta" class="form-label">Precio venta</label>
                        <input type="number" class="form-control" id="precio_venta" name="precio_venta" step="0.01" min="0" required>
                    </div>
                    <div class="mb-3">
                        <label for="id_proveedor" class="form-label">Proveedor</label>
                        <select class="form-control" id="id_proveedor" name="id_proveedor" required>
                            <option value="" disabled selected>Seleccione un proveedor</option>
                            @foreach($proveedores as $proveedor)
                                <option value="{{ $proveedor->id_proveedor }}">
                                    {{ $proveedor->id_proveedor }} - {{ $proveedor->nombre }}
                                </option>
                            @endforeach
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="id_categoria" class="form-label">categoria</label>
                        <select class="form-control" id="id_categoria" name="id_categoria" required>
                            <option value="" disabled selected>Seleccione una categoria</option>
                            @foreach($categorias as $categoria)
                                <option value="{{ $categoria->id_categoria }}">
                                    {{ $categoria->id_categoria }} - {{ $categoria->categoria }}
                                </option>
                            @endforeach
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="stock" class="form-label">Stock</label>
                        <input type="number" class="form-control" id="stock" name="stock" min="0" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary">Modificar Producto</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Modal  
// modal aumentar precio x venta-->
<div class="modal fade" id="aumentarPreciosventaModal" tabindex="-1" aria-labelledby="aumentarPreciosventaModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content bg-dark">
            <div class="modal-header">
                <h5 class="modal-title" id="aumentarPreciosventaModalLabel">Aumentar precios de venta por proveedor</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
            </div>
            <form action="{{ route('productos.aumentarPrecio') }}" method="POST">
                @csrf
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="id_proveedor" class="form-label">Proveedor</label>
                        <select class="form-select" name="id_proveedor" id="id_proveedor" required>
                            @foreach($proveedores as $proveedor)
                                <option value="{{ $proveedor->id_proveedor }}">{{ $proveedor->nombre }}</option>
                            @endforeach
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="porcentaje" class="form-label">Porcentaje de aumento (%)</label>
                        <input type="number" class="form-control" name="porcentaje" id="porcentaje" step="0.01" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                    <button type="submit" class="btn btn-primary">Aplicar</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Modal 
// modal aumentar precio x lista -->
<div class="modal fade" id="aumentarPrecioslistaModal" tabindex="-1" aria-labelledby="aumentarPrecioslistaModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content bg-dark ">
            <div class="modal-header">
                <h5 class="modal-title" id="aumentarPrecioslistaModalLabel">Aumentar precios de lista por proveedor</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
            </div>
            <form action="{{ route('productos.aumentarPreciolista') }}" method="POST">
                @csrf
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="id_proveedor" class="form-label">Proveedor</label>
                        <select class="form-select" name="id_proveedor" id="id_proveedor" required>
                            @foreach($proveedores as $proveedor)
                                <option value="{{ $proveedor->id_proveedor }}">{{ $proveedor->nombre }}</option>
                            @endforeach
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="porcentaje" class="form-label">Porcentaje de aumento (%)</label>
                        <input type="number" class="form-control" name="porcentaje" id="porcentaje" step="0.01" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                    <button type="submit" class="btn btn-primary">Aplicar</button>
                </div>
            </form>
        </div>
    </div>
</div>



<script>
    document.addEventListener('DOMContentLoaded', function () {
        const vermodificarproducModal = document.getElementById('vermodificarproducModal');
        vermodificarproducModal.addEventListener('show.bs.modal', function (event) {
            const button = event.relatedTarget;
    
            const id_producto = button.getAttribute('data-id');
            const nombre = button.getAttribute('data-nombre');
            const codigo = button.getAttribute('data-codigo');
            const codigo_barra = button.getAttribute('data-codigo_barra');
            const precio_lista = button.getAttribute('data-precio_lista');
            const precio_venta = button.getAttribute('data-precio_venta');
            const stock = button.getAttribute('data-stock');
            const id_proveedor = button.getAttribute('data-id_proveedor');
            const id_categoria = button.getAttribute('data-id_categoria');
    
            vermodificarproducModal.querySelector('#id_producto').value = id_producto;
            vermodificarproducModal.querySelector('#nombre').value = nombre;
            vermodificarproducModal.querySelector('#codigo').value = codigo;
            vermodificarproducModal.querySelector('#codigo_barra').value = codigo_barra;
            vermodificarproducModal.querySelector('#precio_lista').value = precio_lista;
            vermodificarproducModal.querySelector('#precio_venta').value = precio_venta;
            vermodificarproducModal.querySelector('#stock').value = stock;
            vermodificarproducModal.querySelector('#id_proveedor').value = id_proveedor;
            vermodificarproducModal.querySelector('#id_categoria').value = id_categoria;
        });
    });
</script>