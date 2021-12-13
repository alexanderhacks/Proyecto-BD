DROP SCHEMA IF EXISTS cinemania100000 CASCADE;
CREATE SCHEMA cinemania100000;
SET search_path TO cinemania100000;
SHOW search_path;

-- CLIENTES
CREATE TABLE "Clientes"
(
    id        VARCHAR(10) NOT NULL,
    nombres   VARCHAR(50) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    correo    VARCHAR(50),
    celular   VARCHAR(9)
);
ALTER TABLE "Clientes"
    ADD CONSTRAINT "pk_clientes" PRIMARY KEY (id);

-- CLIENTES VACUNADOS
CREATE TABLE "ClientesVacunados"
(
    cliente_id  VARCHAR(10) NOT NULL,
    nro_certificado VARCHAR(10) NOT NULL
);
ALTER TABLE "ClientesVacunados"
    ADD CONSTRAINT "pk_clientesvacunados"
        PRIMARY KEY(cliente_id),
    ADD CONSTRAINT "fk_clienteid_clientesvacunados"
        FOREIGN KEY (cliente_id) REFERENCES "Clientes" (id);

-- CUENTA BANCARIA
CREATE TABLE "CuentaBancaria"
(
    numero_cuenta VARCHAR(20) NOT NULL,
    cliente_id    VARCHAR(10) NOT NULL,
    tipo_cuenta   VARCHAR(15) NOT NULL
);
ALTER TABLE "CuentaBancaria"
    ADD CONSTRAINT "pk_cuentabancaria"
        PRIMARY KEY (numero_cuenta),
    ADD CONSTRAINT "fk_cuentabancaria"
        FOREIGN KEY (cliente_id) REFERENCES "Clientes" (id)
        ON DELETE SET NULL ON UPDATE CASCADE;

-- MEMBRESÍA
CREATE TABLE "Membresia"
(
    id     VARCHAR(10) NOT NULL,
    nombre VARCHAR(50) NOT NULL
);
ALTER TABLE "Membresia"
    ADD CONSTRAINT "pk_membresia" PRIMARY KEY (id);

-- SOCIO
CREATE TABLE "Socios"
(
    cliente_id   VARCHAR(10) NOT NULL,
    membresia_id VARCHAR(10) NOT NULL
);
ALTER TABLE "Socios"
    ADD CONSTRAINT "pk_socios"
        PRIMARY KEY (cliente_id),
    ADD CONSTRAINT "fk_membresia_cliente"
        FOREIGN KEY (membresia_id) REFERENCES "Membresia" (id)
            ON DELETE SET NULL ON UPDATE CASCADE,
    ADD CONSTRAINT "fk_cliente_membresia"
        FOREIGN KEY (cliente_id) REFERENCES "Clientes" (id)
            ON DELETE SET NULL ON UPDATE CASCADE;

-- AREA TRABAJO
CREATE TABLE "PuestoTrabajo"
(
    id     VARCHAR(10) NOT NULL,
    nombre VARCHAR(50) NOT NULL
);
ALTER TABLE "PuestoTrabajo"
    ADD CONSTRAINT "pk_areatrabajo" PRIMARY KEY (id);

-- COLABORADORES
CREATE TABLE "Colaboradores"
(
    id             VARCHAR(10) NOT NULL,
    nro_documento  VARCHAR(10)  NOT NULL,
    tipo_documento VARCHAR(10) NOT NULL,
    nombres        VARCHAR(50) NOT NULL,
    apellidos      VARCHAR(50) NOT NULL,
    celular        VARCHAR(9)  NOT NULL,
    correo         VARCHAR(50) NOT NULL,
    cuenta_colaborador VARCHAR(20) DEFAULT NULL,
    areatrabajo_id VARCHAR(10) NOT NULL
);
ALTER TABLE "Colaboradores"
    ADD CONSTRAINT "pk_colaboradores"
        PRIMARY KEY (id),
    ADD CONSTRAINT "fk_colaboradores_trabajo"
        FOREIGN KEY (areatrabajo_id) REFERENCES "PuestoTrabajo" (id);

