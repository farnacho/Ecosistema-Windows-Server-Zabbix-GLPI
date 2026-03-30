-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS gestion_usuarios CHARACTER SET utf8mb4;
USE gestion_usuarios;

-- Tabla principal de solicitudes
CREATE TABLE solicitudes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipo ENUM('ALTA', 'MODIFICACION', 'BAJA') NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    username VARCHAR(50),
    email VARCHAR(150),
    departamento ENUM('Direccion_Administracion', 'Desarrollo', 'Hardware', 'Comercial_Soporte') NOT NULL,
    rol VARCHAR(100),
    fecha_solicitud DATETIME DEFAULT NOW(),
    estado ENUM('PENDIENTE', 'PROCESADO', 'ERROR') DEFAULT 'PENDIENTE',
    fecha_procesado DATETIME NULL,
    notas TEXT NULL
);

-- Tabla de log/auditoría
CREATE TABLE auditoria (
    id INT AUTO_INCREMENT PRIMARY KEY,
    solicitud_id INT,
    accion VARCHAR(255),
    resultado ENUM('OK', 'ERROR'),
    detalle TEXT,
    fecha DATETIME DEFAULT NOW(),
    FOREIGN KEY (solicitud_id) REFERENCES solicitudes(id)
);

-- Tabla de usuarios activos (registro de lo que existe en AD)
CREATE TABLE usuarios_activos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    nombre_completo VARCHAR(200),
    email VARCHAR(150),
    departamento VARCHAR(100),
    fecha_alta DATETIME DEFAULT NOW(),
    activo BOOLEAN DEFAULT TRUE
);