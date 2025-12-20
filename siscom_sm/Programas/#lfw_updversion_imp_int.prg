*******************************************************************************
* Programa............: #lfw_updversion_imp_int.prg
* Descripción.........: Contiene instalación y/o actualización de base de datos
*						con lo que respecta a los impuestos internos.
* Autor...............: LINFOW - Leonardo D. Zulli
* Fecha...............: 27/10/2021
*******************************************************************************

PROCEDURE instalarCpoImpuIntArticulos
	**
	* Instalo los campos de impuestos internos en la tabla de artículos.
	**

	LOCAL lcSql
	LOCAL lcTabla
	lcTabla = "articulos"
	IF !existe_campo(lcTabla, "usarMonExt") THEN
		lcSql = "alter table articulos add usarMonExt bit not null default 0 after tmon; -- Indica si usa moneda extranjera"
		ejecutar_comando(lcSql)
	ENDIF
	
	IF !existe_campo(lcTabla, "usarImpuIn") THEN
		lcSql = "alter table articulos add usarImpuIn bit not null default 0 after prfinalMin; -- Indica si usa impuestos internos"
		ejecutar_comando(lcSql)
	ENDIF
	
	IF !existe_campo(lcTabla, "porImpuIn") THEN
		lcSql = "alter table articulos add porImpuIn decimal(5, 2) default 0 after usarImpuIn; -- Porcentaje de impuestos internos"
		ejecutar_comando(lcSql)
	ENDIF
	
	IF !existe_campo(lcTabla, "impImInMay") THEN
		lcSql = "alter table articulos add impImInMay decimal (20, 2) default 0 after porImpuIn; -- Importe de impuestos internos mayorista."
		ejecutar_comando(lcSql)
	ENDIF
	
	IF !existe_campo(lcTabla, "impImInMin") THEN
		lcSql = "alter table articulos add impImInMin decimal (20, 2) default 0 after impImInMay; -- Importe de impuestos internos minorista."
		ejecutar_comando(lcSql)
	ENDIF
ENDPROC

PROCEDURE instalarCpoImpuIntVentas
	**
	* Instalo el campo de impuestos internos en las tablas de ventas.
	**

	LOCAL lcSql
	
	IF !existe_campo("ventascab", "totaNoGrav") THEN
		lcSql = "alter table ventascab add totaNoGrav decimal(20, 2) not null default 0 after impDesc4; -- Total no gravado"
		ejecutar_comando(lcSql)
	ENDIF
	
	IF !existe_campo("ventasdet", "porNoGrav") THEN
		lcSql = "alter table ventasdet add porNoGrav decimal(5, 2) not null default 0 after impNeto; -- Porcentaje no gravado en el ítem."
		ejecutar_comando(lcSql)
	ENDIF
	
	IF !existe_campo("ventasdet", "baseGrav") THEN
		lcSql = "alter table ventasdet add baseGrav decimal(20, 2) not null default 0 after porNoGrav; -- Base gravada en el ítem. Queda igual a impNeto"
		ejecutar_comando(lcSql)
	ENDIF
	
	IF !existe_campo("ventasdet", "subtNoGrav") THEN
		WAIT WINDOW "Agregando campo subtNoGrav en ventasdet" NOWAIT
		lcSql = "alter table ventasdet add subtNoGrav decimal(20, 2) not null default 0 after baseGrav; -- Base no gravada en el ítem."
		ejecutar_comando(lcSql)
	ENDIF
ENDPROC