-- USUARIO
CREATE TABLE "Usuario"
(
    id           VARCHAR(10)   NOT NULL,
    usuario      VARCHAR(50) NOT NULL,
    "contrasena" VARCHAR(15)    NOT NULL
);
ALTER TABLE "Usuario"
    ADD CONSTRAINT "pk_usuario" PRIMARY KEY (id);

-- SUELDO COLABORADOR
CREATE TABLE "SueldoColaborador"
(
    id             VARCHAR(10) NOT NULL,
    colaborador_id VARCHAR(10) NOT NULL,
    fecha_inicio   DATE        NOT NULL,
    fecha_final    DATE        NOT NULL,
    sueldo         FLOAT8      NOT NULL
);
ALTER TABLE "SueldoColaborador"
    ADD CONSTRAINT "pk_sueldocolaborador"
        PRIMARY KEY (id),
    ADD CONSTRAINT "fk_sueldocolaborador"
        FOREIGN KEY (colaborador_id) REFERENCES "Colaboradores" (id);

-- ADMINISTRADORES
CREATE TABLE "Administradores"
(
    id            VARCHAR(10) NOT NULL,
    nivel_permiso VARCHAR(15)    NOT NULL
);
ALTER TABLE "Administradores"
    ADD CONSTRAINT "pk_administradores"
        PRIMARY KEY (id),
    ADD CONSTRAINT "fk_administradores"
        FOREIGN KEY (id) REFERENCES "Colaboradores" (id);

-- TIPO COLABORADOR
CREATE TABLE "TipoColaborador"
(
    id            VARCHAR(10) NOT NULL,
    especialidad  VARCHAR(30) NOT NULL,
    rango_permiso int8        NOT NULL
);
ALTER TABLE "TipoColaborador"
    ADD CONSTRAINT "pk_tipocolaborador" PRIMARY KEY (id);


-- USUARIO ADMINISTRADORES
CREATE TABLE "UsuarioAdministrador"
(
    usuario_id          VARCHAR(10) NOT NULL,
    administrador_id    VARCHAR(10) NOT NULL
);
ALTER TABLE "UsuarioAdministrador"
    ADD CONSTRAINT "pk_usuario_usuarioadmin"
        PRIMARY KEY (usuario_id),
    ADD CONSTRAINT "fk_administrador_usuarioadmin"
        FOREIGN KEY (administrador_id) REFERENCES "Administradores"(id),
    ADD CONSTRAINT "fk_usuario_usuarioadmin"
        FOREIGN KEY (usuario_id) REFERENCES "Usuario"(id);

-- USUARIO COLABORADOR
CREATE TABLE "UsuarioColaborador"
(
    id                           VARCHAR(10) not null,
    colaborador_id               VARCHAR(10) NOT NULL,
    usuario_id                   VARCHAR(10)   NOT NULL,
    tipocolaborador_id           VARCHAR(10) NOT NULL

);
ALTER TABLE "UsuarioColaborador"
    ADD CONSTRAINT "pk_usuariocolaborador"
        PRIMARY KEY (id),
    ADD CONSTRAINT "fk_colaboradorid_usuariocolaborador"
        FOREIGN KEY (colaborador_id) REFERENCES "Colaboradores" (id),
    ADD CONSTRAINT "fk_usuarioid_usuariocolaborador"
        FOREIGN KEY (usuario_id) REFERENCES "Usuario" (id),
    ADD CONSTRAINT "fk_tipocolaborador_usuariocolaborador_id"
        FOREIGN KEY (tipocolaborador_id) REFERENCES "TipoColaborador" (id);

