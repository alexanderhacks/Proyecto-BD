SHOW search_path;
SET search_path TO public;
DROP SCHEMA public CASCADE;
CREATE SCHEMA public;

set search_path = "public";

-- CLIENTES
CREATE TABLE public."Clientes"
(
    id        VARCHAR(10) NOT NULL,
    nombres   VARCHAR(50) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    correo    VARCHAR(50),
    celular   VARCHAR(9)
);
ALTER TABLE public."Clientes"
    ADD CONSTRAINT "pk_clientes" PRIMARY KEY (id);

-- CLIENTES VACUNADOS

-- CUENTA BANCARIA
CREATE TABLE public."CuentaBancaria"
(
    numero_cuenta VARCHAR(20) NOT NULL,
    cliente_id    VARCHAR(10) NOT NULL,
    tipo_cuenta   VARCHAR(15) NOT NULL
);
ALTER TABLE public."CuentaBancaria"
    ADD CONSTRAINT "pk_cuentabancaria"
        PRIMARY KEY (numero_cuenta),
    ADD CONSTRAINT "fk_cuentabancaria"
        FOREIGN KEY (cliente_id) REFERENCES public."Clientes" (id)
        ON DELETE SET NULL ON UPDATE CASCADE;

-- MEMBRESÍA
CREATE TABLE public."Membresia"
(
    id     VARCHAR(10) NOT NULL,
    nombre VARCHAR(50) NOT NULL
);
ALTER TABLE public."Membresia"
    ADD CONSTRAINT "pk_membresia" PRIMARY KEY (id);

-- SOCIO
CREATE TABLE public."Socios"
(
    cliente_id   VARCHAR(10) NOT NULL,
    membresia_id VARCHAR(10) NOT NULL
);
ALTER TABLE public."Socios"
    ADD CONSTRAINT "pk_socios"
        PRIMARY KEY (cliente_id),
    ADD CONSTRAINT "fk_membresia_cliente"
        FOREIGN KEY (membresia_id) REFERENCES public."Membresia" (id)
            ON DELETE SET NULL ON UPDATE CASCADE,
    ADD CONSTRAINT "fk_cliente_membresia"
        FOREIGN KEY (cliente_id) REFERENCES public."Clientes" (id)
            ON DELETE SET NULL ON UPDATE CASCADE;

-- AREA TRABAJO
CREATE TABLE public."AreaTrabajo"
(
    id     VARCHAR(10) NOT NULL,
    nombre VARCHAR(50) NOT NULL
);
ALTER TABLE public."AreaTrabajo"
    ADD CONSTRAINT "pk_areatrabajo" PRIMARY KEY (id);

-- COLABORADORES
CREATE TABLE public."Colaboradores"
(
    id             VARCHAR(10) NOT NULL,
    nro_documento  VARCHAR(8)  NOT NULL,
    tipo_documento VARCHAR(10) NOT NULL,
    nombres        VARCHAR(50) NOT NULL,
    apellidos      VARCHAR(50) NOT NULL,
    celular        VARCHAR(9)  NOT NULL,
    correo         VARCHAR(50) NOT NULL,
    numero_cuenta  VARCHAR(20) NOT NULL,
    areatrabajo_id VARCHAR(10) NOT NULL
);
ALTER TABLE public."Colaboradores"
    ADD CONSTRAINT "pk_colaboradores"
        PRIMARY KEY (id),
    ADD CONSTRAINT "fk_colaboradores_trabajo"
        FOREIGN KEY (areatrabajo_id) REFERENCES public."AreaTrabajo" (id),
    ADD CONSTRAINT "fk_colaboradores_cuentabanco"
       FOREIGN KEY (numero_cuenta) REFERENCES public."CuentaBancaria" (numero_cuenta);

-- USUARIO
CREATE TABLE public."Usuario"
(
    id           BIGSERIAL   NOT NULL,
    usuario      VARCHAR(15) NOT NULL,
    "contrasena" VARCHAR     NOT NULL
);
ALTER TABLE public."Usuario"
    ADD CONSTRAINT "pk_usuario" PRIMARY KEY (id);

