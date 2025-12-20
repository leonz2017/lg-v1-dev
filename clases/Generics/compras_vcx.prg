************************************************************
OBJETO: cls_form_consartoc
************************************************************
*** PROPIEDADES ***
Height = 390
Width = 900
DoCreate = .T.
Caption = "Consulta de Ordenes de Compra por Artículo"
WindowType = 0
Name = "cls_form_consartoc"

*** METODOS ***
PROCEDURE buscar
LOCAL  lnIdArticulo, lcFecDesde, lcFecHasta, lnEnt
LOCAL loDateTime 

IF ALLTRIM(thisform.contenedor1.sel_articulo.txtCodigo.Value) == "" THEN 
	MESSAGEBOX("Debe ingresar el Artículo", 0+48, Thisform.Caption)
	Thisform.contenedor1.sel_articulo.txtCodigo.SetFocus()
	RETURN .F.
ENDIF 

loDateTime = CREATEOBJECT("datetime")
lnIdArticulo = Thisform.contenedor1.sel_articulo.valcpoid
lcFecDesde = loDateTime.toMySql(thisform.contenedor1.txtFecDesde.Value)
lcFecHasta = loDateTime.toMySql(thisform.contenedor1.txtFecHasta.Value)
lnEnt = thisform.contenedor1.chkEntreg.Value

Thisform.oc.consultar_ocart(lnIdArticulo, lcFecDesde, lcFecHasta, lnEnt)

thisform.contenedor1.grdCab.Refresh()

SELECT cur_ocart
IF RECCOUNT("cur_ocart") = 0 THEN 
	MESSAGEBOX("No hay registros para mostrar",0+48,thisform.Caption)
	
	Thisform.contenedor1.sel_articulo.txtcodigo.SetFocus()
	thisform.oc.limpiar()
ENDIF 


ENDPROC
PROCEDURE blanquear
thisform.contenedor1.sel_articulo.blanquear()
thisform.contenedor1.sel_articulo.valcpoid = 0
thisform.contenedor1.txtFecDesde.Value = DATE() - 30
thisform.contenedor1.txtFecHasta.Value = DATE()
thisform.contenedor1.chkEntreg.Value = 0
thisform.contenedor1.sel_articulo.txtcodigo.SetFocus()

SELECT cur_ocart
ZAP

thisform.contenedor1.grdCab.Refresh()

ENDPROC
PROCEDURE Init
DODEFAULT()

thisform.contenedor1.sel_articulo.txtcodigo.SetFocus()
thisform.contenedor1.txtFecDesde.Value = DATE() - 30
thisform.contenedor1.txtFecHasta.Value = DATE()

Thisform.oc.crear_cursor()

SELECT cur_ocart
Thisform.contenedor1.grdCab.RecordSource = "cur_ocart"
Thisform.contenedor1.grdCab.list_controlsource = "idOcCab,idPcCab,Fecha,Fecent,cantped,cantrec,pendiente,costo,prlista,activo"
Thisform.contenedor1.grdCab.lista_ancho_cols = "60,60,125,125,70,70,70,70,70,70"
Thisform.contenedor1.grdCab.titulos_cabeceras = "N° OC,N° Planif.,Fecha,Fec. Ent.,Cant. Ped.,Cant. Rec.,Pendiente,Costo,Pr. Lista,Activo"
Thisform.contenedor1.grdCab.generar_grid()
Thisform.contenedor1.grdCab.Refresh()
ENDPROC


************************************************************
OBJETO: Contenedor1
************************************************************
*** PROPIEDADES ***
Top = 0
Left = 0
Width = 900
Height = 390
TabIndex = 12
BackColor = 241,236,235
Name = "Contenedor1"

*** METODOS ***


************************************************************
OBJETO: btnSalir
************************************************************
*** PROPIEDADES ***
Top = 343
Left = 852
TabIndex = 8
Name = "btnSalir"

*** METODOS ***


************************************************************
OBJETO: btnBuscar
************************************************************
*** PROPIEDADES ***
Top = 8
Left = 597
TabIndex = 5
Name = "btnBuscar"

*** METODOS ***
PROCEDURE Click
thisform.buscar()
ENDPROC


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Artículo:"
Height = 15
Left = 11
Top = 14
Width = 53
TabIndex = 15
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clscancelar1
************************************************************
*** PROPIEDADES ***
Top = 343
Left = 3
TabIndex = 9
Name = "Clscancelar1"

*** METODOS ***
PROCEDURE Click
thisform.blanquear()
ENDPROC


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Fecha Desde:"
Height = 15
Left = 10
Top = 38
Width = 84
TabIndex = 15
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta6
************************************************************
*** PROPIEDADES ***
Caption = "Fecha Hasta:"
Height = 15
Left = 197
Top = 38
Width = 84
TabIndex = 16
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: txtFecDesde
************************************************************
*** PROPIEDADES ***
Left = 89
TabIndex = 2
Top = 34
isdatetime = .T.
Name = "txtFecDesde"

*** METODOS ***


************************************************************
OBJETO: txtFecHasta
************************************************************
*** PROPIEDADES ***
Left = 270
TabIndex = 3
Top = 34
isdatetime = .T.
Name = "txtFecHasta"

*** METODOS ***


************************************************************
OBJETO: chkEntreg
************************************************************
*** PROPIEDADES ***
Top = 36
Left = 387
Height = 18
Width = 83
Alignment = 0
Caption = "Pendiente"
TabIndex = 4
Name = "chkEntreg"

*** METODOS ***


************************************************************
OBJETO: grdCab
************************************************************
*** PROPIEDADES ***
Height = 282
Left = 3
TabIndex = 6
Top = 59
Width = 894
Name = "grdCab"
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
COLUMN9.CurrentControl = "TEXT1"
COLUMN9.Sparse = .T.
COLUMN9.Name = "COLUMN9"
COLUMN10.HEADER1.Name = "HEADER1"
COLUMN10.TEXT1.Name = "TEXT1"
COLUMN10.CurrentControl = "chkActivo"
COLUMN10.Sparse = .F.
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
OBJETO: chkActivo
************************************************************
*** PROPIEDADES ***
Top = 24
Left = 10
Alignment = 0
Centered = .T.
Caption = ""
Name = "chkActivo"

*** METODOS ***


************************************************************
OBJETO: sel_Articulo
************************************************************
*** PROPIEDADES ***
Top = 8
Left = 62
Width = 534
Height = 25
TabIndex = 1
autocompletar_ceros = .F.
nombre_campo_codigo = codArt
nombre_campo_desc = descripcio
nombre_tabla = articulos
pkfield = idArticulo
Name = "sel_Articulo"
TXTCODIGO.Width = 150
TXTCODIGO.Name = "TXTCODIGO"
TXTDESCRIPCION.Left = 156
TXTDESCRIPCION.Top = 2
TXTDESCRIPCION.Name = "TXTDESCRIPCION"

*** METODOS ***


************************************************************
OBJETO: btnExcel
************************************************************
*** PROPIEDADES ***
Top = 343
Left = 806
TabIndex = 7
Name = "btnExcel"

*** METODOS ***
PROCEDURE Click
SELECT cur_ocArt
IF RECCOUNT() > 0
	genexcel("cur_ocArt","Ordenes de Compra - " + ALLTRIM(thisform.contenedor1.sel_Articulo.txtCodigo.Value))
ELSE 
	MESSAGEBOX("No hay registros para exportar",0+48,Thisform.Caption)
	RETURN
ENDIF 
ENDPROC


************************************************************
OBJETO: oc
************************************************************
*** PROPIEDADES ***
Top = 576
Left = 72
Height = 17
Width = 32
Name = "oc"

*** METODOS ***


************************************************************
OBJETO: cls_form_consartoc
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_form_bajapend
************************************************************
*** PROPIEDADES ***
BorderStyle = 2
Height = 610
Width = 850
DoCreate = .T.
Caption = "Baja de Pendientes de Ordenes de Compra"
Name = "cls_form_bajapend"
contenido.Width = 850
contenido.Height = 610
contenido.Name = "contenido"

*** METODOS ***
PROCEDURE blanquear
thisform.contenido.sel_prov.blanquear()
thisform.contenido.sel_prov.valcpoid = 0
thisform.contenido.sel_marca.blanquear()
thisform.contenido.sel_marca.valcpoid = 0
thisform.contenido.txtOcDesde.Value = 0
thisform.contenido.txtOcHasta.Value = 0
thisform.contenido.txtFecDesde.Value = DATE() - 30
thisform.contenido.txtFecHasta.Value = DATE()
thisform.contenido.sel_prov.SetFocus()

thisform.oc.limpiar()


ENDPROC
PROCEDURE Init
DODEFAULT()

thisform.contenido.sel_prov.SetFocus()
thisform.contenido.txtFecDesde.Value = DATE() - 30
thisform.contenido.txtFecHasta.Value = DATE()

Thisform.oc.crear_cursor()

SELECT cur_ocPend

thisform.contenido.grdarticulos.alias_name = "cur_ocPend"
thisform.contenido.grdarticulos.RecordSource = "cur_ocPend"
thisform.contenido.grdarticulos.list_controlsource = "sel,idOcCab,codArt,descripcio,fecha,fecent,cantped,cantrec,pendiente"
thisform.contenido.grdarticulos.lista_ancho_cols = "50,50,150,200,65,65,70,70,70"
thisform.contenido.grdarticulos.titulos_cabeceras = "Sel.,Nº OC,Código,Descripción,Fecha,Fec. Ent.,Cant. Ped.,Cant. Rec.,Pendiente"
thisform.contenido.grdarticulos.permitir_ordenamiento = .T.
thisform.contenido.grdarticulos.permitir_busqueda = .F.
thisform.contenido.grdarticulos.generar_grid()

ENDPROC
PROCEDURE buscar
LOCAL lnProv, lnMarca, lnOcDesde, lnOcHasta, lcFecDesde, lcFecHasta
LOCAL loDateTime 

loDateTime = CREATEOBJECT("datetime")
lnProv = Thisform.contenido.sel_prov.txtCodigo.Value
lnMarca = Thisform.contenido.sel_marca.txtCodigo.Value 
lnOcDesde = thisform.contenido.txtOcDesde.Value 
lnOcHasta = thisform.contenido.txtOcHasta.Value 
lcFecDesde = loDateTime.toMySql(thisform.contenido.txtFecDesde.Value)
lcFecHasta = loDateTime.toMySql(thisform.contenido.txtFecHasta.Value)

Thisform.oc.filtrar_pend(lnProv, lnMarca, lnOcDesde, lnOcHasta, lcFecDesde, lcFecHasta)

thisform.contenido.grdArticulos.Refresh()

SELECT cur_ocpend
IF RECCOUNT("cur_ocpend") = 0 THEN 
	MESSAGEBOX("No hay registros para mostrar",0+48,thisform.Caption)
	
	Thisform.contenido.sel_prov.txtcodigo.SetFocus()
	thisform.oc.limpiar()
ENDIF 

thisform.contenido.grdArticulos.Refresh()
ENDPROC


************************************************************
OBJETO: oc
************************************************************
*** PROPIEDADES ***
Top = 576
Left = 72
Height = 17
Width = 36
Name = "oc"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Proveedor:"
Height = 15
Left = 14
Top = 16
Width = 72
TabIndex = 13
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: sel_prov
************************************************************
*** PROPIEDADES ***
Top = 10
Left = 100
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
OBJETO: Clsetiqueta6
************************************************************
*** PROPIEDADES ***
Caption = "Marca:"
Height = 15
Left = 14
Top = 40
Width = 72
TabIndex = 17
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: sel_marca
************************************************************
*** PROPIEDADES ***
Top = 34
Left = 100
TabIndex = 2
autocompletar_ceros = .F.
esnumerico = .T.
nombre_campo_codigo = idMarca
nombre_campo_desc = descripcio
nombre_tabla = marcas
pkfield = idMarca
Name = "sel_marca"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: btnSalir
************************************************************
*** PROPIEDADES ***
Top = 562
Left = 800
TabIndex = 10
Name = "btnSalir"

*** METODOS ***


************************************************************
OBJETO: btnGrabar
************************************************************
*** PROPIEDADES ***
Top = 562
Left = 754
TabIndex = 9
Name = "btnGrabar"

*** METODOS ***
PROCEDURE Click
IF !Thisform.oc.grabar_pend() THEN
	RETURN
ENDIF

MESSAGEBOX("Los pendientes se dieron de baja con éxito",0+64, Thisform.Caption)

thisform.blanquear()
ENDPROC


************************************************************
OBJETO: btnCancelar
************************************************************
*** PROPIEDADES ***
Top = 561
Left = 4
TabIndex = 11
Name = "btnCancelar"

*** METODOS ***
PROCEDURE Click
thisform.blanquear()
ENDPROC


************************************************************
OBJETO: grdArticulos
************************************************************
*** PROPIEDADES ***
Height = 472
Left = 4
TabIndex = 8
Top = 87
Width = 842
Name = "grdArticulos"
COLUMN1.HEADER1.Name = "HEADER1"
COLUMN1.TEXT1.ReadOnly = .F.
COLUMN1.TEXT1.Name = "TEXT1"
COLUMN1.CurrentControl = "chkbaja"
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
OBJETO: chkbaja
************************************************************
*** PROPIEDADES ***
Top = 21
Left = 10
Alignment = 0
Centered = .T.
Caption = ""
ReadOnly = .F.
Name = "chkbaja"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "N° OC Desde:"
Height = 15
Left = 15
Top = 65
Width = 84
TabIndex = 15
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "N° OC Hasta:"
Height = 15
Left = 193
Top = 65
Width = 84
TabIndex = 16
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: txtOcDesde
************************************************************
*** PROPIEDADES ***
Left = 102
TabIndex = 3
Top = 61
Width = 80
isdatetime = .F.
isinteger = .T.
Name = "txtOcDesde"

*** METODOS ***


************************************************************
OBJETO: txtOcHasta
************************************************************
*** PROPIEDADES ***
Left = 264
TabIndex = 4
Top = 61
Width = 80
isdatetime = .F.
isinteger = .T.
Name = "txtOcHasta"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Fecha Desde:"
Height = 15
Left = 361
Top = 65
Width = 84
TabIndex = 15
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Fecha Hasta:"
Height = 15
Left = 548
Top = 65
Width = 84
TabIndex = 16
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: txtFecDesde
************************************************************
*** PROPIEDADES ***
Left = 440
TabIndex = 5
Top = 61
isdatetime = .T.
Name = "txtFecDesde"

*** METODOS ***


************************************************************
OBJETO: txtFecHasta
************************************************************
*** PROPIEDADES ***
Left = 621
TabIndex = 6
Top = 61
isdatetime = .T.
Name = "txtFecHasta"

*** METODOS ***


************************************************************
OBJETO: Clsbuscar1
************************************************************
*** PROPIEDADES ***
Top = 39
Left = 752
TabIndex = 7
Name = "Clsbuscar1"

*** METODOS ***
PROCEDURE Click
thisform.buscar()
ENDPROC


************************************************************
OBJETO: btnExcel
************************************************************
*** PROPIEDADES ***
Top = 562
Left = 708
Name = "btnExcel"

*** METODOS ***
PROCEDURE Click
SELECT cur_ocPend
IF RECCOUNT() > 0
	genexcel("cur_ocPend","Pendientes de Entrega")
ELSE 
	MESSAGEBOX("No hay registros para exportar",0+48,Thisform.Caption)
	RETURN
ENDIF 
ENDPROC


************************************************************
OBJETO: cls_form_bajapend
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_form_modplanif
************************************************************
*** PROPIEDADES ***
DataSession = 1
DoCreate = .T.
WindowType = 1
Name = "cls_form_modplanif"
contenido.Pages.ErasePage = .T.
contenido.Pages.Page1.Clsetiqueta1.Name = "Clsetiqueta1"
contenido.Pages.Page1.selProveedor.txtCodigo.Name = "txtCodigo"
contenido.Pages.Page1.selProveedor.txtDescripcion.Name = "txtDescripcion"
contenido.Pages.Page1.selProveedor.Name = "selProveedor"
contenido.Pages.Page1.grdSubRubros.COLUMN1.Header1.Name = "Header1"
contenido.Pages.Page1.grdSubRubros.COLUMN1.Text1.Name = "Text1"
contenido.Pages.Page1.grdSubRubros.COLUMN1.CLSCHECKBOX1.Alignment = 0
contenido.Pages.Page1.grdSubRubros.COLUMN1.CLSCHECKBOX1.Name = "CLSCHECKBOX1"
contenido.Pages.Page1.grdSubRubros.COLUMN1.Name = "COLUMN1"
contenido.Pages.Page1.grdSubRubros.COLUMN2.Header1.Name = "Header1"
contenido.Pages.Page1.grdSubRubros.COLUMN2.Text1.Name = "Text1"
contenido.Pages.Page1.grdSubRubros.COLUMN2.Name = "COLUMN2"
contenido.Pages.Page1.grdSubRubros.COLUMN3.Header1.Name = "Header1"
contenido.Pages.Page1.grdSubRubros.COLUMN3.Text1.Name = "Text1"
contenido.Pages.Page1.grdSubRubros.COLUMN3.Name = "COLUMN3"
contenido.Pages.Page1.grdSubRubros.COLUMN4.Header1.Name = "Header1"
contenido.Pages.Page1.grdSubRubros.COLUMN4.Text1.Name = "Text1"
contenido.Pages.Page1.grdSubRubros.COLUMN4.Name = "COLUMN4"
contenido.Pages.Page1.grdSubRubros.COLUMN5.Header1.Name = "Header1"
contenido.Pages.Page1.grdSubRubros.COLUMN5.Text1.Name = "Text1"
contenido.Pages.Page1.grdSubRubros.COLUMN5.Name = "COLUMN5"
contenido.Pages.Page1.grdSubRubros.COLUMN6.Header1.Name = "Header1"
contenido.Pages.Page1.grdSubRubros.COLUMN6.Text1.Name = "Text1"
contenido.Pages.Page1.grdSubRubros.COLUMN6.Name = "COLUMN6"
contenido.Pages.Page1.grdSubRubros.COLUMN7.Header1.Name = "Header1"
contenido.Pages.Page1.grdSubRubros.COLUMN7.Text1.Name = "Text1"
contenido.Pages.Page1.grdSubRubros.COLUMN7.Name = "COLUMN7"
contenido.Pages.Page1.grdSubRubros.COLUMN8.Header1.Name = "Header1"
contenido.Pages.Page1.grdSubRubros.COLUMN8.Text1.Name = "Text1"
contenido.Pages.Page1.grdSubRubros.COLUMN8.Name = "COLUMN8"
contenido.Pages.Page1.grdSubRubros.COLUMN9.Header1.Name = "Header1"
contenido.Pages.Page1.grdSubRubros.COLUMN9.Text1.Name = "Text1"
contenido.Pages.Page1.grdSubRubros.COLUMN9.Name = "COLUMN9"
contenido.Pages.Page1.grdSubRubros.COLUMN10.Header1.Name = "Header1"
contenido.Pages.Page1.grdSubRubros.COLUMN10.Text1.Name = "Text1"
contenido.Pages.Page1.grdSubRubros.COLUMN10.Name = "COLUMN10"
contenido.Pages.Page1.grdSubRubros.COLUMN11.Header1.Name = "Header1"
contenido.Pages.Page1.grdSubRubros.COLUMN11.Text1.Name = "Text1"
contenido.Pages.Page1.grdSubRubros.COLUMN11.Name = "COLUMN11"
contenido.Pages.Page1.grdSubRubros.COLUMN12.Header1.Name = "Header1"
contenido.Pages.Page1.grdSubRubros.COLUMN12.Text1.Name = "Text1"
contenido.Pages.Page1.grdSubRubros.COLUMN12.Name = "COLUMN12"
contenido.Pages.Page1.grdSubRubros.COLUMN13.Header1.Name = "Header1"
contenido.Pages.Page1.grdSubRubros.COLUMN13.Text1.Name = "Text1"
contenido.Pages.Page1.grdSubRubros.COLUMN13.Name = "COLUMN13"
contenido.Pages.Page1.grdSubRubros.COLUMN14.Header1.Name = "Header1"
contenido.Pages.Page1.grdSubRubros.COLUMN14.Text1.Name = "Text1"
contenido.Pages.Page1.grdSubRubros.COLUMN14.Name = "COLUMN14"
contenido.Pages.Page1.grdSubRubros.COLUMN15.Header1.Name = "Header1"
contenido.Pages.Page1.grdSubRubros.COLUMN15.Text1.Name = "Text1"
contenido.Pages.Page1.grdSubRubros.COLUMN15.Name = "COLUMN15"
contenido.Pages.Page1.grdSubRubros.COLUMN16.Header1.Name = "Header1"
contenido.Pages.Page1.grdSubRubros.COLUMN16.Text1.Name = "Text1"
contenido.Pages.Page1.grdSubRubros.COLUMN16.Name = "COLUMN16"
contenido.Pages.Page1.grdSubRubros.COLUMN17.Header1.Name = "Header1"
contenido.Pages.Page1.grdSubRubros.COLUMN17.Text1.Name = "Text1"
contenido.Pages.Page1.grdSubRubros.COLUMN17.Name = "COLUMN17"
contenido.Pages.Page1.grdSubRubros.COLUMN18.Header1.Name = "Header1"
contenido.Pages.Page1.grdSubRubros.COLUMN18.Text1.Name = "Text1"
contenido.Pages.Page1.grdSubRubros.COLUMN18.Name = "COLUMN18"
contenido.Pages.Page1.grdSubRubros.COLUMN19.Header1.Name = "Header1"
contenido.Pages.Page1.grdSubRubros.COLUMN19.Text1.Name = "Text1"
contenido.Pages.Page1.grdSubRubros.COLUMN19.Name = "COLUMN19"
contenido.Pages.Page1.grdSubRubros.COLUMN20.Header1.Name = "Header1"
contenido.Pages.Page1.grdSubRubros.COLUMN20.Text1.Name = "Text1"
contenido.Pages.Page1.grdSubRubros.COLUMN20.Name = "COLUMN20"
contenido.Pages.Page1.grdSubRubros.Name = "grdSubRubros"
contenido.Pages.Page1.Clsetiqueta2.Name = "Clsetiqueta2"
contenido.Pages.Page1.chkTodos.Alignment = 0
contenido.Pages.Page1.chkTodos.Name = "chkTodos"
contenido.Pages.Page1.Clsetiqueta3.Name = "Clsetiqueta3"
contenido.Pages.Page1.Clsetiqueta4.Name = "Clsetiqueta4"
contenido.Pages.Page1.Clsetiqueta5.Name = "Clsetiqueta5"
contenido.Pages.Page1.txtFecDesde.Name = "txtFecDesde"
contenido.Pages.Page1.txtFecHasta.Name = "txtFecHasta"
contenido.Pages.Page1.chkBaseCalc.Alignment = 0
contenido.Pages.Page1.chkBaseCalc.Name = "chkBaseCalc"
contenido.Pages.Page1.Clslinea1.Name = "Clslinea1"
contenido.Pages.Page1.btnAceptar.Name = "btnAceptar"
contenido.Pages.Page1.Clsetiqueta6.Name = "Clsetiqueta6"
contenido.Pages.Page1.sel_marca.txtCodigo.Name = "txtCodigo"
contenido.Pages.Page1.sel_marca.txtDescripcion.Name = "txtDescripcion"
contenido.Pages.Page1.sel_marca.Name = "sel_marca"
contenido.Pages.Page1.btnBuscar.Name = "btnBuscar"
contenido.Pages.Page1.Clsetiqueta7.Name = "Clsetiqueta7"
contenido.Pages.Page1.txtFecEnt.Name = "txtFecEnt"
contenido.Pages.Page1.Name = "Page1"
contenido.Pages.Page2.grdPlanificar.COLUMN1.Header1.Name = "Header1"
contenido.Pages.Page2.grdPlanificar.COLUMN1.Text1.Name = "Text1"
contenido.Pages.Page2.grdPlanificar.COLUMN1.Name = "COLUMN1"
contenido.Pages.Page2.grdPlanificar.COLUMN2.Header1.Name = "Header1"
contenido.Pages.Page2.grdPlanificar.COLUMN2.Text1.Name = "Text1"
contenido.Pages.Page2.grdPlanificar.COLUMN2.Name = "COLUMN2"
contenido.Pages.Page2.grdPlanificar.COLUMN3.Header1.Name = "Header1"
contenido.Pages.Page2.grdPlanificar.COLUMN3.Text1.Name = "Text1"
contenido.Pages.Page2.grdPlanificar.COLUMN3.Name = "COLUMN3"
contenido.Pages.Page2.grdPlanificar.COLUMN4.Header1.Name = "Header1"
contenido.Pages.Page2.grdPlanificar.COLUMN4.Text1.Name = "Text1"
contenido.Pages.Page2.grdPlanificar.COLUMN4.Name = "COLUMN4"
contenido.Pages.Page2.grdPlanificar.COLUMN5.Header1.Name = "Header1"
contenido.Pages.Page2.grdPlanificar.COLUMN5.Text1.Name = "Text1"
contenido.Pages.Page2.grdPlanificar.COLUMN5.Name = "COLUMN5"
contenido.Pages.Page2.grdPlanificar.COLUMN6.Header1.Name = "Header1"
contenido.Pages.Page2.grdPlanificar.COLUMN6.Text1.Name = "Text1"
contenido.Pages.Page2.grdPlanificar.COLUMN6.Name = "COLUMN6"
contenido.Pages.Page2.grdPlanificar.COLUMN7.Header1.Name = "Header1"
contenido.Pages.Page2.grdPlanificar.COLUMN7.Text1.Name = "Text1"
contenido.Pages.Page2.grdPlanificar.COLUMN7.Name = "COLUMN7"
contenido.Pages.Page2.grdPlanificar.COLUMN8.Header1.Name = "Header1"
contenido.Pages.Page2.grdPlanificar.COLUMN8.Text1.Name = "Text1"
contenido.Pages.Page2.grdPlanificar.COLUMN8.Name = "COLUMN8"
contenido.Pages.Page2.grdPlanificar.COLUMN9.Header1.Name = "Header1"
contenido.Pages.Page2.grdPlanificar.COLUMN9.Text1.Name = "Text1"
contenido.Pages.Page2.grdPlanificar.COLUMN9.Name = "COLUMN9"
contenido.Pages.Page2.grdPlanificar.COLUMN10.Header1.Name = "Header1"
contenido.Pages.Page2.grdPlanificar.COLUMN10.Text1.Name = "Text1"
contenido.Pages.Page2.grdPlanificar.COLUMN10.Name = "COLUMN10"
contenido.Pages.Page2.grdPlanificar.COLUMN11.Header1.Name = "Header1"
contenido.Pages.Page2.grdPlanificar.COLUMN11.Text1.Name = "Text1"
contenido.Pages.Page2.grdPlanificar.COLUMN11.Name = "COLUMN11"
contenido.Pages.Page2.grdPlanificar.COLUMN12.Header1.Name = "Header1"
contenido.Pages.Page2.grdPlanificar.COLUMN12.Text1.Name = "Text1"
contenido.Pages.Page2.grdPlanificar.COLUMN12.Name = "COLUMN12"
contenido.Pages.Page2.grdPlanificar.COLUMN13.Header1.Name = "Header1"
contenido.Pages.Page2.grdPlanificar.COLUMN13.Text1.Name = "Text1"
contenido.Pages.Page2.grdPlanificar.COLUMN13.Name = "COLUMN13"
contenido.Pages.Page2.grdPlanificar.COLUMN14.Header1.Name = "Header1"
contenido.Pages.Page2.grdPlanificar.COLUMN14.Text1.Name = "Text1"
contenido.Pages.Page2.grdPlanificar.COLUMN14.Name = "COLUMN14"
contenido.Pages.Page2.grdPlanificar.COLUMN15.Header1.Name = "Header1"
contenido.Pages.Page2.grdPlanificar.COLUMN15.Text1.Name = "Text1"
contenido.Pages.Page2.grdPlanificar.COLUMN15.Name = "COLUMN15"
contenido.Pages.Page2.grdPlanificar.COLUMN16.Header1.Name = "Header1"
contenido.Pages.Page2.grdPlanificar.COLUMN16.Text1.Name = "Text1"
contenido.Pages.Page2.grdPlanificar.COLUMN16.Name = "COLUMN16"
contenido.Pages.Page2.grdPlanificar.COLUMN17.Header1.Name = "Header1"
contenido.Pages.Page2.grdPlanificar.COLUMN17.Text1.Name = "Text1"
contenido.Pages.Page2.grdPlanificar.COLUMN17.Name = "COLUMN17"
contenido.Pages.Page2.grdPlanificar.COLUMN18.Header1.Name = "Header1"
contenido.Pages.Page2.grdPlanificar.COLUMN18.Text1.Name = "Text1"
contenido.Pages.Page2.grdPlanificar.COLUMN18.Name = "COLUMN18"
contenido.Pages.Page2.grdPlanificar.COLUMN19.Header1.Name = "Header1"
contenido.Pages.Page2.grdPlanificar.COLUMN19.Text1.Name = "Text1"
contenido.Pages.Page2.grdPlanificar.COLUMN19.Name = "COLUMN19"
contenido.Pages.Page2.grdPlanificar.COLUMN20.Header1.Name = "Header1"
contenido.Pages.Page2.grdPlanificar.COLUMN20.Text1.Name = "Text1"
contenido.Pages.Page2.grdPlanificar.COLUMN20.Name = "COLUMN20"
contenido.Pages.Page2.grdPlanificar.Name = "grdPlanificar"
contenido.Pages.Page2.btnDetaEstad.Name = "btnDetaEstad"
contenido.Pages.Page2.btnMovStock.Name = "btnMovStock"
contenido.Pages.Page2.btnDetalVtas.Name = "btnDetalVtas"
contenido.Pages.Page2.Clsetiqueta1.Name = "Clsetiqueta1"
contenido.Pages.Page2.txtTotPed.Name = "txtTotPed"
contenido.Pages.Page2.Clsetiqueta2.Name = "Clsetiqueta2"
contenido.Pages.Page2.txtTotCosto.Name = "txtTotCosto"
contenido.Pages.Page2.Clsetiqueta3.Name = "Clsetiqueta3"
contenido.Pages.Page2.txtObsev.Name = "txtObsev"
contenido.Pages.Page2.Clsgenerico1.Name = "Clsgenerico1"
contenido.Pages.Page2.Name = "Page2"
contenido.Pages.Name = "Pages"
contenido.Name = "contenido"
btnCerrar.Name = "btnCerrar"
planificacion.Name = "planificacion"
btnCancelar.Name = "btnCancelar"
btnGrabar.Name = "btnGrabar"
Clsexcel1.Name = "Clsexcel1"

