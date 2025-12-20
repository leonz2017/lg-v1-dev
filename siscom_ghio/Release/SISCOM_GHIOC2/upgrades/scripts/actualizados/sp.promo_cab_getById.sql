CREATE PROCEDURE promo_cab_getById (
    xidpromo_cab int
)
BEGIN
    SELECT
        *
    FROM
        promo_cab
    WHERE
        promo_cab.idpromo_c = xidpromo_cab;
END