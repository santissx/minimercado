<div class="right-top mb-3">
    <div class="card">
        <div class="card-body d-flex flex-column">
            <h5 class="card-title">Derecha-botones</h5>
            <div class="row g-2 flex-grow-1">
                <div class="col-6 d-flex">
                    <a href="{{ route('views.promo') }}" class="btn btn-dark w-100 d-flex flex-column align-items-center justify-content-center " >
                        <span>🏷️</span>
                        <span class="ms-2">Promociones</span>
                    </a>
                    
                </div>
                <div class="col-6 d-flex">
                    <a href="{{ route('views.ventas') }}" class="btn btn-dark w-100 d-flex flex-column align-items-center justify-content-center " >
                        <span>📊</span>
                        <span class="ms-2">Ventas</span>
                    </a>
                </div>
                <div class="col-6 d-flex">
                    <a href="{{ route('views.historial') }}" class="btn btn-dark w-100 d-flex flex-column align-items-center justify-content-center " >
                        <span>📊</span>
                        <span class="ms-2">Historial de ventas</span>
                    </a>
                </div>
                <div class="col-6 d-flex">
                    <a href="{{ route('views.gastos') }}" class="btn btn-dark w-100 d-flex flex-column align-items-center justify-content-center " >
                        <span>💰</span>
                        <span class="ms-2">Gastos</span>
                    </a>
                </div>
                <div class="col-6 d-flex">
                    <button class="btn btn-dark w-100" data-bs-toggle="modal" data-bs-target="#promocionesModal">
                        <div>🏷️</div>
                        Aplicar promociones
                    </button>
                </div>
              
                
                <div class="col-6 d-flex ">
                    <a href="{{ route('views.anuladas') }}" class="btn btn-dark w-100 d-flex flex-column align-items-center justify-content-center " >
                        <span>❌</span>
                        <span class="ms-2">Ventas anuladas</span>
                    </a>
                </div>
                <div class="col-6 d-flex">
                    <a href="{{ route('views.lista') }}" class="btn btn-dark w-100 d-flex flex-column align-items-center justify-content-center " >
                        <span>📋</span>
                        <span class="ms-2"> Lista de productos</span>
                    </a>
                </div>
                <div class="col-6 d-flex">
                    <a href="" class="btn btn-dark w-100 d-flex flex-column align-items-center justify-content-center " >
                        <span>🤝</span>
                        <span class="ms-2"> Lista de proveedores</span>
                    </a>
                </div>
                
                <div class="col-12 d-flex">
                    <button class="btn btn-dark w-100">
                        <div>🚪</div>
                        Cerrar sesión
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
