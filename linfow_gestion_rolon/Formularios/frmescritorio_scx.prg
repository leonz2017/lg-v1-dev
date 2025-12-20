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
BorderStyle = 3
Height = 440
Width = 122
DoCreate = .T.
ShowTips = .T.
AutoCenter = .T.
Caption = "Barra de herramientas"
TitleBar = 0
BackColor = 255,255,255
Dockable = 1
Name = "FRMESCRITORIO"

*** METODOS ***
PROCEDURE Init
thisform.Dock(1)
ENDPROC


************************************************************
OBJETO: btnEtiquetas
************************************************************
*** PROPIEDADES ***
Top = 6
Left = 11
Height = 58
Width = 91
Picture = ..\..\clases\imagen\iconos bajados\aha-soft-large-business-printer.ico
Caption = "Etiquetas"
TabIndex = 1
ToolTipText = "Imprimir Etiquetas"
Name = "btnEtiquetas"

*** METODOS ***
PROCEDURE Click
DO FORM "frm_imprimir_etiquetas"
ENDPROC


************************************************************
OBJETO: btnFacturar
************************************************************
*** PROPIEDADES ***
Top = 185
Left = 12
Height = 58
Width = 91
Picture = ..\..\clases\imagen\escritorio\facturar.ico
Caption = "Facturar"
TabIndex = 4
ToolTipText = "Facturar"
Name = "btnFacturar"

*** METODOS ***
PROCEDURE Click
DO FORM "frm_factura_fe"
ENDPROC


************************************************************
OBJETO: btnArticulos
************************************************************
*** PROPIEDADES ***
Top = 66
Left = 11
Height = 58
Width = 91
Picture = ..\..\clases\imagen\escritorio\productos.ico
Caption = "Artículos"
TabIndex = 2
ToolTipText = "A.B.M. Artículos"
Name = "btnArticulos"

*** METODOS ***
PROCEDURE Click
DO FORM "frmabmarticulos"
ENDPROC


************************************************************
OBJETO: btnConsultarArticulos
************************************************************
*** PROPIEDADES ***
Top = 126
Left = 12
Height = 58
Width = 91
Picture = ..\..\clases\imagen\escritorio\consultar_articulos.ico
Caption = "Cons. Articulos"
TabIndex = 3
ToolTipText = "Consulta de artículos"
Name = "btnConsultarArticulos"

*** METODOS ***
PROCEDURE Click
DO FORM "frm_cons_artic"
ENDPROC


************************************************************
OBJETO: btnIVAVentas
************************************************************
*** PROPIEDADES ***
Top = 246
Left = 12
Height = 58
Width = 91
Picture = ..\..\clases\imagen\escritorio\iva_ventas.ico
Caption = "IVA. Ventas"
TabIndex = 5
ToolTipText = "Listado IVA. Ventas"
Name = "btnIVAVentas"

*** METODOS ***
PROCEDURE Click
DO FORM "frmivaventas"
ENDPROC


************************************************************
OBJETO: btnConsultaBajaCbtes
************************************************************
*** PROPIEDADES ***
Top = 307
Left = 12
Height = 58
Width = 91
Picture = ..\..\clases\imagen\escritorio\consulta_baja_cbtes.ico
Caption = "Cons. Cbtes."
TabIndex = 6
ToolTipText = "Consulta, baja y reimpresión de comprobantes"
Name = "btnConsultaBajaCbtes"

*** METODOS ***
PROCEDURE Click
DO FORM "frmConsBjaFC_SF"
ENDPROC


************************************************************
OBJETO: 
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


