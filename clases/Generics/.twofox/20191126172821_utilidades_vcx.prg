************************************************************
OBJETO: clsgenerico
************************************************************
*** PROPIEDADES ***
Height = 44
Width = 45
Caption = ""
SpecialEffect = 0
Name = "clsgenerico"

*** METODOS ***


************************************************************
OBJETO: clsgenerico
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: gridmenu
************************************************************
*** PROPIEDADES ***
Width = 409
Height = 62
BackColor = 230,230,230
habilitar_agregar = .T.
habilitar_modificar = .T.
habilitar_eliminar = .T.
Name = "gridmenu"

*** METODOS ***
PROCEDURE Init
This.cmdAgregar.Enabled = This.habilitar_agregar
This.cmdModificar.Enabled = this.habilitar_modificar
This.cmdEliminar.Enabled = this.habilitar_eliminar
ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
FontBold = .F.
Alignment = 2
BackStyle = 1
Caption = "ELIJA LA ACCION A REALIZAR"
Height = 17
Left = 1
Top = 1
Width = 407
ForeColor = 255,255,255
BackColor = 0,64,128
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: cmdAgregar
************************************************************
*** PROPIEDADES ***
Top = 24
Left = 12
Height = 24
Width = 96
Caption = "\<Agregar"
Name = "cmdAgregar"

*** METODOS ***
PROCEDURE Click
this.Parent.agregar()
ENDPROC


************************************************************
OBJETO: cmdModificar
************************************************************
*** PROPIEDADES ***
Top = 24
Left = 108
Height = 24
Width = 96
Caption = "\<Modificar"
Name = "cmdModificar"

*** METODOS ***
PROCEDURE Click
This.Parent.Modificar()
ENDPROC


************************************************************
OBJETO: cmdEliminar
************************************************************
*** PROPIEDADES ***
Top = 24
Left = 204
Height = 24
Width = 96
Caption = "\<Eliminar"
Name = "cmdEliminar"

*** METODOS ***
PROCEDURE Click
This.Parent.eliminar
ENDPROC


************************************************************
OBJETO: cmdCerrar
************************************************************
*** PROPIEDADES ***
Top = 24
Left = 300
Height = 24
Width = 96
Caption = "\<Cerrar"
Name = "cmdCerrar"

*** METODOS ***
PROCEDURE Click
This.Parent.Visible = .F.
ENDPROC


************************************************************
OBJETO: gridmenu
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: clseditbox
************************************************************
*** PROPIEDADES ***
Tag = "edit"
Format = "K!"
Height = 61
SelectOnEntry = .T.
SpecialEffect = 0
Width = 209
BorderColor = 128,128,128
cfieldname = 
requerido = .F.
msgerror = 
Name = "clseditbox"

*** METODOS ***
PROCEDURE blanquear
This.Value = ""
ENDPROC
PROCEDURE LostFocus
this.BackColor = RGB(255, 255, 255)
ENDPROC
PROCEDURE GotFocus
this.BackColor = RGB(226,230,254)
ENDPROC


************************************************************
OBJETO: clseditbox
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: clscombobox
************************************************************
*** PROPIEDADES ***
Tag = "edit"
FontBold = .T.
FontSize = 8
Height = 24
Style = 2
Width = 100
requerido = .T.
msgerror = 
cfieldname = 
Name = "clscombobox"

*** METODOS ***
PROCEDURE blanquear
this.Value = 0
ENDPROC
PROCEDURE estavacio
IF this.ListIndex = 0
	RETURN .T.
ENDIF

RETURN .F.
ENDPROC


************************************************************
OBJETO: clscombobox
************************************************************
*** PROPIEDADES ***
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: clslinea
************************************************************
*** PROPIEDADES ***
BorderWidth = 2
Height = 8
Width = 100
BorderColor = 0,128,192
Name = "clslinea"

*** METODOS ***


************************************************************
OBJETO: clsnumcbtes
************************************************************
*** PROPIEDADES ***
Width = 329
Height = 26
BackStyle = 0
BorderWidth = 0
Name = "clsnumcbtes"

*** METODOS ***
PROCEDURE setvalue
LPARAMETERS tc_Cbte, tc_Letra, tnPV, tnNumero

This.cboCbte.Value = tc_Cbte
This.txtLetra.Value = tc_Letra
This.txtPtoVta.Value = tnPV
This.txtNumero.Value = tnNumero
ENDPROC
PROCEDURE getcbte
RETURN This.cboCbte.Value
ENDPROC
PROCEDURE getletra
RETURN This.txtLetra.Value
ENDPROC
PROCEDURE getptovta
RETURN This.txtPtoVta.Value
ENDPROC
PROCEDURE getnumero
RETURN This.txtNumero.Value
ENDPROC


************************************************************
OBJETO: cboCbte
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 1
Top = 3
Width = 68
msgerror = Debe seleccionar el tipo de comprobante
Name = "cboCbte"

*** METODOS ***


************************************************************
OBJETO: txtLetra
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 72
Top = 3
Width = 32
ischaracter = .T.
msgerror = Debe ingresar la letra
Name = "txtLetra"

*** METODOS ***


************************************************************
OBJETO: txtPtoVta
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 106
MaxLength = 4
Top = 3
Width = 79
autocompleta = .T.
isnumeric = .T.
msgerror = Debe ingresar el punto de venta
Name = "txtPtoVta"

*** METODOS ***


************************************************************
OBJETO: txtNumero
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 186
MaxLength = 8
Top = 3
Width = 139
isnumeric = .T.
autocompleta = .T.
msgerror = Debe ingresar el número de comprobante
Name = "txtNumero"

*** METODOS ***


************************************************************
OBJETO: clsnumcbtes
************************************************************
*** PROPIEDADES ***
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: sys_errortrap
************************************************************
*** PROPIEDADES ***
Height = 321
Width = 674
DoCreate = .T.
AutoCenter = .T.
BorderStyle = 1
Caption = "Error inesperado del sistema"
MaxButton = .F.
MinButton = .F.
Icon = ..\imagen\msgbox01.ico
TitleBar = 0
WindowType = 1
BackColor = 0,128,192
Name = "sys_errortrap"

*** METODOS ***


************************************************************
OBJETO: Contenedor1
************************************************************
*** PROPIEDADES ***
Top = 6
Left = 6
Width = 662
Height = 310
Name = "Contenedor1"

*** METODOS ***


************************************************************
OBJETO: txtError
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 203
Left = 15
Top = 44
Width = 647
ForeColor = 0,0,0
BackColor = 255,255,255
Name = "txtError"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Mensaje de Error:"
Height = 15
Left = 20
Top = 23
Width = 177
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clscerrar1
************************************************************
*** PROPIEDADES ***
Top = 273
Left = 622
Height = 35
Width = 42
Name = "Clscerrar1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
BackStyle = 1
Caption = "ERROR INESPERADO DEL SISTEMA"
Height = 15
Left = 7
Top = 3
Width = 191
ForeColor = 255,255,255
BackColor = 0,128,192
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
BackStyle = 1
Caption = " SI EL ERROR PERSISTE POR FAVOR ENVÍE UN MAIL A ldz.software@gmail.com CON EL MENSAJE DE ERROR"
Height = 18
Left = 16
Top = 251
Width = 646
ForeColor = 255,255,255
BackColor = 52,17,217
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: sys_errortrap
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: strings
************************************************************
*** PROPIEDADES ***
Name = "strings"

*** METODOS ***
PROCEDURE getcharcount
PARAMETERS cSearchedChar, cString

LOCAL cChar
LOCAL nCount

nCount = 0

FOR i = 1 TO LEN(cString)
	cChar = SUBSTR(cString, i, 1)
	
	IF cChar == ","
		nCount = nCount + 1	
	ENDIF
NEXT

RETURN nCount
ENDPROC


************************************************************
OBJETO: tbr_framework
************************************************************
*** PROPIEDADES ***
Caption = "Herramientas"
Height = 35
Left = 0
Top = 0
Width = 44
Name = "tbr_framework"

*** METODOS ***


************************************************************
OBJETO: btnVer
************************************************************
*** PROPIEDADES ***
Top = 3
Left = 5
Height = 29
Width = 34
Picture = ..\imagen\explorer.ico
ToolTipText = "Ver Explorador"
Name = "btnVer"

*** METODOS ***
PROCEDURE Click
goFormMain = CREATEOBJECT("frmMain")
goFormMain.Show()
ENDPROC


************************************************************
OBJETO: tbr_framework
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: cldpgf
************************************************************
*** PROPIEDADES ***
ErasePage = .T.
PageCount = 2
Width = 744
Height = 367
Name = "cldpgf"
Page1.FontBold = .T.
Page1.FontItalic = .T.
Page1.FontSize = 8
Page1.Caption = "Page1"
Page1.ForeColor = 128,64,64
Page1.Name = "Page1"
Page2.FontBold = .T.
Page2.FontItalic = .T.
Page2.FontSize = 8
Page2.Caption = "Page2"
Page2.Enabled = .T.
Page2.ForeColor = 128,64,64
Page2.Name = "Page2"

*** METODOS ***
PROCEDURE cambiar_estado
PARAMETERS tl_Estado

FOR EACH pg IN This.Pages
	FOR EACH ctrl IN pg.Controls
		IF LOWER(ALLTRIM(ctrl.Class)) == "cldpgf"
			ctrl.habilitado(tl_Estado)
		ENDIF
	ENDFOR
ENDFOR
ENDPROC


************************************************************
OBJETO: clspicture
************************************************************
*** PROPIEDADES ***
Stretch = 2
Height = 238
Width = 308
cfieldname = 
Name = "clspicture"

*** METODOS ***


************************************************************
OBJETO: clsoptions
************************************************************
*** PROPIEDADES ***
FontBold = .T.
BackStyle = 0
Caption = "Option1"
Height = 19
Width = 106
Name = "clsoptions"

