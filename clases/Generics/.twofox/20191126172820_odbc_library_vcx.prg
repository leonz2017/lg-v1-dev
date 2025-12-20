************************************************************
OBJETO: odbc_connect
************************************************************
*** PROPIEDADES ***
connectionstring = 
activeconnection = 
errormessage = 
Name = "odbc_connect"

*** METODOS ***
PROCEDURE open
this.activeconnection = SQLSTRINGCONNECT(this.connectionstring)

IF this.activeconnection = -1
	this.ErrorMessage = "Ha ocurrido un error al intentar establecer la conexión con la base de datos"
	RETURN .F.
ENDIF

SQLSETPROP(this.activeconnection,"DispWarnings", .T.)
RETURN .T.


ENDPROC
PROCEDURE close
SQLDISCONNECT(this.activeconnection)
ENDPROC
PROCEDURE begintransaction
LOCAL nRes
LOCAL lnSqlSrv

lnSqlSrv = VAL(getconfig("SQLSRV"))

IF lnSqlSrv = 0
	nRes = SQLEXEC(this.activeconnection, "START TRANSACTION")
ELSE
	nRes = SQLEXEC(this.activeconnection, "BEGIN TRANSACTION")
ENDIF

IF nRes <> 1
	this.errormessage = "Error al intentar iniciar la transacción"
	RETURN .F.
ENDIF

RETURN .T.
ENDPROC
PROCEDURE commit
LOCAL nRes

nRes = SQLEXEC(this.activeconnection, "COMMIT")
IF nRes <> 1
	this.ErrorMessage = "Error al confirmar la transacción"
ENDIF

ENDPROC
PROCEDURE rollback
LOCAL nRes

nRes = SQLEXEC(this.activeconnection, "ROLLBACK")
IF nRes <> 1
	this.ErrorMessage = "Error al confirmar la transacción"
ENDIF

ENDPROC
PROCEDURE getnextid
PARAMETERS tcTableName, tcFieldName

LOCAL cSql
LOCAL nReturnCode

cSql = "SELECT MAX(" + tcFieldName + ") AS MaxID FROM " + tcTableName

SQLEXEC(this.activeconnection, cSql, "cur_MaxID")

SELECT cur_MaxID
IF ISNULL(cur_MaxID.MaxID)
	nReturnCode = 1
ELSE
	nReturnCode = cur_MaxID.MaxID + 1
ENDIF

RETURN nReturnCode


ENDPROC


************************************************************
OBJETO: cls_dataformat
************************************************************
*** PROPIEDADES ***
Name = "cls_dataformat"

*** METODOS ***
PROCEDURE str_sqlfmt
PARAMETERS tcString

LOCAL lcResult

IF INT(VAL(getConfig("SQLSRV"))) = 1 THEN
	&& Reemplazos a realizar si se está usando SQL Server
	lcResult = STRTRAN(tcString, "'", "''")
