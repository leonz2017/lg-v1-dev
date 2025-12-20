CREATE DEFINER=`root`@`localhost` PROCEDURE `ventascab_CITIVtaAlic`(
	pIdVentasC int)
BEGIN
	SELECT
		alicIVA,
		CASE 
			WHEN alicIVA = 21 THEN '0005'
			WHEN alicIVA = 10.5 THEN'0004'
			WHEN alicIVA = 0 THEN '0003'
			WHEN alicIVA = 27 THEN '0006'
			WHEN alicIVA = 5 THEN '0008'
			WHEN alicIVA = 2.5 THEN '0009' END codAlicIVA,
		sum(totNeto) AS impNeto,
		sum(impIVA) AS impIva
	FROM
		ventasdet
	WHERE
		idVentasC = pIdVentasC
	GROUP BY
		alicIVA;
END