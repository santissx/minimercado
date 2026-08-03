-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 03-08-2026 a las 15:53:34
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
('usuario2t@gmaail.com|127.0.0.1', 'i:1;', 1783715561),
('usuario2t@gmaail.com|127.0.0.1:timer', 'i:1783715561;', 1783715561);

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

--
-- Volcado de datos para la tabla `compras`
--

INSERT INTO `compras` (`id_compra`, `monto_compra`, `fecha`, `id_proveedor`) VALUES
(14, 1149701.59, '2026-06-19 18:55:19', 5),
(15, 826603.27, '2026-06-19 18:56:07', 10);

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

--
-- Volcado de datos para la tabla `presupuestos`
--

INSERT INTO `presupuestos` (`id_presupuesto`, `id_usuario`, `titulo`, `fecha`, `monto_total`, `descuento`, `nombre_cliente`, `telefono_cliente`, `observaciones`, `estado`) VALUES
(3, 11, NULL, '2026-06-22 11:41:57', 811765.13, 0.00, NULL, NULL, NULL, 'pendiente'),
(4, 11, NULL, '2026-06-23 08:47:35', 48273.52, 0.00, NULL, NULL, NULL, 'pendiente'),
(5, 11, NULL, '2026-07-08 20:13:44', 113403.40, 0.00, 'Cande', NULL, NULL, 'convertido'),
(6, 11, NULL, '2026-06-26 18:06:55', 275378.00, 30597.46, 'Ruben y Gabriela', NULL, NULL, 'convertido'),
(7, 11, NULL, '2026-06-29 18:30:03', 251336.59, 49950.00, NULL, NULL, NULL, 'pendiente'),
(8, 11, NULL, '2026-06-30 11:08:46', 71808.30, 0.00, NULL, NULL, NULL, 'pendiente'),
(9, 11, NULL, '2026-06-30 16:35:00', 105000.00, 0.00, NULL, NULL, NULL, 'pendiente'),
(10, 11, NULL, '2026-06-30 16:39:01', 48000.00, 0.00, 'Marisol Bobadilla', '3704666489', NULL, 'pendiente'),
(12, 11, NULL, '2026-06-30 16:48:46', 215000.00, 0.00, 'Marisol Bobadilla', NULL, NULL, 'pendiente'),
(13, 11, NULL, '2026-06-30 17:20:38', 548623.92, 0.00, 'Marisol Bobadilla', NULL, NULL, 'pendiente'),
(14, 11, NULL, '2026-07-01 19:14:33', 315409.97, 25000.00, 'Gym Napoleón Uriburu y Mitre', NULL, NULL, 'pendiente'),
(15, 11, NULL, '2026-07-01 09:32:12', 356910.25, 18784.75, NULL, NULL, NULL, 'pendiente'),
(16, 11, NULL, '2026-07-01 09:43:32', 97110.24, 0.00, 'Marisol Navarrete', NULL, NULL, 'convertido'),
(17, 21, NULL, '2026-07-01 16:11:26', 28443.90, 0.00, NULL, NULL, NULL, 'pendiente'),
(18, 21, NULL, '2026-07-01 16:37:05', 3394.54, 0.00, NULL, NULL, NULL, 'pendiente'),
(19, 11, NULL, '2026-07-01 20:54:16', 1066239.32, 56117.86, 'Caritas Parroquial San Miguel Arcangel', NULL, NULL, 'pendiente'),
(20, 21, NULL, '2026-07-02 09:34:18', 11702.17, 0.00, NULL, NULL, NULL, 'pendiente'),
(21, 11, NULL, '2026-07-02 18:59:37', 136192.00, 7168.00, 'David Batalla', NULL, NULL, 'pendiente'),
(22, 21, NULL, '2026-07-03 12:02:34', 31091.79, 1636.41, 'qoaji', NULL, NULL, 'convertido'),
(23, 11, NULL, '2026-07-03 18:35:20', 9165.26, 1018.36, 'Joaqui Casa', '3704717355', NULL, 'convertido'),
(24, 11, NULL, '2026-07-03 19:52:59', 161857.98, 8518.84, 'IDD', NULL, NULL, 'pendiente'),
(25, 21, NULL, '2026-07-08 11:08:42', 93566.06, 0.00, NULL, NULL, NULL, 'convertido'),
(26, 21, NULL, '2026-07-06 10:32:56', 20303.66, 0.00, NULL, NULL, NULL, 'pendiente'),
(27, 11, NULL, '2026-07-06 19:11:06', 7470.84, 0.00, 'Mirla', NULL, NULL, 'pendiente'),
(28, 11, NULL, '2026-07-06 19:21:29', 83060.13, 0.00, 'SRA MARY ROJAS', NULL, NULL, 'pendiente'),
(29, 11, NULL, '2026-07-06 19:34:12', 162216.93, 0.00, 'Marisol Navarrete', NULL, NULL, 'pendiente'),
(30, 11, NULL, '2026-07-08 17:01:52', 2015.00, 2015.00, NULL, NULL, NULL, 'pendiente'),
(31, 21, NULL, '2026-07-09 09:08:33', 411346.47, 0.00, NULL, NULL, NULL, 'pendiente'),
(32, 22, NULL, '2026-07-10 19:36:25', 710079.00, 37372.58, 'Sebastian Gomez', '3704011751', NULL, 'convertido'),
(34, 22, NULL, '2026-07-14 20:15:40', 15486.17, 0.00, NULL, NULL, NULL, 'pendiente'),
(35, 22, NULL, '2026-07-20 19:03:42', 430080.00, 0.00, NULL, NULL, NULL, 'convertido'),
(36, 22, NULL, '2026-07-20 17:22:24', 386384.00, 20336.00, 'LNR', NULL, NULL, 'convertido'),
(37, 22, NULL, '2026-07-16 19:06:30', 89487.50, 16000.00, 'Mariela -MO-Ventilador', NULL, NULL, 'convertido'),
(38, 11, NULL, '2026-07-18 11:37:58', 197200.00, 34800.00, 'Iglesia de Dios - Alem 555', NULL, NULL, 'convertido'),
(40, 11, NULL, '2026-07-20 16:28:58', 100805.14, 17550.00, 'Andrea', '3704609811', NULL, 'convertido'),
(42, 11, NULL, '2026-07-20 19:06:38', 43970.00, 360.00, 'carla', '1111111', NULL, 'convertido'),
(44, 11, NULL, '2026-07-31 18:25:35', 24000.00, 0.00, NULL, NULL, NULL, 'convertido'),
(45, 11, NULL, '2026-07-31 18:32:14', 19181.19, 0.00, NULL, NULL, NULL, 'convertido'),
(46, 11, NULL, '2026-07-31 18:50:29', 9543.57, 0.00, NULL, NULL, NULL, 'convertido'),
(47, 11, NULL, '2026-07-31 18:57:15', 6000.00, 723.95, 'dsadsa', '231424123', NULL, 'convertido'),
(48, 11, NULL, '2026-07-31 19:08:15', 12942.17, 0.00, 'carla', '22222222', NULL, 'convertido'),
(49, 11, NULL, '2026-07-31 19:10:57', 15543.57, 0.00, NULL, NULL, NULL, 'convertido'),
(51, 11, NULL, '2026-07-31 19:14:11', 16000.00, 476.15, NULL, NULL, NULL, 'convertido'),
(52, 11, NULL, '2026-07-31 19:15:54', 16476.15, 0.00, NULL, NULL, NULL, 'convertido'),
(54, 11, NULL, '2026-07-31 19:24:17', 48952.34, 0.00, NULL, NULL, NULL, 'convertido'),
(55, 11, NULL, '2026-07-31 22:14:51', 27521.24, 0.00, NULL, NULL, NULL, 'convertido'),
(56, 11, NULL, '2026-07-31 22:16:15', 31000.00, 292.75, 'sadsa', 'assadsa', NULL, 'convertido'),
(57, 11, NULL, '2026-07-31 22:16:53', 6000.00, 0.00, 'dsfdas', 'fdsafadsfdasfdsafdsa', NULL, 'convertido'),
(58, 11, NULL, '2026-08-01 11:59:32', 21000.00, 200.91, 'sadsa', '22222222', NULL, 'pendiente'),
(59, 11, 'obra casa central', '2026-08-01 12:00:00', 6000.00, 0.00, 'dsfads', '1111111', 'Lorem ipsum dolor sit amet consectetur adipiscing elit curae, ac nisl lobortis semper convallis magna ornare rutrum, vestibulum a dapibus integer justo duis ut. Commodo ultrices integer augue ornare faucibus per vel sociis mauris habitasse hac eget vulputate, mi sodales bibendum lobortis laoreet etiam fusce interdum nisl ante neque odio. Placerat imperdiet urna bibendum ligula eu sociosqu donec tempus, habitasse convallis velit eros faucibus euismod ornare ac a, dui risus natoque sollicitudin rutrum suspendisse nostra.\r\n\r\nMetus dictumst commodo venenatis donec congue ultrices, suspendisse mauris tellus id ultricies, magnis pellentesque condimentum lectus nam. Fames est luctus nostra quam tincidunt ornare iaculis, senectus lacinia erat vestibulum congue vulputate taciti cursus, netus enim metus cras ligula egestas. Sodales at praesent ut penatibus neque nisl torquent rutrum massa eu, ad elementum pretium hac rhoncus pellentesque auctor ornare metus, dictumst nostra natoque cras sed habitant fusce venenatis posuere. Ullamcorper quam dapibus egestas etiam ut lobortis vivamus, tempor id cum nec vulputate iaculis, nunc himenaeos metus parturient cras phasellus.\r\n\r\nPulvinar primis pellentesque praesent scelerisque sodales, augue urna litora facilisi nulla aliquam, a lobortis vestibulum imperdiet. Fermentum euismod ante praesent congue est tellus, ultrices urna erat hac netus imperdiet, varius pulvinar cursus tristique enim. Cum sollicitudin dapibus diam porta condimentum sapien dictum velit vehicula justo, malesuada risus nisi ullamcorper est feugiat gravida lobortis purus bibendum, facilisi dui augue lacus lectus conubia eleifend cubilia scelerisque. Ante at quis cum est sed scelerisque iaculis cursus condimentum, euismod phasellus accumsan feugiat ut natoque magnis pretium aliquet, aliquam faucibus sem ultricies cubilia fusce dis in.\r\n\r\nElementum torquent pulvinar sodales libero ultricies venenatis velit vestibulum suscipit etiam nostra ullamcorper accumsan, luctus consequat per aliquam eu aliquet nullam maecenas viverra porta facilisi leo. Neque nam suscipit fermentum ante hendrerit, felis parturient nunc eleifend ultrices iaculis, sed dui libero magna. Ad cum auctor luctus pulvinar penatibus sollicitudin ligula sem mattis erat accumsan odio volutpat facilisis, feugiat conubia rhoncus tempus hac ac fringilla suspendisse eu ante felis donec mauris.\r\n\r\nFaucibus eget pulvinar nisl ridiculus tortor suscipit nulla cum condimentum vehicula, arcu venenatis ac erat fringilla rutrum augue bibendum nunc volutpat sociosqu, eu torquent tellus etiam tristique aptent viverra platea morbi. Erat libero morbi fringilla nascetur parturient montes facilisi sociis tellus, pretium litora urna dui id integer quis sem etiam, ut ultrices dictum facilisis odio interdum iaculis magna.', 'pendiente'),
(60, 11, NULL, '2026-08-01 12:01:44', 10030.00, 0.00, NULL, NULL, NULL, 'convertido'),
(61, 11, 'obra casa central', '2026-08-01 12:04:46', 10000.00, 30.00, 'carla', '1111111', 'Lorem ipsum dolor sit amet consectetur adipiscing elit dignissim felis per, turpis luctus integer posuere iaculis mattis lacus dis pulvinar, commodo donec est et dictum risus sodales enim arcu. Congue vitae netus fermentum lacinia tempus et cubilia, morbi duis cursus etiam sociosqu dictumst fames, felis iaculis leo potenti ultricies phasellus. Venenatis accumsan blandit tortor ridiculus lectus lobortis diam metus, posuere pharetra auctor aliquet porta ullamcorper tincidunt aliquam consequat, habitant sed nibh bibendum ultrices elementum felis. Justo magna in est tortor viverra, donec tellus purus habitasse, potenti curabitur suscipit facilisi.\r\n\r\nNetus a est cursus sed donec auctor imperdiet porta euismod, risus potenti nec ante class mattis lobortis malesuada vel, platea laoreet habitant accumsan eros enim sem nam. Pretium nam eu magnis rutrum morbi ridiculus eleifend parturient, justo metus tortor vulputate facilisi etiam hendrerit venenatis, ante tempor primis vel ligula et mus. Non pharetra class eget aliquam dapibus mus fermentum, orci montes neque semper ornare ligula, rutrum turpis vel hac ultrices lacinia.\r\n\r\nTincidunt vel eu arcu nec in convallis conubia, varius maecenas ridiculus ut massa venenatis sociosqu, fames sollicitudin rhoncus risus eros praesent. Maecenas tempus cras senectus tristique lacinia netus consequat bibendum, turpis quisque hendrerit aptent curae non dictum. Massa potenti suscipit proin auctor id class felis nisi venenatis lacinia facilisi luctus, fusce tortor est iaculis condimentum fermentum eros mollis quis conubia cum. Montes quam cum eget quis pretium a sodales nisl litora, iaculis integer parturient curae tempor senectus tellus tincidunt, conubia class ligula fermentum augue dictumst enim fringilla.\r\n\r\nParturient enim aliquam mattis consequat egestas primis dictum interdum, tristique nascetur leo et vitae malesuada vehicula mi, proin auctor ligula viverra imperdiet etiam tellus. Euismod netus bibendum mi ad magnis nascetur semper metus faucibus, tortor nibh erat torquent vestibulum mattis habitasse nullam, posuere porta ornare vivamus sem enim tellus sagittis. Porta mus sodales gravida magna diam rhoncus lacinia lobortis leo ligula malesuada nibh, nascetur parturient cubilia tincidunt urna praesent laoreet orci litora facilisis nisl velit nam, class montes sed dis neque tempus potenti id aliquam erat dignissim.\r\n\r\nTortor elementum et ad duis pulvinar erat porttitor ultrices, potenti convallis curabitur himenaeos nascetur venenatis semper lacinia congue, felis sem diam cubilia fringilla metus facilisis. Varius ut potenti sodales vehicula dis est mus auctor, velit ridiculus fusce inceptos sed tristique commodo placerat eget, cursus malesuada venenatis bibendum arcu ornare ultrices. Torquent nec eleifend taciti conubia venenatis curabitur dignissim nullam natoque, aptent magnis vulputate enim id sed sapien.\r\n\r\nPellentesque suscipit accumsan leo donec faucibus imperdiet, id quam gravida erat scelerisque etiam, nibh conubia hac cras sed interdum, dapibus dui lobortis lacinia vel. Molestie imperdiet dapibus lectus interdum sociosqu dignissim, hac odio mi consequat mattis velit aliquam, rutrum nec pretium netus et. Euismod nascetur ultricies aliquet dapibus molestie nunc fames proin felis, risus placerat orci massa feugiat tempus ullamcorper enim, tortor purus dictum eleifend sapien sagittis senectus penatibus.\r\n\r\nAccumsan sem commodo eget suscipit congue non condimentum ad eleifend, himenaeos mauris torquent fames fringilla porta cursus praesent, senectus id pellentesque arcu aptent tempus ornare natoque. Sem litora arcu vehicula eros at fringilla fames nulla, eleifend ac class facilisis ultrices duis maecenas vitae, torquent varius senectus vulputate purus curabitur laoreet. Lacinia phasellus blandit per viverra suspendisse, nam accumsan convallis justo, imperdiet egestas est vulputate.\r\n\r\nAd vitae nec at rhoncus suscipit laoreet, quam potenti praesent dictumst in sagittis tellus, mus semper class viverra egestas. Hendrerit inceptos vehicula condimentum orci malesuada eget ultricies duis suscipit tempus, enim quis pretium penatibus sed vivamus tellus aliquam ullamcorper iaculis vitae, sollicitudin fringilla donec facilisi curae himenaeos mi ornare aenean. Ullamcorper consequat integer pretium pellentesque natoque inceptos potenti, non curae ut commodo primis leo sociis aliquet, morbi facilisi mus nisi et senectus. Egestas sed hac massa justo platea dictumst, condimentum aliquet cras pharetra accumsan fermentum curabitur, dignissim bibendum per porttitor vel volutpat, cum erat sapien senectus ut.\r\n\r\nIaculis aenean malesuada netus mattis ante nibh et neque nostra, nunc augue hac accumsan tempus fusce vulputate. Luctus curae purus mollis ridiculus taciti nisl, inceptos libero himenaeos fermentum euismod at nostra, malesuada phasellus facilisis nullam sodales. Quam proin nullam nunc id nec, vulputate vitae auctor tempor tempus, donec eleifend est nostra.\r\n\r\nDiam venenatis suspendisse pellentesque congue curae eleifend fames aenean elementum eget, nostra non faucibus dui feugiat vulputate neque metus. Aliquam at commodo quam varius urna leo hac rutrum mattis, vulputate venenatis tristique cubilia mi malesuada natoque ridiculus dictum, class integer montes posuere vel etiam augue morbi. Blandit at etiam vivamus sociosqu donec mollis varius sociis, tortor taciti ad cursus pellentesque tincidunt laoreet, facilisi vehicula accumsan habitasse dictum felis fames. A sociis nunc suscipit vitae facilisi vulputate mattis nam, convallis parturient egestas massa placerat purus duis odio eu, faucibus etiam conubia neque inceptos nisi class.\r\n\r\nPlatea commodo integer sem turpis pharetra eleifend condimentum habitant egestas aliquet auctor senectus gravida fringilla, mauris phasellus augue potenti eu morbi sociis nullam penatibus vestibulum ante odio. Imperdiet praesent erat maecenas magnis ante nisl integer vitae commodo habitant nostra rhoncus sociosqu etiam consequat fringilla, faucibus posuere proin ut aliquet pharetra egestas tincidunt augue suscipit pretium ultricies tristique vulputate. Justo interdum laoreet suspendisse senectus donec, platea in pharetra bibendum egestas libero, lectus enim massa per. Aenean est nostra turpis rhoncus conubia hac ac senectus quisque dictum, ante hendrerit mollis nascetur penatibus dapibus nisl sociis.', 'convertido');

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

--
-- Volcado de datos para la tabla `presupuestos_productos`
--

