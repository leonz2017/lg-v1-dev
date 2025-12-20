************************************************************************************
* Proceso que permite actualizar los precios a partir del DERCLI
************************************************************************************
PROCEDURE proc_dercli
PARAMETERS tnIdProv, tnDesc1, tnDesc2, tnDesc3, tnDesc4, tnMargenMay, tnMargenMin
	LOCAL _DERCLI
	
	_DERCLI = CREATEOBJECT("actu_dercli_v2")
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
	
	_TOMMASI= CREATEOBJECT("actu_tommasi_v3")
	_TOMMASI.path = "C:\TOMMASIW\"
	_TOMMASI.alic_iva = 21
	_TOMMASI.desc1 = tnDesc1
	_TOMMASI.desc2 = tnDesc2
	_TOMMASI.desc3 = tnDesc3
	_TOMMASI.desc4 = tnDesc4
	_TOMMASI.margenmay = tnMargenMay
	_TOMMASI.margenmin = tnMargenMin
	_TOMMASI.idProv = tnIdProv
	_TOMMASI.Open()
	
	IF !_TOMMASI.grabar() THEN
		MESSAGEBOX(_TOMMASI.Error_Message, 0+48, "Actualización de Listas")
	ENDIF
	
	MESSAGEBOX("Actualización finalizada",0+64,"Info")
ENDPROC

************************************************************************************
* Proceso que permite actualizar los precios a partir del SISCLI
************************************************************************************
PROCEDURE proc_mg
PARAMETERS tnIdProv, tnDesc1, tnDesc2, tnDesc3, tnDesc4, tnMargenMay, tnMargenMin
	LOCAL _DERCLI
	
	_DERCLI = CREATEOBJECT("actu_siscli")
	_DERCLI.path = "C:\SISCLI\DATOS\"
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