ELSE
	&& Reemplazos a realizar si se está usando mysql
	lcResult = STRTRAN(tcString, "'", "''")
	lcResult = STRTRAN(lcResult, "\", "\\")
ENDIF

RETURN "'" + ALLTRIM(lcResult) + "'"
ENDPROC
PROCEDURE float_sqlfmt
PARAMETERS tnValue, tnDigits, tnDecimals

RETURN ALLTRIM(STR(tnValue, tnDigits, tnDecimals))
ENDPROC
PROCEDURE datetime_sqlfmt
PARAMETERS td_Fecha

LOCAL nDia, nMes, nAnio, cFecResult, lnSqlSrv

lnSqlSrv = VAL(getconfig("SQLSRV"))
nDia = DAY(td_Fecha)
nMes = MONTH(td_Fecha)
nAnio = YEAR(td_Fecha)

IF lnSqlSrv = 0 THEN
	cFecResult = "'" + ALLTRIM(STR(nAnio)) + "-" + ALLTRIM(STR(nMes)) + "-" + ALLTRIM(STR(nDia)) + "'"
ELSE
	cFecResult = "CONVERT(DATETIME, '" + ALLTRIM(STR(nDia)) + "-" + ALLTRIM(STR(nMes)) + "-" + ALLTRIM(STR(nAnio)) + "')"
ENDIF

RETURN cFecResult

ENDPROC


************************************************************
OBJETO: datetime
************************************************************
*** PROPIEDADES ***
Name = "datetime"

*** METODOS ***
PROCEDURE tomysql
PARAMETERS td_Fecha

LOCAL nDia, nMes, nAnio, cFecResult, lnSqlSrv

lnSqlSrv = VAL(getconfig("SQLSRV"))
nDia = DAY(td_Fecha)
nMes = MONTH(td_Fecha)
nAnio = YEAR(td_Fecha)

IF lnSqlSrv <> 2 THEN
	IF lnSqlSrv = 0 THEN
		cFecResult = "'" + ALLTRIM(STR(nAnio)) + "-" + ALLTRIM(STR(nMes)) + "-" + ALLTRIM(STR(nDia)) + "'"
	ELSE
		cFecResult = "CONVERT(DATETIME, '" + ALLTRIM(STR(nDia)) + "-" + ALLTRIM(STR(nMes)) + "-" + ALLTRIM(STR(nAnio)) + "')"
	ENDIF
ELSE
	&& Si lnSqlSrv = 2, entonces, signfica que se está ejecutándo desde Access
	cFecResult = "#" + ALLTRIM(DTOC(td_Fecha)) + "#"
ENDIF

RETURN cFecResult

ENDPROC
PROCEDURE getdatetime
IF INT(VAL(getConfig("SQLSRV"))) = 0 THEN
	&& MySql
	RETURN "current_timestamp"
ELSE
	IF INT(VAL(getConfig("SQLSRV"))) = 1 THEN
		&& SQL Server
		RETURN "GETDATE()"
	ELSE
		&& Access
		RETURN "Now()"
	ENDIF
ENDIF
ENDPROC
PROCEDURE to_webservice
PARAMETERS td_Fecha

LOCAL nDia, nMes, nAnio, cFecResult, lnSqlSrv

lnSqlSrv = VAL(getconfig("SQLSRV"))
nDia = DAY(td_Fecha)
nMes = MONTH(td_Fecha)
nAnio = YEAR(td_Fecha)

cFecResult = ALLTRIM(STR(nAnio)) + "-" + IIF(nMes < 10, "0" + ALLTRIM(STR(nMes)), ALLTRIM(STR(nMes))) + "-" + ALLTRIM(STR(nDia))

RETURN cFecResult

ENDPROC
PROCEDURE getnombremes
PARAMETERS tnMes

DO CASE 
CASE tnMes = 1
	RETURN "ENERO"
CASE tnMes = 2
	RETURN "FEBRERO"
CASE tnMes = 3
	RETURN "MARZO"
CASE tnMes = 4
	RETURN "ABRIL"
CASE tnMes = 5
	RETURN "MAYO"
CASE tnMes = 6
	RETURN "JUNIO"
CASE tnMes = 7
	RETURN "JULIO"
CASE tnMes = 8
	RETURN "AGOSTO"
CASE tnMes = 9
	RETURN "SEPTIEMBRE"
CASE tnMes = 10
	RETURN "OCTUBRE"
CASE tnMes = 11
	RETURN "NOVIEMBRE"
CASE tnMes = 12
	RETURN "DICIEMBRE"
ENDCASE
ENDPROC


************************************************************
OBJETO: cl_form_consart
************************************************************
*** PROPIEDADES ***
Height = 513
Width = 946
DoCreate = .T.
Caption = "Consulta de Artículos"
MaxButton = .T.
MinButton = .T.
WindowState = 2
Name = "cl_form_consart"
contenido.Name = "contenido"

*** METODOS ***
PROCEDURE Load
DODEFAULT()

CREATE CURSOR cur_Artic (	 ;
	idArticulo	integer		,;
	codArt		C(20)		,;
	descripcio	C(60)		,;
	razSoc		C(60)		,;
	descFam		C(60)		,;
	descSubFam	C(60)		,;
	descMarca	C(60)		,;
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
INDEX ON descripcio TAG descripcio 	ASCENDING ADDITIVE
INDEX ON razSoc 	TAG razSoc 		ASCENDING ADDITIVE
INDEX ON descFam 	TAG descFam 	ASCENDING ADDITIVE
INDEX ON descSubFam TAG descSubFam 	ASCENDING ADDITIVE
INDEX ON descMArca 	TAG descMarca	ASCENDING ADDITIVE
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
INDEX ON codArt 	TAG codArt 		ASCENDING ADDITIVE

ENDPROC
PROCEDURE Init
LOCAL lcSql
LOCAL oData
LOCAL loProg

loProg = CREATEOBJECT("_thermometer")

DODEFAULT()

lcSql = "select   	articulos.idArticulo, "
lcSql = lcSql + " 	articulos.codArt, "
lcSql = lcSql + " 	articulos.descripcio, "
lcSql = lcSql + " 	proveedor.razSoc, "
lcSql = lcSql + " 	familias.descripcio as descfam, "
lcSql = lcSql + " 	subfam.descripcio as descsubfam, "
lcSql = lcSql + "	marcas.descripcio as descMarca, "
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
lcSql = lcSql + "	  and articulos.fecBaja IS NULL "

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

loProg.show()

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
	REPLACE cur_Artic.descMarca		WITH cur_a.descMarca	ADDITIVE
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
	loProg.update((RECNO("cur_a") * 100) / RECCOUNT("cur_a"), "Leyendo artículos, espere por favor...")
	
	SELECT cur_a
	SKIP	
ENDDO

loProg.complete()

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
OBJETO: mov_stock
************************************************************
*** PROPIEDADES ***
Top = 488
Left = 248
Height = 17
Width = 37
Name = "mov_stock"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Anchor = 3
Caption = "Valor Buscado:"
Height = 15
Left = 10
Top = 23
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
Top = 19
Width = 792
Name = "txtValorBuscado"

*** METODOS ***


************************************************************
OBJETO: grdArtic
************************************************************
*** PROPIEDADES ***
Anchor = 15
Height = 292
Left = 7
Top = 48
Width = 936
alias_name = cur_Artic
list_controlsource = codArt,descripcio,descMarca,razSoc,prventaMax,prventaMin,prfinalMax,prfinalMin,descFam,descSubFam
lista_ancho_cols = 150,350,100,200,70,70,80,80,100,100
titulos_cabeceras = Código,Descripción,Marca,Proveedor,Venta May.,Venta Min.,c/IVA May.,c/IVA Min.,Familia,SubFamilia
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
thisform.contenido.txtExistencia.Value = thisform.mov_stock.get_exist_byart(cur_Artic.idArticulo, '')
ENDPROC
PROCEDURE press_enter
*Thisform.cbte_m2.contenido.btnGrabar.Enabled = .F.
*thisform.agregar_item()
ENDPROC


************************************************************
OBJETO: Clscerrar1
************************************************************
*** PROPIEDADES ***
Top = 457
Left = 843
Height = 44
Width = 45
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
Left = 476
Top = 371
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
Left = 476
Top = 395
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
Left = 715
Top = 395
Width = 130
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
Left = 715
Top = 418
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
Left = 603
ReadOnly = .T.
Top = 367
Width = 77
Name = "txtPrVtaMay"

*** METODOS ***


************************************************************
OBJETO: txtPrVtaMin
************************************************************
*** PROPIEDADES ***
Anchor = 36
Height = 21
Left = 603
ReadOnly = .T.
Top = 391
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
Left = 846
ReadOnly = .T.
Top = 390
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
Left = 846
ReadOnly = .T.
Top = 414
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
Left = 475
Top = 347
Width = 127
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: txtCostoRep
************************************************************
*** PROPIEDADES ***
Anchor = 36
Height = 21
Left = 603
ReadOnly = .T.
Top = 343
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
Left = 687
Top = 346
Width = 46
Name = "Clsetiqueta7"

*** METODOS ***


************************************************************
OBJETO: txtBonif1
************************************************************
*** PROPIEDADES ***
Anchor = 12
Height = 21
Left = 733
ReadOnly = .T.
Top = 343
Width = 52
Name = "txtBonif1"

*** METODOS ***


************************************************************
OBJETO: txtBonif2
************************************************************
*** PROPIEDADES ***
Anchor = 12
Height = 21
Left = 787
ReadOnly = .T.
Top = 343
Width = 52
Name = "txtBonif2"

*** METODOS ***


************************************************************
OBJETO: txtBonif3
************************************************************
*** PROPIEDADES ***
Anchor = 12
Height = 21
Left = 841
ReadOnly = .T.
Top = 343
Width = 48
Name = "txtBonif3"

*** METODOS ***


************************************************************
OBJETO: txtBonif4
************************************************************
*** PROPIEDADES ***
Anchor = 12
Height = 21
Left = 891
ReadOnly = .T.
Top = 343
Width = 51
Name = "txtBonif4"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta8
************************************************************
*** PROPIEDADES ***
Anchor = 6
Caption = "Precio de Lista Prov.:"
Height = 15
Left = 265
Top = 348
Width = 127
Name = "Clsetiqueta8"

*** METODOS ***


************************************************************
OBJETO: txtListaProv
************************************************************
*** PROPIEDADES ***
Anchor = 6
Height = 21
Left = 392
ReadOnly = .T.
Top = 345
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
Left = 266
Top = 395
Width = 113
Name = "Clsetiqueta9"

*** METODOS ***


************************************************************
OBJETO: txtMargenMay
************************************************************
*** PROPIEDADES ***
Anchor = 6
Height = 21
Left = 392
ReadOnly = .T.
Top = 391
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
Left = 265
Top = 419
Width = 106
Name = "Clsetiqueta10"

*** METODOS ***


************************************************************
OBJETO: txtMargenMin
************************************************************
*** PROPIEDADES ***
Anchor = 6
Height = 21
Left = 392
ReadOnly = .T.
Top = 414
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
Left = 266
Top = 372
Width = 99
Name = "Clsetiqueta11"

*** METODOS ***


************************************************************
OBJETO: txtAlicIVA
************************************************************
*** PROPIEDADES ***
Anchor = 6
Height = 21
Left = 392
ReadOnly = .T.
Top = 368
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
Left = 715
Top = 371
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
Left = 846
ReadOnly = .T.
Top = 366
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
MousePointer = 15
Top = 350
Width = 206
ToolTipText = "Ampliar Foto"
Name = "picFoto"

*** METODOS ***
PROCEDURE Click
DO FORM "frmamplifoto"

Thisform.contenido.grdArtic.SetFocus()
ENDPROC


************************************************************
OBJETO: Clsgenericcontainer1
************************************************************
*** PROPIEDADES ***
Anchor = 12
Top = 455
Left = 394
Width = 387
Height = 46
Name = "Clsgenericcontainer1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Alignment = 2
BackStyle = 1
Caption = "Acciones de Lista"
Height = 15
Left = 1
Top = 1
Width = 386
ForeColor = 255,255,255
BackColor = 0,64,128
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: btnMostrarPrecios
************************************************************
*** PROPIEDADES ***
Top = 18
Left = 3
Height = 24
Width = 139
Caption = "\<Todos los precios"
Name = "btnMostrarPrecios"

*** METODOS ***
PROCEDURE Click
DO FORM "frmVerTodosPr"

ENDPROC


************************************************************
OBJETO: btnEquivalencias
************************************************************
*** PROPIEDADES ***
Top = 18
Left = 146
Height = 24
Width = 139
Caption = "\<Equivalencias"
Name = "btnEquivalencias"

*** METODOS ***
PROCEDURE Click
LOCAL loForm

loForm = CREATEOBJECT("cls_equiv_viewer")
loForm.idArticulo = cur_Artic.idArticulo
loForm.codArt = cur_Artic.codArt
loForm.descripcio = cur_Artic.descripcio
loForm.cons_mostrador = .F.
loForm.leer_equivs()

loForm.hide()
loForm.show(1)

ENDPROC


************************************************************
OBJETO: Clsetiqueta13
************************************************************
*** PROPIEDADES ***
FontItalic = .F.
Anchor = 6
Caption = "Existencia:"
Height = 15
Left = 220
Top = 458
Width = 72
ForeColor = 255,0,0
Name = "Clsetiqueta13"

*** METODOS ***


************************************************************
OBJETO: txtExistencia
************************************************************
*** PROPIEDADES ***
FontItalic = .F.
Anchor = 6
Height = 21
Left = 291
ReadOnly = .T.
Top = 455
Width = 96
ForeColor = 255,0,0
isnumeric = .T.
Name = "txtExistencia"

*** METODOS ***


************************************************************
OBJETO: btnBuscar
************************************************************
*** PROPIEDADES ***
Top = 4
Left = 899
Anchor = 9
TabIndex = 3
Name = "btnBuscar"

*** METODOS ***
PROCEDURE Click
LOCAL lcSql
LOCAL oData
LOCAL loProg

loProg = CREATEOBJECT("_thermometer")

lcSql = "select   	articulos.idArticulo, "
lcSql = lcSql + " 	articulos.codArt, "
lcSql = lcSql + " 	articulos.descripcio, "
lcSql = lcSql + " 	proveedor.razSoc, "
lcSql = lcSql + " 	familias.descripcio as descfam, "
lcSql = lcSql + " 	subfam.descripcio as descsubfam, "
lcSql = lcSql + "	marcas.descripcio as descMarca, "
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

loProg.Show()

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
	REPLACE cur_Artic.descMarca		WITH cur_a.descMarca	ADDITIVE
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
	loProg.update((RECNO("cur_a") * 100) / RECCOUNT("cur_a"), "Buscando artículo, espere por favor...")
	
	SELECT cur_a
	SKIP	
ENDDO

USE IN cur_a

loProg.Complete()

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
OBJETO: btnActualizar
************************************************************
*** PROPIEDADES ***
Top = 457
Left = 797
Anchor = 12
Name = "btnActualizar"

*** METODOS ***
PROCEDURE Click
LOCAL lcSql
LOCAL oData, lnPosActual
LOCAL loProg

loProg = CREATEOBJECT("_thermometer")

SELECT cur_Artic
lnPosActual = RECNO("cur_Artic")

lcSql = "select   	articulos.idArticulo, "
lcSql = lcSql + " 	articulos.codArt, "
lcSql = lcSql + " 	articulos.descripcio, "
lcSql = lcSql + " 	proveedor.razSoc, "
lcSql = lcSql + " 	familias.descripcio as descfam, "
lcSql = lcSql + " 	subfam.descripcio as descsubfam, "
lcSql = lcSql + "	marcas.descripcio as descMarca, "
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

IF !(ALLTRIM(thisform.contenido.txtValorBuscado.Value) == "") THEN
	lcSql = lcSql + "     and (articulos.codArt like '%" + ALLTRIM(thisform.contenido.txtValorBuscado.value) + "%' "
	lcSql = lcSql + "         or articulos.descripcio like '%" + ALLTRIM(thisform.contenido.txtValorBuscado.value) + "%' "
	lcSql = lcSql + "         or proveedor.razSoc like '%" + ALLTRIM(thisform.contenido.txtvalorBuscado.value) + "%' "
	lcSql = lcSql + "         or familias.descripcio like '%" + ALLTRIM(thisform.contenido.txtvalorBuscado.value) + "%' "
	lcSql = lcSql + "         or subfam.descripcio like '%" + ALLTRIM(thisform.contenido.txtvalorBuscado.value) + "%' "
	lcSql = lcSql + "		  or marcas.descripcio like '%" + ALLTRIM(thisform.contenido.txtvalorBuscado.value) + "%' "
	lcSql = lcSql + "		  or articulos.observ like '%" + ALLTRIM(thisform.contenido.txtValorBuscado.Value) + "%')"
ENDIF

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

loProg.Show()

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
	REPLACE cur_Artic.descMarca		WITH cur_a.descMarca	ADDITIVE
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
	loProg.update((RECNO("cur_a") * 100) / RECCOUNT("cur_a"), "Leyendo artículos, espere por favor...")
		
	SELECT cur_a
	SKIP	
ENDDO

loProg.complete()

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

SELECT cur_Artic
IF RECCOUNT("cur_Artic") > 0 THEN
	GO lnPosActual

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
	thisform.contenido.txtExistencia.Value = thisform.mov_stock.get_exist_byart(cur_Artic.idArticulo, '')	
ENDIF

Thisform.contenido.grdArtic.Refresh()

ENDPROC


************************************************************
OBJETO: cl_form_consart
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: odbc_command
************************************************************
*** PROPIEDADES ***
commandtext = 
activeconnection = 
errormessage = 
Name = "odbc_command"

*** METODOS ***
PROCEDURE execute
LOCAL nRes

gcValueTrace = this.commandtext

IF ISNULL(this.commandtext) THEN
	this.ErrorMessage = "La propiedad commandText está vacía"
	errortrap(-1000, this.errorMessage, "The SQL command is not complete", "odbc_command.Execute", 0)
	RETURN .F.
ENDIF

nRes = SQLEXEC(this.activeconnection, this.commandtext)

IF nRes <> 1
	this.ErrorMessage = MESSAGE()
	errortrap(-1000, this.errorMessage, "The SQL command is not complete", "odbc_command.Execute", 0)
	RETURN .F.
ENDIF

RETURN .T.
ENDPROC
PROCEDURE addparameter
PARAMETERS tcName, tcValue, tlString, tlDateTime

LOCAL loDataFormat

loDataFormat = CREATEOBJECT("cls_dataformat")
IF tlString THEN
	this.commandtext = STRTRAN(this.commandtext, "?" + ALLTRIM(tcName), ;
		loDataFormat.str_sqlfmt(tcValue))
ELSE
	IF tlDateTime THEN
		this.commandtext = STRTRAN(this.commandtext, "?" + ALLTRIM(tcName),;
			loDataFormat.datetime_sqlfmt(tcValue))
	ELSE
		this.commandtext = STRTRAN(this.commandtext, "?" + ALLTRIM(tcName), ;
			tcValue)
	ENDIF
ENDIF

ENDPROC


************************************************************
OBJETO: odbc_result
************************************************************
*** PROPIEDADES ***
activeconnection = 
cursor_name = 
error_message = 
Name = "odbc_result"

*** METODOS ***
PROCEDURE openquery
PARAMETERS tc_CommandText

LOCAL lRes, activeconecstring 

gcValueTrace = tc_CommandText
IF ISNULL(tc_CommandText)
	This.error_message = "No se ha recibido la sentencia SQL a ejecutar. odbc_result.OpenQuery()"
	RETURN .F.
ENDIF

IF SQLEXEC(this.activeconnection, tc_CommandText, this.cursor_name) != 1
	_cliptext = tc_CommandText
	this.error_message = "Ha ocurrido un error al intentar ejecutar la consulta, revise la sintaxis, compile y vuelva a intentarlo. Para evaluar la consulta ingrese al motor de base de datos y presione CTRL+V para pegar y resvisar su sintaxis"	
	RETURN .F.
ENDIF

SELECT (this.cursor_name)
IF RECCOUNT() > 0
	GO TOP
ENDIF

RETURN .T.

ENDPROC
PROCEDURE close_query
USE IN (this.cursor_name)
ENDPROC
PROCEDURE addparameter
PARAMETERS tcSql, tcName, tcValue, tlString, tlDateTime

LOCAL loDataFormat
LOCAL lcResult

loDataFormat = CREATEOBJECT("cls_dataformat")
IF tlString THEN
	lcResult = STRTRAN(tcSql, "?" + ALLTRIM(tcName), ;
		loDataFormat.str_sqlfmt(tcValue))
ELSE
	IF tlDateTime THEN
		lcResult = STRTRAN(tcSql, "?" + ALLTRIM(tcName),;
			loDataFormat.datetime_sqlfmt(tcValue))
	ELSE
		lcResult = STRTRAN(tcSql, "?" + ALLTRIM(tcName), ;
			tcValue)
	ENDIF
ENDIF
RETURN lcResult
ENDPROC


