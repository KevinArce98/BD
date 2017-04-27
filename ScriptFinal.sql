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

ALTER TABLE caja ADD CONSTRAINT pk_caja PRIMARY KEY (codigo);

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

---------------FOREIGN KEY---------------------

set search_path = clientes;

ALTER TABLE clienteDebe ADD CONSTRAINT fk_cliente FOREIGN KEY (idCliente)
REFERENCES cliente (id);

set search_path = usuarios;

ALTER TABLE estadoCuenta ADD CONSTRAINT fk_cliente FOREIGN KEY (idCliente)
REFERENCES clientes.cliente (id);

ALTER TABLE detalleVenta ADD CONSTRAINT fk_caja FOREIGN KEY (codigoCaja)
REFERENCES admin.caja (codigo);

ALTER TABLE usuario ADD CONSTRAINT fk_puesto FOREIGN KEY (idPuestos)
REFERENCES puesto (id);

ALTER TABLE ventaContado ADD CONSTRAINT fk_ticket FOREIGN KEY (idTicket)
REFERENCES admin.ticket (id);

ALTER TABLE ventaContado ADD CONSTRAINT fk_caja FOREIGN KEY (codigoCaja)
REFERENCES admin.caja (codigo);

ALTER TABLE ventaCredito ADD CONSTRAINT fk_ticket FOREIGN KEY (idTicket)
REFERENCES admin.ticket (id);

ALTER TABLE ventaCredito ADD CONSTRAINT fk_cliente FOREIGN KEY (idCliente)
REFERENCES clientes.cliente (id);

ALTER TABLE ventaCredito ADD CONSTRAINT fk_usuario FOREIGN KEY (idUsuario)
REFERENCES usuarios.usuario (id);

ALTER TABLE ventaCredito ADD CONSTRAINT fk_caja FOREIGN KEY (codigoCaja)
REFERENCES admin.caja (codigo);

ALTER TABLE venta ADD CONSTRAINT fk_usuario FOREIGN KEY (idUsuario)
REFERENCES usuarios.usuario (id);

ALTER TABLE venta ADD CONSTRAINT fk_detalleVenta FOREIGN KEY (idDetalleVenta)
REFERENCES detalleVenta (id);

ALTER TABLE venta ADD CONSTRAINT fk_caja FOREIGN KEY (codigo_caja)
REFERENCES admin.caja (codigo);
----------------------------------------

set search_path = clientes;
--------------------funciones Cliente-------------------------------
CREATE OR REPLACE FUNCTION insertarCliente(nombre VARCHAR, apellido1 VARCHAR, apellido2 VARCHAR, telefono VARCHAR, montolimite DOUBLE PRECISION, direccion VARCHAR)  RETURNS INTEGER AS 
$clienteTrigger$
DECLARE ID INTEGER;
BEGIN
INSERT INTO clientes.cliente("nombre", "apellido1", "apellido2", "telefono", "montolimite", "direccion")
VALUES (nombre, apellido1, apellido2, telefono, montolimite, direccion);
ID = (SELECT currval('clientes.cliente_id_seq'));
RETURN ID;
END
$clienteTrigger$ language plpgsql;

CREATE OR REPLACE FUNCTION updateCliente(pNombre VARCHAR, pApellido1 VARCHAR, pApellido2 VARCHAR, pTelefono VARCHAR, monto DOUBLE PRECISION, pDireccion VARCHAR, pId INT)  RETURNS VARCHAR AS 
$clienteTrigger$
BEGIN
UPDATE clientes.cliente SET "nombre" = pNombre, "apellido1" = pApellido1, "apellido2"=pApellido2, "telefono"=pTelefono, "montolimite"=monto, "direccion"=pDireccion
 WHERE "id" = pId ;
 RETURN 'Modificado';
END
$clienteTrigger$ language plpgsql;

CREATE OR REPLACE FUNCTION deleteCliente(pId INT)  RETURNS VARCHAR AS 
$$
BEGIN
DELETE FROM clientes.cliente WHERE "id" = pId ;
RETURN 'Elimidano';
END
$$ language plpgsql;

CREATE OR REPLACE FUNCTION validaCliente()  RETURNS TRIGGER AS 
$$
DECLARE bandera boolean;
BEGIN
 bandera:= false;
 IF (TG_OP = 'INSERT') THEN
	IF(NEW.nombre = '' OR NEW.apellido1 = ''OR NEW.apellido2 = ''OR NEW.telefono = ''OR NEW.montolimite < 0 OR NEW.direccion = '') THEN
		bandera := true;
		RAISE NOTICE 'Datos invalidos';
	END IF;
	IF(bandera = false) THEN
	RAISE NOTICE 'AGREGADO';
	RETURN NEW;
	END IF;
  END IF;
IF (TG_OP = 'UPDATE') THEN
	IF(NEW.nombre = '' OR NEW.apellido1 = ''OR NEW.apellido2 = ''OR NEW.telefono = ''OR NEW.montolimite < 0 OR NEW.direccion = '') THEN
		bandera := true;
		RAISE NOTICE 'Datos invalidos';
	END IF;
	IF(bandera = false) THEN
	RAISE NOTICE 'ACTUALIZADO';
	RETURN NEW;
	END IF;
  END IF;
END
$$ language plpgsql;

CREATE TRIGGER clienteTrigger AFTER INSERT OR UPDATE
    ON clientes.cliente FOR EACH ROW 
    EXECUTE PROCEDURE validaCliente();
-------------------------------------------------------------------------------------------------
--DROP TRIGGER clienteTrigger ON clientes.cliente;
--DROP FUNCTION insertarCliente(character varying,character varying,character varying,character varying,double precision,character varying);
--DROP FUNCTION updatecliente(nombre VARCHAR, apellido1 VARCHAR, apellido2 VARCHAR, telefono VARCHAR, montolimite DOUBLE PRECISION, direccion VARCHAR, id INT); 
--DROP FUNCTION deleteCliente(int);

--------------------funciones ClienteDebe-------------------------------
CREATE OR REPLACE FUNCTION insertClienteDebe(pIdCliente INT, monto DOUBLE PRECISION, fecha DATE)  RETURNS INTEGER AS 
$clienteDebeTrigger$
DECLARE ID INTEGER;
BEGIN
INSERT INTO clientes.clientedebe("idcliente", "montodebe", "fechalimitecancelar")
VALUES (pIdCliente, monto, fecha);
ID = (SELECT currval('clientes.clientedebe_id_seq'));
RETURN ID;
END
$clienteDebeTrigger$ language plpgsql;

CREATE OR REPLACE FUNCTION updateClienteDebe(pIdCliente INT, monto DOUBLE PRECISION, fecha TIMESTAMP, pId INT)  RETURNS VOID AS 
$clienteDebeTrigger$
BEGIN
UPDATE clientes.clientedebe SET "idcliente" = pIdCliente, "montodebe" = monto, "fechalimitecancelar" = fecha
 WHERE "id" = pId ;
END
$clienteDebeTrigger$ language plpgsql;

CREATE OR REPLACE FUNCTION deleteClienteDebe(pId INT)  RETURNS VARCHAR AS 
$$
BEGIN
DELETE FROM clientes.clientedebe WHERE "id" = pId ;
RETURN 'Elimidano';
END
$$ language plpgsql;

