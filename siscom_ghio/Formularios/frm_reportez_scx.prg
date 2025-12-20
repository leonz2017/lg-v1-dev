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
OBJETO: frm_reportez
************************************************************
*** PROPIEDADES ***
Height = 99
Width = 388
DoCreate = .T.
BorderStyle = 2
Caption = "Informe Z"
Name = "frm_reportez"
CONTENIDO.Name = "CONTENIDO"

*** METODOS ***


************************************************************
OBJETO: btnEmitirReporteZ
************************************************************
*** PROPIEDADES ***
Top = 24
Left = 72
Height = 32
Width = 100
Caption = "\<Emitir Reporte Z"
Name = "btnEmitirReporteZ"

*** METODOS ***
PROCEDURE Click
Thisform.Fiscal.Puerto = 1
Thisform.Fiscal.comenzar()
Thisform.Fiscal.tratarDeCancelarTodo()
Thisform.Fiscal.reporteZ()
Thisform.FiscaL.finalizar()
ENDPROC


************************************************************
OBJETO: btnCancelar
************************************************************
*** PROPIEDADES ***
Top = 24
Left = 199
Height = 32
Width = 100
Caption = "\<Cancelar"
Name = "btnCancelar"

*** METODOS ***
PROCEDURE Click
thisform.Release()
ENDPROC


************************************************************
OBJETO: Fiscal
************************************************************
*** PROPIEDADES ***
Top = 60
Left = 312
Height = 100
Width = 100
Name = "Fiscal"

*** METODOS ***


************************************************************
OBJETO: 
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 13, 11, 11, 2, 0

*** METODOS ***


