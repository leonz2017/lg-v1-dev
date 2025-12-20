SET TALK OFF
SET DATE FRENCH
SET CENTURY ON
SET EXCLUSIVE OFF
SET MULTILOCKS ON
SET STATUS BAR OFF
SET SYSMENU OFF
SET BELL OFF
SET NULLDISPLAY TO ""
SET REPORTBEHAVIOR 80

SET CLASSLIB TO "odbc_library.vcx"
SET CLASSLIB TO "utilidades.vcx" 		ADDITIVE
SET CLASSLIB TO "winforms.vcx" 			ADDITIVE
SET CLASSLIB TO "zip.vcx" 				ADDITIVE
SET CLASSLIB TO "_therm" 				ADDITIVE
SET CLASSLIB TO "data_services.vcx" 	ADDITIVE
SET CLASSLIB TO "toolbars_gestion.vcx" 	ADDITIVE
SET CLASSLIB TO "ventas_sinfiscal.vcx" 	ADDITIVE
SET CLASSLIB TO "siscaja.vcx" 			ADDITIVE
SET CLASSLIB TO "stock.vcx" 			ADDITIVE
SET CLASSLIB TO "procesos.vcx" 			ADDITIVE
SET CLASSLIB TO "ofertas.vcx" 			ADDITIVE
SET CLASSLIB TO "sis_abms.vcx" 			ADDITIVE
SET CLASSLIB TO "compras.vcx" 			ADDITIVE
SET CLASSLIB TO "retiros_mrcs.vcx" 		ADDITIVE
SET CLASSLIB TO "vnd-comisiones.vcx" 	ADDITIVE
SET CLASSLIB TO "articulos.vcx" 		ADDITIVE
SET CLASSLIB TO "ventas-reports.vcx"	ADDITIVE
SET CLASSLIB TO "listados.vcx"			ADDITIVE
SET CLASSLIB TO "admincpas.vcx"			ADDITIVE
SET CLASSLIB TO "finanzas.vcx"			ADDITIVE
SET CLASSLIB TO "reparaciones.vcx"		ADDITIVE
SET CLASSLIB TO "dbmanager.vcx"			ADDITIVE
SET CLASSLIB TO "promociones.vcx"		ADDITIVE
Set Classlib To "automatizaciones.vcx"	Additive
Set Classlib To "update_version_utils.vcx" additive
SET CLASSLIB TO "ventas-procesos.vcx" ADDITIVE
SET CLASSLIB TO "logistica.vcx"			ADDITIVE && Módulo para emisión de remitos

SET PROCEDURE TO "ErrorTrap"					ADDITIVE	&& Capturador de errores inesperados
SET PROCEDURE TO "CalcularPorcentaje"			ADDITIVE	&& Permite calcular un porcentaje
SET PROCEDURE TO "calcular_costo"				ADDITIVE	&& Permite calcular el costo de reposicion
SET PROCEDURE TO "calcular_venta"				ADDITIVE	&& Permite calcular el precio de venta
SET PROCEDURE TO "getconfig"					ADDITIVE	&& Permite devolver el valor de una variable de configuracion
SET PROCEDURE TO "ftptools"						ADDITIVE	&& Contiene las utilidades para subir archivos por FTP
SET PROCEDURE TO "filetransfer"					ADDITIVE	&& Permite bajar archivos desde una dirección de internet
SET PROCEDURE TO "excel_module"					ADDITIVE	&& Genera una planilla de excel a partir de un cursor
SET PROCEDURE TO "genexcel"						ADDITIVE	&& Este programa lo entregó pablo por el tema de cuentas corrientes
SET PROCEDURE TO "getPtoVta"					ADDITIVE	&& Permite convertir el punto de venta a 4 dígitos para el muestro
SET PROCEDURE TO "getNroCbte"					ADDITIVE	&& Permite convertir el número de comprobante a 8 dígitos para el muestro de información
SET PROCEDURE TO "getglobalcfg"					ADDITIVE	&& Permite recuperar la configuración global
SET PROCEDURE TO "siscom_menu"					ADDITIVE	&& Permite confeccionar el menú normal dinamico
SET PROCEDURE TO "actu_listas"					ADDITIVE	&& Permite reconocer las rutinas de actualización de listas desde los catálogos
SET PROCEDURE TO "menu_abms"					ADDITIVE	&& Contiene los llamados a los formularios de ABMS
SET PROCEDURE TO "menu_compras"					ADDITIVE	&& Contiene los llamados a los formularios de compras
SET PROCEDURE TO "menu_procesos"				ADDITIVE	&& Contiene los llamados a los procesos
SET PROCEDURE TO "ftp"							ADDITIVE 	&& ftp_service para descargar precios de electrodiesel
SET PROCEDURE TO "enviar_mail"					ADDITIVE
SET PROCEDURE TO "funciones.prg"				ADDITIVE	&& Funciones
SET PROCEDURE TO "#lfw_updversion.prg"			ADDITIVE	&& Actualizar versión
SET PROCEDURE TO "#lfw_updversion_params.prg" 	ADDITIVE 	&& Parametros Global_CFG
SET PROCEDURE TO "cls_promociones.prg"			ADDITIVE	&& Referencia a la clase de promociones
SET PROCEDURE TO "#lfw_updversion_clientes"		ADDITIVE	&& Referencia a la actualización de versión de clientes.

SET PATH TO ".\data"					&& Hace referencia a la carpeta de datos
SET PATH TO ".\intercambio" ADDITIVE	&& Hace referencia a la carpeta de intercambios
SET PATH TO ".\upgrades" 	ADDITIVE	&& Se genera la referencia a la carpeta upgrades.

