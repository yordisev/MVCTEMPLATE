-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 16-12-2021 a las 08:00:05
-- Versión del servidor: 5.7.31
-- Versión de PHP: 7.1.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `db_sistema`
--

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `delete_persona`$$
CREATE PROCEDURE `delete_persona` (`personaid` BIGINT)  BEGIN
		DECLARE existe_persona INT;
		DECLARE id INT;
		SET existe_persona = (SELECT COUNT(*) FROM persona WHERE idpersona = personaid);
		IF existe_persona  > 0 THEN
			delete from persona where idpersona = personaid;
			set id = 1;			
		ELSE
			SET id = 0;
		END IF;
		SELECT id;
	END$$

DROP PROCEDURE IF EXISTS `insert_persona`$$
CREATE PROCEDURE `insert_persona` (`nom` VARCHAR(100), `ape` VARCHAR(100), `tel` BIGINT, `emailp` VARCHAR(100))  BEGIN
		declare existe_persona INT;
		DECLARE id INT;
		set existe_persona = (SELECT count(*) from persona where email = emailp);
		if existe_persona  = 0 then
			insert into persona(nombre,apellido,telefono,email) VALUES(nom,ape,tel,emailp);
			SET id = last_insert_id();
		else
			set id = 0;
		end if;
		select id;
	END$$

DROP PROCEDURE IF EXISTS `search_persona`$$
CREATE PROCEDURE `search_persona` (`busqueda` VARCHAR(100))  begin
		select idpersona,nombre,apellido,telefono,email from persona where
		(nombre like concat('%',busqueda,'%') or
		apellido LIKE CONCAT('%',busqueda,'%') or
		telefono LIKE CONCAT('%',busqueda,'%') or
		email LIKE CONCAT('%',busqueda,'%'))
		and
		status != 0;
	end$$

DROP PROCEDURE IF EXISTS `select_persona`$$
CREATE PROCEDURE `select_persona` (`id` BIGINT)  begin
		SELECT idpersona,nombre,apellido,telefono,email FROM persona WHERE idpersona = id and status != 0;
	end$$

DROP PROCEDURE IF EXISTS `select_personas`$$
CREATE PROCEDURE `select_personas` ()  begin
		SELECT idpersona,nombre,apellido,telefono,email FROM persona where status != 0 order by idpersona desc;
	end$$

DROP PROCEDURE IF EXISTS `update_persona`$$
CREATE PROCEDURE `update_persona` (`id` BIGINT, `nom` VARCHAR(100), `ape` VARCHAR(100), `tel` BIGINT, `emailp` VARCHAR(100))  BEGIN
		declare existe_persona INT;
		DECLARE existe_email INT;
		DECLARE idp INT;
		set existe_persona = (SELECT count(*) from persona where idpersona = id);
		if existe_persona  > 0 then
			set existe_email = (SELECT count(*) from persona where email = emailp and idpersona != id);
			if existe_email = 0 then
				update persona set nombre=nom,apellido=ape,telefono=tel,email=emailp where idpersona = id;
				set idp = id;
			else
				set idp = 0;
			end if;
			
		else
			set idp = 0;
		end if;
		select idp;
	END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

DROP TABLE IF EXISTS `persona`;
CREATE TABLE IF NOT EXISTS `persona` (
  `idpersona` bigint(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE utf8mb4_swedish_ci NOT NULL,
  `apellido` varchar(100) COLLATE utf8mb4_swedish_ci NOT NULL,
  `telefono` bigint(20) DEFAULT NULL,
  `email` varchar(100) COLLATE utf8mb4_swedish_ci NOT NULL,
  `datecreated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`idpersona`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`idpersona`, `nombre`, `apellido`, `telefono`, `email`, `datecreated`, `status`) VALUES
(2, 'Enrique', 'Castillo', 123456789, 'enrique@info.com', '2021-08-26 01:44:19', 1),
(3, 'Fernando', 'Pérez', 46897878, 'fer@abelosh.com', '2021-08-26 00:00:00', 0),
(4, 'Francisco', 'Hernández', 45212002, 'fran@abelosh.com', '2021-08-26 01:49:21', 1),
(5, 'Alejandra', 'Rosales', 48978980, 'ale@abelosh.com', '2021-08-26 01:49:57', 1),
(6, 'Marta', 'Paredes', 45212002, 'marga@abelosh.com', '2021-08-26 01:50:13', 1),
(7, 'Gabriela', 'Pineda', 45578954, 'gaby@abelosh.com', '2021-08-26 01:50:33', 1),
(9, 'Carlos Enrrique', 'Maldonado Mora', 78954987, 'cmaldonado@abelosh.com', '2021-08-26 01:54:10', 1),
(10, 'Fabby', 'Torres', 45212002, 'ftorres@abelosh.com', '2021-08-26 01:54:37', 1),
(11, 'Alejandro', 'Pérez', 65465465, 'alej@abelosh.com', '2021-07-26 01:58:34', 1),
(13, 'Julieta', 'Méndez', 45212002, 'julia@abelosh.com', '2021-08-27 22:33:15', 1),
(16, 'Mateo', 'Torres', 78547898, 'mateo@abelosh.com', '2021-08-28 22:34:52', 1),
(17, 'Ángle Eduardo', 'Castillo López', 4654654, 'angeleduardo@info.com', '2021-10-01 01:55:05', 1),
(18, 'Juan Francisco', 'Hernández Pérez', 54654654, 'info@abelosh.com', '2021-11-19 02:08:59', 1),
(22, 'Chaqueta Azul', 'Oj', 465465465, 'ccc@info.com', '2021-11-19 02:15:18', 1),
(23, 'Francisco', 'Juarez', 465465465, 'sdfsdfs@info.com', '2021-11-19 02:15:44', 1),
(25, 'Fernando', 'Arana', 456578978, 'fer@info.com', '2021-11-19 21:08:15', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tarea`
--

DROP TABLE IF EXISTS `tarea`;
CREATE TABLE IF NOT EXISTS `tarea` (
  `idtarea` bigint(20) NOT NULL AUTO_INCREMENT,
  `nombretarea` varchar(100) COLLATE utf8mb4_swedish_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_swedish_ci NOT NULL,
  `fecha_inicio` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_fin` datetime DEFAULT NULL,
  `personaid` bigint(20) NOT NULL,
  `status` varchar(20) COLLATE utf8mb4_swedish_ci NOT NULL,
  PRIMARY KEY (`idtarea`),
  KEY `tarea_persona_fk` (`personaid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;

--
-- Volcado de datos para la tabla `tarea`
--

INSERT INTO `tarea` (`idtarea`, `nombretarea`, `descripcion`, `fecha_inicio`, `fecha_fin`, `personaid`, `status`) VALUES
(2, 'Diagramar Procesos', 'Diagramar proceso de la aplicación facturación', '2021-08-27 00:01:30', '2021-08-29 00:01:53', 2, 'Finalizado');

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `tarea`
--
ALTER TABLE `tarea`
  ADD CONSTRAINT `tarea_persona_fk` FOREIGN KEY (`personaid`) REFERENCES `persona` (`idpersona`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
