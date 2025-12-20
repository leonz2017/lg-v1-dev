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
TabIndex = 13
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
TabIndex = 15
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
TabIndex = 16
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
TabIndex = 17
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
TabIndex = 18
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
TabIndex = 20
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: txtCbte
************************************************************
*** PROPIEDADES ***
Left = 148
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
Left = 148
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
Left = 148
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
Left = 148
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
Left = 148
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
TabIndex = 23
Name = "Clsetiqueta7"

*** METODOS ***


************************************************************
OBJETO: txtNroCAI
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 148
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
Left = 258
Top = 16
Width = 47
TabIndex = 14
Name = "Clsetiqueta8"

*** METODOS ***


************************************************************
OBJETO: txtTipoDoc
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 298
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
Left = 148
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
Left = 439
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
Caption = "Host"
Height = 15
Left = 33
Top = 180
Width = 89
TabIndex = 19
Name = "Clsetiqueta9"

*** METODOS ***


************************************************************
OBJETO: txtHostName
************************************************************
*** PROPIEDADES ***
Tag = ""
Enabled = .F.
Height = 21
Left = 148
TabIndex = 12
Top = 175
Width = 289
ischaracter = .T.
cfieldname = impresora
msgerror = 
requerido = .F.
Name = "txtHostName"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta10
************************************************************
*** PROPIEDADES ***
Caption = "Report Cbte.:"
Left = 33
Top = 201
TabIndex = 21
Name = "Clsetiqueta10"

*** METODOS ***


************************************************************
OBJETO: txtRepName
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 148
TabIndex = 10
Top = 198
Width = 601
ischaracter = .T.
cfieldname = repname
msgerror = Debe ingresar el nombre del reporte
requerido = .F:
Name = "txtRepName"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta11
************************************************************
*** PROPIEDADES ***
Caption = "Report p/conceptos:"
Height = 15
Left = 33
Top = 224
Width = 114
TabIndex = 22
Name = "Clsetiqueta11"

*** METODOS ***


************************************************************
OBJETO: txtRepNameCpto
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 148
TabIndex = 11
Top = 221
Width = 601
ischaracter = .T.
cfieldname = repnamecp
msgerror = Debe ingresar el nombre del reporte para imprimir por concepto
requerido = .F.
Name = "txtRepNameCpto"

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
LOCAL llUsaTicket

DODEFAULT()

