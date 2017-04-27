SELECT clientes.insertarCliente('Kevin','Arias', 'Arce', '84388120', '15000', 'La Palmera');
SELECT clientes.insertarCliente('Roque','Chacón', 'Corrales', '85347528', '10000', 'Naranjo');
SELECT clientes.insertarCliente('Josue','Mora', 'Corrales', '72810534', '7500', 'Ciudad Quesada');
SELECT clientes.insertarCliente('Alejandro','Castro', 'Pérez', '89352769', '25000', 'Aguas Zarcas');
SELECT clientes.insertarCliente('Oscar','Vega', 'Blanco', '75369514', '17500', 'San Pedro');

SELECT clientes.insertclientedebe(1, 2500, '27/09/2018');
SELECT clientes.insertclientedebe(2, 5000, '13/10/2017');
SELECT clientes.insertclientedebe(3, 5000, '05/07/2017');
SELECT clientes.insertclientedebe(4, 15000, '08/05/2017');
SELECT clientes.insertclientedebe(5, 12500, '27/12/2017');

SELECT admin.insertCaja('ASD123', 150000);
SELECT admin.insertCaja('AFG456', 200000);

SELECT admin.insertEntrada('Abono a la deuda de Kevin', 2500, '27/03/2017');
SELECT admin.insertEntrada('Abono a la deuda de Roque', 5000, '27/12/2016');
SELECT admin.insertEntrada('Venta de gran cantidad de producto a una Escuela', 25000, '15/02/2017');
SELECT admin.insertEntrada('Venta Congelador antiguo', 35000, '24/04/2017');
SELECT admin.insertEntrada('Abono a la deuda de Alejandro', 7500, '15/04/2017');

SELECT admin.insertproducto('122100455', 'Agua Alpina 1.5L', 1000, 1250, 15, 5);
SELECT admin.insertProducto('055165454', 'CocaCola 3L', 1500, 1850, 25, 10);
SELECT admin.insertProducto('453454515', 'Leche Pinito Dos Pinos 75g', 750, 1100, 18, 15);
SELECT admin.insertProducto('154512245', 'Atun Tesoro del Mar', 955, 1150, 50, 12);
SELECT admin.insertProducto('786542142', 'Arroz Tio Pelon', 200, 2550, 100, 96);

SELECT admin.insertProveedor('DP1255', 'Ruben', 'San Carlos', '84355124', '15/04/2017', 'Dos Pinos');
SELECT admin.insertProveedor('CC9855', 'Jose Luis', 'Carrillo', '84388120', '01/04/2017', 'Coca Cola');
SELECT admin.insertProveedor('WM8414', 'Frank', 'Zarcero', '87245154', '14/01/2017', 'WAMASE');
SELECT admin.insertProveedor('PS9820', 'Carlos', 'Fortuna', '72589605', '05/02/2017', 'Posuelo');
SELECT admin.insertProveedor('KG5348', 'Sandra', 'Muelle', '70885655', '14/04/2017', 'Kelloggs');

SELECT admin.insertSalida('Compra Congelador Nuevo', 50000, '27/03/2017');
SELECT admin.insertSalida('Compra Producto Coca Cola', 25000, '05/03/2017');
SELECT admin.insertSalida('Pago Empleados', 45000, '30/03/2017');
SELECT admin.insertSalida('Compra Productos WAMASE', 35000, '09/03/2017');
SELECT admin.insertSalida('Mantenimiento Computadoras', 10000, '25/04/2017');

SELECT admin.insertTicket('Super Familia Sanchez', 'La Palmera', '50 oeste Iglesia Catolica La Palmera', 'Manuel Sanchez', '24742500', 'Gracias por su compra', '**********************');

SELECT usuarios.insertdetalleventa('Atunes', 3950, 2, 0.2, 'ASD123');
SELECT usuarios.insertdetalleventa('Leche pinito', 5500, 3, 0.3, 'ASD123');
SELECT usuarios.insertdetalleventa('Arroz', 5000, 4, 0.1, 'AFG456');
SELECT usuarios.insertdetalleventa('Leche Caja', 4500, 2, 0.10, 'AFG456');
SELECT usuarios.insertdetalleventa('Jabones', 2500, 7, 0.2, 'AFG456');

SELECT usuarios.insertEstadoCuenta(1, 5000, 2500, 2500, '25/04/2017');
SELECT usuarios.insertEstadoCuenta(2, 10000, 5000, 5000, '13/04/2017');
SELECT usuarios.insertEstadoCuenta(2, 1500, 5500, 10000, '19/03/2017');
SELECT usuarios.insertEstadoCuenta(4, 1000, 7500, 2500, '01/04/2017');
SELECT usuarios.insertEstadoCuenta(5, 7585, 3585, 4000, '14/04/2017');

SELECT usuarios.insertPuesto('Cajero');
SELECT usuarios.insertPuesto('Gondolero');
SELECT usuarios.insertPuesto('Carnicero');
SELECT usuarios.insertPuesto('Matenimiento');
SELECT usuarios.insertPuesto('Administrador');

SELECT usuarios.insertUsuario('KevinArce98', 'Kevin', 'Arias', 84388120, 'k', 4);
SELECT usuarios.insertUsuario('RCorrales', 'Roque', 'Chacon', 85235874, 'Saprisssa.12', 2);
SELECT usuarios.insertUsuario('ilikay', 'Pedro', 'Arias', 75751155, '45', 1);
SELECT usuarios.insertUsuario('EriSan', 'Erick', 'Sanchez', 85995824, 'eri', 3);
SELECT usuarios.insertUsuario('FranSan', 'Francini', 'Sanchez', 72245896, 'fr', 5);

SELECT usuarios.insertVenta('14/04/2017', 'Contado', 3, 'ASD123', 1);
SELECT usuarios.insertVenta('01/02/2017', 'Contado', 3, 'ASD123', 2);
SELECT usuarios.insertVenta('08/01/2017', 'Credito', 3, 'ASD123', 3);
SELECT usuarios.insertVenta('13/03/2017', 'Contado', 3, 'ASD123', 4);
SELECT usuarios.insertVenta('24/02/2017', 'Credito', 3, 'ASD123', 5);

SELECT usuarios.insertVentaContado(1, 50000, 50000, 0, 'ASD123');
SELECT usuarios.insertVentaContado(1, 2500, 3000, 500 ,'ASD123');
SELECT usuarios.insertVentaContado(1, 6350, 6500, 1500, 'AFG456');
SELECT usuarios.insertVentaContado(1, 1785, 2000, 215, 'ASD123');
SELECT usuarios.insertVentaContado(1, 15890, 16000, 110, 'AFG456');

SELECT usuarios.insertVentaCredito(1, 5000, 1, 3, 'ASD123');
SELECT usuarios.insertVentaCredito(1, 2585, 1, 3, 'ASD123');
SELECT usuarios.insertVentaCredito(1, 5000, 1, 3, 'ASD123');
SELECT usuarios.insertVentaCredito(1, 25500, 1, 3, 'ASD123');
SELECT usuarios.insertVentaCredito(1, 59000, 1, 3, 'ASD123');






