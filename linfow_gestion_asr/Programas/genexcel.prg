PARAMETERS lcCursor, lcTitulo

LOCAL lc_guardar

SELECT (lcCursor)
IF RECCOUNT() > 0
	GO TOP 
ELSE 
	return
ENDIF 

SELECT (lcCursor)
lc_guardar = PUTFILE("Guardar como:","","XLS")
IF EMPTY(lc_guardar)
	RETURN
ENDIF 
Exp2Excel((lcCursor),lc_guardar,lcTitulo)	
MESSAGEBOX("El archivo Excel se guardó en la carpeta " + lc_guardar,0+64, lcTitulo)