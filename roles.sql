-- Para crear los roles :v
-- Rol 1: Administrador (todos los permisos)
CREATE ROLE administrador WITH LOGIN PASSWORD 'admin123';
GRANT ALL PRIVILEGES ON DATABASE lab2_bdd2 TO administrador;

-- Rol 2: Creador (puede crear tablas y alterarlas)
CREATE ROLE creador WITH LOGIN PASSWORD 'creador123';
-- Permite crear objetos dentro del esquema público
GRANT CREATE ON SCHEMA public TO creador;
-- Nota: cualquier tabla creada por 'creador' será de su propiedad y podrá ALTER TABLE sobre ella

-- Rol 3: Manipulador (INSERT, UPDATE, SELECT)
CREATE ROLE manipulador WITH LOGIN PASSWORD 'manip123';
-- Los permisos se aplican sobre *tablas*, aquí un ejemplo global
GRANT INSERT, UPDATE, SELECT ON ALL TABLES IN SCHEMA public TO manipulador;

-- Rol 4: Eliminador
CREATE ROLE eliminador WITH LOGIN PASSWORD 'elim123';
-- Permite eliminar registros y consultar
GRANT DELETE, SELECT ON ALL TABLES IN SCHEMA public TO eliminador;
-- DROP no se puede otorgar directamente; debe ser dueño de las tablas para poder usarlo
-- Si quieres que pueda DROP sobre ciertas tablas:
-- ALTER TABLE nombre_tabla OWNER TO eliminador;