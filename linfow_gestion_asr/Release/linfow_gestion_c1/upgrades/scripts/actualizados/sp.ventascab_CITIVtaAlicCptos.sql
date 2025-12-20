CREATE PROCEDURE `ventascab_CITIVtaAlicCptos`(
	pIdVentasC int)
BEGIN
	SELECT
		ivaPor,
		CASE 
			WHEN ivaPor = 21 THEN '0005'
			WHEN ivaPor = 10.5 THEN'0004'
			WHEN ivaPor = 0 THEN '0003'
			WHEN ivaPor = 27 THEN '0006'
			WHEN ivaPor = 5 THEN '0008'
			WHEN ivaPor = 2.5 THEN '0009' END codAlicIVA,
		sum(impNeto) AS impNeto,
		sum(ivaImp) AS impIva

	FROM
		vtadcp
	WHERE
		idVentasC = pIdVentasC
	GROUP BY
		ivaPor;
END