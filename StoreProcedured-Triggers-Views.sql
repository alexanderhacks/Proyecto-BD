
-- 1. Funciones
-- Configuración de los datos de las películas
CREATE FUNCTION updateDescription(
    id_pelicula varchar(10),
    newDescription varchar(100)
) RETURNS VOID AS
$$
BEGIN
    UPDATE "Peliculas"
    SET resena = newDescription
    WHERE id = id_pelicula;
END
$$;
-- Configuracion de la contraseña del usuario
CREATE FUNCTION updatePassword(
    username varchar(15),
    newPassword varchar(15)
) RETURNS VOID AS
$$
BEGIN
    UPDATE "Usuario"
    SET contrasena = newPassword
    WHERE usuario = username;
END
$$;



-- 2. Views
-- Esta vista por lo general será utilizada por el colaborador encargado de ventanilla o las consultas realizadas desde la página web.
CREATE VIEW ButacasDisponibles
AS
	SELECT butaca_id, funcion_id, nro_fila, nro_columna
	FROM "ButacaFuncion";

-- Esta vista permite ver el historial de todos los socios activos

CREATE VIEW SociosActivos
AS
	SELECT cliente_id, membresia_id
	FROM "Socios";

-- 3. Stored Procedure
CREATE OR REPLACE PROCEDURE reserva(butaca_id varchar(10),
                                    funcion_id varchar(10),
                                    nro_fila varchar(1),
                                    nro_columna smallint)
    LANGUAGE SQL
AS
$$
INSERT INTO "ButacaFuncion"
VALUES (butaca_id, funcion_id, nro_fila, nro_columna);
$$;

-- 4. Triggers

-- El siguiente trigger busca realizar una acción cuando un nuevo socio se afilia a Cinemania.
CREATE FUNCTION nuevosocio_trigger_func()
RETURNS TRIGGER
AS
$$
BEGIN
	INSERT INTO "Socios"(cliente_id, membresia_id)
	VALUES (NEW.cliente_id, NEW.membresia_id);
RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER nuevosocio_insert_trigger
AFTER INSERT
ON "Socios"
FOR EACH ROW
EXECUTE PROCEDURE nuevosocio_trigger_func();

-- El siguiente trigger busca realizar una acción cuando una nueva película ha sido insertada en el catálogo
CREATE FUNCTION nuevopelicula_trigger_func()
RETURNS TRIGGER
AS
$$
BEGIN
	INSERT INTO "Peliculas"(nombre, idioma, fecha_adquision, fecha_estreno, genero_id, duracion_h, resena, nivelpublico_id)
	VALUES (NEW.nombre, NEW.idioma, NEW.fecha_adquision, NEW.fecha_estreno, NEW.genero_id, NEW.duracion_h, NEW.resena, NEW.nivelpublico_id);
RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER nuevosocio_insert_trigger
AFTER INSERT
ON "Peliculas"
FOR EACH ROW
EXECUTE PROCEDURE nuevopelicula_trigger_func();
