
@extends('layouts.nav')

@section('title', 'Clientes')

@section('ladoizq')
<div class="row h-100">
    <div class="col-lg-8 d-flex flex-column">
        <!-- Cuadro de historial -->
        <div class="card mb-3 flex-grow-1 left-table position-relative">
            <div class="card-body d-flex flex-column">
                <h5 class="card-title">Clientes</h5>
                <div class="table-responsive flex-grow-1 table-scrollgr" >
                    <table class="table table-dark table-striped">
                        <thead>
                            <tr>
                                <th>id</th>
                                <th>nombre y apellido</th>
                                <th>dni</th>
                                <th>telefono</th>
                                <th>Estado</th>
                                <th class="text-center">Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            @foreach ($clientes as $cliente)
                            <tr>
                                <td>{{ $cliente->id_cliente }}</td>
                                <td>{{ $cliente->nombre_y_apellido }}</td>
                                <td>{{ $cliente->DNI }}</td>
                                <td>{{ $cliente->telefono }}</td>
                                <td>{{ $cliente->estado }}</td>
                                <td class="d-flex justify-content-center align-items-center gap-2">
                                    <button class="btn btn-primary" 
                                    data-bs-toggle="modal" 
                                    data-bs-target="#vermodificarcliente"
                                    data-id="{{ $cliente->id_cliente }}"
                                    data-nombre_y_apellido="{{ $cliente->nombre_y_apellido }}"
                                    data-dni="{{ $cliente->DNI }}"
                                    data-telefono="{{ $cliente->telefono }}"
                                    data-estado="{{ $cliente->estado }}">
                                    Modificar
                                    </button>
                                    <form class="m-0 d-flex" action="{{route('clientes.borrar' , ['id_cliente' => $cliente->id_cliente])}}" method="POST">
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
                    <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#veragregarcliente">Agregar Cliente</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Columna derecha superior -->
    <div class="col-lg-4 right-column">
        @include('parciales.columna_derecha')
    </div>

    
</div>



<!-- Modal agregar cliente -->
<div class="modal fade" id="veragregarcliente" tabindex="-1" aria-labelledby="veragregarclienteLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content bg-dark">
            <form action="{{ route('clientes.agregar') }}" method="POST">
                @csrf
                <div class="modal-header">
                    <h5 class="modal-title" id="veragregarclienteLabel">Agregar cliente</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="nombre_y_apellido" class="form-label">Nombre y apellido</label>
                        <input type="text" class="form-control" id="nombre_y_apellido" name="nombre_y_apellido" required>
                    </div>
                    <div class="mb-3">
                        <label for="dni" class="form-label">dni</label>
                        <input type="int" class="form-control" id="dni" name="dni" required>
                    </div>
                    <div class="mb-3">
                        <label for="telefono" class="form-label">telefono</label>
                        <input type="int" class="form-control" id="telefono" name="telefono" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-success">Agregar cliente</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Modal modificar usuario -->
<div class="modal fade" id="vermodificarcliente" tabindex="-1" aria-labelledby="vermodificarclienteLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content bg-dark">
            <form action="{{ route('clientes.modificar') }}" method="GET">
                @csrf
                <input type="hidden" name="modal_id_cliente" id="modal_id_cliente">
                <div class="modal-header">
                    <h5 class="modal-title" id="vermodificarLabel">Modificar Usuario</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="nombre_y_apellido" class="form-label">Nombre y apellido</label>
                        <input type="text" class="form-control" id="nombre_y_apellido" name="nombre_y_apellido" required>
                    </div>
                    <div class="mb-3">
                        <label for="dni" class="form-label">DNI</label>
                        <input type="text" class="form-control" id="dni" name="dni" required>
                    </div>
                    <div class="mb-3">
                        <label for="telefono" class="form-label">Teléfono</label>
                        <input type="text" class="form-control" id="telefono" name="telefono" required>
                    </div>
                </div>
                <div class="mb-3">
                    <label for="estado" class="form-label">Estado</label>
                    <select name="estado" id='estado'>
                        <option value="activo">Activo</option>
                        <option value="desactivado" >Desactivado</option>
                      </select>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary">Modificar cliente</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                </div>
            </form>
        </div>
    </div>
</div>




<script>
    document.addEventListener('DOMContentLoaded', function () {
        const modificarclienteModal = document.getElementById('vermodificarcliente');
        modificarclienteModal.addEventListener('show.bs.modal', function (event) {
            const button = event.relatedTarget;
            const id = button.getAttribute('data-id');
            const nombre_y_apellido = button.getAttribute('data-nombre_y_apellido');
            const dni = button.getAttribute('data-dni');
            const telefono = button.getAttribute('data-telefono');
            const estado = button.getAttribute('data-estado');
            modificarclienteModal.querySelector('#modal_id_cliente').value = id;
            modificarclienteModal.querySelector('#nombre_y_apellido').value = nombre_y_apellido;
            modificarclienteModal.querySelector('#dni').value = dni;
            modificarclienteModal.querySelector('#telefono').value = telefono;
            modificarclienteModal.querySelector('#estado').value = estado;
        });
    });
    </script>
@endsection 
