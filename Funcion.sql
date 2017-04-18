
CREATE OR REPLACE FUNCTION insertarCliente(nombre VARCHAR, apellido1 VARCHAR, apellido2 VARCHAR, telefono VARCHAR, montolimite DOUBLE PRECISION, direccion VARCHAR)  RETURNS integer AS 
$rellenar_datos$
declare ID integer;
begin
INSERT INTO clientes.cliente("nombre", "apellido1", "apellido2", "telefono", "montolimite", "direccion")
VALUES (nombre, apellido1, apellido2, telefono, montolimite, direccion);
ID = (select currval('clientes.cliente_id_seq'));
return ID;
end
$rellenar_datos$ language plpgsql;

DROP FUNCTION insertarCliente()character varying,character varying,character varying,character varying,double precision,character varying);

select insertarCliente('Roque', 'Chacon', 'Corrales', '89388525', 1, 'Naranjo');
insert into clientes.cliente("nombre","apellido1","apellido2", "telefono", "montolimite", "direccion") values('Roque', 'Chacon', 'Corrales', '89388525', 10000, 'Naranjo');

delete from clientes.cliente;

DROP TRIGGER rellenar_datos ON clientes.cliente;
select * from clientes.cliente;

show search_path;
set search_path = clientes

CREATE TRIGGER rellenar_datos AFTER INSERT
    ON clientes.cliente FOR EACH ROW 
    EXECUTE PROCEDURE validaCliente();


CREATE OR REPLACE FUNCTION validaCliente()  RETURNS TRIGGER AS 
$$
DECLARE bandera boolean;
begin
 bandera:= false;
 IF (TG_OP = 'INSERT') THEN
	IF(NEW.nombre = '') THEN
		bandera := true;
		RAISE NOTICE 'MONTO INVALIDO';
	END IF;
	IF(bandera = false) THEN
	RAISE NOTICE 'AGREGADO';
	RETURN NEW;
	END IF;
  END IF;
IF (TG_OP = 'UPDATE') THEN
	IF(NEW.nombre = '') THEN
		bandera := true;
		RAISE NOTICE 'MONTO INVALIDO';
	END IF;
	IF(bandera = false) THEN
	RAISE NOTICE 'ACTUALIZADO';
	RETURN NEW;
	END IF;
  END IF;
end
$$ language plpgsql;


CREATE OR REPLACE FUNCTION updateCliente(nombre VARCHAR, apellido1 VARCHAR, apellido2 VARCHAR, telefono VARCHAR, montolimite DOUBLE PRECISION, direccion VARCHAR, id INT)  RETURNS integer AS 
$rellenar_datos$
begin
UPDATE clientes.cliente SET "nombre" = nombre, "apellido1" = apellido1, "apellido2"=apellido2, "telefono"=telefono, "montolimite"=montolimite, "direccion"=direccion
 WHERE "id" = id ;
end
$rellenar_datos$ language plpgsql;

select updateCliente('Kevin', 'Arias', 'Arce', '89388525', 1, 'La Palmera', 32);


