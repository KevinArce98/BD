SELECT clientes.updatecliente('Francisco','Fernandez', 'Arce', '84388120', '15000', 'La Palmera', 1); 

SELECT clientes.updateClienteDebe(1, 3500, '27/09/2017', 1);

SELECT admin.updateCaja('ASD123', 170000, 1);

SELECT admin.updateEntrada('Abono a la deuda de Francisco', 2500, '27/03/2017', 1); 

SELECT admin.updateProducto('122100455', 'Agua en botella 10L', 1250, 1500, 15, 5); 

SELECT admin.updateProveedor('DP1255', 'María', 'San Carlos', '84355124', '15/04/2017', 'Dos Pinos'); 

SELECT admin.updateSalida('Compra Congelador', 50000, '27/03/2017', 1); 

SELECT admin.updateTicket('Super Familia Sanchez', 'La Palmera', '50 oeste Iglesia Catolica La Palmera', 'Manuel Sanchez', '24742500', 'Gracias por su compra', '+++++++++++++', 1); 

SELECT usuarios.updateDetalleVenta('Sardinas', 3950, 2, 0.2, 'ASD123', 1); 

SELECT usuarios.updateEstadoCuenta(1, 7500, 2500, 5000, '25/04/2017', 1); 

SELECT usuarios.updatePuesto('Jefe', 5); 

SELECT usuarios.updateUsuario('FranciscoA', 'Francisco', 'Arce', 84388120, 'k', 4, 1); 

SELECT usuarios.updateVenta('14/04/2017', 'Credito', 3, 'ASD123', 1, 1);

SELECT usuarios.updateVentaContado(1, 50500, 51000, 500, 'ASD123', 1);

SELECT usuarios.updateVentaCredito(1, 10000, 1, 3, 'ASD123', 1);