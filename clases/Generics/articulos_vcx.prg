************************************************************
OBJETO: cls_equiv_viewer
************************************************************
*** PROPIEDADES ***
DataSession = 2
BorderStyle = 2
Height = 425
Width = 860
DoCreate = .T.
Comment = ""
Caption = "Vista de Equivalencias"
idarticulo = 0
codart = 
descripcio = 
cons_mostrador = .F.
Name = "cls_equiv_viewer"

*** METODOS ***
PROCEDURE leer_equivs
LOCAL loRes, lcSql

lcSql = ""
loRes = CREATEOBJECT("odbc_result")


thisform.equivalencias.crear_cursor()
thisform.equivalencias.idartic_a = thisform.idarticulo
thisform.equivalencias.leer_equivs()

IF !thisform.cons_mostrador THEN
	SELECT cur_equivs
	thisform.grdEquivs.alias_name = "cur_equivs"
	thisform.grdEquivs.RecordSource = "cur_equivs"
	thisform.grdEquivs.list_controlsource = "codArt,descripcio,prFMin,prFMay"
	thisform.grdEquivs.lista_ancho_cols = "200,300,150,150"
	thisform.grdEquivs.titulos_cabeceras = "Código,Descripción,Precio Minorista,Precio Mayorista"
	thisform.grdEquivs.generar_grid()
ELSE
	SELECT cur_equivs
	thisform.grdEquivs.alias_name = "cur_equivs"
	thisform.grdEquivs.RecordSource = "cur_equivs"
	thisform.grdEquivs.list_controlsource = "codArt,descripcio,prFMin"
	thisform.grdEquivs.lista_ancho_cols = "200,300,70"
	thisform.grdEquivs.titulos_cabeceras = "Código,Descripción,Precio"
	thisform.grdEquivs.generar_grid()
ENDIF

SELECT cur_artequiv
IF RECCOUNT("cur_artequiv") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_artequiv")
	lcSql = "select * from articulos where codArt = '" + ALLTRIM(cur_artequiv.codArt) + "'"
	loRes.ActiveConnection = goConn.ActiveConnection
	loRes.Cursor_Name = "cur_x"
	
	IF !loRes.OpenQuery(lcSql) THEN
		MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
		RETURN .F.
	ENDIF

	SELECT cur_equivs
	APPEND BLANK
	REPLACE cur_equivs.idArticulo WITH cur_x.idArticulo
	REPLACE cur_equivs.codArt WITH cur_x.codArt ADDITIVE
	REPLACE cur_equivs.descripcio WITH cur_x.descripcio ADDITIVE
	REPLACE cur_equivs.prFMin WITH cur_x.prFinalMin ADDITIVE
	REPLACE cur_equivs.prFMay WITH cur_x.prfinalMax ADDITIVE

	SELECT cur_artequiv
	SKIP
ENDDO

SELECT cur_equivs
IF RECCOUNT("cur_equivs") > 0 THEN
	GO TOP
ENDIF

thisform.grdEquivs.Refresh()
thisform.lblArticulo.Caption = ALLTRIM(thisform.codart) + " - " + ALLTRIM(thisform.descripcio)

ENDPROC
PROCEDURE Load
DODEFAULT()

CREATE CURSOR cur_equivs (;
	idArticulo int,;
	codArt varchar(20),;
	descripcio varchar(30),;
	prFMin float(10,2),;
	prFMay float(10,2))
ENDPROC
PROCEDURE Init
DODEFAULT()

ENDPROC


************************************************************
OBJETO: grdEquivs
************************************************************
*** PROPIEDADES ***
Height = 343
Left = 0
Top = 36
Width = 855
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdEquivs"
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
OBJETO: lblArticulo
************************************************************
*** PROPIEDADES ***
Caption = "Artículo"
Height = 15
Left = 12
Top = 12
Width = 828
Name = "lblArticulo"

*** METODOS ***


************************************************************
OBJETO: equivalencias
************************************************************
*** PROPIEDADES ***
Top = 399
Left = 156
Name = "equivalencias"

*** METODOS ***


************************************************************
OBJETO: btnSalir
************************************************************
*** PROPIEDADES ***
Top = 383
Left = 809
Height = 39
Width = 45
Name = "btnSalir"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
FontSize = 10
Caption = "Atención: Los precios que se muestran en esta grilla son finales, es decir, con el IVA incluído."
Height = 20
Left = 9
Top = 384
Width = 784
ForeColor = 255,0,0
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: cls_equiv_viewer
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_varprecios_viewer
************************************************************
*** PROPIEDADES ***
BorderStyle = 2
Height = 392
Width = 639
DoCreate = .T.
Caption = "Variación de precios por artículos"
Name = "cls_varprecios_viewer"
contenido.Name = "contenido"

*** METODOS ***
PROCEDURE Init
SELECT cur_datos
thisform.contenido.grdDatos.alias_name = "cur_datos"
thisform.contenido.grdDatos.RecordSource = "cur_datos"
thisform.contenido.grdDatos.list_controlsource = "codArt,periodo,porVar"
thisform.contenido.grdDatos.lista_ancho_cols = "100,200,70"
thisform.contenido.grdDatos.titulos_cabeceras = "Código,Período,Variación"
thisform.contenido.grdDatos.generar_grid()


ENDPROC
PROCEDURE Load
DODEFAULT()

CREATE CURSOR cur_datos (	;
	codArt	varchar(20),;
	periodo	varchar(10),;
	porVar	float(10, 2))
ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Artículo:"
Height = 15
Left = 11
Top = 13
Width = 62
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: sel_articulos
************************************************************
*** PROPIEDADES ***
Top = 8
Left = 61
autocompletar_ceros = .F.
nombre_campo_codigo = codArt
nombre_campo_desc = descripcio
nombre_tabla = articulos
pkfield = idArticulo
Name = "sel_articulos"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: btnAceptar
************************************************************
*** PROPIEDADES ***
Top = 3
Left = 544
Height = 37
Width = 45
Name = "btnAceptar"

*** METODOS ***
PROCEDURE Click
LOCAL loRes, lcSql

loRes = CREATEOBJECT("odbc_result")
lcSql = ""

IF thisform.contenido.sel_articulos.valcpoid = 0 THEN
	MESSAGEBOX("Debe ingresar el artículo a evaluar", 0+48, Thisform.Caption)
	thisform.contenido.sel_articulos.txtCodigo.SetFocus()
	RETURN .F.
ENDIF


lcSql = "select "
lcSql = lcSql + "articulos.codArt, "
lcSql = lcSql + "year(art_cbios.fecha) as anio, "
lcSql = lcSql + "month(art_cbios.fecha) as mes, "
lcSql = lcSql + "sum(art_cbios.porVar) as porVar "
lcSql = lcSql + "from 	art_cbios "
lcSql = lcSql + "	inner join articulos on articulos.idArticulo = art_cbios.idArticulo "
lcSql = lcSql + "where art_cbios.idArticulo = " + ALLTRIM(STR(thisform.contenido.sel_Articulos.valcpoid)) + " "
lcSql = lcSql + "group by articulos.codArt, year(art_cbios.fecha), month(art_cbios.fecha) "
lcSql = lcSql + "order by year(art_cbios.fecha), month(art_cbios.fecha) "

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "tempo"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_datos
ZAP

SELECT tempo
IF RECCOUNT("tempo") > 0 THEN
	GO TOP
ELSE
	MESSAGEBOX("No hay registros para mostrar", 0+64, Thisform.Caption)
	loRes.Close_Query()
	RETURN .F.
ENDIF

DO WHILE !EOF("tempo")
	SELECT cur_datos
	APPEND BLANK
	REPLACE cur_datos.codArt WITH tempo.codArt
	REPLACE cur_datos.periodo WITH ALLTRIM(STR(tempo.mes)) + " / " + ALLTRIM(STR(tempo.anio)) ADDITIVE
	REPLACE cur_datos.porVar WITH tempo.porVar

	SELECT tempo
	SKIP
ENDDO

loRes.Close_Query()

SELECT cur_datos
GO TOP
thisform.contenido.grdDatos.Refresh()

RETURN .T.
ENDPROC


************************************************************
OBJETO: btnCancelar
************************************************************
*** PROPIEDADES ***
Top = 3
Left = 589
Height = 37
Width = 45
Name = "btnCancelar"

*** METODOS ***
PROCEDURE Click
thisform.contenido.sel_articulos.blanquear()
thisform.contenido.sel_articulos.txtCodigo.SetFocus()
ENDPROC


************************************************************
OBJETO: btnSalir
************************************************************
*** PROPIEDADES ***
Top = 348
Left = 592
Height = 39
Width = 44
Name = "btnSalir"

*** METODOS ***


************************************************************
OBJETO: grdDatos
************************************************************
*** PROPIEDADES ***
Height = 303
Left = 13
Top = 42
Width = 622
Name = "grdDatos"
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
OBJETO: cls_varprecios_viewer
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_editfalt
************************************************************
*** PROPIEDADES ***
DataSession = 1
BorderStyle = 2
Height = 160
Width = 570
DoCreate = .T.
Caption = "Asignar faltante a proveedor"
Closable = .F.
dialog_result = 0
Name = "cls_sm_editfalt"

*** METODOS ***
PROCEDURE Init
DODEFAULT()

LOCAL lcSql
LOCAL loRes

lcSql = ""
loRes = CREATEOBJECT("odbc_result")

THISFORM.txtArticulo.Value = cur_faltantes.codArt
THISFORM.txtCantidad.Value = cur_faltantes.cantidad
thisform.cboUnidCpa.SetFocus()

&& Ahora levanto las unidades de despacho disponibles
lcSql = "select cantiDesp from codiart where idArticulo = " + ALLTRIM(STR(cur_faltantes.idArticulo)) + " "
lcSql = lcSql + " and (circuito = 'C' or circuito = 'CV') "
loRes.Cursor_Name = "cur_x"
loRes.ActiveConnection = goConn.ActiveConnection

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, THISFORM.Caption)
	RETURN .F.
ENDIF

SELECT cur_x
IF RECCOUNT("cur_x") > 0 THEN
	GO TOP
ENDIF

SELECT cur_x
DO WHILE !EOF("cur_x")
	THISFORM.cboUnidCpa.AddItem(ALLTRIM(STR(cur_x.cantiDesp)))

	SELECT cur_x
	SKIP
ENDDO

IF RECCOUNT("cur_x") > 0 THEN
	GO TOP
ENDIF

THISFORM.cboUnidCpa.Value = ALLTRIM(STR(cur_faltantes.unidCpr))
THISFORM.txtCantPack.Value = ROUND(cur_faltantes.cantidad / cur_faltantes.unidCPR, 2)
THISFORM.sel_proveedor.valcpoid = cur_faltantes.idProv
THISFORM.sel_proveedor.txtCodigo.Value = cur_faltantes.idProv
THISFORM.sel_proveedor.txtDescripcion.Value = ALLTRIM(cur_faltantes.razSocPV)

loRes.Close_Query()

ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Artículo:"
Height = 15
Left = 5
Top = 14
Width = 60
TabIndex = 7
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: btnAceptar
************************************************************
*** PROPIEDADES ***
Top = 110
Left = 471
TabIndex = 5
Name = "btnAceptar"

*** METODOS ***
PROCEDURE Click
IF thisform.sel_proveedor.txtCodigo.Value = 0 THEN
	MESSAGEBOX("Debe ingresar el proveedor", 0+48, thisform.Caption)
	thisform.sel_proveedor.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

IF thisform.txtCantidad.Value = 0 THEN
	MESSAGEBOX("La cantidad ingresada no puede ser cero", 0+48, thisform.Caption)
	thisform.txtcantidad.SetFocus()
	RETURN .F.
ENDIF


SELECT cur_faltantes
LOCK()
REPLACE cur_faltantes.sel WITH .T.
REPLACE cur_faltantes.idProv WITH THISFORM.sel_proveedor.valcpoid ADDITIVE
REPLACE cur_faltantes.razSocPV WITH THISFORM.sel_proveedor.txtDescripcion.Value ADDITIVE
REPLACE cur_faltantes.cantidad WITH THISFORM.txtCantidad.Value ADDITIVE
REPLACE cur_faltantes.unidCPR WITH VAL(THISFORM.cboUnidCpa.Value) ADDITIVE
UNLOCK

thisform.dialog_result = 1
thisform.Hide()

RETURN .T.
ENDPROC


************************************************************
OBJETO: txtArticulo
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 85
TabIndex = 1
TabStop = .T.
Top = 10
Width = 478
Name = "txtArticulo"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Proveedor:"
Height = 15
Left = 4
Top = 38
Width = 63
TabIndex = 8
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: sel_proveedor
************************************************************
*** PROPIEDADES ***
Top = 32
Left = 83
TabIndex = 2
nombre_campo_codigo = idProv
nombre_campo_desc = razSoc
nombre_tabla = proveedor
pkfield = idProv
requerido = .F.
esnumerico = .T.
Name = "sel_proveedor"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Unid. Compra:"
Height = 15
Left = 4
Top = 62
Width = 80
TabIndex = 9
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Cantidad:"
Height = 15
Left = 4
Top = 86
Width = 80
TabIndex = 10
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: cboUnidCpa
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 85
TabIndex = 3
Top = 59
Width = 100
Name = "cboUnidCpa"

*** METODOS ***
PROCEDURE LostFocus
LOCAL lnUnidVta

lnUnidVta = 0.00
lnUnidVta = VAL(THIS.Value)

IF lnUnidVta <> 0 THEN
	IF (THISFORM.txtCantidad.Value % lnUnidVta) <> 0 THEN
		MESSAGEBOX("La cantidad debe ser múltiplo de " + ALLTRIM(STR(lnUnidVta, 10, 2)), 0+48, Thisform.Caption)
		RETURN .F.
	ELSE
		THISFORM.txtCantPack.Value = ROUND(THISFORM.txtCantidad.Value / lnUnidVta, 2)
	ENDIF
ENDIF

RETURN .T.
ENDPROC


************************************************************
OBJETO: txtCantPack
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Left = 189
ReadOnly = .F.
TabIndex = 11
Top = 60
isnumeric = .T.
Name = "txtCantPack"

*** METODOS ***


************************************************************
OBJETO: txtCantidad
************************************************************
*** PROPIEDADES ***
Left = 85
TabIndex = 4
Top = 83
isnumeric = .T.
Name = "txtCantidad"

*** METODOS ***
PROCEDURE Valid
LOCAL lnUnidVta

lnUnidVta = 0.00
lnUnidVta = VAL(THISFORM.cboUnidCpa.Value)

IF lnUnidVta <> 0 THEN
	IF (THIS.Value % lnUnidVta) <> 0 THEN
		MESSAGEBOX("La cantidad debe ser múltiplo de " + ALLTRIM(STR(lnUnidVta, 10, 2)), 0+48, Thisform.Caption)
		RETURN .F.
	ELSE
		THISFORM.txtCantPack.Value = ROUND(THIS.Value / lnUnidVta, 2)
	ENDIF
ENDIF

RETURN .T.
ENDPROC


************************************************************
OBJETO: Clscerrar2
************************************************************
*** PROPIEDADES ***
Top = 110
Left = 519
TabIndex = 6
TabStop = .T.
Name = "Clscerrar2"

*** METODOS ***
PROCEDURE Click
thisform.dialog_result = 0
thisform.Hide()
ENDPROC


************************************************************
OBJETO: cls_editfalt
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_articbycli
************************************************************
*** PROPIEDADES ***
Height = 252
Width = 947
DoCreate = .T.
Caption = "Imprimir artículo por cliente"
Name = "cls_articbycli"
contenido.Top = 0
contenido.Left = 0
contenido.Width = 947
contenido.Height = 252
contenido.Name = "contenido"

*** METODOS ***


************************************************************
OBJETO: cls_articbycli
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_control_precios
************************************************************
*** PROPIEDADES ***
Height = 659
Width = 1080
DoCreate = .T.
Caption = "Control de precios"
WindowState = 2
Name = "cls_control_precios"
contenido.Anchor = 15
contenido.Top = -1
contenido.Left = -1
contenido.Width = 1082
contenido.Height = 661
contenido.TabIndex = 1
contenido.Name = "contenido"

*** METODOS ***
PROCEDURE leer_ingresos
LOCAL loResult
LOCAL lcSql

lcSql = "SELECT	stk_ingdet.idIngDet, "
lcSql = lcSql + "	stk_ingcab.idIngCab, "
lcSql = lcSql + "	stk_ingdet.idArticulo, "
lcSql = lcSql + "	articulos.codArt, "
lcSql = lcSql + "	articulos.descripcio, "
lcSql = lcSql + "	proveedor.idProv, "
lcSql = lcSql + "	proveedor.razSoc, "
lcSql = lcSql + "	stk_ingcab.fecha, "
lcSql = lcSql + "	stk_ingcab.numero, "
lcSql = lcSql + "	stk_ingdet.prLista "
lcSql = lcSql + "	FROM	stk_ingdet "
lcSql = lcSql + "			INNER JOIN stk_ingcab ON stk_ingcab.idIngCab = stk_ingdet.idIngCab "
lcSql = lcSql + "			INNER JOIN articulos ON articulos.idArticulo = stk_ingdet.idArticulo "
lcSql = lcSql + "			INNER JOIN proveedor ON proveedor.idProv = articulos.idProv "
lcSql = lcSql + "	WHERE	stk_ingdet.procesado = 0 "

loResult = CREATEOBJECT("odbc_result")
loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_ingdet"

IF !loResult.OpenQuery(lcSql) THEN
	MESSAGEBOX(loResult.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_articulos
ZAP

SELECT cur_ingdet
GO TOP
DO WHILE !EOF("cur_ingdet")
	SELECT cur_articulos
	APPEND BLANK
	REPLACE cur_articulos.idIngDet WITH cur_ingdet.idIngDet
	REPLACE cur_articulos.idIngCab WITH cur_ingdet.idIngCab ADDITIVE
	REPLACE cur_articulos.idArticulo WITH cur_ingdet.idArticulo ADDITIVE
	REPLACE cur_articulos.codArt WITH cur_ingdet.codArt ADDITIVE
	REPLACE cur_articulos.descripcio WITH cur_ingdet.descripcio ADDITIVE
	REPLACE cur_articulos.idProv WITH cur_ingdet.idProv ADDITIVE
	REPLACE cur_articulos.razSoc WITH cur_ingdet.razSoc ADDITIVE
	REPLACE cur_articulos.fecha WITH cur_ingdet.fecha ADDITIVE
	REPLACE cur_articulos.numero WITH cur_ingdet.numero ADDITIVE
	REPLACE cur_articulos.prLista WITH cur_ingdet.prLista ADDITIVE

	SELECT cur_ingdet
	SKIP
ENDDO

Thisform.Contenido.grdPrecios.Refresh()
RETURN .T.
ENDPROC
PROCEDURE Load
DODEFAULT()

CREATE CURSOR cur_articulos (	;
	idIngDet	int,;
	idIngCab	int,;
	idArticulo	int,;
	codArt		varchar(20),;
	descripcio	varchar(60),;
	idProv		int,;
	razSoc		varchar(60),;
	fecha		D,;
	numero		varchar(13),;
	prLista		float(10, 2))
ENDPROC
PROCEDURE Init
DODEFAULT()

SELECT cur_articulos
Thisform.Contenido.grdPrecios.alias_name = "cur_articulos"
Thisform.Contenido.grdPrecios.RecordSource = "cur_articulos"
Thisform.Contenido.grdPrecios.list_controlsource = "codArt,descripcio,idProv,razSoc,fecha,numero,prLista"
Thisform.Contenido.grdPrecios.lista_ancho_cols = "150,200,70,200,100,100,70"
Thisform.Contenido.grdPrecios.titulos_cabeceras = "Código,Descripción,Prov.,Razón Social,Fecha,RTO./FC.,Precio"
Thisform.Contenido.grdPrecios.generar_grid()

Thisform.leer_ingresos()
ENDPROC
PROCEDURE contenido.Init




ENDPROC


************************************************************
OBJETO: grdPrecios
************************************************************
*** PROPIEDADES ***
Anchor = 15
Height = 598
Left = 1
TabIndex = 5
Top = 1
Width = 1080
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdPrecios"
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
PROCEDURE press_enter
LOCAL loForm

loForm = CREATEOBJECT("cls_control_precios_edit")
loForm.idArticulo = cur_articulos.idArticulo
loForm.idIngDet = cur_articulos.idIngDet
loForm.idIngCab = cur_articulos.idIngCab
loForm.precio_ing = cur_articulos.prLista
loForm.recuperar_precios()

loForm.show()
loForm.release()
Thisform.leer_ingresos()
ENDPROC


************************************************************
OBJETO: btnSalir
************************************************************
*** PROPIEDADES ***
Top = 611
Left = 1032
Anchor = 12
TabIndex = 4
Name = "btnSalir"

*** METODOS ***


************************************************************
OBJETO: btnEditar
************************************************************
*** PROPIEDADES ***
Top = 611
Left = 10
Anchor = 6
TabIndex = 1
Name = "btnEditar"

*** METODOS ***
PROCEDURE Click
LOCAL loForm

loForm = CREATEOBJECT("cls_control_precios_edit")
loForm.idArticulo = cur_articulos.idArticulo
loForm.idIngDet = cur_articulos.idIngDet
loForm.idIngCab = cur_articulos.idIngCab
loForm.precio_ing = cur_articulos.prLista
loForm.recuperar_precios()

loForm.show()
Thisform.leer_ingresos()
ENDPROC


************************************************************
OBJETO: btnEliminar
************************************************************
*** PROPIEDADES ***
Top = 611
Left = 60
Anchor = 6
TabIndex = 2
Name = "btnEliminar"

*** METODOS ***
PROCEDURE Click
LOCAL lcSql
LOCAL loCommand
LOCAL lnResp

loCommand = CREATEOBJECT("odbc_command")
lcSql = ""
lnResp = 0

lnResp = MESSAGEBOX("¿Está seguro que desea dar de baja este precio?", 4+32, Thisform.Caption)

IF lnResp = 6 THEN
	lcSql = "UPDATE stk_ingdet "
	lcSql = lcSql + "SET procesado = 1 "
	lcSql = lcSql + "WHERE idIngDet = " + ALLTRIM(STR(cur_articulos.idIngDet)) + " "
	lcSql = lcSql + "	AND idIngCab = " + ALLTRIM(STR(cur_articulos.idIngCab))
	
	goConn.BeginTransaction()
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute() THEN
		goConn.Rollback()
		MESSAGEBOX(loCommand.Error_Message, 0+48, Thisform.Caption)
		RETURN .F.
	ENDIF
	
	goConn.Commit()
ENDIF

Thisform.leer_ingresos()

RETURN .T.

ENDPROC


************************************************************
OBJETO: cls_control_precios
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_consart
************************************************************
*** PROPIEDADES ***
DoCreate = .T.
Name = "cls_consart"
contenido.Clsetiqueta1.Name = "Clsetiqueta1"
contenido.txtValorBuscado.Name = "txtValorBuscado"
contenido.grdArtic.COLUMN1.Header1.Name = "Header1"
contenido.grdArtic.COLUMN1.Text1.Name = "Text1"
contenido.grdArtic.COLUMN1.Name = "COLUMN1"
contenido.grdArtic.COLUMN2.Header1.Name = "Header1"
contenido.grdArtic.COLUMN2.Text1.Name = "Text1"
contenido.grdArtic.COLUMN2.Name = "COLUMN2"
contenido.grdArtic.COLUMN3.Header1.Name = "Header1"
contenido.grdArtic.COLUMN3.Text1.Name = "Text1"
contenido.grdArtic.COLUMN3.Name = "COLUMN3"
contenido.grdArtic.COLUMN4.Header1.Name = "Header1"
contenido.grdArtic.COLUMN4.Text1.Name = "Text1"
contenido.grdArtic.COLUMN4.Name = "COLUMN4"
contenido.grdArtic.COLUMN5.Header1.Name = "Header1"
contenido.grdArtic.COLUMN5.Text1.Name = "Text1"
contenido.grdArtic.COLUMN5.Name = "COLUMN5"
contenido.grdArtic.COLUMN6.Header1.Name = "Header1"
contenido.grdArtic.COLUMN6.Text1.Name = "Text1"
contenido.grdArtic.COLUMN6.Name = "COLUMN6"
contenido.grdArtic.COLUMN7.Header1.Name = "Header1"
contenido.grdArtic.COLUMN7.Text1.Name = "Text1"
contenido.grdArtic.COLUMN7.Name = "COLUMN7"
contenido.grdArtic.COLUMN8.Header1.Name = "Header1"
contenido.grdArtic.COLUMN8.Text1.Name = "Text1"
contenido.grdArtic.COLUMN8.Name = "COLUMN8"
contenido.grdArtic.COLUMN9.Header1.Name = "Header1"
contenido.grdArtic.COLUMN9.Text1.Name = "Text1"
contenido.grdArtic.COLUMN9.Name = "COLUMN9"
contenido.grdArtic.COLUMN10.Header1.Name = "Header1"
contenido.grdArtic.COLUMN10.Text1.Name = "Text1"
contenido.grdArtic.COLUMN10.Name = "COLUMN10"
contenido.grdArtic.COLUMN11.Header1.Name = "Header1"
contenido.grdArtic.COLUMN11.Text1.Name = "Text1"
contenido.grdArtic.COLUMN11.Name = "COLUMN11"
contenido.grdArtic.COLUMN12.Header1.Name = "Header1"
contenido.grdArtic.COLUMN12.Text1.Name = "Text1"
contenido.grdArtic.COLUMN12.Name = "COLUMN12"
contenido.grdArtic.COLUMN13.Header1.Name = "Header1"
contenido.grdArtic.COLUMN13.Text1.Name = "Text1"
contenido.grdArtic.COLUMN13.Name = "COLUMN13"
contenido.grdArtic.COLUMN14.Header1.Name = "Header1"
contenido.grdArtic.COLUMN14.Text1.Name = "Text1"
contenido.grdArtic.COLUMN14.Name = "COLUMN14"
contenido.grdArtic.COLUMN15.Header1.Name = "Header1"
contenido.grdArtic.COLUMN15.Text1.Name = "Text1"
contenido.grdArtic.COLUMN15.Name = "COLUMN15"
contenido.grdArtic.COLUMN16.Header1.Name = "Header1"
contenido.grdArtic.COLUMN16.Text1.Name = "Text1"
contenido.grdArtic.COLUMN16.Name = "COLUMN16"
contenido.grdArtic.COLUMN17.Header1.Name = "Header1"
contenido.grdArtic.COLUMN17.Text1.Name = "Text1"
contenido.grdArtic.COLUMN17.Name = "COLUMN17"
contenido.grdArtic.COLUMN18.Header1.Name = "Header1"
contenido.grdArtic.COLUMN18.Text1.Name = "Text1"
contenido.grdArtic.COLUMN18.Name = "COLUMN18"
contenido.grdArtic.COLUMN19.Header1.Name = "Header1"
contenido.grdArtic.COLUMN19.Text1.Name = "Text1"
contenido.grdArtic.COLUMN19.Name = "COLUMN19"
contenido.grdArtic.COLUMN20.Header1.Name = "Header1"
contenido.grdArtic.COLUMN20.Text1.Name = "Text1"
contenido.grdArtic.COLUMN20.Name = "COLUMN20"
contenido.grdArtic.Name = "grdArtic"
contenido.Clscerrar1.Name = "Clscerrar1"
contenido.Clsetiqueta2.Name = "Clsetiqueta2"
contenido.Clsetiqueta3.Name = "Clsetiqueta3"
contenido.Clsetiqueta4.Name = "Clsetiqueta4"
contenido.Clsetiqueta5.Name = "Clsetiqueta5"
contenido.txtPrVtaMay.Name = "txtPrVtaMay"
contenido.txtPrVtaMin.Name = "txtPrVtaMin"
contenido.txtPrFinalMay.Name = "txtPrFinalMay"
contenido.txtPrFinalMin.Name = "txtPrFinalMin"
contenido.Clsetiqueta6.Name = "Clsetiqueta6"
contenido.txtCostoRep.Name = "txtCostoRep"
contenido.Clsetiqueta7.Name = "Clsetiqueta7"
contenido.txtBonif1.Name = "txtBonif1"
contenido.txtBonif2.Name = "txtBonif2"
contenido.txtBonif3.Name = "txtBonif3"
contenido.txtBonif4.Name = "txtBonif4"
contenido.Clsetiqueta8.Name = "Clsetiqueta8"
contenido.txtListaProv.Name = "txtListaProv"
contenido.Clsetiqueta9.Name = "Clsetiqueta9"
contenido.txtMargenMay.Name = "txtMargenMay"
contenido.Clsetiqueta10.Name = "Clsetiqueta10"
contenido.txtMargenMin.Name = "txtMargenMin"
contenido.Clsetiqueta11.Name = "Clsetiqueta11"
contenido.txtAlicIVA.Name = "txtAlicIVA"
contenido.Clsetiqueta12.Name = "Clsetiqueta12"
contenido.txtCostoConIVA.Name = "txtCostoConIVA"
contenido.picFoto.Name = "picFoto"
contenido.Clsetiqueta13.Name = "Clsetiqueta13"
contenido.txtExistencia.Name = "txtExistencia"
contenido.btnActualizar.Name = "btnActualizar"
contenido.btnMostrarPrecios.Name = "btnMostrarPrecios"
contenido.btnEquivalencias.Name = "btnEquivalencias"
contenido.Name = "contenido"
mov_stock.Name = "mov_stock"

*** METODOS ***


************************************************************
OBJETO: cls_consart
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_artequiv
************************************************************
*** PROPIEDADES ***
idartic_a = 0
errormessage = 
Name = "cls_artequiv"

*** METODOS ***
PROCEDURE crear_cursor
&& Este cursor va a contener las esquivalencias que tiene un determinado articulo

&& Cursor de muestreo
CREATE CURSOR cur_artequiv ( ;
	codArt		varchar(20),;
	descripcio	varchar(200);
)

INDEX ON  codArt TAG codArt ASCENDING
SET ORDER TO TAG codArt 

&& Cursor que contiene el armado de la cadena de equivalencias
CREATE CURSOR cur_cadena (	;
	idArtic_A	int,;
	idArtic_B	int)

&& Este cursor contiene todos los articulos equivalentes
CREATE CURSOR cur_eq (	;
	idArtic_A	int,;
	codArt_A	varchar(20)) 
	
&& Este cursor contiene todos los articulos equivalentes
CREATE CURSOR cur_delequiv (	;
	idArtic	int,;
	codArt	varchar(20)) 	
	
&& Este cursor contiene las equivalencias originales del articulo
CREATE CURSOR cur_orig (	;
	idArtic_A	int,;
	codArt_A	varchar(20)) 
ENDPROC
PROCEDURE grabar
PARAMETERS tlAutoTransaction

LOCAL loRes, lcSql, loCommand
LOCAL lnIdArtEquiv
LOCAL lcCodArt_A, lcCodArt_B
LOCAL lnCantReg
LOCAL ln_idArticA 

loRes = CREATEOBJECT("odbc_result")
lcSql = ""
loCommand = CREATEOBJECT("odbc_command")
lnIdArtEquiv = 0
lcCodArt_A = ""
lcCodArt_B = ""
lnCantReg = 0
ln_idArticA = 0

IF tlAutoTransaction THEN
	goConn.BeginTransaction()
ENDIF

&& Cuento la cantidad de equivalencias, para luego validar si es necesario armar la cadena  o no.
SELECT cur_artequiv
GO TOP 
COUNT TO lnCantReg FOR !DELETED()

SELECT cur_cadena 
ZAP 

SELECT cur_artequiv
ZAP

SELECT cur_delequiv
ZAP 

IF lnCantReg > 0 THEN 
	This.armar_equivs()
ENDIF 

lnCantReg = 0

SELECT cur_cadena
IF RECCOUNT("cur_cadena") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_cadena")
	***************************************************************************************
	&& Ahora tengo que validar que la combinación no exista
	***************************************************************************************
	lcSql = "SELECT COUNT(*) AS cantReg FROM art_equiv "
	lcSql = lcSql + "WHERE idArtic_A = '" + ALLTRIM(STR(cur_cadena.idArtic_A)) + "' "
	lcSql = lcSql + "	AND idArtic_B = '" + ALLTRIM(STR(cur_cadena.idArtic_B)) + "' "
	loRes.ActiveConnection = goConn.ActiveConnection
	loRes.Cursor_Name = "cur_x"
	
	IF !loRes.OpenQuery(lcSql) THEN
		this.ErrorMessage = loRes.Error_Message
		IF tlAutoTransaction THEN
			goConn.Rollback()
		ENDIF
		
		RETURN .F.
	ENDIF
	
	IF INT(VAL(getConfig("SQLSRV"))) = 1 THEN
		lnCantReg = cur_x.cantReg
	ELSE
		lnCantReg = INT(VAL(cur_x.cantReg))
	ENDIF
	
	loRes.Close_Query()
	
	&& Solo genero el registro si la combinación no existe
	IF lnCantReg = 0 THEN	
		lnIdArtEquiv = goConn.getNextID("art_equiv", "idArtEqui")
		
		lcSql = "select codArt from articulos where idArticulo = " + ALLTRIM(STR(cur_cadena.idArtic_A))
		loRes.ActiveConnection = goConn.ActiveConnection
		loRes.Cursor_Name = "cur_x"
		
		IF !loRes.OpenQuery(lcSql) THEN
			this.ErrorMessage = loRes.Error_Message
			
			IF tlAutoTransaction THEN
				goConn.Rollback()
				RETURN .F.
			ENDIF
			
			RETURN .F.
		ENDIF
		
		lcCodArt_A = cur_x.codArt
		
		loRes.Close_Query()
		
		lcSql = "select codArt from articulos where idArticulo = " + ALLTRIM(STR(cur_cadena.idArtic_B))
		loRes.ActiveConnection = goConn.ActiveConnection
		loRes.Cursor_Name = "cur_x"
		
		IF !loRes.OpenQuery(lcSql) THEN
			this.ErrorMessage = loRes.Error_Message
			
			IF tlAutoTransaction THEN
				goConn.Rollback()
			ENDIF
			
			RETURN .F.		
		ENDIF
		
		lcCodArt_B = cur_x.codArt
		
		loRes.Close_Query()
		
		&& Hago el insert de la equivalencia.
		lcSql = "insert into art_equiv ( "
		lcSql = lcSql + "idArtEqui, "
		lcSql = lcSql + "idArtic_A, "
		lcSql = lcSql + "idArtic_B, "
		lcSql = lcSql + "codArt_A, "
		lcSql = lcSql + "codArt_B) "
		lcSql = lcSql + "values ( "
		lcSql = lcSql + ALLTRIM(STR(lnIdArtEquiv)) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_cadena.idArtic_A)) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_cadena.idArtic_B)) + ", "
		lcSql = lcSql + "'" + ALLTRIM(lcCodArt_A) + "', "
		lcSql = lcSql + "'" + ALLTRIM(lcCodArt_B) + "')"

		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			this.ErrorMessage = loCommand.ErrorMessage
			
			IF tlAutoTransaction THEN
				goConn.Rollback()
			ENDIF
			
			RETURN .F.
		ENDIF
	ENDIF
	
	SELECT cur_cadena
	SKIP
