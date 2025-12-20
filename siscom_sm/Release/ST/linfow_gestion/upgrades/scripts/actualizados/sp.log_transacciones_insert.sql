create procedure log_transacciones_insert (
    xcomponente varchar(50),
    xmodulo varchar(50),
    xdescripcio varchar(100),
    xvaloresref text,
    xlinea_cod int,
    xsql_stmt text,
    xerror_msg text)
begin
	declare v_message text;
    declare exit handler for sqlexception
    begin
		rollback;
        get diagnostics condition 1 v_message = message_text;
        select v_message as result;
    end;
    start transaction;
    insert into log_transacciones (
		componente,
        modulo,
        descripcio,
        valoresref,
        linea_cod,
        sql_stmt,
        error_msg)
	values (
		xcomponente,
        xmodulo,
        xdescripcio,
        xvaloresref,
        xlinea_cod,
        xsql_stmt,
        xerror_msg    
    );
    commit;
    select 'OK' as result;
end
	