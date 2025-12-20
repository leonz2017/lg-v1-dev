CREATE FUNCTION `articulos_costo_to_lista`(
	costo DECIMAL(20, 2),
	bonif1 DECIMAL(5, 2),
	bonif2 DECIMAL(5, 2),
	bonif3 DECIMAL(5, 2),
	bonif4 DECIMAL(5, 2)) RETURNS DECIMAL(20, 2)
    DETERMINISTIC
BEGIN
	DECLARE lista DECIMAL(20, 2);
	
	SET lista = costo + (costo * (bonif4 / 100));
	SET lista = lista + (lista * (bonif3 / 100));
	SET lista = lista + (lista * (bonif2 / 100));
	SET lista = lista + (lista * (bonif1 / 100));
	
	RETURN ROUND(lista, 2);
END