INSERT INTO `presupuestos_productos` (`id_presupuesto_producto`, `id_presupuesto`, `id_producto`, `id_promocion`, `cantidad`, `precio`) VALUES
(25, 3, 211, NULL, 19, 566.61),
(26, 3, 272, NULL, 9, 1130.04),
(27, 3, 212, NULL, 19, 109.45),
(28, 3, 213, NULL, 29, 1048.73),
(29, 3, 214, NULL, 19, 621.02),
(30, 3, 86, NULL, 6, 10547.91),
(31, 3, 84, NULL, 3, 6261.02),
(32, 3, 104, NULL, 1, 8671.59),
(33, 3, 102, NULL, 2, 8671.59),
(34, 3, 148, NULL, 1, 35317.90),
(35, 3, 189, NULL, 2, 12835.67),
(36, 3, 195, NULL, 200, 1878.48),
(37, 3, 194, NULL, 25, 1181.19),
(38, 3, 133, NULL, 30, 723.95),
(39, 3, 197, NULL, 16, 2844.39),
(40, 3, 291, NULL, 20, 1570.72),
(41, 3, 190, NULL, 3, 4209.72),
(42, 3, 293, NULL, 2, 11724.03),
(43, 3, 191, NULL, 2, 18758.22),
(44, 4, 211, NULL, 8, 566.61),
(45, 4, 214, NULL, 8, 621.02),
(46, 4, 213, NULL, 10, 1048.73),
(47, 4, 278, NULL, 1, 1505.86),
(48, 4, 272, NULL, 2, 1130.04),
(49, 4, 212, NULL, 11, 109.45),
(50, 4, 104, NULL, 1, 8671.59),
(51, 4, 89, NULL, 3, 4289.92),
(52, 4, 311, NULL, 1, 1773.94),
(59, 6, 366, NULL, 4, 27500.00),
(60, 6, 367, NULL, 1, 30000.00),
(61, 6, 368, NULL, 3, 14400.00),
(62, 6, 369, NULL, 4, 16250.00),
(63, 6, 217, NULL, 4, 2661.07),
(64, 6, 291, NULL, 15, 1570.72),
(65, 6, 360, NULL, 10, 723.20),
(66, 6, 268, NULL, 1, 1853.39),
(67, 6, 269, NULL, 1, 647.30),
(68, 6, 267, NULL, 2, 289.89),
(69, 6, 270, NULL, 3, 292.42),
(70, 6, 236, NULL, 1, 2003.79),
(71, 6, 211, NULL, 1, 566.61),
(72, 6, 214, NULL, 1, 621.02),
(73, 6, 213, NULL, 1, 1048.73),
(74, 6, 212, NULL, 1, 109.45),
(75, 6, 273, NULL, 1, 2715.57),
(76, 6, 49, NULL, 4, 1328.87),
(103, 7, 110, NULL, 1, 32356.76),
(104, 7, 98, NULL, 1, 8671.59),
(105, 7, 203, NULL, 4, 2494.69),
(106, 7, 209, NULL, 4, 287.38),
(107, 7, 127, NULL, 5, 556.67),
(108, 7, 205, NULL, 2, 770.88),
(109, 7, 218, NULL, 3, 505.95),
(110, 7, 236, NULL, 7, 2003.79),
(111, 7, 272, NULL, 2, 1130.04),
(112, 7, 213, NULL, 10, 1048.73),
(113, 7, 211, NULL, 8, 566.61),
(114, 7, 214, NULL, 8, 621.02),
(115, 7, 278, NULL, 3, 1945.34),
(116, 7, 311, NULL, 2, 1773.94),
(117, 7, 40, NULL, 2, 1015.03),
(118, 7, 122, NULL, 5, 427.54),
(119, 7, 271, NULL, 5, 216.01),
(120, 7, 267, NULL, 18, 289.89),
(121, 7, 270, NULL, 12, 292.42),
(122, 7, 304, NULL, 35, 25.09),
(123, 7, 285, NULL, 35, 45.23),
(124, 7, 190, NULL, 1, 4209.72),
(125, 7, 131, NULL, 24, 1181.19),
(126, 7, 212, NULL, 9, 109.45),
(127, 7, 129, NULL, 50, 1181.19),
(128, 7, 130, NULL, 75, 1181.19),
(129, 8, 256, NULL, 1, 16238.78),
(130, 8, 104, NULL, 1, 8671.59),
(131, 8, 110, NULL, 1, 32356.76),
(132, 8, 376, NULL, 1, 14541.17),
(133, 9, 403, NULL, 3, 35000.00),
(134, 10, 402, NULL, 2, 24000.00),
(145, 12, 396, NULL, 3, 32000.00),
(146, 12, 397, NULL, 2, 16000.00),
(147, 12, 398, NULL, 3, 25000.00),
(148, 12, 399, NULL, 2, 6000.00),
(164, 13, 403, NULL, 3, 35000.00),
(165, 13, 401, NULL, 3, 84000.00),
(166, 13, 400, NULL, 4, 37999.00),
(167, 13, 213, NULL, 3, 1048.73),
(168, 13, 226, NULL, 1, 3216.36),
(169, 13, 291, NULL, 15, 1570.72),
(170, 13, 342, NULL, 3, 1616.24),
(171, 13, 230, NULL, 1, 4855.85),
(184, 15, 195, NULL, 100, 1878.48),
(185, 15, 196, NULL, 100, 1878.47),
(186, 16, 211, NULL, 32, 566.61),
(187, 16, 214, NULL, 32, 621.02),
(188, 16, 213, NULL, 38, 1048.73),
(189, 16, 212, NULL, 40, 109.45),
(190, 16, 278, NULL, 3, 1945.34),
(191, 16, 272, NULL, 8, 1130.04),
(230, 17, 197, NULL, 10, 2844.39),
(231, 18, 211, NULL, 1, 566.61),
(232, 18, 214, NULL, 1, 621.02),
(233, 18, 213, NULL, 2, 1048.73),
(234, 18, 212, NULL, 1, 109.45),
(248, 14, 391, NULL, 3, 30000.00),
(249, 14, 404, NULL, 1, 45000.00),
(250, 14, 264, NULL, 1, 14364.92),
(251, 14, 203, NULL, 6, 2494.69),
(252, 14, 205, NULL, 3, 770.88),
(253, 14, 209, NULL, 5, 287.38),
(254, 14, 127, NULL, 8, 556.67),
(255, 14, 197, NULL, 17, 2844.39),
(256, 14, 198, NULL, 17, 2844.39),
(257, 14, 131, NULL, 17, 1181.19),
(258, 14, 105, NULL, 2, 8671.59),
(259, 14, 235, NULL, 3, 2913.78),
(260, 14, 371, NULL, 1, 25000.00),
(261, 19, 268, NULL, 40, 1853.39),
(262, 19, 269, NULL, 20, 647.30),
(263, 19, 270, NULL, 100, 292.42),
(264, 19, 267, NULL, 40, 289.89),
(265, 19, 236, NULL, 12, 2003.79),
(266, 19, 218, NULL, 10, 505.95),
(267, 19, 259, NULL, 1, 46175.77),
(268, 19, 130, NULL, 100, 1181.19),
(269, 19, 129, NULL, 100, 1181.19),
(270, 19, 193, NULL, 100, 723.95),
(271, 19, 199, NULL, 100, 723.95),
(272, 19, 281, NULL, 1, 12710.75),
(273, 19, 110, NULL, 1, 32356.76),
(274, 19, 104, NULL, 1, 8671.59),
(275, 19, 102, NULL, 7, 8671.59),
(276, 19, 191, NULL, 1, 18758.22),
(277, 19, 378, NULL, 1, 14684.99),
(278, 19, 113, NULL, 2, 3237.92),
(279, 19, 405, NULL, 20, 63.11),
(280, 19, 406, NULL, 4, 96.55),
(281, 19, 86, NULL, 10, 10547.91),
(282, 19, 84, NULL, 2, 6261.02),
(283, 19, 311, NULL, 4, 1773.94),
(284, 19, 43, NULL, 6, 1346.14),
(285, 19, 293, NULL, 1, 11724.03),
(286, 19, 211, NULL, 20, 566.61),
(287, 19, 214, NULL, 20, 621.02),
(288, 19, 213, NULL, 10, 1048.73),
(289, 19, 272, NULL, 6, 1130.04),
(290, 19, 407, NULL, 6, 2960.48),
(291, 19, 297, NULL, 100, 21.96),
(292, 19, 303, NULL, 100, 21.91),
(293, 19, 190, NULL, 3, 4209.72),
(294, 19, 249, NULL, 1, 10612.80),
(295, 19, 195, NULL, 50, 1878.48),
(296, 19, 197, NULL, 20, 2844.39),
(300, 20, 178, NULL, 1, 9465.81),
(301, 20, 211, NULL, 1, 566.61),
(302, 20, 214, NULL, 1, 621.02),
(303, 20, 213, NULL, 1, 1048.73),
(304, 21, 359, NULL, 1, 143360.00),
(305, 22, 211, NULL, 6, 566.61),
(306, 22, 214, NULL, 6, 621.02),
(307, 22, 277, NULL, 2, 5456.00),
(308, 22, 213, NULL, 2, 1048.73),
(309, 22, 272, NULL, 2, 1130.04),
(310, 22, 236, NULL, 2, 2003.79),
(311, 22, 238, NULL, 2, 1400.58),
(312, 22, 278, NULL, 1, 1945.34),
(313, 22, 304, NULL, 10, 25.09),
(314, 22, 285, NULL, 10, 45.23),
(315, 22, 212, NULL, 8, 109.45),
(316, 23, 211, NULL, 3, 566.61),
(317, 23, 214, NULL, 3, 621.02),
(318, 23, 213, NULL, 6, 1048.73),
(319, 23, 212, NULL, 3, 109.45),
(320, 24, 410, NULL, 3, 46621.44),
(321, 24, 50, NULL, 5, 6102.50),
(340, 26, 96, NULL, 1, 8671.59),
(341, 26, 98, NULL, 1, 8671.59),
(342, 26, 407, NULL, 1, 2960.48),
(343, 27, 277, NULL, 1, 4650.00),
(344, 27, 343, NULL, 1, 1662.66),
(345, 27, 213, NULL, 1, 1048.73),
(346, 27, 212, NULL, 1, 109.45),
(349, 28, 106, NULL, 1, 8923.15),
(350, 28, 411, NULL, 1, 35000.00),
(351, 28, 412, NULL, 1, 25000.00),
(352, 28, 122, NULL, 4, 427.54),
(353, 28, 126, NULL, 1, 614.92),
(354, 28, 129, NULL, 5, 1181.19),
(355, 28, 130, NULL, 5, 1181.19),
(356, 29, 105, NULL, 1, 8671.59),
(357, 29, 110, NULL, 1, 32356.76),
(358, 29, 98, NULL, 2, 8671.59),
(359, 29, 102, NULL, 2, 8671.59),
(360, 29, 111, NULL, 1, 25245.74),
(361, 29, 284, NULL, 1, 6355.36),
(362, 29, 119, NULL, 1, 4015.56),
(363, 29, 112, NULL, 1, 6544.12),
(364, 29, 72, NULL, 3, 4730.90),
(365, 29, 74, NULL, 2, 5756.31),
(366, 29, 79, NULL, 2, 9318.06),
(367, 25, 268, NULL, 5, 1853.39),
(368, 25, 267, NULL, 15, 289.89),
(369, 25, 269, NULL, 5, 647.30),
(370, 25, 218, NULL, 4, 505.95),
(371, 25, 222, NULL, 4, 938.41),
(372, 25, 211, NULL, 2, 566.61),
(373, 25, 214, NULL, 2, 621.02),
(374, 25, 272, NULL, 1, 1130.04),
(375, 25, 212, NULL, 2, 109.45),
(376, 25, 213, NULL, 3, 1048.73),
(377, 25, 362, NULL, 1, 2201.17),
(378, 25, 195, NULL, 10, 1878.48),
(379, 25, 196, NULL, 10, 1878.47),
(380, 25, 102, NULL, 1, 8671.59),
(381, 25, 236, NULL, 2, 2003.79),
(382, 25, 255, NULL, 1, 11616.59),
(383, 30, 333, NULL, 1, 4030.00),
(384, 5, 363, NULL, 1, 30000.00),
(385, 5, 364, NULL, 5, 6000.00),
(386, 5, 291, NULL, 15, 1570.72),
(387, 5, 49, NULL, 5, 1328.87),
(388, 5, 418, NULL, 1, 5360.63),
(389, 5, 360, NULL, 1, 685.13),
(390, 5, 384, NULL, 2, 742.23),
(391, 5, 389, NULL, 1, 843.73),
(392, 5, 292, NULL, 1, 13208.06),
(393, 5, 342, NULL, 1, 1616.24),
(394, 31, 132, NULL, 50, 723.95),
(395, 31, 133, NULL, 50, 723.95),
(396, 31, 196, NULL, 14, 1878.47),
(397, 31, 195, NULL, 14, 1878.48),
(398, 31, 102, NULL, 1, 8671.59),
(399, 31, 98, NULL, 1, 8671.59),
(400, 31, 96, NULL, 1, 8671.59),
(401, 31, 145, NULL, 1, 33281.25),
(402, 31, 236, NULL, 8, 2003.79),
(403, 31, 218, NULL, 6, 505.95),
(404, 31, 222, NULL, 6, 938.41),
(405, 31, 258, NULL, 1, 32322.64),
(406, 31, 211, NULL, 6, 566.61),
(407, 31, 214, NULL, 6, 621.02),
(408, 31, 213, NULL, 8, 1048.73),
(409, 31, 272, NULL, 5, 1130.04),
(410, 31, 212, NULL, 5, 109.45),
(411, 31, 407, NULL, 6, 2960.48),
(412, 31, 234, NULL, 2, 4035.59),
(413, 31, 217, NULL, 1, 2661.07),
(414, 31, 203, NULL, 10, 2494.69),
(415, 31, 127, NULL, 30, 556.67),
(416, 31, 205, NULL, 6, 770.88),
(417, 31, 207, NULL, 40, 316.36),
(418, 31, 209, NULL, 6, 287.38),
(419, 31, 348, NULL, 1, 5771.96),
(420, 31, 349, NULL, 1, 4775.12),
(421, 31, 109, NULL, 1, 12653.88),
(422, 31, 285, NULL, 60, 45.23),
(423, 31, 304, NULL, 60, 25.09),
(424, 31, 353, NULL, 2, 2972.96),
(425, 31, 283, NULL, 1, 8908.26),
(426, 31, 119, NULL, 1, 4015.56),
(427, 31, 44, NULL, 1, 1736.05),
(428, 31, 45, NULL, 4, 1736.05),
(429, 31, 190, NULL, 1, 4209.72),
(430, 32, 258, NULL, 1, 32322.64),
(431, 32, 281, NULL, 1, 12710.75),
(432, 32, 119, NULL, 1, 4015.56),
(433, 32, 110, NULL, 1, 32356.76),
(434, 32, 96, NULL, 1, 8671.59),
(435, 32, 102, NULL, 1, 8671.59),
(436, 32, 236, NULL, 9, 2003.79),
(437, 32, 211, NULL, 9, 566.61),
(438, 32, 214, NULL, 9, 621.02),
(439, 32, 213, NULL, 13, 1048.73),
(440, 32, 272, NULL, 3, 1130.04),
(441, 32, 212, NULL, 11, 109.45),
(442, 32, 311, NULL, 8, 1773.94),
(443, 32, 218, NULL, 11, 505.95),
(444, 32, 121, NULL, 100, 540.99),
(445, 32, 127, NULL, 50, 556.67),
(446, 32, 133, NULL, 40, 723.95),
(447, 32, 132, NULL, 40, 723.95),
(448, 32, 129, NULL, 80, 1181.19),
(449, 32, 130, NULL, 80, 1181.19),
(450, 32, 131, NULL, 80, 1181.19),
(451, 32, 196, NULL, 40, 1878.47),
(452, 32, 195, NULL, 40, 1878.48),
(453, 32, 112, NULL, 1, 6544.12),
(454, 32, 306, NULL, 20, 30.91),
(455, 32, 285, NULL, 20, 45.23),
(456, 32, 207, NULL, 1, 316.36),
(461, 34, 211, NULL, 5, 566.61),
(462, 34, 213, NULL, 9, 1048.73),
(463, 34, 212, NULL, 1, 109.45),
(464, 34, 214, NULL, 5, 621.02),
(466, 36, 359, NULL, 2, 143360.00),
(467, 36, 421, NULL, 2, 60000.00),
(479, 37, 391, NULL, 1, 30000.00),
(480, 37, 421, NULL, 1, 60000.00),
(481, 37, 193, NULL, 4, 723.95),
(482, 37, 133, NULL, 4, 723.95),
(483, 37, 270, NULL, 4, 292.42),
(484, 37, 269, NULL, 1, 647.30),
(485, 37, 267, NULL, 2, 289.89),
(486, 37, 217, NULL, 2, 2539.80),
(487, 37, 305, NULL, 10, 41.63),
(488, 37, 335, NULL, 2, 847.42),
(489, 37, 287, NULL, 1, 108.40),
(490, 38, 422, NULL, 1, 90000.00),
(491, 38, 424, NULL, 3, 24000.00),
(492, 38, 423, NULL, 5, 14000.00),
(497, 40, 425, NULL, 3, 12000.00),
(498, 40, 423, NULL, 5, 9000.00),
(499, 40, 426, NULL, 2, 18000.00),
(500, 40, 42, NULL, 1, 1355.14),
(504, 35, 359, NULL, 3, 143360.00),
(506, 42, 333, NULL, 11, 4030.00),
(510, 44, 129, NULL, 4, 1300.70),
(511, 44, 132, NULL, 4, 797.20),
(512, 44, 131, NULL, 12, 1300.70),
(513, 45, 129, NULL, 1, 1181.19),
(514, 45, 129, NULL, 3, 1300.70),
(515, 45, 132, NULL, 3, 797.20),
(516, 45, 131, NULL, 9, 1300.70),
(517, 46, 131, NULL, 3, 1181.19),
(518, 46, 129, NULL, 1, 1300.70),
(519, 46, 132, NULL, 1, 797.20),
(520, 46, 131, NULL, 3, 1300.70),
(521, 47, 132, NULL, 1, 723.95),
(522, 47, 129, NULL, 1, 1300.70),
(523, 47, 132, NULL, 1, 797.20),
(524, 47, 131, NULL, 3, 1300.70),
(529, 48, 129, NULL, 1, 1181.19),
(530, 48, 129, NULL, 2, 1274.79),
(531, 48, 132, NULL, 2, 781.32),
(532, 48, 131, NULL, 6, 1274.79),
(533, 49, 131, NULL, 3, 1181.19),
(534, 49, 129, NULL, 2, 1300.70),
(535, 49, 132, NULL, 2, 797.20),
(536, 49, 131, NULL, 6, 1300.70),
(553, 51, 129, NULL, 1, 1300.70),
(554, 51, 132, NULL, 1, 797.20),
(555, 51, 131, NULL, 3, 1300.70),
(556, 51, 39, NULL, 1, 5012.01),
(557, 51, 53, NULL, 1, 3101.76),
(558, 51, 129, NULL, 1, 1181.19),
(559, 51, 130, NULL, 1, 1181.19),
(560, 52, 129, NULL, 1, 1300.70),
(561, 52, 132, NULL, 1, 797.20),
(562, 52, 131, NULL, 3, 1300.70),
(563, 52, 39, NULL, 1, 5012.01),
(564, 52, 53, NULL, 1, 3101.76),
(565, 52, 129, NULL, 1, 1181.19),
(566, 52, 130, NULL, 1, 1181.19),
(592, 54, 129, NULL, 2, 1300.70),
(593, 54, 132, NULL, 2, 797.20),
(594, 54, 131, NULL, 6, 1300.70),
(595, 54, 39, NULL, 2, 5012.01),
(596, 54, 53, NULL, 2, 3101.76),
(597, 54, 129, NULL, 2, 1181.19),
(598, 54, 130, NULL, 2, 1181.19),
(599, 54, 39, NULL, 2, 4419.71),
(600, 54, 40, NULL, 2, 895.08),
(601, 54, 41, NULL, 6, 895.08),
(602, 55, 41, NULL, 3, 1015.03),
(603, 55, 129, 3, 1, 1300.70),
(604, 55, 132, 3, 1, 797.20),
(605, 55, 131, 3, 3, 1300.70),
(606, 55, 39, 4, 1, 5012.01),
(607, 55, 53, 4, 1, 3101.76),
(608, 55, 129, 4, 1, 1181.19),
(609, 55, 130, 4, 1, 1181.19),
(610, 55, 39, 5, 1, 4419.70),
(611, 55, 40, 5, 1, 895.08),
(612, 55, 41, 5, 3, 895.08),
(633, 56, 131, NULL, 3, 1181.19),
(634, 56, 82, NULL, 1, 5012.01),
(635, 56, 84, NULL, 1, 6261.02),
(636, 56, 129, 3, 1, 1300.70),
(637, 56, 132, 3, 1, 797.20),
(638, 56, 131, 3, 3, 1300.70),
(639, 56, 39, 4, 1, 5012.01),
(640, 56, 53, 4, 1, 3101.76),
(641, 56, 129, 4, 1, 1181.19),
(642, 56, 130, 4, 1, 1181.19),
(643, 57, 129, 3, 1, 1300.70),
(644, 57, 132, 3, 1, 797.20),
(645, 57, 131, 3, 3, 1300.70),
(655, 58, 131, NULL, 3, 1181.19),
(656, 58, 129, NULL, 1, 1181.19),
(657, 58, 129, 3, 1, 1300.70),
(658, 58, 132, 3, 1, 797.20),
(659, 58, 131, 3, 3, 1300.70),
(660, 58, 39, 4, 1, 5012.01),
(661, 58, 53, 4, 1, 3101.76),
(662, 58, 129, 4, 1, 1181.19),
(663, 58, 130, 4, 1, 1181.19),
(664, 59, 129, 3, 1, 1300.70),
(665, 59, 132, 3, 1, 797.20),
(666, 59, 131, 3, 3, 1300.70),
(667, 60, 333, NULL, 1, 4030.00),
(668, 60, 129, 3, 1, 1300.70),
(669, 60, 132, 3, 1, 797.20),
(670, 60, 131, 3, 3, 1300.70),
(671, 61, 333, NULL, 1, 4030.00),
(672, 61, 129, 3, 1, 1300.70),
(673, 61, 132, 3, 1, 797.20),
(674, 61, 131, 3, 3, 1300.70);

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
(39, 'Panel Led Cuadrado Aplicar 12W Frío BRINNA', 'I-PLCA12WFR-BR', 'I-PLCA12WFR-BR', 6, 0, 2847.73, 5, 5012.01, 'activo'),
(40, 'Lámpara Led 9W Cálida BRINNA', 'I-LL9WCA-BR', 'I-LL9WCA-BR', 6, 69, 595.32, 5, 1015.03, 'activo'),
(41, 'Lámpara Led 9W Fría BRINNA', 'I-LL9WFR-BR', 'I-LL9WFR-BR', 6, 49, 595.32, 5, 1015.03, 'activo'),
(42, 'Lámpara Led 12W Cálida BRINNA', 'I-LL12WCA-BR', 'I-LL12WCA-BR', 6, 79, 789.52, 5, 1355.14, 'activo'),
(43, 'Lámpara Led 12W Fría BRINNA', 'I-LL12WFR-BR', 'I-LL12WFR-BR', 6, 78, 789.52, 5, 1346.14, 'activo'),
(44, 'Lámpara Led 15W Cálida BRINNA', 'I-LL15WCA-BR', 'I-LL15WCA-BR', 6, 73, 1018.21, 5, 1736.05, 'activo'),
(45, 'Lámpara Led 15W Frío BRINNA', 'I-LL15WFR-BR', 'I-LL15WFR-BR', 6, 56, 1018.21, 5, 1736.05, 'activo'),
(46, 'Dicroica Led 7W Cálida BRINNA', 'I-DL7WCA-BR', 'I-DL7WCA-BR', 6, 0, 755.04, 5, 1287.34, 'activo'),
(47, 'Dicroica Led 7W Fría BRINNA', 'I-DL7WFR-BR', 'I-DL7WFR-BR', 6, 0, 755.04, 5, 1287.34, 'activo'),
(48, 'Dicroica Led 7W Fría TREFI', 'I-DL7WFR-TR', 'I-DL7WFR-TR', 5, 15, 755.04, 5, 1328.87, 'activo'),
(49, 'Dicroica Led 7W Cálida TREFI', 'I-DL7WCA-TR', 'I-DL7WCA-TR', 5, 11, 755.04, 5, 1328.87, 'activo'),
(50, 'Lámpara Led AR111 12W Cálida BRINNA', 'I-AR111-12WCA-BR', 'I-AR111-12WCA-BR', 6, 1, 3579.18, 5, 6102.50, 'activo'),
(51, 'Lámpara Led AR111 12W Fría BRINNA', 'I-AR111-12WFR-BR', 'I-AR111-12WFR-BR', 6, 5, 3579.18, 5, 6102.50, 'activo'),
(52, 'Desactivado 1', 'libre', 'libre', 6, 20, 446.49, 5, 761.27, 'desactivado'),
(53, 'Panel Led Redondo Embutir 6W Cálido BRINNA', 'I-PLRE6WCA-BR', 'I-PLRE6WCA-BR', 6, 11, 1762.36, 5, 3101.76, 'activo'),
(54, 'Panel Led Redondo Embutir 6W Frío BRINNA', 'I-PLRE6WFR-BR', 'I-PLRE6WFR-BR', 6, 10, 1762.36, 5, 3101.76, 'activo'),
(55, 'Panel Led Redondo Embutir 12W Cálido BRINNA', 'I-PLRE12WCA-BR', 'I-PLRE12WCA-BR', 6, 19, 2459.32, 5, 4328.40, 'activo'),
(56, 'Panel Led Redondo Embutir 12W Frío BRINNA', 'I-PLRE12WFR-BR', 'I-PLRE12WFR-BR', 6, 20, 2459.32, 5, 4328.40, 'activo'),
(57, 'Panel Led Redondo Embutir 18W Cálido BRINNA', 'I-PLRE18WCA-BR', 'I-PLRE18WCA-BR', 6, 20, 2813.25, 5, 4951.32, 'activo'),
(58, 'Panel Led Redondo Embutir 18W Frío BRINNA', 'I-PLRE18WFR-BR', 'I-PLRE18WFR-BR', 6, 0, 2813.25, 5, 4951.32, 'activo'),
(59, 'Panel Led Redondo Embutir 24W Cálido BRINNA', 'I-PLRE24WCA-BR', 'I-PLRE24WCA-BR', 6, 15, 5009.40, 5, 8816.54, 'activo'),
(60, 'Panel Led Redondo Embutir 24W Frío BRINNA', 'I-PLRE24WFR-BR', 'I-PLRE24WFR-BR', 6, 5, 5009.40, 5, 8816.54, 'activo'),
(61, 'Panel Led Cuadrado Embutir 6W Cálido BRINNA', 'I-PLCE6WCA-BR', 'I-PLCE6WCA-BR', 6, 10, 1738.77, 5, 3060.23, 'activo'),
(62, 'Panel Led Cuadrado Embutir 6W Frío BRINNA', 'I-PLCE6WFR-BR', 'I-PLCE6WFR-BR', 6, 10, 1738.77, 5, 3060.23, 'activo'),
(63, 'Panel Led Cuadrado Embutir 12W Cálido BRINNA', 'I-PLCE12WCA-BR', 'I-PLCE12WCA-BR', 6, 20, 2608.15, 5, 4590.34, 'activo'),
(64, 'Panel Led Cuadrado Embutir 12W Frío BRINNA', 'I-PLCE12WFR-BR', 'I-PLCE12WFR-BR', 6, 16, 2608.15, 5, 4590.34, 'activo'),
(65, 'Panel Led Cuadrado Embutir 18W Cálido BRINNA', 'I-PLCE18WCA-BR', 'I-PLCE18WCA-BR', 6, 15, 3100.02, 5, 5456.03, 'activo'),
(66, 'Panel Led Cuadrado Embutir 18W Frío BRINNA', 'I-PLCE18WFR-BR', 'I-PLCE18WFR-BR', 6, 4, 3100.02, 5, 5456.03, 'activo'),
(67, 'Panel Led Cuadrado Embutir 24W Cálido BRINNA', 'I-PLCE24WCA-BR', 'I-PLCE24WCA-BR', 6, 15, 5283.46, 5, 9298.89, 'activo'),
(68, 'Panel Led Cuadrado Embutir 24W Frío BRINNA', 'I-PLCE24WFR-BR', 'I-PLCE24WFR-BR', 6, 4, 5283.46, 5, 9298.89, 'activo'),
(69, 'Panel Led Redondo Aplicar 6W Cálido BRINNA', 'I-PLRA6WCA-BR', 'I-PLRA6WCA-BR', 6, 10, 1829.52, 5, 3219.95, 'activo'),
(70, 'Panel Led Redondo Aplicar 6W Frío BRINNA', 'I-PLRA6WFR-BR', 'I-PLRA6WFR-BR', 6, 7, 1829.52, 5, 3219.95, 'activo'),
(71, 'Panel Led Redondo Aplicar 12W Cálido BRINNA', 'I-PLRA12WCA-BR', 'I-PLRA12WCA-BR', 6, 19, 2688.01, 5, 4730.90, 'activo'),
(72, 'Panel Led Redondo Aplicar 12W Frío BRINNA', 'I-PLRA12WFR-BR', 'I-PLRA12WFR-BR', 6, 20, 2688.01, 5, 4730.90, 'activo'),
(73, 'Panel Led Redondo Aplicar 18W Cálido BRINNA', 'I-PLRA18WCA-BR', 'I-PLRA18WCA-BR', 6, 8, 3270.63, 5, 5756.31, 'activo'),
(74, 'Panel Led Redondo Aplicar 18W Frío BRINNA', 'I-PLRA18WFR-BR', 'I-PLRA18WFR-BR', 6, 3, 3270.63, 5, 5756.31, 'activo'),
(75, 'Panel Led Redondo Aplicar 24W Cálido BRINNA', 'I-PLRA24WCA-BR', 'I-PLRA24WCA-BR', 6, 10, 5294.35, 5, 9318.06, 'activo'),
(79, 'Panel Led Redondo Aplicar 24W Frío BRINNA', 'I-PLRA24WFR-BR', 'I-PLRA24WFR-BR', 6, 9, 5294.35, 5, 9318.06, 'activo'),
(80, 'Panel Led Cuadrado Aplicar 6W Cálido BRINNA', 'I-PLCA6WCA-BR', 'I-PLCA6WCA-BR', 6, 10, 1932.97, 5, 3402.03, 'activo'),
(81, 'Panel Led Cuadrado Aplicar 6W Frío BRINNA', 'I-PLCA6WFR-BR', 'I-PLCA6WFR-BR', 6, 10, 1932.97, 5, 3402.03, 'activo'),
(82, 'Panel Led Cuadrado Aplicar 12W Cálido BRINNA', 'I-PLCA12WCA-BR', 'I-PLCA12WCA-BR', 6, 12, 2847.73, 5, 5012.01, 'activo'),
(83, 'Panel Led Cuadrado Aplicar 18W Cálido BRINNA', 'I-PLCA18WCA-BR', 'I-PLCA18WCA-BR', 6, 10, 3557.40, 5, 6261.02, 'activo'),
(84, 'Panel Led Cuadrado Aplicar 18W Frío BRINNA', 'I-PLCA18WFR-BR', 'I-PLCA18WFR-BR', 6, 9, 3557.40, 5, 6261.02, 'activo'),
(85, 'Panel Led Cuadrado Aplicar 24W Cálido BRINNA', 'I-PLCA24WCA-BR', 'I-PLCA24WCA-BR', 6, 10, 5993.13, 5, 10547.91, 'activo'),
(86, 'Panel Led Cuadrado Aplicar 24W Frío BRINNA', 'I-PLCA24WFR-BR', 'I-PLCA24WFR-BR', 6, 9, 5993.13, 5, 10547.91, 'activo'),
(87, 'Interruptor Termomagnetico Unipolar de 10a (1x10a) BRINNA', 'A-IT1X10-BR', 'A-IT1X10-BR', 7, 14, 2265.12, 1, 4289.92, 'activo'),
(88, 'Interruptor Termomagnetico Unipolar de 16a (1x16a) BRINNA', 'A-IT1X16-BR', 'A-IT1X16-BR', 7, 17, 2265.12, 1, 4289.92, 'activo'),
(89, 'Interruptor Termomagnetico Unipolar de 20a (1x20a) BRINNA', 'A-IT1X20-BR', 'A-IT1X20-BR', 7, 17, 2265.12, 1, 4289.92, 'activo'),
(90, 'Interruptor Termomagnetico Unipolar de 25a (1X25a) BRINNA', 'A-IT1X25-BR', 'A-IT1X25-BR', 7, 12, 2265.12, 1, 4289.92, 'activo'),
(91, 'Interruptor Termomagnetico Unipolar de 32a (1x32a) BRINNA', 'A-IT1X32-BR', 'A-IT1X32-BR', 7, 12, 2265.12, 1, 4289.92, 'activo'),
(92, 'Interruptor Termomagnetico Unipolar de 40a (1x40a) BRINNA', 'A-IT1X40-BR', 'A-IT1X40-BR', 7, 12, 2265.12, 1, 4289.92, 'activo'),
(93, 'Interruptor Termomagnetico Unipolar de 50a (1x50a) BRINNA', 'A-IT1X50-BR', 'A-IT1X50-BR', 7, 12, 2334.09, 1, 4291.74, 'activo'),
(94, 'Interruptor Termomagnetico Unipolar de 63a (1x63a) BRINNA', 'A-IT1X63-BR', 'A-IT1X63-BR', 7, 12, 2334.09, 1, 4291.74, 'activo'),
(95, 'Interruptor Termomagnetico Unipolar de 63a (1x63a) SICA', 'A-IT1X63-SI', 'A-IT1X63-SI', 5, 2, 3501.13, 1, 5391.74, 'activo'),
(96, 'Interruptor Termomagnetico Bipolar de 10a (2x10a) BRINNA', 'A-IT2X10-BR', 'A-IT2X10-BR', 7, 13, 4379.59, 1, 8671.59, 'activo'),
(97, 'Interruptor Termomagnetico Bipolar de 15a (2x15a) SICA', 'A-IT2X15-SI', 'A-IT2X15-SI', 5, 1, 6413.40, 1, 9876.64, 'activo'),
(98, 'Interruptor Termomagnetico Bipolar de 16a (2x16a) BRINNA', 'A-IT2X16-BR', 'A-IT2X16-BR', 7, 24, 4379.59, 1, 8671.59, 'activo'),
(99, 'Interruptor Termomagnetico Bipolar de 16a (2x16a) JELUZ', 'A-IT2X16-JE', 'A-IT2X16-JE', 5, 1, 6413.40, 1, 8978.76, 'activo'),
(101, 'Interruptor Termomagnetico Bipolar de 20a (2x20a) BRINNA', 'A-IT2X20-BR', 'A-IT2X20-BR', 7, 12, 4379.59, 1, 8671.59, 'activo'),
(102, 'Interruptor Termomagnetico Bipolar de 25a (2x25a) BRINNA', 'A-IT2X25-BR', 'A-IT2X25-BR', 7, 10, 4379.59, 1, 8671.59, 'activo'),
(103, 'Interruptor Termomagnetico Bipolar de 20a (2x20a) SICA', 'A-IT2X20-SI', 'A-IT2X20-SI', 5, 1, 6413.40, 1, 9876.64, 'activo'),
(104, 'Interruptor Termomagnetico Bipolar de 32a (2x32a) BRINNA', 'A-IT2X32-BR', 'A-IT2X32-BR', 7, 8, 4379.59, 1, 8671.59, 'activo'),
(105, 'Interruptor Termomagnetico Bipolar de 40a (2x40a) BRINNA', 'A-IT2X40-BR', 'A-IT2X40-BR', 7, 8, 4379.59, 1, 8671.59, 'activo'),
(106, 'Interruptor Termomagnetico Bipolar de 50a (2x50a) BRINNA', 'A-IT2X50-BR', 'A-IT2X50-BR', 7, 10, 4506.64, 1, 8923.15, 'activo'),
(107, 'Interruptor Termomagnetico Bipolar de 63a (2x63a) BRINNA', 'A-IT2X63-BR', 'A-IT2X63-BR', 7, 5, 4506.64, 1, 8923.15, 'activo'),
(108, 'Caja de Embutir para 48 módulos Din PTA FUME SISTELECTRIC', 'T-EMP48-GE', 'T-EMP48-GE', 9, 0, 52168.00, 9, 88685.60, 'activo'),
(109, 'Peine de conexión Bipolar de 63A 12 POLOS BRINNA', 'T-P263A12-BR', 'T-P263A12-BR', 7, 6, 7443.46, 9, 12653.88, 'activo'),
(110, 'Interruptor Diferencial Bipolar de 40a (2x40a) 30mA BRINNA', 'A-ID2X40-BR', 'A-ID2X40-BR', 7, 5, 16808.71, 1, 32356.76, 'activo'),
(111, 'Bornera de Distribución -Repartidora- Din Bipolar de 7 Polos BRINNA', 'T-BD2X7-BR', 'T-BD2X7-BR', 7, 4, 12750.37, 9, 25245.74, 'activo'),
(112, 'Bornera de Distribución -Repartidora- Din Verde Amarillo 7 Polos BRINNA', 'T-BD1X7VA-BR', 'T-BD1X7VA-BR', 7, 6, 3305.11, 9, 6544.12, 'activo'),
(113, 'Conector Para Peine Ingreso lateral 63A BRINNA', 'T-CP63IL-BR', 'T-CP63IL-BR', 7, 41, 1635.31, 9, 3237.92, 'activo'),
(114, 'Protector de Tensión Monofásico Brinna SPC-63', 'A-PT2X63SPC-BR', 'A-PT2X63SPC-BR', 7, 7, 11960.85, 1, 23682.48, 'activo'),
(115, 'Puntera tubular preaislada Terminal TIFF x100 de 2,5mm2 10mm', 'T-PB2510-BR', 'T-PB2510-BR', 7, 2, 2744.28, 9, 5433.67, 'activo'),
(116, 'Puntera tubular preaislada Terminal TIFF x100 de 4mm2 9mm', 'T-PB4009-BR', 'T-PB4009-BR', 7, 1, 2759.98, 9, 5464.76, 'activo'),
(117, 'Puntera tubular preaislada Terminal TIFF x100 de 6mm2 10mm', 'T-PB6010-BR', 'T-PB6010-BR', 7, 5, 4198.09, 9, 8312.22, 'activo'),
(118, 'Puntera Doble tubular preaislada Terminal TIFF x100 de 6mm2 14mm', 'I-PDB6014-BR', 'I-PDB6014-BR', 7, 1, 11309.26, 9, 21148.31, 'activo'),
(119, 'Caja de Inspección de Puesta a Tierra GENROD', 'P-CAPAT-GE', 'P-CAPAT-GE', 14, 3, 2028.06, 8, 4015.56, 'activo'),
(120, 'Jabalina 5/8\" x 1,5m con tomacable', 'P-JM5/8-1,5-GE', 'P-JM5/8-1,5-GE', 9, 0, 11252.33, 8, 17967.43, 'activo'),
(121, 'Caño Corrugado Liviano de 7/8\" ᴓ (22mm) SISTELECTRIC', 'K-CCOR22-GE', 'K-CCOR22-GE', 9, 175, 406.56, 6, 540.99, 'activo'),
(122, 'Caño Corrugado Liviano de 3/4\" ᴓ (20mm) SISTELECTRIC', 'K-CCOR20-GE', 'K-CCOR20-GE', 9, 300, 321.30, 6, 427.54, 'activo'),
(123, 'Caja Cuadrada de Metal 10X10 AG', 'D-CCM10X10-AG', 'D-CCM10X10-AG', 9, 28, 1359.06, 6, 1808.43, 'activo'),
(124, 'Tapa ciega de metal para caja de paso 10*10', 'D-TCM10X10-', 'D-TCM10X10-', 9, 4, 651.00, 6, 866.25, 'activo'),
(125, 'Caja Octogonal de Metal Chica AG', 'D-COMC-AG', 'D-COMC-AG', 9, 41, 462.12, 6, 614.92, 'activo'),
(126, 'Caja Rectangular de Metal Liviana Galv. AG', 'D-CRM-AG', 'D-CRM-AG', 9, 130, 462.12, 3, 614.92, 'activo'),
(127, 'Conector de PVC 7/8\" ᴓ (22mm) SISTELECTRIC', 'K-COPVC22-GE', 'K-COPVC22-GE', 9, 76, 418.34, 6, 556.67, 'activo'),
(128, 'Conector de Metal 22mm (7/8) AG', 'K-CM23-AG', 'K-CM23-AG', 5, 73, 402.67, 6, 664.40, 'activo'),
(129, 'Cable unipolar 1x2,5mm2 color celeste FONSECA', 'C-U1X2,5C-FO', 'C-U1X2,5C-FO', 10, 48, 671.13, 2, 1181.19, 'activo'),
(130, 'Cable unipolar 1x2,5mm2 color marrón FONSECA', 'C-U1X2,5M-FO', 'C-U1X2,5M-FO', 10, 16, 671.13, 2, 1181.19, 'activo'),
(131, 'Cable unipolar 1x2,5mm2 color verdeamarillo FONSECA', 'C-U1X2,5VA-FO', 'C-U1X2,5VA-FO', 10, 91, 671.13, 2, 1181.19, 'activo'),
(132, 'Cable unipolar 1x1,5mm2 color marrón FONSECA', 'C-U1X1,5M-FO', 'C-U1X1,5M-FO', 10, 95, 411.34, 2, 723.95, 'activo'),
(133, 'Cable unipolar 1x1,5mm2 color celeste FONSECA', 'C-U1X1,5C-FO', 'C-U1X1,5C-FO', 10, 96, 411.34, 2, 723.95, 'activo'),
(134, 'Cable unipolar 1x10mm2 color celeste FONSECA', 'C-U1X10C-FO', 'C-U1X10C-FO', 10, 0, 4500.00, 2, 5049.00, 'activo'),
(135, 'Cable unipolar 1x10mm2 color marrón FONSECA', 'C-U1X10M-FO', 'C-U1X10M-FO', 10, 0, 4500.00, 2, 5049.00, 'activo'),
(136, 'Puntera tubular preaislada Terminal TIFF x100 de 10mm2 12mm', 'T-PB1012-BR', 'T-PB1012-BR', 7, 3, 5615.61, 9, 11118.91, 'activo'),
(137, 'Protector de Tensión Monofásico Configurable SPVA-40 BRINNA', 'A-PT2X40SPVA-BR', 'A-PT2X40SPVA-BR', 7, 3, 23259.22, 1, 38377.71, 'activo'),
(140, 'Interruptor Termomagnetico Tetrapolar de 25a (4x25a) BRINNA', 'A-IT4X25-BR', 'A-IT4X25-BR', 7, 3, 8373.90, 1, 15910.41, 'activo'),
(141, 'Interruptor Termomagnetico Tetrapolar de 32a (4x32a) BRINNA', 'A-IT4X32-BR', 'A-IT4X32-BR', 7, 6, 8373.90, 1, 15910.41, 'activo'),
(142, 'Interruptor Termomagnetico Tetrapolar de 40a (4X40a) BRINNA', 'A-IT4X40-BR', 'A-IT4X40-BR', 7, 5, 8373.90, 1, 15910.41, 'activo'),
(143, 'Interruptor Termomagnetico Tetrapolar de 50a (4x50a) BRINNA', 'A-IT4X50-BR', 'A-IT4X50-BR', 7, 3, 9330.91, 1, 18475.20, 'activo'),
(144, 'Interruptor Termomagnetico Tetrapolar de 63a (4x63a) BRINNA', 'A-IT4X63-BR', 'A-IT4X63-BR', 7, 3, 9330.91, 1, 18475.20, 'activo'),
(145, 'Interruptor Diferencial Bipolar de 25a (2x25a) 30mA BRINNA', 'A-ID2X25-BR', 'A-ID2X25-BR', 7, 3, 16808.71, 1, 33281.25, 'activo'),
(146, 'Interruptor Diferencial Bipolar de 25a (2x25a) 30mA JELUZ', 'A-ID2X25-JE', 'A-ID2X25-JE', 7, 2, 16808.71, 1, 33281.25, 'activo'),
(147, 'Interruptor Diferencial Bipolar de 40a (2x40a) 30mA STECK', 'A-ID2X40-ST', 'A-ID2X40-ST', 5, 1, 17837.82, 1, 35318.89, 'activo'),
(148, 'Interruptor Diferencial Bipolar de 63a (2x63a) 30mA BRINNA', 'A-ID2X63-BR', 'A-ID2X63-BR', 7, 3, 17837.32, 1, 35317.90, 'activo'),
(149, 'Interruptor Diferencial Tetrapolar de 25a (4x25a) 30mA BRINNA', 'A-ID4X25-BR', 'A-ID4X25-BR', 7, 0, 24469.83, 1, 48450.26, 'activo'),
(150, 'Interruptor Diferencial Tetrapolar de 40a (4x40a) 30mA BRINNA', 'A-ID4X40-BR', 'A-ID4X40-BR', 7, 2, 24469.83, 1, 48450.26, 'activo'),
(151, 'Interruptor Diferencial Tetrapolar de 63a (4x63a) 30mA BRINNA', 'A-ID4X63-BR', 'A-ID4X63-BR', 7, 1, 26528.04, 1, 52525.52, 'activo'),
(152, 'Protector de Tensión Monofásico Configurable SPVA-63 BRINNA', 'A-PT2X63-BRSPVA', 'A-PT2X63-BRSPVA', 7, 2, 22827.33, 1, 38806.46, 'activo'),
(153, 'Protector y Medidor Monofasico BRINNA SPF-63', 'A-PTyM2X63-BRSPF', 'A-PTyM2X63-BRSPF', 7, 0, 36031.38, 1, 71342.13, 'activo'),
(154, 'Cinta Pasacable de 10mts 4mm con Alma de Acero VIYILANT', 'H-CP104AA-VI', 'H-CP104AA-VI', 5, 2, 5450.50, 4, 10791.99, 'activo'),
(155, 'Destornillador Aislado Plano PL3-100 BRINNA', 'H-DAPL3-100-BR', 'H-DAPL3-100-BR', 8, 2, 3328.71, 4, 6590.85, 'activo'),
(156, 'Destornillador Aislado Plano PL4-100 BRINNA', 'H-DAPL4-100-BR', 'H-DAPL4-100-BR', 8, 1, 3591.88, 4, 7111.92, 'activo'),
(157, 'Destornillador Aislado Plano PL5.5-100 BRINNA', 'H-DAPL5.5-100-BR', 'H-DAPL5.5-100-BR', 8, 2, 4379.59, 4, 8671.59, 'activo'),
(158, 'Destornillador Aislado Philips PH1-80 BRINNA', 'H-DAPH1-80-BR', 'H-DAPH1-80-BR', 8, 2, 3855.06, 4, 7633.02, 'activo'),
(159, 'Destornillador Aislado Philips PH2-100 BRINNA', 'H-DAPH2-100-BR', 'H-DAPH2-100-BR', 8, 2, 4860.57, 4, 9623.93, 'activo'),
(160, 'Destornillador Aislado Para Termicas SLPZ2-100 BRINNA', 'H-DASLPZ2-100-BR', 'H-DASLPZ2-100-BR', 8, 4, 6198.22, 4, 12272.48, 'activo'),
(161, 'Alicate de 7\" HB-DC7 BRINNA', 'H-AHB-DC7-BR', 'H-AHB-DC7-BR', 8, 2, 6232.71, 4, 12340.77, 'activo'),
(162, 'Alicate de 8\" HB-DC8 BRINNA', 'H-AHB-DC8-BR', 'H-AHB-DC8-BR', 8, 2, 6541.26, 4, 12951.70, 'activo'),
(164, 'Pinza Universal de 8\" HB-CP8 BRINNA', 'H-PUHB-CP8-BR', 'H-PUHB-CP8-BR', 8, 4, 7272.70, 4, 14399.95, 'activo'),
(165, 'Pinza Universal de 7\" HB-CP8 BRINNA', 'H-PUHB-CP7-BR', 'H-PUHB-CP7-BR', 8, 2, 6495.88, 4, 12861.84, 'activo'),
(166, 'Pinza Punta Larga de 8\" HB-LN8 BRINNA', 'H-PPLHB-LN8-BR', 'H-PPLHB-LN8-BR', 8, 3, 6416.02, 4, 12703.72, 'activo'),
(167, 'Pinza Punta Larga de 7\" HB-LN8 BRINNA', 'H-PPLHB-LN7-BR', 'H-PPLHB-LN7-BR', 8, 2, 5775.33, 4, 11435.15, 'activo'),
(168, 'SET Destornilladores Aislados 12 Piezas BRINNA', 'H-SDAHB-60-BR', 'H-SDAHB-60-BR', 8, 1, 23052.31, 4, 45643.58, 'activo'),
(169, 'SET Destornilladores Aislados 6 Piezas BRINNA', 'H-SDAHB-65-BR', 'H-SDAHB-65-BR', 8, 1, 21760.03, 4, 43084.86, 'activo'),
(170, 'SET Destornilladores Aislados 7 Piezas BRINNA', 'H-SDAHB-63-BR', 'H-SDAHB-63-BR', 8, 2, 19749.01, 4, 39103.04, 'activo'),
(171, 'KIT de Crimpeadora Terminales Tubulares + 1200 Terminales + Pelacables HB-105 BRINNA', 'H-KCTHB-105-BR', 'H-KCTHB-105-BR', 8, 1, 24642.25, 4, 44356.05, 'activo'),
(172, 'Pinza Crimpeadora 7\" HB-104 BRINNA', 'H-PCHB-104-BR', 'H-PCHB-104-BR', 8, 1, 14764.99, 4, 29234.68, 'activo'),
(173, 'Pinza Amperometrica HB-202 Pro BRINNA', 'H-PAHB-202PRO-BR', 'H-PAHB-202PRO-BR', 8, 2, 25589.55, 4, 50667.31, 'activo'),
(174, 'Pinza Voltamperometrica HB-87 BRINNA', 'H-PVAHB-87-BR', 'H-PVAHB-87-BR', 8, 2, 10383.61, 4, 20559.55, 'activo'),
(175, 'Termometro Infrarrojo HB-15 BRINNA', 'H-TIHB-15-BR', 'H-TIHB-15-BR', 8, 1, 23760.98, 4, 47046.74, 'activo'),
(176, 'Buscapolo Smart HB-64 BRINNA', 'H-BSHB-64-BR', 'H-BSHB-64-BR', 8, 4, 10634.08, 4, 18609.64, 'activo'),
(177, 'Buscapolo Smart HB-62 BRINNA', 'H-BSHB-62-BR', 'H-BSHB-62-BR', 8, 4, 4483.05, 4, 8069.49, 'activo'),
(178, 'Detector de Tension HB-10 BRINNA', 'H-DTHB-10-BR', 'H-DTHB-10-BR', 8, 7, 4780.71, 4, 8605.28, 'activo'),
(179, 'Detector de Tension HB-12 BRINNA', 'H-DTHB-12-BR', 'H-DTHB-12-BR', 8, 8, 12383.74, 4, 19813.98, 'activo'),
(180, 'Bornera de Distribución -Repartidora- Din Azul 7 Polos BRINNA', 'T-BD1X7AZ-BR', 'T-BD1X7AZ-BR', 7, 2, 3305.11, 9, 6544.12, 'activo'),
(181, 'Bornera de Distribución -Repartidora- Din Verde Amarillo 15 Polos BRINNA', 'T-BD1X15VA-BR', 'T-BD1X15VA-BR', 7, 3, 6472.27, 9, 12815.10, 'activo'),
(182, 'Bornera de Distribución -Repartidora- Din Negro 7 Polos BRINNA', 'T-BD1X7NE-BR', 'T-BD1X7NE-BR', 7, 3, 3305.11, 9, 6544.12, 'activo'),
(183, 'Bornera de Distribución -Repartidora- Din Tetrapolar 7 Polos BRINNA', 'T-BD4X7-BR', 'T-BD4X7-BR', 7, 2, 17175.34, 9, 34007.17, 'activo'),
(184, 'Bornera de Distribución -Repartidora- Din Tetrapolar 12 Polos ELENT', 'T-BD4X12-EL', 'T-BD4X12-EL', 5, 1, 23738.38, 9, 47001.99, 'activo'),
(185, 'Interruptor Horario Digital Timer IHD-150 BAW', 'T-IHD-150-BA', 'T-IHD-150-BA', 5, 1, 34011.65, 9, 39793.63, 'activo'),
(186, 'Bornera de Empalme Rapido PRO 4 Vias ER2-4 BRINNA', 'X-BERPRO4-BR', 'X-BERPRO4-BR', 7, 18, 515.85, 11, 1021.38, 'activo'),
(187, 'Bornera de Empalme Rapido PRO 3 Vias ER2-3 BRINNA', 'X-BERPRO3-BR', 'X-BERPRO3-BR', 7, 18, 446.49, 11, 884.05, 'activo'),
(188, 'KIT Termocontraibles 560 Piezas BRINNA', 'X-KST-560-BR', 'X-KST-560-BR', 7, 2, 9210.58, 11, 17500.10, 'activo'),
(189, 'Control de Nivel Flotante Hermetico 1.5 Automatico Tanque Cisterna', 'Y-FL1.5-VI', 'Y-FL1.5-VI', 5, 5, 8334.85, 12, 12835.67, 'activo'),
(190, 'Cinta Aisladora Negra de 20m 3M Temflex', 'X-CA20NE-3M', 'X-CA20NE-3M', 9, 20, 2965.94, 11, 4209.72, 'activo'),
(191, 'Caja de Sobreponer para 8 modulos DIN de PVC PTA FUME SISTELECTRIC', 'T-EXP8-GE', 'T-EXP8-GE', 9, 4, 14097.09, 9, 18758.22, 'activo'),
(192, 'Cable unipolar 1x1.5mm2 color Negro FONSECA', 'C-U1X1.5N-FO', 'C-U1X1.5N-FO', 10, 100, 411.34, 2, 723.95, 'activo'),
(193, 'Cable unipolar 1x1,5mm2 color rojo FONSECA', 'C-U1X1,5R-FO', 'C-U1X1,5R-FO', 10, 129, 411.34, 2, 723.95, 'activo'),
(194, 'Cable unipolar 1x2,5mm2 color rojo FONSECA', 'C-U1X2,5R-FO', 'C-U1X2,5R-FO', 10, 70, 671.13, 2, 1181.19, 'activo'),
(195, 'Cable unipolar 1x4mm2 color celeste FONSECA', 'C-U1X4C-FO', 'C-U1X4C-FO', 10, 164, 1067.31, 2, 1878.48, 'activo'),
(196, 'Cable unipolar 1x4mm2 color marron FONSECA', 'C-U1X4M-FO', 'C-U1X4M-FO', 10, 164, 1067.31, 2, 1878.47, 'activo'),
(197, 'Cable unipolar 1x6mm2 color celeste FONSECA', 'C-U1X6C-FO', 'C-U1X6C-FO', 10, 135, 1616.13, 2, 2844.39, 'activo'),
(198, 'Cable unipolar 1x6mm2 color marron FONSECA', 'C-U1X6M-FO', 'C-U1X6M-FO', 10, 110, 1616.13, 2, 2844.39, 'activo'),
(199, 'Cable unipolar 1x1,5mm2 color verde amarillo FONSECA', 'C-U1X1,5VA-FO', 'C-U1X1,5VA-FO', 10, 100, 411.34, 2, 723.95, 'activo'),
(202, 'Conector de PVC 1\" Ø (25mm) SISTELECTRIC', 'K-COPV25-GE', 'K-COPV25-GE', 9, 95, 584.61, 6, 829.77, 'activo'),
(203, 'Caño Rigido Semipesado de 7/8\" ᴓ (22mm) SISTELECTRIC', 'K-CRPVC22-GE', 'K-CRPVC22-GE', 9, 48, 1757.63, 6, 2494.69, 'activo'),
(204, 'Caño Rigido Semipesado de 1\" ᴓ (25mm) SISTELECTRIC', 'K-CRPVC25-GE', 'K-CRPVC25-GE', 9, 23, 1844.38, 6, 2617.82, 'activo'),
(205, 'Curva de PVC 7/8\" Ø (22mm) SISTELECTRIC', 'K-CUPVC22-GE', 'K-CUPVC22-GE', 9, 124, 543.12, 6, 770.88, 'activo'),
(206, 'Curva de PVC 1\" Ø (25mm) SISTELECTRIC', 'K-CUPVC25-GE', 'K-CUPVC25-GE', 9, 47, 584.61, 6, 829.77, 'activo'),
(207, 'Grampa de PVC 7/8\" Ø (22mm) SISTELECTRIC', 'K-GRPVC22-GE', 'K-GRPVC22-GE', 9, 131, 222.89, 6, 316.36, 'activo'),
(208, 'Grampa de PVC 1\" Ø (25mm) SISTELECTRIC', 'K-GRPVC25-GE', 'K-GRPVC25-GE', 9, 107, 249.17, 6, 353.65, 'activo'),
(209, 'Unión de PVC 7/8\" Ø (22MM) SISTELECTRIC', 'K-UNPVC22-GE', 'K-UNPVC22-GE', 9, 138, 202.47, 6, 287.38, 'activo'),
(210, 'Unión de PVC  1\" Ø (25mm) SISTELECTRIC', 'K-UNPVC25-GE', 'K-UNPVC25-GE', 9, 85, 219.37, 6, 311.37, 'activo'),
(211, 'Bastidor Rectangular para caja 10X5 Negro JELUZ', 'LL-BN10X5-JE', 'LL-BN10X5-JE', 5, 55, 343.40, 7, 566.61, 'activo'),
(212, 'Módulo Tapon Ciego BLANCO JELUZ PLATINUM', 'LL-MCB-JE', 'LL-MCB-JE', 5, 95, 79.67, 7, 109.45, 'activo'),
(213, 'Módulo Tomacorriente binorma 10A JELUZ PLATINUM', 'LL-MTC10B-JE', 'LL-MTC10B-JE', 5, 23, 702.26, 7, 1048.73, 'activo'),
(214, 'Tapa para Bastidor 10X5 Blanco JELUZ PLATINUM', 'LL-TBPB-JE', 'LL-TBPB-JE', 5, 63, 376.37, 7, 621.02, 'activo'),
(215, 'Tornillo y Tarugo FISHER 6mm', 'Y-TT6MM-FI', 'Y-TT6MM-FI', 5, 800, 48.50, 12, 80.03, 'desactivado'),
(216, 'ARANDELA PLANA METAL 4X10', 'Y-AR4X10', 'Y-AR4X10', 5, 200, 25.00, 12, 37.95, 'activo'),
(217, 'Caja de Pase IP65 90X90X55mm Blanca SISTELECTRIC', 'D-CE90X90X55BL-GE', 'D-CE90X90X55BL-GE', 9, 14, 1494.00, 3, 2539.80, 'activo'),
(218, 'Caja de embutir Octogonal Chica de PVC SISTELECTRIC', 'D-COPVCC-GE', 'D-COPVCC-GE', 9, 32, 302.00, 3, 513.40, 'activo'),
(219, 'Caja de embutir Cuadrada 10x10 de PVC SISTELECTRIC', 'D-CCPVC-GE', 'D-CCPVC-GE', 9, 10, 890.00, 3, 1263.22, 'activo'),
(220, 'Caja de embutir de pase 10x16 con TAPA de PVC SISTELECTRIC', 'D-C10X16TPVC-GE', 'D-C10X16TPVC-GE', 9, 2, 8441.05, 3, 8985.64, 'activo'),
(221, 'Tapa ciega de PVC para caja de paso 10*10 SISTELECTRIC', 'D-TCPVX10X10-GE', 'D-TCPVX10X10-GE', 9, 3, 738.82, 3, 983.10, 'activo'),
(222, 'Tapa ciega Octogonal Chica de PVC SISTELECTRIC', 'D-TCOPVCC-GE', 'D-TCOPVCC-GE', 9, 26, 775.76, 3, 938.41, 'activo'),
(223, 'Adhesivo Sellador para tubos y accesorios GENROD', 'K-ASTA-GE', 'K-ASTA-GE', 9, 0, 8903.00, 6, 15135.10, 'activo'),
(224, 'Llave Conmutadora 40a DIN Manual Tetrapolar BAW', 'T-LLC40MT-BA', 'T-LLC40MT-BA', 5, 2, 32185.44, 9, 49887.43, 'activo'),
(225, 'Caja de embutir Rectangular de PVC SISTELECTRIC', 'D-CERPVC-GE', 'D-CERPVC-GE', 9, 5, 356.71, 3, 474.65, 'activo'),
(226, 'Precintos 3,6x150mm Negro 100u BRINNA', 'X-PREC3,6X150N-BR', 'X-PREC3,6X150N-BR', 8, 2, 1624.42, 11, 3216.36, 'activo'),
(227, 'Plafón Led de 30W Redondo de embutir Frio LEDVANCE OSRAM', 'I-PL30RWEF-OS', 'I-PL30RWEF-OS', 9, 0, 47021.89, 5, 42964.36, 'activo'),
(228, 'Reemplazo de cuatro (4) plafones LED en altura', 'S-M4P30W-O', 'S-M4P30W-O', 11, 0, 15600.00, 13, 15756.00, 'activo'),
(229, 'Colocación de Panel Led LED Aplicar y conexión.', 'S-IPLAPL-', 'S-IPLAPL-', 11, 9997, 0.00, 13, 15000.00, 'activo'),
(230, 'Caja de Pase IP65 115x115x110mm Blanca SISTELECTRIC', 'D-CE115X115X110BL-GE', 'D-CE115X115X110BL-GE', 9, 10, 3219.92, 3, 4855.85, 'activo'),
(232, 'Caja de Pase IP65 115x115x65mm Blanca SISTELECTRIC', 'D-CE115X115X65BL-GE', 'D-CE115X115X65BL-GE', 9, 23, 2540.60, 3, 3831.39, 'activo'),
(233, 'Caja de Pase IP65 115x115x80mm Gris SISTELECTRIC', 'D-CE115X115X80GR-GE', 'D-CE115X115X80GR-GE', 9, 20, 2676.01, 3, 4035.59, 'activo'),
(234, 'Caja de Pase IP65 115x115x80mm Blanca SISTELECTRIC', 'D-CE115X115X80BL-GE', 'D-CE115X115X80BL-GE', 9, 2, 2676.01, 3, 4035.59, 'activo'),
(235, 'Caja de Pase IP65 90X90X75mm Blanca SISTELECTRIC', 'D-CE90X90X75BL-GE', 'D-CE90X90X75BL-GE', 9, 10, 1932.13, 3, 2913.78, 'activo'),
(236, 'Caja Monoblock Rectangular de Sobreponer Blanco SISTELECTRIC', 'D-CMRSBL-GE', 'D-CMRSBL-GE', 9, 76, 1125.00, 3, 1912.50, 'activo'),
(237, 'Cablecanal 18x21 con Cinta Autoadhesiva SISTELECTRIC', 'K-CCAN18X21CA-GE', 'K-CCAN18X21CA-GE', 9, 8, 1486.77, 6, 2242.15, 'activo'),
(238, 'Cablecanal 20x10 con Cinta Autoadhesiva SISTELECTRIC', 'K-CCAN20X10CA-GE', 'K-CCAN20X10CA-GE', 9, 24, 928.72, 6, 1400.58, 'activo'),
(239, 'Curva Plana para Cable Canal Sistelectric 20x10', 'K-CUCC20X10-GE', 'K-CUCC20X10-GE', 9, 20, 237.06, 6, 378.53, 'activo'),
(240, 'Esquinero para Cable Canal Sistelectric 20x10', 'K-ESCC20X10-GE', 'K-ESCC20X10-GE', 9, 20, 237.06, 6, 378.53, 'activo'),
(241, 'Extremo para Cable Canal Sistelectric 20x10', 'K-EXCC20X10-GE', 'K-EXCC20X10-GE', 9, 50, 237.06, 6, 378.53, 'activo'),
(242, 'Rinconero para Cable Canal Sistelectric 20x10', 'K-RICC20X10-GE', 'K-RICC20X10-GE', 9, 49, 237.06, 6, 378.53, 'activo'),
(243, 'TE para Cable Canal Sistelectric 20x10', 'K-TECC20X10-GE', 'K-TECC20X10-GE', 9, 50, 237.06, 6, 378.53, 'activo'),
(244, 'Union para Cable Canal Sistelectric 20x10', 'K-UNCC20X10-GE', 'K-UNCC20X10-GE', 9, 50, 237.06, 6, 378.53, 'activo'),
(245, 'Base para Precintos de 20x20 Negro BRINNA', 'X-BP2020N-BR', 'X-BP2020N-BR', 8, 2, 7147.42, 11, 12579.46, 'activo'),
(246, 'Base para Precintos de 30x30 Negro BRINNA', 'X-BP3030N-BR', 'X-BP3030N-BR', 8, 1, 11144.05, 11, 19613.53, 'activo'),
(247, 'Precintos 2.5x150mm Negro 100u BRINNA', 'X-PREC2.5X150N-BR', 'X-PREC2.5X150N-BR', 8, 0, 1367.10, 11, 2706.86, 'activo'),
(248, 'Precintos 3,6x200mm Negro 100u BRINNA', 'X-PREC3,6X200N-BR', 'X-PREC3,6X200N-BR', 8, 0, 1793.45, 11, 3551.03, 'activo'),
(249, 'Precintos 4.8x350mm Negro 100u BRINNA', 'X-PREC4.8X350N-BR', 'X-PREC4.8X350N-BR', 8, 3, 5360.00, 11, 10612.80, 'activo'),
(250, 'Caja de embutir para 12 Modulos DIN PTA FUME SISTELECTRIC', 'T-EMP12-GE', 'T-EMP12-GE', 9, 2, 18482.10, 9, 26232.66, 'activo'),
(252, 'Caja de Embutir para 16 módulos DIN PTA FUME SISTELECTRIC', 'T-EMP16-GE', 'T-EMP16-GE', 9, 0, 26403.39, 9, 37475.79, 'activo'),
(253, 'Caja de Embutir para 36 módulos DIN PTA FUME SISTELECTRIC', 'T-EMP36-GE', 'T-EMP36-GE', 9, 1, 44006.21, 9, 62460.43, 'activo'),
(254, 'Caja de Embutir para 24 módulos DIN PTA FUME SISTELECTRIC', 'T-EMP24-GE', 'T-EMP24-GE', 9, 1, 35204.77, 9, 49968.05, 'activo'),
(255, 'Caja de Embutir para 4 módulos DIN PTA FUME SISTELECTRIC', 'T-EMP4-GE', 'T-EMP4-GE', 9, 1, 8184.42, 9, 11616.59, 'activo'),
(256, 'Caja de Embutir para 8 módulos DIN PTA FUME SISTELECTRIC', 'T-EMP8-GE', 'T-EMP8-GE|', 9, 3, 11440.96, 9, 16238.78, 'activo'),
(257, 'Caja DIN 4 Bocas Interperie para Pilar IP65 SISTELECTRIC', 'T-EXIP4-GE', 'T-EXIP4-GE', 9, 1, 17253.94, 9, 24489.47, 'activo'),
(258, 'Caja de Sobreponer para 12 modulos DIN de PVC PTA FUME SISTELECTRIC', 'T-EXP12-GE', 'T-EXP12-GE', 9, 0, 22772.77, 9, 32322.64, 'activo'),
(259, 'Caja de Sobreponer para 16 modulos DIN de PVC PTA FUME SISTELECTRIC', 'T-EXP16-GE', 'T-EXP16-GE', 9, 1, 32532.93, 9, 46175.77, 'activo'),
(260, 'Caja de Sobreponer para 24 modulos DIN de PVC PTA FUME SISTELECTRIC', 'T-EXP24-GE', 'T-EXP24-GE', 9, 2, 44281.23, 9, 62850.78, 'activo'),
(261, 'Caja de Sobreponer para 36 modulos DIN de PVC PTA FUME SISTELECTRIC', 'T-EXP36-GE', 'T-EXP36-GE', 9, 1, 54222.12, 9, 76960.43, 'activo'),
(262, 'Caja de Sobreponer para 48 modulos DIN de PVC PTA FUME SISTELECTRIC', 'T-EXP48-GE', 'T-EXP48-GE', 9, 1, 76815.06, 9, 109027.83, 'activo'),
(264, 'Caja de Sobreponer para 4 modulos DIN de PVC PTA FUME SISTELECTRIC', 'T-EXP4-GE', 'T-EXP4-GE', 9, 10, 9193.00, 9, 15628.10, 'activo'),
(265, 'Caja Exterior TM para 8 Modulos DIN de PVC PTA FUME SISTELECTRIC', 'T-EXTMP8-GE', 'T-EXTMP8-GE', 9, 9, 5562.37, 9, 7894.98, 'activo'),
(266, 'Caño Corrugado Liviano de 1\" ᴓ (25mm) SISTELECTRIC', 'K-CCOR25-GE', 'K-CCOR25-GE', 9, 250, 423.91, 6, 601.68, 'activo'),
(267, 'Conector de PVC 3/4\" ᴓ (20mm) SISTELECTRIC', 'K-COPVC20-GE', 'K-COPVC20-GE', 9, 67, 204.24, 6, 289.89, 'activo'),
(268, 'Caño Rigido Semipesado de 3/4\" ᴓ (20mm) SISTELECTRIC', 'K-CRPVC20-GE', 'K-CRPVC20-GE', 9, 123, 1305.79, 6, 1853.39, 'activo'),
(269, 'Curva de PVC  3/4\" Ø (20mm) SISTELECTRIC', 'K-CUPVC20-GE', 'K-CUPVC20-GE', 9, 128, 456.05, 6, 647.30, 'activo'),
(270, 'Grampa de PVC 3/4\" Ø (20mm) SISTELECTRIC', 'K-GRPVC20-GE', 'K-GRPVC20-GE', 9, 156, 206.03, 6, 292.42, 'activo'),
(271, 'UNION DE PVC 3/4\" Ø (20MM) SISTELECTRIC', 'K-UNPVC20-GE', 'K-UNPVC20-GE', 9, 156, 152.19, 6, 216.01, 'activo'),
(272, 'Modulo Punto Platinum Blanco JELUZ', 'LL-MI10UPB-JE', 'LL-MI10UPB-JE', 5, 112, 642.07, 7, 1130.04, 'activo'),
(273, 'Modulo Interruptor Doble Medio Punto Platinum Blanco JELUZ', 'LL-MIBPPB-JE', 'LL-MIBPPB-JE', 5, 13, 1542.94, 7, 2715.57, 'activo'),
(274, 'Modulo Punto Combinación Blanco JELUZ Platinum', 'LL-MIC10UPB-JE', 'LL-MIC10UPB-JE', 5, 25, 694.40, 7, 1222.14, 'activo'),
(275, 'Modulo Teclon Interruptor Combinacion Platinum Blanco JELUZ', 'LL-MIC1X3PB-JE', 'LL-MIC1X3PB-JE', 5, 10, 976.49, 7, 1718.62, 'activo'),
(276, 'Modulo Interruptor Combinacion Medio Teclon Platinum Blanco JELUZ', 'LL-MIC2X1/2PB-JE', 'LL-MIC2X1/2PB-JE', 5, 20, 1787.84, 7, 3146.59, 'activo'),
(277, 'Modulo Tomacorriente 16a Schuko Platinum JELUZ', 'LL-MTSCH16-JE', 'LL-MTSCH16-JE', 5, 9, 3100.00, 7, 4650.00, 'activo'),
(278, 'Modulo Tomacorriente 20a Platinum JELUZ', 'LL-MT20CPB-JE', 'LL-MT20CPB-JE', 5, 17, 1296.89, 7, 1945.34, 'activo'),
(279, 'Modulo Tomacorriente Doble Combinado + Tierra JELUZ PLATINUM', 'LL-MT2X10CPB-JE', 'LL-MT2X10CPB-JE', 5, 2, 1924.99, 7, 3387.98, 'activo'),
(280, 'Llave de Punto Comun y Toma de 10a Exterior Extrachato JELUZ', 'LL-PYTEXT-JE', 'LL-PYTEXT-JE', 5, 11, 2035.32, 7, 3582.16, 'activo'),
(281, 'Jabalina 1/2\" 1,5m con tomacable', 'P-JM1/2-1,5-GE', 'P-JM1/2-1,5-GE', 9, 1, 7960.27, 8, 12710.75, 'activo'),
(282, 'Jabalina 1/2\" x 1m con tomacable', 'P-JM1/2-1-GE', 'P-JM1/2-1-GE', 9, 1, 5680.20, 8, 9070.01, 'activo'),
(283, 'Jabalina 3/8\" x 1,5m con tomacable', 'P-JM3/8-1.5-GE', 'P-JM3/8-1.5-GE', 9, 1, 5578.91, 8, 8908.26, 'activo'),
(284, 'Jabalina 3/8\" x 1m con tomacable', 'P-JM3/8-1-GE', 'P-JM3/8-1-GE', 9, 2, 3980.13, 8, 6355.36, 'activo'),
(285, 'Taco Tarugo SX 6 Fischer', 'Y-TASX6-FI', 'Y-TASX6-FI', 12, 1428, 25.13, 12, 45.23, 'activo'),
(286, 'Taco Tarugo SX 8 Fischer', 'Y-TASX8-FI', 'Y-TASX8-FI', 12, 396, 48.53, 12, 87.35, 'activo'),
(287, 'Tornillos Tmf Fix 5 X 45mm', 'Y-TOF5X45-SK', 'Y-TOF5X45-SK', 12, 399, 60.22, 12, 108.40, 'activo'),
(289, 'Tornillo Autoperforante T2 Punta Aguja 6x1', 'Y-TOT2A6X1-SK', 'Y-TOT2A6X1-SK', 12, 900, 9.19, 12, 16.54, 'activo'),
(290, 'Reflector Led 30W IP65 Blanco Frío BELLALUX', 'I-RL30WFR-BE', 'I-RL30WFR-BE', 10, 5, 5036.02, 5, 9870.60, 'activo'),
(291, 'Cable Tipo Taller 2x1mm2 Negro FONSECA', 'C-TPR2X1N-FO', 'C-TPR2X1N-FO', 10, 22, 839.96, 2, 1570.72, 'activo'),
(292, 'Fotocontrol Fotocelula Universal Sensor Exterior FC1500E METAPLAST', 'I-FOSEFC1500E-ME', 'I-FOSEFC1500E-ME', 11, 3, 8805.37, 5, 13208.06, 'activo'),
(293, 'Fotocontrol Fotocelula Universal FC1500 METAPLAST', 'I-FOFC1500-ME', 'I-FOFC1500-ME', 11, 4, 7816.02, 5, 11724.03, 'activo'),
(294, 'Reflector Led 10W IP65 Blanco Frío BELLALUX', 'I-RL10WFR-BE', 'I-RL10WFR-BE', 10, 9, 2768.48, 5, 5426.22, 'activo'),
(295, 'Reflector Led 50W IP65 Blanco Frío BELLALUX', 'I-RL50WFR-BE', 'I-RL50WFR-BE', 10, 3, 7425.77, 5, 14554.51, 'activo'),
(296, 'Reflector Led 150W IP65 Blanco Frío BELLALUX', 'I-RL150WFR-BE', 'I-RL150WFR-BE', 10, 5, 17977.57, 5, 35236.04, 'activo'),
(297, 'Tornillo Autoperforante T1 Punta Mecha 8x1/2', 'Y-TOT1M8X1/2-SK', 'Y-TOT1M8X1/2-SK', 12, 890, 12.20, 12, 21.96, 'activo'),
(301, 'Tornillo Autoperforante T1 Punta Mecha 8x3/4', 'Y-TOT1M8X3/4-SK', 'Y-TOT1M8X3/4-SK', 12, 900, 27.38, 12, 49.28, 'activo'),
(302, 'Tornillo Fix 4x50 Para Madera Dorado', 'Y-TOF4X50-SK', 'Y-TOF4X50-SK', 12, 896, 28.91, 12, 52.04, 'activo'),
(303, 'Tornillos Autoperforantes Madera Drywall 6x3/4', 'Y-TOAM6X3/4-SK', 'Y-TOAM6X3/4-SK', 12, 890, 12.17, 12, 21.91, 'activo'),
(304, 'Tornillo Fix 3.5x30mm', 'Y-TOF3,5X30-SK', 'Y-TOF3,5X30-SK', 12, 784, 13.94, 12, 25.09, 'activo'),
(305, 'Tornillo Fix 4x40 Para Madera Dorado', 'Y-TOF4X40-SK', 'Y-TOF4X40-SK', 12, 890, 23.13, 12, 41.63, 'activo'),
(306, 'Tornillos Fix 4.5x35mm', 'Y-TOF4,5X35-SK', 'Y-TOF4,5X35-SK', 12, 844, 17.17, 12, 30.91, 'activo'),
(307, 'Tarugo Fischer SX 10', 'Y-TASX10-FI', 'Y-TASX10-FI', 12, 30, 75.86, 12, 136.55, 'activo'),
(308, 'Tirafondo 1/4 x 2 1/4', 'Y-TTI1/4X2_1/4-SK', 'Y-TTI1/4X2_1/4-SK', 12, 30, 131.57, 12, 236.83, 'activo'),
(309, 'Arandela Plana Zincada de 1/4 - Diam 18.3/7.0 mm', 'Y-ARPL1/4-SK', 'Y-ARPL1/4-SK', 12, 200, 20.77, 12, 37.39, 'activo'),
(310, 'Tornillo Autoperforante Punta Mecha Hexag 14x1 c/ Arandela', 'Y-THPM14X1A-SK', 'Y-THPM14X1A-SK', 12, 90, 91.66, 12, 164.99, 'activo'),
(311, 'Portalampara Comun E27 PVC', 'I-PPE27-', 'I-PPE27-', 5, 2, 985.52, 5, 1773.94, 'activo'),
(312, 'Lampara Led Heladera E14 1,8W Cálido  MACROLED', 'I-LLH1,8E14C-MA', 'I-LLH1,8E14C-MA', 17, 1, 2474.00, 5, 3958.40, 'activo'),
(313, 'Lampara Led Bipin G9 6W Frio MACROLED', 'I-BIG9-6WF-MA', 'I-BIG9-6WF-MA', 17, 5, 3475.00, 5, 5560.00, 'activo'),
(314, 'Lampara Led Bipin G9 6W Cálido MACROLED', 'I-BIG9-6WC-MA', 'I-BIG9-6WC-MA', 17, 5, 3475.00, 5, 5560.00, 'activo'),
(315, 'Tubo de vidrio Led 120cm 18w Frio MACROLED', 'I-TU120-18F-MA', 'I-TU120-18F-MA', 17, 2, 3280.00, 5, 5248.00, 'activo'),
(316, 'Tubo de vidrio Led 60cm 9w Frio MACROLED', 'I-TU60-9F-MA', 'I-TU60-9F-MA', 17, 5, 2232.00, 5, 3571.20, 'activo'),
(317, 'Listón para Tubo de Led T8 60 cm Simple MACROLED', 'I-LITL60-MA', 'I-LITL60-MA', 17, 5, 3150.00, 5, 5040.00, 'activo'),
(318, 'Listón para Tubo de Led T8 120 cm Simple MACROLED', 'I-LITL120-MA', 'I-LITL120-MA', 17, 2, 4360.00, 5, 6976.00, 'activo'),
(319, 'Lampara led Cuerpo corto 28w E27 Fria MACROLED', 'I-FL28F-MA', 'I-FL28F-MA', 17, 3, 4339.15, 5, 6942.64, 'activo'),
(321, 'Lampara led Cuerpo corto 38w E27 Fria MACROLED', 'I-FL38F-MA', 'I-FL38F-MA', 17, 8, 6295.00, 5, 10072.00, 'activo'),
(322, 'Lampara led High Power 40w E27 Fria MACROLED', 'I-FL40F-MA', 'I-FL40F-MA', 17, 0, 7953.00, 5, 12724.80, 'activo'),
(323, 'Cinta Autosoldable  Negra de 2m TACSA', 'X-CAU2NE-TA', 'X-CAU2NE-TA', 9, 5, 2584.48, 11, 3543.24, 'activo'),
(324, 'Ficha Adaptador de 10a 2P EuroAmericana MIG Blanca', 'Y-FAEA10BL-MI', 'Y-FAEA10BL-MI', 11, 4, 2022.20, 12, 3437.74, 'activo'),
(325, 'Ficha Adaptador de 10a 2P Multifuncion  Blanca', 'Y-FAMF10BL-', 'Y-FAMF10BL-', 11, 0, 2001.24, 12, 3402.11, 'activo'),
(326, 'Portalámpara Cerámico E27 con escuadra MACROLED', 'I-PCE27ES-MA', 'I-PCE27ES-MA', 17, 5, 1197.00, 5, 1915.20, 'activo'),
(327, 'Portalámpara Cerámico E27 con puente MACROLED', 'I-PCE27PU-MA', 'I-PCE27PU-MA', 17, 5, 1159.00, 5, 1854.40, 'activo'),
(328, 'Portalámpara PVC E27 con aro Blanco MACROLED', 'I-PE27AR-MA', 'I-PE27AR-MA', 17, 8, 1109.00, 5, 1774.40, 'activo'),
(329, 'Spot para embutir cuadrado Dicroica Blanco MACROLED', 'I-SECBL-MA', 'I-SECBL-MA', 17, 5, 3516.00, 5, 5625.60, 'activo'),
(330, 'Spot para embutir 8 Dicroica Plata MACROLED', 'I-SEPL-MA', 'I-SEPL-MA', 17, 5, 3176.00, 5, 5081.60, 'activo'),
(331, 'Spot para embutir 8 Dicroica Blanco MACROLED', 'I-SEBL-MA', 'I-SEBL-MA', 17, 10, 2319.00, 5, 3710.40, 'activo'),
(332, 'Portalámpara de Porcelana  E40', 'I-PPOE40-', 'I-PPOE40-', 9, 5, 7227.60, 5, 9325.94, 'activo'),
(333, 'Adaptador de rosca Edison E40 a E27 BAW', 'Y-ADE4027-BA', 'I-ADE4027-BA', 11, 2, 3100.00, 12, 4030.00, 'activo'),
(334, 'Ficha Adaptador para perno americano/aleman MF/NG', 'Y-FAEA10BL-', 'Y-FAEA10BL-', 11, 5, 2379.08, 12, 3330.71, 'activo'),
(335, 'Pila AAA 1.5V OM Ultra Power X1 Unidad', 'Y-PIAAA-OM', 'Y-PIAAA-OM', 11, 39, 605.30, 12, 847.42, 'activo'),
(336, 'Pila AAA 1.5V OM Ultra Power X4 Unidades', 'Y-PIAAA-OMX4', 'Y-PIAAA-OMX4', 11, 44, 1936.40, 12, 2904.60, 'activo'),
(337, 'Pila AA 1.5V OM Ultra Power X1 Unidad', 'Y-PIAA-OM', 'Y-PIAA-OM', 11, 31, 847.42, 12, 1186.39, 'activo'),
(338, 'Tapa ciega de PVC mignon para caja de paso 5X5 GENROD', 'D-TCM5X5-GE', 'D-TCM5X5-GE', 9, 5, 317.00, 3, 538.90, 'activo'),
(339, 'Tapa ciega de PVC Rectangular 10x5 GENROD', 'D-TCR10X5-GE', 'D-TCR10X5-GE', 9, 4, 317.00, 3, 538.90, 'activo'),
(340, 'Tapa ciega de PVC Rectangular 10x5', 'D-TCR10X5-', 'D-TCR10X5-', 11, 6, 286.00, 3, 429.00, 'activo'),
(341, 'Modulo Tomacorriente 20a Verona JELUZ', 'LL-MT20CVB-JE', 'LL-MT20CVB-JE', 5, 5, 855.60, 7, 1540.08, 'activo'),
(342, 'Ficha Hembra de 10a Axial Blanca Jeluz', 'Y-FH10AXBL-JE', 'Y-FH10AXBL-JE', 5, 19, 950.73, 12, 1616.24, 'activo'),
(343, 'Ficha Macho de 10a Axial Blanca Jeluz', 'Y-FM10AXBL-JE', 'Y-FM10AXBL-JE', 5, 11, 1039.16, 12, 1662.66, 'activo'),
(344, 'Bornera Divisible 6/10mm Pro x10 unidades TEKOX', 'X-BD610-TE', 'X-BD610-TE', 5, 5, 5380.28, 11, 9953.52, 'activo'),
(345, 'Caja Octogonal de Metal Grande AG', 'D-COMG-AG', 'D-COMG-AG', 9, 10, 1142.71, 3, 1566.62, 'activo'),
(346, 'Caja Cuadrada de Metal 5X5 Mignon AG', 'D-CCM5X5-AG', 'D-CCM5X5-AG', 9, 101, 462.12, 3, 596.29, 'activo'),
(348, 'Puntera tubular preaislada Terminal TIFF x100 de 4mm2 12mm', 'T-PB412-BR', 'T-PB412-BR', 7, 4, 2959.98, 9, 5771.96, 'activo'),
(349, 'Puntera tubular preaislada Terminal TIFF x100 de 2,5mm2 8mm', 'T-PB258-BR', 'T-PB258-BR', 7, 3, 2448.78, 9, 4775.12, 'activo'),
(350, 'Puntera Doble tubular preaislada Terminal TIFF x100 de 4mm2 12mm', 'T-PDB412-BR', 'T-PDB412-BR', 7, 2, 9309.26, 9, 18153.06, 'activo'),
(351, 'Peine de conexión unipolar de 63A 12 polos BRINNA', 'T-P163A12-BR', 'T-P163A12-BR', 7, 4, 3430.35, 9, 6860.70, 'activo'),
(352, 'Protector Peine x5 unidades BRINNA', 'T-PP5U-BR', 'T-PP5U-BR', 7, 9, 2711.61, 1, 5423.22, 'activo'),
(353, 'Conector Para Peine Ingreso Superior 63A BRINNA', 'T-CP63IS-BR', 'T-CP63IS-BR', 7, 21, 1486.48, 9, 2972.96, 'activo'),
(354, 'Mini Voltamperimetro digital 22mm 100CA Verde BRINNA', 'T-VA22CAV-BR', 'T-VA22CAV-BR', 7, 2, 8575.87, 9, 15436.57, 'activo'),
(355, 'Caja de Pase IP65 165x165x80mm BLANCA', 'D-CE165X165X80BL-GE', 'D-CE165X165X80BL-GE', 9, 4, 5368.36, 3, 6926.91, 'activo'),
(356, 'Caja medidor monofásico con reset Blanco GENROD', 'D-CMEDMOBL-GE', 'D-CMEDMOBL-GE', 5, 1, 11330.00, 3, 18128.00, 'activo'),
(357, 'Caja medidor monofásica sin reset Negro CONEXTUBE', 'D-CMEDMONE-CO', 'D-CMEDMONE-CO', 9, 2, 14233.30, 3, 18365.55, 'activo'),
(358, 'Zócalo portalámpara GU10 Dicroica Cerámica 15cm BRINNA', 'I-ZGU1015-BR', 'I-ZGU1015-BR', 6, 20, 590.86, 5, 886.29, 'activo'),
(359, 'Ventilador de techo Retráctil ALMITECH', 'V-VTR-AL', 'V-VTR-AL', 11, 6, 89600.00, 10, 143360.00, 'activo'),
(360, 'Prensacable PG-7 Negro BRINNA', 'X-PPG7-BR', 'X-PPG7-BR', 8, 40, 380.63, 11, 685.13, 'activo'),
(361, 'Preensacable PG-13.5 Negro BRINNA', 'X-PPG13.5-BR', 'X-PPG13.5-BR', 8, 56, 592.54, 11, 948.06, 'activo'),
(362, 'Cinta Aisladora de PVC 19mm x 10m x 0.18mm 18 PLUS Negro TACSA', 'X-CA10NE-TA', 'X-CA10NE-TA', 9, 7, 1705.91, 11, 2201.17, 'activo'),
(363, 'Colocación y conexión de cámara de seguridad tipo Domo.', 'S-CCSWD-', 'S-CCSWD-', 11, 99, 25000.00, 13, 30000.00, 'activo'),
(364, 'Cableado de circuito especial para cámara (Fase+Neutro) por bocas embutidas en cielorraso.', 'S-CACBE-', 'S-CACBE-', 11, 95, 5000.00, 13, 6000.00, 'activo'),
(365, 'Conector de Metal 20mm (3/4) AG', 'K-CM20-AG', 'K-CM20-AG', 5, 134, 342.67, 6, 479.74, 'activo'),
(366, 'Colocación de cajas de paso IP 65, tendido de cable tipo taller exterior con precintos, Colocación y conexión de artefacto de pared direccional.', 'S-CADCIP65TPR-', 'S-CADCIP65TPR-', 11, 96, 0.00, 13, 27500.00, 'activo'),
(367, 'Canalización exterior, cableado y conexión de un toma corriente + llave de 2 puntos exterior.', 'S-CECCTC-', 'S-CECCTC-', 11, 99, 0.00, 13, 30000.00, 'activo'),
(368, 'Cableado de Fase+Neutro 2,5mm de bocas de iluminación en cañerías existentes.', 'S-CCE', 'S-CCE', 11, 97, 0.00, 13, 14400.00, 'activo'),
(369, 'Artefacto de Pared Direccional Iluminación GU10', 'I-ARDIGU10', 'I-ARDIGU10', 11, 96, 12500.00, 5, 16250.00, 'activo'),
(370, 'Reparación de cortocircuito y puesta en funcionamiento de circuitos terminales.', 'S-RCC', 'S-RCC', 11, 99, 0.00, 13, 25000.00, 'activo'),
(371, 'Visita, diagnóstico y presupuesto de servicio de mantenimiento y/o modificación de instalación eléctrica.', 'S-VDP', 'S-VDP', 11, 99, 0.00, 13, 25000.00, 'activo'),
(373, 'Listón para Tubo de Led Doble 120 cm', 'I-LITLD120', 'I-LITLD120', 11, 2, 4560.00, 5, 6840.00, 'activo'),
(374, 'Dicroica Led 7W Neutra BRINNA', 'I-DL7WNE-BR', 'I-DL7WNE-BR', 6, 9, 755.04, 5, 1283.57, 'activo'),
(375, 'Lámpara Led RGB Smart 12W BRINNA', 'I-LLRGB12W-BR', 'I-LLRGB12W-BR', 6, 3, 8593.48, 5, 14608.92, 'activo'),
(376, 'Protector de Tensión Monofásico Brinna SPC-40', 'A-PT2X40SPC-BR', 'A-PT2X40SPC-BR', 7, 2, 8553.63, 1, 14541.17, 'activo'),
(377, 'Bornera de Distribución -Repartidora- Din Bipolar de 11 Polos BRINNA', 'T-BD2X11-BR', 'T-BD2X11-BR', 7, 2, 14834.05, 9, 25217.88, 'activo'),
(378, 'Peine de conexión Bipolar de 63A 16 POLOS BRINNA', 'T-P263A16-BR', 'T-P263A16-BR', 7, 5, 8638.23, 9, 14684.99, 'activo'),
(379, 'Pinza Crimpeadora TIFF hasta 16mm HB-107 BRINNA', 'H-PCHB107-BR', 'H-PCHB107-BR', 8, 1, 38983.10, 4, 66271.27, 'activo'),
(380, 'Destornillador Crique 29 en 1 HB-43 BRINNA', 'H-DCHB43-BR', 'H-DCHB43-BR', 8, 1, 9018.85, 4, 15332.05, 'activo'),
(381, 'Pinza Universal Multifunción BRINNA', 'H-HBCPM-BR', 'H-HBCPM-BR', 8, 1, 10319.35, 4, 17542.90, 'activo'),
(382, 'Bornera de Empalme Rapido PRO 5 Vias ER2-5 BRINNA', 'X-BERPRO5-BR', 'X-BERPRO5-BR', 8, 20, 613.84, 11, 1043.53, 'activo'),
(383, 'Puntera Doble tubular preaislada Terminal TIFF x100 de 2,5mm2 10mm', 'T-PDB2510-BR', 'T-PDB2510-BR', 7, 1, 5720.04, 9, 10296.07, 'activo'),
(384, 'Prensacable PG-9 Negro BRINNA', 'X-PPG9-BR', 'X-PPG9-BR', 5, 48, 412.35, 11, 742.23, 'activo'),
(385, 'Bornera de Distribución -Repartidora- Din Tetrapolar 15 Polos BRINNA', 'T-BD4X15-BR', 'T-BD4X15-BR', 7, 2, 21949.76, 9, 37314.59, 'activo'),
(386, 'Luz de emergencia 30 Leds BAW', 'I-LE30-BA', 'I-LE30-BA', 5, 2, 12013.61, 5, 19221.78, 'activo'),
(387, 'Lampara Led 20W Fria High Power TREFI', 'I-LL20WFR-TR', 'I-LL20WFR-TR', 5, 3, 1760.63, 5, 2993.07, 'activo'),
(388, 'Llave de Tomacorriente de 10a Normalizado Exterior Extrachato JELUZ', 'LL-T10EXT-JE', 'LL-T10EXT-JE', 5, 6, 1033.26, 7, 1653.22, 'activo'),
(389, 'Prensacable PG-11 Negro BRINNA', 'X-PPG11-BR', 'X-PPG11-BR', 8, 38, 444.07, 11, 843.73, 'activo'),
(390, 'Prensacable PG-16 Negro BRINNA', 'X-PPG16-BR', 'X-PPG16-BR', 8, 18, 816.21, 11, 1305.94, 'activo'),
(391, 'Canalización exterior con caño rígido de PVC, cableado reglamentario de circuito especial por caja de paso en altura.', 'S-CEC1CP', 'S-CEC1CP', 11, 99, 30000.00, 13, 30000.00, 'activo'),
(394, 'Canalización exterior, cableado y conexión de Circuito Especial P/Ducha Electrica por 3 Cajas de Paso (15 Mts lineal)', 'S-CECC-CE', 'S-CECC-CE', 11, 100, 25000.00, 13, 35000.00, 'activo'),
(395, 'Instalacion y Conexion de T.Seccional para proteccion de Ducha', 'S-ICTS-CE', 'S-ICTS-CE', 11, 100, 25000.00, 13, 25000.00, 'activo'),
(396, 'Instalación y conexión de reflector, cableado exterior de Cable Tipo Taller con grampas y precintos.', 'S-REFTPR-', 'S-REFTPR-', 11, 100, 0.00, 13, 32000.00, 'activo'),
(397, 'Instalación y conexión de fotocelula exterior para iluminación.', 'S-FOT', 'S-FOT', 11, 100, 0.00, 13, 16000.00, 'activo'),
(398, 'Colocación de caja estanca con tomacorriente para conexión de cámara wifi 220V.', 'S-CCETC10', 'S-CCETC10', 11, 100, 0.00, 13, 25000.00, 'activo'),
(399, 'Reparación de artefacto de oluminación exterior', 'S-RARTETX', 'S-RARTETX', 11, 100, 0.00, 13, 6000.00, 'activo'),
(400, 'LIBRE', 'ASDASD', 'ASDASD', 11, 0, 0.00, 12, 0.00, 'desactivado'),
(401, 'LIBRRE', 'ASDASDAS', 'ADASD', 11, 0, 0.00, 12, 0.00, 'desactivado'),
(402, 'Instalación de Camára Wifi con conexion a tomacorriente 220v y configuración-vinculación a Aplicación de celular.', 'S-IYCCAMWIFI', 'S-IYCCAMWIFI', 11, 100, 0.00, 13, 24000.00, 'activo'),
(403, 'Instalación de Camára Wifi Triple con conexion a tomacorriente 220v, conexión de cableado de alimentación con con tensión y configuración-vinculación a Aplicación de celular.', 'S-IC3C220', 'S-IC3C220', 11, 100, 0.00, 13, 35000.00, 'activo'),
(404, 'Colocación de caja de sobreponer  de 4 módulos - Tablero - y Conexión de interruptor termomagnético para protección de circuito especial ducha eléctrica.', 'S-CTY1TM', 'S-CTY1TM', 11, 100, 0.00, 13, 45000.00, 'activo'),
(405, 'Puntera tubular preaislada Terminal TIFF x Unidad de 2,5mm2 10mm', 'T-PB2510X1-BR', 'T-PB2510X1-BR', 7, 100, 27.44, 9, 63.11, 'activo'),
(406, 'Puntera tubular preaislada Terminal TIFF x Unidad de 6mm2 10mm', 'T-PB6010X1-BR', 'T-PB6010X1-BR', 7, 90, 41.98, 9, 96.55, 'activo'),
(407, 'Receptaculo Comun E27 PVC', 'I-RCPE27-', 'I-RCPE27-', 11, 6, 1850.30, 5, 2960.48, 'activo'),
(408, 'Cable unipolar 1x1mm2 color rojo FONSECA', 'C-U1X1R-FO', 'C-U1X1R-FO', 10, 100, 311.00, 2, 559.80, 'activo'),
(409, 'Cable unipolar 1x1mm2 color negro FONSECA', 'C-U1X1N-FO', 'C-U1X1N-FO', 10, 100, 311.00, 2, 559.80, 'activo'),
(410, 'Aplique Led Exterior Regulable 3000k Cálido Negro LUZ DESIGN', 'I-ALERCA-LU', 'I-ALERCA-LU', 11, 3, 38851.20, 5, 46621.44, 'activo'),
(411, 'Reemplazo de interruptor termomagnético bipolar en Tablero Principal-Pilar con Tensión.', 'S-RITTPCT', 'S-RITTPCT', 11, 100, 0.00, 13, 35000.00, 'activo'),
(412, 'Canalización embutida, cableado reglamentario y conexion de una boca de toma corriente doble.', 'S-CECXB', 'S-CECXB', 11, 100, 0.00, 13, 25000.00, 'activo'),
(413, 'Zapatilla Prolongador 5 Tomas C/interruptor Cable 1.3m SICA', 'Y-ZP5TCI1.3-SI', 'Y-ZP5TCI1.3-SI', 11, 2, 10880.56, 12, 16320.84, 'activo'),
(414, 'Portalampara E27 Chicote Rosca Led Foco STANDART', 'Y-PE27CH-ST', 'Y-PE27CH-ST', 11, 20, 763.90, 12, 1375.02, 'activo'),
(415, 'Llave Conmutadora Manual Bipolar 40a BAW', 'T-LLC40MBI-BA', 'T-LLC40MBI-BA', 11, 1, 25510.03, 12, 39635.00, 'activo'),
(416, 'Pila Cr2032 Ultra Action Litio 3v X Unidad SICA', 'Y-PI3VCR2032-SI', 'Y-PI3VCR2032-SI', 11, 10, 837.80, 12, 1508.04, 'activo'),
(418, 'Caja de Pase IP65 115x165x80mm BLANCA', 'D-CE115X165X80BL-GE', 'D-CE115X165X80BL-GE', 9, 2, 3910.10, 3, 5360.63, 'activo'),
(419, 'Fotocontrol Fotocelula Universal Alumbrado 2400w METAPLAST', 'I-FOSEFC220012-ME', 'I-FOSEFC220012-ME', 11, 1, 20490.00, 5, 30735.00, 'activo'),
(420, 'Fotocontrol Fotocelula Universal Alumbrado 2200W METAPLAST', 'I-FOSEFC220010-ME', 'I-FOSEFC220010-ME', 11, 2, 18300.00, 5, 27450.00, 'activo'),
(421, 'Instalación y conexión de ventilador de techo retráctil. Estandar: Altura menor a 3.5m, cableado existente apto para conexión y cielorraso apto para soporte.', 'S-IVR-EST', 'S-IVR-EST', 11, 2, 0.00, 13, 60000.00, 'activo'),
(422, 'Alquiler - Servicio de Camión Grua elevadora x hora', 'S-HRGR', 'S-HRGR', 11, 0, 0.00, 13, 90000.00, 'activo'),
(423, 'Reemplazo de lampara led GU 10 Dicroica', 'S-REDIC', 'S-REDIC', 11, 5, 0.00, 13, 9000.00, 'activo'),
(424, 'Reemplazo de Artefacto LED de pared en altura.', 'S-REARTPA', 'S-REARTPA', 11, 7, 0.00, 13, 24000.00, 'activo'),
(425, 'Reemplazo de bastidor con un módulo toma/punto', 'S-RELLPOT', 'S-RELLPOT', 11, 10, 0.00, 13, 12000.00, 'activo'),
(426, 'Reemplazo de Artefacto LED de pared .', 'S-REARTP', 'S-REARTP', 11, 2, 0.00, 13, 18000.00, 'activo'),
(427, 'coca3', '12345622', '12345622', 16, 21, 4500.00, 13, 5400.00, 'desactivado');

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
(26, 224, 1, 14),
(27, 199, 1, 15);

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

