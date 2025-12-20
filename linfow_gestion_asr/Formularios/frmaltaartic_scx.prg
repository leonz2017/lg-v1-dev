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
OBJETO: FRMALTAARTIC
************************************************************
*** PROPIEDADES ***
DataSession = 1
Height = 135
Width = 674
DoCreate = .T.
BorderStyle = 2
Caption = "Alta de Artículos"
WindowType = 1
Name = "FRMALTAARTIC"
CONTENIDO.Top = 0
CONTENIDO.Left = 0
CONTENIDO.Width = 673
CONTENIDO.Height = 257
CONTENIDO.Name = "CONTENIDO"

*** METODOS ***


************************************************************
OBJETO: CLSETIQUETA1
************************************************************
*** PROPIEDADES ***
Caption = "Código:"
Height = 15
Left = 12
Top = 13
Width = 66
TabIndex = 8
Name = "CLSETIQUETA1"

*** METODOS ***


************************************************************
OBJETO: txtCodigo
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 118
TabIndex = 1
Top = 9
Width = 146
Name = "txtCodigo"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Descripción:"
Height = 15
Left = 12
Top = 36
Width = 75
TabIndex = 9
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: txtDescripcion
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 118
TabIndex = 2
Top = 32
Width = 546
Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Alic. I.V.A:"
Height = 15
Left = 12
Top = 59
Width = 75
TabIndex = 10
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: txtAlicIVA
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 118
TabIndex = 3
Top = 55
Width = 46
isnumeric = .T.
Name = "txtAlicIVA"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta9
************************************************************
*** PROPIEDADES ***
Caption = "Venta Max.:"
Height = 15
Left = 309
Top = 60
Width = 73
TabIndex = 12
Name = "Clsetiqueta9"

*** METODOS ***


************************************************************
OBJETO: txtPrVtaMax
************************************************************
*** PROPIEDADES ***
Enabled = .T.
Height = 21
Left = 381
ReadOnly = .F.
TabIndex = 4
Top = 55
Width = 88
isnumeric = .T.
Name = "txtPrVtaMax"

*** METODOS ***


************************************************************
OBJETO: btnGrabar
************************************************************
*** PROPIEDADES ***
Top = 78
Left = 571
TabIndex = 6
Name = "btnGrabar"

*** METODOS ***
PROCEDURE Click
LOCAL lnArticulo, lnIdProv, lnIdFamilia, lnIdSubFam, lnIdMarca
LOCAL lcCodArt, lcDescripcio, lnAlicIVA, lnPrLista
LOCAL lnBonif1, lnBonif2, lnBonif3, lnBonif4, lnCostoRep
LOCAL lnMargenMax, lnMargenMin, lnVentaMax, lnVentaMin, lnPrFinalMax, lnPrFinalMin
LOCAL lcObserv, loCommand

lnIdArticulo = 0
lnIdProv = 0
lnIdFamilia = 0
lnIdSubFam = 0
lnIdMarca = 0
lcCodArt = Thisform.Contenido.txtCodigo.Value
lcDescripcion = Thisform.Contenido.txtDescripcion.Value
lnAlicIVA = Thisform.Contenido.txtAlicIVA.Value
lnPrLista = Thisform.Contenido.txtPrLista.Value
lnBonif1 = 0
lnBonif2 = 0
lnBonif3 = 0
lnBonif4 = 0
lnCostoRep = 0
lnMargenMax = 0
lnMargenMin = 0
lnVentaMax = Thisform.Contenido.txtPrVtaMax.Value
lnVentaMin = Thisform.Contenido.txtPrVtaMin.Value
lnPrFinalMax = Thisform.Contenido.txtPrLista.Value
lnPrFinalMin = Thisform.Contenido.txtPrLista.Value
lcObserv = "ALTA DESDE EL MODULO DE PRESUPUESTOS"

IF ALLTRIM(thisform.contenido.txtCodigo.Value) == ""
	MESSAGEBOX("Falta ingresar el código de artículo", 0+64, Thisform.Caption)
	Thisform.Contenido.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

IF ALLTRIM(Thisform.contenido.txtDescripcion.Value) == ""
	MESSAGEBOX("Falta ingresar la descripción del artículo", 0+64, Thisform.Caption)
	Thisform.Contenido.txtDescripcion.SetFocus()
	RETURN .F.
ENDIF

IF Thisform.Contenido.txtPrVtaMax.Value = 0 .AND. Thisform.Contenido.txtPrVtaMin.Value = 0
	MESSAGEBOX("Falta ingresar un precio", 0+64, Thisform.Caption)
	Thisform.Contenido.txtPrLista.SetFocus()
	RETURN .F.
ENDIF

lnPrFinalMax = lnVentaMax + (lnVentaMax * (Thisform.Contenido.txtAlicIVA.Value / 100))
lnPrFinalMin = lnVentaMin + (lnVentaMin * (Thisform.Contenido.txtAlicIVA.Value / 100))

lnIdArticulo = goConn.getNextID("articulos", "idArticulo")

