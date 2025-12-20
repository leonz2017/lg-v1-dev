CREATE PROCEDURE `lfwcat_getOfertas`()
begin
	select
    idOferta as idOfertaLG,
		idArticulo as idArticuloLG,
		fecVigDD as vigencia_desde,
		fecVigHH as vigencia_hasta,
		codArt,
		porOfert,
		impOfert,
		1 as habilitado,
		case when fecBaja is null then 0 else 1 end eliminado
	from
		ofertas
	where
		cast(ofertas.fecVigDD as date) <= current_date()
		and cast(ofertas.fecVigHH as date) >= current_date();
end