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
OBJETO: FRMABMMENU
************************************************************
*** PROPIEDADES ***
DoCreate = .T.
Comment = ""
Caption = "Configuración del menú del sistema"
listctrlsource = codMenu,nombre,procedim
listwidthcols = 100,300,200
pk_fieldname = idMenue
titulos_cabeceras = Código,Nombre,Formulario
cnombretabla = menues
Name = "FRMABMMENU"
HERRAMIENTAS.CMDNUEVO.Name = "CMDNUEVO"
HERRAMIENTAS.CMDEDITAR.Name = "CMDEDITAR"
HERRAMIENTAS.CMDELIMINAR.Name = "CMDELIMINAR"
HERRAMIENTAS.CMDCERRAR.Name = "CMDCERRAR"
HERRAMIENTAS.CMDGRABAR.Name = "CMDGRABAR"
HERRAMIENTAS.CMDCANCELAR.Name = "CMDCANCELAR"
HERRAMIENTAS.Name = "HERRAMIENTAS"
PGF.ErasePage = .T.
PGF.Page1.GRDDATOS.COLUMN1.Header1.Name = "Header1"
PGF.Page1.GRDDATOS.COLUMN1.Text1.Name = "Text1"
PGF.Page1.GRDDATOS.COLUMN1.Name = "COLUMN1"
PGF.Page1.GRDDATOS.COLUMN2.Header1.Name = "Header1"
PGF.Page1.GRDDATOS.COLUMN2.Text1.Name = "Text1"
PGF.Page1.GRDDATOS.COLUMN2.Name = "COLUMN2"
PGF.Page1.GRDDATOS.COLUMN3.Header1.Name = "Header1"
PGF.Page1.GRDDATOS.COLUMN3.Text1.Name = "Text1"
PGF.Page1.GRDDATOS.COLUMN3.Name = "COLUMN3"
PGF.Page1.GRDDATOS.COLUMN4.Header1.Name = "Header1"
PGF.Page1.GRDDATOS.COLUMN4.Text1.Name = "Text1"
PGF.Page1.GRDDATOS.COLUMN4.Name = "COLUMN4"
PGF.Page1.GRDDATOS.COLUMN5.Header1.Name = "Header1"
PGF.Page1.GRDDATOS.COLUMN5.Text1.Name = "Text1"
PGF.Page1.GRDDATOS.COLUMN5.Name = "COLUMN5"
PGF.Page1.GRDDATOS.COLUMN6.Header1.Name = "Header1"
PGF.Page1.GRDDATOS.COLUMN6.Text1.Name = "Text1"
PGF.Page1.GRDDATOS.COLUMN6.Name = "COLUMN6"
PGF.Page1.GRDDATOS.COLUMN7.Header1.Name = "Header1"
PGF.Page1.GRDDATOS.COLUMN7.Text1.Name = "Text1"
PGF.Page1.GRDDATOS.COLUMN7.Name = "COLUMN7"
PGF.Page1.GRDDATOS.COLUMN8.Header1.Name = "Header1"
PGF.Page1.GRDDATOS.COLUMN8.Text1.Name = "Text1"
PGF.Page1.GRDDATOS.COLUMN8.Name = "COLUMN8"
PGF.Page1.GRDDATOS.COLUMN9.Header1.Name = "Header1"
PGF.Page1.GRDDATOS.COLUMN9.Text1.Name = "Text1"
PGF.Page1.GRDDATOS.COLUMN9.Name = "COLUMN9"
PGF.Page1.GRDDATOS.COLUMN10.Header1.Name = "Header1"
PGF.Page1.GRDDATOS.COLUMN10.Text1.Name = "Text1"
PGF.Page1.GRDDATOS.COLUMN10.Name = "COLUMN10"
PGF.Page1.GRDDATOS.COLUMN11.Header1.Name = "Header1"
PGF.Page1.GRDDATOS.COLUMN11.Text1.Name = "Text1"
PGF.Page1.GRDDATOS.COLUMN11.Name = "COLUMN11"
PGF.Page1.GRDDATOS.COLUMN12.Header1.Name = "Header1"
PGF.Page1.GRDDATOS.COLUMN12.Text1.Name = "Text1"
PGF.Page1.GRDDATOS.COLUMN12.Name = "COLUMN12"
PGF.Page1.GRDDATOS.COLUMN13.Header1.Name = "Header1"
PGF.Page1.GRDDATOS.COLUMN13.Text1.Name = "Text1"
PGF.Page1.GRDDATOS.COLUMN13.Name = "COLUMN13"
PGF.Page1.GRDDATOS.COLUMN14.Header1.Name = "Header1"
PGF.Page1.GRDDATOS.COLUMN14.Text1.Name = "Text1"
PGF.Page1.GRDDATOS.COLUMN14.Name = "COLUMN14"
PGF.Page1.GRDDATOS.COLUMN15.Header1.Name = "Header1"
PGF.Page1.GRDDATOS.COLUMN15.Text1.Name = "Text1"
PGF.Page1.GRDDATOS.COLUMN15.Name = "COLUMN15"
PGF.Page1.GRDDATOS.COLUMN16.Header1.Name = "Header1"
PGF.Page1.GRDDATOS.COLUMN16.Text1.Name = "Text1"
PGF.Page1.GRDDATOS.COLUMN16.Name = "COLUMN16"
PGF.Page1.GRDDATOS.COLUMN17.Header1.Name = "Header1"
PGF.Page1.GRDDATOS.COLUMN17.Text1.Name = "Text1"
PGF.Page1.GRDDATOS.COLUMN17.Name = "COLUMN17"
PGF.Page1.GRDDATOS.COLUMN18.Header1.Name = "Header1"
PGF.Page1.GRDDATOS.COLUMN18.Text1.Name = "Text1"
PGF.Page1.GRDDATOS.COLUMN18.Name = "COLUMN18"
PGF.Page1.GRDDATOS.COLUMN19.Header1.Name = "Header1"
PGF.Page1.GRDDATOS.COLUMN19.Text1.Name = "Text1"
PGF.Page1.GRDDATOS.COLUMN19.Name = "COLUMN19"
PGF.Page1.GRDDATOS.COLUMN20.Header1.Name = "Header1"
PGF.Page1.GRDDATOS.COLUMN20.Text1.Name = "Text1"
PGF.Page1.GRDDATOS.COLUMN20.Name = "COLUMN20"
PGF.Page1.GRDDATOS.Name = "GRDDATOS"
PGF.Page1.Name = "Page1"
PGF.Page2.CNT_FIELDS.Name = "CNT_FIELDS"
PGF.Page2.Name = "Page2"
PGF.Name = "PGF"

