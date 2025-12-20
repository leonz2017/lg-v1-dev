CREATE PROCEDURE ordpag_delete (
	xidProv int,
	xidOrdPagC int,
	xusuario varchar(5),
	xhost varchar(50))
BEGIN
	DECLARE vMensaje TEXT;
	DECLARE vNumeroOP int;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		GET DIAGNOSTICS CONDITION 1 vMensaje = MESSAGE_TEXT;
		SELECT 0 AS 'result', vMensaje AS 'mensaje';
	END;
	
	START TRANSACTION;
	/* Paso 1: Recupero el número de orden de pago */
	SELECT
		nroOP
	INTO
		vNumeroOP
	FROM
		ordpag_c
	WHERE
		ordpag_c.idOrdPagC = xidOrdPagC AND
		ordpag_c.idProv = xidProv;
		
	/* Paso 2: Doy de baja la orden en la cuenta corriente de proveedores */
	UPDATE
		cc_prov
	SET
		cc_prov.usuBaja = xusuario,
		cc_prov.fecBaja = current_timestamp,
		cc_prov.idHostBaja = xhost
	WHERE
		cc_prov.cbte = 'OP' AND
		cc_prov.nroCbte = vNumeroOP;
		
	/* Paso 3: Doy de baja la cabecera de la orden de pago  */
	UPDATE
		ordpag_c
	SET
		ordpag_c.usuBaja = xusuario,
		ordpag_c.fecBaja = current_timestamp,
		ordpag_c.idHostBaja = xhost
	WHERE
		ordpag_c.idProv = xidProv AND
		ordpag_c.idOrdPagC = xidOrdPagC;
	
	COMMIT;
	SELECT 1 AS 'result', 'La orden se eliminó satisfactoriamente' AS 'mensaje';
END