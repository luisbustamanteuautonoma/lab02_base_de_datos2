-- =========================
-- EMPLEADOS
-- =========================
INSERT INTO Empleado (nombre, IDN, fecha_ingreso)
SELECT 
    'Empleado_' || gs::TEXT,
    'IDN' || gs::TEXT,
    CURRENT_DATE - (random()*365)::INT
FROM generate_series(1,50) gs;

-- =========================
-- LIDERES (toman empleados distintos)
-- =========================
INSERT INTO Lider (id_empleado, fecha_inicio)
SELECT id_empleado, CURRENT_DATE - (random()*200)::INT
FROM (
    SELECT id_empleado FROM Empleado ORDER BY random() LIMIT 50
) t;

-- =========================
-- PLANETAS
-- =========================
INSERT INTO Planeta (id_lider, nombre, distancia_solar)
SELECT id_lider, 'Planeta_' || gs::TEXT, round((random()*1000 + 100)::NUMERIC,2)
FROM (SELECT id_lider FROM Lider ORDER BY random() LIMIT 50) t, generate_series(1,50) gs
LIMIT 50;

-- =========================
-- EJECUTIVOS
-- =========================
INSERT INTO Ejecutivo (id_empleado, fecha_inicio)
SELECT id_empleado, CURRENT_DATE - (random()*150)::INT
FROM (
    SELECT id_empleado FROM Empleado ORDER BY random() LIMIT 50
) t;

-- =========================
-- CONTINENTES
-- =========================
INSERT INTO Continente (id_planeta, id_ejecutivo, nombre)
SELECT p.id_planeta, e.id_ejecutivo, 'Continente_' || gs::TEXT
FROM (SELECT id_planeta FROM Planeta ORDER BY random() LIMIT 50) p
JOIN (SELECT id_ejecutivo FROM Ejecutivo ORDER BY random() LIMIT 50) e ON true
JOIN generate_series(1,50) gs ON true
LIMIT 50;

-- =========================
-- UBICACIONES
-- =========================
INSERT INTO Ubicacion (id_continente, descripcion)
SELECT id_continente, 'Zona exploratoria ' || gs::TEXT
FROM (SELECT id_continente FROM Continente ORDER BY random() LIMIT 50) t, generate_series(1,50) gs
LIMIT 50;

-- =========================
-- JEFES DE EQUIPO
-- =========================
INSERT INTO Jefe_Equipo (id_empleado, fecha_inicio)
SELECT id_empleado, CURRENT_DATE - (random()*100)::INT
FROM (
    SELECT id_empleado FROM Empleado ORDER BY random() LIMIT 50
) t;

-- =========================
-- YACIMIENTOS
-- =========================
INSERT INTO Yacimiento (id_ubicacion, id_jefe_equipo, nombre)
SELECT u.id_ubicacion, j.id_jefe_eq, 'Yacimiento_' || gs::TEXT
FROM (SELECT id_ubicacion FROM Ubicacion ORDER BY random() LIMIT 50) u
JOIN (SELECT id_jefe_eq FROM Jefe_Equipo ORDER BY random() LIMIT 50) j ON true
JOIN generate_series(1,50) gs ON true
LIMIT 50;

-- =========================
-- YACIMIENTOS PELIGROSOS
-- =========================
INSERT INTO Yacimiento_Peligroso (id_ubicacion, descripcion)
SELECT id_ubicacion, 'Peligro detectado nivel ' || (random()*10)::INT
FROM (SELECT id_ubicacion FROM Ubicacion ORDER BY random() LIMIT 50) t;

-- =========================
-- ENCARGADOS DEPOSITOS
-- =========================
INSERT INTO Encargado_Deposito (id_empleado, fecha_asignacion)
SELECT id_empleado, CURRENT_DATE - (random()*60)::INT
FROM (
    SELECT id_empleado FROM Empleado ORDER BY random() LIMIT 50
) t;

-- =========================
-- DEPOSITOS
-- =========================
INSERT INTO Deposito (id_yacimiento, id_yacimientopelig, id_encardep, capacidad)
SELECT y.id_yacimiento, yp.id_yacimientopelig, e.id_encardep, (random()*1000 + 100)::INT
FROM (SELECT id_yacimiento FROM Yacimiento ORDER BY random() LIMIT 50) y
JOIN (SELECT id_yacimientopelig FROM Yacimiento_Peligroso ORDER BY random() LIMIT 50) yp ON true
JOIN (SELECT id_encardep FROM Encargado_Deposito ORDER BY random() LIMIT 50) e ON true
LIMIT 50;

-- =========================
-- MINERALES
-- =========================
INSERT INTO Mineral (id_yacimiento, nombre, tipo_mineral)
SELECT y.id_yacimiento, 'Mineral_' || gs::TEXT,
       (ARRAY['Metal','Cristal','Gas','Raro'])[floor(random()*4)+1]
FROM (SELECT id_yacimiento FROM Yacimiento ORDER BY random() LIMIT 50) y, generate_series(1,50) gs
LIMIT 50;

