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
SET PATH TO SYS(5) + "\proyectos\linfow_gestion_src\Gestion\linfow_gestion_dsa\Programas" ADDITIVE
SET PATH TO SYS(5) + "\proyectos\linfow_gestion_src\Gestion\linfow_gestion_dsa\Programas\Calculos" ADDITIVE
SET PATH TO SYS(5) + "\proyectos\linfow_gestion_src\Gestion\linfow_gestion_dsa\Menues" ADDITIVE
SET PATH TO SYS(5) + "\proyectos\linfow_gestion_src\Gestion\linfow_gestion_dsa\Formularios" ADDITIVE
SET PATH TO SYS(5) + "\proyectos\linfow_gestion_src\Gestion\linfow_gestion_dsa\Formularios\Compras" ADDITIVE
SET PATH TO SYS(5) + "\proyectos\linfow_gestion_src\Gestion\linfow_gestion_dsa\Informes" ADDITIVE

SET CLASSLIB TO "odbc_library.vcx"
SET CLASSLIB TO "data_services.vcx" ADDITIVE
SET CLASSLIB TO "sis_abms.vcx" ADDITIVE
SET CLASSLIB TO "utilidades.vcx" ADDITIVE
SET CLASSLIB TO "winforms.vcx" ADDITIVE
SET CLASSLIB TO "zip.vcx" ADDITIVE
SET CLASSLIB TO "_therm" ADDITIVE
SET CLASSLIB TO "ventas_sinfiscal.vcx" ADDITIVE
SET CLASSLIB TO "siscaja.vcx" ADDITIVE
SET CLASSLIB TO "stock.vcx" ADDITIVE
SET CLASSLIB TO "ofertas.vcx" ADDITIVE
SET CLASSLIB TO "admincpas.vcx" ADDITIVE
SET CLASSLIB TO "procesos.vcx" ADDITIVE
SET CLASSLIB TO "promociones.vcx" ADDITIVE

SET PROCEDURE TO "ErrorTrap"			ADDITIVE	&& Capturador de errores inesperados
SET PROCEDURE TO "calcularporcentaje"	ADDITIVE	&& Calcula un porcentaje
SET PROCEDURE TO "filetransfer"			ADDITIVE	&& Permite bajar archivos desde una dirección de internet
SET PROCEDURE TO "getglobalcfg"			ADDITIVE	&& Permite recuperar la configuración global
SET PROCEDURE TO "funciones.prg"		ADDITIVE
SET PROCEDURE TO "cls_promociones.prg"	ADDITIVE

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
goConn.ConnectionString = "DRIVER={MySQL ODBC 5.1 Driver};SERVER=localhost;PORT=3306;UID=root;PWD=l4ld81;DATABASE=linfowgst_desac1;OPTION=3;"
IF !goConn.Open()
	MESSAGEBOX(goConn.ErrorMessage, 1+16, "Database Connection")
	RETURN .F.
ENDIF

=actualizarSPs()

*DO FORM "frmabmarticulos"
*DO FORM "frm_factura_fe"
*DO FORM "frm_ncdev_fe.scx"
*DO FORM "frm_orden_pago"
*DO FORM "frm_autoriza_cbte"
*DO FORM "frm_xls_updater_v2"
*DO FORM "frm_pto_c2"
*DO FORM "frm_ctacte_fe"
*DO FORM frm_cpas_ingcbte
*DO FORM form_pedido_online
*DO FORM frm_control_precios
DO FORM frm_abm_promociones