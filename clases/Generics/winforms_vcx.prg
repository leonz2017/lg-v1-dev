************************************************************
OBJETO: formingresos
************************************************************
*** PROPIEDADES ***
Height = 571
Width = 946
DoCreate = .T.
TitleBar = 0
BackColor = 0,64,128
msgerror = 
transok = .F.
Name = "formingresos"
contenido.cmdCerrar.Top = 525
contenido.cmdCerrar.Left = 886
contenido.cmdCerrar.Height = 33
contenido.cmdCerrar.Width = 37
contenido.cmdCerrar.ToolTipText = "Cerrar"
contenido.cmdCerrar.Name = "cmdCerrar"
contenido.Name = "contenido"

*** METODOS ***
PROCEDURE cambiar_estado
LPARAMETERS tlEstado

FOR EACH ctrl AS Control IN Thisform.Contenido.Cnt_cabecera
	ctrl.Enabled = tlEstado
	
	IF ctrl.Class == "Selector_tabla"
		FOR EACH ctrl_1 as Control IN ctrl.Controls
			ctrl_1.Enabled = tlEstado		
		ENDFOR
	ENDIF
ENDFOR

FOR EACH ctrl AS Control IN Thisform.contenido.cnt_etalle
	ctrl.Enabled = !tlEstado

	IF ctrl.Class == "Selector_tabla"
		FOR EACH ctrl_1 as Control IN ctrl.Controls
			ctrl_1.Enabled = !tlEstado		
		ENDFOR
	ENDIF
ENDFOR
ENDPROC
PROCEDURE validarcampos
FOR EACH ctrl IN thisform.contenido.cnt_cabecera.Controls
	IF ctrl.Tag = "edit"
		IF ctrl.Requerido = .T.
			IF ctrl.EstaVacio()
				Thisform.msgerror = ctrl.MsgError
				ctrl.SetFocus()
				RETURN .F.
			ENDIF		
		ENDIF
	ENDIF
ENDFOR

RETURN .T.

ENDPROC
PROCEDURE validardetalle
FOR EACH ctrl IN thisform.contenido.cntDetalle
	IF ctrl.tag = "edit"
		IF ctrl.EstaVacio()
			thisform.msgerror = ctrl.MsgError
			ctrl.SetFocus()
			RETURN .F.
		ENDIF
	ENDIF
ENDFOR

RETURN .T.
ENDPROC
PROCEDURE agregar
IF !Thisform.ValidarDetalle()
	RETURN
ENDIF

ENDPROC
PROCEDURE grabar
BEGIN TRANSACTION 
Thisform.transOk = .T.

Thisform.Set_Save_Commands()

IF !Thisform.transOK
	ROLLBACK
	MESSAGEBOX("Ha ocurrido un error al intentar grabar los datos", 0+48, "Error de transacción")
	RETURN .F.
ENDIF

END TRANSACTION 
MESSAGEBOX("Los datos han sido grabado satisfactoriamente", 0+48, Thisform.lblCaption.Caption)

ENDPROC


************************************************************
OBJETO: lblCaption
************************************************************
*** PROPIEDADES ***
FontUnderline = .F.
BackStyle = 1
Caption = "FormIngresos"
Height = 15
Left = 6
Top = 4
Width = 174
ForeColor = 255,255,255
BackColor = 0,64,128
Name = "lblCaption"

*** METODOS ***


************************************************************
OBJETO: Clslinea2
************************************************************
*** PROPIEDADES ***
Height = 0
Left = 19
Top = 115
Width = 900
Name = "Clslinea2"

*** METODOS ***


************************************************************
OBJETO: Clslinea3
************************************************************
*** PROPIEDADES ***
Height = 0
Left = 20
Top = 434
Width = 900
Name = "Clslinea3"

*** METODOS ***


************************************************************
OBJETO: Clslinea4
************************************************************
*** PROPIEDADES ***
Height = 0
Left = 21
Top = 517
Width = 900
Name = "Clslinea4"

*** METODOS ***


************************************************************
OBJETO: grdDetalle
************************************************************
*** PROPIEDADES ***
Height = 224
Left = 19
Top = 207
Width = 900
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
OBJETO: Clslinea5
************************************************************
*** PROPIEDADES ***
Height = 0
Left = 20
Top = 204
Width = 900
Name = "Clslinea5"

*** METODOS ***


************************************************************
OBJETO: cmdGrabar
************************************************************
*** PROPIEDADES ***
Top = 525
Left = 840
Height = 34
Width = 41
ToolTipText = "Grabar"
Name = "cmdGrabar"

*** METODOS ***


************************************************************
OBJETO: cnt_cabecera
************************************************************
*** PROPIEDADES ***
Top = 20
Left = 18
Width = 900
Height = 90
BackColor = 221,224,209
Name = "cnt_cabecera"

*** METODOS ***


************************************************************
OBJETO: cmdAceptar
************************************************************
*** PROPIEDADES ***
Top = 52
Left = 816
Height = 35
Width = 40
ToolTipText = "Aceptar"
Name = "cmdAceptar"

*** METODOS ***


************************************************************
OBJETO: cmdCancelar
************************************************************
*** PROPIEDADES ***
Top = 52
Left = 859
Height = 35
Width = 38
ToolTipText = "Cancelar"
Name = "cmdCancelar"

*** METODOS ***


************************************************************
OBJETO: cntDetalle
************************************************************
*** PROPIEDADES ***
Top = 119
Left = 19
Width = 899
Height = 81
BackColor = 221,224,209
Name = "cntDetalle"

*** METODOS ***


************************************************************
OBJETO: cmdAgregar
************************************************************
*** PROPIEDADES ***
OLEDropMode = 1
Top = 42
Left = 855
Height = 36
Width = 41
Picture = ..\imagen\symbol-add.ico
ToolTipText = "Agregar"
Name = "cmdAgregar"

*** METODOS ***


************************************************************
OBJETO: formingresos
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: formlogin
************************************************************
*** PROPIEDADES ***
Height = 142
Width = 334
DoCreate = .T.
BorderStyle = 0
Caption = "Identificarse"
TitleBar = 0
WindowType = 1
isaccept = .F.
currentuser = 
Name = "formlogin"
contenido.Top = 3
contenido.Left = 3
contenido.Width = 327
contenido.Height = 136
contenido.BackColor = 241,236,235
contenido.Name = "contenido"

*** METODOS ***


************************************************************
OBJETO: CLSETIQUETA1
************************************************************
*** PROPIEDADES ***
Caption = "Usuario:"
Left = 24
Top = 32
TabIndex = 5
Name = "CLSETIQUETA1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Password:"
Left = 24
Top = 55
TabIndex = 6
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: txtUsuario
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 120
TabIndex = 1
Top = 28
Width = 179
Name = "txtUsuario"

