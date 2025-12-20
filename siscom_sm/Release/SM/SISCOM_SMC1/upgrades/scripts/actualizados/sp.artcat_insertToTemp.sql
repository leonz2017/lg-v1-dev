CREATE PROCEDURE `artcat_insertToTemp`(
	pIdProv INT,
	pCodArt VARCHAR(20),
	pDescripcio VARCHAR(60),
	pFamilia VARCHAR(60),
	pSubfam VARCHAR(60),
	pMarca VARCHAR(60),
	pPrLista DOUBLE,
	pBonif1 DOUBLE,
	pBonif2 DOUBLE,
	pBonif3 DOUBLE,
	pBonif4 DOUBLE,
	pMargenMay DOUBLE,
	pMargenMin DOUBLE,
	pHostName VARCHAR(50)
)
BEGIN
	DECLARE vErrorMessage VARCHAR(254);
	DECLARE vIdArticulo INT;
	DECLARE vCostoAnt DOUBLE;
	DECLARE vBonif1 DOUBLE;
	DECLARE vBonif2 DOUBLE;
	DECLARE vBonif3 DOUBLE;
	DECLARE vBonif4 DOUBLE;
	DECLARE vCostoRep DOUBLE;
	DECLARE vMargenMay DOUBLE;
	DECLARE vMargenMin DOUBLE;
	DECLARE vPrVentaMay DOUBLE;
	DECLARE vPrVentaMin DOUBLE;
	DECLARE vPrFinalMay DOUBLE;
	DECLARE vPrFinalMin DOUBLE;
	DECLARE vAlicIVA DOUBLE;
	DECLARE EXIT handler FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 vErrorMessage = message_text;
		SELECT vErrorMessage AS 'result';
	END;
				
	SELECT
		idArticulo,
		CASE WHEN pBonif1 = 0 THEN bonif1 ELSE pBonif1 END AS bonif1,
		CASE WHEN pBonif2 = 0 THEN bonif2 ELSE pBonif2 END AS bonif2,
		CASE WHEN pBonif3 = 0 THEN bonif3 ELSE pBonif3 END AS bonif3,
		CASE WHEN pBonif4 = 0 THEN bonif4 ELSE pBonif4 END AS bonif4,
		CASE WHEN pMargenMay = 0 THEN margenMax ELSE pMargenMay END AS margenMay,
		CASE WHEN pMArgenMin = 0 THEN margenMin ELSE pMargenMin END AS margenMin,
		alicIVA,
		costoRep
	INTO 
		vIdArticulo,
		vBonif1,
		vBonif2,
		vBonif3,
		vBonif4,
		vMargenMay,
		vMargenMin,
		vAlicIVA,
		vCostoAnt
	FROM
		tmp_artic
	WHERE
		tmp_artic.codArt = pCodArt;
	
	SET vIdArticulo = IFNULL(vIdArticulo, 0);
	SET vCostoAnt = IFNULL(vCostoAnt, 0);
	SET vBonif1 = IFNULL(vBonif1, pBonif1);
	SET vBonif2 = IFNULL(vBonif2, pBonif2);
	SET vBonif3 = IFNULL(vBonif3, pBonif3);
	SET vBonif4 = IFNULL(vBonif4, pBonif4);
	SET vMargenMay = IFNULL(vMargenMay, pMargenMay);
	SET vMargenMin = IFNULL(vMargenMin, pMargenMin);
	SET vAlicIVA = IFNULL(vAlicIVA, 21);

	SET vCostoRep = articulos_calcularCosto(pPrLista, vBonif1, vBonif2, vBonif3, vBonif4);
	SET vPrVentaMay = articulos_calcularVenta(vCostoRep, vMargenMay);
	SET vPrVentaMin = articulos_calcularVenta(VCostoRep, vMargenMin);
	SET vPrFinalMay = articulos_calcPrFinal(vPrVentaMay, vAlicIVA);
	SET vPrFinalMin = articulos_calcPrFinal(vPrVentaMin, vAlicIVA);
	
	SET vPrVentaMay = IFNULL(vPrVentaMay, 0);
	SET vPrVentaMin = IFNULL(vPrVentaMin, 0); 
	SET vPrFinalMay = IFNULL(vPrFinalMay, 0);
	SET vPrFinalMin = IFNULL(vPrFinalMin, 0);

	INSERT INTO tmp_artcat (
		codArt, 
		descripcio, 
		familia, 
		subfam, 
		marca, 
		prLista,
		bonif1,
		bonif2,
		bonif3,
		bonif4,
		costoRep,
		margenMay,
		margenMin,
		prVentaMay,
		prVentaMin,
		prFinalMay,
		prFinalMin,
		alicIVA,
		costoAnt, 
		idArticulo, 
		hostName)
	VALUES (
		pCodArt, 
		pDescripcio, 
		pFamilia, 
		pSubfam, 
		pMarca, 
		pPrLista, 
		vBonif1,
		vBonif2,
		vBonif3,
		vBonif4,
		vCostoRep,
		vMargenMay,
		vMargenMin,
		vPrVentaMay,
		vPrVentaMin,
		vPrFinalMay,
		vPrFinalMin,
		vAlicIVA,
		vCostoAnt, 
		vIdArticulo, 
		pHostName);
		
	SELECT 'OK' AS 'result';
END