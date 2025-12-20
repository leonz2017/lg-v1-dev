CREATE PROCEDURE rcn_limpiar_aux_fichadet(
	xusuario varchar(5),
	xhost varchar(50)
)
BEGIN
	DELETE FROM rcn_aux_fichadet
	WHERE
		usuario = xusuario AND
		host = xhost;
		
	ALTER TABLE rcn_aux_fichadet AUTO_INCREMENT = 0;
END