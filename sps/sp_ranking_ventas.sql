DELIMITER $$

DROP PROCEDURE IF EXISTS ranking_ventas $$

CREATE PROCEDURE IF NOT EXISTS ranking_ventas (
    IN p_tipo_ranking VARCHAR(20),  -- 'clientes', 'proveedores', 'marcas', 'subfamilias', 'articulos'
    IN p_detalle_mes INT,           -- 1 = Con detalle por mes, 0 = Sin detalle
    IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE,
	IN p_importe_con_iva INT		-- 1 = Tomar el importe con IVA incluído, 0 = Tomar el importe neto sin IVA
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT 'Procedimiento genérico para rankings de ventas'
BEGIN
	DECLARE vIdClienteCF INT;
	
	SELECT
		CAST(global_cfg.cfg_value AS INT)
	INTO
		vIdClienteCF
	FROM
		global_cfg
	WHERE
		global_cfg.cfg_key = 'CLI_CF';
	
    -- ============================================================
    -- RANKING DE CLIENTES
    -- ============================================================
    IF p_tipo_ranking = 'clientes' THEN
        
        IF p_detalle_mes = 1 THEN
            -- Con detalle mensual
            SELECT 
                clientes.idCliente AS codigo,
                YEAR(ventascab.fecEmision) AS anio,
                MONTH(ventascab.fecEmision) AS mes,
                MAX(clientes.razSoc) AS descripcio,
				CASE
					WHEN p_importe_con_iva = 0 THEN
						ROUND(SUM(CASE WHEN ventascab.cbte = 'NC' THEN ventasdet.totNeto * -1 ELSE ventasdet.totNeto END), 2)
					WHEN p_importe_con_iva = 1 THEN
						ROUND(SUM(CASE WHEN ventascab.cbte = 'NC' THEN ventasdet.subTotal * -1 ELSE ventasdet.subTotal END), 2) 
				END 'importe'
            FROM ventascab
                INNER JOIN ventasdet ON ventasdet.idVentasC = ventascab.idVentasC
                INNER JOIN clientes ON ventascab.idCliente = clientes.idCliente
            WHERE ventascab.cbte NOT IN ('PED', 'COT', 'ND')
                AND ventascab.fecEmision BETWEEN p_fecha_inicio AND p_fecha_fin
				AND ventascab.idCliente != vIdClienteCF
            GROUP BY 
                clientes.idCliente,
                YEAR(ventascab.fecEmision),
                MONTH(ventascab.fecEmision)
            ORDER BY 
                clientes.idCliente,
                YEAR(ventascab.fecEmision),
                MONTH(ventascab.fecEmision);
        ELSE
            -- Sin detalle mensual
            SELECT 
                clientes.idCliente AS codigo,
                MAX(clientes.razSoc) AS descripcio,
				CASE
					WHEN p_importe_con_iva = 0 THEN
						ROUND(SUM(CASE WHEN ventascab.cbte = 'NC' THEN ventasdet.totNeto * -1 ELSE ventasdet.totNeto END), 2)
					WHEN p_importe_con_iva = 1 THEN
						ROUND(SUM(CASE WHEN ventascab.cbte = 'NC' THEN ventasdet.subTotal * -1 ELSE ventasdet.subTotal END), 2)
				END 'importe'
            FROM ventascab
                INNER JOIN ventasdet ON ventasdet.idVentasC = ventascab.idVentasC
                INNER JOIN clientes ON ventascab.idCliente = clientes.idCliente
            WHERE ventascab.cbte NOT IN ('PED', 'COT', 'ND')
                AND ventascab.fecEmision BETWEEN p_fecha_inicio AND p_fecha_fin
				AND ventascab.idCliente != vIdClienteCF
            GROUP BY clientes.idCliente
            ORDER BY importe DESC;
        END IF;
    
    -- ============================================================
    -- RANKING DE PROVEEDORES
    -- ============================================================
    ELSEIF p_tipo_ranking = 'proveedores' THEN
        
        IF p_detalle_mes = 1 THEN
            -- Con detalle mensual
            SELECT 
                proveedor.idProv AS codigo,
                YEAR(ventascab.fecEmision) AS anio,
                MONTH(ventascab.fecEmision) AS mes,
                MAX(proveedor.razSoc) AS descripcio,
				CASE
					WHEN p_importe_con_iva = 0 THEN
						ROUND(SUM(CASE WHEN ventascab.cbte = 'FC' THEN ventasdet.totNeto ELSE ventasdet.totNeto * -1 END), 2)
					WHEN p_importe_con_iva = 1 THEN
						ROUND(SUM(CASE WHEN ventascab.cbte = 'FC' THEN ventasdet.subTotal ELSE ventasdet.subTotal * -1 END), 2)
				END 'importe'
            FROM ventascab
                INNER JOIN ventasdet ON ventasdet.idVentasC = ventascab.idVentasC
                INNER JOIN articulos ON articulos.idArticulo = ventasdet.idArticulo
                INNER JOIN proveedor ON proveedor.idProv = articulos.idProv
            WHERE ventascab.cbte NOT IN ('PED', 'COT')
                AND ventascab.fecEmision BETWEEN p_fecha_inicio AND p_fecha_fin
            GROUP BY 
                proveedor.idProv,
                YEAR(ventascab.fecEmision),
                MONTH(ventascab.fecEmision)
            ORDER BY 
                proveedor.idProv,
                YEAR(ventascab.fecEmision),
                MONTH(ventascab.fecEmision);
        ELSE
            -- Sin detalle mensual
            SELECT 
                proveedor.idProv AS codigo,
                MAX(proveedor.razSoc) AS descripcio,
				CASE
					WHEN p_importe_con_iva = 0 THEN
						ROUND(SUM(CASE WHEN ventascab.cbte = 'FC' THEN ventasdet.totNeto ELSE ventasdet.totNeto * -1 END), 2)
					WHEN p_importe_con_iva = 1 THEN
						ROUND(SUM(CASE WHEN ventascab.cbte = 'FC' THEN ventasdet.subTotal ELSE ventasdet.subTotal * -1 END), 2)
				END 'importe'
            FROM ventascab
                INNER JOIN ventasdet ON ventasdet.idVentasC = ventascab.idVentasC
                INNER JOIN articulos ON articulos.idArticulo = ventasdet.idArticulo
                INNER JOIN proveedor ON proveedor.idProv = articulos.idProv
            WHERE ventascab.cbte NOT IN ('PED', 'COT')
                AND ventascab.fecEmision BETWEEN p_fecha_inicio AND p_fecha_fin
            GROUP BY proveedor.idProv
            ORDER BY importe DESC;
        END IF;
    
    -- ============================================================
    -- RANKING DE MARCAS
    -- ============================================================
    ELSEIF p_tipo_ranking = 'marcas' THEN
        
        IF p_detalle_mes = 1 THEN
            -- Con detalle mensual
            SELECT 
                marcas.idmarca AS codigo,
                YEAR(ventascab.fecEmision) AS anio,
                MONTH(ventascab.fecEmision) AS mes,
                MAX(marcas.descripcio) AS descripcio,
				CASE
					WHEN p_importe_con_iva = 0 THEN
						ROUND(SUM(CASE WHEN ventascab.cbte = 'FC' THEN ventasdet.totNeto ELSE ventasdet.totNeto * -1 END), 2)
					WHEN p_importe_con_iva = 1 THEN
						ROUND(SUM(CASE WHEN ventascab.cbte = 'FC' THEN ventasdet.subTotal ELSE ventasdet.subTotal * -1 END), 2)
				END 'importe'
            FROM ventascab
                INNER JOIN ventasdet ON ventasdet.idVentasC = ventascab.idVentasC
                INNER JOIN articulos ON articulos.idArticulo = ventasdet.idArticulo
                INNER JOIN marcas ON marcas.idmarca = articulos.idmarca
            WHERE ventascab.cbte NOT IN ('PED', 'COT')
                AND ventascab.fecEmision BETWEEN p_fecha_inicio AND p_fecha_fin
            GROUP BY 
                marcas.idmarca,
                YEAR(ventascab.fecEmision),
                MONTH(ventascab.fecEmision)
            ORDER BY 
                marcas.idmarca,
                YEAR(ventascab.fecEmision),
                MONTH(ventascab.fecEmision);
        ELSE
            -- Sin detalle mensual
            SELECT 
                marcas.idmarca AS codigo,
                MAX(marcas.descripcio) AS descripcio,
				CASE
					WHEN p_importe_con_iva = 0 THEN
						ROUND(SUM(CASE WHEN ventascab.cbte = 'FC' THEN ventasdet.totNeto ELSE ventasdet.totNeto * -1 END), 2)
					WHEN p_importe_con_iva = 1 THEN
						ROUND(SUM(CASE WHEN ventascab.cbte = 'FC' THEN ventasdet.subTotal ELSE ventasdet.subTotal * -1 END), 2)
				END 'importe'
            FROM ventascab
                INNER JOIN ventasdet ON ventasdet.idVentasC = ventascab.idVentasC
                INNER JOIN articulos ON articulos.idArticulo = ventasdet.idArticulo
                INNER JOIN marcas ON marcas.idmarca = articulos.idmarca
            WHERE ventascab.cbte NOT IN ('PED', 'COT')
                AND ventascab.fecEmision BETWEEN p_fecha_inicio AND p_fecha_fin
            GROUP BY marcas.idmarca
            ORDER BY importe DESC;
        END IF;
    
    -- ============================================================
    -- RANKING DE SUBFAMILIAS
    -- ============================================================
    ELSEIF p_tipo_ranking = 'subfamilias' THEN
        
        IF p_detalle_mes = 1 THEN
            -- Con detalle mensual
            SELECT 
                subfam.idSubFam AS codigo,
                YEAR(ventascab.fecEmision) AS anio,
                MONTH(ventascab.fecEmision) AS mes,
                MAX(subfam.descripcio) AS descripcio,
				CASE
					WHEN p_importe_con_iva = 0 THEN
						ROUND(SUM(CASE WHEN ventascab.cbte = 'FC' THEN ventasdet.totNeto ELSE ventasdet.totNeto * -1 END), 2)
					WHEN p_importe_con_iva = 1 THEN
						ROUND(SUM(CASE WHEN ventascab.cbte = 'FC' THEN ventasdet.subTotal ELSE ventasdet.subTotal * -1 END), 2)
				END 'importe'
            FROM ventascab
                INNER JOIN ventasdet ON ventasdet.idVentasC = ventascab.idVentasC
                INNER JOIN articulos ON articulos.idArticulo = ventasdet.idArticulo
                INNER JOIN subfam ON subfam.idSubFam = articulos.idSubFam
            WHERE ventascab.cbte NOT IN ('PED', 'COT')
                AND ventascab.fecEmision BETWEEN p_fecha_inicio AND p_fecha_fin
            GROUP BY 
                subfam.idSubFam,
                YEAR(ventascab.fecEmision),
                MONTH(ventascab.fecEmision)
            ORDER BY 
                subfam.idSubFam,
                YEAR(ventascab.fecEmision),
                MONTH(ventascab.fecEmision);
        ELSE
            -- Sin detalle mensual
            SELECT 
                subfam.idSubFam AS codigo,
                MAX(subfam.descripcio) AS descripcio,
				CASE
					WHEN p_importe_con_iva = 0 THEN
						ROUND(SUM(CASE WHEN ventascab.cbte = 'FC' THEN ventasdet.totNeto ELSE ventasdet.totNeto * -1 END), 2)
					WHEN p_importe_con_iva = 1 THEN
						ROUND(SUM(CASE WHEN ventascab.cbte = 'FC' THEN ventasdet.subTotal ELSE ventasdet.subTotal * -1 END), 2)
				END 'importe'
            FROM ventascab
                INNER JOIN ventasdet ON ventasdet.idVentasC = ventascab.idVentasC
                INNER JOIN articulos ON articulos.idArticulo = ventasdet.idArticulo
                INNER JOIN subfam ON subfam.idSubFam = articulos.idSubFam
            WHERE ventascab.cbte NOT IN ('PED', 'COT')
                AND ventascab.fecEmision BETWEEN p_fecha_inicio AND p_fecha_fin
            GROUP BY subfam.idSubFam
            ORDER BY importe DESC;
        END IF;
    
    -- ============================================================
    -- RANKING DE ARTÍCULOS
    -- ============================================================
    ELSEIF p_tipo_ranking = 'articulos' THEN
        
        IF p_detalle_mes = 1 THEN
            -- Con detalle mensual
            SELECT 
                articulos.idArticulo AS idarticulo,
                articulos.codart AS codart,
                MAX(articulos.descripcio) AS descripcio,
                ROUND(SUM(CASE WHEN ventascab.cbte = 'NC' THEN ventasdet.cantidad * -1 ELSE ventasdet.cantidad END), 2) AS cantidad,
				CASE
					WHEN p_importe_con_iva = 0 THEN
						ROUND(SUM(CASE WHEN ventascab.cbte = 'NC' THEN ventasdet.totNeto * -1 ELSE ventasdet.totNeto END), 2)
					WHEN p_importe_con_iva = 1 THEN
						ROUND(SUM(CASE WHEN ventascab.cbte = 'NC' THEN ventasdet.subTotal * -1 ELSE ventasdet.subTotal END), 2)
				END 'importe',
                YEAR(ventascab.fecEmision) AS anio,
                MONTH(ventascab.fecEmision) AS mes
            FROM ventascab
                INNER JOIN ventasdet ON ventasdet.idVentasC = ventascab.idVentasC
                INNER JOIN articulos ON articulos.idArticulo = ventasdet.idArticulo
            WHERE ventascab.cbte NOT IN ('PED', 'COT', 'ND')
                AND ventascab.fecEmision BETWEEN p_fecha_inicio AND p_fecha_fin
            GROUP BY 
                articulos.idArticulo,
                articulos.codart,
                YEAR(ventascab.fecEmision),
                MONTH(ventascab.fecEmision)
            ORDER BY 
                articulos.idArticulo,
                YEAR(ventascab.fecEmision),
                MONTH(ventascab.fecEmision);
        ELSE
            -- Sin detalle mensual
            SELECT 
                articulos.idArticulo AS idarticulo,
                articulos.codart AS codart,
                MAX(articulos.descripcio) AS descripcio,
                ROUND(SUM(CASE WHEN ventascab.cbte = 'NC' THEN ventasdet.cantidad * -1 ELSE ventasdet.cantidad END), 2) AS cantidad,
				CASE
					WHEN p_importe_con_iva = 0 THEN
						ROUND(SUM(CASE WHEN ventascab.cbte = 'NC' THEN ventasdet.totNeto * -1 ELSE ventasdet.totNeto END), 2)
					WHEN p_importe_con_iva = 1 THEN
						ROUND(SUM(CASE WHEN ventascab.cbte = 'NC' THEN ventasdet.subTotal * -1 ELSE ventasdet.subTotal END), 2)
				END 'importe'
            FROM ventascab
                INNER JOIN ventasdet ON ventasdet.idVentasC = ventascab.idVentasC
                INNER JOIN articulos ON articulos.idArticulo = ventasdet.idArticulo
            WHERE ventascab.cbte NOT IN ('PED', 'COT', 'ND')
                AND ventascab.fecEmision BETWEEN p_fecha_inicio AND p_fecha_fin
            GROUP BY 
                articulos.idArticulo,
                articulos.codart
            ORDER BY cantidad DESC;
        END IF;
    
    END IF;

END$$
