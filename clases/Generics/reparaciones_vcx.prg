************************************************************
OBJETO: cls_abm_piezas
************************************************************
*** PROPIEDADES ***
DoCreate = .T.
Caption = "Piezas"
WindowState = 0
cnombretabla = piezas
pk_fieldname = idPieza
listctrlsource = idPieza,Descripcio
listwidthcols = 70,300
titulos_cabeceras = #,Descripción
Name = "cls_abm_piezas"
Herramientas.cmdNuevo.Name = "cmdNuevo"
Herramientas.cmdEditar.Name = "cmdEditar"
Herramientas.cmdEliminar.Name = "cmdEliminar"
Herramientas.cmdCerrar.Name = "cmdCerrar"
Herramientas.cmdGrabar.Name = "cmdGrabar"
Herramientas.cmdCancelar.Name = "cmdCancelar"
Herramientas.cmdExcel.Name = "cmdExcel"
Herramientas.Name = "Herramientas"
Pgf.ErasePage = .T.
Pgf.Page1.grdDatos.COLUMN1.HEADER1.Name = "HEADER1"
Pgf.Page1.grdDatos.COLUMN1.TEXT1.Name = "TEXT1"
Pgf.Page1.grdDatos.COLUMN1.Name = "COLUMN1"
Pgf.Page1.grdDatos.COLUMN2.HEADER1.Name = "HEADER1"
Pgf.Page1.grdDatos.COLUMN2.TEXT1.Name = "TEXT1"
Pgf.Page1.grdDatos.COLUMN2.Name = "COLUMN2"
Pgf.Page1.grdDatos.COLUMN3.HEADER1.Name = "HEADER1"
Pgf.Page1.grdDatos.COLUMN3.TEXT1.Name = "TEXT1"
Pgf.Page1.grdDatos.COLUMN3.Name = "COLUMN3"
Pgf.Page1.grdDatos.COLUMN4.HEADER1.Name = "HEADER1"
Pgf.Page1.grdDatos.COLUMN4.TEXT1.Name = "TEXT1"
Pgf.Page1.grdDatos.COLUMN4.Name = "COLUMN4"
Pgf.Page1.grdDatos.COLUMN5.HEADER1.Name = "HEADER1"
Pgf.Page1.grdDatos.COLUMN5.TEXT1.Name = "TEXT1"
Pgf.Page1.grdDatos.COLUMN5.Name = "COLUMN5"
Pgf.Page1.grdDatos.COLUMN6.HEADER1.Name = "HEADER1"
Pgf.Page1.grdDatos.COLUMN6.TEXT1.Name = "TEXT1"
Pgf.Page1.grdDatos.COLUMN6.Name = "COLUMN6"
Pgf.Page1.grdDatos.COLUMN7.HEADER1.Name = "HEADER1"
Pgf.Page1.grdDatos.COLUMN7.TEXT1.Name = "TEXT1"
Pgf.Page1.grdDatos.COLUMN7.Name = "COLUMN7"
Pgf.Page1.grdDatos.COLUMN8.HEADER1.Name = "HEADER1"
Pgf.Page1.grdDatos.COLUMN8.TEXT1.Name = "TEXT1"
Pgf.Page1.grdDatos.COLUMN8.Name = "COLUMN8"
Pgf.Page1.grdDatos.COLUMN9.HEADER1.Name = "HEADER1"
Pgf.Page1.grdDatos.COLUMN9.TEXT1.Name = "TEXT1"
Pgf.Page1.grdDatos.COLUMN9.Name = "COLUMN9"
Pgf.Page1.grdDatos.COLUMN10.HEADER1.Name = "HEADER1"
Pgf.Page1.grdDatos.COLUMN10.TEXT1.Name = "TEXT1"
Pgf.Page1.grdDatos.COLUMN10.Name = "COLUMN10"
Pgf.Page1.grdDatos.COLUMN11.HEADER1.Name = "HEADER1"
Pgf.Page1.grdDatos.COLUMN11.TEXT1.Name = "TEXT1"
Pgf.Page1.grdDatos.COLUMN11.Name = "COLUMN11"
Pgf.Page1.grdDatos.COLUMN12.HEADER1.Name = "HEADER1"
Pgf.Page1.grdDatos.COLUMN12.TEXT1.Name = "TEXT1"
Pgf.Page1.grdDatos.COLUMN12.Name = "COLUMN12"
Pgf.Page1.grdDatos.COLUMN13.HEADER1.Name = "HEADER1"
Pgf.Page1.grdDatos.COLUMN13.TEXT1.Name = "TEXT1"
Pgf.Page1.grdDatos.COLUMN13.Name = "COLUMN13"
Pgf.Page1.grdDatos.COLUMN14.HEADER1.Name = "HEADER1"
Pgf.Page1.grdDatos.COLUMN14.TEXT1.Name = "TEXT1"
Pgf.Page1.grdDatos.COLUMN14.Name = "COLUMN14"
Pgf.Page1.grdDatos.COLUMN15.HEADER1.Name = "HEADER1"
Pgf.Page1.grdDatos.COLUMN15.TEXT1.Name = "TEXT1"
Pgf.Page1.grdDatos.COLUMN15.Name = "COLUMN15"
Pgf.Page1.grdDatos.COLUMN16.HEADER1.Name = "HEADER1"
Pgf.Page1.grdDatos.COLUMN16.TEXT1.Name = "TEXT1"
Pgf.Page1.grdDatos.COLUMN16.Name = "COLUMN16"
Pgf.Page1.grdDatos.COLUMN17.HEADER1.Name = "HEADER1"
Pgf.Page1.grdDatos.COLUMN17.TEXT1.Name = "TEXT1"
Pgf.Page1.grdDatos.COLUMN17.Name = "COLUMN17"
Pgf.Page1.grdDatos.COLUMN18.HEADER1.Name = "HEADER1"
Pgf.Page1.grdDatos.COLUMN18.TEXT1.Name = "TEXT1"
Pgf.Page1.grdDatos.COLUMN18.Name = "COLUMN18"
Pgf.Page1.grdDatos.COLUMN19.HEADER1.Name = "HEADER1"
Pgf.Page1.grdDatos.COLUMN19.TEXT1.Name = "TEXT1"
Pgf.Page1.grdDatos.COLUMN19.Name = "COLUMN19"
Pgf.Page1.grdDatos.COLUMN20.HEADER1.Name = "HEADER1"
Pgf.Page1.grdDatos.COLUMN20.TEXT1.Name = "TEXT1"
Pgf.Page1.grdDatos.COLUMN20.Name = "COLUMN20"
Pgf.Page1.grdDatos.Name = "grdDatos"
Pgf.Page1.Name = "Page1"
Pgf.Page2.cnt_fields.Name = "cnt_fields"
Pgf.Page2.Name = "Page2"
Pgf.Name = "Pgf"

*** METODOS ***


************************************************************
OBJETO: etiqDescripcion
************************************************************
*** PROPIEDADES ***
Caption = "Descripción:"
Height = 14
Left = 24
Top = 39
Width = 84
Name = "etiqDescripcion"

*** METODOS ***


************************************************************
OBJETO: txtDescripcion
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 100
Top = 35
Width = 224
cfieldname = Descripcio
msgerror = Debe ingresar la descripción de la pieza
ischaracter = .T.
Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: cls_abm_piezas
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_abm_clirep
************************************************************
*** PROPIEDADES ***
DoCreate = .T.
Caption = "Clientes de reparaciones"
cnombretabla = clirep
listctrlsource = idCliRep,razSoc,telefono,nextel
listwidthcols = 70,250,100,100
titulos_cabeceras = #,Razón Social,Teléfono,Nextel
pk_fieldname = idCliRep
Name = "cls_abm_clirep"
Herramientas.cmdNuevo.Name = "cmdNuevo"
Herramientas.cmdEditar.Name = "cmdEditar"
Herramientas.cmdEliminar.Name = "cmdEliminar"
Herramientas.cmdCerrar.Name = "cmdCerrar"
Herramientas.cmdGrabar.Name = "cmdGrabar"
Herramientas.cmdCancelar.Name = "cmdCancelar"
Herramientas.cmdExcel.Name = "cmdExcel"
Herramientas.Name = "Herramientas"
Pgf.ErasePage = .T.
Pgf.Page1.grdDatos.COLUMN1.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN1.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN1.Name = "COLUMN1"
Pgf.Page1.grdDatos.COLUMN2.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN2.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN2.Name = "COLUMN2"
Pgf.Page1.grdDatos.COLUMN3.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN3.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN3.Name = "COLUMN3"
Pgf.Page1.grdDatos.COLUMN4.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN4.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN4.Name = "COLUMN4"
Pgf.Page1.grdDatos.COLUMN5.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN5.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN5.Name = "COLUMN5"
Pgf.Page1.grdDatos.COLUMN6.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN6.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN6.Name = "COLUMN6"
Pgf.Page1.grdDatos.COLUMN7.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN7.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN7.Name = "COLUMN7"
Pgf.Page1.grdDatos.COLUMN8.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN8.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN8.Name = "COLUMN8"
Pgf.Page1.grdDatos.COLUMN9.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN9.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN9.Name = "COLUMN9"
Pgf.Page1.grdDatos.COLUMN10.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN10.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN10.Name = "COLUMN10"
Pgf.Page1.grdDatos.COLUMN11.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN11.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN11.Name = "COLUMN11"
Pgf.Page1.grdDatos.COLUMN12.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN12.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN12.Name = "COLUMN12"
Pgf.Page1.grdDatos.COLUMN13.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN13.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN13.Name = "COLUMN13"
Pgf.Page1.grdDatos.COLUMN14.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN14.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN14.Name = "COLUMN14"
Pgf.Page1.grdDatos.COLUMN15.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN15.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN15.Name = "COLUMN15"
Pgf.Page1.grdDatos.COLUMN16.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN16.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN16.Name = "COLUMN16"
Pgf.Page1.grdDatos.COLUMN17.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN17.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN17.Name = "COLUMN17"
Pgf.Page1.grdDatos.COLUMN18.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN18.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN18.Name = "COLUMN18"
Pgf.Page1.grdDatos.COLUMN19.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN19.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN19.Name = "COLUMN19"
Pgf.Page1.grdDatos.COLUMN20.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN20.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN20.Name = "COLUMN20"
Pgf.Page1.grdDatos.Name = "grdDatos"
Pgf.Page1.Name = "Page1"
Pgf.Page2.cnt_fields.Name = "cnt_fields"
Pgf.Page2.Name = "Page2"
Pgf.Name = "Pgf"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Razón Social:"
Height = 15
Left = 24
Top = 27
Width = 84
TabIndex = 7
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Tipo Doc.:"
Height = 15
Left = 24
Top = 51
Width = 72
TabIndex = 8
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Número:"
Height = 15
Left = 595
Top = 51
Width = 54
TabIndex = 9
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: txtRazSoc
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 108
MaxLength = 60
TabIndex = 1
Top = 24
Width = 432
ischaracter = .T.
cfieldname = razSoc
Name = "txtRazSoc"

*** METODOS ***


************************************************************
OBJETO: sel_TipoDoc
************************************************************
*** PROPIEDADES ***
Top = 46
Left = 106
TabIndex = 3
cfieldname = idTipoDoc
esnumerico = .F.
nombre_campo_codigo = TipoDoc
nombre_campo_desc = Descripcio
nombre_tabla = tipodoc
pkfield = idTipoDoc
requerido = .T.
Name = "sel_TipoDoc"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: txtNumero
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 650
MaxLength = 20
TabIndex = 4
Top = 48
Width = 128
ischaracter = .T.
cfieldname = nroFiscal
Name = "txtNumero"

*** METODOS ***


************************************************************
OBJETO: chkPresupuestar
************************************************************
*** PROPIEDADES ***
Top = 27
Left = 561
Height = 18
Width = 97
Alignment = 0
Caption = "Presupuestar"
TabIndex = 2
cfieldname = presup
Name = "chkPresupuestar"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Telefono:"
Height = 15
Left = 24
Top = 76
Width = 72
TabIndex = 10
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: txtTelefono
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 108
MaxLength = 20
TabIndex = 5
Top = 72
Width = 128
ischaracter = .T.
cfieldname = telefono
Name = "txtTelefono"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Nextel:"
Height = 15
Left = 243
Top = 76
Width = 72
TabIndex = 11
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: txtNextel
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 285
MaxLength = 20
TabIndex = 6
Top = 72
Width = 128
ischaracter = .T.
cfieldname = nextel
Name = "txtNextel"

*** METODOS ***


************************************************************
OBJETO: cls_abm_clirep
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_abm_repa
************************************************************
*** PROPIEDADES ***
DoCreate = .T.
Caption = "Reparadores"
cnombretabla = repdores
pk_fieldname = idRepar
listctrlsource = idRepar,apelNom
listwidthcols = 70,400
titulos_cabeceras = #,Apellido y Nombre (s)
Name = "cls_abm_repa"
Herramientas.cmdNuevo.Name = "cmdNuevo"
Herramientas.cmdEditar.Name = "cmdEditar"
Herramientas.cmdEliminar.Name = "cmdEliminar"
Herramientas.cmdCerrar.Name = "cmdCerrar"
Herramientas.cmdGrabar.Name = "cmdGrabar"
Herramientas.cmdCancelar.Name = "cmdCancelar"
Herramientas.cmdExcel.Name = "cmdExcel"
Herramientas.Name = "Herramientas"
Pgf.ErasePage = .T.
Pgf.Page1.grdDatos.COLUMN1.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN1.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN1.Name = "COLUMN1"
Pgf.Page1.grdDatos.COLUMN2.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN2.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN2.Name = "COLUMN2"
Pgf.Page1.grdDatos.COLUMN3.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN3.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN3.Name = "COLUMN3"
Pgf.Page1.grdDatos.COLUMN4.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN4.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN4.Name = "COLUMN4"
Pgf.Page1.grdDatos.COLUMN5.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN5.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN5.Name = "COLUMN5"
Pgf.Page1.grdDatos.COLUMN6.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN6.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN6.Name = "COLUMN6"
Pgf.Page1.grdDatos.COLUMN7.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN7.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN7.Name = "COLUMN7"
Pgf.Page1.grdDatos.COLUMN8.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN8.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN8.Name = "COLUMN8"
Pgf.Page1.grdDatos.COLUMN9.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN9.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN9.Name = "COLUMN9"
Pgf.Page1.grdDatos.COLUMN10.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN10.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN10.Name = "COLUMN10"
Pgf.Page1.grdDatos.COLUMN11.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN11.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN11.Name = "COLUMN11"
Pgf.Page1.grdDatos.COLUMN12.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN12.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN12.Name = "COLUMN12"
Pgf.Page1.grdDatos.COLUMN13.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN13.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN13.Name = "COLUMN13"
Pgf.Page1.grdDatos.COLUMN14.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN14.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN14.Name = "COLUMN14"
Pgf.Page1.grdDatos.COLUMN15.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN15.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN15.Name = "COLUMN15"
Pgf.Page1.grdDatos.COLUMN16.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN16.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN16.Name = "COLUMN16"
Pgf.Page1.grdDatos.COLUMN17.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN17.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN17.Name = "COLUMN17"
Pgf.Page1.grdDatos.COLUMN18.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN18.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN18.Name = "COLUMN18"
Pgf.Page1.grdDatos.COLUMN19.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN19.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN19.Name = "COLUMN19"
Pgf.Page1.grdDatos.COLUMN20.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN20.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN20.Name = "COLUMN20"
Pgf.Page1.grdDatos.Name = "grdDatos"
Pgf.Page1.Name = "Page1"
Pgf.Page2.cnt_fields.Name = "cnt_fields"
Pgf.Page2.Name = "Page2"
Pgf.Name = "Pgf"

*** METODOS ***


************************************************************
OBJETO: etiqapelNom
************************************************************
*** PROPIEDADES ***
Caption = "Apellido y Nombre (s):"
Height = 24
Left = 24
Top = 39
Width = 132
Name = "etiqapelNom"

*** METODOS ***


************************************************************
OBJETO: txtApelNom
************************************************************
*** PROPIEDADES ***
Height = 24
Left = 156
Top = 39
Width = 468
msgerror = Debe ingresar el Apellido y Nombre(s)
cfieldname = apelNom
ischaracter = .T.
Name = "txtApelNom"

*** METODOS ***


