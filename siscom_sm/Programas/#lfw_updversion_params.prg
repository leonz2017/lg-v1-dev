*******************************************************************************
* Programa............: #lfw_updversion_params.prg
* Descripción.........: Actualización de parametros en global_cfg
* Autor...............: LINFOW - Leonardo D. Zulli
* Fecha...............: 27/10/2021
*******************************************************************************

PROCEDURE agregarOActualizarParametros
	**
	* Agrega o actualiza los parámetros en global_cfg
	**	
	&& Actualizo la ruta de los scripts locales para versión desarrollo.
	addOrUpdateGlobalCFG("MODODESA", "L", "false", .F.) && Agrego modo desa pero que no se reemplace el valor al iniciar el sistema
		
	&& Si es modo desa hago que levante los scripts SQL localmente
	IF getGlobalCFG("MODODESA") THEN
		addOrUpdateGlobalCFG("UPDSQLLOC", "L", "true", .T.)
		addOrUpdateGlobalCFG("UPD_URL", "C", "http://localhost/upgrades/sm/", .T.)
		addOrUpdateGlobalCFG("UPDSQLPATH", "C", "D:\sistemas\lg-v1\sql", .T.)
		addOrUpdateGlobalCFG("TEMPDIR", "C", "D:\linfow-projects\temp\", .F.)
		** Agrego parámetros para sincronización de tickets en forma local o remota
		addOrUpdateGlobalCFG("FELOCAL", "L", "true", .F.)
		addOrUpdateGlobalCFG("FETKDIRFTP", "C", "", .F.)
		addOrUpdateGlobalCFG("FACPDFPATH", "C", "D:\sistemas\lg-v1\archivos-afip\cbtes\", .T.)		
	ELSE
		addOrUpdateGlobalCFG("UPDSQLLOC", "L", "false", .T.)
		addOrUpdateGlobalCFG("UPD_URL", "C", "http://www.linfow.com.ar/linfow_gestion_upgrades/sm/", .F.)
		* Agrego parámetro para directorio temporal
		addOrUpdateGlobalCFG("TEMPDIR", "C", "C:\SISCOM_SMC1\intercambio\", .F.)
		** Agrego parámetros para sincronización de tickets en forma local o remota
		addOrUpdateGlobalCFG("FELOCAL", "L", "true", .F.)
		addOrUpdateGlobalCFG("FETKDIRFTP", "C", "", .F.)
		addOrUpdateGlobalCFG("FACPDFPATH", "C", "C:\SISCOM_SMC1\wsafip\ComprobantesPDF\", .F.)
	ENDIF
	
	addOrUpdateGlobalCFG("UPD_EXEC1", "C", "siscom_smc1.exe", .F.)
	addOrUpdateGlobalCFG("UPD_EXEC2", "C", "siscom_smc2.exe", .F.)
	
	* Agrego los parmametros de Familias, subfamilia y marcas predeterminadas
	addOrUpdateGlobalCFG("UPDFAMDEF", "N", "24", .T.)
	addOrUpdateGlobalCFG("UPDSUBFDEF", "N", "534", .T.)
	addOrUpdateGlobalCFG("UPDMARDEF", "N", "233", .T.)
	
	* Agrego parámetros para FTP
	addOrUpdateGlobalCFG("FTPHOST", "C", "NADA", .F.)
	addOrUpdateGlobalCFG("FTPUSER", "C", "NADA", .F.)
	addOrUpdateGlobalCFG("FTPPASS", "C", "NADA", .F.)
	addOrUpdateGlobalCFG("FTPPORT", "C", "NADA", .F.)
	addOrUpdateGlobalCFG("FTPINIDIR", "C", "NADA", .F.)
	addOrUpdateGlobalCFG("USA_SFTP", "L", "true", .F.)
	
	* URL de actualizador
	addOrUpdateGlobalCFG("URLUPDATER", "C", "NADA", .F.)
	
	* Opciones de recibos
	addOrUpdateGlobalCFG("RCIMPSEL", "L", "true", .F.)
	
	* Agrego el parámetro que permite establecer si incluye IVA en el
	* presupuesto o no.
	addOrUpdateGlobalCFG("PTOINCIVA", "L", "false", .T.)
ENDPROC
