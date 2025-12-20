CREATE PROCEDURE `artcat_CrearTemps`(
	pIdProv INT
)
BEGIN
	DROP TABLE IF EXISTS tmp_artcat;
	CREATE TEMPORARY TABLE tmp_artcat (
		codArt VARCHAR(20) NOT NULL,
		descripcio VARCHAR(60) NOT NULL,
		familia VARCHAR(60) NOT NULL,
		subfam VARCHAR(60) NOT NULL,
		marca VARCHAR(60) NOT NULL,
		prLista DOUBLE NOT NULL DEFAULT 0,
		bonif1 DOUBLE NOT NULL DEFAULT 0,
		bonif2 DOUBLE NOT NULL DEFAULT 0,
		bonif3 DOUBLE NOT NULL DEFAULT 0,
		bonif4 DOUBLE NOT NULL DEFAULT 0,
		costoRep DOUBLE NOT NULL DEFAULT 0,
		margenMay DOUBLE NOT NULL DEFAULT 0,
		margenMin DOUBLE NOT NULL DEFAULT 0,
		prVentaMay DOUBLE NOT NULL DEFAULT 0,
		prVentaMin DOUBLE NOT NULL DEFAULT 0,
		prFinalMay DOUBLE NOT NULL DEFAULT 0,
		prFinalMin DOUBLE NOT NULL DEFAULT 0,
		alicIVA DOUBLE NOT NULL DEFAULT 0,
		costoAnt DOUBLE NOT NULL DEFAULT 0,
		idArticulo INT NULL NOT NULL,
		hostName VARCHAR(50) NOT NULL,
		PRIMARY KEY (codArt)) ENGINE=MyISAM;
		CREATE INDEX idxtmp_id ON tmp_artcat (idArticulo);
	
	-- Actualizo codArt de la temporal para poder cruzar con codArtPV.
	-- debido a la duplicación.
	-- La duplicación ocurre cuando el codArt no coincide con el codArtPV.
	UPDATE
		articulos
	SET
		articulos.codArtPV = articulos.codArt
	WHERE
		articulos.idProv = pIdProv AND
		(articulos.codArtPV = '' OR articulos.codArtPV IS NULL) AND
		articulos.fecBaja IS NULL;
		
	DROP TABLE IF EXISTS tmp_artic;
	CREATE TEMPORARY TABLE tmp_artic
		SELECT
			idArticulo,
			codArtPV AS codArt,
			bonif1,
			bonif2,
			bonif3,
			bonif4,
			margenMax,
			margenMin,
			costoRep,
			alicIVA
		FROM
			articulos
		WHERE
			articulos.idProv = pIdProv AND
			articulos.fecBaja IS NULL;
END