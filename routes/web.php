<?php

use App\Http\Controllers\ProfileController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Promocioncontroller;
use App\Http\Controllers\listacontroller;
use App\Http\Controllers\proveedorescontroller;
use App\Http\Controllers\gastoscontroller;


//rutas del login 

Route::get('/', function () {
    return view('welcome');
});

Route::get('/dashboard', function () {
    return view('dashboard');
})->middleware(['auth', 'verified'])->name('dashboard');

Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});

require __DIR__.'/auth.php';

//rutas del sistema

Route::get('/', function () {
    return view('welcome');
}) ->name('views.ventas');
Route::get('/ventas', function () {
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


//rutas gastos
Route::get('/gastos', [gastoscontroller::class, 'mostrar'])->name('views.gastos');
Route::POST('/gastos', [gastoscontroller::class, 'agregar'])->name('gastos.agregar');
Route::get('/gastos/modificar', [gastoscontroller::class, 'modificar'])->name('gastos.modificar');
Route::delete('/gastos/{id_gasto}', [gastoscontroller::class, 'borrar'])->name('gastos.borrar');