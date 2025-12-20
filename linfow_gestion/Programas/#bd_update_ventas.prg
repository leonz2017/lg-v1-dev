*********************************************************
* Permite actualizar el módulo de ventas.
* Fecha: 15/10/2022
* Autor: Leonardo D. Zull
*********************************************************

Procedure vta_agregar_ventasdet_tmp
	Local lcSql

	TEXT TO lcSql NOSHOW
		CREATE TABLE IF NOT EXISTS ventasdet_tmp (
			id			int auto_increment,
			idArticulo	int,
			cantidad	decimal(20, 2) 	DEFAULT 0,
			cantNC		decimal(20, 2) 	DEFAULT 0,
			costoRep	decimal(20, 2) 	DEFAULT 0,
			prArtic		decimal(20, 2) 	DEFAULT 0,
			prVenta		decimal(20, 2) 	DEFAULT 0,
			porDesc1	decimal(5, 2) 	DEFAULT 0,
			porDesc2	decimal(5, 2) 	DEFAULT 0,
			porDesc3	decimal(5, 2) 	DEFAULT 0,
			porDesc4	decimal(5, 2) 	DEFAULT 0,
			impDesc1	decimal(20, 2) 	DEFAULT 0,
			impDesc2	decimal(20, 2) 	DEFAULT 0,
			impDesc3	decimal(20, 2) 	DEFAULT 0,
			impDesc4	decimal(20, 2) 	DEFAULT 0,
			pDtoVta1	decimal(5, 2) 	DEFAULT 0,
			pDtoVta2	decimal(5, 2) 	DEFAULT 0,
			pDtoVta3	decimal(5, 2) 	DEFAULT 0,
			pDtoVta4	decimal(5, 2) 	DEFAULT 0,
			iDtoVta1	decimal(20, 2) 	DEFAULT 0,
			iDtoVta2	decimal(20, 2) 	DEFAULT 0,
			iDtoVta3	decimal(20, 2) 	DEFAULT 0,
			iDtoVta4	decimal(20, 2) 	DEFAULT 0,
			impNeto		decimal(20, 2) 	DEFAULT 0,
			porNoGrav	decimal(5,2) 	DEFAULT 0,
			baseGrav	decimal(20,2) 	DEFAULT 0,
			subtNoGrav	decimal(20,2) 	DEFAULT 0,
			totNeto		decimal(20, 2) 	DEFAULT 0,
			alicIVA		decimal(5, 2) 	DEFAULT 0,
			impIVA		decimal(20, 2) 	DEFAULT 0,
			subTotal	decimal(20, 2) 	DEFAULT 0,
			nroPart		varchar(30),
			esOferta	bit 			DEFAULT 0,
			pRecVta		decimal(5, 2) 	DEFAULT 0,
			iRecVta		decimal(20, 2) 	DEFAULT 0,
			UniDesp		decimal(20, 2) 	DEFAULT 0,
			cantPack	decimal(20, 2) 	DEFAULT 0,
			codUM		varchar(3),
			cant_pri1	decimal(20, 2) 	DEFAULT 0,
			cant_pri2	decimal(20, 2) 	DEFAULT 0,
			cant_pri3	decimal(20, 2) 	DEFAULT 0,
			descripcio	varchar(200),
			cant_falt	decimal(20, 2) 	DEFAULT 0,
			pRecItem	decimal(5, 2) 	DEFAULT 0,
			iRecItem	decimal(20, 2) 	DEFAULT 0,
			usuario		varchar(5),
			host		varchar(50),
			PRIMARY KEY (id)) ENGINE=MyISAM
	ENDTEXT
	ejecutar_comando(lcSql)
Endproc

Procedure vta_agregar_tabla_alicivas
*********************************************************
* Agrego tabla de alícuotas de IVA para autorización de
* AFIP.
* Fecha: 26/12/2022
* Desarrollado por: Leonardo D. Zulli
*********************************************************
	Local lcSql
	TEXT TO lcSql NOSHOW
		CREATE TABLE IF NOT EXISTS alic_ivas (
				id_aliciva int NOT NULL unique auto_increment,
				alicuota decimal(5, 2) NOT NULL,
				id_afip int NOT NULL,
			PRIMARY KEY (id_aliciva))
	ENDTEXT
	ejecutar_comando(lcSql)
Endproc

Procedure vta_insert_alic_ivas
*********************************************************
* Cargo los registros de IVA en la tabla alic_ivas.
*********************************************************
	Local lcSql
	lcSql = "CALL alic_ivas_agregar(21, 5)"
	ejecutar_comando(lcSql)
	lcSql = "CALL alic_ivas_agregar(10.5, 4)"
	ejecutar_comando(lcSql)
	lcSql = "CALL alic_ivas_agregar(0, 3)"
	ejecutar_comando(lcSql)
Endproc

Procedure vta_addCpoVentasDet
*********************************************************
* Agrega campo en la tabla ventasdet.
*********************************************************
	Local lcSql

	If !existe_campo("ventasdet", "cant_pri1") Then
		lcSql = "ALTER TABLE ventasdet ADD cant_pri1 decimal(20, 2) default 0"
		ejecutar_comando(lcSql)
	Endif

	If !existe_campo("ventasdet", "cant_pri2") Then
		lcSql = "ALTER TABLE ventasdet ADD cant_pri2 decimal(20, 2) default 0"
		ejecutar_comando(lcSql)
	Endif

	If !existe_campo("ventasdet", "cant_pri3") Then
		lcSql = "ALTER TABLE ventasdet ADD cant_pri3 decimal(20, 2) default 0"
		ejecutar_comando(lcSql)
	Endif

	If !existe_campo("ventasdet", "cant_falt") Then
		lcSql = "ALTER TABLE ventasdet ADD cant_falt decimal(20, 2) default 0"
		ejecutar_comando(lcSql)
	Endif
Endproc

Procedure instalar_tabla_pedext_invalidos
*********************************************************************
* Permite agregar una tabla vinculada a pedext para los ítems
* inválidos.
*********************************************************************
	Local lcSql
	
	Text To lcSql Noshow
		Create Table If Not Exists pedextinv (
			id int not null unique auto_increment,
			idPedCab int not null,
			idCliente int not null,
			idArticulo int null,
			idVentasC int null,
			fecEmis datetime,
			codArt varchar(20),
			cantidad decimal(10, 5),
			observ text null,
			tipoSist int not null,
			primary Key(id),
			Foreign Key (idCliente) References clientes (idCliente),
			Foreign Key (idArticulo) References articulos (idArticulo))
	EndText
	
	ejecutar_comando(lcSql)
EndProc
