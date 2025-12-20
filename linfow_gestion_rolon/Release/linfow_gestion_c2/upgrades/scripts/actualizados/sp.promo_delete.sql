CREATE PROCEDURE promo_delete(
    xidpromo_cab int,
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

    UPDATE
        promo_cab
    SET
        promo_cab.usuBaja = xusuarioActual,
        promo_cab.fecBaja = current_timestamp,
        promo_cab.idHostBaja = xhost
    WHERE
        promo_cab.idpromo_cab = xidpromo_cab;

    COMMIT;
    SELECT 'OK' AS 'result';
END