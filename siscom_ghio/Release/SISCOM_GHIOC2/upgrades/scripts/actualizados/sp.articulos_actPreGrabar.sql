CREATE PROCEDURE `articulos_actPreGrabar`(
	pUsuModi varchar(5),
	pIdHostModi varchar(50)
)
BEGIN
	DECLARE vIdArticulo INT;
	DECLARE vCostoAnt DOUBLE;
	DECLARE vCostoNuevo DOUBLE;
	DECLARE vFin INT;
	DECLARE cur_art CURSOR FOR
		SELECT
			articulos.idArticulo,
			articulos.costoRep AS costoAnt,
			tmp_artic.costoRep AS costoNuevo
		FROM
			articulos
				INNER JOIN tmp_artic
					ON tmp_artic.idArticulo = articulos.idArticulo
		GROUP BY
			articulos.idArticulo;	
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET vFin = 1;
	DECLARE EXIT handler FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		SELECT 'Error en articulos_actPreGrabar' AS result;
	END;
			
	START TRANSACTION;
	
	OPEN cur_art;
	get_articulo: LOOP
		FETCH cur_art INTO vIdArticulo, vCostoAnt, vCostoNuevo;
		IF vFin = 1 THEN
			LEAVE get_articulo;
		END IF;
		CALL art_cbios_insert (vIdArticulo, vCostoAnt, vCostoNuevo);
	END LOOP get_articulo;
	CLOSE cur_art;
	
	UPDATE
		articulos a
			INNER JOIN tmp_artic b
				ON b.idArticulo = a.idArticulo
	SET
		a.prListaExt = b.prListaExt,
		a.cotizac = b.cotizac,
		a.prLista = b.prLista,
		a.bonif1 = b.bonif1,
		a.bonif2 = b.bonif2,
		a.bonif3 = b.bonif3,
		a.bonif4 = b.bonif4,
		a.costoRep = b.costoRep,
		a.margenMax = b.margenMax,
		a.margenMin = b.margenMin,
		a.prventaMax = b.prventaMax,
		a.prventaMin = b.prventaMin,
		a.prfinalMax = b.prfinalMax,
		a.prfinalMin = b.prfinalMin,
        a.fecActuPre = CURRENT_TIMESTAMP,
		a.usumodi = pUsuModi,
		a.fecmodi = CURRENT_TIMESTAMP,
		a.idhostmodi = pIdHostModi;

	COMMIT;
	SELECT 'OK' AS result;
END