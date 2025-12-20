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
OBJETO: FRMBLOGSISCOM
************************************************************
*** PROPIEDADES ***
Height = 571
Width = 946
DoCreate = .T.
BorderStyle = 3
Caption = "Blog SISCOM"
MaxButton = .F.
MinButton = .F.
TitleBar = 1
WindowState = 2
SizeBox = .F.
Themes = .T.
Name = "FRMBLOGSISCOM"
contenido.Name = "contenido"

*** METODOS ***
PROCEDURE Init
thisform.browser.navigate("http://siscom.hol.es")
ENDPROC


************************************************************
OBJETO: browser
************************************************************
*** PROPIEDADES ***
Top = 1
Left = 1
Height = 569
Width = 944
Anchor = 15
curl = http://siscom-software.blogspot.com.ar/p/que-es-siscom.html
Name = "browser"

*** METODOS ***


************************************************************
OBJETO: 
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 13, 11, 11, 2, 0

*** METODOS ***


