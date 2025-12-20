CREATE PROCEDURE rcn_insert_aux_fichadet (
	xid_ficha int,
	xcantidad decimal(20, 2),
	xidArticulo int,
	xcodArt varchar(20),
	xdescripcion varchar(200),
	xusuario varchar(5),
	xhost varchar(50)
)
BEGIN
	INSERT INTO rcn_aux_fichadet (
		id_ficha, cantidad, idArticulo, codArt,
		descripcio, usuario, host)
	VALUES (
	 xid_ficha, xcantidad, xidArticulo, xcodArt,
	 xdescripcion, xusuario, xhost);
END