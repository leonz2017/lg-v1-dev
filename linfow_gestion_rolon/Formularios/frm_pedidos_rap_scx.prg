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
OBJETO: FRM_PEDIDOS_RAP
************************************************************
*** PROPIEDADES ***
BorderStyle = 0
Height = 512
Width = 900
DoCreate = .T.
Caption = "Consulta de Artículos para Mostrador"
TitleBar = 0
Dockable = 0
cbte_m2 = 
Name = "FRM_PEDIDOS_RAP"
contenido.Top = 1
contenido.Left = 1
contenido.Width = 897
contenido.Height = 509
contenido.Name = "contenido"

*** METODOS ***
PROCEDURE agregar_item
SELECT cur_Artic 
Thisform.cbte_m2.contenido.sel_Articulo.txtCodigo.Value = cur_Artic.codArt
Thisform.cbte_m2.contenido.sel_Articulo.txtDescripcion.Value = cur_Artic.descripcio
Thisform.cbte_m2.contenido.sel_Articulo.txtCodigo.setFocus()

Thisform.cbte_m2.show()

Thisform.Contenido.txtValorBuscado.Value = ""

ENDPROC
PROCEDURE Init
Thisform.cbte_m2 = CREATEOBJECT("cls_cbtes_m2_sf")		&& Genera el objeto que contiene el formulario del comprobante.
Thisform.cbte_m2.cbte = "PED"							&& Indica que tipo de comprobante se va a emitir desde la consulta de artículos.
Thisform.cbte_m2.cerrar_cbte = .F.						&& Establece el falso la propiedad para que no se cierre el comprobante.
Thisform.cbte_m2.pciomaydef = .T.						&& Esta propiedad indica que al cargar un ítem, tome por defecto el precio mayorista.
THisform.cbte_m2.Caption = "Ingreso de Pedidos"			&& Establece el título de la ventana.
Thisform.WindowState = 2

ENDPROC
PROCEDURE Load
DODEFAULT()

CREATE CURSOR cur_Artic (	 ;
	idArticulo	integer		,;
	codArt		C(20)		,;
	descripcio	C(60)		,;
	razSoc		C(60)		,;
	descFam		C(60)		,;
	descSubFam	C(60)		,;
	alicIVA		float(10,2)	,;
	prLista		float(10,2)	,;
	bonif1		float(10,2)	,;
	bonif2		float(10,2)	,;
	bonif3		float(10,2)	,;
	bonif4		float(10,2)	,;
	costoRep	float(10,2)	,;
	margenMax	float(10,2)	,;
	margenMin	float(10,2)	,;
	prventaMax	float(10,2)	,;
	prventaMin	float(10,2)	,;
	prfinalMax	float(10,2)	,;
	prfinalMin	float(10,2) ,;
	linkfoto	C(100))
	
SELECT cur_Artic
INDEX ON idArticulo	TAG idArticulo	ASCENDING
INDEX ON codArt 	TAG codArt 		ASCENDING ADDITIVE
INDEX ON descripcio TAG descripcio 	ASCENDING ADDITIVE
INDEX ON razSoc 	TAG razSoc 		ASCENDING ADDITIVE
INDEX ON descFam 	TAG descFam 	ASCENDING ADDITIVE
INDEX ON descSubFam TAG descSubFam 	ASCENDING ADDITIVE
INDEX ON alicIVA	TAG alicIVA		ASCENDING ADDITIVE
INDEX ON prLista	TAG prLista		ASCENDING ADDITIVE
INDEX ON bonif1		TAG bonif1 		ASCENDING ADDITIVE
INDEX ON bonif2		TAG bonif2		ASCENDING ADDITIVE
INDEX ON bonif3		TAG bonif3		ASCENDING ADDITIVE
INDEX ON bonif4 	TAG bonif4		ASCENDING ADDITIVE
INDEX ON costoRep	TAG costoRep	ASCENDING ADDITIVE
INDEX ON margenMax	TAG margenMax	ASCENDING ADDITIVE
INDEX ON margenMin 	TAG margenMin	ASCENDING ADDITIVE
INDEX ON prventaMax	TAG prventaMax	ASCENDING ADDITIVE
INDEX ON prventaMin TAG prventaMin 	ASCENDING ADDITIVE
INDEX ON prfinalMax	TAG prfinalMax	ASCENDING ADDITIVE
INDEX ON prfinalMin TAG prfinalMin	ASCENDING ADDITIVE

ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Anchor = 3
Caption = "Valor Buscado:"
Height = 15
Left = 10
Top = 20
Width = 90
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: txtValorBuscado
************************************************************
*** PROPIEDADES ***
Anchor = 11
Height = 21
Left = 104
Top = 16
Width = 719
Name = "txtValorBuscado"

