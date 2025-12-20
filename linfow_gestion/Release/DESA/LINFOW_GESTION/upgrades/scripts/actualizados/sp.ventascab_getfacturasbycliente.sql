create procedure ventascab_getFacturasByCliente (
	xidCliente int
)
begin
	select
		idVentasC,
		fecEmision,
		cbte,
		tipoDoc,
		concat(repeat('0', 5 - length(ptoVta)), ptoVta) as ptoVta,
		concat(repeat('0', 8 - length(numCbte)), numCbte) as numero
	from 
		ventascab v 
	where 
		v.idCliente = xidCliente and
		v.cbte = 'FC';	
end