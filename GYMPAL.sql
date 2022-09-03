CREATE DATABASE `GYMPAL` CHARACTER SET utf8 COLLATE utf8_bin;
USE `GYMPAL`;
CREATE TABLE `DiasHabilitados` (
 `id` int(11) NOT NULL AUTO_INCREMENT,
 `Dia` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
 PRIMARY KEY (`id`)
);
CREATE TABLE `Estados` (
 `id` int(11) NOT NULL AUTO_INCREMENT,
 `Estado` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
 PRIMARY KEY (`id`)
);
CREATE TABLE `GruposMusculares` (
 `id` int(11) NOT NULL AUTO_INCREMENT,
 `Parte` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
 `Descripcion` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
 PRIMARY KEY (`id`)
);
CREATE TABLE `Logros` (
 `id` int(11) NOT NULL AUTO_INCREMENT,
 `Logro` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
 `Descripcion` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
 `URL` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
 PRIMARY KEY (`id`)
);
CREATE TABLE `TiposDeObjetivos` (
 `id` int(11) NOT NULL AUTO_INCREMENT,
 `Tipo` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
 PRIMARY KEY (`id`)
);
CREATE TABLE `NivelesDeExigencia` (
 `id` int(11) NOT NULL,
 `Exigencia` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
 PRIMARY KEY (`id`)
);
CREATE TABLE `Objetivos` (
 `id` int(11) NOT NULL AUTO_INCREMENT,
 `id_tipo` int(11) NOT NULL,
 `PesoIdeal` float DEFAULT NULL,
 `MasaCorporalIdeal` float DEFAULT NULL,
 `MargenAceptable` float DEFAULT NULL,
 `id_estado` int(11) NOT NULL,
 PRIMARY KEY (`id`),
 KEY `id_tipo` (`id_tipo`),
 KEY `id_estado` (`id_estado`),
 CONSTRAINT `Objetivos_ibfk_1` FOREIGN KEY (`id_tipo`) REFERENCES `TiposDeObjetivos` (`id`),
 CONSTRAINT `Objetivos_ibfk_3` FOREIGN KEY (`id_estado`) REFERENCES `Estados` (`id`)
);
CREATE TABLE `Preguntas` (
 `id` int(11) NOT NULL AUTO_INCREMENT,
 `Pregunta` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
 PRIMARY KEY (`id`)
);
CREATE TABLE `Usuarios` (
 `id` int(11) NOT NULL AUTO_INCREMENT,
 `Nombre` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
 `Apellido` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
 `Sexo` int(2) DEFAULT NULL,
 `FechaDeNacimiento` date DEFAULT NULL,
 `DNI` int(11) DEFAULT NULL,
 `Direccion` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
 `Celular` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
 `UserName` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
 `Password` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
 `PrimeraPregunta` int(11) NOT NULL,
 `SegundaPregunta` int(11) NOT NULL,
 `TerceraPregunta` int(11) NOT NULL,
 `Peso` float DEFAULT NULL,
 `PorcentajeGrasaCorporal` float DEFAULT NULL,
 `IndicenMasaCorporal` float DEFAULT NULL,
 `Provisoria` tinyint(1) NOT NULL,
 `FechaDeRegistro` date NOT NULL,
 PRIMARY KEY (`id`),
 KEY `PrimeraPregunta` (`PrimeraPregunta`),
 KEY `SegundaPregunta` (`SegundaPregunta`),
 KEY `TerceraPregunta` (`TerceraPregunta`),
 CONSTRAINT `Usuarios_ibfk_1` FOREIGN KEY (`PrimeraPregunta`) REFERENCES `Preguntas` (`id`),
 CONSTRAINT `Usuarios_ibfk_2` FOREIGN KEY (`SegundaPregunta`) REFERENCES `Preguntas` (`id`),
 CONSTRAINT `Usuarios_ibfk_3` FOREIGN KEY (`TerceraPregunta`) REFERENCES `Preguntas` (`id`)
);
CREATE TABLE `RespuestasDeUsuarios` (
 `id_usuario` int(11) DEFAULT NULL,
 `id_pregunta` int(11) DEFAULT NULL,
 `Respuesta` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
 KEY `id_usuario` (`id_usuario`),
 KEY `id_pregunta` (`id_pregunta`),
 CONSTRAINT `RespuestasDeUsuarios_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `Usuarios` (`id`),
 CONSTRAINT `RespuestasDeUsuarios_ibfk_2` FOREIGN KEY (`id_pregunta`) REFERENCES `Preguntas` (`id`)
);
CREATE TABLE `Ejercicios` (
 `id` int(11) NOT NULL,
 `Nombre` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
 `id_exigencia` int(11) NOT NULL,
 `NivelAerobico` int(11) NOT NULL,
 `TiempoUnitaro` int(11) NOT NULL,
 `id_grupo_muscular` int(11) NOT NULL,
 `id_estado` int(11) NOT NULL,
 PRIMARY KEY (`id`),
 KEY `id_exigencia` (`id_exigencia`),
 KEY `id_GrupoMuscular` (`id_grupo_muscular`),
 KEY `id_estado` (`id_estado`),
 CONSTRAINT `Ejercicios_ibfk_1` FOREIGN KEY (`id_exigencia`) REFERENCES `NivelesDeExigencia` (`id`),
 CONSTRAINT `Ejercicios_ibfk_2` FOREIGN KEY (`id_grupo_muscular`) REFERENCES `GruposMusculares` (`id`),
 CONSTRAINT `Ejercicios_ibfk_3` FOREIGN KEY (`id_estado`) REFERENCES `Estados` (`id`)
);
CREATE TABLE `Entrenamientos` (
 `id` int(11) NOT NULL,
 `fechaDeInicio` date NOT NULL,
 `FechaDeFin` date NOT NULL,
 `id_usuario` int(11) NOT NULL,
 `Completitud` float DEFAULT NULL,
 `id_estado` int(11) NOT NULL,
 `FrecuenciaDePesaje` int(11) DEFAULT 0,
 `SemanasDeDuracion` int(11) DEFAULT 4,
 `id_objetivo` int(11) NOT NULL,
 PRIMARY KEY (`id`),
 KEY `id_usuario` (`id_usuario`),
 KEY `id_estado` (`id_estado`),
 KEY `id_objetivo` (`id_objetivo`),
 CONSTRAINT `Entrenamientos_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `Usuarios` (`id`),
 CONSTRAINT `Entrenamientos_ibfk_2` FOREIGN KEY (`id_estado`) REFERENCES `Estados` (`id`),
 CONSTRAINT `Entrenamientos_ibfk_3` FOREIGN KEY (`id_objetivo`) REFERENCES `Objetivos` (`id`)
);
CREATE TABLE `LogrosDeUsuarios` (
 `id_usuario` int(11) NOT NULL,
 `id_logro` int(11) NOT NULL,
 `id_entrenamiento` int(11) NOT NULL,
 KEY `id_usuario` (`id_usuario`),
 KEY `id_logro` (`id_logro`),
 KEY `id_entrenamiento` (`id_entrenamiento`),
 CONSTRAINT `LogrosDeUsuarios_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `Usuarios` (`id`),
 CONSTRAINT `LogrosDeUsuarios_ibfk_2` FOREIGN KEY (`id_logro`) REFERENCES `Logros` (`id`),
 CONSTRAINT `LogrosDeUsuarios_ibfk_3` FOREIGN KEY (`id_entrenamiento`) REFERENCES `Entrenamientos` (`id`)
);
CREATE TABLE `Rutinas` (
 `id` int(11) NOT NULL AUTO_INCREMENT,
 `FechaProgramada` date DEFAULT NULL,
 `id_dia` int(11) NOT NULL,
 `TiempoRestante` float DEFAULT NULL,
 `Completitud` float DEFAULT NULL,
 `id_entrenamiento` int(11) NOT NULL,
 PRIMARY KEY (`id`),
 KEY `id_dia` (`id_dia`),
 KEY `id_entrenamiento` (`id_entrenamiento`),
 CONSTRAINT `Rutinas_ibfk_1` FOREIGN KEY (`id_dia`) REFERENCES `DiasHabilitados` (`id`),
 CONSTRAINT `Rutinas_ibfk_2` FOREIGN KEY (`id_entrenamiento`) REFERENCES `Entrenamientos` (`id`)
);
CREATE TABLE `Subrutinas` (
 `id_rutina` int(11) NOT NULL,
 `id_ejercicio` int(11) NOT NULL,
 `Serie` int(11) NOT NULL,
 `Repeticiones` int(11) NOT NULL,
 `Esfuerzo` int(11) DEFAULT NULL,
 `Completado` tinyint(1) DEFAULT NULL,
 `TiempoRequerido` float NOT NULL,
 KEY `id_rutina` (`id_rutina`),
 KEY `id_ejercicio` (`id_ejercicio`),
 CONSTRAINT `Subrutinas_ibfk_1` FOREIGN KEY (`id_rutina`) REFERENCES `Rutinas` (`id`),
 CONSTRAINT `Subrutinas_ibfk_2` FOREIGN KEY (`id_ejercicio`) REFERENCES `Ejercicios` (`id`)
);