*** METODOS ***
PROCEDURE Init
&& Armo las grillas
SELECT cur_sfam
thisform.contenido.pages.page1.grdSubRubros.alias_name = "cur_sfam"
thisform.contenido.pages.page1.grdSubRubros.RecordSource = "cur_sfam"
thisform.contenido.pages.page1.grdSubRubros.list_controlsource = "selected,idSubFam,descripcio"
thisform.contenido.pages.page1.grdSubRubros.lista_ancho_cols = "50,70,300"
thisform.contenido.pages.page1.grdSubRubros.titulos_cabeceras = "#,Código,Descripción"
thisform.contenido.pages.page1.grdSubRubros.generar_grid()
thisform.contenido.pages.page1.grdSubRubros.columns[1].ReadOnly = .F.

SELECT cur_pcdet
thisform.contenido.pages.page2.grdPlanificar.alias_name = "cur_pcdet"
thisform.contenido.pages.page2.grdPlanificar.RecordSource = "cur_pcdet"
thisform.contenido.pages.page2.grdPlanificar.list_controlsource = "codArt,descripcio,vtaMax,faltant,pendi,stkDis,cantPed,diasCub,costo,prlista,promed,stkMin"
thisform.contenido.pages.page2.grdPlanificar.lista_ancho_cols = "100,300,70,70,70,70,70,70,70,70,70,70"
thisform.contenido.pages.page2.grdPlanificar.titulos_cabeceras = "Código,Descripción,Venta Max.,Faltante,Pendiente,Stock Disp.,Cantidad,Días Cub.,Costo,Pr. Lista,Promedio,Stock Min."
thisform.contenido.pages.page2.grdPlanificar.permitir_ordenamiento = .T.
thisform.contenido.pages.page2.grdPlanificar.permitir_busqueda = .F.
thisform.contenido.pages.page2.grdPlanificar.generar_grid()
thisform.contenido.pages.page2.grdPlanificar.Columns[7].ReadOnly = .F.

**************************************************************************************
LOCAL lcSql, loRes

lcSql = ""
loRes = CREATEOBJECT("odbc_result")

&& Levanto la marca, ya que este dato no lo tengo en el cursor cur_pccab
lcSql = "SELECT marcas.idmarca, "
lcSql = lcSql + "marcas.descripcio "
lcSql = lcSql + "FROM marcas "
lcSql = lcSql + "	INNER JOIN pccab ON marcas.idmarca = pccab.idmarca "
lcSql = lcSql + "WHERE pccab.idpccab = " + ALLTRIM(STR(cur_pccab.idpccab))

loRes.ActiveConnection = goConn.ActiveConnection
loRes.cursor_name = "cur_tempo"

IF !loRes.OpenQuery(lcSql) THEN
	this.errormessage = loRes.Error_Message
	RETURN .F.
ENDIF

&& Seteo los datos de la pantalla
thisform.contenido.pages.page1.selProveedor.valcpoid = cur_pccab.idprov
thisform.contenido.pages.page1.selProveedor.txtCodigo.Value = cur_pccab.idprov
thisform.contenido.pages.page1.selProveedor.txtdescripcion.Value = cur_pccab.razsoc
thisform.contenido.pages.page1.sel_marca.valcpoid = cur_tempo.idmarca
thisform.contenido.pages.page1.sel_marca.txtCodigo.Value = cur_tempo.idmarca
thisform.contenido.pages.page1.sel_marca.txtdescripcion.Value = cur_tempo.descripcio
thisform.contenido.pages.page1.txtFecDesde.Value = cur_pccab.fecdesde
thisform.contenido.pages.page1.txtFecHasta.Value = cur_pccab.fechasta
thisform.contenido.pages.page1.txtfecent.Value = cur_pccab.fecent
thisform.contenido.pages.page1.chkBaseCalc.Value = IIF(cur_pccab.basecalc = 1, 0, 1)
thisform.contenido.pages.page2.txtObsev.Value = cur_pccab.observ

SELECT cur_pccab

thisform.planificacion.idpdcab = cur_pccab.idpccab
thisform.planificacion.fecdesde = thisform.contenido.pages.page1.txtFecDesde.Value
thisform.planificacion.fechasta = thisform.contenido.pages.page1.txtFecHasta.Value
thisform.planificacion.fecEnt = thisform.contenido.pages.page1.txtFecEnt.Value
thisform.planificacion.idProv = thisform.contenido.pages.page1.selProveedor.valcpoid
thisform.planificacion.idMarca = thisform.contenido.pages.page1.sel_marca.valcpoid
thisform.planificacion.fecent = thisform.contenido.pages.page1.txtFecEnt.Value
*!*	thisform.planificacion.usualta = ALLTRIM(gcCodUsu)
*!*	thisform.planificacion.fecalta = DATETIME()
*!*	thisform.planificacion.idhostalta = SYS(0)

loRes.close_query()

&& Indico la base de calculo que se va a usar como stock mínimo
IF thisform.contenido.pages.page1.chkBaseCalc.Value = 1 THEN
	thisform.planificacion.basecalc = 0
ELSE
	thisform.planificacion.basecalc = 1
ENDIF

&& Leo la estadistica. 
IF !thisform.planificacion.leer_estadistica() THEN
	MESSAGEBOX(thisform.planificacion.ErrorMessage, 0+48, Thisform.Caption)
	RETURN
ENDIF

&& Recupero la planificacion
IF !thisform.planificacion.recuperar() THEN
	MESSAGEBOX(thisform.planificacion.ErrorMessage, 0+48, Thisform.Caption)
	RETURN
ENDIF

&& Calculo los totales
thisform.planificacion.totalizar()
thisform.contenido.pages.page2.txtTotPed.Value = thisform.planificacion.totPed
thisform.contenido.pages.page2.txtTotCosto.Value = thisform.planificacion.totCosto

SELECT cur_pcdet
IF RECCOUNT("cur_pcdet") > 0 THEN
	GO TOP
ENDIF

SELECT cur_pcdet
thisform.contenido.pages.page2.SetFocus()
thisform.contenido.pages.page2.grdPlanificar.Refresh()
thisform.contenido.pages.page2.grdPlanificar.SetFocus()
Thisform.habilitar_ctrl_pg1(.F.)
Thisform.btnCancelar.Enabled = .F.
ENDPROC
PROCEDURE Unload
SELECT cur_pccab
ZAP 

SELECT cur_pcdet
ZAP

SELECT cur_estad
ZAP

SELECT cur_sfam
ZAP

SELECT cur_cpasdet
ZAP

SELECT cur_stock
ZAP

SELECT cur_ocdet
ZAP 
ENDPROC
PROCEDURE btnGrabar.Click
LOCAL lnResp

thisform.planificacion.observ = ALLTRIM(thisform.contenido.pages.page2.txtObsev.Value)

IF !thisform.planificacion.actualizar() THEN
	MESSAGEBOX(thisform.planificacion.ErrorMessage, 0+48, Thisform.Caption)
	RETURN
ENDIF

MESSAGEBOX("La planificación se ha actualizado con éxito", 0+64, Thisform.Caption)

lnResp = MESSAGEBOX("¿Desea generar la Orden de Compra?", 4+32, Thisform.Caption)

IF lnResp = 6 THEN
	IF !thisform.planificacion.generar_oc() THEN
		RETURN
	ENDIF
	
	&& Verifico si esta seteado para mandar por pedido la OC
	IF getGlobalCFG("ENVIAR_OC") THEN
		lnResp = MESSAGEBOX("La Orden de Compra N° " + ALLTRIM(STR(thisform.planificacion.idoccab)) + " se ha generado con éxito. ¿Desea transferir la Orden de Compra como pedido a GPSDER?", 4+32, Thisform.Caption)
		IF lnResp = 6  THEN
			IF !thisform.planificacion.convertir_en_pedido(thisform.planificacion.idoccab) THEN
				MESSAGEBOX(thisform.planificacion.errorMessage, 0+48, Thisform.Caption)
				RETURN
			ENDIF
		ENDIF
	ELSE 
		MESSAGEBOX("La Orden de Compra N° " + ALLTRIM(STR(thisform.planificacion.idoccab)) + " se ha generado con éxito", 0+64, Thisform.Caption)
	ENDIF 
	
	Thisform.planificacion.imprimir_oc()
ENDIF

thisform.Release()
ENDPROC


************************************************************
OBJETO: cls_form_modplanif
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_form_consultaoc
************************************************************
*** PROPIEDADES ***
Height = 610
Width = 900
DoCreate = .T.
Caption = "Consulta de Ordenes de Compra"
WindowType = 0
Name = "cls_form_consultaoc"

*** METODOS ***
PROCEDURE buscar
LOCAL lnProvDesde, lnProvHasta, lnMarcaDesde, lnMarcaHasta, lnOcDesde, lnOcHasta, lcFecDesde, lcFecHasta, lnEnt
LOCAL loDateTime 

loDateTime = CREATEOBJECT("datetime")
lnProvDesde = Thisform.contenedor1.sel_prov_desde.txtCodigo.Value 
lnProvHasta = Thisform.contenedor1.sel_prov_hasta.txtCodigo.Value 
lnMarcaDesde = Thisform.contenedor1.sel_marca_desde.txtCodigo.Value 
lnMarcaHasta = Thisform.contenedor1.sel_marca_hasta.txtCodigo.Value 
lnOcDesde = thisform.contenedor1.txtOcDesde.Value 
lnOcHasta = thisform.contenedor1.txtOcHasta.Value 
lcFecDesde = loDateTime.toMySql(thisform.contenedor1.txtFecDesde.Value)
lcFecHasta = loDateTime.toMySql(thisform.contenedor1.txtFecHasta.Value)
lnEnt = thisform.contenedor1.chkEntreg.Value

Thisform.oc.consultar_occab(lnProvDesde, lnProvHasta, lnMarcaDesde, lnMarcaHasta, lnOcDesde, lnOcHasta, lcFecDesde, lcFecHasta, lnEnt)

thisform.contenedor1.grdCab.Refresh()

SELECT cur_occab
IF RECCOUNT("cur_occab") > 0 THEN 
	Thisform.oc.consultar_ocdet(cur_occab.idOcCab)	
ELSE 
	MESSAGEBOX("No hay registros para mostrar",0+48,thisform.Caption)
	
	Thisform.contenedor1.sel_prov_desde.txtcodigo.SetFocus()
	thisform.oc.limpiar()
ENDIF 


thisform.contenedor1.grdDet.Refresh()

ENDPROC
PROCEDURE blanquear
thisform.contenedor1.sel_prov_desde.blanquear()
thisform.contenedor1.sel_prov_desde.valcpoid = 0
thisform.contenedor1.sel_prov_hasta.blanquear()
thisform.contenedor1.sel_prov_hasta.valcpoid = 0
thisform.contenedor1.sel_marca_desde.blanquear()
thisform.contenedor1.sel_marca_desde.valcpoid = 0
thisform.contenedor1.sel_marca_hasta.blanquear()
thisform.contenedor1.sel_marca_hasta.valcpoid = 0
thisform.contenedor1.txtOcDesde.Value = 0
thisform.contenedor1.txtOcHasta.Value = 0
thisform.contenedor1.txtFecDesde.Value = DATE() - 30
thisform.contenedor1.txtFecHasta.Value = DATE()
thisform.contenedor1.chkEntreg.Value = 0
thisform.contenedor1.sel_prov_desde.txtcodigo.SetFocus()

SELECT cur_occab 
ZAP

SELECT cur_ocdet
ZAP 

thisform.contenedor1.grdCab.Refresh()
thisform.contenedor1.grdDet.Refresh()

ENDPROC
PROCEDURE Init
DODEFAULT()

thisform.contenedor1.sel_prov_desde.txtcodigo.SetFocus()
thisform.contenedor1.txtFecDesde.Value = DATE() - 30
thisform.contenedor1.txtFecHasta.Value = DATE()

Thisform.oc.crear_cursor()

SELECT cur_occab
Thisform.contenedor1.grdCab.RecordSource = "cur_occab"
Thisform.contenedor1.grdCab.list_controlsource = "idOcCab,idPcCab,idProv,RazSoc,idMarca,Marca,Fecha,Fecent,entregado"
Thisform.contenedor1.grdCab.lista_ancho_cols = "60,60,60,150,60,120,125,125,80"
Thisform.contenedor1.grdCab.titulos_cabeceras = "N° OC,N° Planif.,N° Prov.,Razón Social,N° Marca,Marca,Fecha,Fec. Ent.,Entregado"
Thisform.contenedor1.grdCab.generar_grid()
Thisform.contenedor1.grdCab.Refresh()

SELECT cur_ocdet
Thisform.contenedor1.grdDet.RecordSource = "cur_ocdet"
Thisform.contenedor1.grdDet.list_controlsource = "codart,descripcio,codUM,cantped,cantrec,pendiente,costo,prlista,activo"
Thisform.contenedor1.grdDet.lista_ancho_cols = "150,220,70,70,70,70,70,70,50"
Thisform.contenedor1.grdDet.titulos_cabeceras = "Código,Descripción,U. Medida,Cant. Ped.,Cant. Rec.,Pendiente,Costo,Pr. Lista,Activo"
Thisform.contenedor1.grdDet.generar_grid()
Thisform.contenedor1.grdDet.Refresh()
ENDPROC


************************************************************
OBJETO: Contenedor1
************************************************************
*** PROPIEDADES ***
Top = 0
Left = 0
Width = 900
Height = 609
TabIndex = 12
BackColor = 241,236,235
Name = "Contenedor1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "N° OC Desde:"
Height = 15
Left = 10
Top = 103
Width = 84
TabIndex = 15
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "N° OC Hasta:"
Height = 15
Left = 208
Top = 103
Width = 84
TabIndex = 16
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: txtOcDesde
************************************************************
*** PROPIEDADES ***
Left = 117
TabIndex = 5
Top = 99
Width = 80
isdatetime = .F.
isinteger = .T.
Name = "txtOcDesde"

*** METODOS ***


************************************************************
OBJETO: txtOcHasta
************************************************************
*** PROPIEDADES ***
Left = 279
TabIndex = 6
Top = 99
Width = 80
isdatetime = .F.
isinteger = .T.
Name = "txtOcHasta"

*** METODOS ***


************************************************************
OBJETO: btnSalir
************************************************************
*** PROPIEDADES ***
Top = 563
Left = 853
TabIndex = 14
Name = "btnSalir"

*** METODOS ***


************************************************************
OBJETO: btnBuscar
************************************************************
*** PROPIEDADES ***
Top = 78
Left = 852
TabIndex = 10
Name = "btnBuscar"

*** METODOS ***
PROCEDURE Click
thisform.buscar()
ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Detalle de Orden de Compra"
Height = 15
Left = 8
Top = 333
Width = 184
TabIndex = 14
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: grdDet
************************************************************
*** PROPIEDADES ***
Height = 212
Left = 5
TabIndex = 12
Top = 350
Width = 893
Name = "grdDet"
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
COLUMN9.CurrentControl = "chkactivo"
COLUMN9.Sparse = .F.
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
OBJETO: chkactivo
************************************************************
*** PROPIEDADES ***
Top = 21
Left = 36
Alignment = 0
Centered = .T.
Caption = ""
ReadOnly = .T.
Name = "chkactivo"

*** METODOS ***


************************************************************
OBJETO: sel_prov_desde
************************************************************
*** PROPIEDADES ***
Top = 4
Left = 115
TabIndex = 1
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
Top = 27
Left = 115
TabIndex = 2
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
Top = 11
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
Top = 33
Width = 99
TabIndex = 15
Name = "Clsetiqueta8"

*** METODOS ***


************************************************************
OBJETO: Clsimprimir1
************************************************************
*** PROPIEDADES ***
Top = 563
Left = 807
TabIndex = 13
Name = "Clsimprimir1"

*** METODOS ***
PROCEDURE Click

SELECT cur_occab
thisform.oc.idoccab = cur_occab.idOcCab
thisform.oc.totprlista = cur_occab.iTotLista
thisform.oc.observ = cur_occab.observ
thisform.oc.idprov = cur_occab.idProv

thisform.oc.imprimir_oc()


ENDPROC


************************************************************
OBJETO: Clscancelar1
************************************************************
*** PROPIEDADES ***
Top = 563
Left = 4
TabIndex = 15
Name = "Clscancelar1"

*** METODOS ***
PROCEDURE Click
thisform.blanquear()
ENDPROC


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Fecha Desde:"
Height = 15
Left = 376
Top = 103
Width = 84
TabIndex = 15
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta6
************************************************************
*** PROPIEDADES ***
Caption = "Fecha Hasta:"
Height = 15
Left = 563
Top = 103
Width = 84
TabIndex = 16
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: txtFecDesde
************************************************************
*** PROPIEDADES ***
Left = 455
TabIndex = 7
Top = 99
isdatetime = .T.
Name = "txtFecDesde"

*** METODOS ***


************************************************************
OBJETO: txtFecHasta
************************************************************
*** PROPIEDADES ***
Left = 636
TabIndex = 8
Top = 99
isdatetime = .T.
Name = "txtFecHasta"

*** METODOS ***


************************************************************
OBJETO: sel_marca_desde
************************************************************
*** PROPIEDADES ***
Top = 50
Left = 115
TabIndex = 3
nombre_campo_codigo = idMarca
nombre_campo_desc = descripcio
nombre_tabla = marcas
pkfield = idMarca
alternative_cols = 
cfieldname = idMarca
esnumerico = .T.
Name = "sel_marca_desde"
TXTCODIGO.Name = "TXTCODIGO"
TXTDESCRIPCION.Name = "TXTDESCRIPCION"

*** METODOS ***


************************************************************
OBJETO: sel_marca_hasta
************************************************************
*** PROPIEDADES ***
Top = 73
Left = 115
TabIndex = 4
pkfield = idMarca
alternative_cols = 
cfieldname = idMarca
nombre_alta_form = 
nombre_campo_codigo = idMarca
nombre_campo_desc = descripcio
nombre_tabla = marcas
esnumerico = .T.
Name = "sel_marca_hasta"
TXTCODIGO.Name = "TXTCODIGO"
TXTDESCRIPCION.Name = "TXTDESCRIPCION"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta7
************************************************************
*** PROPIEDADES ***
Caption = "Marca Desde:"
Height = 15
Left = 9
Top = 57
Width = 99
TabIndex = 15
Name = "Clsetiqueta7"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta9
************************************************************
*** PROPIEDADES ***
Caption = "Marca Hasta:"
Height = 15
Left = 9
Top = 79
Width = 99
TabIndex = 15
Name = "Clsetiqueta9"

*** METODOS ***


************************************************************
OBJETO: chkEntreg
************************************************************
*** PROPIEDADES ***
Top = 101
Left = 753
Height = 18
Width = 83
Alignment = 0
Caption = "Pendiente"
TabIndex = 9
Name = "chkEntreg"

*** METODOS ***


************************************************************
OBJETO: grdCab
************************************************************
*** PROPIEDADES ***
Height = 206
Left = 5
Top = 124
Width = 893
Name = "grdCab"
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
COLUMN9.CurrentControl = "chkent"
COLUMN9.Sparse = .F.
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
PROCEDURE AfterRowColChange
LPARAMETERS nColIndex


SELECT cur_occab
IF RECCOUNT("cur_occab") > 0 THEN 
	Thisform.oc.consultar_ocdet(cur_occab.idOcCab)	
ENDIF 

thisform.contenedor1.grdDet.Refresh()

ENDPROC


************************************************************
OBJETO: chkent
************************************************************
*** PROPIEDADES ***
Top = 19
Left = 12
Alignment = 0
Centered = .T.
Caption = ""
ReadOnly = .T.
Name = "chkent"

*** METODOS ***


************************************************************
OBJETO: oc
************************************************************
*** PROPIEDADES ***
Top = 576
Left = 72
Height = 17
Width = 32
Name = "oc"

*** METODOS ***


************************************************************
OBJETO: cls_form_consultaoc
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_form_cbpc
************************************************************
*** PROPIEDADES ***
DataSession = 2
BorderStyle = 2
Height = 534
Width = 969
DoCreate = .T.
Caption = "Consulta / Modificación y Baja de Planificación de Compras"
WindowType = 0
Name = "cls_form_cbpc"
contenido.Top = -1
contenido.Left = -1
contenido.Width = 977
contenido.Height = 538
contenido.Name = "contenido"

*** METODOS ***
PROCEDURE Init
DODEFAULT()

thisform.planificacion.crear_cursor()

SELECT cur_pccab
thisform.contenido.grdPlanificacion.RecordSource = "cur_pccab"
thisform.contenido.grdPlanificacion.alias_name = "cur_pccab"
thisform.contenido.grdPlanificacion.list_controlsource = "idPCCab,idProv,razSoc,usuAlta,fecAlta,idHostAlta"
thisform.contenido.grdPlanificacion.lista_ancho_cols = "70,70,300,70,150,200"
thisform.contenido.grdPlanificacion.titulos_cabeceras = "Id.,Proveedor,Razón Social,Usuario,Fecha,HostName"
Thisform.contenido.grdPlanificacion.generar_grid()

thisform.planificacion.getpendientes()
thisform.contenido.grdPlanificacion.Refresh()
ENDPROC


************************************************************
OBJETO: planificacion
************************************************************
*** PROPIEDADES ***
Top = 502
Left = 192
Name = "planificacion"

*** METODOS ***


************************************************************
OBJETO: grdPlanificacion
************************************************************
*** PROPIEDADES ***
Anchor = 15
Height = 487
Left = 3
TabIndex = 1
Top = 2
Width = 967
Name = "grdPlanificacion"
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
OBJETO: btnEliminar
************************************************************
*** PROPIEDADES ***
Top = 490
Left = 874
Anchor = 12
TabIndex = 3
Name = "btnEliminar"

*** METODOS ***
PROCEDURE Click
LOCAL lnResp

IF RECCOUNT("cur_pccab") = 0 THEN 
	RETURN 
ENDIF 

lnResp = MESSAGEBOX("¿Está seguro que desea eliminar la planificación?", 4+32, Thisform.Caption)

IF lnResp = 6 THEN
	SELECT cur_pccab
	Thisform.Planificacion.eliminar(cur_pccab.idPCCab)
	
	SELECT cur_pccab
	ZAP 
	
	thisform.planificacion.getpendientes()
	thisform.contenido.grdPlanificacion.Refresh()
ENDIF
ENDPROC


************************************************************
OBJETO: btnModificar
************************************************************
*** PROPIEDADES ***
Top = 490
Left = 828
Anchor = 12
TabIndex = 2
Name = "btnModificar"

*** METODOS ***
PROCEDURE Click
LOCAL loForm

IF RECCOUNT("cur_pccab") = 0 THEN 
	RETURN 
ENDIF 
*!*	SELECT cur_pccab
loForm = CREATEOBJECT("cls_form_modplanif")
*!*	loForm.proveedor = ALLTRIM(STR(cur_pccab.idProv)) + " " + ALLTRIM(cur_pccab.razSoc)
*!*	loForm.fecdd = cur_pccab.fecDesde
*!*	loForm.fechh = cur_pccab.fecHasta
*!*	loForm.id_pccab = cur_pccab.idPCCab
*!*	loForm.leer_datos()
loForm.show()

SELECT cur_pccab
ZAP 
thisform.planificacion.getpendientes()
thisform.contenido.grdPlanificacion.Refresh()
ENDPROC


************************************************************
OBJETO: CLSCERRAR1
************************************************************
*** PROPIEDADES ***
Top = 490
Left = 920
Anchor = 12
TabIndex = 4
Name = "CLSCERRAR1"

*** METODOS ***


************************************************************
OBJETO: cls_form_cbpc
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_form_detaestad
************************************************************
*** PROPIEDADES ***
DataSession = 1
BorderStyle = 2
Height = 370
Width = 640
DoCreate = .T.
Caption = "Detalle de estadística"
WindowType = 1
idarticulo = 0
codart = 
descripcio = 
Name = "cls_form_detaestad"

*** METODOS ***
PROCEDURE leer_datos
LOCAL lnIdArticulo

lnIdArticulo = this.idarticulo

Thisform.txtcodigo.Value = thisform.codart
Thisform.txtdesc.Value = thisform.descripcio

SELECT anio, mes, codArt, cantidad FROM cur_estad WHERE cur_estad.idArticulo = lnIdArticulo ORDER BY anio, mes INTO CURSOR cur_detaEst READWRITE 

*!*	SELECT cur_detaEst
*!*	INDEX ON cur_detaEst.anio TAG anio ASCENDING
*!*	INDEX ON cur_detaEst.mes TAG mes ASCENDING ADDITIVE
*!*	INDEX ON cur_detaEst.codArt TAG codArt ASCENDING ADDITIVE
*!*	INDEX ON cur_detaEst.cantidad TAG cantidad ASCENDING ADDITIVE

SELECT cur_detaEst
thisform.grdEstadDeta.alias_name = "cur_detaEst"
thisform.grdEstadDeta.RecordSource = "cur_detaEst"
thisform.grdEstadDeta.list_controlsource = "anio,mes,cantidad"
thisform.grdEstadDeta.lista_ancho_cols = "50,50,70"
thisform.grdEstadDeta.titulos_cabeceras = "Año,Mes,Unid. Vend."
thisform.grdEstadDeta.generar_grid()

thisform.btnCerrar.SetFocus()
ENDPROC
PROCEDURE Unload
USE IN cur_detaEst
ENDPROC
PROCEDURE Init
DODEFAULT()
ENDPROC


************************************************************
OBJETO: grdEstadDeta
************************************************************
*** PROPIEDADES ***
Height = 287
Left = 1
TabIndex = 1
Top = 37
Width = 636
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdEstadDeta"
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


************************************************************
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 325
Left = 591
Cancel = .T.
TabIndex = 3
Name = "btnCerrar"

*** METODOS ***


************************************************************
OBJETO: CLSETIQUETA1
************************************************************
*** PROPIEDADES ***
Caption = "Artículo:"
Height = 15
Left = 7
Top = 15
Width = 53
TabIndex = 4
Name = "CLSETIQUETA1"

*** METODOS ***


************************************************************
OBJETO: txtCodigo
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 60
ReadOnly = .T.
TabIndex = 5
Top = 10
Width = 150
ischaracter = .T.
Name = "txtCodigo"

*** METODOS ***


************************************************************
OBJETO: txtDesc
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 214
ReadOnly = .T.
TabIndex = 6
Top = 10
Width = 423
ischaracter = .T.
Name = "txtDesc"

*** METODOS ***


************************************************************
OBJETO: Clsexcel1
************************************************************
*** PROPIEDADES ***
Top = 325
Left = 545
TabIndex = 2
Name = "Clsexcel1"

*** METODOS ***
PROCEDURE Click
SELECT cur_detaEst
IF RECCOUNT() > 0
	genexcel("cur_detaEst","Planificación de Compras - Detalle de estadística")
ELSE 
	MESSAGEBOX("No hay registros para exportar",0+48,Thisform.Caption)
	RETURN
ENDIF 
ENDPROC


************************************************************
OBJETO: cls_form_detaestad
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_form_detpend
************************************************************
*** PROPIEDADES ***
DataSession = 2
BorderStyle = 2
Height = 500
Width = 900
DoCreate = .T.
Caption = "Detalle de Pendientes"
idarticulo = 0
fecdesde = {}
fechasta = {}
codart = 
descripcio = 
Name = "cls_form_detpend"

*** METODOS ***
PROCEDURE leer_datos
LOCAL lcSql, loRes, lnCantTot, loDt, lnSqlSrv 

lcSql = ""
loRes = CREATEOBJECT("odbc_result")
loDt = CREATEOBJECT("datetime")
lnCantTot = 0.00
lnSqlSrv = INT(VAL(getconfig("SQLSRV")))

Thisform.txtcodigo.Value = thisform.codart
Thisform.txtDesc.Value = thisform.descripcio


lcSql = "SELECT occab.idoccab, "
lcSql = lcSql + "occab.fecha, "
lcSql = lcSql + "occab.fecent, "
lcSql = lcSql + "ocdet.unidesp, "
lcSql = lcSql + "ocdet.cantpack, "
lcSql = lcSql + "ocdet.codUM, "
lcSql = lcSql + "ocdet.cantped, "
lcSql = lcSql + "ocdet.cantrec, "
lcSql = lcSql + "ocdet.pendiente, "
lcSql = lcSql + "occab.usualta, "
lcSql = lcSql + "CASE WHEN " + loDt.getdatetime() + " > occab.fecent then 1 else 0 end vencida "
lcSql = lcSql + "FROM occab "
lcSql = lcSql + "	inner join ocdet on occab.idoccab = ocdet.idoccab "
lcSql = lcSql + "WHERE ocdet.idarticulo = " + ALLTRIM(STR(thisform.idarticulo)) + " "
lcSql = lcSql + " 	and occab.fecbaja is null "
lcSql = lcSql + " 	and ocdet.activo = 1 "

loRes.ActiveConnection = goConn.ActiveConnection
loRes.cursor_name = "cur_tempo"

IF !loRes.OpenQuery(lcSql) THEN
	this.errorMessage = loRes.Error_Message
	RETURN .F.
ENDIF

SELECT cur_tempo
IF RECCOUNT("cur_tempo") > 0 THEN
	GO TOP
ELSE 
	RETURN .F.
ENDIF

DO WHILE !EOF("cur_tempo")
	SELECT cur_pend
	APPEND BLANK

	REPLACE cur_pend.idoccab WITH cur_tempo.idoccab 
	REPLACE cur_pend.fecha WITH cur_tempo.fecha ADDITIVE
	REPLACE cur_pend.fecent WITH cur_tempo.fecent ADDITIVE
	REPLACE cur_pend.unidesp WITH cur_tempo.unidesp ADDITIVE
	REPLACE cur_pend.cantpack WITH cur_tempo.cantpack ADDITIVE
	REPLACE cur_pend.codUM WITH cur_tempo.codUM ADDITIVE
	REPLACE cur_pend.cantped WITH cur_tempo.cantped ADDITIVE
	REPLACE cur_pend.cantrec WITH cur_tempo.cantrec ADDITIVE 
	REPLACE cur_pend.pendiente WITH cur_tempo.pendiente ADDITIVE
	REPLACE cur_pend.usualta WITH cur_tempo.usualta ADDITIVE
	REPLACE cur_pend.vencida WITH IIF(lnSqlSrv = 1,cur_tempo.vencida,INT(VAL(cur_tempo.vencida))) ADDITIVE
	
	lnCantTot = lnCantTot + cur_tempo.pendiente
	
	SELECT cur_tempo
	SKIP
ENDDO

loRes.Close_Query()

Thisform.txtcantTot.Value = lnCantTot

SELECT cur_pend
IF RECCOUNT("cur_pend") > 0 THEN
	GO TOP
ENDIF

ENDPROC
PROCEDURE Unload
SELECT cur_pend
ZAP 
ENDPROC
PROCEDURE Init
	DODEFAULT()

