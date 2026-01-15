CREATE PROCEDURE promo_create_temps()
BEGIN
    -- Elimino las tablas temporales en caso de que existan
    DROP TABLE IF EXISTS tmp_promo_marcas;
    DROP TABLE IF EXISTS tmp_promo_artic;

    -- Creo la tabla temporal para asignar las marcas en la promoción
    CREATE TEMPORARY TABLE tmp_promo_marcas (
        idpromo_c int not null default 0,
        idmarca int not null,
        primary key (idpromo_c, idmarca)
    );

    CREATE TEMPORARY TABLE tmp_promo_artic (
        idpromo_c int not null default 0,
        idArticulo int not null,
        primary key (idpromo_c, idArticulo)
    );
END