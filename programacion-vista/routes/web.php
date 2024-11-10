<?php
use App\Http\Controllers\Promocioncontroller;
use App\Http\Controllers\listacontroller;
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



//rutas para promociones
Route::POST('/promociones', [Promocioncontroller::class, 'agregar'])->name('promociones.agregar');
Route::get('/promociones', [Promocioncontroller::class, 'mostrar'])->name('views.promo');
Route::get('/promociones/modificar', [PromocionController::class, 'modificar'])->name('promociones.modificar');
Route::delete('/promociones/{id_promocion}', [PromocionController::class, 'borrar'])->name('promociones.borrar');