-- SUELDO COLABORADOR
CREATE TABLE public."SueldoColaborador"
(
    colaborador_id VARCHAR(10) NOT NULL,
    fecha_inicio   DATE        NOT NULL,
    fecha_final    DATE        NOT NULL,
    sueldo         FLOAT8      NOT NULL

);
ALTER TABLE public."SueldoColaborador"
    ADD CONSTRAINT "pk_sueldocolaborador"
        PRIMARY KEY (colaborador_id),
    ADD CONSTRAINT "fk_sueldocolaborador"
        FOREIGN KEY (colaborador_id) REFERENCES public."Colaboradores" (id);

-- ADMINISTRADORES
CREATE TABLE public."Administradores"
(
    id            VARCHAR(10) NOT NULL,
    nivel_permiso SMALLINT    NOT NULL
);
ALTER TABLE public."Administradores"
    ADD CONSTRAINT "pk_administradores"
        PRIMARY KEY (id),
    ADD CONSTRAINT "fk_administradores"
        FOREIGN KEY (id) REFERENCES public."Colaboradores" (id);

-- USUARIO ADMINISTRADORES
CREATE TABLE public."UsuarioAdministrador"
(
    administrador_id    VARCHAR(10) NOT NULL,
    usuario_id          BIGSERIAL   NOT NULL
);
ALTER TABLE public."UsuarioAdministrador"
    ADD CONSTRAINT "fk_administrador_usuarioadmin"
        FOREIGN KEY (administrador_id) REFERENCES "Administradores"(id),
    ADD CONSTRAINT "fk_usuario_usuarioadmin"
        FOREIGN KEY (usuario_id) REFERENCES "Usuario"(id);

-- TIPO COLABORADOR
CREATE TABLE public."TipoColaborador"
(
    id            VARCHAR(10) NOT NULL,
    especialidad  VARCHAR(30) NOT NULL,
    rango_permiso int8        NOT NULL
);
ALTER TABLE public."TipoColaborador"
    ADD CONSTRAINT "pk_tipocolaborador" PRIMARY KEY (id);

-- USUARIO COLABORADOR
CREATE TABLE public."UsuarioColaborador"
(
    id                           VARCHAR(10) not null,
    colaborador_id               VARCHAR(10) NOT NULL,
    usuario_id                   BIGSERIAL   NOT NULL,
    tipocolaborador_id           VARCHAR(10) NOT NULL

);
ALTER TABLE public."UsuarioColaborador"
    ADD CONSTRAINT "pk_usuariocolaborador"
        PRIMARY KEY (id),
    ADD CONSTRAINT "fk_colaboradorid_usuariocolaborador"
        FOREIGN KEY (colaborador_id) REFERENCES "Colaboradores" (id),
    ADD CONSTRAINT "fk_usuarioid_usuariocolaborador"
        FOREIGN KEY (usuario_id) REFERENCES "Usuario" (id),
    ADD CONSTRAINT "fk_tipocolaborador_usuariocolaborador_id"
        FOREIGN KEY (tipocolaborador_id) REFERENCES "TipoColaborador" (id);

-- USUARIO CLIENTE
CREATE TABLE public."UsuarioCliente"
(
    cliente_id      VARCHAR(10) NOT NULL,
    usuario_id      BIGSERIAL   NOT NULL,
    telefono        VARCHAR(9),
    numero_cuenta   VARCHAR(20) NOT NULL
);
ALTER TABLE public."UsuarioCliente"
    ADD CONSTRAINT "fk_clienteid_usuariocliente"
        FOREIGN KEY (cliente_id) REFERENCES "Clientes" (id),
    ADD CONSTRAINT "fk_usuarioid_usuariocliente"
        FOREIGN KEY (usuario_id) REFERENCES "Usuario" (id),
    ADD CONSTRAINT "fk_numerocuenta_usuariocliente"
        FOREIGN KEY (numero_cuenta) REFERENCES "CuentaBancaria" (numero_cuenta);

-- SEDE
CREATE TABLE public."Sede"
(
    id           VARCHAR(10) NOT NULL,
    nombre       VARCHAR(50) NOT NULL,
    direccion    VARCHAR(50) NOT NULL,
    departamento VARCHAR(50) NOT NULL,
    distrito     VARCHAR(50) NOT NULL,
    n_salas      SMALLINT    NOT NULL

);
ALTER TABLE public."Sede"
    ADD CONSTRAINT "pl_sede" PRIMARY KEY (id);

