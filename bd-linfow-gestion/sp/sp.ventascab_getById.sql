CREATE PROCEDURE `ventascab_getById`(_idVentasC int)
begin
	select ventascab.*, tipodoc.CodAfip, sitiva.conivareid
	from ventascab
		inner join tipodoc on tipodoc.idTipoDoc = ventascab.idTipoDoc
        inner join sitiva on sitiva.idSitIVA = ventascab.idSitIVA
	where ventascab.idVentasC = _idVentasC;
end