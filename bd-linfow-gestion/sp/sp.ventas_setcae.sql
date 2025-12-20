CREATE PROCEDURE ventas_setcae (
	xidventac int, 
	xptoVta int, 
	xnumcbte int, 
	xaut_CAE varchar(15),
	xaut_CAE_Vto datetime, 
	xaut_Resultado varchar(1), 
	xaut_Motivo varchar(254),
	xaut_tipoCbte varchar(2), 
	xaut_qr varchar(255))
BEGIN
	DECLARE vMensaje TEXT;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		GET DIAGNOSTICS CONDITION 1 vMensaje = MESSAGE_TEXT;
	
		-- Guardo el log en el SP.
		INSERT INTO log_sps (
			sp_name, msgerror, usuario, host)
		VALUES (
			'ventas_generar_cbtes', vMensaje, xusuario, xhost);	
	END;
	
	START TRANSACTION;
	
	UPDATE ventascab
	SET
		ventascab.ptoVta = xptoVta, 
		ventascab.numCbte = xnumcbte,
		ventascab.aut_CAE = xaut_CAE, 
		ventascab.aut_CAE_VTO = xaut_CAE_Vto,
		ventascab.aut_Resultado = xaut_Resultado, 
		ventascab.aut_Motivo = xaut_Motivo,
		ventascab.aut_tipoCbte = xaut_tipoCbte, 
		ventascab.aut_qr = xaut_qr,
		ventascab.fecEmision = CAST(current_timestamp AS DATE)
	WHERE
		ventascab.idVentasC = xidventac;
	
	COMMIT;
	
END
