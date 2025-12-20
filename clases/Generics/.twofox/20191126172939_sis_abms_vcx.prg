************************************************************
OBJETO: cls_abm_gtscptos
************************************************************
*** PROPIEDADES ***
ShowWindow = 1
DoCreate = .T.
Caption = "ABM Conceptos de Gastos"
MDIForm = .T.
cnombretabla = gst_cptos
listctrlsource = codGstCP,descripcio,costo
listwidthcols = 70,300,70
pk_fieldname = idGstCP
titulos_cabeceras = Código,Descripción,Costo
Name = "cls_abm_gtscptos"
Herramientas.cmdNuevo.Name = "cmdNuevo"
Herramientas.cmdEditar.Name = "cmdEditar"
Herramientas.cmdEliminar.Name = "cmdEliminar"
Herramientas.cmdCerrar.Name = "cmdCerrar"
Herramientas.cmdGrabar.Name = "cmdGrabar"
Herramientas.cmdCancelar.Name = "cmdCancelar"
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
OBJETO: CLSETIQUETA1
************************************************************
*** PROPIEDADES ***
Caption = "Código:"
Height = 15
Left = 36
Top = 27
Width = 84
Name = "CLSETIQUETA1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Descripción:"
Height = 15
Left = 36
Top = 50
Width = 84
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Costo:"
Height = 15
Left = 36
Top = 73
Width = 96
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Cuenta:"
Height = 15
Left = 36
Top = 97
Width = 84
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: txtCodigo
************************************************************
*** PROPIEDADES ***
Tag = "edit"
Enabled = .T.
Height = 21
Left = 134
MaxLength = 20
ReadOnly = .F.
Top = 23
Width = 190
cfieldname = codGstCP
msgerror = Debe ingresar el código
ischaracter = .T.
Name = "txtCodigo"

*** METODOS ***


************************************************************
OBJETO: txtDescripcion
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 134
MaxLength = 60
Top = 46
Width = 514
cfieldname = descripcio
msgerror = Debe ingresar la descripción
ischaracter = .T.
Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: txtCosto
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 134
Top = 69
Width = 100
isnumeric = .T.
cfieldname = costo
msgerror = Debe ingresar el costo
Name = "txtCosto"

*** METODOS ***


************************************************************
OBJETO: sel_cuenta
************************************************************
*** PROPIEDADES ***
Top = 90
Left = 132
cfieldname = idPlanCta
nombre_campo_codigo = codPlanCta
nombre_campo_desc = descripcio
nombre_tabla = planctas
pkfield = idPlanCta
autocompletar_ceros = .F.
requerido = .T.
msgerror = Debe vincular este gasto a la cuenta del plan de cuentas
Name = "sel_cuenta"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: cls_abm_gtscptos
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_abm_global_cfg
************************************************************
*** PROPIEDADES ***
DoCreate = .T.
Caption = "Configuración Global"
cnombretabla = global_cfg
listctrlsource = cfg_key,cfg_Type,cfg_Value
listwidthcols = 100,70,200
pk_fieldname = idGlobalCF
titulos_cabeceras = Variable,Tipo de Dato,Valor
Name = "cls_abm_global_cfg"
Herramientas.cmdNuevo.Name = "cmdNuevo"
Herramientas.cmdEditar.Name = "cmdEditar"
Herramientas.cmdEliminar.Name = "cmdEliminar"
Herramientas.cmdCerrar.Name = "cmdCerrar"
Herramientas.cmdGrabar.Name = "cmdGrabar"
Herramientas.cmdCancelar.Name = "cmdCancelar"
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
Caption = "Variable:"
Left = 24
Top = 27
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Tipo:"
Left = 24
Top = 51
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Value:"
Left = 24
Top = 75
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: txtVariable
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 108
Top = 25
Width = 180
cfieldname = cfg_Key
msgerror = Falta ingresar la variable
ischaracter = .T.
Name = "txtVariable"

*** METODOS ***


************************************************************
OBJETO: txtTipo
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 108
Top = 48
Width = 38
cfieldname = cfg_Type
msgerror = Falta ingresar el tipo
ischaracter = .T.
Name = "txtTipo"

*** METODOS ***


************************************************************
OBJETO: txtValor
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 108
Top = 71
Width = 564
cfieldname = cfg_Value
msgerror = Falta ingresar el valor
ischaracter = .T.
Name = "txtValor"

*** METODOS ***


************************************************************
OBJETO: cls_abm_global_cfg
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_abm_menues
************************************************************
*** PROPIEDADES ***
DoCreate = .T.
Caption = "Menues del Sistema"
cnombretabla = menues
listctrlsource = codMenu,nombre,procedim,enlace,orden
listwidthcols = 100,200,200,70,70
titulos_cabeceras = Código,Nombre,Proc. Ejecutar,Enlace,Orden
pk_fieldname = idMenue
Name = "cls_abm_menues"
Herramientas.cmdNuevo.Name = "cmdNuevo"
Herramientas.cmdEditar.Name = "cmdEditar"
Herramientas.cmdEliminar.Name = "cmdEliminar"
Herramientas.cmdCerrar.Name = "cmdCerrar"
Herramientas.cmdGrabar.Name = "cmdGrabar"
Herramientas.cmdCancelar.Name = "cmdCancelar"
Herramientas.CMDEXCEL.Name = "CMDEXCEL"
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
Caption = "Código:"
Left = 33
Top = 15
TabIndex = 7
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Nombre:"
Left = 33
Top = 42
TabIndex = 8
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Procedimiento:"
Left = 33
Top = 67
TabIndex = 9
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Enlace:"
Left = 33
Top = 91
TabIndex = 10
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: txtCodigo
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 134
MaxLength = 20
TabIndex = 1
Top = 12
Width = 202
ischaracter = .T.
cfieldname = codMenu
msgerror = Falta ingresar el códig
Name = "txtCodigo"

*** METODOS ***


************************************************************
OBJETO: txtNombre
************************************************************
*** PROPIEDADES ***
Format = ""
Height = 21
Left = 134
MaxLength = 60
TabIndex = 2
Top = 37
Width = 358
ischaracter = .T.
cfieldname = nombre
msgerror = Falta ingresar el nombre
Name = "txtNombre"

*** METODOS ***


************************************************************
OBJETO: txtProcedim
************************************************************
*** PROPIEDADES ***
Format = ""
Height = 21
Left = 134
MaxLength = 60
TabIndex = 3
Top = 62
Width = 358
ischaracter = .T.
cfieldname = procedim
requerido = .F.
Name = "txtProcedim"

*** METODOS ***


************************************************************
OBJETO: txtEnlace
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 134
TabIndex = 4
Top = 86
Width = 82
isinteger = .T.
cfieldname = enlace
requerido = .T.
msgerror = Falta cargar el enlace
Name = "txtEnlace"

*** METODOS ***


************************************************************
OBJETO: chkIsChild
************************************************************
*** PROPIEDADES ***
Top = 87
Left = 237
Height = 18
Width = 315
Alignment = 0
Caption = "Pertenece a un menú principal indicado en el enlace"
HelpContextID = 0
TabIndex = 5
cfieldname = isChild
Name = "chkIsChild"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Nro. Orden:"
Left = 33
Top = 114
TabIndex = 11
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: txtNroOrden
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 134
TabIndex = 6
Top = 110
Width = 82
isinteger = .T.
cfieldname = orden
requerido = .T.
msgerror = Falta ingresar en que orden debe aparecer el menu
Name = "txtNroOrden"

*** METODOS ***


************************************************************
OBJETO: cls_abm_menues
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_abm_mrcsv
************************************************************
*** PROPIEDADES ***
DoCreate = .T.
Caption = "Marcas de vehículos"
cnombretabla = marcas_v
listctrlsource = idMarcaV,descripcio
listwidthcols = 70,200
pk_fieldname = idMarcaV
titulos_cabeceras = Código Marca,Descripción
Name = "cls_abm_mrcsv"
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
Caption = "Descripción:"
Height = 15
Left = 24
Top = 27
Width = 77
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: txtDescripcion
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 105
MaxLength = 30
TabIndex = 0
Top = 22
Width = 615
ischaracter = .T.
cfieldname = descripcio
msgerror = Debe ingresar la descripción de la marca
Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: cls_abm_mrcsv
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_abm_numerador
************************************************************
*** PROPIEDADES ***
DoCreate = .T.
Caption = "Talonarios"
cnombretabla = numerador
listctrlsource = cbte,tipoDoc,ptoVta,numActual,cai,fecVto,impresora,cantCpia
listwidthcols = 70,70,70,70,70,100,150,70
titulos_cabeceras = CBTE.,Letra,Pto. Vta.,Número,CAI,Vencimiento,Impresora,Cant. Copia
pk_fieldname = idNum
autogencodigo = .F.
Name = "cls_abm_numerador"
Herramientas.cmdNuevo.Name = "cmdNuevo"
Herramientas.cmdEditar.Name = "cmdEditar"
Herramientas.cmdEliminar.Name = "cmdEliminar"
Herramientas.cmdCerrar.Name = "cmdCerrar"
Herramientas.cmdGrabar.Name = "cmdGrabar"
Herramientas.cmdCancelar.Name = "cmdCancelar"
Herramientas.CMDEXCEL.Name = "CMDEXCEL"
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
Caption = "Comprobante:"
Left = 33
Top = 16
TabIndex = 11
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Punto de Venta:"
Height = 15
Left = 33
Top = 41
Width = 89
TabIndex = 13
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Número Actual:"
Height = 15
Left = 33
Top = 64
Width = 89
TabIndex = 14
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Vencimiento:"
Height = 15
Left = 33
Top = 110
Width = 89
TabIndex = 15
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Impresora:"
Height = 15
Left = 33
Top = 134
Width = 89
TabIndex = 16
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta6
************************************************************
*** PROPIEDADES ***
Caption = "Cant. Copias:"
Height = 15
Left = 33
Top = 158
Width = 89
TabIndex = 18
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: txtCbte
************************************************************
*** PROPIEDADES ***
Left = 143
MaxLength = 3
TabIndex = 1
Top = 14
ischaracter = .T.
cfieldname = cbte
msgerror = Debe ingresar el código de comprobante
Name = "txtCbte"

*** METODOS ***


************************************************************
OBJETO: txtPtoVta
************************************************************
*** PROPIEDADES ***
Left = 143
MaxLength = 4
TabIndex = 3
Top = 37
isinteger = .T.
cfieldname = ptoVta
msgerror = Debe ingresar el punto de venta
Name = "txtPtoVta"

*** METODOS ***


************************************************************
OBJETO: txtNumActual
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 143
MaxLength = 8
TabIndex = 4
Top = 60
Width = 123
isinteger = .T.
cfieldname = numActual
requerido = .F.
Name = "txtNumActual"

*** METODOS ***


************************************************************
OBJETO: txtFecVto
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 143
TabIndex = 6
Top = 106
Width = 123
isdatetime = .T.
cfieldname = fecVto
msgerror = Debe ingresar la fecha de vencimiento
Name = "txtFecVto"

*** METODOS ***


************************************************************
OBJETO: txtCantCpias
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 143
TabIndex = 9
Top = 152
Width = 73
isinteger = .T.
cfieldname = cantCpia
requerido = .F.
Name = "txtCantCpias"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta7
************************************************************
*** PROPIEDADES ***
Caption = "Nro. C.A.I.:"
Left = 33
Top = 86
TabIndex = 19
Name = "Clsetiqueta7"

*** METODOS ***


************************************************************
OBJETO: txtNroCAI
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 143
TabIndex = 5
Top = 83
Width = 289
ischaracter = .T.
cfieldname = cai
msgerror = Debe ingresar el número de C.A.I
Name = "txtNroCAI"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta8
************************************************************
*** PROPIEDADES ***
Caption = "Letra:"
Height = 15
Left = 253
Top = 16
Width = 47
TabIndex = 12
Name = "Clsetiqueta8"

*** METODOS ***


************************************************************
OBJETO: txtTipoDoc
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 293
MaxLength = 1
TabIndex = 2
Top = 14
Width = 31
ischaracter = .T.
cfieldname = tipoDoc
msgerror = Debe ingresar el tipo de comprobante
Name = "txtTipoDoc"

*** METODOS ***


************************************************************
OBJETO: txtImpresora
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 143
TabIndex = 7
Top = 129
Width = 289
ischaracter = .T.
cfieldname = impresora
msgerror = 
requerido = .F.
Name = "txtImpresora"

*** METODOS ***


************************************************************
OBJETO: btnImpresoras
************************************************************
*** PROPIEDADES ***
Top = 128
Left = 434
Height = 23
Width = 30
Caption = "..."
TabIndex = 8
Name = "btnImpresoras"

*** METODOS ***
PROCEDURE Click
LOCAL lcPrinter

lcPrinter = GETPRINTER()

IF !EMPTY(lcPrinter) THEN
	thisform.pgf.page2.cnt_fields.txtImpresora.Value = lcPrinter
ELSE
	MESSAGEBOX("Atención, no ha seleccionado ninguna impresora", 0+64, Thisform.Caption)
ENDIF
ENDPROC


************************************************************
OBJETO: Clsetiqueta9
************************************************************
*** PROPIEDADES ***
Caption = "Cant. Copias:"
Height = 15
Left = 33
Top = 180
Width = 89
TabIndex = 17
Name = "Clsetiqueta9"

*** METODOS ***


************************************************************
OBJETO: txtHostName
************************************************************
*** PROPIEDADES ***
Tag = ""
Enabled = .F.
Height = 21
Left = 143
TabIndex = 10
Top = 175
Width = 289
ischaracter = .T.
cfieldname = impresora
msgerror = 
requerido = .F.
Name = "txtHostName"