************************************************************
OBJETO: cls_abm_repa
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_abm_tiposrep
************************************************************
*** PROPIEDADES ***
DoCreate = .T.
Tag = ""
Caption = "Tipos de Reparación"
WindowState = 0
cnombretabla = tiposrep
listctrlsource = CodigoTR,Descripcio
listwidthcols = 90,350
titulos_cabeceras = Código,Descripción
pk_fieldname = idTipoRep
Name = "cls_abm_tiposrep"
HERRAMIENTAS.CMDNUEVO.Name = "CMDNUEVO"
HERRAMIENTAS.CMDEDITAR.Name = "CMDEDITAR"
HERRAMIENTAS.CMDELIMINAR.Name = "CMDELIMINAR"
HERRAMIENTAS.CMDCERRAR.Name = "CMDCERRAR"
HERRAMIENTAS.CMDGRABAR.Name = "CMDGRABAR"
HERRAMIENTAS.CMDCANCELAR.Name = "CMDCANCELAR"
HERRAMIENTAS.CMDEXCEL.Name = "CMDEXCEL"
HERRAMIENTAS.Name = "HERRAMIENTAS"
PGF.ErasePage = .T.
PGF.Page1.GRDDATOS.COLUMN1.HEADER1.Name = "HEADER1"
PGF.Page1.GRDDATOS.COLUMN1.TEXT1.Name = "TEXT1"
PGF.Page1.GRDDATOS.COLUMN1.Name = "COLUMN1"
PGF.Page1.GRDDATOS.COLUMN2.HEADER1.Name = "HEADER1"
PGF.Page1.GRDDATOS.COLUMN2.TEXT1.Name = "TEXT1"
PGF.Page1.GRDDATOS.COLUMN2.Name = "COLUMN2"
PGF.Page1.GRDDATOS.COLUMN3.HEADER1.Name = "HEADER1"
PGF.Page1.GRDDATOS.COLUMN3.TEXT1.Name = "TEXT1"
PGF.Page1.GRDDATOS.COLUMN3.Name = "COLUMN3"
PGF.Page1.GRDDATOS.COLUMN4.HEADER1.Name = "HEADER1"
PGF.Page1.GRDDATOS.COLUMN4.TEXT1.Name = "TEXT1"
PGF.Page1.GRDDATOS.COLUMN4.Name = "COLUMN4"
PGF.Page1.GRDDATOS.COLUMN5.HEADER1.Name = "HEADER1"
PGF.Page1.GRDDATOS.COLUMN5.TEXT1.Name = "TEXT1"
PGF.Page1.GRDDATOS.COLUMN5.Name = "COLUMN5"
PGF.Page1.GRDDATOS.COLUMN6.HEADER1.Name = "HEADER1"
PGF.Page1.GRDDATOS.COLUMN6.TEXT1.Name = "TEXT1"
PGF.Page1.GRDDATOS.COLUMN6.Name = "COLUMN6"
PGF.Page1.GRDDATOS.COLUMN7.HEADER1.Name = "HEADER1"
PGF.Page1.GRDDATOS.COLUMN7.TEXT1.Name = "TEXT1"
PGF.Page1.GRDDATOS.COLUMN7.Name = "COLUMN7"
PGF.Page1.GRDDATOS.COLUMN8.HEADER1.Name = "HEADER1"
PGF.Page1.GRDDATOS.COLUMN8.TEXT1.Name = "TEXT1"
PGF.Page1.GRDDATOS.COLUMN8.Name = "COLUMN8"
PGF.Page1.GRDDATOS.COLUMN9.HEADER1.Name = "HEADER1"
PGF.Page1.GRDDATOS.COLUMN9.TEXT1.Name = "TEXT1"
PGF.Page1.GRDDATOS.COLUMN9.Name = "COLUMN9"
PGF.Page1.GRDDATOS.COLUMN10.HEADER1.Name = "HEADER1"
PGF.Page1.GRDDATOS.COLUMN10.TEXT1.Name = "TEXT1"
PGF.Page1.GRDDATOS.COLUMN10.Name = "COLUMN10"
PGF.Page1.GRDDATOS.COLUMN11.HEADER1.Name = "HEADER1"
PGF.Page1.GRDDATOS.COLUMN11.TEXT1.Name = "TEXT1"
PGF.Page1.GRDDATOS.COLUMN11.Name = "COLUMN11"
PGF.Page1.GRDDATOS.COLUMN12.HEADER1.Name = "HEADER1"
PGF.Page1.GRDDATOS.COLUMN12.TEXT1.Name = "TEXT1"
PGF.Page1.GRDDATOS.COLUMN12.Name = "COLUMN12"
PGF.Page1.GRDDATOS.COLUMN13.HEADER1.Name = "HEADER1"
PGF.Page1.GRDDATOS.COLUMN13.TEXT1.Name = "TEXT1"
PGF.Page1.GRDDATOS.COLUMN13.Name = "COLUMN13"
PGF.Page1.GRDDATOS.COLUMN14.HEADER1.Name = "HEADER1"
PGF.Page1.GRDDATOS.COLUMN14.TEXT1.Name = "TEXT1"
PGF.Page1.GRDDATOS.COLUMN14.Name = "COLUMN14"
PGF.Page1.GRDDATOS.COLUMN15.HEADER1.Name = "HEADER1"
PGF.Page1.GRDDATOS.COLUMN15.TEXT1.Name = "TEXT1"
PGF.Page1.GRDDATOS.COLUMN15.Name = "COLUMN15"
PGF.Page1.GRDDATOS.COLUMN16.HEADER1.Name = "HEADER1"
PGF.Page1.GRDDATOS.COLUMN16.TEXT1.Name = "TEXT1"
PGF.Page1.GRDDATOS.COLUMN16.Name = "COLUMN16"
PGF.Page1.GRDDATOS.COLUMN17.HEADER1.Name = "HEADER1"
PGF.Page1.GRDDATOS.COLUMN17.TEXT1.Name = "TEXT1"
PGF.Page1.GRDDATOS.COLUMN17.Name = "COLUMN17"
PGF.Page1.GRDDATOS.COLUMN18.HEADER1.Name = "HEADER1"
PGF.Page1.GRDDATOS.COLUMN18.TEXT1.Name = "TEXT1"
PGF.Page1.GRDDATOS.COLUMN18.Name = "COLUMN18"
PGF.Page1.GRDDATOS.COLUMN19.HEADER1.Name = "HEADER1"
PGF.Page1.GRDDATOS.COLUMN19.TEXT1.Name = "TEXT1"
PGF.Page1.GRDDATOS.COLUMN19.Name = "COLUMN19"
PGF.Page1.GRDDATOS.COLUMN20.HEADER1.Name = "HEADER1"
PGF.Page1.GRDDATOS.COLUMN20.TEXT1.Name = "TEXT1"
PGF.Page1.GRDDATOS.COLUMN20.Name = "COLUMN20"
PGF.Page1.GRDDATOS.Name = "GRDDATOS"
PGF.Page1.Name = "Page1"
PGF.Page2.CNT_FIELDS.Top = 10
PGF.Page2.CNT_FIELDS.Left = 8
PGF.Page2.CNT_FIELDS.Width = 794
PGF.Page2.CNT_FIELDS.Height = 360
PGF.Page2.CNT_FIELDS.Name = "CNT_FIELDS"
PGF.Page2.Name = "Page2"
PGF.Name = "PGF"

*** METODOS ***
PROCEDURE recuperardatos
LOCAL loRes
LOCAL lcSql

DODEFAULT()

loRes = CREATEOBJECT("odbc_result")
lcSql = ""

lcSql = "SELECT componen.*, piezas.Descripcio "
lcSql = lcSql + "FROM componen "
lcSql = lcSql + " INNER JOIN piezas ON piezas.idPieza = componen.idPieza "
lcSql = lcSql + "WHERE componen.idTipoRep = " + ALLTRIM(STR(cur_tempo.idTipoRep))

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_comp"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
ELSE
	SELECT cur_P
	ZAP
	
	SELECT cur_comp
	GO TOP
	DO WHILE !EOF("cur_comp")
		SELECT cur_P
		APPEND BLANK
		REPLACE cur_P.idPieza WITH cur_comp.idPieza
		REPLACE cur_P.descripcio WITH cur_comp.descripcio ADDITIVE
		REPLACE cur_P.cantidad WITH cur_comp.cantidad ADDITIVE
	
		SELECT cur_comp
		SKIP
	ENDDO
	
	SELECT cur_P
	GO TOP
	Thisform.pgf.page2.cnt_fields.cnt_piezas.grdPiezas.Refresh()
ENDIF
ENDPROC
PROCEDURE Load
DODEFAULT()

&& Contiene nro. de pieza,descripción y cantidad 
&& de piezas asociadas a cada Tipo de Reparación

CREATE CURSOR cur_P ( ;
	idPieza int,;
	descripcio varchar (100),;
	cantidad int)
	
	

	
	
ENDPROC
PROCEDURE Init
DODEFAULT()

SELECT cur_P 
thisform.pgf.page2.cnt_fields.CNT_piezas.grdPiezas.alias_name = "cur_P"
thisform.pgf.page2.cnt_fields.CNT_piezas.grdPiezas.RecordSource="cur_P"
thisform.pgf.page2.cnt_fields.CNT_piezas.grdPiezas.list_controlsource ="descripcio,cantidad"
thisform.pgf.page2.cnt_fields.CNT_piezas.grdPiezas.lista_ancho_cols="300,70"
thisform.pgf.page2.cnt_fields.cNT_piezas.grdPiezas.titulos_cabeceras="Pieza,Cantidad"
thisform.pgf.page2.cnt_fields.CNT_piezas.grdPiezas.generar_grid()





ENDPROC
PROCEDURE HERRAMIENTAS.nuevo
DODEFAULT()
SELECT cur_p
ZAP
ENDPROC
PROCEDURE HERRAMIENTAS.grabar
PARAMETERS tl_AutoAssing

LOCAL loCmd
LOCAL lcSql

loCmd = CREATEOBJECT("odbc_command")
lcSql = ""

goConn.BeginTransaction()

&& Copio el codigo de la clase padre y la pego a continuación para evitar
&& el llamado al DODEFAULT.
LOCAL cRef

cRef = Thisform.pk_fieldname

IF tl_AutoAssing THEN
	Thisform.asignarcampos()
ENDIF

IF !Thisform.validardatos() THEN
	MESSAGEBOX(thisform.msgerror, 0+48, thisform.Caption)
	Thisform.datos_ok = .F.
	RETURN .F.
ENDIF

Thisform.datos_ok = .T.

IF thisform.lnuevo THEN
	IF !thisform.object_dataservice.Insert(.T.) THEN
		MESSAGEBOX(thisform.object_dataservice.error_message, 0+64, "Mensaje de Error")
		RETURN .F.
	ENDIF
ELSE
	&& Si modifica tengo que traer el id del registro seleccionado
	cRef = "Thisform.object_DataService." + cRef + " = " + "cur_Tempo." + cRef
	&cRef

	IF !thisform.object_dataservice.Update(.T.) THEN
		MESSAGEBOX(thisform.object_dataservice.error_message, 0+64, "Mensaje de Error")
		RETURN .F.
	ENDIF
ENDIF

&& Tengo qeu grabar los datos correspondiente a la
&& tabla componen.

lcSql = "DELETE FROM componen "
lcSql = lcSql + "WHERE idTipoRep = " + ALLTRIM(STR(Thisform.object_dataservice.idTipoRep))

loCmd.ActiveConnection = goConn.ActiveConnection
loCmd.CommandText = lcSql

IF !loCmd.Execute() THEN
	goConn.Rollback()
	MESSAGEBOX(loCmd.ErrorMessage, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_P
GO TOP

DO WHILE !EOF("cur_P")
	lcSql = "INSERT INTO componen ( "
	lcSql = lcSql + "idTipoRep, idPieza, cantidad, "
	lcsql = lcSql + "usuAlta, fecAlta, idHostAlta) "
	lcSql = lcSql + "VALUES ( "
	lcSql = lcSql + ALLTRIM(STR(Thisform.object_dataservice.idTipoRep)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_P.idPieza)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_P.cantidad)) + ", "
	lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
	lcSql = lcSql + "current_timestamp, "
	lcSql = lcSql + "'" + SYS(0) + "')"
	
	loCmd.ActiveConnection = goConn.ActiveConnection
	loCmd.CommandText = lcSql
	IF !loCmd.Execute() THEN
		MESSAGEBOX(loCmd.ErrorMessage, 0+48, Thisform.Caption)
		goConn.Rollback()
		RETURN .F.
	ENDIF

	SELECT cur_P
	SKIP
ENDDO

goConn.Commit()

&& Procedo a pegar el código que cierra el grabado de la clase padre.
Thisform.actualizar_cursor()
Thisform.CambiarEstado(.T.)
Thisform.pgf.Page1.enabled = .T.
Thisform.Pgf.Page1.SetFocus()
Thisform.Pgf.Page1.grdDatos.SetFocus()

RETURN .T.

ENDPROC


************************************************************
OBJETO: etiqDescrip_TipoRep
************************************************************
*** PROPIEDADES ***
Caption = "Descripción"
Height = 16
Left = 24
Top = 38
Width = 74
Name = "etiqDescrip_TipoRep"

*** METODOS ***


************************************************************
OBJETO: txtDescripcio
************************************************************
*** PROPIEDADES ***
Height = 22
Left = 102
ReadOnly = .F.
TabIndex = 2
Top = 34
Width = 462
cfieldname = Descripcio
ischaracter = .T.
msgerror = Debe ingresar la descripción
Name = "txtDescripcio"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Codigo:"
Height = 16
Left = 24
Top = 13
Width = 78
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: txtCodigo
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 102
TabIndex = 1
Top = 10
Width = 247
cfieldname = CodigoTR
ischaracter = .T.
msgerror = Debe ingresar el código
Name = "txtCodigo"

*** METODOS ***


************************************************************
OBJETO: chkInclurR
************************************************************
*** PROPIEDADES ***
Top = 12
Left = 385
Height = 18
Width = 180
Alignment = 0
Caption = "Incluir cambio de repuestos"
Value = 0
TabIndex = 3
cfieldname = incluirR
Name = "chkInclurR"

*** METODOS ***


************************************************************
OBJETO: CNT_piezas
************************************************************
*** PROPIEDADES ***
Tag = ""
Top = 72
Left = 13
Width = 769
Height = 276
ToolTipText = ""
Name = "CNT_piezas"

*** METODOS ***


************************************************************
OBJETO: grdPiezas
************************************************************
*** PROPIEDADES ***
Height = 195
Left = 12
TabIndex = 5
Top = 72
Width = 744
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdPiezas"
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
OBJETO: etiqpieza
************************************************************
*** PROPIEDADES ***
Caption = "Pieza"
Height = 17
Left = 24
Top = 20
Width = 36
Name = "etiqpieza"

*** METODOS ***


************************************************************
OBJETO: txtCant_Pieza
************************************************************
*** PROPIEDADES ***
Height = 22
Left = 83
TabIndex = 2
Top = 43
Width = 60
isinteger = .T.
Name = "txtCant_Pieza"

*** METODOS ***


************************************************************
OBJETO: etiqCantidad
************************************************************
*** PROPIEDADES ***
FontSize = 8
Caption = "Cantidad"
Height = 16
Left = 24
Top = 46
Width = 60
Name = "etiqCantidad"

*** METODOS ***


************************************************************
OBJETO: sel_piezas
************************************************************
*** PROPIEDADES ***
Top = 16
Left = 81
TabIndex = 1
nombre_tabla = piezas
nombre_campo_codigo = idPieza
nombre_campo_desc = Descripcio
pkfield = idPieza
esnumerico = .T.
autocompletar_ceros = .F.
Name = "sel_piezas"
TXTCODIGO.Name = "TXTCODIGO"
TXTDESCRIPCION.Name = "TXTDESCRIPCION"

*** METODOS ***


************************************************************
OBJETO: btnEliminar
************************************************************
*** PROPIEDADES ***
Top = 23
Left = 708
Height = 44
Width = 48
TabIndex = 4
Name = "btnEliminar"

*** METODOS ***
PROCEDURE Click
LOCAL lnResp

lnResp = MESSAGEBOX("¿Está seguro que desea quitar la pieza?", 4+32, Thisform.Caption)

IF lnResp = 6 THEN
	SELECT cur_P
	DELETE
	Thisform.pgf.page2.cnt_fields.CNT_piezas.grdPiezas.Refresh()
ENDIF

Thisform.pgf.page2.cnt_fields.CNT_piezas.sel_piezas.txtCodigo.SetFocus()
ENDPROC


************************************************************
OBJETO: btnAgregar
************************************************************
*** PROPIEDADES ***
Top = 23
Left = 660
TabIndex = 3
Name = "btnAgregar"

*** METODOS ***
PROCEDURE Click
IF thisform.pgf.page2.cnt_fields.CNT_piezas.sel_piezas.valcpoid = 0 THEN
	MESSAGEBOX("Debe ingresar la pieza", 0+48, Thisform.Caption)
	Thisform.pgf.page2.cnt_fields.CNT_piezas.sel_piezas.txtCodigo.SetFocus()
	RETURN
ENDIF

IF Thisform.pgf.page2.cnt_fields.CNT_piezas.txtCant_Pieza.Value = 0 THEN
	MESSAGEBOX("Debe ingresar la cantidad", 0+48, Thisform.Caption)
	Thisform.Pgf.page2.cnt_fields.CNT_piezas.txtCant_Pieza.SetFocus()
	RETURN	
ENDIF

SELECT cur_P
APPEND BLANK
REPLACE cur_P.idPieza WITH Thisform.pgf.page2.cnT_FIELDS.CNT_piezas.sel_piezas.txtCodigo.Value
REPLACE cur_P.descripcio WITH thisform.pgf.page2.cnt_FIELDS.CNT_piezas.sel_piezas.txtDescripcion.Value additive
REPLACE cur_P.cantidad WITH thisform.pgf.page2.cnT_FIELDS.CNT_piezas.txtCant_Pieza.Value additive
				
thisform.pgf.page2.cnt_FIELDS.CNT_piezas.sel_piezas.blanquear()
thisform.pgf.page2.cnt_FIELDS.CNT_piezas.txtCant_Pieza.blanquear()
thisform.pgf.page2.cnT_FIELDS.CNT_piezas.sel_piezas.txtCODIGO.SetFocus()

Thisform.pgf.page2.cnt_fields.CNT_piezas.grdPiezas.Refresh()

ENDPROC


************************************************************
OBJETO: cls_abm_tiposrep
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_dlg_altamarcav
************************************************************
*** PROPIEDADES ***
Height = 110
Width = 490
DoCreate = .T.
BorderStyle = 2
Caption = "Alta marca de vehículo"
Closable = .F.
accept_press = .F.
idmarcav = 0
descripcion = 
Name = "cls_dlg_altamarcav"

