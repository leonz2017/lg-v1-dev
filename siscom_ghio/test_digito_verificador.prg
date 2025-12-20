LOCAL lnDigito
LOCAL lnSumaE1
LOCAL lnSumaE3
LOCAL lnProductoE2
LOCAL lnSumaE4
LOCAL lnMin
LOCAL lcTest

tcCodigo = "233275510940100016522925087252020150612"

lnDigito = 0
lnSumaE1 = 0
lnSumaE3 = 0
lnSumaE4 = 0
lnMin = 0
lcTest = ""

FOR i = 1 TO LEN(ALLTRIM(tcCodigo))
	lnDigito = INT(VAL(SUBSTR(tcCodigo, i, 1)))
	
	IF MOD(i, 2) <> 0 THEN
		&& Etapa 1 (posiciones impares)
		lnSumaE1 = lnSumaE1 + lnDigito
	ELSE
		&& Etapa 3 (posiciones pares)
		lnSumaE3 = lnSumaE3 + lnDigito
	ENDIF
NEXT i

lnProductoE2 = lnSumaE1 * 3 && Etapa 2
lnSumaE4 = lnProductoE2 + lnSumaE3 && Etapa 4

&& Etapa 5
lnPos = 0
FOR i = 1 TO LEN(ALLTRIM(tcCodigo))
	lnDigito = INT(VAL(SUBSTR(tcCodigo, i, 1)))
	IF MOD(lnSumaE4 + lnDigito, 10) = 0 THEN
		lcTest = lcTest + ALLTRIM(STR(lnDigito))
		IF lnPos = 0 THEN
			lnMin = lnDigito
		ELSE
			IF lnDigito < lnMin THEN
				lnMin = lnDigito
			ENDIF
		ENDIF
		
		lnPos = lnPos + 1
	ENDIF
NEXT i

WAIT WINDOW ALLTRIM(lcTest) + " - " + ALLTRIM(STR(lnMin))