*** METODOS ***


************************************************************
OBJETO: clsoptions
************************************************************
*** PROPIEDADES ***
Arial, 1, 9, 6, 13, 11, 12, 2, 0

*** METODOS ***


************************************************************
OBJETO: clsoptiongroup
************************************************************
*** PROPIEDADES ***
ButtonCount = 2
Value = 1
Height = 42
Width = 118
Name = "clsoptiongroup"
Option1.FontBold = .T.
Option1.Caption = "Option1"
Option1.Value = 1
Option1.Height = 15
Option1.Left = 5
Option1.Top = 5
Option1.Width = 91
Option1.Name = "Option1"
Option2.FontBold = .T.
Option2.Caption = "Option2"
Option2.Height = 15
Option2.Left = 5
Option2.Top = 22
Option2.Width = 91
Option2.Name = "Option2"

*** METODOS ***


************************************************************
OBJETO: clsoptiongroup
************************************************************
*** PROPIEDADES ***
Arial, 1, 9, 6, 13, 11, 12, 2, 0

*** METODOS ***


************************************************************
OBJETO: clsetiqueta
************************************************************
*** PROPIEDADES ***
FontBold = .T.
FontSize = 8
BackStyle = 0
Caption = "Label1"
Height = 15
Width = 87
ForeColor = 158,106,75
requerido = .F.
Name = "clsetiqueta"

*** METODOS ***


************************************************************
OBJETO: clscheckbox
************************************************************
*** PROPIEDADES ***
Tag = "edit"
Height = 18
Width = 241
FontBold = .T.
FontSize = 8
Alignment = 0
BackStyle = 0
Caption = "Check Box Control"
SpecialEffect = 1
ForeColor = 158,106,75
requerido = .F.
msgerror = 
cfieldname = 
Name = "clscheckbox"

*** METODOS ***
PROCEDURE blanquear
This.Value = 0
ENDPROC
PROCEDURE estavacio
RETURN IIF(This.Value = 0, .T., .F.)
ENDPROC


************************************************************
OBJETO: clscheckbox
************************************************************
*** PROPIEDADES ***
Arial, 1, 8, 6, 13, 11, 12, 2, 0

*** METODOS ***


************************************************************
OBJETO: clseditar
************************************************************
*** PROPIEDADES ***
Tag = "no_edit"
Picture = ..\imagen\edit.ico
ToolTipText = "Editar"
Name = "clseditar"

*** METODOS ***
PROCEDURE Click
FOR EACH ctrl IN Thisform.Controls
	IF ctrl.Tag == "E"
		ctrl.Enabled = .T.
	ENDIF	
ENDFOR
ENDPROC


************************************************************
OBJETO: clseditar
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 13, 11, 11, 2, 0

*** METODOS ***


************************************************************
OBJETO: clsgenericcontainer
************************************************************
*** PROPIEDADES ***
Width = 920
Height = 478
BackStyle = 0
BackColor = 237,218,205
BorderColor = 192,192,192
esdetalle = .F.
nombrecursor = cur_Detalle
fieldlist = 
anchocols = 
titulos_cabecera = 
datatypelist = 
isedit = .F.
Name = "clsgenericcontainer"

*** METODOS ***
PROCEDURE habilitado
PARAMETERS tl_Estado

FOR EACH ctrl IN this.Controls
	ctrl.Enabled = IIF(ALLTRIM(ctrl.Tag)=="no_edit", tl_Estado, !tl_Estado)		
ENDFOR

ENDPROC
PROCEDURE crear_cursor
LOCAL cCursor, cLinea

IF GETWORDCOUNT(cFieldList, ",") = 0
	RETURN .F.
ENDIF

FOR i = 1 TO GETWORDCOUNT(cFieldList, ",")
	IF i < GETWORDCOUNT(cFieldList, ",")
		cLinea = cLinea + GETWORDNUM(this.fieldlist, ",") + " " + GETWORDNUM(this.datatypelist, ",") + ", "
	ELSE
		cLinea = cLinea + GETWORDNUM(this.fieldlist, ",") + " " + GETWORDNUM(this.datatypelist, ",")
	ENDIF
ENDFOR

cCursor = "CREATE CURSOR " + this.nombrecursor + " ( " + cLinea + ")"
&cCursor	&& Ejecuto la instrucción create cursor

RETURN .T.
ENDPROC
PROCEDURE Init
IF this.esdetalle
	this.crear_cursor()
ENDIF
ENDPROC


************************************************************
OBJETO: clsaceptar
************************************************************
*** PROPIEDADES ***
Picture = ..\imagen\iconos bajados\aceptar-comprobar-si-puede-icono-9389.ico
ToolTipText = "Aceptar"
Name = "clsaceptar"

*** METODOS ***


************************************************************
OBJETO: clsaceptar
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: clsagregar
************************************************************
*** PROPIEDADES ***
Picture = ..\imagen\iconos bajados\agregar-editar-icono-6607.ico
ToolTipText = "Agregar"
Name = "clsagregar"

*** METODOS ***


************************************************************
OBJETO: clsagregar
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: clsbuscar
************************************************************
*** PROPIEDADES ***
Height = 44
Width = 45
Picture = ..\imagen\iconos bajados\buscar-buscar-ampliar-icono-9630.ico
ToolTipText = "Buscar"
Name = "clsbuscar"

*** METODOS ***


************************************************************
OBJETO: clsbuscar
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: clscancelar
************************************************************
*** PROPIEDADES ***
Tag = "edit"
Picture = ..\imagen\iconos bajados\deshacer-icono-5403.ico
ToolTipText = "Cancelar"
Name = "clscancelar"

*** METODOS ***


************************************************************
OBJETO: clscancelar
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: clsdelete
************************************************************
*** PROPIEDADES ***
Tag = "no_edit"
Picture = ..\imagen\iconos bajados\eliminar-cancelar-icono-4935 (1).ico
ToolTipText = "Eliminar"
Name = "clsdelete"

*** METODOS ***


************************************************************
OBJETO: clsdelete
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: clsgrabar
************************************************************
*** PROPIEDADES ***
Tag = "edit"
Picture = ..\imagen\iconos bajados\disquetes-excepto-icono-7120-32.png
ToolTipText = "Grabar"
Name = "clsgrabar"

*** METODOS ***


************************************************************
OBJETO: clsgrabar
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: clsexcel
************************************************************
*** PROPIEDADES ***
Picture = ..\imagen\iconos bajados\ncrow-mega-pack-1-excel.ico
ToolTipText = "Exportar a Excel"
Name = "clsexcel"

*** METODOS ***


************************************************************
OBJETO: clsexcel
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: clslogin
************************************************************
*** PROPIEDADES ***
Picture = ..\imagen\iconos bajados\llave-icono-5809.ico
ToolTipText = "Entrar"
Name = "clslogin"

*** METODOS ***


************************************************************
OBJETO: clslogin
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: clsrefresh
************************************************************
*** PROPIEDADES ***
Picture = ..\imagen\iconos bajados\nuevo-icono-9846.ico
ToolTipText = "Refrescar"
Name = "clsrefresh"

*** METODOS ***


************************************************************
OBJETO: clsrefresh
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: clsimprimir
************************************************************
*** PROPIEDADES ***
Picture = ..\imagen\iconos bajados\aha-soft-large-business-printer.ico
ToolTipText = "Imprimir"
Name = "clsimprimir"

*** METODOS ***


************************************************************
OBJETO: clsimprimir
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: clscerrar
************************************************************
*** PROPIEDADES ***
Tag = "no_edit"
Picture = ..\imagen\iconos bajados\salir-de-mi-perfil-icono-3964.ico
ToolTipText = "Salir"
Name = "clscerrar"

*** METODOS ***
PROCEDURE Click
thisform.Release()
ENDPROC


************************************************************
OBJETO: clscerrar
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: clsnew
************************************************************
*** PROPIEDADES ***
Tag = "no_edit"
Picture = ..\imagen\document.ico
ToolTipText = "Nuevo"
Name = "clsnew"

*** METODOS ***
PROCEDURE Click
FOR EACH ctrl IN Thisform.Controls
	IF ctrl.tag == "E"
		ctrl.Blanquear()
		ctrl.Enabled = .T.
	ENDIF
ENDFOR
ENDPROC


************************************************************
OBJETO: clsnew
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: clsdetalles
************************************************************
*** PROPIEDADES ***
Picture = ..\imagen\iconos bajados\detalles.ico
ToolTipText = "Detalles"
Name = "clsdetalles"

*** METODOS ***


************************************************************
OBJETO: clsdetalles
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: tbrabm
************************************************************
*** PROPIEDADES ***
Width = 819
Height = 41
BackColor = 254,250,235
BorderColor = 128,128,128
autoassing = .T.
Name = "tbrabm"

*** METODOS ***
PROCEDURE cambiar_estado
LPARAMETERS tlEstado

WITH This
	FOR EACH Ctrl IN .Controls
		IF ALLTRIM(Ctrl.Tag) = "no_edit"
			Ctrl.Enabled = tlEstado
		ELSE
			IF ALLTRIM(Ctrl.Tag) = "edit"
				Ctrl.Enabled = !tlEstado
			ENDIF
		ENDIF
	ENDFOR
ENDWITH
ENDPROC


************************************************************
OBJETO: cmdNuevo
************************************************************
*** PROPIEDADES ***
Top = 2
Left = 2
Height = 36
Width = 40
Picture = ..\imagen\document.ico
SpecialEffect = 1
Name = "cmdNuevo"

*** METODOS ***
PROCEDURE Click
IF !glVersionBeta THEN
	This.Parent.Nuevo()
