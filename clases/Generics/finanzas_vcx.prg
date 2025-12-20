************************************************************
OBJETO: cls_alta_chequera
************************************************************
*** PROPIEDADES ***
BorderStyle = 1
Height = 157
Width = 432
DoCreate = .T.
Caption = "Alta de chequeras"
Name = "cls_alta_chequera"
contenido.Name = "contenido"

*** METODOS ***
PROCEDURE Init
SELECT cur_bancos
GO TOP
DO WHILE !EOF("cur_bancos")
	Thisform.contenido.cmbBanco.AddItem(ALLTRIM(cur_bancos.descripcio))

	SELECT cur_bancos
	SKIP
ENDDO

SELECT cur_bancos
GO TOP
Thisform.contenido.cmbBanco.ListIndex = 1
ENDPROC
PROCEDURE Load
LOCAL loRes
LOCAL lcSql

DODEFAULT()

loRes = CREATEOBJECT("odbc_result")
lcSql = ""

CREATE CURSOR cur_bancos ( ;
	idBanco int, descripcio varchar(60))

lcSql = "SELECT bancos.idBanco, bancos.descripcio "
lcSql = lcSql + "FROM bancos "
lcSql = lcSql + "		INNER JOIN planctas ON planctas.idPlanCta = bancos.idPlanCta "
lcSql = lcSql + "ORDER BY bancos.descripcio ASC"

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_tempo"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN
ENDIF

SELECT cur_tempo
GO TOP
DO WHILE !EOF("cur_tempo")
	SELECT cur_bancos
	APPEND BLANK
	REPLACE cur_bancos.idBanco WITH cur_tempo.idBanco
	REPLACE cur_bancos.descripcio WITH ALLTRIM(cur_tempo.descripcio) ADDITIVE

	SELECT cur_tempo
	SKIP
ENDDO

loRes.Close_Query()

SELECT cur_bancos
GO TOP

ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Banco:"
Height = 15
Left = 13
Top = 13
Width = 48
TabIndex = 7
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: cmbBanco
************************************************************
*** PROPIEDADES ***
Height = 24
Left = 109
TabIndex = 1
Top = 7
Width = 305
Name = "cmbBanco"

*** METODOS ***


************************************************************
OBJETO: label2
************************************************************
*** PROPIEDADES ***
Caption = "Número desde:"
Height = 15
Left = 13
Top = 39
Width = 94
TabIndex = 8
Name = "label2"

*** METODOS ***


************************************************************
OBJETO: txtNumDesde
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 109
TabIndex = 2
Top = 36
Width = 108
isinteger = .T.
Name = "txtNumDesde"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Número hasta:"
Height = 15
Left = 13
Top = 65
Width = 94
TabIndex = 9
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: txtNumHasta
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 109
TabIndex = 3
Top = 62
Width = 108
isinteger = .T.
Name = "txtNumHasta"

*** METODOS ***


************************************************************
OBJETO: btnGrabar
************************************************************
*** PROPIEDADES ***
Top = 97
Left = 121
TabIndex = 4
Name = "btnGrabar"

*** METODOS ***
PROCEDURE Click
LOCAL loCommand
LOCAL lcSql
LOCAL lnProxID

loCommand = CREATEOBJECT("odbc_command")
lcSql = ""
lnProxID = 0

IF Thisform.contenido.cmbBanco.ListIndex = 0 THEN
	MESSAGEBOX("Debe seleccionar un banco obligatoriamente", 0+48, Thisform.Caption)
	Thisform.contenido.cmbBanco.SetFocus()
	RETURN
ENDIF

IF Thisform.contenido.txtNumDesde.Value = 0 THEN
	MESSAGEBOX("El número inicial de la chequera es obligatorio", 0+48, Thisform.Caption)
	Thisform.contenido.txtNumDesde.SetFocus()
	RETURN
ENDIF

IF Thisform.contenido.txtNumHasta.Value = 0 THEN
	MESSAGEBOX("El último número de cheque que hay en la chequera es obligatorio", 0+48, Thisform.Caption)
	Thisform.contenido.txtNumHasta.SetFocus()
	RETURN
ENDIF

SELECT cur_bancos
GO TOP
GO Thisform.contenido.cmbBanco.ListIndex

lnProxID = goConn.GetNextID("chequeras", "idChequera")
goConn.BeginTransaction()

lcSql = "INSERT INTO chequeras ( "
lcSql = lcSql + "idChequera, "
lcSql = lcSql + "idBanco, "
lcSql = lcSql + "numDesde, "
lcSql = lcSql + "numHasta, "
lcSql = lcSql + "numActual, "
lcSql = lcSql + "habilitado, "
lcSql = lcSql + "usuAlta, "
lcSql = lcSql + "fecAlta, "
lcSql = lcSql + "idHostAlta) "
lcSql = lcSql + "VALUES ( "
lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", "
lcSql = lcSql + ALLTRIM(STR(cur_bancos.idBanco)) + ", "
lcSql = lcSql + ALLTRIM(STR(Thisform.Contenido.txtNumDesde.Value)) + ", "
lcSql = lcSql + ALLTRIM(STR(Thisform.Contenido.txtNumHasta.Value)) + ", "
lcSql = lcSql + "1, "
lcSql = lcSql + "1, "
lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
lcSql = lcSql + "current_timestamp, "
lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "')"

loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = lcSql

IF !loCommand.Execute() THEN
	goConn.Rollback()
	MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
	RETURN
ENDIF

goConn.Commit()

MESSAGEBOX("La chequera fué dada de alta satisfactoriamente", 0+64, Thisform.Caption)
Thisform.Contenido.cmbBanco.ListIndex = 1
Thisform.Contenido.txtNumDesde.blanquear()
Thisform.Contenido.txtNumHasta.blanquear()

Thisform.Contenido.cmbBanco.SetFocus()

ENDPROC


************************************************************
OBJETO: btnCancelar
************************************************************
*** PROPIEDADES ***
Top = 97
Left = 170
TabIndex = 5
Name = "btnCancelar"

*** METODOS ***
PROCEDURE Click
Thisform.Contenido.cmbBanco.ListIndex = 1
Thisform.Contenido.txtNumDesde.blanquear()
Thisform.Contenido.txtNumHasta.blanquear()

Thisform.Contenido.cmbBanco.SetFocus()
ENDPROC


************************************************************
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 98
Left = 369
TabIndex = 6
Name = "btnCerrar"

*** METODOS ***


************************************************************
OBJETO: cls_alta_chequera
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