ENDDO

IF tlAutoTransaction THEN
	goConn.Commit()
ENDIF

RETURN .T.

ENDPROC
PROCEDURE leer_equivs
LOCAL lcSql, loRes

lcSql = ""
loRes = CREATEOBJECT("odbc_result")

SELECT cur_cadena
ZAP

SELECT cur_artequiv
ZAP

SELECT cur_eq
ZAP 

SELECT cur_delequiv
ZAP 

SELECT cur_orig
ZAP 

&& Tomo las equivalencias del articulo y las enmarco en una sola columna (por eso la union invirtiendo los campos) 
lcSql = "select	art_equiv.idArtic_A, idArtic_B, codArt_A, codArt_B "
lcSql = lcSql + "from art_equiv "
lcSql = lcSql + "where art_equiv.idArtic_A = " + ALLTRIM(STR(this.idartic_a)) + " "
lcSql = lcSql + "	or art_equiv.idArtic_B = " + ALLTRIM(STR(this.idartic_a)) + " "
lcSql = lcSql + "UNION "
lcSql = "select	art_equiv.idArtic_B, idArtic_A, codArt_B, codArt_A "
lcSql = lcSql + "from art_equiv "
lcSql = lcSql + "where art_equiv.idArtic_A = " + ALLTRIM(STR(this.idartic_a)) + " "
lcSql = lcSql + "	or art_equiv.idArtic_B = " + ALLTRIM(STR(this.idartic_a)) + " "

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_temp"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_temp
IF RECCOUNT("cur_temp") > 0 THEN
	GO TOP
ELSE 
	RETURN .F.
ENDIF

&& Agrupo por la primer columna para solo tener un registro por cada articulo.
INSERT INTO cur_eq ;
SELECT idArtic_A, codArt_A FROM cur_temp GROUP BY idArtic_A, codArt_A 

loRes.Close_Query()

IF !This.armar_equivs()
	RETURN .F.
ENDIF 

INSERT INTO cur_orig ;
	SELECT * FROM cur_eq

RETURN .T.


ENDPROC
PROCEDURE asignar
PARAMETERS tnIdArtic_B
LOCAL loRes, lcSql, lnIdArtAux

loRes = CREATEOBJECT("odbc_result")
lcSql = ""
lnIdArtAux = 0
lnPosActual = 0

&& Recorro las equivalencias exitentes
SELECT cur_cadena
IF RECCOUNT("cur_cadena") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_cadena")
	lnIdArtAux = cur_cadena.idArtic_B
	
	SELECT cur_cadaux
	LOCATE FOR cur_cadaux.idArtic_B = lnIdArtAux
	IF !FOUND("cur_cadaux") THEN
		SELECT cur_cadaux
		APPEND BLANK
		REPLACE cur_cadaux.idArtic_A WITH tnIdArtic_B
		REPLACE cur_cadaux.idArtic_B WITH lnIdArtAux ADDITIVE
	ENDIF

	SELECT cur_cadaux
	LOCATE FOR cur_cadaux.idArtic_A = lnIdArtAux
	IF !FOUND("cur_cadaux") THEN
		SELECT cur_cadaux
		APPEND BLANK
		REPLACE cur_cadaux.idArtic_A WITH lnIdArtAux
		REPLACE cur_cadaux.idArtic_B WITH tnIdArtic_B ADDITIVE
	ENDIF
		
	SELECT cur_cadena
	SKIP
ENDDO

SELECT cur_cadaux

&& Agrego la asignación de los nuevos registros a la cadena principal
SELECT cur_cadaux
IF RECCOUNT("cur_cadaux") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_cadaux")
	SELECT cur_cadena
	APPEND BLANK
	REPLACE cur_cadena.idArtic_A WITH cur_cadaux.idArtic_A 
	REPLACE cur_cadena.idArtic_B WITH cur_cadaux.idArtic_B ADDITIVE

	SELECT cur_cadaux
	SKIP
ENDDO

&& Agrego la validacion ya que este registro incial lo generaría solamente
&& cuando se asigna por primera vez una equivalencia a un artículo

IF RECCOUNT("cur_cadena") = 0 THEN
	SELECT cur_cadena
	APPEND BLANK
	REPLACE cur_cadena.idArtic_A WITH this.idartic_a
	REPLACE cur_cadena.idArtic_B WITH tnIdArtic_B ADDITIVE

	SELECT cur_cadena
	APPEND BLANK
	REPLACE cur_cadena.idArtic_A WITH tnIdArtic_B
	REPLACE cur_cadena.idArtic_B WITH this.idartic_a ADDITIVE
ENDIF

IF RECCOUNT("cur_cadena") > 0 THEN
	GO TOP
ENDIF

&& Agrego el artículo nuevo al cursor de muestreo

lcSql = "select * from articulos where idArticulo = " + ALLTRIM(STR(tnIdArtic_B))
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"

IF !loRes.OpenQuery(lcSql) THEN
	this.ErrorMessage = loRes.Error_Message
	RETURN .F.
ENDIF

SELECT cur_x
IF RECCOUNT("cur_x") > 0 THEN
	SELECT cur_artequiv
	APPEND BLANK
	REPLACE cur_artequiv.codArt WITH cur_x.codArt
	REPLACE cur_artequiv.descripcio WITH cur_x.descripcio
ENDIF

loRes.close_query()

*************************
SELECT cur_cadena
BROWSE 
SELECT cur_cadaux
BROWSE
SELECT cur_artequiv
BROWSE
*************************


SELECT cur_cadaux
ZAP

SELECT cur_cadena

RETURN .T.
ENDPROC
PROCEDURE eliminar
LOCAL lcSql, loCommand, lnIdArtAuxl, lnCantReg

lcSql = ""
loCommand = CREATEOBJECT("odbc_command")
lnIdArtAux = ""

SELECT cur_artequiv
GO TOP 
COUNT TO lnCantReg FOR !DELETED()

IF lnCantReg = 0 THEN 
	&& Si lnCantReg es cero, significa que elimine todas las equivalencias de este articulo, por lo tanto
	&& este articulo no es equivalente a ningun otro. Entonces elimino este articulo de todas las equivalencias.
	lcSql = "delete from art_equiv where idArtic_A = " + ALLTRIM(STR(this.idartic_a)) + " or "
	lcSql = lcSql + "idArtic_B = " + ALLTRIM(STR(this.idartic_a)) + " "
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql

	IF !loCommand.Execute() THEN
		this.ErrorMessage = loCommand.ErrorMessage
		RETURN .F.
	ENDIF
ELSE 
	&& Si lnCantReg es mayor a cero, significa que este codigo es equivalente a 1 o n articulos. Entonces elimino solo 
	&& los articulos que no son equivalentes.
	SELECT cur_DelEquiv
	IF RECCOUNT("cur_DelEquiv") > 0 THEN
		GO TOP
	ENDIF

	SELECT cur_DelEquiv
	DO WHILE !EOF("cur_DelEquiv")
		lnIdArtAux = cur_DelEquiv.idArtic
		
		SELECT cur_orig
		LOCATE FOR cur_orig.idArtic_A = lnIdArtAux 
			
		IF FOUND("cur_orig") THEN
			lcSql = "delete from art_equiv where idArtic_A = " + ALLTRIM(STR(cur_DelEquiv.idArtic)) + " or "
			lcSql = lcSql + "idArtic_B = " + ALLTRIM(STR(cur_DelEquiv.idArtic)) + " "
			loCommand.ActiveConnection = goConn.ActiveConnection
			loCommand.CommandText = lcSql
			
			
			IF !loCommand.Execute() THEN
				this.ErrorMessage = loCommand.ErrorMessage
				RETURN .F.
			ENDIF
		ENDIF 
		
		SELECT cur_orig
		GO TOP 
		
		SELECT cur_DelEquiv
		SKIP
	ENDDO

ENDIF 

SELECT cur_DelEquiv 
ZAP

RETURN .T.

ENDPROC
PROCEDURE agregar
PARAMETERS tnIdArtic_B, tnCodArt_B, tnDesc_B
LOCAL loRes, lcSql 

loRes = CREATEOBJECT("odbc_result")
lcSql = ""

&& Agrego el artículo nuevo al cursor de muestreo
SELECT cur_artequiv
APPEND BLANK

REPLACE cur_artequiv.codArt WITH tnCodArt_B
REPLACE cur_artequiv.descripcio WITH tnDesc_B

&& Agrego el articulo a cur_cadena
SELECT cur_eq
IF RECCOUNT("cur_eq") > 0 THEN 
	GO TOP 
	
	DO WHILE !EOF()
		SELECT cur_cadena
		APPEND BLANK
		
		REPLACE cur_cadena.idArtic_A WITH cur_eq.idArtic_A
		REPLACE cur_cadena.idArtic_B WITH tnIdArtic_B
		
		APPEND BLANK
		
		REPLACE cur_cadena.idArtic_A WITH tnIdArtic_B
		REPLACE cur_cadena.idArtic_B WITH cur_eq.idArtic_A
		
		SELECT cur_eq
		SKIP
	ENDDO 
ELSE
	SELECT cur_cadena
	APPEND BLANK
	
	REPLACE cur_cadena.idArtic_A WITH this.idArtic_A
	REPLACE cur_cadena.idArtic_B WITH tnIdArtic_B
	
	APPEND BLANK
	
	REPLACE cur_cadena.idArtic_A WITH tnIdArtic_B
	REPLACE cur_cadena.idArtic_B WITH this.idArtic_A

	&& En caso que sea la primer equivalencia cargada debo agregar el articulo primario a cur_eq
	lcSql = "select * from articulos where idArticulo = " + ALLTRIM(STR(this.idartic_a))
	loRes.ActiveConnection = goConn.ActiveConnection
	loRes.Cursor_Name = "cur_x"

	IF !loRes.OpenQuery(lcSql) THEN
		this.ErrorMessage = loRes.Error_Message
		RETURN .F.
	ENDIF

	SELECT cur_eq
	APPEND BLANK

	REPLACE idArtic_A WITH this.idartic_a
	REPLACE codArt_A  WITH cur_x.codArt

	loRes.close_query()
ENDIF 

&& Agrego la equivalencia cargada a cur_eq
SELECT cur_eq
APPEND BLANK

REPLACE idArtic_A WITH tnIdArtic_B 
REPLACE codArt_A WITH tnCodArt_B	ADDITIVE 
ENDPROC
PROCEDURE armar_equivs
LOCAL lcSql, loRes, lnIdArtAux, lcCodArtAux, ln_pos, ln_idArticA 

lcSql = ""
loRes = CREATEOBJECT("odbc_result")
lnIdArtAux = ""
lcCodArtAux = ""
ln_pos = 0
ln_idArticA = 0

SELECT cur_eq	
IF RECCOUNT() > 0 THEN 
	GO TOP 
ENDIF

&& Recorro el cursor y me fijo por cada articulo si tiene mas equivalencias, si las tiene las agrego a este mismo cursor.
DO WHILE !EOF("cur_eq")
	SELECT cur_eq
	ln_pos = RECNO() && Guardo la posicion del cursor para luego de hacer el APPEND retornar el puntero a esa posicion.
	
	&& Levanto las equivalencias del articulo
	lcSql = "select	art_equiv.* "
	lcSql = lcSql + "from art_equiv "
	lcSql = lcSql + "where art_equiv.idArtic_A = " + ALLTRIM(STR(cur_eq.idartic_a)) + " "
	lcSql = lcSql + "	or art_equiv.idArtic_B = " + ALLTRIM(STR(cur_eq.idartic_a)) + " "

	loRes.ActiveConnection = goConn.ActiveConnection
	loRes.Cursor_Name = "cur_aux"
	
	IF !loRes.OpenQuery(lcSql) THEN
		MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
		RETURN .F.
	ENDIF
	
	SELECT cur_aux
	IF RECCOUNT() > 0 	
		GO TOP 
	ENDIF 
	
	&& Las recorro y me fijo si existen en el cursor cur_eq, sino existe agrego el codigo, 
	&& para que luego puedan ser revisadas sus equivalencias
	DO WHILE !EOF("cur_aux")
		lnIdArtAux = cur_aux.idArtic_A
		lcCodArtAux = cur_aux.codArt_A
		
		SELECT cur_eq
		LOCATE FOR cur_eq.idArtic_A = lnIdArtAux 
		
		IF !FOUND("cur_eq") THEN
			SELECT cur_eq
			APPEND BLANK
			REPLACE cur_eq.idArtic_A WITH lnIdArtAux 
			REPLACE cur_eq.codArt_A WITH lcCodArtAux ADDITIVE 
		ENDIF
		
		lnIdArtAux = cur_aux.idArtic_B
		lcCodArtAux = cur_aux.codArt_B
		
		SELECT cur_eq
		LOCATE FOR cur_eq.idArtic_A = lnIdArtAux 
		
		IF !FOUND("cur_eq") THEN
			SELECT cur_eq
			APPEND BLANK
			REPLACE cur_eq.idArtic_A WITH lnIdArtAux 
			REPLACE cur_eq.codArt_A WITH lcCodArtAux ADDITIVE 
		ENDIF
		
		SELECT cur_aux 
		SKIP 
	ENDDO 
	
	loRes.close_query()
	
	SELECT cur_eq
	GO ln_pos && Retorno la posicion del puntero a la ubicacion original
	SKIP 
	
ENDDO   	

*********************************************************************************************************	
SELECT * FROM cur_eq INTO CURSOR cur_aux2

SELECT cur_eq	
IF RECCOUNT() > 0 	
	GO TOP 
ENDIF 

SELECT cur_aux2	
IF RECCOUNT() > 0 	
	GO TOP 
ENDIF 

DO WHILE !EOF("cur_eq")
	ln_idArticA = cur_eq.idArtic_A
	
	DO WHILE !EOF("cur_aux2")
		
		IF ln_idArticA <> cur_aux2.idArtic_A THEN 
			SELECT cur_cadena
			APPEND BLANK
			
			REPLACE cur_cadena.idArtic_A WITH ln_idArticA
			REPLACE cur_cadena.idArtic_B WITH cur_aux2.idArtic_A 
		ENDIF 
		
		SELECT cur_aux2
		SKIP
	ENDDO	
	
	SELECT cur_aux2
	GO TOP 
	
	SELECT cur_eq
	SKIP
ENDDO 

*********************************************************************************************************	
&& Ahora lleno el muestreo
SELECT cur_cadena
IF RECCOUNT("cur_cadena") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_cadena")
	IF cur_cadena.idArtic_A = this.idartic_a THEN 
		lcSql = "SELECT codArt, descripcio "
		lcSql = lcSql + "FROM articulos "
		lcSql = lcSql + "WHERE idArticulo = " + ALLTRIM(STR(cur_cadena.idartic_b)) + " "	

		loRes.ActiveConnection = goConn.ActiveConnection
		loRes.cursor_name = "cur_x"

		IF !loRes.OpenQuery(lcSql) THEN
			this.ErrorMessage = loRes.Error_Message
			RETURN .F.
		ENDIF

		SELECT cur_artequiv
		APPEND BLANK
		REPLACE cur_artequiv.codArt WITH cur_x.codArt
		REPLACE cur_artequiv.descripcio WITH cur_x.descripcio ADDITIVE
	ENDIF
	
	SELECT cur_cadena
	SKIP 
ENDDO

loRes.close_query()

SELECT cur_cadena
IF RECCOUNT("cur_cadena") > 0 THEN
	GO TOP
ENDIF

SELECT cur_artequiv
IF RECCOUNT("cur_artequiv") > 0 THEN
	GO TOP
ENDIF
ENDPROC


************************************************************
OBJETO: cls_control_precios_edit
************************************************************
*** PROPIEDADES ***
BorderStyle = 2
Height = 512
Width = 491
DoCreate = .T.
Caption = "Editor de precios"
Closable = .F.
idarticulo = 0
precio_ing = 0.00
idingdet = 0
idingcab = 0
actualiza_ingresos = .T.
modificado = .F.
Name = "cls_control_precios_edit"

*** METODOS ***
PROCEDURE recuperar_precios
LOCAL loResult
LOCAL lcSql

loResult = CREATEOBJECT("odbc_result")

lcSql = "SELECT codArt, descripcio, prLista, bonif1, bonif2, bonif3, bonif4, "
lcSql = lcSql + "costoRep, margenMax, margenMin, prVentaMax, prVentaMin, "
lcSql = lcSql + "prFinalMax, prFinalMin, alicIVA "
lcSql = lcSql + "FROM articulos "
lcSql = lcSql + "WHERE idArticulo = " + ALLTRIM(STR(Thisform.idarticulo))

loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_art"