CREATE OR REPLACE FUNCTION validaClienteDebe()  RETURNS TRIGGER AS 
$$
DECLARE bandera boolean;
BEGIN
 bandera:= false;
 IF (TG_OP = 'INSERT') THEN
	IF(NEW.idcliente <= 0 OR NEW.montodebe < 0 OR NEW.fechalimitecancelar <= NOW()) THEN
		bandera := true;
		RAISE NOTICE 'Datos invalidos';
	END IF;
	IF(bandera = false) THEN
	RAISE NOTICE 'AGREGADO';
	RETURN NEW;
	END IF;
  END IF;
IF (TG_OP = 'UPDATE') THEN
	IF(NEW.idcliente <= 0 OR NEW.montodebe < 0 OR NEW.fechalimitecancelar <= NOW()) THEN
		bandera := true;
		RAISE NOTICE 'Datos invalidos';
	END IF;
	IF(bandera = false) THEN
	RAISE NOTICE 'ACTUALIZADO';
	RETURN NEW;
	END IF;
  END IF;
END
$$ language plpgsql;

CREATE TRIGGER clienteDebeTrigger AFTER INSERT OR UPDATE
    ON clientes.clientedebe FOR EACH ROW 
    EXECUTE PROCEDURE validaClienteDebe();
-------------------------------------------------------------------------------------------------
--DROP TRIGGER clienteDebeTrigger ON clientes.clientedebe;
--DROP FUNCTION insertClienteDebe(pIdCliente INT, monto DOUBLE PRECISION, fecha TIMESTAMP);
--DROP FUNCTION updateClienteDebe(pIdCliente INT, monto DOUBLE PRECISION, fecha TIMESTAMP, pId INT); 
--DROP FUNCTION deleteClienteDebe(int);
set search_path = admin;
--------------------funciones caja-------------------------------
CREATE OR REPLACE FUNCTION insertCaja(pCodigo VARCHAR, monto DOUBLE PRECISION)  RETURNS INTEGER AS 
$cajaTrigger$
DECLARE ID INTEGER;
BEGIN
INSERT INTO admin.caja("codigo", "montoinicial")
VALUES (pCodigo, monto);
ID = (SELECT currval('admin.caja_id_seq'));
RETURN ID;
END
$cajaTrigger$ language plpgsql;

CREATE OR REPLACE FUNCTION updateCaja(pCodigo VARCHAR, monto DOUBLE PRECISION, pId INT)  RETURNS VOID AS 
$cajaTrigger$
BEGIN
UPDATE admin.caja SET "codigo" = pCodigo, "montoinicial" = monto
 WHERE "id" = pId ;
END
$cajaTrigger$ language plpgsql;

CREATE OR REPLACE FUNCTION deleteCaja(pCodigo VARCHAR)  RETURNS VARCHAR AS 
$$
BEGIN
DELETE FROM admin.caja WHERE "codigo" = pCodigo ;
RETURN 'Elimidano';
END
$$ language plpgsql;

CREATE OR REPLACE FUNCTION validaCaja()  RETURNS TRIGGER AS 
$$
DECLARE bandera boolean;
BEGIN
 bandera:= false;
 IF (TG_OP = 'INSERT') THEN
	IF(NEW.codigo = '' OR NEW.montoinicial < 0) THEN
		bandera := true;
		RAISE NOTICE 'Datos invalidos';
	END IF;
	IF(bandera = false) THEN
	RAISE NOTICE 'AGREGADO';
	RETURN NEW;
	END IF;
  END IF;
IF (TG_OP = 'UPDATE') THEN
	IF(NEW.codigo = '' OR NEW.montoinicial < 0) THEN
		bandera := true;
		RAISE NOTICE 'Datos invalidos';
	END IF;
	IF(bandera = false) THEN
	RAISE NOTICE 'ACTUALIZADO';
	RETURN NEW;
	END IF;
  END IF;
END
$$ language plpgsql;

CREATE TRIGGER cajaTrigger AFTER INSERT OR UPDATE
    ON admin.caja FOR EACH ROW 
    EXECUTE PROCEDURE validaCaja();
-------------------------------------------------------------------------------------------------
--DROP TRIGGER cajaTrigger ON admin.caja;
--DROP FUNCTION insertCaja(pCodigo VARCHAR, monto DOUBLE PRECISION);
--DROP FUNCTION updateCaja(pCodigo VARCHAR, monto DOUBLE PRECISION, pId INT); 
--DROP FUNCTION deleteCaja(int);

-------------------funciones entrada-------------------------------
CREATE OR REPLACE FUNCTION insertEntrada(pDescripcion VARCHAR, pMonto DOUBLE PRECISION, fecha TIMESTAMP)  RETURNS INTEGER AS 
$entradaTrigger$
DECLARE ID INTEGER;
BEGIN
INSERT INTO admin.entrada("descripcion", "monto", "fechahora")
VALUES (pDescripcion, pMonto, fecha);
ID = (SELECT currval('admin.entrada_id_seq'));
RETURN ID;
END
$entradaTrigger$ language plpgsql;

CREATE OR REPLACE FUNCTION updateEntrada(pDescripcion VARCHAR, pMonto DOUBLE PRECISION, fecha TIMESTAMP, pId INT)  RETURNS VOID AS 
$entradaTrigger$
BEGIN
UPDATE admin.entrada SET "descripcion" = pDescripcion, "monto" = pMonto, "fechahora" = fecha
 WHERE "id" = pId ;
END
$entradaTrigger$ language plpgsql;

CREATE OR REPLACE FUNCTION deleteEntrada(pId INT)  RETURNS VARCHAR AS 
$$
BEGIN
DELETE FROM admin.entrada WHERE "id" = pId ;
RETURN 'Elimidano';
END
$$ language plpgsql;

CREATE OR REPLACE FUNCTION validaEntrada()  RETURNS TRIGGER AS 
$$
DECLARE bandera boolean;
BEGIN
 bandera:= false;
 IF (TG_OP = 'INSERT') THEN
	IF(NEW.descripcion = '' OR NEW.monto < 0) THEN
		bandera := true;
		RAISE NOTICE 'Datos invalidos';
	END IF;
	IF(bandera = false) THEN
	RAISE NOTICE 'AGREGADO';
	RETURN NEW;
	END IF;
  END IF;
IF (TG_OP = 'UPDATE') THEN
	IF(NEW.descripcion = '' OR NEW.monto < 0) THEN
		bandera := true;
		RAISE NOTICE 'Datos invalidos';
	END IF;
	IF(bandera = false) THEN
	RAISE NOTICE 'ACTUALIZADO';
	RETURN NEW;
	END IF;
  END IF;
END
$$ language plpgsql;

CREATE TRIGGER entradaTrigger AFTER INSERT OR UPDATE
    ON admin.entrada FOR EACH ROW 
    EXECUTE PROCEDURE validaEntrada();
