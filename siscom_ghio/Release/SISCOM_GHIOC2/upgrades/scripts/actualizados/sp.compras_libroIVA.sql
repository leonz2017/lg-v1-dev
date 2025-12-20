CREATE PROCEDURE `compras_libroIVA`(pAnio int, pMes int)
begin
	select	comprascab.idcomprac,
		date(comprascab.fecEmis) as 'fecEmision',
		comprascab.cbte,
		comprascab.tipoDoc,
		comprascab.ptoVta,
		comprascab.numCbte,
		proveedor.razSoc as 'Proveedor',
		provincias.descripcio AS 'Juris',
		sitiva.codIVA as 'Cat',
		proveedor.nroCUIT,
		round(comprascab.totNeto * (Case When comprascab.Cbte = 'NC' Then -1 Else 1 End), 2) as 'Neto_Grav',
		round(comprascab.noGravado * (Case When comprascab.Cbte = 'NC' Then -1 Else 1 End), 2) as 'Neto_No_Grav',
		round(comprascab.impIVA21 * (Case When comprascab.Cbte = 'NC' Then -1 Else 1 End), 2) as 'IVA_21',
		round(comprascab.impIVA105 * (Case When comprascab.Cbte = 'NC' Then -1 Else 1 End), 2) as 'IVA_105',
		round(comprascab.retIVA * (Case When comprascab.Cbte = 'NC' Then -1 Else 1 End), 2) as 'retIVA',
		round(comprascab.retIIBB * (Case When comprascab.Cbte = 'NC' Then -1 Else 1 End), 2) as 'retIIBB',
		round(comprascab.retGan * (Case When comprascab.Cbte = 'NC' Then -1 Else 1 End), 2) as 'retGan',
		round(comprascab.retSUSS * (Case When comprascab.Cbte = 'NC' Then -1 Else 1 End), 2) as 'retSUSS',
		round(comprascab.impuestos * (Case When comprascab.Cbte = 'NC' Then -1 Else 1 End), 2) as 'Impuestos',
		round(comprascab.totFinal * (Case When comprascab.Cbte = 'NC' Then -1 Else 1 End), 2) as 'Total'
	from comprascab
		inner join proveedor on proveedor.idProv = comprascab.idProv
		inner join localidad on proveedor.idlocalid = localidad.idlocalid
		inner join provincias on localidad.idprovin = provincias.idprovin
		inner join sitiva on sitiva.idSitIVA = proveedor.idSitIVA
	where year(comprascab.fecEmis) = pAnio
		and month(comprascab.fecEmis) = pMes
        and comprascab.fecBaja is null
	order by comprascab.fecEmis asc;
end