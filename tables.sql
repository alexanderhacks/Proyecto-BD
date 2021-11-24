-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler version: 0.9.4-beta1
-- PostgreSQL version: 13.0
-- Project Site: pgmodeler.io
-- Model Author: ---

-- Database creation must be performed outside a multi lined SQL file. 
-- These commands were put in this file only as a convenience.
-- 
-- object: "Cinemania" | type: DATABASE --
-- DROP DATABASE IF EXISTS "Cinemania";
CREATE DATABASE "Cinemania";
-- ddl-end --


-- object: public."Usuario" | type: TABLE --
-- DROP TABLE IF EXISTS public."Usuario" CASCADE;
CREATE TABLE public."Usuario" (
  "Id" serial NOT NULL,
  "Username" varchar(30) NOT NULL,
  "Password" varchar(15) NOT NULL,
  CONSTRAINT id_pk PRIMARY KEY ("Id")
);
-- ddl-end --
ALTER TABLE public."Usuario" OWNER TO postgres;
-- ddl-end --

-- object: public."Usuario_Administrador" | type: TABLE --
-- DROP TABLE IF EXISTS public."Usuario_Administrador" CASCADE;
CREATE TABLE public."Usuario_Administrador" (
  "Id" serial NOT NULL,
  "Username" varchar(30) NOT NULL,
  "Password" varchar(30) NOT NULL,
  "Id_Usuario" integer NOT NULL,
  CONSTRAINT id_pk_admin PRIMARY KEY ("Id")
);
-- ddl-end --
ALTER TABLE public."Usuario_Administrador" OWNER TO postgres;
-- ddl-end --

-- object: public."Usuario_Cliente" | type: TABLE --
-- DROP TABLE IF EXISTS public."Usuario_Cliente" CASCADE;
CREATE TABLE public."Usuario_Cliente" (
  "Id" serial NOT NULL,
  "Username" varchar(30) NOT NULL,
  "Password" varchar(30) NOT NULL,
  "Id_Usuario" integer NOT NULL,
  CONSTRAINT id_pk_client PRIMARY KEY ("Id")
);
-- ddl-end --
ALTER TABLE public."Usuario_Cliente" OWNER TO postgres;
-- ddl-end --

-- object: "Usuario_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Usuario_Administrador" DROP CONSTRAINT IF EXISTS "Usuario_fk" CASCADE;
ALTER TABLE public."Usuario_Administrador" ADD CONSTRAINT "Usuario_fk" FOREIGN KEY ("Id_Usuario")
REFERENCES public."Usuario" ("Id") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "Usuario_Administrador_uq" | type: CONSTRAINT --
-- ALTER TABLE public."Usuario_Administrador" DROP CONSTRAINT IF EXISTS "Usuario_Administrador_uq" CASCADE;
ALTER TABLE public."Usuario_Administrador" ADD CONSTRAINT "Usuario_Administrador_uq" UNIQUE ("Id_Usuario");
-- ddl-end --

-- object: "Usuario_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Usuario_Cliente" DROP CONSTRAINT IF EXISTS "Usuario_fk" CASCADE;
ALTER TABLE public."Usuario_Cliente" ADD CONSTRAINT "Usuario_fk" FOREIGN KEY ("Id_Usuario")
REFERENCES public."Usuario" ("Id") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "Usuario_Cliente_uq" | type: CONSTRAINT --
-- ALTER TABLE public."Usuario_Cliente" DROP CONSTRAINT IF EXISTS "Usuario_Cliente_uq" CASCADE;
ALTER TABLE public."Usuario_Cliente" ADD CONSTRAINT "Usuario_Cliente_uq" UNIQUE ("Id_Usuario");
-- ddl-end --
