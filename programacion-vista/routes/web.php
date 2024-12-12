<?php

use App\Http\Controllers\ProfileController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Promocioncontroller;
use App\Http\Controllers\listacontroller;
use App\Http\Controllers\proveedorescontroller;
use App\Http\Controllers\gastoscontroller;
use App\Http\Controllers\empleadoscontroller;
use App\Http\Controllers\clienteController;
use App\Http\Controllers\ComprasController;
use App\Http\Controllers\ProductoController;
use App\Http\Controllers\VentaController;
use App\Http\Controllers\HistorialController;
use App\Http\Controllers\VentasAnuController;
use App\Http\Controllers\FallbackController;
use App\Http\Middleware\AdminMiddleware;
//rutas del login 

Route::get('/dashboard', [VentaController::class, 'mostrar'])->middleware(['auth', 'verified'])->name('dashboard');


Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});

require __DIR__.'/auth.php';

//rutas del sistema

Route::middleware(['admin'])->group(function () {

    Route::get('/gastos', function () {
        return view('gastos');
    })->name('views.gastos');
    Route::get('/empleados', function () {
        return view('empleados');
    }) ->name('views.empleados');
    Route::get('/compras', function () {
        return view('compras');
    }) ->name('views.compras');
    //rutas para proveedores

Route::get('/proveedores', [proveedorescontroller::class, 'mostrar'])->name('views.proveedores');
Route::POST('/proveedores', [proveedorescontroller::class, 'agregar'])->name('proveedores.agregar');
Route::get('/proveedores/modificar', [proveedorescontroller::class, 'modificar'])->name('proveedores.modificar');
Route::delete('/proveedores/{id_proveedor}', [proveedorescontroller::class, 'borrar'])->name('proveedores.borrar');

//rutas gastos
Route::get('/gastos', [gastoscontroller::class, 'mostrar'])->name('views.gastos');
Route::POST('/gastos', [gastoscontroller::class, 'agregar'])->name('gastos.agregar');
Route::get('/gastos/modificar', [gastoscontroller::class, 'modificar'])->name('gastos.modificar');
Route::delete('/gastos/{id_gasto}', [gastoscontroller::class, 'borrar'])->name('gastos.borrar');

//ruta para empleados
Route::get('/empleados', [empleadoscontroller::class, 'mostrar'])->name('views.empleados');
Route::POST('/empleados', [empleadoscontroller::class, 'agregar'])->name('empleados.agregar');
Route::get('/empleados/modificar', [empleadoscontroller::class, 'modificar'])->name('empleados.modificar');
Route::delete('/empleados/{id}', [empleadoscontroller::class, 'borrar'])->name('empleados.borrar');

//ruta para clientes
Route::get('/clientes', [clienteController::class, 'mostrar'])->name('views.clientes');
Route::POST('/clientes', [clienteController::class, 'agregar'])->name('clientes.agregar');
Route::get('/clientes/modificar', [clienteController::class, 'modificar'])->name('clientes.modificar');
Route::delete('/clientes/{id_cliente}', [clienteController::class, 'borrar'])->name('clientes.borrar');


//rutas para compras
Route::get('/compras', [ComprasController::class, 'mostrar'])->name('views.compras');
Route::post('/compras', [ComprasController::class, 'agregar'])->name('compras.agregar');
// Ruta para obtener productos según el proveedor en select dependiente (ajax)
Route::get('/productos-por-proveedor/{id}', [ComprasController::class, 'getProductosPorProveedor'])->name('productos-por-proveedor');
Route::delete('/compras/{id_compra}', [ComprasController::class, 'eliminar'])->name('compras.eliminar');



});

Route::get('/ventas', function () {
    return view('welcome');
}) ->name('views.ventas');
Route::get('/historial', function () {
    return view('historial');
}) ->name('views.historial');
Route::get('/lista', function () {
    return view('lista');
}) ->name('views.lista');
Route::get('/anuladas', function () {
    return view('ventas_anu');
}) ->name('views.anuladas');




//rutas para lista
Route::get('/lista', [listacontroller::class, 'mostrar'])->name('views.lista');
Route::POST('/lista', [listacontroller::class, 'agregar'])->name('lista.agregar');
Route::POST('/lista/modificar', [listacontroller::class, 'modificar'])->name('lista.modificar');
Route::delete('/lista/{id_producto}', [listacontroller::class, 'borrar'])->name('lista.borrar');
Route::post('/lista/aumentar-precio-venta', [listacontroller::class, 'aumentarPrecioPorProveedor'])->name('productos.aumentarPrecio');
Route::post('/lista/aumentar-precio-lista', [listacontroller::class, 'aumentarPreciolistaPorProveedor'])->name('productos.aumentarPreciolista');




//rutas de ventas 

Route::get('/buscar-productos', [ProductoController::class, 'buscar'])->name('productos.buscar');
// Ruta para obtener los métodos de pago
Route::get('/ventas', [VentaController::class, 'mostrar'])->name('views.ventas');

Route::post('/ventas/guardar', [VentaController::class, 'guardar'])->name('ventas.guardar');

Route::get('/obtener-clientes-corrientes', [VentaController::class, 'obtenerClientesCorrientes']);


//rutas para historial
Route::get('/historial', [HistorialController::class, 'mostrar'])->name('views.historial');
Route::delete('/ventas/{id}/anular', [HistorialController::class, 'anularVenta'])->name('ventas.anular');

Route::get('/detalle-venta/{id}', [HistorialController::class, 'obtenerDetalleVenta'])->name('detalle.venta');

Route::post('/ventas/anular', [HistorialController::class, 'anularVenta'])->name('ventas.anular');


Route::get('/anuladas', [VentasAnuController::class, 'index'])->name('views.anuladas');

Route::get('/ticket/{idVenta}', [HistorialController::class, 'generarTicket'])->name('ventas.ticket');

Route::fallback([FallbackController::class, 'notFound']);

