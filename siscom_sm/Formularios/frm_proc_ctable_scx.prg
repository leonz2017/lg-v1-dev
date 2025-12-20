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
OBJETO: FRM_PROC_CTABLE
************************************************************
*** PROPIEDADES ***
Height = 97
Width = 510
DoCreate = .T.
Caption = "Generar Ventas para el Estudio Contable"
Name = "FRM_PROC_CTABLE"
contenido.Top = 0
contenido.Left = 0
contenido.Width = 510
contenido.Height = 97
contenido.Name = "contenido"

*** METODOS ***


************************************************************
OBJETO: ventas
************************************************************
*** PROPIEDADES ***
Top = 60
Left = 24
Height = 17
Width = 24
Name = "ventas"

*** METODOS ***


************************************************************
OBJETO: btnGrabar
************************************************************
*** PROPIEDADES ***
Top = 48
Left = 410
Height = 44
Width = 45
TabIndex = 3
Name = "btnGrabar"

*** METODOS ***
PROCEDURE Click
Thisform.ventas.crear_cursor()

IF Thisform.Contenido.txtFecDesde.Value = {} THEN
	MESSAGEBOX("Debe ingresar la fecha desde", 0+48, Thisform.Caption)
	Thisform.Contenido.txtFecDesde.SetFocus()
	RETURN .F.
ENDIF

IF Thisform.Contenido.txtFecHasta.Value = {} THEN
	MESSAGEBOX("Debe ingresar la fecha hasta", 0+48, Thisform.Caption)
	Thisform.Contenido.txtFecHasta.SetFocus()
	RETURN .F.
ENDIF

Thisform.ventas.fecDesde = Thisform.Contenido.txtFecDesde.Value
Thisform.ventas.fecHasta = Thisform.Contenido.txtFecHasta.Value

IF !Thisform.ventas.leer_datos() THEN
	MESSAGEBOX(Thisform.ventas.ErrorMessage, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

IF !Thisform.ventas.grabar() THEN
	MESSAGEBOX(Thisform.ventas.ErrorMessage, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

MESSAGEBOX("El proceso finalizó con éxito", 0+64, Thisform.Caption)
Thisform.Release()

RETURN .T.
ENDPROC


************************************************************
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 48
Left = 457
Height = 44
Width = 45
TabIndex = 4
Name = "btnCerrar"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Fecha desde:"
Left = 22
Top = 19
TabIndex = 6
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Fecha hasta:"
Left = 225
Top = 19
TabIndex = 7
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: txtFecDesde
************************************************************
*** PROPIEDADES ***
Left = 104
TabIndex = 1
Top = 16
isdatetime = .T.
Name = "txtFecDesde"

*** METODOS ***


************************************************************
OBJETO: txtFecHasta
************************************************************
*** PROPIEDADES ***
Left = 302
TabIndex = 2
Top = 16
isdatetime = .T.
Name = "txtFecHasta"

*** METODOS ***


************************************************************
OBJETO: 
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


