set talk off
set date french
set century on
set exclusive off
set multilocks on
set status bar off
set sysmenu off
set bell off
set nulldisplay to ""
* SET REPORTBEHAVIOR 80
STACKSIZE = 1000

set classlib to "odbc_library.vcx"
set classlib to "utilidades.vcx" 		additive
set classlib to "winforms.vcx" 			additive
set classlib to "zip.vcx" 				additive
set classlib to "_therm" 				additive
set classlib to "data_services.vcx" 	additive
set classlib to "toolbars_gestion.vcx" 	additive
set classlib to "ventas_sinfiscal.vcx" 	additive
set classlib to "siscaja.vcx" 			additive
set classlib to "stock.vcx" 			additive
set classlib to "procesos.vcx" 			additive
set classlib to "procesos_adaptados.vcx" additive
set classlib to "ofertas.vcx" 			additive
set classlib to "sis_abms.vcx" 			additive
set classlib to "compras.vcx" 			additive
set classlib to "retiros_mrcs.vcx" 		additive
set classlib to "vnd-comisiones.vcx" 	additive
set classlib to "articulos.vcx" 		additive
set classlib to "ventas-reports.vcx"	additive
set classlib to "listados.vcx"			additive
set classlib to "admincpas.vcx"			additive
set classlib to "finanzas.vcx"			additive
set classlib to "reparaciones.vcx"		additive
set classlib to "controles.vcx"			additive
set classlib to "promociones.vcx"		additive	&& Formularios claseados de promociones
set classlib to "ventas_v2.vcx"			additive	&& Módulo de ventas para autoservicios (mostrador)
set classlib to "mod_reconstrucciones.vcx" additive && Módulo de reconstrucciones de neumáticos
set classlib to "ordenes_trabajo.vcx"	additive	&& Módulo de ordenes de trabajo
set classlib to "ventas_on_line.vcx"	additive	&& Módulo de pedidos On-Line
Set Classlib To "update_version_utils" additive		&& Módulo de actualización del sistema
SET CLASSLIB TO "logistica.vcx"			additive	&& Módulo para emisióin de remitos

*** Clases personalizadas
set classlib to "mg_pedidos_online.vcx" additive	&& Contiene adaptaciones de pedidos on-line para MG Carburación

set procedure to "ErrorTrap"			additive	&& Capturador de errores inesperados
set procedure to "CalcularPorcentaje"	additive	&& Permite calcular un porcentaje
set procedure to "calcular_costo"		additive	&& Permite calcular el costo de reposicion
set procedure to "calcular_venta"		additive	&& Permite calcular el precio de venta
set procedure to "getconfig"			additive	&& Permite devolver el valor de una variable de configuracion
set procedure to "ftptools"				additive	&& Contiene las utilidades para subir archivos por FTP
set procedure to "filetransfer"			additive	&& Permite bajar archivos desde una dirección de internet
set procedure to "excel_module"			additive	&& Genera una planilla de excel a partir de un cursor
set procedure to "genexcel"				additive	&& Este programa lo entregó pablo por el tema de cuentas corrientes
set procedure to "getPtoVta"			additive	&& Permite convertir el punto de venta a 4 dígitos para el muestro
set procedure to "getNroCbte"			additive	&& Permite convertir el número de comprobante a 8 dígitos para el muestro de información
set procedure to "getglobalcfg"			additive	&& Permite recuperar la configuración global
set procedure to "siscom_menu"			additive	&& Permite confeccionar el menú normal dinamico
set procedure to "actu_listas"			additive	&& Permite reconocer las rutinas de actualización de listas desde los catálogos
set procedure to "menu_abms"			additive	&& Contiene los llamados a los formularios de ABMS
set procedure to "menu_compras"			additive	&& Contiene los llamados a los formularios de compras
set procedure to "menu_procesos"		additive	&& Contiene los llamados a los procesos
set procedure to "ftp"					additive 	&& ftp_service para transferencia de archivos
set procedure to "FTP_CLASS.prg"		additive	&& Clase FTP
set procedure to "enviar_mail"			additive
*!*	set procedure to "#lfw_updversion.prg"	additive	&& Actualizar versión de base de datos
set procedure to "funciones.prg"		additive	&& Funciones
set procedure to "cls_promociones.prg"	additive	&& Agrego la clase de promociones
*!*	set procedure to "#bd_update_clientes.prg" additive && Actualizaciones en tabla de clientes
*!*	set procedure to "#bd_update_proveedores.prg" additive && Actualizaciones en tabla de proveedores.
*!*	set procedure to "#lfw_updversion_cou.prg" additive && Actualización del COU
*!*	set procedure to "#lfw_updnewtables.prg" additive && Creación de tablas nuevas.
*!*	set procedure to "#bd_update_cajadiaria" additive && Actualización del módulo de caja diaria.
*!*	set procedure to "#bd_update_promociones" additive  && Actualización del módulo de promociones.
*!*	set procedure to "#bd_update_ventas" additive && Actualización módulo ventas.
*!*	set procedure to "#bd_update_core" additive && Actualiza las tablas del sistema.
*!*	set procedure to "#bd_update_cobranzas" additive && Actualiza tablas módulo cobranzas.
*!*	set procedure to "#bd_update_stock" additive && Actualiza la versión del módulo de stock.
*!*	set procedure to "#bd_update_reconstrucciones" additive && Crea y/o actualiza las tablas del módulo de reconstrucciones.
*!*	set procedure to "#bd_update_pagos" additive && Actualiza la versión en ordenes de pagos.
*!* set procedure to "#bd_upd_version_orden_trabajo" additive && Agregp actualización de las ordenes de trabajo
set procedure to "json_utils" additive && PRG que contiene la clase para manejar JSON

