CREATE FUNCTION promo_calcular_cant_merchandisign(
    ximp_tope decimal(20, 2),
    xtotal_vend decimal(20, 2)
)
RETURNS decimal(20,2) DETERMINISTIC
BEGIN
    /**
     * Esta función permite calcular la cantidad de merchandising
     * que se lleva el cliente en base al total comprado de las 
     * marcas.
     *
     * Desarrollado por: LINFOW - Leonardo D. Zulli
     * Fecha: 30/08/2021
    */

    DECLARE vcantidad decimal(20, 2);
    DECLARE vimporte decimal(20, 2);
    
    SET vcantidad = 0;
    SET vimporte = ximp_tope;
    WHILE vimporte <= xtotal_vend DO
        SET vcantidad = vcantidad + 1;
        SET vimporte = vimporte + ximp_tope;
    END WHILE;
    RETURN vcantidad;
END