CREATE PROCEDURE promo_marcas_getByCab(
    xidpromo_cab int
)
BEGIN
    SELECT
        promo_marcas.idpromo_c,
        promo_marcas.idmarca,
        marcas.descripcio
    FROM
        promo_marcas
            INNER JOIN marcas ON marcas.idmarca = promo_marcas.idmarca
    WHERE
        promo_marcas.idpromo_c = xidpromo_cab;
END