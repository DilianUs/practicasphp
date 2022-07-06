-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 18-01-2021 a las 06:42:38
-- Versión del servidor: 10.4.17-MariaDB
-- Versión de PHP: 8.0.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `inventario`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `ExistenciaBaja` (IN `cantidad` INT)  NO SQL
    DETERMINISTIC
SELECT * FROM productos	WHERE productos.cantidad <= cantidad$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `noticias`
--

CREATE TABLE `noticias` (
  `id_noticia` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `texto` varchar(500) NOT NULL,
  `fecha` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `noticias`
--

INSERT INTO `noticias` (`id_noticia`, `id_usuario`, `texto`, `fecha`) VALUES
(1, 1, 'Esto es un texto de demostración', '2021-01-17'),
(2, 2, '<b>Texto en negritas</b>\r\n<img src=\"https://mk0duplos1wcakrj62gl.kinstacdn.com/wp-content/uploads/2021/01/WandaVision-696x392.jpg\" width=\"348\" height=\"196\">', '0000-00-00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ordenes`
--

CREATE TABLE `ordenes` (
  `id_orden` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha` int(11) NOT NULL DEFAULT current_timestamp(),
  `total` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `ordenes`
--

INSERT INTO `ordenes` (`id_orden`, `id_usuario`, `fecha`, `total`) VALUES
(1, 2, 20210117, 20),
(2, 2, 20210117, 15);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ordenes_detalles`
--

CREATE TABLE `ordenes_detalles` (
  `id_orden` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `ordenes_detalles`
--

INSERT INTO `ordenes_detalles` (`id_orden`, `id_producto`, `cantidad`) VALUES
(1, 2, 5),
(1, 3, 3),
(2, 2, 2),
(2, 3, 5);

--
-- Disparadores `ordenes_detalles`
--
DELIMITER $$
CREATE TRIGGER `actualizarInventario` AFTER INSERT ON `ordenes_detalles` FOR EACH ROW BEGIN
UPDATE productos
SET productos.cantidad = productos.cantidad - NEW.cantidad WHERE productos.id_producto = NEW.id_producto;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id_producto` int(11) NOT NULL,
  `descripcion` varchar(50) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id_producto`, `descripcion`, `cantidad`, `precio`) VALUES
(2, 'Salsa verde', 10, 4.8),
(3, 'Salsa roja', 10, 5.1);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `reporte`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `reporte` (
`orden` int(11)
,`fecha` int(11)
,`nombre` varchar(100)
,`producto` varchar(50)
,`cantidad` int(11)
,`precio` float
,`subtotal` double
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `usuario` varchar(10) NOT NULL,
  `contrasena` varchar(10) NOT NULL,
  `nombre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `usuario`, `contrasena`, `nombre`) VALUES
(1, 'admin', 'admin', 'Administrador demo'),
(2, 'usuario', 'usuario', 'Un usuario'),
(5, 'tienda', 'tienda', '<h1><i>Victor</i></h1>');

-- --------------------------------------------------------

--
-- Estructura para la vista `reporte`
--
DROP TABLE IF EXISTS `reporte`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `reporte`  AS SELECT `ordenes`.`id_orden` AS `orden`, `ordenes`.`fecha` AS `fecha`, `usuarios`.`nombre` AS `nombre`, `productos`.`descripcion` AS `producto`, `ordenes_detalles`.`cantidad` AS `cantidad`, `productos`.`precio` AS `precio`, `ordenes_detalles`.`cantidad`* `productos`.`precio` AS `subtotal` FROM (((`ordenes` join `ordenes_detalles`) join `productos`) join `usuarios`) WHERE `ordenes`.`id_usuario` = `usuarios`.`id_usuario` AND `ordenes_detalles`.`id_orden` = `ordenes`.`id_orden` AND `ordenes_detalles`.`id_producto` = `productos`.`id_producto` ORDER BY `ordenes`.`id_orden` ASC, `ordenes_detalles`.`id_producto` ASC ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `noticias`
--
ALTER TABLE `noticias`
  ADD PRIMARY KEY (`id_noticia`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `ordenes`
--
ALTER TABLE `ordenes`
  ADD PRIMARY KEY (`id_orden`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `ordenes_detalles`
--
ALTER TABLE `ordenes_detalles`
  ADD PRIMARY KEY (`id_orden`,`id_producto`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id_producto`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `noticias`
--
ALTER TABLE `noticias`
  MODIFY `id_noticia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `ordenes`
--
ALTER TABLE `ordenes`
  MODIFY `id_orden` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `noticias`
--
ALTER TABLE `noticias`
  ADD CONSTRAINT `noticias_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `ordenes`
--
ALTER TABLE `ordenes`
  ADD CONSTRAINT `ordenes_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `ordenes_detalles`
--
ALTER TABLE `ordenes_detalles`
  ADD CONSTRAINT `ordenes_detalles_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
