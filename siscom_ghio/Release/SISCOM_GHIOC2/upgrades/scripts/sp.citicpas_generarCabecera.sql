CREATE PROCEDURE `citicpas_generarCabecera`(p_anio int, p_mes int)
begin
	set binlog_format = mixed;   
    drop table if exists tmp_percIIBB;    
	truncate table citicpa_cab;

	create temporary table if not exists tmp_percIIBB as (
		select 
			idCompraC, 
			replace(round(sum(importe), 2), '.', '') as impPerIIBB
		from comprasret
		where comprasret.tipo = 'RIB'
		group by idCompraC);

	/* En el select paso los impuestos internos de otros tributos a conceptos no grabado
		según recomendación del estudio contable */
	insert into citicpa_cab (
		idCompraC,
		fecEmis,
		tipoCbte,
		ptoVta,
		nroCbte,
		nroDespImp,
		codDoc,
		cuitPV,
		razSocPV,
		impTotOper,
		ImpConceptos,
		ioe,
		impPercValAg,
		impPercOIN,
		impPerIIBB,
		impPerImpMun,
		impImpInt,
		codMon,
		tipoCbio,
		cantAlicIVA,
		codOper,
		credFisComp,
		otrosTrib,
		cuitEmisCorr,
		denomEmisCorr,
		ivaCom)
	select 
		comprascab.idCompraC,
		replace(cast(cast(comprascab.fecEmis as date) as char(10)), '-', '') as fecEmis,
		citicpas_cbtes.cod_afip as tipoCbte,
		concat(repeat('0', 5 - length(comprascab.ptoVta)), comprascab.ptovta) as ptoVta,
		concat(repeat('0', 20 - length(comprascab.numCbte)), comprascab.numCbte) as nroCbte,
		repeat(' ', 16) as nroDespImp,
		80 as codDoc, 
		concat(repeat('0', 20 - length(comprascab.cuitPV)), comprascab.cuitPV) as cuitPV,
		substring(comprascab.razSocPV, 1, 30) as razSocPV,
		citicpas_formatImporte(comprascab.totFinal) as totImpOper,
		concat(repeat('0', 15 - length((round(impuestos * 100, 0)))), (round(impuestos * 100, 0))) as ImpConceptos,
		repeat('0', 15) as ioe,
		concat(repeat('0', 15 - length(round(retIVA * 100, 0))), round(retIVA * 100, 0)) as impPercValAg,
		repeat('0', 15) as impPercOIN,
		case 
			when impPerIIBB is null then 
				repeat('0', 15) 
			else 
				concat(repeat('0', 15 - length(impPerIIBB)), impPerIIBB)
			end as impPerIIBB,
		repeat('0', 15) as impPerImpMun,
		repeat('0', 15) as impImpInt,
		'PES' as codMon,
		concat(repeat('0', 10 - length('1000000')), '1000000') as tipoCbio,
		'0' as cantAlicIVA,
		'0' as codOper,
		citicpas_calcCreditoFiscal(comprascab.impIVA21, comprascab.impIVA105) as credFisComp,
		repeat('0', 15) as otrosTrib,
		repeat('0', 11) as cuitEmisCorr,
		repeat(' ', 30) as denomEmisCorr,
		repeat('0', 15) as ivaCom
	from comprascab
		inner join citicpas_cbtes on citicpas_cbtes.codigo = comprascab.cbte
			and citicpas_cbtes.tipoDoc = comprascab.tipoDoc
		left outer join tmp_percIIBB as retenciones on retenciones.idCompraC = comprascab.idCompraC
	where year(comprascab.fecEmis) = p_anio
		and month(comprascab.fecEmis) = p_mes
        and comprascab.fecBaja IS NULL
	order by
		citicpas_cbtes.cod_afip,
        comprascab.ptovta,
        comprascab.numCbte;
end