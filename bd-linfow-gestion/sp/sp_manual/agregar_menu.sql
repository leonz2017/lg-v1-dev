DELIMITER $$
DROP PROCEDURE IF EXISTS agregar_menu $$

CREATE PROCEDURE agregar_menu (
    xCodMenu	varchar(20),
    xNombre	varchar(60),
    xProcedim	varchar(60),
    xIsChild	bit(1),
    xEnlace	int(11),
    xacc_key	varchar(30),
    xorden	int
)
BEGIN
    /**
        * Agrega un menú al sistema si no existe.
    */
    DECLARE vProxId int;
    DECLARE vExisteMenu bit;
    DECLARE vIdAcceso int;
    DECLARE mensaje text;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        GET DIAGNOSTICS CONDITION 1 mensaje = MESSAGE_TEXT;
        SELECT mensaje;
    END;

    SET vExisteMenu = (
        SELECT
            CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END
        FROM
            menues
        WHERE
            menues.CodMenu = xCodMenu);

    IF vExisteMenu = 0 THEN
        START TRANSACTION;

        SET vProxId = (
            SELECT
                CASE WHEN MAX(idMenue) IS NULL THEN 1 ELSE MAX(idMenue) + 1 END
            FROM
                menues);

        INSERT INTO menues (
            idMenue,
            CodMenu,
            Nombre,
            Procedim,
            IsChild,
            Enlace,
            acc_key,
            orden,
            usuAlta,
            fecAlta,
            idHostAlta)
        VALUES (
            vProxId,
            xCodMenu,
            xNombre,
            xProcedim,
            xIsChild,
            xEnlace,
            xacc_key,
            xorden,
            'SUPER',
            current_timestamp,
            'SISTEMA');

        /* Asocio el menú al usuario SUPER */
        SET vIdAcceso = (
            SELECT
                CASE WHEN MAX(idAcceso) IS NULL THEN 1 ELSE MAX(idAcceso) + 1 END
            FROM
                accesos);

        INSERT INTO accesos (
            idAcceso,
            idUsuario,
            idMenue
        ) VALUES (
            vIdAcceso,
            1,
            vProxId);

        COMMIT;
    END IF;
END	