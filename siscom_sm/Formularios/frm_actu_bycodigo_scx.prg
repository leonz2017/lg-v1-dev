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
OBJETO: FRM_ACTU_BYCODIGO
************************************************************
*** PROPIEDADES ***
BorderStyle = 2
Height = 585
Width = 940
DoCreate = .T.
Caption = "Proceso de actualización de precios"
WindowState = 0
Name = "FRM_ACTU_BYCODIGO"
contenido.Top = -1
contenido.Left = -1
contenido.Width = 1092
contenido.Height = 589
contenido.Name = "contenido"

*** METODOS ***
PROCEDURE Init
DODEFAULT()

thisform.actu_precios.crear_cursor()

SELECT cur_artic
thisform.contenido.grdArticulos.RecordSource = "cur_artic"
thisform.contenido.grdArticulos.alias_name = "cur_artic"
thisform.contenido.grdArticulos.list_controlsource = "selected,codArt,codArtPV,descripcio,prLista,costoRep,prFinalMax,prFinalMin"
thisform.contenido.grdArticulos.lista_ancho_cols = "50,150,150,300,70,70,80,80"
thisform.contenido.grdArticulos.titulos_cabeceras = "Proc.,Código,Cód. Prov,Descripción,Pr. Lista,Costo,Pr. May. Final,Pr. Min. Final"
thisform.contenido.grdArticulos.generar_grid()


ENDPROC


************************************************************
OBJETO: actu_precios
************************************************************
*** PROPIEDADES ***
Top = 549
Left = 485
Name = "actu_precios"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Proveedor Desde:"
Height = 15
Left = 17
Top = 11
Width = 111
TabIndex = 16
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Proveedor Hasta:"
Height = 15
Left = 17
Top = 34
Width = 111
TabIndex = 17
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Marca Desde:"
Height = 15
Left = 17
Top = 57
Width = 111
TabIndex = 18
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Marca Hasta:"
Height = 15
Left = 17
Top = 81
Width = 111
TabIndex = 19
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Familia Desde:"
Height = 15
Left = 17
Top = 104
Width = 111
TabIndex = 20
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta6
************************************************************
*** PROPIEDADES ***
Caption = "Familia Hasta:"
Height = 15
Left = 17
Top = 127
Width = 111
TabIndex = 21
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: sel_ProvDD
************************************************************
*** PROPIEDADES ***
Top = 5
Left = 121
TabIndex = 1
esnumerico = .T.
nombre_campo_codigo = idProv
nombre_campo_desc = razSoc
nombre_tabla = proveedor
pkfield = idProv
Name = "sel_ProvDD"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: sel_ProvHH
************************************************************
*** PROPIEDADES ***
Top = 28
Left = 121
TabIndex = 2
esnumerico = .T.
nombre_campo_codigo = idProv
nombre_campo_desc = razSoc
nombre_tabla = proveedor
pkfield = idProv
Name = "sel_ProvHH"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: sel_MarcaDD
************************************************************
*** PROPIEDADES ***
Top = 51
Left = 121
TabIndex = 3
esnumerico = .T.
nombre_campo_codigo = idMarca
nombre_campo_desc = descripcio
nombre_tabla = marcas
pkfield = idMarca
Name = "sel_MarcaDD"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: sel_MarcaHH
************************************************************
*** PROPIEDADES ***
Top = 74
Left = 121
TabIndex = 4
esnumerico = .T.
nombre_campo_codigo = idMarca
nombre_campo_desc = descripcio
nombre_tabla = marcas
pkfield = idMarca
Name = "sel_MarcaHH"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: sel_FamiliaDD
************************************************************
*** PROPIEDADES ***
Top = 97
Left = 121
TabIndex = 5
esnumerico = .T.
nombre_campo_codigo = idFamilia
nombre_campo_desc = descripcio
nombre_tabla = familias
pkfield = idFamilia
Name = "sel_FamiliaDD"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: sel_FamiliaHH
************************************************************
*** PROPIEDADES ***
Top = 120
Left = 121
TabIndex = 6
esnumerico = .T.
nombre_campo_codigo = idFamilia
nombre_campo_desc = descripcio
nombre_tabla = familias
pkfield = idFamilia
Name = "sel_FamiliaHH"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta7
************************************************************
*** PROPIEDADES ***
Caption = "SubFamilia Desde:"
Height = 15
Left = 17
Top = 150
Width = 111
TabIndex = 23
Name = "Clsetiqueta7"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta8
************************************************************
*** PROPIEDADES ***
Caption = "SubFamilia Hasta:"
Height = 15
Left = 17
Top = 173
Width = 111
TabIndex = 24
Name = "Clsetiqueta8"

