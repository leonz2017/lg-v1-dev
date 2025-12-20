******************************************************************
* Permite actualizar la versión de base de datos de pagos
******************************************************************

PROCEDURE actualizar_version_pagos
	*************************************************************
	* Permite actualizar la versión del módulo de pagos a
	* proveedores.
	*************************************************************
	agregarCampoImpPag_ordPagDC()
ENDPROC

PROCEDURE agregarCampoImpPag_ordPagDC
	*************************************************************
	* Permite agregar campos en la tabla ordpag_dc
	* vinculación de ordenes de pagos con comprobantes.
	*************************************************************
	LOCAL lcSql
	TEXT TO lcSql NOSHOW
		ALTER TABLE ordpag_dc ADD IF NOT EXISTS imppag DECIMAL(20, 2) NOT NULL DEFAULT 0
	ENDTEXT
	ejecutar_comando(lcSql)
ENDPROC