CREATE PROCEDURE `ventascab_getIVAVtas`(
	pFechaDD DATE,
	pFechaHH DATE)
BEGIN
	DROP TABLE IF EXISTS tmp_ivavtas;
	CREATE TEMPORARY TABLE tmp_ivavtas
		SELECT 
			ventascab.IdVentasc,
			ventascab.FecEmision,
			ventascab.Cbte,
			ventascab.TipoDoc,
			ventascab.PtoVta,
			ventascab.NumCbte,
			clientes.razsoc as 'Cliente',
			provincias.descripcio as 'Juris',
			Case sitiva.idsitiva
				When 1 Then 'RI'
				When 3 Then 'CF'
				When 6 Then 'MON' 	
			Else 'EXE'  End as 'Cat',  
			ventascab.nroDoc,
			Round(SUM(
				Case When ventasdet.AlicIVA = 21 Then ventasdet.TotNeto Else 0 END) *
						(Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'Grav_P_21', 
					Round(SUM(Case When ventasdet.AlicIVA = 10.5 Then ventasdet.TotNeto Else 0 End) * 
						(Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'Grav_P_105',
			Round(ventascab.totaNoGrav * (Case When ventascab.Cbte = 'NC' Then -1 Else 1 End), 2) as 'No_Grav',
			Round(ventascab.impIIBB * (Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'Per_IIBB',
			Round(ventascab.impIVA21 * (Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'IVA_21',
			Round(ventascab.impIVA105 * (Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'IVA_105',
			Round(ventascab.totfact * (Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'Total'
		FROM  
			ventascab  	
				left join ventasdet on ventascab.idventasc = ventasdet.idventasc 
				inner join clientes on ventascab.idcliente = clientes.idcliente  
				inner join localidad on clientes.idlocalid = localidad.idlocalid 
				inner join provincias on localidad.idprovin = provincias.idprovin 
				inner join sitiva on clientes.idsitiva = sitiva.idsitiva  
		WHERE   
			ventascab.Cbte NOT IN ('PED','COT','PTO')  AND 
			ventascab.idventasc NOT IN (select idventasc from vtadcp) AND 
			ventascab.fecBaja IS NULL AND 
			ventascab.aut_Resultado = 'A' and 
			CAST(ventascab.FecEmision AS DATE) between pFechaDD and pFechaHH
		GROUP BY 
			ventascab.IdVentasc, 
			ventascab.FecEmision, 
			ventascab.Cbte,
			ventascab.TipoDoc,
			ventascab.PtoVta,
			ventascab.NumCbte,
			clientes.razsoc,
			ventascab.nroDoc,
			provincias.descripcio,
			sitiva.idsitiva,
			ventasdet.IdVentasc
		UNION 
		SELECT
			ventascab.IdVentasc,  
			ventascab.FecEmision,  
			ventascab.Cbte,  
			ventascab.TipoDoc,  
			ventascab.PtoVta,  
			ventascab.NumCbte,  
			clientes.razsoc as 'Cliente',  
			provincias.descripcio as 'Juris',  
			Case sitiva.idsitiva
				When 1 Then 'RI' 
				When 3 Then 'CF' 
				When 6 Then 'MON' 	
				Else 'EXE'  
			End as 'Cat',  
			ventascab.nroDoc,  
			Round(SUM(Case When vtadcp.ivaPor = 21 Then vtadcp.impNeto Else 0 End) * 
				(Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'Grav_P_21',  
			Round(SUM(Case When vtadcp.ivaPor = 10.5 Then vtadcp.impNeto Else 0 End) * 
				(Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'Grav_P_105',  
			Round(ventascab.totaNoGrav * (Case When ventascab.Cbte = 'NC' Then -1 Else 1 End), 2) as 'No_Grav',
			Round(ventascab.impIIBB * (Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'Per_IIBB',  
			Round(ventascab.impIVA21 * (Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'IVA_21',  
			Round(ventascab.impIVA105 * (Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'IVA_105',  
			Round(ventascab.totfact * (Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'Total'  
		FROM    
			ventascab  	
				left join vtadcp on ventascab.idventasc = vtadcp.idventasc    
				inner join clientes on ventascab.idcliente = clientes.idcliente    
				inner join localidad on clientes.idlocalid = localidad.idlocalid    
				inner join provincias on localidad.idprovin = provincias.idprovin   
				inner join sitiva on clientes.idsitiva = sitiva.idsitiva  
		WHERE   
			ventascab.Cbte NOT IN ('PED','COT','PTO') AND 
			ventascab.idventasc IN (select idventasc from vtadcp) AND 
			ventascab.fecBaja IS NULL AND 
			ventascab.aut_Resultado = 'A' and 
			CAST(ventascab.FecEmision AS DATE) between pFechaDD and pFechaHH
		GROUP BY  
			ventascab.IdVentasc,
			ventascab.FecEmision,
			ventascab.Cbte,
			ventascab.TipoDoc,
			ventascab.PtoVta,
			ventascab.NumCbte,
			clientes.razsoc,
			ventascab.nroDoc,
			provincias.descripcio,
			sitiva.idsitiva,
			vtadcp.IdVentasc
		ORDER BY 	
			fecEmision, 
			tipodoc;
			
	SELECT
		*
	FROM
		tmp_ivavtas
	ORDER BY
		fecEmision,
		cbte,
		ptovta,
		numcbte;
END