*** METODOS ***


************************************************************
OBJETO: grdArtic
************************************************************
*** PROPIEDADES ***
Anchor = 15
Height = 292
Left = 7
Top = 45
Width = 887
alias_name = cur_Artic
list_controlsource = codArt,descripcio,razSoc,prventaMax,prventaMin,prfinalMax,prfinalMin
lista_ancho_cols = 150,350,200,70,70,80,80
titulos_cabeceras = Código,Descripción,Proveedor,Venta May.,Venta Min.,c/IVA May.,c/IVA Min.
Name = "grdArtic"
COLUMN1.Header1.Name = "Header1"
COLUMN1.Text1.Name = "Text1"
COLUMN1.Name = "COLUMN1"
COLUMN2.Header1.Name = "Header1"
COLUMN2.Text1.Name = "Text1"
COLUMN2.Name = "COLUMN2"
COLUMN3.Header1.Name = "Header1"
COLUMN3.Text1.Name = "Text1"
COLUMN3.Name = "COLUMN3"
COLUMN4.Header1.Name = "Header1"
COLUMN4.Text1.Name = "Text1"
COLUMN4.Name = "COLUMN4"
COLUMN5.Header1.Name = "Header1"
COLUMN5.Text1.Name = "Text1"
COLUMN5.Name = "COLUMN5"
COLUMN6.Header1.Name = "Header1"
COLUMN6.Text1.Name = "Text1"
COLUMN6.Name = "COLUMN6"
COLUMN7.Header1.Name = "Header1"
COLUMN7.Text1.Name = "Text1"
COLUMN7.Name = "COLUMN7"
COLUMN8.Header1.Name = "Header1"
COLUMN8.Text1.Name = "Text1"
COLUMN8.Name = "COLUMN8"
COLUMN9.Header1.Name = "Header1"
COLUMN9.Text1.Name = "Text1"
COLUMN9.Name = "COLUMN9"
COLUMN10.Header1.Name = "Header1"
COLUMN10.Text1.Name = "Text1"
COLUMN10.Name = "COLUMN10"
COLUMN11.Header1.Name = "Header1"
COLUMN11.Text1.Name = "Text1"
COLUMN11.Name = "COLUMN11"
COLUMN12.Header1.Name = "Header1"
COLUMN12.Text1.Name = "Text1"
COLUMN12.Name = "COLUMN12"
COLUMN13.Header1.Name = "Header1"
COLUMN13.Text1.Name = "Text1"
COLUMN13.Name = "COLUMN13"
COLUMN14.Header1.Name = "Header1"
COLUMN14.Text1.Name = "Text1"
COLUMN14.Name = "COLUMN14"
COLUMN15.Header1.Name = "Header1"
COLUMN15.Text1.Name = "Text1"
COLUMN15.Name = "COLUMN15"
COLUMN16.Header1.Name = "Header1"
COLUMN16.Text1.Name = "Text1"
COLUMN16.Name = "COLUMN16"
COLUMN17.Header1.Name = "Header1"
COLUMN17.Text1.Name = "Text1"
COLUMN17.Name = "COLUMN17"
COLUMN18.Header1.Name = "Header1"
COLUMN18.Text1.Name = "Text1"
COLUMN18.Name = "COLUMN18"
COLUMN19.Header1.Name = "Header1"
COLUMN19.Text1.Name = "Text1"
COLUMN19.Name = "COLUMN19"
COLUMN20.Header1.Name = "Header1"
COLUMN20.Text1.Name = "Text1"
COLUMN20.Name = "COLUMN20"

*** METODOS ***
PROCEDURE AfterRowColChange
LPARAMETERS nColIndex

