FUNCTION calcular_prd1
PARAMETERS pr, d1
	LOCAL r
	
	r = 0.00
	r = pr * (d1 / 100)
	
	RETURN ROUND(r, 2)
ENDFUNC

FUNCTION calcular_prd2
PARAMETERS pr, d1, d2
	LOCAL r
	
	r = 0.00
	r = (pr - (pr * (d1 / 100))) * (d2 / 100)
	
	RETURN ROUND(r, 2)
ENDFUNC

FUNCTION calcular_prd3
PARAMETERS pr, d1, d2, d3
	LOCAL r1, r2, r3
	
	r1 = 0.00
	r2 = 0.00
	r3 = 0.00
	
	r1 = pr * (d1 / 100)
	r2 = (pr - r1) * (d2 / 100)
	r3 = (pr - r1 - r2) * (d3 / 100)
	
	RETURN ROUND(r3, 2)
ENDFUNC

FUNCTION calcular_prd4
PARAMETERS pr, d1, d2, d3, d4
	LOCAL r1, r2, r3, r4
	
	r1 = 0.00
	r2 = 0.00
	r3 = 0.00
	r4 = 0.00
	
	r1 = pr * (d1 / 100)
	r2 = (pr - r1) * (d2 / 100)
	r3 = (pr - r1 - r2) * (d3 / 100)
	r4 = (pr - r1 - r2 - r3) * (d4 / 100)
	
	RETURN ROUND(r4, 2)
ENDFUNC 