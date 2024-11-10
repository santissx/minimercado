
@extends('layouts.nav')

@section('title', 'Venta')

@section('ladoizq')
<form >
    @csrf
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
                             <!--   Aquí irían las filas de productos -->
                            </tbody>
                        </table>
                    </div>
                    <div class="action-buttons">
                      
                        <button type="button" class="btn btn-danger me-2">Eliminar producto</button>
                        <button type="submit" class="btn btn-success">Guardar venta</button>
                    </div>
                </div>
            </div>

            <!-- Cuadro de Ventas Totales -->
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Ventas Totales</h5>
                    <select class="form-select mb-3" name="metodo_pago">
                        <option selected>Método de pago</option>
                        <!-- Opciones de método de pago -->
                    </select>
                    <div class="d-flex justify-content-between mb-2">
                        <span>Subtotal:</span>
                        <span>$...</span>
                    </div>
                    <div class="d-flex justify-content-between mb-2">
                        <label for="descuento" class="me-2">Descuento manual:</label>
                        <input type="number" id="descuento" name="descuento_manual" class="form-control w-25" placeholder="$0.00" step="0.01" min="0">
                    </div>
                    <div class="d-flex justify-content-between mb-2">
                        <span>Descuento:</span>
                        <span>$...</span>
                    </div>
                    <div class="d-flex justify-content-between">
                        <span>Total:</span>
                        <span>$...</span>
                    </div>
                </div>
            </div>
        </div>
    </form>


    <!-- Columna derecha superior -->
    <div class="col-lg-4 right-column">
        @include('parciales.columna_derecha')
    </div>
</div>
@endsection


<!-- Modal -->
<div class="modal fade " id="promocionesModal" tabindex="-1" aria-labelledby="verpromosLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg ">
        <div class="modal-content bg-dark">
            <div class="modal-body">
                <!-- productos vendidos en la venta -->
                <div class="card mb-3 flex-grow-1 left-table position-relative">
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title">Promociones disponibles</h5>
                        <div class="table-responsive flex-grow-1">
                            <table class="table table-dark table-striped">
                                <thead>
                                    <tr>
                                        <th>id</th>
                                        <th>descripción</th>
                                        <th>estado</th>
                                        <th>fecha inicio</th>
                                        <th>fecha fin</th>
                                        <th>tipo de descuento</th>
                                        <th>porcentaje/descuento</th>
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
                <button class="btn btn-success">Seleccionar Promoción</button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>