SELECT cur_pend
thisform.grdPend.alias_name = "cur_pend"
thisform.grdPend.RecordSource = "cur_pend"
thisform.grdPend.list_controlsource = "idoccab,fecha,fecent,unidesp,cantpack,codUM,cantped,cantrec,pendiente,usualta"
thisform.grdPend.lista_ancho_cols = "70,150,150,70,70,50,70,70,70,70"
thisform.grdPend.titulos_cabeceras = "Num. OC,Fecha,Fecha Ent,Uni. Desp.,Pack,Medida,Pedido,Recibido,Pendiente,Usuario"
thisform.grdPend.generar_grid()

SELECT cur_pend
GO TOP


*!*	Thisform.grdPend.Column1.DynamicBackColor = "IIF(cur_pend.vencida = 1, RGB(0,255,0), RGB(255,255,0))"
*!*	Thisform.grdPend.Column1.DynamicForeColor = "RGB(0,0,0)"

Thisform.grdPend.SetAll("DynamicBackColor","IIF(cur_pend.vencida = 1, RGB(255,0,0), RGB(255,255,255))","column")
Thisform.grdPend.SetAll("DynamicForeColor","IIF(cur_pend.vencida = 1, RGB(255,255,255), RGB(0,0,0))","column")
thisform.grdPend.Refresh()

thisform.btncerrar.SetFocus()
ENDPROC
PROCEDURE Load
DODEFAULT()

CREATE CURSOR cur_pend ( ;
	idoccab		int,;
	fecha		datetime,;
	fecent		datetime,;
	unidesp		float(10, 2),;
	cantpack	float(10, 2),;
	codUM		varchar(3),;
	cantped		float(10, 2),;
	cantrec		float(10, 2),;
	pendiente	float(10, 2),;
	usualta		varchar(5),;
	vencida		int)
	
SELECT cur_pend 
INDEX ON idoccab TAG idoccab ASCENDING
INDEX ON fecent TAG fecent ASCENDING ADDITIVE 
INDEX ON unidesp TAG unidesp ASCENDING ADDITIVE
INDEX ON cantpack TAG cantpack ASCENDING ADDITIVE
INDEX ON codUM TAG codUM ASCENDING ADDITIVE
INDEX ON cantped TAG cantped ASCENDING ADDITIVE
INDEX ON cantrec TAG cantrec ASCENDING ADDITIVE
INDEX ON pendiente TAG pendiente ASCENDING ADDITIVE
INDEX ON usualta TAG usualta ASCENDING ADDITIVE
INDEX ON vencida TAG vencida ASCENDING ADDITIVE
INDEX ON fecha TAG fecha ASCENDING ADDITIVE

ENDPROC


************************************************************
OBJETO: grdPend
************************************************************
*** PROPIEDADES ***
Height = 416
Left = 2
Top = 35
Width = 895
ForeColor = 0,0,0
permitir_busqueda = .T.
permitir_ordenamiento = .T.
Name = "grdPend"
COLUMN1.Header1.Name = "Header1"
COLUMN1.Text1.ForeColor = 0,0,0
COLUMN1.Text1.Name = "Text1"
COLUMN1.ForeColor = 0,0,0
COLUMN1.Name = "COLUMN1"
COLUMN2.Header1.Name = "Header1"
COLUMN2.Text1.ForeColor = 0,0,0
COLUMN2.Text1.Name = "Text1"
COLUMN2.ForeColor = 0,0,0
COLUMN2.Name = "COLUMN2"
COLUMN3.Header1.Name = "Header1"
COLUMN3.Text1.ForeColor = 0,0,0
COLUMN3.Text1.Name = "Text1"
COLUMN3.ForeColor = 0,0,0
COLUMN3.Name = "COLUMN3"
COLUMN4.Header1.Name = "Header1"
COLUMN4.Text1.ForeColor = 0,0,0
COLUMN4.Text1.Name = "Text1"
COLUMN4.ForeColor = 0,0,0
COLUMN4.Name = "COLUMN4"
COLUMN5.Header1.Name = "Header1"
COLUMN5.Text1.ForeColor = 0,0,0
COLUMN5.Text1.Name = "Text1"
COLUMN5.ForeColor = 0,0,0
COLUMN5.Name = "COLUMN5"
COLUMN6.Header1.Name = "Header1"
COLUMN6.Text1.Alignment = 2
COLUMN6.Text1.ForeColor = 0,0,0
COLUMN6.Text1.Name = "Text1"
COLUMN6.Alignment = 2
COLUMN6.ForeColor = 0,0,0
COLUMN6.Name = "COLUMN6"
COLUMN7.Header1.Name = "Header1"
COLUMN7.Text1.ForeColor = 0,0,0
COLUMN7.Text1.Name = "Text1"
COLUMN7.ForeColor = 0,0,0
COLUMN7.Name = "COLUMN7"
COLUMN8.Header1.Name = "Header1"
COLUMN8.Text1.ForeColor = 0,0,0
COLUMN8.Text1.Name = "Text1"
COLUMN8.ForeColor = 0,0,0
COLUMN8.Name = "COLUMN8"
COLUMN9.Header1.Name = "Header1"
COLUMN9.Text1.ForeColor = 0,0,0
COLUMN9.Text1.Name = "Text1"
COLUMN9.ForeColor = 0,0,0
COLUMN9.Name = "COLUMN9"
COLUMN10.Header1.Name = "Header1"
COLUMN10.Text1.ForeColor = 0,0,0
COLUMN10.Text1.Name = "Text1"
COLUMN10.ForeColor = 0,0,0
COLUMN10.Name = "COLUMN10"
COLUMN11.Header1.Name = "Header1"
COLUMN11.Text1.ForeColor = 0,0,0
COLUMN11.Text1.Name = "Text1"
COLUMN11.ForeColor = 0,0,0
COLUMN11.Name = "COLUMN11"
COLUMN12.Header1.Name = "Header1"
COLUMN12.Text1.ForeColor = 0,0,0
COLUMN12.Text1.Name = "Text1"
COLUMN12.ForeColor = 0,0,0
COLUMN12.Name = "COLUMN12"
COLUMN13.Header1.Name = "Header1"
COLUMN13.Text1.ForeColor = 0,0,0
COLUMN13.Text1.Name = "Text1"
COLUMN13.ForeColor = 0,0,0
COLUMN13.Name = "COLUMN13"
COLUMN14.Header1.Name = "Header1"
COLUMN14.Text1.ForeColor = 0,0,0
COLUMN14.Text1.Name = "Text1"
COLUMN14.ForeColor = 0,0,0
COLUMN14.Name = "COLUMN14"
COLUMN15.Header1.Name = "Header1"
COLUMN15.Text1.ForeColor = 0,0,0
COLUMN15.Text1.Name = "Text1"
COLUMN15.ForeColor = 0,0,0
COLUMN15.Name = "COLUMN15"
COLUMN16.Header1.Name = "Header1"
COLUMN16.Text1.ForeColor = 0,0,0
COLUMN16.Text1.Name = "Text1"
COLUMN16.ForeColor = 0,0,0
COLUMN16.Name = "COLUMN16"
COLUMN17.Header1.Name = "Header1"
COLUMN17.Text1.ForeColor = 0,0,0
COLUMN17.Text1.Name = "Text1"
COLUMN17.ForeColor = 0,0,0
COLUMN17.Name = "COLUMN17"
COLUMN18.Header1.Name = "Header1"
COLUMN18.Text1.ForeColor = 0,0,0
COLUMN18.Text1.Name = "Text1"
COLUMN18.ForeColor = 0,0,0
COLUMN18.Name = "COLUMN18"
COLUMN19.Header1.Name = "Header1"
COLUMN19.Text1.ForeColor = 0,0,0
COLUMN19.Text1.Name = "Text1"
COLUMN19.ForeColor = 0,0,0
COLUMN19.Name = "COLUMN19"
COLUMN20.Header1.Name = "Header1"
COLUMN20.Text1.ForeColor = 0,0,0
COLUMN20.Text1.Name = "Text1"
COLUMN20.ForeColor = 0,0,0
COLUMN20.Name = "COLUMN20"

*** METODOS ***


************************************************************
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 454
Left = 852
Height = 44
Width = 44
Cancel = .T.
TabIndex = 3
Name = "btnCerrar"

*** METODOS ***


************************************************************
OBJETO: CLSETIQUETA1
************************************************************
*** PROPIEDADES ***
Caption = "Articulo:"
Height = 15
Left = 10
Top = 10
Width = 50
TabIndex = 4
Name = "CLSETIQUETA1"

*** METODOS ***


************************************************************
OBJETO: txtCodigo
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 64
ReadOnly = .T.
TabIndex = 5
Top = 6
Width = 150
ischaracter = .T.
Name = "txtCodigo"

*** METODOS ***


************************************************************
OBJETO: txtDesc
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 217
ReadOnly = .T.
TabIndex = 6
Top = 6
Width = 576
ischaracter = .T.
Name = "txtDesc"

*** METODOS ***


************************************************************
OBJETO: Clsexcel1
************************************************************
*** PROPIEDADES ***
Top = 454
Left = 805
Height = 44
Width = 44
TabIndex = 2
Name = "Clsexcel1"

*** METODOS ***
PROCEDURE Click
SELECT cur_pend
IF RECCOUNT() > 0
	genexcel("cur_pend","Planificación de Compras - Detalle de pendientes")
ELSE 
	MESSAGEBOX("No hay registros para exportar",0+48,Thisform.Caption)
	RETURN
ENDIF 
ENDPROC


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Total Pendientes:"
Height = 15
Left = 8
Top = 461
Width = 97
TabIndex = 4
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: txtCantTot
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 111
ReadOnly = .T.
TabIndex = 5
Top = 457
Width = 109
ischaracter = .T.
Name = "txtCantTot"

*** METODOS ***


************************************************************
OBJETO: cls_form_detpend
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_form_detstock
************************************************************
*** PROPIEDADES ***
DataSession = 1
BorderStyle = 1
Height = 500
Width = 806
DoCreate = .T.
Caption = "Detalle del Movimiento de Stock"
codart = 
descripcio = 
Name = "cls_form_detstock"

*** METODOS ***
PROCEDURE leer_datos
Thisform.txtcodigo.Value = thisform.codart
Thisform.txtdesc.Value = thisform.descripcio

SELECT cur_stock
thisform.grdStock.alias_name = "cur_stock"
thisform.grdStock.RecordSource = "cur_stock"
thisform.grdStock.list_controlsource = "fecAlta,nroPart,cbte,tipoDoc,numCbte,entrada,salida,saldo"
thisform.grdStock.lista_ancho_cols = "150,120,50,40,100,50,50,50"
thisform.grdStock.titulos_cabeceras = "Fecha,Partida,Cbte.,Letra,Número,Ent.,Sal.,Saldo"
thisform.grdStock.generar_grid()

thisform.btnCerrar.SetFocus()
ENDPROC
PROCEDURE Unload
SELECT cur_stock
ZAP
ENDPROC


************************************************************
OBJETO: CLSETIQUETA1
************************************************************
*** PROPIEDADES ***
Caption = "Articulo:"
Height = 15
Left = 10
Top = 11
Width = 50
TabIndex = 4
Name = "CLSETIQUETA1"

*** METODOS ***


************************************************************
OBJETO: txtCodigo
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 63
ReadOnly = .T.
TabIndex = 5
Top = 7
Width = 150
ischaracter = .T.
Name = "txtCodigo"

*** METODOS ***


************************************************************
OBJETO: grdStock
************************************************************
*** PROPIEDADES ***
Height = 417
Left = 0
TabIndex = 1
Top = 34
Width = 804
permitir_busqueda = .F.
permitir_ordenamiento = .F.
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
Top = 454
Left = 759
Cancel = .T.
TabIndex = 3
Name = "btnCerrar"

*** METODOS ***


************************************************************
OBJETO: txtDesc
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 216
ReadOnly = .T.
TabIndex = 6
Top = 7
Width = 576
ischaracter = .T.
Name = "txtDesc"

*** METODOS ***


************************************************************
OBJETO: Clsexcel1
************************************************************
*** PROPIEDADES ***
Top = 454
Left = 712
TabIndex = 2
Name = "Clsexcel1"

*** METODOS ***
PROCEDURE Click
SELECT cur_stock
IF RECCOUNT() > 0
	genexcel("cur_stock","Planificación de Compras - Detalle de movimientos de stock")
ELSE 
	MESSAGEBOX("No hay registros para exportar",0+48,Thisform.Caption)
	RETURN
ENDIF 
ENDPROC


************************************************************
OBJETO: cls_form_detstock
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_form_pcdetavtas
************************************************************
*** PROPIEDADES ***
BorderStyle = 2
Height = 500
Width = 855
DoCreate = .T.
Caption = "Detalle de ventas"
idarticulo = 0
fecdesde = {}
fechasta = {}
codart = 
descripcio = 
Name = "cls_form_pcdetavtas"

*** METODOS ***
PROCEDURE leer_datos
LOCAL loRes, lcSql, loDT, loRes2, loConDMO, lnCantTot

lcSql = ""
loDT = CREATEOBJECT("datetime")
loRes = CREATEOBJECT("odbc_result")
loRes2 = CREATEOBJECT("odbc_result")
loConDMO = CREATEOBJECT("odbc_connect")
lnCantTot = 0.00

Thisform.txtcodigo.Value = thisform.codart
Thisform.txtDesc.Value = thisform.descripcio
thisform.txtFecDesde.Value = thisform.fecdesde
thisform.txtFecHasta.Value = thisform.fechasta

***********************************************************************************************************************
&& Levanto las ventas en crudo de Cuenta 1

lcSql = "select 	ventascab.fecEmision, 	"
lcSql = lcSql + "	ventascab.cbte, "
lcSql = lcSql + "	ventascab.tipodoc, "
lcSql = lcSql + "	ventascab.ptoVta, "	
lcSql = lcSql + "	ventascab.numCbte, "	
lcSql = lcSql + "	ventascab.idCliente, "		
lcSql = lcSql + "	clientes.razSoc, "
lcSql = lcSql + "	ventasdet.cantidad "
lcSql = lcSql + "from ventasdet	"
lcSql = lcSql + "	inner join ventascab on ventasdet.idVentasC = ventascab.idVentasC "
lcSql = lcSql + "	inner join clientes on ventascab.idCliente = clientes.idCliente "
lcSql = lcSql + "where ventasdet.idArticulo = " + ALLTRIM(STR(thisform.idarticulo))
lcSql = lcSql + " 	and ventascab.cbte IN ('FC','NC','PTO') "

IF INT(VAL(getConfig("SQLSRV"))) = 1 THEN
	lcSql = lcSql + "	and ventascab.fecEmision between CONVERT(CHAR(8)," + loDT.toMySql(this.fecDesde) +", 112) and  CONVERT(CHAR(8), " + loDT.toMySql(this.fecHasta) + ", 112) "
ELSE
	lcSql = lcSql + "	and ventascab.fecEmision between " + loDT.toMySql(this.fecDesde) +" and  " + loDT.toMySql(this.fecHasta) + " "
ENDIF

lcSql = lcSql + "order by ventascab.fecEmision"

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_ventas1"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN
ENDIF

SELECT cur_ventas1
IF RECCOUNT("cur_ventas1") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_ventas1")
	SELECT cur_ventas
	APPEND BLANK
	REPLACE cur_ventas.fecha WITH cur_ventas1.fecEmision
	REPLACE cur_ventas.cbte WITH cur_ventas1.cbte ADDITIVE
	REPLACE cur_ventas.tipodoc WITH cur_ventas1.tipodoc ADDITIVE
	REPLACE cur_ventas.nroCbte WITH getptovta(cur_ventas1.ptoVta) + "-" + getnrocbte(cur_ventas1.numCbte) ADDITIVE
	REPLACE cur_ventas.idCliente WITH cur_ventas1.idCliente ADDITIVE
	REPLACE cur_ventas.razSoc WITH cur_ventas1.razSoc ADDITIVE
	REPLACE cur_ventas.cantidad WITH cur_ventas1.cantidad ADDITIVE
	
	SELECT cur_ventas1
	SKIP
ENDDO

loRes.Close_Query()

***********************************************************************************************************************
&& Levanto las ventas en crudo de Cuenta 2, si es que la base de cuenta dos existe!!

IF ALLTRIM(getConfig("DMO_CC")) != "DSN=X" THEN 

	loConDMO.ConnectionString = ALLTRIM(getConfig("DMO_CC"))
	
	IF !loConDMO.Open() THEN
		MESSAGEBOX(loConDMO.ErrorMessage, 0+48, Thisform.Caption)
		RETURN .F.
	ENDIF	
	
	lcSql = "select 	ventascab.fecEmision, 	"
	lcSql = lcSql + "	ventascab.cbte, "
	lcSql = lcSql + "	ventascab.tipodoc, "
	lcSql = lcSql + "	ventascab.ptoVta, "	
	lcSql = lcSql + "	ventascab.numCbte, "	
	lcSql = lcSql + "	ventascab.idCliente, "		
	lcSql = lcSql + "	clientes.razSoc, "
	lcSql = lcSql + "	ventasdet.cantidad "
	lcSql = lcSql + "from ventasdet	"
	lcSql = lcSql + "	inner join ventascab on ventasdet.idVentasC = ventascab.idVentasC "
	lcSql = lcSql + "	inner join clientes on ventascab.idCliente = clientes.idCliente "
	lcSql = lcSql + "where ventasdet.idArticulo = " + ALLTRIM(STR(thisform.idarticulo))
	lcSql = lcSql + " 	and ventascab.cbte IN ('FC','NC','PTO') "

	IF INT(VAL(getConfig("SQLSRV"))) = 1 THEN
		lcSql = lcSql + "	and ventascab.fecEmision between CONVERT(CHAR(8)," + loDT.toMySql(this.fecDesde) +", 112) and  CONVERT(CHAR(8), " + loDT.toMySql(this.fecHasta) + ", 112) "
	ELSE
		lcSql = lcSql + "	and ventascab.fecEmision between " + loDT.toMySql(this.fecDesde) +" and  " + loDT.toMySql(this.fecHasta) + " "
	ENDIF

	lcSql = lcSql + "order by ventascab.fecEmision"

	loRes2.ActiveConnection = loConDMO.ActiveConnection
	loRes2.Cursor_Name = "cur_ventas2"	
	
	IF !loRes2.OpenQuery(lcSql) THEN
		this.errorMessage = loRes2.Error_Message
		RETURN .F.
	ENDIF

	&& Recorro el cursor con las ventas de cuenta dos y las meto en el cursor cur_ventas1
	SELECT cur_ventas2
	IF RECCOUNT("cur_ventas2") > 0 THEN
		GO TOP
	ENDIF  
	
	DO WHILE !EOF("cur_ventas2")
		SELECT cur_ventas
		APPEND BLANK
		
		REPLACE cur_ventas.fecha WITH cur_ventas2.fecEmision
		REPLACE cur_ventas.cbte WITH cur_ventas2.cbte ADDITIVE
		REPLACE cur_ventas.tipodoc WITH cur_ventas2.tipodoc ADDITIVE
		REPLACE cur_ventas.nroCbte WITH getptovta(cur_ventas2.ptoVta) + "-" + getnrocbte(cur_ventas2.numCbte) ADDITIVE
		REPLACE cur_ventas.idCliente WITH cur_ventas2.idCliente ADDITIVE
		REPLACE cur_ventas.razSoc WITH cur_ventas2.razSoc ADDITIVE
		REPLACE cur_ventas.cantidad WITH cur_ventas2.cantidad ADDITIVE
		
		SELECT cur_ventas2
		SKIP 
	ENDDO 
	
	loRes2.close_query()
	loConDMO.close()
ENDIF

***********************************************************************************************************************
&& Tomo el cursor con las ventas y calculo el total de unidades vendidas

SELECT cur_ventas
IF RECCOUNT("cur_ventas") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_ventas")
	lnCantTot = lnCantTot + IIF(cur_ventas.cbte = "NC",cur_ventas.cantidad * -1,cur_ventas.cantidad)
	
	SELECT cur_ventas
	SKIP
ENDDO

Thisform.txtcantTot.Value = lnCanttot

SELECT cur_ventas
IF RECCOUNT("cur_ventas") > 0 THEN
	GO TOP
ENDIF

ENDPROC
PROCEDURE Load
DODEFAULT()

CREATE CURSOR cur_ventas ( ;
	fecha		datetime,;
	cbte		varchar(3),;
	tipodoc		varchar(1),;
	nroCbte		varchar(13),;
	idCliente	int,;
	razSoc		varchar(60),;
	cantidad	float(10, 2))
	
SELECT cur_ventas
INDEX ON cbte TAG cbte ASCENDING
INDEX ON nroCbte TAG nroCbte ASCENDING ADDITIVE
INDEX ON tipodoc TAG tipodoc ASCENDING ADDITIVE 
INDEX ON idCliente TAG idCliente ASCENDING ADDITIVE
INDEX ON razSoc TAG razSoc ASCENDING ADDITIVE
INDEX ON cantidad TAG cantidad ASCENDING ADDITIVE
INDEX ON fecha TAG fecha ASCENDING ADDITIVE

ENDPROC
PROCEDURE Init
DODEFAULT()

SELECT cur_ventas
thisform.grdVentas.alias_name = "cur_ventas"
thisform.grdVentas.RecordSource = "cur_ventas"
thisform.grdVentas.list_controlsource = "fecha,cbte,tipodoc,nroCbte,idCliente,razSoc,cantidad"
thisform.grdVentas.lista_ancho_cols = "150,70,50,100,70,250,70"
thisform.grdVentas.titulos_cabeceras = "Fecha,Cbte.,Tipo,Número,Cliente,Razón Social,Cantidad"
thisform.grdVentas.generar_grid()

SELECT cur_ventas
GO TOP

thisform.grdVentas.Refresh()

thisform.btnCerrar.SetFocus()
ENDPROC
PROCEDURE Unload
SELECT cur_ventas
ZAP 
ENDPROC


************************************************************
OBJETO: grdVentas
************************************************************
*** PROPIEDADES ***
Height = 391
Left = 4
Top = 61
Width = 845
permitir_busqueda = .T.
permitir_ordenamiento = .T.
Name = "grdVentas"
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
Top = 454
Left = 805
Cancel = .T.
TabIndex = 3
Name = "btnCerrar"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Fecha Desde:"
Height = 15
Left = 10
Top = 36
Width = 84
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: txtFecDesde
************************************************************
*** PROPIEDADES ***
Left = 92
ReadOnly = .T.
Top = 31
Name = "txtFecDesde"

*** METODOS ***


************************************************************
OBJETO: txtFecHasta
************************************************************
*** PROPIEDADES ***
Left = 280
ReadOnly = .T.
Top = 32
Name = "txtFecHasta"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Fecha Hasta:"
Height = 15
Left = 205
Top = 36
Width = 84
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: CLSETIQUETA1
************************************************************
*** PROPIEDADES ***
Caption = "Articulo:"
Height = 15
Left = 10
Top = 10
Width = 50
TabIndex = 4
Name = "CLSETIQUETA1"

*** METODOS ***


************************************************************
OBJETO: txtCodigo
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 92
ReadOnly = .T.
TabIndex = 5
Top = 6
Width = 150
ischaracter = .T.
Name = "txtCodigo"

*** METODOS ***


************************************************************
OBJETO: txtDesc
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 245
ReadOnly = .T.
TabIndex = 6
Top = 6
Width = 576
ischaracter = .T.
Name = "txtDesc"

*** METODOS ***


************************************************************
OBJETO: Clsexcel1
************************************************************
*** PROPIEDADES ***
Top = 454
Left = 758
TabIndex = 2
Name = "Clsexcel1"

*** METODOS ***
PROCEDURE Click
SELECT cur_ventas
IF RECCOUNT() > 0
	genexcel("cur_ventas","Planificación de Compras - Detalle de ventas")
ELSE 
	MESSAGEBOX("No hay registros para exportar",0+48,Thisform.Caption)
	RETURN
ENDIF 
ENDPROC


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Total Unidades Vendidas:"
Height = 15
Left = 8
Top = 461
Width = 139
TabIndex = 4
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: txtCantTot
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 151
ReadOnly = .T.
TabIndex = 5
Top = 457
Width = 109
ischaracter = .T.
Name = "txtCantTot"

*** METODOS ***


************************************************************
OBJETO: cls_form_pcdetavtas
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_form_planifcpr
************************************************************
*** PROPIEDADES ***
BorderStyle = 1
Height = 531
Width = 1168
ShowInTaskBar = .T.
DoCreate = .T.
AutoCenter = .T.
Caption = "Planificar compras"
Closable = .T.
MaxButton = .F.
MinButton = .F.
WindowType = 0
Name = "cls_form_planifcpr"
contenido.Top = -1
contenido.Left = -1
contenido.Width = 1170
contenido.Height = 533
contenido.Name = "contenido"

