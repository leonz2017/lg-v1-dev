CREATE PROCEDURE `ventas_getByTipoPago`(_fechaDesde DATE, _fechaHasta DATE,_tipoPago int)
BEGIN
		SELECT clientes.idcliente, clientes.razSoc, rccob_c.nroRec, rccob_c.fecAlta, rccob_c.usuAlta, rccob_c.idHostAlta, tipospagos.descripcio, rccob_d.importe
	FROM rccob_c
		INNER JOIN rccob_d ON rccob_c.idRCCob_C = rccob_d.idRCCob_C 
		INNER JOIN clientes ON rccob_c.idCliente = clientes.idCliente
		INNER JOIN tipospagos ON rccob_d.tipopago = tipospagos.codTipoPag
	WHERE rccob_c.fecEmis BETWEEN _fechaDesde AND _fechaHasta
			AND (
			_tipoPago = 0 -- TODOS
			OR tipospagos.idTipoPago = _tipoPago
		);
END