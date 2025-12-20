create function art_generar_cdp (
	xidprov int,
	xcodArtPV varchar(40),
    xdescripcion varchar(200))
returns char(32) deterministic
begin
	declare xcodArtPV_aux varchar(40);
    declare xdescripcion_aux varchar(200);

    set xcodArtPV_aux = art_cdp_formatear_string(xcodArtPV);
    set xdescripcion_aux = art_cdp_formatear_string(xdescripcion);
    return md5(concat(ltrim(rtrim(xcodArtPV_aux)), ltrim(rtrim(xdescripcion_aux)), xidprov));
end