-- GENERO
CREATE TABLE public."Genero"
(
    id     VARCHAR(10) NOT NULL,
    nombre VARCHAR(15) NOT NULL
);
ALTER TABLE public."Genero"
    ADD CONSTRAINT "pk_genero" PRIMARY KEY (id);

-- NIVEL PUBLICO
CREATE TABLE public."NivelPublico"
(
    id         VARCHAR(10) NOT NULL,
    rango_edad SMALLINT    NOT NULL
);
ALTER TABLE public."NivelPublico"
    ADD CONSTRAINT "pk_nivelpublico" PRIMARY KEY (id);

-- ACTORES
CREATE TABLE public."Actores"
(
    id     VARCHAR(10) NOT NULL,
    nombre VARCHAR(50) NOT NULL
);
ALTER TABLE public."Actores"
    ADD CONSTRAINT "pk_actores" PRIMARY KEY (id);

-- DIRECTORES
CREATE TABLE public."Directores"
(
    id     VARCHAR(10) NOT NULL,
    nombre VARCHAR(50) NOT NULL
);
ALTER TABLE public."Directores"
    ADD CONSTRAINT "pk_directores" PRIMARY KEY (id);

-- PELICULAS
CREATE TABLE public."Peliculas"
(
    id              VARCHAR(10)  NOT NULL,
    nombre          VARCHAR(50)  NOT NULL,
    idioma          VARCHAR(20)  NOT NULL,
    fecha_adquision DATE         NOT NULL,
    fecha_estreno   DATE         NOT NULL,
    genero_id       VARCHAR(10)  NOT NULL,
    duracion_h      FLOAT        NOT NULL,
    resena          VARCHAR(100) NOT NULL,
    nivelpublico_id VARCHAR(10)  NOT NULL,
    id_directores VARCHAR(10)
);
ALTER TABLE public."Peliculas"
    ADD CONSTRAINT "pk_peliculas"
        PRIMARY KEY (id),
    ADD CONSTRAINT "fk_generoid_peliculas"
        FOREIGN KEY (genero_id) REFERENCES "Genero" (id),
    ADD CONSTRAINT "fk_nivelpublicoid_peliculas"
        FOREIGN KEY (nivelpublico_id) REFERENCES "NivelPublico" (id),
    ADD CONSTRAINT "fk_iddirectores_peliculas"
        FOREIGN KEY (id_Directores) REFERENCES "Directores" (id);

-- SALA
CREATE TABLE public."Sala"
(
    id           VARCHAR(10) NOT NULL,
    sede_id      VARCHAR(10) NOT NULL,
    numero_salas SMALLINT    NOT NULL,
    n_butacas    SMALLINT    NOT NULL
);
ALTER TABLE public."Sala"
    ADD CONSTRAINT "pk_sala"
        PRIMARY KEY (id),
    ADD CONSTRAINT "fk_sedeid_sala"
        FOREIGN KEY (sede_id) REFERENCES public."Sede" (id);

-- FUNCION
CREATE TABLE public."Funcion"
(
    funcion_id  VARCHAR(10) NOT NULL,
    sala_id     VARCHAR(10) NOT NULL,
    fecha       DATE        NOT NULL,
    hora        TIMESTAMP   NOT NULL,
    pelicula_id VARCHAR(10) NOT NULL
);
ALTER TABLE public."Funcion"
    ADD CONSTRAINT "pk_funcion"
        PRIMARY KEY (funcion_id),
    ADD CONSTRAINT "fk_salaid_funcion"
        FOREIGN KEY (sala_id) REFERENCES "Sala"(id),
    ADD CONSTRAINT "fk_pelicula_funcion_nombre"
        FOREIGN KEY (pelicula_id) REFERENCES "Peliculas" (id);

-- FUNCION CON VACUNA
CREATE TABLE public."FuncionVacuna"
(
    funcion_id VARCHAR(10) NOT NULL
);
ALTER TABLE public."FuncionVacuna"
    ADD CONSTRAINT "pk_funcionvacuna"
        PRIMARY KEY (funcion_id),
    ADD CONSTRAINT "fk_funcionvacuna"
        FOREIGN KEY (funcion_id) REFERENCES "Funcion"(funcion_id);

-- PRODUCTO
CREATE TABLE public."Producto"
(
    id           VARCHAR(10) NOT NULL,
    nombre       VARCHAR(50) NOT NULL,
    descripcion  VARCHAR(50),
    precio_venta FLOAT       NOT NULL
);
ALTER TABLE "Producto"
    ADD CONSTRAINT "pk_producto" PRIMARY KEY (id);

