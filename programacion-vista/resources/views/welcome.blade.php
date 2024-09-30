
@extends('layouts.nav')

@section('title', 'Venta')

@section('ladoizq')
<div class="row h-100">
    <div class="col-lg-8 d-flex flex-column">
        <!-- Cuadro de Venta -->
        <div class="card mb-3 flex-grow-1 left-table position-relative">
            <div class="card-body d-flex flex-column">
                <h5 class="card-title">Venta</h5>
                <div class="table-responsive flex-grow-1">
                    <table class="table table-dark table-striped">
                        <thead>
                            <tr>
                                <th>Código del producto</th>
                                <th>Nombre del producto</th>
                                <th>Cantidad</th>
                                <th>Precio Unitario</th>
                                <th>Precio Total</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Aquí irían las filas de productos -->
                        </tbody>
                    </table>
                </div>
                <div class="action-buttons">
                    <button class="btn btn-danger me-2">Eliminar producto</button>
                    <button class="btn btn-success">Guardar venta</button>
                </div>
            </div>
        </div>

        <!-- Cuadro de Ventas Totales -->
        <div class="card">
            @include('parciales.ventas_totales')
        </div>
    </div>

    <!-- Columna derecha superior -->
    <div class="col-lg-4 right-column">
        @include('parciales.columna_derecha')
        @include('parciales.columna_derecha_inferior')
    </div>

    
</div>
@endsection