IF !loResult.OpenQuery(lcSql) THEN
	MESSAGEBOX(loResult.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_art
IF RECCOUNT("cur_art") > 0 THEN
	Thisform.txtCodigo.Value = cur_art.codArt
	Thisform.txtDescripcion.Value = cur_art.descripcio
	Thisform.txtPrLista.Value = cur_art.prLista
	Thisform.txtBonif1.value = cur_art.bonif1
	Thisform.txtBonif2.Value = cur_art.bonif2
	Thisform.txtBonif3.Value = cur_art.bonif3
	Thisform.txtBonif4.Value = cur_art.bonif4
	Thisform.txtCosto.Value = cur_art.costoRep
	Thisform.txtPorMay.Value = cur_art.margenMax
	Thisform.txtPrVtaMay.Value = cur_art.prVentaMax
	Thisform.txtPorMin.Value = cur_art.margenMin
	Thisform.txtPrVtaMin.Value = cur_art.prVentaMin
	Thisform.txtPrFinalMay.Value = cur_art.prFinalMax
	Thisform.txtPrFinalMin.Value = cur_art.prFinalMin
	THisform.txtAlicIVA.Value = cur_art.alicIVA
	
	&& Levanto los porcentajes en los valores nuevos para el
	&& recalculo del precio nuevo
	Thisform.txtNewBonif1.Value = cur_art.bonif1
	Thisform.txtNewBonif2.Value = cur_art.bonif2
	Thisform.txtNewBonif3.Value = cur_art.bonif3
	Thisform.txtNewBonif4.Value = cur_art.bonif4
	Thisform.txtNewPorMay.Value = cur_art.margenMax
	Thisform.txtNewPorMin.Value = cur_art.margenMin
ENDIF

loResult.Close_Query()

Thisform.txtNewPrLista.Value = Thisform.precio_ing
Thisform.calcular_precios()

RETURN .T.
ENDPROC
PROCEDURE calcular_precios
LOCAL ;
	lnPrLista,;
	lnBonif1,;
	lnBonif2,;
	lnBonif3,;
	lnBonif4,;
	lnCosto,;
	lnPorMay,;
	lnPorMin,;
	lnAlicIVA,;
	lnPrVtaMay,;
	lnPrVtaMin,;
	lnPrFinalMay,;
	lnPrFinalMin
	
lnPrLista = Thisform.txtNewPrLista.Value
lnBonif1 = Thisform.txtNewBonif1.Value
lnBonif2 = Thisform.txtNewBonif2.Value
lnBonif3 = Thisform.txtNewBonif3.Value
lnBonif4 = Thisform.txtNewBonif4.Value
lnPorMay = Thisform.txtNewPorMay.Value
lnPorMin = Thisform.txtNewPorMin.Value
lnAlicIVA = Thisform.txtAlicIVA.Value

lnCosto = lnPrLista - (lnPrLista * (lnBonif1 / 100))
lnCosto = lnCosto - (lnCosto * (lnBonif2 / 100))
lnCosto = lnCosto - (lnCosto * (lnBonif3 / 100))
lnCosto = lnCosto - (lnCosto * (lnBonif4 / 100))

lnPrVtaMay = lnCosto + (lnCosto * (lnPorMay / 100))
lnPrVtaMin = lnCosto + (lnCosto * (lnPorMin / 100))
lnPrFinalMay = lnPrVtaMay + (lnPrVtaMay * (lnAlicIVA / 100))
lnPrFinalMin = lnPrVtaMin + (lnPrVtaMin * (lnAlicIVA / 100))

Thisform.txtNewCosto.Value = ROUND(lnCosto, 2)
Thisform.txtNewPrVtaMay.Value = ROUND(lnPrVtaMay, 2)
Thisform.txtNewPrVtaMin.Value = ROUND(lnPrVtaMin, 2)
Thisform.txtNewPrFinalMay.Value = ROUND(lnPrFinalMay, 2)
Thisform.txtNewPrFinalMin.Value = ROUND(lnPrFinalMin, 2)

ENDPROC


************************************************************
OBJETO: CLSETIQUETA1
************************************************************
*** PROPIEDADES ***
Caption = "Precios actuales"
Height = 15
Left = 9
Top = 82
Width = 103
TabIndex = 17
ForeColor = 0,128,192
Name = "CLSETIQUETA1"

*** METODOS ***


************************************************************
OBJETO: CLSETIQUETA2
************************************************************
*** PROPIEDADES ***
Caption = "Precio de lista:"
Left = 10
Top = 113
TabIndex = 18
Name = "CLSETIQUETA2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Bonif. Prov. 1:"
Height = 15
Left = 10
Top = 139
Width = 79
TabIndex = 19
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Bonif. Prov. 2:"
Height = 15
Left = 10
Top = 163
Width = 79
TabIndex = 20
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Bonif. Prov. 3:"
Height = 15
Left = 10
Top = 187
Width = 79
TabIndex = 21
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta6
************************************************************
*** PROPIEDADES ***
Caption = "Bonif. Prov. 4:"
Height = 15
Left = 10
Top = 211
Width = 79
TabIndex = 22
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: txtPrLista
************************************************************
*** PROPIEDADES ***
Left = 98
ReadOnly = .T.
TabIndex = 23
Top = 109
isnumeric = .T.
Name = "txtPrLista"

*** METODOS ***


************************************************************
OBJETO: txtBonif1
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 98
ReadOnly = .T.
TabIndex = 25
Top = 134
Width = 66
isnumeric = .T.
Name = "txtBonif1"

*** METODOS ***


************************************************************
OBJETO: txtBonif2
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 98
ReadOnly = .T.
TabIndex = 26
Top = 159
Width = 66
isnumeric = .T.
Name = "txtBonif2"

*** METODOS ***


************************************************************
OBJETO: txtBonif3
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 98
ReadOnly = .T.
TabIndex = 27
Top = 183
Width = 66
isnumeric = .T.
Name = "txtBonif3"

*** METODOS ***


************************************************************
OBJETO: txtBonif4
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 98
ReadOnly = .T.
TabIndex = 28
Top = 207
Width = 66
isnumeric = .T.
Name = "txtBonif4"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta7
************************************************************
*** PROPIEDADES ***
Caption = "Costo:"
Height = 15
Left = 10
Top = 234
Width = 42
TabIndex = 29
Name = "Clsetiqueta7"

*** METODOS ***


************************************************************
OBJETO: txtCosto
************************************************************
*** PROPIEDADES ***
Left = 98
ReadOnly = .T.
TabIndex = 30
Top = 231
isnumeric = .T.
Name = "txtCosto"

*** METODOS ***


************************************************************
OBJETO: CLSETIQUETA8
************************************************************
*** PROPIEDADES ***
Caption = "Rentabilidad Mayorista"
Height = 15
Left = 11
Top = 254
Width = 132
TabIndex = 31
Name = "CLSETIQUETA8"

*** METODOS ***


************************************************************
OBJETO: txtPorMay
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 98
ReadOnly = .T.
TabIndex = 32
Top = 274
Width = 66
isnumeric = .T.
Name = "txtPorMay"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta9
************************************************************
*** PROPIEDADES ***
Caption = "Porcentaje:"
Height = 15
Left = 31
Top = 277
Width = 66
TabIndex = 33
Name = "Clsetiqueta9"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta10
************************************************************
*** PROPIEDADES ***
Caption = "Pr. Venta:"
Height = 15
Left = 31
Top = 301
Width = 66
TabIndex = 34
Name = "Clsetiqueta10"

*** METODOS ***


************************************************************
OBJETO: txtPrVtaMay
************************************************************
*** PROPIEDADES ***
Left = 98
ReadOnly = .T.
TabIndex = 35
Top = 298
isnumeric = .T.
Name = "txtPrVtaMay"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta11
************************************************************
*** PROPIEDADES ***
Caption = "Rentabilidad Minorista"
Height = 15
Left = 11
Top = 348
Width = 132
TabIndex = 36
Name = "Clsetiqueta11"

*** METODOS ***


************************************************************
OBJETO: txtPorMin
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 98
ReadOnly = .T.
TabIndex = 37
Top = 368
Width = 66
isnumeric = .T.
Name = "txtPorMin"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta12
************************************************************
*** PROPIEDADES ***
Caption = "Porcentaje:"
Height = 15
Left = 31
Top = 371
Width = 66
TabIndex = 38
Name = "Clsetiqueta12"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta13
************************************************************
*** PROPIEDADES ***
Caption = "Pr. Venta:"
Height = 15
Left = 31
Top = 395
Width = 66
TabIndex = 39
Name = "Clsetiqueta13"

*** METODOS ***


************************************************************
OBJETO: txtPrVtaMin
************************************************************
*** PROPIEDADES ***
Left = 98
ReadOnly = .T.
TabIndex = 40
Top = 392
isnumeric = .T.
Name = "txtPrVtaMin"

*** METODOS ***


************************************************************
OBJETO: CLSLINEA1
************************************************************
*** PROPIEDADES ***
Height = 374
Left = 235
Top = 78
Width = 0
Name = "CLSLINEA1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta14
************************************************************
*** PROPIEDADES ***
Caption = "Precio de lista:"
Left = 249
Top = 113
TabIndex = 41
Name = "Clsetiqueta14"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta15
************************************************************
*** PROPIEDADES ***
Caption = "Bonif. Prov. 1:"
Height = 15
Left = 249
Top = 139
Width = 79
TabIndex = 42
Name = "Clsetiqueta15"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta16
************************************************************
*** PROPIEDADES ***
Caption = "Bonif. Prov. 2:"
Height = 15
Left = 249
Top = 163
Width = 79
TabIndex = 43
Name = "Clsetiqueta16"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta17
************************************************************
*** PROPIEDADES ***
Caption = "Bonif. Prov. 3:"
Height = 15
Left = 249
Top = 187
Width = 79
TabIndex = 44
Name = "Clsetiqueta17"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta18
************************************************************
*** PROPIEDADES ***
Caption = "Bonif. Prov. 4:"
Height = 15
Left = 249
Top = 211
Width = 79
TabIndex = 45
Name = "Clsetiqueta18"

*** METODOS ***


************************************************************
OBJETO: txtNewPrLista
************************************************************
*** PROPIEDADES ***
Left = 337
TabIndex = 1
Top = 109
isnumeric = .T.
Name = "txtNewPrLista"

*** METODOS ***
PROCEDURE calcular
Thisform.calcular_precios()
ENDPROC


************************************************************
OBJETO: txtNewBonif1
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 337
TabIndex = 2
Top = 134
Width = 76
isnumeric = .T.
Name = "txtNewBonif1"

*** METODOS ***
PROCEDURE calcular
Thisform.calcular_precios()
ENDPROC


************************************************************
OBJETO: txtNewBonif2
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 337
TabIndex = 3
Top = 159
Width = 76
isnumeric = .T.
Name = "txtNewBonif2"

*** METODOS ***
PROCEDURE calcular
Thisform.calcular_precios()
ENDPROC


************************************************************
OBJETO: txtNewBonif3
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 337
TabIndex = 4
Top = 183
Width = 76
isnumeric = .T.
Name = "txtNewBonif3"

*** METODOS ***
PROCEDURE calcular
Thisform.calcular_precios()
ENDPROC


************************************************************
OBJETO: txtNewBonif4
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 337
TabIndex = 5
Top = 207
Width = 76
isnumeric = .T.
Name = "txtNewBonif4"

*** METODOS ***
PROCEDURE calcular
Thisform.calcular_precios()
ENDPROC


************************************************************
OBJETO: Clsetiqueta19
************************************************************
*** PROPIEDADES ***
Caption = "Costo:"
Height = 15
Left = 249
Top = 234
Width = 42
TabIndex = 46
Name = "Clsetiqueta19"

*** METODOS ***


************************************************************
OBJETO: txtNewCosto
************************************************************
*** PROPIEDADES ***
Left = 337
ReadOnly = .T.
TabIndex = 6
Top = 231
isnumeric = .T.
Name = "txtNewCosto"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta20
************************************************************
*** PROPIEDADES ***
Caption = "Rentabilidad Mayorista"
Height = 15
Left = 250
Top = 255
Width = 132
TabIndex = 47
Name = "Clsetiqueta20"

*** METODOS ***


************************************************************
OBJETO: txtNewPorMay
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 337
TabIndex = 7
Top = 275
Width = 76
isnumeric = .T.
Name = "txtNewPorMay"

*** METODOS ***
PROCEDURE calcular
Thisform.calcular_precios()
ENDPROC


************************************************************
OBJETO: Clsetiqueta21
************************************************************
*** PROPIEDADES ***
Caption = "Porcentaje:"
Height = 15
Left = 270
Top = 278
Width = 66
TabIndex = 48
Name = "Clsetiqueta21"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta22
************************************************************
*** PROPIEDADES ***
Caption = "Pr. Venta:"
Height = 15
Left = 270
Top = 302
Width = 66
TabIndex = 51
Name = "Clsetiqueta22"

*** METODOS ***


************************************************************
OBJETO: txtNewPrVtaMay
************************************************************
*** PROPIEDADES ***
Left = 337
ReadOnly = .T.
TabIndex = 8
Top = 299
isnumeric = .T.
Name = "txtNewPrVtaMay"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta23
************************************************************
*** PROPIEDADES ***
Caption = "Rentabilidad Minorista"
Height = 15
Left = 250
Top = 348
Width = 132
TabIndex = 52
Name = "Clsetiqueta23"

*** METODOS ***


************************************************************
OBJETO: txtNewPorMin
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 337
TabIndex = 10
Top = 368
Width = 76
isnumeric = .T.
Name = "txtNewPorMin"

*** METODOS ***
PROCEDURE calcular
Thisform.calcular_precios()
ENDPROC


************************************************************
OBJETO: Clsetiqueta24
************************************************************
*** PROPIEDADES ***
Caption = "Porcentaje:"
Height = 15
Left = 270
Top = 371
Width = 66
TabIndex = 53
Name = "Clsetiqueta24"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta25
************************************************************
*** PROPIEDADES ***
Caption = "Pr. Venta:"
Height = 15
Left = 270
Top = 395
Width = 66
TabIndex = 54
Name = "Clsetiqueta25"

*** METODOS ***


************************************************************
OBJETO: txtNewPrVtaMin
************************************************************
*** PROPIEDADES ***
Left = 337
ReadOnly = .T.
TabIndex = 11
Top = 392
isnumeric = .T.
Name = "txtNewPrVtaMin"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta26
************************************************************
*** PROPIEDADES ***
Caption = "Precios nuevos a controlar / corregir"
Height = 15
Left = 250
Top = 82
Width = 217
TabIndex = 57
ForeColor = 0,128,192
Name = "Clsetiqueta26"

*** METODOS ***


************************************************************
OBJETO: CLSLINEA2
************************************************************
*** PROPIEDADES ***
Height = 1
Left = 0
Top = 451
Width = 492
Name = "CLSLINEA2"

*** METODOS ***


************************************************************
OBJETO: Clslinea3
************************************************************
*** PROPIEDADES ***
Height = 1
Left = 1
Top = 100
Width = 492
Name = "Clslinea3"

*** METODOS ***


************************************************************
OBJETO: btnGrabar
************************************************************
*** PROPIEDADES ***
Top = 457
Left = 394
TabIndex = 13
Name = "btnGrabar"

*** METODOS ***
PROCEDURE Click
LOCAL loRes
LOCAL lcSql
LOCAL lnRepuesta

IF thisform.txtNewPrLista.Value = 0 THEN
	MESSAGEBOX("No ha ingresado el precio de lista", 0+48, Thisform.Caption)
	thisform.txtNewPrLista.SetFocus()
	RETURN .f.
ENDIF

loRes = CREATEOBJECT("odbc_result")
lcSql = "CALL arti_actupreGrabar ( " ;
	+ "?pIdArticulo, " ;
	+ "?pPrLista, " ;
	+ "?pBonif1, " ; 
	+ "?pBonif2, " ; 
	+ "?pBonif3, " ;
	+ "?pBonif4, " ;
	+ "?pCostoRep, " ; 
	+ "?pMargenMax, " ;
	+ "?pMargenMin, " ;
	+ "?pPrVentaMax, " ;
	+ "?pPrVentaMin,  " ;
	+ "?pPrFinalMax, " ; 
	+ "?pPrFinalMin, " ;
	+ "?pCodUsu, " ;
	+ "?pIdHostModi) " 
lcSql = loRes.AddParameter(lcSql, "pIdArticulo", ALLTRIM(STR(Thisform.idArticulo)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "pPrLista", ALLTRIM(STR(Thisform.txtNewPrLista.Value, 10, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "pBonif1", ALLTRIM(STR(Thisform.txtNewBonif1.Value, 10, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "pBonif2", ALLTRIM(STR(Thisform.txtNewBonif2.Value, 10, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "pBonif3", ALLTRIM(STR(Thisform.txtNewBonif3.value, 10, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "pBonif4", ALLTRIM(STR(Thisform.txtNewBonif4.Value, 10, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "pCostoRep", ALLTRIM(STR(thisform.txtNewCosto.Value, 10, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "pMargenMax", ALLTRIM(STR(Thisform.txtNewPorMay.Value, 10, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "pMargenMin", ALLTRIM(STR(Thisform.txtNewPorMin.Value, 10, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "pPrVentaMax", ALLTRIM(STR(Thisform.txtNewPrVtaMay.Value, 10, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "pPrVentaMin", ALLTRIM(STR(Thisform.txtNewPrVtaMin.Value, 10, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "pPrFinalMax", ALLTRIM(STR(Thisform.txtNewPrFinalMay.Value, 10, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "pPrFinalMin", ALLTRIM(STR(Thisform.txtNewPrFinalMin.Value, 10, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "pCodUsu", ALLTRIM(gcCodUsu), .t., .f.)
lcSql = loRes.AddParameter(lcSql, "pIdHostModi", ALLTRIM(SYS(0)), .t., .f.)
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_result"
loRes.OpenQuery(lcSql)
IF ALLTRIM(cur_result.result) == "OK" THEN
	MESSAGEBOX("La modificación se grabó con éxito", 0+64, Thisform.Caption)
	loRes.Close_Query()
	Thisform.modificado = .T.
	Thisform.Hide()
	RETURN .T.
ELSE
	MESSAGEBOX(cur_result.result, 0+48, Thisform.Caption)
	Thisform.modificado = .F.
	Thisform.Hide()
	loRes.Close_Query()
	RETURN .T.
ENDIF
ENDPROC


************************************************************
OBJETO: btnCancelar
************************************************************
*** PROPIEDADES ***
Top = 457
Left = 442
Cancel = .T.
TabIndex = 14
Name = "btnCancelar"

*** METODOS ***
PROCEDURE Click
thisform.modificado = .f.
Thisform.Hide()
ENDPROC


************************************************************
OBJETO: Clslinea4
************************************************************
*** PROPIEDADES ***
Height = 1
Left = 2
Top = 77
Width = 492
Name = "Clslinea4"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta27
************************************************************
*** PROPIEDADES ***
Caption = "Código:"
Height = 15
Left = 13
Top = 6
Width = 59
TabIndex = 58
Name = "Clsetiqueta27"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta28
************************************************************
*** PROPIEDADES ***
Caption = "Descripción:"
Height = 15
Left = 13
Top = 29
Width = 74
TabIndex = 60
Name = "Clsetiqueta28"

*** METODOS ***


************************************************************
OBJETO: txtCodigo
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 98
ReadOnly = .T.
TabIndex = 61
Top = 3
Width = 214
Name = "txtCodigo"

*** METODOS ***


************************************************************
OBJETO: txtDescripcion
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 98
ReadOnly = .T.
TabIndex = 62
Top = 26
Width = 380
Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta29
************************************************************
*** PROPIEDADES ***
Caption = "Pr. Final.:"
Height = 15
Left = 270
Top = 326
Width = 66
TabIndex = 50
Name = "Clsetiqueta29"

*** METODOS ***


************************************************************
OBJETO: txtNewPrFinalMay
************************************************************
*** PROPIEDADES ***
Left = 337
ReadOnly = .T.
TabIndex = 9
Top = 323
isnumeric = .T.
Name = "txtNewPrFinalMay"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta30
************************************************************
*** PROPIEDADES ***
Caption = "Pr. Final:"
Height = 15
Left = 270
Top = 419
Width = 66
TabIndex = 56
Name = "Clsetiqueta30"

*** METODOS ***


************************************************************
OBJETO: txtNewPrFinalMin
************************************************************
*** PROPIEDADES ***
Left = 337
ReadOnly = .T.
TabIndex = 12
Top = 416
isnumeric = .T.
Name = "txtNewPrFinalMin"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta31
************************************************************
*** PROPIEDADES ***
Caption = "Pr. Final.:"
Height = 15
Left = 31
Top = 325
Width = 66
TabIndex = 49
Name = "Clsetiqueta31"

*** METODOS ***


************************************************************
OBJETO: txtPrFinalMay
************************************************************
*** PROPIEDADES ***
Left = 98
ReadOnly = .T.
TabIndex = 15
Top = 322
isnumeric = .T.
Name = "txtPrFinalMay"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta32
************************************************************
*** PROPIEDADES ***
Caption = "Pr. Final:"
Height = 15
Left = 31
Top = 419
Width = 66
TabIndex = 55
Name = "Clsetiqueta32"

*** METODOS ***


************************************************************
OBJETO: txtPrFinalMin
************************************************************
*** PROPIEDADES ***
Left = 98
ReadOnly = .T.
TabIndex = 16
Top = 416
isnumeric = .T.
Name = "txtPrFinalMin"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta33
************************************************************
*** PROPIEDADES ***
Caption = "Alícuota I.V.A.:"
Height = 15
Left = 13
Top = 52
Width = 80
TabIndex = 59
Name = "Clsetiqueta33"

*** METODOS ***


************************************************************
OBJETO: txtAlicIVA
************************************************************
*** PROPIEDADES ***
Left = 99
ReadOnly = .T.
TabIndex = 24
Top = 49
isnumeric = .T.
Name = "txtAlicIVA"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta34
************************************************************
*** PROPIEDADES ***
Caption = "%"
Height = 15
Left = 170
Top = 137
Width = 17
TabIndex = 19
Name = "Clsetiqueta34"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta35
************************************************************
*** PROPIEDADES ***
Caption = "%"
Height = 15
Left = 169
Top = 161
Width = 17
TabIndex = 19
Name = "Clsetiqueta35"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta36
************************************************************
*** PROPIEDADES ***
Caption = "%"
Height = 15
Left = 168
Top = 188
Width = 17
TabIndex = 19
Name = "Clsetiqueta36"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta37
************************************************************
*** PROPIEDADES ***
Caption = "%"
Height = 15
Left = 168
Top = 210
Width = 17
TabIndex = 19
Name = "Clsetiqueta37"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta38
************************************************************
*** PROPIEDADES ***
Caption = "%"
Height = 15
Left = 418
Top = 138
Width = 17
TabIndex = 19
Name = "Clsetiqueta38"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta39
************************************************************
*** PROPIEDADES ***
Caption = "%"
Height = 15
Left = 417
Top = 162
Width = 17
TabIndex = 19
Name = "Clsetiqueta39"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta40
************************************************************
*** PROPIEDADES ***
Caption = "%"
Height = 15
Left = 417
Top = 189
Width = 17
TabIndex = 19
Name = "Clsetiqueta40"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta41
************************************************************
*** PROPIEDADES ***
Caption = "%"
Height = 15
Left = 417
Top = 211
Width = 17
TabIndex = 19
Name = "Clsetiqueta41"

*** METODOS ***


************************************************************
OBJETO: cls_control_precios_edit
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_imprimir_etiquetas
************************************************************
*** PROPIEDADES ***
BorderStyle = 1
Height = 523
Width = 946
DoCreate = .T.
Caption = "Imprimir etiquetas para estanterías"
Name = "cls_imprimir_etiquetas"
contenido.Name = "contenido"

*** METODOS ***
PROCEDURE limpiar
thisform.contenido.contenedor_filtros.sel_proveedor.blanquear()
thisform.contenido.contenedor_filtros.sel_familia.blanquear()
thisform.contenido.contenedor_filtros.sel_subfamilia.blanquear()
thisform.contenido.chk_seleccionar_todos.Value = 0
SELECT cur_articulos
ZAP
thisform.contenido.grdArticulos.Refresh()
ENDPROC
PROCEDURE imprimir
SELECT * FROM cur_articulos WHERE sel = .t. INTO CURSOR cur_imprimir
SELECT cur_imprimir
REPORT FORM "rep_etiquetas.frx" TO PRINTER PROMPT PREVIEW
ENDPROC
PROCEDURE Load
DODEFAULT()

CREATE CURSOR cur_articulos ( ;
	sel L,;
	codArt varchar(20),;
	descripcio varchar(100),;
	prFinalMin double)
ENDPROC
PROCEDURE buscar
LOCAL loRes
LOCAL lcSql

loRes = CREATEOBJECT("odbc_result")
lcSql = "CALL articulos_getEtiquetas (?idProv, ?idFamilia, ?idSubFam, ?modificadosHoy)"
lcSql = loRes.AddParameter(lcSql, "idProv", ALLTRIM(STR(thisform.contenido.contenedor_filtros.sel_proveedor.valcpoid)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "idFamilia", ALLTRIM(STR(thisform.contenido.contenedor_filtros.sel_familia.valcpoid)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "idSubFam", ALLTRIM(STR(thisform.contenido.contenedor_filtros.sel_subfamilia.valcpoid)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "modificadosHoy", ALLTRIM(STR(thisform.contenido.contenedor_filtros.grupo_opciones.option1.Value)), .f., .f.)
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"
IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
ELSE
	SELECT cur_articulos
	ZAP
	APPEND FROM DBF("cur_x")
	SELECT cur_articulos
	GO TOP
	Thisform.contenido.grdArticulos.Refresh()
ENDIF
ENDPROC
PROCEDURE Init
SELECT cur_articulos
Thisform.contenido.grdArticulos.alias_name = "cur_articulos"
Thisform.contenido.grdArticulos.RecordSource = "cur_articulos"
Thisform.contenido.grdArticulos.list_controlsource = "sel,codArt,descripcio,prFinalMin"
Thisform.contenido.grdArticulos.lista_ancho_cols = "50,100,350,100"
Thisform.contenido.grdArticulos.titulos_cabeceras = "Sel.,Código,Descripción,Precio"
Thisform.contenido.grdArticulos.generar_grid()

thisform.contenido.contenedor_filtros.sel_proveedor.txtCodigo.ReadOnly= .T.
thisform.contenido.contenedor_filtros.sel_familia.txtCodigo.ReadOnly = .T.
thisform.contenido.contenedor_filtros.sel_subfamilia.txtCodigo.ReadOnly = .T.

Thisform.limpiar()
ENDPROC


************************************************************
OBJETO: contenedor_filtros
************************************************************
*** PROPIEDADES ***
Top = 9
Left = 12
Width = 924
Height = 89
BackStyle = 1
Name = "contenedor_filtros"

*** METODOS ***


************************************************************
OBJETO: grupo_opciones
************************************************************
*** PROPIEDADES ***
BackStyle = 0
Height = 41
Left = 12
Top = 24
Width = 192
Name = "grupo_opciones"
Option1.FontSize = 8
Option1.BackStyle = 0
Option1.Caption = "Artículos modificados hoy"
Option1.Height = 15
Option1.Left = 5
Option1.Top = 5
Option1.Width = 175
Option1.ForeColor = 158,106,75
Option1.Name = "Option1"
Option2.FontSize = 8
Option2.BackStyle = 0
Option2.Caption = "Otros"
Option2.Left = 5
Option2.Top = 22
Option2.ForeColor = 158,106,75
Option2.Name = "Option2"

*** METODOS ***
PROCEDURE Option1.Click
IF this.Value = 1 THEN
	thisform.contenido.contenedor_filtros.sel_proveedor.txtCodigo.ReadOnly= .T.
	thisform.contenido.contenedor_filtros.sel_familia.txtCodigo.ReadOnly = .T.
	thisform.contenido.contenedor_filtros.sel_subfamilia.txtCodigo.ReadOnly = .T.
ENDIF
ENDPROC
PROCEDURE Option2.Click
IF this.Value = 1 THEN
	thisform.contenido.contenedor_filtros.sel_proveedor.txtCodigo.ReadOnly= .F.
	thisform.contenido.contenedor_filtros.sel_familia.txtCodigo.ReadOnly = .F.
	thisform.contenido.contenedor_filtros.sel_subfamilia.txtCodigo.ReadOnly = .F.
ENDIF 
ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Proveedor:"
Height = 12
Left = 213
Top = 12
Width = 75
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Familia:"
Height = 12
Left = 213
Top = 34
Width = 63
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Sub Familia:"
Height = 12
Left = 213
Top = 56
Width = 87
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: sel_proveedor
************************************************************
*** PROPIEDADES ***
Top = 4
Left = 295
nombre_campo_codigo = idprov
nombre_campo_desc = razsoc
nombre_tabla = proveedor
pkfield = idprov
esnumerico = .T.
title_cols = Razón Social
Name = "sel_proveedor"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: sel_familia
************************************************************
*** PROPIEDADES ***
Top = 27
Left = 295
nombre_campo_codigo = idFamilia
nombre_campo_desc = descripcio
nombre_tabla = familias
pkfield = idfamilia
esnumerico = .T.
Name = "sel_familia"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: sel_subfamilia
************************************************************
*** PROPIEDADES ***
Top = 50
Left = 295
nombre_campo_codigo = idSubFam
nombre_campo_desc = descripcio
nombre_tabla = subfam
pkfield = idSubFam
esnumerico = .T.
Name = "sel_subfamilia"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: btnBuscar
************************************************************
*** PROPIEDADES ***
Top = 30
Left = 784
Name = "btnBuscar"

*** METODOS ***
PROCEDURE Click
thisform.buscar()
ENDPROC


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Opciones de filtros"
Height = 12
Left = 19
Top = 12
Width = 126
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: grdArticulos
************************************************************
*** PROPIEDADES ***
Height = 344
Left = 11
Top = 122
Width = 925
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdArticulos"
COLUMN1.Header1.Name = "Header1"
COLUMN1.Text1.ReadOnly = .F.
COLUMN1.Text1.Name = "Text1"
COLUMN1.CurrentControl = "Clscheckbox1"
COLUMN1.ReadOnly = .F.
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


************************************************************
OBJETO: Clscheckbox1
************************************************************
*** PROPIEDADES ***
Top = 22
Left = 39
Alignment = 0
Caption = ""
ReadOnly = .F.
Name = "Clscheckbox1"

*** METODOS ***


************************************************************
OBJETO: btnImprimir
************************************************************
*** PROPIEDADES ***
Top = 468
Left = 843
Name = "btnImprimir"

*** METODOS ***
PROCEDURE Click
thisform.imprimir()
ENDPROC


************************************************************
OBJETO: btnSalir
************************************************************
*** PROPIEDADES ***
Top = 468
Left = 891
Name = "btnSalir"

*** METODOS ***


************************************************************
OBJETO: chk_seleccionar_todos
************************************************************
*** PROPIEDADES ***
Top = 105
Left = 757
Height = 13
Width = 177
Alignment = 0
Caption = "Imprimir todos los artículos"
Name = "chk_seleccionar_todos"

*** METODOS ***
PROCEDURE Click
IF This.Value = 1 THEN
	UPDATE cur_articulos SET sel = .t.
ELSE
	UPDATE cur_articulos SET sel = .f.
ENDIF
ENDPROC


************************************************************
OBJETO: btnLimpiar
************************************************************
*** PROPIEDADES ***
Top = 468
Left = 11
Picture = ..\imagen\iconos bajados\nuevo-icono-8572.ico
ToolTipText = "Nueva búsqueda"
Name = "btnLimpiar"

*** METODOS ***
PROCEDURE Click
thisform.limpiar()
thisform.contenido.contenedor_filtros.grupo_opciones.option1.Value = 1
thisform.contenido.contenedor_filtros.grupo_opciones.option2.Value = 0
thisform.contenido.contenedor_filtros.sel_proveedor.txtCodigo.ReadOnly= .T.
thisform.contenido.contenedor_filtros.sel_familia.txtCodigo.ReadOnly = .T.
thisform.contenido.contenedor_filtros.sel_subfamilia.txtCodigo.ReadOnly = .T.
thisform.contenido.contenedor_filtros.grupo_opciones.option1.SetFocus()


ENDPROC


************************************************************
OBJETO: cls_imprimir_etiquetas
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_historial_precio
************************************************************
*** PROPIEDADES ***
BorderStyle = 2
Height = 370
Width = 718
DoCreate = .T.
Caption = "Historial de precios"
idarticulo = 0
o_res = 
Name = "cls_historial_precio"

*** METODOS ***
PROCEDURE obtener_historico
LOCAL lcSql

this.o_res = CREATEOBJECT("odbc_result")
lcSql = "CALL art_cbios_getByArt(?idArticulo)"
lcSql = this.o_res.AddParameter(lcSql, "idArticulo", ALLTRIM(STR(this.idarticulo)), .f., .f.)
this.o_res.ActiveConnection = goConn.ActiveConnection
this.o_res.Cursor_Name = "cur_historial"
IF !this.o_res.OpenQuery(lcSql) THEN
	MESSAGEBOX(this.o_res.Error_Message, 0+48, Thisform.Caption)
	RETURN
ENDIF
SELECT cur_historial
GO TOP
This.grdHistorial.RecordSource = "cur_historial"
This.grdHistorial.Alias_name = "cur_historial"
This.grdHistorial.list_controlsource = "fecha,prAnt,prNuevo,porVar"
This.grdHistorial.lista_ancho_cols = "130,100,100,100"
This.grdHistorial.titulos_cabeceras = "Fecha,Pr. Ant.,Pr. Actual,% Var."
This.grdHistorial.generar_grid()


ENDPROC
PROCEDURE Unload
this.o_res.Close_Query()
ENDPROC


************************************************************
OBJETO: grdHistorial
************************************************************
*** PROPIEDADES ***
Height = 309
Left = 4
Top = 3
Width = 711
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdHistorial"
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
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 318
Left = 669
Name = "btnCerrar"

*** METODOS ***


************************************************************
OBJETO: cls_historial_precio
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_control_precios_v2
************************************************************
*** PROPIEDADES ***
DoCreate = .T.
Caption = "Control de precios"
MaxButton = .T.
MinButton = .T.
WindowState = 2
Name = "cls_control_precios_v2"
contenido.Name = "contenido"

*** METODOS ***
PROCEDURE obtener_indart
LOCAL loResArt
LOCAL lcSql
LOCAL lcAgruparPor
LOCAL lnCantDias

WAIT WINDOW "Recuperando artículos, espere por favor..." NOWAIT
IF Thisform.contenido.cntParametros.grpAgrupacion.option1.Value = 1 THEN
	lcAgruparPor = "MRC"
ELSE
	IF Thisform.contenido.cntParametros.grpAgrupacion.option2.Value = 1 THEN
		lcAgruparPor = "PRV"
	ENDIF
ENDIF

SELECT cur_indart
ZAP

loResArt = CREATEOBJECT("odbc_result")
lcSql = "CALL cpa_getIndicadorArticulos (?pId, ?pAgruparPor)"
loResArt.ActiveConnection = goConn.ActiveConnection
lcSql = loResArt.AddParameter(lcSql, "pId", ALLTRIM(STR(cur_indgral.id)), .f., .f.)
lcSql = loResArt.AddParameter(lcSql, "pAgruparPor", ALLTRIM(lcAgruparPor), .t., .f.)
loResArt.Cursor_Name = "cur_tmp"
IF !loResArt.OpenQuery(lcSql) THEN
	MESSAGEBOX(loResArt.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF
lnCantDias = This.Contenido.cntParametros.txtCantDias.Value

SELECT cur_indart
APPEND FROM DBF("cur_tmp")
loResArt.Close_Query()

SELECT cur_indart
GO TOP
Thisform.contenido.grdIndArt.Refresh()
WAIT WINDOW "Listo..." NOWAIT
ENDPROC
PROCEDURE obtener_color_fondo
PARAMETERS tnCantDias

RETURN IIF(tnCantDias > Thisform.contenido.cntParametros.txtCantDias.Value ;
	.OR. tnCantDias = -1, RGB(233, 0, 5), RGB(255, 255, 255))
ENDPROC
PROCEDURE obtener_color_texto
PARAMETERS tnCantDias

RETURN IIF(tnCantDias > Thisform.contenido.cntParametros.txtCantDias.Value ;
		.OR. tnCantDias = -1, RGB(255, 255, 255), RGB(0, 0, 0))
ENDPROC
PROCEDURE editar
LOCAL loForm, loRes
LOCAL lcSql

lcSql = ""

SELECT cur_indart
loForm = CREATEOBJECT("cls_control_precios_edit")
loForm.idArticulo = cur_indart.idArticulo
loForm.idIngDet = 0
loForm.idIngCab = 0
loForm.actualiza_ingresos = .F.
loForm.precio_ing = 0.00
loForm.recuperar_precios()

loForm.show()

IF loForm.modificado THEN
	* Hay que ver que conviene hacer al modificar.
ENDIF

loForm.release()
ENDPROC
PROCEDURE buscar
LOCAL loResGral
LOCAL lcSql
LOCAL lcAgruparPor
LOCAL lnCantDias

IF Thisform.contenido.cntParametros.grpAgrupacion.option1.Value = 1 THEN
	lcAgruparPor = "MRC"
ELSE
	IF Thisform.contenido.cntParametros.grpAgrupacion.option2.Value = 1 THEN
		lcAgruparPor = "PRV"
	ENDIF
ENDIF

SELECT cur_indgral
ZAP

loResGral = CREATEOBJECT("odbc_result")
lcSql = "CALL cpa_getIndicadorGeneral (?pAgruparPor)"
lcSql = loResGral.AddParameter(lcSql, "pAgruparPor", ALLTRIM(lcAgruparPor), .t., .f.)
loResGral.ActiveConnection = goConn.ActiveConnection
loResGral.Cursor_Name = "cur_tmp"
IF !loResGral.OpenQuery(lcSql) THEN
	MESSAGEBOX(loResGral.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

lnCantDias = This.contenido.cntParametros.txtCantDias.Value
SELECT cur_indgral
APPEND FROM DBF("cur_tmp")
loResGral.Close_Query()

SELECT cur_indgral
GO TOP
Thisform.contenido.grdIndGral.Refresh()
Thisform.contenido.grdIndGral.SetFocus()

RETURN .T.
ENDPROC
PROCEDURE Init
Thisform.contenido.cntParametros.txtCantDias.Value = getGlobalCFG("CPADIAS")

SELECT cur_indgral
Thisform.contenido.grdIndGral.Alias_Name = "cur_indgral"
Thisform.contenido.grdIndGral.RecordSource = "cur_indgral"
Thisform.contenido.grdIndGral.list_controlsource = "id,descripcio,ultimaAct,cantDias,cantArticulos,promedioVar"
Thisform.contenido.grdIndGral.lista_ancho_cols = "70,250,120,100,100,100"
Thisform.contenido.grdIndGral.titulos_cabeceras = "#,Descripción,Ult. Actualiz.,Cant. Días,Cant. Art.,Promedio Var. (%)"
Thisform.contenido.grdIndGral.SetAll("DynamicBackColor", "Thisform.obtener_color_fondo(cur_indgral.cantDias)")
Thisform.contenido.grdIndGral.SetAll("DynamicForeColor", "Thisform.obtener_color_texto(cur_indgral.cantDias)")
Thisform.contenido.grdIndGral.generar_grid()

SELECT cur_indart
Thisform.contenido.grdIndArt.Alias_Name = "cur_indart"
Thisform.contenido.grdIndArt.RecordSource = "cur_indart"
Thisform.contenido.grdIndArt.list_controlsource = "fecha,codArt,descripcio,prAnt,prNuevo,porVar"
Thisform.contenido.grdIndArt.lista_ancho_cols = "120,100,250,100,100,100"
Thisform.contenido.grdIndArt.titulos_cabeceras = "Fecha,Código,Descripción,Pr. Ant.,Pr. Actual,% Var."
Thisform.contenido.grdIndArt.SetAll("DynamicBackColor", "Thisform.obtener_color_fondo(cur_indart.cantDias)")
Thisform.contenido.grdIndArt.SetAll("DynamicForeColor", "Thisform.obtener_color_texto(cur_indart.cantDias)")
Thisform.contenido.grdIndArt.generar_grid()
Thisform.contenido.grdIndArt.Refresh()
ENDPROC
PROCEDURE Load
DODEFAULT()
CREATE CURSOR cur_indgral ( ;
	id int,;
	descripcio varchar(60),;
	ultimaAct varchar(20),;
	cantDias int,;
	cantArticulos int,;
	promedioVar double)

CREATE CURSOR cur_indart ( ;
	idArticulo int,;
	fecha varchar(20),;
	codArt varchar(20),;
	descripcio varchar(100),;
	prAnt double,;
	prNuevo double,;
	porVar double,;
	cantDias int)

SELECT cur_indart
INDEX ON idArticulo TAG idArticulo ASCENDING
INDEX ON fecha TAG fecha ASCENDING ADDITIVE
INDEX ON codArt TAG codArt ASCENDING ADDITIVE
INDEX ON descripcio TAG descripcio ASCENDING ADDITIVE
INDEX ON prAnt TAG prAnt ASCENDING ADDITIVE
INDEX ON prNuevo TAG prNuevo ASCENDING ADDITIVE
INDEX ON porVar TAG porVar ASCENDING ADDITIVE
INDEX ON cantDias TAG cantDias ASCENDING ADDITIVE
ENDPROC


************************************************************
OBJETO: cntParametros
************************************************************
*** PROPIEDADES ***
Anchor = 11
Top = 7
Left = 10
Width = 924
Height = 73
TabIndex = 1
Name = "cntParametros"

*** METODOS ***


************************************************************
OBJETO: grpAgrupacion
************************************************************
*** PROPIEDADES ***
Anchor = 3
BackStyle = 0
Height = 64
Left = 5
Top = 6
Width = 204
Name = "grpAgrupacion"
Option1.FontSize = 8
Option1.BackStyle = 0
Option1.Caption = "Marca"
Option1.Left = 38
Option1.Top = 22
Option1.ForeColor = 158,106,75
Option1.Name = "Option1"
Option2.FontSize = 8
Option2.BackStyle = 0
Option2.Caption = "Proveedor"
Option2.Left = 38
Option2.Top = 39
Option2.ForeColor = 158,106,75
Option2.Name = "Option2"

*** METODOS ***


************************************************************
OBJETO: CLSETIQUETA1
************************************************************
*** PROPIEDADES ***
Anchor = 3
Caption = "Cantidad de días:"
Height = 12
Left = 221
Top = 7
Width = 108
Name = "CLSETIQUETA1"

*** METODOS ***


************************************************************
OBJETO: txtCantDias
************************************************************
*** PROPIEDADES ***
Anchor = 3
Height = 21
Left = 328
Top = 4
Width = 76
isinteger = .T.
Name = "txtCantDias"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Agrupado por:"
Height = 12
Left = 11
Top = 7
Width = 108
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: btnBuscar
************************************************************
*** PROPIEDADES ***
Top = 25
Left = 875
Anchor = 12
Name = "btnBuscar"

*** METODOS ***
PROCEDURE Click
Thisform.buscar()
ENDPROC


************************************************************
OBJETO: grdIndGral
************************************************************
*** PROPIEDADES ***
Anchor = 15
Height = 149
Left = 10
TabIndex = 2
Top = 97
Width = 924
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdIndGral"
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
PROCEDURE ActivateCell
LPARAMETERS nRow, nCol

ENDPROC
PROCEDURE AfterRowColChange
LPARAMETERS nColIndex

Thisform.obtener_indart()
ENDPROC


************************************************************
OBJETO: grdIndArt
************************************************************
*** PROPIEDADES ***
Anchor = 14
Height = 231
Left = 10
TabIndex = 3
Top = 287
Width = 884
permitir_busqueda = .T.
permitir_ordenamiento = .T.
Name = "grdIndArt"
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
PROCEDURE press_enter
thisform.editar()
ENDPROC


************************************************************
OBJETO: CLSETIQUETA1
************************************************************
*** PROPIEDADES ***
Caption = "Marcas/Proveedores"
Height = 12
Left = 11
Top = 81
Width = 146
TabIndex = 8
Name = "CLSETIQUETA1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Anchor = 14
Caption = "Artículos"
Height = 12
Left = 11
Top = 267
Width = 86
TabIndex = 9
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clslinea1
************************************************************
*** PROPIEDADES ***
Anchor = 14
Height = 1
Left = 12
Top = 253
Width = 921
Name = "Clslinea1"

*** METODOS ***


************************************************************
OBJETO: btnEditar
************************************************************
*** PROPIEDADES ***
Top = 286
Left = 899
Anchor = 12
Default = .F.
TabIndex = 4
Name = "btnEditar"

*** METODOS ***
PROCEDURE Click
Thisform.editar()
ENDPROC


************************************************************
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 526
Left = 899
Anchor = 12
TabIndex = 6
Name = "btnCerrar"

*** METODOS ***


************************************************************
OBJETO: btnDetalles
************************************************************
*** PROPIEDADES ***
Top = 331
Left = 899
Anchor = 12
TabIndex = 5
Name = "btnDetalles"

*** METODOS ***
PROCEDURE Click
LOCAL loForm

loForm = CREATEOBJECT("cls_historial_precio")
loForm.idArticulo = cur_indart.idArticulo
=loForm.obtener_historico()
loForm.Show()
ENDPROC


************************************************************
OBJETO: chkSoloActualizados
************************************************************
*** PROPIEDADES ***
Top = 268
Left = 649
Height = 12
Width = 240
Anchor = 12
Alignment = 0
Caption = "Mostrar solo artículos desactualizados"
Name = "chkSoloActualizados"

*** METODOS ***
PROCEDURE Click
IF This.Value = 1 THEN
	SELECT cur_indart
	SET FILTER TO cur_indart.cantDias > Thisform.contenido.cntParametros.txtCantDias.Value ;
		.OR. cur_indart.cantDias = -1
ELSE
	SELECT cur_indart
	SET FILTER TO
ENDIF
Thisform.contenido.grdIndArt.Refresh()
ENDPROC


************************************************************
OBJETO: cls_control_precios_v2
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_nueva_marca
************************************************************
*** PROPIEDADES ***
DoCreate = .T.
Caption = "Nueva marca"
c_tabla = marcas
c_fkfield = idMarca
c_descripcio_field = descripcio
Name = "cls_nueva_marca"
Clsetiqueta1.Name = "Clsetiqueta1"
txtDescripcion.Name = "txtDescripcion"
btnGrabar.Name = "btnGrabar"
btnCancelar.Name = "btnCancelar"

*** METODOS ***


************************************************************
OBJETO: cls_nueva_marca
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_nueva_familia
************************************************************
*** PROPIEDADES ***
DoCreate = .T.
Caption = "Nueva familia"
c_tabla = familias
c_fkfield = idFamilia
c_descripcio_field = descripcio
Name = "cls_nueva_familia"
Clsetiqueta1.Name = "Clsetiqueta1"
txtDescripcion.Name = "txtDescripcion"
btnGrabar.Name = "btnGrabar"
btnCancelar.Name = "btnCancelar"

*** METODOS ***


************************************************************
OBJETO: cls_nueva_familia
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_nueva_subfamilia
************************************************************
*** PROPIEDADES ***
DoCreate = .T.
Caption = "Nueva Subfamilia"
c_tabla = subfam
c_fkfield = idSubFam
c_descripcio_field = descripcio
Name = "cls_nueva_subfamilia"
Clsetiqueta1.Name = "Clsetiqueta1"
txtDescripcion.Name = "txtDescripcion"
btnGrabar.Name = "btnGrabar"
btnCancelar.Name = "btnCancelar"

*** METODOS ***


************************************************************
OBJETO: cls_nueva_subfamilia
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_adminfalt
************************************************************
*** PROPIEDADES ***
BorderStyle = 2
Height = 538
Width = 976
DoCreate = .T.
ShowTips = .F.
Caption = "Administración de faltantes"
Name = "cls_adminfalt"
contenido.Top = -1
contenido.Left = -1
contenido.Width = 985
contenido.Height = 574
contenido.Name = "contenido"

*** METODOS ***
PROCEDURE buscar_faltantes
LOCAL lcSql
LOCAL loResult

SELECT cur_faltantes
ZAP

lcSql = ""
loResult = CREATEOBJECT("odbc_result")

lcSql = "select	faltantes.*, articulos.descripcio, "
lcSql = lcSql + "	marcas.idMarca, "
lcSql = lcSql + "	marcas.descripcio as descMarca, "
lcSql = lcSql + "	proveedor.idProv, "
lcSql = lcSql + "	proveedor.razSoc AS razSocPV, "
lcSql = lcSql + "	articulos.costorep, "
lcSql = lcSql + "	articulos.prlista "
lcSql = lcSql + "from	faltantes "
lcSql = lcSql + "	inner join articulos on faltantes.idArticulo = articulos.idArticulo "
lcSql = lcSql + "	inner join marcas on articulos.idMarca = marcas.idMarca "
lcSql = lcSql + "	inner join proveedor on articulos.idProv = proveedor.idProv "
lcSql = lcSql + "where faltantes.procesado = 0 "
lcSql = lcSql + "	and faltantes.fecBaja is null "

IF THISFORM.Contenido.sel_marca.txtCodigo.Value <> 0 THEN
	lcSql = lcSql + " and marcas.idMarca = " + ALLTRIM(STR(THISFORM.Contenido.sel_marca.valcpoid))
ENDIF
lcSql = lcSql + " order by articulos.descripcio asc, articulos.codArt asc"

loResult.ActiveConnection = goConn.ActiveConnection
loResult.cursor_name = "cur_x"

IF !loResult.OpenQuery(lcSql) THEN
	MESSAGEBOX(loResult.Error_Message, 0+48, Thisform.Caption)
	RETURN
ENDIF

SELECT cur_x
IF RECCOUNT("cur_x") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_x")
	SELECT cur_faltantes
	APPEND BLANK
	REPLACE cur_faltantes.sel WITH .F. 
	REPLACE cur_faltantes.idFaltante WITH cur_x.idFaltante ADDITIVE
	REPLACE cur_faltantes.idArticulo WITH cur_x.idArticulo ADDITIVE
	REPLACE cur_faltantes.idProv WITH cur_x.idProv ADDITIVE
	REPLACE cur_faltantes.razSocPV WITH cur_x.razSocPV ADDITIVE
	REPLACE cur_faltantes.codArt WITH cur_x.codArt ADDITIVE
	REPLACE cur_faltantes.descripcio WITH cur_x.descripcio ADDITIVE
	REPLACE cur_faltantes.idMarca WITH cur_x.idMarca ADDITIVE
	REPLACE cur_faltantes.descMarca WITH cur_x.descMarca ADDITIVE
	REPLACE cur_faltantes.unidCPR WITH cur_x.uniCpr ADDITIVE
	REPLACE cur_faltantes.cantidad WITH cur_x.cantidad ADDITIVE
	REPLACE cur_faltantes.costo WITH cur_x.costorep ADDITIVE 
	REPLACE cur_faltantes.prlista WITH cur_x.prlista ADDITIVE 
	REPLACE cur_faltantes.usuAlta WITH cur_x.usuAlta ADDITIVE
	REPLACE cur_faltantes.fecAlta WITH cur_x.fecAlta ADDITIVE
	REPLACE cur_faltantes.idHostAlta WITH cur_x.idHostAlta ADDITIVE

	SELECT cur_x
	SKIP
ENDDO

loResult.Close_Query()

SELECT cur_faltantes
IF RECCOUNT("cur_faltantes") > 0 THEN
	GO TOP
ENDIF
ENDPROC
PROCEDURE Init
DODEFAULT()

thisform.contenido.oc.crear_cursor()
THISFORM.buscar_faltantes()

SELECT cur_faltantes
THISFORM.Contenido.grdFaltantes.alias_name = "cur_faltantes"
THISFORM.Contenido.grdFaltantes.list_controlsource = "sel,codArt,descripcio,idMarca,descMarca,cantidad,razSocPV"
THISFORM.Contenido.grdFaltantes.lista_ancho_cols = "40,100,300,70,200,70,100"
THISFORM.Contenido.grdFaltantes.titulos_cabeceras = "#,Código,Descripción,Cod. Marca,Marca,Cantidad,Proveedor"
THISFORM.Contenido.grdFaltantes.generar_grid()

THISFORM.Contenido.grdFaltantes.Columns[2].SetFocus()


ENDPROC
PROCEDURE Load
DODEFAULT()

CREATE CURSOR cur_faltantes ( ;
	sel			L,;
	idFaltante	int,;
	idArticulo	int,;
	idProv		int,;
	razSocPV	varchar(60),;
	codArt		varchar(20),;
	descripcio	varchar(200),;
	idMarca		int,;
	descMarca	varchar(60),;
	unidCPR		float(10, 2),;
	cantidad	float(10, 2),;
	Costo		float(10, 2),;
	PrLista		float(10, 2),;
	usuAlta		varchar(5),;
	fecAlta		datetime,;
	idHostAlta	varchar(50))
ENDPROC


************************************************************
OBJETO: grdFaltantes
************************************************************
*** PROPIEDADES ***
Height = 437
Left = 6
TabIndex = 3
ToolTipText = ""
Top = 50
Width = 968
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdFaltantes"
COLUMN1.Header1.Name = "Header1"
COLUMN1.Text1.ReadOnly = .F.
COLUMN1.Text1.Name = "Text1"
COLUMN1.CurrentControl = "CLSCHECKBOX1"
COLUMN1.ReadOnly = .F.
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
LOCAL lo_form

KEYBOARD '\{LEFTARROW}\'

lo_form = CREATEOBJECT("cls_editfalt")
lo_form.show(1)
lo_Form.cboUnidCpa.setfocus()

IF lo_form.dialog_result = 1 THEN
	SELECT cur_faltantes
	THISFORM.Contenido.grdFaltantes.Refresh
ENDIF

lo_form.Release()



ENDPROC


************************************************************
OBJETO: CLSCHECKBOX1
************************************************************
*** PROPIEDADES ***
Top = 30
Left = 56
Alignment = 0
Caption = ""
Name = "CLSCHECKBOX1"

*** METODOS ***


************************************************************
OBJETO: btnGrabar
************************************************************
*** PROPIEDADES ***
Top = 491
Left = 878
TabIndex = 4
Name = "btnGrabar"

*** METODOS ***
PROCEDURE Click
LOCAL lnIdArticulo, lcCodArt, lcDesc, lnCosto, lnPrLista
LOCAL lnUniDesp, lnCantpack, lnCantPed, lnIdMarca

lnIdArticulo = 0
lcCodArt = ""
lcDesc = ""
lnCosto = 0.00
lnPrLista = 0.00
lnUniDesp = 0.00
lncantPack = 0.00
lnCantPed = 0.00
lnIdMarca = thisform.contenido.sel_marca.txtCodigo.Value 

SELECT cur_faltantes
IF RECCOUNT("cur_faltantes") > 0 THEN 
	GO TOP 
ELSE 
	RETURN .F.
ENDIF 

&& Armo un cursor con los proveedores a los que se les debe generar OC
SELECT idProv FROM cur_faltantes WHERE sel = .T. GROUP BY idProv ORDER BY idProv INTO CURSOR cur_prov

SELECT cur_prov
GO TOP 

&& Recorro el cursor por cada proveedor y genero la OC
DO WHILE !EOF("cur_prov")
	
	&& Recorro los articulos que voy a insertar en la OC del proveedor
	SELECT cur_faltantes
	GO TOP 
	
	DO WHILE !EOF("cur_faltantes")
		IF (cur_faltantes.idProv = cur_prov.idProv) .AND. cur_faltantes.sel THEN 

			&& Asigno los valores a las variables.
			lnIdArticulo = cur_faltantes.idArticulo
			lcCodArt = cur_faltantes.CodArt
			lcDesc = cur_faltantes.descripcio
			lnCantidad = cur_faltantes.cantidad
			lnCosto = cur_faltantes.costo
			lnPrLista = cur_faltantes.prlista
			lnCantPed = cur_faltantes.cantidad
			lnUniDesp = cur_faltantes.unidCPR
			
			IF lnUniDesp = 0 THEN
				lnCantPack = 0
			ELSE
				lnCantPack = ROUND(lnCantPed / lnUniDesp, 2)
			ENDIF

			thisform.contenido.oc.agregar_detalle(0, 0, lnIdArticulo, lcCodArt, lcDesc, ;
				0.00, 0.00, 0.00, 0.00, lnCantPed, lnUniDesp, lnCantPack, 0.00, 0.00, ;
				0.00, lnCosto, lnPrLista)
		ENDIF 

		SELECT cur_faltantes
		SKIP
	ENDDO 
	
	thisform.contenido.oc.idProv = cur_prov.idProv
	thisform.contenido.oc.idMarca = lnIdMarca
	thisform.contenido.oc.fecent = DATETIME()
	thisform.contenido.oc.usualta = ALLTRIM(gcCodUsu)
	thisform.contenido.oc.fecalta = DATETIME()
	thisform.contenido.oc.idhostalta = SYS(0)

	thisform.contenido.oc.totalizar()
	
	&& ------------------------------------------------------------------------------------
	&& Mando a Generar la OC
	SELECT cur_pcdet
	IF RECCOUNT("cur_pcdet") = 0 THEN 
		RETURN .F.
	ENDIF 

	IF !thisform.contenido.oc.generar_oc() THEN
		RETURN
	ENDIF

	&& Marco como procesado los faltantes
	SELECT cur_faltantes
	GO TOP 
	
	goConn.BeginTransaction()
	
	DO WHILE !EOF("cur_faltantes")
		IF (cur_faltantes.idProv = cur_prov.idProv .AND. cur_faltantes.sel = .T.) THEN  
			thisform.contenido.faltantes.procesar(cur_faltantes.idFaltante, thisform.contenido.oc.idoccab)		
		ENDIF
		
		SELECT cur_faltantes
		SKIP  
	ENDDO 
	
	goConn.Commit()

	MESSAGEBOX("La Orden de Compra N° " + ALLTRIM(STR(thisform.contenido.oc.idoccab)) + " se ha generado con éxito",0+64, Thisform.Caption)

	thisform.contenido.oc.imprimir_oc()

	SELECT cur_pcdet
	ZAP 
	
	SELECT cur_ocdet
	ZAP 

	SELECT cur_prov
	SKIP 	
ENDDO 

Thisform.Contenido.sel_marca.blanquear()
Thisform.Contenido.sel_marca.txtCodigo.SetFocus()
thisform.buscar_faltantes()	
thisform.contenido.grdFaltantes.Refresh()


ENDPROC


************************************************************
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 491
Left = 926
TabIndex = 5
Name = "btnCerrar"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Marca:"
Height = 15
Left = 11
Top = 16
Width = 48
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: sel_marca
************************************************************
*** PROPIEDADES ***
Top = 12
Left = 56
Width = 483
Height = 25
TabIndex = 1
nombre_campo_codigo = idmarca
nombre_campo_desc = descripcio
nombre_tabla = marcas
pkfield = idmarca
esnumerico = .T.
Name = "sel_marca"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: btnBuscar
************************************************************
*** PROPIEDADES ***
Top = 4
Left = 552
Height = 44
Width = 45
TabIndex = 2
Name = "btnBuscar"

*** METODOS ***
PROCEDURE Click
THISFORM.buscar_faltantes()
THISFORM.Contenido.grdFaltantes.Refresh()
ENDPROC


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Para asignar un proveedor, seleccione un registro de la grilla y luego presione la tecla ENTER."
Height = 15
Left = 66
Top = 493
Width = 516
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: OC
************************************************************
*** PROPIEDADES ***
Top = 517
Left = 385
Height = 17
Width = 36
Name = "OC"

*** METODOS ***


************************************************************
OBJETO: faltantes
************************************************************
*** PROPIEDADES ***
Top = 517
Left = 457
Height = 17
Width = 38
Name = "faltantes"

*** METODOS ***


************************************************************
OBJETO: Clsexcel1
************************************************************
*** PROPIEDADES ***
Top = 491
Left = 830
Name = "Clsexcel1"

*** METODOS ***
PROCEDURE Click
SELECT cur_faltantes
IF RECCOUNT() > 0
	genexcel("cur_faltantes","Faltantes")
ELSE 
	MESSAGEBOX("No hay registros para exportar",0+48,Thisform.Caption)
	RETURN
ENDIF 
ENDPROC


************************************************************
OBJETO: Clsdelete1
************************************************************
*** PROPIEDADES ***
Top = 490
Left = 8
Name = "Clsdelete1"

*** METODOS ***
PROCEDURE Click
SELECT cur_faltantes
IF RECCOUNT("cur_faltantes") > 0 THEN 
	GO TOP 
ELSE 
	RETURN .F.
ENDIF 

IF MESSAGEBOX("¿Está seguro que desea dar de baja los faltantes?",4+32,Thisform.Caption) = 6 THEN 

	&& Doy de baja los faltantes
	DO WHILE !EOF("cur_faltantes")
		IF cur_faltantes.sel = .T. THEN  
			thisform.contenido.faltantes.eliminar(cur_faltantes.idFaltante)		
		ENDIF
		
		SELECT cur_faltantes
		SKIP  
	ENDDO 

	MESSAGEBOX("Los faltantes fueron dados de baja con éxito",0+64, Thisform.Caption)


	SELECT cur_pcdet
	ZAP 

	SELECT cur_ocdet
	ZAP 

	Thisform.Contenido.sel_marca.blanquear()
	Thisform.Contenido.sel_marca.txtCodigo.SetFocus()
	thisform.buscar_faltantes()	
	thisform.contenido.grdFaltantes.Refresh()
ENDIF 

ENDPROC


************************************************************
OBJETO: cls_adminfalt
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_alta_articulo
************************************************************
*** PROPIEDADES ***
BorderStyle = 2
Height = 467
Width = 874
DoCreate = .T.
Caption = "Alta de artículos"
registro_nuevo_ok = .F.
Name = "cls_alta_articulo"

*** METODOS ***
PROCEDURE calcular_precios
**
* Calcula los precios.
* Este método se ejecuta en el lostfocus de los controles de precios
* Desarrollado por LINFOW
* Fecha: 04/08/2021
**

LOCAL ln_prlista, ln_bonif1, ln_bonif2, ln_bonif3, ln_bonif4, ln_costo
LOCAL ln_aliciva, ln_margenmax, ln_margenmin, ln_prventamax, ln_prventamin, ln_prfinalmax, ln_prfinalmin

ln_costo = 0.00
ln_prventamax = 0.00
ln_prventamin = 0.00
ln_prfinalmax = 0.00
ln_prfinalmin = 0.00

WITH Thisform
	ln_prlista 		= .txtPrLista.value
	ln_bonif1 		= .txtBonif1.value
	ln_bonif2 		= .txtBonif2.value
	ln_bonif3 		= .txtBonif3.value
	ln_bonif4 		= .txtBonif4.value
	ln_aliciva 	 	= Thisform.txtAlicIVA.Value
	ln_margenmax 	= .txtMargenMax.value
	ln_margenmin	= .txtMargenMin.value
ENDWITH

ln_costo = ln_prlista - (ln_prlista * (ln_bonif1 / 100))
ln_costo = ln_costo - (ln_costo * (ln_bonif2 / 100))
ln_costo = ln_costo - (ln_costo * (ln_bonif3 / 100))
ln_costo = ln_costo - (ln_costo * (ln_bonif4 / 100))

ln_prventamax = ln_costo + (ln_costo * (ln_margenmax / 100))
ln_prventamin = ln_costo + (ln_costo * (ln_margenmin / 100))

ln_prfinalmax = ln_prventamax + (ln_prventamax * (ln_aliciva / 100))
ln_prfinalmin = ln_prventamin + (ln_prventamin * (ln_aliciva / 100))

Thisform.txtCostoRep.Value = ROUND(ln_costo, 2)
Thisform.txtPrVentaMax.Value = ROUND(ln_prventamax , 2)
Thisform.txtPrVentaMin.Value = ROUND(ln_prventamin , 2)
Thisform.txtPrFinalMax.Value = ROUND(ln_prfinalmax , 2)
Thisform.txtPrFinalMin.Value = ROUND(ln_prfinalmin , 2)

ENDPROC
PROCEDURE validar_datos
**
* Valido que los datos se hayan cargado.
* Desarrollado por: Leonardo D. Zulli
* Fecha: 04/08/2021
**

IF (ALLTRIM(Thisform.txtCodArt.Value) == "") THEN
	MESSAGEBOX("Debe ingresar el código", 0+48, Thisform.Caption)
	Thisform.txtCodArt.SetFocus()
	RETURN .F.
ENDIF

IF (ALLTRIM(Thisform.txtCodProv.Value) == "") THEN
	MESSAGEBOX("Debe ingresar el código tal cual viene del proveedor", 0+48, Thisform.Caption)
	Thisform.txtCodProv.SetFocus()
	RETURN .F.
ENDIF

IF (ALLTRIM(Thisform.txtDescripcion.Value) == "") THEN
	MESSAGEBOX("Debe ingresar la descripción", 0+48, Thisform.Caption)
	Thisform.txtDescripcion.SetFocus()
	RETURN .F.
ENDIF

IF Thisform.sel_Proveedor.valcpoid = 0 THEN
	MESSAGEBOX("Debe ingresar el proveedor", 0+48, Thisform.Caption)
	Thisform.sel_Proveedor.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

IF Thisform.sel_Familia.valcpoid = 0 THEN
	MESSAGEBOX("Debe ingresar la familia", 0+48, Thisform.Caption)
	Thisform.sel_Familia.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

IF Thisform.sel_subFamilia.valcpoid = 0 THEN
	MESSAGEBOX("Debe ingresar la subfamilia", 0+48, Thisform.Caption)
	Thisform.sel_subFamilia.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

IF Thisform.sel_marca.valcpoid = 0 THEN
	MESSAGEBOX("Debe ingresar la marca", 0+48, Thisform.Caption)
	Thisform.sel_marca.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

IF Thisform.sel_unimed.valcpoid = 0 THEN
	MESSAGEBOX("Debe ingresar la unidad de medida", 0+48, Thisform.Caption)
	Thisform.sel_unimed.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

IF Thisform.txtPrLista.Value = 0 THEN
	MESSAGEBOX("El precio de lista no puede ser cero", 0+48, Thisform.Caption)
	Thisform.txtPrLista.SetFocus()
	RETURN .F.
ENDIF

RETURN .T.
ENDPROC
PROCEDURE establecer_valores_default
**
* Establezco los valores por defecto
* Desarrollado por: Leonardo D. Zulli
* Fecha: 04/08/2021
**

&& Establezco el valor por defecto de los selectores tomando
&& los mismos desde la configuración global.
Thisform.sel_Familia.txtCodigo.Value = getGlobalCFG("UPDFAMDEF")
Thisform.sel_Familia.txtCodigo.LostFocus()

Thisform.sel_SubFamilia.txtCodigo.Value = getGlobalCFG("UPDSUBFDEF")
Thisform.sel_SubFamilia.txtCodigo.LostFocus()

Thisform.sel_Marca.txtCodigo.Value = getGlobalCFG("UPDMARDEF")
Thisform.sel_Marca.txtCodigo.LostFocus()

&& Unidad de medida por defecto
Thisform.sel_unimed.txtCodigo.Value = "UNI"
Thisform.sel_unimed.txtCodigo.LostFocus()

&& Pongo el proveedor por defecto según lo que fué cargado en el
&& formulario padre
Thisform.sel_Proveedor.txtCodigo.Value = gnSelectedIdProv
Thisform.sel_Proveedor.txtCodigo.LostFocus()

&& Tipo de moneda por defecto
Thisform.cmbTipoMon.ListIndex = 1
ENDPROC
PROCEDURE grabar
**
* Permite dar de alta el artículo.
* Desarrollado por: Leonardo D. Zulli
* Fecha: 04/08/2021
**

LOCAL loCmd
LOCAL lcSql

loCmd = CREATEOBJECT("odbc_command")

&& Armo el llamado al SP
TEXT TO loCmd.commandText NOSHOW
	CALL articulos_insert(
		?p_idprov, 
		?p_idfamilia, 
		?p_idsubfam, 
		?p_idmarca, 
		?p_codart, 
		?p_descripcio, 
		?p_aliciva, 
		?p_tmon, 
		?p_prlistaext, 
		?p_cotizac, 
		?p_prlista, 
		?p_bonif1, 
		?p_bonif2, 
		?p_bonif3, 
		?p_bonif4, 
		?p_costorep, 
		?p_margenmax, 
		?p_margenmin, 
		?p_prventamax, 
		?p_prventamin, 
		?p_prfinalmax, 
		?p_prfinalmin, 
		?p_observ, 
		?p_habilitado,
		?p_linkfoto, 
		?p_usualta, 
		?p_idhostalta,
		?p_esserv, 
		?p_idunimed, 
		?p_cod_art_prov, 
		?p_mostrador
	);
ENDTEXT

&& Paso los valores a los parámetros
loCmd.AddParameter("p_idprov", ALLTRIM(STR(Thisform.sel_proveedor.valcpoid)), .f., .f.)
loCmd.AddParameter("p_idfamilia", ALLTRIM(STR(Thisform.sel_Familia.valcpoid)), .f., .f.)
loCmd.AddParameter("p_idsubfam", ALLTRIM(STR(Thisform.sel_SubFamilia.valcpoid)), .f., .f.)
loCmd.AddParameter("p_idmarca", ALLTRIM(STR(Thisform.sel_marca.valcpoid)), .f., .f.)
loCmd.AddParameter("p_codart", ALLTRIM(Thisform.txtCodArt.Value), .t., .f.)
loCmd.AddParameter("p_descripcio", ALLTRIM(Thisform.txtDescripcion.Value), .t., .f.)
loCmd.AddParameter("p_aliciva", ALLTRIM(STR(Thisform.txtAlicIVA.Value, 10, 2)), .f., .f.) 
loCmd.AddParameter("p_tmon", ALLTRIM(Thisform.cmbTipoMon.Value), .t., .f.) 
loCmd.AddParameter("p_prlistaext", ALLTRIM(STR(Thisform.txtPrExt.Value, 20, 2)), .f., .f.) 
loCmd.AddParameter("p_cotizac", ALLTRIM(STR(Thisform.txtCotizacion.Value, 20, 2)), .f., .f.)
loCmd.AddParameter("p_prlista", ALLTRIM(STR(Thisform.txtPrLista.Value, 20, 2)), .f., .f.)
loCmd.AddParameter("p_bonif1", ALLTRIM(STR(Thisform.txtBonif1.Value, 10, 2)), .f., .f.)
loCmd.AddParameter("p_bonif2", ALLTRIM(STR(Thisform.txtBonif2.Value, 10, 2)), .f., .f.)
loCmd.AddParameter("p_bonif3", ALLTRIM(STR(Thisform.txtBonif3.Value, 10, 2)), .f., .f.)
loCmd.AddParameter("p_bonif4", ALLTRIM(STR(Thisform.txtBonif4.Value, 10, 2)), .f., .f.)
loCmd.AddParameter("p_costorep", ALLTRIM(STR(Thisform.txtCostoRep.Value, 20, 2)), .f., .f.)
loCmd.AddParameter("p_margenmax", ALLTRIM(STR(Thisform.txtMargenMax.Value, 10, 2)), .f., .f.)
loCmd.AddParameter("p_margenmin", ALLTRIM(STR(Thisform.txtMargenMin.Value, 10, 2)), .f., .f.)
loCmd.AddParameter("p_prventamax", ALLTRIM(STR(Thisform.txtPrVentaMax.Value, 20, 2)), .f., .f.) 
loCmd.AddParameter("p_prventamin", ALLTRIM(STR(Thisform.txtPrVentaMin.Value, 20, 2)), .f., .f.)
loCmd.AddParameter("p_prfinalmax", ALLTRIM(STR(Thisform.txtPrFinalMax.Value, 20, 2)), .f., .f.)
loCmd.AddParameter("p_prfinalmin", ALLTRIM(STR(Thisform.txtPrFinalMin.Value, 20, 2)), .f., .f.)
loCmd.AddParameter("p_observ", "", .t., .f.)
loCmd.AddParameter("p_habilitado", "1", .f., .f.)
loCmd.AddParameter("p_linkfoto", "", .t., .f.)
loCmd.AddParameter("p_usualta", ALLTRIM(gcCodUsu), .t., .f.)
loCmd.AddParameter("p_idhostalta", ALLTRIM(SYS(0)), .t., .f.)
loCmd.AddParameter("p_esserv", "0", .f., .f.)
loCmd.AddParameter("p_idunimed", ALLTRIM(STR(Thisform.sel_unimed.valcpoid)), .f., .f.)
loCmd.AddParameter("p_cod_art_prov", ALLTRIM(Thisform.txtCodProv.Value), .t., .f.)
loCmd.AddParameter("p_mostrador", "0", .f., .f.)

&& Ejecuto la transacción
goConn.BeginTransaction
loCmd.ActiveConnection = goConn.ActiveConnection

IF !loCmd.Execute() THEN
	&& Si va mal deshago los cambios que haya hecho y muestro mensaje
	goConn.Rollback()
	MESSAGEBOX(loCmd.ErrorMessage, 0+48, Thisform.Caption)
ELSE
	&& Si va bien confirmo los cambios
	goConn.Commit()
ENDIF





ENDPROC
PROCEDURE llenar_tipos_moneda
**
* Llena los tipos de monedas
**

this.cmbTipoMon.AddItem("PSO")
this.cmbTipoMon.AddItem("DOL")
this.cmbTipoMon.AddItem("EUR")
this.cmbTipoMon.ListIndex = 1
ENDPROC
PROCEDURE Init
&& Inicializo los controles con un valor por defecto
thisform.llenar_tipos_moneda()
thisform.establecer_valores_default()
thisform.txtCodArt.SetFocus()
ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Código:"
Height = 15
Left = 64
Top = 12
Width = 47
TabIndex = 23
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: txtCodArt
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 113
TabIndex = 1
Top = 8
Width = 176
Name = "txtCodArt"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Código alternativo:"
Height = 15
Left = 303
Top = 12
Width = 108
TabIndex = 24
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: txtCodProv
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 411
TabIndex = 2
Top = 8
Width = 190
Name = "txtCodProv"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Descripción:"
Height = 15
Left = 38
Top = 35
Width = 75
TabIndex = 25
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: txtDescripcion
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 113
TabIndex = 3
Top = 32
Width = 572
Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Familia:"
Height = 15
Left = 65
Top = 60
Width = 44
TabIndex = 27
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "SubFamilia:"
Height = 15
Left = 44
Top = 84
Width = 65
TabIndex = 29
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: sel_Familia
************************************************************
*** PROPIEDADES ***
Top = 54
Left = 112
Width = 573
Height = 25
TabIndex = 4
nombre_tabla = familias
nombre_campo_codigo = idfamilia
nombre_campo_desc = descripcio
cfieldname = idfamilia
esnumerico = .T.
pkfield = idfamilia
msgerror = Debe seleccionar una Familia
criterio_filtro = familias.fecBaja IS NULL
Name = "sel_Familia"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Height = 21
txtDescripcion.Left = 106
txtDescripcion.Top = 2
txtDescripcion.Width = 467
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta6
************************************************************
*** PROPIEDADES ***
Caption = "Marca:"
Height = 15
Left = 70
Top = 107
Width = 44
TabIndex = 35
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta7
************************************************************
*** PROPIEDADES ***
Caption = "Proveedor:"
Height = 15
Left = 45
Top = 131
Width = 69
TabIndex = 34
Name = "Clsetiqueta7"

*** METODOS ***


************************************************************
OBJETO: Sel_SubFamilia
************************************************************
*** PROPIEDADES ***
Top = 78
Left = 112
Width = 573
Height = 25
TabIndex = 5
nombre_tabla = subfam
nombre_campo_codigo = idsubfam
nombre_campo_desc = descripcio
cfieldname = idsubfam
esnumerico = .T.
pkfield = idsubfam
msgerror = Debe seleccionar una SubFamilia
criterio_filtro = subfam.fecBaja IS NULL
Name = "Sel_SubFamilia"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Height = 21
txtDescripcion.Left = 106
txtDescripcion.Top = 2
txtDescripcion.Width = 467
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: Sel_Marca
************************************************************
*** PROPIEDADES ***
Top = 102
Left = 112
Width = 573
Height = 25
TabIndex = 6
nombre_tabla = marcas
nombre_campo_codigo = idmarca
nombre_campo_desc = descripcio
cfieldname = idmarca
esnumerico = .T.
pkfield = idmarca
msgerror = Debe seleccionar una Marca
criterio_filtro = marcas.fecBaja IS NULL
Name = "Sel_Marca"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Height = 21
txtDescripcion.Left = 106
txtDescripcion.Top = 2
txtDescripcion.Width = 467
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: Sel_Proveedor
************************************************************
*** PROPIEDADES ***
Top = 126
Left = 112
Width = 573
Height = 25
TabIndex = 7
nombre_tabla = proveedor
nombre_campo_codigo = idprov
nombre_campo_desc = razsoc
cfieldname = idprov
esnumerico = .T.
pkfield = idprov
msgerror = Debe seleccionar un Proveedor
criterio_filtro = proveedor.fecBaja IS NULL
Name = "Sel_Proveedor"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Height = 21
txtDescripcion.Left = 106
txtDescripcion.Top = 2
txtDescripcion.Width = 467
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta8
************************************************************
*** PROPIEDADES ***
Caption = "Alícuota I.V.A.:"
Left = 29
Top = 180
TabIndex = 38
Name = "Clsetiqueta8"

*** METODOS ***


************************************************************
OBJETO: txtAlicIVA
************************************************************
*** PROPIEDADES ***
Left = 114
TabIndex = 9
Top = 176
isnumeric = .T.
cfieldname = aliciva
msgerror = Debe ingresar la Alícuota de I.V.A.
Name = "txtAlicIVA"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta9
************************************************************
*** PROPIEDADES ***
Caption = "Unidad de Medida:"
Height = 15
Left = 6
Top = 155
Width = 106
TabIndex = 32
Name = "Clsetiqueta9"

*** METODOS ***


************************************************************
OBJETO: sel_unimed
************************************************************
*** PROPIEDADES ***
Top = 150
Left = 112
Width = 573
Height = 25
TabIndex = 8
nombre_tabla = unidmed
nombre_campo_codigo = codUM
nombre_campo_desc = descripcio
cfieldname = idUniMed
esnumerico = .F.
pkfield = idUniMed
msgerror = Debe ingresar la unidad de medida del artículo
Name = "sel_unimed"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Height = 21
txtDescripcion.Left = 106
txtDescripcion.Top = 2
txtDescripcion.Width = 467
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta10
************************************************************
*** PROPIEDADES ***
Caption = "Prec. Lista Proveedor ($):"
Height = 15
Left = 26
Top = 224
Width = 148
TabIndex = 26
Name = "Clsetiqueta10"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta11
************************************************************
*** PROPIEDADES ***
Caption = "Bonificación 1:"
Left = 26
Top = 293
TabIndex = 30
Name = "Clsetiqueta11"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta12
************************************************************
*** PROPIEDADES ***
Caption = "Bonificación 2:"
Left = 26
Top = 317
TabIndex = 31
Name = "Clsetiqueta12"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta13
************************************************************
*** PROPIEDADES ***
Caption = "Bonificación 3:"
Left = 26
Top = 341
TabIndex = 33
Name = "Clsetiqueta13"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta14
************************************************************
*** PROPIEDADES ***
Caption = "Bonificación 4:"
Left = 26
Top = 365
TabIndex = 36
Name = "Clsetiqueta14"

*** METODOS ***


************************************************************
OBJETO: txtBonif1
************************************************************
*** PROPIEDADES ***
Left = 119
TabIndex = 11
Top = 289
isnumeric = .T.
cfieldname = bonif1
requerido = .F.
Name = "txtBonif1"

*** METODOS ***
PROCEDURE Valid



ENDPROC
PROCEDURE LostFocus
DODEFAULT()
thisform.calcular_precios()
ENDPROC


************************************************************
OBJETO: txtBonif2
************************************************************
*** PROPIEDADES ***
Left = 119
TabIndex = 12
Top = 313
isnumeric = .T.
requerido = .F.
cfieldname = bonif2
Name = "txtBonif2"

*** METODOS ***
PROCEDURE LostFocus
DODEFAULT()
thisform.calcular_precios()
ENDPROC


************************************************************
OBJETO: txtBonif3
************************************************************
*** PROPIEDADES ***
Left = 119
TabIndex = 13
Top = 337
isnumeric = .T.
requerido = .F.
cfieldname = bonif3
Name = "txtBonif3"

*** METODOS ***
PROCEDURE LostFocus
DODEFAULT()
thisform.calcular_precios()
ENDPROC


************************************************************
OBJETO: txtBonif4
************************************************************
*** PROPIEDADES ***
Left = 119
TabIndex = 14
Top = 361
isnumeric = .T.
requerido = .F.
cfieldname = bonif4
Name = "txtBonif4"

*** METODOS ***
PROCEDURE LostFocus
DODEFAULT()
thisform.calcular_precios()
ENDPROC


************************************************************
OBJETO: Clsetiqueta15
************************************************************
*** PROPIEDADES ***
Caption = "Costo de Reposición:"
Height = 15
Left = 26
Top = 396
Width = 123
TabIndex = 37
Name = "Clsetiqueta15"

*** METODOS ***


************************************************************
OBJETO: txtCostoRep
************************************************************
*** PROPIEDADES ***
Tag = ""
Enabled = .F.
Left = 158
TabIndex = 39
Top = 392
isnumeric = .T.
cfieldname = costoRep
requerido = .F.
Name = "txtCostoRep"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta16
************************************************************
*** PROPIEDADES ***
Caption = "Margen Mayorista:"
Height = 15
Left = 255
Top = 295
Width = 105
TabIndex = 41
Name = "Clsetiqueta16"

*** METODOS ***


************************************************************
OBJETO: txtMargenMax
************************************************************
*** PROPIEDADES ***
Left = 371
TabIndex = 15
Top = 291
isnumeric = .T.
requerido = .F.
cfieldname = margenmax
Name = "txtMargenMax"

*** METODOS ***
PROCEDURE LostFocus
DODEFAULT()
Thisform.calcular_precios()
ENDPROC


************************************************************
OBJETO: txtMargenMin
************************************************************
*** PROPIEDADES ***
Left = 371
TabIndex = 16
Top = 315
isnumeric = .T.
requerido = .F.
cfieldname = margenmin
Name = "txtMargenMin"

*** METODOS ***
PROCEDURE LostFocus
DODEFAULT()
Thisform.calcular_precios()
ENDPROC


************************************************************
OBJETO: txtPrVentaMax
************************************************************
*** PROPIEDADES ***
Tag = ""
Enabled = .F.
Left = 474
TabIndex = 17
Top = 291
isnumeric = .T.
cfieldname = prventamax
requerido = .F.
Name = "txtPrVentaMax"

*** METODOS ***


************************************************************
OBJETO: txtPrVentaMin
************************************************************
*** PROPIEDADES ***
Tag = ""
Enabled = .F.
Left = 474
TabIndex = 18
Top = 315
isnumeric = .T.
cfieldname = prventamin
requerido = .F.
Name = "txtPrVentaMin"

*** METODOS ***


************************************************************
OBJETO: txtPrFinalMax
************************************************************
*** PROPIEDADES ***
Tag = ""
Enabled = .F.
Left = 577
TabIndex = 19
Top = 291
isnumeric = .T.
cfieldname = prfinalmax
requerido = .F.
Name = "txtPrFinalMax"

*** METODOS ***


************************************************************
OBJETO: txtPrFinalMin
************************************************************
*** PROPIEDADES ***
Tag = ""
Enabled = .F.
Left = 577
TabIndex = 20
Top = 315
isnumeric = .T.
cfieldname = prfinalmin
requerido = .F.
Name = "txtPrFinalMin"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta17
************************************************************
*** PROPIEDADES ***
Caption = "Utilidad"
Height = 15
Left = 343
Top = 267
Width = 46
TabIndex = 42
Name = "Clsetiqueta17"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta18
************************************************************
*** PROPIEDADES ***
Caption = "Con I.V.A"
Height = 15
Left = 597
Top = 267
Width = 56
TabIndex = 44
Name = "Clsetiqueta18"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta19
************************************************************
*** PROPIEDADES ***
Caption = "% Dto. Prov."
Height = 15
Left = 77
Top = 267
Width = 80
TabIndex = 28
Name = "Clsetiqueta19"

*** METODOS ***


************************************************************
OBJETO: Clslinea1
************************************************************
*** PROPIEDADES ***
Height = 0
Left = 21
Top = 283
Width = 849
Name = "Clslinea1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta20
************************************************************
*** PROPIEDADES ***
Caption = "Margen Minorista:"
Height = 15
Left = 255
Top = 318
Width = 110
TabIndex = 40
Name = "Clsetiqueta20"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta21
************************************************************
*** PROPIEDADES ***
Caption = "Sin I.V.A"
Height = 15
Left = 500
Top = 267
Width = 59
TabIndex = 43
Name = "Clsetiqueta21"

*** METODOS ***


************************************************************
OBJETO: txtprLista
************************************************************
*** PROPIEDADES ***
Left = 178
TabIndex = 10
Top = 220
isnumeric = .T.
cfieldname = prlista
requerido = .T.
Name = "txtprLista"

*** METODOS ***
PROCEDURE Valid


ENDPROC
PROCEDURE LostFocus
DODEFAULT()
thisform.calcular_precios()
ENDPROC


************************************************************
OBJETO: Clsetiqueta22
************************************************************
*** PROPIEDADES ***
Caption = "Tipo Moneda:"
Left = 369
Top = 223
TabIndex = 45
Name = "Clsetiqueta22"

*** METODOS ***


************************************************************
OBJETO: cmbTipoMon
************************************************************
*** PROPIEDADES ***
Height = 22
Left = 454
TabIndex = 46
ToolTipText = "PSO: Pesos | DOL: Dolares | EUR: Euros"
Top = 219
Width = 100
cfieldname = tmon
requerido = .F.
Name = "cmbTipoMon"

*** METODOS ***
PROCEDURE InteractiveChange
IF ALLTRIM(This.Value) <> "PSO" THEN 
	Thisform.PGF.Page2.Cnt_Fields.InternalPgf.Page1.txtprLista.Enabled = .F.
ELSE
	Thisform.PGF.Page2.Cnt_Fields.InternalPgf.Page1.txtprLista.Enabled = .T.
ENDIF 
ENDPROC


************************************************************
OBJETO: Clsetiqueta23
************************************************************
*** PROPIEDADES ***
Caption = "Cotización:"
Height = 15
Left = 563
Top = 223
Width = 70
TabIndex = 47
Name = "Clsetiqueta23"

*** METODOS ***


************************************************************
OBJETO: txtCotizacion
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 637
TabIndex = 48
Top = 219
Width = 59
isnumeric = .T.
requerido = .F.
cfieldname = cotizac
Name = "txtCotizacion"

*** METODOS ***
PROCEDURE LostFocus
DODEFAULT()

This.Parent.txtPrLista.Value = ROUND(This.Parent.txtPrExt.Value * This.Parent.txtCotizacion.Value, 2)
Thisform.calcular_precios()
ENDPROC


************************************************************
OBJETO: Clsetiqueta24
************************************************************
*** PROPIEDADES ***
Caption = "Precio Mon. Ext.:"
Height = 15
Left = 701
Top = 223
Width = 111
TabIndex = 49
Name = "Clsetiqueta24"

*** METODOS ***


************************************************************
OBJETO: txtPrExt
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 805
TabIndex = 50
Top = 219
Width = 59
isnumeric = .T.
requerido = .F.
cfieldname = prListaExt
Name = "txtPrExt"

*** METODOS ***
PROCEDURE LostFocus
DODEFAULT()
This.Parent.txtPrLista.Value = ROUND(This.Parent.txtPrExt.Value * This.Parent.txtCotizacion.Value, 2)
Thisform.calcular_precios()
ENDPROC


************************************************************
OBJETO: Clslinea2
************************************************************
*** PROPIEDADES ***
Height = 0
Left = 372
Top = 210
Width = 499
Name = "Clslinea2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta25
************************************************************
*** PROPIEDADES ***
BackStyle = 1
Caption = " Moneda Extranjera"
Height = 15
Left = 365
Top = 202
Width = 149
TabIndex = 51
ForeColor = 255,255,255
BackColor = 0,128,192
Name = "Clsetiqueta25"

*** METODOS ***


************************************************************
OBJETO: btnGrabar
************************************************************
*** PROPIEDADES ***
Top = 420
Left = 768
TabIndex = 21
Name = "btnGrabar"

*** METODOS ***
PROCEDURE Click
&& Valido que los datos estén cargados y si está correcto
&& invoco al método de grabación.
IF thisform.validar_datos()
	thisform.grabar()
	thisform.registro_nuevo_ok = .T.
	thisform.Hide()
ENDIF

ENDPROC


************************************************************
OBJETO: btnCancelar
************************************************************
*** PROPIEDADES ***
Top = 420
Left = 816
TabIndex = 22
Name = "btnCancelar"

*** METODOS ***
PROCEDURE Click
thisform.registro_nuevo_ok = .F.
thisform.Hide()
ENDPROC


************************************************************
OBJETO: cls_alta_articulo
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_agregafalt
************************************************************
*** PROPIEDADES ***
DataSession = 1
BorderStyle = 2
Height = 176
Width = 533
DoCreate = .T.
ShowTips = .F.
Caption = "Agregar faltante"
Closable = .F.
idarticulo = 
codart = 
cantidad = 0.00
aceptar = .F.
unicpr = 0.00
idcliente = 0
Name = "cls_agregafalt"

*** METODOS ***
PROCEDURE Load
DODEFAULT()
** Agrego cursor para levantar las unidades de despacho.

CREATE CURSOR cur_unidesp ( ;
	idCodArt int, ;
	idArticulo int, ;
	codArt varchar(20), ;
	codigos varchar(20), ;
	cantiDesp N(20, 2))
	
ENDPROC
PROCEDURE Init
DODEFAULT()

LOCAL loRes, lcSql

loRes = CREATEOBJECT("odbc_result")
lcSql = ""

THISFORM.txtCodArt.Value = cur_Artic.codArt

lcSql = "SELECT idCodArt, idArticulo, codArt, codigos, cantiDesp FROM codiart WHERE idArticulo = " + ALLTRIM(STR(cur_artic.idArticulo)) + " "
lcSql = lcSql + "AND (circuito = 'C' OR circuito = 'CV')"
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"
IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, THISFORM.Caption)
	RETURN .F.
ENDIF

SELECT cur_unidesp
APPEND FROM DBF("cur_x")
loRes.Close_Query()

IF RECCOUNT("cur_unidesp") <> 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_unidesp")
	THISFORM.cboUnidCpa.AddItem(ALLTRIM(STR(cur_unidesp.cantiDesp, 20, 2)))

	SELECT cur_unidesp
	SKIP
ENDDO

** Me posiciono en el primer registro del combobox ya que es el que queda seleccionado
** y recupero el código de la unidad de despacho seleccionada.
SELECT cur_unidesp
GO TOP
Thisform.txtCodigoUD.Value = cur_unidesp.codigos
THISFORM.cboUnidCpa.ListIndex = 1
Thisform.txtCantidad.SetFocus()


RETURN .T.

ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Artículo seleccionado:"
Height = 15
Left = 12
Top = 34
Width = 137
TabIndex = 7
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Cantidad:"
Height = 15
Left = 12
Top = 82
Width = 84
TabIndex = 9
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: txtCodArt
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 152
TabIndex = 2
TabStop = .T.
Top = 31
Width = 374
Name = "txtCodArt"

*** METODOS ***


************************************************************
OBJETO: txtCantidad
************************************************************
*** PROPIEDADES ***
Left = 152
TabIndex = 4
Top = 78
isnumeric = .T.
Name = "txtCantidad"

*** METODOS ***
PROCEDURE Valid
LOCAL lnUnidVta

lnUnidVta = 0.00
lnUnidVta = VAL(thisform.cboUnidCpa.Value)

IF lnUnidVta <> 0 THEN
	IF (THIS.Value % lnUnidVta) <> 0 THEN
		MESSAGEBOX("La cantidad debe ser múltiplo de " + ALLTRIM(STR(lnUnidVta, 10, 2)), 0+48, Thisform.Caption)
		RETURN .F.		
	ENDIF
ENDIF

RETURN .T.
ENDPROC


************************************************************
OBJETO: btnAceptar
************************************************************
*** PROPIEDADES ***
Top = 129
Left = 438
Height = 44
Width = 45
TabIndex = 5
Name = "btnAceptar"

*** METODOS ***
PROCEDURE Click
IF thisform.txtCantidad.Value = 0 THEN
	MESSAGEBOX("Debe ingresar la cantidad", 0+48, Thisform.Caption)
	thisform.txtCantidad.SetFocus()
	RETURN
ENDIF

THISFORM.idCliente = THISFORM.sel_cliente.valcpoid
THISFORM.cantidad = THISFORM.txtCantidad.Value
THISFORM.unicpr = VAL(THISFORM.cboUnidCpa.Value)
THISFORM.aceptar = .T.
THISFORM.Hide()
ENDPROC


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Unidad de Compra:"
Height = 15
Left = 12
Top = 57
Width = 132
TabIndex = 10
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: cboUnidCpa
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 152
TabIndex = 3
Top = 54
Width = 100
Name = "cboUnidCpa"

*** METODOS ***
PROCEDURE InteractiveChange
** Recupero el código de la unidad de despacho al seleccionar una
** cantidad.

SELECT cur_unidesp
Thisform.txtCodigoUD.Value = cur_unidesp.codigos
ENDPROC


************************************************************
OBJETO: CLSCERRAR
************************************************************
*** PROPIEDADES ***
Top = 129
Left = 484
TabIndex = 6
Name = "CLSCERRAR"

*** METODOS ***
PROCEDURE Click
THISFORM.aceptar = .F.
thisform.Hide()

ENDPROC


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Cliente:"
Height = 15
Left = 12
Top = 11
Width = 137
TabIndex = 8
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: sel_cliente
************************************************************
*** PROPIEDADES ***
Top = 3
Left = 66
TabIndex = 1
nombre_tabla = clientes
nombre_campo_codigo = idCliente
nombre_campo_desc = razSoc
pkfield = idCliente
requerido = .F.
title_cols = Razón Social
autocompletar_ceros = .F.
esnumerico = .T.
Name = "sel_cliente"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Height = 21
txtDescripcion.Left = 106
txtDescripcion.Top = 2
txtDescripcion.Width = 354
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: CLSETIQUETA5
************************************************************
*** PROPIEDADES ***
Caption = "Código Unid. Desp.:"
Height = 15
Left = 264
Top = 58
Width = 108
Name = "CLSETIQUETA5"

*** METODOS ***


************************************************************
OBJETO: txtCodigoUD
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 377
ReadOnly = .T.
Top = 54
Width = 149
Name = "txtCodigoUD"

*** METODOS ***


************************************************************
OBJETO: cls_agregafalt
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_form_generar_rutas
************************************************************
*** PROPIEDADES ***
BorderStyle = 2
Height = 196
Width = 708
DoCreate = .T.
Caption = "Generar rutas de fotos"
Name = "cls_form_generar_rutas"

*** METODOS ***
PROCEDURE generar_rutas
LOCAL loRes
LOCAL lcSql

loRes = CREATEOBJECT("odbc_result")
lcSql = ""

IF !thisform.validar_form() THEN
	RETURN
ENDIF

IF thisform.options.option1.Value = 1 THEN
	** Proceso todos los artículos de la marca seleccionada
	TEXT TO lcSql NOSHOW
		CALL util_generar_rutasFotos(?pIdMarca, ?pMarca, ?pidProv)
	ENDTEXT
ELSE
	** Proces o solo los artículos que no tienen fotos.
	TEXT TO lcSql NOSHOW
		CALL util_generar_rutasFotos_sin_fotos(?pIdMarca, ?pMarca, ?pidProv)
	ENDTEXT
ENDIF

lcSql = loRes.AddParameter(lcSql, "pIdMarca", ALLTRIM(STR(thisform.sel_marca.valcpoid)), .F. ,.F.)
lcSql = loRes.AddParameter(lcSql, "pMarca", ALLTRIM(thisform.txtCarpeta.Value), .T., .F.)
lcSql = loRes.AddParameter(lcSql, "pidProv", ALLTRIM(STR(thisform.sel_Proveedor.valcpoid)), .F., .F.)
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_rutas"
loRes.OpenQuery(lcSql)

IF RECCOUNT("cur_rutas") = 0 THEN
	MESSAGEBOX("No se encontraron artículos", 0+64, Thisform.Caption)
ELSE
	genexcel("cur_rutas","rutas_fotos")
ENDIF

loRes.Close_Query()
thisform.blanquear()
ENDPROC
PROCEDURE blanquear
thisform.sel_marca.blanquear()
thisform.sel_proveedor.blanquear()
thisform.txtCarpeta.Value = ""
thisform.options.option1.Value = 1
thisform.options.option2.value = 0
thisform.sel_marca.txtCodigo.SetFocus()

ENDPROC
PROCEDURE validar_form
** Valido que los datos que pido en el form estén cargados.

IF thisform.sel_marca.valcpoid = 0 THEN
	MESSAGEBOX("Debe ingresar una marca", 0+48, Thisform.Caption)
	thisform.sel_marca.SetFocus()
	RETURN .F.
ENDIF


IF EMPTY(thisform.txtCarpeta.Value) THEN
	MESSAGEBOX("Debe ingresar el nombre de la carpeta donde está las imágenes", 0+48, Thisform.Caption)
	thisform.txtCarpeta.SetFocus()
	RETURN .F.
ENDIF

RETURN .T.
ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Marca:"
Height = 15
Left = 82
Top = 24
Width = 41
TabIndex = 7
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Nombre de carpeta:"
Height = 15
Left = 10
Top = 70
Width = 113
TabIndex = 8
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: sel_marca
************************************************************
*** PROPIEDADES ***
Top = 18
Left = 125
TabIndex = 1
esnumerico = .T.
nombre_campo_codigo = idmarca
nombre_campo_desc = descripcio
nombre_tabla = marcas
pkfield = idmarca
Name = "sel_marca"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: txtCarpeta
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 127
TabIndex = 3
Top = 68
Width = 570
Name = "txtCarpeta"

*** METODOS ***


************************************************************
OBJETO: btnAceptar
************************************************************
*** PROPIEDADES ***
Top = 138
Left = 330
TabIndex = 5
Name = "btnAceptar"

*** METODOS ***
PROCEDURE Click
Thisform.generar_rutas()
ENDPROC


************************************************************
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 138
Left = 378
TabIndex = 6
Name = "btnCerrar"

*** METODOS ***


************************************************************
OBJETO: options
************************************************************
*** PROPIEDADES ***
Height = 48
Left = 127
Top = 93
Width = 168
TabIndex = 4
BackColor = 255,255,255
Name = "options"
OPTION1.Caption = "Todos"
OPTION1.Left = 5
OPTION1.Top = 5
OPTION1.ForeColor = 158,106,75
OPTION1.BackColor = 255,255,255
OPTION1.Name = "OPTION1"
OPTION2.Caption = "Artículos sin fotos"
OPTION2.Height = 15
OPTION2.Left = 5
OPTION2.Top = 22
OPTION2.Width = 144
OPTION2.ForeColor = 158,106,75
OPTION2.BackColor = 255,255,255
OPTION2.Name = "OPTION2"

*** METODOS ***


************************************************************
OBJETO: Sel_Proveedor
************************************************************
*** PROPIEDADES ***
Top = 42
Left = 125
Width = 573
Height = 25
TabIndex = 2
nombre_tabla = proveedor
nombre_campo_codigo = idprov
nombre_campo_desc = razsoc
cfieldname = idprov
esnumerico = .T.
pkfield = idprov
msgerror = Debe seleccionar un Proveedor
criterio_filtro = proveedor.fecBaja IS NULL
Name = "Sel_Proveedor"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Height = 21
txtDescripcion.Left = 106
txtDescripcion.Top = 2
txtDescripcion.Width = 467
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Proveedor:"
Height = 15
Left = 56
Top = 46
Width = 66
TabIndex = 9
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: cls_form_generar_rutas
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 9, 6, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_form_updprecio_codiart
************************************************************
*** PROPIEDADES ***
BorderStyle = 1
Height = 402
Width = 946
DoCreate = .T.
Caption = "Actualización de precios por código de barras"
Name = "cls_form_updprecio_codiart"
contenido.Name = "contenido"

*** METODOS ***
PROCEDURE actualizar
**************************************************************
* Método principal de actualización
**************************************************************

IF this.validarcampos() THEN
	this.grabar()
	this.contenido.sel_articulos.txtCodigo.SetFocus()
ENDIF
ENDPROC
PROCEDURE Load
***********************************************************
* Armo el cursor para reflejar los precios actualizados.
***********************************************************
DODEFAULT()

CREATE CURSOR cur_precios ( ;
	idarticulo int,;
	codart varchar(20),;
	descripcio varchar(200),;
	prfinalMin N(20, 2))
ENDPROC
PROCEDURE Init
*******************************************************
* Configuraciones de controles de formulario.
*******************************************************
SELECT cur_precios
this.contenido.grdArticulosActualizados.alias_name = "cur_precios"
this.contenido.grdArticulosActualizados.RecordSource = "cur_precios"
this.contenido.grdArticulosActualizados.list_controlsource = "codart, descripcio, prfinalMin"
this.contenido.grdArticulosActualizados.lista_ancho_cols = "100,200,70"
this.contenido.grdArticulosActualizados.titulos_cabeceras = "Código, Descripción, Precio"
this.contenido.grdArticulosActualizados.generar_grid()


ENDPROC
PROCEDURE validarcampos
************************************************************
* Verifico que los datos se ingresen correctamente
************************************************************

IF this.contenido.sel_articulos.valcpoid = 0 THEN
	MESSAGEBOX("Debe ingresar el artículo", 0+48, This.Caption)
	this.contenido.sel_articulos.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

IF this.contenido.txtPrecioFinal.Value = 0 THEN
	MESSAGEBOX("Debe ingresar el precio de venta final", 0+48, This.Caption)
	this.contenido.txtPrecioFinal.SetFocus()
	RETURN .F.
ENDIF

RETURN .T.
ENDPROC
PROCEDURE grabar
****************************************************
* Grabo la actualización
****************************************************


LOCAL loRes
LOCAL loResCambios
LOCAL lcSql

loRes = CREATEOBJECT("odbc_result")
lcSql = "CALL articulos_updateByPrecioFinal (?pIdArticulo, ?pPreVtaFinal, ?pUsuario, ?pHostName)"
lcSql = loRes.AddParameter(lcSql, "pIdArticulo", ALLTRIM(STR(This.contenido.sel_articulos.valcpoid)), .F., .F.)
lcSql = loRes.AddParameter(lcSql, "pPreVtaFinal", ALLTRIM(STR(This.contenido.txtPrecioFinal.Value, 20, 2)), .F., .F.)
lcSql = loRes.AddParameter(lcSql, "pUsuario", ALLTRIM(gcCodUsu), .T., .F.)
lcSql = loRes.AddParameter(lcSql, "pHostName", ALLTRIM(SYS(0)), .T., .F.)
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_result"
loRes.OpenQuery(lcSql)
SELECT cur_result
IF !(cur_result.result == "OK") THEN
	* Si falla muestro mensaje.
	MESSAGEBOX(cur_result.result, 0+48, Thisform.Caption)
ELSE
	* Si va todo OK reflejo el cambio en la grilla.
	TEXT TO lcSql NOSHOW
		SELECT
			articulos.idArticulo AS 'idarticulo',
			articulos.codArt AS 'codart',
			articulos.descripcio AS 'descripcio',
			articulos.prfinalMin AS 'prfinalMin'
		FROM
			articulos
		WHERE
			CAST(articulos.fecmodi AS date) = CAST(current_timestamp AS date) AND
			articulos.fecBaja IS NULL
	ENDTEXT
	
	loResCambios = CREATEOBJECT("odbc_result")
	loResCambios.ActiveConnection = goConn.ActiveConnection
	loResCambios.Cursor_Name = "cur_cambios"
	loResCambios.OpenQuery(lcSql)
	SELECT cur_precios
	ZAP
	APPEND FROM DBF("cur_cambios")
	this.contenido.grdArticulosActualizados.Refresh()
	loResCambios.close_query()
ENDIF

loRes.Close_Query()




ENDPROC


************************************************************
OBJETO: sel_articulos
************************************************************
*** PROPIEDADES ***
Top = 13
Left = 119
Width = 612
Height = 32
TabIndex = 1
cfieldname = 
nombre_campo_codigo = codArt
nombre_campo_desc = descripcio
nombre_tabla = articulos
pkfield = idArticulo
Name = "sel_articulos"
txtCodigo.FontSize = 10
txtCodigo.Height = 25
txtCodigo.Left = 2
txtCodigo.Top = 4
txtCodigo.Width = 163
txtCodigo.Name = "txtCodigo"
txtDescripcion.FontSize = 10
txtDescripcion.Height = 25
txtDescripcion.Left = 166
txtDescripcion.Top = 4
txtDescripcion.Width = 435
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***
PROCEDURE recuperar_datos
*************************************************************
* Recupero el precio actual del artículo. 
*************************************************************
LOCAL loRes
LOCAL lcSql

loRes = CREATEOBJECT("odbc_result")

TEXT TO lcSql NOSHOW
	SELECT
		prfinalMin
	FROM
		articulos
	WHERE
		articulos.idArticulo = ?pIdArticulo
ENDTEXT
lcSql = loRes.AddParameter(lcSql, "pIdArticulo", ALLTRIM(STR(this.valcpoid)), .F., .F.)

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"
loRes.OpenQuery(lcSql)
SELECT cur_x
thisform.contenido.txtPrecioActual.Value = cur_x.prfinalMin
loRes.Close_Query()
ENDPROC
PROCEDURE txtCodigo.LostFocus
LOCAL lcCodArt
LOCAL loResult, lcSql

lcCodArt = ""
lcSql = ""
loResult = CREATEOBJECT("odbc_result")

IF !(ALLTRIM(this.Value) == "") THEN
	TEXT TO lcSql NOSHOW
		SELECT
			codArt,
			cantiDesp
		FROM
			codiart
		WHERE
			codigos = ?pCodArt AND
			(codiart.circuito = 'V' OR 'CV')
	ENDTEXT
	lcSql = loResult.AddParameter(lcSql, "pCodArt", ALLTRIM(this.Value), .T., .F.)
	loResult.ActiveConnection = goConn.ActiveConnection
	loResult.Cursor_Name = "cur_x"
	
	IF !loResult.OpenQuery(lcSql) THEN
		MESSAGEBOX(loResult.Error_Message, 0+48, Thisform.Caption)
		RETURN .F.
	ENDIF

	SELECT cur_x
	IF RECCOUNT("cur_x") > 0 THEN
		GO TOP
		
		IF RECCOUNT("cur_x") = 1 THEN
			&& Paso por aca en caso que solo encuentre un registro puntual
			lcCodArt = cur_x.codArt
			loResult.close_query()
			this.Value = lcCodArt
			DODEFAULT()
			
			RETURN .F.
		ELSE 
			&& En caso de que devuelva más de un registro, recupero el codigo de artículo
			&& para que haga la búsqueda normal
			lcCodArt = cur_x.codArt
			loResult.close_query()
			
			this.Value = lcCodArt
			DODEFAULT()	
		ENDIF
	ELSE
		&& Si no encuentra nada en codiart entonces sigue la busqueda
		&& estandar
		
		DODEFAULT()
	ENDIF
	
	IF USED("cur_x") THEN
		loResult.close_query()
	ENDIF

	IF ALLTRIM(lcCodArt) == "ERROR" THEN
		RETURN .F.
	ENDIF
ENDIF

RETURN .T.
ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
FontSize = 10
Caption = "Artículo:"
Height = 15
Left = 57
Top = 21
Width = 60
TabIndex = 4
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
FontSize = 10
Caption = "Precio actual:"
Height = 15
Left = 22
Top = 49
Width = 88
TabIndex = 5
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: txtPrecioFinal
************************************************************
*** PROPIEDADES ***
FontSize = 10
Height = 25
Left = 413
TabIndex = 2
Top = 45
Width = 129
isnumeric = .T.
Name = "txtPrecioFinal"

*** METODOS ***
PROCEDURE LostFocus
thisform.actualizar()
ENDPROC


************************************************************
OBJETO: grdArticulosActualizados
************************************************************
*** PROPIEDADES ***
FontSize = 10
Height = 261
Left = 22
RowHeight = 19
TabIndex = 3
Top = 76
Width = 910
Name = "grdArticulosActualizados"
COLUMN1.Header1.FontSize = 10
COLUMN1.Header1.Name = "Header1"
COLUMN1.Text1.FontSize = 10
COLUMN1.Text1.Name = "Text1"
COLUMN1.FontSize = 10
COLUMN1.Name = "COLUMN1"
COLUMN2.Header1.FontSize = 10
COLUMN2.Header1.Name = "Header1"
COLUMN2.Text1.FontSize = 10
COLUMN2.Text1.Name = "Text1"
COLUMN2.FontSize = 10
COLUMN2.Name = "COLUMN2"
COLUMN3.Header1.FontSize = 10
COLUMN3.Header1.Name = "Header1"
COLUMN3.Text1.FontSize = 10
COLUMN3.Text1.Name = "Text1"
COLUMN3.FontSize = 10
COLUMN3.Name = "COLUMN3"
COLUMN4.Header1.FontSize = 10
COLUMN4.Header1.Name = "Header1"
COLUMN4.Text1.FontSize = 10
COLUMN4.Text1.Name = "Text1"
COLUMN4.FontSize = 10
COLUMN4.Name = "COLUMN4"
COLUMN5.Header1.FontSize = 10
COLUMN5.Header1.Name = "Header1"
COLUMN5.Text1.FontSize = 10
COLUMN5.Text1.Name = "Text1"
COLUMN5.FontSize = 10
COLUMN5.Name = "COLUMN5"
COLUMN6.Header1.FontSize = 10
COLUMN6.Header1.Name = "Header1"
COLUMN6.Text1.FontSize = 10
COLUMN6.Text1.Name = "Text1"
COLUMN6.FontSize = 10
COLUMN6.Name = "COLUMN6"
COLUMN7.Header1.FontSize = 10
COLUMN7.Header1.Name = "Header1"
COLUMN7.Text1.FontSize = 10
COLUMN7.Text1.Name = "Text1"
COLUMN7.FontSize = 10
COLUMN7.Name = "COLUMN7"
COLUMN8.Header1.FontSize = 10
COLUMN8.Header1.Name = "Header1"
COLUMN8.Text1.FontSize = 10
COLUMN8.Text1.Name = "Text1"
COLUMN8.FontSize = 10
COLUMN8.Name = "COLUMN8"
COLUMN9.Header1.FontSize = 10
COLUMN9.Header1.Name = "Header1"
COLUMN9.Text1.FontSize = 10
COLUMN9.Text1.Name = "Text1"
COLUMN9.FontSize = 10
COLUMN9.Name = "COLUMN9"
COLUMN10.Header1.FontSize = 10
COLUMN10.Header1.Name = "Header1"
COLUMN10.Text1.FontSize = 10
COLUMN10.Text1.Name = "Text1"
COLUMN10.FontSize = 10
COLUMN10.Name = "COLUMN10"
COLUMN11.Header1.FontSize = 10
COLUMN11.Header1.Name = "Header1"
COLUMN11.Text1.FontSize = 10
COLUMN11.Text1.Name = "Text1"
COLUMN11.FontSize = 10
COLUMN11.Name = "COLUMN11"
COLUMN12.Header1.FontSize = 10
COLUMN12.Header1.Name = "Header1"
COLUMN12.Text1.FontSize = 10
COLUMN12.Text1.Name = "Text1"
COLUMN12.FontSize = 10
COLUMN12.Name = "COLUMN12"
COLUMN13.Header1.FontSize = 10
COLUMN13.Header1.Name = "Header1"
COLUMN13.Text1.FontSize = 10
COLUMN13.Text1.Name = "Text1"
COLUMN13.FontSize = 10
COLUMN13.Name = "COLUMN13"
COLUMN14.Header1.FontSize = 10
COLUMN14.Header1.Name = "Header1"
COLUMN14.Text1.FontSize = 10
COLUMN14.Text1.Name = "Text1"
COLUMN14.FontSize = 10
COLUMN14.Name = "COLUMN14"
COLUMN15.Header1.FontSize = 10
COLUMN15.Header1.Name = "Header1"
COLUMN15.Text1.FontSize = 10
COLUMN15.Text1.Name = "Text1"
COLUMN15.FontSize = 10
COLUMN15.Name = "COLUMN15"
COLUMN16.Header1.FontSize = 10
COLUMN16.Header1.Name = "Header1"
COLUMN16.Text1.FontSize = 10
COLUMN16.Text1.Name = "Text1"
COLUMN16.FontSize = 10
COLUMN16.Name = "COLUMN16"
COLUMN17.Header1.FontSize = 10
COLUMN17.Header1.Name = "Header1"
COLUMN17.Text1.FontSize = 10
COLUMN17.Text1.Name = "Text1"
COLUMN17.FontSize = 10
COLUMN17.Name = "COLUMN17"
COLUMN18.Header1.FontSize = 10
COLUMN18.Header1.Name = "Header1"
COLUMN18.Text1.FontSize = 10
COLUMN18.Text1.Name = "Text1"
COLUMN18.FontSize = 10
COLUMN18.Name = "COLUMN18"
COLUMN19.Header1.FontSize = 10
COLUMN19.Header1.Name = "Header1"
COLUMN19.Text1.FontSize = 10
COLUMN19.Text1.Name = "Text1"
COLUMN19.FontSize = 10
COLUMN19.Name = "COLUMN19"
COLUMN20.Header1.FontSize = 10
COLUMN20.Header1.Name = "Header1"
COLUMN20.Text1.FontSize = 10
COLUMN20.Text1.Name = "Text1"
COLUMN20.FontSize = 10
COLUMN20.Name = "COLUMN20"

*** METODOS ***


************************************************************
OBJETO: Clscerrar1
************************************************************
*** PROPIEDADES ***
Top = 349
Left = 889
TabIndex = 6
Name = "Clscerrar1"

*** METODOS ***


************************************************************
OBJETO: txtPrecioActual
************************************************************
*** PROPIEDADES ***
FontSize = 10
Height = 25
Left = 121
ReadOnly = .T.
TabIndex = 7
Top = 45
Width = 129
isnumeric = .T.
Name = "txtPrecioActual"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
FontSize = 10
Caption = "Precio final minorista:"
Height = 15
Left = 266
Top = 49
Width = 143
TabIndex = 8
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: cls_form_updprecio_codiart
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 10, 6, 16, 13, 34, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_imprimir_listas
************************************************************
*** PROPIEDADES ***
BorderStyle = 1
Height = 244
Width = 946
DoCreate = .T.
Caption = "Imprimir listas de precios"
toexcel = .F.
idramo = 0
ramo_mrcv = .F.
ramo_fam = .F.
ramo_sf = .F.
Name = "cls_imprimir_listas"
contenido.Name = "contenido"

*** METODOS ***
PROCEDURE generar_lista
LOCAL loRes
LOCAL lcSql
LOCAL loTherm
LOCAL lnIdProvDD, lnIdProvHH
LOCAL lnIdMarcaDD, lnMarcaHH
LOCAL lnIdFamiliaDD, lnIdFamiliaHH
LOCAL lnIdSubFamDD, lnIdSubFamHH
LOCAL lcLinkFoto

lnIdProvDD = thisform.contenido.sel_ProvDesde.valcpoid
lnIdProvHH = thisform.contenido.sel_ProvHasta.valcpoid
lnIdMarcaDD = thisform.contenido.sel_MarcaDD.valcpoid
lnIdMarcaHH = thisform.contenido.sel_MarcaHH.valcpoid
lnIdFamiliaDD = thisform.contenido.sel_FamDesde.valcpoid
lnIdFamiliaHH = thisform.contenido.sel_FamHasta.valcpoid
lnIdSubFamDD = thisform.contenido.sel_SubFamDesde.valcpoid
lnIdSubFamHH = thisform.contenido.sel_SubFamHasta.valcpoid

loRes = CREATEOBJECT("odbc_result")
loTherm = CREATEOBJECT("_thermometer")
lcSql = ""
lcLinkFoto = ""

lcSql = "SELECT "
lcSql = lcSql + "articulos.codArt, articulos.descripcio, "
lcSql = lcSql + "subfam.descripcio AS descSF, marcas.descripcio AS descMC, "
lcSql = lcSql + "familias.descripcio AS descFam, "

IF Thisform.Contenido.opg_Precios.option1.Value = 1 THEN
	IF thisform.contenido.chkPrMay.Value = 1 THEN
		IF Thisform.contenido.chkConIVA.Value = 1 THEN
			lcSql = lcSql + "articulos.prFinalMax AS precio, "
		ELSE
			lcSql = lcSql + "articulos.prVentaMax AS precio, "
		ENDIF
	ELSE
		IF Thisform.contenido.chkConIVA.Value = 1 THEN
			lcSql = lcSql + "articulos.prFinalMin AS precio, "
		ELSE
			lcSql = lcSql + "articulos.prVentaMin AS precio, "
		ENDIF
	ENDIF
ELSE
	lcSql = lcSql + "articulos.prLista AS precio, "
ENDIF

lcSql = lcSql + "	articulos.linkfoto "

lcSql = lcSql + "FROM articulos INNER JOIN subfam ON subfam.idSubFam = articulos.idSubFam "
lcSql = lcSql + "	INNER JOIN marcas ON marcas.idmarca = articulos.idmarca "
lcSql = lcSql + "	INNER JOIN familias ON familias.idFamilia = articulos.idFamilia "
lcSql = lcSql + "	LEFT JOIN art_mrv ON art_mrv.idArticulo = articulos.idArticulo "
lcSql = lcSql + "WHERE articulos.fecBaja IS NULL AND articulos.habilitado = 1 "
lcSql = lcSql + " AND articulos.codArt NOT LIKE '%ARX' "

IF lnIdProvDD <> 0 .AND. lnIdProvHH <> 0 THEN
	lcSql = lcSql + " AND articulos.idProv BETWEEN " + ALLTRIM(STR(lnIdProvDD)) + " AND " + ALLTRIM(STR(lnIdProvHH)) + " "
ENDIF

IF lnIdMarcaDD <> 0 .AND. lnIdMarcaHH <> 0 THEN
	lcSql = lcSql + " AND articulos.idmarca BETWEEN " + ALLTRIM(STR(lnIdMarcaDD)) + " AND " + ALLTRIM(STR(lnIdMarcaHH)) + " "
ENDIF

IF lnIdFamiliaDD <> 0 .AND. lnIdFamiliaHH <> 0 THEN
	lcSql = lcSql + " AND articulos.idFamilia BETWEEN " + ALLTRIM(STR(lnIdFamiliaDD)) + " AND " + ALLTRIM(STR(lnIdFamiliaHH)) + " "
ENDIF

IF lnIdSubFamDD <> 0 .AND. lnIdSubFamHH <> 0 THEN
	lcSql = lcSql + " AND articulos.idSubFam BETWEEN " + ALLTRIM(STR(lnIdSubFamDD)) + " AND " + ALLTRIM(STR(lnIdSubFamHH)) + " "
ENDIF

IF Thisform.contenido.chkEmitirACliente.Value = 1 THEN
	IF Thisform.ramo_fam .OR. Thisform.ramo_mrcv .OR. Thisform.ramo_sf THEN
		lcSql = lcSql + "AND ( "
		lcSql = lcSql + "		art_mrv.idMarcaV IN (SELECT ramo_mrcv.idMarcaV FROM ramo_mrcv WHERE ramo_mrcv.idRamo = " + ALLTRIM(STR(Thisform.idramo)) + ") "
		lcSql = lcSql + "	OR 	articulos.idFamilia IN (SELECT ramofam.idFamilia FROM ramofam WHERE ramofam.idRamo = " + ALLTRIM(STR(Thisform.idramo)) + ")"
		lcSql = lcSql + "	OR 	articulos.idSubFam IN (SELECT ramo_sf.idSubFam FROM ramo_sf WHERE ramo_sf.idRamo = " + ALLTRIM(STR(Thisform.idramo)) + "))"
	ENDIF
ENDIF

&& lcSql = lcSql + "ORDER BY marcas.descripcio ASC, subfam.descripcio ASC, articulos.descripcio ASC"

&& Establezco el orden de la lista impresa
IF Thisform.Contenido.optOrden.option1.Value = 1 THEN
	lcSql = lcSql + "ORDER BY marcas.descripcio ASC, subfam.descripcio ASC, articulos.codArt"
ELSE
	IF Thisform.Contenido.optOrden.option2.Value = 1 THEN
		lcSql = lcSql + "ORDER BY marcas.descripcio ASC, subfam.descripcio ASC, articulos.descripcio "
	ENDIF
ENDIF

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_articulos
ZAP

SELECT cur_x
IF RECCOUNT("cur_x") = 0 THEN
	MESSAGEBOX("No hay registros para mostrar", 0+64, Thisform.Caption)
	loRes.Close_Query()
	RETURN .F.
ELSE
	SELECT cur_x
	GO TOP
ENDIF

loTherm.show()

* Limpio el cursor de artículos
SELECT cur_articulos
ZAP

* Limpio el cursor que se usa para exportar a Excel
SELECT cur_artexcel
ZAP

SELECT cur_x
DO WHILE !EOF("cur_x")
	lcLinkFoto = ""
	
	IF !ISNULL(cur_x.linkfoto) THEN
 		IF FILE(ALLTRIM(cur_x.linkfoto)) THEN
			lcLinkFoto = ALLTRIM(cur_x.linkfoto)
		ELSE
			lcLinkFoto = "c:\mg_fotos\sin-foto.png"
		ENDIF
	ELSE
		lcLinkFoto = "c:\mg_fotos\sin-foto.png"
	ENDIF
	
	IF !thisform.toexcel THEN
		SELECT cur_articulos
		APPEND BLANK
		REPLACE cur_articulos.codArt WITH cur_x.codArt
		REPLACE cur_articulos.descripcio WITH cur_x.descripcio ADDITIVE
		REPLACE cur_articulos.descFam WITH cur_x.descFam ADDITIVE
		REPLACE cur_articulos.descSF WITH cur_x.descSF ADDITIVE
		REPLACE cur_articulos.descMC WITH cur_x.descMC ADDITIVE
		REPLACE cur_articulos.precio WITH cur_x.precio ADDITIVE
		REPLACE cur_articulos.link WITH lcLinkFoto ADDITIVE		
	ELSE	
		SELECT cur_artexcel
		APPEND BLANK
		REPLACE cur_artexcel.codArt WITH cur_x.codArt
		REPLACE cur_artexcel.descripcio WITH cur_x.descripcio ADDITIVE
		REPLACE cur_artexcel.descFam WITH cur_x.descFam ADDITIVE
		REPLACE cur_artexcel.descSF WITH cur_x.descSF ADDITIVE
		REPLACE cur_artexcel.precio WITH STRTRAN(ALLTRIM(STR(cur_x.precio, 10, 2)), ".", ",") ADDITIVE
	ENDIF

	loTherm.update((RECNO("cur_x") * 100) / RECCOUNT("cur_x"), "Generando lista impresa")
	SELECT cur_x
	SKIP
ENDDO

loRes.Close_Query()

SELECT cur_articulos
GO TOP

RETURN .T.


ENDPROC
PROCEDURE Init
Thisform.contenido.sel_ramos.txtCodigo.Enabled = .F.
ENDPROC
PROCEDURE Load
DODEFAULT()

CREATE CURSOR cur_articulos (	;
	codArt		varchar(20),;
	descripcio	varchar(60),;
	descFam		varchar(60),;
	descSF		varchar(60),;
	descMC		varchar(60),;
	precio		float(10, 2),;
	link		varchar(254))
	
CREATE CURSOR cur_artexcel (	;
	codArt		varchar(20),;
	descripcio	varchar(60),;
	descFam		varchar(60),;
	descSF		varchar(60),;
	precio		varchar(20))
ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Proveedor"
Height = 15
Left = 9
Top = 53
Width = 72
TabIndex = 18
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Desde:"
Height = 15
Left = 74
Top = 53
Width = 46
TabIndex = 19
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Hasta:"
Height = 15
Left = 74
Top = 76
Width = 46
TabIndex = 20
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Familias"
Height = 15
Left = 472
Top = 53
Width = 65
TabIndex = 21
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Desde:"
Height = 15
Left = 551
Top = 53
Width = 45
TabIndex = 25
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta6
************************************************************
*** PROPIEDADES ***
Caption = "Hasta:"
Height = 15
Left = 551
Top = 76
Width = 45
TabIndex = 28
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta7
************************************************************
*** PROPIEDADES ***
Caption = "SubFamilias"
Height = 15
Left = 471
Top = 99
Width = 71
TabIndex = 29
Name = "Clsetiqueta7"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta8
************************************************************
*** PROPIEDADES ***
Caption = "Desde:"
Height = 15
Left = 551
Top = 99
Width = 45
TabIndex = 30
Name = "Clsetiqueta8"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta9
************************************************************
*** PROPIEDADES ***
Caption = "Hasta:"
Height = 15
Left = 552
Top = 122
Width = 45
TabIndex = 31
Name = "Clsetiqueta9"

*** METODOS ***


************************************************************
OBJETO: sel_FamDesde
************************************************************
*** PROPIEDADES ***
Top = 47
Left = 595
Width = 345
Height = 25
TabIndex = 6
esnumerico = .T.
cfieldname = idFamilia
nombre_campo_codigo = idFamilia
nombre_campo_desc = descripcio
nombre_tabla = familias
pkfield = idFamilia
Name = "sel_FamDesde"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Height = 21
txtDescripcion.Left = 106
txtDescripcion.Top = 2
txtDescripcion.Width = 236
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: sel_FamHasta
************************************************************
*** PROPIEDADES ***
Top = 70
Left = 595
Width = 345
Height = 25
TabIndex = 7
esnumerico = .T.
cfieldname = idFamilia
nombre_campo_codigo = idFamilia
nombre_campo_desc = descripcio
nombre_tabla = familias
pkfield = idFamilia
Name = "sel_FamHasta"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Height = 21
txtDescripcion.Left = 106
txtDescripcion.Top = 2
txtDescripcion.Width = 236
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: sel_SubFamDesde
************************************************************
*** PROPIEDADES ***
Top = 93
Left = 595
Width = 345
Height = 25
TabIndex = 8
esnumerico = .T.
cfieldname = idSubFam
nombre_campo_codigo = idSubFam
nombre_campo_desc = descripcio
nombre_tabla = subfam
pkfield = idSubFam
Name = "sel_SubFamDesde"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Height = 21
txtDescripcion.Left = 106
txtDescripcion.Top = 2
txtDescripcion.Width = 236
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: sel_SubFamHasta
************************************************************
*** PROPIEDADES ***
Top = 116
Left = 595
Width = 345
Height = 25
TabIndex = 9
esnumerico = .T.
cfieldname = idSubFam
nombre_campo_codigo = idSubFam
nombre_campo_desc = Descripcio
nombre_tabla = subfam
pkfield = idSubFam
Name = "sel_SubFamHasta"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Height = 21
txtDescripcion.Left = 106
txtDescripcion.Top = 2
txtDescripcion.Width = 236
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: sel_ProvDesde
************************************************************
*** PROPIEDADES ***
Top = 48
Left = 120
Width = 345
Height = 25
TabIndex = 2
esnumerico = .T.
nombre_tabla = proveedor
pkfield = idProv
nombre_campo_codigo = idProv
nombre_campo_desc = razSoc
cfieldname = idProv
Name = "sel_ProvDesde"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Height = 21
txtDescripcion.Left = 106
txtDescripcion.Top = 2
txtDescripcion.Width = 236
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: sel_ProvHasta
************************************************************
*** PROPIEDADES ***
Top = 71
Left = 120
Width = 345
Height = 25
TabIndex = 3
esnumerico = .T.
cfieldname = idProv
nombre_campo_codigo = idProv
nombre_campo_desc = razSoc
nombre_tabla = proveedor
pkfield = idProv
Name = "sel_ProvHasta"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Height = 21
txtDescripcion.Left = 106
txtDescripcion.Top = 2
txtDescripcion.Width = 236
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta26
************************************************************
*** PROPIEDADES ***
Caption = "Marca"
Height = 15
Left = 9
Top = 100
Width = 62
TabIndex = 22
Name = "Clsetiqueta26"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta27
************************************************************
*** PROPIEDADES ***
Caption = "Desde:"
Height = 15
Left = 73
Top = 100
Width = 46
TabIndex = 26
Name = "Clsetiqueta27"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta28
************************************************************
*** PROPIEDADES ***
Caption = "Hasta:"
Height = 15
Left = 73
Top = 123
Width = 45
TabIndex = 27
Name = "Clsetiqueta28"

*** METODOS ***


************************************************************
OBJETO: sel_MarcaDD
************************************************************
*** PROPIEDADES ***
Top = 94
Left = 120
Width = 345
Height = 25
TabIndex = 4
esnumerico = .T.
cfieldname = idMarca
nombre_campo_codigo = idMarca
nombre_campo_desc = descripcio
nombre_tabla = marcas
pkfield = idMarca
Name = "sel_MarcaDD"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Height = 21
txtDescripcion.Left = 106
txtDescripcion.Top = 2
txtDescripcion.Width = 236
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: sel_MarcaHH
************************************************************
*** PROPIEDADES ***
Top = 117
Left = 120
Width = 345
Height = 25
TabIndex = 5
esnumerico = .T.
cfieldname = idMarca
nombre_campo_codigo = idMarca
nombre_campo_desc = descripcio
nombre_tabla = marcas
pkfield = idMarca
Name = "sel_MarcaHH"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Height = 21
txtDescripcion.Left = 106
txtDescripcion.Top = 2
txtDescripcion.Width = 236
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: btnExcel
************************************************************
*** PROPIEDADES ***
Top = 199
Left = 730
TabIndex = 14
Name = "btnExcel"

*** METODOS ***
PROCEDURE Click
LOCAL lcFileName

thisform.toexcel = .t.
thisform.generar_lista()
SELECT cur_articulos

lcFileName = PUTFILE("Guardar como", "", "xls")

IF !(ALLTRIM(lcFileName) == "") THEN
	=Exp2Excel( "cur_artexcel", lcFileName, "Lista de Precios" )
ENDIF

thisform.contenido.sel_ProvDesde.blanquear()
thisform.contenido.sel_ProvHasta.blanquear()
thisform.contenido.sel_MarcaDD.blanquear()
thisform.contenido.sel_MarcaHH.blanquear()
thisform.contenido.sel_FamDesde.blanquear()
thisform.contenido.sel_FamHasta.blanquear()
thisform.contenido.sel_SubFamDesde.blanquear()
thisform.contenido.sel_SubFamHasta.blanquear()

ENDPROC


************************************************************
OBJETO: btnImprimir
************************************************************
*** PROPIEDADES ***
Top = 199
Left = 778
TabIndex = 15
Name = "btnImprimir"

*** METODOS ***
PROCEDURE Click
LOCAL m.provDD, m.provHH
LOCAL m.marcaDD, m.marcaHH
LOCAL m.familiaDD, m.familiaHH
LOCAL m.subfamDD, m.subfamHH
LOCAL lnIdProvDD, lnIdProvHH
LOCAL lnIdMarcaDD, lnMarcaHH
LOCAL lnIdFamiliaDD, lnIdFamiliaHH
LOCAL lnIdSubFamDD, lnIdSubFamHH
LOCAL m.Cliente

lnIdProvDD = thisform.contenido.sel_ProvDesde.valcpoid
lnIdProvHH = thisform.contenido.sel_ProvHasta.valcpoid
lnIdMarcaDD = thisform.contenido.sel_MarcaDD.valcpoid
lnIdMarcaHH = thisform.contenido.sel_MarcaHH.valcpoid
lnIdFamiliaDD = thisform.contenido.sel_FamDesde.valcpoid
lnIdFamiliaHH = thisform.contenido.sel_FamHasta.valcpoid
lnIdSubFamDD = thisform.contenido.sel_SubFamDesde.valcpoid
lnIdSubFamHH = thisform.contenido.sel_SubFamHasta.valcpoid

m.provDD = ""
m.provHH = ""
m.marcaDD = ""
m.marcaHH = ""
m.familiaDD = ""
m.familiaHH = ""
m.subfamDD = ""
m.subfamHH = ""
m.Ramo = ""

thisform.toexcel = .f.

thisform.generar_lista()

IF lnIdProvDD <> 0 .AND. lnIdProvHH <> 0 THEN
	m.provDD = thisform.contenido.sel_provDesde.txtDescripcion.Value
	m.provHH = thisform.contenido.sel_ProvHasta.txtDescripcion.Value	
ELSE
	m.provDD = "TODOS"
	m.provHH = "TODOS"
ENDIF

IF lnIdMarcaDD <> 0 .AND. lnIdMarcaHH <> 0 THEN
	m.marcaDD = thisform.contenido.sel_MarcaDD.txtDescripcion.Value
	m.marcaHH = thisform.contenido.sel_MarcaHH.txtDescripcion.Value
ELSE
	m.marcaDD = "TODOS"
	m.marcaHH = "TODOS"
ENDIF

IF lnIdFamiliaDD <> 0 .AND. lnIdFamiliaHH <> 0 THEN
	m.familiaDD = thisform.contenido.sel_FamDesde.txtDescripcion.Value
	m.familiaHH = thisform.contenido.sel_FamHasta.txtDescripcion.Value
ELSE
	m.familiaDD = "TODOS"
	m.familiaHH = "TODOS"
ENDIF

IF lnIdSubFamDD <> 0 .AND. lnIdSubFamHH <> 0 THEN
	m.subfamDD = thisform.contenido.sel_SubFamDesde.txtDescripcion.Value
	m.subfamHH = thisform.contenido.sel_SubFamHasta.txtDescripcion.Value
ELSE
	m.subfamDD = "TODOS"
	m.subfamHH = "TODOS"
ENDIF

IF thisform.contenido.chkEmitirACliente.Value = 1 THEN
	m.Ramo = "Ramo: " + ALLTRIM(STR(thisform.contenido.sel_ramos.txtCodigo.Value)) + " - " + ALLTRIM(thisform.contenido.sel_ramos.txtDescripcion.Value)
ENDIF

IF Thisform.Contenido.chkConFoto.Value = 0 THEN
	SELECT cur_articulos 
	REPORT FORM "rep_lista_precios" TO PRINTER PROMPT NODIALOG PREVIEW
ELSE
	SELECT cur_articulos
	REPORT FORM "rep_catalogo" TO PRINTER PROMPT NODIALOG PREVIEW
ENDIF

thisform.contenido.sel_ProvDesde.blanquear()
thisform.contenido.sel_ProvHasta.blanquear()
thisform.contenido.sel_MarcaDD.blanquear()
thisform.contenido.sel_MarcaHH.blanquear()
thisform.contenido.sel_FamDesde.blanquear()
thisform.contenido.sel_FamHasta.blanquear()
thisform.contenido.sel_SubFamDesde.blanquear()
thisform.contenido.sel_SubFamHasta.blanquear()
ENDPROC


************************************************************
OBJETO: btnSalir
************************************************************
*** PROPIEDADES ***
Top = 199
Left = 892
TabIndex = 16
Name = "btnSalir"

*** METODOS ***


************************************************************
OBJETO: chkPrMay
************************************************************
*** PROPIEDADES ***
Top = 216
Left = 11
Height = 18
Width = 158
Alignment = 0
Caption = "Emitir precio mayorista"
Value = 1
TabIndex = 13
Name = "chkPrMay"

*** METODOS ***


************************************************************
OBJETO: chkEmitirACliente
************************************************************
*** PROPIEDADES ***
Top = 12
Left = 11
Height = 18
Width = 182
Alignment = 0
Caption = "Emitir una lista para el ramo:"
TabIndex = 17
Name = "chkEmitirACliente"

*** METODOS ***
PROCEDURE Click
IF This.Value = 0 THEN
	Thisform.contenido.sel_ramos.txtCodigo.Enabled = .F.
ELSE
	Thisform.contenido.sel_ramos.txtCodigo.Enabled = .T.
ENDIF
ENDPROC


************************************************************
OBJETO: sel_ramos
************************************************************
*** PROPIEDADES ***
Top = 9
Left = 190
TabIndex = 1
esnumerico = .T.
nombre_campo_codigo = idRamo
nombre_campo_desc = descripcio
nombre_tabla = ramos
pkfield = idRamo
title_cols = Descripción
Name = "sel_ramos"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***
PROCEDURE recuperar_datos
LOCAL loResult
LOCAL lcSql
LOCAL llMrcv
LOCAL llFam
LOCAL llSubFam

loResult = CREATEOBJECT("odbc_result")
lcSql = ""
Thisform.ramo_fam = .F.
Thisform.ramo_mrcv = .F.
Thisform.ramo_sf = .F.

Thisform.idRamo = ramos.idRamo


&& Verifico si el ramo tiene alguna configuración
&& que se necesite

lcSql = "SELECT COUNT(*) AS cant FROM ramo_mrcv WHERE ramo_mrcv.idRamo = " + ALLTRIM(STR(Thisform.idRamo))
loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_x"

IF !loResult.OpenQuery(lcSql) THEN
	MESSAGEBOX(loResult.Error_Message, 0+48, Thisform.Caption)
	RETURN
ENDIF

IF INT(VAL(getConfig("SQLSRV"))) = 1 THEN
	IF cur_x.cant > 0 THEN
		Thisform.ramo_mrcv = .T.
	ENDIF
ELSE
	IF VAL(cur_x.cant) > 0 THEN
		Thisform.ramo_mrcv = .T.
	ENDIF
ENDIF

loResult.Close_Query()

lcSql = "SELECT COUNT(*) AS cant FROM ramofam WHERE ramofam.idRamo = " + ALLTRIM(STR(Thisform.idRamo))
loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_x"

IF !loResult.OpenQuery(lcSql) THEN
	MESSAGEBOX(loResult.Error_Message, 0+48, Thisform.Caption)
	RETURN
ENDIF

IF INT(VAL(getConfig("SQLSRV"))) = 1 THEN
	IF cur_x.cant > 0 THEN
		Thisform.ramo_fam = .T.
	ENDIF
ELSE
	IF VAL(cur_x.cant) > 0 THEN
		Thisform.ramo_fam = .T.
	ENDIF
ENDIF

loResult.Close_Query()

lcSql = "SELECT COUNT(*) AS cant FROM ramo_sf WHERE ramo_sf.idRamo = " + ALLTRIM(STR(Thisform.idRamo))
loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_x"

IF !loResult.OpenQuery(lcSql) THEN
	MESSAGEBOX(loResult.Error_Message, 0+48, Thisform.Caption)
	RETURN
ENDIF

IF INT(VAL(getConfig("SQLSRV"))) = 1 THEN
	IF cur_x.cant > 0 THEN
		Thisform.ramo_sf = .T.
	ENDIF
ELSE
	IF VAL(cur_x.cant) > 0 THEN
		Thisform.ramo_sf = .T.
	ENDIF
ENDIF

loResult.Close_Query()
ENDPROC


************************************************************
OBJETO: optOrden
************************************************************
*** PROPIEDADES ***
ButtonCount = 2
Height = 24
Left = 8
Top = 169
Width = 186
TabIndex = 10
Name = "optOrden"
Option1.FontSize = 8
Option1.Caption = "Código"
Option1.Height = 15
Option1.Left = 5
Option1.Top = 4
Option1.Width = 67
Option1.ForeColor = 158,106,75
Option1.Name = "Option1"
Option2.OLEDragMode = 0
Option2.FontSize = 8
Option2.Caption = "Descripción"
Option2.Left = 80
Option2.Top = 4
Option2.ForeColor = 158,106,75
Option2.Name = "Option2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta10
************************************************************
*** PROPIEDADES ***
Caption = "Ordenado por:"
Height = 15
Left = 9
Top = 153
Width = 84
TabIndex = 24
Name = "Clsetiqueta10"

*** METODOS ***


************************************************************
OBJETO: opg_precios
************************************************************
*** PROPIEDADES ***
ButtonCount = 2
Height = 24
Left = 245
Top = 170
Width = 284
TabIndex = 11
Name = "opg_precios"
Option1.FontSize = 8
Option1.Caption = "Precio de Venta"
Option1.Height = 15
Option1.Left = 5
Option1.Top = 4
Option1.Width = 118
Option1.ForeColor = 158,106,75
Option1.Name = "Option1"
Option2.OLEDragMode = 0
Option2.FontSize = 8
Option2.Caption = "Lista de Proveedor"
Option2.Height = 15
Option2.Left = 138
Option2.Top = 4
Option2.Width = 136
Option2.ForeColor = 158,106,75
Option2.Name = "Option2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta11
************************************************************
*** PROPIEDADES ***
Caption = "Seleccione el precio que desea imprimir:"
Height = 15
Left = 245
Top = 153
Width = 248
TabIndex = 23
Name = "Clsetiqueta11"

*** METODOS ***


************************************************************
OBJETO: chkConIVA
************************************************************
*** PROPIEDADES ***
Top = 174
Left = 538
Height = 18
Width = 72
Alignment = 0
Caption = "Con IVA"
TabIndex = 12
Name = "chkConIVA"

*** METODOS ***


************************************************************
OBJETO: chkConFoto
************************************************************
*** PROPIEDADES ***
Top = 174
Left = 617
Height = 18
Width = 119
Alignment = 0
Caption = "Imprimir con foto"
TabIndex = 12
Name = "chkConFoto"

*** METODOS ***


************************************************************
OBJETO: cls_imprimir_listas
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: clform_consart_mostrad
************************************************************
*** PROPIEDADES ***
Height = 515
Width = 947
DoCreate = .T.
Name = "clform_consart_mostrad"
contenido.Clsetiqueta1.Name = "Clsetiqueta1"
contenido.txtValorBuscado.Name = "txtValorBuscado"
contenido.grdArtic.COLUMN1.Header1.Name = "Header1"
contenido.grdArtic.COLUMN1.Text1.Visible = .T.
contenido.grdArtic.COLUMN1.Text1.Name = "Text1"
contenido.grdArtic.COLUMN1.Visible = .T.
contenido.grdArtic.COLUMN1.Name = "COLUMN1"
contenido.grdArtic.COLUMN2.Header1.Name = "Header1"
contenido.grdArtic.COLUMN2.Text1.Visible = .T.
contenido.grdArtic.COLUMN2.Text1.Name = "Text1"
contenido.grdArtic.COLUMN2.Visible = .T.
contenido.grdArtic.COLUMN2.Name = "COLUMN2"
contenido.grdArtic.COLUMN3.Header1.Name = "Header1"
contenido.grdArtic.COLUMN3.Text1.Visible = .T.
contenido.grdArtic.COLUMN3.Text1.Name = "Text1"
contenido.grdArtic.COLUMN3.Visible = .T.
contenido.grdArtic.COLUMN3.Name = "COLUMN3"
contenido.grdArtic.COLUMN4.Header1.Name = "Header1"
contenido.grdArtic.COLUMN4.Text1.Visible = .T.
contenido.grdArtic.COLUMN4.Text1.Name = "Text1"
contenido.grdArtic.COLUMN4.Visible = .T.
contenido.grdArtic.COLUMN4.Name = "COLUMN4"
contenido.grdArtic.COLUMN5.Header1.Name = "Header1"
contenido.grdArtic.COLUMN5.Text1.Visible = .T.
contenido.grdArtic.COLUMN5.Text1.Name = "Text1"
contenido.grdArtic.COLUMN5.Visible = .T.
contenido.grdArtic.COLUMN5.Name = "COLUMN5"
contenido.grdArtic.COLUMN6.Header1.Name = "Header1"
contenido.grdArtic.COLUMN6.Text1.Visible = .T.
contenido.grdArtic.COLUMN6.Text1.Name = "Text1"
contenido.grdArtic.COLUMN6.Visible = .T.
contenido.grdArtic.COLUMN6.Name = "COLUMN6"
contenido.grdArtic.COLUMN7.Header1.Name = "Header1"
contenido.grdArtic.COLUMN7.Text1.Visible = .T.
contenido.grdArtic.COLUMN7.Text1.Name = "Text1"
contenido.grdArtic.COLUMN7.Visible = .T.
contenido.grdArtic.COLUMN7.Name = "COLUMN7"
contenido.grdArtic.COLUMN8.Header1.Name = "Header1"
contenido.grdArtic.COLUMN8.Text1.Visible = .T.
contenido.grdArtic.COLUMN8.Text1.Name = "Text1"
contenido.grdArtic.COLUMN8.Visible = .T.
contenido.grdArtic.COLUMN8.Name = "COLUMN8"
contenido.grdArtic.COLUMN9.Header1.Name = "Header1"
contenido.grdArtic.COLUMN9.Text1.Visible = .T.
contenido.grdArtic.COLUMN9.Text1.Name = "Text1"
contenido.grdArtic.COLUMN9.Visible = .T.
contenido.grdArtic.COLUMN9.Name = "COLUMN9"
contenido.grdArtic.COLUMN10.Header1.Name = "Header1"
contenido.grdArtic.COLUMN10.Text1.Visible = .T.
contenido.grdArtic.COLUMN10.Text1.Name = "Text1"
contenido.grdArtic.COLUMN10.Visible = .T.
contenido.grdArtic.COLUMN10.Name = "COLUMN10"
contenido.grdArtic.COLUMN11.Header1.Name = "Header1"
contenido.grdArtic.COLUMN11.Text1.Visible = .T.
contenido.grdArtic.COLUMN11.Text1.Name = "Text1"
contenido.grdArtic.COLUMN11.Visible = .T.
contenido.grdArtic.COLUMN11.Name = "COLUMN11"
contenido.grdArtic.COLUMN12.Header1.Name = "Header1"
contenido.grdArtic.COLUMN12.Text1.Visible = .T.
contenido.grdArtic.COLUMN12.Text1.Name = "Text1"
contenido.grdArtic.COLUMN12.Visible = .T.
contenido.grdArtic.COLUMN12.Name = "COLUMN12"
contenido.grdArtic.COLUMN13.Header1.Name = "Header1"
contenido.grdArtic.COLUMN13.Text1.Visible = .T.
contenido.grdArtic.COLUMN13.Text1.Name = "Text1"
contenido.grdArtic.COLUMN13.Visible = .T.
contenido.grdArtic.COLUMN13.Name = "COLUMN13"
contenido.grdArtic.COLUMN14.Header1.Name = "Header1"
contenido.grdArtic.COLUMN14.Text1.Visible = .T.
contenido.grdArtic.COLUMN14.Text1.Name = "Text1"
contenido.grdArtic.COLUMN14.Visible = .T.
contenido.grdArtic.COLUMN14.Name = "COLUMN14"
contenido.grdArtic.COLUMN15.Header1.Name = "Header1"
contenido.grdArtic.COLUMN15.Text1.Visible = .T.
contenido.grdArtic.COLUMN15.Text1.Name = "Text1"
contenido.grdArtic.COLUMN15.Visible = .T.
contenido.grdArtic.COLUMN15.Name = "COLUMN15"
contenido.grdArtic.COLUMN16.Header1.Name = "Header1"
contenido.grdArtic.COLUMN16.Text1.Visible = .T.
contenido.grdArtic.COLUMN16.Text1.Name = "Text1"
contenido.grdArtic.COLUMN16.Visible = .T.
contenido.grdArtic.COLUMN16.Name = "COLUMN16"
contenido.grdArtic.COLUMN17.Header1.Name = "Header1"
contenido.grdArtic.COLUMN17.Text1.Visible = .T.
contenido.grdArtic.COLUMN17.Text1.Name = "Text1"
contenido.grdArtic.COLUMN17.Visible = .T.
contenido.grdArtic.COLUMN17.Name = "COLUMN17"
contenido.grdArtic.COLUMN18.Header1.Name = "Header1"
contenido.grdArtic.COLUMN18.Text1.Visible = .T.
contenido.grdArtic.COLUMN18.Text1.Name = "Text1"
contenido.grdArtic.COLUMN18.Visible = .T.
contenido.grdArtic.COLUMN18.Name = "COLUMN18"
contenido.grdArtic.COLUMN19.Header1.Name = "Header1"
contenido.grdArtic.COLUMN19.Text1.Visible = .T.
contenido.grdArtic.COLUMN19.Text1.Name = "Text1"
contenido.grdArtic.COLUMN19.Visible = .T.
contenido.grdArtic.COLUMN19.Name = "COLUMN19"
contenido.grdArtic.COLUMN20.Header1.Name = "Header1"
contenido.grdArtic.COLUMN20.Text1.Visible = .T.
contenido.grdArtic.COLUMN20.Text1.Name = "Text1"
contenido.grdArtic.COLUMN20.Visible = .T.
contenido.grdArtic.COLUMN20.Name = "COLUMN20"
contenido.grdArtic.Height = 327
contenido.grdArtic.Left = 7
contenido.grdArtic.Top = 48
contenido.grdArtic.Width = 936
contenido.grdArtic.Name = "grdArtic"
contenido.Clscerrar1.Top = 469
contenido.Clscerrar1.Left = 899
contenido.Clscerrar1.Name = "Clscerrar1"
contenido.Clsetiqueta2.Left = 433
contenido.Clsetiqueta2.Top = 592
contenido.Clsetiqueta2.Visible = .F.
contenido.Clsetiqueta2.Name = "Clsetiqueta2"
contenido.Clsetiqueta3.Anchor = 6
contenido.Clsetiqueta3.Left = 390
contenido.Clsetiqueta3.Top = 544
contenido.Clsetiqueta3.Visible = .F.
contenido.Clsetiqueta3.Name = "Clsetiqueta3"
contenido.Clsetiqueta4.Left = 715
contenido.Clsetiqueta4.Top = 610
contenido.Clsetiqueta4.Visible = .F.
contenido.Clsetiqueta4.Name = "Clsetiqueta4"
contenido.Clsetiqueta5.Anchor = 6
contenido.Clsetiqueta5.Left = 390
contenido.Clsetiqueta5.Top = 381
contenido.Clsetiqueta5.Name = "Clsetiqueta5"
contenido.txtPrVtaMay.Left = 554
contenido.txtPrVtaMay.Top = 582
contenido.txtPrVtaMay.Visible = .F.
contenido.txtPrVtaMay.Name = "txtPrVtaMay"
contenido.txtPrVtaMin.Anchor = 6
contenido.txtPrVtaMin.Left = 508
contenido.txtPrVtaMin.Top = 540
contenido.txtPrVtaMin.Visible = .F.
contenido.txtPrVtaMin.Width = 96
contenido.txtPrVtaMin.Name = "txtPrVtaMin"
contenido.txtPrFinalMay.Left = 846
contenido.txtPrFinalMay.Top = 605
contenido.txtPrFinalMay.Visible = .F.
contenido.txtPrFinalMay.Name = "txtPrFinalMay"
contenido.txtPrFinalMin.Anchor = 6
contenido.txtPrFinalMin.Left = 508
contenido.txtPrFinalMin.Top = 378
contenido.txtPrFinalMin.Name = "txtPrFinalMin"
contenido.Clsetiqueta6.Left = 426
contenido.Clsetiqueta6.Top = 562
contenido.Clsetiqueta6.Visible = .F.
contenido.Clsetiqueta6.Name = "Clsetiqueta6"
contenido.txtCostoRep.Left = 554
contenido.txtCostoRep.Top = 558
contenido.txtCostoRep.Visible = .F.
contenido.txtCostoRep.Name = "txtCostoRep"
contenido.Clsetiqueta7.Left = 649
contenido.Clsetiqueta7.Top = 564
contenido.Clsetiqueta7.Visible = .F.
contenido.Clsetiqueta7.Name = "Clsetiqueta7"
contenido.txtBonif1.Left = 695
contenido.txtBonif1.Top = 561
contenido.txtBonif1.Visible = .F.
contenido.txtBonif1.Name = "txtBonif1"
contenido.txtBonif2.Left = 749
contenido.txtBonif2.Top = 561
contenido.txtBonif2.Visible = .F.
contenido.txtBonif2.Name = "txtBonif2"
contenido.txtBonif3.Left = 803
contenido.txtBonif3.Top = 561
contenido.txtBonif3.Visible = .F.
contenido.txtBonif3.Name = "txtBonif3"
contenido.txtBonif4.Left = 853
contenido.txtBonif4.Top = 561
contenido.txtBonif4.Visible = .F.
contenido.txtBonif4.Name = "txtBonif4"
contenido.Clsetiqueta8.Left = 222
contenido.Clsetiqueta8.Top = 562
contenido.Clsetiqueta8.Visible = .F.
contenido.Clsetiqueta8.Name = "Clsetiqueta8"
contenido.txtListaProv.Left = 349
contenido.txtListaProv.Top = 559
contenido.txtListaProv.Visible = .F.
contenido.txtListaProv.Name = "txtListaProv"
contenido.Clsetiqueta9.Left = 223
contenido.Clsetiqueta9.Top = 609
contenido.Clsetiqueta9.Visible = .F.
contenido.Clsetiqueta9.Name = "Clsetiqueta9"
contenido.txtMargenMay.Left = 349
contenido.txtMargenMay.Top = 605
contenido.txtMargenMay.Visible = .F.
contenido.txtMargenMay.Name = "txtMargenMay"
contenido.Clsetiqueta10.Left = 222
contenido.Clsetiqueta10.Top = 633
contenido.Clsetiqueta10.Visible = .F.
contenido.Clsetiqueta10.Name = "Clsetiqueta10"
contenido.txtMargenMin.Left = 349
contenido.txtMargenMin.Top = 628
contenido.txtMargenMin.Visible = .F.
contenido.txtMargenMin.Name = "txtMargenMin"
contenido.Clsetiqueta11.Left = 223
contenido.Clsetiqueta11.Top = 586
contenido.Clsetiqueta11.Visible = .F.
contenido.Clsetiqueta11.Name = "Clsetiqueta11"
contenido.txtAlicIVA.Left = 349
contenido.txtAlicIVA.Top = 582
contenido.txtAlicIVA.Visible = .F.
contenido.txtAlicIVA.Name = "txtAlicIVA"
contenido.Clsetiqueta12.Left = 715
contenido.Clsetiqueta12.Top = 586
contenido.Clsetiqueta12.Visible = .F.
contenido.Clsetiqueta12.Name = "Clsetiqueta12"
contenido.txtCostoConIVA.Left = 846
contenido.txtCostoConIVA.Top = 581
contenido.txtCostoConIVA.Visible = .F.
contenido.txtCostoConIVA.Name = "txtCostoConIVA"
contenido.picFoto.Height = 130
contenido.picFoto.Left = 8
contenido.picFoto.Top = 379
contenido.picFoto.Width = 192
contenido.picFoto.Name = "picFoto"
contenido.Clsetiqueta13.Anchor = 6
contenido.Clsetiqueta13.Left = 206
contenido.Clsetiqueta13.Top = 381
contenido.Clsetiqueta13.Name = "Clsetiqueta13"
contenido.txtExistencia.Anchor = 6
contenido.txtExistencia.Left = 275
contenido.txtExistencia.Top = 378
contenido.txtExistencia.Name = "txtExistencia"
contenido.btnActualizar.Top = 469
contenido.btnActualizar.Left = 853
contenido.btnActualizar.Name = "btnActualizar"
contenido.btnMostrarPrecios.Top = 470
contenido.btnMostrarPrecios.Left = 207
contenido.btnMostrarPrecios.Name = "btnMostrarPrecios"
contenido.btnEquivalencias.Top = 470
contenido.btnEquivalencias.Left = 353
contenido.btnEquivalencias.Name = "btnEquivalencias"
contenido.Clsetiqueta14.Visible = .F.
contenido.Clsetiqueta14.Name = "Clsetiqueta14"
contenido.txtUltimaActualizacion.Visible = .F.
contenido.txtUltimaActualizacion.Name = "txtUltimaActualizacion"
contenido.Top = 0
contenido.Left = 0
contenido.Width = 948
contenido.Height = 519
contenido.Name = "contenido"
mov_stock.Top = 444
mov_stock.Left = 576
mov_stock.Name = "mov_stock"
faltantes.Name = "faltantes"

*** METODOS ***
PROCEDURE Init
NODEFAULT

LOCAL lcSql, oData

lcSql = "SELECT   	articulos.idArticulo, "
lcSql = lcSql + " 	articulos.codArt, "
lcSql = lcSql + " 	articulos.descripcio, "
lcSql = lcSql + "	marcas.descripcio as descMarca, "
lcSql = lcSql + " 	subfam.descripcio as descsubfam, "
lcSql = lcSql + " 	articulos.alicIVA, "
lcSql = lcSql + " 	articulos.prLista, "
lcSql = lcSql + " 	articulos.bonif1, "
lcSql = lcSql + " 	articulos.bonif2, "
lcSql = lcSql + " 	articulos.bonif3, "
lcSql = lcSql + " 	articulos.bonif4, "
lcSql = lcSql + " 	articulos.costoRep, " 
lcSql = lcSql + " 	articulos.margenMax, "
lcSql = lcSql + " 	articulos.margenMin, "
lcSql = lcSql + " 	articulos.prventaMax, "
lcSql = lcSql + " 	articulos.prventaMin, "
lcSql = lcSql + " 	articulos.prfinalMax, "
lcSql = lcSql + " 	articulos.prfinalMin, "
lcSql = lcSql + "	articulos.linkFoto, "
lcSql = lcSql + "	articulos.fecActuPre "
lcSql = lcSql + " FROM    articulos "
lcSql = lcSql + "		  INNER JOIN marcas ON  articulos.idmarca = marcas.idmarca "
lcSql = lcSql + "		  INNER JOIN subfam ON  articulos.idSubFam = subfam.idSubFam "
lcSql = lcSql + " WHERE articulos.fecBaja IS NULL "
lcSql = lcSql + " 		AND articulos.habilitado = 1 "


oData = CREATEOBJECT("odbc_Result")
oData.ActiveConnection = goConn.ActiveConnection
oData.cursor_name = "cur_Artic"
oData.OpenQuery(lcSql)

SELECT cur_Artic
INDEX ON idArticulo	TAG idArticulo	ASCENDING
INDEX ON descripcio TAG descripcio 	ASCENDING ADDITIVE
INDEX ON descMarca 	TAG descMarca	ASCENDING ADDITIVE
INDEX ON descsubfam	TAG descsubfam	ASCENDING ADDITIVE
INDEX ON alicIVA	TAG alicIVA		ASCENDING ADDITIVE
INDEX ON prLista	TAG prLista		ASCENDING ADDITIVE
INDEX ON bonif1		TAG bonif1 		ASCENDING ADDITIVE
INDEX ON bonif2		TAG bonif2		ASCENDING ADDITIVE
INDEX ON bonif3		TAG bonif3		ASCENDING ADDITIVE
INDEX ON bonif4 	TAG bonif4		ASCENDING ADDITIVE
INDEX ON costoRep	TAG costoRep	ASCENDING ADDITIVE
INDEX ON margenMax	TAG margenMax	ASCENDING ADDITIVE
INDEX ON margenMin 	TAG margenMin	ASCENDING ADDITIVE
INDEX ON prventaMax	TAG prventaMax	ASCENDING ADDITIVE
INDEX ON prventaMin TAG prventaMin 	ASCENDING ADDITIVE
INDEX ON prfinalMax	TAG prfinalMax	ASCENDING ADDITIVE
INDEX ON prfinalMin TAG prfinalMin	ASCENDING ADDITIVE
INDEX ON codArt 	TAG codArt 		ASCENDING ADDITIVE



SELECT cur_Artic
IF RECCOUNT() > 0
	GO TOP
	thisform.contenido.txtprVtaMay.Value = cur_Artic.prventaMax
	thisform.contenido.txtprFinalMin.Value = cur_Artic.prfinalMin
	thisform.contenido.txtprFinalMay.value = cur_Artic.prfinalMax
	thisform.contenido.txtPrVtaMin.Value = cur_Artic.prventaMin
	thisform.contenido.txtAlicIVA.Value = cur_Artic.alicIVA
	thisform.contenido.txtListaProv.Value = cur_Artic.prLista
	thisform.contenido.txtBonif1.Value = cur_Artic.bonif1
	thisform.contenido.txtBonif2.Value = cur_Artic.bonif2
	thisform.contenido.txtBonif3.Value = cur_Artic.bonif3
	thisform.contenido.txtBonif4.Value = cur_Artic.bonif4
	thisform.contenido.txtCostoRep.Value = cur_Artic.costoRep
	thisform.contenido.txtMargenMay.value = cur_Artic.margenMax
	Thisform.contenido.txtMargenMin.Value = cur_Artic.MargenMin

	thisform.contenido.txtCostoConIVA.Value = ROUND(cur_Artic.CostoRep + (cur_Artic.CostoRep * (thisform.contenido.txtAlicIVA.Value / 100)), 2)
	thisform.contenido.picFoto.Picture = IIF(ISNULL(cur_Artic.linkfoto), "", cur_Artic.linkfoto)
ENDIF

&& Muestro los campos necesarios solo para el mostrador
SELECT cur_Artic
Thisform.contenido.grdArtic.RecordSource = "cur_Artic"
Thisform.contenido.grdArtic.list_controlsource = "codArt,descripcio,descMarca,descsubfam,prfinalMin"
Thisform.contenido.grdArtic.lista_ancho_cols = "150,350,250,250,70"
Thisform.contenido.grdArtic.titulos_cabeceras = "Código,Descripción,Marca,Subfamilia,Precio"
Thisform.contenido.grdArtic.generar_grid()

ENDPROC


************************************************************
OBJETO: clform_consart_mostrad
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_form_consart_v2
************************************************************
*** PROPIEDADES ***
Height = 513
Width = 947
DoCreate = .T.
Name = "cls_form_consart_v2"
contenido.Clsetiqueta1.TabIndex = 1
contenido.Clsetiqueta1.Name = "Clsetiqueta1"
contenido.txtValorBuscado.Height = 21
contenido.txtValorBuscado.Left = 58
contenido.txtValorBuscado.TabIndex = 2
contenido.txtValorBuscado.Top = 19
contenido.txtValorBuscado.Width = 843
contenido.txtValorBuscado.Name = "txtValorBuscado"
contenido.grdArtic.COLUMN1.Header1.Name = "Header1"
contenido.grdArtic.COLUMN1.Text1.Name = "Text1"
contenido.grdArtic.COLUMN1.Name = "COLUMN1"
contenido.grdArtic.COLUMN2.Header1.Name = "Header1"
contenido.grdArtic.COLUMN2.Text1.Name = "Text1"
contenido.grdArtic.COLUMN2.Name = "COLUMN2"
contenido.grdArtic.COLUMN3.Header1.Name = "Header1"
contenido.grdArtic.COLUMN3.Text1.Name = "Text1"
contenido.grdArtic.COLUMN3.Name = "COLUMN3"
contenido.grdArtic.COLUMN4.Header1.Name = "Header1"
contenido.grdArtic.COLUMN4.Text1.Name = "Text1"
contenido.grdArtic.COLUMN4.Name = "COLUMN4"
contenido.grdArtic.COLUMN5.Header1.Name = "Header1"
contenido.grdArtic.COLUMN5.Text1.Name = "Text1"
contenido.grdArtic.COLUMN5.Name = "COLUMN5"
contenido.grdArtic.COLUMN6.Header1.Name = "Header1"
contenido.grdArtic.COLUMN6.Text1.Name = "Text1"
contenido.grdArtic.COLUMN6.Name = "COLUMN6"
contenido.grdArtic.COLUMN7.Header1.Name = "Header1"
contenido.grdArtic.COLUMN7.Text1.Name = "Text1"
contenido.grdArtic.COLUMN7.Name = "COLUMN7"
contenido.grdArtic.COLUMN8.Header1.Name = "Header1"
contenido.grdArtic.COLUMN8.Text1.Name = "Text1"
contenido.grdArtic.COLUMN8.Name = "COLUMN8"
contenido.grdArtic.COLUMN9.Header1.Name = "Header1"
contenido.grdArtic.COLUMN9.Text1.Name = "Text1"
contenido.grdArtic.COLUMN9.Name = "COLUMN9"
contenido.grdArtic.COLUMN10.Header1.Name = "Header1"
contenido.grdArtic.COLUMN10.Text1.Name = "Text1"
contenido.grdArtic.COLUMN10.Name = "COLUMN10"
contenido.grdArtic.COLUMN11.Header1.Name = "Header1"
contenido.grdArtic.COLUMN11.Text1.Name = "Text1"
contenido.grdArtic.COLUMN11.Name = "COLUMN11"
contenido.grdArtic.COLUMN12.Header1.Name = "Header1"
contenido.grdArtic.COLUMN12.Text1.Name = "Text1"
contenido.grdArtic.COLUMN12.Name = "COLUMN12"
contenido.grdArtic.COLUMN13.Header1.Name = "Header1"
contenido.grdArtic.COLUMN13.Text1.Name = "Text1"
contenido.grdArtic.COLUMN13.Name = "COLUMN13"
contenido.grdArtic.COLUMN14.Header1.Name = "Header1"
contenido.grdArtic.COLUMN14.Text1.Name = "Text1"
contenido.grdArtic.COLUMN14.Name = "COLUMN14"
contenido.grdArtic.COLUMN15.Header1.Name = "Header1"
contenido.grdArtic.COLUMN15.Text1.Name = "Text1"
contenido.grdArtic.COLUMN15.Name = "COLUMN15"
contenido.grdArtic.COLUMN16.Header1.Name = "Header1"
contenido.grdArtic.COLUMN16.Text1.Name = "Text1"
contenido.grdArtic.COLUMN16.Name = "COLUMN16"
contenido.grdArtic.COLUMN17.Header1.Name = "Header1"
contenido.grdArtic.COLUMN17.Text1.Name = "Text1"
contenido.grdArtic.COLUMN17.Name = "COLUMN17"
contenido.grdArtic.COLUMN18.Header1.Name = "Header1"
contenido.grdArtic.COLUMN18.Text1.Name = "Text1"
contenido.grdArtic.COLUMN18.Name = "COLUMN18"
contenido.grdArtic.COLUMN19.Header1.Name = "Header1"
contenido.grdArtic.COLUMN19.Text1.Name = "Text1"
contenido.grdArtic.COLUMN19.Name = "COLUMN19"
contenido.grdArtic.COLUMN20.Header1.Name = "Header1"
contenido.grdArtic.COLUMN20.Text1.Name = "Text1"
contenido.grdArtic.COLUMN20.Name = "COLUMN20"
contenido.grdArtic.TabIndex = 4
contenido.grdArtic.Name = "grdArtic"
contenido.Clscerrar1.TabIndex = 5
contenido.Clscerrar1.Name = "Clscerrar1"
contenido.Clsetiqueta2.TabIndex = 6
contenido.Clsetiqueta2.Name = "Clsetiqueta2"
contenido.Clsetiqueta3.TabIndex = 7
contenido.Clsetiqueta3.Name = "Clsetiqueta3"
contenido.Clsetiqueta4.TabIndex = 8
contenido.Clsetiqueta4.Name = "Clsetiqueta4"
contenido.Clsetiqueta5.TabIndex = 9
contenido.Clsetiqueta5.Name = "Clsetiqueta5"
contenido.txtPrVtaMay.TabIndex = 10
contenido.txtPrVtaMay.Name = "txtPrVtaMay"
contenido.txtPrVtaMin.TabIndex = 11
contenido.txtPrVtaMin.Name = "txtPrVtaMin"
contenido.txtPrFinalMay.TabIndex = 12
contenido.txtPrFinalMay.Name = "txtPrFinalMay"
contenido.txtPrFinalMin.TabIndex = 13
contenido.txtPrFinalMin.Name = "txtPrFinalMin"
contenido.Clsetiqueta6.TabIndex = 14
contenido.Clsetiqueta6.Name = "Clsetiqueta6"
contenido.txtCostoRep.TabIndex = 15
contenido.txtCostoRep.Name = "txtCostoRep"
contenido.Clsetiqueta7.TabIndex = 16
contenido.Clsetiqueta7.Name = "Clsetiqueta7"
contenido.txtBonif1.TabIndex = 17
contenido.txtBonif1.Name = "txtBonif1"
contenido.txtBonif2.TabIndex = 18
contenido.txtBonif2.Name = "txtBonif2"
contenido.txtBonif3.TabIndex = 19
contenido.txtBonif3.Name = "txtBonif3"
contenido.txtBonif4.TabIndex = 20
contenido.txtBonif4.Name = "txtBonif4"
contenido.Clsetiqueta8.TabIndex = 21
contenido.Clsetiqueta8.Name = "Clsetiqueta8"
contenido.txtListaProv.TabIndex = 22
contenido.txtListaProv.Name = "txtListaProv"
contenido.Clsetiqueta9.TabIndex = 23
contenido.Clsetiqueta9.Name = "Clsetiqueta9"
contenido.txtMargenMay.TabIndex = 24
contenido.txtMargenMay.Name = "txtMargenMay"
contenido.Clsetiqueta10.TabIndex = 25
contenido.Clsetiqueta10.Name = "Clsetiqueta10"
contenido.txtMargenMin.TabIndex = 26
contenido.txtMargenMin.Name = "txtMargenMin"
contenido.Clsetiqueta11.TabIndex = 27
contenido.Clsetiqueta11.Name = "Clsetiqueta11"
contenido.txtAlicIVA.TabIndex = 28
contenido.txtAlicIVA.Name = "txtAlicIVA"
contenido.Clsetiqueta12.TabIndex = 29
contenido.Clsetiqueta12.Name = "Clsetiqueta12"
contenido.txtCostoConIVA.TabIndex = 30
contenido.txtCostoConIVA.Name = "txtCostoConIVA"
contenido.picFoto.Name = "picFoto"
contenido.Clsetiqueta13.TabIndex = 31
contenido.Clsetiqueta13.Name = "Clsetiqueta13"
contenido.txtExistencia.TabIndex = 32
contenido.txtExistencia.Name = "txtExistencia"
contenido.btnActualizar.TabIndex = 33
contenido.btnActualizar.Name = "btnActualizar"
contenido.btnMostrarPrecios.TabIndex = 34
contenido.btnMostrarPrecios.Name = "btnMostrarPrecios"
contenido.btnEquivalencias.TabIndex = 35
contenido.btnEquivalencias.Name = "btnEquivalencias"
contenido.Clsetiqueta14.Name = "Clsetiqueta14"
contenido.txtUltimaActualizacion.Name = "txtUltimaActualizacion"
contenido.Name = "contenido"
mov_stock.Name = "mov_stock"
faltantes.Name = "faltantes"

*** METODOS ***
PROCEDURE buscar
*******************************************************
* Permite buscar los artículos en la base de datos
* según la frase buscada
*******************************************************
LOCAL lcSql, oData, lcFrase, lnExistencia

lcFrase = "%" + STRTRAN(ALLTRIM(thisform.contenido.txtvalorBuscado.Value), " ", "%") + "%"
oData = CREATEOBJECT("odbc_Result")

TEXT TO lcSql NOSHOW
	SELECT   	
		articulos.idArticulo,
		articulos.codArt, 
		articulos.descripcio, 
		marcas.descripcio as descMarca, 
		subfam.descripcio as descsubfam, 
		articulos.alicIVA, 
		articulos.prLista, 
		articulos.bonif1, 
		articulos.bonif2, 
		articulos.bonif3, 
		articulos.bonif4, 
		articulos.costoRep, 
		articulos.margenMax, 
		articulos.margenMin, 
		articulos.prventaMax, 
		articulos.prventaMin, 
		articulos.prfinalMax, 
		articulos.prfinalMin, 
		articulos.linkFoto,
		articulos.fecActuPre
	FROM 
		articulos 
			INNER JOIN marcas ON  articulos.idmarca = marcas.idmarca 
			INNER JOIN subfam ON  articulos.idSubFam = subfam.idSubFam 
	WHERE 
		articulos.fecBaja IS NULL AND 
		articulos.habilitado = 1 AND 
		(articulos.codArt LIKE ?valorBuscado OR
		articulos.descripcio LIKE ?valorBuscado OR
		marcas.descripcio LIKE ?valorBuscado OR
		subfam.descripcio LIKE ?valorBuscado)
ENDTEXT

lcSql = oData.addParameter(lcSql, "valorBuscado", ALLTRIM(lcFrase), .t., .f.)

oData.ActiveConnection = goConn.ActiveConnection
oData.cursor_name = "cur_tmp"
oData.OpenQuery(lcSql)

SELECT cur_Artic
ZAP
APPEND FROM DBF("cur_tmp")

* Actualizo la existencia en el cursor
SELECT cur_Artic
GO TOP
Do While !Eof("cur_Artic")
	Select cur_Artic
	lnExistencia = This.mov_stock.get_exist_byart(cur_Artic.idArticulo)
	Lock()
	Replace cur_Artic.existencia WITH lnExistencia
	Unlock
	
	Select cur_Artic
	SKIP
EndDo

SELECT cur_Artic
GO TOP

oData.close_query()

Thisform.contenido.grdArtic.Refresh()
Thisform.contenido.grdArtic.SetFocus()
ENDPROC
PROCEDURE Load
DODEFAULT()

CREATE CURSOR cur_Artic ( ;
	idArticulo	integer	,;
	codArt		C(20)	,;
	descripcio	C(60)	,;
	descMarca	C(60)	,;
	descsubfam	C(60)	,;
	alicIVA		double	,;
	prLista		double	,;
	bonif1		double	,;
	bonif2		double	,;
	bonif3		double	,;
	bonif4		double	,;
	costoRep	double	,;
	margenMax	double	,;
	margenMin	double	,;
	prventaMax	double	,;
	prventaMin	double	,;
	prfinalMax	double	,;
	prfinalMin	double 	,;
	linkfoto	double NULL	,;
	fecActuPre datetime NULL,;
	existencia  N(20, 2))
	
SELECT cur_Artic
INDEX ON idArticulo	TAG idArticulo	ASCENDING
Index ON existencia	TAG existencia	ASCENDING ADDITIVE
INDEX ON descripcio TAG descripcio 	ASCENDING ADDITIVE
INDEX ON descMarca 	TAG descMarca	ASCENDING ADDITIVE
INDEX ON descsubfam	TAG descsubfam	ASCENDING ADDITIVE
INDEX ON alicIVA	TAG alicIVA		ASCENDING ADDITIVE
INDEX ON prLista	TAG prLista		ASCENDING ADDITIVE
INDEX ON bonif1		TAG bonif1 		ASCENDING ADDITIVE
INDEX ON bonif2		TAG bonif2		ASCENDING ADDITIVE
INDEX ON bonif3		TAG bonif3		ASCENDING ADDITIVE
INDEX ON bonif4 	TAG bonif4		ASCENDING ADDITIVE
INDEX ON costoRep	TAG costoRep	ASCENDING ADDITIVE
INDEX ON margenMax	TAG margenMax	ASCENDING ADDITIVE
INDEX ON margenMin 	TAG margenMin	ASCENDING ADDITIVE
INDEX ON prventaMax	TAG prventaMax	ASCENDING ADDITIVE
INDEX ON prventaMin TAG prventaMin 	ASCENDING ADDITIVE
INDEX ON prfinalMax	TAG prfinalMax	ASCENDING ADDITIVE
INDEX ON prfinalMin TAG prfinalMin	ASCENDING ADDITIVE
INDEX ON codArt 	TAG codArt 		ASCENDING ADDITIVE

ENDPROC
PROCEDURE Init
*************************************************************
* En este método dejo solo la configuración de la grilla.
*************************************************************

SELECT cur_Artic
Thisform.contenido.grdArtic.RecordSource = "cur_Artic"
Thisform.contenido.grdArtic.list_controlsource = "codArt,descripcio,descMarca,descsubfam,prventaMax,prventaMin,prfinalMax,prfinalMin,existencia"
Thisform.contenido.grdArtic.lista_ancho_cols = "150,350,100,100,80,80,80,80,80"
Thisform.contenido.grdArtic.titulos_cabeceras = "Código,Descripción,Marca,SubFamilia,Venta May.,Venta Min.,c/IVA May.,c/IVA Min.,Existencia"
Thisform.contenido.grdArtic.generar_grid()

ENDPROC
PROCEDURE contenido.txtValorBuscado.KeyPress
LPARAMETERS nKeyCode, nShiftAltCtrl

IF nKeyCode = 13 THEN
	thisform.buscar()
ENDIF
ENDPROC
PROCEDURE contenido.txtValorBuscado.InteractiveChange
** Con este comentario cancelo la búsqueda que realiza la clase padre.
ENDPROC
PROCEDURE contenido.grdArtic.AfterRowColChange
LPARAMETERS nColIndex

SELECT cur_Artic
thisform.contenido.txtprVtaMay.Value = cur_Artic.prventaMax
thisform.contenido.txtprFinalMin.Value = cur_Artic.prfinalMin
thisform.contenido.txtprFinalMay.value = cur_Artic.prfinalMax
thisform.contenido.txtPrVtaMin.Value = cur_Artic.prventaMin
thisform.contenido.txtAlicIVA.Value = cur_Artic.alicIVA
thisform.contenido.txtListaProv.Value = cur_Artic.prLista
thisform.contenido.txtBonif1.Value = cur_Artic.bonif1
thisform.contenido.txtBonif2.Value = cur_Artic.bonif2
thisform.contenido.txtBonif3.Value = cur_Artic.bonif3
thisform.contenido.txtBonif4.Value = cur_Artic.bonif4
thisform.contenido.txtCostoRep.Value = cur_Artic.costoRep
thisform.contenido.txtMargenMay.value = cur_Artic.margenMax
Thisform.contenido.txtMargenMin.Value = cur_Artic.MargenMin
Thisform.contenido.txtUltimaActualizacion.Value = cur_Artic.fecActuPre
Thisform.contenido.txtExistencia.Value = cur_Artic.existencia

thisform.contenido.txtCostoConIVA.Value = ROUND(cur_Artic.CostoRep + (cur_Artic.CostoRep * (thisform.contenido.txtAlicIVA.Value / 100)), 2)
ENDPROC
PROCEDURE contenido.btnActualizar.Click
****************************************************
* Vuelve a buscar para refrescar los datos.
****************************************************
thisform.buscar()
ENDPROC


************************************************************
OBJETO: btnBuscar
************************************************************
*** PROPIEDADES ***
Top = 9
Left = 902
Height = 36
Width = 42
Anchor = 9
TabIndex = 3
Name = "btnBuscar"

*** METODOS ***
PROCEDURE Click
thisform.buscar()
ENDPROC


************************************************************
OBJETO: cls_form_consart_v2
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cl_form_consart
************************************************************
*** PROPIEDADES ***
Height = 513
Width = 946
DoCreate = .T.
Caption = "Consulta de Artículos"
MaxButton = .T.
MinButton = .T.
WindowState = 2
Name = "cl_form_consart"
contenido.Name = "contenido"

*** METODOS ***
PROCEDURE Init
LOCAL lcSql, oData

lcSql = "SELECT   	articulos.idArticulo, "
lcSql = lcSql + " 	articulos.codArt, "
lcSql = lcSql + " 	articulos.descripcio, "
lcSql = lcSql + "	marcas.descripcio as descMarca, "
lcSql = lcSql + " 	subfam.descripcio as descsubfam, "
lcSql = lcSql + " 	articulos.alicIVA, "
lcSql = lcSql + " 	articulos.prLista, "
lcSql = lcSql + " 	articulos.bonif1, "
lcSql = lcSql + " 	articulos.bonif2, "
lcSql = lcSql + " 	articulos.bonif3, "
lcSql = lcSql + " 	articulos.bonif4, "
lcSql = lcSql + " 	articulos.costoRep, " 
lcSql = lcSql + " 	articulos.margenMax, "
lcSql = lcSql + " 	articulos.margenMin, "
lcSql = lcSql + " 	articulos.prventaMax, "
lcSql = lcSql + " 	articulos.prventaMin, "
lcSql = lcSql + " 	articulos.prfinalMax, "
lcSql = lcSql + " 	articulos.prfinalMin, "
lcSql = lcSql + "	articulos.linkFoto, "
lcSql = lcSql + "	articulos.fecActuPre "
lcSql = lcSql + " FROM    articulos "
lcSql = lcSql + "		  INNER JOIN marcas ON  articulos.idmarca = marcas.idmarca "
lcSql = lcSql + "		  INNER JOIN subfam ON  articulos.idSubFam = subfam.idSubFam "
lcSql = lcSql + " WHERE articulos.fecBaja IS NULL "
lcSql = lcSql + " 		AND articulos.habilitado = 1 "

oData = CREATEOBJECT("odbc_Result")
oData.ActiveConnection = goConn.ActiveConnection
oData.cursor_name = "cur_Artic"
oData.OpenQuery(lcSql)

SELECT cur_Artic
INDEX ON idArticulo	TAG idArticulo	ASCENDING
INDEX ON descripcio TAG descripcio 	ASCENDING ADDITIVE
INDEX ON descMarca 	TAG descMarca	ASCENDING ADDITIVE
INDEX ON descsubfam	TAG descsubfam	ASCENDING ADDITIVE
INDEX ON alicIVA	TAG alicIVA		ASCENDING ADDITIVE
INDEX ON prLista	TAG prLista		ASCENDING ADDITIVE
INDEX ON bonif1		TAG bonif1 		ASCENDING ADDITIVE
INDEX ON bonif2		TAG bonif2		ASCENDING ADDITIVE
INDEX ON bonif3		TAG bonif3		ASCENDING ADDITIVE
INDEX ON bonif4 	TAG bonif4		ASCENDING ADDITIVE
INDEX ON costoRep	TAG costoRep	ASCENDING ADDITIVE
INDEX ON margenMax	TAG margenMax	ASCENDING ADDITIVE
INDEX ON margenMin 	TAG margenMin	ASCENDING ADDITIVE
INDEX ON prventaMax	TAG prventaMax	ASCENDING ADDITIVE
INDEX ON prventaMin TAG prventaMin 	ASCENDING ADDITIVE
INDEX ON prfinalMax	TAG prfinalMax	ASCENDING ADDITIVE
INDEX ON prfinalMin TAG prfinalMin	ASCENDING ADDITIVE
INDEX ON codArt 	TAG codArt 		ASCENDING ADDITIVE



SELECT cur_Artic
IF RECCOUNT() > 0
	GO TOP
	thisform.contenido.txtprVtaMay.Value = cur_Artic.prventaMax
	thisform.contenido.txtprFinalMin.Value = cur_Artic.prfinalMin
	thisform.contenido.txtprFinalMay.value = cur_Artic.prfinalMax
	thisform.contenido.txtPrVtaMin.Value = cur_Artic.prventaMin
	thisform.contenido.txtAlicIVA.Value = cur_Artic.alicIVA
	thisform.contenido.txtListaProv.Value = cur_Artic.prLista
	thisform.contenido.txtBonif1.Value = cur_Artic.bonif1
	thisform.contenido.txtBonif2.Value = cur_Artic.bonif2
	thisform.contenido.txtBonif3.Value = cur_Artic.bonif3
	thisform.contenido.txtBonif4.Value = cur_Artic.bonif4
	thisform.contenido.txtCostoRep.Value = cur_Artic.costoRep
	thisform.contenido.txtMargenMay.value = cur_Artic.margenMax
	Thisform.contenido.txtMargenMin.Value = cur_Artic.MargenMin

	thisform.contenido.txtCostoConIVA.Value = ROUND(cur_Artic.CostoRep + (cur_Artic.CostoRep * (thisform.contenido.txtAlicIVA.Value / 100)), 2)
	thisform.contenido.picFoto.Picture = IIF(ISNULL(cur_Artic.linkfoto), "", cur_Artic.linkfoto)
ENDIF


SELECT cur_Artic
Thisform.contenido.grdArtic.RecordSource = "cur_Artic"
Thisform.contenido.grdArtic.list_controlsource = "codArt,descripcio,descMarca,descsubfam,prventaMax,prventaMin,prfinalMax,prfinalMin"
Thisform.contenido.grdArtic.lista_ancho_cols = "150,350,150,180,80,80,80,80"
Thisform.contenido.grdArtic.titulos_cabeceras = "Código,Descripción,Marca,SubFamilia,Venta May.,Venta Min.,c/IVA May.,c/IVA Min."
Thisform.contenido.grdArtic.generar_grid()

ENDPROC
PROCEDURE Load
DODEFAULT()

*!*	CREATE CURSOR cur_Artic ( ;
*!*		idArticulo	integer	,;
*!*		codArt		C(20)	,;
*!*		descripcio	C(60)	,;
*!*		descMarca	C(60)	,;
*!*		descsubfam	C(60)	,;
*!*		alicIVA		double	,;
*!*		prLista		double	,;
*!*		bonif1		double	,;
*!*		bonif2		double	,;
*!*		bonif3		double	,;
*!*		bonif4		double	,;
*!*		costoRep	double	,;
*!*		margenMax	double	,;
*!*		margenMin	double	,;
*!*		prventaMax	double	,;
*!*		prventaMin	double	,;
*!*		prfinalMax	double	,;
*!*		prfinalMin	double 	,;
*!*		linkfoto	double NULL	,;
*!*		fecActuPre datetime NULL)
*!*		


ENDPROC


************************************************************
OBJETO: mov_stock
************************************************************
*** PROPIEDADES ***
Top = 480
Left = 564
Height = 17
Width = 37
Name = "mov_stock"

*** METODOS ***


************************************************************
OBJETO: faltantes
************************************************************
*** PROPIEDADES ***
Top = 480
Left = 612
Height = 17
Width = 36
Name = "faltantes"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Anchor = 3
Caption = "Buscar:"
Height = 15
Left = 10
Top = 23
Width = 51
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: txtValorBuscado
************************************************************
*** PROPIEDADES ***
Anchor = 11
Height = 21
Left = 58
Top = 19
Width = 885
Name = "txtValorBuscado"

*** METODOS ***
PROCEDURE InteractiveChange
LOCAL lnCont, lcRef
LOCAL lcExpresion, i, lcValorBuscado


lcRef = ""
lcExpresion = ""
lcValorBuscado = STRTRAN(ALLTRIM(thisform.contenido.TxtValorBuscado.Value)," ","*")
lcValorBuscado = STRTRAN(ALLTRIM(lcValorBuscado), "'", "*")

lcExpresion = "LIKE('*" + ALLTRIM(lcValorBuscado) + "*', cur_Artic.CodArt) " 
lcExpresion = lcExpresion + " OR LIKE('*" + ALLTRIM(lcValorBuscado) + "*', cur_Artic.Descripcio) "
lcExpresion = lcExpresion + " OR LIKE('*" + ALLTRIM(lcValorBuscado) + "*', cur_Artic.descMarca) "
lcExpresion = lcExpresion + " OR LIKE('*" + ALLTRIM(lcValorBuscado) + "*', cur_Artic.descsubfam) "

SELECT cur_Artic
IF ALLTRIM(lcValorBuscado) == "" THEN
	SET FILTER TO
ELSE
	SET FILTER TO &lcExpresion
ENDIF

Thisform.contenido.grdArtic.Refresh()

ENDPROC


************************************************************
OBJETO: grdArtic
************************************************************
*** PROPIEDADES ***
Anchor = 15
Height = 292
Left = 7
Top = 48
Width = 936
Name = "grdArtic"
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
PROCEDURE press_enter
*Thisform.cbte_m2.contenido.btnGrabar.Enabled = .F.
*thisform.agregar_item()

LOCAL loForm

&&KEYBOARD '\{LEFTARROW}\'

loForm = CREATEOBJECT("cls_agregafalt")
loForm.Show(1)

IF loForm.aceptar THEN
	THISFORM.faltantes.grabar(0, cur_Artic.idArticulo, cur_Artic.codArt, loForm.unicpr, loForm.Cantidad, loForm.idCliente)
ENDIF

loForm.Release()
ENDPROC
PROCEDURE AfterRowColChange
LPARAMETERS nColIndex

SELECT cur_Artic
thisform.contenido.txtprVtaMay.Value = cur_Artic.prventaMax
thisform.contenido.txtprFinalMin.Value = cur_Artic.prfinalMin
thisform.contenido.txtprFinalMay.value = cur_Artic.prfinalMax
thisform.contenido.txtPrVtaMin.Value = cur_Artic.prventaMin
thisform.contenido.txtAlicIVA.Value = cur_Artic.alicIVA
thisform.contenido.txtListaProv.Value = cur_Artic.prLista
thisform.contenido.txtBonif1.Value = cur_Artic.bonif1
thisform.contenido.txtBonif2.Value = cur_Artic.bonif2
thisform.contenido.txtBonif3.Value = cur_Artic.bonif3
thisform.contenido.txtBonif4.Value = cur_Artic.bonif4
thisform.contenido.txtCostoRep.Value = cur_Artic.costoRep
thisform.contenido.txtMargenMay.value = cur_Artic.margenMax
Thisform.contenido.txtMargenMin.Value = cur_Artic.MargenMin
Thisform.contenido.txtUltimaActualizacion.Value = cur_Artic.fecActuPre 

thisform.contenido.txtCostoConIVA.Value = ROUND(cur_Artic.CostoRep + (cur_Artic.CostoRep * (thisform.contenido.txtAlicIVA.Value / 100)), 2)
ENDPROC


************************************************************
OBJETO: Clscerrar1
************************************************************
*** PROPIEDADES ***
Top = 465
Left = 898
Height = 44
Width = 45
Anchor = 12
Name = "Clscerrar1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Anchor = 36
Caption = "Pr. Lista Mayorista:"
Height = 15
Left = 472
Top = 371
Width = 130
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Anchor = 36
Caption = "Pr. Lista Minorista:"
Height = 15
Left = 472
Top = 395
Width = 124
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
FontItalic = .F.
Anchor = 12
Caption = "Con I.V.A Mayorista:"
Height = 15
Left = 715
Top = 395
Width = 130
ForeColor = 255,0,0
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
FontItalic = .F.
Anchor = 12
Caption = "Con I.V.A Minorista:"
Height = 15
Left = 715
Top = 418
Width = 118
ForeColor = 255,0,0
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: txtPrVtaMay
************************************************************
*** PROPIEDADES ***
Anchor = 36
Height = 21
Left = 599
ReadOnly = .T.
Top = 367
Width = 77
Name = "txtPrVtaMay"

*** METODOS ***


************************************************************
OBJETO: txtPrVtaMin
************************************************************
*** PROPIEDADES ***
Anchor = 36
Height = 21
Left = 599
ReadOnly = .T.
Top = 391
Width = 77
Name = "txtPrVtaMin"

*** METODOS ***


************************************************************
OBJETO: txtPrFinalMay
************************************************************
*** PROPIEDADES ***
FontItalic = .F.
Anchor = 12
Height = 21
Left = 846
ReadOnly = .T.
Top = 390
Width = 96
ForeColor = 255,0,0
Name = "txtPrFinalMay"

*** METODOS ***


************************************************************
OBJETO: txtPrFinalMin
************************************************************
*** PROPIEDADES ***
FontItalic = .F.
Anchor = 12
Height = 21
Left = 846
ReadOnly = .T.
Top = 414
Width = 96
ForeColor = 255,0,0
Name = "txtPrFinalMin"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta6
************************************************************
*** PROPIEDADES ***
Anchor = 36
Caption = "Costo de Reposición:"
Height = 15
Left = 472
Top = 347
Width = 127
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: txtCostoRep
************************************************************
*** PROPIEDADES ***
Anchor = 36
Height = 21
Left = 599
ReadOnly = .T.
Top = 343
Width = 77
Name = "txtCostoRep"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta7
************************************************************
*** PROPIEDADES ***
Anchor = 12
Caption = "Desc.:"
Height = 15
Left = 687
Top = 346
Width = 46
Name = "Clsetiqueta7"

*** METODOS ***


************************************************************
OBJETO: txtBonif1
************************************************************
*** PROPIEDADES ***
Anchor = 12
Height = 21
Left = 733
ReadOnly = .T.
Top = 343
Width = 52
Name = "txtBonif1"

*** METODOS ***


************************************************************
OBJETO: txtBonif2
************************************************************
*** PROPIEDADES ***
Anchor = 12
Height = 21
Left = 787
ReadOnly = .T.
Top = 343
Width = 52
Name = "txtBonif2"

*** METODOS ***


************************************************************
OBJETO: txtBonif3
************************************************************
*** PROPIEDADES ***
Anchor = 12
Height = 21
Left = 841
ReadOnly = .T.
Top = 343
Width = 48
Name = "txtBonif3"

*** METODOS ***


************************************************************
OBJETO: txtBonif4
************************************************************
*** PROPIEDADES ***
Anchor = 12
Height = 21
Left = 891
ReadOnly = .T.
Top = 343
Width = 51
Name = "txtBonif4"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta8
************************************************************
*** PROPIEDADES ***
Anchor = 6
Caption = "Precio de Lista Prov.:"
Height = 15
Left = 257
Top = 348
Width = 127
Name = "Clsetiqueta8"

*** METODOS ***


************************************************************
OBJETO: txtListaProv
************************************************************
*** PROPIEDADES ***
Anchor = 6
Height = 21
Left = 384
ReadOnly = .T.
Top = 345
Width = 70
Name = "txtListaProv"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta9
************************************************************
*** PROPIEDADES ***
Anchor = 6
Caption = "Margen Mayorista:"
Height = 15
Left = 257
Top = 395
Width = 113
Name = "Clsetiqueta9"

*** METODOS ***


************************************************************
OBJETO: txtMargenMay
************************************************************
*** PROPIEDADES ***
Anchor = 6
Height = 21
Left = 384
ReadOnly = .T.
Top = 391
Width = 71
Name = "txtMargenMay"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta10
************************************************************
*** PROPIEDADES ***
Anchor = 6
Caption = "Margen Minorista:"
Height = 15
Left = 257
Top = 419
Width = 106
Name = "Clsetiqueta10"

*** METODOS ***


************************************************************
OBJETO: txtMargenMin
************************************************************
*** PROPIEDADES ***
Anchor = 6
Height = 21
Left = 384
ReadOnly = .T.
Top = 414
Width = 71
Name = "txtMargenMin"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta11
************************************************************
*** PROPIEDADES ***
Anchor = 6
Caption = "Alícuota I.V.A.:"
Height = 15
Left = 257
Top = 372
Width = 99
Name = "Clsetiqueta11"

*** METODOS ***


************************************************************
OBJETO: txtAlicIVA
************************************************************
*** PROPIEDADES ***
Anchor = 6
Height = 21
Left = 384
ReadOnly = .T.
Top = 368
Width = 71
Name = "txtAlicIVA"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta12
************************************************************
*** PROPIEDADES ***
FontItalic = .F.
Anchor = 12
Caption = "Costo con I.V.A:"
Height = 15
Left = 715
Top = 371
Width = 99
ForeColor = 255,0,0
Name = "Clsetiqueta12"

*** METODOS ***


************************************************************
OBJETO: txtCostoConIVA
************************************************************
*** PROPIEDADES ***
FontItalic = .F.
Anchor = 12
Height = 21
Left = 846
ReadOnly = .T.
Top = 366
Width = 96
ForeColor = 255,0,0
Name = "txtCostoConIVA"

*** METODOS ***


************************************************************
OBJETO: picFoto
************************************************************
*** PROPIEDADES ***
Anchor = 6
Height = 169
Left = 9
MousePointer = 15
Top = 343
Width = 225
ToolTipText = "Ampliar Foto"
Name = "picFoto"

*** METODOS ***
PROCEDURE Click
DO FORM "frmamplifoto"

Thisform.contenido.grdArtic.SetFocus()           
ENDPROC


************************************************************
OBJETO: Clsetiqueta13
************************************************************
*** PROPIEDADES ***
FontItalic = .F.
Anchor = 12
Caption = "Existencia:"
Height = 15
Left = 715
Top = 443
Width = 72
ForeColor = 255,0,0
Name = "Clsetiqueta13"

*** METODOS ***


************************************************************
OBJETO: txtExistencia
************************************************************
*** PROPIEDADES ***
FontItalic = .F.
Anchor = 12
Height = 21
Left = 847
ReadOnly = .T.
Top = 438
Width = 96
ForeColor = 255,0,0
isnumeric = .T.
Name = "txtExistencia"

*** METODOS ***


************************************************************
OBJETO: btnActualizar
************************************************************
*** PROPIEDADES ***
Top = 465
Left = 850
Anchor = 12
Visible = .F.
Name = "btnActualizar"

*** METODOS ***
PROCEDURE Click
LOCAL lcSql
LOCAL oData, lnPosActual

SELECT cur_Artic
lnPosActual = RECNO("cur_Artic")

SELECT cur_Artic
IF RECCOUNT() > 0
	ZAP
ENDIF

lcSql = "SELECT   	articulos.idArticulo, "
lcSql = lcSql + " 	articulos.codArt, "
lcSql = lcSql + " 	articulos.descripcio, "
lcSql = lcSql + "	marcas.descripcio as descMarca, "
lcSql = lcSql + " 	subfam.descripcio as descsubfam, "
lcSql = lcSql + " 	articulos.alicIVA, "
lcSql = lcSql + " 	articulos.prLista, "
lcSql = lcSql + " 	articulos.bonif1, "
lcSql = lcSql + " 	articulos.bonif2, "
lcSql = lcSql + " 	articulos.bonif3, "
lcSql = lcSql + " 	articulos.bonif4, "
lcSql = lcSql + " 	articulos.costoRep, " 
lcSql = lcSql + " 	articulos.margenMax, "
lcSql = lcSql + " 	articulos.margenMin, "
lcSql = lcSql + " 	articulos.prventaMax, "
lcSql = lcSql + " 	articulos.prventaMin, "
lcSql = lcSql + " 	articulos.prfinalMax, "
lcSql = lcSql + " 	articulos.prfinalMin, "
lcSql = lcSql + "	articulos.linkFoto "
lcSql = lcSql + " FROM    articulos "
lcSql = lcSql + "		  INNER JOIN marcas ON  articulos.idmarca = marcas.idmarca "
lcSql = lcSql + "		  INNER JOIN subfam ON  articulos.idSubFam = subfam.idSubFam "
lcSql = lcSql + " WHERE articulos.fecBaja IS NULL "
lcSql = lcSql + " 		AND articulos.habilitado = 1 "

oData = CREATEOBJECT("odbc_Result")
oData.ActiveConnection = goConn.ActiveConnection
oData.cursor_name = "cur_Artic"
oData.OpenQuery(lcSql)

IF !(ALLTRIM(thisform.contenido.txtValorBuscado.Value) == "") THEN
	Thisform.contenido.txtvalorBuscado.InteractiveChange()
ENDIF

SELECT cur_Artic
INDEX ON idArticulo	TAG idArticulo	ASCENDING
INDEX ON descripcio TAG descripcio 	ASCENDING ADDITIVE
INDEX ON descMarca 	TAG descMarca	ASCENDING ADDITIVE
INDEX ON descsubfam	TAG descsubfam	ASCENDING ADDITIVE
INDEX ON alicIVA	TAG alicIVA		ASCENDING ADDITIVE
INDEX ON prLista	TAG prLista		ASCENDING ADDITIVE
INDEX ON bonif1		TAG bonif1 		ASCENDING ADDITIVE
INDEX ON bonif2		TAG bonif2		ASCENDING ADDITIVE
INDEX ON bonif3		TAG bonif3		ASCENDING ADDITIVE
INDEX ON bonif4 	TAG bonif4		ASCENDING ADDITIVE
INDEX ON costoRep	TAG costoRep	ASCENDING ADDITIVE
INDEX ON margenMax	TAG margenMax	ASCENDING ADDITIVE
INDEX ON margenMin 	TAG margenMin	ASCENDING ADDITIVE
INDEX ON prventaMax	TAG prventaMax	ASCENDING ADDITIVE
INDEX ON prventaMin TAG prventaMin 	ASCENDING ADDITIVE
INDEX ON prfinalMax	TAG prfinalMax	ASCENDING ADDITIVE
INDEX ON prfinalMin TAG prfinalMin	ASCENDING ADDITIVE
INDEX ON codArt 	TAG codArt 		ASCENDING ADDITIVE


SELECT cur_Artic
IF RECCOUNT() > 0
	GO TOP
	thisform.contenido.txtprVtaMay.Value = cur_Artic.prventaMax
	thisform.contenido.txtprFinalMin.Value = cur_Artic.prfinalMin
	thisform.contenido.txtprFinalMay.value = cur_Artic.prfinalMax
	thisform.contenido.txtPrVtaMin.Value = cur_Artic.prventaMin
	thisform.contenido.txtAlicIVA.Value = cur_Artic.alicIVA
	thisform.contenido.txtListaProv.Value = cur_Artic.prLista
	thisform.contenido.txtBonif1.Value = cur_Artic.bonif1
	thisform.contenido.txtBonif2.Value = cur_Artic.bonif2
	thisform.contenido.txtBonif3.Value = cur_Artic.bonif3
	thisform.contenido.txtBonif4.Value = cur_Artic.bonif4
	thisform.contenido.txtCostoRep.Value = cur_Artic.costoRep
	thisform.contenido.txtMargenMay.value = cur_Artic.margenMax
	Thisform.contenido.txtMargenMin.Value = cur_Artic.MargenMin

	thisform.contenido.txtCostoConIVA.Value = ROUND(cur_Artic.CostoRep + (cur_Artic.CostoRep * (thisform.contenido.txtAlicIVA.Value / 100)), 2)
	thisform.contenido.picFoto.Picture = IIF(ISNULL(cur_Artic.linkfoto), "", cur_Artic.linkfoto)
ENDIF

SELECT cur_Artic
IF RECCOUNT("cur_Artic") > 0 THEN
	GO lnPosActual

	thisform.contenido.txtprVtaMay.Value = cur_Artic.prventaMax
	thisform.contenido.txtprFinalMin.Value = cur_Artic.prfinalMin
	thisform.contenido.txtprFinalMay.value = cur_Artic.prfinalMax
	thisform.contenido.txtPrVtaMin.Value = cur_Artic.prventaMin
	thisform.contenido.txtAlicIVA.Value = cur_Artic.alicIVA
	thisform.contenido.txtListaProv.Value = cur_Artic.prLista
	thisform.contenido.txtBonif1.Value = cur_Artic.bonif1
	thisform.contenido.txtBonif2.Value = cur_Artic.bonif2
	thisform.contenido.txtBonif3.Value = cur_Artic.bonif3
	thisform.contenido.txtBonif4.Value = cur_Artic.bonif4
	thisform.contenido.txtCostoRep.Value = cur_Artic.costoRep
	thisform.contenido.txtMargenMay.value = cur_Artic.margenMax
	Thisform.contenido.txtMargenMin.Value = cur_Artic.MargenMin

	thisform.contenido.txtCostoConIVA.Value = ROUND(cur_Artic.CostoRep + (cur_Artic.CostoRep * (thisform.contenido.txtAlicIVA.Value / 100)), 2)
	thisform.contenido.picFoto.Picture = IIF(ISNULL(cur_Artic.linkfoto), "", cur_Artic.linkfoto)
	thisform.contenido.txtExistencia.Value = thisform.mov_stock.get_exist_byart(cur_Artic.idArticulo)	
ENDIF

Thisform.contenido.grdArtic.Refresh()

ENDPROC


************************************************************
OBJETO: btnMostrarPrecios
************************************************************
*** PROPIEDADES ***
Top = 469
Left = 257
Height = 36
Width = 139
Anchor = 6
Caption = "\<Todos los precios"
Name = "btnMostrarPrecios"

*** METODOS ***
PROCEDURE Click
DO FORM "frmVerTodosPr"

ENDPROC


************************************************************
OBJETO: btnEquivalencias
************************************************************
*** PROPIEDADES ***
Top = 469
Left = 403
Height = 36
Width = 139
Anchor = 6
Caption = "\<Equivalencias"
Name = "btnEquivalencias"

*** METODOS ***
PROCEDURE Click
LOCAL loForm

loForm = CREATEOBJECT("cls_equiv_viewer")
loForm.idArticulo = cur_Artic.idArticulo
loForm.codArt = cur_Artic.codArt
loForm.descripcio = cur_Artic.descripcio
loForm.cons_mostrador = .F.
loForm.leer_equivs()

loForm.hide()
loForm.show(1)

ENDPROC


************************************************************
OBJETO: Clsetiqueta14
************************************************************
*** PROPIEDADES ***
Anchor = 36
Caption = "Ultima actualización:"
Height = 15
Left = 473
Top = 420
Width = 115
Name = "Clsetiqueta14"

*** METODOS ***


************************************************************
OBJETO: txtUltimaActualizacion
************************************************************
*** PROPIEDADES ***
Anchor = 36
Height = 21
Left = 599
ReadOnly = .T.
Top = 415
Width = 110
isdatetime = .T.
Name = "txtUltimaActualizacion"

*** METODOS ***


************************************************************
OBJETO: cl_form_consart
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_form_faltbycli
************************************************************
*** PROPIEDADES ***
Height = 160
Width = 600
DoCreate = .T.
BorderStyle = 2
Caption = "Listado de faltantes por clientes"
Name = "cls_form_faltbycli"
contenido.Name = "contenido"

*** METODOS ***
PROCEDURE Load
DODEFAULT()

CREATE CURSOR cur_faltantes (	;
	idCliente	int,;
	razSocCL	varchar(60),;
	codArt		varchar(20),;
	descripcio	varchar(100),;
	idOcCab		int null,;
	idProv		int null,;
	razSocPV	varchar(60) null,;
	fecha		datetime null,;
	cantidad	float(10, 2))
	

ENDPROC
PROCEDURE Init
Thisform.contenido.txtFechaDD.Value = CTOD("01/" + ALLTRIM(STR(MONTH(DATE()))) + "/" + ALLTRIM(STR(YEAR(DATE()))))
Thisform.contenido.txtFecHaHH.Value = DATE() + 1
ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Cliente desde:"
Left = 24
Top = 41
TabIndex = 7
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Cliente hasta:"
Left = 24
Top = 65
TabIndex = 8
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: sel_clienteDD
************************************************************
*** PROPIEDADES ***
Top = 35
Left = 114
TabIndex = 2
nombre_campo_codigo = idCliente
nombre_campo_desc = razSoc
nombre_tabla = clientes
pkfield = idCliente
title_cols = Razón Social
esnumerico = .T.
Name = "sel_clienteDD"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: sel_clienteHH
************************************************************
*** PROPIEDADES ***
Top = 59
Left = 114
TabIndex = 3
esnumerico = .T.
nombre_campo_codigo = idCliente
nombre_campo_desc = razSoc
nombre_tabla = clientes
pkfield = idCliente
title_cols = Razón Social
Name = "sel_clienteHH"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: btnImprimir
************************************************************
*** PROPIEDADES ***
Top = 103
Left = 501
TabIndex = 6
Name = "btnImprimir"

*** METODOS ***
PROCEDURE Click
LOCAL loRes, lcSql
LOCAL lnIdClienteDD, lnIdClienteHH, lnIdArticulo
LOCAL m.clienteDD, m.clienteHH, m.fechaDD, m.fechaHH, m.articulo
LOCAL loDT
loDT = CREATEOBJECT("datetime")
loRes = CREATEOBJECT("odbc_result")
lcSql = ""

* Obtener valores de los controles
lnIdClienteDD = Thisform.Contenido.sel_clienteDD.valcpoid
lnIdClienteHH = Thisform.Contenido.sel_clienteHH.valcpoid
lnIdArticulo = 0  && Inicializar variable para artículo

lnIdArticulo = Thisform.Contenido.sel_articulo.valcpoid

m.fechaDD = Thisform.Contenido.txtFechaDD.Value
m.fechaHH = Thisform.Contenido.txtFechaHH.Value

* Construir la consulta SQL base
lcSql = "SELECT "
lcSql = lcSql + "clientes.idCliente, "
lcSql = lcSql + "clientes.razSoc AS razSocCL, "
lcSql = lcSql + "faltantes.codArt, "
lcSql = lcSql + "articulos.descripcio, "
lcSql = lcSql + "occab.idOcCab, "
lcSql = lcSql + "proveedor.idProv, "
lcSql = lcSql + "proveedor.razSoc AS razSocPV, "
lcSql = lcSql + "faltantes.fecAlta AS fecha, "
lcSql = lcSql + "faltantes.cantidad "
lcSql = lcSql + "FROM faltantes "
lcSql = lcSql + "	LEFT JOIN clientes ON clientes.idCliente = faltantes.idCliente "
lcSql = lcSql + "	LEFT JOIN occab ON occab.idOcCab = faltantes.idOcCab "
lcSql = lcSql + "	LEFT JOIN proveedor ON proveedor.idProv = occab.idprov "
lcSql = lcSql + "	INNER JOIN articulos ON articulos.idArticulo = faltantes.idArticulo "
lcSql = lcSql + "WHERE faltantes.fecBaja IS NULL "

* Filtro por rango de clientes
IF lnIdClienteDD <> 0 .AND. lnIdClienteHH <> 0 THEN
	lcSql = lcSql + " AND clientes.idCliente BETWEEN " + ALLTRIM(STR(lnIdClienteDD)) + " AND " + ALLTRIM(STR(lnIdClienteHH)) + " "
	m.clienteDD = ALLTRIM(STR(Thisform.Contenido.sel_clienteDD.txtCodigo.Value)) + " - " + ALLTRIM(Thisform.Contenido.sel_clienteDD.txtDescripcion.Value)
	m.clienteHH = ALLTRIM(STR(Thisform.Contenido.sel_clienteHH.txtCodigo.Value)) + " - " + ALLTRIM(Thisform.Contenido.sel_clienteHH.txtDescripcion.Value)
ELSE
	m.clienteDD = "[TODOS]"
	m.clienteHH = "[TODOS]"
ENDIF

* Filtro por artículo específico
IF lnIdArticulo <> 0 THEN
	lcSql = lcSql + " AND faltantes.idArticulo = " + ALLTRIM(STR(lnIdArticulo)) + " "
	m.articulo = ALLTRIM(Thisform.Contenido.sel_articulo.TXTCODIGO.Value)
ELSE
	m.articulo = "[TODOS]"
ENDIF

* Filtro por fechas
IF INT(VAL(getConfig("SQLSRV"))) = 1 THEN
	lcSql = lcSql + " AND CONVERT(char(8), faltantes.fecAlta, 112) BETWEEN " + loDT.toMySql(Thisform.Contenido.txtFechaDD.Value) + " AND " + loDT.toMySql(Thisform.Contenido.txtFechaHH.Value) + " "
ELSE
	lcSql = lcSql + " AND faltantes.fecAlta >= " + loDT.toMySql(Thisform.Contenido.txtFechaDD.Value ) + " "
	lcSql = lcSql + " AND faltantes.fecAlta <= " + loDT.toMySql(Thisform.Contenido.txtFechaHH.Value) + " "
ENDIF

lcSql = lcSql + "ORDER BY faltantes.idCliente, faltantes.procesado DESC"

* Ejecutar consulta
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"
IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

* Procesar resultados
SELECT cur_faltantes
ZAP
SELECT cur_x
IF RECCOUNT("cur_x") > 0 THEN
	GO TOP
ELSE
	MESSAGEBOX("No hay registros para mostrar", 0+64, Thisform.Caption)
	loRes.Close_Query()
	RETURN .F.
ENDIF

DO WHILE !EOF("cur_x")
	SELECT cur_faltantes
	APPEND BLANK
	REPLACE cur_faltantes.idCliente WITH cur_x.idCliente
	REPLACE cur_faltantes.razSocCL WITH cur_x.razSocCL ADDITIVE
	REPLACE cur_faltantes.codArt WITH ALLTRIM(cur_x.codArt) ADDITIVE
	REPLACE cur_faltantes.descripcio WITH ALLTRIM(cur_x.descripcio) ADDITIVE
	REPLACE cur_faltantes.idOcCab WITH cur_x.idOcCab ADDITIVE
	REPLACE cur_faltantes.idProv WITH cur_x.idProv ADDITIVE
	REPLACE cur_faltantes.razSocPV WITH cur_x.razSocPV ADDITIVE
	REPLACE cur_faltantes.fecha WITH cur_x.fecha ADDITIVE
	REPLACE cur_faltantes.cantidad WITH cur_x.cantidad ADDITIVE
	SELECT cur_x
	SKIP
ENDDO

loRes.Close_Query()
SELECT cur_faltantes
REPORT FORM "rep-faltbycli" PREVIEW
RETURN .T.
ENDPROC


************************************************************
OBJETO: btnSalir
************************************************************
*** PROPIEDADES ***
Top = 103
Left = 549
TabIndex = 7
Name = "btnSalir"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Fecha desde:"
Left = 25
Top = 89
TabIndex = 9
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: txtFechaDD
************************************************************
*** PROPIEDADES ***
Left = 116
TabIndex = 4
Top = 85
isdatetime = .T.
Name = "txtFechaDD"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Fecha hasta:"
Left = 221
Top = 89
TabIndex = 10
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: txtFechaHH
************************************************************
*** PROPIEDADES ***
Left = 303
TabIndex = 5
Top = 85
isdatetime = .T.
Name = "txtFechaHH"

*** METODOS ***


************************************************************
OBJETO: sel_articulo
************************************************************
*** PROPIEDADES ***
Top = 11
Left = 114
Width = 487
Height = 24
TabIndex = 1
nombre_campo_codigo = codArt
nombre_campo_desc = descripcio
nombre_tabla = articulos
pkfield = idArticulo
Name = "sel_articulo"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Artículo:"
Left = 24
Top = 17
TabIndex = 7
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: cls_form_faltbycli
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


