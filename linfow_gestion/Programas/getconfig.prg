&& Este procedimiento permite recuperar valores del config
PARAMETERS tc_Variable

LOCAL lcFile
LOCAL lcCfg
LOCAL i
LOCAL llOk
LOCAL lcConfig
LOCAL lcLinea
LOCAL lcValue
LOCAL lnLinCount
DIMENSION laLin[2]

lcFile = "siscom.conf"
i = 0
lcCfg = ""
llOk = .F.
lcConfig = ""
lcKey = "ODBC_CONN"
lnLinCount = 0
lcLinea = ""

lcCfg = FILETOSTR(lcFile)
lnLinCount = 1
FOR i = 1 TO LEN(lcCfg)
	IF SUBSTR(lcCfg, i, 1) == "<" THEN
		llOk = .T.
	ELSE
		IF llOk THEN
			IF SUBSTR(lcCfg, i, 1) == ">" THEN
				lcConfig = lcConfig + CHR(13) + CHR(10)
				lnLinCount = lnLinCount + 1
				llOk = .F.
			ELSE 
				lcConfig = lcConfig + SUBSTR(lcCfg, i, 1)
			ENDIF
		ENDIF
	ENDIF
NEXT i

lcValue = "Nothing"
FOR i = 1 TO GETWORDCOUNT(lcConfig, CHR(13) + CHR(10))
	lcLinea = GETWORDNUM(lcConfig, i, CHR(13) + CHR(10))
	laLin[1] = GETWORDNUM(lcLinea, 1, ":")
	laLin[2] = GETWORDNUM(lcLinea, 2, ":")
	IF ALLTRIM(laLin[1]) == ALLTRIM(tc_Variable) THEN
		lcValue = laLin[2]
	ENDIF
NEXT i

RETURN ALLTRIM(lcValue)