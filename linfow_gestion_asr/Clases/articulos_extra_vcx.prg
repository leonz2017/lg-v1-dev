************************************************************
OBJETO: cls_acomodar_datos_list
************************************************************
*** PROPIEDADES ***
Height = 504
Width = 1011
DoCreate = .T.
Caption = "Acomodar datos de artículos"
MaxButton = .T.
MinButton = .T.
WindowState = 2
Name = "cls_acomodar_datos_list"
contenido.Top = -1
contenido.Left = -1
contenido.Width = 1013
contenido.Height = 506
contenido.Name = "contenido"

*** METODOS ***
PROCEDURE procesar
LOCAL loForm

SELECT cur_articulos
DO WHILE !EOF("cur_articulos")
	Thisform.contenido.grdArticulos.Refresh()
	loForm = CREATEOBJECT("cls_acomodar_datos_edit")
	loForm.Show()
	IF !loForm.presionar_aceptar THEN
		RETURN
	ENDIF
	loForm.Release()

	SELECT cur_articulos
	SKIP
ENDDO
ENDPROC
PROCEDURE modificar
LOCAL loForm

loForm = CREATEOBJECT("cls_acomodar_datos_edit")
loForm.Show()
IF !loForm.presionar_aceptar THEN
	Thisform.contenido.grdArticulos.SetFocus()
	RETURN
ENDIF
Thisform.contenido.grdArticulos.SetFocus()
loForm.Release()
ENDPROC
PROCEDURE buscar
LOCAL lcSql
LOCAL loResult

TEXT TO lcSql NOSHOW
	SELECT
		articulos.idArticulo,
		articulos.codArt,
		articulos.descripcio,
		marcas.idMarca,
		marcas.descripcio AS descMarca,
		familias.idFamilia,
		familias.descripcio AS descFam,
		subfam.idSubFam,
		subfam.descripcio AS descSF
	FROM
		articulos
			INNER JOIN marcas ON marcas.idMarca = articulos.idMarca
			INNER JOIN familias ON familias.idFamilia = articulos.idFamilia
			INNER JOIN subfam ON subfam.idSubFam = articulos.idSubFam
	WHERE
		articulos.fecBaja IS NULL
		AND (CASE WHEN ?valorBuscado = '' THEN 1 ELSE articulos.codArt LIKE CONCAT('%', ?valorBuscado, '%') END
			OR CASE WHEN ?valorBuscado = '' THEN 1 ELSE articulos.descripcio LIKE CONCAT('%', ?valorBuscado, '%') END)
		AND CASE WHEN ?pIdMarca = 0 THEN 1 ELSE articulos.idMarca = ?pIdMarca END
		AND CASE WHEN ?pIdFamilia = 0 THEN 1 ELSE articulos.idFamilia = ?pIdFamilia END
		AND CASE WHEN ?pIdSubFam = 0 THEN 1 ELSE articulos.idSubFam = ?pIdSubFam END
