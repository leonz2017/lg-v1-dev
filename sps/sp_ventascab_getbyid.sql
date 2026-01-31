DELIMITER $$
DROP PROCEDURE IF EXISTS ventascab_getById $$

CREATE PROCEDURE IF NOT EXISTS `ventascab_getById`(_idVentasC int)
begin
	select ventascab.*, tipodoc.CodAfip, sitiva.conivareid, condpagos.cntDias
	from ventascab
		inner join tipodoc on tipodoc.idTipoDoc = ventascab.idTipoDoc
        inner join sitiva on sitiva.idSitIVA = ventascab.idSitIVA
        inner join condpagos on condpagos.idCondPago = ventascab.idCondPago
	where ventascab.idVentasC = _idVentasC;
end