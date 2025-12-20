CREATE PROCEDURE promo_tempo_marcas_insert (
    xidpromo_c int,
    xidmarca int
)
BEGIN
    INSERT INTO tmp_promo_marcas (
        idpromo_c,
        idmarca
    ) VALUES (
        xidpromo_c,
        xidmarca
    );
END