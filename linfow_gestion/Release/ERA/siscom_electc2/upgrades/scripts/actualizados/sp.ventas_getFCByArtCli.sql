CREATE PROCEDURE ventas_getFCByArtCli (
    xIdArticulo int,
    xFechaDD datetime,
    xFechaHH datetime,
    xIdCliente int
)
BEGIN
	SELECT	
		ventascab.idVentasC,
		ventascab.fecEmision AS fecemis,
		ventascab.idCliente,
		ventascab.razSoc,
		CONCAT(REPEAT('0', 4 - LENGTH(ventascab.ptoVta)), ventascab.ptoVta) AS ptoVta,
		CONCAT(REPEAT('0', 8 - LENGTH(ventascab.numcbte)), ventascab.numcbte) AS numCbte,
		ventascab.totFact,
		ventascab.observ,
		ventascab.nroDoc
	FROM
		ventasdet
			INNER JOIN ventascab ON ventascab.idVentasC = ventasdet.idVentasC
	WHERE
		ventasdet.idArticulo = xIdArticulo AND
		ventascab.cbte = 'FC' AND
		ventascab.fecEmision BETWEEN xFechaDD AND xFechaHH AND
		ventascab.idCliente = xidCliente;
END