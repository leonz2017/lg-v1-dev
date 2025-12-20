CREATE PROCEDURE rcn_insertar_items_temporal (
	IN iditem_param INT(11),
    IN idmarca_param INT(11),
    IN medida_param DECIMAL(20, 2),
    IN nro_serie_param VARCHAR(20),
    IN trabajo_param VARCHAR(100),
    IN usuario_param VARCHAR(5),
    IN host_param VARCHAR(50)
)
BEGIN    
    INSERT INTO rcn_aux_rtitem (id, idmarca, medida, nro_serie, trabajo, usuario, host)
    VALUES (iditem_param, idmarca_param, medida_param, nro_serie_param, trabajo_param, usuario_param, host_param);
END




