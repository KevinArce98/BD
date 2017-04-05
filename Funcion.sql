
CREATE OR REPLACE FUNCTION insertarCliente(nombre VARCHAR, apellido1 VARCHAR, apellido2 VARCHAR, telefono VARCHAR, montolimite DOUBLE PRECISION, direccion VARCHAR)  RETURNS integer AS   
$$
declare ID integer;
begin
INSERT INTO clientes.cliente("nombre", "apellido1", "apellido2", "telefono", "montolimite", "direccion")
VALUES (nombre, apellido1, apellido2, telefono, montolimite, direccion);
ID = (select currval(clientes.cliente_id_seq));
return ID;
end
$$ language plpgsql;

DROP FUNCTION insertarCliente(character varying,character varying,character varying,character varying,double precision,character varying);

select insertarCliente('Kevin', 'Arias', 'Arce', '84388120', 5000, 'La Palmera');


delete from clientes.cliente;


select * from clientes.cliente;