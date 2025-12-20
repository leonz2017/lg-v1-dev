************************************************************
OBJETO: cls_saldo_a_favor
************************************************************
*** PROPIEDADES ***
BorderStyle = 1
Height = 515
Width = 875
DoCreate = .T.
Caption = "Compensación de saldo a favor"
idcliente = 0
idventasc = 0
idcc_cli = 0
Name = "cls_saldo_a_favor"

*** METODOS ***
PROCEDURE cargar
LOCAL loResult, lcSql, lnIdVentasC

loResult = CREATEOBJECT("odbc_result")
lcSql = ""
lnidVentasC = Thisform.idVentasC

DODEFAULT()

lcSql = "SELECT * FROM VentasCab WHERE idVentasC = " + ALLTRIM(STR(lnIdVentasC))
loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_Fact"
loResult.OpenQuery(lcSql)

SELECT cur_Fact
IF !EOF("cur_Fact")
	Thisform.txtNroFact.Value = ALLTRIM(cur_Fact.tipoDoc) + " " + ;
		REPLICATE("0", 4 - LEN(ALLTRIM(STR(cur_Fact.ptoVta)))) + ALLTRIM(STR(cur_Fact.ptoVta)) + ;
		REPLICATE("0", 8 - LEN(ALLTRIM(STR(cur_Fact.numCbte)))) + ALLTRIM(STR(cur_Fact.numCbte))
	Thisform.txtImpFact.Value = cur_Fact.totFact
	Thisform.txtImpSaldo.Value = cur_Fact.saldo	
	Thisform.CntTotales.txtResto.Value = cur_Fact.saldo
	Thisform.CntTotales.txtSaldoCompensar.Value = cur_Fact.saldo
ENDIF

loResult.Close_Query()

&& Levanto los comprobantes disponible para utilizar en la
&& compensación

lcSql = "SELECT		idCC_Cli, "
lcSql = lcSql + "	idCliente, "
lcSql = lcSql + "	fecEmis, "
lcSql = lcSql + "	cbte, "
lcSql = lcSql + "	tipoDoc, "
lcSql = lcSql + "	ptoVta, "
lcSql = lcSql + "	nroCbte, "
lcSql = lcSql + "	impHaber "
lcSql = lcSql + "FROM	cc_cli "
lcSql = lcSql + "WHERE	Cbte IN ('NC', 'RC') "
lcSql = lcSql + "	AND idOper = 0 "
lcSql = lcSql + "	AND idCliente = " + ALLTRIM(STR(Thisform.idcliente))

loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "tmp_cbtes"
loResult.OpenQuery(lcSql)

SELECT tmp_cbtes
DO WHILE !EOF("tmp_cbtes")
	SELECT cur_CbteDisp	
	APPEND BLANK
	REPLACE marcado WITH .F.
	REPLACE idCC_Cli WITH tmp_cbtes.idCC_Cli ADDITIVE
	REPLACE fecEmis WITH tmp_cbtes.fecEmis ADDITIVE
	REPLACE cbte WITH tmp_cbtes.cbte ADDITIVE
	REPLACE tipoDoc WITH tmp_cbtes.tipoDoc ADDITIVE
	REPLACE ptoVta WITH REPLICATE("0", 4 - LEN(ALLTRIM(STR(tmp_cbtes.ptoVta)))) + ALLTRIM(STR(tmp_cbtes.ptoVta)) ADDITIVE
	REPLACE numCbte WITH REPLICATE("0", 8 - LEN(ALLTRIM(STR(tmp_cbtes.nroCbte)))) + ALLTRIM(STR(tmp_cbtes.nroCbte)) ADDITIVE
	REPLACE importe WITH tmp_cbtes.impHaber ADDITIVE
	
	SELECT tmp_cbtes
	SKIP
ENDDO

loResult.Close_Query()

SELECT cur_CbteDisp
IF RECCOUNT("cur_CbteDisp") > 0 THEN
	GO TOP
ENDIF

Thisform.grdCbteDisp.Refresh()
ENDPROC
PROCEDURE sumar_ncrc
LOCAL lnTotal
LOCAL lnPosAnt

lnTotal = 0.00
lnPosAnt = 0

SELECT cur_CbteDisp
IF RECCOUNT("cur_CbteDisp") > 0 THEN
	lnPosAnt = RECNO("cur_CbteDisp")
	GO TOP
ENDIF

DO WHILE !EOF("cur_CbteDisp")
	IF cur_CbteDisp.marcado THEN
		lnTotal = lnTotal + cur_CbteDisp.importe
	ENDIF

	SELECT cur_CbteDisp
	SKIP
ENDDO

SELECT cur_CbteDisp
IF RECCOUNT("cur_CbteDisp") > 0 THEN
	GO TOP
	SKIP lnPosAnt
	Thisform.grdCbteDisp.Refresh()
ENDIF

RETURN lnTotal
ENDPROC
PROCEDURE validar_importes
LOCAL lnTotAComp
LOCAL lnTotDisp

lnTotAComp = 0
lnTotDisp = 0

&& Calculo el importe total de las facturas seleccionadas para compensar
SELECT cur_CbteAComp
IF RECCOUNT("cur_CbteAComp") > 0 THEN
	GO TOP
ENDIF

SELECT cur_CbteAComp
DO WHILE !EOF("cur_CbteAComp")
	lnTotAComp = lnTotAComp + cur_CbteAComp.saldo

	SELECT cur_CbteAComp
	SKIP
ENDDO

IF RECCOUNT("cur_CbteAComp") > 0 THEN
	GO TOP
ENDIF

&& Calculo el importe total disponible para compensar
SELECT cur_CbteDisp
IF RECCOUNT("cur_CbteDisp") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_CbteDisp")
	lnTotDisp = lnTotDisp + cur_CbteDisp.importe

	SELECT cur_CbteDisp
	SKIP
ENDDO

IF RECCOUNT("cur_CbteDisp") > 0 THEN
	GO TOP
ENDIF

IF lnTotAComp > lnTotDisp THEN
	MESSAGEBOX("El importe total de las facturas seleccionadas no puede superar el importe disponible para compensar", 0+64, Thisform.Caption)
	RETURN .F.
ENDIF

RETURN .T.
ENDPROC
PROCEDURE Init


DODEFAULT()

&& Asigno los comprobantes disponible a la grilla
SELECT cur_CbteDisp
Thisform.grdCbteDisp.RecordSource = "cur_CbteDisp"
Thisform.grdCbteDisp.list_controlsource = "marcado,fecEmis,cbte,tipoDoc,ptoVta,numCbte,importe"
Thisform.grdCbteDisp.lista_ancho_cols = "70,250,70,70,70,100,100"
Thisform.grdCbteDisp.titulos_cabeceras = "Sel.,Fecha,Comp.,Tipo,Pto. Vta.,Número,Importe"
Thisform.grdCbteDisp.Columns[3].Alignment = 2
Thisform.grdCbteDisp.generar_grid()

ENDPROC
PROCEDURE Load
DODEFAULT()

CREATE CURSOR cur_CbteDisp (	;
	marcado		l,;
	idCC_Cli	int,;
	fecEmis		datetime,;
	cbte		varchar(3),;
	tipoDoc		varchar(1),;
	ptoVta		varchar(4),;
	numCbte		varchar(8),;
	importe		float(10, 2))
	

ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Datos de la Factura"
Height = 15
Left = 6
Top = 5
Width = 107
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: grdCbteDisp
************************************************************
*** PROPIEDADES ***
Height = 333
Left = 5
Top = 85
Width = 865
Name = "grdCbteDisp"
COLUMN1.Header1.Name = "Header1"
COLUMN1.Text1.Alignment = 2
COLUMN1.Text1.ReadOnly = .F.
COLUMN1.Text1.Name = "Text1"
COLUMN1.Alignment = 6
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
PROCEDURE AfterRowColChange
LPARAMETERS nColIndex

ENDPROC


************************************************************
OBJETO: Clscheckbox1
************************************************************
*** PROPIEDADES ***
Top = 35
Left = 37
Alignment = 0
Centered = .T.
Caption = ""
ReadOnly = .F.
Name = "Clscheckbox1"

*** METODOS ***
PROCEDURE InteractiveChange
IF this.Value THEN
	SELECT cur_CbteDisp
	Thisform.cntTotales.txtSalDisp.Value = Thisform.cntTotales.txtSalDisp.Value + cur_CbteDisp.importe
	Thisform.cntTotales.txtResto.Value = Thisform.cntTotales.txtSaldoCompensar.Value - Thisform.cntTotales.txtSalDisp.Value
ELSE
	SELECT cur_CbteDisp
	Thisform.cntTotales.txtSalDisp.Value = Thisform.cntTotales.txtSalDisp.Value - cur_CbteDisp.importe
	Thisform.cntTotales.txtResto.Value = Thisform.cntTotales.txtSaldoCompensar.Value - Thisform.cntTotales.txtSalDisp.Value
ENDIF

ENDPROC


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Seleccione los comprobantes para aplicar la factura"
Height = 15
Left = 6
Top = 66
Width = 359
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: cntTotales
************************************************************
*** PROPIEDADES ***
Top = 420
Left = 5
Width = 865
Height = 48
BackStyle = 1
Name = "cntTotales"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Saldo a Compensar"
Height = 15
Left = 13
Top = 5
Width = 119
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: txtSaldoCompensar
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Left = 14
Top = 22
isnumeric = .T.
Name = "txtSaldoCompensar"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Saldo Seleccionado"
Height = 15
Left = 175
Top = 5
Width = 119
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: txtSalDisp
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Left = 178
Top = 22
isnumeric = .T.
Name = "txtSalDisp"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Resto:"
Height = 15
Left = 325
Top = 5
Width = 58
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: txtResto
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Left = 325
Top = 22
isnumeric = .T.
Name = "txtResto"

*** METODOS ***


************************************************************
OBJETO: btnGrabar
************************************************************
*** PROPIEDADES ***
Top = 472
Left = 778
Height = 44
Width = 45
Alignment = 0
Name = "btnGrabar"

*** METODOS ***
PROCEDURE Click
LOCAL loCommand, lcSql, loResult, lnIdCC_Cli, lnIdOperacion, lnIdVentasC, lnSaldoFC, lnCont, lnResto
LOCAL lnProxId, loDT

