-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 12-12-2024 a las 20:27:45
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
(1, 'lacteos', 'productos provenientes de la leche'),
(2, 'Panadería', 'Pan fresco, bollería y productos horneados'),
(3, 'Frutas y Verduras', 'Productos frescos de frutas y verduras'),
(4, 'Carnes', 'Carnes frescas y embutidos'),
(5, 'Bebidas', 'Refrescos, jugos, agua y bebidas alcohólicas'),
(6, 'Congelados', 'Alimentos congelados y helados'),
(7, 'Abarrotes', 'Productos secos y enlatados'),
(8, 'Limpieza', 'Productos de limpieza para el hogar'),
(9, 'Higiene Personal', 'Artículos de cuidado personal y cosmética'),
(10, 'Snacks', 'Botanas, galletas y dulces'),
(11, 'Mascotas', 'Alimentos y accesorios para mascotas'),
(12, 'Hogar', 'Artículos básicos para el hogar'),
(13, 'Bebés', 'Productos para el cuidado de bebés'),
(14, 'Desayuno', 'Cereales, mermeladas y productos para el desayuno'),
(15, 'Condimentos', 'Especias, salsas y aderezos');

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
(11, 6000.00, '2024-12-12 12:43:47', 1);

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
  `fecha_gasto` date NOT NULL DEFAULT current_timestamp(),
  `categoria` enum('administrativo','logistico','cotidiano','deudas') DEFAULT NULL,
  `id_usuario` bigint(20) UNSIGNED NOT NULL,
  `motivo` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `gastos`
--

