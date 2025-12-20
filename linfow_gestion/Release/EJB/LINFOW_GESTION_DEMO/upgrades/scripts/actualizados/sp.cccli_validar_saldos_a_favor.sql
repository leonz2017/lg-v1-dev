CREATE PROCEDURE `cccli_validar_saldos_a_favor`(
	pIdCliente int)
begin
	select
		case
			when count(*) > 0 then 1 else 0 end hay_cbte
	from
		cc_cli
	where
		cc_cli.idCliente = pIdCliente and
		cc_cli.impHaber <> 0 and
		cc_cli.idOper in (
			select
				idOper
			from
				cc_cli
			where
				idCliente = pIdCliente
			group by
				idOper
			having
				count(*) = 1
			order by
				idOper);
end