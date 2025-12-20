************************************************************
OBJETO: abm_depositos
************************************************************
*** PROPIEDADES ***
DoCreate = .T.
Caption = "Depósitos"
cnombretabla = stk_deps
listctrlsource = idStkDep,descripcio
listwidthcols = 70,300
pk_fieldname = idStkDep
titulos_cabeceras = #,Descripción
Name = "abm_depositos"
HERRAMIENTAS.CMDNUEVO.Name = "CMDNUEVO"
HERRAMIENTAS.CMDEDITAR.Name = "CMDEDITAR"
HERRAMIENTAS.CMDELIMINAR.Name = "CMDELIMINAR"
HERRAMIENTAS.CMDCERRAR.Name = "CMDCERRAR"
HERRAMIENTAS.CMDGRABAR.Name = "CMDGRABAR"
HERRAMIENTAS.CMDCANCELAR.Name = "CMDCANCELAR"
HERRAMIENTAS.Name = "HERRAMIENTAS"
PGF.ErasePage = .T.
PGF.Page1.GRDDATOS.COLUMN1.HEADER1.Name = "HEADER1"
PGF.Page1.GRDDATOS.COLUMN1.Text1.Name = "Text1"
PGF.Page1.GRDDATOS.COLUMN1.Name = "COLUMN1"
PGF.Page1.GRDDATOS.COLUMN2.HEADER1.Name = "HEADER1"
PGF.Page1.GRDDATOS.COLUMN2.Text1.Name = "Text1"
PGF.Page1.GRDDATOS.COLUMN2.Name = "COLUMN2"
PGF.Page1.GRDDATOS.COLUMN3.HEADER1.Name = "HEADER1"
PGF.Page1.GRDDATOS.COLUMN3.Text1.Name = "Text1"
PGF.Page1.GRDDATOS.COLUMN3.Name = "COLUMN3"
PGF.Page1.GRDDATOS.COLUMN4.HEADER1.Name = "HEADER1"
PGF.Page1.GRDDATOS.COLUMN4.Text1.Name = "Text1"
PGF.Page1.GRDDATOS.COLUMN4.Name = "COLUMN4"
PGF.Page1.GRDDATOS.COLUMN5.HEADER1.Name = "HEADER1"
PGF.Page1.GRDDATOS.COLUMN5.Text1.Name = "Text1"
PGF.Page1.GRDDATOS.COLUMN5.Name = "COLUMN5"
PGF.Page1.GRDDATOS.COLUMN6.HEADER1.Name = "HEADER1"
PGF.Page1.GRDDATOS.COLUMN6.Text1.Name = "Text1"
PGF.Page1.GRDDATOS.COLUMN6.Name = "COLUMN6"
PGF.Page1.GRDDATOS.COLUMN7.HEADER1.Name = "HEADER1"
PGF.Page1.GRDDATOS.COLUMN7.Text1.Name = "Text1"
PGF.Page1.GRDDATOS.COLUMN7.Name = "COLUMN7"
PGF.Page1.GRDDATOS.COLUMN8.HEADER1.Name = "HEADER1"
PGF.Page1.GRDDATOS.COLUMN8.Text1.Name = "Text1"
PGF.Page1.GRDDATOS.COLUMN8.Name = "COLUMN8"
PGF.Page1.GRDDATOS.COLUMN9.HEADER1.Name = "HEADER1"
PGF.Page1.GRDDATOS.COLUMN9.Text1.Name = "Text1"
PGF.Page1.GRDDATOS.COLUMN9.Name = "COLUMN9"
PGF.Page1.GRDDATOS.COLUMN10.HEADER1.Name = "HEADER1"
PGF.Page1.GRDDATOS.COLUMN10.Text1.Name = "Text1"
PGF.Page1.GRDDATOS.COLUMN10.Name = "COLUMN10"
PGF.Page1.GRDDATOS.COLUMN11.HEADER1.Name = "HEADER1"
PGF.Page1.GRDDATOS.COLUMN11.Text1.Name = "Text1"
PGF.Page1.GRDDATOS.COLUMN11.Name = "COLUMN11"
PGF.Page1.GRDDATOS.COLUMN12.HEADER1.Name = "HEADER1"
PGF.Page1.GRDDATOS.COLUMN12.Text1.Name = "Text1"
PGF.Page1.GRDDATOS.COLUMN12.Name = "COLUMN12"
PGF.Page1.GRDDATOS.COLUMN13.HEADER1.Name = "HEADER1"
PGF.Page1.GRDDATOS.COLUMN13.Text1.Name = "Text1"
PGF.Page1.GRDDATOS.COLUMN13.Name = "COLUMN13"
PGF.Page1.GRDDATOS.COLUMN14.HEADER1.Name = "HEADER1"
PGF.Page1.GRDDATOS.COLUMN14.Text1.Name = "Text1"
PGF.Page1.GRDDATOS.COLUMN14.Name = "COLUMN14"
PGF.Page1.GRDDATOS.COLUMN15.HEADER1.Name = "HEADER1"
PGF.Page1.GRDDATOS.COLUMN15.Text1.Name = "Text1"
PGF.Page1.GRDDATOS.COLUMN15.Name = "COLUMN15"
PGF.Page1.GRDDATOS.COLUMN16.HEADER1.Name = "HEADER1"
PGF.Page1.GRDDATOS.COLUMN16.Text1.Name = "Text1"
PGF.Page1.GRDDATOS.COLUMN16.Name = "COLUMN16"
PGF.Page1.GRDDATOS.COLUMN17.HEADER1.Name = "HEADER1"
PGF.Page1.GRDDATOS.COLUMN17.Text1.Name = "Text1"
PGF.Page1.GRDDATOS.COLUMN17.Name = "COLUMN17"
PGF.Page1.GRDDATOS.COLUMN18.HEADER1.Name = "HEADER1"
PGF.Page1.GRDDATOS.COLUMN18.Text1.Name = "Text1"
PGF.Page1.GRDDATOS.COLUMN18.Name = "COLUMN18"
PGF.Page1.GRDDATOS.COLUMN19.HEADER1.Name = "HEADER1"
PGF.Page1.GRDDATOS.COLUMN19.Text1.Name = "Text1"
PGF.Page1.GRDDATOS.COLUMN19.Name = "COLUMN19"
PGF.Page1.GRDDATOS.COLUMN20.HEADER1.Name = "HEADER1"
PGF.Page1.GRDDATOS.COLUMN20.Text1.Name = "Text1"
PGF.Page1.GRDDATOS.COLUMN20.Name = "COLUMN20"
PGF.Page1.GRDDATOS.Name = "GRDDATOS"
PGF.Page1.Name = "Page1"
PGF.Page2.CNT_FIELDS.Name = "CNT_FIELDS"
PGF.Page2.Name = "Page2"
PGF.Name = "PGF"

*** METODOS ***


************************************************************
OBJETO: CLSETIQUETA1
************************************************************
*** PROPIEDADES ***
Caption = "Código:"
Left = 36
Top = 30
TabIndex = 3
Name = "CLSETIQUETA1"

*** METODOS ***


************************************************************
OBJETO: CLSETIQUETA2
************************************************************
*** PROPIEDADES ***
Caption = "Descripción:"
Left = 36
Top = 54
TabIndex = 4
Name = "CLSETIQUETA2"

*** METODOS ***


************************************************************
OBJETO: txtCodigo
************************************************************
*** PROPIEDADES ***
Left = 129
TabIndex = 1
Top = 27
cfieldname = codDep
ischaracter = .T.
msgerror = Debe ingresar el código de depósito
Name = "txtCodigo"

*** METODOS ***


************************************************************
OBJETO: txtDescriocion
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 129
TabIndex = 2
Top = 50
Width = 435
msgerror = Debe ingresar la descripción
cfieldname = descripcio
ischaracter = .T.
Name = "txtDescriocion"

*** METODOS ***


************************************************************
OBJETO: abm_depositos
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 13, 11, 11, 2, 0
Arial, 0, 9, 5, 13, 11, 11, 2, 0
Arial, 1, 8, 6, 13, 11, 12, 2, 0

*** METODOS ***


************************************************************
OBJETO: cl_art_sindep_viewer
************************************************************
*** PROPIEDADES ***
DataSession = 1
Height = 308
Width = 643
DoCreate = .T.
BorderStyle = 1
Caption = "Artículos sin depósitos asignados"
Name = "cl_art_sindep_viewer"

*** METODOS ***
PROCEDURE Init
DODEFAULT()

Thisform.lblMensaje.Caption = "La siguiente lista de artículos son aquellos que no se pueden" + CHR(13) + CHR(10) + "generar movimientos de stock debido " + ;
	"a que no tiene depósito asignado, tome nota de estos códigos y dirijase" + CHR(13) + CHR(10) + " a Stock / Asignar artículos por depósito."

SELECT cur_artSD
thisform.grdSD.alias_name = "cur_artSD"
thisform.grdSD.RecordSource = "cur_artSD"
thisform.grdSD.list_controlsource = "codArt,Descripcio"
thisform.grdSD.lista_ancho_cols = "100,300"
thisform.grdSD.titulos_cabeceras = "Código,Descripción"
thisform.grdSD.generar_grid()

ENDPROC


************************************************************
OBJETO: lblMensaje
************************************************************
*** PROPIEDADES ***
Caption = ""
Height = 46
Left = 12
Top = 4
Width = 612
Name = "lblMensaje"

*** METODOS ***


************************************************************
OBJETO: Clslinea1
************************************************************
*** PROPIEDADES ***
Height = 0
Left = 12
Top = 56
Width = 624
Name = "Clslinea1"

*** METODOS ***


************************************************************
OBJETO: grdSD
************************************************************
*** PROPIEDADES ***
Height = 197
Left = 12
Top = 60
Width = 625
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdSD"
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
OBJETO: Clscerrar1
************************************************************
*** PROPIEDADES ***
Top = 261
Left = 593
Name = "Clscerrar1"

*** METODOS ***


************************************************************
OBJETO: cl_art_sindep_viewer
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: cl_busqueda_avanzada
************************************************************
*** PROPIEDADES ***
DataSession = 2
BorderStyle = 2
Height = 285
Width = 665
DoCreate = .T.
Caption = "Búsqueda avanzada"
idprov_dd = 0
idprov_hh = 0
idmarca_dd = 0
idmarca_hh = 0
idfamilia_dd = 0
idfamilia_hh = 0
idsubfam_dd = 0
idsubfam_hh = 0
iddep_dd = 0
iddep_hh = 0
idart_dd = 0
idart_hh = 0
result = 0
Name = "cl_busqueda_avanzada"

*** METODOS ***


************************************************************
OBJETO: CLSETIQUETA1
************************************************************
*** PROPIEDADES ***
Caption = "Proveedor Desde:"
Height = 15
Left = 12
Top = 8
Width = 112
TabIndex = 17
Name = "CLSETIQUETA1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Proveedor Hasta:"
Height = 15
Left = 12
Top = 30
Width = 111
TabIndex = 18
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Familia Desde:"
Height = 15
Left = 12
Top = 99
Width = 113
TabIndex = 19
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Familia Hasta:"
Height = 15
Left = 12
Top = 122
Width = 111
TabIndex = 20
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Sub-Familia Desde:"
Height = 15
Left = 12
Top = 145
Width = 111
TabIndex = 21
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta6
************************************************************
*** PROPIEDADES ***
Caption = "Sub-Familia Hasta:"
Height = 15
Left = 12
Top = 168
Width = 109
TabIndex = 22
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: selProvDD
************************************************************
*** PROPIEDADES ***
Top = 2
Left = 124
Width = 484
Height = 25
TabIndex = 1
autocompletar_ceros = .F.
esnumerico = .T.
nombre_campo_codigo = idProv
nombre_campo_desc = razSoc
nombre_tabla = proveedor
pkfield = idProv
Name = "selProvDD"
TXTCODIGO.Name = "TXTCODIGO"
TXTDESCRIPCION.Name = "TXTDESCRIPCION"

*** METODOS ***


************************************************************
OBJETO: sel_ProvHH
************************************************************
*** PROPIEDADES ***
Top = 25
Left = 124
Width = 483
Height = 25
TabIndex = 2
autocompletar_ceros = .F.
esnumerico = .T.
nombre_campo_codigo = idProv
nombre_campo_desc = razSoc
nombre_tabla = proveedor
pkfield = idProv
Name = "sel_ProvHH"
TXTCODIGO.Name = "TXTCODIGO"
TXTDESCRIPCION.Name = "TXTDESCRIPCION"

*** METODOS ***


************************************************************
OBJETO: sel_FamiliaDD
************************************************************
*** PROPIEDADES ***
Top = 94
Left = 124
Width = 484
Height = 25
TabIndex = 5
WhatsThisHelpID = -1
esnumerico = .T.
autocompletar_ceros = .F.
nombre_campo_codigo = idFamilia
nombre_campo_desc = descripcio
nombre_tabla = familias
pkfield = idFamilia
Name = "sel_FamiliaDD"
TXTCODIGO.Name = "TXTCODIGO"
TXTDESCRIPCION.Name = "TXTDESCRIPCION"

*** METODOS ***


************************************************************
OBJETO: sel_FamiliaHH
************************************************************
*** PROPIEDADES ***
Top = 117
Left = 124
Width = 484
Height = 25
TabIndex = 6
autocompletar_ceros = .F.
esnumerico = .T.
nombre_campo_codigo = idFamilia
nombre_campo_desc = descripcio
nombre_tabla = familias
pkfield = idFamilia
Name = "sel_FamiliaHH"
TXTCODIGO.Name = "TXTCODIGO"
TXTDESCRIPCION.Name = "TXTDESCRIPCION"

*** METODOS ***


************************************************************
OBJETO: sel_SubFamDD
************************************************************
*** PROPIEDADES ***
Top = 140
Left = 124
Width = 485
Height = 25
TabIndex = 7
autocompletar_ceros = .F.
esnumerico = .T.
nombre_campo_codigo = idSubFam
nombre_campo_desc = descripcio
nombre_tabla = subfam
pkfield = idSubFam
Name = "sel_SubFamDD"
TXTCODIGO.Name = "TXTCODIGO"
TXTDESCRIPCION.Name = "TXTDESCRIPCION"

*** METODOS ***


************************************************************
OBJETO: sel_SubFamHH
************************************************************
*** PROPIEDADES ***
Top = 163
Left = 124
Width = 485
Height = 25
TabIndex = 8
autocompletar_ceros = .F.
esnumerico = .T.
nombre_campo_codigo = idSubFam
nombre_campo_desc = descripcio
nombre_tabla = subfam
pkfield = idSubFam
Name = "sel_SubFamHH"
TXTCODIGO.Name = "TXTCODIGO"
TXTDESCRIPCION.Name = "TXTDESCRIPCION"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta11
************************************************************
*** PROPIEDADES ***
Caption = "Marca Desde:"
Height = 15
Left = 12
Top = 53
Width = 111
TabIndex = 29
Name = "Clsetiqueta11"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta12
************************************************************
*** PROPIEDADES ***
Caption = "Marca Hasta:"
Height = 15
Left = 12
Top = 76
Width = 109
TabIndex = 30
Name = "Clsetiqueta12"

*** METODOS ***


************************************************************
OBJETO: sel_MarcaDD
************************************************************
*** PROPIEDADES ***
Top = 48
Left = 124
Width = 485
Height = 25
TabIndex = 3
esnumerico = .T.
autocompletar_ceros = .F.
nombre_campo_codigo = idMarca
nombre_campo_desc = descripcio
nombre_tabla = marcas
pkfield = idMarca
Name = "sel_MarcaDD"
TXTCODIGO.Name = "TXTCODIGO"
TXTDESCRIPCION.Name = "TXTDESCRIPCION"

*** METODOS ***


************************************************************
OBJETO: sel_MarcaHH
************************************************************
*** PROPIEDADES ***
Top = 71
Left = 124
Width = 485
Height = 25
TabIndex = 4
autocompletar_ceros = .F.
esnumerico = .T.
nombre_campo_codigo = idMarca
nombre_campo_desc = descripcio
nombre_tabla = marcas
pkfield = idMarca
Name = "sel_MarcaHH"
TXTCODIGO.Name = "TXTCODIGO"
TXTDESCRIPCION.Name = "TXTDESCRIPCION"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta13
************************************************************
*** PROPIEDADES ***
Caption = "Artículo Desde:"
Height = 15
Left = 12
Top = 191
Width = 111
TabIndex = 25
Name = "Clsetiqueta13"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta14
************************************************************
*** PROPIEDADES ***
Caption = "Artículo Hasta:"
Height = 15
Left = 12
Top = 214
Width = 109
TabIndex = 27
Name = "Clsetiqueta14"

*** METODOS ***


************************************************************
OBJETO: sel_ArticuloDD
************************************************************
*** PROPIEDADES ***
Top = 186
Left = 124
Width = 533
Height = 25
TabIndex = 11
esnumerico = .F.
autocompletar_ceros = .F.
nombre_campo_codigo = codArt
nombre_campo_desc = descripcio
nombre_tabla = articulos
pkfield = idArticulo
Name = "sel_ArticuloDD"
TXTCODIGO.Width = 150
TXTCODIGO.Name = "TXTCODIGO"
TXTDESCRIPCION.Left = 156
TXTDESCRIPCION.Top = 2
TXTDESCRIPCION.Name = "TXTDESCRIPCION"

*** METODOS ***


