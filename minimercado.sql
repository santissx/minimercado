-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 18-06-2026 a las 00:56:57
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

--
-- Volcado de datos para la tabla `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('admin@gmail.com|127.0.0.1', 'i:2;', 1781547597),
('admin@gmail.com|127.0.0.1:timer', 'i:1781547597;', 1781547597);

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
(3, 'cliente_corriente'),
(4, 'mercado pago'),
(5, 'Tarjeta de credito');

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
(39, 'coca', '123456', '123456', 5, 0, 50.00, 12, 800.00, 'activo'),
(164, 'Llave térmica 2x16A Sica', '7654342', '7654321000132', 5, 44, 4500.00, 1, 6500.00, 'activo'),
(165, 'Disyuntor diferencial 2x40A', '7654343', '7654321000133', 5, 19, 25000.00, 1, 35000.00, 'activo'),
(166, 'Llave térmica 2x25A', '7654344', '7654321000134', 5, 42, 4500.00, 1, 6500.00, 'activo'),
(167, 'Cable unipolar 2.5mm celeste x100m', '7654345', '7654321000135', 5, 14, 18000.00, 2, 26000.00, 'activo'),
(168, 'Cable unipolar 1.5mm rojo x100m', '7654346', '7654321000136', 5, 17, 12000.00, 2, 17500.00, 'activo'),
(169, 'Cable tipo taller 3x1.5mm x metro', '7654347', '7654321000137', 5, 499, 800.00, 2, 1300.00, 'activo'),
(170, 'Caja rectangular chapa semipesada', '7654348', '7654321000138', 5, 149, 400.00, 3, 750.00, 'activo'),
(171, 'Caja octogonal PVC', '7654349', '7654321000139', 5, 199, 300.00, 3, 550.00, 'activo'),
(172, 'Caja estanca 100x100 IP65', '7654350', '7654321000140', 5, 39, 2500.00, 3, 4000.00, 'activo'),
(173, 'Pinza universal aislada 1000V', '7654351', '7654321000141', 5, 11, 12000.00, 4, 18500.00, 'activo'),
(174, 'Multímetro digital', '7654352', '7654321000142', 5, 7, 28000.00, 4, 42000.00, 'activo'),
(175, 'Cinta pasacables plástico 15m', '7654353', '7654321000143', 5, 24, 6500.00, 4, 9800.00, 'activo'),
(176, 'Lámpara LED 9W E27 luz fría', '7654354', '7654321000144', 5, 300, 1100.00, 5, 1800.00, 'activo'),
(177, 'Panel LED 60x60 40W', '7654355', '7654321000145', 5, 34, 15000.00, 5, 23000.00, 'activo'),
(178, 'Reflector LED 50W exterior', '7654356', '7654321000146', 5, 24, 9500.00, 5, 14500.00, 'activo'),
(179, 'Caño corrugado 3/4 blanco x25m', '7654357', '7654321000147', 5, 59, 4500.00, 6, 7200.00, 'activo'),
(180, 'Cablecanal 20x10mm c/adhesivo x2m', '7654358', '7654321000148', 5, 119, 1800.00, 6, 2900.00, 'activo'),
(181, 'Tomacorriente doble c/tierra 10A', '7654359', '7654321000149', 5, 79, 2200.00, 7, 3500.00, 'activo'),
(182, 'Módulo interruptor simple', '7654360', '7654321000150', 5, 150, 1200.00, 7, 1900.00, 'activo'),
(183, 'Bastidor 10x5 PVC', '7654361', '7654321000151', 5, 199, 400.00, 7, 700.00, 'activo'),
(184, 'Jabalina acero cobre 5/8 x 1.5m', '7654362', '7654321000152', 5, 14, 18000.00, 8, 27000.00, 'activo'),
(185, 'Tomacable bronce para jabalina', '7654363', '7654321000153', 5, 29, 2500.00, 8, 3800.00, 'activo'),
(186, 'Tablero embutir 12 a 16 bocas', '7654364', '7654321000154', 5, 9, 14000.00, 9, 21000.00, 'activo'),
(187, 'Tablero exterior 8 bocas DIN', '7654365', '7654321000155', 5, 15, 9000.00, 9, 13500.00, 'desactivado'),
(188, 'Ventilador de techo c/luz paletas metal', '7654366', '7654321000156', 5, 5, 85000.00, 10, 125000.00, 'activo'),
(189, 'Extractor de aire para baño 4 pulg', '7654367', '7654321000157', 5, 12, 22000.00, 10, 33000.00, 'activo'),
(190, 'Cinta aisladora negra 10m PVC', '7654368', '7654321000158', 5, 399, 800.00, 11, 1300.00, 'activo'),
(191, 'Precintos plásticos 200x4.8mm x100', '7654369', '7654321000159', 5, 149, 3000.00, 11, 4800.00, 'activo'),
(192, 'Tarugos con tope Nro 6 x100', '7654370', '7654321000160', 5, 80, 1500.00, 12, 2500.00, 'activo'),
(193, 'Visita técnica revisión eléctrica', '7654371', '7654321000161', 5, 999, 15000.00, 13, 15000.00, 'activo'),
(194, 'Instalación ventilador de techo', '7654372', '7654321000162', 5, 998, 35000.00, 14, 35000.00, 'activo'),
(195, 'dsfasd', '345325', '5475647456', 5, 2, 56000.00, 5, 112000.00, 'activo');

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
(5, 'proveedor_1', '4444444', 'dsfasd', 'prove@gmail.com', 'provee', '44444', 'activo');

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
('O1PTImRy0Ek7xdep0YIx98lmVCokaOiutvrqKvST', 11, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36 Edg/149.0.0.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiMXBIWDhTZFRsWXNTMFpuQlFSQUlWUUNSS3BsazJEUHJIMmVlZU1zUCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6OTI6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9iYWxhbmNlcz9hbmlvPSZmZWNoYWZpbj0mZmVjaGFpbmljaW89MjAyNi0wNi0xNyZ2aXN0YT1iYWxhbmNlX3Bvc2l0aXZvIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTE7fQ==', 1781734611),
('RA5QVQNvOmAFU4LnshmLWqKO2KjzxQbt8AZ8Q3g9', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMlIybFhjRk01SW5COTlqRVk2UjhFR3lta290bVNsOGVHRzlsUEtreSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9sb2dpbiI7fX0=', 1781734059);

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
(11, 'Admin', 'solucioneselectricasfsa@gmail.com', NULL, '$2y$12$hpNDjfYkMgeTmfpK8bhfCesIBK19cXtlAuUT0/1v8NQXFwE574Hhe', NULL, '2024-11-25 22:48:17', '2024-11-25 22:48:17', 'administrador', 'activo');

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
(47, 11, '2026-06-15 15:22:01', 800.00, 1, 0.00, NULL),
(48, 11, '2026-06-15 15:48:37', 301100.00, 2, 12000.00, NULL),
(49, 11, '2026-06-15 15:49:18', 13000.00, 2, 0.00, NULL),
(50, 11, '2026-06-15 15:53:58', 300.00, 2, 500.00, NULL),
(51, 11, '2026-06-15 16:05:20', 9000.00, 2, 800.00, NULL),
(52, 11, '2026-06-16 19:50:16', 6500.00, 2, 0.00, NULL),
(53, 11, '2026-06-17 16:10:20', 750.00, 2, 0.00, NULL),
(56, 11, '2026-06-17 18:53:51', 6500.00, 2, 0.00, NULL),
(57, 11, '2026-06-17 18:56:12', 6500.00, 2, 0.00, NULL),
(58, 11, '2026-06-17 18:57:20', 6500.00, 2, 0.00, NULL),
(59, 11, '2026-06-17 18:58:10', 5500.00, 1, 1000.00, NULL),
(60, 11, '2026-06-17 19:08:25', 6500.00, 2, 0.00, NULL),
(61, 11, '2026-06-17 19:16:06', 23000.00, 2, 0.00, NULL);

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
(1, 53, 11, 'prueba', '2026-06-17 18:21:08'),
(2, 51, 11, 'PRUEBA', '2026-06-17 18:46:10'),
(3, 59, 11, 'PRUEBA', '2026-06-17 19:07:22'),
(4, 61, 11, 'prueba2', '2026-06-17 19:16:45');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas_productos`
--

