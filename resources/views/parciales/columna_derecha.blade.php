@auth
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
                    <a href="{{ route('views.compras') }}" class="btn btn-dark w-100 d-flex flex-column align-items-center justify-content-center " >
                        <span>🛒</span>
                        <span class="ms-2">Compras</span>
                    </a>
                        
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
                    <a href="{{route('views.proveedores')}}" class="btn btn-dark w-100 d-flex flex-column align-items-center justify-content-center " >
                        <span>🤝</span>
                        <span class="ms-2"> Lista de proveedores</span>
                    </a>
                </div>
                <div class="col-6 d-flex">
                    <a href="{{route('views.clientes')}}" class="btn btn-dark w-100 d-flex flex-column align-items-center justify-content-center " >
                        <span>🤝</span>
                        <span class="ms-2"> Clientes C/cuenta_corriente</span>
                    </a>
                </div>
                @if(Auth::check())
                    @if(Auth::user()->rol === 'administrador')
                        <div class="col-6 d-flex">
                            <a href="{{ route('views.empleados') }}" class="btn btn-dark w-100 d-flex flex-column align-items-center justify-content-center">
                                <span aria-hidden="true">👥</span>
                                <span class="ms-2">Lista de empleados</span>
                            </a>
                        </div>
                    <div class="col-12 d-flex">
                        <form method="POST" action="{{ route('logout') }}" class="w-100 m-0 d-flex">
                            @csrf
                            <button type="submit" class="btn btn-dark w-100 d-flex flex-column align-items-center justify-content-center">
                                <span aria-hidden="true">🚪</span>
                                <span class="ms-2">Cerrar sesión</span>
                            </button>
                        </form>
                    </div>
                    @elseif(Auth::user()->rol === 'empleado')
                    <div class="col-6 d-flex">
                        <form method="POST" action="{{ route('logout') }}" class="w-100 m-0 d-flex">
                            @csrf
                            <button type="submit" class="btn btn-dark w-100 d-flex flex-column align-items-center justify-content-center">
                                <span aria-hidden="true">🚪</span>
                                <span class="ms-2">Cerrar sesión</span>
                            </button>
                        </form>
                    </div>
                @endif
                @endif

            </div>
        </div>
    </div>
</div>
@else
    <script>window.location = "{{ route('login') }}";</script>
@endauth