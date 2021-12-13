-- 1. Funciones

-- Configuración de los datos de las películas
CREATE FUNCTION updateDescription(
	id_pelicula varchar(10),
	newDescription varchar(100)
) RETURNS VOID AS $$
BEGIN
	UPDATE USUARIO
	SET contrasena = newPassowrd
	WHERE username = usuario;
END
-- Configuracion de la contraseña del usuario
CREATE FUNCTION updatePassword(
	username varchar(15),
	newPassword varchar(15)
) RETURNS VOID AS $$
	BEGIN
		UPDATE USUARIO
		SET contrasena = newPassowrd
		WHERE username = usuario;
	END
$$ LANGUAGE as plpsql;

-- 2. Views
-- Esta vista por lo general será utilizada por el colaborador encargado de ventanilla o las consultas realizadas desde la página web.
CREATE VIEW ButacasDisponibles
AS 
	SELECT butada_id, funcion_id, nro_fila, nro_columan
	FROM ButacaFuncion
WITH NOT DATA;
-- Esta vista por lo general será utilizada por el colaborador encargado de ventanilla o las consultas realizadas desde la página web.
CREATE VIEW ButacasDisponibles
AS 
	SELECT butada_id, funcion_id, nro_fila, nro_columan
	FROM ButacaFuncion
WITH NOT DATA;

-- Esta vista permite ver el historial de todos los socios activos

CREATE VIEW SociosActivos
AS
	SELECT cliente_id, membresia_id
	FROM Socios
WITH NOT DATA;

-- 3. Triggers

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
LANGUAGE pLppgsql;

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
	INSERT INTO "Peliculas"(nombre, idioma, fecha_adquision, fecha_estreno, genero_id, duracion_h, resena, nivelpublico_id, id_directores)
	VALUES (NEW.cliente_id, NEW.membresia_id);
RETURN NEW;
END;
$$
LANGUAGE pLppgsql;

CREATE TRIGGER nuevosocio_insert_trigger
AFTER INSERT
ON "Peliculas"
FOR EACH ROW
EXECUTE PROCEDURE nuevopelicula_trigger_func();


