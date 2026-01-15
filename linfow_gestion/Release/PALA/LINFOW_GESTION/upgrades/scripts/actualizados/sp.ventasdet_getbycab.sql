CREATE PROCEDURE `ventasdet_getByCab`(_idVentasC int)
BEGIN
	SELECT  ventasdet.idventasc,
	        ventasdet.idarticulo,
	        articulos.codart,
	        ventasdet.descripcio,
	        ventasdet.cantidad,
	        ventasdet.prVenta,
		ventasdet.prArtic,
	        ventasdet.pDtoVta1,
	        ventasdet.pDtoVta2,
	        ventasdet.pDtoVta3,
	        ventasdet.pDtoVta4,
	        ventasdet.iDtoVta1,
	        ventasdet.iDtoVta2,
	        ventasdet.iDtoVta3,
	        ventasdet.iDtoVta4,
	        ventasdet.porDesc1,
	        ventasdet.porDesc2,
	        ventasdet.porDesc3,
	        ventasdet.porDesc4,
	        ventasdet.impDesc1,
	        ventasdet.impDesc2,
	        ventasdet.impDesc3,
	        ventasdet.impDesc4,
	        ventasdet.alicIVA,
	        ventasdet.impIVA,
	        ventasdet.impNeto,
	        ventasdet.totNeto,
	        ventasdet.subTotal,
	        marcas.descripcio AS marca
	FROM    ventasdet 
	INNER JOIN articulos
	   ON ventasdet.idArticulo = articulos.idArticulo
	INNER JOIN marcas 
		ON articulos.idMarca = marcas.idMarca
	WHERE idVentasC =  _idVentasC;
END