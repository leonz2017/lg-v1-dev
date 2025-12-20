****************************************************
* Este programa permite actualizar las estructuras
* de las tablas del módulo de caja.
* Fecha: 14/10/2022
* Autor: Leonardo D. Zulli
****************************************************

PROCEDURE cja_agregarCampos
	LOCAL lcSql
	
	IF !existe_campo("movcjarel", "idCC_Cli") THEN
		TEXT TO lcSql NOSHOW
			ALTER TABLE movcjarel
				ADD idCC_Cli INT NULL
		ENDTEXT
		ejecutar_comando(lcSql)
	ENDIF
ENDPROC