-- =========================
-- DEPOSITO-MINERAL
-- =========================
INSERT INTO Deposito_Mineral (id_deposito, id_mineral, stock, stock_maximo)
SELECT d.id_deposito, m.id_mineral,
       (random()*500)::INT, ((random()*500)+500)::INT
FROM (SELECT id_deposito FROM Deposito ORDER BY random() LIMIT 50) d
JOIN (SELECT id_mineral FROM Mineral ORDER BY random() LIMIT 50) m ON true
LIMIT 50;

-- =========================
-- EQUIPO TRABAJO
-- =========================
INSERT INTO Equipo_Trabajo (id_jefe_eq, nombre)
SELECT id_jefe_eq, 'EquipoTrabajo_' || gs::TEXT
FROM (SELECT id_jefe_eq FROM Jefe_Equipo ORDER BY random() LIMIT 50) j, generate_series(1,50) gs
LIMIT 50;

-- =========================
-- MINEROS
-- =========================
INSERT INTO Minero (id_empleado, id_equipo)
SELECT e.id_empleado, eq.id_equipo
FROM (SELECT id_empleado FROM Empleado ORDER BY random() LIMIT 50) e
JOIN (SELECT id_equipo FROM Equipo_Trabajo ORDER BY random() LIMIT 50) eq ON true
LIMIT 50;

-- =========================
-- EQUIPO ESPECIALIZADO
-- =========================
INSERT INTO Equipo_Especializado (id_jefe_eq, nombre)
SELECT id_jefe_eq, 'EquipoEsp_' || gs::TEXT
FROM (SELECT id_jefe_eq FROM Jefe_Equipo ORDER BY random() LIMIT 50) j, generate_series(1,50) gs
LIMIT 50;

-- =========================
-- MINEROS EXPERIMENTADOS
-- =========================
INSERT INTO Minero_Experimentado (id_equipoesp, id_empleado, antiguedad)
SELECT eq.id_equipoesp, e.id_empleado, (random()*365 || ' days')::INTERVAL
FROM (SELECT id_equipoesp FROM Equipo_Especializado ORDER BY random() LIMIT 50) eq
JOIN (SELECT id_empleado FROM Empleado ORDER BY random() LIMIT 50) e ON true
LIMIT 50;

-- =========================
-- ESTADO DEPOSITO
-- =========================
INSERT INTO Estado_Deposito (id_encardep, estado, comentario)
SELECT id_encardep,
       (ARRAY['Activo','Inactivo','Mantenimiento'])[floor(random()*3)+1],
       'Comentario estado ' || gs::TEXT
FROM (SELECT id_encardep FROM Encargado_Deposito ORDER BY random() LIMIT 50) e, generate_series(1,50) gs
LIMIT 50;

-- =========================
-- ENCARGADO ORDEN TRANSPORTE
-- =========================
INSERT INTO Encargado_Orden_Transporte (id_empleado, id_estadodep, rol, fecha_asignacion)
SELECT e.id_empleado, ed.id_estadodep, 'Rol_' || gs::TEXT, CURRENT_DATE - (random()*40)::INT
FROM (SELECT id_empleado FROM Empleado ORDER BY random() LIMIT 50) e
JOIN (SELECT id_estadodep FROM Estado_Deposito ORDER BY random() LIMIT 50) ed ON true
JOIN generate_series(1,50) gs ON true
LIMIT 50;

-- =========================
-- CONDUCTORES
-- =========================
INSERT INTO Conductor (id_empleado, licencia)
SELECT id_empleado, 'LIC-' || gs::TEXT
FROM (SELECT id_empleado FROM Empleado ORDER BY random() LIMIT 50) e, generate_series(1,50) gs
LIMIT 50;

-- =========================
-- NAVES
-- =========================
INSERT INTO Nave (id_conductor, tipo_combustible)
SELECT c.id_conductor, (ARRAY['Ionico','Plasma','Nuclear','Hidrogeno'])[floor(random()*4)+1]
FROM (SELECT id_conductor FROM Conductor ORDER BY random() LIMIT 50) c;

-- =========================
-- ORDENES DE TRANSPORTE
-- =========================
INSERT INTO Orden_de_Transporte (id_dep_min, id_continente, id_encargado_orden_t, id_nave, cantidad, fecha_orden, estado)
SELECT dm.id_dep_min, ct.id_continente, eo.id_encargado_orden_t, n.id_nave,
       (random()*300)::INT, NOW() - (random()*100)::INT * INTERVAL '1 day',
       (ARRAY['Pendiente','En Proceso','En Transito','Entregado','Cancelado'])[floor(random()*5)+1]
FROM (SELECT id_dep_min FROM Deposito_Mineral ORDER BY random() LIMIT 50) dm
JOIN (SELECT id_continente FROM Continente ORDER BY random() LIMIT 50) ct ON true
JOIN (SELECT id_encargado_orden_t FROM Encargado_Orden_Transporte ORDER BY random() LIMIT 50) eo ON true
JOIN (SELECT id_nave FROM Nave ORDER BY random() LIMIT 50) n ON true
LIMIT 50;
