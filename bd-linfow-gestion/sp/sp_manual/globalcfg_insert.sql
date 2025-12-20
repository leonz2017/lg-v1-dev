delimiter $$
DROP PROCEDURE if EXISTS globalcfg_insert $$
CREATE PROCEDURE if NOT exists `globalcfg_insert`(
	IN `xkey` varchar(10),
	IN `xtype` varchar(1),
	IN `xvalue` varchar(255),
	IN `xreemplazar` bit
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
    ELSE
    	-- Solo reemplazo el valor si le indico que lo tiene que hacer.
    	IF xreemplazar = 1 THEN
    		UPDATE
    			global_cfg
    		SET
    			cfg_value = xvalue,
    			usuModi = 'DESA',
    			fecModi = current_timestamp,
    			idHostModi = 'ESCRITORIO # Leonardo'
    		WHERE
    			cfg_key = xkey;
    	END IF;
    END IF;
END $$