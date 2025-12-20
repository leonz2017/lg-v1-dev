&& Programa: Calcular_Venta
&& Calcula el precio de venta

PARAMETERS tf_Costo, tf_Rentab1, tf_Rentab2

LOCAL lf_Venta

lf_Venta = tf_Costo + (tf_Costo * (tf_Rentab1 / 100))
lf_Venta = lf_Venta + (lf_Venta * (tf_Rentab2 / 100))

RETURN ROUND(lf_Venta, 2)