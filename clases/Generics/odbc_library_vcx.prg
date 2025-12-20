************************************************************
OBJETO: cls_dataformat
************************************************************
*** PROPIEDADES ***
Name = "cls_dataformat"

*** METODOS ***
PROCEDURE str_sqlfmt
PARAMETERS tcString

LOCAL lcResult

IF INT(VAL(getConfig("SQLSRV"))) = 1 THEN
	&& Reemplazos a realizar si se está usando SQL Server
	lcResult = STRTRAN(tcString, "'", "''")
ELSE
	&& Reemplazos a realizar si se está usando mysql
	lcResult = STRTRAN(tcString, "'", "''")
	lcResult = STRTRAN(lcResult, "\", "\\")
ENDIF

RETURN "'" + ALLTRIM(lcResult) + "'"
ENDPROC
PROCEDURE float_sqlfmt
PARAMETERS tnValue, tnDigits, tnDecimals

RETURN ALLTRIM(STR(tnValue, tnDigits, tnDecimals))
ENDPROC
PROCEDURE datetime_sqlfmt
PARAMETERS td_Fecha

LOCAL nDia, nMes, nAnio, cFecResult, lnSqlSrv

lnSqlSrv = VAL(getconfig("SQLSRV"))
nDia = DAY(td_Fecha)
nMes = MONTH(td_Fecha)
nAnio = YEAR(td_Fecha)

IF lnSqlSrv = 0 THEN
	cFecResult = "'" + ALLTRIM(STR(nAnio)) + "-" + ALLTRIM(STR(nMes)) + "-" + ALLTRIM(STR(nDia)) + "'"
ELSE
	cFecResult = "CONVERT(DATETIME, '" + ALLTRIM(STR(nDia)) + "-" + ALLTRIM(STR(nMes)) + "-" + ALLTRIM(STR(nAnio)) + "')"
ENDIF

RETURN cFecResult

ENDPROC


************************************************************
OBJETO: datetime
************************************************************
*** PROPIEDADES ***
Name = "datetime"

*** METODOS ***
PROCEDURE tomysql
PARAMETERS td_Fecha

LOCAL nDia, nMes, nAnio, cFecResult, lnSqlSrv

lnSqlSrv = VAL(getconfig("SQLSRV"))
nDia = DAY(td_Fecha)
nMes = MONTH(td_Fecha)
nAnio = YEAR(td_Fecha)

IF lnSqlSrv <> 2 THEN
	IF lnSqlSrv = 0 THEN
		cFecResult = "'" + ALLTRIM(STR(nAnio)) + "-" + ALLTRIM(STR(nMes)) + "-" + ALLTRIM(STR(nDia)) + "'"
	ELSE
		cFecResult = "CONVERT(DATETIME, '" + ALLTRIM(STR(nDia)) + "-" + ALLTRIM(STR(nMes)) + "-" + ALLTRIM(STR(nAnio)) + "')"
	ENDIF
ELSE
	&& Si lnSqlSrv = 2, entonces, signfica que se está ejecutándo desde Access
	cFecResult = "#" + ALLTRIM(DTOC(td_Fecha)) + "#"
ENDIF

RETURN cFecResult

ENDPROC
PROCEDURE getdatetime
IF INT(VAL(getConfig("SQLSRV"))) = 0 THEN
	&& MySql
	RETURN "current_timestamp"
ELSE
	IF INT(VAL(getConfig("SQLSRV"))) = 1 THEN
		&& SQL Server
		RETURN "GETDATE()"
	ELSE
		&& Access
		RETURN "Now()"
	ENDIF
ENDIF
ENDPROC
PROCEDURE to_webservice
PARAMETERS td_Fecha

LOCAL nDia, nMes, nAnio, cFecResult, lnSqlSrv

lnSqlSrv = VAL(getconfig("SQLSRV"))
nDia = DAY(td_Fecha)
nMes = MONTH(td_Fecha)
nAnio = YEAR(td_Fecha)

cFecResult = ALLTRIM(STR(nAnio)) + "-" + IIF(nMes < 10, "0" + ALLTRIM(STR(nMes)), ALLTRIM(STR(nMes))) + "-" + ALLTRIM(STR(nDia))

RETURN cFecResult

ENDPROC
PROCEDURE getnombremes
PARAMETERS tnMes

DO CASE 
CASE tnMes = 1
	RETURN "ENERO"
CASE tnMes = 2
	RETURN "FEBRERO"
CASE tnMes = 3
	RETURN "MARZO"
CASE tnMes = 4
	RETURN "ABRIL"
CASE tnMes = 5
	RETURN "MAYO"
CASE tnMes = 6
	RETURN "JUNIO"
CASE tnMes = 7
	RETURN "JULIO"
CASE tnMes = 8
	RETURN "AGOSTO"
CASE tnMes = 9
	RETURN "SEPTIEMBRE"
CASE tnMes = 10
	RETURN "OCTUBRE"
CASE tnMes = 11
	RETURN "NOVIEMBRE"
CASE tnMes = 12
	RETURN "DICIEMBRE"
ENDCASE
ENDPROC


************************************************************
OBJETO: odbc_result
************************************************************
*** PROPIEDADES ***
activeconnection = 
cursor_name = 
error_message = 
Name = "odbc_result"

*** METODOS ***
PROCEDURE openquery
PARAMETERS tc_CommandText

LOCAL lRes, activeconecstring

gcValueTrace = tc_CommandText
IF ISNULL(tc_CommandText)
	This.error_message = "No se ha recibido la sentencia SQL a ejecutar. odbc_result.OpenQuery()"
	RETURN .F.
ENDIF

IF SQLEXEC(this.activeconnection, tc_CommandText, this.cursor_name) != 1
	this.error_message = "Ha ocurrido un error al intentar ejecutar la consulta, revise la sintaxis, compile y vuelva a intentarlo. Para evaluar la consulta ingrese al motor de base de datos y presione CTRL+V para pegar y resvisar su sintaxis"	
	RETURN .F.
ENDIF

SELECT (this.cursor_name)
IF RECCOUNT() > 0
	GO TOP
ENDIF

RETURN .T.

ENDPROC
PROCEDURE close_query
If Used(this.cursor_name) Then
	Use In (this.cursor_name)
EndIf
ENDPROC
PROCEDURE addparameter
PARAMETERS tcSql, tcName, tcValue, tlString, tlDateTime

LOCAL loDataFormat
LOCAL lcResult

loDataFormat = CREATEOBJECT("cls_dataformat")
IF tlString THEN
	lcResult = STRTRAN(tcSql, "?" + ALLTRIM(tcName), ;
		loDataFormat.str_sqlfmt(tcValue))
ELSE
	IF tlDateTime THEN
		lcResult = STRTRAN(tcSql, "?" + ALLTRIM(tcName),;
			loDataFormat.datetime_sqlfmt(tcValue))
	ELSE
		lcResult = STRTRAN(tcSql, "?" + ALLTRIM(tcName), ;
			tcValue)
	ENDIF
ENDIF
RETURN lcResult
ENDPROC
PROCEDURE convert_count_to_numeric
****************************************************
* Fuerza el resultado de un count a numerico
****************************************************
LPARAMETERS txValue

IF TYPE("txValue") <> "N" THEN
	RETURN INT(VAL(txValue))
ENDIF

RETURN txValue
ENDPROC


************************************************************
OBJETO: odbc_connect
************************************************************
*** PROPIEDADES ***
connectionstring = 
activeconnection = 
errormessage = 
current_db = 
transaccion_iniciada = .F.
Name = "odbc_connect"

*** METODOS ***
PROCEDURE open
LOCAL lcConnectionString

this.activeconnection = SQLSTRINGCONNECT(this.connectionstring)

IF this.activeconnection = -1
	this.ErrorMessage = "Ha ocurrido un error al intentar establecer la conexión con la base de datos"
	RETURN .F.
ENDIF

SQLSETPROP(this.activeconnection,"DispWarnings", .T.)

lcConnectionString = GETWORDNUM(this.connectionstring, 6, ";")
this.current_db = GETWORDNUM(lcConnectionString, 2, "=")

RETURN .T.


ENDPROC
PROCEDURE close
SQLDISCONNECT(this.activeconnection)
ENDPROC
PROCEDURE begintransaction
LOCAL nRes
LOCAL lnSqlSrv

lnSqlSrv = VAL(getconfig("SQLSRV"))

IF lnSqlSrv = 0
	nRes = SQLEXEC(this.activeconnection, "START TRANSACTION")
ELSE
	nRes = SQLEXEC(this.activeconnection, "BEGIN TRANSACTION")
ENDIF

IF nRes <> 1
	this.errormessage = "Error al intentar iniciar la transacción"
	This.transaccion_iniciada = .F.
	RETURN .F.
ENDIF

This.transaccion_iniciada = .T.
RETURN .T.
ENDPROC
PROCEDURE commit
LOCAL nRes

nRes = SQLEXEC(this.activeconnection, "COMMIT")
IF nRes <> 1
	this.ErrorMessage = "Error al confirmar la transacción"
	RETURN
ENDIF

This.transaccion_iniciada = .F.

ENDPROC
PROCEDURE rollback
LOCAL nRes

nRes = SQLEXEC(this.activeconnection, "ROLLBACK")
IF nRes <> 1
	this.ErrorMessage = "Error al confirmar la transacción"
	RETURN
ENDIF

This.transaccion_iniciada = .F.

ENDPROC
PROCEDURE getnextid
PARAMETERS tcTableName, tcFieldName

LOCAL cSql
LOCAL nReturnCode

cSql = "SELECT MAX(" + tcFieldName + ") AS MaxID FROM " + tcTableName

SQLEXEC(this.activeconnection, cSql, "cur_MaxID")

SELECT cur_MaxID
IF ISNULL(cur_MaxID.MaxID)
	nReturnCode = 1
ELSE
	nReturnCode = cur_MaxID.MaxID + 1
ENDIF

RETURN nReturnCode


ENDPROC


************************************************************
OBJETO: odbc_command
************************************************************
*** PROPIEDADES ***
commandtext = 
activeconnection = 
errormessage = 
Name = "odbc_command"

*** METODOS ***
PROCEDURE execute
LOCAL nRes

gcValueTrace = this.commandtext

IF ISNULL(this.commandtext) THEN
	this.ErrorMessage = "La propiedad commandText está vacía"
	errortrap(-1000, this.errorMessage, "The SQL command is not complete", "odbc_command.Execute", 0)
	RETURN .F.
ENDIF

* Deshabilita los mensajes de error de ODBC
SQLSETPROP(this.activeconnection, "DispWarnings", .F.)
nRes = SQLEXEC(this.activeconnection, this.commandtext)

IF nRes <> 1
	this.ErrorMessage = MESSAGE()
	errortrap(-1000, this.errorMessage, "The SQL command is not complete", "odbc_command.Execute", 0)
	RETURN .F.
ENDIF

RETURN .T.
ENDPROC
PROCEDURE addparameter
PARAMETERS tcName, tcValue, tlString, tlDateTime

LOCAL loDataFormat

loDataFormat = CREATEOBJECT("cls_dataformat")
IF tlString THEN
	this.commandtext = STRTRAN(this.commandtext, "?" + ALLTRIM(tcName), ;
		loDataFormat.str_sqlfmt(tcValue))
ELSE
	IF tlDateTime THEN
		this.commandtext = STRTRAN(this.commandtext, "?" + ALLTRIM(tcName),;
			loDataFormat.datetime_sqlfmt(tcValue))
	ELSE
		this.commandtext = STRTRAN(this.commandtext, "?" + ALLTRIM(tcName), ;
			tcValue)
	ENDIF
ENDIF

ENDPROC