-------------------------------------------------------------------------------------------------
--DROP TRIGGER entradaTrigger ON admin.entrada;
--DROP FUNCTION insertEntrada(pDescripcion VARCHAR, pMonto DOUBLE PRECISION, fecha TIMESTAMP);
--DROP FUNCTION updateEntrada(pDescripcion VARCHAR, pMonto DOUBLE PRECISION, fecha TIMESTAMP, pId INT); 
--DROP FUNCTION deleteEntrada(int);


-------------------funciones producto-------------------------------
CREATE OR REPLACE FUNCTION insertProducto(pCodigo VARCHAR, pDescripcion VARCHAR, pCostobase double precision, pPrecioventa double precision, pPantidad double precision, pEnstock integer)  RETURNS VARCHAR AS 
$productoTrigger$
DECLARE Codigo VARCHAR;
BEGIN
INSERT INTO admin.producto("codigo", "descripcion", "costobase", "precioventa", "cantidad", "enstock") VALUES (pCodigo, pDescripcion, pCostobase, pPrecioventa, pPantidad, pEnstock);
Codigo = pCodigo;
RETURN Codigo;
END
$productoTrigger$ language plpgsql;

CREATE OR REPLACE FUNCTION updateProducto(pCodigo VARCHAR, pDescripcion VARCHAR, pCostobase double precision, pPrecioventa double precision, pPantidad double precision, pEnstock integer)  RETURNS VOID AS 
$productoTrigger$
BEGIN
UPDATE admin.producto SET "descripcion" = pDescripcion, "costobase" = pCostobase,"precioventa" = pPrecioventa,"cantidad" = pPantidad,"enstock" = pEnstock
 WHERE "codigo" = pCodigo;
END
$productoTrigger$ language plpgsql;

CREATE OR REPLACE FUNCTION deleteProducto(pCodigo VARCHAR)  RETURNS VARCHAR AS 
$$
BEGIN
DELETE FROM admin.producto WHERE "codigo" = pCodigo;
RETURN 'Elimidano';
END
$$ language plpgsql;

CREATE OR REPLACE FUNCTION validaProducto()  RETURNS TRIGGER AS 
$$
DECLARE bandera boolean;
BEGIN
 bandera:= false;
 IF (TG_OP = 'INSERT') THEN
	IF(NEW.codigo = '' OR NEW.descripcion = '' OR NEW.costobase < 0 OR NEW.precioventa < 0 OR NEW.cantidad < 0 OR NEW.enstock < 0) THEN
		bandera := true;
		RAISE NOTICE 'Datos invalidos';
	END IF;
	IF(bandera = false) THEN
	RAISE NOTICE 'AGREGADO';
	RETURN NEW;
	END IF;
  END IF;
IF (TG_OP = 'UPDATE') THEN
IF(NEW.codigo = '' OR NEW.descripcion = '' OR NEW.costobase < 0 OR NEW.precioventa < 0 OR NEW.cantidad < 0 OR NEW.enstock < 0) THEN
		bandera := true;
		RAISE NOTICE 'Datos invalidos';
	END IF;
	IF(bandera = false) THEN
	RAISE NOTICE 'ACTUALIZADO';
	RETURN NEW;
	END IF;
  END IF;
END
$$ language plpgsql;

CREATE TRIGGER productoTrigger AFTER INSERT OR UPDATE
    ON admin.producto FOR EACH ROW 
    EXECUTE PROCEDURE validaProducto();
-------------------------------------------------------------------------------------------------
--DROP TRIGGER productoTrigger ON admin.producto;
--DROP FUNCTION insertProducto(pCodigo VARCHAR, pDescripcion VARCHAR, pCostobase double precision, pPrecioventa double precision, pPantidad double precision, pEnstock integer);
--DROP FUNCTION updateProducto(pCodigo VARCHAR, pDescripcion VARCHAR, pCostobase double precision, pPrecioventa double precision, pPantidad double precision, pEnstock integer); 
--DROP FUNCTION deleteProducto(pCodigo VARCHAR);

-------------------funciones proveedor-------------------------------
CREATE OR REPLACE FUNCTION insertProveedor(pCodigo VARCHAR, pNombre VARCHAR, pDireccion VARCHAR, pTelefono integer, fecha timestamp, compania VARCHAR)  RETURNS VARCHAR AS 
$proveedorTrigger$
DECLARE Codigo VARCHAR;
BEGIN
INSERT INTO admin.proveedor("codigo", "nombre" , "direccion" , "telefono" , "fechapedido" , "compannia")
VALUES (pCodigo, pNombre, pDireccion, pTelefono, fecha, compania);
Codigo = pCodigo;
RETURN Codigo;
END
$proveedorTrigger$ language plpgsql;

CREATE OR REPLACE FUNCTION updateProveedor(pCodigo VARCHAR, pNombre VARCHAR, pDireccion VARCHAR, pTelefono integer, fecha timestamp, compania VARCHAR)  RETURNS VOID AS 
$proveedorTrigger$
BEGIN
UPDATE admin.proveedor SET "nombre" = pNombre, "direccion" = pDireccion,"telefono" = pTelefono,"fechapedido" = fecha,"compannia" = compania
 WHERE "codigo" = pCodigo;
END
$proveedorTrigger$ language plpgsql;

CREATE OR REPLACE FUNCTION deleteProveedor(pCodigo VARCHAR)  RETURNS VARCHAR AS 
$$
BEGIN
DELETE FROM admin.proveedor WHERE "codigo" = pCodigo;
RETURN 'Elimidano';
END
$$ language plpgsql;

CREATE OR REPLACE FUNCTION validaProveedor()  RETURNS TRIGGER AS 
$$
DECLARE bandera boolean;
BEGIN
 bandera:= false;
 IF (TG_OP = 'INSERT') THEN
	IF(NEW.codigo = '' OR NEW.nombre = '' OR NEW.direccion = '' OR NEW.telefono < 0 OR NEW.compannia = '') THEN
		bandera := true;
		RAISE NOTICE 'Datos invalidos';
	END IF;
	IF(bandera = false) THEN
	RAISE NOTICE 'AGREGADO';
	RETURN NEW;
	END IF;
  END IF;
IF (TG_OP = 'UPDATE') THEN
	IF(NEW.codigo = ''OR NEW.nombre = '' OR NEW.direccion = '' OR NEW.telefono < 0 OR NEW.compannia = '') THEN
		bandera := true;
		RAISE NOTICE 'Datos invalidos';
	END IF;
	IF(bandera = false) THEN
	RAISE NOTICE 'ACTUALIZADO';
	RETURN NEW;
	END IF;
  END IF;
END
$$ language plpgsql;

CREATE TRIGGER proveedorTrigger AFTER INSERT OR UPDATE
    ON admin.proveedor FOR EACH ROW 
    EXECUTE PROCEDURE validaProveedor();
-------------------------------------------------------------------------------------------------
--DROP TRIGGER proveedorTrigger ON admin.proveedor;
--DROP FUNCTION insertProveedor(pCodigo VARCHAR, pNombre VARCHAR, pDireccion VARCHAR, pTelefono integer, fecha timestamp, compania VARCHAR);
--DROP FUNCTION updateProveedor(pCodigo VARCHAR, pNombre VARCHAR, pDireccion VARCHAR, pTelefono integer, fecha timestamp, compania VARCHAR); 
--DROP FUNCTION  deleteProveedor(pCodigo VARCHAR);


