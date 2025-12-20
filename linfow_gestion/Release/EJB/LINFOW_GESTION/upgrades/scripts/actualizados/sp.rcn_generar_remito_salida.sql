CREATE PROCEDURE rcn_generar_remito_salida (
	xidCliente int,
	xid_rtoent int,
	xobservaciones varchar(200),
	xusuario varchar(5),
	xhost varchar(50)
)
BEGIN
	DECLARE vProxID int;
	DECLARE vNumeroRemito int;
	DECLARE vDestino varchar(200);
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		GET DIAGNOSTICS CONDITION 1
			@mensaje = MESSAGE_TEXT;
			
		SELECT 0 AS 'result', @mensaje AS 'mensaje', -1 AS 'id_rtosal';
	END;
	
	START TRANSACTION;

	/* Pago 1: Grabo la cabecera */
	SELECT
		CASE WHEN MAX(id_rtoent) IS NULL THEN 1 ELSE MAX(id_rtoent) + 1 END
	INTO
		vProxID
	FROM
		rcn_remito;
	
	-- Calculo el próximo número de remito de salida
	SELECT
		CASE WHEN MAX(CONVERT(numero, SIGNED integer)) IS NULL THEN 1 ELSE MAX(CONVERT(numero, SIGNED integer)) + 1 END
	INTO
		vNumeroRemito
	FROM
		rcn_remito
	WHERE
		rcn_remito.id_tiporto = 2;
		
	SELECT
		destino
	INTO
		vDestino
	FROM
		rcn_remito
	WHERE
		rcn_remito.id_rtoent = xid_rtoent;
		
	INSERT INTO rcn_remito (
		id_rtoent, id_tiporto, idCliente, numero,
		destino, observaciones, usuAlta, fecAlta,
		idHostAlta)
	VALUES (
		vProxID, 2, xidCliente, CONCAT(REPEAT('0', 8 - LENGTH(vNumeroRemito)), vNumeroRemito),
		vDestino, xobservaciones, xusuario, current_timestamp,
		xhost);
	
	/* Paso 2: Actualiza el id_rtosal en rcn_ficha y cambio el estado
		a entregado.*/
	UPDATE
		rcn_ficha rf
			INNER JOIN rcn_remito rr ON rf.id_rtoent = rr.id_rtoent
			INNER JOIN rcn_aux_fichas_rtosal temp ON temp.id_ficha = rf.id_ficha
	SET
		rf.id_rtosal = vProxID,
		rf.id_estado = 4,
		rf.usuModi = xusuario,
		rf.fecModi = current_timestamp,
		rf.idHostModi = xhost
	WHERE
		rr.idCliente = xidCliente AND
		rf.id_estado = 3;
	
	COMMIT;
	SELECT 1 AS 'result', 'El remito de salida se grabó satisfactoriamente' AS 'mensaje', vProxID AS 'id_rtosal';
END