******************************************************************
* Funciones de llamado para ejecutar procesos de actualizaciones
******************************************************************
PROCEDURE proc_arze
PARAMETERS tnIdProv, tnDesc1, tnDesc2, tnDesc3, tnDesc4, tnMargenMay, tnMargenMin
	LOCAL _ARZE

	_ARZE = CREATEOBJECT("actu_arze")
	
	_ARZE.alic_iva = 21
	_ARZE.idprov = tnIdProv
	_ARZE.desc1 = tnDesc1
	_ARZE.desc2 = tnDesc2
	_ARZE.desc3 = tnDesc3
	_ARZE.desc4 = tnDesc4
	_ARZE.margen_may = tnMargenMay
	_ARZE.margen_min = tnMargenMin
	
	_ARZE.nombre_archivo = "C:\siscom_listados\ARZE.xls"
	
	IF !_ARZE.open() THEN
		MESSAGEBOX(_ARZE.ErrorMessage, 0+48, "Actualización de Listas")
	ENDIF
	
	IF !_ARZE.grabar() THEN
		MESSAGEBOX(_ARZE.ErrorMessage,0+48, "Actualización de Listas")
	ENDIF	
	MESSAGEBOX("Actualización finalizada",0+64,"Info")
ENDPROC

************************************************************************************
* Proceso de actualización de la lista de ITUPER
************************************************************************************
PROCEDURE proc_ituper
PARAMETERS tnIdProv, tnDesc1, tnDesc2, tnDesc3, tnDesc4, tnMargenMay, tnMargenMin
	LOCAL _ITUPER
	
	_ITUPER = CREATEOBJECT("actualiza_ituper")

	_ITUPER.alic_iva = 21
	_ITUPER.idprov = tnIdProv
	_ITUPER.access_path = "C:\siscom_listados"
	_ITUPER.desc1 = tnDesc1
	_ITUPER.desc2 = tnDesc2
	_ITUPER.desc3 = tnDesc3
	_ITUPER.desc4 = tnDesc4
	_ITUPER.margen_may = tnMargenMay
	_ITUPER.margen_min = tnMargenMin
	
	IF !_ITUPER.procesar() THEN
		MESSAGEBOX(_ITUPER.Error_message, 0+48, "Actualización de Listas")
	ENDIF
	
	MESSAGEBOX("Actualización finalizada",0+64,"Info")
ENDPROC

************************************************************************************
* Proceso que permite actualizar los precios a partir del DERCLI
************************************************************************************
PROCEDURE proc_dercli
PARAMETERS tnIdProv, tnDesc1, tnDesc2, tnDesc3, tnDesc4, tnMargenMay, tnMargenMin
	LOCAL _DERCLI
	
	_DERCLI = CREATEOBJECT("actu_dercli")
	_DERCLI.path = "C:\DERCLI6\DATOS\"
	_DERCLI.alic_iva = 21
	_DERCLI.desc1 = tnDesc1
	_DERCLI.desc2 = tnDesc2
	_DERCLI.desc3 = tnDesc3
	_DERCLI.desc4 = tnDesc4
	_DERCLI.margenmay = tnMargenMay
	_DERCLI.margenmin = tnMargenMin
	_DERCLI.idProv = tnIdProv
	_DERCLI.Open()
	
	IF !_DERCLI.grabar() THEN
		MESSAGEBOX(_DERCLI.Error_Message, 0+48, "Actualización de Listas")
	ENDIF
	
	MESSAGEBOX("Actualización finalizada",0+64,"Info")
ENDPROC

************************************************************************************
* Este proceso permite actualizar la lista de TOMMASI
************************************************************************************

PROCEDURE proc_tommasi
PARAMETERS tnIdProv,tnDesc1,tnDesc2, tnDesc3, tnDesc4, tnMargenMay, tnMargenMin
	LOCAL _TOMMASI
	
	_TOMMASI = CREATEOBJECT("actu_tommasi")
	_TOMMASI.alic_iva = 21
	_TOMMASI.desc1 = tnDesc1
	_TOMMASI.desc2 = tnDesc2
	_TOMMASI.desc3 = tnDesc3
	_TOMMASI.desc4 = tnDesc4
	_TOMMASI.margen_may = tnMargenMay
	_TOMMASI.margen_min = tnMargenMin
	_TOMMASI.idProv = tnIdProv
	
	IF !_TOMMASI.actualizar_articulos() THEN
		MESSAGEBOX(_TOMMASI.Error_Message, 0+48, "Actualización de Listas")
	ENDIF
	
	MESSAGEBOX("Actualización finalizada",0+64,"Info")
ENDPROC


