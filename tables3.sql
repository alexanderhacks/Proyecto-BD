-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler version: 0.9.4-beta1
-- PostgreSQL version: 13.0
-- Project Site: pgmodeler.io
-- Model Author: ---

-- Database creation must be performed outside a multi lined SQL file. 
-- These commands were put in this file only as a convenience.
-- 
-- object: new_database | type: DATABASE --
-- DROP DATABASE IF EXISTS new_database;
CREATE DATABASE new_database;
-- ddl-end --


-- object: public."Clientes" | type: TABLE --
-- DROP TABLE IF EXISTS public."Clientes" CASCADE;
CREATE TABLE public."Clientes" (
	id varchar(10) NOT NULL,
	nombres varchar(50) NOT NULL,
	apellidos varchar(50) NOT NULL,
	correo varchar(50),
	celular varchar(9),
	CONSTRAINT pk_cliente PRIMARY KEY (id)
);
-- ddl-end --
ALTER TABLE public."Clientes" OWNER TO postgres;
-- ddl-end --

-- object: public."CuentaBancaria" | type: TABLE --
-- DROP TABLE IF EXISTS public."CuentaBancaria" CASCADE;
CREATE TABLE public."CuentaBancaria" (
	numero_cuenta varchar(20) NOT NULL,
	cliente_id varchar(10) NOT NULL,
	tipo_cuenta varchar(15) NOT NULL,
	CONSTRAINT pk_cuentabancaria PRIMARY KEY (numero_cuenta)
);
-- ddl-end --
ALTER TABLE public."CuentaBancaria" OWNER TO postgres;
-- ddl-end --

-- object: public."Membresia" | type: TABLE --
-- DROP TABLE IF EXISTS public."Membresia" CASCADE;
CREATE TABLE public."Membresia" (
	id varchar(10) NOT NULL,
	nombre varchar(50) NOT NULL,
	"id_Clientes" varchar(10) NOT NULL,
	CONSTRAINT pk_membresia PRIMARY KEY (id)
);
-- ddl-end --
ALTER TABLE public."Membresia" OWNER TO postgres;
-- ddl-end --

