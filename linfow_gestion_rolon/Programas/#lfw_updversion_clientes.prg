*********************************************************
* Crea las tablas necesarias para clasificar clientes
* Fecha: 16/06/2023
*********************************************************
PROCEDURE actualizar_clientes
	***************************************************
	* Actualiza las estructuras de las tablas de clientes.
	***************************************************
	actualizar_tabla_tiposcli()
	instalarOperacionesClasifClientes()
ENDPROC

PROCEDURE actualizar_tabla_tiposcli
	******************************************************
	* Agrego la tabla de crédito máximo en tipos de clientes para
	* clasificarlos.
	******************************************************
	LOCAL lcSql
	
	IF !existe_campo("tiposcli", "credmax_dd") THEN
		** Agrego el campo de crédito máximo en tipo de clientes
		TEXT TO lcSql NOSHOW
			ALTER TABLE tiposcli
				ADD COLUMN credmax_dd DECIMAL(20, 2) NOT NULL DEFAULT 0 AFTER descripcio
		ENDTEXT
		ejecutar_comando(lcSql)
	ENDIF
	
	IF !existe_campo("tiposcli", "credmax_hh") THEN
		** Agrego el campo de crédito máximo en tipo de clientes
		TEXT TO lcSql NOSHOW
			ALTER TABLE tiposcli ADD credmax_hh DECIMAL(20, 2) NOT NULL DEFAULT 0 AFTER credmax_dd
		ENDTEXT
		ejecutar_comando(lcSql)
	ENDIF
ENDPROC

PROCEDURE instalarOperacionesClasifClientes()
	******************************************************
	* Agrego los menues del módulo de clasificación de
	* clientes.
	******************************************************
	LOCAL lcSql
	
	IF INT(VAL(getConfig("DEMO"))) = 0 THEN
		* Paso por acá si es C1
		TEXT TO lcSql NOSHOW
			CALL agregar_menu ('5.13', '\\-', '', 1, 5,  '', 5013)
		ENDTEXT
		ejecutar_comando(lcSql)

		TEXT TO lcSql NOSHOW
			CALL agregar_menu ('5.14', 'Clasificar clientes', 'DO FORM frm_form_clasificar_clientes', 1, 5,  '', 5014)
		ENDTEXT
		ejecutar_comando(lcSql)
	ELSE
		* Paso por acá si es C2
		TEXT TO lcSql NOSHOW
			CALL agregar_menu ('2.14', '\\-', '', 1, 2,  '', 2014)
		ENDTEXT
		ejecutar_comando(lcSql)

		TEXT TO lcSql NOSHOW
			CALL agregar_menu ('2.15', 'Clasificar clientes', 'DO FORM frm_form_clasificar_clientes', 1, 2,  '', 2015)
		ENDTEXT
		ejecutar_comando(lcSql)	
	ENDIF
ENDPROC