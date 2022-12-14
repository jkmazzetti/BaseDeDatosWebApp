CREATE DATABASE `GYMPAL` CHARACTER SET utf8 COLLATE utf8_bin;
USE `GYMPAL`;
CREATE TABLE `EstadosObjetivos` (
`id` int(11) NOT NULL AUTO_INCREMENT,
 `Estado` varchar(12) COLLATE utf8_bin DEFAULT NULL,
 PRIMARY KEY (`id`)
);
CREATE TABLE `EstadoEjecicio` (
`id` int(11) NOT NULL AUTO_INCREMENT,
 `Estado` varchar(12) COLLATE utf8_bin DEFAULT NULL,
 PRIMARY KEY (`id`)
);
CREATE TABLE `DiasHabilitados` (
 `id` int(11) NOT NULL AUTO_INCREMENT,
 `Dia` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
 PRIMARY KEY (`id`)
);
CREATE TABLE `Sexo` (
 `id` int(11) NOT NULL AUTO_INCREMENT,
 `Sexo` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
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
 `id` int(11) NOT NULL AUTO_INCREMENT,
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
 CONSTRAINT `Objetivos_ibfk_2` FOREIGN KEY (`id_estado`) REFERENCES `EstadosObjetivos` (`id`)
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
 `Sexo` int(2) NOT NULL,
 `FechaDeNacimiento` date DEFAULT NULL,
 `DNI` varchar(11) DEFAULT NULL,
 `Direccion` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
 `Email` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
 `Celular` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
 `FechaDeRegistro` date NOT NULL,
 PRIMARY KEY (`id`),
 KEY `Sexo` (`Sexo`),
 CONSTRAINT `Usuarios_ibfk_1` FOREIGN KEY (`Sexo`) REFERENCES `Sexo` (`id`)
);
CREATE TABLE `EstadosUsuarios` (
 `id_usuario` int(11) NOT NULL,
 `id_sexo` int(11) NOT NULL,
 `Altura` float NOT NULL,
 `Peso` float NOT NULL,
 `IndicenMasaCorporal` float DEFAULT NULL,
 `PorcentajeGrasaCorporal` float DEFAULT NULL,
 KEY `id_usuario` (`id_usuario`),
 KEY `id_sexo` (`id_sexo`),
 CONSTRAINT `EstadosUsuarios_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `Usuarios` (`id`),
 CONSTRAINT `EstadosUsuarios_ibfk_2` FOREIGN KEY (`id_sexo`) REFERENCES `Sexo` (`id`)
);
CREATE TABLE `LogIn` (
 `id_usuario` int(11) NOT NULL,
 `UserName` varchar(32) COLLATE utf8_bin NOT NULL,
 `Password` varchar(32) COLLATE utf8_bin NOT NULL,
 `PrimeraPregunta` int(11) NOT NULL,
 `SegundaPregunta` int(11) NOT NULL,
 `TerceraPregunta` int(11) NOT NULL,
 `Provisoria` tinyint(1) DEFAULT 0,
 KEY `id_usuario` (`id_usuario`),
 KEY `PrimeraPregunta` (`PrimeraPregunta`),
 KEY `SegundaPregunta` (`SegundaPregunta`),
 KEY `TerceraPregunta` (`TerceraPregunta`),
 CONSTRAINT `LogIn_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `Usuarios` (`id`),
 CONSTRAINT `LogIn_ibfk_2` FOREIGN KEY (`PrimeraPregunta`) REFERENCES `Preguntas` (`id`),
 CONSTRAINT `LogIn_ibfk_3` FOREIGN KEY (`SegundaPregunta`) REFERENCES `Preguntas` (`id`),
 CONSTRAINT `LogIn_ibfk_4` FOREIGN KEY (`TerceraPregunta`) REFERENCES `Preguntas` (`id`)
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
 `id` int(11) NOT NULL AUTO_INCREMENT,
 `Nombre` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
 `id_exigencia` int(11) NOT NULL,
 `NivelAerobico` int(11) NOT NULL,
 `TiempoUnitario` int(11) NOT NULL,
 `id_grupo_muscular` int(11) NOT NULL,
 PRIMARY KEY (`id`),
 KEY `id_exigencia` (`id_exigencia`),
 KEY `id_grupo_muscular` (`id_grupo_muscular`),
 CONSTRAINT `Ejercicios_ibfk_1` FOREIGN KEY (`id_exigencia`) REFERENCES `NivelesDeExigencia` (`id`),
 CONSTRAINT `Ejercicios_ibfk_2` FOREIGN KEY (`id_grupo_muscular`) REFERENCES `GruposMusculares` (`id`)
);
CREATE TABLE `Rutinas` (
 `id` int(11) NOT NULL AUTO_INCREMENT,
 `fechaDeInicio` date NOT NULL,
 `FechaDeFin` date NOT NULL,
 `id_usuario` int(11) NOT NULL,
 `Completitud` float DEFAULT 0.0,
 `FrecuenciaDePesaje` int(11) DEFAULT 0,
 `SemanasDeDuracion` int(11) DEFAULT 4,
 `id_objetivo` int(11) NOT NULL, 
 PRIMARY KEY (`id`),
 KEY `id_usuario` (`id_usuario`),
 KEY `id_objetivo` (`id_objetivo`), 
 CONSTRAINT `Rutinas_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `Usuarios` (`id`),
 CONSTRAINT `Rutinas_ibfk_2` FOREIGN KEY (`id_objetivo`) REFERENCES `Objetivos` (`id`) 
);
CREATE TABLE `LogrosDeUsuarios` (
 `id_usuario` int(11) NOT NULL,
 `id_logro` int(11) NOT NULL,
 `id_rutina` int(11) NOT NULL,
 KEY `id_usuario` (`id_usuario`),
 KEY `id_logro` (`id_logro`),
 KEY `id_rutina` (`id_rutina`),
 CONSTRAINT `LogrosDeUsuarios_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `Usuarios` (`id`),
 CONSTRAINT `LogrosDeUsuarios_ibfk_2` FOREIGN KEY (`id_logro`) REFERENCES `Logros` (`id`),
 CONSTRAINT `LogrosDeUsuarios_ibfk_3` FOREIGN KEY (`id_rutina`) REFERENCES `Rutinas` (`id`)
);
CREATE TABLE `Entrenamientos` (
 `id` int(11) NOT NULL AUTO_INCREMENT,
 `FechaProgramada` date NOT NULL,
 `id_dia` int(11) NOT NULL,
 `TiempoRestante` float DEFAULT 0.0,
 `Completitud` float DEFAULT 0.0,
 `id_rutina` int(11) NOT NULL,
 PRIMARY KEY (`id`),
 KEY `id_dia` (`id_dia`),
 KEY `id_rutina` (`id_rutina`),
 CONSTRAINT `Entrenamientos_ibfk_1` FOREIGN KEY (`id_dia`) REFERENCES `DiasHabilitados` (`id`),
 CONSTRAINT `Entrenamientos_ibfk_2` FOREIGN KEY (`id_rutina`) REFERENCES `Rutinas` (`id`)
);
CREATE TABLE `EjerciciosDeEntrenamiento` (
 `id` int(11) NOT NULL AUTO_INCREMENT,
 `id_entrenamiento` int(11) NOT NULL,
 `id_ejercicio` int(11) NOT NULL,
 `Series` int(11) DEFAULT 0,
 `Repeticiones` int(11) DEFAULT 0,
 `Esfuerzo` int(11) DEFAULT 0.0,
 `Completado` tinyint(1) DEFAULT 0,
 `TiempoRequerido` float DEFAULT 0.0,
 `id_estado` int(11) DEFAULT 1, 
 PRIMARY KEY (`id`),
 KEY `id_entrenamiento` (`id_entrenamiento`),
 KEY `id_ejercicio` (`id_ejercicio`),
 KEY `id_estado` (`id_estado`),
 CONSTRAINT `EjerciciosDeEntrenamiento_ibfk_1` FOREIGN KEY (`id_entrenamiento`) REFERENCES `Entrenamientos` (`id`),
 CONSTRAINT `EjerciciosDeEntrenamiento_ibfk_2` FOREIGN KEY (`id_ejercicio`) REFERENCES `Ejercicios` (`id`),
 CONSTRAINT `EjerciciosDeEntrenamiento_ibfk_3` FOREIGN KEY (`id_estado`) REFERENCES `EstadoEjecicio` (`id`)
);
CREATE TABLE `PesajeDeUsuarios` ( 
id_usuario int not null, 
FOREIGN key (id_usuario) REFERENCES Usuarios(id), 
id_rutina int not null, 
FOREIGN key (id_rutina) REFERENCES Rutinas(id), 
Peso float not null, 
MasaCorporal float not null
);
CREATE TABLE `EjerciciosRealizadosPorEntrenamiento`(
`id_entrenamiento` int not null,
`id_ejercicio_entrenamiento` int not null,
`Series` int not null,
`Repeticiones` int not null,
`Esfuerzo` float not null,
KEY `id_entrenamiento` (`id_entrenamiento`),
KEY `id_ejercicio_entrenamiento` (`id_ejercicio_entrenamiento`),
CONSTRAINT `EjerciciosRealizadosPorEntrenamiento_ibfk_1` FOREIGN KEY (`id_entrenamiento`) REFERENCES `Entrenamientos` (`id`),
CONSTRAINT `EjerciciosRealizadosPorEntrenamiento_ibfk_2` FOREIGN KEY (`id_ejercicio_entrenamiento`) REFERENCES `EjerciciosDeEntrenamiento` (`id`)
);
ALTER TABLE Ejercicios ADD COLUMN VideoURL varchar (255);
INSERT INTO Sexo (Sexo) VALUES ('Masculino');
INSERT INTO Sexo (Sexo) VALUES ('Femenino');
INSERT INTO DiasHabilitados (Dia) VALUES ('Lunes');
INSERT INTO DiasHabilitados (Dia) VALUES ('Martes');
INSERT INTO DiasHabilitados (Dia) VALUES ('Miercoles');
INSERT INTO DiasHabilitados (Dia) VALUES ('Jueves');
INSERT INTO DiasHabilitados (Dia) VALUES ('Viernes');
INSERT INTO DiasHabilitados (Dia) VALUES ('S??bado');
INSERT INTO DiasHabilitados (Dia) VALUES ('Domingo');
INSERT INTO NivelesDeExigencia (Exigencia) VALUES ('Baja');
INSERT INTO NivelesDeExigencia (Exigencia) VALUES ('Media');
INSERT INTO NivelesDeExigencia (Exigencia) VALUES ('Alta');
INSERT INTO GruposMusculares (Parte, Descripcion) VALUES ('Pecho','Mejora postura y respiraci??n.');
INSERT INTO GruposMusculares (Parte, Descripcion) VALUES ('Hombros','Hombros m??s fuertes, resistentes y capaces de soportar m??s peso.');
INSERT INTO GruposMusculares (Parte, Descripcion) VALUES ('Tr??ceps','Ayudan a equilibrar los brazos.');
INSERT INTO GruposMusculares (Parte, Descripcion) VALUES ('Espalda','Ayuda a proteger la columna vertebral.');
INSERT INTO GruposMusculares (Parte, Descripcion) VALUES ('B??ceps','Acelera el metabolismo.');
INSERT INTO GruposMusculares (Parte, Descripcion) VALUES ('Abdominales','Acelera el movimiento de los intestinos y se facilita la digesti??n.');
INSERT INTO GruposMusculares (Parte, Descripcion) VALUES ('Isquiotibiales','Evita lesiones en espalda baja, rodillas, gl??teos y pantorrillas.');
INSERT INTO GruposMusculares (Parte, Descripcion) VALUES ('Cu??driceps','Mejora el rendimiento de cualquier en disciplina deportiva');
INSERT INTO GruposMusculares (Parte, Descripcion) VALUES ('Gl??teos','Mejora el desempe??o deportivo.');
INSERT INTO Preguntas (Pregunta) VALUES ('??Cu??l es tu color favorito?');
INSERT INTO Preguntas (Pregunta) VALUES ('??C??mo se llama tu mascota?');
INSERT INTO Preguntas (Pregunta) VALUES ('??Cu??l es el apellido de casada de tu mam???');
INSERT INTO Preguntas (Pregunta) VALUES ('??Cu??l es tu hobby?');
INSERT INTO Preguntas (Pregunta) VALUES ('??C??mo se llamaba tu mejor amigo de la infancia?');
INSERT INTO Preguntas (Pregunta) VALUES ('??Cu??l es tu lugar comida favorita?');
INSERT INTO TiposDeObjetivos (Tipo) VALUES ('Bajar de peso');
INSERT INTO TiposDeObjetivos (Tipo) VALUES ('Tonificar el cuerpo');
INSERT INTO TiposDeObjetivos (Tipo) VALUES ('Mantener la figura');
INSERT INTO Logros (Logro, Descripcion, URL) VALUES ('Medalla Dedicaci??n','??Cumpl??ste todos los objetivos!','img/medalla_dedicacion.png');
INSERT INTO Logros (Logro, Descripcion, URL) VALUES ('Medalla Constancia','??Asistencia Perfecta!','img/medalla_constancia.png');
INSERT INTO Logros (Logro, Descripcion, URL) VALUES ('Medalla Cre??do','??Te ves muy bien!','img/medalla_creido.png');
INSERT INTO EstadosObjetivos (Estado) VALUES ('No cumplido');
INSERT INTO EstadosObjetivos (Estado) VALUES ('Cumplido');
INSERT INTO EstadoEjecicio (Estado) VALUES ('Pausado');
INSERT INTO EstadoEjecicio (Estado) VALUES ('En proceso');
INSERT INTO EstadoEjecicio (Estado) VALUES ('Finalizado');
INSERT INTO EstadoEjecicio (Estado) VALUES ('Cancelado');
INSERT INTO Ejercicios (Nombre, id_exigencia, NivelAerobico, TiempoUnitario, id_grupo_muscular) VALUES ('Press inclinado', 3, 8, 18, 1);
INSERT INTO Ejercicios (Nombre, id_exigencia, NivelAerobico, TiempoUnitario, id_grupo_muscular) VALUES ('Press declinado', 3, 8, 12, 1);
INSERT INTO Ejercicios (Nombre, id_exigencia, NivelAerobico, TiempoUnitario, id_grupo_muscular) VALUES ('Flexiones', 2, 5, 10, 1);
INSERT INTO Ejercicios (Nombre, id_exigencia, NivelAerobico, TiempoUnitario, id_grupo_muscular) VALUES ('Press de hombros', 2, 5, 6, 2);
INSERT INTO Ejercicios (Nombre, id_exigencia, NivelAerobico, TiempoUnitario, id_grupo_muscular) VALUES ('Press Arnold', 2, 5, 6, 2);
INSERT INTO Usuarios (Nombre, Apellido, Sexo, FechaDeNacimiento, DNI, Direccion, Email, Celular, FechaDeRegistro) VALUES ('Jeremias', 'Mazzetti', '1', '1992-06-01', '3636363636', 'Calle 1500', 'jere.mazzetti@gmail.com', '15-6666-6666','2022-09-04');
INSERT INTO LogIn (id_usuario, UserName, Password, PrimeraPregunta, SegundaPregunta, TerceraPregunta, Provisoria) VALUES ('1', 'admin', '123456', '1', '2', '5', '0');
INSERT INTO EstadosUsuarios (id_usuario, id_sexo, Altura, Peso, IndicenMasaCorporal, PorcentajeGrasaCorporal) VALUES ('1','1','1.77','75.0','75.5','5');
INSERT INTO RespuestasDeUsuarios (id_usuario, id_pregunta, Respuesta) VALUES ('1', '1', 'Azul Noche');
INSERT INTO RespuestasDeUsuarios (id_usuario, id_pregunta, Respuesta) VALUES ('1', '2', 'Martin');
INSERT INTO RespuestasDeUsuarios (id_usuario, id_pregunta, Respuesta) VALUES ('1', '5', 'Fulanito');
INSERT INTO Objetivos (id_tipo, PesoIdeal, MasaCorporalIdeal, MargenAceptable, id_estado) VALUES ('2', '72.5', '80.5', '3.5', '1');
INSERT INTO Rutinas (fechaDeInicio, FechaDeFin, id_usuario, id_objetivo) VALUES ('2022-09-13', '2022-10-04', '1','1');
INSERT INTO Entrenamientos (FechaProgramada, id_dia, id_rutina) VALUES ('2022-09-13', '2', '1');
INSERT INTO Entrenamientos (FechaProgramada, id_dia, id_rutina) VALUES ('2022-09-15', '4', '1');
INSERT INTO EjerciciosDeEntrenamiento (id_entrenamiento, id_ejercicio, Series, Repeticiones, Esfuerzo, id_estado) VALUES ('1', '1', '3', '20', '10.5', '1');
INSERT INTO EjerciciosDeEntrenamiento (id_entrenamiento, id_ejercicio, Series, Repeticiones, Esfuerzo, id_estado) VALUES ('1', '2', '2', '15', '9.5', '1');
INSERT INTO EjerciciosDeEntrenamiento (id_entrenamiento, id_ejercicio, Series, Repeticiones, Esfuerzo, id_estado) VALUES ('1', '3', '4', '10', '12.5', '1');
INSERT INTO EjerciciosDeEntrenamiento (id_entrenamiento, id_ejercicio, Series, Repeticiones, Esfuerzo, id_estado) VALUES ('2', '4', '1', '50', '8.5', '1');
INSERT INTO EjerciciosDeEntrenamiento (id_entrenamiento, id_ejercicio, Series, Repeticiones, Esfuerzo, id_estado) VALUES ('2', '2', '3', '20', '10.0', '1');
INSERT INTO EjerciciosDeEntrenamiento (id_entrenamiento, id_ejercicio, Series, Repeticiones, Esfuerzo, id_estado) VALUES ('2', '5', '2', '15', '12.5', '1');	
