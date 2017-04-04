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
