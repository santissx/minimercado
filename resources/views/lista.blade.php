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
                                <th>Precio</th>
                                <th>Proveedor</th>
                                <th>Stock</th>
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
                                <td>{{ $producto->precio }}</td>
                                <td>{{ $producto->id_proveedor }}</td>
                                <td>{{ $producto->stock }}</td>
                                <td class="d-flex justify-content-center align-items-center gap-2">
                                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#vermodificarproduc" data-id="{{ $producto->id_producto }}" onclick="document.getElementById('modal_id_producto').value = {{ $producto->id_producto }}">Modificar producto</button>
                                    <form class="m-0 d-flex" action="{{route('lista.borrar' , ['id_producto' => $producto->id_producto])}}" method="POST">
                                        @csrf
                                        @method('DELETE')
                                        <button type="submit" class="btn btn-danger ">Eliminar promo</button>
                                    </form>
                                </td>
                            </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>
                <div class="action-buttons">
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
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
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
                        <label for="precio" class="form-label">Precio</label>
                        <input type="number" class="form-control" id="precio" name="precio" step="0.01" min="0" required>
                    </div>
                    <div class="mb-3">
                        <label for="id_proveedor" class="form-label">Proveedor</label>
                        
                            <input type="number" class="form-control" id="id_proveedor" name="id_proveedor" min="0" required>
                            
                    </select>
                    </div>
                    <div class="mb-3">
                        <label for="stock" class="form-label">Stock</label>
                        <input type="number" class="form-control" id="stock" name="stock" min="0" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-success">Agregar Promoción</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                </div>
            </form>
        </div>
    </div>
</div>



<!-- Modal modificar -->
<div class="modal fade" id="vermodificarproduc" tabindex="-1" aria-labelledby="vermodificarproducLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content bg-dark">
            <form action="{{ route('lista.modificar') }}" method="GET">
               
                @csrf  
                <input type="text" name="id_producto" id="modal_id_producto">
                <div class="modal-header">
                    <h5 class="modal-title" id="vermodificarLabel">Modificar Promocion</h5>
                </div>
                <div class="modal-header">
                    <h5 class="modal-title" id="verlistaLabel">Agregar Producto</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
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
                        <label for="precio" class="form-label">Precio</label>
                        <input type="number" class="form-control" id="precio" name="precio" step="0.01" min="0" required>
                    </div>
                    <div class="mb-3">
                        <label for="id_proveedor" class="form-label">Proveedor</label>
                        
                            <input type="number" class="form-control" id="id_proveedor" name="id_proveedor" min="0" required>
                            
                    </select>
                    </div>
                    <div class="mb-3">
                        <label for="stock" class="form-label">Stock</label>
                        <input type="number" class="form-control" id="stock" name="stock" min="0" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-success">Agregar Promoción</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                </div>
            </form>
        </div>
    </div>
</div>
