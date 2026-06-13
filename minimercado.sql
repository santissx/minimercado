-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 13-06-2026 a las 02:00:17
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `minimercado`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id_categoria` bigint(20) NOT NULL,
  `categoria` varchar(255) NOT NULL,
  `descripcion` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id_categoria`, `categoria`, `descripcion`) VALUES
(1, 'A - Térmicas y Disyuntores', 'Dispositivos de protección eléctrica (Código A)'),
(2, 'C - Cables', 'Cables conductores y unipolares (Código C)'),
(3, 'D - Cajas de PVC y METAL', 'Cajas de paso, embutir y exteriores (Código D)'),
(4, 'H - Herramientas e Instrumentos', 'Herramientas de mano e instrumentos de medición (Código H)'),
(5, 'I - Iluminación', 'Lámparas, paneles LED y artefactos (Código I)'),
(6, 'K - Canalización y accesorios', 'Caños, cablescanales y conectores (Código K)'),
(7, 'LL - Llaves, modulos, bastidores', 'Interruptores, tomacorrientes y bastidores (Código LL)'),
(8, 'P - Puesta a Tierra', 'Jabalinas, morcetis y mallas (Código P)'),
(9, 'T - Tableros y elementos', 'Tableros principales, seccionales y cajas térmicas (Código T)'),
(10, 'V - Ventiladores', 'Ventiladores de techo, pared y turbinas (Código V)'),
(11, 'X - Accesorios para cables', 'Terminales, precintos y aisladoras (Código X)'),
(12, 'Y - Varios', 'Artículos varios de ferretería eléctrica (Código Y)'),
(13, 'S - Servicios y mantenimientos', 'Servicios técnicos y mano de obra (Código S)'),
(14, 'IN - Instalaciones', 'Proyectos e instalaciones eléctricas completas (Código IN)');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes_corrientes`
--

CREATE TABLE `clientes_corrientes` (
  `id_cliente` bigint(20) NOT NULL,
  `nombre_y_apellido` varchar(255) NOT NULL,
  `DNI` bigint(15) NOT NULL,
  `telefono` bigint(14) DEFAULT NULL,
  `estado` enum('activo','desactivado') DEFAULT 'activo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clientes_corrientes`
--