&& Valido la compensación
IF Thisform.cntTotales.txtResto.Value > Thisform.cntTotales.txtSaldoCompensar.Value THEN
	MESSAGEBOX("La suma de los comprobantes seleccionado no puede ser mayor al saldo a compensar", 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

lnCont = 0
SELECT cur_CbteDisp
IF RECCOUNT("cur_CbteDisp") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_CbteDisp")
	IF cur_CbteDisp.marcado THEN
		lnCont = lnCont + 1
	ENDIF
	
	SELECT cur_CbteDisp
	SKIP
ENDDO

IF lnCont = 0 THEN
	MESSAGEBOX("Debe seleccionar al menos un comprobante", 0+48, Thisform.Caption)
	SELECT cur_CbteDisp

	IF RECCOUNT("cur_CbteDisp") > 0 THEN
		GO TOP
	ENDIF

	Thisform.grdCbteDisp.SetFocus()
	RETURN .F.
ENDIF

SELECT cur_CbteDisp
IF RECCOUNT("cur_CbteDisp") > 0 THEN
	GO TOP
ENDIF

loDT = CREATEOBJECT("datetime")
loCommand = CREATEOBJECT("odbc_command")
loResult = CREATEOBJECT("odbc_result")
lcSql = ""									&& Comando SQL a ejecutar
lnIdCC_Cli = Thisform.idcc_cli				&& Id. de Cuenta Corriente de Origen
lnIdVentasC = Thisform.idVentasC			&& Id. de Comprobante de Venta Seleccionado
lnIdOperacion = 0							&& Numero de operación a asignar
lnSaldoFC = 0								&& Saldo nuevo que quedó en la factura

&& Levanto el id operacion
lcSql = "SELECT * FROM cc_cli WHERE idCC_Cli = " + ALLTRIM(STR(lnIdCC_Cli)) + " AND idVentasC = " + ALLTRIM(STR(lnIdVentasC))
loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_X"
loResult.OpenQuery(lcSql)

SELECT cur_X
IF cur_X.idOper <> 0 THEN
	lnIdOperacion = cur_X.idOper
ENDIF

loResult.Close_Query()

IF lnIdOperacion = 0 THEN
	lcSql = "SELECT MAX(idOper) AS maxOper FROM cc_Cli"
	loResult.ActiveConnection = goConn.ActiveConnection
	loResult.Cursor_Name = "cur_X"
	loResult.OpenQuery(lcSql)
	
	SELECT cur_X
	lnIdOperacion = cur_X.maxOper + 1
	
	loResult.Close_Query()
ENDIF

goConn.BeginTransaction()

SELECT cur_CbteDisp
IF RECCOUNT("cur_CbteDisp") > 0 THEN
	GO TOP
ENDIF

&& Asigno el Id. Operacion de los comprobantes que estan marcados
DO WHILE !EOF("cur_CbteDisp")
	IF cur_CbteDisp.marcado THEN
		lcSql = "UPDATE cc_cli SET idOper = " + ALLTRIM(STR(lnIdOperacion)) + " WHERE idCC_Cli = " + ALLTRIM(STR(cur_CbteDisp.idCC_Cli))
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			RETURN .F.
		ENDIF
	ENDIF

	SELECT cur_CbteDisp
	SKIP
ENDDO

&& Ahora asigno el Id. Operacion del comprobante factura seleccionada
lcSql = "UPDATE cc_cli SET idOper = " + ALLTRIM(STR(lnIdOperacion)) + " WHERE idCC_Cli = " + ALLTRIM(STR(lnIdCC_Cli))
loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = lcSql

IF !loCommand.Execute() THEN
	goConn.Rollback()
	RETURN .F.
ENDIF

lnSaldoFC = Thisform.CntTotales.txtResto.Value

IF Thisform.CntTotales.txtResto.Value < 0 THEN
	lnSaldoFC = 0
ENDIF

lcSql = "UPDATE ventascab SET saldo = " + ALLTRIM(STR(lnSaldoFC, 10, 2)) + " WHERE idVentasC = " + ALLTRIM(STR(lnIdVentasC))
loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = lcSql

IF !loCommand.Execute() THEN
	goConn.Rollback()
	RETURN .F.
ENDIF

&& Si el resto es negativo significa que el monto del RC/NC supera el monto de la FC ac compensar, entonces
&& corresponde generar un registro con el restante
IF (Thisform.cntTotales.txtResto.Value < 0) THEN
	SELECT cur_CbteDisp
	IF RECCOUNT("cur_CbteDisp") > 0 THEN
		GO TOP
	ENDIF

	lnResto = Thisform.txtImpSaldo.Value
	SELECT cur_CbteDisp
	DO WHILE !EOF("cur_CbteDisp")
		lnResto = lnResto  - cur_CbteDisp.importe
		
		IF lnResto < 0 THEN
				lnProxId = goConn.GetNextID("cc_cli", "idCC_Cli")
				lcSql = "INSERT INTO cc_cli ( idCC_Cli, idCliente, cbte, tipoDoc, ptoVta, nroCbte, fecEmis, impDebe, impHaber, idOPer) VALUES ("
				lcSql = lcSql + ALLTRIM(STR(lnProxId)) + ", " + ALLTRIM(STR(Thisform.idCliente)) + ", "
				lcSql = lcSql + "'" + ALLTRIM(cur_CbteDisp.cbte) + "', '" + ALLTRIM(cur_CbteDisp.TipoDoc) + "', " + ALLTRIM(cur_CbteDisp.ptoVta) + ", "
				lcSql = lcSql + ALLTRIM(cur_CbteDisp.numCbte) + ", " + loDT.toMySql(cur_CbteDisp.fecEmis) + ", 0, " + ALLTRIM(STR(Thisform.CntTotales.txtResto.Value * (-1), 10, 2)) + ", 0)"
				
				loCommand.ActiveConnection = goConn.ActiveConnection
				loCommand.CommandText = lcSql
				
				IF !loCommand.Execute()
					goConn.Rollback()
					RETURN .F.
				ENDIF
		ENDIF			
	
		SELECT cur_CbteDisp
		SKIP
	ENDDO	
ENDIF

goConn.Commit()
MESSAGEBOX("La compensación ha sido generada con éxito", 0+64, Thisform.Caption)
Thisform.Release()

RETURN .T.
ENDPROC


************************************************************
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 472
Left = 826
Height = 44
Width = 45
Alignment = 0
Name = "btnCerrar"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Nro. de Factura:"
Height = 15
Left = 29
Top = 33
Width = 96
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Importe Factura:"
Height = 15
Left = 313
Top = 33
Width = 96
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Saldo:"
Height = 15
Left = 574
Top = 33
Width = 60
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: txtNroFact
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 122
Top = 29
Width = 168
Name = "txtNroFact"

*** METODOS ***


************************************************************
OBJETO: txtImpFact
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 410
Top = 29
Width = 123
Name = "txtImpFact"

*** METODOS ***


************************************************************
OBJETO: txtImpSaldo
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 616
Top = 29
Width = 123
Name = "txtImpSaldo"

*** METODOS ***


************************************************************
OBJETO: CLSLINEA1
************************************************************
*** PROPIEDADES ***
Height = 0
Left = 7
Top = 58
Width = 863
Name = "CLSLINEA1"

*** METODOS ***


************************************************************
OBJETO: cls_saldo_a_favor
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_cbtes_m2
************************************************************
*** PROPIEDADES ***
DoCreate = .T.
cerrar_cbte = .F.
Name = "cls_cbtes_m2"
contenido.Clsetiqueta1.Name = "Clsetiqueta1"
contenido.sel_Cliente.txtCodigo.Name = "txtCodigo"
contenido.sel_Cliente.txtDescripcion.Name = "txtDescripcion"
contenido.sel_Cliente.Name = "sel_Cliente"
contenido.Clsetiqueta2.Name = "Clsetiqueta2"
contenido.Clsetiqueta3.Name = "Clsetiqueta3"
contenido.txtSitIVA.Name = "txtSitIVA"
contenido.sel_FormaPago.txtCodigo.Name = "txtCodigo"
contenido.sel_FormaPago.txtDescripcion.Name = "txtDescripcion"
contenido.sel_FormaPago.Name = "sel_FormaPago"
contenido.Clslinea1.Name = "Clslinea1"
contenido.Clsetiqueta6.Name = "Clsetiqueta6"
contenido.Clsetiqueta7.Name = "Clsetiqueta7"
contenido.Clsetiqueta8.Name = "Clsetiqueta8"
contenido.Clsetiqueta9.Name = "Clsetiqueta9"
contenido.txtTotNeto.Name = "txtTotNeto"
contenido.txtPorIVA21.Name = "txtPorIVA21"
contenido.txtPorIVA105.Name = "txtPorIVA105"
contenido.txtImpIVA21.Name = "txtImpIVA21"
contenido.txtImpIVA105.Name = "txtImpIVA105"
contenido.txtTotal.Name = "txtTotal"
contenido.btnGrabar.Top = 515
contenido.btnGrabar.Left = 929
contenido.btnGrabar.Height = 44
contenido.btnGrabar.Name = "btnGrabar"
contenido.btnCancelar.Top = 513
contenido.btnCancelar.Left = 5
contenido.btnCancelar.Height = 44
contenido.btnCancelar.Name = "btnCancelar"
contenido.Clscerrar1.Top = 515
contenido.Clscerrar1.Left = 977
contenido.Clscerrar1.Height = 44
contenido.Clscerrar1.Visible = .T.
contenido.Clscerrar1.Name = "Clscerrar1"
contenido.Clsetiqueta14.Name = "Clsetiqueta14"
contenido.txtDesc1.Name = "txtDesc1"
contenido.txtDesc2.Name = "txtDesc2"
contenido.txtDesc3.Name = "txtDesc3"
contenido.txtDesc4.Name = "txtDesc4"
contenido.txtImpDesc1.Name = "txtImpDesc1"
contenido.txtImpDesc2.Name = "txtImpDesc2"
contenido.txtImpDesc3.Name = "txtImpDesc3"
contenido.txtImpDesc4.Name = "txtImpDesc4"
contenido.Clsetiqueta15.Name = "Clsetiqueta15"
contenido.Clsetiqueta16.Name = "Clsetiqueta16"
contenido.Clsetiqueta17.Name = "Clsetiqueta17"
contenido.txtTotFact.Name = "txtTotFact"
contenido.chkImprimeDup.Alignment = 0
contenido.chkImprimeDup.Name = "chkImprimeDup"
contenido.BTNCBTEORIGEN.Name = "BTNCBTEORIGEN"
contenido.TXTOBSERV.Name = "TXTOBSERV"
contenido.Clsetiqueta18.Name = "Clsetiqueta18"
contenido.txtPorIIBB.Name = "txtPorIIBB"
contenido.txtImpIIBB.Name = "txtImpIIBB"
contenido.Clsetiqueta19.Name = "Clsetiqueta19"
contenido.txtST.Name = "txtST"
contenido.Clsetiqueta4.Name = "Clsetiqueta4"
contenido.sel_Articulo.txtCodigo.Name = "txtCodigo"
contenido.sel_Articulo.txtDescripcion.Name = "txtDescripcion"
contenido.sel_Articulo.Name = "sel_Articulo"
contenido.Clsetiqueta5.Name = "Clsetiqueta5"
contenido.txtCantidad.Name = "txtCantidad"
contenido.btnAgregar.Top = 164
contenido.btnAgregar.Left = 930
contenido.btnAgregar.Height = 44
contenido.btnAgregar.Width = 45
contenido.btnAgregar.Name = "btnAgregar"
contenido.Clsetiqueta10.Name = "Clsetiqueta10"
contenido.txtPrMay.Name = "txtPrMay"
contenido.Clsetiqueta11.Name = "Clsetiqueta11"
contenido.txtPrMinorista.Name = "txtPrMinorista"
contenido.Clsetiqueta12.Name = "Clsetiqueta12"
contenido.txtAlicIVA.Name = "txtAlicIVA"
contenido.Clsetiqueta13.Name = "Clsetiqueta13"
contenido.txtSubTotal.Name = "txtSubTotal"
contenido.chkCalcIVA.Alignment = 0
contenido.chkCalcIVA.Visible = .F.
contenido.chkCalcIVA.Name = "chkCalcIVA"
contenido.btnEliminar.Top = 164
contenido.btnEliminar.Left = 977
contenido.btnEliminar.Height = 44
contenido.btnEliminar.Width = 45
contenido.btnEliminar.Name = "btnEliminar"
contenido.Clsetiqueta20.Name = "Clsetiqueta20"
contenido.txtPorDesc1.Name = "txtPorDesc1"
contenido.txtImpDescItem1.Name = "txtImpDescItem1"
contenido.txtPorDesc2.Name = "txtPorDesc2"
contenido.txtImpDescItem2.Name = "txtImpDescItem2"
contenido.txtPorDesc3.Name = "txtPorDesc3"
contenido.txtImpDescItem3.Name = "txtImpDescItem3"
contenido.txtPorDesc4.Name = "txtPorDesc4"
contenido.txtImpDescItem4.Name = "txtImpDescItem4"
contenido.Clsetiqueta21.Name = "Clsetiqueta21"
contenido.txtImpIVA.Name = "txtImpIVA"
contenido.Clsetiqueta22.Name = "Clsetiqueta22"
contenido.txtSTNeto.Name = "txtSTNeto"
contenido.grdDetalles.COLUMN1.Header1.Name = "Header1"
contenido.grdDetalles.COLUMN1.Text1.Name = "Text1"
contenido.grdDetalles.COLUMN1.Name = "COLUMN1"
contenido.grdDetalles.COLUMN2.Header1.Name = "Header1"
contenido.grdDetalles.COLUMN2.Text1.Name = "Text1"
contenido.grdDetalles.COLUMN2.Name = "COLUMN2"
contenido.grdDetalles.COLUMN3.Header1.Name = "Header1"
contenido.grdDetalles.COLUMN3.Text1.Name = "Text1"
contenido.grdDetalles.COLUMN3.Name = "COLUMN3"
contenido.grdDetalles.COLUMN4.Header1.Name = "Header1"
contenido.grdDetalles.COLUMN4.Text1.Name = "Text1"
contenido.grdDetalles.COLUMN4.Name = "COLUMN4"
contenido.grdDetalles.COLUMN5.Header1.Name = "Header1"
contenido.grdDetalles.COLUMN5.Text1.Name = "Text1"
contenido.grdDetalles.COLUMN5.Name = "COLUMN5"
contenido.grdDetalles.COLUMN6.Header1.Name = "Header1"
contenido.grdDetalles.COLUMN6.Text1.Name = "Text1"
contenido.grdDetalles.COLUMN6.Name = "COLUMN6"
contenido.grdDetalles.COLUMN7.Header1.Name = "Header1"
contenido.grdDetalles.COLUMN7.Text1.Name = "Text1"
contenido.grdDetalles.COLUMN7.Name = "COLUMN7"
contenido.grdDetalles.COLUMN8.Header1.Name = "Header1"
contenido.grdDetalles.COLUMN8.Text1.Name = "Text1"
contenido.grdDetalles.COLUMN8.Name = "COLUMN8"
contenido.grdDetalles.COLUMN9.Header1.Name = "Header1"
contenido.grdDetalles.COLUMN9.Text1.Name = "Text1"
contenido.grdDetalles.COLUMN9.Name = "COLUMN9"
contenido.grdDetalles.COLUMN10.Header1.Name = "Header1"
contenido.grdDetalles.COLUMN10.Text1.Name = "Text1"
contenido.grdDetalles.COLUMN10.Name = "COLUMN10"
contenido.grdDetalles.COLUMN11.Header1.Name = "Header1"
contenido.grdDetalles.COLUMN11.Text1.Name = "Text1"
contenido.grdDetalles.COLUMN11.Name = "COLUMN11"
contenido.grdDetalles.COLUMN12.Header1.Name = "Header1"
contenido.grdDetalles.COLUMN12.Text1.Name = "Text1"
contenido.grdDetalles.COLUMN12.Name = "COLUMN12"
contenido.grdDetalles.COLUMN13.Header1.Name = "Header1"
contenido.grdDetalles.COLUMN13.Text1.Name = "Text1"
contenido.grdDetalles.COLUMN13.Name = "COLUMN13"
contenido.grdDetalles.COLUMN14.Header1.Name = "Header1"
contenido.grdDetalles.COLUMN14.Text1.Name = "Text1"
contenido.grdDetalles.COLUMN14.Name = "COLUMN14"
contenido.grdDetalles.COLUMN15.Header1.Name = "Header1"
contenido.grdDetalles.COLUMN15.Text1.Name = "Text1"
contenido.grdDetalles.COLUMN15.Name = "COLUMN15"
contenido.grdDetalles.COLUMN16.Header1.Name = "Header1"
contenido.grdDetalles.COLUMN16.Text1.Name = "Text1"
contenido.grdDetalles.COLUMN16.Name = "COLUMN16"
contenido.grdDetalles.COLUMN17.Header1.Name = "Header1"
contenido.grdDetalles.COLUMN17.Text1.Name = "Text1"
contenido.grdDetalles.COLUMN17.Name = "COLUMN17"
contenido.grdDetalles.COLUMN18.Header1.Name = "Header1"
contenido.grdDetalles.COLUMN18.Text1.Name = "Text1"
contenido.grdDetalles.COLUMN18.Name = "COLUMN18"
contenido.grdDetalles.COLUMN19.Header1.Name = "Header1"
contenido.grdDetalles.COLUMN19.Text1.Name = "Text1"
contenido.grdDetalles.COLUMN19.Name = "COLUMN19"
contenido.grdDetalles.COLUMN20.Header1.Name = "Header1"
contenido.grdDetalles.COLUMN20.Text1.Name = "Text1"
contenido.grdDetalles.COLUMN20.Name = "COLUMN20"
contenido.grdDetalles.Name = "grdDetalles"
contenido.Clsetiqueta23.Name = "Clsetiqueta23"
contenido.txtPrNeto.Name = "txtPrNeto"
contenido.lblExistencia.Name = "lblExistencia"
contenido.txtExistencia.Name = "txtExistencia"
contenido.Name = "contenido"
Fiscal.Top = 528
Fiscal.Left = 576
Fiscal.Height = 100
Fiscal.Width = 100
Fiscal.Name = "Fiscal"
mov_stock.Name = "mov_stock"

*** METODOS ***
PROCEDURE Init
DODEFAULT()
Thisform.Closable = .F.
ENDPROC
PROCEDURE contenido.btnGrabar.Click
DODEFAULT()
IF Thisform.cerrar_cbte THEN
	Thisform.blanquear()
	Thisform.Hide()
ENDIF
ENDPROC
PROCEDURE contenido.Clscerrar1.Click
Thisform.Hide()
ENDPROC
PROCEDURE contenido.btnAgregar.Click
DODEFAULT()
Thisform.Hide()
ENDPROC


************************************************************
OBJETO: cls_cbtes_m2
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 9, 6, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_busca_pedido
************************************************************
*** PROPIEDADES ***
BorderStyle = 1
Height = 397
Width = 728
DoCreate = .T.
Caption = "Búsqueda de pedidos ON-Line pendeintes de facturar"
Closable = .F.
BindControls = .T.
codcli = 0
cancelar = .F.
filename = 
idpedarch = 
observ = 
Name = "cls_busca_pedido"

*** METODOS ***
PROCEDURE Activate
LOCAL loSoapCli, lcIds, lnId, lcRegistro

loSoapCli = CREATEOBJECT("MSSOAP.SoapClient30")
loSoapCli.MSSoapInit(gcUrlWS)

lcIds = loSoapCli.getIdsNoProcByCli(Thisform.codcli)

FOR i = 1 TO GETWORDCOUNT(lcIds, "|")
	lnId = GETWORDNUM(lcIds, i, "|")
	lcRegistro = loSoapCli.getByID(lnId)
	
	SELECT cur_Pend
	APPEND BLANK
	REPLACE idPedArch WITH INT(VAL(GETWORDNUM(lcRegistro, 1, "|")))
	REPLACE fecha WITH GETWORDNUM(lcRegistro, 2, "|") ADDITIVE
	REPLACE fileName WITH GETWORDNUM(lcRegistro, 3, "|") ADDITIVE
	REPLACE codCli WITH INT(VAL(GETWORDNUM(lcRegistro, 4, "|"))) ADDITIVE
	REPLACE observ WITH ALLTRIM(GETWORDNUM(lcRegistro, 5, "|")) ADDITIVE
NEXT i

SELECT cur_Pend
IF RECCOUNT("cur_Pend") > 0 THEN
	GO TOP
ENDIF

Thisform.grdPendi.Refresh()

ENDPROC
PROCEDURE Init
DODEFAULT()

SELECT cur_Pend
Thisform.grdPendi.RecordSource = "cur_Pend"
Thisform.grdPendi.alias_name = "cur_Pend"
Thisform.grdPendi.titulos_cabeceras = "Nro. Arch.,Cliente,Fecha"
Thisform.grdPendi.list_controlsource = "idPedArch,codCli,fecha"
Thisform.grdPendi.lista_ancho_cols = "70,70,70"
Thisform.grdPendi.generar_grid()
ENDPROC
PROCEDURE Load
DODEFAULT()

&& El siguiente cursor graba los archivos pendientes
&& de pedidos que hay que descargar

CREATE TABLE cur_pend (	;
	idPedArch	int,;
	fecha		varchar(10),;
	fileName	varchar(60),;
	codCli		int,;
	observ		M)

ENDPROC


************************************************************
OBJETO: grdPendi
************************************************************
*** PROPIEDADES ***
Height = 343
Left = 8
Top = 8
Width = 713
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdPendi"
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
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 352
Left = 676
Height = 44
Width = 45
Caption = ""
Name = "btnCerrar"

*** METODOS ***
PROCEDURE Click
Thisform.filename = ""
Thisform.cancelar = .T.
Thisform.Hide()
ENDPROC


************************************************************
OBJETO: btnAceptar
************************************************************
*** PROPIEDADES ***
Top = 352
Left = 629
Height = 44
Width = 45
Name = "btnAceptar"

*** METODOS ***
PROCEDURE Click
LOCAL lcUrl, lcRuta, loSoapCli
LOCAL lcFTADDR

lcRuta = ""

SELECT cur_Pend
lcFTADDR = GetConfig("FT_ADDR")
*lcUrl = "http://siscom.hol.es/" + ALLTRIM(lcFTADDR) + "/Pedidos/" + ALLTRIM(cur_Pend.fileName)
*lcRuta = HOME(0) + "intercambio\" + ALLTRIM(cur_Pend.fileName)

&& Descargo el archivo
*IF !VFPHTTP(lcUrl, lcRuta) THEN
*	MESSAGEBOX("Ha ocurrido un error al intentar descargar el archivo, verifique que no se haya perdido la conexión a internet", 0+48, Thisform.Caption)
*	RETURN .F.
*ENDIF

&& Una vez descargado lo marco
*loSoapCli = CREATEOBJECT("MSSOAP.SoapClient30")
*loSoapCli.MSSoapInit(gcUrlWS)


Thisform.filename = ALLTRIM(lcRuta)
Thisform.idpedarch = cur_Pend.idPedArch
Thisform.cancelar = .F.
Thisform.observ = cur_Pend.observ
Thisform.Hide()
ENDPROC


************************************************************
OBJETO: cls_busca_pedido
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: clsform_imagencbte
************************************************************
*** PROPIEDADES ***
DataSession = 1
BorderStyle = 2
Height = 388
Width = 851
DoCreate = .T.
Comment = ""
Caption = "Consulta de Imagen del Comprobante"
idventascab = 0
Name = "clsform_imagencbte"
CONTENIDO.Top = -1
CONTENIDO.Left = -1
CONTENIDO.Width = 853
CONTENIDO.Height = 390
CONTENIDO.Name = "CONTENIDO"

*** METODOS ***
PROCEDURE Load
LOCAL lcSql, loResult, loVentas, cbte

lcSql = ""
loResult = CREATEOBJECT("odbc_result")
loVentas = CREATEOBJECT("odbc_result")
cbte = ""

DODEFAULT()

CREATE CURSOR cur_Detalle (	;
	idDetalle		int			,;
	idArticulo		int 		,;
	codArt			C(20)		,;
	descripcio		C(60)		,;
	cantidad		float(10,2)	,;
	prVta			float(10,2)	,;
	pDtoVta1		float(10,2)	,;
	pDtoVta2		float(10,2)	,;
	pDtoVta3		float(10,2)	,;
	pDtoVta4		float(10,2)	,;
	iDtoVta1		float(10,2)	,;
	iDtoVta2		float(10,2)	,;
	iDtoVta3		float(10,2)	,;
	iDtoVta4		float(10,2)	,;
	pDtoCli1		float(10,2)	,;
	pDtoCli2		float(10,2)	,;
	pDtoCli3		float(10,2)	,;
	pDtoCli4		float(10,2)	,;
	iDtoCli1		float(10,2)	,;
	iDtoCli2		float(10,2)	,;
	iDtoCli3		float(10,2)	,;
	iDtoCli4		float(10,2)	,;	
	alicIVA			float(10,2)	,;
	impIVA			float(10,2)	,;
	impNeto			float(10,2)	,;	
	totNeto			float(10,2)	,;
	subTotal		float(10, 2))
	
CREATE CURSOR cur_Aux (	;
	idDetalle		int			,;
	idArticulo		int 		,;
	codArt			C(20)		,;
	descripcio		C(60)		,;
	cantidad		float(10,2)	,;
	prVta			float(10,2)	,;
	pDtoVta1		float(10,2)	,;
	pDtoVta2		float(10,2)	,;
	pDtoVta3		float(10,2)	,;
	pDtoVta4		float(10,2)	,;
	iDtoVta1		float(10,2)	,;
	iDtoVta2		float(10,2)	,;
	iDtoVta3		float(10,2)	,;
	iDtoVta4		float(10,2)	,;
	pDtoCli1		float(10,2)	,;
	pDtoCli2		float(10,2)	,;
	pDtoCli3		float(10,2)	,;
	pDtoCli4		float(10,2)	,;
	iDtoCli1		float(10,2)	,;
	iDtoCli2		float(10,2)	,;
	iDtoCli3		float(10,2)	,;
	iDtoCli4		float(10,2)	,;	
	alicIVA			float(10,2)	,;
	impIVA			float(10,2)	,;
	impNeto			float(10,2)	,;	
	totNeto			float(10,2)	,;
	subTotal		float(10, 2))

lcSql = lcSql + "select  ventasdet.idventasc, "
lcSql = lcSql + "        ventasdet.idarticulo, "
lcSql = lcSql + "        articulos.codart, "
lcSql = lcSql + "        articulos.descripcio, "
lcSql = lcSql + "        ventasdet.cantidad, "
lcSql = lcSql + "        ventasdet.prVenta, "
lcSql = lcSql + "        ventasdet.pDtoVta1, "
lcSql = lcSql + "        ventasdet.pDtoVta2, "
lcSql = lcSql + "        ventasdet.pDtoVta3, "
lcSql = lcSql + "        ventasdet.pDtoVta4, "
lcSql = lcSql + "        ventasdet.iDtoVta1, "
lcSql = lcSql + "        ventasdet.iDtoVta2, "
lcSql = lcSql + "        ventasdet.iDtoVta3, "
lcSql = lcSql + "        ventasdet.iDtoVta4, "
lcSql = lcSql + "        ventasdet.porDesc1, "
lcSql = lcSql + "        ventasdet.porDesc2, "
lcSql = lcSql + "        ventasdet.porDesc3, "
lcSql = lcSql + "        ventasdet.porDesc4, "
lcSql = lcSql + "        ventasdet.impDesc1, "
lcSql = lcSql + "        ventasdet.impDesc2, "
lcSql = lcSql + "        ventasdet.impDesc3, "
lcSql = lcSql + "        ventasdet.impDesc4, "
lcSql = lcSql + "        ventasdet.alicIVA, "
lcSql = lcSql + "        ventasdet.impIVA, "
lcSql = lcSql + "        ventasdet.impNeto, "
lcSql = lcSql + "        ventasdet.totNeto, "
lcSql = lcSql + "        ventasdet.subTotal "
lcSql = lcSql + "from    ventasdet inner join articulos "
lcSql = lcSql + "    on ventasdet.idArticulo = articulos.idArticulo "
lcSql = lcSql + "where idVentasC = " + ALLTRIM(STR(cur_Cbtes.idventasc))

loResult.ActiveConnection = goConn.ActiveConnection
loResult.cursor_name = "cur_tempo"
loResult.OpenQuery(lcSql)

lcSql = "select * from ventascab where idventasc = " + ALLTRIM(STR(cur_cbtes.idventasc))
loVentas.Cursor_Name = "cur_vtas"
loVentas.ActiveConnection = goConn.ActiveConnection
loVentas.OpenQuery(lcSql)

cbte = ALLTRIM(cur_vtas.cbte)

loVentas.close_query()

SELECT cur_tempo
IF RECCOUNT() > 0
	GO TOP
ENDIF

IF ((ALLTRIM(cbte) == "NC") .OR. (ALLTRIM(cbte) == "FC") .OR. (ALLTRIM(cbte) == "PTO") .OR. (ALLTRIM(cbte) == "COT")) THEN
	SELECT cur_tempo
	DO WHILE !EOF()
		
		SELECT cur_aux
		APPEND BLANK	
		
		REPLACE cur_aux.idDetalle WITH cur_tempo.idVentasc
		REPLACE cur_aux.idArticulo WITH cur_tempo.idArticulo ADDITIVE
		REPLACE cur_aux.codArt WITH cur_tempo.codArt ADDITIVE
		REPLACE cur_aux.descripcio WITH cur_tempo.descripcio ADDITIVE
		REPLACE cur_aux.cantidad WITH cur_tempo.cantidad ADDITIVE
		REPLACE cur_aux.prVta WITH cur_tempo.prVenta ADDITIVE
		REPLACE cur_aux.pDtoVta1 WITH cur_tempo.pDtoVta1 ADDITIVE
		REPLACE cur_aux.pDtoVta2 WITH cur_tempo.pDtoVta2 ADDITIVE
		REPLACE cur_aux.pDtoVta3 WITH cur_tempo.pDtoVta3 ADDITIVE
		REPLACE cur_aux.pDtoVta4 WITH cur_tempo.pDtoVta4 ADDITIVE
		REPLACE cur_aux.iDtoVta1 WITH cur_tempo.iDtoVta1 ADDITIVE
		REPLACE cur_aux.iDtoVta2 WITH cur_tempo.iDtoVta2 ADDITIVE
		REPLACE cur_aux.iDtoVta3 WITH cur_tempo.iDtoVta3 ADDITIVE
		REPLACE cur_aux.iDtoVta4 WITH cur_tempo.iDtoVta4 ADDITIVE
		REPLACE cur_aux.pDtoCli1 WITH cur_tempo.porDesc1 ADDITIVE
		REPLACE cur_aux.pDtoCli2 WITH cur_tempo.porDesc2 ADDITIVE
		REPLACE cur_aux.pDtoCli3 WITH cur_tempo.porDesc3 ADDITIVE
		REPLACE cur_aux.pDtoCli4 WITH cur_tempo.porDesc4 ADDITIVE
		REPLACE cur_aux.iDtoCli1 WITH cur_tempo.impDesc1 ADDITIVE
		REPLACE cur_aux.iDtoCli2 WITH cur_tempo.impDesc2 ADDITIVE
		REPLACE cur_aux.iDtoCli3 WITH cur_tempo.impDesc3 ADDITIVE
		REPLACE cur_aux.iDtoCli4 WITH cur_tempo.impDesc4 ADDITIVE
		REPLACE cur_aux.alicIVA WITH cur_tempo.alicIVA ADDITIVE
		REPLACE cur_aux.impIVA WITH cur_tempo.impIVA ADDITIVE
		REPLACE cur_aux.impNeto WITH cur_tempo.impNeto ADDITIVE
		REPLACE cur_aux.totNeto WITH cur_tempo.totNeto ADDITIVE
		REPLACE cur_aux.subTotal WITH cur_tempo.subTotal ADDITIVE

		SELECT cur_tempo
		SKIP
	ENDDO
	
	SELECT cur_aux
	IF RECCOUNT() > 0
		GO TOP
	ENDIF
ENDIF 

SELECT cur_tempo
IF RECCOUNT() > 0
	GO TOP
ENDIF

SELECT cur_tempo
DO WHILE !EOF()
	
	SELECT cur_detalle
	APPEND BLANK	
	
	REPLACE cur_detalle.idDetalle WITH cur_tempo.idVentasc
	REPLACE cur_detalle.idArticulo WITH cur_tempo.idArticulo ADDITIVE
	REPLACE cur_detalle.codArt WITH cur_tempo.codArt ADDITIVE
	REPLACE cur_detalle.descripcio WITH cur_tempo.descripcio ADDITIVE
	REPLACE cur_detalle.cantidad WITH cur_tempo.cantidad ADDITIVE
	REPLACE cur_detalle.prVta WITH cur_tempo.prVenta ADDITIVE
	REPLACE cur_detalle.pDtoVta1 WITH cur_tempo.pDtoVta1 ADDITIVE
	REPLACE cur_detalle.pDtoVta2 WITH cur_tempo.pDtoVta2 ADDITIVE
	REPLACE cur_detalle.pDtoVta3 WITH cur_tempo.pDtoVta3 ADDITIVE
	REPLACE cur_detalle.pDtoVta4 WITH cur_tempo.pDtoVta4 ADDITIVE
	REPLACE cur_detalle.iDtoVta1 WITH cur_tempo.iDtoVta1 ADDITIVE
	REPLACE cur_detalle.iDtoVta2 WITH cur_tempo.iDtoVta2 ADDITIVE
	REPLACE cur_detalle.iDtoVta3 WITH cur_tempo.iDtoVta3 ADDITIVE
	REPLACE cur_detalle.iDtoVta4 WITH cur_tempo.iDtoVta4 ADDITIVE
	REPLACE cur_detalle.pDtoCli1 WITH cur_tempo.porDesc1 ADDITIVE
	REPLACE cur_detalle.pDtoCli2 WITH cur_tempo.porDesc2 ADDITIVE
	REPLACE cur_detalle.pDtoCli3 WITH cur_tempo.porDesc3 ADDITIVE
	REPLACE cur_detalle.pDtoCli4 WITH cur_tempo.porDesc4 ADDITIVE
	REPLACE cur_detalle.iDtoCli1 WITH cur_tempo.impDesc1 ADDITIVE
	REPLACE cur_detalle.iDtoCli2 WITH cur_tempo.impDesc2 ADDITIVE
	REPLACE cur_detalle.iDtoCli3 WITH cur_tempo.impDesc3 ADDITIVE
	REPLACE cur_detalle.iDtoCli4 WITH cur_tempo.impDesc4 ADDITIVE
	REPLACE cur_detalle.alicIVA WITH cur_tempo.alicIVA ADDITIVE
	REPLACE cur_detalle.impIVA WITH cur_tempo.impIVA ADDITIVE
	REPLACE cur_detalle.impNeto WITH cur_tempo.impNeto ADDITIVE
	REPLACE cur_detalle.totNeto WITH cur_tempo.totNeto ADDITIVE
	REPLACE cur_detalle.subTotal WITH cur_tempo.subTotal ADDITIVE

	SELECT cur_tempo
	SKIP
ENDDO

SELECT cur_Detalle
IF RECCOUNT() > 0
	GO TOP
ENDIF


loResult.close_query()

ENDPROC
PROCEDURE Init
DODEFAULT()
Thisform.Contenido.txtObserv.Value = cur_Cbtes.Observ
Thisform.Caption = Thisform.Caption + " " + cur_cbtes.NroDoc
ENDPROC


************************************************************
OBJETO: grdDetalle
************************************************************
*** PROPIEDADES ***
Height = 289
Left = 5
TabIndex = 1
Top = 3
Width = 844
alias_name = cur_Detalle
list_controlsource = cantidad,codArt,descripcio,prVta,AlicIVA,impIVA,totNeto,subTotal
lista_ancho_cols = 70,100,200,70,70,70,70,70
permitir_busqueda = .F.
permitir_ordenamiento = .F.
titulos_cabeceras = Cantidad,Codigo,Descripción,Pr. Venta,Alic. I.V.A,Imp. I.V.A,Total Neto,SubTotal
Name = "grdDetalle"
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
OBJETO: CLSCERRAR1
************************************************************
*** PROPIEDADES ***
Top = 344
Left = 804
Height = 44
Width = 45
TabIndex = 4
Name = "CLSCERRAR1"

*** METODOS ***


************************************************************
OBJETO: txtObserv
************************************************************
*** PROPIEDADES ***
Height = 48
Left = 6
ReadOnly = .T.
TabIndex = 2
Top = 295
Width = 843
Name = "txtObserv"

*** METODOS ***


************************************************************
OBJETO: Clsimprimir1
************************************************************
*** PROPIEDADES ***
Top = 344
Left = 757
TabIndex = 3
Name = "Clsimprimir1"

*** METODOS ***
PROCEDURE Click
LOCAL m.NroCli, m.RazSoc, m.Telefono,  m.direccion, m.localidad, m.codPostal, m.pcia, m.tipoIVA, m.nroCuit
LOCAL m.Total, m.tipoDoc, m.NroCbte, m.Fecha, m.leyenda, m.fecVto, m.tipoDoc, m.ptoVta
LOCAL m.porDesc1, m.porDesc2, m.porDesc3, m.porDesc4
LOCAL m.impDesc1, m.impDesc2, m.impDesc3, m.impDesc4
LOCAL m.porIIBB, m.impIIBB, m.observ
LOCAL m.porIVA105, m.impIVA105, m.porIVA21, m.impIVA21, m.impNeto, m.impFinal
LOCAL lcSql, loCV, loCD, lcPrinterName
LOCAL lo_rsSitIVA, lo_rsCondPago, lo_rsLocalidad, lo_rsPcia

loCV = CREATEOBJECT("odbc_result")
lo_rsSitIVA = CREATEOBJECT("odbc_result")
lo_rsCondPago = CREATEOBJECT("odbc_result")
lo_rsLocalidad = CREATEOBJECT("odbc_result")
lo_rsPcia = CREATEOBJECT("odbc_result")
lo_rsCliente = CREATEOBJECT("odbc_result")

lcSql = ""
m.NroCli = ""
m.RazSoc = ""
m.Telefono = ""
m.direccion = ""
m.localidad = ""
m.codPostal = ""
m.pcia = ""
m.nroCuit = ""
m.tipoIVA = ""
m.Total = 0.00
m.tipoDoc = ""
m.NroCbte = ""
m.leyenda = ""
m.Fecha = cur_cbtes.fecemis
m.porIVA105 = 0.00
m.porIVA21 = 0.00
m.impIVA105 = 0.00
m.impIVA21 = 0.00
m.impNeto = 0.00
m.impFinal = 0.00
m.fecVto =  {}
m.tipoDoc = ""
m.ptoVta = ""
m.porIIBB = 0.00
m.impIIBB = 0.00
lnCantCpia = 0
m.observ = Thisform.Contenido.txtObserv.Value

***********************************************************************************
&& Busco la cabecera de venta, cliente, localidad, provincia, cond pago, sir iva

lcSql = "select * from ventascab where idventasc = " + ALLTRIM(STR(cur_cbtes.idventasc))
loCV.Cursor_Name = "cur_venta"
loCV.ActiveConnection = goConn.ActiveConnection
loCV.OpenQuery(lcSql)

lcSql = "SELECT * FROM clientes WHERE idCliente = " + ALLTRIM(STR(cur_venta.idCliente))
lo_rsCliente.ActiveConnection = goConn.ActiveConnection
lo_rsCliente.Cursor_Name = "cur_Cliente"
lo_rsCliente.OpenQuery(lcSql)

SELECT cur_Cliente
m.NroCli = cur_Cliente.idcliente
m.RazSoc = cur_Cliente.razsoc
m.Telefono = cur_Cliente.telefono
m.direccion = cur_Cliente.direccion
m.nroCuit = cur_Cliente.nrocuit

lcSql = "SELECT * FROM localidad WHERE idLocalid = " + ALLTRIM(STR(cur_Cliente.idLocalid))
lo_rsLocalidad.ActiveConnection = goConn.ActiveConnection
lo_rsLocalidad.Cursor_Name = "cur_Localid"
lo_rsLocalidad.OpenQuery(lcSql)

SELECT cur_Localid
m.localidad = cur_Localid.descripcio
m.codpostal = ALLTRIM(cur_Localid.codPostal)

lcSql = "SELECT * FROM provincias WHERE idProvin = " + ALLTRIM(STR(cur_Localid.idProvin))
lo_rsPcia.ActiveConnection = goConn.ActiveConnection
lo_rsPcia.Cursor_Name = "cur_Pcia"
lo_rsPcia.OpenQuery(lcSql)

SELECT cur_Pcia
m.pcia = cur_Pcia.descripcio

lo_rsPcia.close_query()
lo_rsLocalidad.close_query()
lo_rsCliente.close_query()

lcSql = "SELECT * FROM SitIva WHERE idSitIVA = " + ALLTRIM(STR(cur_venta.idSitIVA))
lo_rsSitIVA.ActiveConnection = goConn.ActiveConnection
lo_rsSitIVA.Cursor_Name = "cur_SitIVA"
lo_rsSitIVA.OpenQuery(lcSql)

SELECT cur_SitIVA
m.tipoIVA = cur_SitIVA.descripcio

lo_rsSitIVA.close_query()

lcSql = "SELECT * FROM condpagos WHERE idCondPago = " + ALLTRIM(STR(cur_venta.idCondPago))
lo_rsCondPago.ActiveConnection = goConn.ActiveConnection
lo_rsCondPago.Cursor_Name = "cur_CondPago"
lo_rsCondPago.OpenQuery(lcSql)

SELECT cur_CondPago
m.fecVto = TTOD(cur_venta.fecEmision) + cur_CondPago.cntDias

lo_rsCondPago.close_query()
***********************************************************************************

IF ALLTRIM(cur_venta.cbte) == "COT"
	m.leyenda = "COTIZACION"
	m.Total = cur_venta.totfact
ELSE 
	IF ALLTRIM(cur_venta.cbte) == "PTO"
		m.leyenda = "PRESUPUESTO"
		m.Total = cur_venta.totfact
	ELSE
		IF ALLTRIM(cur_venta.cbte) == "PED"
			m.leyenda = "NOTA DE PEDIDO"
			m.tipoDoc = "P"
			m.Total = cur_venta.totfact
		ELSE
			IF ALLTRIM(cur_venta.Cbte) == "FC"
				m.leyenda = "FACTURA"
				m.Total = cur_venta.totfact
				&& Aca tengo que agregar el calculo de la letra
			ELSE
				IF ALLTRIM(cur_venta.Cbte) == "NC"
					m.Leyenda = "NOTA DE CREDITO"
					m.Total = cur_venta.totfact
					&& Aca tengo que agregar el calculo de la letra
				ELSE
					IF ALLTRIM(cur_venta.Cbte) == "ND"
						m.leyenda = "NOTA DE DEBITO"
						m.Total = cur_venta.totfact
						&& Aca tengo que agregar el calculo de la letra
					ENDIF
				ENDIF
			ENDIF
		ENDIF
	ENDIF
ENDIF 

SELECT cur_venta

m.tipoDoc = cur_venta.tipodoc
m.ptoVta = REPLICATE("0", 4 - LEN(ALLTRIM(STR(cur_venta.ptovta)))) + ALLTRIM(STR(cur_venta.ptovta))
m.NroCbte = m.ptoVta + "-" + REPLICATE("0", 8 - LEN(ALLTRIM(STR(cur_venta.numcbte)))) + ALLTRIM(STR(cur_venta.numcbte))
m.porDesc1 = cur_venta.porDesc1
m.porDesc2 = cur_venta.porDesc2
m.porDesc3 = cur_venta.porDesc3
m.porDesc4 = cur_venta.porDesc4
m.impDesc1 = cur_venta.impDesc1
m.impDesc2 = cur_venta.impDesc2
m.impDesc3 = cur_venta.impDesc3
m.impDesc4 = cur_venta.impDesc4
m.porIVA105 = cur_venta.porIVA105
m.porIVA21 = cur_venta.porIVA21
m.impIVA105 = cur_venta.impIVA105
m.impIVA21 = cur_venta.impIVA21
m.impNeto = cur_venta.impFinal
m.impFinal = cur_venta.impFinal
m.porIIBB = cur_venta.porIIBB
m.impIIBB = cur_venta.impIIBB

IF (cur_venta.cbte == "COT") THEN 
	&& Imprime una cotizacion
	SELECT cur_aux	
	REPORT FORM "repcot.frx" TO PRINTER PREVIEW 
ELSE
	IF (cur_venta.cbte == "PTO") THEN
		&& Imprime un presupuesto
		SELECT cur_aux	
		REPORT FORM "reppto.frx" TO PRINTER PREVIEW 
	ELSE
		&& Si el comprobante es "PED" entonces, tiene que enviar a imprimir una nota de pedido
		IF ALLTRIM(cur_venta.cbte) == "PED" THEN
			m.observ = Thisform.contenido.txtObserv.Value
			SELECT cur_detalle
			REPORT FORM "reppedido.frx" TO PRINTER PREVIEW 
		ELSE 
			IF ALLTRIM(cur_venta.tipodoc) == "A" THEN
				&& Imprime el comprobante de tipo "A"
				SELECT cur_aux	
				REPORT FORM "repcbtesvta.frx" TO PRINTER PREVIEW 
			ELSE
				&& Imprime el comprobante de tipo "B"
				SELECT cur_aux	
				REPORT FORM "repcbtesvta_b.frx" TO PRINTER PREVIEW 
			ENDIF
		ENDIF
	ENDIF
ENDIF 

loCV.close_query()

ENDPROC


************************************************************
OBJETO: clsform_imagencbte
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: clsformcbtes
************************************************************
*** PROPIEDADES ***
BorderStyle = 2
Height = 561
Width = 1024
DoCreate = .T.
Caption = "Ingreso de Comprobantes de Ventas"
cbte = 
usar_fiscal = .F.
pciomaydef = .T.
cp_cntdias = 0
sitivacli = 0
saldo_fc = 0.00
idorigen = 0
cli_calle = 
cli_localidad = 
cli_codpostal = 
cli_pcia = 
cli_tipoiva = 
cli_cuit = 
cli_telefono = 
cli_id = 0
printerdevice = 
tipodoc = X
ptovta = 
codivafiscal = 0
fis_numcbte = 0
Name = "clsformcbtes"
contenido.Top = -1
contenido.Left = -1
contenido.Width = 1025
contenido.Height = 574
contenido.TabIndex = 1
contenido.Name = "contenido"

*** METODOS ***
PROCEDURE sumar_items
LOCAL lnTotal, lnTotImpIVA21, lnTotImpIVA105
LOCAL loResult, lcSql, lnTotNeto, lnSubTotal, lnTotal

loResult = CREATEOBJECT("odbc_result")
lnTotNeto = 0.00
lnTotal = 0.00
lnTotImpIVA21 = 0.00
lnTotImpIVA105 = 0.00
lcSql = ""
lnSubTotal = 0.00

SELECT cur_Detalle
IF RECCOUNT("cur_Detalle") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF()
	lcSql = "SELECT * FROM articulos WHERE idArticulo = " + ALLTRIM(STR(cur_Detalle.idArticulo))
	loResult.ActiveConnection = goConn.ActiveConnection
	loResult.Cursor_Name = "cur_art"
	loResult.OpenQuery(lcSql)
	
	IF clientes.mayorista THEN
		lnTotNeto = lnTotNeto + (cur_art.prVentaMax * cur_Detalle.cantidad)
	ELSE
		lnTotNeto = lnTotNeto + (cur_art.prVentaMin * cur_Detalle.cantidad)
	ENDIF
	
	lnSubTotal = lnSubTotal + cur_Detalle.totNeto
	lnTotal = lnTotal + cur_Detalle.SubTotal
	
	IF cur_Detalle.alicIVA = 21
		Thisform.contenido.txtPorIVA21.Value = cur_Detalle.alicIVA
		lnTotImpIVA21 = lnTotImpIVA21 + cur_Detalle.impIVA
	ELSE
		Thisform.contenido.txtPorIVA105.Value = cur_Detalle.alicIVA
		lnTotImpIVA105 = lnTotImpIVA105 + cur_Detalle.impIVA
	ENDIF
	
	loResult.Close_Query()

	SELECT cur_Detalle
	SKIP
ENDDO

Thisform.contenido.txtTotNeto.Value = ROUND(lnTotNeto, 2)
Thisform.contenido.txtST.Value = ROUND(lnSubTotal, 2)
Thisform.contenido.txtTotal.Value = ROUND(lnTotal, 2)
Thisform.contenido.txtImpIVA105.Value = ROUND(lnTotImpIVA105, 2)
Thisform.contenido.txtImpIVA21.Value = ROUND(lnTotImpIVA21, 2)
Thisform.contenido.txtTotFact.Value = lnSubTotal + lnTotImpIVA21 + lnTotImpIVA105

SELECT cur_Detalle
IF RECCOUNT() > 0
	GO TOP
ENDIF

ENDPROC
PROCEDURE blanquear
Thisform.Contenido.sel_Cliente.blanquear()
thisform.contenido.sel_Cliente.valcpoid = 0
Thisform.Contenido.txtSitIVA.Value = ""
Thisform.Contenido.sel_FormaPago.blanquear()
Thisform.contenido.sel_Articulo.blanquear()
Thisform.contenido.sel_Articulo.valcpoid = 0
Thisform.Contenido.txtCantidad.Value = 0.00
Thisform.Contenido.txtPrMay.Value = 0.00
Thisform.Contenido.txtPrMinorista.Value = 0.00
Thisform.Contenido.txtDesc1.Value = 0.00
Thisform.Contenido.txtDesc2.Value = 0.00
Thisform.Contenido.txtDesc3.Value = 0.00
Thisform.Contenido.txtDesc4.Value = 0.00
Thisform.Contenido.txtImpDesc1.Value = 0.00
Thisform.Contenido.txtImpDesc2.Value = 0.00
Thisform.Contenido.txtImpDesc3.Value = 0.00
Thisform.Contenido.txtImpDesc4.Value = 0.00
Thisform.contenido.txtPorDesc1.Value = 0.00
Thisform.contenido.txtPorDesc2.Value = 0.00
Thisform.contenido.txtPorDesc3.Value = 0.00
Thisform.contenido.txtPorDesc4.Value = 0.00
Thisform.contenido.txtImpDescItem1.Value = 0.00
Thisform.contenido.txtImpDescItem2.Value = 0.00
Thisform.contenido.txtImpDescItem3.Value = 0.00
Thisform.contenido.txtImpDescItem4.Value = 0.00
Thisform.contenido.txtPrNeto.Value = 0.00
Thisform.contenido.txtSTNeto.Value = 0.00
Thisform.Contenido.txtAlicIVA.Value = 0.00
Thisform.contenido.txtImpIva.Value = 0.00
Thisform.Contenido.txtSubTotal.Value = 0.00

Thisform.Contenido.txtTotNeto.Value = 0.00
Thisform.Contenido.txtTotal.Value = 0.00
Thisform.contenido.txtST.Value = 0.00
Thisform.Contenido.txtPorIVA21.Value = 0.00
Thisform.Contenido.txtPorIVA105.Value = 0.00
Thisform.Contenido.txtPorIIBB.Value = 0.00
Thisform.Contenido.txtImpIVA21.Value = 0.00
Thisform.Contenido.txtImpIVA105.Value = 0.00
Thisform.Contenido.txtImpIIBB.Value = 0.00
Thisform.Contenido.txtTotFact.Value = 0.00

Thisform.Contenido.txtObserv.Value = ""

SELECT cur_Detalle
ZAP
Thisform.Contenido.grdDetalles.Refresh()
Thisform.contenido.btnCbteOrigen.Enabled = .T.
Thisform.Contenido.sel_Cliente.txtCodigo.SetFocus()
Thisform.mov_stock.limpiar()
ENDPROC
PROCEDURE imprimir
LOCAL m.NroCli, m.RazSoc, m.Telefono, m.direccion, m.localidad, m.codPostal, m.pcia, m.TipoIVA, m.nroCUIT
LOCAL m.Total, m.tipoDoc, m.NroCbte, m.Fecha, m.leyenda, m.fecVto, m.tipoDoc, m.ptoVta
LOCAL m.porDesc1, m.porDesc2, m.porDesc3, m.porDesc4
LOCAL m.impDesc1, m.impDesc2, m.impDesc3, m.impDesc4
LOCAL m.porIIBB, m.impIIBB, m.observ
LOCAL m.porIVA105, m.impIVA105, m.porIVA21, m.impIVA21, m.impNeto, m.impFinal
LOCAL lcSql, loNumerador, lcPrinterName, lnCantCpia

loNumerador = CREATEOBJECT("odbc_result")
lcSql = ""
m.NroCli = Thisform.contenido.sel_Cliente.txtCodigo.Value
m.RazSoc = Thisform.contenido.sel_Cliente.txtDescripcion.Value
m.Telefono = ALLTRIM(Thisform.cli_telefono)
m.direccion = ALLTRIM(Thisform.cli_calle)
m.localidad = ALLTRIM(Thisform.cli_localidad)
m.codPostal = ALLTRIM(Thisform.cli_codPostal)
m.pcia = ALLTRIM(Thisform.cli_Pcia)
m.nroCUIT = ALLTRIM(Thisform.cli_cuit)
m.TipoIVA = Thisform.Contenido.txtSitIVA.Value
m.Total = 0.00
m.tipoDoc = ""
m.NroCbte = ""
m.leyenda = ""
m.Fecha = DATETIME()
m.porIVA105 = 0.00
m.porIVA21 = 0.00
m.impIVA105 = 0.00
m.impIVA21 = 0.00
m.impNeto = 0.00
m.impFinal = 0.00
m.fecVto = DATE() + thisform.cp_cntdias
m.tipoDoc = Thisform.tipodoc
m.ptoVta = Thisform.ptovta
m.porIIBB = 0.00
m.impIIBB = 0.00
lnCantCpia = 0
m.observ = ""

lcSql = "select * from numerador where cbte = '" + ALLTRIM(Thisform.cbte) + "' and tipoDoc = '" + ALLTRIM(m.tipoDoc) + "' AND ptoVta = " + ALLTRIM(STR(INT(VAL(m.ptoVta))))
loNumerador = CREATEOBJECT("odbc_result")
loNumerador.ActiveConnection = goConn.ActiveConnection
loNumerador.Cursor_Name = "cur_num"
loNumerador.OpenQuery(lcSql)

SELECT cur_num
m.NroCbte = m.ptoVta + "-" + REPLICATE("0", 8 - LEN(ALLTRIM(STR(cur_num.numActual)))) + ALLTRIM(STR(cur_num.numActual))
lcPrinterName = cur_num.impresora
lnCantCpia = cur_num.cantCpia

loNumerador.close_query()


IF ALLTRIM(Thisform.cbte) == "COT"
	m.leyenda = "COTIZACION"
	m.tipoDoc = "X"
	m.Total = Thisform.Contenido.txtTotFact.Value
ELSE 
	IF ALLTRIM(Thisform.cbte) == "PTO"
		m.leyenda = "PRESUPUESTO"
		m.tipoDoc = "X"
		m.Total = Thisform.Contenido.txtST.Value 
	ELSE
		IF ALLTRIM(Thisform.cbte) == "PED"
			m.leyenda = "NOTA DE PEDIDO"
			m.tipoDoc = "P"
			m.Total = Thisform.contenido.txtTotFact.Value
		ELSE
			IF ALLTRIM(Thisform.Cbte) == "FC"
				m.leyenda = "FACTURA"
				m.Total = Thisform.contenido.txtTotFact.Value
			ELSE
				IF ALLTRIM(Thisform.Cbte) == "NC"
					m.Leyenda = "NOTA DE CREDITO"
					m.Total = Thisform.contenido.txtTotFact.Value
				ELSE
					IF ALLTRIM(Thisform.Cbte) == "ND"
						m.leyenda = "NOTA DE DEBITO"
						m.Total = Thisform.contenido.txtTotFact.Value
					ENDIF
				ENDIF
			ENDIF
		ENDIF
	ENDIF
ENDIF 

m.NroCli = clientes.idCliente
m.RazSoc = clientes.razSoc
m.Telefono = clientes.telefono


m.porDesc1 = Thisform.Contenido.txtDesc1.Value
m.porDesc2 = Thisform.Contenido.txtDesc2.Value
m.porDesc3 = Thisform.Contenido.txtDesc3.Value
m.porDesc4 = Thisform.Contenido.txtDesc4.Value
m.impDesc1 = Thisform.Contenido.txtImpDesc1.Value
m.impDesc2 = Thisform.Contenido.txtImpDesc2.Value
m.impDesc3 = Thisform.Contenido.txtImpDesc3.Value
m.impDesc4 = Thisform.Contenido.txtImpDesc4.Value
m.porIVA105 = Thisform.contenido.txtPorIVA105.Value
m.porIVA21 = Thisform.Contenido.txtPorIVA21.value
m.impIVA105 = Thisform.Contenido.txtImpIVA105.Value
m.impIVA21 = Thisform.Contenido.txtImpIVA21.Value
m.impNeto = Thisform.Contenido.txtST.Value
m.impFinal = Thisform.Contenido.txtTotFact.Value
m.porIIBB = Thisform.Contenido.txtPorIIBB.Value
m.impIIBB = Thisform.Contenido.txtImpIIBB.Value

SET PRINTER TO NAME ALLTRIM(lcPrinterName)
SELECT cur_Detalle

FOR i = 1 TO lnCantCpia
	IF (this.cbte == "COT") THEN
		&& Imprime un presupuesto
		REPORT FORM "repcot.frx" TO PRINTER NOCONSOLE
	ELSE
		IF (this.cbte == "PTO") THEN
			&& Imprime un presupuesto
			REPORT FORM "reppto.frx" TO PRINTER NOCONSOLE
		ELSE
			&& Si el comprobante es "PED" entonces, tiene que enviar a imprimir una nota de pedido
			IF ALLTRIM(Thisform.cbte) == "PED" THEN
				m.observ = Thisform.contenido.txtObserv.Value
				REPORT FORM "reppedido.frx" TO PRINTER NOCONSOLE
			ELSE 
				IF ALLTRIM(Thisform.tipodoc) == "A" THEN
					&& Imprime el comprobante de tipo "A"
					REPORT FORM "repcbtesvta.frx" TO PRINTER NOCONSOLE
				ELSE
					&& Imprime el comprobante de tipo "B"
					REPORT FORM "repcbtesvta_b.frx" TO PRINTER NOCONSOLE
				ENDIF
			ENDIF
		ENDIF
	ENDIF 
NEXT

*IF thisform.contenido.chkImprimeDup.Value = 1
*	REPORT FORM "reppto.frx" TO PRINTER NOCONSOLE
*ENDIF

ENDPROC
PROCEDURE enviar_fiscal
LOCAL lcDireccion, lcDesc, lnImpItem, lnImpItemNeto

lnImpItem = 0.00
lnImpItemNeto = 0.00
lcDireccion = ALLTRIM(Thisform.cli_calle) + " " + ALLTRIM(Thisform.cli_Codpostal) + " " + ALLTRIM(Thisform.cli_Localidad) + " " + ALLTRIM(Thisform.cli_pcia)

Thisform.Fiscal.Puerto = 1
Thisform.Fiscal.Comenzar()
Thisform.Fiscal.Modelo = 8  && MODELO_P320
Thisform.Fiscal.TratarDeCancelarTodo()
Thisform.Fiscal.DescripcionesLargas = .T.
Thisform.Fiscal.ReintentoConstante = .T.
Thisform.Fiscal.usarASCII = .T.
Thisform.Fiscal.DatosCliente(ALLTRIM(Thisform.Contenido.sel_Cliente.txtDescripcion.Value), ALLTRIM(Thisform.cli_cuit), 67, Thisform.codivafiscal, lcDireccion)

* Configuración del controlador
&&Thisform.Fiscal.ConfigurarControladorCompleto(.T., .F., 10000, 10000, 0.00, 1, .F., .F., 70, .F., .F., "", .T., 79, 78, 84, 65)

IF ALLTRIM(Thisform.cbte) == "FC" THEN
	IF ALLTRIM(Thisform.tipodoc) == "A" THEN
		Thisform.Fiscal.AbrirComprobanteFiscal(48)	&& FACTURA A
	ELSE
		Thisform.Fiscal.AbrirComprobanteFiscal(49)	&& FACTURA B
	ENDIF
ELSE
	IF ALLTRIM(Thisform.cbte) == "NC" THEN
		Thisform.Fiscal.InformacionRemito(1) = ""
		
		IF ALLTRIM(Thisform.tipodoc) == "A" THEN
			Thisform.Fiscal.AbrirComprobanteNoFiscalHomologado(82)	&& NOTA DE CREDITO A
		ELSE
			Thisform.Fiscal.AbrirComprobanteNoFiscalHomologado(83)	&& NOTA DE CREDITO B
		ENDIF
	ENDIF
ENDIF

SELECT cur_Detalle
IF RECCOUNT("cur_Detalle") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_Detalle")
	lcDesc = SUBSTR(ALLTRIM(cur_Detalle.codArt) + REPLICATE(" ", 15 - LEN(ALLTRIM(cur_Detalle.codArt))) + "-" + STRTRAN(ALLTRIM(cur_Detalle.Descripcio), ".", " "), 1, 54)
	lnImpItemNeto = cur_Detalle.prVta
	lnImpItem = (cur_Detalle.prVta + cur_Detalle.impIVA)
	Thisform.Fiscal.ImprimirItem(ALLTRIM(lcDesc), cur_Detalle.Cantidad, ROUND(lnImpItem, 2), cur_Detalle.alicIVA, 0)

	SELECT cur_Detalle
	SKIP
ENDDO

Thisform.Fiscal.EspecificarPercepcionGlobal("Perc. IIBB.", Thisform.Contenido.txtImpIIBB.Value)

Thisform.Fiscal.Subtotal(.T.)
IF ALLTRIM(Thisform.cbte) == "FC" THEN
	Thisform.Fiscal.CerrarComprobanteFiscal()
ELSE
	Thisform.Fiscal.CerrarComprobanteNoFiscalHomologado()
ENDIF

Thisform.fis_numcbte = INT(VAL(Thisform.Fiscal.Respuesta(3)))	&& Devuelvo el número de comprobante a grabar

Thisform.Fiscal.Finalizar()
ENDPROC
PROCEDURE calcular_tipodoc
LOCAL lnSitIVACli

lnSitIvaEmp = 0
lnSitIvaEmp = VAL(ALLTRIM(getConfig("SITIVAEMP")))

IF lnSitIvaEmp = 1 .AND. Thisform.sitivacli = 1 THEN
	RETURN "A"
ENDIF

IF lnSitIvaEmp = 1 .AND. Thisform.sitivacli = 2 THEN
	RETURN "B"
ENDIF

IF lnSitIvaEmp = 1 .AND. Thisform.sitivacli = 3 THEN
	RETURN "B"
ENDIF

IF lnSitIvaEmp = 1 .AND. Thisform.sitivacli = 6 THEN
	RETURN "B"
ENDIF

IF lnSitIvaEmp = 6 THEN
	RETURN "B"
ENDIF

ENDPROC
PROCEDURE recuperar_fc
&& Este método permite recuperar la factura a la que se le va 
&& a aplicar la nota de crédito

LOCAL lcSql, loResult, loResArt, lcCodArt, lcDescripcio

loResult = CREATEOBJECT("odbc_result")
loResArt = CREATEOBJECT("odbc_result")
lcSql = ""

&& Levanto el detalle del comprobante filtrando los ítems que son válidos para
&& hacerle Nota de crédito
lcSql = "SELECT * FROM ventasdet WHERE idVentasC = " + ALLTRIM(STR(Thisform.idorigen)) + " "
lcSql = lcSql + " AND (ventasdet.Cantidad - ventasdet.cantNC) <> 0"

loResult.ActiveConnection = goConn.ActiveConnection
loResult.cursor_name = "cur_Vtas"
loResult.OpenQuery(lcSql)

SELECT cur_Vtas
IF RECCOUNT("cur_Vtas") > 0 THEN 
	GO TOP 
ELSE 
	MESSAGEBOX("Esta Factura ya no posee items a los cuales se les pueda aplicar Nota de Crédito.",0+48,thisform.Caption)
	loResult.Close_Query()
	RETURN 
ENDIF 

SELECT cur_Vtas
DO WHILE !EOF("cur_Vtas")
	lcSql = "SELECT * FROM articulos WHERE idArticulo = " + ALLTRIM(STR(cur_Vtas.idArticulo))
	loResArt.ActiveConnection = goConn.ActiveConnection
	loResArt.cursor_name = "cur_artic"
	
	IF !loResArt.OpenQuery(lcSql)
		MESSAGEBOX(loResArt.error_message, 0+48, Thisform.Caption)
		RETURN .F.
	ENDIF
	
	SELECT cur_artic
	IF RECCOUNT("cur_artic") > 0 THEN 
		GO TOP 
	ENDIF  
	
	SELECT cur_artic
	lcCodArt = cur_artic.codArt
	lcDescripcio = cur_artic.descripcio
	
	loResArt.Close_Query()

	SELECT cur_Detalle
	APPEND BLANK
	REPLACE cur_Detalle.idDetalle	WITH cur_Vtas.idVentasD
	REPLACE cur_Detalle.idArticulo 	WITH cur_Vtas.idArticulo ADDITIVE
	REPLACE cur_Detalle.codArt 		WITH lcCodArt ADDITIVE
	REPLACE cur_Detalle.descripcio 	WITH lcDescripcio ADDITIVE
	REPLACE cur_Detalle.cantidad 	WITH cur_Vtas.cantidad - cur_Vtas.cantNC ADDITIVE
	REPLACE cur_Detalle.prVta		WITH cur_Vtas.prVenta ADDITIVE
	REPLACE cur_Detalle.pDtoVta1	WITH cur_Vtas.pDtoVta1 ADDITIVE 
	REPLACE cur_Detalle.pDtoVta2	WITH cur_Vtas.pDtoVta2 ADDITIVE 
	REPLACE cur_Detalle.pDtoVta3	WITH cur_Vtas.pDtoVta3 ADDITIVE 
	REPLACE cur_Detalle.pDtoVta4	WITH cur_Vtas.pDtoVta4 ADDITIVE 
	REPLACE cur_Detalle.iDtoVta1	WITH cur_Vtas.iDtoVta1 ADDITIVE 
	REPLACE cur_Detalle.iDtoVta2	WITH cur_Vtas.iDtoVta2 ADDITIVE 
	REPLACE cur_Detalle.iDtoVta3	WITH cur_Vtas.iDtoVta3 ADDITIVE 
	REPLACE cur_Detalle.iDtoVta4	WITH cur_Vtas.iDtoVta4 ADDITIVE 
	REPLACE cur_Detalle.pDtoCli1	WITH cur_Vtas.porDesc1 ADDITIVE 
	REPLACE cur_Detalle.pDtoCli2	WITH cur_Vtas.porDesc2 ADDITIVE 
	REPLACE cur_Detalle.pDtoCli3	WITH cur_Vtas.porDesc3 ADDITIVE 
	REPLACE cur_Detalle.pDtoCli4	WITH cur_Vtas.porDesc4 ADDITIVE 
	REPLACE cur_Detalle.iDtoCli1	WITH cur_Vtas.impDesc1 ADDITIVE 
	REPLACE cur_Detalle.iDtoCli2	WITH cur_Vtas.impDesc2 ADDITIVE 
	REPLACE cur_Detalle.iDtoCli3	WITH cur_Vtas.impDesc3 ADDITIVE 
	REPLACE cur_Detalle.iDtoCli4	WITH cur_Vtas.impDesc4 ADDITIVE 
	REPLACE cur_Detalle.alicIVA 	WITH cur_Vtas.alicIVA ADDITIVE
	REPLACE cur_Detalle.impIVA 		WITH cur_Vtas.impIVA ADDITIVE
	REPLACE cur_Detalle.impNeto 	WITH cur_Vtas.impNeto ADDITIVE
	REPLACE cur_Detalle.totNeto 	WITH cur_Vtas.totNeto ADDITIVE
	REPLACE cur_Detalle.subTotal 	WITH cur_Vtas.subTotal ADDITIVE

	IF getGlobalCFG("STK_MODULE") THEN
		********************************************************************************************
		* Agrego el item al detalle de stock
		********************************************************************************************
		IF !Thisform.mov_Stock.agregar_articulo(cur_Vtas.idArticulo, cur_Vtas.cantidad - cur_Vtas.cantNC) THEN
			MESSAGEBOX(Thisform.mov_stock.ErrorMessage, 0+48, Thisform.Caption)
			loResult.Close_Query()
			RETURN .F.
		ENDIF

	ENDIF
	
	SELECT cur_Vtas
	SKIP
ENDDO

loResult.Close_Query()

SELECT cur_Detalle
IF RECCOUNT("cur_Detalle") > 0 THEN
	GO TOP
ENDIF

Thisform.contenido.txtdesc1.Value = cur_detalle.pDtoCli1
Thisform.contenido.txtdesc2.Value = cur_detalle.pDtoCli2
Thisform.contenido.txtdesc3.Value = cur_detalle.pDtoCli3
Thisform.contenido.txtdesc4.Value = cur_detalle.pDtoCli4

Thisform.Contenido.grdDetalles.Refresh()
Thisform.sumar_items()
Thisform.calcular_ret_iibb()

RETURN .T.
ENDPROC
PROCEDURE calcular_ret_iibb
&& Calculo el importe de percepción de ingresos brutos y lo anexo al total
IF (ALLTRIM(Thisform.cbte) == "PTO") THEN
	Thisform.Contenido.txtImpIIBB.Value = 0.00
ELSE 
	Thisform.Contenido.txtImpIIBB.Value = ROUND(Thisform.Contenido.txtST.Value * (Thisform.Contenido.txtPorIIBB.Value / 100), 2)
	Thisform.Contenido.txtTotFact.Value = Thisform.Contenido.txtTotFact.Value + Thisform.Contenido.txtImpIIBB.Value
ENDIF 

ENDPROC
PROCEDURE calc_item_desc
LOCAL lnDesc1, lnDesc2, lnDesc3, lnDesc4, lnNeto
LOCAL lnImpDesc1, lnImpDesc2, lnImpDesc3, lnImpDesc4
LOCAL lnImpIVA, lnAlicIVA

lnDesc1 = Thisform.contenido.txtPorDesc1.Value
lnDesc2 = Thisform.contenido.txtPorDesc2.Value
lnDesc3 = Thisform.contenido.txtPorDesc3.Value
lnDesc4 = Thisform.contenido.txtPorDesc4.Value
lnAlicIVA = Thisform.contenido.txtAlicIva.Value

lnImpDesc1 = 0.00
lnImpDesc2 = 0.00
lnImpDesc3 = 0.00
lnImpDesc4 = 0.00

IF clientes.mayorista THEN
	lnNeto = Thisform.contenido.txtPrMay.Value
ELSE
	lnNeto = Thisform.contenido.txtPrMinorista.Value
ENDIF

&& Hago el descuento extra
lnImpDesc1 = lnNeto * (lnDesc1 / 100)
lnImpDesc2 = (lnNeto - lnImpDesc1) * (lnDesc2 / 100)
lnImpDesc3 = (lnNeto - lnImpDesc1 - lnImpDesc2) * (lnDesc3 / 100)
lnImpDesc4 = (lnNeto - lnImpDesc1 - lnImpDesc2 - lnImpDesc3) * (lnDesc4 /100)

lnNeto = lnNeto - ROUND(lnImpDesc1,2) - ROUND(lnImpDesc2,2) - ROUND(lnImpDesc3,2) - ROUND(lnImpDesc4,2)

Thisform.contenido.txtImpDescItem1.Value = ROUND(lnImpDesc1, 2)
Thisform.contenido.txtImpDescItem2.Value = ROUND(lnImpDesc2, 2)
Thisform.contenido.txtImpDescItem3.Value = ROUND(lnImpDesc3, 2)
Thisform.contenido.txtImpDescItem4.Value = ROUND(lnImpDesc4, 2)
Thisform.contenido.txtPrNeto.Value = ROUND(lnNeto, 2)
Thisform.contenido.txtSTNeto.Value = ROUND((lnNeto * thisform.contenido.txtcantidad.value), 2)

* Calculo el IVA
IF (ALLTRIM(Thisform.cbte) == "PTO") THEN 
	Thisform.contenido.txtSubTotal.Value = ROUND(Thisform.contenido.txtSTNeto.Value + Thisform.contenido.txtImpIVA.Value, 2)
ELSE 
	lnImpIVA = Thisform.contenido.txtSTNeto.Value * (lnAlicIVA / 100)
	Thisform.contenido.txtImpIva.Value = ROUND(lnImpIVA, 2)
	Thisform.contenido.txtSubTotal.Value = ROUND(Thisform.contenido.txtSTNeto.Value + Thisform.contenido.txtImpIVA.Value, 2)
ENDIF 
ENDPROC
PROCEDURE recalcular_todo
LOCAL lo_artic, lcSql
LOCAL lnPorDesc1, lnPorDesc2, lnPorDesc3, lnPorDesc4
LOCAL lnImpDesc1, lnImpDesc2, lnImpDesc3, lnImpDesc4
LOCAL lnPrVtaMax, lnPrVtaMin, lnPrecio, lnNeto, lnSubTotNeto

lcSql = ""
lo_artic = CREATEOBJECT("odbc_result")

SELECT cur_detalle
IF RECCOUNT("cur_detalle") > 0 THEN
	GO TOP
ENDIF

&& Recalculo los datos de la grilla
DO WHILE !EOF("cur_Detalle")
	lcSql = "SELECT * FROM articulos WHERE articulos.idArticulo = " + ALLTRIM(STR(cur_Detalle.idArticulo))

	lo_artic.ActiveConnection = goConn.ActiveConnection
	lo_artic.cursor_name = "tmp_artic"
	
	IF !lo_artic.OpenQuery(lcSql) THEN
		MESSAGEBOX(lo_artic.error_Message, 0+16, Thisform.Caption)
		RETURN .F.
	ENDIF

	SELECT tmp_artic
	IF RECCOUNT() > 0 THEN
		SELECT cur_Detalle
		LOCK()
		
*******************************************************************************************************************************
* Recalculo los precios mayorista y minorista segun los descuentos del cliente
*******************************************************************************************************************************

		lnPorDesc1 = Thisform.contenido.txtDesc1.Value
		lnPorDesc2 = Thisform.contenido.txtDesc2.Value
		lnPorDesc3 = Thisform.contenido.txtDesc3.Value
		lnPorDesc4 = Thisform.contenido.txtDesc4.Value
		lnImpDesc1 = 0.00
		lnImpDesc2 = 0.00
		lnImpDesc3 = 0.00
		lnImpDesc4 = 0.00
		lnPrVtaMax = 0.00
		lnPrVtaMin = 0.00

		SELECT tmp_artic
		lnPrVtaMax = tmp_artic.prVentaMax
		lnPrVtaMin = tmp_artic.prVentaMin

		IF clientes.mayorista
			lnPrecio = lnPrVtaMax
		ELSE 
			lnPrecio = lnPrVtaMin
		ENDIF 	
		
		&& Calculo el precio con descuento del cliente
		lnImpDesc1 = lnPrecio * (lnPorDesc1 / 100)
		lnImpDesc2 = (lnPrecio - lnImpDesc1 ) * (lnPorDesc2 / 100)
		lnImpDesc3 = (lnPrecio - lnImpDesc1 - lnImpDesc2 ) * (lnPorDesc3 / 100)
		lnImpDesc4 = (lnPrecio - lnImpDesc1 - lnImpDesc2 - lnImpDesc3) * (lnPorDesc4 / 100)
		lnPrecio = ROUND((lnPrecio - lnImpDesc1 - lnImpDesc2 - lnImpDesc3 - lnImpDesc4),2)
		
		REPLACE cur_detalle.prVta WITH lnPrecio ADDITIVE  
		
		REPLACE cur_Detalle.pDtoCli1 WITH lnPorDesc1 ADDITIVE
		REPLACE cur_Detalle.pDtoCli2 WITH lnPorDesc2 ADDITIVE
		REPLACE cur_Detalle.pDtoCli3 WITH lnPorDesc3 ADDITIVE
		REPLACE cur_Detalle.pDtoCli4 WITH lnPorDesc4 ADDITIVE
		REPLACE cur_Detalle.iDtoCli1 WITH lnImpDesc1 ADDITIVE
		REPLACE cur_Detalle.iDtoCli2 WITH lnImpDesc2 ADDITIVE
		REPLACE cur_Detalle.iDtoCli3 WITH lnImpDesc3 ADDITIVE
		REPLACE cur_Detalle.iDtoCli4 WITH lnImpDesc4 ADDITIVE
		
*******************************************************************************************************************************
* Recalculo los precios de acuerdo al descuento de cada item
*******************************************************************************************************************************
		
		lnPorDesc1 = cur_detalle.pDtoVta1
		lnPorDesc2 = cur_detalle.pDtoVta2
		lnPorDesc3 = cur_detalle.pDtoVta3
		lnPorDesc4 = cur_detalle.pDtoVta4
		lnImpDesc1 = 0.00
		lnImpDesc2 = 0.00
		lnImpDesc3 = 0.00
		lnImpDesc4 = 0.00
		lnNeto = 0.00

		&& Calculo el precio neto
		lnImpDesc1 = lnPrecio * (lnPorDesc1 / 100)
		lnImpDesc2 = (lnPrecio - lnImpDesc1 ) * (lnPorDesc2 / 100)
		lnImpDesc3 = (lnPrecio - lnImpDesc1 - lnImpDesc2 ) * (lnPorDesc3 / 100)
		lnImpDesc4 = (lnPrecio - lnImpDesc1 - lnImpDesc2 - lnImpDesc3) * (lnPorDesc4 / 100)
		lnNeto = ROUND((lnPrecio - lnImpDesc1 - lnImpDesc2 - lnImpDesc3 - lnImpDesc4),2)

		REPLACE cur_Detalle.iDtoVta1 WITH lnImpDesc1 ADDITIVE
		REPLACE cur_Detalle.iDtoVta2 WITH lnImpDesc2 ADDITIVE
		REPLACE cur_Detalle.iDtoVta3 WITH lnImpDesc3 ADDITIVE
		REPLACE cur_Detalle.iDtoVta4 WITH lnImpDesc4 ADDITIVE
*******************************************************************************************************************************
* Recalculo el IVA y los Subtotales
*******************************************************************************************************************************
		REPLACE cur_detalle.impNeto WITH lnNeto ADDITIVE 
		
		lnSubTotNeto = lnNeto * cur_Detalle.cantidad
		
		IF (ALLTRIM(Thisform.cbte) == "PTO") THEN
			REPLACE cur_Detalle.impIVA WITH 0 ADDITIVE
			REPLACE cur_Detalle.alicIVA WITH 0 ADDITIVE
		ELSE
			REPLACE cur_Detalle.impIVA WITH ROUND(lnSubTotNeto * (tmp_artic.alicIVA / 100),2) ADDITIVE
			REPLACE cur_Detalle.alicIVA WITH tmp_artic.alicIVA ADDITIVE
		ENDIF
		
		REPLACE cur_Detalle.totNeto WITH ROUND(lnSubTotNeto,2)  ADDITIVE
		
		IF (ALLTRIM(Thisform.cbte) == "PTO") THEN
			REPLACE cur_Detalle.subTotal WITH cur_Detalle.totNeto ADDITIVE		
		ELSE 
			REPLACE cur_Detalle.subTotal WITH ROUND(cur_Detalle.totNeto + cur_Detalle.totNeto * (tmp_artic.alicIVA / 100),2) ADDITIVE
		ENDIF 
		UNLOCK
	ENDIF

	lo_artic.close_query()
		
	SELECT cur_Detalle
	SKIP
ENDDO

&& Recalculo los datos de la pantalla
lnPorDesc1 = Thisform.contenido.txtDesc1.Value * -1
lnPorDesc2 = Thisform.contenido.txtDesc2.Value * -1
lnPorDesc3 = Thisform.contenido.txtDesc3.Value * -1
lnPorDesc4 = Thisform.contenido.txtDesc4.Value * -1
lnImpDesc1 = 0.00
lnImpDesc2 = 0.00
lnImpDesc3 = 0.00
lnImpDesc4 = 0.00
lnPrVtaMax = 0.00
lnPrVtaMin = 0.00


lcSql = "SELECT * FROM articulos WHERE idarticulo = " + ALLTRIM(STR(thisform.contenido.sel_Articulo.valcpoid))

lo_artic.ActiveConnection = goConn.ActiveConnection
lo_artic.cursor_name = "tmp_artic"

IF !lo_artic.OpenQuery(lcSql) THEN
	MESSAGEBOX(lo_artic.error_Message, 0+16, Thisform.Caption)
	RETURN .F.
ENDIF


SELECT tmp_artic
IF RECCOUNT() > 0 THEN
	SELECT tmp_artic
	lnPrVtaMax = tmp_artic.prVentaMax
	lnPrVtaMin = tmp_artic.prVentaMin

	&& Calculo el precio mayorista con descuento
	lnImpDesc1 = lnPrVtaMax + (lnPrVtaMax * (lnPorDesc1 / 100))
	lnImpDesc2 = lnImpDesc1 + (lnImpDesc1 * (lnPorDesc2 / 100))
	lnImpDesc3 = lnImpDesc2 + (lnImpDesc2 * (lnPorDesc3 / 100))
	lnImpDesc4 = lnImpDesc3 + (lnImpDesc3 * (lnPorDesc4 / 100))
	Thisform.contenido.txtPrMay.Value = ROUND(lnImpDesc4, 2)

	&& Calculo el precio minorista con descuento
	lnImpDesc1 = lnPrVtaMin + (lnPrVtaMin * (lnPorDesc1 / 100))
	lnImpDesc2 = lnImpDesc1 + (lnImpDesc1 * (lnPorDesc2 / 100))
	lnImpDesc3 = lnImpDesc2 + (lnImpDesc2 * (lnPorDesc3 / 100))
	lnImpDesc4 = lnImpDesc3 + (lnImpDesc3 * (lnPorDesc4 / 100))
	Thisform.contenido.txtPrMinorista.Value = ROUND(lnImpDesc4, 2)
	thisform.contenido.txtAlicIVA.Value = articulos.alicIVA
ENDIF 

lo_artic.close_query()

Thisform.contenido.grdDetalles.Refresh()
Thisform.sumar_items()
Thisform.calc_item_desc()
Thisform.calcular_ret_iibb()

RETURN .T.
ENDPROC
PROCEDURE recuperar_ped
&& Este método permite recuperar los pedidos para facturar.

LOCAL lcSql, loResult, loResArt, lcCodArt, lcDescripcio

loResult = CREATEOBJECT("odbc_result")
loResArt = CREATEOBJECT("odbc_result")
lcSql = ""

&& Levanto el detalle del comprobante 
lcSql = "SELECT * FROM ventasdet WHERE idVentasC = " + ALLTRIM(STR(Thisform.idorigen)) + " "

loResult.ActiveConnection = goConn.ActiveConnection
loResult.cursor_name = "cur_Vtas"
loResult.OpenQuery(lcSql)


SELECT cur_Vtas
IF RECCOUNT("cur_Vtas") > 0 THEN 
	GO TOP 
ENDIF 

SELECT cur_Vtas
DO WHILE !EOF("cur_Vtas")
	lcSql = "SELECT * FROM articulos WHERE idArticulo = " + ALLTRIM(STR(cur_Vtas.idArticulo))
	loResArt.ActiveConnection = goConn.ActiveConnection
	loResArt.cursor_name = "cur_artic"
	
	IF !loResArt.OpenQuery(lcSql)
		MESSAGEBOX(loResArt.error_message, 0+48, Thisform.Caption)
		RETURN .F.
	ENDIF
	
	SELECT cur_artic
	IF RECCOUNT("cur_artic") > 0 THEN 
		GO TOP 
	ENDIF  
	
	SELECT cur_artic
	lcCodArt = cur_artic.codArt
	lcDescripcio = cur_artic.descripcio
	
	loResArt.Close_Query()

	SELECT cur_Detalle
	APPEND BLANK
	REPLACE cur_Detalle.idDetalle	WITH cur_Vtas.idVentasD
	REPLACE cur_Detalle.idArticulo 	WITH cur_Vtas.idArticulo ADDITIVE
	REPLACE cur_Detalle.codArt 		WITH lcCodArt ADDITIVE
	REPLACE cur_Detalle.descripcio 	WITH lcDescripcio ADDITIVE
	REPLACE cur_Detalle.cantidad 	WITH cur_Vtas.cantidad - cur_Vtas.cantNC ADDITIVE
	REPLACE cur_Detalle.prVta		WITH cur_Vtas.prVenta ADDITIVE
	REPLACE cur_Detalle.pDtoVta1	WITH cur_Vtas.pDtoVta1 ADDITIVE 
	REPLACE cur_Detalle.pDtoVta2	WITH cur_Vtas.pDtoVta2 ADDITIVE 
	REPLACE cur_Detalle.pDtoVta3	WITH cur_Vtas.pDtoVta3 ADDITIVE 
	REPLACE cur_Detalle.pDtoVta4	WITH cur_Vtas.pDtoVta4 ADDITIVE 
	REPLACE cur_Detalle.iDtoVta1	WITH cur_Vtas.iDtoVta1 ADDITIVE 
	REPLACE cur_Detalle.iDtoVta2	WITH cur_Vtas.iDtoVta2 ADDITIVE 
	REPLACE cur_Detalle.iDtoVta3	WITH cur_Vtas.iDtoVta3 ADDITIVE 
	REPLACE cur_Detalle.iDtoVta4	WITH cur_Vtas.iDtoVta4 ADDITIVE 
	REPLACE cur_Detalle.pDtoCli1	WITH cur_Vtas.porDesc1 ADDITIVE 
	REPLACE cur_Detalle.pDtoCli2	WITH cur_Vtas.porDesc2 ADDITIVE 
	REPLACE cur_Detalle.pDtoCli3	WITH cur_Vtas.porDesc3 ADDITIVE 
	REPLACE cur_Detalle.pDtoCli4	WITH cur_Vtas.porDesc4 ADDITIVE 
	REPLACE cur_Detalle.iDtoCli1	WITH cur_Vtas.impDesc1 ADDITIVE 
	REPLACE cur_Detalle.iDtoCli2	WITH cur_Vtas.impDesc2 ADDITIVE 
	REPLACE cur_Detalle.iDtoCli3	WITH cur_Vtas.impDesc3 ADDITIVE 
	REPLACE cur_Detalle.iDtoCli4	WITH cur_Vtas.impDesc4 ADDITIVE 
	REPLACE cur_Detalle.alicIVA 	WITH cur_Vtas.alicIVA ADDITIVE
	REPLACE cur_Detalle.impIVA 		WITH cur_Vtas.impIVA ADDITIVE
	REPLACE cur_Detalle.impNeto 	WITH cur_Vtas.impNeto ADDITIVE
	REPLACE cur_Detalle.totNeto 	WITH cur_Vtas.totNeto ADDITIVE
	REPLACE cur_Detalle.subTotal 	WITH cur_Vtas.subTotal ADDITIVE

	IF getGlobalCFG("STK_MODULE") THEN
		********************************************************************************************
		* Agrego el item al detalle de stock
		********************************************************************************************
		IF !Thisform.mov_Stock.agregar_articulo(cur_Vtas.idArticulo, cur_Vtas.cantidad - cur_Vtas.cantNC) THEN
			MESSAGEBOX(Thisform.mov_stock.ErrorMessage, 0+48, Thisform.Caption)
			loResult.Close_Query()
			RETURN .F.
		ENDIF
	ENDIF 
	
	SELECT cur_Vtas
	SKIP
ENDDO

loResult.Close_Query()

SELECT cur_Detalle
IF RECCOUNT("cur_Detalle") > 0 THEN
	GO TOP
ENDIF

Thisform.contenido.txtdesc1.Value = cur_detalle.pDtoCli1
Thisform.contenido.txtdesc2.Value = cur_detalle.pDtoCli2
Thisform.contenido.txtdesc3.Value = cur_detalle.pDtoCli3
Thisform.contenido.txtdesc4.Value = cur_detalle.pDtoCli4

Thisform.Contenido.grdDetalles.Refresh()
Thisform.sumar_items()
Thisform.calcular_ret_iibb()

RETURN .T.
ENDPROC
PROCEDURE Init
Thisform.ShowTips = .T.

Thisform.mov_stock.circuito = "V"
Thisform.mov_stock.crear_cursor()

IF getConfig("PRIOSAL") == "ON"
	Thisform.Contenido.chkCalcIVA.Visible = .T.
ELSE
	Thisform.Contenido.chkCalcIVA.Visible = .F.
ENDIF

IF ALLTRIM(Thisform.cbte) == "PTO" THEN
	Thisform.mov_stock.tipomov = "SAL"
ELSE 
	IF ALLTRIM(Thisform.cbte) == "NC" THEN
		Thisform.Contenido.btnCbteOrigen.Visible = .T.
		Thisform.contenido.txtdesc1.Enabled = .F.
	    Thisform.contenido.txtdesc2.Enabled = .F.
		Thisform.contenido.txtdesc3.Enabled = .F.
		Thisform.contenido.txtdesc4.Enabled = .F.
		Thisform.mov_stock.tipomov = "ENT"
	ELSE
		IF ALLTRIM(Thisform.cbte) == "FC" THEN
			Thisform.Contenido.btnCbteOrigen.Visible = .T.
			Thisform.Contenido.btnCbteOrigen.Caption = "Leer Pedido"
			Thisform.mov_stock.tipomov = "SAL"
		ELSE
			IF ALLTRIM(Thisform.cbte) == "PED" THEN
				Thisform.Contenido.btnCbteOrigen.Visible = .T.
				Thisform.Contenido.btnCbteOrigen.Caption = "Descargar Pedido"
			ELSE
				Thisform.Contenido.btnCbteOrigen.Visible = .F.
			ENDIF
		ENDIF
	ENDIF
ENDIF 

Thisform.saldo_fc = 0.00
Thisform.idorigen = 0

&& A partir de la configuración, el sistema indica si debe utilizar impresora fiscal
&& o no.
IF ALLTRIM(GetConfig("USA_FISCAL")) == "S" THEN
	Thisform.usar_fiscal = .T.
	Thisform.Fiscal.modelo = 8  && MODELO_P320
ELSE
	Thisform.usar_fiscal = .F.
ENDIF

IF getGlobalCFG("STK_MODULE") THEN
	Thisform.Contenido.lblExistencia.Visible = .T.
	Thisform.Contenido.txtExistencia.Visible = .T.
ELSE
	Thisform.Contenido.lblExistencia.Visible = .F.
	Thisform.Contenido.txtExistencia.Visible = .F.
ENDIF



ENDPROC
PROCEDURE Load
DODEFAULT()

CREATE CURSOR cur_PedExt (	;
	codArt			varchar(20),;
	cantidad		int)

CREATE CURSOR cur_Detalle (	;
	idDetalle		int			,;
	idArticulo		int 		,;
	codArt			C(20)		,;
	descripcio		C(60)		,;
	cantidad		float(10,2)	,;
	prVta			float(10,2)	,;
	pDtoVta1		float(10,2)	,;
	pDtoVta2		float(10,2)	,;
	pDtoVta3		float(10,2)	,;
	pDtoVta4		float(10,2)	,;
	iDtoVta1		float(10,2)	,;
	iDtoVta2		float(10,2)	,;
	iDtoVta3		float(10,2)	,;
	iDtoVta4		float(10,2)	,;
	pDtoCli1		float(10,2)	,;
	pDtoCli2		float(10,2)	,;
	pDtoCli3		float(10,2)	,;
	pDtoCli4		float(10,2)	,;
	iDtoCli1		float(10,2)	,;
	iDtoCli2		float(10,2)	,;
	iDtoCli3		float(10,2)	,;
	iDtoCli4		float(10,2)	,;	
	alicIVA			float(10,2)	,;
	impIVA			float(10,2)	,;
	impNeto			float(10,2)	,;		
	totNeto			float(10,2)	,;
	subTotal		float(10, 2),;
	stkDisp			float(10, 2))

SELECT cur_Detalle

&& Si usa impresora fiscal, agrego estas líneas para que el formulario
&& tenga soporte a los eventos del control OCX que se inserto para el
&& manejo de impresoras fiscales
IF ALLTRIM(GetConfig("USA_FISCAL")) == "S" THEN
	SYS(2333, 0)
	_VFP.AutoYield = .F.
	
	RETURN
ENDIF


ENDPROC
PROCEDURE validarcampos
IF Thisform.Contenido.Sel_Cliente.estavacio() .AND. ALLTRIM(Thisform.Contenido.Sel_Cliente.txtDescripcion.Value) == ""
	MESSAGEBOX("Debe ingresar el cliente", 0+48, Thisform.Caption)
	Thisform.Contenido.sel_Cliente.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

IF Thisform.Contenido.sel_FormaPago.EstaVacio()
	MESSAGEBOX("Debe ingresar la forma de pago", 0+48, Thisform.Caption)
	Thisform.Contenido.sel_FormaPago.txtCodigo.SetFocus()
	RETURN .F.
ENDIF


SELECT cur_Detalle
IF RECCOUNT() = 0
	MESSAGEBOX("Debe ingresar al menos un artículo", 0+48, Thisform.Caption)
	Thisform.Contenido.sel_Articulo.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

IF ALLTRIM(Thisform.cbte) == "NC" THEN
	IF thisform.saldo_fc <> 0 THEN
		IF Thisform.Contenido.txtTotFact.Value > thisform.saldo_fc THEN
			MESSAGEBOX("No puede realizar una nota de crédito mayor al saldo de cuenta corriente de la factura", 0+48, Thisform.Caption)
			RETURN .F.
		ENDIF
	ENDIF
ENDIF

RETURN .T.

ENDPROC
PROCEDURE validardetalle
IF ALLTRIM(Thisform.Contenido.sel_Articulo.txtCodigo.Value) == ""
	MESSAGEBOX("Debe ingresar el artículo", 0+48, Thisform.Caption)
	Thisform.Contenido.sel_Articulo.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

IF Thisform.Contenido.txtCantidad.Value = 0
	MESSAGEBOX("Falta ingresar la cantidad", 0+48, Thisform.Caption)
	Thisform.Contenido.txtCantidad.SetFocus()
	RETURN .F.
ENDIF

IF Thisform.Contenido.txtCantidad.Value < 0 THEN
	MESSAGEBOX("La cantidad ingresada no puede ser un valor negativo", 0+48, Thisform.Caption)
	Thisform.Contenido.txtCantidad.SetFocus()
	RETURN .F.
ENDIF

IF (ALLTRIM(Thisform.cbte) != "COT") .AND. (ALLTRIM(Thisform.cbte) != "NC") THEN
	IF getGlobalCFG("STK_MODULE") THEN
		IF Thisform.mov_stock.get_exist_byart(Thisform.Contenido.sel_Articulo.valcpoid) <= 0 THEN
			MESSAGEBOX("No hay stock disponible", 0+48, Thisform.Caption)
			Thisform.Contenido.sel_Articulo.txtCodigo.SetFocus()
			
			&& Si es un pedido, entonces lo dejo continuar
			IF !(ALLTRIM(Thisform.cbte) == "PED") THEN
				RETURN .F.
			ENDIF
		ENDIF
	ENDIF
ENDIF


RETURN .T.


ENDPROC
PROCEDURE grabar
&& Grabo la info en la base

LOCAL lnIdVentasC, lnIdCliente, lcFecEmis, lcCbte, lcTipoDoc, lnPtoVta
LOCAL lnNroCbte, llAnulado, lnImpNeto, lnImpFinal, lnPorIVA21, lnImpIVA21
LOCAL lnPorIVA105, lnImpIVA105, lnPorDesc1, lnPorDesc2, lnPorDesc3, lnPorDesc4
LOCAL lnImpDesc1, lnImpDesc2, lnImpDesc3, lnImpDesc4, lnTotFact
LOCAL lnIdVentasD, lnIdArticulo, lnCantidad, lnCostoRep, lnPrVenta, lnAlicIVA, lnImpIVA
LOCAL lnTotNeto, lnSubTotal, lnSaldo, lcObserv, lnPorIIBB, lnImpIIBB
LOCAL lnPDtoVta1, lnPDtoVta2, lnPDtoVta3, lnPDtoVta4, lnIDtoVta1, lnIDtoVta2, lnIDtoVta3, lnIDtoVta4
LOCAL lnIdCondPago, lnIdSitIVA
LOCAL ldFecVto, lnIdOper, oDT
LOCAL loNumerador, lcSql, loCommand, loArtic, loOper, lnSqlSrv, lnPrNeto, lnIdCCOrig, loCliente, lnIdVendedor

&& Inicializo las variables del detalle

lnIdVentasD = 0
lnIdArticulo = 0
lnCantidad = 0
lnCostoRep = 0.00
lnPrVenta = 0.00
lnAlicIVA = 0.00
lnImpIVA = 0.00
lnTotNeto = 0.00
lnSubTotal = 0.00
ldFecVto = {}
lnIdOper = 0
lnSaldo = 0
oDT = CREATEOBJECT("datetime")
loArtic = CREATEOBJECT("odbc_result")
loOper = CREATEOBJECT("odbc_result")
loCliente = CREATEOBJECT("odbc_result")
loCommand = CREATEOBJECT("odbc_command")
lnSqlSrv = INT(VAL(getconfig("SQLSRV")))
lcObserv = Thisform.Contenido.txtObserv.Value
lnPorIIBB = 0.00
lnImpIIBB = 0.00
lnPDtoVta1 = 0.00
lnPDtoVta2 = 0.00
lnPDtoVta3 = 0.00
lnPDtoVta4 = 0.00
lnIDtoVta1 = 0.00
lnIDtoVta2 = 0.00
lnIDtoVta3 = 0.00
lnIDtoVta4 = 0.00
lnImpDesc1 = 0.00
lnImpDesc2 = 0.00
lnImpDesc3 = 0.00
lnImpDesc4 = 0.00
lnPrNeto = 0.00
lnCondPago = 0
lnIdSitIVA = 0
lnIdVendedor = 0

&& Asigno los valores de la cabecera

lnIdCliente = Thisform.Contenido.sel_Cliente.ValCpoId

&& Asigno el idvendedor
lcSql = "SELECT * FROM Clientes WHERE idCliente = " + ALLTRIM(STR(lnIdCliente))
loCliente.ActiveConnection = goConn.ActiveConnection
loCliente.Cursor_Name = "cur_cliente"
loCliente.OpenQuery(lcSql)

lnIdVendedor = cur_cliente.idVendedor

loCliente.Close_Query()

lcFecEmis = ALLTRIM(STR(YEAR(DATETIME()))) + "-" + ALLTRIM(STR(MONTH(DATETIME()))) + " - " + ;
	ALLTRIM(STR(DAY(DATETIME())))
	
lcCbte = Thisform.Cbte

IF lcCbte == "COT"
	lcTipoDoc = "X"
	Thisform.tipodoc = lcTipoDoc
ELSE
	&& Aca tengo que agregar el cálculo en caso que sea
	&& comprobante fiscal
	IF lcCbte == "PED"
		lcTipoDoc = "P"
		Thisform.tipodoc = lcTipoDoc
	ELSE
		lcTipoDoc = thisform.calcular_tipodoc()
		Thisform.tipodoc = lcTipoDoc
	ENDIF
ENDIF


IF lcCbte == "PTO" THEN
	lnPtoVta = 9999
	lcTipoDoc = "X"
	Thisform.tipodoc = lcTipoDoc
ELSE
	lnPtoVta = INT(VAL(ALLTRIM(getconfig("PTOVTA"))))
ENDIF

Thisform.ptovta = REPLICATE("0", 4 - LEN(ALLTRIM(STR(lnPtoVta)))) + ALLTRIM(STR(lnPtoVta))

IF Thisform.usar_fiscal THEN
	Thisform.enviar_fiscal()
	lnNroCbte = Thisform.fis_numcbte
	
	IF lnNroCbte = 0 THEN
		MESSAGEBOX("Error en el controlador fiscal, la factura no se grabará", 0+48, Thisform.Caption)
		RETURN .F.
	ENDIF
ELSE
	&& En caso que el sistema no use controlador fiscal, entonces,
	&& el número debe generarlo a partir de la tabla numerador de la
	&& base de datos
	
	lcSql = "select * from numerador where cbte = '" + ALLTRIM(lcCbte) + "' and tipoDoc = '" + ALLTRIM(lcTipoDoc) + "' AND ptoVta = " + ALLTRIM(STR(lnPtoVta))
	loNumerador = CREATEOBJECT("odbc_result")
	loNumerador.ActiveConnection = goConn.ActiveConnection
	loNumerador.Cursor_Name = "cur_num"
	loNumerador.OpenQuery(lcSql)
	SELECT cur_num

	IF RECCOUNT("cur_num") = 0 THEN
		MESSAGEBOX("No se encuentra configurado el numerador del comprobante " + ALLTRIM(lcCbte) + " Punto de Venta: " + ALLTRIM(STR(lnPtoVta)) + " Letra: " + ALLTRIM(lcTipoDoc), 0+48, thisform.Caption)
		loNumerador.close_query()
		RETURN .F.
	ENDIF

	SELECT cur_num
	lnNroCbte = cur_num.numActual + 1
	Thisform.printerDevice = cur_num.impresora

	loNumerador.close_query()	
	
	&& Actualizo el numerador
	lcSql = "update numerador set numActual = " + ALLTRIM(STR(lnNroCbte)) + ;
		" where cbte = '" + ALLTRIM(lcCbte) + "' and tipoDoc = '" + ALLTRIM(lcTipoDoc) + "'"

	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql

	IF !loCommand.Execute()
		goConn.Rollback()
		RETURN .F.
	ENDIF	
ENDIF

llAnulado = .F.
lnImpNeto = Thisform.Contenido.txtTotNeto.Value
lnImpFinal = Thisform.Contenido.txtST.Value
lnPorIVA21 = Thisform.Contenido.txtPorIVA21.Value
lnPorIVA105 = Thisform.Contenido.txtPorIVA105.Value
lnImpIVA21 = Thisform.Contenido.txtImpIva21.Value
lnImpIVA105 = Thisform.Contenido.txtImpIva105.Value
lnPorIIBB= Thisform.contenido.txtPorIIBB.Value
lnImpIIBB = thisform.contenido.txtImpIIBB.Value
lnPorDesc1 = thisform.contenido.txtDesc1.Value
lnPorDesc2 = thisform.contenido.txtdesc2.Value
lnPorDesc3 = Thisform.contenido.txtdesc3.Value
lnPorDesc4 = Thisform.contenido.txtdesc4.Value
SELECT cur_detalle
GO TOP 
DO WHILE !EOF()
	lnImpDesc1 = lnImpDesc1 + cur_detalle.iDtoCli1 * cur_detalle.cantidad
	lnImpDesc2 = lnImpDesc2 + cur_detalle.iDtoCli2 * cur_detalle.cantidad
	lnImpDesc3 = lnImpDesc3 + cur_detalle.iDtoCli3 * cur_detalle.cantidad
	lnImpDesc4 = lnImpDesc4 + cur_detalle.iDtoCli4 * cur_detalle.cantidad
	
	SELECT cur_detalle
	SKIP 
ENDDO 
lnTotFact = Thisform.Contenido.txtTotFact.Value
lnIdCondPago = clientes.idCondPago
lnIdSitIVA = clientes.idSitIVA


IF ALLTRIM(Thisform.cbte) == "FC" THEN
	lnSaldo = Thisform.Contenido.txtTotFact.Value
ELSE
	lnSaldo = 0
ENDIF

goConn.BeginTransaction()
lnIdVentasC = goConn.GetNextID("ventascab", "idVentasC")

lcSql = "INSERT INTO ventascab ( "
lcSql = lcSql + "idVentasC, idCliente, fecEmision, cbte, tipoDoc, ptoVta, numCbte, anulado, idCondPago, idSitIVA, idVendedor,"
lcSql = lcSql + "impNeto, impFinal, porIVA21, impIVA21, porIVA105, impIVA105, porDesc1, "
lcSql = lcSql + "porDesc2, porDesc3, porDesc4, impDesc1, impDesc2, impDesc3, impDesc4, totFact, Saldo, usuAlta, fecAlta, idHostAlta, observ, porIIBB, impIIBB) VALUES ("
lcSql = lcSql + ALLTRIM(STR(lnIdVentasC)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnIdCliente)) + ", "
lcSql = lcSql + oDT.getDateTime() + ", "
lcSql = lcSql + "'" + ALLTRIM(lcCbte) + "', "
lcSql = lcSql + "'" + ALLTRIM(lcTipoDoc) + "', "
lcSql = lcSql + ALLTRIM(STR(lnPtoVta)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnNroCbte)) + ", "
lcSql = lcSql + IIF(lnSqlSrv = 0, "false", "0") + ", "
lcSql = lcSql + ALLTRIM(STR(lnIdCondPago)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnIdSitIVA)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnIdVendedor)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnImpNeto, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnImpFinal, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnPorIVA21, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnImpIVA21, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnPorIVA105, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnImpIVA105, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnPorDesc1, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnPorDesc2, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnPorDesc3, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnPorDesc4, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnImpDesc1, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnImpDesc2, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnImpDesc3, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnImpDesc4, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnTotFact, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnSaldo, 10, 2)) + ", "
lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', " 
lcSql = lcSql + oDT.getDateTime() + ", "
lcSql = lcSql + "'" + SYS(0) + "', '" + ALLTRIM(lcObserv) + "', "
lcSql = lcSql + ALLTRIM(STR(lnPorIIBB, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnImpIIBB, 10, 2)) + ")"

loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = lcSql

IF !loCommand.Execute()
	goConn.Rollback()
	RETURN .F.
ENDIF

&& Grabo el detalle del comprobante

SELECT cur_Detalle
IF RECCOUNT() > 0
	GO TOP
ENDIF

lnIdVentasD = 0

DO WHILE !EOF()
	&& lnIdVentasD = goConn.GetNextID("ventasdet", "idVentasD")
	lnIdVentasD = lnIdVentasD + 1
	
	lnIdArticulo = cur_Detalle.idArticulo
	lnCantidad = cur_Detalle.cantidad
	lnAlicIVA = cur_Detalle.alicIVA
	lnPrVenta = cur_Detalle.PrVta
	lnImpIVA = cur_Detalle.impIVA
	lnPrNeto = cur_Detalle.impNeto
	lnTotNeto = cur_Detalle.totNeto
	lnSubTotal = cur_Detalle.subTotal
	lnPDtoVta1 = cur_Detalle.pDtoVta1
	lnPDtoVta2 = cur_Detalle.pDtoVta2
	lnPDtoVta3 = cur_Detalle.pDtoVta3
	lnPDtoVta4 = cur_Detalle.pDtoVta4
	lnIDtoVta1 = cur_Detalle.iDtoVta1
	lnIDtoVta2 = cur_Detalle.iDtoVta2
	lnIDtoVta3 = cur_Detalle.iDtoVta3
	lnIDtoVta4 = cur_Detalle.iDtoVta4
	
	lnPorDesc1 = cur_Detalle.pDtoCli1
	lnPorDesc2 = cur_Detalle.pDtoCli2
	lnPorDesc3 = cur_Detalle.pDtoCli3
	lnPorDesc4 = cur_Detalle.pDtoCli4
	lnImpDesc1 = cur_Detalle.iDtoCli1
	lnImpDesc2 = cur_Detalle.iDtoCli2
	lnImpDesc3 = cur_Detalle.iDtoCli3
	lnImpDesc4 = cur_Detalle.iDtoCli4
	
	lcSql = "SELECT * FROM articulos WHERE idArticulo = " + ALLTRIM(STR(lnIdArticulo))
	loArtic.ActiveConnection = goConn.ActiveConnection
	loArtic.Cursor_Name = "cur_Artic"
	loArtic.OpenQuery(lcSql)
	
	SELECT cur_Artic
	lnCostoRep = cur_Artic.costoRep
	
	loArtic.close_query()

	lcSql = "INSERT INTO ventasdet ( "
	lcSql = lcSql + "idVentasD, "
	lcSql = lcSql + "idVentasC, "
	lcSql = lcSql + "idArticulo, "
	lcSql = lcSql + "Cantidad, "
	lcSql = lcSql + "costoRep, "
	lcSql = lcSql + "prVenta, "
	lcSql = lcSql + "alicIVA, "
	lcSql = lcSql + "impIVA, "
	lcSql = lcSql + "subTotal, "
	lcSql = lcSql + "porDesc1, "
	lcSql = lcSql + "porDesc2, "
	lcSql = lcSql + "porDesc3, "
	lcSql = lcSql + "porDesc4, "
	lcSql = lcSql + "impDesc1, "
	lcSql = lcSql + "impDesc2, "
	lcSql = lcSql + "impDesc3, "
	lcSql = lcSql + "impDesc4, "
	lcSql = lcSql + "pDtoVta1, "
	lcSql = lcSql + "pDtoVta2, "
	lcSql = lcSql + "pDtoVta3, "
	lcSql = lcSql + "pDtoVta4, "
	lcSql = lcSql + "iDtoVta1, "
	lcSql = lcSql + "iDtoVta2, "
	lcSql = lcSql + "iDtoVta3, "
	lcSql = lcSql + "iDtoVta4, "
	lcSql = lcSql + "impNeto, "
	lcSql = lcSql + "totNeto) VALUES ( "
	lcSql = lcSql + ALLTRIM(STR(lnIdVentasD)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnIdVentasC)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnIdArticulo)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnCantidad)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnCostoRep, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPrVenta, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnAlicIVA, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnImpIVA, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnSubTotal, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPorDesc1, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPorDesc2, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPorDesc3, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPorDesc4, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnImpDesc1, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnImpDesc2, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnImpDesc3, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnImpDesc4, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPDtoVta1, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPDtoVta2, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPDtoVta3, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPDtoVta4, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnIDtoVta1, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnIDtoVta2, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnIDtoVta3, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnIDtoVta4, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPrNeto, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnTotNeto, 10, 2)) + ")"
	
	*******************************************************************************************
	
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute()
		goConn.Rollback()
		RETURN .F.
	ENDIF
	
	&& Si es nota de crédito entonces, actualizo la cantidad de NC en los
	&& items de la factura.
	&& Actualizar este dato tiene como objetivo de que si se hace más una NC
	&& que no se pueda hacer dos veces sobre la misma cantidad de un producto
	&& sino que por el resto.
	
	IF ALLTRIM(Thisform.cbte) == "NC" THEN
		lcSql = "UPDATE ventasdet SET cantNC = " + ALLTRIM(STR(lnCantidad)) + " "
		lcSql = lcSql + "WHERE idVentasC = " + ALLTRIM(STR(Thisform.idorigen)) + " "
		lcSql = lcSql + " AND idArticulo = " + ALLTRIM(STR(cur_Detalle.idArticulo))
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			RETURN .F.
		ENDIF
	ENDIF

	SELECT cur_Detalle
	SKIP
