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
OBJETO: frm_soporte
************************************************************
*** PROPIEDADES ***
BorderStyle = 1
Top = 0
Left = 0
Height = 711
Width = 671
DoCreate = .T.
Caption = "Mesa de Ayuda"
HalfHeightCaption = .F.
MaxButton = .F.
MinButton = .T.
MDIForm = .F.
WindowState = 0
BackColor = 255,255,255
Dockable = 0
Name = "frm_soporte"

*** METODOS ***
PROCEDURE DragDrop
LPARAMETERS oSource, nXCoord, nYCoord

ENDPROC
PROCEDURE Init
thisform.browser.navigate("https://www.linfow.com.ar/linfow_support/index.php?razonSocial=" + getConfig("NOMEMP") ;
	+ "&nro_cuit=" + getGlobalCFG("FECUIT"))
ENDPROC


************************************************************
OBJETO: browser
************************************************************
*** PROPIEDADES ***
Top = 0
Left = 0
Height = 652
Width = 671
Anchor = 240
Name = "browser"

*** METODOS ***


************************************************************
OBJETO: 
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


