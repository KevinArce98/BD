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
                             --    SELECTS   --
                             ------------------


SELECT descripcion,cantidad FROM usuarios.detalleventa WHERE precio > 1000;

SELECT nombre,apellido1 FROM clientes.cliente WHERE montolimite BETWEEN 5000 and 20000;

SELECT codigo,descripcion FROM  admin.producto WHERE  cantidad = 10;


SELECT codigo,descripcion FROM  admin.producto WHERE  producto.costobase = 1000 AND producto.costobase = 1500;


SELECT codigo FROM admin.caja WHERE caja.montoinicial = 50000;


SELECT  codigo, descripcion FROM admin.producto WHERE producto.codigo LIKE '%12%';

SELECT *FROM clientes.cliente WHERE nombre LIKE 'Jo%';

SELECT codigo, nombre,direccion , telefono FROM admin.proveedor WHERE compannia ILIKE 'J%';

SELECT codigo ,descripcion FROM admin.producto WHERE producto.costobase < 1000 OR producto.costobase >2000;

SELECT  ticket.nombre, ticket.localidad, ticket.propietario, ticket.telefono, ventacontado.monto, ventacontado.pagacon, 
  ventacontado.suvuelto, ventacontado.codigocaja FROM admin.ticket, usuarios.ventacontado
WHERE ticket.id = ventacontado.idticket;

