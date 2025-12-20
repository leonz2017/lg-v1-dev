CREATE PROCEDURE promo_update(
    xidpromo_c int,
    xnombre varchar(60),
    xvigencia_d datetime, 
    xvigencia_h datetime, 
    ximp_tope decimal(20,2),
    xusuarioActual varchar(5),
    xhost varchar(50)
)
BEGIN
    DECLARE v_mensaje varchar(255);
    DECLARE EXIT handler FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        GET DIAGNOSTICS CONDITION 1 v_mensaje = MESSAGE_TEXT;
        SELECT v_mensaje AS 'result';
    END;

    START TRANSACTION;

    -- Actualizo los datos de cabecera
    UPDATE
        promo_cab
    SET
        promo_cab.nombre = xnombre,
        promo_cab.vigencia_d = xvigencia_d,
        promo_cab.vigencia_h = xvigencia_h,
        promo_cab.imp_tope = ximp_tope,
        promo_cab.usuModi = xusuarioActual,
        promo_cab.fecModi = current_timestamp,
        promo_cab.idHostModi = xhost
    WHERE
        promo_cab.idpromo_c = xidpromo_c;

    -- Actualizo las marcas asignadas
    DELETE 
    FROM 
        promo_marcas
    WHERE
        promo_marcas.idpromo_c = xidpromo_c;

    INSERT INTO promo_marcas
        SELECT
            idpromo_c,
            idmarca
        FROM
            tmp_promo_marcas;
    
    -- Actualizo los artículos de merchandising
    DELETE
    FROM
        promo_artic
    WHERE
        promo_artic.idpromo_c = xidpromo_c;

    INSERT INTO promo_artic
        SELECT
            idpromo_c,
            idArticulo
        FROM
            tmp_promo_artic;

    COMMIT;
    SELECT 'OK' AS 'result';
END