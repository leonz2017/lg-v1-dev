CREATE PROCEDURE ordtrabajo_delete (
	xid int, xusuario varchar(5), xhost varchar(50))
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		GET DIAGNOSTICS CONDITION 1 @mensaje = MESSAGE_TEXT;
		SELECT 0 AS 'result', @mensaje AS 'mensaje';
	END;
	
	START TRANSACTION;
	
	UPDATE
		ordtrabajo
	SET
		ordtrabajo.usuBaja = xusuario,
		ordtrabajo.fecBaja = CURRENT_TIMESTAMP,
		ordtrabajo.idHostBaja = xhost
	WHERE
		ordtrabajo.id = xid;
	
	COMMIT;
	SELECT 1 AS 'result', 'La orden de trabajo se eliminó con éxito' AS 'mensaje';
END