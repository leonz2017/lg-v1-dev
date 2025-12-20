CREATE PROCEDURE `upd_actualizarExistentes`(
	IN `pIdProv` int,
	IN `pUsuario` varchar(5),
	IN `pIdHost` varchar(50)
)
begin
	declare mensaje text;
    declare exit handler for sqlexception
    begin
		get diagnostics condition 1 mensaje = message_text;
        call art_upd_log_insert ('upd_actualizarExistentes', 'OK');
    end;

	update articulos
		inner join (
			select 
					*
         from 
				art_upd_tempo
         where 
				esNuevo = 0 and
				idProv = pIdProv) as tempo on tempo.idArticulo = articulos.idArticulo
	set articulos.prLista = tempo.lista,
		articulos.bonif1 = tempo.bonif1,
        articulos.bonif2 = tempo.bonif2,
        articulos.bonif3 = tempo.bonif3,
        articulos.bonif4 = tempo.bonif4,
        articulos.costoRep = articulos_calcularCosto(tempo.lista,
				tempo.bonif1, tempo.bonif2, tempo.bonif3, tempo.bonif4),
		articulos.margenMax = tempo.margenMax,
        articulos.margenMin = tempo.margenMin,
        articulos.prventaMax = articulos_calcularVenta(
				articulos_calcularCosto(tempo.lista, tempo.bonif1, tempo.bonif2,
					tempo.bonif3, tempo.bonif4), tempo.margenMax),
		articulos.prventaMin = articulos_calcularVenta(
				articulos_calcularCosto(tempo.lista, tempo.bonif1, tempo.bonif2,
					tempo.bonif3, tempo.bonif4), tempo.margenMin),
		articulos.prfinalMax = articulos_calcPrFinal(
				articulos_calcularVenta(
					articulos_calcularCosto(tempo.lista, tempo.bonif1, tempo.bonif2,
						tempo.bonif3, tempo.bonif4), tempo.margenMax), articulos.alicIVA),
		articulos.prfinalMin = articulos_calcPrFinal(
				articulos_calcularVenta(
					articulos_calcularCosto(tempo.lista,
						tempo.bonif1, tempo.bonif2,
						tempo.bonif3, tempo.bonif4), tempo.margenMin), articulos.alicIVA),
		articulos.fecActuPre = current_timestamp,
		articulos.usuModi = pUsuario,
        articulos.fecModi = current_timestamp,
        articulos.idHostModi = pIdHost;
end