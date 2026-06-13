@echo off
:: Cambia esta ruta por la ruta real donde está el proyecto
cd /d "C:\xampp\htdocs\tu_proyecto_ventas"

:: Verificamos si existe el archivo .env, si no, lo creamos desde el ejemplo
if not exist .env (
    echo Creando archivo de configuracion .env...
    copy .env.example .env
    
    echo Generando clave de cifrado unica para este equipo...
    php artisan key:generate
)

echo Iniciando Sistema...
start http://127.0.0.1:8000
php artisan serve
pause