lcSql = "INSERT INTO articulos ( "
lcSql = lcSql + " 	idArticulo, "
lcSql = lcSql + "	idProv, "
lcSql = lcSql + "	idFamilia, "
lcSql = lcSql + "	idSubFam, "
lcSql = lcSql + "	idmarca, "
lcSql = lcSql + "	codArt, "
lcSql = lcSql + "	descripcio, "
lcSql = lcSql + "	alicIVA, "
lcSql = lcSql + "	tmon, "
lcSql = lcSql + "	prListaExt, "
lcSql = lcSql + "	cotizac, "
lcSql = lcSql + "	prLista, "
lcSql = lcSql + "	bonif1, "
lcSql = lcSql + "	bonif2, "
lcSql = lcSql + "	bonif3, "
lcSql = lcSql + "	bonif4, "
lcSql = lcSql + "	costoRep, "
lcSql = lcSql + "	margenMax, "
lcSql = lcSql + "	margenMin, "
lcSql = lcSql + "	prventaMax, "
lcSql = lcSql + "	prventaMin, "
lcSql = lcSql + "	prfinalMax, "
lcSql = lcSql + "	prfinalMin, "
lcSql = lcSql + "	observ, "
lcSql = lcSql + "	habilitado, "
lcSql = lcSql + "	linkFoto) "
lcSql = lcSql + "VALUES ( "
lcSql = lcSql + ALLTRIM(STR(lnIdArticulo)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnIdProv)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnIdFamilia)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnIdSubFam)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnIdMarca)) + ", "
lcSql = lcSql + "'" + ALLTRIM(lcCodArt) + "', "
lcSql = lcSql + "'" + ALLTRIM(lcDescripcion) + "', "
lcSql = lcSql + ALLTRIM(STR(lnAlicIVA, 10, 2)) + ", "
lcSql = lcSql + "'PSO', 0, 0, "
lcSql = lcSql + ALLTRIM(STR(lnPrLista, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnBonif1, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnBonif2, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnBonif3, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnBonif4, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnCostoRep, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnMargenMax, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnMargenMin, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnVentaMax, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnVentaMin, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnPrFinalMax, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnPrFinalMin, 10, 2)) + ", "
lcSql = lcSql + "'" + ALLTRIM(lcObserv) + "', "
lcSql = lcSql + " 1, '')"

goConn.BeginTransaction()
loCommand = CREATEOBJECT("odbc_command")
loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = lcSql

IF !loCommand.Execute()
	MESSAGEBOX("Ha ocurrido un error al intentar generar el nuevo artículo", 0+64, Thisform.Caption)
	goConn.Rollback()
	RETURN .F.
ENDIF

goConn.Commit()

&& Actualizo el cursor de artículos
SELECT articulos
APPEND BLANK
REPLACE idArticulo WITH lnIdArticulo
REPLACE idProv WITH lnIdProv ADDITIVE
REPLACE idFamilia WITH lnIdFamilia ADDITIVE
REPLACE idSubFam WITH lnIdSubFam ADDITIVE
REPLACE idMarca WITH lnIdMarca ADDITIVE
REPLACE codArt WITH lcCodArt ADDITIVE
REPLACE descripcio WITH lcDescripcion ADDITIVE
REPLACE alicIVA WITH lnAlicIVA ADDITIVE
REPLACE tmon WITH "PSO" ADDITIVE
REPLACE prListaExt WITH 0 ADDITIVE
REPLACE cotizac WITH 0 ADDITIVE
REPLACE prLista WITH lnPrLista ADDITIVE
REPLACE bonif1 WITH lnBonif1 ADDITIVE
REPLACE bonif2 WITH lnBonif2 ADDITIVE
REPLACE bonif3 WITH lnBonif3 ADDITIVE
REPLACE bonif4 WITH lnBonif4 ADDITIVE
REPLACE costoRep WITH lnCostoRep ADDITIVE
REPLACE margenMax WITH lnMargenMax ADDITIVE
REPLACE margenMin WITH lnMargenMin ADDITIVE
REPLACE prventaMax WITH lnVentaMax ADDITIVE
REPLACE prventaMin WITH lnVentaMin ADDITIVE
REPLACE prfinalMax WITH lnPrFinalMax ADDITIVE
REPLACE prfinalMin WITH lnPrFinalMin ADDITIVE
REPLACE observ WITH lcObserv ADDITIVE
REPLACE habilitado WITH .T. ADDITIVE
REPLACE linkFoto WITH "" ADDITIVE

Thisform.Release()

RETURN .T.
ENDPROC


************************************************************
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 78
Left = 619
TabIndex = 7
Name = "btnCerrar"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta10
************************************************************
*** PROPIEDADES ***
Caption = "Venta Min.:"
Height = 15
Left = 473
Top = 60
Width = 73
TabIndex = 11
Name = "Clsetiqueta10"

*** METODOS ***


************************************************************
OBJETO: txtPrVtaMin
************************************************************
*** PROPIEDADES ***
Enabled = .T.
Height = 21
Left = 541
ReadOnly = .F.
TabIndex = 5
Top = 55
Width = 88
isnumeric = .T.
Name = "txtPrVtaMin"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Precio:"
Height = 15
Left = 172
Top = 59
Width = 49
TabIndex = 12
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: txtPrLista
************************************************************
*** PROPIEDADES ***
Enabled = .T.
Height = 21
Left = 217
ReadOnly = .F.
TabIndex = 4
Top = 55
Width = 88
isnumeric = .T.
Name = "txtPrLista"

*** METODOS ***


************************************************************
OBJETO: 
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 13, 11, 11, 2, 0
Arial, 1, 8, 6, 13, 11, 12, 2, 0

*** METODOS ***


