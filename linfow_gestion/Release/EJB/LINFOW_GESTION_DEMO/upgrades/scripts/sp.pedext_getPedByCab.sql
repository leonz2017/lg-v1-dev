CREATE PROCEDURE `pedext_getPedByCab`(pIdPedCab int)
BEGIN
	SELECT pedext.idPedExt,
		pedext.idArticulo,
		pedext.codArt,
        MAX(pedext.cantidad) AS cantidad
	FROM pedext
    WHERE pedext.procesado = 0
		and pedext.idPedCab = pIdPedCab
    GROUP BY
        pedext.idArticulo;
END