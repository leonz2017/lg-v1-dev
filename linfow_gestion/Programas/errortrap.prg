PARAMETERS merror, mensaje1, mensaje2, mprog, mlineno

LOCAL lFormError
LOCAL lcError
LOCAL lcWSMail
LOCAL lnResult
LOCAL lcValueTrace
LOCAL lcSalto
LOCAL lcMensaje

lnResult = 0
lcWSMail = ""
lcError = ""
lcValueTrace = gcValueTrace 
lcSalto = CHR(13) + CHR(10)
lcMensaje = "Cliente: " + ALLTRIM(getConfig("NOMEMP")) + ;
	" - HostName: " + ALLTRIM(SYS(0)) + ;
	" - Usuario: " + ALLTRIM(Iif(!Empty(gcCodUsu), gcCodUsu, "")) + ;
	lcSalto + lcSalto

* Verifico si el error es por impresora apagada o desconectada
if merror = 1958 .or. merror = 1957 then
	messagebox("Verifique que su impresora esté encendida o disponible en la red. Ingrese en consulta y baja de comprobantes para reimprimirlo.", ;
		0+48, "Mensaje del sistema")
	return .t.
endif

* Verifica el error que genera cuando se pierde la conexión después de un tiempo inactivo
* el uso del sistema.
if merror = 1466 then
	return .t.
endif

* Esta validación surgió cuando se actualiza desde catálogo en el DERCLI.
if merror = 1705 then
	messagebox(lcError + ". El archivo está siendo usado por otra aplicación", 0+48, "Mensaje del sistema")
	return .t.
endif

* Verifico si hay un problema de conexión al servidor web, que no muestre nada
if merror = 1429 then
	MESSAGEBOX("Hubo un error al intentar comunicarse con el webservice de ARCA", 0+16, "Mensaje del sistema")
	RETURN .t.
endif

IF merror = 11 .AND. mprog == "CLS_DATA_PEDIDOS_ONLINE.DESCARGAR_PEDIDOS_SISCLI" THEN
	messagebox(lcError + "Hubo un microcorte de internet al intentar conectarse al hosting.", 0+48, "Mensaje del sistema")
	RETURN .t.
endif

IF merror = 11 .AND. mprog == "CLS_DATA_PEDIDOS_ONLINE.DESCARGAR_PEDIDOS_WEB" THEN
	messagebox(lcError + "Hubo un microcorte de internet al intentar conectarse al hosting.", 0+48, "Mensaje del sistema")
	RETURN .t.
ENDIF

* Agrego la verificación de errores capturados de MySQL
IF merror = -1000 THEN
	IF goConn.transaccion_iniciada THEN
		goConn.rollback()
		lcError = "La última operación que quizo realizar no se pudo concretar, sugerencias: " + CHR(10) + CHR(13) ;
			+ "1. Revisar que el movimiento no se haya generado erroneamente. " + CHR(10) + CHR(13) ;
			+ "2. Realzar la operación nuevamente." + CHR(10) + CHR(13) ;
			+ "3. Si el error persiste reinicie el servidor."
		MESSAGEBOX(lcError, 0+16, "Mensaje del sistema")
		RETURN .T.
	ENDIF
ENDIF

&& Agrego verificación de cuando genera error el OCX de Facturación Electrónica
IF merror = 1426 THEN
	lcError = "Ha ocurrido un error al intentar enviar el comprobante a ARCA por problemas de tipos de datos. " + CHR(10) + CHR(13) ;
		+ "Posibles problemas: " + CHR(10) + CHR(13) ;
		+ "1. El número de CUIT del cliente tiene algún caracter que no es numérico. " + CHR(10) + CHR(13) ;
		+ "2. Intente hacer nuevamente el comprobante y asegurese de que los datos están todos correctos. " + CHR(10) + CHR(13) ;
		+ "3. Asegurese de que la unidad compartida esté accesible desde la PC que intenta emitir el comprobante. " + CHR(10) + CHR(13) ;
		+ "Si el error persiste comuniquese con soporte indicando el número de cliente al que se le quizo facturar"
	MESSAGEBOX(lcError, 0+16, "Mensaje del sistema")
	
	&& Verifico que no haya quedado una transacción iniciada
	IF goConn.transaccion_iniciada THEN
		goConn.Rollback()
	ENDIF
	
	RETURN .T.
ENDIF

IF merror = 125 THEN
	&& Verifico que no haya quedado una transacción iniciada
	IF goConn.transaccion_iniciada THEN
		goConn.Rollback()
	ENDIF

	lcError = "Verifique que la impresora y/o ticketeadora se encuentre encendida y accesible." + CHR(10) + CHR(13) ;
		+ "Posbles problemas: " + CHR(10) + CHR(13) ;
		+ " 1. La impresora / ticketadora se encuentra apagada." + CHR(10) + CHR(13) ;
		+ " 2. Revise si la impresora se encuentra configurada en Windows." + lcSalto ;
		+ " 3. Verifique la el dispositivo esté disponible en la red"
	
	RETURN .T.
ENDIF

lcError = "Error Number: " + LTRIM(STR(merror)) + CHR(13) + CHR(10)
lcError = lcError + "Mensaje de Error: " + mensaje1 + CHR(13) + CHR(10)
lcError = lcError + "Línea de Código del error: " + mensaje2 + CHR(13) + CHR(10)
lcError = lcError + "Número de línea: " + LTRIM(STR(mlineno)) + CHR(13) + CHR(10)
lcError = lcError + "Programa con el error: " + mprog

lcMensaje = lcMensaje + "Se ha reportado el siguiente error: " + lcSalto 
lcMensaje = lcMensaje + "***********************************************************************************************" + lcSalto
lcMensaje = lcMensaje + lcError + lcSalto
lcMensaje = lcMensaje + "***********************************************************************************************" + lcSalto + lcSalto
lcMensaje = lcMensaje + lcValueTrace + lcSalto
lcMensaje = lcMensaje + "***********************************************************************************************" + lcSalto + lcSalto
lcMensaje = lcMensaje + "Enviado por el sistema LINFOW GESTION."

* Solo mando el mail si estoy en modo de producción.
IF !getGlobalCFG("MODODESA") THEN
	DO LOCFILE("FoxyPreviewer.App")
	WITH _screen.oFoxyPreviewer	
		.cEmailType = "HTML"
		.nEmailMode = 2
		.cEMailTo = "info@linfow.com.ar"
		.cSMTPServer = getGlobalCFG("EMAILSMTP")
		.cEmailFrom = getGlobalCFG("EMAILADDR")
		.cEMailSubject = "Error del sistema"
		.nSMTPPort = getGlobalCFG("EMAILPORT")
		.lSMTPUseSSL = getGlobalCFG("EMAILSSL")
		.cSMTPUserName = getGlobalCFG("EMAILUSR")
		.cSMTPPassword = getGlobalCFG("EMAILPWD")
		.lReadReceipt  = .F.
		.lPriority = .F.
		.cEmailBody = lcMensaje
		.SendEmailUsingCDO("")
	ENDWITH
	DO LOCFILE("FoxyPreviewer.App") WITH "Release"
ENDIF

MESSAGEBOX(lcMensaje, 0+16, "Error de sistema")
RETURN .T.