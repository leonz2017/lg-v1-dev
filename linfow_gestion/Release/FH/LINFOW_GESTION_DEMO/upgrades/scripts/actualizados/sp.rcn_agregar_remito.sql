CREATE PROCEDURE rcn_agregar_remito (
	xid_tiporto int,
	xidCliente int, 
	xnumero varchar(20), 
	xdestino varchar(200), 
	xobservaciones text, 
	xusuario varchar(5), 
	xhostname varchar(50)
)
BEGIN
	DECLARE vMensaje text;
	DECLARE vIdRtoEnt int;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		GET DIAGNOSTICS CONDITION 1 
			vMensaje = MESSAGE_TEXT;
		
		/* Limpio la tabla temporal */
		DELETE FROM rcn_aux_rtitem WHERE usuario = xusuario AND host = xhostname;
		
		SELECT 'BD_ERROR' AS 'result', vMensaje AS 'mensaje';
	END;
	
	START TRANSACTION;
	
	/* Calculo el próximo ID. */		
	SELECT COALESCE(MAX(id_rtoent), 0) + 1 INTO vIdRtoEnt FROM rcn_remito;
		
	/* Creo el registro en la cabecera de remito*/
	INSERT INTO rcn_remito (
		id_rtoent, id_tiporto, idCliente, numero,
		destino, observaciones, usuAlta, fecAlta,
		idHostAlta)
	VALUES (
		vIdRtoEnt, xid_tiporto, xidCliente, xnumero,
		xdestino, xobservaciones, xusuario, current_timestamp,
		xhostname);
					
	/* Agrego el detalle en la ficha */
	INSERT INTO rcn_ficha (
		id_estado, id_rtoent, idmarca, medida, nro_serie, trabajo,
		usuAlta, fecAlta, idHostAlta)
			SELECT
				1 AS 'id_estado', vIdRtoEnt, idmarca, medida, nro_serie, trabajo,
				usuario, current_timestamp, host
			FROM
				rcn_aux_rtitem
			WHERE
				usuario = xusuario AND
				host = xhostname;
			
	COMMIT;
	
	/* Limpio la tabla temporal */
	DELETE FROM rcn_aux_rtitem WHERE usuario = xusuario AND host = xhostname;
	
	SELECT 'OK' AS 'result', 'El remito se grabó satisfactoriamente' AS 'mensaje';
END