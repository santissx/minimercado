<!-- resources/views/layouts/app.blade.php -->
@auth
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>@yield('title', 'Sistema minimercado')</title>
    
    <!-- Enlace al archivo CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="{{ asset('css/ventas.css') }}">
</head>
<body>
    <!-- Barra de navegación -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        
            <span class="navbar-text">
                {{ auth()->user()->name }}
            </span>
        </div>
    </nav>

    <!-- Contenido principal -->
    <div class="container-fluid mt-3 main-content">
        @yield('ladoizq')
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
@else
    <script>window.location = "{{ route('login') }}";</script>
@endauth