*** METODOS ***
PROCEDURE generar_orden
IF !thisform.planificacion.generar_oc() THEN
	MESSAGEBOX(thisform.planificacion.ErrorMessage, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

RETURN .T.

ENDPROC
PROCEDURE habilitar_ctrl_pg1
PARAMETERS lbEstado

LOCAL cant_ctrl, i 

cant_ctrl = Thisform.contenido.pages.page1.ControlCount

FOR i = 1 TO cant_ctrl 
	Thisform.contenido.pages.page1.Controls(i).Enabled = lbEstado
ENDFOR 
ENDPROC
PROCEDURE blanquear
thisform.planificacion.limpiar()
thisform.contenido.pages.page1.selProveedor.blanquear()
thisform.contenido.pages.page1.selProveedor.valcpoid = 0
thisform.contenido.pages.page1.sel_marca.blanquear()
thisform.contenido.pages.page1.sel_marca.valcpoid = 0
thisform.contenido.pages.page1.txtFecDesde.Value = DATE() - 190
thisform.contenido.pages.page1.txtFecHasta.Value = DATE()
thisform.contenido.pages.page1.txtFecEnt.Value = DATE() + 7
thisform.contenido.pages.page1.chkTodos.Value = 0
thisform.contenido.pages.page2.txtObsev.Value = ""
thisform.contenido.pages.page2.txtTotCosto.Value = 0.00
thisform.contenido.pages.page2.txtTotPed.Value = 0.00
Thisform.habilitar_ctrl_pg1(.T.)
thisform.contenido.pages.page1.SetFocus()
thisform.contenido.pages.page1.selProveedor.txtCodigo.SetFocus()
ENDPROC
PROCEDURE Init
DODEFAULT()
thisform.planificacion.crear_cursor()

SELECT cur_sfam
thisform.contenido.pages.page1.grdSubRubros.alias_name = "cur_sfam"
thisform.contenido.pages.page1.grdSubRubros.RecordSource = "cur_sfam"
thisform.contenido.pages.page1.grdSubRubros.list_controlsource = "selected,idSubFam,descripcio"
thisform.contenido.pages.page1.grdSubRubros.lista_ancho_cols = "50,70,300"
thisform.contenido.pages.page1.grdSubRubros.titulos_cabeceras = "#,Código,Descripción"
thisform.contenido.pages.page1.grdSubRubros.generar_grid()
thisform.contenido.pages.page1.grdSubRubros.columns[1].ReadOnly = .F.


SELECT cur_pcdet
thisform.contenido.pages.page2.grdPlanificar.alias_name = "cur_pcdet"
thisform.contenido.pages.page2.grdPlanificar.RecordSource = "cur_pcdet"
thisform.contenido.pages.page2.grdPlanificar.list_controlsource = "codArt,descripcio,vtaMax,faltant,pendi,stkDis,cantPed,diasCub,costo,prlista,promed,stkMin"
thisform.contenido.pages.page2.grdPlanificar.lista_ancho_cols = "100,300,70,70,70,70,70,70,70,70,70,70"
thisform.contenido.pages.page2.grdPlanificar.titulos_cabeceras = "Código,Descripción,Venta Max.,Faltante,Pendiente,Stock Disp.,Cantidad,Días Cub.,Costo,Pr. Lista,Promedio,Stock Min."
thisform.contenido.pages.page2.grdPlanificar.permitir_ordenamiento = .T.
thisform.contenido.pages.page2.grdPlanificar.permitir_busqueda = .F.
thisform.contenido.pages.page2.grdPlanificar.generar_grid()
thisform.contenido.pages.page2.grdPlanificar.Columns[7].ReadOnly = .F.

thisform.contenido.pages.page1.selProveedor.txtCodigo.SetFocus()
thisform.contenido.pages.page1.txtFecDesde.Value = DATE() - 190
thisform.contenido.pages.page1.txtFecHasta.Value = DATE()
thisform.contenido.pages.page1.txtFecEnt.Value = DATE() + 7

thisform.MaxButton = .F.
thisform.MinButton = .F.
ENDPROC


************************************************************
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 483
Left = 1119
Name = "btnCerrar"

*** METODOS ***


************************************************************
OBJETO: planificacion
************************************************************
*** PROPIEDADES ***
Top = 492
Left = 229
Name = "planificacion"

*** METODOS ***


************************************************************
OBJETO: btnCancelar
************************************************************
*** PROPIEDADES ***
Top = 483
Left = 6
TabIndex = 9
Name = "btnCancelar"

*** METODOS ***
PROCEDURE Click
Thisform.blanquear()
ENDPROC


************************************************************
OBJETO: btnGrabar
************************************************************
*** PROPIEDADES ***
Top = 483
Left = 1072
Height = 44
Width = 45
TabIndex = 8
Name = "btnGrabar"

*** METODOS ***
PROCEDURE Click
LOCAL lnResp

thisform.planificacion.observ = ALLTRIM(thisform.contenido.pages.page2.txtObsev.Value)

IF !thisform.planificacion.grabar() THEN
	MESSAGEBOX(thisform.planificacion.ErrorMessage, 0+48, Thisform.Caption)
	RETURN
ENDIF

MESSAGEBOX("La planificación se ha generado con éxito", 0+64, Thisform.Caption)

lnResp = MESSAGEBOX("¿Desea generar la Orden de Compra?", 4+32, Thisform.Caption)

IF lnResp = 6 THEN
	IF !thisform.planificacion.generar_oc() THEN
		RETURN
	ENDIF
	
	&& Verifico si esta seteado para mandar por pedido la OC
	IF getGlobalCFG("ENVIAR_OC") THEN
		lnResp = MESSAGEBOX("La Orden de Compra N° " + ALLTRIM(STR(thisform.planificacion.idoccab)) + " se ha generado con éxito. ¿Desea transferir la Orden de Compra como pedido a GPSDER?", 4+32, Thisform.Caption)
		IF lnResp = 6  THEN
			IF !thisform.planificacion.convertir_en_pedido(thisform.planificacion.idoccab) THEN
				MESSAGEBOX(thisform.planificacion.errorMessage, 0+48, Thisform.Caption)
				RETURN
			ENDIF
		ENDIF
	ELSE 
		MESSAGEBOX("La Orden de Compra N° " + ALLTRIM(STR(thisform.planificacion.idoccab)) + " se ha generado con éxito",0+64, Thisform.Caption)
	ENDIF 
	
	Thisform.planificacion.imprimir_oc()
ENDIF

thisform.blanquear()
ENDPROC


************************************************************
OBJETO: Clsexcel1
************************************************************
*** PROPIEDADES ***
Top = 483
Left = 1025
Name = "Clsexcel1"

*** METODOS ***
PROCEDURE Click
SELECT cur_pcdet
IF RECCOUNT() > 0
	genexcel("cur_pcdet","Planificación de Compras")
ELSE 
	MESSAGEBOX("No hay registros para exportar",0+48,Thisform.Caption)
	RETURN
ENDIF 
ENDPROC


************************************************************
OBJETO: pages
************************************************************
*** PROPIEDADES ***
ErasePage = .T.
Top = 1
Left = 1
Width = 1168
Height = 478
TabIndex = 1
Name = "pages"
Page1.Caption = "Parámetros de Planificación"
Page1.Name = "Page1"
Page2.Caption = "Planificación de Compras"
Page2.Name = "Page2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Proveedor:"
Height = 15
Left = 11
Top = 16
Width = 72
TabIndex = 13
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: selProveedor
************************************************************
*** PROPIEDADES ***
Top = 10
Left = 81
TabIndex = 1
autocompletar_ceros = .F.
esnumerico = .T.
nombre_campo_codigo = idProv
nombre_campo_desc = razSoc
nombre_tabla = proveedor
pkfield = idProv
Name = "selProveedor"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: grdSubRubros
************************************************************
*** PROPIEDADES ***
Height = 174
Left = 11
TabIndex = 5
Top = 104
Width = 1148
permitir_busqueda = .T.
permitir_ordenamiento = .T.
Name = "grdSubRubros"
COLUMN1.Header1.Name = "Header1"
COLUMN1.Text1.Name = "Text1"
COLUMN1.ControlSource = ""
COLUMN1.CurrentControl = "CLSCHECKBOX1"
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
OBJETO: CLSCHECKBOX1
************************************************************
*** PROPIEDADES ***
Top = 29
Left = 49
Alignment = 0
Caption = ""
Name = "CLSCHECKBOX1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Seleccione los subrubros a planificar:"
Height = 15
Left = 11
Top = 82
Width = 216
TabIndex = 4
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: chkTodos
************************************************************
*** PROPIEDADES ***
Top = 284
Left = 12
Height = 18
Width = 179
Alignment = 0
Caption = "Marcar / Desmarcar todos"
TabIndex = 6
Name = "chkTodos"

*** METODOS ***
PROCEDURE Click
SELECT cur_sfam
IF RECCOUNT("cur_sfam") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_sfam")
	IF this.Value = 1 THEN
		LOCK()
		REPLACE cur_sfam.selected WITH .T.
		UNLOCK
	ELSE
		LOCK()
		REPLACE cur_sfam.selected WITH .F.
		UNLOCK
	ENDIF
	
	SELECT cur_sfam
	SKIP
ENDDO

IF RECCOUNT("cur_sfam") > 0 THEN
	GO TOP
ENDIF

thisform.contenido.pages.page1.grdSubRubros.Refresh()

ENDPROC


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Parámetros de estadísticas para calcular stock mínimo:"
Height = 15
Left = 11
Top = 328
Width = 333
TabIndex = 12
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Fecha Desde:"
Height = 15
Left = 40
Top = 352
Width = 88
TabIndex = 14
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Fecha Hasta:"
Height = 15
Left = 40
Top = 377
Width = 88
TabIndex = 15
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: txtFecDesde
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 129
TabIndex = 7
Top = 349
Width = 126
isdatetime = .T.
Name = "txtFecDesde"

*** METODOS ***


************************************************************
OBJETO: txtFecHasta
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 129
TabIndex = 8
Top = 373
Width = 126
isdatetime = .T.
Name = "txtFecHasta"

*** METODOS ***


************************************************************
OBJETO: chkBaseCalc
************************************************************
*** PROPIEDADES ***
Top = 403
Left = 263
Height = 16
Width = 233
Alignment = 0
Caption = "Base de cálculo en promedio de venta"
TabIndex = 10
Name = "chkBaseCalc"

*** METODOS ***


************************************************************
OBJETO: Clslinea1
************************************************************
*** PROPIEDADES ***
Height = 1
Left = 11
Top = 314
Width = 1147
Name = "Clslinea1"

*** METODOS ***


************************************************************
OBJETO: btnAceptar
************************************************************
*** PROPIEDADES ***
Top = 373
Left = 503
TabIndex = 11
Name = "btnAceptar"

*** METODOS ***
PROCEDURE Click
LOCAL lnCont

lnCont = 0

IF thisform.contenido.pages.page1.txtFecDesde.Value = {} THEN
	MESSAGEBOX("Falta ingresar la fecha desde", 0+48, thisform.Caption)
	thisform.contenido.pages.page1.txtFecDesde.SetFocus()
	RETURN
ENDIF


IF thisform.contenido.pages.page1.txtFecHasta.Value = {} THEN
	MESSAGEBOX("Falta ingresar la fecha hasta", 0+48,thisform.Caption)
	thisform.contenido.pages.page1.txtFecHasta.SetFocus()
	RETURN
ENDIF

SELECT cur_sfam
DO WHILE !EOF("cur_sfam")
	IF cur_sfam.selected THEN
		lnCont = lnCont + 1
	ENDIF

	SELECT cur_sfam
	SKIP
ENDDO

IF lnCont = 0 THEN
	MESSAGEBOX("Debe seleccionar al menos un subrubro", 0+48, thisform.Caption)
	thisform.contenido.pages.page1.grdSubRubros.SetFocus()
	RETURN
ENDIF

thisform.planificacion.fecdesde = thisform.contenido.pages.page1.txtFecDesde.Value
thisform.planificacion.fechasta = thisform.contenido.pages.page1.txtFecHasta.Value
thisform.planificacion.fecEnt = thisform.contenido.pages.page1.txtFecEnt.Value
thisform.planificacion.idProv = thisform.contenido.pages.page1.selProveedor.valcpoid
thisform.planificacion.idMarca = thisform.contenido.pages.page1.sel_marca.valcpoid
thisform.planificacion.fecent = thisform.contenido.pages.page1.txtFecEnt.Value
thisform.planificacion.usualta = ALLTRIM(gcCodUsu)
thisform.planificacion.fecalta = DATETIME()
thisform.planificacion.idhostalta = SYS(0)

&& Indico la base de calculo que se va a usar como stock mínimo
IF thisform.contenido.pages.page1.chkBaseCalc.Value = 1 THEN
	thisform.planificacion.basecalc = 0
ELSE
	thisform.planificacion.basecalc = 1
ENDIF

IF !thisform.planificacion.leer_estadistica() THEN
	MESSAGEBOX(thisform.planificacion.ErrorMessage, 0+48, Thisform.Caption)
	RETURN
ENDIF

IF !thisform.planificacion.planificar() THEN
	MESSAGEBOX(thisform.planificacion.ErrorMessage, 0+48, Thisform.Caption)
	RETURN
ENDIF

SELECT cur_pcdet
IF RECCOUNT("cur_pcdet") > 0 THEN
	GO TOP
ENDIF

SELECT cur_pcdet
thisform.contenido.pages.page2.SetFocus()
thisform.contenido.pages.page2.grdPlanificar.Refresh()
thisform.contenido.pages.page2.grdPlanificar.SetFocus()
Thisform.habilitar_ctrl_pg1(.F.)
ENDPROC


************************************************************
OBJETO: Clsetiqueta6
************************************************************
*** PROPIEDADES ***
Caption = "Marca:"
Height = 15
Left = 11
Top = 40
Width = 72
TabIndex = 17
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: sel_marca
************************************************************
*** PROPIEDADES ***
Top = 34
Left = 81
TabIndex = 2
autocompletar_ceros = .F.
esnumerico = .T.
nombre_campo_codigo = idMarca
nombre_campo_desc = descripcio
nombre_tabla = marcas
pkfield = idMarca
Name = "sel_marca"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: btnBuscar
************************************************************
*** PROPIEDADES ***
Top = 12
Left = 568
TabIndex = 3
Name = "btnBuscar"

*** METODOS ***
PROCEDURE Click
thisform.planificacion.leer_subfam(thisform.contenido.pages.page1.selProveedor.valcpoid, thisform.contenido.pages.page1.sel_marca.valcpoid)
thisform.contenido.pages.page1.grdSubRubros.Refresh()
ENDPROC


************************************************************
OBJETO: Clsetiqueta7
************************************************************
*** PROPIEDADES ***
Caption = "Fecha Entrega:"
Height = 15
Left = 40
Top = 401
Width = 88
TabIndex = 16
Name = "Clsetiqueta7"

*** METODOS ***


************************************************************
OBJETO: txtFecEnt
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 129
TabIndex = 9
Top = 397
Width = 126
isdatetime = .T.
Name = "txtFecEnt"

*** METODOS ***


************************************************************
OBJETO: grdPlanificar
************************************************************
*** PROPIEDADES ***
Height = 343
Left = 4
TabIndex = 1
Top = 4
Width = 1153
permitir_busqueda = .F.
permitir_ordenamiento = .T.
Name = "grdPlanificar"
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
COLUMN11.Header1.Alignment = 2
COLUMN11.Header1.Name = "Header1"
COLUMN11.Text1.Name = "Text1"
COLUMN11.Name = "COLUMN11"
COLUMN12.Header1.Alignment = 2
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
PROCEDURE COLUMN6.Text1.KeyPress
LPARAMETERS nKeyCode, nShiftAltCtrl

ENDPROC
PROCEDURE COLUMN7.Text1.KeyPress
LPARAMETERS nKeyCode, nShiftAltCtrl

IF LASTKEY() = 13 THEN 
	nodefault
	KEYBOARD '{DNARROW}'
ENDIF 


ENDPROC
PROCEDURE COLUMN7.Text1.Valid
LOCAL lnCantUD

lnCantUD = 0.00

IF this.Value <> 0 THEN
	lnCantUD = thisform.planificacion.calc_mult_ud(cur_pcdet.idArticulo, this.Value)

	IF lnCantUD = -1 THEN
		RETURN .F.
	ELSE
		IF this.Value <> lnCantUD THEN
			MESSAGEBOX("Atención, la cantidad a pedir se cambiará por " + ALLTRIM(STR(lnCantUD, 10, 2)), 0+64, Thisform.Caption)
			
			SELECT cur_pcdet
			LOCK()
			REPLACE cur_pcdet.cantPed WITH lnCantUD
			REPLACE cur_pcdet.UniDesp WITH Thisform.planificacion.unidesp
			REPLACE cur_pcdet.cantpack WITH Thisform.planificacion.cantpack
			UNLOCK
		ELSE
			SELECT cur_pcdet
			LOCK()
			REPLACE cur_pcdet.cantPed WITH this.Value
			REPLACE cur_pcdet.UniDesp WITH Thisform.planificacion.unidesp
			REPLACE cur_pcdet.cantpack WITH Thisform.planificacion.cantpack
			UNLOCK
		ENDIF
	ENDIF
ENDIF

SELECT cur_pcdet
LOCK()
REPLACE diasCub WITH thisform.planificacion.calc_diascub(cur_pcdet.stkDis, cur_pcdet.stkMin, cur_pcdet.pendi, this.Value)
UNLOCK	

thisform.planificacion.totalizar()
thisform.contenido.pages.page2.txtTotPed.Value = thisform.planificacion.totPed
thisform.contenido.pages.page2.txtTotCosto.Value = thisform.planificacion.totCosto

RETURN .T.
ENDPROC
PROCEDURE COLUMN11.Header1.Click
IF This.Parent.Parent.permitir_ordenamiento then
	This.Parent.Parent.ordenar_datos(This.Parent.ControlSource)
ENDIF
ENDPROC
PROCEDURE COLUMN12.Header1.Click
IF This.Parent.Parent.permitir_ordenamiento then
	This.Parent.Parent.ordenar_datos(This.Parent.ControlSource)
ENDIF
ENDPROC


************************************************************
OBJETO: btnDetaEstad
************************************************************
*** PROPIEDADES ***
Top = 419
Left = 3
Height = 30
Width = 92
FontBold = .T.
Caption = "Detalle \<Estad."
TabIndex = 5
Name = "btnDetaEstad"

*** METODOS ***
PROCEDURE Click
LOCAL loForm

loForm = CREATEOBJECT("cls_form_detaestad")

loForm.idArticulo = cur_pcdet.idArticulo
loForm.codart = cur_pcdet.codart
loForm.descripcio = cur_pcdet.descripcio

loForm.leer_datos()
loForm.show()

Thisform.contenido.pages.page2.grdplanificar.SetFocus()
ENDPROC


************************************************************
OBJETO: btnMovStock
************************************************************
*** PROPIEDADES ***
Top = 419
Left = 101
Height = 30
Width = 92
FontBold = .T.
Caption = "Detalle \<Stock"
TabIndex = 6
Name = "btnMovStock"

*** METODOS ***
PROCEDURE Click
LOCAL loForm

loForm = CREATEOBJECT("cls_form_detstock")

thisform.planificacion.leer_fichastock(cur_pcdet.idArticulo)
loForm.codart = cur_pcdet.codart
loForm.descripcio = cur_pcdet.descripcio
loForm.leer_datos()
loForm.show()

Thisform.contenido.pages.page2.grdplanificar.SetFocus()
ENDPROC


************************************************************
OBJETO: btnDetalVtas
************************************************************
*** PROPIEDADES ***
Top = 419
Left = 199
Height = 30
Width = 92
FontBold = .T.
Caption = "Detalle de \<Vtas"
TabIndex = 7
Name = "btnDetalVtas"

*** METODOS ***
PROCEDURE Click
LOCAL loForm

loForm = CREATEOBJECT("cls_form_pcdetavtas")

loForm.idArticulo = cur_pcdet.idArticulo
loForm.codart = cur_pcdet.codart
loForm.descripcio = cur_pcdet.descripcio
loForm.fecDesde = thisform.contenido.pages.page1.txtFecDesde.Value
loForm.fecHasta = thisform.contenido.pages.page1.txtFecHasta.Value
loForm.leer_datos()
loForm.show()

Thisform.contenido.pages.page2.grdplanificar.SetFocus()
ENDPROC


************************************************************
OBJETO: CLSETIQUETA1
************************************************************
*** PROPIEDADES ***
Caption = "Total Pedido:"
Height = 15
Left = 683
Top = 353
Width = 84
TabIndex = 10
Name = "CLSETIQUETA1"

*** METODOS ***


************************************************************
OBJETO: txtTotPed
************************************************************
*** PROPIEDADES ***
Left = 767
ReadOnly = .T.
TabIndex = 3
Top = 350
isnumeric = .T.
Name = "txtTotPed"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Total Costo:"
Height = 15
Left = 879
Top = 353
Width = 70
TabIndex = 11
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: txtTotCosto
************************************************************
*** PROPIEDADES ***
Left = 956
ReadOnly = .T.
TabIndex = 4
Top = 350
isnumeric = .T.
Name = "txtTotCosto"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Observaciones:"
Height = 15
Left = 5
Top = 350
Width = 91
TabIndex = 12
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: txtObsev
************************************************************
*** PROPIEDADES ***
Height = 65
Left = 97
TabIndex = 2
Top = 350
Width = 574
Name = "txtObsev"

*** METODOS ***


************************************************************
OBJETO: Clsgenerico1
************************************************************
*** PROPIEDADES ***
Top = 419
Left = 296
Height = 30
Width = 92
FontBold = .T.
Caption = "Pen\<dientes"
TabIndex = 7
Name = "Clsgenerico1"

*** METODOS ***
PROCEDURE Click
LOCAL loForm

loForm = CREATEOBJECT("cls_form_detpend")

loForm.idArticulo = cur_pcdet.idArticulo
loForm.codart = cur_pcdet.codart
loForm.descripcio = cur_pcdet.descripcio
loForm.leer_datos()
loForm.show()

Thisform.contenido.pages.page2.grdplanificar.SetFocus()
ENDPROC


************************************************************
OBJETO: cls_form_planifcpr
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 9, 6, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_faltantes
************************************************************
*** PROPIEDADES ***
errormessage = 
Name = "cls_faltantes"

*** METODOS ***
PROCEDURE grabar
PARAMETERS ;
	tnIdFaltante,;
	tnIdArticulo,;
	tcCodArt,;
	tnUniCpr,;
	tnCantidad,;
	tnIdCliente
	
LOCAL lcSql
LOCAL loCommand
LOCAL lnIdFaltante
LOCAL loRes
LOCAL lnRespuesta
	
IF ALLTRIM(tcCodArt) == "" THEN
	This.ErrorMessage = "El parámetro código de artículo no tiene ningún valor"
	RETURN .F.
ENDIF

IF tnUniCpr = 0 THEN
	This.ErrorMessage = "El parámetro unidad de compras no tiene ningún valor"
	RETURN .F.
ENDIF

IF tnCantidad = 0 THEN
	This.ErrorMessage = "El parámetro cantidad no tiene ningún valor"
	RETURN .F.
ENDIF

lcSql = ""
loCommand = CREATEOBJECT("odbc_command")
lnIdFaltante = 0
lnRespuesta = 0

* Verifico si el artículo ya se encuentra dentro de los faltantes.
TEXT TO lcSql NOSHOW
	SELECT
		COUNT(*) AS cantidad
	FROM
		faltantes
	WHERE
		faltantes.idArticulo = ?xid AND
		faltantes.procesado = 0 AND
		faltantes.fecBaja IS NULL
ENDTEXT
loRes = CREATEOBJECT("odbc_result")
lcSql = loRes.AddParameter(lcSql, "xid", ALLTRIM(STR(tnIdArticulo)), .F., .F.)
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"
loRes.OpenQuery(lcSql)

IF INT(VAL(cur_x.cantidad)) > 0 THEN
	lnRespuesta = MESSAGEBOX("El artículo ya se encuentra en faltantes, ¿Quiere sumar la cantidad?", 4+32, Thisform.Caption)
ELSE
	* Si no existe entonces fuerzo la repuesta a si para que lo agregue
	lnRespuesta = 6
ENDIF
loRes.Close_Query()

* Si el usuario responde que no, entonces, salgo y no hago nada.
IF lnRespuesta = 7 THEN
	RETURN .F.
ENDIF

* Agrego el faltante. La transacción la manejo dentro del SP.
loCommand.CommandText = "CALL agregar_faltantes(?xidArticulo, ?xcodArt, ?xuniCpr, ?xcantidad, ?xidCliente, ?xusuario, ?xhost)"
loCommand.AddParameter("xidArticulo", ALLTRIM(STR(tnIdArticulo)), .F., .F.)
loCommand.AddParameter("xcodArt", ALLTRIM(tcCodArt), .T., .F.)
loCommand.AddParameter("xuniCpr", ALLTRIM(STR(tnUniCpr, 10, 2)), .F., .F.)
loCommand.AddParameter("xcantidad", ALLTRIM(STR(tnCantidad, 10, 2)), .F., .F.)
loCommand.AddParameter("xidCliente", ALLTRIM(STR(tnIdCliente)), .F., .F.)
loCommand.AddParameter("xusuario", ALLTRIM(gcCodUsu), .T., .F.)
loCommand.AddParameter("xhost", ALLTRIM(SYS(0)), .T., .F.)
loCommand.ActiveConnection = goConn.ActiveConnection
IF !loCommand.Execute() THEN
	THIS.ErrorMessage = loCommand.ErrorMessage
	RETURN .F.
ENDIF

RETURN .T.
ENDPROC
PROCEDURE eliminar
PARAMETERS tnIdFaltante

LOCAL lcSql
LOCAL loCommand

lcSql = ""
loCommand = CREATEOBJECT("odbc_command")

goConn.BeginTransaction()

lcSql = "update faltantes set usuBaja = '" + ALLTRIM(gcCodUsu) + "', "

IF VAL(getConfig("SQLSRV")) = 1 THEN
	lcSql = lcSql + "fecBaja = GETDATE(), "
ELSE
	lcSql = lcSql + "fecBaja = current_timestamp, "
ENDIF

lcSql = lcSql + "idHostBaja = '" + ALLTRIM(SYS(0)) + "' "
lcSql = lcSql + "where idFaltante = " + ALLTRIM(STR(tnIdFaltante))

loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = lcSql

IF !loCommand.Execute() THEn
	THIS.ErrorMessage = loCommand.ErrorMessage
	goConn.Rollback()
	RETURN .F.
ENDIF

goConn.Commit()

RETURN .T.
ENDPROC
PROCEDURE crear_cursor
*CREATE CURSOR cur_faltantes (	;
*	idFaltante	int,;
*	idArticulo	int,;
*	codArt		varchar	(20),;
*	uniCpr		float	(10, 2),;
*	cantidad	float	(10, 2),;
*	procesado	L,;
*	idOcCab		int)


ENDPROC
PROCEDURE procesar
PARAMETERS tnIdFaltante, tnIdOcCab

LOCAL lcSql
LOCAL loCommand

lcSql = ""
loCommand = CREATEOBJECT("odbc_command")

lcSql = "UPDATE faltantes SET procesado = 1, idOcCab = " + ALLTRIM(STR(tnIdOcCab)) + " "
lcSql = lcSql + "WHERE idFaltante = " + ALLTRIM(STR(tnIdFaltante))

loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = lcSql

IF !loCommand.Execute() THEn
	THIS.ErrorMessage = loCommand.ErrorMessage
	goConn.Rollback()
	RETURN .F.
ENDIF

RETURN .T.
ENDPROC


************************************************************
OBJETO: cls_planifcpr
************************************************************
*** PROPIEDADES ***
Comment = ""
Height = 17
Width = 98
idpdcab = 0
idprov = 0
fecent = {}
basecalc = 0
cntds = 0
observ = 
emitido = 0
estado = 
usualta = 
fecalta = {}
idhostalta = 
usumodi = 
fecmodi = {}
idhostmodi = 
usubaja = 
fecbaja = {}
idhostbaja = .F.
errormessage = 
fecdesde = {}
fechasta = {}
totunid = 0.00
idmarca = 0
impneto = 0.00
impfinal = 0.00
poriva21 = 0.00
impiva21 = 0.00
poriva105 = 0.00
impiva105 = 0.00
poriibb = 0.00
impiibb = 0.00
pordesc1 = 0.00
pordesc2 = 0.00
pordesc3 = 0.00
pordesc4 = 0.00
impdesc1 = 0.00
impdesc2 = 0.00
impdesc3 = 0.00
impdesc4 = 0.00
totfact = 0.00
saldo = 0.00
porrec = 0.00
imprec = 0.00
idcomprasc = 0
totcosto = 0.00
totped = 0.00
unidesp = 0.00
cantpack = 0.00
idoccab = 0
totprlista = 0.00
Name = "cls_planifcpr"

*** METODOS ***
PROCEDURE leer_estadistica
LOCAL lcSql, loRes, loRes2, loDT, loConDMO, lnSqlSrv 

lcSql = ""
loRes = CREATEOBJECT("odbc_result")
loRes2 = CREATEOBJECT("odbc_result")
loDT = CREATEOBJECT("datetime")
loConDMO = CREATEOBJECT("odbc_connect")
lnSqlSrv = INT(VAL(getconfig("SQLSRV")))

***********************************************************************************************************************
&& Levanto las ventas en crudo de Cuenta 1

lcSql = "select		year(ventascab.fecEmision) as anio,	"
lcSql = lcSql + "	month(ventascab.fecEmision) as mes,	"
lcSql = lcSql + "	ventasdet.idArticulo, "
lcSql = lcSql + "	articulos.codArt, "
lcSql = lcSql + "	case ventascab.cbte when 'NC' then ventasdet.cantidad * -1 else ventasdet.cantidad end cantidad "
lcSql = lcSql + "from	ventascab "
lcSql = lcSql + "			inner join ventasdet on ventascab.idVentasC = ventasdet.idVentasC "
lcSql = lcSql + "			inner join articulos on ventasdet.idArticulo = articulos.idArticulo "
lcSql = lcSql + "where	ventascab.cbte IN ('FC', 'NC', 'PTO') "
lcSql = lcSql + "	and articulos.idProv = " + ALLTRIM(STR(this.idprov)) + " "

IF INT(VAL(getConfig("SQLSRV"))) = 1 THEN
	lcSql = lcSql + "	and ventascab.fecEmision between CONVERT(CHAR(8)," + loDT.toMySql(this.fecDesde) +", 112) and  CONVERT(CHAR(8), " + loDT.toMySql(this.fecHasta) + ", 112) "
ELSE
	lcSql = lcSql + "	and ventascab.fecEmision between " + loDT.toMySql(this.fecDesde) +" and  " + loDT.toMySql(this.fecHasta) + " "
ENDIF

lcSql = lcSql + "order by year(ventascab.fecEmision), month(ventascab.fecEmision)"

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_vtas"

IF !loRes.OpenQuery(lcSql) THEN
	this.errorMessage = loRes.Error_Message
	RETURN .F.
ENDIF

***********************************************************************************************************************
&& Levanto las ventas en crudo de Cuenta 2, si es que la base de cuenta dos existe!!

IF ALLTRIM(getConfig("DMO_CC")) != "DSN=X" THEN 

	loConDMO.ConnectionString = ALLTRIM(getConfig("DMO_CC"))
	
	IF !loConDMO.Open() THEN
		MESSAGEBOX(loConDMO.ErrorMessage, 0+48, Thisform.Caption)
		RETURN .F.
	ENDIF	
	
	lcSql = "select		year(ventascab.fecEmision) as anio,	"
	lcSql = lcSql + "	month(ventascab.fecEmision) as mes,	"
	lcSql = lcSql + "	ventasdet.idArticulo, "
	lcSql = lcSql + "	articulos.codArt, "
	lcSql = lcSql + "	case ventascab.cbte when 'NC' then ventasdet.cantidad * -1 else ventasdet.cantidad end cantidad "
	lcSql = lcSql + "from	ventascab "
	lcSql = lcSql + "			inner join ventasdet on ventascab.idVentasC = ventasdet.idVentasC "
	lcSql = lcSql + "			inner join articulos on ventasdet.idArticulo = articulos.idArticulo "
	lcSql = lcSql + "where	ventascab.cbte IN ('FC', 'NC', 'PTO') "
	lcSql = lcSql + "	and articulos.idProv = " + ALLTRIM(STR(this.idprov)) + " "

	IF INT(VAL(getConfig("SQLSRV"))) = 1 THEN
		lcSql = lcSql + "	and ventascab.fecEmision between CONVERT(CHAR(8)," + loDT.toMySql(this.fecDesde) +", 112) and  CONVERT(CHAR(8), " + loDT.toMySql(this.fecHasta) + ", 112) "
	ELSE
		lcSql = lcSql + "	and ventascab.fecEmision between " + loDT.toMySql(this.fecDesde) +" and  " + loDT.toMySql(this.fecHasta) + " "
	ENDIF
	
	lcSql = lcSql + "order by year(ventascab.fecEmision), month(ventascab.fecEmision)"

	&& Si no hay nada en la primer consulta, tengo que crear cur_vtas
	SELECT cur_vtas
	IF RECCOUNT("cur_vtas") > 0 THEN
		loRes2.ActiveConnection = loConDMO.ActiveConnection
		loRes2.Cursor_Name = "cur_vtas_C2"	
		
		IF !loRes2.OpenQuery(lcSql) THEN
			this.errorMessage = loRes2.Error_Message
			RETURN .F.
		ENDIF
		
		&& Recorro el cursor con las ventas de cuenta dos y las meto en el cursor cur_vtas
		SELECT cur_vtas_C2
		IF RECCOUNT("cur_vtas_C2") > 0 THEN
			GO TOP
		ENDIF  

		DO WHILE !EOF("cur_vtas_C2")
			SELECT cur_vtas
			APPEND BLANK
			
			&&REPLACE cur_vtas.anio WITH IIF(TYPE("cur_vtas_C2.anio") == "C", INT(VAL(cur_vtas_C2.anio)), cur_vtas_C2.anio)
			&&REPLACE cur_vtas.mes WITH IIF(TYPE("cur_vtas_C2.mes") == "C", INT(VAL(cur_vtas_C2.mes)), cur_vtas_C2.mes) ADDITIVE 
			
			REPLACE cur_vtas.anio WITH cur_vtas_C2.anio
			REPLACE cur_vtas.mes WITH cur_vtas_C2.mes ADDITIVE
			REPLACE cur_vtas.idArticulo WITH cur_vtas_C2.idArticulo ADDITIVE 
			REPLACE cur_vtas.CodArt WITH cur_vtas_C2.CodArt ADDITIVE 
			REPLACE cur_vtas.Cantidad WITH cur_vtas_C2.Cantidad ADDITIVE 
			
			SELECT cur_vtas_C2
			SKIP 
		ENDDO 	
		
		loRes2.close_query()
		loConDMO.close()	
	ELSE 
		loRes2.ActiveConnection = loConDMO.ActiveConnection
		loRes2.Cursor_Name = "cur_vtas"	
		
		IF !loRes2.OpenQuery(lcSql) THEN
			this.errorMessage = loRes2.Error_Message
			RETURN .F.
		ENDIF
	ENDIF  
ENDIF 

***********************************************************************************************************************
&& Tomo el cursor con las ventas generales y las meto en otro cursor agrupando por año y mes.
SELECT cur_vtas
IF RECCOUNT("cur_vtas") > 0 THEN
	GO TOP
ENDIF

SELECT anio, mes, idArticulo, MAX(CodArt)as CodArt, SUM(Cantidad) as Cantidad;
FROM cur_vtas;
GROUP BY anio, mes, idArticulo;
INTO CURSOR cur_ventastot;

&& Genero el cursor definitivo
SELECT cur_ventastot
IF RECCOUNT("cur_ventastot") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_ventastot")
	SELECT cur_estad
	APPEND BLANK
	
	&&REPLACE cur_estad.anio 			WITH IIF(lnSqlSrv = 1,cur_ventastot.anio,INT(VAL(cur_ventastot.anio)))
	&&REPLACE cur_estad.mes 			WITH IIF(lnSqlSrv = 1,cur_ventastot.mes,INT(VAL(cur_ventastot.mes))) ADDITIVE
	IF lnSqlSrv = 1 THEN 
		REPLACE cur_estad.anio 			WITH cur_ventastot.anio
		REPLACE cur_estad.mes 			WITH cur_ventastot.mes ADDITIVE
	ELSE 
		REPLACE cur_estad.anio 			WITH INT(VAL(cur_ventastot.anio))
		REPLACE cur_estad.mes 			WITH INT(VAL(cur_ventastot.mes)) ADDITIVE
	ENDIF 

	REPLACE cur_estad.idArticulo 	WITH cur_ventastot.idArticulo ADDITIVE
	REPLACE cur_estad.codArt 		WITH cur_ventastot.codArt ADDITIVE
	REPLACE cur_estad.cantidad 		WITH cur_ventastot.cantidad ADDITIVE

	SELECT cur_ventastot
	SKIP
ENDDO

SELECT cur_ventastot
IF RECCOUNT("cur_ventastot") > 0 THEN
	GO TOP
ENDIF

loRes.close_query()
RETURN .T.
ENDPROC
PROCEDURE grabar
LOCAL loCommand, lcSql
LOCAL lnProxID, loDT, lnNroReng

loCommand = CREATEOBJECT("odbc_command")
loRes = CREATEOBJECT("odbc_result")
loDT = CREATEOBJECT("datetime")
lcSql = ""
lnProxID = 0
lnNroReng = 0

lnProxID = goConn.getNextID("pccab", "idPCCab")

goConn.BeginTransaction()

lcSql = "insert into pccab ( "
lcSql = lcSql + " 	idPCCab, "
lcSql = lcSql + "	idProv, "
lcSql = lcSql + "	idMarca, "
lcSql = lcSql + "	fecDesde, "
lcSql = lcSql + "	fecHasta, "
lcSql = lcSql + "	fecEnt, "
lcSql = lcSql + "	baseCalc, "
lcSql = lcSql + "	cntDS, "
lcSql = lcSql + "	observ, "
lcSql = lcSql + "	emitido, "
lcSql = lcSql + "	estado, "
lcSql = lcSql + "	usuAlta, "
lcSql = lcSql + "	fecAlta, "
lcSql = lcSql + "	idHostAlta) "
lcSql = lcSql + "VALUES ( "
lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", "
lcSql = lcSql + ALLTRIM(STR(this.idProv)) + ", "
lcSql = lcSql + ALLTRIM(IIF(this.idmarca = 0, "NULL", STR(this.idmarca))) + ", "
lcSql = lcSql + loDT.toMySql(this.fecdesde) + ", "
lcSql = lcSql + loDT.toMySql(this.fecHasta) + ", "
lcSql = lcSql + loDT.toMySql(this.fecEnt) + ", "
lcSql = lcSql + ALLTRIM(STR(this.basecalc)) + ", "
lcSql = lcSql + ALLTRIM(STR(this.cntds)) + ", "
lcSql = lcSql + "'" + ALLTRIM(this.observ) + "', "
lcSql = lcSql + ALLTRIM(STR(this.emitido)) + ", "
lcSql = lcSql + "'P', "
lcSql = lcSql + "'" + ALLTRIM(this.usualta) + "', "
lcSql = lcSql + loDT.toMySql(this.fecAlta) + ", "
lcSql = lcSql + "'" + ALLTRIM(this.idhostalta) + "')"

loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = lcSql

IF !loCommand.Execute() THEN
	this.ErrorMessage = loCommand.ErrorMessage
	goConn.Rollback()
	RETURN .F.
ENDIF

SELECT cur_pcdet
IF RECCOUNT("cur_pcdet") > 0 THEN
	GO TOP
ENDIF

lnNroReng = 1

DO WHILE !EOF("cur_pcdet")

	lcSql = "insert into pcdet ( "
	lcSql = lcSql + "	idPCDet, "
	lcSql = lcSql + "	idPCCab, "
	lcSql = lcSql + "	idArticulo, "
	lcSql = lcSql + "	codArt, "
	lcSql = lcSql + "	vtaMax, "
	lcSql = lcSql + "	promed, "
	lcSql = lcSql + "	stkMin, "
	lcSql = lcSql + "	stkDis, "
	lcSql = lcSql + "	cantPed, "
	lcSql = lcSql + "	pendi, "
	lcSql = lcSql + "	faltant, "
	lcSql = lcSql + "	diasCub, "
	lcSql = lcSql + "	costo, "
	lcSql = lcSql + "	prLista, "
	lcSql = lcSql + "	unidesp, "
	lcSql = lcSql + "	cantpack) "
	lcSql = lcSql + "VALUES ("
	lcSql = lcSql + ALLTRIM(STR(lnNroReng)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_pcdet.idArticulo)) + ", "
	lcSql = lcSql + "'" + ALLTRIM(cur_pcdet.codArt) + "', "
	lcSql = lcSql + ALLTRIM(STR(cur_pcdet.vtaMax, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_pcdet.promed, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_pcdet.stkMin, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_pcdet.stkDis, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_pcdet.cantPed, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_pcdet.pendi, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_pcdet.faltant, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_pcdet.diasCub)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_pcdet.costo, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_pcdet.prLista, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_pcdet.unidesp, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_pcdet.cantpack, 10, 2)) + ")"
	
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute() THEN
		this.ErrorMessage = loCommand.ErrorMessage
		goConn.Rollback()
		RETURN .F.
	ENDIF
	
	lnNroReng = lnNroReng + 1
	
	SELECT cur_pcdet
	SKIP