*** METODOS ***


************************************************************
OBJETO: cls_abm_numerador
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_configurar_printer
************************************************************
*** PROPIEDADES ***
BorderStyle = 2
Height = 534
Width = 946
DoCreate = .T.
Caption = "Configuración de impresoras"
Name = "cls_configurar_printer"
contenido.Name = "contenido"

*** METODOS ***
PROCEDURE Init
SELECT cur_impresoras
Thisform.contenido.grdImpresoras.alias_name = "cur_impresoras"
Thisform.contenido.grdImpresoras.RecordSource = "cur_impresoras"
Thisform.contenido.grdImpresoras.list_controlsource = "idImpres,cbte,ptoVta,tipoDoc,impresora,hostName,copias"
Thisform.contenido.grdImpresoras.titulos_cabeceras = "#,C.B.T.E,Pto. Vta.,Letra,Impresora,Host,Copias"
Thisform.contenido.grdImpresoras.lista_ancho_cols = "50,70,70,70,200,100,70"
Thisform.contenido.grdImpresoras.generar_grid()

select cur_impresoras
GO TOP
Thisform.contenido.grdImpresoras.Refresh()

ENDPROC
PROCEDURE Load
LOCAL loRes
LOCAL loResImp
LOCAL lcSql
LOCAL lcImpresora, lnCopias, lcHostName, lnIdImpres

DODEFAULT()

CREATE CURSOR cur_impresoras ( ;
	idImpres int,;
	idNum int,;
	cbte varchar(3),;
	ptoVta varchar(4),;
	tipoDoc varchar(1),;
	hostName varchar(50),;
	impresora varchar(100),;
	copias int)	

loRes = CREATEOBJECT("odbc_result")
loResImp = CREATEOBJECT("odbc_result")
lcSql = ""
lnIdImpres = 0
lcImpresora = ""
lnCopias = 0
lcHostName = ""

lcSql = "SELECT  numerador.idNum, "
lcSql = lcSql + "numerador.cbte, "
lcSql = lcSql + "numerador.ptoVta, "
lcSql = lcSql + "numerador.tipoDoc "
lcSql = lcSql + "FROM numerador "

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_temp"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN
ENDIF

SELECT cur_temp
GO TOP

DO WHILE !EOF("cur_temp")
	lcSql = "SELECT * "
	lcSql = lcSql + "FROM impresoras "
	lcSql = lcSql + "WHERE impresoras.hostName = '" + ALLTRIM(SYS(0)) + "' "
	lcSql = lcSql + "	AND impresoras.idNum = " + ALLTRIM(STR(cur_temp.idNum))
	
	loResImp.ActiveConnection = goConn.ActiveConnection
	loResImp.Cursor_Name = "cur_x"
	
	IF !loResImp.OpenQuery(lcSql) THEN
		MESSAGEBOX(loResImp.Error_Message, 0+48,  Thisform.Caption)
		RETURN
	ENDIF
	
	SELECT cur_x
	IF RECCOUNT("cur_x") = 0 THEN
		lnIdImpres = 0
		lcImpresora = ""
		lnCopias = 0
		lcHostName = ""
	ELSE
		lnIdImpres = cur_x.idImpres
		lcImpresora = IIF(ISNULL(cur_x.impresora), "", cur_x.impresora)
		lnCopias = IIF(ISNULL(cur_x.copias), 0, cur_x.copias)
		lcHostName = IIF(ISNULL(cur_x.hostName), "", cur_x.hostName)
	ENDIF
	
	loResImp.Close_Query()
	
	SELECT cur_impresoras
	APPEND BLANK
	REPLACE cur_impresoras.idImpres WITH lnIdImpres
	REPLACE cur_impresoras.idNum WITH cur_temp.idNum ADDITIVE
	REPLACE cur_impresoras.cbte WITH cur_temp.cbte ADDITIVE
	REPLACE cur_impresoras.ptoVta WITH REPLICATE("0", 4 - LEN(ALLTRIM(STR(cur_temp.ptoVta)))) + ALLTRIM(STR(cur_temp.ptoVta)) ADDITIVE
	REPLACE cur_impresoras.tipoDoc WITH cur_temp.tipoDoc ADDITIVE
	REPLACE cur_impresoras.hostName WITH ALLTRIM(lcHostName) ADDITIVE
	REPLACE cur_impresoras.impresora WITH ALLTRIM(lcImpresora) ADDITIVE
	REPLACE cur_impresoras.copias WITH lnCopias ADDITIVE

	SELECT cur_temp
	SKIP
ENDDO

loRes.Close_Query()
ENDPROC


************************************************************
OBJETO: grdImpresoras
************************************************************
*** PROPIEDADES ***
Height = 395
Left = 6
TabIndex = 1
Top = 5
Width = 938
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdImpresoras"
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
PROCEDURE AfterRowColChange
LPARAMETERS nColIndex

SELECT cur_impresoras
Thisform.contenido.txtImpresora.Value = cur_impresoras.impresora
Thisform.contenido.txtCopias.Value = cur_impresoras.copias
ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Impresora:"
Height = 15
Left = 13
Top = 419
Width = 72
TabIndex = 7
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Copias:"
Height = 15
Left = 13
Top = 444
Width = 72
TabIndex = 8
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: txtImpresora
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 85
TabIndex = 2
Top = 416
Width = 396
ischaracter = .T.
Name = "txtImpresora"

*** METODOS ***


************************************************************
OBJETO: txtCopias
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 85
TabIndex = 4
Top = 440
Width = 84
isinteger = .T.
Name = "txtCopias"

*** METODOS ***


************************************************************
OBJETO: btnBuscar
************************************************************
*** PROPIEDADES ***
Top = 415
Left = 483
Height = 25
Width = 34
Caption = "..."
TabIndex = 3
Name = "btnBuscar"

*** METODOS ***
PROCEDURE Click
LOCAL lcPrinter

lcPrinter = GETPRINTER()

IF !EMPTY(lcPrinter) THEN
	Thisform.contenido.txtImpresora.Value = ALLTRIM(lcPrinter)
ELSE
	MESSAGEBOX("Atención, no ha seleccionado ninguna impresora", 0+64, Thisform.Caption)
ENDIF
ENDPROC


************************************************************
OBJETO: btnGrabar
************************************************************
*** PROPIEDADES ***
Top = 481
Left = 847
TabIndex = 5
Name = "btnGrabar"

*** METODOS ***
PROCEDURE Click
LOCAL loCommand
LOCAL lcSql
LOCAL lnProxID

loCommand = CREATEOBJECT("odbc_command")
lcSql = ""
lnProxID = 0

IF ALLTRIM(Thisform.Contenido.txtImpresora.Value) == "" THEN
	MESSAGEBOX("No ha ingresado la impresora", 0+48, Thisform.Caption)
	RETURN
ENDIF

goConn.BeginTransaction()

IF cur_impresoras.idImpres = 0 THEN
	lnProxID = goConn.GetNextID("impresoras", "idImpres")

	lcSql = "INSERT INTO impresoras ("
	lcSql = lcSql + "idImpres, idNum, hostName, impresora, copias) "
	lcSql = lcSql + "VALUES (" + ALLTRIM(STR(lnProxID)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_impresoras.idNum)) + ", "
	lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "', "
	lcSql = lcSql + "'" + STRTRAN(ALLTRIM(Thisform.Contenido.txtImpresora.Value), "\", "\\") + "', "
	lcSql = lcSql + ALLTRIM(STR(Thisform.contenido.txtCopias.Value)) + ")"
ELSE
	lcSql = "UPDATE impresoras "
	lcSql = lcSql + "SET impresora = '" + STRTRAN(ALLTRIM(Thisform.Contenido.txtImpresora.Value), "\", "\\") + "', "
	lcSql = lcSql + "	hostName = '" + ALLTRIM(SYS(0)) + "', "
	lcSql = lcSql + "	copias = " + ALLTRIM(STR(Thisform.Contenido.txtCopias.Value)) + " "
	lcSql = lcSql + "WHERE idImpres = " + ALLTRIM(STR(cur_impresoras.idImpres))
	_cliptext = lcSql
ENDIF

loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = lcSql

IF !loCommand.Execute() THEN
	goConn.Rollback()
	MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
	RETURN
ENDIF

goConn.Commit()

&& Actualizo la interfaz
SELECT cur_impresoras
LOCK()
REPLACE cur_impresoras.impresora WITH ALLTRIM(Thisform.Contenido.txtImpresora.Value)
REPLACE cur_impresoras.copias WITH Thisform.contenido.txtCopias.Value
UNLOCK


ENDPROC


************************************************************
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 481
Left = 895
TabIndex = 6
Name = "btnCerrar"

*** METODOS ***


************************************************************
OBJETO: cls_configurar_printer
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_abm_articulo
************************************************************
*** PROPIEDADES ***
BorderStyle = 2
Height = 564
Width = 993
DoCreate = .T.
Caption = "ABM de Artículos"
MinButton = .T.
WindowState = 0
idarticulo = 0
listctrlsource = Codart,Descripcio
listwidthcols = 150,400
titulos_cabeceras = Código,Descripción
pk_fieldname = idarticulo
cnombretabla = articulos
Name = "cls_abm_articulo"
HERRAMIENTAS.CMDNUEVO.Name = "CMDNUEVO"
HERRAMIENTAS.CMDEDITAR.Name = "CMDEDITAR"
HERRAMIENTAS.CMDELIMINAR.Name = "CMDELIMINAR"
HERRAMIENTAS.CMDCERRAR.Top = 1
HERRAMIENTAS.CMDCERRAR.Left = 944
HERRAMIENTAS.CMDCERRAR.Name = "CMDCERRAR"
HERRAMIENTAS.CMDGRABAR.Name = "CMDGRABAR"
HERRAMIENTAS.CMDCANCELAR.Name = "CMDCANCELAR"
HERRAMIENTAS.CMDEXCEL.Name = "CMDEXCEL"
HERRAMIENTAS.Top = 1
HERRAMIENTAS.Left = 2
HERRAMIENTAS.Width = 987
HERRAMIENTAS.Height = 36
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
PGF.Page1.GRDDATOS.Height = 475
PGF.Page1.GRDDATOS.Left = 2
PGF.Page1.GRDDATOS.Top = 3
PGF.Page1.GRDDATOS.Width = 982
PGF.Page1.GRDDATOS.Name = "GRDDATOS"
PGF.Page1.Name = "Page1"
PGF.Page2.CNT_FIELDS.Top = 7
PGF.Page2.CNT_FIELDS.Left = 9
PGF.Page2.CNT_FIELDS.Width = 975
PGF.Page2.CNT_FIELDS.Height = 486
PGF.Page2.CNT_FIELDS.Name = "CNT_FIELDS"
PGF.Page2.Name = "Page2"
PGF.Top = 38
PGF.Left = 2
PGF.Width = 991
PGF.Height = 524
PGF.Name = "PGF"

*** METODOS ***
PROCEDURE calcular_precios
LOCAL ln_prlista, ln_bonif1, ln_bonif2, ln_bonif3, ln_bonif4, ln_costo
LOCAL ln_aliciva, ln_margenmax, ln_margenmin, ln_prventamax, ln_prventamin, ln_prfinalmax, ln_prfinalmin

ln_costo = 0.00
ln_prventamax = 0.00
ln_prventamin = 0.00
ln_prfinalmax = 0.00
ln_prfinalmin = 0.00

WITH Thisform.pgf.page2.cnt_fields.internalPgf.page1
	ln_prlista 		= .txtPrLista.value
	ln_bonif1 		= .txtBonif1.value
	ln_bonif2 		= .txtBonif2.value
	ln_bonif3 		= .txtBonif3.value
	ln_bonif4 		= .txtBonif4.value
	ln_aliciva 	 	= Thisform.pgf.page2.cnt_fields.txtAlicIVA.Value
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

Thisform.pgf.page2.cnt_fields.internalPgf.page1.txtCostoRep.Value = ROUND(ln_costo, 2)
Thisform.pgf.page2.cnt_fields.internalPgf.page1.txtPrVentaMax.Value = ROUND(ln_prventamax , 2)
Thisform.pgf.page2.cnt_fields.internalPgf.page1.txtPrVentaMin.Value = ROUND(ln_prventamin , 2)
Thisform.pgf.page2.cnt_fields.internalPgf.page1.txtPrFinalMax.Value = ROUND(ln_prfinalmax , 2)
Thisform.pgf.page2.cnt_fields.internalPgf.page1.txtPrFinalMin.Value = ROUND(ln_prfinalmin , 2)

ENDPROC
PROCEDURE cambiar_estado_2
PARAMETERS tl_Estado

Thisform.Pgf.Page2.cnt_fields.InternalPgf.Enabled = .T.
Thisform.Pgf.Page2.cnt_fields.InternalPgf.Page1.Enabled = .T.
Thisform.Pgf.Page2.cnt_fields.InternalPgf.Page2.Enabled = .T.
Thisform.Pgf.Page2.cnt_fields.InternalPgf.Page3.Enabled = .T.
Thisform.Pgf.Page2.cnt_fields.InternalPgf.Page4.Enabled = .T.
Thisform.Pgf.Page2.cnt_fields.InternalPgf.Page5.Enabled = .T.

WITH Thisform.Pgf.Page2.cnt_Fields.InternalPgf.Page1
	FOR EACH ctrl IN .Controls
		ctrl.Enabled = IIF(ALLTRIM(ctrl.Tag)=="no_edit", tl_Estado, !tl_Estado)
	ENDFOR
ENDWITH

WITH Thisform.Pgf.Page2.cnt_Fields.InternalPgf.Page2
	FOR EACH ctrl IN .Controls
		ctrl.Enabled = IIF(ALLTRIM(ctrl.Tag)=="no_edit", tl_Estado, !tl_Estado)
	ENDFOR
ENDWITH

WITH thisform.Pgf.Page2.cnt_Fields.InternalPgf.Page3
	FOR EACH ctrl IN .Controls
		ctrl.Enabled = IIF(ALLTRIM(ctrl.Tag)=="no_edit", tl_Estado, !tl_Estado)
	ENDFOR	
ENDWITH

WITH Thisform.Pgf.Page2.cnt_Fields.InternalPgf.Page4
	FOR EACH ctrl IN .Controls
		ctrl.Enabled = IIF(ALLTRIM(ctrl.Tag)=="no_edit", tl_Estado, !tl_Estado)
	ENDFOR
ENDWITH

WITH thisform.Pgf.Page2.cnt_Fields.InternalPgf.Page5
	FOR EACH ctrl IN .Controls
		ctrl.Enabled = IIF(ALLTRIM(ctrl.Tag)=="no_edit", tl_Estado, !tl_Estado)
	ENDFOR	
ENDWITH
ENDPROC
PROCEDURE grabar_codiart
LOCAL lcSql, loCommand, lnProxID

lcSql = ""
lnProxID = 0
loCommand = CREATEOBJECT("odbc_command")

SELECT cur_codiart
IF RECCOUNT("cur_codiart") > 0 THEN
	GO TOP
ENDIF

goConn.BeginTransaction()
lcSql = "delete from codiart where idArticulo = " + ALLTRIM(STR(cur_tempo.idArticulo))
loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = lcSql

IF !loCommand.Execute() THEN
	goConn.Rollback()
	RETURN .F.
ENDIF

SELECT cur_codiart
DO WHILE !EOF("cur_codiart")
	lnProxID = goConn.GetNextID("codiart", "idCodArt")
	
	lcSql = "insert into codiart ("
	lcSql = lcSql + "idCodArt, idArticulo, codArt, codigos, tipo, cantiDesp, procesado, circuito) "
	lcSql = lcSql + "values ( "
	lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_codiart.idArticulo)) + ", "
	lcSql = lcsql + "'" + ALLTRIM(cur_codiart.codArt) + "', "
	lcSql = lcSql + "'" + ALLTRIM(cur_codiart.codigos) + "', "
	lcSql = lcSql + "'" + ALLTRIM(cur_codiart.tipo) + "', "
	lcSql = lcSql + ALLTRIM(STR(cur_codiart.cantiDesp, 10, 2)) + ", "
	lcSql = lcSql + "1, '" + ALLTRIM(cur_codiart.circuito) + "')"
	
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.execute() THEN
		goConn.Rollback()
		RETURN .F.
	ENDIF

	SELECT cur_codiart
	SKIP
