CREATE PROCEDURE `clientes_insert_rapido`(
	IN prazSoc varchar(60),
	IN pdireccion varchar(60),
	IN pidLocalid int,
	IN pidCondPago int,
	IN pidSitIVA int,
	IN pidVendedor int,
	IN pidTipoCli int,
	IN pidTransp int,
	IN pidTipoDoc int,
	IN pidRamo int,
	IN pnroCUIT varchar(20),
	IN ptelefono varchar(20),
	IN pcelular varchar(20),
	IN pfax varchar(20),
	IN peMail varchar(60),
	IN phabilitado bit,
	IN pmayorista bit,
	IN pdesc1 decimal(5, 2),
	IN pdesc2 decimal(5, 2),
	IN pdesc3 decimal(5, 2),
	IN pdesc4 decimal(5, 2),
	IN precargo decimal(5, 2),
	IN pusuAlta varchar(5),
	IN pidHostAlta varchar(50),
	IN penvCbte bit,
	IN pprintCbte bit,
	IN pmailFC varchar(60),
	IN pctrMoro bit
)
begin
	declare mensaje varchar(255);
    declare exit handler for sqlexception
    begin
		rollback;
        get diagnostics condition 1 mensaje = message_text;
        select mensaje as result;
    end;
    start transaction;
	set @maxID = (select MAX(idCliente) + 1 from clientes);
	insert into clientes (
		idCliente,
		razSoc,
		direccion,
		idLocalid,
		idCondPago,
		idSitIVA,
		idVendedor,
		idTipoCli,
		idTransp,
		idTipoDoc,
		idRamo,
		nroCUIT,
		telefono,
		celular,
		fax,
		eMail,
		habilitado,
		mayorista,
		desc1,
		desc2,
		desc3,
		desc4,
		recargo,
		usuAlta,
		fecAlta,
		idHostAlta,
		envCbte,
		printCbte,
		mailFC,
		ctrMoro)
	values (
		@maxID,
		prazSoc,
		pdireccion,
		pidLocalid,
		pidCondPago,
		pidSitIVA,
		pidVendedor,
		pidTipoCli,
		pidTransp,
		pidTipoDoc,
		pidRamo,
		pnroCUIT,
		ptelefono,
		pcelular,
		pfax,
		peMail,
		phabilitado,
		pmayorista,
		pdesc1,
		pdesc2,
		pdesc3,
		pdesc4,
		precargo,
		pusuAlta,
		current_timestamp,
		pidHostAlta,
		penvCbte,
		pprintCbte,
		pmailFC,
		pctrMoro
		);
	commit;
	select @maxID as result;
end