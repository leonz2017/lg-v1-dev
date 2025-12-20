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
OBJETO: FRMVERDIFPRECIO
************************************************************
*** PROPIEDADES ***
DataSession = 1
Height = 381
Width = 365
DoCreate = .T.
BorderStyle = 2
Caption = "Diferencia de Precios con la lista anterior"
Name = "FRMVERDIFPRECIO"

*** METODOS ***
PROCEDURE Init
LOCAL idArticulo, lcSql, loData

SELECT cur_Artic

idArticulo = cur_Artic.idArticulo
Thisform.txtBonif1New.Value = cur_Artic.Bonif1
Thisform.txtBonif2New.Value = cur_Artic.Bonif2
Thisform.txtBonif3New.Value = cur_Artic.Bonif3
Thisform.txtBonif4New.Value = cur_Artic.Bonif4
Thisform.txtCostoRepNew.Value = cur_Artic.costoRep
Thisform.txtListaProvNuevo.Value = cur_Artic.prLista
Thisform.txtMargenMayNew.Value = cur_Artic.margenMax
Thisform.txtMargenMinNew.Value = cur_Artic.margenMin
Thisform.txtPrVtaMayNew.Value = cur_Artic.prventaMax
Thisform.txtPrVtaMinNew.Value = cur_Artic.prventaMin
Thisform.txtFinalMayNew.value = cur_Artic.prfinalMax
Thisform.txtFinaMinNew.Value = cur_Artic.prfinalMin

lcSql = "select prLista, bonif1, bonif2, bonif3, bonif4, costoRep, margenMax, margenMin, prventaMax, "
lcSql = lcSql + "	prventaMin, prfinalMax, prfinalMin "
lcSql = lcSql + "from articulos where idArticulo = " + ALLTRIM(STR(idArticulo))

loData = CREATEOBJECT("odbc_Result")
loData.ActiveConnection = goConn.ActiveConnection
loData.cursor_name = "cur_tmpart"
loData.OpenQuery(lcSql)

SELECT cur_tmpart
IF RECCOUNT() > 0
	Thisform.txtBonif1Ant.Value = cur_tmpart.bonif1
	Thisform.txtBonif2Ant.Value = cur_tmpart.bonif2
	Thisform.txtBonif3Ant.Value = cur_tmpart.bonif3
	Thisform.txtBonif4Ant.Value = cur_tmpart.bonif4
	Thisform.txtcostoRepAnt.Value = cur_tmpart.costoRep
	Thisform.txtListaProvAnt.Value = cur_tmpart.prLista
	Thisform.txtMargenMayAnt.Value = cur_tmpart.margenMax
	Thisform.txtMargenMinAnt.Value = cur_tmpart.margenMin
	Thisform.txtPrVtaMayAnt.Value = cur_tmpart.prventaMax
	Thisform.txtprVtaMinAnt.Value = cur_tmpart.prventaMin
	Thisform.txtFinalMayAnt.Value = cur_tmpart.prfinalMax
	Thisform.txtFinalMinAnt.Value = cur_tmpart.prfinalMin
ENDIF

USE IN cur_tmpart


ENDPROC
PROCEDURE Load
*

ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
FontBold = .T.
FontItalic = .T.
FontSize = 9
Caption = "Valores Anteriores"
Height = 15
Left = 130
Top = 7
Width = 110
ForeColor = 0,64,128
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
FontBold = .T.
FontItalic = .T.
FontSize = 9
Caption = "Valores Actuales"
Height = 15
Left = 251
Top = 7
Width = 109
ForeColor = 0,64,128
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Precio de Lista:"
Height = 15
Left = 12
Top = 33
Width = 108
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Bonificación 1:"
Height = 15
Left = 12
Top = 58
Width = 108
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Bonificación 2:"
Height = 15
Left = 12
Top = 82
Width = 108
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta6
************************************************************
*** PROPIEDADES ***
Caption = "Bonificación 3:"
Height = 15
Left = 12
Top = 106
Width = 108
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta7
************************************************************
*** PROPIEDADES ***
Caption = "Bonificación 4:"
Height = 15
Left = 12
Top = 130
Width = 108
Name = "Clsetiqueta7"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta8
************************************************************
*** PROPIEDADES ***
Caption = "Costo Rep.:"
Height = 15
Left = 12
Top = 153
Width = 108
Name = "Clsetiqueta8"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta9
************************************************************
*** PROPIEDADES ***
Caption = "Margen Mayorista:"
Height = 15
Left = 12
Top = 178
Width = 108
Name = "Clsetiqueta9"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta10
************************************************************
*** PROPIEDADES ***
Caption = "Margen Minorista:"
Height = 15
Left = 12
Top = 202
Width = 108
Name = "Clsetiqueta10"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta11
************************************************************
*** PROPIEDADES ***
Caption = "Pr. Vta. Mayorista:"
Height = 15
Left = 12
Top = 226
Width = 108
Name = "Clsetiqueta11"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta12
************************************************************
*** PROPIEDADES ***
Caption = "Pr. Vta. Minorista:"
Height = 15
Left = 12
Top = 250
Width = 108
Name = "Clsetiqueta12"

