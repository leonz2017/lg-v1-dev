* ************************************************
* Este procedimiento permite registrar un LOG
* de procesamiento en un archivo de texto.
* ************************************************
PARAMETERS tcAsunto, tcModulo, tcRegistro
LOCAL lnHandler
LOCAL lcMensaje
LOCAL lcSaltoLin
LOCAL lnSize

lcMensaje = ""
lcSaltoLin = CHR(13) + CHR(10)

IF FILE("SISCOM_Log.log") THEN
	lnHandler = FOPEN("SISCOM_Log.log", 2)
	lnSize = FSEEK(lnHandler, 0, 2)
	lcMensaje = FREAD(lnHandler, lnSize)
ELSE
	lnHandler = FCREATE("SISCOM_Log.log")
	lcMensaje = ""
ENDIF

lcMensaje = lcMensaje + "Módulo: " + ALLTRIM(tcModulo) + lcSaltoLin
lcMensaje = lcMensaje + "Fecha: " + DTOC(DATETIME()) + lcSaltoLin
lcMensaje = lcMensaje + "Asunto: " + ALLTRIM(tcAsunto) + lcSaltoLin
lcMensaje = lcMensaje + ALLTRIM(tcRegistro) + lcSaltoLin
lcMensaje = lcMensaje + "---------------> Fin Registro <---------------------------------" + lcSaltoLin + lcSaltoLin

=FWRITE(lnHandler, lcMensaje)
=FCLOSE(lnHandler)


