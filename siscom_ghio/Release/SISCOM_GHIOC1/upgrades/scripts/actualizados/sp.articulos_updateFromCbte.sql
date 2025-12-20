CREATE PROCEDURE `articulos_updateFromCbte`(
	IN `pIdArticulo` INT,
	IN `pIdCliente` INT,
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
	DECLARE vPrVenta DOUBLE;
	DECLARE vEsMayorista BIT;
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
	
	SELECT
		mayorista
	INTO
		vEsMayorista
	FROM
		clientes
	WHERE
		clientes.idCliente = pIdCliente;
	
	IF vEsMayorista THEN
		-- Paso por acá si corresponde precio mayorista.
		SET vPrVenta = pPreVtaFinal / (1 + (vAlicIVA / 100));
		SET vCosto = vPrVenta / (1 + (vMargenMay / 100));

		-- Si está tildado impuestos internos, entonces lo calculo
		-- tanto para precio mayorista como minorista.
		IF vUsarImpuIn THEN
			SET vImpImInMay = pPreVtaFinal * (vPorImpuIn / 100);
		END IF;
	ELSE
		-- Paso por acá si corresponde precio minorista
		SET vPrVenta = pPreVtaFinal / (1 + (vAlicIVA / 100));
		SET vCosto = vPrVenta / (1 + (vMargenMin / 100));

		-- Si está tildado impuestos internos, entonces lo calculo
		-- tanto para precio mayorista como minorista.
		IF vUsarImpuIn THEN
			SET vImpImInMin = pPreVtaFinal * (vPorImpuIn / 100);
		END IF;
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
	
	IF vEsMayorista THEN
		UPDATE
			articulos
		SET
			articulos.prVentaMax = vPrVenta,
			articulos.prFinalMax = pPreVtaFinal,
			articulos.impImInMay = vImpImInMay,
			articulos.fecActuPre = CURRENT_TIMESTAMP,
			articulos.usuModi = pUsuario,
			articulos.fecModi = CURRENT_TIMESTAMP,
			articulos.idHostModi = pHostName
		WHERE
			articulos.idArticulo = pIdArticulo;
	ELSE
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
	END IF;
	CALL art_cbios_insert(pIdArticulo, vCostoAnt, vCosto);
	COMMIT;
	
	SELECT 'OK' AS 'result';
END
