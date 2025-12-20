&& Esta función verifica si tengo conexión a internet.

*!*	DECLARE LONG InternetGetConnectedState IN "wininet.dll" LONG lpdwFlags, LONG dwReserved
*!*	IF     InternetGetConnectedState(0, 0) = 1 THEN
*!*	    * El equipo está conectado a Internet
*!*	    RETURN .T.
*!*	ELSE
*!*	    * El equipo NO está conectado a Internet
*!*	    &&MESSAGEBOX("Esta PC no se encuentra conectada a Internet. Verifique su conexión y vuelva a intentarlo.",0+16,"Error")
*!*	    RETURN .F.
*!*	ENDIF

LOCAL tcURL

tcURL = "https://www.linfow.com.ar"

DECLARE INTEGER InternetCheckConnection in "wininet.dll";
                STRING lpszUrl,;
                INTEGER dwFlags,;
                INTEGER dwReserved

WAIT WINDOW "Chequeando si hay conexión a internet" NOWAIT
IF InternetCheckConnection(tcURL, 1, 0) == 1 THEN 
    * El equipo está conectado a Internet
    RETURN .T.
ELSE
    * El equipo NO está conectado a Internet
    RETURN .F.
ENDIF
