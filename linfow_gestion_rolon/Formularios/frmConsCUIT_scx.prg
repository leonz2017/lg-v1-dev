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
OBJETO: frmConsCUIT
************************************************************
*** PROPIEDADES ***
Height = 476
Width = 742
DoCreate = .T.
BorderStyle = 1
Caption = "Emitir constancia de C.U.I.T"
Name = "frmConsCUIT"

*** METODOS ***
PROCEDURE Init
thisform.browser.navigate("https://seti.afip.gob.ar/padron-puc-constancia-internet/ConsultaConstanciaAction.do")

ENDPROC


************************************************************
OBJETO: browser
************************************************************
*** PROPIEDADES ***
Top = 0
Left = 0
Height = 474
Width = 742
Anchor = 15
curl = https://seti.afip.gob.ar/padron-puc-constancia-internet/ConsultaConstanciaAction.do
Name = "browser"

*** METODOS ***


************************************************************
OBJETO: 
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


