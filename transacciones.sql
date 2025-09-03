--TRANSACCIONES ROL ADMIN
-- 1. Crear tabla
BEGIN;
CREATE TABLE prueba_admin1 (id SERIAL PRIMARY KEY, nombre TEXT);
COMMIT;

-- 2. Insertar
BEGIN;
INSERT INTO prueba_admin1 (nombre) VALUES ('Admin Insert 1');
COMMIT;

-- 3. Alterar
BEGIN;
ALTER TABLE prueba_admin1 ADD COLUMN descripcion TEXT;
COMMIT;

-- 4. Actualizar
BEGIN;
UPDATE prueba_admin1 SET descripcion = 'Modificado por Admin' WHERE id = 1;
COMMIT;

-- 5. Eliminar fila
BEGIN;
DELETE FROM prueba_admin1 WHERE id = 1;
COMMIT;

-- 6. Crear otra tabla
BEGIN;
CREATE TABLE prueba_admin2 (codigo INT, valor TEXT);
COMMIT;

-- 7. Drop
BEGIN;
DROP TABLE prueba_admin2;
COMMIT;

--TRANSACCIONES ROL CREADOR
-- 1. Crear tabla
BEGIN;
CREATE TABLE creador_tabla1 (id SERIAL PRIMARY KEY, dato TEXT);
COMMIT;

-- 2. Crear tabla 2
BEGIN;
CREATE TABLE creador_tabla2 (codigo INT);
COMMIT;

-- 3. Alterar tabla
BEGIN;
ALTER TABLE creador_tabla1 ADD COLUMN descripcion TEXT;
COMMIT;

-- 4. Alterar otra tabla
BEGIN;
ALTER TABLE creador_tabla2 ADD COLUMN fecha DATE;
COMMIT;

-- 5. Crear índice
BEGIN;
CREATE INDEX idx_creador ON creador_tabla1(dato);
COMMIT;

-- 6. Crear secuencia
BEGIN;
CREATE SEQUENCE secuencia_creador START 1;
COMMIT;

-- 7. Alterar secuencia
BEGIN;
ALTER SEQUENCE secuencia_creador RESTART WITH 100;
COMMIT;


--TRANSACCIONES ROL MANIPULADOR
-- 1. Insertar
BEGIN;
INSERT INTO Empleado (nombre, IDN, fecha_ingreso) VALUES ('Manip1', 'M001', CURRENT_DATE);
COMMIT;

-- 2. Insertar
BEGIN;
INSERT INTO Empleado (nombre, IDN, fecha_ingreso) VALUES ('Manip2', 'M002', CURRENT_DATE - 10);
COMMIT;

-- 3. Consultar
BEGIN;
SELECT * FROM Empleado LIMIT 5;
COMMIT;

-- 4. Actualizar
BEGIN;
UPDATE Empleado SET nombre = 'ManipUpdate' WHERE id_empleado = 1;
COMMIT;

-- 5. Insertar en Continente
BEGIN;
INSERT INTO Continente (id_planeta, id_ejecutivo, nombre) 
VALUES (1, 1, 'ManipCont1');
COMMIT;

-- 6. Consultar con condición
BEGIN;
SELECT nombre, fecha_ingreso FROM Empleado WHERE fecha_ingreso > '2024-01-01';
COMMIT;

-- 7. Update masivo
BEGIN;
UPDATE Empleado SET nombre = nombre || '_M';
COMMIT;


--TRANSACCIONES ELIMINADOR
-- 1. Seleccionar
BEGIN;
SELECT * FROM Empleado LIMIT 3;
COMMIT;

-- 2. Eliminar un empleado
BEGIN;
DELETE FROM Empleado WHERE id_empleado = 2;
COMMIT;

-- 3. Eliminar otro
BEGIN;
DELETE FROM Empleado WHERE id_empleado = 3;
COMMIT;

-- 4. Crear y eliminar tabla
BEGIN;
CREATE TABLE elim_tabla (id INT);
COMMIT;

BEGIN;
DROP TABLE elim_tabla;
COMMIT;

-- 5. Borrar en cascada
BEGIN;
DELETE FROM Continente WHERE id_continente = 1;
COMMIT;

-- 6. Seleccionar continentes
BEGIN;
SELECT * FROM Continente;
COMMIT;

-- 7. Eliminar varios
BEGIN;
DELETE FROM Empleado WHERE id_empleado > 45;
COMMIT;