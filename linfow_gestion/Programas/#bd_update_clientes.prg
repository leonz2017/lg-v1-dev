****************************************************
* Cambios en la tabla de clientes
****************************************************


** Amplia el campo teléfono de la tabla clientes
PROCEDURE ampliarClienteCampoTelefono
	LOCAL lcTabla
	LOCAL lcCampo
	LOCAL lcSql
	
	TEXT TO lcSql NOSHOW
		ALTER TABLE clientes CHANGE COLUMN telefono telefono VARCHAR(100) NULL DEFAULT NULL 
	ENDTEXT
	ejecutar_comando(lcSql)
ENDPROC