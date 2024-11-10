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
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Aquí irían las filas de productos -->
                        </tbody>
                    </table>
                </div>
                <div class="action-buttons">
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modificarModal">Modificar Producto</button>
                    <button class="btn btn-danger me-2" >Eliminar Producto</button>
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
            <form >
                @csrf 
                <div class="modal-header">
                    <h5 class="modal-title" id="verlistaLabel">Agregar Producto</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
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
                        <label for="precio" class="form-label">Precio</label>
                        <input type="number" class="form-control" id="precio" name="precio" step="0.01" min="0" required>
                    </div>
                    <div class="mb-3">
                        <label for="proveedor" class="form-label">Proveedor</label>
                        <select class="form-select" id="proveedor" name="proveedor" required>
                            <option value="" selected disabled>Seleccione un proveedor</option>
                        {{--
                            @foreach($proveedores as $proveedor) 
                           <option value="{{ $proveedor->id }}">{{ $proveedor->nombre }}</option>
                            @endforeach
                            
                        --}}
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

<!-- Modal modificiar -->
<div class="modal fade" id="modificarModal" tabindex="-1" aria-labelledby="vermodificarLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content bg-dark">
            <form >
                @csrf 
                <div class="modal-header">
                    <h5 class="modal-title" id="verlistaLabel">Modificar Producto</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
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
                        <label for="precio" class="form-label">Precio</label>
                        <input type="number" class="form-control" id="precio" name="precio" step="0.01" min="0" required>
                    </div>
                    <div class="mb-3">
                        <label for="proveedor" class="form-label">Proveedor</label>
                        <select class="form-select" id="proveedor" name="proveedor" required>
                            <option value="" selected disabled>Seleccione un proveedor</option>
                        {{--
                            @foreach($proveedores as $proveedor) 
                           <option value="{{ $proveedor->id }}">{{ $proveedor->nombre }}</option>
                            @endforeach
                        --}}
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