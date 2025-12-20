CREATE PROCEDURE `clientes_getMorosos`()
BEGIN

	DECLARE vIdClienteCF int;
	
	select cast(cfg_value as int) into vIdClienteCF from global_cfg where cfg_key = 'CLI_CF';

	/*drop table if exists tmp_clientes_morosos;
	create temporary table tmp_clientes_morosos (
		idCliente int not null unique,
		habilitado bit not null,
		razSoc varchar(60) not null,
		telefono varchar(30) null,
		eMail varchar(60) null,
		primary key (idCliente));*/

	drop table if exists x_op_con_saldo;
	create temporary table x_op_con_saldo
		select
			idOper
		from
			cc_cli as aux
		where
			aux.fecBaja IS NULL
		group by
			idOper
		having
			(round(sum(aux.impDebe), 2) - round(sum(aux.impHaber), 2)) != 0;


	select
		clientes.habilitado AS habilitado,
		clientes.idCliente,
		clientes.razSoc, 
		clientes.telefono,
		clientes.eMail
	from
		cc_cli
			inner join x_op_con_saldo on x_op_con_saldo.idOper = cc_cli.idOper
			inner join clientes on clientes.idCliente = cc_cli.idCliente
	where
		cc_cli.impDebe != 0 and
		current_date() > cast(cc_cli.fecVto as date) and
		cc_cli.idCliente != vIdClienteCF
	group by
		cc_cli.idCliente;	
END