*** METODOS ***
PROCEDURE validar_datos
IF ALLTRIM(Thisform.txtDescripcio.Value) == "" THEN
	MESSAGEBOX("La descripción es obligatoria", 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

RETURN .T.
ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Descripción:"
Height = 15
Left = 10
Top = 24
Width = 84
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: txtDescripcio
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 92
Top = 21
Width = 387
Name = "txtDescripcio"

*** METODOS ***


************************************************************
OBJETO: btnGrabar
************************************************************
*** PROPIEDADES ***
Top = 60
Left = 389
Name = "btnGrabar"

*** METODOS ***
PROCEDURE Click
LOCAL loCommand
LOCAL loDT
LOCAL lcSql
LOCAL lnProxID
LOCAL lcDescripcio

loCommand = CREATEOBJECT("odbc_command")
loDT = CREATEOBJECT("datetime")
lcSql = ""
lnProxID = 0
lcDescripcio = ""

IF Thisform.validar_datos() THEN
	goConn.BeginTransaction()
	
	lnProxID = goConn.GetNextID("marcas_v", "idMarcaV")
	lcDescripcio = ALLTRIM(Thisform.txtDescripcio.Value)
	
	lcSql = "INSERT INTO marcas_v ( "
	lcSql = lcSql + "idMarcaV, "
	lcSql = lcSql + "descripcio, "
	lcSql = lcSql + "usuAlta, "
	lcSql = lcSql + "fecAlta, "
	lcSql = lcSql + "idHostAlta) "
	lcSql = lcSql + "VALUES ( "
	lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", "
	lcSql = lcSql + "'" + ALLTRIM(lcDescripcio) + "', "
	lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
	lcSql = lcSql + loDT.ToMySql(DATETIME()) + ", "
	lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "')"
	
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	IF !loCommand.Execute() THEN
		goConn.Rollback()
		MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
	ELSE
		goConn.Commit()
		MESSAGEBOX("La marca se dió de alta satisfactoriamente", 0+64,;
			Thisform.Caption)
		Thisform.idmarcav = lnProxID
		Thisform.descripcion = lcDescripcio
		Thisform.accept_press = .T.
		Thisform.Hide()
	ENDIF
ENDIF
ENDPROC


************************************************************
OBJETO: Clscerrar1
************************************************************
*** PROPIEDADES ***
Top = 60
Left = 435
Name = "Clscerrar1"

*** METODOS ***
PROCEDURE Click
Thisform.accept_press = .F.
Thisform.Hide()
ENDPROC


************************************************************
OBJETO: cls_dlg_altamarcav
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_dlg_altapieza
************************************************************
*** PROPIEDADES ***
Height = 110
Width = 490
DoCreate = .T.
BorderStyle = 2
Caption = "Alta de pieza"
Closable = .F.
accept_press = .F.
idpieza = 0
descripcio = 
Name = "cls_dlg_altapieza"

*** METODOS ***
PROCEDURE validar_datos
IF ALLTRIM(Thisform.txtDescripcio.Value) == "" THEN
	MESSAGEBOX("La descripción es obligatoria", 0+48, Thisform.Caption)
	Thisform.txtDescripcio.SetFocus()
	RETURN .F.
ENDIF

RETURN .T.
ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Descripción:"
Height = 15
Left = 14
Top = 24
Width = 84
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: txtDescripcio
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 96
Top = 21
Width = 387
Name = "txtDescripcio"

*** METODOS ***


************************************************************
OBJETO: btnGrabar
************************************************************
*** PROPIEDADES ***
Top = 61
Left = 392
Name = "btnGrabar"

*** METODOS ***
PROCEDURE Click
LOCAL loCommand
LOCAL loDT
LOCAL lcSql
LOCAL lnProxID
LOCAL lcDescripcio

loCommand = CREATEOBJECT("odbc_command")
loDT = CREATEOBJECT("datetime")
lcSql = ""
lnProxID = 0
lcDescripcio = ""

IF Thisform.validar_datos() THEN
	goConn.BeginTransaction()
	
	lnProxID = goConn.GetNextID("piezas", "idPieza")
	lcDescripcio = ALLTRIM(Thisform.txtDescripcio.Value)
	
	lcSql = "INSERT INTO piezas ( "
	lcSql = lcSql + "idPieza, "
	lcSql = lcSql + "descripcio, "
	lcSql = lcSql + "usuAlta, "
	lcSql = lcSql + "fecAlta, "
	lcSql = lcSql + "idHostAlta) "
	lcSql = lcSql + "VALUES ( "
	lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", "
	lcSql = lcSql + "'" + ALLTRIM(lcDescripcio) + "', "
	lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
	lcSql = lcSql + loDT.ToMySql(DATETIME()) + ", "
	lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "')"
	
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	IF !loCommand.Execute() THEN
		goConn.Rollback()
		MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
	ELSE
		goConn.Commit()
		MESSAGEBOX("La pieza se dió de alta satisfactoriamente", 0+64,;
			Thisform.Caption)
		Thisform.idpieza= lnProxID
		Thisform.descripcio = lcDescripcio
		Thisform.accept_press = .T.
		Thisform.Hide()
	ENDIF
ENDIF
ENDPROC


************************************************************
OBJETO: Clscerrar1
************************************************************
*** PROPIEDADES ***
Top = 61
Left = 438
Name = "Clscerrar1"

*** METODOS ***
PROCEDURE Click
Thisform.accept_press = .F.
Thisform.Hide()
ENDPROC


************************************************************
OBJETO: cls_dlg_altapieza
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_dlg_altatiposrep
************************************************************
*** PROPIEDADES ***
Height = 125
Width = 490
DoCreate = .T.
BorderStyle = 2
Caption = "Alta de tipos de reparaciones"
Closable = .F.
accept_press = .F.
idtiporep = 0
codigotr = 
descripcio = 
Name = "cls_dlg_altatiposrep"

*** METODOS ***
PROCEDURE validar_datos
IF ALLTRIM(Thisform.txtCodigoTR.Value) == "" THEN
	MESSAGEBOX("El código del tipo de reparación es obligatorio", 0+48, Thisform.Caption)
	Thisform.txtCodigoTR.SetFocus()
	RETURN .F.
ENDIF

IF ALLTRIM(Thisform.txtDescripcion.Value) == "" THEN
	MESSAGEBOX("La descripción es obligatoria", 0+48, Thisform.Caption)
	Thisform.txtDescripcion.SetFocus()
	RETURN .F.
ENDIF

RETURN .T.
ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Código:"
Height = 15
Left = 12
Top = 12
Width = 60
TabIndex = 6
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Descripción:"
Height = 15
Left = 11
Top = 37
Width = 74
TabIndex = 7
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: txtCodigoTR
************************************************************
*** PROPIEDADES ***
Left = 94
TabIndex = 1
Top = 9
Name = "txtCodigoTR"

*** METODOS ***


************************************************************
OBJETO: txtDescripcion
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 94
TabIndex = 2
Top = 33
Width = 387
Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: btnGrabar
************************************************************
*** PROPIEDADES ***
Top = 77
Left = 389
TabIndex = 4
Name = "btnGrabar"

*** METODOS ***
PROCEDURE Click
LOCAL loCommand
LOCAL loRes
LOCAL loDT
LOCAL lcSql
LOCAL lnIdTipoRep
LOCAL lcCodigoTR
LOCAL lcDescripcio
LOCAL lnIncluirR

loCommand = CREATEOBJECT("odbc_command")
loRes = CREATEOBJECT("odbc_result")
loDT = CREATEOBJECT("datetime")
lcSql = ""
lnIdTipoRep = 0
lcCodigoTR = ""
lcDescripcio = ""
lnIncluirR = 0

IF Thisform.validar_datos() THEN
	lcCodigoTR = Thisform.txtCodigoTR.Value
	lcDescripcio = Thisform.txtDescripcion.Value
	lnIncluirR = Thisform.chkIncluirR.Value

	lcSql = "SELECT * FROM tiposrep "
	lcSql = lcSql + "WHERE codigoTR = '" + ALLTRIM(lcCodigoTR) + "'"
	loRes.ActiveConnection = goConn.ActiveConnection
	loRes.Cursor_Name = "cur_temp"
	IF !loRes.OpenQuery(lcSql) THEN
		MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	ELSE
		SELECT cur_temp
		IF RECCOUNT("cur_temp") > 0 THEN
			MESSAGEBOX("El código de tipo de reparación ya existe", 0+48, Thisform.Caption)
			loRes.Close_Query()
		ELSE
			loRes.Close_Query()
			
			goConn.BeginTransaction()
			lnProxID = goConn.GetNextID("tiposrep", "idTipoRep")
			
			lcSql = "INSERT INTO tiposrep ( "
			lcSql = lcSql + "idTipoRep, "
			lcSql = lcSql + "codigoTR, "
			lcSql = lcSql + "descripcio, "
			lcSql = lcSql + "incluirR, "
			lcSql = lcSql + "usuAlta, "
			lcSql = lcSql + "fecAlta, "
			lcSql = lcSql + "idHostAlta) "
			lcSql = lcSql + "VALUES ( "
			lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", "
			lcSql = lcSql + "'" + ALLTRIM(lcCodigoTR) + "', "
			lcSql = lcSql + "'" + ALLTRIM(lcDescripcio) + "', "
			lcSql = lcSql + ALLTRIM(STR(lnIncluirR)) + ", "
			lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
			lcSql = lcSql + loDT.ToMySql(DATETIME()) + ", "
			lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "')"
			
			loCommand.ActiveConnection = goConn.ActiveConnection
			loCommand.CommandText = lcSql
			IF !loCommand.Execute() THEN
				goConn.Rollback()
				MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
			ELSE
				goConn.Commit()
				MESSAGEBOX("El tipo de reparacion se grabó satisfactoriamente", ;
					0+64, Thisform.Caption)
					
				Thisform.accept_press = .t.
				Thisform.idtiporep = lnProxID
				Thisform.codigotr = lcCodigoTR
				Thisform.descripcio = lcDescripcio
				Thisform.Hide()
			ENDIF
			
		ENDIF
	ENDIF
ENDIF
ENDPROC


************************************************************
OBJETO: chkIncluirR
************************************************************
*** PROPIEDADES ***
Top = 60
Left = 94
Alignment = 0
Caption = "Incluir cambio de repuestos"
TabIndex = 3
Name = "chkIncluirR"

*** METODOS ***


************************************************************
OBJETO: Clscerrar1
************************************************************
*** PROPIEDADES ***
Top = 77
Left = 435
Name = "Clscerrar1"

*** METODOS ***
PROCEDURE Click
Thisform.accept_press = .F.
Thisform.Hide()
ENDPROC


************************************************************
OBJETO: cls_dlg_altatiposrep
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_report_selector
************************************************************
*** PROPIEDADES ***
Height = 131
Width = 339
DoCreate = .T.
BorderStyle = 2
Caption = "Seleccionar reporte"
Closable = .F.
tipo_report = 
press_aceptar = .F.
Name = "cls_report_selector"

*** METODOS ***


************************************************************
OBJETO: grp
************************************************************
*** PROPIEDADES ***
Height = 42
Left = 48
Top = 36
Width = 276
Name = "grp"
OPTION1.FontSize = 8
OPTION1.Caption = "Presupuesto"
OPTION1.Height = 15
OPTION1.Left = 5
OPTION1.Top = 5
OPTION1.Width = 139
OPTION1.ForeColor = 158,106,75
OPTION1.Name = "OPTION1"
OPTION2.FontSize = 8
OPTION2.Caption = "Ficha de reparación"
OPTION2.Height = 15
OPTION2.Left = 5
OPTION2.Top = 22
OPTION2.Width = 139
OPTION2.ForeColor = 158,106,75
OPTION2.Name = "OPTION2"

*** METODOS ***


************************************************************
OBJETO: CLSETIQUETA1
************************************************************
*** PROPIEDADES ***
Caption = "Qué desea imprimir?"
Height = 15
Left = 12
Top = 12
Width = 240
Name = "CLSETIQUETA1"

*** METODOS ***


************************************************************
OBJETO: btnAceptar
************************************************************
*** PROPIEDADES ***
Top = 84
Left = 234
Name = "btnAceptar"

*** METODOS ***
PROCEDURE Click
Thisform.press_aceptar = .T.
IF Thisform.grp.Option1.Value = 1 THEN
	Thisform.tipo_report = "P"
ELSE
	Thisform.tipo_report = "F"
ENDIF

Thisform.Hide()
ENDPROC


************************************************************
OBJETO: Clscerrar1
************************************************************
*** PROPIEDADES ***
Top = 84
Left = 280
Name = "Clscerrar1"

*** METODOS ***
PROCEDURE Click
Thisform.press_aceptar = .F.
Thisform.Hide()
ENDPROC


************************************************************
OBJETO: cls_report_selector
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_adm_repar
************************************************************
*** PROPIEDADES ***
Height = 523
Width = 946
DoCreate = .T.
BorderStyle = 2
Caption = "Administración de reparaciones"
Name = "cls_adm_repar"
contenido.Name = "contenido"

*** METODOS ***
PROCEDURE Init
Thisform.Contenido.sel_CliRep.txtCodigo.Enabled = .F.

SELECT cur_repa
Thisform.Contenido.grdRep.alias_name = "cur_repa"
Thisform.Contenido.grdRep.RecordSource = "cur_repa"
Thisform.Contenido.grdRep.List_ControlSource = "nroRep,fecEnt,fecSal,nroFiscal,razSoc,codigoTR,descripcio"
Thisform.Contenido.grdRep.Lista_Ancho_Cols = "70,100,100,100,200,100,200"
Thisform.Contenido.grdRep.Titulos_Cabeceras = "Número,Entrada,Salida,Documento,Denominación,Cód. TR.,Descripción"
Thisform.Contenido.grdRep.Generar_grid()
ENDPROC
PROCEDURE Load
DODEFAULT()

CREATE CURSOR cur_repa ( ;
	idCabRep int,;
	nroRep int,;
	fecEnt D,;
	fecSal D,;
	nroFiscal varchar(20),;
	razSoc varchar(60),;
	codigoTR varchar(20),;
	descripcio varchar(100))
ENDPROC


************************************************************
OBJETO: opgEstados
************************************************************
*** PROPIEDADES ***
ButtonCount = 4
BackStyle = 0
Height = 91
Left = 15
Top = 14
Width = 168
TabIndex = 1
Name = "opgEstados"
Option1.FontBold = .T.
Option1.FontSize = 8
Option1.Caption = "Pendientes"
Option1.Height = 15
Option1.Left = 20
Option1.Top = 12
Option1.Width = 115
Option1.ForeColor = 158,106,75
Option1.Name = "Option1"
Option2.FontBold = .T.
Option2.FontSize = 8
Option2.Caption = "Presupuestados"
Option2.Height = 15
Option2.Left = 20
Option2.Top = 31
Option2.Width = 115
Option2.ForeColor = 158,106,75
Option2.Name = "Option2"
Option3.FontBold = .T.
Option3.FontSize = 8
Option3.Caption = "Abiertos"
Option3.Height = 17
Option3.Left = 20
Option3.Top = 49
Option3.Width = 67
Option3.ForeColor = 158,106,75
Option3.Name = "Option3"
Option4.FontBold = .T.
Option4.FontSize = 8
Option4.Caption = "Cerrados"
Option4.Height = 17
Option4.Left = 20
Option4.Top = 67
Option4.Width = 79
Option4.ForeColor = 158,106,75
Option4.Name = "Option4"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
BackStyle = 1
Caption = "Estados:"
Height = 15
Left = 25
Top = 6
Width = 50
TabIndex = 2
BackColor = 241,236,235
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: chkCliente
************************************************************
*** PROPIEDADES ***
Top = 12
Left = 199
Height = 18
Width = 126
Alignment = 0
Caption = "Buscar por cliente:"
TabIndex = 14
Name = "chkCliente"

*** METODOS ***
PROCEDURE Click
IF this.Value = 1 THEN
	This.Parent.sel_clirep.txtCodigo.Enabled = .T.
ELSE
	This.Parent.sel_clirep.txtCodigo.Enabled = .F.
ENDIF
ENDPROC


************************************************************
OBJETO: sel_clirep
************************************************************
*** PROPIEDADES ***
Top = 9
Left = 325
TabIndex = 3
nombre_campo_codigo = nroFiscal
autocompletar_ceros = .F.
nombre_campo_desc = razSoc
nombre_tabla = clirep
pkfield = idCliRep
title_cols = Descripción
Name = "sel_clirep"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Fecha desde:"
Left = 200
Top = 49
TabIndex = 15
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Fecha hasta:"
Left = 200
Top = 73
TabIndex = 16
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: txtFechaDD
************************************************************
*** PROPIEDADES ***
Left = 284
TabIndex = 4
Top = 45
isdatetime = .T.
Name = "txtFechaDD"

*** METODOS ***


************************************************************
OBJETO: txtFechaHH
************************************************************
*** PROPIEDADES ***
Left = 284
TabIndex = 5
Top = 69
isdatetime = .T.
Name = "txtFechaHH"

*** METODOS ***


************************************************************
OBJETO: btnBuscar
************************************************************
*** PROPIEDADES ***
Top = 60
Left = 846
TabIndex = 8
Name = "btnBuscar"

*** METODOS ***
PROCEDURE Click
LOCAL loRes
LOCAL loDT
LOCAL lcSql
LOCAL lnIdCliRep
LOCAL ldFechaDD
LOCAL ldFechaHH

loRes = CREATEOBJECT("odbc_result")
loDT = CREATEOBJECT("datetime")
lcSql = ""
lnIdCliRep = 0
ldFechaDD = {}
ldFechaHH = {}

SELECT cur_repa
ZAP

lcSql = "SELECT "
lcSql = lcSql + "cabrep.idCabRep, "
lcSql = lcSql + "cabrep.nroRep, "
lcSql = lcSql + "cabrep.fecEnt, "
lcSql = lcSql + "cabrep.fecSal, "
lcSql = lcSql + "clirep.nroFiscal, "
lcSql = lcSql + "clirep.razSoc, "
lcSql = lcSql + "tiposrep.codigoTR, "
lcSql = lcSql + "tiposrep.descripcio "
lcSql = lcSql + "FROM cabrep "
lcSql = lcSql + " INNER JOIN clirep ON clirep.idCliRep = cabrep.idCliRep "
lcSql = lcSql + " INNER JOIN tiposrep ON tiposrep.idTipoRep = cabrep.idTipoRep "
lcSql = lcSql + "WHERE cabrep.fecBaja IS NULL "

IF This.Parent.chkCliente.Value = 1 THEN
	lnIdCliRep = This.Parent.sel_clirep.valcpoid
	lcSql = lcSql + " AND clirep.idCliRep = " + ALLTRIM(STR(lnIdCliRep)) + " "
ENDIF

IF This.Parent.txtFechaDD.Value <> {} .AND. ;
		This.Parent.txtFechaHH.Value <> {} THEN
	ldFechaDD = This.Parent.txtFechaDD.Value
	ldFechaHH = This.Parent.txtFechaHH.Value
	lcSql = lcSql + " AND cabrep.fecEnt BETWEEN " + loDT.ToMySql(ldFechaDD) + " AND "
	lcSql = lcSql + loDT.ToMySql(ldFechaHH)+ " "
ENDIF

IF This.Parent.txtNroDesde.Value <> 0 .AND. ;
		This.Parent.txtNroHasta.Value <> 0 THEN
	lcSql = lcSql + " AND cabrep.nroRep BETWEEN " + ALLTRIM(STR(thisform.contenido.txtNroDesde.Value)) + " AND "
	lcSql = lcSql + ALLTRIM(STR(thisform.contenido.txtNroHasta.Value))
ENDIF

DO CASE
	CASE This.Parent.opgEstados.Option1.Value = 1
		lcSql = lcSql + " AND cabrep.estado = 'P' "
	CASE This.Parent.opgEstados.Option2.Value = 1
		lcSql = lcSql + " AND cabrep.estado = 'R' "
	CASE This.Parent.opgEstados.Option3.Value = 1
		lcSql = lcSql + " AND cabrep.estado = 'A' "
	CASE This.Parent.opgEstados.Option4.Value = 1
		lcSql = lcSql + " AND cabrep.estado = 'C' "
ENDCASE

lcSql = lcSql + "ORDER BY cabrep.nroRep "

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_temp"
IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN
ENDIF

SELECT cur_temp
GO TOP
DO WHILE !EOF("cur_temp")
	SELECT cur_repa
	APPEND BLANK
	REPLACE cur_repa.idCabRep WITH cur_temp.idCabRep
	REPLACE cur_repa.nroRep WITH cur_temp.nroRep ADDITIVE
	REPLACE cur_repa.fecEnt WITH cur_temp.fecEnt ADDITIVE
	REPLACE cur_repa.fecSal WITH cur_temp.fecSal ADDITIVE
	REPLACE cur_repa.nroFiscal WITH cur_temp.nroFiscal ADDITIVE
	REPLACE cur_repa.razSoc WITH cur_temp.razSoc ADDITIVE
	REPLACE cur_repa.codigoTR WITH cur_temp.codigoTR ADDITIVE
	REPLACE cur_repa.descripcio WITH cur_temp.descripcio ADDITIVE

	SELECT cur_temp
	SKIP
ENDDO

loRes.Close_Query()

SELECT cur_repa
GO TOP
Thisform.Contenido.grdRep.Refresh()
ENDPROC


************************************************************
OBJETO: btnCancelar
************************************************************
*** PROPIEDADES ***
Top = 60
Left = 894
TabIndex = 9
Name = "btnCancelar"

*** METODOS ***


************************************************************
OBJETO: grdRep
************************************************************
*** PROPIEDADES ***
Height = 360
Left = 14
TabIndex = 10
Top = 107
Width = 924
Name = "grdRep"
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
OBJETO: btnNuevo
************************************************************
*** PROPIEDADES ***
Top = 471
Left = 13
TabIndex = 11
Name = "btnNuevo"

*** METODOS ***
PROCEDURE Click
LOCAL loForm

loForm = CREATEOBJECT("cls_ing_repar")
loForm.idCabRep = 0
loForm.esNuevo = .T.
loForm.WindowType = 1
loForm.Show()
ENDPROC


************************************************************
OBJETO: btnEditar
************************************************************
*** PROPIEDADES ***
Top = 471
Left = 60
TabIndex = 12
Name = "btnEditar"

*** METODOS ***
PROCEDURE Click
LOCAL loForm

loForm = CREATEOBJECT("cls_ing_repar")

SELECT cur_repa
loForm.idCabRep = cur_repa.idCabRep
loForm.NroRep = cur_repa.NroRep
loForm.esNuevo = .F.
loForm.leer_reparacion()
loForm.WindowType = 1
loForm.Show()
ENDPROC


************************************************************
OBJETO: btnSalir
************************************************************
*** PROPIEDADES ***
Top = 471
Left = 894
TabIndex = 13
Name = "btnSalir"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Número desde:"
Height = 15
Left = 389
Top = 49
Width = 92
TabIndex = 17
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Número hasta:"
Height = 15
Left = 389
Top = 73
Width = 88
TabIndex = 18
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: txtNroDesde
************************************************************
*** PROPIEDADES ***
Left = 485
TabIndex = 6
Top = 45
isdatetime = .F.
isinteger = .T.
Name = "txtNroDesde"

*** METODOS ***


************************************************************
OBJETO: txtNroHasta
************************************************************
*** PROPIEDADES ***
Left = 485
TabIndex = 7
Top = 69
isdatetime = .F.
isinteger = .T.
Name = "txtNroHasta"

*** METODOS ***


************************************************************
OBJETO: cls_adm_repar
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_ing_repar
************************************************************
*** PROPIEDADES ***
BorderStyle = 2
Height = 560
Width = 947
DoCreate = .T.
Caption = "Ingreso de Reparaciones"
editapieza = .F.
idcabrep = 0
nrorep = 0
esnuevo = .T.
Name = "cls_ing_repar"
contenido.Top = 0
contenido.Left = -1
contenido.Width = 948
contenido.Height = 560
contenido.TabIndex = 1
contenido.Name = "contenido"

*** METODOS ***
PROCEDURE recuperar_piezas
PARAMETERS tnIdTipoRep

LOCAL loRsPieza
LOCAL lcSql

loRsPieza = CREATEOBJECT("odbc_result")
lcSql = ""

SELECT cur_P
ZAP

lcSql = "SELECT piezas.*, componen.cantidad "
lcSql = lcSql + "FROM piezas "
lcSql = lcSql + "	INNER JOIN componen ON "
lcSql = lcSql + "		componen.idPieza = piezas.idPieza "
lcSql = lcSql + "WHERE componen.idTipoRep = " + ALLTRIM(STR(tnIdTipoRep))

loRsPieza.ActiveConnection = goConn.ActiveConnection
loRsPieza.Cursor_Name = "cur_temp"
IF !loRsPieza.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRsPieza.Error_Message, 0+48, Thisform.Caption)
ELSE
	SELECT cur_temp
	GO TOP
	DO WHILE !EOF("cur_temp")
		SELECT cur_P
		APPEND BLANK
		REPLACE cur_P.sel WITH .F.
		REPLACE cur_P.idPieza WITH cur_temp.idPieza ADDITIVE
		REPLACE cur_P.descripcio WITH cur_temp.descripcio ADDITIVE
		REPLACE cur_P.cantidad WITH cur_temp.cantidad ADDITIVE
		REPLACE cur_P.observ WITH "" ADDITIVE
		REPLACE cur_P.esNuevo WITH .F. ADDITIVE
	
		SELECT cur_temp
		SKIP
	ENDDO
	
	loRsPieza.Close_Query()
	SELECT cur_P
	GO TOP
	Thisform.contenido.cntPiezas.grdPiezas.Refresh()
