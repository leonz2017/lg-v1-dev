DELIMITER $$
DROP PROCEDURE IF EXISTS citicpas_obtenerAlicuotas $$
CREATE PROCEDURE IF NOT EXISTS `citicpas_obtenerAlicuotas`()
begin
	select
		tipoCbte,
		ptoVta,
		nroCbte,
		codDocVdor,
		cuitPV,
		citicpas_formatImporte(sum(impNetoGrav)) as impNetoGrav,
		alicIVA,
		citicpas_formatImporte(sum(impLiq)) as impLiq
	from
		citicpa_alic
	group by
		alicIVA,
		tipoCbte,
		ptoVta,
		nroCbte,
		cuitPV
	order by
		tipoCbte,
        ptoVta,
        nroCbte;
end 
$$