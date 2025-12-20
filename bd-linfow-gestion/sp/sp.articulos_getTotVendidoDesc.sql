CREATE PROCEDURE `articulos_getTotVendidoDesc`(
	p_idarticulo VARCHAR(50),
	p_fecha_inicio DATE,
    p_fecha_fin DATE
)
BEGIN
    SELECT
	art.codArt as 'codigo',
	cli.razSoc AS 'cliente',
	vc.fecEmision AS 'fecemis',
	CONCAT(vc.cbte, ' ', vc.tipoDoc, ' ', REPEAT('0', 4 - LENGTH(vc.ptoVta)), vc.ptoVta, '-', REPEAT('0', 8 - LENGTH(vc.numCbte)), vc.numCbte) AS 'cbte',
	art.descripcio AS 'descripcion',
	CASE
	 WHEN vc.cbte = 'NC' THEN -vd.cantidad
	 ELSE vd.cantidad
	END AS 'cantidad',
	CASE
	 WHEN vc.cbte = 'NC' THEN -(vd.cantidad * vd.prVenta)
	 ELSE (vd.cantidad * vd.prVenta)
	END AS 'importe'
	
	FROM ventascab vc
	JOIN ventasdet vd   ON vc.idventasC = vd.idventasC
	JOIN articulos art  ON art.idArticulo = vd.idArticulo
	JOIN clientes cli	  ON cli.idcliente = vc.idcliente
	
	WHERE vc.cbte IN ('FC','NC')
	  AND (p_idArticulo = 0 OR art.idArticulo = p_idArticulo)
	  AND vc.fecEmision BETWEEN p_fecha_inicio AND p_fecha_fin
	  AND vc.fecBaja IS NULL
	ORDER BY
	  cantidad DESC;
END