ELSE
	MESSAGEBOX("Usted está usando una versión limitada del sistema, si desea comprarlo envíe un mail a ldz.software@gmail.com", 0+64, Thisform.Caption)
ENDIF
ENDPROC


************************************************************
OBJETO: cmdEditar
************************************************************
*** PROPIEDADES ***
Top = 2
Left = 42
Height = 36
Width = 40
Picture = ..\imagen\edit.ico
SpecialEffect = 1
Name = "cmdEditar"

*** METODOS ***
PROCEDURE Click
This.Parent.Modificar()
ENDPROC


************************************************************
OBJETO: cmdEliminar
************************************************************
*** PROPIEDADES ***
Top = 2
Left = 82
Height = 36
Width = 40
Picture = ..\imagen\iconos bajados\eliminar-cancelar-icono-4935 (1).ico
SpecialEffect = 1
Name = "cmdEliminar"

*** METODOS ***
PROCEDURE Click
This.Parent.Eliminar()
ENDPROC


************************************************************
OBJETO: cmdCerrar
************************************************************
*** PROPIEDADES ***
Tag = "no_edit"
Top = 2
Left = 776
Height = 36
Width = 40
SpecialEffect = 1
Name = "cmdCerrar"

*** METODOS ***


************************************************************
OBJETO: cmdGrabar
************************************************************
*** PROPIEDADES ***
Top = 2
Left = 122
Height = 36
Width = 40
Picture = ..\imagen\iconos bajados\disquetes-excepto-icono-7120-32.png
SpecialEffect = 1
Name = "cmdGrabar"

*** METODOS ***
PROCEDURE Click
This.Parent.Grabar(this.Parent.AutoAssing)
ENDPROC


************************************************************
OBJETO: cmdCancelar
************************************************************
*** PROPIEDADES ***
Top = 2
Left = 162
Height = 36
Width = 40
Picture = ..\imagen\iconos bajados\deshacer-icono-5403.ico
SpecialEffect = 1
Name = "cmdCancelar"

*** METODOS ***
PROCEDURE Click
This.Parent.Cancelar()
ENDPROC


************************************************************
OBJETO: cmdExcel
************************************************************
*** PROPIEDADES ***
OLEDragMode = 1
Top = 2
Left = 202
Height = 36
Width = 40
SpecialEffect = 1
Name = "cmdExcel"

*** METODOS ***
PROCEDURE Click
This.Parent.Excel()
ENDPROC


************************************************************
OBJETO: tbrabm
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: gridcontrol
************************************************************
*** PROPIEDADES ***
ColumnCount = 20
Tag = "no_edit"
FontBold = .T.
FontSize = 8
DeleteMark = .F.
Height = 347
ReadOnly = .T.
RowHeight = 17
Width = 940
GridLineColor = 192,192,192
HighlightBackColor = 0,64,128
HighlightForeColor = 255,255,255
SelectedItemBackColor = 0,128,192
SelectedItemForeColor = 255,255,255
HighlightStyle = 2
ordenado = .F.
texto_busqueda = 
pos_actual_texto = 0
ultimo_valor = 
titulos_cabeceras = 
list_controlsource = 
lista_ancho_cols = 
alias_name = 
permitir_busqueda = .T.
permitir_ordenamiento = .T.
Name = "gridcontrol"
Column1.FontBold = .T.
Column1.FontSize = 8
Column1.ReadOnly = .T.
Column1.Name = "Column1"
Column2.FontBold = .T.
Column2.FontSize = 8
Column2.ReadOnly = .T.
Column2.Name = "Column2"
Column3.FontBold = .T.
Column3.FontSize = 8
Column3.ReadOnly = .T.
Column3.Name = "Column3"
Column4.FontBold = .T.
Column4.FontSize = 8
Column4.ReadOnly = .T.
Column4.Name = "Column4"
Column5.FontBold = .T.
Column5.FontSize = 8
Column5.ReadOnly = .T.
Column5.Name = "Column5"
Column6.FontBold = .T.
Column6.FontSize = 8
Column6.ReadOnly = .T.
Column6.Name = "Column6"
Column7.FontBold = .T.
Column7.FontSize = 8
Column7.ReadOnly = .T.
Column7.Name = "Column7"
Column8.FontBold = .T.
Column8.FontSize = 8
Column8.ReadOnly = .T.
Column8.Name = "Column8"
Column9.FontBold = .T.
Column9.FontSize = 8
Column9.ReadOnly = .T.
Column9.Name = "Column9"
Column10.FontBold = .T.
Column10.FontSize = 8
Column10.ReadOnly = .T.
Column10.Name = "Column10"
Column11.FontBold = .T.
Column11.FontSize = 8
Column11.ReadOnly = .T.
Column11.Name = "Column11"
Column12.FontBold = .T.
Column12.FontSize = 8
Column12.ReadOnly = .T.
Column12.Name = "Column12"
Column13.FontBold = .T.
Column13.FontSize = 8
Column13.ReadOnly = .T.
Column13.Name = "Column13"
Column14.FontBold = .T.
Column14.FontSize = 8
Column14.ReadOnly = .T.
Column14.Name = "Column14"
Column15.FontBold = .T.
Column15.FontSize = 8
Column15.ReadOnly = .T.
Column15.Name = "Column15"
Column16.FontBold = .T.
Column16.FontSize = 8
Column16.ReadOnly = .T.
Column16.Name = "Column16"
Column17.FontBold = .T.
Column17.FontSize = 8
Column17.ReadOnly = .T.
Column17.Name = "Column17"
Column18.FontBold = .T.
Column18.FontSize = 8
Column18.ReadOnly = .T.
Column18.Name = "Column18"
Column19.FontBold = .T.
Column19.FontSize = 8
Column19.ReadOnly = .T.
Column19.Name = "Column19"
Column20.FontBold = .T.
Column20.FontSize = 8
Column20.ReadOnly = .T.
Column20.Name = "Column20"

*** METODOS ***
PROCEDURE localizar_registros
PARAMETERS c_campo, c_tag_indice, n_KeyCode

&& Hago la búsqueda progresiva

LOCAL lc_alias
LOCAL lc_campo_ref
LOCAL lc_indice


lc_alias = This.RecordSource
lc_indice = ALLTRIM(This.RecordSource)

IF (n_KeyCode = 24 .or. n_KeyCode = 5 .or. n_KeyCode = 4 .or. n_KeyCode = 19 .or. n_KeyCode = 27)
	&& Si me muevo con las flechas
	This.texto_busqueda = ""
	RETURN .F.
ENDIF

this.ordenado = .f.
this.ordenar_datos(c_campo)

lc_campo_ref = lc_alias + "." + ALLTRIM(c_campo)

IF n_KeyCode = 127
	IF This.pos_actual_texto <= 0
		GO TOP 
		This.texto_busqueda = ""
		RETURN .F.
	ELSE
		This.pos_actual_texto = This.pos_actual_texto - 1
		This.texto_busqueda = SUBSTR(This.texto_busqueda, 1, this.pos_actual_texto)
	ENDIF
	
	SELECT (lc_alias)
	DO CASE 
	CASE UPPER(TYPE('&lc_campo_ref')) $ 'C'
		LOCATE FOR ALLTRIM(&lc_campo_ref) >= this.texto_busqueda
	CASE UPPER(TYPE('&lc_campo_ref')) $ 'NIF'
		LOCATE FOR ALLTRIM(STR(&lc_campo_ref)) == This.texto_busqueda
	CASE UPPER(TYPE('&lc_campo_ref')) $ 'DT'
		MESSAGEBOX("No se puede buscar por fecha", 48, "Sistema")
		This.pos_actual_texto = 0
		This.texto_busqueda = ""
	ENDCASE
	
	IF FOUND()
		DO CASE
		CASE UPPER(TYPE('&lc_campo_ref')) $ 'C'
			This.ultimo_valor = ALLTRIM(&lc_campo_ref)
		CASE UPPER(TYPE('&lc_campo_ref')) $ 'NIF'
			This.ultimo_valor = STR(&lc_campo_ref)
		ENDCASE
	ENDIF
	
	WAIT WINDOW This.texto_busqueda NoWait
	RETURN .T.
ENDIF

IF 	(n_KeyCode >= 30 .And. n_KeyCode <= 59) 	.Or. ;
	(n_KeyCode >= 97 .And. n_KeyCode <= 122) 	.Or. ;
	(n_KeyCode >= 65 .And. n_KeyCode <= 90) 	.Or. ;
	(n_KeyCode = 241)
	
	This.texto_busqueda = This.texto_busqueda + UPPER(CHR(n_KeyCode))
	
	SELECT (lc_alias)
	DO CASE
		CASE UPPER(TYPE('&lc_campo_ref')) $ 'C'
			LOCATE FOR ALLTRIM(&lc_campo_ref) >= This.texto_busqueda
		CASE UPPER(TYPE('&lc_campo_ref')) $ 'NIF'
			LOCATE FOR ALLTRIM(STR(&lc_campo_ref)) == This.texto_busqueda
		CASE UPPER(TYPE('&lc_campo_ref')) $ 'DT'
			MESSAGEBOX('No se puede buscar por fecha',48, 'Sistema')
			This.pos_actual_texto = 0
			This.texto_busqueda = ""
			RETURN .F.
	ENDCASE
	
	IF FOUND()
		DO CASE
		CASE UPPER(TYPE('&lc_campo_ref')) $ 'C'
			This.ultimo_valor = ALLTRIM(&lc_campo_ref)
		CASE UPPER(TYPE('&lc_campo_ref')) $ 'NIF'
			This.ultimo_valor = STR(&lc_campo_ref)
		ENDCASE
	ENDIF
	
	WAIT WINDOW This.texto_busqueda NoWait
	This.pos_actual_texto = This.pos_actual_texto + 1
ENDIF

