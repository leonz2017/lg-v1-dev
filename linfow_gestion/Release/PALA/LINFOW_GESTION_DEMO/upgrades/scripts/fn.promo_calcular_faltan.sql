CREATE FUNCTION promo_calcular_faltan (
       xtope decimal(20, 2),
       xtotal_v decimal(20, 2))
RETURNS decimal(20, 2) DETERMINISTIC
BEGIN
  /**
  * Esta función permite calcular el importe que falta
  * para llevarse un merchandisign o duplicar.
  */
  DECLARE vMultiplo int DEFAULT 0;
  DECLARE vFaltan decimal(20, 2);

  IF xtotal_v > xtope THEN
  	/* Si el total vendido supera el tope, tengo que calcular lo
		lo que le falta para duplicar el merchandising.
     */
    WHILE xtotal_v > (xtope * vMultiplo) DO
      SET vMultiplo = vMultiplo + 2;
      SET vFaltan = (xtope * vMultiplo) - xtotal_v;
    END WHILE;
  ELSE
  	/* Si paso por acá es porque simplemente tengo que calcular lo
    	que falta para llevarse un merchandising.
     */
	SET vFaltan = xtope - xtotal_v;
  END IF;
  RETURN vFaltan;
END