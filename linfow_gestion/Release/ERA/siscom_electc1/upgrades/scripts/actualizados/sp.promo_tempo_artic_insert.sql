CREATE PROCEDURE promo_tempo_artic_insert (
    xidpromo_c int,
    xidArticulo int
)
BEGIN
    INSERT INTO tmp_promo_artic (
        idpromo_c,
        idArticulo
    ) VALUES (
        xidpromo_c,
        xidArticulo
    );
END