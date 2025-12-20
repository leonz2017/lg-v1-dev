* Calcula el descuento del valor recibido como parámetro

PARAMETERS tn_Valor, tn_PorDesc

LOCAL lnRes
lnRes = 0

lnRes = tn_Valor * (tn_PorDesc / 100)

RETURN lnRes