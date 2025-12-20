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
OBJETO: FRMABMSUBFAMILIAS
************************************************************
*** PROPIEDADES ***
DoCreate = .T.
Caption = "ABM SubFamilias"
cnombretabla = subfam
listctrlsource = idsubfam,descripcio
listwidthcols = 70,300
obj_dataservicename = datObject
titulos_cabeceras = Código,Descripción
pk_fieldname = idsubfam
Name = "FRMABMSUBFAMILIAS"
Herramientas.cmdNuevo.Name = "cmdNuevo"
Herramientas.cmdEditar.Name = "cmdEditar"
Herramientas.cmdEliminar.Name = "cmdEliminar"
Herramientas.cmdCerrar.Name = "cmdCerrar"
Herramientas.cmdGrabar.Name = "cmdGrabar"
Herramientas.cmdCancelar.Name = "cmdCancelar"
Herramientas.autoassing = .T.
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
PROCEDURE validar_eliminar
LOCAL loResult, lcSql

lcSql = "select count(*) as cant from articulos where idSubFam = " + ALLTRIM(STR(cur_tempo.idSubFam))
loResult = CREATEOBJECT("odbc_result")
loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_x"
loResult.OpenQuery(lcSql)

SELECT cur_x

IF VAL(cur_x.cant) > 0
	MESSAGEBOX("No se puede eliminar la subfamilia porque tiene artículos vinculados", 0+64, Thisform.Caption)
	loResult.close_query()
	RETURN .F.
ENDIF

loResult.close_query()
RETURN .T.
ENDPROC


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Descripción:"
Left = 24
Top = 27
TabIndex = 2
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: txtDescripcion
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 117
MaxLength = 45
TabIndex = 1
Top = 23
Width = 507
cfieldname = descripcio
isinteger = .F.
ischaracter = .T.
msgerror = Debe ingresar la Descripción
Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: 
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 13, 11, 11, 2, 0
Arial, 0, 9, 5, 13, 11, 11, 2, 0
Arial, 1, 8, 6, 13, 11, 12, 2, 0

*** METODOS ***


