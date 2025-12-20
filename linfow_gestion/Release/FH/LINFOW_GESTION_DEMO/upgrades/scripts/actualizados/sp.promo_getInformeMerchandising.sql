CREATE PROCEDURE promo_getInformeMerchandising (
    xidcliente int
)
BEGIN
    /**
     * Recupero los merchandising que se lleva el cliente con su cantidad
     *
     * Desarrollado por: LINFOW - Leonardo D. Zulli
     * Fecha: 30/08/2021
    */

    SELECT 
        * 
    FROM 
        promo_clim 
    WHERE 
        promo_clim.idCliente = xidcliente;
END