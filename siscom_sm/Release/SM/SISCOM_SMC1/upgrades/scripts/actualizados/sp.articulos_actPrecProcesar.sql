CREATE PROCEDURE `articulos_actPrecProcesar`(
	pIdFamiliaDD int,
	pIdFamiliaHH int,
	pIdSubFamDD int,
	pIdSubFamHH int,
	pIdProvDD int,
	pIdProvHH int,
	pIdMarcaDD int,
	pIdMarcaHH int,
	pBonif1 double,
	pBonif2 double,
	pBonif3 double,
	pBonif4 double,
	pMargenMax double,
	pMargenMin double,
	pPorVariacion DOUBLE,
	pTMon VARCHAR(3),
	pCotizac double
)
BEGIN
	DROP TABLE IF EXISTS tmp_artic;
	CREATE TEMPORARY TABLE tmp_artic AS (
		SELECT
			articulos.idArticulo,
			articulos.idProv,
			articulos.idFamilia,
			articulos.idSubFam,
			articulos.idmarca,
			articulos.codArt,
			articulos.descripcio,
			articulos.alicIVA,
			articulos.prLista,
			articulos.prListaExt,
			articulos.tmon,
			articulos.cotizac,			
			articulos.bonif1,
			articulos.bonif2,
			articulos.bonif3,
			articulos.bonif4,
			articulos.costoRep,
			articulos.margenMax,
			articulos.margenMin,
			articulos.prventaMax,
			articulos.prventaMin,
			articulos.prfinalMax,
			articulos.prfinalMin,
			articulos.observ
		FROM
			articulos
		WHERE
			CASE WHEN pIdFamiliaDD = -1 AND pIdFamiliaHH = -1 
				THEN 1
				ELSE articulos.idFamilia BETWEEN pIdFamiliaDD AND pIdFamiliaHH END
			AND
			CASE WHEN pIdSubFamDD = -1	AND pIdSubFamHH = -1 
				THEN 1
				ELSE articulos.idSubFam BETWEEN pIdSubFamDD AND pIdSubFamHH END
			AND
			CASE WHEN pIdProvDD = -1 AND pIdProvHH = -1 
				THEN 1
				ELSE articulos.idProv BETWEEN pIdProvDD AND pIdProvHH END
			AND
			CASE WHEN pIdMarcaDD = -1 AND pIdMarcaHH = -1 
				THEN 1
				ELSE articulos.idmarca BETWEEN pIdMarcaDD AND pIdMarcaHH END
			AND articulos.tmon = pTMon
			AND
				articulos.fecBaja IS NULL
		ORDER BY
			articulos.codArt);

	UPDATE
		tmp_artic
	SET
		tmp_artic.bonif1 = CASE WHEN pBonif1 = -1 THEN tmp_artic.bonif1 ELSE pBonif1 END,
		tmp_artic.bonif2 = CASE WHEN pBonif2 = -1 THEN tmp_artic.bonif2 ELSE pBonif2 END,
		tmp_artic.bonif3 = CASE WHEN pBonif3 = -1 THEN tmp_artic.bonif3 ELSE pBonif3 END,
		tmp_artic.bonif4 = CASE WHEN pBonif4 = -1 THEN tmp_artic.bonif4 ELSE pBonif4 END,
		tmp_artic.margenMax = CASE WHEN pMargenMax = -1 THEN tmp_artic.margenMax ELSE pMargenMax END,
		tmp_artic.margenMin = CASE WHEN pMargenMin = -1 THEN tmp_artic.margenMin ELSE pMargenMin END;
	
	IF pTMon != 'PSO' THEN
		-- Actualización de listas en moneda extrangera
		IF pPorVariacion != 0 THEN
			UPDATE
				tmp_artic
			SET
				tmp_artic.prListaExt = tmp_artic.prListaExt + (tmp_artic.prListaExt * (pPorVariacion / 100));
		END IF;
		
		-- Vuelvo si la cotización es 0 vuelvo a pesificar tomando la cotización que tiene cargada
		-- el artículo. Esto es por si se genera una variación porcentual en el precio del dolar.
		UPDATE
			tmp_artic
		SET
			tmp_artic.cotizac = (CASE WHEN pCotizac = 0 THEN tmp_artic.cotizac ELSE pCotizac END),
			tmp_artic.prLista = tmp_artic.prListaExt * (CASE WHEN pCotizac = 0 THEN tmp_artic.cotizac ELSE pCotizac END);
	ELSE
		-- Actualización de listas en pesos.
		IF pPorVariacion != 0 THEN
			UPDATE
				tmp_artic
			SET
				tmp_artic.prLista = tmp_artic.prLista + (tmp_artic.prLista * (pPorVariacion / 100));
		END IF;		
	END IF;

	UPDATE
		tmp_artic
	SET
		tmp_artic.costoRep = articulos_calcularCosto (
			tmp_artic.prLista,
			tmp_artic.bonif1,
			tmp_artic.bonif2,
			tmp_artic.bonif3,
			tmp_artic.bonif4),
		tmp_artic.prventaMax = articulos_calcularVenta (
			tmp_artic.costoRep,
			tmp_artic.margenMax),
		tmp_artic.prventaMin = articulos_calcularVenta (
			tmp_artic.costoRep,
			tmp_artic.margenMin),
		tmp_artic.prfinalMax = articulos_calcPrFinal (
			tmp_artic.prventaMax,
			tmp_artic.alicIVA),
		tmp_artic.prfinalMin = articulos_calcPrFinal (
			tmp_artic.prventaMin,
			tmp_artic.alicIVA);

	SELECT * FROM tmp_artic;
END