*** METODOS ***


************************************************************
OBJETO: txtPassword
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 120
TabIndex = 2
Top = 51
Width = 179
PasswordChar = "?"
ischaracter = .T.
Name = "txtPassword"

*** METODOS ***


************************************************************
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 82
Left = 170
Height = 44
Width = 45
Picture = ..\imagen\iconos bajados\salir-de-mi-perfil-icono-3964.ico
TabIndex = 4
Name = "btnCerrar"

*** METODOS ***
PROCEDURE Click
Thisform.IsAccept = .F.
Thisform.Hide()
ENDPROC


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "IDENTIFIQUESE"
Height = 15
Left = 5
Top = 4
Width = 148
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clslinea1
************************************************************
*** PROPIEDADES ***
Height = 0
Left = 4
Top = 20
Width = 317
BorderColor = 128,64,0
Name = "Clslinea1"

*** METODOS ***


************************************************************
OBJETO: btnlogin
************************************************************
*** PROPIEDADES ***
Top = 82
Left = 119
TabIndex = 3
Name = "btnlogin"

*** METODOS ***
PROCEDURE Click
LOCAL lcUsuario, lcClave
LOCAL rsUser, lcSql

rsUser = CREATEOBJECT("odbc_result")
lcSql = ""

WITH Thisform.contenido
	IF ALLTRIM(.txtUsuario.Value) == ""
		MESSAGEBOX("Debe ingresar el usuario", 0+48, Thisform.Caption)
		.txtUsuario.SetFocus
		RETURN .F.
	ENDIF
	
	IF ALLTRIM(.txtPassword.Value) == ""
		MESSAGEBOX("Debe ingresar la clave", 0+48, Thisform.Caption)
		.txtPassword.SetFocus()
		RETURN .F.
	ENDIF
	
	lcUsuario = .txtUsuario.Value
	lcClave = .txtPassword.Value
ENDWITH

lcSql = "select idUsuario, CodUsu, Password, habilitado from usuarios where CodUsu = '" + ALLTRIM(lcUsuario) + "'"
rsUser.ActiveConnection = goConn.ActiveConnection
rsUser.Cursor_Name = "cur_User"

