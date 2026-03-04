create database Anemia
use Anemia
go

CREATE TABLE DIM_ETNIA (
    id_etnia INT IDENTITY(1,1) PRIMARY KEY,
    etnia VARCHAR(30)
);
go

CREATE TABLE DIM_TIEMPO (
    id_tiempo INT IDENTITY(1,1) PRIMARY KEY,
    dia INT,
    mes INT,
    years INT
);
go

CREATE TABLE DIM_PROVINCIA (
    id_provincia INT IDENTITY(1,1) PRIMARY KEY,
    provincia VARCHAR(50)
);
go

CREATE TABLE DIM_DISTRITO (
    id_distrito INT IDENTITY(1,1) PRIMARY KEY,
    distrito VARCHAR(50)
);
go

CREATE TABLE DIM_ESTABLECIMIENTO (
    codigo_unico INT PRIMARY KEY,
    nombre_establecimiento VARCHAR(100)
);
go

CREATE TABLE DIM_SEVERIDAD (
    id_severidad INT IDENTITY(1,1) PRIMARY KEY,
    severidad VARCHAR(5)
);
go

CREATE TABLE DIM_DIAGNOSTICO (
    id_diagnostico INT IDENTITY(1,1) PRIMARY KEY,
    diagnostico VARCHAR(100)
);
go

CREATE TABLE DIM_SEGURO (
    id_seguro INT IDENTITY(1,1) PRIMARY KEY,
    seguro VARCHAR(50)
);
go

CREATE TABLE FACT_PACIENTE_ANEMIA (
    PK_registro INT,
    id_tiempo INT,
    id_provincia INT,
    id_distrito INT,
    codigo_unico INT,
    id_severidad INT,
    id_diagnostico INT,
    id_seguro INT,
    id_etnia INT,
    genero VARCHAR(5),
    edad INT,
    cantidad INT,

    FOREIGN KEY (id_tiempo) REFERENCES DIM_TIEMPO(id_tiempo),
    FOREIGN KEY (id_provincia) REFERENCES DIM_PROVINCIA(id_provincia),
    FOREIGN KEY (id_distrito) REFERENCES DIM_DISTRITO(id_distrito),
    FOREIGN KEY (codigo_unico) REFERENCES DIM_ESTABLECIMIENTO(codigo_unico),
    FOREIGN KEY (id_severidad) REFERENCES DIM_SEVERIDAD(id_severidad),
    FOREIGN KEY (id_diagnostico) REFERENCES DIM_DIAGNOSTICO(id_diagnostico),
    FOREIGN KEY (id_seguro) REFERENCES DIM_SEGURO(id_seguro),
    FOREIGN KEY (id_etnia) REFERENCES DIM_ETNIA(id_etnia)
);
go

SELECT * FROM FACT_PACIENTE_ANEMIA;
SELECT F.PK_registro,T.dia,T.mes,T.years,P.provincia, D.distrito,E.nombre_establecimiento, S.severidad,
    DG.diagnostico, SG.seguro,ET.etnia,F.genero,F.edad,F.cantidad
FROM FACT_PACIENTE_ANEMIA F
	LEFT JOIN DIM_TIEMPO T ON F.id_tiempo = T.id_tiempo
	LEFT JOIN DIM_PROVINCIA P ON F.id_provincia = P.id_provincia
	LEFT JOIN DIM_DISTRITO D ON F.id_distrito = D.id_distrito
	LEFT JOIN DIM_ESTABLECIMIENTO E ON F.codigo_unico = E.codigo_unico
	LEFT JOIN DIM_SEVERIDAD S ON F.id_severidad = S.id_severidad
	LEFT JOIN DIM_DIAGNOSTICO DG ON F.id_diagnostico = DG.id_diagnostico
	LEFT JOIN DIM_SEGURO SG ON F.id_seguro = SG.id_seguro
	LEFT JOIN DIM_ETNIA ET ON F.id_etnia = ET.id_etnia 
WHERE F.PK_registro = 1
go

DELETE FROM FACT_PACIENTE_ANEMIA;
DELETE FROM DIM_TIEMPO;
DELETE FROM DIM_PROVINCIA;
DELETE FROM DIM_DISTRITO;
DELETE FROM DIM_ESTABLECIMIENTO;
DELETE FROM DIM_SEVERIDAD;
DELETE FROM DIM_DIAGNOSTICO;
DELETE FROM DIM_SEGURO;
DELETE FROM DIM_ETNIA;
go
