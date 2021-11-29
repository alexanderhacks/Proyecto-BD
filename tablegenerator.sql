set search_path = "public";
CREATE TABLE public."Clientes"
(
    id        varchar(10) NOT NULL,
    nombres   varchar(50) NOT NULL,
    apellidos varchar(50) NOT NULL,
    correo    varchar(50),
    celular   varchar(9)
);
ALTER TABLE public."Clientes"
    ADD CONSTRAINT "pk_clientes" PRIMARY KEY (id);

CREATE TABLE public."CuentaBancaria"
(
    numero_cuenta varchar(20) NOT NULL,
    cliente_id    varchar(10) NOT NULL,
    tipo_cuenta   varchar(15) NOT NULL
);

ALTER TABLE public."CuentaBancaria"
    ADD CONSTRAINT "fk_cuentabancaria" FOREIGN KEY (cliente_id) REFERENCES public."Clientes" (id)
        ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE public."CuentaBancaria"
    ADD CONSTRAINT "pk_cuentabancaria" PRIMARY KEY (numero_cuenta);

CREATE TABLE public."Membresia"
(
    id     varchar(10) NOT NULL,
    nombre varchar(50) NOT NULL
);
ALTER TABLE public."Membresia"
    ADD CONSTRAINT "pk_membresia" PRIMARY KEY (id);

-- Socios es la relación entre Cliente y Membresía
CREATE TABLE public."Socios"
(
    cliente_id   varchar(10) NOT NULL,
    membresia_id varchar(10) NOT NULL
);

ALTER TABLE public."Socios"
    ADD CONSTRAINT "fk_cliente_membresia" FOREIGN KEY (cliente_id) REFERENCES public."Clientes" (id) ON DELETE SET NULL ON UPDATE CASCADE;;
ALTER TABLE public."Socios"
    ADD CONSTRAINT "fk_membresia_cliente" FOREIGN KEY (membresia_id) REFERENCES public."Membresia" (id) ON DELETE SET NULL ON UPDATE CASCADE;;



CREATE TABLE public."AreaTrabajo"
(
    id     varchar(10) NOT NULL,
    nombre varchar(50) NOT NULL,
    CONSTRAINT pk_areatrabajo PRIMARY KEY (id)
);
ALTER TABLE public."AreaTrabajo"
    ADD CONSTRAINT "pk_areatrabajo" PRIMARY KEY (id);

CREATE TABLE public."Colaboradores"
(
    id             varchar(10) NOT NULL,
    nro_documento  varchar(8)  NOT NULL,
    tipo_documento varchar(10) NOT NULL,
    nombres        varchar(50) NOT NULL,
    apellidos      varchar(50) NOT NULL,
    celular        varchar(9)  NOT NULL,
    correo         varchar(50) NOT NULL,
    numero_cuenta  varchar(20) NOT NULL,
    areatrabajo_id varchar(10) NOT NULL
);
ALTER TABLE public."Colaboradores"
    ADD CONSTRAINT "pk_colaboradores" PRIMARY KEY (id);
ALTER TABLE public."Colaboradores"
    ADD CONSTRAINT "fk_colaboradores" FOREIGN KEY (areatrabajo_id) REFERENCES public."AreaTrabajo" (id);

CREATE TABLE public."SueldoColaborador"
(
    colaborador_id varchar(10) NOT NULL,
    fecha_inicio   date        NOT NULL,
    fecha_final    date        NOT NULL,
    sueldo         float8      NOT NULL

);
ALTER TABLE public."SueldoColaborador"
    ADD CONSTRAINT "fk_sueldocolaborador" FOREIGN KEY (colaborador_id) REFERENCES public."Colaboradores" (id);


CREATE TABLE public."Administradores"
(
    id            varchar(10) NOT NULL,
    nivel_permiso smallint    NOT NULL

);

ALTER TABLE public."Administradores"
    ADD CONSTRAINT "pk_administradores" PRIMARY KEY (id);

CREATE TABLE public."Usuario"
(
    id           bigserial   NOT NULL,
    usuario      varchar(15) NOT NULL,
    "contrasena" varchar     NOT NULL
);

ALTER TABLE public."Usuario"
    ADD CONSTRAINT "pk_usuario" PRIMARY KEY (id);

CREATE TABLE public."TipoColaborador"
(
    id            varchar(10) NOT NULL,
    especialidad  varchar(30) NOT NULL,
    rango_permiso int8        NOT NULL
);

ALTER TABLE public."TipoColaborador"
    ADD CONSTRAINT "pk_tipocolaborador" PRIMARY KEY (id);

