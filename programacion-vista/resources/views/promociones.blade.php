
@extends('layouts.nav')

@section('title', 'Venta')

@section('ladoizq')
<div class="row h-100">
    <div class="col-lg-8 d-flex flex-column">
        <!-- Cuadro de Venta -->
        <div class="card mb-3 flex-grow-1 left-table position-relative">
            <div class="card-body d-flex flex-column">
                <h5 class="card-title">promociones</h5>
                <div class="table-responsive flex-grow-1">
                    <table class="table table-dark table-striped">
                        <thead>
                            <tr>
                                <th>id</th>
                                <th>Nombre de la promocion</th>
                                <th>Tipo de descuento</th>
                                <th>Descuento</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Aquí irían las filas de productos -->
                        </tbody>
                    </table>
                </div>
                <div class="action-buttons">
                    <button class="btn btn-danger me-2">Eliminar Promoción</button>
                    <button class="btn btn-success">Agregar Promoción</button>
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