IF !rsUser.OpenQuery(lcSql) THEN
	MESSAGEBOX(rsUser.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_User
IF RECCOUNT("cur_User") = 0
	MESSAGEBOX("Usuario incorrecto", 0+48, Thisform.Caption)
	rsUser.close_query()
	Thisform.Contenido.txtUsuario.SetFocus()
	RETURN .F.
ELSE
	IF !cur_User.habilitado THEN
		MESSAGEBOX("Este usuario no se encuentra habilitado", 0+48, Thisform.Caption)
		rsUser.close_query()
		thisform.contenido.txtUsuario.SetFocus()
		RETURN .F.
	ENDIF

	SET EXACT ON
	
	IF ALLTRIM(Thisform.Contenido.txtPassword.Value) != ALLTRIM(cur_User.Password)
		rsUser.close_query()
		MESSAGEBOX("Clave incorrecta", 0+48, Thisform.Caption)
		RETURN .F.
	ENDIF
	
	SET EXACT OFF
ENDIF

Thisform.IsAccept = .T.
gnUserID = cur_User.idUsuario
gcCodUsu = cur_User.CodUsu

rsUser.close_query()
Thisform.Hide()

RETURN .T.
ENDPROC


************************************************************
OBJETO: formlogin
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: frmmain
************************************************************
*** PROPIEDADES ***
BorderStyle = 1
Top = 0
Left = 0
Height = 524
Width = 250
Desktop = .F.
DoCreate = .T.
ShowTips = .T.
AutoCenter = .F.
Picture = ..\..\siscom_der\
Caption = "MENU PRINCIPAL"
MaxButton = .T.
MDIForm = .F.
Visible = .T.
FillStyle = 0
TitleBar = 0
ColorSource = 4
BackColor = 255,255,255
FillColor = 255,255,255
Dockable = 1
odata = 
Name = "frmmain"

*** METODOS ***
PROCEDURE Init
LOCAL loNewNode, lcSql, li_IDX, ll_Ok
DIMENSION laCodMenues[1]

this.tvwMenu.ImageList = thisform.img
this.tvwMenu.fullRowSelect = .T.
this.tvwMenu.hotTracking = .T.

this.odata.ActiveConnection = goConn.ActiveConnection
this.odata.cursor_name = "cur_Menu"

lcSql = "SELECT  menues.* "
lcSql = lcSql + "FROM    menues, accesos  "
lcSql = lcSql + "WHERE   menues.idMenue = accesos.idMenue "
lcSql = lcSql + "    AND menues.IsChild = 0 "
lcSql = lcSql + "    AND accesos.idUsuario = " + ALLTRIM(STR(gnUserID))
    
this.odata.OpenQuery(lcSql)

SELECT cur_Menu

IF RECCOUNT() > 0
	GO TOP
ENDIF

li_IDX = 1
SELECT cur_Menu
DO WHILE !EOF("cur_Menu")
	DIMENSION laCodMenues[li_IDX]
	laCodMenues[li_IDX] = cur_menu.CodMenu
	loNewNode = Thisform.tvwMenu.Nodes.Add(,,"E"+ALLTRIM(STR(cur_menu.Enlace)), ALLTRIM(cur_Menu.Nombre), 1, 2)
	
	li_IDX = li_IDX + 1
	
	SELECT cur_Menu
	SKIP
ENDDO

IF li_IDX = 1 .AND. !laCodMenues[li_IDX] 
	laCodMenues[1] = ""
ENDIF

USE IN cur_Menu

lcSql = "SELECT  menues.* "
lcSql = lcSql + "FROM    menues, accesos  "
lcSql = lcSql + "WHERE   menues.idMenue = accesos.idMenue "
lcSql = lcSql + "    AND menues.IsChild = 1 "
lcSql = lcSql + "    AND accesos.idUsuario = " + ALLTRIM(STR(gnUserID))

this.odata.OpenQuery(lcSql)
SELECT cur_Menu
DO WHILE !EOF()
	ll_Ok = .F.
	FOR li_IDX = 1 TO ALEN(laCodMenues)
		*IF ALLTRIM(laCodMenues[li_IDX]) == ALLTRIM(GETWORDNUM(cur_Menu.Enlace, 1, "."))
		IF ALLTRIM(laCodMenues[li_IDX]) == ALLTRIM(STR(cur_Menu.Enlace))
			ll_Ok = .T.		
		ENDIF
	NEXT li_IDX	

	IF ll_Ok
		loNewNode = Thisform.tvwMenu.Nodes.Add("E"+ALLTRIM(STR(cur_Menu.Enlace)), 4, "M:"+ALLTRIM(cur_Menu.CodMenu), ALLTRIM(cur_Menu.Nombre), 3, 3)
	ENDIF

	SKIP
ENDDO

Thisform.Dock(1)
ENDPROC
PROCEDURE Load
this.odata = CREATEOBJECT("odbc_Result")
thisform.Dock(1)

ENDPROC


************************************************************
OBJETO: tvwMenu
************************************************************
*** PROPIEDADES ***
Top = 0
Left = 2
Height = 523
Width = 246
Visible = .T.
Anchor = 15
Name = "tvwMenu"

*** METODOS ***
PROCEDURE KeyPress
*** ActiveX Control Event ***
LPARAMETERS keyascii

LOCAL cKey, cCodMenu

IF keyascii == 13
	cKey = thisform.tvwMenu.selectedItem.Key
	cCodMenu = GETWORDNUM(cKey, 2, ":")

	SELECT cur_Menu
	LOCATE FOR ALLTRIM(CodMenu )== ALLTRIM(cCodMenu)
	
	IF FOUND()
		IF !EMPTY(cur_Menu.Procedim)
			DO FORM ALLTRIM(cur_Menu.Procedim)
		ENDIF
	ENDIF
ENDIF
ENDPROC
PROCEDURE Click
*** ActiveX Control Event ***

ENDPROC
PROCEDURE DblClick
*** ActiveX Control Event ***
cKey = thisform.tvwMenu.selectedItem.Key
cCodMenu = GETWORDNUM(cKey, 2, ":")

SELECT cur_Menu
LOCATE FOR ALLTRIM(CodMenu )== ALLTRIM(cCodMenu)

IF FOUND()
	IF !EMPTY(cur_Menu.Procedim)
		DO FORM ALLTRIM(cur_Menu.Procedim)
	ENDIF
ENDIF
ENDPROC


************************************************************
OBJETO: img
************************************************************
*** PROPIEDADES ***
Top = 240
Left = 156
Height = 150
Width = 200
Visible = .F.
Name = "img"

*** METODOS ***


************************************************************
OBJETO: frmmain
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: frm_consultas
************************************************************
*** PROPIEDADES ***
DataSession = 2
BorderStyle = 1
Height = 450
Width = 737
DoCreate = .T.
ShowTips = .T.
AutoCenter = .T.
Caption = "Consultas"
MaxButton = .F.
MinButton = .F.
TitleBar = 0
BackColor = 0,64,128
label_caption = .F.
nombre_campo_codigo = 
nombre_campo_desc = 
nombre_tabla = 
pkfield = 
Name = "frm_consultas"

*** METODOS ***
PROCEDURE Load
SetVars()
ENDPROC


************************************************************
OBJETO: Contenedor1
************************************************************
*** PROPIEDADES ***
Top = 5
Left = 4
Width = 728
Height = 441
Name = "Contenedor1"

*** METODOS ***


************************************************************
OBJETO: Etiqueta
************************************************************
*** PROPIEDADES ***
Caption = "Etiqueta:"
Height = 14
Left = 9
Top = 38
Width = 87
TabIndex = 8
Name = "Etiqueta"

*** METODOS ***


************************************************************
OBJETO: Selector
************************************************************
*** PROPIEDADES ***
Top = 32
Left = 134
Width = 535
Height = 24
TabIndex = 1
nombre_tabla = 
pkfield = 
nombre_campo_codigo = 
nombre_campo_desc = 
esnumerico = .T.
autocompletar_ceros = .F.
Name = "Selector"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Height = 21
txtDescripcion.Left = 106
txtDescripcion.Top = 2
txtDescripcion.Width = 429
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***
PROCEDURE txtCodigo.LostFocus
DODEFAULT()

ENDPROC


************************************************************
OBJETO: grd
************************************************************
*** PROPIEDADES ***
Height = 329
Left = 7
TabIndex = 5
Top = 68
Width = 720
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


************************************************************
OBJETO: btnImprimir
************************************************************
*** PROPIEDADES ***
Top = 406
Left = 640
Height = 35
Width = 39
Picture = ..\imagen\printer.ico
TabIndex = 6
ToolTipText = "Imprimir"
Name = "btnImprimir"

*** METODOS ***


************************************************************
OBJETO: Clscerrar1
************************************************************
*** PROPIEDADES ***
Top = 406
Left = 688
Height = 35
Width = 39
TabIndex = 7
ToolTipText = "Cerrar"
Name = "Clscerrar1"

*** METODOS ***


************************************************************
OBJETO: btnBuscar
************************************************************
*** PROPIEDADES ***
Top = 26
Left = 687
Height = 34
Width = 39
Picture = ..\imagen\find.ico
TabIndex = 4
ToolTipText = "Buscar"
Name = "btnBuscar"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
BackStyle = 1
Caption = "Consulta de Pendientes"
Height = 15
Left = 4
Top = 1
Width = 151
ForeColor = 255,255,255
BackColor = 0,64,128
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: frm_consultas
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: frm_ing_stock
************************************************************
*** PROPIEDADES ***
DataSession = 2
BorderStyle = 1
Height = 380
Width = 729
DoCreate = .T.
Comment = ""
ShowTips = .T.
AutoCenter = .T.
Caption = "|"
MaxButton = .F.
MinButton = .F.
TitleBar = 0
WindowType = 1
BackColor = 0,64,128
tms = 
Name = "frm_ing_stock"

*** METODOS ***
PROCEDURE Unload
USE IN stkcab
USE IN stkdet
USE IN tms
ENDPROC
PROCEDURE Load
SetVars()

abrir_tabla("StkCab")
abrir_tabla("StkDet")
abrir_tabla("tms")

CREATE CURSOR cur_Stock (	 ;
	id_stkcab		int		,;
	id_art			int		,;
	codart			c(20)	,;
	descripcio		c(60)	,;
	cantidad		float	,;
	unidades		float)
	
INDEX ON CodArt TAG CodArt ASCENDING
INDEX ON Descripcio TAG Descripcio ASCENDING

ENDPROC
PROCEDURE Init
thisform.grdStock.list_controlsource = "codart,descripcio,cantidad,unidades"
thisform.grdStock.lista_ancho_cols = "150,200,70,70"
thisform.grdStock.titulos_cabeceras = "Código,Descripción,Cant.,Unid."

SELECT cur_Stock
thisform.grdStock.alias_name = "cur_stock"
thisform.grdStock.generar_grid()

thisform.sel_Articulo.txtCodigo.value = ""
thisform.sel_Articulo.txtdescripcion.Value = ""
thisform.txtCantidad.Value = 0.00



ENDPROC
PROCEDURE Activate
IF Thisform.tms == "ENT"
	thisform.Caption = "Entrada de Stock"
ENDIF

IF Thisform.tms = "SAL"
	thisform.Caption = "Salida de Stock"
ENDIF

IF thisform.tms = "AJU"
	thisform.Caption = "Ajuste de Stock"
ENDIF

ENDPROC


************************************************************
OBJETO: Contenedor1
************************************************************
*** PROPIEDADES ***
Top = 3
Left = 4
Width = 722
Height = 373
Name = "Contenedor1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Artículo:"
Height = 15
Left = 25
Top = 25
Width = 120
TabIndex = 11
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Cantidad:"
Height = 15
Left = 25
Top = 51
Width = 120
TabIndex = 12
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: sel_Articulo
************************************************************
*** PROPIEDADES ***
Top = 21
Left = 146
Width = 574
Height = 25
TabIndex = 2
nombre_campo_codigo = codart
nombre_campo_desc = descripcio
autocompletar_ceros = .F.
nombre_tabla = articulos
pkfield = id_art
Name = "sel_Articulo"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Height = 21
txtDescripcion.Left = 106
txtDescripcion.Top = 2
txtDescripcion.Width = 463
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: txtCantidad
************************************************************
*** PROPIEDADES ***
Left = 148
TabIndex = 3
Top = 47
isnumeric = .T.
Name = "txtCantidad"

*** METODOS ***


************************************************************
OBJETO: btnCancelar
************************************************************
*** PROPIEDADES ***
Top = 325
Left = 634
Height = 39
Width = 40
TabIndex = 8
Name = "btnCancelar"

*** METODOS ***
PROCEDURE Click
Thisform.sel_articulo.blanquear()
Thisform.txtCantidad.blanquear()
SELECT cur_Stock
ZAP
ENDPROC


************************************************************
OBJETO: btnAceptar
************************************************************
*** PROPIEDADES ***
Top = 51
Left = 637
Height = 38
Width = 38
TabIndex = 4
Name = "btnAceptar"

*** METODOS ***
PROCEDURE Click
IF thisform.txtCantidad.Value = 0
	MESSAGEBOX("Debe ingresar la cantidad", 0+48, "Ingreso de Stock")
	thisform.txtCantidad.SetFocus()
	RETURN .F.
ENDIF

IF ALLTRIM(thisform.sel_Articulo.txtCodigo.Value) == ""
	MESSAGEBOX("Debe ingresar el código de artículo", 0+48, "Ingreso de Stock")
	thisform.sel_Articulo.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

SELECT cur_Stock
APPEND BLANK
REPLACE Id_Art	WITH thisform.sel_Articulo.valcpoid
REPLACE CodArt 	WITH thisform.sel_Articulo.txtCodigo.Value Additive
REPLACE Descripcio WITH thisform.sel_Articulo.txtDescripcion.Value Additive
REPLACE Cantidad WITH thisform.txtCantidad.Value Additive

thisform.grdStock.Refresh()

thisform.sel_Articulo.txtCodigo.value = ""
thisform.sel_Articulo.txtdescripcion.Value = ""
thisform.txtCantidad.Value = 0.00
thisform.sel_Articulo.SetFocus()

RETURN .T.
ENDPROC


************************************************************
OBJETO: grdStock
************************************************************
*** PROPIEDADES ***
Height = 224
Left = 20
TabIndex = 6
Top = 92
Width = 696
Name = "grdStock"
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
Top = 325
Left = 590
Height = 39
Width = 41
TabIndex = 7
Name = "btnGrabar"

*** METODOS ***
PROCEDURE Click
&& Al grabar los movimientos

LOCAL lb_Ok, ln_IdStkCab, ln_IdStkDet, ln_IdTMS, ln_Cant, lnIdArt, lnCantidad, ldFecAlta, lcCodTMS

lb_Ok = .T.
ln_IdStkCab = 0
ln_IdStkDet = 0
ln_IdTMS = 0
ln_Cant = 0
ldFecAlta = DATETIME()
lcCodTMS = Thisform.tms


SELECT * FROM TMS WHERE Cod_Tms = Thisform.TMS INTO CURSOR cur_tms
SELECT cur_tms
IF RECCOUNT() > 0
	ln_IdTMS = cur_tms.Id_TMS
ELSE
	MESSAGEBOX("No se encuentra cargado el tipo de movimiento", 0+16, "Ingreso de Stock")
	RETURN .F.
ENDIF

IF CURSORGETPROP("Buffering", "StkCab") <> 3
	CURSORSETPROP("Buffering", 3, "StkCab")
ENDIF

IF CURSORGETPROP("Buffering", "StkDet") <> 3
	CURSORSETPROP("Buffering", 3, "StkDet")
ENDIF

BEGIN TRANSACTION 
lb_Ok = .T.

ln_IdStkCab = Calcular_Proximo_Id("StkCab", "Id_StkCab")

INSERT INTO StkCab (Id_StkCab, Id_Tms, Cod_Tms, FecAlta) ;
VALUES (ln_IdStkCab, ln_IdTMS, lcCodTMS, DATETIME())

lb_Ok = TABLEUPDATE(1, .T., "StkCab")

SELECT cur_Stock
IF RECCOUNT() > 0
	GO TOP
ENDIF

DO WHILE !EOF()
	ln_IdStkDet = Calcular_Proximo_Id("StkDet", "Id_StkDet")
	
	IF lb_Ok
		lnIdArt = cur_Stock.Id_Art
		lnCantidad = cur_Stock.Cantidad
		
		IF thisform.tms = "ENT"
			INSERT INTO StkDet (Id_StkDet, Id_StkCab, Id_Art, Cantidad, Unidades, FecAlta)	 ;
			VALUES (ln_IdStkDet, ln_IdStkCab, lnIdArt, lnCantidad, 0, ldFecAlta)
		ENDIF
		
		IF thisform.tms = "SAL"		
			INSERT INTO StkDet (Id_StkDet, Id_StkCab, Id_Art, Cantidad, Unidades, FecAlta)	 ;
			VALUES (ln_IdStkDet, ln_IdStkCab, lnIdArt, lnCantidad * -1, 0, ldFecAlta)
		ENDIF
		
		IF thisform.tms = "AJU"
			SELECT	SUM(Cantidad) AS Total 		;
			FROM	StkDet						;
			WHERE	Id_Art = cur_Stock.Id_Art 	;
			INTO CURSOR cur_Total
			
			SELECT cur_Total
			ln_Cant = cur_Total.Total
			USE IN cur_Total
			
			INSERT INTO StkDet (Id_StkDet, Id_StkCab, Id_Art, Cantidad, Unidades, FecAlta)	 ;
			VALUES (ln_IdStkDet, ln_IdStkCab, lnIdArt, lnCantidad - ln_Cant, 0, ldFecAlta)			
		ENDIF
		
		lb_Ok = TABLEUPDATE(1, .T., "StkDet")
	ENDIF		
	
	SELECT cur_Stock
	SKIP
ENDDO

IF lb_Ok 
	END TRANSACTION 
	MESSAGEBOX("La transacción ha finalizado con éxito", 0+64, "Ingreso de Stock")
	
	CURSORSETPROP("Buffering", 1, "StkCab")
	CURSORSETPROP("Buffering", 1, "StkDet")
		
	SELECT cur_Stock
	ZAP
ELSE
	ROLLBACK
	MESSAGEBOX("Ha ocurrido un fallo en la transacción", 0+48, "Ingreso de Stock")

	CURSORSETPROP("Buffering", 1, "StkCab")
	CURSORSETPROP("Buffering", 1, "StkDet")

	RETURN .F.
ENDIF

RETURN .T.



ENDPROC


************************************************************
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 325
Left = 676
Height = 39
Width = 38
TabIndex = 9
Name = "btnCerrar"

*** METODOS ***


************************************************************
OBJETO: btnEliminar
************************************************************
*** PROPIEDADES ***
Top = 51
Left = 677
Height = 38
Width = 38
TabIndex = 5
Name = "btnEliminar"

*** METODOS ***
PROCEDURE Click
LOCAL ln_resp

ln_resp = MESSAGEBOX("Está seguro que desea eliminar el ítem", 4+32, "Ingreso de Stock")

IF ln_resp = 6
	SELECT cur_Stock
	DELETE
	thisform.grdStock.Refresh()
ENDIF

ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
BackStyle = 1
Caption = "Ingreso de Stock"
Height = 15
Left = 4
Top = 4
Width = 136
ForeColor = 255,255,255
BackColor = 0,64,128
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: frm_ing_stock
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: modal_formbase
************************************************************
*** PROPIEDADES ***
DataSession = 2
BorderStyle = 2
Height = 189
Width = 533
DoCreate = .T.
ShowTips = .T.
AutoCenter = .T.
Caption = "Modal Form Base"
FontSize = 8
MaxButton = .F.
MinButton = .F.
Icon = ..\imagen\application_32x32.ico
WindowType = 1
BackColor = 255,255,255
Name = "modal_formbase"

*** METODOS ***
PROCEDURE conectar_db
LOCAL lcConnectionString
lcConnectionString = getConfig("ODBC_CONN")
goConn = CREATEOBJECT("odbc_connect")
goConn.ConnectionString = alltrim(lcConnectionString )

IF !goConn.Open()
	MESSAGEBOX(goConn.ErrorMessage, 1+16, "Database Connection")
	RETURN .F.
ENDIF
RETURN .T.
ENDPROC
PROCEDURE verificar_conexion_db
LOCAL result

result = SQLEXEC(goConn.ActiveConnection, "SELECT 1", "cur_test")
IF result = -1 THEN
	=Thisform.conectar_db()
ENDIF
ENDPROC
PROCEDURE MouseWheel
LPARAMETERS nDirection, nShift, nXCoord, nYCoord

ENDPROC
PROCEDURE Activate
thisform.verificar_conexion_db()
ENDPROC
PROCEDURE Load
&& Seteo las variables de session

SET TALK OFF
SET DATE FRENCH
SET CENTURY ON
SET SAFETY OFF
SET NOTIFY OFF
SET EXCLUSIVE OFF
SET DATE FRENCH
SET MULTILOCKS ON
SET DELETED ON
SET ENGINEBEHAVIOR 90

thisform.verificar_conexion_db()
ENDPROC
PROCEDURE MouseMove
LPARAMETERS nButton, nShift, nXCoord, nYCoord

ENDPROC


************************************************************
OBJETO: modal_formbase
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: formbase
************************************************************
*** PROPIEDADES ***
DataSession = 2
BorderStyle = 3
Height = 571
Width = 946
DoCreate = .T.
ShowTips = .T.
AutoCenter = .T.
Caption = "Formulario Base"
MaxButton = .F.
MinButton = .F.
Icon = ..\imagen\application_32x32.ico
TitleBar = 1
BackColor = 221,217,217
esnuevo = .F.
index_currow = 
Name = "formbase"

*** METODOS ***
PROCEDURE conectardb
LOCAL lcConnectionString
lcConnectionString = getConfig("ODBC_CONN")
goConn = CREATEOBJECT("odbc_connect")
goConn.ConnectionString = alltrim(lcConnectionString )

IF !goConn.Open()
	MESSAGEBOX(goConn.ErrorMessage, 1+16, "Database Connection")
	RETURN .F.
ENDIF

RETURN .T.
ENDPROC
PROCEDURE verificar_conexion_db
LOCAL result

result = SQLEXEC(goConn.ActiveConnection, "SELECT 1", "cur_test")
IF result = -1 THEN
	=Thisform.conectardb()
ENDIF
ENDPROC
PROCEDURE MouseWheel
LPARAMETERS nDirection, nShift, nXCoord, nYCoord

ENDPROC
PROCEDURE Activate
thisform.verificar_conexion_db()
ENDPROC
PROCEDURE Load
SET TALK OFF
SET DATE FRENCH
SET CENTURY ON
SET SAFETY OFF
SET NOTIFY OFF
SET EXCLUSIVE OFF
SET DATE FRENCH
SET MULTILOCKS ON
SET DELETED ON
SET ENGINEBEHAVIOR 90

Thisform.verificar_conexion_db()
ENDPROC
PROCEDURE MouseMove
LPARAMETERS nButton, nShift, nXCoord, nYCoord

ENDPROC


************************************************************
OBJETO: contenido
************************************************************
*** PROPIEDADES ***
Anchor = 15
Top = -1
Left = -1
Width = 948
Height = 574
BackColor = 241,236,235
Name = "contenido"

*** METODOS ***


************************************************************
OBJETO: formbase
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_form_nuevo_x
************************************************************
*** PROPIEDADES ***
DoCreate = .T.
Caption = "Nuevo"
WindowState = 0
c_tabla = 
c_fkfield = 
c_descripcio_field = 
registro_nuevo_ok = .F.
Name = "cls_form_nuevo_x"

*** METODOS ***
PROCEDURE grabar
LOCAL loCmd
LOCAL lnProxId

loCmd = CREATEOBJECT("odbc_command")
lnProxId = goConn.GetNextId(This.c_tabla, This.c_fkfield)
TEXT TO loCmd.CommandText NOSHOW
	INSERT INTO _tableName (
		_pkField,
		_descripcionField,
		usuAlta,
		fecAlta,
		idHostAlta)
	VALUES (
		?pProxID,
		?pDescripcion,
		?pUsuAlta,
		current_timestamp,
		?pIdHostAlta);
ENDTEXT
loCmd.CommandText = STRTRAN(loCmd.CommandText, "_tableName", This.c_tabla)
loCmd.CommandText = STRTRAN(loCmd.CommandText, "_pkField", This.c_fkfield)
loCmd.CommandText = STRTRAN(loCmd.CommandText, "_descripcionField", This.c_descripcio_field)

loCmd.AddParameter("pProxID", ALLTRIM(STR(lnProxId)), .f., .f.)
loCmd.AddParameter("pDescripcion", ALLTRIM(This.txtDescripcion.Value), .t., .f.)
loCmd.AddParameter("pUsuAlta", ALLTRIM(gcCodusu), .t., .f.)
loCmd.AddParameter("pIdHostAlta", ALLTRIM(SYS(0)), .t., .f.)
loCmd.ActiveConnection = goConn.ActiveConnection
IF !loCmd.Execute() THEN
	MESSAGEBOX(loCmd.ErrorMessage, 0+64, Thisform.Caption)
	RETURN
ENDIF

MESSAGEBOX("Registro grabado con éxito", 0+64, Thisform.Caption)

ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Descripción:"
Left = 12
Top = 24
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: txtDescripcion
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 93
Top = 20
Width = 387
Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: btnGrabar
************************************************************
*** PROPIEDADES ***
Top = 120
Left = 208
Name = "btnGrabar"

*** METODOS ***
PROCEDURE Click
IF ALLTRIM(Thisform.txtDescripcion.Value) == "" THEN
	MESSAGEBOX("Debe ingresar la descripción", 0+48, Thisform.Caption)
	Thisform.txtDescripcion.SetFocus()
	RETURN
ENDIF

Thisform.grabar()
Thisform.registro_nuevo_ok = .t.
Thisform.hide()
ENDPROC


************************************************************
OBJETO: btnCancelar
************************************************************
*** PROPIEDADES ***
Top = 120
Left = 256
Name = "btnCancelar"

*** METODOS ***
PROCEDURE Click
Thisform.registro_nuevo_ok = .f.
Thisform.hide()
ENDPROC


************************************************************
OBJETO: cls_form_nuevo_x
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: formabm
************************************************************
*** PROPIEDADES ***
BorderStyle = 1
Height = 438
Width = 817
DoCreate = .T.
ShowTips = .T.
AutoCenter = .T.
Caption = "ABM Formulario"
Closable = .F.
MinButton = .T.
Visible = .T.
TitleBar = 1
WindowType = 0
WindowState = 0
cnombretabla = 
lnuevo = .F.
titulos_cabeceras = 
listctrlsource = 
listwidthcols = 
nultposgrid = -1
msgerror = 
ltransok = .F.
pk_fieldname = 
pk_identity = .T.
autogencodigo = .T.
ncodigo = 0
currentid = 0
getall_command = 
object_dataservice = 
obj_dataservicename = datObject
datos_ok = .F.
Name = "formabm"

*** METODOS ***
PROCEDURE blanquear
&& Permite blanquear los controles que corresponde al cuadro 
&& de edición

WITH Thisform.Pgf.Page2.cnt_fields
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
PROCEDURE cambiarestado
&& Permite cambiar de estado de los controles segun
&& la situación del ABM

LPARAMETERS tl_Estado

WITH Thisform.Pgf.Page2.cnt_fields
	FOR EACH ctrl IN .Controls
		ctrl.Enabled = IIF(ALLTRIM(ctrl.Tag)=="no_edit", tl_Estado, !tl_Estado)
	ENDFOR
ENDWITH

WITH Thisform
	.Herramientas.Cambiar_Estado(tl_Estado)
ENDWITH


ENDPROC
PROCEDURE refrescargrilla
WITH Thisform	
	IF USED("cur_Tempo")
		SELECT cur_Tempo
		IF RECCOUNT() > 0 .AND. RECNO() <= RECCOUNT()
			.nUltPosGrid = RECNO("cur_Tempo")
		ELSE
			.nUltPosGrid = 0
		ENDIF
	ELSE
		.nUltPosGrid = 1
	ENDIF
		
	.CrearCursor()
	.ConfigurarGrilla()

	&& Valido que la tabla tenga contenido para poder posicionar
	&& la ultima ubicación en el grid.
	
	SELECT cur_Tempo
	IF RECCOUNT() > 0
		IF .nUltPosGrid <> 0
			SELECT cur_Tempo
			GO .nUltPosGrid
		ENDIF
	ENDIF
ENDWITH
ENDPROC
PROCEDURE validardatos
LOCAL llReturn

Thisform.MsgError = ""

WITH Thisform.Pgf.Page2.cnt_fields
	FOR EACH ctrl IN .Controls
		IF 	LOWER(ALLTRIM(ctrl.BaseClass)) == "textbox" 	.Or.	;
			LOWER(ALLTRIM(ctrl.BaseClass)) == "combobox"	.Or.	;
			(LOWER(ALLTRIM(ctrl.BaseClass)) == "container" .And. LOWER(ALLTRIM(ctrl.Tag)) == "edit")
					
			IF ctrl.Requerido .AND. ctrl.EstaVacio() THEN
				Thisform.MsgError = ctrl.MsgError
				RETURN .F.
			ENDIF
		ENDIF
	ENDFOR
ENDWITH

RETURN .T.
ENDPROC
PROCEDURE recuperardatos
LOCAL lcReferencia, lnCont, lcFieldName, loData, lcSql
DIMENSION laCampos[1]

SELECT cur_Tempo
loData = CREATEOBJECT("odbc_Result")
lcReferencia = "cur_Tempo." + ALLTRIM(thisform.pk_fieldname)
lcSql = "select * from " + thisform.cnombretabla + " where " + thisform.pk_fieldname + " = " + ALLTRIM(STR(&lcReferencia))
loData.ActiveConnection = goConn.ActiveConnection
loData.Cursor_Name ="cur_Tempo2"

IF loData.OpenQuery(lcSql) THEN
	SELECT cur_Tempo2
	WITH Thisform.Pgf.Page2.cnt_fields
		lnCont = AFIELDS(laCampos)
		
		FOR i = 1 TO lnCont
			FOR EACH ctrl IN .Controls
				lcFieldName = laCampos[i, 1]
				lcReferencia = "cur_Tempo2." + ALLTRIM(lcFieldName)

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

	loData.close_query()
ENDIF
ENDPROC
PROCEDURE configurargrilla
LOCAL lcTitulos, lcCtrlSource, lcAncho, lcAliasName

&& Levanto los parámetros
WITH Thisform
	.Herramientas.cambiar_estado(.T.)
	.lNuevo = .T.
	lcTitulos = .Titulos_Cabeceras
	lcCtrlSource = .ListCtrlSource
	lcAncho = .ListWidthCols
ENDWITH

&& Seteo las propiedades de la grilla y vinculo
&& los datos
WITH Thisform.Pgf.Page1.grdDatos
	SELECT (Thisform.object_dataservice.nombre_cursor)

	.Alias_Name = Thisform.object_dataservice.nombre_cursor
	.RecordSource = Thisform.object_dataservice.nombre_cursor
	.Titulos_Cabeceras = lcTitulos
	.List_ControlSource = lcCtrlSource
	.Lista_Ancho_Cols = lcAncho
	.Generar_Grid()
	.Refresh()
ENDWITH
ENDPROC
PROCEDURE crearcursor
&& Cada vez que creo el cursor verifico si el alias está siendo utilizado
&& si está siendo utilizado, entonces, limpio el recordsource de la grilla
&& y cierro el cursor que se está utilizando actualmente.

IF USED("cur_Tempo")
	Thisform.Pgf.Page1.grdDatos.RecordSource = ''
	USE IN cur_Tempo
ENDIF
ENDPROC
PROCEDURE set_insert_cmd
LPARAMETERS tn_ProxId
ENDPROC
PROCEDURE llenarcbos
LPARAMETERS tc_CtrlName, tcRowSource, lcAliasName

LOCAL lcRef

lcRef = "Thisform.Pgf.Page2.Cnt_Fields." + tc_CtrlName

SELECT (lcAliasName)
IF RECCOUNT() > 0
	WITH &lcRef
		.BoundColumn = 2
		.BoundTo = .T.
		.RowSource = tcRowSource
		.RowSourceType = 6
	ENDWITH
ENDIF
ENDPROC
PROCEDURE actualizar_cursor
&& Este procedimiento permite actualizar el cursor para refrescar la interfaz de usuario

LOCAL i, cRef, cBaseClass, cObj

SELECT (Thisform.object_dataservice.nombre_cursor)

IF thisform.lnuevo
	APPEND BLANK
	
	cObj = "Thisform.object_dataservice." + (Thisform.pk_fieldname)
	cRef = Thisform.object_dataservice.nombre_cursor + "." + ALLTRIM(Thisform.pk_fieldname)
	REPLACE (cRef) WITH &cObj
ELSE
	LOCK()
ENDIF

FOR i = 1 TO Thisform.Pgf.page2.cnt_fields.ControlCount
	cBaseClass = LOWER(ALLTRIM(Thisform.Pgf.Page2.cnt_fields.Controls[i].BaseClass))
	
	IF ALLTRIM(cBaseClass) == "textbox" .OR. ALLTRIM(cBaseClass) == "editbox" .OR. ALLTRIM(cBaseClass) == "selector_tabla"
		

		cRef = "cur_Tempo." + ALLTRIM(Thisform.Pgf.page2.cnt_fields.Controls[i].cFieldName)
		
		IF i = 1 
			IF Thisform.lnuevo
				REPLACE (cRef) WITH Thisform.Pgf.Page2.cnt_fields.Controls[i].Value
			ENDIF
		ENDIF
		
		IF ALLTRIM(Thisform.Pgf.page2.cnt_fields.Controls[i].Tag) == "edit"
			IF !ISNULL(Thisform.Pgf.Page2.cnt_fields.Controls[i].Value) THEN
				REPLACE (cRef) WITH Thisform.Pgf.Page2.cnt_fields.Controls[i].Value ADDITIVE
			ENDIF
		ENDIF
	ENDIF
	
	IF ALLTRIM(cBaseClass) == "checkbox"
		cRef = "cur_Tempo." + ALLTRIM(Thisform.Pgf.page2.cnt_fields.Controls[i].cFieldName)
		
		IF ALLTRIM(Thisform.Pgf.Page2.cnt_fields.Controls[i].Tag)  == "edit"
			IF TYPE("Thisform.Pgf.page2.cnt_fields.Controls[i].value") $ "L"
				IF Thisform.Pgf.Page2.cnt_fields.Controls[i].Value
					REPLACE (cRef) WITH .T. ADDITIVE
				ELSE
					REPLACE (cRef) WITH .F. ADDITIVE
				ENDIF
			ELSE
				IF Thisform.Pgf.Page2.cnt_fields.Controls[i].Value = 1
					REPLACE (cRef) WITH .T. ADDITIVE
				ELSE
					REPLACE (cRef) WITH .F. ADDITIVE
				ENDIF
			ENDIF
		ENDIF
	ENDIF
NEXT i

UNLOCK

Thisform.Pgf.Page1.grdDatos.Refresh()

ENDPROC
PROCEDURE asignarcampos
&& Permite recorrer los controles de edición y asignarlo a la
&& propiedad que corresponda

LOCAL i, cRef, cBaseClass

i = 0
cRef = ""
cBaseClass = ""

FOR i = 1 TO Thisform.Pgf.page2.cnt_fields.ControlCount
	cBaseClass = LOWER(ALLTRIM(Thisform.Pgf.Page2.cnt_fields.Controls[i].BaseClass))
	
	IF ALLTRIM(cBaseClass) == "textbox" .OR. ALLTRIM(cBaseClass) == "editbox" .OR. ;
			ALLTRIM(cBaseClass) == "combobox"
		
		IF ALLTRIM(thisform.Pgf.Page2.cnt_fields.Controls[i].Tag) == "edit"		
			cRef = "Thisform.Object_DataService." + ALLTRIM(Thisform.Pgf.page2.cnt_fields.Controls[i].cFieldName)
			&cRef = Thisform.Pgf.page2.cnt_fields.Controls[i].value
		ENDIF
	ENDIF
	
	IF ALLTRIM(cBaseClass) == "checkbox" .AND. ALLTRIM(thisform.Pgf.Page2.cnt_fields.Controls[i].Tag) == "edit"
		cRef = "Thisform.Object_DataService." + ALLTRIM(Thisform.Pgf.page2.cnt_fields.Controls[i].cFieldName)
		IF TYPE("Thisform.Pgf.page2.cnt_fields.Controls[i].value") $ "L"
			IF Thisform.Pgf.page2.cnt_fields.Controls[i].value
				&cRef = 1
			ELSE
				&cRef = 0
			ENDIF
		ELSE
			IF Thisform.Pgf.page2.cnt_fields.Controls[i].value = 1
				&cRef = 1
			ELSE
				&cRef = 0
			ENDIF
		ENDIF
	ENDIF
	
	IF LOWER(ALLTRIM(cBaseClass)) == "container" .AND. ALLTRIM(thisform.Pgf.Page2.cnt_fields.Controls[i].Tag) == "edit"
		cRef = "Thisform.Object_DataService." + ALLTRIM(Thisform.Pgf.page2.cnt_fields.Controls[i].cFieldName)
		&cRef = Thisform.Pgf.page2.cnt_fields.Controls[i].ValCpoID
	ENDIF
ENDFOR
ENDPROC
PROCEDURE conectardb
LOCAL lcConnectionString
IF glError THEN
	lcConnectionString = getConfig("ODBC_CONN")
	goConn = CREATEOBJECT("odbc_connect")
	goConn.ConnectionString = alltrim(lcConnectionString )

	IF !goConn.Open()
		MESSAGEBOX(goConn.ErrorMessage, 1+16, "Database Connection")
		RETURN .F.
	ENDIF
ENDIF
ENDPROC
PROCEDURE Unload



ENDPROC
PROCEDURE Load
LOCAL lcAlias, i
DODEFAULT()



ENDPROC
PROCEDURE Init
thisform.object_dataservice = CREATEOBJECT(thisform.obj_dataservicename)
thisform.object_dataservice.cTableName = Thisform.cNombreTabla
thisform.object_dataservice.cPkFieldName = Thisform.Pk_FieldName
thisform.object_dataservice.initializate()
thisform.object_dataservice.getAll()
thisform.configurargrilla()

WITH Thisform
	&&.RefrescarGrilla()
	.Pgf.Page1.SetFocus()
	.recuperardatos()
	.CambiarEstado(.T.)
	.Pgf.Page1.grdDatos.SetFocus()
	.Pgf.Page2.enabled = .f.
ENDWITH

ENDPROC


************************************************************
OBJETO: Herramientas
************************************************************
*** PROPIEDADES ***
Top = 1
Left = 2
Width = 813
Height = 36
BackColor = 252,247,233
BorderColor = 255,128,0
autoassing = .T.
Name = "Herramientas"
cmdNuevo.Top = 1
cmdNuevo.Left = 6
cmdNuevo.Height = 34
cmdNuevo.Width = 40
cmdNuevo.Picture = ..\imagen\document.ico
cmdNuevo.ToolTipText = "Nuevo"
cmdNuevo.Name = "cmdNuevo"
cmdEditar.Top = 1
cmdEditar.Left = 46
cmdEditar.Height = 34
cmdEditar.Width = 40
cmdEditar.Picture = ..\imagen\edit.ico
cmdEditar.ToolTipText = "Modificar"
cmdEditar.Name = "cmdEditar"
cmdEliminar.Top = 1
cmdEliminar.Left = 86
cmdEliminar.Height = 34
cmdEliminar.Width = 40
cmdEliminar.ToolTipText = "Eliminar"
cmdEliminar.Name = "cmdEliminar"
cmdCerrar.Top = 1
cmdCerrar.Left = 764
cmdCerrar.Height = 34
cmdCerrar.Width = 40
cmdCerrar.ToolTipText = "Cerrar"
cmdCerrar.Name = "cmdCerrar"
cmdGrabar.Top = 1
cmdGrabar.Left = 126
cmdGrabar.Height = 34
cmdGrabar.Width = 40
cmdGrabar.ToolTipText = "Guardar"
cmdGrabar.Name = "cmdGrabar"
cmdCancelar.Top = 1
cmdCancelar.Left = 166
cmdCancelar.Height = 34
cmdCancelar.Width = 40
cmdCancelar.Picture = ..\imagen\iconos bajados\deshacer-icono-5403.ico
cmdCancelar.ToolTipText = "Cancelar"
cmdCancelar.Name = "cmdCancelar"
cmdExcel.Top = 1
cmdExcel.Left = 206
cmdExcel.Height = 34
cmdExcel.Picture = ..\imagen\iconos bajados\ncrow-mega-pack-1-excel.ico
cmdExcel.ToolTipText = "Exportar a Excel"
cmdExcel.Name = "cmdExcel"

*** METODOS ***
PROCEDURE grabar
PARAMETERS tl_AutoAssing 
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

Thisform.actualizar_cursor()
Thisform.CambiarEstado(.T.)
Thisform.Pgf.Page2.Enabled = .f.
Thisform.pgf.Page1.enabled = .T.
Thisform.Pgf.Page1.SetFocus()
Thisform.Pgf.Page1.grdDatos.SetFocus()

RETURN .T.
ENDPROC
PROCEDURE nuevo
WITH Thisform
	.Pgf.Page2.Enabled = .t.
	.Pgf.Page2.SetFocus()
	.pgf.Page1.enabled = .F.
	
	.lNuevo = .T.
	.CambiarEstado(.F.)	
	.Blanquear()
ENDWITH


ENDPROC
PROCEDURE modificar
WITH Thisform
	.Pgf.Page2.Enabled = .t.
	.Pgf.Page2.SetFocus()
	.pgf.Page1.enabled = .F.
	.lNuevo = .F.
	.RecuperarDatos()
	.CambiarEstado(.F.)
ENDWITH

ENDPROC
PROCEDURE cancelar
WITH Thisform
	.RecuperarDatos()
	.CambiarEstado(.T.)
	.pgf.Page1.Enabled = .T.
	.pgf.Page1.setfocus()
	.Pgf.Page1.grdDatos.SetFocus()
	.Pgf.Page2.Enabled = .f.
ENDWITH

ENDPROC
PROCEDURE eliminar
LOCAL lnResp, lcAlias, cRef, lcSql

IF !thisform.validar_eliminar()
	RETURN .F.
ENDIF

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
PROCEDURE excel
genexcel("cur_tempo","Listado")
ENDPROC


************************************************************
OBJETO: Pgf
************************************************************
*** PROPIEDADES ***
ErasePage = .T.
Top = 38
Left = 2
Width = 815
Height = 401
Name = "Pgf"
Page1.Caption = "Listado"
Page1.Name = "Page1"
Page2.Caption = "Datos"
Page2.Name = "Page2"

*** METODOS ***
PROCEDURE Page1.Activate
Thisform.Pgf.Page1.grdDatos.SetFocus()

ENDPROC


************************************************************
OBJETO: grdDatos
************************************************************
*** PROPIEDADES ***
Height = 366
Left = 2
Top = 3
Width = 808
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
PROCEDURE AfterRowColChange
LPARAMETERS nColIndex


ENDPROC
PROCEDURE press_enter
Thisform.recuperardatos()
Thisform.Pgf.Page1.Enabled = .f.
Thisform.Pgf.Page2.Enabled = .t.
*Thisform.Pgf.Page2.SetFocus()
Thisform.herramientas.modificar()
Thisform.Herramientas.cmdCancelar.Enabled = .t.
ENDPROC


************************************************************
OBJETO: cnt_fields
************************************************************
*** PROPIEDADES ***
Top = 7
Left = 9
Width = 794
Height = 355
BackColor = 241,236,235
Name = "cnt_fields"

*** METODOS ***


************************************************************
OBJETO: formabm
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


