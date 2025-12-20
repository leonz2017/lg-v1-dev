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
OBJETO: FRM_PADRON_IIBB
************************************************************
*** PROPIEDADES ***
DoCreate = .T.
Caption = "Proceso de importación de IIBB"
WindowType = 0
Name = "FRM_PADRON_IIBB"

*** METODOS ***


************************************************************
OBJETO: txtHistorial
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 73
Left = 3
ReadOnly = .F.
TabIndex = 3
Top = 68
Width = 527
Name = "txtHistorial"

*** METODOS ***


************************************************************
OBJETO: Clscerrar1
************************************************************
*** PROPIEDADES ***
Top = 145
Left = 486
TabIndex = 5
Name = "Clscerrar1"

*** METODOS ***


************************************************************
OBJETO: btnGrabar
************************************************************
*** PROPIEDADES ***
Top = 145
Left = 441
TabIndex = 4
Name = "btnGrabar"

*** METODOS ***
PROCEDURE Click
LOCAL lcFileName

IF ALLTRIM(thisform.txtArchPer.Value) == "" THEN
	MESSAGEBOX("No se ha ingresado el archivo de percepciones", 0+48, Thisform.Caption)
	RETURN
ENDIF

IF ALLTRIM(thisform.txtArchRet.Value) == "" THEN
	MESSAGEBOX("No se ha ingresado el archivo de retenciones", 0+48, Thisform.Caption)
	RETURN
ENDIF

Thisform.padron_iibb.eliminar()

lcFileName = thisform.txtArchRet.Value

Thisform.padron_iibb.filename = lcFileName
Thisform.padron_iibb.crear_cursor()
Thisform.padron_iibb.leer_archivo()

Thisform.txtHistorial.Value = "Cantidad de Registros a Procesar: " + ALLTRIM(STR(Thisform.padron_iibb.cantidad_registros)) + CHR(13) + CHR(10)
Thisform.txtHistorial.Value = Thisform.txtHistorial.Value + "Importando registros, espere por favor... " + CHR(13) + CHR(10)
IF !Thisform.padron_iibb.grabar() THEN
	MESSAGEBOX(Thisform.padron_iibb.ErrorMessage, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

Thisform.txtHistorial.Value = Thisform.txtHistorial.Value + "Importación finalizada... " + CHR(13) + CHR(10)
Thisform.txtHistorial.Value = Thisform.txtHistorial.Value + "La actualización ha finalizado con éxito..." + CHR(13) + CHR(10)


lcFileName = thisform.txtArchPer.Value

Thisform.padron_iibb.filename = lcFileName
Thisform.padron_iibb.crear_cursor()
Thisform.padron_iibb.leer_archivo()

Thisform.txtHistorial.Value = "Cantidad de Registros a Procesar: " + ALLTRIM(STR(Thisform.padron_iibb.cantidad_registros)) + CHR(13) + CHR(10)
Thisform.txtHistorial.Value = Thisform.txtHistorial.Value + "Importando registros, espere por favor... " + CHR(13) + CHR(10)
IF !Thisform.padron_iibb.grabar() THEN
	MESSAGEBOX(Thisform.padron_iibb.ErrorMessage, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

Thisform.txtHistorial.Value = Thisform.txtHistorial.Value + "Importación finalizada... " + CHR(13) + CHR(10)
Thisform.txtHistorial.Value = Thisform.txtHistorial.Value + "La actualización ha finalizado con éxito..." + CHR(13) + CHR(10)


MESSAGEBOX("La actualización ha finalizado con éxito", 0+64, Thisform.Caption)
RETURN .T.
ENDPROC


************************************************************
OBJETO: CLSETIQUETA1
************************************************************
*** PROPIEDADES ***
Caption = "Archivo Retensiones:"
Height = 15
Left = 12
Top = 8
Width = 132
TabIndex = 6
Name = "CLSETIQUETA1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Archivo Percepciones:"
Height = 15
Left = 12
Top = 32
Width = 132
TabIndex = 7
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: txtArchRet
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 144
TabIndex = 8
Top = 5
Width = 342
Name = "txtArchRet"

*** METODOS ***


************************************************************
OBJETO: txtArchPer
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 144
TabIndex = 9
Top = 29
Width = 342
Name = "txtArchPer"

*** METODOS ***


************************************************************
OBJETO: btnBuscarRet
************************************************************
*** PROPIEDADES ***
Top = 4
Left = 489
Height = 24
Width = 27
Caption = "..."
TabIndex = 1
Name = "btnBuscarRet"

*** METODOS ***
PROCEDURE Click
thisform.txtArchRet.Value = GETFILE("txt", "Abrir padron de Retensiones IIBB")

ENDPROC


************************************************************
OBJETO: btnPerc
************************************************************
*** PROPIEDADES ***
Top = 28
Left = 489
Height = 24
Width = 27
Caption = "..."
TabIndex = 2
Name = "btnPerc"

*** METODOS ***
PROCEDURE Click
thisform.txtArchPer.Value = GETFILE("txt", "Abrir padron de Percepciones IIBB")
ENDPROC


************************************************************
OBJETO: padron_iibb
************************************************************
*** PROPIEDADES ***
Top = 160
Left = 162
Height = 17
Width = 42
Name = "padron_iibb"

*** METODOS ***


************************************************************
OBJETO: 
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


