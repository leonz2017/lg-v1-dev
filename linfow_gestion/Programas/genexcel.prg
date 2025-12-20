PARAMETERS lcCursor, lcTitulo

LOCAL lc_guardar
LOCAL loExcel

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
exportar_a_excel((lcCursor),lc_guardar,lcTitulo)	

loExcel = CREATEOBJECT("Excel.Application")
loExcel.Workbooks.Open(lc_guardar)
loExcel.Visible = .T.