-- USUARIO CLIENTE
CREATE TABLE "UsuarioCliente"
(
    usuario_id      VARCHAR(10)   NOT NULL,
    cliente_id      VARCHAR(10) NOT NULL,
    telefono        VARCHAR(9),
    numero_cuenta   VARCHAR(20) NOT NULL
);
ALTER TABLE "UsuarioCliente"
    ADD CONSTRAINT "pk_usuarioid_usuariocliente"
        PRIMARY KEY (usuario_id),
    ADD CONSTRAINT "fk_clienteid_usuariocliente"
        FOREIGN KEY (cliente_id) REFERENCES "Clientes" (id),
    ADD CONSTRAINT "fk_usuarioid_usuariocliente"
        FOREIGN KEY (usuario_id) REFERENCES "Usuario" (id),
    ADD CONSTRAINT "fk_numerocuenta_usuariocliente"
        FOREIGN KEY (numero_cuenta) REFERENCES "CuentaBancaria" (numero_cuenta);

-- SEDE
CREATE TABLE "Sede"
(
    id           VARCHAR(10) NOT NULL,
    nombre       VARCHAR(50) NOT NULL,
    direccion    VARCHAR(50) NOT NULL,
    departamento VARCHAR(50) NOT NULL,
    distrito     VARCHAR(50) NOT NULL,
    n_salas      SMALLINT    NOT NULL

);
ALTER TABLE "Sede"
    ADD CONSTRAINT "pl_sede" PRIMARY KEY (id);

-- GENERO
CREATE TABLE "Genero"
(
    id     VARCHAR(10) NOT NULL,
    nombre VARCHAR(20) NOT NULL
);
ALTER TABLE "Genero"
    ADD CONSTRAINT "pk_genero" PRIMARY KEY (id);

-- NIVEL PUBLICO
CREATE TABLE "NivelPublico"
(
    id         VARCHAR(10) NOT NULL,
    rango_edad VARCHAR    NOT NULL
);
ALTER TABLE "NivelPublico"
    ADD CONSTRAINT "pk_nivelpublico" PRIMARY KEY (id);

-- ACTORES
CREATE TABLE "Actores"
(
    id     VARCHAR(10) NOT NULL,
    nombre VARCHAR(50) NOT NULL
);
ALTER TABLE "Actores"
    ADD CONSTRAINT "pk_actores" PRIMARY KEY (id);

-- DIRECTORES
CREATE TABLE "Directores"
(
    id     VARCHAR(10) NOT NULL,
    nombre VARCHAR(50) NOT NULL
);
ALTER TABLE "Directores"
    ADD CONSTRAINT "pk_directores" PRIMARY KEY (id);

-- PELICULAS
CREATE TABLE "Peliculas"
(
    id              VARCHAR(10)  NOT NULL,
    nombre          VARCHAR(50)  NOT NULL,
    idioma          VARCHAR(20)  NOT NULL,
    fecha_adquision DATE         NOT NULL,
    fecha_estreno   DATE         NOT NULL,
    genero_id       VARCHAR(10)  NOT NULL,
    duracion_h      FLOAT        NOT NULL,
    resena          VARCHAR(100) NOT NULL,
    nivelpublico_id VARCHAR(10)  NOT NULL
);
ALTER TABLE "Peliculas"
    ADD CONSTRAINT "pk_peliculas"
        PRIMARY KEY (id),
    ADD CONSTRAINT "fk_generoid_peliculas"
        FOREIGN KEY (genero_id) REFERENCES "Genero" (id),
    ADD CONSTRAINT "fk_nivelpublicoid_peliculas"
        FOREIGN KEY (nivelpublico_id) REFERENCES "NivelPublico" (id);

-- SALA
CREATE TABLE "Sala"
(
    id           VARCHAR(10) NOT NULL,
    sede_id      VARCHAR(10) NOT NULL,
    numero_sala  SMALLINT    NOT NULL,
    n_butacas    SMALLINT    NOT NULL
);
ALTER TABLE "Sala"
    ADD CONSTRAINT "pk_sala"
        PRIMARY KEY (id),
    ADD CONSTRAINT "fk_sedeid_sala"
        FOREIGN KEY (sede_id) REFERENCES "Sede" (id);

