**********************************************************************
* Programa: #lfw_acomodar_datos.prg
* Permite verificar y acomodar datos si es necesario
* Autor: LINFOW - Leonardo D. Zulli
* Fecha: 23/10/2021
**********************************************************************

PROCEDURE verificar_impImInMin_en_articulos
	LOCAL lcSql
	
	lcSql = "UPDATE articulos SET impImInMin = 0 WHERE impImInMin IS NULL"
	ejecutar_comando(lcSql)
ENDPROC