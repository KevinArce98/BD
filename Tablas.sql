CREATE TABLE cliente
(
 id serial NOT NULL,
 nombre VARCHAR NOT NULL,
 apellido1 VARCHAR NOT NULL,
 apellido2 VARCHAR NOT NULL,
 telefono VARCHAR NOT NULL,
 montoLimite DOUBLE NOT NULL,
 direccion VARCHAR NOT NULL
);

ALTER TABLE cliente ADD CONSTRAINT pk_cliente PRIMARY KEY (id);

CREATE TABLE clienteDebe
(
 id serial NOT NULL,
 idCliente INT NOT NULL,
 montoDebe DOUBLE NOT NULL,
 fechaLimiteCancelar TIMESTAMP NOT NULL
);

ALTER TABLE clienteDebe ADD CONSTRAINT pk_clienteDebe PRIMARY KEY (id);

CREATE TABLE estadoCuenta(
id serial NOT NULL,
idCliente INT NOT NULL,
saldoAnterior DOUBLE NOT NULL,
abono DOUBLE NOT NULL,
saldoActual DOUBLE NOT NULL,
fechaHora TIMESTAMP NOT NULL
);

ALTER TABLE estadoCuenta ADD CONSTRAINT pk_estadoCuenta PRIMARY KEY (id);

CREATE TABLE cajas(
id serial NOT NULL,
codigo VARCHAR NOT NULL,
montoInicial DOUBLE NOT NULL
);

ALTER TABLE cajas ADD CONSTRAINT pk_cajas PRIMARY KEY (id);

CREATE TABLE detalleVenta(
id serial NOT NULL,
descripcion VARCHAR NOT NULL,
precio DOUBLE NOT NULL
cantidad INT NOT NULL,
impuestos DOUBLE NOT NULL,
codigoCaja VARCHAR NOT NULL
);

ALTER TABLE detalleVenta ADD CONSTRAINT pk_detalleVenta PRIMARY KEY (id);

CREATE TABLE entrada(
id serial NOT NULL,
descripcion VARCHAR NOT NULL,
monto DOUBLE NOT NULL,
fechaHora TIMESTAMP NOT NULL
);

ALTER TABLE entrada ADD CONSTRAINT pk_entrada PRIMARY KEY (id);

CREATE TABLE salidas(
id serial NOT NULL, 
descripcion VARCHAR NOT NULL,
monto DOUBLE NOT NULL,
fechaHora TIMESTAMP NOT NULL
);

ALTER TABLE salidas ADD CONSTRAINT pk_salidas PRIMARY KEY (id);


CREATE TABLE usuario(id serial NOT NULL , usuario VARCHAR NOT NULL,nombre VARCHAR NOT NULL , apellido VARCHAR NOT NULL , telefono INTEGER NOT NULL ,
 clave VARCHAR NOT NULL, idPuestos INTEGER NOT NULL);
 ALTER TABLE usuario ADD CONSTRAINT pk_idUsuario PRIMARY KEY(id);


 CREATE TABLE puesto(id SERIAL NOT NULL, puesto VARCHAR NOT NULL);
 ALTER TABLE puesto ADD CONSTRAINT pk_idPuesto PRIMARY KEY(id);


 CREATE TABLE  producto(codigo VARCHAR NOT NULL, descripcion VARCHAR NOT NULL, costoBase DOUBLE NOT NULL, precioVenta DOUBLE NOT NULL, cantidad DOUBLE NOT NULL, enStock INTEGER NOT NULL);
 ALTER TABLE producto ADD CONSTRAINT pk_codigoProducto PRIMARY KEY(codigo);


 CREATE TABLE ticket(id SERIAL NOT NULL, nombre VARCHAR NOT NULL, localidad VARCHAR NOT NULL, direccion VARCHAR NOT NULL, propietario VARCHAR NOT NULL, telefono INTEGER NOT NULL, mensajefinal VARCHAR NOT NULL, ultimalinea VARCHAR NOT NULL);
 ALTER TABLE ticket ADD CONSTRAINT pk_idTicket PRIMARY KEY(id);


 CREATE TABLE ventaContado(id SERIAL NOT NULL , idTicket INTEGER NOT NULL, monto DOUBLE NOT NULL, pagaCon DOUBLE NOT NULL, suVuelto DOUBLE NOT NULL, codigoCaja VARCHAR NOT NULL);
 ALTER TABLE ventaContado ADD CONSTRAINT pk_idVentaContado PRIMARY KEY(id);

 CREATE TABLE ventaCredito(id SERIAL NOT NULL, idTicket INTEGER NOT NULL, monto DOUBLE NOT NULL, idCliente INTEGER NOT NULL,idUsuario INTEGER NOT NULL,codigoCaja VARCHAR NOT NULL);
 ALTER TABLE ventaCredito ADD CONSTRAINT pk_idVentaCredito PRIMARY KEY(id);


  CREATE TABLE venta(id SERIAL NOT NULL, fecha_hora TIMESTAMP NOT NULL, tipoPago VARCHAR NOT NULL, idUsuario INTEGER NOT NULL , codigo_caja VARCHAR NOT NULL, idDetalleVenta INTEGER NOT NULL);
  ALTER TABLE venta ADD CONSTRAINT pk_idVenta PRIMARY KEY(id);

 CREATE TABLE  proveedor(codigo VARCHAR NOT NULL, nombre VARCHAR NOT NULL, direccion VARCHAR NOT NULL, telefono INTEGER NOT NULL, fechaPedido TIMESTAMP NOT NULL,compannia VARCHAR NOT NULL );
 ALTER TABLE proveedor ADD CONSTRAINT pk_codProveedor PRIMARY KEY (codigo);