-- FUNCION
CREATE TABLE "Funcion"
(
    funcion_id  VARCHAR(10) NOT NULL,
    sala_id     VARCHAR(10) NOT NULL,
    pelicula_id VARCHAR(10) NOT NULL,
    fecha       DATE        NOT NULL,
    hora        TIME   NOT NULL
);
ALTER TABLE "Funcion"
    ADD CONSTRAINT "pk_funcion"
        PRIMARY KEY (funcion_id),
    ADD CONSTRAINT "fk_salaid_funcion"
        FOREIGN KEY (sala_id) REFERENCES "Sala"(id),
    ADD CONSTRAINT "fk_pelicula_funcion_nombre"
        FOREIGN KEY (pelicula_id) REFERENCES "Peliculas" (id);

-- FUNCION CON VACUNA
CREATE TABLE "FuncionVacuna"
(
    funcion_id VARCHAR(10) NOT NULL
);
ALTER TABLE "FuncionVacuna"
    ADD CONSTRAINT "pk_funcionvacuna"
        PRIMARY KEY (funcion_id),
    ADD CONSTRAINT "fk_funcionvacuna"
        FOREIGN KEY (funcion_id) REFERENCES "Funcion"(funcion_id);

-- PRODUCTO
CREATE TABLE "Producto"
(
    id           VARCHAR(10) NOT NULL,
    nombre       VARCHAR(50) NOT NULL,
    descripcion  VARCHAR(50),
    precio_venta FLOAT       NOT NULL
);
ALTER TABLE "Producto"
    ADD CONSTRAINT "pk_producto" PRIMARY KEY (id);

-- VENTAS
CREATE TABLE "Venta"
(
    id         VARCHAR(10) NOT NULL,
    cliente_id VARCHAR(10) NOT NULL,
    colaborador_id  VARCHAR(10) NOT NULL,
    fecha      DATE        NOT NULL,
    hora       TIME   NOT NULL,
    qr_id          VARCHAR(50) NOT NULL
);
ALTER TABLE "Venta"
    ADD CONSTRAINT "pk_venta"
        PRIMARY KEY (id),
    ADD CONSTRAINT "fk_clienteid_venta"
        FOREIGN KEY (cliente_id) REFERENCES "Clientes" (id),
    ADD CONSTRAINT "fk_colaboradorid_venta"
        FOREIGN KEY (colaborador_id) REFERENCES "Colaboradores" (id);

-- VENTA ENTRADA
CREATE TABLE "VentaEntrada"
(
    id     VARCHAR(10) not null,
    venta_id       VARCHAR(10) NOT NULL
);
ALTER TABLE "VentaEntrada"
    ADD CONSTRAINT "pk_ventaentrada"
        PRIMARY KEY (id),
    ADD CONSTRAINT "fk_ventaid_ventaentrada"
        FOREIGN KEY (venta_id) REFERENCES "Venta" (id);

-- BUTACA FUNCION
CREATE TABLE "ButacaFuncion"
(
    butaca_id       VARCHAR(10) NOT NULL,
    ventaentrada_id VARCHAR(10) NOT NULL,
    funcion_id      VARCHAR(10) NOT NULL,
    nro_fila        VARCHAR(1)    NOT NULL,
    nro_columna     SMALLINT    NOT NULL,
    tipo_entrada   VARCHAR(10) NOT NULL,
    precio_entrada FLOAT       NOT NULL
);
ALTER TABLE "ButacaFuncion"
    ADD CONSTRAINT "butacafuncion_id"
        PRIMARY KEY (butaca_id, ventaentrada_id),
    ADD CONSTRAINT "fk_funcion_butacafuncion"
        FOREIGN KEY (funcion_id) REFERENCES "Funcion" (funcion_id),
    ADD CONSTRAINT "fk_ventaentrada_id"
        FOREIGN KEY (ventaentrada_id) REFERENCES "VentaEntrada" (id);

