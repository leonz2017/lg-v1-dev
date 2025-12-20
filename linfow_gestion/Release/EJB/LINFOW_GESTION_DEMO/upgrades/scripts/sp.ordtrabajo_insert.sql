CREATE PROCEDURE ordtrabajo_insert (
	xidcliente int, xfecha datetime, xcantidad decimal(10, 2),
	xdetalle VARCHAR(60), xprecio DECIMAL(20, 2), xfacturado bit,
	xusuario varchar(5), xHost varchar(50)
)
BEGIN
	DECLARE vIdOrden int;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		GET DIAGNOSTICS CONDITION 1 @mensaje = MESSAGE_TEXT;
		SELECT 0 AS 'result', @mensaje AS 'mensaje';
	END;
	
	START TRANSACTION;
	
	INSERT INTO ordtrabajo (
		idCliente, fecha, cantidad, detalle,
		precio, facturado, usuAlta, fecAlta, idHostAlta) 
	VALUES (
		xidcliente, CAST(xfecha AS DATE), xcantidad, xdetalle,
		xprecio, xfacturado, xusuario, CURRENT_TIMESTAMP, xHost);
	
	COMMIT;
	
	/* Obtengo el último id generado */
	SELECT
		CASE WHEN MAX(id) IS NULL THEN 1 ELSE MAX(id) END
	INTO
		vIdOrden
	FROM
		ordtrabajo;
		
	SELECT vIdOrden AS 'result', 'El trabajo fue grabada con éxito' as 'mensaje';
END