ENDDO

IF ALLTRIM(thisform.cbte) == "FC" THEN
	lnProxID = goConn.GetNextId("cc_cli", "idCC_Cli")
	lnIdCliente = Thisform.contenido.sel_Cliente.valcpoid
	
	&& Calculo la fecha de vencimiento correspondiente a la factura
	IF thisform.cp_cntdias <> 0 THEN
		ldFecVto = DATE() + thisform.cp_cntdias
	ELSE
		ldFecVto = DATE()
	ENDIF
	
	&& Inserto el registro correspondiente a la factura en la tabla de cuentas corrientes
	lcSql = "INSERT INTO cc_cli (idCC_Cli, idCliente, idCC_Orig, cbte, nroCbte, tipoDoc, ptoVta, idCondPago, idSitIVA, idVendedor, "
	lcSql = lcSql + "fecEmis, fecVto, impDebe, impHaber, idOper, idVentasC, usuAlta, fecAlta, idHostAlta) VALUES ( "
	lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", " + ALLTRIM(STR(lnIdCliente)) + ", null, '" + ALLTRIM(lcCbte) + "', "
	lcSql = lcSql + ALLTRIM(STR(lnNroCbte)) + ", '" + ALLTRIM(lcTipoDoc) + "', " + ALLTRIM(STR(lnPtoVta)) + ", " + ALLTRIM(STR(lnIdCondPago)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnIdSitIVA)) + ", " + ALLTRIM(STR(lnIdVendedor)) + ", " + oDT.getDateTime() + ", "
	lcSql = lcsql + oDT.toMySql(ldFecVto) + ", " + ALLTRIM(STR(lnTotFact, 10, 2)) + ", 0, 0, " + ALLTRIM(STR(lnIdVentasC)) + ", "
	lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', " + oDT.getDateTime() + ", '" + ALLTRIM(SYS(0)) + "')"
	
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute()
		goConn.Rollback()
		RETURN .F.
	ENDIF