************************************************************************************
* El siguiente proceso permite actualizar la lista correspondiente al sisurbana
************************************************************************************
PROCEDURE proc_sisurbana
PARAMETERS tnIdProv, tnBonif1, tnBonif2, tnBonif3, tnBonif4, tnMargenMax, tnMargenMin
	LOCAL _URBANA
	
	_URBANA = CREATEOBJECT("actu_sisurbana")
	_URBANA.idProv = tnIdProv
	_URBANA.dto1 = tnBonif1
	_URBANA.dto2 = tnBonif2
	_URBANA.dto3 = tnBonif3
	_URBANA.dto4 = tnBonif4
	_URBANA.rentab1 = tnMargenMax
	_URBANA.rentab2 = tnMargenMin
	_URBANA.crear_cursor()
	_URBANA.leer_articulos()
	
	IF !_URBANA.grabar() THEN
		MESSAGEBOX(_URBANA.ErrorMessage, 0+48, "Actualización de Listas")
	ENDIF
	
	MESSAGEBOX("Actualización finalizada",0+64,"Info")
ENDPROC

*************************************************************************************
* El siguiente proceso permite actualizar la lista de pagano
*************************************************************************************
PROCEDURE proc_pagano
PARAMETERS tnIdProv, tnBonif1, tnBonif2, tnBonif3, tnBonif4, tnMargenMax, tnMargenMin
	LOCAL _pagano
	
	_pagano = CREATEOBJECT("actutxt_pagano")
	_pagano.idProv = tnIdProv
	_pagano.dto1 = tnBonif1
	_pagano.dto2 = tnBonif2
	_pagano.dto3 = tnBonif3
	_pagano.dto4 = tnBonif4
	_pagano.margenMay = tnMargenMax
	_pagano.margenMin = tnMargenMin
	_pagano.crear_cursor()
	
	IF !_pagano.grabar() THEN
		MESSAGEBOX(_pagano.ErrorMessage, 0+48, "Actualización de listas")
	ENDIF
	
	MESSAGEBOX("Actualización finalizada",0+64,"Info")
ENDPROC

************************************************************************************
* Este proceso permite actualizar la lista de ELECTRODIESEL
************************************************************************************
PROCEDURE proc_electrodiesel
PARAMETERS tnIdProv,tnDesc1,tnDesc2, tnDesc3, tnDesc4, tnMargenMay, tnMargenMin
	LOCAL _ELECTRODIESEL
	
	_ELECTRODIESEL= CREATEOBJECT("actu_electrodiesel")
	_ELECTRODIESEL.path = SYS(5)+SYS(2003) + "\data\"
	_ELECTRODIESEL.alic_iva = 21
	_ELECTRODIESEL.desc1 = tnDesc1
	_ELECTRODIESEL.desc2 = tnDesc2
	_ELECTRODIESEL.desc3 = tnDesc3
	_ELECTRODIESEL.desc4 = tnDesc4
	_ELECTRODIESEL.margenmay = tnMargenMay
	_ELECTRODIESEL.margenmin = tnMargenMin
	_ELECTRODIESEL.idProv = tnIdProv
	
	IF !_ELECTRODIESEL.actualizar_articulos() THEN
		MESSAGEBOX(_ELECTRODIESEL.Error_Message, 0+48, "Actualización de Listas")
	ENDIF
	
	MESSAGEBOX("Actualización finalizada",0+64,"Info")
ENDPROC

************************************************************************************
* Este proceso permite actualizar la lista de TRESSOLS
************************************************************************************
PROCEDURE proc_tressols
PARAMETERS tnIdProv,tnDesc1,tnDesc2, tnDesc3, tnDesc4, tnMargenMay, tnMargenMin
	LOCAL _TRESSOLS
	
	_TRESSOLS= CREATEOBJECT("actu_tressols")
	_TRESSOLS.path = SYS(5)+SYS(2003) + "\data\"
	_TRESSOLS.alic_iva = 21
	_TRESSOLS.desc1 = tnDesc1
	_TRESSOLS.desc2 = tnDesc2
	_TRESSOLS.desc3 = tnDesc3
	_TRESSOLS.desc4 = tnDesc4
	_TRESSOLS.margenmay = tnMargenMay
	_TRESSOLS.margenmin = tnMargenMin
	_TRESSOLS.idProv = tnIdProv
	
	IF !_TRESSOLS.actualizar_articulos() THEN
		MESSAGEBOX(_TRESSOLS.Error_Message, 0+48, "Actualización de Listas")
	ENDIF
	
	MESSAGEBOX("Actualización finalizada",0+64,"Info")
ENDPROC