-------------------funciones salida-------------------------------
CREATE OR REPLACE FUNCTION insertSalida(pDescripcion VARCHAR, pMonto DOUBLE PRECISION, fecha TIMESTAMP)  RETURNS INTEGER AS 
$salidaTrigger$
DECLARE ID INTEGER;
BEGIN
INSERT INTO admin.salida("descripcion", "monto", "fechahora")
VALUES (pDescripcion, pMonto, fecha);
ID = (SELECT currval('admin.salida_id_seq'));
RETURN ID;
END
$salidaTrigger$ language plpgsql;

CREATE OR REPLACE FUNCTION updateSalida(pDescripcion VARCHAR, pMonto DOUBLE PRECISION, fecha TIMESTAMP, pId INT)  RETURNS VOID AS 
$salidaTrigger$
BEGIN
UPDATE admin.salida SET "descripcion" = pDescripcion, "monto" = pMonto, "fechahora" = fecha
 WHERE "id" = pId ;
END
$salidaTrigger$ language plpgsql;

CREATE OR REPLACE FUNCTION deleteSalida(pId INT)  RETURNS VARCHAR AS 
$$
BEGIN
DELETE FROM admin.salida WHERE "id" = pId ;
RETURN 'Elimidano';
END
$$ language plpgsql;

CREATE OR REPLACE FUNCTION validaSalida()  RETURNS TRIGGER AS 
$$
DECLARE bandera boolean;
BEGIN
 bandera:= false;
 IF (TG_OP = 'INSERT') THEN
	IF(NEW.descripcion = '' OR NEW.monto < 0) THEN
		bandera := true;
		RAISE NOTICE 'Datos invalidos';
	END IF;
	IF(bandera = false) THEN
	RAISE NOTICE 'AGREGADO';
	RETURN NEW;
	END IF;
  END IF;
IF (TG_OP = 'UPDATE') THEN
	IF(NEW.descripcion = '' OR NEW.monto < 0) THEN
		bandera := true;
		RAISE NOTICE 'Datos invalidos';
	END IF;
	IF(bandera = false) THEN
	RAISE NOTICE 'ACTUALIZADO';
	RETURN NEW;
	END IF;
  END IF;
END
$$ language plpgsql;

CREATE TRIGGER salidaTrigger AFTER INSERT OR UPDATE
    ON admin.salida FOR EACH ROW 
    EXECUTE PROCEDURE validaSalida();
-------------------------------------------------------------------------------------------------
--DROP TRIGGER salidaTrigger ON admin.salida;
--DROP FUNCTION insertSalida(pDescripcion VARCHAR, pMonto DOUBLE PRECISION, fecha TIMESTAMP);
--DROP FUNCTION updateSalida(pDescripcion VARCHAR, pMonto DOUBLE PRECISION, fecha TIMESTAMP, pId INT); 
--DROP FUNCTION deleteSalida(int);


-------------------funciones ticket-------------------------------
CREATE OR REPLACE FUNCTION insertTicket(pNombre VARCHAR, pLocalidad VARCHAR, pDireccion VARCHAR, pPropietario VARCHAR, pTelefono integer, mensaje VARCHAR, pUltimalinea VARCHAR)  RETURNS INTEGER AS 
$ticketTrigger$
DECLARE ID INTEGER;
BEGIN
INSERT INTO admin.ticket("nombre", "localidad", "direccion", "propietario", "telefono", "mensajefinal", "ultimalinea")
VALUES (pNombre, pLocalidad, pDireccion, pPropietario, pTelefono, mensaje, pUltimalinea);
ID = (SELECT currval('admin.salida_id_seq'));
RETURN ID;
END
$ticketTrigger$ language plpgsql;

CREATE OR REPLACE FUNCTION updateTicket(pNombre VARCHAR, pLocalidad VARCHAR, pDireccion VARCHAR, pPropietario VARCHAR, pTelefono integer, mensaje VARCHAR, pUltimalinea VARCHAR, pId INT)  RETURNS VOID AS 
$ticketTrigger$
BEGIN
UPDATE admin.ticket SET "nombre" = pNombre, "localidad" = pLocalidad, "direccion" = pDireccion, "propietario" = pPropietario, 
"telefono" = pTelefono, "mensajefinal" = mensaje, "ultimalinea" = pUltimalinea
 WHERE "id" = pId ;
END
$ticketTrigger$ language plpgsql;

CREATE OR REPLACE FUNCTION deleteTicket(pId INT)  RETURNS VARCHAR AS 
$$
BEGIN
DELETE FROM admin.ticket WHERE "id" = pId ;
RETURN 'Elimidano';
END
$$ language plpgsql;

CREATE OR REPLACE FUNCTION validaTicket()  RETURNS TRIGGER AS 
$$
DECLARE bandera boolean;
BEGIN
 bandera:= false;
 IF (TG_OP = 'INSERT') THEN
	IF(NEW.nombre = ''OR NEW.localidad = ''OR NEW.direccion = ''OR NEW.propietario = ''OR NEW.telefono < 0 OR NEW.mensajefinal = '' OR NEW.ultimalinea = '') THEN
		bandera := true;
		RAISE NOTICE 'Datos invalidos';
	END IF;
	IF(bandera = false) THEN
	RAISE NOTICE 'AGREGADO';
	RETURN NEW;
	END IF;
  END IF;
IF (TG_OP = 'UPDATE') THEN
		IF(NEW.nombre = ''OR NEW.localidad = ''OR NEW.direccion = ''OR NEW.propietario = ''OR NEW.telefono < 0 OR NEW.mensajefinal = '' OR NEW.ultimalinea = '') THEN
		bandera := true;
		RAISE NOTICE 'Datos invalidos';
	END IF;
	IF(bandera = false) THEN
	RAISE NOTICE 'ACTUALIZADO';
	RETURN NEW;
	END IF;
  END IF;
END
$$ language plpgsql;

CREATE TRIGGER ticketTrigger AFTER INSERT OR UPDATE
    ON admin.ticket FOR EACH ROW 
    EXECUTE PROCEDURE validaTicket();
-------------------------------------------------------------------------------------------------
--DROP TRIGGER ticketTrigger ON admin.ticket;
--DROP FUNCTION insertTicket(pNombre VARCHAR, pLocalidad VARCHAR, pDireccion VARCHAR, pPropietario VARCHAR, pTelefono integer, mensaje VARCHAR, pUltimalinea VARCHAR);
--DROP FUNCTION updateTicket(pNombre VARCHAR, pLocalidad VARCHAR, pDireccion VARCHAR, pPropietario VARCHAR, pTelefono integer, mensaje VARCHAR, pUltimalinea VARCHAR, pId INT); 
--DROP FUNCTION deleteTicket(int);

