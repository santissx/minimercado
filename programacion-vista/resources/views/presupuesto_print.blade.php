<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>Presupuesto</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            font-size: 13px;
            color: #222;
            background: #fff;
            padding: 30px;
        }

        .no-print {
            margin-bottom: 20px;
            display: flex;
            gap: 10px;
        }

        .btn {
            padding: 8px 18px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 13px;
        }

        .btn-volver {
            background: #6c757d;
            color: #fff;
        }

        .btn-imprimir {
            background: #0d6efd;
            color: #fff;
        }

        .ticket {
            max-width: 800px;
            margin: 0 auto;
            border: 1px solid #ccc;
            padding: 30px;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 20px;
        }

        .header-izq h1 {
            font-size: 22px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .logo {
            width: 100px;
            height: auto;
            margin-bottom: 8px;
        }

        .logo-placeholder {
            width: 100px;
            height: 80px;
            border: 1px dashed #aaa;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #aaa;
            font-size: 11px;
            margin-bottom: 8px;
        }

        .datos-local {
            font-size: 12px;
            line-height: 1.7;
            color: #444;
        }

        .header-der {
            text-align: right;
            font-size: 13px;
            line-height: 1.8;
        }

        hr {
            border: none;
            border-top: 1px solid #ccc;
            margin: 16px 0;
        }

        .datos-cliente {
            display: flex;
            justify-content: flex-end;
            margin-bottom: 16px;
        }

        .datos-cliente table td {
            padding: 2px 8px;
            font-size: 13px;
        }

        .datos-cliente table td:first-child {
            font-weight: bold;
            text-align: right;
        }

        .tabla-productos {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        .tabla-productos thead tr {
            background: #333;
            color: #fff;
        }

        .tabla-productos th,
        .tabla-productos td {
            padding: 7px 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .tabla-productos th:last-child,
        .tabla-productos td:last-child {
            text-align: right;
        }

        .tabla-productos th:nth-child(4),
        .tabla-productos td:nth-child(4) {
            text-align: right;
        }

        .tabla-productos tbody tr:nth-child(even) {
            background: #f9f9f9;
        }

        .totales {
            display: flex;
            justify-content: flex-end;
        }

        .totales table {
            min-width: 260px;
        }

        .totales table td {
            padding: 5px 10px;
            font-size: 13px;
        }

        .totales table td:first-child {
            font-weight: bold;
            text-align: right;
            color: #444;
        }

        .totales table td:last-child {
            text-align: right;
        }

        .totales .fila-total td {
            font-size: 18px;
            font-weight: bold;
            border-top: 2px solid #333;
            padding-top: 10px;
        }

        .totales .fila-total td:last-child {
            color: #c0392b;
        }

        .avisos {
            margin-top: 24px;
            font-size: 12px;
            color: #555;
            border-top: 1px solid #ddd;
            padding-top: 12px;
        }

        .avisos p {
            margin-bottom: 4px;
        }

        .footer {
            text-align: center;
            margin-top: 24px;
            font-size: 11px;
            color: #888;
        }

        @media print {
            body {
                padding: 0;
            }

            .no-print {
                display: none !important;
            }

            .ticket {
                border: none;
                padding: 10px;
            }
        }

        @media print {
            body {
                padding: 0;
            }

            .no-print {
                display: none !important;
            }

            .ticket {
                border: none;
                padding: 10px;
            }

            /* Evita que una fila de la tabla se corte entre dos páginas */
            .tabla-productos tbody tr {
                page-break-inside: avoid;
            }

            /* El header, datos del cliente y totales nunca se cortan */
            .header,
            .datos-cliente,
            .totales,
            .avisos {
                page-break-inside: avoid;
            }

            /* Si hay muchos productos, los totales arrancan en nueva página
       solo si no entran en la página actual */
            .totales {
                page-break-before: auto;
            }
        }
    </style>
</head>

<body>

    <div class="no-print">
        <button class="btn btn-volver" onclick="history.back()">← Volver</button>
        <button class="btn btn-imprimir" onclick="window.print()">Imprimir presupuesto</button>
    </div>

    <div class="ticket">

        {{-- Header --}}
        <div class="header">
            <div class="header-izq">
                <h1>{{ $local['nombre'] }}</h1>

                {{-- Logo: reemplazá el div por el img cuando tengas el archivo --}}
                {{-- <img src="{{ asset('images/logo.png') }}" class="logo" alt="Logo"> --}}
                <div class="logo-placeholder">Logo aquí</div>

                <div class="datos-local">
                    <div>Facebook: {{ $local['facebook'] }}</div>
                    <div>Instagram: {{ $local['instagram'] }}</div>
                    <div>CUIT: {{ $local['cuit'] }}</div>
                    <div>Teléfono: {{ $local['telefono'] }}</div>
                    <div>{{ $local['direccion'] }}</div>
                </div>
            </div>
            <div class="header-der">
                <div>Fecha: {{ $fecha }}</div>
                <div style="font-weight:bold; font-size:14px;">PRESUPUESTO</div>
            </div>
        </div>

        <hr>

        {{-- Datos del cliente --}}
        <div class="datos-cliente">
            <table>
                <tr>
                    <td>CLIENTE</td>
                    <td>{{ $nombre_cliente ?: 'Consumidor final' }}</td>
                </tr>
                @if ($telefono_cliente)
                    <tr>
                        <td>TELÉFONO</td>
                        <td>{{ $telefono_cliente }}</td>
                    </tr>
                @endif
            </table>
        </div>

        <hr>

        {{-- Tabla de productos --}}
        <table class="tabla-productos">
            <thead>
                <tr>
                    <th>Código</th>
                    <th>Descripción</th>
                    <th>Cant.</th>
                    <th>Precio unit.</th>
                    <th>Total</th>
                </tr>
            </thead>
            <tbody>
                @foreach ($productos as $producto)
                    <tr>
                        <td>{{ $producto['codigo'] }}</td>
                        <td>{{ $producto['nombre'] }}</td>
                        <td>{{ $producto['cantidad'] }}</td>
                        <td>${{ number_format($producto['precio'], 2) }}</td>
                        <td>${{ number_format($producto['total_linea'], 2) }}</td>
                    </tr>
                @endforeach
            </tbody>
        </table>

        {{-- Totales --}}
        <div class="totales">
            <table>
                <tr>
                    <td>SUBTOTAL $</td>
                    <td>{{ number_format($subtotal, 2) }}</td>
                </tr>
                @if ($descuento > 0)
                    <tr>
                        <td>DESCUENTO $</td>
                        <td>{{ number_format($descuento, 2) }}</td>
                    </tr>
                @endif
                <tr class="fila-total">
                    <td>Total $</td>
                    <td>{{ number_format($total, 2) }}</td>
                </tr>
            </table>
        </div>

        {{-- Avisos --}}
        <div class="avisos">
            <p>* Precios sujetos a cambios sin previo aviso.</p>
            <p>* Consultar stock al momento de realizar el pedido.</p>
        </div>

        <div class="footer">
            <p>{{ $local['nombre'] }} — {{ $local['telefono'] }}</p>
        </div>

    </div>

</body>

</html>
