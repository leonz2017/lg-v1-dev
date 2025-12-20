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
OBJETO: FRMPERMISOS
************************************************************
*** PROPIEDADES ***
Height = 475
Width = 946
DoCreate = .T.
BorderStyle = 2
Caption = "Configuración de Accesos"
Name = "FRMPERMISOS"
contenido.Top = -36
contenido.Left = 0
contenido.Width = 948
contenido.Height = 511
contenido.Name = "contenido"

*** METODOS ***
PROCEDURE grabar
LOCAL lnIdAcceso, lnIdUsuario, lnIdMenue
LOCAL loCommand, lcSql

lnIdAcceso = 0
lnIdUsuario = 0
lnIdMenue = 0
loCommand = CREATEOBJECT("odbc_Command")
lcSql = ""
lnIdUsuario = Thisform.Contenido.sel_usuario.valcpoid

SELECT cur_Menues
IF RECCOUNT() > 0
	GO TOP
ENDIF

goConn.BeginTransaction()
loCommand.ActiveConnection = goConn.ActiveConnection


&& Primero elimino todos los registros de accesos que tiene el usuario
&& seleccionado

lcSql = "delete from accesos where idUsuario = " + ALLTRIM(STR(lnIdUsuario))
loCommand.CommandText = lcSql
IF !loCommand.execute()
	goConn.RollBack()
	RETURN .F.
ENDIF

SELECT cur_Menues
DO WHILE !EOF()
	IF cur_Menues.sel
		lnIdAcceso = goConn.GetNextId("accesos", "idAcceso")
		lnIdMenue = cur_Menues.IdMenu
	
		lcSql = "INSERT INTO accesos (idAcceso, idUsuario, idMenue) "
		lcSql = lcSql + "VALUES (" + ALLTRIM(STR(lnIdAcceso)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnIdUsuario)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnIdMenue)) + ") "
		
		loCommand.CommandText = lcSql
		IF !loCommand.execute()
			goConn.RollBack()
			RETURN .F.
		ENDIF
	ENDIF

	SELECT cur_Menues
	SKIP
ENDDO

goConn.Commit()

RETURN .T.

ENDPROC
PROCEDURE Load
LOCAL rsMenu, lcSql, rsAccesos

DODEFAULT()

CREATE CURSOR cur_Menues ( ;
	sel		L			,;
	idMenu	int			,;
	CodMenu	varchar(20)	,;
	Nombre	varchar(60))
	
SELECT cur_Menues
INDEX ON sel TAG sel ASCENDING
INDEX ON idMenu TAG idMenu ASCENDING ADDITIVE
INDEX ON CodMenu TAG CodMenu ASCENDING ADDITIVE
INDEX ON Nombre TAG Nombre ASCENDING ADDITIVE

SET ORDER TO TAG CodMenu ASCENDING

lcSql = "select * from menues"
rsMenu = CREATEOBJECT("odbc_result")
rsMenu.ActiveConnection = goConn.ActiveConnection
rsMenu.Cursor_Name = "cur_x"
rsMenu.OpenQuery(lcSql)

SELECT cur_x
DO WHILE !EOF()
	SELECT cur_Menues
	APPEND BLANK
	REPLACE sel WITH .F.
	REPLACE idMenu WITH cur_x.idMenue ADDITIVE
	REPLACE CodMenu WITH cur_x.CodMenu ADDITIVE
	REPLACE Nombre WITH cur_x.Nombre ADDITIVE

	SELECT cur_x
	SKIP
ENDDO

rsMenu.close_query()

SELECT cur_Menues
IF RECCOUNT() > 0
	GO TOP
ENDIF



ENDPROC
PROCEDURE Init
Thisform.contenido.grdMenues.Refresh()
ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Usuario:"
Height = 15
Left = 26
Top = 48
Width = 59
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: sel_usuario
************************************************************
*** PROPIEDADES ***
Top = 42
Left = 86
cfieldname = idUsuario
esnumerico = .F.
nombre_campo_codigo = CodUsu
nombre_campo_desc = ApelNom
nombre_tabla = usuarios
pkfield = idUsuario
Name = "sel_usuario"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***
PROCEDURE recuperar_datos
LOCAL loPermisos, lcSql

