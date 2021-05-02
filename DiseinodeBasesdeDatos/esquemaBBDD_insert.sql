DROP DATABASE IF EXISTS `ArtBase`;
CREATE DATABASE  IF NOT EXISTS `ArtBase`;

USE `ArtBase`;

/* los artistas, sus nombres (que son únicos), lugares de nacimiento, año de nacimiento 
 y estilo de arte (clásico o moderno). */

DROP TABLE IF EXISTS `estilo`;
CREATE TABLE `estilo` (
  `ID_estilo`	int NOT NULL AUTO_INCREMENT,
  `estilo`  	varchar(20),
  PRIMARY KEY (`ID_estilo`)
);

DROP TABLE IF EXISTS `artista`;
CREATE TABLE `artista` (
  `ID_artista` int NOT NULL AUTO_INCREMENT,
  `nombreArtista` varchar(50) NOT NULL,

  `paisDeNacimiento` varchar(15),
  `ciudadDeNacimiento` varchar (15),
  `direccionDeNacimiento` varchar (30),
  `fechaNacimiento` DATE ,

  /* NOs digeron que solo hay 2 tipos, clasico o moderno, si no fuera así, lo mejor sería hacer una tabla auxiliar con todos los posibles estilos 
  y que aquí hubiera un foreign key*/
  `ID_estilo` INT NOT NULL,
/*`estilo` char(10), /*c-clasico, m-moderno*/

  PRIMARY KEY (`ID_artista`),
  FOREIGN KEY (`ID_estilo`) REFERENCES `estilo` (`ID_estilo`)

);


/*	DESCRIPCION `obraDeArte`:
-ID_obraDeArte(Primary key)
-El artista (Foreign key)				-Su tipo de arte (pintura, litografía, escultura, fotografía)
-El año en que se hizo	 				-Su título 
-Precio 
*/
/*	CARACTERISTICAS ESPECIALES:
-Asumimos que cada obra de arte ha sido creada por un solo artista.
-Supongamos también que tenemos varias obras de arte con el mismo título por ejemplo:  “What is Love?” by Cheryl D, “What is Love?” by Joe Brown, etc.*/

/* SACAR TIPO DE ARTE DE OBRA DE ARTE PARA NORMALIZAR LA BBDD*/

DROP TABLE IF EXISTS `tipoArte`;
CREATE TABLE `tipoArte` (
  `ID_tipoArte` int NOT NULL AUTO_INCREMENT,
  `tipoArte` varchar(20),

    PRIMARY KEY (`ID_tipoArte`)
);

DROP TABLE IF EXISTS `obraDeArte`;
CREATE TABLE `obraDeArte` (
  `ID_obraDeArte` int NOT NULL AUTO_INCREMENT, /*SE Puede hacer tmb con el titulo y el artista en vez de una id*/

  `titulo` varchar(35) NOT NULL,

  `ID_artista` INT NOT NULL,

  `ID_tipoArte` INT NOT NULL,

  `anioCreacion` DATE ,

  `precio` DECIMAL(14, 2) UNSIGNED,


  PRIMARY KEY (`ID_obraDeArte`),
  FOREIGN KEY (`ID_artista`) REFERENCES `artista` (`ID_artista`),
  FOREIGN KEY (`ID_tipoArte`) REFERENCES `tipoArte` (`ID_tipoArte`)
);

/*GRUPO ES PARA REDUCIR COMLEJIDAD*/
DROP TABLE IF EXISTS `grupo`;
CREATE TABLE `grupo` (
	`ID_grupo` int NOT NULL AUTO_INCREMENT,
	`nombreGrupo` varchar(30) NOT NULL,

	PRIMARY KEY(`ID_grupo`)
);


