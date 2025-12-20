&& Nombre del programa: calcular_costo
&& Calcula el costo de reposición

PARAMETERS tf_PrLista, tf_Bonif1, tf_Bonif2, tf_Bonif3, tf_Bonif4, tf_PorGtos

LOCAL lfCosto1, lfCosto2, lfCosto3, lfCosto4, lfCosto5

lfCosto1 = 0.00
lfCosto2 = 0.00
lfCosto3 = 0.00
lfCosto4 = 0.00
lfCosto5 = 0.00

lfCosto1 = tf_PrLista - (tf_PrLista * tf_Bonif1 / 100)
lfCosto2 = lfCosto1 - (lfCosto1 * tf_Bonif2 / 100)
lfCosto3 = lfCosto2 - (lfCosto2 * tf_Bonif3 / 100)
lfCosto4 = lfCosto3 - (lfCosto3 * tf_Bonif4 / 100)
lfCosto5 = lfCosto4 + (lfCosto4 * tf_PorGtos / 100)

RETURN ROUND(lfCosto5, 2)