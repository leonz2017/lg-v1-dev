************************************************************
OBJETO: Dataenvironment
************************************************************
*** PROPIEDADES ***
Top = 0
Left = 0
Width = 0
Height = 0
DataSource = .NULL.
Name = "Dataenvironment"

*** METODOS ***


************************************************************
OBJETO: FRM_ACTUALIZAR_PRECIOS_FINAL
************************************************************
*** PROPIEDADES ***
Top = 0
Left = 0
Height = 55
Width = 937
DoCreate = .T.
Caption = "Actualizar precio final"
TitleBar = 0
BackColor = 255,255,255
Dockable = 1
prfinalant = 0.00
Name = "FRM_ACTUALIZAR_PRECIOS_FINAL"

*** METODOS ***
PROCEDURE blanquear
Thisform.sel_Articulo.blanquear()
Thisform.sel_Articulo.txtCodigo.SetFocus()
Thisform.txtPrUnitFinal.Value = 0

ENDPROC
PROCEDURE Init
Thisform.Dock(0)
ENDPROC


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Anchor = 3
Caption = "Artículo:"
Height = 15
Left = 17
Top = 12
Width = 60
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: sel_Articulo
************************************************************
*** PROPIEDADES ***
Anchor = 3
Top = 6
Left = 73
Width = 564
Height = 25
TabIndex = 5
autocompletar_ceros = .F.
esnumerico = .F.
nombre_campo_codigo = codArt
nombre_campo_desc = descripcio
nombre_tabla = articulos
permitir_agregar_regs = .F.
pkfield = idArticulo
requerido = .F.
alternative_cols = prFinalMax,prFinalMin
anchos_cols = 400,70,70
title_cols = Descripción,Precio May, Precio Min
criterio_filtro = articulos.habilitado = 1 AND articulos.fecBaja IS NULL
Name = "sel_Articulo"
txtCodigo.Height = 21
txtCodigo.Left = 2
txtCodigo.Top = 2
txtCodigo.Width = 181
txtCodigo.Name = "txtCodigo"
txtDescripcion.Left = 185
txtDescripcion.Top = 2
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***
PROCEDURE recuperar_datos
Thisform.txtPrUnitFinal.Value = articulos.prfinalMin
ENDPROC
PROCEDURE txtCodigo.LostFocus
*******************************************************************
* Busca por todos los códigos posibles
*******************************************************************

LOCAL lcCodArt
LOCAL loResult, lcSql

lcCodArt = ""
lcSql = ""
loResult = CREATEOBJECT("odbc_result")

IF !(ALLTRIM(this.Value) == "") THEN
	TEXT TO lcSql NOSHOW
		SELECT 
			codArt, cantiDesp 
		FROM 
			codiart
		WHERE
			codigos = ?xCodigos AND
			(circuito = 'V' OR circuito = 'CV') AND
			codiart.idArticulo IN (
				SELECT
					idArticulo
				FROM
					articulos
				WHERE
					articulos.fecBaja IS NULL)
	ENDTEXT

	lcSql = loResult.AddParameter(lcSql, "xCodigos", ALLTRIM(This.Value), .t., .f.)
	loResult.ActiveConnection = goConn.ActiveConnection
	loResult.Cursor_Name = "cur_x"
	
	IF !loResult.OpenQuery(lcSql) THEN
		MESSAGEBOX(loResult.Error_Message, 0+48, Thisform.Caption)
		RETURN .F.
	ENDIF

	SELECT cur_x
	IF RECCOUNT("cur_x") > 0 THEN
		This.Parent.txtCodigo.Value = ALLTRIM(cur_x.codArt)
		DODEFAULT()
		Thisform.txtPrUnitFinal.SetFocus()
	ELSE
		&& Si no encuentra nada en codiart entonces sigue la busqueda
		&& estandar
		
		DODEFAULT()
	ENDIF
	
	IF USED("cur_x") THEN
		loResult.close_query()
	ENDIF
ENDIF

RETURN .T.
ENDPROC


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Anchor = 3
Caption = "Precio final:"
Height = 15
Left = 643
Top = 12
Width = 72
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: txtPrUnitFinal
************************************************************
*** PROPIEDADES ***
Enabled = .T.
Height = 21
Left = 715
TabIndex = 8
ToolTipText = "Presione Enter para realizar el cambio de precio"
Top = 8
Width = 96
isnumeric = .T.
Name = "txtPrUnitFinal"

*** METODOS ***
PROCEDURE calcular
***************************************************************************************
* Para realizar la modificación de precios a partir del precio final, toma el cliente
* consumidor final desde la GlobalCFG. Solo minorista.
***************************************************************************************

LOCAL loCmd, lcSql

* Valido que no haga nada si el valor está en cero
IF this.Value = 0 THEN
	MESSAGEBOX("El precio no puede ser 0 (cero)", 0+48, Thisform.Caption)
	Thisform.blanquear()
	RETURN
ENDIF

IF !(RIGHT(ALLTRIM(This.Parent.sel_Articulo.txtCodigo.Value), 3) == "ARX") THEN
	&& Redondeo a un decimal en la validación debido a la diferencia que aveces se genera
	&& de un decimal.

	loCmd = CREATEOBJECT("odbc_result")
	lcSql = "CALL sp_articulos_updateByPrecioFinal (?pIdArticulo, ?pPreVtaFinal, ?pUsuario, ?pHostName)"
	lcSql = loCmd.AddParameter(lcSql, "pIdArticulo", ALLTRIM(STR(this.Parent.sel_Articulo.valcpoid)), .f., .f.)
	lcSql = loCmd.AddParameter(lcSql, "pPreVtaFinal", ALLTRIM(STR(This.Value, 10, 2)), .f., .f.)
	lcSql = loCmd.AddParameter(lcSql, "pUsuario", ALLTRIM(gcCodUsu), .t., .f.)
	lcSql = loCmd.AddParameter(lcSql, "pHostName", ALLTRIM(SYS(0)), .t., .f.)
	loCmd.ActiveConnection = goConn.ActiveConnection
	loCmd.Cursor_Name = "cur_tmp"
	
	IF !loCmd.OpenQuery(lcSql) THEN
		MESSAGEBOX(loCmd.Error_Message, 0+48, Thisform.Caption)
	ELSE
		IF !(ALLTRIM(cur_tmp.result) == "OK") THEN
			SELECT cur_tmp
			MESSAGEBOX(cur_tmp.result, 0+48, Thisform.Caption)
		ELSE
			MESSAGEBOX("Precio actualizado satisfactoriamente.", 0+64, Thisform.Caption)
			Thisform.blanquear()
		ENDIF
	ENDIF
	
	loCmd.Close_Query()
ENDIF


ENDPROC


************************************************************
OBJETO: 
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