CREATE TABLE public."UsuarioColaborador"
(
    id                           varchar(10) not null,
    colaborador_id               varchar(10) NOT NULL,
    usuario_id                   bigserial   NOT NULL,
    tipocolaborador_especialidad varchar(30) NOT NULL,
    tipocolaborador_id           varchar(10) NOT NULL

);
ALTER TABLE public."UsuarioColaborador"
    ADD CONSTRAINT "pk_usuariocolaborador" PRIMARY KEY (id);
ALTER TABLE public."UsuarioColaborador"
    ADD CONSTRAINT "fk_colaboradorid_usuariocolaborador" FOREIGN KEY (colaborador_id) REFERENCES "Colaboradores" (id);
ALTER TABLE public."UsuarioColaborador"
    ADD CONSTRAINT "fk_usuarioid_usuariocolaborador" FOREIGN KEY (usuario_id) REFERENCES "Usuario" (id);

ALTER TABLE public."UsuarioColaborador"
    ADD CONSTRAINT "fk_tipocolaborador_usuariocolaborador_id" FOREIGN KEY (tipocolaborador_id) REFERENCES "TipoColaborador" (id);

ALTER TABLE public."UsuarioColaborador"
    ADD CONSTRAINT "fk_tipocolaborador_usuariocolaborador_especialidad" FOREIGN KEY (tipocolaborador_especialidad) REFERENCES "TipoColaborador" (especialidad);


CREATE TABLE public."UsuarioCliente"
(
    cliente_id varchar(10) NOT NULL,
    usuario_id bigserial   NOT NULL,
    telefono   varchar(9)

);
ALTER TABLE public."UsuarioCliente"
    ADD CONSTRAINT "fk_clienteid_usuariocliente" FOREIGN KEY (cliente_id) REFERENCES "Clientes" (id);

ALTER TABLE public."UsuarioCliente"
    ADD CONSTRAINT "fk_usuarioid_usuariocliente" FOREIGN KEY (usuario_id) REFERENCES "Usuario" (id);

CREATE TABLE public."Sede"
(
    id           varchar(10) NOT NULL,
    nombre       varchar(50) NOT NULL,
    direccion    varchar(50) NOT NULL,
    departamento varchar(50) NOT NULL,
    distrito     varchar(50) NOT NULL,
    n_salas      smallint    NOT NULL

);
ALTER TABLE public."Sede"
    ADD CONSTRAINT "pl_sede" PRIMARY KEY (id);

CREATE TABLE public."Genero"
(
    id     varchar(10) NOT NULL,
    nombre varchar(15) NOT NULL
);
ALTER TABLE public."Genero"
    ADD CONSTRAINT "pk_genero" PRIMARY KEY (id);

CREATE TABLE public."NivelPublico"
(
    id         varchar(10) NOT NULL,
    rango_edad smallint    NOT NULL
);

ALTER TABLE public."NivelPublico"
    ADD CONSTRAINT "pk_nivelpublico" PRIMARY KEY (id);

CREATE TABLE public."Peliculas"
(
    id              varchar(10)  NOT NULL,
    nombre          varchar(50)  NOT NULL,
    idioma          varchar(20)  NOT NULL,
    fecha_adquision date         NOT NULL,
    fecha_estreno   date         NOT NULL,
    genero_id       varchar(10)  NOT NULL,
    duracion_h      float        NOT NULL,
    resena          varchar(100) NOT NULL,
    nivelpublico_id varchar(10)  NOT NULL,
    "id_directores" varchar(10)
);

ALTER TABLE public."Peliculas"
    ADD CONSTRAINT "pk_peliculas" PRIMARY KEY (id);
ALTER TABLE public."Peliculas"
    ADD CONSTRAINT "fk_generoid_peliculas" FOREIGN KEY (genero_id)
        references "Genero" (id);
ALTER TABLE public."Peliculas"
    ADD CONSTRAINT "fk_nivelpublicoid_peliculas" FOREIGN KEY (nivelpublico_id) references "NivelPublico" (id);

ALTER TABLE public."Peliculas"
    ADD CONSTRAINT "fk_iddirectores_peliculas" FOREIGN KEY ("id_Directores") references "Directores" (id);

CREATE TABLE public."Actores"
(
    id     varchar(10) NOT NULL,
    nombre varchar(50) NOT NULL
);

ALTER TABLE public."Actores"
    ADD CONSTRAINT "pk_actores" PRIMARY KEY (id);

CREATE TABLE public."Directores"
(
    id     varchar(10) NOT NULL,
    nombre varchar(50) NOT NULL
);

ALTER TABLE public."Directores"
    ADD CONSTRAINT "pk_directores" PRIMARY KEY (id);

