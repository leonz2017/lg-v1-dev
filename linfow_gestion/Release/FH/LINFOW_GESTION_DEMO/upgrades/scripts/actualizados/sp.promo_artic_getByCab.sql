CREATE PROCEDURE promo_artic_getByCab(
    xidpromo_c int
)
BEGIN
    SELECT
        promo_artic.idpromo_c,
        promo_artic.idArticulo,
        articulos.codArt,
        articulos.descripcio
    FROM
        promo_artic
            INNER JOIN articulos ON articulos.idArticulo = promo_artic.idArticulo
    WHERE
        promo_artic.idpromo_c = xidpromo_c;
END