-- VENTAS
CREATE TABLE public."Venta"
(
    id         VARCHAR(10) NOT NULL,
    cliente_id VARCHAR(10) NOT NULL,
    colaborador_id  VARCHAR(10) NOT NULL,
    fecha      DATE        NOT NULL,
    hora       TIMESTAMP   NOT NULL
);
ALTER TABLE "Venta"
    ADD CONSTRAINT "pk_venta"
        PRIMARY KEY (id),
    ADD CONSTRAINT "fk_clienteid_venta"
        FOREIGN KEY (cliente_id) REFERENCES "Clientes" (id),
    ADD CONSTRAINT "fk_colaboradorid_venta"
        FOREIGN KEY (colaborador_id) REFERENCES "Colaboradores" (id);

-- VENTA ENTRADA
CREATE TABLE public."VentaEntrada"
(
    id     VARCHAR(10) not null,
    venta_id       VARCHAR(10) NOT NULL,
    fila           SMALLINT    NOT NULL,
    columna        SMALLINT    NOT NULL,
    precio_entrada FLOAT       NOT NULL,
    tipo_entrada   VARCHAR(10) NOT NULL
);
ALTER TABLE public."VentaEntrada"
    ADD CONSTRAINT "pk_ventaentrada"
        PRIMARY KEY (id),
    ADD CONSTRAINT "fk_ventaid_ventaentrada"
        FOREIGN KEY (venta_id) REFERENCES "Venta" (id);

-- FACTURA ENTRADA
CREATE TABLE public."FacturaEntrada"
(
    id               VARCHAR(10) NOT NULL,
    venta_id VARCHAR(10) NOT NULL,
    funcion_id       VARCHAR(10),
    cantidad_entadas SMALLINT    NOT NULL,
    qr_id            VARCHAR(50) NOT NULL
);
ALTER TABLE public."FacturaEntrada"
    ADD CONSTRAINT "pk_facturaventa"
        PRIMARY KEY (id),
    ADD CONSTRAINT "fk_funcionid_facturaentrada"
        FOREIGN KEY (funcion_id) REFERENCES "Funcion" (funcion_id),
    ADD CONSTRAINT "fk_ventacliente_facturaentrada"
        FOREIGN KEY (venta_id) REFERENCES "Venta" (id);

-- VENTA PRODUCTO
CREATE TABLE public."VentaProducto"
(
    venta_id    VARCHAR(10) NOT NULL,
    producto_id VARCHAR(10) NOT NULL,
    cantidad    SMALLINT    NOT NULL
);
ALTER TABLE "VentaProducto"
    ADD CONSTRAINT "fk_ventaid_ventaproducto"
        FOREIGN KEY (venta_id) REFERENCES "Venta" (id),
    ADD CONSTRAINT "fk_productoid_ventaproducto"
        FOREIGN KEY (producto_id) REFERENCES "Producto" (id);

-- BUTACA FUNCION
CREATE TABLE public."ButacaFuncion"
(
    funcion_id      VARCHAR(10) NOT NULL,
    nro_fila        SMALLINT    NOT NULL,
    nro_columna     SMALLINT    NOT NULL,
    ventaentrada_id VARCHAR(10) NOT NULL

);
ALTER TABLE "ButacaFuncion"
    ADD CONSTRAINT "fk_funcion_butacafuncion"
        FOREIGN KEY (funcion_id) REFERENCES "Funcion" (funcion_id),
    ADD CONSTRAINT "fk_ventaentrada_id"
        FOREIGN KEY (ventaentrada_id) REFERENCES "VentaEntrada" (id);

-- ACTUA
CREATE TABLE public."Actua"
(
    pelicula_id VARCHAR(10),
    actor_id    VARCHAR(10)
);
ALTER TABLE "Actua"
    ADD CONSTRAINT "pk_actua"
        PRIMARY KEY (pelicula_id),
    ADD CONSTRAINT "fk_pelicula_actua" FOREIGN KEY (pelicula_id)
        REFERENCES "Peliculas" (id),
    ADD CONSTRAINT "fk_actor_actua" FOREIGN KEY (actor_id)
        REFERENCES "Actores" (id);