SELECT cur_Artic
thisform.contenido.txtprVtaMay.Value = cur_Artic.prventaMax
thisform.contenido.txtprFinalMin.Value = cur_Artic.prfinalMin
thisform.contenido.txtprFinalMay.value = cur_Artic.prfinalMax
thisform.contenido.txtPrVtaMin.Value = cur_Artic.prventaMin
thisform.contenido.txtAlicIVA.Value = cur_Artic.alicIVA
thisform.contenido.txtListaProv.Value = cur_Artic.prLista
thisform.contenido.txtBonif1.Value = cur_Artic.bonif1
thisform.contenido.txtBonif2.Value = cur_Artic.bonif2
thisform.contenido.txtBonif3.Value = cur_Artic.bonif3
thisform.contenido.txtBonif4.Value = cur_Artic.bonif4
thisform.contenido.txtCostoRep.Value = cur_Artic.costoRep
thisform.contenido.txtMargenMay.value = cur_Artic.margenMax
Thisform.contenido.txtMargenMin.Value = cur_Artic.MargenMin

thisform.contenido.txtCostoConIVA.Value = ROUND(cur_Artic.CostoRep + (cur_Artic.CostoRep * (thisform.contenido.txtAlicIVA.Value / 100)), 2)
thisform.contenido.picFoto.Picture = cur_Artic.linkfoto

ENDPROC
PROCEDURE press_enter
Thisform.cbte_m2.contenido.btnGrabar.Enabled = .F.
thisform.agregar_item()

ENDPROC


************************************************************
OBJETO: Clscerrar1
************************************************************
*** PROPIEDADES ***
Top = 459
Left = 847
Anchor = 12
Name = "Clscerrar1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Anchor = 36
Caption = "Pr. Lista Mayorista:"
Height = 15
Left = 427
Top = 368
Width = 130
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Anchor = 36
Caption = "Pr. Lista Minorista:"
Height = 15
Left = 427
Top = 392
Width = 124
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
FontItalic = .F.
Anchor = 12
Caption = "Con I.V.A Mayorista:"
Height = 15
Left = 676
Top = 392
Width = 121
ForeColor = 255,0,0
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
FontItalic = .F.
Anchor = 12
Caption = "Con I.V.A Minorista:"
Height = 15
Left = 676
Top = 415
Width = 118
ForeColor = 255,0,0
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: txtPrVtaMay
************************************************************
*** PROPIEDADES ***
Anchor = 36
Height = 21
Left = 554
ReadOnly = .T.
Top = 364
Width = 77
Name = "txtPrVtaMay"

*** METODOS ***


************************************************************
OBJETO: txtPrVtaMin
************************************************************
*** PROPIEDADES ***
Anchor = 36
Height = 21
Left = 554
ReadOnly = .T.
Top = 388
Width = 77
Name = "txtPrVtaMin"

*** METODOS ***


************************************************************
OBJETO: txtPrFinalMay
************************************************************
*** PROPIEDADES ***
FontItalic = .F.
Anchor = 12
Height = 21
Left = 798
ReadOnly = .T.
Top = 387
Width = 96
ForeColor = 255,0,0
Name = "txtPrFinalMay"

*** METODOS ***


************************************************************
OBJETO: txtPrFinalMin
************************************************************
*** PROPIEDADES ***
FontItalic = .F.
Anchor = 12
Height = 21
Left = 798
ReadOnly = .T.
Top = 411
Width = 96
ForeColor = 255,0,0
Name = "txtPrFinalMin"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta6
************************************************************
*** PROPIEDADES ***
Anchor = 36
Caption = "Costo de Reposición:"
Height = 15
Left = 426
Top = 344
Width = 127
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: txtCostoRep
************************************************************
*** PROPIEDADES ***
Anchor = 36
Height = 21
Left = 554
ReadOnly = .T.
Top = 340
Width = 77
Name = "txtCostoRep"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta7
************************************************************
*** PROPIEDADES ***
Anchor = 12
Caption = "Desc.:"
Height = 15
Left = 637
Top = 343
Width = 46
Name = "Clsetiqueta7"

*** METODOS ***


************************************************************
OBJETO: txtBonif1
************************************************************
*** PROPIEDADES ***
Anchor = 12
Height = 21
Left = 678
ReadOnly = .T.
Top = 340
Width = 56
Name = "txtBonif1"

*** METODOS ***