set path to ".\data"					&& Hace referencia a la carpeta de datos.
set path to ".\intercambio" additive	&& Hace referencia a la carpeta de intercambios.
set path to ".\upgrades" 	additive	&& Se genera la referencia a la carpeta upgrades.

on error do ErrorTrap with error(), message(), message(1), program(), lineno()

_screen.caption = "LINFOW Gestión"
_screen.windowstate = 2
_screen.closable = .f.
_screen.icon = 'linfow_icon.ico'
_screen.backcolor = rgb(255,255,255)
_screen.picture = "background.gif"

local lcOdbcCon
local lcToolBar
local lnPedNuevo
local lcWSADDR
local loCommand
local lcVersionActual

public goConn
public goFormMain
public goFormLogin
public gnUserID
public gcCodUsu
public gcUrlWS
public glVersionBeta
public gnDEMO
public gcValueTrace
public gcConnectionString
public glError

***********************************************************************************
* Cambiar el siguiente parámetro para generar la versión beta a .T. o a .F. para el
* release
***********************************************************************************
glVersionBeta = .f.
lcOdbcCon = getconfig("ODBC_CONN")
lcToolBar = getconfig("TOOLBAR")
gnDEMO = getconfig("DEMO")
lcWSADDR = getconfig("WS_ADDR")
gcUrlWS = "https://www.linfow.com.ar/" + alltrim(lcWSADDR) + "/pedidos_siscom.php?wsdl"

goConn = createobject("odbc_connect")
goConn.ConnectionString = alltrim(lcOdbcCon)

if !goConn.open()
	messagebox(goConn.errormessage, 1+16, "Database Connection")
	return .f.
endif

gcConnectionString = sqlgetprop(goConn.ActiveConnection,"ConnectString")

&& Busco actualización y si encuentra actualizo la versión
* Deshabilito la actualización de versiones por el problema de conexión
* lcVersionActual = actualizarVersion()

** Actualización de versión del sistema
loUpdateVersion = CreateObject("cls_update_version")
loUpdateVersion.actualizar_version()
lcVersionActual = loUpdateVersion.version_actual
**
goFormLogin = createobject("formLogin")
goFormLogin.show()

if !goFormLogin.IsAccept
	goFormLogin.release()
	clear all
	close databases all
	quit
	return .f.
EndIf

* Agrego la línea para inicializar la variable
_screen.caption = "LINFOW GESTION " ;
	+ alltrim(lcVersionActual) + " - " + getconfig("NOMEMP") ;
	+ " - Usuario Actual: " + alltrim(gcCodUsu) ;
	+ iif(glVersionBeta, " - VERSION BETA", "") ;
	+ " - Punto de Venta: " + getconfig("PTOVTA")

public hOpen, hFtpSession
declare integer InternetOpen in wininet.dll;
	string  sAgent,;
	integer lAccessType,;
	string  sProxyName,;
	string  sProxyBypass,;
	string  lFlags

declare integer InternetCloseHandle in wininet.dll;
	integer hInet

declare integer InternetConnect in wininet.dll;
	integer hInternetSession,;
	string  sServerName,;
	integer nServerPort,;
	string  sUsername,;
	string  sPassword,;
	integer lService,;
	integer lFlags,;
	integer lContext

declare integer FtpOpenFile in wininet.dll;
	integer hFtpSession,;
	string  sFileName,;
	integer lAccess,;
	integer lFlags,;
	integer lContext

declare integer InternetWriteFile in wininet.dll;
	integer   hFile,;
	string  @ sBuffer,;
	integer   lNumBytesToWrite,;
	integer @ dwNumberOfBytesWritten

declare long WinExec in kernel32 ;
	string lpCmdLine , ;
	long nCmdShow

if alltrim(getconfig("INIVERIFP")) == "S" then
	do form "frmpedsiscli"
endif

if alltrim(lcToolBar) == "ON"
	do form "frmEscritorio"
ENDIF

IF getGlobalCFG("MODOMOST") THEN
	DO FORM "frm_actualizar_precios_final"
ENDIF

if val(getconfig("SQLSRV")) = 1 then
	loCommand = createobject("odbc_command")
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = "SET DATEFORMAT dmy"

	if !loCommand.Execute() then
		messagebox(loCommand.errormessage, 0+48, "Error de Inicio")
		quit
	endif
else
	if val(getconfig("SQLSRV")) = 0 .and. (!glVersionBeta) then
		if getGlobalCFG("BINLOGFMT") then
			loCommand = createobject("odbc_command")
			loCommand.ActiveConnection = goConn.ActiveConnection
			loCommand.CommandText = "SET SESSION binlog_format='ROW';"

			if !loCommand.Execute() then
				messagebox(loCommand.errormessage, 0+48, "Error de Inicio")
				quit
			endif
		endif
	endif
endif

do "siscom_menu"
read events


