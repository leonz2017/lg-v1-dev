***************************************************************
* Configuro los parámetros de global_cfg para desarrollo
***************************************************************

SET TALK OFF
SET DATE FRENCH
SET CENTURY ON
SET EXCLUSIVE OFF
SET MULTILOCKS ON
SET DEBUG OFF

set path to sys(5) + "\sistemas\lg-v1\CLASES\Generics"
set path to sys(5) + "\sistemas\lg-v1\CLASES\data_services" additive
set path to sys(5) + "\sistemas\lg-v1\CLASES\Stock" additive
set path to sys(5) + "\sistemas\lg-v1\CLASES\FFC" additive
set path to sys(5) + "\sistemas\lg-v1\CLASES\ofertas" additive
set path to sys(5) + sys(2003) + "\Programas" additive
set path to sys(5) + sys(2003) + "\Programas\Calculos" additive
set path to sys(5) + sys(2003) + "\Menues" additive
set path to sys(5) + sys(2003) + "\Formularios" additive
set path to sys(5) + sys(2003) + "\Formularios\Compras" additive
set path to sys(5) + sys(2003) + "\Informes" additive

SET CLASSLIB TO "odbc_library.vcx"
SET CLASSLIB TO "utilidades.vcx" additive
SET CLASSLIB TO "winforms.vcx" additive
SET CLASSLIB TO "zip.vcx" additive
SET CLASSLIB TO "_therm" additive
SET CLASSLIB TO "data_services.vcx" additive
SET CLASSLIB TO "ventas_sinfiscal.vcx" additive
SET CLASSLIB TO "siscaja.vcx" additive
SET CLASSLIB TO "stock.vcx" ADDITIVE
SET CLASSLIB TO "ofertas.vcx" ADDITIVE
SET CLASSLIB TO "admincpas.vcx" ADDITIVE
SET CLASSLIB TO "procesos.vcx" ADDITIVE

SET PROCEDURE TO "ErrorTrap"			ADDITIVE	&& Capturador de errores inesperados
SET PROCEDURE TO "calcularporcentaje"	ADDITIVE	&& Calcula un porcentaje
SET PROCEDURE TO "filetransfer"			ADDITIVE	&& Permite bajar archivos desde una dirección de internet
SET PROCEDURE TO "getglobalcfg"			ADDITIVE	&& Permite recuperar la configuración global
SET PROCEDURE TO "funciones.prg"		ADDITIVE	&& Funciones
SET PROCEDURE TO "#lfw_updversion.prg"	ADDITIVE	&& Actualizar Versión

_screen.Caption = "LINFOW Gestion Tito DESA"
_Screen.WindowState = 2
_Screen.Closable = .F.

LOCAL loRes

PUBLIC goConn
PUBLIC goFormMain
PUBLIC goFormLogin
PUBLIC gnUserID
PUBLIC gcCodUsu
PUBLIC gcUrlWS
PUBLIC glVersionBeta

goConn = CREATEOBJECT("odbc_connect")
goConn.ConnectionString = "DRIVER={MySQL ODBC 5.1 Driver};SERVER=localhost;PORT=3306;UID=root;PWD=l4ld81;DATABASE=linfowgst_stc2;OPTION=3;"
WAIT WINDOW goConn.ActiveConnection NOWAIT
IF !goConn.Open()
	MESSAGEBOX(goConn.ErrorMessage, 1+16, "Database Connection")
	RETURN .F.
ENDIF

WAIT WINDOW "Configurando modo desarrollo" NOWAIT
&& Instalo los SPs iniciales
instalarSPInicial()

addOrUpdateGlobalCFG("FEDEBUG", "L", "true", .t.)
addOrUpdateGlobalCFG("FECUIT", "C", "20280456919", .t.)
addOrUpdateGlobalCFG("FE_FILE", "C", "20280456919.pfx", .t.)
addOrUpdateGlobalCFG("FE_LIC", "C", "", .t.)
addOrUpdateGlobalCFG("FE_PWD", "C", "2048", .t.)
addOrUpdateGlobalCFG("FE_TICKACC", "C", sys(5) + "\sistemas\lg-v1\archivos-afip\ticket\ticket.txt", .t.)
addOrUpdateGlobalCFG("FETLS", "N", "12", .t.)
addOrUpdateGlobalCFG("QRPATH", "C", sys(5) + "\sistemas\lg-v1\archivos-afip\qr\", .t.)
addOrUpdateGlobalCFG("FACPDFPATH", "C", sys(5) + "\sistemas\lg-v1\archivos-afip\cbtes\", .t.)
addOrUpdateGlobalCFG("UPD_URL", "C", "http://localhost/upgrades/st/", .t.)
addOrUpdateGlobalCFG("UPDSQLPATH", "C", sys(5) + "\sistemas\lg-v1\sql", .t.)
addOrUpdateGlobalCFG("UPDSQLLOC", "L", "true", .t.)
addOrUpdateGlobalCFG("MODODESA", "L", "true", .t.)

* Agrego parámetro para directorio temporal
addOrUpdateGlobalCFG("TEMPDIR", "C", sys(5) + "\Temp\", .F.)

* Agrego parámetros para FTP
addOrUpdateGlobalCFG("FTPHOST", "C", "", .T.)
addOrUpdateGlobalCFG("FTPUSER", "C", "", .T.)
addOrUpdateGlobalCFG("FTPPASS", "C", "", .T.)
addOrUpdateGlobalCFG("FTPPORT", "C", "", .T.)
addOrUpdateGlobalCFG("FTPINIDIR", "C", "", .T.)
addOrUpdateGlobalCFG("USA_SFTP", "L", "false", .T.)

* URL de actualizador
addOrUpdateGlobalCFG("URLUPDATER", "C", "NADA", .T.)

loRes = CREATEOBJECT("odbc_result")
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_config"
loRes.OpenQuery("SELECT * FROM global_cfg")
BROWSE
loRes.Close_Query()

WAIT WINDOW "Modo desarrollo listo" NOWAIT
goConn.Close()
