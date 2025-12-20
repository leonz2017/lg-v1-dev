CREATE PROCEDURE `articulos_getTotVendido`(
	p_idarticulo VARCHAR(50),
	p_fecha_inicio DATE,
    p_fecha_fin DATE
)
BEGIN
    SELECT
        IFNULL(SUM(
            CASE 
                WHEN vc.cbte = 'NC' THEN -vd.cantidad
                ELSE vd.cantidad 
            END
        ), 0) AS vtotal,
        IFNULL(SUM(
            CASE 
                WHEN vc.cbte = 'NC' THEN -(vd.cantidad * vd.prVenta)
                ELSE (vd.cantidad * vd.prVenta)
            END
        ), 0) AS importe_total
    FROM ventascab vc
    INNER JOIN ventasdet vd 
        ON vc.idventasC = vd.idventasC
    INNER JOIN articulos art 
        ON art.idArticulo = vd.idArticulo
    WHERE (p_idArticulo = 0 OR art.idArticulo = p_idArticulo)
   	AND vc.cbte IN ('FC','NC') 
    AND vc.fecEmision BETWEEN p_fecha_inicio AND p_fecha_fin
    AND vc.fecBaja is NULL;
END