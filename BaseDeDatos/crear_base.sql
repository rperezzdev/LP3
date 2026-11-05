-- Script para crear la base de datos del sitio "Asesoría Legal Global"
-- Ejecutar en SQL Server Management Studio (o en una nueva consulta desde Visual Studio)

IF DB_ID('asesoria') IS NULL
    CREATE DATABASE asesoria;
GO

USE asesoria;
GO

-- Tabla de clientes registrados
-- La clave se guarda encriptada (hash SHA-256 en hexadecimal = 64 caracteres)
IF OBJECT_ID('usuarios') IS NULL
CREATE TABLE usuarios (
    usuario  varchar(30) NOT NULL PRIMARY KEY,
    nombre   varchar(50) NOT NULL,
    apellido varchar(50) NOT NULL,
    mail     varchar(60) NOT NULL,
    edad     int         NOT NULL,
    clave    varchar(64) NOT NULL
);
GO

-- Tabla con los documentos que sube cada usuario
-- (el archivo en sí se guarda en la carpeta documentos/usuario del sitio)
IF OBJECT_ID('documentos') IS NULL
CREATE TABLE documentos (
    codigo        int IDENTITY(1,1) NOT NULL PRIMARY KEY,
    usuario       varchar(30)  NOT NULL REFERENCES usuarios(usuario),
    nombrearchivo varchar(200) NOT NULL,
    tamanio       int          NOT NULL,   -- en bytes
    fecha         datetime     NOT NULL DEFAULT GETDATE(),
    CONSTRAINT uq_documentos UNIQUE (usuario, nombrearchivo)
);
GO
