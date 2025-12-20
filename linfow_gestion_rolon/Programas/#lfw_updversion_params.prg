*********************************************************************************************
* Programa......: #lfw_updversion_params.prg
* Descripción...: Contiene la actualización de los parámetros del sistema en global_cfg
* Fecha.........: 30/09/2021
* Autor.........: LINFOW - Leonardo D. Zulli
*********************************************************************************************

PROCEDURE agregarParametrosEmpresa
	************************************************
	* Agrego los parámetros con los datos de la
	* empresa. Esto se usa para los membretes de los
	* tickets
	************************************************
	addOrUpdateGlobalCFG("EMPFANT", "C", "REPUESTOS ROLON", .F.)
	addOrUpdateGlobalCFG("EMPRAZSOC", "C", "PRESENTADO BLANCA MARIA", .F.)
	addOrUpdateGlobalCFG("EMPCUIT", "C", "27-11606954-2", .T.)
	addOrUpdateGlobalCFG("EMPIIBB", "C", "27-11606954-2", .T.)
	addOrUpdateGlobalCFG("EMPDIREC", "C", "BOLIVAR 1777", .F.)
	addOrUpdateGlobalCFG("EMPCODPOS", "C", "2800", .F.)
	addOrUpdateGlobalCFG("EMPLOC", "C", "ZARATE", .F.)
	addOrUpdateGlobalCFG("EMPPCIA", "C", "BUENOS AIRES", .F.)
	addOrUpdateGlobalCFG("EMPINIACT", "C", "01/01/2005", .F.)
	addOrUpdateGlobalCFG("EMPIVA", "C", "IVA RESPONSABLE INSCRIPTO", .F.)
	addOrUpdateGlobalCFG("EMPIDIVA", "N", "1", .F.)
	addOrUpdateGlobalCFG("EMAILCC", "C", "repuestosrolonz@hotmail.com", .F.)
ENDPROC