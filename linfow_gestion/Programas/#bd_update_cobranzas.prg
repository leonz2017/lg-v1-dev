*************************************************************
* Actualización de cobranzas
* Fecha: 16/12/2022
* Desarrollado por: Leonardo D. Zulli
*************************************************************

PROCEDURE agregarCamposCheques
	LOCAL lcTabla
	LOCAL lcCampo
	
	lcTabla = "cheques"
	lcCampo = "anulado"
	IF !existe_campo(lcTabla, lcCampo) THEN
		WAIT WINDOW "Agregando " + ALLTRIM(lcTabla) + " " + lcCampo + " en ventasdet" NOWAIT
		lcSql = "ALTER TABLE " + lcTabla + " ADD " + lcCampo + " bit NOT NULL DEFAULT 0; -- Establece si el cheque está anulado."
		ejecutar_comando(lcSql)
	ENDIF
ENDPROC

************************************************************
* Permite ampliar el campo de número de cheque
* Fecha: 15/08/2023
************************************************************
PROCEDURE ampliarCampoNumeroCheque
	LOCAL lcSql
	
	lcSql = "ALTER TABLE cheques CHANGE COLUMN chq_nro chq_nro varchar(20)"
	ejecutar_comando(lcSql)
ENDPROC