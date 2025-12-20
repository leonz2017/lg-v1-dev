CREATE PROCEDURE globalcfg_insert (
	xkey varchar(10),
    xtype varchar(1),
    xvalue varchar(255)
)
BEGIN
    DECLARE proximoId int;
	DECLARE existeParametro bit;
    SET existeParametro = (
        SELECT
            CASE WHEN count(*) > 0 THEN 1 ELSE 0 END
        FROM
            global_cfg
        WHERE 
            global_cfg.cfg_key = xkey
    );

    IF NOT existeParametro THEN
        SET proximoId = (
            SELECT
                MAX(idGlobalCF) + 1
            FROM
                global_cfg
        );

        INSERT INTO global_cfg (
            idGlobalCF,
            cfg_key,
            cfg_Type,
            cfg_Value,
            usuAlta,
            fecAlta,
            idHostAlta
        ) VALUES (
            proximoId,
            xkey,
            xtype,
            xvalue,
            'ROOT',
            current_timestamp,
            'LINFOW GESTION # Upgrade'
        );
    END IF;
END 