IF n_KeyCode = 9
	This.pos_actual_texto = 0
	This.texto_busqueda = ""
	
	DO CASE
	CASE UPPER(TYPE('&lc_campo_ref')) $ 'C'
		This.texto_busqueda = ALLTRIM(&lc_campo_ref)
	CASE UPPER(TYPE('&lc_campo_ref')) $ 'NIF'
		This.texto_busqueda = STR(&lc_campo_ref)
	ENDCASE
ENDIF

&& Comento las siguientes líneas porque debajo del llamado de esta función ya está contemplado
&& y provoca una doble ejecución del evento press_enter. Fecha: 26/01/2014
*IF n_KeyCode = 13
*	RAISEEVENT(This, "press_enter")
*ENDIF

SET EXACT ON
RETURN .T.
ENDPROC
PROCEDURE ordenar_datos
PARAMETERS c_campo

LOCAL li_ultimo_reg

li_ultimo_reg = 0

SELECT (This.RecordSource)

IF RECCOUNT() > 0
	li_ultimo_reg = RECNO()
ENDIF

IF This.ordenado
	SET ORDER TO TAG (c_campo) descending
	This.ordenado = .f.
ELSE
	SET ORDER TO TAG (c_campo) ascending
	This.ordenado = .t.
ENDIF

IF RECCOUNT() > 0 .AND. (li_ultimo_reg < RECCOUNT()) THEN
	GO li_ultimo_reg
ENDIF

This.Refresh()
ENDPROC
PROCEDURE generar_grid
&& Seteo las propiedades de la grilla

LOCAL li_max_columns

IF !EMPTY(This.list_controlsource)
	li_max_columns = GETWORDCOUNT(This.list_controlsource, ",")
	This.ColumnCount = li_max_columns
	
	FOR i = 1 TO li_max_columns	
		This.Columns[i].Header1.Caption = GETWORDNUM(This.titulos_cabeceras, i, ',')
		This.Columns[i].ControlSource = GETWORDNUM(This.list_controlsource, i, ',')
		This.Columns[i].Width = VAL(GETWORDNUM(This.lista_ancho_cols, i, ','))
	NEXT
ENDIF
ENDPROC
PROCEDURE Init
IF !EMPTY(ALLTRIM(This.alias_name))
	SELECT (This.Alias_name)
	This.RecordSource = This.alias_name
ENDIF

This.generar_grid()
ENDPROC


************************************************************
OBJETO: Header1
************************************************************
*** PROPIEDADES ***
FontBold = .T.
FontSize = 8
Alignment = 2
Caption = "Header1"
Name = "Header1"

*** METODOS ***
PROCEDURE Click
IF This.Parent.Parent.permitir_ordenamiento then
	This.Parent.Parent.ordenar_datos(This.Parent.ControlSource)
ENDIF
ENDPROC


************************************************************
OBJETO: Text1
************************************************************
*** PROPIEDADES ***
FontBold = .T.
FontSize = 8
BorderStyle = 0
Margin = 0
ReadOnly = .T.
ForeColor = 0,0,0
BackColor = 255,255,255
SelectedForeColor = 255,255,255
SelectedBackColor = 0,128,192
Name = "Text1"

*** METODOS ***
PROCEDURE KeyPress
LPARAMETERS nKeyCode, nShiftAltCtrl

IF nKeyCode = 5 .Or. nKeyCode = 4 .Or. nKeyCode = 19 .Or. nKeyCode = 24
	This.Parent.Parent.pos_actual_texto = 0
	This.Parent.Parent.texto_busqueda = ""
ENDIF

IF nKeyCode = 13
	this.Parent.Parent.press_enter()
ELSE
	IF This.Parent.Parent.permitir_busqueda THEN
		This.Parent.Parent.localizar_registros(This.Parent.ControlSource, This.Parent.ControlSource, nKeyCode)
		This.Parent.Parent.Refresh()
	ENDIF
ENDIF
ENDPROC


************************************************************
OBJETO: Header1
************************************************************
*** PROPIEDADES ***
FontBold = .T.
FontSize = 8
Alignment = 2
Caption = "Header1"
Name = "Header1"

*** METODOS ***
PROCEDURE Click
IF This.Parent.Parent.permitir_ordenamiento then
	This.Parent.Parent.ordenar_datos(This.Parent.ControlSource)
ENDIF
ENDPROC


************************************************************
OBJETO: Text1
************************************************************
*** PROPIEDADES ***
FontBold = .T.
FontSize = 8
BorderStyle = 0
Margin = 0
ReadOnly = .T.
ForeColor = 0,0,0
BackColor = 255,255,255
SelectedForeColor = 255,255,255
SelectedBackColor = 0,128,192
Name = "Text1"

*** METODOS ***
PROCEDURE KeyPress
LPARAMETERS nKeyCode, nShiftAltCtrl

IF nKeyCode = 5 .Or. nKeyCode = 4 .Or. nKeyCode = 19 .Or. nKeyCode = 24
	This.Parent.Parent.pos_actual_texto = 0
	This.Parent.Parent.texto_busqueda = ""
ENDIF

IF nKeyCode = 13
	this.Parent.Parent.press_enter()
ELSE
	IF This.Parent.Parent.permitir_busqueda THEN
		This.Parent.Parent.localizar_registros(This.Parent.ControlSource, This.Parent.ControlSource, nKeyCode)
		This.Parent.Parent.Refresh()
	ENDIF
ENDIF
ENDPROC


************************************************************
OBJETO: Header1
************************************************************
*** PROPIEDADES ***
FontBold = .T.
FontSize = 8
Alignment = 2
Caption = "Header1"
Name = "Header1"

*** METODOS ***
PROCEDURE Click
IF This.Parent.Parent.permitir_ordenamiento then
	This.Parent.Parent.ordenar_datos(This.Parent.ControlSource)
ENDIF
ENDPROC


************************************************************
OBJETO: Text1
************************************************************
*** PROPIEDADES ***
FontBold = .T.
FontSize = 8
BorderStyle = 0
Margin = 0
ReadOnly = .T.
ForeColor = 0,0,0
BackColor = 255,255,255
SelectedForeColor = 255,255,255
SelectedBackColor = 0,128,192
Name = "Text1"

*** METODOS ***
PROCEDURE KeyPress
LPARAMETERS nKeyCode, nShiftAltCtrl

IF nKeyCode = 5 .Or. nKeyCode = 4 .Or. nKeyCode = 19 .Or. nKeyCode = 24
	This.Parent.Parent.pos_actual_texto = 0
	This.Parent.Parent.texto_busqueda = ""
ENDIF

IF nKeyCode = 13
	this.Parent.Parent.press_enter()
ELSE
	IF This.Parent.Parent.permitir_busqueda THEN
		This.Parent.Parent.localizar_registros(This.Parent.ControlSource, This.Parent.ControlSource, nKeyCode)
		This.Parent.Parent.Refresh()
	ENDIF
ENDIF
ENDPROC


************************************************************
OBJETO: Header1
************************************************************
*** PROPIEDADES ***
FontBold = .T.
FontSize = 8
Alignment = 2
Caption = "Header1"
Name = "Header1"

*** METODOS ***
PROCEDURE Click
IF This.Parent.Parent.permitir_ordenamiento then
	This.Parent.Parent.ordenar_datos(This.Parent.ControlSource)
ENDIF
ENDPROC


************************************************************
OBJETO: Text1
************************************************************
*** PROPIEDADES ***
FontBold = .T.
FontSize = 8
BorderStyle = 0
Margin = 0
ReadOnly = .T.
ForeColor = 0,0,0
BackColor = 255,255,255
SelectedForeColor = 255,255,255
SelectedBackColor = 0,128,192
Name = "Text1"

*** METODOS ***
PROCEDURE KeyPress
LPARAMETERS nKeyCode, nShiftAltCtrl

IF nKeyCode = 5 .Or. nKeyCode = 4 .Or. nKeyCode = 19 .Or. nKeyCode = 24
	This.Parent.Parent.pos_actual_texto = 0
	This.Parent.Parent.texto_busqueda = ""
ENDIF

IF nKeyCode = 13
	this.Parent.Parent.press_enter()
ELSE
	IF This.Parent.Parent.permitir_busqueda THEN
		This.Parent.Parent.localizar_registros(This.Parent.ControlSource, This.Parent.ControlSource, nKeyCode)
		This.Parent.Parent.Refresh()
	ENDIF
ENDIF
ENDPROC


************************************************************
OBJETO: Header1
************************************************************
*** PROPIEDADES ***
FontBold = .T.
FontSize = 8
Alignment = 2
Caption = "Header1"
Name = "Header1"

*** METODOS ***
PROCEDURE Click
IF This.Parent.Parent.permitir_ordenamiento then
	This.Parent.Parent.ordenar_datos(This.Parent.ControlSource)
ENDIF
ENDPROC


************************************************************
OBJETO: Text1
************************************************************
*** PROPIEDADES ***
FontBold = .T.
FontSize = 8
BorderStyle = 0
Margin = 0
ReadOnly = .T.
ForeColor = 0,0,0
BackColor = 255,255,255
SelectedForeColor = 255,255,255
SelectedBackColor = 0,128,192
Name = "Text1"

*** METODOS ***
PROCEDURE KeyPress
LPARAMETERS nKeyCode, nShiftAltCtrl

IF nKeyCode = 5 .Or. nKeyCode = 4 .Or. nKeyCode = 19 .Or. nKeyCode = 24
	This.Parent.Parent.pos_actual_texto = 0
	This.Parent.Parent.texto_busqueda = ""
ENDIF

IF nKeyCode = 13
	this.Parent.Parent.press_enter()
ELSE
	IF This.Parent.Parent.permitir_busqueda THEN
		This.Parent.Parent.localizar_registros(This.Parent.ControlSource, This.Parent.ControlSource, nKeyCode)
		This.Parent.Parent.Refresh()
	ENDIF