ELSE
	IF ALLTRIM(Thisform.cbte) == "NC" THEN
		&& Verifico si tiene numero de operación asignado
		lcSql = "SELECT idCC_Cli, idOper FROM cc_cli WHERE idVentasC = " + ALLTRIM(STR(Thisform.idorigen))
		loOper.ActiveConnection = goConn.ActiveConnection
		loOper.Cursor_Name = "cur_Oper"
		loOper.OpenQuery(lcSql)
		
		lnIdCCOrig = cur_Oper.idCC_Cli
		lnIdOper = cur_Oper.idOper
		
		loOper.Close_Query()
		
		&& Tengo que calcular el Id de Operación para vincular ambos comprobantes
		IF lnIdOper = 0 THEN
			lcSql = "SELECT MAX(cc_cli.idOper) AS maxIdOper FROM cc_cli"
			loOper.ActiveConnection = goConn.ActiveConnection
			loOper.Cursor_Name = "cur_Oper"
			loOper.OpenQuery(lcSql)
			
			lnIdOper = cur_Oper.maxIdOper + 1
			
			loOper.Close_Query()
		
			&& Actualizo el comprobante de origen con el Id de Operación calculado
			lcSql = "UPDATE cc_cli SET idOper = " + ALLTRIM(STR(lnIdOper)) + " WHERE idVentasC = " + ALLTRIM(STR(Thisform.idorigen))
			loCommand.ActiveConnection = goConn.ActiveConnection
			loCommand.CommandText = lcSql
		
			IF !loCommand.Execute()
				goConn.Rollback()
				RETURN .F.
			ENDIF	
		ENDIF
		
		&& Genero el registro de la nota de crédito en las cuentas corrientes del cliente
		
		lnProxID = goConn.GetNextId("cc_cli", "idCC_Cli")
		lnIdCliente = Thisform.contenido.sel_Cliente.valcpoid	
		
		lcSql = "INSERT INTO cc_cli (idCC_Cli, idCliente, idCC_Orig, cbte, nroCbte, tipoDoc, ptoVta, idCondPago, idSitIVA, idVendedor, "
		lcSql = lcSql + "fecEmis, impDebe, impHaber, idOper, idVentasC, usuAlta, fecAlta, idHostAlta) VALUES ( "
		lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", " + ALLTRIM(STR(lnIdCliente)) + ", " + ALLTRIM(STR(lnIdCCOrig)) + ", '" + ALLTRIM(lcCbte) + "', "
		lcSql = lcSql + ALLTRIM(STR(lnNroCbte)) + ", '" + ALLTRIM(lcTipoDoc) + "', " + ALLTRIM(STR(lnPtoVta)) + ", " + ALLTRIM(STR(lnIdCondPago)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnIdSitIVA)) + ", " + ALLTRIM(STR(lnIdVendedor)) + ", " + oDT.getDateTime() + ", "
		lcSql = lcsql + "0, " + ALLTRIM(STR(lnTotFact, 10, 2)) + ", " + ALLTRIM(STR(lnIdOper)) + ", " + ALLTRIM(STR(lnIdVentasC)) + ", "
		lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', " + oDT.getDateTime() + ", '" + ALLTRIM(SYS(0)) + "')"
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute()
			goConn.Rollback()
			RETURN .F.
		ENDIF
		
		lnSaldo = Thisform.saldo_fc - thisform.Contenido.txtTotFact.Value
		
		&& Actualizo el Saldo en la factura para validar que no se pueda
		&& aplicar un importe superior al saldo.
		lcSql = "UPDATE ventascab SET saldo = " + ALLTRIM(STR(lnSaldo, 10, 2)) + ", "
		lcSql = lcSql + "usuModi = '" + ALLTRIM(gcCodUsu) + "', "
		lcSql = lcSql + "fecModi = " + oDT.getDateTime() + ", "
		lcSql = lcSql + "idHostModi = '" + ALLTRIM(SYS(0)) + "' " 				
		lcSql = lcSql + "WHERE idVentasC = " + ALLTRIM(STR(Thisform.idorigen))
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute()
			goConn.Rollback()
			RETURN .F.
		ENDIF	
	ENDIF
ENDIF

&& Ahora tengo que generar la relación entre el comprobante de origen con el comprobante
&& de destino
IF (ALLTRIM(Thisform.cbte) == "NC") .OR. (ALLTRIM(Thisform.Cbte) == "FC") THEN
	IF Thisform.idorigen <> 0 THEN
		lnProxID = goConn.GetNextId("ventasrel", "idVtaRel")
		
		lcSql = "INSERT INTO ventasrel (idVtaRel, idVtaCO, idVtaCD) VALUES ("
		lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", " + ALLTRIM(STR(Thisform.idorigen)) + ", " + ALLTRIM(STR(lnIdVentasC)) + ")"
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			RETURN .F.
		ENDIF
	ENDIF
ENDIF

IF ALLTRIM(Thisform.Cbte) == "PED" THEN
	IF getglobalcfg("TRANS_PED") THEN
		loSoapCli = CREATEOBJECT("MSSOAP.SoapClient30")
		loSoapCli.MSSoapInit(gcUrlWS)
		loSoapCli.marcarProcesado(Thisform.idPedarch)
	ENDIF
ENDIF

************************************************************************************************
* Agrego que se genere el movimiento de stock al grabar la operación
* siempre y cuando el sistema se encuentre configurado para soportar esta funcionalidad
************************************************************************************************
IF getGlobalCFG("STK_MODULE") .AND. (ALLTRIM(THisform.Cbte) <> "COT" .OR. ALLTRIM(THisform.Cbte) <> "NC") THEN
	Thisform.mov_stock.idcliente = thisform.contenido.sel_Cliente.valcpoid
	Thisform.mov_stock.idprov = 0
	Thisform.mov_stock.tipodoc = Thisform.tipodoc
	Thisform.mov_stock.cbte = lcCbte
	Thisform.mov_stock.numcbte =  REPLICATE("0", 4 - LEN(ALLTRIM(STR(lnPtoVta)))) + ALLTRIM(STR(lnPtoVta)) + "-" + REPLICATE("0", 8 - LEN(ALLTRIM(STR(lnNroCbte)))) + ALLTRIM(STR(lnNroCbte))

	IF !(ALLTRIM(Thisform.cbte) == "COT") THEN
		IF !(ALLTRIM(Thisform.cbte) == "PED") THEN
			IF !Thisform.mov_stock.grabar2() THEN
				MESSAGEBOX(Thisform.mov_stock.ErrorMessage, 0+48, Thisform.Caption)
				goConn.Rollback()
				RETURN .F.
			ENDIF
		ENDIF	
	ENDIF
ENDIF
	
goConn.Commit()

MESSAGEBOX("El comprobante: " + ALLTRIM(lcCbte) + " " + REPLICATE("0", 4 - LEN(ALLTRIM(STR(lnPtoVta)))) + ALLTRIM(STR(lnPtoVta)) + "-" + ;
	REPLICATE("0", 8 - LEN(ALLTRIM(STR(lnNroCbte)))) + ALLTRIM(STR(lnNroCbte)) + " se ha generado exitosamente...", 0+64, Thisform.Caption)

RETURN .T.
ENDPROC


************************************************************
OBJETO: Fiscal
************************************************************
*** PROPIEDADES ***
Top = 521
Left = 792
Height = 100
Width = 100
Name = "Fiscal"

*** METODOS ***


************************************************************
OBJETO: mov_stock
************************************************************
*** PROPIEDADES ***
Top = 504
Left = 756
Height = 17
Width = 38
Name = "mov_stock"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Cliente:"
Height = 15
Left = 9
Top = 20
Width = 69
TabIndex = 26
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: sel_Cliente
************************************************************
*** PROPIEDADES ***
Top = 13
Left = 111
Width = 739
Height = 25
TabIndex = 1
cfieldname = 
esnumerico = .T.
nombre_tabla = clientes
pkfield = idCliente
nombre_campo_codigo = idCliente
nombre_campo_desc = razSoc
msgerror = Debe ingresar el cliente
autocompletar_ceros = .F.
permitir_agregar_regs = .T.
nombre_alta_form = frmaltaartic
Name = "sel_Cliente"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Height = 21
txtDescripcion.Left = 106
txtDescripcion.Top = 2
txtDescripcion.Width = 629
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***
PROCEDURE recuperar_datos
LOCAL lo_rsSitIVA, lo_rsCondPago, lo_rsLocalidad, lo_rsPcia, lo_rsIIBB, lcSql

lo_rsSitIVA = CREATEOBJECT("odbc_result")
lo_rsCondPago = CREATEOBJECT("odbc_result")
lo_rsLocalidad = CREATEOBJECT("odbc_result")
lo_rsPcia = CREATEOBJECT("odbc_result")
lo_rsIIBB = CREATEOBJECT("odbc_result")
lcSql = ""

SELECT clientes
Thisform.contenido.txtDesc1.Value = clientes.desc1
Thisform.contenido.txtDesc2.Value = clientes.desc2
Thisform.contenido.txtDesc3.Value = clientes.desc3
Thisform.contenido.txtDesc4.Value = clientes.desc4
Thisform.cli_calle = clientes.direccion
Thisform.cli_cuit = clientes.nroCUIT
Thisform.cli_telefono = clientes.telefono
Thisform.cli_Id = clientes.idCliente

lcSql = "SELECT * FROM localidad WHERE idLocalid = " + ALLTRIM(STR(clientes.idLocalid))
lo_rsLocalidad.ActiveConnection = goConn.ActiveConnection
lo_rsLocalidad.Cursor_Name = "cur_Localid"
lo_rsLocalidad.OpenQuery(lcSql)

SELECT cur_Localid
Thisform.cli_localidad = cur_Localid.descripcio
Thisform.cli_codpostal = cur_Localid.codPostal

lcSql = "SELECT * FROM provincias WHERE idProvin = " + ALLTRIM(STR(cur_Localid.idProvin))
lo_rsPcia.ActiveConnection = goConn.ActiveConnection
lo_rsPcia.Cursor_Name = "cur_Pcia"
lo_rsPcia.OpenQuery(lcSql)

SELECT cur_Pcia
Thisform.cli_pcia = cur_Pcia.descripcio

lo_rsPcia.close_query()
lo_rsLocalidad.close_query()

lcSql = "SELECT * FROM SitIva WHERE idSitIVA = " + ALLTRIM(STR(clientes.idSitIVA))
lo_rsSitIVA.ActiveConnection = goConn.ActiveConnection
lo_rsSitIVA.Cursor_Name = "cur_SitIVA"
lo_rsSitIVA.OpenQuery(lcSql)

SELECT cur_SitIVA
Thisform.contenido.txtSitIVA.Value = cur_SitIVA.descripcio
Thisform.sitivacli = cur_SitIVA.idSitIVA
Thisform.CodIVAFiscal = cur_SitIVA.CodFiscal

lo_rsSitIVA.close_query()

lcSql = "SELECT * FROM condpagos WHERE idCondPago = " + ALLTRIM(STR(clientes.idCondPago))
lo_rsCondPago.ActiveConnection = goConn.ActiveConnection
lo_rsCondPago.Cursor_Name = "cur_CondPago"
lo_rsCondPago.OpenQuery(lcSql)

SELECT cur_CondPago
Thisform.contenido.sel_FormaPago.valcpoid = cur_CondPago.idCondPago
Thisform.contenido.sel_FormaPago.txtCodigo.Value = cur_CondPago.idCondPago
Thisform.contenido.sel_FormaPago.txtDescripcion.Value = cur_CondPago.Descripcio
thisform.cp_cntdias = cur_CondPago.cntDias

lo_rsCondPago.close_query()

lcSql = "SELECT * FROM padronib WHERE cuit = " + ALLTRIM(STRTRAN(clientes.nrocuit,"-",""))
lo_rsIIBB.ActiveConnection = goConn.ActiveConnection
lo_rsIIBB.Cursor_Name = "cur_PadronIB"
lo_rsIIBB.OpenQuery(lcSql)

SELECT cur_PadronIB
IF RECCOUNT("cur_PadronIB") > 0 THEN
	Thisform.contenido.txtPorIIBB.Value = cur_PadronIB.AlicuotaPer
ELSE 
	Thisform.contenido.txtPorIIBB.Value = 0.00
ENDIF 

lo_rsIIBB.close_query()

IF ALLTRIM(thisform.cbte) != "NC" THEN 
	thisform.recalcular_todo()
ENDIF 

ENDPROC


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Situación I.V.A:"
Height = 15
Left = 9
Top = 42
Width = 96
TabIndex = 27
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Forma de Pago:"
Height = 15
Left = 10
Top = 65
Width = 96
TabIndex = 28
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: txtSitIVA
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 113
ReadOnly = .T.
TabIndex = 19
Top = 38
Width = 212
Name = "txtSitIVA"

*** METODOS ***


************************************************************
OBJETO: sel_FormaPago
************************************************************
*** PROPIEDADES ***
Top = 59
Left = 111
TabIndex = 3
nombre_campo_codigo = idCondPago
nombre_campo_desc = descripcio
nombre_tabla = condpagos
pkfield = idCondPago
esnumerico = .T.
autocompletar_ceros = .F.
Name = "sel_FormaPago"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***
PROCEDURE recuperar_datos
SELECT condpagos
thisform.cp_cntdias = condpagos.cntDias
ENDPROC


************************************************************
OBJETO: Clslinea1
************************************************************
*** PROPIEDADES ***
Height = 0
Left = 8
Top = 92
Width = 985
Name = "Clslinea1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta6
************************************************************
*** PROPIEDADES ***
Caption = "Neto:"
Height = 15
Left = 9
Top = 445
Width = 36
TabIndex = 29
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta7
************************************************************
*** PROPIEDADES ***
Caption = "I.V.A 21:"
Height = 15
Left = 316
Top = 446
Width = 57
TabIndex = 32
Name = "Clsetiqueta7"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta8
************************************************************
*** PROPIEDADES ***
Caption = "I.V.A 10,5:"
Height = 15
Left = 316
Top = 469
Width = 72
TabIndex = 35
Name = "Clsetiqueta8"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta9
************************************************************
*** PROPIEDADES ***
Caption = "Final:"
Height = 15
Left = 9
Top = 469
Visible = .F.
Width = 38
TabIndex = 36
Name = "Clsetiqueta9"

*** METODOS ***


************************************************************
OBJETO: txtTotNeto
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 45
ReadOnly = .T.
TabIndex = 38
Top = 441
Width = 83
isnumeric = .T.
Name = "txtTotNeto"

*** METODOS ***


************************************************************
OBJETO: txtPorIVA21
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 387
ReadOnly = .T.
TabIndex = 40
Top = 442
Width = 44
isnumeric = .T.
Name = "txtPorIVA21"

*** METODOS ***


************************************************************
OBJETO: txtPorIVA105
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 387
ReadOnly = .T.
TabIndex = 42
Top = 465
Width = 44
isnumeric = .T.
Name = "txtPorIVA105"

*** METODOS ***


************************************************************
OBJETO: txtImpIVA21
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 432
ReadOnly = .T.
TabIndex = 43
Top = 442
Width = 75
isnumeric = .T.
Name = "txtImpIVA21"

*** METODOS ***


************************************************************
OBJETO: txtImpIVA105
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 432
ReadOnly = .T.
TabIndex = 45
Top = 465
Width = 75
isnumeric = .T.
Name = "txtImpIVA105"

*** METODOS ***


************************************************************
OBJETO: txtTotal
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 45
ReadOnly = .T.
TabIndex = 46
Top = 464
Visible = .F.
Width = 83
isnumeric = .T.
Name = "txtTotal"

*** METODOS ***


************************************************************
OBJETO: btnGrabar
************************************************************
*** PROPIEDADES ***
Top = 515
Left = 929
Height = 44
Width = 45
TabIndex = 12
Name = "btnGrabar"

*** METODOS ***
PROCEDURE Click
IF !Thisform.ValidarCampos()
	RETURN .F.
ENDIF

IF !thisform.grabar()
	MESSAGEBOX("Error al intentar grabar el comprobante", 0+16, Thisform.Caption)
	RETURN .F.
ENDIF

IF !thisform.usar_fiscal
	Thisform.imprimir()
ENDIF

IF (ALLTRIM(Thisform.cbte) == "NC") .OR. (ALLTRIM(Thisform.cbte) == "FC") THEN
	Thisform.Contenido.btnCbteOrigen.Enabled = .T.
ENDIF

Thisform.Blanquear()
Thisform.mov_stock.limpiar()

RETURN .T.
ENDPROC


************************************************************
OBJETO: btnCancelar
************************************************************
*** PROPIEDADES ***
Top = 514
Left = 5
Height = 44
Width = 45
TabIndex = 13
Name = "btnCancelar"

*** METODOS ***
PROCEDURE Click
Thisform.Blanquear()
Thisform.Contenido.Sel_Cliente.txtCodigo.SetFocus()
ENDPROC


************************************************************
OBJETO: Clscerrar1
************************************************************
*** PROPIEDADES ***
Top = 515
Left = 976
Height = 44
Width = 45
TabIndex = 14
Name = "Clscerrar1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta14
************************************************************
*** PROPIEDADES ***
Caption = "Descuentos"
Height = 15
Left = 612
Top = 65
Width = 77
TabIndex = 50
Name = "Clsetiqueta14"

*** METODOS ***


************************************************************
OBJETO: txtDesc1
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 702
ReadOnly = .F.
TabIndex = 8
Top = 61
Width = 49
isnumeric = .T.
Name = "txtDesc1"

*** METODOS ***
PROCEDURE LostFocus
DODEFAULT()
Thisform.recalcular_todo()
ENDPROC


************************************************************
OBJETO: txtDesc2
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 752
ReadOnly = .F.
TabIndex = 9
Top = 61
Width = 49
isnumeric = .T.
Name = "txtDesc2"

*** METODOS ***
PROCEDURE LostFocus
DODEFAULT()
Thisform.recalcular_todo()
ENDPROC


************************************************************
OBJETO: txtDesc3
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 802
ReadOnly = .F.
TabIndex = 10
Top = 61
Width = 49
isnumeric = .T.
Name = "txtDesc3"

*** METODOS ***
PROCEDURE LostFocus
DODEFAULT()
Thisform.recalcular_todo()
ENDPROC


************************************************************
OBJETO: txtDesc4
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 852
ReadOnly = .F.
TabIndex = 11
Top = 61
Width = 49
isnumeric = .T.
Name = "txtDesc4"

*** METODOS ***
PROCEDURE LostFocus
DODEFAULT()
Thisform.recalcular_todo()
ENDPROC


************************************************************
OBJETO: txtImpDesc1
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 702
ReadOnly = .T.
TabIndex = 21
Top = 38
Visible = .F.
Width = 49
isnumeric = .T.
Name = "txtImpDesc1"

*** METODOS ***


************************************************************
OBJETO: txtImpDesc2
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 752
ReadOnly = .T.
TabIndex = 22
Top = 38
Visible = .F.
Width = 49
isnumeric = .T.
Name = "txtImpDesc2"

*** METODOS ***


************************************************************
OBJETO: txtImpDesc3
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 802
ReadOnly = .T.
TabIndex = 23
Top = 38
Visible = .F.
Width = 49
isnumeric = .T.
Name = "txtImpDesc3"

*** METODOS ***


************************************************************
OBJETO: txtImpDesc4
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 852
ReadOnly = .T.
TabIndex = 25
Top = 38
Visible = .F.
Width = 49
isnumeric = .T.
Name = "txtImpDesc4"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta15
************************************************************
*** PROPIEDADES ***
Caption = "%:"
Height = 15
Left = 683
Top = 65
Width = 15
TabIndex = 48
Name = "Clsetiqueta15"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta16
************************************************************
*** PROPIEDADES ***
Caption = "$:"
Height = 15
Left = 685
Top = 42
Visible = .F.
Width = 15
TabIndex = 53
Name = "Clsetiqueta16"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta17
************************************************************
*** PROPIEDADES ***
Caption = "Total:"
Height = 15
Left = 896
Top = 445
Width = 40
TabIndex = 37
Name = "Clsetiqueta17"

*** METODOS ***


************************************************************
OBJETO: txtTotFact
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 939
ReadOnly = .T.
TabIndex = 47
Top = 441
Width = 83
isnumeric = .T.
Name = "txtTotFact"

*** METODOS ***


************************************************************
OBJETO: chkImprimeDup
************************************************************
*** PROPIEDADES ***
Top = 40
Left = 372
Height = 18
Width = 216
Alignment = 0
Caption = "Emitir comprobante por duplicado"
TabIndex = 56
Visible = .F.
Name = "chkImprimeDup"

*** METODOS ***


************************************************************
OBJETO: btnCbteOrigen
************************************************************
*** PROPIEDADES ***
Top = 13
Left = 846
Height = 24
Width = 98
Caption = "\<Cbte. Origen"
TabIndex = 2
Name = "btnCbteOrigen"

*** METODOS ***
PROCEDURE Click
LOCAL loForm

loForm = CREATEOBJECT("cls_busca_fcorigen")
loForm.cbte = Thisform.cbte

