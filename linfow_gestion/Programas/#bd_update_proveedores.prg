*****************************************************************************************
* Cambio de estructuras en la tabla de proveedores.
*****************************************************************************************

PROCEDURE ampliarProvCampoTelefono
	LOCAL lcTabla
	LOCAL lcCampo
	LOCAL lcSql
	
	TEXT TO lcSql NOSHOW
		ALTER TABLE proveedor CHANGE COLUMN telefono telefono VARCHAR(100) NULL DEFAULT NULL 
	ENDTEXT
	ejecutar_comando(lcSql)
ENDPROC