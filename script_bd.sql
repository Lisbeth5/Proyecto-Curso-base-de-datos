-- -----------------------------------------------------
-- Table `ciudad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ciudad` (
  `idciudad` INT NOT NULL,
  `nombre_ciudad` VARCHAR(45) NULL,
  PRIMARY KEY (`idciudad`)
);


-- -----------------------------------------------------
-- Table `ubicacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ubicacion` (
  `idubicacion` INT NOT NULL,
  `calle` INT NULL,
  `comuna` VARCHAR(45) NULL,
  `descripcion` VARCHAR(45) NULL,
  `ciudad_idciudad` INT NOT NULL,
  PRIMARY KEY (`idubicacion`),
  INDEX `fk_ubicacion_ciudad_idx` (`ciudad_idciudad` ASC),
  CONSTRAINT `fk_ubicacion_ciudad`
    FOREIGN KEY (`ciudad_idciudad`)
    REFERENCES `ciudad` (`idciudad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);


-- -----------------------------------------------------
-- Table `proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proveedor` (
  `idproveedor` INT NOT NULL,
  `RUT` VARCHAR(45) NULL,
  `nombre` VARCHAR(45) NULL,
  `paginaWeb` VARCHAR(45) NULL,
  `telefono` VARCHAR(45) NULL,
  `ubicacion_idubicacion` INT NOT NULL,
  PRIMARY KEY (`idproveedor`),
  INDEX `fk_proveedor_ubicacion1_idx` (`ubicacion_idubicacion` ASC),
  CONSTRAINT `fk_proveedor_ubicacion1`
    FOREIGN KEY (`ubicacion_idubicacion`)
    REFERENCES `ubicacion` (`idubicacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);


-- -----------------------------------------------------
-- Table `tipo_producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tipo_producto` (
  `idtipo_producto` INT NOT NULL,
  `nombre_tipo` VARCHAR(45) NULL,
  `descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`idtipo_producto`)
);


-- -----------------------------------------------------
-- Table `Producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Producto` (
  `idProducto` INT NOT NULL,
  `nombre_producto` VARCHAR(45) NULL,
  `descripcion` VARCHAR(45) NULL,
  `precio` DECIMAL(10,2) NULL,
  `stock` INT NULL,
  `proveedor_idproveedor` INT NOT NULL,
  `tipo_producto_idtipo_producto` INT NOT NULL,
  PRIMARY KEY (`idProducto`),
  INDEX `fk_Producto_proveedor1_idx` (`proveedor_idproveedor` ASC),
  INDEX `fk_Producto_tipo_producto1_idx` (`tipo_producto_idtipo_producto` ASC),
  CONSTRAINT `fk_Producto_proveedor1`
    FOREIGN KEY (`proveedor_idproveedor`)
    REFERENCES `proveedor` (`idproveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Producto_tipo_producto1`
    FOREIGN KEY (`tipo_producto_idtipo_producto`)
    REFERENCES `tipo_producto` (`idtipo_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);


-- -----------------------------------------------------
-- Table `cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cliente` (
  `idcliente` INT NOT NULL,
  `RUT` VARCHAR(45) NULL,
  `nombre` VARCHAR(45) NULL,
  `ubicacion_idubicacion` INT NOT NULL,
  PRIMARY KEY (`idcliente`),
  INDEX `fk_cliente_ubicacion1_idx` (`ubicacion_idubicacion` ASC),
  CONSTRAINT `fk_cliente_ubicacion1`
    FOREIGN KEY (`ubicacion_idubicacion`)
    REFERENCES `ubicacion` (`idubicacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);


-- -----------------------------------------------------
-- Table `venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `venta` (
  `idventa` INT NOT NULL,
  `fecha_venta` DATE NULL,
  `cliente_idcliente` INT NOT NULL,
  PRIMARY KEY (`idventa`),
  INDEX `fk_venta_cliente1_idx` (`cliente_idcliente` ASC),
  CONSTRAINT `fk_venta_cliente1`
    FOREIGN KEY (`cliente_idcliente`)
    REFERENCES `cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);


-- -----------------------------------------------------
-- Table `Telefonos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Telefonos` (
  `idTelefonos` INT NOT NULL,
  `numero_telefono` VARCHAR(45) NULL,
  `cliente_idcliente` INT NOT NULL,
  PRIMARY KEY (`idTelefonos`),
  INDEX `fk_Telefonos_cliente1_idx` (`cliente_idcliente` ASC),
  CONSTRAINT `fk_Telefonos_cliente1`
    FOREIGN KEY (`cliente_idcliente`)
    REFERENCES `cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);


-- -----------------------------------------------------
-- Table `productos_venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `productos_venta` (
  `idproductos_venta` INT NOT NULL,
  `cantidad` INT NULL,
  `venta_idventa` INT NOT NULL,
  `Producto_idProducto` INT NOT NULL,
  PRIMARY KEY (`idproductos_venta`),
  INDEX `fk_productos_venta_venta1_idx` (`venta_idventa` ASC),
  INDEX `fk_productos_venta_Producto1_idx` (`Producto_idProducto` ASC),
  CONSTRAINT `fk_productos_venta_venta1`
    FOREIGN KEY (`venta_idventa`)
    REFERENCES `venta` (`idventa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_productos_venta_Producto1`
    FOREIGN KEY (`Producto_idProducto`)
    REFERENCES `Producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);


insert into ciudad values(1,'Bogota'),(2,'Medellin'),(3,'Cali');



insert into ubicacion values(1,54,'modelo',NULL,1),
(2,173,'cedritos','calle 173 con 25',1),(3,45,'modelo','edificio azul de 10 pisos',1),
(4,14,'13','comuna 13 calle 14',2),(5,25,'milagro','calle 25#10',2),
(6,73,'unidos',NULL,2),(7,99,'20','comuna 20 con calle 73',2),
(8,27,'jardines',NULL,3),(9,94,'ciudad jardin','barrio ciudad jardin',3),
(10,44,'20 julio','calle 44#3 barrio 20 de julio',3),
(11,25,'consuelo',NULL,3);


insert into proveedor values (1,1234,'mis muebles','www.mismuebles.com.co','+573212897044',5),
(2,4321,'laCantera','www.lacantera.co','+573103448070',10),
(3,4567,'puntolimpio','www.elpuntolimpio.com.co','+573003546789',7)
;


insert into tipo_producto values (1,'ASEO','utencilios de aseo'),
(2,'HOGAR','productos para el hogar'),(3,'electronicos','electrodomesticos y computadoras')
;

insert into producto values(1,'MESAPC2','mesa para computador',23500,10,1,2),
(2,'comedor1','comedor de 4 puestos',560000,4,1,2),
(3,'comedor2','comedor de 6 puestos',1263000,10,1,2),
(4,'MESAPC1','mesa para pc de vidrio',475200,5,1,2),
(5,'Limpiapisos','acido para limpiar las baldosas',45500,20,3,1),
(6,'espum','jabon para labar baños',23000,35,3,1),
(7,'microhondas1','microhondas marca samsung',250000,4,2,3),
(8,'microhondas2','microhondas marca glg',273000,5,2,3),
(9,'pcgamer','portatil para gamers',8572700,2,2,3),
(10,'pc','computador de mesa basico',1200000,6,2,3),
(11,'lavadora','lavadora marca samnsung',750000,1,2,3)
;


insert into cliente values (1,24275476,'Flor',1),
(2,1043567890,'Gloria',2),
(3,232829489,'Andres',3),
(4,98765423,'Carlos',1),
(5,23267893,'Hernando',4),
(6,98675409,'Maria',6),
(7,24201456,'Oscar',8),
(8,23257589,'Ricardo',9),
(9,21265478,'Helena',4),
(10,78234590,'Diego',11)
;


insert into telefonos values (1,'+573212893090',1),
(2,'+573212893344',1),
(3,'+573204827091',1),
(4,'+573004534023',2),
(5,'+573217634580',3),
(6,'+573217634582',3),
(7,'+573204237011',4),
(8,'+573235637180',5),
(9,'+573247634580',6),
(10,'+573208634780',7),
(11,'+573227534590',8),
(12,'+573207654582',9),
(13,'+573227644549',10)
;


insert into venta values (1,'2014-10-23',1),
(2,'2015-01-22',2),(3,'2015-02-12',3),
(4,'2015-03-03',1),(5,'2015-04-12',3),
(6,'2015-06-28',4),(7,'2015-07-12',5),
(8,'2015-07-20',6),(9,'2015-09-12',6),
(10,'2015-10-03',7),(11,'2015-12-12',8),
(12,'2016-01-22',10),(13,'2016-02-12',9),
(14,'2016-03-03',10),(15,'2016-04-12',9),
(16,'2016-06-28',2),(17,'2016-07-12',10),
(18,'2016-07-20',7),(19,'2016-09-12',1),
(20,'2016-10-03',7),(21,'2016-11-12',8),
(22,'2016-11-13',10),(23,'2016-12-01',4),
(24,'2016-12-03',7),(25,'2016-12-12',8)
;


insert into productos_venta values (1,2,1,1),(2,1,1,10),(3,1,1,9),
(4,1,2,5),(5,3,2,6),(6,1,2,11),
(7,1,3,7),
(8,1,4,8),(9,1,4,11),
(10,2,5,8),
(11,1,6,4),(12,1,6,10),
(13,1,7,11),(14,3,7,6),
(15,1,8,5),(16,3,8,6),(17,1,8,11),
(46,1,9,2),(55,1,9,3),
(18,1,10,7),(19,1,10,8),(20,2,10,5),
(21,2,11,1),(22,1,11,10),(23,1,11,9),
(24,1,12,5),(25,3,12,6),(26,1,12,11),
(27,1,13,7),
(28,1,14,8),(29,1,14,11),
(30,2,15,8),
(31,1,16,4),(32,1,16,10),
(33,1,17,11),(34,3,17,6),
(35,1,18,5),(36,3,8,6),(37,1,18,11),
(38,1,19,2),(39,1,19,5),(40,1,19,7),(41,1,19,11),
(42,1,20,7),(43,1,20,8),
(44,2,21,1),(45,1,21,10),
(47,1,22,5),(48,3,22,6),(49,1,22,11),
(50,1,23,7),
(51,1,24,8),(52,1,24,11),
(53,2,25,8),(54,1,25,4)
;
