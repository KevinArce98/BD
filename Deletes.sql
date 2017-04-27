SELECT clientes.deleteCliente(5);
SELECT clientes.deleteClienteDebe(5);
SELECT admin.deleteCaja('ASD123');
SELECT admin.deleteEntrada(5);
SELECT admin.deleteProducto('786542142');
SELECT admin.deleteProveedor('WM8414');
SELECT admin.deleteSalida(5);
SELECT admin.deleteTicket(1);
SELECT usuarios.deleteDetalleVenta(5);
SELECT usuarios.deleteEstadoCuenta(5);
SELECT usuarios.deletePuesto(5);
SELECT usuarios.deleteUsuario(5);
SELECT usuarios.deleteVenta(5);
SELECT usuarios.deleteVentaContado(5);
SELECT usuarios.deleteVentaCredito(5);

delete from usuarios.ventacredito;// para eliminar el ticket
delete from usuarios.ventacontado;

delete from usuarios.venta; // para eliminar caja
delete from usuarios.detalleventa;