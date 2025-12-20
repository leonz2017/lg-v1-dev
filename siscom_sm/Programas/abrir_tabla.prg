&& Procedimiento abrir tabla
PARAMETERS tc_TableName

IF !USED(tc_TableName)
	USE &tc_TableName ALIAS &tc_TableName AGAIN IN 0
ELSE
	SELECT (tc_TableName)
ENDIF