ENDIF
ENDPROC


************************************************************
OBJETO: Header1
************************************************************
*** PROPIEDADES ***
FontBold = .T.
FontSize = 8
Alignment = 2
Caption = "Header1"
Name = "Header1"

*** METODOS ***
PROCEDURE Click
IF This.Parent.Parent.permitir_ordenamiento then
	This.Parent.Parent.ordenar_datos(This.Parent.ControlSource)
ENDIF
ENDPROC


************************************************************
OBJETO: Text1
************************************************************
*** PROPIEDADES ***
FontBold = .T.
FontSize = 8
BorderStyle = 0
Margin = 0
ReadOnly = .T.
ForeColor = 0,0,0
BackColor = 255,255,255
SelectedForeColor = 255,255,255
SelectedBackColor = 0,128,192
Name = "Text1"

*** METODOS ***
PROCEDURE KeyPress
LPARAMETERS nKeyCode, nShiftAltCtrl

IF nKeyCode = 5 .Or. nKeyCode = 4 .Or. nKeyCode = 19 .Or. nKeyCode = 24
	This.Parent.Parent.pos_actual_texto = 0
	This.Parent.Parent.texto_busqueda = ""
ENDIF

IF nKeyCode = 13
	this.Parent.Parent.press_enter()
ELSE
	IF This.Parent.Parent.permitir_busqueda THEN
		This.Parent.Parent.localizar_registros(This.Parent.ControlSource, This.Parent.ControlSource, nKeyCode)
		This.Parent.Parent.Refresh()
	ENDIF
ENDIF
ENDPROC


************************************************************
OBJETO: Header1
************************************************************
*** PROPIEDADES ***
FontBold = .T.
FontSize = 8
Alignment = 2
Caption = "Header1"
Name = "Header1"

*** METODOS ***
PROCEDURE Click
IF This.Parent.Parent.permitir_ordenamiento then
	This.Parent.Parent.ordenar_datos(This.Parent.ControlSource)
ENDIF
ENDPROC


************************************************************
OBJETO: Text1
************************************************************
*** PROPIEDADES ***
FontBold = .T.
FontSize = 8
BorderStyle = 0
Margin = 0
ReadOnly = .T.
ForeColor = 0,0,0
BackColor = 255,255,255
SelectedForeColor = 255,255,255
SelectedBackColor = 0,128,192
Name = "Text1"

*** METODOS ***
PROCEDURE KeyPress
LPARAMETERS nKeyCode, nShiftAltCtrl

IF nKeyCode = 5 .Or. nKeyCode = 4 .Or. nKeyCode = 19 .Or. nKeyCode = 24
	This.Parent.Parent.pos_actual_texto = 0
	This.Parent.Parent.texto_busqueda = ""
ENDIF

IF nKeyCode = 13
	this.Parent.Parent.press_enter()
ELSE
	IF This.Parent.Parent.permitir_busqueda THEN
		This.Parent.Parent.localizar_registros(This.Parent.ControlSource, This.Parent.ControlSource, nKeyCode)
		This.Parent.Parent.Refresh()
	ENDIF
ENDIF
ENDPROC


************************************************************
OBJETO: Header1
************************************************************
*** PROPIEDADES ***
FontBold = .T.
FontSize = 8
Alignment = 2
Caption = "Header1"
Name = "Header1"

*** METODOS ***
PROCEDURE Click
IF This.Parent.Parent.permitir_ordenamiento then
	This.Parent.Parent.ordenar_datos(This.Parent.ControlSource)
ENDIF
ENDPROC


************************************************************
OBJETO: Text1
************************************************************
*** PROPIEDADES ***
FontBold = .T.
FontSize = 8
BorderStyle = 0
Margin = 0
ReadOnly = .T.
ForeColor = 0,0,0
BackColor = 255,255,255
SelectedForeColor = 255,255,255
SelectedBackColor = 0,128,192
Name = "Text1"

*** METODOS ***
PROCEDURE KeyPress
LPARAMETERS nKeyCode, nShiftAltCtrl

IF nKeyCode = 5 .Or. nKeyCode = 4 .Or. nKeyCode = 19 .Or. nKeyCode = 24
	This.Parent.Parent.pos_actual_texto = 0
	This.Parent.Parent.texto_busqueda = ""
ENDIF

IF nKeyCode = 13
	this.Parent.Parent.press_enter()
ELSE
	IF This.Parent.Parent.permitir_busqueda THEN
		This.Parent.Parent.localizar_registros(This.Parent.ControlSource, This.Parent.ControlSource, nKeyCode)
		This.Parent.Parent.Refresh()
	ENDIF
ENDIF
ENDPROC


************************************************************
OBJETO: Header1
************************************************************
*** PROPIEDADES ***
FontBold = .T.
FontSize = 8
Alignment = 2
Caption = "Header1"
Name = "Header1"

*** METODOS ***
PROCEDURE Click
IF This.Parent.Parent.permitir_ordenamiento then
	This.Parent.Parent.ordenar_datos(This.Parent.ControlSource)
ENDIF
ENDPROC


************************************************************
OBJETO: Text1
************************************************************
*** PROPIEDADES ***
FontBold = .T.
FontSize = 8
BorderStyle = 0
Margin = 0
ReadOnly = .T.
ForeColor = 0,0,0
BackColor = 255,255,255
SelectedForeColor = 255,255,255
SelectedBackColor = 0,128,192
Name = "Text1"

*** METODOS ***
PROCEDURE KeyPress
LPARAMETERS nKeyCode, nShiftAltCtrl

IF nKeyCode = 5 .Or. nKeyCode = 4 .Or. nKeyCode = 19 .Or. nKeyCode = 24
	This.Parent.Parent.pos_actual_texto = 0
	This.Parent.Parent.texto_busqueda = ""
ENDIF

IF nKeyCode = 13
	this.Parent.Parent.press_enter()
ELSE
	IF This.Parent.Parent.permitir_busqueda THEN
		This.Parent.Parent.localizar_registros(This.Parent.ControlSource, This.Parent.ControlSource, nKeyCode)
		This.Parent.Parent.Refresh()
	ENDIF
ENDIF
ENDPROC


************************************************************
OBJETO: Header1
************************************************************
*** PROPIEDADES ***
FontBold = .T.
FontSize = 8
Alignment = 2
Caption = "Header1"
Name = "Header1"

*** METODOS ***
PROCEDURE Click
IF This.Parent.Parent.permitir_ordenamiento then
	This.Parent.Parent.ordenar_datos(This.Parent.ControlSource)
ENDIF
ENDPROC


************************************************************
OBJETO: Text1
************************************************************
*** PROPIEDADES ***
FontBold = .T.
FontSize = 8
BorderStyle = 0
Margin = 0
ReadOnly = .T.
ForeColor = 0,0,0
BackColor = 255,255,255
SelectedForeColor = 255,255,255
SelectedBackColor = 0,128,192
Name = "Text1"

*** METODOS ***
PROCEDURE KeyPress
LPARAMETERS nKeyCode, nShiftAltCtrl

IF nKeyCode = 5 .Or. nKeyCode = 4 .Or. nKeyCode = 19 .Or. nKeyCode = 24
	This.Parent.Parent.pos_actual_texto = 0
	This.Parent.Parent.texto_busqueda = ""
ENDIF

IF nKeyCode = 13
	this.Parent.Parent.press_enter()
ELSE
	IF This.Parent.Parent.permitir_busqueda THEN
		This.Parent.Parent.localizar_registros(This.Parent.ControlSource, This.Parent.ControlSource, nKeyCode)
		This.Parent.Parent.Refresh()
	ENDIF
ENDIF
ENDPROC


************************************************************
OBJETO: Header1
************************************************************
*** PROPIEDADES ***
FontBold = .T.
FontSize = 8
Caption = "Header1"
Name = "Header1"

*** METODOS ***


************************************************************
OBJETO: Text1
************************************************************
*** PROPIEDADES ***
FontBold = .T.
FontSize = 8
BorderStyle = 0
Margin = 0
ForeColor = 0,0,0
BackColor = 255,255,255
SelectedForeColor = 255,255,255
SelectedBackColor = 0,128,192
Name = "Text1"

*** METODOS ***


************************************************************
OBJETO: Header1
************************************************************
*** PROPIEDADES ***
FontBold = .T.
FontSize = 8
Caption = "Header1"
Name = "Header1"

*** METODOS ***


************************************************************
OBJETO: Text1
************************************************************
*** PROPIEDADES ***
FontBold = .T.
FontSize = 8
BorderStyle = 0
Margin = 0
ForeColor = 0,0,0
BackColor = 255,255,255
SelectedForeColor = 255,255,255
SelectedBackColor = 0,128,192
Name = "Text1"

*** METODOS ***


************************************************************
OBJETO: Header1
************************************************************
*** PROPIEDADES ***
FontBold = .T.
FontSize = 8
Caption = "Header1"
Name = "Header1"

*** METODOS ***


************************************************************
OBJETO: Text1
************************************************************
*** PROPIEDADES ***
FontBold = .T.
FontSize = 8
BorderStyle = 0
Margin = 0
ForeColor = 0,0,0
BackColor = 255,255,255
SelectedForeColor = 255,255,255
SelectedBackColor = 0,128,192
Name = "Text1"

*** METODOS ***


************************************************************
OBJETO: Header1
************************************************************
*** PROPIEDADES ***
FontBold = .T.
FontSize = 8
Caption = "Header1"
Name = "Header1"

*** METODOS ***


************************************************************
OBJETO: Text1
************************************************************
*** PROPIEDADES ***
FontBold = .T.
FontSize = 8
BorderStyle = 0
Margin = 0
ForeColor = 0,0,0
BackColor = 255,255,255
SelectedForeColor = 255,255,255
SelectedBackColor = 0,128,192
Name = "Text1"

