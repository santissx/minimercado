<?php
use App\Http\Controllers\Promocioncontroller;
use App\Http\Controllers\listacontroller;
use App\Http\Controllers\proveedorescontroller;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
}) ->name('views.ventas');
Route::get('/promociones', function () {
    return view('promociones');
}) ->name('views.promo');
Route::get('/historial', function () {
    return view('historial');
}) ->name('views.historial');
Route::get('/gastos', function () {
    return view('gastos');
})->name('views.gastos');
Route::get('/anuladas', function () {
    return view('ventas_anu');
}) ->name('views.anuladas');
Route::get('/lista', function () {
    return view('lista');
}) ->name('views.lista');
Route::get('/proveedores', function () {
    return view('proveedores');
}) ->name('views.proveedores');



//rutas para promociones
Route::get('/promociones', [Promocioncontroller::class, 'mostrar'])->name('views.promo');
Route::POST('/promociones', [Promocioncontroller::class, 'agregar'])->name('promociones.agregar');
Route::get('/promociones/modificar', [PromocionController::class, 'modificar'])->name('promociones.modificar');
Route::delete('/promociones/{id_promocion}', [PromocionController::class, 'borrar'])->name('promociones.borrar');


//rutas para lista
Route::get('/lista', [listacontroller::class, 'mostrar'])->name('views.lista');
Route::POST('/lista', [listacontroller::class, 'agregar'])->name('lista.agregar');
Route::get('/lista/modificar', [listacontroller::class, 'modificar'])->name('lista.modificar');
Route::delete('/lista/{id_producto}', [listacontroller::class, 'borrar'])->name('lista.borrar');

//rutas para proveedores

Route::get('/proveedores', [proveedorescontroller::class, 'mostrar'])->name('views.proveedores');
Route::POST('/proveedores', [proveedorescontroller::class, 'agregar'])->name('proveedores.agregar');
Route::get('/proveedores/modificar', [proveedorescontroller::class, 'modificar'])->name('proveedores.modificar');
Route::delete('/proveedores/{id_proveedor}', [proveedorescontroller::class, 'borrar'])->name('proveedores.borrar');
