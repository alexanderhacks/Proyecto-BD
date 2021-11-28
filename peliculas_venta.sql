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
	"id_Directores" varchar(10),
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

-- object: public."Actores" | type: TABLE --
-- DROP TABLE IF EXISTS public."Actores" CASCADE;
CREATE TABLE public."Actores" (
	id varchar(10) NOT NULL,
	nombre varchar(50) NOT NULL,
	"id_Peliculas" varchar(10),
	CONSTRAINT pk_genero_cp PRIMARY KEY (id)
);
-- ddl-end --
ALTER TABLE public."Actores" OWNER TO postgres;
-- ddl-end --

-- object: public."Directores" | type: TABLE --
-- DROP TABLE IF EXISTS public."Directores" CASCADE;
CREATE TABLE public."Directores" (
	id varchar(10) NOT NULL,
	nombre varchar(50) NOT NULL,
	CONSTRAINT pk_genero_cp_cp PRIMARY KEY (id)
);
-- ddl-end --
ALTER TABLE public."Directores" OWNER TO postgres;
-- ddl-end --

-- object: "Peliculas_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Actores" DROP CONSTRAINT IF EXISTS "Peliculas_fk" CASCADE;
ALTER TABLE public."Actores" ADD CONSTRAINT "Peliculas_fk" FOREIGN KEY ("id_Peliculas")
REFERENCES public."Peliculas" (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: "Directores_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Peliculas" DROP CONSTRAINT IF EXISTS "Directores_fk" CASCADE;
ALTER TABLE public."Peliculas" ADD CONSTRAINT "Directores_fk" FOREIGN KEY ("id_Directores")
REFERENCES public."Directores" (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public."Sala" | type: TABLE --
-- DROP TABLE IF EXISTS public."Sala" CASCADE;
CREATE TABLE public."Sala" (
	id varchar(10) NOT NULL,
	sede_id varchar(10) NOT NULL,
	numero_salas smallint NOT NULL,
	n_butacas smallint NOT NULL,
	"id_Sede" varchar(10),
	CONSTRAINT pk_sala PRIMARY KEY (id)
);
-- ddl-end --
ALTER TABLE public."Sala" OWNER TO postgres;
-- ddl-end --

-- object: public."Funcion" | type: TABLE --
-- DROP TABLE IF EXISTS public."Funcion" CASCADE;
CREATE TABLE public."Funcion" (
	sala_id varchar(10) NOT NULL,
	fecha date NOT NULL,
	hora timestamp NOT NULL,
	pelicula_nombre smallint,
	pelicula_idioma smallint

);
-- ddl-end --
ALTER TABLE public."Funcion" OWNER TO postgres;
-- ddl-end --

-- object: public."ButacaFuncion" | type: TABLE --
-- DROP TABLE IF EXISTS public."ButacaFuncion" CASCADE;
CREATE TABLE public."ButacaFuncion" (
	funcion_id varchar(10) NOT NULL,
	funcion_fecha date NOT NULL,
	funcion_hora timestamp NOT NULL,
	nro_fila smallint NOT NULL,
	nro_columna smallint NOT NULL,
	ventaentrada_id varchar(10) NOT NULL

);
-- ddl-end --
ALTER TABLE public."ButacaFuncion" OWNER TO postgres;
-- ddl-end --

-- object: public."Producto" | type: TABLE --
-- DROP TABLE IF EXISTS public."Producto" CASCADE;
CREATE TABLE public."Producto" (
	id varchar(10) NOT NULL,
	nombre varchar(50) NOT NULL,
	descripcion varchar(50),
	precio_venta float NOT NULL,
	CONSTRAINT pk_producto PRIMARY KEY (id)
);
-- ddl-end --
ALTER TABLE public."Producto" OWNER TO postgres;
-- ddl-end --

-- object: public."Sede" | type: TABLE --
-- DROP TABLE IF EXISTS public."Sede" CASCADE;
CREATE TABLE public."Sede" (
	id varchar(10) NOT NULL,
	nombre varchar(50) NOT NULL,
	direccion varchar(50) NOT NULL,
	departamento varchar(50) NOT NULL,
	distrito varchar(50) NOT NULL,
	n_salas smallint NOT NULL,
	CONSTRAINT pk_sede PRIMARY KEY (id)
);
-- ddl-end --
ALTER TABLE public."Sede" OWNER TO postgres;
-- ddl-end --

-- object: "Sede_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Sala" DROP CONSTRAINT IF EXISTS "Sede_fk" CASCADE;
ALTER TABLE public."Sala" ADD CONSTRAINT "Sede_fk" FOREIGN KEY ("id_Sede")
REFERENCES public."Sede" (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public."Venta" | type: TABLE --
-- DROP TABLE IF EXISTS public."Venta" CASCADE;
CREATE TABLE public."Venta" (
	id varchar(10) NOT NULL,
	cliente_id varchar(10) NOT NULL,
	fecha date NOT NULL,
	hora timestamp NOT NULL,
	"id_Cliente" varchar(10),
	CONSTRAINT pk_producto_cp_cp PRIMARY KEY (id)
);
-- ddl-end --
ALTER TABLE public."Venta" OWNER TO postgres;
-- ddl-end --

-- object: public."FacturaEntrada" | type: TABLE --
-- DROP TABLE IF EXISTS public."FacturaEntrada" CASCADE;
CREATE TABLE public."FacturaEntrada" (
	id varchar(10) NOT NULL,
	fila smallint NOT NULL,
	columna smallint NOT NULL,
	precio_entrada float NOT NULL,
	tipo_entrada varchar(10) NOT NULL,
	CONSTRAINT "FacturaEntrada_pk" PRIMARY KEY (id)
);
-- ddl-end --
ALTER TABLE public."FacturaEntrada" OWNER TO postgres;
-- ddl-end --

-- object: public."VentaEntrada" | type: TABLE --
-- DROP TABLE IF EXISTS public."VentaEntrada" CASCADE;
CREATE TABLE public."VentaEntrada" (
	id varchar(10) NOT NULL,
	venta_cliente_id varchar(10) NOT NULL,
	funcion_id varchar(10),
	cantidad_entadas smallint NOT NULL,
	qr_id varchar(50) NOT NULL,
	CONSTRAINT pk_producto_cp_cp_cp PRIMARY KEY (id)
);
-- ddl-end --
ALTER TABLE public."VentaEntrada" OWNER TO postgres;
-- ddl-end --

-- object: public."VentaProducto" | type: TABLE --
-- DROP TABLE IF EXISTS public."VentaProducto" CASCADE;
CREATE TABLE public."VentaProducto" (
	venta_id varchar(10) NOT NULL,
	producto_id varchar(10) NOT NULL,
	cantidad smallint NOT NULL,
	CONSTRAINT pk_producto_cp_cp_cp_cp PRIMARY KEY (venta_id)
);
-- ddl-end --
ALTER TABLE public."VentaProducto" OWNER TO postgres;
-- ddl-end --

-- object: public."Cliente" | type: TABLE --
-- DROP TABLE IF EXISTS public."Cliente" CASCADE;
CREATE TABLE public."Cliente" (
	id varchar(10) NOT NULL,
	nombres varchar(50) NOT NULL,
	apellidos varchar(50) NOT NULL,
	correo varchar(50) NOT NULL,
	celular varchar(9) NOT NULL,
	CONSTRAINT "Cliente_pk" PRIMARY KEY (id)
);
-- ddl-end --
ALTER TABLE public."Cliente" OWNER TO postgres;
-- ddl-end --

-- object: "Cliente_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Venta" DROP CONSTRAINT IF EXISTS "Cliente_fk" CASCADE;
ALTER TABLE public."Venta" ADD CONSTRAINT "Cliente_fk" FOREIGN KEY ("id_Cliente")
REFERENCES public."Cliente" (id) MATCH FULL
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

-- object: fk_salaid_funcion | type: CONSTRAINT --
-- ALTER TABLE public."Funcion" DROP CONSTRAINT IF EXISTS fk_salaid_funcion CASCADE;
ALTER TABLE public."Funcion" ADD CONSTRAINT fk_salaid_funcion FOREIGN KEY (sala_id)
REFERENCES public."Sala" (id) MATCH SIMPLE
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: fk_pelicula_funcion | type: CONSTRAINT --
-- ALTER TABLE public."Funcion" DROP CONSTRAINT IF EXISTS fk_pelicula_funcion CASCADE;
ALTER TABLE public."Funcion" ADD CONSTRAINT fk_pelicula_funcion FOREIGN KEY (pelicula_nombre,pelicula_idioma)
REFERENCES public."Peliculas" (nombre,idioma) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_funcion_butaca | type: CONSTRAINT --
-- ALTER TABLE public."ButacaFuncion" DROP CONSTRAINT IF EXISTS fk_funcion_butaca CASCADE;
ALTER TABLE public."ButacaFuncion" ADD CONSTRAINT fk_funcion_butaca FOREIGN KEY (funcion_id,funcion_fecha,funcion_hora)
REFERENCES public."Funcion" (sala_id,fecha,hora) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_facturaentrada_ventaentrada | type: CONSTRAINT --
-- ALTER TABLE public."FacturaEntrada" DROP CONSTRAINT IF EXISTS fk_facturaentrada_ventaentrada CASCADE;
ALTER TABLE public."FacturaEntrada" ADD CONSTRAINT fk_facturaentrada_ventaentrada FOREIGN KEY (id)
REFERENCES public."VentaEntrada" (id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_ventaentrada | type: CONSTRAINT --
-- ALTER TABLE public."VentaEntrada" DROP CONSTRAINT IF EXISTS fk_ventaentrada CASCADE;
ALTER TABLE public."VentaEntrada" ADD CONSTRAINT fk_ventaentrada FOREIGN KEY (id,venta_cliente_id)
REFERENCES public."Venta" (id,cliente_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_funcion_ventaentrada | type: CONSTRAINT --
-- ALTER TABLE public."VentaEntrada" DROP CONSTRAINT IF EXISTS fk_funcion_ventaentrada CASCADE;
ALTER TABLE public."VentaEntrada" ADD CONSTRAINT fk_funcion_ventaentrada FOREIGN KEY (funcion_id)
REFERENCES public."Funcion" (sala_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_producto_ventaproducto | type: CONSTRAINT --
-- ALTER TABLE public."VentaProducto" DROP CONSTRAINT IF EXISTS fk_producto_ventaproducto CASCADE;
ALTER TABLE public."VentaProducto" ADD CONSTRAINT fk_producto_ventaproducto FOREIGN KEY (producto_id)
REFERENCES public."Producto" (id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: fk_ventaid_ventaproducto | type: CONSTRAINT --
-- ALTER TABLE public."VentaProducto" DROP CONSTRAINT IF EXISTS fk_ventaid_ventaproducto CASCADE;
ALTER TABLE public."VentaProducto" ADD CONSTRAINT fk_ventaid_ventaproducto FOREIGN KEY (venta_id)
REFERENCES public."Venta" (id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