*** METODOS ***


************************************************************
OBJETO: Header1
************************************************************
*** PROPIEDADES ***
FontBold = .T.
FontSize = 8
Caption = "Header1"
Name = "Header1"

*** METODOS ***


************************************************************
OBJETO: Text1
************************************************************
*** PROPIEDADES ***
FontBold = .T.
FontSize = 8
BorderStyle = 0
Margin = 0
ForeColor = 0,0,0
BackColor = 255,255,255
SelectedForeColor = 255,255,255
SelectedBackColor = 0,128,192
Name = "Text1"

*** METODOS ***


************************************************************
OBJETO: Header1
************************************************************
*** PROPIEDADES ***
FontBold = .T.
FontSize = 8
Caption = "Header1"
Name = "Header1"

*** METODOS ***


************************************************************
OBJETO: Text1
************************************************************
*** PROPIEDADES ***
FontBold = .T.
FontSize = 8
BorderStyle = 0
Margin = 0
ForeColor = 0,0,0
BackColor = 255,255,255
SelectedForeColor = 255,255,255
SelectedBackColor = 0,128,192
Name = "Text1"

*** METODOS ***


************************************************************
OBJETO: Header1
************************************************************
*** PROPIEDADES ***
FontBold = .T.
FontSize = 8
Caption = "Header1"
Name = "Header1"

*** METODOS ***


************************************************************
OBJETO: Text1
************************************************************
*** PROPIEDADES ***
FontBold = .T.
FontSize = 8
BorderStyle = 0
Margin = 0
ForeColor = 0,0,0
BackColor = 255,255,255
SelectedForeColor = 255,255,255
SelectedBackColor = 0,128,192
Name = "Text1"

*** METODOS ***


************************************************************
OBJETO: Header1
************************************************************
*** PROPIEDADES ***
FontBold = .T.
FontSize = 8
Caption = "Header1"
Name = "Header1"

*** METODOS ***


************************************************************
OBJETO: Text1
************************************************************
*** PROPIEDADES ***
FontBold = .T.
FontSize = 8
BorderStyle = 0
Margin = 0
ForeColor = 0,0,0
BackColor = 255,255,255
SelectedForeColor = 255,255,255
SelectedBackColor = 0,128,192
Name = "Text1"

*** METODOS ***


************************************************************
OBJETO: Header1
************************************************************
*** PROPIEDADES ***
FontBold = .T.
FontSize = 8
Caption = "Header1"
Name = "Header1"

*** METODOS ***


************************************************************
OBJETO: Text1
************************************************************
*** PROPIEDADES ***
FontBold = .T.
FontSize = 8
BorderStyle = 0
Margin = 0
ForeColor = 0,0,0
BackColor = 255,255,255
SelectedForeColor = 255,255,255
SelectedBackColor = 0,128,192
Name = "Text1"

*** METODOS ***


************************************************************
OBJETO: Header1
************************************************************
*** PROPIEDADES ***
FontBold = .T.
FontSize = 8
Caption = "Header1"
Name = "Header1"

*** METODOS ***


************************************************************
OBJETO: Text1
************************************************************
*** PROPIEDADES ***
FontBold = .T.
FontSize = 8
BorderStyle = 0
Margin = 0
ForeColor = 0,0,0
BackColor = 255,255,255
SelectedForeColor = 255,255,255
SelectedBackColor = 0,128,192
Name = "Text1"

*** METODOS ***


************************************************************
OBJETO: gridcontrol
************************************************************
*** PROPIEDADES ***
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: clstextbox
************************************************************
*** PROPIEDADES ***
Tag = "edit"
FontBold = .T.
FontSize = 8
Format = "K!"
Height = 21
SelectOnEntry = .T.
SpecialEffect = 0
Width = 100
Style = 0
BackColor = 255,255,255
BorderColor = 128,128,128
requerido = .T.
isnumeric = .F.
isdatetime = .F.
isinteger = .F.
msgerror = 
autocompleta = .F.
ischaracter = .F.
cfieldname = 
Name = "clstextbox"

*** METODOS ***
PROCEDURE estavacio
DO CASE
CASE this.isdatetime
	IF this.value = {}
		RETURN .T.
	ENDIF
CASE this.isinteger
	IF this.Value = 0
		RETURN .T.
	ENDIF
CASE this.isnumeric
	IF this.Value = 0
		RETURN .T.
	ENDIF
CASE this.ischaracter
	IF ALLTRIM(this.Value) == ""
		RETURN .T.
	ENDIF
ENDCASE

RETURN .F.

ENDPROC
PROCEDURE blanquear
IF this.isnumeric
	this.Value = 0.00
	this.InputMask = "999999999.99"
ENDIF

IF this.isdatetime
	this.Value = {}
ENDIF

IF this.isInteger
	this.Value = 0
ENDIF

IF this.ischaracter
	this.Value = ""
ENDIF


ENDPROC
PROCEDURE LostFocus
this.BackColor = RGB(255, 255, 255)
this.Refresh()

IF this.autocompleta
	this.Value = REPLICATE("0", this.MaxLength - LEN(ALLTRIM(this.Value))) + ALLTRIM(this.Value)
ENDIF

this.calcular()
ENDPROC
PROCEDURE GotFocus
this.BackColor = RGB(226,230,254)
ENDPROC
PROCEDURE Init
this.blanquear()

ENDPROC


************************************************************
OBJETO: clstextbox
************************************************************
*** PROPIEDADES ***
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: contenedor
************************************************************
*** PROPIEDADES ***
Width = 534
Height = 135
BackColor = 255,255,255
BorderColor = 128,128,128
Name = "contenedor"

*** METODOS ***


************************************************************
OBJETO: funciones
************************************************************
*** PROPIEDADES ***
Name = "funciones"

*** METODOS ***
PROCEDURE calcular_descuento
&& Calcular Descuentos Clientes
PARAMETERS tnNeto, tnDesc1, tnDesc2, tnDesc3, tnDesc4

LOCAL lnTotal

lnTotal = 0.00

lnTotal = tnNeto - (tnNeto * (tnDesc1 / 100))
lnTotal = lnTotal - (lnTotal * (tnDesc2 / 100))
lnTotal = lnTotal - (lnTotal * (tnDesc3 / 100))
lnTotal = lnTotal - (lnTotal * (tnDesc4 / 100))

RETURN lnTotal
ENDPROC
PROCEDURE calcular_costo
&& Nombre del programa: calcular_costo
&& Calcula el costo de reposición

PARAMETERS tf_PrLista, tf_Bonif1, tf_Bonif2, tf_Bonif3, tf_Bonif4, tf_PorGtos

LOCAL lf_Costo

lf_Costo = tf_PrLista - (tf_PrLista * (tf_Bonif1 / 100))
lf_Costo = lf_Costo - (lf_Costo * (tf_Bonif2 / 100))
lf_Costo = lf_Costo - (lf_Costo * (tf_Bonif3 / 100))
lf_Costo = lf_Costo - (lf_Costo * (tf_Bonif4 / 100))
lf_Costo = lf_Costo - (lf_Costo * (tf_PorGtos / 100))


RETURN ROUND(lf_Costo, 2)
ENDPROC
PROCEDURE calcular_venta
&& Programa: Calcular_Venta
&& Calcula el precio de venta

PARAMETERS tf_Costo, tf_Rentab1

LOCAL lf_Venta

lf_Venta = tf_Costo + (tf_Costo * (tf_Rentab1 / 100))

RETURN ROUND(lf_Venta, 2)
ENDPROC


************************************************************
OBJETO: selector_tabla
************************************************************
*** PROPIEDADES ***
Tag = "edit"
Width = 487
Height = 25
BackStyle = 0
BorderWidth = 0
nombre_campo_desc = 
nombre_tabla = 
esnumerico = .F.
autocompletar_ceros = .T.
nombre_campo_codigo = 
permitir_agregar_regs = .F.
nombre_alta_form = 
pkfield = 
valcpoid = 0
msgerror = 
cfieldname = 
requerido = .T.
localizado_manual = .F.
anchos_cols = 400
alternative_cols = 
title_cols = Descripción
criterio_filtro = 
Name = "selector_tabla"

*** METODOS ***
PROCEDURE cerrar_tabla
USE IN cur_aux
ENDPROC
PROCEDURE blanquear
This.txtCodigo.blanquear()
This.txtDescripcion.Value = ""
This.valcpoid = 0
ENDPROC
PROCEDURE estavacio
RETURN this.txtCodigo.estavacio()

*!*	IF TYPE("this.txtCodigo.Value") == "N" THEN
*!*		IF this.txtCodigo.Value = 0 THEN
*!*			RETURN .T.
*!*		ELSE
*!*			RETURN .F.
*!*		ENDIF
*!*	ELSE
*!*		IF ALLTRIM(This.txtCodigo.Value) == "" THEN
*!*			RETURN .T.
*!*		ELSE
*!*			RETURN .F.
*!*		ENDIF
*!*	ENDIF

ENDPROC
PROCEDURE setvalue
* ----------------------------------------------------------------------
* Este procedimiento permite setear el valor del campo clave
* y recuperar los valores en los cuadros de texto correspondientes.
* 
* tcValue: 	Valor del campo Id. (Parámetro)
* lcRef:	Macro de sustitución. Referencia de tabla.campo a recuperar
* 
* Desarrollado por: Leonardo D. Zulli
* Fecha: 30/12/2010
* ----------------------------------------------------------------------


LPARAMETERS tcValue

LOCAL lcRef, dataObject, cAlias

dataObject = CREATEOBJECT("datObject")
dataObject.cPkFieldName = this.pkfield
dataObject.cTableName = this.nombre_tabla
dataObject.nombre_Cursor = "__AUX"
dataObject.Initializate()