ENDIF
ENDPROC
PROCEDURE limpiar
SELECT cur_p
ZAP

Thisform.Contenido.sel_Cliente.blanquear()
Thisform.Contenido.sel_Reparador.blanquear()
Thisform.Contenido.sel_TipoRep.blanquear()
Thisform.Contenido.sel_Vehiculo.blanquear()
Thisform.contenido.cmbEstado.blanquear()
Thisform.Contenido.txtNroRep.Value = ""
Thisform.Contenido.txtFecEnt.Value = DATE()
Thisform.Contenido.txtFecSal.Value = {}
Thisform.Contenido.txtModelo.Value = ""
Thisform.Contenido.txtPatente.Value = ""
Thisform.contenido.txtVoltaje.Value = 0
Thisform.contenido.txtMarca.Value = ""
Thisform.Contenido.txtObserv.Value = ""

Thisform.contenido.cntPiezas.sel_piezas.blanquear()
Thisform.contenido.cntPiezas.sel_Articulo.blanquear()
Thisform.contenido.cntPiezas.txtObserv.Value = ""

Thisform.contenido.txttotRptos.Value = 0.00
Thisform.contenido.txtCMO.Value = 0.00
Thisform.contenido.txttotalFinal.Value = 0.00


Thisform.Contenido.sel_Cliente.txtCodigo.SetFocus()
ENDPROC
PROCEDURE calc_totrptos
LOCAL lnCurrentPos
LOCAL lnTotal

lnCurrentPos = RECNO("cur_p")
lnTotal = 0.00

SELECT cur_p
GO TOP
DO WHILE !EOF("cur_p")
	IF cur_p.sel THEN
		lnTotal = lnTotal + cur_p.subTot
	ENDIF
	
	SELECT cur_p
	SKIP
ENDDO

SELECT cur_p
GO lnCurrentPos

RETURN lnTotal
ENDPROC
PROCEDURE leer_reparacion
LOCAL loRes
LOCAL lcSql
LOCAL lnTotal

loRes = CREATEOBJECT("odbc_result")
lcSql = ""

lcSql = "SELECT cabrep.*, clirep.nroFiscal, clirep.razSoc, repdores.apelNom, "
lcSql = lcSql + "marcas_v.descripcio AS descMV, "
lcSql = lcSql + "tiposrep.codigoTR, tiposrep.descripcio AS descTR "
lcSql = lcSql + "FROM cabrep "
lcSql = lcSql + "	INNER JOIN clirep ON clirep.idCliRep = cabrep.idCliRep "
lcSql = lcSql + "	INNER JOIN repdores ON repdores.idRepar = cabrep.idRepar "
lcSql = lcSql + "	INNER JOIN marcas_v ON marcas_v.idMarcaV = cabrep.idMarcaV "
lcSql = lcSql + "	INNER JOIN tiposrep ON tiposrep.idTipoRep = cabrep.idTipoRep "
lcSql = lcSql + "WHERE cabrep.idCabRep = " + ALLTRIM(STR(Thisform.idcabrep))

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_x
GO TOP
Thisform.Contenido.txtNroRep.Value = cur_x.nroRep
Thisform.Contenido.sel_Cliente.valcpoid = cur_x.idCliRep
Thisform.Contenido.sel_Cliente.txtCodigo.Value = cur_x.nroFiscal
Thisform.Contenido.sel_Cliente.txtDescripcion.Value = ALLTRIM(cur_x.razSoc)
Thisform.Contenido.txtFecEnt.Value = TTOD(cur_x.fecEnt)
Thisform.Contenido.txtFecSal.Value = TTOD(cur_x.fecSal)
Thisform.Contenido.sel_Reparador.valcpoid = cur_x.idRepar
Thisform.Contenido.sel_Reparador.txtCodigo.Value = cur_x.idRepar
Thisform.Contenido.sel_Reparador.txtDescripcion.Value = ALLTRIM(cur_x.apelNom)
Thisform.Contenido.sel_Vehiculo.valcpoid = cur_x.idMarcaV
Thisform.Contenido.sel_Vehiculo.txtCodigo.Value = cur_x.idMarcaV
Thisform.Contenido.sel_Vehiculo.txtDescripcion.Value = ALLTRIM(cur_x.descMV)
Thisform.Contenido.sel_TipoRep.valcpoid = cur_x.idTipoRep
Thisform.Contenido.sel_TipoRep.txtCodigo.Value = ALLTRIM(cur_x.codigoTR)
Thisform.Contenido.sel_TipoRep.txtDescripcion.Value = ALLTRIM(cur_x.descTR)
Thisform.Contenido.txtModelo.Value = ALLTRIM(cur_x.modelo)
Thisform.Contenido.txtPatente.Value = ALLTRIM(cur_x.patente)
Thisform.Contenido.txtObserv.Value = ALLTRIM(cur_x.observ)
Thisform.Contenido.txtTotalFinal.value = cur_x.precio
Thisform.Contenido.txtCMO.Value = cur_x.prManOb
Thisform.Contenido.txtMarca.Value = cur_x.marca
Thisform.Contenido.txtVoltaje.Value = cur_x.voltaje
Thisform.recuperar_piezas(cur_x.idTipoRep)

&& Defino los estados a mostrar
Thisform.Contenido.CmbEstado.Clear()
IF cur_x.estado == "P" THEN
	Thisform.Contenido.cmbEstado.AddItem("Pendiente")
	Thisform.Contenido.cmbEstado.AddItem("Presupuestado")
	Thisform.Contenido.cmbEstado.AddItem("Abierto")
	Thisform.Contenido.cmbEstado.AddItem("Cerrado")
	Thisform.Contenido.cmbEstado.ListIndex = 1
ELSE
	IF cur_x.estado == "R" THEN
		Thisform.Contenido.cmbEstado.AddItem("Presupuestado")
		Thisform.Contenido.cmbEstado.AddItem("Abierto")
		Thisform.Contenido.cmbEstado.AddItem("Cerrado")
		Thisform.Contenido.cmbEstado.ListIndex = 1
	ELSE
		IF cur_x.estado == "A" THEN
			Thisform.Contenido.cmbEstado.AddItem("Abierto")
			Thisform.Contenido.cmbEstado.AddItem("Cerrado")
			Thisform.Contenido.cmbEstado.ListIndex = 1
		ELSE
			Thisform.Contenido.cmbEstado.AddItem("Cerrado")
			Thisform.Contenido.cmbEstado.ListIndex = 1
			Thisform.Contenido.cmbestado.Enabled = .F.
			Thisform.Contenido.txtObserv.Enabled = .F.
			Thisform.Contenido.txtCMO.Enabled = .F.
			Thisform.Contenido.cntPiezas.sel_Articulo.txtCodigo.Enabled = .F.
			Thisform.Contenido.cntPiezas.sel_piezas.txtCodigo.Enabled = .F.
			Thisform.Contenido.cntPiezas.txtCantidad.Enabled = .F.
			Thisform.Contenido.cntPiezas.txtPrecio.Enabled = .F.
			Thisform.Contenido.cntPiezas.txtObserv.Enabled = .F.
			Thisform.Contenido.cntPiezas.btnAgregarPieza.Enabled = .F.
			Thisform.Contenido.cntPiezas.btnEditar.Enabled = .F.
		ENDIF
	ENDIF
ENDIF

loRes.Close_Query()

&& Recupero los ítems de la reparacion para tildar
&& las piezas en forma automática.
lcSql = "SELECT "
lcSql = lcSql + "  detrep.idDetRep, "
lcSql = lcSql + "  detrep.idPieza, "
lcSql = lcSql + "  IFNULL(detrep.idArticulo, 0) AS idArticulo, "
lcSql = lcSql + "  IFNULL(articulos.codArt, '') AS codArt, "
lcSql = lcSql + "  IFNULL(articulos.descripcio, '') AS descArt, "
lcSql = lcSql + "  IFNULL(detrep.prVenta, 0) AS prVenta, "
lcSql = lcSql + "  IFNULL(detrep.subTot, 0) AS subTot, "
lcSql = lcSql + "  piezas.descripcio, "
lcSql = lcSql + "  detrep.cantidad, "
lcSql = lcSql + "  detrep.observ "
lcSql = lcSql + "FROM detrep "
lcSql = lcSql + "  INNER JOIN piezas "
lcSql = lcSql + "    ON piezas.idPieza = detrep.idPieza "
lcSql = lcSql + "  LEFT JOIN articulos "
lcSql = lcSql + "    ON articulos.idArticulo = detrep.idArticulo "
lcSql = lcSql + "WHERE detrep.idCabRep = " + ALLTRIM(STR(thisform.idcabrep))
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"
IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

lnTotal = 0.00
SELECT cur_x
GO TOP
DO WHILE !EOF("cur_x")
	SELECT cur_p
	LOCATE FOR cur_p.idPieza = cur_x.idPieza
	IF FOUND("cur_p") THEN
		SELECT cur_p
		LOCK()
		REPLACE cur_p.sel WITH .T.
		REPLACE cur_p.idDetRep WITH cur_x.idDetRep ADDITIVE
		REPLACE cur_p.cantidad WITH cur_x.cantidad ADDITIVE
		
		IF (INT(VAL(cur_x.idArticulo)) <> 0) THEN
			REPLACE cur_p.idArticulo WITH INT(VAL(cur_x.idArticulo)) ADDITIVE
			REPLACE cur_p.codArt WITH cur_x.codArt ADDITIVE
			REPLACE cur_p.descripcio WITH cur_x.descArt ADDITIVE
			REPLACE cur_p.prVenta WITH cur_x.prVenta ADDITIVE
			REPLACE cur_p.subTot WITH cur_x.subTot ADDITIVE
						
			lnTotal = lnTotal + cur_x.subTot
		ELSE
			REPLACE cur_p.prVenta WITH 0 ADDITIVE
			REPLACE cur_p.subtot WITH 0 ADDITIVE
		ENDIF
		
		REPLACE cur_p.observ WITH cur_x.observ ADDITIVE
		UNLOCK
	ENDIF

	SELECT cur_X
	SKIP