*** METODOS ***
PROCEDURE Init
LOCAL lcSql, loResult

lcSql = ""
loResult = CREATEOBJECT("odbc_result")

DODEFAULT()

lcSql = "SELECT		enlace, "
lcSql = lcSql + "	nombre "
lcSql = lcSql + "FROM	menues "
lcSql = lcSql + "WHERE	isChild = 0"

loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_Enlaces"

IF !loResult.OpenQuery(lcSql) THEN
	MESSAGEBOX(loResult.Error_Message, 0+48, Thisform.Caption)
ELSE
	SELECT cur_Enlaces
	IF RECCOUNT("cur_Enlaces") > 0 THEN
		GO TOP
	ENDIF
	
	DO WHILE !EOF("cur_Enlaces")
		Thisform.Pgf.Page2.cnt_Fields.cmbEnlace.AddItem(cur_Enlaces.Nombre)
	
		SELECT cur_Enlaces
		SKIP
	ENDDO
ENDIF


ENDPROC
PROCEDURE recuperardatos
LOCAL lcSql, loResult

DODEFAULT()

loResult = CREATEOBJECT("odbc_result")
lcSql = "" 

lcSql = "SELECT * FROM forms WHERE codigo = '" + ALLTRIM(cur_Tempo.procedim) + "'"
loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_forms"
loResult.OpenQuery(lcSql)

SELECT cur_forms
IF RECCOUNT("cur_forms") > 0 THEN
	Thisform.Pgf.Page2.cnt_Fields.sel_form.txtCodigo.Value = cur_forms.codigo
	Thisform.Pgf.Page2.cnt_Fields.sel_form.txtDescripcion.Value = cur_forms.descripcio
	Thisform.Pgf.Page2.cnt_Fields.sel_form.valcpoid = cur_forms.idForm
