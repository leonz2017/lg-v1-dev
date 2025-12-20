***********************************************************************
* Programa: 	menu_compras
* Descripción:	Contiene las funciones correspondientes a los llamados
* Fecha:		27/05/2014
***********************************************************************


PROCEDURE planif_cpr
	LOCAL loForm
	
	loForm = CREATEOBJECT("cls_form_planifcpr")
	loForm.hide()
	loForm.show(1)
ENDPROC


&& Este procedimiento contiene puntualmente la funcionalidad de la planificación de compras
&& que requiere DER.
PROCEDURE planif_cpr_der
	LOCAL loForm
	
	loForm = CREATEOBJECT("cls_form_panifcpr_der")
	loForm.hide()
	loForm.show(1)
ENDPROC


PROCEDURE planif_cbcpr
	LOCAL loForm
	
	loForm = CREATEOBJECT("cls_form_cbpc")
	loForm.Hide()
	loForm.Show(1)
ENDPROC

PROCEDURE planif_cbcpr_der
	LOCAL loForm
	
	loForm = CREATEOBJECT("cls_form_cbpc_der")
	loForm.Hide()
	loForm.Show(1)
ENDPROC

PROCEDURE ing_oc
	LOCAL loForm
	
	loForm = CREATEOBJECT("cls_form_ocmanual")
	loForm.hide()
	loForm.show(1)
ENDPROC

PROCEDURE consulta_oc
	LOCAL loForm
	
	loForm = CREATEOBJECT("cls_form_consultaoc")
	loForm.hide()
	loForm.show(1)
ENDPROC

PROCEDURE consulta_ocart
	LOCAL loForm
	
	loForm = CREATEOBJECT("cls_form_consartoc")
	loForm.hide()
	loForm.show(1)
ENDPROC

PROCEDURE oc_bajapend
	LOCAL loForm
	
	loForm = CREATEOBJECT("cls_form_bajapend")
	loForm.hide()
	loForm.show(1)
ENDPROC