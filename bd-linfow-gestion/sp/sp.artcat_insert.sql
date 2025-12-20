CREATE PROCEDURE `artcat_insert`(
	pIdProv INT,
    pBonif1 decimal(5, 2),
    pBonif2 decimal(5, 2),
    pBonif3 decimal(5, 2),
    pBonif4 decimal(5, 2),
    pMargenMay decimal(5, 2),
    pMargenMin decimal(5, 2),
	pUsuario VARCHAR(5),
	pHostName VARCHAR(50)
)
BEGIN
	DECLARE vMensaje VARCHAR(200);
	DECLARE EXIT handler FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;	
		GET DIAGNOSTICS CONDITION 1 vMensaje = message_text;
		SELECT vMensaje AS 'result';
	END;	
    
	START TRANSACTION;
	CALL artcat_addFamilia ('SUPER', 'ESCRITORIO');
	CALL artcat_AddSubFam ('SUPER', 'ESCRITORIO');
	CALL artcat_addMarca ('SUPER', 'ESCRITORIO');
	
	CREATE TEMPORARY TABLE tmp_familias
		SELECT
			familias.*
		FROM
			familias
				INNER JOIN tmp_artcat ON tmp_artcat.familia = familias.descripcio
		GROUP BY
			familias.idFamilia;
			
	CREATE TEMPORARY TABLE tmp_subfam
		SELECT
			subfam.*
		FROM
			subfam
				INNER JOIN tmp_artcat ON tmp_artcat.subfam = subfam.descripcio
		GROUP BY
			subfam.idSubFam;
			
	CREATE TEMPORARY TABLE tmp_marcas
		SELECT
			marcas.*
		FROM
			marcas
				INNER JOIN tmp_artcat ON tmp_artcat.marca = marcas.descripcio
		GROUP BY
			marcas.idmarca;
			
	CREATE INDEX idxtemp_familia ON tmp_familias (descripcio);
	CREATE INDEX idxtemp_subfam ON tmp_subfam (descripcio);
	CREATE INDEX idxtemp_marcas ON tmp_marcas (descripcio);
	CREATE INDEX idxtemp_familias1 ON tmp_artcat (familia);
	CREATE INDEX idxtemp_subfam1 ON tmp_artcat (subfam);
	CREATE INDEX idxtemp_marcas1 ON tmp_artcat (marca);
	
	SELECT
		CASE WHEN MAX(idArticulo) IS NULL THEN 0
		ELSE MAX(idArticulo) END
	INTO
		@idArticulo
	FROM
		articulos;
	
	INSERT INTO articulos (
		idArticulo,
        equiv,
		idProv,
		idFamilia,
		idSubFam,
		idmarca,
		idUniMed,
		codArt,
		codArtPV,
		descripcio,
		alicIVA,
		tmon,
		prListaExt,
		cotizac,
		prLista,
		bonif1,
		bonif2,
		bonif3,
		bonif4,
		costoRep,
		margenMax,
		margenMin,
		prVentaMax,
		prVentaMin,
		prFinalMax,
		prFinalMin,
		observ,
		habilitado,
		linkFoto,
		usuAlta,
		fecAlta,
		idHostAlta)
			SELECT
				@idArticulo := @idArticulo + 1 AS idArticulo,
                @idArticulo AS equiv,
				pIdProv AS idProv,
				tmp_familias.idFamilia,
				tmp_subfam.idSubFam,
				tmp_marcas.idmarca,
				1 AS idUniMed,
				CONCAT(LTRIM(RTRIM(tmp_artcat.codArt))) ,
				LTRIM(RTRIM(tmp_artcat.codArt)) AS codArtPV,
				tmp_artcat.descripcio,
				tmp_artcat.alicIVA,
				'PSO' AS tmon,
				0 AS prListaExt,
				0 AS cotizac,
				tmp_artcat.prLista,
				pBonif1,
				pBonif2,
				pBonif3, 
				pBonif4,
				articulos_calcularCosto(tmp_artcat.costoRep, pBonif1, pBonif2, pBonif3, pBonif4),
				pMargenMay,
				pMargenMin,
				articulos_calcularVenta(
					articulos_calcularCosto(tmp_artcat.costoRep, pBonif1, pBonif2, pBonif3, pBonif4), pMargenMay),
				articulos_calcularVenta(
					articulos_calcularCosto(tmp_artcat.costoRep, pBonif1, pBonif2, pBonif3, pBonif4), pMargenMin),
				articulos_calcPrFinal(
					articulos_calcularVenta(
					articulos_calcularCosto(tmp_artcat.costoRep, pBonif1, pBonif2, pBonif3, pBonif4), pMargenMay), tmp_artcat.alicIVA),
				articulos_calcPrFinal(
					articulos_calcularVenta(
					articulos_calcularCosto(tmp_artcat.costoRep, pBonif1, pBonif2, pBonif3, pBonif4), pMargenMin), tmp_artcat.alicIVA),
				'' AS observ,
				1 AS habilitado,
				'' AS linkFoto,
				pUsuario AS usualta,
				CURRENT_TIMESTAMP AS fecalta,
				pHostName AS idHostAlta
			FROM
				tmp_artcat
					INNER JOIN tmp_familias ON tmp_familias.descripcio = tmp_artcat.familia
					INNER JOIN tmp_subfam ON tmp_subfam.descripcio = tmp_artcat.subfam
					INNER JOIN tmp_marcas ON tmp_marcas.descripcio = tmp_artcat.marca
			WHERE
				tmp_artcat.idArticulo = 0;
                
    SET @idCodiArt = (
		SELECT
			CASE WHEN max(idCodArt) IS NULL
				THEN 0 ELSE max(idCodArt) + 1 END
		FROM codiart);
    INSERT INTO codiart
		SELECT
				@idCodiArt := @idCodiArt + 1 AS idCodArt,
				articulos.idArticulo,
				articulos.codArt,
				articulos.codArt AS codigo,
				'CP' as tipo,
				1 as cantiDesp,
				0 as procesado,
				'CV' as circuito
			FROM
				articulos
			WHERE
				articulos.idArticulo NOT IN (
					SELECT
						idArticulo
					FROM
						codiart);
    
	DROP TABLE IF EXISTS tmp_familias;
	DROP TABLE IF EXISTS tmp_subfam;
	DROP TABLE IF EXISTS tmp_marcas;
	DROP TABLE IF EXISTS tmp_artcat;					
	COMMIT;
	SELECT 'OK' AS 'result';
END