-- VENTA PRODUCTO
CREATE TABLE "VentaProducto"
(   -- agregar id
    venta_id    VARCHAR(10) NOT NULL,
    producto_id VARCHAR(10) NOT NULL,
    cantidad    SMALLINT    NOT NULL,
    precio      SMALLINT    NOT NULL
);
ALTER TABLE "VentaProducto"
    ADD CONSTRAINT "pk_ventaproducto"
        PRIMARY KEY (venta_id, producto_id),
    ADD CONSTRAINT "fk_ventaid_ventaproducto"
        FOREIGN KEY (venta_id) REFERENCES "Venta" (id),
    ADD CONSTRAINT "fk_productoid_ventaproducto"
        FOREIGN KEY (producto_id) REFERENCES "Producto" (id);

-- ACTUA
CREATE TABLE "Actua"
(
    pelicula_id VARCHAR(10),
    actor_id    VARCHAR(10)
);
ALTER TABLE "Actua"
    ADD CONSTRAINT "pk_actua"
        PRIMARY KEY (pelicula_id, actor_id),
    ADD CONSTRAINT "fk_pelicula_actua" FOREIGN KEY (pelicula_id)
        REFERENCES "Peliculas" (id),
    ADD CONSTRAINT "fk_actor_actua" FOREIGN KEY (actor_id)
        REFERENCES "Actores" (id);

CREATE TABLE "Dirige"
(
    pelicula_id VARCHAR(10),
    director_id VARCHAR(10)
);
ALTER TABLE "Dirige"
    ADD CONSTRAINT "pk_dirige"
        PRIMARY KEY (pelicula_id, director_id),
    ADD CONSTRAINT "fk_pelicula_dirige" FOREIGN KEY (pelicula_id) REFERENCES "Peliculas" (id),
    ADD CONSTRAINT "fk_director_dirige" FOREIGN KEY (director_id) REFERENCES "Directores" (id);



TRUNCATE "Clientes" CASCADE;
COPY "Clientes" FROM 'C:\Users\Jeremy\Desktop\bd1P\Proyecto-BD\Data-Generator\cinemania100K\clientes.csv'
    DELIMITER ',' CSV HEADER;
SELECT * FROM "Clientes";

TRUNCATE "PuestoTrabajo" CASCADE;
COPY "PuestoTrabajo" FROM 'C:\Users\Jeremy\Desktop\bd1P\Proyecto-BD\Data-Generator\cinemania100K\puestoTrabajo.csv'
    DELIMITER ',' CSV HEADER;
SELECT * FROM "PuestoTrabajo";  -- ==

TRUNCATE "CuentaBancaria" CASCADE;
COPY "CuentaBancaria" FROM 'C:\Users\Jeremy\Desktop\bd1P\Proyecto-BD\Data-Generator\cinemania100K\cuentaBancaria.csv'
    DELIMITER ',' CSV HEADER;
SELECT * FROM "CuentaBancaria";

TRUNCATE "Producto" CASCADE;
COPY "Producto" FROM 'C:\Users\Jeremy\Desktop\bd1P\Proyecto-BD\Data-Generator\cinemania100K\productos.csv'
    DELIMITER ',' CSV HEADER;               -- ==
SELECT * FROM "Producto";

TRUNCATE "Sede" CASCADE;
COPY "Sede" FROM 'C:\Users\Jeremy\Desktop\bd1P\Proyecto-BD\Data-Generator\cinemania100K\sede.csv'
    DELIMITER ',' CSV HEADER;
SELECT * FROM "Sede";

