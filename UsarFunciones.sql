SELECT clientes.insertarCliente('NOMBRE','APELLIDO1', 'APELLIDO2', 'TELEFONO', 'MONTOLIMMITE', 'RESIDENCIA');
SELECT clientes.updatecliente('NOMBRE','APELLIDO1', 'APELLIDO2', 'TELEFONO', 'MONTOLIMMITE', 'RESIDENCIA', 'IDMODIFICAR'); 
SELECT clientes.deleteCliente('ID');

SELECT clientes.insertclientedebe(pIdCliente INT, monto DOUBLE PRECISION, fecha TIMESTAMP);
SELECT clientes.insertclientedebe(1, 2500, NOW());
SELECT clientes.updateClienteDebe(pIdCliente INT, monto DOUBLE PRECISION, fecha TIMESTAMP, pId INT); 
SELECT clientes.deleteCliente(int);

SELECT insertCaja(pCodigo VARCHAR, monto DOUBLE PRECISION);
SELECT updateCaja(pCodigo VARCHAR, monto DOUBLE PRECISION, pId INT); 
SELECT deleteCaja(int);

SELECT insertEntrada(pDescripcion VARCHAR, pMonto DOUBLE PRECISION, fecha TIMESTAMP);
SELECT updateEntrada(pDescripcion VARCHAR, pMonto DOUBLE PRECISION, fecha TIMESTAMP, pId INT); 
SELECT deleteEntrada(int);

SELECT insertProducto(pCodigo VARCHAR, pDescripcion VARCHAR, pCostobase double precision, pPrecioventa double precision, pPantidad double precision, pEnstock integer);
SELECT updateProducto(pCodigo VARCHAR, pDescripcion VARCHAR, pCostobase double precision, pPrecioventa double precision, pPantidad double precision, pEnstock integer); 
SELECT deleteProducto(pCodigo VARCHAR);

SELECT insertProveedor(pCodigo VARCHAR, pNombre VARCHAR, pDireccion VARCHAR, pTelefono integer, fecha timestamp, compania VARCHAR);
SELECT updateProveedor(pCodigo VARCHAR, pNombre VARCHAR, pDireccion VARCHAR, pTelefono integer, fecha timestamp, compania VARCHAR); 
SELECT deleteProducto(pCodigo VARCHAR);

SELECT insertSalida(pDescripcion VARCHAR, pMonto DOUBLE PRECISION, fecha TIMESTAMP);
SELECT updateSalida(pDescripcion VARCHAR, pMonto DOUBLE PRECISION, fecha TIMESTAMP, pId INT); 
SELECT deleteSalida(int);

SELECT insertTicket(pNombre VARCHAR, pLocalidad VARCHAR, pDireccion VARCHAR, pPropietario VARCHAR, pTelefono integer, mensaje VARCHAR, pUltimalinea VARCHAR);
SELECT updateTicket(pNombre VARCHAR, pLocalidad VARCHAR, pDireccion VARCHAR, pPropietario VARCHAR, pTelefono integer, mensaje VARCHAR, pUltimalinea VARCHAR, pId INT); 
SELECT deleteTicket(int);

SELECT insertTicket(pNombre VARCHAR, pLocalidad VARCHAR, pDireccion VARCHAR, pPropietario VARCHAR, pTelefono integer, mensaje VARCHAR, pUltimalinea VARCHAR);
SELECT updateTicket(pNombre VARCHAR, pLocalidad VARCHAR, pDireccion VARCHAR, pPropietario VARCHAR, pTelefono integer, mensaje VARCHAR, pUltimalinea VARCHAR, pId INT); 
SELECT deleteTicket(int);

SELECT insertEstadoCuenta(pIdcliente integer, pSaldoanterior double precision, pAbono double precision, pSaldoactual double precision, pFechahora timestamp);
SELECT updateEstadoCuenta(pIdcliente integer, pSaldoanterior double precision, pAbono double precision, pSaldoactual double precision, pFechahora timestamp, pId INT); 
SELECT deleteEstadoCuenta(int);


SELECT insertPuesto(pPuesto VARCHAR);
SELECT updatePuesto(pPuesto VARCHAR, pId INT); 
SELECT deletePuesto(int);

SELECT insertUsuario(pUsuario VARCHAR, pNombre VARCHAR, pApellido VARCHAR, pTelefono integer, pClave VARCHAR, pIdpuestos integer);
SELECT updateUsuario(pUsuario VARCHAR, pNombre VARCHAR, pApellido VARCHAR, pTelefono integer, pClave VARCHAR, pIdpuestos integer, pId INT); 
SELECT deleteUsuario(int);

SELECT insertVenta(fecha timestamp, pTipopago VARCHAR, pIdusuario integer, codigoCaja VARCHAR, pIddetalleventa integer);
SELECT updateVenta(fecha timestamp, pTipopago VARCHAR, pIdusuario integer, codigoCaja VARCHAR, pIddetalleventa integer, pId INT);
SELECT deleteVenta(int);

SELECT insertVentaContado(pIdticket integer,pMonto double precision, pPagacon double precision, pSuvuelto double precision, pCodigocaja VARCHAR);
SELECT updateVentaContado(pIdticket integer,pMonto double precision, pPagacon double precision, pSuvuelto double precision, pCodigocaja VARCHAR, pId INT);
SELECT deleteVentaContado(int);

SELECT insertVentaCredito(pIdticket integer,pMonto double precision, pIdcliente integer, pIdusuario integer, pCodigocaja VARCHAR);
SELECT updateVentaCredito(pIdticket integer,pMonto double precision, pIdcliente integer, pIdusuario integer, pCodigocaja VARCHAR, pId INT);
SELECT deleteVentaCredito(int);





