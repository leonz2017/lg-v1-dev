CREATE PROCEDURE `citicpa_generarAlic`(pAnio int, pMes int)
begin
	truncate table citicpa_alic;
    
	insert into citicpa_alic (
			idCompraC, tipoCbte, ptoVta, nroCbte, codDocVdor,
			cuitPV, impNetoGrav, alicIVA, impLiq)
		select
			comprascab.idCompraC,
			citicpas_cbtes.cod_afip as tipoCbte,
			concat(repeat('0', 5 - length(comprascab.ptoVta)), comprascab.ptovta) as ptoVta,
			concat(repeat('0', 20 - length(comprascab.numCbte)), comprascab.numCbte) as nroCbte,
			'80' as codDocVdor, 
			concat(repeat('0', 20 - length(comprascab.cuitPV)), comprascab.cuitPV) as cuitPV,
			concat(repeat('0', 15 - length(round(impNeto * 100, 0))), round(impNeto * 100, 0)) as impNetoGrav,
			citi_alicuotas.codAlicuota,
			concat(repeat('0', 15 - length(round(cpasdet_cp.ivaImp * 100, 0))), round(cpasdet_cp.ivaImp * 100, 0)) as impLiq
		from comprascab
			inner join cpasdet_cp on cpasdet_cp.idCompraC	= comprascab.idCompraC
			inner join citicpas_cbtes on citicpas_cbtes.codigo = comprascab.cbte
				and citicpas_cbtes.tipoDoc = comprascab.tipoDoc
			inner join citi_alicuotas on citi_alicuotas.alicuota = cpasdet_cp.ivaPor
		where year(comprascab.fecEmis) = pAnio
			and month(comprascab.fecEmis) = pMes and
            comprascab.fecBaja IS NULL
		group by tipoCbte, ptoVta, numCbte, codAlicuota
		order by tipoCbte, ptoVta, numCbte;

	insert into citicpa_alic (
			idCompraC, tipoCbte, ptoVta, nroCbte, codDocVdor,
			cuitPV, impNetoGrav, alicIVA, impLiq)
		select
			comprascab.idCompraC,
			citicpas_cbtes.cod_afip as tipoCbte,
			concat(repeat('0', 5 - length(comprascab.ptoVta)), comprascab.ptovta) as ptoVta,
			concat(repeat('0', 20 - length(comprascab.numCbte)), comprascab.numCbte) as nroCbte,
			'80' as codDocVdor, 
			concat(repeat('0', 20 - length(comprascab.cuitPV)), comprascab.cuitPV) as cuitPV,
			comprasdet.totNeto as impNetoGrav,
			citi_alicuotas.codAlicuota,
			comprasdet.impIVA as impLiq 
		from comprascab
			inner join comprasdet on comprasdet.idCompraC	= comprascab.idCompraC
			inner join citicpas_cbtes on citicpas_cbtes.codigo = comprascab.cbte
				and citicpas_cbtes.tipoDoc = comprascab.tipoDoc
			inner join citi_alicuotas on citi_alicuotas.alicuota = comprasdet.alicIVA
		where year(comprascab.fecEmis) = pAnio
			and month(comprascab.fecEmis) = pMes
		group by tipoCbte, ptoVta, numCbte, codAlicuota
		order by tipoCbte, ptoVta, numCbte;
end