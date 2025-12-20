**********************************************************************
* Programa: getGlobalCFG
* Descripción: Permite levantar un valor de la tabla de configuración
* global.
* Fecha: 20/08/2013
***********************************************************************
PARAMETERS tnKey

LOCAL loRes, lcSql, lResult

loRes = CREATEOBJECT("odbc_result")
lcSql = ""

lcSql = "SELECT * FROM global_cfg WHERE cfg_Key = '" + ALLTRIM(tnKey) + "'"
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_global"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, "Error inesperado")
	RETURN "Error Inesperado"
ENDIF

IF UPPER(ALLTRIM(cur_global.cfg_Type)) == 'L' THEN
	IF LOWER(ALLTRIM(cur_global.cfg_Value)) == "true" THEN
		lResult = .T.
	ELSE
		lResult = .F.
	ENDIF
ELSE
	IF ALLTRIM(cur_global.cfg_Type) == "C" THEN
		lResult = ALLTRIM(cur_global.cfg_Value)
	ELSE
		IF ALLTRIM(cur_global.cfg_Type) == "N" THEN
			lResult = INT(VAL(ALLTRIM(cur_global.cfg_Value)))
		ELSE 
			lResult = FLOAT(VAL(ALLTRIM(cur_global.cfg_Value)))
		ENDIF 
	ENDIF
ENDIF

loRes.Close_Query()

RETURN lResult