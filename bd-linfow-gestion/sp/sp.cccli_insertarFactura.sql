CREATE PROCEDURE cccli_insertarFactura (
	xidVentaC int)
BEGIN
	DECLARE vidCC_Cli int;
	DECLARE vidCliente int;
	DECLARE vCbte varchar(3);
	DECLARE vTipoDoc varchar(3);
	DECLARE vPtoVta int;
	DECLARE vNroCbte int;
	DECLARE vFecEmision datetime;
	DECLARE vFecVto datetime;
	DECLARE vImpDebe decimal(20, 2);
	DECLARE vidCondPago int;
	DECLARE vidSitIVA int;
	DECLARE vidVendedor int;
	DECLARE vidOper int;
	DECLARE vUsuario varchar(5);
	DECLARE vHost varchar(50);
	DECLARE vMensaje text;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 vMensaje = MESSAGE_TEXT;
		
		-- Guardo el error capturado en la tabla log_sps.
		INSERT INTO log_sps (
			sp_name, 
			fecha, 
			msgerror, 
			usuario, 
			host)
		VALUES (
			'cc_cli_insertDebe',
			current_timestamp,
			CONCAT('Error: ', vMensaje, 'Id Venta: ', xidVentaC),
			vUsuario,
			vHost
		);
	END;

	--	Obtengo los datos de la cabecera de ventas
	SELECT
		idCliente,
		idCondPago,
		idSitIVA,
		idVendedor,
		fecEmision,
		fecVto,
		cbte,
		tipoDoc,
		ptoVta,
		numCbte,
		totFact,
		usuAlta,
		idHostAlta
	INTO
		vidCliente,
		vidCondPago,
		vidSitIVA,
		vidVendedor,
		vFecEmision,
		vFecVto,
		vCbte,
		vTipoDoc,
		vPtoVta,
		vNroCbte,
		vImpDebe,
		vUsuario,
		vHost
	FROM
		ventascab
	WHERE
		ventascab.idVentasC = xidVentaC;
		
	-- Calculo el próximo id.
	SELECT
		CASE WHEN MAX(idCC_Cli) IS NULL THEN 1 ELSE MAX(idCC_Cli) + 1 END
	INTO
		vidCC_Cli
	FROM
		cc_cli;
		
	-- Calculo el próximo ID. de Operación
	SELECT
		CASE WHEN MAX(idOper) IS NULL THEN 1 ELSE MAX(idOper) + 1 END
	INTO
		vidOper
	FROM
		cc_cli;
		
	-- Inserto el registro en la tabla cc_cli.
	
	INSERT INTO cc_cli (
		idCC_Cli,
		idCliente,
		idVentasC,
		cbte,
		tipoDoc,
		ptoVta,
		nroCbte,
		fecEmis,
		fecVto,
		impDebe,
		impHaber,
		idOper,
		idCondPago,
		idSitIVA,
		idVendedor,
		usuAlta,
		fecAlta,
		idHostAlta)
	VALUES (
		vidCC_Cli,
		vidCliente,
		xidVentaC,
		vCbte,
		vTipoDoc,
		vPtoVta,
		vNroCbte,
		vFecEmision,
		vFecVto,
		vImpDebe,
		0,
		vidOper,
		vidCondPago,
		vidSitIVA,
		vidVendedor,
		vUsuario,
		current_timestamp,
		vHost);
END
	