/* DESCRIPCION `cliente`:
-NOmbre(Primary key)
-Direccion 								-Su tipo de arte (pintura, litografía, escultura, fotografía)
-Direccion(pais ciudad calle nº extra)	-Grupos que tiende a elegir (FOREIGN KEY a tabla relacion con grupos) 
-Dienro Total Gastado 
*/
DROP TABLE IF EXISTS `cliente`;
CREATE TABLE `cliente`(
`ID_cliente` INT NOT NULL AUTO_INCREMENT,
  `nombreCliente` varchar(50) NOT NULL,
  /*	NOTAS DE CLASE
  mysql -u usuario -p -h <IP>
  pepito@%->aceso externo
  /etc/mudql/mysql.conf.d/mysqld.conf
  bind_address 127.0.0.1 -> 0.0.0.0 (o el de la red que quieras)
  */
	/*DIRECCION*/
  `pais` varchar(15),
  `ciudad` varchar (30),
  `calle` varchar(20),
  `numero` SMALLINT (5) UNSIGNED,
  `restoInformacion` varchar (40), /*si es un piso o una escalera o el bloque o klk*/

	`gastoTotal` DECIMAL(15, 2) UNSIGNED,

  PRIMARY KEY (`ID_cliente`)
);


DROP TABLE IF EXISTS `RELACION_OBRA_GRUPO`;
CREATE TABLE `RELACION_OBRA_GRUPO` (
	`ID_relacion_OBRA_GRUPO` int NOT NULL AUTO_INCREMENT,

    `ID_grupo` int NOT NULL ,
	`ID_obraDeArte` int NOT NULL,

    PRIMARY KEY(`ID_relacion_OBRA_GRUPO` ),
    FOREIGN KEY (`ID_grupo`) REFERENCES `grupo` (`ID_grupo`),
    FOREIGN KEY (`ID_obraDeArte`) REFERENCES `obraDeArte` (`ID_obraDeArte`)
);

DROP TABLE IF EXISTS `RELACION_CLIENTE_GRUPO`;
CREATE TABLE `RELACION_CLIENTE_GRUPO` (
	`ID_relacion_CLIENTE_GRUPO` int NOT NULL AUTO_INCREMENT,

    `ID_grupo` int NOT NULL ,
	`ID_cliente` int NOT NULL,

    PRIMARY KEY(`ID_relacion_CLIENTE_GRUPO` ),
    FOREIGN KEY (`ID_grupo`) REFERENCES `grupo` (`ID_grupo`),
    FOREIGN KEY (`ID_cliente`) REFERENCES `cliente` (`ID_cliente`)
);

/*INSERTS BASE DE DATOS*/
insert into `estilo`(`estilo`)
values
 ('clasico')
,('moderno')
;

insert into `artista` (`nombreArtista`, `paisDeNacimiento`, `ciudadDeNacimiento`, `direccionDeNacimiento`, `fechaNacimiento`, `ID_estilo`)
values
 ('Vladamir Milnthorpe','South Korea', 'Goseong', '9 Union Circle', '1996-09-24', 		1)
,('Kym Melding', 	'Indonesia', 'Kadurahayu', '58745 Orin Junction', '1998-01-28', 	2)
,('Marleen Edgeller', 	'Norway', 'Elverum', '1 Loftsgordon Center', '1999-10-19',		1)
,('Georgi Priddy', 	'Sweden', 'Vårgårda', '57723 6th Junction', '1997-07-05', 		1)
,('Gaby Maffioni', 	'China', 'Huangqiao', '170 Lakewood Gardens Circle', '2001-01-10', 	1)
,('Flynn Yeulet', 	'Zimbabwe', 'Chinhoyi', '693 Blue Bill Park Terrace', '1996-04-13',	2)
,('Gay Karppi', 	'China', 'Bashan', '4181 Continental Street', '1999-09-29', 		2)
,('Agustin Cockerton', 	'Russia', 'Volokolamsk', '3082 Hanson Circle', '2000-10-19', 		2)
,('Brittani Bedells', 	'China', 'Caijiapu', '9 Bellgrove Plaza', '1999-10-24', 		1)
,('Martie Hamblyn', 	'Indonesia', 'Desa Werasari', '9839 Hanover Terrace', '1997-06-25', 	1)
;

insert into `cliente` (`nombreCliente`, `pais`, `ciudad`, `calle`, `numero`, `gastoTotal`) 
values
 ('Trevar Wytchard', 'Russia', 'Cherëmushki', 'Scoville', 72, 5994321.70)
