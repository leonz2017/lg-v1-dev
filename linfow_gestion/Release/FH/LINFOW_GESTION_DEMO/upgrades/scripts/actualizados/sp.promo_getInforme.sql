CREATE PROCEDURE promo_getInforme()
BEGIN
    /**
    * Este procedimeinto permite obtener la medición por cliente
    * para saber quién se lleva o se está por llevar el merchandising.
    *
    * Desarrollado por: LINFOW - Leonardo D. Zulli
    * Fecha: 27/08/2021
    */

    SELECT
        promo_cli.idpromo_c,
        promo_cab.nombre,
        promo_cli.idCliente,
        clientes.razSoc,
        promo_cli.imp_tope,
        sum(promo_cli.total_vend) as total_vend,
        promo_calcular_faltan(promo_cli.imp_tope, sum(promo_cli.total_vend)) as faltan
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
        sum(promo_cli.total_vend) DESC;
END