IF Thisform.Contenido.sel_Cliente.txtCodigo.Value = 0 THEN
	MESSAGEBOX("Debe ingresar el código de cliente", 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

loForm.idCliente = Thisform.Contenido.sel_Cliente.valcpoid
loForm.llenar_grilla()
loForm.show()

IF loForm.press_aceptar
	Thisform.idOrigen = loForm.valor_id
	Thisform.saldo_fc = loForm.saldo
	
	IF ALLTRIM(Thisform.Cbte) == "FC" THEN
		Thisform.recuperar_ped()
	ELSE
		IF ALLTRIM(thisform.cbte) == "NC" THEN 
			Thisform.recuperar_fc()
		ENDIF 
	ENDIF
ENDIF

loForm.release()
This.Enabled = .F.

Thisform.contenido.sel_Articulo.SetFocus()

RETURN .T.

ENDPROC


************************************************************
OBJETO: txtObserv
************************************************************
*** PROPIEDADES ***
Height = 35
Left = 6
TabIndex = 20
Top = 398
Width = 1016
Name = "txtObserv"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta18
************************************************************
*** PROPIEDADES ***
Caption = "Perc. IIBB.:"
Height = 15
Left = 316
Top = 491
Width = 63
TabIndex = 33
Name = "Clsetiqueta18"

*** METODOS ***


************************************************************
OBJETO: txtPorIIBB
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 387
ReadOnly = .T.
TabIndex = 41
Top = 488
Width = 44
isnumeric = .T.
Name = "txtPorIIBB"

*** METODOS ***


************************************************************
OBJETO: txtImpIIBB
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 432
ReadOnly = .T.
TabIndex = 44
Top = 488
Width = 75
isnumeric = .T.
Name = "txtImpIIBB"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta19
************************************************************
*** PROPIEDADES ***
Caption = "Subtotal:"
Height = 15
Left = 148
Top = 446
Width = 59
TabIndex = 51
Name = "Clsetiqueta19"

*** METODOS ***


************************************************************
OBJETO: txtST
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 207
ReadOnly = .T.
TabIndex = 39
Top = 441
Width = 83
isnumeric = .T.
Name = "txtST"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Artículo:"
Left = 11
Top = 100
TabIndex = 30
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: sel_Articulo
************************************************************
*** PROPIEDADES ***
Top = 94
Left = 114
TabIndex = 4
autocompletar_ceros = .F.
esnumerico = .F.
nombre_campo_codigo = codArt
nombre_campo_desc = descripcio
nombre_tabla = articulos
permitir_agregar_regs = .F.
pkfield = idArticulo
requerido = .F.
Name = "sel_Articulo"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***
PROCEDURE recuperar_datos
LOCAL lnPorDesc1, lnPorDesc2, lnPorDesc3, lnPorDesc4
LOCAL lnImpDesc1, lnImpDesc2, lnImpDesc3, lnImpDesc4
LOCAL lnPrVtaMax, lnPrVtaMin

lnPorDesc1 = Thisform.contenido.txtDesc1.Value * -1
lnPorDesc2 = Thisform.contenido.txtDesc2.Value * -1
lnPorDesc3 = Thisform.contenido.txtDesc3.Value * -1
lnPorDesc4 = Thisform.contenido.txtDesc4.Value * -1
lnImpDesc1 = 0.00
lnImpDesc2 = 0.00
lnImpDesc3 = 0.00
lnImpDesc4 = 0.00
lnPrVtaMax = 0.00
lnPrVtaMin = 0.00

SELECT articulos
lnPrVtaMax = articulos.prVentaMax
lnPrVtaMin = articulos.prVentaMin

&& Calculo el precio mayorista con descuento
lnImpDesc1 = lnPrVtaMax + (lnPrVtaMax * (lnPorDesc1 / 100))
lnImpDesc2 = lnImpDesc1 + (lnImpDesc1 * (lnPorDesc2 / 100))
lnImpDesc3 = lnImpDesc2 + (lnImpDesc2 * (lnPorDesc3 / 100))
lnImpDesc4 = lnImpDesc3 + (lnImpDesc3 * (lnPorDesc4 / 100))
Thisform.contenido.txtPrMay.Value = ROUND(lnImpDesc4, 2)

&& Calculo el precio minorista con descuento
lnImpDesc1 = lnPrVtaMin + (lnPrVtaMin * (lnPorDesc1 / 100))
lnImpDesc2 = lnImpDesc1 + (lnImpDesc1 * (lnPorDesc2 / 100))
lnImpDesc3 = lnImpDesc2 + (lnImpDesc2 * (lnPorDesc3 / 100))
lnImpDesc4 = lnImpDesc3 + (lnImpDesc3 * (lnPorDesc4 / 100))
Thisform.contenido.txtPrMinorista.Value = ROUND(lnImpDesc4, 2)
thisform.contenido.txtAlicIVA.Value = articulos.alicIVA

Thisform.Contenido.txtExistencia.Value = Thisform.mov_stock.get_exist_byart(Thisform.contenido.sel_Articulo.valcpoid)
Thisform.calc_item_desc()


ENDPROC


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Cantidad:"
Height = 15
Left = 599
Top = 100
Width = 60
TabIndex = 34
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: txtCantidad
************************************************************
*** PROPIEDADES ***
Left = 660
TabIndex = 5
Top = 96
isnumeric = .T.
Name = "txtCantidad"

*** METODOS ***
PROCEDURE LostFocus
DODEFAULT()
Thisform.calc_item_desc()
ENDPROC


************************************************************
OBJETO: btnAgregar
************************************************************
*** PROPIEDADES ***
Top = 163
Left = 930
Height = 44
Width = 45
TabIndex = 6
Name = "btnAgregar"

*** METODOS ***
PROCEDURE Click
LOCAL lnPDtoCli1, lnPDtoCli2, lnPDtoCli3, lnPDtoCli4
LOCAL lnIDtoCli1, lnIDtoCli2, lnIDtoCli3, lnIDtoCli4
LOCAL loResult, lcSql, lnPrecio

lnPDtoCli1 = Thisform.contenido.txtDesc1.Value * -1
lnPDtoCli2 = Thisform.contenido.txtDesc2.Value * -1
lnPDtoCli3 = Thisform.contenido.txtDesc3.Value * -1
lnPDtoCli4 = Thisform.contenido.txtDesc4.Value * -1
lnIDtoCli1 = 0.00
lnIDtoCli2 = 0.00
lnIDtoCli3 = 0.00
lnIDtoCli4 = 0.00
lnPrecio = 0.00
loResult = CREATEOBJECT("odbc_result")
lcSql = ""

IF !Thisform.ValidarDetalle()
	RETURN .F.
ENDIF

lcSql = "SELECT * FROM articulos WHERE idArticulo = " + ALLTRIM(STR(Thisform.contenido.sel_Articulo.valcpoid))
loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_Art"
loResult.OpenQuery(lcSql)

IF clientes.mayorista
	lnPrecio = cur_Art.prVentaMax
ELSE
	lnPrecio = cur_Art.prVentaMin
ENDIF

loResult.Close_Query()

IF glVersionBeta THEN
	SELECT cur_Detalle
	IF RECCOUNT() = 5 THEN
		MESSAGEBOX("Usted está utilizando una versión límitada del sistema, si desea comprarlo envíe un mail a ldz.software@gmail.com", 0+64, Thisform.Caption)
		RETURN .F.
	ENDIF
ENDIF

* Valido si el artículo ya se encuentra cargado en el presupuesto
SELECT cur_Detalle
IF RECCOUNT() > 0
	GO TOP
ENDIF

SELECT cur_Detalle
DO WHILE !EOF()
	IF cur_Detalle.codArt == Thisform.contenido.sel_Articulo.txtCodigo.Value
		MESSAGEBOX("El artículo ya se encuentra cargado", 0+48, Thisform.Caption)
		RETURN .F.
	ENDIF

	SELECT cur_Detalle
	SKIP
ENDDO

SELECT cur_Detalle
APPEND BLANK
REPLACE cur_Detalle.idDetalle WITH RECCOUNT("cur_Detalle") + 1
REPLACE cur_Detalle.idArticulo WITH Thisform.contenido.sel_Articulo.valcpoid ADDITIVE
REPLACE cur_Detalle.codArt WITH Thisform.contenido.sel_Articulo.txtCodigo.Value	ADDITIVE
REPLACE cur_Detalle.descripcio WITH Thisform.contenido.sel_Articulo.txtDescripcion.Value ADDITIVE
REPLACE cur_Detalle.cantidad WITH Thisform.contenido.txtCantidad.Value ADDITIVE

*******************************************************************************************************************************
* Verifico el tipo de cliente que es para saber desde donde tomar el precio
*******************************************************************************************************************************
IF clientes.mayorista THEN 
	REPLACE cur_Detalle.prVta WITH Thisform.contenido.txtPrMay.Value ADDITIVE
ELSE
	REPLACE cur_Detalle.prVta WITH Thisform.contenido.txtPrMinorista.Value ADDITIVE
ENDIF

REPLACE cur_Detalle.pDtoVta1 WITH Thisform.contenido.txtPorDesc1.Value
REPLACE cur_Detalle.pDtoVta2 WITH Thisform.contenido.txtPorDesc2.Value
REPLACE cur_Detalle.pDtoVta3 WITH Thisform.contenido.txtPorDesc3.Value
REPLACE cur_Detalle.pDtoVta4 WITH Thisform.contenido.txtPorDesc4.Value
REPLACE cur_Detalle.iDtoVta1 WITH Thisform.contenido.txtImpDescItem1.Value
REPLACE cur_Detalle.iDtoVta2 WITH Thisform.contenido.txtImpDescItem2.Value 
REPLACE cur_Detalle.iDtoVta3 WITH Thisform.contenido.txtImpDescItem3.Value
REPLACE cur_Detalle.iDtoVta4 WITH Thisform.contenido.txtImpDescItem4.Value
replace cur_Detalle.impNeto WITH Thisform.contenido.txtPrNeto.Value
*******************************************************************************************************************************
* Hago el cálculo del IVA
*******************************************************************************************************************************
IF (ALLTRIM(Thisform.cbte) == "PTO") THEN
	REPLACE cur_Detalle.impIVA WITH 0 ADDITIVE
	REPLACE cur_Detalle.alicIVA WITH 0 ADDITIVE
ELSE
	REPLACE cur_Detalle.impIVA WITH Thisform.contenido.txtSTNeto.Value * (Thisform.contenido.txtAlicIVA.Value / 100) ADDITIVE
	REPLACE cur_Detalle.alicIVA WITH Thisform.contenido.txtAlicIVA.Value ADDITIVE
ENDIF

REPLACE cur_Detalle.totNeto WITH Thisform.contenido.txtSTNeto.Value ADDITIVE
REPLACE cur_Detalle.subTotal WITH Thisform.contenido.txtSubTotal.Value ADDITIVE

*******************************************************************************************************************************
* Calculo el descuento del cliente en el ítem para grabar
*******************************************************************************************************************************
lnIDtoCli1 = lnPrecio * (lnPDtoCli1 / 100)
lnIDtoCli2 = (lnPrecio + lnIDtoCli1) * (lnPDtoCli2 / 100)
lnIDtoCli3 = (lnPrecio + lnIDtoCli1 + lnIDtoCli2) * (lnPDtoCli3 / 100)
lnIDtoCli4 = (lnPrecio + lnIDtoCli1 + lnIDtoCli2 + lnIDtoCli3) * (lnPDtoCli4 / 100)


REPLACE cur_Detalle.pDtoCli1 WITH lnPDtoCli1 * -1 ADDITIVE
REPLACE cur_Detalle.pDtoCli2 WITH lnPDtoCli2 * -1 ADDITIVE
REPLACE cur_Detalle.pDtoCli3 WITH lnPDtoCli3 * -1 ADDITIVE
REPLACE cur_Detalle.pDtoCli4 WITH lnPDtoCli4 * -1 ADDITIVE
REPLACE cur_Detalle.iDtoCli1 WITH lnIDtoCli1 * -1 ADDITIVE
REPLACE cur_Detalle.iDtoCli2 WITH lnIDtoCli2 * -1 ADDITIVE
REPLACE cur_Detalle.iDtoCli3 WITH lnIDtoCli3 * -1 ADDITIVE
REPLACE cur_Detalle.iDtoCli4 WITH lnIDtoCli4 * -1 ADDITIVE
REPLACe cur_Detalle.stkDisp	 WITH Thisform.mov_stock.get_exist_byart(Thisform.contenido.sel_Articulo.valcpoid) ADDITIVE

*******************************************************************************************************************************
* Agrego el registro en el cursor cur_stkdet para que el sistema genere los movimientos de stock correspondientes.
* Agregado el 14/08/2013
*******************************************************************************************************************************
Thisform.mov_stock.agregar_articulo(cur_Detalle.idArticulo, cur_Detalle.cantidad)
*******************************************************************************************************************************

Thisform.contenido.sel_Articulo.blanquear()
Thisform.contenido.txtprMay.Value = 0.00
Thisform.contenido.txtPrMinorista.Value = 0.00
Thisform.contenido.txtCantidad.Value = 0.00
Thisform.contenido.txtPrNeto.Value = 0.00
Thisform.contenido.txtSubTotal.Value = 0.00
Thisform.contenido.txtAlicIVA.Value = 0.00
Thisform.contenido.txtImpIVA.Value = 0.00
Thisform.contenido.txtSTNeto.Value = 0.00
Thisform.contenido.txtPorDesc1.Value = 0.00
Thisform.contenido.txtPorDesc2.Value = 0.00
Thisform.contenido.txtPorDesc3.Value = 0.00
Thisform.contenido.txtPorDesc4.Value = 0.00
Thisform.contenido.txtImpDescItem1.Value = 0.00
Thisform.contenido.txtImpDescItem2.Value = 0.00
Thisform.contenido.txtImpDescItem3.Value = 0.00
Thisform.contenido.txtImpDescItem4.Value = 0.00
Thisform.contenido.sel_Articulo.txtCodigo.SetFocus()

Thisform.sumar_items()
Thisform.calcular_ret_iibb()

SELECT cur_Detalle
GO BOTTOM
Thisform.contenido.grdDetalles.Refresh()

RETURN .T.

ENDPROC


************************************************************
OBJETO: Clsetiqueta10
************************************************************
*** PROPIEDADES ***
Caption = "Precio Mayorista:"
Height = 15
Left = 11
Top = 123
Width = 101
TabIndex = 52
Name = "Clsetiqueta10"

*** METODOS ***


************************************************************
OBJETO: txtPrMay
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 116
TabIndex = 54
Top = 119
Width = 100
isnumeric = .T.
Name = "txtPrMay"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta11
************************************************************
*** PROPIEDADES ***
Caption = "Precio Minorista:"
Height = 15
Left = 225
Top = 123
Width = 101
TabIndex = 55
Name = "Clsetiqueta11"

*** METODOS ***


************************************************************
OBJETO: txtPrMinorista
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 330
TabIndex = 58
Top = 119
Width = 104
isnumeric = .T.
Name = "txtPrMinorista"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta12
************************************************************
*** PROPIEDADES ***
Caption = "Alícuota I.V.A.:"
Height = 15
Left = 207
Top = 169
Width = 96
TabIndex = 61
Name = "Clsetiqueta12"

*** METODOS ***


************************************************************
OBJETO: txtAlicIVA
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 289
TabIndex = 62
Top = 165
Width = 66
isnumeric = .T.
Name = "txtAlicIVA"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta13
************************************************************
*** PROPIEDADES ***
FontSize = 9
Caption = "Tot. C/I.V.A.:"
Height = 15
Left = 507
Top = 169
Width = 100
TabIndex = 63
ForeColor = 255,0,0
Name = "Clsetiqueta13"

*** METODOS ***


************************************************************
OBJETO: txtSubTotal
************************************************************
*** PROPIEDADES ***
FontSize = 9
Enabled = .F.
Left = 581
TabIndex = 64
Top = 165
ForeColor = 255,0,0
DisabledForeColor = 255,0,0
isnumeric = .T.
Name = "txtSubTotal"

*** METODOS ***


************************************************************
OBJETO: chkCalcIVA
************************************************************
*** PROPIEDADES ***
Top = 97
Left = 771
Height = 18
Width = 137
Alignment = 0
Caption = "Prioridad de Salida"
Value = 1
TabIndex = 24
Name = "chkCalcIVA"

*** METODOS ***
PROCEDURE Click
&&Thisform.calc_stitem()
ENDPROC


************************************************************
OBJETO: btnEliminar
************************************************************
*** PROPIEDADES ***
Top = 163
Left = 977
Height = 44
Width = 45
TabIndex = 7
Name = "btnEliminar"

*** METODOS ***
PROCEDURE Click
LOCAL lnResp

lnResp = MESSAGEBOX("Está seguro que desea eliminar este ítem?", 0+4, Thisform.Caption)

IF lnResp = 6
	*****************************************************************************
	* Elimino el item del detalle de movimiento de stock siempre y cuando
	* el sistema tenga configurado la funcionalidad de stock
	*****************************************************************************
	IF getGlobalCFG("STK_MODULE") THEN
		SELECT cur_Detalle
		Thisform.mov_stock.eliminar(cur_Detalle.idArticulo)
	ENDIF

	*****************************************************************************
	* Elimino el artículo del detalle del a factura
	*****************************************************************************
	SELECT cur_Detalle
	DELETE
	Thisform.Contenido.grdDetalles.Refresh()
	Thisform.sumar_items()
	Thisform.calcular_ret_iibb()
ENDIF

ENDPROC


************************************************************
OBJETO: Clsetiqueta20
************************************************************
*** PROPIEDADES ***
Caption = "Descuento Item:"
Height = 15
Left = 11
Top = 145
Width = 101
TabIndex = 49
Name = "Clsetiqueta20"

*** METODOS ***


************************************************************
OBJETO: txtPorDesc1
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 116
TabIndex = 15
Top = 142
Width = 66
isnumeric = .T.
Name = "txtPorDesc1"

*** METODOS ***
PROCEDURE InteractiveChange
thisform.calc_item_desc()
ENDPROC


************************************************************
OBJETO: txtImpDescItem1
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 184
ReadOnly = .T.
TabIndex = 65
Top = 142
Width = 66
isnumeric = .T.
Name = "txtImpDescItem1"

*** METODOS ***


************************************************************
OBJETO: txtPorDesc2
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 252
TabIndex = 16
Top = 142
Width = 66
isnumeric = .T.
Name = "txtPorDesc2"

*** METODOS ***
PROCEDURE InteractiveChange
thisform.calc_item_desc()
ENDPROC


************************************************************
OBJETO: txtImpDescItem2
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 320
ReadOnly = .T.
TabIndex = 66
Top = 142
Width = 66
isnumeric = .T.
Name = "txtImpDescItem2"

*** METODOS ***


************************************************************
OBJETO: txtPorDesc3
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 388
TabIndex = 17
Top = 142
Width = 66
isnumeric = .T.
Name = "txtPorDesc3"

*** METODOS ***
PROCEDURE InteractiveChange
thisform.calc_item_desc()
ENDPROC


************************************************************
OBJETO: txtImpDescItem3
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 456
ReadOnly = .T.
TabIndex = 67
Top = 142
Width = 66
isnumeric = .T.
Name = "txtImpDescItem3"

*** METODOS ***


************************************************************
OBJETO: txtPorDesc4
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 524
TabIndex = 18
Top = 142
Width = 66
isnumeric = .T.
Name = "txtPorDesc4"

*** METODOS ***
PROCEDURE InteractiveChange
thisform.calc_item_desc()
ENDPROC


************************************************************
OBJETO: txtImpDescItem4
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 592
ReadOnly = .T.
TabIndex = 68
Top = 142
Width = 66
isnumeric = .T.
Name = "txtImpDescItem4"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta21
************************************************************
*** PROPIEDADES ***
Caption = "Imp. I.V.A.:"
Height = 15
Left = 365
Top = 169
Width = 67
TabIndex = 60
Name = "Clsetiqueta21"

*** METODOS ***


************************************************************
OBJETO: txtImpIVA
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 432
ReadOnly = .T.
TabIndex = 69
Top = 165
Width = 66
isnumeric = .T.
Name = "txtImpIVA"

*** METODOS ***
PROCEDURE InteractiveChange
thisform.capc_item_desc()
ENDPROC


************************************************************
OBJETO: Clsetiqueta22
************************************************************
*** PROPIEDADES ***
Caption = "Subtot. c/ Desc.:"
Height = 15
Left = 11
Top = 169
Width = 101
TabIndex = 57
Name = "Clsetiqueta22"

*** METODOS ***


************************************************************
OBJETO: txtSTNeto
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 116
TabIndex = 59
Top = 165
Width = 85
isnumeric = .T.
Name = "txtSTNeto"

*** METODOS ***


************************************************************
OBJETO: grdDetalles
************************************************************
*** PROPIEDADES ***
Height = 190
Left = 6
TabIndex = 31
Top = 209
Width = 1016
permitir_busqueda = .F.
permitir_ordenamiento = .F.
alias_name = cur_Detalle
list_controlsource = codArt,descripcio,cantidad,prVta,pDtoVta1,pDtoVta2,pDtoVta3,pDtoVta4,totNeto,alicIVA,impIVA,subTotal,stkDisp
lista_ancho_cols = 150,200,70,70,50,50,50,50,50,50,50,50,70
titulos_cabeceras = Código,Descripción,Cantidad,Pr. Vta.,Desc.1,Desc.2,Desc.3,Desc.4,Neto,I.V.A.,Imp.IVA,Total,Existec.
Name = "grdDetalles"
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
OBJETO: Clsetiqueta23
************************************************************
*** PROPIEDADES ***
Caption = "Precio Neto:"
Height = 15
Left = 667
Top = 145
Width = 69
TabIndex = 51
Name = "Clsetiqueta23"

*** METODOS ***


************************************************************
OBJETO: txtPrNeto
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 742
TabIndex = 53
Top = 142
Width = 104
isnumeric = .T.
Name = "txtPrNeto"

*** METODOS ***


************************************************************
OBJETO: lblExistencia
************************************************************
*** PROPIEDADES ***
Caption = "Existencia:"
Height = 15
Left = 697
Top = 169
Width = 67
TabIndex = 55
Name = "lblExistencia"

*** METODOS ***


************************************************************
OBJETO: txtExistencia
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 765
ReadOnly = .T.
TabIndex = 69
Top = 166
Width = 81
isnumeric = .T.
Name = "txtExistencia"

*** METODOS ***
PROCEDURE InteractiveChange
thisform.capc_item_desc()
ENDPROC


************************************************************
OBJETO: clsformcbtes
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 9, 6, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_busca_fcorigen
************************************************************
*** PROPIEDADES ***
Height = 329
Width = 842
DoCreate = .T.
Caption = "Seleccionar Factura de Origen"
Closable = .F.
valor_id = 0
press_aceptar = .F.
idcliente = 0
saldo = 
cbte = 
Name = "cls_busca_fcorigen"

*** METODOS ***
PROCEDURE seleccionar
SELECT cur_Cbtes
Thisform.valor_id = cur_Cbtes.idVentasC
Thisform.saldo = cur_Cbtes.totFact
Thisform.press_aceptar = .T.
Thisform.Hide()
ENDPROC
PROCEDURE llenar_grilla
LOCAL loCbtes, lcSql, lnSqlSrv

lcSql = ""
loCbtes = CREATEOBJECT("odbc_result")
lnSqlSrv = VAL(getconfig("SQLSRV"))

lcSql = lcSql + "SELECT ventascab.idVentasC, "
lcSql = lcSql + "   	ventascab.fecEmision, "

IF lnSqlSrv = 0 THEN
	lcSql = lcSql + "CONCAT(ventascab.cbte, CONCAT(' ', CONCAT(ventascab.tipoDoc, "
	lcSql = lcSql + "	CONCAT(' ', CONCAT(CONCAT(CONCAT(REPEAT('0', 4 - LENGTH(TRIM(ventasCab.ptoVta))), "
	lcSql = lcSql + "   TRIM(ventascab.ptoVta)), '-'), CONCAT(REPEAT('0', 8 - LENGTH(TRIM(ventascab.numCbte))), "
	lcSql = lcSql + "   TRIM(ventascab.numCbte))))))) AS numCbte, "
ELSE
	lcSql = lcSql + "ventascab.cbte + ' ' + ventascab.tipoDoc + " 
	lcSql = lcSql + "	' ' + REPLICATE('0', 4 - LEN(RTRIM(LTRIM(ventasCab.ptoVta)))) + "
	lcSql = lcSql + "	LTRIM(RTRIM(ventascab.ptoVta)) + '-' + REPLICATE('0', 8 - LEN(LTRIM(RTRIM(ventascab.numCbte)))) + "
	lcSql = lcSql + "	RTRIM(LTRIM(ventascab.numCbte)) AS numCbte, "
ENDIF

lcSql = lcSql + "       ventascab.idCliente, "
lcSql = lcSql + "       clientes.razSoc, "
lcSql = lcSql + "       ventasCab.totFact "
lcSql = lcSql + "FROM   ventascab, "
lcSql = lcSql + "       clientes "
lcSql = lcSql + "WHERE  ventascab.idCliente = clientes.idCliente "
lcSql = lcSql + "	 AND ventascab.idCliente = " + ALLTRIM(STR(Thisform.idcliente)) + " "

&& Segun el comprobante que se está procesando, levanto los comprobantes de 
&& origen que corresponda
IF ALLTRIM(Thisform.cbte) == "NC" THEN
	&& Si es nota de crédito levanto las facturas con saldo pendiente de cancelar
	lcSql = lcSql + "    AND ventascab.cbte = 'FC' "
	lcSql = lcSql + "    AND idVentasC IN ( "
	lcSql = lcSql + "            SELECT  idVentasC "
	lcSql = lcSql + "            FROM    cc_cli "
	lcSql = lcSql + "            WHERE   IdOper IN ( "
	lcSql = lcSql + "                SELECT  cc_cli.idOper "
	lcSql = lcSql + "                FROM    cc_cli "
	lcSql = lcSql + "                GROUP BY cc_cli.idOper "
	lcSql = lcSql + "                HAVING (SUM(cc_cli.impDebe) - SUM(cc_cli.impHaber)) != 0)) "
	lcSql = lcSql + "ORDER BY idVentasC ASC"
ELSE
	IF ALLTRIM(Thisform.cbte) == "FC" THEN
		&& si es factura levanto los pedidos
		lcSql = lcSql + "	AND ventascab.cbte = 'PED' "
		lcSql = lcSql + "	AND idVentasC NOT IN ( "
		lcSql = lcSql + "		SELECT idVtaCO FROM ventasrel)"
		lcSql = lcSql + "ORDER BY idVentasC ASC"
	ENDIF
ENDIF


loCbtes.ActiveConnection = goConn.ActiveConnection
loCbtes.cursor_name = "tmp_cbtes"
loCbtes.OpenQuery(lcSql)

SELECT tmp_cbtes
IF RECCOUNT("tmp_cbtes") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("tmp_cbtes")
	SELECT cur_Cbtes
	APPEND BLANK
	REPLACE cur_cbtes.idVentasC WITH tmp_cbtes.idVentasC
	REPLACE cur_cbtes.fecEmision WITH tmp_cbtes.fecEmision ADDITIVE
	REPLACE cur_cbtes.numCbte WITH tmp_cbtes.numCbte ADDITIVE
	REPLACE cur_cbtes.idCliente WITH tmp_cbtes.idCliente ADDITIVE
	REPLACE cur_cbtes.razSoc WITH tmp_cbtes.razSoc ADDITIVE
	REPLACE cur_cbtes.totFact WITH tmp_cbtes.totFact ADDITIVE

	SELECT tmp_cbtes
	SKIP
ENDDO

loCbtes.Close_Query()

SELECT cur_Cbtes
IF RECCOUNT("cur_Cbtes") > 0 THEN
	GO TOP
ENDIF


SELECT cur_Cbtes
Thisform.grdCbtes.RecordSource = "cur_Cbtes"
Thisform.grdCbtes.list_controlsource = "fecEmision,numCbte,idCliente,razSoc,totFact"
Thisform.grdCbtes.lista_ancho_cols = "100,150,70,350,100"
Thisform.grdCbtes.titulos_cabeceras = "Fecha,Comprobante,Cliente,Razón Social, Total Factura"
Thisform.grdCbtes.generar_grid()

ENDPROC
PROCEDURE Load
DODEFAULT()

lcSql = ""
loCbtes = CREATEOBJECT("odbc_result")

CREATE CURSOR cur_Cbtes (	;
	idVentasC	int,;
	fecEmision	D,;
	numCbte		varchar(20),;
	idCliente	int,;
	razSoc		varchar(60),;
	totFact		double) 


ENDPROC
PROCEDURE Init
&& El siguiente código permite confeccionar la grilla
DODEFAULT()

ENDPROC


************************************************************
OBJETO: grdCbtes
************************************************************
*** PROPIEDADES ***
Height = 280
Left = 2
Top = 1
Width = 838
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
PROCEDURE press_enter
Thisform.seleccionar()
ENDPROC


************************************************************
OBJETO: btnAceptar
************************************************************
*** PROPIEDADES ***
Top = 283
Left = 748
Height = 44
Width = 45
Name = "btnAceptar"

*** METODOS ***
PROCEDURE Click
Thisform.seleccionar()
ENDPROC


************************************************************
OBJETO: Clscerrar1
************************************************************
*** PROPIEDADES ***
OLEDropEffects = 3
Top = 283
Left = 795
Name = "Clscerrar1"

*** METODOS ***
PROCEDURE Click
Thisform.press_aceptar = .F.
Thisform.Hide()
ENDPROC


************************************************************
OBJETO: cls_busca_fcorigen
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: frm_ncnd_cc
************************************************************
*** PROPIEDADES ***
BorderStyle = 2
Height = 520
Width = 776
DoCreate = .T.
Caption = "Nota de crédito"
cbte = NC
idventascab = -1
cbteref = 
tipodocref = 
ptovtaref = 
numcbteref = 
importecbteref = 
idcliente = -1
idcc_cli = -1
printerdevice = 
idoper = 
imptotiva21 = 0.00
imptotiva105 = 0.00
poriva21 = 0.00
poriva105 = 0.00
ptovta = 
nrocbte = 
cli_calle = 
cli_codpostal = 
cli_localidad = 
cli_pcia = 
cli_sitiva = 
cli_razsoc = 
cli_cuit = 
fiscal_nrodoc = 0
usa_fiscal = .F.
sqlsrv = .F.
idcheque = 0
codabr = 
idsitiva = 0
Name = "frm_ncnd_cc"

*** METODOS ***
PROCEDURE imprimir
LOCAL m.NroCli, m.RazSoc, m.Telefono, m.direccion, m.localidad, m.codPostal, m.pcia, m.TipoIVA, m.nroCUIT
LOCAL m.Total, m.tipoDoc, m.NroCbte, m.Fecha, m.leyenda, m.fecVto, m.tipoDoc, m.ptoVta
LOCAL m.porDesc1, m.porDesc2, m.porDesc3, m.porDesc4
LOCAL m.impDesc1, m.impDesc2, m.impDesc3, m.impDesc4
LOCAL m.impIVA105, m.impIVA21, m.impNeto, m.impFinal, m.porIIBB, m.impIIBB, m.observ
LOCAL lcSql, loNumerador, lcPrinterName, lnCantCpia
LOCAL loResCli, loResLoc, loResPcia

loNumerador = CREATEOBJECT("odbc_result")
loResCli = CREATEOBJECT("odbc_result")
loResLoc = CREATEOBJECT("odbc_result")
loResPcia = CREATEOBJECT("odbc_result")
loResSitIVA = CREATEOBJECT("odbc_result")
lcSql = ""

m.Total = 0.00
m.tipoDoc = ""
m.NroCbte = ""
m.leyenda = ""
m.Fecha = DATETIME()
m.impIVA105 = 0.00
m.impIVA21 = 0.00
m.impNeto = 0.00
m.impFinal = 0.00
m.tipoDoc = Thisform.tipodocref
m.ptoVta = Thisform.ptovta
m.NroCbte = Thisform.ptovta + "-" + Thisform.nrocbte
m.porIIBB = 0.00
m.impIIBB = 0.00
m.observ = ""

&& Me fijo cuantas copias tengo que imprimir
lcSql = "select * from numerador where cbte = '" + ALLTRIM(Thisform.cbte) + "' and tipoDoc = '" + ALLTRIM(m.tipoDoc) + "' AND ptoVta = " + ALLTRIM(STR(INT(VAL(m.ptoVta))))
loNumerador = CREATEOBJECT("odbc_result")
loNumerador.ActiveConnection = goConn.ActiveConnection
loNumerador.Cursor_Name = "cur_num"
loNumerador.OpenQuery(lcSql)

SELECT cur_num
m.NroCbte = m.ptoVta + "-" + REPLICATE("0", 8 - LEN(ALLTRIM(STR(cur_num.numActual)))) + ALLTRIM(STR(cur_num.numActual))
lcPrinterName = cur_num.impresora
lnCantCpia = cur_num.cantCpia

loNumerador.close_query()

&& Recupero los datos del cliente
lcSql = "SELECT * FROM clientes WHERE idCliente = " + ALLTRIM(STR(Thisform.idCliente))
loResCli.cursor_name = "cur_Cliente"
loResCli.ActiveConnection = goConn.ActiveConnection
loResCli.OpenQuery(lcSql)

m.NroCli = cur_Cliente.idCliente
m.RazSoc = cur_Cliente.razSoc
m.Telefono = cur_Cliente.telefono
m.direccion = cur_Cliente.direccion

&& Levanto los datos de la localidad que tiene asignada el cliente
lcSql = "SELECT * FROM localidad WHERE idLocalid = " + ALLTRIM(STR(cur_Cliente.idLocalid))
loResLoc.Cursor_Name = "cur_Loc"
loResLoc.ActiveConnection = goConn.ActiveConnection
loResLoc.OpenQuery(lcSql)

m.localidad = ALLTRIM(cur_Loc.descripcio)
m.codPostal = ALLTRIM(cur_Loc.codPostal)

&& Levanto los datos de la provincia que tiene asignada la localidad
lcSql = "SELECT * FROM provincias WHERE idProvin = " + ALLTRIM(STR(cur_Loc.idProvin))
loResPcia.Cursor_Name = "cur_Pcia"
loResPcia.ActiveConnection = goConn.ActiveConnection
loResPcia.OpenQuery(lcSql)

m.pcia = ALLTRIM(cur_Loc.descripcio)

loResPcia.Close_Query()
loResLoc.Close_Query()

m.nroCUIT = cur_Cliente.nroCUIT

&& Levanto los datos de la situación de IVA que tiene el cliente
lcSql = "SELECT * FROM sitiva WHERE idSitIVA = " + ALLTRIM(STR(cur_Cliente.idSitIVA))
loResSitIVA.Cursor_Name = "cur_SitIVA"
loResSitIVA.ActiveConnection = goConn.ActiveConnection
loResSitIVA.OpenQuery(lcSql)

m.TipoIVA = cur_SitIVA.descripcio

loResSitIVA.Close_Query()
loResCli.Close_Query()


m.impIVA105 = Thisform.txtImpIVA105.Value 
m.impIVA21 = Thisform.txtImpIVA21.Value 
m.impNeto = Thisform.txtSubTotal.Value
m.impFinal = Thisform.txtTotal.Value
m.porIIBB = Thisform.txtporIIBB.Value 
m.impIIBB = Thisform.txtImpIIBB.Value 
m.observ = Thisform.txtobserv.Value

IF ALLTRIM(Thisform.Cbte) == "NC"
	m.Leyenda = "NOTA DE CREDITO"
	m.Total = Thisform.txtTotal.Value
ELSE
	IF ALLTRIM(Thisform.Cbte) == "ND"
		m.leyenda = "NOTA DE DEBITO"
		m.Total = Thisform.txtTotal.Value
	ENDIF
ENDIF

SET PRINTER TO NAME ALLTRIM(lcPrinterName)
SELECT vtadcp

FOR i = 1 TO lnCantCpia
	IF ALLTRIM(m.tipodoc) == "A" THEN 
		REPORT FORM "repncnd.frx" TO PRINTER NOCONSOLE
	ELSE 
		REPORT FORM "repncnd_b.frx" TO PRINTER NOCONSOLE
	ENDIF
NEXT


ENDPROC
PROCEDURE enviar_fiscal
LOCAL lcDireccion, lcDesc, lnPorIIBB, lnImpIIBB

lnPorIIBB = 0.00
lnImpIIBB = 0.00

lcDireccion = Thisform.cli_calle + " " + Thisform.cli_Codpostal + " " + Thisform.cli_Localidad + " " + Thisform.cli_pcia
lnPorIIBB = Thisform.txtporIIBB.Value 
lnImpIIBB = Thisform.txtimpIIBB.Value 

Thisform.Fiscal.Puerto = 1
Thisform.Fiscal.Comenzar()
Thisform.Fiscal.UsarASCII = .F.
Thisform.Fiscal.Modelo = 8  && MODELO_P320
Thisform.Fiscal.TratarDeCancelarTodo()
Thisform.Fiscal.DescripcionesLargas = .T.
Thisform.Fiscal.ReintentoConstante = .T.
Thisform.Fiscal.DatosCliente(ALLTRIM(STR(Thisform.idcliente)) + " - " + ALLTRIM(Thisform.cli_razsoc), ALLTRIM(Thisform.cli_cuit), IIF(thisform.cli_sitiva = 67, 50, 67), Thisform.cli_sitiva, lcDireccion)

IF ALLTRIM(Thisform.cbte) == "NC" THEN
	IF ALLTRIM(thisform.numcbteref) <> "" THEN
		Thisform.Fiscal.InformacionRemito(1) = ALLTRIM(this.ptovtaref) + "-" + ALLTRIM(this.numcbteref)
	ELSE
		Thisform.Fiscal.InformacionRemito(1) = " "
	ENDIF

	IF ALLTRIM(Thisform.TipoDocRef) == "A" THEN
		Thisform.Fiscal.AbrirComprobanteNoFiscalHomologado(82)	&& NOTA DE CREDITO "A"
	ELSE
		Thisform.Fiscal.AbrirComprobanteNoFiscalHomologado(83)	&& NOTA DE CREDITO "B"
	ENDIF
ELSE
	IF ALLTRIM(Thisform.TipoDocRef) == "A" THEN			
		Thisform.Fiscal.AbrirComprobanteFiscal(68)	&& NOTA DE DEBITO "A"
	ELSE
		Thisform.Fiscal.AbrirComprobanteFiscal(69)	&& NOTA DE DEBITO "B"
	ENDIF
ENDIF

SELECT vtadcp
IF RECCOUNT("vtadcp") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("vtadcp")
	lcDesc = ALLTRIM(vtadcp.descPlan)
	THisform.Fiscal.imprimirItem(lcDesc, 1, vtadcp.impNeto + vtadcp.ivaImp, vtadcp.ivaPor, 0) 

	SELECT vtadcp
	SKIP
ENDDO

Thisform.Fiscal.EspecificarPercepcionGlobal("Perc. IIBB. %" + ALLTRIM(STR(lnPorIIBB)), lnImpIIBB)

IF ALLTRIM(Thisform.txtobserv.Value) == "" THEN
	Thisform.Fiscal.Encabezado(11) = ""
ELSE 
	Thisform.Fiscal.Encabezado(11) = ALLTRIM(Thisform.txtobserv.Value)
ENDIF

Thisform.Fiscal.Subtotal(.T.)

IF ALLTRIM(Thisform.cbte) == "NC" THEN
	Thisform.Fiscal.CerrarComprobanteNoFiscalHomologado()
ELSE
	Thisform.Fiscal.CerrarComprobanteFiscal()
ENDIF

&& Thisform.Fiscal_nrodoc = Thisform.Fiscal.Respuesta(3)
Thisform.Fiscal_nrodoc = INT(VAL(Thisform.Fiscal.Respuesta(3)))
Thisform.Fiscal.Finalizar()

ENDPROC
PROCEDURE buscar_cheque
LOCAL loResult, lcSql

loResult = CREATEOBJECT("odbc_result")
lcSql = ""


lcSql = "SELECT * FROM cheques WHERE chq_nro = '" + ALLTRIM(Thisform.txtNroCheque.Value) + "' AND idBanco = " + ALLTRIM(STR(Thisform.sel_Banco.valcpoid)) + " "
lcSql = lcSql + "AND estado != 'R'"

loResult.Cursor_Name = "cur_Bco"
loResult.ActiveConnection = goConn.ActiveConnection
loResult.OpenQuery(lcSql)

SELECT cur_Bco
IF RECCOUNT("cur_Bco") > 0 THEN
	Thisform.IdCheque = cur_Bco.idCheque
	Thisform.txtImporteNeto.Value = cur_Bco.importe
ELSE
	MESSAGEBOX("Cheque no encontrado, por favor, ingrese bien los datos", 0+48, Thisform.Caption)
	Thisform.txtNroCheque.Value = ""
	Thisform.sel_Banco.txtCodigo.Value = ""
	Thisform.sel_Banco.txtDescripcion.Value = ""
ENDIF

loResult.Close_Query()

RETURN .T.

ENDPROC
PROCEDURE calcular_tipodoc
LOCAL lnSitIVACli

lnSitIvaEmp = 0
lnSitIvaEmp = VAL(ALLTRIM(getConfig("SITIVAEMP")))

IF lnSitIvaEmp = 1 .AND. Thisform.idSitIva = 1 THEN
	RETURN "A"
ENDIF

IF lnSitIvaEmp = 1 .AND. Thisform.idSitIva= 2 THEN
	RETURN "B"
ENDIF

IF lnSitIvaEmp = 1 .AND. Thisform.idSitIva = 3 THEN
	RETURN "B"
ENDIF

IF lnSitIvaEmp = 1 .AND. Thisform.idSitIva = 6 THEN
	RETURN "B"
ENDIF

IF lnSitIvaEmp = 6 THEN
	RETURN "B"
ENDIF

ENDPROC
PROCEDURE calcular_ret_iibb
&& Calculo el importe de percepción de ingresos brutos y lo anexo al total
IF (ALLTRIM(Thisform.cbte) == "PTO") THEN
	Thisform.txtImpuestos.Value = 0.00
ELSE 
	Thisform.txtImpIIBB.Value = ROUND(Thisform.txtsubTotal.Value * (Thisform.txtPorIIBB.Value / 100), 2)
	Thisform.txttotal.Value = Thisform.txttotal.Value + Thisform.txtImpIIBB.Value
ENDIF 

ENDPROC
PROCEDURE sumar_items
LOCAL lnSubtotal, lnIVA21, lnIVA105, lnTotal

lnSubtotal = 0.00
lnIVA21 = 0.00
lnIVA105 = 0.00
lnTotal = 0.00

SELECT vtadcp
IF RECCOUNT("vtadcp") > 0
	GO TOP 
ENDIF 

DO WHILE !EOF()
	lnSubtotal = lnSubtotal + vtadcp.impNeto
	
	IF vtadcp.ivaPor = 21 THEN
		lnIVA21 = lnIVA21 + vtadcp.ivaImp
	ELSE
		lnIVA105 = lnIVA105  + vtadcp.ivaImp
	ENDIF
	
	lnTotal = lnTotal + vtadcp.total
	
	SELECT vtadcp
	SKIP 
ENDDO 

Thisform.txtsubTotal.Value = lnSubtotal
Thisform.txtImpIVA21.Value = lnIVA21
Thisform.txtImpIVA105.Value = lnIVA105
Thisform.txttotal.Value = lnTotal

SELECT vtadcp
IF RECCOUNT("vtadcp") > 0
	GO TOP 
ENDIF 

ENDPROC
PROCEDURE Init
DODEFAULT()

&& Creo la grilla
SELECT vtadcp
Thisform.grdDetalle.RecordSource = "vtadcp"
Thisform.grdDetalle.list_controlsource = "codPlanCta,descPlan,cheque_nro,impNeto,ivaPor,ivaImp,total"
Thisform.grdDetalle.lista_ancho_cols = "100,250,100,70,70,70,70"
Thisform.grdDetalle.titulos_cabeceras = "Código,Descripción,Cheque,Imp. Neto,I.V.A,Imp. IVA,Total"
Thisform.grdDetalle.generar_grid()


IF ALLTRIM(GetConfig("USA_FISCAL")) == "S" THEN
	Thisform.usa_fiscal = .T.
ELSE
	Thisform.usa_fiscal = .F.
ENDIF

IF ALLTRIM(GetConfig("SQLSRV")) == "1" THEN
	Thisform.sqlsrv = .T.
ELSE
	Thisform.sqlsrv = .F.
ENDIF
ENDPROC
PROCEDURE Load
DODEFAULT()

&& Creo el cursor que contendrá el detalle del comprobante

CREATE CURSOR vtadcp (	;
	id_vtadcp	int	,;
	idVentasC	int ,;
	idPlanCta	int ,;
	idBanco		int ,;
	codPlanCta	varchar(20),;
	descPlan	varchar(60),;
	cheque_nro	varchar(8),;
	impNeto		float(10, 2),;
	ivaPor		float(10, 2),;
	ivaImp		float(10, 2),;
	total		float(10, 2) ;
)
	

ENDPROC
PROCEDURE Activate
LOCAL lo_rsIIBB

lo_rsIIBB = CREATEOBJECT("odbc_result")
lcSql = ""

&& Levanto el IIBB del cliente
lcSql = "SELECT * FROM padronib WHERE cuit = '" + ALLTRIM(STRTRAN(thisform.cli_cuit,"-","")) + "'"
lo_rsIIBB.ActiveConnection = goConn.ActiveConnection
lo_rsIIBB.Cursor_Name = "cur_PadronIB"
lo_rsIIBB.OpenQuery(lcSql)

SELECT cur_PadronIB
IF RECCOUNT("cur_PadronIB") > 0 THEN
	Thisform.txtPorIIBB.Value = cur_PadronIB.AlicuotaPer
ELSE 
	Thisform.txtPorIIBB.Value = 0.00
ENDIF 

lo_rsIIBB.close_query()

Thisform.chkIVA21.Value = 1
Thisform.txtPtoVta.Value = Thisform.ptovtaref
Thisform.txtNroCbte.Value = Thisform.numcbteref
Thisform.txtPorIVA105.Value = 10.50
Thisform.txtPorIVA21.Value = 21.00

IF ALLTRIM(Thisform.cbte) == "NC" THEN
	Thisform.txtOperacion.Value = "NOTA DE CREDITO"
ELSE
	Thisform.txtOperacion.Value = "NOTA DE DEBITO"
ENDIF
ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Operación"
Height = 15
Left = 12
Top = 12
Width = 72
TabIndex = 15
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Factura de Referencia"
Height = 15
Left = 157
Top = 12
Width = 132
TabIndex = 16
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Importe"
Height = 15
Left = 346
Top = 12
Width = 51
TabIndex = 17
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: txtOperacion
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 12
TabIndex = 18
Top = 28
Width = 120
Name = "txtOperacion"

*** METODOS ***


************************************************************
OBJETO: txtPtoVta
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 157
TabIndex = 19
Top = 28
Width = 43
Name = "txtPtoVta"

*** METODOS ***


************************************************************
OBJETO: txtNroCbte
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 204
TabIndex = 20
Top = 28
Width = 109
Name = "txtNroCbte"

*** METODOS ***


************************************************************
OBJETO: txtImporte
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 347
TabIndex = 21
Top = 28
Width = 86
Name = "txtImporte"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Concepto:"
Height = 15
Left = 12
Top = 70
Width = 72
TabIndex = 22
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: sel_Conceptos
************************************************************
*** PROPIEDADES ***
Top = 63
Left = 91
Width = 557
Height = 25
TabIndex = 1
cfieldname = 
nombre_campo_codigo = codPlanCta
nombre_campo_desc = descripcio
nombre_tabla = planctas
pkfield = idPlanCta
autocompletar_ceros = .F.
Name = "sel_Conceptos"
txtCodigo.Height = 21
txtCodigo.Left = 2
txtCodigo.Top = 2
txtCodigo.Width = 172
txtCodigo.Name = "txtCodigo"
txtDescripcion.Left = 177
txtDescripcion.Top = 2
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***
PROCEDURE recuperar_datos
SELECT planctas
thisform.codabr = planctas.codAbr

&& Si es cheque rechazado, habilito para que carguen el banco y el número
&& de cheque, en caso contrario, deshabilito los controles de cheques.
IF ALLTRIM(planctas.codAbr) == "CHR" THEN
	Thisform.sel_Banco.txtcodigo.Enabled = .T.
	Thisform.txtNroCheque.Enabled = .T.
ELSE
	Thisform.sel_Banco.txtcodigo.Enabled = .F.
	Thisform.txtNroCheque.Enabled = .F.
ENDIF
ENDPROC


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Importe Neto"
Height = 15
Left = 87
Top = 146
Width = 79
TabIndex = 23
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: chkIVA21
************************************************************
*** PROPIEDADES ***
Top = 144
Left = 192
Height = 18
Width = 91
Alignment = 0
Caption = "I.V.A 21,00%"
TabIndex = 5
Name = "chkIVA21"

*** METODOS ***
PROCEDURE Click
IF this.Value = 1 THEN
	Thisform.txtIVA105.Value = 0.00
	Thisform.txtIVA21.Value = ROUND(Thisform.txtImporteNeto.Value * 0.21, 2)
	Thisform.txtImpTotal.Value = ROUND(Thisform.txtImporteNeto.Value + Thisform.txtIVA21.Value + Thisform.txtIVA105.Value, 2)
	Thisform.chkIVA105.Value = 0
ELSE
	Thisform.txtIVA21.Value = 0.00
	Thisform.txtImpTotal.Value = ROUND(Thisform.txtImporteNeto.Value + Thisform.txtIVA21.Value + Thisform.txtIVA105.Value, 2)
ENDIF
ENDPROC


************************************************************
OBJETO: chkIVA105
************************************************************
*** PROPIEDADES ***
Top = 144
Left = 300
Height = 18
Width = 92
Alignment = 0
Caption = "I.V.A 10,50%"
TabIndex = 6
Name = "chkIVA105"

*** METODOS ***
PROCEDURE Click
IF this.Value = 1 THEN
	Thisform.txtIVA21.Value = 0.00
	Thisform.txtIVA105.Value = ROUND(Thisform.txtImporteNeto.Value * 0.105, 2)
	Thisform.txtImpTotal.Value = ROUND(Thisform.txtImporteNeto.Value + Thisform.txtIVA21.Value + Thisform.txtIVA105.Value, 2)
	Thisform.chkIVA21.Value = 0
ELSE
	Thisform.txtIVA105.Value = 0.00
	Thisform.txtImpTotal.Value = ROUND(Thisform.txtImporteNeto.Value + Thisform.txtIVA21.Value + Thisform.txtIVA105.Value, 2)
ENDIF
ENDPROC


************************************************************
OBJETO: Clsetiqueta6
************************************************************
*** PROPIEDADES ***
Caption = "Importe Total"
Height = 15
Left = 412
Top = 146
Width = 79
TabIndex = 25
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: txtImporteNeto
************************************************************
*** PROPIEDADES ***
Left = 84
TabIndex = 4
Top = 162
isnumeric = .T.
Name = "txtImporteNeto"

*** METODOS ***
PROCEDURE LostFocus
IF thisform.chkIVA21.Value = 1 THEN
	Thisform.txtIVA105.Value = 0.00
	Thisform.txtIVA21.Value = ROUND(Thisform.txtImporteNeto.Value * 0.21, 2)
	Thisform.txtImpTotal.Value = ROUND(Thisform.txtImporteNeto.Value + Thisform.txtIVA21.Value + Thisform.txtIVA105.Value, 2)
ELSE
	Thisform.txtIVA21.Value = 0.00
	Thisform.txtIVA105.Value = ROUND(Thisform.txtImporteNeto.Value * 0.105, 2)
	Thisform.txtImpTotal.Value = ROUND(Thisform.txtImporteNeto.Value + Thisform.txtIVA21.Value + Thisform.txtIVA105.Value, 2)
ENDIF
ENDPROC


************************************************************
OBJETO: txtIVA21
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 192
TabIndex = 26
Top = 162
Width = 104
isnumeric = .T.
Name = "txtIVA21"

*** METODOS ***


************************************************************
OBJETO: txtIVA105
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 302
TabIndex = 28
Top = 162
Width = 101
isnumeric = .T.
Name = "txtIVA105"

*** METODOS ***


************************************************************
OBJETO: txtImpTotal
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 411
TabIndex = 29
Top = 162
Width = 101
isnumeric = .T.
Name = "txtImpTotal"

*** METODOS ***


************************************************************
OBJETO: btnAgregar
************************************************************
*** PROPIEDADES ***
Top = 143
Left = 680
Height = 44
Width = 45
TabIndex = 7
Name = "btnAgregar"

*** METODOS ***
PROCEDURE Click
IF Thisform.sel_Conceptos.valcpoid = 0 THEN
	MESSAGEBOX("Debe selecionar un concepto", 0+48, Thisform.Caption)
	Thisform.sel_Conceptos.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

IF Thisform.txtImporteNeto.Value = 0 THEN
	MESSAGEBOX("Debe ingresar el importe neto", 0+48, Thisform.Caption)
	Thisform.txtImporteNeto.SetFocus()
	RETURN .F.
ENDIF

&& Si es cheque rechazado entonces valido que el usuario ingrese los datos
&& del cheque
IF ALLTRIM(Thisform.codAbr) == "CHR" THEN
	IF ALLTRIM(Thisform.Sel_Banco.txtCodigo.Value) == "" THEN
		MESSAGEBOX("Debe ingresar el banco", 0+48, Thisform.Caption)
		Thisform.sel_Banco.txtCodigo.SetFocus()
		RETURN .F.
	ENDIF
	
	IF ALLTRIM(Thisform.txtNroCheque.Value) == "" THEN
		MESSAGEBOX("Debe ingresar el número de cheque", 0+48, Thisform.Caption)
		Thisform.txtNroCheque.SetFocus()
		RETURN .F.
	ENDIF
	
	IF !Thisform.buscar_cheque() THEN
		Thisform.sel_Banco.txtCodigo.SetFocus()
		RETURN .F.
	ENDIF	
ENDIF

SELECT vtadcp
APPEND BLANK
REPLACE vtadcp.id_vtadcp WITH 0
REPLACE vtadcp.idVentasC WITH 0 ADDITIVE
REPLACE vtadcp.idPlanCta WITH Thisform.sel_Conceptos.valcpoid ADDITIVE
REPLACE vtadcp.idBanco WITH Thisform.sel_Banco.valcpoid ADDITIVE
REPLACE vtadcp.codPlanCta WITH Thisform.sel_Conceptos.txtCodigo.Value ADDITIVE
REPLACE vtadcp.descPlan WITH Thisform.sel_Conceptos.txtDescripcion.Value ADDITIVE
REPLACE vtadcp.cheque_nro WITH Thisform.txtNroCheque.Value ADDITIVE
REPLACE	vtadcp.impNeto WITH ROUND(Thisform.txtImporteNeto.Value, 2) ADDITIVE

IF Thisform.txtIVA105.Value <> 0 THEN
	REPLACE vtadcp.ivaPor WITH 10.5 ADDITIVE
	REPLACE vtadcp.ivaImp WITH Thisform.txtIVA105.Value ADDITIVE
ELSE
	REPLACE vtadcp.ivaPor WITH 21 ADDITIVE
	REPLACE vtadcp.ivaImp WITH Thisform.txtIVA21.Value ADDITIVE
ENDIF

REPLACE vtadcp.total WITH Thisform.txtImpTotal.Value ADDITIVE

Thisform.grdDetalle.Refresh()

Thisform.sel_Conceptos.txtCodigo.Value = ""
Thisform.sel_Conceptos.txtdescripcion.Value = ""
Thisform.txtImporteNeto.Value = 0.00
Thisform.txtIVA105.Value = 0.00
Thisform.txtIVA21.Value = 0.00
Thisform.txtImpTotal.Value = 0.00
Thisform.sel_Conceptos.txtCodigo.SetFocus()
Thisform.chkIVA105.Value = 0
Thisform.chkIVA21.Value = 1

Thisform.sumar_items()
Thisform.calcular_ret_iibb()

RETURN .T.
ENDPROC


************************************************************
OBJETO: grdDetalle
************************************************************
*** PROPIEDADES ***
Height = 224
Left = 3
TabIndex = 30
Top = 189
Width = 769
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
OBJETO: SubTotal
************************************************************
*** PROPIEDADES ***
Caption = "SubTotal"
Height = 15
Left = 12
Top = 422
Width = 60
TabIndex = 31
Name = "SubTotal"

*** METODOS ***


************************************************************
OBJETO: txtSubTotal
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 72
TabIndex = 9
Top = 418
Width = 86
isnumeric = .T.
Name = "txtSubTotal"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta9
************************************************************
*** PROPIEDADES ***
Caption = "Total:"
Height = 15
Left = 464
Top = 422
Width = 40
TabIndex = 34
Name = "Clsetiqueta9"

*** METODOS ***


************************************************************
OBJETO: txtTotal
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 504
TabIndex = 12
Top = 418
Width = 86
isnumeric = .T.
Name = "txtTotal"

*** METODOS ***


************************************************************
OBJETO: btnGrabar
************************************************************
*** PROPIEDADES ***
Top = 471
Left = 679
Height = 44
Width = 45
TabIndex = 13
Name = "btnGrabar"

*** METODOS ***
PROCEDURE Click
LOCAL lcSql, loCommand, lnIdVentaC, lnPtoVta, lnIdVtasRel, loResCli
LOCAL loNumerador, lnPtoVta, lnNroCbte, lnPorIVA21 
LOCAL lnPorIVA105, lnImpIVA21, lnImpIVA105, lnIdVtaCP, lnIdCC_Cli
LOCAL lnIdOper, lnSaldo, loDateTime
LOCAL lnIdCondPago, lnIdSitIVA, lnIdVendedor, lnPorIIBB, lnImpIIBB, lnIdCC_CliOrig 

lcSql = ""
loDateTime = CREATEOBJECT("datetime")
loCommand = CREATEOBJECT("odbc_command")
loResCli = CREATEOBJECT("odbc_result")
lnIdVentaC = 0
lnPtoVta = INT(VAL(ALLTRIM(getconfig("PTOVTA"))))
lnNroCbte = 0
lnIdVtaCP = 0
lnIdCC_Cli = 0
lnPorIVA21 = 0.00
lnImpIVA21 = 0.00
lnPorIVA105 = 0.00
lnImpIVA105 = 0.00
lnIdOper = 0
lnSaldo = 0.00
lnIdVtasRel = 0
lnIdCondPago = 0
lnIdSitIVA = 0
lnIdVendedor = 0
lnPorIIBB = 0.00
lnImpIIBB = 0.00
lnIdCC_CliOrig = thisform.idcc_cli


SELECT vtadcp
IF RECCOUNT("vtadcp") = 0 THEN
	MESSAGEBOX("Debe ingresar al menos un ítem del detalle", 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

lcSql = "SELECT * FROM clientes WHERE idCliente = " + ALLTRIM(STR(Thisform.idCliente))
loResCli.ActiveConnection = goConn.ActiveConnection
loResCli.Cursor_Name = "cur_cli"

IF !loResCli.OpenQuery(lcSql) THEN
	MESSAGEBOX(loResCli.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_cli
lnIdCondPago = cur_cli.idCondPago
lnIdSitIVA = cur_cli.idSitIVA
lnIdVendedor = cur_cli.idVendedor

loResCli.Close_Query()

SELECT vtadcp
DO WHILE !EOF("vtadcp") 
	IF vtadcp.ivaPor = 21 THEN
		lnPorIVA21 = vtadcp.ivaPor
		lnImpIVA21 = lnImpIVA21 + vtadcp.ivaImp
	ELSE
		lnPorIVA105 = vtadcp.ivaPor
		lnImpIVA105 = lnImpIVA105 + vtadcp.ivaImp
	ENDIF	

	SELECT vtadcp
	SKIP	
ENDDO

lnPorIIBB = Thisform.txtporIIBB.Value
lnImpIIBB = Thisform.txtImpIIBB.Value

goConn.BeginTransaction()	&& Inicio la transacción

&& Si no está vinculado a ningún comprobante tengo que calcular la letra
&&IF ALLTRIM(Thisform.tipoDocRef) == "" THEN
	Thisform.Tipodocref = Thisform.calcular_tipodoc()
&&ENDIF

IF Thisform.usa_fiscal THEN
	Thisform.enviar_fiscal()
	lnNroCbte = Thisform.fiscal_nrodoc
	
	IF lnNroCbte = 0 THEN
		MESSAGEBOX("Error al enviar el comprobante fiscal, el documento no será grabado", 0+48, Thisform.Caption)
		RETURN .F.
	ENDIF
ELSE
	lcSql = "SELECT * FROM numerador WHERE cbte = '" + ALLTRIM(Thisform.cbte) + "' AND tipoDoc = '" + ALLTRIM(thisform.tipodocref) + "' AND ptoVta = " + ALLTRIM(STR(lnPtoVta))
	loNumerador = CREATEOBJECT("odbc_result")
	loNumerador.ActiveConnection = goConn.ActiveConnection
	loNumerador.Cursor_Name = "cur_num"
	loNumerador.OpenQuery(lcSql)
	SELECT cur_num

	IF RECCOUNT("cur_num") = 0 THEN
		MESSAGEBOX("No se encuentra configurado el numerador del comprobante " + ALLTRIM(Thisform.cbte) + " Punto de Venta: " + ALLTRIM(STR(lnPtoVta)) + " Letra: " + ALLTRIM(thisform.tipodocref), 0+48, thisform.Caption)
		loNumerador.close_query()
		RETURN .F.
	ENDIF

	SELECT cur_num
	lnNroCbte = cur_num.numActual + 1
	Thisform.printerDevice = cur_num.impresora

	loNumerador.close_query()

	&& Actualizo el numerador
	lcSql = "update numerador set numActual = " + ALLTRIM(STR(lnNroCbte)) + ;
		" where cbte = '" + ALLTRIM(Thisform.cbte) + "' and tipoDoc = '" + ALLTRIM(thisform.tipodocref) + "'"

	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql

	IF !loCommand.Execute()
		goConn.Rollback()
		RETURN .F.
	ENDIF
ENDIF

lnIdVentaC = goConn.GetNextId("ventascab", "idVentasC")

lcSql = "INSERT INTO ventascab ( "
lcSql = lcSql + "idVentasC, idCliente, fecEmision, fecVto, cbte, tipoDoc, ptoVta, numCbte, anulado, idCondPago, idSitIVA, idVendedor, "
lcSql = lcSql + "impNeto, impFinal, porIVA21, impIVA21, porIVA105, impIVA105, porDesc1, "
lcSql = lcSql + "porDesc2, porDesc3, porDesc4, impDesc1, impDesc2, impDesc3, impDesc4, totFact, Saldo, usuAlta, fecAlta, idHostAlta, porIIBB, impIIBB, observ) VALUES ("
lcSql = lcSql + ALLTRIM(STR(lnIdVentaC)) + ", "
lcSql = lcSql + ALLTRIM(STR(Thisform.idCliente)) + ", "
lcSql = lcSql + IIF(Thisform.sqlsrv, "GETDATE(), " , "current_date, ")
lcSql = lcSql + IIF(Thisform.sqlsrv, "GETDATE(), " , "current_date, ")
lcSql = lcSql + "'" + ALLTRIM(Thisform.cbte) + "', "
lcSql = lcSql + "'" + ALLTRIM(Thisform.tipodocref) + "', "
lcSql = lcSql + ALLTRIM(STR(lnPtoVta)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnNroCbte)) + ", "
lcSql = lcSql + "0, "
lcSql = lcSQl + ALLTRIM(STR(lnIdCondPago)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnIdSitIVA)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnIdVendedor)) + ", "
lcSql = lcSql + ALLTRIM(STR(Thisform.txtSubTotal.Value, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(Thisform.txtSubTotal.Value, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnPorIVA21, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnImpIVA21, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnPorIVA105, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnImpIVA105, 10, 2)) + ", "
lcSql = lcSql + "0, 0, 0, 0, 0, 0, 0, 0, "
lcSql = lcSql + ALLTRIM(STR(Thisform.txtTotal.Value, 10, 2)) + ", 0, "
lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
lcSql = lcSql + loDateTime.getDateTime() + ", " 
lcSql = lcSql + "'" + SYS(0) + "', "
lcSql = lcSql + ALLTRIM(STR(lnPorIIBB, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnImpIIBB, 10, 2)) + ", "
lcSql = lcSql + "'" + ALLTRIM(thisform.txtobserv.Value) + "')"

loCommand.commandText = lcSql
loCommand.ActiveConnection = goConn.ActiveConnection

IF !loCommand.Execute() then
	goConn.Rollback()
	MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

&& Grabar el detalle en VTADCP
SELECT vtadcp
GO TOP
DO WHILE !EOF("vtadcp")
	lnIdVtaCP = goConn.GetNextID("vtadcp", "id_vtadcp")
	
	lcSql = "INSERT INTO vtadcp ( "
	lcSql = lcSql + "id_vtadcp, idVentasC, idPlanCta, impNeto, ivaPor, ivaImp, total) VALUES "
	lcSql = lcSql + "(" + ALLTRIM(STR(lnIdVtaCP)) + ", " + ALLTRIM(STR(lnIdVentaC)) + ", " + ALLTRIM(STR(vtadcp.idPlanCta)) + ", "
	lcSql = lcSql + ALLTRIM(STR(vtadcp.impNeto, 10, 2)) + ", " + ALLTRIM(STR(vtadcp.ivaPor, 10, 2)) + ", " + ALLTRIM(STR(vtadcp.ivaImp, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(vtadcp.total, 10, 2)) + ")"
	
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute() THEN
		goConn.Rollback()
		MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
		RETURN .F.
	ENDIF
	
	&& Marco el cheque como cheque rechazado
	IF ALLTRIM(vtadcp.cheque_nro) != "" THEN
		lcSql = "UPDATE cheques SET estado = 'R' WHERE chq_nro = '" + ALLTRIM(vtadcp.cheque_nro) + "' AND idBanco = " + ALLTRIM(STR(vtadcp.idBanco))
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
			RETURN .F.
		ENDIF
	ENDIF

	SELECT vtadcp
	SKIP
ENDDO


&& Grabar el registro en CC_CLI vinculado por Id_Oper al cbte seleccionado
lnIdCC_Cli = goConn.GetNextID("cc_cli", "idCC_Cli")

IF Thisform.idOper = 0 THEN
	lnIdOper = goConn.GetNextID("cc_Cli", "idOper")
ELSE
	lnIdOper = Thisform.idOper
ENDIF

IF ALLTRIM(Thisform.cbte) == "NC" THEN
	lcSql = "INSERT INTO cc_cli (idCC_Cli, idCliente, idCC_Orig, idVentasC, cbte, tipoDoc, ptoVta, nroCbte, fecEmis, fecVto, idCondPago, idSitIVA, idVendedor, "
	lcSql = lcSql + "impDebe, impHaber, idOper, observ, usuAlta, fecAlta, idHostAlta) VALUES ( "
	lcSql = lcSql + ALLTRIM(STR(lnIdCC_Cli)) + ", " + ALLTRIM(STR(Thisform.idCliente)) + ", " + IIF(lnIdCC_CliOrig <> -1, ALLTRIM(STR(lnIdCC_CliOrig)), "null") + ", "
	lcSql = lcSql + ALLTRIM(STR(lnIdVentaC)) + ", '" + ALLTRIM(Thisform.cbte) + "', '" + ALLTRIM(Thisform.TipoDocRef) + "', "
	lcSql = lcSql + ALLTRIM(STR(lnPtoVta)) + ", " + ALLTRIM(STR(lnNroCbte)) + ", " + loDateTime.getDateTime() + ", " + loDateTime.getDateTime() + ", " + ALLTRIM(STR(lnIdCondPago)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnIdSitIVA)) + ", " + ALLTRIM(STR(lnIdVendedor)) + ", 0, " + ALLTRIM(STR(Thisform.txtTotal.Value, 10, 2)) + ", " + ALLTRIM(STR(lnIdOPer)) + ", '" + ALLTRIM(thisform.txtobserv.Value) + "', "
	lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', " + loDateTime.getDateTime() + ", '" + ALLTRIM(SYS(0)) + "')"
ELSE
	lcSql = "INSERT INTO cc_cli (idCC_Cli, idCliente, idCC_Orig, idVentasC, cbte, tipoDoc, ptoVta, nroCbte, fecEmis, fecVto, idCondPago, idSitIVA, idVendedor, "
	lcSql = lcSql + "impDebe, impHaber, idOper, usuAlta, fecAlta, idHostAlta) VALUES ( "
	lcSql = lcSql + ALLTRIM(STR(lnIdCC_Cli)) + ", " + ALLTRIM(STR(Thisform.idCliente)) + ", " + IIF(lnIdCC_CliOrig <> -1, ALLTRIM(STR(lnIdCC_CliOrig)), "null") + ", "
	lcSql = lcSql + ALLTRIM(STR(lnIdVentaC)) + ", '" + ALLTRIM(Thisform.cbte) + "', '" + ALLTRIM(Thisform.TipoDocRef) + "', "
	lcSql = lcSql + ALLTRIM(STR(lnPtoVta)) + ", " + ALLTRIM(STR(lnNroCbte)) + ", " + loDateTime.getDateTime() + ", " + loDateTime.getDateTime() + ", " + ALLTRIM(STR(lnIdCondPago)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnIdSitIVA)) + ", " + ALLTRIM(STR(lnIdVendedor)) + ", " + ALLTRIM(STR(Thisform.txtTotal.Value, 10, 2)) + ", 0, " + ALLTRIM(STR(lnIdOper)) + ", '" + ALLTRIM(thisform.txtobserv.Value) + "', "
	lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', " + loDateTime.getDateTime() + ", '" + ALLTRIM(SYS(0)) + "')"