IF !dataObject.getByAnything(this.pkfield, tcValue) THEN
	This.txtCodigo.blanquear()
	This.txtDescripcion.Value = ""
	RETURN .F.
ENDIF

cAlias = dataObject.nombre_cursor

SELECT (cAlias)

this.valcpoid = tcValue
lcRef = ALLTRIM(cAlias) + "." + ALLTRIM(this.pkfield)

SELECT (cAlias)
LOCATE FOR &lcRef = tcvalue

IF FOUND(cAlias)
	lcRef = ALLTRIM(cAlias) + "." + ALLTRIM(this.nombre_campo_codigo)
	This.txtCodigo.Value = &lcRef
	
	lcRef = ALLTRIM(cAlias) + "." + ALLTRIM(this.nombre_campo_desc)
	This.txtDescripcion.Value = &lcRef	
ENDIF

IF USED("__AUX")
	USE IN __AUX
ENDIF

RETURN .T.
ENDPROC
PROCEDURE habilitar
PARAMETERS tl_Estado

This.txtCodigo.Enabled = tl_Estado
ENDPROC
PROCEDURE buscar_registro
LOCAL frm
LOCAL c_referencia 

frm = CREATEOBJECT("frm_Busqueda")

SELECT (SUBSTR(this.nombre_tabla, 1, 10))
frm.alias_name = SUBSTR(this.nombre_tabla, 1, 10)
frm.titulos_cabeceras = "Código," + this.title_cols

IF !(TYPE("this.anchos_cols") == "C") THEN
	frm.lista_ancho_cols = "150, " + ALLTRIM(STR(this.anchos_cols))
ELSE
	frm.lista_ancho_cols = "150, " + this.anchos_cols
ENDIF

frm.lista_controlsource = This.Nombre_campo_codigo + "," ;
	+ This.nombre_campo_desc + IIF(!EMPTY(this.alternative_cols), "," ;
	+ this.alternative_cols, "")
frm.nombre_form_nuevo = This.nombre_alta_form
frm.permitir_nuevo = This.permitir_agregar_regs
frm.nombre_campo_codigo = this.nombre_campo_codigo
frm.nombre_campo_desc = this.nombre_campo_desc
frm.criterios = this.criterio_filtro

frm.mostrar_form()	

IF frm.DialogResult = 0
	&& Si el usuario hizo clic en Cancelar, destruyo el objeto
	&& de memoria e inicializo el control código a vacío o 0 (cero)
	DO CASE 
		CASE TYPE('This.Value') $ "C"
			This.Value = ""
		CASE TYPE('This.Value') $ "NIF"
			This.value = 0
	ENDCASE 
	
	frm.release()
ELSE
	&& Si el usuario hizo clic en Aceptar, entonces procedo
	SELECT (SUBSTR(this.nombre_tabla, 1, 10))
	c_referencia = SUBSTR(this.nombre_tabla, 1, 10) + "." + This.nombre_campo_codigo
	This.txtCodigo.Value = &c_referencia
	c_referencia = SUBSTR(this.nombre_tabla, 1, 10) + "." + This.nombre_campo_desc
	This.txtDescripcion.Value = &c_referencia
	c_referencia = SUBSTR(this.nombre_tabla, 1, 10) + "." + This.pkfield
	This.valcpoid = &c_referencia
	
	frm.release()
	This.recuperar_datos()
	This.localizado_manual = .T.
ENDIF


ENDPROC
PROCEDURE obtener_por_codigo
LOCAL loRes
LOCAL lcSql
LOCAL lcRef
LOCAL lcCursorName

loRes = CREATEOBJECT("odbc_result")
lcCursorName = SUBSTR(this.nombre_tabla, 1, 10)
lcSql = "SELECT * FROM " + this.nombre_tabla + " "
IF TYPE("this.txtCodigo.Value") == "C" THEN
	lcSql = lcSql + "WHERE " + this.nombre_campo_codigo + " = '" + ALLTRIM(this.txtCodigo.Value) + "' "
ELSE
	lcSql = lcSql + "WHERE " + this.nombre_campo_codigo + " = " + ALLTRIM(STR(this.txtCodigo.Value)) + " "
ENDIF

IF !(ALLTRIM(this.criterio_filtro) == "") THEN
	lcSql = lcSql + "AND " + ALLTRIM(this.criterio_filtro)
ENDIF

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_temp"
loRes.OpenQuery(lcSql)
SELECT (lcCursorName)
ZAP
APPEND FROM DBF("cur_temp")
lcRef = lcCursorName + "." + this.nombre_campo_codigo
this.txtCodigo.Value = &lcRef
lcRef = lcCursorName + "." + this.nombre_campo_desc
this.txtDescripcion.Value = &lcRef
lcRef = lcCursorName + "." + this.pkfield
this.valcpoid = &lcRef


ENDPROC
PROCEDURE create_index_cursor
LOCAL i
LOCAL lcFieldName
LOCAL lcListFields

lcListFields = This.Nombre_campo_codigo + "," ;
	+ This.nombre_campo_desc ;
	+ IIF(!EMPTY(this.alternative_cols), "," + this.alternative_cols, "")

SELECT (SUBSTR(this.nombre_tabla, 1, 10))
FOR i = 1 TO GETWORDCOUNT(lcListFields,",")
	lcFieldName = GETWORDNUM(lcListFields, i, ",")
	IF i = 1 THEN
		INDEX ON &lcFieldName TAG &lcFieldName ASCENDING
	ELSE
		INDEX ON &lcFieldName TAG &lcFieldName ASCENDING ADDITIVE
	ENDIF
NEXT i
ENDPROC
PROCEDURE Init
LOCAL loRes
LOCAL lcSql

lcSql = "SELECT * FROM " + this.nombre_tabla + " ";
	+ "WHERE 1 = 0"
loRes = CREATEOBJECT("odbc_result")
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = SUBSTR(this.nombre_tabla, 1, 10)
loRes.OpenQuery(lcSql)
SELECT (SUBSTR(this.nombre_tabla, 1, 10))
This.create_index_cursor()

IF This.esnumerico
	This.txtCodigo.IsInteger = .T.
	This.txtCodigo.Value = 0
ELSE
	This.txtCodigo.ischaracter = .T.
	This.txtCodigo.Value = ""
ENDIF

This.localizado_manual = .F.

ENDPROC


************************************************************
OBJETO: txtCodigo
************************************************************
*** PROPIEDADES ***
Left = 2
Top = 2
Name = "txtCodigo"

*** METODOS ***
PROCEDURE GotFocus
WAIT WINDOW "Si no recuerda el código, presione la tecla F1 para buscar..." NOWAIT
ENDPROC
PROCEDURE KeyPress
LPARAMETERS nKeyCode, nShiftAltCtrl

IF nKeyCode = 28 THEN
	This.Parent.buscar_registro()
ENDIF
ENDPROC
PROCEDURE LostFocus
&& Busco el registro según el código ingresado

LOCAL lcReferencia

lcReferencia = SUBSTR(this.Parent.nombre_tabla, 1, 10) + "." + This.Parent.nombre_campo_codigo
DODEFAULT()

IF !This.Parent.localizado_manual THEN
	IF This.ischaracter
		IF EMPTY(This.Value)
			This.Parent.txtDescripcion.Value = ""
			RETURN .F.
		ENDIF
	ELSE
		IF This.Value = 0
			This.Parent.txtDescripcion.Value = ""
			RETURN .F.
		ENDIF
	ENDIF
	this.Parent.obtener_por_codigo()
	SELECT (SUBSTR(this.Parent.nombre_tabla, 1, 10))
	IF RECCOUNT(SUBSTR(this.Parent.nombre_tabla, 1, 10)) > 0 THEN
		lcReferencia = SUBSTR(this.Parent.nombre_tabla, 1, 10) + "." + This.Parent.nombre_campo_desc
		This.Parent.txtDescripcion.Value = &lcReferencia
		lcReferencia = SUBSTR(this.Parent.nombre_tabla, 1, 10) + "." + This.Parent.pkfield
		This.Parent.valcpoid = &lcReferencia
	ELSE
		this.Parent.buscar_registro()
	ENDIF
	This.Parent.recuperar_datos()
ENDIF

This.Parent.Localizado_manual = .F.

RETURN .T.
ENDPROC


************************************************************
OBJETO: txtDescripcion
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 106
Top = 2
Width = 374
Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: selector_tabla
************************************************************
*** PROPIEDADES ***
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: frm_busqueda
************************************************************
*** PROPIEDADES ***
BorderStyle = 2
Height = 506
Width = 910
DoCreate = .T.
AutoCenter = .T.
Caption = "Búsqueda inteligente"
ControlBox = .F.
Closable = .F.
MaxButton = .F.
MinButton = .F.
Icon = ..\..\siscom_renato\
WindowType = 1
lista_controlsource = 
lista_ancho_cols = 
titulos_cabeceras = 
alias_name = 
permitir_nuevo = .F.
nombre_form_nuevo = 
dialogresult = 0
nombre_campo_codigo = 
nombre_campo_desc = 
criterios = .F.
Name = "frm_busqueda"

*** METODOS ***
PROCEDURE mostrar_form
IF Thisform.permitir_nuevo 
	Thisform.cmdNuevo.Visible = .T.
ELSE
	Thisform.cmdNuevo.Visible = .F.
ENDIF

SELECT (Thisform.alias_name)
GO TOP
ZAP
Thisform.configurar_grid()
This.txtvalorbuscado.SetFocus()

SELECT (This.alias_name)
IF RECCOUNT() > 0
	GO TOP
ENDIF

Thisform.Visible = .T.
Thisform.Show()
ENDPROC
PROCEDURE buscar_registros
LOCAL loRes
LOCAL lcSql
LOCAL lcFilter
LOCAL i
LOCAL lcRef
DECLARE aPalabras[1]