-- object: "Clientes_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Membresia" DROP CONSTRAINT IF EXISTS "Clientes_fk" CASCADE;
ALTER TABLE public."Membresia" ADD CONSTRAINT "Clientes_fk" FOREIGN KEY ("id_Clientes")
REFERENCES public."Clientes" (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: public."AreaTrabajo" | type: TABLE --
-- DROP TABLE IF EXISTS public."AreaTrabajo" CASCADE;
CREATE TABLE public."AreaTrabajo" (
	id varchar(10) NOT NULL,
	nombre varchar(50) NOT NULL,
	CONSTRAINT pk_areatrabajo PRIMARY KEY (id)
);
-- ddl-end --
ALTER TABLE public."AreaTrabajo" OWNER TO postgres;
-- ddl-end --

-- object: public."Colaboradores" | type: TABLE --
-- DROP TABLE IF EXISTS public."Colaboradores" CASCADE;
CREATE TABLE public."Colaboradores" (
	id varchar(10) NOT NULL,
	nro_documento varchar(8) NOT NULL,
	tipo_documento varchar(10) NOT NULL,
	nombres varchar(50) NOT NULL,
	apellidos varchar(50) NOT NULL,
	celular varchar(9) NOT NULL,
	correo varchar(50) NOT NULL,
	numero_cuenta varchar(20) NOT NULL,
	areatrabajo_id varchar(10) NOT NULL,
	"id_AreaTrabajo" varchar(10),
	CONSTRAINT pk_colaboradores PRIMARY KEY (id)
);
-- ddl-end --
ALTER TABLE public."Colaboradores" OWNER TO postgres;
-- ddl-end --

-- object: "AreaTrabajo_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Colaboradores" DROP CONSTRAINT IF EXISTS "AreaTrabajo_fk" CASCADE;
ALTER TABLE public."Colaboradores" ADD CONSTRAINT "AreaTrabajo_fk" FOREIGN KEY ("id_AreaTrabajo")
REFERENCES public."AreaTrabajo" (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public."SueldoColaborador" | type: TABLE --
-- DROP TABLE IF EXISTS public."SueldoColaborador" CASCADE;
CREATE TABLE public."SueldoColaborador" (
	id varchar(10) NOT NULL,
	fecha_inicio date NOT NULL,
	fecha_final date NOT NULL,
	sueldo float8 NOT NULL

);
-- ddl-end --
ALTER TABLE public."SueldoColaborador" OWNER TO postgres;
-- ddl-end --

-- object: public."Administradores" | type: TABLE --
-- DROP TABLE IF EXISTS public."Administradores" CASCADE;
CREATE TABLE public."Administradores" (
	id smallint,
	nivel_permiso smallint NOT NULL

);
-- ddl-end --
ALTER TABLE public."Administradores" OWNER TO postgres;
-- ddl-end --

-- object: public."Usuario" | type: TABLE --
-- DROP TABLE IF EXISTS public."Usuario" CASCADE;
CREATE TABLE public."Usuario" (
	id bigserial NOT NULL,
	usuario varchar(15) NOT NULL,
	"contraseña" varchar NOT NULL,
	CONSTRAINT pk_usuario PRIMARY KEY (usuario)
);
-- ddl-end --
ALTER TABLE public."Usuario" OWNER TO postgres;
-- ddl-end --

-- object: public."TipoColaborador" | type: TABLE --
-- DROP TABLE IF EXISTS public."TipoColaborador" CASCADE;
CREATE TABLE public."TipoColaborador" (
	id varchar(10) NOT NULL,
	especialidad varchar(30) NOT NULL,
	rango_permiso int8 NOT NULL,
	CONSTRAINT pk_tipocolaborador PRIMARY KEY (id)
);
-- ddl-end --
ALTER TABLE public."TipoColaborador" OWNER TO postgres;
-- ddl-end --

-- object: public."UsuarioColaborador" | type: TABLE --
-- DROP TABLE IF EXISTS public."UsuarioColaborador" CASCADE;
CREATE TABLE public."UsuarioColaborador" (
	colaborador_id varchar(10) NOT NULL,
	usuario_id bigserial NOT NULL,
	tipocolaborador_especialidad varchar(30) NOT NULL,
	tipocolaborador_id varchar(10) NOT NULL

);
-- ddl-end --
ALTER TABLE public."UsuarioColaborador" OWNER TO postgres;
-- ddl-end --

-- object: public."UsuarioCliente" | type: TABLE --
-- DROP TABLE IF EXISTS public."UsuarioCliente" CASCADE;
CREATE TABLE public."UsuarioCliente" (
	cliente_id varchar(10) NOT NULL,
	usuario_id bigserial NOT NULL,
	telefono varchar(9)

);
-- ddl-end --
ALTER TABLE public."UsuarioCliente" OWNER TO postgres;
-- ddl-end --

-- object: public."Sede" | type: TABLE --
-- DROP TABLE IF EXISTS public."Sede" CASCADE;
CREATE TABLE public."Sede" (
	id varchar(10) NOT NULL,
	nombre varchar(50) NOT NULL,
	direccion varchar(50) NOT NULL,
	departamento varchar(50) NOT NULL,
	distrito varchar(50) NOT NULL,
	n_salas smallint NOT NULL

);
-- ddl-end --
ALTER TABLE public."Sede" OWNER TO postgres;
-- ddl-end --

-- object: public."Peliculas" | type: TABLE --
-- DROP TABLE IF EXISTS public."Peliculas" CASCADE;
CREATE TABLE public."Peliculas" (
	id varchar(10) NOT NULL,
	nombre varchar(50) NOT NULL,
	idioma varchar(20) NOT NULL,
	fecha_adquision date NOT NULL,
	fecha_estreno date NOT NULL,
	genero_id varchar(10) NOT NULL,
	duracion_h float NOT NULL,
	resena varchar(100) NOT NULL,
	nivelpublico_id varchar(10) NOT NULL,
	CONSTRAINT pk_pelicula PRIMARY KEY (id)
);
-- ddl-end --
ALTER TABLE public."Peliculas" OWNER TO postgres;
-- ddl-end --

-- object: public."Genero" | type: TABLE --
-- DROP TABLE IF EXISTS public."Genero" CASCADE;
CREATE TABLE public."Genero" (
	id varchar(10) NOT NULL,
	nombre varchar(15) NOT NULL,
	CONSTRAINT pk_genero PRIMARY KEY (id)
);
-- ddl-end --
ALTER TABLE public."Genero" OWNER TO postgres;
-- ddl-end --

-- object: public."NivelPublico" | type: TABLE --
-- DROP TABLE IF EXISTS public."NivelPublico" CASCADE;
CREATE TABLE public."NivelPublico" (
	id varchar(10) NOT NULL,
	rango_edad smallint NOT NULL,
	CONSTRAINT pk_nivelpublico PRIMARY KEY (id)
);
-- ddl-end --
ALTER TABLE public."NivelPublico" OWNER TO postgres;
-- ddl-end --

-- object: fk_cuentabancaria | type: CONSTRAINT --
-- ALTER TABLE public."CuentaBancaria" DROP CONSTRAINT IF EXISTS fk_cuentabancaria CASCADE;
ALTER TABLE public."CuentaBancaria" ADD CONSTRAINT fk_cuentabancaria FOREIGN KEY (cliente_id)
REFERENCES public."Clientes" (id) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_sueldocolaborador | type: CONSTRAINT --
-- ALTER TABLE public."SueldoColaborador" DROP CONSTRAINT IF EXISTS fk_sueldocolaborador CASCADE;
ALTER TABLE public."SueldoColaborador" ADD CONSTRAINT fk_sueldocolaborador FOREIGN KEY (id)
REFERENCES public."Colaboradores" (id) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_administradores | type: CONSTRAINT --
-- ALTER TABLE public."Administradores" DROP CONSTRAINT IF EXISTS fk_administradores CASCADE;
ALTER TABLE public."Administradores" ADD CONSTRAINT fk_administradores FOREIGN KEY (id)
REFERENCES public."Colaboradores" (id) MATCH SIMPLE
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_colaboradres_id | type: CONSTRAINT --
-- ALTER TABLE public."UsuarioColaborador" DROP CONSTRAINT IF EXISTS fk_colaboradres_id CASCADE;
ALTER TABLE public."UsuarioColaborador" ADD CONSTRAINT fk_colaboradres_id FOREIGN KEY (colaborador_id)
REFERENCES public."Colaboradores" (id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_usuario_id | type: CONSTRAINT --
-- ALTER TABLE public."UsuarioColaborador" DROP CONSTRAINT IF EXISTS fk_usuario_id CASCADE;
ALTER TABLE public."UsuarioColaborador" ADD CONSTRAINT fk_usuario_id FOREIGN KEY (usuario_id)
REFERENCES public."Usuario" (id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_tipocolaborador_colaboradores | type: CONSTRAINT --
-- ALTER TABLE public."UsuarioColaborador" DROP CONSTRAINT IF EXISTS fk_tipocolaborador_colaboradores CASCADE;
ALTER TABLE public."UsuarioColaborador" ADD CONSTRAINT fk_tipocolaborador_colaboradores FOREIGN KEY (tipocolaborador_especialidad,tipocolaborador_id)
REFERENCES public."TipoColaborador" (id,especialidad) MATCH SIMPLE
ON DELETE SET DEFAULT ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_usuariocliente_id | type: CONSTRAINT --
-- ALTER TABLE public."UsuarioCliente" DROP CONSTRAINT IF EXISTS fk_usuariocliente_id CASCADE;
ALTER TABLE public."UsuarioCliente" ADD CONSTRAINT fk_usuariocliente_id FOREIGN KEY (cliente_id)
REFERENCES public."Clientes" (id) MATCH SIMPLE
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_usuiaro_cliente | type: CONSTRAINT --
-- ALTER TABLE public."UsuarioCliente" DROP CONSTRAINT IF EXISTS fk_usuiaro_cliente CASCADE;
ALTER TABLE public."UsuarioCliente" ADD CONSTRAINT fk_usuiaro_cliente FOREIGN KEY (usuario_id)
REFERENCES public."Usuario" (id) MATCH SIMPLE
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_nivelpublico_pelicula | type: CONSTRAINT --
-- ALTER TABLE public."Peliculas" DROP CONSTRAINT IF EXISTS fk_nivelpublico_pelicula CASCADE;
ALTER TABLE public."Peliculas" ADD CONSTRAINT fk_nivelpublico_pelicula FOREIGN KEY (nivelpublico_id)
REFERENCES public."NivelPublico" (id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_genero_pelicula | type: CONSTRAINT --
-- ALTER TABLE public."Peliculas" DROP CONSTRAINT IF EXISTS fk_genero_pelicula CASCADE;
ALTER TABLE public."Peliculas" ADD CONSTRAINT fk_genero_pelicula FOREIGN KEY (genero_id)
REFERENCES public."Genero" (id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


