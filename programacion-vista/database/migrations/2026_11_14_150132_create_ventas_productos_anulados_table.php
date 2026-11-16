<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('ventas_productos_anulados', function (Blueprint $table) {
            $table->id('id_anulacion_producto');
            $table->unsignedBigInteger('id_venta');
            $table->unsignedBigInteger('id_venta_producto');
            $table->unsignedBigInteger('id_producto');
            $table->unsignedBigInteger('id_usuario_anulador');
            $table->integer('cantidad_anulada');
            $table->decimal('precio_unitario', 10, 2);
            $table->string('descripcion', 255);
            $table->timestamp('fecha_anulacion')->useCurrent();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('ventas_productos_anulados');
    }
};