IF ALLTRIM(this.txtValorBuscado.Value) == ""  THEN
	RETURN
ENDIF

DIMENSION aPalabras[GETWORDCOUNT(this.txtValorBuscado.Value)]
FOR i = 1 TO GETWORDCOUNT(this.txtValorBuscado.Value)
	aPalabras[i] = GETWORDNUM(this.txtValorBuscado.Value, i)
NEXT i

FOR i = 1 TO ALEN(aPalabras)
	IF i = 1 THEN
		lcFiltro = "CONCAT(" + this.alias_name + "." + this.nombre_campo_codigo + ", ' ', " ;
			+ this.alias_name + "." + this.nombre_campo_desc + ") LIKE '%"
	ELSE
		lcFiltro = lcFiltro + "AND CONCAT(" + this.alias_name + "." + this.nombre_campo_codigo + ", ' ', " ;
			+ this.alias_name + "." + this.nombre_campo_desc + ") LIKE '%"
	ENDIF
	
	lcFiltro = lcFiltro + ALLTRIM(aPalabras[i]) + "%'"
NEXT i

lcSql = "SELECT * FROM " + this.alias_name + " " ;
	+ "WHERE " + lcFiltro + " "
IF !(ALLTRIM(this.criterios) == "") THEN	
	lcSql = lcSql + " AND " + ALLTRIM(this.criterios)
ENDIF

loRes = CREATEOBJECT("odbc_result")
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_tmp"
loRes.OpenQuery(lcSql)
SELECT (SUBSTR(this.alias_name, 1, 10))
ZAP
APPEND FROM DBF("cur_tmp")
loRes.Close_Query()
Thisform.localizar_registro()
SELECT (SUBSTR(this.alias_name, 1, 10))
Thisform.configurar_grid()

ENDPROC
PROCEDURE configurar_grid
SELECT (SUBSTR(this.alias_name, 1, 10))
Thisform.grd.RecordSource = SUBSTR(this.alias_name, 1, 10)
Thisform.grd.lista_ancho_cols = Thisform.lista_ancho_cols
Thisform.grd.list_controlsource = Thisform.lista_controlsource
Thisform.grd.titulos_cabeceras = Thisform.titulos_cabeceras
Thisform.grd.generar_grid()
*This.grd.Column2.header1.Click()
ENDPROC
PROCEDURE seleccionar_registro
SELECT (SUBSTR(this.alias_name, 1, 10))
IF RECCOUNT(SUBSTR(this.alias_name, 1, 10)) = 0 THEN
	MESSAGEBOX("No hay registro seleccionado", 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

Thisform.Dialogresult = 1
Thisform.Hide()

ENDPROC
PROCEDURE create_cursor_index
LOCAL i
LOCAL lcFieldName

SELECT cur_aux
FOR i = 1 TO GETWORDCOUNT(this.lista_controlsource,",")
	lcFieldName = GETWORDNUM(this.lista_controlsource, i, ",")
	IF i = 1 THEN
		INDEX ON &lcFieldName TAG &lcFieldName ASCENDING
	ELSE
		INDEX ON &lcFieldName TAG &lcFieldName ASCENDING ADDITIVE
	ENDIF
NEXT i
ENDPROC
PROCEDURE localizar_registro
LOCAL lcRef

lcRef = SUBSTR(this.alias_name, 1, 10) + "." + ALLTRIM(this.nombre_campo_codigo)
SELECT (SUBSTR(this.alias_name, 1, 10))
GO TOP
SET ORDER TO TAG ALLTRIM(this.nombre_campo_codigo) ASCENDING
IF UPPER(TYPE(lcRef)) $ "C" THEN
	SET EXACT OFF
	LOCATE FOR &lcRef = ALLTRIM(this.txtValorBuscado.Value)
	IF !FOUND(SUBSTR(this.alias_name, 1, 10)) THEN
		GO TOP
	ENDIF
	SET EXACT ON
ENDIF
ENDPROC


************************************************************
OBJETO: cmdNuevo
************************************************************
*** PROPIEDADES ***
Top = 456
Left = 12
Height = 44
Width = 45
TabIndex = 5
Name = "cmdNuevo"

*** METODOS ***
PROCEDURE Click
&& Muestro el formulario en caso que el usuario
&& necesite agregar un nuevo registro.

Thisform.Dialogresult = 1
DO FORM (Thisform.nombre_form_nuevo)
Thisform.Hide()
ENDPROC


************************************************************
OBJETO: cmdCerrar
************************************************************
*** PROPIEDADES ***
Top = 455
Left = 857
Height = 44
Width = 45
Cancel = .T.
TabIndex = 4
Name = "cmdCerrar"

*** METODOS ***
PROCEDURE Click
This.Parent.Dialogresult = 0
This.Parent.Hide()
ENDPROC


************************************************************
OBJETO: grd
************************************************************
*** PROPIEDADES ***
Height = 395
Left = 6
TabIndex = 2
Top = 57
Width = 895
permitir_ordenamiento = .T.
Name = "grd"
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
PROCEDURE DblClick


ENDPROC
PROCEDURE press_enter
IF RECCOUNT(thisform.alias_name) = 0 THEN
	MESSAGEBOX("No hay registro seleccionado", 0+48, Thisform.Caption)
	RETURN .F.
ENDIF
Thisform.seleccionar_registro()
Thisform.Dialogresult = 1
Thisform.Hide()

ENDPROC
PROCEDURE COLUMN1.Text1.DblClick
IF RECCOUNT(thisform.alias_name) = 0 THEN
	MESSAGEBOX("No hay registro seleccionado", 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

*SELECT (Thisform.alias_name)
*SET FILTER TO 

Thisform.Dialogresult = 1
Thisform.Hide()

ENDPROC
PROCEDURE COLUMN2.Text1.DblClick
IF RECCOUNT(thisform.alias_name) = 0 THEN
	MESSAGEBOX("No hay registro seleccionado", 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT (Thisform.alias_name)
SET FILTER TO 

Thisform.Dialogresult = 1
Thisform.Hide()

ENDPROC
PROCEDURE COLUMN3.Text1.DblClick
IF RECCOUNT(thisform.alias_name) = 0 THEN
	MESSAGEBOX("No hay registro seleccionado", 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT (Thisform.alias_name)
SET FILTER TO 

Thisform.Dialogresult = 1
Thisform.Hide()

ENDPROC
PROCEDURE COLUMN4.Text1.DblClick
IF RECCOUNT(thisform.alias_name) = 0 THEN
	MESSAGEBOX("No hay registro seleccionado", 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT (Thisform.alias_name)
SET FILTER TO 

Thisform.Dialogresult = 1
Thisform.Hide()

ENDPROC
PROCEDURE COLUMN5.Text1.DblClick
IF RECCOUNT(thisform.alias_name) = 0 THEN
	MESSAGEBOX("No hay registro seleccionado", 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT (Thisform.alias_name)
SET FILTER TO 

Thisform.Dialogresult = 1
Thisform.Hide()

ENDPROC
PROCEDURE COLUMN6.Text1.DblClick
IF RECCOUNT(thisform.alias_name) = 0 THEN
	MESSAGEBOX("No hay registro seleccionado", 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT (Thisform.alias_name)
SET FILTER TO 

Thisform.Dialogresult = 1
Thisform.Hide()

ENDPROC
PROCEDURE COLUMN7.Text1.DblClick
IF RECCOUNT(thisform.alias_name) = 0 THEN
	MESSAGEBOX("No hay registro seleccionado", 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT (Thisform.alias_name)
SET FILTER TO 

Thisform.Dialogresult = 1
Thisform.Hide()

ENDPROC
PROCEDURE COLUMN8.Text1.DblClick
IF RECCOUNT(thisform.alias_name) = 0 THEN
	MESSAGEBOX("No hay registro seleccionado", 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT (Thisform.alias_name)
SET FILTER TO 

Thisform.Dialogresult = 1
Thisform.Hide()

ENDPROC
PROCEDURE COLUMN9.Text1.DblClick
IF RECCOUNT(thisform.alias_name) = 0 THEN
	MESSAGEBOX("No hay registro seleccionado", 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT (Thisform.alias_name)
SET FILTER TO 

Thisform.Dialogresult = 1
Thisform.Hide()

ENDPROC
PROCEDURE COLUMN10.Text1.DblClick
IF RECCOUNT(thisform.alias_name) = 0 THEN
	MESSAGEBOX("No hay registro seleccionado", 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT (Thisform.alias_name)
SET FILTER TO 

Thisform.Dialogresult = 1
Thisform.Hide()

ENDPROC


************************************************************
OBJETO: cmdAceptar
************************************************************
*** PROPIEDADES ***
Top = 455
Left = 810
Height = 44
Width = 45
Default = .F.
TabIndex = 3
Name = "cmdAceptar"

*** METODOS ***
PROCEDURE Click
thisform.seleccionar_registro()
ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "A continuación ingrese el valor buscado y presione la tecla ENTER para iniciar la búsqueda:"
Height = 15
Left = 10
Top = 9
Width = 890
TabIndex = 6
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: txtValorBuscado
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 7
TabIndex = 1
ToolTipText = "Ingrese el valor buscado y presione ENTER para iniciar la búsqueda"
Top = 30
Width = 894
Name = "txtValorBuscado"

*** METODOS ***
PROCEDURE KeyPress
LPARAMETERS nKeyCode, nShiftAltCtrl

IF nKeyCode = 13 THEN
	WAIT WINDOW "Buscando artíuclos, aguarde por favor..." NOWAIT
	this.Parent.buscar_registros()
	WAIT WINDOW "Listo..." NOWAIT
ENDIF
ENDPROC


************************************************************
OBJETO: frm_busqueda
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


