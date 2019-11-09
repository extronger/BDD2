CREATE TABLE COMUNA(
    idcomuna INTEGER PRIMARY KEY,
    nombre VARCHAR(20),
    idregion INTEGER,
    FOREIGN KEY (idregion) REFERENCES REGION(idRegion)
);

CREATE TABLE REGION(
    idRegion INTEGER PRIMARY KEY,
    nombre VARCHAR(20)
);

CREATE TABLE LOCALES(
    idlocal INTEGER PRIMARY KEY,
    nombre VARCHAR(20),
    localidad VARCHAR(20),
    idComuna INTEGER,
    FOREIGN KEY (idComuna) REFERENCES COMUNA(idComuna)
);

CREATE TABLE CATEGORIA(
    idCategoria INTEGER PRIMARY KEY,
    descripcion VARCHAR(20)
);

CREATE TABLE SUBCATEGORIA(
    idSubCat INTEGER PRIMARY KEY,
    descripcion VARCHAR(20),
    idCategoria INTEGER,
    FOREIGN KEY (idCategoria) REFERENCES CATEGORIA(idCategoria)
);

CREATE TABLE PRODUCTO(
    idProducto INTEGER PRIMARY KEY,
    descripcion VARCHAR(30),
    uMedida VARCHAR(10),
    idSubCat INTEGER,
    FOREIGN KEY (idSubCat) REFERENCES SUBCATEGORIA(idSubCat)
);

CREATE TABLE VENTAS(
    fecha DATE,
    idproducto INTEGER,
    idlocal INTEGER,
    cantidad INTEGER,
    montoVenta INTEGER,
    FOREIGN KEY(idproducto) REFERENCES PRODUCTO(idproducto),
    FOREIGN KEY (idlocal) REFERENCES LOCALES(idlocal)
);
---------
--INSERT
---------
INSERT ALL 
INTO REGION(idRegion, nombre) VALUES (1,'ARICA Y PARINACOTA')         
INTO REGION(idRegion, nombre) VALUES (2,'TARAPACÁ')
INTO REGION(idRegion, nombre) VALUES (3,'ANTOFAGASTA')
INTO REGION(idRegion, nombre) VALUES (4,'ATACAMA')
INTO REGION(idRegion, nombre) VALUES (5,'COQUIMBO')
INTO REGION(idRegion, nombre) VALUES (6,'VALPARAÍSO')
INTO REGION(idRegion, nombre) VALUES (7,'DEL LIBERTADOR GRAL')
INTO REGION(idRegion, nombre) VALUES (8,'DEL MAULE')
INTO REGION(idRegion, nombre) VALUES (9,'DEL BIOBÍO')
INTO REGION(idRegion, nombre) VALUES (10,'DE LA ARAUCANÍA')
INTO REGION(idRegion, nombre) VALUES (11,'DE LOS RÍOS')
INTO REGION(idRegion, nombre) VALUES (12,'DE LOS LAGOS')
INTO REGION(idRegion, nombre) VALUES (13,'AISÉN')
INTO REGION(idRegion, nombre) VALUES (14,'MAGALLANES')
INTO REGION(idRegion, nombre) VALUES (15,'SANTIAGO')
SELECT * FROM DUAL;

INSERT ALL
INTO COMUNA(idComuna, nombre, idRegion) VALUES (1, 'Chillan', 9)
INTO COMUNA(idComuna, nombre, idRegion) VALUES (2, 'Puerto Varas', 12)
INTO COMUNA(idComuna, nombre, idRegion) VALUES (3, 'Temuco', 10)
INTO COMUNA(idComuna, nombre, idRegion) VALUES (4, 'Santiago', 15)
SELECT * FROM DUAL;

INSERT ALL
INTO LOCALES(idLocal, nombre, localidad, idComuna) VALUES (1, 'PcFactory', 'El Roble 856', 1)
INTO LOCALES(idLocal, nombre, localidad, idComuna) VALUES (2, 'SpDigital', 'Padre Mariano 356', 4)
INTO LOCALES(idLocal, nombre, localidad, idComuna) VALUES (3, 'TtChile', ' Av. Salvador 465', 4)
SELECT * FROM DUAL;

INSERT ALL
INTO CATEGORIA(idCategoria, descripcion) VALUES (1, 'Partes y piezas pc')
INTO CATEGORIA(idCategoria, descripcion) VALUES (2, 'Conectividad y Redes')
INTO CATEGORIA(idCategoria, descripcion) VALUES (3, 'Almacenamiento')
INTO CATEGORIA(idCategoria, descripcion) VALUES (4, 'Software')
INTO CATEGORIA(idCategoria, descripcion) VALUES (5, 'Accesorios')
SELECT * FROM DUAL;

