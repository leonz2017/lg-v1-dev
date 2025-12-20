CREATE PROCEDURE `articulos_updateByPrecioFinal`(
	IN `pIdArticulo` INT,
	IN `pPreVtaFinal` DECIMAL(20, 2),
	IN `pUsuario` VARCHAR(5),
	IN `pHostName` VARCHAR(50)
)
BEGIN
	DECLARE vPrLista DECIMAL(20, 2);
	DECLARE vAlicIVA DECIMAL(5, 2);
	DECLARE vBonif1 DECIMAL(5, 2);
	DECLARE vBonif2 DECIMAL(5, 2);
	DECLARE vBonif3 DECIMAL(5, 2);
	DECLARE vBonif4 DECIMAL(5, 2);
	DECLARE vCosto DECIMAL(20, 2);
	DECLARE vCostoAnt DECIMAL(20, 2);
	DECLARE vMargenMay DECIMAL(5, 2);
	DECLARE vMargenMin DECIMAL(5, 2);
	DECLARE vPrVenta DECIMAL(20, 2);
    DECLARE vUsarImpuIn BIT;
    DECLARE vPorImpuIn DECIMAL(5, 2);
    DECLARE vImpImInMay DECIMAL(20, 2);
    DECLARE vImpImInMin DECIMAL(20, 2);
	DECLARE vMensaje TEXT;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		GET DIAGNOSTICS CONDITION 1 vMensaje = message_text;
		SELECT vMensaje AS 'result';
	END;
	
	SELECT
		alicIVA,
		bonif1,
		bonif2,
		bonif3,
		bonif4,
		margenMax,
		margenMin,
		costoRep,
        usarImpuIn,
        porImpuIn
	INTO
		vAlicIVA,
		vBonif1,
		vBonif2,
		vBonif3,
		vBonif4,
		vMargenMay,
		vMargenMin,
		vCostoAnt,
        vUsarImpuIn,
        vPorImpuIn
	FROM
		articulos
	WHERE
		articulos.idArticulo = pIdArticulo;
	
    SET vPrVenta = pPreVtaFinal / (1 + (vAlicIVA / 100));
    SET vCosto = vPrVenta / (1 + (vMargenMin / 100));

    IF vUsarImpuIn THEN
        SET vImpImInMin = pPreVtaFinal * (vPorImpuIn / 100);
    END IF;
	
	SET vPrLista = articulos_costo_to_lista(vCosto, vBonif1, vBonif2, vBonif3, vBonif4);
		
	START TRANSACTION;
	UPDATE
		articulos
	SET
		articulos.prLista = vPrLista,
		articulos.costorep = vCosto
	WHERE
		articulos.idArticulo = pIdArticulo;
	
	UPDATE
		articulos
	SET
		articulos.prVentaMin = vPrVenta,
		articulos.prFinalMin = pPreVtaFinal,
		articulos.impImInMin = vImpImInMin,
		articulos.fecActuPre = CURRENT_TIMESTAMP,
		articulos.usuModi = pUsuario,
		articulos.fecModi = CURRENT_TIMESTAMP,
		articulos.idHostModi = pHostName
	WHERE
		articulos.idArticulo = pIdArticulo;
		
	-- Calculo el precio de venta mayorista a partir del costo obtenido
	-- al calcularlo en base al precio de final minorista.
	SET vPrVenta = articulos_calcularVenta(vCosto, vMargenMay);
	UPDATE
		articulos
	SET
		articulos.prventaMax = vPrVenta,
		articulos.prfinalMax = vPrVenta + (vPrVenta * (vAlicIVA / 100))
	WHERE
		articulos.idArticulo = pIdArticulo;

	CALL art_cbios_insert(pIdArticulo, vCostoAnt, vCosto);
	COMMIT;
	
	SELECT 'OK' AS 'result';
END