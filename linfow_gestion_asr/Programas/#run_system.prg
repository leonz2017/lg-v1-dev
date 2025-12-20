SET TALK OFF
SET DATE FRENCH
SET CENTURY ON
SET EXCLUSIVE OFF
SET MULTILOCKS ON
SET DEBUG ON

SET PATH TO SYS(5) + "\proyectos\linfow_gestion_src\Gestion\CLASES\Generics"
SET PATH TO SYS(5) + "\proyectos\linfow_gestion_src\Gestion\CLASES\data_services" ADDITIVE
SET PATH TO SYS(5) + "\proyectos\linfow_gestion_src\Gestion\CLASES\Stock" ADDITIVE
SET PATH TO SYS(5) + "\proyectos\linfow_gestion_src\Gestion\CLASES\FFC" ADDITIVE
SET PATH TO SYS(5) + "\proyectos\linfow_gestion_src\Gestion\CLASES\ofertas" ADDITIVE
SET PATH TO SYS(5) + "\proyectos\linfow_gestion_src\Gestion\linfow_gestion_asr\Programas" ADDITIVE
SET PATH TO SYS(5) + "\proyectos\linfow_gestion_src\Gestion\linfow_gestion_asr\Programas\Calculos" ADDITIVE
SET PATH TO SYS(5) + "\proyectos\linfow_gestion_src\Gestion\linfow_gestion_asr\Menues" ADDITIVE
SET PATH TO SYS(5) + "\proyectos\linfow_gestion_src\Gestion\linfow_gestion_asr\Formularios" ADDITIVE
SET PATH TO SYS(5) + "\proyectos\linfow_gestion_src\Gestion\linfow_gestion_asr\Formularios\Compras" ADDITIVE
SET PATH TO SYS(5) + "\proyectos\linfow_gestion_src\Gestion\linfow_gestion_asr\Informes" ADDITIVE

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
SET PROCEDURE TO "funciones.prg"		ADDITIVE

DEBUG
&& SET STEP ON
&& SET ECHO ON
ACTIVATE WINDOW trace
&&ON ERROR DO ErrorTrap WITH ERROR(), MESSAGE(), MESSAGE(1), PROGRAM(), LINENO()

_screen.Caption = "GESTION MySQL"
_Screen.WindowState = 2
_Screen.Closable = .F.

LOCAL loCommand

PUBLIC goConn
PUBLIC goFormMain
PUBLIC goFormLogin
PUBLIC gnUserID
PUBLIC gcCodUsu
PUBLIC gcUrlWS
PUBLIC glVersionBeta

lcWSADDR = GetConfig("WS_ADDR")
gcUrlWS = "http://www.lp-soft.com.ar/" + ALLTRIM(lcWSADDR) + "/pedidos_siscom.php?wsdl"
gcCodUsu = "SUPER"
glVersionBeta = .F.

goConn = CREATEOBJECT("odbc_connect")
goConn.ConnectionString = "DRIVER={MySQL ODBC 5.1 Driver};SERVER=localhost;PORT=3306;UID=root;PWD=l4ld81;DATABASE=linfowgst_titoc1;OPTION=3;"
IF !goConn.Open()
	MESSAGEBOX(goConn.ErrorMessage, 1+16, "Database Connection")
	RETURN .F.
ENDIF

&& Actualizo los cambios en la base de datos.
&& Esta actualización se ejecuta siempre porque a veces puede que
&& haga un ajuste en algún SP sin necesidad de pisar el ejecutable.
WAIT WINDOW "Actualizando base..." NOWAIT
=checkSqlDirectory()		&& Verifico si el directorio de scripts existe sino lo crea.
&& Solo instalo los scripts si el sistema está en producción.
WAIT WINDOW "Base actualizada" NOWAIT

DO FORM "frmabmarticulos"
*DO FORM "frm_factura_fe"
*DO FORM "frm_ncdev_fe.scx"
*DO FORM "frm_orden_pago"
*DO FORM "frm_autoriza_cbte"
*DO FORM "frm_xls_updater_v2"
*DO FORM "frm_pto_c2"
*DO FORM "frm_ctacte_fe"
*DO FORM frm_cpas_ingcbte
*DO FORM form_pedido_online
*DO FORM frmrecibos
*DO FORM frmctacte