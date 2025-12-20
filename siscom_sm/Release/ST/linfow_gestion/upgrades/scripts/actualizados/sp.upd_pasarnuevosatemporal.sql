CREATE PROCEDURE `upd_pasarNuevosATemporal`(pIdProv int)
begin
	declare vIdFamilia int;
    declare vIdSubFam int;
    declare vIdMarca int;
	
	set vIdFamilia = globalCFG_getByKey ('UPDFAMDEF');
	set vIdSubFam = globalCFG_getByKey ('UPDSUBFDEF');
	set vIdMarca = globalCFG_getByKey ('UPDMARDEF');
	
	insert into art_tempo (
		idprov, idFamilia, idSubFam, idMarca, codArt, codArtPV,
        descripcio, alicIVA, prListaPV, bonif1, bonif2, bonif3, bonif4,
        costoRep, margenMay, margenMin, prVentaMay, prVentaMin, procesado, cou)
			select 
				idprov,vIdFamilia, vIdSubFam, vIdMarca, codArt,
				codigo, UPPER(articulo), 21 as alicIVA, lista, art_upd_tempo.bonif1,
				art_upd_tempo.bonif2, art_upd_tempo.bonif3, art_upd_tempo.bonif4, 0 as costoRep, art_upd_tempo.margenMax,
				art_upd_tempo.margenMin, 0 as prVentaMay, 0 as prVentaMin, 0 as procesado, cou
			from 
				art_upd_tempo
			where 
				art_upd_tempo.esNuevo = 1 and
				art_upd_tempo.idProv = pIdProv;
	
    
	
	update
		art_tempo
	set
		art_tempo.bonif1 = case when art_tempo.bonif1 = -1 then 0 else art_tempo.bonif1 end,
        art_tempo.bonif2 = case when art_tempo.bonif2 = -1 then 0 else art_tempo.bonif2 end,
        art_tempo.bonif3 = case when art_tempo.bonif3 = -1 then 0 else art_tempo.bonif3 end,
        art_tempo.bonif4 = case when art_tempo.bonif4 = -1 then 0 else art_tempo.bonif4 end,
        art_tempo.margenMay = case when art_tempo.margenMay = -1 then 0 else art_tempo.margenMay end,
        art_tempo.margenMin = case when art_tempo.margenMin = -1 then 0 else art_tempo.margenMin end;
end