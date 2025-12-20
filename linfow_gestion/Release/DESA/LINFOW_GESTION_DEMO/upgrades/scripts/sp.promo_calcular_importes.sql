CREATE PROCEDURE promo_calcular_importes ()
BEGIN
    /**
     * Este SP permite calcular los importes comprados por los clientes y
     * calcular cuánto le falta para alcanzar alguna promoción, y los resultados
     * de merchandisign en cuanto a cantidad.
     *
     * Desarrollado por: LINFOW - Leonardo D. Zulli
     * Fecha: 27/08/2021
    */

    DECLARE v_mensaje varchar(255);
    DECLARE EXIT handler FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        GET DIAGNOSTICS CONDITION 1 v_mensaje = MESSAGE_TEXT;
        SELECT v_mensaje AS 'result';
    END;

    START TRANSACTION;

    -- Elimino el contenido de los resultados de merchandising
    DELETE FROM promo_clim;
    ALTER TABLE promo_clim AUTO_INCREMENT = 0;    

    -- Elimino los datos de mediciones
    DELETE FROM promo_cli;
    ALTER TABLE promo_cli AUTO_INCREMENT = 0;

    COMMIT;


    -- Levanta ventas de cuenta 1
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
                cab.cbte IN ('FC', 'NC')
            GROUP BY
                prc.idpromo_c,
                cab.idCliente,
                cab.idVentasC,
                cab.cbte;
        
    -- Levanta ventas de cuenta 2
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
                siscom_mgc2.ventasdet det
                    INNER JOIN siscom_mgc2.ventascab cab
                        ON cab.idVentasC = det.idVentasC
                    INNER JOIN articulos art 
                        ON art.idArticulo = det.idArticulo
                    INNER JOIN promo_marcas prm
                        ON prm.idmarca = art.idmarca
                    INNER JOIN promo_cab prc
                        ON prc.idpromo_c = prm.idpromo_c
            WHERE
                cast(cab.fecEmision AS DATE) between cast(prc.vigencia_d AS DATE) AND cast(prc.vigencia_h AS DATE) AND
                cab.cbte IN ('FC', 'NC')
            GROUP BY
                prc.idpromo_c,
                cab.idCliente,
                cab.idVentasC,
                cab.cbte;

    -- Pongo en negativo los valores que corresponden a las notas de créditos
    -- para que lo descuente
    UPDATE
        promo_cli
    SET
        total_vend = total_vend * -1
    WHERE
        cbte = 'NC' AND
        total_vend > 0;

    -- Calculo los resultados de los merchandising para saber quién y 
    -- cuantos se llevan.

    -- Elimino tabla temporal
    DROP TABLE IF EXISTS tmp_promo_cli_merch;

    -- Cargo los resultados de merchandising en tabla temporal
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
        GROUP BY
            promo_cli.idpromo_c,
            promo_cli.idCliente
        ORDER BY
            sum(promo_cli.total_vend) ASC;

    -- Grabo los resultados obtenidos de merchandising en la tabla
    -- promo_clim
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