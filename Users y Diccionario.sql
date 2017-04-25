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
------------Dicionario de Datos----------------

SELECT * FROM pg_stat_user_indexes; --Mostrar Indices

SELECT proname FROM pg_proc WHERE prolang  = 11859 ORDER BY proname --Mostrar Funciones

SELECT tgname FROM pg_trigger WHERE tgisinternal = false ORDER BY tgname; --Mostrar Tiggers

SELECT table_schema AS schemas FROM information_schema.tables WHERE table_name !~~ '%pg%' AND table_schema !~~ '%schema%' GROUP BY schemas;--Mostrar esquemas


SELECT table_name FROM information_schema.columns WHERE table_name !~~ '%pg%' AND table_name !~~ '%sql%' AND is_nullable = 'NO' GROUP BY table_name; -- Mostrar tablas
SELECT table_name, column_name FROM information_schema.columns WHERE table_name !~~ '%pg%' AND table_name !~~ '%sql%' AND is_nullable = 'NO' 
GROUP BY table_name, column_name ORDER BY table_name, column_name; -- Mostrar tablas y atributos

SELECT table_name FROM INFORMATION_SCHEMA.views WHERE table_name !~~ '%pg%' AND table_name !~~ '%sql%' AND table_schema !~~ '%schema%' ORDER BY table_schema; -- Mostrar Vistas

------------------------------------------------