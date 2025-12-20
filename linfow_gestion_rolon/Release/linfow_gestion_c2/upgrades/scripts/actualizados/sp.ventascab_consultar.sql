CREATE PROCEDURE `ventascab_consultar`(
	_tipoConsulta varchar(20),
	_fechaDesde datetime,
	_fechaHasta datetime,
	_idClienteDesde int,
	_idClienteHasta int,
	_cbte varchar(5),
	_tipoDoc varchar(5),
	_ptoVta int,
	_numCbte int)
begin
	select ventascab.idVentasC, ventascab.idCliente, ventascab.razSoc,
        	ventascab.fecEmision, ventascab.cbte, ventascab.tipoDoc, ventascab.ptoVta,
	        ventascab.numCbte, ventascab.totFact, ventascab.usuAlta, ventascab.idHostAlta,
        	ventascab.observ, ventascab.aut_Resultado, ventascab.aut_CAE, ventascab.aut_CAE_Vto
	from ventascab
		inner join clientes on ventascab.idCliente = clientes.idCliente
	where ventascab.anulado = 0
		and ventascab.fecBaja is null
        and case
			when (_fechaDesde is null and _fechaHasta is null) then 1
			else cast(ventascab.fecEmision as date) between _fechaDesde and _fechaHasta end
		and case
			when (_idClienteDesde = 0 and _idClienteHasta = 0) then 1
			else ventascab.idCliente between _idClienteDesde and _idClienteHasta end
		and case
			when _cbte = 'TODOS' then
				case
					when _tipoConsulta = 'facturacion' then ventascab.cbte in ('FC', 'NC', 'ND')
					when _tipoConsulta = 'pedidos' then ventascab.cbte = 'PED'
					when _tipoConsulta = 'presupuesto' then ventascab.cbte in ('FC', 'NC', 'ND')
					when _tipoConsulta = 'cotizador' then ventascab.cbte in ('COT') end
			else case
				when _cbte is null then 1
				else ventascab.cbte = _cbte end
			end
		and case
			when _tipoConsulta = 'facturacion' then ventascab.aut_Resultado = 'A'
            else 1 end
		and case
			when _tipoDoc = 'TODOS' then 1
			else ventascab.tipodoc = _tipoDoc end
        and case
			when _ptoVta = 0 then 1
			else ventascab.ptovta = _ptoVta end
		and case
			when _numCbte = 0 then 1
			else ventascab.numCbte = _numCbte end
	order by ventascab.fecEmision;
end