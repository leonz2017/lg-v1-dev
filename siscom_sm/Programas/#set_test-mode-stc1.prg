***************************************************************
* Configuro los parámetros de global_cfg para desarrollo
***************************************************************

set talk off
set date french
set century on
set exclusive off
set multilocks on
set debug off

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

set classlib to "odbc_library.vcx"
set classlib to "utilidades.vcx" additive
set classlib to "winforms.vcx" additive
set classlib to "zip.vcx" additive
set classlib to "_therm" additive
set classlib to "data_services.vcx" additive
set classlib to "ventas_sinfiscal.vcx" additive
set classlib to "siscaja.vcx" additive
set classlib to "stock.vcx" additive
set classlib to "ofertas.vcx" additive
set classlib to "admincpas.vcx" additive
set classlib to "procesos.vcx" additive

set procedure to "ErrorTrap"			additive	&& Capturador de errores inesperados
set procedure to "calcularporcentaje"	additive	&& Calcula un porcentaje
set procedure to "filetransfer"			additive	&& Permite bajar archivos desde una dirección de internet
set procedure to "getglobalcfg"			additive	&& Permite recuperar la configuración global
set procedure to "funciones.prg"		additive	&& Funciones
set procedure to "#lfw_updversion.prg"	additive	&& Actualizar Versión


_screen.caption = "LINFOW Gestion Tito DESA"
_screen.windowstate = 2
_screen.closable = .f.

local loRes

public goConn
public goFormMain
public goFormLogin
public gnUserID
public gcCodUsu
public gcUrlWS
public glVersionBeta

goConn = createobject("odbc_connect")
goConn.ConnectionString = "DRIVER={MySQL ODBC 5.1 Driver};SERVER=localhost;PORT=3306;UID=root;PWD=l4ld81;DATABASE=linfowgst_stc1;OPTION=3;"
wait window goConn.ActiveConnection nowait
if !goConn.open()
	messagebox(goConn.errormessage, 1+16, "Database Connection")
	return .f.
endif

wait window "Configurando modo desarrollo" nowait
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
addOrUpdateGlobalCFG("TEMPDIR", "C", sys(5) + "\Temp\", .f.)

* Agrego parámetros para FTP
addOrUpdateGlobalCFG("FTPHOST", "C", "", .t.)
addOrUpdateGlobalCFG("FTPUSER", "C", "", .t.)
addOrUpdateGlobalCFG("FTPPASS", "C", "", .t.)
addOrUpdateGlobalCFG("FTPPORT", "C", "", .t.)
addOrUpdateGlobalCFG("FTPINIDIR", "C", "", .t.)
addOrUpdateGlobalCFG("USA_SFTP", "L", "false", .t.)

* URL de actualizador
addOrUpdateGlobalCFG("URLUPDATER", "C", "NADA", .t.)

loRes = createobject("odbc_result")
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_config"
loRes.OpenQuery("SELECT * FROM global_cfg")
browse
loRes.Close_Query()

wait window "Modo desarrollo listo" nowait
goConn.close()