*** METODOS ***


************************************************************
OBJETO: sel_SubFamDD
************************************************************
*** PROPIEDADES ***
Top = 143
Left = 121
TabIndex = 7
esnumerico = .T.
nombre_campo_codigo = idSubFam
nombre_campo_desc = descripcio
nombre_tabla = subfam
pkfield = idSubFam
Name = "sel_SubFamDD"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: sel_SubFamHH
************************************************************
*** PROPIEDADES ***
Top = 166
Left = 121
TabIndex = 8
esnumerico = .T.
nombre_campo_codigo = idSubFam
nombre_campo_desc = descripcio
nombre_tabla = subfam
pkfield = idSubFam
Name = "sel_SubFamHH"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: grdArticulos
************************************************************
*** PROPIEDADES ***
Height = 291
Left = 14
TabIndex = 12
Top = 245
Width = 923
permitir_ordenamiento = .F.
permitir_busqueda = .F.
Name = "grdArticulos"
COLUMN1.Header1.Name = "Header1"
COLUMN1.Text1.Name = "Text1"
COLUMN1.CurrentControl = "Clscheckbox1"
COLUMN1.Sparse = .F.
COLUMN1.Name = "COLUMN1"
COLUMN2.Header1.Name = "Header1"
COLUMN2.Text1.Name = "Text1"
COLUMN2.Name = "COLUMN2"
COLUMN3.Header1.Name = "Header1"
COLUMN3.Text1.Name = "Text1"
COLUMN3.Name = "COLUMN3"
COLUMN4.Header1.Name = "Header1"
COLUMN4.Text1.Name = "Text1"
COLUMN4.Name = "COLUMN4"
COLUMN5.Header1.Name = "Header1"
COLUMN5.Text1.Name = "Text1"
COLUMN5.Name = "COLUMN5"
COLUMN6.Header1.Name = "Header1"
COLUMN6.Text1.Name = "Text1"
COLUMN6.Name = "COLUMN6"
COLUMN7.Header1.Name = "Header1"
COLUMN7.Text1.Name = "Text1"
COLUMN7.Name = "COLUMN7"
COLUMN8.Header1.Name = "Header1"
COLUMN8.Text1.Name = "Text1"
COLUMN8.Name = "COLUMN8"
COLUMN9.Header1.Name = "Header1"
COLUMN9.Text1.Name = "Text1"
COLUMN9.Name = "COLUMN9"
COLUMN10.Header1.Name = "Header1"
COLUMN10.Text1.Name = "Text1"
COLUMN10.Name = "COLUMN10"
COLUMN11.Header1.Name = "Header1"
COLUMN11.Text1.Name = "Text1"
COLUMN11.Name = "COLUMN11"
COLUMN12.Header1.Name = "Header1"
COLUMN12.Text1.Name = "Text1"
COLUMN12.Name = "COLUMN12"
COLUMN13.Header1.Name = "Header1"
COLUMN13.Text1.Name = "Text1"
COLUMN13.Name = "COLUMN13"
COLUMN14.Header1.Name = "Header1"
COLUMN14.Text1.Name = "Text1"
COLUMN14.Name = "COLUMN14"
COLUMN15.Header1.Name = "Header1"
COLUMN15.Text1.Name = "Text1"
COLUMN15.Name = "COLUMN15"
COLUMN16.Header1.Name = "Header1"
COLUMN16.Text1.Name = "Text1"
COLUMN16.Name = "COLUMN16"
COLUMN17.Header1.Name = "Header1"
COLUMN17.Text1.Name = "Text1"
COLUMN17.Name = "COLUMN17"
COLUMN18.Header1.Name = "Header1"
COLUMN18.Text1.Name = "Text1"
COLUMN18.Name = "COLUMN18"
COLUMN19.Header1.Name = "Header1"
COLUMN19.Text1.Name = "Text1"
COLUMN19.Name = "COLUMN19"
COLUMN20.Header1.Name = "Header1"
COLUMN20.Text1.Name = "Text1"
COLUMN20.Name = "COLUMN20"

