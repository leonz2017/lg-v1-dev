********************************************************************
* Este programa contiene los procedimientos que permitirán el acceso
* a los menues del sistema.
********************************************************************

&& Acceso al ABM de conceptos
PROCEDURE abmgst_cptos
	LOCAL loForm
	
	loForm = CREATEOBJECT("cls_abm_gtscptos")
	loForm.hide()
	loForm.show(1)
ENDPROC

&& Acceso al ABM de Personal
PROCEDURE abmgst_pers
	LOCAL loForm
	
	loForm = CREATEOBJECT("cls_abm_pers")
	loForm.hide()
	loForm.show(1)
ENDPROC


&& Acceso a la pantalla de gastos
PROCEDURE ing_gastos
	LOCAL loForm
	
	loForm = CREATEOBJECT("cls_frming_gst")
	loForm.hide()
	loForm.show(1)
ENDPROC

PROCEDURE concil_gst
	LOCAL loForm
	
	loForm = CREATEOBJECT("cls_concil_gst")
	loForm.hide()
	loForm.show(1)
ENDPROC