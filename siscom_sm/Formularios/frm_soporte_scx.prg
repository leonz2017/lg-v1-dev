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
Top = 0
Left = 0
Height = 689
Width = 343
DoCreate = .T.
Caption = "Mesa de Ayuda"
HalfHeightCaption = .T.
MaxButton = .F.
MinButton = .F.
BackColor = 0,0,0
Dockable = 1
Name = "frm_soporte"

*** METODOS ***
PROCEDURE DragDrop
LPARAMETERS oSource, nXCoord, nYCoord

ENDPROC
PROCEDURE Load
Thisform.Dock(2)
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
Height = 646
Width = 348
Anchor = 15
Name = "browser"

*** METODOS ***


************************************************************
OBJETO: 
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


