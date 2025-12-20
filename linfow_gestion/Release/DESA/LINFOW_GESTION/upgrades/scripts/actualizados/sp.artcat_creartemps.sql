CREATE PROCEDURE `artcat_CrearTemps`(
	pIdProv INT,
    pPermitirDuplicado bit
)
BEGIN
	DROP TABLE IF EXISTS tmp_artcat;
    IF pPermitirDuplicado THEN
		CREATE TEMPORARY TABLE tmp_artcat (
			codArt VARCHAR(25) NOT NULL,
			descripcio VARCHAR(200) NOT NULL,
			familia VARCHAR(60) NOT NULL,
			subfam VARCHAR(60) NOT NULL,
			marca VARCHAR(60) NOT NULL,
			prLista DECIMAL(20,2) NOT NULL DEFAULT 0,
			bonif1 DECIMAL(20,2) NOT NULL DEFAULT 0,
			bonif2 DECIMAL(20,2) NOT NULL DEFAULT 0,
			bonif3 DECIMAL(20,2) NOT NULL DEFAULT 0,
			bonif4 DECIMAL(20,2) NOT NULL DEFAULT 0,
			costoRep DECIMAL(20,2) NOT NULL DEFAULT 0,
			margenMay DECIMAL(20,2) NOT NULL DEFAULT 0,
			margenMin DECIMAL(20,2) NOT NULL DEFAULT 0,
			prVentaMay DECIMAL(20,2) NOT NULL DEFAULT 0,
			prVentaMin DECIMAL(20,2) NOT NULL DEFAULT 0,
			prFinalMay DECIMAL(20,2) NOT NULL DEFAULT 0,
			prFinalMin DECIMAL(20,2) NOT NULL DEFAULT 0,
			alicIVA DECIMAL(20,2) NOT NULL DEFAULT 0,
			costoAnt DECIMAL(20,2) NOT NULL DEFAULT 0,
			idArticulo INT NULL NOT NULL,
			linkFoto varchar(255),
			hostName VARCHAR(50) NOT NULL) ENGINE=MyISAM;
	ELSE
		CREATE TEMPORARY TABLE tmp_artcat (
			codArt VARCHAR(25) NOT NULL,
			descripcio VARCHAR(200) NOT NULL,
			familia VARCHAR(60) NOT NULL,
			subfam VARCHAR(60) NOT NULL,
			marca VARCHAR(60) NOT NULL,
			prLista DECIMAL(20,2) NOT NULL DEFAULT 0,
			bonif1 DECIMAL(20,2) NOT NULL DEFAULT 0,
			bonif2 DECIMAL(20,2) NOT NULL DEFAULT 0,
			bonif3 DECIMAL(20,2) NOT NULL DEFAULT 0,
			bonif4 DECIMAL(20,2) NOT NULL DEFAULT 0,
			costoRep DECIMAL(20,2) NOT NULL DEFAULT 0,
			margenMay DECIMAL(20,2) NOT NULL DEFAULT 0,
			margenMin DECIMAL(20,2) NOT NULL DEFAULT 0,
			prVentaMay DECIMAL(20,2) NOT NULL DEFAULT 0,
			prVentaMin DECIMAL(20,2) NOT NULL DEFAULT 0,
			prFinalMay DECIMAL(20,2) NOT NULL DEFAULT 0,
			prFinalMin DECIMAL(20,2) NOT NULL DEFAULT 0,
			alicIVA DECIMAL(20,2) NOT NULL DEFAULT 0,
			costoAnt DECIMAL(20,2) NOT NULL DEFAULT 0,
			idArticulo INT NULL NOT NULL,
			linkFoto varchar(255),
			hostName VARCHAR(50) NOT NULL,
            PRIMARY KEY (codArt)) ENGINE=MyISAM; 
    END IF;
	CREATE INDEX idxtmp_id ON tmp_artcat (idArticulo);
	CREATE INDEX ifxtmp_id ON tmp_artcat (codArt);   
    
	DROP TABLE IF EXISTS tmp_artic;
	CREATE TEMPORARY TABLE tmp_artic
		SELECT
			idArticulo,
			codArtPV,
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