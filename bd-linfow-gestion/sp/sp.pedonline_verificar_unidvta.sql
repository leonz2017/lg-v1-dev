CREATE PROCEDURE pedonline_verificar_unidvta (
	xcodart varchar(20)
)
BEGIN
	SELECT
		COUNT(*) AS 'cantDuplicado'
	INTO
		@cantDuplicado
	FROM
		articulos
	WHERE
		articulos.codArt = xcodart AND
		articulos.fecBaja IS NULL AND
		articulos.habilitado = 1;
	
	IF @cantDuplicado > 1 THEN
		SELECT 
			CONCAT('El articulo: ', xcodart, ' se encuentra repetido ', @cantDuplicado, ' veces. Corregir esta situacion desde el ABM de articulos.') AS 'mensaje', 
			-1 AS 'cantiDesp';
	ELSE
		SELECT
			idArticulo
		INTO
			@idArticulo
		FROM
			articulos
		WHERE
			articulos.codArt = xcodart AND
			articulos.fecBaja IS NULL AND
			articulos.habilitado = 1;
			
		SELECT
			'OK' AS 'mensaje',
			MIN(cantiDesp) AS 'cantiDesp'
		FROM
			codiart
		WHERE
			codiart.idArticulo = @idArticulo AND
			codiart.circuito IN ('CV', 'V')
		GROUP BY
			idArticulo;
	END IF;
END