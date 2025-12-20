CREATE PROCEDURE `ranking_Articulos`(
	p_SeparoPorMes INT,
	p_fechaInicio DATE,
	p_fechaFin DATE
)
BEGIN
    IF p_SeparoPorMes = 1 THEN
        -- Consulta con separación por mes
        SELECT  
            articulos.idArticulo AS idarticulo,
            articulos.codart AS codart,
            MAX(articulos.descripcio) AS descripcio,
            ROUND(SUM(CASE WHEN ventascab.cbte = 'NC' THEN ventasdet.cantidad * -1 ELSE ventasdet.cantidad END), 2) AS cantidad,
            ROUND(SUM(CASE WHEN ventascab.cbte = 'NC' THEN ventasdet.totNeto * -1 ELSE ventasdet.totNeto END), 2) AS importe,
            YEAR(ventascab.fecEmision) AS anio,
            MONTH(ventascab.fecEmision) AS mes
        FROM ventascab   
            INNER JOIN ventasdet ON ventasdet.idVentasC = ventascab.idVentasC     
            INNER JOIN articulos ON articulos.idArticulo = ventasdet.idArticulo 
        WHERE ventascab.cbte NOT IN ('PED', 'COT', 'ND')
            AND ventascab.fecEmision BETWEEN p_fechaInicio AND p_fechaFin
        GROUP BY articulos.idArticulo, articulos.codart, YEAR(ventascab.fecEmision), MONTH(ventascab.fecEmision)
        ORDER BY articulos.idarticulo, YEAR(ventascab.fecEmision), MONTH(ventascab.fecEmision);
    ELSE
        -- Consulta sin separación mensual
        SELECT  
            articulos.idArticulo AS idarticulo,
            articulos.codart AS codart,
            MAX(articulos.descripcio) AS descripcio,
            ROUND(SUM(CASE WHEN ventascab.cbte = 'NC' THEN ventasdet.cantidad * -1 ELSE ventasdet.cantidad END), 2) AS cantidad,
            ROUND(SUM(CASE WHEN ventascab.cbte = 'NC' THEN ventasdet.totNeto * -1 ELSE ventasdet.totNeto END), 2) AS importe
        FROM ventascab   
            INNER JOIN ventasdet ON ventasdet.idVentasC = ventascab.idVentasC     
            INNER JOIN articulos ON articulos.idArticulo = ventasdet.idArticulo
        WHERE ventascab.cbte NOT IN ('PED', 'COT', 'ND')
            AND ventascab.fecEmision BETWEEN p_fechaInicio AND p_fechaFin
        GROUP BY articulos.idArticulo, articulos.codart
        ORDER BY cantidad DESC;
    END IF;
END
