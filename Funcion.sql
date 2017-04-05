
CREATE OR REPLACE FUNCTION insertarCliente(nombre VARCHAR, apellido1 VARCHAR, apellido2 VARCHAR, telefono VARCHAR, montolimite DOUBLE PRECISION, direccion VARCHAR)  RETURNS integer AS 
$$
declare ID integer;
begin
INSERT INTO clientes.cliente("nombre", "apellido1", "apellido2", "telefono", "montolimite", "direccion")
VALUES (nombre, apellido1, apellido2, telefono, montolimite, direccion);
ID = (select currval('clientes.cliente_id_seq'));
return ID;
end
$$ language plpgsql;

DROP FUNCTION insertarCliente(character varying,character varying,character varying,character varying,double precision,character varying);

select insertarCliente('Roque', 'Chacon', 'Corrales', '89388525', 10000, 'Naranjo');
insert into cliente("nombre","apellido1","apellido2", "telefono", "montolimite", "direccion") values('Roque', 'Chacon', 'Corrales', '89388525', 10000, 'Naranjo');

delete from clientes.cliente;

DROP TRIGGER rellenar_datos ON cliente;
select * from clientes.cliente;

show search_path;
set search_path = clientes

CREATE TRIGGER rellenar_datos BEFORE INSERT OR UPDATE 
    ON clientes.cliente FOR EACH ROW 
    EXECUTE PROCEDURE insertarCliente();


CREATE OR REPLACE FUNCTION insertarCliente()  RETURNS TRIGGER AS 
$proteger_datos$
begin
INSERT INTO clientes.cliente("nombre", "apellido1", "apellido2", "telefono", "montolimite", "direccion")
VALUES (nombre, apellido1, apellido2, telefono, montolimite, direccion);
end
$proteger_datos$ language plpgsql;