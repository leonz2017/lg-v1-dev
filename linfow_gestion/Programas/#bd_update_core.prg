*************************************************************
* Programa: #bd_update_core
* Permite actualizar las tablas del core del sistema.
*************************************************************

PROCEDURE bd_actualizar_numerador
	***********************************************
	* Actualiza estructura de la tabla numerador.
	* Fecha: 09/12/2022
	* Desarrollador: Leonardo D. Zulli	
	***********************************************
	LOCAL lcTabla
	LOCAL lcCampo
	
	lcTabla = "numerador"
	lcCampo = "codafip"
	IF !existe_campo(lcTabla, lcCampo) THEN
		lcSql = "ALTER TABLE " + lcTabla + " ADD " + lcCampo + " INT NULL DEFAULT 0"
		ejecutar_comando(lcSql)
	ENDIF
ENDPROC

PROCEDURE bd_acomodar_codafip_numerador
	LOCAL lcSql
	
	* Acomodo los códigos de FC "A"
	TEXT TO lcSql NOSHOW
		UPDATE
			numerador
		SET
			codafip = 1
		WHERE
			cbte = 'FC' AND
			tipoDoc = 'A'
	ENDTEXT
	ejecutar_comando(lcSql)
	
	* Acomodo los códigos de FC "B"
	TEXT TO lcSql NOSHOW
		UPDATE
			numerador
		SET
			codafip = 6
		WHERE
			cbte = 'FC' AND
			tipoDoc = 'B'
	ENDTEXT
	ejecutar_comando(lcSql)
	
	* AComodo los códigos de FC "C"
	TEXT TO lcSql NOSHOW
		UPDATE
			numerador
		SET
			codafip = 11
		WHERE
			cbte = 'FC' AND
			tipoDoc = 'C'
	ENDTEXT
	ejecutar_comando(lcSql)
	
	* Acomodo ND "A" (Notas de débitos)
	TEXT TO lcSql NOSHOW
		UPDATE
			numerador
		SET
			codafip = 2
		WHERE
			cbte = 'ND' AND
			tipoDoc = 'A'
	ENDTEXT
	ejecutar_comando(lcSql)

	* Acomodo ND "B"
	TEXT TO lcSql NOSHOW
		UPDATE
			numerador
		SET
			codafip = 7
		WHERE
			cbte = 'ND' AND
			tipoDoc = 'B'
	ENDTEXT
	ejecutar_comando(lcSql)
	
	* Acomodo ND "C"
	TEXT TO lcSql NOSHOW
		UPDATE
			numerador
		SET
			codafip = 12
		WHERE
			cbte = 'ND' AND
			tipoDoc = 'C'
	ENDTEXT
	ejecutar_comando(lcSql)

	* Acomodo NC "A" (Notas de créditos)
	TEXT TO lcSql NOSHOW
		UPDATE
			numerador
		SET
			codafip = 3
		WHERE
			cbte = 'NC' AND
			tipoDoc = 'A'
	ENDTEXT
	ejecutar_comando(lcSql)

	* Acomodo NC "B" (Notas de créditos)	
	TEXT TO lcSql NOSHOW
		UPDATE
			numerador
		SET
			codafip = 8
		WHERE
			cbte = 'NC' AND
			tipoDoc = 'B'
	ENDTEXT
	ejecutar_comando(lcSql)
	
	* Acomodo NC "C"
	TEXT TO lcSql NOSHOW
		UPDATE
			numerador
		SET
			codafip = 3
		WHERE
			cbte = '13' AND
			tipoDoc = 'C'
	ENDTEXT
	ejecutar_comando(lcSql)

	* Por último a los comprobantes internos que no tienen código de
	* AFIP les asigno un -1.
	TEXT TO lcSql NOSHOW
		UPDATE
			numerador
		SET
			codafip = -1
		WHERE
			codafip = 0
	ENDTEXT
	ejecutar_comando(lcSql)
ENDPROC