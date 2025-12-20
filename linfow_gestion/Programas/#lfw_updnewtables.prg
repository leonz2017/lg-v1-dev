***************************************************************
* Archivo: #lfw_updnewtables.prg
* Este archivo contiene las funciones que permiten crear
* tablas nuevas en la base de datos.
***************************************************************

*************************************************
* Permite crear la tabla art_exivapto en donde
* se almacenarán los artículos que no deben
* incluir IVA en presupuestos.
*************************************************
PROCEDURE upd_create_art_exivapto
	LOCAL lcSql
	
	TEXT TO lcSql NOSHOW
		CREATE TABLE IF NOT EXISTS art_exivapto (
			id int not null unique auto_increment,
			idArticulo int not null,
			habilitado bit not null default 1,
			usualta varchar(5) not null,
			fecalta datetime not null,
			idhostalta varchar(50) not null,
			usumodi varchar(5) null,
			fecmodi datetime null,
			idhostmodi varchar(50) null,
			usubaja varchar(5) null,
			fecbaja datetime null,
			idhostbaja varchar(50),
			PRIMARY KEY (id),
			FOREIGN KEY (idArticulo) REFERENCES articulos (idArticulo))
	ENDTEXT
	ejecutar_comando(lcSql)
ENDPROC