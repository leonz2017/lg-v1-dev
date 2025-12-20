*****************************************************************
* Contiene los procedimientos correspondientes al menu de ventas
*****************************************************************

PROCEDURE ingreso_fc
	LOCAL loForm
	
	loForm = CREATEOBJECT("clsformcbte_sm")
	loForm.cbte = "FC"
	loForm.hide()
	loForm.show(1)
ENDPROC 

PROCEDURE ingreso_pto
	LOCAL loForm
	
	loForm = CREATEOBJECT("clsformcbte_pto")
	loForm.cbte = "PTO"
	loForm.hide()
	loForm.show(1)
ENDPROC 

PROCEDURE ingreso_cot
	LOCAL loForm
	
	loForm = CREATEOBJECT("clsformcbte_sm")
	loForm.cbte = "COT"
	loForm.hide()
	loForm.show(1)
ENDPROC