*** METODOS ***


************************************************************
OBJETO: txtListaProvAnt
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Left = 132
Top = 31
Name = "txtListaProvAnt"

*** METODOS ***


************************************************************
OBJETO: txtBonif1Ant
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Left = 132
Top = 55
Name = "txtBonif1Ant"

*** METODOS ***


************************************************************
OBJETO: txtBonif2Ant
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Left = 132
Top = 79
Name = "txtBonif2Ant"

*** METODOS ***


************************************************************
OBJETO: txtBonif3Ant
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Left = 132
Top = 103
Name = "txtBonif3Ant"

*** METODOS ***


************************************************************
OBJETO: txtBonif4Ant
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Left = 132
Top = 127
Name = "txtBonif4Ant"

*** METODOS ***


************************************************************
OBJETO: txtCostoRepAnt
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Left = 132
Top = 151
Name = "txtCostoRepAnt"

*** METODOS ***


************************************************************
OBJETO: txtMargenMayAnt
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Left = 132
Top = 175
Name = "txtMargenMayAnt"

*** METODOS ***


************************************************************
OBJETO: txtMargenMinAnt
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Left = 132
Top = 199
Name = "txtMargenMinAnt"

*** METODOS ***


************************************************************
OBJETO: txtPrVtaMayAnt
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Left = 132
Top = 223
Name = "txtPrVtaMayAnt"

*** METODOS ***


************************************************************
OBJETO: txtPrVtaMinAnt
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Left = 132
Top = 247
Name = "txtPrVtaMinAnt"

*** METODOS ***


************************************************************
OBJETO: txtListaProvNuevo
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Left = 252
Top = 31
Name = "txtListaProvNuevo"

*** METODOS ***


************************************************************
OBJETO: txtBonif1New
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Left = 252
Top = 55
Name = "txtBonif1New"

*** METODOS ***


************************************************************
OBJETO: txtBonif2New
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Left = 252
Top = 79
Name = "txtBonif2New"

*** METODOS ***


************************************************************
OBJETO: txtBonif3New
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Left = 252
Top = 103
Name = "txtBonif3New"

*** METODOS ***


************************************************************
OBJETO: txtBonif4New
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Left = 252
Top = 127
Name = "txtBonif4New"

*** METODOS ***


************************************************************
OBJETO: txtCostoRepNew
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Left = 252
Top = 151
Name = "txtCostoRepNew"

*** METODOS ***


************************************************************
OBJETO: txtMargenMayNew
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Left = 252
Top = 175
Name = "txtMargenMayNew"

*** METODOS ***


************************************************************
OBJETO: txtMargenMinNew
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Left = 252
Top = 199
Name = "txtMargenMinNew"

*** METODOS ***


************************************************************
OBJETO: txtPrVtaMayNew
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Left = 252
Top = 223
Name = "txtPrVtaMayNew"

*** METODOS ***


************************************************************
OBJETO: txtPrVtaMinNew
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Left = 252
Top = 247
Name = "txtPrVtaMinNew"

*** METODOS ***


************************************************************
OBJETO: Clscerrar1
************************************************************
*** PROPIEDADES ***
Top = 324
Left = 308
Name = "Clscerrar1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta13
************************************************************
*** PROPIEDADES ***
Caption = "Pr. Final Mayorista:"
Height = 15
Left = 12
Top = 271
Width = 108
Name = "Clsetiqueta13"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta14
************************************************************
*** PROPIEDADES ***
Caption = "Pr. Final Minorista:"
Height = 15
Left = 12
Top = 295
Width = 108
Name = "Clsetiqueta14"

*** METODOS ***


************************************************************
OBJETO: txtFinalMayAnt
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Left = 132
Top = 271
Name = "txtFinalMayAnt"

*** METODOS ***


************************************************************
OBJETO: txtFinalMinAnt
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Left = 132
Top = 295
Name = "txtFinalMinAnt"

*** METODOS ***


************************************************************
OBJETO: txtFinalMayNew
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Left = 252
Top = 271
Name = "txtFinalMayNew"

*** METODOS ***


************************************************************
OBJETO: txtFinaMinNew
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Left = 252
Top = 295
Name = "txtFinaMinNew"

*** METODOS ***


************************************************************
OBJETO: 
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 13, 11, 11, 2, 0
Arial, 1, 8, 6, 13, 11, 12, 2, 0
Arial, 0, 9, 5, 13, 11, 11, 2, 0

*** METODOS ***


