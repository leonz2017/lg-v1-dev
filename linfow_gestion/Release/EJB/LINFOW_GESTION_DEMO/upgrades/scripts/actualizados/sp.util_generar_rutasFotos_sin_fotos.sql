CREATE PROCEDURE `util_generar_rutasFotos_sin_fotos`(
	pIdMarca int,
	pMarca varchar(60),
    pIdProv int)
BEGIN
	DECLARE vMensaje text;
	DECLARE EXIT handler FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		GET DIAGNOSTICS CONDITION 1 vMensaje = message_text;
		SELECT vMensaje AS 'result';
	END;

	START TRANSACTION;
    
    DROP TABLE IF EXISTS tmp_sin_fotos;
    CREATE TEMPORARY TABLE tmp_sin_fotos
		SELECT
			idArticulo
		FROM
			articulos
		WHERE
			articulos.linkFoto IS NULL AND
			articulos.idmarca = pIdMarca AND
            articulos.fecBaja IS NULL;

	UPDATE	articulos
		INNER JOIN tmp_sin_fotos ON tmp_sin_fotos.idArticulo = articulos.idArticulo
	SET 	articulos.linkfoto = CONCAT('C:\\MG_FOTOS\\', pMarca, '\\', articulos.codart, '.JPG')
	WHERE	articulos.idmarca = pIdMarca AND
			articulos.fecBaja IS NULL AND
            CASE WHEN pIdProv = 0 THEN 1 ELSE articulos.idProv = pIdProv END;
	
	UPDATE 	articulos
		INNER JOIN tmp_sin_fotos ON tmp_sin_fotos.idArticulo = articulos.idArticulo
	SET		articulos.linkfoto = CONCAT('C:\\MG_FOTOS\\', pMarca, '\\', 
				REPLACE(articulos.codArt, '/', '-'), '.JPG')
	WHERE articulos.idmarca = pIdMarca 
		AND articulos.codArt LIKE '%/%'
		AND articulos.fecBaja IS NULL AND
        CASE WHEN pIdProv = 0 THEN 1 ELSE articulos.idProv = pIdProv END;
	
	COMMIT;

	SELECT codart, linkfoto, marcas.descripcio, articulos.idProv
	FROM articulos
		INNER JOIN marcas ON marcas.idmarca = articulos.idmarca
        INNER JOIN tmp_sin_fotos ON tmp_sin_fotos.idArticulo = articulos.idArticulo
	WHERE marcas.idmarca = pIdMarca
		AND articulos.fecBaja IS NULL AND
        CASE WHEN pIdProv = 0 THEN 1 ELSE articulos.idProv = pIdProv END;
END