set search_path = usuarios;
-------------------funciones DetalleVenta-------------------------------
CREATE OR REPLACE FUNCTION insertDetalleVenta(pDescripcion VARCHAR, pPrecio double precision, pCantidad integer, pImpuestos double precision, pCodigocaja VARCHAR)  RETURNS INTEGER AS 
$detalleventaTrigger$
DECLARE ID INTEGER;
BEGIN
INSERT INTO usuarios.detalleventa("descripcion", "precio", "cantidad", "impuestos", "codigocaja")
VALUES (pDescripcion, pPrecio, pCantidad, pImpuestos, pCodigocaja);
ID = (SELECT currval('usuarios.detalleventa_id_seq'));
RETURN ID;
END
$detalleventaTrigger$ language plpgsql;

CREATE OR REPLACE FUNCTION updateDetalleVenta(pDescripcion VARCHAR, pPrecio double precision, pCantidad integer, pImpuestos double precision, pCodigocaja VARCHAR, pId INT)  RETURNS VOID AS 
$detalleventaTrigger$
BEGIN
UPDATE usuarios.detalleventa SET "descripcion" = pDescripcion, "precio" = pPrecio, "cantidad" = pCantidad, "impuestos" = pImpuestos, "codigocaja"= pCodigocaja
 WHERE "id" = pId ;
END
$detalleventaTrigger$ language plpgsql;

CREATE OR REPLACE FUNCTION deleteDetalleVenta(pId INT)  RETURNS VARCHAR AS 
$$
BEGIN
DELETE FROM usuarios.detalleventa WHERE "id" = pId ;
RETURN 'Elimidano';
END
$$ language plpgsql;

CREATE OR REPLACE FUNCTION validaDetalleVenta()  RETURNS TRIGGER AS 
$$
DECLARE bandera boolean;
BEGIN
 bandera:= false;
 IF (TG_OP = 'INSERT') THEN
	IF(NEW.descripcion = ''OR NEW.precio < 0 OR NEW.cantidad < 0 OR NEW.impuestos < 0 OR NEW.codigocaja = '') THEN
		bandera := true;
		RAISE NOTICE 'Datos invalidos';
	END IF;
	IF(bandera = false) THEN
	RAISE NOTICE 'AGREGADO';
	RETURN NEW;
	END IF;
  END IF;
IF (TG_OP = 'UPDATE') THEN
	IF(NEW.descripcion = ''OR NEW.precio < 0 OR NEW.cantidad < 0 OR NEW.impuestos < 0 OR NEW.codigocaja = '') THEN
		bandera := true;
		RAISE NOTICE 'Datos invalidos';
	END IF;
	IF(bandera = false) THEN
	RAISE NOTICE 'ACTUALIZADO';
	RETURN NEW;
	END IF;
  END IF;
END
$$ language plpgsql;

CREATE TRIGGER detalleventaTrigger AFTER INSERT OR UPDATE
    ON usuarios.detalleventa FOR EACH ROW 
    EXECUTE PROCEDURE validaDetalleVenta();
-------------------------------------------------------------------------------------------------
--DROP TRIGGER detalleventaTrigger ON usuarios.detalleventa;
--DROP FUNCTION insertDetalleVenta(pDescripcion VARCHAR, pPrecio VARCHAR, pCantidad integer, pImpuestos double precision, pCodigocaja VARCHAR);
--DROP FUNCTION updateDetalleVenta(pDescripcion VARCHAR, pPrecio VARCHAR, pCantidad integer, pImpuestos double precision, pCodigocaja VARCHAR, pId INT); 
--DROP FUNCTION deleteDetalleVenta(int);

-------------------funciones estadocuenta-------------------------------
CREATE OR REPLACE FUNCTION insertEstadoCuenta(pIdcliente integer, pSaldoanterior double precision, pAbono double precision, pSaldoactual double precision, pFechahora timestamp)  RETURNS INTEGER AS 
$estadocuentaTrigger$
DECLARE ID INTEGER;
BEGIN
INSERT INTO usuarios.estadocuenta("idcliente", "saldoanterior", "abono", "saldoactual", "fechahora")
VALUES (pIdcliente, pSaldoanterior, pAbono, pSaldoactual, pFechahora);
ID = (SELECT currval('usuarios.estadocuenta_id_seq'));
RETURN ID;
END
$estadocuentaTrigger$ language plpgsql;

CREATE OR REPLACE FUNCTION updateEstadoCuenta(pIdcliente integer, pSaldoanterior double precision, pAbono double precision, pSaldoactual double precision, pFechahora timestamp, pId INT)  RETURNS VOID AS 
$estadocuentaTrigger$
BEGIN
UPDATE usuarios.estadocuenta SET "idcliente" = pIdcliente, "saldoanterior" = pSaldoanterior, "abono" = pAbono, "saldoactual" = pSaldoactual, "fechahora"= pFechahora
 WHERE "id" = pId ;
END
$estadocuentaTrigger$ language plpgsql;

CREATE OR REPLACE FUNCTION deleteEstadoCuenta(pId INT)  RETURNS VARCHAR AS 
$$
BEGIN
DELETE FROM usuarios.estadocuenta WHERE "id" = pId ;
RETURN 'Elimidano';
END
$$ language plpgsql;

CREATE OR REPLACE FUNCTION validaEstadoCuenta()  RETURNS TRIGGER AS 
$$
DECLARE bandera boolean;
BEGIN
 bandera:= false;
 IF (TG_OP = 'INSERT') THEN
	IF(NEW.idcliente < 0 OR NEW.saldoanterior < 0 OR NEW.abono < 0 OR NEW.saldoactual < 0) THEN
		bandera := true;
		RAISE NOTICE 'Datos invalidos';
	END IF;
	IF(bandera = false) THEN
	RAISE NOTICE 'AGREGADO';
	RETURN NEW;
	END IF;
  END IF;
IF (TG_OP = 'UPDATE') THEN
		IF(NEW.idcliente < 0 OR NEW.saldoanterior < 0 OR NEW.abono < 0 OR NEW.saldoactual < 0) THEN
		bandera := true;
		RAISE NOTICE 'Datos invalidos';
	END IF;
	IF(bandera = false) THEN
	RAISE NOTICE 'ACTUALIZADO';
	RETURN NEW;
	END IF;
  END IF;
END
$$ language plpgsql;

CREATE TRIGGER estadocuentaTrigger AFTER INSERT OR UPDATE
    ON usuarios.estadocuenta FOR EACH ROW 
    EXECUTE PROCEDURE validaEstadoCuenta();
-------------------------------------------------------------------------------------------------
--DROP TRIGGER detalleventaTrigger ON usuarios.estadocuenta;
--DROP FUNCTION insertEstadoCuenta(pIdcliente integer, pSaldoanterior double precision, pAbono double precision, pSaldoactual double precision, pFechahora timestamp);
--DROP FUNCTION updateEstadoCuenta(pIdcliente integer, pSaldoanterior double precision, pAbono double precision, pSaldoactual double precision, pFechahora timestamp, pId INT); 
--DROP FUNCTION deleteEstadoCuenta(int);


-------------------funciones puesto-------------------------------
CREATE OR REPLACE FUNCTION insertPuesto(pPuesto VARCHAR)  RETURNS INTEGER AS 
$puestoTrigger$
DECLARE ID INTEGER;
BEGIN
INSERT INTO usuarios.puesto("puesto") VALUES (pPuesto);
ID = (SELECT currval('usuarios.puesto_id_seq'));
RETURN ID;
END
$puestoTrigger$ language plpgsql;