,('Brinna Henrichsen', 'Panama', 'Llano Largo', 'Corscot',56, 1211356.20)
,('Dotty Redfern', 'Sweden', 'Örebro', 'Vernon', 5, 7651409.48)
,('Benton Treen', 'Russia', 'Orahovica Donja', 'Di Loreto', 6873, 2856053.24)
,('Wang Bosnell', 'China', 'Hujiaba', 'Dexter', 725, 6058466.20)
,('Hillier Sprigin', 'Mongolia', 'Erdenet', 'Westerfield', 289, 2784309.57)
,('Erasmus Martynka', 'Poland', 'Radzanów', 'Kennedy', 190, 8269431.44)
,('Frederique Vane', 'Sweden', 'Kallinge', 'Utah', 923, 5789140.47)
,('Emanuele Phalp', 'Portugal', 'Serra de Santa Marinha', 'Ramsey', 6, 7540572.39)
,('Lenard Spurdon', 'China', 'Bailai', 'Bluejay', 2209, 7986521.41)
;

insert into `tipoArte` (`tipoArte`) 
values
('Artdeco')
,('Impresionismo')
,('Surrealismo')
,('Realismo')
,('Contemporaneo')
,('Modernista')
;


insert into `obraDeArte` (`titulo`, `ID_artista`, `ID_tipoArte`, `precio`,`anioCreacion`) 
values 
('Tamara en un Bugatti Verde', 		1, 1, 29.53, '1999-03-17')
,('La cuna',				3, 2, 92.69, '1959-10-23')
,('Young Woman Picking Fruit', 		2, 3, 29.68, '1978-03-02')
,('Gintana y alerquin', 		4, 4, 74.62, '1966-11-3')
,('El destino', 			2, 1, 90.4,  '1990-03-05')
,('A miracle', 				7, 6, 14.33, '1970-06-24')
,('La feriade caballos', 		5, 5, 3.53,  '1955-03-25')
,('Blue and Green music', 		6, 3, 5.71,  '1921-08-30')
,('Adeu Ammenotep', 			9, 4, 61.26, '1960-06-20')
,('La violoncel-lista descansant',     10, 6, 22.65, '1976-12-28')
;

insert into `grupo` (`nombreGrupo`) 
values
('Retratos')
,('Del siglo XIX')
,('Del siglo XVIII')
,('Precios inferiores a 50 euros')
,('Precios superiores a 50 euros')
,('Obras del Realismo')
,('Obras del Impresionismo')
,('Obras del Surrealismo')
,('Obras de Camille Claudel')
,('Obras de Georgia OKeefee')
;

insert into `RELACION_OBRA_GRUPO` (`ID_grupo`,`ID_obraDeArte`) 
values
(1,1)
,(2,1)
,(2,4)
,(3,2)
,(3,5)
,(6,5)
,(8,4)
,(8,9)
,(7,3)
,(6,7)
;

insert into `RELACION_CLIENTE_GRUPO` (`ID_grupo`,`ID_cliente`) 
values
(1,1)
,(3,4)
,(3,6)
,(7,3)
,(9,5)
,(10,8)
,(4,6)
,(8,9)
,(2,5)
,(5,10)
;
/* FIN DE DATOS UTILES */

SELECT * FROM obraDeArte;
SELECT * FROM artista;
SELECT * FROM cliente;
SELECT * FROM grupo;
SELECT * FROM RELACION_CLIENTE_GRUPO;
SELECT * FROM RELACION_OBRA_GRUPO;
SELECT * FROM tipoArte;
SELECT * FROM estilo;

/*como hacer un insert into
insert  into `artistas`(`customerNumber`,`customerName`,`contactLastName`,`contactFirstName`,`phone`,`addressLine1`,`addressLine2`,`city`,`state`,`postalCode`,`country`,`salesRepEmployeeNumber`,`creditLimit`) values 

(103,'Atelier graphique','Schmitt','Carine ','40.32.2555','54, rue Royale',NULL,'Nantes',NULL,'44000','France',1370,'21000.00'),

(496,'Kelly\'s Gift Shop','Snowden','Tony','+64 9 5555500','Arenales 1938 3\'A\'',NULL,'Auckland  ',NULL,NULL,'New Zealand',1612,'110000.00');
*/