ENDIF

loResult.Close_Query()

lcSql = "SELECT * FROM menues WHERE isChild = 0 AND enlace = " + ALLTRIM(STR(cur_Tempo.enlace))
loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_x"
loResult.OpenQuery(lcSql)

SELECT cur_x
IF RECCOUNT("cur_x") > 0 THEN
	Thisform.Pgf.Page2.Cnt_Fields.cmbEnlace.Value = cur_x.nombre
ENDIF

loResult.Close_Query()
ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Código:"
Left = 24
Top = 27
TabIndex = 7
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Nombre:"
Left = 24
Top = 51
TabIndex = 8
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Formulario:"
Left = 24
Top = 75
TabIndex = 3
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: txtCodigo
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 165
MaxLength = 20
TabIndex = 1
Top = 23
Width = 154
ischaracter = .T.
cfieldname = codMenu
msgerror = Debe ingresar el código del menú.
Name = "txtCodigo"

*** METODOS ***


************************************************************
OBJETO: txtDescripcion
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 165
MaxLength = 60
TabIndex = 2
Top = 47
Width = 478
cfieldname = nombre
ischaracter = .T.
msgerror = Debe ingresar el nombre del menú
Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: sel_form
************************************************************
*** PROPIEDADES ***
Top = 69
Left = 163
TabIndex = 4
autocompletar_ceros = .F.
nombre_campo_codigo = codigo
nombre_campo_desc = descripcio
nombre_tabla = forms
pkfield = idForm
msgerror = 
requerido = .F.
cfieldname = procedim
Name = "sel_form"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: cmbEnlace
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 165
TabIndex = 5
Top = 95
Width = 315
cfieldname = 
Name = "cmbEnlace"

*** METODOS ***
PROCEDURE InteractiveChange
SELECT cur_Enlaces
IF RECCOUNT("cur_Enlaces") > 0 THEN
	GO TOP
ENDIF

SKIP This.Parent.cmbEnlace.ListIndex
This.Parent.txtEnlace.Value = cur_Enlaces.enlace
ENDPROC


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Access Key:"
Left = 25
Top = 123
TabIndex = 9
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: txtAccessKey
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 165
MaxLength = 30
TabIndex = 6
Top = 119
Width = 178
cfieldname = acc_key
ischaracter = .T.
Name = "txtAccessKey"

*** METODOS ***


************************************************************
OBJETO: chkIsChild
************************************************************
*** PROPIEDADES ***
Top = 97
Left = 24
Height = 18
Width = 132
Alignment = 0
Caption = "Es hijo del enlace:"
Value = 0
TabIndex = 10
cfieldname = isChild
Name = "chkIsChild"

*** METODOS ***
PROCEDURE InteractiveChange
LOCAL lcSql, loResult

IF This.Value = .T. THEN
	This.Parent.cmbEnlace.Enabled = .T.
ELSE
	* En caso que no sea un menú hijo, entonces, significa que es un menú
	* principal, con lo que se debe generar un nuevo número de enlace
	lcSql = "SELECT MAX(enlace) as maxEnlace FROM menues"
	loResult = CREATEOBJECT("odbc_result")
	loResult.ActiveConnection = goConn.ActiveConnection
	loResult.Cursor_Name = "cur_maxE"
	loResult.OpenQuery(lcSql)
	
	This.Parent.txtEnlace.Value = cur_maxE.maxEnlace
	
	loResult.Close_Query()

	This.Parent.cmbEnlace.Enabled = .F.
ENDIF
ENDPROC


************************************************************
OBJETO: txtEnlace
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 483
Top = 95
Width = 81
isinteger = .T.
cfieldname = enlace
Name = "txtEnlace"

*** METODOS ***


************************************************************
OBJETO: 
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 13, 11, 11, 2, 0
Arial, 0, 9, 5, 13, 11, 11, 2, 0
Arial, 1, 8, 6, 13, 11, 12, 2, 0

*** METODOS ***