ENDIF

loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = lcSql

IF !loCommand.Execute() THEN
	goConn.Rollback()
	MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

IF Thisform.idVentascab <> - 1 THEN

	&& Actualizar idOper del movimiento seleccionado
	lcSql = "UPDATE cc_cli SET idOper = " + ALLTRIM(STR(lnIdOper)) + ", "
	lcSql = lcSql + "usuModi = '" + ALLTRIM(gcCodUsu) + "', "
	lcSql = lcSql + "fecModi = " + loDateTime.getDateTime() + ", "
	lcSql = lcSql + "idHostModi = '" + ALLTRIM(SYS(0)) + "' "
	lcSql = lcSql + "WHERE idCC_Cli = " + ALLTRIM(STR(Thisform.idcc_cli))

	loCommand.CommandText = lcSql
	loCommand.ActiveConnection = goConn.ActiveConnection

	IF !loCommand.Execute()
		goConn.Rollback()
		RETURN .F.
	ENDIF

	&& Generar el registro de vinculación de comprobantes
	lnIdVtasRel = goConn.GetNextId("ventasrel", "idvtarel")

	&& Vinculo el comprobante de venta
	lcSql = "INSERT INTO ventasrel (idVtaRel, idVtaCO, idVtaCD) VALUES "
	lcSql = lcSql + "(" + ALLTRIM(STR(lnIdVtasRel)) + ", " + ALLTRIM(STR(Thisform.idventascab)) + ", " + ALLTRIM(STR(lnIdVentaC)) + ")"

	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql

	IF !loCommand.Execute()
		goConn.Rollback()
		RETURN .F.
	ENDIF
