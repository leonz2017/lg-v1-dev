PROCEDURE VFPHTTP
LPARAMETER cURL, cNameFich
*** Definición de constantes básicas
#DEFINE INTERNET_OPEN_TYPE_PRECONFIG 0
#DEFINE INTERNET_OPEN_TIPE_PROXY 3
#DEFINE INTERNET_FLAG_RELOAD 2147483648

*** Declaración de funciones del API
DECLARE LONG GetLastError ;
	IN WIN32API
	
DECLARE INTEGER InternetCloseHandle ;
	IN "wininet.dll" ;
	LONG     hInet
	
DECLARE LONG InternetOpen ;
	IN "wininet.dll" ;
	STRING   lpszAgent, ;
	LONG     dwAccessType, ;
	STRING   lpszProxyName, ;
	STRING   lpszProxyBypass, ;
	LONG     dwFlags
	
DECLARE LONG InternetOpenUrl ;
	IN "wininet.dll" LONG hInet, STRING lpszUrl, STRING lpszHeaders, ;
    LONG    dwHeadersLength, LONG dwFlags, LONG dwContext
    
DECLARE LONG InternetReadFile IN "wininet.dll" LONG hFtpSession, ;
	STRING  @lpBuffer, LONG dwNumberOfBytesToRead, LONG @lpNumberOfBytesRead
	
	
*** Apertura
nInternet = InternetOpen("pruebavfp", INTERNET_OPEN_TYPE_PRECONFIG, "", "", 0 )

IF nInternet = 0
	MESSAGEBOX( "Error: " + LTRIM(STR(GetLastError())) + " en InternetOpen.", 16 )
	RETURN
ENDIF

*** Abrir el URL
nFichHTTP = InternetOpenUrl (nInternet, cUrl, NULL, 0, INTERNET_FLAG_RELOAD, 0 )
IF nFichHTTP = 0
	MESSAGEBOX( "Error: " + LTRIM(STR(GetLastError())) + ", verificar conexión a internet.", 16 )
	InternetCloseHandle( nInternet )
	RETURN
ENDIF
*** Abrir el fichero en el cliente
nFich = FCREATE( cNameFich )
*** Contruir las variables necesarias
nTama = 0
nLen = 1
*** Bucle de lectura
DO WHILE nLen # 0
	cBuffer = REPLICATE( CHR(0), 4096 )
	*** Leer del fichero en el servidor
	InternetReadFile(nFichHTTP, @cBuffer, LEN( cBuffer ), @nLen) 

	*** Escribir el fichero en el cliente
	FWRITE(nFich,SUBSTR( cBuffer, 1, nLen ))
	*** Aumentar el tamaño total
	nTama = nTama + nLen
	
	WAIT WIND "Des. " + ALLTRIM(cNameFich) + " " + ALLTRIM(STR(nTama / 1024)) + " Kb ..." NOWAIT
ENDDO
WAIT CLEAR

*** Cerrar el fichero local
FCLOSE( nFich )

*** Cierre del uso del API
InternetCloseHandle( nInternet )
InternetCloseHandle( nFichHTTP )
ENDPROC

&& --------------------------------------------------------------
&& Esta rutina se utiliza para abrir programas desde
&& visual foxpro

FUNCTION ShellExec
LPARAMETER lcLink, lcAction, lcParms

	lcAction = IIF(EMPTY(lcAction), "Open", lcAction)
	lcParms = IIF(EMPTY(lcParms), "", lcParms)
	
	DECLARE INTEGER ShellExecute ;
	IN SHELL32.dll ;
	INTEGER nWinHandle, ;
	STRING cOperation, ;
	STRING cFileName, ;
	STRING cParameters, ;
	STRING cDirectory, ;
	INTEGER nShowWindow

	DECLARE INTEGER FindWindow ;
	IN WIN32API ;
	STRING cNull,STRING cWinName
	RETURN ShellExecute(FindWindow(0, _SCREEN.caption), ;
	lcAction, lcLink, ;
	lcParms, SYS(2023), 1)
ENDFUNC