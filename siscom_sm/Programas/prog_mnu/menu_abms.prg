***********************************************************************
* Programa: 	menu_abms
* Descripción: 	Este PRG contiene todas las funciones correspondientes
* 				a las llamadas de los formularios de ABMS del sistema
* Fecha:		27/03/2014
***********************************************************************

PROCEDURE abm_talonarios
	LOCAL oForm
	
	loForm = CREATEOBJECT("cls_abm_numerador")
	loForm.hide()
	loForm.show(1)
ENDPROC

PROCEDURE abm_menues
	LOCAL loForm
	loForm = CREATEOBJECT("cls_abm_menues")
	loForm.hide()
	loForm.show(1)
ENDPROC

PROCEDURE abm_config_global
	LOCAL loForm
	loForm = CREATEOBJECT("cls_abm_global_cfg")
	loForm.hide()
	loForm.show(1)
ENDPROC

PROCEDURE abm_unidDesp
	LOCAL loForm
	
	loForm = CREATEOBJECT("frm_abm_artunid")
	loForm.hide()
	loForm.show(1)
ENDPROC