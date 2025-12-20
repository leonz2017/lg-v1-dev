CREATE PROCEDURE `artcat_insertToTemp`(
	pIdProv INT,
	pBonif1 DECIMAL (10, 2),
	pBonif2 DECIMAL (10, 2),
	pBonif3 DECIMAL (10, 2),
	pBonif4 DECIMAL (10, 2),
    pMargenMay DECIMAL (10, 2),
    pMargenMin DECIMAL (10, 2),
	pHostName VARCHAR(50)
)
BEGIN
	DECLARE vErrorMessage VARCHAR(254);
	DECLARE EXIT handler FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 vErrorMessage = message_text;
		SELECT vErrorMessage AS 'result';
	END;
               
	UPDATE 
		tmp_artcat
			INNER JOIN articulos ON articulos.codArtPV = tmp_artcat.codArt
	SET
		tmp_artcat.idArticulo = articulos.idArticulo,
		tmp_artcat.bonif1 = CASE WHEN pBonif1 = 0 THEN IFNULL(articulos.bonif1, 0) ELSE pBonif1 END,
        tmp_artcat.bonif2 = CASE WHEN pBonif2 = 0 THEN IFNULL(articulos.bonif2, 0) ELSE pBonif2 END,
        tmp_artcat.bonif3 = CASE WHEN pBonif3 = 0 THEN IFNULL(articulos.bonif3, 0) ELSE pBonif3 END,
        tmp_artcat.bonif4 = CASE WHEN pBonif4 = 0 THEN IFNULL(articulos.bonif4, 0) ELSE pBonif4 END,
        tmp_artcat.costoAnt = articulos.costoRep,
        tmp_artcat.margenMay = CASE WHEN pMargenMay = 0 THEN IFNULL(articulos.margenMax, 0) ELSE pMargenMay END,
        tmp_artcat.margenMin = CASE WHEN pMargenMin = 0 THEN IFNULL(articulos.margenMin, 0) ELSE pMargenMin END,
        tmp_artcat.alicIVA = IFNULL(articulos.alicIVA, 21)
	WHERE
		articulos.idProv = pIdProv AND
		articulos.fecBaja IS NULL;
        
	UPDATE
		tmp_artcat
	SET
		tmp_artcat.costoRep = articulos_calcularCosto(tmp_artcat.prLista, tmp_artcat.bonif1,
			tmp_artcat.bonif2, tmp_artcat.bonif3, tmp_artcat.bonif4);
            
	UPDATE
		tmp_artcat
	SET
		tmp_artcat.prVentaMay = articulos_calcularVenta(tmp_artcat.costoRep, tmp_artcat.margenMay),
		tmp_artcat.prVentaMin = articulos_calcularVenta(tmp_artcat.costoRep, tmp_artcat.margenMin);
            
	UPDATE
		tmp_artcat
	SET
		tmp_artcat.prFinalMay = articulos_calcPrFinal(tmp_artcat.prVentaMay, tmp_artcat.alicIVA),
        tmp_artcat.prFinalMin = articulos_calcPrFinal(tmp_artcat.prVentaMin, tmp_artcat.alicIVA);

	SELECT 'OK' AS 'result';
END
