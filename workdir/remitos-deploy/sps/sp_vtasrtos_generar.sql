DELIMITER $$
DROP PROCEDURE IF EXISTS vtasrtos_generar $$

CREATE PROCEDURE IF NOT EXISTS vtasrtos_generar(
	xidVentasC int,
	xidTransp int,
	xidNum int,
	xfecha datetime,
	xusuario varchar(5),
	xhost varchar(50)
)
BEGIN
	DECLARE vProxID int;
	DECLARE vCodTrans int;
	DECLARE vrazSocTrn varchar(60);
	DECLARE vnrocomp varchar(20);
	DECLARE vcantItems int;
	DECLARE vnumCbte int;
	DECLARE vCbte varchar(3);
	DECLARE vTipoDoc varchar(1);
	DECLARE vPtoVta int;
	
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		GET DIAGNOSTICS CONDITION 1 @mensaje = MESSAGE_TEXT;
		SELECT @mensaje AS 'result';
	END;
	
	/* Recupero los datos del transporte */
	SELECT
		codTrans, razSoc
	INTO
		vCodTrans, vrazSocTrn
	FROM
		transp
	WHERE
		transp.idTransp = xidTransp;
		
	/* Obtengo la cantidad de items que tiene el remito */
	SELECT
		COUNT(*)
	INTO
		vcantItems
	FROM
		ventasdet
	WHERE
		ventasdet.idVentasC = xidVentasC;
		
	/* 
		Obtengo el proximo id de remito por comprobante seleccionado.
		Tener en cuenta que empiza de 1 por cbte porque es clave primaria compuesta.
	*/
	SELECT
		CASE WHEN MAX(vtasrtos.idVtaRto) IS NULL THEN 1 ELSE MAX(vtasrtos.idVtaRto) + 1 END
	INTO
		vProxID
	FROM
		vtasrtos
	WHERE
		vtasrtos.idVentasC = xidVentasC;
		
	/* Calculo el proximo numero de remito */
	SELECT
		numerador.cbte,
		numerador.tipoDoc,
		numerador.ptoVta,
		numerador.numActual + 1
	INTO
		vCbte,
		vTipoDoc,
		vPtoVta,
		vnumCbte
	FROM
		numerador
	WHERE
		numerador.idNum = xidNum;
		
	SET vnrocomp = CONCAT(
		vCbte, ' ', 
		vTipoDoc, ' ', 
		REPEAT('0', 5 - LENGTH(vPtoVta)), vPtoVta, '-', 
		REPEAT('0', 8 - LENGTH(vnumCbte)), vnumCbte);
	
	START TRANSACTION;
		/* Grabo el registro del remito */
	
		INSERT INTO vtasrtos (
			idVtaRto, idVentasC, idTransp, codTrans, razSocTrn, fecha, cbte, tipoDoc, ptoVta,
			numCbte, nrocomp, cantItems, usuAlta, fecAlta, idHostAlta)
		VALUES (
			vProxID, xidVentasC, xidTransp, vCodTrans, vrazSocTrn, xfecha, vCbte, vTipoDoc, vPtoVta,
			vnumCbte, vnrocomp, vcantItems, xusuario, current_timestamp, xhost
		);
		
		/* Actualizo el numero de remito */
		UPDATE
			numerador
		SET
			numerador.numActual = vnumCbte
		WHERE
			numerador.idNum = xidNum;
	COMMIT;
	
	SET @mensaje = 'OK';
	SELECT @mensaje AS 'result', vnrocomp as 'nro_rto';
END
$$