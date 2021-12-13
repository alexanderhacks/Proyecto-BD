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
	VALUES (NEW.nombre, NEW.idioma, NEW.fecha_adquision, NEW.fecha_estreno, NEW.genero_id, NEW.duracion_h, NEW.resena, NEW.nivelpublico_id, NEW.id_directores);
RETURN NEW;
END;
$$
LANGUAGE pLppgsql;

CREATE TRIGGER nuevosocio_insert_trigger
AFTER INSERT
ON "Peliculas"
FOR EACH ROW
EXECUTE PROCEDURE nuevopelicula_trigger_func();

-- 3. Stored Procedure
CREATE PROCEDURE reserva(
	varchar(10) butaca_id,
	varchar(10) funcion_id,
	varchar(1) nro_fila,
	smallint nro_columna
)
language plpgsql
AS $$
BEGIN
	IF (butaca_id, funcion_id, nro_fila, nro_columna) NOT IN
	(
		SELECT butaca_id, funcion_id, nro_fila, nro_columna
		FROM ButacaFuncion
	)
	INSERT INTO "ButacaFuncion"(butaca_id, ventaentrada_id, funcion_id, nro_fila, nro_columna, tipo_entrada, precio_entrada)
	VALUES (NEW.butaca_id, NEW.ventaentrada_id, NEW.funcion_id, NEW.nro_fila, NEW.nro_columna, NEW.tipo_entrada, NEW.precio_entrada);
	ELSE
		THROW 51000, 'El asiento ya ha sido reservado', 1;  
	COMMIT
END; $$
call reserva(####, #####, ####, ####);

