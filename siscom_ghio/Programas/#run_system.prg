SET TALK OFF
SET DATE FRENCH
SET CENTURY ON
SET EXCLUSIVE OFF
SET MULTILOCKS ON
SET DEBUG ON

LOCAL lcPath

lcPath = SYS(5) + "\proyectos\linfow_gestion_src\Gestion\"

SET PATH TO lcPath + "CLASES\Ofertas"
SET PATH TO lcPath + "CLASES\Generics" ADDITIVE
SET PATH TO lcPath + "CLASES\data_services" ADDITIVE
SET PATH TO lcPath + "CLASES\Stock" ADDITIVE
SET PATH TO lcPath + "CLASES\FFC" ADDITIVE
SET PATH TO lcPath + "ofertas" ADDITIVE
SET PATH TO lcPath + "SISCOM_GHIO\Programas" ADDITIVE
SET PATH TO lcPath + "SISCOM_GHIO\Programas\Calculos" ADDITIVE
SET PATH TO lcPath + "SISCOM_GHIO\Menues" ADDITIVE
SET PATH TO lcPath + "SISCOM_GHIO\Formularios" ADDITIVE
SET PATH TO lcPath + "SISCOM_GHIO\Informes" ADDITIVE

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
SET CLASSLIB TO "procesos.vcx" ADDITIVE

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
PUBLIC gnDEMO

gnDEMO = "0"
lcWSADDR = GetConfig("WS_ADDR")
gcUrlWS = "http://www.lp-soft.com.ar/" + ALLTRIM(lcWSADDR) + "/pedidos_siscom.php?wsdl"
gcCodUsu = "SUPER"
glVersionBeta = .F.

goConn = CREATEOBJECT("odbc_connect")
*goConn.ConnectionString = "Driver=Microsoft Access Driver (*.mdb);uid=admin;pwd=;DBQ=data\siscom_g2.mdb"
goConn.ConnectionString = "DRIVER={MySQL ODBC 5.1 Driver};SERVER=localhost;PORT=3306;UID=root;PWD=l4ld81;DATABASE=siscom_dgc1;OPTION=3;"

IF !goConn.Open()
	MESSAGEBOX(goConn.ErrorMessage, 1+16, "Database Connection")
	RETURN .F.
ENDIF

*DO FORM "frmpedidos"
*DO FORM "frm_factura_fe"
*DO FORM "frm_ncdev_fe.scx"
*DO FORM "frm_imp_precios"
*DO FORM "frmConsBjaFC_SF"
*DO FORM "frm_imp_precios"
DO FORM "frm_xls_updater"
*DO FORM frm_xls_config
*DO FORM "frmabmclientes"
*DO FORM "frm_autoriza_cbte"
* DO FORM "frm_imp_c1"
*DO FORM "frmrecibos"
