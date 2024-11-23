
@extends('layouts.nav')

@section('title', 'Compras')

@section('ladoizq')
<div class="row h-100">
    <div class="col-lg-8 d-flex flex-column">
        <!-- Cuadro de historial -->
        <div class="card mb-3 flex-grow-1 left-table position-relative">
            <div class="card-body d-flex flex-column">
                <h5 class="card-title">Compras</h5>
                <div class="table-responsive flex-grow-1">
                    <table class="table table-dark table-striped">
                        <thead>
                            <tr>
                                <th>id</th>
                                <th>monto_compra</th>
                                <th>fecha</th>
                                <th class="text-center">Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td></td>
                                <td></td>
                                <td> </td>
                                <td class="d-flex justify-content-center align-items-center gap-2 ">
                                    <button class="btn btn-info" data-bs-toggle="modal" data-bs-target="" data-id="" onclick="">Ver Detalle</button>
                                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="" data-id="" onclick="">Modificar</button>
                                    <button type="submit" class="btn btn-danger  ">Eliminar</button>
                                </form>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="action-buttons">   
                    <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="">Agregar Compra</button>
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