ENDTEXT
loRes = CREATEOBJECT("odbc_result")
lcSql = loRes.AddParameter(lcSql, "valorBuscado", This.Contenido.cntFiltros.txtValorBuscado.Value, .t., .f.)
lcSql = loRes.AddParameter(lcSql, "pIdMarca", ALLTRIM(STR(This.Contenido.cntFiltros.sel_marca.valcpoid)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "pIdFamilia", ALLTRIM(STR(This.Contenido.cntFiltros.sel_familia.valcpoid)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "pIdSubFam", ALLTRIM(STR(This.Contenido.cntFiltros.sel_subfam.valcpoid)), .f., .f.)
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_temp"
IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+16, Thisform.Caption)
ELSE
	SELECT cur_articulos
	ZAP
	APPEND FROM DBF("cur_temp")
	GO TOP
	This.Contenido.grdArticulos.Refresh()
	loRes.Close_Query()
ENDIF
ENDPROC
PROCEDURE Init
SELECT cur_articulos
Thisform.contenido.grdArticulos.alias_name = "cur_articulos"
Thisform.contenido.grdArticulos.RecordSource = "cur_articulos"
Thisform.contenido.grdArticulos.list_controlsource = "codArt,descripcio,idMarca,descMarca,idFamilia,descFam,idSubFam,descSF"
Thisform.contenido.grdArticulos.lista_ancho_cols = "100,300,70,200,70,150,70,150"
Thisform.contenido.grdArticulos.titulos_cabeceras = "Código,Descripción,Nº Marca,Marca,Nº Fam.,Familia,Nº S.F, Subfamilia"
Thisform.contenido.grdArticulos.generar_grid()
Thisform.contenido.cntGridToolbar.btnEditar.Enabled = .F.
Thisform.contenido.cntGridToolbar.btnEditarMasivo.Enabled = .F.
ENDPROC
PROCEDURE Load
DODEFAULT()

CREATE CURSOR cur_articulos ( ;
	idArticulo int,;
	codArt varchar(20),;
	descripcio varchar(60),;
	idMarca int,;
	descMarca varchar(30),;
	idFamilia int ,;
	descFam varchar(30),;
	idSubFam int,;
	descSF varchar(30))
	
SELECT cur_articulos
INDEX ON codArt TAG codArt ASCENDING
INDEX ON descripcio TAG descripcio ASCENDING ADDITIVE
INDEX ON idMarca TAG idMarca ASCENDING ADDITIVE
INDEX ON descMarca TAG descMarca ASCENDING ADDITIVE
INDEX ON idFamilia TAG idFamilia ASCENDING ADDITIVE
INDEX ON descFam TAG descFam ASCENDING ADDITIVE
INDEX ON idSubFam TAG idSubFAm ASCENDING ADDITIVE
INDEX ON descSF TAG descSF ASCENDING ADDITIVE

ENDPROC
PROCEDURE validarcampos
IF ALLTRIM(This.contenido.cntFiltros.txtValorBuscado.Value) == "" ;
		.AND. (This.contenido.cntFiltros.sel_familia.valcpoid = 0 ;
		.AND. This.contenido.cntFiltros.sel_subfam.valcpoid = 0 ;
		.AND. This.contenido.cntFiltros.sel_marca.valcpoid = 0) THEN
	MESSAGEBOX("Debe ingresar al menos un filtro", 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

RETURN .T.

ENDPROC


************************************************************
OBJETO: btnNuevo
************************************************************
*** PROPIEDADES ***
Top = 456
Left = 12
Anchor = 6
Name = "btnNuevo"

*** METODOS ***
PROCEDURE Click
Thisform.contenido.cntFiltros.txtValorBuscado.Value = ""
Thisform.contenido.cntFiltros.sel_familia.blanquear()
Thisform.contenido.cntFiltros.sel_marca.blanquear()
Thisform.contenido.cntFiltros.sel_subfam.blanquear()
Thisform.contenido.cntGridToolbar.btnEditar.Enabled = .F.
Thisform.contenido.cntGridToolbar.btnEditarMasivo.Enabled = .F.
Thisform.contenido.cntFiltros.txtValorBuscado.Enabled = .T.
Thisform.contenido.cntFiltros.sel_familia.txtCodigo.Enabled = .T.
Thisform.contenido.cntFiltros.sel_marca.txtcodigo.Enabled = .T.
Thisform.contenido.cntFiltros.sel_subfam.txtCodigo.Enabled = .T.
Thisform.contenido.cntFiltros.btnBuscar.Enabled = .T.
SELECT cur_articulos
ZAP
Thisform.contenido.cntFiltros.txtValorBuscado.SetFocus()
This.Enabled = .T.

ENDPROC


************************************************************
OBJETO: cntFiltros
************************************************************
*** PROPIEDADES ***
Anchor = 11
Top = 13
Left = 13
Width = 994
Height = 108
Name = "cntFiltros"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Anchor = 3
Caption = "Valor buscado:"
Left = 12
Top = 12
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Anchor = 3
Caption = "Marca:"
Left = 12
Top = 36
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Anchor = 3
Caption = "Subfamilia:"
Height = 15
Left = 11
Top = 80
Width = 66
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Anchor = 3
Caption = "Familia:"
Left = 12
Top = 59
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: txtValorBuscado
************************************************************
*** PROPIEDADES ***
Anchor = 3
Height = 21
Left = 100
Top = 8
Width = 812
Name = "txtValorBuscado"

*** METODOS ***


************************************************************
OBJETO: sel_marca
************************************************************
*** PROPIEDADES ***
Anchor = 3
Top = 29
Left = 98
pkfield = idmarca
nombre_tabla = marcas
nombre_campo_codigo = idmarca
nombre_campo_desc = descripcio
esnumerico = .T.
Name = "sel_marca"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: sel_familia
************************************************************
*** PROPIEDADES ***
Anchor = 3
Top = 52
Left = 98
pkfield = idsubfam
nombre_tabla = familias
nombre_campo_codigo = idfamilia
nombre_campo_desc = descripcio
esnumerico = .T.
Name = "sel_familia"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: sel_subfam
************************************************************
*** PROPIEDADES ***
Anchor = 3
Top = 75
Left = 98
pkfield = idSubFam
nombre_tabla = subfam
nombre_campo_codigo = idSubFam
nombre_campo_desc = descripcio
esnumerico = .T.
Name = "sel_subfam"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: btnBuscar
************************************************************
*** PROPIEDADES ***
Top = 56
Left = 944
Anchor = 12
Name = "btnBuscar"

*** METODOS ***
PROCEDURE Click
IF Thisform.validarcampos() THEN
	Thisform.buscar()
	Thisform.contenido.cntGridToolbar.btnEditar.Enabled = .T.
	Thisform.contenido.cntGridToolbar.btnEditarMasivo.Enabled = .T.
	Thisform.contenido.cntFiltros.txtValorBuscado.Enabled = .F.
	Thisform.contenido.cntFiltros.sel_familia.txtCodigo.Enabled = .F.
	Thisform.contenido.cntFiltros.sel_marca.txtcodigo.Enabled = .F.
	Thisform.contenido.cntFiltros.sel_subfam.txtCodigo.Enabled = .F.	
	This.Enabled = .F.
	Thisform.contenido.grdArticulos.SetFocus()
ENDIF
ENDPROC


************************************************************
OBJETO: grdArticulos
************************************************************
*** PROPIEDADES ***
Anchor = 15
Height = 326
Left = 13
Top = 126
Width = 936
Name = "grdArticulos"
COLUMN1.Header1.Name = "Header1"
COLUMN1.Text1.Name = "Text1"
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


************************************************************
OBJETO: cntGridToolbar
************************************************************
*** PROPIEDADES ***
Anchor = 13
Top = 126
Left = 950
Width = 56
Height = 326
Name = "cntGridToolbar"

*** METODOS ***


************************************************************
OBJETO: btnEditar
************************************************************
*** PROPIEDADES ***
Top = 7
Left = 5
Name = "btnEditar"

*** METODOS ***
PROCEDURE Click
Thisform.modificar()
ENDPROC


************************************************************
OBJETO: btnEditarMasivo
************************************************************
*** PROPIEDADES ***
Top = 52
Left = 5
Picture = ..\..\clases\imagen\iconos bajados\parametros-icono-6232.ico
Name = "btnEditarMasivo"

*** METODOS ***
PROCEDURE Click
Thisform.procesar()
ENDPROC


************************************************************
OBJETO: CLSCERRAR1
************************************************************
*** PROPIEDADES ***
Top = 457
Left = 961
Anchor = 12
Name = "CLSCERRAR1"

*** METODOS ***


************************************************************
OBJETO: cls_acomodar_datos_list
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_acomodar_datos_edit
************************************************************
*** PROPIEDADES ***
DataSession = 1
BorderStyle = 2
Height = 214
Width = 603
DoCreate = .T.
Caption = "Acomodar datos artículos."
idarticulo = 0
presionar_aceptar = .F.
Name = "cls_acomodar_datos_edit"

*** METODOS ***
PROCEDURE Init
LOCAL lcSql

Thisform.txtCodigo.Value = ALLTRIM(cur_articulos.codArt)
Thisform.txtDescripcion.Value = ALLTRIM(cur_articulos.descripcio)
Thisform.sel_marca.txtCodigo.Value = cur_articulos.idMarca
Thisform.sel_marca.txtDescripcion.Value = ALLTRIM(cur_articulos.descMarca)
Thisform.sel_marca.valcpoid = cur_articulos.idMarca
Thisform.sel_familia.txtCodigo.Value = cur_articulos.idFamilia
Thisform.sel_familia.txtDescripcion.Value = ALLTRIM(cur_articulos.descFam)
THisform.sel_familia.valcpoid = cur_articulos.idFamilia
Thisform.sel_subfam.txtCodigo.Value = cur_articulos.idSubFam
Thisform.sel_subfam.txtDescripcion.Value = ALLTRIM(cur_articulos.descSF)
Thisform.sel_subfam.valcpoid = cur_articulos.idSubFam

ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Código:"
Left = 12
Top = 12
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Descripción:"
Left = 12
Top = 36
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: txtCodigo
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 108
Top = 9
Width = 204
Name = "txtCodigo"

*** METODOS ***


************************************************************
OBJETO: txtDescripcion
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 108
Top = 33
Width = 432
Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Anchor = 3
Caption = "Marca:"
Left = 12
Top = 77
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Anchor = 3
Caption = "Subfamilia:"
Height = 15
Left = 12
Top = 121
Width = 66
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Anchor = 3
Caption = "Familia:"
Left = 12
Top = 100
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: sel_marca
************************************************************
*** PROPIEDADES ***
Anchor = 3
Top = 70
Left = 107
pkfield = idmarca
nombre_tabla = marcas
nombre_campo_codigo = idmarca
nombre_campo_desc = descripcio
permitir_agregar_regs = .T.
nombre_alta_form = cls_nueva_marca
Name = "sel_marca"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: sel_familia
************************************************************
*** PROPIEDADES ***
Anchor = 3
Top = 93
Left = 107
pkfield = idfamilia
nombre_tabla = familias
nombre_campo_codigo = idfamilia
nombre_campo_desc = descripcio
permitir_agregar_regs = .T.
nombre_alta_form = cls_nueva_familia
Name = "sel_familia"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: sel_subfam
************************************************************
*** PROPIEDADES ***
Anchor = 3
Top = 116
Left = 107
pkfield = idSubFam
nombre_tabla = subfam
nombre_campo_codigo = idSubFam
nombre_campo_desc = descripcio
permitir_agregar_regs = .T.
nombre_alta_form = cls_nueva_subfamilia
Name = "sel_subfam"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: btnGrabar
************************************************************
*** PROPIEDADES ***
Top = 156
Left = 269
Default = .T.
Name = "btnGrabar"

*** METODOS ***
PROCEDURE Click
LOCAL loCmd

Thisform.presionar_aceptar = .t.

loCmd = CREATEOBJECT("odbc_command")
TEXT TO loCmd.CommandText NOSHOW
	UPDATE
		articulos
	SET
		articulos.idMarca = ?pIdMarca,
		articulos.idFamilia = ?pIdFamilia,
		articulos.idSubFam = ?pIdSubFam,
		articulos.usuModi = ?pUsuModi,
		articulos.fecModi = current_timestamp,
		articulos.idHostModi = ?pIdHostModi
	WHERE
		articulos.idArticulo = ?pIdArticulo
ENDTEXT

loCmd.AddParameter("pIdMarca", ALLTRIM(STR(This.Parent.sel_marca.valcpoid)), .f., .f.)
loCmd.AddParameter("pIdFamilia", ALLTRIM(STR(This.Parent.sel_familia.valcpoid)), .f., .f.)
loCmd.AddParameter("pIdSubFam", ALLTRIM(STR(This.Parent.sel_subfam.valcpoid)), .f., .f.)
loCmd.AddParameter("pUsuModi", ALLTRIM(gcCodUsu), .t., .f.)
loCmd.AddParameter("pIdHostModi", ALLTRIM(SYS(0)), .t., .f.)
loCmd.AddParameter("pIdArticulo", ALLTRIM(STR(cur_articulos.idArticulo)), .f., .f.)

goConn.BeginTransaction()
loCmd.ActiveConnection = goConn.ActiveConnection
IF !loCmd.Execute() THEN
	goConn.Rollback()
	MESSAGEBOX(loCmd.ErrorMessage, 0+48, Thisform.Caption)
	RETURN
ENDIF

* Actualizo el cursor
SELECT cur_articulos
LOCK()
REPLACE cur_articulos.idMarca WITH Thisform.sel_marca.valcpoid
REPLACE cur_articulos.descMarca WITH ALLTRIM(Thisform.sel_marca.txtDescripcion.Value) ADDITIVE
REPLACE cur_articulos.idFamilia WITH Thisform.sel_familia.valcpoid ADDITIVE
REPLACE cur_articulos.descFam WITH Thisform.sel_familia.txtDescripcion.Value ADDITIVE
REPLACE cur_articulos.idSubFam WITH Thisform.sel_subfam.valcpoid ADDITIVE
REPLACE cur_articulos.descSF WITH THisform.sel_subfam.txtDescripcion.Value ADDITIVE
UNLOCK

goConn.Commit()
MESSAGEBOX("Artículo modificado con éxito", 0+64, Thisform.Caption)
Thisform.Hide()


ENDPROC


************************************************************
OBJETO: btnCancelar
************************************************************
*** PROPIEDADES ***
Top = 156
Left = 317
Cancel = .T.
Name = "btnCancelar"

*** METODOS ***
PROCEDURE Click
Thisform.presionar_aceptar = .f.
Thisform.Hide()
ENDPROC


************************************************************
OBJETO: cls_acomodar_datos_edit
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


