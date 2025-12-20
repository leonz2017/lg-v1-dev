CREATE PROCEDURE rcn_limpiar_temporal_items (
	xusuario varchar(5),
	xhostname varchar(50))
BEGIN
	DELETE FROM rcn_aux_rtitem WHERE usuario = xusuario AND host = xhostname;
END