CREATE OR REPLACE FUNCTION updatePuesto(pPuesto VARCHAR, pId INT)  RETURNS VOID AS 
$puestoTrigger$
BEGIN
UPDATE usuarios.puesto SET "puesto" = pPuesto
 WHERE "id" = pId ;
END
$puestoTrigger$ language plpgsql;

CREATE OR REPLACE FUNCTION deletePuesto(pId INT)  RETURNS VARCHAR AS 
$$
BEGIN
DELETE FROM usuarios.puesto WHERE "id" = pId ;
RETURN 'Elimidano';
END
$$ language plpgsql;

CREATE OR REPLACE FUNCTION validaPuesto()  RETURNS TRIGGER AS 
$$
DECLARE bandera boolean;
BEGIN
 bandera:= false;
 IF (TG_OP = 'INSERT') THEN
	IF(NEW.puesto = '') THEN
		bandera := true;
		RAISE NOTICE 'Datos invalidos';
	END IF;
	IF(bandera = false) THEN
	RAISE NOTICE 'AGREGADO';
	RETURN NEW;
	END IF;
  END IF;
IF (TG_OP = 'UPDATE') THEN
			IF(NEW.puesto = '') THEN
		bandera := true;
		RAISE NOTICE 'Datos invalidos';
	END IF;
	IF(bandera = false) THEN
	RAISE NOTICE 'ACTUALIZADO';
	RETURN NEW;
	END IF;
  END IF;
END
$$ language plpgsql;

CREATE TRIGGER puestoTrigger AFTER INSERT OR UPDATE
    ON usuarios.puesto FOR EACH ROW 
    EXECUTE PROCEDURE validaPuesto();
-------------------------------------------------------------------------------------------------
--DROP TRIGGER puestoTrigger ON usuarios.puesto;
--DROP FUNCTION insertPuesto(pPuesto VARCHAR);
--DROP FUNCTION updatePuesto(pPuesto VARCHAR, pId INT); 
--DROP FUNCTION deletePuesto(int);


-------------------funciones usuario-------------------------------
CREATE OR REPLACE FUNCTION insertUsuario(pUsuario VARCHAR, pNombre VARCHAR, pApellido VARCHAR, pTelefono integer, pClave VARCHAR, pIdpuestos integer)  RETURNS INTEGER AS 
$usuarioTrigger$
DECLARE ID INTEGER;

BEGIN
INSERT INTO usuarios.usuario("usuario", "nombre", "apellido", "telefono", "clave", "idpuestos") VALUES (pUsuario, pNombre, pApellido, pTelefono, md5(pClave), pIdpuestos);
ID = (SELECT currval('usuarios.puesto_id_seq'));
RETURN ID;
END
$usuarioTrigger$ language plpgsql;

CREATE OR REPLACE FUNCTION updateUsuario(pUsuario VARCHAR, pNombre VARCHAR, pApellido VARCHAR, pTelefono integer, pClave VARCHAR, pIdpuestos integer, pId INT)  RETURNS VOID AS 
$usuarioTrigger$
BEGIN
UPDATE usuarios.usuario SET "usuario" = pUsuario, "nombre" = pNombre, "apellido" = pApellido, "telefono" = pTelefono, "clave" = md5(pClave), "idpuestos" = pIdpuestos
 WHERE "id" = pId ;
END
$usuarioTrigger$ language plpgsql;

CREATE OR REPLACE FUNCTION deleteUsuario(pId INT)  RETURNS VARCHAR AS 
$$
BEGIN
DELETE FROM usuarios.usuario WHERE "id" = pId ;
RETURN 'Elimidano';
END
$$ language plpgsql;

CREATE OR REPLACE FUNCTION validaUsuario()  RETURNS TRIGGER AS 
$$
DECLARE bandera boolean;
BEGIN
 bandera:= false;
 IF (TG_OP = 'INSERT') THEN
	IF(NEW.usuario = '' OR NEW.nombre = '' OR NEW.apellido = '' OR NEW.telefono < 0 OR NEW.clave = '' OR NEW.idpuestos < 0) THEN
		bandera := true;
		RAISE NOTICE 'Datos invalidos';
	END IF;
	IF(bandera = false) THEN
	RAISE NOTICE 'AGREGADO';
	RETURN NEW;
	END IF;
  END IF;
IF (TG_OP = 'UPDATE') THEN
	IF(NEW.usuario = '' OR NEW.nombre = '' OR NEW.apellido = '' OR NEW.telefono < 0 OR NEW.clave = '' OR NEW.idpuestos < 0) THEN
		bandera := true;
		RAISE NOTICE 'Datos invalidos';
	END IF;
	IF(bandera = false) THEN
	RAISE NOTICE 'ACTUALIZADO';
	RETURN NEW;
	END IF;
  END IF;
END
$$ language plpgsql;

CREATE TRIGGER usuarioTrigger AFTER INSERT OR UPDATE
    ON usuarios.usuario FOR EACH ROW 
    EXECUTE PROCEDURE validaUsuario();
-------------------------------------------------------------------------------------------------
--DROP TRIGGER usuarioTrigger ON usuarios.puesto;
--DROP FUNCTION insertUsuario(pUsuario VARCHAR, pNombre VARCHAR, pApellido VARCHAR, pTelefono integer, pClave VARCHAR, pIdpuestos integer);
--DROP FUNCTION updateUsuario(pUsuario VARCHAR, pNombre VARCHAR, pApellido VARCHAR, pTelefono integer, pClave VARCHAR, pIdpuestos integer, pId INT); 
--DROP FUNCTION deleteUsuario(int);


-------------------funciones venta-------------------------------
CREATE OR REPLACE FUNCTION insertVenta(fecha timestamp, pTipopago VARCHAR, pIdusuario integer, codigoCaja VARCHAR, pIddetalleventa integer)  RETURNS INTEGER AS 
$ventaTrigger$
DECLARE ID INTEGER;
BEGIN
INSERT INTO usuarios.venta("fecha_hora", "tipopago", "idusuario", "codigo_caja", "iddetalleventa") VALUES (fecha, pTipopago, pIdusuario, codigoCaja, pIddetalleventa);
ID = (SELECT currval('usuarios.usuario_id_seq'));
RETURN ID;
END
$ventaTrigger$ language plpgsql;

CREATE OR REPLACE FUNCTION updateVenta(fecha timestamp, pTipopago VARCHAR, pIdusuario integer, codigoCaja VARCHAR, pIddetalleventa integer, pId INT)  RETURNS VOID AS 
$ventaTrigger$
BEGIN
UPDATE usuarios.venta SET "fecha_hora" = fecha, "tipopago" = pTipopago, "idusuario" = pIdusuario, "codigo_caja" = codigoCaja, "iddetalleventa" = pIddetalleventa
 WHERE "id" = pId ;
END
$ventaTrigger$ language plpgsql;

CREATE OR REPLACE FUNCTION deleteVenta(pId INT)  RETURNS VARCHAR AS 
$$
BEGIN
DELETE FROM usuarios.venta WHERE "id" = pId ;
RETURN 'Elimidano';
END
$$ language plpgsql;

