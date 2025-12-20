CREATE PROCEDURE `articulos_insert`(
	p_idprov int, 
	p_idfamilia int, 
	p_idsubfam int, 
	p_idmarca int, 
	p_codart varchar(20), 
	p_descripcio varchar(200), 
	p_aliciva  DECIMAL(10, 2), 
	p_tmon varchar(3), 
	p_prlistaext  DECIMAL(10, 2), 
	p_cotizac  DECIMAL(10, 2), 
	p_prlista  DECIMAL(10, 2), 
	p_bonif1  DECIMAL(10, 2), 
	p_bonif2  DECIMAL(10, 2), 
	p_bonif3  DECIMAL(10, 2), 
	p_bonif4  DECIMAL(10, 2), 
	p_costorep  DECIMAL(10, 2), 
	p_margenmax  DECIMAL(10, 2), 
	p_margenmin  DECIMAL(10, 2), 
	p_prventamax  DECIMAL(10, 2), 
	p_prventamin  DECIMAL(10, 2), 
	p_prfinalmax  DECIMAL(10, 2), 
	p_prfinalmin  DECIMAL(10, 2), 
	p_observ text, 
	p_habilitado bit,
	p_linkfoto varchar(100), 
	p_usualta varchar(5), 
	p_idhostalta varchar(50),
	p_esserv bit, 
	p_idunimed int, 
	p_codartpv varchar(45), 
	p_mostrador bit)
BEGIN
	/**
	Permite dar de alta un artículo en el sistema.
	Desarrollado por: LINFOW
	*/

	DECLARE v_idarticulo int;

	-- Calculo el próximo ID de artículo
	SET v_idarticulo = (
		SELECT CASE
			WHEN MAX(idarticulo) IS NULL THEN 1
            ELSE MAX(idarticulo) + 1 END
		FROM articulos);

	-- Inserto el artículo
    INSERT INTO articulos (
		idarticulo, 
		idprov, 
		idfamilia, 
		idsubfam, 
		idmarca, 
		codart, 
		descripcio,
		aliciva, 
		tmon, 
		prlistaext, 
		cotizac, 
		prlista, 
		bonif1, 
		bonif2, 
		bonif3,
		bonif4, 
		costorep, 
		margenmax, 
		margenmin, 
		prventamax, 
		prventamin, 
		prfinalmax,
		prfinalmin, 
		observ, 
		habilitado, 
		linkfoto, 
		usualta, 
		fecalta, 
		idhostalta,
		esserv, 
		idunimed, 
		codartpv, 
		mostrador, 
		equiv)
	VALUES (
		v_idarticulo, 
		p_idprov,  
		p_idfamilia, 
		p_idsubfam, 
		p_idmarca, 
		p_codart, 
		p_descripcio,
		p_aliciva, 
		p_tmon, 
		p_prlistaext, 
		p_cotizac, 
		p_prlista, 
		p_bonif1, 
		p_bonif2, 
		p_bonif3,
		p_bonif4, 
		p_costorep, 
		p_margenmax, 
		p_margenmin, 
		p_prventamax, 
		p_prventamin, 
		p_prfinalmax,
		p_prfinalmin, 
		p_observ, 
		p_habilitado, 
		p_linkfoto, 
		p_usualta, 
		current_timestamp, 
		p_idhostalta,
		p_esserv, 
		p_idunimed, 
		p_codartpv, 
		p_mostrador, 
		v_idarticulo);

	-- Genero el registro asociado en codiart
    CALL codiart_insert (v_idarticulo, p_codart, p_codart, 'CP', 1, 'CV');

	-- Asigno el artículo al depósito predeterminado
    INSERT INTO art_dep (
		idarticulo, 
		idstkdep, 
		usualta, 
		fecalta, 
		idhostalta)
	VALUES (
		v_idarticulo, 
		1, 
		p_usualta, 
		current_timestamp, 
		p_idhostalta);

    SELECT v_idarticulo AS result;
END