ENDDO

goConn.Commit()

this.idpdcab = lnProxID

RETURN .T.
ENDPROC
PROCEDURE recuperar
LOCAL lcSql, loRes, loProgress
LOCAL lnCont

lcSql = ""
loRes = CREATEOBJECT("odbc_result")
loProgress = CREATEOBJECT("_thermometer")
lnCont = 0

loProgress.Show()

lcSql = "select "
lcSql = lcSql + "pcdet.idPCDet, "
lcSql = lcSql + "pcdet.idPCCab, "
lcSql = lcSql + "pcdet.idArticulo, "
lcSql = lcSql + "pcdet.codArt, "
lcSql = lcSql + "articulos.descripcio, "
lcSql = lcSql + "pcdet.vtaMax, "
lcSql = lcSql + "pcdet.promed, "
lcSql = lcSql + "pcdet.stkMin, "
lcSql = lcSql + "pcdet.stkDis, "
lcSql = lcSql + "pcdet.cantPed, "
lcSql = lcSql + "pcdet.pendi, "
lcSql = lcSql + "pcdet.faltant, "
lcSql = lcSql + "pcdet.diasCub, "
lcSql = lcSql + "pcdet.costo, "
lcSql = lcSql + "pcdet.prLista, "
lcSql = lcSql + "pcdet.unidesp, "
lcSql = lcSql + "pcdet.cantpack "
lcSql = lcSql + "from pcdet inner join articulos on pcdet.idArticulo = articulos.idArticulo "
lcSql = lcSql + "where pcdet.idPCCab = " + ALLTRIM(STR(this.idpdcab)) + " "
lcSql = lcSql + "order by pcdet.codArt"

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_detalle"

IF !loRes.OpenQuery(lcSql) THEN
	this.ErrorMessage = loRes.Error_Message
	RETURN .F.
ENDIF

SELECT cur_detalle
IF RECCOUNT("cur_detalle") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_detalle")
	this.agregar_detalle(cur_detalle.idPCDet, cur_detalle.idPCCab, cur_detalle.idArticulo, ALLTRIM(cur_detalle.codArt), ALLTRIM(cur_detalle.descripcio), ;
		cur_detalle.vtaMax, cur_detalle.promed, cur_detalle.stkMin, cur_detalle.stkDis, cur_detalle.cantPed, cur_detalle.unidesp, cur_detalle.cantpack, ;
		cur_detalle.pendi, cur_detalle.faltant, cur_detalle.diasCub, cur_Detalle.costo, cur_detalle.prLista)

	lnCont = lnCont + 1
	loProgress.update((lnCont * 100) / RECCOUNT("cur_detalle"), "Leyendo planificación...")
	
	SELECT cur_detalle
	SKIP
ENDDO

loRes.Close_Query()

loProgress.Complete()

RETURN .T.

ENDPROC
PROCEDURE crear_cursor
&& El siguiente cursor contiene las cabeceras de planificación disponibles
&& para seleccionar en una pantalla.
CREATE CURSOR cur_pccab (	;
	idPCCab		int,;
	idProv		int,;
	razSoc		varchar(60),;
	fecDesde	datetime,;
	fecHasta	datetime,;
	fecEnt		datetime,;
	baseCalc	int,;
	cntDS		int,;
	observ		M,;
	emitido		l,;
	estado		varchar(2),;
	usuAlta		varchar(5),;
	fecAlta		datetime,;
	idHostAlta	varchar(50),;
	usuModi		varchar(5) NULL,;
	fecModi		datetime NULL,;
	idHostModi	varchar(50) NULL)
	

&& El siguiente cursor contiene el detalle durante la confección
&& del detalle
CREATE CURSOR cur_pcdet (	;
	idPCDet		int,;
	idPCCab		int,;
	idArticulo	int,;
	codArt		varchar(20),;
	descripcio	varchar(60),;
	vtaMax		float(10, 2),;
	faltant		float(10, 2),;
	pendi		float(10, 2),;
	stkDis		float(10, 2),;
	cantPed		float(10, 2),;
	UniDesp		float(10, 2),;
	cantPack	float(10, 2),;
	diasCub		int,;
	costo		float(10, 2),;
	prLista		float(10, 2),;
	promed		float(10, 2),;
	stkMin		float(10, 2))
	
SELECT cur_pcdet
INDEX ON cur_pcdet.idPCDet TAG idPCDet ASCENDING
INDEX ON cur_pcdet.idPCCab TAG idPCCab ASCENDING ADDITIVE
INDEX ON cur_pcdet.idArticulo TAG idArticulo ASCENDING ADDITIVE
INDEX ON cur_pcdet.descripcio TAG descripcio ASCENDING ADDITIVE
INDEX ON cur_pcdet.vtaMax TAG vtaMax ASCENDING ADDITIVE
INDEX ON cur_pcdet.faltant TAG faltant ASCENDING ADDITIVE
INDEX ON cur_pcdet.pendi TAG pendi ASCENDING ADDITIVE
INDEX ON cur_pcdet.stkDis TAG stkDis ASCENDING ADDITIVE
INDEX ON cur_pcdet.cantPed TAG cantPed ASCENDING ADDITIVE
INDEX ON cur_pcdet.UniDesp TAG UniDesp ASCENDING ADDITIVE
INDEX ON cur_pcdet.cantPack TAG cantPack ASCENDING ADDITIVE
INDEX ON cur_pcdet.diasCub TAG diasCub ASCENDING ADDITIVE
INDEX ON cur_pcdet.costo TAG costo ASCENDING ADDITIVE
INDEX ON cur_pcdet.prLista TAG prLista ASCENDING ADDITIVE
INDEX ON cur_pcdet.promed TAG promed ASCENDING ADDITIVE
INDEX ON cur_pcdet.stkMin TAG stkMin ASCENDING ADDITIVE	
INDEX ON cur_pcdet.codArt TAG codArt ASCENDING ADDITIVE

&& El siguiente se usa para levantar la estadística de ventas
CREATE CURSOR cur_estad ( ;
	anio		int,;
	mes			int,;
	idArticulo	int,;
	codArt		varchar(20),;
	cantidad	float(10, 2))
	
SELECT cur_estad
INDEX ON cur_estad.idArticulo TAG idArticulo ASCENDING 
INDEX ON cur_estad.codArt TAG codARt ASCENDING ADDITIVE
INDEX ON cur_estad.cantidad TAG cantidad ASCENDING ADDITIVE
INDEX ON cur_estad.anio TAG anio ASCENDING ADDITIVE
INDEX ON cur_estad.mes TAG mes ASCENDING ADDITIVE
	

&& El siguiente cursor tiene las subfamilias.
CREATE CURSOR cur_sfam (	;
	selected	l,;
	idSubFam	int,;
	descripcio	varchar(60))

SELECT cur_sfam
INDEX ON selected TAG selected ASCENDING
INDEX ON descripcio TAG descripcio ASCENDING ADDITIVE	
INDEX ON idSubFam TAG idSubFam ASCENDING ADDITIVE

	
&& Contiene el detalle de los movimientos de stock
CREATE CURSOR cur_stock (	;
	circuito	varchar(1),;
	fecAlta		datetime,;
	nroPart		varchar(20),;
	cbte		varchar(3),;
	tipoDoc		varchar(1),;
	numCbte		varchar(13),;
	entrada		float(10, 2),;
	salida		float(10, 2),;
	saldo		float(10, 2))

SELECT cur_stock
INDEX ON circuito TAG circuito ASCENDING
INDEX ON nroPart TAG nroPart ASCENDING ADDITIVE
INDEX ON cbte TAG cbte ASCENDING ADDITIVE
INDEX ON tipoDoc TAG tipoDoc ASCENDING ADDITIVE
INDEX ON numCbte TAG numCbte ASCENDING ADDITIVE
INDEX ON entrada TAG entrada ASCENDING ADDITIVE
INDEX ON salida TAG salida ASCENDING ADDITIVE
INDEX ON saldo TAG saldo ASCENDING ADDITIVE
INDEX ON fecAlta TAG fecAlta ASCENDING ADDITIVE

&& El siguiente cursor contiene el detalle de los comprobantes de compras. 
CREATE CURSOR cur_cpasdet (	;
	idCompraD	int,;
	idCompraC	int,;
	idArticulo	int,;
	codArt		varchar(20),;
	cantidad	float(10, 2),;
	cantNC		float(10, 2),;
	costoRep	float(10, 2),;
	prArtic		float(10, 2),;
	prCompra	float(10, 2),;
	porDesc1	float(10, 2),;
	porDesc2	float(10, 2),;
	porDesc3	float(10, 2),;
	porDesc4	float(10, 2),;
	impDesc1	float(10, 2),;
	impDesc2	float(10, 2),;
	impDesc3	float(10, 2),;
	impDesc4	float(10, 2),;
	impNeto		float(10, 2),;
	totNeto		float(10, 2),;
	alicIVA		float(10, 2),;
	impIVA		float(10, 2),;
	subTotal	float(10, 2))
	
	
&& Armo los cursores de las Ordenes de Compras
CREATE CURSOR cur_occab(;
	idOcCab		int,;
	idProv		int,;
	RazSoc		varchar(60),;
	idMarca		int,;
	Marca		varchar(60),;
	idPcCab		int,;
	Fecha		datetime,;
	FecEnt		datetime,;	
	iTotCosto	float(10, 2),;
	iTotLista	float(10, 2),;
	cantTot 	float(10, 2),;
	observ		M,;
	estado		l,;
	entregado	l)


SELECT cur_occab
INDEX ON idProv TAG idProv ASCENDING ADDITIVE 
INDEX ON RazSoc TAG RazSoc ASCENDING ADDITIVE 
INDEX ON idMarca TAG idMarca ASCENDING ADDITIVE 
INDEX ON Marca TAG Marca ASCENDING ADDITIVE 
INDEX ON idPcCab TAG idPcCab ASCENDING ADDITIVE 
INDEX ON Fecha TAG Fecha ASCENDING ADDITIVE 
INDEX ON FecEnt TAG FecEnt ASCENDING ADDITIVE 
INDEX ON iTotCosto TAG iTotCosto ASCENDING ADDITIVE 
INDEX ON iTotLista TAG iTotLista ASCENDING ADDITIVE 
INDEX ON cantTot  TAG cantTot ASCENDING ADDITIVE 
INDEX ON estado TAG estado ASCENDING ADDITIVE 
INDEX ON idOcCab TAG idOcCab ASCENDING

CREATE CURSOR cur_ocdet(;
	idOcDet		int,;
	idOcCab		int,;
	codArt		varchar(20),;
	descripcio	varchar(60),;	
	idArticulo	int,;
	UniDesp		float(10, 2),;
	cantPack	float(10, 2),;
	codUM		varchar(3),;
	CantPed		float(10, 2),;
	CantRec		float(10, 2),;
	Pendiente	float(10, 2),;
	Costo		float(10, 2),;
	PrLista		float(10, 2),;
	TotCosto	float(10, 2),;
	TotPrLista	float(10, 2),;
	Activo		l)


SELECT cur_ocdet
INDEX ON idOcDet TAG idOcDet ASCENDING
INDEX ON idOcCab TAG idOcCab ASCENDING ADDITIVE 
INDEX ON idArticulo TAG idArticulo ASCENDING ADDITIVE 
INDEX ON codArt TAG codArt ASCENDING ADDITIVE 
INDEX ON descripcio TAG descripcio ASCENDING ADDITIVE 
INDEX ON UniDesp TAG UniDesp ASCENDING ADDITIVE 
INDEX ON cantPack TAG cantPack ASCENDING ADDITIVE 
INDEX ON codUM TAG codUM ASCENDING ADDITIVE 
INDEX ON CantPed TAG CantPed ASCENDING ADDITIVE 
INDEX ON CantRec TAG CantRec ASCENDING ADDITIVE 
INDEX ON Pendiente TAG Pendiente ASCENDING ADDITIVE 
INDEX ON Costo TAG Costo ASCENDING ADDITIVE 
INDEX ON PrLista TAG PrLista ASCENDING ADDITIVE 
INDEX ON TotCosto TAG TotCosto ASCENDING ADDITIVE 
INDEX ON TotPrLista TAG TotPrLista ASCENDING ADDITIVE 
INDEX ON Activo TAG Activo ASCENDING ADDITIVE 



CREATE CURSOR cur_ocart(;
	idOcCab		int,;
	idPcCab		int,;
	Fecha		datetime,;
	FecEnt		datetime,;
	cantPed		float(10, 2),;	
	cantRec		float(10, 2),;	
	Pendiente	float(10, 2),;		
	Costo		float(10, 2),;
	PrLista		float(10, 2),;
	Activo		l)

SELECT cur_ocart
INDEX ON idPcCab TAG idPcCab ASCENDING ADDITIVE 
INDEX ON Fecha TAG Fecha ASCENDING ADDITIVE 
INDEX ON FecEnt TAG FecEnt ASCENDING ADDITIVE 
INDEX ON cantPed TAG cantPed ASCENDING ADDITIVE 
INDEX ON cantRec TAG cantRec ASCENDING ADDITIVE 
INDEX ON Pendiente TAG Pendiente ASCENDING ADDITIVE 
INDEX ON Costo TAG Costo ASCENDING ADDITIVE 
INDEX ON PrLista TAG PrLista ASCENDING ADDITIVE 
INDEX ON Activo TAG Activo ASCENDING ADDITIVE 
INDEX ON idOcCab TAG idOcCab ASCENDING
	
	
CREATE CURSOR cur_ocPend(;
	sel 		l,;
	idOcDet		int,;
	idOcCab		int,;
	idArticulo	int,;
	codArt		varchar(20),;
	descripcio	varchar(60),;		
	Fecha		date,;
	FecEnt		date,;
	cantPed		float(10, 2),;	
	cantRec		float(10, 2),;	
	Pendiente	float(10, 2))

SELECT cur_ocPend
INDEX ON sel TAG sel ASCENDING 
INDEX ON idOcDet TAG idOcDet ASCENDING ADDITIVE 
INDEX ON idOcCab TAG idOcCab ASCENDING ADDITIVE 
INDEX ON idArticulo TAG idArticulo ASCENDING ADDITIVE 
INDEX ON descripcio TAG descripcio ASCENDING ADDITIVE 
INDEX ON Fecha TAG Fecha ASCENDING ADDITIVE 
INDEX ON FecEnt TAG FecEnt ASCENDING ADDITIVE 
INDEX ON cantPed TAG cantPed ASCENDING ADDITIVE 
INDEX ON cantRec TAG cantRec ASCENDING ADDITIVE 
INDEX ON Pendiente TAG Pendiente ASCENDING ADDITIVE
INDEX ON codArt TAG codArt ASCENDING ADDITIVE 


ENDPROC
PROCEDURE agregar_detalle
PARAMETERS tnIdPCDet, tnIdPCCab, tnIdArticulo, tcCodArt, tcDescripcio, ;
	tnVtaMax, tnPromed, tnStkMin, tnStkDisp, tnCantPed, tnUniDesp, tncantPack, tnPendi, tnFaltant, ;
	tnDiasCub, tnCosto, tnPrLista

SELECT cur_pcdet
APPEND BLANK
REPLACE cur_pcdet.idPCDet 		WITH tnIdPCDet
REPLACE cur_pcdet.idPCCab 		WITH tnIdPCCab 								ADDITIVE
REPLACE cur_pcdet.idArticulo 	WITH tnIdArticulo 							ADDITIVE
REPLACE cur_pcdet.codArt 		WITH ALLTRIM(tcCodArt) 						ADDITIVE
REPLACE cur_pcdet.descripcio 	WITH ALLTRIM(tcDescripcio) 					ADDITIVE
REPLACE cur_pcdet.vtaMax 		WITH IIF(ISNULL(tnVtaMax), 0, tnVtaMax) 	ADDITIVE
REPLACE cur_pcdet.faltant 		WITH IIF(ISNULL(tnFaltant), 0, tnFaltant) 	ADDITIVE
REPLACE cur_pcdet.pendi 		WITH IIF(ISNULL(tnPendi), 0, tnPendi) 		ADDITIVE
REPLACE cur_pcdet.stkDis 		WITH IIF(ISNULL(tnStkDisp), 0, tnStkDisp) 	ADDITIVE
REPLACE cur_pcdet.cantPed 		WITH IIF(ISNULL(tnCantPed), 0, tnCantPed) 	ADDITIVE
REPLACE cur_pcdet.UniDesp		WITH IIF(ISNULL(tnUniDesp), 0, tnUniDesp) 	ADDITIVE
REPLACE cur_pcdet.cantPack		WITH IIF(ISNULL(tncantPack), 0, tncantPack) ADDITIVE
REPLACE cur_pcdet.diasCub 		WITH IIF(ISNULL(tnDiasCub), 0, tnDiasCub) 	ADDITIVE
REPLACE cur_pcdet.costo 		WITH IIF(ISNULL(tnCosto), 0, tnCosto) 		ADDITIVE
REPLACE cur_pcdet.prLista 		WITH IIF(ISNULL(tnPrLista), 0, tnPrLista) 	ADDITIVE
REPLACE cur_pcdet.promed 		WITH IIF(ISNULL(tnPromed), 0, tnPromed) 	ADDITIVE
REPLACE cur_pcdet.stkMin 		WITH IIF(ISNULL(tnStkMin), 0, tnStkMin) 	ADDITIVE

ENDPROC
PROCEDURE planificar
LOCAL loRes, lcSql, loPend
LOCAL lnVtaMax, lnPromedio, lnStkMin, lnStkDis
LOCAL lnCantPed, lnPendi, lnFaltant, lnDiasCub, lnCosto, lnPrLista
LOCAL lnNroReng, lnDiasCub, loTherm, lnCont

loRes = CREATEOBJECT("odbc_result")
loPend = CREATEOBJECT("odbc_result")
lcSql = ""

lnVtaMax = 0.00
lnPromedio = 0.00
lnStkMin = 0.00
lnStkDis = 0.00
lnCantPed = 0.00
lnPendi = 0.00
lnFaltant = 0.00
lnDiasCub = 0.00
lnCosto = 0.00
lnPrLista = 0.00
lnNroReng = 0
lnDiasCub = 0
loTherm = CREATEOBJECT("_thermometer")

loTherm.Show()

SELECT cur_sfam
IF RECCOUNT("cur_sfam") > 0 THEN
	GO TOP
ENDIF

lnCont = 0
SELECT cur_sfam
DO WHILE !EOF("cur_sfam")
	
	&& Levanto el stock actual de los articulos segun las subfamilias seleccionadas
	IF cur_sfam.selected THEN
		lcSql = "select	articulos.idArticulo,	"
		lcSql = lcSql + "	max(articulos.codArt) as codArt, "
		lcSql = lcSql + "	max(articulos.descripcio) as descripcio, "
		
		IF INT(VAL(getConfig("SQLSRV"))) = 1 THEN
			lcSql = lcSql + "	sum(isnull(stk_det.cantidad, 0)) as cntExist, "
		ELSE
			lcSql = lcSql + "	sum(ifnull(stk_det.cantidad, 0)) as cntExist, "
		ENDIF
		
		lcSql = lcSql + "	max(articulos.costoRep) as costoRep, "
		lcSql = lcSql + "	max(articulos.prLista) as prLista "
		lcSql = lcSql + "from 	articulos "
		lcSql = lcSql + "			left join stk_det on articulos.idArticulo = stk_det.idArticulo "
		lcSql = lcSql + "where 	idProv = " + ALLTRIM(STR(this.idprov)) + " "
		lcSql = lcSql + "	and idSubFam = " + ALLTRIM(STR(cur_sfam.idSubFam)) + " "
		lcSql = lcSql + "	and articulos.habilitado = 1 "
		lcSql = lcSql + "	and RIGHT(articulos.codArt, 3) != 'ARX' "
		
		IF this.idMarca <> 0 THEN
			lcSql = lcSql + "	and idMarca = " + ALLTRIM(STR(this.idMarca)) + " " 
		ENDIF
		
		lcSql = lcSql + "group by articulos.idArticulo "
		lcSql = lcSql + "order by MAX(articulos.codArt)"
		
		loRes.ActiveConnection = goConn.ActiveConnection
		loRes.Cursor_Name = "cur_artic"

		IF !loRes.OpenQuery(lcSql) THEN
			this.ErrorMessage = loRes.Error_Message
			RETURN .F.
		ENDIF

		SELECT cur_artic
		IF RECCOUNT("cur_artic") > 0 THEN
			GO TOP
		ENDIF

		lnNroReng = 1

		SELECT cur_artic
		DO WHILE !EOF("cur_artic")
			lnCosto = cur_artic.costoRep
			lnPrLista = cur_artic.prLista
			lnStkDis = cur_artic.cntExist
		
			***************************************************************
			&& Calculo la venta máxima
			SELECT	MAX(cur_estad.cantidad) AS maxCant, ;
					AVG(cur_estad.cantidad) AS promCant ;
			FROM	cur_estad ;
			WHERE	cur_estad.idArticulo = cur_artic.idArticulo ;
			INTO CURSOR cur_maxvta
			
			lnVtaMax = cur_maxvta.maxCant
			lnPromedio = cur_maxvta.promCant
			
			USE IN cur_maxvta
			
			IF this.basecalc = 1 THEN
				lnStkMin = lnVtaMax
			ELSE
				lnStkMin = lnPromedio
			ENDIF
		
			***************************************************************
			&& Calculo los pendientes
			lnPendi = this.calc_pendientes(cur_artic.idArticulo)
			
			***************************************************************
			&& Calculo los dias cubiertos
			lnDiasCub = this.calc_diascub(lnStkDis, lnStkMin, lnPendi, 0.00)
			
			***************************************************************
			&& Inserto el detalle en el cursor
			SELECT cur_pcdet			
			this.agregar_detalle(lnNroReng, 0, cur_artic.idArticulo, cur_artic.codArt, cur_artic.descripcio, ;
				lnVtaMax, lnPromedio, lnStkMin, lnStkDis, 0.00, 0.00, 0.00, lnPendi, lnFaltant, ;
				lnDiasCub, lnCosto, lnPrLista)
			
			lnNroReng = lnNroReng + 1

			SELECT cur_artic
			SKIP
		ENDDO

		loRes.Close_Query()		
	ENDIF
	
	lnCont = lnCont + 1
	loTherm.update((lnCont * 100) / RECCOUNT("cur_sfam"), "Planificando compras...")
	
	SELECT cur_sfam
	SKIP
ENDDO

loTherm.Complete()

RETURN .T.
ENDPROC
PROCEDURE calc_diascub
PARAMETERS tn_StkDisp, tn_StkMin, tn_Pend, tn_Pedir

LOCAL ln_DiasCub

ln_DiasCub = 0

IF tn_StkMin <> 0 THEN
	ln_DiasCub = (tn_StkDisp + tn_Pend + tn_Pedir) / tn_StkMin * 30
ELSE
	IF tn_StkDisp <> 0 THEN
		ln_DiasCub = 9999
	ELSE
		ln_DiasCub = 0
	ENDIF
ENDIF

RETURN ln_DiasCub
ENDPROC
PROCEDURE limpiar
SELECT cur_pcdet
ZAP

SELECT cur_estad
ZAP

SELECT cur_sfam
ZAP

SELECT cur_cpasdet
ZAP

SELECT cur_stock
ZAP

SELECT cur_ocdet
ZAP 

SELECT cur_ocart
ZAP 

SELECT cur_ocpend
ZAP 
ENDPROC
PROCEDURE generar_fc
LOCAL loRes, lcSql, loCommand, loDT
LOCAL lnProxID, lnNroReng, loTherm

LOCAL lnIdProv, lnIdCondPago, lnIdSitIVA, ldFecEmision
LOCAL lcCbte, lcTipoDoc, lnPtoVta, lnNumCbte, llAnulado
LOCAL lnImpNeto, lnImpFinal, lnPorIVA21, lnImpIVA21, lnPorIVA105, lnImpIVA105
LOCAL lnPorIIBB, lnImpIIBB, lnPorDesc1, lnPorDesc2, lnPorDesc3, lnPorDesc4
LOCAL lnImpDesc1, lnImpDesc2, lnImpDesc3, lnImpDesc4, lnTotFact, lnSaldo
LOCAL llEsPendi, lcObserv, lnIdCompraD, loNumerador

loNumerador = CREATEOBJECT("cls_numeradores")
lnIdProv = this.idprov
lnCondPago = 0
lnIdSitIVA = 0
ldFecEmision = DATETIME()
lcCbte = "OC"
lcTipoDoc = ""
lnPtoVta = ""
lnNumCbte = 0
llAnulado = .F.
lnImpNeto = 0.00
lnImpFinal = 0.00
lnPorIVA21 = 0.00
lnImpIVA21 = 0.00
lnPorIVA105 = 0.00
lnImpIVA105 = 0.00
lnPorIIBB = 0.00
lnImpIIBB = 0.00
lnPorDesc1 = 0.00
lnImpDesc1 = 0.00
lnPorDesc2 = 0.00
lnImpDesc2 = 0.00
lnPorDesc3 = 0.00
lnImpDesc3 = 0.00
lnPorDesc4 = 0.00
lnImpDesc4 = 0.00
lnTotFact = 0.00
lnSaldo = 0.00
llEsPendi = .F.
lcObserv = ""
lnResp = 0

lcSql  = ""
loRes = CREATEOBJECT("odbc_result")
loCommand = CREATEOBJECT("odbc_command")
loDT = CREATEOBJECT("datetime")
lnProxID = goConn.getNextID("comprascab", "idCompraC")
lnNroReng = 0
loTherm = CREATEOBJECT("_thermometer")

&& Levanto los datos que necesito de la tabla de proveedores
lcSql = "select * from proveedor where idProv = " + ALLTRIM(STR(lnIdProv))
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_tempo"

IF !loRes.OpenQuery(lcSql) THEN
	this.ErrorMessage = loRes.Error_Message
	RETURN .F.
ENDIF

SELECT cur_tempo
IF RECCOUNT("cur_tempo") > 0 THEN
	lnIdCondPago = cur_tempo.idCondPago
	lnIdSitIVA = cur_tempo.idSitIVA
ENDIF

loRes.Close_Query()

loNumerador.cbte = lcCbte
loNumerador.tipoDoc = lcTipoDoc 

IF !loNumerador.getptovta() THEN 
	RETURN .F.
ENDIF 

