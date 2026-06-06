-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: 127.0.0.1    Database: minimercado
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache`
--

LOCK TABLES `cache` WRITE;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_locks`
--

LOCK TABLES `cache_locks` WRITE;
/*!40000 ALTER TABLE `cache_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categorias`
--

DROP TABLE IF EXISTS `categorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorias` (
  `id_categoria` bigint(20) NOT NULL AUTO_INCREMENT,
  `categoria` varchar(255) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  PRIMARY KEY (`id_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorias`
--

LOCK TABLES `categorias` WRITE;
/*!40000 ALTER TABLE `categorias` DISABLE KEYS */;
INSERT INTO `categorias` VALUES (1,'lacteos','productos provenientes de la leche'),(2,'Panadería','Pan fresco, bollería y productos horneados'),(3,'Frutas y Verduras','Productos frescos de frutas y verduras'),(4,'Carnes','Carnes frescas y embutidos'),(5,'Bebidas','Refrescos, jugos, agua y bebidas alcohólicas'),(6,'Congelados','Alimentos congelados y helados'),(7,'Abarrotes','Productos secos y enlatados'),(8,'Limpieza','Productos de limpieza para el hogar'),(9,'Higiene Personal','Artículos de cuidado personal y cosmética'),(10,'Snacks','Botanas, galletas y dulces'),(11,'Mascotas','Alimentos y accesorios para mascotas'),(12,'Hogar','Artículos básicos para el hogar'),(13,'Bebés','Productos para el cuidado de bebés'),(14,'Desayuno','Cereales, mermeladas y productos para el desayuno'),(15,'Condimentos','Especias, salsas y aderezos');
/*!40000 ALTER TABLE `categorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clientes_corrientes`
--

DROP TABLE IF EXISTS `clientes_corrientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clientes_corrientes` (
  `id_cliente` bigint(20) NOT NULL AUTO_INCREMENT,
  `nombre_y_apellido` varchar(255) NOT NULL,
  `DNI` bigint(15) NOT NULL,
  `telefono` bigint(14) DEFAULT NULL,
  `estado` enum('activo','desactivado') DEFAULT 'activo',
  PRIMARY KEY (`id_cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes_corrientes`
--

LOCK TABLES `clientes_corrientes` WRITE;
/*!40000 ALTER TABLE `clientes_corrientes` DISABLE KEYS */;
INSERT INTO `clientes_corrientes` VALUES (1,'carlos tevez',53555555,3704653535,'desactivado'),(3,'martin palermo',23456888,3704444423,'activo'),(4,'exequiel fernandez',43777888,1234555555,'activo'),(5,'exequiel ceballos',46777777,3704206331,'desactivado');
/*!40000 ALTER TABLE `clientes_corrientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compras`
--

DROP TABLE IF EXISTS `compras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `compras` (
  `id_compra` bigint(20) NOT NULL AUTO_INCREMENT,
  `monto_compra` decimal(10,2) NOT NULL,
  `fecha` datetime DEFAULT current_timestamp(),
  `id_proveedor` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id_compra`),
  KEY `prov` (`id_proveedor`),
  CONSTRAINT `prov` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedores` (`id_proveedor`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compras`
--

LOCK TABLES `compras` WRITE;
/*!40000 ALTER TABLE `compras` DISABLE KEYS */;
INSERT INTO `compras` VALUES (2,9000.00,'2024-11-24 23:57:12',2),(3,9000.00,'2024-11-24 23:58:03',2),(4,1500.00,'2024-11-25 00:22:13',2),(6,800.00,'2024-11-25 00:24:11',2),(11,6000.00,'2024-12-12 12:43:47',1),(12,1222.00,'2026-01-27 14:19:37',1);
/*!40000 ALTER TABLE `compras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gastos`
--

DROP TABLE IF EXISTS `gastos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gastos` (
  `id_gasto` bigint(20) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(255) NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `fecha_gasto` datetime NOT NULL DEFAULT current_timestamp(),
  `categoria` enum('administrativo','logistico','cotidiano','deudas') DEFAULT NULL,
  `id_usuario` bigint(20) unsigned NOT NULL,
  `motivo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_gasto`),
  KEY `gastos_ibfk_1` (`categoria`),
  KEY `gastos_usu` (`id_usuario`),
  CONSTRAINT `gastos_usu` FOREIGN KEY (`id_usuario`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gastos`
--

LOCK TABLES `gastos` WRITE;
/*!40000 ALTER TABLE `gastos` DISABLE KEYS */;
INSERT INTO `gastos` VALUES (1,'mercaderia',500.55,'2024-11-10 00:00:00','logistico',2,'compras'),(3,'sueldo',400.00,'2024-11-23 00:00:00','deudas',2,'pagar'),(5,'envio',1500.00,'2024-11-23 00:00:00','logistico',2,'pagar'),(9,'gasto en uber',2500.00,'2026-06-06 18:48:40','logistico',11,'delivery');
/*!40000 ALTER TABLE `gastos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
  `finished_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_batches`
--

LOCK TABLES `job_batches` WRITE;
/*!40000 ALTER TABLE `job_batches` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metodos_pago`
--

DROP TABLE IF EXISTS `metodos_pago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `metodos_pago` (
  `id_metodo_pago` bigint(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`id_metodo_pago`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metodos_pago`
--

LOCK TABLES `metodos_pago` WRITE;
/*!40000 ALTER TABLE `metodos_pago` DISABLE KEYS */;
INSERT INTO `metodos_pago` VALUES (1,'efectivo'),(2,'transferencia'),(3,'cliente_corriente');
/*!40000 ALTER TABLE `metodos_pago` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'0001_01_01_000000_create_users_table',1),(2,'0001_01_01_000001_create_cache_table',1),(3,'0001_01_01_000002_create_jobs_table',1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `productos` (
  `id_producto` bigint(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `codigo` varchar(100) NOT NULL,
  `codigo_barra` varchar(100) NOT NULL,
  `id_proveedor` bigint(20) NOT NULL,
  `stock` int(11) DEFAULT NULL,
  `precio_lista` decimal(10,2) DEFAULT NULL,
  `id_categoria` bigint(20) DEFAULT NULL,
  `precio_venta` decimal(10,2) DEFAULT NULL,
  `estado` enum('activo','desactivado') DEFAULT 'activo',
  PRIMARY KEY (`id_producto`),
  UNIQUE KEY `codigo` (`codigo`),
  UNIQUE KEY `codigo_barra` (`codigo_barra`),
  KEY `id_proveedor` (`id_proveedor`),
  KEY `producxcategoria` (`id_categoria`),
  CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedores` (`id_proveedor`),
  CONSTRAINT `producxcategoria` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id_categoria`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES (1,'coca','123456','123456',1,29,600.00,1,1125.00,'activo'),(6,'coca 3L','1234562','111333444',2,55,2700.00,1,7200.00,'activo'),(8,'chocolate blanco','12578','15778966',2,84,5400.00,1,14400.00,'activo'),(9,'chocolate milka','123456789909','123456789909',2,78,5400.00,1,10800.00,'activo'),(11,'pepsi 2.25','8678787','234513279851',1,0,1500.00,1,2500.00,'activo'),(12,'pepsi 3l','2345342534','412341234',2,47,3000.00,1,12000.00,'activo'),(13,'pepsi 500ml','12345','1233245423',2,4,4800.00,1,7200.00,'desactivado'),(14,'pan mignon','111','12345566',2,49,2400.00,2,5400.00,'activo');
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productosxcompras`
--

DROP TABLE IF EXISTS `productosxcompras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `productosxcompras` (
  `id_pxc` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_producto` bigint(20) NOT NULL,
  `cantidad_agregada` int(11) NOT NULL,
  `id_compra` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id_pxc`),
  KEY `pxc` (`id_producto`),
  KEY `compra` (`id_compra`),
  CONSTRAINT `compra` FOREIGN KEY (`id_compra`) REFERENCES `compras` (`id_compra`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pxc` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productosxcompras`
--

LOCK TABLES `productosxcompras` WRITE;
/*!40000 ALTER TABLE `productosxcompras` DISABLE KEYS */;
INSERT INTO `productosxcompras` VALUES (3,6,5,2),(4,9,5,2),(5,6,5,3),(6,9,5,3),(7,8,2,4),(8,6,2,4),(10,8,5,6),(11,9,8,6),(12,6,7,6),(23,1,10,11),(24,1,22,12);
/*!40000 ALTER TABLE `productosxcompras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proveedores`
--

DROP TABLE IF EXISTS `proveedores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proveedores` (
  `id_proveedor` bigint(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `telefono` varchar(50) NOT NULL,
  `direccion` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `nombre_preventista` varchar(255) DEFAULT NULL,
  `num_preventista` varchar(20) DEFAULT NULL,
  `estado` enum('activo','desactivado') DEFAULT 'activo',
  PRIMARY KEY (`id_proveedor`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedores`
--

LOCK TABLES `proveedores` WRITE;
/*!40000 ALTER TABLE `proveedores` DISABLE KEYS */;
INSERT INTO `proveedores` VALUES (1,'arca continental','3704444444','9 de julio 101','arcacontinental@gmail.com','lucas  armand  ugon','2147483647','desactivado'),(2,'alfa','3704222222','9 de julio 805','alfa@gmail.com','lucas2','2147483647','activo');
/*!40000 ALTER TABLE `proveedores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES ('QqSkx7SPlV68HvmspNu8Su6GLS1krlVZdxaCIUUu',18,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36 Edg/148.0.0.0','YTo0OntzOjY6Il90b2tlbiI7czo0MDoiang2THFFQ0gwU2ZzN2RlNndJNGtrZnNCZ2dMWnF0SHNuZk13U2djUCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjg6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC92ZW50YXMiO31zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxODt9',1780785409),('YUa4xrxKNYe4OnRrnSXwJ0RvmYivVFEaWBQIEHKF',11,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.122.1 Chrome/142.0.7444.265 Electron/39.8.8 Safari/537.36','YTo0OntzOjY6Il90b2tlbiI7czo0MDoidVVDb0hzRkRmT0NsZ2dBTjU1ejRwNUNGdnpGblkxNlRkdFU3RnBseiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJuZXciO2E6MDp7fXM6Mzoib2xkIjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9saXN0YSI7fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjExO30=',1780778819);
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp(),
  `rol` enum('administrador','empleado') DEFAULT NULL,
  `estado` enum('activo','desactivado') DEFAULT 'activo',
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (2,'prueba2','prueba2@gmail.com',NULL,'$2y$12$FQojJnYwgpYkwUcys.gb0elS6uetuoYTK7fVM5CHlqwcJJrptOgmy',NULL,'2024-11-10 23:22:20','2024-11-10 23:22:20','empleado','desactivado'),(10,'prueba3','prueba3@gmail.com',NULL,'$2y$12$wdB7l9G69gyW92QHcKP.PuBYm7gLQS6A7DTk38zly9hxumdDPwgeS',NULL,NULL,NULL,'administrador','desactivado'),(11,'admin','admin@gmail.com',NULL,'$2y$12$8opCHL7Xediw3GAl/EF7seHMCrEYn8oppva6GTHHYgDmwkfLZrY9u',NULL,'2024-11-25 22:48:17','2024-11-25 22:48:17','administrador','activo'),(12,'caja 1','caja1@gmail.com',NULL,'$2y$12$W8SKHkMc9MYqJa04S.dtqeHZ8P2QhdzFho6Hmh/9.EW8l1ZDmbiW2',NULL,'2024-11-25 22:48:58','2024-11-25 22:48:58','empleado','desactivado'),(13,'caja 2','caja2@gmail.com',NULL,'$2y$12$8oRVhbv/Mh2MUh.whltaZuYFMemcr6kdRCsbsexW1CZg/j.hWpDJ2',NULL,'2024-11-25 22:49:24','2024-11-25 22:49:24','empleado','desactivado'),(14,'caja 3','caja3@gmail.com',NULL,'$2y$12$p9Z.BCajwIiUgXyYTeTMR.coHgOT80V5fWyawdCZ3w3oVB9YT.kAi',NULL,'2024-11-25 20:34:11','2024-11-25 20:34:11','empleado','desactivado'),(15,'caja4','caja4@gmail.com',NULL,'$2y$12$JuZPYbXa2O0TmeQJtW55gea6zML8IDoBgPT966/iWXE2ul4hbyVcq',NULL,'2024-12-12 18:21:19','2024-12-12 18:21:19','administrador','desactivado'),(16,'caja5','caja5@gmail.com',NULL,'$2y$12$cakfdwRtY6GRSMqAWxuwUeXhGlxMrtFrQenozkrGzrnfl/.KFDVJC',NULL,'2024-12-12 18:21:35','2024-12-12 18:21:35','empleado','desactivado'),(17,'admin2','caja16@gmail.com',NULL,'$2y$12$b460gVqtszVuCu.0JsW37eY.veAHBfwLeDzBzR7dI2MvJ3lu50U8u',NULL,'2026-06-06 22:31:24','2026-06-06 22:31:24','administrador','activo'),(18,'cajaprueba','cajaprueba@gmail.com',NULL,'$2y$12$sSblXRB2uvLsG2w2AYuuWumLZ2ONg3tOTpJlDNLR2Zf/FtfKeKIoO',NULL,'2026-06-06 22:33:25','2026-06-06 22:33:25','empleado','activo');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventas`
--

DROP TABLE IF EXISTS `ventas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ventas` (
  `id_venta` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_usuario` bigint(20) unsigned NOT NULL,
  `fecha_venta` datetime NOT NULL DEFAULT current_timestamp(),
  `monto_total` decimal(10,2) NOT NULL,
  `id_metodo_pago` bigint(20) NOT NULL,
  `descuento` decimal(10,2) DEFAULT NULL,
  `id_cliente` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id_venta`),
  KEY `ventas_ibfk_2` (`id_metodo_pago`),
  KEY `usersid` (`id_usuario`),
  KEY `clientes_Corrientes` (`id_cliente`),
  CONSTRAINT `clientes_Corrientes` FOREIGN KEY (`id_cliente`) REFERENCES `clientes_corrientes` (`id_cliente`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `usersid` FOREIGN KEY (`id_usuario`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ventas_ibfk_2` FOREIGN KEY (`id_metodo_pago`) REFERENCES `metodos_pago` (`id_metodo_pago`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventas`
--

LOCK TABLES `ventas` WRITE;
/*!40000 ALTER TABLE `ventas` DISABLE KEYS */;
INSERT INTO `ventas` VALUES (1,2,'2024-11-25 00:00:00',650.00,2,100.00,NULL),(2,2,'2024-11-25 00:00:00',1200.00,2,0.00,NULL),(3,2,'2024-11-25 00:00:00',2550.00,1,0.00,NULL),(4,2,'2024-11-25 00:00:00',250.00,3,500.00,NULL),(5,2,'2024-11-25 00:00:00',250.00,3,500.00,NULL),(6,2,'2024-11-25 00:00:00',550.00,3,200.00,1),(7,2,'2024-11-25 00:00:00',700.00,2,500.00,NULL),(8,2,'2024-11-25 00:00:00',1000.00,3,200.00,1),(9,2,'2024-11-25 00:00:00',250.00,2,500.00,NULL),(10,2,'2024-11-25 00:00:00',1500.00,2,300.00,NULL),(11,2,'2024-11-25 00:00:00',3250.00,3,500.00,1),(12,2,'2024-11-25 00:00:00',1950.00,1,0.00,NULL),(13,13,'2024-11-25 00:00:00',600.00,2,525.00,NULL),(14,14,'2024-11-25 00:00:00',625.00,2,500.00,NULL),(15,14,'2024-11-25 00:00:00',1500.00,2,900.00,NULL),(16,11,'2024-12-10 00:00:00',1125.00,1,0.00,NULL),(17,11,'2024-12-11 00:00:00',700.00,3,500.00,1),(18,11,'2024-12-12 00:00:00',2200.00,3,200.00,3),(19,11,'2024-12-12 00:00:00',1125.00,1,0.00,NULL),(20,11,'2024-12-12 00:00:00',1200.00,2,0.00,NULL),(21,11,'2024-12-12 00:00:00',1125.00,1,0.00,NULL),(22,11,'2024-12-12 00:00:00',13725.00,3,0.00,4),(23,13,'2026-01-27 00:00:00',2300.00,1,200.00,NULL),(24,13,'2026-05-27 00:00:00',10000.00,1,2500.00,NULL),(25,11,'2026-06-06 05:41:04',625.00,1,500.00,NULL),(26,11,'2026-06-06 02:44:28',12000.00,1,0.00,NULL),(27,17,'2026-06-06 19:32:04',12000.00,3,0.00,3),(28,18,'2026-06-06 19:33:50',12000.00,2,0.00,NULL),(29,18,'2026-06-06 19:34:02',7200.00,3,0.00,3),(30,18,'2026-06-06 19:34:15',0.00,1,1125.00,NULL),(31,18,'2026-06-06 19:34:30',-75.00,1,1200.00,NULL);
/*!40000 ALTER TABLE `ventas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventas_anuladas`
--

DROP TABLE IF EXISTS `ventas_anuladas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ventas_anuladas` (
  `id_venta_anulada` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_venta` bigint(20) NOT NULL,
  `id_usuario_anulador` bigint(20) unsigned NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `fecha_anu` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_venta_anulada`),
  KEY `ventas_anuladas_ibfk_1` (`id_venta`),
  KEY `useranul` (`id_usuario_anulador`),
  CONSTRAINT `useranul` FOREIGN KEY (`id_usuario_anulador`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ventas_anuladas_ibfk_1` FOREIGN KEY (`id_venta`) REFERENCES `ventas` (`id_venta`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventas_anuladas`
--

LOCK TABLES `ventas_anuladas` WRITE;
/*!40000 ALTER TABLE `ventas_anuladas` DISABLE KEYS */;
INSERT INTO `ventas_anuladas` VALUES (2,2,2,'se cobro en efectivo','2024-11-23 00:00:00'),(3,4,13,'el cliente devolvio el producto','2024-11-21 00:00:00'),(4,15,11,'Producto Vencido','2024-12-03 00:00:00'),(5,14,11,'x motivo','2024-12-02 00:00:00'),(6,9,12,'se cobro mal','2024-12-11 00:00:00'),(7,3,11,'no se aplico el descuento','2024-12-11 00:00:00'),(8,16,11,'prueba','2024-12-12 00:00:00'),(9,21,11,'sin gas','2024-12-12 00:00:00'),(10,25,11,'prueba2','2026-06-06 00:00:00');
/*!40000 ALTER TABLE `ventas_anuladas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventas_productos`
--

DROP TABLE IF EXISTS `ventas_productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ventas_productos` (
  `id_venta_producto` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_venta` bigint(20) NOT NULL,
  `id_producto` bigint(20) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id_venta_producto`),
  KEY `id_venta` (`id_venta`),
  KEY `id_producto` (`id_producto`),
  CONSTRAINT `ventas_productos_ibfk_1` FOREIGN KEY (`id_venta`) REFERENCES `ventas` (`id_venta`),
  CONSTRAINT `ventas_productos_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventas_productos`
--

LOCK TABLES `ventas_productos` WRITE;
/*!40000 ALTER TABLE `ventas_productos` DISABLE KEYS */;
INSERT INTO `ventas_productos` VALUES (1,1,1,1,NULL),(2,2,6,1,NULL),(3,3,1,1,750.00),(4,3,9,1,1800.00),(5,4,1,1,750.00),(6,5,1,1,750.00),(7,6,1,1,750.00),(8,7,6,1,1200.00),(9,8,6,1,1200.00),(10,9,1,1,750.00),(11,10,9,1,1800.00),(12,11,1,5,750.00),(13,12,1,1,750.00),(14,12,6,1,1200.00),(15,13,1,1,1125.00),(16,14,1,1,1125.00),(17,15,8,1,2400.00),(18,16,1,1,1125.00),(19,17,6,1,1200.00),(20,18,6,2,1200.00),(21,19,1,1,1125.00),(22,20,6,1,1200.00),(23,21,1,1,1125.00),(24,22,1,1,1125.00),(25,22,6,1,7200.00),(26,22,14,1,5400.00),(27,23,11,1,2500.00),(28,24,11,5,2500.00),(29,25,1,1,1125.00),(30,26,12,1,12000.00),(31,27,12,1,12000.00),(32,28,12,1,12000.00),(33,29,6,1,7200.00),(34,30,1,1,1125.00),(35,31,1,1,1125.00);
/*!40000 ALTER TABLE `ventas_productos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-06 19:36:50
