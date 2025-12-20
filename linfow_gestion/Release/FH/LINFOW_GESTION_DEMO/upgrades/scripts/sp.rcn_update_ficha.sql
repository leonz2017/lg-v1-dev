CREATE PROCEDURE rcn_update_ficha (
	 xidFicha int,
	 xid_motrec int,
	 xidmarca int,
	 xmedida decimal(20, 2),
	 xnro_serie varchar(20),
	 xtrabajo varchar(100),
	 xid_estado int,
	 xcamsecgdo decimal(20, 2),
	 xmatricula varchar(100),
	 xreferencia int,
	 xvulcaniza bit,
	 xaprobado bit,
	 xaprob_sg bit,
	 xrechazado bit,
	 xradio decimal(20, 2),
	 xperimetro decimal(20, 2),
	 xancho decimal(20, 2),
	 xobserv text,
	 xparch_ant bit,
	 xid_estcra int,
	 xidop_recep int,
	 xidop_exapr int,
	 xidop_rasp int,
	 xidop_esca int,
	 xidop_appar int,
	 xusuario varchar(5),
	 xidHost varchar(50),
	 xidVentasC int
)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		GET DIAGNOSTICS CONDITION 1
			@mensaje = MESSAGE_TEXT;
		SELECT 0 AS 'result', @mensaje AS 'mensaje';
	END;
	
	START TRANSACTION;
	
	UPDATE
		rcn_ficha
	SET
		rcn_ficha.id_motrec = CASE WHEN xid_motrec = 0 THEN NULL ELSE xid_motrec END,
		rcn_ficha.idmarca = xidmarca,
		rcn_ficha.medida = xmedida,
		rcn_ficha.nro_serie = xnro_serie,
		rcn_ficha.trabajo = xtrabajo,
		rcn_ficha.id_estado = CASE WHEN xid_estado = 0 THEN rcn_ficha.id_estado ELSE xid_estado END,
		rcn_ficha.id_estcra = CASE WHEN xid_estcra = 0 THEN rcn_ficha.id_estcra ELSE xid_estcra END,
		rcn_ficha.camsecgdo = xcamsecgdo,
		rcn_ficha.matricula = xmatricula,
		rcn_ficha.referencia = xreferencia,
		rcn_ficha.vulcaniza = xvulcaniza,
		rcn_ficha.aprobado = xaprobado,
		rcn_ficha.aprob_sg = xaprob_sg,
		rcn_ficha.rechazado = xrechazado,
		rcn_ficha.radio = xradio,
		rcn_ficha.perimetro = xperimetro,
		rcn_ficha.ancho = xancho,
		rcn_ficha.observ = xobserv,
		rcn_ficha.parch_ant = xparch_ant,
		rcn_ficha.idop_recep = CASE WHEN xidop_recep = 0 THEN NULL ELSE xidop_recep END,
		rcn_ficha.idop_exapr = CASE WHEN xidop_exapr = 0 THEN NULL ELSE xidop_exapr END,
		rcn_ficha.idop_rasp = CASE WHEN xidop_rasp = 0 THEN NULL ELSE xidop_rasp END,
		rcn_ficha.idop_esca = CASE WHEN xidop_esca = 0 THEN NULL ELSE xidop_esca END,
		rcn_ficha.idop_appar = CASE WHEN xidop_appar = 0 THEN NULL ELSE xidop_appar END,
		rcn_ficha.usuModi = xusuario,
		rcn_ficha.fecModi = current_timestamp,
		rcn_ficha.idHostModi = xidHost,
		rcn_ficha.idVentasC = CASE WHEN xidVentasC = 0 THEN NULL ELSE xidVentasC END
	WHERE
		rcn_ficha.id_ficha = xidFicha;
		
	/* 
		Guardo el detalle de la ficha a partir de la tabla auxiliar.
		Limpio la tabla para que no se dupliquen registros y guarde todos
		los cambios y luego grabo todos los registros.
	*/
	DELETE
	FROM
		rcn_fichadet
	WHERE
		rcn_fichadet.id_ficha = xidFicha;
	
	INSERT INTO rcn_fichadet (
		id_fichadet, id_ficha, cantidad, idArticulo,
		codArt, descripcio, usuAlta, fecAlta, idHostAlta)
			SELECT
				id, id_ficha, cantidad, idArticulo,
				codArt, descripcio, usuario, current_timestamp, host
			FROM
				rcn_aux_fichadet fd
			WHERE
				fd.usuario = xusuario AND
				fd.host = xidHost AND
				fd.id_ficha = xidFicha;
	
	/* Hago el movimiento de stock*/
	CALL rcn_generar_stock (xidFicha, xusuario, xidHost);
	
	COMMIT;
	DELETE FROM rcn_aux_fichadet WHERE host = xidHost;
	SELECT 1 AS 'result', 'Los cambios fueron grabados satsifactoriamente' AS 'mensaje';
END