CREATE TABLE `ventas_productos` (
  `id_venta_producto` bigint(20) NOT NULL,
  `id_venta` bigint(20) NOT NULL,
  `id_producto` bigint(20) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `precio_lista` decimal(10,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ventas_productos`
--

INSERT INTO `ventas_productos` (`id_venta_producto`, `id_venta`, `id_producto`, `cantidad`, `precio`, `precio_lista`) VALUES
(1, 47, 39, 1, 800.00, 0.00),
(2, 48, 165, 1, 35000.00, 0.00),
(3, 48, 164, 1, 6500.00, 3000.00),
(4, 48, 166, 1, 6500.00, 0.00),
(5, 48, 167, 1, 26000.00, 0.00),
(6, 48, 168, 1, 17500.00, 0.00),
(7, 48, 169, 1, 1300.00, 0.00),
(8, 48, 175, 1, 9800.00, 0.00),
(9, 48, 180, 1, 2900.00, 0.00),
(10, 48, 185, 1, 3800.00, 0.00),
(11, 48, 170, 1, 750.00, 0.00),
(12, 48, 171, 1, 550.00, 0.00),
(13, 48, 172, 1, 4000.00, 0.00),
(14, 48, 173, 1, 18500.00, 0.00),
(15, 48, 174, 1, 42000.00, 0.00),
(16, 48, 190, 1, 1300.00, 0.00),
(17, 48, 191, 1, 4800.00, 0.00),
(18, 48, 194, 1, 35000.00, 0.00),
(19, 48, 177, 1, 23000.00, 0.00),
(20, 48, 178, 1, 14500.00, 0.00),
(21, 48, 179, 1, 7200.00, 0.00),
(22, 48, 181, 1, 3500.00, 0.00),
(23, 48, 183, 1, 700.00, 0.00),
(24, 48, 184, 1, 27000.00, 0.00),
(25, 48, 186, 1, 21000.00, 0.00),
(26, 49, 164, 1, 6500.00, 0.00),
(27, 49, 166, 1, 6500.00, 0.00),
(28, 50, 39, 1, 800.00, 0.00),
(29, 51, 175, 1, 9800.00, 0.00),
(30, 52, 164, 1, 6500.00, 3000.00),
(31, 53, 170, 1, 750.00, 0.00),
(32, 56, 164, 1, 6500.00, 0.00),
(33, 57, 164, 1, 6500.00, 0.00),
(34, 58, 164, 1, 6500.00, 4500.00),
(35, 59, 164, 1, 6500.00, 4500.00),
(36, 60, 166, 1, 6500.00, 4500.00),
(37, 61, 177, 1, 23000.00, 15000.00);

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
  MODIFY `id_gasto` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `metodos_pago`
--
ALTER TABLE `metodos_pago`
  MODIFY `id_metodo_pago` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id_producto` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=196;

--
-- AUTO_INCREMENT de la tabla `productosxcompras`
--
ALTER TABLE `productosxcompras`
  MODIFY `id_pxc` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  MODIFY `id_proveedor` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `id_venta` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

--
-- AUTO_INCREMENT de la tabla `ventas_anuladas`
--
ALTER TABLE `ventas_anuladas`
  MODIFY `id_venta_anulada` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `ventas_productos`
--
ALTER TABLE `ventas_productos`
  MODIFY `id_venta_producto` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

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
