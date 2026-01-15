DELIMITER $$
DROP PROCEDURE IF EXISTS vtasrtos_generar_c2 $$

CREATE PROCEDURE IF NOT EXISTS vtasrtos_generar_c2(
	xidVentasC int,
	xidTransp int,
	xcbte varchar(3),
	xtipoDoc varchar(1),
	xptoVta int,
	xnumCbte int,
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
	
	/* Armo el número completo */
	SET vnrocomp = CONCAT(
		xcbte, ' ', 
		xtipoDoc, ' ', 
		REPEAT('0', 5 - LENGTH(xptoVta)), xptoVta, '-', 
		REPEAT('0', 8 - LENGTH(xnumCbte)), xnumCbte);
	
	/* Grabo el registro del remito */
	INSERT INTO vtasrtos (
		idVtaRto, idVentasC, idTransp, codTrans, razSocTrn, fecha, cbte, tipoDoc, ptoVta,
		numCbte, nrocomp, cantItems, usuAlta, fecAlta, idHostAlta)
	VALUES (
		vProxID, xidVentasC, xidTransp, vCodTrans, vrazSocTrn, xfecha, xcbte, xtipoDoc, xptoVta,
		xnumCbte, vnrocomp, vcantItems, xusuario, current_timestamp, xhost
	);
	
	SET @mensaje = 'OK';
	SELECT @mensaje AS 'result', vnrocomp as 'nro_rto';
END
$$