CREATE TABLE public."Sala"
(
    id           varchar(10) NOT NULL,
    sede_id      varchar(10) NOT NULL,
    numero_salas smallint    NOT NULL,
    n_butacas    smallint    NOT NULL
);

ALTER TABLE public."Sala"
    ADD CONSTRAINT "pk_sala" PRIMARY KEY (id);
ALTER TABLE public."Sala"
    ADD CONSTRAINT "fk_sedeid_sala" FOREIGN KEY (sede_id) REFERENCES public."Sede" (id);


CREATE TABLE public."Funcion"
(
    funcion_id  varchar(10) NOT NULL,
    sala_id     varchar(10) NOT NULL,
    fecha       date        NOT NULL,
    hora        timestamp   NOT NULL,
    pelicula_id varchar(10) NOT NULL

);
ALTER TABLE public."Funcion"
    ADD CONSTRAINT "pk_funcion" primary key (funcion_id);
ALTER TABLE "Funcion"
    ADD CONSTRAINT "fk_salaid_funcion" FOREIGN KEY (sala_id) REFERENCES "Sala" (id);
ALTER TABLE "Funcion"
    ADD CONSTRAINT "fk_pelicula_funcion_nombre" FOREIGN KEY (pelicula_id) REFERENCES "Peliculas" (id);

CREATE TABLE public."Producto"
(
    id           varchar(10) NOT NULL,
    nombre       varchar(50) NOT NULL,
    descripcion  varchar(50),
    precio_venta float       NOT NULL
);
ALTER TABLE "Producto"
    ADD CONSTRAINT "pk_producto" primary key (id);

CREATE TABLE public."Venta"
(
    id         varchar(10) NOT NULL,
    cliente_id varchar(10) NOT NULL,
    fecha      date        NOT NULL,
    hora       timestamp   NOT NULL
);

ALTER TABLE "Venta"
    ADD CONSTRAINT "pk_venta" primary key (id);
ALTER TABLE "Venta"
    ADD CONSTRAINT "fk_clienteid_venta" foreign key (cliente_id) references "Clientes" (id);

CREATE TABLE public."VentaEntrada"
(
    id     varchar(10) not null,
    venta_id       varchar(10) NOT NULL,
    fila           smallint    NOT NULL,
    columna        smallint    NOT NULL,
    precio_entrada float       NOT NULL,
    tipo_entrada   varchar(10) NOT NULL
);
ALTER TABLE public."VentaEntrada"
    ADD CONSTRAINT "pk_ventaentrada" primary key (id);
ALTER TABLE public."VentaEntrada"
    ADD CONSTRAINT "fk_ventaid_ventaentrada" foreign key (venta_id) references "Venta" (id);

-- se hizo cambio de nombre
CREATE TABLE public."FacturaEntrada"
(
    id               varchar(10) NOT NULL,
    venta_id varchar(10) NOT NULL,
    funcion_id       varchar(10),
    cantidad_entadas smallint    NOT NULL,
    qr_id            varchar(50) NOT NULL
);
ALTER TABLE public."FacturaEntrada"
    ADD CONSTRAINT "pk_facturaventa" primary key (id);

ALTER TABLE public."FacturaEntrada"
    ADD CONSTRAINT "fk_funcionid_facturaentrada" foreign key (funcion_id) references "Funcion" (funcion_id);

ALTER TABLE public."FacturaEntrada"
    ADD CONSTRAINT "fk_ventacliente_facturaentrada" foreign key (venta_id) references "Venta" (id);

CREATE TABLE public."VentaProducto"
(
    venta_id    varchar(10) NOT NULL,
    producto_id varchar(10) NOT NULL,
    cantidad    smallint    NOT NULL
);

ALTER TABLE "VentaProducto" ADD CONSTRAINT "fk_ventaid_ventaproducto" foreign key (venta_id) references "Venta" (id);

ALTER TABLE "VentaProducto" ADD CONSTRAINT "fk_productoid_ventaproducto" foreign key (producto_id) references "Producto" (id);



CREATE TABLE public."ButacaFuncion"
(
    funcion_id      varchar(10) NOT NULL,
    nro_fila        smallint    NOT NULL,
    nro_columna     smallint    NOT NULL,
    ventaentrada_id varchar(10) NOT NULL

);

ALTER TABLE "ButacaFuncion" add constraint "fk_funcion_butacafuncion" foreign key (funcion_id) references "Funcion" (funcion_id);
ALTER TABLE "ButacaFuncion" add constraint "fk_ventaentrada_id" foreign key (ventaentrada_id) references "VentaEntrada" (id);