ENDDO

loRes.Close_Query()

Thisform.Contenido.txtTotRptos.Value = lnTotal

&& Deshabilito los controles que no se pueden
&& modificar
Thisform.Contenido.sel_TipoRep.txtCodigo.Enabled = .F.
Thisform.Contenido.sel_Cliente.txtCodigo.Enabled = .F.
Thisform.Contenido.sel_Reparador.txtCodigo.Enabled = .F.
Thisform.Contenido.sel_TipoRep.txtCodigo.Enabled = .F.
Thisform.Contenido.sel_Vehiculo.txtCodigo.Enabled = .F.
Thisform.Contenido.txtPatente.Enabled = .F.
Thisform.Contenido.txtFecEnt.Enabled = .F.
Thisform.Contenido.txtModelo.Enabled = .F.




ENDPROC
PROCEDURE imprimir_ficha
LOCAL m.NroRepa
LOCAL m.FecEnt
LOCAL m.Reparador
LOCAL m.tipoDoc
LOCAL m.dni
LOCAL m.razSoc
LOCAL m.marcaVehic
LOCAL m.patente
LOCAL m.tipoRep
LOCAL m.observ
LOCAL m.telefono
LOCAL m.marca
LOCAL m.voltaje

SELECT cur_print
ZAP 

SELECT * FROM clirep WHERE nroFiscal = Thisform.Contenido.sel_Cliente.txtCodigo.Value INTO CURSOR curtemp

m.NroRepa = Thisform.Contenido.txtNroRep.Value
m.FecEnt = Thisform.Contenido.txtFecEnt.Value
m.Reparador = Thisform.Contenido.sel_Reparador.txtDescripcion.Value
m.tipoDoc = "DNI/CUIT"
m.dni = Thisform.Contenido.sel_Cliente.txtCodigo.Value
m.razSoc = Thisform.Contenido.sel_Cliente.txtDescripcion.Value
m.marcaVehic = Thisform.Contenido.sel_vehiculo.txtdescripcion.Value
m.patente = Thisform.Contenido.txtPatente.Value
m.tipoRep = Thisform.Contenido.sel_TipoRep.txtdescripcion.Value
m.observ = Thisform.Contenido.txtObserv.Value + ""
m.telefono = curtemp.telefono
m.marca = ALLTRIM(thisform.contenido.txtMarca.Value)
m.voltaje = Thisform.Contenido.txtVoltaje.Value

USE IN curtemp

SELECT cur_p
GO TOP
DO WHILE !EOF("cur_p")
	SELECT cur_print
	APPEND BLANK
	REPLACE cur_print.sel WITH cur_p.sel
	REPLACE cur_print.descripcio WITH cur_p.descripcio ADDITIVE
	REPLACE cur_print.cantidad WITH cur_p.cantidad ADDITIVE
	REPLACE cur_print.observ WITH cur_p.observ ADDITIVE
	
	SELECT cur_p
	SKIP
ENDDO

SELECT cur_print
GO TOP
REPORT FORM "rep_ficharepar" TO PRINTER PROMPT NODIALOG PREVIEW
ENDPROC
PROCEDURE imprimir_presupuesto
LOCAL m.NroRepa
LOCAL m.FecEnt
LOCAL m.Reparador
LOCAL m.tipoDoc
LOCAL m.dni
LOCAL m.razSoc
LOCAL m.marcaVehic
LOCAL m.patente
LOCAL m.tipoRep
LOCAL m.observ
LOCAL m.impMO
LOCAL m.total

SELECT cur_print
ZAP


m.NroRepa = Thisform.Contenido.txtNroRep.Value
m.FecEnt = Thisform.Contenido.txtFecEnt.Value
m.Reparador = Thisform.Contenido.sel_Reparador.txtDescripcion.Value
m.tipoDoc = "DNI/CUIT"
m.dni = Thisform.Contenido.sel_Cliente.txtCodigo.Value
m.razSoc = Thisform.Contenido.sel_Cliente.txtDescripcion.Value
m.marcaVehic = Thisform.Contenido.sel_vehiculo.txtdescripcion.Value
m.patente = Thisform.Contenido.txtPatente.Value
m.tipoRep = Thisform.Contenido.sel_TipoRep.txtdescripcion.Value
m.observ = Thisform.Contenido.txtObserv.Value + ""
m.impMO = Thisform.Contenido.txtCMO.Value
m.total = Thisform.Contenido.txtTotalFinal.Value
m.NroRepa = thisform.contenido.txtNroRep.Value

SELECT cur_p
GO TOP
DO WHILE !EOF("cur_p")
	IF cur_p.sel THEN
		SELECT cur_print
		APPEND BLANK
		REPLACE cur_print.descripcio WITH cur_p.descripcio
		REPLACE cur_print.cantidad WITH cur_p.cantidad ADDITIVE
		REPLACE cur_print.idArticulo WITH cur_p.idArticulo ADDITIVE
		REPLACE cur_print.codArt WITH cur_p.codArt ADDITIVE
		REPLACE cur_print.descArt WITH cur_p.descArt ADDITIVE
		REPLACE cur_print.prVenta WITH cur_p.prVenta ADDITIVE
		REPLACE cur_print.subTot WITH cur_p.subTot ADDITIVE
		REPLACE cur_print.observ WITH cur_p.observ ADDITIVE
	ENDIF
	
	SELECT cur_p
	SKIP
ENDDO

SELECT cur_print
IF RECCOUNT("cur_print") = 0 THEN
	SELECT cur_print
	APPEND BLANK
	REPLACE cur_print.descripcio WITH ""
	REPLACE cur_print.cantidad WITH 1 ADDITIVE
	REPLACE cur_print.prVenta WITH 0 ADDITIVE
	REPLACE cur_print.subTot WITH 0 ADDITIVE
	REPLACE cur_print.observ WITH "" ADDITIVE
ENDIF

SELECT cur_print
GO TOP
REPORT FORM "rep_presurepar" TO PRINTER PROMPT NODIALOG PREVIEW
ENDPROC
PROCEDURE grabar
LOCAL loCommand
LOCAL loRes
LOCAL loDT
LOCAL lcSql
LOCAL lnProxID
LOCAL lnNroRep
LOCAL lnIdNum
LOCAL lnIdDetRep
LOCAL lcEstado

IF !Thisform.validarcampos() THEN
	RETURN .F.
ENDIF

loCommand = CREATEOBJECT("odbc_command")
loRes = CREATEOBJECT("odbc_result")
loDT = CREATEOBJECT("datetime")
lcSql = ""
lnNroRep = 0
lnIdNum = 0
lnIdDetRep = 0
lcEstado = ""

IF Thisform.esnuevo THEN
	&& Levanto el número de reparación
	lcSql = "SELECT idNum, numActual "
	lcSql = lcSql + "FROM numerador "
	lcSql = lcSql + "WHERE cbte = 'REP' "
	lcSql = lcSql + "	AND tipoDoc = 'X' "

	loRes.ActiveConnection = goConn.ActiveConnection
	loRes.Cursor_Name = "cur_num"
	IF !loRes.OpenQuery(lcSql) THEN
		MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
		RETURN .F.
	ENDIF

	SELECT cur_num
	lnNroRep = cur_num.numActual + 1
	lnIdNum = cur_num.idNum

	loRes.Close_Query()

	&& Actualizo el número de reparación en el numerador
	lcSql = "UPDATE numerador "
	lcSql = lcSql + "SET numActual = " + ALLTRIM(STR(lnNroRep)) + " "
	lcSql = lcSql + "WHERE numerador.idNum = " + ALLTRIM(STR(lnIdNum))
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	IF !loCommand.Execute() THEN
		MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
		RETURN .F.
	ENDIF

	lcSql = "SELECT MAX(idCabRep) AS maxID "
	lcSql = lcSql + "FROM cabrep "

	loRes.ActiveConnection = goConn.ActiveConnection
	loRes.Cursor_Name = "cur_max"
	IF !loRes.OpenQuery(lcSql) THEN
		MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
		RETURN .F.
	ENDIF

	IF ISNULL(cur_max.maxID) THEN
		lnProxID = 1
	ELSE
		lnProxID = cur_max.maxID + 1
	ENDIF

	loRes.Close_Query()

	goConn.BeginTransaction()

	lcSql = "INSERT INTO cabrep ("
	lcSql = lcSql + "idCabRep, "
	lcSql = lcSql + "idCliRep, "
	lcSql = lcSql + "idRepar, "
	lcSql = lcSql + "idTipoRep, "
	lcSql = lcSql + "fecEnt, "
	lcSql = lcSql + "fecSal, "
	lcSql = lcSql + "nroRep, "
	lcSql = lcSql + "patente, "
	lcSql = lcSql + "idMarcaV, "
	lcSql = lcSql + "modelo, "
	lcSql = lcSql + "observ, "
	lcSql = lcSql + "prManOb, "
	lcSql = lcSql + "precio, "
	lcSql = lcSql + "estado, "
	lcSql = lcSql + "voltaje, "
	lcSql = lcSql + "marca, "
	lcSql = lcSql + "usuAlta, "
	lcSql = lcSql + "fecAlta, "
	lcSql = lcSql + "idHostAlta) "
	lcSql = lcSql + "VALUES ( "
	lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", "
	lcSql = lcSql + ALLTRIM(STR(Thisform.contenido.sel_cliente.valcpoid)) + ", "
	lcSql = lcSql + ALLTRIM(STR(Thisform.contenido.sel_Reparador.valcpoid)) + ", "
	lcSql = lcSql + ALLTRIM(STR(Thisform.contenido.sel_TipoRep.valcpoid)) + ", "
	lcSql = lcSql + loDT.ToMySql(Thisform.Contenido.txtFecEnt.Value) + ", "
	lcSql = lcSql + loDT.ToMySql(Thisform.Contenido.txtFecSal.Value) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnNroRep)) + ", "
	lcSql = lcSql + "'" + ALLTRIM(Thisform.Contenido.txtPatente.Value) + "', "
	lcSql = lcSql + ALLTRIM(STR(Thisform.Contenido.sel_Vehiculo.valcpoid)) + ", "
	lcSql = lcSql + "'" + ALLTRIM(Thisform.Contenido.txtModelo.Value) + "', "
	lcSql = lcSql + "'" + ALLTRIM(Thisform.Contenido.txtObserv.Value) + "', "
	lcSql = lcSql + ALLTRIM(STR(Thisform.Contenido.txtCMO.Value)) + ", "
	lcSql = lcSql + ALLTRIM(STR(Thisform.Contenido.txtTotalFinal.Value, 10, 2)) + ", "
	IF Thisform.Contenido.cmbEstado.ListIndex = 1 THEN
		lcSql = lcSql + "'P',"
	ELSE
		IF Thisform.Contenido.cmbEstado.ListIndex = 2 THEN
			lcSql = lcSql + "'R', "
		ELSE
			lcSql = lcSql + "'A', "
		ENDIF
	ENDIF
	lcSql = lcSql + "'" + ALLTRIM(STR(thisform.contenido.txtVoltaje.Value)) + "', "
	lcSql = lcSql + "'" + ALLTRIM(thisform.contenido.txtMarca.Value) + "', "
	lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
	lcSql = lcSql + "current_timestamp, "
	lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "')"
ELSE
	lcSql = "UPDATE cabrep "
	lcSql = lcSql + "SET "
	lcSql = lcSql + "fecSal = " + loDT.ToMySql(Thisform.Contenido.txtFecSal.Value) + ", "
	lcSql = lcSql + "observ = '" + ALLTRIM(Thisform.Contenido.txtObserv.Value) + "', "
	
	lcEstado = UPPER(ALLTRIM(Thisform.Contenido.cmbEstado.Value))
	IF lcEstado == "PENDIENTE" THEN
		lcSql = lcSql + "estado = 'P', "
	ELSE
		IF lcEstado == "PRESUPUESTADO" THEN
			lcSql = lcSql + "estado = 'R', "
		ELSE
			IF lcEstado == "ABIERTO" THEN
				lcSql = lcSql + "estado = 'A', "
			ELSE
				lcSql = lcSql + "estado = 'C', "
			ENDIF
		ENDIF
	ENDIF
	
	lcSql = lcSql + "usuModi = '" + ALLTRIM(gcCodUsu) + "', "
	lcSql = lcSql + "fecModi = current_timestamp, "
	lcSql = lcSql + "idHostModi = '" + ALLTRIM(SYS(0)) + "' "
	lcSql = lcSql + "WHERE idCabRep = " + ALLTRIM(STR(Thisform.idcabrep))
	
	&& La siguiente línea la incorporo para no agregar
	&& una validación más en el update
	lnProxID = Thisform.idcabrep
	lnNroRep = Thisform.nrorep
ENDIF

loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = lcSql
IF !loCommand.Execute() THEN
	goConn.Rollback()
	MESSAGEBOX(loCommand.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

IF (!Thisform.esnuevo) THEN
	lcSql = "DELETE FROM detrep "
	lcSql = lcSql + "WHERE idCabRep = " + ALLTRIM(STR(Thisform.idcabrep))
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	IF !loCommand.Execute() THEN
		MESSAGEBOX(loCommand.Error_Message, 0+48, Thisform.Caption)
		RETURN .F.
	ENDIF
ENDIF

lnIdDetRep = 1
SELECT cur_p
GO TOP
DO WHILE !EOF("cur_p")
	IF cur_p.sel THEN
		IF cur_p.esNuevo THEN
			lcSql = "INSERT INTO componen ( "
			lcSql = lcSql + "idTipoRep, "
			lcSql = lcSql + "idPieza, "
			lcSql = lcSql + "cantidad, "
			lcSql = lcSql + "usuAlta, "
			lcSql = lcSql + "fecAlta, "
			lcSql = lcSql + "idHostAlta) "
			lcSql = lcSql + "VALUES ( "
			lcSql = lcSql + ALLTRIM(STR(Thisform.Contenido.sel_TipoRep.valcpoid)) + ", "
			lcSql = lcSql + ALLTRIM(STR(cur_p.idPieza)) + ", "
			lcSql = lcSql + ALLTRIM(STR(cur_p.cantidad)) + ", "
			lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
			lcSql = lcSql + "current_timestamp, "
			lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "')"
			
			loCommand.ActiveConnection = goConn.ActiveConnection
			loCommand.CommandText = lcSql
			IF !loCommand.Execute() THEN
				goConn.Rollback()
				MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
				RETURN .F.
			ENDIF
		ENDIF	

		lcSql = "INSERT INTO detrep ( "
		lcSql = lcSql + "idDetRep, "
		lcSql = lcSql + "idCabRep, "
		lcSql = lcSql + "idPieza, "
		IF cur_p.idArticulo <> 0 THEN
			lcSql = lcSql + "idArticulo, "
			lcSql = lcSql + "prVenta, "
			lcSql = lcSql + "subTot, "
		ENDIF
		lcSql = lcSql + "cantidad, "
		lcSql = lcSql + "observ) "
		lcSql = lcSql + "VALUES ( "
		lcSql = lcSql + ALLTRIM(STR(lnIdDetRep)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_p.idPieza)) + ", "
		IF cur_p.idArticulo <> 0 THEN
			lcsql = lcSql + ALLTRIM(STR(cur_p.idArticulo)) + ", "
			lcSql = lcSql + ALLTRIM(STR(cur_p.prVenta, 10, 2)) + ", "
			lcSql = lcSql + ALLTRIM(STR(cur_p.subTot, 10, 2)) + ", "
		ENDIF
		lcSql = lcSql + ALLTRIM(STR(cur_p.cantidad)) + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_p.observ) + "')"
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
			RETURN .F.
		ENDIF
		
		lnIdDetRep = lnIdDetRep + 1
	ENDIF
	
	SELECT cur_p
	SKIP
ENDDO

goConn.Commit()
Thisform.Contenido.txtNroRep.Value = lnNroRep
MESSAGEBOX("La reparación se ha cargado satisfactoriamente", ;
	0+64, Thisform.Caption)

RETURN .T.
ENDPROC
PROCEDURE validarcampos
IF Thisform.contenido.sel_cliente.valcpoid = 0 THEN
	MESSAGEBOX("Debe ingresar el cliente", 0+48, Thisform.Caption)
	Thisform.Contenido.sel_cliente.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

IF Thisform.contenido.sel_Reparador.valcpoid = 0 THEN
	MESSAGEBOX("Debe ingresar el reparador", 0+48, Thisform.Caption)
	Thisform.Contenido.sel_Reparador.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

IF Thisform.Contenido.sel_TipoRep.valcpoid = 0 THEN
	MESSAGEBOX("Debe ingresar el tipo de reparación", 0+48, Thisform.Caption)
	Thisform.Contenido.sel_TipoRep.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

IF Thisform.Contenido.sel_Vehiculo.valcpoid = 0 THEN
	MESSAGEBOX("Debe ingresar el vehículo", 0+48, Thisform.Caption)
	Thisform.Contenido.sel_Vehiculo.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

