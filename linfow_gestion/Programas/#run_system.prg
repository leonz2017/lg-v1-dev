SET TALK OFF
SET DATE FRENCH
SET CENTURY ON
SET EXCLUSIVE OFF
SET MULTILOCKS ON
SET DEBUG ON

SET PATH TO SYS(5) + "\sistemas\lg-v1\clases\Generics"
SET PATH TO SYS(5) + "\sistemas\lg-v1\clases\data_services" ADDITIVE
SET PATH TO SYS(5) + "\sistemas\lg-v1\clases\Stock" ADDITIVE
SET PATH TO SYS(5) + "\sistemas\lg-v1\clases\FFC" ADDITIVE
SET PATH TO SYS(5) + "\sistemas\lg-v1\clases\ofertas" ADDITIVE
SET PATH TO SYS(5) + "\sistemas\lg-v1\linfow_gestion\Programas" ADDITIVE
SET PATH TO SYS(5) + "\sistemas\lg-v1\linfow_gestion\Programas\Calculos" ADDITIVE
SET PATH TO SYS(5) + "\sistemas\lg-v1\linfow_gestion\Programas\Menues" ADDITIVE
SET PATH TO SYS(5) + "\sistemas\lg-v1\linfow_gestion\Formularios" ADDITIVE
SET PATH TO SYS(5) + "\sistemas\lg-v1\linfow_gestion\Formularios\Compras" ADDITIVE
SET PATH TO SYS(5) + "\sistemas\lg-v1\linfow_gestion\Informes" ADDITIVE

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
SET CLASSLIB TO "admincpas.vcx"		ADDITIVE
SET CLASSLIB TO "finanzas.vcx"			ADDITIVE
SET CLASSLIB TO "reparaciones.vcx"		ADDITIVE
SET CLASSLIB TO "ventas_v2.vcx"		ADDITIVE	&& Módulo de ventas para autoservicios (mostrador)
SET CLASSLIB TO "ventas_on_line.vcx" ADDITIVE

SET PROCEDURE TO "ErrorTrap"			ADDITIVE	&& Capturador de errores inesperados
SET PROCEDURE TO "calcularporcentaje"	ADDITIVE	&& Calcula un porcentaje
SET PROCEDURE TO "filetransfer"			ADDITIVE	&& Permite bajar archivos desde una dirección de internet
SET PROCEDURE TO "getglobalcfg"			ADDITIVE	&& Permite recuperar la configuración global
SET PROCEDURE TO "funciones.prg"		ADDITIVE
SET PROCEDURE TO "#bd_update_clientes.prg" ADDITIVE
SET PROCEDURE TO "#bd_update_proveedores.prg" ADDITIVE
SET PROCEDURE TO "#lfw_updversion_cou.prg" ADDITIVE
SET PROCEDURE TO "#lfw_updversion.prg"	ADDITIVE
SET PROCEDURE TO "#lfw_updnewtables.prg"	ADDITIVE
SET PROCEDURE TO "#bd_update_clientes.prg" ADDITIVE && Actualizaciones en tabla de clientes
SET PROCEDURE TO "#bd_update_proveedores.prg" ADDITIVE && Actualizaciones en tabla de proveedores.
SET PROCEDURE TO "#lfw_updversion_cou.prg" ADDITIVE && Actualización del COU
SET PROCEDURE TO "#lfw_updnewtables.prg" ADDITIVE && Creación de tablas nuevas.
SET PROCEDURE TO "#bd_update_cajadiaria" ADDITIVE && Actualización del módulo de caja diaria.
SET PROCEDURE TO "#bd_update_promociones" ADDITIVE  && Actualización del módulo de promociones.
SET PROCEDURE TO "#bd_update_ventas" ADDITIVE && Actualización módulo ventas.
SET PROCEDURE TO "json_utils.prg" ADDITIVE

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
goConn.ConnectionString = "DRIVER={MySQL ODBC 5.1 Driver};SERVER=localhost;PORT=3306;UID=root;PWD=l4ld81;DATABASE=linfowgst_mgc1;OPTION=3;"

IF !goConn.Open()
	MESSAGEBOX(goConn.ErrorMessage, 1+16, "Database Connection")
	RETURN .F.
ENDIF

*=instalar_scripts()
*=actualizarSPs()
*=actualizar_funciones()
*actualizarVersion()


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
*DO FORM frm_imp_precios
DO FORM frm_pedidos_online_v2

*DO FORM frmabrircaja
*DO FORM frm_facturar_mostrador
*DO FORM frm_orden_pago