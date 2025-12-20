CREATE PROCEDURE agregar_faltantes (
	xidArticulo int,
	xcodArt varchar(20),
	xuniCpr float,
	xcantidad float,
	xidcliente int,
	xusuario varchar(5),
	xhost varchar(50))
BEGIN
	DECLARE vMensaje VARCHAR(200);
	DECLARE vCantReg INT;
	DECLARE vProxID INT;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		GET DIAGNOSTICS CONDITION 1 vMensaje = MESSAGE_TEXT;
	END;
	
	START TRANSACTION;
	
	-- Verifico si el artículo existe
	SELECT
		COUNT(*)
	INTO
		vCantReg
	FROM
		faltantes
	WHERE
		idArticulo = xidArticulo AND
                procesado = 0 AND
		fecBaja IS NULL;
	
	IF vCantReg = 0 THEN
		SELECT
			IFNULL(MAX(idFaltante), 0) + 1
		INTO
			vProxID
		FROM
			faltantes;
	
		INSERT INTO faltantes (
			idFaltante,
			idArticulo,
			codArt,
			uniCpr,
			cantidad,
			procesado,
			idCliente,
			usuAlta,
			fecAlta,
			idHostAlta)
		VALUES (
			vProxID,
			xidArticulo,
			xcodArt,
			xuniCpr,
			xcantidad,
			0,
			CASE WHEN xidcliente = 0 THEN NULL ELSE xidcliente END,
			xusuario,
			CURRENT_TIMESTAMP,
			xhost);
	ELSE
		UPDATE
			faltantes
		SET
			cantidad = cantidad + xcantidad
		WHERE
			idArticulo = xidArticulo;
	END IF;
	
	COMMIT;
END