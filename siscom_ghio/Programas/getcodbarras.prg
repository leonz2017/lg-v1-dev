PARAMETERS lc_codigo

LOCAL lc_code25i, ln_xPos, ln_aux, lc_codbarra

lc_code25i = ""
ln_xPos = 1
ln_aux = 0
lc_codbarra = ""

DO WHILE ln_xPos <= LEN(lc_codigo) THEN 
	ln_aux = INT(VAL(SUBSTR(lc_codigo, ln_xPos, 2)))
	
	IF ln_aux < 94 THEN 
		ln_aux = ln_aux + 33
	ELSE 
		ln_aux = ln_aux + 101
	ENDIF 
	
	lc_code25i = lc_code25i + CHR(ln_aux)
	
	ln_xPos = ln_xPos + 2
ENDDO 
 
lc_codbarra = CHR(201) + lc_code25i +CHR(202)

RETURN lc_codbarra 