DO WHILE loNumerador.esta_bloqueado()
	WAIT WINDOW "Otro usuario está emitiendo una orden de compra, por favor espere..." NOWAIT
ENDDO

loNumerador.bloquear()

loTherm.Show()

goConn.BeginTransaction()


SELECT cur_pcdet
IF RECCOUNT("cur_pcdet") > 0 THEN
	GO TOP
ENDIF

lnNroReng = 1

DO WHILE !EOF("cur_pcdet")
	IF cur_pcdet.cantPed > 0 THEN
		this.agregar_det_oc(cur_pcdet.idArticulo, cur_pcdet.cantPed)
	ENDIF
	
	loTherm.update((lnNroReng * 100) / RECCOUNT(), "Generando registros para la Orden de Compra")
	lnNroReng = lnNroReng + 1
	SELECT cur_pcdet
	SKIP
ENDDO

loTherm.Complete()

SELECT cur_cpasdet
IF RECCOUNT("cur_cpasdet") = 0 THEN
	MESSAGEBOX("No se ha generado ningún registro para la Orden de Compra", 0+48, Thisform.Caption)
	loNumerador.desbloquear()
	RETURN .F.
ENDIF

loTherm.show()

lcSql = "insert into comprascab ("
lcSql = lcSql + "idCompraC, "
lcSql = lcSql + "idProv, "
lcSql = lcSql + "idCondPago, "
lcSql = lcSql + "idSitIVA, "
lcSql = lcSql + "fecEmision, "
lcSql = lcSql + "fecVto, "
lcSql = lcSql + "cbte, "
lcSql = lcSql + "tipoDoc, "
lcSql = lcSql + "ptoVta, "
lcSql = lcSql + "numCbte, "
lcSql = lcSql + "anulado, "
lcSql = lcSql + "impNeto, "
lcSql = lcSql + "impFinal, "
lcSql = lcSql + "porIVA21, "
lcSql = lcSql + "impIVA21, "
lcSql = lcSql + "porIVA105, "
lcSql = lcSql + "impIVA105, "
lcSql = lcSql + "porIIBB, "
lcSql = lcSql + "impIIBB, "
lcSql = lcSql + "porDesc1, "
lcSql = lcSql + "impDesc1, "
lcSql = lcSql + "porDesc2, "
lcSql = lcSql + "impDesc2, "
lcSql = lcSql + "porDesc3, "
lcSql = lcSql + "impDesc3, "
lcSql = lcSql + "porDesc4, "
lcSql = lcSql + "impDesc4, "
lcSql = lcSql + "totFact, "
lcSql = lcSql + "saldo, "
lcSql = lcSql + "esPendi, "
lcSql = lcSql + "observ, "
lcSql = lcSql + "procesado, "
lcSql = lcSql + "usuAlta, "
lcSql = lcSql + "fecAlta, "
lcSql = lcSql + "idHostAlta) VALUES ("
lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", "
lcSql = lcSql + ALLTRIM(STR(this.idprov)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnIdCondPago)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnIdSitIVA)) + ", "
lcSql = lcSql + IIF(INT(VAL(getConfig("SQLSRV"))) = 1, "GETDATE(), ", "current_date, ")
lcSql = lcSql + "NULL, "
lcSql = lcSql + "'" + ALLTRIM(loNumerador.cbte) + "', "
lcSql = lcSql + "'" + ALLTRIM(loNumerador.tipoDoc) + "', "
lcSql = lcSql + ALLTRIM(STR(loNumerador.ptoVta)) + ", "
lcSql = lcSql + ALLTRIM(STR(loNumerador.getProxNum())) + ", "
lcSql = lcSql + "0, "
lcSql = lcSql + ALLTRIM(STR(this.impneto, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(this.impfinal, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(this.poriva21, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(this.impiva21, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(this.poriva105, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(this.impiva105, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(this.poriibb, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(this.impiibb, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(this.pordesc1, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(this.impdesc1, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(this.pordesc2, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(this.impdesc2, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(this.pordesc3, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(this.impdesc3, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(this.pordesc4, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(this.impDesc4, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(this.totfact, 10, 2)) + ", "
lcSql = lcSql + "0, "
lcSql = lcSql + "0, "
lcSql = lcSql + "'',"
lcSql = lcSql + "0, "
lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
lcSql = lcSql + IIF(INT(VAL(getConfig("SQLSRV"))) = 1, "GETDATE(), ", "current_date,")
lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "')"


loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = lcSql

IF !loCommand.Execute() THEN
	MESSAGEBOX(loCommand.Error_Message, 0+48, Thisform.Caption)
	goConn.Rollback()
	loNumerador.desbloquear()
	RETURN .F.
ENDIF

SELECT cur_cpasdet
IF RECCOUNT("cur_cpasdet") > 0 THEN
	GO TOP
ENDIF
lnIdCompraD = 1

DO WHILE !EOF("cur_cpasdet")
	SET STEP ON
	lcSql = "INSERT INTO comprasdet ( "
	lcSql = lcSql + "idCompraD, "
	lcSql = lcSql + "idCompraC, "
	lcSql = lcSql + "idArticulo, "
	lcSql = lcSql + "cantidad, "
	lcSql = lcSql + "cantNC, "
	lcSql = lcSql + "costoRep, "
	lcSql = lcSql + "prArtic, "
	lcSql = lcSql + "prCompra, "
	lcSql = lcSql + "porDesc1, "
	lcSql = lcSql + "porDesc2, "
	lcSql = lcSql + "porDesc3, "
	lcSql = lcSql + "porDesc4, "
	lcSql = lcSql + "impDesc1, "
	lcSql = lcSql + "impDesc2, "
	lcSql = lcSql + "impDesc3, "
	lcSql = lcSql + "impDesc4, "
	lcSql = lcSql + "impNeto, "
	lcSql = lcSql + "totNeto, "
	lcSql = lcSql + "alicIVA, "
	lcSql = lcSql + "impIVA, "
	lcSql = lcSql + "subTotal, "
	lcSql = lcSql + "porRec, "
	lcSql = lcSql + "impRec ) "
	lcSql = lcSql + "VALUES ( "
	lcSql = lcSql + ALLTRIM(STR(lnIdCompraD)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_cpasdet.idArticulo)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_cpasdet.cantidad, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_cpasdet.cantNC, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_cpasdet.costoRep, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_cpasdet.prArtic, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_cpasdet.prCompra, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_cpasdet.porDesc1, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_cpasdet.porDesc2, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_cpasdet.porDesc3, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_cpasdet.porDesc4, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_cpasdet.impDesc1, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_cpasdet.impDesc2, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_cpasdet.impDesc3, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_cpasdet.impDesc4, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_cpasdet.impNeto, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_cpasdet.totNeto, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_cpasdet.alicIVA, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_cpasdet.impIVA, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_cpasdet.subTotal, 10, 2)) + ", "
	lcSql = lcSql + "0, "
	lcSql = lcSql + "0)"
	
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute() THEN
		MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
		goConn.Rollback()
		loNumerador.desbloquear()		
		RETURN .F.
	ENDIF
 	
 	loTherm.update((lnIdCompraD * 100) / RECCOUNT(), "Grabando Orden de Compra...")
	lnIdCompraD = lnIdCompraD + 1
	SELECT cur_cpasdet
	SKIP
ENDDO

&& Actualizo el estado de la planificación
lcSql = "update pccab set "
lcSql = lcSql + "emitido = 1, estado = 'E', "
lcSql = lcSql + "usuModi = '" + ALLTRIM(gcCodUsu) + "', "
lcSql = lcSql + "fecModi = " + IIF(INT(VAL(getConfig("SQLSRV"))) = 1, "GETDATE(), ", "current_date, ")
lcSql = lcSql + "idHostModi = '" + ALLTRIM(SYS(0)) + "' "
lcSql = lcSql + "where idPCCab = " + ALLTRIM(STR(this.idpdcab))

loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = lcSql

IF !loCommand.Execute() THEN
	MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
	goConn.Rollback()
	loNumerador.desbloquear()
	RETURN .F.
ENDIF

loNumerador.actualizar()
loNumerador.desbloquear()

goConn.Commit()
loTherm.complete()

this.idcomprasc = lnProxID

RETURN .T.
ENDPROC
PROCEDURE leer_subfam
PARAMETERS tnIdProv, tnIdMarca

LOCAL lcSql, loRes

lcSql = ""
loRes = CREATEOBJECT("odbc_result")

lcSql = "select		subfam.idSubFam, "
lcSql = lcSql + "	max(subfam.descripcio) as descripcio "
lcSql = lcSql + "from subfam inner join articulos on subfam.idSubFam = articulos.idSubFam "
lcSql = lcSql + "where articulos.idProv = " + ALLTRIM(STR(tnIdProv)) + " "

IF tnIdMarca <> 0 THEN
	lcSql = lcSql + "and articulos.idMarca = " + ALLTRIM(STR(tnIdMarca)) + " "
ENDIF

lcSql = lcSql + "group by subfam.idSubFam "
lcSql = lcSql + "order by subfam.idSubFam "

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"

IF !loRes.OpenQuery(lcSql) THEN
	this.ErrorMessage = loRes.Error_Message
	RETURN .F.
ENDIF

SELECT cur_sfam
ZAP 

SELECT cur_x
DO WHILE !EOF("cur_x")
	SELECT cur_sfam
	APPEND BLANK
	REPLACE cur_sfam.selected WITH .F.
	REPLACE cur_sfam.idSubFam WITH cur_x.idSubFam ADDITIVE
	REPLACE cur_sfam.descripcio WITH cur_x.descripcio ADDITIVE

	SELECT cur_x
	SKIP
ENDDO

SELECT cur_sfam
IF RECCOUNT("cur_sfam") > 0 THEN
	GO TOP
ENDIF

loRes.Close_Query()

RETURN .T.
ENDPROC
PROCEDURE leer_fichastock
PARAMETERS tn_idArticulo

LOCAL lcSql, loRes, lnSaldo, loRes2, lnSaldoAnt, lnCont, loDT

lcSql = ""
loRes = CREATEOBJECT("odbc_result")
loRes2 = CREATEOBJECT("odbc_result")
loDT = CREATEOBJECT("datetime")
lnSaldo = 0.00
lnSaldoAnt = 0.00
lnCont = 0
*****************************************************************************************************************
&& Calculo el saldo anterior a la estadistica.

lcSql = "select	SUM(stk_det.cantidad) as saldo "
lcSql = lcSql + "from stk_cab	 "
lcSql = lcSql + "	inner join stk_det on stk_det.idStkCab = stk_cab.idStkCab "
lcSql = lcSql + "where idArticulo = " + ALLTRIM(STR(tn_idArticulo)) + " "

IF INT(VAL(getConfig("SQLSRV"))) = 1 THEN
	lcSql = lcSql + "	and stk_cab.fecAlta < CONVERT(CHAR(8)," + loDT.toMySql(this.fecDesde) + ", 112) "
ELSE
	lcSql = lcSql + "	and stk_cab.fecAlta < " + loDT.toMySql(this.fecDesde) + " "
ENDIF

lcSql = lcSql + "and (stk_cab.usubaja is null OR stk_cab.usubaja = '') "

loRes2.ActiveConnection = goConn.ActiveConnection
loRes2.Cursor_Name = "cur_saldo"

IF !loRes2.OpenQuery(lcSql) THEN
	this.ErrorMessage = loRes2.Error_Message
	RETURN .F.
ENDIF

lnSaldoAnt = cur_saldo.saldo

loRes2.close_query()

*****************************************************************************************************************
&& Levanto los movimientos entre la fecha de la estadistica.
lcSql = "select	stk_cab.circuito, "
lcSql = lcSql + "stk_cab.fecAlta, "
lcSql = lcSql + "stk_det.tipoMov, "
lcSql = lcSql + "stk_det.nroPart, "
lcSql = lcSql + "stk_cab.cbte, "
lcSql = lcSql + "stk_cab.tipoDoc, "
lcSql = lcSql + "stk_cab.numCbte, "
lcSql = lcSql + "stk_det.cantidad, "
lcSql = lcSql + "stk_cab.usuAlta, "
lcSql = lcSql + "stk_cab.idHostAlta "
lcSql = lcSql + "from stk_cab	 "
lcSql = lcSql + "	inner join stk_det on stk_det.idStkCab = stk_cab.idStkCab "
lcSql = lcSql + "where idArticulo = " + ALLTRIM(STR(tn_idArticulo)) + " "

IF INT(VAL(getConfig("SQLSRV"))) = 1 THEN
	lcSql = lcSql + "	and stk_cab.fecAlta between CONVERT(CHAR(8)," + loDT.toMySql(this.fecDesde) +", 112) and  CONVERT(CHAR(8), " + loDT.toMySql(this.fecHasta) + ", 112) "
ELSE
	lcSql = lcSql + "	and stk_cab.fecAlta between " + loDT.toMySql(this.fecDesde) +" and  " + loDT.toMySql(this.fecHasta) + " "
ENDIF

lcSql = lcSql + "and (stk_cab.usubaja is null OR stk_cab.usubaja = '') "
lcSql = lcSql + "order by stk_cab.idStkCab, stk_det.idStkDet ASC "

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_temp"

IF !loRes.OpenQuery(lcSql) THEN
	this.ErrorMessage = loRes.Error_Message
	RETURN .F.
ENDIF

SELECT cur_temp
IF RECCOUNT("cur_temp") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_temp")
	SELECT cur_stock
	APPEND BLANK
	REPLACE cur_stock.circuito WITH cur_temp.circuito
	REPLACE cur_stock.fecAlta WITH cur_temp.fecAlta ADDITIVE
	REPLACE cur_stock.nroPart WITH IIF(ISNULL(cur_temp.nroPart), "", cur_temp.nroPart) ADDITIVE
	REPLACE cur_stock.cbte WITH cur_temp.cbte ADDITIVE
	REPLACE cur_stock.tipoDoc WITH cur_temp.tipoDoc ADDITIVE
	REPLACE cur_stock.numCbte WITH cur_temp.numCbte ADDITIVE
	REPLACE cur_stock.entrada WITH IIF(cur_temp.cantidad > 0, cur_temp.cantidad, 0) ADDITIVE
	REPLACE cur_stock.salida WITH IIF(cur_temp.cantidad < 0, cur_temp.cantidad * -1, 0) ADDITIVE
	
	IF lnCont = 0 THEN 
		lnSaldo = lnSaldoAnt + cur_temp.cantidad
	ELSE
		lnSaldo = lnSaldo + cur_temp.cantidad
	ENDIF 
	
	REPLACE cur_stock.saldo WITH lnSaldo ADDITIVE
	
	lnCont = lnCont + 1
	
	SELECT cur_temp
	SKIP
ENDDO

loRes.close_query()

SELECT cur_stock
IF RECCOUNT("cur_stock") > 0 THEN
	GO TOP
ENDIF

RETURN .T.

ENDPROC
PROCEDURE getpendientes
&& Este método permite levantar un listado de las cabeceras
&& de planificaciones que se encuentran pendientes de emitir.
LOCAL lcSql, loRes

lcSql = ""
loRes = CREATEOBJECT("odbc_result")

lcSql = "select pccab.idPCCab, pccab.idProv, proveedor.razSoc, pccab.fecDesde, pccab.fecHasta, pccab.fecEnt, "
lcSql = lcSql + "	pccab.baseCalc, pccab.cntDS, pccab.observ, pccab.emitido, pccab.estado, "
lcSql = lcSql + "	pccab.usuAlta, pccab.fecAlta, pccab.idHostAlta, pccab.usuModi, pccab.fecModi, pccab.idHostModi "
lcSql = lcSql + "from pccab inner join proveedor on pccab.idProv = proveedor.idProv "
lcSql = lcSql + "where pccab.emitido = 0 and pccab.fecBaja IS NULL"

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_tempo"

IF !loRes.OpenQuery(lcSql) THEN
	this.ErrorMessage = loRes.Error_Message
	RETURN .F.
ENDIF

SELECT cur_tempo
DO WHILE !EOF("cur_tempo")
	SELECT cur_pccab
	APPEND BLANK
	REPLACE cur_pccab.idPCCab WITH cur_tempo.idPCCab
	REPLACE cur_pccab.idProv WITH cur_tempo.idProv ADDITIVE
	REPLACE cur_pccab.razSoc WITH ALLTRIM(cur_tempo.razSoc) ADDITIVE
	REPLACE cur_pccab.fecDesde WITH cur_tempo.fecDesde ADDITIVE
	REPLACE cur_pccab.fecHasta WITH cur_tempo.fecHasta ADDITIVE
	REPLACE cur_pccab.fecEnt WITH cur_tempo.fecEnt ADDITIVE
	REPLACE cur_pccab.baseCalc WITH cur_tempo.baseCalc ADDITIVE
	REPLACE cur_pccab.cntDS WITH cur_tempo.cntDS ADDITIVE
	REPLACE cur_pccab.observ WITH IIF(ISNULL(cur_tempo.observ), "", cur_tempo.observ) ADDITIVE
	REPLACE cur_pccab.emitido WITH cur_tempo.emitido ADDITIVE
	REPLACE cur_pccab.estado WITH cur_tempo.estado ADDITIVE
	REPLACE cur_pccab.usuAlta WITH cur_tempo.usuAlta ADDITIVE
	REPLACE cur_pccab.fecAlta WITH cur_tempo.fecAlta ADDITIVE
	REPLACE cur_pccab.idHostAlta WITH cur_tempo.idHostAlta ADDITIVE
	REPLACE cur_pccab.usuModi WITH cur_tempo.usuModi ADDITIVE
	REPLACE cur_pccab.fecModi WITH cur_tempo.fecModi ADDITIVE
	REPLACE cur_pccab.idHostModi WITH cur_tempo.idHostModi ADDITIVE

	SELECT cur_tempo
	SKIP
ENDDO

loRes.Close_Query()

SELECT cur_pccab
IF RECCOUNT("cur_pccab") > 0 THEN
	GO TOP
ENDIF

RETURN .T.
ENDPROC
PROCEDURE actualizar
LOCAL loRes, lcSql, loProgress
LOCAL loCommand, loDT, lnCont

loCommand = CREATEOBJECT("odbc_command")
loRes = CREATEOBJECT("odbc_result")
loDT = CREATEOBJECT("datetime")
lcSql = ""
loProgress = CREATEOBJECT("_thermometer")
lnCont = 0

loProgress.Show()

goConn.BeginTransaction()

SELECT cur_pcdet
IF RECCOUNT("cur_pcdet") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_pcdet")
	lcSql = "update pcdet set "
	lcSql = lcSql + "	vtaMax = " + ALLTRIM(STR(cur_pcdet.vtaMax, 10, 2)) + ", "
	lcSql = lcSql + "	promed = " + ALLTRIM(STR(cur_pcdet.promed, 10, 2)) + ", "
	lcSql = lcSql + "	stkMin = " + ALLTRIM(STR(cur_pcdet.stkMin, 10, 2)) + ", "
	lcSql = lcSql + "	stkDis = " + ALLTRIM(STR(cur_pcdet.stkDis, 10, 2)) + ", "
	lcSql = lcSql + "	cantPed = " + ALLTRIM(STR(cur_pcdet.cantPed, 10, 2)) + ", "
	lcSql = lcSql + "	pendi = " + ALLTRIM(STR(cur_pcdet.pendi, 10, 2)) + ", "
	lcSql = lcSql + "	faltant = " + ALLTRIM(STR(cur_pcdet.faltant, 10, 2)) + ", "
	lcSql = lcSql + "	diasCub = " + ALLTRIM(STR(cur_pcdet.diasCub)) + ", "
	lcSql = lcSql + "	costo = " + ALLTRIM(STR(cur_pcdet.costo, 10, 2)) + ", "
	lcSql = lcSql + "	prLista = " + ALLTRIM(STR(cur_pcdet.prLista, 10, 2)) + ", "
	lcSql = lcSql + "	uniDesp = " + ALLTRIM(STR(cur_pcdet.uniDesp, 10, 2)) + ", "
	lcSql = lcSql + "	cantPack = " + ALLTRIM(STR(cur_pcdet.cantPack, 10, 2)) + " "
	lcSql = lcSql + "where idPCDet = " + ALLTRIM(STR(cur_pcdet.idPCDet)) + " "
	lcSql = lcSql + " and idPCCab = " + ALLTRIM(STR(this.idpdcab))
	
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute() THEN
		MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
		goConn.Rollback()
		RETURN .F.
	ENDIF
	
	lnCont = lnCont + 1
	loProgress.update((lnCont * 100) / RECCOUNT("cur_pcdet"), "Guardando cambios...")
	SELECT cur_pcdet
	SKIP
ENDDO

lcSql = "update pccab set usuModi = '" + ALLTRIM(gcCodUsu) + "', "
lcSql = lcSql + " fecModi = " + loDT.getdatetime() + ", "
lcSql = lcSql + " idHostModi = '" + ALLTRIM(SYS(0)) + "', "
lcSql = lcSql + " observ = '" + ALLTRIM(this.observ) + "' "
lcSql = lcSql + "where idPCCab = " + ALLTRIM(STR(this.idpdcab))

loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = lcSql

IF !loCommand.Execute() THEN
	MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
	goConn.Rollback()
	RETURN .F.
ENDIF

goConn.Commit()

loProgress.complete()

RETURN .T.
ENDPROC
PROCEDURE agregar_det_fc
PARAMETERS tnIdArticulo, tnCantidad

LOCAL lcSql, loRes
LOCAL lnAlicIVA, lnPrLista, lnBonif1, lnBonif2, lnBonif3, lnBonif4
LOCAL lnImpDesc1, lnImpDesc2, lnImpDesc3, lnImpDesc4
LOCAL lnCostoRep, lnImpNeto, lnTotNeto, lnImpIVA, lnSubTotal
LOCAL lnCantNC, lcCodArt

lcSql = ""
loRes = CREATEOBJECT("odbc_result")

lnAlicIVA = 0.00
lnPrLista = 0.00
lnBonif1 = 0.00
lnBonif2 = 0.00
lnBonif3 = 0.00
lnBonif4 = 0.00
lnImpDesc1 = 0.00
lnImpDesc2 = 0.00
lnImpDesc3 = 0.00
lnImpDesc4 = 0.00
lnCostoRep = 0.00
lnImpNeto = 0.00
lnTotNeto = 0.00
lnImpIVA = 0.00
lnSubTotal = 0.00
lnCantidad = 0.00
lnCantNC = 0.00
lcCodArt = ""

lcSql = ""
loRes = CREATEOBJECT("odbc_result")

lcSql = "select * from articulos where idArticulo = " + ALLTRIM(STR(cur_pcdet.idArticulo))
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_tempo"

IF !loRes.OpenQuery(lcSql) THEN
	this.ErrorMessage = loRes.Error_Message
	RETURN .F.
ENDIF

SELECT cur_tempo
lcCodArt = cur_tempo.codArt
lnAlicIVA = cur_tempo.alicIVA
lnPrLista = cur_tempo.prLista
lnBonif1 = cur_tempo.bonif1
lnImpDesc1 = cur_tempo.prLista * (lnBonif1 / 100)
lnBonif2 = cur_tempo.bonif2
lnImpDesc2 = lnImpDesc1 * (lnBonif2 / 100)
lnBonif3 = cur_tempo.bonif3
lnImpDesc3 = lnImpDesc2 * (lnBonif3 / 100)
lnBonif4 = cur_tempo.bonif4
lnImpDesc4 = lnImpDesc3 * (lnBonif4 / 100)
lnCostoRep = cur_tempo.costoRep
lnImpNeto = lnCostoRep
lnTotNeto = lnCostoRep * tnCantidad
lnImpIVA = lnTotNeto * (lnAlicIVA / 100)
lnSubTotal = lnTotNeto + lnImpIVA

this.impdesc1 = this.impdesc1 + lnImpDesc1
this.impdesc2 = this.impdesc2 + lnImpDesc2
this.impdesc3 = this.impdesc3 + lnImpDesc3
this.impdesc4 = this.impdesc4 + lnImpDesc4
this.pordesc1 = lnBonif1
this.pordesc2 = lnBonif2
this.pordesc3 = lnBonif3
this.pordesc4 = lnBonif4
this.impneto = this.impneto + lnTotNeto

IF lnAlicIVA = 21 THEN
	this.poriva21 = lnAlicIVA
	this.impiva21 = this.impiva21 + lnImpIVA
ELSE
	IF lnAlicIVA = 10.5 THEN
		this.poriva105 = lnAlicIVA
		this.impiva105 = this.impiva105 + lnImpIVA
	ENDIF
ENDIF

this.totfact = this.totfact + (lnTotNeto + this.impiva21 + this.impiva105)

loRes.Close_Query()

SELECT cur_cpasdet
APPEND BLANK
REPLACE cur_cpasdet.idCompraD WITH 0
REPLACE cur_cpasdet.idCompraC WITH 0 ADDITIVE
REPLACE cur_cpasdet.idArticulo WITH tnIdArticulo ADDITIVE
REPLACE cur_cpasdet.codArt WITH ALLTRIM(lcCodArt) ADDITIVE
REPLACE cur_cpasdet.cantidad WITH tnCantidad ADDITIVE
REPLACE cur_cpasdet.cantNC WITH lnCantNC ADDITIVE
REPLACE cur_cpasdet.costoRep WITH lnCostoRep ADDITIVE
REPLACE cur_cpasdet.prArtic WITH lnPrLista ADDITIVE
REPLACE cur_cpasdet.prCompra WITH lnCostoRep ADDITIVE
REPLACE cur_cpasdet.porDesc1 WITH lnBonif1 ADDITIVE
REPLACE cur_cpasdet.porDesc2 WITH lnBonif2 ADDITIVE
REPLACE cur_cpasdet.porDesc3 WITH lnBonif3 ADDITIVE
REPLACE cur_cpasdet.porDesc4 WITH lnBonif4 ADDITIVE
REPLACE cur_cpasdet.impDesc1 WITH lnImpDesc1 ADDITIVE
REPLACE cur_cpasdet.impDesc2 WITH lnImpDesc2 ADDITIVE
REPLACE cur_cpasdet.impDesc3 WITH lnImpDesc3 ADDITIVE
REPLACE cur_cpasdet.impDesc4 WITH lnImpDesc4 ADDITIVE
REPLACE cur_cpasdet.impNeto WITH lnImpNeto ADDITIVE
REPLACE cur_cpasdet.totNeto WITH lnTotNeto ADDITIVE
REPLACE cur_cpasdet.alicIVA WITH lnAlicIVA ADDITIVE
REPLACE cur_cpasdet.impIVA WITH lnImpIVA ADDITIVE
REPLACE cur_cpasdet.subTotal WITH lnSubTotal ADDITIVE

RETURN .T.
ENDPROC
PROCEDURE eliminar
PARAMETERS tnIdPCCab

LOCAL lcSql, loCommand, loDT

lcSql = ""
loCommand = CREATEOBJECT("odbc_command")
loDT = CREATEOBJECT("datetime")

goConn.BeginTransaction()

lcSql = "update pccab set "
lcSql = lcSql + "usuBaja = '" + ALLTRIM(gcCodUsu) + "', "
lcSql = lcSql + "fecBaja = " + loDT.getdatetime() + ", "
lcSql = lcSql + "idHostBaja = '" + ALLTRIM(SYS(0)) + "' "
lcSql = lcSql + "where idPCCab = " + ALLTRIM(STR(tnIdPCCab)) 

loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = lcSql

IF !loCommand.Execute() THEN
	MESSAGEBOX(loCommand.Error_Message, 0+48, Thisform.Caption)
	goConn.Rollback()
	RETURN .F.
ENDIF

goConn.Commit()

RETURN .T.
ENDPROC
PROCEDURE convertir_en_pedido
********************************************************************
* Método: 	Convertir_en_pedido
* Detalle:	Permite pasar la orden de compra como pedido a DER 
*			mediante la utilización del WebService.
* Fecha:	07/07/2014
********************************************************************
PARAMETERS lnIdOcCab

LOCAL loSoap, loProgress, lnNroPed, lnResult, llOk
LOCAL lnDERNroCli, loRes, lcSql, loDT, lcObserv
LOCAL loCommand

loSoap = CREATEOBJECT("MSSOAP.SoapClient30")
loProgress = CREATEOBJECT("_Thermometer")
loRes = CREATEOBJECT("odbc_result")
loCommand = CREATEOBJECT("odbc_command")
lnNroPed = 0.00
lnResult = 0
llOk = .F.
lnDERNroCli = 8105
lcSql = ""
loDT = CREATEOBJECT("datetime")
lcObserv = "Orden de Compra N° " + ALLTRIM(STR(lnIdOcCab))

SELECT cur_ocdet
IF RECCOUNT("cur_ocdet") = 0 THEN
	this.ErrorMessage = "No se puede trasnferir la orden de compra como pedido"
	RETURN .F.
ENDIF

loSoap.mssoapinit(ALLTRIM(getconfig("WSDERCLI")), "WSPedidos", "WSPedidosSoap")
lnNroPed = loSoap.Enviar_Cabecera(lnDERNroCli, "SISCOM", RECCOUNT("cur_ocdet"), lcObserv, loDT.to_webservice(DATE()))

IF lnNroPed = -1 THEN
	this.ErrorMessage = "Ha ocurrido un error al intentar enviar la cabecera del pedido"
	lo_SoapCli.AnularPedido(lnNroPed)
	RETURN .F.	
ENDIF

loProgress.Show()

SELECT cur_ocdet
IF RECCOUNT("cur_ocdet") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_ocdet")
	lcSql = "select * from articulos where idArticulo = " + ALLTRIM(STR(cur_ocdet.idArticulo))
	loRes.ActiveConnection = goConn.ActiveConnection
	loRes.Cursor_Name = "cur_tmpart"

	IF !loRes.OpenQuery(lcSql) THEN
		this.ErrorMessage = loRes.Error_Message
		loSoap.AnularPedido(lnNroPed)
		RETURN .F.
	ENDIF

	SELECT cur_ocdet
	lnResult = loSoap.Agregar_Detalle(lnNroPed, cur_tmpart.codArt, cur_ocdet.cantPed)
	
	IF lnResult = -1 THEN
		&& Se agrega el envio del método de anulación del pedido. 22/09/2010
		this.ErrorMessage = "Ha ocurrido un error al transferir el artículo."
		loSoap.AnularPedido(lnNroPed)
		RETURN .F.
	ENDIF

	SELECT cur_ocdet
	loProgress.update((RECNO() * 100) / RECCOUNT(), "Convirtiendo Orden de Compra en pedido...")
	
	SELECT cur_ocdet
	SKIP
ENDDO

lnResult = loSoap.Confirmar_Pedido(lnNroPed)

DO CASE
	CASE lnResult = -1
		&& Se agrega el envio del método de anulación del pedido. 22/09/2010
		this.ErrorMessage = "La cantidad enviada no coincide con la cantidad de la orden de compra. Se canceló la transferencia."
		loSoap.AnularPedido(lnNroPed)
		RETURN .F.
	CASE lnResult = -2
		&& Se agrega el envio del método de anulación del pedido. 22/09/2010
		this.ErrorMessage = "Ha ocurrido un error al intentar confirmar el pedido. Se canceló la transferencia."
		loSoap.AnularPedido(lnNroPed)
		RETURN .F.
ENDCASE

loProgress.complete()

goConn.BeginTransaction()

lcSql = "update occab set estado = 1 where idOcCab = " + ALLTRIM(STR(lnIdOcCab))
loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = lcSql

IF !loCommand.Execute() THEN
	this.ErrorMessage = loCommnad.ErrorMesssage
	goConn.Rollback()
	lo_SoapCli.AnularPedido(lnNroPed)
	RETURN .F.
ENDIF

goConn.Commit()

MESSAGEBOX("Se ha generado con éxito el pedido N° " + ALLTRIM(STR(lnNroPed)),0+64,thisform.Caption)

RETURN .T.

ENDPROC
PROCEDURE calc_mult_ud
PARAMETERS tn_idArticulo, tn_CantPed

LOCAL loRes, lcSql
LOCAL lnUD, lnReturn, lnCoef, lnUniDesp, lnCantPack, lnCant

loRes = CREATEOBJECT("odbc_result")
lcSql = ""
lnUD = 0.00
lnReturn = 0.00
lnCoef = 0.00
lnUniDesp = 0.00
lnCantPack = 0
lnCant = 0.00

SELECT cur_pcdet
lcSql = "SELECT cantiDesp as ud "
lcSql = lcSql + "FROM codiart "
lcSql = lcSql + "WHERE idArticulo = " + ALLTRIM(STR(tn_idArticulo)) + " and tipo in ('CP','CB') and circuito in ('C','CV') "
lcSql = lcSql + "ORDER BY cantiDesp ASC"

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_ud"

IF !loRes.OpenQuery(lcSql) THEN
	this.ErrorMessage = loRes.Error_Message
	RETURN -1
ENDIF

SELECT cur_ud
IF RECCOUNT("cur_ud") > 0 THEN
	GO TOP
ELSE 
	&&MESSAGEBOX("Este artículo no posee unidades de despacho asignadas", 0+48, "Error")
	&&RETURN -1
	this.unidesp = 1
	this.cantpack = tn_CantPed
	RETURN tn_CantPed
ENDIF


&& Chequeo si la cantidad ingresada es multiplo de alguna UD.
DO WHILE !EOF("cur_ud")
	lnUD = cur_ud.ud
	
	* 30/11/2023: Si es distinto de cero entonces, hago los cálculos
	IF lnUD <> 0 THEN
		IF (MOD(tn_CantPed, lnUD) = 0) THEN
			loRes.close_query()
			this.unidesp = lnUD
			this.cantpack = ROUND((tn_CantPed / lnUD), 2)
			RETURN tn_CantPed
		ELSE
			&& Si la cantidad es mas pequeña que la UD la guardo. Controlo que por aca se pase solo una vez con el campo lnCantPack.
			IF lnCantPack <> 1 THEN 
				IF tn_CantPed <= lnUD THEN
					lnUniDesp = lnUD
					lnCantPack = 1
					lnCant = lnUD	
				ENDIF
			ENDIF 
		ENDIF
	ENDIF
		
	SELECT cur_ud
	SKIP
ENDDO

SELECT cur_ud
IF RECCOUNT("cur_ud") > 0 THEN
	GO TOP
ENDIF

&& Tomo la UD mas pequeña y calculo la cantidad, ésta cantidad la comparo contra la cantidad que tome en lnCant. 
&& Si es menor significa que tomando la UD mas pequeña la cantidad es mas proxima a la cantidad ingresada,
&& si es mayor significa que la cantidad de lnCant es mas proxima a la cantidad ingresada.
SELECT MIN(ud) as ud FROM cur_ud INTO CURSOR cur_udmin
lnUD = cur_udmin.ud

lnCoef = FLOOR(tn_CantPed/lnUD) + 1
tn_CantPed = lnUD * lnCoef

USE IN cur_udmin

&& Si lnCant es CERO significa que la cantidad ingresada es mayor a cualquier UD, es por eso que va por el ELSE. 
&& Sino se valida y compara lo antes mencionado.
IF lnCant <> 0 THEN 
	IF tn_CantPed < lnCant THEN 
		loRes.close_query()
		this.unidesp = lnUD
		this.cantpack = ROUND((tn_CantPed / lnUD), 2)
		RETURN tn_CantPed
	ELSE 
		loRes.close_query()
		this.unidesp = lnUniDesp
		this.cantpack = lnCantPack
		RETURN lnCant
	ENDIF 
ELSE 
	loRes.close_query()
	this.unidesp = lnUD
	this.cantpack = ROUND((tn_CantPed / lnUD), 2)
	RETURN tn_CantPed
ENDIF 

ENDPROC
PROCEDURE totalizar
LOCAL lnUltPos

this.totcosto = 0.00
this.totped = 0.00
this.totprlista = 0.00

lnUltPos = -1

SELECT cur_pcdet
lnUltPos = RECNO("cur_pcdet")

SELECT cur_pcdet
GO TOP
DO WHILE !EOF("cur_pcdet")
	IF cur_pcdet.cantPed > 0 THEN
		this.totCosto = this.totCosto + ROUND((cur_pcdet.costo * cur_pcdet.cantPed),2)
		this.totprlista = this.totprlista + ROUND((cur_pcdet.prlista * cur_pcdet.cantPed),2)
		this.totped = this.totped + cur_pcdet.cantPed
	ENDIF
	
	SELECT cur_pcdet
	SKIP
ENDDO

SELECT cur_pcdet
GO lnUltPos


ENDPROC
PROCEDURE calc_mult_ud2
PARAMETERS tn_CantPed

LOCAL loRes, lcSql
LOCAL lnUD, lnReturn

loRes = CREATEOBJECT("odbc_result")
lcSql = ""
lnUD = 0.00
lnReturn = 0.00

SELECT cur_pcdet
lcSql = "select min(cantiDesp) as ud from codiart where idArticulo = " + ALLTRIM(STR(cur_pcdet.idArticulo)) + " and tipo = 'CB' "

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_ud"

IF !loRes.OpenQuery(lcSql) THEN
	this.ErrorMessage = loRes.Error_Message
	RETURN -1
ENDIF

SELECT cur_ud
IF RECCOUNT() > 0 THEN
	GO TOP
	lnUD = cur_ud.ud

	loRes.Close_Query()

	IF tn_CantPed <= lnUD THEN
		lnReturn = lnUD
	ELSE
		IF MOD(tn_CantPed, lnUD) <> 0 THEN
			lnReturn = -1
		ENDIF
	ENDIF
ELSE
	lnReturn = 1
ENDIF

RETURN lnReturn
ENDPROC
PROCEDURE agregar_det_oc
PARAMETERS tnIdArticulo, tnCantidad, lnUniDesp, lncantPack

LOCAL lcSql, loRes
LOCAL lcCodArt, lcDesc, lnPrLista, lnCosto, lnTotCosto, lnTotPrLista
LOCAL lnIdArticulo, lnidUniMed, lccodUM, llActivo 

lcSql = ""
loRes = CREATEOBJECT("odbc_result")
lcCodArt = ""
lcDesc = ""
lccodUM = ""
lnCosto = 0.00
lnPrLista = 0.00
lnTotCosto = 0.00
lnTotPrLista = 0.00
lnidUniMed = 0
llActivo = .T.


&& Traigo los datos del articulo
lcSql = "select * from articulos where idArticulo = " + ALLTRIM(STR(tnIdArticulo))
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_tempo"

IF !loRes.OpenQuery(lcSql) THEN
	this.ErrorMessage = loRes.Error_Message
	RETURN .F.
ENDIF

SELECT cur_tempo
lcCodArt = cur_tempo.codart
lcDesc = cur_tempo.descripcio
lnCosto = cur_tempo.costoRep
lnPrLista = cur_tempo.prLista
lnTotCosto = ROUND(lnCosto * tnCantidad, 2)
lnTotPrLista = ROUND(lnPrLista * tnCantidad, 2)
lnidUniMed = cur_tempo.idUniMed

loRes.Close_Query()

&& Traigo el codigo de unidad de medida
lcSql = "select * from unidmed where idUniMed = " + ALLTRIM(STR(lnidUniMed))
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_tempo"

IF !loRes.OpenQuery(lcSql) THEN
	this.ErrorMessage = loRes.Error_Message
	RETURN .F.
ENDIF

SELECT cur_tempo
lccodUM = ALLTRIM(cur_tempo.codUM)

loRes.Close_Query()


&& Armo el cursor cur_ocdet
SELECT cur_ocdet
APPEND BLANK
REPLACE cur_ocdet.idOcDet WITH 0
REPLACE cur_ocdet.idOcCab WITH 0 ADDITIVE
REPLACE cur_ocdet.idArticulo WITH tnIdArticulo ADDITIVE
REPLACE cur_ocdet.codArt WITH lcCodart ADDITIVE
REPLACE cur_ocdet.descripcio WITH lcDesc ADDITIVE
REPLACE cur_ocdet.UniDesp WITH lnUniDesp ADDITIVE
REPLACE cur_ocdet.cantPack WITH lncantPack ADDITIVE
REPLACE cur_ocdet.codUM WITH lccodUM ADDITIVE
REPLACE cur_ocdet.cantPed WITH tnCantidad ADDITIVE
REPLACE cur_ocdet.cantRec WITH 0 ADDITIVE
REPLACE cur_ocdet.Pendiente WITH tnCantidad ADDITIVE
REPLACE cur_ocdet.Costo WITH lnCosto ADDITIVE
REPLACE cur_ocdet.PrLista WITH lnPrLista ADDITIVE
REPLACE cur_ocdet.TotCosto WITH lnTotCosto ADDITIVE
REPLACE cur_ocdet.TotPrLista WITH lnTotPrLista ADDITIVE
REPLACE cur_ocdet.Activo WITH llActivo ADDITIVE

RETURN .T.
ENDPROC
PROCEDURE generar_oc
LOCAL loRes, lcSql, loCommand, loDT, loNumerador, loTherm
LOCAL lnProxID, lcCbte, lnIdOcDet

loNumerador = CREATEOBJECT("cls_numeradores")
lcCbte = "OC"

lcSql  = ""
loRes = CREATEOBJECT("odbc_result")
loCommand = CREATEOBJECT("odbc_command")
loDT = CREATEOBJECT("datetime")
lnProxID = 0
loTherm = CREATEOBJECT("_thermometer")
lnIdOcDet = 0
loNumerador.cbte = lcCbte


loTherm.Show()

SELECT cur_pcdet
IF RECCOUNT("cur_pcdet") > 0 THEN
	GO TOP 
ENDIF 

&& Agrego al cursor cur_ocdet los articulos con cantidad pedida > 0
DO WHILE !EOF("cur_pcdet")
	IF cur_pcdet.cantPed > 0 THEN
		this.agregar_det_oc(cur_pcdet.idArticulo, cur_pcdet.cantPed, cur_pcdet.UniDesp, cur_pcdet.cantPack)
	ENDIF

	SELECT cur_pcdet
	SKIP
ENDDO

SELECT cur_ocdet
IF RECCOUNT("cur_ocdet") > 0 THEN
	GO TOP 
	
	IF !loNumerador.getptovta() THEN 
		RETURN .F.
	ENDIF 

	DO WHILE loNumerador.esta_bloqueado()
		WAIT WINDOW "Otro usuario está emitiendo una orden de compra, por favor espere..." NOWAIT
	ENDDO

	loNumerador.bloquear()
ELSE 
	MESSAGEBOX("No se ha generado ningún registro para la Orden de Compra", 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

goConn.BeginTransaction()

lcSql = [ 	;
	SELECT 	;
		CASE ; 
			WHEN MAX(idOcCab) IS NULL THEN 1 ;
			ELSE MAX(idOcCab) + 1 END AS proxId ;
	FROM occab]
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"
loRes.OpenQuery(lcSql)
SELECT cur_x
lnProxID = INT(VAL(cur_x.proxid))
loRes.Close_Query()

lcSql = "insert into occab ("
lcSql = lcSql + "idOcCab, "
lcSql = lcSql + "idProv, "
lcSql = lcSql + "idMarca, "
lcSql = lcSql + "idPcCab, "
lcSql = lcSql + "Fecha, "
lcSql = lcSql + "FecEnt, "
lcSql = lcSql + "iTotCosto, "
lcSql = lcSql + "iTotLista, "
lcSql = lcSql + "CantTot, "
lcSql = lcSql + "observ, "
lcSql = lcSql + "estado, "
lcSql = lcSql + "usuAlta, "
lcSql = lcSql + "fecAlta, "
lcSql = lcSql + "idHostAlta) VALUES ("
lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", "
lcSql = lcSql + ALLTRIM(STR(this.idprov)) + ", "
lcSql = lcSql + ALLTRIM(IIF(this.idmarca = 0, "NULL", STR(this.idmarca))) + ", "
lcSql = lcSql + ALLTRIM(IIF(this.idpdcab = 0, "NULL", STR(this.idpdcab))) + ", "
lcSql = lcSql + loDT.getDateTime() + ", "
lcSql = lcSql + loDT.toMySql(this.fecEnt) + ", "
lcSql = lcSql + ALLTRIM(STR(this.totcosto, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(this.totprlista, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(this.totped, 10, 2)) + ", "
lcSql = lcSql + "'" + ALLTRIM(this.observ) + "', "
lcSql = lcSql + "0, "
lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
lcSql = lcSql + loDT.getDateTime() + ", "
lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "')"

loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = lcSql

IF !loCommand.Execute() THEN
	MESSAGEBOX(loCommand.Error_Message, 0+48, Thisform.Caption)
	goConn.Rollback()
	loNumerador.desbloquear()
	RETURN .F.
ENDIF

SELECT cur_ocdet
IF RECCOUNT("cur_ocdet") > 0 THEN
	GO TOP
ENDIF

lnIdOcDet = 1

DO WHILE !EOF("cur_ocdet")

	SET STEP ON
	lcSql = "INSERT INTO ocdet ( "
	lcSql = lcSql + "idOcDet, "
	lcSql = lcSql + "idOcCab, "
	lcSql = lcSql + "idArticulo, "
	lcSql = lcSql + "UniDesp, "
	lcSql = lcSql + "cantPack, "
	lcSql = lcSql + "codUM, "
	lcSql = lcSql + "cantPed, "
	lcSql = lcSql + "cantRec, "
	lcSql = lcSql + "Pendiente, "
	lcSql = lcSql + "Costo, "
	lcSql = lcSql + "PrLista, "
	lcSql = lcSql + "TotCosto, "
	lcSql = lcSql + "TotPrLista, "
	lcSql = lcSql + "Activo) "
	lcSql = lcSql + "VALUES ( "
	lcSql = lcSql + ALLTRIM(STR(lnIdOcDet)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_ocdet.idArticulo)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_ocdet.UniDesp, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_ocdet.cantPack, 10, 2)) + ", "
	lcSql = lcSql + "'" + ALLTRIM(cur_ocdet.codUM) + "', "
	lcSql = lcSql + ALLTRIM(STR(cur_ocdet.CantPed, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_ocdet.CantRec, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_ocdet.Pendiente, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_ocdet.Costo, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_ocdet.prLista, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_ocdet.TotCosto, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_ocdet.TotPrLista, 10, 2)) + ", "
	lcSql = lcSql + IIF(cur_ocdet.Activo, "1", "0") + ") "
	
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute() THEN
		MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
		goConn.Rollback()
		loNumerador.desbloquear()		
		RETURN .F.
	ENDIF
 	
 	loTherm.update((lnIdOcDet * 100) / RECCOUNT(), "Grabando Orden de Compra...")
	lnIdOcDet = lnIdOcDet + 1
	
	SELECT cur_ocdet
	SKIP
ENDDO

&& Actualizo el estado de la planificación
lcSql = "update pccab set "
lcSql = lcSql + "emitido = 1, estado = 'E', "
lcSql = lcSql + "usuModi = '" + ALLTRIM(gcCodUsu) + "', "
lcSql = lcSql + "fecModi = " + loDT.getDateTime() + ", "
lcSql = lcSql + "idHostModi = '" + ALLTRIM(SYS(0)) + "' "
lcSql = lcSql + "where idPCCab = " + ALLTRIM(STR(this.idpdcab))

loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = lcSql

IF !loCommand.Execute() THEN
	MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
	goConn.Rollback()
	loNumerador.desbloquear()
	RETURN .F.
ENDIF

loNumerador.numactual = lnProxID
loNumerador.actualizar()
loNumerador.desbloquear()

goConn.Commit()
loTherm.complete()

this.idOcCab = lnProxID

RETURN .T.
ENDPROC
PROCEDURE calc_pendientes
PARAMETERS tnidArticulo

LOCAL lcSql, loRes, lnPendiente

lcSql = ""
loRes = CREATEOBJECT("odbc_result")
lnPendiente = 0.00

IF INT(VAL(getconfig("SQLSRV"))) = 1 THEN 
	lcSql = "SELECT ISNULL(SUM(pendiente),0) as pendiente "
ELSE 
	lcSql = "SELECT IFNULL(SUM(pendiente),0) as pendiente "
ENDIF 
lcSql = lcSql + "FROM occab "
lcSql = lcSql + "	inner join ocdet on occab.idoccab = ocdet.idoccab "
lcSql = lcSql + "WHERE idarticulo = " + ALLTRIM(STR(tnidArticulo)) + " "
lcSql = lcSql + " 	and occab.fecbaja is null "
lcSql = lcSql + " 	and ocdet.activo = 1 "

loRes.ActiveConnection = goConn.ActiveConnection
loRes.cursor_name = "cur_pend"

IF !loRes.OpenQuery(lcSql) THEN
	this.errorMessage = loRes.Error_Message
	RETURN .F.
ENDIF

SELECT cur_pend
lnPendiente = cur_pend.pendiente

loRes.close_query()

RETURN lnPendiente 

ENDPROC
PROCEDURE imprimir_oc
LOCAL m.NroCbte, m.Fecha, m.RazSoc, m.Telefono, m.direccion, m.localidad, m.codPostal, m.pcia, m.TipoIVA, m.nroCUIT, m.condpago
LOCAL m.porIVA105, m.impIVA105, m.porIVA21, m.impIVA21, m.porIIBB, m.impIIBB, m.impNeto, m.Total, m.observ
LOCAL lcSql, loRes

lcSql = ""
loRes = CREATEOBJECT("odbc_result")

lcSql = " SELECT proveedor.razsoc, "
lcSql = lcSql + " proveedor.direccion, "
lcSql = lcSql + " proveedor.nrocuit, "
lcSql = lcSql + " proveedor.telefono, "
lcSql = lcSql + " localidad.codpostal as codpostal, "
lcSql = lcSql + " localidad.descripcio as loc, "
lcSql = lcSql + " provincias.descripcio as provincia, "
lcSql = lcSql + " sitiva.descripcio as sitiva, "
lcSql = lcSql + " condpagos.descripcio as condpago "
lcSql = lcSql + " FROM proveedor "
lcSql = lcSql + "	INNER JOIN localidad on proveedor.idlocalid = localidad.idlocalid "
lcSql = lcSql + "	INNER JOIN provincias on localidad.idprovin = provincias.idprovin "
lcSql = lcSql + "	INNER JOIN sitiva on proveedor.idsitiva = sitiva.idsitiva "
lcSql = lcSql + "	INNER JOIN condpagos on proveedor.idcondpago = condpagos.idcondpago "
lcSql = lcSql + " WHERE proveedor.idprov = " + ALLTRIM(STR(this.idprov))
  
loRes.ActiveConnection = goConn.ActiveConnection
loRes.cursor_name = "cur_tempo"

IF !loRes.OpenQuery(lcSql) THEN
	this.errorMessage = loRes.Error_Message
	RETURN .F.
ENDIF

SELECT cur_tempo
IF RECCOUNT("cur_tempo") > 0 THEN
	GO TOP
ENDIF  

m.NroCbte = this.idoccab
m.Fecha = DATETIME()
m.RazSoc = cur_tempo.razsoc
m.Telefono = cur_tempo.telefono
m.direccion = cur_tempo.direccion
m.localidad = cur_tempo.loc
m.codPostal = ALLTRIM(cur_tempo.codpostal)
m.pcia = cur_tempo.provincia
m.TipoIVA = cur_tempo.sitiva
m.nroCUIT = cur_tempo.nrocuit
m.condpago = cur_tempo.condpago
m.porIVA105 = 0.00
m.porIVA21 = 0.00
m.impIVA105 = 0.00
m.impIVA21 = 0.00
m.porIIBB = 0.00
m.impIIBB = 0.00
m.impNeto = 0.00
m.Total = this.totprlista
m.observ = this.observ

loRes.close_query()

SELECT cur_ocdet
REPORT FORM repoc TO PRINTER PROMPT PREVIEW 


ENDPROC
PROCEDURE consultar_occab
PARAMETERS lnProvD, lnProvH, lnMarD, lnMarH, lnOcD, lnOcH, lcFecD, lcFecH, lnEnt

LOCAL lcSql, loRes, loDT, lnEntregado

lcSql = ""
loRes = CREATEOBJECT("odbc_result")
loDT = CREATEOBJECT("datetime")
lnSqlSrv = INT(VAL(getconfig("SQLSRV")))
lnEntregado = 0

SELECT cur_occab
ZAP 

lcSql = " SELECT occab.idOcCab, "
lcSql = lcSql + "proveedor.idProv, "
lcSql = lcSql + "proveedor.razsoc, "
lcSql = lcSql + IIF(lnSqlSrv = 1,"ISNULL","IFNULL") + "(marcas.idMarca,0) as idMarca, "
lcSql = lcSql + IIF(lnSqlSrv = 1,"ISNULL","IFNULL") + "(marcas.descripcio,'') as Marca, "
lcSql = lcSql + IIF(lnSqlSrv = 1,"ISNULL","IFNULL") + "(occab.idPcCab,0) as idPcCab, "
lcSql = lcSql + "occab.Fecha, "
lcSql = lcSql + "occab.FecEnt, "
lcSql = lcSql + "occab.iTotCosto, "
lcSql = lcSql + "occab.iTotLista, "
lcSql = lcSql + "occab.cantTot, "
lcSql = lcSql + "occab.observ, "
lcSql = lcSql + "occab.estado, "
lcSql = lcSql + "	(select case when(SUM(pendiente)) = 0 then 1 else 0 end "
lcSql = lcSql + "		from ocdet "
lcSql = lcSql + " 		where ocdet.idoccab = occab.idoccab "
lcSql = lcSql + " 			and activo = 1 "
lcSql = lcSql + " 		group by idoccab) Entregado, "
lcSql = lcSql + "occab.usualta, "
lcSql = lcSql + "occab.fecalta, "
lcSql = lcSql + "occab.idhostAlta "
lcSql = lcSql + " FROM occab "
lcSql = lcSql + " 	INNER JOIN proveedor ON occab.idProv = proveedor.idProv "
lcSql = lcSql + " 	LEFT JOIN marcas ON occab.idMarca = marcas.idMarca "
lcSql = lcSql + " WHERE occab.FecBaja is null "

IF lnProvD <> 0 THEN 
	lcSql = lcSql + " AND occab.idProv >= " + ALLTRIM(STR(lnProvD))
ENDIF 

IF lnProvH <> 0 THEN 
	lcSql = lcSql + " AND occab.idProv <= " + ALLTRIM(STR(lnProvD))
ENDIF

IF lnMarD <> 0 THEN 
	lcSql = lcSql + " AND " + IIF(lnSqlSrv = 1,"ISNULL","IFNULL") + "(occab.idMarca,0) >= " + ALLTRIM(STR(lnMarD))
ENDIF

IF lnMarH <> 0 THEN 
	lcSql = lcSql + " AND " + IIF(lnSqlSrv = 1,"ISNULL","IFNULL") + "(occab.idMarca,0) <= " + ALLTRIM(STR(lnMarH))
ENDIF

IF lnOcD <> 0 THEN 
	lcSql = lcSql + " AND occab.idOcCab >= " + ALLTRIM(STR(lnOcD))
ENDIF 

IF lnOcH <> 0 THEN 
	lcSql = lcSql + " AND occab.idOcCab <= " + ALLTRIM(STR(lnOcH))
ENDIF

IF lnSqlSrv = 1 THEN
	lcSql = lcSql + " AND (CONVERT(CHAR(8), fecha , 112) BETWEEN " + lcFecD + " AND " + lcFecH + ") "
ELSE
	lcSql = lcSql + " AND (CAST(fecha AS DATE) BETWEEN " + lcFecD + " AND " + lcFecH + ") "
ENDIF

IF lnEnt = 1 THEN 
	lcSql = lcSql + " 	AND occab.idOcCab in (select idOcCab "
	lcSql = lcSql + " 			from ocdet "
	lcSql = lcSql + " 			where activo = 1 "
	lcSql = lcSql + " 			group by idoccab "
	lcSql = lcSql + " 			having SUM(pendiente) <> 0) "
ENDIF 

lcSql = lcSql + " ORDER BY occab.idOcCab"

loRes.ActiveConnection = goConn.ActiveConnection
loRes.cursor_name = "cur_tempo"

IF !loRes.OpenQuery(lcSql) THEN
	this.ErrorMessage = loRes.Error_Message
	RETURN .F.
ENDIF

IF RECCOUNT("cur_tempo") > 0 THEN 
	GO TOP
ENDIF 

SELECT cur_tempo
DO WHILE !EOF("cur_tempo") 

	lnEntregado = IIF(TYPE("cur_tempo.entregado") == "C", INT(VAL(cur_tempo.entregado)), cur_tempo.entregado)	
		
	SELECT cur_occab
	APPEND BLANK
	REPLACE idOcCab WITH cur_tempo.idOcCab 
 	REPLACE idProv WITH cur_tempo.idProv ADDITIVE
 	REPLACE RazSoc WITH cur_tempo.Razsoc ADDITIVE
 	REPLACE idMarca WITH cur_tempo.idMarca ADDITIVE
 	REPLACE Marca WITH cur_tempo.Marca ADDITIVE
 	REPLACE idPcCab WITH cur_tempo.idPcCab ADDITIVE
 	REPLACE Fecha WITH cur_tempo.Fecha ADDITIVE
 	REPLACE FecEnt WITH cur_tempo.FecEnt ADDITIVE
 	REPLACE iTotCosto WITH cur_tempo.iTotCosto ADDITIVE
 	REPLACE iTotLista WITH cur_tempo.iTotLista ADDITIVE
 	REPLACE cantTot WITH cur_tempo.cantTot ADDITIVE
 	REPLACE observ WITH cur_tempo.observ ADDITIVE
	REPLACE estado WITH IIF(cur_tempo.estado,.T.,.F.) ADDITIVE
	&&REPLACE entregado WITH IIF(IIF(lnSqlSrv = 1,cur_tempo.entregado,INT(VAL(cur_tempo.entregado))) = 1,.T.,.F.) ADDITIVE 	
	REPLACE entregado WITH IIF(lnEntregado = 1,.T.,.F.) ADDITIVE 

	SELECT cur_tempo
	SKIP 
ENDDO 

loRes.close_query()


ENDPROC
PROCEDURE consultar_ocdet
PARAMETERS lnIdOcCab

LOCAL lcSql, loRes

lcSql = ""
loRes = CREATEOBJECT("odbc_result")

SELECT cur_ocdet
ZAP

lcSql = "SELECT	ocdet.*, "
lcSql = lcSql + "	articulos.codart, "
lcSql = lcSql + "	articulos.descripcio "
lcSql = lcSql + "FROM	ocdet "
lcSql = lcSql + "	INNER JOIN articulos ON articulos.idArticulo = ocdet.idArticulo "
lcSql = lcSql + "WHERE ocdet.idOcCab = " + ALLTRIM(STR(lnIdOcCab)) + " "
lcSql = lcSql + "ORDER BY articulos.codArt ASC"

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_tempo"
loRes.OpenQuery(lcSql)

SELECT cur_tempo
IF RECCOUNT("cur_tempo") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_tempo")
	SELECT cur_ocdet
	APPEND BLANK
	REPLACE cur_ocdet.idOcDet WITH cur_tempo.idOcDet
	REPLACE cur_ocdet.idOcCab WITH cur_tempo.idOcCab ADDITIVE
	REPLACE cur_ocdet.codArt WITH cur_tempo.codArt ADDITIVE
	REPLACE cur_ocdet.descripcio WITH cur_tempo.descripcio ADDITIVE
	REPLACE cur_ocdet.idArticulo WITH cur_tempo.idArticulo ADDITIVE
	REPLACE cur_ocdet.UniDesp WITH cur_tempo.UniDesp ADDITIVE
	REPLACE cur_ocdet.cantPack WITH cur_tempo.cantPack ADDITIVE
	REPLACE cur_ocdet.CodUM WITH cur_tempo.CodUM ADDITIVE 
	REPLACE cur_ocdet.cantped WITH cur_tempo.cantped ADDITIVE
	REPLACE cur_ocdet.cantrec WITH cur_tempo.cantrec ADDITIVE
	REPLACE cur_ocdet.pendiente WITH cur_tempo.pendiente ADDITIVE
	REPLACE cur_ocdet.Costo WITH cur_tempo.Costo ADDITIVE
	REPLACE cur_ocdet.PrLista WITH cur_tempo.PrLista ADDITIVE
	REPLACE cur_ocdet.TotCosto WITH cur_tempo.TotCosto ADDITIVE
	REPLACE cur_ocdet.TotPrLista WITH cur_tempo.TotPrLista ADDITIVE
	REPLACE cur_ocdet.Activo WITH IIF(cur_tempo.Activo, .T., .F.) ADDITIVE

	SELECT cur_tempo
	SKIP
ENDDO

loRes.Close_Query()

SELECT cur_ocdet
IF RECCOUNT("cur_ocdet") > 0 THEN
	GO TOP
ENDIF
ENDPROC
PROCEDURE consultar_ocart
PARAMETERS lnArt, lcFecD, lcFecH, lnEnt

LOCAL lcSql, loRes, loDT

lcSql = ""
loRes = CREATEOBJECT("odbc_result")
loDT = CREATEOBJECT("datetime")
lnSqlSrv = INT(VAL(getconfig("SQLSRV")))

SELECT cur_ocart
ZAP 

lcSql = " SELECT occab.idOcCab, "
lcSql = lcSql + IIF(lnSqlSrv = 1,"ISNULL","IFNULL") + "(occab.idPcCab,0) as idPcCab, "
lcSql = lcSql + "occab.Fecha, "
lcSql = lcSql + "occab.FecEnt, "
lcSql = lcSql + "ocdet.cantPed, "
lcSql = lcSql + "ocdet.cantRec, "
lcSql = lcSql + "ocdet.Pendiente, "
lcSql = lcSql + "ocdet.Costo, "
lcSql = lcSql + "ocdet.PrLista, "
lcSql = lcSql + "ocdet.Activo "
lcSql = lcSql + " FROM occab "
lcSql = lcSql + " 	INNER JOIN ocdet ON ocdet.idOcCab = occab.idOcCab "
lcSql = lcSql + " WHERE occab.FecBaja is null "
lcSql = lcSql + " AND ocdet.idArticulo = " + ALLTRIM(STR(lnArt)) + " "

IF lnSqlSrv = 1 THEN
	lcSql = lcSql + " AND (CONVERT(CHAR(8), fecha , 112) BETWEEN " + lcFecD + " AND " + lcFecH + ") "
ELSE
	lcSql = lcSql + " AND (CAST(fecha AS DATE) BETWEEN " + lcFecD + " AND " + lcFecH + ") "
ENDIF

IF lnEnt = 1 THEN 
	lcSql = lcSql + " 	AND occab.idOcCab in (select idOcCab "
	lcSql = lcSql + " 			from ocdet "
	lcSql = lcSql + " 			where activo = 1 "
	lcSql = lcSql + " 			group by idoccab "
	lcSql = lcSql + " 			having SUM(pendiente) <> 0) "
ENDIF 

lcSql = lcSql + " ORDER BY occab.idOcCab"

loRes.ActiveConnection = goConn.ActiveConnection
loRes.cursor_name = "cur_tempo"

IF !loRes.OpenQuery(lcSql) THEN
	this.ErrorMessage = loRes.Error_Message
	RETURN .F.
ENDIF

IF RECCOUNT("cur_tempo") >0 THEN 
	GO TOP 
ENDIF 

SELECT cur_tempo
DO WHILE !EOF("cur_tempo") 
	SELECT cur_ocart
	APPEND BLANK
	
	REPLACE idOcCab WITH cur_tempo.idOcCab 
 	REPLACE idPcCab WITH IIF(lnSqlSrv = 1,cur_tempo.idPcCab,INT(VAL(cur_tempo.idPcCab))) ADDITIVE
 	REPLACE Fecha WITH cur_tempo.Fecha ADDITIVE
 	REPLACE FecEnt WITH cur_tempo.FecEnt ADDITIVE
 	REPLACE cantPed WITH cur_tempo.cantPed ADDITIVE
 	REPLACE cantRec WITH cur_tempo.cantRec ADDITIVE
 	REPLACE Pendiente WITH cur_tempo.Pendiente ADDITIVE
 	REPLACE Costo WITH cur_tempo.Costo ADDITIVE
 	REPLACE PrLista WITH cur_tempo.PrLista ADDITIVE
 	REPLACE Activo WITH IIF(cur_tempo.Activo, .T., .F.) ADDITIVE
	
	SELECT cur_tempo
	SKIP 
ENDDO 

loRes.close_query()


ENDPROC
PROCEDURE filtrar_pend
PARAMETERS lnProv, lnMar, lnOcD, lnOcH, lcFecD, lcFecH

LOCAL lcSql, loRes, loDT

lcSql = ""
loRes = CREATEOBJECT("odbc_result")
loDT = CREATEOBJECT("datetime")
lnSqlSrv = INT(VAL(getconfig("SQLSRV")))

SELECT cur_ocpend
ZAP 

lcSql = " SELECT ocdet.idOcDet, "
lcSql = lcSql + "occab.idOcCab, "
lcSql = lcSql + "ocdet.idArticulo, "
lcSql = lcSql + "articulos.codart, "
lcSql = lcSql + "articulos.descripcio, "
lcSql = lcSql + "occab.Fecha, "
lcSql = lcSql + "occab.FecEnt, "
lcSql = lcSql + "ocdet.cantPed, "
lcSql = lcSql + "ocdet.cantRec, "
lcSql = lcSql + "ocdet.pendiente "
lcSql = lcSql + " FROM occab "
lcSql = lcSql + " 	INNER JOIN ocdet ON occab.idOcCab = ocdet.idOcCab "
lcSql = lcSql + " 	INNER JOIN articulos ON ocdet.idArticulo = articulos.idArticulo "
lcSql = lcSql + " 	LEFT JOIN marcas ON occab.idMarca = marcas.idMarca "
lcSql = lcSql + " WHERE occab.FecBaja is null "
lcSql = lcSql + " 	AND ocdet.Activo = 1 "
lcSql = lcSql + " 	AND ocdet.Pendiente <> 0 "

IF lnProv <> 0 THEN 
	lcSql = lcSql + " AND occab.idProv = " + ALLTRIM(STR(lnProv))
ENDIF 

IF lnMar <> 0 THEN 
	lcSql = lcSql + " AND " + IIF(lnSqlSrv = 1,"ISNULL","IFNULL") + "(occab.idMarca,0) >= " + ALLTRIM(STR(lnMar))
ENDIF

IF lnOcD <> 0 THEN 
	lcSql = lcSql + " AND occab.idOcCab >= " + ALLTRIM(STR(lnOcD))
ENDIF 

IF lnOcH <> 0 THEN 
	lcSql = lcSql + " AND occab.idOcCab <= " + ALLTRIM(STR(lnOcH))
ENDIF

IF lnSqlSrv = 1 THEN
	lcSql = lcSql + " AND (CONVERT(CHAR(8), fecha , 112) BETWEEN " + lcFecD + " AND " + lcFecH + ") "
ELSE
	lcSql = lcSql + " AND (CAST(fecha AS DATE) BETWEEN " + lcFecD + " AND " + lcFecH + ") "
ENDIF

lcSql = lcSql + " ORDER BY articulos.Codart, occab.Fecha "

loRes.ActiveConnection = goConn.ActiveConnection
loRes.cursor_name = "cur_tempo"

IF !loRes.OpenQuery(lcSql) THEN
	this.ErrorMessage = loRes.Error_Message
	RETURN .F.
ENDIF

IF RECCOUNT("cur_tempo") >0 THEN 
	GO TOP 
ENDIF 

SELECT cur_tempo
DO WHILE !EOF("cur_tempo") 
	SELECT cur_ocpend
	APPEND BLANK
	
	REPLACE sel WITH .F. 
	REPLACE idOcDet WITH cur_tempo.idOcDet ADDITIVE 
	REPLACE idOcCab WITH cur_tempo.idOcCab ADDITIVE 
	REPLACE idArticulo WITH cur_tempo.idArticulo ADDITIVE
 	REPLACE CodArt WITH cur_tempo.CodArt ADDITIVE
 	REPLACE descripcio WITH cur_tempo.descripcio ADDITIVE
 	REPLACE Fecha WITH cur_tempo.Fecha ADDITIVE
 	REPLACE FecEnt WITH cur_tempo.FecEnt ADDITIVE
 	REPLACE cantPed WITH cur_tempo.cantPed ADDITIVE
 	REPLACE cantRec WITH cur_tempo.cantRec ADDITIVE
 	REPLACE Pendiente WITH cur_tempo.pendiente ADDITIVE 
	
	SELECT cur_tempo
	SKIP 
ENDDO 

loRes.close_query()

ENDPROC
PROCEDURE grabar_pend
LOCAL loCommand, lcSql

loCommand = CREATEOBJECT("odbc_command")
loRes = CREATEOBJECT("odbc_result")
lcSql = ""

SELECT cur_ocPend
IF RECCOUNT("cur_ocPend") > 0 THEN 
	GO TOP 
ELSE 
	RETURN .F.
ENDIF 

goConn.BeginTransaction()

SELECT cur_ocPend
DO WHILE !EOF("cur_ocPend") 
	IF cur_ocPend.sel = .T. THEN 

		lcSql = "UPDATE ocdet "
		lcSql = lcSql + " SET activo = 0 "
		lcSql = lcSql + " WHERE idarticulo = " + ALLTRIM(STR(cur_ocPend.idArticulo)) + " "
		lcSql = lcSql + " 	AND idOcCab = " + ALLTRIM(STR(cur_ocPend.idOcCab)) + " "
		lcSql = lcSql + " 	AND idOcDet	= " + ALLTRIM(STR(cur_ocPend.idOcDet))

		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql

		IF !loCommand.Execute() THEN
			this.ErrorMessage = loCommand.ErrorMessage
			goConn.Rollback()
			RETURN .F.
		ENDIF
	ENDIF 
	
	SELECT cur_ocPend
	SKIP 
ENDDO

goConn.Commit()

RETURN .T.
ENDPROC
PROCEDURE descontar_pend
LOCAL lcSql, loRes, loCommand, lnPend, lnResto, lnCant, lnSum

lcSql = ""
loRes = CREATEOBJECT("odbc_result")
loCommand = CREATEOBJECT("odbc_command")
lnPend = 0.00
lnResto = 0.00
lnCant = 0.00
lnSum = 0.00

SELECT idarticulo, codart, SUM(cantreci) as cantreci;
FROM cur_rtos;
GROUP BY idarticulo, codart;
INTO CURSOR cur_ing

IF RECCOUNT("cur_ing") > 0
	GO TOP 
ELSE 
	RETURN .F.
ENDIF

goConn.BeginTransaction()

&& Recorro cada articulo del ingreso
SELECT cur_ing
DO WHILE !EOF("cur_ing")
	lnPend = this.calc_pendientes(cur_ing.idarticulo)
	
	&& Si la cantidad pendiente es cero, no tengo que descontar nada, entonces salto al siguiente articulo.
	IF lnPend <> 0 THEN 
		&& Levanto el detalle de los pendientes
		lcSql = " SELECT occab.idOcCab, "
		lcSql = lcSql + "ocdet.idArticulo, "
		lcSql = lcSql + "articulos.codart, "
		lcSql = lcSql + "occab.Fecha, "
		lcSql = lcSql + "ocdet.cantPed, "
		lcSql = lcSql + "ocdet.cantRec, "
		lcSql = lcSql + "ocdet.pendiente "
		lcSql = lcSql + " FROM occab "
		lcSql = lcSql + " 	INNER JOIN ocdet ON occab.idOcCab = ocdet.idOcCab "
		lcSql = lcSql + " 	INNER JOIN articulos ON ocdet.idArticulo = articulos.idArticulo "
		lcSql = lcSql + " WHERE occab.FecBaja is null "
		lcSql = lcSql + " 	AND ocdet.Activo = 1 "
		lcSql = lcSql + " 	AND ocdet.Pendiente <> 0 "
		lcSql = lcSql + " 	AND ocdet.idArticulo = " + ALLTRIM(STR(cur_ing.idarticulo)) + " "
		lcSql = lcSql + " ORDER BY occab.Fecha, occab.idoccab ASC"
		
		loRes.ActiveConnection = goConn.ActiveConnection
		loRes.cursor_name = "cur_tempo"

		IF !loRes.OpenQuery(lcSql) THEN
			this.ErrorMessage = loRes.Error_Message
			RETURN .F.
		ENDIF

		IF RECCOUNT("cur_tempo") > 0 THEN 
			GO TOP 
			
			lnResto = cur_ing.cantreci 
		
			&& Recorro cada pendiente, empezando desde el mas viejo.
			DO WHILE !EOF("cur_tempo")
				IF lnResto > 0 THEN 
					
					lnResto = lnResto - cur_tempo.pendiente
					
					IF lnResto >= 0 THEN 
						lcSql = "UPDATE OcDet SET cantRec = cantPed, pendiente = 0 "
						lcSql = lcSql + " WHERE idarticulo = " + ALLTRIM(STR(cur_tempo.idArticulo)) + " "
						lcSql = lcSql + " 	AND idOcCab = " + ALLTRIM(STR(cur_tempo.idOcCab))
					ELSE 
						lnCant = lnResto + cur_tempo.pendiente
						lnSum = cur_tempo.pendiente - lnCant
						
						lcSql = "UPDATE OcDet SET cantRec = cantRec + " + ALLTRIM(STR(lnCant)) + ", pendiente = " + ALLTRIM(STR(lnSum)) + " "
						lcSql = lcSql + " WHERE idarticulo = " + ALLTRIM(STR(cur_tempo.idArticulo)) + " "
						lcSql = lcSql + " 	AND idOcCab = " + ALLTRIM(STR(cur_tempo.idOcCab))
					ENDIF 
					
					loCommand.ActiveConnection = goConn.ActiveConnection
					loCommand.CommandText = lcSql

					IF !loCommand.Execute() THEN
						this.ErrorMessage = loCommand.ErrorMessage
						goConn.Rollback()
						RETURN .F.
					ENDIF 
					
				ENDIF 
				
				SELECT cur_tempo
				SKIP 
			ENDDO 
			
			loRes.close_query()
		ENDIF 
	ENDIF 
	
	SELECT cur_ing 
	SKIP 
ENDDO 

goConn.Commit()

RETURN .T.
ENDPROC


************************************************************
OBJETO: cls_form_ocmanual
************************************************************
*** PROPIEDADES ***
BorderStyle = 2
Height = 610
Width = 850
DoCreate = .T.
Caption = "Ingreso de Ordenes de Compra"
Name = "cls_form_ocmanual"
contenido.Width = 850
contenido.Height = 610
contenido.Name = "contenido"

*** METODOS ***
PROCEDURE blanquear
thisform.contenido.sel_prov.blanquear()
thisform.contenido.sel_prov.valcpoid = 0
thisform.contenido.sel_marca.blanquear()
thisform.contenido.sel_marca.valcpoid = 0
thisform.contenido.txtfecent.Value = DATE() + 7
thisform.contenido.txtobserv.Value = ""
thisform.contenido.sel_articulo.blanquear()
thisform.contenido.sel_articulo.valcpoid = 0
thisform.contenido.txtCantidad.Value = 0.00
thisform.contenido.totales.txttotCant.Value = 0.00
thisform.contenido.totales.txttotcosto.Value = 0.00
thisform.contenido.totales.txttotprlista.Value = 0.00
thisform.oc.limpiar()

thisform.contenido.sel_prov.Enabled = .T.
thisform.contenido.sel_marca.Enabled = .T.
thisform.contenido.txtfecent.Enabled = .T.
thisform.contenido.txtobserv.Enabled = .T.
thisform.contenido.btnaceptar.Enabled = .T.

thisform.contenido.sel_prov.SetFocus()
ENDPROC
PROCEDURE Init
DODEFAULT()

Thisform.oc.crear_cursor()

SELECT cur_pcdet
SET ORDER TO idPCDet 

thisform.contenido.grdarticulos.alias_name = "cur_pcdet"
thisform.contenido.grdarticulos.RecordSource = "cur_pcdet"
thisform.contenido.grdarticulos.list_controlsource = "codArt,descripcio,cantped,costo,prlista"
thisform.contenido.grdarticulos.lista_ancho_cols = "100,300,70,70,70"
thisform.contenido.grdarticulos.titulos_cabeceras = "Código,Descripción,Cantidad,Costo,Pr. Lista"
thisform.contenido.grdarticulos.permitir_ordenamiento = .F.
thisform.contenido.grdarticulos.permitir_busqueda = .F.
thisform.contenido.grdarticulos.generar_grid()

thisform.contenido.sel_prov.SetFocus()
thisform.contenido.txtfecent.Value = DATE() + 7
ENDPROC


************************************************************
OBJETO: oc
************************************************************
*** PROPIEDADES ***
Top = 588
Left = 708
Height = 17
Width = 36
Name = "oc"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Proveedor:"
Height = 15
Left = 14
Top = 16
Width = 72
TabIndex = 13
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: sel_prov
************************************************************
*** PROPIEDADES ***
Top = 10
Left = 100
TabIndex = 1
autocompletar_ceros = .F.
esnumerico = .T.
nombre_campo_codigo = idProv
nombre_campo_desc = razSoc
nombre_tabla = proveedor
pkfield = idProv
criterio_filtro = fecBaja IS NULL
Name = "sel_prov"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta6
************************************************************
*** PROPIEDADES ***
Caption = "Marca:"
Height = 15
Left = 14
Top = 40
Width = 72
TabIndex = 17
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: sel_marca
************************************************************
*** PROPIEDADES ***
Top = 34
Left = 100
TabIndex = 2
autocompletar_ceros = .F.
esnumerico = .T.
nombre_campo_codigo = idMarca
nombre_campo_desc = descripcio
nombre_tabla = marcas
pkfield = idMarca
Name = "sel_marca"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta7
************************************************************
*** PROPIEDADES ***
Caption = "Fecha Entrega:"
Height = 15
Left = 14
Top = 63
Width = 88
TabIndex = 16
Name = "Clsetiqueta7"

*** METODOS ***


************************************************************
OBJETO: txtFecEnt
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 102
TabIndex = 3
Top = 60
Width = 126
isdatetime = .T.
Name = "txtFecEnt"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Observaciones:"
Height = 15
Left = 13
Top = 86
Width = 91
TabIndex = 12
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: txtObserv
************************************************************
*** PROPIEDADES ***
Height = 43
Left = 102
TabIndex = 4
Top = 83
Width = 485
Name = "txtObserv"

*** METODOS ***


************************************************************
OBJETO: Clslinea1
************************************************************
*** PROPIEDADES ***
Height = 1
Left = 5
Top = 133
Width = 840
Name = "Clslinea1"

*** METODOS ***


************************************************************
OBJETO: btnSalir
************************************************************
*** PROPIEDADES ***
Top = 562
Left = 800
TabIndex = 12
Name = "btnSalir"

*** METODOS ***


************************************************************
OBJETO: btnAceptar
************************************************************
*** PROPIEDADES ***
Top = 82
Left = 603
TabIndex = 5
Name = "btnAceptar"

*** METODOS ***
PROCEDURE Click
LOCAL lcSql, loRes

lcSql = ""
loRes = CREATEOBJECT("odbc_result")

IF thisform.contenido.sel_prov.txtCodigo.Value = 0 THEN 
	MESSAGEBOX("Debe ingresar el proveedor", 0+48, Thisform.Caption)
	Thisform.contenido.sel_prov.txtCodigo.SetFocus()
	RETURN .F.
ENDIF 

thisform.contenido.sel_prov.Enabled = .F.
thisform.contenido.sel_marca.Enabled = .F.
thisform.contenido.txtfecent.Enabled = .F.
thisform.contenido.txtobserv.Enabled = .F.
thisform.contenido.btnaceptar.Enabled = .F.

ENDPROC


************************************************************
OBJETO: btnAgregar
************************************************************
*** PROPIEDADES ***
Top = 143
Left = 757
TabIndex = 8
Name = "btnAgregar"

*** METODOS ***
PROCEDURE Click
LOCAL lnIdArticulo, lcCodArt, lcDesc, lnCosto, lnPrLista
LOCAL lnCantidad, lnUniDesp, lnCantpack, lnCantUD, lnCantPed

lnIdArticulo = 0
lcCodArt = ""
lcDesc = ""
lnCosto = 0.00
lnPrLista = 0.00
lnCantidad = 0.00
lnUniDesp = 0.00
lncantPack = 0.00
lnCantUD = 0.00
lnCantPed = 0.00

IF Thisform.contenido.btnAceptar.Enabled = .T. THEN 
	RETURN .F.
ENDIF 

IF Thisform.contenido.sel_Articulo.valcpoid = 0 THEN
	MESSAGEBOX("Debe ingresar el artículo", 0+48, Thisform.Caption)
	Thisform.contenido.sel_Articulo.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

IF Thisform.contenido.txtCantidad.Value = 0.00 THEN
	MESSAGEBOX("La cantidad no puede ser cero", 0+48, Thisform.Caption)
	Thisform.contenido.txtCantidad.SetFocus()
	RETURN .F.
ENDIF

&& Verifico que el articulo ya no haya sido ingresado.

SELECT cur_pcdet
IF RECCOUNT() > 0
	GO TOP
ENDIF

SELECT cur_pcdet
DO WHILE !EOF()
	IF ALLTRIM(cur_pcdet.codArt) == ALLTRIM(Thisform.contenido.sel_Articulo.txtCodigo.Value) THEN
		IF MESSAGEBOX("El artículo ya se encuentra cargado, ¿Desea acumular la cantidad?",4+32, Thisform.Caption) == 6 THEN
			Thisform.contenido.txtCantidad.Value = Thisform.contenido.txtcantidad.Value + cur_pcdet.cantPed	
			
			SELECT cur_pcdet
			DELETE
		ELSE 
			thisform.contenido.sel_articulo.txtCodigo.SetFocus()	
			RETURN .F.
		ENDIF 
	ENDIF 
	
	SELECT cur_pcdet
	SKIP
ENDDO 

&& Asigno los valores a las variables.
lnIdArticulo = Thisform.contenido.sel_Articulo.valcpoid
lcCodArt = thisform.contenido.sel_articulo.txtCodigo.Value 
lcDesc = thisform.contenido.sel_articulo.txtDescripcion.Value 
lnCantidad = thisform.contenido.txtCantidad.Value 
lnCosto = articulos.costorep
lnPrLista = articulos.prlista

&& Calculo la UD
lnCantUD = thisform.oc.calc_mult_ud(lnIdArticulo, lnCantidad)

IF lnCantUD = -1 THEN 
	RETURN .F.
ELSE 
	IF lnCantidad <> lnCantUD THEN
		MESSAGEBOX("Atención, la cantidad a pedir se cambiará por " + ALLTRIM(STR(lnCantUD, 10, 2)), 0+64, Thisform.Caption)
		
		lnCantPed = lnCantUD
		lnUniDesp = Thisform.oc.unidesp
		lnCantPack = Thisform.oc.cantpack
	ELSE
		lnCantPed = lnCantidad
		lnUniDesp = Thisform.oc.unidesp
		lnCantPack = Thisform.oc.cantpack
	ENDIF
ENDIF 


thisform.oc.idProv = thisform.contenido.sel_prov.valcpoid
thisform.oc.idMarca = thisform.contenido.sel_marca.valcpoid
thisform.oc.fecent = thisform.contenido.txtFecEnt.Value
thisform.oc.usualta = ALLTRIM(gcCodUsu)
thisform.oc.fecalta = DATETIME()
thisform.oc.idhostalta = SYS(0)

SELECT cur_pcdet
IF RECCOUNT("cur_pcdet") > 0 THEN
	GO TOP
ENDIF

SELECT cur_pcdet			
thisform.oc.agregar_detalle(0, 0, lnIdArticulo, lcCodArt, lcDesc, ;
	0.00, 0.00, 0.00, 0.00, lnCantPed, lnUniDesp, lnCantPack, 0.00, 0.00, ;
	0.00, lnCosto, lnPrLista)

thisform.oc.totalizar()
thisform.contenido.totales.txtTotCant.Value = thisform.oc.totped
thisform.contenido.totales.txttotcosto.Value = thisform.oc.totcosto
thisform.contenido.totales.txtTotPrLista.Value = thisform.oc.totprlista
Thisform.Contenido.grdArticulos.Refresh()
Thisform.Contenido.sel_Articulo.Blanquear()
Thisform.Contenido.txtCantidad.blanquear()
Thisform.Contenido.sel_Articulo.txtCodigo.SetFocus()


ENDPROC


************************************************************
OBJETO: btnEliminar
************************************************************
*** PROPIEDADES ***
Top = 143
Left = 802
TabIndex = 9
Name = "btnEliminar"

*** METODOS ***
PROCEDURE Click
LOCAL lnResp

lnResp = MESSAGEBOX("Está seguro que desea eliminar este ítem?", 4+32, Thisform.Caption)

IF lnResp = 6 THEN
	SELECT cur_pcdet
	DELETE
	
	Thisform.Contenido.grdArticulos.Refresh()
	thisform.oc.totalizar()
	thisform.contenido.totales.txtTotCant.Value = thisform.oc.totped
	thisform.contenido.totales.txttotcosto.Value = thisform.oc.totcosto
	thisform.contenido.totales.txtTotPrLista.Value = thisform.oc.totprlista
	
	thisform.contenido.sel_articulo.SetFocus()
ENDIF


ENDPROC


************************************************************
OBJETO: btnGrabar
************************************************************
*** PROPIEDADES ***
Top = 562
Left = 754
TabIndex = 11
Name = "btnGrabar"

*** METODOS ***
PROCEDURE Click
LOCAL lnResp

SELECT cur_pcdet
IF RECCOUNT("cur_pcdet") = 0 THEN 
	RETURN .F.
ENDIF 

thisform.oc.observ = ALLTRIM(thisform.contenido.txtObserv.Value)

IF !thisform.oc.generar_oc() THEN
	RETURN
ENDIF

&& Verifico si esta seteado para mandar por pedido la OC
IF getGlobalCFG("ENVIAR_OC") THEN
	lnResp = MESSAGEBOX("La Orden de Compra N° " + ALLTRIM(STR(thisform.oc.idoccab)) + " se ha generado con éxito. ¿Desea transferir la Orden de Compra como pedido a GPSDER?", 4+32, Thisform.Caption)
	IF lnResp = 6  THEN
		IF !thisform.oc.convertir_en_pedido(thisform.oc.idoccab) THEN
			MESSAGEBOX(thisform.oc.errorMessage, 0+48, Thisform.Caption)
			RETURN
		ENDIF
	ENDIF
ELSE 
	MESSAGEBOX("La Orden de Compra N° " + ALLTRIM(STR(thisform.oc.idoccab)) + " se ha generado con éxito",0+64, Thisform.Caption)
ENDIF 

Thisform.oc.imprimir_oc()

thisform.blanquear()
ENDPROC


************************************************************
OBJETO: btnCancelar
************************************************************
*** PROPIEDADES ***
Top = 561
Left = 4
TabIndex = 13
Name = "btnCancelar"

*** METODOS ***
PROCEDURE Click
thisform.blanquear()
ENDPROC


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Artículo:"
Height = 15
Left = 13
Top = 148
Width = 54
TabIndex = 13
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Cantidad:"
Height = 15
Left = 598
Top = 149
Width = 56
TabIndex = 16
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: txtCantidad
************************************************************
*** PROPIEDADES ***
Left = 653
TabIndex = 7
Top = 145
isnumeric = .T.
Name = "txtCantidad"

*** METODOS ***


************************************************************
OBJETO: grdArticulos
************************************************************
*** PROPIEDADES ***
Height = 333
Left = 4
TabIndex = 10
Top = 190
Width = 842
Name = "grdArticulos"
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
OBJETO: sel_Articulo
************************************************************
*** PROPIEDADES ***
Top = 143
Left = 62
Width = 534
Height = 25
TabIndex = 6
autocompletar_ceros = .F.
nombre_campo_codigo = codArt
nombre_campo_desc = descripcio
nombre_tabla = articulos
pkfield = idArticulo
criterio_filtro = fecBaja IS NULL
Name = "sel_Articulo"
txtCodigo.Width = 150
txtCodigo.Name = "txtCodigo"
txtDescripcion.Left = 156
txtDescripcion.Top = 2
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***
PROCEDURE recuperar_datos
LOCAL lcSql, loResult, lcCodArt, lnIdProv, lnIdMarca

loResult = CREATEOBJECT("odbc_result")
lnIdProv = Thisform.contenido.sel_prov.txtCodigo.Value 
lnIdMarca = Thisform.contenido.sel_marca.txtCodigo.Value 

&& Valido que el articulo sea del proveedor cargado
IF Thisform.contenido.sel_articulo.valcpoid <> 0 THEN

	lcCodArt = Thisform.contenido.sel_articulo.txtCodigo.Value
	
	lcSql = "SELECT * FROM articulos WHERE codart = '" + lcCodArt + "'"
	loResult.ActiveConnection = goConn.ActiveConnection
	loResult.cursor_name = "cur_art"
	loResult.openquery(lcSql)
	
	IF lnIdMarca <> 0 THEN 
		IF cur_art.idProv <> lnIdProv .AND. cur_art.idMarca <> lnIdMarca THEN
			MESSAGEBOX("El artículo cargado no pertenece a este proveedor y esta marca", 0+16, Thisform.Caption)
			Thisform.contenido.sel_articulo.valcpoid = 0 
			Thisform.contenido.sel_articulo.txtCodigo.Value = ""
			Thisform.contenido.sel_articulo.txtDescripcion.Value = ""
			This.txtCodigo.SetFocus()
		ELSE 
			IF cur_art.idProv <> lnIdProv THEN 
				MESSAGEBOX("El artículo cargado no pertenece a este proveedor", 0+16, Thisform.Caption)
				Thisform.contenido.sel_articulo.valcpoid = 0 
				Thisform.contenido.sel_articulo.txtCodigo.Value = ""
				Thisform.contenido.sel_articulo.txtDescripcion.Value = ""
				This.txtCodigo.SetFocus()
			ELSE 
				IF cur_art.idMarca <> lnIdMarca THEN
					MESSAGEBOX("El artículo cargado no pertenece a esta marca", 0+16, Thisform.Caption)
					Thisform.contenido.sel_articulo.valcpoid = 0 
					Thisform.contenido.sel_articulo.txtCodigo.Value = ""
					Thisform.contenido.sel_articulo.txtDescripcion.Value = ""
					This.txtCodigo.SetFocus()
				ENDIF 
			ENDIF 
		ENDIF 
	ELSE 
		IF cur_art.idProv <> lnIdProv THEN 
			MESSAGEBOX("El artículo cargado no pertenece a este proveedor", 0+16, Thisform.Caption)
			Thisform.contenido.sel_articulo.valcpoid = 0 
			Thisform.contenido.sel_articulo.txtCodigo.Value = ""
			Thisform.contenido.sel_articulo.txtDescripcion.Value = ""
			This.txtCodigo.SetFocus()
		ENDIF 
	ENDIF 
	loResult.close_query()	
ENDIF
ENDPROC


************************************************************
OBJETO: Totales
************************************************************
*** PROPIEDADES ***
Top = 526
Left = 6
Width = 839
Height = 32
BackColor = 212,212,212
Name = "Totales"

*** METODOS ***


************************************************************
OBJETO: CLSETIQUETA5
************************************************************
*** PROPIEDADES ***
Caption = "Total Costo:"
Height = 15
Left = 209
Top = 9
Width = 72
Name = "CLSETIQUETA5"

*** METODOS ***


************************************************************
OBJETO: txtTotCosto
************************************************************
*** PROPIEDADES ***
Left = 280
ReadOnly = .T.
Top = 5
isnumeric = .T.
Name = "txtTotCosto"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta8
************************************************************
*** PROPIEDADES ***
Caption = "Total Pr. Lista:"
Height = 15
Left = 393
Top = 9
Width = 80
Name = "Clsetiqueta8"

*** METODOS ***


************************************************************
OBJETO: txtTotPrLista
************************************************************
*** PROPIEDADES ***
Left = 475
ReadOnly = .T.
Top = 5
isnumeric = .T.
Name = "txtTotPrLista"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Total Cantidad:"
Height = 15
Left = 12
Top = 9
Width = 79
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: txtTotCant
************************************************************
*** PROPIEDADES ***
Left = 96
ReadOnly = .T.
Top = 5
isnumeric = .T.
Name = "txtTotCant"

*** METODOS ***


************************************************************
OBJETO: cls_form_ocmanual
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


