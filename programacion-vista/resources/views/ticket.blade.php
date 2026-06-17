<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Ticket #{{ $venta->id_venta }}</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial, sans-serif; font-size: 13px; color: #222; background: #fff; padding: 30px; }
        
        /* Contenedor de la X enmarcada */
        .contenedor-x {
            width: 70px; height: 70px; border: 2px solid #000;
            display: flex; flex-direction: column; align-items: center; justify-content: center;
            background: #fff; margin: 0 20px;
        }
        .x-grande { font-size: 40px; font-weight: bold; line-height: 1; }
        .leyenda-x { font-size: 7px; font-weight: bold; text-transform: uppercase; text-align: center; line-height: 1; margin-top: 2px; }

        .ticket { position: relative; max-width: 800px; margin: 0 auto; border: 1px solid #ccc; padding: 30px; background: #fff; }
        .no-print { margin-bottom: 20px; display: flex; gap: 10px; }
        .btn { padding: 8px 18px; border: none; border-radius: 4px; cursor: pointer; font-size: 13px; }
        .btn-volver { background: #6c757d; color: #fff; }
        .btn-imprimir { background: #0d6efd; color: #fff; }
        
        /* Header estructurado para que la X quede en el medio */
        .header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
        .header-izq { flex: 1; }
        .header-der { flex: 1; text-align: right; }
        .header-centro { display: flex; justify-content: center; }

        .header-izq h1 { font-size: 22px; font-weight: bold; margin-bottom: 5px; }
        .logo { width: 100px; height: auto; }
        .datos-local { font-size: 12px; line-height: 1.5; color: #444; margin-top: 5px; }
        .header-der { font-size: 13px; line-height: 1.8; }
        .comprobante-num { font-weight: bold; font-size: 14px; }
        
        hr { border: none; border-top: 1px solid #ccc; margin: 16px 0; }
        .datos-cliente { display: flex; justify-content: flex-end; margin-bottom: 16px; }
        .datos-cliente table td { padding: 2px 8px; font-size: 13px; }
        .datos-cliente table td:first-child { font-weight: bold; text-align: right; }
        
        .tabla-productos { width: 100%; border-collapse: collapse; margin-bottom: 20px; }
        .tabla-productos thead tr { background: #333; color: #fff; }
        .tabla-productos th, .tabla-productos td { padding: 7px 10px; text-align: left; border-bottom: 1px solid #ddd; }
        .tabla-productos th:last-child, .tabla-productos td:last-child { text-align: right; }
        .tabla-productos tbody tr:nth-child(even) { background: #f9f9f9; }
        
        .totales { display: flex; justify-content: flex-end; }
        .totales table { min-width: 260px; }
        .totales table td { padding: 5px 10px; font-size: 13px; }
        .totales table td:first-child { font-weight: bold; text-align: right; color: #444; }
        .fila-total td { font-size: 18px; font-weight: bold; border-top: 2px solid #333; padding-top: 10px; }
        .fila-total td:last-child { color: #c0392b; }
        
        .footer { text-align: center; margin-top: 30px; font-size: 11px; color: #888; }
        .leyenda-no-valido { text-align: center; font-size: 12px; font-weight: bold; color: #555; letter-spacing: 1px; margin-top: 20px; }

        @media print {
            .no-print { display: none !important; }
            .ticket { border: none; padding: 10px; }
        }
    </style>
</head>
<body>
    <div class="no-print">
        <button class="btn btn-volver" onclick="history.back()">← Volver</button>
        <button class="btn btn-imprimir" onclick="window.print()">Imprimir ticket</button>
    </div>

    <div class="ticket">
        <div class="header">
            <div class="header-izq">
                <h1>{{ $local['nombre'] }}</h1>
                <img src="{{ asset('storage/logo_se.jpeg') }}" alt="Logo Empresa" class="logo">
                <div class="datos-local">
                    <div>Facebook: {{ $local['facebook'] }}</div>
                    <div>Instagram: {{ $local['instagram'] }}</div>
                    <div>Teléfono: {{ $local['telefono'] }}</div>
                    <div>{{ $local['direccion'] }}</div>
                </div>
            </div>

            <div class="contenedor-x">
                <div class="x-grande">X</div>
                <div class="leyenda-x">TICKET NO VÁLIDO<br>COMO FACTURA</div>
            </div>

            <div class="header-der">
                <div>Fecha: {{ \Carbon\Carbon::parse($venta->fecha_venta)->format('d/m/Y H:i') }}</div>
                <div class="comprobante-num">Comprobante N° {{ str_pad($venta->id_venta, 8, '0', STR_PAD_LEFT) }}</div>
            </div>
        </div>
        
        <hr>
        <div class="datos-cliente">
            <table>
                <tr><td>CLIENTE</td><td>{{ $venta->clientec ? $venta->nombre_clientec : 'Consumidor final' }}</td></tr>
                <tr><td>VENDEDOR</td><td>{{ $venta->vendedor_name }}</td></tr>
                <tr><td>MÉTODO DE PAGO</td><td>{{ $venta->metodo_pago }}</td></tr>
            </table>
        </div>
        <hr>
        <table class="tabla-productos">
            <thead><tr><th>Código</th><th>Descripción</th><th>Cant.</th><th>Precio unit.</th><th>Total</th></tr></thead>
            <tbody>
                @foreach ($productos as $producto)
                    <tr>
                        <td>{{ $producto->codigo ?: $producto->codigo_barra }}</td>
                        <td>{{ $producto->producto }}</td>
                        <td>{{ $producto->cantidad }}</td>
                        <td>${{ number_format($producto->precio, 2) }}</td>
                        <td>${{ number_format($producto->precio * $producto->cantidad, 2) }}</td>
                    </tr>
                @endforeach
            </tbody>
        </table>
        <div class="totales">
            <table>
                <tr><td>SUBTOTAL $</td><td>{{ number_format($venta->monto_total + $venta->descuento, 2) }}</td></tr>
                @if ($venta->descuento > 0)
                    <tr><td>DESCUENTO $</td><td>{{ number_format($venta->descuento, 2) }}</td></tr>
                @endif
                <tr class="fila-total"><td>Total $</td><td>{{ number_format($venta->monto_total, 2) }}</td></tr>
            </table>
        </div>
        <div class="footer"><p>Gracias por su compra — {{ $local['nombre'] }}</p></div>
        <div class="leyenda-no-valido">*** TICKET NO VÁLIDO COMO FACTURA ***</div>
    </div>
</body>
</html>