************************************************************
OBJETO: sel_ArticuloHH
************************************************************
*** PROPIEDADES ***
Top = 209
Left = 124
Width = 532
Height = 25
TabIndex = 12
autocompletar_ceros = .F.
esnumerico = .F.
nombre_campo_codigo = codArt
nombre_campo_desc = descripcio
nombre_tabla = articulos
pkfield = idArticulo
Name = "sel_ArticuloHH"
TXTCODIGO.Width = 150
TXTCODIGO.Name = "TXTCODIGO"
TXTDESCRIPCION.Left = 156
TXTDESCRIPCION.Top = 2
TXTDESCRIPCION.Name = "TXTDESCRIPCION"

*** METODOS ***


************************************************************
OBJETO: btnAceptar
************************************************************
*** PROPIEDADES ***
Top = 237
Left = 562
Height = 44
Width = 45
Name = "btnAceptar"

*** METODOS ***
PROCEDURE Click
Thisform.idprov_dd = Thisform.selProvDD.valcpoid
Thisform.idprov_hh = Thisform.sel_ProvHH.valcpoid
Thisform.idmarca_dd = Thisform.sel_MarcaDD.valcpoid
Thisform.idmarca_hh = Thisform.sel_MarcaHH.valcpoid
Thisform.idfamilia_dd = Thisform.sel_FamiliaDD.valcpoid
Thisform.idfamilia_hh = Thisform.sel_FamiliaHH.valcpoid
Thisform.idsubfam_dd = Thisform.sel_subfamDD.valcpoid
Thisform.idsubfam_hh = Thisform.sel_subfamHH.valcpoid
Thisform.idart_dd = Thisform.sel_ArticuloDD.valcpoid
Thisform.idart_hh = Thisform.sel_ArticuloHH.valcpoid

Thisform.result = 1
Thisform.Hide()
ENDPROC


************************************************************
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 237
Left = 609
Height = 44
Width = 45
Name = "btnCerrar"

*** METODOS ***
PROCEDURE Click
Thisform.result = 0
Thisform.Hide()
ENDPROC


************************************************************
OBJETO: cl_busqueda_avanzada
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: cl_busca_remito
************************************************************
*** PROPIEDADES ***
Height = 392
Width = 700
DoCreate = .T.
Caption = "Control Físico de Mercadería - Búsqueda de Remitos"
list_cbtes = 
Name = "cl_busca_remito"

*** METODOS ***
PROCEDURE cargar_combos
&& Cargo los combobox de cbte y tipo de acuerdo a los comprobante seteados en la propiedad list_cbtes

LOCAL lc_cbtes, ln, lc_cantcbtes, ln_cargoAB
DIMENSION la_vector[10]

lc_cbtes = thisform.list_cbtes
lc_cantcbtes = ALINES(la_vector,lc_cbtes,5,",")
ln_cargoAB = 0

Thisform.contenedor1.cmbTipo.AddItem("Todos")

FOR ln=1 TO lc_cantcbtes 
	IF ln == 1 THEN 
		IF lc_cantcbtes > 1
			Thisform.contenedor1.cmbCbte.AddItem("Todos")
		ENDIF 
	ENDIF 
	
	Thisform.contenedor1.cmbCbte.AddItem(STRTRAN(la_vector(ln),"'",""))
	
	IF STRTRAN(la_vector(ln),"'","") == "FC"
		IF ln_cargoAB = 0 THEN 
			Thisform.contenedor1.cmbTipo.AddItem("A")
			Thisform.contenedor1.cmbTipo.AddItem("B")
			ln_cargoAB = 1
		ENDIF 
	ELSE 
		IF STRTRAN(la_vector(ln),"'","") == "RTO"
			Thisform.contenedor1.cmbTipo.AddItem("X")
			Thisform.contenedor1.cmbTipo.AddItem("Z")
		ENDIF 
	ENDIF 
ENDFOR 

Thisform.contenedor1.cmbCbte.ListIndex = 1
Thisform.contenedor1.cmbTipo.ListIndex = 1
ENDPROC
PROCEDURE buscar
LOCAL lcFecDesde, lcFecHasta, lcCbte, lcTipo, lcNumero

loDateTime = CREATEOBJECT("datetime")
lcFecDesde = loDateTime.toMySql(thisform.contenedor1.txtFecDesde.Value)
lcFecHasta = loDateTime.toMySql(thisform.contenedor1.txtFecHasta.Value)
lcCbte = ALLTRIM(thisform.contenedor1.cmbCBTE.Value)
lcTipo = ALLTRIM(thisform.contenedor1.cmbTIPO.Value)
lcNumero = ALLTRIM(thisform.contenedor1.txtptoVTA.Value) + "-" + ALLTRIM(thisform.contenedor1.txtnuMERO.Value)

Thisform.Contenedor1.oCtrlFisico.buscar_rtos(lcFecDesde, lcFecHasta, lcCbte, lcTipo, lcNumero, thisform.list_cbtes)

thisform.contenedor1.grdRTOS.Refresh()

ENDPROC
PROCEDURE Init
DODEFAULT()

thisform.contenedor1.txtFecDesde.Value = DATE() - 30
thisform.contenedor1.txtFecHasta.Value = DATE()
thisform.contenedor1.txtptovta.Value = "0000"
thisform.contenedor1.txtnumero.Value = "00000000"

thisform.cargar_combos()

Thisform.contenedor1.oCtrlFisico.crear_cursor()

SELECT cur_busq_rtos
Thisform.contenedor1.grdRtos.RecordSource = "cur_busq_rtos"
Thisform.contenedor1.grdRtos.list_controlsource = "idIngcab,idProv,cbte,tipo,numero,fecha"
Thisform.contenedor1.grdRtos.lista_ancho_cols = "80,80,50,70,100,150"
Thisform.contenedor1.grdRtos.titulos_cabeceras = "N. Ingreso,Proveedor,Cbte,Tipo,Número,Fecha"
Thisform.contenedor1.grdRtos.generar_grid()
Thisform.contenedor1.grdRtos.Refresh()
ENDPROC


************************************************************
OBJETO: Contenedor1
************************************************************
*** PROPIEDADES ***
Top = 1
Left = 1
Width = 697
Height = 390
BackColor = 241,236,235
Name = "Contenedor1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Fecha Desde:"
Height = 15
Left = 9
Top = 15
Width = 84
TabIndex = 15
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Fecha Hasta:"
Height = 15
Left = 208
Top = 15
Width = 84
TabIndex = 16
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: txtFecDesde
************************************************************
*** PROPIEDADES ***
Left = 99
TabIndex = 1
Top = 11
isdatetime = .T.
Name = "txtFecDesde"

*** METODOS ***


************************************************************
OBJETO: txtFecHasta
************************************************************
*** PROPIEDADES ***
Left = 285
TabIndex = 2
Top = 11
isdatetime = .T.
Name = "txtFecHasta"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Comprobante:"
Height = 15
Left = 9
Top = 42
Width = 84
TabIndex = 14
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: txtptovta
************************************************************
*** PROPIEDADES ***
Alignment = 3
Value = 
Height = 21
Left = 209
MaxLength = 4
TabIndex = 5
Top = 39
Width = 45
autocompleta = .T.
ischaracter = .T.
Name = "txtptovta"

*** METODOS ***


************************************************************
OBJETO: cmbCbte
************************************************************
*** PROPIEDADES ***
Height = 24
Left = 99
TabIndex = 3
Top = 38
Width = 59
cfieldname = 
Name = "cmbCbte"

*** METODOS ***


************************************************************
OBJETO: cmbTipo
************************************************************
*** PROPIEDADES ***
Height = 24
Left = 161
TabIndex = 4
Top = 38
Width = 44
Name = "cmbTipo"

*** METODOS ***


************************************************************
OBJETO: txtnumero
************************************************************
*** PROPIEDADES ***
Alignment = 3
Value = 
Height = 21
Left = 257
MaxLength = 8
TabIndex = 6
Top = 39
Width = 90
ischaracter = .T.
autocompleta = .T.
Name = "txtnumero"

*** METODOS ***


************************************************************
OBJETO: grdRtos
************************************************************
*** PROPIEDADES ***
Height = 266
Left = 7
TabIndex = 8
Top = 69
Width = 688
Name = "grdRtos"
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

SELECT cur_busq_rtos
IF RECCOUNT("cur_busq_rtos") > 0 THEN 

	loForm = CREATEOBJECT("cltr_fisico")

	loForm.numingreso = cur_busq_rtos.idIngcab
	loForm.recuperardatos()
	loForm.hide()
	loForm.Show(1)

	thisform.buscar()
ELSE 
	MESSAGEBOX("Debe seleccionar un remito",0+48,thisform.Caption)
ENDIF 


ENDPROC


************************************************************
OBJETO: btnAceptar
************************************************************
*** PROPIEDADES ***
Top = 340
Left = 603
TabIndex = 9
Name = "btnAceptar"

*** METODOS ***
PROCEDURE Click
LOCAL loForm

SELECT cur_busq_rtos
IF RECCOUNT("cur_busq_rtos") > 0 THEN 

	loForm = CREATEOBJECT("cltr_fisico")

	loForm.numingreso = cur_busq_rtos.idIngcab
	loForm.idProv = cur_busq_rtos.idProv
	loForm.recuperardatos()
	loForm.hide()
	loForm.Show(1)

	thisform.buscar()
ELSE 
	MESSAGEBOX("Debe seleccionar un remito",0+48,thisform.Caption)
ENDIF 


ENDPROC


************************************************************
OBJETO: btnSalir
************************************************************
*** PROPIEDADES ***
Top = 340
Left = 649
TabIndex = 10
Name = "btnSalir"

*** METODOS ***


************************************************************
OBJETO: btnBuscar
************************************************************
*** PROPIEDADES ***
Top = 23
Left = 649
TabIndex = 7
Name = "btnBuscar"

*** METODOS ***
PROCEDURE Click
thisform.buscar()
ENDPROC


************************************************************
OBJETO: oCtrlFisico
************************************************************
*** PROPIEDADES ***
Top = 347
Left = 35
Height = 13
Width = 36
Name = "oCtrlFisico"

*** METODOS ***


************************************************************
OBJETO: cl_busca_remito
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: env_mercaderias
************************************************************
*** PROPIEDADES ***
Height = 505
Width = 948
DoCreate = .T.
Caption = "Envío de Mercadería a Mostrador"
MaxButton = .T.
MinButton = .T.
MinHeight = 500
MinWidth = 400
WindowState = 2
Name = "env_mercaderias"
contenido.Top = -1
contenido.Left = 0
contenido.Width = 950
contenido.Height = 574
contenido.Name = "contenido"

*** METODOS ***
PROCEDURE Init
DODEFAULT()
Thisform.oEnvMerc.crear_cursor()
Thisform.Contenido.grdArticulos.RecordSource = "cur_ptos"
Thisform.Contenido.grdArticulos.alias_name = "cur_ptos"
Thisform.Contenido.grdArticulos.List_controlsource = "fecPed,cpte,tipo,numero,nroPed,codArt,descripcio,nroPart,cantidad"
Thisform.Contenido.grdArticulos.lista_ancho_cols = "120,70,70,100,100,150,300,150,70"
Thisform.Contenido.grdArticulos.titulos_cabeceras = "Fecha,Comp.,Tipo,Número,Pedido,Código,Descripción,Partida,Cantidad"
Thisform.Contenido.grdArticulos.generar_grid()

Thisform.oEnvMerc.leer_ptos()
Thisform.Contenido.grdArticulos.SetAll("DynamicBackColor", "iif(cur_ptos.idArticulo <> 0, RGB(255,255,255), RGB(255,205,155))", "Column")
Thisform.Contenido.grdArticulos.Refresh()

ENDPROC


************************************************************
OBJETO: oEnvMerc
************************************************************
*** PROPIEDADES ***
Top = 480
Left = 24
Height = 17
Width = 24
Name = "oEnvMerc"

*** METODOS ***


************************************************************
OBJETO: grdArticulos
************************************************************
*** PROPIEDADES ***
Anchor = 15
Height = 445
Left = 6
Top = 4
Width = 939
permitir_busqueda = .F.
permitir_ordenamiento = .F.
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
OBJETO: btnGrabar
************************************************************
*** PROPIEDADES ***
Top = 458
Left = 853
Anchor = 12
TabIndex = 3
Name = "btnGrabar"