ENDIF 

&& Actualizar el saldo de la factura seleccionada
IF ALLTRIM(thisform.cbte) == "NC" THEN

	lcSql = "UPDATE VentasCab SET Saldo = Saldo - " + ALLTRIM(STR(Thisform.txtTotal.Value, 10, 2)) + ", "
	lcSql = lcSql + "usuModi = '" + ALLTRIM(gcCodUsu) + "', "
	lcSql = lcSql + "fecModi = " + loDateTime.getDateTime() + ", "
	lcSql = lcSql + "idHostModi = '" + ALLTRIM(SYS(0)) + "' "
	lcSql = lcSql + "WHERE idVentasC IN (SELECT IdVentasC FROM cc_cli WHERE IdOper = " +  ALLTRIM(STR(lnIdOper)) + " AND cbte like 'FC%')"
ELSE 
	lcSql = "UPDATE VentasCab SET Saldo = Saldo + " + ALLTRIM(STR(Thisform.txtTotal.Value, 10, 2)) + ", "
	lcSql = lcSql + "usuModi = '" + ALLTRIM(gcCodUsu) + "', "
	lcSql = lcSql + "fecModi = " + loDateTime.getDateTime() + ", "
	lcSql = lcSql + "idHostModi = '" + ALLTRIM(SYS(0)) + "' "
	lcSql = lcSql + "WHERE idVentasC IN (SELECT IdVentasC FROM cc_cli WHERE IdOper = " +  ALLTRIM(STR(lnIdOper)) + " AND cbte like 'FC%')"

ENDIF
	
loCommand.CommandText = lcSql
loCommand.ActiveConnection = goConn.ActiveConnection

IF !loCommand.Execute()
	goConn.Rollback()
	RETURN .F.
ENDIF 

goConn.Commit()

Thisform.ptovta = REPLICATE("0", 4 - LEN(ALLTRIM(STR(lnPtoVta)))) + ALLTRIM(STR(lnPtoVta))
Thisform.nrocbte = REPLICATE("0", 8 - LEN(ALLTRIM(STR(lnNroCbte)))) + ALLTRIM(STR(lnNroCbte))

MESSAGEBOX("El comprobante: " + ALLTRIM(Thisform.cbte) + " " + ALLTRIM(Thisform.Tipodocref) + " " + REPLICATE("0", 4 - LEN(ALLTRIM(STR(lnPtoVta)))) + ALLTRIM(STR(lnPtoVta)) + "-" + ;
	REPLICATE("0", 8 - LEN(ALLTRIM(STR(lnNroCbte)))) + ALLTRIM(STR(lnNroCbte)) + " se ha generado exitosamente...", 0+64, Thisform.Caption)

IF !Thisform.usa_fiscal THEN
	Thisform.imprimir()
ENDIF

Thisform.Release()
RETURN .T.
ENDPROC


************************************************************
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 471
Left = 727
Height = 44
Width = 45
TabIndex = 14
Name = "btnCerrar"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta10
************************************************************
*** PROPIEDADES ***
Caption = "Banco:"
Height = 15
Left = 12
Top = 94
Width = 72
TabIndex = 24
Name = "Clsetiqueta10"

*** METODOS ***


************************************************************
OBJETO: Sel_Banco
************************************************************
*** PROPIEDADES ***
Top = 87
Left = 91
TabIndex = 2
esnumerico = .F.
cfieldname = codbco
nombre_campo_codigo = codbco
nombre_campo_desc = descripcio
nombre_tabla = bancos
pkfield = idBanco
autocompletar_ceros = .F.
Name = "Sel_Banco"
txtCodigo.Value = 
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta11
************************************************************
*** PROPIEDADES ***
Caption = "Cheque Nº:"
Height = 15
Left = 576
Top = 92
Width = 72
TabIndex = 27
Name = "Clsetiqueta11"

*** METODOS ***


************************************************************
OBJETO: txtNroCheque
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 644
MaxLength = 8
TabIndex = 3
Top = 89
Width = 125
ischaracter = .T.
autocompleta = .T.
Name = "txtNroCheque"

*** METODOS ***
PROCEDURE LostFocus
DODEFAULT()

IF !Thisform.buscar_cheque() THEN
	Thisform.sel_Banco.txtCodigo.SetFocus()
ENDIF

ENDPROC


************************************************************
OBJETO: Fiscal
************************************************************
*** PROPIEDADES ***
Top = 446
Left = 612
Height = 100
Width = 100
Name = "Fiscal"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta12
************************************************************
*** PROPIEDADES ***
Caption = "I.V.A 21:"
Height = 15
Left = 228
Top = 422
Width = 57
TabIndex = 33
Name = "Clsetiqueta12"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta13
************************************************************
*** PROPIEDADES ***
Caption = "I.V.A 10,5:"
Height = 15
Left = 228
Top = 445
Width = 72
TabIndex = 35
Name = "Clsetiqueta13"

*** METODOS ***


************************************************************
OBJETO: txtPorIVA21
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 299
ReadOnly = .T.
TabIndex = 41
Top = 418
Width = 44
isnumeric = .T.
Name = "txtPorIVA21"

*** METODOS ***


************************************************************
OBJETO: txtPorIVA105
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 299
ReadOnly = .T.
TabIndex = 42
Top = 441
Width = 44
isnumeric = .T.
Name = "txtPorIVA105"

*** METODOS ***


************************************************************
OBJETO: txtImpIVA21
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 344
ReadOnly = .T.
TabIndex = 44
Top = 418
Width = 75
isnumeric = .T.
Name = "txtImpIVA21"

*** METODOS ***


************************************************************
OBJETO: txtImpIVA105
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 344
ReadOnly = .T.
TabIndex = 45
Top = 441
Width = 75
isnumeric = .T.
Name = "txtImpIVA105"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta18
************************************************************
*** PROPIEDADES ***
Caption = "Perc. IIBB.:"
Height = 15
Left = 228
Top = 467
Width = 63
TabIndex = 34
Name = "Clsetiqueta18"

*** METODOS ***


************************************************************
OBJETO: txtPorIIBB
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 299
ReadOnly = .T.
TabIndex = 40
Top = 464
Width = 44
isnumeric = .T.
Name = "txtPorIIBB"

*** METODOS ***


************************************************************
OBJETO: txtImpIIBB
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 344
ReadOnly = .T.
TabIndex = 43
Top = 464
Width = 75
isnumeric = .T.
Name = "txtImpIIBB"

*** METODOS ***


************************************************************
OBJETO: Clsdelete1
************************************************************
*** PROPIEDADES ***
Top = 143
Left = 727
Height = 44
Width = 45
Name = "Clsdelete1"

*** METODOS ***
PROCEDURE Click
LOCAL lnResp

lnResp = MESSAGEBOX("Está seguro que desea eliminar este ítem?", 0+4, Thisform.Caption)

IF lnResp = 6 THEN
	SELECT vtadcp 
	DELETE 

	Thisform.grdDetalle.Refresh()

	Thisform.sumar_items()
	Thisform.calcular_ret_iibb()
ENDIF 
ENDPROC


************************************************************
OBJETO: Clsetiqueta7
************************************************************
*** PROPIEDADES ***
Caption = "Leyenda:"
Height = 15
Left = 11
Top = 118
Width = 72
TabIndex = 22
Name = "Clsetiqueta7"

*** METODOS ***


************************************************************
OBJETO: txtobserv
************************************************************
*** PROPIEDADES ***
Enabled = .T.
Height = 21
Left = 93
TabIndex = 18
Top = 113
Width = 550
Name = "txtobserv"

*** METODOS ***


************************************************************
OBJETO: frm_ncnd_cc
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: clsform_consbjacbte
************************************************************
*** PROPIEDADES ***
BorderStyle = 2
Height = 445
Width = 867
DoCreate = .T.
Caption = "Consulta y Baja de Comprobantes"
list_cbtes = 
consulta = .T.
Name = "clsform_consbjacbte"
CONTENIDO.Top = -1
CONTENIDO.Left = -1
CONTENIDO.Width = 868
CONTENIDO.Height = 446
CONTENIDO.Name = "CONTENIDO"

*** METODOS ***
PROCEDURE cargar_combos
&& Cargo los combobox de cbte y tipo de acuerdo a los comprobante seteados en la propiedad list_cbtes

LOCAL lc_cbtes, ln, lc_cantcbtes, ln_cargoAB
DIMENSION la_vector[10]

lc_cbtes = thisform.list_cbtes
lc_cantcbtes = ALINES(la_vector,lc_cbtes,5,",")
ln_cargoAB = 0

Thisform.contenido.cmbTipo.AddItem("Todos")

FOR ln=1 TO lc_cantcbtes 
	IF ln == 1 THEN 
		IF lc_cantcbtes > 1
			Thisform.contenido.cmbCbte.AddItem("Todos")
		ENDIF 
	ENDIF 
	
	Thisform.contenido.cmbCbte.AddItem(STRTRAN(la_vector(ln),"'",""))
	
	IF STRTRAN(la_vector(ln),"'","") == "FC" OR STRTRAN(la_vector(ln),"'","") == "NC" OR STRTRAN(la_vector(ln),"'","") == "ND"
		IF ln_cargoAB = 0 THEN 
			Thisform.contenido.cmbTipo.AddItem("A")
			Thisform.contenido.cmbTipo.AddItem("B")
			ln_cargoAB = 1
		ENDIF 
	ELSE 
		IF STRTRAN(la_vector(ln),"'","") == "PED"
			Thisform.contenido.cmbTipo.AddItem("P")
		ENDIF 
	ENDIF 
ENDFOR 

Thisform.contenido.cmbCbte.ListIndex = 1
Thisform.contenido.cmbTipo.ListIndex = 1

ENDPROC
PROCEDURE Load
DODEFAULT()

CREATE CURSOR cur_Cbtes( 	;
	idVentasC	int,;
	idCliente	int,;
	razSoc		C(60),;
	fecEmis		D,;
	nroDoc		C(20),;
	impFinal	F(10,2),;
	usualta		C(5),;
	idhostalta	C(50),;
	Observ		M)
	
SELECT cur_Cbtes
INDEX on idVentasC TAG idVentasC ASCENDING
INDEX on idCliente TAG idCliente ASCENDING ADDITIVE 
INDEX on razSoc TAG razSoc ASCENDING ADDITIVE 
INDEX on fecEmis TAG fecEmis ASCENDING ADDITIVE 
INDEX on nroDoc TAG nroDoc ASCENDING ADDITIVE 
INDEX on impFinal TAG impFinal ASCENDING ADDITIVE
INDEX on usualta TAG usualta ASCENDING ADDITIVE
INDEX on idhostalta TAG idhostalta ASCENDING ADDITIVE 
	
SELECT cur_Cbtes
SET ORDER TO TAG fecEmis ASCENDING
ENDPROC
PROCEDURE Init
&& Configuro según la funcionalidad del formulario

Thisform.cargar_combos()

IF thisform.consulta
	thisform.contenido.btnEliminar.Visible = .F.
ELSE
	thisform.contenido.btnEliminar.Visible = .T.
ENDIF

thisform.contenido.txtFecDesde.Value = DATE() - 30
thisform.contenido.txtFecHasta.Value = DATE()
thisform.contenido.txtptovta.Value = "0000"
thisform.contenido.txtnumero.Value = "00000000"
thisform.ShowTips = .T.

ENDPROC


************************************************************
OBJETO: CLSETIQUETA1
************************************************************
*** PROPIEDADES ***
Caption = "Cliente Desde:"
Height = 15
Left = 5
Top = 13
TabIndex = 12
Name = "CLSETIQUETA1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Cliente Hasta:"
Height = 15
Left = 5
Top = 37
TabIndex = 13
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Fecha Desde:"
Height = 15
Left = 5
Top = 89
Width = 84
TabIndex = 15
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Fecha Hasta:"
Height = 15
Left = 202
Top = 89
Width = 84
TabIndex = 16
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: sel_cliDesde
************************************************************
*** PROPIEDADES ***
Top = 8
Left = 96
TabIndex = 1
cfieldname = idCliente
esnumerico = .T.
nombre_campo_codigo = idCliente
nombre_campo_desc = razSoc
nombre_tabla = clientes
pkfield = idCliente
requerido = .F.
Name = "sel_cliDesde"
TXTCODIGO.Name = "TXTCODIGO"
TXTDESCRIPCION.Name = "TXTDESCRIPCION"

*** METODOS ***


************************************************************
OBJETO: sel_cliHasta
************************************************************
*** PROPIEDADES ***
Top = 32
Left = 96
TabIndex = 2
cfieldname = idCliente
esnumerico = .T.
nombre_campo_codigo = idCliente
nombre_campo_desc = razSoc
nombre_tabla = clientes
pkfield = idCliente
requerido = .F.
Name = "sel_cliHasta"
TXTCODIGO.Name = "TXTCODIGO"
TXTDESCRIPCION.Name = "TXTDESCRIPCION"

*** METODOS ***


************************************************************
OBJETO: txtFecDesde
************************************************************
*** PROPIEDADES ***
Left = 98
TabIndex = 7
Top = 85
isdatetime = .T.
Name = "txtFecDesde"

*** METODOS ***


************************************************************
OBJETO: txtFecHasta
************************************************************
*** PROPIEDADES ***
Left = 292
TabIndex = 8
Top = 85
isdatetime = .T.
Name = "txtFecHasta"

*** METODOS ***


************************************************************
OBJETO: grdCbtes
************************************************************
*** PROPIEDADES ***
Height = 275
Left = 6
TabIndex = 17
Top = 111
Width = 856
alias_name = cur_Cbtes
permitir_busqueda = .T.
permitir_ordenamiento = .T.
list_controlsource = fecEmis,idCliente,razSoc,nroDoc,impFinal,usualta,idhostalta
lista_ancho_cols = 100,70,200,150,70,70,150
titulos_cabeceras = Fecha,Cliente,Razón Social,Nro. Comprob.,Importe,Usuario,Host
Name = "grdCbtes"
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
OBJETO: btnAceptar
************************************************************
*** PROPIEDADES ***
Top = 65
Left = 818
Height = 44
Width = 45
TabIndex = 9
Name = "btnAceptar"

*** METODOS ***
PROCEDURE Click
LOCAL lcFecDesde, lcFecHasta, loDateTime, lcNroDoc 
LOCAL lnIdCliDesde, lnIdCliHasta, lcSql, loResult

loDateTime = CREATEOBJECT("datetime")
loResult = CREATEOBJECT("odbc_result")
lcFecDesde = loDateTime.toMySql(thisform.contenido.txtFecDesde.Value)
lcFecHasta = loDateTime.toMySql(thisform.contenido.txtFecHasta.Value)
lcNroDoc = "" 

IF thisform.contenido.sel_cliDesde.valcpoid <> 0 .AND. thisform.contenido.sel_CliHasta.valcpoid <> 0
	lnIdCliDesde = thisform.contenido.sel_cliDesde.valcpoid
	lnIdCliHasta = thisform.contenido.sel_CliHasta.valcpoid
ELSE
	lnIdCliDesde = 0
	lnIdCliHasta = 999999
ENDIF

SELECT cur_Cbtes
ZAP

lcSql = "SELECT  VentasCab.IdVentasC, "
lcSql = lcSql + " VentasCab.idCliente, "
lcSql = lcSql + " Clientes.razSoc, "
lcSql = lcSql + " VentasCab.fecEmision, "
lcSql = lcSql + " VentasCab.Cbte, "
lcSql = lcSql + " VentasCab.tipoDoc, "
lcSql = lcSql + " VentasCab.PtoVta, "
lcSql = lcSql + " VentasCab.numCbte, "
lcSql = lcSql + " VentasCab.impFinal, "
lcSql = lcSql + " VentasCab.usualta, "
lcSql = lcSql + " VentasCab.idhostalta, "
lcSql = lcSql + " VentasCab.Observ "
lcSql = lcSql + "FROM    VentasCab INNER JOIN Clientes "
lcSql = lcSql + "             ON VentasCab.idCliente = Clientes.idCliente "
lcSql = lcSql + "WHERE   VentasCab.anulado = 0 "

IF INT(VAL(getConfig("SQLSRV"))) = 1 THEN
	lcSql = lcSql + "         and (CONVERT(CHAR(8), fecEmision, 112) between " + lcFecDesde + " and " + lcFecHasta + ") "
ELSE
	IF INT(VAL(getConfig("SQLSRV"))) = 0 THEN
		lcSql = lcSql + "         and (CAST(fecEmision AS DATE) between " + lcFecDesde + " and " + lcFecHasta + ") "
	ELSE
		lcSql = lcSql + "         and (fecEmision between " + lcFecDesde + " and " + lcFecHasta + ") "
	ENDIF
ENDIF

lcSql = lcSql + "     AND Clientes.idCliente >=  " + ALLTRIM(STR(lnIdCliDesde)) + " "
lcSql = lcSql + "     AND Clientes.idCliente <= " + ALLTRIM(STR(lnIdCliHasta)) + " "

IF ALLTRIM(Thisform.contenido.cmbCbte.Value) == "Todos" THEN 
	lcSql = lcSql + "	  AND VentasCab.Cbte IN (" + Thisform.list_cbtes + ")"
ELSE 
	lcSql = lcSql + "	  AND VentasCab.Cbte = '" + ALLTRIM(Thisform.contenido.cmbCbte.Value) + "' "
ENDIF 

IF ALLTRIM(Thisform.contenido.cmbTipo.Value) != "Todos" THEN 
	lcSql = lcSql + "	  AND VentasCab.tipoDoc = '" + ALLTRIM(Thisform.contenido.cmbTipo.Value) + "' "
ENDIF 

IF ALLTRIM(Thisform.contenido.txtptovta.Value) != "0000" AND ALLTRIM(Thisform.contenido.txtnumero.Value) != "00000000" THEN
	IF ALLTRIM(getconfig("SQLSRV")) == "1" THEN
		lcSql = lcSql + " AND REPLICATE('0', 4 - LEN(LTRIM(RTRIM((VentasCab.ptoVta))))) + LTRIM(RTRIM(VentasCab.ptoVta)) = '" + ALLTRIM(Thisform.contenido.txtptovta.Value) + "' "
		lcSql = lcSql + " AND REPLICATE('0', 8 - LEN(LTRIM(RTRIM((VentasCab.numCbte))))) + LTRIM(RTRIM(VentasCab.numCbte)) = '" + ALLTRIM(Thisform.contenido.txtnumero.Value) + "' "
	ELSE 
		IF ALLTRIM(getconfig("SQLSRV")) == "0" THEN
			lcSql = lcSql + " AND CONCAT(REPEAT('0', 4 - LENGTH(TRIM(CAST(VentasCab.ptoVta AS CHAR)))),TRIM(CAST(VentasCab.ptoVta AS CHAR))) = '" + ALLTRIM(Thisform.contenido.txtptovta.Value) + "' "
			lcSql = lcSql + " AND CONCAT(REPEAT('0', 8 - LENGTH(TRIM(CAST(VentasCab.numCbte AS CHAR)))), TRIM(CAST(VentasCab.numCbte AS CHAR))) = '" + ALLTRIM(Thisform.contenido.txtnumero.Value) + "' "	
		ELSE
			lcSql = lcSql + " AND String(4 - Len(Trim(CStr(VentasCab.ptoVta))), '0') & Trim(CStr(VentasCab.ptoVta)) = '" + ALLTRIM(Thisform.contenido.txtptovta.Value) + "' "
			lcSql = lcSql + " AND String(8 - Len(Trim(CStr(VentasCab.numCbte))), '0') & Trim(CStr(VentasCab.numCbte)) = '" + ALLTRIM(Thisform.contenido.txtnumero.Value) + "' "	
		ENDIF
	ENDIF  
ENDIF 

lcSql = lcSql + "ORDER BY VentasCab.fecEmision"

loResult.ActiveConnection = goConn.ActiveConnection
loResult.cursor_name = "cur_tempo"
loResult.OpenQuery(lcSql)
_cliptext = lcSql
SELECT cur_tempo
IF RECCOUNT() > 0
	GO TOP
ENDIF

SELECT cur_tempo
DO WHILE !EOF()
	lcNroDoc = ALLTRIM(cur_tempo.Cbte) + " " + ALLTRIM(cur_tempo.tipoDoc) + " "
	lcNroDoc = lcNroDoc + REPLICATE("0", 4 - LEN(ALLTRIM(STR(cur_tempo.ptoVta)))) + ALLTRIM(STR(cur_tempo.ptoVta)) + "-"
	lcNroDoc = lcNroDoc + REPLICATE("0", 8 - LEN(ALLTRIM(STR(cur_tempo.numCbte)))) + ALLTRIM(STR(cur_tempo.numCbte))

	SELECT cur_Cbtes
	APPEND BLANK
	REPLACE idVentasC WITH cur_tempo.idVentasC
	REPLACE idCliente WITH cur_tempo.idCliente ADDITIVE
	REPLACE razSoc WITH cur_tempo.razSoc ADDITIVE
	REPLACE fecEmis WITH cur_tempo.fecEmision ADDITIVE
	REPLACE nroDoc WITH lcNroDoc ADDITIVE
	REPLACE impFinal WITH cur_tempo.impFinal ADDITIVE
	REPLACE usualta WITH cur_tempo.usualta ADDITIVE
	REPLACE idhostalta WITH cur_tempo.idhostalta ADDITIVE
	REPLACE observ WITH IIF(ISNULL(cur_tempo.Observ), "", cur_tempo.Observ) ADDITIVE

	SELECT cur_tempo
	SKIP
ENDDO

loResult.close_query()

SELECT cur_Cbtes
IF RECCOUNT() > 0
	GO TOP
ENDIF

Thisform.Contenido.grdCbtes.Refresh()

ENDPROC


************************************************************
OBJETO: btnEliminar
************************************************************
*** PROPIEDADES ***
Top = 394
Left = 769
TabIndex = 11
Name = "btnEliminar"

*** METODOS ***
PROCEDURE Click
LOCAL lnResp, lcSql
LOCAL loCommand

lnResp = 0
lcSql = ""
loCommand = CREATEOBJECT("odbc_command")

lnResp = MESSAGEBOX("¿Está seguro que desea anular el comprobante?", 4+32, Thisform.Caption)

IF lnResp = 6
	lcSql = "UPDATE ventascab "
	lcSql = lcSql + "SET anulado = 1, "
	lcSql = lcSql + "usuBaja = '" + ALLTRIM(gcCodUsu) + "', " 
	IF ALLTRIM(getconfig("SQLSRV")) == "0" THEN
		lcSql = lcSql + "fecBaja = current_timestamp, "
	ELSE
		lcSql = lcSql + "fecBaja = GETDATE(), "
	ENDIF
	lcSql = lcSql + "idHostBaja = '" + SYS(0) + "' "
	lcSql = lcSql + "WHERE idventasc = " + ALLTRIM(STR(cur_Cbtes.idventasc))
	
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.execute()
		MESSAGEBOX("No se ha podido anular el comprobante", 0+64, thisform.Caption)
		RETURN .F.
	ENDIF
	
	SELECT cur_Cbtes
	DELETE
	thisform.contenido.grdCbtes.Refresh()
ENDIF

RETURN .T.
ENDPROC


************************************************************
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 394
Left = 817
TabIndex = 12
Name = "btnCerrar"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Comprobante:"
Height = 15
Left = 5
Top = 62
Width = 84
TabIndex = 14
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: txtptovta
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 208
MaxLength = 4
TabIndex = 5
Top = 59
Width = 45
autocompleta = .T.
ischaracter = .T.
Name = "txtptovta"

*** METODOS ***


************************************************************
OBJETO: cmbCbte
************************************************************
*** PROPIEDADES ***
Height = 24
Left = 98
TabIndex = 3
Top = 58
Width = 59
cfieldname = 
Name = "cmbCbte"

*** METODOS ***


************************************************************
OBJETO: cmbTipo
************************************************************
*** PROPIEDADES ***
Height = 24
Left = 160
TabIndex = 4
Top = 58
Width = 44
Name = "cmbTipo"

*** METODOS ***


************************************************************
OBJETO: txtnumero
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 256
MaxLength = 8
TabIndex = 6
Top = 59
Width = 90
ischaracter = .T.
autocompleta = .T.
Name = "txtnumero"

*** METODOS ***


************************************************************
OBJETO: Clsdetalles1
************************************************************
*** PROPIEDADES ***
Top = 394
Left = 7
TabIndex = 10
Name = "Clsdetalles1"

*** METODOS ***
PROCEDURE Click
DO FORM "frmImagenCbte"
ENDPROC


************************************************************
OBJETO: clsform_consbjacbte
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


