-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 13-08-2026 a las 23:03:19
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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
-- Estructura de tabla para la tabla `presupuestos`
--

CREATE TABLE `presupuestos` (
  `id_presupuesto` int(11) NOT NULL,
  `id_usuario` bigint(20) UNSIGNED DEFAULT NULL,
  `titulo` varchar(255) DEFAULT NULL,
  `fecha` datetime NOT NULL,
  `monto_total` decimal(10,2) NOT NULL DEFAULT 0.00,
  `descuento` decimal(10,2) NOT NULL DEFAULT 0.00,
  `nombre_cliente` varchar(150) DEFAULT NULL,
  `telefono_cliente` varchar(50) DEFAULT NULL,
  `observaciones` text DEFAULT NULL,
  `estado` varchar(30) DEFAULT 'pendiente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `presupuestos_productos`
--

CREATE TABLE `presupuestos_productos` (
  `id_presupuesto_producto` int(11) NOT NULL,
  `id_presupuesto` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `id_promocion` int(11) DEFAULT NULL,
  `cantidad` int(11) NOT NULL,
  `precio` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productosxcompras`
--

CREATE TABLE `productosxcompras` (
  `id_pxc` bigint(20) NOT NULL,
  `id_producto` bigint(20) NOT NULL,
  `cantidad_agregada` int(11) NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL,
  `id_compra` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `promociones`
--

CREATE TABLE `promociones` (
  `id_promocion` bigint(20) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `estado` enum('activo','inactivo') DEFAULT 'activo',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `promocion_productos`
--

CREATE TABLE `promocion_productos` (
  `id_promocion_producto` bigint(20) NOT NULL,
  `id_promocion` bigint(20) NOT NULL,
  `id_producto` bigint(20) NOT NULL,
  `cantidad` int(11) NOT NULL DEFAULT 1
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
  `id_cliente` bigint(20) DEFAULT NULL,
  `cliente_nombre` varchar(255) DEFAULT NULL,
  `cliente_telefono` varchar(50) DEFAULT NULL,
  `observaciones` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
-- Indices de la tabla `presupuestos`
--
ALTER TABLE `presupuestos`
  ADD PRIMARY KEY (`id_presupuesto`);

--
-- Indices de la tabla `presupuestos_productos`
--
ALTER TABLE `presupuestos_productos`
  ADD PRIMARY KEY (`id_presupuesto_producto`),
  ADD KEY `id_presupuesto` (`id_presupuesto`);

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
-- Indices de la tabla `promociones`
--
ALTER TABLE `promociones`
  ADD PRIMARY KEY (`id_promocion`);

--
-- Indices de la tabla `promocion_productos`
--
ALTER TABLE `promocion_productos`
  ADD PRIMARY KEY (`id_promocion_producto`),
  ADD KEY `id_promocion` (`id_promocion`),
  ADD KEY `id_producto` (`id_producto`);

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
  MODIFY `id_cliente` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `compras`
--
ALTER TABLE `compras`
  MODIFY `id_compra` bigint(20) NOT NULL AUTO_INCREMENT;

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
  MODIFY `id_metodo_pago` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `presupuestos`
--
ALTER TABLE `presupuestos`
  MODIFY `id_presupuesto` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `presupuestos_productos`
--
ALTER TABLE `presupuestos_productos`
  MODIFY `id_presupuesto_producto` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id_producto` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `productosxcompras`
--
ALTER TABLE `productosxcompras`
  MODIFY `id_pxc` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `promociones`
--
ALTER TABLE `promociones`
  MODIFY `id_promocion` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `promocion_productos`
--
ALTER TABLE `promocion_productos`
  MODIFY `id_promocion_producto` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  MODIFY `id_proveedor` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `id_venta` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `ventas_anuladas`
--
ALTER TABLE `ventas_anuladas`
  MODIFY `id_venta_anulada` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `ventas_productos`
--
ALTER TABLE `ventas_productos`
  MODIFY `id_venta_producto` bigint(20) NOT NULL AUTO_INCREMENT;

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
-- Filtros para la tabla `presupuestos_productos`
--
ALTER TABLE `presupuestos_productos`
  ADD CONSTRAINT `presupuestos_productos_ibfk_1` FOREIGN KEY (`id_presupuesto`) REFERENCES `presupuestos` (`id_presupuesto`) ON DELETE CASCADE;

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
-- Filtros para la tabla `promocion_productos`
--
ALTER TABLE `promocion_productos`
  ADD CONSTRAINT `fk_producto_ref` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_promocion_ref` FOREIGN KEY (`id_promocion`) REFERENCES `promociones` (`id_promocion`) ON DELETE CASCADE ON UPDATE CASCADE;

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