IF Thisform.Contenido.txtFecSal.Value = {} THEN
	MESSAGEBOX("Debe ingresar la fecha de salida", 0+48, Thisform.Caption)
	Thisform.Contenido.txtFecSal.SetFocus()
	RETURN .F.
ENDIF



RETURN .T.
ENDPROC
PROCEDURE Load
DODEFAULT()

CREATE CURSOR cur_p ( ;
	sel L,;
	idDetRep int,;
	idPieza int,;
	idArticulo int null,;
	codArt varchar(20) null,;
	descArt varchar(200) null,;
	prVenta float(10, 2) null,;
	subTot float(10, 2) null,;
	descripcio varchar(60),;
	cantidad int,;
	observ varchar(100),;
	esNuevo L)

CREATE CURSOR cur_print (;
	sel L,;
	descripcio varchar(60),;
	cantidad int,;
	idArticulo int null,;
	codArt varchar(20) null,;
	descArt varchar(200) null,;
	prVenta float(10, 2) null,;
	subTot float(10, 2) null,;
	observ varchar(100))
ENDPROC
PROCEDURE Init
Thisform.contenido.cmbEstado.AddItem("Pendiente")
Thisform.contenido.cmbEstado.AddItem("Presupuestado")
Thisform.contenido.cmbEstado.AddItem("Abierto")

SELECT cur_p
Thisform.Contenido.cntPiezas.grdPiezas.alias_name = "cur_p"
Thisform.Contenido.cntPiezas.grdPiezas.RecordSource = "cur_p"
Thisform.Contenido.cntPiezas.grdPiezas.list_controlsource = ;
	"sel,idPieza,descripcio,cantidad,codArt,prVenta,observ"
Thisform.Contenido.cntPiezas.grdPiezas.lista_ancho_cols = "70,70,150,100,120,70,200"
Thisform.Contenido.cntPiezas.grdPiezas.titulos_cabeceras = ;
	"Sel.,Pieza,Descripción,Cantidad,Artículo,Precio,Observaciones"
Thisform.Contenido.cntPiezas.grdPiezas.generar_grid()

Thisform.Contenido.cntPiezas.grdPiezas.ReadOnly = .F.
Thisform.Contenido.cntPiezas.grdPiezas.Columns[1].ReadOnly = .F.
Thisform.Contenido.cntPiezas.grdPiezas.Columns[2].ReadOnly = .T.
Thisform.Contenido.cntPiezas.grdPiezas.Columns[3].ReadOnly = .T.
Thisform.Contenido.cntPiezas.grdPiezas.Columns[4].ReadOnly = .F.

Thisform.Contenido.txtFecEnt.Value = DATE()
Thisform.Contenido.txtFecSal.Value = {}

ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Cliente:"
Height = 15
Left = 283
Top = 11
Width = 72
TabIndex = 25
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Reparador:"
Height = 15
Left = 25
Top = 36
Width = 72
TabIndex = 27
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Tipo de Reparación:"
Height = 15
Left = 25
Top = 111
Width = 120
TabIndex = 36
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Marca de Vehículo:"
Height = 15
Left = 25
Top = 61
Width = 120
TabIndex = 38
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Patente:"
Height = 15
Left = 661
Top = 85
Width = 60
TabIndex = 39
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: sel_Cliente
************************************************************
*** PROPIEDADES ***
Top = 5
Left = 334
TabIndex = 2
nombre_campo_codigo = nroFiscal
autocompletar_ceros = .F.
esnumerico = .F.
nombre_campo_desc = razSoc
nombre_tabla = clirep
permitir_agregar_regs = .F.
pkfield = idCliRep
Name = "sel_Cliente"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: sel_Reparador
************************************************************
*** PROPIEDADES ***
Top = 30
Left = 144
TabIndex = 4
autocompletar_ceros = .F.
esnumerico = .T.
nombre_campo_codigo = idRepar
nombre_campo_desc = apelNom
nombre_tabla = repdores
pkfield = idRepar
title_cols = Apellido y Nombre(s)
Name = "sel_Reparador"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: sel_Vehiculo
************************************************************
*** PROPIEDADES ***
Top = 55
Left = 144
TabIndex = 6
autocompletar_ceros = .F.
nombre_campo_codigo = idMarcaV
nombre_campo_desc = descripcio
nombre_tabla = marcas_v
pkfield = idMarcaV
esnumerico = .T.
Name = "sel_Vehiculo"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: txtPatente
************************************************************
*** PROPIEDADES ***
Left = 725
MaxLength = 10
TabIndex = 9
Top = 82
Name = "txtPatente"

*** METODOS ***


************************************************************
OBJETO: sel_TipoRep
************************************************************
*** PROPIEDADES ***
Top = 105
Left = 144
TabIndex = 10
autocompletar_ceros = .F.
nombre_campo_codigo = codigoTR
nombre_campo_desc = descripcio
nombre_tabla = tiposrep
permitir_agregar_regs = .F.
pkfield = idTipoRep
Name = "sel_TipoRep"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***
PROCEDURE recuperar_datos
Thisform.recuperar_piezas(this.valcpoid)
Thisform.Contenido.txtFecEnt.SetFocus()
ENDPROC


************************************************************
OBJETO: cntPiezas
************************************************************
*** PROPIEDADES ***
Top = 157
Left = 25
Width = 900
Height = 279
TabIndex = 16
BackColor = 232,232,232
Name = "cntPiezas"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Pieza:"
Height = 15
Left = 12
Top = 12
Width = 48
TabIndex = 10
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: sel_piezas
************************************************************
*** PROPIEDADES ***
Top = 7
Left = 60
TabIndex = 1
nombre_campo_codigo = idPieza
nombre_campo_desc = descripcio
nombre_tabla = piezas
pkfield = idPieza
autocompletar_ceros = .F.
esnumerico = .T.
Name = "sel_piezas"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Cantidad:"
Height = 15
Left = 592
Top = 12
Width = 59
TabIndex = 14
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: txtCantidad
************************************************************
*** PROPIEDADES ***
Left = 652
TabIndex = 2
Top = 9
isinteger = .T.
Name = "txtCantidad"

*** METODOS ***


************************************************************
OBJETO: btnAgregarPieza
************************************************************
*** PROPIEDADES ***
Top = 67
Left = 817
Height = 36
Width = 36
TabIndex = 5
ToolTipText = "Agregar pieza al tipo de reparación seleccionado"
Name = "btnAgregarPieza"

*** METODOS ***
PROCEDURE Click
IF This.Parent.sel_piezas.valcpoid = 0 THEN
	MESSAGEBOX("Debe seleccionar una pieza", 0+48, Thisform.Caption)
	This.Parent.sel_piezas.txtCodigo.SetFocus()
	RETURN
ENDIF

IF This.Parent.txtCantidad.Value = 0 THEN
	MESSAGEBOX("La cantidad no puede ser cero", 0+48, Thisform.Caption)
	This.Parent.txtcantidad.SetFocus()
	RETURN
ENDIF

IF !Thisform.editapieza THEN
	SELECT cur_p
	APPEND BLANK
	REPLACE cur_p.sel WITH .T.
	REPLACE cur_p.idDetRep WITH 0 ADDITIVE
	REPLACE cur_p.idPieza WITH This.Parent.sel_piezas.valcpoid ADDITIVE
	REPLACE cur_p.descripcio WITH This.Parent.sel_piezas.txtdescripcion.Value ADDITIVE
	REPLACE cur_p.cantidad WITH This.Parent.txtCantidad.Value ADDITIVE
	REPLACE cur_p.observ WITH ALLTRIM(This.Parent.txtObserv.Value) ADDITIVE
	REPLACE cur_p.esNuevo WITH .T. ADDITIVE

	IF (This.Parent.sel_Articulo.valcpoid <> 0) THEN
		REPLACE cur_p.idArticulo WITH This.Parent.sel_Articulo.valcpoid ADDITIVE
		REPLACE cur_p.codArt WITH This.Parent.sel_Articulo.txtCodigo.Value ADDITIVE
		REPLACE cur_p.descArt WITH This.Parent.sel_Articulo.txtDescripcion.Value ADDITIVE
		REPLACE cur_p.prVenta WITH This.Parent.txtPrecio.Value ADDITIVE
		REPLACE cur_p.subTot WITH This.Parent.txtPrecio.Value * This.Parent.txtCantidad.Value ADDITIVE
	ELSE
		REPLACE cur_p.idArticulo WITH 0 ADDITIVE
		REPLACE cur_p.codArt WITH "" ADDITIVE
		REPLACE cur_p.descArt WITH "" ADDITIVE
		REPLACE cur_p.prVenta WITH 0 ADDITIVE
		REPLACE cur_p.subTot WITH 0 ADDITIVE
	ENDIF
ELSE
	SELECT cur_p
	LOCK()
	REPLACE cur_p.sel WITH .T.
	REPLACE cur_p.cantidad WITH This.Parent.txtCantidad.Value ADDITIVE
	REPLACE cur_p.observ WITH ALLTRIM(This.Parent.txtObserv.Value) ADDITIVE	
	IF (This.Parent.sel_Articulo.valcpoid <> 0) THEN
		REPLACE cur_p.idArticulo WITH This.Parent.sel_Articulo.valcpoid ADDITIVE
		REPLACE cur_p.codArt WITH This.Parent.sel_Articulo.txtCodigo.Value ADDITIVE
		REPLACE cur_p.descArt WITH This.Parent.sel_Articulo.txtDescripcion.Value ADDITIVE
		REPLACE cur_p.prVenta WITH This.Parent.txtPrecio.Value ADDITIVE
		REPLACE cur_p.subTot WITH This.Parent.txtPrecio.Value * This.Parent.txtCantidad.Value ADDITIVE
	ELSE
		REPLACE cur_p.idArticulo WITH 0 ADDITIVE
		REPLACE cur_p.codArt WITH "" ADDITIVE
		REPLACE cur_p.descArt WITH "" ADDITIVE
		REPLACE cur_p.prVenta WITH 0 ADDITIVE
		REPLACE cur_p.subTot WITH 0 ADDITIVE
	ENDIF
	UNLOCK
	
	Thisform.editapieza = .F.
	Thisform.contenido.cntPiezas.sel_piezas.txtCodigo.Enabled = .T.
	MESSAGEBOX("Los datos fueron modificados con éxito", 0+64, Thisform.Caption)
ENDIF

Thisform.Contenido.txtTotRptos.Value = Thisform.calc_totrptos()
Thisform.Contenido.txtTotalFinal.Value = Thisform.Contenido.txtTotRptos.Value + ;
	Thisform.contenido.txtCMO.value

SELECT cur_p
GO TOP

Thisform.contenido.cntPiezas.grdPiezas.Refresh()
Thisform.contenido.cntPiezas.sel_piezas.blanquear()
Thisform.contenido.cntPiezas.sel_Articulo.blanquear()
Thisform.contenido.cntPiezas.txtCantidad.blanquear()
Thisform.contenido.cntPiezas.txtPrecio.blanquear()
Thisform.contenido.cntPiezas.txtObserv.Value = ""
Thisform.contenido.cntpiezas.sel_piezas.txtcodigo.SetFocus()
ENDPROC


************************************************************
OBJETO: grdPiezas
************************************************************
*** PROPIEDADES ***
Height = 173
Left = 12
TabIndex = 7
Top = 103
Width = 876
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdPiezas"
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
PROCEDURE AfterRowColChange
LPARAMETERS nColIndex
SELECT cur_p
Thisform.contenido.cntPiezas.grdPiezas.ToolTipText = ALLTRIM(cur_p.observ)
ENDPROC
PROCEDURE COLUMN6.Text1.Valid
SELECT cur_p
IF cur_p.subTot = 0 .and. cur_p.prVenta <> 0 THEN
	SELECT cur_p
	LOCK()
	REPLACE cur_p.sel WITH .t.
	REPLACE cur_p.subTot WITH cur_p.prVenta ADDITIVE
	UNLOCK
ELSE
	IF cur_p.prVenta = 0 THEN
		SELECT cur_p
		LOCK()
		REPLACE cur_p.sel WITH .f.
		REPLACE cur_p.subTot WITH 0 ADDITIVE
		UNLOCK
	ENDIF
ENDIF

thisform.contenido.txtTotRptos.Value = thisform.calc_totrptos()
thisform.contenido.txtTotalFinal.Value = thisform.contenido.txtTotRptos.Value + thisform.contenido.txtCMO.Value
ENDPROC


************************************************************
OBJETO: Clscheckbox1
************************************************************
*** PROPIEDADES ***
Top = 26
Left = 37
Alignment = 0
Caption = ""
Name = "Clscheckbox1"

*** METODOS ***


************************************************************
OBJETO: btnAgregarTipoRep
************************************************************
*** PROPIEDADES ***
Top = 8
Left = 538
Height = 23
Width = 22
Picture = ..\imagen\iconos_chicos\add_3.jpg
TabIndex = 9
ToolTipText = "Dar de alta una pieza nueva"
Name = "btnAgregarTipoRep"

*** METODOS ***
PROCEDURE Click
LOCAL loForm

loForm = CREATEOBJECT("cls_dlg_altapieza")
loForm.Show()

IF loForm.accept_press THEN
	&&Thisform.contenido.cntPiezas.sel_piezas.leer_datos()
	Thisform.contenido.cntPiezas.sel_piezas.txtCodigo.Value = loForm.idpieza
	Thisform.contenido.cntPiezas.sel_piezas.txtDescripcion.value = loForm.descripcio
	Thisform.contenido.cntPiezas.sel_piezas.valcpoid = loForm.idpieza
ENDIF

loForm.Release()

ENDPROC


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Artículo:"
Height = 15
Left = 12
Top = 36
Width = 48
TabIndex = 13
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: sel_Articulo
************************************************************
*** PROPIEDADES ***
Top = 31
Left = 60
TabIndex = 3
nombre_campo_codigo = codArt
nombre_campo_desc = descripcio
nombre_tabla = articulos
pkfield = idArticulo
autocompletar_ceros = .F.
esnumerico = .F.
Name = "sel_Articulo"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***
PROCEDURE recuperar_datos
SELECT articulos
This.Parent.txtPrecio.Value = articulos.prFinalMax

ENDPROC


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Observaciones:"
Height = 15
Left = 12
Top = 58
Width = 90
TabIndex = 11
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: txtObserv
************************************************************
*** PROPIEDADES ***
Height = 30
Left = 12
MaxLength = 100
TabIndex = 4
Top = 72
Width = 804
Name = "txtObserv"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Precio:"
Height = 15
Left = 592
Top = 36
Width = 48
TabIndex = 12
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: txtPrecio
************************************************************
*** PROPIEDADES ***
Left = 652
ReadOnly = .T.
TabIndex = 8
Top = 33
isinteger = .F.
isnumeric = .T.
Name = "txtPrecio"

*** METODOS ***


************************************************************
OBJETO: btnEditar
************************************************************
*** PROPIEDADES ***
Top = 67
Left = 852
Height = 36
Width = 37
TabIndex = 6
ToolTipText = "Editar el artículo."
Name = "btnEditar"

*** METODOS ***
PROCEDURE Click
Thisform.editapieza = .T.
SELECT cur_p
This.Parent.sel_piezas.valcpoid = cur_p.idPieza
This.Parent.sel_piezas.txtCodigo.Value = cur_p.idPieza
This.Parent.sel_Piezas.txtDescripcion.Value = cur_p.descripcio
This.Parent.sel_Articulo.valcpoid = cur_p.idArticulo
This.Parent.sel_Articulo.txtCodigo.Value = cur_p.codArt
This.Parent.sel_Articulo.txtDescripcion.Value = cur_p.descArt 
This.Parent.txtPrecio.Value = cur_p.prVenta
This.Parent.txtCantidad.Value = cur_p.cantidad
This.Parent.txtObserv.Value = cur_p.observ

This.Parent.sel_piezas.txtCodigo.Enabled = .F.
ENDPROC


************************************************************
OBJETO: Clsetiqueta6
************************************************************
*** PROPIEDADES ***
Caption = "Estado:"
Height = 15
Left = 660
Top = 35
Width = 48
TabIndex = 40
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: cmbEstado
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 724
TabIndex = 5
Top = 32
Width = 200
Name = "cmbEstado"

*** METODOS ***


************************************************************
OBJETO: btnGrabar
************************************************************
*** PROPIEDADES ***
Top = 514
Left = 475
TabIndex = 19
Name = "btnGrabar"

*** METODOS ***
PROCEDURE Click
LOCAL llOK
LOCAL lnResp

llOK = .F.

IF Thisform.ValidarCampos() THEN
	llOK = Thisform.Grabar()
	IF llOK THEN
		lnResp = MESSAGEBOX("¿Desea imprimir la ficha de reparación", 4+32, Thisform.Caption)
		IF lnResp = 6 THEN
			Thisform.imprimir_ficha()
		ENDIF
	
		Thisform.Limpiar()
	ENDIF
ENDIF
ENDPROC


************************************************************
OBJETO: btnCancelar
************************************************************
*** PROPIEDADES ***
Top = 514
Left = 28
TabIndex = 20
Name = "btnCancelar"

*** METODOS ***
PROCEDURE Click
Thisform.Limpiar()

ENDPROC


************************************************************
OBJETO: btnAgregarCliente
************************************************************
*** PROPIEDADES ***
Top = 6
Left = 812
Height = 23
Width = 22
Picture = ..\imagen\iconos_chicos\add_3.jpg
TabIndex = 3
ToolTipText = "Dar de alta un cliente nuevo"
Name = "btnAgregarCliente"

