set search_path = "public";

-- PELICULAS
CREATE TABLE Peliculas
(
    id              varchar(9),
    nombre          varchar(50),
    idioma          varchar(10),
    resenha         varchar(100),
    fecha_estreno   date,
    fecha_adquision date
);

