CREATE PROCEDURE `lfwcat_getArticulos`()
BEGIN
	SELECT
		articulos.idArticulo AS idArticuloLG,
		marcas.idmarca AS idMarcaLG,
		familias.idFamilia AS idRubroLG,
		subfam.idSubFam AS idSubrubroLG,
		articulos.codArt,
		articulos.descripcio AS descripcion,
		articulos.prventaMax AS precio_lista,
		articulos.equiv AS equivalencia,
		articulos.habilitado AS habilitado,
		0 AS eliminado,
		articulos.alicIVA,
		marcas.descripcio AS marca,
		familias.descripcio AS rubro,
		subfam.descripcio AS subrubro,
		observ AS descripcion_larga
	FROM
		articulos
			INNER JOIN marcas ON marcas.idmarca = articulos.idmarca
			INNER JOIN familias ON familias.idFamilia = articulos.idFamilia 
			INNER JOIN subfam ON subfam.idSubFam = articulos.idSubFam
	WHERE
		articulos.fecBaja IS NULL AND 
        articulos.codArt NOT LIKE '%ARX';
END