INSERT INTO `gastos` (`id_gasto`, `descripcion`, `monto`, `fecha_gasto`, `categoria`, `id_usuario`, `motivo`) VALUES
(1, 'mercaderia', 500.55, '2024-11-10', 'logistico', 2, 'compras'),
(3, 'sueldo', 400.00, '2024-11-23', 'deudas', 2, 'pagar'),
(5, 'envio', 1500.00, '2024-11-23', 'logistico', 2, 'pagar');

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
(1, 'coca', '123456', '123456', 1, 9, 600.00, 1, 1125.00, 'activo'),
(6, 'coca 3L', '1234562', '111333444', 2, 56, 2700.00, 1, 7200.00, 'activo'),
(8, 'chocolate blanco', '12578', '15778966', 2, 84, 5400.00, 1, 14400.00, 'activo'),
(9, 'chocolate milka', '123456789909', '123456789909', 2, 78, 5400.00, 1, 10800.00, 'activo'),
(11, 'pepsi 2.25', '8678787', '234513279851', 1, 6, 1500.00, 1, 2500.00, 'activo'),
(12, 'pepsi 3l', '2345342534', '412341234', 2, 50, 3000.00, 1, 12000.00, 'activo'),
(13, 'pepsi 500ml', '12345', '1233245423', 2, 4, 4800.00, 1, 7200.00, 'desactivado'),
(14, 'pan mignon', '111', '12345566', 2, 49, 2400.00, 2, 5400.00, 'activo');

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
(23, 1, 10, 11);

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
('ATnMkUE58LwXvpxcsmQUaz80N65f4X9NGzdocKzC', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWFd5RWhhVmlUNVRvd0ZuR1VoVW9MVkcwdFVUSU9SemtOWWxDcmlHUiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9sb2dpbiI7fX0=', 1734028884);

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
(2, 'prueba2', 'prueba2@gmail.com', NULL, '$2y$12$FQojJnYwgpYkwUcys.gb0elS6uetuoYTK7fVM5CHlqwcJJrptOgmy', NULL, '2024-11-10 23:22:20', '2024-11-10 23:22:20', 'empleado', 'activo'),
(10, 'prueba3', 'prueba3@gmail.com', NULL, '$2y$12$wdB7l9G69gyW92QHcKP.PuBYm7gLQS6A7DTk38zly9hxumdDPwgeS', NULL, NULL, NULL, 'administrador', 'desactivado'),
(11, 'admin', 'admin@gmail.com', NULL, '$2y$12$8opCHL7Xediw3GAl/EF7seHMCrEYn8oppva6GTHHYgDmwkfLZrY9u', NULL, '2024-11-25 22:48:17', '2024-11-25 22:48:17', 'administrador', 'activo'),
(12, 'caja 1', 'caja1@gmail.com', NULL, '$2y$12$W8SKHkMc9MYqJa04S.dtqeHZ8P2QhdzFho6Hmh/9.EW8l1ZDmbiW2', NULL, '2024-11-25 22:48:58', '2024-11-25 22:48:58', 'empleado', 'activo'),
(13, 'caja 2', 'caja2@gmail.com', NULL, '$2y$12$8oRVhbv/Mh2MUh.whltaZuYFMemcr6kdRCsbsexW1CZg/j.hWpDJ2', NULL, '2024-11-25 22:49:24', '2024-11-25 22:49:24', 'empleado', 'activo'),
(14, 'caja 3', 'caja3@gmail.com', NULL, '$2y$12$p9Z.BCajwIiUgXyYTeTMR.coHgOT80V5fWyawdCZ3w3oVB9YT.kAi', NULL, '2024-11-25 20:34:11', '2024-11-25 20:34:11', 'empleado', 'activo'),
(15, 'caja4', 'caja4@gmail.com', NULL, '$2y$12$JuZPYbXa2O0TmeQJtW55gea6zML8IDoBgPT966/iWXE2ul4hbyVcq', NULL, '2024-12-12 18:21:19', '2024-12-12 18:21:19', 'administrador', 'activo'),
(16, 'caja5', 'caja5@gmail.com', NULL, '$2y$12$cakfdwRtY6GRSMqAWxuwUeXhGlxMrtFrQenozkrGzrnfl/.KFDVJC', NULL, '2024-12-12 18:21:35', '2024-12-12 18:21:35', 'empleado', 'activo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `id_venta` bigint(20) NOT NULL,
  `id_usuario` bigint(20) UNSIGNED NOT NULL,
  `fecha_venta` date NOT NULL DEFAULT current_timestamp(),
  `monto_total` decimal(10,2) NOT NULL,
  `id_metodo_pago` bigint(20) NOT NULL,
  `descuento` decimal(10,2) DEFAULT NULL,
  `id_cliente` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`id_venta`, `id_usuario`, `fecha_venta`, `monto_total`, `id_metodo_pago`, `descuento`, `id_cliente`) VALUES
(1, 2, '2024-11-25', 650.00, 2, 100.00, NULL),
(2, 2, '2024-11-25', 1200.00, 2, 0.00, NULL),
(3, 2, '2024-11-25', 2550.00, 1, 0.00, NULL),
(4, 2, '2024-11-25', 250.00, 3, 500.00, NULL),
(5, 2, '2024-11-25', 250.00, 3, 500.00, NULL),
(6, 2, '2024-11-25', 550.00, 3, 200.00, 1),
(7, 2, '2024-11-25', 700.00, 2, 500.00, NULL),
(8, 2, '2024-11-25', 1000.00, 3, 200.00, 1),
(9, 2, '2024-11-25', 250.00, 2, 500.00, NULL),
(10, 2, '2024-11-25', 1500.00, 2, 300.00, NULL),
(11, 2, '2024-11-25', 3250.00, 3, 500.00, 1),
(12, 2, '2024-11-25', 1950.00, 1, 0.00, NULL),
(13, 13, '2024-11-25', 600.00, 2, 525.00, NULL),
(14, 14, '2024-11-25', 625.00, 2, 500.00, NULL),
(15, 14, '2024-11-25', 1500.00, 2, 900.00, NULL),
(16, 11, '2024-12-10', 1125.00, 1, 0.00, NULL),
(17, 11, '2024-12-11', 700.00, 3, 500.00, 1),
(18, 11, '2024-12-12', 2200.00, 3, 200.00, 3),
(19, 11, '2024-12-12', 1125.00, 1, 0.00, NULL),
(20, 11, '2024-12-12', 1200.00, 2, 0.00, NULL),
(21, 11, '2024-12-12', 1125.00, 1, 0.00, NULL),
(22, 11, '2024-12-12', 13725.00, 3, 0.00, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas_anuladas`
--

CREATE TABLE `ventas_anuladas` (
  `id_venta_anulada` bigint(20) NOT NULL,
  `id_venta` bigint(20) NOT NULL,
  `id_usuario_anulador` bigint(20) UNSIGNED NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `fecha_anu` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ventas_anuladas`
--

INSERT INTO `ventas_anuladas` (`id_venta_anulada`, `id_venta`, `id_usuario_anulador`, `descripcion`, `fecha_anu`) VALUES
(2, 2, 2, 'se cobro en efectivo', '2024-11-23'),
(3, 4, 13, 'el cliente devolvio el producto', '2024-11-21'),
(4, 15, 11, 'Producto Vencido', '2024-12-03'),
(5, 14, 11, 'x motivo', '2024-12-02'),
(6, 9, 12, 'se cobro mal', '2024-12-11'),
(7, 3, 11, 'no se aplico el descuento', '2024-12-11'),
(8, 16, 11, 'prueba', '2024-12-12'),
(9, 21, 11, 'sin gas', '2024-12-12');

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
(26, 22, 14, 1, 5400.00);

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
  MODIFY `id_compra` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `gastos`
--
ALTER TABLE `gastos`
  MODIFY `id_gasto` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

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
  MODIFY `id_producto` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `productosxcompras`
--
ALTER TABLE `productosxcompras`
  MODIFY `id_pxc` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  MODIFY `id_proveedor` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `id_venta` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `ventas_anuladas`
--
ALTER TABLE `ventas_anuladas`
  MODIFY `id_venta_anulada` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `ventas_productos`
--
ALTER TABLE `ventas_productos`
  MODIFY `id_venta_producto` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

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
