@auth
@if(Auth::user()->rol === 'administrador')
@extends('layouts.nav')

@section('title', 'Usuarios')

@section('ladoizq')
<div class="row h-100">
    <div class="col-lg-8 d-flex flex-column">
        <div class="card mb-3 flex-grow-1 left-table position-relative">
            <div class="card-body d-flex flex-column">
                <h5 class="card-title">Usuarios</h5>
                <div class="table-responsive flex-grow-1">
                    <table class="table table-dark table-striped">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nombre</th>
                                <th>Email</th>
                                <th>Rol</th>
                                <th style="text-align: center">Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            @foreach ($users as $usuario)
                            <tr>
                                <td>{{ $usuario->id }}</td>
                                <td>{{ $usuario->name }}</td>
                                <td>{{ $usuario->email }}</td>
                                <td>{{ $usuario->rol }}</td>
                                <td class="d-flex justify-content-center align-items-center gap-2">
                                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#vermodificarusuario" data-id="{{ $usuario->id }}" onclick="document.getElementById('modal_id_usuario').value = {{ $usuario->id }}">Modificar</button>
                                    <form class="m-0 d-flex" action="{{route('empleados.borrar' , ['id' => $usuario->id])}}" method="POST">
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
                    <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#veragregarusuario">Agregar Usuario</button>
                </div>
            </div>
        </div>
    </div>

    <div class="col-lg-4 right-column">
        @include('parciales.columna_derecha')
    </div>
</div>
@endsection

<!-- Modal agregar usuario -->
<div class="modal fade" id="veragregarusuario" tabindex="-1" aria-labelledby="veragregarusuarioLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content bg-dark">
            <form action="{{ route('empleados.agregar') }}" method="POST">
                @csrf
                <div class="modal-header">
                    <h5 class="modal-title" id="veragregarLabel">Agregar Usuario</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="name" class="form-label">Nombre</label>
                        <input type="text" class="form-control" id="name" name="name" required>
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" class="form-control" id="email" name="email" required>
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">Contraseña</label>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>
                    <div class="mb-3">
                        <label for="password_confirmation" class="form-label">Confirmar Contraseña</label>
                        <input type="password" class="form-control" id="password_confirmation" name="password_confirmation" required>
                    </div>
                    <div class="mb-3">
                        <label for="rol" class="form-label">Rol</label>
                        <select id="rol" class="form-control" name="rol" required>
                            <option value="administrador">Administrador</option>
                            <option value="empleado">Empleado</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-success">Agregar Usuario</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Modal modificar usuario -->
<div class="modal fade" id="vermodificarusuario" tabindex="-1" aria-labelledby="vermodificarusuarioLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content bg-dark">
            <form action="{{ route('empleados.modificar') }}" method="GET">
                @csrf
                <input type="hidden" name="id" id="modal_id_usuario">
                <div class="modal-header">
                    <h5 class="modal-title" id="vermodificarLabel">Modificar Usuario</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="name" class="form-label">Nombre</label>
                        <input type="text" class="form-control" id="name" name="name" required>
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" class="form-control" id="email" name="email" required>
                    </div>
                    <div class="mb-3">
                        <label for="rol" class="form-label">Rol</label>
                        <select id="rol" class="form-control" name="rol" required>
                            <option value="administrador">Administrador</option>
                            <option value="empleado">Empleado</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary">Modificar Usuario</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                </div>
            </form>
        </div>
    </div>
</div>
@else
    <script>window.location = "{{ route('views.ventas') }}";</script>
@endif
@else
    <script>window.location = "{{ route('login') }}";</script>
@endauth