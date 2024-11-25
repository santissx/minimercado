@extends('layouts.nav')

@section('title', 'Promocion')

@section('ladoizq')

<div class="row h-100">
    <div class="col-lg-8 d-flex flex-column">
        <div class="card mb-3 flex-grow-1 left-table position-relative">
            <div class="card-body d-flex flex-column">
                <h5 class="card-title">Promociones</h5>
                <div class="table-responsive flex-grow-1">
                    <table class="table table-dark table-striped">
                        <thead>
                            <tr>
                                <th>id</th>
                                <th>nombre</th>
                                <th>descripción</th>
                                <th>estado</th>
                                <th>fecha inicio</th>
                                <th>fecha fin</th>
                                <th>monto</th>
                                <th style="text-align: center">acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            @foreach ($promociones as $promocion)
                            <tr>
                                <td>{{ $promocion->id_promocion }}</td>
                                <td>{{ $promocion->nombre }}</td>
                                <td>{{ $promocion->descripcion }}</td>
                                <td>{{ $promocion->estado == 1 ? 'Activa' : 'Inactiva' }}</td>
                                <td>{{ $promocion->fecha_inicio }}</td>
                                <td>{{ $promocion->fecha_fin }}</td>
                                <td>{{ $promocion->descuento }}</td>
                                <td class="d-flex justify-content-center align-items-center gap-2">
                                   <!-- Botón para abrir el modal y pasar los datos de la promoción -->
                                   <button class="btn btn-primary" 
                                   data-bs-toggle="modal" 
                                   data-bs-target="#vermodificarpromos"
                                   data-id="{{ $promocion->id_promocion }}"
                                   data-nombre="{{ $promocion->nombre }}"
                                   data-descripcion="{{ $promocion->descripcion }}"
                                   data-fecha_inicio="{{ $promocion->fecha_inicio }}"
                                   data-fecha_fin="{{ $promocion->fecha_fin }}"
                                   data-descuento="{{ $promocion->descuento }}"
                                   data-estado="{{ $promocion->estado == 1 ? 'Activa' : 'Inactiva' }}">
                                   Modificar
                                    </button>

                                    <form class="m-0 d-flex" action="{{route('promociones.borrar' , ['id_promocion' => $promocion->id_promocion])}}" method="POST">
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
                    <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#veragregarpromos">Agregar promoción</button>
                </div>
            </div>
        </div>
    </div>

    <div class="col-lg-4 right-column">
        @include('parciales.columna_derecha')
    </div>
</div>
@endsection

<!-- Modal agregar de gastos -->
<div class="modal fade " id="veragregarpromos" tabindex="-1" aria-labelledby="veragregarpromosLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg ">
        <div class="modal-content bg-dark">
            <form action="{{route ('promociones.agregar')}}" method="POST">
                @csrf 

                <div class="modal-header">
                    <h5 class="modal-title" id="veragregarLabel">Agregar Promos</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <!-- Campos para agregar promociones -->
                    <div class="mb-3">
                        <label for="nombre" class="form-label">Nombre</label>
                        <input type="text" class="form-control" id="nombre" name="nombre" required>
                    </div>
                    <div class="mb-3">
                        <label for="descripcion" class="form-label">Descripcion</label>
                        <input type="text" class="form-control" id="descripcion" name="descripcion" required>
                    </div>
                    <div class="mb-3">
                        <label for="fecha_inicio" class="form-label">Fecha inicio</label>
                        <input type="Date" class="form-control" id="fecha_inicio" name="fecha_inicio" required>
                    </div>
                    <div class="mb-3">
                        <label for="fecha_fin" class="form-label">Fecha fin</label>
                        <input type="Date" class="form-control" id="fecha_fin" name="fecha_fin" required>
                    </div>
                    <div class="mb-3">
                        <label for="descuento" class="form-label">Descuento</label>
                        <input type="number" class="form-control" id="descuento" name="descuento" required>
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
<div class="modal fade" id="vermodificarpromos" tabindex="-1" aria-labelledby="vermodificarpromosLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content bg-dark">
            <form action="{{ route('promociones.modificar') }}" method="GET">
               
                @csrf  
                <input type="text" id="modal_id_promocion" name="modal_id_promocion">
                <div class="modal-header">
                    <h5 class="modal-title" id="vermodificarLabel">Modificar Promocion</h5>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="modal_nombre" class="form-label">Nombre</label>
                        <input type="text" class="form-control" id="modal_nombre" name="modal_nombre" required>
                    </div>
                    <div class="mb-3">
                        <label for="modal_descripcion" class="form-label">Descripcion</label>
                        <input type="text" class="form-control" id="modal_descripcion" name="modal_descripcion" required>
                    </div>
                    <div class="mb-3">
                        <label for="modal_fecha_inicio" class="form-label">Fecha inicio</label>
                        <input type="date" class="form-control" id="modal_fecha_inicio" name="modal_fecha_inicio" required>
                    </div>
                    <div class="mb-3">
                        <label for="modal_fecha_fin" class="form-label">Fecha fin</label>
                        <input type="date" class="form-control" id="modal_fecha_fin" name="modal_fecha_fin" required>
                    </div>
                    <div class="mb-3">
                        <label for="modal_descuento" class="form-label">Descuento</label>
                        <input type="number" class="form-control" id="modal_descuento" name="modal_descuento" required>
                    </div>
                    <div class="mb-3">
                        <label for="modal_estado" class="form-label">Estado</label>
                        <select class="form-select" id="modal_estado" name="modal_estado" required>
                            <option value="1">Activa</option>
                            <option value="0">Inactiva</option>
                        </select>
                    </div>
                   
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary">Modificar Promoción</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        const vermodificarpromosModal = document.getElementById('vermodificarpromos');
        vermodificarpromosModal.addEventListener('show.bs.modal', function (event) {
            const button = event.relatedTarget;
    
            const id = button.getAttribute('data-id');
            const nombre = button.getAttribute('data-nombre');
            const descripcion = button.getAttribute('data-descripcion');
            const fecha_inicio = button.getAttribute('data-fecha_inicio');
            const fecha_fin = button.getAttribute('data-fecha_fin');
            const descuento = button.getAttribute('data-descuento');
            const estado = button.getAttribute('data-estado');
    
            vermodificarpromosModal.querySelector('#modal_id_promocion').value = id;
            vermodificarpromosModal.querySelector('#modal_nombre').value = nombre;
            vermodificarpromosModal.querySelector('#modal_descripcion').value = descripcion;
            vermodificarpromosModal.querySelector('#modal_fecha_inicio').value = fecha_inicio;
            vermodificarpromosModal.querySelector('#modal_fecha_fin').value = fecha_fin;
            vermodificarpromosModal.querySelector('#modal_descuento').value = descuento;
            vermodificarpromosModal.querySelector('#modal_estado').value = estado === 'Activa' ? 1 : 0;
        });
    });
</script>