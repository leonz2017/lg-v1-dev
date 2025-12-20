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
goConn.ConnectionString = "DRIVER={MySQL ODBC 5.1 Driver};SERVER=localhost;PORT=3306;UID=root;PWD=l4ld81;DATABASE=linfowgst_dsac2;OPTION=3;"
WAIT WINDOW goConn.ActiveConnection NOWAIT
IF !goConn.Open()
	MESSAGEBOX(goConn.ErrorMessage, 1+16, "Database Connection")
	RETURN .F.
ENDIF

WAIT WINDOW "Configurando modo desarrollo" NOWAIT
&& Instalo los SPs iniciales
instalarSPInicial()
addOrUpdateGlobalCFG("MODODESA", "L", "true", .T.)
ejecutar_comando(lcSql)

WAIT WINDOW "Modo desarrollo listo" NOWAIT
goConn.Close()

