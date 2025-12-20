************************************************************
OBJETO: cls_buscacbte_cpas
************************************************************
*** PROPIEDADES ***
BorderStyle = 2
Height = 493
Width = 908
DoCreate = .T.
Caption = "Buscar comprobante origen"
Closable = .F.
idcomprac = 0
press_ok = .F.
idprov = 0
cbte = FC
sel_cbte = 
sel_letra = 
sel_ptovta = 
sel_numcbte = 
idoper = 0
Name = "cls_buscacbte_cpas"

*** METODOS ***
PROCEDURE leer_cbtes
LOCAL loRes
LOCAL lcSql

loRes = CREATEOBJECT("odbc_result")
lcSql = ""

lcSql = "SELECT comprascab.idCompraC, comprascab.idProv, "
lcSql = lcSql + "	comprascab.fecEmis, comprascab.fecVto, "
lcSql = lcSql + "	comprascab.cbte, comprascab.tipoDoc, comprascab.ptoVta, "
lcSql = lcSql + "	comprascab.numCbte, comprascab.saldo "
lcSql = lcSql + "FROM 	comprascab "
lcSql = lcSql + "WHERE	comprascab.idProv = " + ALLTRIM(STR(This.idProv)) + " "
lcSql = lcSql + "	AND comprascab.cbte = '" + ALLTRIM(This.cbte) + "' "
lcSql = lcSql + "	AND comprascab.idCompraC IN ( "
lcSql = lcSql + "		SELECT idCompraC "
lcSql = lcSql + "		FROM cc_prov "
lcSql = lcSql + "		WHERE cc_prov.idOper IN ( "
lcSql = lcSql + "			SELECT cc_prov.idOper "
lcSql = lcSql + "			FROM cc_prov "
lcSql = lcSql + "			GROUP BY idOper "
lcSql = lcSql + "			HAVING (SUM(cc_prov.impDebe) - SUM(cc_prov.impHaber)) <> 0)) "

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_cbtes"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN
ENDIF

SELECT cur_cbtes
GO TOP
DO WHILE !EOF("cur_cbtes")
	SELECT cbtes
	APPEND BLANK
	REPLACE cbtes.idCompraC WITH cur_cbtes.idCompraC
	REPLACE cbtes.idProv WITH cur_cbtes.idProv ADDITIVE
	REPLACE cbtes.fecEmis WITH cur_cbtes.fecEmis ADDITIVE
	REPLACE cbtes.fecVto WITH cur_cbtes.fecVto ADDITIVE
	REPLACE cbtes.cbte WITH ALLTRIM(cur_cbtes.cbte) ADDITIVE
	REPLACE cbtes.tipoDoc WITH ALLTRIM(cur_cbtes.tipoDoc) ADDITIVE
	REPLACE cbtes.ptoVta WITH REPLICATE("0", 4 - LEN(ALLTRIM(STR(cur_cbtes.ptoVta)))) + ALLTRIM(STR(cur_cbtes.ptoVta)) ADDITIVE
	REPLACE cbtes.numCbte WITH REPLICATE("0", 8 - LEN(ALLTRIM(STR(cur_cbtes.numCbte)))) + ALLTRIM(STR(cur_cbtes.numCbte)) ADDITIVE
	REPLACE cbtes.saldo WITH cur_cbtes.saldo ADDITIVE

	SELECT cur_cbtes
	SKIP
ENDDO

loRes.Close_Query()

SELECT cbtes
GO TOP
ENDPROC
PROCEDURE aceptar
LOCAL loRes
LOCAL lcSql

Thisform.press_ok = .T.
Thisform.idcomprac = cbtes.idCompraC
Thisform.sel_cbte = cbtes.cbte
Thisform.sel_letra = cbtes.tipoDoc
Thisform.sel_ptovta = cbtes.ptoVta
Thisform.sel_numcbte = cbtes.numCbte

loRes = CREATEOBJECT("odbc_result")
lcSql = "SELECT * FROM cc_prov "
lcSql = lcSql + "WHERE cc_prov.idCompraC = " + ALLTRIM(STR(cbtes.idCompraC))

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_tempo"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_tempo
IF RECCOUNT("cur_tempo") > 0 THEN
	Thisform.idOper = cur_tempo.idOper
ELSE
	Thisform.idOper = 0
ENDIF

loRes.Close_Query()

Thisform.Hide()
RETURN .T.
ENDPROC
PROCEDURE Init
SELECT cbtes
Thisform.grdCbtes.Alias_Name = "cbtes"
Thisform.grdCbtes.RecordSource = "cbtes"
Thisform.grdCbtes.List_ControlSource = "fecEmis,cbte,tipoDoc,ptoVta,numCbte,saldo"
Thisform.grdCbtes.Lista_Ancho_Cols = "100,70,70,100,100,70"
Thisform.grdCbtes.Titulos_Cabeceras = "Fecha,Comp.,Letra,Pto. Vta.,Número,Saldo"
Thisform.grdCbtes.generar_grid()

ENDPROC
PROCEDURE Load
DODEFAULT()

CREATE CURSOR cbtes (	;
	idCompraC int,;
	idProv int,;
	fecEmis D,;
	fecVto D,;
	cbte varchar(3),;
	tipoDoc varchar(1),;
	ptoVta varchar(4),;
	numCbte varchar(8),;
	saldo float(10, 2))
	
INDEX ON idCompraC TAG idCompraC ASCENDING
INDEX ON idProv TAG idProv ASCENDING ADDITIVE
INDEX ON fecEmis TAG fecEmis ASCENDING ADDITIVE
INDEX ON fecVto TAG fecVto ASCENDING ADDITIVE
INDEX ON cbte TAG cbte ASCENDING ADDITIVE
INDEX ON tipoDoc TAG tipoDoc ASCENDING ADDITIVE
INDEX ON ptoVta TAG ptoVta ASCENDING ADDITIVE
INDEX ON numCbte TAG numCbte ASCENDING ADDITIVE
INDEX ON saldo TAG saldo ASCENDING ADDITIVE
ENDPROC


************************************************************
OBJETO: grdCbtes
************************************************************
*** PROPIEDADES ***
Height = 445
Left = 2
Top = 2
Width = 902
Name = "grdCbtes"
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
PROCEDURE press_enter
Thisform.aceptar()
ENDPROC


************************************************************
OBJETO: btnAceptar
************************************************************
*** PROPIEDADES ***
Top = 448
Left = 813
Name = "btnAceptar"

*** METODOS ***
PROCEDURE Click
Thisform.aceptar()
ENDPROC


************************************************************
OBJETO: Clscerrar1
************************************************************
*** PROPIEDADES ***
Top = 448
Left = 860
Name = "Clscerrar1"

*** METODOS ***
PROCEDURE Click
Thisform.press_ok = .F.
Thisform.Hide()
ENDPROC


************************************************************
OBJETO: cls_buscacbte_cpas
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_form_saf_viewmov_prov
************************************************************
*** PROPIEDADES ***
DataSession = 1
BorderStyle = 2
Height = 519
Width = 873
DoCreate = .T.
Caption = "Movimientos a generar"
Name = "cls_form_saf_viewmov"

*** METODOS ***
PROCEDURE Init
DODEFAULT()

SELECT cur_Movs
thisform.grdMovimientos.RecordSource = "cur_Movs"
thisform.grdMovimientos.alias_name = "cur_Movs"
thisform.grdMovimientos.list_controlsource = "idOper,cbte,tipoDoc,ptoVta,numCbte,debe,haber"
thisform.grdMovimientos.lista_ancho_cols = "70,70,70,70,100,70,70"
thisform.grdMovimientos.titulos_cabeceras = "Operación,Comprob.,Tipo,Pto.Vta.,Número,Debe,Haber"
thisform.grdMovimientos.generar_grid()

SELECT cur_CCMovs
thisform.grdControl.RecordSource = "cur_CCMovs"
thisform.grdControl.alias_name = "cur_CCMovs"
thisform.grdControl.list_controlsource = "idOper,cbte,tipoDoc,ptoVta,numCbte,haber"
thisform.grdControl.lista_ancho_cols = "70,70,70,70,100,70,70"
thisform.grdControl.titulos_cabeceras = "Operación,Comprob.,Tipo,Pto.Vta.,Número,Importe"
thisform.grdControl.generar_grid()
ENDPROC


************************************************************
OBJETO: grdMovimientos
************************************************************
*** PROPIEDADES ***
Height = 207
Left = 2
TabIndex = 2
Top = 262
Width = 870
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdMovimientos"
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


************************************************************
OBJETO: btnSalir
************************************************************
*** PROPIEDADES ***
Top = 474
Left = 828
TabIndex = 3
Name = "btnSalir"

*** METODOS ***


************************************************************
OBJETO: grdControl
************************************************************
*** PROPIEDADES ***
Height = 207
Left = 2
TabIndex = 1
Top = 21
Width = 870
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdControl"
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


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Vista previa la vinculación de los comprobantes resultante"
Height = 15
Left = 5
Top = 243
Width = 355
TabIndex = 4
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Control de movimientos que se van a generar"
Height = 15
Left = 5
Top = 2
Width = 355
TabIndex = 5
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: cls_form_saf_viewmov_prov
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_saldo_a_favor_prov
************************************************************
*** PROPIEDADES ***
DataSession = 1
BorderStyle = 2
Height = 550
Width = 1010
DoCreate = .T.
Caption = "Compensación de Comprobantes"
idprov = 0
idcomprac = 0
idcc_prov = 0
Name = "cls_saldo_a_favor_prov"

*** METODOS ***
PROCEDURE cargar
LOCAL lcSql, loRes, lnIdOperAnt 

lcSql = ""
loRes = CREATEOBJECT("odbc_result")
lnIdOperAnt = 0

SELECT	*	;
FROM	cc_pv ;
WHERE	cc_pv.sel = .T. ;
ORDER BY cc_pv.fecEmis ;
INTO CURSOR cur_SelCbtes

SELECT cur_SelCbtes
IF RECCOUNT("cur_SelCbtes") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_SelCbtes")
	&& Si cur_SelCbtes.idCompraC es nulo, entonces, significa que el movimiento no tiene
	&& cabecera de compras vinculado, por lo tanto, se asume que es un ajuste de debito.
*!*		IF SUBSTR(cc_pv.nroCbte, 1, 2) == "NC" .OR. ;
*!*			SUBSTR(cc_pv.nroCbte, 1, 2) == "ACP" .OR.  ;
*!*			SUBSTR(cc_pv.nroCbte, 1, 2) == "OP" THEN
*!*		IF !ISNULL(cur_SelCbtes.idVentasC) THEN
*!*			lcSql = "select	SUM(cc_prov.impDebe) - SUM(cc_prov.impHaber) as saldo "
*!*			lcSql = lcSql + "from	cc_prov "
*!*			lcSql = lcSql + "where	idOper in (	"
*!*			lcSql = lcSql + "			select	idOper	"
*!*			lcSql = lcSql + "			from	cc_prov	"
*!*			lcSql = lcSql + "			where	cc_prov.idCompraC= " + ALLTRIM(STR(cur_SelCbtes.idVentasC)) + " "
*!*			lcSql = lcSql + "				and cc_prov.fecBaja IS NULL) "
*!*			lcSql = lcSql + "	and fecBaja IS NULL "
*!*			lcSql = lcSql + "group by idOper"
*!*		ELSE
		&& Pasa por acá si no tiene idVentaC asociado. Se da en el caso de los ajustes.
		lcSql = "select	*, ROUND((SUM(cc_prov.impDebe) - SUM(cc_prov.impHaber)),2) as saldo "
		lcSql = lcSql + "from	cc_prov "
		lcSql = lcSql + "where	idOper = " + ALLTRIM(STR(cur_SelCbtes.idOper)) + " "
		lcSql = lcSql + "	and (usuBaja IS NULL or usuBaja = '') "
		lcSql = lcSql + "group by idOper"
&&	ENDIF
	
	loRes.ActiveConnection = goConn.ActiveConnection
	loRes.Cursor_Name = "cur_tempo"
	
	IF !loRes.OpenQuery(lcSql) THEN
		MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
		RETURN .F.
	ENDIF
	
	SELECT cur_tempo
	IF cur_tempo.saldo <= 0 THEN
		MESSAGEBOX("El saldo de la(s) factura(s) seleccionada(s) no puede ser menor o igual que 0(cero)", 0+48, Thisform.Caption)
		loRes.Close_Query()
		thisform.hide()
		RETURN .F.
	ENDIF

	SELECT cur_cbtes
	APPEND BLANK
	REPLACE cur_cbtes.idcc_prov WITH cur_SelCbtes.idcc_prov
	REPLACE cur_cbtes.idCompraC WITH IIF(ISNULL(cur_SelCbtes.idCompraC), 0, cur_SelCbtes.idCompraC) ADDITIVE
	REPLACE cur_cbtes.idOper WITH cur_SelCbtes.idOper ADDITIVE
	REPLACE cur_cbtes.fecEmis WITH cur_SelCbtes.fecEmis ADDITIVE
	REPLACE cur_cbtes.fecVto WITH cur_SelCbtes.fecVto ADDITIVE
	REPLACE cur_cbtes.numCbte WITH cur_SelCbtes.nroCbte ADDITIVE
	REPLACE cur_cbtes.observ WITH cur_SelCbtes.observ ADDITIVE
	REPLACE cur_cbtes.saldo WITH cur_tempo.saldo ADDITIVE
	REPLACE cur_cbtes.aplicado WITH 0 ADDITIVE
	
	loRes.Close_Query()
	
	thisform.txtSaldoComp.Value = thisform.txtSaldoComp.Value + cur_cbtes.saldo

	SELECT cur_SelCbtes
	SKIP
ENDDO

SELECT cur_cbtes
IF RECCOUNT("cur_cbtes") > 0 THEN
	GO TOP
ENDIF

SELECT cur_cbtes
thisform.grdCbtes.RecordSource = "cur_cbtes"
thisform.grdCbtes.alias_name = "cur_cbtes"
thisform.grdCbtes.list_controlsource = "fecEmis,fecVto,numCbte,Saldo,Aplicado,observ"
thisform.grdCbtes.lista_ancho_cols = "150,150,150,100,100,300"
thisform.grdCbtes.titulos_cabeceras = "Fecha,Fecha Vto.,Comprobante,Saldo,Aplicado,Observaciones"
thisform.grdCbtes.generar_grid()

&& Ahora levanto los comprobantes disponibles para utilizar en la compensación
*!*	lcSql = "SELECT		idcc_prov, "
*!*	lcSql = lcSql + "	idProv, "
*!*	lcSql = lcSql + "	idOper, "
*!*	lcSql = lcSql + "	fecEmis, "
*!*	lcSql = lcSql + "	cbte, "
*!*	lcSql = lcSql + "	tipoDoc, "
*!*	lcSql = lcSql + "	ptoVta, "
*!*	lcSql = lcSql + "	nroCbte, "
*!*	lcSql = lcSql + "	impHaber, "
*!*	lcSql = lcSql + "	Saldos.Saldo, "
*!*	lcSql = lcSql + "FROM	cc_prov "
*!*	lcSql = lcSql + "WHERE	Cbte IN ('NC', 'ACP', 'OP') "
*!*	lcSql = lcSql + "	AND idProv = " + ALLTRIM(STR(Thisform.idProv))
*!*	lcSql = lcSql + "	AND idOper IN ( "
*!*	lcSql = lcSql + "		SELECT	idOper "
*!*	lcSql = lcSql + "  		FROM	cc_prov "
*!*	lcSql = lcSql + "  		WHERE	idProv = " + ALLTRIM(STR(thisform.idProv))
*!*	lcSql = lcSql + "  		GROUP BY idOper "
*!*	lcSql = lcSql + "		HAVING (ROUND(SUM(impDebe), 2) - ROUND(SUM(impHaber), 2)) < 0) "
*!*	lcSql = lcSql + "ORDER BY fecEmis"

*!*	lcSql = "SELECT		idcc_prov, "
*!*	lcSql = lcSql + "	idProv, "
*!*	lcSql = lcSql + "	cc_prov.idOper, "
*!*	lcSql = lcSql + "	fecEmis, "
*!*	lcSql = lcSql + "	cbte, "
*!*	lcSql = lcSql + "	tipoDoc, "
*!*	lcSql = lcSql + "	ptoVta, "
*!*	lcSql = lcSql + "	nroCbte, "
*!*	lcSql = lcSql + "	impHaber, "
*!*	lcSql = lcSql + "	observ, "
*!*	lcSql = lcSql + "	Saldos.Saldo "
*!*	lcSql = lcSql + "FROM	cc_prov "
*!*	lcSql = lcSql + "	LEFT JOIN (SELECT cc2.idOper, ROUND(SUM(cc2.impdebe - cc2.imphaber),2) as Saldo "
*!*	lcSql = lcSql + "       		FROM cc_prov AS cc2 "
*!*	lcSql = lcSql + "       		WHERE (cc2.usubaja is null OR cc2.usubaja = '') "
*!*	lcSql = lcSql + "				GROUP BY cc2.idoper "
*!*	lcSql = lcSql + "				HAVING (ROUND(SUM(cc2.impDebe), 2) - ROUND(SUM(cc2.impHaber), 2)) < 0) AS Saldos ON cc_prov.idoper = Saldos.idoper "
*!*	lcSql = lcSql + "	INNER JOIN (SELECT MAX(cc3.fecEmis) AS fecha, idOper "
*!*	lcSql = lcSql + "				FROM cc_prov AS cc3 "
*!*	lcSql = lcSql + "				WHERE (cc3.usubaja is null OR cc3.usubaja = '') "
*!*	lcSql = lcSql + "				GROUP BY cc3.idOper) AS Cbtes ON cc_prov.fecEmis = Cbtes.fecha AND cc_prov.idoper = Cbtes.idoper "
*!*	lcSql = lcSql + "WHERE	Cbte IN ('NC', 'ACP', 'OP') "
*!*	lcSql = lcSql + "	AND idProv = " + ALLTRIM(STR(Thisform.idProv)) + " "
*!*	lcSql = lcSql + "	AND Saldos.Saldo < 0 "
*!*	lcSql = lcSql + "	AND(usubaja is null OR usubaja = '') "
*!*	lcSql = lcSql + "ORDER BY fecEmis"

*!*	loRes.ActiveConnection = goConn.ActiveConnection
*!*	loRes.Cursor_Name = "tmp_cbtes"
*!*	loRes.OpenQuery(lcSql)

SELECT * FROM cc_pv WHERE Saldo < 0 INTO CURSOR cur_Saldos

SELECT cur_Saldos
IF RECCOUNT("cur_Saldos") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_Saldos")
	SELECT cur_CbteDisp	
	APPEND BLANK
	REPLACE marcado WITH .F.
	REPLACE cur_CbteDisp.idcc_prov WITH cur_Saldos.idcc_prov ADDITIVE
	REPLACE cur_CbteDisp.idOper WITH cur_Saldos.idOper ADDITIVE
	REPLACE cur_CbteDisp.fecEmis WITH cur_Saldos.fecEmis ADDITIVE
	REPLACE cur_CbteDisp.cbte WITH cur_Saldos.cbte ADDITIVE
	REPLACE cur_CbteDisp.tipoDoc WITH cur_Saldos.tipoDoc ADDITIVE
	REPLACE cur_CbteDisp.ptoVta WITH cur_Saldos.ptoVta ADDITIVE 
	REPLACE cur_CbteDisp.numCbte WITH cur_Saldos.numCbte ADDITIVE   
	REPLACE cur_CbteDisp.observ WITH cur_Saldos.observ ADDITIVE	
	
	IF lnIdOperAnt != cur_Saldos.idOper  THEN 
		REPLACE cur_CbteDisp.importe WITH cur_Saldos.impHaber - (cur_Saldos.Saldo * -1)ADDITIVE
		REPLACE cur_CbteDisp.restante WITH cur_Saldos.Saldo ADDITIVE
	ELSE 
		REPLACE cur_CbteDisp.importe WITH 0 ADDITIVE
		REPLACE cur_CbteDisp.restante WITH cur_Saldos.impHaber * -1 ADDITIVE
	ENDIF 

	lnIdOperAnt = cur_Saldos.idOper
		
	SELECT cur_Saldos
	SKIP
ENDDO

SELECT cur_CbteDisp
IF RECCOUNT("cur_CbteDisp") > 0 THEN
	GO TOP
ENDIF

&& Asigno los comprobantes disponible a la grilla
SELECT cur_CbteDisp
Thisform.grdCbteDisp.RecordSource = "cur_CbteDisp"
Thisform.grdCbteDisp.list_controlsource = "marcado,fecEmis,cbte,tipoDoc,ptoVta,numCbte,restante,observ"
Thisform.grdCbteDisp.lista_ancho_cols = "50,250,70,70,70,100,100,200"
Thisform.grdCbteDisp.titulos_cabeceras = "Sel.,Fecha,Cbte,Tipo,Pto. Vta.,Número,Saldo,Observaciones"
&&Thisform.grdCbteDisp.Columns[3].Alignment = 2
Thisform.grdCbteDisp.Columns[1].ReadOnly = .F.
Thisform.grdCbteDisp.generar_grid()



ENDPROC
PROCEDURE grabar
LOCAL loCommand, lcSql, lnIdCC_Prov 
LOCAL loRes, lnIdCondPago, lnIdSitIVA
LOCAL loDT

loCommand = CREATEOBJECT("odbc_command")
loRes = CREATEOBJECT("odbc_result")
loDT = CREATEOBJECT("datetime")
lcSql = ""
lnIdCC_Prov = 0

lnIdCondPago = 0
lnIdSitIVA = 0

goConn.BeginTransaction()

SELECT cur_CCMovs
GO TOP

DO WHILE !EOF("cur_CCMovs")
	lcSql = "select * from cc_prov where idCC_Prov = " + ALLTRIM(STR(cur_CCMovs.idCC_Prov))
	loRes.ActiveConnection = goConn.ActiveConnection
	loRes.Cursor_Name = "cur_x"
	
	IF !loRes.OpenQuery(lcSql) THEN
		MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
		goConn.Rollback()
		RETURN .F.
	ENDIF
	
	SELECT cur_x
	IF RECCOUNT("cur_x") > 0 THEN
		lnIdCondPago = cur_x.idCondPago
		lnIdSitIVA = cur_x.idSitIVA
	ENDIF
	
	loRes.Close_Query()
	
	IF !cur_CCMovs.isUpd THEN
		lnIdCC_Prov = goConn.getNextID("cc_prov", "idCC_Prov")

		lcSql = "insert into cc_prov ( "
		lcSql = lcSql + "	idCC_Prov, "
		lcSql = lcSql + "	idProv, "
		lcSql = lcSql + "	cbte, "
		lcSql = lcSql + "	tipoDoc, "
		lcSql = lcSql + "	ptoVta, "
		lcSql = lcSql + "	nroCbte, "
		lcSql = lcSql + "	fecEmis, "
		lcSql = lcSql + "	fecVto, "
		lcSql = lcSql + "	impDebe, "
		lcSql = lcSql + "	impHaber, "
		lcSql = lcSql + "	idOper, "
		lcSql = lcSql + "	observ, "
		lcSql = lcSql + "	idCondPago, "
		lcSql = lcSql + "	idSitIVA, "
		lcSql = lcSql + "	usuAlta, "
		lcSql = lcSql + "	fecAlta, "
		lcSql = lcSql + "	idHostAlta) "
		lcSql = lcSql + "VALUES ( "
		lcSql = lcSql + ALLTRIM(STR(lnIdCC_Prov)) + ", "
		lcSql = lcSql + ALLTRIM(STR(thisform.idprov)) + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_CCMovs.cbte) + "', "
		lcSql = lcSql + "'" + ALLTRIM(cur_CCMovs.tipoDoc) + "', "
		lcSql = lcSql + ALLTRIM(STR(INT(VAL(cur_CCMovs.ptoVta)))) + ", "
		lcSql = lcSql + ALLTRIM(STR(INT(VAL(cur_CCMovs.numCbte)))) + ", "
		lcSql = lcSql + loDT.toMySql(cur_CCMovs.fecEmis) + ", "
		lcSql = lcSql + loDT.toMySql(cur_CCMovs.fecEmis) + ", "
		lcSql = lcSql + "0, "
		lcSql = lcSql + ALLTRIM(STR(cur_CCMovs.haber, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_CCMovs.idOper)) + ", "
		lcSql = lcSql + "'', "
		lcSql = lcSql + ALLTRIM(STR(lnIdCondPago)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnIdSitIVA)) + ", "
		lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
		lcSql = lcSql + loDT.getDateTime() + ", "
		lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "')"
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			MESSAGEBOX(loCommand.ErrorMessage, 0+48,  Thisform.Caption)
			goConn.Rollback()
			RETURN .F.
		ENDIF
		
		&& cuando idCompraC es nulo, entonces, no hay saldo para actualizar en comprascab
		IF !ISNULL(cur_CCMovs.idCompraC) THEN
			&& Actualizo el saldo correspondiente a la factura que se está cancelando.
			lcSql = "update comprascab set saldo = saldo - " + ALLTRIM(STR(cur_CCMovs.haber, 10, 2)) + " "
			lcSql = lcSql + "where idCompraC = " + ALLTRIM(STR(cur_CCMovs.idCompraC))
			
			loCommand.ActiveConnection = goConn.ActiveConnection
			loCommand.CommandText = lcSql
			
			IF !loCommand.Execute() THEN
				MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
				goConn.Rollback()
				RETURN .F.
			ENDIF
		ENDIF
	ELSE
*!*			lcSql = "update cc_prov "
*!*			lcSql = lcSql + "SET impHaber = " + ALLTRIM(STR(cur_CCMovs.haber, 10, 2)) + ", "
*!*			lcSql = lcSql + " 	usuModi = '" + ALLTRIM(gcCodUsu) + "', "
*!*			lcSql = lcSql + "	fecModi = " + loDT.getDateTime() + ", "
*!*			lcSql = lcSql + "	idHostModi = '" + ALLTRIM(SYS(0)) + "' "
*!*			lcSql = lcSql + "where cc_prov.idCC_Prov = " + ALLTRIM(STR(cur_CCMovs.idCC_Prov))
*!*			&&lcSql = lcSql + "	and cc_cli.cbte = 'RC'"
*!*					
*!*			loCommand.ActiveConnection = goConn.ActiveConnection
*!*			loCommand.CommandText = lcSql
*!*			
*!*			IF !loCommand.Execute() THEN
*!*				MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
*!*				goConn.Rollback()
*!*				RETURN .F.
*!*			ENDIF
	ENDIF
	
	SELECT cur_CCMovs
	SKIP
ENDDO

&& Elimino los saldos que fueron utilizados o los actualizo en caso que 
SELECT cur_tempo
GO TOP

DO WHILE !EOF("cur_tempo")
	IF cur_tempo.importe = 0 THEN 
		IF cur_tempo.restante = 0 THEN
			lcSql = "delete from cc_prov where cc_prov.idCC_Prov = " + ALLTRIM(STR(cur_tempo.idCC_Prov))
		ELSE
			lcSql = "update cc_prov "
			lcSql = lcSql + "SET impHaber = " + ALLTRIM(STR(cur_tempo.restante, 10, 2)) + ", "
			lcSql = lcSql + " 	usuModi = '" + ALLTRIM(gcCodUsu) + "', "
			lcSql = lcSql + "	fecModi = " + loDT.getDateTime() + ", "
			lcSql = lcSql + "	idHostModi = '" + ALLTRIM(SYS(0)) + "' "
			lcSql = lcSql + "where cc_prov.idCC_Prov = " + ALLTRIM(STR(cur_tempo.idCC_Prov))	
		ENDIF
	ELSE 
		IF cur_tempo.restante = 0 THEN 
			lcSql = "update cc_prov "
			lcSql = lcSql + "SET impHaber = " + ALLTRIM(STR(cur_tempo.importe, 10, 2)) + ", "
			lcSql = lcSql + " 	usuModi = '" + ALLTRIM(gcCodUsu) + "', "
			lcSql = lcSql + "	fecModi = " + loDT.getDateTime() + ", "
			lcSql = lcSql + "	idHostModi = '" + ALLTRIM(SYS(0)) + "' "
			lcSql = lcSql + "where cc_prov.idCC_Prov = " + ALLTRIM(STR(cur_tempo.idCC_Prov))	
		ELSE 
			lcSql = "update cc_prov "
			lcSql = lcSql + "SET impHaber = " + ALLTRIM(STR(cur_tempo.importe + cur_tempo.restante, 10, 2)) + ", "
			lcSql = lcSql + " 	usuModi = '" + ALLTRIM(gcCodUsu) + "', "
			lcSql = lcSql + "	fecModi = " + loDT.getDateTime() + ", "
			lcSql = lcSql + "	idHostModi = '" + ALLTRIM(SYS(0)) + "' "
			lcSql = lcSql + "where cc_prov.idCC_Prov = " + ALLTRIM(STR(cur_tempo.idCC_Prov))	
		ENDIF 
	ENDIF 
	
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute() THEN
		goConn.Rollback()
		MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
		RETURN .F.
	ENDIF

	SELECT cur_tempo
	SKIP
ENDDO

goConn.Commit()

RETURN .T.
ENDPROC
PROCEDURE compensar
LOCAL lnResto, loForm

lnResto = 0	

SELECT * FROM cur_CbteDisp WHERE cur_CbteDisp.marcado = .T. ;
INTO CURSOR cur_tempo READWRITE

UPDATE cur_tempo SET cur_tempo.restante = cur_tempo.restante * -1

SELECT cur_tempo
GO TOP
DO WHILE !EOF("cur_tempo")
	lnResto = lnResto + cur_tempo.restante
	
	SELECT cur_tempo
	SKIP
ENDDO

SELECT cur_cbtes
GO TOP

SELECT cur_tempo
GO TOP

DO WHILE !EOF("cur_tempo")	
	IF lnResto <= 0 THEN
		EXIT 
	ENDIF
	
	DO WHILE !EOF("cur_cbtes")
		IF cur_tempo.restante > 0 THEN
			SELECT cur_Movs
			APPEND BLANK
			REPLACE cur_Movs.idOper WITH cur_cbtes.idOper 
			REPLACE cur_Movs.fecEmis WITH cur_cbtes.fecEmis ADDITIVE
			REPLACE cur_Movs.cbte WITH SUBSTR(cur_cbtes.numCbte, 1, 2) ADDITIVE
			REPLACE cur_Movs.tipoDoc WITH SUBSTR(cur_cbtes.numCbte, 4, 1) ADDITIVE
			REPLACE cur_Movs.ptoVta WITH SUBSTR(cur_cbtes.numCbte, 6, 4) ADDITIVE
			REPLACE cur_Movs.numCbte WITH SUBSTR(cur_cbtes.numCbte, 11, 8) ADDITIVE
			REPLACE cur_Movs.debe WITH cur_cbtes.saldo ADDITIVE
			REPLACE cur_Movs.haber WITH 0 ADDITIVE
			
			SELECT cur_Movs
			APPEND BLANK
			REPLACE cur_Movs.idOper WITH cur_cbtes.idOper
			REPLACE cur_Movs.fecEmis WITH cur_cbtes.fecEmis ADDITIVE
			REPLACE cur_Movs.cbte WITH cur_tempo.cbte ADDITIVE
			REPLACE cur_Movs.tipoDoc WITH cur_tempo.tipoDoc ADDITIVE
			REPLACE cur_Movs.ptoVta WITH cur_tempo.ptoVta ADDITIVE
			REPLACE cur_movs.numCbte WITH cur_tempo.numCbte ADDITIVE
			REPLACE cur_Movs.debe WITH 0 ADDITIVE
						
			&& Grabo el movimiento a generar en la base de datos física a parte
			SELECT cur_CCMovs
			APPEND BLANK
			REPLACE cur_CCMovs.idCC_Prov WITH cur_cbtes.idCC_Prov
			REPLACE cur_CCMovs.idOper WITH cur_cbtes.idOper ADDITIVE
			&&REPLACE cur_CCMovs.idCompraC WITH cur_tempo.idCompraC ADDITIVE
			REPLACE cur_CCMovs.fecEmis WITH cur_tempo.fecEmis ADDITIVE
			REPLACE cur_CCMovs.cbte WITH cur_tempo.cbte ADDITIVE
			REPLACE cur_CCMovs.tipoDoc WITH cur_tempo.tipoDoc ADDITIVE
			REPLACE cur_CCMovs.ptoVta WITH cur_tempo.ptoVta ADDITIVE
			REPLACE cur_CCMovs.numCbte WITH cur_tempo.numCbte ADDITIVE
			REPLACE cur_CCMovs.debe WITH 0 ADDITIVE
			
			IF cur_cbtes.saldo <= lnResto THEN
				IF cur_cbtes.saldo <= cur_tempo.restante THEN
					SELECT cur_Movs
					REPLACE cur_Movs.haber WITH cur_cbtes.saldo ADDITIVE
					
					SELECT cur_CCMovs
					REPLACE cur_CCMovs.haber WITH cur_cbtes.saldo ADDITIVE
					REPLACE cur_CCMovs.isUpd WITH .F. ADDITIVE
					
					lnResto = lnResto - cur_cbtes.saldo
										
					SELECT cur_tempo
					LOCK()
					REPLACE cur_tempo.restante WITH cur_tempo.restante - cur_cbtes.saldo
					UNLOCK
					
					SELECT cur_cbtes
					LOCK()
					REPLACE cur_cbtes.aplicado WITH cur_cbtes.aplicado + cur_cbtes.saldo
					REPLACE cur_cbtes.saldo WITH 0
					UNLOCK
				ELSE
					SELECT cur_Movs
					REPLACE cur_Movs.haber WITH cur_tempo.restante ADDITIVE
					
					SELECT cur_CCMovs
					REPLACE cur_CCMovs.haber WITH cur_tempo.restante ADDITIVE
					REPLACE cur_CCMovs.isUpd WITH .F. ADDITIVE
					
					lnResto = lnResto - cur_tempo.restante
					
					SELECT cur_cbtes
					LOCK()
					REPLACE cur_cbtes.aplicado WITH cur_cbtes.aplicado + cur_tempo.restante
					REPLACE cur_cbtes.saldo WITH cur_cbtes.saldo - cur_tempo.restante
					UNLOCK
					
					SELECT cur_tempo
					LOCK()
					REPLACE cur_tempo.restante WITH 0
					UNLOCK			
					
					EXIT		
				ENDIF
			ELSE
				* Antes estaba asignando al haber lnResto
				SELECT cur_Movs
				REPLACE cur_Movs.haber WITH cur_tempo.restante ADDITIVE
				
				SELECT cur_CCMovs
				REPLACE cur_CCMovs.haber WITH cur_tempo.restante ADDITIVE
				REPLACE cur_CCMovs.isUpd WITH .F. ADDITIVE
				
				lnResto = lnResto - cur_tempo.restante
				
				SELECT cur_cbtes
				LOCK()
				* REPLACE cur_cbtes.saldo WITH cur_cbtes.saldo - lnResto
				REPLACE cur_cbtes.aplicado WITH cur_cbtes.aplicado + cur_tempo.restante
				REPLACE cur_cbtes.saldo WITH cur_cbtes.saldo - cur_tempo.restante
				UNLOCK
				
				SELECT cur_tempo
				LOCK()
				REPLACE cur_tempo.restante WITH 0
				UNLOCK
				
				IF cur_cbtes.saldo > 0 THEN
					EXIT
				ENDIF
			ENDIF
		ENDIF
			
		SELECT cur_cbtes
		SKIP
	ENDDO

	SELECT cur_tempo
	SKIP
ENDDO

IF lnResto > 0 THEN
	SELECT cur_tempo
	SKIP -1
	
	SELECT cur_Movs
	APPEND BLANK
	REPLACE cur_Movs.idOper WITH cur_tempo.idOper ADDITIVE
	REPLACE cur_Movs.fecEmis WITH cur_tempo.fecEmis ADDITIVE
	REPLACE cur_Movs.cbte WITH cur_tempo.cbte ADDITIVE
	REPLACE cur_Movs.tipoDoc WITH cur_tempo.tipoDoc ADDITIVE
	REPLACE cur_Movs.ptoVta WITH cur_tempo.ptoVta ADDITIVE
	REPLACE cur_Movs.numCbte WITH cur_tempo.numCbte ADDITIVE
	REPLACE cur_Movs.debe WITH 0 ADDITIVE
	REPLACE cur_Movs.haber WITH cur_tempo.importe + lnResto ADDITIVE
	REPLACE cur_Movs.isUpd WITH .T. ADDITIVE

	&& Grabo el movimiento a generar en la base de datos física a parte
	SELECT cur_CCMovs
	APPEND BLANK
	REPLACE cur_CCMovs.idCC_Prov WITH cur_tempo.idCC_Prov
	REPLACE cur_CCMovs.idOper WITH cur_tempo.idOper ADDITIVE
	REPLACE cur_CCMovs.fecEmis WITH cur_tempo.fecEmis ADDITIVE
	REPLACE cur_CCMovs.cbte WITH cur_tempo.cbte ADDITIVE
	REPLACE cur_CCMovs.tipoDoc WITH cur_tempo.tipoDoc ADDITIVE
	REPLACE cur_CCMovs.ptoVta WITH cur_tempo.ptoVta ADDITIVE
	REPLACE cur_CCMovs.numCbte WITH cur_tempo.numCbte ADDITIVE
	REPLACE cur_CCMovs.debe WITH 0 ADDITIVE
	REPLACE cur_CCMovs.haber WITH cur_tempo.importe + lnResto ADDITIVE
	REPLACE cur_CCMovs.isUpd WITH .T. ADDITIVE
ENDIF

SELECT cur_CCMovs
GO TOP

SELECT cur_Movs
GO TOP

loForm = CREATEOBJECT("cls_form_saf_viewmov_prov")
loForm.show()

RETURN .T.
ENDPROC
PROCEDURE validar
LOCAL lnCantSel, lnImporte, lnImputado

lnCantSel = 0
lnImporte = 0.00
lnImputado = Thisform.txtImpTot.Value

SELECT cur_cbtes
lnCantSel = RECCOUNT("cur_cbtes")

IF lnCantSel  = 0 THEN
	MESSAGEBOX("Debe seleccionar al menos un comprobante para aplicar saldos negativos", 0+48, Thisform.Caption)
	RETURN .F.
ELSE 
	GO TOP
ENDIF

DO WHILE !EOF("cur_cbtes")
	IF (lnCantSel > 1) .AND. lnImputado <= 0 THEN
		MESSAGEBOX("La compensación no es válida. Se seleccionaron más comprobantes de los que se pueden cancelar con los saldos elegidos.", 0+48, Thisform.Caption)
		RETURN .F.
	ELSE
		lnImputado = lnImputado - cur_cbtes.saldo
	ENDIF
	
	SELECT cur_cbtes
	SKIP
ENDDO

SELECT cur_cbtes
IF RECCOUNT("cur_cbtes") > 0 THEN
	GO TOP
ENDIF

RETURN .T.
ENDPROC
PROCEDURE validar_selnc
lnCantSel = 0
lnImporte = 0.00
lnImputado = thisform.txtSaldoComp.Value

SELECT * FROM cur_CbteDisp WHERE marcado = .T. ;
INTO CURSOR cur_x

SELECT cur_x
lnCantSel = RECCOUNT("cur_x")
USE IN cur_x

SELECT cur_CbteDisp
IF lnCantSel = 0 THEN
	MESSAGEBOX("Debe seleccionar al menos un saldo negativo para aplicar a los comprobantes", 0+48, Thisform.Caption)
	RETURN .F.
ELSE 
	GO TOP
ENDIF

DO WHILE !EOF("cur_CbteDisp")
	IF cur_CbteDisp.marcado THEN
		IF (lnCantSel > 1) .AND. lnImputado <= 0 THEN
			MESSAGEBOX("La compensación no es válida. Se seleccionaron más saldos de los necesarios para cancelar los comprobantes marcados.", 0+48, Thisform.Caption)
			RETURN .F.
		ELSE
			lnImputado = lnImputado - (cur_CbteDisp.restante * -1)
		ENDIF
	ENDIF

	SELECT cur_CbteDisp
	SKIP
ENDDO

SELECT cur_CbteDisp
IF RECCOUNT("cur_CbteDisp") > 0 THEN
	GO TOP
ENDIF

RETURN .T.
ENDPROC
PROCEDURE Destroy
USE IN cur_cbtes 
USE IN cur_CbteDisp 
USE IN cur_Movs 
USE IN cur_CCMovs 
ENDPROC
PROCEDURE Init
DODEFAULT()

thisform.btnGrabar.Enabled = .F.
thisform.btnAceptar.Enabled = .T.

ENDPROC
PROCEDURE Load
LOCAL lcSql, loRes

lcSql = ""
loRes = CREATEOBJECT("odbc_result")

DODEFAULT()

&& Este cursor tiene los comprobantes a compensar
CREATE CURSOR cur_cbtes (	;
	idCC_Prov	int,;
	idCompraC	int null,;
	idOper		int,;
	fecEmis		datetime,;
	fecVto		datetime,;
	numCbte		varchar(20),;
	observ		varchar(254),;
	saldo		float(10,2),;
	aplicado	float(10,2))	


&& Este cursor tiene los comprobantes disponible para compensar los comprobantes
CREATE CURSOR cur_CbteDisp (	;
	marcado		l,;
	idCC_Prov	int,;
	IdOper		int,;
	fecEmis		datetime,;
	cbte		varchar(3),;
	tipoDoc		varchar(1),;
	ptoVta		varchar(4),;
	numCbte		varchar(8),;
	observ		varchar(254),;
	importe		float(10, 2),;
	restante	float(10, 2))
	

&& En este cursor se graba un borrador de los movimientos a generar en las
&& cuentas corrientes.
CREATE CURSOR cur_Movs (	;
	idOper		int,;		
	fecEmis		datetime,;
	cbte		varchar(3),;
	tipoDoc		varchar(1),;
	ptoVta		varchar(4),;
	numCbte		varchar(8),;
	debe		float(10, 2),;
	haber		float(10, 2),;
	isUpd		l)
	
&& Este cursor graba los movimientos puntuales que hay que generar en la tabla cc_cli de la
&& base de datos
CREATE CURSOR cur_CCMovs (	;
	idCC_Prov	int,;
	idOper		int,;
	idCompraC	int null,;		
	fecEmis		datetime,;
	cbte		varchar(3),;
	tipoDoc		varchar(1),;
	ptoVta		varchar(4),;
	numCbte		varchar(8),;
	debe		float(10, 2),;
	haber		float(10, 2),;
	isUpd		l)	
ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Comprobantes a aplicar"
Height = 15
Left = 8
Top = 10
Width = 144
TabIndex = 6
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: grdCbtes
************************************************************
*** PROPIEDADES ***
Height = 190
Left = 8
TabIndex = 1
Top = 27
Width = 996
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdCbtes"
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


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Saldos Negativos"
Height = 15
Left = 9
Top = 260
Width = 227
TabIndex = 7
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: grdCbteDisp
************************************************************
*** PROPIEDADES ***
Height = 190
Left = 8
TabIndex = 2
Top = 279
Width = 996
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdCbteDisp"
COLUMN1.Header1.Name = "Header1"
COLUMN1.Text1.Alignment = 2
COLUMN1.Text1.Name = "Text1"
COLUMN1.Alignment = 2
COLUMN1.CurrentControl = "Clscheckbox1"
COLUMN1.Sparse = .F.
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


************************************************************
OBJETO: Clscheckbox1
************************************************************
*** PROPIEDADES ***
Top = 23
Left = 37
Alignment = 0
Centered = .T.
Caption = ""
Name = "Clscheckbox1"

*** METODOS ***
PROCEDURE InteractiveChange
SELECT cur_CbteDisp

IF this.Value THEN
	thisform.txtImpTot.Value = thisform.txtImpTot.Value + (cur_CbteDisp.restante * -1)
ELSE
	thisform.txtImpTot.Value = thisform.txtImpTot.Value - (cur_CbteDisp.restante * -1)
ENDIF
ENDPROC


************************************************************
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 501
Left = 958
TabIndex = 5
Name = "btnCerrar"

*** METODOS ***


************************************************************
OBJETO: btnGrabar
************************************************************
*** PROPIEDADES ***
Top = 501
Left = 910
TabIndex = 4
Name = "btnGrabar"

*** METODOS ***
PROCEDURE Click
thisform.grabar()
thisform.Release()
ENDPROC


************************************************************
OBJETO: btnAceptar
************************************************************
*** PROPIEDADES ***
Top = 501
Left = 9
TabIndex = 3
Name = "btnAceptar"

*** METODOS ***
PROCEDURE Click
SELECT cur_CCMovs
ZAP

SELECT cur_Movs
ZAP

IF !thisform.validar() THEN
	RETURN .F.
ENDIF

IF !Thisform.validar_selnc() THEN
	RETURN .F.
ENDIF

IF thisform.compensar() THEN
	thisform.btnGrabar.Enabled = .T.
	thisform.btnAceptar.Enabled = .F.
	thisform.grdCbteDisp.Enabled = .F.
	Thisform.grdCbtes.Refresh()
	Thisform.grdCbteDisp.Refresh()
	Thisform.btnGrabar.SetFocus()
ENDIF

ENDPROC


************************************************************
OBJETO: CLSETIQUETA3
************************************************************
*** PROPIEDADES ***
Caption = "Total comprobantes:"
Height = 15
Left = 8
Top = 228
Width = 120
Name = "CLSETIQUETA3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Tota Saldos:"
Height = 15
Left = 9
Top = 478
Width = 164
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: txtSaldoComp
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 128
ReadOnly = .T.
TabStop = .F.
Top = 225
Width = 113
isnumeric = .T.
Name = "txtSaldoComp"

*** METODOS ***


************************************************************
OBJETO: txtImpTot
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 82
ReadOnly = .T.
TabStop = .F.
Top = 476
Width = 113
isnumeric = .T.
Name = "txtImpTot"

*** METODOS ***


************************************************************
OBJETO: cls_saldo_a_favor_prov
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_ajuste_ccprov
************************************************************
*** PROPIEDADES ***
Height = 235
Width = 540
DoCreate = .T.
Caption = "Ajuste de Cuenta Corriente Proveedores"
cbte = 
idcc_prov = 0
idprov = 0
idoperacion = 0
importe = 0.00
nrocbte = 
saldo = 0.00
tipodoc = 
ptovta = 
idcomprascab = -1
idsitiva = 0
idcondpago = .F.
Name = "cls_ajuste_ccprov"

*** METODOS ***
PROCEDURE Activate
DODEFAULT()

thisform.contenedor.txtcbte.Value = thisform.cbte
thisform.contenedor.txttipo.Value = thisform.tipodoc
thisform.contenedor.txtnrocbte.Value = thisform.nrocbte
thisform.contenedor.txtimporte.Value = thisform.importe

thisform.contenedor.cmbajuste.AddItem("Crédito",1)
thisform.contenedor.cmbajuste.AddItem("Débito",2)
thisform.contenedor.txtimp.Value = 0.00
thisform.contenedor.cmbajuste.SetFocus()


ENDPROC


************************************************************
OBJETO: Contenedor
************************************************************
*** PROPIEDADES ***
Top = 0
Left = 0
Width = 540
Height = 300
BackColor = 241,236,235
Name = "Contenedor"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Aplicado a comprobante"
Height = 15
Left = 13
Top = 17
Width = 156
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Importe"
Height = 15
Left = 334
Top = 17
Width = 51
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: txtimporte
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Left = 384
Top = 12
Name = "txtimporte"

*** METODOS ***


************************************************************
OBJETO: txtcbte
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 155
Top = 12
Width = 37
Name = "txtcbte"

*** METODOS ***


************************************************************
OBJETO: txttipo
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 195
Top = 12
Width = 28
Name = "txttipo"

*** METODOS ***


************************************************************
OBJETO: txtnrocbte
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 226
Top = 12
Width = 86
Name = "txtnrocbte"

*** METODOS ***


************************************************************
OBJETO: Clslinea1
************************************************************
*** PROPIEDADES ***
Height = 1
Left = 12
Top = 39
Width = 521
Name = "Clslinea1"

*** METODOS ***


************************************************************
OBJETO: cmbajuste
************************************************************
*** PROPIEDADES ***
Height = 24
Left = 109
TabIndex = 1
Top = 57
Width = 192
cfieldname = 
Name = "cmbajuste"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Ajuste de:"
Height = 15
Left = 14
Top = 62
Width = 60
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Importe:"
Height = 15
Left = 324
Top = 62
Width = 60
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: txtimp
************************************************************
*** PROPIEDADES ***
Left = 379
TabIndex = 2
Top = 58
Name = "txtimp"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta6
************************************************************
*** PROPIEDADES ***
Caption = "Observaciones:"
Height = 15
Left = 14
Top = 95
Width = 96
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: txtobservac
************************************************************
*** PROPIEDADES ***
Height = 71
Left = 109
TabIndex = 3
Top = 97
Width = 417
Name = "txtobservac"

*** METODOS ***


************************************************************
OBJETO: btnGrabar
************************************************************
*** PROPIEDADES ***
Top = 180
Left = 437
TabIndex = 4
Name = "btnGrabar"

*** METODOS ***
PROCEDURE Click
LOCAL lcSql, loCommand, loDT, loNumerador
LOCAL lnAjuste, lcNumAjuste, lnIdCC_Prov, lnIdOper, lcCbte, lcTipoDoc, lnPtoVta, lnNroCbte
LOCAL lcObserv, lnImporte

loCommand = CREATEOBJECT("odbc_command")
loCliente = CREATEOBJECT("odbc_result")
loDT = CREATEOBJECT("datetime")
loNumerador = CREATEOBJECT("odbc_result")
lcSql = ""
lnAjuste = 0
lcNumAjuste = ""
lnIdCondPago = 0
lnIdSitIva = 0
lnIdCC_Prov = 0
lnIdOper = 0
lcCbte = ""
lcTipoDoc = "X"
lnPtoVta = 0
lnNroCbte = 0
lcObserv = ""
lnImporte = 0.00

lnAjuste = thisform.contenedor.cmbajuste.ListItemId
lcObserv = ALLTRIM(UPPER(thisform.contenedor.txtobservac.Value))
lnImporte = thisform.contenedor.txtimp.Value 
lnIdOper = thisform.idoperacion

IF lnImporte = 0 THEN
	MESSAGEBOX("El importe del ajuste no puede ser cero", 0+48, Thisform.Caption)
	Thisform.txtimp.SetFocus()
	RETURN .F.
ENDIF

IF lnAjuste = 1 THEN
	lcCbte = "ACP"
ELSE 
	lcCbte = "ADP"
ENDIF 

lnIdCondPago = Thisform.idCondPago
lnIdSitIva = Thisform.IdSitIva

&& Inicio la transaccion
goConn.BeginTransaction

&& Busco el numero de ptovta y cbte
lcSql = "SELECT * FROM numerador WHERE cbte = '" + ALLTRIM(lcCbte) + "' and tipodoc = '" + ALLTRIM(lcTipoDoc) + "'"
loNumerador.ActiveConnection = goConn.ActiveConnection
loNumerador.cursor_name = "cur_num"
loNumerador.OpenQuery(lcSql)

IF RECCOUNT("cur_num") = 0 THEN
	MESSAGEBOX("No se encuentra configurado el numerador del comprobante " + ALLTRIM(lcCbte) + " Letra: " + ALLTRIM(lcTipoDoc), 0+48, thisform.Caption)
	loNumerador.close_query()
	goConn.Rollback()
	RETURN .F.
ENDIF

lnPtoVta = cur_num.ptovta
lnNroCbte = cur_num.numactual + 1
lcNumAjuste = REPLICATE("0", 8 - LEN(ALLTRIM(STR(lnNroCbte)))) + ALLTRIM(STR(lnNroCbte))

loNumerador.close_query()

&& Actualizo el numerador
lcSql = "update numerador set numActual = " + ALLTRIM(STR(lnNroCbte)) + ;
	" where cbte = '" + ALLTRIM(lcCbte) + "' and tipoDoc = '" + ALLTRIM(lcTipoDoc) + "'"
	
loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = lcSql

IF !loCommand.execute() THEN 
	goConn.Rollback()
	RETURN .F.
ENDIF	

&& Busco el proximo ID de la tabla CC_Cli
lnIdCC_Prov = goConn.GetNextID("cc_prov", "idCC_Prov")

IF lnIdOper = 0 THEN 
	lnIdOper = goConn.GetNextID("cc_prov", "idOper")
ENDIF 

IF ALLTRIM(lcCbte) == "ACP" THEN 
	lcSql = "INSERT INTO cc_prov(idCC_Prov, idProv, cbte, tipoDoc, ptoVta, nroCbte, fecEmis, fecVto, "
	lcSql = lcSql + "	impDebe, impHaber, idOper, observ, idCondPago, idSitIva, usuAlta, fecAlta, idHostAlta) "
	lcSql = lcSql + "VALUES( " + ALLTRIM(STR(lnIdCC_Prov)) + ", " + ALLTRIM(STR(thisform.idprov)) + ", '" + ALLTRIM(lcCbte) + "', '"
	lcSql = lcSql + 	ALLTRIM(lcTipoDoc) + "', " + ALLTRIM(STR(lnPtoVta)) + ", " + ALLTRIM(STR(lnNroCbte)) + ", " 
	lcSql = lcSql + 	loDT.getdatetime() + ", " + loDT.getdatetime() + ", 0, " + ALLTRIM(STR(lnImporte, 10, 2)) + ", " 
	lcSql = lcSql + 	ALLTRIM(STR(lnIdOper)) + ", '" + ALLTRIM(lcObserv) + "', " + ALLTRIM(STR(lnIdCondPago)) + ", "
	lcSql = lcSql + 	ALLTRIM(STR(lnIdSitIva)) + ", '" + ALLTRIM(gcCodUsu) + "', " + loDT.getDateTime() + ", '" + SYS(0) + "')"
ELSE 
	lcSql = "INSERT INTO cc_prov(idCC_Prov, idProv, cbte, tipoDoc, ptoVta, nroCbte, fecEmis, fecVto, "
	lcSql = lcSql + "	impDebe, impHaber, idOper, observ, idCondPago, idSitIva, usuAlta, fecAlta, idHostAlta) "
	lcSql = lcSql + "VALUES( " + ALLTRIM(STR(lnIdCC_Prov)) + ", " + ALLTRIM(STR(thisform.idprov)) + ", '" + ALLTRIM(lcCbte) + "', '"
	lcSql = lcSql + 	ALLTRIM(lcTipoDoc) + "', " + ALLTRIM(STR(lnPtoVta)) + ", " + ALLTRIM(STR(lnNroCbte)) + ", " 
	lcSql = lcSql + 	loDT.getdatetime() + ", " + loDT.getdatetime() + ", " + ALLTRIM(STR(lnImporte, 10, 2)) + ", 0, " 
	lcSql = lcSql + 	ALLTRIM(STR(lnIdOper)) + ", '" + ALLTRIM(lcObserv) + "', " + ALLTRIM(STR(lnIdCondPago)) + ", "
	lcSql = lcSql + 	ALLTRIM(STR(lnIdSitIva)) + ", '" + ALLTRIM(gcCodUsu) + "', " + loDT.getDateTime() + ", '" + SYS(0) + "')"
ENDIF 

loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = lcSql

IF !loCommand.execute() THEN
	goConn.Rollback()
	RETURN .F.
ENDIF

&& Actualizar el saldo de la factura seleccionada
IF ALLTRIM(lcCbte) == "ACP" THEN
	lcSql = "UPDATE comprascab SET Saldo = Saldo - " + ALLTRIM(STR(lnImporte, 10, 2)) + ", "
	lcSql = lcSql + "usuModi = '" + ALLTRIM(gcCodUsu) + "', "
	lcSql = lcSql + "fecModi = " + loDT.getDateTime() + ", "
	lcSql = lcSql + "idHostModi = '" + ALLTRIM(SYS(0)) + "' "
	lcSql = lcSql + "WHERE idCompraC IN (SELECT idCompraC FROM cc_prov WHERE IdOper = " +  ALLTRIM(STR(lnIdOper)) + " AND cbte like 'FC%')"
ELSE 
	lcSql = "UPDATE comprascab SET Saldo = Saldo + " + ALLTRIM(STR(lnImporte, 10, 2)) + ", "
	lcSql = lcSql + "usuModi = '" + ALLTRIM(gcCodUsu) + "', "
	lcSql = lcSql + "fecModi = " + loDT.getDateTime() + ", "
	lcSql = lcSql + "idHostModi = '" + ALLTRIM(SYS(0)) + "' "
	lcSql = lcSql + "WHERE idCompraC IN (SELECT idCompraC FROM cc_prov WHERE IdOper = " +  ALLTRIM(STR(lnIdOper)) + " AND cbte like 'FC%')"
ENDIF
	
loCommand.CommandText = lcSql
loCommand.ActiveConnection = goConn.ActiveConnection

IF !loCommand.Execute()
	goConn.Rollback()
	RETURN .F.
ENDIF 
 

goConn.Commit()

IF lcCbte = "ACP" THEN 
	MESSAGEBOX("El Ajuste de Crédito " + ALLTRIM(lcNumAjuste) + " se ha generado exitosamente", 0+64, thisform.Caption)
ELSE
	MESSAGEBOX("El Ajuste de Débito " + ALLTRIM(lcNumAjuste) + " se ha generado exitosamente", 0+64, thisform.Caption)
ENDIF 

thisform.Release()

ENDPROC


************************************************************
OBJETO: btnSalir
************************************************************
*** PROPIEDADES ***
Top = 180
Left = 484
Cancel = .T.
TabIndex = 5
Name = "btnSalir"

*** METODOS ***


************************************************************
OBJETO: cls_ajuste_ccprov
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_cb_cbtescpas
************************************************************
*** PROPIEDADES ***
BorderStyle = 2
Height = 535
Width = 986
DoCreate = .T.
Caption = "Consulta y baja de comprobantes de compras"
WindowType = 0
Name = "cls_cb_cbtescpas"
contenido.Top = -1
contenido.Left = -1
contenido.Width = 987
contenido.Height = 540
contenido.Name = "contenido"

*** METODOS ***
PROCEDURE leer_artdet
LOCAL loRes, lcSql
LOCAL lnIdCompraC

loRes = CREATEOBJECT("odbc_result")
lcSql = ""
lnIdArticulo = 0

SELECT comprasdet
ZAP

SELECT comprascab
lnCompraC = comprascab.idCompraC

lcSql = "SELECT * "
lcSql = lcSql + "FROM comprasdet "
lcSql = lcSql + "WHERE comprasdet.idCompraC = " + ALLTRIM(STR(lnCompraC)) + " "

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_temp"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_temp
GO TOP
DO WHILE !EOF("cur_temp")
	SELECT comprasdet
	APPEND BLANK
	REPLACE comprasdet.idCompraD WITH cur_temp.idCompraD
	REPLACE comprasdet.idCompraC WITH cur_temp.idCompraC ADDITIVE
	REPLACE comprasdet.codArt WITH ALLTRIM(cur_temp.codArt) ADDITIVE
	REPLACE comprasdet.descripcio WITH ALLTRIM(cur_temp.descripcio) ADDITIVE
	REPLACE comprasdet.cantidad WITH cur_temp.cantidad ADDITIVE
	REPLACE comprasdet.cantPack WITH cur_temp.cantPack ADDITIVE
	REPLACE comprasdet.prLista WITH cur_temp.prLista ADDITIVE
	REPLACE comprasdet.porDesc1 WITH cur_temp.porDesc1 ADDITIVE
	REPLACE comprasdet.porDesc2 WITH cur_temp.porDesc2 ADDITIVE
	REPLACE comprasdet.porDesc3 WITH cur_temp.porDesc3 ADDITIVE
	REPLACE comprasdet.porDesc4 WITH cur_temp.porDesc4 ADDITIVE
	REPLACE comprasdet.costoNeto WITH cur_temp.costoNeto ADDITIVE
	REPLACE comprasdet.alicIVA WITH cur_temp.alicIVA ADDITIVE
	REPLACE comprasdet.costoFinal WITH cur_temp.costoFinal ADDITIVE
	REPLACE comprasdet.totNeto WITH cur_temp.totNeto ADDITIVE
	REPLACE comprasdet.totFinal WITH cur_temp.totFinal ADDITIVE
	
	SELECT cur_temp
	SKIP
ENDDO

loRes.Close_Query()

SELECT comprasdet
GO TOP
Thisform.contenido.group_pages.page1.grdArticulos.Refresh()

RETURN .T.
ENDPROC
PROCEDURE leer_cptos
LOCAL loRes, lcSql
LOCAL lnIdCompraC

loRes = CREATEOBJECT("odbc_result")
lcSql = ""

SELECT cpasdet_cp
ZAP

SELECT comprascab
lnIdCompraC = comprascab.idCompraC

lcSql = "SELECT cpasdet_cp.idCpaDCP, "
lcSql = lcSql + "planctas.codPlanCta, "
lcSql = lcSql + "planctas.descripcio, "
lcSql = lcSql + "cpasdet_cp.impNeto, "
lcSql = lcSql + "cpasdet_cp.ivaPor, "
lcSql = lcSql + "cpasdet_cp.ivaImp, "
lcSql = lcSql + "cpasdet_cp.total "
lcSql = lcSql + "FROM cpasdet_cp "
lcSql = lcSql + "INNER JOIN planctas ON planctas.idPlanCta = cpasdet_cp.idPlanCta "
lcSql = lcSql + "WHERE cpasdet_cp.idCompraC = " + ALLTRIM(STR(lnIdCompraC))

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_temp"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_temp
GO TOP
DO WHILE !EOF("cur_temp")
	SELECT cpasdet_cp
	APPEND BLANK
	REPLACE cpasdet_cp.idCpaDCP WITH cur_temp.idCpaDCP
	REPLACE cpasdet_cp.codPlanCta WITH cur_temp.codPlanCta ADDITIVE
	REPLACE cpasdet_cp.descripcio WITH cur_temp.descripcio ADDITIVE
	REPLACE cpasdet_cp.impNeto WITH cur_temp.impNeto ADDITIVE
	REPLACE cpasdet_cp.ivaPor WITH cur_temp.ivaPor ADDITIVE
	REPLACE cpasdet_cp.ivaImp WITH cur_temp.ivaImp ADDITIVE
	REPLACE cpasdet_cp.total WITH cur_temp.total ADDITIVE

	SELECT cur_temp
	SKIP
ENDDO

loRes.Close_Query()

SELECT cpasdet_cp
GO TOP
Thisform.contenido.group_pages.page2.grdConceptos.Refresh()

RETURN .T.
ENDPROC
PROCEDURE leer_percepciones
Thisform.contenido.group_pages.page3.txtIVA.Value = comprascab.retIVA
Thisform.contenido.group_pages.page3.txtIIBB.Value = comprascab.retIIBB
Thisform.contenido.group_pages.page3.txtProvincia.Value = comprascab.provincia
Thisform.contenido.group_pages.page3.txtGanancias.Value = comprascab.retGan
Thisform.contenido.group_pages.page3.txtSUSS.Value = comprascab.retSUSS
Thisform.contenido.group_pages.page3.txtImpuestos.Value = comprascab.impuestos




ENDPROC
PROCEDURE leer_totales
Thisform.contenido.txtNoGravado.Value = comprascab.noGravado
Thisform.contenido.txttotalNeto.Value = comprascab.totNeto
Thisform.contenido.txtImpIVA21.Value = comprascab.impIVA21
Thisform.contenido.txtImpIVA105.Value = comprascab.impIVA105
Thisform.contenido.txtPercepciones.Value = comprascab.retIVA + comprascab.retIIBB + comprascab.retGan + comprascab.retSUSS
Thisform.contenido.txtImpuestos.Value = comprascab.impuestos
Thisform.contenido.txtTotalFinal.Value = comprascab.totFinal
ENDPROC
PROCEDURE Load
DODEFAULT()

&& Este cursor va a ser para la grilla de cabeceras
CREATE CURSOR comprascab (	;
	idCC_Prov int,;
	idCompraC int,;
	idProv int,;
	razSocPV varchar(100),;
	fecEmis datetime,;
	cbte varchar(3),;
	tipoDoc varchar(1),;
	ptoVta varchar(4),;
	numCbte varchar(8),;
	noGravado float(10,2),;
	totNeto float(10,2),;
	impIVA21 float(10,2),;
	impIVA105 float(10,2),;
	retIVA float(10,2),;
	retIIBB float(10,2),;
	provincia varchar(60),;
	retGan float(10,2),;
	retSUSS float(10,2),;
	impuestos float(10,2),;
	totFinal float(10,2),;
	saldo float(10, 2),;
	usuAlta varchar(5),;
	fecAlta datetime,;
	idHostAlta varchar(60))
	

&& El siguiente cursor corresponde al detalle de compras
CREATE CURSOR comprasdet (	;
	idCompraD 	int,;
	idCompraC	int,;
	codArt		varchar(20),;
	descripcio	varchar(100),;
	cantidad	float(10,2),;
	cantPack	float(10,2),;
	prLista		float(10,2),;
	porDesc1	float(10,2),;
	porDesc2	float(10,2),;
	porDesc3	float(10,2),;
	porDesc4	float(10,2),;
	costoNeto	float(10,2),;
	alicIVA		float(10,2),;
	costoFinal	float(10,2),;
	totNeto		float(10,2),;
	totFinal	float(10,2))
	
&& Este cursor lo voy a usar para mostrar los datos en la
&& grilla de conceptos.
CREATE CURSOR cpasdet_cp (	;
	idCpaDCP	int,;
	codPlanCta	varchar(20),;
	descripcio	varchar(60),;
	impNeto		float(10,2),;
	ivaPor		float(10,2),;
	ivaImp		float(10,2),;
	total		float(10,2))
ENDPROC
PROCEDURE buscar
LOCAL loRes, lcSql, loDT
LOCAL lnIdProv, ldFechaDD, ldFechaHH
LOCAL lcCbte, lcTipoDoc, lnPtoVta, lnNumCbte

loDT = CREATEOBJECT("datetime")
loRes = CREATEOBJECT("odbc_result")
lcSql = ""

lnIdProv = Thisform.contenido.cnt_filtros.sel_proveedor.valcpoid
ldFechaDD = Thisform.contenido.cnt_filtros.txtFechaDD.Value
ldFechaHH = Thisform.contenido.cnt_filtros.txtFechaHH.Value
lcCbte = Thisform.contenido.cnt_filtros.cmbCbte.Value
lcTipoDoc = Thisform.contenido.cnt_filtros.cmbTipoDoc.Value
lnPtoVta = INT(VAL(Thisform.contenido.cnt_filtros.txtPtoVta.Value))
lnNumCbte = INT(VAL(Thisform.contenido.cnt_filtros.txtnroCbte.Value))

SELECT comprascab
ZAP

lcSql = "SELECT 	cc_prov.idCC_Prov,	"
lcSql = lcSql + "	cc_prov.idCompraC, "
lcSql = lcSql + "	cc_prov.idProv, "
lcSql = lcSql + "	comprascab.razSocPV, "
lcSql = lcSql + "	cc_prov.fecEmis, "
lcSql = lcSql + "	cc_prov.cbte, "
lcSql = lcSql + "	cc_prov.tipoDoc, "
lcSql = lcSql + "	cc_prov.ptoVta, "
lcSql = lcSql + "	cc_prov.nroCbte, "
lcSql = lcSql + "	comprascab.noGravado, "
lcSql = lcSql + "	comprascab.totNeto, "
lcSql = lcSql + "	comprascab.impIVA21, "
lcSql = lcSql + "	comprascab.impIVA105, "
lcSql = lcSql + "	comprascab.retIVA, "
lcSql = lcSql + "	comprascab.retIIBB, "
lcSql = lcSql + "	provincias.descripcio AS provincia, "
lcSql = lcSql + "	comprascab.retGan, "
lcSql = lcSql + "	comprascab.retSUSS, "
lcSql = lcSql + "	comprascab.impuestos, "
lcSql = lcSql + "	comprascab.totFinal, "
lcSql = lcSql + "	Saldos.saldo, "
lcSql = lcSql + "	comprascab.usuAlta, "
lcSql = lcSql + "	comprascab.fecAlta, "
lcSql = lcSql + "	comprascab.idHostAlta "
lcSql = lcSql + "FROM 	cc_prov INNER JOIN proveedor ON cc_prov.idProv = proveedor.idProv "
lcSql = lcSql + "	LEFT JOIN (SELECT cc2.idOper, ROUND(SUM(cc2.impdebe - cc2.imphaber),2) as Saldo "
lcSql = lcSql + "       		FROM cc_prov AS cc2 "
lcSql = lcSql + "       		WHERE (cc2.usubaja is null OR cc2.usubaja = '') "
lcSql = lcSql + "				GROUP BY cc2.idoper) AS Saldos ON cc_prov.idoper = Saldos.idoper "
lcSql = lcSql + "	INNER JOIN comprascab ON comprascab.idCompraC = cc_prov.idCompraC "
lcSql = lcSql + "	LEFT JOIN provincias ON comprascab.idProvin = provincias.idProvin "
lcSql = lcSql + "WHERE cc_prov.cbte IN ('FC', 'ND', 'NC') "
lcSql = lcSql + "	AND (cc_prov.usubaja is null OR cc_prov.usubaja = '') "
lcSql = lcSql + "	AND (comprascab.usubaja is null OR comprascab.usubaja = '') "
lcSql = lcSql + "	AND comprascab.fecEmis BETWEEN " + loDT.toMySql(ldFechaDD) + " AND " + loDT.toMySql(ldFechaHH) + " "

IF lnIdProv <> 0 THEN
	lcSql = lcSql + "AND comprascab.idProv = " + ALLTRIM(STR(lnIdProv)) + " "
ENDIF

IF !(ALLTRIM(lcCbte) == "Todos") THEN
	lcSql = lcSql + "AND comprascab.cbte = '" + ALLTRIM(lcCbte) + "' "
ENDIF

IF !(ALLTRIM(lcTipoDoc) == "Todos") THEN
	lcSql = lcSql + "AND comprascab.tipoDoc = '" + ALLTRIM(lcTipoDoc) + "' "
ENDIF

IF lnPtoVta <> 0 THEN
	lcSql = lcSql + "AND comprascab.ptoVta = " + ALLTRIM(STR(lnPtoVta)) + " "
ENDIF

IF lnNumCbte <> 0 THEN
	lcSql = lcSql + "AND comprascab.numCbte = " + ALLTRIM(STR(lnNumCbte)) + " "
ENDIF

lcSql = lcSql + "ORDER BY cc_prov.fecEmis ASC "

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_temp"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_temp
GO TOP
DO WHILE !EOF("cur_temp")
	SELECT comprascab
	APPEND BLANK
	REPLACE comprascab.idCC_Prov WITH cur_temp.idCC_Prov
	REPLACE comprascab.idCompraC WITH cur_temp.idCompraC ADDITIVE 
	REPLACE comprascab.idProv WITH cur_temp.idProv ADDITIVE
	REPLACE comprascab.razSocPV WITH cur_temp.razSocPV ADDITIVE
	REPLACE comprascab.fecEmis WITH cur_temp.fecEmis ADDITIVE
	REPLACE comprascab.cbte WITH cur_temp.cbte ADDITIVE
	REPLACE comprascab.tipoDoc WITH cur_temp.tipoDoc ADDITIVE
	REPLACE comprascab.ptoVta WITH REPLICATE("0", 4 - LEN(ALLTRIM(STR(cur_temp.ptoVta)))) + ALLTRIM(STR(cur_temp.ptoVta)) ADDITIVE
	REPLACE comprascab.numCbte WITH REPLICATE("0", 8 - LEN(ALLTRIM(STR(cur_temp.nroCbte)))) + ALLTRIM(STR(cur_temp.nroCbte)) ADDITIVE
	REPLACE comprascab.noGravado WITH cur_temp.noGravado ADDITIVE
	REPLACE comprascab.totNeto WITH cur_temp.totNeto ADDITIVE
	REPLACE comprascab.impIVA21 WITH cur_temp.impIVA21 ADDITIVE
	REPLACE comprascab.impIVA105 WITH cur_temp.impIVA105 ADDITIVE
	REPLACE comprascab.retIVA WITH cur_temp.retIVA ADDITIVE
	REPLACE comprascab.retIIBB WITH cur_temp.retIIBB ADDITIVE
	REPLACE comprascab.provincia WITH IIF(ISNULL(cur_temp.provincia),"",cur_temp.provincia) ADDITIVE
	REPLACE comprascab.retGan WITH cur_temp.retGan ADDITIVE
	REPLACE comprascab.retSUSS WITH cur_temp.retSUSS ADDITIVE
	REPLACE comprascab.impuestos WITH cur_temp.impuestos ADDITIVE
	REPLACE comprascab.totFinal WITH cur_temp.totFinal ADDITIVE
	REPLACE comprascab.saldo WITH cur_temp.saldo ADDITIVE
	REPLACE comprascab.usuAlta WITH cur_temp.usuAlta ADDITIVE
	REPLACE comprascab.fecAlta WITH cur_temp.fecAlta ADDITIVE
	REPLACE comprascab.idHostAlta WITH cur_temp.idHostAlta ADDITIVE


	SELECT cur_temp
	SKIP
ENDDO

loRes.Close_Query()

SELECT comprascab
GO TOP

Thisform.Contenido.grdCabeceras.Refresh
Thisform.leer_artdet()
Thisform.leer_cptos()
Thisform.leer_percepciones()
Thisform.leer_totales()

RETURN .T.
ENDPROC
PROCEDURE Init
Thisform.Contenido.cnt_filtros.cmbCbte.AddItem("Todos")
Thisform.Contenido.cnt_filtros.cmbCbte.AddItem("FC")
Thisform.Contenido.cnt_filtros.cmbCbte.AddItem("NC")
Thisform.Contenido.cnt_filtros.cmbCbte.AddItem("ND")
Thisform.Contenido.cnt_filtros.cmbCbte.ListIndex = 1

Thisform.Contenido.cnt_filtros.cmbTipoDoc.AddItem("Todos")
Thisform.Contenido.cnt_filtros.cmbTipoDoc.AddItem("A")
Thisform.Contenido.cnt_filtros.cmbTipoDoc.AddItem("B")
Thisform.Contenido.cnt_filtros.cmbTipoDoc.AddItem("X")
Thisform.Contenido.cnt_filtros.cmbTipoDoc.ListIndex = 1

Thisform.contenido.cnt_filtros.txtFechaDD.Value = DATE() - 30
Thisform.contenido.cnt_filtros.txtFechaHH.Value = DATE()

SELECT comprascab
Thisform.Contenido.grdCabeceras.alias_name = "comprascab"
Thisform.contenido.grdCabeceras.RecordSource = "comprascab"
Thisform.contenido.grdCabeceras.list_controlsource = "fecEmis,idProv,razSocPV,cbte,tipoDoc,ptoVta,numCbte,totFinal,saldo"
Thisform.contenido.grdCabeceras.lista_ancho_cols = "130,70,250,70,70,70,100,70,70"
Thisform.contenido.grdCabeceras.titulos_cabeceras = "Fecha,Prov.,Razón Social,Cbte,Tipo,Pto. Vta.,Número,Total Final,Saldo"
Thisform.contenido.grdCabeceras.generar_grid()

SELECT comprasdet
Thisform.contenido.group_pages.page1.grdArticulos.alias_name = "comprasdet"
Thisform.contenido.group_pages.page1.grdArticulos.RecordSource = "comprasdet"
Thisform.contenido.group_pages.page1.grdArticulos.list_controlsource = "codArt,descripcio,cantidad,prLista,porDesc1,porDesc2,porDesc3,porDesc4,costoNeto,alicIVA,costoFinal,totNeto,totFinal"
Thisform.contenido.group_pages.page1.grdArticulos.lista_ancho_cols = "100,170,60,60,55,55,55,55,60,40,70,70,70,70,70"
Thisform.contenido.group_pages.page1.grdArticulos.titulos_cabeceras = "Código,Descripción,Cantidad,Pr. Lista,Desc. 1,Desc. 2,Desc. 3,Desc. 4,Neto,IVA,Final,Total Neto, Total Final"
Thisform.contenido.group_pages.page1.grdArticulos.generar_grid()

SELECT cpasdet_cp
Thisform.contenido.group_pages.page2.grdConceptos.alias_name = "cpasdet_cp"
Thisform.contenido.group_pages.page2.grdConceptos.RecordSource = "cpasdet_cp"
Thisform.contenido.group_pages.page2.grdConceptos.list_controlsource = "codPlanCta,descripcio,impNeto,ivaPor,ivaImp,total"
Thisform.contenido.group_pages.page2.grdConceptos.lista_ancho_cols = "100,250,70,70,70,70"
Thisform.contenido.group_pages.page2.grdConceptos.titulos_cabeceras = "Código,Descripción,Imp. Neto,% IVA,Imp. IVA,Total"
Thisform.contenido.group_pages.page2.grdConceptos.generar_grid()


ENDPROC
PROCEDURE eliminar
LOCAL loCommand, lcSql
LOCAL lnResp
LOCAL lnIdCompraC
LOCAL lnIdCC_Prov

loCommand = CREATEOBJECT("odbc_command")
lcSql = ""

SELECT comprascab
lnIdCompraC = comprascab.idCompraC
lnIdCC_Prov = comprascab.idCC_Prov

lnResp = MESSAGEBOX("¿Está seguro que desea eliminar el comprobante?", 4+32, Thisform.Caption)
IF lnResp = 6 THEN
	goConn.BeginTransaction()

	lcSql = "UPDATE comprascab "
	lcSql = lcSql + "SET comprascab.usuBaja = '" + ALLTRIM(gcCodUsu) + "', "
	lcSql = lcSql + "	comprascab.fecBaja = current_timestamp, "
	lcSql = lcSql + "	comprascab.idHostBaja = '" + ALLTRIM(SYS(0)) + "' "
	lcSql = lcSql + "WHERE comprascab.idCompraC = " + ALLTRIM(STR(lnIdCompraC))
	
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute() THEN
		goConn.Rollback()
		MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
		RETURN .F.
	ENDIF
	
	lcSql = "UPDATE cc_prov "
	lcSql = lcSql + "SET cc_prov.usuBaja = '" + ALLTRIM(gcCodUsu) + "', "
	lcSql = lcSql + "	cc_prov.fecBaja = current_timestamp, "
	lcSql = lcSql + "	cc_prov.idHostBaja = '" + ALLTRIM(SYS(0)) + "' "
	lcSql = lcSql + "WHERE cc_prov.idCC_Prov = " + ALLTRIM(STR(lnIdCC_Prov))
	
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute() THEN
		goConn.Rollback()
		MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
		RETURN .F.
	ENDIF	
	
	goConn.Commit()
	
	SELECT comprascab
	DELETE
	
	SELECT comprascab
	Thisform.contenido.grdCabeceras.Refresh()
	Thisform.contenido.grdCabeceras.SetFocus()

	Thisform.contenido.Group_pages.page1.grdArticulos.Refresh()
	Thisform.contenido.group_pages.page2.grdConceptos.Refresh()
ENDIF

RETURN .T.
ENDPROC


************************************************************
OBJETO: cnt_filtros
************************************************************
*** PROPIEDADES ***
Top = 6
Left = 8
Width = 973
Height = 66
BackStyle = 1
TabIndex = 1
BackColor = 237,218,205
Name = "cnt_filtros"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Proveedor:"
Height = 15
Left = 17
Top = 19
Width = 72
TabIndex = 10
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: sel_proveedor
************************************************************
*** PROPIEDADES ***
Top = 12
Left = 94
TabIndex = 1
nombre_tabla = proveedor
nombre_campo_codigo = idProv
nombre_campo_desc = razSoc
pkfield = idProv
esnumerico = .T.
Name = "sel_proveedor"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Fecha Desde:"
Height = 15
Left = 17
Top = 41
Width = 79
TabIndex = 11
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Fecha Hasta:"
Height = 15
Left = 199
Top = 41
Width = 78
TabIndex = 12
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: txtFechaDD
************************************************************
*** PROPIEDADES ***
Left = 96
TabIndex = 2
Top = 37
Name = "txtFechaDD"

*** METODOS ***


************************************************************
OBJETO: txtFechaHH
************************************************************
*** PROPIEDADES ***
Left = 278
TabIndex = 3
Top = 37
Name = "txtFechaHH"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Comprobante:"
Height = 15
Left = 386
Top = 40
Width = 87
TabIndex = 13
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: cmbCbte
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 472
TabIndex = 4
Top = 37
Width = 60
Name = "cmbCbte"

*** METODOS ***


************************************************************
OBJETO: cmbTipoDoc
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 534
TabIndex = 5
Top = 37
Width = 46
Name = "cmbTipoDoc"

*** METODOS ***


************************************************************
OBJETO: txtPtoVta
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 582
MaxLength = 4
TabIndex = 6
Top = 37
Width = 61
ischaracter = .T.
autocompleta = .T.
Name = "txtPtoVta"

*** METODOS ***


************************************************************
OBJETO: txtNroCbte
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 645
MaxLength = 8
TabIndex = 7
Top = 37
Width = 106
ischaracter = .T.
autocompleta = .T.
Name = "txtNroCbte"

*** METODOS ***


************************************************************
OBJETO: btnBuscar
************************************************************
*** PROPIEDADES ***
Top = 18
Left = 924
Picture = ..\imagen\iconos bajados\buscar-buscar-ampliar-icono-9630.ico
TabIndex = 8
Name = "btnBuscar"

*** METODOS ***
PROCEDURE Click
Thisform.buscar()
ENDPROC


************************************************************
OBJETO: grdCabeceras
************************************************************
*** PROPIEDADES ***
Height = 156
Left = 7
TabIndex = 2
Top = 75
Width = 974
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdCabeceras"
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
Thisform.leer_artdet()
Thisform.leer_cptos()
Thisform.leer_percepciones()
Thisform.leer_totales()

ENDPROC


************************************************************
OBJETO: group_pages
************************************************************
*** PROPIEDADES ***
ErasePage = .T.
PageCount = 3
Top = 233
Left = 8
Width = 976
Height = 253
TabIndex = 3
Name = "group_pages"
Page1.Caption = "Artículos"
Page1.Name = "Page1"
Page2.Caption = "Conceptos"
Page2.Name = "Page2"
Page3.FontBold = .T.
Page3.FontItalic = .T.
Page3.FontSize = 8
Page3.Caption = "Percepciones e Impuestos"
Page3.ForeColor = 128,64,64
Page3.Name = "Page3"

*** METODOS ***


************************************************************
OBJETO: grdArticulos
************************************************************
*** PROPIEDADES ***
Height = 208
Left = 4
Top = 10
Width = 965
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdArticulos"
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
COLUMN11.Header1.Alignment = 2
COLUMN11.Header1.Name = "Header1"
COLUMN11.Text1.Name = "Text1"
COLUMN11.Name = "COLUMN11"
COLUMN12.Header1.Alignment = 2
COLUMN12.Header1.Name = "Header1"
COLUMN12.Text1.Name = "Text1"
COLUMN12.Name = "COLUMN12"
COLUMN13.Header1.Alignment = 2
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

ENDPROC


************************************************************
OBJETO: grdConceptos
************************************************************
*** PROPIEDADES ***
Height = 208
Left = 5
Top = 9
Width = 964
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdConceptos"
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
COLUMN11.Header1.Alignment = 2
COLUMN11.Header1.Name = "Header1"
COLUMN11.Text1.Name = "Text1"
COLUMN11.Name = "COLUMN11"
COLUMN12.Header1.Alignment = 2
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


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "I.V.A.:"
Height = 15
Left = 17
Top = 17
Width = 84
TabIndex = 6
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Ingresos Brutos:"
Height = 15
Left = 17
Top = 43
Width = 97
TabIndex = 7
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Provincia:"
Height = 15
Left = 234
Top = 44
Width = 60
TabIndex = 8
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Ganancias:"
Height = 15
Left = 17
Top = 68
Width = 97
TabIndex = 9
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "SUSS:"
Height = 15
Left = 17
Top = 93
Width = 97
TabIndex = 10
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: txtIVA
************************************************************
*** PROPIEDADES ***
Left = 123
ReadOnly = .T.
TabIndex = 1
Top = 14
isnumeric = .T.
Name = "txtIVA"

*** METODOS ***


************************************************************
OBJETO: txtIIBB
************************************************************
*** PROPIEDADES ***
Left = 123
ReadOnly = .T.
TabIndex = 2
Top = 39
isnumeric = .T.
Name = "txtIIBB"

*** METODOS ***


************************************************************
OBJETO: txtGanancias
************************************************************
*** PROPIEDADES ***
Left = 123
ReadOnly = .T.
TabIndex = 4
Top = 64
isnumeric = .T.
Name = "txtGanancias"

*** METODOS ***


************************************************************
OBJETO: txtSUSS
************************************************************
*** PROPIEDADES ***
Left = 123
ReadOnly = .T.
TabIndex = 5
Top = 89
isnumeric = .T.
Name = "txtSUSS"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta6
************************************************************
*** PROPIEDADES ***
Caption = "Impuestos:"
Height = 15
Left = 17
Top = 152
Width = 97
TabIndex = 10
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: txtImpuestos
************************************************************
*** PROPIEDADES ***
Left = 123
ReadOnly = .T.
TabIndex = 6
Top = 148
isnumeric = .T.
Name = "txtImpuestos"

*** METODOS ***


************************************************************
OBJETO: txtProvincia
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 297
ReadOnly = .T.
TabIndex = 3
Top = 39
Width = 379
ischaracter = .T.
Name = "txtProvincia"

*** METODOS ***


************************************************************
OBJETO: btnEliminar
************************************************************
*** PROPIEDADES ***
Top = 488
Left = 55
Picture = ..\imagen\iconos bajados\eliminar-cancelar-icono-4935 (1).ico
TabIndex = 5
Name = "btnEliminar"

*** METODOS ***
PROCEDURE Click
Thisform.eliminar()
ENDPROC


************************************************************
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 488
Left = 936
Picture = ..\imagen\iconos bajados\salir-de-mi-perfil-icono-3964.ico
TabIndex = 7
Name = "btnCerrar"

*** METODOS ***


************************************************************
OBJETO: btnNuevo
************************************************************
*** PROPIEDADES ***
Top = 488
Left = 7
Height = 44
Width = 45
Picture = ..\imagen\iconos bajados\deshacer-icono-5403.ico
TabIndex = 4
Name = "btnNuevo"

*** METODOS ***
PROCEDURE Click
Thisform.contenido.cnt_filtros.sel_proveedor.blanquear()
Thisform.contenido.cnt_filtros.txtFechaDD.Value = DATE() - 30
Thisform.contenido.cnt_filtros.txtFechaHH.Value = DATE()
Thisform.contenido.cnt_filtros.cmbCbte.ListIndex = 1
Thisform.contenido.cnt_filtros.cmbTipoDoc.ListIndex = 1
Thisform.contenido.cnt_filtros.txtPtoVta.blanquear()
Thisform.contenido.cnt_filtros.txtNroCbte.blanquear()

SELECT comprascab
ZAP
Thisform.contenido.grdCabeceras.Refresh()
SELECT comprasdet
ZAP
Thisform.contenido.group_pages.page1.grdArticulos.Refresh()
SELECT cpasdet_cp
ZAP
Thisform.contenido.group_pages.page2.grdConceptos.Refresh()

Thisform.contenido.group_pages.page3.txtIVA.Value = 0.00
Thisform.contenido.group_pages.page3.txtIIBB.Value = 0.00
Thisform.contenido.group_pages.page3.txtProvincia.Value = ""
Thisform.contenido.group_pages.page3.txtGanancias.Value = 0.00
Thisform.contenido.group_pages.page3.txtSUSS.Value = 0.00
Thisform.contenido.group_pages.page3.txtImpuestos.Value = 0.00
Thisform.contenido.txtNoGravado.Value = 0.00
Thisform.contenido.txttotalNeto.Value = 0.00
Thisform.contenido.txtImpIVA21.Value = 0.00
Thisform.contenido.txtImpIVA105.Value = 0.00
Thisform.contenido.txtPercepciones.Value = 0.00
Thisform.contenido.txtImpuestos.Value = 0.00
Thisform.contenido.txtTotalFinal.Value = 0.00


Thisform.contenido.cnt_filtros.sel_proveedor.txtCodigo.SetFocus()

ENDPROC


************************************************************
OBJETO: Clsetiqueta14
************************************************************
*** PROPIEDADES ***
Caption = "Gravado"
Height = 15
Left = 279
Top = 489
Width = 84
TabIndex = 29
Name = "Clsetiqueta14"

*** METODOS ***


************************************************************
OBJETO: txtTotalNeto
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 278
ReadOnly = .T.
TabIndex = 30
Top = 504
Width = 85
isnumeric = .T.
Name = "txtTotalNeto"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta15
************************************************************
*** PROPIEDADES ***
Caption = "I.V.A. 21%"
Height = 15
Left = 372
Top = 489
Width = 60
TabIndex = 31
Name = "Clsetiqueta15"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta16
************************************************************
*** PROPIEDADES ***
Caption = "I.V.A. 10.5%"
Height = 15
Left = 462
Top = 489
Width = 62
TabIndex = 32
Name = "Clsetiqueta16"

*** METODOS ***


************************************************************
OBJETO: txtImpIVA21
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 369
ReadOnly = .T.
TabIndex = 33
Top = 504
Width = 85
isnumeric = .T.
Name = "txtImpIVA21"

*** METODOS ***


************************************************************
OBJETO: txtImpIVA105
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 460
ReadOnly = .T.
TabIndex = 34
Top = 504
Width = 85
isnumeric = .T.
Name = "txtImpIVA105"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta17
************************************************************
*** PROPIEDADES ***
Caption = "Total Final"
Height = 15
Left = 734
Top = 489
Width = 63
TabIndex = 35
Name = "Clsetiqueta17"

*** METODOS ***


************************************************************
OBJETO: txtTotalFinal
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 733
ReadOnly = .T.
TabIndex = 36
Top = 504
Width = 85
isnumeric = .T.
Name = "txtTotalFinal"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta19
************************************************************
*** PROPIEDADES ***
Caption = "Percepciones"
Height = 15
Left = 552
Top = 489
Width = 81
TabIndex = 39
Name = "Clsetiqueta19"

*** METODOS ***


************************************************************
OBJETO: txtPercepciones
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 551
ReadOnly = .T.
TabIndex = 40
Top = 504
Width = 85
isnumeric = .T.
Name = "txtPercepciones"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta6
************************************************************
*** PROPIEDADES ***
Caption = "No Gravado"
Height = 15
Left = 188
Top = 489
Width = 84
TabIndex = 29
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: txtNoGravado
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 187
ReadOnly = .T.
TabIndex = 30
Top = 504
Width = 85
isnumeric = .T.
Name = "txtNoGravado"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta7
************************************************************
*** PROPIEDADES ***
Caption = "Impuestos"
Height = 15
Left = 643
Top = 489
Width = 81
TabIndex = 39
Name = "Clsetiqueta7"

*** METODOS ***


************************************************************
OBJETO: txtImpuestos
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 642
ReadOnly = .T.
TabIndex = 40
Top = 504
Width = 85
isnumeric = .T.
Name = "txtImpuestos"

*** METODOS ***


************************************************************
OBJETO: cls_cb_cbtescpas
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_cbtecpas
************************************************************
*** PROPIEDADES ***
Height = 22
Width = 100
cbte = FC
error_message = 
tipodoc = 
ptovta = 0
numcbte = 0
fecemis = {}
fecvto = {}
totneto = 0.00
saldo = 0.00
totfinal = 0.00
observ = 
idprov = 0
idcondpago = 0
idsitiva = 0
razsocpv = 
cuitpv = 
retiva = 0.00
retiibb = 0.00
aliciva21 = 0.00
impiva21 = 0.00
aliciva105 = 0.00
impiva105 = 0.00
idoper = 0
idcomprac_orig = 0
nogravado = 0.00
retgan = 0.00
retsuss = 0.00
idprovin = 0.00
percepciones = 0.00
impuestos = 0.00
Name = "cls_cbtecpas"

*** METODOS ***
PROCEDURE crear_cursor
CREATE CURSOR comprasdet ( ;
	idCompraD	int,;
	idCompraC	int,;
	idArticulo	int,;
	codArt		varchar(20),;
	descripcio	varchar(100),;
	idUniMed	int,;
	cantidad	double,;
	cantPack	double,;
	cantNC		double,;
	prLista		double,; 
	porDesc1	double,;
	porDesc2	double,;
	porDesc3	double,;
	porDesc4	double,;
	impDesc1	double,;
	impDesc2	double,;
	impDesc3	double,;
	impDesc4	double,;
	costoNeto	double,;
	alicIVA		double,;
	impIVA		double,;
	costoFinal	double,;
	totNeto		double,;
	totFinal	double)
	
&& El siguiente cursor es para grabar el detalle
&& por concepto

CREATE CURSOR cpasdet_cp (	;
	idCpaCP		int,;
	idCompraC	int,;
	idPlanCta	int,;
	codPlanCta	varchar(20),;
	idBanco		int,;
	idCheque	int,;
	descripcio	varchar(100),;
	cheque_nro	varchar(8),;
	impNeto		double,;
	ivaPor		double,;
	ivaImp		double,;
	total		double)

&& Cursor para las retenciones	
CREATE CURSOR comprasret ( ;
	idCompraR	int,;
	idCompraC	int,;
	tipo		varchar(5),;
	idProvin	int,;
	provincia	varchar(60),;
	importe	double)	
	

ENDPROC
PROCEDURE grabar
LOCAL loCommand
LOCAL loRes
LOCAL lcSql
LOCAL lcCbte
LOCAL lnIdCompraC
LOCAL lnIdCompraD
LOCAL loDT
LOCAL lnIdCCProv
LOCAL lnIdOper
LOCAL lnIdCpaDCP
LOCAL lnIdCompraR 

loDT = CREATEOBJECT("datetime")
loCommand = CREATEOBJECT("odbc_command")
loRes = CREATEOBJECT("odbc_result")
lcSql = ""
lcCbte = This.cbte
lnIdCompraC = 0
lnIdCompraD = 0
lnIdCCProv = 0
lnIdCpaDCP = 0
lnIdCompraR = 0

goConn.BeginTransaction()

lnIdCompraC = goConn.GetNextID("comprascab", "idCompraC")

lcSql = "INSERT INTO comprascab ("
lcSql = lcSql + "idCompraC, "
lcSql = lcSql + "idProv, "
lcSql = lcSql + "idCondPago, "
lcSql = lcSql + "idSitIVA, "
lcSql = lcSql + "razSocPV, "
lcSql = lcSql + "cuitPV, "
lcSql = lcSql + "fecEmis, "
lcSql = lcSql + "fecVto, "
lcSql = lcSql + "cbte, "
lcSql = lcSql + "tipoDoc, "
lcSql = lcSql + "ptoVta, "
lcSql = lcSql + "numCbte, "
lcSql = lcSql + "noGravado, "
lcSql = lcSql + "totNeto, "
lcSql = lcSql + "alicIVA21, "
lcSql = lcSql + "impIVA21, "
lcSql = lcSql + "alicIVA105, "
lcSql = lcSql + "impIVA105, "
lcSql = lcSql + "retiva, "
lcSql = lcSql + "retiibb, "
lcSql = lcSql + "idprovin, "
lcSql = lcSql + "retgan, "
lcSql = lcSql + "retsuss, "
lcSql = lcSql + "impuestos, "
lcSql = lcSql + "totFinal, "
lcSql = lcSql + "saldo, "
lcSql = lcSql + "observ, "
lcSql = lcSql + "usuAlta, "
lcSql = lcSql + "fecAlta, "
lcSql = lcSql + "idHostAlta) "
lcSql = lcSql + "VALUES ( "
lcSql = lcSql + ALLTRIM(STR(lnIdCompraC)) + ", "
lcSql = lcSql + ALLTRIM(STR(This.idProv)) + ", "
lcSql = lcSql + ALLTRIM(STR(This.idCondPago)) + ", "
lcSql = lcSql + ALLTRIM(STR(This.idSitIVA)) + ", "
lcSql = lcSql + "'" + ALLTRIM(This.razsocpv) + "', "
lcSql = lcSql + "'" + ALLTRIM(This.cuitpv) + "', "
lcSql = lcSql + loDT.toMySql(This.fecEmis) + ", "
lcSql = lcSql + loDT.toMySql(This.fecVto) + ", "
lcSql = lcSql + "'" + ALLTRIM(lcCbte) + "', "
lcSql = lcSql + "'" + ALLTRIM(This.tipodoc) + "', "
lcSql = lcSql + "'" + ALLTRIM(STR(This.ptovta)) + "', "
lcSql = lcSql + "'" + ALLTRIM(STR(This.numcbte)) + "', "
lcSql = lcSql + ALLTRIM(STR(This.nogravado, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(This.totNeto, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(This.aliciva21, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(This.impiva21, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(This.aliciva105, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(This.impiva105, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(This.retiva, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(This.retiibb, 10, 2)) + ", "
lcSql = lcSql + IIF(This.retiibb <> 0, ALLTRIM(STR(pcias.idprovin)), "NULL") + ", "
lcSql = lcSql + ALLTRIM(STR(This.retgan, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(This.retsuss, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(This.impuestos, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(This.totFinal, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(This.saldo, 10, 2)) + ", "
lcSql = lcSql + "'" + ALLTRIM(This.observ) + "', "
lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
lcSql = lcSql + "current_timestamp, "
lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "')"

loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = lcSql

IF !loCommand.Execute() THEN
	goConn.Rollback()
	This.error_message = loCommand.ErrorMessage
	RETURN .F.
ENDIF

lnIdCompraD = 1
SELECT comprasdet
GO TOP
DO WHILE !EOF("comprasdet")
	lcSql = "INSERT INTO comprasdet ( "
	lcSql = lcSql + "idCompraD, "
	lcSql = lcsql + "idCompraC, "
	lcSql = lcSql + "idArticulo, "
	lcSql = lcSql + "codArt, "
	lcSql = lcSql + "descripcio, "
	lcSql = lcSql + "idUniMed, "
	lcSql = lcSql + "cantidad, "
	lcSql = lcSql + "cantPack, "
	lcSql = lcSql + "cantNC, "
	lcSql = lcSql + "prLista, "
	lcSql = lcSql + "porDesc1, "
	lcSql = lcSql + "porDesc2, "
	lcSql = lcSql + "porDesc3, "
	lcSql = lcSql + "porDesc4, "
	lcSql = lcSql + "impDesc1, "
	lcSql = lcSql + "impDesc2, "
	lcSql = lcSql + "impDesc3, "
	lcSql = lcSql + "impDesc4, "
	lcSql = lcSql + "costoNeto, "
	lcSql = lcSql + "alicIVA, "
	lcSql = lcSql + "impIVA, "
	lcSql = lcSql + "costoFinal, "
	lcSql = lcSql + "totNeto, "
	lcSql = lcSql + "totFinal) "
	lcSql = lcSql + "VALUES ( "
	lcSql = lcSql + ALLTRIM(STR(lnIdCompraD)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnIdCompraC)) + ", "
	lcSql = lcSql + ALLTRIM(STR(comprasdet.idArticulo)) + ", "
	lcSql = lcSql + "'" + ALLTRIM(comprasdet.codArt) + "', "
	lcSql = lcSql + "'" + ALLTRIM(comprasdet.descripcio) + "', "
	lcSql = lcSql + ALLTRIM(STR(comprasdet.idUniMed)) + ", "
	lcSql = lcSql + ALLTRIM(STR(comprasdet.cantidad, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(comprasdet.cantPack, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(comprasdet.cantNC, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(comprasdet.prLista, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(comprasdet.porDesc1, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(comprasdet.porDesc2, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(comprasdet.porDesc3, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(comprasdet.porDesc4, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(comprasdet.impDesc1, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(comprasdet.impDesc2, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(comprasdet.impDesc3, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(comprasdet.impDesc4, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(comprasdet.costoNeto, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(comprasdet.alicIVA, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(comprasdet.impIVA, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(comprasdet.costoFinal, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(comprasdet.totNeto, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(comprasdet.totFinal, 10, 2)) + ")"
		
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute() THEN
		goConn.Rollback()
		This.error_message = loCommand.ErrorMessage
		RETURN .F.
	ENDIF
	
	lnIdCompraD = lnIdCompraD + 1
	SELECT comprasdet
	SKIP
ENDDO

&& Ahora tengo que recorrer el cursor que corresponde con el detalle
&& de los conceptos de la factura para el grabado de los mismos
lnIdCpaDCP = 1
SELECT cpasdet_cp
GO TOP
DO WHILE !EOF("cpasdet_cp")
	lcSql = "INSERT INTO cpasdet_cp ( "
	lcSql = lcSql + "idCpaDCP, "
	lcSql = lcSql + "idCompraC, "
	lcSql = lcSql + "idPlanCta, "
	lcSql = lcSql + "idBanco, "
	lcSql = lcSql + "idCheque, "
	lcSql = lcSql + "cheque_nro, "
	lcSql = lcSql + "impNeto, "
	lcSql = lcSql + "ivaPor, "
	lcSql = lcSql + "ivaImp, "
	lcSql = lcSql + "total) "
	lcSql = lcSql + "VALUES ( "
	lcSql = lcSql + ALLTRIM(STR(lnIdCpaDCP)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnIdCompraC)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cpasdet_cp.idPlanCta)) + ", "
	lcSql = lcSql + IIF(cpasdet_cp.idBanco = 0, "NULL", ALLTRIM(STR(cpasdet_cp.idBanco))) + ", "
	lcSql = lcSql + IIF(cpasdet_cp.idCheque = 0, "NULL", ALLTRIM(STR(cpasdet_cp.idCheque))) + ", "
	lcSql = lcSql + IIF(ALLTRIM(cpasdet_cp.cheque_nro) == "", "NULL", "'" + ALLTRIM(cpasdet_cp.cheque_nro) + "'") + ", "
	lcSql = lcSql + ALLTRIM(STR(cpasdet_cp.impNeto, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cpasdet_cp.ivaPor, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cpasdet_cp.ivaImp, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cpasdet_cp.total, 10, 2)) + ")"
	
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute() THEN
		goConn.Rollback()
		This.error_message = loCommand.ErrorMessage
		RETURN .F.
	ENDIF
	
	lnIdCpaDCP = lnIdCpaDCP + 1
	SELECT cpasdet_cp
	SKIP
ENDDO 


&& Grabo las retenciones
lnIdCompraR = 1
SELECT comprasret
GO TOP
DO WHILE !EOF("comprasret")
	lcSql = "INSERT INTO comprasret( "
	lcSql = lcSql + "idCompraR, "
	lcSql = lcsql + "idCompraC, "
	lcSql = lcSql + "Tipo, "
	lcSql = lcSql + "idProvin, "
	lcSql = lcSql + "importe) "
	lcSql = lcSql + "VALUES ( "
	lcSql = lcSql + ALLTRIM(STR(lnIdCompraR)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnIdCompraC)) + ", "
	lcSql = lcSql + "'" + ALLTRIM(comprasret.Tipo) + "', "
	lcSql = lcSql + ALLTRIM(STR(comprasret.idProvin)) + ", "
	lcSql = lcSql + ALLTRIM(STR(comprasret.importe, 10, 2)) + ")"
		
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute() THEN
		goConn.Rollback()
		This.error_message = loCommand.ErrorMessage
		RETURN .F.
	ENDIF
	
	lnIdCompraR = lnIdCompraR + 1
	SELECT comprasret
	SKIP
ENDDO


&& Procedo al grabado de la cuenta corriente
lnIdCCProv = goConn.GetNextID("cc_prov", "idCC_Prov")

IF This.idOper = 0 THEN
	lnIdOper = goConn.GetNextID("cc_prov", "idOper")
ELSE
	lnIdOper = This.idOper
ENDIF

IF ALLTRIM(lcCbte) == "FC" .OR. ALLTRIM(lcCbte) == "ND" THEN
	lcSql = "INSERT INTO cc_prov (idCC_Prov, "
	lcSql = lcSql + "idCompraC, "
	lcSql = lcSql + "idProv, "
	lcSql = lcSql + "idOper, "
	lcSql = lcSql + "idSitIVA, "
	lcSql = lcSql + "idCondPago, "
	lcSql = lcSql + "cbte, "
	lcSql = lcSql + "tipoDoc, "
	lcSql = lcSql + "ptoVta, "
	lcSql = lcSql + "nroCbte, "
	lcSql = lcSql + "fecEmis, "
	lcSql = lcSql + "fecVto, "
	lcSql = lcSql + "impDebe, "
	lcSql = lcSql + "impHaber, "
	lcSql = lcSql + "observ, "
	lcSql = lcSql + "usuAlta, "
	lcSql = lcSql + "fecAlta, "
	lcSql = lcSql + "idHostAlta) "
	lcSql = lcSql + "VALUES ( "
	lcSql = lcSql + ALLTRIM(STR(lnIdCCProv)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnIdCompraC)) + ", "
	lcSql = lcSql + ALLTRIM(STR(This.idProv)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnIdOper)) + ", "
	lcSql = lcSql + ALLTRIM(STR(This.idsitiva)) + ", "
	lcSql = lcSql + ALLTRIM(STR(This.idcondpago)) + ", "
	lcSql = lcSql + "'" + ALLTRIM(lcCbte) + "', "
	lcSql = lcSql + "'" + ALLTRIM(This.tipodoc) + "', "
	lcSql = lcSql + ALLTRIM(STR(This.ptovta)) + ", "
	lcSql = lcSql + ALLTRIM(STR(This.numcbte)) + ", "
	lcSql = lcSql + loDT.toMySql(This.fecemis) + ", "
	lcSql = lcSql + loDT.toMySql(This.fecvto) + ", "
	lcSql = lcSql + ALLTRIM(STR(This.totfinal, 10, 2)) + ", "
	lcSql = lcSql + "0, "
	lcSql = lcSql + "'',"
	lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
	lcSql = lcSql + "current_timestamp, "
	lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "')"
ELSE
	lcSql = "INSERT INTO cc_prov (idCC_Prov, "
	lcSql = lcSql + "idCompraC, "
	lcSql = lcSql + "idProv, "
	lcSql = lcSql + "idOper, "
	lcSql = lcSql + "idSitIVA, "
	lcSql = lcSql + "idCondPago, "
	lcSql = lcSql + "cbte, "
	lcSql = lcSql + "tipoDoc, "
	lcSql = lcSql + "ptoVta, "
	lcSql = lcSql + "nroCbte, "
	lcSql = lcSql + "fecEmis, "
	lcSql = lcSql + "fecVto, "
	lcSql = lcSql + "impDebe, "
	lcSql = lcSql + "impHaber, "
	lcSql = lcSql + "observ, "
	lcSql = lcSql + "usuAlta, "
	lcSql = lcSql + "fecAlta, "
	lcSql = lcSql + "idHostAlta) "
	lcSql = lcSql + "VALUES ( "
	lcSql = lcSql + ALLTRIM(STR(lnIdCCProv)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnIdCompraC)) + ", "
	lcSql = lcSql + ALLTRIM(STR(This.idProv)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnIdOper)) + ", "
	lcSql = lcSql + ALLTRIM(STR(This.idsitiva)) + ", "
	lcSql = lcSql + ALLTRIM(STR(This.idcondpago)) + ", "
	lcSql = lcSql + "'" + ALLTRIM(lcCbte) + "', "
	lcSql = lcSql + "'" + ALLTRIM(This.tipodoc) + "', "
	lcSql = lcSql + ALLTRIM(STR(This.ptovta)) + ", "
	lcSql = lcSql + ALLTRIM(STR(This.numcbte)) + ", "
	lcSql = lcSql + loDT.toMySql(This.fecemis) + ", "
	lcSql = lcSql + loDT.toMySql(This.fecvto) + ", "
	lcSql = lcSql + "0, "
	lcSql = lcSql + ALLTRIM(STR(This.totfinal, 10, 2)) + ", "
	lcSql = lcSql + "'',"
	lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
	lcSql = lcSql + "current_timestamp, "
	lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "')"
ENDIF

loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = lcSql

IF !loCommand.Execute() THEN
	This.error_message = loCommand.ErrorMessage
	RETURN .F.
ENDIF

&& Verifico si tiene algun comprobante asociado. Si lo tiene
&& entonces actualizo el saldo.
IF (This.idcomprac_orig <> 0) THEN
	lcSql = "UPDATE comprascab "
	lcSql = lcSql + "SET comprascab.saldo = comprascab.totFinal - " + ALLTRIM(STR(This.totfinal, 10, 2)) + " "
	lcSql = lcSql + "WHERE comprascab.idCompraC = " + ALLTRIM(STR(this.idcomprac_orig))
	
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute() THEN
		This.Error_message = loCommand.ErrorMessage
		RETURN .F.
	ENDIF
ENDIF

goConn.Commit()
RETURN .T.
ENDPROC
PROCEDURE agregar_detalle
PARAMETERS tnIdArticulo, tnCantidad, tnCantPack, tnPrLista,;
	tnPorDesc1, tnPorDesc2, tnPorDesc3, tnPorDesc4, tnCostoRep, ;
	tnAlicIVA, tnImpIVA, tnCostoFinal, tnSTNeto, tnSTFinal

LOCAL lcCodArt, lcDescripcio, lnAlicIVA, lnImpIVA
LOCAL lnIdUniMed
LOCAL lnImpDesc1, lnImpDesc2, lnImpDesc3, lnImpDesc4
LOCAL lnIDescITM1, lnIDescITM2, lnIDescITM3, lnIDescITM4
LOCAL lnIRecITM, lnCostoFinal, lnTotNeto, lnTotFinal
LOCAL loResult, lcSql
LOCAL lnNroReng

lnNroReng = 0
lcCodArt = ""
lcDescripcio = ""
lnIdUniMed = 0
lnAlicIVA = 0.00
lnImpIVA = 0.00
lnImpDesc1 = 0.00
lnImpDesc2 = 0.00
lnImpDesc3 = 0.00
lnImpDesc4 = 0.00

lcSql = ""
loResult = CREATEOBJECT("odbc_result")

lcSql = "SELECT * "
lcSql = lcSql + "FROM articulos "
lcSql = lcSql + "WHERE idArticulo = " + ALLTRIM(STR(tnIdArticulo))

loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_artic"

IF !loResult.OpenQuery(lcSql) THEN
	MESSAGEBOX(loResult.Error_Message, 0+48, Thisform.Caption)
	RETURN 
ENDIF

SELECT cur_artic
IF RECCOUNT("cur_artic") > 0 THEN
	lnIdUniMed = cur_artic.idUniMed
	lcCodArt = ALLTRIM(cur_artic.codArt)
	lcDescripcio = ALLTRIM(cur_artic.descripcio)
ELSE
	This.error_message = "El artículo no se encuentra cargado en la base de datos"
	RETURN .F.
ENDIF

loResult.Close_Query()

lnImpDesc1 = tnPrLista * (tnPorDesc1 / 100)
lnImpDesc2 = (tnPrLista - lnImpDesc1) * (tnPorDesc2 / 100)
lnImpDesc3 = (tnPrLista - lnImpDesc1 - lnImpDesc2) * (tnPorDesc3 / 100)
lnImpDesc4 = (tnPrLista - lnImpDesc1 - lnImpDesc2 - lnImpDesc3) * (tnPorDesc4 / 100)

SELECT MAX(idCompraD) AS maxID FROM comprasdet ;
INTO CURSOR cur_temp

IF ISNULL(cur_temp.maxID) THEN
	lnNroReng = 1
ELSE
	lnNroReng = cur_temp.maxID + 1
ENDIF

USE IN cur_temp

&& Genero el registro del detalle que después tengo que grabar en la tabla
&& fisica
SELECT comprasdet
APPEND BLANK
REPLACE comprasdet.idCompraD WITH lnNroReng
REPLACE comprasdet.idCompraC WITH 0 ADDITIVE
REPLACE comprasdet.idArticulo WITH tnIdArticulo ADDITIVE
REPLACE comprasdet.codArt WITH ALLTRIM(lcCodArt) ADDITIVE
REPLACE comprasdet.descripcio WITH ALLTRIM(lcDescripcio) ADDITIVE
REPLACE comprasdet.idUniMed WITH lnIdUniMed ADDITIVE
REPLACE comprasdet.cantidad WITH tnCantidad ADDITIVE
REPLACE comprasdet.cantPack WITH tnCantPack ADDITIVE
REPLACE comprasdet.cantNC WITH 0 ADDITIVE
REPLACE comprasdet.prLista WITH tnPrLista ADDITIVE
REPLACE comprasdet.porDesc1 WITH tnPorDesc1 ADDITIVE
REPLACE comprasdet.porDesc2 WITH tnPorDesc2 ADDITIVE
REPLACE comprasdet.porDesc3 WITH tnPorDesc3 ADDITIVE
REPLACE comprasdet.porDesc4 WITH tnPorDesc4 ADDITIVE
REPLACE comprasdet.impDesc1 WITH lnImpDesc1 ADDITIVE
REPLACE comprasdet.impDesc2 WITH lnImpDesc2 ADDITIVE
REPLACE comprasdet.impDesc3 WITH lnImpDesc3 ADDITIVE
REPLACE comprasdet.impDesc4 WITH lnImpDesc4 ADDITIVE
REPLACE comprasdet.costoNeto WITH tnCostoRep ADDITIVE
REPLACE comprasdet.alicIVA WITH tnAlicIVA ADDITIVE
REPLACE comprasdet.impIVA WITH tnImpIVA ADDITIVE
REPLACE comprasdet.costoFinal WITH tnCostoFinal ADDITIVE
REPLACE comprasdet.totNeto WITH tnSTNeto ADDITIVE
REPLACE comprasdet.totFinal WITH tnSTFinal ADDITIVE

RETURN .T.
ENDPROC
PROCEDURE agregar_detalle_cp
PARAMETERS tnIdCompraC, tnIdPlanCta, tcCodPlanCta, tcDescripcio, tnIdBanco, tnIdCheque, tnImpNeto, tnPorIVA

&& En este método tengo que ver bien como es que debo chequear
&& la validación de cheques rechazados puntualmente.

LOCAL lnImpIVA
LOCAL lnTotal

lnImpIVA = 0.00
lnTotal = 0.00

lnImpIVA = ROUND(tnImpNeto * (tnPorIVA / 100), 2)
lnTotal = tnImpNeto + lnImpIVA

SELECT cpasdet_cp
APPEND BLANK
REPLACE cpasdet_cp.idCpaCP WITH RECCOUNT("cpasdet_cp")
REPLACE cpasdet_cp.idCompraC WITH tnIdCompraC ADDITIVE
REPLACE cpasdet_cp.idPlanCta WITH tnIdPlanCta ADDITIVE
REPLACE cpasdet_cp.codPlanCta WITH ALLTRIM(tcCodPlanCta) ADDITIVE

IF tnIdBanco <> 0 THEN
	REPLACE cpasdet_cp.idBanco WITH tnIdBanco ADDITIVE
ENDIF

IF tnIdCheque <> 0 THEN
	REPLACE cpasdet_cp.idCheque WITH tnIdCheque ADDITIVE
ENDIF

REPLACE cpasdet_cp.descripcio WITH tcDescripcio ADDITIVE
REPLACE cpasdet_cp.impNeto WITH tnImpNeto ADDITIVE
REPLACE cpasdet_cp.ivaPor WITH tnPorIVA ADDITIVE
REPLACE cpasdet_cp.ivaImp WITH lnImpIVA ADDITIVE
REPLACE cpasdet_cp.total WITH lnTotal ADDITIVE
ENDPROC
PROCEDURE calcular_costoneto
PARAMETERS tnPrLista, tnPorDesc1, tnPorDesc2, tnPorDesc3, tnPorDesc4

LOCAL lnImpDesc1, lnImpDesc2, lnImpDesc3, lnImpDesc4
LOCAL lnCostoNeto

lnImpDesc1 = 0.00
lnImpDesc2 = 0.00
lnImpDesc3 = 0.00
lnImpDesc4 = 0.00
lnCostoNeto = 0.00

&& Calculo el descuento del proveedor
*!*	lnImpDesc1 = ROUND(tnPrLista * (tnPorDesc1 / 100),  2)
*!*	lnImpDesc2 = ROUND((tnPrLista - lnImpDesc1) * (tnPorDesc2 / 100), 2)
*!*	lnImpDesc3 = ROUND((tnPrLista - lnImpDesc1 - lnImpDesc2) * (tnPorDesc3 / 100), 2)
*!*	lnImpDesc4 = ROUND((tnPrLista - lnImpDesc1 - lnImpDesc2 - lnImpDesc3) * (tnPorDesc4 /100), 2)

*!*	lnCostoNeto = tnPrLista - lnImpDesc1 - lnImpDesc2 - lnImpDesc3 - lnImpDesc4

lnImpDesc1 = tnPrLista * (tnPorDesc1 / 100)
lnImpDesc2 = (tnPrLista - lnImpDesc1) * (tnPorDesc2 / 100)
lnImpDesc3 = (tnPrLista - lnImpDesc1 - lnImpDesc2) * (tnPorDesc3 / 100)
lnImpDesc4 = (tnPrLista - lnImpDesc1 - lnImpDesc2 - lnImpDesc3) * (tnPorDesc4 /100)

lnCostoNeto = ROUND(tnPrLista - lnImpDesc1 - lnImpDesc2 - lnImpDesc3 - lnImpDesc4, 2)

RETURN lnCostoNeto
ENDPROC
PROCEDURE calcular_costofinal
PARAMETERS tnCostoNeto, tnImpIVA
RETURN tnCostoNeto + tnImpIVA
ENDPROC
PROCEDURE calcular_impiva
PARAMETERS tnCostoNeto, tnAlicIVA

RETURN (tnCostoNeto * (tnAlicIVA / 100))
ENDPROC
PROCEDURE calcular_totneto
PARAMETERS tnCostoNeto, tnCantidad

RETURN tnCostoNeto * tnCantidad
ENDPROC
PROCEDURE calcular_totfinal
PARAMETERS tnCantidad, tnTotNeto, tnImpIVA

RETURN ROUND(tnTotNeto + (tnImpIVA * tnCantidad), 2)
ENDPROC
PROCEDURE calcular_prlista
PARAMETERS tnCostoRep, tnPorDesc1, tnPorDesc2, tnPorDesc3, tnPorDesc4

LOCAL lnImpD1, lnImpD2, lnImpD3
LOCAL lnPrLista, lnCostoAux
LOCAL lnImpDAux1, lnImpDAux2, lnImpDAux3

lnImpD1 = 0.00
lnImpD2 = 0.00
lnImpD3 = 0.00
lnPrLista = 0.00
lnCostoAux = 0.00
lnImpDAux1 = 0.00
lnImpDAux2 = 0.00
lnImpDAux3 = 0.00

&& Hago el cáculo a la inversa para obtener
&& un precio de lista base
lnImpD3 = ROUND(tnCostoRep + (tnCostoRep * (tnPorDesc4 / 100)), 2)
lnImpD2 = ROUND(lnImpD3 + (lnImpD3 * (tnPorDesc3 / 100)), 2)
lnImpD1 = ROUND(lnImpD2 + (lnImpD2 * (tnPorDesc2 / 100)), 2)
lnPrLista = ROUND(lnImpD1 + (lnImpD1 * (tnPorDesc1 / 100)), 2)

&& Hago el cálculo a partir del precio de lista base obtenido
&& para calcular el costo que daría
lnImpDAux1 = ROUND(lnPrLista - (lnPrLista * (tnPorDesc1 / 100)), 2)
lnImpDAux2 = ROUND(lnImpDAux1 - (lnImpDAux1 * (tnPorDesc2 / 100)), 2)
lnImpDAux3 = ROUND(lnImpDAux2 - (lnImpDAux2 * (tnPorDesc3 / 100)), 2)
lnCostoAux = ROUND(lnImpDAux3 - (lnImpDAux3 * (tnPorDesc4 / 100)), 2)

&& Ahora procedo a hacer la búsqueda del precio de lista exacto a partir de la base
&& calculada.
DO WHILE lnCostoAux <> tnCostoRep
	IF lnCostoAux < tnCostoRep THEN
		lnPrLista = lnPrLista + 0.01
		lnImpDAux1 = ROUND(lnPrLista - (lnPrLista * (tnPorDesc1 / 100)), 2)
		lnImpDAux2 = ROUND(lnImpDAux1 - (lnImpDAux1 * (tnPorDesc2 / 100)), 2)
		lnImpDAux3 = ROUND(lnImpDAux2 - (lnImpDAux2 * (tnPorDesc3 / 100)), 2)
		lnCostoAux = ROUND(lnImpDAux3 - (lnImpDAux3 * (tnPorDesc4 / 100)), 2)
	ELSE
		IF lnCostoAux > tnCostoRep THEN
			lnPrLista = lnPrLista - 0.01
			lnImpDAux1 = ROUND(lnPrLista - (lnPrLista * (tnPorDesc1 / 100)), 2)
			lnImpDAux2 = ROUND(lnImpDAux1 - (lnImpDAux1 * (tnPorDesc2 / 100)), 2)
			lnImpDAux3 = ROUND(lnImpDAux2 - (lnImpDAux2 * (tnPorDesc3 / 100)), 2)
			lnCostoAux = ROUND(lnImpDAux3 - (lnImpDAux3 * (tnPorDesc4 / 100)), 2)
		ENDIF
	ENDIF
ENDDO

RETURN lnPrLista
ENDPROC
PROCEDURE totalizar_cbte
LOCAL lcSql
LOCAL loRes
LOCAL lnNoGravado
LOCAL lnTotalNeto
LOCAL lnAlicIVA21
LOCAL lnImpIVA21
LOCAL lnAlicIVA105
LOCAL lnImpIVA105
LOCAL lnPercepciones
LOCAL lnTotalFinal
LOCAL lnCantidad
LOCAL lnUltPos

lcSql = ""
loRes = CREATEOBJECT("odbc_result")
lnNoGravado = 0.00
lnTotalNeto = 0.00
lnAlicIVA21 = 0.00
lnImpIVA21 = 0.00
lnAlicIVA105 = 0.00
lnImpIVA105 = 0.00
lnPercepciones = 0.00
lnTotalFinal = 0.00
lnCantidad = 0.00
lnImpuestos = this.impuestos
lnUltPos = 0

&& Recorro el detalle de mercadería de reventa
SELECT comprasdet
lnUltPos = RECNO("comprasdet")
GO TOP

DO WHILE !EOF("comprasdet")
	lnCantidad = comprasdet.cantidad
	lnTotalNeto = lnTotalNeto + (comprasdet.costoNeto * lnCantidad)
	
*!*		IF comprasdet.alicIVA = 21 THEN
*!*			lnAlicIVA21 = comprasdet.alicIVA
*!*			lnImpIVA21 = lnImpIVA21 + ROUND(comprasdet.costoNeto * (lnAlicIVA21 / 100), 2) * lnCantidad
*!*		ELSE
*!*			lnAlicIVA105 = comprasdet.alicIVA
*!*			lnImpIVA105 = lnImpIVA105 + ROUND(comprasdet.costoNeto * (lnAlicIVA105 / 100), 2) * lnCantidad
*!*		ENDIF
	
	IF comprasdet.alicIVA = 21 THEN
		lnAlicIVA21 = comprasdet.alicIVA
		lnImpIVA21 = lnImpIVA21 + comprasdet.costoNeto * (lnAlicIVA21 / 100) * lnCantidad
	ELSE
		lnAlicIVA105 = comprasdet.alicIVA
		lnImpIVA105 = lnImpIVA105 + comprasdet.costoNeto * (lnAlicIVA105 / 100) * lnCantidad
	ENDIF
	
	SELECT comprasdet
	SKIP
ENDDO

SELECT comprasdet
GO TOP

&& Ahora recorro el detalle de conceptos
SELECT cpasdet_cp
lnUltPos = RECNO("cpasdet_cp")
GO TOP
DO WHILE !EOF("cpasdet_cp")
		
	IF cpasdet_cp.ivaPor = 21 THEN
		lnAlicIVA21 = cpasdet_cp.ivaPor
		lnImpIVA21 = lnImpIVA21 + cpasdet_cp.ivaImp
		lnTotalNeto = lnTotalNeto + cpasdet_cp.impNeto
	ELSE
		IF cpasdet_cp.ivaPor = 10.5 THEN 
			lnAlicIVA105 = cpasdet_cp.ivaPor
			lnImpIVA105 = lnImpIVA105 + cpasdet_cp.ivaImp
			lnTotalNeto = lnTotalNeto + cpasdet_cp.impNeto
		ELSE 
			lnNoGravado = lnNoGravado + cpasdet_cp.impNeto
		ENDIF 
	ENDIF
	
	SELECT cpasdet_cp
	SKIP
ENDDO

SELECT cpasdet_cp
GO TOP

lnPercepciones = this.retiva + this.retiibb + this.retgan + this.retsuss

lnTotalFinal = lnNoGravado + lnTotalNeto + lnImpIVA21 + lnImpIVA105 + lnPercepciones + lnImpuestos

This.nogravado = lnNoGravado 
This.totneto = lnTotalNeto
This.aliciva21 = lnAlicIVA21
This.aliciva105 = lnAlicIVA105
This.impiva21 = lnImpIVA21
This.impiva105 = lnImpIVA105
This.percepciones = lnPercepciones
This.totfinal = lnTotalFinal

IF ALLTRIM(This.cbte) == "FC" THEN
	This.saldo = lnTotalFinal
ELSE
	This.saldo = 0.00
ENDIF
ENDPROC
PROCEDURE limpiar
This.idcondpago = 0
This.idprov = 0
This.idsitiva = 0
This.impiva105 = 0.00
This.impiva21 = 0.00
This.nogravado = 0.00
This.numcbte = 0
This.observ = ""
This.ptovta = 0
This.razsocpv = ""
This.retiva = 0.00
This.retiibb = 0.00
This.retgan = 0.00
This.retsuss = 0.00
This.percepciones = 0.00
This.saldo = 0.00
This.tipodoc = ""
This.cbte = ""
This.totFinal = 0.00
This.totNeto = 0.00
This.cbte = "FC"
This.aliciva105 = 0
This.aliciva21 = 0
This.fecemis = {}
This.fecvto = {}
this.impuestos = 0.00

SELECT comprasdet
ZAP
SELECT cpasdet_cp
ZAP
SELECT comprasret
ZAP 
ENDPROC
PROCEDURE eliminar_articulo
SELECT comprasdet
DELETE

This.totalizar_cbte()
ENDPROC
PROCEDURE eliminar_cp
SELECT cpasdet_cp
DELETE

This.totalizar_cbte()
ENDPROC
PROCEDURE articulo_duplicado
PARAMETERS tnIdArticulo

SELECT comprasdet
GO TOP
LOCATE FOR comprasdet.idArticulo = tnIdArticulo

IF FOUND("comprasdet") THEN
	This.error_message = "El artículo ya existe en el detalle. ¿Desea agregarlo de todas formas?"
	RETURN .F.
ENDIF

RETURN .T.
ENDPROC
PROCEDURE concepto_duplicado
PARAMETERS tnIdPlanCta

SELECT cpasdet_cp
GO TOP
LOCATE FOR cpasdet_cp.idPlanCta = tnIdPlanCta

IF FOUND("cpasdet_cp") THEN
	This.error_message = "El concepto ya ha sido cargado en el detalle. ¿Está seguro que desea agregar otro concepto?"
	RETURN .F.
ENDIF

RETURN .T.
ENDPROC
PROCEDURE agregar_detalle_ret
PARAMETERS tnTipo, tnIdProvin, tnProvincia, tnImporte

LOCAL lnNroReng

lnNroReng = 0

SELECT MAX(idCompraR) AS maxID FROM comprasret ;
INTO CURSOR cur_temp

IF ISNULL(cur_temp.maxID) THEN
	lnNroReng = 1
ELSE
	lnNroReng = cur_temp.maxID + 1
ENDIF

USE IN cur_temp

&& Genero el registro de retencion que después tengo que grabar en la tabla fisica
SELECT comprasret
APPEND BLANK
REPLACE comprasret.idCompraR WITH lnNroReng
REPLACE comprasret.idCompraC WITH 0 ADDITIVE
REPLACE comprasret.Tipo WITH tnTipo ADDITIVE
REPLACE comprasret.idProvin WITH tnidProvin ADDITIVE
REPLACE comprasret.Provincia WITH tnProvincia ADDITIVE
REPLACE comprasret.Importe WITH tnImporte ADDITIVE


RETURN .T.
ENDPROC
PROCEDURE eliminar_ret
SELECT comprasret
DELETE

This.totalizar_cbte()
ENDPROC


************************************************************
OBJETO: cc_data_ccprov
************************************************************
*** PROPIEDADES ***
error_message = 
saldo_total = 0.00
Name = "cc_data_ccprov"

*** METODOS ***
PROCEDURE leer_ctacte
PARAMETERS tnIdProv

LOCAL loRes
LOCAL lcSql
LOCAL lnIdOperAnt
LOCAL lnSaldo
LOCAL lnSaldoTot 
LOCAL lnBandera

loRes = CREATEOBJECT("odbc_result")
lcSql = ""
lnIdOperAnt = 0
lnSaldo = 0.00
lnSaldoTot = 0.00
lnBandera = 0

SELECT cc_pv
ZAP

lcSql = "SELECT	cc1.*, "
lcSql = lcSql + "(CASE WHEN operfc.fecfc is null THEN (CASE WHEN operadnd.fecadnd is null THEN fecemis ELSE operadnd.fecadnd END) ELSE operfc.fecfc END) AS fecha, "
lcSql = lcSql + "(CASE WHEN cbte = 'FC' OR cbte = 'FCSL' OR cbte = 'FCI' OR cbte = 'FDI' THEN  1 ELSE "
lcSql = lcSql + "	(CASE WHEN cbte = 'OP' OR cbte = 'PA' THEN  4 ELSE "
lcSql = lcSql + "		(CASE WHEN cbte = 'NC' THEN  5 ELSE "
lcSql = lcSql + "			(CASE WHEN cbte = 'ACP' THEN  6 ELSE "
lcSql = lcSql + "				(CASE WHEN cbte = 'ADP' THEN  3 ELSE "
lcSql = lcSql + "					(CASE WHEN cbte = 'ND' THEN  2 ELSE "
lcSql = lcSql + "						(CASE WHEN cbte = 'AN' THEN  2 ELSE 0 END) "
lcSql = lcSql + "					END) "
lcSql = lcSql + "				END) "
lcSql = lcSql + "			END) "
lcSql = lcSql + "		END) "
lcSql = lcSql + "	END) "
lcSql = lcSql + "END) AS Orden2 "
lcSql = lcSql + "FROM cc_prov AS cc1 "
lcSql = lcSql + " 	left join ( SELECT idoper, MAX(fecemis) AS 'fecfc' "
lcSql = lcSql + " 				FROM cc_prov "
lcSql = lcSql + " 				WHERE cbte = 'FC' and idoper != 0"
lcSql = lcSql + " 				GROUP BY idoper) AS operfc ON cc1.idoper = operfc.idoper "
lcSql = lcSql + " 	left join ( SELECT idoper, MAX(fecemis) AS 'fecadnd' "
lcSql = lcSql + " 				FROM cc_prov "
lcSql = lcSql + " 				WHERE cbte IN ('ADP','ND') and idoper != 0"
lcSql = lcSql + " 				GROUP BY idoper) AS operadnd ON cc1.idoper = operadnd.idoper "
lcSql = lcSql + "WHERE	cc1.idProv = " + ALLTRIM(STR(tnIdProv)) + " "
lcSql = lcSql + "	AND cc1.idOper IN ( SELECT	cc2.idOper "
lcSql = lcSql + "       FROM	cc_prov AS cc2 "
lcSql = lcSql + "       WHERE	cc2.idProv = " + ALLTRIM(STR(tnIdProv)) + " "
lcSql = lcSql + " 			AND (UsuBaja IS NULL OR UsuBaja = '') "
lcSql = lcSql + "		GROUP BY cc2.idOper HAVING ROUND(SUM(cc2.impDebe - cc2.impHaber),2) <> 0) "
lcSql = lcSql + " 	AND (UsuBaja IS NULL OR UsuBaja = '') "
lcSql = lcSql + "ORDER BY fecha, cc1.idOper, Orden2, nroCbte"

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_temp"

IF !loRes.OpenQuery(lcSql) THEN
	This.error_message = loRes.Error_Message
	RETURN .F.
ENDIF

SELECT cur_temp
IF RECCOUNT("cur_temp") > 0 THEN
	GO TOP
	lnIdOperAnt = cur_temp.idOper
ENDIF

DO WHILE !EOF("cur_temp")
	SELECT cc_pv
	APPEND BLANK
	REPLACE cc_pv.sel WITH .F. 
	REPLACE cc_pv.idCC_Prov WITH cur_temp.idCC_Prov ADDITIVE
	REPLACE cc_pv.idCompraC WITH cur_temp.idCompraC ADDITIVE
	REPLACE cc_pv.idOper WITH cur_temp.idOper ADDITIVE
	REPLACE cc_pv.fecEmis WITH cur_temp.fecEmis ADDITIVE
	REPLACE cc_pv.fecVto WITH cur_temp.fecVto ADDITIVE
	REPLACE cc_pv.cbte WITH cur_temp.cbte ADDITIVE
	REPLACE cc_pv.tipoDoc WITH cur_temp.tipoDoc ADDITIVE	
	REPLACE cc_pv.ptoVta WITH REPLICATE("0", 4 - LEN(ALLTRIM(STR(cur_temp.ptoVta)))) + ALLTRIM(STR(cur_temp.ptoVta)) ADDITIVE
	REPLACE cc_pv.numCbte WITH REPLICATE("0", 8 - LEN(ALLTRIM(STR(cur_temp.nroCbte)))) + ALLTRIM(STR(cur_temp.nroCbte)) ADDITIVE	
	REPLACE cc_pv.nroCbte WITH ALLTRIM(cur_temp.cbte) + " " + ALLTRIM(cur_temp.tipoDoc) + " " + getPtoVta(cur_temp.ptoVta) + "-" + getNroCbte(cur_temp.nroCbte) ADDITIVE
	REPLACE cc_pv.impDebe WITH cur_temp.impDebe ADDITIVE
	REPLACE cc_pv.impHaber WITH cur_temp.impHaber ADDITIVE
	REPLACE cc_pv.observ WITH ALLTRIM(cur_temp.observ) ADDITIVE	

	IF lnIdOperAnt != cur_temp.idOper THEN
		IF lnBandera = 0 THEN
			lnBandera = 1
		ELSE
			lnBandera = 0
		ENDIF

		IF cur_temp.impDebe <> 0 THEN
			lnSaldo = cur_temp.impDebe
		ELSE
			lnSaldo = cur_temp.impHaber * -1
		ENDIF
	ELSE		
		IF cur_temp.impDebe <> 0 THEN
			lnSaldo = lnSaldo + cur_temp.impDebe
		ELSE
			lnSaldo = lnSaldo - cur_temp.impHaber
		ENDIF
	ENDIF
		
	REPLACE cc_pv.saldo WITH lnSaldo ADDITIVE
	REPLACE cc_pv.bandera WITH lnBandera ADDITIVE
	
	lnSaldoTot = lnSaldoTot + IIF(cur_temp.impDebe <> 0, cur_temp.impdebe, (cur_temp.imphaber * -1))
	
	lnIdOperAnt = cur_temp.idOper
	
	SELECT cur_temp
	SKIP
ENDDO

loRes.Close_Query()

SELECT cc_pv
IF RECCOUNT("cc_pv") > 0 THEN
	GO TOP
ENDIF

This.saldo_total = lnSaldoTot 

RETURN .T.
ENDPROC
PROCEDURE crear_cursor
CREATE CURSOR cc_pv (	;
	sel	l,;
	idCC_Prov 	int,;
	idCompraC 	int null,;
	idOper 		int null,;
	fecEmis 	date,;
	fecVto 		date null,;
	cbte		varchar(3),;
	tipoDoc		varchar(1),;
	ptoVta		varchar(4),;
	numCbte		varchar(8),;
	nroCbte 	varchar(20),;
	impDebe 	double,;
	impHaber 	double,;
	saldo 		double,;
	observ 		varchar(254),;
	bandera 	int)

ENDPROC
PROCEDURE calc_saldo_actual
PARAMETERS tnIdOper, tnIdProv

LOCAL loRes
LOCAL lcSql
LOCAL lnSaldo

loRes = CREATEOBJECT("odbc_result")
lcSql = ""
lnSaldo = 0.00

IF tnIdOper <> 0 THEN
	lcSql = "SELECT ROUND((SUM(cc_prov.impDebe) - SUM(cc_prov.impHaber)),2) AS saldo "
	lcSql = lcSql + "FROM cc_prov "
	lcSql = lcSql + "WHERE cc_prov.idOper = " + ALLTRIM(STR(tnIdOper)) + " "
	lcSql = lcSql + " AND cc_prov.idProv = " + ALLTRIM(STR(tnIdProv)) + " "
	lcSql = lcSql + " AND (UsuBaja IS NULL OR UsuBaja = '') "
ELSE
	lcSql = "SELECT ROUND((SUM(cc_prov.impDebe) - SUM(cc_prov.impHaber)),2) AS saldo "
	lcSql = lcSql + "FROM cc_prov "
	lcSql = lcSql + "WHERE idProv = " + ALLTRIM(STR(tnIdProv)) + " "
	lcSql = lcSql + " AND (UsuBaja IS NULL OR UsuBaja = '') "
ENDIF

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_saldo"

IF !loRes.OpenQuery(lcSql) THEN
	This.error_message = loRes.Error_Message
	RETURN -1
ENDIF

SELECT cur_saldo
GO TOP
lnSaldo = cur_saldo.saldo

loRes.Close_Query()

RETURN lnSaldo
ENDPROC
PROCEDURE leer_oper_by_cbte
PARAMETERS tnIdCompraC

LOCAL loRes
LOCAL lcSql
LOCAL lnIdOper

loRes = CREATEOBJECT("odbc_result")
lcSql = ""
lnIdOper = 0 

lcSql = "SELECT idOper FROM cc_prov "
lcSql = lcSql + "WHERE idCompraC = " + ALLTRIM(STR(tnIdCompraC))

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_temp"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN -1
ENDIF

SELECT cur_temp
lnIdOper = IIF(ISNULL(cur_temp.idOper), 0, cur_temp.idOper)

loRes.Close_Query()

RETURN lnIdOper
ENDPROC


************************************************************
OBJETO: cls_resumen_por_cptos
************************************************************
*** PROPIEDADES ***
Height = 539
Width = 962
DoCreate = .T.
Caption = "Resumen de compras por conceptos"
Name = "cls_resumen_por_cptos"
contenido.Top = -1
contenido.Left = -1
contenido.Width = 964
contenido.Height = 542
contenido.Name = "contenido"

*** METODOS ***
PROCEDURE Load
DODEFAULT()
CREATE CURSOR cur_resumen ( ;
	anio int,;
	mes int,;
	idPlanCta int,;
	codPlanCta varchar(20),;
	descripcio varchar(60),;
	totalNeto double,;
	totalIvaImp double,;
	total double)
ENDPROC
PROCEDURE Init
SELECT cur_resumen
this.contenido.grdResult.alias_name = "cur_resumen"
this.contenido.grdResult.RecordSource = "cur_resumen"
this.contenido.grdResult.list_controlsource = "codPlanCta,descripcio,totalNeto,totalIvaImp,total"
this.contenido.grdResult.lista_ancho_cols = "120,250,100,100,100"
this.contenido.grdResult.titulos_cabeceras = "Código,Concepto,Tot. Neto, Tot. IVA, Total"
this.contenido.grdResult.generar_grid()
this.contenido.cntFiltros.txtAnio.Value = YEAR(DATETIME())
this.contenido.cntFiltros.txtMes.Value = MONTH(DATETIME())


ENDPROC


************************************************************
OBJETO: cntFiltros
************************************************************
*** PROPIEDADES ***
Top = 4
Left = 3
Width = 956
Height = 69
Name = "cntFiltros"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Parámetros"
Left = 18
Top = 5
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Año:"
Height = 15
Left = 63
Top = 24
Width = 43
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Mes:"
Height = 15
Left = 134
Top = 25
Width = 43
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: txtAnio
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 63
Top = 38
Width = 64
isinteger = .T.
Name = "txtAnio"

*** METODOS ***


************************************************************
OBJETO: txtMes
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 136
Top = 38
Width = 64
isinteger = .T.
Name = "txtMes"

*** METODOS ***


************************************************************
OBJETO: btnBuscar
************************************************************
*** PROPIEDADES ***
Top = 12
Left = 877
Name = "btnBuscar"

*** METODOS ***
PROCEDURE Click
LOCAL loRes
LOCAL lcSql

loRes = CREATEOBJECT("odbc_result")
lcSql = "CALL compras_getResumenByCpto (?anio, ?mes)"
lcSql = loRes.AddParameter(lcSql, "anio", ALLTRIM(STR(this.Parent.txtAnio.Value)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "mes", ALLTRIM(STR(this.Parent.txtMes.Value)), .f., .f.)
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"
loRes.OpenQuery(lcSql)
SELECT cur_resumen
ZAP
APPEND FROM DBF("cur_x")
loRes.Close_Query()
SELECT cur_resumen
GO TOP
Thisform.contenido.grdResult.Refresh()

SELECT ;
	SUM(totalNeto) AS totalNeto, ;
	SUM(totalIvaImp) AS totalIvaImp, ;
	SUM(total) AS total ;
FROM cur_resumen ;
INTO CURSOR cur_x

SELECT cur_x
this.Parent.Parent.txtTotalNeto.Value = cur_x.totalNeto
this.Parent.Parent.txttotaIvaImp.Value = cur_x.totalIvaImp
this.Parent.Parent.txtTotal.Value = cur_x.total
USE IN cur_x
ENDPROC


************************************************************
OBJETO: grdResult
************************************************************
*** PROPIEDADES ***
Height = 360
Left = 4
Top = 75
Width = 955
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdResult"
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


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Total Neto:"
Height = 15
Left = 682
Top = 441
Width = 64
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: txtTotalNeto
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 682
Top = 455
Width = 87
isinteger = .F.
isnumeric = .T.
Name = "txtTotalNeto"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Total I.V.A.:"
Height = 15
Left = 777
Top = 441
Width = 64
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: txtTotaIvaImp
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 777
Top = 455
Width = 87
isinteger = .F.
isnumeric = .T.
Name = "txtTotaIvaImp"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Total:"
Height = 15
Left = 871
Top = 441
Width = 64
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: txtTotal
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 871
Top = 455
Width = 87
isinteger = .F.
isnumeric = .T.
Name = "txtTotal"

*** METODOS ***


************************************************************
OBJETO: btnSalir
************************************************************
*** PROPIEDADES ***
Top = 485
Left = 912
Name = "btnSalir"

*** METODOS ***


************************************************************
OBJETO: cls_resumen_por_cptos
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_frm_ivacpas
************************************************************
*** PROPIEDADES ***
BorderStyle = 2
Height = 135
Width = 404
DoCreate = .T.
Caption = "Listado IVA Compras"
Name = "cls_frm_ivacpas"

*** METODOS ***
PROCEDURE generar_listado
LOCAL loRes
LOCAL lcSql
LOCAL loDT

loDT = CREATEOBJECT("datetime")
loRes = CREATEOBJECT("odbc_result")
lcSql = ""

lcSql = "CALL compras_libroIVA (?pAnio, ?pMes)"
lcSql = loRes.AddParameter(lcSql, "pAnio", ALLTRIM(STR(thisform.txtAnio.Value)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "pMes", ALLTRIM(STR(thisform.txtMes.Value)), .f., .f.)
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_tempo"
loRes.OpenQuery(lcSql)

SELECT cur_tempo
IF RECCOUNT("cur_tempo") > 0 THEN 
	RETURN .T.
ELSE
	MESSAGEBOX("No hay registros para exportar",0+48,thisform.Caption)
	loRes.Close_Query()
	RETURN .F.
ENDIF 


ENDPROC
PROCEDURE generar_citicab
LOCAL loRes
LOCAL lcSql
LOCAL lnFileHandler
LOCAL lcFileName
LOCAL lcLinea

lcSql = "CALL citicpas_generarCitiCpa (?anio, ?mes)"
loRes = CREATEOBJECT("odbc_result")
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_citicpa"

lcSql = loRes.AddParameter(lcSql, "anio", ALLTRIM(STR(thisform.txtAnio.Value)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "mes", ALLTRIM(STR(thisform.txtMes.Value)), .f., .f.)
loRes.OpenQuery(lcSql)

lcFileName = "citicpa-cabecera-" + ALLTRIM(STR(thisform.txtAnio.Value)) ;
	+ ALLTRIM(STR(thisform.txtMes.Value)) + ".txt"
lcFileName = PUTFILE("Guardar como:", lcFileName, "txt")
lnFileHandler = FCREATE(lcFileName)

SELECT cur_citicpa
GO TOP
DO WHILE !EOF("cur_citicpa")
	lcLinea = cur_citicpa.fecEmis 	;
		+ cur_citicpa.tipoCbte		;
		+ cur_citicpa.ptoVta		;
		+ cur_citicpa.nroCbte		;
		+ cur_citicpa.nroDespImp	;
		+ cur_citicpa.codDoc		;
		+ cur_citicpa.cuitPV		;
		+ cur_citicpa.razSocPV		;
		+ cur_citicpa.impTotOper	;
		+ cur_citicpa.ImpConceptos	;
		+ cur_citicpa.ioe			;
		+ cur_citicpa.impPercValAg	;
		+ cur_citicpa.impPercOIN	;
		+ cur_citicpa.impPerIIBB	;
		+ cur_citicpa.impPerImpMun	;
		+ cur_citicpa.impImpInt		;
		+ cur_citicpa.codMon		;
		+ cur_citicpa.tipoCbio		;
		+ cur_citicpa.cantAlicIVA	;
		+ cur_citicpa.codOper		;
		+ cur_citicpa.credFisComp	;
		+ cur_citicpa.otrosTrib		;
		+ cur_citicpa.cuitEmisCorr	;
		+ cur_citicpa.denomEmisCorr	;
		+ cur_citicpa.ivaCom + CHR(13) + CHR(10)
	
	FWRITE(lnFileHandler, lcLinea)

	SELECT cur_citicpa
	SKIP
ENDDO

loRes.Close_Query()
FCLOSE(lnFileHandler)

ENDPROC
PROCEDURE generar_citialic
LOCAL loRes
LOCAL lcSql
LOCAL lnFileHandler
LOCAL lcFileName
LOCAL lcLinea

lcSql = "SELECT * FROM citicpa_alic"
loRes = CREATEOBJECT("odbc_result")
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_citialic"
loRes.OpenQuery(lcSql)
lcFileName = "citicpa-alicuotas-" + ALLTRIM(STR(thisform.txtAnio.Value)) ;
	+ ALLTRIM(STR(thisform.txtMes.Value)) + ".txt"
lcFileName = PUTFILE("Guardar como:", lcFileName, "txt")
lnFileHandler = FCREATE(lcFileName)

SELECT cur_citialic
GO TOP
DO WHILE !EOF("cur_citialic")
	lcLinea = cur_citialic.tipoCbte ;
		+ cur_citialic.ptoVta 		;
		+ cur_citialic.nroCbte 		;
		+ cur_citialic.codDocVdor 	;
		+ cur_citialic.cuitPV 		;
		+ cur_citialic.impNetoGrav 	;
		+ cur_citialic.alicIVA 		;
		+ cur_citialic.impLiq + CHR(13) + CHR(10)
	
	FWRITE(lnFileHandler, lcLinea)

	SELECT cur_citialic
	SKIP
ENDDO

loRes.Close_Query()
FCLOSE(lnFileHandler)

ENDPROC
PROCEDURE Load
DODEFAULT()

CREATE CURSOR cur_iva ( ;
	fecEmis d,;
	cbte varchar(3),;
	tipoDoc varchar(1),;
	ptoVta varchar(4),;
	numCbte varchar(8),;
	provincia varchar(30),;
	categ varchar(3),;
	nroDoc varchar(13),;
	neto_grav float(10,2),;
	neto_no_grav float(10,2),;
	iva_21 float(10,2),;
	iva_105 float(10,2),;
	retiva float(10,2),;
	retiibb float(10,2),;
	retgan float(10,2),;
	retsuss float(10,2),;
	impuestos float(10,2),;
	total float(10,2))
ENDPROC
PROCEDURE Init
thisform.txtAnio.Value = YEAR(DATE())
thisform.txtMes.Value = MONTH(DATE())
ENDPROC


************************************************************
OBJETO: CLSETIQUETA1
************************************************************
*** PROPIEDADES ***
Caption = "Mes:"
Height = 15
Left = 43
Top = 31
Width = 38
TabIndex = 7
Name = "CLSETIQUETA1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Año:"
Height = 15
Left = 210
Top = 31
Width = 40
TabIndex = 8
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: txtMes
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 92
TabIndex = 1
Top = 26
Width = 100
isdatetime = .F.
isinteger = .T.
Name = "txtMes"

*** METODOS ***


************************************************************
OBJETO: txtAnio
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 250
TabIndex = 2
Top = 26
Width = 100
isdatetime = .F.
isinteger = .T.
Name = "txtAnio"

*** METODOS ***


************************************************************
OBJETO: btnImprimir
************************************************************
*** PROPIEDADES ***
Top = 84
Left = 7
Picture = ..\imagen\iconos bajados\aha-soft-large-business-printer.ico
TabIndex = 3
Name = "btnImprimir"

*** METODOS ***
PROCEDURE Click
LOCAL m.periodo

m.periodo = ALLTRIM(STR(thisform.txtMes.Value)) + "/" + ALLTRIM(STR(thisform.txtAnio.Value))

IF Thisform.generar_listado() THEN
	SELECT cur_iva
	ZAP
	SELECT cur_tempo
	GO TOP
	
	DO WHILE !EOF("cur_tempo")
		SELECT cur_iva		
		APPEND BLANK
		REPLACE cur_iva.fecEmis WITH cur_tempo.FecEmision
		REPLACE cur_iva.cbte WITH cur_tempo.cbte ADDITIVE
		REPLACE cur_iva.tipoDoc WITH cur_tempo.tipoDoc ADDITIVE
		REPLACE cur_iva.ptoVta WITH REPLICATE("0", 4 - LEN(ALLTRIM(STR(cur_tempo.ptoVta)))) + ALLTRIM(STR(cur_tempo.ptoVta)) ADDITIVE
		REPLACE cur_iva.numCbte WITH REPLICATE("0", 8 - LEN(ALLTRIM(STR(cur_tempo.numCbte)))) + ALLTRIM(STR(cur_tempo.numCbte)) ADDITIVE
		REPLACE cur_iva.provincia WITH ALLTRIM(cur_tempo.juris) ADDITIVE
		REPLACE cur_iva.categ WITH ALLTRIM(cur_tempo.cat) ADDITIVE
		REPLACE cur_iva.nroDoc WITH ALLTRIM(cur_tempo.nroCUIT) ADDITIVE
		REPLACE cur_iva.neto_grav WITH cur_tempo.neto_grav ADDITIVE
		REPLACE cur_iva.neto_no_grav WITH cur_tempo.neto_no_grav ADDITIVE
		REPLACE cur_iva.iva_21 WITH cur_tempo.IVA_21 ADDITIVE
		REPLACE cur_iva.iva_105 WITH cur_tempo.IVA_105 ADDITIVE
		REPLACE cur_iva.retiva WITH cur_tempo.retIVA ADDITIVE
		REPLACE cur_iva.retIIBB WITH cur_tempo.retIIBB ADDITIVE
		REPLACE cur_iva.retGan WITH cur_tempo.retGan ADDITIVE
		REPLACE cur_iva.retSUSS WITH cur_tempo.retSUSS ADDITIVE
		REPLACE cur_iva.impuestos WITH cur_tempo.impuestos ADDITIVE
		REPLACE cur_iva.total WITH cur_tempo.total ADDITIVE
	
		SELECT cur_tempo
		SKIP
	ENDDO
	
	SELECT cur_iva
	GO TOP
	REPORT FORM "rep_iva_compras" TO PRINTER PROMPT NODIALOG PREVIEW
ENDIF 


ENDPROC


************************************************************
OBJETO: Clscerrar1
************************************************************
*** PROPIEDADES ***
Top = 85
Left = 348
TabIndex = 6
Name = "Clscerrar1"

*** METODOS ***


************************************************************
OBJETO: btnExport
************************************************************
*** PROPIEDADES ***
Top = 84
Left = 55
Picture = ..\imagen\excel.ico
TabIndex = 4
Name = "btnExport"

*** METODOS ***
PROCEDURE Click
IF Thisform.generar_listado() THEN 
	genexcel("cur_tempo", "Listado IVA Compras")
ENDIF 
ENDPROC


************************************************************
OBJETO: btnExportarCITI
************************************************************
*** PROPIEDADES ***
Top = 84
Left = 105
Height = 44
Width = 45
Picture = ..\imagen\floppy_drive.ico
TabIndex = 5
ToolTipText = "Generar archivos CITI Ventas"
Name = "btnExportarCITI"

*** METODOS ***
PROCEDURE Click
WAIT WINDOW "Procesando, espere por favor..." NOWAIT
Thisform.generar_citicab()
Thisform.generar_citialic()
MESSAGEBOX("Los archivos fueron generados satisfactoriamente", 0+64, Thisform.Caption)
ENDPROC


************************************************************
OBJETO: cls_frm_ivacpas
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_frmcons_ccpv
************************************************************
*** PROPIEDADES ***
BorderStyle = 1
Height = 295
Width = 747
DoCreate = .T.
Caption = "Listado de Cuentas Corrientes de Proveedores"
Name = "cls_frmcons_ccpv"
CONTENIDO.Name = "CONTENIDO"

*** METODOS ***
PROCEDURE resumen
PARAMETERS lnIdProvDD, lnIdProvHH

LOCAL loRes, lcSql

loRes = CREATEOBJECT("odbc_result")
lcSql = ""

lcSql = "SELECT proveedor.idProv, "
lcSql = lcSql + " proveedor.razSoc, "
lcSql = lcSql + " proveedor.telefono, "
lcSql = lcSql + " proveedor.email, "
lcSql = lcSql + " ROUND(SUM(cc_prov.impdebe - cc_prov.imphaber),2) as Saldo "
lcSql = lcSql + "FROM proveedor "
lcSql = lcSql + "	INNER JOIN cc_prov ON cc_prov.idProv = proveedor.idProv "
lcSql = lcSql + "WHERE cc_prov.idProv >= " + ALLTRIM(STR(lnIdProvDD)) + " AND cc_prov.idProv <= " + ALLTRIM(STR(lnIdProvHH)) + " "
lcSql = lcSql + "	AND (cc_prov.usubaja is null or cc_prov.usubaja = '') "
lcSql = lcSql + "GROUP BY proveedor.idProv, "
lcSql = lcSql + " 		proveedor.razsoc, "
lcSql = lcSql + " 		proveedor.telefono, "
lcSql = lcSql + " 		proveedor.email "
lcSql = lcSql + "HAVING ROUND(SUM(cc_prov.impdebe - cc_prov.imphaber),2) != 0 "
lcSql = lcSql + "ORDER BY proveedor.idProv "	

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_tempo"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_tempo
IF RECCOUNT() > 0      
 GO TOP 
ENDIF

SELECT cur_resumen
ZAP

SELECT cur_tempo
DO WHILE !EOF("cur_tempo")
	SELECT cur_resumen
	APPEND BLANK
	REPLACE cur_resumen.Codigo WITH cur_tempo.idProv ADDITIVE 
	REPLACE cur_resumen.RazSoc WITH cur_tempo.razsoc ADDITIVE
	REPLACE cur_resumen.telefono WITH cur_tempo.telefono ADDITIVE 
	REPLACE cur_resumen.email WITH cur_tempo.email ADDITIVE 
	REPLACE cur_resumen.saldo WITH cur_tempo.saldo ADDITIVE 
	
	SELECT cur_tempo
	SKIP 
ENDDO 

loRes.close_query()

SELECT cur_resumen
IF RECCOUNT() > 0
	GO top
ELSE 
	RETURN .F.
ENDIF

RETURN .T.
ENDPROC
PROCEDURE cbtesconsaldos
PARAMETERS lnIdProvDD, lnIdProvHH, lcFecEmisDesde, lcFecEmisHasta

LOCAL loRes, lcSql

loRes = CREATEOBJECT("odbc_result")
lcSql = ""

lcSql = "SELECT cc_prov.idProv, "
lcSql = lcSql + "	proveedor.razSoc, "
lcSql = lcSql + "	cc_prov.fecEmis, "
lcSql = lcSql + "	cc_prov.fecVto, "
lcSql = lcSql + "	cc_prov.idOper, "
lcSql = lcSql + " 	cc_prov.observ, "
lcSql = lcSql + "	cc_prov.cbte, "
lcSql = lcSql + "	cc_prov.tipoDoc, "
lcSql = lcSql + "	cc_prov.ptoVta, "
lcSql = lcSql + "	cc_prov.nroCbte, "
lcSql = lcSql + "	ROUND(cc_prov.impDebe,2) AS Debe, "
lcSql = lcSql + "	ROUND(cc_prov.impHaber,2) AS Haber, "
lcSql = lcSql + " 	ROUND(cc_prov.impdebe - cc_prov.imphaber,2) AS Saldo, "
lcSql = lcSql + "(CASE WHEN operfc.fecfc is null THEN (CASE WHEN operadnd.fecadnd is null THEN fecemis ELSE operadnd.fecadnd END) ELSE operfc.fecfc END) AS fecha, "
lcSql = lcSql + "(CASE WHEN cbte = 'FC' OR cbte = 'FCSL' OR cbte = 'FCI' OR cbte = 'FDI' THEN  1 ELSE "
lcSql = lcSql + "	(CASE WHEN cbte = 'OP' OR cbte = 'PA' THEN  4 ELSE "
lcSql = lcSql + "		(CASE WHEN cbte = 'NC' THEN  5 ELSE "
lcSql = lcSql + "			(CASE WHEN cbte = 'ACP' THEN  6 ELSE "
lcSql = lcSql + "				(CASE WHEN cbte = 'ADP' THEN  3 ELSE "
lcSql = lcSql + "					(CASE WHEN cbte = 'ND' THEN  2 ELSE "
lcSql = lcSql + "						(CASE WHEN cbte = 'AN' THEN  2 ELSE 0 END) "
lcSql = lcSql + "					END) "
lcSql = lcSql + "				END) "
lcSql = lcSql + "			END) "
lcSql = lcSql + "		END) "
lcSql = lcSql + "	END) "
lcSql = lcSql + "END) AS Orden2 "
lcSql = lcSql + "FROM cc_prov "
lcSql = lcSql + "	INNER JOIN proveedor ON proveedor.idProv = cc_prov.idProv "
lcSql = lcSql + " 	left join ( SELECT idoper, MAX(fecemis) AS 'fecfc' "
lcSql = lcSql + " 				FROM cc_prov "
lcSql = lcSql + " 				WHERE cbte = 'FC' and idoper != 0"
lcSql = lcSql + " 				GROUP BY idoper) AS operfc ON cc_prov.idoper = operfc.idoper "
lcSql = lcSql + " 	left join ( SELECT idoper, MAX(fecemis) AS 'fecadnd' "
lcSql = lcSql + " 				FROM cc_prov "
lcSql = lcSql + " 				WHERE cbte IN ('ADP','ND') and idoper != 0"
lcSql = lcSql + " 				GROUP BY idoper) AS operadnd ON cc_prov.idoper = operadnd.idoper "
lcSql = lcSql + " 	left join ( SELECT cc2.idoper, ROUND(SUM(cc2.impdebe - cc2.imphaber),2) as SaldoTot "
lcSql = lcSql + " 				FROM cc_prov cc2 "
lcSql = lcSql + " 				WHERE cc2.idProv >= " + ALLTRIM(STR(lnIdProvDD)) + " and cc2.idProv <= " +  ALLTRIM(STR(lnIdProvHH)) + " "
lcSql = lcSql + "         			and (cc2.usubaja is null or cc2.usubaja = '') "
lcSql = lcSql + "         			and idoper != 0 "
lcSql = lcSql + "         		GROUP BY cc2.idoper) AS Saldos ON cc_prov.idoper = Saldos.idoper "
lcSql = lcSql + "WHERE cc_prov.idProv >= " + ALLTRIM(STR(lnIdProvDD)) + " AND cc_prov.idProv <= " + ALLTRIM(STR(lnIdProvHH)) + " "

IF INT(VAL(getConfig("SQLSRV"))) = 1 THEN
	lcSql = lcSql + "         and CONVERT(CHAR(8), fecemis, 112) between " + lcFecEmisDesde + " and " + lcFecEmisHasta + " "
ELSE
	lcSql = lcSql + "         and CAST(fecemis AS DATE) between " + lcFecEmisDesde + " and " + lcFecEmisHasta + " "
ENDIF

lcSql = lcSql + "         and (cc_prov.usubaja is null or cc_prov.usubaja = '') "
lcSql = lcSql + "         and (SaldoTot != 0 or SaldoTot is null) "
lcSql = lcSql + "ORDER BY cc_prov.idProv, fecha, cc_prov.idOper, Orden2, cc_prov.nrocbte"

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_tempo"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_tempo
IF RECCOUNT() > 0      
 GO TOP 
ENDIF
 
SELECT cur_todosmov
ZAP

SELECT cur_tempo
DO WHILE !EOF()
	SELECT cur_todosmov
	APPEND BLANK
	REPLACE Codigo WITH cur_tempo.idProv ADDITIVE 
	REPLACE RazSoc WITH cur_tempo.razsoc ADDITIVE
	REPLACE idoper WITH cur_tempo.idoper ADDITIVE 
	REPLACE observ WITH IIF(ISNULL(cur_tempo.observ), "", cur_tempo.observ) ADDITIVE
	REPLACE fecemis WITH cur_tempo.fecemis ADDITIVE
	REPLACE fecha WITH cur_tempo.fecha ADDITIVE  
	REPLACE cbte WITH cur_tempo.cbte ADDITIVE 
	REPLACE tipodoc WITH cur_tempo.tipodoc ADDITIVE
	REPLACE numCbte WITH getPtoVta(cur_tempo.ptoVta) + "-" + getNroCbte(cur_tempo.nroCbte) ADDITIVE
   	REPLACE debe WITH cur_tempo.debe ADDITIVE
   	REPLACE haber WITH cur_tempo.haber ADDITIVE   
	REPLACE saldo WITH cur_tempo.saldo ADDITIVE 
	
	SELECT cur_tempo
	SKIP 
ENDDO 

loRes.close_query()

SELECT cur_todosmov
IF RECCOUNT() > 0
	GO top
ELSE 
	RETURN .F.
ENDIF 

RETURN .T.
ENDPROC
PROCEDURE fcconsaldos
PARAMETERS lnIdProvDD, lnIdProvHH, lcFecEmisDesde, lcFecEmisHasta

LOCAL loRes, lcSql

loRes = CREATEOBJECT("odbc_result")
lcSql = ""

lcSql = "SELECT cc_prov.idProv, "
lcSql = lcSql + "	proveedor.razSoc, "
lcSql = lcSql + "	cc_prov.fecEmis, "
lcSql = lcSql + "	cc_prov.fecVto, "
lcSql = lcSql + "	cc_prov.idOper, "
lcSql = lcSql + " 	cc_prov.observ, "
lcSql = lcSql + "	cc_prov.cbte, "
lcSql = lcSql + "	cc_prov.tipoDoc, "
lcSql = lcSql + "	cc_prov.ptoVta, "
lcSql = lcSql + "	cc_prov.nroCbte, "
lcSql = lcSql + " 	ROUND(cc_prov.impdebe,2) AS Debe, "
lcSql = lcSql + " 	ROUND(cc_prov.imphaber,2) AS Haber, "
lcSql = lcSql + " 	ROUND(cc_prov.impdebe - cc_prov.imphaber,2) AS Saldo, "

IF ALLTRIM(getconfig("SQLSRV")) == "1" THEN
	lcSql = lcSql + " (CASE WHEN Saldos.SaldoTot is null THEN ROUND(cc_prov.impdebe - cc_prov.imphaber,2) ELSE Saldos.SaldoTot END) AS SaldoTot "
ELSE 
	IF ALLTRIM(getconfig("SQLSRV")) == "0" THEN
		lcSql = lcSql + " (CASE WHEN Saldos.SaldoTot is null THEN ROUND(cc_prov.impdebe - cc_prov.imphaber,2) ELSE Saldos.SaldoTot END) AS SaldoTot "
	ENDIF
ENDIF 

lcSql = lcSql + "FROM cc_prov "
lcSql = lcSql + "		INNER JOIN proveedor ON proveedor.idProv = cc_prov.idProv "
lcSql = lcSql + " 	left join ( SELECT cc2.idoper, ROUND(SUM(cc2.impdebe - cc2.imphaber),2) as SaldoTot "
lcSql = lcSql + " 				FROM cc_prov cc2 "
lcSql = lcSql + " 				WHERE cc2.idProv >= " + ALLTRIM(STR(lnIdProvDD)) + " and cc2.idProv <= " +  ALLTRIM(STR(lnIdProvHH)) + " "
lcSql = lcSql + "         			and (cc2.usubaja is null or cc2.usubaja = '') "
lcSql = lcSql + "         			and idoper != 0 "
lcSql = lcSql + "         		GROUP BY cc2.idoper) AS Saldos ON cc_prov.idoper = Saldos.idoper "
lcSql = lcSql + "WHERE cc_prov.idProv >= " + ALLTRIM(STR(lnIdProvDD)) + " AND cc_prov.idProv <= " + ALLTRIM(STR(lnIdProvHH)) + " "

IF INT(VAL(getConfig("SQLSRV"))) = 1 THEN
	lcSql = lcSql + "         and CONVERT(CHAR(8), fecemis, 112) between " + lcFecEmisDesde + " and " + lcFecEmisHasta + " "
ELSE
	lcSql = lcSql + "         and CAST(fecemis AS DATE) between " + lcFecEmisDesde + " and " + lcFecEmisHasta + " "
ENDIF

lcSql = lcSql + "         and (cc_prov.usubaja is null or cc_prov.usubaja = '') "
lcSql = lcSql + "         and (SaldoTot <> 0 or SaldoTot is null) "
lcSql = lcSql + "         and cbte = 'FC' "
lcSql = lcSql + "ORDER BY cc_prov.idProv, cc_prov.fecemis, cc_prov.idOper, cc_prov.nrocbte"

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_tempo"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_tempo
IF RECCOUNT() > 0      
 GO TOP 
ENDIF

SELECT cur_fcsaldos
ZAP

SELECT cur_tempo
DO WHILE !EOF()
	SELECT cur_fcsaldos
	APPEND BLANK
	REPLACE Codigo WITH cur_tempo.idprov ADDITIVE
	REPLACE RazSoc WITH cur_tempo.razsoc ADDITIVE
	REPLACE idoper WITH cur_tempo.idoper ADDITIVE 
	REPLACE observ WITH IIF(ISNULL(cur_tempo.observ), "", cur_tempo.observ) ADDITIVE
	REPLACE fecemis WITH cur_tempo.fecemis ADDITIVE
	REPLACE cbte WITH cur_tempo.cbte ADDITIVE 
	REPLACE tipodoc WITH cur_tempo.tipodoc ADDITIVE
	REPLACE numCbte WITH getPtoVta(cur_tempo.ptoVta) + "-" + getNroCbte(cur_tempo.nroCbte) ADDITIVE
   	REPLACE debe WITH cur_tempo.debe ADDITIVE
   	REPLACE haber WITH cur_tempo.haber ADDITIVE   
	REPLACE saldo WITH cur_tempo.saldo ADDITIVE 
	REPLACE saldotot WITH cur_tempo.saldotot ADDITIVE 
	
	SELECT cur_tempo
	SKIP 
ENDDO 

loRes.close_query()

SELECT cur_fcsaldos
IF RECCOUNT() > 0
	GO TOP
ELSE 
	RETURN .F.
ENDIF 

RETURN .T.
ENDPROC
PROCEDURE todosmov
PARAMETERS lnIdProvDD, lnIdProvHH, lcFecEmisDesde, lcFecEmisHasta

LOCAL loRes, lcSql


loRes = CREATEOBJECT("odbc_result")
lcSql = ""

lcSql = "SELECT cc_prov.idProv, "
lcSql = lcSql + "	proveedor.razSoc, "
lcSql = lcSql + "	cc_prov.fecEmis, "
lcSql = lcSql + "	cc_prov.fecVto, "
lcSql = lcSql + "	cc_prov.idOper, "
lcSql = lcSql + " 	cc_prov.observ, "
lcSql = lcSql + "	cc_prov.cbte, "
lcSql = lcSql + "	cc_prov.tipoDoc, "
lcSql = lcSql + "	cc_prov.ptoVta, "
lcSql = lcSql + "	cc_prov.nroCbte, "
lcSql = lcSql + "	ROUND(cc_prov.impDebe,2) AS Debe, "
lcSql = lcSql + "	ROUND(cc_prov.impHaber,2) AS Haber, "
lcSql = lcSql + " 	ROUND(cc_prov.impdebe - cc_prov.imphaber,2) AS Saldo, "
lcSql = lcSql + "(CASE WHEN operfc.fecfc is null THEN (CASE WHEN operadnd.fecadnd is null THEN fecemis ELSE operadnd.fecadnd END) ELSE operfc.fecfc END) AS fecha, "
lcSql = lcSql + "(CASE WHEN cbte = 'FC' OR cbte = 'FCSL' OR cbte = 'FCI' OR cbte = 'FDI' THEN  1 ELSE "
lcSql = lcSql + "	(CASE WHEN cbte = 'OP' OR cbte = 'PA' THEN  4 ELSE "
lcSql = lcSql + "		(CASE WHEN cbte = 'NC' THEN  5 ELSE "
lcSql = lcSql + "			(CASE WHEN cbte = 'ACP' THEN  6 ELSE "
lcSql = lcSql + "				(CASE WHEN cbte = 'ADP' THEN  3 ELSE "
lcSql = lcSql + "					(CASE WHEN cbte = 'ND' THEN  2 ELSE "
lcSql = lcSql + "						(CASE WHEN cbte = 'AN' THEN  2 ELSE 0 END) "
lcSql = lcSql + "					END) "
lcSql = lcSql + "				END) "
lcSql = lcSql + "			END) "
lcSql = lcSql + "		END) "
lcSql = lcSql + "	END) "
lcSql = lcSql + "END) AS Orden2 "
lcSql = lcSql + "FROM cc_prov "
lcSql = lcSql + "		INNER JOIN proveedor ON proveedor.idProv = cc_prov.idProv "
lcSql = lcSql + " 	left join ( SELECT idoper, MAX(fecemis) AS 'fecfc' "
lcSql = lcSql + " 				FROM cc_prov "
lcSql = lcSql + " 				WHERE cbte = 'FC' and idoper != 0"
lcSql = lcSql + " 				GROUP BY idoper) AS operfc ON cc_prov.idoper = operfc.idoper "
lcSql = lcSql + " 	left join ( SELECT idoper, MAX(fecemis) AS 'fecadnd' "
lcSql = lcSql + " 				FROM cc_prov "
lcSql = lcSql + " 				WHERE cbte IN ('ADP','ND') and idoper != 0"
lcSql = lcSql + " 				GROUP BY idoper) AS operadnd ON cc_prov.idoper = operadnd.idoper "
lcSql = lcSql + "WHERE cc_prov.idProv >= " + ALLTRIM(STR(lnIdProvDD)) + " AND cc_prov.idProv <= " + ALLTRIM(STR(lnIdProvHH)) + " "

IF INT(VAL(getConfig("SQLSRV"))) = 1 THEN
	lcSql = lcSql + "         and CONVERT(CHAR(8), fecemis, 112) between " + lcFecEmisDesde + " and " + lcFecEmisHasta + " "
ELSE
	lcSql = lcSql + "         and CAST(fecemis AS DATE) between " + lcFecEmisDesde + " and " + lcFecEmisHasta + " "
ENDIF

lcSql = lcSql + "         and (cc_prov.usubaja is null or cc_prov.usubaja = '') "
lcSql = lcSql + "ORDER BY cc_prov.idProv, fecha, cc_prov.idOper, Orden2, cc_prov.nrocbte"

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_tempo"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_tempo
IF RECCOUNT() > 0      
 GO TOP 
ENDIF
 
SELECT cur_todosmov
ZAP

SELECT cur_tempo
DO WHILE !EOF()
	SELECT cur_todosmov
	APPEND BLANK
	REPLACE Codigo WITH cur_tempo.idProv ADDITIVE 
	REPLACE RazSoc WITH cur_tempo.razsoc ADDITIVE
	REPLACE idoper WITH cur_tempo.idoper ADDITIVE 
	REPLACE observ WITH IIF(ISNULL(cur_tempo.observ), "", cur_tempo.observ) ADDITIVE
	REPLACE fecemis WITH cur_tempo.fecemis ADDITIVE
	REPLACE fecha WITH cur_tempo.fecha ADDITIVE  
	REPLACE cbte WITH cur_tempo.cbte ADDITIVE 
	REPLACE tipodoc WITH cur_tempo.tipodoc ADDITIVE
	REPLACE numCbte WITH getPtoVta(cur_tempo.ptoVta) + "-" + getNroCbte(cur_tempo.nroCbte) ADDITIVE
   	REPLACE debe WITH cur_tempo.debe ADDITIVE
   	REPLACE haber WITH cur_tempo.haber ADDITIVE   
	REPLACE saldo WITH cur_tempo.saldo ADDITIVE 
	
	SELECT cur_tempo
	SKIP 
ENDDO 

loRes.close_query()

SELECT cur_todosmov
IF RECCOUNT() > 0
	GO top
ELSE 
	RETURN .F.
ENDIF 

RETURN .T.
ENDPROC
PROCEDURE saldosparc
PARAMETERS lnIdProvDD, lnIdProvHH, lcFecEmisDesde, lcFecEmisHasta

LOCAL loRes
LOCAL loRSA
LOCAL lcSql
LOCAL lnSaldo
LOCAL lnIdProvAnt

loRes = CREATEOBJECT("odbc_result")
loRSA = CREATEOBJECT("odbc_result")
lcSql = ""
lnIdProvAnt = 0
lnSaldo = 0.00 

&& Calculo el saldo anterior
lcSql = "SELECT cc.idProv, "
lcSql = lcSql + "MAX(proveedor.razSoc) AS razSoc, "
IF INT(VAL(getConfig("SQLSRV"))) = 1 THEN
	lcSql = lcSql + "ISNULL(ROUND(SUM(cc.impDebe - cc.impHaber),2), 0) AS saldo "
ELSE
	lcSql = lcSql + "IFNULL(ROUND(SUM(cc.impDebe - cc.impHaber),2), 0) AS saldo "
ENDIF
lcSql = lcSql + "FROM cc_prov cc "
lcSql = lcSql + "  INNER JOIN proveedor ON proveedor.idProv = cc.idProv "
lcSql = lcSql + "WHERE cc.idProv >= " + ALLTRIM(STR(lnIdProvDD)) + " AND cc.idProv <= " + ALLTRIM(STR(lnIdProvHH)) + " "
lcSql = lcSql + "   AND (cc.usubaja is null or cc.usubaja = '') "

IF INT(VAL(getConfig("SQLSRV"))) = 1 THEN
	lcSql = lcSql + " AND CONVERT(CHAR(8), fecemis, 112) < " + lcFecEmisDesde + " "
ELSE
	lcSql = lcSql + " AND CAST(fecemis AS DATE) < " + lcFecEmisDesde + " "
ENDIF

lcSql = lcSql + "GROUP BY idProv "
lcSql = lcSql + "ORDER BY idProv "

loRSA.ActiveConnection = goConn.ActiveConnection
loRSA.Cursor_Name = "cur_sa"

IF !loRSA.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_sa
GO TOP


lcSql = "SELECT cc.idProv, "
lcSql = lcSql + " MAX(proveedor.razsoc) AS razsoc, "
lcSql = lcSql + " MAX(cc.observ) AS observ, "
lcSql = lcSql + " MAX(cc.fecemis) AS fecemis, "
lcSql = lcSql + " MAX(cc.fecVto) AS fecVto, "
lcSql = lcSql + " cc.cbte, "
lcSql = lcSql + " cc.tipoDoc, "
lcSql = lcSql + " cc.ptoVta, "
lcSql = lcSql + " cc.nroCbte, "
lcSql = lcSql + " ROUND(SUM(cc.impdebe),2) AS Debe, "
lcSql = lcSql + " ROUND(SUM(cc.imphaber),2) AS Haber, "
lcSql = lcSql + " ROUND(SUM(cc.impdebe - cc.imphaber),2) AS Saldo "
lcSql = lcSql + "FROM cc_prov cc "
lcSql = lcSql + "  INNER JOIN proveedor ON proveedor.idProv = cc.idProv "
lcSql = lcSql + "WHERE cc.idProv >= " + ALLTRIM(STR(lnIdProvDD)) + " AND cc.idProv <= " + ALLTRIM(STR(lnIdProvHH)) + " "
lcSql = lcSql + "   AND (cc.usubaja is null or cc.usubaja = '') "

IF INT(VAL(getConfig("SQLSRV"))) = 1 THEN
	lcSql = lcSql + "     AND CONVERT(CHAR(8), fecemis, 112) between " + lcFecEmisDesde + " and " + lcFecEmisHasta + " "
ELSE
	lcSql = lcSql + "     AND CAST(fecemis AS DATE) between " + lcFecEmisDesde + " and " + lcFecEmisHasta + " "
ENDIF

lcSql = lcSql + " GROUP BY cc.idProv, "
lcSql = lcSql + " 	cc.cbte, "
lcSql = lcSql + " 	cc.tipoDoc, "
lcSql = lcSql + " 	cc.ptoVta, "
lcSql = lcSql + " 	cc.nroCbte "
lcSql = lcSql + " ORDER BY cc.idProv, fecEmis, nroCbte"

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_tempo"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_tempo
IF RECCOUNT() > 0      
 GO TOP 
ENDIF

SELECT cur_saldoparc
ZAP

DO WHILE !EOF("cur_tempo")
	IF lnIdProvAnt <> cur_tempo.idProv THEN
		SELECT cur_sa
		GO TOP
		LOCATE FOR cur_sa.idProv = cur_tempo.idProv 
		
		IF FOUND() .AND. (cur_sa.saldo <> 0) THEN
			SELECT cur_saldoparc
			APPEND BLANK
			
			REPLACE Codigo WITH cur_sa.idProv 
			REPLACE razSoc WITH cur_sa.razSoc ADDITIVE
			REPLACE fecEmis WITH NULL ADDITIVE
			REPLACE fecVto WITH NULL ADDITIVE
			REPLACE cbte WITH "SAA" ADDITIVE
			REPLACE tipoDoc WITH "" ADDITIVE
			REPLACE numCbte WITH "Saldo Ant." ADDITIVE
			
			IF (cur_sa.saldo > 0) THEN
				REPLACE	Debe WITH cur_sa.saldo ADDITIVE
			ELSE
				REPLACE Haber WITH cur_sa.saldo * -1 ADDITIVE
			ENDIF
			
			REPLACE saldo WITH cur_sa.saldo ADDITIVE
		
*!*				lnSaldo = cur_sa.saldo
*!*			ELSE
*!*				lnSaldo = 0
*!*			ENDIF
*!*		
*!*			IF cur_tempo.Debe <> 0 THEN
*!*				lnSaldo = lnSaldo + cur_tempo.Debe
*!*			ELSE
*!*				lnSaldo = lnSaldo - cur_tempo.Haber
*!*			ENDIF
*!*		ELSE
*!*			IF cur_tempo.Debe <> 0 THEN
*!*				lnSaldo = lnSaldo + cur_tempo.Debe
*!*			ELSE
*!*				lnSaldo = lnSaldo - cur_tempo.Haber
		ENDIF
	ENDIF

	SELECT cur_saldoparc
	APPEND BLANK
	
	REPLACE Codigo WITH cur_tempo.idProv 
	REPLACE razSoc WITH cur_tempo.razSoc ADDITIVE
	REPLACE observ WITH IIF(ISNULL(cur_tempo.observ), "", cur_tempo.observ) ADDITIVE
	REPLACE fecEmis WITH IIF(ISNULL(cur_tempo.fecEmis), "-", cur_tempo.fecEmis) ADDITIVE
	REPLACE fecVto WITH IIF(ISNULL(cur_tempo.fecVto ), "-", cur_tempo.fecVto ) ADDITIVE
	REPLACE cbte WITH cur_tempo.cbte ADDITIVE
	REPLACE tipoDoc WITH cur_tempo.tipoDoc ADDITIVE
	REPLACE numCbte WITH getPtoVta(cur_tempo.ptoVta) + "-" + getNroCbte(cur_tempo.nroCbte) ADDITIVE	
	REPLACE Debe WITH cur_tempo.Debe ADDITIVE
	REPLACE Haber WITH cur_tempo.Haber ADDITIVE	
	REPLACE saldo WITH cur_tempo.Saldo ADDITIVE
	
	lnIdProvAnt = cur_tempo.idProv 
	
	SELECT cur_tempo
	SKIP
ENDDO

loRSA.Close_Query()
loRes.Close_Query()

SELECT cur_saldoparc
IF RECCOUNT() > 0
	GO top
ELSE 
	RETURN .F.
ENDIF 

RETURN .T.
ENDPROC
PROCEDURE Init
Thisform.Contenido.cntFiltros.sel_provDD.txtCodigo.Enabled = .F.
Thisform.Contenido.cntFIltros.sel_provHH.txtCodigo.Enabled = .F.
Thisform.Contenido.cntFiltros.txtFechaDD.Value = DATE(2013,01,01)
Thisform.Contenido.cntFiltros.txtFechaHH.Value = DATE()

Thisform.Contenido.cntFiltros.txtFechaDD.Enabled = .T.
Thisform.Contenido.cntFiltros.txtFechaHH.Enabled = .T.
ENDPROC
PROCEDURE Load
DODEFAULT()

CREATE CURSOR cur_resumen(;
	CodVend			int,;
	Nombre			C(60),;	
	Codigo			int,;
	RazSoc			C(60),;
	Localidad		C(60) NULL,;
	CodPostal		C(10) NULL,;
	idLocalid		int,;
	Telefono		C(20) NULL,;
	Email			C(60) NULL,;
	Saldo			float(10,2))

CREATE CURSOR cur_todosmov(;
	Codigo			int,;
	RazSoc			C(60),;
	Telefono		C(20) NULL,;
	Email			C(60) NULL,;
	Idoper			int,;
	observ			varchar(100),;
	FecEmis			datetime,;
	Fecha			datetime,;
	Cbte			C(3),;
	TipoDoc			C(1),;
	NumCbte			C(14),;
	Debe			float(10,2),;
	Haber			float(10,2),;
	Saldo			float(10,2))
			
CREATE CURSOR cur_fcsaldos(;
	Codigo			int,;
	RazSoc			C(60),;
	Telefono		C(20) NULL,;
	Email			C(60) NULL,;
	Idoper			int,;
	observ			varchar(100),;
	FecEmis			datetime,;
	Cbte			C(3),;
	TipoDoc			C(1),;
	NumCbte			C(14),;
	Debe			float(10,2),;
	Haber			float(10,2),;
	Saldo			float(10,2),;
	SaldoTot		float(10,2))
	
CREATE CURSOR cur_saldoparc ( ;
	Codigo		int,;
	razSoc		varchar(60),;
	observ		varchar(100),;	
	fecEmis		datetime NULL,;
	fecVto		datetime NULL,;
	cbte		varchar(3),;
	tipoDoc		varchar(1),;
	NumCbte		varchar(14),;
	Debe		float(10,2),;
	Haber		float(10,2),;
	saldo		float(10,2))	
	
ENDPROC


************************************************************
OBJETO: cntFiltros
************************************************************
*** PROPIEDADES ***
Top = 4
Left = 3
Width = 742
Height = 142
BackStyle = 1
BackColor = 241,236,235
Name = "cntFiltros"

*** METODOS ***


************************************************************
OBJETO: chkProveedor
************************************************************
*** PROPIEDADES ***
Top = 27
Left = 26
Height = 18
Width = 156
Alignment = 0
Caption = "Filtrar por proveedor"
TabIndex = 5
Name = "chkProveedor"

*** METODOS ***
PROCEDURE Click
IF This.Value = 0 THEN
	This.Parent.sel_provDD.txtCodigo.Enabled = .F.
	This.Parent.sel_ProvHH.txtCodigo.Enabled = .F.
ELSE
	This.Parent.sel_provDD.txtCodigo.Enabled = .T.
	This.Parent.sel_ProvHH.txtCodigo.Enabled = .T.
ENDIF
ENDPROC


************************************************************
OBJETO: CLSETIQUETA1
************************************************************
*** PROPIEDADES ***
Caption = "Proveedor desde:"
Height = 15
Left = 48
Top = 53
Width = 110
TabIndex = 6
Name = "CLSETIQUETA1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Proveedor hasta:"
Height = 15
Left = 48
Top = 77
Width = 110
TabIndex = 7
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: sel_provDD
************************************************************
*** PROPIEDADES ***
Top = 47
Left = 158
TabIndex = 1
autocompletar_ceros = .F.
esnumerico = .T.
nombre_campo_codigo = idProv
nombre_campo_desc = razSoc
nombre_tabla = proveedor
pkfield = idProv
Name = "sel_provDD"
TXTCODIGO.Name = "TXTCODIGO"
TXTDESCRIPCION.Name = "TXTDESCRIPCION"

*** METODOS ***


************************************************************
OBJETO: sel_ProvHH
************************************************************
*** PROPIEDADES ***
Top = 70
Left = 158
TabIndex = 2
autocompletar_ceros = .F.
esnumerico = .T.
nombre_campo_codigo = idProv
nombre_campo_desc = razSoc
nombre_tabla = proveedor
pkfield = idProv
Name = "sel_ProvHH"
TXTCODIGO.Name = "TXTCODIGO"
TXTDESCRIPCION.Name = "TXTDESCRIPCION"

*** METODOS ***


************************************************************
OBJETO: CLSETIQUETA3
************************************************************
*** PROPIEDADES ***
Caption = "Fecha desde:"
Left = 29
Top = 116
TabIndex = 8
Name = "CLSETIQUETA3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Fecha hasta:"
Left = 222
Top = 116
TabIndex = 9
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: txtFechaDD
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 106
TabIndex = 3
Top = 111
Width = 103
isdatetime = .T.
Name = "txtFechaDD"

*** METODOS ***


************************************************************
OBJETO: txtFechaHH
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 295
TabIndex = 4
Top = 111
Width = 103
isdatetime = .T.
Name = "txtFechaHH"

*** METODOS ***


************************************************************
OBJETO: CLSETIQUETA5
************************************************************
*** PROPIEDADES ***
Caption = "Ingreso de datos para filtrar"
Height = 15
Left = 9
Top = 4
Width = 169
TabIndex = 10
Name = "CLSETIQUETA5"

*** METODOS ***


************************************************************
OBJETO: cntTipoInforme
************************************************************
*** PROPIEDADES ***
Top = 148
Left = 3
Width = 742
Height = 81
BackStyle = 1
BackColor = 241,236,235
Name = "cntTipoInforme"

*** METODOS ***


************************************************************
OBJETO: CLSETIQUETA5
************************************************************
*** PROPIEDADES ***
Caption = "Marcar el tipo de informe a emitir"
Height = 15
Left = 9
Top = 4
Width = 193
Name = "CLSETIQUETA5"

*** METODOS ***


************************************************************
OBJETO: option_group
************************************************************
*** PROPIEDADES ***
Top = 25
Left = 34
Width = 696
Height = 52
TabIndex = 18
TabStop = .T.
BackColor = 240,240,240
BorderColor = 192,192,192
Name = "option_group"

*** METODOS ***


************************************************************
OBJETO: opciones
************************************************************
*** PROPIEDADES ***
ButtonCount = 5
BorderStyle = 0
Value = 1
Height = 46
Left = 10
Top = 3
Width = 681
Name = "opciones"
Option1.FontBold = .T.
Option1.Caption = "Comprobantes con Saldo"
Option1.Value = 1
Option1.Height = 17
Option1.Left = 105
Option1.TabIndex = 6
Option1.TabStop = .T.
Option1.Top = 3
Option1.Width = 182
Option1.Name = "optCompSaldos"
Option2.FontBold = .T.
Option2.Caption = "Todos los movimientos"
Option2.Height = 17
Option2.Left = 520
Option2.TabIndex = 8
Option2.TabStop = .T.
Option2.Top = 3
Option2.Width = 156
Option2.Name = "optMov"
Option3.FontBold = .T.
Option3.Caption = "Resumen"
Option3.Height = 17
Option3.Left = 4
Option3.TabIndex = 5
Option3.Top = 3
Option3.Width = 98
Option3.Name = "optResumen"
Option4.FontBold = .T.
Option4.Caption = "Facturas Vencidas con Saldo"
Option4.Height = 17
Option4.Left = 304
Option4.TabIndex = 7
Option4.Top = 3
Option4.Width = 187
Option4.Name = "optFactSaldos"
Option5.FontBold = .T.
Option5.Caption = "Saldos Parciales"
Option5.Height = 17
Option5.Left = 4
Option5.Top = 28
Option5.Width = 116
Option5.Name = "optSaldoParcial"

*** METODOS ***
PROCEDURE optCompSaldos.Click
IF this.Value = 1
	Thisform.Contenido.cntFiltros.txtFechaDD.Enabled = .T.
	Thisform.Contenido.cntFiltros.txtFechaHH.Enabled = .T.
ENDIF
ENDPROC
PROCEDURE optMov.Click
IF this.Value = 1
	Thisform.Contenido.cntFiltros.txtFechaDD.Enabled = .T.
	Thisform.Contenido.cntFiltros.txtFechaHH.Enabled = .T.
ENDIF
ENDPROC
PROCEDURE optResumen.Click
IF this.Value = 1
	Thisform.Contenido.cntFiltros.txtFechaDD.Enabled = .F.
	Thisform.Contenido.cntFiltros.txtFechaHH.Enabled = .F.
ENDIF
ENDPROC
PROCEDURE optFactSaldos.Click
IF this.Value = 1
	Thisform.Contenido.cntFiltros.txtFechaDD.Enabled = .T.
	Thisform.Contenido.cntFiltros.txtFechaHH.Enabled = .T.
ENDIF
ENDPROC
PROCEDURE optSaldoParcial.Click
IF this.Value = 1
	Thisform.Contenido.cntFiltros.txtFechaDD.Enabled = .T.
	Thisform.Contenido.cntFiltros.txtFechaHH.Enabled = .T.
ENDIF
ENDPROC


************************************************************
OBJETO: btnImprimir
************************************************************
*** PROPIEDADES ***
Top = 241
Left = 99
Name = "btnImprimir"

*** METODOS ***
PROCEDURE Click
LOCAL loDateTime, lcFecEmisDesde, lcFecEmisHasta, lnIdProvDesde, lnIdProvHasta
LOCAL m.fecha, m.provDD, m.provHH, m.femisd, m.femish, m.titulo, m.tipolistado

loDateTime = CREATEOBJECT("datetime")

lcFecEmisDesde = loDateTime.toMySql(Thisform.contenido.cntFiltros.txtFechaDD.Value)
lcFecEmisHasta = loDateTime.toMySql(Thisform.contenido.cntFiltros.txtFechaHH.Value)

IF (Thisform.Contenido.cntFiltros.sel_provDD.valcpoid <> 0) .AND. ;
		(Thisform.Contenido.cntFiltros.sel_ProvHH.valcpoid	<> 0) THEN
		
*!*		m.provDD = "(" + ALLTRIM(STR(Thisform.Contenido.cntFiltros.sel_provDD.txtCodigo.Value)) + ") "
*!*		m.provDD = m.provDD + ALLTRIM(Thisform.Contenido.cntFiltros.sel_provDD.txtDescripcion.Value)
*!*		m.provHH = "(" + ALLTRIM(STR(Thisform.Contenido.cntFiltros.sel_provHH.txtCodigo.Value)) + ") "
*!*		m.provHH = m.provHH + ALLTRIM(Thisform.Contenido.cntFiltros.sel_provHH.txtDescripcion.Value)
	
	lnIdProvDesde = Thisform.Contenido.cntFiltros.sel_provDD.valcpoid
	lnIdProvHasta = Thisform.Contenido.cntFiltros.sel_provHH.valcpoid
ELSE
*!*		m.provDD = "(Todos)"
*!*		m.provHH = "(Todos)"
	
	lnIdProvDesde = 0
	lnIdProvHasta = 999999
ENDIF

m.fecha = DATETIME()
m.provDD = lnIdProvDesde
m.provHH = lnIdProvHasta
m.femisd = Thisform.contenido.cntFiltros.txtFechaDD.Value
m.femish = Thisform.contenido.cntFiltros.txtFechaHH.Value
m.titulo = "Listado de Cuentas Corrientes de Proveedores"

* Habilito el foxypreview
DO LOCFILE("FoxyPreviewer.App")
WITH _screen.oFoxyPreviewer	
	.cEmailType = "PDF"
	.nEmailMode = 2
	.cSMTPServer = getGlobalCFG("EMAILSMTP")
	.cEmailFrom = getGlobalCFG("EMAILEMP") + "<" + getGlobalCFG("EMAILADDR") + ">"
	.cEmailTo = ""
	.cEMailSubject = "Listado de Cuentas Corrientes Proveedor"
	.nSMTPPort = getGlobalCFG("EMAILPORT")
	.lSMTPUseSSL = getGlobalCFG("EMAILSSL")
	.cSMTPUserName = getGlobalCFG("EMAILUSR")
	.cSMTPPassword = getGlobalCFG("EMAILPWD")
	.lReadReceipt  = .F.
	.lPriority = .F.
	.cEmailBody = ""
ENDWITH

IF Thisform.Contenido.cntTipoInforme.option_group.opciones.optResumen.Value = 1 THEN
	IF Thisform.resumen(lnIdProvDesde, lnIdProvHasta)
		m.tipolistado = "Resumen de cuentas"	
		SELECT cur_resumen
		REPORT FORM "repctacteprovresumen" TO PRINTER PROMPT NODIALOG PREVIEW
	ELSE 
		MESSAGEBOX("No hay registros para mostrar",0+64,"Listado de Cuentas Corrientes")
	ENDIF 
ENDIF

IF Thisform.Contenido.cntTipoInforme.option_group.opciones.optCompSaldos.Value = 1 THEN
	IF Thisform.cbtesconsaldos(lnIdProvDesde, lnIdProvHasta, lcFecEmisDesde, lcFecEmisHasta)
		m.tipolistado = "Comprobantes con saldo"
		SELECT cur_todosmov 
		REPORT FORM "repctacteprovmov" TO PRINTER PROMPT NODIALOG PREVIEW
	ELSE 
		MESSAGEBOX("No hay registros para mostrar",0+64,"Listado de Cuentas Corrientes")
	ENDIF 
ENDIF

IF Thisform.Contenido.cntTipoInforme.option_group.opciones.optFactSaldos.Value = 1 THEN
	IF Thisform.fcconsaldos(lnIdProvDesde, lnIdProvHasta, lcFecEmisDesde, lcFecEmisHasta)
		m.tipolistado = "Facturas Vencidas con Saldo"	
		SELECT cur_fcsaldos
		REPORT FORM "repctacteprovfcsaldos" TO PRINTER PROMPT NODIALOG PREVIEW
	ELSE 
		MESSAGEBOX("No hay registros para mostrar",0+64,"Listado de Cuentas Corrientes")
	ENDIF 
ENDIF

IF Thisform.Contenido.cntTipoInforme.option_group.opciones.optMov.Value = 1 THEN
	IF Thisform.todosmov(lnIdProvDesde, lnIdProvHasta, lcFecEmisDesde, lcFecEmisHasta)
		m.tipolistado = "Todos los Movimientos"	
		SELECT cur_todosmov 
		REPORT FORM "repctacteprovmov" TO PRINTER PROMPT NODIALOG PREVIEW
	ELSE 
		MESSAGEBOX("No hay registros para mostrar",0+64,"Listado de Cuentas Corrientes")
	ENDIF 		
ENDIF

IF Thisform.Contenido.cntTipoInforme.option_group.opciones.optSaldoParcial.Value = 1 THEN
	IF Thisform.saldosparc(lnIdProvDesde, lnIdProvHasta, lcFecEmisDesde, lcFecEmisHasta)
		m.tipolistado = "Saldos Parciales"
		SELECT cur_saldoparc
		REPORT FORM rep_ctacteprov_saldoparc TO PRINTER PROMPT PREVIEW
	ELSE
		MESSAGEBOX("No hay registros para mostrar", 0+64, "Listado de Cuentas Corrientes")
	ENDIF
ENDIF

* Cierro el foxypreview
DO LOCFILE("FoxyPreviewer.App") WITH "Release"
ENDPROC


************************************************************
OBJETO: btnCancelar
************************************************************
*** PROPIEDADES ***
Top = 241
Left = 5
Name = "btnCancelar"

*** METODOS ***
PROCEDURE Click
Thisform.Contenido.cntFiltros.sel_provDD.txtCodigo.blanquear()
Thisform.Contenido.cntFIltros.sel_provHH.txtCodigo.blanquear()
Thisform.Contenido.cntFiltros.txtFechaDD.blanquear()
Thisform.Contenido.cntFiltros.txtFechaHH.blanquear()

Thisform.contenido.cntFiltros.txtFechaDD.SetFocus()

Thisform.Contenido.cntFiltros.sel_provDD.txtCodigo.Enabled = .F.
Thisform.Contenido.cntFIltros.sel_provHH.txtCodigo.Enabled = .F.
Thisform.Contenido.cntFiltros.txtFechaDD.Value = DATE(2013,01,01)
Thisform.Contenido.cntFiltros.txtFechaHH.Value = DATE()

thisform.contenido.cntFiltros.chkProveedor.Value = 0

IF !USED("cur_resumen")
	SELECT cur_resumen
	ZAP
ENDIF 

IF !USED("cur_todosmov")
	SELECT cur_todosmov
	ZAP
ENDIF 

IF !USED("cur_fcsaldos")
	SELECT cur_fcsaldos
	ZAP
ENDIF 

ENDPROC


************************************************************
OBJETO: btnSalir
************************************************************
*** PROPIEDADES ***
Top = 241
Left = 701
Name = "btnSalir"

*** METODOS ***


************************************************************
OBJETO: Clsexcel1
************************************************************
*** PROPIEDADES ***
Top = 241
Left = 52
TabIndex = 21
Name = "Clsexcel1"

*** METODOS ***
PROCEDURE Click
LOCAL loDateTime, lcFecEmisDesde, lcFecEmisHasta, lnIdProvDesde, lnIdProvHasta

loDateTime = CREATEOBJECT("datetime")

lcFecEmisDesde = loDateTime.toMySql(Thisform.contenido.cntFiltros.txtFechaDD.Value)
lcFecEmisHasta = loDateTime.toMySql(Thisform.contenido.cntFiltros.txtFechaHH.Value)

IF (Thisform.Contenido.cntFiltros.sel_provDD.valcpoid <> 0) .AND. ;
		(Thisform.Contenido.cntFiltros.sel_ProvHH.valcpoid	<> 0) THEN
	lnIdProvDesde = Thisform.Contenido.cntFiltros.sel_provDD.valcpoid
	lnIdProvHasta = Thisform.Contenido.cntFiltros.sel_provHH.valcpoid
ELSE
	lnIdProvDesde = 0
	lnIdProvHasta = 999999
ENDIF

IF Thisform.Contenido.cntTipoInforme.option_group.opciones.optResumen.Value = 1
	IF Thisform.resumen(lnIdProvDesde, lnIdProvHasta)
		SELECT cur_resumen
		genExcel("cur_resumen","Listado de Cuentas Corrientes de Proveedores (Resumen de Cuentas)")
	ELSE 
		MESSAGEBOX("No hay registros para exportar",0+48,"Listado de Cuentas Corrientes")
	ENDIF 
ENDIF

IF Thisform.Contenido.cntTipoInforme.option_group.opciones.optCompSaldos.Value = 1
	IF Thisform.cbtesconsaldos(lnIdProvDesde, lnIdProvHasta, lcFecEmisDesde, lcFecEmisHasta)
		SELECT cur_todosmov
		genExcel("cur_todosmov","Listado de Cuentas Corrientes de Proveedores (Comprobantes con Saldo)")
	ELSE 
		MESSAGEBOX("No hay registros para exportar",0+48,"Listado de Cuentas Corrientes")
	ENDIF 
ENDIF

IF Thisform.Contenido.cntTipoInforme.option_group.opciones.optFactSaldos.Value = 1
	IF Thisform.fcconsaldos(lnIdProvDesde, lnIdProvHasta, lcFecEmisDesde, lcFecEmisHasta)
		SELECT cur_fcsaldos
		genExcel("cur_fcsaldos","Listado de Cuentas Corrientes de Proveedores (Facturas con Saldo)")
	ELSE 
		MESSAGEBOX("No hay registros para exportar",0+48,"Listado de Cuentas Corrientes")
	ENDIF 
ENDIF

IF Thisform.Contenido.cntTipoInforme.option_group.opciones.optMov.Value = 1
	IF Thisform.todosmov(lnIdProvDesde, lnIdProvHasta, lcFecEmisDesde, lcFecEmisHasta)
		SELECT cur_todosmov
		genExcel("cur_todosmov","Listado de Cuentas Corrientes de Proveedores (Todos los Movimientos)")
	ELSE 
		MESSAGEBOX("No hay registros para exportar",0+48,"Listado de Cuentas Corrientes")
	ENDIF 
ENDIF

IF Thisform.Contenido.cntTipoInforme.option_group.opciones.optSaldoParcial.Value = 1 THEN
	IF Thisform.saldosparc(lnIdProvDesde, lnIdProvHasta, lcFecEmisDesde, lcFecEmisHasta)
		m.tipolistado = "Saldos Parciales"
		SELECT cur_saldoparc
		genExcel("cur_saldoparc","Listado de Cuentas Corrientes de Proveedores (Saldos Parciales)")
	ELSE
		MESSAGEBOX("No hay registros para mostrar", 0+64, "Listado de Cuentas Corrientes")
	ENDIF
ENDIF


ENDPROC


************************************************************
OBJETO: cls_frmcons_ccpv
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 9, 6, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_orden_pago_consulta
************************************************************
*** PROPIEDADES ***
BorderStyle = 2
Height = 579
Width = 952
DoCreate = .T.
Caption = "Consulta de ordenes de pagos"
Name = "cls_orden_pago_consulta"
contenido.Top = -1
contenido.Left = -1
contenido.Width = 953
contenido.Height = 580
contenido.Name = "contenido"

*** METODOS ***
PROCEDURE entrar_detalle
LOCAL loForm

loForm = CREATEOBJECT("cls_orden_pago_cons_detalles")
SELECT cur_op
loForm.id_orden_pago_c = cur_op.idOrdPagC
loForm.id_prov = cur_op.idProv
loForm.razon_social = cur_op.razSoc
loForm.importe = cur_op.importe
loForm.fecha_emision = cur_op.fecEmis
loForm.nro_op = cur_op.nroOP
loForm.inicializar_formulario()
loForm.recuperar_datos()
loForm.show(1)

ENDPROC
PROCEDURE Init
******************************************************
* Inicializo los controles
* Fecha: 08/08/2023
******************************************************

Thisform.o_orden_pago.crear_cursores_consultas()
Thisform.o_orden_pago.crear_cursor()

SELECT cur_op
Thisform.contenido.grdOrdenPago.alias_name = "cur_op"
Thisform.contenido.grdOrdenPago.RecordSource = "cur_op"
Thisform.contenido.grdOrdenPago.list_controlsource = "fecEmis,nroOP,idProv,RazSoc,importe,usuAlta,fecAlta,idHostAlta"
Thisform.contenido.grdOrdenPago.lista_ancho_cols = "100,100,70,200,100,100,150,200"
Thisform.contenido.grdOrdenPago.titulos_cabeceras = "Fec. Emis,Número,Proveedor,Razón Social,Importe,Usuario,Alta,Host"
Thisform.contenido.grdOrdenPago.permitir_busqueda = .f.
Thisform.contenido.grdOrdenPago.permitir_ordenamiento = .f.
Thisform.contenido.grdOrdenPago.generar_grid()

Thisform.contenido.txtFechaDD.Value = CTOD("01/01/2000")
Thisform.contenidO.txtFechaHH.Value = DATE() + 1

Thisform.contenido.txtNroRecDD.Value = 0
Thisform.contenido.txtNroRecHH.Value = 0
ENDPROC
PROCEDURE buscar
***********************************************************************
* Busca una orden de pago.
* Fecha: 08/08/2023
***********************************************************************
Thisform.o_orden_pago.get_listado_ordenes_pagos( ;
	Thisform.contenido.sel_provDD.valcpoid, ;
	Thisform.contenido.sel_provHH.valcpoid, ;
	Thisform.contenido.txtFechaDD.Value,	;
	Thisform.contenido.txtFechaHH.Value,	;
	Thisform.contenido.txtNroRecDD.Value,	;
	Thisform.contenido.txtNroRecHH.Value)

Thisform.contenido.grdOrdenPago.Refresh()

SELECT SUM(importe) AS total FROM cur_op INTO CURSOR cur_total
Thisform.contenido.txtTotal.Value = cur_total.total
USE IN cur_total
ENDPROC
PROCEDURE Load
*************************************************
* Load del formulario donde creo los cursores
*************************************************
DODEFAULT()


ENDPROC


************************************************************
OBJETO: o_orden_pago
************************************************************
*** PROPIEDADES ***
Top = 550
Left = 116
Height = 17
Width = 28
Name = "o_orden_pago"

*** METODOS ***


************************************************************
OBJETO: CLSETIQUETA1
************************************************************
*** PROPIEDADES ***
Caption = "Proveedor desde:"
Height = 15
Left = 24
Top = 20
Width = 101
TabIndex = 13
Name = "CLSETIQUETA1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Proveedor hasta:"
Height = 15
Left = 24
Top = 45
Width = 99
TabIndex = 14
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Fecha desde:"
Left = 24
Top = 70
TabIndex = 16
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Fecha hasta:"
Left = 238
Top = 67
TabIndex = 18
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: sel_provDD
************************************************************
*** PROPIEDADES ***
Top = 13
Left = 129
TabIndex = 1
anchos_cols = 400
esnumerico = .T.
nombre_campo_codigo = idProv
nombre_campo_desc = razSoc
alternative_cols = 
nombre_tabla = proveedor
pkfield = idProv
title_cols = Razón Social
criterio_filtro = proveedor.fecBaja IS NULL
Name = "sel_provDD"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: sel_provHH
************************************************************
*** PROPIEDADES ***
Top = 38
Left = 129
TabIndex = 2
anchos_cols = 400
esnumerico = .T.
nombre_campo_codigo = idProv
nombre_campo_desc = razSoc
alternative_cols = 
nombre_tabla = proveedor
pkfield = idProv
title_cols = Razón Social
criterio_filtro = proveedor.fecBaja IS NULL
Name = "sel_provHH"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: txtFechaDD
************************************************************
*** PROPIEDADES ***
Left = 131
TabIndex = 3
Top = 65
isdatetime = .T.
Name = "txtFechaDD"

*** METODOS ***


************************************************************
OBJETO: txtFechaHH
************************************************************
*** PROPIEDADES ***
Left = 313
TabIndex = 4
Top = 65
isdatetime = .T.
Name = "txtFechaHH"

*** METODOS ***


************************************************************
OBJETO: btnAceptar
************************************************************
*** PROPIEDADES ***
Top = 71
Left = 857
TabIndex = 7
Name = "btnAceptar"

*** METODOS ***
PROCEDURE Click
thisform.buscar()
ENDPROC


************************************************************
OBJETO: grdOrdenPago
************************************************************
*** PROPIEDADES ***
Height = 377
Left = 18
TabIndex = 12
Top = 117
Width = 932
permitir_busqueda = .F.
permitir_ordenamiento = .T.
Name = "grdOrdenPago"
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
PROCEDURE press_enter
thisform.entrar_detalle()
ENDPROC


************************************************************
OBJETO: CLSCERRAR1
************************************************************
*** PROPIEDADES ***
Top = 533
Left = 906
TabIndex = 11
Name = "CLSCERRAR1"

*** METODOS ***


************************************************************
OBJETO: btnDetalles
************************************************************
*** PROPIEDADES ***
Top = 533
Left = 18
TabIndex = 9
Name = "btnDetalles"

*** METODOS ***
PROCEDURE Click
thisform.entrar_detalle()

ENDPROC


************************************************************
OBJETO: btnCancelar
************************************************************
*** PROPIEDADES ***
Top = 71
Left = 906
TabIndex = 8
Name = "btnCancelar"

*** METODOS ***
PROCEDURE Click

Thisform.contenido.sel_provDD.blanquear()
Thisform.contenido.sel_provHH.blanquear()
Thisform.contenido.txtFechaDD.Value = DATE() - 30
Thisform.contenido.txtFechaHH.Value = DATE() + 1
Thisform.contenido.txtNroRecDD.Value = 0
Thisform.contenido.txtNroRecHH.Value = 0

* 14/05/2024: Agrego limpieza de cursor
SELECT cur_op
ZAP
Thisform.contenido.grdOrdenPago.Refresh()

ENDPROC


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "N° Orden desde:"
Height = 15
Left = 24
Top = 94
Width = 93
TabIndex = 15
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta6
************************************************************
*** PROPIEDADES ***
Caption = "N° Orden Hasta:"
Height = 15
Left = 317
Top = 94
Width = 94
TabIndex = 17
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: txtNroRecDD
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 131
TabIndex = 5
Top = 89
Width = 169
ischaracter = .F.
isinteger = .T.
Name = "txtNroRecDD"

*** METODOS ***


************************************************************
OBJETO: txtNroRecHH
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 415
TabIndex = 6
Top = 89
Width = 169
ischaracter = .F.
isinteger = .T.
Name = "txtNroRecHH"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta7
************************************************************
*** PROPIEDADES ***
Caption = "Importe total O.P.:"
Height = 15
Left = 21
Top = 501
Width = 127
Name = "Clsetiqueta7"

*** METODOS ***


************************************************************
OBJETO: txtTotal
************************************************************
*** PROPIEDADES ***
Left = 153
ReadOnly = .T.
Top = 498
isnumeric = .T.
Name = "txtTotal"

*** METODOS ***


************************************************************
OBJETO: cls_orden_pago_consulta
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_op
************************************************************
*** PROPIEDADES ***
idprov = 0
importe = 0
nroop = 
error_message = 
id_orden_pago = 0
mensaje = 
Name = "cls_op"

*** METODOS ***
PROCEDURE crear_cursor
CREATE CURSOR ordpag_d ( ;
	idOrdPagD int,;
	idOrdPagC int,;
	tipoPago varchar(5),;
	importe float(10, 2),;
	idPlanCta int,;
	idBanco int,;
	idCheque int,;
	idChequeP int,;	
	idProvin int,;
	retCompro int,;
	retFecha datetime,;
	fecTrans datetime,;
	nomOrig varchar(60),;
	docOrig varchar(20),;
	nroTrans varchar(8))
	
CREATE CURSOR deposito ( ;
	idBanco int,;
	idPlanCta int,;
	codBco varchar(5),;
	nomBco varchar(60),;
	nroTrans varchar(8),;
	fecTrans D,;
	nomOrig varchar(60),;
	docOrig varchar(20),;
	importe float(10,2))
	
CREATE CURSOR ordpag_dc (	;
	idOrdPagDC int,;
	idOrdPagC int,;
	idCompraC int)
	
CREATE CURSOR comprob (	;
	sel l,;
	idCompraC int,;
	idProv int,;
	fecEmis D,;
	fecVto D,;
	cbte varchar(3),;
	tipoDoc varchar(1),;
	nroFC varchar(13),;
	imppag float(10, 2),;
	saldo float(10, 2))
	
CREATE CURSOR cc_prov (	;
	idCC_Prov int,;
	idCompraC int,;
	idProv int,;
	idOper int,;
	idSitIVA int,;
	idCondPago int,;
	cbte varchar(3),;
	tipoDoc varchar(1),;
	ptoVta int,;
	nroCbte int,;
	fecEmis datetime,;
	fecVto datetime,;
	impDebe float(10, 2),;
	impHaber float(10, 2),;
	observ varchar(254))

CREATE CURSOR cheq_disp (	;
	sel l,;
	idCheque int,;
	idCliente int,;
	razSoc varchar(100),;
	idBanco int,;
	codBco varchar(5),;	
	descripcio varchar(60),;
	tipo varchar(1),;
	sucursal varchar(60),;
	chq_nro varchar(20),;
	fecEmis date,;
	fecVto date,;
	importe float(10, 2),;
	tipoDoc varchar(5),;
	nroCUIT varchar(20),;
	titular varchar(60),;
	nroRec varchar(13))
	
CREATE CURSOR chequesp ( ;
	idChequeP int,;
	idChequera int,;
	idPlanCta int,;
	idBanco int,;
	descripcio varchar(60),;
	idProv int,;
	idOrdPagC int,;
	nroCheque varchar(8),;
	fecEmis date,;
	fecVto date,;
	importe float(10,2))
ENDPROC
PROCEDURE agregar_detalle
PARAMETERS tnIdOrdPagD, ; 	&& Id Detalle. Poner 0 (Cero)
	tnIdOrdPagC		,;		&& Id Cabecera. Poner 0 (cero)
	tcTipoPago		,;		&& Tipo de pago	
	tnImporte		,;		&& Importe
	tnIdPlanCta		,;		&& Id. Plan de Cuenta
	tnIdBanco		,;		&& Id. Banco
	tnIdCheque		,; 		&& Id. Cheque. Poner 0 (Cero) si no corresponde
	tnIdChequeP		,; 		&& Id. Cheque. Poner 0 (Cero) si no corresponde	
	tnIdProvin		,;		&& Id. Provincia para retensiones
	tnRetCompro	,;		&& Num cbte de retención
	tnRetFecha		,;		&& Retensión de Ingresos Brutos
	tdFecTrans		,;		&& Fecha de transacción
	tcNomOrig		,;		&& Nombre de Origenante
	tcDocOrig		,;		&& Documento de Origenante
	tcNroTrans				&& Número de transaccion
	
SELECT ordpag_d
APPEND BLANK
REPLACE ordpag_d.idOrdPagD WITH tnIdOrdPagD
REPLACE ordpag_d.idOrdPagC WITH tnIdOrdPagC ADDITIVE
REPLACE ordpag_d.tipoPago WITH tcTipoPago ADDITIVE
REPLACE ordpag_d.importe WITH tnImporte ADDITIVE
REPLACE ordpag_d.idPlanCta WITH tnIdPlanCta ADDITIVE
REPLACE ordpag_d.idBanco WITH tnIdBanco ADDITIVE
REPLACE ordpag_d.idCheque WITH tnIdCheque ADDITIVE
REPLACE ordpag_d.idChequeP WITH tnIdChequeP ADDITIVE
REPLACE ordpag_d.idProvin WITH tnIdProvin ADDITIVE
REPLACE ordpag_d.retcompro WITH tnRetCompro ADDITIVE
REPLACE ordpag_d.retfecha WITH tnRetFecha ADDITIVE
REPLACE ordpag_d.fecTrans WITH tdFecTrans ADDITIVE
REPLACE ordpag_d.nomOrig WITH tcNomOrig ADDITIVE
REPLACE ordpag_d.docOrig WITH tcDocOrig ADDITIVE
REPLACE ordpag_d.nroTrans WITH tcNroTrans ADDITIVE
ENDPROC
PROCEDURE leer_cbtes
LOCAL lcSql
LOCAL loRes

lcSql = ""
loRes = CREATEOBJECT("odbc_result")

SELECT comprob
ZAP

*!*	lcSql = "SELECT 	comprascab.idCompraC,	"
*!*	lcSql = lcSql + "	comprascab.idProv, "
*!*	lcSql = lcSql + "	comprascab.fecEmis, "
*!*	lcSql = lcSql + "	comprascab.fecVto, "
*!*	lcSql = lcSql + "	comprascab.cbte, "
*!*	lcSql = lcSql + "	comprascab.tipoDoc, "
*!*	lcSql = lcSql + "	comprascab.ptoVta, "
*!*	lcSql = lcSql + "	comprascab.numCbte, "
*!*	lcSql = lcSql + "	comprascab.saldo "
*!*	lcSql = lcSql + "FROM 	comprascab "
*!*	lcSql = lcSql + "WHERE 	comprascab.fecBaja IS NULL "
*!*	lcSql = lcSql + "	AND comprascab.idProv = " + ALLTRIM(STR(This.idprov)) + " "
*!*	lcSql = lcSql + "	AND comprascab.cbte IN ('FC', 'ND') "
*!*	lcSql = lcSql + "	AND comprascab.idCompraC IN ( "
*!*	lcSql = lcSql + "		SELECT	cc1.idCompraC "
*!*	lcSql = lcSql + "		FROM cc_prov AS cc1 "
*!*	lcSql = lcSql + "		WHERE	cc1.idProv = " + ALLTRIM(STR(This.idprov)) + " "
*!*	lcSql = lcSql + "			AND cc1.idOper IN ( SELECT	cc2.idOper "
*!*	lcSql = lcSql + "       						FROM	cc_prov AS cc2 "
*!*	lcSql = lcSql + "       						WHERE	cc2.idProv = " + ALLTRIM(STR(This.idprov)) + " "
*!*	lcSql = lcSql + " 									AND (UsuBaja IS NULL OR UsuBaja = '') "
*!*	lcSql = lcSql + "								GROUP BY cc2.idOper HAVING ROUND((SUM(cc2.impDebe) - SUM(cc2.impHaber)),2) <> 0) "
*!*	lcSql = lcSql + " 			AND (UsuBaja IS NULL OR UsuBaja = '')) "
*!*	lcSql = lcSql + "ORDER BY fecEmis ASC "

lcSql = "SELECT 	cc_prov.idCompraC,	"
lcSql = lcSql + "	cc_prov.idProv, "
lcSql = lcSql + "	cc_prov.fecEmis, "
lcSql = lcSql + "	cc_prov.fecVto, "
lcSql = lcSql + "	cc_prov.cbte, "
lcSql = lcSql + "	cc_prov.tipoDoc, "
lcSql = lcSql + "	cc_prov.ptoVta, "
lcSql = lcSql + "	cc_prov.nroCbte, "
lcSql = lcSql + "	Saldos.saldo "
lcSql = lcSql + "FROM 	cc_prov INNER JOIN proveedor ON cc_prov.idProv = proveedor.idProv "
lcSql = lcSql + "	LEFT JOIN (SELECT cc2.idOper, ROUND(SUM(cc2.impdebe - cc2.imphaber),2) as Saldo "
lcSql = lcSql + "       		FROM cc_prov AS cc2 "
lcSql = lcSql + "       		WHERE (cc2.usubaja is null OR cc2.usubaja = '') "
lcSql = lcSql + "				GROUP BY cc2.idoper) AS Saldos ON cc_prov.idoper = Saldos.idoper "
lcSql = lcSql + "	INNER JOIN comprascab ON comprascab.idCompraC = cc_prov.idCompraC "
lcSql = lcSql + "	AND comprascab.idProv = " + ALLTRIM(STR(This.idprov)) + " "
lcSql = lcSql + " 	AND Saldos.Saldo > 0 "
lcSql = lcSql + "	AND cc_prov.cbte IN ('FC', 'ND') "
lcSql = lcSql + "	AND (cc_prov.usubaja is null OR cc_prov.usubaja = '') "
lcSql = lcSql + "ORDER BY cc_prov.fecEmis"

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_temp"

IF !loRes.OpenQuery(lcSql) THEN
	This.Error_Message = loRes.Error_Message
	RETURN .F.
ENDIF

SELECT cur_temp
GO TOP

DO WHILE !EOF("cur_temp")
	SELECT comprob
	APPEND BLANK
	REPLACE comprob.sel WITH .F.
	REPLACE comprob.idCompraC WITH cur_temp.idCompraC ADDITIVE
	REPLACE comprob.idProv WITH cur_temp.idProv ADDITIVE
	REPLACE comprob.fecEmis WITH cur_temp.fecEmis ADDITIVE
	REPLACE comprob.fecVto WITH cur_temp.fecVto ADDITIVE
	REPLACE comprob.cbte WITH cur_temp.cbte ADDITIVE
	REPLACE comprob.tipoDoc WITH cur_temp.tipoDoc ADDITIVE
	
	REPLACE comprob.nroFC WITH REPLICATE("0", 4 - LEN(ALLTRIM(STR(cur_temp.ptoVta)))) + ALLTRIM(STR(cur_temp.ptoVta)) ;
		+ "-" + REPLICATE("0", 8 - LEN(ALLTRIM(STR(cur_temp.nroCbte)))) + ALLTRIM(STR(cur_temp.nroCbte)) ADDITIVE
		
	REPLACE comprob.saldo WITH cur_temp.saldo ADDITIVE

	SELECT cur_temp
	SKIP
ENDDO

loRes.Close_Query()

SELECT comprob
IF RECCOUNT("comprob") <> 0 THEN
	GO TOP
ENDIF

RETURN .T.
ENDPROC
PROCEDURE grabar
LOCAL loCommand, loRes, lcSql, loDT
LOCAL lnIdOrdPagC, lnIdOrdPagD, lnIdCC_Prov
LOCAL lnNroOP, lnIdOrdPagDC, lnIdChequeP

loDT = CREATEOBJECT("datetime")
loCommand = CREATEOBJECT("odbc_command")
loRes = CREATEOBJECT("odbc_result")
lcSql = ""

lnIdOrdPagC = 0
lnIdOrgPagD = 0
lnIdCC_Prov = 0
lnNroOP = 0
lnIdOrdPagDC = 0
lnIdChequeP = 0

goConn.BeginTransaction()

&& Paso 1 - Grabo la cabecera de la orden de pago
lnIdOrdPagC = goConn.GetNextID("ordpag_c", "idOrdPagC")
lnNroOP = goConn.GetNextID("ordpag_c", "nroOP")
This.nroop = lnNroOP

lcSql = "INSERT INTO ordpag_c ("
lcSql = lcSql + "idOrdPagC, "
lcSql = lcSql + "idProv, "
lcSql = lcSql + "nroOP, "
lcSql = lcSql + "fecEmis, "
lcSql = lcSql + "importe, "
lcSql = lcSql + "usuAlta, "
lcSql = lcSql + "fecAlta, "
lcSql = lcSql + "idHostAlta) "
lcSql = lcSql + "VALUES ( "
lcSql = lcSql + ALLTRIM(STR(lnIdOrdPagC)) + ", "
lcSql = lcSql + ALLTRIM(STR(This.idprov)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnNroOP)) + ", "
lcSql = lcSql + loDT.getDateTime() + ", "
lcSql = lcSql + ALLTRIM(STR(This.importe, 10, 2)) + ", "
lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
lcSql = lcSql + loDT.getDateTime() + ", "
lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "')"

loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = lcSql

IF !loCommand.Execute() THEN
	goConn.Rollback()
	MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF


&& Paso 2 - Grabo el detalle de la orden de pago
SELECT ordpag_d
GO TOP

DO WHILE !EOF("ordpag_d")
	lnIdOrdPagD = goConn.GetNextID("ordpag_d", "idOrdPagD")
	
	lcSql = "INSERT INTO ordpag_d ("
	lcSql = lcSql + "idOrdPagD "
	lcSql = lcSql + ",idOrdPagC "
	lcSql = lcSql + ",tipoPago "
	lcSql = lcSql + ",importe "
	
	IF ordpag_d.idPlanCta <> 0 THEN
		lcSql = lcSql + ",idPlanCta "
	ENDIF
	
	IF ordpag_d.idBanco <> 0 THEN
		lcSql = lcSql + ",idBanco "
	ENDIF	
	
	IF ordpag_d.idCheque <> 0 THEN
		lcSql = lcSql + ",idCheque "
	ENDIF
	
	IF ordpag_d.idChequeP <> 0 THEN
		lcSql = lcSql + ",idChequeP "
	ENDIF
	
	IF ordpag_d.idProvin <> 0 THEN
		lcSql = lcSql + ",idProvin "
		lcSql = lcSql + ",retCompro "
		lcSql = lcSql + ",retFecha "
	ENDIF
		
	IF ordpag_d.tipoPago == "TRAN" THEN
		lcSql = lcSql + ",fecTrans "
		lcSql = lcSql + ",nomOrig "
		lcSql = lcSql + ",docOrig "
		lcSql = lcSql + ",nroTrans "
	ENDIF
	
	lcSql = lcSql + ") "
	lcSql = lcSql + "VALUES ( "
	lcSql = lcSql + ALLTRIM(STR(lnIdOrdPagD))
	lcSql = lcSql + ", " + ALLTRIM(STR(lnIdOrdPagC))
	lcSql = lcSql + ",'" + ALLTRIM(ordpag_d.tipoPago) + "'"	
	lcSql = lcSql + ", " + ALLTRIM(STR(ordpag_d.importe, 10, 2))

	IF ordpag_d.idPlanCta <> 0 THEN
		lcSql = lcSql + ", " + ALLTRIM(STR(ordpag_d.idPlanCta))
	ENDIF

	IF ordpag_d.idBanco <> 0 THEN
		lcSql = lcSql + ", " + ALLTRIM(STR(ordpag_d.idBanco))
	ENDIF
		
	IF ordpag_d.idCheque <> 0 THEN
		lcSql = lcSql + ", " + ALLTRIM(STR(ordpag_d.idCheque))
	ENDIF
	
	IF ordpag_d.idChequeP<> 0 THEN
		lcSql = lcSql + ", " + ALLTRIM(STR(ordpag_d.idChequeP))
	ENDIF
	
	IF ordpag_d.idProvin <> 0 THEN
		lcSql = lcSql + ", " + ALLTRIM(STR(ordpag_d.idProvin))
		lcSql = lcSql + ", " + ALLTRIM(STR(ordpag_d.retCompro))
		lcSql = lcSql + ", " + loDT.toMySql(ordpag_d.retFecha)
	ENDIF
	
	IF ordpag_d.tipoPago == "TRAN" THEN
		lcSql = lcSql + ", " + loDT.toMySql(ordpag_d.fecTrans)
		lcSql = lcSql + ",'" + ALLTRIM(ordpag_d.nomOrig) + "'"
		lcSql = lcSql + ",'" + ALLTRIM(ordpag_d.docOrig) + "'"
		lcSql = lcSql + ",'" + ALLTRIM(ordpag_d.nroTrans) + "'"
	ENDIF
	
	lcSql = lcSql + ")"
	
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText= lcSql
	
	IF !loCommand.Execute() THEN
		goConn.Rollback()
		This.error_message = loCommand.ErrorMessage
		RETURN .F.
	ENDIF
	
	&& Actualizo los cheques utilizados como utilizados en la tabla de
	&& cheques.
	IF ordpag_d.idCheque <> 0 THEN
		lcSql = "UPDATE cheques "
		lcSql = lcSql + "SET cheques.estado = 'U' "
		lcSql = lcSql + "WHERE cheques.idCheque = " + ALLTRIM(STR(ordpag_d.idCheque))
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
			RETURN .F.
		ENDIF
	ENDIF

	SELECT ordpag_d
	SKIP
ENDDO

&& Paso 3 - Aplico el importe correspondiente a cada comprobante seleccionado
This.aplicar_cbtes()

&& Paso 4 - Tengo que grabar los registros de vinculación de OP con FC.
SELECT comprob
GO TOP
DO WHILE !EOF("comprob")
	IF comprob.sel THEN
		lnIdOrdPagDC = goConn.GetNextID("ordpag_dc", "idOrdPagDC")
	
		lcSql = "INSERT INTO ordpag_dc ("
		lcSql = lcSql + "idOrdPagDC, "
		lcSql = lcSql + "idOrdPagC, "
		lcSql = lcSql + "idCompraC, "
		lcSql = lcSql + "imppag) "
		lcSql = lcSql + "VALUES ( "
 		lcSql = lcSql + ALLTRIM(STR(lnIdOrdPagDC)) + ", "
 		lcSql = lcSql + ALLTRIM(STR(lnIdOrdPagC)) + ", "
 		lcSql = lcSql + ALLTRIM(STR(comprob.idCompraC)) + ", "
 		lcSql = lcSql + ALLTRIM(STR(comprob.imppag, 20, 2)) + ")"
 		
 		loCommand.ActiveConnection = goConn.ActiveConnection
 		loCommand.CommandText = lcSql
 		
 		IF !loCommand.Execute() THEN
 			goConn.Rollback()
 			MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
 			RETURN .F.
 		ENDIF
	ENDIF

	SELECT comprob
	SKIP
ENDDO

* Paso 5: Genero los movimientos de cuentas corrientes.
SELECT cc_prov
GO TOP
DO WHILE !EOF("cc_prov")
	lnIdCC_Prov = goConn.GetNextID("cc_prov", "idCC_Prov")

	lcSql = "INSERT INTO cc_prov ( "
	lcSql = lcSql + "idCC_Prov, "
	
	IF cc_prov.idCompraC <> 0 THEN
		lcSql = lcSql + "idCompraC, "
	ENDIF
	
	lcSql = lcSql + "idProv, "
	lcSql = lcSql + "idOper, "
	lcSql = lcSql + "idSitIVA, "
	lcSql = lcSql + "idCondPago, "
	lcSql = lcSql + "cbte, "
	lcSql = lcSql + "tipoDoc, "
	lcSql = lcSql + "ptoVta, "
	lcSql = lcSql + "nroCbte, "
	lcSql = lcSql + "fecEmis, "
	lcSql = lcSql + "fecVto, "
	lcSql = lcSql + "impDebe, "
	lcSql = lcSql + "impHaber, "
	lcSql = lcSql + "observ, "
	lcSql = lcSql + "usuAlta, "
	lcSql = lcSql + "fecAlta, "
	lcSql = lcSql + "idHostAlta) "
	lcSql = lcSql + "VALUES ( "
	lcSql = lcSql + ALLTRIM(STR(lnIdCC_Prov)) + ", "
	
	IF cc_prov.idCompraC <> 0 THEN
		lcSql = lcSql + ALLTRIM(STR(cc_prov.idCompraC)) + ", "
	ENDIF
	
	lcSql = lcSql + ALLTRIM(STR(This.idprov)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cc_prov.idOper)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cc_prov.idSitIVA)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cc_prov.idCondPago)) + ", "
	lcSql = lcSql + "'" + ALLTRIM(cc_prov.cbte) + "', "
	lcSql = lcSql + "'', "
	lcSql = lcSql + "0, "
	lcSql = lcSql + ALLTRIM(STR(This.nroop)) + ", "
	lcSql = lcSql + "current_timestamp, "
	lcSql = lcSql + "current_timestamp, "
	lcSql = lcSql + ALLTRIM(STR(cc_prov.impDebe, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cc_prov.impHaber, 10, 2)) + ", "
	lcSql = lcSql + "'" + ALLTRIM(cc_prov.observ) + "', "
	lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
	lcSql = lcSql + "current_timestamp, "
	lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "')"
	
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute() THEN
		This.Error_Message = loCommand.ErrorMessage
		RETURN .F.
	ENDIF
	
	SELECT cc_prov
	SKIP
ENDDO

&& Paso 6 - Grabar los cheques propios en la tabla de cheques propios
SELECT chequesp
GO TOP
DO WHILE !EOF("chequesp")
	lnIdChequeP = goConn.GetNextID("chequesp", "idChequeP")

	lcSql = "INSERT INTO chequesp ( "
	lcSql = lcSql + "idChequeP, "
	lcSql = lcSql + "idChequera, "
	lcSql = lcSql + "idBanco, "
	lcSql = lcSql + "idProv, "
	lcSql = lcSql + "idOrdPagC, "
	lcSql = lcSql + "nroCheque, "
	lcSql = lcSql + "fecEmis, "
	lcSql = lcSql + "fecVto, "	
	lcSql = lcSql + "importe, "
	lcSql = lcSql + "usuAlta, "
	lcSql = lcSql + "fecAlta, "
	lcSql = lcSql + "idHostAlta) "
	lcSql = lcSql + "VALUES ( "
	lcSql = lcSql + ALLTRIM(STR(lnIdChequeP)) + ", "
	lcSql = lcSql + ALLTRIM(STR(chequesp.idChequera)) + ", "
	lcSql = lcSql + ALLTRIM(STR(chequesp.idBanco)) + ", "
	lcSql = lcSql + ALLTRIM(STR(chequesp.idProv)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnIdOrdPagC)) + ", "
	lcSql = lcSql + ALLTRIM(STR(INT(VAL(chequesp.nroCheque)))) + ", "
	lcSql = lcSql + loDT.toMySql(chequesp.fecEmis) + ", "
	lcSql = lcSql + loDT.toMySql(chequesp.fecVto) + ", "
	lcSql = lcSql + ALLTRIM(STR(chequesp.importe, 20, 2)) + ", "
	lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
	lcSql = lcSql + "current_timestamp, "
	lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "')"
	
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute() THEN
		goConn.Rollback()
		MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
		RETURN .F.
	ENDIF
	
	&& Actualizo el número actual de la chequera
	lcSql = "UPDATE chequeras "
	lcSql = lcSql + "SET chequeras.numActual = " + ALLTRIM(STR(INT(VAL(chequesp.nroCheque)))) + " + 1 "
	lcSql = lcSql + "WHERE chequeras.idChequera = " + ALLTRIM(STR(chequesp.idChequera))
	
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute() THEN
		goConn.Rollback()
		MESSAGEBOX(loCommand.ErrorMessage, 0+48, "Orden de pago")
		RETURN .F.
	ENDIF
	
	*!* Actualizo el ID de cheques propios en el detalle de la orden
	*!* ACLARACION: No me gusta la idea de poner en el where el importe pero de la forma
	*!* en que está desarrollado no me queda otra para identificar en caso de que haya más
	*!* de un cheque del mismo banco.
	TEXT TO loCommand.CommandText NOSHOW
		UPDATE
			ordpag_d
		SET
			ordpag_d.idChequeP = ?xidChequeP
		WHERE
			ordpag_d.idOrdPagC = ?xidOrdPagC AND
			ordpag_d.tipoPago = 'CHEQP' AND
			ordpag_d.idBanco = ?xidBanco AND
			ROUND(ordpag_d.importe, 0) = ROUND(?ximporte, 0)
	ENDTEXT
	loCommand.AddParameter("xidChequeP", ALLTRIM(STR(lnIdChequeP)), .f., .f.)
	loCommand.AddParameter("xidOrdPagC", ALLTRIM(STR(lnIdOrdPagC)), .f., .f.)
	loCommand.AddParameter("xidBanco", ALLTRIM(STR(chequesp.idBanco)), .f., .f.)
	loCommand.AddParameter("ximporte", ALLTRIM(STR(chequesp.importe, 20, 2)), .f., .f.)
	
	IF !loCommand.Execute() THEN
		goConn.Rollback()
		MESSAGEBOX(loCommand.ErrorMessage, 0+48, "Orden de pago")
		RETURN .F.
	ENDIF

	SELECT chequesp
	SKIP
ENDDO


&& Paso 6: Actualizo los saldos
SELECT comprob
GO TOP
DO WHILE !EOF("comprob")
	lcSql = "UPDATE comprascab "
	lcSql = lcSql + "SET comprascab.saldo = " + ALLTRIM(STR(comprob.saldo, 10, 2)) + ", "
	lcSql = lcSql + "	comprascab.usuModi = '" + ALLTRIM(gcCodUsu) + "', "
	lcSql = lcSql + "	comprascab.fecModi = current_timestamp, "
	lcSql = lcSql + "	comprascab.idHostModi = '" + ALLTRIM(SYS(0)) + "' "
	lcSql = lcSql + "WHERE comprascab.idCompraC = " + ALLTRIM(STR(comprob.idCompraC))
	
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute() THEN
		goConn.Rollback()
		MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
		RETURN .F.
	ENDIF

	SELECT comprob
	SKIP
ENDDO

goConn.Commit()

RETURN .T.



ENDPROC
PROCEDURE aplicar_cbtes
*!*	LOCAL s	&& Saldo del comprobante actual
*!*	LOCAL r	&& Saldo restante a imputar

*!*	s = 0.00
*!*	r = this.importe

*!*	SELECT comprob
*!*	GO TOP

*!*	DO WHILE !EOF("comprob")
*!*		IF comprob.sel THEN
*!*			s = comprob.saldo
*!*			
*!*			IF r >= s THEN
*!*							
*!*				This.generar_cc(comprob.idCompraC, s)
*!*				
*!*				SELECT comprob
*!*				LOCK()
*!*				REPLACE comprob.imppag WITH s
*!*				REPLACE comprob.saldo WITH 0
*!*				UNLOCK
*!*			ELSE
*!*				s = s - r
*!*				This.generar_cc(comprob.idCompraC, r)
*!*				
*!*				SELECT comprob
*!*				LOCK()
*!*				REPLACE comprob.imppag WITH r
*!*				REPLACE comprob.saldo WITH s
*!*				UNLOCK
*!*			ENDIF
*!*			
*!*			r = r - s
*!*		ENDIF
*!*		
*!*		SELECT comprob
*!*		SKIP
*!*	ENDDO

*!*	IF r > 0 THEN
*!*		This.generar_cc(0, r)
*!*	ENDIF
**************************************************************************
LOCAL lnImpImputar, lnImpGrabar, lnImpHaber, lnSaldo   

lnImpImputar = this.importe
lnImpGrabar = 0.00
lnImpHaber = 0.00
lnSaldo = 0.00

SELECT comprob
GO TOP

DO WHILE !EOF("comprob")
	IF comprob.sel THEN
		IF lnImpImputar >= comprob.saldo THEN
			lnImpGrabar = comprob.saldo
			lnImpImputar = lnImpImputar - comprob.saldo
			lnImpHaber = lnImpImputar
			lnSaldo = 0.00
			
			This.generar_cc(comprob.idCompraC, lnImpGrabar)
			
			SELECT comprob
			LOCK()
			REPLACE comprob.imppag WITH lnImpGrabar
			REPLACE comprob.saldo WITH lnSaldo 
			UNLOCK
		ELSE
			lnImpGrabar = lnImpImputar
			lnImpHaber = lnImpImputar - comprob.saldo 
			lnSaldo = comprob.saldo - lnImpImputar
			
			This.generar_cc(comprob.idCompraC, IIF(lnImpGrabar < 0, lnImpGrabar * -1, lnImpGrabar))
			
			SELECT comprob
			LOCK()
			REPLACE comprob.imppag WITH IIF(lnImpGrabar < 0, lnImpGrabar * -1, lnImpGrabar)
			REPLACE comprob.saldo WITH lnSaldo 
			UNLOCK
		ENDIF
	ENDIF
	
	SELECT comprob
	SKIP
ENDDO

IF lnImpHaber > 0 THEN
	This.generar_cc(0, lnImpHaber)
ENDIF

SELECT * FROM comprob WHERE sel = .T. INTO CURSOR cur_temp

SELECT cur_temp
IF RECCOUNT() = 0 THEN
	This.generar_cc(0, lnImpImputar)
ENDIF

USE IN cur_temp
ENDPROC
PROCEDURE generar_cc
PARAMETERS tnIdCompraC, tnSaldo

LOCAL lnIdOper
LOCAL loRes
LOCAL lcSql
LOCAL lnIdSitIVA
LOCAL lnIdCondPago
LOCAL lcCbte
LOCAL lcTipoDoc
LOCAL lnPtoVta
LOCAL lnNroCbte

lnIdOper = 0
loRes = CREATEOBJECT("odbc_result")
lcSql = ""
lnIdSitIVA = 0
lnIdCondPago = 0
lcCbte = ""

IF tnIdCompraC <> 0 THEN
	lcSql = "SELECT idOper, idSitIVA, idCondPago FROM cc_prov "
	lcSql = lcSql + "WHERE cc_prov.idCompraC = " + ALLTRIM(STR(tnIdCompraC))

	loRes.ActiveConnection = goConn.ActiveConnection
	loRes.Cursor_Name = "cur_x"

	IF !loRes.OpenQuery(lcSql) THEN
		This.Error_Message = loRes.Error_Message
		RETURN .F.
	ENDIF

	lnIdOper = cur_x.idOper
	lnIdSitIVA = cur_x.idSitIVA
	lnIdCondPago = cur_x.idCondPago

	loRes.Close_Query()
ELSE
	lcSql = "SELECT idSitIVA, idCondPago "
	lcSql = lcSql + "FROM proveedor "
	lcSql = lcSql + "WHERE proveedor.idProv = " + ALLTRIM(STR(this.idprov))
	
	loRes.ActiveConnection = goConn.ActiveConnection
	loRes.Cursor_Name = "cur_x"
	
	IF !loRes.OpenQuery(lcSql) THEN
		MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
		RETURN .F.
	ENDIF
	
	lnIdSitIVA = cur_x.idSitIVA
	lnIdCondPago = cur_x.idCondPago
	
	loRes.Close_Query()
	
	&& En este caso el registro no estaría asociado a ningún comprobante con lo que
	&& genero un idOper nuevo
	lnIdOper = goConn.GetNextID("cc_prov", "idOper")
ENDIF

SELECT cc_prov
APPEND BLANK
REPLACE cc_prov.idCC_Prov WITH 0
REPLACE cc_prov.idCompraC WITH tnIdCompraC ADDITIVE
REPLACE cc_prov.idOper WITH lnIdOper ADDITIVE
REPLACE cc_prov.idSitIVA WITH lnIdSitIVA ADDITIVE
REPLACE cc_prov.idCondPago WITH lnIdCondPago ADDITIVE
REPLACE cc_prov.cbte WITH "OP" ADDITIVE
REPLACE cc_prov.tipoDoc WITH "X" ADDITIVE
REPLACE cc_prov.ptoVta WITH 0 ADDITIVE
REPLACE cc_prov.nroCbte WITH This.nroop ADDITIVE
REPLACE cc_prov.fecEmis WITH DATETIME() ADDITIVE
REPLACE cc_prov.fecVto WITH DATETIME() ADDITIVE
REPLACE cc_prov.impDebe WITH 0 ADDITIVE
REPLACE cc_prov.impHaber WITH tnSaldo ADDITIVE
REPLACE cc_prov.observ WITH "" ADDITIVE

RETURN .T.
ENDPROC
PROCEDURE leer_cheqdisp
LOCAL loRes
LOCAL lcSql

loRes = CREATEOBJECT("odbc_result")
lcSql = ""

SELECT cheq_disp
ZAP

lcSql = "SELECT 	cheques.idCheque, "
lcSql = lcSql + "	cheques.idCliente, "
lcSql = lcSql + "	clientes.razSoc, "
lcSql = lcSql + "	bancos.idBanco, "
lcSql = lcSql + "	bancos.codBco, "
lcSql = lcSql + "	bancos.descripcio, "
lcSql = lcSql + "	cheques.tipo, "
lcSql = lcSql + "	cheques.sucursal, "
lcSql = lcSql + "	cheques.chq_nro, "
lcSql = lcSql + "	cheques.fecEmis, "
lcSql = lcSql + "	cheques.fecVto, "
lcSql = lcSql + "	cheques.importe, "
lcSql = lcSql + "	cheques.tipoDoc, "
lcSql = lcSql + "	cheques.nroCUIT, "
lcSql = lcSql + "	cheques.titular, "
lcSql = lcSql + "	cheques.nroRec "
lcSql = lcSql + "FROM 	cheques "
lcSql = lcSql + "	INNER JOIN clientes ON clientes.idCliente = cheques.idCliente "
lcSql = lcSql + "	INNER JOIN bancos ON bancos.idBanco = cheques.idBanco "
lcSql = lcSql + "WHERE cheques.estado = 'D' "

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_x
GO TOP
DO WHILE !EOF("cur_x")
	SELECT cheq_disp
	APPEND BLANK
	REPLACE cheq_disp.idCheque WITH cur_x.idCheque
	REPLACE cheq_disp.idCliente WITH cur_x.idCliente ADDITIVE
	REPLACE cheq_disp.razSoc WITH cur_x.razSoc ADDITIVE
	REPLACE cheq_disp.idBanco WITH cur_x.idBanco ADDITIVE
	REPLACE cheq_disp.codBco WITH cur_x.codBco ADDITIVE
	REPLACE cheq_disp.descripcio WITH cur_x.descripcio ADDITIVE
	REPLACE cheq_disp.chq_nro WITH cur_x.chq_nro ADDITIVE
	REPLACE cheq_disp.fecEmis WITH cur_x.fecEmis ADDITIVE
	REPLACE cheq_disp.fecVto WITH cur_x.fecVto ADDITIVE
	REPLACE cheq_disp.importe WITH cur_x.importe ADDITIVE
	REPLACE cheq_disp.tipoDoc WITH cur_x.tipoDoc ADDITIVE
	REPLACE cheq_disp.nroCUIT WITH cur_x.nroCUIT ADDITIVE
	REPLACE cheq_disp.titular WITH cur_x.titular ADDITIVE
	REPLACE cheq_disp.nroRec WITH cur_x.nroRec ADDITIVE

	SELECT cur_x
	SKIP
ENDDO

loRes.Close_Query()

SELECT cheq_disp
GO TOP

RETURN .T.

ENDPROC
PROCEDURE agregar_deposito
PARAMETERS ;
	tnIdBanco,;		&& Id. Banco
	tnNroTrans,;	&& Número de tansacción
	tdFecTrans,;	&& Fecha de transacción
	tcNomOrig,;		&& Nomre del originante
	tcDocOrig,;		&& Número fiscal del originante
	tnImporte		&& Importe del depósito / transacción
	
LOCAL loRes
LOCAL lcSql
LOCAL lcCodBco
LOCAL lcNomBco
LOCAL lnIdPlanCta

loRes = CREATEOBJECT("odbc_result")
lcSql = "SELECT * FROM bancos "
lcSql = lcSql + "WHERE bancos.idBanco = " + ALLTRIM(STR(tnIdBanco))

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_tempo"

IF !loRes.OpenQuery(lcSql) THEN
	This.Error_message = loRes.Error_Message
	RETURN .F.
ENDIF

lcCodBco = ALLTRIM(cur_tempo.codBco)
lcNomBco = ALLTRIM(cur_tempo.descripcio)
lnIdPlanCta = cur_tempo.idPlanCta

loRes.Close_Query()

SELECT deposito
APPEND BLANK
REPLACE deposito.idBanco WITH tnIdBanco
REPLACE deposito.idPlanCta WITH lnIdPlanCta ADDITIVE
REPLACE deposito.codBco WITH ALLTRIM(lcCodBco) ADDITIVE
REPLACE deposito.nomBco WITH ALLTRIM(lcNomBco) ADDITIVE
REPLACE deposito.nroTrans WITH ALLTRIM(tnNroTrans) ADDITIVE
REPLACE deposito.fecTrans WITH tdFecTrans ADDITIVE
REPLACE deposito.nomOrig WITH tcNomOrig ADDITIVE
REPLACE deposito.docOrig WITH tcDocOrig ADDITIVE
REPLACE deposito.importe WITH tnImporte ADDITIVE

SELECT deposito
GO TOP

RETURN .T.
ENDPROC
PROCEDURE blanquear_detalle
SELECT ordpag_d
ZAP
ENDPROC
PROCEDURE blanquear
SELECT ordpag_d
ZAP
SELECT deposito
ZAP
SELECT ordpag_dc
ZAP
SELECT comprob
ZAP
SELECT cc_prov
ZAP
SELECT cheq_disp
ZAP
SELECT chequesp
ZAP

This.idprov = 0
This.importe = 0.00
This.nroop = ""
ENDPROC
PROCEDURE validar_op
&& Este método permite validar que los importes de la orden de pago definidos sean consistentes

LOCAL lnImporteOP, lnImpTot, lnResp, lnCantSel, lnImputado 

lnImporteOP = 0
lnImpTot = 0
lnCantSel = 0
lnImputado = this.importe

SELECT comprob
GO TOP
DO WHILE !EOF("comprob")
	IF comprob.sel THEN
		lnImporteOP = lnImporteOP + comprob.saldo
	ENDIF

	SELECT comprob
	SKIP
ENDDO

SELECT comprob
GO TOP



SELECT ordpag_d
GO TOP
DO WHILE !EOF("ordpag_d")
	lnImpTot = lnImpTot + ordpag_d.importe

	SELECT ordpag_d
	SKIP
ENDDO

SELECT ordpag_d
GO TOP

IF lnImporteOP <> lnImpTot THEN
	lnResp = MESSAGEBOX("La suma de los saldos de los comprobantes seleccionados no coincide con el importe total ingresado. ¿Desea  continuar de todas formas?", 32+4, Thisform.Caption)
	
	IF lnResp = 6 THEN
		RETURN .T.
	ELSE
		This.blanquear_detalle()
		RETURN .F.
	ENDIF
ENDIF

******************************************************************************************************
&& Valido que no se hayan seleccionado mas facturas de las que se puede cancelar con el pago.
SELECT COUNT(*) AS cantSel FROM comprob WHERE sel = .T. ;
INTO CURSOR cur_x

SELECT cur_x
lnCantSel = cur_x.cantSel
USE IN cur_x

SELECT comprob 
IF RECCOUNT("comprob") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("comprob")
	IF comprob.sel THEN
		IF (lnCantSel > 1) .AND. lnImputado <= 0 THEN
			MESSAGEBOX("El pago no es válido, por favor verifique las facturas seleccionadas.", 0+48, Thisform.Caption)
			RETURN .F.
		ELSE
			lnImputado = lnImputado - comprob.saldo
		ENDIF
	ENDIF

	SELECT comprob 
	SKIP
ENDDO

SELECT comprob
IF RECCOUNT("comprob") > 0 THEN
	GO TOP
ENDIF

RETURN .T.
ENDPROC
PROCEDURE agregar_chequesp
PARAMETERS ;
	tnIdChequera,;	&& Id. Chequera
	tnIdPlanCta,;	&& Id. de plan de cuentas
	tnIdBanco,;		&& Id. Banco
	tnDescripcio,;	&& Nombre del banco
	tnIdProv,;		&& Id. Proveedor
	tnIdOrdPagC,;	&& Id. Cabecera Orden Pago
	tnNroCheque,;	&& Número de cheque
	tdFecEmis,;		&& Fecha de Emisión
	tdFecVto,;		&& Fecha de Vencimiento
	tnImporte		&& Importe
	
SELECT chequesp
APPEND BLANK
REPLACE chequesp.idChequeP WITH 0
REPLACE chequesp.idChequera WITH tnIdChequera ADDITIVE
REPLACE chequesp.idPlanCta WITH tnIdPlanCta ADDITIVE
REPLACE chequesp.idBanco WITH tnIdBanco ADDITIVE
REPLACE chequesp.descripcio WITH ALLTRIM(tnDescripcio) ADDITIVE
REPLACE chequesp.idProv WITH tnIdProv ADDITIVE
REPLACE chequesp.idOrdPagC WITH tnIdOrdPagC ADDITIVE
REPLACE chequesp.nroCheque WITH tnNroCheque ADDITIVE
REPLACE chequesp.fecEmis WITH tdFecEmis ADDITIVE
REPLACE chequesp.fecVto WITH tdFecVto ADDITIVE
REPLACE chequesp.importe WITH tnImporte ADDITIVE

RETURN .T.
ENDPROC
PROCEDURE crear_cursores_consultas
*****************************************************************
* Permite crear los cursores para la consulta de OP
*****************************************************************

CREATE CURSOR cur_op ( ;
	idOrdPagC int,;
	fecEmis DATE,;
	nroOP varchar(10),;
	idProv int,;
	razSoc varchar(60),;
	importe N(20, 2),;
	usuAlta varchar(5),;
	fecAlta datetime,;
	idHostAlta varchar(50))
	
	
CREATE CURSOR cur_prov ( ;
	razsoc varchar(60),;
	direccion varhcar(60) DEFAULT '',;
	nrocuit varchar(20) ,;
	telefono varchar(100) DEFAULT '',;
	codPostal varchar(10) DEFAULT '',;
	loc varchar(60) DEFAULT '',;
	provincia varchar(60) DEFAULT '',;
	sitiva varchar(60) ,;
	condpago varchar(60))
	
CREATE CURSOR cur_importes ( ;
	tipoPago varchar(5),;
	cuenta varchar(60),;
	importe N(20, 2),;
	provincia varchar(60) NULL)
ENDPROC
PROCEDURE get_listado_ordenes_pagos
************************************************************************
* Permite obtener el listado para la consulta de ordenes de pagos.
* Fecha: 09/08/203
************************************************************************
LPARAMETERS tnIdProvDD, tnIdProvHH, tdFechaDD, tdFechaHH, tnNroOPDD, tnNroOPHH

LOCAL loRes
LOCAL lcSql

loRes = CREATEOBJECT("odbc_result")

TEXT TO lcSql NOSHOW
	SELECT
	  oc.idOrdPagC,
	  oc.fecEmis,
	  CONCAT(REPEAT('0', 8 - LENGTH(oc.nroOP)), oc.nroOP) AS 'nroOP',
	  oc.idProv,
	  p.razSoc,
	  oc.importe,
	  oc.usuAlta,
	  oc.fecAlta,
	  oc.idHostAlta
	FROM 
	  ordpag_c oc
	    INNER JOIN proveedor p ON oc.idProv = p.idProv
	WHERE
		oc.fecBaja IS NULL AND
	 	CASE WHEN ?xidProvDD = 0 THEN 1 ELSE  oc.idProv >= ?xidProvDD END AND
	  	CASE WHEN ?xidProvHH = 0 THEN 1 ELSE oc.idProv <= ?xidProvHH END AND
	  	CASE WHEN ?xNroOPDD = 0 AND ?xNroOPHH = 0 THEN 1 ELSE oc.nroOP BETWEEN ?xNroOPDD AND ?xNroOPHH END AND
	  	CAST(oc.fecEmis AS date) BETWEEN CAST(?xfechaDD AS DATE) AND CAST(?xfechaHH AS DATE)
	 ORDER BY
	 	oc.idOrdPagC DESC
ENDTEXT

loRes = CREATEOBJECT("odbc_result")
lcSql = loRes.AddParameter(lcSql, "xidProvDD", ALLTRIM(STR(tnIdProvDD)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "xidProvHH", ALLTRIM(STR(tnIdProvHH)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "xNroOPDD", ALLTRIM(STR(tnNroOPDD)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "xNroOPHH", ALLTRIM(STR(tnNroOPHH)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "xfechaDD", tdFechaDD, .f., .t.)
lcSql = loRes.AddParameter(lcSql, "xfechaHH", tdFechaHH, .f., .t.)

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"
loRes.OpenQuery(lcSql)

SELECT cur_op
ZAP
APPEND FROM DBF("cur_x")
loRes.Close_Query()

SELECT cur_op
GO TOP
ENDPROC
PROCEDURE get_orden_pago_byid
**********************************************************
* Obtiene todos los datos asociada a una orden de pago
* por Id.
* Fecha: 09/08/2023
**********************************************************
LPARAMETERS tnId

This.get_cabecera_by_opid(tnId)
This.get_comprob_by_idop(tnId)
This.get_cheques_terceros_by_idop(tnId)
This.get_cheques_propios_byidop(tnId)
This.get_depositos_byopid(tnId)


ENDPROC
PROCEDURE get_comprob_by_idop
***********************************************************************
* Obtiene los comprobantes asociados a una orden de pago por ID.
* Fecha: 09/08/2023
***********************************************************************
LPARAMETERS tnId

LOCAL loRes
LOCAL lcSql

loRes = CREATEOBJECT("odbc_result")

* El campo saldo lo pongo por una tema la estructura del cursor
* pero no lo voy a mostrar en la reimpresión.
TEXT TO lcSql NOSHOW
	SELECT 
	  1 AS 'sel',
	  od.idCompraC,
	  c.idProv,
	  c.fecEmis,
	  c.fecVto,
	  c.cbte,
	  c.tipoDoc,
	  CONCAT(REPEAT('0', 4 - LENGTH(c.ptoVta)), c.ptoVta, '-', REPEAT('0', 8 - LENGTH(c.numCbte)), c.numCbte) AS 'nroFC',
	  od.imppag,
	  0 AS 'saldo'
	FROM 
	  ordpag_dc od
	    INNER JOIN comprascab c ON od.idCompraC = c.idCompraC
	WHERE
	  od.idOrdPagC = ?xid;
ENDTEXT

lcSql = loRes.AddParameter(lcSql, "xid", ALLTRIM(STR(tnId)), .f., .f.)
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"
loRes.OpenQuery(lcSql)
SELECT comprob
ZAP
APPEND FROM DBF("cur_x")
loRes.Close_Query()

SELECT comprob
GO TOP
ENDPROC
PROCEDURE get_cheques_terceros_by_idop
**************************************************************************************************
* Permite obtener los chequesde terceros asociados a una orden de pago por id de orden de pago
* Fecha: 09/08/2023
**************************************************************************************************
LPARAMETERS tnId

LOCAL loRes
LOCAL lcSql

loRes = CREATEOBJECT("odbc_result")
TEXT TO lcSql NOSHOW
	SELECT
	  1 AS 'sel',
	  c.idCheque,
	  c.idCliente,
	  c1.razSoc,
	  b.idBanco,
	  b.codBco,
	  b.descripcio,
	  c.tipo,
	  c.sucursal,
	  c.chq_nro,
	  c.fecEmis,
	  c.fecVto,
	  c.importe,
	  c.tipoDoc,
	  c.nroCUIT,
	  c.titular,
	  c.NroRec
	FROM
	  ordpag_d od
	    INNER JOIN cheques c ON od.idCheque = c.idCheque
	    INNER JOIN bancos b ON c.idBanco = b.idBanco
	    INNER JOIN clientes c1 ON c.idCliente = c1.idCliente
	WHERE
	  od.idOrdPagC = ?xid;
ENDTEXT
lcSql = loRes.AddParameter(lcSql, "xid", ALLTRIM(STR(tnId)), .f., .f.)

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"
loRes.OpenQuery(lcSql)

SELECT cheq_disp
ZAP
APPEND FROM DBF("cur_x")
loRes.Close_Query()

* Pongo sel en true para que lo imprima
UPDATE cheq_disp SET sel = .T.

SELECT cheq_disp
GO TOP


ENDPROC
PROCEDURE get_cheques_propios_byidop
************************************************************************
* Obtiene los cheques propios cargados en una determinada orden de pago.
* Fecha: 10/08/2023
************************************************************************
LPARAMETERS tnId

LOCAL loRes
LOCAL lcSql

loRes = CREATEOBJECT("odbc_result")

TEXT TO lcSql NOSHOW
	SELECT
	  c.idChequeP,
	  c.idChequera,
	  opd.idPlanCta,
	  c.idBanco,
	  b.descripcio,
	  c.idProv,
	  opd.idOrdPagC,
	  CONCAT(REPEAT('0', 8 - LENGTH(c.nroCheque)), c.nroCheque) AS 'nroCheque',
	  c.fecEmis,
	  c.fecVto,
	  c.importe
	FROM
	  ordpag_d opd
	    INNER JOIN chequesp c ON opd.idChequeP = c.idChequeP
	    INNER JOIN bancos b ON c.idBanco = b.idBanco
	WHERE
	  opd.idOrdPagC = ?xid;
ENDTEXT

lcSql = loRes.AddParameter(lcSql, "xid", ALLTRIM(STR(tnId)), .f., .f.)

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"
loRes.OpenQuery(lcSql)

SELECT chequesp
ZAP
APPEND FROM DBF("cur_x")

loRes.Close_Query()

SELECT chequesp
GO TOP
ENDPROC
PROCEDURE get_depositos_byopid
******************************************************************************
* Obtiene los depósitos asociados a una orden de pago por id.
* Fecha: 10/08/2023
******************************************************************************
LPARAMETERS tnId

LOCAL loRes
LOCAL lcSql

loRes = CREATEOBJECT("odbc_result")

TEXT TO lcSql NOSHOW
	SELECT
	  opd.idBanco,
	  opd.idPlanCta,
	  b.codBco,
	  b.descripcio AS 'nomBco',
	  IFNULL(opd.nroTrans, "") AS 'nroTrans',
	  opd.fecTrans,
	  opd.nomOrig,
	  opd.docOrig,
	  opd.importe
	FROM
	  ordpag_d opd
	    INNER JOIN bancos b ON opd.idBanco = b.idBanco
	WHERE
	  opd.idOrdPagC = ?xid AND 
	  opd.tipoPago = 'TRAN'
ENDTEXT

lcSql = loRes.AddParameter(lcSql, "xid", ALLTRIM(STR(tnId)), .f., .f.)
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"
loRes.OpenQuery(lcSql)
SELECT deposito
ZAP
APPEND FROM DBF("cur_x")

loRes.Close_Query()

SELECT deposito
GO TOP
ENDPROC
PROCEDURE get_suma_efvo_byopid
****************************************************************
* Obtiene la suma de los efectivos aplicados de una
* orden de pago.
* Fecha: 10/08/2023
****************************************************************
LPARAMETERS tnId

LOCAL loRes
LOCAL lcSql
LOCAL lnImporte

loRes = CREATEOBJECT("odbc_result")
TEXT TO lcSql NOSHOW
	SELECT 
	  SUM(od.importe) AS 'importe'
	FROM
	  ordpag_d od
	WHERE
	  od.idOrdPagC = ?xid AND
	  od.tipoPago = 'EFVO';
ENDTEXT

lcSql = loRes.AddParameter(lcSql, "xid", ALLTRIM(STR(tnId)), .f., .f.)
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"
loRes.OpenQuery(lcSql)
lnImporte = cur_x.importe
loRes.Close_Query()

RETURN lnImporte
ENDPROC
PROCEDURE get_retencion_ganancia_byopid
LPARAMETERS tnId

LOCAL loRes, lcSql
LOCAL lnImporte

lnImporte = 0.00

loRes = CREATEOBJECT("odbc_result")
TEXT TO lcSql NOSHOW
	SELECT
		importe
	FROM
		ordpag_d
	WHERE
		idOrdPagC = ?xid AND
		tipoPago = 'RGAN'
ENDTEXT
lcSql = loRes.AddParameter(lcSql, "xid", ALLTRIM(STR(tnId)), .f., .f.)
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"
loRes.OpenQuery(lcSql)
SELECT cur_x
lnImporte = cur_x.importe
loRes.Close_Query()

RETURN lnImporte
ENDPROC
PROCEDURE get_retencion_iibb_byopid
LPARAMETERS tnId

LOCAL loRes, lcSql
LOCAL lnImporte

lnImporte = 0.00

loRes = CREATEOBJECT("odbc_result")
TEXT TO lcSql NOSHOW
	SELECT
		importe
	FROM
		ordpag_d
	WHERE
		idOrdPagC = ?xid AND
		tipoPago = 'RIB'
ENDTEXT
lcSql = loRes.AddParameter(lcSql, "xid", ALLTRIM(STR(tnId)), .f., .f.)
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"
loRes.OpenQuery(lcSql)
SELECT cur_x
lnImporte = cur_x.importe
loRes.Close_Query()

RETURN lnImporte
ENDPROC
PROCEDURE get_retension_iva_byopid
LPARAMETERS tnId

LOCAL loRes, lcSql
LOCAL lnImporte

lnImporte = 0.00

loRes = CREATEOBJECT("odbc_result")
TEXT TO lcSql NOSHOW
	SELECT
		importe
	FROM
		ordpag_d
	WHERE
		idOrdPagC = ?xid AND
		tipoPago = 'RIVA'
ENDTEXT
lcSql = loRes.AddParameter(lcSql, "xid", ALLTRIM(STR(tnId)), .f., .f.)
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"
loRes.OpenQuery(lcSql)
SELECT cur_x
lnImporte = cur_x.importe
loRes.Close_Query()

RETURN lnImporte
ENDPROC
PROCEDURE get_rsuss_by_opid
LPARAMETERS tnId

LOCAL loRes, lcSql
LOCAL lnImporte

lnImporte = 0.00

loRes = CREATEOBJECT("odbc_result")
TEXT TO lcSql NOSHOW
	SELECT
		importe
	FROM
		ordpag_d
	WHERE
		idOrdPagC = ?xid AND
		tipoPago = 'RSUSS'
ENDTEXT
lcSql = loRes.AddParameter(lcSql, "xid", ALLTRIM(STR(tnId)), .f., .f.)
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"
loRes.OpenQuery(lcSql)
SELECT cur_x
lnImporte = cur_x.importe
loRes.Close_Query()

RETURN lnImporte
ENDPROC
PROCEDURE get_datos_proveedor_byid
******************************************************************
* Obtiene los datos del proveedor que necesito para imprimir en
* el reporte.
* Fecha: 17/08/2023
******************************************************************
LOCAL loRes, lcSql

loRes = CREATEOBJECT("odbc_result")
lcSql = ""

TEXT TO lcSql NOSHOW
	SELECT 
	  proveedor.razsoc, 
	  proveedor.direccion, 
	  proveedor.nrocuit, 
	  proveedor.telefono, 
	  localidad.codpostal as codpostal, 
	  localidad.descripcio as loc, 
	  provincias.descripcio as provincia, 
	  sitiva.descripcio as sitiva, 
	  condpagos.descripcio as condpago 
	FROM proveedor 
	  INNER JOIN localidad on proveedor.idlocalid = localidad.idlocalid 
	  INNER JOIN provincias on localidad.idprovin = provincias.idprovin 
	  INNER JOIN sitiva on proveedor.idsitiva = sitiva.idsitiva 
	  INNER JOIN condpagos on proveedor.idcondpago = condpagos.idcondpago 
	WHERE proveedor.idprov = ?xid
ENDTEXT

lcSql = loRes.AddParameter(lcSql, "xid", ALLTRIM(STR(this.idprov)), .f., .f.)
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"
loRes.OpenQuery(lcSql)

SELECT cur_prov
ZAP
APPEND FROM DBF("cur_x")

loRes.Close_Query()

SELECT cur_prov
GO TOP
ENDPROC
PROCEDURE get_importes_reimpresion_byopid
**************************************************************
* Obtiene los importe para poner en la reimpresión de la op.
* Fecha: 17/08/2023
**************************************************************
LPARAMETERS tnId

LOCAL loRes, lcSql

loRes = CREATEOBJECT("odbc_result")
lcSql = ""

TEXT TO lcSql NOSHOW
	SELECT 
	  od.tipoPago,
	  p.descripcio AS 'cuenta',
	  od.importe,
	  p1.descripcio AS 'provincia'
	FROM 
	  ordpag_d od
	    INNER JOIN planctas p ON od.idPlanCta = p.idPlanCta
	    LEFT JOIN provincias p1 ON od.idProvin = p1.idProvin
	WHERE
	  od.idOrdPagC = ?xid;
ENDTEXT

lcSql = loRes.AddParameter(lcSql, "xid", ALLTRIM(STR(tnId)), .f., .f.)
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"
loRes.OpenQuery(lcSql)
SELECT cur_importes
ZAP
APPEND FROM DBF("cur_x")
loRes.Close_Query()
ENDPROC
PROCEDURE get_cabecera_by_opid
************************************************************************
* Permite obtener la cabecera de una orden de pago por id.
* Fecha: 09/08/203
************************************************************************
LPARAMETERS tnId

LOCAL loRes
LOCAL lcSql

loRes = CREATEOBJECT("odbc_result")

TEXT TO lcSql NOSHOW
	SELECT
	  oc.idOrdPagC,
	  oc.fecEmis,
	  CONCAT(REPEAT('0', 8 - LENGTH(oc.nroOP)), oc.nroOP) AS 'nroOP',
	  oc.idProv,
	  p.razSoc,
	  oc.importe,
	  oc.usuAlta,
	  oc.fecAlta,
	  oc.idHostAlta
	FROM 
	  ordpag_c oc
	    INNER JOIN proveedor p ON oc.idProv = p.idProv
	WHERE
		oc.idOrdPagC = ?xid
	ORDER BY
	 	oc.idOrdPagC DESC
ENDTEXT

loRes = CREATEOBJECT("odbc_result")
lcSql = loRes.AddParameter(lcSql, "xid", ALLTRIM(STR(tnId)), .f., .f.)

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"
loRes.OpenQuery(lcSql)

SELECT cur_op
ZAP
APPEND FROM DBF("cur_x")
loRes.Close_Query()

SELECT cur_op
GO TOP
ENDPROC
PROCEDURE eliminar
***************************************************
* Permite eliminar una orden de pago
* Fecha: 14/05/2024
* Desarrollador: Leonardo D. Zulli
***************************************************

LOCAL loRes
LOCAL lcSql
LOCAL llResult

loRes = CREATEOBJECT("odbc_result")

lcSql = "CALL ordpag_delete(?xidProv, ?xidOrdPagC, ?xusuario, ?xhost)"
lcSql = loRes.AddParameter(lcSql, "xidProv", ALLTRIM(STR(This.idprov)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "xidOrdPagC", ALLTRIM(STR(This.id_orden_pago)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "xusuario", ALLTRIM(gcCodUsu), .t., .f.)
lcSql = loRes.AddParameter(lcSql, "xhost", ALLTRIM(SYS(0)), .t., .f.)

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_result"
loRes.OpenQuery(lcSql)
SELECT cur_result

IF cur_result.result = 0 THEN
	llResult = .F.
ELSE
	llResult = .T.
ENDIF

This.mensaje = ALLTRIM(cur_result.mensaje)
loRes.Close_Query()

RETURN llResult
ENDPROC


************************************************************
OBJETO: cls_frmcbtes_cpas
************************************************************
*** PROPIEDADES ***
BorderStyle = 2
Height = 544
Width = 946
DoCreate = .T.
Caption = "Ingreso de comprobantes"
idsitiva = 0
idcomprac_orig = 0
idoper = 0
Name = "cls_frmcbtes_cpas"
contenido.Name = "contenido"

*** METODOS ***
PROCEDURE blanquear
&& Cabecera
Thisform.Contenido.cmbCbte.ListIndex = 1
Thisform.Contenido.cmbTipoDoc.ListIndex = 1
Thisform.Contenido.txtPtoVta.Value = "0000"
Thisform.Contenido.txtNroCbte.Value = "00000000"
Thisform.Contenido.chkCosto.Value = 0
Thisform.Contenido.sel_proveedor.blanquear()
Thisform.Contenido.txtNroCUIT.blanquear()
Thisform.Contenido.txtSitIVA.blanquear()
Thisform.Contenido.sel_condpago.blanquear()
Thisform.Contenido.txtFecEmision.Value = DATE()
Thisform.Contenido.txtFecVto.blanquear()
Thisform.contenido.btnSelCbteOrig.Enabled = .F.
Thisform.contenido.txtcbteOrig.blanquear()
Thisform.contenido.txtletraOrig.blanquear()
Thisform.contenido.txtptoVtaOrig.blanquear()
Thisform.contenido.txtnumeroOrig.blanquear()
Thisform.idOper = 0

&& Page 1
Thisform.Contenido.page_group.page1.sel_articulo.blanquear()
Thisform.Contenido.page_group.page1.cmbUnidCpa.Clear()
Thisform.Contenido.page_group.page1.txtCantPack.blanquear()
Thisform.Contenido.page_group.page1.txtCantidad.blanquear()
Thisform.Contenido.page_group.page1.txtPrLista.blanquear()
Thisform.Contenido.page_group.page1.txtBonif1.blanquear()
Thisform.Contenido.page_group.page1.txtBonif2.blanquear()
Thisform.Contenido.page_group.page1.txtBonif3.blanquear()
Thisform.Contenido.page_group.page1.txtBonif4.blanquear()
Thisform.Contenido.page_group.page1.txtAlicIVA.blanquear()
Thisform.Contenido.page_group.page1.txtImpIVA.blanquear()
Thisform.Contenido.page_group.page1.txtCostoRep.blanquear()
Thisform.Contenido.page_group.page1.txtCostoFinal.blanquear()
Thisform.Contenido.page_group.page1.txtSTFinal.blanquear()
Thisform.Contenido.page_group.page1.txtSTNeto.blanquear()
Thisform.Contenido.page_group.page1.txtPrLista.ReadOnly = .F.
Thisform.Contenido.page_group.page1.txtCostoRep.ReadOnly = .T.

&& Page 2
Thisform.Contenido.page_group.page2.sel_concepto.blanquear()
Thisform.Contenido.page_group.page2.txtImpNeto.blanquear()
Thisform.Contenido.page_group.page2.txtImpIVA.blanquear()
Thisform.Contenido.page_group.page2.txtTotal.blanquear()

&& Page 3
Thisform.contenido.page_group.page3.txtGanancias.blanquear()
Thisform.contenido.page_group.page3.txtIIBB.blanquear()
Thisform.contenido.page_group.page3.txtIVA.blanquear()
Thisform.contenido.page_group.page3.txtSUSS.blanquear()
Thisform.contenido.page_group.page3.cmbPcias.ListIndex = 1
Thisform.contenido.page_group.page3.txtImpuestos.blanquear()

&& Totales
Thisform.contenido.txtnoGravado.blanquear()
Thisform.Contenido.txtTotalNeto.blanquear()
Thisform.Contenido.txtImpIVA105.blanquear()
Thisform.Contenido.txtImpIVA21.blanquear()
Thisform.Contenido.txtPercepciones.blanquear()
Thisform.Contenido.txtimpuestos.blanquear()
Thisform.Contenido.txtTotalFinal.blanquear()


Thisform.compras.limpiar()
Thisform.mov_stock.limpiar()
Thisform.Contenido.page_group.page1.SetFocus()
Thisform.Contenido.cmbCbte.SetFocus()
ENDPROC
PROCEDURE calcular_item
LOCAL lnPrLista, lnBonif1, lnBonif2, lnBonif3, lnBonif4
LOCAL lnCostoRep, lnAlicIVA, lnImpIVA, lnCostoFinal
LOCAL lnCantidad

lnPrLista = 0.00
lnBonif1 = 0.00
lnBonif2 = 0.00
lnBonif3 = 0.00
lnBonif4 = 0.00
lnCostoRep = 0.00
lnAlicIVA = 0.00
lnImpIVA = 0.00
lnCostoFinal = 0.00
lnCantidad = 0.00

lnPrLista = Thisform.Contenido.page_group.page1.txtPrLista.Value
lnBonif1 = Thisform.Contenido.page_group.page1.txtBonif1.Value
lnBonif2 = Thisform.Contenido.page_group.page1.txtBonif2.Value
lnBonif3 = Thisform.Contenido.page_group.page1.txtBonif3.Value
lnBonif4 = Thisform.Contenido.page_group.page1.txtBonif4.Value
lnAlicIVA = Thisform.Contenido.page_group.page1.txtAlicIVA.Value
lnCantidad = Thisform.Contenido.page_group.page1.txtCantidad.Value

lnCostoRep = Thisform.compras.calcular_costoneto(lnPrLista,lnBonif1,lnBonif2,lnBonif3,lnBonif4)
lnImpIVA = Thisform.compras.calcular_impiva(lnCostoRep, lnAlicIVA)
lnCostoFinal = lnCostoRep + lnImpIVA

Thisform.Contenido.page_group.page1.txtImpIVA.Value = lnImpIVA
Thisform.Contenido.page_group.page1.txtCostoRep.Value = lnCostoRep
Thisform.Contenido.page_group.page1.txtCostoFinal.Value = lnCostoFinal
Thisform.Contenido.page_group.page1.txtSTNeto.Value = Thisform.compras.calcular_totneto(lnCostoRep, lnCantidad)

Thisform.Contenido.page_group.page1.txtSTFinal.Value = Thisform.Compras.calcular_totfinal(lnCantidad, ;
	Thisform.Contenido.page_group.page1.txtSTNeto.Value, lnImpIVA)
ENDPROC
PROCEDURE calcular_item_cp
LOCAL lnImpNeto, lcAlicIVA, lnImpIVA
LOCAL lnTotal

lnImpNeto = 0.00
lnAlicIVA = 0.00
lnImpIVA = 0.00
lnTotal = 0.00

lnImpNeto = Thisform.Contenido.page_group.page2.txtImpNeto.Value
lnAlicIVA = FLOAT(VAL(Thisform.Contenido.page_group.page2.cmbAlicIva.Value)) 
lnImpIVA = Thisform.Contenido.page_group.page2.txtImpIVA.Value
lnTotal = Thisform.Contenido.page_group.page2.txtTotal.Value

lnImpIVA = lnImpNeto * (lnAlicIVA / 100)
lnTotal = lnImpNeto + lnImpIVA

Thisform.Contenido.page_group.page2.txtImpIVA.Value = lnImpIVA
Thisform.Contenido.page_group.page2.txtTotal.Value = lnTotal
ENDPROC
PROCEDURE validar_comprobante
LOCAL loRes
LOCAL lcSql
LOCAL lnPtoVta
LOCAL lnNumCbte
LOCAL lnResp
LOCAL lnIdProv

loRes = CREATEOBJECT("odbc_result")
lcSql = ""
lnPtoVta = 0
lnNumCbte = 0
lnResp = 0
lnIdProv = Thisform.Contenido.sel_Proveedor.valcpoid

lnPtoVta = INT(VAL(Thisform.Contenido.txtPtoVta.Value))
lnNumCbte = INT(VAL(Thisform.Contenido.txtNroCbte.Value))

lcSql = "SELECT idCompraC "
lcSql = lcSql + "FROM comprascab "
lcSql = lcSql + "WHERE comprascab.ptoVta = " + ALLTRIM(STR(lnPtoVta)) + " "
lcSql = lcSql + "	AND comprascab.numCbte = " + ALLTRIM(STR(lnNumCbte)) + " "
lcSql = lcSql + "	AND comprascab.idProv = " + ALLTRIM(STR(lnIdProv))

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_x

IF RECCOUNT("cur_x") > 0 THEN
	lnResp = MESSAGEBOX("Este número de comprobante ya fue cargado, ¿Desea continuar de todos modos?", 4+32, Thisform.Caption)
	IF lnResp = 6 THEN
		loRes.Close_Query()
		RETURN .T.
	ELSE
		loRes.Close_Query()
		RETURN .F.
	ENDIF
ENDIF

loRes.Close_Query()
RETURN .T.

ENDPROC
PROCEDURE cambiar_estado
PARAMETERS tlEstado

Thisform.Contenido.CmbCbte.Enabled = tlEstado
Thisform.Contenido.CmbTipoDoc.Enabled = tlEstado
Thisform.Contenido.txtPtoVta.Enabled = tlEstado
Thisform.Contenido.txtNroCbte.Enabled = tlEstado
Thisform.Contenido.txtFecEmision.Enabled = tlEstado
Thisform.Contenido.txtFEcVto.Enabled = tlEstado
Thisform.Contenido.sel_proveedor.txtCodigo.Enabled = tlEstado
Thisform.Contenido.sel_condpago.txtCodigo.Enabled = tlEstado
Thisform.Contenido.btnSelCbteOrig.Enabled = tlEstado

Thisform.Contenido.page_group.page1.Enabled = !tlEstado
Thisform.Contenido.page_group.page2.Enabled = !tlEstado
Thisform.Contenido.page_group.page3.Enabled = !tlEstado
ENDPROC
PROCEDURE cargar_comboiva
&& Cargo el combobox con el iva
LOCAL lnIVA1, lnIVA2

lnIVA1 = GetGlobalCFG("IVA_1")
lnIVA2 = GetGlobalCFG("IVA_2")

Thisform.contenido.page_group.page2.cmbAlicIva.AddItem(ALLTRIM(STR(lnIVA1,10,2)))
Thisform.contenido.page_group.page2.cmbAlicIva.AddItem(ALLTRIM(STR(lnIVA2,10,2)))
Thisform.contenido.page_group.page2.cmbAlicIva.AddItem("0.00")

Thisform.contenido.page_group.page2.cmbAlicIva.ListIndex = 1
ENDPROC
PROCEDURE cargar_provincias
LOCAL loRes, lcSql

loRes = CREATEOBJECT("odbc_result")
lcSql = ""

&& Levanto las provincias
CREATE CURSOR pcias ( ;
	descripcio varchar(60),;
	idProvin int)

lcSql = "SELECT * FROM provincias ORDER BY provincias.descripcio"
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_tempo"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.ErrorMessage, 0+48, Thisform.Caption)
	RETURN
ENDIF

SELECT cur_tempo
GO TOP
DO WHILE !EOF("cur_tempo")
	SELECT pcias
	APPEND BLANK
	REPLACE pcias.descripcio WITH cur_tempo.descripcio ADDITIVE
	REPLACE pcias.idProvin WITH cur_tempo.idProvin


	SELECT cur_tempo
	SKIP
ENDDO

loRes.Close_Query()

SELECT pcias
GO TOP


Thisform.contenido.page_group.page3.cmbPcias.BoundColumn = 2
Thisform.contenido.page_group.page3.cmbPcias.RowSourceType = 2
Thisform.contenido.page_group.page3.cmbPcias.RowSource = "pcias"

Thisform.contenido.page_group.page3.cmbPcias.ListIndex = 1


ENDPROC
PROCEDURE validardetalle
IF Thisform.contenido.page_group.page1.sel_articulo.valcpoid = 0 THEN
	MESSAGEBOX("Debe ingresar el artículo", 0+48, Thisform.Caption)
	Thisform.contenido.page_group.page1.sel_articulo.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

IF Thisform.contenido.page_group.page1.txtCantidad.Value = 0 THEN
	MESSAGEBOX("La cantidad no puede ser 0 (cero)", 0+48, Thisform.Caption)
	Thisform.contenido.page_group.page1.txtCantidad.SetFocus()
	RETURN .F.
ENDIF

RETURN .T.
ENDPROC
PROCEDURE validarcampos
IF Thisform.Contenido.txtPtoVta.Value = "0000" .OR. ALLTRIM(Thisform.Contenido.txtPtoVta.Value) == "" THEN
	MESSAGEBOX("Debe ingresar el punto de venta", 0+48, Thisform.Caption)
	Thisform.Contenido.txtPtoVta.SetFocus()
	RETURN .F.
ENDIF

IF Thisform.Contenido.txtNroCbte.Value == "00000000" .OR. ALLTRIM(Thisform.Contenido.txtNroCbte.Value) == "" THEN
	MESSAGEBOX("Debe ingresar el número de comprobante", 0+48, Thisform.Caption)
	Thisform.Contenido.txtNroCbte.SetFocus()
	RETURN .F.
ENDIF

IF Thisform.contenido.sel_proveedor.valcpoid = 0 OR Thisform.contenido.sel_proveedor.txtCodigo.Value = 0 THEN
	MESSAGEBOX("Debe ingresar el proveedor", 0+48, Thisform.Caption)
	Thisform.contenido.sel_proveedor.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

IF Thisform.contenido.sel_condpago.valcpoid = 0 THEN
	MESSAGEBOX("Debe ingresar la condición de pago", 0+48,  Thisform.Caption)
	Thisform.contenido.sel_condpago.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

IF Thisform.Contenido.txtfecEmision.Value = {} THEN
	MESSAGEBOX("Debe ingresar la fecha de emisión", 0+48, Thisform.Caption)
	Thisform.Contenido.sel_CondPago.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

IF Thisform.Contenido.txtFecVto.Value = {} THEN
	MESSAGEBOX("Debe ingresar la fecha de vencimiento", 0+48, Thisform.Caption)
	Thisform.Contenido.sel_CondPago.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

RETURN .T.
ENDPROC
PROCEDURE Init
Thisform.mov_stock.circuito = "C"
Thisform.mov_stock.crear_cursor()

Thisform.compras.crear_cursor()
Thisform.cargar_comboiva()
Thisform.cargar_provincias()

SELECT comprasdet
Thisform.contenido.page_group.page1.grdDetalle.alias_name = "comprasdet"
Thisform.contenido.page_group.page1.grdDetalle.RecordSource = "comprasdet"
Thisform.contenido.page_group.page1.grdDetalle.list_controlsource = "codArt,descripcio,cantidad,prLista,costoNeto,alicIVA,impIVA,costoFinal,totNeto,totFinal"
Thisform.contenido.page_group.page1.grdDetalle.lista_ancho_cols = "100,200,70,70,70,70,70,70,70,70"
Thisform.contenido.page_group.page1.grdDetalle.titulos_cabeceras = "Código,Descripción,Cantidad,Pr. Lista,Costo Neto,IVA %,IVA $,Costo Final,Total Neto, Total Final"
Thisform.contenido.page_group.page1.grdDetalle.generar_grid()

SELECT cpasdet_cp
Thisform.contenido.page_group.page2.grdDetalle.alias_name = "cpasdet_cp"
Thisform.contenido.page_group.page2.grdDetalle.RecordSource = "cpasdet_cp"
Thisform.contenido.page_group.page2.grdDetalle.list_controlsource = "codPlanCta,descripcio,impNeto,ivaPor,ivaImp,total"
Thisform.contenido.page_group.page2.grdDetalle.titulos_cabeceras = "Código,Descripción,Imp. Neto,Alíc. IVA,IVA,Total"
Thisform.contenido.page_group.page2.grdDetalle.lista_ancho_cols = "100,300,70,70,70,70"
Thisform.contenido.page_group.page2.grdDetalle.generar_grid()

SELECT comprasret
Thisform.contenido.page_group.page3.grdIIBB.alias_name= "comprasret"
Thisform.contenido.page_group.page3.grdIIBB.RecordSource = "comprasret"
Thisform.contenido.page_group.page3.grdIIBB.list_controlsource = "Provincia,importe"
Thisform.contenido.page_group.page3.grdIIBB.titulos_cabeceras = "Provincia,Importe"
Thisform.contenido.page_group.page3.grdIIBB.lista_ancho_cols = "300,70"
Thisform.contenido.page_group.page3.grdIIBB.generar_grid()

Thisform.Contenido.cmbCbte.AddItem("FC")
Thisform.Contenido.cmbCbte.AddItem("NC")
Thisform.Contenido.cmbCbte.AddItem("ND")
Thisform.Contenido.cmbCbte.ListIndex = 1

IF INT(VAL(getconfig("DEMO"))) = 0 THEN 
	Thisform.Contenido.cmbTipoDoc.AddItem("A")
	Thisform.Contenido.cmbTipoDoc.AddItem("B")
	Thisform.Contenido.cmbTipoDoc.AddItem("C")
ELSE 
	Thisform.Contenido.cmbTipoDoc.AddItem("X")
ENDIF 

Thisform.Contenido.cmbTipoDoc.ListIndex = 1

Thisform.Contenido.txtPtoVta.Value = "0000"
Thisform.Contenido.txtNroCbte.Value = "00000000"
Thisform.Contenido.txtFecEmision.Value = DATE()
Thisform.idOper = 0

Thisform.Contenido.page_group.page1.txtPrLista.ReadOnly = .F.
Thisform.Contenido.page_group.page1.txtCostoRep.ReadOnly = .T.
Thisform.Cambiar_estado(.T.)
Thisform.contenido.btnSelCbteOrig.Enabled = .F.

&& Inicializo el tipo de movimiento de stock
IF ALLTRIM(Thisform.Contenido.cmbCbte.Value) == "FC" THEN
	Thisform.mov_stock.tipomov = "ENT"
ELSE 
	IF ALLTRIM(Thisform.Contenido.cmbCbte.Value) == "NC" THEN
		Thisform.mov_stock.tipomov = "SAL"
	ENDIF
ENDIF 
ENDPROC


************************************************************
OBJETO: compras
************************************************************
*** PROPIEDADES ***
Top = 504
Left = 84
Height = 17
Width = 24
Name = "compras"

*** METODOS ***


************************************************************
OBJETO: mov_stock
************************************************************
*** PROPIEDADES ***
Top = 504
Left = 120
Height = 17
Width = 38
Name = "mov_stock"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Proveedor:"
Height = 15
Left = 13
Top = 34
Width = 72
TabIndex = 17
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: sel_proveedor
************************************************************
*** PROPIEDADES ***
Top = 29
Left = 102
TabIndex = 5
pkfield = idProv
nombre_tabla = proveedor
nombre_campo_codigo = idProv
nombre_campo_desc = razSoc
esnumerico = .T.
alternative_cols = nomFant
title_cols = Descripción,Nombre Fantasía
anchos_cols = 400,250
Name = "sel_proveedor"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***
PROCEDURE recuperar_datos
LOCAL loRes
LOCAL lcSql

loRes = CREATEOBJECT("odbc_result")
lcSql = ""

&& Recupero la situación de IVA del proveedor
lcSql = "SELECT * FROM sitiva "
lcSql = lcSql + "WHERE sitiva.idSitIVA = " + ALLTRIM(STR(proveedor.idSitIVA))

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_sitiva"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN
ENDIF

SELECT cur_sitiva
GO TOP
Thisform.contenido.txtSitIVA.Value = ALLTRIM(cur_sitiva.descripcio)
Thisform.idsitiva = cur_sitiva.idSitIva

loRes.Close_Query()

&& Recupero la condición de pago del proveedor
lcSql = "SELECT * FROM condpagos "
lcSql = lcSql + "WHERE condpagos.idCondPago = " + ALLTRIM(STR(proveedor.idCondPago))

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_condpago"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN
ENDIF

SELECT cur_condpago
GO TOP
Thisform.contenido.sel_condpago.valcpoid = cur_condpago.idCondPago
Thisform.contenido.sel_condpago.txtCodigo.Value = cur_condpago.idCondPago
Thisform.contenido.sel_condpago.txtDescripcion.Value = ALLTRIM(cur_condpago.descripcio)
Thisform.Contenido.txtFecVto.Value = Thisform.Contenido.txtFecEmision.Value + cur_condpago.cntDias

loRes.Close_Query()

Thisform.contenido.txtNroCUIT.Value = ALLTRIM(proveedor.nroCUIT)

*!*	lcSql = "SELECT * FROM padronib WHERE CUIT = '" + ALLTRIM(proveedor.nroCUIT) + "'"
*!*	loRes.ActiveConnection = goConn.ActiveConnection
*!*	loRes.Cursor_Name = "cur_x"

*!*	IF !loRes.OpenQuery(lcSql) THEN
*!*		MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
*!*		RETURN
*!*	ENDIF

*!*	SELECT cur_x
*!*	IF RECCOUNT("cur_x") > 0 THEN
*!*		GO TOP
*!*		
*!*		Thisform.compras.poriibb = cur_x.alicuotaRet
*!*		Thisform.Contenido.txtPorIIBB.Value = cur_x.alicuotaRet
*!*	ENDIF

*!*	loRes.Close_Query()

This.Parent.page_group.page1.sel_articulo.criterio_filtro = "articulos.idProv = " + ALLTRIM(STR(This.valcpoid))

&& Pongo el ID de proveedor seleccionado en la variable global
gnSelectedIdProv = This.valcpoid




ENDPROC


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Situación I.V.A.:"
Height = 15
Left = 12
Top = 59
Width = 89
TabIndex = 25
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Nro. C.U.I.T.:"
Height = 15
Left = 621
Top = 34
Width = 72
TabIndex = 26
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: txtNroCUIT
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 696
ReadOnly = .T.
TabIndex = 28
Top = 31
Width = 133
ischaracter = .T.
Name = "txtNroCUIT"

*** METODOS ***


************************************************************
OBJETO: txtSitIVA
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 104
ReadOnly = .T.
TabIndex = 29
Top = 54
Width = 236
ischaracter = .T.
Name = "txtSitIVA"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Condición de Pago:"
Height = 15
Left = 352
Top = 59
Width = 111
TabIndex = 30
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: sel_condpago
************************************************************
*** PROPIEDADES ***
Top = 52
Left = 461
Width = 483
Height = 25
TabIndex = 7
pkfield = idCondPago
nombre_tabla = condpagos
nombre_campo_codigo = idcondpago
nombre_campo_desc = descripcio
esnumerico = .T.
Name = "sel_condpago"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***
PROCEDURE recuperar_datos
SELECT condpagos
Thisform.Contenido.txtFecVto.Value = Thisform.Contenido.txtFecEmision.Value + condpagos.cntDias
ENDPROC


************************************************************
OBJETO: Clsetiqueta14
************************************************************
*** PROPIEDADES ***
Caption = "Gravado"
Height = 15
Left = 103
Top = 454
Width = 84
TabIndex = 31
Name = "Clsetiqueta14"

*** METODOS ***


************************************************************
OBJETO: txtTotalNeto
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 102
ReadOnly = .T.
TabIndex = 33
Top = 469
Width = 85
isnumeric = .T.
Name = "txtTotalNeto"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta15
************************************************************
*** PROPIEDADES ***
Caption = "I.V.A. 21%"
Height = 15
Left = 196
Top = 454
Width = 60
TabIndex = 35
Name = "Clsetiqueta15"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta16
************************************************************
*** PROPIEDADES ***
Caption = "I.V.A. 10.5%"
Height = 15
Left = 286
Top = 454
Width = 62
TabIndex = 36
Name = "Clsetiqueta16"

*** METODOS ***


************************************************************
OBJETO: txtImpIVA21
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 193
ReadOnly = .T.
TabIndex = 37
Top = 469
Width = 85
isnumeric = .T.
Name = "txtImpIVA21"

*** METODOS ***


************************************************************
OBJETO: txtImpIVA105
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 284
ReadOnly = .T.
TabIndex = 38
Top = 469
Width = 85
isnumeric = .T.
Name = "txtImpIVA105"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta17
************************************************************
*** PROPIEDADES ***
Caption = "Total Final"
Height = 15
Left = 558
Top = 454
Width = 63
TabIndex = 39
Name = "Clsetiqueta17"

*** METODOS ***


************************************************************
OBJETO: txtTotalFinal
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 557
ReadOnly = .T.
TabIndex = 40
Top = 469
Width = 85
isnumeric = .T.
Name = "txtTotalFinal"

*** METODOS ***


************************************************************
OBJETO: btnGrabar
************************************************************
*** PROPIEDADES ***
Top = 494
Left = 849
TabIndex = 13
Name = "btnGrabar"

*** METODOS ***
PROCEDURE Click
IF RECCOUNT("comprasdet") = 0 .AND. RECCOUNT("cpasdet_cp") = 0 THEN
	MESSAGEBOX("Debe ingresar al menos un ítem ya sea artículo o concepto", 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

Thisform.compras.fecemis = Thisform.Contenido.txtFecEmision.Value
Thisform.compras.fecvto = Thisform.Contenido.txtFecVto.Value
Thisform.compras.cbte = Thisform.Contenido.cmbCbte.Value
Thisform.compras.tipodoc = Thisform.Contenido.cmbTipoDoc.Value
Thisform.compras.ptovta = INT(VAL(Thisform.Contenido.txtPtoVta.Value))
Thisform.compras.numcbte = INT(VAL(Thisform.Contenido.txtNroCbte.Value))
Thisform.compras.idprov = Thisform.Contenido.sel_proveedor.valcpoid
Thisform.compras.idsitiva = Thisform.idsitiva
Thisform.compras.totNeto = Thisform.Contenido.txtTotalNeto.Value

IF Thisform.compras.aliciva21 <> 0 THEN
	Thisform.compras.aliciva21 = 21
	Thisform.compras.impIVA21 = Thisform.Contenido.txtImpIVA21.Value
ENDIF

IF Thisform.compras.aliciva105 <> 0 THEN
	Thisform.compras.aliciva105 = 10.5
	Thisform.compras.impIVA105 = Thisform.Contenido.txtImpIVA105.Value
ENDIF

SELECT pcias
GO Thisform.contenido.page_group.page3.cmbPcias.ListIndex
Thisform.compras.idprovin = pcias.idprovin
Thisform.compras.percepciones = Thisform.Contenido.txtPercepciones.Value 
Thisform.compras.impuestos = Thisform.Contenido.txtimpuestos.Value
Thisform.compras.totfinal = Thisform.Contenido.txtTotalFinal.Value
Thisform.compras.idcondpago = Thisform.Contenido.sel_condpago.valcpoid
Thisform.compras.razsocpv = ALLTRIM(Thisform.Contenido.sel_proveedor.txtDescripcion.Value)
Thisform.compras.cuitpv = ALLTRIM(Thisform.Contenido.txtNroCUIT.Value)
Thisform.compras.idOper = Thisform.idOper
Thisform.compras.idcomprac_orig = Thisform.idcomprac_orig

IF !Thisform.compras.grabar() THEN
	MESSAGEBOX(Thisform.compras.error_message, 0+48, Thisform.Caption)
ENDIF

************************************************************************************************
* Agrego que se genere el movimiento de stock al grabar la operación
* siempre y cuando el sistema se encuentre configurado para soportar esta funcionalidad
************************************************************************************************
IF getGlobalCFG("STK_MODULE") .AND. getGlobalCFG("INGSTKCOMP") .AND. (ALLTRIM(Thisform.compras.cbte) == "FC") THEN
	IF ALLTRIM(thisform.compras.tipodoc) == "X" THEN
		Thisform.mov_stock.circuito = "S"
		Thisform.mov_stock.tipodoc = ""
		Thisform.mov_stock.cbte = ""
		
		IF !Thisform.mov_stock.grabar3() THEN
			MESSAGEBOX(Thisform.mov_stock.ErrorMessage, 0+48, Thisform.Caption)
			goConn.Rollback()
			RETURN .F.
		ENDIF
	ELSE
		Thisform.mov_stock.circuito = "C"
		Thisform.mov_stock.idcliente = 0
		Thisform.mov_stock.idprov = Thisform.compras.idprov
		Thisform.mov_stock.tipodoc = Thisform.compras.tipodoc
		Thisform.mov_stock.cbte = Thisform.compras.cbte
		Thisform.mov_stock.numcbte =  REPLICATE("0", 4 - LEN(ALLTRIM(STR(Thisform.compras.ptovta)))) + ALLTRIM(STR(Thisform.compras.ptovta)) + "-" + ;
									  REPLICATE("0", 8 - LEN(ALLTRIM(STR(Thisform.compras.numcbte)))) + ALLTRIM(STR(Thisform.compras.numcbte))		
	
		IF !Thisform.mov_stock.grabar2() THEN
			MESSAGEBOX(Thisform.mov_stock.ErrorMessage, 0+48, Thisform.Caption)
			goConn.Rollback()
			RETURN .F.
		ENDIF
	ENDIF
ENDIF
************************************************************************************************

MESSAGEBOX("El comprobante se grabó con éxito", 0+64, Thisform.Caption)


Thisform.Cambiar_estado(.T.)
Thisform.blanquear()

&& Inicializo nuevamente el tipo de movimiento de stock
IF ALLTRIM(Thisform.compras.cbte) == "FC" THEN
	Thisform.mov_stock.tipomov = "ENT"
ELSE 
	IF ALLTRIM(Thisform.compras.cbte) == "NC" THEN
		Thisform.mov_stock.tipomov = "SAL"
	ENDIF
ENDIF 
ENDPROC


************************************************************
OBJETO: btnCancelar
************************************************************
*** PROPIEDADES ***
Top = 494
Left = 13
Picture = ..\imagen\iconos bajados\deshacer-icono-5403.ico
TabIndex = 14
Name = "btnCancelar"

*** METODOS ***
PROCEDURE Click
Thisform.Cambiar_estado(.T.)
Thisform.blanquear()
ENDPROC


************************************************************
OBJETO: btnSalir
************************************************************
*** PROPIEDADES ***
Top = 494
Left = 896
TabIndex = 15
Name = "btnSalir"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta19
************************************************************
*** PROPIEDADES ***
Caption = "Percepciones"
Height = 15
Left = 376
Top = 454
Width = 81
TabIndex = 42
Name = "Clsetiqueta19"

*** METODOS ***


************************************************************
OBJETO: txtPercepciones
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 375
ReadOnly = .T.
TabIndex = 44
Top = 469
Width = 85
isnumeric = .T.
Name = "txtPercepciones"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta20
************************************************************
*** PROPIEDADES ***
Caption = "Comprobante:"
Height = 15
Left = 13
Top = 10
Width = 85
TabIndex = 19
Name = "Clsetiqueta20"

*** METODOS ***


************************************************************
OBJETO: cmbCbte
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 104
TabIndex = 1
Top = 8
Width = 57
Name = "cmbCbte"

*** METODOS ***
PROCEDURE InteractiveChange
IF This.Value = "FC" THEN 
	Thisform.contenido.btnSelCbteOrig.Enabled = .F.
ELSE 
	Thisform.contenido.btnSelCbteOrig.Enabled = .T.
ENDIF 

Thisform.contenido.txtcbteOrig.Value = ""
Thisform.contenido.txtletraOrig.Value = ""
Thisform.contenido.txtptoVtaOrig.Value = ""
Thisform.contenido.txtnumeroOrig.Value = ""
ENDPROC


************************************************************
OBJETO: cmbTipoDoc
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 163
TabIndex = 2
Top = 8
Width = 57
Name = "cmbTipoDoc"

*** METODOS ***


************************************************************
OBJETO: txtPtoVta
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 221
MaxLength = 4
TabIndex = 3
Top = 8
Width = 81
ischaracter = .T.
autocompleta = .T.
Name = "txtPtoVta"

*** METODOS ***


************************************************************
OBJETO: txtNroCbte
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 304
MaxLength = 8
TabIndex = 4
Top = 8
Width = 130
ischaracter = .T.
autocompleta = .T.
Name = "txtNroCbte"

*** METODOS ***


************************************************************
OBJETO: chkCosto
************************************************************
*** PROPIEDADES ***
Top = 8
Left = 445
Height = 18
Width = 480
Alignment = 0
Caption = "Los precios unitarios de los artículos de este comprobante corresponde al costo."
TabIndex = 16
Visible = .F.
Name = "chkCosto"

*** METODOS ***
PROCEDURE Click
IF This.Value = 1 THEN
	Thisform.Contenido.page_group.page1.txtPrLista.ReadOnly = .T.
	Thisform.Contenido.page_group.page1.txtCostoRep.ReadOnly = .F.
ELSE
	Thisform.Contenido.page_group.page1.txtPrLista.ReadOnly = .F.
	Thisform.Contenido.page_group.page1.txtCostoRep.ReadOnly = .T.
ENDIF
ENDPROC


************************************************************
OBJETO: Clsetiqueta23
************************************************************
*** PROPIEDADES ***
Caption = "Fecha de Emisión:"
Height = 15
Left = 12
Top = 83
Width = 101
TabIndex = 22
Name = "Clsetiqueta23"

*** METODOS ***


************************************************************
OBJETO: txtFecEmision
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 121
TabIndex = 8
Top = 77
Width = 108
isdatetime = .T.
Name = "txtFecEmision"

*** METODOS ***
PROCEDURE LostFocus
This.Parent.txtFecVto.Value = This.Value + condpagos.cntDias
ENDPROC


************************************************************
OBJETO: Clsetiqueta24
************************************************************
*** PROPIEDADES ***
Caption = "Fecha de Vto.:"
Height = 15
Left = 235
Top = 83
Width = 90
TabIndex = 21
Name = "Clsetiqueta24"

*** METODOS ***


************************************************************
OBJETO: txtFecVto
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 320
TabIndex = 9
Top = 77
Width = 108
isdatetime = .T.
Name = "txtFecVto"

*** METODOS ***
PROCEDURE Valid
IF (This.Value < This.Parent.txtFecEmision.Value) THEN
	MESSAGEBOX("La fecha de vencimiento no puede ser menor a la de compra.", 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

RETURN .T.
ENDPROC


************************************************************
OBJETO: page_group
************************************************************
*** PROPIEDADES ***
ErasePage = .T.
PageCount = 3
Top = 108
Left = 5
Width = 941
Height = 345
TabIndex = 12
Name = "page_group"
Page1.Caption = "Artículos"
Page1.Name = "Page1"
Page2.Caption = "Conceptos"
Page2.Name = "Page2"
Page3.FontBold = .T.
Page3.FontItalic = .T.
Page3.FontSize = 8
Page3.Caption = "Percepciones e Impuestos"
Page3.ForeColor = 128,64,64
Page3.Name = "Page3"

*** METODOS ***
PROCEDURE Page2.Click
Thisform.contenido.page_group.page2.sel_concepto.SetFocus()
ENDPROC


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Bonificaciones:"
Height = 15
Left = 168
Top = 37
Width = 89
TabIndex = 31
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: txtBonif1
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 260
TabIndex = 12
Top = 33
Width = 64
isnumeric = .T.
Name = "txtBonif1"

*** METODOS ***
PROCEDURE LostFocus
DODEFAULT()
=Thisform.Calcular_item()
ENDPROC


************************************************************
OBJETO: txtBonif2
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 326
TabIndex = 13
Top = 33
Width = 64
isnumeric = .T.
Name = "txtBonif2"

*** METODOS ***
PROCEDURE LostFocus
DODEFAULT()
=Thisform.Calcular_item()
ENDPROC


************************************************************
OBJETO: txtBonif3
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 392
TabIndex = 14
Top = 33
Width = 64
isnumeric = .T.
Name = "txtBonif3"

*** METODOS ***
PROCEDURE LostFocus
DODEFAULT()
=Thisform.Calcular_item()
ENDPROC


************************************************************
OBJETO: txtBonif4
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 458
TabIndex = 15
Top = 33
Width = 64
isnumeric = .T.
Name = "txtBonif4"

*** METODOS ***
PROCEDURE LostFocus
DODEFAULT()
=Thisform.Calcular_item()
ENDPROC


************************************************************
OBJETO: Clsetiqueta6
************************************************************
*** PROPIEDADES ***
Caption = "Artículo:"
Height = 15
Left = 6
Top = 14
Width = 56
TabIndex = 22
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: sel_articulo
************************************************************
*** PROPIEDADES ***
Top = 8
Left = 76
Width = 509
Height = 25
TabIndex = 8
pkfield = idArticulo
nombre_tabla = articulos
nombre_campo_codigo = codArt
nombre_campo_desc = descripcio
esnumerico = .F.
alternative_cols = 
title_cols = Descripción
anchos_cols = 400
autocompletar_ceros = .F.
nombre_alta_form = cls_alta_articulo
permitir_agregar_regs = .T.
Name = "sel_articulo"
txtCodigo.Height = 21
txtCodigo.Left = 2
txtCodigo.Top = 2
txtCodigo.Width = 148
txtCodigo.Name = "txtCodigo"
txtDescripcion.Height = 21
txtDescripcion.Left = 152
txtDescripcion.Top = 2
txtDescripcion.Width = 350
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***
PROCEDURE recuperar_datos
LOCAL loRes
LOCAL lcSql

loRes = CREATEOBJECT("odbc_result")
lcSql = ""

lcSql = "SELECT * FROM codiart "
lcSql = lcSql + "WHERE codiart.idArticulo = " + ALLTRIM(STR(articulos.idArticulo)) + " "
lcSql = lcSql + "	AND (codiart.circuito = 'CV' OR codiart.circuito = 'C') "

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_codiart"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN
ENDIF

This.Parent.cmbUnidCpa.Clear()
SELECT cur_codiart
GO TOP
DO WHILE !EOF("cur_codiart")
	This.Parent.cmbUnidCpa.AddItem(ALLTRIM(STR(cur_codiart.cantiDesp)))

	SELECT cur_codiart
	SKIP
ENDDO

IF RECCOUNT("cur_codiart") > 0 THEN
	This.Parent.cmbUnidCpa.ListIndex = 1
ENDIF

This.Parent.txtPrLista.Value = articulos.prLista
This.Parent.txtBonif1.Value = articulos.bonif1
This.Parent.txtBonif2.Value = articulos.bonif2
This.Parent.txtBonif3.Value = articulos.bonif3
This.Parent.txtBonif4.Value = articulos.bonif4
This.Parent.txtCostoRep.Value = articulos.costorep

IF INT(VAL(getConfig("DEMO"))) = 0 THEN 
	This.Parent.txtAlicIVA.Value = articulos.alicIVA
ELSE 
	This.Parent.txtAlicIVA.Value = 0.00
ENDIF 
	

Thisform.calcular_item()

loRes.Close_Query()
ENDPROC


************************************************************
OBJETO: Clsetiqueta7
************************************************************
*** PROPIEDADES ***
Caption = "Unid. CPA.:"
Height = 15
Left = 584
Top = 14
Width = 62
TabIndex = 32
Name = "Clsetiqueta7"

*** METODOS ***


************************************************************
OBJETO: cmbUnidCpa
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 652
TabIndex = 9
Top = 10
Width = 71
Name = "cmbUnidCpa"

*** METODOS ***
PROCEDURE InteractiveChange
LOCAL lnUnidVta

lnUnidVta = 0.00

lnUnidVta = VAL(this.Parent.cboUnidVta.Value)

this.Parent.txtCantidad.Value = ROUND(lnUnidVta * this.Parent.txtCantPack.Value, 2)
ENDPROC


************************************************************
OBJETO: txtCantPack
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 725
ReadOnly = .T.
TabIndex = 23
Top = 10
Width = 64
isnumeric = .T.
Name = "txtCantPack"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta8
************************************************************
*** PROPIEDADES ***
Caption = "Cantidad:"
Height = 15
Left = 801
Top = 14
Width = 56
TabIndex = 33
Name = "Clsetiqueta8"

*** METODOS ***


************************************************************
OBJETO: txtCantidad
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 856
TabIndex = 10
Top = 10
Width = 64
isnumeric = .T.
Name = "txtCantidad"

*** METODOS ***
PROCEDURE Valid
LOCAL lnUnidVta

lnUnidVta = 0.00

lnUnidVta = VAL(This.Parent.cmbUnidCpa.Value)

IF lnUnidVta <> 0 THEN
	IF (this.Value % lnUnidVta) <> 0 THEN
		MESSAGEBOX("La cantidad debe ser múltiplo de " + ALLTRIM(STR(lnUnidVta, 10, 2)), 0+48, Thisform.Caption)
		RETURN .F.
	ELSE	
		this.Parent.txtCantPack.Value = ROUND(this.Value / lnUnidVta, 2)
	ENDIF
ENDIF

IF This.Value < 0 THEN
	MESSAGEBOX("La cantidad no puede ser negativa", 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

RETURN .T.

ENDPROC
PROCEDURE LostFocus
DODEFAULT()
=Thisform.Calcular_item()

ENDPROC


************************************************************
OBJETO: Clsetiqueta9
************************************************************
*** PROPIEDADES ***
Caption = "Precio Lista:"
Height = 15
Left = 6
Top = 37
Width = 71
TabIndex = 34
Name = "Clsetiqueta9"

*** METODOS ***


************************************************************
OBJETO: txtPrLista
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 78
TabIndex = 11
Top = 33
Width = 87
isnumeric = .T.
Name = "txtPrLista"

*** METODOS ***
PROCEDURE LostFocus
DODEFAULT()
=Thisform.Calcular_item()
ENDPROC


************************************************************
OBJETO: Clsetiqueta10
************************************************************
*** PROPIEDADES ***
Caption = "Costo Rep.:"
Height = 15
Left = 584
Top = 37
Width = 68
TabIndex = 35
Name = "Clsetiqueta10"

*** METODOS ***


************************************************************
OBJETO: txtCostoRep
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 652
ReadOnly = .F.
TabIndex = 16
Top = 33
Width = 85
isnumeric = .T.
Name = "txtCostoRep"

*** METODOS ***
PROCEDURE LostFocus
DODEFAULT()

LOCAL lnBonif1, lnBonif2, lnBonif3, lnBonif4

lnBonif1 = This.Parent.txtBonif1.Value
lnBonif2 = This.Parent.txtBonif2.Value
lnBonif3 = This.Parent.txtBonif3.Value
lnBonif4 = This.Parent.txtBonif4.value

IF Thisform.contenido.chkCosto.Value = 1 THEN
	This.Parent.txtPrLista.Value = Thisform.Compras.calcular_prlista(This.Value, lnBonif1, lnBonif2, lnBonif3, lnBonif4)
ENDIF

=Thisform.Calcular_item()

ENDPROC


************************************************************
OBJETO: btnAgregar
************************************************************
*** PROPIEDADES ***
Top = 41
Left = 849
Height = 37
Width = 36
TabIndex = 17
Name = "btnAgregar"

*** METODOS ***
PROCEDURE Click
LOCAL lnIdArticulo
LOCAL lnCantidad
LOCAL lnCantPack
LOCAL lnPrLista
LOCAL lnPorDesc1
LOCAL lnPorDesc2
LOCAL lnPorDesc3
LOCAL lnPorDesc4
LOCAL lnCostoRep
LOCAL lnAlicIVA
LOCAL lnImpIVA
LOCAL lnCostoFinal
LOCAL lnSTNeto
LOCAL lnSTFinal
LOCAL lnResp
LOCAL lcCodArt

lnIdArticulo = 0
lnCantidad = 0.00
lnCantPack = 0.00
lnPrLista = 0.00
lnPorDesc1 = 0.00
lnPorDesc2 = 0.00
lnPorDesc3 = 0.00
lnPorDesc4 = 0.00
lnCostoRep = 0.00
lnAlicIVA = 0.00
lnImpIVA = 0.00
lnCostoFinal = 0.00
lnSTNeto = 0.00
lnSTFinal = 0.00
lnResp = 0
lcCodArt = ""

IF !Thisform.validardetalle() THEN
	RETURN
ENDIF


lnIdArticulo = This.Parent.sel_articulo.valcpoid
lnCantidad = This.Parent.txtCantidad.Value
lnCantPack = This.Parent.txtCantPack.Value
lnPrLista = This.Parent.txtPrLista.Value
lnPorDesc1 = This.Parent.txtBonif1.Value
lnPorDesc2 = This.Parent.txtBonif2.Value
lnPorDesc3 = This.Parent.txtBonif3.Value
lnPorDesc4 = This.Parent.txtBonif4.Value
lnCostoRep = This.Parent.txtCostoRep.Value
lnAlicIVA = This.Parent.txtAlicIVA.Value
lnImpIVA = This.Parent.txtImpIVA.Value
lnCostoFinal = This.Parent.txtCostoFinal.Value
lnSTNeto = This.Parent.txtSTNeto.Value
lnSTFinal = This.Parent.txtSTFinal.Value
lcCodArt = ALLTRIM(This.Parent.sel_Articulo.txtCodigo.Value)

IF !Thisform.compras.articulo_duplicado(lnIdArticulo) THEN
	lnResp = MESSAGEBOX(Thisform.compras.error_message, 4+32, Thisform.Caption)
	
	IF lnResp = 7 THEN
		RETURN
	ENDIF
ENDIF

Thisform.compras.agregar_detalle(lnIdArticulo, lnCantidad, lnCantPack,; 
	lnPrLista, lnPorDesc1, lnPorDesc2, lnPorDesc3, lnPorDesc4, lnCostoRep,;
	lnAlicIVA, lnImpIVA, lnCostoFinal, lnSTNeto, lnSTFinal)

Thisform.compras.totalizar_cbte()
Thisform.Contenido.txtTotalNeto.Value = Thisform.compras.totneto
Thisform.Contenido.txtImpIVA21.Value = Thisform.compras.impiva21
Thisform.Contenido.txtImpIVA105.Value = Thisform.compras.impiva105
Thisform.Contenido.txtPercepciones.Value = Thisform.compras.percepciones
Thisform.Contenido.txtTotalFinal.Value = Thisform.compras.totfinal

&& Si está habilitado el módulo de stock, entonces, genero el movimiento.
IF getGlobalCFG("STK_MODULE") THEN
	IF !(RIGHT(ALLTRIM(lcCodArt), 3) == "ARX") THEN
		Thisform.mov_stock.agregar_articulo(lnIdArticulo, lnCantidad, "")
	ENDIF
ENDIF
	
SELECT comprasdet
This.Parent.grdDetalle.Refresh()

This.Parent.sel_articulo.blanquear()
This.Parent.cmbUnidCpa.Clear()
This.Parent.txtCantPack.blanquear()
This.Parent.txtCantidad.blanquear()
This.Parent.txtPrLista.blanquear()
This.Parent.txtBonif1.blanquear()
This.Parent.txtBonif2.blanquear()
This.Parent.txtBonif3.blanquear()
This.Parent.txtBonif4.blanquear()
This.Parent.txtAlicIVA.blanquear()
This.Parent.txtImpIVA.blanquear()
This.Parent.txtCostoRep.blanquear()
This.Parent.txtCostoFinal.blanquear()
This.Parent.txtSTFinal.blanquear()
This.Parent.txtSTNeto.blanquear()
	
This.Parent.grdDetalle.Refresh()
This.Parent.sel_articulo.txtCodigo.SetFocus()
ENDPROC


************************************************************
OBJETO: btnEliminar
************************************************************
*** PROPIEDADES ***
Top = 41
Left = 885
Height = 37
Width = 36
TabIndex = 18
Name = "btnEliminar"

*** METODOS ***
PROCEDURE Click
LOCAL lnResp

lnResp = MESSAGEBOX("¿Está seguro que desea eliminar este ítem?", 4+32, Thisform.Caption)

IF lnResp = 6 THEN

	&& Si está habilitado el módulo de stock, entonces, elimino el movimiento.
	IF getGlobalCFG("STK_MODULE") THEN
		IF !(RIGHT(ALLTRIM(This.Parent.sel_articulo.txtCodigo.Value), 3) == "ARX") THEN
			SELECT comprasdet 
			Thisform.mov_stock.eliminar(comprasdet.IdArticulo)
		ENDIF
	ENDIF
	
	Thisform.compras.eliminar_articulo()		
	This.Parent.grdDetalle.Refresh()

	Thisform.Contenido.txtTotalNeto.Value = Thisform.compras.totneto
	Thisform.Contenido.txtImpIVA21.Value = Thisform.compras.impiva21
	Thisform.Contenido.txtImpIVA105.Value = Thisform.compras.impiva105
	Thisform.Contenido.txtPercepciones.Value = Thisform.compras.percepciones
	Thisform.Contenido.txtTotalFinal.Value = Thisform.compras.totfinal
	
	This.Parent.sel_articulo.blanquear()
	This.Parent.cmbUnidCpa.Clear()
	This.Parent.txtCantPack.blanquear()
	This.Parent.txtCantidad.blanquear()
	This.Parent.txtPrLista.blanquear()
	This.Parent.txtBonif1.blanquear()
	This.Parent.txtBonif2.blanquear()
	This.Parent.txtBonif3.blanquear()
	This.Parent.txtBonif4.blanquear()
	This.Parent.txtAlicIVA.blanquear()
	This.Parent.txtImpIVA.blanquear()
	This.Parent.txtCostoRep.blanquear()
	This.Parent.txtCostoFinal.blanquear()
	This.Parent.txtSTFinal.blanquear()
	This.Parent.txtSTNeto.blanquear()
	This.Parent.sel_articulo.txtCodigo.SetFocus()
ENDIF
ENDPROC


************************************************************
OBJETO: grdDetalle
************************************************************
*** PROPIEDADES ***
Height = 224
Left = 5
TabIndex = 36
Top = 86
Width = 915
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdDetalle"
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


************************************************************
OBJETO: Clsetiqueta11
************************************************************
*** PROPIEDADES ***
Caption = "Alíc. I.V.A.:"
Height = 15
Left = 6
Top = 60
Width = 62
TabIndex = 37
Name = "Clsetiqueta11"

*** METODOS ***


************************************************************
OBJETO: txtAlicIVA
************************************************************
*** PROPIEDADES ***
Enabled = .T.
Height = 21
Left = 78
ReadOnly = .F.
TabIndex = 38
Top = 56
Width = 87
isnumeric = .T.
Name = "txtAlicIVA"

*** METODOS ***
PROCEDURE calcular
=Thisform.Calcular_item()
ENDPROC


************************************************************
OBJETO: Clsetiqueta12
************************************************************
*** PROPIEDADES ***
Caption = "Importe I.V.A.:"
Height = 15
Left = 169
Top = 60
Width = 80
TabIndex = 39
Name = "Clsetiqueta12"

*** METODOS ***


************************************************************
OBJETO: txtImpIVA
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 260
ReadOnly = .T.
TabIndex = 40
Top = 56
Width = 79
isnumeric = .T.
Name = "txtImpIVA"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta13
************************************************************
*** PROPIEDADES ***
Caption = "Costo Final:"
Height = 15
Left = 343
Top = 60
Width = 67
TabIndex = 43
Name = "Clsetiqueta13"

*** METODOS ***


************************************************************
OBJETO: txtCostoFinal
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 412
ReadOnly = .T.
TabIndex = 46
Top = 56
Width = 88
isnumeric = .T.
Name = "txtCostoFinal"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta21
************************************************************
*** PROPIEDADES ***
Caption = "Subtotal Neto:"
Height = 15
Left = 502
Top = 60
Width = 87
TabIndex = 41
Name = "Clsetiqueta21"

*** METODOS ***


************************************************************
OBJETO: txtSTNeto
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 583
ReadOnly = .T.
TabIndex = 45
Top = 56
Width = 88
isnumeric = .T.
Name = "txtSTNeto"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta22
************************************************************
*** PROPIEDADES ***
Caption = "Subtotal Final:"
Height = 15
Left = 674
Top = 60
Width = 87
TabIndex = 42
Name = "Clsetiqueta22"

*** METODOS ***


************************************************************
OBJETO: txtSTFinal
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 755
ReadOnly = .T.
TabIndex = 44
Top = 56
Width = 88
isnumeric = .T.
Name = "txtSTFinal"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Concepto:"
Height = 15
Left = 15
Top = 17
Width = 72
TabIndex = 10
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: sel_concepto
************************************************************
*** PROPIEDADES ***
Top = 12
Left = 81
TabIndex = 1
nombre_tabla = planctas
pkfield = idPlanCta
nombre_campo_codigo = codPlanCta
nombre_campo_desc = descripcio
criterio_filtro = planctas.esImput = 1
Name = "sel_concepto"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Imp. Neto:"
Height = 15
Left = 16
Top = 41
Width = 64
TabIndex = 11
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Alic. I.V.A.:"
Height = 15
Left = 189
Top = 41
Width = 64
TabIndex = 12
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Total:"
Height = 15
Left = 396
Top = 41
Width = 36
TabIndex = 13
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: txtImpNeto
************************************************************
*** PROPIEDADES ***
Left = 83
TabIndex = 2
Top = 38
isnumeric = .T.
Name = "txtImpNeto"

*** METODOS ***
PROCEDURE LostFocus
DODEFAULT()
Thisform.calcular_item_cp()
ENDPROC


************************************************************
OBJETO: txtImpIVA
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 319
ReadOnly = .T.
TabIndex = 8
Top = 38
Width = 72
isnumeric = .T.
Name = "txtImpIVA"

*** METODOS ***


************************************************************
OBJETO: txtTotal
************************************************************
*** PROPIEDADES ***
Left = 435
ReadOnly = .T.
TabIndex = 9
Top = 38
isnumeric = .T.
Name = "txtTotal"

*** METODOS ***


************************************************************
OBJETO: btnAgregar
************************************************************
*** PROPIEDADES ***
Top = 47
Left = 849
Height = 37
Width = 36
TabIndex = 4
Name = "btnAgregar"

*** METODOS ***
PROCEDURE Click
LOCAL lnIdPlanCta, lnIdBanco, lnIdCheque, lnImpNeto, lnPorIVA
LOCAL lcCodPlanCta, lnResp

IF This.Parent.sel_concepto.valcpoid = 0 THEN
	MESSAGEBOX("Debe ingresar el concepto", 0+48, Thisform.Caption)
	This.Parent.sel_concepto.txtCodigo.SetFocus()
	RETURN
ENDIF

IF This.Parent.txtImpNeto.Value = 0 THEN
	MESSAGEBOX("Debe ingresar el importe", 0+48, Thisform.Caption)
	This.Parent.txtImpNeto.SetFocus()
	RETURN
ENDIF

lnIdPlanCta = This.Parent.sel_concepto.valcpoid
lcCodPlanCta = ALLTRIM(This.Parent.sel_concepto.txtCodigo.Value)
lnIdBanco = 0
lnIdCheque = 0
lnImpNeto = This.Parent.txtImpNeto.Value
lnPorIVA = FLOAT(VAL(This.Parent.cmbAlicIva.Value)) 
lnResp = 0

IF !Thisform.compras.concepto_duplicado(lnIdPlanCta) THEN
	lnResp = MESSAGEBOX(Thisform.compras.error_message, 4+32, Thisform.Caption)
	
	IF lnResp = 7 THEN
		RETURN
	ENDIF
ENDIF

Thisform.compras.agregar_detalle_cp(0, lnIdPlanCta, lcCodPlanCta, ALLTRIM(This.Parent.sel_concepto.txtDescripcion.Value), ;
	lnIdBanco, lnIdCheque, lnImpNeto, lnPorIVA)

Thisform.compras.totalizar_cbte()
Thisform.contenido.txtNoGravado.Value = Thisform.compras.nogravado
Thisform.Contenido.txtTotalNeto.Value = Thisform.compras.totneto
Thisform.Contenido.txtImpIVA21.Value = Thisform.compras.impiva21
Thisform.Contenido.txtImpIVA105.Value = Thisform.compras.impiva105
Thisform.Contenido.txtPercepciones.Value = Thisform.compras.percepciones
Thisform.Contenido.txtTotalFinal.Value = Thisform.compras.totfinal

SELECT cpasdet_cp
This.Parent.grdDetalle.Refresh()

This.Parent.sel_concepto.blanquear()
This.Parent.txtImpNeto.blanquear()
This.Parent.txtImpIVA.blanquear()
This.Parent.txtTotal.blanquear()
This.Parent.sel_concepto.txtCodigo.SetFocus()
ENDPROC


************************************************************
OBJETO: btnEliminar
************************************************************
*** PROPIEDADES ***
Top = 47
Left = 885
Height = 37
Width = 36
TabIndex = 5
Name = "btnEliminar"

*** METODOS ***
PROCEDURE Click
LOCAL lnResp

lnResp = MESSAGEBOX("¿Está seguro que desea eliminar el concepto?", 4+32, Thisform.Caption)
IF lnResp = 6 THEN
	Thisform.compras.eliminar_cp()
	Thisform.compras.totalizar_cbte()
	This.Parent.grdDetalle.Refresh()
	
	Thisform.contenido.txtNoGravado.Value = Thisform.compras.nogravado
	Thisform.Contenido.txtTotalNeto.Value = Thisform.compras.totneto
	Thisform.Contenido.txtImpIVA21.Value = Thisform.compras.impiva21
	Thisform.Contenido.txtImpIVA105.Value = Thisform.compras.impiva105
	Thisform.Contenido.txtPercepciones.Value = Thisform.compras.percepciones
	Thisform.Contenido.txtTotalFinal.Value = Thisform.compras.totfinal
	
	This.Parent.sel_concepto.blanquear()
	This.Parent.txtImpNeto.blanquear()
	This.Parent.txtImpIVA.blanquear()
	This.Parent.txtTotal.blanquear()
	This.Parent.sel_concepto.txtCodigo.SetFocus()	
ENDIF
ENDPROC


************************************************************
OBJETO: grdDetalle
************************************************************
*** PROPIEDADES ***
Height = 207
Left = 5
TabIndex = 7
Top = 90
Width = 915
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdDetalle"
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


************************************************************
OBJETO: cmbAlicIva
************************************************************
*** PROPIEDADES ***
ControlSource = ""
Height = 21
Left = 250
TabIndex = 8
Top = 38
Width = 67
Name = "cmbAlicIva"

*** METODOS ***
PROCEDURE InteractiveChange
Thisform.calcular_item_cp()
ENDPROC
PROCEDURE LostFocus
Thisform.calcular_item_cp()
ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "I.V.A.:"
Height = 15
Left = 14
Top = 14
Width = 84
TabIndex = 6
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Ingresos Brutos:"
Height = 15
Left = 14
Top = 40
Width = 97
TabIndex = 7
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Provincia:"
Height = 15
Left = 231
Top = 41
Width = 60
TabIndex = 8
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Ganancias:"
Height = 15
Left = 14
Top = 65
Width = 97
TabIndex = 9
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "SUSS:"
Height = 15
Left = 14
Top = 90
Width = 97
TabIndex = 10
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: txtIVA
************************************************************
*** PROPIEDADES ***
Left = 120
TabIndex = 1
Top = 11
isnumeric = .T.
Name = "txtIVA"

*** METODOS ***
PROCEDURE calcular
Thisform.compras.retiva = this.Value 

Thisform.compras.totalizar_cbte()
Thisform.contenido.txtNoGravado.Value = Thisform.compras.nogravado
Thisform.Contenido.txtTotalNeto.Value = Thisform.compras.totneto
Thisform.Contenido.txtImpIVA21.Value = Thisform.compras.impiva21
Thisform.Contenido.txtImpIVA105.Value = Thisform.compras.impiva105
Thisform.Contenido.txtPercepciones.Value = Thisform.compras.percepciones
Thisform.Contenido.txtTotalFinal.Value = Thisform.compras.totfinal


ENDPROC


************************************************************
OBJETO: txtIIBB
************************************************************
*** PROPIEDADES ***
Left = 120
TabIndex = 2
Top = 36
isnumeric = .T.
Name = "txtIIBB"

*** METODOS ***


************************************************************
OBJETO: cmbPcias
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 292
TabIndex = 3
Top = 36
Width = 367
Name = "cmbPcias"

*** METODOS ***


************************************************************
OBJETO: txtGanancias
************************************************************
*** PROPIEDADES ***
Left = 120
TabIndex = 5
Top = 61
isnumeric = .T.
Name = "txtGanancias"

*** METODOS ***
PROCEDURE calcular
Thisform.compras.retgan = this.Value 

Thisform.compras.totalizar_cbte()
Thisform.contenido.txtNoGravado.Value = Thisform.compras.nogravado
Thisform.Contenido.txtTotalNeto.Value = Thisform.compras.totneto
Thisform.Contenido.txtImpIVA21.Value = Thisform.compras.impiva21
Thisform.Contenido.txtImpIVA105.Value = Thisform.compras.impiva105
Thisform.Contenido.txtPercepciones.Value = Thisform.compras.percepciones
Thisform.Contenido.txtTotalFinal.Value = Thisform.compras.totfinal


ENDPROC


************************************************************
OBJETO: txtSUSS
************************************************************
*** PROPIEDADES ***
Left = 120
TabIndex = 6
Top = 86
isnumeric = .T.
Name = "txtSUSS"

*** METODOS ***
PROCEDURE calcular
Thisform.compras.retsuss = this.Value 

Thisform.compras.totalizar_cbte()
Thisform.contenido.txtNoGravado.Value = Thisform.compras.nogravado
Thisform.Contenido.txtTotalNeto.Value = Thisform.compras.totneto
Thisform.Contenido.txtImpIVA21.Value = Thisform.compras.impiva21
Thisform.Contenido.txtImpIVA105.Value = Thisform.compras.impiva105
Thisform.Contenido.txtPercepciones.Value = Thisform.compras.percepciones
Thisform.Contenido.txtTotalFinal.Value = Thisform.compras.totfinal

ENDPROC


************************************************************
OBJETO: Clsetiqueta6
************************************************************
*** PROPIEDADES ***
Caption = "Impuestos:"
Height = 15
Left = 14
Top = 149
Width = 97
TabIndex = 10
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: txtImpuestos
************************************************************
*** PROPIEDADES ***
Left = 120
TabIndex = 7
Top = 145
isnumeric = .T.
Name = "txtImpuestos"

*** METODOS ***
PROCEDURE calcular
Thisform.compras.impuestos = this.Value 

Thisform.compras.totalizar_cbte()
Thisform.contenido.txtNoGravado.Value = Thisform.compras.nogravado
Thisform.Contenido.txtTotalNeto.Value = Thisform.compras.totneto
Thisform.Contenido.txtImpIVA21.Value = Thisform.compras.impiva21
Thisform.Contenido.txtImpIVA105.Value = Thisform.compras.impiva105
Thisform.Contenido.txtPercepciones.Value = Thisform.compras.percepciones
Thisform.Contenido.txtImpuestos.Value = Thisform.compras.impuestos
Thisform.Contenido.txtTotalFinal.Value = Thisform.compras.totfinal

ENDPROC


************************************************************
OBJETO: grdIIBB
************************************************************
*** PROPIEDADES ***
Height = 207
Left = 292
RecordMark = .F.
ScrollBars = 0
TabIndex = 20
Top = 61
Width = 367
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdIIBB"
COLUMN1.HEADER1.Name = "HEADER1"
COLUMN1.TEXT1.Name = "TEXT1"
COLUMN1.Name = "COLUMN1"
COLUMN2.HEADER1.Name = "HEADER1"
COLUMN2.TEXT1.Name = "TEXT1"
COLUMN2.Name = "COLUMN2"
COLUMN3.HEADER1.Name = "HEADER1"
COLUMN3.TEXT1.Name = "TEXT1"
COLUMN3.Name = "COLUMN3"
COLUMN4.HEADER1.Name = "HEADER1"
COLUMN4.TEXT1.Name = "TEXT1"
COLUMN4.Name = "COLUMN4"
COLUMN5.HEADER1.Name = "HEADER1"
COLUMN5.TEXT1.Name = "TEXT1"
COLUMN5.Name = "COLUMN5"
COLUMN6.HEADER1.Name = "HEADER1"
COLUMN6.TEXT1.Name = "TEXT1"
COLUMN6.Name = "COLUMN6"
COLUMN7.HEADER1.Name = "HEADER1"
COLUMN7.TEXT1.Name = "TEXT1"
COLUMN7.Name = "COLUMN7"
COLUMN8.HEADER1.Name = "HEADER1"
COLUMN8.TEXT1.Name = "TEXT1"
COLUMN8.Name = "COLUMN8"
COLUMN9.HEADER1.Name = "HEADER1"
COLUMN9.TEXT1.Name = "TEXT1"
COLUMN9.Name = "COLUMN9"
COLUMN10.HEADER1.Name = "HEADER1"
COLUMN10.TEXT1.Name = "TEXT1"
COLUMN10.Name = "COLUMN10"
COLUMN11.HEADER1.Name = "HEADER1"
COLUMN11.TEXT1.Name = "TEXT1"
COLUMN11.Name = "COLUMN11"
COLUMN12.HEADER1.Name = "HEADER1"
COLUMN12.TEXT1.Name = "TEXT1"
COLUMN12.Name = "COLUMN12"
COLUMN13.HEADER1.Name = "HEADER1"
COLUMN13.TEXT1.Name = "TEXT1"
COLUMN13.Name = "COLUMN13"
COLUMN14.HEADER1.Name = "HEADER1"
COLUMN14.TEXT1.Name = "TEXT1"
COLUMN14.Name = "COLUMN14"
COLUMN15.HEADER1.Name = "HEADER1"
COLUMN15.TEXT1.Name = "TEXT1"
COLUMN15.Name = "COLUMN15"
COLUMN16.HEADER1.Name = "HEADER1"
COLUMN16.TEXT1.Name = "TEXT1"
COLUMN16.Name = "COLUMN16"
COLUMN17.HEADER1.Name = "HEADER1"
COLUMN17.TEXT1.Name = "TEXT1"
COLUMN17.Name = "COLUMN17"
COLUMN18.HEADER1.Name = "HEADER1"
COLUMN18.TEXT1.Name = "TEXT1"
COLUMN18.Name = "COLUMN18"
COLUMN19.HEADER1.Name = "HEADER1"
COLUMN19.TEXT1.Name = "TEXT1"
COLUMN19.Name = "COLUMN19"
COLUMN20.HEADER1.Name = "HEADER1"
COLUMN20.TEXT1.Name = "TEXT1"
COLUMN20.Name = "COLUMN20"

*** METODOS ***


************************************************************
OBJETO: CLSAGREGAR1
************************************************************
*** PROPIEDADES ***
Top = 20
Left = 665
Height = 37
Width = 36
TabIndex = 4
Name = "CLSAGREGAR1"

*** METODOS ***
PROCEDURE Click
LOCAL lnIdProvin, lcDescripcio, lnImporte, lnResp

IF This.Parent.txtIIBB.Value = 0 THEN
	MESSAGEBOX("Debe ingresar el importe", 0+48, Thisform.Caption)
	This.Parent.txtIIBB.SetFocus()
	RETURN
ENDIF

SELECT pcias
lnIdProvin = INT(VAL(This.Parent.cmbPcias.Value))
lcDescripcio = ALLTRIM(This.Parent.cmbPcias.DisplayValue)
lnImporte = This.Parent.txtIIBB.Value 
lnResp = 0

*!*	IF !Thisform.compras.concepto_duplicado(lnIdPlanCta) THEN
*!*		lnResp = MESSAGEBOX(Thisform.compras.error_message, 4+32, Thisform.Caption)
*!*		
*!*		IF lnResp = 7 THEN
*!*			RETURN
*!*		ENDIF
*!*	ENDIF

Thisform.compras.agregar_detalle_ret('RIB', lnIdProvin, lcDescripcio, lnImporte)

Thisform.compras.retiibb = Thisform.compras.retiibb + this.Parent.txtIIBB.Value 

Thisform.compras.totalizar_cbte()
Thisform.contenido.txtNoGravado.Value = Thisform.compras.nogravado
Thisform.Contenido.txtTotalNeto.Value = Thisform.compras.totneto
Thisform.Contenido.txtImpIVA21.Value = Thisform.compras.impiva21
Thisform.Contenido.txtImpIVA105.Value = Thisform.compras.impiva105
Thisform.Contenido.txtPercepciones.Value = Thisform.compras.percepciones
Thisform.Contenido.txtTotalFinal.Value = Thisform.compras.totfinal

This.Parent.grdIIBB.Refresh()

This.Parent.txtIIBB.blanquear()
This.Parent.txtIIBB.SetFocus()
ENDPROC


************************************************************
OBJETO: CLSDELETE1
************************************************************
*** PROPIEDADES ***
Top = 20
Left = 703
Height = 37
Width = 36
Name = "CLSDELETE1"

*** METODOS ***
PROCEDURE Click
LOCAL lnResp

lnResp = MESSAGEBOX("¿Está seguro que desea eliminar el ingreso bruto de esta provincia?", 4+32, Thisform.Caption)
IF lnResp = 6 THEN
	Thisform.compras.eliminar_ret()
	Thisform.compras.retiibb = Thisform.compras.retiibb - comprasret.importe
	Thisform.compras.totalizar_cbte()
	
	Thisform.contenido.txtNoGravado.Value = Thisform.compras.nogravado
	Thisform.Contenido.txtTotalNeto.Value = Thisform.compras.totneto
	Thisform.Contenido.txtImpIVA21.Value = Thisform.compras.impiva21
	Thisform.Contenido.txtImpIVA105.Value = Thisform.compras.impiva105
	Thisform.Contenido.txtPercepciones.Value = Thisform.compras.percepciones
	Thisform.Contenido.txtTotalFinal.Value = Thisform.compras.totfinal
	
	This.Parent.grdIIBB.Refresh()

	This.Parent.txtIIBB.blanquear()
	This.Parent.txtIIBB.SetFocus()
ENDIF
ENDPROC


************************************************************
OBJETO: btnSelCbteOrig
************************************************************
*** PROPIEDADES ***
Top = 75
Left = 435
Height = 31
Width = 212
Caption = "\<Seleccionar comprobante de Origen"
TabIndex = 10
Name = "btnSelCbteOrig"

*** METODOS ***
PROCEDURE Click
LOCAL loForm, lnResp

lnResp = 0

loForm = CREATEOBJECT("cls_buscacbte_cpas")
loForm.idProv = Thisform.contenido.sel_proveedor.valcpoid
loForm.cbte = "FC"
loForm.leer_cbtes()

loForm.Show()

IF loForm.press_ok THEN
	Thisform.Contenido.txtCbteOrig.Value = loForm.sel_cbte
	Thisform.Contenido.txtLetraOrig.Value = loForm.sel_letra
	Thisform.Contenido.txtPtoVtaOrig.Value = loForm.sel_ptovta
	Thisform.Contenido.txtNumeroOrig.Value = loForm.sel_numCbte
	Thisform.idComprac_orig = loForm.idCompraC
	Thisform.idOper = loForm.idOper
	
	loForm.Release()
ELSE
	loForm.Release()
ENDIF

ENDPROC


************************************************************
OBJETO: txtCbteOrig
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 702
ReadOnly = .T.
TabIndex = 20
Top = 77
Width = 36
ischaracter = .T.
Name = "txtCbteOrig"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Origen:"
Height = 15
Left = 653
Top = 80
Width = 48
TabIndex = 18
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: txtLetraOrig
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 740
ReadOnly = .T.
TabIndex = 23
Top = 77
Width = 36
ischaracter = .T.
Name = "txtLetraOrig"

*** METODOS ***


************************************************************
OBJETO: txtPtoVtaOrig
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 778
ReadOnly = .T.
TabIndex = 24
Top = 77
Width = 58
ischaracter = .T.
Name = "txtPtoVtaOrig"

*** METODOS ***


************************************************************
OBJETO: txtNumeroOrig
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 838
ReadOnly = .T.
TabIndex = 27
Top = 77
Width = 103
ischaracter = .T.
Name = "txtNumeroOrig"

*** METODOS ***


************************************************************
OBJETO: Clsaceptar1
************************************************************
*** PROPIEDADES ***
Top = 8
Left = 896
TabIndex = 11
Name = "Clsaceptar1"

*** METODOS ***
PROCEDURE Click
LOCAL lnResp, loForm

lnResp = 0

IF !Thisform.validarcampos() THEN
	RETURN
ENDIF

IF !Thisform.validar_comprobante() THEN
	Thisform.Contenido.txtPtoVta.SetFocus()
	RETURN
ENDIF

Thisform.Contenido.Page_group.page1.sel_Articulo.txtCodigo.SetFocus()
Thisform.Cambiar_estado(.F.)

ENDPROC


************************************************************
OBJETO: Clsetiqueta6
************************************************************
*** PROPIEDADES ***
Caption = "No Gravado"
Height = 15
Left = 12
Top = 454
Width = 84
TabIndex = 32
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: txtNoGravado
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 11
ReadOnly = .T.
TabIndex = 34
Top = 469
Width = 85
isnumeric = .T.
Name = "txtNoGravado"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta7
************************************************************
*** PROPIEDADES ***
Caption = "Impuestos"
Height = 15
Left = 467
Top = 454
Width = 81
TabIndex = 41
Name = "Clsetiqueta7"

*** METODOS ***


************************************************************
OBJETO: txtImpuestos
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 466
ReadOnly = .T.
TabIndex = 43
Top = 469
Width = 85
isnumeric = .T.
Name = "txtImpuestos"

*** METODOS ***


************************************************************
OBJETO: btnAgregarProveedor
************************************************************
*** PROPIEDADES ***
Top = 30
Left = 580
Height = 23
Width = 22
Picture = ..\imagen\iconos_chicos\add_3.jpg
TabIndex = 6
ToolTipText = "Dar de alta un proveedor"
Name = "btnAgregarProveedor"

*** METODOS ***
PROCEDURE Click
LOCAL loForm

loForm = CREATEOBJECT("cls_alta_prov")
loForm.Show()
IF loForm.accept_press THEN
	This.Parent.sel_proveedor.txtCodigo.Value = loForm.idprov
	This.Parent.sel_proveedor.txtCodigo.LostFocus()
	This.Parent.txtFecEmision.SetFocus()
ENDIF
RELEASE loForm

ENDPROC


************************************************************
OBJETO: cls_frmcbtes_cpas
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_alta_prov
************************************************************
*** PROPIEDADES ***
BorderStyle = 2
Height = 298
Width = 611
DoCreate = .T.
Caption = "Ingresar nuevo proveedor"
Closable = .F.
accept_press = .F.
idlocalid = 0
idcondpago = 0
idsitiva = 0
idprov = 0
razsoc = 
Name = "cls_alta_prov"

*** METODOS ***
PROCEDURE validar_datos
IF ALLTRIM(Thisform.txtRazSoc.Value) == "" THEN
	MESSAGEBOX("Debe ingresar la razón social", 0+48, Thisform.Caption)
	Thisform.txtRazSoc.SetFocus()
	RETURN .F.
ENDIF

IF ALLTRIM(Thisform.txtNroCuit.Value) == "" THEN
	MESSAGEBOX("Debe ingresar el número de CUIT", 0+48, Thisform.Caption)
	Thisform.txtNroCuit.SetFocus()
	RETURN .F.
ENDIF
**
IF ALLTRIM(Thisform.sel_Localid.txtCodigo.Value) == "" THEN
	MESSAGEBOX("Debe ingresar el código postal", 0+48, Thisform.Caption)
	Thisform.txtRazSoc.SetFocus()
	RETURN .F.
ENDIF

IF Thisform.sel_SitIVA.txtCodigo.value == 0 THEN
	MESSAGEBOX("Debe ingresar la situación de IVA", 0+48, Thisform.Caption)
	Thisform.txtRazSoc.SetFocus()
	RETURN .F.
ENDIF

IF Thisform.sel_CondPago.txtCodigo.value == 0 THEN
	MESSAGEBOX("Debe ingresar la condición de pago", 0+48, Thisform.Caption)
	Thisform.txtRazSoc.SetFocus()
	RETURN .F.
ENDIF

IF !This.validar_cuit() THEN
	MESSAGEBOX("La CUIT ingresada ya se encuentra cargada, busque el proveedor y seleccionelo", 0+48, Thisform.Caption)
	Thisform.txtNroCuit.SetFocus()
	RETURN .F.
ENDIF

RETURN .T.
ENDPROC
PROCEDURE grabar
LOCAL loRes
LOCAL lcSql

loRes = CREATEOBJECT("odbc_result")
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_temp"
lcSql = "CALL proveedor_insert ( " + ;
	"?_razSoc, ?_nomFant, ?_direccion, ?_idLocalid, ?_idCondPago, ?_idSitIVA, " + ;
	"?_nroCUIT, ?_telefono, ?_fax, ?_eMail, ?_pagWeb, ?_observ, ?_contacto, "  + ;
	"?_habilitado, ?_tMon, ?_cotizac, ?_idTransp, ?_usuAlta, current_timestamp, " + ;
	"?_idHostAlta, ?_proc_name, ?_idTipoDoc) "
lcSql = loRes.AddParameter(lcSql, "_razSoc", ALLTRIM(thisform.txtRazSoc.Value), .t., .f.)
lcSql = loRes.AddParameter(lcSql, "_nomFant", "", .t., .f.)
lcSql = loRes.AddParameter(lcSql, "_direccion", ALLTRIM(Thisform.txtDireccion.Value), .t., .f.)
lcSql = loRes.AddParameter(lcSql, "_idLocalid", ALLTRIM(STR(Thisform.idlocalid)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "_idCondPago", ALLTRIM(STR(Thisform.idcondpago)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "_idSitIVA", ALLTRIM(STR(Thisform.idsitiva)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "_nroCUIT", ALLTRIM(Thisform.txtNroCuit.Value), .t., .f.)
lcSql = loRes.AddParameter(lcSql, "_telefono", ALLTRIM(Thisform.txtTelefono.Value), .t., .f.)
lcSql = loRes.AddParameter(lcSql, "_fax", "", .t., .f.)
lcSql = loRes.AddParameter(lcSql, "_eMail", "", .t., .f.)
lcSql = loRes.AddParameter(lcSql, "_pagWeb", "", .t., .f.)
lcSql = loRes.AddParameter(lcSql, "_observ", "", .t., .f.)
lcSql = loRes.AddParameter(lcSql, "_contacto", "", .t., .f.)
lcSql = loRes.AddParameter(lcSql, "_habilitado", "1", .f., .f.)
lcSql = loRes.AddParameter(lcSql, "_tMon", "PSO", .t., .f.)
lcSql = loRes.AddParameter(lcSql, "_cotizac", "0", .f., .f.)
lcSql = loRes.AddParameter(lcSql, "_idTransp", ALLTRIM(STR(getGlobalCFG("TRANSP_DEF"))), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "_usuAlta", ALLTRIM(gcCodUsu), .t., .f.)
lcSql = loRes.AddParameter(lcSql, "_idHostAlta", ALLTRIM(SYS(0)), .t., .f.)
lcSql = loRes.AddParameter(lcSql, "_proc_name", "", .t., .f.)
lcSql = loRes.AddParameter(lcSql, "_idTipoDoc", "1", .f., .f.)
loRes.OpenQuery(lcSql)
SELECT cur_temp
this.idprov = cur_temp.idprov
this.razsoc = ALLTRIM(this.txtRazSoc.Value)
USE IN cur_temp
ENDPROC
PROCEDURE validar_cuit
LOCAL loRes
LOCAL llOk
LOCAL lcSql

loRes = CREATEOBJECT("odbc_result")
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_tmp"
lcSql = "CALL proveedor_getByCuit(?_nroCUIT)"
lcSql = loRes.AddParameter(lcSql, "_nroCUIT", ALLTRIM(Thisform.txtNroCuit.Value), .t., .f.)
loRes.OpenQuery(lcSql)
SELECT cur_tmp
IF RECCOUNT("cur_tmp") > 0 THEN
	llOK = .f.
ELSE
	llOk = .t.
ENDIF
loRes.Close_Query()
RETURN llOk
ENDPROC


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Razón Social:"
Left = 24
Top = 47
TabIndex = 13
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Dirección:"
Left = 24
Top = 71
TabIndex = 14
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta6
************************************************************
*** PROPIEDADES ***
Caption = "Código Postal:"
Left = 24
Top = 95
TabIndex = 15
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta7
************************************************************
*** PROPIEDADES ***
Caption = "Provincia:"
Height = 15
Left = 24
Top = 117
Width = 58
TabIndex = 16
Name = "Clsetiqueta7"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta8
************************************************************
*** PROPIEDADES ***
Caption = "Teléfono:"
Left = 24
Top = 141
TabIndex = 17
Name = "Clsetiqueta8"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta11
************************************************************
*** PROPIEDADES ***
Caption = "Cond. de Pago:"
Left = 24
Top = 191
TabIndex = 18
Name = "Clsetiqueta11"

*** METODOS ***


************************************************************
OBJETO: sel_SitIVA
************************************************************
*** PROPIEDADES ***
Top = 160
Left = 118
TabIndex = 8
cfieldname = idsitiva
msgerror = Debe ingresar la Situación de I.V.A.
nombre_campo_codigo = idsitiva
nombre_campo_desc = descripcio
nombre_tabla = sitiva
pkfield = idsitiva
esnumerico = .T.
Name = "sel_SitIVA"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***
PROCEDURE recuperar_datos
thisform.idsitiva = sitiva.idSitIVA
ENDPROC


************************************************************
OBJETO: Clsetiqueta14
************************************************************
*** PROPIEDADES ***
Caption = "Situación I.V.A.:"
Left = 23
Top = 167
TabIndex = 19
Name = "Clsetiqueta14"

*** METODOS ***


************************************************************
OBJETO: txtRazSoc
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 120
TabIndex = 3
Top = 43
Width = 478
cfieldname = razsoc
msgerror = Debe ingresar la Razón Social
ischaracter = .T.
Name = "txtRazSoc"

*** METODOS ***


************************************************************
OBJETO: txtDireccion
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 120
TabIndex = 4
Top = 67
Width = 478
cfieldname = direccion
ischaracter = .T.
msgerror = Debe ingresar la Dirección
Name = "txtDireccion"

*** METODOS ***


************************************************************
OBJETO: txtTelefono
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 120
TabIndex = 7
Top = 137
Width = 478
cfieldname = telefono
ischaracter = .T.
msgerror = Debe ingresar el Teléfono
requerido = .F.
Name = "txtTelefono"

*** METODOS ***


************************************************************
OBJETO: sel_CondPago
************************************************************
*** PROPIEDADES ***
Top = 184
Left = 118
Width = 482
Height = 25
TabIndex = 9
cfieldname = idcondpago
msgerror = Debe ingresar la Condición de Pago
nombre_campo_codigo = idcondpago
nombre_campo_desc = descripcio
nombre_tabla = condpagos
pkfield = idcondpago
requerido = .T.
esnumerico = .T.
Name = "sel_CondPago"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***
PROCEDURE recuperar_datos
thisform.idcondpago = condpagos.idCondPago
ENDPROC


************************************************************
OBJETO: txtNroCuit
************************************************************
*** PROPIEDADES ***
Height = 21
InputMask = ""
Left = 120
MaxLength = 0
TabIndex = 1
Top = 18
Width = 139
cfieldname = nrocuit
ischaracter = .T.
msgerror = Debe ingresar el número de C.U.I.T.
Name = "txtNroCuit"

*** METODOS ***


************************************************************
OBJETO: Sel_Localid
************************************************************
*** PROPIEDADES ***
Top = 88
Left = 118
TabIndex = 5
cfieldname = idLocalid
msgerror = Debe ingresar el Código Postal
nombre_campo_codigo = codpostal
nombre_campo_desc = descripcio
nombre_tabla = localidad
pkfield = idlocalid
esnumerico = .F.
Name = "Sel_Localid"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***
PROCEDURE recuperar_datos
LOCAL lcSql, loPcia

SELECT localidad
thisform.idlocalid = localidad.idLocalid
loPcia = CREATEOBJECT("odbc_Result")
loPcia.ActiveConnection = goConn.ActiveConnection
loPcia.cursor_name = "cur_pcia"
lcSql = "CALL provincias_getById(?_id)"
lcSql = loPcia.AddParameter(lcSql, "_id", ALLTRIM(STR(localidad.idprovin)), .f., .f.)
loPcia.OpenQuery(lcSql)
SELECT cur_pcia
IF RECCOUNT() > 0 THEN
	thisform.txtProvincia.Value = ALLTRIM(cur_pcia.descripcio)
ENDIF
loPcia.Close_Query()
ENDPROC


************************************************************
OBJETO: txtProvincia
************************************************************
*** PROPIEDADES ***
Tag = "noedit"
Height = 21
Left = 120
ReadOnly = .T.
TabIndex = 6
Top = 113
Width = 478
cfieldname = 
ischaracter = .T.
msgerror = 
requerido = .F.
Name = "txtProvincia"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Nro. C.U.I.T.:"
Left = 24
Top = 23
TabIndex = 12
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: btnGrabar
************************************************************
*** PROPIEDADES ***
Top = 239
Left = 253
TabIndex = 10
Name = "btnGrabar"

*** METODOS ***
PROCEDURE Click
IF thisform.validar_datos() THEN
	thisform.grabar()
	thisform.accept_press = .t.
	thisform.Hide()
ENDIF
ENDPROC


************************************************************
OBJETO: btnCancelar
************************************************************
*** PROPIEDADES ***
Top = 239
Left = 300
TabIndex = 11
Name = "btnCancelar"

*** METODOS ***
PROCEDURE Click
thisform.accept_press = .f.
thisform.Hide()
ENDPROC


************************************************************
OBJETO: btnConsCUIT
************************************************************
*** PROPIEDADES ***
Top = 17
Left = 261
Height = 23
Width = 104
Caption = "Buscar en AFIP"
TabIndex = 2
Visible = .F.
Name = "btnConsCUIT"

*** METODOS ***
PROCEDURE Click
LOCAL loPersonaService
loPersonaService = CREATEOBJECT("PadronA5Library.PersonasA5Class")
loPersonaService.TicketFileName = STRTRAN(ALLTRIM(getGlobalCFG("FE_TICKACC")), ".txt", "_") + "padron.txt"
loPersonaService.Certificado = SYS(5) + SYS(2003) + "\wsafip\" + getGlobalCFG("FE_FILE")
loPersonaService.Clave = ALLTRIM(getGlobalCFG("FE_PWD"))
loPersonaService.GetPersona(INT(VAL(getGlobalCFG("FECUIT"))), INT(VAL(ALLTRIM(thisform.pgf.page2.cnt_fields.txtNroCuit.Value))))
Thisform.txtRazSoc.Value = loPersonaService.ObtenerRazonSocial()
Thisform.txtDireccion.Value = loPersonaService.Direccion
Thisform.sel_Localid.txtCodigo.Value = loPersonaService.CodigoPostal
Thisform.sel_Localid.txtCodigo.LostFocus()
Thisform.sel_SitIVA.txtCodigo.Value = loPersonaService.ObtenerSitIVA()
Thisform.pgf.page2.cnt_fields.sel_SitIVA.txtCodigo.LostFocus()
RELEASE loPersonaService
ENDPROC


************************************************************
OBJETO: cls_alta_prov
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_orden_pago_cons_detalles
************************************************************
*** PROPIEDADES ***
Height = 547
Width = 1029
DoCreate = .T.
BorderStyle = 2
Caption = "Detalle de orden de pago"
id_orden_pago_c = 0
id_prov = 0
fecha_emision = {}
razon_social = 
importe = 0.00
nro_op = 
Name = "cls_orden_pago_cons_detalles"

*** METODOS ***
PROCEDURE imprimir
***********************************************************************
* Envía a imprimir una nueva orden de pago.
* Fecha: 17/08/2023
***********************************************************************
LOCAL m.numOP, m.Fecha, m.RazSoc, m.Telefono, m.direccion, m.localidad, m.codPostal, m.pcia, m.TipoIVA, m.nroCUIT, m.condpago
LOCAL m.cuenta, m.efvo, m.retiva, m.retiibb, m.retgan, m.retsuss, m.provin, m.Total
LOCAL lcSql, loRes, lcSaltoLinea, m.detcheq, m.detcheq2, m.detcheq3, m.detcheqp, m.detcheqp2, m.detcheqp3, m.detdepo, m.detdepo2, m.detdepo3
LOCAL m.detcbte, m.detcbte2
LOCAL m.dto_financiero_desc
LOCAL m.dto_financiero_imp
LOCAL m.dto_especiales_desc
LOCAL m.dto_especiales_imp
LOCAL lnIdProveedor
LOCAL lcFileName
LOCAL lnResp

&& Datos de empresa
LOCAL lcEMPRAZSOC, lcEMPCUIT, lcEMPDIREC, lcEMPLOC, lcEMPPCIA, lnEMPCUIT

lcSql = ""
loRes = CREATEOBJECT("odbc_result")
lcSaltoLinea = CHR(13) + CHR(10)
lcFileName = ""

Thisform.o_orden_pago.idprov = Thisform.id_prov
Thisform.o_orden_pago.get_datos_proveedor_byid()
Thisform.o_orden_pago.get_importes_reimpresion_byopid(thisform.id_orden_pago_c)

SELECT cur_op
m.numop = cur_op.nroOP
m.Fecha = cur_op.fecEmis

SELECT cur_prov
m.RazSoc = cur_prov.razsoc
m.Telefono = cur_prov.telefono
m.direccion = cur_prov.direccion
m.localidad = cur_prov.loc
m.codPostal = ALLTRIM(cur_prov.codPostal)
m.pcia = cur_prov.provincia
m.TipoIVA = cur_prov.sitiva
m.nroCUIT = cur_prov.nrocuit
m.condpago = cur_prov.condpago

SELECT cur_importes
SELECT * FROM cur_importes WHERE tipoPago == 'EFVO' INTO CURSOR cur_temp

m.cuenta = IIF(cur_temp.importe = 0, "", cur_temp.cuenta)
m.efvo = IIF(cur_temp.importe = 0, "", cur_temp.importe)
USE IN cur_temp

m.retiva = IIF(Thisform.cnt_totales.txtRetencionIVA.Value = 0, "", Thisform.cnt_totales.txtRetencionIVA.Value)
m.retiibb = IIF(Thisform.cnt_totales.txtRetencionIIBB.Value = 0, "", Thisform.cnt_totales.txtRetencionIIBB.Value)

* En este caso tengo que traer la provincia
SELECT * FROM cur_importes WHERE tipoPago = 'RIB' INTO CURSOR cur_temp
m.provin = IIF(cur_temp.importe = 0,"", cur_temp.provincia)
USE IN cur_temp

m.retgan = IIF(Thisform.cnt_totales.txtRetencionGanancia.Value = 0, "", Thisform.cnt_totales.txtRetencionGanancia.Value)
m.retsuss = IIF(Thisform.cnt_totales.txtRetencionSUSS.Value = 0, "", Thisform.cnt_totales.txtRetencionSUSS.Value)

m.Total = Thisform.cnt_totales.txt_total_op.Value


*****************************************************************************************************************************************************
&& Armo el detalle de los comprobantes
m.detcbte = ""
m.detcbte2 = ""

SELECT comprob 
GO TOP

DO WHILE !EOF("comprob")
	IF comprob.sel THEN 
		m.detcbte = m.detcbte + IIF(comprob.fecEmis = {} .OR. ISNULL(comprob.fecEmis), SPACE(10), ALLTRIM(DTOC(comprob.fecEmis))) + SPACE(20)
		m.detcbte = m.detcbte + IIF(comprob.fecVto = {} .OR. ISNULL(comprob.fecVto), SPACE(10), ALLTRIM(DTOC(comprob.fecVto))) + SPACE(20)	
		m.detcbte = m.detcbte + IIF(ALLTRIM(comprob.cbte) == "", SPACE(2), ALLTRIM(comprob.cbte)) + SPACE(15)
		m.detcbte = m.detcbte + IIF(ALLTRIM(comprob.tipodoc) == "", SPACE(2), ALLTRIM(comprob.tipodoc)) + SPACE(15)	
		m.detcbte = m.detcbte + IIF(ALLTRIM(comprob.nroFC) == "", SPACE(8), ALLTRIM(comprob.nroFC)) + lcSaltoLinea
		
		m.detcbte2 = m.detcbte2 + ALLTRIM(STR(comprob.imppag, 10, 2)) + lcSaltoLinea

	ENDIF 

	SELECT comprob 
	SKIP
ENDDO

SELECT comprob 
GO TOP
*****************************************************************************************************************************************************
&& Armo el detalle de los cheques
m.detcheq = ""
m.detcheq2 = ""
m.detcheq3 = ""

SELECT cheq_disp
GO TOP

DO WHILE !EOF("cheq_disp")
	IF cheq_disp.sel THEN 
		m.detcheq = m.detcheq + SUBSTR(ALLTRIM(cheq_disp.descripcio), 1, 60) + lcSaltoLinea		

		m.detcheq2 = m.detcheq2  + IIF(ALLTRIM(cheq_disp.chq_nro) == "", SPACE(20), ALLTRIM(cheq_disp.chq_nro)) + SPACE(14)
		
		m.detcheq2 = m.detcheq2 + IIF(cheq_disp.fecEmis = {} .OR. ISNULL(cheq_disp.fecEmis), SPACE(10), ALLTRIM(DTOC(cheq_disp.fecEmis))) + SPACE(13)
		m.detcheq2 = m.detcheq2 + IIF(cheq_disp.fecVto = {} .OR. ISNULL(cheq_disp.fecVto), SPACE(10), ALLTRIM(DTOC(cheq_disp.fecVto))) + lcSaltoLinea		

		m.detcheq3 = m.detcheq3 + ALLTRIM(STR(cheq_disp.importe, 10, 2)) + lcSaltoLinea
	ENDIF 
	SELECT cheq_disp
	SKIP
ENDDO

SELECT cheq_disp
GO TOP
*****************************************************************************************************************************************************
&& Armo el detalle de los cheques propios
m.detcheqp = ""
m.detcheqp2 = ""
m.detcheqp3 = ""

SELECT chequesp
GO TOP

DO WHILE !EOF("chequesp")
	m.detcheqp = m.detcheqp + SUBSTR(ALLTRIM(chequesp.descripcio), 1, 60) + lcSaltoLinea		

	m.detcheqp2 = m.detcheqp2 + IIF(ALLTRIM(chequesp.nroCheque) == "", SPACE(8), ALLTRIM(chequesp.nroCheque)) + SPACE(25)
	
	m.detcheqp2 = m.detcheqp2 + IIF(chequesp.fecEmis = {} .OR. ISNULL(chequesp.fecEmis), SPACE(10), ALLTRIM(DTOC(chequesp.fecEmis))) + SPACE(20)
	m.detcheqp2 = m.detcheqp2 + IIF(chequesp.fecVto = {} .OR. ISNULL(chequesp.fecVto), SPACE(10), ALLTRIM(DTOC(chequesp.fecVto))) + lcSaltoLinea		
		
	m.detcheqp3 = m.detcheqp3 + ALLTRIM(STR(chequesp.importe, 10, 2)) + lcSaltoLinea

	SELECT chequesp
	SKIP
ENDDO

SELECT chequesp
GO TOP
*****************************************************************************************************************************************************
&& Armo el detalle de los cheques propios
m.detdepo = ""
m.detdepo2 = ""
m.detdepo3 = ""

SELECT deposito
GO TOP

DO WHILE !EOF("deposito")
	m.detdepo = m.detdepo + SUBSTR(ALLTRIM(deposito.nomBco), 1, 60) + lcSaltoLinea		

	m.detdepo2 = m.detdepo2 + IIF(ALLTRIM(deposito.nroTrans) == "", SPACE(8), ALLTRIM(deposito.nroTrans)) + SPACE(25)

	m.detdepo2 = m.detdepo2 + IIF(deposito.fecTrans = {} .OR. ISNULL(deposito.fecTrans), SPACE(10), ALLTRIM(DTOC(deposito.fecTrans))) + SPACE(20)
		
	m.detdepo3 = m.detdepo3 + ALLTRIM(STR(deposito.importe, 10, 2)) + lcSaltoLinea

	SELECT deposito
	SKIP
ENDDO

SELECT deposito
GO TOP
*****************************************************************************************************************************************************

&& Armo los descuentos comerciales.
SELECT * FROM cur_importes WHERE tipoPago = 'DPP' INTO CURSOR cur_temp
IF cur_temp.importe <> 0 THEN
	m.dto_financiero_desc = "DESCUENTO FINANCIERO"
	m.dto_financiero_imp = cur_temp.importe
ELSE
	m.dto_financiero_desc = "DESCUENTO FINANCIERO"
	m.dto_financiero_imp = 0.00
ENDIF
USE IN cur_temp


SELECT * FROM cur_importes WHERE tipoPago = 'DSCEO' INTO CURSOR cur_temp
IF cur_temp.importe <> 0 THEN
	m.dto_especiales_desc = "DESCUENTO ESPECIAL"
	m.dto_especiales_imp = cur_temp.importe
ELSE
	m.dto_especiales_desc = "DESCUENTO ESPECIAL"
	m.dto_especiales_imp = 0.00
ENDIF
USE IN cur_temp

* Pregunto si quieren generar el pdf en el compartido.
lnResp = MESSAGEBOX("Â¿Desea generar la orden de pago en PDF?", 4+32, This.Caption)
IF lnResp = 6 THEN
	* Si el usuario dice que si, seteo la impresora bullziprinter.
	IF DIRECTORY(GetGlobalCfg("FACPDFPATH")) THEN
		* Si el directorio existe entonces genero el PDF
		lcFileName = ALLTRIM(GetGlobalCfg("FACPDFPATH")) + "OP_" + ALLTRIM(m.numOP) + "_Proveedor_" + ALLTRIM(STR(Thisform.id_prov)) + ".pdf"

		loPDF = CREATEOBJECT("Bullzip.PDFPrinterSettings")
		loPDF.SetValue('output', lcFileName)
		loPDF.SetValue('DisableOptionDialog', 'no') 
		loPDF.SetValue('ConfirmOverwrite', 'no')
		loPDF.SetValue('Showsettings', 'never') 
		loPDF.SetValue('ShowSaveAS', 'nofile') 
		loPDF.SetValue('ShowPdf', 'no') 
		loPDF.WriteSettings(.t.)
		
		* Asigno datos de empresa
		lcEMPRAZSOC = GetGlobalCfg("EMPRAZSOC")
		lcEMPCUIT = GetGlobalCfg("EMPCUIT")
		lcEMPDIREC = GetGlobalCfg("EMPDIREC")
		lcEMPLOC = GetGlobalCfg("EMPLOC")

		SET PRINTER TO NAME("Bullzip PDF Printer") NOCONSOLE
		SELECT cur_prov
		REPORT FORM repop NOCONSOLE TO PRINTER
		SET PRINTER TO DEFAULT
		SET CONSOLE ON
		
		DO WHILE !FILE(lcFileName)
			WAIT WINDOW "El archivo PDF se está generando, aguarde unos segundos..." NOWAIT	
		ENDDO
	ELSE
		MESSAGEBOX("No se puede acceder a la carpeta: " + ALLTRIM(GetGlobalCfg("FACPDFPATH")), 0+48, Thisform.Caption)
	ENDIF
ELSE
	SELECT cur_prov
	REPORT FORM repop TO PRINTER PROMPT PREVIEW
ENDIF




ENDPROC
PROCEDURE recuperar_datos
*********************************************************************
* Recupera la información de la orden de pago.
* Fecha: 10/08/2023
*********************************************************************
Thisform.o_orden_pago.get_orden_pago_byid(Thisform.id_orden_pago_c)

Thisform.txtCodProv.Value = Thisform.id_prov
Thisform.txtRazSoc.Value = Thisform.razon_social
Thisform.txtFecEmision.Value = Thisform.fecha_emision
Thisform.txtNroOP.Value = Thisform.nro_op
Thisform.cnt_totales.txt_total_op.Value = Thisform.importe

SELECT comprob
Thisform.grd_cbtes.Refresh()
SELECT deposito
Thisform.pgf.page1.grd_depositos.Refresh()
SELECT cheq_disp
Thisform.pgf.page2.grd_cheques_t.Refresh()
SELECT chequesp
Thisform.pgf.page3.grd_cheques_p.Refresh()

Thisform.txt_efectivo.Value = Thisform.o_orden_pago.get_suma_efvo_byopid(Thisform.id_orden_pago_c)

Thisform.cnt_totales.txtRetencionGanancia.Value = Thisform.o_orden_pago.get_retencion_ganancia_byopid(thisform.id_orden_pago_c)
Thisform.cnt_totales.txtRetencionIIBB.Value = Thisform.o_orden_pago.get_retencion_iibb_byopid(thisform.id_orden_pago_c)
Thisform.cnt_totales.txtRetencionIVA.Value = Thisform.o_orden_pago.get_retension_iva_byopid(thisform.id_orden_pago_c)
Thisform.cnt_totales.txtRetencionSUSS.Value = Thisform.o_orden_pago.get_rsuss_by_opid(thisform.id_orden_pago_c)
ENDPROC
PROCEDURE inicializar_formulario
*********************************************************************
* Inicializa los controles del formulario
*********************************************************************

Thisform.o_orden_pago.crear_cursor()
Thisform.o_orden_pago.crear_cursores_consultas()

* Configuración del datagrid de comprobantes aplicados
SELECT comprob
Thisform.grd_cbtes.alias_name = "comprob"
Thisform.grd_cbtes.RecordSource = "comprob"
THisform.grd_cbtes.list_controlsource = "fecEmis,cbte,tipoDoc,nroFC,imppag"
Thisform.grd_cbtes.lista_ancho_cols = "100,100,70,200,100"
Thisform.grd_cbtes.titulos_cabeceras = "Fecha,Comrpob.,Letra,Número,Aplicado"
Thisform.grd_cbtes.permitir_busqueda = .f.
Thisform.grd_cbtes.permitir_ordenamiento = .f.
Thisform.grd_cbtes.generar_grid()

* Configuración datagrid depositos
SELECT deposito
Thisform.pgf.page1.grd_depositos.alias_name = "deposito"
Thisform.pgf.page1.grd_depositos.RecordSource = "deposito"
Thisform.pgf.page1.grd_depositos.list_controlsource = "fecTrans, nroTrans, nomBco, nomOrig, docOrig, importe"
Thisform.pgf.page1.grd_depositos.lista_ancho_cols = "100, 150, 200, 250, 100, 100"
Thisform.pgf.page1.grd_depositos.titulos_cabeceras = "Fecha, Número Trans., Banco, Originante, CUIT/DNI, Importe"
Thisform.pgf.page1.grd_depositos.permitir_busqueda = .f.
Thisform.pgf.page1.grd_depositos.permitir_ordenamiento = .f.
Thisform.pgf.page1.grd_depositos.generar_grid()

* Configuracion datagrid cheques de terceros
SELECT cheq_disp
Thisform.pgf.page2.grd_cheques_t.alias_name = "cheq_disp"
Thisform.pgf.page2.grd_cheques_t.RecordSource = "cheq_disp"
Thisform.pgf.page2.grd_cheques_t.list_controlsource = "fecEmis,fecVto,chq_nro,descripcio,nroCUIT,titular,importe"
Thisform.pgf.page2.grd_cheques_t.lista_ancho_cols = "100,100,100,200,100,200,100"
Thisform.pgf.page2.grd_cheques_t.titulos_cabeceras = "Fecha,Vencimiento,Número,Banco,CUIT Tit.,Titular,Importe"
Thisform.pgf.page2.grd_cheques_t.permitir_busqueda = .f.
Thisform.pgf.page2.grd_cheques_t.permitir_ordenamiento = .f.
Thisform.pgf.page2.grd_cheques_t.generar_grid()

* Configuracion datagrid cheques propios
SELECT chequesp
Thisform.pgf.page3.grd_cheques_p.alias_name = "chequesp"
Thisform.pgf.page3.grd_cheques_p.RecordSource = "chequesp"
Thisform.pgf.page3.grd_cheques_p.list_controlsource = "fecEmis,fecVto,nroCheque,descripcio,importe"
Thisform.pgf.page3.grd_cheques_p.lista_ancho_cols = "100,100,100,200,100"
Thisform.pgf.page3.grd_cheques_p.titulos_cabeceras = "Fecha,Vencimiento,Número,Banco,Importe"
Thisform.pgf.page3.grd_cheques_p.permitir_busqueda = .f.
Thisform.pgf.page3.grd_cheques_p.permitir_ordenamiento = .f.
Thisform.pgf.page3.grd_cheques_p.generar_grid()

ENDPROC
PROCEDURE eliminar
***********************************************
* Permite eliminar una orden de pago.
* Fecha: 14/05/2024
* Desarrollador: Leonardo D. Zulli
***********************************************

Thisform.o_orden_pago.idprov = Thisform.id_prov
Thisform.o_orden_pago.id_orden_pago = Thisform.id_orden_pago_c
IF !Thisform.o_orden_pago.eliminar() THEN
	MESSAGEBOX(Thisform.o_orden_pago.mensaje, 0+48, Thisform.Caption)
ELSE
	MESSAGEBOX(Thisform.o_orden_pago.mensaje, 0+64, Thisform.Caption)
ENDIF
ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Proveedor:"
Height = 15
Left = 22
Top = 10
Width = 72
TabIndex = 13
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Nro. O.P.:"
Height = 15
Left = 616
Top = 10
Width = 55
TabIndex = 14
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Fecha de Emisión:"
Height = 15
Left = 22
Top = 34
Width = 110
TabIndex = 15
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: txtCodProv
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 136
ReadOnly = .T.
TabIndex = 1
Top = 6
Width = 140
Name = "txtCodProv"

*** METODOS ***


************************************************************
OBJETO: txtRazSoc
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 279
ReadOnly = .T.
TabIndex = 2
Top = 6
Width = 333
Name = "txtRazSoc"

*** METODOS ***


************************************************************
OBJETO: txtNroOP
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 671
ReadOnly = .T.
TabIndex = 3
Top = 6
Width = 140
Name = "txtNroOP"

*** METODOS ***


************************************************************
OBJETO: txtFecEmision
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 136
ReadOnly = .T.
TabIndex = 5
Top = 30
Width = 140
Name = "txtFecEmision"

*** METODOS ***


************************************************************
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 498
Left = 980
Cancel = .T.
TabIndex = 11
Name = "btnCerrar"

*** METODOS ***


************************************************************
OBJETO: btnImprimir
************************************************************
*** PROPIEDADES ***
Top = 498
Left = 932
TabIndex = 10
Name = "btnImprimir"

*** METODOS ***
PROCEDURE Click
thisform.imprimir()
ENDPROC


************************************************************
OBJETO: pgf
************************************************************
*** PROPIEDADES ***
ErasePage = .T.
PageCount = 3
Top = 175
Left = 24
Width = 1002
Height = 262
Name = "pgf"
PAGE1.Caption = "Depósito / Transferencias"
PAGE1.Name = "PAGE1"
PAGE2.Caption = "Cheques de tercero"
PAGE2.Name = "PAGE2"
Page3.FontBold = .T.
Page3.FontSize = 8
Page3.Caption = "Cheques propios"
Page3.ForeColor = 128,64,64
Page3.Name = "Page3"

*** METODOS ***


************************************************************
OBJETO: grd_depositos
************************************************************
*** PROPIEDADES ***
Height = 225
Left = 5
Top = 5
Width = 990
Name = "grd_depositos"
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


************************************************************
OBJETO: grd_cheques_t
************************************************************
*** PROPIEDADES ***
Height = 225
Left = 4
Top = 2
Width = 990
Name = "grd_cheques_t"
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


************************************************************
OBJETO: grd_cheques_p
************************************************************
*** PROPIEDADES ***
Height = 225
Left = 4
Top = 3
Width = 990
Name = "grd_cheques_p"
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


************************************************************
OBJETO: o_orden_pago
************************************************************
*** PROPIEDADES ***
Top = 60
Left = 24
Height = 17
Width = 18
Name = "o_orden_pago"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Comprobantes aplicados"
Height = 15
Left = 285
Top = 35
Width = 141
TabIndex = 15
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: grd_cbtes
************************************************************
*** PROPIEDADES ***
Height = 106
Left = 285
Top = 52
Width = 736
Name = "grd_cbtes"
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


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Total Efectivo:"
Height = 15
Left = 24
Top = 153
Width = 84
TabIndex = 14
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: txt_efectivo
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 116
ReadOnly = .T.
TabIndex = 3
Top = 148
Width = 140
isnumeric = .T.
Name = "txt_efectivo"

*** METODOS ***


************************************************************
OBJETO: cnt_totales
************************************************************
*** PROPIEDADES ***
Top = 439
Left = 24
Width = 889
Height = 56
Name = "cnt_totales"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Total de orden de pago"
Height = 15
Left = 10
Top = 6
Width = 134
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Total:"
Height = 15
Left = 719
Top = 29
Width = 37
TabIndex = 14
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: txt_total_op
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 758
ReadOnly = .T.
Top = 26
Width = 114
isnumeric = .T.
Name = "txt_total_op"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Ret. I.V.A.:"
Height = 15
Left = 385
Top = 29
Width = 59
TabIndex = 14
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: txtRetencionIVA
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 448
ReadOnly = .T.
Top = 26
Width = 93
isnumeric = .T.
Name = "txtRetencionIVA"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Ret. I.I.B.B.:"
Height = 15
Left = 209
Top = 29
Width = 65
TabIndex = 14
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: txtRetencionIIBB
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 275
ReadOnly = .T.
Top = 26
Width = 95
isnumeric = .T.
Name = "txtRetencionIIBB"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Ret. Gananacia:"
Height = 15
Left = 12
Top = 29
Width = 96
TabIndex = 14
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: txtRetencionGanancia
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 99
ReadOnly = .T.
Top = 26
Width = 99
isnumeric = .T.
Name = "txtRetencionGanancia"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta6
************************************************************
*** PROPIEDADES ***
Caption = "S.U.S.S.:"
Height = 15
Left = 554
Top = 29
Width = 50
TabIndex = 14
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: txtRetencionSUSS
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 610
ReadOnly = .T.
Top = 26
Width = 93
isnumeric = .T.
Name = "txtRetencionSUSS"

*** METODOS ***


************************************************************
OBJETO: btn_eliminar
************************************************************
*** PROPIEDADES ***
Top = 499
Left = 885
Name = "btn_eliminar"

*** METODOS ***
PROCEDURE Click
*************************************************
* Elimina una orden de pago
*************************************************
LOCAL lnRespuesta

lnRespuesta = MESSAGEBOX("¿Está seguro que desea dar de baja la orden de pago?", 4+32, Thisform.Caption)
IF lnRespuesta = 6 THEN
	Thisform.eliminar()
ENDIF
ENDPROC


************************************************************
OBJETO: cls_orden_pago_cons_detalles
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_frm_ordenpago
************************************************************
*** PROPIEDADES ***
Height = 544
Width = 940
DoCreate = .T.
BorderStyle = 2
Caption = "Ingreso de Ordenes de Pagos"
Name = "cls_frm_ordenpago"
contenido.Name = "contenido"

*** METODOS ***
PROCEDURE calcular
LOCAL lnImputar
LOCAL lnImpCheques
LOCAL lnImpDepo
LOCAL lnRetIVA
LOCAL lnRetIIBB
LOCAL lnRetGan
LOCAL lnRetSUSS
LOCAL lnTotChqP
LOCAL lnImpEfvo
LOCAL lnImpOP
LOCAL lnDtoFinanciero
LOCAL lnDtoEspeciales

lnImputar = Thisform.contenido.txtTotImputar.Value
lnImpOP = Thisform.contenido.txtImpOP.Value 

lnImpEfvo = Thisform.contenido.pgroup.page2.txtImporte.Value 
lnImpCheques = Thisform.contenido.pgroup.page3.txtImpTotCheq.Value
lnTotChqP = Thisform.contenido.pgroup.page4.txtImpTotCheqPro.Value
lnImpDepo = Thisform.contenido.pgroup.page5.txtImpTotDep.Value
lnRetIVA = Thisform.contenido.pgroup.page6.txtIVA.Value
lnRetIIBB = Thisform.contenido.pgroup.page6.txtIIBB.Value
lnRetGan = Thisform.contenido.pgroup.page6.txtGanancias.Value
lnRetSUSS = Thisform.contenido.pgroup.page6.txtSUSS.Value
lnDtoFinanciero = Thisform.contenido.pgroup.Page7.txtDtoFinanciero.value
lnDtoEspeciales = Thisform.contenido.pgroup.page7.txtDtoEspecial.value

Thisform.contenido.txtTotalOP.Value = lnImpEfvo + lnImpCheques + lnTotChqP + lnImpDepo + ;
	lnRetIVA + lnRetIIBB + lnRetGan + lnRetSUSS + lnDtoFinanciero + lnDtoEspeciales
	
Thisform.contenido.txtResto.Value = lnImpOP - lnImpEfvo - lnImpCheques  - lnTotChqP - ;
	lnImpDepo - lnRetIVA - lnRetIIBB - lnRetGan - lnRetSUSS - lnDtoFinanciero - lnDtoEspeciales

ENDPROC
PROCEDURE imprimir
LOCAL m.numOP, m.Fecha, m.RazSoc, m.Telefono, m.direccion, m.localidad, m.codPostal, m.pcia, m.TipoIVA, m.nroCUIT, m.condpago
LOCAL m.cuenta, m.efvo, m.retiva, m.retiibb, m.retgan, m.retsuss, m.provin, m.Total
LOCAL lcSql, loRes, lcSaltoLinea, m.detcheq, m.detcheq2, m.detcheq3, m.detcheqp, m.detcheqp2, m.detcheqp3, m.detdepo, m.detdepo2, m.detdepo3
LOCAL m.detcbte, m.detcbte2
LOCAL m.dto_financiero_desc
LOCAL m.dto_financiero_imp
LOCAL m.dto_especiales_desc
LOCAL m.dto_especiales_imp
LOCAL lnIdProveedor
LOCAL lcFileName
LOCAL lnResp

&& Datos de empresa
LOCAL lcEMPRAZSOC, lcEMPCUIT, lcEMPDIREC, lcEMPLOC, lcEMPPCIA, lnEMPCUIT

lcSql = ""
loRes = CREATEOBJECT("odbc_result")
lcSaltoLinea = CHR(13) + CHR(10)
lcFileName = ""
lnIdProveedor = Thisform.contenido.sel_prov.valcpoid

lcSql = " SELECT proveedor.razsoc, "
lcSql = lcSql + " proveedor.direccion, "
lcSql = lcSql + " proveedor.nrocuit, "
lcSql = lcSql + " proveedor.telefono, "
lcSql = lcSql + " localidad.codpostal as codpostal, "
lcSql = lcSql + " localidad.descripcio as loc, "
lcSql = lcSql + " provincias.descripcio as provincia, "
lcSql = lcSql + " sitiva.descripcio as sitiva, "
lcSql = lcSql + " condpagos.descripcio as condpago "
lcSql = lcSql + " FROM proveedor "
lcSql = lcSql + "	INNER JOIN localidad on proveedor.idlocalid = localidad.idlocalid "
lcSql = lcSql + "	INNER JOIN provincias on localidad.idprovin = provincias.idprovin "
lcSql = lcSql + "	INNER JOIN sitiva on proveedor.idsitiva = sitiva.idsitiva "
lcSql = lcSql + "	INNER JOIN condpagos on proveedor.idcondpago = condpagos.idcondpago "
lcSql = lcSql + " WHERE proveedor.idprov = " + ALLTRIM(STR(Thisform.orden_pago.idprov))
  
loRes.ActiveConnection = goConn.ActiveConnection
loRes.cursor_name = "cur_tempo"

IF !loRes.OpenQuery(lcSql) THEN
	this.errorMessage = loRes.Error_Message
	RETURN .F.
ENDIF

SELECT cur_tempo
IF RECCOUNT("cur_tempo") > 0 THEN
	GO TOP
ENDIF  

m.numOP = this.orden_pago.nroop
m.Fecha = DATETIME()
m.RazSoc = cur_tempo.razsoc
m.Telefono = cur_tempo.telefono
m.direccion = cur_tempo.direccion
m.localidad = cur_tempo.loc
m.codPostal = ALLTRIM(cur_tempo.codpostal)
m.pcia = cur_tempo.provincia
m.TipoIVA = cur_tempo.sitiva
m.nroCUIT = cur_tempo.nrocuit
m.condpago = cur_tempo.condpago
m.cuenta = IIF(Thisform.contenido.pgroup.page2.txtImporte.Value = 0, "", Thisform.contenido.pgroup.page2.cmbConcepto.Value)
m.efvo = IIF(Thisform.contenido.pgroup.page2.txtImporte.Value = 0, "", Thisform.contenido.pgroup.page2.txtImporte.Value)
m.retiva = IIF(Thisform.contenido.pgroup.page6.txtIVA.Value = 0, "", Thisform.contenido.pgroup.page6.txtIVA.Value)
m.retiibb = IIF(Thisform.contenido.pgroup.page6.txtIIBB.Value = 0, "", Thisform.contenido.pgroup.page6.txtIIBB.Value)
m.retgan = IIF(Thisform.contenido.pgroup.page6.txtGanancias.Value = 0, "", Thisform.contenido.pgroup.page6.txtGanancias.Value)
m.retsuss = IIF(Thisform.contenido.pgroup.page6.txtSUSS.Value = 0, "", Thisform.contenido.pgroup.page6.txtSUSS.Value)
m.provin = IIF(Thisform.contenido.pgroup.page6.txtIIBB.Value = 0,"", Thisform.contenido.pgroup.page6.cmbPcias.Value)
m.Total = Thisform.contenido.txtImpOP.Value 


*****************************************************************************************************************************************************
&& Armo el detalle de los comprobantes
m.detcbte = ""
m.detcbte2 = ""

SELECT comprob 
GO TOP

DO WHILE !EOF("comprob")
	IF comprob.sel THEN 
		m.detcbte = m.detcbte + IIF(comprob.fecEmis = {} .OR. ISNULL(comprob.fecEmis), SPACE(10), ALLTRIM(DTOC(comprob.fecEmis))) + SPACE(20)
		m.detcbte = m.detcbte + IIF(comprob.fecVto = {} .OR. ISNULL(comprob.fecVto), SPACE(10), ALLTRIM(DTOC(comprob.fecVto))) + SPACE(20)	
		m.detcbte = m.detcbte + IIF(ALLTRIM(comprob.cbte) == "", SPACE(2), ALLTRIM(comprob.cbte)) + SPACE(15)
		m.detcbte = m.detcbte + IIF(ALLTRIM(comprob.tipodoc) == "", SPACE(2), ALLTRIM(comprob.tipodoc)) + SPACE(15)	
		m.detcbte = m.detcbte + IIF(ALLTRIM(comprob.nroFC) == "", SPACE(8), ALLTRIM(comprob.nroFC)) + lcSaltoLinea
		
		m.detcbte2 = m.detcbte2 + ALLTRIM(STR(comprob.imppag, 10, 2)) + lcSaltoLinea

	ENDIF 

	SELECT comprob 
	SKIP
ENDDO

SELECT comprob 
GO TOP
*****************************************************************************************************************************************************
&& Armo el detalle de los cheques
m.detcheq = ""
m.detcheq2 = ""
m.detcheq3 = ""

SELECT cheq_disp
GO TOP

DO WHILE !EOF("cheq_disp")
	IF cheq_disp.sel THEN 
		m.detcheq = m.detcheq + SUBSTR(ALLTRIM(cheq_disp.descripcio), 1, 60) + lcSaltoLinea		

		m.detcheq2 = m.detcheq2  + IIF(ALLTRIM(cheq_disp.chq_nro) == "", SPACE(20), ALLTRIM(cheq_disp.chq_nro)) + SPACE(14)
		
		m.detcheq2 = m.detcheq2 + IIF(cheq_disp.fecEmis = {} .OR. ISNULL(cheq_disp.fecEmis), SPACE(10), ALLTRIM(DTOC(cheq_disp.fecEmis))) + SPACE(13)
		m.detcheq2 = m.detcheq2 + IIF(cheq_disp.fecVto = {} .OR. ISNULL(cheq_disp.fecVto), SPACE(10), ALLTRIM(DTOC(cheq_disp.fecVto))) + lcSaltoLinea		

		m.detcheq3 = m.detcheq3 + ALLTRIM(STR(cheq_disp.importe, 10, 2)) + lcSaltoLinea
	ENDIF 
	SELECT cheq_disp
	SKIP
ENDDO

SELECT cheq_disp
GO TOP
*****************************************************************************************************************************************************
&& Armo el detalle de los cheques propios
m.detcheqp = ""
m.detcheqp2 = ""
m.detcheqp3 = ""

SELECT chequesp
GO TOP

DO WHILE !EOF("chequesp")
	m.detcheqp = m.detcheqp + SUBSTR(ALLTRIM(chequesp.descripcio), 1, 60) + lcSaltoLinea		

	m.detcheqp2 = m.detcheqp2 + IIF(ALLTRIM(chequesp.nroCheque) == "", SPACE(8), ALLTRIM(chequesp.nroCheque)) + SPACE(25)
	
	m.detcheqp2 = m.detcheqp2 + IIF(chequesp.fecEmis = {} .OR. ISNULL(chequesp.fecEmis), SPACE(10), ALLTRIM(DTOC(chequesp.fecEmis))) + SPACE(20)
	m.detcheqp2 = m.detcheqp2 + IIF(chequesp.fecVto = {} .OR. ISNULL(chequesp.fecVto), SPACE(10), ALLTRIM(DTOC(chequesp.fecVto))) + lcSaltoLinea		
		
	m.detcheqp3 = m.detcheqp3 + ALLTRIM(STR(chequesp.importe, 10, 2)) + lcSaltoLinea

	SELECT chequesp
	SKIP
ENDDO

SELECT chequesp
GO TOP
*****************************************************************************************************************************************************
&& Armo el detalle de los cheques propios
m.detdepo = ""
m.detdepo2 = ""
m.detdepo3 = ""

SELECT deposito
GO TOP

DO WHILE !EOF("deposito")
	m.detdepo = m.detdepo + SUBSTR(ALLTRIM(deposito.nomBco), 1, 60) + lcSaltoLinea		

	m.detdepo2 = m.detdepo2 + IIF(ALLTRIM(deposito.nroTrans) == "", SPACE(8), ALLTRIM(deposito.nroTrans)) + SPACE(25)

	m.detdepo2 = m.detdepo2 + IIF(deposito.fecTrans = {} .OR. ISNULL(deposito.fecTrans), SPACE(10), ALLTRIM(DTOC(deposito.fecTrans))) + SPACE(20)
		
	m.detdepo3 = m.detdepo3 + ALLTRIM(STR(deposito.importe, 10, 2)) + lcSaltoLinea

	SELECT deposito
	SKIP
ENDDO

SELECT deposito
GO TOP
*****************************************************************************************************************************************************

&& Armo los descuentos comerciales.
IF Thisform.contenido.pgroup.page7.txtDtoFinanciero.Value <> 0 THEN
	m.dto_financiero_desc = "DESCUENTO FINANCIERO"
	m.dto_financiero_imp = Thisform.contenido.pgroup.page7.txtDtoFinanciero.Value
ELSE
	m.dto_financiero_desc = "DESCUENTO FINANCIERO"
	m.dto_financiero_imp = 0.00
ENDIF

IF Thisform.contenido.pgroup.page7.txtDtoEspecial.Value <> 0 THEN
	m.dto_especiales_desc = "DESCUENTO ESPECIAL"
	m.dto_especiales_imp = Thisform.contenido.pgroup.page7.txtDtoEspecial.Value	
ELSE
	m.dto_especiales_desc = "DESCUENTO ESPECIAL"
	m.dto_especiales_imp = 0.00
ENDIF

* Pregunto si quieren generar el pdf en el compartido.
lnResp = MESSAGEBOX("¿Desea generar la orden de pago en PDF?", 4+32, This.Caption)
IF lnResp = 6 THEN
	* Si el usuario dice que si, seteo la impresora bullziprinter.
	IF DIRECTORY(GetGlobalCfg("FACPDFPATH")) THEN
		* Si el directorio existe entonces genero el PDF
		lcFileName = ALLTRIM(GetGlobalCfg("FACPDFPATH")) + "OP_" + ALLTRIM(STR(m.numOP)) + "_Proveedor_" + ALLTRIM(STR(lnIdProveedor)) + ".pdf"

		loPDF = CREATEOBJECT("Bullzip.PDFPrinterSettings")
		loPDF.SetValue('output', lcFileName)
		loPDF.SetValue('DisableOptionDialog', 'no') 
		loPDF.SetValue('ConfirmOverwrite', 'no')
		loPDF.SetValue('Showsettings', 'never') 
		loPDF.SetValue('ShowSaveAS', 'nofile') 
		loPDF.SetValue('ShowPdf', 'no') 
		loPDF.WriteSettings(.t.)
		
		* Asigno datos de empresa
		lcEMPRAZSOC = GetGlobalCfg("EMPRAZSOC")
		lcEMPCUIT = GetGlobalCfg("EMPCUIT")
		lcEMPDIREC = GetGlobalCfg("EMPDIREC")
		lcEMPLOC = GetGlobalCfg("EMPLOC")

		SET PRINTER TO NAME("Bullzip PDF Printer") NOCONSOLE
		SELECT cur_tempo
		REPORT FORM repop NOCONSOLE TO PRINTER
		SET PRINTER TO DEFAULT
		SET CONSOLE ON
		
		DO WHILE !FILE(lcFileName)
			WAIT WINDOW "El archivo PDF se está generando, aguarde unos segundos..." NOWAIT	
		ENDDO
	ELSE
		MESSAGEBOX("No se puede acceder a la carpeta: " + ALLTRIM(GetGlobalCfg("FACPDFPATH")), 0+48, Thisform.Caption)
	ENDIF
ELSE
	SELECT cur_tempo
	REPORT FORM repop TO PRINTER PROMPT PREVIEW
ENDIF

loRes.close_query()


ENDPROC
PROCEDURE validar_pago
LOCAL lnCantSel, lnImputado, lnResto, lnResp

lnCantSel = 0
lnImputado = Thisform.contenido.txtImpOP.Value 
lnResto = Thisform.contenido.txtResto.Value

&& Valido
IF Thisform.contenido.txtImpOP.Enabled THEN 
	RETURN .F.
ENDIF 

IF Thisform.contenido.txtTotalOP.Value = 0 THEN
	MESSAGEBOX("No se puede ingresar una orden de pago en 0 (cero)", 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

IF lnResto <> 0 THEN
	MESSAGEBOX("No coincide el importe total de la orden de pago con lo imputado.", 0+48, Thisform.Caption)
	
	lnResp = MESSAGEBOX("¿Desea que el sistema corrija este error? Se modificará el importe total de la orden de pago.", 4+32, Thisform.Caption)
	IF lnResp = 6 THEN
		Thisform.Contenido.txtImpOP.Value = Thisform.Contenido.txtTotalOP.Value
		Thisform.Contenido.txtresto.Value = 0.00
		MESSAGEBOX("Importe total corregido, controle la orden de pago y vuelva a confirmar el grabado.", 0+64, Thisform.Caption)
	ENDIF
	
	RETURN .F.
ENDIF


******************************************************************************************************
&& Valido que no se hayan seleccionado mas facturas de las que se puede cancelar con el pago.
SELECT COUNT(*) AS cantSel FROM comprob WHERE sel = .T. ;
INTO CURSOR cur_x

SELECT cur_x
lnCantSel = cur_x.cantSel
USE IN cur_x

SELECT comprob 
IF RECCOUNT("comprob") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("comprob")
	IF comprob.sel THEN
		IF (lnCantSel > 1) .AND. lnImputado <= 0 THEN
			MESSAGEBOX("El pago no es válido. Se seleccionaron más comprobantes de los que se pueden cancelar con el importe ingresado.", 0+48, Thisform.Caption)
			RETURN .F.
		ELSE
			lnImputado = lnImputado - comprob.saldo
		ENDIF
	ENDIF

	SELECT comprob 
	SKIP
ENDDO

SELECT comprob
IF RECCOUNT("comprob") > 0 THEN
	GO TOP
ENDIF

RETURN .T.
ENDPROC
PROCEDURE cambiar_estado
***************************************************************
* Permite cambiar el estado de las pestañas y el boton grabar
* Fecha: 14/12/2022
* Desarrollado por: Enzo Alzueta
***************************************************************
LPARAMETERS tlEstado

thisform.contenido.pgroup.page2.Enabled = tlEstado
thisform.contenido.pgroup.page3.Enabled = tlEstado
thisform.contenido.pgroup.page4.Enabled = tlEstado
thisform.contenido.pgroup.page5.Enabled = tlEstado
thisform.contenido.pgroup.page6.Enabled = tlEstado
thisform.contenido.pgroup.page7.Enabled = tlEstado
thisform.contenido.BtnGrabar.Enabled = tlEstado
ENDPROC
PROCEDURE Init
Thisform.orden_pago.crear_cursor()

&& Configuración de grilla de comprobantes a seleccionar
SELECT comprob
Thisform.contenido.pgroup.page1.grdComprobantes.alias_name = "comprob"
Thisform.contenido.pgroup.page1.grdComprobantes.RecordSource = "comprob"
Thisform.contenido.pgroup.page1.grdComprobantes.List_controlsource = "sel,fecEmis,fecVto,cbte,tipoDoc,nroFC,saldo"
Thisform.contenido.pgroup.page1.grdComprobantes.lista_ancho_cols = "70,100,100,70,70,100,70"
Thisform.contenido.pgroup.page1.grdComprobantes.titulos_cabeceras = "Sel.,Fecha,Fec. Vto.,Cbte,Tipo,Número,Saldo"
Thisform.contenido.pgroup.page1.grdComprobantes.generar_grid()
Thisform.contenido.pgroup.page1.grdComprobantes.Columns[1].ReadOnly = .F.

&& Configuración de grilla de cheques disponible
SELECT cheq_disp
Thisform.contenido.pgroup.page3.grdChequesDisp.alias_name = "cheq_disp"
Thisform.contenido.pgroup.page3.grdChequesDisp.RecordSource = "cheq_disp"
Thisform.contenido.pgroup.page3.grdChequesDisp.list_controlsource = "sel,codBco,descripcio,chq_nro,fecEmis,fecVto,importe,idCliente,razSoc,tipoDoc,nroCUIT,titular,nroRec"
Thisform.contenido.pgroup.page3.grdChequesDisp.lista_ancho_cols = "50,70,150,100,80,80,80,70,150,70,100,100,100"
Thisform.contenido.pgroup.page3.grdChequesDisp.titulos_cabeceras = "Sel.,Cod. Banco,Banco,Número,Fecha Emisión,Fecha Vto.,Importe,Cliente,Razón Social,Tipo Doc.,Nro Doc.,Titular,Recibo"
Thisform.contenido.pgroup.page3.grdChequesDisp.generar_grid()
Thisform.contenido.pgroup.page3.grdChequesDisp.Columns[1].ReadOnly = .F.

&& Configuración de grilla de cheques propios
SELECT chequesp
Thisform.contenido.pgroup.page4.grdChequesP.Alias_name = "chequesp"
Thisform.contenido.pgroup.page4.grdChequesP.RecordSource = "chequesp"
Thisform.contenido.pgroup.page4.grdChequesP.list_controlsource = "descripcio,nroCheque,fecEmis,fecVto,importe"
Thisform.contenido.pgroup.page4.grdChequesP.titulos_cabeceras = "Banco,Nº Cheque,Fecha Emisión,Fecha Vto.,Importe"
Thisform.contenido.pgroup.page4.grdChequesP.lista_ancho_cols = "200,100,100,100,70"
Thisform.contenido.pgroup.page4.grdChequesP.generar_grid()

&& Configuración de la grilla de depósito bancario
SELECT deposito
Thisform.contenido.pgroup.page5.grdDepositos.alias_name = "deposito"
Thisform.contenido.pgroup.page5.grdDepositos.RecordSource = "deposito"
Thisform.contenido.pgroup.page5.grdDepositos.list_controlsource = "codBco,nomBco,nroTrans,fecTrans,nomOrig,docOrig,importe"
Thisform.contenido.pgroup.page5.grdDepositos.lista_ancho_cols = "70,200,120,100,150,100,100"
Thisform.contenido.pgroup.page5.grdDepositos.titulos_cabeceras = "Cod. Banco,Banco,Nº Transacción,Fecha,Originante,Doc. Orig.,Importe"
Thisform.contenido.pgroup.page5.grdDepositos.generar_grid()


* Lleno el combo de conceptos
SELECT efvo_cptos
GO TOP
DO WHILE !EOF("efvo_cptos")
	Thisform.contenido.pgroup.page2.cmbConcepto.AddItem(ALLTRIM(efvo_cptos.descripcio))
	
	SELECT efvo_cptos
	SKIP
ENDDO

SELECT efvo_cptos
GO TOP

* Lleno los bancos
SELECT bancos
GO TOP
DO WHILE !EOF("bancos")
	Thisform.contenido.pgroup.page5.cmbBanco.AddItem(ALLTRIM(bancos.descripcio))
	Thisform.contenido.pgroup.page4.cmbBancoCHP.AddItem(ALLTRIM(bancos.descripcio))
	
	SELECT bancos
	SKIP
ENDDO

SELECT bancos
GO TOP

* Lleno las provincias
SELECT pcias
GO TOP
DO WHILE !EOF("pcias")
	Thisform.contenido.pgroup.page6.cmbPcias.AddItem(ALLTRIM(pcias.descripcio))

	SELECT pcias
	SKIP
ENDDO

SELECT pcias
GO TOP

Thisform.contenido.pgroup.page2.cmbConcepto.ListIndex = 2
Thisform.contenido.pgroup.page4.cmbBancoCHP.ListIndex = 1
Thisform.contenido.pgroup.page4.txtFecEmision.Value = DATE()
Thisform.contenido.pgroup.page4.txtFecVto.Value = {}
Thisform.contenido.pgroup.page4.txtImporte.ReadOnly = .T.
Thisform.contenido.pgroup.page4.txtFecEmision.ReadOnly = .T.
Thisform.contenido.pgroup.page5.cmbBanco.ListIndex = 1
Thisform.contenido.pgroup.page5.txtFecha.Value = DATE()
Thisform.contenido.pgroup.page6.cmbPcias.ListIndex = 1
Thisform.cambiar_estado(.F.)
ENDPROC
PROCEDURE Load
LOCAL loRes
LOCAL lcSql

loRes = CREATEOBJECT("odbc_result")
lcSql = ""

DODEFAULT()

CREATE CURSOR efvo_cptos ( ;
	idPlanCta int,;
	codPlanCta varchar(20),;
	descripcio varchar(60))

lcSql = "SELECT idPlanCta, codPlanCta, descripcio "
lcSql = lcSql + "FROM planctas "
lcSql = lcSql + "WHERE planctas.codAbr LIKE 'FP%' "
lcSql = lcSql + "ORDER BY planctas.descripcio"

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_tempo"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN
ENDIF

SELECT cur_tempo
GO TOP
DO WHILE !EOF("cur_tempo")
	SELECT efvo_cptos
	APPEND BLANK
	REPLACE efvo_cptos.idPlanCta WITH cur_tempo.idPlanCta
	REPLACE efvo_cptos.codPlanCta WITH cur_tempo.codPlanCta ADDITIVE
	REPLACE efvo_cptos.descripcio WITH cur_tempo.descripcio ADDITIVE

	SELECT cur_tempo
	SKIP
ENDDO

SELECT efvo_cptos
GO TOP
loRes.Close_Query()

* Cargo los bancos a seleccionar para el deposito bancario o transferencia

CREATE CURSOR bancos (	;
	idBanco int,;
	idPlanCta int,;
	codBco varchar(5),;
	descripcio varchar(60))

lcSql = "SELECT bancos.idBanco, bancos.idPlanCta, bancos.codBco, bancos.descripcio "
lcSql = lcSql + "FROM bancos "
lcSql = lcSql + "	INNER JOIN planctas ON planctas.idPlanCta = bancos.idPlanCta "
lcSql = lcSql + "WHERE bancos.fecBaja IS NULL "
lcSql = lcSql + "ORDER BY bancos.descripcio "

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_tempo"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN
ENDIF

SELECT cur_tempo
GO TOP
DO WHILE !EOF("cur_tempo")
	SELECT bancos
	APPEND BLANK
	REPLACE bancos.idBanco WITH cur_tempo.idBanco
	REPLACE bancos.idPlanCta WITH cur_tempo.idPlanCta ADDITIVE
	REPLACE bancos.codBco WITH cur_tempo.codBco ADDITIVE
	REPLACE bancos.descripcio WITH cur_tempo.descripcio ADDITIVE

	SELECT cur_tempo
	SKIP
ENDDO

SELECT bancos
GO TOP

loRes.Close_Query()

* Levanto las provincias
CREATE CURSOR pcias ( ;
	idProvin int,;
	descripcio varchar(60))

lcSql = "SELECT * FROM provincias ORDER BY provincias.descripcio"
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_tempo"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.ErrorMessage, 0+48, Thisform.Caption)
	RETURN
ENDIF

SELECT cur_tempo
GO TOP
DO WHILE !EOF("cur_tempo")
	SELECT pcias
	APPEND BLANK
	REPLACE pcias.idProvin WITH cur_tempo.idProvin
	REPLACE pcias.descripcio WITH cur_tempo.descripcio ADDITIVE

	SELECT cur_tempo
	SKIP
ENDDO

SELECT pcias
GO TOP

loRes.Close_Query()
ENDPROC


************************************************************
OBJETO: orden_pago
************************************************************
*** PROPIEDADES ***
Top = 475
Left = 612
Height = 17
Width = 22
Name = "orden_pago"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Proveedor:"
Height = 15
Left = 16
Top = 20
Width = 72
TabIndex = 14
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: sel_prov
************************************************************
*** PROPIEDADES ***
Top = 13
Left = 91
TabIndex = 1
nombre_campo_codigo = idProv
nombre_campo_desc = razSoc
nombre_tabla = proveedor
pkfield = idProv
autocompletar_ceros = .F.
esnumerico = .T.
criterio_filtro = fecBaja IS NULL
Name = "sel_prov"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***
PROCEDURE recuperar_datos
&& Acá hago que levante los comprobantes a seleccionar de una
&& al seleccionar el proveedor

Thisform.orden_pago.idprov = This.Parent.sel_prov.valcpoid
Thisform.orden_pago.leer_cbtes()
Thisform.Contenido.pgroup.page1.grdComprobantes.Refresh()

&& Cargo los datos del originante en depósito en base al proveedor
&& seleccionado.
SELECT proveedor
Thisform.Contenido.pgroup.Page5.txtOriginante.Value = proveedor.razSoc
Thisform.Contenido.pgroup.Page5.txtDocumento.Value = proveedor.nroCUIT

Thisform.Contenido.pgroup.page1.grdComprobantes.SetFocus()
This.habilitar(.F.)
ENDPROC


************************************************************
OBJETO: pgroup
************************************************************
*** PROPIEDADES ***
ErasePage = .T.
PageCount = 7
Top = 48
Left = 13
Width = 924
Height = 422
TabIndex = 4
Name = "pgroup"
Page1.Caption = "Seleccionar comprobantes"
Page1.Name = "Page1"
Page2.Caption = "Efectivo"
Page2.Name = "Page2"
Page3.FontBold = .T.
Page3.FontSize = 8
Page3.Caption = "Cheques"
Page3.ForeColor = 128,64,64
Page3.Name = "Page3"
Page4.FontBold = .T.
Page4.FontSize = 8
Page4.Caption = "Cheques Propios"
Page4.ForeColor = 128,64,64
Page4.Name = "Page4"
Page5.FontBold = .T.
Page5.FontSize = 8
Page5.Caption = "Depósitos"
Page5.ForeColor = 128,64,64
Page5.Name = "Page5"
Page6.FontBold = .T.
Page6.FontSize = 8
Page6.Caption = "Retenciones"
Page6.ForeColor = 128,64,64
Page6.Name = "Page6"
Page7.FontBold = .T.
Page7.FontSize = 8
Page7.Caption = "Descuentos"
Page7.ForeColor = 128,64,64
Page7.Name = "Page7"

*** METODOS ***
PROCEDURE Page2.Click
This.txtImporte.SetFocus()
ENDPROC
PROCEDURE Page4.Click
This.cmbBancoCHP.SetFocus()
ENDPROC
PROCEDURE Page5.Click
This.cmbBanco.SetFocus()
ENDPROC
PROCEDURE Page6.Click
This.txtIVA.SetFocus()
ENDPROC


************************************************************
OBJETO: grdComprobantes
************************************************************
*** PROPIEDADES ***
Anchor = 0
Height = 377
Left = 8
TabIndex = 2
Top = 7
Width = 905
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdComprobantes"
COLUMN1.HEADER1.Name = "HEADER1"
COLUMN1.TEXT1.Alignment = 2
COLUMN1.TEXT1.Name = "TEXT1"
COLUMN1.Alignment = 2
COLUMN1.ControlSource = ""
COLUMN1.CurrentControl = "CLSCHECKBOX1"
COLUMN1.Sparse = .F.
COLUMN1.Name = "COLUMN1"
COLUMN2.HEADER1.Name = "HEADER1"
COLUMN2.TEXT1.Name = "TEXT1"
COLUMN2.Name = "COLUMN2"
COLUMN3.HEADER1.Name = "HEADER1"
COLUMN3.TEXT1.Name = "TEXT1"
COLUMN3.Name = "COLUMN3"
COLUMN4.HEADER1.Name = "HEADER1"
COLUMN4.TEXT1.Name = "TEXT1"
COLUMN4.Name = "COLUMN4"
COLUMN5.HEADER1.Name = "HEADER1"
COLUMN5.TEXT1.Name = "TEXT1"
COLUMN5.Name = "COLUMN5"
COLUMN6.HEADER1.Name = "HEADER1"
COLUMN6.TEXT1.Name = "TEXT1"
COLUMN6.Name = "COLUMN6"
COLUMN7.HEADER1.Name = "HEADER1"
COLUMN7.TEXT1.Name = "TEXT1"
COLUMN7.Name = "COLUMN7"
COLUMN8.HEADER1.Name = "HEADER1"
COLUMN8.TEXT1.Name = "TEXT1"
COLUMN8.Name = "COLUMN8"
COLUMN9.HEADER1.Name = "HEADER1"
COLUMN9.TEXT1.Name = "TEXT1"
COLUMN9.Name = "COLUMN9"
COLUMN10.HEADER1.Name = "HEADER1"
COLUMN10.TEXT1.Name = "TEXT1"
COLUMN10.Name = "COLUMN10"
COLUMN11.HEADER1.Name = "HEADER1"
COLUMN11.TEXT1.Name = "TEXT1"
COLUMN11.Name = "COLUMN11"
COLUMN12.HEADER1.Name = "HEADER1"
COLUMN12.TEXT1.Name = "TEXT1"
COLUMN12.Name = "COLUMN12"
COLUMN13.HEADER1.Name = "HEADER1"
COLUMN13.TEXT1.Name = "TEXT1"
COLUMN13.Name = "COLUMN13"
COLUMN14.HEADER1.Name = "HEADER1"
COLUMN14.TEXT1.Name = "TEXT1"
COLUMN14.Name = "COLUMN14"
COLUMN15.HEADER1.Name = "HEADER1"
COLUMN15.TEXT1.Name = "TEXT1"
COLUMN15.Name = "COLUMN15"
COLUMN16.HEADER1.Name = "HEADER1"
COLUMN16.TEXT1.Name = "TEXT1"
COLUMN16.Name = "COLUMN16"
COLUMN17.HEADER1.Name = "HEADER1"
COLUMN17.TEXT1.Name = "TEXT1"
COLUMN17.Name = "COLUMN17"
COLUMN18.HEADER1.Name = "HEADER1"
COLUMN18.TEXT1.Name = "TEXT1"
COLUMN18.Name = "COLUMN18"
COLUMN19.HEADER1.Name = "HEADER1"
COLUMN19.TEXT1.Name = "TEXT1"
COLUMN19.Name = "COLUMN19"
COLUMN20.HEADER1.Name = "HEADER1"
COLUMN20.TEXT1.Name = "TEXT1"
COLUMN20.Name = "COLUMN20"

*** METODOS ***


************************************************************
OBJETO: CLSCHECKBOX1
************************************************************
*** PROPIEDADES ***
Top = 23
Left = 52
Alignment = 0
Centered = .T.
Caption = ""
Name = "CLSCHECKBOX1"

*** METODOS ***
PROCEDURE KeyPress
LPARAMETERS nKeyCode, nShiftAltCtrl

*!*	IF nKeyCode = 13 .Or. nKeyCode = 9 THEN 
*!*		Thisform.contenido.pgroup.page2.SetFocus()
*!*		Thisform.contenido.pgroup.page2.txtImporte.SetFocus()
*!*	ENDIF 
ENDPROC
PROCEDURE Click
**
* Permite calcular el saldo a imputar y el importe de la orden de pago
* según se selecciona el comprobante.
**

IF This.Value THEN
	Thisform.Contenido.txtTotImputar.Value = Thisform.Contenido.txtTotImputar.Value + comprob.saldo
	Thisform.Contenido.txtImpOP.Value = Thisform.Contenido.txtImpOP.Value + comprob.saldo
ELSE
	Thisform.Contenido.txtTotImputar.Value = Thisform.Contenido.txtTotImputar.Value - comprob.saldo
	Thisform.Contenido.txtImpOP.Value = Thisform.Contenido.txtImpOP.Value - comprob.saldo
ENDIF


ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Concepto:"
Height = 15
Left = 19
Top = 21
Width = 72
TabIndex = 3
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: cmbConcepto
************************************************************
*** PROPIEDADES ***
Height = 22
Left = 94
TabIndex = 1
Top = 18
Width = 425
Name = "cmbConcepto"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Importe:"
Height = 15
Left = 19
Top = 48
Width = 72
TabIndex = 4
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: txtImporte
************************************************************
*** PROPIEDADES ***
Left = 94
TabIndex = 2
Top = 43
isnumeric = .T.
Name = "txtImporte"

*** METODOS ***
PROCEDURE calcular
Thisform.calcular()

ENDPROC
PROCEDURE KeyPress
LPARAMETERS nKeyCode, nShiftAltCtrl

*!*	IF nKeyCode = 13 .Or. nKeyCode = 9 THEN 
*!*		Thisform.contenido.pgroup.page3.SetFocus()
*!*		&&Thisform.contenido.pgroup.page3.grdChequesDisp.SetFocus()
*!*	ENDIF 

ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Cheques en cartera disponibles"
Height = 15
Left = 9
Top = 14
Width = 180
TabIndex = 3
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: grdChequesDisp
************************************************************
*** PROPIEDADES ***
Height = 331
Left = 5
TabIndex = 1
Top = 30
Width = 909
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdChequesDisp"
COLUMN1.Header1.Name = "Header1"
COLUMN1.Text1.Alignment = 2
COLUMN1.Text1.Name = "Text1"
COLUMN1.Alignment = 2
COLUMN1.CurrentControl = "CLSCHECKBOX1"
COLUMN1.Sparse = .F.
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
COLUMN11.Header1.Alignment = 2
COLUMN11.Header1.Name = "Header1"
COLUMN11.Text1.Name = "Text1"
COLUMN11.Name = "COLUMN11"
COLUMN12.Header1.Alignment = 2
COLUMN12.Header1.Name = "Header1"
COLUMN12.Text1.Name = "Text1"
COLUMN12.Name = "COLUMN12"
COLUMN13.Header1.Alignment = 2
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


************************************************************
OBJETO: CLSCHECKBOX1
************************************************************
*** PROPIEDADES ***
Top = 27
Left = 32
Alignment = 0
Centered = .T.
Caption = ""
Name = "CLSCHECKBOX1"

*** METODOS ***
PROCEDURE KeyPress
LPARAMETERS nKeyCode, nShiftAltCtrl

*!*	IF nKeyCode = 13 .Or. nKeyCode = 9 THEN 
*!*		Thisform.contenido.pgroup.page4.SetFocus()
*!*		Thisform.contenido.pgroup.page4.cmbBancoCHP.SetFocus()
*!*	ENDIF 
ENDPROC
PROCEDURE InteractiveChange
LOCAL lnTotChqT

lnTotChqT = 0.00

lnTotChqT = Thisform.contenido.pgroup.page3.txtImpTotCheq.Value

IF This.Value THEN
	lnTotChqT = lnTotChqT + cheq_disp.importe
ELSE
	lnTotChqT = lnTotChqT - cheq_disp.importe
ENDIF

Thisform.contenido.pgroup.page3.txtImpTotCheq.Value = lnTotChqT

Thisform.calcular()
ENDPROC


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Total cheques:"
Height = 15
Left = 20
Top = 370
Width = 101
TabIndex = 4
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: txtImpTotCheq
************************************************************
*** PROPIEDADES ***
Left = 111
ReadOnly = .T.
TabIndex = 2
TabStop = .F.
Top = 366
isnumeric = .T.
Name = "txtImpTotCheq"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Banco:"
Height = 15
Left = 16
Top = 28
Width = 51
TabIndex = 10
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: cmbBancoCHP
************************************************************
*** PROPIEDADES ***
Height = 22
Left = 74
TabIndex = 1
Top = 22
Width = 589
Name = "cmbBancoCHP"

*** METODOS ***


************************************************************
OBJETO: btnGenerarCheque
************************************************************
*** PROPIEDADES ***
Top = 10
Left = 671
Height = 36
Width = 108
Caption = "\<Generar cheque"
TabIndex = 2
Name = "btnGenerarCheque"

*** METODOS ***
PROCEDURE Click
LOCAL loRes
LOCAL lcSql
LOCAL lnNroCheque

loRes = CREATEOBJECT("odbc_result")
lcSql = ""
lnNroCheque = 0

IF Thisform.contenido.pgroup.page4.cmbBancoCHP.ListIndex = 0 THEN
	MESSAGEBOX("Debe seleccionar un banco", 0+48, Thisform.Caption)
	Thisform.contenido.pgroup.page4.cmbBancoCHP.SetFocus()
	RETURN
ENDIF

SELECT bancos
GO TOP
GO Thisform.contenido.pgroup.page4.cmbBancoCHP.ListIndex


&& Tengo que buscar la chequera habilitada para generar el cheque
lcSql = "SELECT * FROM chequeras "
lcSql = lcSql + "WHERE idBanco = " + ALLTRIM(STR(bancos.idBanco)) + " "
lcSql = lcSql + "	AND habilitado = 1 "
*!*	lcSql = lcSql + "	AND numActual < numHasta "
lcSql = lcSql + "ORDER BY numDesde "

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_tempo"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

IF cur_tempo.numActual = cur_tempo.numHasta THEN
	MESSAGEBOX("Atención, ya no tiene más cheques disponible en la chequera", 0+48, Thisform.Caption)
	loRes.Close_Query()
	RETURN .F.
ENDIF

lnNroCheque = cur_tempo.numActual
Thisform.contenido.pgroup.page4.txtNroChequera.Value = cur_tempo.idChequera

loRes.Close_Query()

Thisform.contenido.pgroup.page4.txtNroCheque.Value = REPLICATE("0", 8 - LEN(ALLTRIM(STR(lnNroCheque)))) + ALLTRIM(STR(lnNroCheque))
Thisform.contenido.pgroup.page4.txtFecEmision.Value = DATE()
Thisform.contenido.pgroup.page4.txtFecEmision.Value = {}

Thisform.contenido.pgroup.page4.txtImporte.ReadOnly = .F.
Thisform.contenido.pgroup.page4.txtFecEmision.ReadOnly = .F.
Thisform.contenido.pgroup.page4.txtFecVto.ReadOnly = .F.

SELECT chequesp
Thisform.contenido.pgroup.page4.txtImporte.SetFocus()

ENDPROC


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Importe:"
Height = 15
Left = 16
Top = 53
Width = 51
TabIndex = 13
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: txtImporte
************************************************************
*** PROPIEDADES ***
Left = 74
TabIndex = 3
Top = 48
isnumeric = .T.
Name = "txtImporte"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Fecha Emisión:"
Height = 15
Left = 184
Top = 53
Width = 103
TabIndex = 14
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: txtFecEmision
************************************************************
*** PROPIEDADES ***
Left = 271
TabIndex = 4
Top = 48
isdatetime = .T.
Name = "txtFecEmision"

*** METODOS ***


************************************************************
OBJETO: grdChequesP
************************************************************
*** PROPIEDADES ***
Height = 264
Left = 8
TabIndex = 10
Top = 99
Width = 904
Name = "grdChequesP"
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


************************************************************
OBJETO: btnAgregar
************************************************************
*** PROPIEDADES ***
Top = 47
Left = 750
Height = 40
Width = 40
TabIndex = 8
Name = "btnAgregar"

*** METODOS ***
PROCEDURE Click
LOCAL lnTotChqP, lnImporte

lnTotChqP = 0.00
lnImporte = 0.00

&& Valido
IF Thisform.contenido.pgroup.page4.cmbBancoCHP.ListIndex = 0 THEN
	MESSAGEBOX("Debe seleccionar un banco", 0+48, Thisform.Caption)
	Thisform.contenido.pgroup.page4.cmbBancoCHP.SetFocus()
	RETURN .F.
ENDIF

IF Thisform.contenido.pgroup.page4.txtImporte.Value = 0 THEN
	MESSAGEBOX("El importe del cheque no puede ser cero", 0+48, Thisform.Caption)
	Thisform.contenido.pgroup.page4.txtImporte.SetFocus()
	RETURN .F.
ENDIF

IF Thisform.contenido.pgroup.page4.txtFecEmision.Value = {} THEN
	MESSAGEBOX("Debe ingresar la fecha de emisión", 0+48, Thisform.Caption)
	Thisform.contenido.pgroup.page4.txtFecEmision.SetFocus()
	RETURN .F.
ENDIF

IF Thisform.contenido.pgroup.page4.txtFecVto.Value = {} THEN
	MESSAGEBOX("Debe ingresar la fecha de vencimiento", 0+48, Thisform.Caption)
	Thisform.contenido.pgroup.page4.txtFecVto.SetFocus()
	RETURN .F.
ENDIF


SELECT bancos
GO TOP

GO Thisform.contenido.pgroup.page4.cmbBancoCHP.ListIndex


&& Agrego el cheque a la orden de pago y la grilla.
Thisform.orden_pago.agregar_chequesp(This.Parent.txtNroChequera.Value, bancos.idPlanCta, ;
	bancos.idBanco, bancos.descripcio, Thisform.contenido.sel_prov.valcpoid, ;
	0, This.Parent.txtNroCheque.Value, This.Parent.txtFecEmision.Value,;
	This.Parent.txtFecVto.Value, This.Parent.txtImporte.Value)

Thisform.contenido.pgroup.page4.grdChequesP.Refresh()
	
	
&& Calculo los totales 
lnTotChqP = Thisform.contenido.pgroup.page4.txtImpTotCheqPro.Value
lnImporte = Thisform.contenido.pgroup.page4.txtImporte.Value 
Thisform.contenido.pgroup.page4.txtImpTotCheqPro.Value = lnTotChqP + lnImporte 

Thisform.calcular()

Thisform.contenido.pgroup.page4.txtImporte.ReadOnly = .T.
Thisform.contenido.pgroup.page4.txtFecEmision.ReadOnly = .T.
Thisform.contenido.pgroup.page4.txtFecVto.ReadOnly = .T.

Thisform.contenido.pgroup.page4.txtImporte.blanquear()
Thisform.contenido.pgroup.page4.txtFecEmision.blanquear()
Thisform.contenido.pgroup.page4.txtFecVto.blanquear()
Thisform.contenido.pgroup.page4.txtNroCheque.blanquear()
Thisform.contenido.pgroup.page4.txtNroChequera.blanquear()
Thisform.contenido.pgroup.page4.cmbBancoCHP.SetFocus()


ENDPROC


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Número:"
Height = 15
Left = 561
Top = 53
Width = 51
TabIndex = 11
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: txtNroCheque
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 614
ReadOnly = .T.
TabIndex = 6
TabStop = .F.
Top = 48
Width = 123
ischaracter = .T.
Name = "txtNroCheque"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Nro. Chequera:"
Height = 15
Left = 16
Top = 77
Width = 85
TabIndex = 12
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: txtNroChequera
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 102
ReadOnly = .T.
TabIndex = 7
TabStop = .F.
Top = 73
Width = 89
ischaracter = .T.
isinteger = .T.
Name = "txtNroChequera"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta6
************************************************************
*** PROPIEDADES ***
Caption = "Total cheques propios:"
Height = 15
Left = 20
Top = 372
Width = 129
TabIndex = 4
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: txtImpTotCheqPro
************************************************************
*** PROPIEDADES ***
Left = 154
ReadOnly = .T.
TabIndex = 2
TabStop = .F.
Top = 368
isnumeric = .T.
Name = "txtImpTotCheqPro"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta7
************************************************************
*** PROPIEDADES ***
Caption = "Fecha Vto.:"
Height = 15
Left = 382
Top = 53
Width = 62
TabIndex = 14
Name = "Clsetiqueta7"

*** METODOS ***


************************************************************
OBJETO: txtFecVto
************************************************************
*** PROPIEDADES ***
Left = 446
TabIndex = 5
Top = 48
isdatetime = .T.
Name = "txtFecVto"

*** METODOS ***


************************************************************
OBJETO: btnEliminar
************************************************************
*** PROPIEDADES ***
Top = 47
Left = 791
Height = 40
Width = 40
Name = "btnEliminar"

*** METODOS ***
PROCEDURE Click
LOCAL lnTotChqP, lnResp

lnTotChqP = 0.00


&& Elimino el cheque de la orden de pago y la grilla
lnResp = MESSAGEBOX("¿Está seguro que desea eliminar este ítem?", 4+32, Thisform.Caption)

IF lnResp = 6 THEN
	SELECT chequesp
	&& Calculo los totales  
	lnTotChqP = Thisform.contenido.pgroup.page4.txtImpTotCheqPro.Value
	lnImporte = chequesp.importe
	Thisform.contenido.pgroup.page4.txtImpTotCheqPro.Value = lnTotChqP - lnImporte 

	Thisform.calcular()

	SELECT chequesp
	DELETE

	Thisform.contenido.pgroup.page4.grdChequesP.Refresh()
	Thisform.contenido.pgroup.page4.cmbBancoCHP.SetFocus()
ENDIF


*!*	Thisform.contenido.pgroup.page4.txtImporte.ReadOnly = .T.
*!*	Thisform.contenido.pgroup.page4.txtFecEmision.ReadOnly = .T.
*!*	Thisform.contenido.pgroup.page4.txtFecVto.ReadOnly = .T.

*!*	Thisform.contenido.pgroup.page4.txtImporte.blanquear()
*!*	Thisform.contenido.pgroup.page4.txtFecEmision.blanquear()
*!*	Thisform.contenido.pgroup.page4.txtFecVto.blanquear()
*!*	Thisform.contenido.pgroup.page4.txtNroCheque.blanquear()
*!*	Thisform.contenido.pgroup.page4.txtNroChequera.blanquear()

ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Banco:"
Height = 15
Left = 9
Top = 21
Width = 48
TabIndex = 10
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Transacción Nº:"
Height = 15
Left = 9
Top = 47
Width = 93
TabIndex = 11
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "DNI / CUIT / CUIL Originante:"
Height = 15
Left = 436
Top = 71
Width = 156
TabIndex = 13
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: txtNroTrans
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 100
MaxLength = 8
TabIndex = 2
Top = 43
Width = 147
ischaracter = .T.
autocompleta = .T.
Name = "txtNroTrans"

*** METODOS ***


************************************************************
OBJETO: txtOriginante
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 100
TabIndex = 4
Top = 68
Width = 329
ischaracter = .T.
autocompleta = .F.
Name = "txtOriginante"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta6
************************************************************
*** PROPIEDADES ***
Caption = "Importe:"
Height = 15
Left = 10
Top = 97
Width = 84
TabIndex = 15
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: btnAgregarDepo
************************************************************
*** PROPIEDADES ***
Top = 76
Left = 832
Height = 40
Width = 40
TabIndex = 7
Name = "btnAgregarDepo"

*** METODOS ***
PROCEDURE Click
LOCAL lnImpDepo, lnImporte

lnImpDepo = 0.00
lnImporte = 0.00

&& Valido
IF Thisform.contenido.pgroup.page5.cmbBanco.ListIndex = 0 THEN
	MESSAGEBOX("Debe seleccionar el banco", 0+48, Thisform.Caption)
	Thisform.contenido.pgroup.page5.cmbBanco.SetFocus()
	RETURN
ENDIF

IF ALLTRIM(Thisform.contenido.pgroup.page5.txtNroTrans.Value) == "" THEN
	MESSAGEBOX("Debe ingresar el número de transacción", 0+48, Thisform.Caption)
	Thisform.contenido.pgroup.page5.txtNroTrans.SetFocus()
	RETURN
ENDIF

IF Thisform.contenido.pgroup.page5.txtFecha.Value = {} THEN
	MESSAGEBOX("Debe ingresar la fecha de la transacción", 0+48, Thisform.Caption)
	Thisform.contenido.pgroup.page5.txtFecha.SetFocus()
	RETURN
ENDIF

IF ALLTRIM(Thisform.contenido.pgroup.page5.txtOriginante.Value) == "" THEN
	MESSAGEBOX("Debe ingresar el originante", 0+48, Thisform.Caption)
	Thisform.contenido.pgroup.page5.txtOriginante.SetFocus()
	RETURN
ENDIF

IF ALLTRIM(Thisform.contenido.pgroup.page5.txtDocumento.Value) == "" THEN
	MESSAGEBOX("Debe ingresar el número de DNI / CUIT / CUIL Originante", 0+48, Thisform.Caption)
	Thisform.contenido.pgroup.page5.txtDocumento.SetFocus()
	RETURN
ENDIF

IF Thisform.contenido.pgroup.page5.txtImporte.Value = 0 THEN
	MESSAGEBOX("Debe ingresar el importe del comprobante", 0+48, Thisform.Caption)
	Thisform.contenido.pgroup.page5.txtImporte.SetFocus()
	RETURN
ENDIF


SELECT bancos
GO TOP

GO Thisform.contenido.pgroup.page5.cmbBanco.ListIndex

IF !Thisform.orden_pago.agregar_deposito(bancos.idBanco, ;
	Thisform.contenido.pgroup.page5.txtNroTrans.Value,;
	Thisform.contenido.pgroup.page5.txtFecha.Value,;
	Thisform.contenido.pgroup.page5.txtOriginante.Value,;
	ALLTRIM(Thisform.contenido.pgroup.page5.txtDocumento.Value),;
	Thisform.contenido.pgroup.page5.txtImporte.Value) THEN
	
	MESSAGEBOX(Thisform.orden_pago.error_message, 0+48, Thisform.Caption)
ENDIF

Thisform.contenido.pgroup.page5.grdDepositos.Refresh()


&& Calculo los totales 
lnImpDepo = Thisform.contenido.pgroup.page5.txtImpTotDep.Value 
lnImporte = Thisform.contenido.pgroup.page5.txtImporte.Value 
Thisform.contenido.pgroup.page5.txtImpTotDep.Value = lnImpDepo + lnImporte 

Thisform.calcular()

Thisform.contenido.pgroup.page5.cmbBanco.ListIndex = 1
Thisform.contenido.pgroup.page5.txtNroTrans.blanquear()
Thisform.contenido.pgroup.page5.txtFecha.Value = DATE()
Thisform.contenido.pgroup.page5.txtOriginante.blanquear()
Thisform.contenido.pgroup.page5.txtDocumento.blanquear()
Thisform.contenido.pgroup.page5.txtImporte.blanquear()
Thisform.contenido.pgroup.page5.cmbBanco.SetFocus()


ENDPROC


************************************************************
OBJETO: grdDepositos
************************************************************
*** PROPIEDADES ***
Height = 241
Left = 9
TabIndex = 9
Top = 122
Width = 907
Name = "grdDepositos"
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


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Originante:"
Height = 15
Left = 9
Top = 71
Width = 93
TabIndex = 12
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Fecha Trans.:"
Height = 15
Left = 254
Top = 47
Width = 79
TabIndex = 14
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: txtFecha
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 331
TabIndex = 3
Top = 43
Width = 98
ischaracter = .F.
autocompleta = .F.
isdatetime = .T.
Name = "txtFecha"

*** METODOS ***


************************************************************
OBJETO: txtDocumento
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 590
TabIndex = 5
Top = 67
Width = 153
ischaracter = .T.
Name = "txtDocumento"

*** METODOS ***


************************************************************
OBJETO: txtImporte
************************************************************
*** PROPIEDADES ***
Left = 100
TabIndex = 6
Top = 93
isnumeric = .T.
Name = "txtImporte"

*** METODOS ***


************************************************************
OBJETO: cmbBanco
************************************************************
*** PROPIEDADES ***
Height = 22
Left = 100
TabIndex = 1
Top = 17
Width = 644
Name = "cmbBanco"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta7
************************************************************
*** PROPIEDADES ***
Caption = "Total depósitos:"
Height = 15
Left = 20
Top = 372
Width = 129
TabIndex = 4
Name = "Clsetiqueta7"

*** METODOS ***


************************************************************
OBJETO: txtImpTotDep
************************************************************
*** PROPIEDADES ***
Left = 118
ReadOnly = .T.
TabIndex = 2
TabStop = .F.
Top = 368
isnumeric = .T.
Name = "txtImpTotDep"

*** METODOS ***


************************************************************
OBJETO: btnEliminarDepo
************************************************************
*** PROPIEDADES ***
Top = 76
Left = 873
Height = 40
Width = 40
Name = "btnEliminarDepo"

*** METODOS ***
PROCEDURE Click
LOCAL lnTotDepo, lnResp

lnTotDepo = 0.00


&& Elimino el deposito de la orden de pago y la grilla
lnResp = MESSAGEBOX("¿Está seguro que desea eliminar este ítem?", 4+32, Thisform.Caption)

IF lnResp = 6 THEN
	SELECT deposito
	&& Calculo los totales  
	lnTotDepo = Thisform.contenido.pgroup.page5.txtImpTotDep.Value 
	lnImporte = deposito.importe
	Thisform.contenido.pgroup.page5.txtImpTotDep.Value = lnTotDepo - lnImporte 

	Thisform.calcular()

	SELECT deposito
	DELETE

	Thisform.contenido.pgroup.page5.grdDepositos.Refresh()
	Thisform.contenido.pgroup.page5.cmbBanco.SetFocus()
ENDIF


*!*	Thisform.contenido.pgroup.page5.cmbBanco.ListIndex = 1
*!*	Thisform.contenido.pgroup.page5.txtNroTrans.blanquear()
*!*	Thisform.contenido.pgroup.page5.txtFecha.Value = DATE()
*!*	Thisform.contenido.pgroup.page5.txtOriginante.blanquear()
*!*	Thisform.contenido.pgroup.page5.txtDocumento.blanquear()
*!*	Thisform.contenido.pgroup.page5.txtImporte.blanquear()
*!*	Thisform.contenido.pgroup.page5.cmbBanco.SetFocus()
ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "I.V.A.:"
Height = 15
Left = 11
Top = 16
Width = 84
TabIndex = 6
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Ingresos Brutos:"
Height = 15
Left = 11
Top = 42
Width = 97
TabIndex = 7
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Provincia:"
Height = 15
Left = 228
Top = 43
Width = 60
TabIndex = 8
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Ganancias:"
Height = 15
Left = 11
Top = 67
Width = 97
TabIndex = 9
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "SUSS:"
Height = 15
Left = 11
Top = 92
Width = 97
TabIndex = 10
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: txtIVA
************************************************************
*** PROPIEDADES ***
Left = 117
TabIndex = 1
Top = 13
isnumeric = .T.
Name = "txtIVA"

*** METODOS ***
PROCEDURE calcular
Thisform.calcular()
ENDPROC


************************************************************
OBJETO: txtIIBB
************************************************************
*** PROPIEDADES ***
Left = 117
TabIndex = 2
Top = 38
isnumeric = .T.
Name = "txtIIBB"

*** METODOS ***
PROCEDURE calcular
Thisform.calcular()
ENDPROC


************************************************************
OBJETO: cmbPcias
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 288
TabIndex = 3
Top = 38
Width = 380
Name = "cmbPcias"

*** METODOS ***


************************************************************
OBJETO: txtGanancias
************************************************************
*** PROPIEDADES ***
Left = 117
TabIndex = 4
Top = 63
isnumeric = .T.
Name = "txtGanancias"

*** METODOS ***
PROCEDURE calcular
Thisform.calcular()

ENDPROC


************************************************************
OBJETO: txtSUSS
************************************************************
*** PROPIEDADES ***
Left = 117
TabIndex = 5
Top = 88
isnumeric = .T.
Name = "txtSUSS"

*** METODOS ***
PROCEDURE calcular
Thisform.calcular()
ENDPROC


************************************************************
OBJETO: CLSETIQUETA1
************************************************************
*** PROPIEDADES ***
Caption = "Importe descuento financiero:"
Height = 15
Left = 23
Top = 23
Width = 172
Name = "CLSETIQUETA1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Importe descuento especiales:"
Height = 15
Left = 19
Top = 48
Width = 180
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: txtDtoFinanciero
************************************************************
*** PROPIEDADES ***
Left = 199
Top = 21
isnumeric = .T.
Name = "txtDtoFinanciero"

*** METODOS ***
PROCEDURE calcular
Thisform.calcular()
ENDPROC


************************************************************
OBJETO: txtDtoEspecial
************************************************************
*** PROPIEDADES ***
Left = 199
Top = 45
isnumeric = .T.
Name = "txtDtoEspecial"

*** METODOS ***
PROCEDURE calcular
Thisform.calcular()
ENDPROC


************************************************************
OBJETO: btnGrabar
************************************************************
*** PROPIEDADES ***
Top = 495
Left = 843
TabIndex = 5
Alignment = 2
Name = "btnGrabar"

*** METODOS ***
PROCEDURE Click
LOCAL loRes, lcSql

loRes = CREATEOBJECT("odbc_result")
lcSql = ""

&& Valido
IF !Thisform.validar_pago() THEN 
	RETURN .F.
ENDIF 

Thisform.orden_pago.blanquear_detalle()

SELECT efvo_cptos
GO Thisform.contenido.pgroup.page2.cmbConcepto.ListIndex

Thisform.orden_pago.importe = Thisform.contenido.txtImpOP.Value 


&& Paso 1: Si el importe de efectivo es distinto de cero entonces,
&& genero el registro de detalle correspondiente al pago en efectivo
IF Thisform.contenido.pgroup.page2.txtImporte.Value <> 0 THEN
	Thisform.orden_pago.agregar_detalle(0,;
		0, 'EFVO',Thisform.contenido.pgroup.page2.txtImporte.Value,;
		efvo_cptos.idPlanCta, 0, 0, 0, 0, 0, {}, {}, "", "", "")
ENDIF

&& Paso 2: Recorro el cursor de cheques y si hay cheques seleccionados
&& entonces genero el o los registros de detalle correspondiente a los
&& cheques seleccionados
SELECT cheq_disp
GO TOP
DO WHILE !EOF("cheq_disp")
	IF cheq_disp.sel THEN
		lcSql = "SELECT * FROM planctas WHERE esChqT = 1"
		loRes.ActiveConnection = goConn.ActiveConnection
		loRes.Cursor_Name = "cur_tempo"
		
		IF !loRes.OpenQuery(lcSql) THEN
			MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
			RETURN .F.
		ENDIF
	
		Thisform.orden_pago.agregar_detalle(0, 0, "CHEQ", cheq_disp.importe,;
			cur_tempo.idPlanCta, cheq_disp.idBanco, cheq_disp.idCheque, ;
			0, 0, 0, {}, {}, "", "", "")
			
		loRes.Close_Query()
	ENDIF

	SELECT cheq_disp
	SKIP
ENDDO

SELECT cheq_disp
GO TOP

&& Paso 3: Recorro el cursor de depósito y genero los registros que corresponden a depósitos y/o transferencias bancarias.
SELECT deposito
GO TOP
DO WHILE !EOF("deposito")
	Thisform.orden_pago.agregar_detalle(0, 0, "TRAN", deposito.importe, deposito.idPlanCta, ;
	deposito.idBanco, 0, 0, 0, 0, {}, deposito.fecTrans, ALLTRIM(deposito.nomOrig), ;
	ALLTRIM(deposito.docOrig), ALLTRIM(deposito.nroTrans))

	SELECT deposito
	SKIP
ENDDO

SELECT deposito
GO TOP

SELECT chequesp
GO TOP
DO WHILE !EOF("chequesp")
	Thisform.orden_pago.agregar_detalle(0, 0, 'CHEQP', chequesp.importe, ;
	chequesp.idPlanCta, chequesp.idBanco, 0, 0, 0, 0, {}, {}, "", "", "")

	SELECT chequesp
	SKIP
ENDDO

&& Ingreso la retencion de ganancias
IF Thisform.contenido.pgroup.page6.txtGanancias.Value <> 0 THEN
	lcSql = "SELECT * FROM planctas WHERE codAbr = 'RETDGAN'"
	loRes.ActiveConnection = goConn.ActiveConnection
	loRes.Cursor_Name = "cur_tempo"
	
	IF !loRes.OpenQuery(lcSql) THEN
		MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
		RETURN
	ENDIF
	
	SELECT cur_tempo
	GO TOP

	Thisform.orden_pago.agregar_detalle(0, 0, "RGAN", Thisform.contenido.pgroup.page6.txtGanancias.Value,;
	cur_tempo.idPlanCta, 0, 0, 0, 0, 0, {}, {}, "", "", "");
				
	loRes.Close_Query()
ENDIF

&& Ingreso la retencion de ingresos brutos
IF Thisform.contenido.pgroup.page6.txtIIBB.Value <> 0 THEN
	lcSql = "SELECT * FROM planctas WHERE codAbr = 'RETDIB'"
	loRes.ActiveConnection = goConn.ActiveConnection
	loRes.Cursor_Name = "cur_tempo"
	
	IF !loRes.OpenQuery(lcSql) THEN
		MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
		RETURN
	ENDIF
	
	SELECT cur_tempo
	GO TOP

	SELECT pcias
	GO Thisform.contenido.pgroup.page6.cmbPcias.ListIndex

	Thisform.orden_pago.agregar_detalle(0, 0, "RIB", Thisform.contenido.pgroup.page6.txtIIBB.Value, ;
	cur_tempo.idPlanCta, 0, 0, 0, pcias.idProvin, 0, {}, {}, "", "", "");
		
	loRes.Close_Query()
ENDIF

&& Ingreso la retencion de iva
IF Thisform.contenido.pgroup.page6.txtIVA.Value <> 0 THEN
	lcSql = "SELECT * FROM planctas WHERE codAbr = 'RETDIVA'"
	loRes.ActiveConnection = goConn.ActiveConnection
	loRes.Cursor_Name = "cur_tempo"
	
	IF !loRes.OpenQuery(lcSql) THEN
		MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
		RETURN
	ENDIF
	
	SELECT cur_tempo
	GO TOP

	Thisform.orden_pago.agregar_detalle(0, 0, "RIVA", Thisform.contenido.pgroup.page6.txtIVA.Value, ;
	cur_tempo.idPlanCta, 0, 0, 0, 0, 0, {}, {}, "", "", "");
		
	loRes.Close_Query()
ENDIF

&& Ingreso la retension de SUSS
IF Thisform.contenido.pgroup.page6.txtSUSS.Value <> 0 THEN
	lcSql = "SELECT * FROM planctas WHERE codAbr = 'RETDSUS'"
	loRes.ActiveConnection = goConn.ActiveConnection
	loRes.Cursor_Name = "cur_tempo"
	
	IF !loRes.OpenQuery(lcSql) THEN
		MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
		RETURN
	ENDIF
	
	SELECT cur_tempo
	GO TOP

	Thisform.orden_pago.agregar_detalle(0, 0, "RSUSS", Thisform.contenido.pgroup.page6.txtSUSS.Value, ;
		cur_tempo.idPlanCta, 0, 0, 0, 0, 0, {}, {}, "", "", "");
		
	loRes.Close_Query()
ENDIF

* Agrego el grabado de los descuentos financiero.
IF Thisform.contenido.pgroup.page7.txtDtoFinanciero.value <> 0 THEN
	lcSql = "SELECT * FROM planctas WHERE codAbr = 'DPP'"
	loRes.ActiveConnection = goConn.ActiveConnection
	loRes.Cursor_Name = "cur_tempo"
	loRes.OpenQuery(lcSql)
	SELECT cur_tempo
	GO TOP
	Thisform.orden_pago.Agregar_detalle(0, 0, cur_tempo.codAbr, Thisform.contenido.pgroup.page7.txtDtoFinanciero.value, ;
		cur_tempo.idPlanCta, 0, 0, 0, 0, 0, {}, {}, "", "", "")
	loRes.Close_Query()
ENDIF

* Agrego grabado de los descuentos especiales
IF Thisform.contenido.pgroup.page7.txtDtoEspecial.value <> 0 THEN
	lcSql = "SELECT * FROM planctas WHERE codAbr = 'DSCEO'"
	loRes.ActiveConnection = goConn.ActiveConnection
	loRes.Cursor_Name = "cur_tempo"
	loRes.OpenQuery(lcSql)
	SELECT cur_tempo
	GO TOP
	Thisform.orden_pago.Agregar_detalle(0, 0, cur_tempo.codAbr, Thisform.contenido.pgroup.page7.txtDtoEspecial.value, ;
		cur_tempo.idPlanCta, 0, 0, 0, 0, 0, {}, {}, "", "", "")
	loRes.Close_Query()	
ENDIF

IF !Thisform.orden_pago.grabar() THEN
	MESSAGEBOX(Thisform.orden_pago.error_message, 0+48, Thisform.Caption)
	RETURN
ENDIF

MESSAGEBOX("La orden de pago N° " + ALLTRIM(STR(Thisform.orden_pago.nroop)) + " se generó con éxito", 0+64, Thisform.Caption)

Thisform.imprimir()
Thisform.contenido.btnCancelar.Click()

ENDPROC


************************************************************
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 495
Left = 890
TabIndex = 6
Name = "btnCerrar"

*** METODOS ***


************************************************************
OBJETO: btnAceptar
************************************************************
*** PROPIEDADES ***
Top = 3
Left = 756
Height = 44
Width = 45
TabIndex = 3
Name = "btnAceptar"

*** METODOS ***
PROCEDURE Click
IF Thisform.contenido.sel_prov.valcpoid = 0 OR Thisform.contenido.sel_prov.txtCodigo.Value = 0 THEN
	MESSAGEBOX("Debe ingresar el proveedor", 0+48, Thisform.Caption)
	Thisform.contenido.sel_prov.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

IF Thisform.contenido.txtImpOP.Value = 0 THEN
	MESSAGEBOX("Debe ingresar el importe", 0+48, Thisform.Caption)
	Thisform.contenido.txtImpOP.SetFocus()
	RETURN .F.
ENDIF

Thisform.contenido.sel_prov.Enabled = .F.
Thisform.contenido.txtImpOP.Enabled = .F.

Thisform.orden_pago.leer_cheqdisp()
Thisform.Contenido.pgroup.page3.grdChequesDisp.Refresh()

Thisform.calcular()
Thisform.Contenido.pgroup.page1.grdComprobantes.SetFocus()

Thisform.cambiar_estado(.T.)
ENDPROC


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Saldo a imputar:"
Height = 15
Left = 13
Top = 477
Width = 94
TabIndex = 12
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: txtTotImputar
************************************************************
*** PROPIEDADES ***
Left = 104
ReadOnly = .T.
TabIndex = 6
TabStop = .F.
Top = 473
isnumeric = .T.
Name = "txtTotImputar"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Resta imputar:"
Height = 15
Left = 416
Top = 477
Width = 84
TabIndex = 11
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: txtResto
************************************************************
*** PROPIEDADES ***
Left = 503
ReadOnly = .T.
TabIndex = 7
TabStop = .F.
Top = 473
isnumeric = .T.
Name = "txtResto"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Total Ingresado:"
Height = 15
Left = 213
Top = 477
Width = 90
TabIndex = 13
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: txtTotalOP
************************************************************
*** PROPIEDADES ***
Left = 308
ReadOnly = .T.
TabIndex = 8
TabStop = .F.
Top = 473
isnumeric = .T.
Name = "txtTotalOP"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Anchor = 3
Caption = "Importe:"
Height = 15
Left = 586
Top = 19
Width = 60
TabIndex = 4
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: txtImpOP
************************************************************
*** PROPIEDADES ***
Anchor = 3
Left = 638
TabIndex = 2
Top = 15
isnumeric = .T.
Name = "txtImpOP"

*** METODOS ***


************************************************************
OBJETO: btnCancelar
************************************************************
*** PROPIEDADES ***
Top = 497
Left = 13
TabIndex = 7
Name = "btnCancelar"

*** METODOS ***
PROCEDURE Click
Thisform.orden_pago.blanquear()
Thisform.contenido.sel_prov.blanquear()
*Thisform.contenido.sel_prov.Enabled = .T.
Thisform.contenido.sel_prov.habilitar(.t.)
Thisform.contenido.txtImpOP.blanquear()
Thisform.contenido.txtImpOP.Enabled = .T.

&& Page 2
Thisform.contenido.pgroup.page2.txtImporte.blanquear()

&& Page 3
Thisform.contenido.pgroup.page3.grdChequesDisp.Refresh()
Thisform.contenido.pgroup.page3.txtImpTotCheq.blanquear()

&& Page 4
Thisform.contenido.pgroup.page4.cmbBancoCHP.ListIndex = 1
Thisform.contenido.pgroup.page4.txtImporte.ReadOnly = .T.
Thisform.contenido.pgroup.page4.txtFecEmision.ReadOnly = .T.
Thisform.contenido.pgroup.page4.txtFecVto.ReadOnly = .T.
Thisform.contenido.pgroup.page4.txtImporte.blanquear()
Thisform.contenido.pgroup.page4.txtFecEmision.blanquear()
Thisform.contenido.pgroup.page4.txtFecVto.blanquear()
Thisform.contenido.pgroup.page4.txtNroCheque.blanquear()
Thisform.contenido.pgroup.page4.txtNroChequera.blanquear()
Thisform.contenido.pgroup.page4.grdChequesP.Refresh()
Thisform.contenido.pgroup.page4.txtImpTotCheqPro.blanquear()

&& Page 5
Thisform.contenido.pgroup.page5.cmbBanco.ListIndex = 1
Thisform.contenido.pgroup.page5.txtNroTrans.blanquear()
Thisform.contenido.pgroup.page5.txtFecha.Value = DATE()
Thisform.contenido.pgroup.page5.txtOriginante.blanquear()
Thisform.contenido.pgroup.page5.txtDocumento.blanquear()
Thisform.contenido.pgroup.page5.txtImporte.blanquear()
Thisform.contenido.pgroup.page5.grdDepositos.Refresh()
Thisform.contenido.pgroup.page5.txtImpTotDep.blanquear()

&& Page 6
Thisform.contenido.pgroup.page6.txtGanancias.blanquear()
Thisform.contenido.pgroup.page6.txtIIBB.blanquear()
Thisform.contenido.pgroup.page6.txtIVA.blanquear()
Thisform.contenido.pgroup.page6.txtSUSS.blanquear()
Thisform.contenido.pgroup.page6.cmbPcias.ListIndex = 1

&& Totales
Thisform.contenido.txtTotImputar.blanquear()
Thisform.contenido.txtTotalOP.blanquear()
Thisform.contenido.txtResto.blanquear()

Thisform.contenido.pgroup.page1.SetFocus()
Thisform.contenido.sel_prov.txtCodigo.SetFocus()
Thisform.cambiar_estado(.F.)
ENDPROC


************************************************************
OBJETO: cls_frm_ordenpago
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_ctacte_prov
************************************************************
*** PROPIEDADES ***
Height = 533
Width = 1000
DoCreate = .T.
Caption = "Cuentas Corrientes de Proveedores"
MaxButton = .T.
MinButton = .T.
idsitiva = 0
idcondpago = 0
Name = "cls_ctacte_prov"
contenido.Anchor = 15
contenido.Top = -1
contenido.Left = -1
contenido.Width = 1002
contenido.Height = 574
contenido.Name = "contenido"

*** METODOS ***
PROCEDURE Init
Thisform.ctacte_pv.crear_cursor()

SELECT cc_pv
Thisform.Contenido.grdCtaCte.permitir_busqueda = .F.
Thisform.Contenido.grdCtaCte.permitir_ordenamiento = .F.
Thisform.Contenido.grdCtaCte.alias_name = "cc_pv"
Thisform.Contenido.grdCtaCte.RecordSource = "cc_pv"
Thisform.Contenido.grdCtaCte.list_controlsource = "sel,fecEmis,fecVto,nroCbte,impDebe,impHaber,saldo,observ,bandera"
Thisform.Contenido.grdCtaCte.lista_ancho_cols = "50,100,100,150,80,80,80,300,0"
Thisform.Contenido.grdCtaCte.titulos_cabeceras = "#,Fecha,Fecha Vto.,Comprobante,Debe,Haber,Saldo,Observaciones,#"
Thisform.Contenido.grdCtaCte.Columns[1].ReadOnly = .F.
Thisform.Contenido.grdCtaCte.Columns[9].Visible = .F.

Thisform.Contenido.grdCtaCte.SetAll("DynamicBackColor", "iif(cc_pv.bandera = 0, RGB(255,255,255), RGB(255,205,155))", "Column")
Thisform.Contenido.grdCtaCte.generar_grid()
ENDPROC
PROCEDURE validarcampos
IF Thisform.contenido.cntCabecera.selProv.valcpoid = 0 THEN 
	MESSAGEBOX("Debe seleccionar un proveedor primero", 0+48, this.Caption)
	Thisform.contenido.cntCabecera.selProv.SetFocus()
	RETURN .F.
ENDIF 

RETURN .T.

ENDPROC


************************************************************
OBJETO: ctacte_pv
************************************************************
*** PROPIEDADES ***
Top = 492
Left = 264
Height = 17
Width = 24
Name = "ctacte_pv"

*** METODOS ***


************************************************************
OBJETO: cntCabecera
************************************************************
*** PROPIEDADES ***
Anchor = 11
Top = 5
Left = 6
Width = 991
Height = 80
BackStyle = 1
BackColor = 237,218,205
Name = "cntCabecera"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Proveedor:"
Height = 15
Left = 9
Top = 9
Width = 72
TabIndex = 4
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: selProv
************************************************************
*** PROPIEDADES ***
Top = 3
Left = 91
Width = 487
Height = 25
TabIndex = 1
autocompletar_ceros = .F.
nombre_campo_codigo = idProv
nombre_campo_desc = razSoc
nombre_tabla = proveedor
pkfield = idProv
esnumerico = .T.
Name = "selProv"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***
PROCEDURE recuperar_datos
LOCAL loRes
LOCAL lcSql

loRes = CREATEOBJECT("odbc_result")
lcSql = ""

lcSql = "SELECT * FROM sitiva WHERE idSitIVA = " + ALLTRIM(STR(proveedor.idSitIVA))
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_temp"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN
ENDIF

This.Parent.txtSitIVA.Value = ALLTRIM(cur_temp.descripcio)
Thisform.idSitIVA = cur_temp.idSitIVA

loRes.Close_Query()

lcSql = "SELECT * FROM condpagos WHERE idCondPago = " + ALLTRIM(STR(proveedor.idCondPago))
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_temp"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN
ENDIF

This.Parent.txtCondPago.Value = ALLTRIM(cur_temp.descripcio)
Thisform.idCondPago = cur_temp.idCondPago

loRes.Close_Query()

This.Parent.txtNroCUIT.Value = ALLTRIM(proveedor.nroCUIT)

*!*	Thisform.ctacte_pv.leer_ctacte(Thisform.Contenido.cntCabecera.selProv.valcpoid)
*!*	Thisform.contenido.txtsaldo.Value = Thisform.ctacte_pv.saldo_total
*!*	Thisform.Contenido.grdCtaCte.Refresh()
*!*	Thisform.Contenido.grdCtaCte.SetFocus()
ENDPROC


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Situación IVA:"
Height = 15
Left = 9
Top = 33
Width = 87
TabIndex = 5
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: txtSitIVA
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 93
ReadOnly = .F.
TabIndex = 6
Top = 29
Width = 277
Name = "txtSitIVA"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Nro. CUIT:"
Height = 15
Left = 9
Top = 58
Width = 87
TabIndex = 7
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: txtNroCUIT
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 93
ReadOnly = .F.
TabIndex = 8
Top = 53
Width = 159
Name = "txtNroCUIT"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Cond. Pago:"
Height = 15
Left = 392
Top = 35
Width = 87
TabIndex = 9
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: txtCondPago
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 466
ReadOnly = .F.
TabIndex = 10
Top = 31
Width = 250
Name = "txtCondPago"

*** METODOS ***


************************************************************
OBJETO: btn_aceptar
************************************************************
*** PROPIEDADES ***
Top = 31
Left = 881
Height = 45
Width = 53
TabIndex = 2
Name = "btn_aceptar"

*** METODOS ***
PROCEDURE Click
IF !Thisform.validarcampos() THEN
	* Si los datos no son validos corto la ejecucion
	RETURN
ENDIF

Thisform.ctacte_pv.leer_ctacte(Thisform.Contenido.cntCabecera.selProv.valcpoid)
Thisform.contenido.txtsaldo.Value = Thisform.ctacte_pv.saldo_total
SELECT cc_pv

IF RECCOUNT("cc_pv") = 0 THEN
	MESSAGEBOX("No hay registros para mostrar", 0+64, Thisform.Caption)
	RETURN
ENDIF

Thisform.Contenido.grdCtaCte.Refresh()
Thisform.Contenido.grdCtaCte.SetFocus()
ENDPROC


************************************************************
OBJETO: btn_cancelar
************************************************************
*** PROPIEDADES ***
Top = 31
Left = 934
Height = 45
Width = 52
TabIndex = 3
Name = "btn_cancelar"

*** METODOS ***
PROCEDURE Click
* Limpio el cursor
SELECT cc_pv
ZAP

* Blanqueamos los controles
This.Parent.selProv.blanquear()
This.Parent.txtNroCUIT.Value = ""
this.Parent.txtCondPago.Value = ""
this.Parent.txtSitIVA.Value = ""

this.Parent.selprov.txtCodigo.SetFocus()
ENDPROC


************************************************************
OBJETO: grdCtaCte
************************************************************
*** PROPIEDADES ***
Anchor = 15
Height = 394
Left = 5
Top = 88
Width = 992
Name = "grdCtaCte"
COLUMN1.Header1.Name = "Header1"
COLUMN1.Text1.Alignment = 2
COLUMN1.Text1.ReadOnly = .F.
COLUMN1.Text1.Name = "Text1"
COLUMN1.Alignment = 2
COLUMN1.CurrentControl = "Clscheckbox1"
COLUMN1.ReadOnly = .F.
COLUMN1.Sparse = .F.
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


************************************************************
OBJETO: Clscheckbox1
************************************************************
*** PROPIEDADES ***
Top = 23
Left = 57
Alignment = 0
Centered = .T.
Caption = ""
Name = "Clscheckbox1"

*** METODOS ***


************************************************************
OBJETO: CLSCERRAR1
************************************************************
*** PROPIEDADES ***
Top = 487
Left = 952
Anchor = 12
Name = "CLSCERRAR1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
FontSize = 10
Caption = "Saldo:"
Height = 15
Left = 592
Top = 13
Width = 55
ForeColor = 255,0,0
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: txtsaldo
************************************************************
*** PROPIEDADES ***
FontSize = 10
FontUnderline = .F.
Enabled = .F.
Height = 26
Left = 645
Top = 7
Width = 164
ForeColor = 255,0,0
isnumeric = .T.
Name = "txtsaldo"

*** METODOS ***


************************************************************
OBJETO: btnAjuste
************************************************************
*** PROPIEDADES ***
Top = 487
Left = 11
Height = 42
Width = 106
FontBold = .T.
Anchor = 6
Caption = "\<Ajustes"
Name = "btnAjuste"

*** METODOS ***
PROCEDURE Click
LOCAL loForm

SELECT *;
FROM cc_pv ;
WHERE cc_pv.sel = .T. ;
INTO CURSOR cur_SelCta

SELECT cur_SelCta
IF RECCOUNT("cur_SelCta") > 1 THEN
	MESSAGEBOX("No puede seleccionar más de un comprobante", 0+48, Thisform.Caption)
	SELECT cc_pv
	UPDATE cc_pv SET sel = .F.
	GO TOP
	USE IN cur_SelCta
	Thisform.contenido.grdCtaCte.Refresh()
	Thisform.contenido.grdCtaCte.SetFocus()
	RETURN .F.
ENDIF

loForm = CREATEOBJECT("cls_ajuste_ccprov")

IF RECCOUNT("cur_SelCta") > 0 THEN
	lcCbte = GETWORDNUM(cur_SelCta.nroCbte, 1, " ")
	lcTipoDoc = GETWORDNUM(cur_SelCta.nroCbte, 2, " ")
	lcNumCbte = GETWORDNUM(cur_SelCta.nroCbte, 3, " ")
	loForm.cbte = lcCbte
	loForm.ptoVta = ALLTRIM(GETWORDNUM(lcNumCbte, 1, "-"))
	loForm.nroCbte = ALLTRIM(GETWORDNUM(lcNumCbte, 2, "-"))
	loForm.tipoDoc = ALLTRIM(lcTipoDoc)
	loForm.idOperacion = cur_SelCta.idOper
	loForm.idCC_Prov = cur_SelCta.idCC_Prov
	&&loForm.recuperar()
	loForm.importe = IIF(cur_SelCta.impDebe <> 0, cur_SelCta.impDebe, cur_SelCta.impHaber)
ELSE
	loForm.cbte = ""
	loForm.idCC_Prov = 0
	&&loForm.leer_saldo_prov()
	loForm.importe = 0.00
ENDIF

loForm.idSitIVA = Thisform.idSitIVA
loForm.idCondPago = Thisform.idCondPago
loForm.idProv = Thisform.Contenido.cntCabecera.selProv.valcpoid
loForm.Show()

Thisform.ctacte_pv.leer_ctacte(Thisform.Contenido.cntCabecera.selProv.valcpoid)
Thisform.Contenido.grdCtaCte.Refresh()	

USE IN cur_SelCta

RETURN .T.
ENDPROC


************************************************************
OBJETO: btnCompensar
************************************************************
*** PROPIEDADES ***
Top = 488
Left = 120
Height = 42
Width = 106
FontBold = .T.
Anchor = 6
Caption = "\<Saldos a Favor"
Name = "btnCompensar"

*** METODOS ***
PROCEDURE Click
LOCAL loForm

&& Valido que no haya notas de créditos, ajustes o ordenes de pago.
SELECT cc_pv
IF RECCOUNT("cc_pv") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cc_pv")
	IF cc_pv.sel THEN
		IF SUBSTR(cc_pv.nroCbte, 1, 2) == "NC" .OR. ;
				SUBSTR(cc_pv.nroCbte, 1, 2) == "ACP" .OR.  ;
				SUBSTR(cc_pv.nroCbte, 1, 2) == "OP" THEN
				
			MESSAGEBOX("No puede seleccionar NC, ACP y/o OP para compensar", 0+48, Thisform.Caption)
			RETURN .F.
		ENDIF
	ENDIF

	SELECT cc_pv
	SKIP
ENDDO

loForm = CREATEOBJECT("cls_saldo_a_favor_prov")
loForm.idProv = Thisform.contenido.cntCabecera.selProv.valcpoid
loForm.idCompraC = cc_pv.idCompraC
loForm.idCC_Prov = cc_pv.idCC_Prov
IF !loForm.cargar() THEN
	loForm.release()
	RETURN .F.
ENDIF

loForm.show()
Thisform.ctacte_pv.leer_ctacte(Thisform.Contenido.cntCabecera.selProv.valcpoid)
Thisform.Contenido.grdCtaCte.Refresh()
Thisform.Contenido.grdCtaCte.SetFocus()

RETURN .T.
ENDPROC


************************************************************
OBJETO: cls_ctacte_prov
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 10, 6, 16, 13, 34, 3, 0
Arial, 1, 9, 6, 15, 12, 32, 3, 0

*** METODOS ***