************************************************************
OBJETO: txtBonif2
************************************************************
*** PROPIEDADES ***
Anchor = 12
Height = 21
Left = 737
ReadOnly = .T.
Top = 340
Width = 53
Name = "txtBonif2"

*** METODOS ***


************************************************************
OBJETO: txtBonif3
************************************************************
*** PROPIEDADES ***
Anchor = 12
Height = 21
Left = 792
ReadOnly = .T.
Top = 340
Width = 51
Name = "txtBonif3"

*** METODOS ***


************************************************************
OBJETO: txtBonif4
************************************************************
*** PROPIEDADES ***
Anchor = 12
Height = 21
Left = 844
ReadOnly = .T.
Top = 340
Width = 50
Name = "txtBonif4"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta8
************************************************************
*** PROPIEDADES ***
Anchor = 6
Caption = "Precio de Lista Prov.:"
Height = 15
Left = 220
Top = 345
Width = 127
Name = "Clsetiqueta8"

*** METODOS ***


************************************************************
OBJETO: txtListaProv
************************************************************
*** PROPIEDADES ***
Anchor = 6
Height = 21
Left = 347
ReadOnly = .T.
Top = 342
Width = 70
Name = "txtListaProv"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta9
************************************************************
*** PROPIEDADES ***
Anchor = 6
Caption = "Margen Mayorista:"
Height = 15
Left = 221
Top = 392
Width = 113
Name = "Clsetiqueta9"

*** METODOS ***


************************************************************
OBJETO: txtMargenMay
************************************************************
*** PROPIEDADES ***
Anchor = 6
Height = 21
Left = 347
ReadOnly = .T.
Top = 388
Width = 71
Name = "txtMargenMay"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta10
************************************************************
*** PROPIEDADES ***
Anchor = 6
Caption = "Margen Minorista:"
Height = 15
Left = 220
Top = 416
Width = 106
Name = "Clsetiqueta10"

*** METODOS ***


************************************************************
OBJETO: txtMargenMin
************************************************************
*** PROPIEDADES ***
Anchor = 6
Height = 21
Left = 347
ReadOnly = .T.
Top = 411
Width = 71
Name = "txtMargenMin"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta11
************************************************************
*** PROPIEDADES ***
Anchor = 6
Caption = "Alícuota I.V.A.:"
Height = 15
Left = 221
Top = 369
Width = 99
Name = "Clsetiqueta11"

*** METODOS ***


************************************************************
OBJETO: txtAlicIVA
************************************************************
*** PROPIEDADES ***
Anchor = 6
Height = 21
Left = 347
ReadOnly = .T.
Top = 365
Width = 71
Name = "txtAlicIVA"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta12
************************************************************
*** PROPIEDADES ***
FontItalic = .F.
Anchor = 12
Caption = "Costo con I.V.A:"
Height = 15
Left = 676
Top = 368
Width = 99
ForeColor = 255,0,0
Name = "Clsetiqueta12"

*** METODOS ***


************************************************************
OBJETO: txtCostoConIVA
************************************************************
*** PROPIEDADES ***
FontItalic = .F.
Anchor = 12
Height = 21
Left = 798
ReadOnly = .T.
Top = 363
Width = 96
ForeColor = 255,0,0
Name = "txtCostoConIVA"

*** METODOS ***


************************************************************
OBJETO: picFoto
************************************************************
*** PROPIEDADES ***
Anchor = 6
Height = 156
Left = 8
Top = 347
Width = 206
Name = "picFoto"

*** METODOS ***


************************************************************
OBJETO: cnt_command_facts
************************************************************
*** PROPIEDADES ***
Anchor = 14
Top = 443
Left = 239
Width = 588
Height = 60
Name = "cnt_command_facts"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Alignment = 2
BackStyle = 1
Caption = "Facturación"
Height = 15
Left = 2
Top = 2
Width = 585
ForeColor = 255,255,255
BackColor = 0,64,128
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: btnAgregar
************************************************************
*** PROPIEDADES ***
Top = 24
Left = 137
Height = 24
Width = 96
Caption = "\<Agregar Item"
Name = "btnAgregar"

*** METODOS ***
PROCEDURE Click
Thisform.cbte_m2.contenido.btnGrabar.Enabled = .F.
Thisform.agregar_item()
Thisform.Contenido.txtValorBuscado.Value = ""
Thisform.Contenido.txtValorBuscado.SetFocus()
ENDPROC


