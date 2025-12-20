DELIMITER $$

DROP PROCEDURE IF EXISTS articulos_updateFromCbte $$

CREATE PROCEDURE articulos_updateFromCbte (
	IN `pIdArticulo` INT,
	IN `pPreVtaFinal` DOUBLE,
	IN `pUsuario` VARCHAR(5),
	IN `pHostName` VARCHAR(50)
)
BEGIN
	DECLARE vPrLista DOUBLE;
	DECLARE vAlicIVA DOUBLE;
	DECLARE vBonif1 DOUBLE;
	DECLARE vBonif2 DOUBLE;
	DECLARE vBonif3 DOUBLE;
	DECLARE vBonif4 DOUBLE;
	DECLARE vCosto DOUBLE;
	DECLARE vCostoAnt DOUBLE;
	DECLARE vMargenMay DOUBLE;
	DECLARE vMargenMin DOUBLE;
	DECLARE vPrVentaMay DOUBLE;
	DECLARE vPrVentaMin DOUBLE;
	DECLARE vEsMayorista BIT;
    DECLARE vUsarImpuIn BIT;
    DECLARE vPorImpuIn DECIMAL(5, 2);
    DECLARE vImpImIn DECIMAL(20, 2);
    DECLARE vPrFinalMay DECIMAL(20, 2);
	DECLARE vMensaje TEXT;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		GET DIAGNOSTICS CONDITION 1 vMensaje = message_text;
		SELECT vMensaje AS 'result';
	END;
	
	SELECT
		alicIVA, bonif1, bonif2, bonif3, bonif4,
		margenMax, margenMin, costoRep, 
        usarImpuIn, porImpuIn
	INTO
		vAlicIVA, vBonif1, vBonif2, vBonif3, vBonif4,
		vMargenMay, vMargenMin, vCostoAnt, 
		vUsarImpuIn, vPorImpuIn
	FROM
		articulos
	WHERE
		articulos.idArticulo = pIdArticulo;
	
	SET vPrVentaMin = pPreVtaFinal / (1 + (vAlicIVA / 100));
	SET vCosto = vPrVentaMin / (1 + (vMargenMin / 100));
		
	SET vPrVentaMay = vCosto + (vCosto * (vMargenMay / 100));
	SET vPrFinalMay = vPrVentaMay + (vPrVentaMay * (vAlicIVA / 100));
	
	IF vUsarImpuIn THEN
		SET vImpImIn = pPreVtaFinal * (vPorImpuIn / 100);
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
		articulos.prVentaMin = vPrVentaMin,
		articulos.prVentaMax = vPrVentaMay,
		articulos.prFinalMin = pPreVtaFinal,
		articulos.prFinalMax = vPrFinalMay,
		articulos.impImInMay = vImpImIn,
		articulos.fecActuPre = CURRENT_TIMESTAMP,
		articulos.usuModi = pUsuario,
		articulos.fecModi = CURRENT_TIMESTAMP,
		articulos.idHostModi = pHostName
	WHERE
		articulos.idArticulo = pIdArticulo;

	CALL art_cbios_insert(pIdArticulo, vCostoAnt, vCosto);
	COMMIT;
	
	SELECT 'OK' AS 'result';
END