*** METODOS ***
PROCEDURE press_enter
LOCAL loForm, loRes
LOCAL lcSql

lcSql = ""

SELECT cur_artic
loForm = CREATEOBJECT("cls_control_precios_edit")
loForm.idArticulo = cur_artic.idArticulo
loForm.idIngDet = 0
loForm.idIngCab = 0
loForm.actualiza_ingresos = .F.
loForm.precio_ing = 0.00
loForm.recuperar_precios()

loForm.show()

IF loForm.modificado THEN
	loRes = CREATEOBJECT("odbc_result")
	loRes.ActiveConnection = goConn.ActiveConnection
	loRes.Cursor_Name = "cur_x"
	
	lcSql = "CALL articulos_getById(?pIdArticulo)"
	lcSql = loRes.AddParameter(lcSql, "pIdArticulo", ALLTRIM(STR(cur_artic.idArticulo)), .f., .f.)	
	IF !loRes.OpenQuery(lcSql) THEN
		MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
		RETURN .F.
	ENDIF

	SELECT cur_artic
	LOCK()
	REPLACE cur_artic.selected WITH .T.
	REPLACE cur_artic.prLista WITH cur_x.prLista ADDITIVE
	REPLACE cur_artic.bonif1 WITH cur_x.bonif1 ADDITIVE
	REPLACE cur_artic.bonif2 WITH cur_x.bonif2 ADDITIVE
	REPLACE cur_artic.bonif3 WITH cur_x.bonif3 ADDITIVE
	REPLACE cur_artic.bonif4 WITH cur_x.bonif4 ADDITIVE
	REPLACE cur_artic.costoRep WITH cur_x.costoRep ADDITIVE
	REPLACE cur_artic.margenMax WITH cur_x.margenMax ADDITIVE
	REPLACE cur_artic.margenMin WITH cur_x.margenMin ADDITIVE
	REPLACE cur_artic.prVentaMax WITH cur_x.prVentaMax ADDITIVE
	REPLACE cur_artic.prVentaMin WITH cur_x.prVentaMin ADDITIVE
	REPLACE cur_artic.prFinalMax WITH cur_x.prFinalMax ADDITIVE
	REPLACE cur_artic.prFinalMin WITH cur_x.prFinalMin ADDITIVE
	UNLOCK
	
	loRes.Close_Query()
ENDIF

loForm.release()
ENDPROC


************************************************************
OBJETO: Clscheckbox1
************************************************************
*** PROPIEDADES ***
Top = 23
Left = 36
Alignment = 0
Caption = ""
Name = "Clscheckbox1"

*** METODOS ***


************************************************************
OBJETO: btnCancelar
************************************************************
*** PROPIEDADES ***
Top = 540
Left = 14
Height = 44
Width = 45
TabIndex = 15
Name = "btnCancelar"

*** METODOS ***
PROCEDURE Click
thisform.actu_precios.limpiar()
thisform.contenido.sel_FamiliaDD.blanquear()
thisform.contenido.sel_FamiliaHH.blanquear()
thisform.contenido.sel_MarcaDD.blanquear()
thisform.contenido.sel_MarcaHH.blanquear()
thisform.contenido.sel_ProvDD.blanquear()
thisform.contenido.sel_ProvHH.blanquear()
thisform.contenido.sel_SubFamDD.blanquear()
thisform.contenido.sel_SubFamHH.blanquear()
thisform.contenido.sel_articuloDD.blanquear()
thisform.contenido.sel_articuloHH.blanquear()
thisform.contenido.sel_articuloDD.valcpoid = 0
thisform.contenido.sel_articuloHH.valcpoid = 0
thisform.contenido.sel_provDD.txtCodigo.SetFocus()
ENDPROC


************************************************************
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 540
Left = 892
Height = 44
Width = 45
TabIndex = 14
Name = "btnCerrar"

*** METODOS ***


************************************************************
OBJETO: btnBuscar
************************************************************
*** PROPIEDADES ***
Top = 191
Left = 686
TabIndex = 11
Name = "btnBuscar"

