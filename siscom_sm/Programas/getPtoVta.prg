PARAMETERS lnPtoVta

LOCAL lcPtoVta

lcPtoVta = REPLICATE("0", 4 - LEN(ALLTRIM(STR(lnPtoVta)))) + ALLTRIM(STR(lnPtoVta))
RETURN lcPtoVta