************************************************************************************
* Este proceso permite actualizar la lista de CROMOSOL
************************************************************************************
PROCEDURE proc_cromosol
PARAMETERS tnIdProv,tnDesc1,tnDesc2, tnDesc3, tnDesc4, tnMargenMay, tnMargenMin
	LOCAL _CROMOSOL
	
	_CROMOSOL= CREATEOBJECT("actu_cromosol")
	_CROMOSOL.path = SYS(5)+SYS(2003) + "\data\"
	&&_CROMOSOL.alic_iva = 21 -- lo levanta por articulo
	_CROMOSOL.desc1 = tnDesc1
	_CROMOSOL.desc2 = tnDesc2
	_CROMOSOL.desc3 = tnDesc3
	_CROMOSOL.desc4 = tnDesc4
	_CROMOSOL.margenmay = tnMargenMay
	_CROMOSOL.margenmin = tnMargenMin
	_CROMOSOL.idProv = tnIdProv
	
	IF !_CROMOSOL.actualizar_articulos() THEN
		MESSAGEBOX(_CROMOSOL.Error_Message, 0+48, "Actualización de Listas")
	ENDIF
	
	MESSAGEBOX("Actualización finalizada",0+64,"Info")
ENDPROC


************************************************************************************
* Este proceso permite actualizar la lista de BBA
************************************************************************************
PROCEDURE proc_bba
PARAMETERS tnIdProv,tnDesc1,tnDesc2, tnDesc3, tnDesc4, tnMargenMay, tnMargenMin
	LOCAL _BBA
	
	_BBA= CREATEOBJECT("actu_bba")
	_BBA.path = SYS(5)+SYS(2003) + "\data\"
	&&_BBA.alic_iva = 21 -- lo levanta por articulo
	_BBA.desc1 = tnDesc1
	_BBA.desc2 = tnDesc2
	_BBA.desc3 = tnDesc3
	_BBA.desc4 = tnDesc4
	_BBA.margenmay = tnMargenMay
	_BBA.margenmin = tnMargenMin
	_BBA.idProv = tnIdProv
	
	IF !_BBA.actualizar_articulos() THEN
		MESSAGEBOX(_BBA.Error_Message, 0+48, "Actualización de Listas")
	ENDIF
	
	MESSAGEBOX("Actualización finalizada",0+64,"Info")
ENDPROC


************************************************************************************
* Este proceso permite actualizar la lista de DM
************************************************************************************
PROCEDURE proc_dm
PARAMETERS tnIdProv,tnDesc1,tnDesc2, tnDesc3, tnDesc4, tnMargenMay, tnMargenMin
	LOCAL _DM
	
	_DM= CREATEOBJECT("actu_dm")
	_DM.path = SYS(5)+SYS(2003) + "\data\"
	&&_DM.alic_iva = 21 -- lo levanta por articulo
	_DM.desc1 = tnDesc1
	_DM.desc2 = tnDesc2
	_DM.desc3 = tnDesc3
	_DM.desc4 = tnDesc4
	_DM.margenmay = tnMargenMay
	_DM.margenmin = tnMargenMin
	_DM.idProv = tnIdProv
	
	IF !_DM.actualizar_articulos() THEN
		MESSAGEBOX(_DM.Error_Message, 0+48, "Actualización de Listas")
	ENDIF
	
	MESSAGEBOX("Actualización finalizada",0+64,"Info")
ENDPROC


************************************************************************************
* Este proceso permite actualizar la lista de EXPOYER
************************************************************************************
PROCEDURE proc_expoyer
PARAMETERS tnIdProv,tnDesc1,tnDesc2, tnDesc3, tnDesc4, tnMargenMay, tnMargenMin
	LOCAL _EXPOYER
	
	_EXPOYER= CREATEOBJECT("actu_expoyer")
	_EXPOYER.path = SYS(5)+SYS(2003) + "\data\"
	&&_EXPOYER.alic_iva = 21 -- lo levanta por articulo
	_EXPOYER.desc1 = tnDesc1
	_EXPOYER.desc2 = tnDesc2
	_EXPOYER.desc3 = tnDesc3
	_EXPOYER.desc4 = tnDesc4
	_EXPOYER.margenmay = tnMargenMay
	_EXPOYER.margenmin = tnMargenMin
	_EXPOYER.idProv = tnIdProv
	
	IF !_EXPOYER.actualizar_articulos() THEN
		MESSAGEBOX(_EXPOYER.Error_Message, 0+48, "Actualización de Listas")
	ENDIF
	
	MESSAGEBOX("Actualización finalizada",0+64,"Info")
ENDPROC