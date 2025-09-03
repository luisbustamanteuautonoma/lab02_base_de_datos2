-- =========================
-- TABLAS BASE
-- =========================
CREATE TABLE Empleado (
    id_empleado SERIAL PRIMARY KEY,
    nombre TEXT NOT NULL,
    IDN VARCHAR(20) UNIQUE,
    fecha_ingreso DATE NOT NULL
);

-- =========================
-- LIDER Y PLANETA
-- =========================
CREATE TABLE Lider (
    id_lider SERIAL PRIMARY KEY,
    id_empleado INT NOT NULL REFERENCES Empleado(id_empleado),
    fecha_inicio DATE NOT NULL
);

CREATE TABLE Planeta (
    id_planeta SERIAL PRIMARY KEY,
    id_lider INT UNIQUE NOT NULL REFERENCES Lider(id_lider),
    nombre TEXT NOT NULL,
    distancia_solar DECIMAL NOT NULL
);

-- =========================
-- EJECUTIVO Y CONTINENTE
-- =========================
CREATE TABLE Ejecutivo (
    id_ejecutivo SERIAL PRIMARY KEY,
    id_empleado INT NOT NULL REFERENCES Empleado(id_empleado),
    fecha_inicio DATE NOT NULL
);

CREATE TABLE Continente (
    id_continente SERIAL PRIMARY KEY,
    id_planeta INT NOT NULL REFERENCES Planeta(id_planeta),
    id_ejecutivo INT UNIQUE NOT NULL REFERENCES Ejecutivo(id_ejecutivo),
    nombre TEXT NOT NULL
);

-- =========================
-- UBICACIÓN, YACIMIENTO, YACIMIENTO PELIGROSO
-- =========================
CREATE TABLE Ubicacion (
    id_ubicacion SERIAL PRIMARY KEY,
    id_continente INT NOT NULL REFERENCES Continente(id_continente),
    descripcion TEXT
);

CREATE TABLE Jefe_Equipo (
    id_jefe_eq SERIAL PRIMARY KEY,
    id_empleado INT NOT NULL REFERENCES Empleado(id_empleado),
    fecha_inicio DATE NOT NULL
);

CREATE TABLE Yacimiento (
    id_yacimiento SERIAL PRIMARY KEY,
    id_ubicacion INT NOT NULL REFERENCES Ubicacion(id_ubicacion),
    id_jefe_equipo INT NOT NULL REFERENCES Jefe_Equipo(id_jefe_eq),
    nombre TEXT NOT NULL
);

CREATE TABLE Yacimiento_Peligroso (
    id_yacimientopelig SERIAL PRIMARY KEY,
    id_ubicacion INT NOT NULL REFERENCES Ubicacion(id_ubicacion),
    descripcion VARCHAR(255)
);

-- =========================
-- DEPOSITO Y ENCARGADO
-- =========================
CREATE TABLE Encargado_Deposito (
    id_encardep SERIAL PRIMARY KEY,
    id_empleado INT NOT NULL REFERENCES Empleado(id_empleado),
    fecha_asignacion DATE NOT NULL
);

CREATE TABLE Deposito (
    id_deposito SERIAL PRIMARY KEY,
    id_yacimiento INT REFERENCES Yacimiento(id_yacimiento),
    id_yacimientopelig INT REFERENCES Yacimiento_Peligroso(id_yacimientopelig),
    id_encardep INT UNIQUE NOT NULL REFERENCES Encargado_Deposito(id_encardep),
    capacidad INT NOT NULL
);

-- =========================
-- MINERAL Y RELACIÓN DEPOSITO-MINERAL
-- =========================
CREATE TABLE Mineral (
    id_mineral SERIAL PRIMARY KEY,
    id_yacimiento INT NOT NULL REFERENCES Yacimiento(id_yacimiento),
    nombre TEXT NOT NULL,
    tipo_mineral TEXT NOT NULL
);

CREATE TABLE Deposito_Mineral (
    id_dep_min SERIAL PRIMARY KEY,
    id_deposito INT NOT NULL REFERENCES Deposito(id_deposito),
    id_mineral INT NOT NULL REFERENCES Mineral(id_mineral),
    stock INT NOT NULL,
    stock_maximo INT NOT NULL
);

-- =========================
-- EQUIPOS Y MINEROS
-- =========================
CREATE TABLE Equipo_Trabajo (
    id_equipo SERIAL PRIMARY KEY,
    id_jefe_eq INT UNIQUE NOT NULL REFERENCES Jefe_Equipo(id_jefe_eq),
    nombre TEXT NOT NULL
);

CREATE TABLE Minero (
    id_minero SERIAL PRIMARY KEY,
    id_empleado INT NOT NULL REFERENCES Empleado(id_empleado),
    id_equipo INT NOT NULL REFERENCES Equipo_Trabajo(id_equipo)
);

CREATE TABLE Equipo_Especializado (
    id_equipoesp SERIAL PRIMARY KEY,
    id_jefe_eq INT UNIQUE NOT NULL REFERENCES Jefe_Equipo(id_jefe_eq),
    nombre TEXT NOT NULL
);

CREATE TABLE Minero_Experimentado (
    id_mineroexp SERIAL PRIMARY KEY,
    id_equipoesp INT NOT NULL REFERENCES Equipo_Especializado(id_equipoesp),
    id_empleado INT NOT NULL REFERENCES Empleado(id_empleado),
    antiguedad INTERVAL NOT NULL
);

-- =========================
-- ESTADO DEPOSITO Y ORDENES DE TRANSPORTE
-- =========================
CREATE TABLE Estado_Deposito (
    id_estadodep SERIAL PRIMARY KEY,
    id_encardep INT UNIQUE NOT NULL REFERENCES Encargado_Deposito(id_encardep),
    estado VARCHAR(50) NOT NULL,
    comentario TEXT
);

CREATE TABLE Encargado_Orden_Transporte (
    id_encargado_orden_t SERIAL PRIMARY KEY,
    id_empleado INT NOT NULL REFERENCES Empleado(id_empleado),
    id_estadodep INT NOT NULL REFERENCES Estado_Deposito(id_estadodep),
    rol VARCHAR(100) NOT NULL,
    fecha_asignacion DATE NOT NULL
);


CREATE TABLE Conductor (
    id_conductor SERIAL PRIMARY KEY,
    id_empleado INT NOT NULL REFERENCES Empleado(id_empleado),
    licencia VARCHAR(50) NOT NULL
);

CREATE TABLE Nave (
    id_nave SERIAL PRIMARY KEY,
    id_conductor INT UNIQUE NOT NULL,
    tipo_combustible VARCHAR(50) NOT NULL
);

CREATE TABLE Orden_de_Transporte (
    id_orden SERIAL PRIMARY KEY,
    id_dep_min INT NOT NULL REFERENCES Deposito_Mineral(id_dep_min),
    id_continente INT NOT NULL REFERENCES Continente(id_continente),
    id_encargado_orden_t INT NOT NULL REFERENCES Encargado_Orden_Transporte(id_encargado_orden_t),
    id_nave INT NOT NULL REFERENCES Nave(id_nave),
    cantidad INT NOT NULL,
    fecha_orden TIMESTAMP NOT NULL,
    estado VARCHAR(50) NOT NULL CHECK (estado IN ('Pendiente', 'En Proceso', 'En Transito', 'Entregado', 'Cancelado'))
);
