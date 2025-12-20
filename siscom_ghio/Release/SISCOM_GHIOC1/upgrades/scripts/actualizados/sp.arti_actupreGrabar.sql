CREATE PROCEDURE `arti_actupreGrabar`(
	pIdArticulo int,
	pPrLista double,
	pBonif1 double,
	pBonif2 double,
	pBonif3 double,
	pBonif4 double,
	pCostoRep double,
	pMargenMax double,
	pMargenMin double,
	pPrVentaMax double,
	pPrVentaMin double,
	pPrFinalMax double,
	pPrFinalMin double,
	pCodUsu varchar(5),
	pIdHostModi varchar(50))
BEGIN
	DECLARE vCostoAnt DOUBLE;
	DECLARE EXIT handler FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		SELECT 'Error en arti_actupreGrabar' AS result;
	END;
	START TRANSACTION;
	
	SELECT
		articulos.costoRep
	INTO
		vCostoAnt
	FROM
		articulos
	WHERE
		articulos.idArticulo = pIdArticulo;
	
	UPDATE
		articulos
	SET
		articulos.prLista = pPrLista,
		articulos.bonif1 = pBonif1,
		articulos.bonif2 = pBonif2,
		articulos.bonif3 = pBonif3,
		articulos.bonif4 = pBonif4,
		articulos.costoRep = pCostoRep,
		articulos.margenMax = pMargenMax,
		articulos.margenMin = pMargenMin,
		articulos.prventaMax = pPrVentaMax,
		articulos.prventaMin = pPrVentaMin,
		articulos.prfinalMax = pPrFinalMax,
		articulos.prfinalMin = pPrFinalMin,
        articulos.fecActuPre = CURRENT_TIMESTAMP,
		articulos.usumodi = pCodUsu,
		articulos.fecmodi = CURRENT_TIMESTAMP,
		articulos.idhostmodi = pIdHostModi
	WHERE
		articulos.idArticulo = pIdArticulo;
		
	CALL art_cbios_insert(pIdArticulo, vCostoAnt, pCostoRep);
	COMMIT;
	SELECT 'OK' AS result;
END