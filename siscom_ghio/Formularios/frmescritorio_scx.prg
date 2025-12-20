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
OBJETO: FRMESCRITORIO
************************************************************
*** PROPIEDADES ***
Height = 48
Width = 458
DoCreate = .T.
AutoCenter = .T.
BorderStyle = 3
Caption = "Escritorio"
TitleBar = 0
BackColor = 255,255,255
Dockable = 1
Name = "FRMESCRITORIO"

*** METODOS ***
PROCEDURE Init
thisform.Dock(0)
ENDPROC


************************************************************
OBJETO: Clspicture1
************************************************************
*** PROPIEDADES ***
Picture = ..\clases\imagen\gestion\busquedaprod.jpg
Stretch = 2
BorderStyle = 1
Height = 37
Left = 153
MousePointer = 15
Top = 3
Width = 46
BorderColor = 0,0,0
ToolTipText = "Consultar Artículos"
Name = "Clspicture1"

*** METODOS ***
PROCEDURE Click
DO FORM "frm_cons_precios"
ENDPROC


************************************************************
OBJETO: Clspicture2
************************************************************
*** PROPIEDADES ***
Picture = ..\clases\imagen\gestion\proveedores.jpg
BorderStyle = 1
Height = 37
Left = 3
MousePointer = 15
Top = 3
Width = 43
BorderColor = 0,0,0
ToolTipText = "Proveedores"
Name = "Clspicture2"

*** METODOS ***
PROCEDURE Click
DO FORM "frmabmprov"
ENDPROC


************************************************************
OBJETO: Clspicture3
************************************************************
*** PROPIEDADES ***
Picture = ..\clases\imagen\gestion\abm_articulos.jpg
Stretch = 2
BorderStyle = 1
Height = 37
Left = 51
MousePointer = 15
Top = 3
Width = 43
BorderColor = 0,0,0
ToolTipText = "Artículos"
Name = "Clspicture3"

*** METODOS ***
PROCEDURE Click
DO FORM "frmabmarticulos"
ENDPROC


************************************************************
OBJETO: Clspicture4
************************************************************
*** PROPIEDADES ***
Picture = ..\clases\imagen\gestion\proceso_actu_masiva.jpg
Stretch = 2
BorderStyle = 1
Height = 37
Left = 205
MousePointer = 15
Top = 3
Width = 46
BorderColor = 0,0,0
ToolTipText = "Actualización de Precios Masiva"
Name = "Clspicture4"

*** METODOS ***
PROCEDURE Click
DO FORM "frm_actu_lista"
ENDPROC


************************************************************
OBJETO: Clspicture5
************************************************************
*** PROPIEDADES ***
Picture = ..\clases\imagen\gestion\presupuesto.jpg
Stretch = 2
BorderStyle = 1
Height = 37
Left = 256
MousePointer = 15
Top = 3
Width = 51
BorderColor = 0,0,0
ToolTipText = "Presupuestar"
Name = "Clspicture5"

*** METODOS ***
PROCEDURE Click
DO FORM "frmconfpresupuesto"
ENDPROC


************************************************************
OBJETO: Clspicture6
************************************************************
*** PROPIEDADES ***
Picture = ..\clases\imagen\gestion\clientes.jpg
Stretch = 2
BorderStyle = 1
Height = 37
Left = 99
MousePointer = 15
Top = 3
Width = 49
BorderColor = 0,0,0
ToolTipText = "Clientes"
Name = "Clspicture6"

*** METODOS ***
PROCEDURE Click
DO FORM "frmabmclientes"
ENDPROC


************************************************************
OBJETO: 
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 13, 11, 11, 2, 0

*** METODOS ***


