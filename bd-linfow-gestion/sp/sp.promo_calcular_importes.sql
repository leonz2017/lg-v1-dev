CREATE PROCEDURE promo_calcular_importes()
BEGIN
    DECLARE v_mensaje varchar(255);
	
    DECLARE EXIT handler FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        GET DIAGNOSTICS CONDITION 1 v_mensaje = MESSAGE_TEXT;
        SELECT v_mensaje AS 'result';
    END;

    START TRANSACTION;
    
    DELETE FROM promo_clim;

    ALTER TABLE promo_clim AUTO_INCREMENT = 0;    

    DELETE FROM promo_cli;

    ALTER TABLE promo_cli AUTO_INCREMENT = 0;

    INSERT INTO promo_cli (
        idpromo_c,
        idCliente,
        idVentasC,
        cbte,
        cuenta,
        imp_tope,
        total_vend)
            SELECT
                prc.idpromo_c,
                cab.idCliente,
                cab.idVentasC,
                cab.cbte,
                1 AS cuenta,
                prc.imp_tope,
                sum(det.subTotal) as total_vend
            FROM
                ventasdet det
                    INNER JOIN ventascab cab 
                        ON cab.idVentasC = det.idVentasC
                    INNER JOIN articulos art 
                        ON art.idArticulo = det.idArticulo
                    INNER JOIN promo_marcas prm
                        ON prm.idmarca = art.idmarca
                    INNER JOIN promo_cab prc
                        ON prc.idpromo_c = prm.idpromo_c
            WHERE
                cast(cab.fecEmision AS DATE) between cast(prc.vigencia_d AS DATE) AND cast(prc.vigencia_h AS DATE) AND
                cab.cbte IN ('FC', 'NC') AND
                prc.fecBaja IS NULL
            GROUP BY
                prc.idpromo_c,
                cab.idCliente,
                cab.idVentasC,
                cab.cbte;       
    
    INSERT INTO promo_cli (
        idpromo_c,
        idCliente,
        idVentasC,
        cbte,
        cuenta,
        imp_tope,
        total_vend)
            SELECT
                prc.idpromo_c,
                cab.idCliente,
                cab.idVentasC,
                cab.cbte,            
                2 AS cuenta,
                prc.imp_tope,
                round(sum(det.subTotal), 2) as total_vend
            FROM
                linfowgst_mgc2.ventasdet det
                    INNER JOIN linfowgst_mgc2.ventascab cab
                        ON cab.idVentasC = det.idVentasC
                    INNER JOIN articulos art 
                        ON art.idArticulo = det.idArticulo
                    INNER JOIN promo_marcas prm
                        ON prm.idmarca = art.idmarca
                    INNER JOIN promo_cab prc
                        ON prc.idpromo_c = prm.idpromo_c
            WHERE
                cast(cab.fecEmision AS DATE) between cast(prc.vigencia_d AS DATE) AND cast(prc.vigencia_h AS DATE) AND
                cab.cbte IN ('FC', 'NC') AND
                prc.fecBaja IS NULL
            GROUP BY
                prc.idpromo_c,
                cab.idCliente,
                cab.idVentasC,
                cab.cbte;
    
    UPDATE
        promo_cli
    SET
        total_vend = total_vend * -1
    WHERE
        cbte = 'NC' AND
        total_vend > 0;
    
    DROP TABLE IF EXISTS tmp_promo_cli_merch;

    CREATE TEMPORARY TABLE tmp_promo_cli_merch
        SELECT
            promo_cli.idpromo_c,
            promo_cli.id AS idpromo_cli,
            promo_cab.nombre,
            promo_cli.idCliente,
            clientes.razSoc,
            promo_cli.imp_tope,
            sum(promo_cli.total_vend) as total_vend,
            promo_cli.imp_tope - sum(promo_cli.total_vend) as faltan
        FROM
            promo_cli
                INNER JOIN clientes 
                    ON clientes.idCliente = promo_cli.idCliente
                INNER JOIN promo_cab
                    ON promo_cab.idpromo_c = promo_cli.idpromo_c
         WHERE
   			cast(CURRENT_TIMESTAMP() AS DATE) <= cast(promo_cab.vigencia_h AS DATE)
        GROUP BY
            promo_cli.idpromo_c,
            promo_cli.idCliente
        ORDER BY
            sum(promo_cli.total_vend) ASC;

    INSERT INTO promo_clim (
            idpromocli,
            idCliente,
            idArticulo,
            codArt,
            descripcio,
            cantidad
        )
        SELECT 
            tmp_promo_cli_merch.idpromo_cli,
            tmp_promo_cli_merch.idCliente,
            articulos.idArticulo,
            articulos.codArt,
            articulos.descripcio,
            promo_calcular_cant_merchandisign(tmp_promo_cli_merch.imp_tope, tmp_promo_cli_merch.total_vend) AS cantidad
        FROM 
            promo_artic
                INNER JOIN articulos ON articulos.idArticulo = promo_artic.idArticulo
                INNER JOIN tmp_promo_cli_merch ON tmp_promo_cli_merch.idpromo_c = promo_artic.idpromo_c
                INNER JOIN promo_cli ON promo_cli.id = tmp_promo_cli_merch.idpromo_cli;

    COMMIT;

    SELECT 'OK' AS 'result';
END