*** METODOS ***
PROCEDURE Click
LOCAL loForm

loForm = CREATEOBJECT("cls_dlg_altaclirep")
loForm.ingreso_desde_fc = .f.
loForm.inicializar_formulario()
loForm.Show()

IF loForm.accept_press THEN
	&&Thisform.Contenido.sel_cliente.leer_datos()
	Thisform.contenido.sel_Cliente.txtCodigo.Value = loForm.nrofiscal
	Thisform.contenido.sel_Cliente.txtDescripcion.value = loForm.razsoc
	Thisform.contenido.sel_Cliente.valcpoid = loForm.idclirep
	
	Thisform.contenido.sel_Reparador.SetFocus()
ENDIF

loForm.Release()


ENDPROC


************************************************************
OBJETO: btnAgregarMarcasV
************************************************************
*** PROPIEDADES ***
Top = 56
Left = 622
Height = 23
Width = 23
Picture = ..\imagen\iconos_chicos\add_3.jpg
TabIndex = 7
ToolTipText = "Dar de alta una marca nueva"
Name = "btnAgregarMarcasV"

*** METODOS ***
PROCEDURE Click
LOCAL loForm

loForm = CREATEOBJECT("cls_dlg_altamarcav")
loForm.Show()

IF loForm.accept_press THEN
	&&Thisform.contenido.sel_Vehiculo.leer_datos()
	Thisform.contenido.sel_Vehiculo.txtCodigo.Value = loForm.idMarcaV
	Thisform.contenido.sel_Vehiculo.txtDescripcion.value = loForm.descripcion
	Thisform.contenido.sel_Vehiculo.valcpoid = loForm.idMarcaV
ENDIF

loForm.Release()

ENDPROC


************************************************************
OBJETO: btnAgregarTipoRep
************************************************************
*** PROPIEDADES ***
Top = 106
Left = 622
Height = 23
Width = 23
Picture = ..\imagen\iconos_chicos\add_3.jpg
TabIndex = 11
ToolTipText = "Dar de alta un tipo de reparación nuevo"
Name = "btnAgregarTipoRep"

*** METODOS ***
PROCEDURE Click
LOCAL loForm

loForm = CREATEOBJECT("cls_dlg_altatiposrep")
loForm.Show()

IF loForm.accept_press THEN
	&&Thisform.contenido.sel_tipoRep.leer_datos()
	Thisform.contenido.sel_tipoRep.txtCodigo.Value = loForm.codigotr
	Thisform.contenido.sel_tipoRep.txtDescripcion.value = loForm.descripcio
	Thisform.contenido.sel_tipoRep.valcpoid = loForm.idtiporep
	Thisform.recuperar_piezas(loForm.idtiporep)
ENDIF

loForm.Release()


ENDPROC


************************************************************
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 514
Left = 881
TabIndex = 21
Name = "btnCerrar"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta7
************************************************************
*** PROPIEDADES ***
Caption = "Modelo:"
Height = 15
Left = 25
Top = 85
Width = 120
TabIndex = 37
Name = "Clsetiqueta7"

*** METODOS ***


************************************************************
OBJETO: txtModelo
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 146
MaxLength = 100
TabIndex = 8
Top = 82
Width = 478
ischaracter = .T.
Name = "txtModelo"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta8
************************************************************
*** PROPIEDADES ***
Caption = "Fecha Entrada:"
Height = 15
Left = 25
Top = 136
Width = 108
TabIndex = 31
Name = "Clsetiqueta8"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta9
************************************************************
*** PROPIEDADES ***
Caption = "Fecha Salida:"
Height = 15
Left = 260
Top = 136
Width = 75
TabIndex = 28
Name = "Clsetiqueta9"

*** METODOS ***


************************************************************
OBJETO: txtFecEnt
************************************************************
*** PROPIEDADES ***
Left = 146
TabIndex = 12
Top = 132
isdatetime = .T.
Name = "txtFecEnt"

*** METODOS ***


************************************************************
OBJETO: txtFecSal
************************************************************
*** PROPIEDADES ***
Left = 338
TabIndex = 13
Top = 132
isdatetime = .T.
Name = "txtFecSal"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta10
************************************************************
*** PROPIEDADES ***
Caption = "Nro. Reparación:"
Height = 15
Left = 25
Top = 11
Width = 96
TabIndex = 26
Name = "Clsetiqueta10"

*** METODOS ***


************************************************************
OBJETO: txtNroRep
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 146
ReadOnly = .T.
TabIndex = 1
Top = 7
Width = 131
Name = "txtNroRep"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta11
************************************************************
*** PROPIEDADES ***
Caption = "Observaciones:"
Height = 15
Left = 25
Top = 440
Width = 108
TabIndex = 32
Name = "Clsetiqueta11"

*** METODOS ***


************************************************************
OBJETO: txtObserv
************************************************************
*** PROPIEDADES ***
Height = 33
Left = 25
TabIndex = 17
Top = 456
Width = 900
Name = "txtObserv"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta12
************************************************************
*** PROPIEDADES ***
Caption = "Costo Rptos.:"
Height = 15
Left = 25
Top = 494
Width = 84
TabIndex = 33
Name = "Clsetiqueta12"

*** METODOS ***


************************************************************
OBJETO: txtTotRptos
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 109
ReadOnly = .T.
TabIndex = 24
Top = 491
Width = 84
isinteger = .F.
isnumeric = .T.
Name = "txtTotRptos"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta13
************************************************************
*** PROPIEDADES ***
Caption = "Costo Mano de Obra:"
Height = 15
Left = 205
Top = 494
Width = 120
TabIndex = 34
Name = "Clsetiqueta13"

*** METODOS ***


************************************************************
OBJETO: txtCMO
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 327
ReadOnly = .F.
TabIndex = 22
Top = 491
Width = 84
isinteger = .F.
isnumeric = .T.
Name = "txtCMO"

*** METODOS ***
PROCEDURE calcular
This.Parent.txtTotalFinal.Value = This.Parent.txtTotRptos.Value + This.Parent.txtCMO.Value
ENDPROC


************************************************************
OBJETO: Clsetiqueta14
************************************************************
*** PROPIEDADES ***
Caption = "Total Final:"
Height = 15
Left = 417
Top = 494
Width = 64
TabIndex = 35
Name = "Clsetiqueta14"

*** METODOS ***


************************************************************
OBJETO: txtTotalFinal
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 483
ReadOnly = .T.
TabIndex = 23
Top = 491
Width = 84
isinteger = .F.
isnumeric = .T.
Name = "txtTotalFinal"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta15
************************************************************
*** PROPIEDADES ***
Caption = "Voltaje:"
Height = 15
Left = 453
Top = 136
Width = 52
TabIndex = 30
Name = "Clsetiqueta15"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta16
************************************************************
*** PROPIEDADES ***
Caption = "Marca:"
Height = 15
Left = 639
Top = 136
Width = 52
TabIndex = 29
Name = "Clsetiqueta16"

*** METODOS ***


************************************************************
OBJETO: txtVoltaje
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 502
MaxLength = 0
TabIndex = 14
Top = 133
Width = 123
isnumeric = .F.
isinteger = .T.
Name = "txtVoltaje"

*** METODOS ***


************************************************************
OBJETO: txtMarca
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 684
MaxLength = 0
TabIndex = 15
Top = 133
Width = 241
Name = "txtMarca"

*** METODOS ***


************************************************************
OBJETO: btnImprimir
************************************************************
*** PROPIEDADES ***
Top = 514
Left = 428
TabIndex = 18
ToolTipText = "Imprimir ficha de reparación"
Name = "btnImprimir"

*** METODOS ***
PROCEDURE Click
LOCAL loForm

IF !Thisform.ValidarCampos() THEN
	RETURN .F.
ENDIF 

loForm = CREATEOBJECT("cls_report_selector")
loForm.Show()

IF loForm.Press_Aceptar THEN
	IF loForm.tipo_report == "F" THEN
		Thisform.imprimir_ficha()
	ELSE
		IF loForm.tipo_report == "P" THEN
			Thisform.imprimir_presupuesto()
		ENDIF
	ENDIF
ENDIF

loForm.Release()
ENDPROC


************************************************************
OBJETO: cls_ing_repar
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_dlg_altaclirep
************************************************************
*** PROPIEDADES ***
BorderStyle = 2
Height = 376
Width = 600
DoCreate = .T.
Caption = "Alta de cliente"
Closable = .F.
idclirep = 0
nrofiscal = 
razsoc = 
accept_press = .F.
ingreso_desde_fc = .F.
Name = "cls_dlg_altaclirep"

*** METODOS ***
PROCEDURE validar_datos
IF Thisform.sel_tipoDoc.valcpoid = 0 THEN
	MESSAGEBOX("El tipo de documento es obligatorio", 0+48, Thisform.Caption)
	Thisform.sel_tipoDoc.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

IF ALLTRIM(Thisform.txtNumero.Value) == "" THEN
	MESSAGEBOX("El número de documento es obligatorio", 0+48, Thisform.Caption)
	Thisform.txtNumero.SetFocus()
	RETURN .F.
ENDIF

IF ALLTRIM(Thisform.txtRazSoc.Value) == "" THEN
	MESSAGEBOX("La razón social es obligatoria", 0+48, Thisform.Caption)
	Thisform.txtRazSoc.SetFocus()
	RETURN .F.
ENDIF

IF ALLTRIM(Thisform.txtDireccion.Value) == "" THEN
	MESSAGEBOX("Ingrese la dirección", 0+48, Thisform.Caption)
	Thisform.txtDireccion.SetFocus()
	RETURN .F.
ENDIF

IF Thisform.sel_Localid.valcpoid = 0 THEN
	MESSAGEBOX("Ingrese la localidad", 0+48, Thisform.Caption)
	Thisform.sel_localid.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

IF THisform.sel_condpago.valcpoid = 0 THEN
	MESSAGEBOX("Ingrese la condición de pago", 0+48, Thisform.Caption)
	Thisform.sel_condpago.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

IF Thisform.sel_SitIVA.valcpoid = 0 THEN
	MESSAGEBOX("Ingrese la situación de IVA", 0+48, Thisform.Caption)
	Thisform.sel_condpago.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

IF Thisform.sel_vendedor.valcpoid = 0 THEN
	MESSAGEBOX("Ingrese el vendedor", 0+48, Thisform.Caption)
	Thisform.sel_Vendedor.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

IF Thisform.sel_transporte.valcpoid = 0 THEN
	MESSAGEBOX("Ingrese el transporte", 0+48, Thisform.Caption)
	Thisform.sel_transporte.SetFocus()
	RETURN .F.
ENDIF

&& Si la situación de IVA no es consumidor final y el tipo de documento no es CUIT,
&& entonces le exijo que cargue el número de CUIT para poder facturar.
IF Thisform.sel_SitIVA.valcpoid <> 3 .AND. Thisform.sel_TipoDoc.valcpoid <> 1 THEN
	MESSAGEBOX("Si el cliente no es consumidor final debe ingresar el número de CUIT", 0+48, Thisform.Caption)
	Thisform.sel_TipoDoc.txtCodigo.SetFocus()
	RETURN .F.
ENDIF


&& Si el tipo de documento es CUIT, entonces verifico que cargue un número
&& de CUIT realmente
IF Thisform.sel_TipoDoc.valcpoid = 1 THEN
	IF LEN(ALLTRIM(Thisform.txtNumero.Value)) < 11 THEN
		MESSAGEBOX("CUIT Inválido, ingrese el número de CUIT correcto", 0+48, Thisform.Caption)
		Thisform.txtNumero.SetFocus()
		RETURN .F.
	ENDIF	
ENDIF

RETURN .T.

ENDPROC
PROCEDURE insertar_en_cliprep
LOCAL loCommand
LOCAL loRes
LOCAL loDT
LOCAL lcSql
LOCAL lnProxID
LOCAL lnIdTipoDoc
LOCAL lcNroFiscal
LOCAL lcRazSoc
LOCAL lcTelefono
LOCAL lcNextTel
LOCAL lnPresup
LOCAL lcUsuAlta
LOCAL ldFecAlta
LOCAL lcIdHostAlta

loCommand = CREATEOBJECT("odbc_command")
loRes = CREATEOBJECT("odbc_result")
loDT = CREATEOBJECT("datetime")
lcSql = ""

lnProxID = 0
lnIdTipoDoc = 0
lcNroFiscal = ""
lcRazSoc = ""
lcTelefono = ""
lcNextTel = ""
llPresup = .F.
lcUsuAlta = gcCodUsu
ldFecAlta = DATETIME()
lcIdHostAlta = SYS(0)

&& Asigno los campos a variables
lnIdTipoDoc = Thisform.sel_tipoDoc.valcpoid
lcNroFiscal = Thisform.txtNumero.Value
lcRazSoc = Thisform.txtRazSoc.Value
lcTelefono = Thisform.txtTeléfono.Value
lcNextTel = Thisform.txtNextel.Value
lnPresup = Thisform.chkPresupuestar.Value

lcSql = "SELECT * "
lcSql = lcSql + "FROM clirep "
lcSql = lcSql + "WHERE idTipoDoc = " + ALLTRIM(STR(lnIdTipoDoc)) + " "
lcSql = lcSql + "	AND nroFiscal = '" + ALLTRIM(lcNroFiscal) + "' "

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_temp"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
ELSE
	SELECT cur_temp
	GO TOP
	IF RECCOUNT("cur_temp") > 0 THEN
		MESSAGEBOX("El número de documento ya se encuentra cargado " + ;
			"con el cliente " + ALLTRIM(cur_temp.razSoc), 0+48, ;
			Thisform.Caption)
	ELSE
		goConn.BeginTransaction()
		lnProxID = goConn.GetNextID("clirep", "idCliRep")
		
		lcSql = "INSERT INTO clirep ( "
		lcSql = lcSql + "idCliRep, "
		lcSql = lcSql + "idTipoDoc, "
		lcSql = lcSql + "nroFiscal, "
		lcSql = lcSql + "razSoc, "
		lcSql = lcSql + "telefono, "
		lcSql = lcSql + "nextel, "
		lcSql = lcSql + "presup, "
		lcSql = lcSql + "usuAlta, "
		lcSql = lcSql + "fecAlta, "
		lcSql = lcSql + "idHostAlta) "
		lcSql = lcSql + "VALUES ( "
		lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnIdTipoDoc)) + ", "
		lcSql = lcSql + ALLTRIM(lcNroFiscal) + ", "
		lcSql = lcSql + "'" + ALLTRIM(lcRazSoc) + "', "
		lcSql = lcSql + "'" + ALLTRIM(lcTelefono) + "', "
		lcSql = lcSql + "'" + ALLTRIM(lcNextTel) + "', "
		lcSql = lcSql + ALLTRIM(STR(lnPresup)) + ", "
		lcSql = lcSql + "'" + ALLTRIM(lcUsuAlta) + "', "
		lcSql = lcSql + loDT.ToMySql(ldFecAlta) + ", "
		lcSql = lcSql + "'" + ALLTRIM(lcIdHostAlta) + "')"
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
		ELSE 
			goConn.Commit()
			Thisform.idclirep = lnProxID
			Thisform.nrofiscal = lcNroFiscal
			Thisform.razsoc = lcRazSoc
			
			MESSAGEBOX("El cliente de reparación se dió de alta satisfactoriamente",;
				0+64, Thisform.Caption)
			
			Thisform.accept_press = .T.
			Thisform.Hide()
		ENDIF
	ENDIF
	
	loRes.Close_Query()
ENDIF

ENDPROC
PROCEDURE insertar_cliente
LOCAL loCmd
LOCAL lcSql

loCmd = CREATEOBJECT("odbc_result")

TEXT TO lcSql NOSHOW
	CALL clientes_insert_rapido (
		?razSoc,
		?direccion,
		?idLocalid,
		?idCondPago,
		?idSitIVA,
		?idVendedor,
		?idTipoCli,
		?idTransp,
		?idTipoDoc,
		?idRamo,
		?nroCUIT,
		?telefono,
		?celular,
		?fax,
		?eMail,
		?habilitado,
		?mayorista,
		?desc1,
		?desc2,
		?desc3,
		?desc4,
		?recargo,
		?usuAlta,
		?idHostAlta)
