
@extends('layouts.nav')

@section('title', 'Historial')

@section('ladoizq')
<div class="row h-100">
    <div class="col-lg-8 d-flex flex-column">
        <!-- Cuadro de historial -->
        <div class="card mb-3 flex-grow-1 left-table position-relative">
            <div class="card-body d-flex flex-column">
                <h5 class="card-title">Historial de anulaciones</h5>
                <div class="table-responsive flex-grow-1">
                    <table class="table table-dark table-striped">
                        <thead>
                            <tr>
                                <th>id venta anulada</th>
                                <th>id venta</th>
                                <th>usuario anulador</th>
                                <th>motivo</th>
                                <th>Detalle</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Aquí irían las filas de productos -->
                        </tbody>
                    </table>
                </div>
                <div class="action-buttons">   
                    <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#verinfo">Ver detalle</button>
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

<!-- Modal -->
<div class="modal fade " id="verinfo" tabindex="-1" aria-labelledby="verinfoLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg ">
        <div class="modal-content bg-dark">
            <div class="modal-header">
                <h5 class="modal-title" id="verinfoLabel">Detalle de la venta</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- productos vendidos en la venta -->
                <div class="card mb-3 flex-grow-1 left-table position-relative">
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title">Productos de la venta anulada</h5>
                        <div class="table-responsive flex-grow-1">
                            <table class="table table-dark table-striped">
                                <thead>
                                    <tr>
                                        <th>id_venta</th>
                                        <th>productos</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- Aquí irían las filas de productos -->
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>

