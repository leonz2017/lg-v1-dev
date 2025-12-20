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
OBJETO: _Fiscal
************************************************************
*** PROPIEDADES ***
Top = 0
Left = 0
Height = 250
Width = 451
DoCreate = .T.
Caption = "test::fiscal"
Name = "_Fiscal"

*** METODOS ***


************************************************************
OBJETO: Command1
************************************************************
*** PROPIEDADES ***
Top = 24
Left = 180
Height = 36
Width = 108
Caption = "Factura A"
Name = "Command1"

*** METODOS ***
PROCEDURE Click
LOCAL TICKET_A

TICKET_A = 48

THISFORM.fiscal.Puerto = 1
THISFORM.fiscal.Comenzar
Thisform.fiscal.modelo = 8  && MODELO_P320
THISFORM.fiscal.TratarDeCancelarTodo
THISFORM.fiscal.DatosCliente("Yo", "20280456919", 67, 73, "Calle X")
THISFORM.fiscal.AbrirComprobanteFiscal (TICKET_A)
THISFORM.fiscal.ImprimirItem("Item 1", 1, 0.01, 21, 0)
THISFORM.fiscal.Subtotal (.T.)
THISFORM.fiscal.ImprimirPago ("Efectivo", 100)
THISFORM.fiscal.CerrarComprobanteFiscal
MESSAGEBOX(THISFORM.fiscal.Respuesta(0))
THISFORM.fiscal.Finalizar


ENDPROC


************************************************************
OBJETO: Command2
************************************************************
*** PROPIEDADES ***
Top = 72
Left = 180
Height = 36
Width = 108
Caption = "Factura B"
Name = "Command2"

*** METODOS ***
PROCEDURE Click
LOCAL TICKET_B

TICKET_B = 49

THISFORM.fiscal.Puerto = 1
THISFORM.fiscal.Comenzar
Thisform.fiscal.modelo = 8  && MODELO_P320
THISFORM.fiscal.TratarDeCancelarTodo
THISFORM.fiscal.DatosCliente("Yo", "20280456919", 67, 73, "Calle X")
THISFORM.fiscal.AbrirComprobanteFiscal (TICKET_B)
THISFORM.fiscal.ImprimirItem("Item 1", 1, 0.01, 21, 0)
THISFORM.fiscal.Subtotal (.T.)
THISFORM.fiscal.ImprimirPago ("Efectivo", 100)
THISFORM.fiscal.CerrarComprobanteFiscal
MESSAGEBOX(THISFORM.fiscal.Respuesta(0))
THISFORM.fiscal.Finalizar

ENDPROC


************************************************************
OBJETO: fiscal
************************************************************
*** PROPIEDADES ***
Top = 144
Left = 72
Height = 100
Width = 100
Name = "fiscal"

*** METODOS ***


************************************************************
OBJETO: Command3
************************************************************
*** PROPIEDADES ***
Top = 120
Left = 179
Height = 36
Width = 108
Caption = "Nota De Crédito A"
Name = "Command3"

*** METODOS ***
PROCEDURE Click

THISFORM.fiscal.Puerto = 1
THISFORM.fiscal.Comenzar()
Thisform.fiscal.modelo = 8  && MODELO_P320
THISFORM.fiscal.TratarDeCancelarTodo()
THISFORM.fiscal.DatosCliente("Yo", "20280456919", 67, 73, "Calle X")
THISFORM.fiscal.InformacionRemito = "0005-00030201"
THISFORM.fiscal.abrirComprobanteNoFiscalHomologado(82)
THISFORM.fiscal.ImprimirItem("Item 1", 1, 0.01, 21, 0)
THISFORM.fiscal.Subtotal (.T.)
THISFORM.fiscal.cerrarComprobanteNoFiscalHomologado()
MESSAGEBOX(THISFORM.fiscal.Respuesta(3))
THISFORM.fiscal.Finalizar()

ENDPROC


************************************************************
OBJETO: Command4
************************************************************
*** PROPIEDADES ***
Top = 168
Left = 180
Height = 36
Width = 108
Caption = "Nota De Crédito B"
Name = "Command4"

*** METODOS ***
PROCEDURE Click

THISFORM.fiscal.Puerto = 1
THISFORM.fiscal.Comenzar()
Thisform.fiscal.modelo = 8  && MODELO_P320
THISFORM.fiscal.TratarDeCancelarTodo()
THISFORM.fiscal.DatosCliente("Yo", "20280456919", 67, 73, "Calle X")
THISFORM.fiscal.InformacionRemito = "9999-99999999"
THISFORM.fiscal.abrirComprobanteNoFiscalHomologado(83)
THISFORM.fiscal.ImprimirItem("Item 1", 1, 0.01, 21, 0)
THISFORM.fiscal.Subtotal (.T.)
THISFORM.fiscal.cerrarComprobanteNoFiscalHomologado()
MESSAGEBOX(THISFORM.fiscal.Respuesta(3))
THISFORM.fiscal.Finalizar()

ENDPROC


************************************************************
OBJETO: 
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 13, 11, 11, 2, 0

*** METODOS ***


