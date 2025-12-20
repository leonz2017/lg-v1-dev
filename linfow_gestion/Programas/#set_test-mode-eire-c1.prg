***************************************************************
* Configuro los parámetros de global_cfg para desarrollo
***************************************************************

SET TALK OFF
SET DATE FRENCH
SET CENTURY ON
SET EXCLUSIVE OFF
SET MULTILOCKS ON
SET DEBUG OFF

SET PATH TO SYS(5) + "\proyectos\linfow_gestion_src\Gestion\CLASES\Generics"
SET PATH TO SYS(5) + "\proyectos\linfow_gestion_src\Gestion\CLASES\data_services" ADDITIVE
SET PATH TO SYS(5) + "\proyectos\linfow_gestion_src\Gestion\CLASES\Stock" ADDITIVE
SET PATH TO SYS(5) + "\proyectos\linfow_gestion_src\Gestion\CLASES\FFC" ADDITIVE
SET PATH TO SYS(5) + "\proyectos\linfow_gestion_src\Gestion\CLASES\ofertas" ADDITIVE
SET PATH TO SYS(5) + "\proyectos\linfow_gestion_src\Gestion\siscom_mg\Programas" ADDITIVE
SET PATH TO SYS(5) + "\proyectos\linfow_gestion_src\Gestion\siscom_mg\Programas\Calculos" ADDITIVE
SET PATH TO SYS(5) + "\proyectos\linfow_gestion_src\Gestion\siscom_mg\Menues" ADDITIVE
SET PATH TO SYS(5) + "\proyectos\linfow_gestion_src\Gestion\siscom_mg\Formularios" ADDITIVE
SET PATH TO SYS(5) + "\proyectos\linfow_gestion_src\Gestion\siscom_mg\Formularios\Compras" ADDITIVE
SET PATH TO SYS(5) + "\proyectos\linfow_gestion_src\Gestion\siscom_mg\Informes" ADDITIVE

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
goConn.ConnectionString = "DRIVER={MySQL ODBC 5.1 Driver};SERVER=localhost;PORT=3306;UID=root;PWD=l4ld81;DATABASE=linfowgst_eirec1;OPTION=3;"
WAIT WINDOW goConn.ActiveConnection NOWAIT
IF !goConn.Open()
	MESSAGEBOX(goConn.ErrorMessage, 1+16, "Database Connection")
	RETURN .F.
ENDIF

WAIT WINDOW "Configurando modo desarrollo" NOWAIT
&& Instalo los SPs iniciales
instalarSPInicial()

addOrUpdateGlobalCFG("FEDEBUG", "L", "true", .T.)
addOrUpdateGlobalCFG("FECUIT", "C", "20280456919", .T.)
addOrUpdateGlobalCFG("FE_FILE", "C", "20280456919.pfx", .T.)
addOrUpdateGlobalCFG("FE_LIC", "C", "", .T.)
addOrUpdateGlobalCFG("FE_PWD", "C", "2048", .T.)
addOrUpdateGlobalCFG("FE_TICKACC", "C", "\\192.168.1.250\compartido\linfow\gestion\ticket_desa\ticket.txt", .T.)
addOrUpdateGlobalCFG("FETLS", "N", "12", .T.)
addOrUpdateGlobalCFG("QRPATH", "C", "\\192.168.1.250\compartido\linfow\qr\", .T.)
addOrUpdateGlobalCFG("FACPDFPATH", "C", "\\192.168.1.250\compartido\linfow\gestion\Cbtes\", .T.)
addOrUpdateGlobalCFG("UPDSQLPATH", "C", "d:\proyectos\linfow_gestion_src\Gestion\sql", .T.)
addOrUpdateGlobalCFG("UPDSQLLOC", "L", "true", .T.)
addOrUpdateGlobalCFG("MODODESA", "L", "true", .T.)

* Agrego parámetro para directorio temporal
addOrUpdateGlobalCFG("TEMPDIR", "C", "D:\Temp\", .F.)

* Agrego parámetros para FTP
addOrUpdateGlobalCFG("FTPHOST", "C", "localhost", .T.)
addOrUpdateGlobalCFG("FTPUSER", "C", "leonardo", .T.)
addOrUpdateGlobalCFG("FTPPASS", "C", "l4ld81", .T.)
addOrUpdateGlobalCFG("FTPPORT", "C", "21", .T.)
addOrUpdateGlobalCFG("FTPINIDIR", "C", "wp/mgcarburacion/mg_server_updater/data/Temp", .T.)
addOrUpdateGlobalCFG("USA_SFTP", "L", "false", .T.)

* URL de actualizador
addOrUpdateGlobalCFG("URLUPDATER", "C", "", .T.)

loRes = CREATEOBJECT("odbc_result")
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_config"
loRes.OpenQuery("SELECT * FROM global_cfg")
BROWSE
loRes.Close_Query()

WAIT WINDOW "Configurando base de clientes para desarrollo" NOWAIT
TEXT TO lcSql NOSHOW
	UPDATE
		clientes
	SET
		clientes.envCbte = 0,
		clientes.mailFC = "info@linfow.com.ar",
		clientes.printCbte = 0
ENDTEXT
ejecutar_comando(lcSql)

WAIT WINDOW "Modo desarrollo listo" NOWAIT
goConn.Close()