--
-- Volcado de datos para la tabla `promociones`
--

INSERT INTO `promociones` (`id_promocion`, `nombre`, `precio`, `estado`, `created_at`, `updated_at`) VALUES
(2, 'combo lampara y dicroica', 3045.09, 'inactivo', '2026-07-23 17:08:57', '2026-07-23 17:26:57'),
(3, 'Cable tipo taller 3x1.5mm x metro', 6000.00, 'activo', '2026-07-23 17:09:53', '2026-07-23 18:18:29'),
(4, 'combo lamparas', 10476.15, 'activo', '2026-07-23 17:12:13', '2026-07-23 17:12:13'),
(5, 'combo lampara y dicroica2', 8000.00, 'activo', '2026-07-23 17:12:38', '2026-07-23 17:12:38'),
(6, 'Llave armada de un punto y un toma de 10a para embutir', 1000.00, 'activo', '2026-07-23 18:57:06', '2026-07-28 18:36:05');

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

--
-- Volcado de datos para la tabla `promocion_productos`
--

INSERT INTO `promocion_productos` (`id_promocion_producto`, `id_promocion`, `id_producto`, `cantidad`) VALUES
(8, 4, 39, 1),
(9, 4, 53, 1),
(10, 4, 129, 1),
(11, 4, 130, 1),
(12, 5, 39, 1),
(13, 5, 40, 1),
(14, 5, 41, 3),
(16, 2, 40, 2),
(17, 2, 41, 1),
(18, 3, 129, 1),
(19, 3, 132, 1),
(20, 3, 131, 3),
(26, 6, 211, 1),
(27, 6, 214, 1),
(28, 6, 213, 1),
(29, 6, 212, 1),
(30, 6, 272, 1);

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
(5, 'ADMA JELUZ', '1130824990', 'CABA', 'ventas-online@admadistribuidora.com', 'Lautaro', '1130824990', 'activo'),
(6, 'ADMA-BRINNA ILUMINACION', '1130824990', 'CABA', 'ventas-online@admadistribuidora.com', 'Lautaro', '1130824990', 'activo'),
(7, 'ADMA-BRINNA TABLEROS-COMPONENTES', '1130824990', 'CABA', 'ventas-online@admadistribuidora.com', 'Lautaro', '1130824990', 'activo'),
(8, 'ADMA-BRINNA HERRAMIENTAS', '1130824990', 'CABA', 'ventas-online@admadistribuidora.com', 'Lautaro', '1130824990', 'activo'),
(9, 'NEORED GENROD - SISTELECTRIC', '5555555556', 'Web', 'info@neored.com.ar', 'Auto', '30000', 'activo'),
(10, 'ELECTRICA 631', '1123827674', 'CABA', 'ventas@e631.com.ar', 'Juan', '1123827674', 'activo'),
(11, 'SOLUCIONES ELÉCTRICAS', '3705033180', 'Av. Juan B. Cabral 586', 'solucioneselectricasfsa@gmail.com', 'Francisco Javier Araujo', '3704660816', 'activo'),
(12, 'SKYHARD', '1171823232', 'Av. Larrazabal 1249', 'ventas@skyhard.com.ar', 'Larrazabal', '1171823232', 'activo'),
(13, 'MERCADO LIBRE', '11111111111', 'WEB', 'MELI@GMAIL.COM', 'AAA', '111111111', 'activo'),
(14, 'ADMA VARIOS', '7777777777', 'WEB', 'ventas-online@admadistribuidora.com', 'Lautaro', '77777777777', 'activo'),
(15, 'NEORED- VARIOS', '55555555555', 'WEB', 'info@neored.com.ar', 'ASD', '5555555555', 'activo'),
(16, 'ADMA-BRINNA ACCESORIOS', '1130824990', 'CABA', 'ventas-online@admadistribuidora.com', 'Lautaro', '1130824990', 'activo'),
(17, 'NEORED - ILUMINACION', '555555', 'WEB', 'neored@ilu.com', 'asdasd', '325165', 'activo');

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
('Ctg8jPlQmHRkzEwlPtAVoRVRoQW39Prf8h4vqWpf', 11, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiaXBGOTBPbTNFbm1VOWpXS1k1bzd0ZFkzUGRGbzFMb1lkWkJVSTRSMSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDY6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9wcmVzdXB1ZXN0b3MvaW1wcmltaXIvNjEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxMTt9', 1785598373);

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
(11, 'Admin', 'solucioneselectricasfsa@gmail.com', NULL, '$2y$12$hpNDjfYkMgeTmfpK8bhfCesIBK19cXtlAuUT0/1v8NQXFwE574Hhe', 'LwthQGKPgEVuYHGBs5uAJRv18ZgNC7jZlJRjkr1zJVjN1FunwVa1QUtGBqWj', '2024-11-25 22:48:17', '2024-11-25 22:48:17', 'administrador', 'activo'),
(21, 'Usuario1', 'Usuario1@gmail.com', NULL, '$2y$12$CtT.dnseZDo88yYj4b6d6.JUFJLOFbO3241pgySwfpJAxS0GTp6Ke', 'Q7savN1M4qZjMSivR8Ua0EFiqZz0R1G5vNhFyTFhwrhUzSaXffWghSJDhLFs', '2026-06-13 21:28:16', '2026-06-13 21:28:16', 'empleado', 'activo'),
(22, 'usuario2T', 'usuario2T@gmail.com', NULL, '$2y$12$JWpBJ5zMEiCs4bkoljuXZ.K1PoIFcXj2A0uABGncuMVaLYixVHpOG', NULL, '2026-07-10 19:32:46', '2026-07-10 19:32:46', 'empleado', 'activo');

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

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`id_venta`, `id_usuario`, `fecha_venta`, `monto_total`, `id_metodo_pago`, `descuento`, `id_cliente`, `cliente_nombre`, `cliente_telefono`, `observaciones`) VALUES
(47, 11, '2026-06-13 18:23:53', 9000.00, 2, 0.00, NULL, NULL, NULL, NULL),
(48, 21, '2026-06-13 18:28:55', 4500.00, 1, 0.00, NULL, NULL, NULL, NULL),
(49, 11, '2026-06-16 10:36:42', 12625.84, 1, 3156.46, NULL, NULL, NULL, NULL),
(50, 11, '2026-06-16 16:35:15', 4556.37, 2, 0.00, NULL, NULL, NULL, NULL),
(51, 11, '2026-06-16 19:21:06', 1323162.80, 2, 0.00, NULL, NULL, NULL, NULL),
(52, 11, '2026-06-18 16:44:05', 8612.74, 1, 500.00, NULL, NULL, NULL, NULL),
(53, 11, '2026-06-18 16:45:07', 872.75, 2, 50.00, NULL, NULL, NULL, NULL),
(54, 11, '2026-06-18 17:42:03', 197332.44, 1, 21925.60, NULL, NULL, NULL, NULL),
(55, 11, '2026-06-18 18:12:34', 39333.58, 2, 4370.39, NULL, NULL, NULL, NULL),
(56, 11, '2026-06-18 18:22:56', 65742.00, 2, 3460.10, NULL, NULL, NULL, NULL),
(57, 11, '2026-06-20 11:23:01', 10596.88, 1, 1177.39, NULL, NULL, NULL, NULL),
(58, 11, '2026-06-20 11:53:39', 128311.83, 2, 0.00, NULL, NULL, NULL, NULL),
(59, 11, '2026-06-23 18:18:31', 16751.43, 1, 881.65, NULL, NULL, NULL, NULL),
(60, 11, '2026-06-24 16:21:50', 1579.53, 2, 83.13, NULL, NULL, NULL, NULL),
(61, 11, '2026-06-24 19:21:20', 1690.16, 2, 88.95, NULL, NULL, NULL, NULL),
(62, 11, '2026-06-25 11:25:51', 3828.50, 2, 201.50, NULL, NULL, NULL, NULL),
(63, 11, '2026-06-25 16:54:33', 8364.45, 1, 440.23, NULL, NULL, NULL, NULL),
(64, 11, '2026-06-25 19:46:19', 27301.48, 1, 1436.92, NULL, NULL, NULL, NULL),
(65, 11, '2026-06-26 18:32:01', 50000.00, 1, 0.00, NULL, NULL, NULL, NULL),
(66, 11, '2026-06-29 12:03:59', 7906.85, 4, 0.00, NULL, NULL, NULL, NULL),
(67, 11, '2026-06-29 12:42:22', 931.57, 1, 49.03, NULL, NULL, NULL, NULL),
(68, 11, '2026-06-29 18:13:57', 194543.47, 2, 34331.20, NULL, NULL, NULL, NULL),
(69, 11, '2026-06-30 11:18:21', 5426.00, 2, 0.22, NULL, NULL, NULL, NULL),
(70, 11, '2026-06-30 11:27:43', 20000.00, 1, 1938.46, NULL, NULL, NULL, NULL),
(71, 11, '2026-06-30 17:28:45', 18000.73, 1, 947.40, NULL, NULL, NULL, NULL),
(72, 11, '2026-07-01 08:21:11', 17808.25, 2, 0.00, NULL, NULL, NULL, NULL),
(73, 11, '2026-07-01 09:55:16', 97110.24, 2, 0.00, NULL, NULL, NULL, NULL),
(74, 11, '2026-07-01 11:22:10', 2097.46, 1, 0.00, NULL, NULL, NULL, NULL),
(75, 11, '2026-07-01 12:04:04', 3278.90, 2, 0.00, NULL, NULL, NULL, NULL),
(76, 11, '2026-07-01 12:04:48', 19141.34, 2, 0.00, NULL, NULL, NULL, NULL),
(77, 21, '2026-07-01 17:49:41', 23394.24, 2, 1231.28, NULL, NULL, NULL, NULL),
(78, 21, '2026-07-02 09:37:24', 9870.60, 1, 0.00, NULL, NULL, NULL, NULL),
(79, 21, '2026-07-02 11:05:37', 1694.84, 1, 0.00, NULL, NULL, NULL, NULL),
(80, 11, '2026-07-02 15:50:56', 275378.00, 2, 30597.46, NULL, NULL, NULL, NULL),
(81, 11, '2026-07-02 16:07:51', 35908.18, 2, 1889.90, NULL, NULL, NULL, NULL),
(82, 11, '2026-07-02 18:17:54', 13400.64, 2, 0.00, NULL, NULL, NULL, NULL),
(83, 11, '2026-07-02 18:58:08', 96065.46, 1, 5150.81, NULL, NULL, NULL, NULL),
(84, 11, '2026-07-02 20:28:41', 3702.40, 1, 0.00, NULL, NULL, NULL, NULL),
(85, 21, '2026-07-03 09:58:00', 16684.93, 1, 0.00, NULL, NULL, NULL, NULL),
(86, 21, '2026-07-03 12:05:43', 8269.04, 2, 0.00, NULL, NULL, NULL, NULL),
(87, 11, '2026-07-03 16:40:34', 58852.15, 2, 3097.48, NULL, NULL, NULL, NULL),
(88, 11, '2026-07-03 17:32:45', 32929.70, 2, 1733.14, NULL, NULL, NULL, NULL),
(89, 11, '2026-07-03 17:47:20', 44205.49, 2, 0.00, NULL, NULL, NULL, NULL),
(90, 11, '2026-07-03 17:58:30', 5227.05, 1, 275.11, NULL, NULL, NULL, NULL),
(91, 11, '2026-07-03 18:07:55', 31091.79, 2, 1636.41, NULL, NULL, NULL, NULL),
(92, 11, '2026-07-03 18:35:50', 9165.26, 1, 1018.36, NULL, NULL, NULL, NULL),
(93, 21, '2026-07-06 09:16:04', 19221.78, 1, 0.00, NULL, NULL, NULL, NULL),
(94, 21, '2026-07-06 10:17:36', 8481.71, 1, 0.00, NULL, NULL, NULL, NULL),
(95, 21, '2026-07-06 10:20:42', 5492.00, 2, 0.00, NULL, NULL, NULL, NULL),
(96, 21, '2026-07-06 10:26:49', 17343.18, 2, 0.00, NULL, NULL, NULL, NULL),
(97, 21, '2026-07-06 10:57:50', 10547.91, 2, 0.00, NULL, NULL, NULL, NULL),
(98, 21, '2026-07-06 11:06:57', 5456.00, 2, 0.00, NULL, NULL, NULL, NULL),
(99, 21, '2026-07-06 11:14:17', 5246.04, 1, 0.00, NULL, NULL, NULL, NULL),
(100, 21, '2026-07-06 11:16:53', 5456.00, 2, 0.00, NULL, NULL, NULL, NULL),
(101, 21, '2026-07-06 11:39:19', 38009.36, 5, 0.00, NULL, NULL, NULL, NULL),
(102, 11, '2026-07-06 16:07:54', 20082.39, 2, 1056.96, NULL, NULL, NULL, NULL),
(103, 11, '2026-07-06 16:23:42', 13053.26, 2, 4289.92, NULL, NULL, NULL, NULL),
(104, 21, '2026-07-07 10:24:52', 5188.45, 1, 0.00, NULL, NULL, NULL, NULL),
(105, 21, '2026-07-07 11:11:58', 3330.71, 2, 0.00, NULL, NULL, NULL, NULL),
(106, 21, '2026-07-07 11:27:30', 3437.74, 1, 0.00, NULL, NULL, NULL, NULL),
(107, 21, '2026-07-07 11:32:28', 1283.57, 2, 0.00, NULL, NULL, NULL, NULL),
(108, 11, '2026-07-07 15:48:39', 11512.62, 2, 0.00, NULL, NULL, NULL, NULL),
(109, 11, '2026-07-07 19:02:59', 12835.67, 1, 0.00, NULL, NULL, NULL, NULL),
(110, 21, '2026-07-08 10:13:40', 3216.36, 2, 0.00, NULL, NULL, NULL, NULL),
(111, 21, '2026-07-08 11:09:00', 93566.06, 2, 0.00, NULL, NULL, NULL, NULL),
(112, 21, '2026-07-08 11:24:35', 30000.00, 1, 241.95, NULL, NULL, NULL, NULL),
(113, 11, '2026-07-08 17:06:00', 17060.50, 2, 897.92, NULL, NULL, NULL, NULL),
(114, 11, '2026-07-08 17:14:46', 13137.70, 2, 691.46, NULL, NULL, NULL, NULL),
(115, 11, '2026-07-08 17:50:46', 4174.10, 2, 219.69, NULL, NULL, NULL, NULL),
(116, 11, '2026-07-08 18:52:40', 37474.36, 1, 1972.33, NULL, NULL, NULL, NULL),
(117, 11, '2026-07-08 19:24:03', 8069.49, 1, 0.00, NULL, NULL, NULL, NULL),
(118, 11, '2026-07-08 20:14:20', 113403.40, 2, 0.00, NULL, NULL, NULL, NULL),
(119, 21, '2026-07-09 16:48:39', 14570.75, 2, 766.88, NULL, NULL, NULL, NULL),
(120, 21, '2026-07-09 16:53:00', 38052.60, 2, 2002.77, NULL, NULL, NULL, NULL),
(121, 21, '2026-07-09 17:52:36', 20093.28, 2, 0.00, NULL, NULL, NULL, NULL),
(122, 21, '2026-07-09 19:10:42', 7544.06, 1, 397.06, NULL, NULL, NULL, NULL),
(123, 11, '2026-07-09 19:52:01', 433.70, 1, 5.00, NULL, NULL, NULL, NULL),
(124, 22, '2026-07-10 18:23:43', 19975.67, 2, 1051.35, NULL, NULL, NULL, NULL),
(125, 11, '2026-07-11 10:43:39', 1570.56, 1, 82.66, NULL, NULL, NULL, NULL),
(126, 11, '2026-07-11 10:46:30', 2901.11, 1, 152.69, NULL, NULL, NULL, NULL),
(127, 11, '2026-07-11 10:56:26', 2759.37, 1, 145.23, NULL, NULL, NULL, NULL),
(128, 11, '2026-07-11 11:20:15', 10552.26, 2, 555.38, NULL, NULL, NULL, NULL),
(129, 22, '2026-07-13 15:45:48', 9424.32, 2, 0.00, NULL, NULL, NULL, NULL),
(130, 22, '2026-07-14 19:51:03', 11865.21, 1, 787.91, NULL, NULL, NULL, NULL),
(131, 21, '2026-07-16 12:08:31', 5000.00, 1, 654.95, NULL, NULL, NULL, NULL),
(132, 22, '2026-07-16 16:29:01', 2833.05, 2, 0.00, NULL, NULL, NULL, NULL),
(133, 22, '2026-07-16 17:34:41', 136192.00, 2, 7168.00, NULL, NULL, NULL, NULL),
(134, 22, '2026-07-16 19:16:25', 89487.50, 2, 16000.00, NULL, NULL, NULL, NULL),
(135, 21, '2026-07-17 12:13:19', 70000.00, 2, 604.03, NULL, NULL, NULL, NULL),
(136, 21, '2026-07-17 12:18:56', 5000.00, 1, 698.73, NULL, NULL, NULL, NULL),
(137, 22, '2026-07-17 16:46:41', 73531.14, 2, 3870.06, NULL, NULL, NULL, NULL),
(138, 22, '2026-07-17 18:37:37', 9568.40, 1, 503.60, NULL, NULL, NULL, NULL),
(139, 11, '2026-07-18 10:36:57', 15624.45, 1, 1736.05, NULL, NULL, NULL, NULL),
(140, 11, '2026-07-20 17:00:08', 915.03, 1, 100.00, NULL, 'carlitos bala', '3222212345', 'sdfgasdfgadsg'),
(141, 11, '2026-07-20 19:05:29', 197200.00, 1, 34800.00, NULL, NULL, NULL, NULL),
(142, 11, '2026-07-20 19:20:01', 676268.96, 1, 37372.58, NULL, 'Sebastian Gomez', '3704011751', NULL),
(143, 11, '2026-07-20 19:20:17', 4289.92, 4, 0.00, NULL, NULL, NULL, NULL),
(144, 11, '2026-07-20 19:20:32', 3582.16, 2, 0.00, NULL, 'dsfafdas', '34254325432', 'asdfads'),
(145, 11, '2026-07-20 19:20:48', 1328.87, 2, 0.00, NULL, NULL, NULL, NULL),
(146, 11, '2026-07-23 14:41:38', 8092.33, 1, 500.00, NULL, NULL, NULL, NULL),
(147, 11, '2026-07-23 14:42:41', 9181.21, 1, 0.00, NULL, NULL, NULL, NULL),
(148, 11, '2026-07-23 14:43:40', 8592.33, 1, 0.00, NULL, NULL, NULL, NULL),
(149, 11, '2026-07-23 14:44:08', 8000.02, 1, 0.00, NULL, NULL, NULL, NULL),
(150, 11, '2026-07-23 14:44:45', 8000.02, 1, 0.00, NULL, NULL, NULL, NULL),
(151, 11, '2026-07-23 14:45:01', 8000.02, 1, 0.00, NULL, NULL, NULL, NULL),
(152, 11, '2026-07-23 14:45:25', 8000.02, 1, 0.00, NULL, NULL, NULL, NULL),
(153, 11, '2026-07-23 15:11:13', 15042.09, 1, 0.00, NULL, NULL, NULL, NULL),
(154, 11, '2026-07-23 15:12:13', 2370.17, 4, 0.00, NULL, NULL, NULL, NULL),
(155, 11, '2026-07-23 15:24:00', 18000.00, 1, 0.00, NULL, NULL, NULL, NULL),
(156, 11, '2026-07-23 15:24:55', 7300.70, 1, 0.00, NULL, NULL, NULL, NULL),
(157, 11, '2026-07-23 15:25:28', 7181.19, 1, 0.00, NULL, NULL, NULL, NULL),
(158, 11, '2026-07-23 15:25:58', 13012.03, 1, 0.00, NULL, NULL, NULL, NULL),
(159, 11, '2026-07-23 15:26:52', 13012.03, 2, 0.00, NULL, NULL, NULL, 'en promo: Panel Led Cuadrado Aplicar 12W Frío BRINNA \r\nLámpara Led 9W Cálida BRINNA \r\nLámpara Led 9W Fría BRINNA'),
(160, 11, '2026-07-23 15:57:33', 3475.85, 1, 0.00, NULL, NULL, NULL, NULL),
(161, 11, '2026-07-28 15:33:27', 14362.38, 1, 0.00, NULL, 'Sebastian Gomez', '3704011751', 'sdafdasfdsa'),
(162, 11, '2026-07-28 15:36:37', 1566.61, 1, 0.00, NULL, 'Sebastian Gomez', '3704011751', 'asdasdsadsad'),
(163, 11, '2026-07-28 16:07:49', 6000.00, 1, 0.00, NULL, NULL, NULL, NULL),
(164, 11, '2026-07-28 16:10:21', 64961.92, 2, 0.00, NULL, NULL, NULL, NULL),
(165, 11, '2026-07-31 18:33:29', 19181.19, 1, 0.00, NULL, NULL, NULL, NULL),
(166, 11, '2026-07-31 18:54:54', 24000.00, 1, 0.00, NULL, NULL, NULL, NULL),
(167, 11, '2026-07-31 18:56:41', 24000.00, 1, 0.00, NULL, NULL, NULL, NULL),
(168, 11, '2026-07-31 18:57:37', 6000.00, 1, 723.95, NULL, 'dsadsa', '231424123', NULL),
(169, 11, '2026-07-31 19:11:28', 15000.00, 1, 543.57, NULL, 'el gato', '213213213', 'sdfdasfadsfadsf'),
(170, 11, '2026-07-31 22:17:02', 6000.00, 1, 0.00, NULL, 'dsfdas', 'fdsafadsfdasfdsafdsa', NULL),
(171, 11, '2026-08-01 12:28:10', 10000.00, 1, 30.00, NULL, 'carla', '1111111', 'dsafdasfdass'),
(172, 11, '2026-08-01 12:30:57', 10000.00, 1, 30.00, NULL, NULL, NULL, NULL);

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
(1, 48, 21, 'prueba', '2026-06-13 18:29:07'),
(2, 50, 11, 'Prueba_bernis', '2026-06-16 16:35:52'),
(3, 52, 11, 'prueba', '2026-06-18 16:46:34'),
(4, 53, 11, 'prueba', '2026-06-18 16:46:40'),
(5, 55, 11, 'SE AGREGARON COSAS', '2026-06-18 19:00:44'),
(6, 59, 11, 'prueba', '2026-06-23 18:23:42'),
(7, 96, 21, 'CANCELADO', '2026-07-06 10:29:45'),
(8, 105, 21, 'cambio por otra ficha', '2026-07-07 11:26:16'),
(9, 125, 11, 'Se agregaron productos y se hizo otra compra', '2026-07-11 10:52:27'),
(10, 154, 11, 'PRUEBA', '2026-07-23 15:13:15'),
(11, 153, 11, 'PRUEBA', '2026-07-23 15:14:08'),
(12, 164, 11, 's', '2026-07-28 16:10:31');

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
(1, 47, 39, 2, 4500.00, 0.00),
(2, 48, 39, 1, 4500.00, 0.00),
(3, 49, 45, 10, 1578.23, 0.00),
(4, 50, 39, 1, 4556.37, 0.00),
(5, 51, 110, 3, 29415.24, 0.00),
(6, 51, 108, 1, 74527.10, 0.00),
(7, 51, 111, 1, 22950.67, 0.00),
(8, 51, 112, 3, 5949.20, 0.00),
(9, 51, 113, 6, 2943.56, 0.00),
(10, 51, 109, 3, 12362.86, 0.00),
(11, 51, 137, 1, 34888.83, 0.00),
(12, 51, 96, 10, 7883.26, 0.00),
(13, 51, 101, 4, 7883.26, 0.00),
(14, 51, 99, 4, 8978.76, 0.00),
(15, 51, 105, 1, 7883.26, 0.00),
(16, 51, 115, 1, 4939.70, 0.00),
(17, 51, 116, 1, 4967.96, 0.00),
(18, 51, 117, 1, 7556.56, 0.00),
(19, 51, 118, 1, 19225.74, 0.00),
(20, 51, 136, 1, 10108.10, 0.00),
(21, 51, 120, 1, 16334.03, 0.00),
(22, 51, 119, 1, 3650.51, 0.00),
(23, 51, 121, 75, 491.81, 0.00),
(24, 51, 122, 25, 388.67, 0.00),
(25, 51, 124, 10, 787.50, 0.00),
(26, 51, 123, 10, 1644.03, 0.00),
(27, 51, 125, 15, 559.02, 0.00),
(28, 51, 126, 20, 559.02, 0.00),
(29, 51, 127, 15, 506.06, 0.00),
(30, 51, 128, 20, 604.00, 0.00),
(31, 51, 129, 100, 1073.81, 0.00),
(32, 51, 131, 200, 1073.81, 0.00),
(33, 51, 130, 100, 1073.81, 0.00),
(34, 51, 132, 100, 658.14, 0.00),
(35, 51, 133, 100, 658.14, 0.00),
(36, 51, 134, 15, 4590.00, 0.00),
(37, 51, 135, 15, 4590.00, 0.00),
(38, 52, 39, 2, 4556.37, 2847.73),
(39, 53, 40, 1, 922.75, 595.32),
(40, 54, 227, 4, 39058.51, 37920.88),
(41, 54, 228, 4, 15756.00, 15600.00),
(42, 55, 79, 1, 8470.96, 5294.35),
(43, 55, 74, 1, 5233.01, 3270.63),
(44, 55, 229, 2, 15000.00, 0.00),
(45, 56, 79, 1, 8470.96, 5294.35),
(46, 56, 74, 2, 5233.01, 3270.63),
(47, 56, 193, 8, 658.14, 411.34),
(48, 56, 229, 3, 15000.00, 0.00),
(49, 57, 162, 1, 11774.27, 6541.26),
(50, 58, 291, 30, 1427.93, 839.96),
(51, 58, 290, 2, 9064.84, 5036.02),
(52, 58, 197, 6, 2585.81, 1616.13),
(53, 58, 198, 6, 2585.81, 1616.13),
(54, 58, 293, 1, 11724.03, 7816.02),
(55, 58, 121, 50, 491.81, 327.87),
(56, 59, 60, 2, 8816.54, 5009.40),
(57, 60, 343, 1, 1662.66, 1039.16),
(58, 61, 242, 1, 378.53, 191.18),
(59, 61, 238, 1, 1400.58, 748.97),
(60, 62, 333, 1, 4030.00, 3100.00),
(61, 63, 362, 4, 2201.17, 1375.73),
(62, 64, 50, 4, 6102.50, 3579.18),
(63, 64, 55, 1, 4328.40, 2459.32),
(64, 65, 371, 1, 25000.00, 0.00),
(65, 65, 370, 1, 25000.00, 0.00),
(66, 66, 321, 1, 7906.85, 4941.78),
(67, 67, 225, 1, 474.65, 287.67),
(68, 67, 218, 1, 505.95, 287.47),
(69, 68, 98, 2, 8671.59, 4379.59),
(70, 68, 96, 2, 8671.59, 4379.59),
(71, 68, 203, 4, 2494.69, 1417.44),
(72, 68, 209, 4, 287.38, 163.28),
(73, 68, 127, 5, 556.67, 337.37),
(74, 68, 268, 5, 1853.39, 1053.06),
(75, 68, 306, 20, 30.91, 17.17),
(76, 68, 285, 20, 45.23, 25.13),
(77, 68, 129, 50, 1181.19, 671.13),
(78, 68, 194, 25, 1181.19, 671.13),
(79, 68, 130, 25, 1181.19, 671.13),
(80, 68, 236, 10, 2003.79, 1071.55),
(81, 68, 248, 1, 3551.03, 1793.45),
(82, 68, 124, 1, 866.25, 525.00),
(83, 68, 213, 20, 1048.73, 702.26),
(84, 68, 211, 5, 566.61, 343.40),
(85, 68, 214, 5, 621.02, 376.37),
(86, 69, 294, 1, 5426.22, 2768.48),
(87, 70, 322, 2, 10969.23, 6855.77),
(88, 71, 387, 1, 2993.07, 1760.63),
(89, 71, 43, 1, 1346.14, 789.52),
(90, 71, 375, 1, 14608.92, 8593.48),
(91, 72, 225, 15, 474.65, 287.67),
(92, 72, 122, 25, 427.54, 259.11),
(93, 73, 211, 32, 566.61, 343.40),
(94, 73, 214, 32, 621.02, 376.37),
(95, 73, 213, 38, 1048.73, 702.26),
(96, 73, 212, 40, 109.45, 79.67),
(97, 73, 278, 3, 1945.34, 1296.89),
(98, 73, 272, 8, 1130.04, 642.07),
(99, 74, 213, 2, 1048.73, 702.26),
(100, 75, 342, 1, 1616.24, 950.73),
(101, 75, 343, 1, 1662.66, 1039.16),
(102, 76, 176, 1, 19141.34, 10634.08),
(103, 77, 290, 1, 9870.60, 5036.02),
(104, 77, 66, 1, 5456.03, 3100.02),
(105, 77, 68, 1, 9298.89, 5283.46),
(106, 78, 290, 1, 9870.60, 5036.02),
(107, 79, 335, 2, 847.42, 605.30),
(108, 80, 366, 4, 27500.00, 0.00),
(109, 80, 367, 1, 30000.00, 0.00),
(110, 80, 368, 3, 14400.00, 0.00),
(111, 80, 369, 4, 16250.00, 12500.00),
(112, 80, 217, 4, 2661.07, 1423.03),
(113, 80, 291, 15, 1570.72, 839.96),
(114, 80, 360, 10, 723.20, 380.63),
(115, 80, 268, 1, 1853.39, 1053.06),
(116, 80, 269, 1, 647.30, 367.78),
(117, 80, 267, 2, 289.89, 164.71),
(118, 80, 270, 3, 292.42, 166.15),
(119, 80, 236, 1, 2003.79, 1071.55),
(120, 80, 211, 1, 566.61, 343.40),
(121, 80, 214, 1, 621.02, 376.37),
(122, 80, 213, 1, 1048.73, 702.26),
(123, 80, 212, 1, 109.45, 79.67),
(124, 80, 273, 1, 2715.57, 1542.94),
(125, 80, 49, 4, 1328.87, 755.04),
(126, 81, 130, 16, 1181.19, 671.13),
(127, 81, 129, 16, 1181.19, 671.13),
(128, 82, 290, 1, 9870.60, 5036.02),
(129, 82, 48, 1, 1328.87, 755.04),
(130, 82, 362, 1, 2201.17, 1375.73),
(131, 83, 129, 4, 1181.19, 671.13),
(132, 83, 130, 4, 1181.19, 671.13),
(133, 83, 268, 1, 1853.39, 1053.06),
(134, 83, 269, 3, 647.30, 367.78),
(135, 83, 270, 5, 292.42, 166.15),
(136, 83, 213, 3, 1048.73, 702.26),
(137, 83, 98, 1, 8671.59, 4379.59),
(138, 83, 104, 1, 8671.59, 4379.59),
(139, 83, 64, 4, 4590.34, 2608.15),
(140, 83, 267, 1, 289.89, 164.71),
(141, 83, 110, 1, 32356.76, 16808.71),
(142, 83, 132, 20, 723.95, 411.34),
(143, 83, 306, 7, 30.91, 17.17),
(144, 83, 285, 7, 45.23, 25.13),
(145, 84, 312, 1, 3702.40, 2314.00),
(146, 85, 315, 1, 3771.74, 2357.34),
(147, 85, 325, 3, 3402.11, 2001.24),
(148, 85, 247, 1, 2706.86, 1367.10),
(149, 86, 41, 1, 1015.03, 595.32),
(150, 86, 342, 1, 1616.24, 950.73),
(151, 86, 343, 1, 1662.66, 1039.16),
(152, 86, 311, 1, 1773.94, 985.52),
(153, 86, 362, 1, 2201.17, 1375.73),
(154, 87, 195, 10, 1878.48, 1067.31),
(155, 87, 186, 2, 1021.38, 515.85),
(156, 87, 196, 10, 1878.47, 1067.31),
(157, 87, 237, 1, 2242.15, 1199.01),
(158, 87, 109, 1, 12653.88, 7443.46),
(159, 87, 113, 2, 3237.92, 1635.31),
(160, 87, 406, 10, 96.55, 41.98),
(161, 88, 319, 1, 5553.82, 3471.14),
(162, 88, 295, 2, 14554.51, 7425.77),
(163, 89, 121, 25, 540.99, 327.87),
(164, 89, 122, 25, 427.54, 259.11),
(165, 89, 249, 1, 10612.80, 5360.00),
(166, 89, 362, 4, 2201.17, 1375.73),
(167, 89, 209, 2, 287.38, 163.28),
(168, 90, 45, 2, 1736.05, 1018.21),
(169, 90, 41, 2, 1015.03, 595.32),
(170, 91, 211, 6, 566.61, 343.40),
(171, 91, 214, 6, 621.02, 376.37),
(172, 91, 277, 2, 5456.00, 3100.00),
(173, 91, 213, 2, 1048.73, 702.26),
(174, 91, 272, 2, 1130.04, 642.07),
(175, 91, 236, 2, 2003.79, 1071.55),
(176, 91, 238, 2, 1400.58, 748.97),
(177, 91, 278, 1, 1945.34, 1296.89),
(178, 91, 304, 10, 25.09, 13.94),
(179, 91, 285, 10, 45.23, 25.13),
(180, 91, 212, 8, 109.45, 79.67),
(181, 92, 211, 3, 566.61, 343.40),
(182, 92, 214, 3, 621.02, 376.37),
(183, 92, 213, 6, 1048.73, 702.26),
(184, 92, 212, 3, 109.45, 79.67),
(185, 93, 386, 1, 19221.78, 12013.61),
(186, 94, 129, 2, 1181.19, 671.13),
(187, 94, 130, 2, 1181.19, 671.13),
(188, 94, 195, 1, 1878.48, 1067.31),
(189, 94, 196, 1, 1878.47, 1067.31),
(190, 95, 211, 1, 566.61, 343.40),
(191, 95, 214, 1, 621.02, 376.37),
(192, 95, 213, 4, 1048.73, 702.26),
(193, 95, 212, 1, 109.45, 79.67),
(194, 96, 96, 1, 8671.59, 4379.59),
(195, 96, 98, 1, 8671.59, 4379.59),
(196, 97, 86, 1, 10547.91, 5993.13),
(197, 98, 277, 1, 5456.00, 3100.00),
(198, 99, 45, 2, 1736.05, 1018.21),
(199, 99, 311, 1, 1773.94, 985.52),
(200, 100, 277, 1, 5456.00, 3100.00),
(201, 101, 211, 7, 566.61, 343.40),
(202, 101, 214, 7, 621.02, 376.37),
(203, 101, 213, 2, 1048.73, 702.26),
(204, 101, 70, 1, 3219.95, 1829.52),
(205, 101, 388, 3, 1653.22, 1033.26),
(206, 101, 212, 2, 109.45, 79.67),
(207, 101, 272, 2, 1130.04, 642.07),
(208, 101, 279, 5, 3387.98, 1924.99),
(209, 102, 197, 1, 2844.39, 1616.13),
(210, 102, 198, 1, 2844.39, 1616.13),
(211, 102, 91, 1, 4289.92, 2265.12),
(212, 102, 178, 1, 9465.81, 4780.71),
(213, 102, 335, 2, 847.42, 605.30),
(214, 103, 104, 2, 8671.59, 4379.59),
(215, 104, 286, 4, 87.35, 48.53),
(216, 104, 302, 4, 52.04, 28.91),
(217, 104, 280, 1, 3582.16, 2035.32),
(218, 104, 213, 1, 1048.73, 702.26),
(219, 105, 334, 1, 3330.71, 2379.08),
(220, 106, 324, 1, 3437.74, 2022.20),
(221, 107, 374, 1, 1283.57, 755.04),
(222, 108, 74, 2, 5756.31, 3270.63),
(223, 109, 189, 1, 12835.67, 8334.85),
(224, 110, 226, 1, 3216.36, 1624.42),
(225, 111, 268, 5, 1853.39, 1053.06),
(226, 111, 267, 15, 289.89, 164.71),
(227, 111, 269, 5, 647.30, 367.78),
(228, 111, 218, 4, 505.95, 287.47),
(229, 111, 222, 4, 938.41, 625.61),
(230, 111, 211, 2, 566.61, 343.40),
(231, 111, 214, 2, 621.02, 376.37),
(232, 111, 272, 1, 1130.04, 642.07),
(233, 111, 212, 2, 109.45, 79.67),
(234, 111, 213, 3, 1048.73, 702.26),
(235, 111, 362, 1, 2201.17, 1375.73),
(236, 111, 195, 10, 1878.48, 1067.31),
(237, 111, 196, 10, 1878.47, 1067.31),
(238, 111, 102, 1, 8671.59, 4379.59),
(239, 111, 236, 2, 2003.79, 1071.55),
(240, 111, 255, 1, 11616.59, 6600.34),
(241, 112, 315, 3, 3771.74, 2357.34),
(242, 112, 318, 3, 6308.91, 3943.07),
(243, 113, 387, 6, 2993.07, 1760.63),
(244, 114, 249, 1, 10612.80, 5360.00),
(245, 114, 226, 1, 3216.36, 1624.42),
(246, 115, 48, 2, 1328.87, 755.04),
(247, 115, 45, 1, 1736.05, 1018.21),
(248, 116, 418, 2, 5360.63, 3153.31),
(249, 116, 234, 2, 4035.59, 2158.07),
(250, 116, 217, 1, 2661.07, 1423.03),
(251, 116, 245, 1, 12579.46, 7147.42),
(252, 116, 247, 2, 2706.86, 1367.10),
(253, 117, 177, 1, 8069.49, 4483.05),
(254, 118, 363, 1, 30000.00, 25000.00),
(255, 118, 364, 5, 6000.00, 5000.00),
(256, 118, 291, 15, 1570.72, 839.96),
(257, 118, 49, 5, 1328.87, 755.04),
(258, 118, 418, 1, 5360.63, 3153.31),
(259, 118, 360, 1, 685.13, 380.63),
(260, 118, 384, 2, 742.23, 412.35),
(261, 118, 389, 1, 843.73, 444.07),
(262, 118, 292, 1, 13208.06, 8805.37),
(263, 118, 342, 1, 1616.24, 950.73),
(264, 119, 204, 1, 2617.82, 1487.40),
(265, 119, 206, 3, 829.77, 471.46),
(266, 119, 208, 5, 353.65, 200.94),
(267, 119, 267, 1, 289.89, 164.71),
(268, 119, 235, 2, 2913.78, 1558.17),
(269, 119, 285, 9, 45.23, 25.13),
(270, 119, 306, 9, 30.91, 17.17),
(271, 119, 202, 2, 829.77, 471.46),
(272, 120, 164, 1, 14399.95, 7272.70),
(273, 120, 166, 1, 12703.72, 6416.02),
(274, 120, 162, 1, 12951.70, 6541.26),
(275, 121, 319, 2, 5553.82, 3471.14),
(276, 121, 220, 1, 8985.64, 6807.30),
(277, 122, 129, 2, 1181.19, 671.13),
(278, 122, 130, 2, 1181.19, 671.13),
(279, 122, 226, 1, 3216.36, 1624.42),
(280, 123, 303, 10, 21.91, 12.17),
(281, 123, 297, 10, 21.96, 12.20),
(282, 124, 375, 1, 14608.92, 8593.48),
(283, 124, 277, 1, 4650.00, 3100.00),
(284, 124, 187, 2, 884.05, 446.49),
(285, 125, 388, 1, 1653.22, 1033.26),
(286, 126, 238, 1, 1400.58, 748.97),
(287, 126, 388, 1, 1653.22, 1033.26),
(288, 127, 336, 1, 2904.60, 1936.40),
(289, 128, 319, 2, 5553.82, 3471.14),
(290, 129, 291, 6, 1570.72, 839.96),
(291, 130, 214, 5, 621.02, 376.37),
(292, 130, 213, 9, 1048.73, 702.26),
(293, 130, 212, 1, 109.45, 79.67),
(294, 131, 45, 2, 1736.05, 1018.21),
(295, 131, 211, 1, 566.61, 343.40),
(296, 131, 342, 1, 1616.24, 950.73),
(297, 132, 211, 5, 566.61, 343.40),
(298, 133, 359, 1, 143360.00, 89600.00),
(299, 134, 391, 1, 30000.00, 30000.00),
(300, 134, 421, 1, 60000.00, 0.00),
(301, 134, 193, 4, 723.95, 411.34),
(302, 134, 133, 4, 723.95, 411.34),
(303, 134, 270, 4, 292.42, 206.03),
(304, 134, 269, 1, 647.30, 456.05),
(305, 134, 267, 2, 289.89, 204.24),
(306, 134, 217, 2, 2539.80, 1494.00),
(307, 134, 305, 10, 41.63, 23.13),
(308, 134, 335, 2, 847.42, 605.30),
(309, 134, 287, 1, 108.40, 60.22),
(310, 135, 197, 8, 2844.39, 1616.13),
(311, 135, 198, 9, 2844.39, 1616.13),
(312, 135, 101, 1, 8671.59, 4379.59),
(313, 135, 96, 1, 8671.59, 4379.59),
(314, 135, 304, 6, 25.09, 13.94),
(315, 135, 285, 6, 45.23, 25.13),
(316, 135, 237, 2, 2242.15, 1486.77),
(317, 136, 213, 1, 1048.73, 702.26),
(318, 136, 277, 1, 4650.00, 3100.00),
(319, 137, 74, 3, 5756.31, 3270.63),
(320, 137, 73, 2, 5756.31, 3270.63),
(321, 137, 71, 1, 4730.90, 2688.01),
(322, 137, 214, 4, 621.02, 376.37),
(323, 137, 211, 4, 566.61, 343.40),
(324, 137, 279, 2, 3387.98, 1924.99),
(325, 137, 213, 2, 1048.73, 702.26),
(326, 137, 272, 3, 1130.04, 642.07),
(327, 137, 212, 1, 109.45, 79.67),
(328, 137, 291, 2, 1570.72, 839.96),
(329, 137, 129, 10, 1181.19, 671.13),
(330, 137, 130, 10, 1181.19, 671.13),
(331, 138, 321, 1, 10072.00, 6295.00),
(332, 139, 45, 10, 1736.05, 1018.21),
(333, 140, 40, 1, 1015.03, 595.32),
(334, 141, 422, 1, 90000.00, 0.00),
(335, 141, 424, 3, 24000.00, 0.00),
(336, 141, 423, 5, 14000.00, 0.00),
(337, 142, 258, 1, 32322.64, 22772.77),
(338, 142, 281, 1, 12710.75, 7960.27),
(339, 142, 119, 1, 4015.56, 2028.06),
(340, 142, 110, 1, 32356.76, 16808.71),
(341, 142, 96, 1, 8671.59, 4379.59),
(342, 142, 102, 1, 8671.59, 4379.59),
(343, 142, 236, 9, 2003.79, 1125.00),
(344, 142, 211, 9, 566.61, 343.40),
(345, 142, 214, 9, 621.02, 376.37),
(346, 142, 213, 13, 1048.73, 702.26),
(347, 142, 272, 3, 1130.04, 642.07),
(348, 142, 212, 11, 109.45, 79.67),
(349, 142, 311, 2, 1773.94, 985.52),
(350, 142, 218, 11, 505.95, 302.00),
(351, 142, 121, 100, 540.99, 406.56),
(352, 142, 127, 50, 556.67, 418.34),
(353, 142, 133, 40, 723.95, 411.34),
(354, 142, 132, 8, 723.95, 411.34),
(355, 142, 129, 80, 1181.19, 671.13),
(356, 142, 130, 80, 1181.19, 671.13),
(357, 142, 131, 80, 1181.19, 671.13),
(358, 142, 196, 40, 1878.47, 1067.31),
(359, 142, 195, 40, 1878.48, 1067.31),
(360, 142, 112, 1, 6544.12, 3305.11),
(361, 142, 306, 20, 30.91, 17.17),
(362, 142, 285, 20, 45.23, 25.13),
(363, 142, 207, 1, 316.36, 222.89),
(364, 143, 88, 1, 4289.92, 2265.12),
(365, 144, 280, 1, 3582.16, 2035.32),
(366, 145, 48, 1, 1328.87, 755.04),
(367, 146, 39, 1, 5012.01, 2847.73),
(368, 146, 40, 1, 895.08, 595.32),
(369, 146, 41, 3, 895.08, 595.32),
(370, 147, 39, 1, 4419.70, 2847.73),
(371, 147, 40, 1, 895.08, 595.32),
(372, 147, 41, 3, 895.08, 595.32),
(373, 147, 129, 1, 1181.19, 671.13),
(374, 148, 39, 1, 5012.01, 2847.73),
(375, 148, 40, 1, 895.08, 595.32),
(376, 148, 41, 3, 895.08, 595.32),
(377, 149, 39, 1, 4419.70, 2847.73),
(378, 149, 40, 1, 895.08, 595.32),
(379, 149, 41, 3, 895.08, 595.32),
(380, 150, 39, 1, 4419.70, 2847.73),
(381, 150, 40, 1, 895.08, 595.32),
(382, 150, 41, 3, 895.08, 595.32),
(383, 151, 39, 1, 4419.70, 2847.73),
(384, 151, 40, 1, 895.08, 595.32),
(385, 151, 41, 3, 895.08, 595.32),
(386, 152, 39, 1, 4419.70, 2847.73),
(387, 152, 40, 1, 895.08, 595.32),
(388, 152, 41, 3, 895.08, 595.32),
(389, 153, 39, 1, 4419.70, 2847.73),
(390, 153, 40, 1, 895.08, 595.32),
(391, 153, 41, 3, 895.08, 595.32),
(392, 153, 39, 1, 5012.01, 2847.73),
(393, 153, 40, 1, 1015.03, 595.32),
(394, 153, 41, 1, 1015.03, 595.32),
(395, 154, 40, 1, 1015.03, 595.32),
(396, 154, 42, 1, 1355.14, 789.52),
(397, 155, 129, 3, 1300.70, 671.13),
(398, 155, 132, 3, 797.20, 411.34),
(399, 155, 131, 9, 1300.70, 671.13),
(400, 156, 129, 2, 1300.70, 671.13),
(401, 156, 132, 1, 797.20, 411.34),
(402, 156, 131, 3, 1300.70, 671.13),
(403, 157, 129, 1, 1300.70, 671.13),
(404, 157, 132, 1, 797.20, 411.34),
(405, 157, 131, 3, 1300.70, 671.13),
(406, 157, 129, 1, 1181.19, 671.13),
(407, 158, 39, 1, 4419.70, 2847.73),
(408, 158, 40, 1, 895.08, 595.32),
(409, 158, 41, 3, 895.08, 595.32),
(410, 158, 39, 1, 5012.01, 2847.73),
(411, 159, 39, 1, 4419.70, 2847.73),
(412, 159, 40, 1, 895.08, 595.32),
(413, 159, 41, 3, 895.08, 595.32),
(414, 159, 39, 1, 5012.01, 2847.73),
(415, 160, 211, 1, 566.61, 343.40),
(416, 160, 214, 1, 621.02, 376.37),
(417, 160, 213, 1, 1048.73, 702.26),
(418, 160, 212, 1, 109.45, 79.67),
(419, 160, 272, 1, 1130.04, 642.07),
(420, 161, 129, 1, 1181.19, 671.13),
(421, 161, 131, 1, 1181.19, 671.13),
(422, 161, 129, 2, 1300.70, 671.13),
(423, 161, 132, 2, 797.20, 411.34),
(424, 161, 131, 6, 1300.70, 671.13),
(425, 162, 211, 1, 566.61, 343.40),
(426, 162, 211, 1, 163.01, 343.40),
(427, 162, 214, 1, 178.67, 376.37),
(428, 162, 213, 1, 301.72, 702.26),
(429, 162, 212, 1, 31.49, 79.67),
(430, 162, 272, 1, 325.11, 642.07),
(431, 163, 129, 1, 1300.70, 671.13),
(432, 163, 132, 1, 797.20, 411.34),
(433, 163, 131, 3, 1300.70, 671.13),
(434, 164, 40, 64, 1015.03, 595.32),
(435, 165, 129, 1, 1181.19, 671.13),
(436, 165, 129, 3, 1300.70, 671.13),
(437, 165, 132, 3, 797.20, 411.34),
(438, 165, 131, 9, 1300.70, 671.13),
(439, 166, 129, 4, 1300.70, 671.13),
(440, 166, 132, 4, 797.20, 411.34),
(441, 166, 131, 12, 1300.70, 671.13),
(442, 167, 129, 4, 1300.70, 671.13),
(443, 167, 132, 4, 797.20, 411.34),
(444, 167, 131, 12, 1300.70, 671.13),
(445, 168, 132, 1, 723.95, 411.34),
(446, 168, 129, 1, 1300.70, 671.13),
(447, 168, 132, 1, 797.20, 411.34),
(448, 168, 131, 3, 1300.70, 671.13),
(449, 169, 131, 3, 1181.19, 671.13),
(450, 169, 129, 2, 1300.70, 671.13),
(451, 169, 132, 2, 797.20, 411.34),
(452, 169, 131, 6, 1300.70, 671.13),
(453, 170, 129, 1, 1300.70, 671.13),
(454, 170, 132, 1, 797.20, 411.34),
(455, 170, 131, 3, 1300.70, 671.13),
(456, 171, 333, 1, 4030.00, 3100.00),
(457, 171, 129, 1, 1300.70, 671.13),
(458, 171, 132, 1, 797.20, 411.34),
(459, 171, 131, 3, 1300.70, 671.13),
(460, 172, 333, 1, 4030.00, 3100.00),
(461, 172, 129, 1, 1300.70, 671.13),
(462, 172, 132, 1, 797.20, 411.34),
(463, 172, 131, 3, 1300.70, 671.13);

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
  MODIFY `id_cliente` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `compras`
--
ALTER TABLE `compras`
  MODIFY `id_compra` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

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
-- AUTO_INCREMENT de la tabla `presupuestos`
--
ALTER TABLE `presupuestos`
  MODIFY `id_presupuesto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

--
-- AUTO_INCREMENT de la tabla `presupuestos_productos`
--
ALTER TABLE `presupuestos_productos`
  MODIFY `id_presupuesto_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=675;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id_producto` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=428;

--
-- AUTO_INCREMENT de la tabla `productosxcompras`
--
ALTER TABLE `productosxcompras`
  MODIFY `id_pxc` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT de la tabla `promociones`
--
ALTER TABLE `promociones`
  MODIFY `id_promocion` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `promocion_productos`
--
ALTER TABLE `promocion_productos`
  MODIFY `id_promocion_producto` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  MODIFY `id_proveedor` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `id_venta` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=173;

--
-- AUTO_INCREMENT de la tabla `ventas_anuladas`
--
ALTER TABLE `ventas_anuladas`
  MODIFY `id_venta_anulada` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `ventas_productos`
--
ALTER TABLE `ventas_productos`
  MODIFY `id_venta_producto` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=464;

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