*** METODOS ***
PROCEDURE Click
IF !Thisform.oEnvMerc.grabar(1) THEN
	MESSAGEBOX("Hubo un error al intentar generar el remito", 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

Thisform.oEnvMerc.limpiar()
MESSAGEBOX("El remito ha sido generado con éxito", 0+64, Thisform.Caption)
RETURN .T.

ENDPROC


************************************************************
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 458
Left = 899
Anchor = 12
TabIndex = 4
Name = "btnCerrar"

*** METODOS ***


************************************************************
OBJETO: btnRefrescar
************************************************************
*** PROPIEDADES ***
Top = 458
Left = 807
Anchor = 12
TabIndex = 2
Name = "btnRefrescar"

*** METODOS ***
PROCEDURE Click
Thisform.oEnvMerc.leer_ptos()
Thisform.Contenido.grdArticulos.Refresh()
ENDPROC


************************************************************
OBJETO: env_mercaderias
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cl_cons_ing
************************************************************
*** PROPIEDADES ***
Height = 600
Width = 800
DoCreate = .T.
Caption = "Consulta de Ingresos de Mercadería"
WindowType = 0
list_cbtes = 
Name = "cl_cons_ing"

*** METODOS ***
PROCEDURE buscar
LOCAL lcFecDesde, lcFecHasta, lcCbte, lcTipo, lcNumero, lnProvDesde, lnProvHasta

loDateTime = CREATEOBJECT("datetime")
lcFecDesde = loDateTime.toMySql(thisform.contenedor1.txtFecDesde.Value)
lcFecHasta = loDateTime.toMySql(thisform.contenedor1.txtFecHasta.Value)
lnProvDesde = Thisform.contenedor1.sel_prov_desde.valcpoid
lnProvHasta = Thisform.contenedor1.sel_prov_hasta.valcpoid
lcCbte = ALLTRIM(thisform.contenedor1.cmbCBTE.Value)
lcTipo = ALLTRIM(thisform.contenedor1.cmbTIPO.Value)
lcNumero = ALLTRIM(thisform.contenedor1.txtptoVTA.Value) + "-" + ALLTRIM(thisform.contenedor1.txtnuMERO.Value)

Thisform.Contenedor1.oIngMerc.buscar_rtos(lcFecDesde, lcFecHasta, lnProvDesde, lnProvHasta, lcCbte, lcTipo, lcNumero, thisform.list_cbtes)

thisform.contenedor1.grdRTOS.Refresh()

SELECT cur_busq_rtos
IF RECCOUNT("cur_busq_rtos") > 0 THEN 

	Thisform.contenedor1.oinGMERC.leer_det_rto(cur_busq_rtos.idIngcab)
	
ELSE 
	MESSAGEBOX("No hay registros para mostrar",0+48,thisform.Caption)
	
	SELECT cur_busq_rtos
	ZAP 
	SELECT cur_det_rto
	ZAP 
	
	Thisform.contenedor1.txtFecDesde.SetFocus()
ENDIF 


thisform.contenedor1.grdDetalle.Refresh()

ENDPROC
PROCEDURE cargar_combos
&& Cargo los combobox de cbte y tipo de acuerdo a los comprobante seteados en la propiedad list_cbtes

LOCAL lc_cbtes, ln, lc_cantcbtes, ln_cargoAB
DIMENSION la_vector[10]

lc_cbtes = thisform.list_cbtes
lc_cantcbtes = ALINES(la_vector,lc_cbtes,5,",")
ln_cargoAB = 0

Thisform.contenedor1.cmbTipo.AddItem("Todos")

FOR ln=1 TO lc_cantcbtes 
	IF ln == 1 THEN 
		IF lc_cantcbtes > 1
			Thisform.contenedor1.cmbCbte.AddItem("Todos")
		ENDIF 
	ENDIF 
	
	Thisform.contenedor1.cmbCbte.AddItem(STRTRAN(la_vector(ln),"'",""))
	
	IF STRTRAN(la_vector(ln),"'","") == "FC"
		IF ln_cargoAB = 0 THEN 
			Thisform.contenedor1.cmbTipo.AddItem("A")
			Thisform.contenedor1.cmbTipo.AddItem("B")
			ln_cargoAB = 1
		ENDIF 
	ELSE 
		IF STRTRAN(la_vector(ln),"'","") == "RTO"
			Thisform.contenedor1.cmbTipo.AddItem("X")
			Thisform.contenedor1.cmbTipo.AddItem("Z")
		ENDIF 
	ENDIF 
ENDFOR 

Thisform.contenedor1.cmbCbte.ListIndex = 1
Thisform.contenedor1.cmbTipo.ListIndex = 1
ENDPROC
PROCEDURE Init
DODEFAULT()

thisform.contenedor1.txtfecDesde.SetFocus()
thisform.contenedor1.txtFecDesde.Value = DATE() - 30
thisform.contenedor1.txtFecHasta.Value = DATE()
thisform.contenedor1.txtptovta.Value = "0000"
thisform.contenedor1.txtnumero.Value = "00000000"

thisform.cargar_combos()

Thisform.contenedor1.oIngMerc.crear_cursor()
Thisform.contenedor1.oingMERC.crear_cursor_detalle()

SELECT cur_busq_rtos
Thisform.contenedor1.grdRtos.RecordSource = "cur_busq_rtos"
Thisform.contenedor1.grdRtos.list_controlsource = "idIngcab,idProv,cbte,tipo,numero,fecha,controla"
Thisform.contenedor1.grdRtos.lista_ancho_cols = "80,80,50,70,100,150,70"
Thisform.contenedor1.grdRtos.titulos_cabeceras = "N. Ingreso,Proveedor,Cbte,Tipo,Número,Fecha,Controlado"
Thisform.contenedor1.grdRtos.generar_grid()
Thisform.contenedor1.grdRtos.Refresh()

SELECT cur_det_rto
Thisform.contenedor1.grddetalle.RecordSource = "cur_det_rto"
Thisform.contenedor1.grddetalle.list_controlsource = "codart,descripcio,cantidad,cantreci,nropart"
Thisform.contenedor1.grddetalle.lista_ancho_cols = "150,300,70,70,100"
Thisform.contenedor1.grddetalle.titulos_cabeceras = "Código,Descripción,Cantidad,Cant. Ctrl.,Nº Partida"
Thisform.contenedor1.grddetalle.generar_grid()
Thisform.contenedor1.grddetalle.Refresh()
ENDPROC


************************************************************
OBJETO: Contenedor1
************************************************************
*** PROPIEDADES ***
Top = 1
Left = 0
Width = 797
Height = 597
TabIndex = 12
BackColor = 241,236,235
Name = "Contenedor1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Fecha Desde:"
Height = 15
Left = 10
Top = 15
Width = 84
TabIndex = 15
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Fecha Hasta:"
Height = 15
Left = 226
Top = 15
Width = 84
TabIndex = 16
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: txtFecDesde
************************************************************
*** PROPIEDADES ***
Left = 117
TabIndex = 1
Top = 11
isdatetime = .T.
Name = "txtFecDesde"

*** METODOS ***


************************************************************
OBJETO: txtFecHasta
************************************************************
*** PROPIEDADES ***
Left = 303
TabIndex = 2
Top = 11
isdatetime = .T.
Name = "txtFecHasta"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Comprobante:"
Height = 15
Left = 9
Top = 84
Width = 84
TabIndex = 14
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: txtptovta
************************************************************
*** PROPIEDADES ***
Alignment = 3
Value = 
Height = 21
Left = 227
MaxLength = 4
TabIndex = 7
Top = 82
Width = 45
autocompleta = .T.
ischaracter = .T.
Name = "txtptovta"

*** METODOS ***


************************************************************
OBJETO: cmbCbte
************************************************************
*** PROPIEDADES ***
Height = 24
Left = 117
TabIndex = 5
Top = 80
Width = 59
cfieldname = 
Name = "cmbCbte"

*** METODOS ***


************************************************************
OBJETO: cmbTipo
************************************************************
*** PROPIEDADES ***
Height = 24
Left = 179
TabIndex = 6
Top = 80
Width = 44
Name = "cmbTipo"

*** METODOS ***


************************************************************
OBJETO: txtnumero
************************************************************
*** PROPIEDADES ***
Alignment = 3
Value = 
Height = 21
Left = 275
MaxLength = 8
TabIndex = 8
Top = 82
Width = 90
ischaracter = .T.
autocompleta = .T.
Name = "txtnumero"

*** METODOS ***


************************************************************
OBJETO: grdRtos
************************************************************
*** PROPIEDADES ***
Height = 206
Left = 7
TabIndex = 10
Top = 109
Width = 787
Name = "grdRtos"
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
COLUMN7.Text1.Alignment = 3
COLUMN7.Text1.Name = "Text1"
COLUMN7.Alignment = 3
COLUMN7.CurrentControl = "chkcontrola"
COLUMN7.Sparse = .F.
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
PROCEDURE BeforeRowColChange
LPARAMETERS nColIndex

ENDPROC
PROCEDURE AfterRowColChange
LPARAMETERS nColIndex


SELECT cur_busq_rtos
IF RECCOUNT("cur_busq_rtos") > 0 THEN 

	Thisform.contenedor1.oinGMERC.leer_det_rto(cur_busq_rtos.idIngcab)
ENDIF 

thisform.contenedor1.grdDetalle.Refresh()
ENDPROC


************************************************************
OBJETO: chkcontrola
************************************************************
*** PROPIEDADES ***
Top = 21
Left = 30
Alignment = 2
Centered = .T.
Caption = ""
ReadOnly = .T.
Name = "chkcontrola"

*** METODOS ***


************************************************************
OBJETO: btnSalir
************************************************************
*** PROPIEDADES ***
Top = 550
Left = 749
TabIndex = 13
Name = "btnSalir"

*** METODOS ***


************************************************************
OBJETO: btnBuscar
************************************************************
*** PROPIEDADES ***
Top = 62
Left = 749
TabIndex = 9
Name = "btnBuscar"

*** METODOS ***
PROCEDURE Click
thisform.buscar()
ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Detalle de Ingreso"
Height = 15
Left = 8
Top = 320
Width = 112
TabIndex = 14
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: grdDetalle
************************************************************
*** PROPIEDADES ***
Height = 212
Left = 7
TabIndex = 11
Top = 337
Width = 787
Name = "grdDetalle"
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



ENDPROC


************************************************************
OBJETO: sel_prov_desde
************************************************************
*** PROPIEDADES ***
Top = 32
Left = 115
TabIndex = 3
nombre_campo_codigo = idProv
nombre_campo_desc = Razsoc
nombre_tabla = proveedor
pkfield = idProv
alternative_cols = NomFant
cfieldname = idProv
esnumerico = .T.
Name = "sel_prov_desde"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: sel_prov_hasta
************************************************************
*** PROPIEDADES ***
Top = 55
Left = 115
TabIndex = 4
pkfield = idProv
alternative_cols = NomFant
cfieldname = idProv
nombre_alta_form = 
nombre_campo_codigo = idProv
nombre_campo_desc = Razsoc
nombre_tabla = proveedor
esnumerico = .T.
Name = "sel_prov_hasta"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Proveedor Desde:"
Height = 15
Left = 9
Top = 39
Width = 99
TabIndex = 15
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta8
************************************************************
*** PROPIEDADES ***
Caption = "Proveedor Hasta:"
Height = 15
Left = 9
Top = 61
Width = 99
TabIndex = 15
Name = "Clsetiqueta8"

*** METODOS ***


************************************************************
OBJETO: oIngMerc
************************************************************
*** PROPIEDADES ***
Top = 563
Left = 108
Height = 17
Width = 20
Name = "oIngMerc"

*** METODOS ***


************************************************************
OBJETO: Clsimprimir1
************************************************************
*** PROPIEDADES ***
Top = 550
Left = 703
TabIndex = 12
Name = "Clsimprimir1"

*** METODOS ***
PROCEDURE Click
LOCAL m.idingcab, m.fecha, m.proveedor, m.numero
LOCAL lcSql, loResult

loResult = CREATEOBJECT("odbc_result")
lcSql = ""

SELECT cur_busq_rtos 
IF RECCOUNT("cur_busq_rtos") = 0 THEN 
	MESSAGEBOX("Debe seleccionar un remito",0+48,Thisform.Caption)
	RETURN .F.
ENDIF 

SELECT cur_busq_rtos
m.idingcab = ALLTRIM(STR(cur_busq_rtos.idingcab))
m.fecha = cur_busq_rtos.fecha
m.numero = cur_busq_rtos.numero

lcSql = "SELECT * FROM Proveedor WHERE idProv = " + ALLTRIM(STR(cur_busq_rtos.idProv))
loResult.ActiveConnection = goConn.ActiveConnection
loResult.cursor_name = "cur_prov"
loResult.openquery(lcSql)

m.proveedor = ALLTRIM(STR(cur_prov.idProv)) + " - " + ALLTRIM(cur_prov.razsoc)

loResult.close_query()

SELECT cur_det_rto
REPORT FORM repingmerc TO PRINTER PROMPT PREVIEW 




	

ENDPROC


************************************************************
OBJETO: cl_cons_ing
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: cl_ing_merc
************************************************************
*** PROPIEDADES ***
BorderStyle = 2
Height = 480
Width = 883
DoCreate = .T.
Caption = "Ingreso de mercaderías"
Name = "cl_ing_merc"
contenido.Name = "contenido"

*** METODOS ***
PROCEDURE cambiar_estado
PARAMETERS tl_estado

Thisform.Contenido.sel_prov.txtCodigo.Enabled = tl_estado
Thisform.Contenido.btnAceptar.Enabled = tl_estado
Thisform.Contenido.txtptovta.Enabled = tl_estado
Thisform.Contenido.txtnumero.Enabled = tl_estado

Thisform.Contenido.sel_artic.txtCodigo.Enabled = !tl_estado
Thisform.Contenido.txtCantidad.Enabled = !tl_estado
Thisform.Contenido.btnAgregarItem.Enabled = !tl_estado
Thisform.Contenido.btnEliminaItem.Enabled = !tl_estado
Thisform.Contenido.btnGrabar.Enabled = !tl_estado
Thisform.Contenido.btnCancelar.Enabled = !tl_estado
Thisform.Contenido.txtNroPartida.Enabled = !tl_estado
ENDPROC
PROCEDURE Init
DODEFAULT()
Thisform.cambiar_estado(.t.)
Thisform.remito.crear_cursor()

SELECT cur_ptos
Thisform.contenido.grdArticulos.RecordSource = "cur_ptos"
Thisform.contenido.grdArticulos.list_controlsource = "codArt,descripcio,nroPart,cantidad"
Thisform.contenido.grdArticulos.lista_ancho_cols = "100,300,150,70"
Thisform.contenido.grdArticulos.titulos_cabeceras = "Código,Descripción,Nro. Partida,Cantidad"
Thisform.contenido.grdArticulos.generar_grid()

ENDPROC


************************************************************
OBJETO: remito
************************************************************
*** PROPIEDADES ***
Top = 432
Left = 144
Height = 17
Width = 26
Name = "remito"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Proveedor:"
Height = 15
Left = 12
Top = 13
Width = 72
TabIndex = 13
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: sel_prov
************************************************************
*** PROPIEDADES ***
Top = 8
Left = 78
TabIndex = 1
autocompletar_ceros = .F.
esnumerico = .T.
nombre_campo_codigo = idProv
nombre_campo_desc = razSoc
nombre_tabla = proveedor
pkfield = idProv
Name = "sel_prov"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: btnAceptar
************************************************************
*** PROPIEDADES ***
Top = 2
Left = 831
Height = 44
Width = 45
TabIndex = 4
Name = "btnAceptar"

*** METODOS ***
PROCEDURE Click
LOCAL lcSql, loResult, lcptoVta, lcnumcbte, lnIdProv

loResult = CREATEOBJECT("odbc_result")

&& Valido si se ingreso el proveedor
IF thisform.contenido.sel_prov.txtCodigo.Value = 0 THEN 
	MESSAGEBOX("Debe ingresar el proveedor", 0+48, Thisform.Caption)
	Thisform.contenido.sel_prov.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

&& Valido si se ingreso el ptovta y num de remito
IF ALLTRIM(Thisform.contenido.txtptovta.Value) == "0000" THEN
	MESSAGEBOX("Debe ingresar el punto de venta del remito", 0+48, Thisform.Caption)
	Thisform.Contenido.txtptovta.SetFocus()
	RETURN .F.
ENDIF

IF ALLTRIM(Thisform.Contenido.txtnumero.Value) == "00000000" THEN
	MESSAGEBOX("Debe ingresar el número del remito", 0+48, Thisform.Caption)
	Thisform.Contenido.txtnumero.SetFocus()
	RETURN .F.
ENDIF

&& Valido que el remito ingresado para el proveedor ya no se haya ingresado anteriormente.
lnIdProv = Thisform.contenido.sel_prov.txtCodigo.Value
lcptoVta  = Thisform.contenido.txtptovta.Value
lcnumcbte = Thisform.contenido.txtnumero.Value
lcCbte = lcptoVta + "-" + lcnumcbte

lcSql = "SELECT * FROM stk_ingcab WHERE idProv = " + ALLTRIM(STR(lnIdProv)) + " AND numero = '" + lcCbte + "'"
loResult.ActiveConnection = goConn.ActiveConnection
loResult.cursor_name = "cur_remito"
loResult.openquery(lcSql)

IF RECCOUNT("cur_remito") > 0 THEN
	IF MESSAGEBOX("El remito cargado ya fue ingresado para este proveedor, ¿Desea continuar de todos modos?",4+48, Thisform.Caption) <> 6 THEN
		Thisform.contenido.txtptovta.SetFocus()
		loResult.close_query()
		RETURN .F.
	ENDIF 
ENDIF 

loResult.close_query()	

Thisform.cambiar_estado(.f.)
RETURN .T.
ENDPROC


************************************************************
OBJETO: Clslinea1
************************************************************
*** PROPIEDADES ***
Height = 1
Left = 4
Top = 50
Width = 876
Name = "Clslinea1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Artículo:"
Height = 15
Left = 13
Top = 63
Width = 66
TabIndex = 14
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: sel_artic
************************************************************
*** PROPIEDADES ***
Top = 58
Left = 89
Width = 623
Height = 25
TabIndex = 5
autocompletar_ceros = .F.
esnumerico = .F.
nombre_campo_codigo = codArt
nombre_campo_desc = descripcio
nombre_tabla = articulos
pkfield = idArticulo
Name = "sel_artic"
txtCodigo.Height = 21
txtCodigo.Left = 2
txtCodigo.Top = 2
txtCodigo.Width = 183
txtCodigo.Name = "txtCodigo"
txtDescripcion.Height = 21
txtDescripcion.Left = 188
txtDescripcion.Top = 2
txtDescripcion.Width = 427
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***
PROCEDURE recuperar_datos
LOCAL lcSql, loResult, lcCodArt, lnIdProv

loResult = CREATEOBJECT("odbc_result")
lnIdProv = Thisform.contenido.sel_prov.txtCodigo.Value 

&& Valido que el articulo sea del proveedor cargado
IF Thisform.contenido.sel_artic.valcpoid <> 0 THEN

	lcCodArt = Thisform.contenido.sel_artic.txtCodigo.Value
	
	lcSql = "SELECT * FROM articulos WHERE codart = '" + lcCodArt + "'"
	loResult.ActiveConnection = goConn.ActiveConnection
	loResult.cursor_name = "cur_art"
	loResult.openquery(lcSql)
	
	IF cur_art.idProv <> lnIdProv THEN
		MESSAGEBOX("El artículo cargado no pertenece a este proveedor", 0+16, Thisform.Caption)
		Thisform.contenido.sel_artic.valcpoid = 0 
		Thisform.contenido.sel_artic.txtCodigo.Value = ""
		Thisform.contenido.sel_artic.txtDescripcion.Value = ""
		This.txtCodigo.SetFocus()
	ENDIF 
	
	loResult.close_query()	
ENDIF
ENDPROC


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Cantidad:"
Height = 16
Left = 716
Top = 63
Width = 60
TabIndex = 16
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: txtCantidad
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 781
TabIndex = 6
Top = 59
Width = 95
isnumeric = .T.
isinteger = .F.
Name = "txtCantidad"

*** METODOS ***


************************************************************
OBJETO: btnAgregarItem
************************************************************
*** PROPIEDADES ***
Top = 89
Left = 784
Height = 44
Width = 45
TabIndex = 8
Name = "btnAgregarItem"

*** METODOS ***
PROCEDURE Click
LOCAL lcTipo

IF ALLTRIM(thisform.contenido.sel_artic.txtCodigo.Value) == "" THEN
	MESSAGEBOX("Falta ingresar el artículo", 0+48, Thisform.Caption)
	thisform.contenido.sel_artic.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

IF thisform.contenido.txtCantidad.Value = 0 THEN
	MESSAGEBOX("Falta ingresar la cantidad", 0+48, Thisform.Caption)
	thisform.contenido.txtCantidad.SetFocus()
	RETURN .F.
ENDIF


lcTipo = IIF((Thisform.contenido.txtPtoVta.Value == "9999"), "Z", "X")

Thisform.remito.agregar_item(0, Thisform.contenido.sel_artic.valcpoid, "RTO", lcTipo,; 
	ALLTRIM(Thisform.contenido.txtPtoVta.Value) + "-" + ALLTRIM(Thisform.contenido.txtNumero.Value), 0, DATETIME(),; 
	ALLTRIM(Thisform.contenido.sel_Artic.txtCodigo.Value), Thisform.contenido.sel_artic.txtDescripcion.Value, ;
	thisform.contenido.txtNropartida.Value, thisform.contenido.txtCantidad.Value)
	
Thisform.contenido.grdArticulos.Refresh()

Thisform.contenido.sel_artic.blanquear()
Thisform.contenido.txtNroPartida.blanquear()
Thisform.contenido.txtCantidad.blanquear()
Thisform.contenido.sel_artic.txtCodigo.SetFocus()

RETURN .T.
ENDPROC


************************************************************
OBJETO: btnEliminaItem
************************************************************
*** PROPIEDADES ***
Top = 89
Left = 830
Height = 44
Width = 45
TabIndex = 9
Name = "btnEliminaItem"

*** METODOS ***


************************************************************
OBJETO: grdArticulos
************************************************************
*** PROPIEDADES ***
Height = 292
Left = 6
TabIndex = 17
Top = 137
Width = 872
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
OBJETO: btnGrabar
************************************************************
*** PROPIEDADES ***
Top = 433
Left = 787
Height = 44
Width = 45
TabIndex = 10
Name = "btnGrabar"

*** METODOS ***
PROCEDURE Click
SELECT cur_ptos
IF RECCOUNT("cur_ptos") = 0 THEN
	MESSAGEBOX("Debe ingresar al menos un artículo", 0+48, Thisform.Caption)
	Thisform.Contenido.sel_artic.txtCodigo.SetFocus()
	RETURN .T.
ENDIF

IF !Thisform.remito.grabar(Thisform.contenido.sel_prov.txtCodigo.Value) THEN
	MESSAGEBOX("Error al intentar grabar el remito", 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_ptos
ZAP

Thisform.contenido.sel_prov.blanquear()
Thisform.contenido.txtPtoVta.blanquear()
Thisform.contenido.txtNumero.blanquear()
Thisform.contenido.sel_prov.txtCodigo.SetFocus()

Thisform.cambiar_estado(.t.)
RETURN .T.
ENDPROC


************************************************************
OBJETO: btnCancelar
************************************************************
*** PROPIEDADES ***
Top = 433
Left = 8
Height = 44
Width = 45
TabIndex = 11
Name = "btnCancelar"

*** METODOS ***
PROCEDURE Click
Thisform.contenido.sel_prov.blanquear()
Thisform.contenido.sel_prov.valcpoid = 0
Thisform.contenido.txtptovta.Value = ""
Thisform.contenido.txtnumero.Value = ""
Thisform.remito.limpiar
Thisform.contenido.grdArticulos.Refresh()
Thisform.cambiar_estado(.t.)
Thisform.contenido.sel_prov.txtcodigo.SetFocus()
ENDPROC


************************************************************
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 433
Left = 834
Height = 44
Width = 45
TabIndex = 12
Name = "btnCerrar"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Remito:"
Height = 15
Left = 566
Top = 13
Width = 51
TabIndex = 18
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: txtPtoVta
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 618
MaxLength = 4
TabIndex = 2
Top = 10
Width = 74
ischaracter = .T.
autocompleta = .T.
Name = "txtPtoVta"

*** METODOS ***


************************************************************
OBJETO: txtNumero
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 695
MaxLength = 8
TabIndex = 3
Top = 10
Width = 133
autocompleta = .T.
ischaracter = .T.
Name = "txtNumero"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Nro. Partida:"
Height = 15
Left = 13
Top = 87
Width = 66
TabIndex = 15
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: txtNroPartida
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 91
TabIndex = 7
Top = 84
Width = 183
ischaracter = .T.
Name = "txtNroPartida"

*** METODOS ***


************************************************************
OBJETO: cl_ing_merc
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: asign_artdep
************************************************************
*** PROPIEDADES ***
BorderStyle = 2
Height = 465
Width = 890
DoCreate = .T.
Caption = "Asignación Artículos a Depósito"
Name = "asign_artdep"
CONTENIDO.Name = "CONTENIDO"

*** METODOS ***
PROCEDURE Load
DODEFAULT()

ENDPROC
PROCEDURE Init
DODEFAULT()
Thisform.oArtDep.Crear_Cursor()

Thisform.Contenido.cnt_articulos.grdArticulos.RecordSource = "cur_Articulos"
Thisform.Contenido.cnt_articulos.grdArticulos.list_controlsource = "sel,codArt,descripcio"
Thisform.Contenido.cnt_articulos.grdArticulos.lista_ancho_cols = "50,100,500"
Thisform.Contenido.cnt_articulos.grdArticulos.list_controlsource = "sel,codArt,descripcio"
Thisform.Contenido.cnt_articulos.grdArticulos.generar_grid()
ENDPROC


************************************************************
OBJETO: oArtDep
************************************************************
*** PROPIEDADES ***
Top = 434
Left = 232
Height = 17
Width = 44
Name = "oArtDep"

*** METODOS ***


************************************************************
OBJETO: CLSETIQUETA1
************************************************************
*** PROPIEDADES ***
Caption = "Depósito:"
Left = 13
Top = 13
TabIndex = 6
Name = "CLSETIQUETA1"

*** METODOS ***


************************************************************
OBJETO: sel_deposito
************************************************************
*** PROPIEDADES ***
Top = 8
Left = 76
TabIndex = 1
cfieldname = 
nombre_tabla = stk_deps
nombre_campo_codigo = codDep
nombre_campo_desc = descripcio
pkfield = idStkDep
autocompletar_ceros = .F.
Name = "sel_deposito"
TXTCODIGO.Name = "TXTCODIGO"
TXTDESCRIPCION.Name = "TXTDESCRIPCION"

*** METODOS ***


************************************************************
OBJETO: cnt_articulos
************************************************************
*** PROPIEDADES ***
Top = 43
Left = 13
Width = 870
Height = 366
BackStyle = 1
TabIndex = 2
BackColor = 237,218,205
Name = "cnt_articulos"

*** METODOS ***


************************************************************
OBJETO: CLSETIQUETA1
************************************************************
*** PROPIEDADES ***
Caption = "Valor buscado:"
Left = 12
Top = 19
TabIndex = 4
Name = "CLSETIQUETA1"

*** METODOS ***


************************************************************
OBJETO: txtValorBuscado
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 106
TabIndex = 1
Top = 16
Width = 604
Name = "txtValorBuscado"

*** METODOS ***


************************************************************
OBJETO: grdArticulos
************************************************************
*** PROPIEDADES ***
Height = 292
Left = 10
TabIndex = 3
Top = 70
Width = 855
Name = "grdArticulos"
COLUMN1.HEADER1.Name = "HEADER1"
COLUMN1.TEXT1.ReadOnly = .F.
COLUMN1.TEXT1.Name = "TEXT1"
COLUMN1.CurrentControl = "CLSCHECKBOX1"
COLUMN1.ReadOnly = .F.
COLUMN1.Sparse = .F.
COLUMN1.Name = "COLUMN1"
COLUMN2.HEADER1.Name = "HEADER1"
COLUMN2.TEXT1.Name = "TEXT1"
COLUMN2.Name = "COLUMN2"
COLUMN3.HEADER1.Name = "HEADER1"
COLUMN3.TEXT1.Name = "TEXT1"
COLUMN3.Name = "COLUMN3"
COLUMN4.HEADER1.Name = "HEADER1"
COLUMN4.TEXT1.Name = "TEXT1"
COLUMN4.Name = "COLUMN4"
COLUMN5.HEADER1.Name = "HEADER1"
COLUMN5.TEXT1.Name = "TEXT1"
COLUMN5.Name = "COLUMN5"
COLUMN6.HEADER1.Name = "HEADER1"
COLUMN6.TEXT1.Name = "TEXT1"
COLUMN6.Name = "COLUMN6"
COLUMN7.HEADER1.Name = "HEADER1"
COLUMN7.TEXT1.Name = "TEXT1"
COLUMN7.Name = "COLUMN7"
COLUMN8.HEADER1.Name = "HEADER1"
COLUMN8.TEXT1.Name = "TEXT1"
COLUMN8.Name = "COLUMN8"
COLUMN9.HEADER1.Name = "HEADER1"
COLUMN9.TEXT1.Name = "TEXT1"
COLUMN9.Name = "COLUMN9"
COLUMN10.HEADER1.Name = "HEADER1"
COLUMN10.TEXT1.Name = "TEXT1"
COLUMN10.Name = "COLUMN10"
COLUMN11.HEADER1.Name = "HEADER1"
COLUMN11.TEXT1.Name = "TEXT1"
COLUMN11.Name = "COLUMN11"
COLUMN12.HEADER1.Name = "HEADER1"
COLUMN12.TEXT1.Name = "TEXT1"
COLUMN12.Name = "COLUMN12"
COLUMN13.HEADER1.Name = "HEADER1"
COLUMN13.TEXT1.Name = "TEXT1"
COLUMN13.Name = "COLUMN13"
COLUMN14.HEADER1.Name = "HEADER1"
COLUMN14.TEXT1.Name = "TEXT1"
COLUMN14.Name = "COLUMN14"
COLUMN15.HEADER1.Name = "HEADER1"
COLUMN15.TEXT1.Name = "TEXT1"
COLUMN15.Name = "COLUMN15"
COLUMN16.HEADER1.Name = "HEADER1"
COLUMN16.TEXT1.Name = "TEXT1"
COLUMN16.Name = "COLUMN16"
COLUMN17.HEADER1.Name = "HEADER1"
COLUMN17.TEXT1.Name = "TEXT1"
COLUMN17.Name = "COLUMN17"
COLUMN18.HEADER1.Name = "HEADER1"
COLUMN18.TEXT1.Name = "TEXT1"
COLUMN18.Name = "COLUMN18"
COLUMN19.HEADER1.Name = "HEADER1"
COLUMN19.TEXT1.Name = "TEXT1"
COLUMN19.Name = "COLUMN19"
COLUMN20.HEADER1.Name = "HEADER1"
COLUMN20.TEXT1.Name = "TEXT1"
COLUMN20.Name = "COLUMN20"

*** METODOS ***


************************************************************
OBJETO: CLSCHECKBOX1
************************************************************
*** PROPIEDADES ***
Top = 30
Left = 51
Width = 12
Alignment = 0
Caption = ""
ReadOnly = .F.
Name = "CLSCHECKBOX1"

*** METODOS ***


************************************************************
OBJETO: chkMarcarTodos
************************************************************
*** PROPIEDADES ***
Top = 52
Left = 23
Height = 18
Width = 121
Alignment = 0
Caption = "Marcar Todos"
Name = "chkMarcarTodos"

*** METODOS ***
PROCEDURE InteractiveChange
IF this.Value = 1 THEN
	Thisform.oArtDep.marcar_todos()
	Thisform.Contenido.cnt_articulos.grdArticulos.Refresh()
ELSE
	Thisform.oArtDep.desmarcar_todos()
	Thisform.Contenido.cnt_articulos.grdArticulos.Refresh()
ENDIF
ENDPROC


************************************************************
OBJETO: btnBusquedaAvanzada
************************************************************
*** PROPIEDADES ***
Top = 8
Left = 767
Picture = ..\imagen\iconos bajados\editar-buscar-icono-5523.ico
TabIndex = 6
ToolTipText = "Búsqueda Avanzada"
Name = "btnBusquedaAvanzada"

*** METODOS ***
PROCEDURE Click
LOCAL lnIdProvDD, lnIdProvHH, lnIdMarcaDD, lnIdMarcaHH 
LOCAL lnIdFamDD, lnIdFamHH, lnIdSubFamDD, lnIdSubFamHH 
LOCAL lnIdArtDD, lnIdArtHH
LOCAL loForm

loForm = CREATEOBJECT("cl_busqueda_avanzada")
loForm.Show()

lnIdProvDD = 0
lnIdProvHH = 0
lnIdMarcaDD = 0
lnIdMarcaHH = 0
lnIdFamDD = 0
lnIdFamHH = 0
lnIdSubFamDD = 0
lnIdSubFamHH = 0
lnIdArtDD = 0
lnIdArtHH = 0

IF loForm.result = 0 THEN
	loForm.release()
	RETURN .F.
ENDIF

lnIdProvDD = IIF(ISNULL(loForm.idprov_dd), 0, loForm.idprov_dd)
lnIdProvHH = IIF(ISNULL(loForm.idprov_hh), 0, loForm.idprov_hh)
lnIdMarcaDD = IIF(ISNULL(loForm.idmarca_dd), 0, loForm.idmarca_dd)
lnIdMarcaHH = IIF(ISNULL(loForm.idmarca_hh), 0, loForm.idmarca_hh)
lnIdFamDD = IIF(ISNULL(loForm.idfamilia_dd), 0, loForm.idfamilia_dd)
lnIdFamHH = IIF(ISNULL(loForm.idfamilia_hh), 0, loForm.idfamilia_hh)
lnIdSubFamDD = IIF(ISNULL(loForm.idsubfam_dd), 0, loForm.idsubfam_dd)
lnIdSubFamHH = IIF(ISNULL(loForm.idsubfam_hh), 0, loForm.idsubfam_hh)
lnIdArtDD = IIF(ISNULL(loForm.idart_dd), 0, loForm.idart_dd)
lnIdArtHH = IIF(ISNULL(loForm.idart_hh), 0, loForm.idart_hh)

Thisform.oArtDep.limpiar()

Thisform.oArtDep.busqueda_avanzada(lnIdProvDD, lnIdProvHH, lnIdMarcaDD, lnIdMarcaHH, lnIdFamDD, lnIdFamHH, lnIdSubFamDD, lnIdSubFamHH, lnIdArtDD, lnIdArtHH)
Thisform.Contenido.cnt_articulos.grdArticulos.Refresh()

loForm.Release()
RETURN .T.
ENDPROC


************************************************************
OBJETO: btnBuscar
************************************************************
*** PROPIEDADES ***
Top = 8
Left = 719
TabIndex = 2
Name = "btnBuscar"

*** METODOS ***
PROCEDURE Click
Thisform.oArtDep.valor_buscado = Thisform.Contenido.Cnt_articulos.txtValorBuscado.Value
Thisform.oArtDep.limpiar()
Thisform.oArtDep.buscar_articulo()
Thisform.Contenido.cnt_articulos.grdArticulos.Refresh()
ENDPROC


************************************************************
OBJETO: btnGrabar
************************************************************
*** PROPIEDADES ***
Top = 415
Left = 791
TabIndex = 3
Name = "btnGrabar"

*** METODOS ***
PROCEDURE Click
IF Thisform.Contenido.sel_deposito.valcpoid = 0 THEN
	MESSAGEBOX("Debe ingresar el depósito a asignar", 0+48, Thisform.Caption)
	Thisform.Contenido.sel_deposito.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

Thisform.oArtDep.idStkDep = Thisform.Contenido.sel_deposito.valcpoid

IF !Thisform.oArtDep.validar_datos() THEN
	MESSAGEBOX(Thisform.oArtDep.ErrorMessage, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

IF !Thisform.oArtDep.asignar() THEN
	MESSAGEBOX(Thisform.oArtDep.ErrorMessage, 0+48, THisform.Caption)
	RETURN .F.
ENDIF

Thisform.oArtDep.limpiar()
Thisform.Contenido.cnt_articulos.txtValorBuscado.Value = ""
Thisform.Contenido.cnt_articulos.chkMarcarTodos.Value = 0
RETURN .T.

ENDPROC


************************************************************
OBJETO: btnCancelar
************************************************************
*** PROPIEDADES ***
Top = 415
Left = 12
TabIndex = 4
Name = "btnCancelar"

*** METODOS ***
PROCEDURE Click
Thisform.Contenido.sel_deposito.blanquear()
Thisform.Contenido.Cnt_articulos.txtValorBuscado.blanquear()
Thisform.oArtDep.Limpiar()
ENDPROC


************************************************************
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 415
Left = 838
Height = 43
Width = 45
TabIndex = 5
Name = "btnCerrar"

*** METODOS ***


************************************************************
OBJETO: asign_artdep
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cl_ing_merc_cstock
************************************************************
*** PROPIEDADES ***
BorderStyle = 2
Height = 480
Width = 883
DoCreate = .T.
Caption = "Ingreso de mercaderías"
Name = "cl_ing_merc_cstock"
contenido.Name = "contenido"

*** METODOS ***
PROCEDURE cambiar_estado
PARAMETERS tl_estado

Thisform.Contenido.sel_prov.txtCodigo.Enabled = tl_estado
Thisform.Contenido.btnAceptar.Enabled = tl_estado
Thisform.Contenido.txtptovta.Enabled = tl_estado
Thisform.Contenido.txtnumero.Enabled = tl_estado

Thisform.Contenido.sel_artic.txtCodigo.Enabled = !tl_estado
Thisform.Contenido.txtCantidad.Enabled = !tl_estado
Thisform.Contenido.btnAgregarItem.Enabled = !tl_estado
Thisform.Contenido.btnEliminaItem.Enabled = !tl_estado
Thisform.Contenido.btnGrabar.Enabled = !tl_estado
Thisform.Contenido.btnCancelar.Enabled = !tl_estado
Thisform.Contenido.txtNroPartida.Enabled = !tl_estado
ENDPROC
PROCEDURE Init
DODEFAULT()
Thisform.cambiar_estado(.t.)
Thisform.remito.crear_cursor()

SELECT cur_ptos
Thisform.contenido.grdArticulos.RecordSource = "cur_ptos"
Thisform.contenido.grdArticulos.list_controlsource = "codArt,descripcio,nroPart,cantidad"
Thisform.contenido.grdArticulos.lista_ancho_cols = "100,300,150,70"
Thisform.contenido.grdArticulos.titulos_cabeceras = "Código,Descripción,Nro. Partida,Cantidad"
Thisform.contenido.grdArticulos.generar_grid()

ENDPROC


************************************************************
OBJETO: remito
************************************************************
*** PROPIEDADES ***
Top = 432
Left = 144
Height = 17
Width = 26
Name = "remito"

*** METODOS ***


************************************************************
OBJETO: mov_stock
************************************************************
*** PROPIEDADES ***
Top = 446
Left = 222
Height = 17
Width = 42
Name = "mov_stock"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Proveedor:"
Height = 15
Left = 12
Top = 13
Width = 72
TabIndex = 14
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: sel_prov
************************************************************
*** PROPIEDADES ***
Top = 8
Left = 78
TabIndex = 1
autocompletar_ceros = .F.
esnumerico = .T.
nombre_campo_codigo = idProv
nombre_campo_desc = razSoc
nombre_tabla = proveedor
pkfield = idProv
Name = "sel_prov"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: btnAceptar
************************************************************
*** PROPIEDADES ***
Top = 2
Left = 831
Height = 44
Width = 45
TabIndex = 4
Name = "btnAceptar"

*** METODOS ***
PROCEDURE Click
LOCAL lcSql, loResult, lcptoVta, lcnumcbte, lnIdProv

loResult = CREATEOBJECT("odbc_result")

&& Valido si se ingreso el proveedor
IF thisform.contenido.sel_prov.txtCodigo.Value = 0 THEN 
	MESSAGEBOX("Debe ingresar el proveedor", 0+48, Thisform.Caption)
	Thisform.contenido.sel_prov.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

&& Valido si se ingreso el ptovta y num de remito
IF ALLTRIM(Thisform.contenido.txtptovta.Value) == "0000" THEN
	MESSAGEBOX("Debe ingresar el punto de venta del remito", 0+48, Thisform.Caption)
	Thisform.Contenido.txtptovta.SetFocus()
	RETURN .F.
ENDIF

IF ALLTRIM(Thisform.Contenido.txtnumero.Value) == "00000000" THEN
	MESSAGEBOX("Debe ingresar el número del remito", 0+48, Thisform.Caption)
	Thisform.Contenido.txtnumero.SetFocus()
	RETURN .F.
ENDIF

&& Valido que el remito ingresado para el proveedor ya no se haya ingresado anteriormente.
lnIdProv = Thisform.contenido.sel_prov.txtCodigo.Value
lcptoVta  = Thisform.contenido.txtptovta.Value
lcnumcbte = Thisform.contenido.txtnumero.Value
lcCbte = lcptoVta + "-" + lcnumcbte

lcSql = "SELECT * FROM stk_ingcab WHERE idProv = " + ALLTRIM(STR(lnIdProv)) + " AND numero = '" + lcCbte + "'"
loResult.ActiveConnection = goConn.ActiveConnection
loResult.cursor_name = "cur_remito"
loResult.openquery(lcSql)

IF RECCOUNT("cur_remito") > 0 THEN
	IF MESSAGEBOX("El remito cargado ya fue ingresado para este proveedor, ¿Desea continuar de todos modos?",4+48, Thisform.Caption) <> 6 THEN
		Thisform.contenido.txtptovta.SetFocus()
		loResult.close_query()
		RETURN .F.
	ENDIF 
ENDIF 

loResult.close_query()	

Thisform.cambiar_estado(.f.)
RETURN .T.
ENDPROC


************************************************************
OBJETO: Clslinea1
************************************************************
*** PROPIEDADES ***
Height = 1
Left = 4
Top = 50
Width = 876
Name = "Clslinea1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Artículo:"
Height = 15
Left = 13
Top = 63
Width = 66
TabIndex = 15
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: sel_artic
************************************************************
*** PROPIEDADES ***
Top = 58
Left = 89
Width = 623
Height = 25
TabIndex = 5
autocompletar_ceros = .F.
esnumerico = .F.
nombre_campo_codigo = codArt
nombre_campo_desc = descripcio
nombre_tabla = articulos
pkfield = idArticulo
Name = "sel_artic"
txtCodigo.Height = 21
txtCodigo.Left = 2
txtCodigo.MaxLength = 0
txtCodigo.Top = 2
txtCodigo.Width = 183
txtCodigo.autocompleta = .F.
txtCodigo.ischaracter = .T.
txtCodigo.Name = "txtCodigo"
txtDescripcion.Height = 21
txtDescripcion.Left = 188
txtDescripcion.Top = 2
txtDescripcion.Width = 427
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***
PROCEDURE recuperar_datos
LOCAL lcSql, loResult, lcCodArt, lnIdProv

loResult = CREATEOBJECT("odbc_result")
lnIdProv = Thisform.contenido.sel_prov.txtCodigo.Value 

&& Valido que el articulo sea del proveedor cargado
IF Thisform.contenido.sel_artic.valcpoid <> 0 THEN

	lcCodArt = Thisform.contenido.sel_artic.txtCodigo.Value
	
	lcSql = "SELECT * FROM articulos WHERE codart = '" + lcCodArt + "'"
	loResult.ActiveConnection = goConn.ActiveConnection
	loResult.cursor_name = "cur_art"
	loResult.openquery(lcSql)
	
*!*		IF cur_art.idProv <> lnIdProv THEN
*!*			MESSAGEBOX("El artículo cargado no pertenece a este proveedor", 0+16, Thisform.Caption)
*!*			Thisform.contenido.sel_artic.valcpoid = 0 
*!*			Thisform.contenido.sel_artic.txtCodigo.Value = ""
*!*			Thisform.contenido.sel_artic.txtDescripcion.Value = ""
*!*			This.txtCodigo.SetFocus()
*!*		ENDIF
	
	loResult.close_query()
	
	lcSql = "select codArt, cantiDesp from codiart "
	lcSql = lcSql + "where codigos = '" + ALLTRIM(This.txtCodigo.Value) + "' "
	lcSql = lcSql + "	and (circuito = 'C' or circuito = 'CV')"

	loResult.ActiveConnection = goConn.ActiveConnection
	loResult.Cursor_Name = "cur_x"
	
	IF !loResult.OpenQuery(lcSql) THEN
		MESSAGEBOX(loResult.Error_Message, 0+48, Thisform.Caption)
		RETURN
	ENDIF

	SELECT cur_x
	IF RECCOUNT("cur_x") > 0 THEN
		GO TOP
		
		IF RECCOUNT("cur_x") = 1 THEN
			&& Paso por aca en caso que solo encuentre un registro puntual
			*lcCodArt = thisform.leer_unid_desp(this.Value, "codigos")
			loResult.close_query()
			This.txtCodigo.Value = lcCodArt
			DODEFAULT()
			
			RETURN
		ELSE 
			&& En caso de que devuelva más de un registro, recupero el codigo de artículo
			&& para que haga la búsqueda normal
			lcCodArt = cur_x.codArt
			loResult.close_query()
			
			This.txtCodigo.Value = lcCodArt
			DODEFAULT()	
			*lcCodArt = thisform.leer_unid_desp(this.Value, "codigos")
		ENDIF
	ELSE
		&& Si no encuentra nada en codiart entonces sigue la busqueda
		&& estandar
		
		DODEFAULT()
		*lcCodArt = thisform.leer_unid_desp(this.Value, "codArt")
	ENDIF
	
	IF USED("cur_x") THEN
		loResult.close_query()
	ENDIF

	IF ALLTRIM(lcCodArt) == "ERROR" THEN
		RETURN
	ENDIF	
ENDIF
ENDPROC


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Cantidad:"
Height = 16
Left = 716
Top = 63
Width = 60
TabIndex = 18
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: txtCantidad
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 781
TabIndex = 6
Top = 59
Width = 95
isnumeric = .T.
isinteger = .F.
Name = "txtCantidad"

*** METODOS ***


************************************************************
OBJETO: btnAgregarItem
************************************************************
*** PROPIEDADES ***
Top = 89
Left = 784
Height = 44
Width = 45
TabIndex = 9
Name = "btnAgregarItem"

*** METODOS ***
PROCEDURE Click
LOCAL lcTipo, loForm

IF ALLTRIM(thisform.contenido.sel_artic.txtCodigo.Value) == "" THEN
	MESSAGEBOX("Falta ingresar el artículo", 0+48, Thisform.Caption)
	thisform.contenido.sel_artic.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

IF ALLTRIM(Thisform.contenido.sel_artic.txtCodigo.Value) == "0000" THEN
	MESSAGEBOX("El código de artículo que ingresó está en cero, por favor, ingrese un código correcto", 0+48, Thisform.Caption)
	Thisform.contenido.sel_artic.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

IF thisform.contenido.txtCantidad.Value = 0 THEN
	MESSAGEBOX("Falta ingresar la cantidad", 0+48, Thisform.Caption)
	thisform.contenido.txtCantidad.SetFocus()
	RETURN .F.
ENDIF

lcTipo = IIF((Thisform.contenido.txtPtoVta.Value == "9999"), "Z", "X")

loForm = CREATEOBJECT("cls_control_precios_edit")
loForm.idArticulo = Thisform.contenido.sel_artic.valcpoid
loForm.idIngDet = 0
loForm.idIngCab = 0
loForm.actualiza_ingresos = .F.
loForm.precio_ing = 0.00
loForm.recuperar_precios()

loForm.show()

Thisform.remito.agregar_item(0, Thisform.contenido.sel_artic.valcpoid, "RTO", lcTipo,; 
	ALLTRIM(Thisform.contenido.txtPtoVta.Value) + "-" + ALLTRIM(Thisform.contenido.txtNumero.Value), 0, DATETIME(),; 
	ALLTRIM(Thisform.contenido.sel_Artic.txtCodigo.Value), Thisform.contenido.sel_artic.txtDescripcion.Value, ;
	thisform.contenido.txtNropartida.Value, thisform.contenido.txtCantidad.Value)
	
Thisform.contenido.grdArticulos.Refresh()

Thisform.contenido.sel_artic.blanquear()
Thisform.contenido.txtNroPartida.blanquear()
Thisform.contenido.txtCantidad.blanquear()
Thisform.contenido.sel_artic.txtCodigo.SetFocus()
Thisform.contenido.txtPrecio.blanquear()

RETURN .T.
ENDPROC


************************************************************
OBJETO: btnEliminaItem
************************************************************
*** PROPIEDADES ***
Top = 89
Left = 830
Height = 44
Width = 45
TabIndex = 10
Name = "btnEliminaItem"

*** METODOS ***


************************************************************
OBJETO: grdArticulos
************************************************************
*** PROPIEDADES ***
Height = 292
Left = 6
TabIndex = 19
Top = 137
Width = 872
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
OBJETO: btnGrabar
************************************************************
*** PROPIEDADES ***
Top = 433
Left = 787
Height = 44
Width = 45
TabIndex = 11
Name = "btnGrabar"

*** METODOS ***
PROCEDURE Click
SELECT cur_ptos
IF RECCOUNT("cur_ptos") = 0 THEN
	MESSAGEBOX("Debe ingresar al menos un artículo", 0+48, Thisform.Caption)
	Thisform.Contenido.sel_artic.txtCodigo.SetFocus()
	RETURN .T.
ENDIF

IF !Thisform.remito.grabar(Thisform.contenido.sel_prov.txtCodigo.Value) THEN
	MESSAGEBOX("Error al intentar grabar el remito", 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

&& Genero los movimientos de stock

Thisform.mov_stock.crear_cursor()
Thisform.mov_stock.circuito = "S"
Thisform.mov_stock.tipomov = "ENT"
Thisform.mov_stock.codusu = gcCodUsu

SELECT cur_ptos
GO TOP

DO WHILE !EOF("cur_ptos")
	IF !Thisform.mov_stock.agregar_articulo(cur_ptos.idArticulo, cur_ptos.cantidad, cur_ptos.nroPart) THEN
		MESSAGEBOX(Thisform.mov_stock.errorMessage, 0+48, Thisform.Caption)
		RETURN .F.
	ENDIF

	SELECT cur_ptos
	SKIP
ENDDO

IF !Thisform.mov_stock.grabar(0) THEN
	MESSAGEBOX(Thisform.mov_stock.ErrorMessage, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_ptos
ZAP

MESSAGEBOX("El ingreso se ha generado con éxito", 0+64, Thisform.Caption)

Thisform.contenido.sel_prov.blanquear()
Thisform.contenido.sel_prov.valcpoid = 0
Thisform.contenido.txtptovta.Value = ""
Thisform.contenido.txtnumero.Value = ""
Thisform.remito.limpiar()
Thisform.contenido.grdArticulos.Refresh()
Thisform.cambiar_estado(.t.)
Thisform.contenido.sel_prov.txtcodigo.SetFocus()

Thisform.cambiar_estado(.t.)
RETURN .T.
ENDPROC


************************************************************
OBJETO: btnCancelar
************************************************************
*** PROPIEDADES ***
Top = 433
Left = 8
Height = 44
Width = 45
TabIndex = 12
Name = "btnCancelar"

*** METODOS ***
PROCEDURE Click
Thisform.contenido.sel_prov.blanquear()
Thisform.contenido.sel_prov.valcpoid = 0
Thisform.contenido.txtptovta.Value = ""
Thisform.contenido.txtnumero.Value = ""
Thisform.remito.limpiar()
Thisform.contenido.grdArticulos.Refresh()
Thisform.cambiar_estado(.t.)
Thisform.contenido.sel_prov.txtcodigo.SetFocus()
ENDPROC


************************************************************
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 433
Left = 834
Height = 44
Width = 45
TabIndex = 13
Name = "btnCerrar"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Remito:"
Height = 15
Left = 566
Top = 13
Width = 51
TabIndex = 20
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: txtPtoVta
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 618
MaxLength = 4
TabIndex = 2
Top = 10
Width = 74
ischaracter = .T.
autocompleta = .T.
Name = "txtPtoVta"

*** METODOS ***


************************************************************
OBJETO: txtNumero
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 695
MaxLength = 8
TabIndex = 3
Top = 10
Width = 133
autocompleta = .T.
ischaracter = .T.
Name = "txtNumero"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Nro. Partida:"
Height = 15
Left = 13
Top = 87
Width = 66
TabIndex = 17
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: txtNroPartida
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 91
TabIndex = 7
Top = 84
Width = 183
ischaracter = .T.
Name = "txtNroPartida"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta6
************************************************************
*** PROPIEDADES ***
Caption = "Precio de lista:"
Height = 15
Left = 280
Top = 87
Visible = .F.
Width = 90
TabIndex = 16
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: txtPrecio
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 371
TabIndex = 8
Top = 84
Visible = .F.
Width = 95
isnumeric = .T.
isinteger = .F.
Name = "txtPrecio"

*** METODOS ***


************************************************************
OBJETO: cl_ing_merc_cstock
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cl_cons_stk
************************************************************
*** PROPIEDADES ***
BorderStyle = 2
Height = 495
Width = 715
DoCreate = .T.
Caption = "Consulta de Stock"
WindowType = 0
Name = "cl_cons_stk"

*** METODOS ***
PROCEDURE cargar_combos
LOCAL lcSql, loUsuario, loRes

lcSql = ""
loUsuario = CREATEOBJECT("odbc_result")
loRes = CREATEOBJECT("odbc_result")

&& Cargo el combo de tipos de movimiento
lcSql = "SELECT codmov FROM stk_tipomov ORDER BY codmov"
loRes.ActiveConnection = goConn.ActiveConnection
loRes.cursor_name = "cur_movs"

IF !loRes.OpenQuery(lcSql)
	MESSAGEBOX(loRes.error_message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

Thisform.Contenido.cmbTipoMov.AddItem("Todos")

SELECT cur_movs
IF RECCOUNT("cur_movs") <> 0 THEN 
	DO WHILE !EOF("cur_movs")
		SELECT cur_movs
		Thisform.contenido.cmbTipoMov.AddItem(cur_movs.codmov)
		
		SELECT cur_movs
		SKIP
	ENDDO 
ENDIF 

Thisform.Contenido.cmbTipoMov.ListIndex = 1
loRes.close_query()


&& Cargo el combo de usuarios
lcSql = "SELECT * FROM usuarios WHERE FecBaja IS NULL ORDER BY codusu"
loUsuario.ActiveConnection  = goConn.ActiveConnection
loUsuario.cursor_name = "cur_usuarios"

IF !loUsuario.OpenQuery(lcSql)
	MESSAGEBOX(loUsuario.error_message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF
	
Thisform.contenido.cmbusuarios.AddItem("Todos") && Todos los usuarios

SELECT cur_usuarios
DO WHILE !EOF("cur_usuarios")
	Thisform.contenido.cmbUsuarios.AddItem(ALLTRIM(cur_usuarios.codusu))
	
	SELECT cur_usuarios
	SKIP 
ENDDO 

Thisform.contenido.cmbusuarios.ListIndex = 1

loUsuario.close_query()
ENDPROC
PROCEDURE exportar_excel
genexcel("cur_MovStock","Listado de Stock")
ENDPROC
PROCEDURE blanquear
Thisform.contenido.txtFecDesde.Value = DATE(2014,01,01)
Thisform.contenido.txtFecHasta.Value = DATE()
Thisform.contenido.opgStock.Value = 1
Thisform.contenido.opg_salida.Value = 1
Thisform.contenido.cmbTipoMov.ListIndex = 1
Thisform.contenido.cmbUsuarios.ListIndex = 1
Thisform.contenido.selProvDD.blanquear()
Thisform.contenido.sel_ProvHH.blanquear()
Thisform.contenido.sel_MarcaDD.blanquear()
Thisform.contenido.sel_MarcaHH.blanquear()
Thisform.contenido.sel_FamiliaDD.blanquear()
Thisform.contenido.sel_FamiliaHH.blanquear()
Thisform.contenido.sel_SubFamDD.blanquear()
Thisform.contenido.sel_SubFamHH.blanquear()
Thisform.contenido.sel_DepositoDD.blanquear()
Thisform.contenido.sel_DepositoHH.blanquear()
Thisform.contenido.sel_ArticuloDD.blanquear()
Thisform.contenido.sel_ArticuloHH.blanquear()

Thisform.contenido.txtFecDesde.SetFocus()


ENDPROC
PROCEDURE Init
WAIT WINDOW "Espere por favor..." NOWAIT
DODEFAULT()
Thisform.contenido.txtFecDesde.Value = DATE(2014,01,01)
Thisform.contenido.txtFecHasta.Value = DATE()
Thisform.cargar_combos()
Thisform.contenido.txtFecDesde.SetFocus()
WAIT WINDOW "OK..." NOWAIT
ENDPROC


************************************************************
OBJETO: contenido
************************************************************
*** PROPIEDADES ***
Top = 2
Left = 2
Width = 710
Height = 441
BackStyle = 1
BackColor = 237,218,205
Name = "contenido"

*** METODOS ***


************************************************************
OBJETO: CLSETIQUETA1
************************************************************
*** PROPIEDADES ***
Caption = "Proveedor Desde:"
Height = 15
Left = 16
Top = 159
Width = 110
TabIndex = 17
Name = "CLSETIQUETA1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Proveedor Hasta:"
Height = 15
Left = 16
Top = 181
Width = 109
TabIndex = 18
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Familia Desde:"
Height = 15
Left = 16
Top = 250
Width = 111
TabIndex = 19
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Familia Hasta:"
Height = 15
Left = 16
Top = 273
Width = 109
TabIndex = 20
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Sub-Familia Desde:"
Height = 15
Left = 16
Top = 296
Width = 109
TabIndex = 21
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta6
************************************************************
*** PROPIEDADES ***
Caption = "Sub-Familia Hasta:"
Height = 15
Left = 16
Top = 319
Width = 107
TabIndex = 22
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: selProvDD
************************************************************
*** PROPIEDADES ***
Top = 153
Left = 128
Width = 484
Height = 25
TabIndex = 7
autocompletar_ceros = .F.
esnumerico = .T.
nombre_campo_codigo = idProv
nombre_campo_desc = razSoc
nombre_tabla = proveedor
pkfield = idProv
Name = "selProvDD"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: sel_ProvHH
************************************************************
*** PROPIEDADES ***
Top = 176
Left = 128
Width = 483
Height = 25
TabIndex = 8
autocompletar_ceros = .F.
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
OBJETO: sel_FamiliaDD
************************************************************
*** PROPIEDADES ***
Top = 245
Left = 128
Width = 484
Height = 25
TabIndex = 11
WhatsThisHelpID = -1
esnumerico = .T.
autocompletar_ceros = .F.
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
Top = 268
Left = 128
Width = 484
Height = 25
TabIndex = 12
autocompletar_ceros = .F.
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
OBJETO: sel_SubFamDD
************************************************************
*** PROPIEDADES ***
Top = 291
Left = 128
Width = 485
Height = 25
TabIndex = 13
autocompletar_ceros = .F.
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
Top = 314
Left = 128
Width = 485
Height = 25
TabIndex = 14
autocompletar_ceros = .F.
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
OBJETO: Clsetiqueta7
************************************************************
*** PROPIEDADES ***
Caption = "Fecha Desde:"
Height = 15
Left = 12
Top = 14
Width = 84
TabIndex = 23
Name = "Clsetiqueta7"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta8
************************************************************
*** PROPIEDADES ***
Caption = "Fecha Hasta:"
Height = 15
Left = 203
Top = 14
Width = 84
TabIndex = 24
Name = "Clsetiqueta8"

*** METODOS ***


************************************************************
OBJETO: txtFecDesde
************************************************************
*** PROPIEDADES ***
Left = 94
TabIndex = 1
Top = 10
isdatetime = .T.
Name = "txtFecDesde"

*** METODOS ***


************************************************************
OBJETO: txtFecHasta
************************************************************
*** PROPIEDADES ***
Left = 279
TabIndex = 2
Top = 10
isdatetime = .T.
Name = "txtFecHasta"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta9
************************************************************
*** PROPIEDADES ***
Caption = "Depóstio Desde:"
Height = 15
Left = 16
Top = 342
Width = 109
TabIndex = 26
Name = "Clsetiqueta9"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta10
************************************************************
*** PROPIEDADES ***
Caption = "Depósito Hasta:"
Height = 15
Left = 16
Top = 365
Width = 107
TabIndex = 28
Name = "Clsetiqueta10"

*** METODOS ***


************************************************************
OBJETO: sel_DepositoDD
************************************************************
*** PROPIEDADES ***
Top = 337
Left = 128
Width = 485
Height = 25
TabIndex = 15
esnumerico = .F.
autocompletar_ceros = .F.
nombre_campo_codigo = codDep
nombre_campo_desc = descripcio
nombre_tabla = stk_deps
pkfield = idStkDep
Name = "sel_DepositoDD"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: sel_DepositoHH
************************************************************
*** PROPIEDADES ***
Top = 360
Left = 128
Width = 485
Height = 25
TabIndex = 16
autocompletar_ceros = .F.
esnumerico = .F.
nombre_campo_codigo = codDep
nombre_campo_desc = descripcio
nombre_tabla = stk_deps
pkfield = idStkDep
Name = "sel_DepositoHH"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: opgStock
************************************************************
*** PROPIEDADES ***
ButtonCount = 3
BackStyle = 0
BorderStyle = 1
Height = 75
Left = 9
SpecialEffect = 0
Top = 61
Width = 167
TabIndex = 4
ColorSource = 4
BorderColor = 100,100,100
Name = "opgStock"
Option1.FontSize = 8
Option1.BackStyle = 0
Option1.Caption = "Listado de Existencia"
Option1.Height = 15
Option1.Left = 5
Option1.Top = 8
Option1.Width = 163
Option1.ForeColor = 158,106,75
Option1.BackColor = 244,244,244
Option1.Name = "Option1"
Option2.FontSize = 8
Option2.BackStyle = 0
Option2.Caption = "Detalle de Movimientos"
Option2.Height = 15
Option2.Left = 5
Option2.Top = 29
Option2.Width = 187
Option2.ForeColor = 158,106,75
Option2.BackColor = 244,244,244
Option2.Name = "Option2"
Option3.FontBold = .T.
Option3.FontSize = 8
Option3.BackStyle = 0
Option3.Caption = "Stock Valorizado"
Option3.Height = 15
Option3.Left = 5
Option3.Top = 50
Option3.Width = 139
Option3.ForeColor = 158,106,75
Option3.BackColor = 244,244,244
Option3.Name = "Option3"

*** METODOS ***
PROCEDURE Option1.Click
Thisform.contenido.cmbTipoMov.Enabled = .F.
Thisform.contenido.cmbusuarios.Enabled = .F.

ENDPROC
PROCEDURE Option2.Click
Thisform.contenido.cmbTipoMov.Enabled = .T.
Thisform.contenido.cmbusuarios.Enabled = .T.

ENDPROC
PROCEDURE Option3.Click
Thisform.contenido.cmbTipoMov.Enabled = .F.
Thisform.contenido.cmbusuarios.Enabled = .F.

ENDPROC


************************************************************
OBJETO: Clsetiqueta11
************************************************************
*** PROPIEDADES ***
Caption = "Marca Desde:"
Height = 15
Left = 16
Top = 204
Width = 109
TabIndex = 29
Name = "Clsetiqueta11"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta12
************************************************************
*** PROPIEDADES ***
Caption = "Marca Hasta:"
Height = 15
Left = 16
Top = 227
Width = 107
TabIndex = 30
Name = "Clsetiqueta12"

*** METODOS ***


************************************************************
OBJETO: sel_MarcaDD
************************************************************
*** PROPIEDADES ***
Top = 199
Left = 128
Width = 485
Height = 25
TabIndex = 9
esnumerico = .T.
autocompletar_ceros = .F.
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
Top = 222
Left = 128
Width = 485
Height = 25
TabIndex = 10
autocompletar_ceros = .F.
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
OBJETO: Clsetiqueta13
************************************************************
*** PROPIEDADES ***
Caption = "Artículo Desde:"
Height = 15
Left = 16
Top = 388
Width = 109
TabIndex = 25
Name = "Clsetiqueta13"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta14
************************************************************
*** PROPIEDADES ***
Caption = "Artículo Hasta:"
Height = 15
Left = 16
Top = 411
Width = 107
TabIndex = 27
Name = "Clsetiqueta14"

*** METODOS ***


************************************************************
OBJETO: sel_ArticuloDD
************************************************************
*** PROPIEDADES ***
Top = 383
Left = 128
Width = 530
Height = 25
TabIndex = 17
esnumerico = .F.
autocompletar_ceros = .F.
nombre_campo_codigo = codArt
nombre_campo_desc = descripcio
nombre_tabla = articulos
pkfield = idArticulo
Name = "sel_ArticuloDD"
txtCodigo.Height = 21
txtCodigo.Left = 2
txtCodigo.Top = 2
txtCodigo.Visible = .T.
txtCodigo.Width = 150
txtCodigo.Name = "txtCodigo"
txtDescripcion.Left = 156
txtDescripcion.Top = 2
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: sel_ArticuloHH
************************************************************
*** PROPIEDADES ***
Top = 406
Left = 128
Width = 533
Height = 25
TabIndex = 18
autocompletar_ceros = .F.
esnumerico = .F.
nombre_campo_codigo = codArt
nombre_campo_desc = descripcio
nombre_tabla = articulos
pkfield = idArticulo
Name = "sel_ArticuloHH"
txtCodigo.Width = 150
txtCodigo.Name = "txtCodigo"
txtDescripcion.Left = 156
txtDescripcion.Top = 2
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: opg_salida
************************************************************
*** PROPIEDADES ***
ButtonCount = 3
BackStyle = 0
Value = 1
Height = 30
Left = 468
Top = 5
Width = 231
TabIndex = 3
Name = "opg_salida"
Option1.FontSize = 8
Option1.BackStyle = 0
Option1.Caption = "Impresión"
Option1.Value = 1
Option1.Height = 15
Option1.Left = 13
Option1.Top = 8
Option1.Width = 94
Option1.ForeColor = 158,106,75
Option1.BackColor = 244,244,244
Option1.Name = "Option1"
Option2.FontSize = 8
Option2.BackStyle = 0
Option2.Caption = "Pantalla"
Option2.Value = 0
Option2.Height = 15
Option2.Left = 99
Option2.Top = 9
Option2.Width = 65
Option2.ForeColor = 158,106,75
Option2.BackColor = 244,244,244
Option2.Name = "Option2"
Option3.FontBold = .T.
Option3.FontSize = 8
Option3.BackStyle = 0
Option3.Caption = "Excel"
Option3.Height = 17
Option3.Left = 171
Option3.Top = 9
Option3.Width = 50
Option3.ForeColor = 158,106,75
Option3.BackColor = 244,244,244
Option3.Name = "Option3"

*** METODOS ***


************************************************************
OBJETO: cmbTipoMov
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 23
Left = 244
TabIndex = 5
Top = 84
Visible = .T.
Width = 100
Name = "cmbTipoMov"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta15
************************************************************
*** PROPIEDADES ***
Caption = "Tipo Mov.:"
Height = 15
Left = 182
Top = 90
Width = 56
TabIndex = 24
Name = "Clsetiqueta15"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta16
************************************************************
*** PROPIEDADES ***
Caption = "Usuario:"
Height = 15
Left = 351
Top = 89
Width = 56
TabIndex = 24
Name = "Clsetiqueta16"

*** METODOS ***


************************************************************
OBJETO: cmbUsuarios
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 23
Left = 401
TabIndex = 6
Top = 84
Width = 100
Name = "cmbUsuarios"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta17
************************************************************
*** PROPIEDADES ***
Caption = "Salida por:"
Height = 15
Left = 401
Top = 14
Width = 84
TabIndex = 24
Name = "Clsetiqueta17"

*** METODOS ***


************************************************************
OBJETO: Clslinea1
************************************************************
*** PROPIEDADES ***
Height = 1
Left = 8
Top = 148
Width = 687
Name = "Clslinea1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta18
************************************************************
*** PROPIEDADES ***
Caption = "Tipo de listado:"
Height = 15
Left = 12
Top = 43
Width = 84
TabIndex = 23
Name = "Clsetiqueta18"

*** METODOS ***


************************************************************
OBJETO: mov_stock
************************************************************
*** PROPIEDADES ***
Top = 460
Left = 279
Height = 17
Width = 56
Name = "mov_stock"

*** METODOS ***


************************************************************
OBJETO: btnCancelar
************************************************************
*** PROPIEDADES ***
Top = 447
Left = 4
Height = 44
Width = 45
TabIndex = 21
Name = "btnCancelar"

*** METODOS ***
PROCEDURE Click
Thisform.blanquear()
ENDPROC


************************************************************
OBJETO: Clscerrar1
************************************************************
*** PROPIEDADES ***
Top = 447
Left = 665
Height = 44
Width = 45
TabIndex = 20
Name = "Clscerrar1"

*** METODOS ***


************************************************************
OBJETO: Clsaceptar1
************************************************************
*** PROPIEDADES ***
Top = 447
Left = 618
TabIndex = 19
Name = "Clsaceptar1"

*** METODOS ***
PROCEDURE Click
LOCAL ldFecDD, ldFecHH
LOCAL lnIdProvDD, lnIdProvHH
LOCAL lnIdFamiliaDD, lnIdFamiliaHH
LOCAL lnIdSubFamDD, lnIdSubFamHH
LOCAL lnIdStkDepDD, lnIdStkDepHH
LOCAL lnIdMarcaDD, lnIdMarcaHH
LOCAL lnIdArticuloDD, lnIdArticuloHH
LOCAL loForm
LOCAL lcTipoMov, lcUsuario

&& Datos del Reporte
LOCAL proveedorDesde, proveedorHasta
LOCAL familiaDesde, familiaHasta
LOCAL subFamDesde, subFamHasta
LOCAL depostioDesde, depositoHasta
LOCAL marcaDesde, marcaHasta

ldFecDD = {}
ldFecHH = {}
lnIdProvDD = 0
lnIdProvHH = 0
lnIdFamiliaDD = 0
lnIdFamiliaHH = 0
lnIdSubFamDD = 0
lnIdSubFamHH = 0
lnIdStkDepDD = 0
lnIdStkDepHH = 0
lnIdMarcaDD = 0
lnIdMarcaHH = 0
lnIdArticuloDD = 0
lnIdArticuloHH = 0

proveedorDesde = ""
proveedorHasta = ""
familiaDesde = ""
familiaHasta = ""
subFamDesde = ""
subFamHasta = ""
depositoDesde = ""
depositoHasta = ""
marcaDesde = ""
marcaHasta = ""

IF Thisform.contenido.selProvDD.valcpoid <> 0 .AND. Thisform.contenido.sel_provHH.valcpoid <> 0 THEN
	lnIdProvDD = Thisform.contenido.selProvDD.valcpoid
	lnIdProvHH = Thisform.contenido.sel_ProvHH.valcpoid
	proveedorDesde = Thisform.contenido.selProvDD.txtDescripcion.Value
	proveedorHasta = Thisform.contenido.sel_ProvHH.txtDescripcion.Value
ENDIF

IF Thisform.contenido.sel_MarcaDD.valcpoid <> 0 .AND. Thisform.contenido.sel_MarcaHH.valcpoid <> 0 THEN
	lnIdMarcaDD = Thisform.contenido.sel_MarcaDD.valcpoid
	lnIdMarcaHH = THisform.contenido.sel_MarcaHH.valcpoid
	marcaDesde = Thisform.contenido.sel_MarcaDD.txtDescripcion.Value
	marcaHasta = Thisform.contenido.sel_marcaHH.txtDescripcion.Value
ENDIF

IF Thisform.contenido.sel_familiaDD.valcpoid <> 0 .AND. Thisform.contenido.sel_FamiliaHH.valcpoid <> 0 THEN
	lnIdFamiliaDD = Thisform.contenido.sel_FamiliaDD.valcpoid
	lnIdFamiliaHH = Thisform.contenido.sel_familiaHH.valcpoid
	familiaDesde = Thisform.contenido.sel_FamiliaDD.txtDescripcion.Value
	familiaHasta = Thisform.contenido.sel_FamiliaHH.txtDescripcion.Value
ENDIF

IF Thisform.contenido.sel_SubFamDD.valcpoid <> 0 .AND. Thisform.contenido.sel_subFamHH.valcpoid <> 0 THEN
	lnIdSubFamDD = Thisform.contenido.sel_SubFamDD.valcpoid
	lnIdSubFamHH = Thisform.contenido.sel_SubFamHH.valcpoid
	subFamDesde = Thisform.contenido.sel_SubFamDD.txtDescripcion.Value
	subFamHasta = Thisform.contenido.sel_SubFamHH.txtDescripcion.Value
ENDIF

IF Thisform.contenido.sel_DepositoDD.valcpoid <> 0 .AND. Thisform.contenido.sel_DepositoHH.valcpoid <> 0 THEN
	lnIdStkDepDD = Thisform.contenido.sel_depositoDD.valcpoid
	lnIdStkDepHH = Thisform.contenido.sel_DepositoHH.valcpoid
	depositoDesde = Thisform.contenido.sel_DepositoDD.txtDescripcion.Value
	depositoHasta = Thisform.contenido.sel_DepositoHH.txtDescripcion.Value
ENDIF

IF Thisform.contenido.sel_ArticuloDD.valcpoid <> 0 .AND. Thisform.contenido.sel_ArticuloHH.valcpoid <> 0 THEN
	lnIdArticuloDD = Thisform.Contenido.sel_ArticuloDD.valcpoid
	lnIdArticuloHH = Thisform.Contenido.sel_ArticuloHH.valcpoid
ENDIF

ldFecDD = Thisform.contenido.txtFecDesde.Value
ldFecHH = Thisform.contenido.txtFecHasta.Value

lcTipoMov = Thisform.contenido.cmbTipoMov.Value
lcUsuario = Thisform.contenido.cmbusuarios.Value

IF Thisform.contenido.opgStock.option1.Value = 1 THEN
	&& Emite el listado de existencia de Stock
	IF !Thisform.mov_stock.getexistencia(ldFecDD, ldFecHH, lnIdProvDD, lnIdProvHH, lnIdFamiliaDD, ;
			lnIdFamiliaHH, lnIdSubFamDD, lnIdSubFamHH, lnIdStkDepDD, lnIdStkDepHH, lnIdMarcaDD, lnIdMarcaHH, lnIdArticuloDD, lnIdArticuloHH) THEN
		MESSAGEBOX(Thisform.mov_stock.errorMessage, 0+48, Thisform.Caption)
		RETURN .F.	
	ENDIF
	
	IF Thisform.Contenido.opg_salida.option1.Value = 1 THEN
		SELECT cur_MovStock	
		REPORT FORM "repexistencia" TO PRINTER PROMPT PREVIEW 
	ELSE
		IF Thisform.Contenido.opg_salida.option2.Value = 1 THEN
			loForm = CREATEOBJECT("cl_movstock")
			loForm.tipo_listado = 0
			loForm.leer_datos()
			loForm.Show()
		ELSE 
			Thisform.exportar_excel()
		ENDIF 
	ENDIF
ELSE 
	&& Emito el listado de movimientos de stock
	IF Thisform.contenido.opgStock.option2.Value = 1 THEN
		IF !Thisform.mov_stock.getmovs(ldFecDD, ldFecHH, lnIdProvDD, lnIdProvHH, lnIdFamiliaDD, lnIdFamiliaHH, lnIdSubFamDD, lnIdSubFamHH, ;
				lnIdStkDepDD, lnIdStkDepHH, lnIdMarcaDD, lnIdMarcaHH, lnIdArticuloDD, lnIdArticuloHH, lcTipoMov, lcUsuario) THEN
			MESSAGEBOX(Thisform.mov_stock.errorMessage, 0+48, Thisform.Caption)
			RETURN .F.
		ENDIF
		
		IF Thisform.contenido.opg_salida.option1.Value = 1 THEN
			SELECT cur_movstock
			REPORT FORM "repmovstock" TO PRINTER PROMPT PREVIEW 
		ELSE
			IF Thisform.Contenido.opg_salida.option2.Value = 1 THEN
				loForm = CREATEOBJECT("cl_movstock")
				loForm.tipo_listado = 1
				loForm.leer_datos()
				loForm.Show()		
			ELSE 
				Thisform.exportar_excel()
			ENDIF 
		ENDIF
	ELSE
		&& Emito el listado del stock valorizado
		IF !Thisform.mov_stock.get_stkval(ldFecDD, ldFecHH, lnIdProvDD, lnIdProvHH, lnIdFamiliaDD, lnIdFamiliaHH, lnIdSubFamDD, lnIdSubFamHH,;
				lnIdStkDepDD, lnIdStkDepHH, lnIdMarcaDD, lnIdMarcaHH, lnIdArticuloDD, lnIdArticuloHH) THEN
			MESSAGEBOX(Thisform.mov_Stock.errorMessage, 0+48, Thisform.Caption)
			RETURN .F.
		ENDIF
		
		IF Thisform.contenido.opg_salida.option1.value = 1 THEN
			SELECT cur_MovStock
			REPORT FORM "repstockvalorizado" TO PRINTER PROMPT PREVIEW 
		ELSE
			IF Thisform.Contenido.opg_salida.option2.Value = 1 THEN
				loForm = CREATEOBJECT("cl_movstock")
				loForm.tipo_listado = 2
				loForm.leer_datos()
				loForm.Show()	
			ELSE 
				Thisform.exportar_excel()
			ENDIF 
		ENDIF
	ENDIF
ENDIF

RETURN .T.
ENDPROC


************************************************************
OBJETO: cl_cons_stk
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: cltr_fisico
************************************************************
*** PROPIEDADES ***
Height = 511
Width = 960
DoCreate = .T.
Caption = "Control Físico de Mercadería"
MaxButton = .T.
MinButton = .T.
MinHeight = 500
MinWidth = 400
WindowState = 2
numingreso = 0
idprov = 0
Name = "cltr_fisico"
contenido.Top = -1
contenido.Left = -1
contenido.Width = 961
contenido.Height = 574
contenido.TabIndex = 1
contenido.Name = "contenido"

*** METODOS ***
PROCEDURE recuperardatos
Thisform.oCtrlFisico.leer_rtos(thisform.numingreso)
ENDPROC
PROCEDURE Init
DODEFAULT()
Thisform.oCtrlFisico.crear_cursor_detalle()
Thisform.mov_stock.crear_cursor()

SELECT cur_rtos
Thisform.Contenido.grdArticulos.RecordSource = "cur_rtos"
Thisform.Contenido.grdArticulos.list_controlsource = "codArt,descripcio,nroPart,cbte,tipo,numero,cantidad,cantreci"
Thisform.Contenido.grdArticulos.lista_ancho_cols = "100,300,100,70,70,100,70,70"
Thisform.Contenido.grdArticulos.titulos_cabeceras = "Código,Descripción,Partida,Cbte.,Tipo,Número,Cantidad,Recibido"
Thisform.Contenido.grdArticulos.generar_grid()
* Thisform.Contenido.grdArticulos.Columns[7].ReadOnly = .F.
Thisform.Contenido.grdArticulos.Columns[8].ReadOnly = .F.
Thisform.Contenido.grdArticulos.Refresh()
ENDPROC


************************************************************
OBJETO: oCtrlFisico
************************************************************
*** PROPIEDADES ***
Top = 468
Left = 24
Height = 17
Width = 27
Name = "oCtrlFisico"

*** METODOS ***


************************************************************
OBJETO: mov_stock
************************************************************
*** PROPIEDADES ***
Top = 468
Left = 72
Height = 17
Width = 37
Name = "mov_stock"

*** METODOS ***


************************************************************
OBJETO: planificacion
************************************************************
*** PROPIEDADES ***
Top = 469
Left = 131
Height = 17
Width = 36
Name = "planificacion"

*** METODOS ***


************************************************************
OBJETO: grdArticulos
************************************************************
*** PROPIEDADES ***
Anchor = 15
Height = 445
Left = 7
TabIndex = 1
Top = 5
Width = 948
permitir_busqueda = .F.
permitir_ordenamiento = .F.
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
OBJETO: btnGrabar
************************************************************
*** PROPIEDADES ***
Top = 459
Left = 864
Anchor = 12
TabIndex = 4
Name = "btnGrabar"

*** METODOS ***
PROCEDURE Click
********************************************************************************
&& Agrego el detalle de los movimientos que hay que darle entrada al stock
********************************************************************************
LOCAL loForm, llArtSD

llArtSD = .F.

Thisform.mov_stock.circuito = "S"
Thisform.mov_stock.tipomov = "ENT"

SELECT cur_rtos
IF RECCOUNT("cur_rtos") > 0 THEN
	GO TOP
ENDIF

llArtSD = .F.
DO WHILE !EOF("cur_rtos")
	IF !Thisform.mov_stock.agregar_articulo(cur_rtos.idArticulo, cur_rtos.cantReci, cur_rtos.nroPart) THEN
		llArtSD = .T.
	ENDIF

	SELECT cur_rtos
	SKIP
ENDDO

&& Comento esta línea ya que la asignacion de deposito la hice automaticamente en el grabado 08/06/2017
*!*	IF llArtSD THEN
*!*		loForm = CREATEOBJECT("cl_art_sindep_viewer")
*!*		loForm.show()
*!*		RETURN .F.		
*!*	ENDIF

********************************************************************************
&& Grabo el control fisico
********************************************************************************
IF !thisform.oCtrlFisico.grabar() THEN
	MESSAGEBOX(Thisform.oCtrlFisico.ErrorMessage, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

********************************************************************************
&& Hago el grabado de los movimientos de stock
********************************************************************************
IF !Thisform.mov_stock.grabar(Thisform.idprov) THEN
	MESSAGEBOX(Thisform.mov_stock.ErrorMessage, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

********************************************************************************
&& Grabo el numero de movimiento de stock en la tabla de ingresos
********************************************************************************
IF !Thisform.oCtrlFisico.update_idstkcab(thisform.mov_stock.idstkcab) THEN
	MESSAGEBOX(Thisform.oCtrlFisico.ErrorMessage, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

********************************************************************************
&& Descuento el ingreso de los pendientes
********************************************************************************
IF !Thisform.planificacion.descontar_pend() THEN
	MESSAGEBOX(Thisform.oCtrlFisico.ErrorMessage, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

********************************************************************************
&& Mando el mail con las diferencias
********************************************************************************
IF getGlobalCFG("CTRFCO_MAI") THEN
	IF !Thisform.oCtrlFisico.Enviar_mail()
		MESSAGEBOX(Thisform.oCtrlFisico.ErrorMessage, 0+48, Thisform.Caption)
		RETURN .F.
	ENDIF
ENDIF

Thisform.oCtrlFisico.imprimir_diferencia()

MESSAGEBOX("Remito controlado con éxito!", 0+64, Thisform.Caption)

Thisform.mov_stock.limpiar()

Thisform.Release()

RETURN .T.
ENDPROC


************************************************************
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 459
Left = 910
Anchor = 12
TabIndex = 5
Name = "btnCerrar"

*** METODOS ***


************************************************************
OBJETO: btnRefresh
************************************************************
*** PROPIEDADES ***
Top = 459
Left = 771
Anchor = 12
TabIndex = 2
Visible = .F.
Name = "btnRefresh"

*** METODOS ***
PROCEDURE Click
Thisform.oCtrlFisico.leer_rtos()
Thisform.Contenido.grdArticulos.Refresh()

ENDPROC


************************************************************
OBJETO: btnImprimir
************************************************************
*** PROPIEDADES ***
Top = 459
Left = 817
Anchor = 12
TabIndex = 3
Name = "btnImprimir"

*** METODOS ***
PROCEDURE Click
SELECT cur_rtos
REPORT FORM "reprecepcion_mrcs" TO PRINTER PROMPT PREVIEW

ENDPROC


************************************************************
OBJETO: cltr_fisico
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: ing_movstock
************************************************************
*** PROPIEDADES ***
BorderStyle = 1
Height = 500
Width = 946
DoCreate = .T.
Caption = "Ingreso de Movimiento de Stock"
Name = "ing_movstock"
contenido.Top = -1
contenido.Left = -1
contenido.Width = 948
contenido.Height = 500
contenido.Name = "contenido"

*** METODOS ***
PROCEDURE cargar_tipomov
LOCAL loRes, lcSql

loRes = CREATEOBJECT("odbc_result")
lcSql = ""

lcSql = "SELECT tm.codmov "
lcSql = lcSql + " FROM stk_tipomov tm, accesos_tm"
lcSql = lcSql + " WHERE tm.idtipomov = accesos_tm.idtipomov " 
lcSql = lcSql + " 	AND accesos_tm.idUsuario = " + ALLTRIM(STR(gnUserID))

loRes.ActiveConnection = goConn.ActiveConnection
loRes.cursor_name = "cur_tipomov"
loRes.openquery(lcSql)

SELECT cur_tipomov
IF RECCOUNT("cur_tipomov") == 0 THEN 
	MESSAGEBOX("Usted no esta autorizado a realizar movimientos. Pónganse en contacto con el Administrador del Sistema.",0+16,thisform.Caption)
	RETURN .F.
ENDIF 

DO WHILE !EOF("cur_tipomov")
	SELECT cur_tipomov
	Thisform.contenido.cnt_ingreso.cmbTipoMov.AddItem(cur_tipomov.codmov)
	
	SELECT cur_tipomov
	SKIP
ENDDO 

loRes.close_query()

ENDPROC
PROCEDURE imp_xls
PARAMETERS lcRuta

LOCAL loExcel, lnFil, lnCol, lnPorcentaje, lcMensaje

lnPorcentaje = 0.00
loExcel = CREATEOBJECT("Excel.Application")
progressBar = CREATEOBJECT("_thermometer")
lcMensaje = ""

&& SELECT cur_xls
&& APPEND FROM (lcRuta) TYPE XLS

WITH loExcel.Application
	.visible = .F.
	.workbooks.open(lcRuta)
	lnCol = .ActiveSheet.UsedRange.Columns.Count
	lnFil = .ActiveSheet.UsedRange.Rows.Count
	progressBar.show()
	
	FOR i = 2 TO lnFil
		IF !ISNULL(.activesheet.cells(i, 5).value) THEN 
		
			SELECT cur_xls
			APPEND BLANK
				
			&& Levanto el codigo
			IF TYPE(".activesheet.cells(i, 2).value") == "C" THEN
				IF !(ALLTRIM(.activesheet.cells(i, 2).value) == "") THEN
					REPLACE Codigo WITH ALLTRIM(.activesheet.cells(i, 2).value)
				ELSE
					lcMensaje = "El Código no puede ser un vacío. Fila: " + ALLTRIM(STR(i))
					EXIT FOR 
				ENDIF
			ELSE
				IF ISNULL(.activesheet.cells(i, 2).value) THEN
					lcMensaje = "El Código no puede ser un valor nulo. Fila: " + ALLTRIM(STR(i))
					EXIT FOR 
				ELSE
					REPLACE Codigo WITH ALLTRIM(STR(.activesheet.cells(i, 2).value))
				ENDIF
			ENDIF
			
			&& Levanto la existencia en sistema 
			IF TYPE(".activesheet.cells(i, 4).value") == "C" THEN
				lcMensaje = "La cantidad en sistema debe ser un valor numérico. Fila: " + ALLTRIM(STR(i))
				EXIT FOR 
			ELSE
				IF ISNULL(.activesheet.cells(i, 4).value) THEN
					lcMensaje = "La cantidad en sistema no puede ser un valor nulo. Fila: " + ALLTRIM(STR(i))
					EXIT FOR 
				ELSE 
					IF (.activesheet.cells(i, 4).value) < 0 THEN 
						lcMensaje = "La cantidad en sistema no puede ser negativa. Fila: " + ALLTRIM(STR(i))
						EXIT FOR 
					ELSE 
						REPLACE Existencia WITH ROUND(.activesheet.cells(i, 4).value, 2)
					ENDIF 
				ENDIF
			ENDIF
			
			&& Levanto la cantidad contada
			IF TYPE(".activesheet.cells(i, 5).value") == "C" THEN
				lcMensaje = "La cantidad contada debe ser un valor numérico. Fila: " + ALLTRIM(STR(i))
				EXIT FOR 
			ELSE
				IF ISNULL(.activesheet.cells(i, 5).value) THEN
					lcMensaje = "La cantidad contada no puede ser un valor nulo. Fila: " + ALLTRIM(STR(i))
					EXIT FOR 
				ELSE 
					IF (.activesheet.cells(i, 5).value) < 0 THEN 
						lcMensaje = "La cantidad contada no puede ser negativa. Fila: " + ALLTRIM(STR(i))
						EXIT FOR 
					ELSE 
						REPLACE Cantidad WITH ROUND(.activesheet.cells(i, 5).value, 2)
					ENDIF 
				ENDIF
			ENDIF
			
			lnPorcentaje = (i * 100) / (lnFil - 2)
			WAIT WINDOW "Leyendo: " + STR(i) + " registro de " + STR(lnFil) NOWAIT 
			progressBar.update(lnPorcentaje)
		ENDIF 
	ENDFOR
	
	.workbooks.close()
	.quit
ENDWITH
MESSAGEBOX(lcMensaje, 0+48,Thisform.Caption)
IF lcMensaje != "" THEN 
	MESSAGEBOX(lcMensaje, 0+48,Thisform.Caption)
	.workbooks.close()
	.quit
	RELEASE loExcel
	
	SELECT cur_xls 
	ZAP 
	RETURN .F.
ENDIF 

progressBar.complete()
progressBar.release()

RELEASE loExcel

SELECT cur_xls
BROWSE 
IF RECCOUNT() > 0
	GO TOP
ELSE 
	MESSAGEBOX("El archivo se encuentra vacío",0+48,Thisform.Caption)
	RETURN .F.
ENDIF

RETURN .T.
ENDPROC
PROCEDURE validar_stk
LOCAL lnExistencia, lnCantidad

lnExistencia = 0.00
lnCantidad = 0.00

SELECT cur_stkdet
IF RECCOUNT("cur_stkdet") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_stkdet")
	IF RIGHT(ALLTRIM(cur_stkdet.codArt), 3) != "ARX" THEN
		IF cur_stkdet.Cantidad < 0 THEN 	
			lnCantidad = cur_stkdet.Cantidad * -1
			
			lnExistencia = thisform.mov_stock.get_exist_byart(cur_stkdet.idArticulo)
			
			IF lnExistencia < lnCantidad THEN
				MESSAGEBOX("La cantidad de salida del artículo " + ALLTRIM(cur_stkdet.codart) + " no puede ser mayor al stock (" + ALLTRIM(STR(lnExistencia)) + "), por favor verifique la cantidad.", 0+16, "Control de Movimientos")
				RETURN .F.
			ENDIF
		ENDIF
	ENDIF
	
	SELECT cur_stkdet
	SKIP
ENDDO

SELECT cur_stkdet
IF RECCOUNT("cur_stkdet") > 0 THEN
	GO TOP
ENDIF

RETURN .T.


ENDPROC
PROCEDURE Init
DODEFAULT()

Thisform.Contenido.cnt_ingreso.cmbTipoMov.ListIndex = 1

Thisform.mov_Stock.crear_cursor()

SELECT cur_stkdet
Thisform.Contenido.grdDetalle.Permitir_busqueda = .F.
Thisform.Contenido.grdDetalle.Permitir_Ordenamiento = .F.
Thisform.Contenido.grdDetalle.RecordSource = "cur_stkdet"
Thisform.Contenido.grdDetalle.list_controlsource = "codArt,descripcio,razSoc,deposito,nroPart,cantidad"
Thisform.Contenido.grdDetalle.lista_ancho_cols = "100,300,150,150,100,70"
Thisform.Contenido.grdDetalle.titulos_cabeceras = "Codigo,Descripción,Proveedor,Depósito,Partida,Cantidad"
Thisform.Contenido.grdDetalle.generar_grid()

IF !Thisform.cargar_tipomov()
	Thisform.contenido.Enabled = .F.
	Thisform.Release()
ENDIF 


ENDPROC
PROCEDURE Load
DODEFAULT()

CREATE CURSOR cur_xls (		;
	idArticulo	int				,;
	Codigo		C(20)			,;
	Existencia	Float(10,2)		,;
	Cantidad	Float(10,2))


SELECT cur_xls

ENDPROC


************************************************************
OBJETO: mov_stock
************************************************************
*** PROPIEDADES ***
Top = 468
Left = 168
Height = 17
Width = 24
Name = "mov_stock"

*** METODOS ***


************************************************************
OBJETO: cnt_ingreso
************************************************************
*** PROPIEDADES ***
Top = 6
Left = 6
Width = 937
Height = 82
BackStyle = 1
BackColor = 237,218,205
Name = "cnt_ingreso"

*** METODOS ***


************************************************************
OBJETO: CLSETIQUETA1
************************************************************
*** PROPIEDADES ***
Caption = "Artículo:"
Height = 15
Left = 191
Top = 15
Width = 49
TabIndex = 7
Name = "CLSETIQUETA1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Cantidad:"
Height = 17
Left = 777
Top = 14
Width = 52
TabIndex = 9
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: sel_Articulo
************************************************************
*** PROPIEDADES ***
Top = 9
Left = 239
Width = 534
Height = 25
TabIndex = 2
autocompletar_ceros = .F.
nombre_campo_codigo = codArt
nombre_campo_desc = descripcio
nombre_tabla = articulos
pkfield = idArticulo
Name = "sel_Articulo"
txtCodigo.Width = 150
txtCodigo.Name = "txtCodigo"
txtDescripcion.Left = 156
txtDescripcion.Top = 2
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***
PROCEDURE recuperar_datos
IF !EMPTY(This.txtCodigo.Value)
	Thisform.contenido.cnt_ingreso.txtStock.Value = thisform.mov_stock.get_exist_byart(Thisform.contenido.cnt_ingreso.sel_articulo.valcpoid)
ELSE 
	Thisform.contenido.cnt_ingreso.txtStock.Value = 0.00
ENDIF 
ENDPROC
PROCEDURE txtCodigo.LostFocus
DODEFAULT()

IF EMPTY(This.Value) THEN 
	Thisform.contenido.cnt_ingreso.txtStock.Value = 0.00
ENDIF 
ENDPROC


************************************************************
OBJETO: txtCantidad
************************************************************
*** PROPIEDADES ***
Left = 831
TabIndex = 3
Top = 9
Width = 100
isinteger = .F.
isnumeric = .T.
Name = "txtCantidad"

*** METODOS ***


************************************************************
OBJETO: btnAgregar
************************************************************
*** PROPIEDADES ***
Top = 35
Left = 842
Height = 44
Width = 45
Picture = ..\imagen\iconos bajados\agregar-editar-icono-6607.ico
TabIndex = 5
Name = "btnAgregar"

*** METODOS ***
PROCEDURE Click
LOCAL lnExistencia, loRes, lcSql

lnExistencia = 0.00
loRes = CREATEOBJECT("odbc_result")
lcSql = ""

IF This.Parent.sel_Articulo.valcpoid = 0 THEN
	MESSAGEBOX("Debe ingresar al menos un artículo", 0+48, Thisform.Caption)
	This.Parent.sel_Articulo.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

IF Thisform.contenido.cnt_ingreso.cmbTipoMov.Value <> "AJU" THEN 
	IF This.Parent.txtCantidad.Value = 0 THEN
		MESSAGEBOX("La cantidad no puede ser cero", 0+48, Thisform.Caption)
		This.Parent.txtCantidad.SetFocus()
		RETURN .F.
	ENDIF
ENDIF 

IF This.Parent.txtCantidad.Value < 0 THEN
	MESSAGEBOX("La cantidad no puede ser negativa", 0+48, Thisform.Caption)
	This.Parent.txtCantidad.SetFocus()
	RETURN .F.
ENDIF

&& Verifico si el artículo ya se encuentra cargado
SELECT cur_stkdet
IF RECCOUNT() > 0
	GO TOP
ENDIF

SELECT cur_stkdet
DO WHILE !EOF()
	IF ALLTRIM(cur_stkdet.codArt) == ALLTRIM(Thisform.contenido.cnt_ingreso.sel_Articulo.txtCodigo.Value) THEN
		MESSAGEBOX("El artículo ya se encuentra cargado.",0+48, Thisform.Caption)
		Thisform.contenido.cnt_ingreso.sel_Articulo.txtCodigo.SetFocus()

		RETURN .F.
	ENDIF

	SELECT cur_stkdet
	SKIP
ENDDO

&& Busco el tipo de movimiento para poder validar si el movimiento es negativo que no supere el stock
lcSql = "SELECT * FROM stk_tipomov WHERE codMov = '" + Thisform.contenido.cnt_ingreso.cmbTipoMov.Value + "'"

loRes.ActiveConnection = goConn.ActiveConnection
loRes.cursor_name = "tipomov"
loRes.openquery(lcSql)

IF tipomov.signo = -1 THEN 	
	lnExistencia = thisform.mov_stock.get_exit_byartpart(Thisform.contenido.cnt_ingreso.sel_articulo.valcpoid, ALLTRIM(Thisform.contenido.cnt_ingreso.txtNroPart.Value))
	
	IF lnExistencia < Thisform.contenido.cnt_ingreso.txtCantidad.Value THEN
		MESSAGEBOX("La cantidad de salida no puede ser mayor a la existencia del artículo, por favor, verifique la cantidad", 0+48, Thisform.Caption)
		This.Parent.txtCantidad.SetFocus()
		RETURN .F.
	ENDIF
ENDIF

loRes.close_query()

Thisform.mov_stock.tipomov = Thisform.Contenido.cnt_ingreso.cmbTipoMov.Value

&& Agrego el mov del articulo.
IF !Thisform.mov_stock.agregar_articulo(This.Parent.sel_Articulo.valcpoid, This.Parent.txtCantidad.Value, Thisform.contenido.cnt_ingreso.txtNroPart.Value) THEN
	MESSAGEBOX(Thisform.mov_Stock.ErrorMessage, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

Thisform.Contenido.grdDetalle.Refresh()
Thisform.Contenido.cnt_Ingreso.sel_Articulo.Blanquear()
Thisform.Contenido.cnt_Ingreso.txtCantidad.blanquear()
Thisform.Contenido.cnt_ingreso.sel_Articulo.txtCodigo.SetFocus()
Thisform.Contenido.cnt_Ingreso.txtNroPart.blanquear()
Thisform.contenido.cnt_ingreso.txtStock.blanquear()

RETURN .T.

ENDPROC


************************************************************
OBJETO: btnEliminar
************************************************************
*** PROPIEDADES ***
Top = 35
Left = 887
Height = 44
Width = 45
TabIndex = 6
Name = "btnEliminar"

*** METODOS ***
PROCEDURE Click
LOCAL lnResp

lnResp = MESSAGEBOX("Está seguro que desea eliminar este ítem?", 0+4, Thisform.Caption)

IF lnResp = 6 THEN
	SELECT cur_stkdet
	DELETE 

	Thisform.contenido.grdDetalle.Refresh()
ENDIF 
ENDPROC


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Tipo Mov.:"
Height = 15
Left = 8
Top = 14
Width = 73
TabIndex = 10
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: cmbTipoMov
************************************************************
*** PROPIEDADES ***
Height = 23
Left = 80
TabIndex = 1
Top = 9
Width = 100
Name = "cmbTipoMov"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Nro. Partida:"
Height = 15
Left = 9
Top = 39
Width = 71
TabIndex = 8
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: txtNroPart
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 80
MaxLength = 30
TabIndex = 4
Top = 35
Width = 158
ischaracter = .T.
Name = "txtNroPart"

*** METODOS ***


************************************************************
OBJETO: btnImportar
************************************************************
*** PROPIEDADES ***
Top = 35
Left = 778
Picture = ..\imagen\iconos bajados\descargar-caja-de-madera-icono-5941.ico
ToolTipText = "Descargar desde Excel"
Name = "btnImportar"

*** METODOS ***
PROCEDURE Click
LOCAL lcRuta

lcRuta = GETFILE("XLS")

SELECT cur_xls
ZAP

SELECT cur_stkdet
ZAP

IF ALLTRIM(lcRuta) == ""
	MESSAGEBOX("Seleccione la ruta del archivo",0+48,Thisform.Caption)
	RETURN .F.
ELSE 
	IF !Thisform.imp_xls(lcRuta) THEN 
		RETURN .F.
	ENDIF 
ENDIF

&& Paso lo que se levanto desde el excel a la grilla.

Thisform.contenido.grdDetalle.Refresh()


ENDPROC


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Stock:"
Height = 17
Left = 251
Top = 39
Width = 37
TabIndex = 9
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: txtStock
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Left = 291
TabIndex = 3
Top = 35
Width = 100
isinteger = .F.
isnumeric = .T.
Name = "txtStock"

*** METODOS ***


************************************************************
OBJETO: grdDetalle
************************************************************
*** PROPIEDADES ***
Height = 360
Left = 5
Top = 90
Width = 938
Name = "grdDetalle"
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
OBJETO: btnGrabar
************************************************************
*** PROPIEDADES ***
Top = 452
Left = 851
Height = 44
Width = 45
Name = "btnGrabar"

*** METODOS ***
PROCEDURE Click
Thisform.mov_stock.circuito = "S"

IF !Thisform.validar_stk() THEN 
	RETURN .F.
ENDIF 

IF !Thisform.mov_stock.generar_cbtes() THEN
	MESSAGEBOX(Thisform.mov_stock.ErrorMessage, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

Thisform.mov_Stock.limpiar()

RETURN .T.

ENDPROC


************************************************************
OBJETO: btnCancelar
************************************************************
*** PROPIEDADES ***
Top = 452
Left = 5
Height = 44
Width = 45
Name = "btnCancelar"

*** METODOS ***
PROCEDURE Click
SELECT cur_xls
ZAP 

Thisform.mov_stock.limpiar()
Thisform.Contenido.cnt_ingreso.sel_Articulo.blanquear()
Thisform.Contenido.cnt_ingreso.txtCantidad.Value = 0.00
Thisform.contenido.cnt_ingreso.txtNroPart.Value = ""
Thisform.contenido.cnt_ingreso.txtStock.Value = 0.00
ENDPROC


************************************************************
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 452
Left = 898
Height = 44
Width = 45
Name = "btnCerrar"

*** METODOS ***


************************************************************
OBJETO: ing_movstock
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cl_movstock
************************************************************
*** PROPIEDADES ***
DataSession = 1
Height = 464
Width = 1065
DoCreate = .T.
BorderStyle = 3
Caption = "Consulta de Stock"
MaxButton = .T.
MinButton = .T.
MaxWidth = -1
MinHeight = 400
MinWidth = 400
WindowType = 1
tipo_listado = 0
Name = "cl_movstock"
contenido.Top = -1
contenido.Left = -1
contenido.Width = 1066
contenido.Height = 574
contenido.Name = "contenido"

*** METODOS ***
PROCEDURE leer_datos
SELECT cur_MovStock
Thisform.Contenido.grdStock.alias_name = "cur_MovStock"
Thisform.Contenido.grdStock.RecordSource = "cur_MovStock"

IF Thisform.tipo_listado = 0 THEN
	&& Existencia
	Thisform.Contenido.grdStock.list_controlsource = "codArt,descripcio,Existencia"
	Thisform.Contenido.grdStock.lista_ancho_cols = "100,300,100"
	Thisform.Contenido.grdStock.titulos_cabeceras = "Código,Descripción,Existencia"
	Thisform.Contenido.grdStock.generar_grid()
ELSE
	IF Thisform.tipo_listado = 1 THEN
		&& Detalle de Movimientos
		Thisform.Contenido.grdStock.list_controlsource = "circuito,fecalta,idCliente,rsCli,cbte,tipoDoc,numCbte,codArt,descripcio,entrada,salida"
		Thisform.Contenido.grdStock.lista_ancho_cols = "50,150,70,150,50,50,100,100,150,70,70"	
		Thisform.Contenido.grdStock.titulos_cabeceras = "Circ.,Fecha,Cliente,Raz. Soc.,Cbte,Letra,Número,Código,Descripción,Entrada,Salida"
		Thisform.Contenido.grdStock.generar_grid()
	ELSE
		&& Stock Valorizado
		Thisform.Contenido.grdStock.list_controlsource = "codArt,descripcio,stock,costo,stkval"
		Thisform.Contenido.grdStock.lista_ancho_cols = "150,400,70,70,100"
		Thisform.Contenido.grdStock.titulos_cabeceras = "Código,Descripción,Stock,Costo,Stock Valorizado"
		Thisform.Contenido.grdStock.generar_grid()
	ENDIF
ENDIF
ENDPROC
PROCEDURE Load
DODEFAULT()
ENDPROC
PROCEDURE Init
DODEFAULT()


ENDPROC


************************************************************
OBJETO: grdStock
************************************************************
*** PROPIEDADES ***
Height = 411
Left = 4
Top = 4
Width = 1060
permitir_busqueda = .F.
permitir_ordenamiento = .F.
alias_name = 
Name = "grdStock"
COLUMN1.HEADER1.Name = "HEADER1"
COLUMN1.TEXT1.Name = "TEXT1"
COLUMN1.Name = "COLUMN1"
COLUMN2.HEADER1.Name = "HEADER1"
COLUMN2.TEXT1.Name = "TEXT1"
COLUMN2.Name = "COLUMN2"
COLUMN3.HEADER1.Name = "HEADER1"
COLUMN3.TEXT1.Name = "TEXT1"
COLUMN3.Name = "COLUMN3"
COLUMN4.HEADER1.Name = "HEADER1"
COLUMN4.TEXT1.Name = "TEXT1"
COLUMN4.Name = "COLUMN4"
COLUMN5.HEADER1.Name = "HEADER1"
COLUMN5.TEXT1.Name = "TEXT1"
COLUMN5.Name = "COLUMN5"
COLUMN6.HEADER1.Name = "HEADER1"
COLUMN6.TEXT1.Name = "TEXT1"
COLUMN6.Name = "COLUMN6"
COLUMN7.HEADER1.Name = "HEADER1"
COLUMN7.TEXT1.Name = "TEXT1"
COLUMN7.Name = "COLUMN7"
COLUMN8.HEADER1.Name = "HEADER1"
COLUMN8.TEXT1.Name = "TEXT1"
COLUMN8.Name = "COLUMN8"
COLUMN9.HEADER1.Name = "HEADER1"
COLUMN9.TEXT1.Name = "TEXT1"
COLUMN9.Name = "COLUMN9"
COLUMN10.HEADER1.Name = "HEADER1"
COLUMN10.TEXT1.Name = "TEXT1"
COLUMN10.Name = "COLUMN10"
COLUMN11.HEADER1.Alignment = 2
COLUMN11.HEADER1.Name = "HEADER1"
COLUMN11.TEXT1.Name = "TEXT1"
COLUMN11.Name = "COLUMN11"
COLUMN12.HEADER1.Name = "HEADER1"
COLUMN12.TEXT1.Name = "TEXT1"
COLUMN12.Name = "COLUMN12"
COLUMN13.HEADER1.Name = "HEADER1"
COLUMN13.TEXT1.Name = "TEXT1"
COLUMN13.Name = "COLUMN13"
COLUMN14.HEADER1.Name = "HEADER1"
COLUMN14.TEXT1.Name = "TEXT1"
COLUMN14.Name = "COLUMN14"
COLUMN15.HEADER1.Name = "HEADER1"
COLUMN15.TEXT1.Name = "TEXT1"
COLUMN15.Name = "COLUMN15"
COLUMN16.HEADER1.Name = "HEADER1"
COLUMN16.TEXT1.Name = "TEXT1"
COLUMN16.Name = "COLUMN16"
COLUMN17.HEADER1.Name = "HEADER1"
COLUMN17.TEXT1.Name = "TEXT1"
COLUMN17.Name = "COLUMN17"
COLUMN18.HEADER1.Name = "HEADER1"
COLUMN18.TEXT1.Name = "TEXT1"
COLUMN18.Name = "COLUMN18"
COLUMN19.HEADER1.Name = "HEADER1"
COLUMN19.TEXT1.Name = "TEXT1"
COLUMN19.Name = "COLUMN19"
COLUMN20.HEADER1.Name = "HEADER1"
COLUMN20.TEXT1.Name = "TEXT1"
COLUMN20.Name = "COLUMN20"

*** METODOS ***


************************************************************
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 418
Left = 1018
Name = "btnCerrar"

*** METODOS ***


************************************************************
OBJETO: cl_movstock
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