TRUNCATE "Colaboradores" CASCADE;
COPY "Colaboradores" FROM 'C:\Users\Jeremy\Desktop\bd1P\Proyecto-BD\Data-Generator\cinemania100K\colaboradores.csv'
    DELIMITER ',' CSV HEADER;
SELECT * FROM "Colaboradores";

TRUNCATE "ClientesVacunados" CASCADE;
COPY "ClientesVacunados" FROM 'C:\Users\Jeremy\Desktop\bd1P\Proyecto-BD\Data-Generator\cinemania100K\clientesVacunados.csv'
    DELIMITER ',' CSV HEADER;
SELECT * FROM "ClientesVacunados";

TRUNCATE "Actores" CASCADE;
COPY "Actores" FROM 'C:\Users\Jeremy\Desktop\bd1P\Proyecto-BD\Data-Generator\cinemania100K\actores.csv'
    DELIMITER ',' CSV HEADER;
SELECT * FROM "Actores";        -- ==

TRUNCATE "Genero" CASCADE;
COPY "Genero" FROM 'C:\Users\Jeremy\Desktop\bd1P\Proyecto-BD\Data-Generator\cinemania100K\genero.csv'
    DELIMITER ',' CSV HEADER;
SELECT * FROM "Genero";         -- ==

TRUNCATE "Directores" CASCADE;
COPY "Directores" FROM 'C:\Users\Jeremy\Desktop\bd1P\Proyecto-BD\Data-Generator\cinemania100K\directores.csv'
    DELIMITER ',' CSV HEADER;
SELECT * FROM "Directores";     -- ==

TRUNCATE "NivelPublico" CASCADE;
COPY "NivelPublico" FROM 'C:\Users\Jeremy\Desktop\bd1P\Proyecto-BD\Data-Generator\cinemania100K\nivelPublico.csv'
    DELIMITER ',' CSV HEADER;
SELECT * FROM "NivelPublico";   -- ==

TRUNCATE "Peliculas" CASCADE;
COPY "Peliculas" FROM 'C:\Users\Jeremy\Desktop\bd1P\Proyecto-BD\Data-Generator\cinemania100K\peliculas.csv'
    DELIMITER ',' CSV HEADER;
SELECT * FROM "Peliculas";      -- ==

TRUNCATE "Actua" CASCADE;
COPY "Actua" FROM 'C:\Users\Jeremy\Desktop\bd1P\Proyecto-BD\Data-Generator\cinemania100K\actua.csv'
    DELIMITER ',' CSV HEADER;
SELECT * FROM "Actua";

TRUNCATE "Sala" CASCADE;
COPY "Sala" FROM 'C:\Users\Jeremy\Desktop\bd1P\Proyecto-BD\Data-Generator\cinemania100K\sala.csv'
    DELIMITER ',' CSV HEADER;
SELECT * FROM "Sala";


TRUNCATE "Funcion" CASCADE;
COPY "Funcion" FROM 'C:\Users\Jeremy\Desktop\bd1P\Proyecto-BD\Data-Generator\cinemania100K\funcion.csv'
    DELIMITER ',' CSV HEADER;
SELECT * FROM "Funcion";

TRUNCATE "FuncionVacuna" CASCADE;
COPY "FuncionVacuna" FROM 'C:\Users\Jeremy\Desktop\bd1P\Proyecto-BD\Data-Generator\cinemania100K\funcionVacuna.csv'
    DELIMITER ',' CSV HEADER;
SELECT * FROM "FuncionVacuna";

TRUNCATE "Membresia" CASCADE;
COPY "Membresia" FROM 'C:\Users\Jeremy\Desktop\bd1P\Proyecto-BD\Data-Generator\cinemania100K\membresia.csv'
    DELIMITER ',' CSV HEADER;               -- ==
SELECT * FROM "Membresia";

