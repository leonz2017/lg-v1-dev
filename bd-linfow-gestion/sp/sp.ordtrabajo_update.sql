CREATE PROCEDURE ordtrabajo_update (
	x_id INT, xidcliente INT, xfecha DATETIME, xcantidad DECIMAL(10, 2),
	xdetalle VARCHAR(60), xprecio DECIMAL(20, 2), xfacturado bit,
	xusuario varchar(5), xHost varchar(50)
)
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
		ordtrabajo.idCliente = xidcliente,
		ordtrabajo.fecha = CAST(xfecha AS DATE),
		ordtrabajo.cantidad = xcantidad,
		ordtrabajo.detalle = xdetalle,
		ordtrabajo.precio = xprecio,
		ordtrabajo.facturado = xfacturado,
		ordtrabajo.usuModi = xusuario,
		ordtrabajo.fecModi = CURRENT_TIMESTAMP,
		ordtrabajo.idHostModi = xHost
	WHERE
		id = x_id;
		
	COMMIT;
	SELECT 1 AS 'result', 'El trabajo fue grabada con éxito' as 'mensaje';
END