ON ERROR DO ErrorTrap WITH ERROR(), MESSAGE(), MESSAGE(1), PROGRAM(), LINENO()

_screen.Caption = "SISCOM"
_Screen.WindowState = 2
_Screen.Closable = .F.
_Screen.Icon = 'linfow_icon.ico'
_screen.BackColor = RGB(255,255,255)
_screen.Picture = "background.gif"

LOCAL lcOdbcCon
LOCAL lcToolBar
LOCAL lnPedNuevo
LOCAL lcWSADDR
LOCAL loCommand
LOCAL lcVersionActual

PUBLIC goConn
PUBLIC goFormMain
PUBLIC goFormLogin
PUBLIC gnUserID
PUBLIC gcCodUsu
PUBLIC gcUrlWS
PUBLIC glVersionBeta
PUBLIC gnDEMO
PUBLIC gcValueTrace 
PUBLIC gcConnectionString
PUBLIC glError

&& Incorporo esta variable porque necesito el proveedor seleccionad
&& en la factura de compra para poner como valor predeterminado
&& en el alta de artículo.
PUBLIC gnSelectedIdProv

***********************************************************************************
* Cambiar el siguiente parámetro para generar la versión beta a .T. o a .F. para el
* release
***********************************************************************************
glVersionBeta = .F.
lcOdbcCon = getconfig("ODBC_CONN")
lcToolBar = getconfig("TOOLBAR")
gnDEMO = getConfig("DEMO")
lcWSADDR = GetConfig("WS_ADDR")
gcUrlWS = "https://www.linfow.com.ar/" + ALLTRIM(lcWSADDR) + "/pedidos_siscom.php?wsdl"

goConn = CREATEOBJECT("odbc_connect")
goConn.ConnectionString = alltrim(lcOdbcCon)

IF !goConn.Open()
	MESSAGEBOX(goConn.ErrorMessage, 1+16, "Database Connection")
	RETURN .F.
ENDIF

gcConnectionString = SQLGETPROP(goConn.ActiveConnection,"ConnectString")

&& Busco actualización y si encuentra actualizo la versión
* lcVersionActual = actualizarVersion()

** Actualizar versión nuevo
loUpdateVersion = CreateObject("cls_update_version")
loUpdateVersion.actualizar_version()
lcVersionActual = loUpdateVersion.version_actual
* Fin del nuevo actualizar versión


goFormLogin = CREATEOBJECT("formLogin")
goFormLogin.show()

IF !goFormLogin.IsAccept
	goFormLogin.release()
	CLEAR ALL
	CLOSE DATABASES ALL
	QUIT
	RETURN .F.
ENDIF

_screen.Caption = "LINFOW GESTION " + ALLTRIM(lcVersionActual) + " - " + getconfig("NOMEMP") + " - Usuario Actual: " + ALLTRIM(gcCodUsu) + IIF(glVersionBeta, " - VERSION BETA", "")

PUBLIC hOpen, hFtpSession  
DECLARE INTEGER InternetOpen IN wininet.dll;   
    STRING  sAgent,;   
    INTEGER lAccessType,;   
    STRING  sProxyName,;   
    STRING  sProxyBypass,;   
    STRING  lFlags    

DECLARE INTEGER InternetCloseHandle IN wininet.dll; 
    INTEGER hInet   

DECLARE INTEGER InternetConnect IN wininet.dll;   
    INTEGER hInternetSession,;   
    STRING  sServerName,;   
    INTEGER nServerPort,;   
    STRING  sUsername,;   
    STRING  sPassword,;   
    INTEGER lService,;   
    INTEGER lFlags,;   
    INTEGER lContext   

DECLARE INTEGER FtpOpenFile IN wininet.dll; 
    INTEGER hFtpSession,; 
    STRING  sFileName,; 
    INTEGER lAccess,; 
    INTEGER lFlags,; 
    INTEGER lContext 

DECLARE INTEGER InternetWriteFile IN wininet.dll; 
    INTEGER   hFile,; 
    STRING  @ sBuffer,; 
    INTEGER   lNumBytesToWrite,; 
    INTEGER @ dwNumberOfBytesWritten 

IF ALLTRIM(getconfig("INIVERIFP")) == "S" THEN
	DO FORM "frmpedsiscli"
ENDIF

IF ALLTRIM(lcToolBar) == "ON"
	DO FORM "frmEscritorio"
ENDIF

IF getGlobalCFG("MODOMOST") THEN
	DO FORM "frm_actualizar_precios_final"
ENDIF

IF VAL(getconfig("SQLSRV")) = 1 THEN
	loCommand = CREATEOBJECT("odbc_command")
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = "SET DATEFORMAT dmy"

	IF !loCommand.Execute() THEN
		MESSAGEBOX(loCommand.ErrorMessage, 0+48, "Error de Inicio")
		QUIT
	ENDIF
ELSE
	IF VAL(getconfig("SQLSRV")) = 0 .AND. (!glVersionBeta) THEN
		IF getGlobalCFG("BINLOGFMT") THEN
			loCommand = CREATEOBJECT("odbc_command")
			loCommand.ActiveConnection = goConn.ActiveConnection
			loCommand.CommandText = "SET SESSION binlog_format='ROW';"

			IF !loCommand.Execute() THEN
				MESSAGEBOX(loCommand.ErrorMessage, 0+48, "Error de Inicio")
				QUIT
			ENDIF
		ENDIF
	ENDIF
ENDIF

DO "siscom_menu"
READ EVENTS
 

