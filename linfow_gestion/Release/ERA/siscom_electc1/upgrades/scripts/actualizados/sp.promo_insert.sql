CREATE PROCEDURE promo_insert(
    xnombre varchar(60),
    xvigencia_d datetime, 
    xvigencia_h datetime, 
    ximp_tope decimal(20,2),
    xusuarioActual varchar(5),
    xhost varchar(50)
)
BEGIN
    DECLARE v_mensaje varchar(255);
    DECLARE v_idpromo_c int;

    DECLARE EXIT handler FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        GET DIAGNOSTICS CONDITION 1 v_mensaje = MESSAGE_TEXT;
        SELECT v_mensaje AS 'result';
    END;

    START TRANSACTION;

    -- Inserto la cabecera de la promoción
    INSERT INTO promo_cab (
        nombre,
        vigencia_d,
        vigencia_h,
        imp_tope,
        usuAlta,
        fecAlta,
        idHostAlta
    ) VALUES (
        xnombre,
        xvigencia_d,
        xvigencia_h,
        ximp_tope,
        xusuarioActual,
        current_timestamp,
        xhost
    );

    -- Obtengo el id de promoción generado.
    SET v_idpromo_c = (
        SELECT
            MAX(idpromo_c)
        FROM
            promo_cab);

    -- Actualizo la tabla temporal de marcas
    UPDATE
        tmp_promo_marcas
    SET
        tmp_promo_marcas.idpromo_c = v_idpromo_c;
    
    -- Actualizo la tabla temporal de merchandisign con el id de promoción obtenido
    UPDATE
        tmp_promo_artic
    SET
        tmp_promo_artic.idpromo_c = v_idpromo_c;

    -- Inserto las marcas en la promoción
    INSERT INTO promo_marcas
        SELECT
            idpromo_c,
            idmarca
        FROM
            tmp_promo_marcas;

    -- Inserto los artículos merchandisign en la promoción
    INSERT INTO promo_artic
        SELECT
            idpromo_c,
            idArticulo
        FROM
            tmp_promo_artic;

    COMMIT;
    SELECT 'OK' AS 'result';
END