ENDDO

goConn.Commit()

RETURN .T.
ENDPROC
PROCEDURE asignar_marcas_v
LOCAL loCommand
LOCAL lcSql

loCommand = CREATEOBJECT("odbc_command")
lcSql = ""

lcSql = "delete from art_mrv where idArticulo = " + ALLTRIM(STR(Thisform.idarticulo))
loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = lcSql

IF !loCommand.Execute() THEN
	MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_mrcsv
GO TOP

DO WHILE !EOF("cur_mrcsv")
	lcSql = "insert into art_mrv ("
	lcSql = lcSql + "idMarcaV, "
	lcSql = lcSql + "idArticulo) "
	lcSql = lcSql + "VALUES ( "
	lcSql = lcSql + ALLTRIM(STR(cur_mrcsv.idMarcaV)) + ", "
	lcSql = lcSql + ALLTRIM(STR(Thisform.idarticulo)) + ")"

	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute() THEN
		MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
		RETURN .F.
	ENDIF

	SELECT cur_mrcsv
	SKIP
ENDDO

RETURN .T.
ENDPROC
PROCEDURE configurargrilla
DODEFAULT()
SELECT cur_codiart
thisform.pgf.page2.cnt_fields.internalpgf.page3.grdCodigos.alias_name = "cur_codiart"
thisform.pgf.page2.cnt_fields.internalpgf.page3.grdCodigos.RecordSource = "cur_codiart"
thisform.pgf.page2.cnt_fields.internalpgf.page3.grdCodigos.list_controlsource = "circuito,tipo,codigos,cantiDesp"
thisform.pgf.page2.cnt_fields.internalpgf.page3.grdCodigos.lista_ancho_cols = "50,50,200,70"
thisform.pgf.page2.cnt_fields.internalpgf.page3.grdCodigos.titulos_cabeceras = "Circuito,Tipo,Código,Cantidad"
thisform.pgf.page2.cnt_fields.internalpgf.page3.grdCodigos.generar_grid()
ENDPROC
PROCEDURE Init
&& Inicializo los objetos de equivalencias

thisform.equivalencias.crear_cursor()
SELECT cur_artequiv
thisform.pgf.page2.cnt_fields.internalPgf.page4.grdEquivs.alias_name = "cur_artequiv"
thisform.pgf.page2.cnt_fields.internalPgf.page4.grdEquivs.RecordSource = "cur_artequiv"
thisform.pgf.page2.cnt_fields.internalPgf.page4.grdEquivs.titulos_cabeceras = "Código,Descripción"
thisform.pgf.page2.cnt_fields.internalPgf.page4.grdEquivs.lista_ancho_cols = "100,500"
thisform.pgf.page2.cnt_fields.internalPgf.page4.grdEquivs.list_controlsource = "codArt,descripcio"
thisform.pgf.page2.cnt_fields.internalPgf.page4.grdEquivs.generar_grid()

SELECT cur_mrcsv
thisform.pgf.page2.cnt_fields.internalPgf.page5.grdMarcasV.alias_name = "cur_mrcsv"
thisform.pgf.page2.cnt_fields.internalPgf.page5.grdMarcasV.RecordSource = "cur_mrcsv"
thisform.pgf.page2.cnt_fields.internalPgf.page5.grdMarcasV.titulos_cabeceras = "Código,Descripción"
thisform.pgf.page2.cnt_fields.internalPgf.page5.grdMarcasV.lista_ancho_cols = "100,250"
thisform.pgf.page2.cnt_fields.internalPgf.page5.grdMarcasV.list_controlsource = "idMarcaV,descripcio"
thisform.pgf.page2.cnt_fields.internalPgf.page5.grdMarcasV.generar_grid()

DODEFAULT()

WITH thisform.pgf.page2.cnt_fields.internalPgf.page1
	.cmbTipoMon.AddItem("PSO")
	.cmbTipoMon.AddItem("DOL")
	.cmbTipoMon.AddItem("EUR")
	.cmbTipoMon.ListIndex = 1
ENDWITH

WITH thisform.pgf.page2.cnt_fields.InternalPgf.page3
	.cboCircuito.AddItem("V")	&& Circuito de Ventas
	.cboCircuito.AddItem("C")	&& Circuito de Compras
	.cboCircuito.AddItem("CV")	&& Circuito de Ventas y Compras
	
	.cboTipo.AddItem("CP")		&& Código de Pack
	.cboTipo.AddItem("CO")		&& Código de Original
	.cboTipo.AddItem("CB")		&& Código de Barra
	
	.cboCircuito.ListIndex = 1
	.cboTipo.ListIndex = 1
ENDWITH

ENDPROC
PROCEDURE validardatos
DODEFAULT()

IF Thisform.Pgf.Page2.cnt_Fields.sel_Familia.txtCodigo.Value = 0 THEN
	RETURN .F.
ENDIF

IF Thisform.Pgf.Page2.cnt_FIELDS.sel_SubFamilia.txtCodigo.Value = 0 THEN
	RETURN .F.
ENDIF

IF Thisform.Pgf.Page2.cnt_Fields.sel_Marca.txtCodigo.Value = 0 THEN
	RETURN .F.
ENDIF

IF Thisform.Pgf.Page2.cnt_Fields.sel_Proveedor.txtCodigo.Value = 0 THEN
	RETURN .F.
ENDIF

RETURN .T.


ENDPROC
PROCEDURE validar_eliminar
&& Valida si el artículo está siendo utilizado
&& en alguna tabla relacional

LOCAL loData, lcSql

loData = CREATEOBJECT("odbc_result")

lcSql = "select idArticulo from ventasdet where idArticulo = " + ALLTRIM(STR(cur_Tempo.idarticulo))

loData.ActiveConnection = goConn.ActiveConnection
loData.Cursor_Name = "cur_Det"
loData.OpenQuery(lcSql)

SELECT cur_Det
IF RECCOUNT() > 0
	MESSAGEBOX("No se puede eliminar este artículo debido a que tiene comprobantes vinculados", 0+64, Thisform.Caption)
	RETURN .F.
ENDIF

loData.Close_Query()

RETURN .T.

ENDPROC
PROCEDURE recuperardatos
LOCAL lcReferencia, lnCont, lcFieldName
LOCAL lcSql, loResult

DODEFAULT()

lcSql = ""
loResult = CREATEOBJECT("odbc_result")

DIMENSION laCampos[1]

&&Recupero los datos de la solapa "Precios"
SELECT cur_Tempo

WITH Thisform.Pgf.Page2.cnt_fields.internalPgf.page1
	lnCont = AFIELDS(laCampos)
	
	FOR i = 1 TO lnCont
		FOR EACH ctrl IN .Controls
			lcFieldName = laCampos[i, 1]
			lcReferencia = "cur_Tempo." + ALLTRIM(lcFieldName)

			DO CASE 
				CASE LOWER(ctrl.BaseClass) == "textbox"
					IF LOWER(ALLTRIM(ctrl.cFieldName)) == LOWER(ALLTRIM(lcFieldName))
						ctrl.value = &lcReferencia
					ENDIF			
				CASE LOWER(ctrl.BaseClass) == "combobox"
					IF LOWER(ALLTRIM(ctrl.cFieldName)) == LOWER(ALLTRIM(lcFieldName))
						ctrl.value = &lcReferencia
					ENDIF			
				CASE LOWER(ctrl.BaseClass) == "editbox"
					IF LOWER(ALLTRIM(ctrl.cFieldName)) == LOWER(ALLTRIM(lcFieldName))
						ctrl.value = &lcReferencia
					ENDIF			
				CASE LOWER(ctrl.BaseClass) == "checkbox"
					IF LOWER(ALLTRIM(ctrl.cFieldName)) == LOWER(ALLTRIM(lcFieldName))
						ctrl.value = &lcReferencia
					ENDIF
				CASE LOWER(ctrl.BaseClass) == "container" .And. ALLTRIM(ctrl.Tag) == "edit"
					IF LOWER(ALLTRIM(ctrl.cFieldName)) == LOWER(ALLTRIM(lcFieldName))
						ctrl.SetValue(&lcReferencia)
					ENDIF
			ENDCASE
		ENDFOR
	ENDFOR
ENDWITH


&&Recupero los datos de la solapa "Observaciones"
SELECT cur_Tempo

WITH Thisform.Pgf.Page2.cnt_fields.internalPgf.page2
	lnCont = AFIELDS(laCampos)
	
	FOR i = 1 TO lnCont
		FOR EACH ctrl IN .Controls
			lcFieldName = laCampos[i, 1]
			lcReferencia = "cur_Tempo." + ALLTRIM(lcFieldName)

			DO CASE 
				CASE LOWER(ctrl.BaseClass) == "textbox"
					IF LOWER(ALLTRIM(ctrl.cFieldName)) == LOWER(ALLTRIM(lcFieldName)) THEN
						ctrl.value = &lcReferencia
					ENDIF			
				CASE LOWER(ctrl.BaseClass) == "combobox"
					IF LOWER(ALLTRIM(ctrl.cFieldName)) == LOWER(ALLTRIM(lcFieldName)) THEN
						ctrl.value = &lcReferencia
					ENDIF			
				CASE LOWER(ctrl.BaseClass) == "editbox"
					IF LOWER(ALLTRIM(ctrl.cFieldName)) == LOWER(ALLTRIM(lcFieldName)) THEN
						ctrl.value = &lcReferencia
					ENDIF			
				CASE LOWER(ctrl.BaseClass) == "checkbox"
					IF LOWER(ALLTRIM(ctrl.cFieldName)) == LOWER(ALLTRIM(lcFieldName)) THEN
						ctrl.value = &lcReferencia
					ENDIF
				CASE LOWER(ctrl.BaseClass) == "container" .And. ALLTRIM(ctrl.Tag) == "edit"
					IF LOWER(ALLTRIM(ctrl.cFieldName)) == LOWER(ALLTRIM(lcFieldName)) THEN
						ctrl.SetValue(&lcReferencia)
					ENDIF
			ENDCASE
		ENDFOR
	ENDFOR
ENDWITH

&& Recupero la imagen