INSERT INTO `clientes_corrientes` (`id_cliente`, `nombre_y_apellido`, `DNI`, `telefono`, `estado`) VALUES
(1, 'carlos tevez', 53555555, 3704653535, 'desactivado'),
(3, 'martin palermo', 23456888, 3704444423, 'activo'),
(4, 'exequiel fernandez', 43777888, 1234555555, 'activo'),
(5, 'exequiel ceballos', 46777777, 3704206331, 'desactivado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compras`
--

CREATE TABLE `compras` (
  `id_compra` bigint(20) NOT NULL,
  `monto_compra` decimal(10,2) NOT NULL,
  `fecha` datetime DEFAULT current_timestamp(),
  `id_proveedor` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `compras`
--

INSERT INTO `compras` (`id_compra`, `monto_compra`, `fecha`, `id_proveedor`) VALUES
(2, 9000.00, '2024-11-24 23:57:12', 2),
(3, 9000.00, '2024-11-24 23:58:03', 2),
(4, 1500.00, '2024-11-25 00:22:13', 2),
(6, 800.00, '2024-11-25 00:24:11', 2),
(11, 6000.00, '2024-12-12 12:43:47', 1),
(12, 1222.00, '2026-01-27 14:19:37', 1),
(13, 1500.00, '2026-06-11 23:37:14', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `gastos`
--

CREATE TABLE `gastos` (
  `id_gasto` bigint(20) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `fecha_gasto` datetime NOT NULL DEFAULT current_timestamp(),
  `categoria` enum('administrativo','logistico','cotidiano','deudas') DEFAULT NULL,
  `id_usuario` bigint(20) UNSIGNED NOT NULL,
  `motivo` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `gastos`
--

INSERT INTO `gastos` (`id_gasto`, `descripcion`, `monto`, `fecha_gasto`, `categoria`, `id_usuario`, `motivo`) VALUES
(1, 'mercaderia', 500.55, '2024-11-10 00:00:00', 'logistico', 2, 'compras'),
(3, 'sueldo', 400.00, '2024-11-23 00:00:00', 'deudas', 2, 'pagar'),
(5, 'envio', 1500.00, '2024-11-23 00:00:00', 'logistico', 2, 'pagar'),
(9, 'gasto en uber', 2500.00, '2026-06-06 18:48:40', 'logistico', 11, 'delivery');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `metodos_pago`
--

CREATE TABLE `metodos_pago` (
  `id_metodo_pago` bigint(20) NOT NULL,
  `nombre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `metodos_pago`
--

INSERT INTO `metodos_pago` (`id_metodo_pago`, `nombre`) VALUES
(1, 'efectivo'),
(2, 'transferencia'),
(3, 'cliente_corriente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id_producto` bigint(20) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `codigo` varchar(100) NOT NULL,
  `codigo_barra` varchar(100) NOT NULL,
  `id_proveedor` bigint(20) NOT NULL,
  `stock` int(11) DEFAULT NULL,
  `precio_lista` decimal(10,2) DEFAULT NULL,
  `id_categoria` bigint(20) DEFAULT NULL,
  `precio_venta` decimal(10,2) DEFAULT NULL,
  `estado` enum('activo','desactivado') DEFAULT 'activo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id_producto`, `nombre`, `codigo`, `codigo_barra`, `id_proveedor`, `stock`, `precio_lista`, `id_categoria`, `precio_venta`, `estado`) VALUES
(1, 'coca', '123456', '123456', 1, 22, 600.00, 1, 1125.00, 'activo'),
(6, 'coca 3L', '1234562', '111333444', 2, 48, 2700.00, 1, 7200.00, 'activo'),
(8, 'chocolate blanco', '12578', '15778966', 2, 79, 5400.00, 1, 14400.00, 'activo'),
(9, 'chocolate milka', '123456789909', '123456789909', 2, 73, 5400.00, 1, 10800.00, 'activo'),
(11, 'pepsi 2.25', '8678787', '234513279851', 1, 12, 1500.00, 1, 2500.00, 'activo'),
(12, 'pepsi 3l', '2345342534', '412341234', 2, 43, 3000.00, 1, 12000.00, 'activo'),
(13, 'pepsi 500ml', '12345', '1233245423', 2, 0, 4800.00, 1, 7200.00, 'activo'),
(14, 'pan mignon', '111', '12345566', 2, 48, 2400.00, 2, 5400.00, 'activo'),
(15, 'leche la serenisima', '1234556666', '123333333', 2, 15, 1500.00, 1, 1800.00, 'activo'),
(16, 'huevos revueltos', '123-huev-br', '199999', 2, 10, 1200.00, 14, 2400.00, 'activo'),
(17, 'huevos fritos', '124-huev-br', '1999992', 2, 10, 1200.00, 14, 2400.00, 'activo'),
(18, 'galletitas oreo', '7654321', '7654321000111', 1, 50, 800.00, 3, 1500.00, 'activo'),
(19, 'yerba mate playadito 1kg', '7654322', '7654321000112', 2, 27, 2500.00, 4, 4500.00, 'activo'),
(20, 'fideos matarazzo', '7654323', '7654321000113', 1, 97, 900.00, 5, 1800.00, 'activo'),
(21, 'arroz gallo oro', '7654324', '7654321000114', 2, 57, 1200.00, 5, 2200.00, 'activo'),
(22, 'pure de tomate', '7654325', '7654321000115', 1, 39, 500.00, 6, 950.00, 'activo'),
(23, 'azucar ledesma 1kg', '7654326', '7654321000116', 2, 82, 800.00, 7, 1400.00, 'activo'),
(24, 'aceite natura 1.5l', '7654327', '7654321000117', 1, 23, 2200.00, 8, 4000.00, 'activo'),
(25, 'agua mineral kin 1.5l', '7654328', '7654321000118', 2, 118, 600.00, 1, 1100.00, 'activo'),
(26, 'cerveza quilmes 1l', '7654329', '7654321000119', 1, 49, 1500.00, 9, 2800.00, 'activo'),
(27, 'vino tinto malbec', '7654330', '7654321000120', 2, 12, 3000.00, 10, 5500.00, 'activo'),
(28, 'sal fina celusal', '7654331', '7654321000121', 1, 37, 700.00, 14, 1300.00, 'activo'),
(29, 'pan integral', '7654332', '7654321000122', 1, 19, 1500.00, 2, 2800.00, 'activo'),
(30, 'queso crema', '7654333', '7654321000123', 2, 34, 1800.00, 1, 3200.00, 'activo'),
(31, 'jamon cocido 200g', '7654334', '7654321000124', 1, 15, 2500.00, 1, 4000.00, 'activo'),
(32, 'mayonesa hellmanns', '7654335', '7654321000125', 2, 53, 900.00, 6, 1600.00, 'activo'),
(33, 'ketchup natura', '7654336', '7654321000126', 1, 43, 850.00, 6, 1500.00, 'activo'),
(34, 'te taragui 50 saquitos', '7654337', '7654321000127', 2, 78, 1100.00, 4, 1900.00, 'activo'),
(35, 'cafe la virginia 500g', '7654338', '7654321000128', 1, 23, 4500.00, 4, 7500.00, 'activo'),
(36, 'detergente magistral', '7654339', '7654321000129', 2, 58, 1300.00, 11, 2200.00, 'activo'),
(37, 'lavandina ayudin 1l', '7654340', '7654321000130', 1, 90, 800.00, 11, 1400.00, 'desactivado'),
(38, 'papel higienico higienol', '7654341', '7654321000131', 2, 38, 2000.00, 12, 3500.00, 'activo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productosxcompras`
--

CREATE TABLE `productosxcompras` (
  `id_pxc` bigint(20) NOT NULL,
  `id_producto` bigint(20) NOT NULL,
  `cantidad_agregada` int(11) NOT NULL,
  `id_compra` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productosxcompras`
--

INSERT INTO `productosxcompras` (`id_pxc`, `id_producto`, `cantidad_agregada`, `id_compra`) VALUES
(3, 6, 5, 2),
(4, 9, 5, 2),
(5, 6, 5, 3),
(6, 9, 5, 3),
(7, 8, 2, 4),
(8, 6, 2, 4),
(10, 8, 5, 6),
(11, 9, 8, 6),
(12, 6, 7, 6),
(23, 1, 10, 11),
(24, 1, 22, 12),
(25, 11, 15, 13);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE `proveedores` (
  `id_proveedor` bigint(20) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `telefono` varchar(50) NOT NULL,
  `direccion` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `nombre_preventista` varchar(255) DEFAULT NULL,
  `num_preventista` varchar(20) DEFAULT NULL,
  `estado` enum('activo','desactivado') DEFAULT 'activo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `proveedores`
--

INSERT INTO `proveedores` (`id_proveedor`, `nombre`, `telefono`, `direccion`, `email`, `nombre_preventista`, `num_preventista`, `estado`) VALUES
(1, 'arca continental', '3704444444', '9 de julio 101', 'arcacontinental@gmail.com', 'lucas  armand  ugon', '2147483647', 'desactivado'),
(2, 'alfa', '3704222222', '9 de julio 805', 'alfa@gmail.com', 'lucas2', '2147483647', 'activo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('VP7KRPMZLcsayaf8bJ148cw4ZkDfUT5hk3lxj0LO', 11, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36 Edg/149.0.0.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoidEFwbWxydTFDTDduTWtXWllQOEVhS3VScU16Q0d0eVBtRU9kNnUyRCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDY6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9idXNjYXItcHJvZHVjdG9zP3E9cGVwc2kiO31zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxMTt9', 1781308758);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp(),
  `rol` enum('administrador','empleado') DEFAULT NULL,
  `estado` enum('activo','desactivado') DEFAULT 'activo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `rol`, `estado`) VALUES
(2, 'prueba2', 'prueba2@gmail.com', NULL, '$2y$12$FQojJnYwgpYkwUcys.gb0elS6uetuoYTK7fVM5CHlqwcJJrptOgmy', NULL, '2024-11-10 23:22:20', '2024-11-10 23:22:20', 'empleado', 'desactivado'),
(10, 'prueba3', 'prueba3@gmail.com', NULL, '$2y$12$wdB7l9G69gyW92QHcKP.PuBYm7gLQS6A7DTk38zly9hxumdDPwgeS', NULL, NULL, NULL, 'administrador', 'desactivado'),
(11, 'admin', 'admin@gmail.com', NULL, '$2y$12$8opCHL7Xediw3GAl/EF7seHMCrEYn8oppva6GTHHYgDmwkfLZrY9u', NULL, '2024-11-25 22:48:17', '2024-11-25 22:48:17', 'administrador', 'activo'),
(12, 'caja 1', 'caja1@gmail.com', NULL, '$2y$12$W8SKHkMc9MYqJa04S.dtqeHZ8P2QhdzFho6Hmh/9.EW8l1ZDmbiW2', NULL, '2024-11-25 22:48:58', '2024-11-25 22:48:58', 'empleado', 'desactivado'),
(13, 'caja 2', 'caja2@gmail.com', NULL, '$2y$12$8oRVhbv/Mh2MUh.whltaZuYFMemcr6kdRCsbsexW1CZg/j.hWpDJ2', NULL, '2024-11-25 22:49:24', '2024-11-25 22:49:24', 'empleado', 'desactivado'),
(14, 'caja 3', 'caja3@gmail.com', NULL, '$2y$12$p9Z.BCajwIiUgXyYTeTMR.coHgOT80V5fWyawdCZ3w3oVB9YT.kAi', NULL, '2024-11-25 20:34:11', '2024-11-25 20:34:11', 'empleado', 'desactivado'),
(15, 'caja4', 'caja4@gmail.com', NULL, '$2y$12$JuZPYbXa2O0TmeQJtW55gea6zML8IDoBgPT966/iWXE2ul4hbyVcq', NULL, '2024-12-12 18:21:19', '2024-12-12 18:21:19', 'administrador', 'desactivado'),
(16, 'caja5', 'caja5@gmail.com', NULL, '$2y$12$cakfdwRtY6GRSMqAWxuwUeXhGlxMrtFrQenozkrGzrnfl/.KFDVJC', NULL, '2024-12-12 18:21:35', '2024-12-12 18:21:35', 'empleado', 'desactivado'),
(17, 'admin2', 'caja16@gmail.com', NULL, '$2y$12$b460gVqtszVuCu.0JsW37eY.veAHBfwLeDzBzR7dI2MvJ3lu50U8u', NULL, '2026-06-06 22:31:24', '2026-06-06 22:31:24', 'administrador', 'activo'),
(18, 'cajaprueba', 'cajaprueba@gmail.com', NULL, '$2y$12$sSblXRB2uvLsG2w2AYuuWumLZ2ONg3tOTpJlDNLR2Zf/FtfKeKIoO', NULL, '2026-06-06 22:33:25', '2026-06-06 22:33:25', 'empleado', 'activo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `id_venta` bigint(20) NOT NULL,
  `id_usuario` bigint(20) UNSIGNED NOT NULL,
  `fecha_venta` datetime NOT NULL DEFAULT current_timestamp(),
  `monto_total` decimal(10,2) NOT NULL,
  `id_metodo_pago` bigint(20) NOT NULL,
  `descuento` decimal(10,2) DEFAULT NULL,
  `id_cliente` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`id_venta`, `id_usuario`, `fecha_venta`, `monto_total`, `id_metodo_pago`, `descuento`, `id_cliente`) VALUES
(1, 2, '2024-11-25 00:00:00', 650.00, 2, 100.00, NULL),
(2, 2, '2024-11-25 00:00:00', 1200.00, 2, 0.00, NULL),
(3, 2, '2024-11-25 00:00:00', 2550.00, 1, 0.00, NULL),
(4, 2, '2024-11-25 00:00:00', 250.00, 3, 500.00, NULL),
(5, 2, '2024-11-25 00:00:00', 250.00, 3, 500.00, NULL),
(6, 2, '2024-11-25 00:00:00', 550.00, 3, 200.00, 1),
(7, 2, '2024-11-25 00:00:00', 700.00, 2, 500.00, NULL),
(8, 2, '2024-11-25 00:00:00', 1000.00, 3, 200.00, 1),
(9, 2, '2024-11-25 00:00:00', 250.00, 2, 500.00, NULL),
(10, 2, '2024-11-25 00:00:00', 1500.00, 2, 300.00, NULL),
(11, 2, '2024-11-25 00:00:00', 3250.00, 3, 500.00, 1),
(12, 2, '2024-11-25 00:00:00', 1950.00, 1, 0.00, NULL),
(13, 13, '2024-11-25 00:00:00', 600.00, 2, 525.00, NULL),
(14, 14, '2024-11-25 00:00:00', 625.00, 2, 500.00, NULL),
(15, 14, '2024-11-25 00:00:00', 1500.00, 2, 900.00, NULL),
(16, 11, '2024-12-10 00:00:00', 1125.00, 1, 0.00, NULL),
(17, 11, '2024-12-11 00:00:00', 700.00, 3, 500.00, 1),
(18, 11, '2024-12-12 00:00:00', 2200.00, 3, 200.00, 3),
(19, 11, '2024-12-12 00:00:00', 1125.00, 1, 0.00, NULL),
(20, 11, '2024-12-12 00:00:00', 1200.00, 2, 0.00, NULL),
(21, 11, '2024-12-12 00:00:00', 1125.00, 1, 0.00, NULL),
(22, 11, '2024-12-12 00:00:00', 13725.00, 3, 0.00, 4),
(23, 13, '2026-01-27 00:00:00', 2300.00, 1, 200.00, NULL),
(24, 13, '2026-05-27 00:00:00', 10000.00, 1, 2500.00, NULL),
(25, 11, '2026-06-06 05:41:04', 625.00, 1, 500.00, NULL),
(26, 11, '2026-06-06 02:44:28', 12000.00, 1, 0.00, NULL),
(27, 17, '2026-06-06 19:32:04', 12000.00, 3, 0.00, 3),
(28, 18, '2026-06-06 19:33:50', 12000.00, 2, 0.00, NULL),
(29, 18, '2026-06-06 19:34:02', 7200.00, 3, 0.00, 3),
(30, 18, '2026-06-06 19:34:15', 0.00, 1, 1125.00, NULL),
(31, 18, '2026-06-06 19:34:30', -75.00, 1, 1200.00, NULL),
(32, 11, '2026-06-08 20:53:14', 3325.00, 1, 5000.00, NULL),
(33, 11, '2026-06-08 21:00:13', 16125.00, 2, 3000.00, NULL),
(34, 11, '2026-06-11 23:32:30', 1125.00, 1, 0.00, NULL),
(35, 11, '2026-06-11 23:32:52', 7000.00, 2, 200.00, NULL),
(36, 11, '2026-06-11 23:37:49', 54625.00, 2, 0.00, NULL),
(37, 11, '2026-06-11 23:46:05', 82525.00, 1, 0.00, NULL),
(38, 11, '2026-06-11 23:50:14', 93025.00, 2, 0.00, NULL),
(39, 11, '2026-06-12 00:05:37', 14400.00, 1, 0.00, NULL),
(40, 11, '2026-06-12 00:08:44', 12000.00, 1, 0.00, NULL),
(41, 11, '2026-06-12 00:09:02', 7200.00, 3, 0.00, 3),
(42, 11, '2026-06-12 20:12:42', 90475.00, 2, 0.00, NULL),
(43, 11, '2026-06-12 20:14:32', -75.00, 2, 1200.00, NULL),
(44, 11, '2026-06-12 20:59:00', 1800.00, 1, 14400.00, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas_anuladas`
--

CREATE TABLE `ventas_anuladas` (
  `id_venta_anulada` bigint(20) NOT NULL,
  `id_venta` bigint(20) NOT NULL,
  `id_usuario_anulador` bigint(20) UNSIGNED NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `fecha_anu` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ventas_anuladas`
--

INSERT INTO `ventas_anuladas` (`id_venta_anulada`, `id_venta`, `id_usuario_anulador`, `descripcion`, `fecha_anu`) VALUES
(2, 2, 2, 'se cobro en efectivo', '2024-11-23 00:00:00'),
(3, 4, 13, 'el cliente devolvio el producto', '2024-11-21 00:00:00'),
(4, 15, 11, 'Producto Vencido', '2024-12-03 00:00:00'),
(5, 14, 11, 'x motivo', '2024-12-02 00:00:00'),
(6, 9, 12, 'se cobro mal', '2024-12-11 00:00:00'),
(7, 3, 11, 'no se aplico el descuento', '2024-12-11 00:00:00'),
(8, 16, 11, 'prueba', '2024-12-12 00:00:00'),
(9, 21, 11, 'sin gas', '2024-12-12 00:00:00'),
(10, 25, 11, 'prueba2', '2026-06-06 00:00:00'),
(11, 32, 11, 'PRUEBA', '2026-06-08 20:56:01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas_productos`
--

CREATE TABLE `ventas_productos` (
  `id_venta_producto` bigint(20) NOT NULL,
  `id_venta` bigint(20) NOT NULL,
  `id_producto` bigint(20) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ventas_productos`
--

INSERT INTO `ventas_productos` (`id_venta_producto`, `id_venta`, `id_producto`, `cantidad`, `precio`) VALUES
(1, 1, 1, 1, NULL),
(2, 2, 6, 1, NULL),
(3, 3, 1, 1, 750.00),
(4, 3, 9, 1, 1800.00),
(5, 4, 1, 1, 750.00),
(6, 5, 1, 1, 750.00),
(7, 6, 1, 1, 750.00),
(8, 7, 6, 1, 1200.00),
(9, 8, 6, 1, 1200.00),
(10, 9, 1, 1, 750.00),
(11, 10, 9, 1, 1800.00),
(12, 11, 1, 5, 750.00),
(13, 12, 1, 1, 750.00),
(14, 12, 6, 1, 1200.00),
(15, 13, 1, 1, 1125.00),
(16, 14, 1, 1, 1125.00),
(17, 15, 8, 1, 2400.00),
(18, 16, 1, 1, 1125.00),
(19, 17, 6, 1, 1200.00),
(20, 18, 6, 2, 1200.00),
(21, 19, 1, 1, 1125.00),
(22, 20, 6, 1, 1200.00),
(23, 21, 1, 1, 1125.00),
(24, 22, 1, 1, 1125.00),
(25, 22, 6, 1, 7200.00),
(26, 22, 14, 1, 5400.00),
(27, 23, 11, 1, 2500.00),
(28, 24, 11, 5, 2500.00),
(29, 25, 1, 1, 1125.00),
(30, 26, 12, 1, 12000.00),
(31, 27, 12, 1, 12000.00),
(32, 28, 12, 1, 12000.00),
(33, 29, 6, 1, 7200.00),
(34, 30, 1, 1, 1125.00),
(35, 31, 1, 1, 1125.00),
(36, 32, 1, 1, 1125.00),
(37, 32, 6, 1, 7200.00),
(38, 33, 6, 1, 7200.00),
(39, 33, 1, 1, 1125.00),
(40, 33, 9, 1, 10800.00),
(41, 34, 1, 1, 1125.00),
(42, 35, 6, 1, 7200.00),
(43, 36, 11, 1, 2500.00),
(44, 36, 12, 1, 12000.00),
(45, 36, 1, 1, 1125.00),
(46, 36, 6, 1, 7200.00),
(47, 36, 8, 1, 14400.00),
(48, 36, 9, 1, 10800.00),
(49, 36, 15, 1, 1800.00),
(50, 36, 16, 1, 2400.00),
(51, 36, 17, 1, 2400.00),
(52, 37, 11, 1, 2500.00),
(53, 37, 12, 1, 12000.00),
(54, 37, 13, 1, 7200.00),
(55, 37, 1, 1, 1125.00),
(56, 37, 6, 1, 7200.00),
(57, 37, 8, 1, 14400.00),
(58, 37, 9, 1, 10800.00),
(59, 37, 15, 1, 1800.00),
(60, 37, 20, 1, 1800.00),
(61, 37, 21, 1, 2200.00),
(62, 37, 23, 1, 1400.00),
(63, 37, 24, 1, 4000.00),
(64, 37, 16, 1, 2400.00),
(65, 37, 17, 1, 2400.00),
(66, 37, 19, 1, 4500.00),
(67, 37, 27, 1, 5500.00),
(68, 37, 28, 1, 1300.00),
(69, 38, 11, 1, 2500.00),
(70, 38, 12, 1, 12000.00),
(71, 38, 13, 1, 7200.00),
(72, 38, 1, 1, 1125.00),
(73, 38, 6, 1, 7200.00),
(74, 38, 8, 1, 14400.00),
(75, 38, 9, 1, 10800.00),
(76, 38, 15, 1, 1800.00),
(77, 38, 33, 1, 1500.00),
(78, 38, 20, 1, 1800.00),
(79, 38, 21, 1, 2200.00),
(80, 38, 23, 1, 1400.00),
(81, 38, 34, 1, 1900.00),
(82, 38, 25, 1, 1100.00),
(83, 38, 36, 1, 2200.00),
(84, 38, 19, 1, 4500.00),
(85, 38, 28, 1, 1300.00),
(86, 38, 32, 1, 1600.00),
(87, 38, 27, 1, 5500.00),
(88, 38, 35, 1, 7500.00),
(89, 38, 38, 1, 3500.00),
(90, 39, 13, 2, 7200.00),
(91, 40, 12, 1, 12000.00),
(92, 41, 6, 1, 7200.00),
(93, 42, 8, 1, 14400.00),
(94, 42, 9, 1, 10800.00),
(95, 42, 15, 1, 1800.00),
(96, 42, 33, 1, 1500.00),
(97, 42, 20, 1, 1800.00),
(98, 42, 21, 1, 2200.00),
(99, 42, 23, 1, 1400.00),
(100, 42, 34, 1, 1900.00),
(101, 42, 25, 1, 1100.00),
(102, 42, 36, 1, 2200.00),
(103, 42, 28, 1, 1300.00),
(104, 42, 32, 1, 1600.00),
(105, 42, 24, 1, 4000.00),
(106, 42, 19, 1, 4500.00),
(107, 42, 22, 1, 950.00),
(108, 42, 27, 1, 5500.00),
(109, 42, 30, 1, 3200.00),
(110, 42, 1, 1, 1125.00),
(111, 42, 6, 1, 7200.00),
(112, 42, 35, 1, 7500.00),
(113, 42, 26, 1, 2800.00),
(114, 42, 14, 1, 5400.00),
(115, 42, 29, 1, 2800.00),
(116, 42, 38, 1, 3500.00),
(117, 43, 1, 1, 1125.00),
(118, 44, 8, 1, 14400.00),
(119, 44, 15, 1, 1800.00);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indices de la tabla `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id_categoria`);

--
-- Indices de la tabla `clientes_corrientes`
--
ALTER TABLE `clientes_corrientes`
  ADD PRIMARY KEY (`id_cliente`);

--
-- Indices de la tabla `compras`
--
ALTER TABLE `compras`
  ADD PRIMARY KEY (`id_compra`),
  ADD KEY `prov` (`id_proveedor`);

--
-- Indices de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indices de la tabla `gastos`
--
ALTER TABLE `gastos`
  ADD PRIMARY KEY (`id_gasto`),
  ADD KEY `gastos_ibfk_1` (`categoria`),
  ADD KEY `gastos_usu` (`id_usuario`);

--
-- Indices de la tabla `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indices de la tabla `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `metodos_pago`
--
ALTER TABLE `metodos_pago`
  ADD PRIMARY KEY (`id_metodo_pago`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id_producto`),
  ADD UNIQUE KEY `codigo` (`codigo`),
  ADD UNIQUE KEY `codigo_barra` (`codigo_barra`),
  ADD KEY `id_proveedor` (`id_proveedor`),
  ADD KEY `producxcategoria` (`id_categoria`);

--
-- Indices de la tabla `productosxcompras`
--
ALTER TABLE `productosxcompras`
  ADD PRIMARY KEY (`id_pxc`),
  ADD KEY `pxc` (`id_producto`),
  ADD KEY `compra` (`id_compra`);

--
-- Indices de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`id_proveedor`);

--
-- Indices de la tabla `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`id_venta`),
  ADD KEY `ventas_ibfk_2` (`id_metodo_pago`),
  ADD KEY `usersid` (`id_usuario`),
  ADD KEY `clientes_Corrientes` (`id_cliente`);

--
-- Indices de la tabla `ventas_anuladas`
--
ALTER TABLE `ventas_anuladas`
  ADD PRIMARY KEY (`id_venta_anulada`),
  ADD KEY `ventas_anuladas_ibfk_1` (`id_venta`),
  ADD KEY `useranul` (`id_usuario_anulador`);

--
-- Indices de la tabla `ventas_productos`
--
ALTER TABLE `ventas_productos`
  ADD PRIMARY KEY (`id_venta_producto`),
  ADD KEY `id_venta` (`id_venta`),
  ADD KEY `id_producto` (`id_producto`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id_categoria` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `clientes_corrientes`
--
ALTER TABLE `clientes_corrientes`
  MODIFY `id_cliente` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `compras`
--
ALTER TABLE `compras`
  MODIFY `id_compra` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `gastos`
--
ALTER TABLE `gastos`
  MODIFY `id_gasto` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `metodos_pago`
--
ALTER TABLE `metodos_pago`
  MODIFY `id_metodo_pago` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id_producto` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT de la tabla `productosxcompras`
--
ALTER TABLE `productosxcompras`
  MODIFY `id_pxc` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  MODIFY `id_proveedor` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `id_venta` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT de la tabla `ventas_anuladas`
--
ALTER TABLE `ventas_anuladas`
  MODIFY `id_venta_anulada` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `ventas_productos`
--
ALTER TABLE `ventas_productos`
  MODIFY `id_venta_producto` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=120;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `compras`
--
ALTER TABLE `compras`
  ADD CONSTRAINT `prov` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedores` (`id_proveedor`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `gastos`
--
ALTER TABLE `gastos`
  ADD CONSTRAINT `gastos_usu` FOREIGN KEY (`id_usuario`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedores` (`id_proveedor`),
  ADD CONSTRAINT `producxcategoria` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id_categoria`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `productosxcompras`
--
ALTER TABLE `productosxcompras`
  ADD CONSTRAINT `compra` FOREIGN KEY (`id_compra`) REFERENCES `compras` (`id_compra`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pxc` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD CONSTRAINT `clientes_Corrientes` FOREIGN KEY (`id_cliente`) REFERENCES `clientes_corrientes` (`id_cliente`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `usersid` FOREIGN KEY (`id_usuario`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ventas_ibfk_2` FOREIGN KEY (`id_metodo_pago`) REFERENCES `metodos_pago` (`id_metodo_pago`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `ventas_anuladas`
--
ALTER TABLE `ventas_anuladas`
  ADD CONSTRAINT `useranul` FOREIGN KEY (`id_usuario_anulador`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ventas_anuladas_ibfk_1` FOREIGN KEY (`id_venta`) REFERENCES `ventas` (`id_venta`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `ventas_productos`
--
ALTER TABLE `ventas_productos`
  ADD CONSTRAINT `ventas_productos_ibfk_1` FOREIGN KEY (`id_venta`) REFERENCES `ventas` (`id_venta`),
  ADD CONSTRAINT `ventas_productos_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