CREATE CURSOR cur_impresoras ( ;
	idImpres int,;
	idNum int,;
	cbte varchar(3),;
	ptoVta varchar(5),;
	tipoDoc varchar(1),;
	hostName varchar(50),;
	impresora varchar(100),;
	copias int,;
	usa_ticket L)	

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
		llUsaTicket = cur_x.usa_ticket
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
	REPLACE cur_impresoras.usa_ticket WITH llUsaTicket ADDITIVE

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
Thisform.contenido.chkUsaTicket.Value = IIF(cur_impresoras.usa_ticket, 1, 0)
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
TabIndex = 8
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
TabIndex = 9
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
Top = 413
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
TabIndex = 6
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
	lcSql = lcSql + "idImpres, idNum, hostName, impresora, copias, usa_ticket) "
	lcSql = lcSql + "VALUES (" + ALLTRIM(STR(lnProxID)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_impresoras.idNum)) + ", "
	lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "', "
	lcSql = lcSql + "'" + STRTRAN(ALLTRIM(Thisform.Contenido.txtImpresora.Value), "\", "\\") + "', "
	lcSql = lcSql + ALLTRIM(STR(Thisform.contenido.txtCopias.Value)) + ", "
	lcSql = lcSql + ALLTRIM(STR(Thisform.contenido.chkUsaTicket.Value)) + ")"
ELSE
	lcSql = "UPDATE impresoras "
	lcSql = lcSql + "SET impresora = '" + STRTRAN(ALLTRIM(Thisform.Contenido.txtImpresora.Value), "\", "\\") + "', "
	lcSql = lcSql + "	hostName = '" + ALLTRIM(SYS(0)) + "', "
	lcSql = lcSql + "	copias = " + ALLTRIM(STR(Thisform.Contenido.txtCopias.Value)) + ", "
	lcSql = lcSql + "	usa_ticket = " + ALLTRIM(STR(Thisform.Contenido.chkUsaTicket.Value)) + " "
	lcSql = lcSql + "WHERE idImpres = " + ALLTRIM(STR(cur_impresoras.idImpres))
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
REPLACE cur_impresoras.usa_ticket WITH IIF(Thisform.contenido.chkUsaTicket.Value = 1, .T., .F.)
UNLOCK

thisform.contenido.grdImpresoras.SetFocus()
ENDPROC


************************************************************
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 481
Left = 895
TabIndex = 7
Name = "btnCerrar"

*** METODOS ***


************************************************************
OBJETO: chkUsaTicket
************************************************************
*** PROPIEDADES ***
Top = 443
Left = 177
Height = 18
Width = 130
Alignment = 0
Caption = "Usar ticketeadora"
TabIndex = 5
Name = "chkUsaTicket"

*** METODOS ***


************************************************************
OBJETO: cls_configurar_printer
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_abm_art_exivapto
************************************************************
*** PROPIEDADES ***
DoCreate = .T.
Caption = "A.B.M. Artículos Exceptuado IVA Presupuesto"
cnombretabla = art_exivapto
obj_dataservicename = cl_dat_art_exivapto
listctrlsource = codArt,descripcio
listwidthcols = 100,300
pk_fieldname = id
titulos_cabeceras = Código,Descripción
Name = "cls_abm_art_exivapto"
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
PROCEDURE Init
DODEFAULT()
this.pgf.page2.cnt_fields.chkHabilitado.Value = 1
ENDPROC
PROCEDURE actualizar_cursor
**********************************************************
* Actualizo los datos del cursor para refrescar la grilla
**********************************************************

IF this.lnuevo THEN
	* Si se agrega nuevo, agrego un nuevo registro en el cursor.
	SELECT cur_Tempo
	APPEND BLANK
	REPLACE cur_Tempo.id WITH this.object_dataservice.id
	REPLACE cur_Tempo.codArt WITH this.pgf.page2.cnt_fields.sel_articulo.txtCodigo.Value ADDITIVE
	REPLACE cur_Tempo.descripcio WITH this.pgf.page2.cnt_fields.sel_articulo.txtdescripcion.Value ADDITIVE
ELSE
	* En caso de edición actualizo los datos del cursor.
	SELECT cur_Tempo
	LOCK()
	REPLACE cur_Tempo.codArt WITH this.pgf.page2.cnt_fields.sel_articulo.txtCodigo.Value
	REPLACE cur_Tempo.descripcio WITH this.pgf.page2.cnt_fields.sel_articulo.txtdescripcion.Value ADDITIVE
	UNLOCK
ENDIF

SELECT cur_Tempo
this.pgf.page1.grdDatos.Refresh()
ENDPROC
PROCEDURE asignarcampos
*****************************************************
* Asigno los campos
*****************************************************

this.object_dataservice.id = 0

IF !this.lnuevo THEN
	this.object_dataservice.id = cur_Tempo.id
ENDIF

this.object_dataservice.idarticulo = Thisform.pgf.page2.cnt_fields.sel_articulo.valcpoid
this.object_dataservice.habilitado = estandarizar_checkbox_value(Thisform.pgf.page2.cnt_fields.chkHabilitado.Value)


ENDPROC
PROCEDURE blanquear
DODEFAULT()
this.object_dataservice.id = 0
this.pgf.page2.cnt_fields.chkHabilitado.Value = 1
ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Artículo:"
Height = 15
Left = 20
Top = 21
Width = 60
TabIndex = 3
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: sel_articulo
************************************************************
*** PROPIEDADES ***
Top = 16
Left = 90
TabIndex = 1
cfieldname = idArticulo
criterio_filtro = fecBaja IS NULL AND habilitado = 1
nombre_campo_codigo = codArt
nombre_campo_desc = descripcio
nombre_tabla = articulos
pkfield = idArticulo
msgerror = Debe ingresar el artículo
autocompletar_ceros = .F.
Name = "sel_articulo"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: chkHabilitado
************************************************************
*** PROPIEDADES ***
Top = 48
Left = 498
Height = 18
Width = 72
Alignment = 0
Caption = "Habilitado"
Value = 1
TabIndex = 2
cfieldname = habilitado
Name = "chkHabilitado"

*** METODOS ***


************************************************************
OBJETO: cls_abm_art_exivapto
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
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
codiart_counter = 0
porimpuin_changed = .F.
impimpuintmay_changed = .F.
impimpuintmin_changed = .F.
cexpresion_busqueda = 
listctrlsource = Codart,Descripcio,marca,subfam,fecActuPre
listwidthcols = 150,350,140,140,110
titulos_cabeceras = Código,Descripción,Marca,Subfamilia,Ult. Act.
pk_fieldname = idarticulo
cnombretabla = articulos
obj_dataservicename = cl_dat_articulos
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
PGF.Page1.GRDDATOS.Height = 360
PGF.Page1.GRDDATOS.Left = 2
PGF.Page1.GRDDATOS.TabIndex = 2
PGF.Page1.GRDDATOS.Top = 114
PGF.Page1.GRDDATOS.Width = 931
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

&& Agrego el calculo del impuesto interno.
IF estandarizar_checkbox_value(Thisform.pgf.page2.cnt_fields.internalPgf.page1.chkUsarImpuestosInternos.Value) = 1 THEN
	&& Si modifico el precio del artículo, bonificaciones y/o margenes, para calcular el
	&& impuesto interno me baso en el porcentaje que se encuentra cargado
	Thisform.porimpuin_changed = .t.
	Thisform.calcular_impuestos_internos()
ENDIF
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


&& Agrego el estado inicial de los campos para impuestos internos
&& según como viene dado el dato en el cursor o si es cero que se
&& da cuenta si el idarticulo es 0 (cero).
IF Thisform.idarticulo <> 0
	IF !cur_tempo.usarImpuIn THEN
		Thisform.pgf.Page2.Cnt_Fields.internalPgf.Page1.chkUsarImpuestosInternos.Value = .F.
		Thisform.pgf.Page2.Cnt_Fields.internalPgf.Page1.txtPorImpuIn.Enabled = .F.
		Thisform.pgf.Page2.Cnt_Fields.internalPgf.Page1.txtImpImpuIntMay.Enabled = .F.
		Thisform.pgf.Page2.Cnt_Fields.internalPgf.Page1.txtImpImpuIntMin.Enabled = .F.
	ELSE
		Thisform.pgf.Page2.Cnt_Fields.internalPgf.Page1.chkUsarImpuestosInternos.Value = .T.
		Thisform.pgf.Page2.Cnt_Fields.internalPgf.Page1.txtPorImpuIn.Enabled = .T.
		Thisform.pgf.Page2.Cnt_Fields.internalPgf.Page1.txtImpImpuIntMay.Enabled = .T.
		Thisform.pgf.Page2.Cnt_Fields.internalPgf.Page1.txtImpImpuIntMin.Enabled = .T.
	ENDIF
	
	&& Detecto si tengo que habilitar los datos de moneda extranjera o no en base a los 
	&& datos qeu vienen cargado si edito un registro.
	IF cur_Tempo.usarMonExt THEN
		Thisform.pgf.Page2.Cnt_Fields.internalPgf.Page1.chkHabilitarMonedaExtrangera.Value = 1
		Thisform.pgf.Page2.Cnt_Fields.internalPgf.Page1.cmbTipoMon.Enabled = .T.
		Thisform.pgf.Page2.Cnt_Fields.internalPgf.Page1.txtCotizacion.Enabled = .T.
		Thisform.pgf.Page2.Cnt_Fields.internalPgf.Page1.txtPrExt.Enabled = .T.
	ELSE
		Thisform.pgf.Page2.Cnt_Fields.internalPgf.Page1.chkHabilitarMonedaExtrangera.Value = 0
		Thisform.pgf.Page2.Cnt_Fields.internalPgf.Page1.cmbTipoMon.Enabled = .F.
		Thisform.pgf.Page2.Cnt_Fields.internalPgf.Page1.txtCotizacion.Enabled = .F.
		Thisform.pgf.Page2.Cnt_Fields.internalPgf.Page1.txtPrExt.Enabled = .F.
	ENDIF
	
ELSE
	&& Si estoy agragando un artículo nuevo, entonces, pongo el estado inicial
	Thisform.pgf.Page2.Cnt_Fields.internalPgf.Page1.chkUsarImpuestosInternos.Value = .F.
	Thisform.pgf.Page2.Cnt_Fields.internalPgf.Page1.txtPorImpuIn.Enabled = .F.
	Thisform.pgf.Page2.Cnt_Fields.internalPgf.Page1.txtImpImpuIntMay.Enabled = .F.
	Thisform.pgf.Page2.Cnt_Fields.internalPgf.Page1.txtImpImpuIntMin.Enabled = .F.
	
	&& Estado inicial de moneda extrangera
	Thisform.pgf.Page2.Cnt_Fields.internalPgf.Page1.chkHabilitarMonedaExtrangera.Value = 0
	Thisform.pgf.Page2.Cnt_Fields.internalPgf.Page1.cmbTipoMon.Enabled = .F.
	Thisform.pgf.Page2.Cnt_Fields.internalPgf.Page1.txtCotizacion.Enabled = .F.
	Thisform.pgf.Page2.Cnt_Fields.internalPgf.Page1.txtPrExt.Enabled = .F.	
ENDIF


&& Lo que nunca se debe habilitar
Thisform.pgf.page2.cnt_fields.internalPgf.page1.txtCostoRep.Enabled = .F.
Thisform.pgf.page2.cnt_fields.internalPgf.page1.txtPrVentaMax.Enabled = .F.
Thisform.pgf.page2.cnt_fields.internalPgf.page1.txtPrVentaMin.Enabled = .F.
Thisform.pgf.page2.cnt_fields.internalPgf.page1.txtPrFinalMax.Enabled = .F.
Thisform.pgf.page2.cnt_fields.internalPgf.page1.txtPrFinalMin.Enabled = .F.
ENDPROC
PROCEDURE grabar_codiart
LOCAL loCommand, lnProxID

lnProxID = 0
loCommand = CREATEOBJECT("odbc_command")

SELECT cur_codiart
IF RECCOUNT("cur_codiart") > 0 THEN
	GO TOP
ENDIF

loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = "CALL codiart_deleteByArtic (?pIdArticulo)"
loCommand.AddParameter("pIdArticulo", ALLTRIM(STR(cur_tempo.idArticulo)), .f., .f.)
IF !loCommand.Execute() THEN
	RETURN .F.
ENDIF

SELECT cur_codiart
DO WHILE !EOF("cur_codiart")	
	loCommand.CommandText = "CALL codiart_insert (?pIdArticulo, ?pCodArt, ?pCodigos, ?pTipo, ?pCantiDesp, ?pCircuito)"
	loCommand.AddParameter("pIdArticulo", ALLTRIM(STR(cur_codiart.idArticulo)), .f., .f.)
	loCommand.AddParameter("pCodArt", ALLTRIM(cur_codiart.codArt), .t., .f.)
	loCommand.AddParameter("pCodigos", ALLTRIM(cur_codiart.codigos), .t., .f.)
	loCommand.AddParameter("pTipo", ALLTRIM(cur_codiart.tipo), .t., .f.)
	loCommand.AddParameter("pCantiDesp", ALLTRIM(STR(cur_codiart.cantiDesp, 10, 2)), .t., .f.)
	loCommand.AddParameter("pCircuito", ALLTRIM(cur_codiart.circuito), .t., .f.)	
	loCommand.ActiveConnection = goConn.ActiveConnection
	IF !loCommand.execute() THEN
		RETURN .F.
	ENDIF
	SELECT cur_codiart
	SKIP
ENDDO

RETURN .T.
ENDPROC
PROCEDURE asignar_marcas_v
LOCAL loCommand
LOCAL lcSql

loCommand = CREATEOBJECT("odbc_command")
lcSql = ""

loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = "CALL art_mrv_deleteByArt (?pIdArticulo)"
loCommand.AddParameter("pIdArticulo", ALLTRIM(STR(Thisform.idArticulo)), .f., .f.)
IF !loCommand.Execute() THEN
	MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_mrcsv
GO TOP
DO WHILE !EOF("cur_mrcsv")
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = "CALL art_mrv_insert (?pIdMarcaV, ?pIdArticulo)"
	loCommand.AddParameter("pIdMarcaV", ALLTRIM(STR(cur_mrcsv.idMarcaV)), .f., .f.)
	loCommand.AddParameter("pIdArticulo", ALLTRIM(STR(cur_mrcsv.idArticulo)), .f., .f.)	
	IF !loCommand.Execute() THEN
		MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
		RETURN .F.
	ENDIF

	SELECT cur_mrcsv
	SKIP
ENDDO

RETURN .T.
ENDPROC
PROCEDURE insert
**
* Este método permite insertar un artículo nuevo.
* Desarrollado por LINFOW
* Modificado: 07/08/2021
**

LOCAL loRes
LOCAL lcSql

lcSql = "CALL articulos_insert (" ;
	+ "	?idProv, ?idFamilia, ?idSubFam, ?idmarca, ?codigo, ?descripcio, " ;
	+ "	?alicIVA, ?tmon, ?prListaExt, ?cotizac, ?prLista, ?bonif1, ?bonif2, ?bonif3, " ;
	+ "	?bonif4, ?costoRep,	?margenMax,	?margenMin,	?prventaMax, ?prventaMin, ?prfinalMax, " ;
	+ "	?prfinalMin, ?p_usarImpuIn, ?p_porImpuIn, ?p_impImInMay, ?p_impImInMin, ?observ, " ;
	+ " ?habilitado, ?linkfoto, ?usualta, ?idhostalta, " ;
	+ "	?esServ, ?idUniMed,	?codArtPV, ?mostrador, ?llevastk, ?p_usarMonExt, ?p_promocion)"

loRes = CREATEOBJECT("odbc_result")
lcSql = loRes.AddParameter(lcSql, "idProv", ALLTRIM(STR(Thisform.Pgf.Page2.cnt_fields.sel_Proveedor.valcpoid)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "idFamilia", ALLTRIM(STR(Thisform.pgf.page2.cnt_fields.sel_Familia.valcpoid)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "idSubFam", ALLTRIM(STR(Thisform.pgf.page2.cnt_fields.sel_SubFamilia.valcpoid)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "idmarca", ALLTRIM(STR(Thisform.pgf.page2.cnt_fields.sel_Marca.valcpoid)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "codigo", ALLTRIM(Thisform.pgf.page2.cnt_fields.txtCodigo.Value), .t., .f.)
lcSql = loRes.AddParameter(lcSql, "descripcio", ALLTRIM(Thisform.pgf.page2.cnt_fields.txtDescripcion.Value), .t., .f.)
lcSql = loRes.AddParameter(lcSql, "alicIVA", ALLTRIM(STR(Thisform.pgf.page2.cnt_fields.txtAlicIVA.Value, 10, 2)), .t., .f.)
lcSql = loRes.AddParameter(lcSql, "tmon", ALLTRIM(Thisform.pgf.page2.cnt_fields.internalPgf.page1.cmbTipoMon.Value), .t., .f.)
lcSql = loRes.AddParameter(lcSql, "prListaExt", ALLTRIM(STR(Thisform.pgf.page2.cnt_fields.internalPgf.page1.txtPrExt.Value, 10, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "cotizac", ALLTRIM(STR(Thisform.pgf.page2.cnt_fields.internalPgf.page1.txtCotizacion.Value, 10, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "prLista", ALLTRIM(STR(Thisform.pgf.page2.cnt_fields.internalPgf.page1.txtPrLista.Value, 10, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "bonif1", ALLTRIM(STR(Thisform.pgf.page2.cnt_fields.internalPgf.page1.txtBonif1.Value, 10, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "bonif2", ALLTRIM(STR(Thisform.pgf.page2.cnt_fields.internalPgf.page1.txtBonif2.Value, 10, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "bonif3", ALLTRIM(STR(Thisform.pgf.page2.cnt_fields.internalPgf.page1.txtBonif3.Value, 10, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "bonif4", ALLTRIM(STR(Thisform.pgf.page2.cnt_fields.internalPgf.page1.txtBonif4.Value, 10, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "costoRep", ALLTRIM(STR(Thisform.pgf.page2.cnt_fields.internalPgf.page1.txtCostoRep.value, 10, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "margenMax", ALLTRIM(STR(Thisform.pgf.page2.cnt_fields.internalPgf.page1.txtMargenMax.Value, 10, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "margenMin", ALLTRIM(STR(Thisform.pgf.page2.cnt_fields.internalPgf.page1.txtMargenMin.Value, 10, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "prventaMax", ALLTRIM(STR(Thisform.pgf.page2.cnt_fields.internalPgf.page1.txtPrVentaMax.Value, 10, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "prventaMin", ALLTRIM(STR(Thisform.pgf.page2.cnt_fields.internalPgf.page1.txtPrVentaMin.Value, 10, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "prfinalMax", ALLTRIM(STR(Thisform.pgf.page2.cnt_fields.internalPgf.page1.txtPrFinalMax.Value, 10, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "prfinalMin", ALLTRIM(STR(Thisform.pgf.page2.cnt_fields.internalPgf.page1.txtPrFinalMin.Value, 10, 2)), .f., .f.)

&& Parametros de impuestos internos
lcSql = loRes.AddParameter(lcSql, "p_usarImpuIn", ;
		ALLTRIM(STR(IIF(Thisform.pgf.page2.cnt_fields.internalPgf.page1.chkUsarImpuestosInternos.Value, 1, 0), 10, 2)), ;
		.f., .f.)
lcSql = loRes.AddParameter(lcSql, "p_porImpuIn", ;
		ALLTRIM(STR(Thisform.pgf.page2.cnt_fields.internalPgf.page1.txtPorImpuIn.Value, 10, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "p_impImInMay", ;
		ALLTRIM(STR(Thisform.pgf.page2.cnt_fields.internalPgf.page1.txtImpImpuIntMay.Value, 10, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "p_impImInMin", ;
		ALLTRIM(STR(Thisform.pgf.page2.cnt_fields.internalPgf.page1.txtImpImpuIntMin.Value, 10, 2)), .f., .f.)
&& --

lcSql = loRes.AddParameter(lcSql, "observ", ALLTRIM(Thisform.pgf.page2.cnt_fields.internalPgf.page2.txtObserv.Value), .t., .f.)
lcSql = loRes.AddParameter(lcSql, "habilitado", ALLTRIM(STR(Thisform.pgf.page2.cnt_fields.chkHabilitado.Value)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "linkfoto", ALLTRIM(Thisform.pgf.page2.cnt_fields.txtPathFoto.Value), .t., .f.)
lcSql = loRes.AddParameter(lcSql, "usualta", ALLTRIM(gcCodUsu), .t., .f.)
lcSql = loRes.AddParameter(lcSql, "idhostalta", ALLTRIM(SYS(0)), .t., .f.)
lcSql = loRes.AddParameter(lcSql, "esServ", ALLTRIM(STR(Thisform.pgf.page2.cnt_fields.chkEsServicio.Value)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "idUniMed", ALLTRIM(STR(Thisform.pgf.page2.cnt_fields.sel_unimed.valcpoid)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "codArtPV", ALLTRIM(Thisform.pgf.page2.cnt_fields.txtCodArtPV.Value), .t., .f.)
lcSql = loRes.AddParameter(lcSql, "mostrador", ALLTRIM(STR(Thisform.pgf.page2.cnt_fields.chkMostrador.Value)), .f., .f.)

lcSql = loRes.AddParameter(lcSql, "llevastk", ALLTRIM(STR(thisform.pgf.page2.cnt_fields.chkLlevaStock.Value)),.f., .f.)

&& Paso el parámetro que indica si uso moneda extrangera
lcSql = loRes.AddParameter(lcSql, "p_usarMonExt", ;
		ALLTRIM(STR(Thisform.pgf.page2.cnt_fields.internalPgf.page1.chkHabilitarMonedaExtrangera.Value)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "p_promocion", ;
		ALLTRIM(STR(Thisform.pgf.Page2.cnt_fields.chkMerchandising.value)), .f., .f.)

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_result"
loRes.OpenQuery(lcSql)
SELECT cur_result
thisform.idarticulo = cur_result.result
loRes.Close_Query()
IF Thisform.idarticulo = -1 THEN
	RETURN .f.
ENDIF
Thisform.object_dataservice.idarticulo = thisform.idarticulo
RETURN .t.



ENDPROC
PROCEDURE update
**
* Este método permite actualizar los datos de un artículo existente.
* Desarrollado por: LINFOW
* Fecha: 07/08/2021
**

LOCAL loRes
LOCAL lcSql
LOCAL lnResult

lcSql = "CALL articulos_update(" ;
	+ "	?idArticulo, ?idProv, ?idFamilia, ?idSubFam, ?idmarca, ?codigo, ?descripcio, " ;
	+ "	?alicIVA, ?tmon, ?prListaExt, ?cotizac, ?prLista, ?bonif1, ?bonif2, ?bonif3, " ;
	+ "	?bonif4, ?costoRep,	?margenMax,	?margenMin,	?prventaMax, ?prventaMin, ?prfinalMax, " ;
	+ "	?prfinalMin, ?p_usarImpuIn, ?p_porImpuIn, ?p_impImInMay, ?p_impImInMin, ?observ, " ;
	+ " ?habilitado, ?linkfoto, ?usumodi, ?idhostmodi, " ;
	+ "	?esServ, ?idUniMed,	?codArtPV, ?mostrador, ?llevastk, ?p_usarMonExt, ?p_promocion)"

loRes = CREATEOBJECT("odbc_result")
lcSql = loRes.AddParameter(lcSql, "idArticulo", ALLTRIM(STR(Thisform.idarticulo)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "idProv", ALLTRIM(STR(Thisform.Pgf.Page2.cnt_fields.sel_Proveedor.valcpoid)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "idFamilia", ALLTRIM(STR(Thisform.pgf.page2.cnt_fields.sel_Familia.valcpoid)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "idSubFam", ALLTRIM(STR(Thisform.pgf.page2.cnt_fields.sel_SubFamilia.valcpoid)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "idmarca", ALLTRIM(STR(Thisform.pgf.page2.cnt_fields.sel_Marca.valcpoid)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "codigo", ALLTRIM(Thisform.pgf.page2.cnt_fields.txtCodigo.Value), .t., .f.)
lcSql = loRes.AddParameter(lcSql, "descripcio", ALLTRIM(Thisform.pgf.page2.cnt_fields.txtDescripcion.Value), .t., .f.)
lcSql = loRes.AddParameter(lcSql, "alicIVA", ALLTRIM(STR(Thisform.pgf.page2.cnt_fields.txtAlicIVA.Value, 10, 2)), .t., .f.)
lcSql = loRes.AddParameter(lcSql, "tmon", ALLTRIM(Thisform.pgf.page2.cnt_fields.internalPgf.page1.cmbTipoMon.Value), .t., .f.)
lcSql = loRes.AddParameter(lcSql, "prListaExt", ALLTRIM(STR(Thisform.pgf.page2.cnt_fields.internalPgf.page1.txtPrExt.Value, 10, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "cotizac", ALLTRIM(STR(Thisform.pgf.page2.cnt_fields.internalPgf.page1.txtCotizacion.Value, 10, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "prLista", ALLTRIM(STR(Thisform.pgf.page2.cnt_fields.internalPgf.page1.txtPrLista.Value, 10, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "bonif1", ALLTRIM(STR(Thisform.pgf.page2.cnt_fields.internalPgf.page1.txtBonif1.Value, 10, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "bonif2", ALLTRIM(STR(Thisform.pgf.page2.cnt_fields.internalPgf.page1.txtBonif2.Value, 10, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "bonif3", ALLTRIM(STR(Thisform.pgf.page2.cnt_fields.internalPgf.page1.txtBonif3.Value, 10, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "bonif4", ALLTRIM(STR(Thisform.pgf.page2.cnt_fields.internalPgf.page1.txtBonif4.Value, 10, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "costoRep", ALLTRIM(STR(Thisform.pgf.page2.cnt_fields.internalPgf.page1.txtCostoRep.value, 10, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "margenMax", ALLTRIM(STR(Thisform.pgf.page2.cnt_fields.internalPgf.page1.txtMargenMax.Value, 10, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "margenMin", ALLTRIM(STR(Thisform.pgf.page2.cnt_fields.internalPgf.page1.txtMargenMin.Value, 10, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "prventaMax", ALLTRIM(STR(Thisform.pgf.page2.cnt_fields.internalPgf.page1.txtPrVentaMax.Value, 10, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "prventaMin", ALLTRIM(STR(Thisform.pgf.page2.cnt_fields.internalPgf.page1.txtPrVentaMin.Value, 10, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "prfinalMax", ALLTRIM(STR(Thisform.pgf.page2.cnt_fields.internalPgf.page1.txtPrFinalMax.Value, 10, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "prfinalMin", ALLTRIM(STR(Thisform.pgf.page2.cnt_fields.internalPgf.page1.txtPrFinalMin.Value, 10, 2)), .f., .f.)

&& Parametros de impuestos inernos
lcSql = loRes.AddParameter(lcSql, "p_usarImpuIn", ;
		ALLTRIM(STR(estandarizar_checkbox_value(Thisform.pgf.page2.cnt_fields.internalPgf.page1.chkUsarImpuestosInternos.Value))), ;
		.f., .f.)
lcSql = loRes.AddParameter(lcSql, "p_porImpuIn", ALLTRIM(STR(Thisform.pgf.page2.cnt_fields.internalPgf.page1.txtPorImpuIn.Value, 10, 2)), .f., .f.)

IF ISNULL(Thisform.pgf.page2.cnt_fields.internalPgf.page1.txtImpImpuIntMay.Value) THEN
	lcSql = loRes.AddParameter(lcSql, "p_impImInMay", ALLTRIM(STR(Thisform.pgf.page2.cnt_fields.internalPgf.page1.txtImpImpuIntMay.Value, 10, 2)), .f., .f.)
ELSE
	lcSql = loRes.AddParameter(lcSql, "p_impImInMay", "0", .f., .f.)
ENDIF

IF ISNULL(Thisform.pgf.page2.cnt_fields.internalPgf.page1.txtImpImpuIntMin.Value) THEN
	lcSql = loRes.AddParameter(lcSql, "p_impImInMin", "0", .f., .f.)
ELSE
	lcSql = loRes.AddParameter(lcSql, "p_impImInMin", ALLTRIM(STR(Thisform.pgf.page2.cnt_fields.internalPgf.page1.txtImpImpuIntMin.Value, 10, 2)), .f., .f.)
ENDIF
&& --

lcSql = loRes.AddParameter(lcSql, "observ", ALLTRIM(Thisform.pgf.page2.cnt_fields.internalPgf.page2.txtObserv.Value), .t., .f.)
lcSql = loRes.AddParameter(lcSql, "habilitado", ALLTRIM( ;
		STR(IIF(Thisform.pgf.page2.cnt_fields.chkHabilitado.Value, 1, 0))), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "linkfoto", ALLTRIM(IIF(ISNULL(Thisform.pgf.page2.cnt_fields.txtPathFoto.Value), "", Thisform.pgf.page2.cnt_fields.txtPathFoto.Value)), .t., .f.)
lcSql = loRes.AddParameter(lcSql, "usumodi", ALLTRIM(gcCodUsu), .t., .f.)
lcSql = loRes.AddParameter(lcSql, "idhostmodi", ALLTRIM(SYS(0)), .t., .f.)
lcSql = loRes.AddParameter(lcSql, "esServ", ALLTRIM( ;
		STR(IIF(Thisform.pgf.page2.cnt_fields.chkEsServicio.Value, 1, 0))), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "idUniMed", ALLTRIM(STR(Thisform.pgf.page2.cnt_fields.sel_unimed.valcpoid)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "codArtPV", ALLTRIM(IIF(ISNULL(Thisform.pgf.page2.cnt_fields.txtCodArtPV.Value), ;
		"", Thisform.pgf.page2.cnt_fields.txtCodArtPV.Value)), .t., .f.)
lcSql = loRes.AddParameter(lcSql, "mostrador", ALLTRIM( ;
		STR(IIF(Thisform.pgf.page2.cnt_fields.chkMostrador.Value, 1, 0))), .f., .f.)
		
lcSql = loRes.AddParameter(lcSql, "llevastk", ALLTRIM( ;
		STR(estandarizar_checkbox_value(thisform.pgf.page2.cnt_fields.chkLlevaStock.value))), .f., .f.)
		
&& Paso el parámetro que habilita o deshabilita el uso de moneda extrangera
lcSql = loRes.AddParameter(lcSql, "p_usarMonExt", ;
		ALLTRIM(STR(estandarizar_checkbox_value(Thisform.pgf.page2.cnt_fields.internalPgf.page1.chkHabilitarMonedaExtrangera.Value))), .f., .f.)
&& Agrego marca de si el artículo es merchandising
lcSql = loRes.AddParameter(lcSql, "p_promocion", ;
		ALLTRIM(STR(estandarizar_checkbox_value(Thisform.pgf.page2.cnt_fields.chkMerchandising.value))), .f., .f.)

_cliptext = lcSql
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_result"
IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN .f.
ENDIF
SELECT cur_result
lnResult = cur_result.result
loRes.Close_Query()
RETURN IIF(INT(VAL(lnResult)) = 0, .f., .t.)

ENDPROC
PROCEDURE grabar_equivs
LOCAL loResult
LOCAL lcSql

loResult = CREATEOBJECT("odbc_result")

SELECT cur_artequiv
GO TOP
DO WHILE !EOF("cur_artequiv")
	lcSql = "CALL equiv_grabar (?pIdArtic_A, ?pIdArtic_B, ?pEsNuevo)"
	lcSql = loResult.AddParameter(lcSql, "pIdArtic_A", ALLTRIM(STR(thisform.idArticulo)), .f., .f.)
	lcSql = loResult.AddParameter(lcSql, "pIdArtic_B", ALLTRIM(STR(cur_artequiv.idArticulo)), .f., .f.)
	lcSql = loResult.AddParameter(lcSql, "pEsNuevo", IIF(cur_artequiv.esNuevo, "1", "0"), .f., .f.)
	loResult.ActiveConnection = goConn.ActiveConnection
	loResult.Cursor_Name = "cur_result"
	loResult.OpenQuery(lcSql)
	IF !(ALLTRIM(cur_result.result) == "OK") THEN
		MESSAGEBOX(ALLTRIM(cur_result.result), 0+46, Thisform.Caption)
		RETURN .F.
	ENDIF
	SELECT cur_artequiv
	SKIP
ENDDO

RETURN .T.

ENDPROC
PROCEDURE leer_equivs
PARAMETERS tnIdArticulo

LOCAL lcSql
LOCAL loRes

lcSql = ""
loRes = CREATEOBJECT("odbc_result")
lcSql = "CALL equiv_leer (?pIdArtic_A)"
lcSql = loRes.AddParameter(lcSql, "pIdArtic_A", ALLTRIM(STR(tnIdArticulo)), .f., .f.)
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_temp"
loRes.OpenQuery(lcSql)
SELECT cur_artequiv 
ZAP
APPEND FROM DBF("cur_temp")
GO TOP
loRes.Close_Query()


ENDPROC
PROCEDURE eliminar_equiv
LOCAL lcSql
LOCAL loRes

lcSql = ""
loRes = CREATEOBJECT("odbc_result")

SELECT cur_delequiv
GO TOP
DO WHILE !EOF("cur_delequiv")
	lcSql = "CALL equiv_eliminar(?pIdArticulo)"
	lcSql = loRes.AddParameter(lcSql, "pIdArticulo", ALLTRIM(STR(cur_delequiv.idArtic)), .f., .f.)
	loRes.ActiveConnection = goConn.ActiveConnection
	loRes.Cursor_Name = "cur_result"
	loRes.OpenQuery(lcSql)
	IF !(ALLTRIM(cur_result.result) == "OK") THEN
		loRes.Close_Query()
		MESSAGEBOX(cur_result.result, 0+48, Thisform.Caption)
		RETURN .F.
	ENDIF
	loRes.Close_Query()

	SELECT cur_delequiv
	SKIP
ENDDO

SELECT cur_delequiv
ZAP

RETURN .T.
ENDPROC
PROCEDURE buscar
LOCAL lcExpresion
LOCAL lcValorBuscado
LOCAL lcPalabra
LOCAL lcAuxiliar
LOCAL i

lcValorBuscado = STRTRAN(ALLTRIM(This.Pgf.Page1.cnt_busqueda.txtValorBuscado.Value), " ", "*")
lcExpresion = "(LIKE('*" + ALLTRIM(lcValorBuscado) + "*', cur_Tempo.CodArt) " 
lcExpresion = lcExpresion + " OR LIKE('*" + ALLTRIM(lcValorBuscado) + "*', cur_Tempo.subfam) "
lcExpresion = lcExpresion + " OR LIKE('*" + ALLTRIM(lcValorBuscado) + "*', cur_Tempo.marca) "
lcExpresion = lcExpresion + " OR LIKE('*" + ALLTRIM(lcValorBuscado) + "*', cur_Tempo.descripcio)) "

* Filtra por marca.
SELECT cur_Tempo
IF This.Pgf.Page1.cnt_busqueda.sel_Marca.valcpoid <> 0 THEN
	IF ALLTRIM(lcExpresion) == "" THEN
		lcExpresion = lcExpresion + "cur_Tempo.idmarca = " + ALLTRIM(STR(This.Pgf.Page1.cnt_busqueda.sel_Marca.valcpoid)) + " "
	ELSE
		lcExpresion = lcExpresion + " AND cur_Tempo.idmarca = " + ALLTRIM(STR(This.Pgf.Page1.cnt_busqueda.sel_Marca.valcpoid)) + " "
	ENDIF
ENDIF

* 26/04/2024: Filtra por familia
IF This.Pgf.page1.cnt_busqueda.sel_Familia.valcpoid <> 0 THEN
	IF ALLTRIM(lcExpresion) == "" THEN
		lcExpresion = lcExpresion + "cur_Tempo.idFamilia = " + ALLTRIM(STR(This.Pgf.Page1.cnt_busqueda.sel_Familia.valcpoid))
	ELSE
		lcExpresion = lcExpresion + " AND cur_Tempo.idFamilia = " + ALLTRIM(STR(This.Pgf.Page1.cnt_busqueda.sel_Familia.valcpoid))
	ENDIF
ENDIF

* Filtra por subfamilia.
IF This.Pgf.Page1.cnt_busqueda.sel_subfam.valcpoid <> 0 THEN
	IF ALLTRIM(lcExpresion) == "" THEN
		lcExpresion = lcExpresion + "cur_Tempo.idsubfam = " + ALLTRIM(STR(This.Pgf.Page1.cnt_busqueda.sel_subfam.valcpoid))
	ELSE
		lcExpresion = lcExpresion + " AND cur_Tempo.idsubfam = " + ALLTRIM(STR(This.Pgf.Page1.cnt_busqueda.sel_subfam.valcpoid))
	ENDIF
ENDIF

* Filtr por proveedor
IF This.Pgf.page1.cnt_busqueda.sel_proveedores.valcpoid <> 0 THEN
	IF ALLTRIM(lcExpresion) == "" THEN
		lcExpresion = lcExpresion + "cur_Tempo.idprov = " + ALLTRIM(STR(This.Pgf.Page1.cnt_busqueda.sel_proveedores.valcpoid))
	ELSE
		lcExpresion = lcExpresion + " AND cur_Tempo.idprov = " + ALLTRIM(STR(This.Pgf.Page1.cnt_busqueda.sel_proveedores.valcpoid))
	ENDIF
ENDIF

This.Pgf.Page1.cnt_busqueda.chkMostrarTodos.Value = 0
This.cexpresion_busqueda = lcExpresion
SELECT cur_Tempo
SET FILTER TO &lcExpresion
SET ORDER TO TAG descripcio ASCENDING
GO TOP
This.Pgf.Page1.grdDatos.Refresh()
This.Pgf.Page1.grdDatos.SetFocus()

ENDPROC
PROCEDURE verificar_codigo
LOCAL loRes
LOCAL lcSql

loRes = CREATEOBJECT("odbc_result")
lcSql = "CALL articulos_getByCod (?pCodArt)"
lcSql = loRes.AddParameter(lcSql, "pCodArt", ALLTRIM(Thisform.pgf.page2.cnt_fields.txtCodigo.Value), .t., .f.)
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"
loRes.OpenQuery(lcSql)
SELECT cur_x
IF RECCOUNT("cur_x") > 0 THEN
	loRes.Close_Query()
	RETURN .F.
ENDIF
loRes.Close_Query()
RETURN .T.
ENDPROC
PROCEDURE calcular_impuestos_internos
**
* Este método permite calcular los impuestos internos tomando como refrencias
* las formulas que hice en el análisis.
* Desarrollado por: LINFOW
* Fecha: 07/08/2021
**

LOCAL lnPorImpuInt
LOCAL lnImpImpuInMay
LOCAL lnImpImpuInMin
LOCAL lnPrFinalMin
LOCAL lnPrFinalMay

&& Necesito los precios finales para hacer los cálculos a partir del precio final.
lnPrFinalMay = Thisform.Pgf.Page2.Cnt_Fields.internalPgf.Page1.txtPrFinalMax.Value
lnPrFinalMin = Thisform.Pgf.Page2.Cnt_Fields.internalPgf.Page1.txtPrFinalMin.Value

&& Inicializo las variables a partir de los valores
&& ingresados
lnPorImpuInt = Thisform.pgf.Page2.Cnt_Fields.internalPgf.Page1.txtPorImpuIn.Value
lnImpImpuInMay = Thisform.pgf.Page2.Cnt_Fields.internalPgf.Page1.txtImpImpuIntMay.Value
lnImpImpuInMin = Thisform.Pgf.Page2.Cnt_Fields.internalPgf.Page1.txtImpImpuIntMin.Value

IF Thisform.porimpuin_changed THEN
	&& Si modifico el porcentaje, entonces, caluclo los precios
	&& mayorista y minorista.
	lnImpImpuInMay = ROUND(lnPrFinalMay * (lnPorImpuInt / 100), 2)
	lnImpImpuInMin = ROUND(lnPrFinalMin * (lnPorImpuInt / 100), 2)
	Thisform.pgf.Page2.Cnt_Fields.internalPgf.Page1.txtImpImpuIntMay.Value = lnImpImpuInMay
	Thisform.pgf.Page2.Cnt_Fields.internalPgf.Page1.txtImpImpuIntMin.Value = lnImpImpuInMin
	RETURN
ENDIF

IF Thisform.impimpuintmay_changed THEN
	&& Si modifico el importe de impuesto a partir del precio
	&& mayorista, entonces, lo tomo como base para calcular
	&& el impuesto para minorista y el porcentaje
	lnPorImpuInt = ROUND((lnImpImpuInMay * 100) / lnPrFinalMay, 2)
	lnImpImpuInMin = ROUND(lnPrFinalMin * (lnPorImpuInt / 100), 2)
	Thisform.Pgf.Page2.Cnt_Fields.internalPgf.Page1.txtPorImpuIn.Value = lnPorImpuInt
	Thisform.Pgf.Page2.Cnt_Fields.internalPgf.Page1.txtImpImpuIntMin.Value = lnImpImpuInMin 
	RETURN
ENDIF

IF THisform.impimpuintmin_changed THEN
	&& Si se modificó el importe de impuesto minorista, lo tomo
	&& como base para calcular el porcentaje y el impuesto mayorista.
	lnPorImpuInt = ROUND((lnImpImpuInMin * 100) / lnPrFinalMin, 2)
	lnImpImpuInMay = ROUND(lnPrFinalMay * (lnPorImpuInt / 100), 2)
	Thisform.pgf.Page2.Cnt_Fields.internalPgf.Page1.txtPorImpuIn.Value = lnPorImpuInt
	Thisform.pgf.Page2.Cnt_Fields.internalPgf.Page1.txtImpImpuIntMay.Value = lnImpImpuInMay
	RETURN
ENDIF

&& Inicializo las marcas de cambios
Thisform.porimpuin_changed = .f.
Thisform.impimpuintmay_changed = .f.
Thisform.impimpuintmin_changed = .f.
ENDPROC
PROCEDURE habilitar_filtrados
**********************************************************************
* Este procedimiento permite deshabilitar los artículos según
* el filtro establecido.
**********************************************************************
LOCAL loCmd

loCmd = CREATEOBJECT("odbc_command")

* Recorro el cursor cur_tempo que ya lo tengo filtrado
goConn.BeginTransaction()
SELECT cur_tempo
GO TOP
DO WHILE !EOF("cur_tempo")
	WAIT WINDOW "Deshabilitando " + cur_tempo.codArt NOWAIT

	* Armo la sentencia SQL
	TEXT TO loCmd.CommandText NOSHOW
		UPDATE
			articulos
		SET
			articulos.habilitado = 1,
			articulos.usuModi = ?xusuModi,
			articulos.fecModi = current_timestamp,
			articulos.idHostModi  = ?xhost
		WHERE
			articulos.idArticulo = ?xidArticulo
	ENDTEXT
	loCmd.addParameter("xusuModi", ALLTRIM(gcCodUsu), .T., .F.)
	loCmd.addParameter("xhost", ALLTRIM(SYS(0)), .T., .F.)
	loCmd.AddParameter("xidArticulo", ALLTRIM(STR(cur_tempo.idArticulo)), .F., .F.)
	loCmd.ActiveConnection = goConn.ActiveConnection
	
	IF !loCmd.Execute() THEN
		goConn.Rollback()
		MESSAGEBOX(loCmd.ErrorMessage, 0+48, This.Caption)
		RETURN .F.
	ENDIF

	SELECT cur_tempo
	This.Pgf.Page1.grdDatos.SetAll("DynamicBackColor", "IIF(!cur_Tempo.habilitado, RGB(244, 197, 168), RGB(255, 255, 255))")
	thisform.pgf.page1.grdDatos.Refresh()
	SKIP
ENDDO

goConn.Commit()
MESSAGEBOX("Los artículos fueron deshabilitados con éxito", 0+64, Thisform.Caption)


ENDPROC
PROCEDURE dehsabilitar_filtrados
**********************************************************************
* Este procedimiento permite deshabilitar los artículos según
* el filtro establecido.
**********************************************************************
LOCAL loCmd

loCmd = CREATEOBJECT("odbc_command")

* Recorro el cursor cur_tempo que ya lo tengo filtrado
goConn.BeginTransaction()
SELECT cur_tempo
GO TOP
DO WHILE !EOF("cur_tempo")
	WAIT WINDOW "Deshabilitando " + cur_tempo.codArt NOWAIT

	* Armo la sentencia SQL
	TEXT TO loCmd.CommandText NOSHOW
		UPDATE
			articulos
		SET
			articulos.habilitado = 0,
			articulos.usuModi = ?xusuModi,
			articulos.fecModi = current_timestamp,
			articulos.idHostModi  = ?xhost
		WHERE
			articulos.idArticulo = ?xidArticulo
	ENDTEXT
	loCmd.addParameter("xusuModi", ALLTRIM(gcCodUsu), .T., .F.)
	loCmd.addParameter("xhost", ALLTRIM(SYS(0)), .T., .F.)	
	loCmd.AddParameter("xidArticulo", ALLTRIM(STR(cur_tempo.idArticulo)), .F., .F.)
	loCmd.ActiveConnection = goConn.ActiveConnection
	
	* Actualizo el cursor para refrescar la grilla
	SELECT cur_Tempo
	LOCK()
	REPLACE cur_Tempo.habilitado WITH .T.
	UNLOCK
	
	IF !loCmd.Execute() THEN
		goConn.Rollback()
		MESSAGEBOX(loCmd.ErrorMessage, 0+48, This.Caption)
		RETURN .F.
	ENDIF

	SELECT cur_tempo
	This.Pgf.Page1.grdDatos.SetAll("DynamicBackColor", "IIF(!cur_Tempo.habilitado, RGB(244, 197, 168), RGB(255, 255, 255))")
	thisform.pgf.page1.grdDatos.Refresh()
	SKIP
ENDDO

goConn.Commit()
MESSAGEBOX("Los artículos fueron deshabilitados con éxito", 0+64, Thisform.Caption)


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

CREATE CURSOR cur_artequiv ( ;
	idArticulo	int,;
	codArt		varchar(20),;
	descripcio	varchar(200),;
	esNuevo		L DEFAULT .F.)
	
&& Inicializo checkbox
thisform.pgf.page2.cnt_fields.internalPgf.page1.chkUsarImpuestosInternos.Value = 0
thisform.pgf.page2.cnt_fields.internalPgf.page1.chkHabilitarMonedaExtrangera.Value = 0
thisform.pgf.page2.cnt_fields.chkLlevaStock.Value = 0

&& Valido si el modulo de stock esta habilitado en la base de datos para mostrar el lleva stock
IF getGlobalCFG("STK_MODULE") THEN
	thisform.pgf.page2.cnt_fields.chkLlevaStock.Visible = .T.
	
ELSE
	thisform.pgf.page2.cnt_fields.chkLlevaStock.Visible = .F.

ENDIF

SELECT cur_artequiv
thisform.pgf.page2.cnt_fields.internalPgf.page4.grdEquivs.alias_name = "cur_artequiv"
thisform.pgf.page2.cnt_fields.internalPgf.page4.grdEquivs.RecordSource = "cur_artequiv"
thisform.pgf.page2.cnt_fields.internalPgf.page4.grdEquivs.titulos_cabeceras = "Código,Descripción"
thisform.pgf.page2.cnt_fields.internalPgf.page4.grdEquivs.lista_ancho_cols = "100,500"
thisform.pgf.page2.cnt_fields.internalPgf.page4.grdEquivs.list_controlsource = "codArt,descripcio"
thisform.pgf.page2.cnt_fields.internalPgf.page4.grdEquivs.generar_grid()

CREATE CURSOR cur_delequiv (;
	idArtic	int,;
	codArt	varchar(20)) 

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

This.Pgf.Page1.grdDatos.SetAll("DynamicBackColor", "IIF(!cur_Tempo.habilitado, RGB(244, 197, 168), RGB(255, 255, 255))")
This.Pgf.Page1.grdDatos.SetFocus()
This.Pgf.page1.btnHabilitar.Enabled = .F.
This.Pgf.Page1.btnDeshabilitar.Enabled = .F.


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

IF Thisform.lnuevo THEN
	IF !Thisform.verificar_codigo() THEN
		Thisform.msgerror = "Este código ya se encuentra cargado en el sistema"
		RETURN .F.
	ENDIF
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
**
* Este método permite recuperar los datos del artículo y mostrarlo en pantalla.
* Los datos se encuentran en el page interno
**

LOCAL lcReferencia, lnCont, lcFieldName
LOCAL lcSql, loResult

DODEFAULT()

lcSql = ""
loResult = CREATEOBJECT("odbc_result")

DIMENSION laCampos[1]

&&Recupero los datos de la solapa "Precios"
SELECT cur_Tempo
thisform.idarticulo = cur_tempo.idArticulo

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
						ctrl.value = &lcReferencia)
					ENDIF			
				CASE LOWER(ctrl.BaseClass) == "combobox"
					IF LOWER(ALLTRIM(ctrl.cFieldName)) == LOWER(ALLTRIM(lcFieldName)) THEN
						ctrl.value = &lcReferencia
					ENDIF			
				CASE LOWER(ctrl.BaseClass) == "editbox"
					IF LOWER(ALLTRIM(ctrl.cFieldName)) == LOWER(ALLTRIM(lcFieldName)) THEN
						ctrl.value = IIF(ISNULL(&lcReferencia), "", &lcReferencia)
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
	IF FILE(STRTRAN(cur_Tempo.linkfoto, "\\", "\")) THEN
		Thisform.Pgf.page2.cnt_Fields.picFoto.Picture = STRTRAN(cur_Tempo.linkfoto, "\\", "\")
		
		IF INT(VAL(getconfig("SQLSRV"))) = 1 THEN	
			Thisform.Pgf.Page2.cnt_Fields.txtPathFoto.Value = STRTRAN(cur_Tempo.linkfoto, "\\", "\")
		ELSE
			&& Si no anda volver a como estaba
			Thisform.Pgf.Page2.cnt_fields.txtPathFoto.Value = cur_Tempo.linkfoto
		ENDIF
	ENDIF
ELSE
	Thisform.Pgf.page2.cnt_Fields.picFoto.Picture = ""
ENDIF

&& Recupero los datos correspondiente al codiart

SELECT cur_codiart
ZAP

lcSql = "CALL codiart_getByArticulo (?pIdArticulo)"
lcSql = loResult.AddParameter(lcSql, "pIdArticulo", ALLTRIM(STR(cur_tempo.idArticulo)), .f., .f.)
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
Thisform.codiart_counter = RECCOUNT("cur_codiart")

lcSql = "CALL marcas_getByArticulo (?pIdArticulo)"
lcSql = loResult.AddParameter(lcSql, "pIdArticulo", ALLTRIM(STR(cur_tempo.idArticulo)), .f., .f.)
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
Thisform.leer_equivs(cur_tempo.idarticulo)
Thisform.pgf.page2.cnt_fields.internalPgf.page4.grdEquivs.Refresh()

&& Recupero el checkbox que indica si usa o no impuestos internos.
Thisform.Pgf.Page2.Cnt_Fields.internalPgf.Page1.chkUsarImpuestosInternos.Value = cur_tempo.usarImpuIn

&& Recupero si uso moneda extrangera
Thisform.Pgf.Page2.Cnt_Fields.internalPgf.Page1.chkHabilitarMonedaExtrangera.Value = cur_tempo.usarMonExt

** Sacar
Thisform.pgf.page2.cnt_fields.chkLlevaStock.Value = estandarizar_checkbox_value(cur_tempo.llevastk)

SELECT cur_tempo
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
Thisform.Pgf.Page2.cnt_fields.internalPgf.page1.cmbTipoMon.ListIndex = 1
Thisform.pgf.page2.cnt_fields.chkLlevaStock.Value = 0
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
LOCAL loRes
LOCAL lcSql
LOCAL ldFecActuPre

* Recupero la última fecha de actualización de precios.
ldFecActuPre = {}
loRes = CREATEOBJECT("odbc_result")

TEXT TO lcSql NOSHOW
	SELECT
		fecActuPre
	FROM
		articulos
	WHERE
		articulos.idarticulo = ?xid
ENDTEXT

lcSql = loRes.addParameter(lcSql, "xid", ALLTRIM(STR(this.idarticulo)), .f., .f.)
loRes.Cursor_Name = "cur_fap"
loRes.ActiveConnection = goConn.ActiveConnection
loRes.OpenQuery(lcSql)

SELECT cur_fap
ldFecActuPre = cur_fap.fecActuPre

loRes.Close_Query()

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
REPLACE cur_Tempo.idmarca		WITH Thisform.Pgf.Page2.Cnt_Fields.sel_marca.valcpoid ADDITIVE
REPLACE cur_Tempo.marca			WITH Thisform.Pgf.Page2.Cnt_Fields.sel_marca.txtDescripcion.Value ADDITIVE
REPLACE cur_Tempo.idfamilia		WITH Thisform.Pgf.Page2.Cnt_fields.sel_Familia.valcpoid ADDITIVE
REPLACE cur_Tempo.familia		WITH Thisform.Pgf.Page2.Cnt_Fields.sel_familia.txtDescripcion.Value ADDITIVE
REPLACE cur_Tempo.idsubfam		WITH Thisform.Pgf.Page2.Cnt_Fields.sel_SubFamilia.valcpoid ADDITIVE
REPLACE cur_Tempo.subfam		WITH Thisform.Pgf.Page2.Cnt_Fields.sel_SubFamilia.txtDescripcion.Value ADDITIVE
REPLACE cur_Tempo.tmon			WITH Thisform.Pgf.Page2.cnt_fields.InternalPGF.page1.cmbTipoMon.Value ADDITIVE
REPLACE cur_Tempo.fecActuPre	WITH ldFecActuPre ADDITIVE
replace cur_Tempo.llevastk		WITH IIF(thisform.pgf.page2.cnt_fields.chkLlevaStock.Value = 1, .t., .f.) additive


&& Agrego el refresco de los campos de no gravado y activación de moneda extranjera
WITH THisform.pgf.page2.Cnt_Fields.internalPgf.Page1
	REPLACE cur_Tempo.usarMonExt	WITH IIF(.chkHabilitarMonedaExtrangera.value = 1, .T., .F.) ADDITIVE
	REPLACE cur_Tempo.usarImpuIn	WITH .chkUsarImpuestosInternos.value ADDITIVE
	REPLACE cur_Tempo.porImpuIn		WITH .txtPorImpuIn.value ADDITIVE
	REPLACE cur_Tempo.impImInMay	WITH .txtImpImpuIntMay.value ADDITIVE
	REPLACE cur_Tempo.impImInMin	WITH .txtImpImpuIntMin.value ADDITIVE
ENDWITH

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
	cantiDesp	double,;
	circuito	varchar(2))


CREATE CURSOR cur_mrcsv (	;
	idMarcaV	int,;
	descripcio	varchar(60))
	


ENDPROC
PROCEDURE HERRAMIENTAS.excel
LOCAL loRes, lcSql, lcWhere, lcValorBuscado

loRes = CREATEOBJECT("odbc_result")

* Construye la cláusula WHERE basándose en los filtros del formulario
lcWhere = ""

* Filtra por palabras clave en varios campos
lcValorBuscado = STRTRAN(ALLTRIM(Thisform.pgf.Page1.cnt_busqueda.txtValorBuscado.Value), " ", "%")
IF !EMPTY(lcValorBuscado) THEN
    lcWhere = lcWhere + " WHERE (articulos.CodArt LIKE '%" + lcValorBuscado + "%' " + ;
              "OR subfam.descripcio LIKE '%" + lcValorBuscado + "%' " + ;
              "OR marcas.descripcio LIKE '%" + lcValorBuscado + "%' " + ;
              "OR articulos.descripcio LIKE '%" + lcValorBuscado + "%') "
ENDIF

* Filtra por marca
IF Thisform.Pgf.Page1.cnt_busqueda.sel_Marca.valcpoid <> 0 THEN
    lcWhere = IIF(EMPTY(lcWhere), " WHERE ", lcWhere + " AND ")
    lcWhere = lcWhere + "articulos.idmarca = " + ALLTRIM(STR(Thisform.Pgf.Page1.cnt_busqueda.sel_Marca.valcpoid))
ENDIF

* Filtra por familia
IF Thisform.Pgf.page1.cnt_busqueda.sel_Familia.valcpoid <> 0 THEN
    lcWhere = IIF(EMPTY(lcWhere), " WHERE ", lcWhere + " AND ")
    lcWhere = lcWhere + "articulos.idFamilia = " + ALLTRIM(STR(Thisform.Pgf.Page1.cnt_busqueda.sel_Familia.valcpoid))
ENDIF

* Filtra por subfamilia
IF Thisform.Pgf.Page1.cnt_busqueda.sel_subfam.valcpoid <> 0 THEN
    lcWhere = IIF(EMPTY(lcWhere), " WHERE ", lcWhere + " AND ")
    lcWhere = lcWhere + "articulos.idsubfam = " + ALLTRIM(STR(Thisform.Pgf.Page1.cnt_busqueda.sel_subfam.valcpoid))
ENDIF

* Filtra por proveedor
IF Thisform.Pgf.page1.cnt_busqueda.sel_proveedores.valcpoid <> 0 THEN
    lcWhere = IIF(EMPTY(lcWhere), " WHERE ", lcWhere + " AND ")
    lcWhere = lcWhere + "articulos.idprov = " + ALLTRIM(STR(Thisform.Pgf.Page1.cnt_busqueda.sel_proveedores.valcpoid))
ENDIF

* Construye la consulta SQL completa
TEXT TO lcSql NOSHOW
    SELECT    idArticulo, CodArt, CodArtPv, articulos.descripcio, marcas.descripcio AS marca,
              familias.descripcio AS familia, subfam.descripcio AS subfam, proveedor.razSoc AS proveedor,
              alicIVA, articulos.tmon, usarMonExt, prListaExt, articulos.cotizac, prLista,
              bonif1, bonif2, bonif3, bonif4, costoRep, margenMax,
              margenMin, prVentaMax, prVentaMin, prfinalMax, prfinalMin,
              articulos.habilitado, articulos.usuAlta, articulos.fecAlta, articulos.idHostAlta,
              articulos.usuModi, articulos.fecModi, articulos.idHostModi
    FROM    
        articulos        
            INNER JOIN marcas ON marcas.idMarca = articulos.idMarca
            INNER JOIN familias ON familias.idFamilia = articulos.idFamilia
            INNER JOIN subfam ON subfam.idSubFam = articulos.idSubFam
            LEFT JOIN proveedor ON proveedor.idProv = articulos.idProv
ENDTEXT

* Agrega la cláusula WHERE
lcSql = lcSql + lcWhere + " ORDER BY idArticulo ASC"

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"
loRes.OpenQuery(lcSql)

genexcel("cur_x","Listado")

loRes.Close_Query()
ENDPROC
PROCEDURE HERRAMIENTAS.eliminar
LOCAL lnResp, lcAlias, cRef, lcSql

WITH Thisform
	lcAlias = .cNombreTabla
	lnResp = MESSAGEBOX("¿Está seguro que desea eliminar el registro?", 4+32, .Caption)
		
	IF lnResp = 6
			
		cRef = Thisform.pk_fieldname
		cRef = "Thisform.object_DataService." + cRef + " = " + "cur_Tempo." + cRef
		&cRef
	
		IF(!.object_dataservice.Delete())
			RETURN .F.
		ENDIF
		
		SELECT cur_Tempo
		DELETE
		
		IF RECCOUNT() > 0 .AND. !(BOF("cur_Tempo") .AND. BOF("cur_Tempo"))
			SKIP -1
		ENDIF
		
		Thisform.Pgf.page1.grdDatos.Refresh()
		Thisform.recuperardatos()
	ENDIF
ENDWITH

RETURN .T.
ENDPROC
PROCEDURE HERRAMIENTAS.nuevo
DODEFAULT()
SELECT cur_codiart
ZAP 
SELECT cur_artequiv
ZAP
SELECT cur_mrcsv
ZAP

WITH thisform.pgf.page2.cnt_fields
	.chkHabilitado.value = 1
	.chkMerchandising.value = 0
	.chkEsServicio.value = 0
	.chkMostrador.value = 0
	.chkLlevaStock.value = 0
ENDWITH 

Thisform.Pgf.page2.cnt_fields.internalPgf.page1.chkUsarImpuestosInternos.Value = 0
Thisform.idarticulo = 0
Thisform.Cambiar_estado_2(.F.)
Thisform.Pgf.Page2.cnt_fields.txtCodigo.SetFocus()


ENDPROC
PROCEDURE HERRAMIENTAS.cancelar
DODEFAULT()
Thisform.Cambiar_estado_2(.T.)
ENDPROC
PROCEDURE HERRAMIENTAS.modificar
DODEFAULT()
Thisform.Cambiar_estado_2(.F.)
Thisform.Pgf.Page2.cnt_fields.txtCodigo.SetFocus()
ENDPROC
PROCEDURE HERRAMIENTAS.grabar
PARAMETERS tl_AutoAssing

LOCAL loRes, lnProxID, loCommand, lcSql, lnPrAnt, lnPrLista, lnVariacion

loRes = CREATEOBJECT("odbc_result")
loCommand = CREATEOBJECT("odbc_command")
lcSql = ""
lnPrAnt = 0.00
lnPrLista = 0.00
lnVariacion = 0.00

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
	IF !thisform.insert() THEN
		MESSAGEBOX("Error al intentar grabar el artículo", 0+64, "Mensaje de Error")
		goConn.Rollback()
		RETURN .F.
	ENDIF
	
	IF RECCOUNT("cur_codiart") <> 0 THEN
		IF !thisform.grabar_codiart() THEN 
			MESSAGEBOX("Error al intentar grabar las unidades de compras y ventas", 0+48, Thisform.Caption)
			goConn.Rollback()
			RETURN .F.
		ENDIF	
	ENDIF
	
	&& Si sale todo bien, entonces grabo las equivalencias
	IF !thisform.grabar_equivs() THEN
		MESSAGEBOX(thisform.equivalencias.ErrorMessage, 0+48, Thisform.Caption)
		goConn.Rollback()
		RETURN .F.
	ENDIF
	
	&& El siguiente código permite asignar las marcas de vehículos que asigna el
	&& siguiente artículo.
	IF !Thisform.asignar_marcas_v() THEN
		goConn.Rollback()
		RETURN .F.
	ENDIF
	
	goConn.Commit()
ELSE
	goConn.BeginTransaction()
	
	&& Si modifica tengo que traer el id del registro seleccionado
	IF !thisform.update() THEN
		MESSAGEBOX("Ha ocurrido un error al intentar actualizar los datos", 0+64, "Mensaje de Error")
		goConn.Rollback()
		RETURN .F.
	ENDIF
	
	&& Se eliminan las equivalencias enviadas al cursor de cur_delequiv
	IF !thisform.eliminar_equiv() THEN
		MESSAGEBOX("Ha ocurrido un error al intentar eliminar las equivalencias", 0+64, Thisform.Caption)
		goConn.Rollback()
		RETURN .F.
	ENDIF
		
	&& Si sale todo bien, entonces grabo las equivalencias
	IF !thisform.grabar_equivs() THEN
		MESSAGEBOX("Ha ocurrido un error al intentar grabar las equivalencias", 0+64, Thisform.Caption)
		goConn.Rollback()
		RETURN .F.
	ENDIF
	
	&& El siguiente código permite asignar las marcas de vehículos que aplica
	&& el artículo
	IF !Thisform.asignar_marcas_v() THEN
		MESSAGEBOX("Ha ocurrido un error al intentar asignar las marcas de vehículos", 0+64, Thisform.Caption)
		goConn.Rollback()
		RETURN .F.
	ENDIF
	
	IF !thisform.grabar_codiart() THEN 
		MESSAGEBOX("Error al intentar grabar las unidades de compras y ventas", 0+48, Thisform.Caption)
		goConn.Rollback()
		RETURN .F.
	ENDIF	
	
	goConn.Commit()	
ENDIF


Thisform.actualizar_cursor()
Thisform.CambiarEstado(.T.)
Thisform.pgf.page2.cnt_fields.internalPGF.pagE4.grdEquivs.Refresh()
Thisform.pgf.Page1.enabled = .T.
Thisform.Pgf.Page1.SetFocus()
Thisform.Pgf.Page1.grdDatos.SetFocus()

RETURN .T.

ENDPROC
PROCEDURE PGF.Page1.Activate
* Anulo la cadena de herencia para que no se ejecute
* el código padre
ENDPROC


************************************************************
OBJETO: btnRutaFotos
************************************************************
*** PROPIEDADES ***
Top = 1
Left = 276
Height = 34
Width = 40
Picture = ..\imagen\iconos bajados\noflash-camara-icono-9494.ico
ToolTipText = "Generar rutas de fotos"
Name = "btnRutaFotos"

*** METODOS ***
PROCEDURE Click
LOCAL loForm

loForm = CREATEOBJECT("cls_form_generar_rutas")
loForm.show()
ENDPROC


************************************************************
OBJETO: cnt_busqueda
************************************************************
*** PROPIEDADES ***
Top = 2
Left = 3
Width = 980
Height = 104
TabIndex = 1
BackColor = 241,236,235
Name = "cnt_busqueda"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Parámetros de búsqueda"
Height = 12
Left = 2
Top = 1
Width = 147
TabIndex = 8
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Frase:"
Height = 12
Left = 40
Top = 20
Width = 37
TabIndex = 9
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: txtValorBuscado
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 81
TabIndex = 1
Top = 16
Width = 360
Name = "txtValorBuscado"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Marca:"
Height = 12
Left = 478
Top = 20
Width = 42
TabIndex = 10
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: sel_marca
************************************************************
*** PROPIEDADES ***
Top = 15
Left = 519
Width = 442
Height = 25
TabIndex = 2
esnumerico = .T.
nombre_campo_codigo = idmarca
nombre_campo_desc = descripcio
nombre_tabla = marcas
pkfield = idmarca
criterio_filtro = fecBaja IS NULL
Name = "sel_marca"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Height = 21
txtDescripcion.Left = 106
txtDescripcion.Top = 2
txtDescripcion.Width = 333
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Sub Familia:"
Height = 12
Left = 449
Top = 43
Width = 68
TabIndex = 12
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: sel_subfam
************************************************************
*** PROPIEDADES ***
Top = 38
Left = 519
Width = 368
Height = 25
TabIndex = 4
esnumerico = .T.
nombre_campo_codigo = idSubFam
nombre_campo_desc = descripcio
nombre_tabla = subfam
pkfield = idsubfam
Name = "sel_subfam"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Height = 21
txtDescripcion.Left = 106
txtDescripcion.Top = 2
txtDescripcion.Width = 256
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: btnBuscar
************************************************************
*** PROPIEDADES ***
Top = 62
Left = 936
Height = 37
Width = 41
TabIndex = 6
Name = "btnBuscar"

*** METODOS ***
PROCEDURE Click
thisform.buscar()

* Habilito los botones de habilitar / deshabilitar masivo
Thisform.Pgf.page1.btnHabilitar.Enabled = .T.
Thisform.Pgf.Page1.btnDeshabilitar.Enabled = .T.
ENDPROC


************************************************************
OBJETO: chkMostrarTodos
************************************************************
*** PROPIEDADES ***
Top = 80
Left = 831
Height = 15
Width = 102
Alignment = 0
Caption = "Mostrar todos"
Value = 1
TabIndex = 7
Name = "chkMostrarTodos"

*** METODOS ***
PROCEDURE Click
IF This.Value = 1 then
	SELECT cur_tempo
	SET FILTER TO
	This.Parent.sel_Marca.blanquear()
	This.Parent.sel_Familia.blanquear()
	This.Parent.sel_subfam.blanquear()
	This.Parent.sel_proveedores.blanquear()
	This.Parent.txtValorBuscado.Value = ""
	
	* Dehsabilito los botones de deshabilitar / habilitar masivo.
	Thisform.Pgf.page1.btnHabilitar.Enabled = .F.
	Thisform.Pgf.Page1.btnDeshabilitar.Enabled = .F.
ENDIF
Thisform.Pgf.Page1.grdDatos.Refresh()
Thisform.Pgf.Page1.grdDatos.SetFocus()
ENDPROC


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Prov.:"
Height = 12
Left = 44
Top = 67
Width = 46
TabIndex = 11
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: sel_proveedores
************************************************************
*** PROPIEDADES ***
Top = 62
Left = 79
Width = 442
Height = 25
TabIndex = 5
esnumerico = .T.
nombre_campo_codigo = idprov
nombre_campo_desc = razSoc
nombre_tabla = proveedor
pkfield = idProv
Name = "sel_proveedores"
TXTCODIGO.Name = "TXTCODIGO"
TXTDESCRIPCION.Height = 21
TXTDESCRIPCION.Left = 106
TXTDESCRIPCION.Top = 2
TXTDESCRIPCION.Width = 333
TXTDESCRIPCION.Name = "TXTDESCRIPCION"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta6
************************************************************
*** PROPIEDADES ***
Caption = "Familia:"
Height = 12
Left = 32
Top = 43
Width = 47
TabIndex = 13
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: sel_familia
************************************************************
*** PROPIEDADES ***
Top = 38
Left = 79
Width = 368
Height = 25
TabIndex = 3
esnumerico = .T.
nombre_campo_codigo = idFamilia
nombre_campo_desc = descripcio
nombre_tabla = familias
pkfield = idFamilia
criterio_filtro = 
Name = "sel_familia"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Height = 21
txtDescripcion.Left = 106
txtDescripcion.Top = 2
txtDescripcion.Width = 256
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: CLSETIQUETA1
************************************************************
*** PROPIEDADES ***
Caption = "(*) Las filas con fondo naranja indica que el artículo está deshabilitado."
Height = 12
Left = 11
Top = 478
Width = 408
ForeColor = 255,0,0
Name = "CLSETIQUETA1"

*** METODOS ***


************************************************************
OBJETO: btnHabilitar
************************************************************
*** PROPIEDADES ***
Top = 114
Left = 940
Height = 36
Width = 43
Picture = ..\imagen\iconos bajados\habilitar-30.png
ToolTipText = "Habilitar artículos filtrados"
Name = "btnHabilitar"

*** METODOS ***
PROCEDURE Click
**************************************************************************************************************
* Habilita todos los artículos que se muestran en la grilla respetando el filtro aplicado.
**************************************************************************************************************

LOCAL lnResp
LOCAL lcMensaje

TEXT TO lcMensaje NOSHOW
Esta función habilitará todos los artículos que se muestra en la grilla 
respetando el filtro aplicado. ¿Esta seguro que desea continuar?
ENDTEXT

lnResp = MESSAGEBOX(lcMensaje, 4+32, Thisform.Caption)

IF lnResp = 6 THEN
	thisform.habilitar_filtrados()
ENDIF
ENDPROC


************************************************************
OBJETO: btnDeshabilitar
************************************************************
*** PROPIEDADES ***
Top = 151
Left = 940
Height = 36
Width = 43
Picture = ..\imagen\iconos bajados\deshabilitar-24.png
ToolTipText = "Dehsabilitar artículos filtrados"
Name = "btnDeshabilitar"

*** METODOS ***
PROCEDURE Click
LOCAL lnResp
LOCAL lcMensaje

TEXT TO lcMensaje NOSHOW
Esta función deshabilitará todos los artículos que se muestra en la grilla 
respetando el filtro aplicado. ¿Esta seguro que desea continuar?
ENDTEXT

lnResp = MESSAGEBOX(lcMensaje, 4+32, Thisform.Caption)

IF lnResp = 6 THEN
	thisform.dehsabilitar_filtrados()
ENDIF
ENDPROC


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
TabIndex = 14
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
Left = 30
Top = 25
Width = 148
TabIndex = 13
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Bonificación 1:"
Left = 57
Top = 112
TabIndex = 15
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Bonificación 2:"
Left = 57
Top = 136
TabIndex = 16
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta6
************************************************************
*** PROPIEDADES ***
Caption = "Bonificación 3:"
Left = 57
Top = 160
TabIndex = 17
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta7
************************************************************
*** PROPIEDADES ***
Caption = "Bonificación 4:"
Left = 57
Top = 184
TabIndex = 18
Name = "Clsetiqueta7"

*** METODOS ***


************************************************************
OBJETO: txtBonif1
************************************************************
*** PROPIEDADES ***
Left = 150
TabIndex = 4
Top = 108
isnumeric = .T.
cfieldname = bonif1
requerido = .F.
Name = "txtBonif1"

*** METODOS ***
PROCEDURE Valid
IF this.Value > 500 then
	MESSAGEBOX("Por favor, revise el valor en el campo Bonificacion 1", 0+48, thisform.Caption)
	RETURN .F.
ENDIF

RETURN .t.
ENDPROC
PROCEDURE LostFocus
DODEFAULT()
thisform.calcular_precios()
ENDPROC


************************************************************
OBJETO: txtBonif2
************************************************************
*** PROPIEDADES ***
Left = 150
TabIndex = 5
Top = 132
isnumeric = .T.
requerido = .F.
cfieldname = bonif2
Name = "txtBonif2"

*** METODOS ***
PROCEDURE LostFocus
DODEFAULT()
IF this.Value > 500 then
	MESSAGEBOX("Por favor, revise el valor en el campo Bonificacion 2", 0+48, thisform.Caption)
	RETURN .F.
ENDIF
thisform.calcular_precios()



ENDPROC


************************************************************
OBJETO: txtBonif3
************************************************************
*** PROPIEDADES ***
Left = 150
TabIndex = 6
Top = 156
isnumeric = .T.
requerido = .F.
cfieldname = bonif3
Name = "txtBonif3"

*** METODOS ***
PROCEDURE LostFocus
DODEFAULT()
IF this.Value > 500 then
	MESSAGEBOX("Por favor, revise el valor en el campo Bonificacion 3", 0+48, thisform.Caption)
	RETURN .F.
ENDIF

thisform.calcular_precios()
ENDPROC


************************************************************
OBJETO: txtBonif4
************************************************************
*** PROPIEDADES ***
Left = 150
TabIndex = 7
Top = 180
isnumeric = .T.
requerido = .F.
cfieldname = bonif4
Name = "txtBonif4"

*** METODOS ***
PROCEDURE LostFocus
DODEFAULT()
IF this.Value > 500 then
	MESSAGEBOX("Por favor, revise el valor en el campo Bonificacion 4", 0+48, thisform.Caption)
	RETURN .F.
ENDIF

thisform.calcular_precios()
ENDPROC


************************************************************
OBJETO: Clsetiqueta9
************************************************************
*** PROPIEDADES ***
Caption = "Costo de Reposición:"
Height = 15
Left = 18
Top = 208
Width = 123
TabIndex = 19
Name = "Clsetiqueta9"

*** METODOS ***


************************************************************
OBJETO: txtCostoRep
************************************************************
*** PROPIEDADES ***
Tag = ""
Enabled = .F.
Left = 150
TabIndex = 8
Top = 204
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
Left = 258
Top = 114
Width = 105
TabIndex = 22
Name = "Clsetiqueta11"

*** METODOS ***


************************************************************
OBJETO: txtMargenMax
************************************************************
*** PROPIEDADES ***
Left = 364
TabIndex = 9
Top = 110
isnumeric = .T.
requerido = .F.
cfieldname = margenmax
Name = "txtMargenMax"

*** METODOS ***
PROCEDURE LostFocus
DODEFAULT()
IF this.Value > 500 then
	MESSAGEBOX("Por favor, revise el valor en el Margen mayorista", 0+48, thisform.Caption)
	RETURN .F.
ENDIF

Thisform.calcular_precios()
ENDPROC


************************************************************
OBJETO: txtMargenMin
************************************************************
*** PROPIEDADES ***
Left = 364
TabIndex = 10
Top = 134
isnumeric = .T.
requerido = .F.
cfieldname = margenmin
Name = "txtMargenMin"

*** METODOS ***
PROCEDURE LostFocus
DODEFAULT()
IF this.Value > 500 then
	MESSAGEBOX("Por favor, revise el valor en el campo Margen Minorista", 0+48, thisform.Caption)
	RETURN .F.
ENDIF

Thisform.calcular_precios()
ENDPROC


************************************************************
OBJETO: txtPrVentaMax
************************************************************
*** PROPIEDADES ***
Tag = ""
Enabled = .F.
Left = 467
TabIndex = 23
Top = 110
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
Left = 467
TabIndex = 24
Top = 134
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
Left = 570
TabIndex = 25
Top = 110
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
Left = 570
TabIndex = 26
Top = 134
isnumeric = .T.
cfieldname = prfinalmin
requerido = .F.
Name = "txtPrFinalMin"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta12
************************************************************
*** PROPIEDADES ***
Caption = "Utilidad (%)"
Height = 15
Left = 384
Top = 86
Width = 65
TabIndex = 27
Name = "Clsetiqueta12"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta13
************************************************************
*** PROPIEDADES ***
Caption = "Con I.V.A"
Height = 15
Left = 590
Top = 86
Width = 56
TabIndex = 29
Name = "Clsetiqueta13"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta18
************************************************************
*** PROPIEDADES ***
Caption = "% Dto. Prov."
Height = 15
Left = 69
Top = 86
Width = 80
TabIndex = 14
Name = "Clsetiqueta18"

*** METODOS ***


************************************************************
OBJETO: Clslinea1
************************************************************
*** PROPIEDADES ***
Height = 0
Left = 13
Top = 102
Width = 942
Name = "Clslinea1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta19
************************************************************
*** PROPIEDADES ***
Caption = "Margen Minorista:"
Height = 15
Left = 260
Top = 137
Width = 104
TabIndex = 21
Name = "Clsetiqueta19"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta20
************************************************************
*** PROPIEDADES ***
Caption = "Sin I.V.A"
Height = 15
Left = 493
Top = 86
Width = 59
TabIndex = 28
Name = "Clsetiqueta20"

*** METODOS ***


************************************************************
OBJETO: txtprLista
************************************************************
*** PROPIEDADES ***
Left = 180
TabIndex = 1
Top = 21
isnumeric = .T.
cfieldname = prlista
requerido = .T.
Name = "txtprLista"

*** METODOS ***
PROCEDURE calcular
thisform.calcular_precios()
ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Tipo Moneda:"
Left = 435
Top = 48
TabIndex = 30
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: cmbTipoMon
************************************************************
*** PROPIEDADES ***
Height = 22
Left = 520
TabIndex = 31
ToolTipText = "PSO: Pesos | DOL: Dolares | EUR: Euros"
Top = 44
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
Left = 629
Top = 48
Width = 70
TabIndex = 32
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: txtCotizacion
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 703
TabIndex = 33
Top = 44
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
Left = 767
Top = 48
Width = 111
TabIndex = 34
Name = "Clsetiqueta8"

*** METODOS ***


************************************************************
OBJETO: txtPrExt
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 871
TabIndex = 35
Top = 44
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
TabIndex = 36
ForeColor = 255,255,255
BackColor = 0,128,192
Name = "Clsetiqueta10"

*** METODOS ***


************************************************************
OBJETO: chkUsarImpuestosInternos
************************************************************
*** PROPIEDADES ***
Top = 46
Left = 20
Height = 18
Width = 162
Alignment = 0
Caption = "Impuestos internos (%):"
Value = .F.
TabIndex = 2
cfieldname = usarImpuIn
Name = "chkUsarImpuestosInternos"

*** METODOS ***
PROCEDURE InteractiveChange
&& Si habilito que calcula impuestos internos, entonces,
&& Habilito los campos para realizar los cálculos.

This.Parent.txtPorImpuIn.Enabled = This.Value
This.Parent.txtImpImpuIntMay.Enabled = This.Value
This.Parent.txtImpImpuIntMin.Enabled = This.Value

IF !This.Value THEN
	&& Si lo deshabilito entonces inicializo en cero los valores
	This.Parent.txtPorImpuIn.Value = 0.00
	This.Parent.txtImpImpuIntMay.Value = 0.00
	This.Parent.txtImpImpuIntMin.Value = 0.00
ENDIF

ENDPROC


************************************************************
OBJETO: Clsetiqueta15
************************************************************
*** PROPIEDADES ***
Caption = "Impuestos internos ($):"
Height = 15
Left = 690
Top = 85
Width = 135
TabIndex = 20
Name = "Clsetiqueta15"

*** METODOS ***


************************************************************
OBJETO: txtPorImpuIn
************************************************************
*** PROPIEDADES ***
Tag = ""
Left = 180
TabIndex = 3
Top = 44
isnumeric = .T.
requerido = .F.
cfieldname = porImpuIn
Name = "txtPorImpuIn"

*** METODOS ***
PROCEDURE Valid
IF this.Value > 1000 then
	MESSAGEBOX("Por favor, revise el Impuesto Interno", 0+48, thisform.Caption)
	RETURN .F.
ENDIF

RETURN .t.

ENDPROC
PROCEDURE calcular
&& Indico que calcule los montos de impuestos internos a partir del
&& porcentaje.

Thisform.porimpuin_changed = .t.
Thisform.impimpuintmay_changed = .f.
Thisform.impimpuintmin_changed = .f.

Thisform.calcular_impuestos_internos()
ENDPROC


************************************************************
OBJETO: txtImpImpuIntMay
************************************************************
*** PROPIEDADES ***
Tag = ""
Left = 689
TabIndex = 11
Top = 110
isnumeric = .T.
cfieldname = impImInMay
requerido = .F.
Name = "txtImpImpuIntMay"

*** METODOS ***
PROCEDURE calcular
&& Indico que se modificó desde imp. int mayorista por lo que debe tomar
&& este valor para calcular el porcentaje

Thisform.porimpuin_changed = .f.
Thisform.impimpuintmay_changed = .t.
Thisform.impimpuintmin_changed = .f.

Thisform.calcular_impuestos_internos()
ENDPROC


************************************************************
OBJETO: txtImpImpuIntMin
************************************************************
*** PROPIEDADES ***
Tag = ""
Left = 689
TabIndex = 12
Top = 134
isnumeric = .T.
cfieldname = impImInMin
requerido = .F.
Name = "txtImpImpuIntMin"

*** METODOS ***
PROCEDURE calcular
&& Indico que se modificó desde importe imp. int. minorista con lo que debe tomar este valor
&& para calcular el porcentaje
Thisform.porimpuin_changed = .f.
Thisform.impimpuintmay_changed = .f.
Thisform.impimpuintmin_changed = .t.

Thisform.calcular_impuestos_internos()
ENDPROC


************************************************************
OBJETO: chkHabilitarMonedaExtrangera
************************************************************
*** PROPIEDADES ***
Top = 23
Left = 435
Height = 18
Width = 191
Alignment = 0
Caption = "Habilitar moneda extranjera"
Value = 0
cfieldname = usarMonExt
Name = "chkHabilitarMonedaExtrangera"

*** METODOS ***
PROCEDURE InteractiveChange
&& Habilito la moneda extranjera en caso de que se utilice

IF This.Value = 1 THEN
	This.Parent.cmbTipoMon.Enabled = .T.
	This.Parent.txtCotizacion.Enabled = .T.
	This.Parent.txtPrExt.Enabled = .T.
ELSE
	This.Parent.cmbTipoMon.Enabled = .F.
	This.Parent.txtCotizacion.Enabled = .F.
	This.Parent.txtPrExt.Enabled = .F.
	
	&& Inicializo en cero los valores de moneda extrangera
	This.Parent.cmbTipoMon.ListIndex = 1
	This.Parent.txtCotizacion.Value = 0.00
	This.Parent.txtPrExt.Value = 0.00
ENDIF
ENDPROC


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
thisform.codiart_counter = thisform.codiart_counter + 1
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
	IF thisform.codiart_counter = 1 THEN
		MESSAGEBOX("El artículo debe tener al menos una unidad de compra/venta asociado, " ;
			+ "no se puede eliminar", 0+48, Thisform.Caption)
		RETURN
	ENDIF
	SELECT cur_codiart
	DELETE
	thisform.codiart_counter = thisform.codiart_counter - 1
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


SELECT idArticulo, codArt, descripcio, esNuevo ;
FROM cur_artequiv ;
INTO CURSOR cur_aux

SELECT cur_artequiv
ZAP

Thisform.leer_equivs(this.Parent.sel_artic_equiv.valcpoid)
SELECT cur_artequiv
APPEND FROM DBF("cur_aux")
USE IN cur_aux

INSERT INTO cur_artequiv (;
	idArticulo, ;
	codArt, ;
	descripcio, ;
	esNuevo) ;
VALUES (;
	this.Parent.sel_artic_equiv.valcpoid, ;
	this.Parent.sel_artic_equiv.txtCodigo.Value, ;
	this.Parent.sel_artic_equiv.txtDescripcion.Value, ;
	.T.)

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
	SELECT cur_delequiv
	APPEND BLANK
	REPLACE idArtic WITH cur_artequiv.idArticulo
	REPLACE codArt	WITH cur_artequiv.codArt ADDITIVE
	
	SELECT cur_artequiv
	DELETE	
	This.Parent.grdEquivs.Refresh()
ENDIF

SELECT cur_artequiv
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
Left = 276
Top = 14
Width = 72
TabIndex = 16
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Descripción:"
Height = 15
Left = 250
Top = 38
Width = 76
TabIndex = 17
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Familia:"
Height = 15
Left = 277
Top = 62
Width = 44
TabIndex = 18
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "SubFamilia:"
Height = 15
Left = 256
Top = 86
Width = 65
TabIndex = 19
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: txtCodigo
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 328
MaxLength = 20
TabIndex = 1
Top = 10
Width = 226
ischaracter = .T.
cfieldname = CodArt
msgerror = Debe ingresar el Código del Artículo
Name = "txtCodigo"

*** METODOS ***
PROCEDURE Valid
LOCAL loRes
LOCAL lcSql

IF Thisform.lNuevo THEN
	loRes = CREATEOBJECT("odbc_result")
	lcSql = "CALL articulos_getByCod (?pCodArt)"
	lcSql = loRes.AddParameter(lcSql, "pCodArt", ALLTRIM(Thisform.pgf.page2.cnt_fields.txtCodigo.Value), .t., .f.)
	loRes.ActiveConnection = goConn.ActiveConnection
	loRes.Cursor_Name = "cur_x"
	loRes.OpenQuery(lcSql)
	SELECT cur_x
	IF RECCOUNT("cur_x") > 0 THEN
		MESSAGEBOX("Este código ya se encuentra cargado", 0+48, Thisform.Caption)
		loRes.Close_Query()
		RETURN .F.
	ENDIF
	loRes.Close_Query()
ENDIF
RETURN .T.
ENDPROC


************************************************************
OBJETO: txtDescripcion
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 328
MaxLength = 100
TabIndex = 3
Top = 34
Width = 619
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
Left = 326
Width = 621
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
TXTDESCRIPCION.Width = 515
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
TabIndex = 15
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
Left = 282
Top = 109
Width = 44
TabIndex = 22
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta6
************************************************************
*** PROPIEDADES ***
Caption = "Proveedor:"
Height = 15
Left = 257
Top = 133
Width = 69
TabIndex = 21
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: Sel_SubFamilia
************************************************************
*** PROPIEDADES ***
Top = 80
Left = 326
Width = 624
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
TXTDESCRIPCION.Width = 515
TXTDESCRIPCION.Name = "TXTDESCRIPCION"

*** METODOS ***


************************************************************
OBJETO: Sel_Marca
************************************************************
*** PROPIEDADES ***
Top = 104
Left = 326
Width = 621
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
TXTDESCRIPCION.Width = 515
TXTDESCRIPCION.Name = "TXTDESCRIPCION"

*** METODOS ***


************************************************************
OBJETO: Sel_Proveedor
************************************************************
*** PROPIEDADES ***
Top = 128
Left = 326
Width = 621
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
TXTDESCRIPCION.Width = 515
TXTDESCRIPCION.Name = "TXTDESCRIPCION"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta7
************************************************************
*** PROPIEDADES ***
Caption = "Alícuota I.V.A.:"
Left = 241
Top = 182
TabIndex = 23
Name = "Clsetiqueta7"

*** METODOS ***


************************************************************
OBJETO: txtAlicIVA
************************************************************
*** PROPIEDADES ***
Left = 328
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
Left = 454
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
Left = 431
Top = 182
Width = 12
TabIndex = 24
Name = "Clsetiqueta8"

*** METODOS ***


************************************************************
OBJETO: txtPathFoto
************************************************************
*** PROPIEDADES ***
Height = 22
Left = 11
MaxLength = 100
TabIndex = 25
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
Left = 537
Height = 18
Width = 102
Alignment = 0
Caption = "Es un servicio"
Value = 0
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
Left = 218
Top = 157
Width = 106
TabIndex = 20
Name = "Clsetiqueta9"

*** METODOS ***


************************************************************
OBJETO: sel_unimed
************************************************************
*** PROPIEDADES ***
Top = 152
Left = 326
Width = 621
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
txtDescripcion.Width = 515
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: CLSETIQUETA10
************************************************************
*** PROPIEDADES ***
Caption = "Código Alternativo:"
Height = 15
Left = 559
Top = 13
Width = 113
TabIndex = 26
Name = "CLSETIQUETA10"

*** METODOS ***


************************************************************
OBJETO: txtCodArtPV
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 674
MaxLength = 20
TabIndex = 2
Top = 10
Width = 273
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
Left = 638
Height = 18
Width = 109
Alignment = 0
Caption = "Solo Mostrador"
Value = 0
TabIndex = 13
cfieldname = mostrador
requerido = .T.
Name = "chkMostrador"

*** METODOS ***


************************************************************
OBJETO: chkMerchandising
************************************************************
*** PROPIEDADES ***
Top = 180
Left = 749
Height = 18
Width = 121
Alignment = 0
Caption = "Es Merchandising"
Value = 0
TabIndex = 12
cfieldname = promocion
requerido = .T.
Name = "chkMerchandising"

*** METODOS ***


************************************************************
OBJETO: chkLlevaStock
************************************************************
*** PROPIEDADES ***
Top = 180
Left = 872
Height = 18
Width = 85
Alignment = 0
Caption = "Lleva Stock"
Value = 0
Enabled = .T.
TabIndex = 13
cfieldname = llevastk
requerido = .T.
Name = "chkLlevaStock"

*** METODOS ***


************************************************************
OBJETO: cls_abm_articulo
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