************************************************************
OBJETO: btnModificar
************************************************************
*** PROPIEDADES ***
Top = 24
Left = 233
Height = 24
Width = 96
Caption = "\<Modificar Items"
Name = "btnModificar"

*** METODOS ***
PROCEDURE Click
Thisform.cbte_m2.contenido.btnGrabar.Enabled = .F.
Thisform.cbte_m2.show()
Thisform.cbte_m2.contenido.sel_Articulo.txtCodigo.setFocus()
ENDPROC


************************************************************
OBJETO: btnFacturar
************************************************************
*** PROPIEDADES ***
Top = 24
Left = 330
Height = 24
Width = 96
Caption = "\<Cerrar Pedido"
Name = "btnFacturar"

*** METODOS ***
PROCEDURE Click
Thisform.cbte_m2.contenido.sel_Cliente.SetFocus()
Thisform.cbte_m2.contenido.btnGrabar.Enabled = .F.
Thisform.cbte_m2.cerrar_cbte = .T.
Thisform.cbte_m2.show()
ENDPROC


************************************************************
OBJETO: btnBuscar
************************************************************
*** PROPIEDADES ***
Top = 1
Left = 836
TabIndex = 3
Name = "btnBuscar"

*** METODOS ***
PROCEDURE Click
LOCAL lcSql
LOCAL oData

lcSql = "select   	articulos.idArticulo, "
lcSql = lcSql + " 	articulos.codArt, "
lcSql = lcSql + " 	articulos.descripcio, "
lcSql = lcSql + " 	proveedor.razSoc, "
lcSql = lcSql + " 	familias.descripcio as descfam, "
lcSql = lcSql + " 	subfam.descripcio as descsubfam, "
lcSql = lcSql + " 	articulos.alicIVA, "
lcSql = lcSql + " 	articulos.prLista, "
lcSql = lcSql + " 	articulos.bonif1, "
lcSql = lcSql + " 	articulos.bonif2, "
lcSql = lcSql + " 	articulos.bonif3, "
lcSql = lcSql + " 	articulos.bonif4, "
lcSql = lcSql + " 	articulos.costoRep, " 
lcSql = lcSql + " 	articulos.margenMax, "
lcSql = lcSql + " 	articulos.margenMin, "
lcSql = lcSql + " 	articulos.prventaMax, "
lcSql = lcSql + " 	articulos.prventaMin, "
lcSql = lcSql + " 	articulos.prfinalMax, "
lcSql = lcSql + " 	articulos.prfinalMin, "
lcSql = lcSql + "	articulos.linkFoto "
lcSql = lcSql + " from    articulos, "
lcSql = lcSql + "         proveedor, "
lcSql = lcSql + "         familias, "
lcSql = lcSql + "         subfam, "
lcSql = lcSql + "		  marcas "
lcSql = lcSql + " where   articulos.idprov = proveedor.idprov "
lcSql = lcSql + "     and articulos.idfamilia = familias.idfamilia "
lcSql = lcSql + "     and articulos.idsubfam = subfam.idsubfam "
lcSql = lcSql + "	  and articulos.idmarca = marcas.idmarca "
lcSql = lcSql + "     and (articulos.codArt like '%" + ALLTRIM(thisform.contenido.txtValorBuscado.value) + "%' "
lcSql = lcSql + "         or articulos.descripcio like '%" + ALLTRIM(thisform.contenido.txtValorBuscado.value) + "%' "
lcSql = lcSql + "         or proveedor.razSoc like '%" + ALLTRIM(thisform.contenido.txtvalorBuscado.value) + "%' "
lcSql = lcSql + "         or familias.descripcio like '%" + ALLTRIM(thisform.contenido.txtvalorBuscado.value) + "%' "
lcSql = lcSql + "         or subfam.descripcio like '%" + ALLTRIM(thisform.contenido.txtvalorBuscado.value) + "%' "
lcSql = lcSql + "		  or marcas.descripcio like '%" + ALLTRIM(thisform.contenido.txtvalorBuscado.value) + "%' "
lcSql = lcSql + "		  or articulos.observ like '%" + ALLTRIM(thisform.contenido.txtValorBuscado.Value) + "%')"

