CREATE PROCEDURE rcn_generar_stock (
	xid_ficha int,
	xusuario varchar(5),
	xhost varchar(50))
BEGIN

	/* Verifico si el stock está habilitado*/
	SELECT
		cfg_value
	INTO
		@habilitar_stock
	FROM
		global_cfg gc
	WHERE
		gc.cfg_key = 'STK_MODULE';
	
	IF @habilitar_stock = 'true' THEN
		/* Levanto los datos que necesito de tipos de movimientos */
		SELECT
			codMov,
			signo
		INTO
			@codMov,
			@signo
		FROM
			stk_tipomov stm
		WHERE
			stm.codMov = 'SAL';
		
		/* Pongo el circuto R en referencia al módulo de reconstrucciones */
		SET @circuito = 'R';
		
		SELECT
			idCliente
		INTO
			@idCliente
		FROM
			rcn_ficha
				INNER JOIN rcn_remito ON rcn_remito.id_rtoent = rcn_ficha.id_rtoent
		WHERE
			rcn_ficha.id_ficha = xid_ficha;
			
		/* Armo la cabecera */
		SELECT
			CASE WHEN MAX(idStkCab) IS NULL THEN 1 ELSE MAX(idStkCab) + 1 END
		INTO
			@proximo_idStkCab
		FROM
			stk_cab;
			
		/* Verifico si la cabecera para esta ficha ya existe. Solo
			Genero la cabecera en caso de que no exista */
		SELECT
		  idStkCab
		INTO
		  @idStkCab
		FROM
		  stk_cab
		WHERE
		  stk_cab.id_ficha = xid_ficha;

		IF @idStkCab IS NULL THEN
			
			INSERT INTO stk_cab (
				idStkCab, circuito, numCbte, idCliente, 
				usuAlta, fecAlta, idHostAlta, id_ficha)
			VALUES (
				@proximo_idStkCab, @circuito, CONCAT('Ficha Nro: ', xid_ficha), @idCliente, 
				xusuario, current_timestamp, xhost, xid_ficha);
		END IF;
			
		/* Cargo el detalle de stock */
		
		SET @proximo_idStkDet = 0;
		
		/* Elimino los movimientos de stock asociados a la ficha y
			cargo los movimentos con las modificaciones */
			
		
		DELETE
		FROM
			stk_det
		WHERE
			stk_det.idStkCab = @idStkCab;
		
		/* Inserto los movimientos de salida de stock */
		INSERT INTO stk_det (
			idStkDet, idStkCab, idArticulo, idStkDep,
			tipoMov, cantidad, costoRep, nroPart)
				SELECT
					@proximo_idStkDet := @proximo_idStkDet + 1 AS idStkDet,
					CASE WHEN @idStkCab IS NULL THEN @proximo_idStkCab ELSE @idStkCab END idStkCab,
					raf.idArticulo,
					ad.idStkDep,
					@codMov,
					raf.cantidad * @signo,
					a.costoRep * @signo,
					'' AS nroPart
				FROM 
					rcn_aux_fichadet raf
						INNER JOIN articulos a ON a.idArticulo = raf.idArticulo
						INNER JOIN art_dep ad ON a.idArticulo = ad.idArticulo
				WHERE
					raf.host = xhost;
	END IF;
END