loPermisos = CREATEOBJECT("odbc_result")
lcSql = ""

lcSql = "SELECT	idMenue FROM accesos WHERE idUsuario = " + ALLTRIM(STR(usuarios.idUsuario))

loPermisos.ActiveConnection = goConn.ActiveConnection
loPermisos.Cursor_Name = "cur_permisos"

IF !loPermisos.OpenQuery(lcSql) THEN
	MESSAGEBOX(loPermisos.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

UPDATE cur_Menues SET sel = .F.

SELECT cur_permisos
IF RECCOUNT("cur_permisos") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_permisos")
	UPDATE cur_Menues SET sel = .T. ;
	WHERE idMenu = cur_permisos.idMenue

	SELECT cur_permisos
	SKIP
ENDDO

loPermisos.Close_Query()

RETURN .T.
ENDPROC


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "A continuación seleccione los menues que puede acceder este usuario:"
Height = 15
Left = 26
Top = 74
Width = 418
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: grdMenues
************************************************************
*** PROPIEDADES ***
Height = 347
Left = 24
Top = 96
Width = 911
alias_name = cur_Menues
lista_ancho_cols = 30,70,200
list_controlsource = sel,CodMenu,Nombre
titulos_cabeceras = Sel.,Codigo,Nombre
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdMenues"
COLUMN1.Header1.Name = "Header1"
COLUMN1.Text1.ReadOnly = .F.
COLUMN1.Text1.Name = "Text1"
COLUMN1.CurrentControl = "chkSel"
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
OBJETO: chkSel
************************************************************
*** PROPIEDADES ***
Top = 23
Left = 37
Alignment = 0
Caption = ""
ReadOnly = .F.
Name = "chkSel"

*** METODOS ***


************************************************************
OBJETO: btnGrabar
************************************************************
*** PROPIEDADES ***
Top = 455
Left = 890
Name = "btnGrabar"

*** METODOS ***
PROCEDURE Click
IF thisform.contenido.sel_usuario.valcpoid = 0
	MESSAGEBOX("Falta ingresar el usuario", 0+64, Thisform.Caption)
	RETURN .F.
ENDIF

IF !Thisform.grabar()
	MESSAGEBOX("Ha ocurrido un error al intentar grabar los accesos", 0+64, Thisform.Caption)
	RETURN .F.
ENDIF

MESSAGEBOX("Los permisos se han configurado con éxito", 0+64, Thisform.Caption)

&& Limpio la pantalla

SELECT cur_Menues
IF RECCOUNT() > 0
	GO TOP
ENDIF

DO WHILE !EOF("cur_Menues")
	SELECT cur_Menues
	LOCK()
	REPLACE sel WITH .F.
	UNLOCK 

	SELECT cur_Menues
	SKIP
ENDDO

SELECT cur_Menues
IF RECCOUNT() > 0
	GO TOP
ENDIF

Thisform.Contenido.Refresh()
Thisform.Contenido.sel_usuario.blanquear()
Thisform.Contenido.sel_usuario.txtcodigo.SetFocus()

RETURN .T.
ENDPROC


************************************************************
OBJETO: btnCancelar
************************************************************
*** PROPIEDADES ***
Top = 454
Left = 23
Name = "btnCancelar"

*** METODOS ***
PROCEDURE Click
SELECT cur_Menues
IF RECCOUNT() > 0
	GO TOP
ENDIF

DO WHILE !EOF("cur_Menues")
	SELECT cur_Menues
	LOCK()
	REPLACE sel WITH .F.
	UNLOCK 

	SELECT cur_Menues
	SKIP
ENDDO

SELECT cur_Menues
IF RECCOUNT() > 0
	GO TOP
ENDIF

Thisform.Contenido.Refresh()
Thisform.Contenido.sel_usuario.blanquear()
Thisform.Contenido.sel_usuario.txtcodigo.SetFocus()
ENDPROC


************************************************************
OBJETO: 
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


