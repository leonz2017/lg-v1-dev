CREATE PROCEDURE `log_transacciones_insert`(
	IN `xcomponente` varchar(50),
	IN `xmodulo` varchar(50),
	IN `xdescripcio` varchar(100),
	IN `xvaloresref` text,
	IN `xlinea_cod` int,
	IN `xsql_stmt` text,
	IN `xerror_msg` text
)
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