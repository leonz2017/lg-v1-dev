SET TALK OFF
SET DATE FRENCH
SET CENTURY ON
SET EXCLUSIVE OFF
SET MULTILOCKS ON
SET DEBUG ON

SET PATH TO SYS(5) + "\proyectos\linfow_gestion_src\CLASES\Generics"
SET PATH TO SYS(5) + "\proyectos\linfow_gestion_src\CLASES\data_services" ADDITIVE
SET PATH TO SYS(5) + "\proyectos\linfow_gestion_src\CLASES\Stock" ADDITIVE
SET PATH TO SYS(5) + "\proyectos\linfow_gestion_src\CLASES\FFC" ADDITIVE
SET PATH TO SYS(5) + "\proyectos\linfow_gestion_src\CLASES\ofertas" ADDITIVE
SET PATH TO SYS(5) + "\proyectos\linfow_gestion_src\linfow_gestion_rolon\Programas" ADDITIVE
SET PATH TO SYS(5) + "\proyectos\linfow_gestion_src\linfow_gestion_rolon\Programas\Calculos" ADDITIVE
SET PATH TO SYS(5) + "\proyectos\linfow_gestion_src\linfow_gestion_rolon\Menues" ADDITIVE
SET PATH TO SYS(5) + "\proyectos\linfow_gestion_src\linfow_gestion_rolon\Formularios" ADDITIVE
SET PATH TO SYS(5) + "\proyectos\linfow_gestion_src\linfow_gestion_rolon\Formularios\Compras" ADDITIVE
SET PATH TO SYS(5) + "\proyectos\linfow_gestion_src\linfow_gestion_rolon\Informes" ADDITIVE

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
* SET CLASSLIB TO "retiros_mrcs.vcx" 		ADDITIVE
SET CLASSLIB TO "vnd-comisiones.vcx" 	ADDITIVE
SET CLASSLIB TO "articulos.vcx" 		ADDITIVE
SET CLASSLIB TO "ventas-reports.vcx"	ADDITIVE
SET CLASSLIB TO "listados.vcx"			ADDITIVE
SET CLASSLIB TO "admincpas.vcx"			ADDITIVE
SET CLASSLIB TO "finanzas.vcx"			ADDITIVE
SET CLASSLIB TO "reparaciones.vcx"		ADDITIVE

SET PROCEDURE TO "ErrorTrap"			ADDITIVE	&& Capturador de errores inesperados
SET PROCEDURE TO "calcularporcentaje"	ADDITIVE	&& Calcula un porcentaje
SET PROCEDURE TO "filetransfer"			ADDITIVE	&& Permite bajar archivos desde una dirección de internet
SET PROCEDURE TO "getglobalcfg"			ADDITIVE	&& Permite recuperar la configuración global

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
goConn.ConnectionString = "DRIVER={MySQL ODBC 5.1 Driver};SERVER=localhost;PORT=3306;UID=root;PWD=l4ld81;DATABASE=linfowgst_rolonc1;OPTION=3;"
WAIT WINDOW goConn.ActiveConnection
IF !goConn.Open()
	MESSAGEBOX(goConn.ErrorMessage, 1+16, "Database Connection")
	RETURN .F.
ENDIF

*DO FORM "frmabmarticulos"
*DO FORM "frm_factura_fe"
*DO FORM "frm_ncdev_fe.scx"
*DO FORM "frm_orden_pago"
*DO FORM "frm_autoriza_cbte"
*DO FORM "frm_xls_updater_v2"
DO FORM "frm_pto_c2"
*DO FORM "frm_ctacte_fe"
*DO FORM frm_cpas_ingcbte
*DO FORM form_pedido_online