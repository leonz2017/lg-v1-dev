CREATE PROCEDURE `articulos_update`(
	p_idarticulo int, 
    p_idprov int,  
    p_idfamilia int, 
    p_idsubfam int, 
	p_idmarca int, 	
    p_codart varchar(20),  
    p_descripcio varchar(200), 
    p_aliciva  decimal(10, 2), 
	p_tmon varchar(3), 
    p_prlistaext  decimal(10, 2), 
    p_cotizac  decimal(10, 2), 
    p_prlista  decimal(10, 2), 
	p_bonif1  decimal(10, 2), 
    p_bonif2  decimal(10, 2), 
    p_bonif3  decimal(10, 2), 
    p_bonif4  decimal(10, 2), 
	p_costorep  decimal(10, 2), 
    p_margenmax  decimal(10, 2), 
    p_margenmin  decimal(10, 2), 
    p_prventamax  decimal(10, 2), 
	p_prventamin  decimal(10, 2), 
    p_prfinalmax  decimal(10, 2), 
    p_prfinalmin  decimal(10, 2),
    p_usarImpuIn bit,
    p_porImpuIn decimal(5, 2),
    p_impImInMay decimal(20, 2),
    p_impImInMin decimal(20, 2),
    p_observ text, 
	p_habilitado bit, 
    p_linkfoto varchar(100), 
    p_usumodi varchar(5), 
    p_idhostmodi varchar(50), 
    p_esserv bit, 
    p_idunimed int, 
    p_codartpv varchar(45), 
    p_mostrador bit,
    p_usarMonExt bit,
	p_promocion bit)
BEGIN
	DECLARE vCostoAnt  decimal(10, 2);
    DECLARE vMensaje text;

	DECLARE EXIT handler FOR SQLEXCEPTION
	BEGIN
    	GET DIAGNOSTICS CONDITION 1 vMensaje = MESSAGE_TEXT;
		SELECT '0' AS 'result';
	END;

	SELECT
		articulos.costoRep INTO vCostoAnt
	FROM
		articulos
	WHERE
		articulos.idArticulo = p_idarticulo;

	UPDATE
		articulos
	SET
		articulos.idprov = p_idprov,
		articulos.idfamilia = p_idfamilia,
		articulos.idsubfam = p_idsubfam,
		articulos.idmarca = p_idmarca,
		articulos.codart = p_codart,
		articulos.descripcio = p_descripcio,
		articulos.aliciva = p_aliciva,
		articulos.tmon = p_tmon,
		articulos.prlistaext = p_prlistaext,
		articulos.cotizac = p_cotizac,
		articulos.prlista = p_prlista,
		articulos.bonif1 = p_bonif1,
		articulos.bonif2 = p_bonif2,
		articulos.bonif3 = p_bonif3,
		articulos.bonif4 = p_bonif4,
		articulos.costorep = p_costorep,
		articulos.margenmax = p_margenmax,
		articulos.margenmin = p_margenmin,
		articulos.prventamax = p_prventamax,
		articulos.prventamin = p_prventamin,
		articulos.prfinalMax = p_prfinalmax,
		articulos.prfinalMin = p_prfinalmin,
        articulos.usarImpuIn = p_usarImpuIn,
        articulos.porImpuIn = p_porImpuIn,
        articulos.impImInMay = p_impImInMay,
        articulos.impImInMin = p_impImInMin,
		articulos.observ = p_observ,
		articulos.habilitado = p_habilitado,
		articulos.linkfoto = p_linkfoto,
		articulos.usumodi = p_usumodi,
		articulos.fecmodi = CURRENT_TIMESTAMP,
		articulos.idhostmodi = p_idhostmodi,
		articulos.idunimed = p_idunimed,
		articulos.codartpv = p_codartpv,
		articulos.mostrador = p_mostrador,
        articulos.usarMonExt = p_usarMonExt,
		articulos.promocion = p_promocion
	WHERE
		articulos.idarticulo = p_idarticulo;
	
    -- Doy de alta el historial de precios.
	CALL art_cbios_insert (p_idarticulo, vCostoAnt, p_costorep);	

	SELECT '1' AS 'result';
END