TRUNCATE "Socios" CASCADE;
COPY "Socios" FROM 'C:\Users\Jeremy\Desktop\bd1P\Proyecto-BD\Data-Generator\cinemania100K\socios.csv'
    DELIMITER ',' CSV HEADER;
SELECT * FROM "Socios";

TRUNCATE "Administradores" CASCADE;
COPY "Administradores" FROM 'C:\Users\Jeremy\Desktop\bd1P\Proyecto-BD\Data-Generator\cinemania100K\administradores.csv'
    DELIMITER ',' CSV HEADER;
SELECT * FROM "Administradores";

TRUNCATE "Usuario" CASCADE;
COPY "Usuario" FROM 'C:\Users\Jeremy\Desktop\bd1P\Proyecto-BD\Data-Generator\cinemania100K\usuario.csv'
    DELIMITER ',' CSV HEADER;
SELECT * FROM "Usuario";

TRUNCATE "SueldoColaborador" CASCADE;
COPY "SueldoColaborador" FROM 'C:\Users\Jeremy\Desktop\bd1P\Proyecto-BD\Data-Generator\cinemania100K\sueldoColaborador.csv'
    DELIMITER ',' CSV HEADER;
SELECT * FROM "SueldoColaborador";

TRUNCATE "UsuarioAdministrador" CASCADE;
COPY "UsuarioAdministrador" FROM 'C:\Users\Jeremy\Desktop\bd1P\Proyecto-BD\Data-Generator\cinemania100K\usuarioAdministrador.csv'
    DELIMITER ',' CSV HEADER;
SELECT * FROM "UsuarioAdministrador";

TRUNCATE "UsuarioCliente" CASCADE;
COPY "UsuarioCliente" FROM 'C:\Users\Jeremy\Desktop\bd1P\Proyecto-BD\Data-Generator\cinemania100K\usuarioCliente.csv'
    DELIMITER ',' CSV HEADER;
SELECT * FROM "UsuarioCliente";

TRUNCATE "TipoColaborador" CASCADE;
COPY "TipoColaborador" FROM 'C:\Users\Jeremy\Desktop\bd1P\Proyecto-BD\Data-Generator\cinemania100K\tipoColaborador.csv'
    DELIMITER ',' CSV HEADER;
SELECT * FROM "TipoColaborador";            -- ==

TRUNCATE "UsuarioColaborador" CASCADE;
COPY "UsuarioColaborador" FROM 'C:\Users\Jeremy\Desktop\bd1P\Proyecto-BD\Data-Generator\cinemania100K\usuarioColaborador.csv'
    DELIMITER ',' CSV HEADER;
SELECT * FROM "UsuarioColaborador";

TRUNCATE "Venta" CASCADE;
COPY "Venta" FROM 'C:\Users\Jeremy\Desktop\bd1P\Proyecto-BD\Data-Generator\cinemania100K\venta.csv'
    DELIMITER ',' CSV HEADER;
SELECT * FROM "Venta";

TRUNCATE "VentaEntrada" CASCADE;
COPY "VentaEntrada" FROM 'C:\Users\Jeremy\Desktop\bd1P\Proyecto-BD\Data-Generator\cinemania100K\ventaEntrada.csv'
    DELIMITER ',' CSV HEADER;
SELECT * FROM "VentaEntrada";

TRUNCATE "VentaProducto" CASCADE;
COPY "VentaProducto" FROM 'C:\Users\Jeremy\Desktop\bd1P\Proyecto-BD\Data-Generator\cinemania100K\VentaProducto.csv'
    DELIMITER ',' CSV HEADER;
SELECT * FROM "VentaProducto";

TRUNCATE "ButacaFuncion" CASCADE;
COPY "ButacaFuncion" FROM 'C:\Users\Jeremy\Desktop\bd1P\Proyecto-BD\Data-Generator\cinemania100K\butacaFuncion.csv'
    DELIMITER ',' CSV HEADER;
SELECT * FROM "ButacaFuncion";
