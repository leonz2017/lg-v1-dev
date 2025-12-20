**********************************************************
* Módulo de ordenes de trabajo
* Este script permite actualizar el módulo.
* Fecha: 21/12/2023
**********************************************************
PROCEDURE actualizar_ordenes_trabajo
	******************************************************
	* Permite actualizar el módulo de ordenes de trabajo
	******************************************************
	crear_tabla_ordenes_trabajo()
	ot_agregar_campos_baja()
ENDPROC

PROCEDURE crear_tabla_ordenes_trabajo
	************************************************************
	* Permite crear la tabla donde se guardarán las órdenes
	* de trabajo.
	************************************************************
	LOCAL lcSql
	
	TEXT TO lcSql NOSHOW
		CREATE TABLE IF NOT EXISTS ordtrabajo (
			id int not null unique auto_increment,
			idCliente int not null,
			fecha datetime not null default current_timestamp,
			cantidad decimal(10, 2) not null default 1,
			detalle varchar(60) not null,
			precio decimal(20, 2) not null,
			facturado bit not null default 0,
			usuAlta varchar(5) not null,
			fecAlta datetime not null default current_timestamp,
			idHostAlta varchar(50) not null,
			usuModi varchar(5) null,
			fecModi datetime null,
			idHostModi varchar(50) null,
			PRIMARY KEY (id),
			FOREIGN KEY (idCliente) REFERENCES clientes (idCliente)
		)Engine=InnoDB
	ENDTEXT
	ejecutar_comando(lcSql)
ENDPROC

PROCEDURE ot_agregar_campos_baja
	IF !existe_campo("ordtrabajo", "usuBaja") THEN
		lcSql = "ALTER TABLE ordtrabajo ADD usuBaja varchar(5) NULL"
		ejecutar_comando(lcSql)
	ENDIF
	
	IF !existe_campo("ordtrabajo", "fecBaja") THEN
		lcSql = "ALTER TABLE ordtrabajo ADD fecBaja datetime NULL"
		ejecutar_comando(lcSql)
	ENDIF

	IF !existe_campo("ordtrabajo", "idHostBaja") THEN
		lcSql = "ALTER TABLE ordtrabajo ADD idHostBaja varchar(50) NULL"
		ejecutar_comando(lcSql)
	ENDIF
ENDPROC