*** METODOS ***
PROCEDURE Click
thisform.actu_precios.idfamilia_dd = thisform.contenido.sel_FamiliaDD.valcpoid
thisform.actu_precios.idfamilia_hh = thisform.contenido.sel_FamiliaHH.valcpoid
thisform.actu_precios.idmarca_dd = thisform.contenido.sel_MarcaDD.valcpoid
thisform.actu_precios.idmarca_hh = thisform.contenido.sel_MarcaHH.valcpoid
thisform.actu_precios.idprov_dd = thisform.contenido.sel_provDD.valcpoid
thisform.actu_precios.idprov_hh = thisform.contenido.sel_ProvHH.valcpoid
thisform.actu_precios.idsubfam_dd = thisform.contenido.sel_SubFamDD.valcpoid
thisform.actu_precios.idsubfam_hh = thisform.contenido.sel_SubFamHH.valcpoid
thisform.actu_precios.codArt_dd = thisform.contenido.sel_articuloDD.txtCodigo.Value
thisform.actu_precios.codart_hh = thisform.contenido.sel_articuloHH.txtCodigo.Value

IF !thisform.actu_precios.open() THEN
	MESSAGEBOX(thisform.actu_precios.ErrorMessage, 0+48, thisform.Caption)
	RETURN .F.
ENDIF

Thisform.Contenido.grdArticulos.Refresh()
Thisform.Contenido.grdArticulos.SetFocus()

RETURN .T.
ENDPROC


************************************************************
OBJETO: Clsetiqueta9
************************************************************
*** PROPIEDADES ***
Anchor = 0
Caption = "Artículo desde:"
Height = 15
Left = 17
Top = 195
Width = 105
TabIndex = 22
Name = "Clsetiqueta9"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta10
************************************************************
*** PROPIEDADES ***
Anchor = 0
Caption = "Artículo hasta:"
Height = 15
Left = 17
Top = 218
Width = 103
TabIndex = 25
Name = "Clsetiqueta10"

*** METODOS ***


************************************************************
OBJETO: sel_articuloDD
************************************************************
*** PROPIEDADES ***
Anchor = 0
Top = 189
Left = 121
Width = 564
Height = 25
TabIndex = 9
autocompletar_ceros = .F.
esnumerico = .F.
nombre_campo_codigo = codArt
nombre_campo_desc = descripcio
nombre_tabla = articulos
permitir_agregar_regs = .F.
pkfield = idArticulo
requerido = .F.
Name = "sel_articuloDD"
txtCodigo.Height = 21
txtCodigo.Left = 2
txtCodigo.Top = 2
txtCodigo.Width = 181
txtCodigo.Name = "txtCodigo"
txtDescripcion.Left = 185
txtDescripcion.Top = 2
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: sel_articuloHH
************************************************************
*** PROPIEDADES ***
Anchor = 0
Top = 212
Left = 121
Width = 564
Height = 25
TabIndex = 10
autocompletar_ceros = .F.
esnumerico = .F.
nombre_campo_codigo = codArt
nombre_campo_desc = descripcio
nombre_tabla = articulos
permitir_agregar_regs = .F.
pkfield = idArticulo
requerido = .F.
Name = "sel_articuloHH"
txtCodigo.Height = 21
txtCodigo.Left = 2
txtCodigo.Top = 2
txtCodigo.Width = 181
txtCodigo.Name = "txtCodigo"
txtDescripcion.Left = 185
txtDescripcion.Top = 2
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: CLSETIQUETA11
************************************************************
*** PROPIEDADES ***
Caption = "En esta nueva modalidad para editar los precios"
Height = 17
Left = 618
Top = 8
Width = 288
Name = "CLSETIQUETA11"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta12
************************************************************
*** PROPIEDADES ***
Caption = "deberá presionar la tecla ENTER sobre el artículo"
Height = 17
Left = 613
Top = 23
Width = 288
Name = "Clsetiqueta12"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta13
************************************************************
*** PROPIEDADES ***
Caption = "seleccionado en la grilla."
Height = 17
Left = 613
Top = 39
Width = 192
Name = "Clsetiqueta13"

*** METODOS ***


************************************************************
OBJETO: 
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


