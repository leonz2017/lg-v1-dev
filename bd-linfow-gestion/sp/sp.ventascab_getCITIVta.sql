DELIMITER $$
DROP PROCEDURE IF EXISTS ventascab_getCITIVta $$

CREATE PROCEDURE `ventascab_getCITIVta`(
	fechaDD DATE,
    fechaHH DATE)
BEGIN
	/* Ultima version agrego total no gravado */
	SELECT 
		ventascab.fecEmision,
		ventascab.cbte, 
		ventascab.aut_tipoCbte, 
		ventascab.ptoVta, 
		ventascab.numCbte, 
		tipodoc.CodAfip, 
		ventascab.nroDoc, 
		ventascab.razSoc, 
		ventascab.totFact, 
		ventascab.impFinal, 
		ventascab.porIVA21, 
		ventascab.impIVA21, 
		ventascab.porIVA105, 
		ventascab.impIVA105,
		ventascab.totaNoGrav,
		ventascab.fecVto, 
		ventascab.idVentasC 
	FROM ventascab 
	  INNER JOIN tipodoc ON tipodoc.idTipoDoc = ventascab.idTipoDoc 
	WHERE  
		CAST(ventascab.FecEmision AS DATE) between  fechaDD and fechaHH
	 AND ventascab.cbte NOT IN ('PED', 'COT', 'PTO')
	 AND ventascab.fecBaja IS NULL 
	 AND ventascab.aut_Resultado = 'A';
END $$