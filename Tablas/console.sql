set search_path = "public";

-- PELICULAS
CREATE TABLE Pelicula
(
    id              varchar(9),
    nombre          varchar(50),
    idioma          varchar(10),
    resenha         varchar(100),
    fecha_estreno   date,
    fecha_adquision date
);

CREATE TABLE Actor
(
    id              varchar(9),
    nombre          varchar(50),
);

CREATE TABLE Director
(
    id              varchar(9),
    nombre          varchar(50)
);

CREATE TABLE Genero
(
    id              int,
    nombre          varchar(10),
);
CREATE TABLE Nivel_Publico
(
    id              int,
    nombre          varchar(10),
);