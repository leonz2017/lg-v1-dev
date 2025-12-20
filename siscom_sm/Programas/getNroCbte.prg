PARAMETERS lnNroCbte

LOCAL lcNroCbte

lcNroCbte = REPLICATE("0", 8 - LEN(ALLTRIM(STR(lnNroCbte)))) + ALLTRIM(STR(lnNroCbte))

RETURN lcNroCbte