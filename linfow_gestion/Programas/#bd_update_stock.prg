***************************************************************
* Programa #bd_update_stock
* 	Permite actualizar las estrucutras de tablas correspondiente
* 	al módulo de stock.
***************************************************************

PROCEDURE ampliarCamposStkCab
	*************************************************
	* Permite ampliar cambios correspondientes a la
	* cabecera de stock.
	*************************************************
	LOCAL lcSql
	
	TEXT TO lcSql NOSHOW
		ALTER TABLE stk_cab CHANGE COLUMN numCbte numCbte VARCHAR(20) NULL DEFAULT NULL 
	ENDTEXT
	ejecutar_comando(lcSql)	
ENDPROC

PROCEDURE generarCamposStkCab
	LOCAL lcSql
	
	TEXT TO lcSql NOSHOW
		ALTER TABLE stk_cab ADD IF NOT EXISTS id_ficha int NULL
	ENDTEXT
	ejecutar_comando(lcSql)	
ENDPROC