oData = CREATEOBJECT("odbc_Result")
oData.ActiveConnection = goConn.ActiveConnection
oData.cursor_name = "cur_a"
oData.OpenQuery(lcSql)

SELECT cur_Artic
IF RECCOUNT() > 0
	ZAP
ENDIF

SELECT cur_a
IF RECCOUNT() > 0
	GO TOP
ENDIF

SELECT cur_a
DO WHILE !EOF()
	SELECT cur_Artic
	APPEND BLANK
	
	REPLACE cur_Artic.idArticulo 	WITH cur_a.idArticulo
	REPLACE cur_Artic.codArt 		WITH cur_a.codArt 		ADDITIVE
	REPLACE cur_Artic.descripcio 	WITH cur_a.descripcio 	ADDITIVE
	REPLACE cur_Artic.razSoc		WITH cur_a.razSoc		ADDITIVE
	REPLACE cur_Artic.descFam		WITH cur_a.descFam		ADDITIVE
	REPLACE cur_Artic.descSubFam	WITH cur_a.descSubFam	ADDITIVE
	REPLACE cur_Artic.alicIVA		WITH cur_a.alicIVA		ADDITIVE
	REPLACE cur_Artic.prLista		WITH cur_a.prLista		ADDITIVE
	REPLACE cur_Artic.bonif1		WITH cur_a.bonif1		ADDITIVE
	REPLACE cur_Artic.bonif2		WITH cur_a.bonif2		ADDITIVE
	REPLACE cur_Artic.bonif3		WITH cur_a.bonif3		ADDITIVE
	REPLACE cur_Artic.bonif4		WITH cur_a.bonif4		ADDITIVE
	REPLACE cur_Artic.costoRep		WITH cur_a.costoRep		ADDITIVE
	REPLACE cur_Artic.margenMax		WITH cur_a.margenMax	ADDITIVE
	REPLACE cur_Artic.margenMin		WITH cur_a.margenMin	ADDITIVE
	REPLACE cur_Artic.prventaMax	WITH cur_a.prventaMax	ADDITIVE
	REPLACE cur_Artic.prventaMin	WITH cur_a.prventaMin	ADDITIVE
	REPLACE cur_Artic.prfinalMax	WITH cur_a.prfinalMax	ADDITIVE
	REPLACE cur_Artic.prfinalMin	WITH cur_a.prfinalMin	ADDITIVE
	REPLACE cur_Artic.linkfoto 		WITH IIF(ISNULL(cur_a.linkFoto), "", cur_a.linkFoto) ADDITIVE
	
	SELECT cur_a
	SKIP	
ENDDO

USE IN cur_a

SELECT cur_Artic
IF RECCOUNT() > 0
	GO TOP
	thisform.contenido.txtprVtaMay.Value = cur_Artic.prventaMax
	thisform.contenido.txtprFinalMin.Value = cur_Artic.prfinalMin
	thisform.contenido.txtprFinalMay.value = cur_Artic.prfinalMax
	thisform.contenido.txtPrVtaMin.Value = cur_Artic.prventaMin
	thisform.contenido.txtAlicIVA.Value = cur_Artic.alicIVA
	thisform.contenido.txtListaProv.Value = cur_Artic.prLista
	thisform.contenido.txtBonif1.Value = cur_Artic.bonif1
	thisform.contenido.txtBonif2.Value = cur_Artic.bonif2
	thisform.contenido.txtBonif3.Value = cur_Artic.bonif3
	thisform.contenido.txtBonif4.Value = cur_Artic.bonif4
	thisform.contenido.txtCostoRep.Value = cur_Artic.costoRep
	thisform.contenido.txtMargenMay.value = cur_Artic.margenMax
	Thisform.contenido.txtMargenMin.Value = cur_Artic.MargenMin

	thisform.contenido.txtCostoConIVA.Value = ROUND(cur_Artic.CostoRep + (cur_Artic.CostoRep * (thisform.contenido.txtAlicIVA.Value / 100)), 2)
	thisform.contenido.picFoto.Picture = IIF(ISNULL(cur_Artic.linkfoto), "", cur_Artic.linkfoto)
ENDIF

Thisform.contenido.grdArtic.Refresh()
ENDPROC


************************************************************
OBJETO: 
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