ENDTEXT
lcSql = loCmd.AddParameter(lcSql, "razSoc", ALLTRIM(Thisform.txtRazSoc.Value), .t., .f.)
lcSql = loCmd.AddParameter(lcSql, "direccion", ALLTRIM(Thisform.txtDireccion.Value), .t., .f.)
lcSql = loCmd.AddParameter(lcSql, "idLocalid", ALLTRIM(STR(Thisform.sel_Localid.valcpoid)), .f., .f.)
lcSql = loCmd.AddParameter(lcSql, "idCondPago", ALLTRIM(STR(Thisform.sel_CondPago.valcpoid)), .f., .f.)
lcSql = loCmd.AddParameter(lcSql, "idSitIVA", ALLTRIM(STR(Thisform.sel_SitIVA.valcpoid)), .f., .f.)
lcSql = loCmd.AddParameter(lcSql, "idVendedor", ALLTRIM(STR(Thisform.sel_vendedor.valcpoid)), .f., .f.)
lcSql = loCmd.AddParameter(lcSql, "idTipoCli", "1", .f., .f.)
lcSql = loCmd.AddParameter(lcSql, "idTransp", ALLTRIM(STR(Thisform.sel_transporte.valcpoid)), .f., .f.)
lcSql = loCmd.AddParameter(lcSql, "idTipoDoc", ALLTRIM(STR(Thisform.sel_tipoDoc.valcpoid)), .f., .f.)
lcSql = loCmd.AddParameter(lcSql, "idRamo", "1", .f., .f.)
lcSql = loCmd.AddParameter(lcSql, "nroCUIT", STRTRAN(ALLTRIM(Thisform.txtNumero.Value), "-", ""), .t., .f.)
lcSql = loCmd.AddParameter(lcSql, "telefono", ALLTRIM(Thisform.txtTeléfono.Value), .t., .f.)
lcSql = loCmd.AddParameter(lcSql, "celular", "", .t., .f.)
lcSql = loCmd.AddParameter(lcSql, "fax", "", .t., .f.)
lcSql = loCmd.AddParameter(lcSql, "eMail", "", .t., .f.)
lcSql = loCmd.AddParameter(lcSql, "habilitado", "1", .f., .f.)
lcSql = loCmd.AddParameter(lcSql, "mayorista", IIF(Thisform.chkMayorista.Value = 1, "1", "0"), .f., .f.)
lcSql = loCmd.AddParameter(lcSql, "desc1", ALLTRIM(STR(Thisform.txtDesc1.Value, 5, 2)), .f., .f.)
lcSql = loCmd.AddParameter(lcSql, "desc2", ALLTRIM(STR(Thisform.txtDesc1.Value, 5, 2)), .f., .f.)
lcSql = loCmd.AddParameter(lcSql, "desc3", ALLTRIM(STR(Thisform.txtDesc1.Value, 5, 2)), .f., .f.)
lcSql = loCmd.AddParameter(lcSql, "desc4", ALLTRIM(STR(Thisform.txtDesc1.Value, 5, 2)), .f., .f.)
lcSql = loCmd.AddParameter(lcSql, "recargo", ALLTRIM(STR(Thisform.txtRecargo.Value, 5, 2)), .f., .f.)
lcSql = loCmd.AddParameter(lcSql, "usuAlta", ALLTRIM(gcCodUsu), .t., .f.)
lcSql = loCmd.AddParameter(lcSql, "idHostAlta", ALLTRIM(SYS(0)), .t., .f.)

loCmd.ActiveConnection = goConn.ActiveConnection
loCmd.Cursor_Name = "cur_x"
loCmd.OpenQuery(lcSql)
SELECT cur_x
Thisform.idclirep = INT(VAL(cur_x.result))
loCmd.Close_Query()
Thisform.nrofiscal = ALLTRIM(Thisform.txtNumero.Value)
Thisform.razsoc = ALLTRIM(Thisform.txtRazSoc.Value)
Thisform.accept_press = .T.
MESSAGEBOX("En esta pantalla se pidieron los datos básicos con el fin de que se pueda facturar. " ;
		+ "No te olvides mejorar la carga desde el menú Archivos / Clientes.", 0+64, Thisform.Caption)
Thisform.Hide()


ENDPROC
PROCEDURE inicializar_formulario
&& Solo muestro la opción presupuestar si entra desde el módulo
&& de reparaciones.
Thisform.chkMayorista.Value = 0
IF !Thisform.ingreso_desde_fc THEN
	Thisform.chkPresupuestar.Visible = .T.
ELSE
	Thisform.chkPresupuestar.Visible = .F.
ENDIF
Thisform.sel_SitIVA.txtCodigo.Value = 1
Thisform.sel_SitIVA.txtCodigo.LostFocus()
Thisform.sel_CONDPAGO.txtCodigo.Value = 1
Thisform.sel_CONDPAGO.txtCodigo.LostFocus()
Thisform.sel_Vendedor.txtCodigo.Value = 1
Thisform.sel_Vendedor.txtCodigo.LostFocus()
Thisform.sel_transporte.txtCodigo.Value = 1
Thisform.sel_transporte.txtCodigo.LostFocus()
Thisform.sel_TIPODOC.txtCodigo.Value = "CUIT"
Thisform.sel_TIPODOC.txtCodigo.LostFocus()
Thisform.sel_TIPODOC.txtCodigo.SetFocus()
ENDPROC
PROCEDURE validar_cuit
PARAMETERS tcCUIT

LOCAL lnSuma, llRet
IF EMPTY(tcCuit)
	llRet = .T.
ELSE
	IF TYPE('tcCuit') = 'C' AND LEN(tcCuit) = 13
	  lnSuma = VAL(SUBS(tcCUIT,11,1)) * 2 + ;
		VAL(SUBS(tcCUIT,10,1)) * 3 + ;
		VAL(SUBS(tcCUIT,9,1)) * 4 + ;
		VAL(SUBS(tcCUIT,8,1)) * 5 + ;
		VAL(SUBS(tcCUIT,7,1)) * 6 + ;
		VAL(SUBS(tcCUIT,6,1)) * 7 + ;
		VAL(SUBS(tcCUIT,5,1)) * 2 + ;
		VAL(SUBS(tcCUIT,4,1)) * 3 + ;
		VAL(SUBS(tcCUIT,2,1)) * 4 + ;
		VAL(SUBS(tcCUIT,1,1)) * 5
		  llRet = VAL(SUBS(tcCUIT,13,1)) = ;
		IIF(MOD(lnSuma,11) = 0, 0, 11-MOD(lnSuma,11))
	ELSE
	  *--- No es Char o no tiene el largo correcto
	  llRet = .F.
	ENDIF
ENDIF
RETURN llRet
ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Tipo Documento:"
Height = 15
Left = 12
Top = 12
Width = 108
TabIndex = 22
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Número:"
Height = 15
Left = 12
Top = 36
Width = 108
TabIndex = 23
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Razón Social:"
Height = 15
Left = 12
Top = 61
Width = 108
TabIndex = 24
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Teléfono:"
Height = 15
Left = 12
Top = 153
Width = 108
TabIndex = 25
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Nexttel:"
Height = 15
Left = 12
Top = 177
Width = 93
TabIndex = 26
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: sel_tipoDoc
************************************************************
*** PROPIEDADES ***
Top = 7
Left = 110
TabIndex = 1
autocompletar_ceros = .F.
nombre_campo_codigo = TipoDoc
nombre_campo_desc = Descripcio
nombre_tabla = tipodoc
pkfield = idTipoDoc
Name = "sel_tipoDoc"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***
PROCEDURE recuperar_datos
SELECT tipodoc
IF tipodoc.tipodoc == "CUIT" .OR. tipodoc.tipodoc == "CUIL" THEN
	Thisform.txtNumero.InputMask = "XX-XXXXXXXX-X"
ELSE
	Thisform.txtNumero.InputMask = ""
	Thisform.txtNumero.Value = ""
ENDIF
ENDPROC


************************************************************
OBJETO: txtNumero
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 112
TabIndex = 2
Top = 33
Width = 141
Name = "txtNumero"

*** METODOS ***
PROCEDURE Valid
LOCAL loRes
LOCAL lcSql
LOCAL lnRes

IF Thisform.sel_TipoDoc.valcpoid = 1 THEN
	IF !Thisform.validar_cuit(This.Value) THEN
		MESSAGEBOX("Número de CUIT inválido", 0+48, Thisform.Caption)
		RETURN .F.
	ENDIF
ENDIF

&& Verifico si el CUIT / DNI ya se encuentra cargado en la base de datos
loRes = CREATEOBJECT("odbc_result")
TEXT TO lcSql NOSHOW
	SELECT
		CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END existe
	FROM
		clientes
	WHERE
		clientes.nroCUIT = ?nroCUIT
ENDTEXT
lcSql = loRes.AddParameter(lcSql, "nroCUIT", STRTRAN(ALLTRIM(This.Value), "-", ""), .t., .f.)
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"
loRes.OpenQuery(lcSql)
SELECT cur_x
IF IIF(TYPE("cur_x.existe") == "N", cur_x.existe, INT(VAL(cur_x.existe))) = 1 THEN
	&& Si el usuario responde NO, entonces, no dejo continuar con la
	&& grabación.
	lnRes = MESSAGEBOX("CUIT/DNI encontrado. Verifique que el cliente no se encuentre cargado." ;
			+ " ¿Desea continuar de todos modos?", 4+32, Thisform.Caption)
	IF lnRes = 7 THEN
		loRes.Close_Query()
		RETURN .F.
	ENDIF
ENDIF
loRes.Close_Query()

RETURN .T.
ENDPROC


************************************************************
OBJETO: txtRazSoc
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 112
TabIndex = 4
Top = 57
Width = 478
Name = "txtRazSoc"

*** METODOS ***


************************************************************
OBJETO: txtTeléfono
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 112
TabIndex = 7
Top = 149
Width = 224
Name = "txtTeléfono"

*** METODOS ***


************************************************************
OBJETO: txtNextel
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 112
TabIndex = 8
Top = 173
Width = 224
Name = "txtNextel"

*** METODOS ***


************************************************************
OBJETO: btnGrabar
************************************************************
*** PROPIEDADES ***
Top = 320
Left = 497
TabIndex = 18
Name = "btnGrabar"

*** METODOS ***
PROCEDURE Click
IF Thisform.validar_datos() THEN
	&& Si no ingreso desde facturación entonces cargo el cliente en
	&& clirep. En caso contrario lo cargo como cliente.
	
	&& Esto tengo que ver si no me conviene que lo meta en las dos tablas
	IF !Thisform.ingreso_desde_fc THEN
		&& En caso de que dé de alta clientes desde el módulo de reparaciones,
		&& también lo doy de alta en la tabla de clientes para que quede cargado por
		&& si tiene qeu facturar.
		Thisform.insertar_en_cliprep()
		Thisform.insertar_cliente()
	ELSE
		Thisform.insertar_cliente()
	ENDIF
ENDIF


ENDPROC


************************************************************
OBJETO: chkPresupuestar
************************************************************
*** PROPIEDADES ***
Top = 175
Left = 344
Height = 18
Width = 106
Alignment = 0
Caption = "Presupuestar"
TabIndex = 27
Name = "chkPresupuestar"

*** METODOS ***


************************************************************
OBJETO: Clscerrar1
************************************************************
*** PROPIEDADES ***
Top = 320
Left = 545
TabIndex = 19
Name = "Clscerrar1"

*** METODOS ***
PROCEDURE Click
Thisform.accept_press = .F.
Thisform.Hide()
ENDPROC


************************************************************
OBJETO: sel_SitIVA
************************************************************
*** PROPIEDADES ***
Top = 194
Left = 110
TabIndex = 9
cfieldname = idsitiva
msgerror = Debe ingresar la Situación de I.V.A.
nombre_campo_codigo = idsitiva
nombre_campo_desc = descripcio
nombre_tabla = sitiva
pkfield = idsitiva
esnumerico = .T.
Name = "sel_SitIVA"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: sel_CondPago
************************************************************
*** PROPIEDADES ***
Top = 218
Left = 110
Width = 482
Height = 25
TabIndex = 10
cfieldname = idcondpago
msgerror = Debe ingresar la Condición de Pago
nombre_campo_codigo = idcondpago
nombre_campo_desc = descripcio
nombre_tabla = condpagos
pkfield = idcondpago
requerido = .T.
esnumerico = .T.
Name = "sel_CondPago"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: chkMayorista
************************************************************
*** PROPIEDADES ***
Tag = "edit"
Top = 35
Left = 260
Height = 18
Width = 91
Alignment = 0
Caption = "Es Mayorista"
Value = 1
TabIndex = 3
cfieldname = mayorista
Name = "chkMayorista"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta6
************************************************************
*** PROPIEDADES ***
Caption = "Descuentos:"
Left = 13
Top = 247
TabIndex = 32
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: txtDesc1
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 112
TabIndex = 11
Top = 244
Width = 84
isnumeric = .T.
requerido = .F.
cfieldname = desc1
Name = "txtDesc1"

*** METODOS ***


************************************************************
OBJETO: txtDesc2
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 197
TabIndex = 12
Top = 244
Width = 84
isnumeric = .T.
requerido = .F.
cfieldname = desc2
Name = "txtDesc2"

*** METODOS ***


************************************************************
OBJETO: txtDesc3
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 282
TabIndex = 13
Top = 244
Width = 84
isnumeric = .T.
requerido = .F.
cfieldname = desc3
Name = "txtDesc3"

*** METODOS ***


************************************************************
OBJETO: txtDesc4
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 367
TabIndex = 14
Top = 244
Width = 84
isnumeric = .T.
requerido = .F.
cfieldname = desc4
Name = "txtDesc4"

*** METODOS ***


************************************************************
OBJETO: sel_transporte
************************************************************
*** PROPIEDADES ***
Top = 290
Left = 110
TabIndex = 17
cfieldname = idTransp
msgerror = Debe ingresar el Transporte
nombre_campo_codigo = codTrans
nombre_campo_desc = razSoc
nombre_tabla = transp
pkfield = idTransp
esnumerico = .T.
requerido = .T.
Name = "sel_transporte"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: sel_vendedor
************************************************************
*** PROPIEDADES ***
Top = 266
Left = 110
TabIndex = 16
cfieldname = idVendedor
msgerror = Debe ingresar el Vendedor
nombre_campo_codigo = idVendedor
nombre_campo_desc = Nombre
nombre_tabla = vendedores
pkfield = idVendedor
esnumerico = .T.
requerido = .T.
Name = "sel_vendedor"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta18
************************************************************
*** PROPIEDADES ***
Caption = "Recargos:"
Height = 15
Left = 460
Top = 248
Width = 63
TabIndex = 31
Name = "Clsetiqueta18"

*** METODOS ***


************************************************************
OBJETO: txtRecargo
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 520
TabIndex = 15
Top = 244
Width = 70
isnumeric = .T.
requerido = .F.
cfieldname = recargo
Name = "txtRecargo"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta7
************************************************************
*** PROPIEDADES ***
Caption = "Sit. I.V.A.:"
Height = 15
Left = 12
Top = 200
Width = 93
TabIndex = 33
Name = "Clsetiqueta7"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta8
************************************************************
*** PROPIEDADES ***
Caption = "Cond. Pago:"
Height = 15
Left = 12
Top = 223
Width = 93
TabIndex = 34
Name = "Clsetiqueta8"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta9
************************************************************
*** PROPIEDADES ***
Caption = "Vendedor:"
Height = 15
Left = 12
Top = 271
Width = 93
TabIndex = 35
Name = "Clsetiqueta9"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta10
************************************************************
*** PROPIEDADES ***
Caption = "Transporte"
Height = 15
Left = 12
Top = 294
Width = 93
TabIndex = 36
Name = "Clsetiqueta10"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta11
************************************************************
*** PROPIEDADES ***
Caption = "Dirección:"
Left = 12
Top = 84
TabIndex = 28
Name = "Clsetiqueta11"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta12
************************************************************
*** PROPIEDADES ***
Caption = "Código Postal:"
Left = 12
Top = 108
TabIndex = 29
Name = "Clsetiqueta12"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta13
************************************************************
*** PROPIEDADES ***
Caption = "Pcia./Pais:"
Height = 15
Left = 12
Top = 130
Width = 58
TabIndex = 30
Name = "Clsetiqueta13"

*** METODOS ***


************************************************************
OBJETO: txtDireccion
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 112
MaxLength = 60
TabIndex = 5
Top = 80
Width = 478
cfieldname = direccion
ischaracter = .T.
msgerror = Debe ingresar la Dirección
Name = "txtDireccion"

*** METODOS ***


************************************************************
OBJETO: Sel_Localid
************************************************************
*** PROPIEDADES ***
Top = 101
Left = 110
TabIndex = 6
cfieldname = idlocalid
msgerror = Debe ingresar el Código Postal
nombre_campo_codigo = codpostal
nombre_campo_desc = descripcio
nombre_tabla = localidad
pkfield = idlocalid
esnumerico = .F.
autocompletar_ceros = .F.
Name = "Sel_Localid"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***
PROCEDURE recuperar_datos
LOCAL lcSql, loPcia, loPais

SELECT localidad
lcSql = "select * from provincias where idprovin = " + ALLTRIM(STR(localidad.idprovin))
loPcia = CREATEOBJECT("odbc_Result")
loPcia.ActiveConnection = goConn.ActiveConnection
loPcia.cursor_name = "cur_pcia"
loPcia.OpenQuery(lcSql)

SELECT cur_pcia
IF RECCOUNT() > 0
	thisform.txtProvincia.Value = cur_pcia.descripcio
ENDIF

loPcia.Close_Query()

SELECT localidad
lcSql = "select * from paises where idpais = " + ALLTRIM(STR(localidad.idpais))
loPais = CREATEOBJECT("odbc_Result")
loPais.ActiveConnection = goConn.ActiveConnection
loPais.cursor_name = "cur_pais"
loPais.OpenQuery(lcSql)

SELECT cur_pais
IF RECCOUNT() > 0
	thisform.txtPais.Value = cur_pais.descripcio
ENDIF

loPais.Close_Query()
ENDPROC


************************************************************
OBJETO: txtProvincia
************************************************************
*** PROPIEDADES ***
Tag = "noedit"
Height = 21
Left = 112
ReadOnly = .T.
TabIndex = 20
TabStop = .F.
Top = 126
Width = 239
cfieldname = 
ischaracter = .T.
msgerror = 
requerido = .F.
Name = "txtProvincia"

*** METODOS ***


************************************************************
OBJETO: txtPais
************************************************************
*** PROPIEDADES ***
Tag = "noedit"
Height = 21
Left = 355
ReadOnly = .T.
TabIndex = 21
TabStop = .F.
Top = 126
Width = 235
cfieldname = 
ischaracter = .T.
msgerror = 
requerido = .F.
Name = "txtPais"

*** METODOS ***


************************************************************
OBJETO: cls_dlg_altaclirep
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