INSERT ALL
INTO SUBCATEGORIA(idSubCat, descripcion, idCategoria) VALUES (1, 'Procesadores', 1)
INTO SUBCATEGORIA(idSubCat, descripcion, idCategoria) VALUES (2, 'Tarjetas graficas', 1)
INTO SUBCATEGORIA(idSubCat, descripcion, idCategoria) VALUES (3, 'Routers', 2)
INTO SUBCATEGORIA(idSubCat, descripcion, idCategoria) VALUES (4, 'Switches', 2)
INTO SUBCATEGORIA(idSubCat, descripcion, idCategoria) VALUES (5, 'Discos SSD', 3)
INTO SUBCATEGORIA(idSubCat, descripcion, idCategoria) VALUES (6, 'Discos externos', 3)
INTO SUBCATEGORIA(idSubCat, descripcion, idCategoria) VALUES (7, 'Antivirus', 4)
INTO SUBCATEGORIA(idSubCat, descripcion, idCategoria) VALUES (8, 'Sistemas operativos', 4)
INTO SUBCATEGORIA(idSubCat, descripcion, idCategoria) VALUES (9, 'Mouse y teclados', 5)
INTO SUBCATEGORIA(idSubCat, descripcion, idCategoria) VALUES (10, 'Cables y adaptadores', 5)
SELECT * FROM DUAL;

INSERT ALL
INTO PRODUCTO(idProducto, descripcion, uMedida, idSubCat) VALUES (1, 'Ryzen 3 2200g', 'kilos', 1)
INTO PRODUCTO(idProducto, descripcion, uMedida, idSubCat) VALUES (2, 'Ryzen 5 2400g', 'kilos', 1)
INTO PRODUCTO(idProducto, descripcion, uMedida, idSubCat) VALUES (3, 'Core i5-8400', 'kilos', 1)
INTO PRODUCTO(idProducto, descripcion, uMedida, idSubCat) VALUES (4, 'Nvidia GTX1660ti', 'kilos', 2)
INTO PRODUCTO(idProducto, descripcion, uMedida, idSubCat) VALUES (5, 'Nvidia GTX1080i', 'kilos', 2)
INTO PRODUCTO(idProducto, descripcion, uMedida, idSubCat) VALUES (6, 'AMD RX 580', 'kilos', 2)
INTO PRODUCTO(idProducto, descripcion, uMedida, idSubCat) VALUES (7, 'Dlink N150', 'kilos', 3)
INTO PRODUCTO(idProducto, descripcion, uMedida, idSubCat) VALUES (8, 'TPLink N300TL', 'kilos', 3)
INTO PRODUCTO(idProducto, descripcion, uMedida, idSubCat) VALUES (9, 'Lynksys N300 E900', 'kilos', 3)
INTO PRODUCTO(idProducto, descripcion, uMedida, idSubCat) VALUES (10, 'Asus N300', 'kilos', 4)
INTO PRODUCTO(idProducto, descripcion, uMedida, idSubCat) VALUES (11, 'TPLink N450', 'kilos', 4)
INTO PRODUCTO(idProducto, descripcion, uMedida, idSubCat) VALUES (12, 'Asus Dual-Band AC10', 'kilos', 4)
INTO PRODUCTO(idProducto, descripcion, uMedida, idSubCat) VALUES (13, 'Crucial 120GB 2.5', 'kilos', 5)
INTO PRODUCTO(idProducto, descripcion, uMedida, idSubCat) VALUES (14, 'Kingston 240GB 2.5', 'kilos', 5)
INTO PRODUCTO(idProducto, descripcion, uMedida, idSubCat) VALUES (15, 'Crucial 240GB M.2', 'kilos', 5)
INTO PRODUCTO(idProducto, descripcion, uMedida, idSubCat) VALUES (16, 'WD 750GB USB 3.0', 'kilos', 6)
INTO PRODUCTO(idProducto, descripcion, uMedida, idSubCat) VALUES (17, 'Toshiba 1TB USB 3.0', 'kilos', 6)
INTO PRODUCTO(idProducto, descripcion, uMedida, idSubCat) VALUES (18, 'WD 1TB USB 3.0', 'kilos', 6)
INTO PRODUCTO(idProducto, descripcion, uMedida, idSubCat) VALUES (19, 'Panda Dome', 'kilos', 7)
INTO PRODUCTO(idProducto, descripcion, uMedida, idSubCat) VALUES (20, 'Eset NOD32 HOME', 'kilos', 7)
INTO PRODUCTO(idProducto, descripcion, uMedida, idSubCat) VALUES (21, 'Kaspersky PRO', 'kilos', 7)
INTO PRODUCTO(idProducto, descripcion, uMedida, idSubCat) VALUES (22, 'Windows 10 HOME', 'kilos', 8)
INTO PRODUCTO(idProducto, descripcion, uMedida, idSubCat) VALUES (23, 'Windows 10 PRO GGK', 'kilos', 8)
INTO PRODUCTO(idProducto, descripcion, uMedida, idSubCat) VALUES (24, 'Windows Server', 'kilos', 8)
INTO PRODUCTO(idProducto, descripcion, uMedida, idSubCat) VALUES (25, 'Logitech G Pro', 'kilos', 9)
INTO PRODUCTO(idProducto, descripcion, uMedida, idSubCat) VALUES (26, 'Logitech G 402', 'kilos', 9)
INTO PRODUCTO(idProducto, descripcion, uMedida, idSubCat) VALUES (27, 'Razer Naga', 'kilos', 9)
INTO PRODUCTO(idProducto, descripcion, uMedida, idSubCat) VALUES (28, 'Cable UTP Cat5e', 'kilos', 10)
INTO PRODUCTO(idProducto, descripcion, uMedida, idSubCat) VALUES (29, 'Conector RJ45', 'kilos', 10)
INTO PRODUCTO(idProducto, descripcion, uMedida, idSubCat) VALUES (30, 'Cable SATA', 'kilos', 10)
SELECT * FROM DUAL;





