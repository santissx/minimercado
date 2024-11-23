
@extends('layouts.nav')

@section('title', 'Historial')

@section('ladoizq')
<div class="row h-100">
    <div class="col-lg-8 d-flex flex-column">
        <!-- Cuadro de historial -->
        <div class="card mb-3 flex-grow-1 left-table position-relative">
            <div class="card-body d-flex flex-column">
                <h5 class="card-title">Historial de ventas</h5>
                <div class="table-responsive flex-grow-1">
                    <table class="table table-dark table-striped">
                        <thead>
                            <tr>
                                <th>id_venta</th>
                                <th>vendedor</th>
                                <th>monto</th>
                                <th>descuento</th>
                                <th>monto final</th>
                                <th>metodo de pago</th>
                                <th>promociones aplicadas</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Aquí irían las filas de productos -->
                        </tbody>
                    </table>
                </div>
                <div class="filtros mb-3">
                    <form class="mb-3">
                    <label for="selectVendedor" class="form-label">Filtrar por vendedor</label>
                    <select class="form-select" id="selectVendedor">
                        <option selected>Selecciona un vendedor</option>
                        <option value="1">Vendedor 1</option>
                        <option value="2">Vendedor 2</option>
                        <option value="3">Vendedor 3</option>
                    </select>  
                    <label for="rango" class="form-label">Filtrar por rango de fechas</label>
                            <div class="input-group">
                                <input type="date" class="form-control" id="fechainicio" placeholder="Fecha inicio">
                                <span class="input-group-text">a</span>
                                <input type="date" class="form-control" id="fechafin" placeholder="Fecha fin">
                            </div>
                            <br>
                        <button type="submit" class="btn btn-primary">Aplicar filtros</button>
                        </form>
                        
                </div>
                <div class="action-buttons "> 
                    <button class="btn btn-danger me-2">Anular</button>
                    <button class="btn btn-info" data-bs-toggle="modal" data-bs-target="#verinfo">Detalle</button>
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
                

                <div class="card mb-3 flex-grow-1 left-table position-relative">
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title">Productos vendidos</h5>
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
                  <!-- Total de ventas en efectivo y ventas digitales -->
             
            </div>
            <div class="modal-footer">

                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
            </div>  
        </div>  
            </div>

            

            
        </div>
    </div>
</div>