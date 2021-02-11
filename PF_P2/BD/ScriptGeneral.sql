USE AppGestionRH;

--MODULO DE MANTENIMIENTO
--Tabla Empleados
CREATE TABLE EMPLEADOS
(ID INT NOT NULL,
COD_EMPLEADO INT NOT NULL PRIMARY KEY,
NOMBRE VARCHAR(150) NOT NULL,
APELLIDO VARCHAR(150) NOT NULL,
TELEFONO VARCHAR(15) NOT NULL,
DEPT VARCHAR(150) NOT NULL,
CARGO VARCHAR(150) NOT NULL,
FECHA_INGRESO DATE NOT NULL,
SALARIO INT,
ESTATUS VARCHAR(20) NOT NULL
);

--Tabla Departamentos
CREATE TABLE DEPARTAMENTOS
(ID INT NOT NULL,
COD_DEPT INT NOT NULL PRIMARY KEY,
NOMBRE VARCHAR(248) NOT NULL
);

--Table Cargos
CREATE TABLE CARGOS
(ID INT NOT NULL PRIMARY KEY,
CARGO VARCHAR(150) NOT NULL
);

--*******************************
--MODULO DE PROCESOS
--Tabla de nominas
CREATE TABLE NOMINAS
(ID INT NOT NULL PRIMARY KEY,
ANNO INT NOT NULL,
MES INT NOT NULL,
MONTO_TOTAL INT
);

--Tabla de salidas
CREATE TABLE SALIDAS
(COD_EMPLEADO INT NOT NULL PRIMARY KEY,
FOREIGN KEY (COD_EMPLEADO) REFERENCES EMPLEADOS(COD_EMPLEADO),
NOM_EMP VARCHAR(150) NOT NULL,
TIPO_SALIDA VARCHAR(100) NOT NULL,
MOTIVO VARCHAR(300) NOT NULL,
FECHA_SALIDA DATE NOT NULL
);

--Tabla de vacaciones
CREATE TABLE VACACIONES
(COD_EMPLEADO INT NOT NULL PRIMARY KEY,
FOREIGN KEY (COD_EMPLEADO) REFERENCES EMPLEADOS(COD_EMPLEADO),
DESDE VARCHAR(100) NOT NULL,
HASTA VARCHAR(100) NOT NULL,
CORRESPONDIENTE_A VARCHAR(5) NOT NULL,
COMENTARIOS VARCHAR(300)
);

--Tabla de permisos
CREATE TABLE PERMISOS
(COD_EMPLEADO INT NOT NULL PRIMARY KEY,
FOREIGN KEY (COD_EMPLEADO) REFERENCES EMPLEADOS(COD_EMPLEADO),
DESDE VARCHAR(100) NOT NULL,
HASTA VARCHAR(100) NOT NULL,
COMENTARIOS VARCHAR(300)
);

--Tabla de licencias
CREATE TABLE LICENCIAS
(COD_EMPLEADO INT NOT NULL PRIMARY KEY,
FOREIGN KEY (COD_EMPLEADO) REFERENCES EMPLEADOS(COD_EMPLEADO),
DESDE VARCHAR(100) NOT NULL,
HASTA VARCHAR(100) NOT NULL,
MOTIVO VARCHAR(200) NOT NULL,
COMENTARIOS VARCHAR(300)
);

--MODULO DE INFORMES
--Vista de nomina en anno especifico
--crear procedimiento que recibe por parametro el anno para ver las nominas del anno especificado

--Vista de nomina en mes especifico
--procedimiento que recibe por parametro el mes para ver las nominas del mes especificado

--Vista de empleados activos en la empresa
--vista que busque los empleados con el estatus activo
--vista de todos
--filtro por departamento
--filtro por nombre

--Vista de empleados inactivos de la empresa
--vista que busque los empleados con el estatus inactivo

--Vista de todos los departamentos
CREATE VIEW VER_DEPTS
AS SELECT * FROM DEPARTAMENTOS;


--Vista de todos los cargos
CREATE VIEW VER_CARGOS
AS SELECT * FROM CARGOS;

CREATE TRIGGER TGR_NOMNINAS ON NOMINAS
FOR INSERT AS
DECLARE
@MONTO INT;
SELECT @MONTO = SUM(SALARIO) FROM EMPLEADOS WHERE ESTATUS = 'activo';
UPDATE NOMINAS SET MONTO_TOTAL = @MONTO;
PRINT'Trigger realizado'
GO

CREATE TRIGGER inactivar ON salidas
FOR INSERT
AS
declare @empleado VARCHAR(100)
SELECT @empleado = e.nombre from empleados e
UPDATE empleados SET Estatus = 'Inactivo' WHERE nombre = @empleado;
PRINT 'Trigger realizado'
GO

--Vista de los empleados que ingresaron en un mes especifico
--procedimiento que recibe por parametro el mes del usuario y muestra todos los empleados que ingresaron en ese mes

--Vista de los empleados que se inactivaron en un mes especifico
--procedimiento que recibe por parametro el mes del usuario y muestra todos los empleados que se inactivaron en ese mes

--Vista de los permisos de un empleado determinado
--procedimiento que recibe por parametro el codigo del empleado y devuelve los permisos que este ha tomado
/*
DROP VIEW VER_CARGOS;
DROP VIEW DEPTS;

DROP TABLE LICENCIAS;
DROP TABLE PERMISOS;
DROP TABLE VACACIONES;
DROP TABLE SALIDAS;
DROP TABLE NOMINAS;
DROP TABLE CARGOS;
DROP TABLE DEPARTAMENTOS;
DROP TABLE EMPLEADOS;*/