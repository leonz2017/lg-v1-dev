******************************************************************************************
* Programa............: #lfw_acomodar_datos.prg
* Descripción.........: Acomoda datos de la base los que posiblemente genere algún hueco.
* Autor...............: LINFOW - Leonardo D. Zulli
* Fecha...............: 27/10/2021
******************************************************************************************

PROCEDURE acomodarDtosArticulos
	**
	* Acomoda datos de artículos de los que por lo general se viene generando algún dato en blanco al
	* arrancar el sistema.
	**
	LOCAL lcSql
	lcSql = "UPDATE articulos SET tmon = 'PSO' WHERE tmon = '' AND prListaExt = 0"
	ejecutar_comando(lcSql)
	
	&& Agrego función para que marque usarMonExt en 1 a los que tienen tmon <> 'PSO' porque este
	&& campo es nuevo
	lcSql = "UPDATE articulos SET usarMonExt = 1 WHERE tmon <> 'PSO'"
	ejecutar_comando(lcSql)
ENDPROC

PROCEDURE acomodarMFSDescripcionBlanco
	LOCAL lcSql
	
	* Acomoda marcas con descripción en blanco.
	lcSql = "UPDATE marcas SET descripcio = 'SIN DEFINIR O VARIOS' WHERE descripcio = ''"
	ejecutar_comando(lcSql)
	
	* Acomodo familias con descripción en blanco.
	lcSql = "UPDATE familias SET descripcio = 'SIN DEFINIR O VARIOS' WHERE descripcio = ''"
	ejecutar_comando(lcSql)
	
	* Acomodo subfamilias con descripción en blanco.
	lcSql = "UPDATE subfam SET descripcio = 'SIN DEFINIR O VARIOS' WHERE descripcio = ''"
	ejecutar_comando(lcSql)
ENDPROC