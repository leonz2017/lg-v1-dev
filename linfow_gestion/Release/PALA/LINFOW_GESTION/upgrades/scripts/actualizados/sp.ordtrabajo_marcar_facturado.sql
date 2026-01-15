CREATE PROCEDURE ordtrabajo_marcar_facturado (x_id INT)
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
		ordtrabajo.facturado = 1
	WHERE
		id = x_id;
		
	COMMIT;
	SELECT 1 AS 'result', 'El trabajo ya fue facturado' as 'mensaje';
END
