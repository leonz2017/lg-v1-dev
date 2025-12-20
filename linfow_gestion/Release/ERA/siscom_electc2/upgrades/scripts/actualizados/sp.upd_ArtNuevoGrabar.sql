CREATE PROCEDURE `upd_ArtNuevoGrabar`(pIdProv int, pUsuario varchar(5), pIdHost varchar(50))
begin
	declare vMensaje text;
	declare exit handler for sqlexception
    begin
		rollback;
        get diagnostics condition 1 vMensaje = message_text;
        select vMensaje as result;
    end;
    start transaction;
    
    set @vIdArticulo = (
		select case when max(idArticulo) is null then 1
			else max(idArticulo) + 1 end
		from articulos);
	insert into articulos (
		idArticulo, 
		idprov, 
		idFamilia, 
		idSubFam, 
		idMarca, 
		codArt, 
		descripcio,
        alicIVA, 
        prLista,
        prListaExt,
        cotizac,
        bonif1, 
        bonif2, 
        bonif3, 
        bonif4, 
        costoRep,
        margenMax, 
        margenMin,
        prventaMax, 
        prventaMin, 
        prfinalMax,
        prfinalMin, 
        habilitado, 
        usuAlta, 
        fecAlta, 
        idHostAlta, 
        esServ,
        idUniMed, 
        codArtPV, 
        mostrador, 
        fecActuPre, 
        esNuevo,
        cou)
			select (
				@vIdArticulo := @vIdArticulo + 1), 
				idprov, 
				idFamilia, 
				idSubFam, 
				idMarca, 
				codArt, 
				UPPER(descripcio),
				alicIVA, 
				prListaPV as prLista,
				0 as prListaExt,
				0 as cotizac,
				bonif1, 
				bonif2, 
				bonif3, 
				bonif4, 
				costoRep,
				margenMay, 
				margenMin, 
				prventaMay, 
				prventaMin, 
				articulos_calcPrFinal(prventaMay, alicIVA) as prfinalMax,
				articulos_calcPrFinal(prventaMin, alicIVA) as prfinalMin, 
				1 as habilitado, pUsuario as usuAlta, 
				current_timestamp as fecAlta, 
				pIdHost as idHostAlta, 
				0 as esServ, 
				1 as idUniMed,
				codArtPV, 0 as mostrador, 
				current_timestamp as fecActuPre, 
				1 as esNuevo,
                cou
			from 
				art_tempo
			where 
				idProv = pIdProv;
		
	set @vIdCodArt = (
		select case when max(idCodArt) is null then 1
				else max(idCodArt) + 1 end
		from codiart);
	insert into codiart (
		idCodArt, idArticulo, codArt, codigos, tipo, cantiDesp, procesado, circuito)
			select (@vIdCodArt := @vIdCodArt + 1),
				idArticulo, codArt, codArt, 'CP', 1, 0, 'CV'
			from articulos
			where articulos.idprov = pIdProv
				and articulos.esNuevo = 1;
	
	update articulos
	set articulos.esNuevo = 0
	where articulos.idprov = pIdProv;
    
    delete from art_tempo where idProv = pIdProv;
    commit;
    select 'OK' as result;
end