CREATE PROCEDURE `articulos_getTotVendido`(
	p_idarticulo VARCHAR(50),
	p_fecha_inicio DATE,
    p_fecha_fin DATE
)
BEGIN
    SELECT 
        SUM(
            CASE 
                WHEN vc.cbte = 'NC' THEN -vd.cantidad
                ELSE vd.cantidad 
            END
        ) AS vtotal
    FROM ventascab vc
    INNER JOIN ventasdet vd 
        ON vc.idventasC = vd.idventasC
    INNER JOIN articulos art 
        ON art.idArticulo = vd.idArticulo
    WHERE art.idArticulo = p_idArticulo
   	AND vc.cbte IN ('FC','NC') 
      AND vc.fecEmision BETWEEN p_fecha_inicio AND p_fecha_fin;
END