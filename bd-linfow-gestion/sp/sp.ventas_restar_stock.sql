CREATE PROCEDURE ventas_restar_stock (
	xidVentaC int,
	xusuario varchar(5),
	xhost varchar(50),
	xautoTransaction bit)
BEGIN
	DECLARE vMensaje TEXT;
	DECLARE vidStkCab int;
	DECLARE vCbte varchar(3);
	DECLARE vtipoDoc varchar(1);
	DECLARE vnumCbte varchar(20);
	DECLARE vidCliente int;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		IF xautoTransaction = 1 THEN
			ROLLBACK;
		END IF;
	
		GET DIAGNOSTICS CONDITION 1 vMensaje = MESSAGE_TEXT;
		INSERT INTO log_sps (sp_name, msgerror, usuario, host)
		VALUES ('ventas_restar_stock', vMensaje, xusuario, xhost);
		SELECT '0' AS 'result';
	END;
	
	IF xautoTransaction = 1 THEN
		START TRANSACTION;
	END IF;
	
	-- Caclulo el próximo Id. de cabecera de stock
	SELECT
		CASE WHEN MAX(idStkCab) IS NULL THEN 1 ELSE MAX(idStkCab) + 1 END
	INTO
		vidStkCab
	FROM
		stk_cab;
	
	-- Recupero los datos que necesito de la tabla de ventas.
	SELECT
		cbte, 
		tipoDoc, 	
		CONCAT(REPEAT('0', 5 - length(ptoVta)), ptoVta, '-', REPEAT('0', 8 - LENGTH(numCbte)), numCbte) AS numCbte, 
		idCliente
	INTO
		vCbte, 
		vtipoDoc, 
		vnumCbte, 
		vidCliente
	FROM
		ventascab
	WHERE
		ventascab.idVentasC = xidVentaC;
			
	-- Genero el registro de cabecera de stock
	INSERT INTO stk_cab (
		idStkCab, circuito, cbte, tipoDoc, numCbte, idCliente, usuAlta, fecAlta, idHostAlta)
	VALUES (
		vidStkCab, 'V', vCbte, vtipoDoc, vnumCbte, vidCliente, xusuario, current_timestamp, xhost);
	
	-- Recupero los ítems.
	INSERT INTO stk_det (
		idStkDet, idStkCab, idArticulo, idStkDep,
		tipoMov, cantidad, costoRep, nroPart)
			SELECT
				ventasdet.idVentasD, vidStkCab AS idStkCab, ventasdet.idArticulo, art_dep.idStkDep,
				'SAL', ventasdet.cantidad * -1, articulos.costoRep, '' AS nroPart
			FROM
				ventasdet
					INNER JOIN articulos ON articulos.idArticulo = ventasdet.idArticulo
					INNER JOIN art_dep ON art_dep.idArticulo = ventasdet.idArticulo
			WHERE
				ventasdet.idVentasC = xidVentaC;
				
	IF xautoTransaction = 1 THEN
		COMMIT;
	END IF;
	SELECT '1' AS 'result';
END