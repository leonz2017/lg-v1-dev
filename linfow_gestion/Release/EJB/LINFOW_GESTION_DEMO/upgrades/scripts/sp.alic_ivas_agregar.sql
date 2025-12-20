CREATE PROCEDURE alic_ivas_agregar (
	xalicuota DECIMAL(5, 2),
    xid_afip INT)
BEGIN
	DECLARE vCantReg INT;
    DECLARE vMensaje TEXT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		ROLLBACK;
        GET DIAGNOSTICS CONDITION 1 vMensaje = MESSAGE_TEXT;
		INSERT INTO log_sps (sp_name, fecha, msgerror, usuario, host)
		VALUES ('alic_ivas_agregar', current_timestamp, vMensaje, '', '');
    END;
	
	START TRANSACTION;
    
	SELECT
		COUNT(*)
	INTO
		vCantReg
	FROM
		alic_ivas
	WHERE
		alic_ivas.alicuota = xalicuota;
		
	IF vCantReg = 0 THEN
		INSERT INTO alic_ivas (
			alicuota, id_afip)
		VALUES (
			xalicuota, xid_afip);
	END IF;
	
	COMMIT;
END