CREATE PROCEDURE pedext_insert (
	_idPedCab int,
    _idCliente int,
    _tipoSist int,
    _idArticulo int,
    _fecEmis datetime,
    _codArt varchar(20),
    _cantidad double,
    _observ text)
BEGIN
	DECLARE vCantArtDuplicado int;
    IF _idArticulo <> 0 THEN
		SELECT
			COUNT(*)
		INTO
			vCantArtDuplicado
		FROM
			pedext
		WHERE
			idPedCab = _idPedCab AND
			idCliente = _idCliente AND
			idArticulo = _idArticulo;		
		
		IF vCantArtDuplicado = 0 THEN
			INSERT INTO pedext (
				idPedCab, idCliente, tipoSist, idArticulo,
				fecEmis, codArt, cantidad, observ, procesado)
			VALUES (
				_idPedCab, _idCliente, _tipoSist, _idArticulo,
				_fecEmis, _codArt, _cantidad, _observ, 0);
		END IF;
    END IF;
END