CREATE OR REPLACE FUNCTION validaVenta()  RETURNS TRIGGER AS 
$$
DECLARE bandera boolean;
BEGIN
 bandera:= false;
 IF (TG_OP = 'INSERT') THEN
	IF(NEW.tipopago = '' OR NEW.idusuario < 0 OR NEW.codigo_caja = '' OR NEW.iddetalleventa < 0) THEN
		bandera := true;
		RAISE NOTICE 'Datos invalidos';
	END IF;
	IF(bandera = false) THEN
	RAISE NOTICE 'AGREGADO';
	RETURN NEW;
	END IF;
  END IF;
IF (TG_OP = 'UPDATE') THEN
	IF(NEW.tipopago = '' OR NEW.idusuario < 0 OR NEW.codigo_caja = '' OR NEW.iddetalleventa < 0) THEN
		bandera := true;
		RAISE NOTICE 'Datos invalidos';
	END IF;
	IF(bandera = false) THEN
	RAISE NOTICE 'ACTUALIZADO';
	RETURN NEW;
	END IF;
  END IF;
END
$$ language plpgsql;

CREATE TRIGGER ventaTrigger AFTER INSERT OR UPDATE
    ON usuarios.venta FOR EACH ROW 
    EXECUTE PROCEDURE validaVenta();
-------------------------------------------------------------------------------------------------
--DROP TRIGGER ventaTrigger ON usuarios.venta;
--DROP FUNCTION insertVenta(fecha timestamp, pTipopago VARCHAR, pIdusuario integer, codigoCaja VARCHAR, pIddetalleventa integer);
--DROP FUNCTION updateVenta(fecha timestamp, pTipopago VARCHAR, pIdusuario integer, codigoCaja VARCHAR, pIddetalleventa integer, pId INT);
--DROP FUNCTION deleteVenta(int);


-------------------funciones ventacontado-------------------------------
CREATE OR REPLACE FUNCTION insertVentaContado(pIdticket integer,pMonto double precision, pPagacon double precision, pSuvuelto double precision, pCodigocaja VARCHAR)  RETURNS INTEGER AS 
$ventacontadoTrigger$
DECLARE ID INTEGER;
BEGIN
INSERT INTO usuarios.ventacontado("idticket", "monto", "pagacon", "suvuelto", "codigocaja") VALUES (pIdticket,pMonto, pPagacon, pSuvuelto, pCodigocaja);
ID = (SELECT currval('usuarios.ventacontado_id_seq'));
RETURN ID;
END
$ventacontadoTrigger$ language plpgsql;

CREATE OR REPLACE FUNCTION updateVentaContado(pIdticket integer,pMonto double precision, pPagacon double precision, pSuvuelto double precision, pCodigocaja VARCHAR, pId INT)  RETURNS VOID AS 
$ventacontadoTrigger$
BEGIN
UPDATE usuarios.ventacontado SET "idticket" = pIdticket, "monto" = pMonto, "pagacon" = pPagacon, "suvuelto" = pSuvuelto, "codigocaja" = pCodigocaja
 WHERE "id" = pId ;
END
$ventacontadoTrigger$ language plpgsql;

CREATE OR REPLACE FUNCTION deleteVentaContado(pId INT)  RETURNS VARCHAR AS 
$$
BEGIN
DELETE FROM usuarios.ventacontado WHERE "id" = pId ;
RETURN 'Elimidano';
END
$$ language plpgsql;

CREATE OR REPLACE FUNCTION validaVentaContado()  RETURNS TRIGGER AS 
$$
DECLARE bandera boolean;
BEGIN
 bandera:= false;
 IF (TG_OP = 'INSERT') THEN
	IF(NEW.idticket < 0 OR NEW.monto < 0 OR NEW.pagacon < 0 OR NEW.suvuelto < 0 OR NEW.codigocaja = '') THEN
		bandera := true;
		RAISE NOTICE 'Datos invalidos';
	END IF;
	IF(bandera = false) THEN
	RAISE NOTICE 'AGREGADO';
	RETURN NEW;
	END IF;
  END IF;
IF (TG_OP = 'UPDATE') THEN
	IF(NEW.idticket < 0 OR NEW.monto < 0 OR NEW.pagacon < 0 OR NEW.suvuelto < 0 OR NEW.codigocaja = '') THEN
		bandera := true;
		RAISE NOTICE 'Datos invalidos';
	END IF;
	IF(bandera = false) THEN
	RAISE NOTICE 'ACTUALIZADO';
	RETURN NEW;
	END IF;
  END IF;
END
$$ language plpgsql;

CREATE TRIGGER ventacontadoTrigger AFTER INSERT OR UPDATE
    ON usuarios.ventacontado FOR EACH ROW 
    EXECUTE PROCEDURE validaVentaContado();
-------------------------------------------------------------------------------------------------
--DROP TRIGGER ventacontadoTrigger ON usuarios.ventacontado;
--DROP FUNCTION insertVentaContado(pIdticket integer,pMonto double precision, pPagacon double precision, pSuvuelto double precision, pCodigocaja VARCHAR);
--DROP FUNCTION updateVentaContado(pIdticket integer,pMonto double precision, pPagacon double precision, pSuvuelto double precision, pCodigocaja VARCHAR, pId INT);
--DROP FUNCTION deleteVentaContado(int);


-------------------funciones ventacredito-------------------------------
CREATE OR REPLACE FUNCTION insertVentaCredito(pIdticket integer,pMonto double precision, pIdcliente integer, pIdusuario integer, pCodigocaja VARCHAR)  RETURNS INTEGER AS 
$ventacreditoTrigger$
DECLARE ID INTEGER;
BEGIN
INSERT INTO usuarios.ventacredito("idticket", "monto", "idcliente","idusuario", "codigocaja") VALUES (pIdticket,pMonto, pIdcliente, pIdusuario, pCodigocaja);
ID = (SELECT currval('usuarios.ventacredito_id_seq'));
RETURN ID;
END
$ventacreditoTrigger$ language plpgsql;

CREATE OR REPLACE FUNCTION updateVentaCredito(pIdticket integer,pMonto double precision, pIdcliente integer, pIdusuario integer, pCodigocaja VARCHAR, pId INT)  RETURNS VOID AS 
$ventacreditoTrigger$
BEGIN
UPDATE usuarios.ventacredito SET "idticket" = pIdticket, "monto" = pMonto, "idcliente" = pIdcliente, "idusuario" = pIdusuario, "codigocaja" = pCodigocaja
 WHERE "id" = pId ;
END
$ventacreditoTrigger$ language plpgsql;

CREATE OR REPLACE FUNCTION deleteVentaCredito(pId INT)  RETURNS VARCHAR AS 
$$
BEGIN
DELETE FROM usuarios.ventacredito WHERE "id" = pId ;
RETURN 'Elimidano';
END
$$ language plpgsql;

CREATE OR REPLACE FUNCTION validaVentaCredito()  RETURNS TRIGGER AS 
$$
DECLARE bandera boolean;
BEGIN
 bandera:= false;
 IF (TG_OP = 'INSERT') THEN
	IF(NEW.idticket < 0 OR NEW.monto < 0 OR NEW.idcliente < 0 OR NEW.idusuario < 0 OR NEW.codigocaja = '') THEN
		bandera := true;
		RAISE NOTICE 'Datos invalidos';
	END IF;
	IF(bandera = false) THEN
	RAISE NOTICE 'AGREGADO';
	RETURN NEW;
	END IF;
  END IF;