IF !ISNULL(cur_Tempo.linkfoto) THEN
	Thisform.Pgf.page2.cnt_Fields.picFoto.Picture = STRTRAN(cur_Tempo.linkfoto, "\\", "\")
	
	IF INT(VAL(getconfig("SQLSRV"))) = 1 THEN	
		Thisform.Pgf.Page2.cnt_Fields.txtPathFoto.Value = STRTRAN(cur_Tempo.linkfoto, "\\", "\")
	ELSE
		&& Si no anda volver a como estaba
		*Thisform.Pgf.Page2.cnt_Fields.txtPathFoto.Value = STRTRAN(cur_Tempo.linkfoto, "\", "\\")
		Thisform.Pgf.Page2.cnt_fields.txtPathFoto.Value = cur_Tempo.linkfoto
	ENDIF
ELSE
	Thisform.Pgf.page2.cnt_Fields.picFoto.Picture = ""
ENDIF

&& Recupero los datos correspondiente al codiart

SELECT cur_codiart
ZAP

lcSql = "select * from codiart where idArticulo = " + ALLTRIM(STR(cur_tempo.idArticulo))

loResult.ActiveConnection = goConn.ActiveConnection
loResult.cursor_name = "cur_ca"

IF !loResult.OpenQuery(lcSql) THEN
	MESSAGEBOX(loResult.Error_Message, 0+48, Thisform.Caption)
	RETURN
ENDIF

SELECT cur_ca
DO WHILE !EOF("cur_ca")
	SELECT cur_codiart
	APPEND BLANK
	REPLACE cur_codiart.idCodiArt WITH cur_ca.idCodArt
	REPLACE cur_codiart.idArticulo WITH cur_ca.idArticulo ADDITIVE
	REPLACE cur_codiart.codArt WITH cur_ca.codArt ADDITIVE
	REPLACE cur_codiart.codigos WITH cur_ca.codigos ADDITIVE
	REPLACE cur_codiart.tipo WITH cur_ca.tipo ADDITIVE
	REPLACE cur_codiart.cantiDesp WITH cur_ca.cantiDesp ADDITIVE
	REPLACE cur_codiart.circuito WITH cur_ca.circuito ADDITIVE

	SELECT cur_ca
	SKIP
ENDDO

loResult.Close_Query()

SELECT cur_codiart
IF RECCOUNT("cur_codiart") > 0 THEN
	GO TOP 
ENDIF

&& Recupero las marcas de vehículos que aplica el artículo
lcSql = "SELECT marcas_v.* FROM marcas_v "
lcSql = lcSql + "INNER JOIN art_mrv ON marcas_v.idMarcaV = art_mrv.idMarcaV "
lcSql = lcSql + "WHERE art_mrv.idArticulo = " + ALLTRIM(STR(cur_tempo.idArticulo))

loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_x"

IF !loResult.OpenQuery(lcSql) THEN
	MESSAGEBOX(loResult.ErrorMessage, 0+48, Thisform.Caption)
	RETURN
ENDIF

SELECT cur_mrcsv
ZAP

SELECT cur_x
GO TOP

DO WHILE !EOF("cur_x")
	SELECT cur_mrcsv
	APPEND BLANK
	REPLACE cur_mrcsv.idMarcaV WITH cur_x.idMarcaV
	REPLACE cur_mrcsv.descripcio WITH ALLTRIM(cur_x.descripcio) ADDITIVE

	SELECT cur_x
	SKIP
ENDDO

loResult.Close_Query()
SELECT cur_mrcsv
GO TOP

Thisform.Pgf.Page2.cnt_fields.internalPgf.Page5.grdMarcasV.Refresh()
Thisform.pgf.page2.cnt_fields.internalpgf.page3.grdCodigos.Refresh()
Thisform.idarticulo = cur_Tempo.idArticulo
Thisform.equivalencias.idartic_a = cur_Tempo.idArticulo
Thisform.equivalencias.leer_equivs()
Thisform.pgf.page2.cnt_fields.internalPgf.page4.grdEquivs.Refresh()

SELECT cur_tempo

&& Al recuperar los datos, si estoy bajo mysql tengo que reemplazar las \ del path por \\
*IF INT(VAL(getConfig("SQLSRV"))) = 0 THEN
*	thisform.pgf.page2.cnt_fields.txtPathFoto.Value = STRTRAN(thisform.pgf.page2.cnt_fields.txtPathFoto.Value, "\", "\\")
*ENDIF

*DODEFAULT()

ENDPROC
PROCEDURE blanquear
DODEFAULT()

WITH Thisform.Pgf.Page2.cnt_fields.internalPgf.page1
	FOR EACH ctrl IN .Controls
		DO CASE
			CASE LOWER(ctrl.BaseClass) == "textbox"
				ctrl.Blanquear()

				IF ctrl.TabIndex = 1
					ctrl.SetFocus()
				ENDIF
			CASE LOWER(ctrl.BaseClass) == "editbox"
				ctrl.Blanquear()

				IF ctrl.TabIndex = 1
					ctrl.SetFocus()
				ENDIF
			CASE LOWER(ctrl.BaseClass) == "selector_tabla"
				ctrl.Blanquear()

				IF ctrl.TabIndex = 1
					ctrl.SetFocus()
				ENDIF
			CASE LOWER(ctrl.BaseClass) == "checkbox"
				ctrl.value = 0

				IF ctrl.TabIndex = 1
					ctrl.SetFocus()
				ENDIF
			CASE LOWER(ctrl.BaseClass) == "container" .and. LOWER(ctrl.Tag) == "edit"
				ctrl.Blanquear()
				IF ctrl.TabIndex = 1
					ctrl.SetFocus()
				ENDIF
			CASE LOWER(ctrl.BaseClass) == "image"
				ctrl.picture = ""
		ENDCASE
		
	ENDFOR
ENDWITH


WITH Thisform.Pgf.Page2.cnt_fields.internalPgf.page2
	FOR EACH ctrl IN .Controls
		DO CASE
			CASE LOWER(ctrl.BaseClass) == "textbox"
				ctrl.Blanquear()

				IF ctrl.TabIndex = 1
					ctrl.SetFocus()
				ENDIF
			CASE LOWER(ctrl.BaseClass) == "editbox"
				ctrl.Blanquear()

				IF ctrl.TabIndex = 1
					ctrl.SetFocus()
				ENDIF
			CASE LOWER(ctrl.BaseClass) == "selector_tabla"
				ctrl.Blanquear()

				IF ctrl.TabIndex = 1
					ctrl.SetFocus()
				ENDIF
			CASE LOWER(ctrl.BaseClass) == "checkbox"
				ctrl.value = 0

				IF ctrl.TabIndex = 1
					ctrl.SetFocus()
				ENDIF
			CASE LOWER(ctrl.BaseClass) == "container" .and. LOWER(ctrl.Tag) == "edit"
				ctrl.Blanquear()
				IF ctrl.TabIndex = 1
					ctrl.SetFocus()
				ENDIF
			CASE LOWER(ctrl.BaseClass) == "image"
				ctrl.picture = ""
		ENDCASE
	ENDFOR
ENDWITH

WITH Thisform.Pgf.Page2.cnt_fields.internalPgf.page3
	FOR EACH ctrl IN .Controls
		DO CASE
			CASE LOWER(ctrl.BaseClass) == "textbox"
				ctrl.Blanquear()

				IF ctrl.TabIndex = 1
					ctrl.SetFocus()
				ENDIF
			CASE LOWER(ctrl.BaseClass) == "editbox"
				ctrl.Blanquear()

				IF ctrl.TabIndex = 1
					ctrl.SetFocus()
				ENDIF
			CASE LOWER(ctrl.BaseClass) == "selector_tabla"
				ctrl.Blanquear()

				IF ctrl.TabIndex = 1
					ctrl.SetFocus()
				ENDIF
			CASE LOWER(ctrl.BaseClass) == "checkbox"
				ctrl.value = 0

				IF ctrl.TabIndex = 1
					ctrl.SetFocus()
				ENDIF
			CASE LOWER(ctrl.BaseClass) == "container" .and. LOWER(ctrl.Tag) == "edit"
				ctrl.Blanquear()
				IF ctrl.TabIndex = 1
					ctrl.SetFocus()
				ENDIF
			CASE LOWER(ctrl.BaseClass) == "image"
				ctrl.picture = ""
		ENDCASE
	ENDFOR
ENDWITH

ENDPROC
PROCEDURE asignarcampos
LOCAL i, cRef, cBaseClass
LOCAL lcFoto

i = 0
cRef = ""
cBaseClass = ""

DODEFAULT()

&& Formateo la ruta de la foto para que no saque las barras al editar
lcFoto = STRTRAN(ALLTRIM(Thisform.Pgf.Page2.cnt_fields.txtPathFoto.Value), "\", "\\")
Thisform.object_dataservice.linkfoto = lcFoto

&&Asigno los campos de la solapa "Precios"
FOR i = 1 TO Thisform.Pgf.page2.cnt_fields.internalPgf.page1.ControlCount
	cBaseClass = LOWER(ALLTRIM(Thisform.Pgf.page2.cnt_fields.internalPgf.page1.Controls[i].BaseClass))
	
	IF ALLTRIM(cBaseClass) == "textbox" .OR. ALLTRIM(cBaseClass) == "editbox" .OR. ;
			ALLTRIM(cBaseClass) == "checkbox"

		cRef = "Thisform.Object_DataService." + ALLTRIM(Thisform.Pgf.page2.cnt_fields.internalPgf.page1.Controls[i].cFieldName)
		&cRef = Thisform.Pgf.page2.cnt_fields.internalPgf.page1.Controls[i].value
	ENDIF
	
	IF LOWER(ALLTRIM(Thisform.Pgf.page2.cnt_fields.internalPgf.page1.Controls[i].Class)) == "selector_tabla"
		cRef = "Thisform.Object_DataService." + ALLTRIM(Thisform.Pgf.page2.cnt_fields.internalPgf.page1.Controls[i].cFieldName)
		&cRef = Thisform.Pgf.page2.cnt_fields.internalPgf.page1.Controls[i].ValCpoID
	ENDIF
ENDFOR

&&Asigno los campos de la solapa "Observaciones"
FOR i = 1 TO Thisform.Pgf.page2.cnt_fields.internalPgf.page2.ControlCount
	cBaseClass = LOWER(ALLTRIM(Thisform.Pgf.page2.cnt_fields.internalPgf.page2.Controls[i].BaseClass))
	
	IF ALLTRIM(cBaseClass) == "textbox" .OR. ALLTRIM(cBaseClass) == "editbox" .OR. ;
			ALLTRIM(cBaseClass) == "checkbox"

		cRef = "Thisform.Object_DataService." + ALLTRIM(Thisform.Pgf.page2.cnt_fields.internalPgf.page2.Controls[i].cFieldName)
		
		IF ALLTRIM(thisform.pgf.page2.cnt_fields.internalPgf.page2.Controls[i].name) == "txtObserv" THEN
			&cRef = ""
		ENDIF
		
		&cRef = Thisform.Pgf.page2.cnt_fields.internalPgf.page2.Controls[i].value
	ENDIF
	
	IF LOWER(ALLTRIM(Thisform.Pgf.page2.cnt_fields.internalPgf.page2.Controls[i].Class)) == "selector_tabla"
		cRef = "Thisform.Object_DataService." + ALLTRIM(Thisform.Pgf.page2.cnt_fields.internalPgf.page2.Controls[i].cFieldName)
		&cRef = Thisform.Pgf.page2.cnt_fields.internalPgf.page2.Controls[i].ValCpoID
	ENDIF
ENDFOR


ENDPROC
PROCEDURE actualizar_cursor
DODEFAULT()
SELECT cur_Tempo
LOCK()
REPLACE cur_Tempo.observ		WITH ""
REPLACE cur_Tempo.prListaExt 	WITH Thisform.Pgf.Page2.Cnt_Fields.InternalPgf.Page1.txtprExt.Value ADDITIVE
REPLACE cur_Tempo.prLista 		WITH Thisform.Pgf.Page2.Cnt_Fields.InternalPgf.Page1.txtPrLista.Value ADDITIVE
REPLACE cur_Tempo.bonif1 		WITH Thisform.Pgf.Page2.Cnt_Fields.InternalPgf.Page1.txtBonif1.Value ADDITIVE
REPLACE cur_Tempo.bonif2 		WITH Thisform.Pgf.Page2.Cnt_Fields.InternalPgf.Page1.txtBonif2.Value ADDITIVE
REPLACE cur_Tempo.bonif3 		WITH Thisform.Pgf.Page2.Cnt_Fields.InternalPgf.Page1.txtBonif3.Value ADDITIVE
REPLACE cur_Tempo.bonif4 		WITH Thisform.Pgf.Page2.Cnt_Fields.InternalPgf.Page1.txtBonif4.Value ADDITIVE
REPLACE cur_Tempo.costoRep 		WITH Thisform.Pgf.Page2.Cnt_Fields.InternalPgf.Page1.txtCostoRep.Value ADDITIVE
REPLACE cur_Tempo.margenMax 	WITH Thisform.Pgf.Page2.Cnt_Fields.InternalPgf.Page1.txtMargenMax.Value ADDITIVE
REPLACE cur_Tempo.margenMin 	WITH Thisform.Pgf.Page2.Cnt_Fields.InternalPgf.Page1.txtMargenMin.Value ADDITIVE
REPLACE cur_Tempo.prVentaMax 	WITH Thisform.Pgf.Page2.Cnt_Fields.InternalPgf.Page1.txtPrVentaMax.Value ADDITIVE
REPLACE cur_Tempo.prVentaMin 	WITH Thisform.Pgf.Page2.Cnt_Fields.InternalPgf.Page1.txtPrVentaMin.Value ADDITIVE
REPLACE cur_Tempo.prFinalMax 	WITH Thisform.Pgf.Page2.Cnt_Fields.InternalPgf.Page1.txtPrFinalMax.Value ADDITIVE
REPLACE cur_Tempo.prFinalMin 	WITH Thisform.Pgf.Page2.Cnt_Fields.InternalPgf.Page1.txtPrFinalMin.Value ADDITIVE
REPLACE cur_Tempo.observ		WITH Thisform.Pgf.Page2.Cnt_Fields.InternalPgf.Page2.txtObserv.Value ADDITIVE
UNLOCK

ENDPROC
PROCEDURE Load
DODEFAULT()
SET DELETED ON 

&& Creo el cursor donde voy a tener los datos de las unidades de despacho
CREATE CURSOR cur_codiart (	;
	idCodiArt	int,;
	idArticulo	int,;
	codArt		varchar(20),;
	codigos		varchar(20),;
	tipo		varchar(2),;
	cantiDesp	float(10, 2),;
	circuito	varchar(2))
	
CREATE CURSOR cur_mrcsv (	;
	idMarcaV	int,;
	descripcio	varchar(60))

ENDPROC
PROCEDURE HERRAMIENTAS.nuevo
DODEFAULT()
Thisform.Cambiar_estado_2(.F.)
SELECT cur_codiart
ZAP 
SELECT cur_artequiv
ZAP
SELECT cur_mrcsv
ZAP

WITH thisform.pgf.page2.cnt_fields
	.chkHabilitado.value = 1
ENDWITH 

ENDPROC
PROCEDURE HERRAMIENTAS.cancelar
DODEFAULT()
Thisform.Cambiar_estado_2(.T.)
ENDPROC
PROCEDURE HERRAMIENTAS.modificar
DODEFAULT()
Thisform.Cambiar_estado_2(.F.)
ENDPROC
PROCEDURE HERRAMIENTAS.grabar
PARAMETERS tl_AutoAssing

LOCAL cRef
LOCAL loRes, lnProxID, loCommand, lcSql, lnPrAnt, lnPrLista, lnVariacion

loRes = CREATEOBJECT("odbc_result")
loCommand = CREATEOBJECT("odbc_command")
lcSql = ""
lnPrAnt = 0.00
lnPrLista = 0.00
lnVariacion = 0.00

cRef = Thisform.pk_fieldname

IF tl_AutoAssing THEN
	Thisform.asignarcampos()
ENDIF

IF !Thisform.validardatos() THEN
	MESSAGEBOX(thisform.msgerror, 0+48, thisform.Caption)
	RETURN .F.
ENDIF

IF thisform.pgf.page2.cnt_fields.sel_unimed.valcpoid = 0 THEN
	MESSAGEBOX("Debe ingresar la unidad de medida", 0+48, Thisform.Caption)
	thisform.pgf.page2.cnt_fields.sel_unimed.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

IF thisform.lnuevo THEN
	goConn.BeginTransaction()
	IF !thisform.object_dataservice.Insert(.F.) THEN
		MESSAGEBOX(thisform.object_dataservice.error_message, 0+64, "Mensaje de Error")
		goConn.Rollback()
		RETURN .F.
	ENDIF
	
	&& Si sale todo bien, entonces grabo las equivalencias
	IF !thisform.equivalencias.grabar(.F.) THEN
		MESSAGEBOX(thisform.equivalencias.ErrorMessage, 0+48, Thisform.Caption)
		goConn.Rollback()
		RETURN .F.
	ENDIF
	
	&& El siguiente código permite asignar las marcas de vehículos que asigna el
	&& siguiente artículo.
	Thisform.idarticulo = Thisform.object_dataservice.idArticulo
	IF !Thisform.asignar_marcas_v() THEN
		goConn.Rollback()
		RETURN .F.
	ENDIF
	
	goConn.Commit()
	
	&& Si es nuevo y no se ha cargado ninguna unidad de despacho, entonces se deberá generar una
	&& predeterminada
	IF thisform.pgf.page2.cnt_fields.chkEsServicio.Value = 0 THEN
		SELECT cur_codiart
		IF RECCOUNT("cur_codiart") = 0 THEN
			SELECT cur_codiart
			APPEND BLANK
			REPLACE cur_codiart.idCodiArt WITH 0
			REPLACE cur_codiart.idArticulo WITH thisform.object_dataservice.idArticulo ADDITIVE
			REPLACE cur_codiart.codArt WITH ALLTRIM(thisform.pgf.page2.cnt_fields.txtCodigo.Value) ADDITIVE
			REPLACE cur_codiart.codigos WITH ALLTRIM(thisform.pgf.page2.cnt_fields.txtCodigo.Value) ADDITIVE
			REPLACE cur_codiart.tipo WITH "CP" ADDITIVE
			REPLACE cur_codiart.cantiDesp WITH 1 ADDITIVE
			REPLACE cur_codiart.circuito WITH "CV" ADDITIVE
		ENDIF
	ENDIF
ELSE
	goConn.BeginTransaction()
	
	lcSql = "select prLista from articulos where idArticulo = " + ALLTRIM(STR(cur_tempo.idArticulo))
	loRes.ActiveConnection = goConn.ActiveConnection
	loRes.cursor_name = "tempo"
	
	IF !loRes.OpenQuery(lcSql) THEN
		this.ErrorMessage = loRes.Error_Message
		goConn.Rollback()
		RETURN .F.
	ENDIF
	
	lnPrLista = thisform.pgf.page2.cnt_fields.internalPgf.page1.txtPrLista.Value
	lnPrAnt = tempo.prLista
	IF lnPrLista <> 0 .AND. lnPrAnt <> 0 THEN
		lnVariacion = ROUND(((lnPrLista - lnPrAnt) / lnPrAnt) * 100, 2)
	ELSE
		lnVariacion = 0
	ENDIF
	
	loRes.Close_Query()	

	&& Si modifica tengo que traer el id del registro seleccionado
	cRef = "Thisform.object_DataService." + cRef + " = " + "cur_Tempo." + cRef
	&cRef

	IF !thisform.object_dataservice.Update(.F.) THEN
		MESSAGEBOX(thisform.object_dataservice.error_message, 0+64, "Mensaje de Error")
		goConn.Rollback()
		RETURN .F.
	ENDIF
	
	&& Agrego el insert que permite registrar los cambios de precios de los artículos
	IF lnVariacion <> 0 THEN
		lnProxID = goConn.GetNextID("art_cbios", "idArtCbios")
		
		lcSql = "insert into art_cbios ( "
		lcSql = lcSql + "idArtCbios, idArticulo, fecha, prAnt, prNuevo, porVar) values ("
		lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_tempo.idArticulo)) + ", "
		lcSql = lcSql + "current_timestamp, "
		lcSql = lcSql + ALLTRIM(STR(lnPrAnt, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnPrLista, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnVariacion, 10, 2)) + ") "
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
			goConn.Rollback()
			RETURN .F.
		ENDIF
	ENDIF
	
	&& Primero elimino las equivalencias dadas de baja
	IF !thisform.equivalencias.eliminar() THEN
		MESSAGEBOX(thisform.equivalencias.ErrorMessage, 0+48, Thisform.Caption)
		goConn.Rollback()
		RETURN .F.
	ENDIF
	
	&& Si sale todo bien, entonces grabo las equivalencias
	IF !thisform.equivalencias.grabar(.F.) THEN
		MESSAGEBOX(thisform.equivalencias.ErrorMessage, 0+48, Thisform.Caption)
		goConn.Rollback()
		RETURN .F.
	ENDIF
	
	&& El siguiente código permite asignar las marcas de vehículos que aplica
	&& el artículo
	Thisform.object_dataservice.idArticulo = cur_tempo.idArticulo
	IF !Thisform.asignar_marcas_v() THEN
		goConn.Rollback()
		RETURN .F.
	ENDIF	
	
	goConn.Commit()
	
	&& Si es update también si no hay nada asignado genero uno, ya que si borran y dejan vació las unidades
	&& tengo que hacer que siempre se genere un registro vinculádo en el codiart para mantener la consistencia
	&& de datos.

	IF thisform.pgf.page2.cnt_fields.chkEsServicio.Value = .F. THEN
		SELECT cur_codiart
		IF RECCOUNT("cur_codiart") = 0 THEN
			SELECT cur_codiart
			APPEND BLANK
			REPLACE cur_codiart.idCodiArt WITH 0
			REPLACE cur_codiart.idArticulo WITH thisform.object_dataservice.idArticulo ADDITIVE
			REPLACE cur_codiart.codArt WITH ALLTRIM(thisform.pgf.page2.cnt_fields.txtCodigo.Value) ADDITIVE
			REPLACE cur_codiart.codigos WITH ALLTRIM(thisform.pgf.page2.cnt_fields.txtCodigo.Value) ADDITIVE
			REPLACE cur_codiart.tipo WITH "CP" ADDITIVE
			REPLACE cur_codiart.cantiDesp WITH 1 ADDITIVE
			REPLACE cur_codiart.circuito WITH "CV" ADDITIVE
		ENDIF
	ENDIF
ENDIF

IF !thisform.grabar_codiart() THEN 
	MESSAGEBOX("Error al intentar grabar las unidades de compras y ventas", 0+48, Thisform.Caption)
	RETURN .F.
ENDIF


Thisform.actualizar_cursor()
Thisform.CambiarEstado(.T.)
Thisform.pgf.page2.cnT_FIELDS.INTERNALPGF.pagE4.grdEQUIVS.Refresh()
Thisform.pgf.Page1.enabled = .T.
Thisform.Pgf.Page1.SetFocus()
Thisform.Pgf.Page1.grdDatos.SetFocus()

RETURN .T.

ENDPROC


************************************************************
OBJETO: equivalencias
************************************************************
*** PROPIEDADES ***
Top = 12
Left = 444
Height = 17
Width = 36
Name = "equivalencias"

*** METODOS ***


************************************************************
OBJETO: internalPgf
************************************************************
*** PROPIEDADES ***
ErasePage = .T.
PageCount = 5
Top = 206
Left = 9
Width = 965
Height = 274
TabIndex = 13
TabStop = .T.
Name = "internalPgf"
Page1.Caption = "Precios"
Page1.Name = "Page1"
Page2.Caption = "Observaciones"
Page2.BackColor = 212,208,200
Page2.Name = "Page2"
Page3.FontBold = .T.
Page3.FontItalic = .T.
Page3.FontSize = 8
Page3.Caption = "Unidades de Compras / Ventas"
Page3.ForeColor = 128,64,64
Page3.Name = "Page3"
Page4.FontBold = .T.
Page4.FontItalic = .T.
Page4.FontSize = 8
Page4.Caption = "Equivalencias"
Page4.ForeColor = 128,64,64
Page4.Name = "Page4"
Page5.FontBold = .T.
Page5.FontSize = 8
Page5.Caption = "Marcas de Vehículos"
Page5.ForeColor = 128,64,64
Page5.Name = "Page5"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Prec. Lista Proveedor ($):"
Height = 15
Left = 18
Top = 25
Width = 148
TabIndex = 16
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Bonificación 1:"
Left = 18
Top = 94
TabIndex = 18
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Bonificación 2:"
Left = 18
Top = 118
TabIndex = 19
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta6
************************************************************
*** PROPIEDADES ***
Caption = "Bonificación 3:"
Left = 18
Top = 142
TabIndex = 20
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta7
************************************************************
*** PROPIEDADES ***
Caption = "Bonificación 4:"
Left = 18
Top = 166
TabIndex = 21
Name = "Clsetiqueta7"

*** METODOS ***


************************************************************
OBJETO: txtBonif1
************************************************************
*** PROPIEDADES ***
Left = 111
TabIndex = 10
Top = 90
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
Left = 111
TabIndex = 11
Top = 114
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
Left = 111
TabIndex = 12
Top = 138
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
Left = 111
TabIndex = 13
Top = 162
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
OBJETO: Clsetiqueta9
************************************************************
*** PROPIEDADES ***
Caption = "Costo de Reposición:"
Height = 15
Left = 18
Top = 197
Width = 123
TabIndex = 22
Name = "Clsetiqueta9"

*** METODOS ***


************************************************************
OBJETO: txtCostoRep
************************************************************
*** PROPIEDADES ***
Tag = ""
Enabled = .F.
Left = 150
TabIndex = 23
Top = 193
isnumeric = .T.
cfieldname = costoRep
requerido = .F.
Name = "txtCostoRep"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta11
************************************************************
*** PROPIEDADES ***
Caption = "Margen Mayorista:"
Height = 15
Left = 247
Top = 96
Width = 105
TabIndex = 26
Name = "Clsetiqueta11"

*** METODOS ***


************************************************************
OBJETO: txtMargenMax
************************************************************
*** PROPIEDADES ***
Left = 363
TabIndex = 14
Top = 92
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
Left = 363
TabIndex = 15
Top = 116
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
Left = 466
TabIndex = 27
Top = 92
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
Left = 466
TabIndex = 28
Top = 116
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
Left = 569
TabIndex = 29
Top = 92
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
Left = 569
TabIndex = 30
Top = 116
isnumeric = .T.
cfieldname = prfinalmin
requerido = .F.
Name = "txtPrFinalMin"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta12
************************************************************
*** PROPIEDADES ***
Caption = "Utilidad"
Height = 15
Left = 335
Top = 68
Width = 46
TabIndex = 34
Name = "Clsetiqueta12"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta13
************************************************************
*** PROPIEDADES ***
Caption = "Con I.V.A"
Height = 15
Left = 589
Top = 68
Width = 56
TabIndex = 36
Name = "Clsetiqueta13"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta18
************************************************************
*** PROPIEDADES ***
Caption = "% Dto. Prov."
Height = 15
Left = 69
Top = 68
Width = 80
TabIndex = 17
Name = "Clsetiqueta18"

*** METODOS ***


************************************************************
OBJETO: Clslinea1
************************************************************
*** PROPIEDADES ***
Height = 0
Left = 13
Top = 84
Width = 942
Name = "Clslinea1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta19
************************************************************
*** PROPIEDADES ***
Caption = "Margen Minorista:"
Height = 15
Left = 247
Top = 119
Width = 110
TabIndex = 25
Name = "Clsetiqueta19"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta20
************************************************************
*** PROPIEDADES ***
Caption = "Sin I.V.A"
Height = 15
Left = 492
Top = 68
Width = 59
TabIndex = 35
Name = "Clsetiqueta20"

*** METODOS ***


************************************************************
OBJETO: txtprLista
************************************************************
*** PROPIEDADES ***
Left = 170
TabIndex = 9
Top = 21
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
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Tipo Moneda:"
Left = 361
Top = 24
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: cmbTipoMon
************************************************************
*** PROPIEDADES ***
Height = 22
Left = 446
ToolTipText = "PSO: Pesos | DOL: Dolares | EUR: Euros"
Top = 20
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
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Cotización:"
Height = 15
Left = 555
Top = 24
Width = 70
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: txtCotizacion
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 629
Top = 20
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
OBJETO: Clsetiqueta8
************************************************************
*** PROPIEDADES ***
Caption = "Precio Mon. Ext.:"
Height = 15
Left = 693
Top = 24
Width = 111
Name = "Clsetiqueta8"

*** METODOS ***


************************************************************
OBJETO: txtPrExt
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 797
Top = 20
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
Left = 364
Top = 11
Width = 592
Name = "Clslinea2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta10
************************************************************
*** PROPIEDADES ***
BackStyle = 1
Caption = " Moneda Extranjera"
Height = 15
Left = 357
Top = 3
Width = 149
ForeColor = 255,255,255
BackColor = 0,128,192
Name = "Clsetiqueta10"

*** METODOS ***


************************************************************
OBJETO: txtObserv
************************************************************
*** PROPIEDADES ***
Height = 183
Left = 4
TabIndex = 16
Top = 33
Width = 952
cfieldname = observ
Name = "txtObserv"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta19
************************************************************
*** PROPIEDADES ***
Caption = "Observaciones:"
Height = 15
Left = 20
Top = 13
Width = 110
TabIndex = 25
Name = "Clsetiqueta19"

*** METODOS ***


************************************************************
OBJETO: CLSETIQUETA1
************************************************************
*** PROPIEDADES ***
Caption = "Circuito:"
Height = 15
Left = 14
Top = 20
Width = 72
TabIndex = 9
Name = "CLSETIQUETA1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Tipo:"
Height = 15
Left = 144
Top = 20
Width = 72
TabIndex = 10
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Código:"
Height = 15
Left = 254
Top = 20
Width = 72
TabIndex = 11
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Unidades:"
Height = 15
Left = 661
Top = 20
Width = 73
TabIndex = 12
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: cboCircuito
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 67
TabIndex = 1
Top = 16
Width = 73
Name = "cboCircuito"

*** METODOS ***


************************************************************
OBJETO: cboTipo
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 176
TabIndex = 2
Top = 16
Width = 73
Name = "cboTipo"

*** METODOS ***


************************************************************
OBJETO: txtCodigo
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 300
TabIndex = 3
Top = 16
Width = 354
ischaracter = .T.
Name = "txtCodigo"

*** METODOS ***


************************************************************
OBJETO: txtUnidades
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 720
TabIndex = 4
Top = 16
Width = 77
isnumeric = .T.
Name = "txtUnidades"

*** METODOS ***


************************************************************
OBJETO: btnAgregar
************************************************************
*** PROPIEDADES ***
Top = 9
Left = 806
Height = 35
Width = 40
TabIndex = 5
Name = "btnAgregar"

*** METODOS ***
PROCEDURE Click
IF ALLTRIM(this.Parent.txtCodigo.Value) == "" THEN
	MESSAGEBOX("Debe ingresar un código", 0+48, Thisform.Caption)
	this.Parent.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

SELECT cur_codiart
APPEND BLANK
REPLACE cur_codiart.idCodiArt WITH 0
REPLACE cur_codiart.idArticulo WITH Thisform.idarticulo ADDITIVE
REPLACE cur_codiart.codArt WITH Thisform.pgf.page2.cnt_fields.txtCodigo.Value ADDITIVE
REPLACE cur_codiart.codigos WITH this.Parent.txtCodigo.Value ADDITIVE
REPLACE cur_codiart.tipo WITH this.Parent.cboTipo.Value ADDITIVE
REPLACE cur_codiart.cantiDesp WITH this.Parent.txtUnidades.Value ADDITIVE
REPLACE cur_codiart.circuito WITH this.Parent.cboCircuito.Value ADDITIVE

SELECT cur_codiart
this.Parent.grdCodigos.Refresh()

this.Parent.cboTipo.ListIndex = 1
this.Parent.cboCircuito.ListIndex = 1
this.Parent.txtCodigo.Value = ""
this.Parent.txtUnidades.Value = 0.00
this.Parent.cboCircuito.SetFocus()

RETURN .T.
ENDPROC


************************************************************
OBJETO: grdCodigos
************************************************************
*** PROPIEDADES ***
Tag = "edit"
Height = 190
Left = 14
TabIndex = 8
Top = 47
Width = 940
permitir_busqueda = .F.
permitir_ordenamiento = .F.
alias_name = 
list_controlsource = 
lista_ancho_cols = 
titulos_cabeceras = 
Name = "grdCodigos"
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
Tag = "edit"
Top = 9
Left = 914
Height = 35
Width = 40
TabIndex = 7
Name = "btnEliminar"

*** METODOS ***
PROCEDURE Click
LOCAL lnResp

lnResp = MESSAGEBOX("¿Está seguro que desea eliminar el pack seleccionado?", 4+32, Thisform.Caption)

IF lnResp = 6 THEN
	SELECT cur_codiart
	DELETE 
	this.Parent.grdCodigos.Refresh()
ENDIF
ENDPROC


************************************************************
OBJETO: btnCancelar
************************************************************
*** PROPIEDADES ***
Top = 9
Left = 849
Height = 35
Width = 40
TabIndex = 6
Name = "btnCancelar"

*** METODOS ***
PROCEDURE Click
this.Parent.cboTipo.ListIndex = 1
this.Parent.cboCircuito.ListIndex = 1
this.Parent.txtCodigo.Value = ""
this.Parent.txtUnidades.Value = 0.00
ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Artículo:"
Height = 15
Left = 14
Top = 14
Width = 60
TabIndex = 6
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: sel_artic_equiv
************************************************************
*** PROPIEDADES ***
Top = 8
Left = 62
TabIndex = 1
cfieldname = 
nombre_campo_codigo = codArt
nombre_campo_desc = descripcio
nombre_tabla = articulos
pkfield = idArticulo
requerido = .F.
localizado_manual = .F.
criterio_filtro = articulos.habilitado = 1 AND articulos.fecBaja IS NULL
Name = "sel_artic_equiv"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: grdEquivs
************************************************************
*** PROPIEDADES ***
Tag = "edit"
Height = 190
Left = 14
TabIndex = 5
Top = 41
Width = 940
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
OBJETO: btnAgrEquiv
************************************************************
*** PROPIEDADES ***
Top = 2
Left = 547
Height = 37
Width = 40
TabIndex = 2
Name = "btnAgrEquiv"

*** METODOS ***
PROCEDURE Click
IF this.Parent.sel_artic_equiv.valcpoid = 0 THEN
	MESSAGEBOX("Debe ingresar el artículo que va a asignar la equivalencia", 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

&&thisform.equivalencias.asignar(this.Parent.sel_artic_equiv.valcpoid)
Thisform.equivalencias.agregar(this.Parent.sel_artic_equiv.valcpoid, this.Parent.sel_artic_equiv.txtCodigo.Value, this.Parent.sel_artic_equiv.txtDescripcion.Value)
SELECT cur_artequiv
this.Parent.grdEquivs.Refresh()

this.Parent.sel_artic_equiv.blanquear()
this.Parent.sel_artic_equiv.txtCodigo.SetFocus()
ENDPROC


************************************************************
OBJETO: btnEliminar
************************************************************
*** PROPIEDADES ***
Tag = "edit"
Top = 2
Left = 588
Height = 37
Width = 42
TabIndex = 4
Name = "btnEliminar"

*** METODOS ***
PROCEDURE Click
LOCAL lnResp, ln_idArtic, lc_codArt 

ln_idArtic = 0
lc_codArt = ""

lnResp = MESSAGEBOX("¿Está seguro que desea eliminar esta equivalencia?", 4+32, Thisform.Caption)
IF lnResp = 6 THEN

	SELECT cur_eq
	LOCATE FOR cur_eq.codArt_A = cur_artequiv.codArt
	IF FOUND("cur_eq") THEN 
		ln_idArtic = cur_eq.idArtic_A
		lc_codArt = cur_eq.codArt_A 
	ENDIF 
	
	SELECT cur_eq
	DELETE FROM cur_eq WHERE idArtic_a = ln_idArtic 
	
	SELECT cur_cadena 
	DELETE FROM cur_cadena WHERE idArtic_A = ln_idArtic 
	
	SELECT cur_cadena 
	DELETE FROM cur_cadena WHERE idArtic_B = ln_idArtic 
	
	SELECT cur_ArtEquiv
	DELETE
	
	SELECT cur_delequiv
	APPEND BLANK
	REPLACE idArtic WITH ln_idArtic 
	REPLACE codArt	WITH lc_codArt
	
	This.Parent.grdEquivs.Refresh()
ENDIF

This.Parent.grdEquivs.SetFocus()
ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Marca de Vehículo:"
Height = 15
Left = 10
Top = 14
Width = 109
TabIndex = 6
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: sel_mrcsv
************************************************************
*** PROPIEDADES ***
Top = 8
Left = 122
TabIndex = 1
cfieldname = 
nombre_campo_codigo = idMarcaV
nombre_campo_desc = descripcio
nombre_tabla = marcas_v
pkfield = idMarcaV
requerido = .F.
localizado_manual = .F.
esnumerico = .T.
criterio_filtro = marcas_v.fecBaja IS NULL
Name = "sel_mrcsv"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: grdMarcasV
************************************************************
*** PROPIEDADES ***
Tag = "edit"
Height = 191
Left = 10
TabIndex = 5
Top = 41
Width = 940
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdMarcasV"
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
OBJETO: btnAgregarMV
************************************************************
*** PROPIEDADES ***
Top = 2
Left = 607
Height = 37
Width = 40
TabIndex = 2
Name = "btnAgregarMV"

*** METODOS ***
PROCEDURE Click
IF This.Parent.sel_mrcsv.valcpoid = 0 THEN
	MESSAGEBOX("Debe ingresar una marca de vehículo", 0+48, Thisform.Caption)
	This.Parent.sel_mrcsv.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

SELECT cur_mrcsv
APPEND BLANK
REPLACE cur_mrcsv.idMarcaV WITH This.Parent.sel_mrcsv.txtCodigo.Value
REPLACE cur_mrcsv.descripcio WITH This.Parent.sel_mrcsv.txtDescripcion.Value ADDITIVE

This.Parent.grdMarcasV.Refresh()

RETURN .T.
ENDPROC


************************************************************
OBJETO: btnEliminar
************************************************************
*** PROPIEDADES ***
Tag = "edit"
Top = 2
Left = 648
Height = 37
Width = 42
TabIndex = 4
Name = "btnEliminar"

*** METODOS ***
PROCEDURE Click
LOCAL lnResp

lnResp = MESSAGEBOX("¿Está seguro que desea eliminar esta equivalencias?", 4+32, Thisform.Caption)
IF lnResp = 6 THEN
	SELECT cur_mrcsv
	DELETE
	
	This.Parent.grdMarcasV.Refresh()
ENDIF
ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Código:"
Height = 15
Left = 284
Top = 14
Width = 72
TabIndex = 15
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Descripción:"
Height = 15
Left = 258
Top = 38
Width = 76
TabIndex = 16
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Familia:"
Height = 15
Left = 285
Top = 62
Width = 44
TabIndex = 17
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "SubFamilia:"
Height = 15
Left = 264
Top = 86
Width = 65
TabIndex = 18
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: txtCodigo
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 336
MaxLength = 20
TabIndex = 1
Top = 10
Width = 226
ischaracter = .T.
cfieldname = CodArt
msgerror = Debe ingresar el Código del Artículo
Name = "txtCodigo"

*** METODOS ***


************************************************************
OBJETO: txtDescripcion
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 336
MaxLength = 100
TabIndex = 3
Top = 34
Width = 571
ischaracter = .T.
cfieldname = Descripcio
msgerror = Debe ingresar la Descripción
Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: sel_Familia
************************************************************
*** PROPIEDADES ***
Top = 56
Left = 334
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
TXTCODIGO.Name = "TXTCODIGO"
TXTDESCRIPCION.Height = 21
TXTDESCRIPCION.Left = 106
TXTDESCRIPCION.Top = 2
TXTDESCRIPCION.Width = 467
TXTDESCRIPCION.Name = "TXTDESCRIPCION"

*** METODOS ***


************************************************************
OBJETO: picFoto
************************************************************
*** PROPIEDADES ***
Height = 120
Left = 38
Top = 3
Width = 140
cfieldname = 
Name = "picFoto"

*** METODOS ***


************************************************************
OBJETO: btnCargarFoto
************************************************************
*** PROPIEDADES ***
Tag = "edit"
Top = 126
Left = 9
Height = 25
Width = 202
Caption = "Cargar Foto"
TabIndex = 14
Name = "btnCargarFoto"

*** METODOS ***
PROCEDURE Click
LOCAL lcPath

lcPath = GETFILE("JPG")

IF ALLTRIM(lcPath) == ""
	RETURN	
ENDIF

&& Si corre bajo mysql entonces tengo que reemplazar la \ en \\
IF INT(VAL(getConfig("SQLSRV"))) = 0 THEN
	This.Parent.picFoto.Picture = lcPath
	This.Parent.txtPathFoto.Value = STRTRAN(lcPath, "\", "\\")
ENDIF



ENDPROC


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Marca:"
Height = 15
Left = 290
Top = 109
Width = 44
TabIndex = 21
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta6
************************************************************
*** PROPIEDADES ***
Caption = "Proveedor:"
Height = 15
Left = 265
Top = 133
Width = 69
TabIndex = 20
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: Sel_SubFamilia
************************************************************
*** PROPIEDADES ***
Top = 80
Left = 334
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
TXTCODIGO.Name = "TXTCODIGO"
TXTDESCRIPCION.Height = 21
TXTDESCRIPCION.Left = 106
TXTDESCRIPCION.Top = 2
TXTDESCRIPCION.Width = 467
TXTDESCRIPCION.Name = "TXTDESCRIPCION"

*** METODOS ***


************************************************************
OBJETO: Sel_Marca
************************************************************
*** PROPIEDADES ***
Top = 104
Left = 334
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
TXTCODIGO.Name = "TXTCODIGO"
TXTDESCRIPCION.Height = 21
TXTDESCRIPCION.Left = 106
TXTDESCRIPCION.Top = 2
TXTDESCRIPCION.Width = 467
TXTDESCRIPCION.Name = "TXTDESCRIPCION"

*** METODOS ***


************************************************************
OBJETO: Sel_Proveedor
************************************************************
*** PROPIEDADES ***
Top = 128
Left = 334
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
TXTCODIGO.Name = "TXTCODIGO"
TXTDESCRIPCION.Height = 21
TXTDESCRIPCION.Left = 106
TXTDESCRIPCION.Top = 2
TXTDESCRIPCION.Width = 467
TXTDESCRIPCION.Name = "TXTDESCRIPCION"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta7
************************************************************
*** PROPIEDADES ***
Caption = "Alícuota I.V.A.:"
Left = 249
Top = 182
TabIndex = 22
Name = "Clsetiqueta7"

*** METODOS ***


************************************************************
OBJETO: txtAlicIVA
************************************************************
*** PROPIEDADES ***
Left = 336
TabIndex = 9
Top = 178
isnumeric = .T.
cfieldname = aliciva
msgerror = Debe ingresar la Alícuota de I.V.A.
Name = "txtAlicIVA"

*** METODOS ***


************************************************************
OBJETO: chkHabilitado
************************************************************
*** PROPIEDADES ***
Top = 180
Left = 462
Height = 18
Width = 79
Alignment = 0
Caption = " Habilitado"
Value = 1
TabIndex = 10
cfieldname = habilitado
requerido = .T.
Name = "chkHabilitado"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta8
************************************************************
*** PROPIEDADES ***
Caption = "%"
Height = 15
Left = 439
Top = 182
Width = 12
TabIndex = 23
Name = "Clsetiqueta8"

*** METODOS ***


************************************************************
OBJETO: txtPathFoto
************************************************************
*** PROPIEDADES ***
Height = 22
Left = 11
MaxLength = 100
TabIndex = 24
Top = 153
Width = 199
cfieldname = linkfoto
ischaracter = .T.
requerido = .F.
Name = "txtPathFoto"

*** METODOS ***


************************************************************
OBJETO: chkEsServicio
************************************************************
*** PROPIEDADES ***
Top = 180
Left = 551
Height = 18
Width = 110
Alignment = 0
Caption = "Es un servicio"
Value = 1
TabIndex = 11
cfieldname = esServ
requerido = .T.
Name = "chkEsServicio"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta9
************************************************************
*** PROPIEDADES ***
Caption = "Unidad de Medida:"
Height = 15
Left = 226
Top = 157
Width = 106
TabIndex = 19
Name = "Clsetiqueta9"

*** METODOS ***


************************************************************
OBJETO: sel_unimed
************************************************************
*** PROPIEDADES ***
Top = 152
Left = 334
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
OBJETO: CLSETIQUETA10
************************************************************
*** PROPIEDADES ***
Caption = "Código Alternativo:"
Height = 15
Left = 567
Top = 13
Width = 113
TabIndex = 25
Name = "CLSETIQUETA10"

*** METODOS ***


************************************************************
OBJETO: txtCodArtPV
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 682
MaxLength = 20
TabIndex = 2
Top = 10
Width = 225
ischaracter = .T.
cfieldname = codArtPV
msgerror = 
requerido = .F.
Name = "txtCodArtPV"

*** METODOS ***


************************************************************
OBJETO: chkMostrador
************************************************************
*** PROPIEDADES ***
Top = 180
Left = 659
Height = 18
Width = 144
Alignment = 0
Caption = "Venta solo mostrador"
Value = 0
TabIndex = 12
cfieldname = mostrador
requerido = .T.
Name = "chkMostrador"

*** METODOS ***


************************************************************
OBJETO: cls_abm_articulo
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: frm_abm_artunid
************************************************************
*** PROPIEDADES ***
DoCreate = .T.
Caption = "Definición de Unidades de Despacho por Artículo"
MinButton = .T.
listctrlsource = codArt,cantUD
listwidthcols = 200,100
pk_fieldname = idArtUnid
titulos_cabeceras = Código,Unidad Desp.
cnombretabla = art_unid
Name = "frm_abm_artunid"
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
Caption = "Código de artículo:"
Height = 15
Left = 19
Top = 15
Width = 115
TabIndex = 3
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: sel_articulo
************************************************************
*** PROPIEDADES ***
Top = 10
Left = 141
Width = 623
Height = 25
TabIndex = 1
pkfield = idArticulo
nombre_campo_codigo = codArt
autocompletar_ceros = .F.
nombre_campo_desc = descripcio
nombre_tabla = articulos
cfieldname = idArticulo
Name = "sel_articulo"
txtCodigo.Height = 21
txtCodigo.Left = 2
txtCodigo.Top = 2
txtCodigo.Width = 178
txtCodigo.Name = "txtCodigo"
txtDescripcion.Height = 21
txtDescripcion.Left = 183
txtDescripcion.Top = 2
txtDescripcion.Width = 436
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***
PROCEDURE recuperar_datos
thisform.pgf.page2.cnt_fields.txtCodArt.Value = thisform.pgf.page2.cnt_fields.sel_articulo.txtCodigo.Value
ENDPROC


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Unidad de Despacho:"
Height = 15
Left = 19
Top = 40
Width = 115
TabIndex = 4
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: txtCantidad
************************************************************
*** PROPIEDADES ***
Left = 143
TabIndex = 2
Top = 36
isnumeric = .T.
cfieldname = cantUD
Name = "txtCantidad"

*** METODOS ***


************************************************************
OBJETO: txtCodArt
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 248
Top = 36
Visible = .F.
Width = 512
cfieldname = codArt
requerido = .F.
ischaracter = .T.
Name = "txtCodArt"

*** METODOS ***


************************************************************
OBJETO: frm_abm_artunid
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_abm_unidmed
************************************************************
*** PROPIEDADES ***
DoCreate = .T.
Caption = "ABM Unidades de Medida"
MinButton = .T.
cnombretabla = unidmed
listctrlsource = codUM,descripcio
listwidthcols = 70,300
object_dataservice = 
pk_fieldname = idUniMed
titulos_cabeceras = Código,Descripción
Name = "cls_abm_unidmed"
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
PGF.Page2.CNT_FIELDS.Name = "CNT_FIELDS"
PGF.Page2.Name = "Page2"
PGF.Name = "PGF"

*** METODOS ***


************************************************************
OBJETO: CLSETIQUETA1
************************************************************
*** PROPIEDADES ***
Caption = "Código:"
Left = 24
Top = 27
Name = "CLSETIQUETA1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Descripción:"
Left = 24
Top = 53
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: txtCodigo
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 120
MaxLength = 4
Top = 24
Width = 128
cfieldname = codUM
Name = "txtCodigo"

*** METODOS ***


************************************************************
OBJETO: txtDescripcion
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 120
MaxLength = 30
Top = 48
Width = 492
cfieldname = descripcio
Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: cls_abm_unidmed
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_abm_ramos
************************************************************
*** PROPIEDADES ***
BorderStyle = 1
Height = 629
Width = 1160
DoCreate = .T.
Caption = "ABM Ramos"
MinButton = .T.
currentid = 0
cnombretabla = ramos
listctrlsource = idRamo,descripcio
listwidthcols = 70,300
pk_fieldname = idRamo
titulos_cabeceras = Código,Descripción
Name = "cls_abm_ramos"
Herramientas.cmdNuevo.Name = "cmdNuevo"
Herramientas.cmdEditar.Name = "cmdEditar"
Herramientas.cmdEliminar.Name = "cmdEliminar"
Herramientas.cmdCerrar.Top = 1
Herramientas.cmdCerrar.Left = 1108
Herramientas.cmdCerrar.Name = "cmdCerrar"
Herramientas.cmdGrabar.Name = "cmdGrabar"
Herramientas.cmdCancelar.Name = "cmdCancelar"
Herramientas.cmdExcel.Name = "cmdExcel"
Herramientas.Top = 1
Herramientas.Left = 2
Herramientas.Width = 1153
Herramientas.Height = 36
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
Pgf.Page1.grdDatos.Height = 552
Pgf.Page1.grdDatos.Left = 2
Pgf.Page1.grdDatos.Top = 3
Pgf.Page1.grdDatos.Width = 1146
Pgf.Page1.grdDatos.Name = "grdDatos"
Pgf.Page1.Name = "Page1"
Pgf.Page2.cnt_fields.Top = 7
Pgf.Page2.cnt_fields.Left = 6
Pgf.Page2.cnt_fields.Width = 1140
Pgf.Page2.cnt_fields.Height = 546
Pgf.Page2.cnt_fields.Name = "cnt_fields"
Pgf.Page2.Name = "Page2"
Pgf.Top = 38
Pgf.Left = 2
Pgf.Width = 1157
Pgf.Height = 586
Pgf.Name = "Pgf"

*** METODOS ***
PROCEDURE Load
DODEFAULT()

CREATE CURSOR cur_mrcsv (	;
	idMarcaV	int,;
	descripcio	varchar(60))

CREATE CURSOR cur_familias (	;
	idFamilia	int,;
	descripcio varchar(60))
	
CREATE CURSOR cur_subfam (	;
	idSubFam	int,;
	descripcio varchar(60))
	


ENDPROC
PROCEDURE Init
DODEFAULT()

SELECT cur_mrcsv
WITH THISFORM.pgf.page2.cnt_fields.pgf.page1.grdMarcasV
	.alias_name = "cur_mrcsv"
	.RecordSource = "cur_mrcsv"
	.list_controlsource = "idMarcaV,descripcio"
	.lista_ancho_cols = "70,300"
	.titulos_cabeceras = "Código,Descripción"
	.generar_grid()
ENDWITH

SELECT cur_familias
WITH THISFORM.pgf.page2.cnt_fields.pgf.page2.grdFamilias
	.alias_name = "cur_familias"
	.RecordSource = "cur_familias"
	.list_controlsource = "idFamilia,descripcio"
	.lista_ancho_cols = "70,300"
	.titulos_cabeceras = "Código,Descripcion"
	.generar_grid()
ENDWITH

SELECT cur_subfam
WITH THISFORM.pgf.page2.cnt_fields.pgf.page3.grdSubFam
	.alias_name = "cur_subfam"
	.RecordSource = "cur_subfam"
	.list_controlsource = "idSubFam,descripcio"
	.lista_ancho_cols = "70,300"
	.titulos_cabeceras = "Código,Descripción"
	.generar_grid()
ENDWITH
ENDPROC
PROCEDURE recuperardatos
LOCAL loRes
LOCAL lcSql

loRes = CREATEOBJECT("odbc_result")
lcSql = ""

SELECT cur_mrcsv
ZAP

SELECT cur_familias
ZAP

SELECT cur_subfam
ZAP

DODEFAULT()

SELECT cur_tempo
lcSql = "select marcas_v.* from marcas_v "
lcSql = lcSql + "	inner join ramo_mrcv on marcas_v.idMarcaV = ramo_mrcv.idMarcaV "
lcSql = lcSql + "where ramo_mrcv.idRamo = " + ALLTRIM(STR(cur_tempo.idRamo))

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_x
GO TOP

DO WHILE !EOF("cur_x")
	SELECT cur_mrcsv
	APPEND BLANK
	REPLACE cur_mrcsv.idMarcaV WITH cur_x.idMarcaV
	REPLACE cur_mrcsv.descripcio WITH cur_x.descripcio ADDITIVE

	SELECT cur_x
	SKIP
ENDDO

SELECT cur_mrcsv
GO TOP
Thisform.pgf.page2.cnt_fields.pgf.page1.grdMarcasV.Refresh()

loRes.Close_Query()

SELECT cur_tempo
lcSql = "select familias.* from familias "
lcSql = lcSql + "inner join ramofam on ramofam.idFamilia = familias.idFamilia "
lcSql = lcSql + "where ramofam.idRamo = " + ALLTRIM(STR(cur_tempo.idRamo))

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_x
GO TOP

DO WHILE !EOF("cur_x")
	SELECT cur_familias
	APPEND BLANK
	REPLACE cur_familias.idFamilia WITH cur_x.idFamilia
	REPLACE cur_familias.descripcio WITH cur_x.descripcio ADDITIVE

	SELECT cur_x
	SKIP
ENDDO

loRes.Close_Query()

SELECT cur_familias
GO TOP
Thisform.pgf.page2.cnt_fields.pgf.page2.grdFamilias.Refresh()

SELECT cur_tempo
lcSql = "select subfam.* from subfam "
lcSql = lcSql + "inner join ramo_sf on ramo_sf.idSubFam = subfam.idSubFam "
lcSql = lcSql + "where ramo_sf.idRamo = " + ALLTRIM(STR(cur_tempo.idRamo))

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_x
GO TOP

DO WHILE !EOF("cur_x")
	SELECT cur_subfam
	APPEND BLANK
	REPLACE cur_subfam.idSubFam WITH cur_x.idSubFam
	REPLACE cur_subfam.descripcio WITH cur_x.descripcio ADDITIVE

	SELECT cur_x
	SKIP
ENDDO

loRes.Close_Query()

SELECT cur_subfam
GO TOP
Thisform.pgf.page2.cnt_fields.pgf.page3.grdSubFam.Refresh()

RETURN .T.
ENDPROC
PROCEDURE Herramientas.grabar
PARAMETERS tl_AutoAssing

LOCAL loCommand
LOCAL lcSql
LOCAL lnProxID
LOCAL cRef

loCommand = CREATEOBJECT("odbc_command")
lcSql = ""

cRef = Thisform.pk_fieldname

IF tl_AutoAssing THEN
	Thisform.asignarcampos()
ENDIF

IF !Thisform.validardatos() THEN
	MESSAGEBOX(thisform.msgerror, 0+48, thisform.Caption)
	Thisform.datos_ok = .F.
	RETURN .F.
ENDIF

goConn.BeginTransaction()

IF thisform.lnuevo THEN
	IF !thisform.object_dataservice.Insert(.F.) THEN
		goConn.Rollback()
		MESSAGEBOX(thisform.object_dataservice.error_message, 0+64, "Mensaje de Error")
		RETURN .F.
	ENDIF
ELSE
	&& Si modifica tengo que traer el id del registro seleccionado
	cRef = "Thisform.object_DataService." + cRef + " = " + "cur_Tempo." + cRef
	&cRef

	IF !thisform.object_dataservice.Update(.F.) THEN
		goConn.Rollback()
		MESSAGEBOX(thisform.object_dataservice.error_message, 0+64, "Mensaje de Error")
		RETURN .F.
	ENDIF
ENDIF

lcSql = "delete from ramo_mrcv where idRamo = " + ALLTRIM(STR(Thisform.object_dataservice.idRamo))
loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = lcSql

IF !loCommand.Execute() THEN
	goConn.Rollback()
	MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

lcSql = "delete from ramofam where idRamo = " + ALLTRIM(STR(Thisform.object_dataservice.idRamo))
loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = lcSql

IF !loCommand.Execute() THEN
	goConn.Rollback()
	MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

lcSql = "delete from ramo_sf where idRamo = " + ALLTRIM(STR(Thisform.object_dataservice.idRamo))
loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = lcSql

IF !loCommand.Execute() THEN
	goConn.Rollback()
	MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_mrcsv
GO TOP

DO WHILE !EOF("cur_mrcsv")
	lcSql = "insert into ramo_mrcv ( "
	lcSql = lcSql + "idMarcaV, "
	lcSql = lcSql + "idRamo) "
	lcSql = lcSql + "values ( "
	lcSql = lcSql + ALLTRIM(STR(cur_mrcsv.idMarcaV)) + ", "
	lcSql = lcSql + ALLTRIM(STR(Thisform.object_dataservice.idRamo)) + ")"
	
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute() THEN
		goConn.Rollback()
		MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
		RETURN .F.
	ENDIF
	
	SELECT cur_mrcsv
	SKIP
ENDDO

SELECT cur_familias
GO TOP

DO WHILE !EOF("cur_familias")
	lcSql = "insert into ramofam ( "
	lcSql = lcSql + "	idFamilia, "
	lcSql = lcSql + "	idRamo) "
	lcSql = lcSql + "values ( "
	lcSql = lcSql + ALLTRIM(STR(cur_familias.idFamilia)) + ", "
	lcSql = lcSql + ALLTRIM(STR(Thisform.object_dataservice.idRamo)) + ")"
	
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute() THEN
		goConn.Rollback()
		MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
		RETURN .F.
	ENDIF

	SELECT cur_familias
	SKIP
ENDDO

SELECT cur_subfam
GO TOP

DO WHILE !EOF("cur_subfam")
	lcSql = "insert into ramo_sf ( "
	lcSql = lcSql + "idSubFam, "
	lcSql = lcSql + "idRamo) "
	lcSql = lcSql + "values ( "
	lcSql = lcSql + ALLTRIM(STR(cur_subfam.idSubFam)) + ", "
	lcSql = lcSql + ALLTRIM(STR(Thisform.object_dataservice.idRamo)) + ")"
	
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute() THEN
		goConn.Rollback()
		MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
		RETURN .F.
	ENDIF

	SELECT cur_subfam
	SKIP
ENDDO

goConn.Commit()

Thisform.actualizar_cursor()
Thisform.CambiarEstado(.T.)
Thisform.pgf.Page1.enabled = .T.
Thisform.Pgf.Page1.SetFocus()
Thisform.Pgf.Page1.grdDatos.SetFocus()

RETURN .T.
ENDPROC
PROCEDURE Herramientas.nuevo
DODEFAULT()

SELECT cur_mrcsv
ZAP
SELECT cur_familias
ZAP
SELECT cur_subfam
ZAP

ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Descripción:"
Height = 15
Left = 15
Top = 15
Width = 84
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: txtDescripcion
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 94
Top = 9
Width = 576
cfieldname = descripcio
ischaracter = .T.
msgerror = Debe ingresar la descripción
Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Parámetros para generar la lista de precios que le corresponde al ramo."
Height = 15
Left = 15
Top = 40
Width = 420
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: pgf
************************************************************
*** PROPIEDADES ***
ErasePage = .T.
PageCount = 3
Top = 63
Left = 15
Width = 1116
Height = 468
Name = "pgf"
Page1.Caption = "Marcas de vehículos"
Page1.Name = "Page1"
Page2.Caption = "Familias"
Page2.Name = "Page2"
Page3.FontBold = .T.
Page3.FontItalic = .T.
Page3.FontSize = 8
Page3.Caption = "Subfamilias"
Page3.ForeColor = 128,64,64
Page3.Name = "Page3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Vehículos:"
Height = 15
Left = 23
Top = 21
Width = 72
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: sel_marcasv
************************************************************
*** PROPIEDADES ***
Top = 14
Left = 93
esnumerico = .T.
nombre_campo_codigo = idMarcaV
nombre_campo_desc = descripcio
nombre_tabla = marcas_v
pkfield = idMarcaV
Name = "sel_marcasv"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: grdMarcasV
************************************************************
*** PROPIEDADES ***
Height = 381
Left = 8
Top = 53
Width = 1097
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdMarcasV"
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
OBJETO: btnAgregar
************************************************************
*** PROPIEDADES ***
Top = 5
Left = 594
Name = "btnAgregar"

*** METODOS ***
PROCEDURE Click
IF This.Parent.sel_marcasv.valcpoid = 0 THEN
	MESSAGEBOX("Debe ingresar la marca", 0+48, Thisform.Caption)
	This.Parent.sel_marcasv.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

SELECT cur_mrcsv
APPEND BLANK
REPLACE cur_mrcsv.idMarcaV WITH This.Parent.sel_marcasv.valcpoid
REPLACE cur_mrcsv.descripcio WITH This.Parent.sel_marcasv.txtDescripcion.Value

This.Parent.grdMarcasV.Refresh()
This.Parent.sel_marcasv.blanquear()
This.Parent.sel_marcasv.txtCodigo.SetFocus()

RETURN .T.
ENDPROC


************************************************************
OBJETO: btnCancelar
************************************************************
*** PROPIEDADES ***
Top = 5
Left = 641
Name = "btnCancelar"

*** METODOS ***
PROCEDURE Click
This.Parent.sel_marcasv.blanquear()
This.Parent.sel_marcasv.txtCodigo.SetFocus()
ENDPROC


************************************************************
OBJETO: btnEliminar
************************************************************
*** PROPIEDADES ***
Top = 5
Left = 1060
Name = "btnEliminar"

*** METODOS ***
PROCEDURE Click
LOCAL lnResp

lnResp = MESSAGEBOX("¿Está seguro que desea eliminar la marca?", 4+32, Thisform.Caption)

IF lnResp = 6 THEN
	SELECT cur_mrcsv
	DELETE
	
	This.Parent.grdMarcasV.Refresh()
ENDIF

ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Familias:"
Height = 15
Left = 26
Top = 20
Width = 72
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: sel_familia
************************************************************
*** PROPIEDADES ***
Top = 13
Left = 96
esnumerico = .T.
nombre_campo_codigo = idFamilia
nombre_campo_desc = descripcio
nombre_tabla = familias
pkfield = idFamilia
Name = "sel_familia"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: grdFamilias
************************************************************
*** PROPIEDADES ***
Height = 380
Left = 5
Top = 52
Width = 1100
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdFamilias"
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
OBJETO: btnAgregar
************************************************************
*** PROPIEDADES ***
Top = 4
Left = 597
Name = "btnAgregar"

*** METODOS ***
PROCEDURE Click
IF This.Parent.sel_familia.valcpoid = 0 THEN
	MESSAGEBOX("Debe ingresar la familia", 0+32, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_familias
APPEND BLANK
REPLACE cur_familias.idFamilia WITH This.Parent.sel_familia.valcpoid
REPLACE cur_familias.descripcio WITH This.Parent.sel_familia.txtDescripcion.Value ADDITIVE

This.Parent.grdFamilias.Refresh()
This.Parent.sel_familia.blanquear()
This.Parent.sel_familia.txtCodigo.SetFocus()

RETURN .T.
ENDPROC


************************************************************
OBJETO: btnCancelar
************************************************************
*** PROPIEDADES ***
Top = 4
Left = 645
Name = "btnCancelar"

*** METODOS ***
PROCEDURE Click
This.Parent.sel_familia.blanquear()
This.Parent.sel_familia.txtCodigo.SetFocus()
ENDPROC


************************************************************
OBJETO: btnEliminar
************************************************************
*** PROPIEDADES ***
Top = 4
Left = 1061
Name = "btnEliminar"

*** METODOS ***
PROCEDURE Click
LOCAL lnResp

lnResp = MESSAGEBOX("¿Está seguro que desea eliminar el filtro por familia?", 4+32, Thisform.Caption)

IF lnResp = 6 THEN
	SELECT cur_familias
	DELETE
	
	This.Parent.grdFamilias.Refresh()
ENDIF
ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Subfamilia:"
Height = 15
Left = 31
Top = 22
Width = 72
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: sel_subfam
************************************************************
*** PROPIEDADES ***
Top = 15
Left = 101
esnumerico = .T.
nombre_campo_codigo = idSubFam
nombre_campo_desc = descripcio
nombre_tabla = subfam
pkfield = idSubFam
Name = "sel_subfam"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: grdSubFam
************************************************************
*** PROPIEDADES ***
Height = 377
Left = 8
Top = 54
Width = 1094
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdSubFam"
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
OBJETO: btnAgregar
************************************************************
*** PROPIEDADES ***
Top = 6
Left = 602
Name = "btnAgregar"

*** METODOS ***
PROCEDURE Click
IF This.Parent.sel_subfam.valcpoid = 0 THEN
	MESSAGEBOX("Debe ingresar la subfamilia", 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_subfam
APPEND BLANK
REPLACE cur_subfam.idSubFam WITH This.Parent.sel_subfam.valcpoid
REPLACE cur_subfam.descripcio WITH ALLTRIM(This.Parent.sel_subfam.txtDescripcion.Value) ADDITIVE

This.Parent.grdSubFam.Refresh()
This.Parent.sel_subfam.blanquear()
This.Parent.sel_subfam.txtCodigo.SetFocus()

RETURN .T.
ENDPROC


************************************************************
OBJETO: btnCancelar
************************************************************
*** PROPIEDADES ***
Top = 6
Left = 650
Name = "btnCancelar"

*** METODOS ***
PROCEDURE Click
This.Parent.sel_subfam.blanquear()
This.Parent.sel_subfam.txtCodigo.SetFocus()
ENDPROC


************************************************************
OBJETO: btnEliminar
************************************************************
*** PROPIEDADES ***
Top = 5
Left = 1059
Name = "btnEliminar"

*** METODOS ***
PROCEDURE Click
LOCAL lnResp

lnResp = MESSAGEBOX("¿Está seguro que desea eliminar el filtro por subfamilia?", 4+32, Thisform.Caption)

IF lnResp = 6 THEN
	SELECT cur_subfam
	DELETE
	
	This.Parent.grdSubFam.Refresh()
ENDIF
ENDPROC


************************************************************
OBJETO: cls_abm_ramos
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_abm_pers
************************************************************
*** PROPIEDADES ***
DoCreate = .T.
Caption = "ABM Personal"
MinButton = .T.
cnombretabla = personal
listctrlsource = idPers,apelNom
listwidthcols = 70,250
pk_fieldname = idPers
pk_identity = .T.
titulos_cabeceras = #,Apellido y Nombre(s)
Name = "cls_abm_pers"
Herramientas.cmdNuevo.Name = "cmdNuevo"
Herramientas.cmdEditar.Name = "cmdEditar"
Herramientas.cmdEliminar.Name = "cmdEliminar"
Herramientas.cmdCerrar.Name = "cmdCerrar"
Herramientas.cmdGrabar.Name = "cmdGrabar"
Herramientas.cmdCancelar.Name = "cmdCancelar"
Herramientas.CMDEXCEL.Name = "CMDEXCEL"
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
OBJETO: CLSETIQUETA1
************************************************************
*** PROPIEDADES ***
Caption = "Apellido y Nombre(s):"
Height = 15
Left = 24
Top = 27
Width = 132
Name = "CLSETIQUETA1"

*** METODOS ***


************************************************************
OBJETO: txtApelNom
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 156
MaxLength = 60
Top = 24
Width = 612
cfieldname = apelNom
ischaracter = .T.
msgerror = Debe ingresar el apellido y nombre(s)
Name = "txtApelNom"

*** METODOS ***


************************************************************
OBJETO: cls_abm_pers
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


