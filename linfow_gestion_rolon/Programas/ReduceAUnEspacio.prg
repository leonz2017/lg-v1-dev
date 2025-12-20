FUNCTION ReduceAUnEspacio(tcCadena)
  DO WHILE AT(SPACE(2), tcCadena) > 0
    tcCadena = STRTRAN(tcCadena, SPACE(2), SPACE(1) )
  ENDDO
  RETURN ALLTRIM(tcCadena)
ENDFUNC