IF (TG_OP = 'UPDATE') THEN
	IF(NEW.idticket < 0 OR NEW.monto < 0 OR NEW.idcliente < 0 OR NEW.idusuario < 0 OR NEW.codigocaja = '') THEN
		bandera := true;
		RAISE NOTICE 'Datos invalidos';
	END IF;
	IF(bandera = false) THEN
	RAISE NOTICE 'ACTUALIZADO';
	RETURN NEW;
	END IF;
  END IF;
END
$$ language plpgsql;

CREATE TRIGGER ventacreditoTrigger AFTER INSERT OR UPDATE
    ON usuarios.ventacredito FOR EACH ROW 
    EXECUTE PROCEDURE validaVentaCredito();
-------------------------------------------------------------------------------------------------
--DROP TRIGGER ventacreditoTrigger ON usuarios.ventacredito;
--DROP FUNCTION insertVentaCredito(pIdticket integer,pMonto double precision, pIdcliente integer, pIdusuario integer, pCodigocaja VARCHAR);
--DROP FUNCTION updateVentaCredito(pIdticket integer,pMonto double precision, pIdcliente integer, pIdusuario integer, pCodigocaja VARCHAR, pId INT);
--DROP FUNCTION deleteVentaCredito(int);



--------------Users-----------------
CREATE USER administrador;
ALTER ROLE administrador WITH SUPERUSER CREATEROLE;
ALTER ROLE administrador WITH PASSWORD '12345';

CREATE USER normal;
ALTER ROLE normal WITH SUPERUSER CREATEROLE;
ALTER ROLE normal WITH PASSWORD '12345';

CREATE USER respaldo;
ALTER ROLE respaldo WITH REPLICATION CREATEROLE;
ALTER ROLE respaldo WITH PASSWORD '12345';
-----------------------------------------------
                             ------------------
                             --    INDEXES   --
                             ------------------

set search_path = usuarios;
CREATE INDEX index_estado_cuenta ON usuarios.estadocuenta (idcliente,saldoanterior,abono,saldoactual);

CREATE UNIQUE INDEX index_venta_contado ON usuarios.ventacontado(id);

CREATE INDEX index_detalle_venta ON usuarios.detalleventa ( codigocaja, cantidad,precio);

set search_path = clientes;

CREATE INDEX index_cliente ON clientes.cliente (nombre,telefono);

CREATE INDEX index_cliente_debe ON clientes.clientedebe (idcliente,montodebe,fechalimitecancelar);

                             ------------------
                             --    VISTAS    --
                             ------------------
set search_path = clientes;

CREATE VIEW vista_debe_cliente AS
SELECT cliente.id, nombre, apellido1, apellido2, telefono, montolimite, direccion,clientedebe.montodebe
  FROM clientes.cliente INNER JOIN clientes.clientedebe ON clientedebe.idcliente = clientes.cliente.id
  ORDER BY clientedebe.montodebe;

CREATE VIEW cliente_estado_cuenta AS
SELECT cliente.id, nombre, apellido1, apellido2, telefono,  direccion,usuarios.estadocuenta.saldoactual
  FROM clientes.cliente INNER JOIN usuarios.estadocuenta ON cliente.id = usuarios.estadocuenta.idcliente;

CREATE VIEW cliente_ventas_credito AS 
SELECT cliente.id, nombre,apellido1,apellido2,telefono,usuarios.ventacredito.monto
FROM clientes.cliente JOIN usuarios.ventacredito ON cliente.id = usuarios.ventacredito.idcliente;

set search_path = usuarios;

CREATE VIEW usuarios.venta_contado AS
SELECT admin.ticket.id,nombre,localidad,direccion,propietario,telefono,
mensajefinal,usuarios.ventacontado.monto, usuarios.ventacontado.codigocaja FROM admin.ticket JOIN usuarios.ventacontado ON
admin.ticket.id = usuarios.ventacontado.idticket;

CREATE VIEW usuarios_detalle_venta AS
SELECT detalleventa.descripcion, precio, cantidad,detalleventa.impuestos,codigocaja,admin.caja.montoinicial
FROM usuarios.detalleventa JOIN admin.caja ON usuarios.detalleventa.codigocaja = admin.caja.codigo;

------------Dicionario de Datos----------------

SELECT relname, indexrelname FROM pg_stat_user_indexes WHERE indexrelname !~~ '%pk%'; --Mostrar Indices

SELECT proname FROM pg_proc WHERE prolang  = 11859 ORDER BY proname --Mostrar Funciones

SELECT tgname FROM pg_trigger WHERE tgisinternal = false ORDER BY tgname; --Mostrar Tiggers

SELECT table_schema AS schemas FROM information_schema.tables WHERE table_name !~~ '%pg%' AND table_schema !~~ '%schema%' GROUP BY schemas;--Mostrar esquemas


SELECT table_name FROM information_schema.columns WHERE table_name !~~ '%pg%' AND table_name !~~ '%sql%' AND is_nullable = 'NO' GROUP BY table_name; -- Mostrar tablas
SELECT table_name, column_name FROM information_schema.columns WHERE table_name !~~ '%pg%' AND table_name !~~ '%sql%' AND is_nullable = 'NO' 
GROUP BY table_name, column_name ORDER BY table_name, column_name; -- Mostrar tablas y atributos

SELECT table_name FROM INFORMATION_SCHEMA.views WHERE table_name !~~ '%pg%' AND table_name !~~ '%sql%' AND table_schema !~~ '%schema%' ORDER BY table_schema; -- Mostrar Vistas

------------------------------------------------
                             ------------------
                             --    SELECTS   --
                             ------------------


SELECT descripcion,cantidad FROM usuarios.detalleventa WHERE precio > 1000;

SELECT nombre,apellido1 FROM clientes.cliente WHERE montolimite BETWEEN 5000 and 20000;

SELECT codigo,descripcion FROM  admin.producto WHERE  cantidad = 10;


SELECT codigo,descripcion FROM  admin.producto WHERE  producto.costobase = 1000 AND producto.costobase = 1500;


SELECT codigo FROM admin.caja WHERE caja.montoinicial >= 50000;


SELECT  codigo, descripcion FROM admin.producto WHERE producto.codigo LIKE '%12%';

SELECT * FROM clientes.cliente WHERE nombre LIKE 'Jo%';

SELECT codigo, nombre,direccion , telefono FROM admin.proveedor WHERE compannia ILIKE 'A%';

SELECT codigo ,descripcion FROM admin.producto WHERE producto.costobase < 1000 OR producto.costobase >2000;

SELECT  ticket.nombre, ticket.localidad, ticket.propietario, ticket.telefono, ventacontado.monto, ventacontado.pagacon, 
  ventacontado.suvuelto, ventacontado.codigocaja FROM admin.ticket, usuarios.ventacontado
WHERE ticket.id = ventacontado.idticket;

