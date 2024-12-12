
@extends('layouts.nav')

@section('title', 'Gastos')

@section('ladoizq')
<div class="row h-100">
    <div class="col-lg-8 d-flex flex-column">
        <!-- Cuadro de historial -->
        <div class="card mb-3 flex-grow-1 left-table position-relative">
            <div class="card-body d-flex flex-column">
                <h5 class="card-title">Historial de gastos</h5>
                <div class="table-responsive flex-grow-1 table-scrollgr">
                    <table class="table table-dark table-striped">
                        <thead>
                            <tr>
                                <th>id</th>
                                <th>Motivo</th>
                                <th>descripción</th>
                                <th>monto</th>
                                <th>fecha</th>
                                <th>categoria</th>
                                <th>usuario</th>
                                <th style="text-align: center">acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            @foreach ($gastos as $gasto)
                            <tr>
                                <td>{{ $gasto->id_gasto }}</td>
                                <td>{{ $gasto->motivo }}</td>
                                <td>{{ $gasto->descripcion }}</td>
                                <td>{{ $gasto->monto }}</td>
                                <td>{{ $gasto->fecha_gasto }}</td>
                                <td>{{ $gasto->categoria }}</td>
                                <td>{{ $gasto->id_usuario }} - {{ $gasto->nombre_usuario }}</td>
                                <td class="d-flex justify-content-center align-items-center gap-2">
                                    <button class="btn btn-primary" 
                                    data-bs-toggle="modal" 
                                    data-bs-target="#vermodificargastos"
                                    data-id="{{ $gasto->id_gasto }}"
                                    data-motivo="{{ $gasto->motivo }}"
                                    data-descripcion="{{ $gasto->descripcion }}"
                                    data-monto="{{ $gasto->monto }}"
                                    data-fecha_gasto="{{ $gasto->fecha_gasto }}"
                                    data-categoria="{{ $gasto->categoria }}">
                                    Modificar
                                    </button>
                                    <form class="m-0 d-flex" action="{{route('gastos.borrar' , ['id_gasto' => $gasto->id_gasto])}}" method="POST">
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
            </div>
            <div class="action-buttons mt-3">   
                <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#veragregargastos">Agregar Gastos</button>
            </div>
        </div>
       
        <strong> <label for="totalcompras" >Gastos totales: ${{ number_format($totalgastos, 2) }}</label>  </strong>
    </div>

    <!-- Columna derecha superior -->
    <div class="col-lg-4 right-column">
        @include('parciales.columna_derecha')
    </div>

    
</div>




<!-- Modal agregar de gastos -->
<div class="modal fade" id="veragregargastos" tabindex="-1" aria-labelledby="veragregargastosLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content bg-dark">
            <form action="{{ route('gastos.agregar') }}" method="POST">
                @csrf 
                <div class="modal-header">
                    <h5 class="modal-title" id="veragregarLabel">Agregar Gasto</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <!-- Campos para agregar productos -->
                   
                    <div class="mb-3">
                        <label for="motivo" class="form-label">Motivo</label>
                        <input type="text" class="form-control" id="motivo" name="motivo" >
                    </div>
                    <div class="mb-3">
                        <label for="descripcion" class="form-label">Descripción</label>
                        <input type="text" class="form-control" id="descripcion" name="descripcion" required>
                    </div>
                    <div class="mb-3">
                        <label for="monto" class="form-label">Monto</label>
                        <input type="number" class="form-control" id="monto" name="monto"  step="0.01" required>
                    </div>
                    
                    <div class="mb-3">
                        <label for="categoria" class="form-label">Categoria</label>
                        <select class="form-control" id="categoria" name="categoria" required>
                            <option value="administrativo">Administrativo</option>
                            <option value="logistico">Logístico</option>
                            <option value="cotidiano">Cotidiano</option>
                            <option value="deudas">Deudas</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="id_usuario" class="form-label">Usuario</label>
                        <input type="number" class="form-control" id="id_usuario" name="id_usuario" value="{{ auth()->id() }}" readonly>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-success">Agregar Gasto</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                </div>
            </form>
        </div>
    </div>
</div>



<!-- Modal modificar gastos -->
<div class="modal fade" id="vermodificargastos" tabindex="-1" aria-labelledby="vermodificargastosLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content bg-dark">
            <form action="{{ route('gastos.modificar') }}" method="GET">
                @csrf
               
                <input type="hidden" name="id_gasto" id="modal_id_gasto">
                <div class="modal-header">
                    <h5 class="modal-title" id="vermodifgastosLabel">modificar Gasto</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="motivo" class="form-label">Motivo</label>
                        <input type="text" class="form-control" id="motivo" name="motivo" >
                    </div>
                    <div class="mb-3">
                        <label for="descripcion" class="form-label">Descripción</label>
                        <input type="text" class="form-control" id="descripcion" name="descripcion" required>
                    </div>
                    <div class="mb-3">
                        <label for="monto" class="form-label">Monto</label>
                        <input type="number" class="form-control" id="monto" name="monto"  step="0.01" required>
                    </div>
                    <div class="mb-3">
                        <label for="categoria" class="form-label">Categoria</label>
                        <select class="form-control" id="categoria" name="categoria" required>
                            <option value="administrativo">Administrativo</option>
                            <option value="logistico">Logístico</option>
                            <option value="cotidiano">Cotidiano</option>
                            <option value="deudas">Deudas</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-success">Modificar Gasto</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                </div>
            </form>
        </div>
    </div>
</div>



<script>
    document.addEventListener('DOMContentLoaded', function () {
        const modificargastosModal = document.getElementById('vermodificargastos');
        modificargastosModal.addEventListener('show.bs.modal', function (event) {
            const button = event.relatedTarget;
    
            const id = button.getAttribute('data-id');
            const descripcion = button.getAttribute('data-descripcion');
            const monto = button.getAttribute('data-monto');
            const categoria = button.getAttribute('data-categoria');
            const motivo = button.getAttribute('data-motivo');
            modificargastosModal.querySelector('#modal_id_gasto').value = id;
            modificargastosModal.querySelector('#descripcion').value = descripcion;
            modificargastosModal.querySelector('#monto').value = monto;
            modificargastosModal.querySelector('#categoria').value = categoria;
            modificargastosModal.querySelector('#motivo').value = motivo;
        });
    });
    </script>
@endsection 


