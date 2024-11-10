
@extends('layouts.nav')

@section('title', 'Historial')

@section('ladoizq')
<div class="row h-100">
    <div class="col-lg-8 d-flex flex-column">
        <!-- Cuadro de historial -->
        <div class="card mb-3 flex-grow-1 left-table position-relative">
            <div class="card-body d-flex flex-column">
                <h5 class="card-title">Historial de gastos</h5>
                <div class="table-responsive flex-grow-1">
                    <table class="table table-dark table-striped">
                        <thead>
                            <tr>
                                <th>id</th>
                                <th>descripción</th>
                                <th>monto</th>
                                <th>fecha</th>
                                <th>proveedor</th>
                                <th>usuario</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Aquí irían las filas de productos -->
                        </tbody>
                    </table>
                </div>
                <div class="action-buttons">   
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#vermodifgastos">Modificar Gastos </button>
                    <button class="btn btn-danger me-2">Anular gasto</button>
                    <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#veragregargastos">Agregar Gastos</button>
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

<!-- Modal agregar de gastos -->
<div class="modal fade " id="veragregargastos" tabindex="-1" aria-labelledby="veragregargastosLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg ">
        <div class="modal-content bg-dark">
            <form >
                @csrf 
                <div class="modal-header">
                    <h5 class="modal-title" id="veragregarLabel">Agregar Gasto</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <!-- Campos para agregar productos -->
                    <div class="mb-3">
                        <label for="id" class="form-label">id gasto</label>
                        <input type="number" class="form-control" id="id" name="id" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="descripcion" class="form-label">Descripcion</label>
                        <input type="text" class="form-control" id="descripcion" name="descripcion" required>
                    </div>
                    <div class="mb-3">
                        <label for="monto" class="form-label">Monto</label>
                        <input type="number" class="form-control" id="monto" name="monto" required>
                    </div>
                    <div class="mb-3">
                        <label for="Fecha" class="form-label">Fecha</label>
                        <input type="Date" class="form-control" id="Fecha" name="Fecha" required>
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
                        <label for="id_usuario" class="form-label">Usuario</label>
                        <input type="number" class="form-control" id="id_usuario" name="id_usuario" readonly>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-success">Agregar Gastos</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                </div>
            </form>
        </div>
    </div>
</div>


<!-- Modal modificar gastos -->

<div class="modal fade " id="vermodifgastos" tabindex="-1" aria-labelledby="vermodifgastosLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg ">
        <div class="modal-content bg-dark">
            <form >
                @csrf 
                <div class="modal-header">
                    <h5 class="modal-title" id="vermodifLabel">Modificar Gasto</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <!-- Campos para modificar productos -->
                    <div class="mb-3">
                        <label for="id" class="form-label">id gasto</label>
                        <input type="numbre" class="form-control" id="id" name="id" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="descripcion" class="form-label">Descripcion</label>
                        <input type="text" class="form-control" id="descripcion" name="descripcion" required>
                    </div>
                    <div class="mb-3">
                        <label for="monto" class="form-label">Monto</label>
                        <input type="number" class="form-control" id="monto" name="monto" required>
                    </div>
                    <div class="mb-3">
                        <label for="Fecha" class="form-label">Fecha</label>
                        <input type="Date" class="form-control" id="Fecha" name="Fecha" required>
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
                        <label for="id_usuario" class="form-label">Usuario</label>
                        <input type="number" class="form-control" id="id_usuario" name="id_usuario" readonly>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary">Modificar Gasto</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                </div>
            </form>
        </div>
    </div>
</div>