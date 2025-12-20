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
OBJETO: FRM_UPDXLS_GHIO
************************************************************
*** PROPIEDADES ***
BorderStyle = 2
Height = 165
Width = 818
DoCreate = .T.
Caption = "Actualizar precios en Excel Imprimible"
Name = "FRM_UPDXLS_GHIO"
contenido.Name = "contenido"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Nro. columna que contiene el código de artículo:"
Height = 15
Left = 10
Top = 10
Width = 279
TabIndex = 9
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Nro. de columna que contiene los precios a actualizar:"
Height = 15
Left = 10
Top = 36
Width = 303
TabIndex = 10
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Actualizar hasta la fila Nro.:"
Height = 15
Left = 10
Top = 60
Width = 303
TabIndex = 11
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: txtNroColCodigo
************************************************************
*** PROPIEDADES ***
Left = 325
TabIndex = 1
Top = 7
isinteger = .T.
Name = "txtNroColCodigo"

*** METODOS ***


************************************************************
OBJETO: txtNroColPcio
************************************************************
*** PROPIEDADES ***
Left = 325
TabIndex = 2
Top = 31
isinteger = .T.
Name = "txtNroColPcio"

*** METODOS ***


************************************************************
OBJETO: txtNroFilaHasta
************************************************************
*** PROPIEDADES ***
Left = 325
TabIndex = 3
Top = 55
isinteger = .T.
Name = "txtNroFilaHasta"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Archivo a actualizar:"
Height = 15
Left = 10
Top = 87
Width = 303
TabIndex = 12
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: txtFileName
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 325
TabIndex = 5
Top = 79
Width = 444
Name = "txtFileName"

*** METODOS ***


************************************************************
OBJETO: btnAbrirArchivo
************************************************************
*** PROPIEDADES ***
Top = 77
Left = 775
Height = 25
Width = 33
Caption = "..."
TabIndex = 6
Name = "btnAbrirArchivo"

*** METODOS ***
PROCEDURE Click
LOCAL lcFileName

lcFileName = GETFILE("Microsoft Excel 2003:xls; Microsoft Excel 2007/2010:xlsx", "Abrir planilla", "Abrir", 0, "Abrir planilla de precios")
IF ALLTRIM(lcFileName) == "" THEN
	MESSAGEBOX("No ha abierto ningún archivo", 0+64, Thisform.Caption)
ELSE
	Thisform.Contenido.txtFileName.Value = ALLTRIM(lcFileName)
ENDIF
ENDPROC


************************************************************
OBJETO: btnGrabar
************************************************************
*** PROPIEDADES ***
Top = 112
Left = 715
TabIndex = 7
Name = "btnGrabar"

*** METODOS ***
PROCEDURE Click
LOCAL loExcel
LOCAL loProgressBar
LOCAL lnFilaActual
LOCAL lnTotalFilas
LOCAL lnColCodigo
LOCAL lnColPcio
LOCAL loRes
LOCAL lcSql
LOCAL lcCodigo

IF Thisform.Contenido.txtNroColCodigo.Value = 0 THEN
	MESSAGEBOX("Debe ingresar el número de columna que contiene el código", 0+48, Thisform.Caption)
	Thisform.Contenido.txtNroColCodigo.SetFocus()
	RETURN .F.
ENDIF

IF Thisform.Contenido.txtNroColPcio.Value = 0 THEN
	MESSAGEBOX("Debe ingresar el número de columna que contiene el precio", 0+48, Thisform.Caption)
	Thisform.Contenido.txtNroColPcio.SetFocus()
	RETURN .F
ENDIF

IF ALLTRIM(Thisform.Contenido.txtFileName.Value) == "" THEN
	MESSAGEBOX("Debe ingresar el nombre del archivo", 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

loRes = CREATEOBJECT("odbc_result")
lcSql = ""
loExcel = CREATEOBJECT("Excel.Application")
loProgressBar = CREATEOBJECT("_Thermometer")
lnFilaActual = 1
lnTotalFilas = Thisform.Contenido.txtNroFilaHasta.Value
lnColCodigo = Thisform.Contenido.txtNroColCodigo.Value
lnColPcio = Thisform.Contenido.txtNroColPcio.Value

loExcel.Visible = .F.
loExcel.Workbooks.Open(ALLTRIM(Thisform.Contenido.txtFileName.Value))
loExcel.Sheets[4].Select()

&& Levanto los artículos siempre y cuando no se encuentren dados de baja
lcSql = "SELECT articulos.codArt, "

IF Thisform.Contenido.chkPcioMay.Value = 1 THEN
	lcSql = lcSql + "articulos.prventaMax AS precio "
ELSE
	lcSql = lcSql + "articulos.prventaMin AS precio "
ENDIF

lcSql = lcSql + "FROM articulos "
lcSql = lcSql + "	INNER JOIN subfam ON subfam.idSubFam = articulos.idSubFam "
lcSql = lcSql + "WHERE articulos.fecBaja IS NULL "
lcSql = lcSql + "ORDER BY subfam.descripcio, articulos.codArt "

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_articulos"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

loProgressBar.Show()

lnFilaActual = 1
DO WHILE lnFilaActual <= lnTotalFilas
	IF !EMPTY(loExcel.cells(lnFilaActual, lnColCodigo).Value) .AND. !ISNULL(loExcel.cells(lnFilaActual, lnColCodigo).Value) THEN
		IF TYPE("loExcel.cells(lnFilaActual, lnColCodigo).Value") == "N" THEN
			lcCodigo = ALLTRIM(STR(loExcel.cells(lnFilaActual, lnColCodigo).Value))
		ELSE
			lcCodigo = ALLTRIM(loExcel.cells(lnFilaActual, lnColCodigo).Value)
		ENDIF
		
		SELECT cur_articulos
		LOCATE FOR ALLTRIM(cur_articulos.codArt) == lcCodigo
		
		IF FOUND("cur_articulos") THEN
			loExcel.cells(lnFilaActual, lnColPcio).Value = STRTRAN(ALLTRIM(STR(cur_articulos.precio, 10, 2)), ".", ",")
		ELSE
			&& Pintar el excel para marcar el artículo como nuevo.
		ENDIF
	ENDIF

	loProgressBar.update((lnFilaActual * 100) / lnTotalFilas, "Actualizando planilla excel...")	
	lnFilaActual = lnFilaActual + 1
ENDDO

loProgressBar.complete()

loRes.Close_Query()

WAIT WINDOW "Guardando planilla, aguarde por favor..." NOWAIT
loExcel.Workbooks.Close()

MESSAGEBOX("La actualización ha finalizado con éxito", 0+64, Thisform.Caption)

RETURN .T.
ENDPROC


************************************************************
OBJETO: btnSalir
************************************************************
*** PROPIEDADES ***
Top = 112
Left = 763
TabIndex = 8
Name = "btnSalir"

*** METODOS ***


************************************************************
OBJETO: chkPcioMay
************************************************************
*** PROPIEDADES ***
Top = 58
Left = 444
Alignment = 0
Caption = "Tomar precio mayorista para actualizar"
Value = 1
TabIndex = 4
Name = "chkPcioMay"

*** METODOS ***


************************************************************
OBJETO: 
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


