-------Esquemas-----
CREATE SCHEMA admin;
CREATE SCHEMA usuarios;
CREATE SCHEMA clientes;

----Cambio Esquema-----
SET search_path = clientes;
---Tablas Esquema Cliente---
CREATE TABLE cliente
(
 id serial NOT NULL,
 nombre VARCHAR NOT NULL,
 apellido1 VARCHAR NOT NULL,
 apellido2 VARCHAR NOT NULL,
 telefono VARCHAR NOT NULL,
 montoLimite DOUBLE PRECISION NOT NULL,
 direccion VARCHAR NOT NULL
);

ALTER TABLE cliente ADD CONSTRAINT pk_cliente PRIMARY KEY (id);

CREATE TABLE clienteDebe
(
 id serial NOT NULL,
 idCliente INT NOT NULL,
 montoDebe DOUBLE PRECISION NOT NULL,
 fechaLimiteCancelar TIMESTAMP NOT NULL
);

ALTER TABLE clienteDebe ADD CONSTRAINT pk_clienteDebe PRIMARY KEY (id);

----Cambio Esquema-----
SET search_path = admin;
---Tablas Esquema Admin---

CREATE TABLE caja(
id serial NOT NULL,
codigo VARCHAR NOT NULL,
montoInicial DOUBLE PRECISION NOT NULL
);

ALTER TABLE caja ADD CONSTRAINT pk_caja PRIMARY KEY (id);

CREATE TABLE entrada(
id serial NOT NULL,
descripcion VARCHAR NOT NULL,
monto DOUBLE PRECISION NOT NULL,
fechaHora TIMESTAMP NOT NULL
);

ALTER TABLE entrada ADD CONSTRAINT pk_entrada PRIMARY KEY (id);

CREATE TABLE salida(
id serial NOT NULL, 
descripcion VARCHAR NOT NULL,
monto DOUBLE PRECISION NOT NULL,
fechaHora TIMESTAMP NOT NULL
);

ALTER TABLE salida ADD CONSTRAINT pk_salida PRIMARY KEY (id);

 CREATE TABLE  producto(
 codigo VARCHAR NOT NULL, 
 descripcion VARCHAR NOT NULL, 
 costoBase DOUBLE PRECISION NOT NULL, 
 precioVenta DOUBLE PRECISION NOT NULL, 
 cantidad DOUBLE PRECISION NOT NULL, 
 enStock INTEGER NOT NULL
 );
 ALTER TABLE producto ADD CONSTRAINT pk_codigoProducto PRIMARY KEY(codigo);

  CREATE TABLE ticket(
 id SERIAL NOT NULL, 
 nombre VARCHAR NOT NULL, 
 localidad VARCHAR NOT NULL, 
 direccion VARCHAR NOT NULL, 
 propietario VARCHAR NOT NULL, 
 telefono INTEGER NOT NULL, 
 mensajefinal VARCHAR NOT NULL, 
 ultimalinea VARCHAR NOT NULL
 );
 ALTER TABLE ticket ADD CONSTRAINT pk_idTicket PRIMARY KEY(id);
 
  CREATE TABLE  proveedor(
 codigo VARCHAR NOT NULL, 
 nombre VARCHAR NOT NULL, 
 direccion VARCHAR NOT NULL, 
 telefono INTEGER NOT NULL, 
 fechaPedido TIMESTAMP NOT NULL,
 compannia VARCHAR NOT NULL 
 );
 ALTER TABLE proveedor ADD CONSTRAINT pk_codProveedor PRIMARY KEY (codigo);
 
----Cambio Esquema-----
SET search_path = usuarios;
---Tablas Esquema Usuarios---

CREATE TABLE estadoCuenta(
id serial NOT NULL,
idCliente INT NOT NULL,
saldoAnterior DOUBLE PRECISION NOT NULL,
abono DOUBLE PRECISION NOT NULL,
saldoActual DOUBLE PRECISION NOT NULL,
fechaHora TIMESTAMP NOT NULL
);

ALTER TABLE estadoCuenta ADD CONSTRAINT pk_estadoCuenta PRIMARY KEY (id);


CREATE TABLE detalleVenta(
id serial NOT NULL,
descripcion VARCHAR NOT NULL,
precio DOUBLE PRECISION NOT NULL,
cantidad INT NOT NULL,
impuestos DOUBLE PRECISION NOT NULL,
codigoCaja VARCHAR NOT NULL
);

ALTER TABLE detalleVenta ADD CONSTRAINT pk_detalleVenta PRIMARY KEY (id);


CREATE TABLE usuario(
id serial NOT NULL , 
usuario VARCHAR NOT NULL,
nombre VARCHAR NOT NULL , 
apellido VARCHAR NOT NULL, 
telefono INTEGER NOT NULL,
 clave VARCHAR NOT NULL, 
 idPuestos INTEGER NOT NULL
 );
 ALTER TABLE usuario ADD CONSTRAINT pk_idUsuario PRIMARY KEY(id);


 CREATE TABLE puesto(
 id SERIAL NOT NULL, 
 puesto VARCHAR NOT NULL
 );
 ALTER TABLE puesto ADD CONSTRAINT pk_idPuesto PRIMARY KEY(id);

 CREATE TABLE ventaContado(
 id SERIAL NOT NULL, 
 idTicket INTEGER NOT NULL, 
 monto DOUBLE PRECISION NOT NULL, 
 pagaCon DOUBLE PRECISION NOT NULL, 
 suVuelto DOUBLE PRECISION NOT NULL, 
 codigoCaja VARCHAR NOT NULL
 );
 ALTER TABLE ventaContado ADD CONSTRAINT pk_idVentaContado PRIMARY KEY(id);

 CREATE TABLE ventaCredito(
 id SERIAL NOT NULL, 
 idTicket INTEGER NOT NULL, 
 monto DOUBLE PRECISION NOT NULL, 
 idCliente INTEGER NOT NULL,
 idUsuario INTEGER NOT NULL,
 codigoCaja VARCHAR NOT NULL
 );
 ALTER TABLE ventaCredito ADD CONSTRAINT pk_idVentaCredito PRIMARY KEY(id);


  CREATE TABLE venta(
  id SERIAL NOT NULL, 
  fecha_hora TIMESTAMP NOT NULL, 
  tipoPago VARCHAR NOT NULL, 
  idUsuario INTEGER NOT NULL , 
  codigo_caja VARCHAR NOT NULL, 
  idDetalleVenta INTEGER NOT NULL
  );
  ALTER TABLE venta ADD CONSTRAINT pk_idVenta PRIMARY KEY(id);

