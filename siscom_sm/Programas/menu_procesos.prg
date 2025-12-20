**********************************************************************
* Este script contiene los menues correspondiente los procesos del
* sistema
**********************************************************************

PROCEDURE actualizar_scw 
	LOCAL loProceso
	
	loProceso = CREATEOBJECT("cls_upd_sc_web")
	
	IF !loProceso.conectar() THEN
		WAIT WINDOW "Error al intentarse conectar al hosting"
		RETURN
	ENDIF
	
	WAIT WINDOW "Actualizando vendedores..." NOWAIT
	IF !loProceso.upd_vendedores() THEN
		WAIT WINDOW "Error al actualizar al vendedor..."
		RETURN
	ENDIF
	
	WAIT WINDOW "Actualizando clientes..." NOWAIT
	IF !loProceso.upd_clientes() THEN
		WAIT WINDOW "Error al actualizar clientes..."
		RETURN
	ENDIF
	
	WAIT WINDOW "Actualizándo cuentas corrientes..." NOWAIT
	IF !loProceso.upd_cc_cli() THEN
		WAIT WINDOW "Error al actualizar las cuentas corrientes..."
		RETURN 
	ENDIF	
	
	WAIT WINDOW "Actualizándo artículos..." NOWAIT
	IF !loProceso.upd_articulos() THEN
		WAIT WINDOW "Error al actualizar artículos..."
		RETURN
	ENDIF
		
	WAIT WINDOW "Proceso finalizado..." NOWAIT
ENDPROC 