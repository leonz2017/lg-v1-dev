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
OBJETO: FRMRECIBOS
************************************************************
*** PROPIEDADES ***
BorderStyle = 1
Height = 600
Width = 889
DoCreate = .T.
Caption = "Ingreso de Recibos"
WindowType = 0
WindowState = 0
idcliente = 0
idventasc = 0
abrir_fc = .F.
Name = "FRMRECIBOS"

*** METODOS ***
PROCEDURE blanquear

&& Page 1
Thisform.Pgf.Page1.sel_Cliente.txtCodigo.Value = 0
Thisform.Pgf.Page1.sel_Cliente.txtDescripcion.value = ""
Thisform.pgf.page1.sel_cliente.valcpoid = 0
thisform.pgf.page1.txtcodvend.Value = ""
thisform.pgf.page1.txtvendedor.Value = ""
thisform.pgf.page1.txtcondpago.Value = ""
Thisform.Pgf.Page1.contenedor.txtPtoVta.Value = ""
Thisform.Pgf.Page1.contenedor.txtNroRec.Value = ""
Thisform.Pgf.Page1.contenedor.txtFecha.Value = DATE()
Thisform.Pgf.Page1.contenedor.txtImporteFC.Value = 0.00
Thisform.Pgf.Page1.contenedor.txtImpRecibido.Value = 0.00
Thisform.Pgf.Page1.txtEMail.Value = ""
THisform.Pgf.Page1.chkEnviarMail.Value = .F.
Thisform.Pgf.Page1.chkImprimir.Value = .T.

&& Page 2
&& Efectivo/Tarjetas
Thisform.Pgf.Page2.contenedor_efvo.txtImpEfvo.Value = 0.00
thisform.pgf.page2.contenedor_efvo.txtImpTC.Value = 0.00
Thisform.pgf.page2.contenedor_efvo.txtImpTD.Value = 0.00

&& Cheques/Depositos
Thisform.pgf.page2.contenedor_cheques.opgTipoPago.option1.Value = 1
Thisform.pgf.page2.contenedor_cheques.opgTipoPago.option2.Value = 0
Thisform.pgf.page2.contenedor_cheques.sel_Banco.txtCODIGO.Value = ""
Thisform.pgf.page2.contenedor_cheques.sel_Banco.txtDescripcion.Value = ""
Thisform.pgf.page2.contenedor_cheques.sel_Banco.valcpoid = 0
Thisform.pgf.page2.contenedor_cheques.txtsucursal.Value = ""
Thisform.pgf.page2.contenedor_cheques.txtnroCheque.Value = ""
Thisform.pgf.page2.contenedor_cheques.txtFecEmis.Value = {}
Thisform.pgf.page2.contenedor_cheques.txtFecVto.Value = {}
Thisform.pgf.page2.contenedor_cheques.cmbTipoDoc.ListIndex = 1
Thisform.pgf.page2.contenedor_cheques.txtnroCUIT.Value = 0
Thisform.pgf.page2.contenedor_cheques.txtTitular.Value = ""
Thisform.pgf.page2.contenedor_cheques.txtimporte.Value = 0.00
Thisform.pgf.page2.contenedor_cheques.txttotalRec.Value = 0.00

&& Retenciones
Thisform.pgf.page2.contenedor_ret.txtRetGan.Value = 0.00
Thisform.pgf.page2.contenedor_ret.txtRetIIBB.Value = 0.00
Thisform.pgf.page2.contenedor_ret.txtRetIVA.Value = 0.00
Thisform.pgf.page2.contenedor_ret.txtRetSUSS.Value = 0.00
Thisform.pgf.page2.contenedor_ret.txtFecGAN.Value = {}
Thisform.pgf.page2.contenedor_ret.txtFecIIBB.Value = {}
Thisform.pgf.page2.contenedor_ret.txtFecIVA.Value = {}
Thisform.pgf.page2.contenedor_ret.txtFecSUSS.Value = {}
Thisform.pgf.page2.contenedor_ret.txtCbteGAN.Value = 0
Thisform.pgf.page2.contenedor_ret.txtCbteIIBB.Value = 0
Thisform.pgf.page2.contenedor_ret.txtCbteIVA.Value = 0
Thisform.pgf.page2.contenedor_ret.txtCbteSUSS.Value = 0
Thisform.pgf.page2.contenedor_Ret.sel_provincia.txtCodigo.Value = 0
Thisform.pgf.page2.contenedor_Ret.sel_provincia.txtDescripcion.Value = ""
Thisform.pgf.page2.contenedor_Ret.sel_provincia.valcpoid = 0

&& Totales
Thisform.pgf.page2.txtSaldoImputar.Value = 0.00

&& Limpio los cursores 
Thisform.Recibos.limpiar() && Limpia los cursores de facturas y detalle

&& Habilito todo de nuevo
Thisform.Pgf.Page1.sel_Cliente.Enabled = .T.
Thisform.Pgf.Page1.contenedor.txtPtoVta.Enabled = .T.
Thisform.Pgf.Page1.contenedor.txtNroRec.Enabled = .T.
Thisform.Pgf.Page1.contenedor.txtFecha.Enabled = .T.
Thisform.Pgf.Page1.contenedor.txtImpRecibido.Enabled = .T.
Thisform.Pgf.Page1.contenedor.btnAceptar.Enabled = .T.
Thisform.btnGrabar.Enabled = .F.
Thisform.Pgf.Page1.SetFocus()
Thisform.Pgf.Page1.sel_Cliente.txtCodigo.SetFocus()
Thisform.Pgf.Page2.Enabled = .F.
ENDPROC
PROCEDURE imprimir
PARAMETERS tcImpresora, tnCantCpia

LOCAL loRes, lcSql
LOCAL m.nroRec, m.cobrador, m.fecha
LOCAL m.idCliente, m.razSoc, m.domicilio, m.sitIVA, m.localidad, m.nroCUIT
LOCAL m.detFact, m.detPag
LOCAL m.efectivo, m.TDebito, m.TCredito, m.total, m.leyenda
LOCAL lcSaltoLinea, i

m.nroRec = REPLICATE("0", 4 - LEN(ALLTRIM(this.recibos.ptovta))) + ALLTRIM(this.recibos.ptovta) ;
		+ "-" + REPLICATE("0", 8 - LEN(ALLTRIM(this.recibos.nrocbte))) + ALLTRIM(this.recibos.nrocbte)
m.cobrador = ""
m.fecha = DATETIME()
m.idCliente = thisform.pgf.page1.sel_Cliente.valcpoid
m.razSoc = thisform.pgf.page1.sel_Cliente.txtDescripcion.Value
m.domicilio = ""
m.sitIVA = ""
m.localidad = ""
m.nroCUIT = ""
m.detfact = ""
m.detpag = ""
m.efectivo = 0.00
m.TDebito = 0.00
m.TCredito = 0.00
m.total = 0.00
lcSaltoLinea = CHR(13) + CHR(10)
m.leyenda = ""

loRes = CREATEOBJECT("odbc_result")
lcSql = ""

lcSql = "select		clientes.idCliente, "
lcSql = lcSql + "	clientes.razSoc, "
lcSql = lcSql + "	sitiva.descripcio as sitiva, "
lcSql = lcSql + "	clientes.direccion, "
lcSql = lcSql + "	localidad.descripcio, "
lcSql = lcSql + "	clientes.nroCUIT "
lcSql = lcSql + "from	clientes "
lcSql = lcSql + "	inner join sitiva on clientes.idsitiva = sitiva.idsitiva "
lcSql = lcSql + "	inner join localidad on clientes.idLocalid = localidad.idLocalid "
lcSql = lcSql + "where	clientes.idCliente = " + ALLTRIM(STR(m.idCliente))

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_cli"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN
ENDIF

SELECT cur_cli
IF RECCOUNT("cur_cli") > 0 THEN
	m.domicilio = ALLTRIM(cur_cli.direccion)
	m.sitIVA = ALLTRIM(cur_cli.sitiva)
	m.localidad = ALLTRIM(cur_cli.descripcio)
	m.nroCUIT = ALLTRIM(cur_cli.nroCUIT)
ENDIF

loRes.Close_Query()

&& Armo el string correspondiente al detalle de facturas
&& seleccionadas
SELECT cur_facturas
IF RECCOUNT("cur_facturas") > 0 THEN
	GO TOP
ENDIF

m.detfact = ""
DO WHILE !EOF("cur_facturas")
	IF cur_facturas.selected THEN
		m.detfact = m.detfact + ALLTRIM(DTOC(cur_facturas.fecEmis)) + SPACE(2)
		m.detfact = m.detfact + ALLTRIM(cur_facturas.numCbte1) + SPACE(2)
		m.detfact = m.detfact + REPLICATE(" ", 9 - LEN(ALLTRIM(STR(cur_facturas.impApl, 6, 2)))) + ALLTRIM(STR(cur_facturas.impApl, 6, 2))
		m.detfact = m.detfact + lcSaltoLinea
	ENDIF

	SELECT cur_facturas
	SKIP
ENDDO

&& Ahora tengo que armar el strign que permite imprimir el 
&& detalle de los pagos

m.detpag = ""
SELECT cur_detalle
IF RECCOUNT("cur_detalle") > 0 THEN
	GO TOP
ENDIF
DO WHILE !EOF("cur_detalle")
	m.detpag = m.detpag + IIF(cur_detalle.fecEmis = {}, SPACE(10), ALLTRIM(DTOC(cur_detalle.fecEmis))) + SPACE(1)
	m.detpag = m.detpag + SUBSTR(ALLTRIM(cur_detalle.descripcio), 1, 20) + IIF(LEN(ALLTRIM(cur_detalle.descripcio)) < 20, REPLICATE(" ", 20 - LEN(ALLTRIM(cur_detalle.descripcio))), "") + SPACE(1)
	m.detpag = m.detpag + IIF(ALLTRIM(cur_detalle.chq_nro) == "", SPACE(8), ALLTRIM(cur_detalle.chq_nro)) + SPACE(1)
	m.detpag = m.detpag + IIF(ALLTRIM(cur_detalle.nroCuit) == "", SPACE(11), ALLTRIM(cur_detalle.nroCuit) + REPLICATE(" ", 11 - LEN(ALLTRIM(cur_detalle.nroCuit)))) + SPACE(1)
	m.detpag = m.detpag + REPLICATE(" ", 9 - LEN(ALLTRIM(STR(cur_detalle.importe, 6, 2)))) + ALLTRIM(STR(cur_detalle.importe, 6, 2)) + lcSaltoLinea
	
	SELECT cur_Detalle
	SKIP
ENDDO

SELECT cur_detalle
IF RECCOUNT("cur_detalle") = 0 THEN
	SELECT cur_detalle
	APPEND BLANK
	REPLACE cur_detalle.idDetalle WITH 0
	REPLACE cur_detalle.idCheque WITH 0 Additive
	REPLACE cur_detalle.idPlanCta WITH 0 Additive
	REPLACE cur_detalle.idBanco WITH 0 Additive
	REPLACE cur_detalle.descripcio WITH "" Additive
	REPLACE cur_detalle.chq_nro WITH "" Additive
	REPLACE cur_detalle.tipoDoc WITH "" Additive
	REPLACE cur_detalle.nroCuit WITH "" Additive
	REPLACE cur_detalle.titular WITH "" Additive
	REPLACE cur_detalle.fecEmis WITH {} Additive
	REPLACE cur_detalle.fecVto WITH {} Additive
	REPLACE cur_detalle.importe WITH 0 Additive
	REPLACE cur_detalle.tipoPago WITH "" Additive
ENDIF

m.efectivo = Thisform.Pgf.Page2.contenedor_efvo.txtImpEfvo.Value
m.TDebito = Thisform.Pgf.Page2.contenedor_efvo.txtImpTC.Value
m.TCredito = Thisform.Pgf.Page2.contenedor_efvo.txtImpTD.Value
m.Total = Thisform.Pgf.Page2.contenedor_cheques.txtTotalRec.Value + m.efectivo + m.TDebito + m.TCredito

&& Mando por impresora si la opción imprimir está tildada.
IF Thisform.pgf.page1.chkImprimir.Value THEN
	IF ALLTRIM(tcImpresora) == "" THEN
		SET PRINTER TO DEFAULT
	ELSE
		SET PRINTER TO NAME ALLTRIM(tcImpresora)
	ENDIF

	FOR i = 1 TO tnCantCpia
		REPORT FORM "rep_recibos.frx" TO PRINTER NOCONSOLE 
	NEXT i
ENDIF

&& Mando el recibo por mail si está tildado enviar mail.
IF Thisform.pgf.page1.chkEnviarMail.Value THEN
	lcFileName = SYS(5) + SYS(2003) + "\wsafip\ComprobantesPDF\RC_" + m.nroRec + ".pdf"
	&& Solo genero el PDF si el archivo no existe
	IF !FILE(lcFileName) THEN
		loPDF = CREATEOBJECT("Bullzip.PDFPrinterSettings")
			loPDF.SetValue('output', lcFileName)
			loPDF.SetValue('DisableOptionDialog', 'no') 
			loPDF.SetValue('ConfirmOverwrite', 'no')
			loPDF.SetValue('Showsettings', 'never') 
			loPDF.SetValue('ShowSaveAS', 'nofile') 
			loPDF.SetValue('ShowPdf', 'no') 
			loPDF.WriteSettings(.t.)
			
		SET CONSOLE OFF
		SET PRINTER TO NAME("Bullzip PDF Printer")
		SELECT cur_detalle
		REPORT FORM "rep_recibos" NOCONSOLE TO PRINTER
		SET PRINTER TO DEFAULT
		SET CONSOLE ON			
	ENDIF
	
	DO WHILE !FILE(lcFileName)
		WAIT WINDOW "El archivo PDF se está generando, aguarde unos segundos..." NOWAIT	
	ENDDO
	
	TEXT TO lcMailMsg NOSHOW
	Estimado cliente,
	Le adjuntamos el recibo en formato PDF.
	
	Por favor no responder a este mail.
	
	Saludos cordiales,
	[firma]
	
	--
	Mail generado por sistema LINFOW Gestión.
	
	ENDTEXT
	lcMailMsg = STRTRAN(lcMailMsg, "[firma]", getGlobalCFG("EMAILFIRMA"))	
	
	&& Envío el mail con el recibo
	DO LOCFILE("FoxyPreviewer.App")
	WITH _screen.oFoxyPreviewer	
		.cEmailType = "PDF"
		.nEmailMode = 2
		.cEMailTo = ALLTRIM(Thisform.pgf.page1.txtEMail.Value)
		.cEmailCC = ALLTRIM(getGlobalCFG("EMAILCC"))
		.cSMTPServer = getGlobalCFG("EMAILSMTP")
		.cEmailFrom = getGlobalCFG("EMAILEMP") + "<" + getGlobalCFG("EMAILADDR") + ">"
		.cEMailSubject = "Recibo " + m.nroRec
		.nSMTPPort = getGlobalCFG("EMAILPORT")
		.lSMTPUseSSL = getGlobalCFG("EMAILSSL")
		.cSMTPUserName = getGlobalCFG("EMAILUSR")
		.cSMTPPassword = getGlobalCFG("EMAILPWD")
		.lReadReceipt  = .F.
		.lPriority = .F.
		.cEmailBody = lcMailMsg
		.SendEmailUsingCDO(lcFileName)
	ENDWITH
	DO LOCFILE("FoxyPreviewer.App") WITH "Release"	
ENDIF
ENDPROC
PROCEDURE calc_saldoimputar
&& Este metodo calcula el saldo a imputar

Thisform.Pgf.Page2.txtSaldoImputar.Value = Thisform.Pgf.Page1.contenedor.txtImpRecibido.Value - ;
	Thisform.Pgf.Page2.contenedor_efvo.txtImpEfvo.value - ;
	Thisform.Pgf.Page2.contenedor_efvo.txtImpTC.Value - ;
	Thisform.Pgf.Page2.contenedor_efvo.txtImpTD.Value - ;
	Thisform.Pgf.Page2.contenedor_cheques.txtTotalRec.Value - ;
	Thisform.Pgf.Page2.contenedor_ret.txtRetGan.Value - ;
	Thisform.Pgf.Page2.contenedor_ret.txtRetIIBB.Value - ;
	Thisform.Pgf.Page2.contenedor_ret.txtRetIVA.Value - ;
	Thisform.Pgf.Page2.contenedor_ret.txtRetSUSS.Value

	
ENDPROC
PROCEDURE validar_pago
&& Valido que el pago se haya hecho correctamente.
LOCAL lnCantSel, lnImporte, lnImputado, lnSuma

lnCantSel = 0
lnImporte = 0.00
lnImputado = Thisform.pgf.page1.contenedor.txtimpRecibido.Value
lnSuma = 0

IF !getGlobalCFG("NRC_AUTO") THEN
	&& Valido que se haya ingresado el punto de venta
	IF  ALLTRIM(Thisform.pgf.Page1.contenedor.txtPtoVta.Value) == "" .OR. ALLTRIM(Thisform.pgf.Page1.contenedor.txtPtoVta.Value) == "0000" THEN
		MESSAGEBOX("Debe ingresar el punto de venta correspondiente al número de recibo", 0+48, Thisform.Caption)
		Thisform.pgf.Page1.contenedor.txtPtoVta.SetFocus()
		RETURN .F.
	ENDIF
	&& Valido que se haya ingresado el numero de recibo	
	IF ALLTRIM(Thisform.pgf.Page1.contenedor.txtNroRec.Value) == "" .OR. ALLTRIM(Thisform.pgf.Page1.contenedor.txtNroRec.Value) == "00000000" THEN
		MESSAGEBOX("Debe ingresar el número de recibo", 0+48, Thisform.Caption)
		Thisform.pgf.Page1.contenedor.txtNroRec.SetFocus()
		RETURN .F.
	ENDIF
ENDIF
IF !thisform.recibos.validar_numero(ALLTRIM(Thisform.pgf.Page1.contenedor.txtPtoVta.Value), ALLTRIM(Thisform.pgf.Page1.contenedor.txtNroRec.Value)) THEN 
	RETURN .F.
ENDIF

&& Valido los comprobantes seleccionados
SELECT cur_facturas
IF RECCOUNT("cur_facturas") > 0 THEN
	GO TOP
ENDIF

SELECT	idCliente ;
FROM	cur_facturas ;
WHERE	selected = .T.;
GROUP BY idCliente INTO CURSOR cur_x

SELECT cur_x

IF RECCOUNT("cur_x") = 0 THEN && Valido que se haya seleccionado al menos un comprobante
	MESSAGEBOX("Debe seleccionar al menos un comprobante para aplicar el pago", 0+48, Thisform.Caption)
	USE IN cur_x
	RETURN .F.
ELSE
	Thisform.idcliente = cur_x.idCliente	&& Si el cliente seleccionado es uno solo guardo el numero.
ENDIF

USE IN cur_x


&& Valido que se haya ingresado algun importe en el pago.
lnSuma = Thisform.Pgf.Page2.contenedor_efvo.txtImpEfvo.Value + Thisform.Pgf.Page2.contenedor_cheques.txtTotalRec.Value
lnSuma = lnSuma + Thisform.Pgf.Page2.contenedor_efvo.txtImpTC.Value
lnSuma = lnSuma + Thisform.Pgf.Page2.contenedor_efvo.txtImpTD.Value
lnSuma = lnSuma + Thisform.Pgf.Page2.contenedor_ret.txtRetGan.Value
lnSuma = lnSuma + Thisform.Pgf.Page2.contenedor_ret.txtRetIIBB.Value
lnSuma = lnSuma + Thisform.Pgf.Page2.contenedor_ret.txtRetIVA.Value
lnSuma = lnSuma + Thisform.Pgf.Page2.contenedor_ret.txtRetSUSS.Value

IF lnSuma = 0 THEN 
	MESSAGEBOX("No ingreso importes en el pago", 0+48, Thisform.Caption)
	RETURN .F.
ENDIF 

IF Thisform.Pgf.Page1.contenedor.txtImpRecibido.Value <> lnSuma THEN
	MESSAGEBOX("No coincide el importe recibido con lo imputado. Verifique el recibo por favor.", 0+48, Thisform.Caption)
	RETURN .F.
ENDIF


&& Valido que no se hayan seleccionado mas facturas de las que se puede cancelar con el pago.
SELECT COUNT(*) AS cantSel FROM cur_facturas WHERE selected = .T. ;
INTO CURSOR cur_x

SELECT cur_x
lnCantSel = cur_x.cantSel
USE IN cur_x

SELECT cur_facturas 
IF RECCOUNT("cur_facturas") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_facturas")
	IF cur_facturas.selected THEN
		IF (lnCantSel > 1) .AND. lnImputado <= 0 THEN
			MESSAGEBOX("El pago no es válido, por favor verifique las facturas seleccionadas.", 0+48, Thisform.Caption)
			RETURN .F.
		ELSE
			lnImputado = lnImputado - cur_facturas.saldo
		ENDIF
	ENDIF

	SELECT cur_facturas
	SKIP
ENDDO

SELECT cur_facturas
IF RECCOUNT("cur_facturas") > 0 THEN
	GO TOP
ENDIF


&& Valido que los cheques ingresados no esten ya cargados en la base
IF !Thisform.recibos.validar_todosloscheques(thisform.idcliente)
	RETURN .F.
ENDIF 	

&& Valido que se ingresen todos los datos de IIBB
IF thisform.pgf.page2.contenedor_Ret.txtRetIIBB.Value <> 0 THEN 
	IF thisform.pgf.page2.contenedor_Ret.txtfecIIBB.Value = {} THEN 
		MESSAGEBOX("Debe ingresar la fecha de retención IIBB", 0+48, Thisform.Caption)
		thisform.pgf.page2.contenedor_Ret.txtfecIIBB.SetFocus()
		RETURN .F.
	ENDIF 
	
	IF thisform.pgf.page2.contenedor_Ret.txtCbteIIBB.Value = 0 THEN 
		MESSAGEBOX("Debe ingresar el Nº de comprobante de retención IIBB", 0+48, Thisform.Caption)
		thisform.pgf.page2.contenedor_Ret.txtCbteIIBB.SetFocus()
		RETURN .F.
	ENDIF 
	
	IF thisform.pgf.page2.contenedor_Ret.sel_provincia.txtCodigo.Value = 0 THEN 
		MESSAGEBOX("Debe ingresar la provincia de retención IIBB", 0+48, Thisform.Caption)
		thisform.pgf.page2.contenedor_Ret.sel_provincia.txtCodigo.SetFocus()
		RETURN .F.
	ENDIF 
ENDIF 

&& Valido que se ingresen todos los datos de IVA
IF thisform.pgf.page2.contenedor_Ret.txtRetIVA.Value <> 0 THEN 
	IF thisform.pgf.page2.contenedor_Ret.txtfecIVA.Value = {} THEN 
		MESSAGEBOX("Debe ingresar la fecha de retención IVA", 0+48, Thisform.Caption)
		thisform.pgf.page2.contenedor_Ret.txtfecIVA.SetFocus()
		RETURN .F.
	ENDIF 
	
	IF thisform.pgf.page2.contenedor_Ret.txtCbteIVA.Value = 0 THEN 
		MESSAGEBOX("Debe ingresar el Nº de comprobante de retención IVA", 0+48, Thisform.Caption)
		thisform.pgf.page2.contenedor_Ret.txtCbteIVA.SetFocus()
		RETURN .F.
	ENDIF 
ENDIF 

&& Valido que se ingresen todos los datos de GANANCIAS
IF thisform.pgf.page2.contenedor_Ret.txtRetGAN.Value <> 0 THEN 
	IF thisform.pgf.page2.contenedor_Ret.txtfecGAN.Value = {} THEN 
		MESSAGEBOX("Debe ingresar la fecha de retención Ganancias", 0+48, Thisform.Caption)
		thisform.pgf.page2.contenedor_Ret.txtfecGAN.SetFocus()
		RETURN .F.
	ENDIF 
	
	IF thisform.pgf.page2.contenedor_Ret.txtCbteGAN.Value = 0 THEN 
		MESSAGEBOX("Debe ingresar el Nº de comprobante de retención Ganancias", 0+48, Thisform.Caption)
		thisform.pgf.page2.contenedor_Ret.txtCbteGAN.SetFocus()
		RETURN .F.
	ENDIF 
ENDIF 

&& Valido que se ingresen todos los datos de SUSS
IF thisform.pgf.page2.contenedor_Ret.txtRetSUSS.Value <> 0 THEN 
	IF thisform.pgf.page2.contenedor_Ret.txtfecSUSS.Value = {} THEN 
		MESSAGEBOX("Debe ingresar la fecha de retención SUSS", 0+48, Thisform.Caption)
		thisform.pgf.page2.contenedor_Ret.txtfecSUSS.SetFocus()
		RETURN .F.
	ENDIF 
	
	IF thisform.pgf.page2.contenedor_Ret.txtCbteSUSS.Value = 0 THEN 
		MESSAGEBOX("Debe ingresar el Nº de comprobante de retención SUSS", 0+48, Thisform.Caption)
		thisform.pgf.page2.contenedor_Ret.txtCbteSUSS.SetFocus()
		RETURN .F.
	ENDIF 
ENDIF 


RETURN .T.
ENDPROC
PROCEDURE cargar_tipodoc
&& Cargo el combobox con los tipos de documento

LOCAL lcSql, loResult

lcSql = ""
loResult = CREATEOBJECT("odbc_result")

lcSql = "SELECT * FROM tipodoc"
loResult.ActiveConnection = goConn.ActiveConnection
loResult.cursor_name = "cur_tipodoc"

IF !loResult.OpenQuery(lcSql)
	MESSAGEBOX(loResult.error_message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF 

SELECT cur_tipodoc
IF RECCOUNT("cur_tipodoc") > 0 THEN 
	GO TOP
ELSE 
	RETURN .F.
ENDIF 

DO WHILE !EOF("cur_tipodoc")
	SELECT cur_tipodoc
	Thisform.pgf.page2.contenedor_cheques.cmbTipoDoc.AddItem(ALLTRIM(cur_tipodoc.tipodoc))
	
	SKIP 
ENDDO 

loResult.close_query()

Thisform.pgf.page2.contenedor_cheques.cmbTipoDoc.ListIndex = 1
ENDPROC
PROCEDURE realizar_recibo_automatico
LOCAL i
LOCAL lnIdVentaC
LOCAL lnImpTotal

i = 0
lnIdVentaC = 0
lnImpTotal = 0.00

FOR i = 1 TO GETWORDCOUNT(this.idventasc, ",")
	lnIdVentaC = INT(VAL(GETWORDNUM(this.idventasc, i, ",")))
	SELECT cur_facasel
	APPEND BLANK
	REPLACE cur_facasel.idVentasC WITH lnIdVentaC
NEXT i

&& Selecciono el cliente
This.pgf.page1.sel_Cliente.txtCodigo.Value = This.idcliente
This.pgf.page1.sel_Cliente.txtCodigo.LostFocus()
This.pgf.page1.contenedor.btnAceptar.SetFocus()

&& Selecciono la(s) factura(s) que hay que cancelar en forma
&& automática.
&& Este UPDATE es una prueba, en caso de que no funcione, entonces
&& hay que hacerlo de forma tradicional con un ciclo.
UPDATE cur_facturas 		;
SET cur_facturas.selected = .t. 	;
FROM cur_facasel			;
WHERE cur_facasel.idVentasC = cur_facturas.idVentasC

lnImpTotal = 0.00
SELECT cur_facturas
GO TOP
DO WHILE !EOF("cur_facturas")
	IF cur_facturas.selected THEN
		lnImpTotal = lnImpTotal + cur_facturas.saldo
	ENDIF

	SELECT cur_facturas
	SKIP
ENDDO

SELECT cur_facturas
GO TOP

This.Pgf.page1.grdCbtes.Refresh()
This.Pgf.page1.contenedor.txtImpRecibido.Value = lnImpTotal
This.Pgf.page2.contenedor_efvo.txtImpEfvo.Value = lnImpTotal
This.Pgf.page1.contenedor.btnAceptar.Click()
ENDPROC
PROCEDURE imprimir_ticket
******************************************************************
* Imprimio el recibo en la ticketeadora
******************************************************************
LPARAMETERS tcImpresora, tnCopias

* Variables locales
LOCAL loRes
LOCAL lcSql
LOCAL m.efectivo
LOCAL m.TDebito
LOCAL m.TCredito
LOCAL m.Total


* Configuro los datos del ticket
Thisform.o_ticket.Leyenda = "RECIBO"
Thisform.o_ticket.Nro_cbte = Thisform.recibos.Nrocbte
Thisform.o_ticket.Nombre_impresora = ALLTRIM(tcImpresora)

* Levanto los datos del cliente.
loRes = CREATEOBJECT("odbc_result")
TEXT TO lcSql NOSHOW
	SELECT		
		clientes.idCliente,
		clientes.razSoc,
		sitiva.descripcio AS sitiva,
		clientes.direccion,
		localidad.descripcio,
		localidad.codPostal,
		clientes.nroCUIT
	FROM
		clientes
			INNER JOIN sitiva 		ON clientes.idsitiva = sitiva.idsitiva
			INNER JOIN localidad 	ON clientes.idLocalid = localidad.idLocalid
	WHERE
		clientes.idCliente = ?idcliente
ENDTEXT
lcSql = loRes.AddParameter(lcSql, "idcliente", ALLTRIM(STR(thisform.recibos.Idcliente)), .F., .F.)
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_cli"
loRes.OpenQuery(lcSql)

* Cargo los datos del cliente en el objeto ticket
Thisform.o_ticket.Fecha_cbte = Thisform.recibos.Fec_emis
Thisform.o_ticket.Numero_cliente = cur_cli.idCliente
Thisform.o_ticket.Razon_social = ALLTRIM(cur_cli.razSoc)
Thisform.o_ticket.Tipo_iva = ALLTRIM(cur_cli.sitiva)
Thisform.o_ticket.Nro_cuit = ALLTRIM(cur_cli.nroCUIT)
Thisform.o_ticket.Direccion = ALLTRIM(cur_cli.direccion)
Thisform.o_ticket.Localidad = ALLTRIM(cur_cli.descripcio)
Thisform.o_ticket.Codigo_postal = ALLTRIM(cur_cli.codPostal)

loRes.Close_Query()

&& Levanto las facturas seleccionadas y las paso al objeto Ticket.
SELECT cur_facturas
GO TOP

DO WHILE !EOF("cur_facturas")
	IF cur_facturas.selected THEN
		Thisform.o_ticket.Add_fc_seleccionada(cur_facturas.fecEmis, cur_facturas.numCbte1, cur_facturas.impApl)
	ENDIF

	SELECT cur_facturas
	SKIP
ENDDO

* Levanto el detalle del recibo
SELECT cur_detalle
GO TOP
DO WHILE !EOF("cur_detalle")
	Thisform.o_ticket.Add_item_recibo( ;
		cur_detalle.fecEmis, ;
		cur_detalle.descripcio, ;
		cur_detalle.chq_nro, ;
		cur_detalle.nroCuit, ;
		cur_detalle.importe)
	
	SELECT cur_detalle
	SKIP
ENDDO

* Levanto los montos de las formas de pagos
*!*	m.efectivo = Thisform.Pgf.Page2.contenedor_efvo.txtImpEfvo.Value
*!*	m.TDebito = Thisform.Pgf.Page2.contenedor_efvo.txtImpTC.Value
*!*	m.TCredito = Thisform.Pgf.Page2.contenedor_efvo.txtImpTD.Value

*!*	IF m.efectivo <> 0 THEN
*!*		Thisform.o_ticket.Add_item_recibo({}, "EFECTIVO", "", "", m.efectivo)
*!*	ENDIF

*!*	IF m.TDebito <> 0 THEN
*!*		Thisform.o_ticket.Add_item_recibo({}, "T. DEBITO", "", "", m.TDebito)
*!*	ENDIF

*!*	IF m.TCredito <> 0 THEN
*!*		Thisform.o_ticket.Add_item_recibo({}, "T. Crédito", "", "", m.TCredito)
*!*	ENDIF

Thisform.o_ticket.Imprimir_recibo()





ENDPROC
PROCEDURE Init
thisform.recibos.crear_cursor()
thisform.o_ticket.crear_cursor()

&& Armo la grilla que corresponde a la selección de facturas
SELECT cur_facturas
Thisform.Pgf.Page1.grdCbtes.RecordSource = "cur_facturas"
Thisform.Pgf.Page1.grdCbtes.list_controlsource = "selected,fecEmis,cbte,tipodoc,numCbte1,importe,saldo"
Thisform.Pgf.Page1.grdCbtes.lista_ancho_cols = "70,150,70,50,150,100,100"
Thisform.Pgf.Page1.grdCbtes.titulos_cabeceras = "Sel.,Fecha,Cbte,Tipo,Número,Importe,Saldo"
Thisform.Pgf.Page1.grdCbtes.generar_grid()

&& Armo la grilla correspondiente al detalle del recibo
SELECT cur_Detalle
Thisform.pgf.Page2.contenedor_cheques.grdDetalle.RecordSource = "cur_Detalle"
Thisform.Pgf.Page2.contenedor_cheques.grdDetalle.list_controlsource = "tipoPago,chq_nro,descripcio,tipoDoc,nroCuit,titular,fecvto,importe"
Thisform.Pgf.Page2.contenedor_cheques.grdDetalle.lista_ancho_cols = "70,80,170,70,80,200,70,70"
Thisform.Pgf.Page2.contenedor_cheques.grdDetalle.titulos_cabeceras = "Tipo Pago,Nº Cheque,Descripción,Tipo Doc.,Nº Doc.,Titular,Fecha Vto.,Importe"
Thisform.Pgf.Page2.contenedor_cheques.grdDetalle.generar_grid();

&& Cargo los tipos de documento
Thisform.cargar_tipodoc()

IF getGlobalCFG("NRC_AUTO") THEN
	thisform.pgf.page1.contenedor.labRecibo.Visible = .F.
	thisform.pgf.page1.contenedor.txtPtoVta.Visible = .F.
	thisform.pgf.page1.contenedor.txtNroRec.Visible = .F.
ELSE
	thisform.pgf.page1.contenedor.labRecibo.Visible = .T.
	thisform.pgf.page1.contenedor.txtPtoVta.Visible = .T.
	thisform.pgf.page1.contenedor.txtNroRec.Visible = .T.
ENDIF

&& En el detalle de pago por default se habilita el ingreso de cheques
Thisform.Pgf.Page2.Enabled = .F.
Thisform.Pgf.Page1.contenedor.txtFecha.Value = DATE()

Thisform.Pgf.Page1.SetFocus()
Thisform.Pgf.Page1.sel_Cliente.txtCodigo.SetFocus()
Thisform.abrir_fc = .f.

&& Inicializo los controles del mail
Thisform.Pgf.Page1.txtEMail.Value = ""
THisform.Pgf.Page1.chkEnviarMail.Value = .F.
Thisform.Pgf.Page1.chkImprimir.Value = .T.
ENDPROC
PROCEDURE Load
DODEFAULT()


	

ENDPROC


************************************************************
OBJETO: pgf
************************************************************
*** PROPIEDADES ***
ErasePage = .T.
Top = 1
Left = 2
Width = 886
Height = 555
Name = "pgf"
Page1.Caption = "Comprobantes a Aplicar"
Page1.Name = "Page1"
Page2.Caption = "Pagos"
Page2.Name = "Page2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Cliente:"
Height = 15
Left = 9
Top = 9
Width = 48
TabIndex = 4
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: sel_Cliente
************************************************************
*** PROPIEDADES ***
Top = 3
Left = 79
TabIndex = 1
esnumerico = .T.
nombre_campo_codigo = idCliente
nombre_campo_desc = razSoc
nombre_tabla = clientes
pkfield = idCliente
criterio_filtro = fecBaja is null
Name = "sel_Cliente"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***
PROCEDURE recuperar_datos
LOCAL loVtas, lcSql, lcPtoVta, lcNumero, loVendedor, loCondPago

loVtas = CREATEOBJECT("odbc_result")
loVendedor = CREATEOBJECT("odbc_result")
loCondPago = CREATEOBJECT("odbc_result")
lcSql = ""
lcPtoVta = ""
lcNumero = ""

&& Limpio los controles al cambiar de cliente
thisform.pgf.page1.txtcodvend.Value = ""
thisform.pgf.page1.txtvendedor.Value = ""
thisform.pgf.page1.txtcondpago.Value = ""
Thisform.Pgf.Page1.contenedor.txtPtoVta.Value = ""
Thisform.Pgf.Page1.contenedor.txtNroRec.Value = ""
Thisform.Pgf.Page1.contenedor.txtFecha.Value = DATE()
Thisform.Pgf.Page1.contenedor.txtImporteFC.Value = 0.00
Thisform.Pgf.Page1.contenedor.txtImpRecibido.Value = 0.00
Thisform.Recibos.limpiar()

thisform.idcliente = clientes.idcliente
thisform.pgf.page1.txtEmail.Value = clientes.mailFC
thisform.pgf.page1.chkEnviarMail.Value = clientes.envCbte
thisform.pgf.page1.chkImprimir.Value = clientes.printCbte

&& Levanto los datos del cliente
lcSql = "SELECT * FROM vendedores WHERE idVendedor = ?pIdVendedor"
lcSql = loVendedor.addParameter(lcSql, "pIdVendedor", ALLTRIM(STR(clientes.idvendedor)), .f., .f.)
loVendedor.ActiveConnection = goConn.ActiveConnection
loVendedor.Cursor_Name = "cur_vendedores"
loVendedor.OpenQuery(lcSql)

thisform.pgf.page1.txtcodvend.Value = ALLTRIM(STR(cur_vendedores.idvendedor))
thisform.pgf.page1.txtvendedor.Value = ALLTRIM(cur_vendedores.nombre)

loVendedor.Close_Query()

lcSql = "SELECT * FROM condpagos WHERE idcondpago = ?pIdCondPago"
lcSql = loCondPago.addParameter(lcSql, "pIdCondPago", ALLTRIM(STR(clientes.idcondpago)), .f., .f.)
loCondPago.ActiveConnection = goConn.ActiveConnection
loCondPago.Cursor_Name = "cur_condpago"
loCondPago.OpenQuery(lcSql)

thisform.pgf.page1.txtcondpago.Value = ALLTRIM(cur_condpago.descripcio)

loCondPago.Close_Query()
*********************************************************
lcSql = "SELECT		cc_cli.idVentasC, "
lcSql = lcSql + "	cc_cli.idCliente, "
lcSql = lcSql + "	cc_cli.idCondPago, "
lcSql = lcSql + "	cc_cli.idSitIVA, "
lcSql = lcSql + "	cc_cli.idVendedor, "
lcSql = lcSql + "	clientes.razSoc, "
lcSql = lcSql + "	cc_cli.fecEmis, "
lcSql = lcSql + "	cc_cli.tipoDoc, "
lcSql = lcSql + "	cc_cli.cbte, "
lcSql = lcSql + "	cc_cli.ptoVta, "
lcSql = lcSql + "	cc_cli.nroCbte, "
lcSql = lcSql + "	cc_cli.impdebe, "
lcSql = lcSql + "	saldo "
lcSql = lcSql + " FROM cc_cli INNER JOIN clientes ON cc_cli.idCliente = clientes.idCliente "
lcSql = lcSql + "	INNER JOIN condpagos ON condpagos.idCondPago = cc_cli.idCondPago "
lcSql = lcSql + "	LEFT JOIN (SELECT cc2.idoper, ROUND(SUM(cc2.impdebe - cc2.imphaber),2) as Saldo "
lcSql = lcSql + "				FROM cc_cli cc2 "
lcSql = lcSql + "				WHERE (cc2.usubaja is null or cc2.usubaja = '') "
lcSql = lcSql + "				GROUP BY cc2.idoper) AS Saldos ON cc_cli.idoper = Saldos.idoper "
lcSql = lcSql + " WHERE cbte IN ('FC','ND') "
lcSql = lcSql + " 	AND Saldo > 0 "
lcSql = lcSql + " 	AND cc_cli.idCliente = ?pIdCliente "
lcSql = lcSql + " ORDER BY cc_cli.fecEmis ASC"
lcSql = loVtas.AddParameter(lcSql, "pIdCliente", ALLTRIM(STR(Thisform.pgf.page1.sel_Cliente.valcpoid)), .f., .f.)

loVtas.ActiveConnection = goConn.ActiveConnection
loVtas.Cursor_Name = "cur_vta"

IF !loVtas.OpenQuery(lcSql) THEN
	MESSAGEBOX(loVtas.error_message, 0+16, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_vta
IF RECCOUNT("cur_vta") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_vta")
	lcPtoVta = REPLICATE("0", 4 - LEN(ALLTRIM(STR(cur_vta.ptoVta)))) + ALLTRIM(STR(cur_vta.ptoVta))
	lcNumero = REPLICATE("0", 8 - LEN(ALLTRIM(STR(cur_vta.nroCbte)))) + ALLTRIM(STR(cur_vta.nroCbte))
	
	SELECT cur_facturas
	APPEND BLANK
	REPLACE cur_facturas.selected 	WITH .F.
	REPLACE cur_facturas.idVentasC 	WITH cur_vta.idVentasC ADDITIVE
	REPLACE cur_facturas.idCliente	WITH cur_vta.idCliente ADDITIVE
	REPLACE cur_facturas.idCondPago WITH cur_vta.idCondPago ADDITIVE
	REPLACE cur_facturas.idSitIVA 	WITH cur_vta.idSitIVA ADDITIVE
	REPLACE cur_facturas.idVendedor WITH cur_vta.idVendedor ADDITIVE
	REPLACE cur_facturas.razSoc		WITH cur_vta.razSoc ADDITIVE
	REPLACE cur_facturas.fecEmis 	WITH cur_vta.fecEmis ADDITIVE
	REPLACE cur_facturas.cbte 		WITH ALLTRIM(cur_vta.cbte) ADDITIVE
	REPLACE cur_facturas.numCbte1 	WITH lcPtoVta + "-" + lcNumero ADDITIVE
	REPLACE cur_facturas.TipoDoc	WITH cur_vta.tipoDoc ADDITIVE
	REPLACE cur_facturas.PtoVta 	WITH cur_vta.ptoVta ADDITIVE
	REPLACE cur_facturas.numCbte	WITH cur_vta.nroCbte ADDITIVE
	REPLACE cur_facturas.importe 	WITH cur_vta.impdebe ADDITIVE
	REPLACE cur_facturas.saldo 		WITH cur_vta.saldo ADDITIVE

	SELECT cur_vta
	SKIP
ENDDO

loVtas.Close_Query()

SELECT cur_facturas
IF RECCOUNT("cur_facturas") > 0 THEN
	GO TOP
ENDIF

Thisform.pgF.page1.grdCbtes.Refresh()

RETURN .T.
ENDPROC


************************************************************
OBJETO: grdCbtes
************************************************************
*** PROPIEDADES ***
Height = 394
Left = 7
TabIndex = 3
Top = 129
Width = 869
permitir_busqueda = .F.
permitir_ordenamiento = .F.
pos_actual_texto = 0
Name = "grdCbtes"
COLUMN1.Header1.Name = "Header1"
COLUMN1.Text1.ReadOnly = .F.
COLUMN1.Text1.Name = "Text1"
COLUMN1.ControlSource = ""
COLUMN1.CurrentControl = "chkSelected"
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
OBJETO: chkSelected
************************************************************
*** PROPIEDADES ***
Comment = ""
Top = 31
Left = 13
Alignment = 0
Caption = ""
ReadOnly = .F.
Name = "chkSelected"

*** METODOS ***
PROCEDURE InteractiveChange
&& Aca incorporo cuando el usuario selecciona un comprobante

IF this.Value THEN
	SELECT cur_Facturas
	Thisform.Pgf.Page1.contenedor.txtImporteFC.Value = Thisform.Pgf.Page1.contenedor.txtImporteFC.Value + cur_Facturas.saldo
ELSE
	SELECT cur_Facturas
	Thisform.Pgf.Page1.contenedor.txtImporteFC.Value = Thisform.Pgf.Page1.contenedor.txtImporteFC.Value - cur_Facturas.saldo
ENDIF

ENDPROC


************************************************************
OBJETO: Contenedor
************************************************************
*** PROPIEDADES ***
Top = 5
Left = 595
Width = 281
Height = 104
BackStyle = 1
TabIndex = 5
Name = "Contenedor"

*** METODOS ***


************************************************************
OBJETO: labRecibo
************************************************************
*** PROPIEDADES ***
Caption = "Nro. Recibo:"
Left = 9
Top = 13
TabIndex = 7
Name = "labRecibo"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Fecha:"
Left = 10
Top = 36
TabIndex = 8
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Importe Recibido:"
Height = 15
Left = 10
Top = 80
Width = 104
TabIndex = 9
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: txtPtoVta
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 115
MaxLength = 4
TabIndex = 1
Top = 8
Width = 51
autocompleta = .T.
isnumeric = .F.
ischaracter = .T.
isinteger = .F.
Name = "txtPtoVta"

*** METODOS ***


************************************************************
OBJETO: txtNroRec
************************************************************
*** PROPIEDADES ***
Tag = "edit"
Height = 21
Left = 168
MaxLength = 8
TabIndex = 2
Top = 8
Width = 104
ischaracter = .T.
autocompleta = .T.
isnumeric = .F.
isinteger = .F.
Name = "txtNroRec"

*** METODOS ***


************************************************************
OBJETO: txtFecha
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 115
TabIndex = 3
Top = 31
Width = 91
isdatetime = .T.
Name = "txtFecha"

*** METODOS ***


************************************************************
OBJETO: txtImpRecibido
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 115
TabIndex = 4
Top = 77
Width = 91
isnumeric = .T.
Name = "txtImpRecibido"

*** METODOS ***


************************************************************
OBJETO: btnAceptar
************************************************************
*** PROPIEDADES ***
Top = 54
Left = 228
Height = 44
Width = 45
TabIndex = 5
Name = "btnAceptar"

*** METODOS ***
PROCEDURE Click
&& Valido antes de pasar a la siguiente solapa

IF Thisform.pgf.page1.sel_Cliente.txtCodigo.Value = 0 THEN 
	MESSAGEBOX("Debe ingresar el número de cliente",0+48,Thisform.Caption)
	Thisform.pgf.page1.sel_Cliente.SetFocus()
	RETURN .F.
ENDIF 

IF Thisform.pgf.page1.contenedor.txtFecha.Value = {} THEN
	MESSAGEBOX("Debe ingresar la fecha de emisión, se establecerá la fecha actual", 0+48, Thisform.Caption)
	Thisform.pgf.page1.contenedor.txtFecha.Value = DATE()
	Thisform.pgf.page1.contenedor.SetFocus()
	RETURN .F.	
ENDIF

IF !getGlobalCFG("NRC_AUTO") THEN
	&& Valido que se haya ingresado el punto de venta
	IF  ALLTRIM(Thisform.pgf.Page1.contenedor.txtPtoVta.Value) == "" .OR. ALLTRIM(Thisform.pgf.Page1.contenedor.txtPtoVta.Value) == "0000" THEN
		MESSAGEBOX("Debe ingresar el punto de venta correspondiente al número de recibo", 0+48, Thisform.Caption)
		Thisform.pgf.Page1.contenedor.txtPtoVta.SetFocus()
		RETURN .F.
	ENDIF
	&& Valido que se haya ingresado el numero de recibo	
	IF ALLTRIM(Thisform.pgf.Page1.contenedor.txtNroRec.Value) == "" .OR. ALLTRIM(Thisform.pgf.Page1.contenedor.txtNroRec.Value) == "00000000" THEN
		MESSAGEBOX("Debe ingresar el número de recibo", 0+48, Thisform.Caption)
		Thisform.pgf.Page1.contenedor.txtNroRec.SetFocus()
		RETURN .F.
	ENDIF
ENDIF

IF !thisform.recibos.validar_numero(ALLTRIM(Thisform.pgf.Page1.contenedor.txtPtoVta.Value), ALLTRIM(Thisform.pgf.Page1.contenedor.txtNroRec.Value)) THEN 
	RETURN .F.
ENDIF

&& Valido que si se encuentra enviar mail tildado que haya una dirección cargada
IF Thisform.pgf.page1.chkEnviarMail.Value THEN
	IF ALLTRIM(Thisform.pgf.page1.txtEMail.Value) == "" THEN
		MESSAGEBOX("Ingrese una dirección de mail", 0+48, Thisform.Caption)
		Thisform.pgf.page1.txtEMail.SetFocus()
		RETURN .F.
	ENDIF
ENDIF

&& Valido los comprobantes seleccionados
SELECT cur_facturas
IF RECCOUNT("cur_facturas") > 0 THEN
	GO TOP
ENDIF

SELECT	idCliente ;
FROM	cur_facturas ;
WHERE	selected = .T.;
GROUP BY idCliente INTO CURSOR cur_x

SELECT cur_x

IF RECCOUNT("cur_x") = 0 THEN && Valido que se haya seleccionado al menos un comprobante
	MESSAGEBOX("Debe seleccionar al menos un comprobante para aplicar el pago", 0+48, Thisform.Caption)
	USE IN cur_x
	RETURN .F.
ELSE
	Thisform.idcliente = cur_x.idCliente	&& Si el cliente seleccionado es uno solo guardo el numero.
ENDIF

USE IN cur_x

&& Valido que se haya ingresado el importe del recibo
IF thisform.pgf.page1.contenedor.txtImpRecibido.Value = 0 THEN
	MESSAGEBOX("Debe ingresar el importe recibido", 0+48, Thisform.Caption)
	thisform.pgf.page1.contenedor.txtImpRecibido.SetFocus()
	RETURN .F.
ENDIF

*!*	&& Verifico si el importe del recibo es distinto al importe de las FC seleccionadas y muestro un mensaje de advertencia.
*!*	IF This.Parent.txtImpRecibido.Value <> This.Parent.txtImporteFC.Value THEN
*!*		MESSAGEBOX("Hay diferencia entre el importe ingresado y el importe total de las facturas seleccionadas", 0+64, Thisform.Caption)
*!*	ENDIF

Thisform.Pgf.Page2.txtSaldoImputar.Value = Thisform.Pgf.Page1.contenedor.txtImpRecibido.Value
Thisform.Pgf.Page1.sel_Cliente.Enabled = .F.
Thisform.Pgf.Page1.contenedor.txtPtoVta.Enabled = .F.
Thisform.Pgf.Page1.contenedor.txtNroRec.Enabled = .F.
Thisform.Pgf.Page1.contenedor.txtFecha.Enabled = .F.
Thisform.Pgf.Page1.contenedor.txtImporteFC.Enabled = .F.
Thisform.Pgf.Page1.contenedor.txtImpRecibido.Enabled = .F.
Thisform.Pgf.Page1.contenedor.btnAceptar.Enabled = .F.
Thisform.btnGrabar.Enabled = .T.
Thisform.Pgf.Page2.Enabled = .T.
Thisform.Pgf.Page2.SetFocus()
Thisform.Pgf.Page2.contenedor_efvo.txtImpEfvo.SetFocus()

RETURN .T.

ENDPROC


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Importe Facturas:"
Height = 15
Left = 10
Top = 57
Width = 104
TabIndex = 9
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: txtImporteFC
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 115
TabIndex = 4
Top = 54
Width = 91
isnumeric = .T.
Name = "txtImporteFC"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Vendedor:"
Height = 15
Left = 9
Top = 56
Width = 59
TabIndex = 4
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Cond. Pago:"
Height = 15
Left = 9
Top = 33
Width = 67
TabIndex = 4
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: txtcondpago
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 81
Top = 28
Width = 332
Name = "txtcondpago"

*** METODOS ***


************************************************************
OBJETO: txtcodvend
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Left = 81
Top = 51
isnumeric = .F.
isinteger = .T.
Name = "txtcodvend"

*** METODOS ***


************************************************************
OBJETO: txtvendedor
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 185
Top = 51
Width = 374
Name = "txtvendedor"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "E-Mail:"
Height = 15
Left = 10
Top = 77
Width = 59
TabIndex = 4
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: txtEMail
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 81
Top = 74
Width = 478
Name = "txtEMail"

*** METODOS ***


************************************************************
OBJETO: chkEnviarMail
************************************************************
*** PROPIEDADES ***
Top = 100
Left = 277
Height = 18
Width = 92
Alignment = 0
Caption = "Enviar E-Mail"
Name = "chkEnviarMail"

*** METODOS ***


************************************************************
OBJETO: chkImprimir
************************************************************
*** PROPIEDADES ***
Top = 100
Left = 415
Height = 18
Width = 148
Alignment = 0
Caption = "Imprimir comprobante"
Name = "chkImprimir"

*** METODOS ***


************************************************************
OBJETO: contenedor_efvo
************************************************************
*** PROPIEDADES ***
Top = 4
Left = 8
Width = 865
Height = 58
BackStyle = 1
TabIndex = 1
Name = "contenedor_efvo"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Efectivo / Tarjetas"
Height = 15
Left = 7
Top = 4
Width = 131
TabIndex = 9
ForeColor = 0,0,0
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Efectivo:"
Height = 15
Left = 14
Top = 33
Width = 67
TabIndex = 10
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: txtImpEfvo
************************************************************
*** PROPIEDADES ***
Left = 72
TabIndex = 1
Top = 30
isnumeric = .T.
Name = "txtImpEfvo"

*** METODOS ***
PROCEDURE LostFocus
DODEFAULT()

IF this.Value < 0 THEN 
	MESSAGEBOX("No se pueden ingresar valores negativos",0+48,Thisform.Caption)
	This.SetFocus()
	RETURN .F.
ENDIF 

thisform.calc_saldoimputar()

ENDPROC


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Tarjeta de Débito:"
Height = 15
Left = 183
Top = 34
Width = 101
TabIndex = 12
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Tarjeta de Crédito:"
Height = 15
Left = 401
Top = 34
Width = 101
TabIndex = 13
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: txtImpTD
************************************************************
*** PROPIEDADES ***
Left = 293
TabIndex = 2
Top = 31
isnumeric = .T.
Name = "txtImpTD"

*** METODOS ***
PROCEDURE LostFocus
DODEFAULT()

IF this.Value < 0 THEN 
	MESSAGEBOX("No se pueden ingresar valores negativos",0+48,Thisform.Caption)
	This.SetFocus()
	RETURN .F.
ENDIF 

thisform.calc_saldoimputar()

ENDPROC


************************************************************
OBJETO: txtImpTC
************************************************************
*** PROPIEDADES ***
Left = 511
TabIndex = 3
Top = 31
isnumeric = .T.
Name = "txtImpTC"

*** METODOS ***
PROCEDURE LostFocus
DODEFAULT()

IF this.Value < 0 THEN 
	MESSAGEBOX("No se pueden ingresar valores negativos",0+48,Thisform.Caption)
	This.SetFocus()
	RETURN .F.
ENDIF 

thisform.calc_saldoimputar()

ENDPROC


************************************************************
OBJETO: CLSLINEA2
************************************************************
*** PROPIEDADES ***
Height = 1
Left = 7
Top = 20
Width = 842
Name = "CLSLINEA2"

*** METODOS ***


************************************************************
OBJETO: contenedor_cheques
************************************************************
*** PROPIEDADES ***
Top = 65
Left = 8
Width = 864
Height = 331
BackStyle = 1
TabIndex = 3
Name = "contenedor_cheques"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Cheque / Depósito Bancario"
Height = 15
Left = 7
Top = 5
Width = 175
TabIndex = 14
ForeColor = 0,0,0
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Banco:"
Height = 15
Left = 15
Top = 55
Width = 58
TabIndex = 15
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Sucursal:"
Height = 15
Left = 588
Top = 56
Width = 57
TabIndex = 16
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Nro. Cheque:"
Height = 15
Left = 15
Top = 79
Width = 81
TabIndex = 19
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Fecha Emisión:"
Height = 15
Left = 237
Top = 80
Width = 87
TabIndex = 21
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta6
************************************************************
*** PROPIEDADES ***
Caption = "Fecha de Vto.:"
Height = 15
Left = 428
Top = 80
Width = 87
TabIndex = 22
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta7
************************************************************
*** PROPIEDADES ***
Caption = "Importe:"
Height = 15
Left = 619
Top = 79
Width = 50
TabIndex = 23
Name = "Clsetiqueta7"

*** METODOS ***


************************************************************
OBJETO: sel_Banco
************************************************************
*** PROPIEDADES ***
Top = 49
Left = 94
TabIndex = 2
nombre_campo_codigo = codBco
nombre_campo_desc = descripcio
nombre_tabla = bancos
pkfield = idBanco
Name = "sel_Banco"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: txtSucursal
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 645
TabIndex = 3
Top = 51
Width = 215
ischaracter = .T.
Name = "txtSucursal"

*** METODOS ***


************************************************************
OBJETO: txtNroCheque
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 96
MaxLength = 20
TabIndex = 4
Top = 75
Width = 136
ischaracter = .T.
autocompleta = .F.
Name = "txtNroCheque"

*** METODOS ***


************************************************************
OBJETO: txtFecEmis
************************************************************
*** PROPIEDADES ***
Left = 325
TabIndex = 5
Top = 75
isdatetime = .T.
Name = "txtFecEmis"

*** METODOS ***


************************************************************
OBJETO: txtFecVto
************************************************************
*** PROPIEDADES ***
Left = 513
TabIndex = 6
Top = 75
isdatetime = .T.
Name = "txtFecVto"

*** METODOS ***


************************************************************
OBJETO: txtImporte
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 672
TabIndex = 7
Top = 75
Width = 95
isnumeric = .T.
Name = "txtImporte"

*** METODOS ***
PROCEDURE LostFocus
DODEFAULT()

IF this.Value < 0 THEN 
	MESSAGEBOX("No se pueden ingresar valores negativos",0+48,Thisform.Caption)
	This.SetFocus()
	RETURN .F.
ENDIF 

thisform.calc_saldoimputar()

ENDPROC


************************************************************
OBJETO: grdDetalle
************************************************************
*** PROPIEDADES ***
Height = 173
Left = 4
TabIndex = 24
Top = 126
Width = 859
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
OBJETO: btnAgregarCheque
************************************************************
*** PROPIEDADES ***
Top = 77
Left = 771
Height = 44
Width = 45
TabIndex = 11
Name = "btnAgregarCheque"

*** METODOS ***
PROCEDURE Click
&& Este método permite agregar un nuevo item al recibo
LOCAL loPlanCta, lcSql, llEsCheque, lnIdCliente, lnIdBanco, lc_nrocheque

lcSql = ""
loPlanCta = CREATEOBJECT("odbc_result")
lnIdCliente = thisform.pgf.page1.sel_Cliente.valcpoid
lnIdBanco = thisform.pgf.page2.contenedor_cheques.sel_Banco.valcpoid
lc_nrocheque = thisform.pgf.page2.contenedor_cheques.txtNroCheque.Value 

IF This.Parent.opgTipoPago.Option1.Value = 1 THEN
	llEsCheque = .T.
ELSE
	llEsCheque = .F.
ENDIF

&& Valido que se hayan ingresado los datos del cheque
IF This.Parent.sel_Banco.valcpoid = 0 THEN
	MESSAGEBOX("Debe seleccionar el banco", 0+48, Thisform.Caption)
	this.Parent.sel_Banco.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

IF llEsCheque THEN
	IF (This.Parent.txtNroCheque.Value == "") .OR. (This.Parent.txtNroCheque.Value == "00000000") THEN
		MESSAGEBOX("Debe ingresar el número de cheque", 0+48, Thisform.Caption)
		This.Parent.txtNroCheque.SetFocus()
		RETURN .F.
	ENDIF

	IF This.Parent.txtFecEmis.Value = {} THEN
		MESSAGEBOX("Debe ingresar la fecha de emisión", 0+48, Thisform.Caption)
		This.Parent.txtFecEmis.SetFocus()
		RETURN .F.
	ENDIF

	IF This.Parent.txtFecVto.Value = {} THEN
		MESSAGEBOX("Debe ingresar la fecha de vencimiento", 0+48, Thisform.Caption)
		This.Parent.txtFecVto.SetFocus()
		RETURN .F.
	ENDIF
	
	IF !Thisform.recibos.validar_cheques(lnIdCliente, lnIdBanco, lc_nrocheque)
		RETURN .F.
	ENDIF 
ENDIF

IF This.Parent.txtImporte.Value = 0 THEN
	MESSAGEBOX("Debe ingresar el importe", 0+48, Thisform.Caption)
	this.Parent.txtImporte.SetFocus()
	RETURN .F.
ENDIF


SELECT cur_Detalle
APPEND BLANK
REPLACE cur_Detalle.idDetalle WITH 0
REPLACE cur_Detalle.idCheque WITH 0 ADDITIVE
REPLACE cur_Detalle.importe WITH This.Parent.txtImporte.Value ADDITIVE
REPLACE cur_Detalle.idBanco WITH This.Parent.sel_Banco.valcpoid ADDITIVE

IF !llEsCheque THEN
	&& Si el pago es por deposito bancario, entonces, tengo que hacer
	&& que se genere los datos del banco:
	
	REPLACE cur_Detalle.descripcio WITH This.Parent.sel_Banco.txtDescripcion.Value ADDITIVE
	REPLACE cur_Detalle.tipoPago WITH "DEP" ADDITIVE
	REPLACE cur_Detalle.sucursal WITH this.Parent.txtSucursal.Value ADDITIVE 
ELSE
	&& Si es pago con Cheque entonces busco la cuenta cheques en cartera
	&& en el plan de cuenta y lo asigno:
	
	lcSql = "SELECT * FROM planctas WHERE esChqT = 1"
	loPlanCta.Cursor_Name = "cur_PlanCta"
	loPlanCta.ActiveConnection = goConn.ActiveConnection
	loPlanCta.OpenQuery(lcSql)

	REPLACE cur_Detalle.tipoPago WITH "CHEQ" ADDITIVE
	REPLACE cur_Detalle.sucursal WITH this.Parent.txtSucursal.Value ADDITIVE 
	REPLACE cur_Detalle.chq_nro WITH This.Parent.txtNroCheque.Value ADDITIVE
	REPLACE cur_Detalle.idPlanCta WITH cur_PlanCta.idPlanCta ADDITIVE
	REPLACE cur_Detalle.descripcio WITH This.Parent.sel_Banco.txtDescripcion.Value ADDITIVE
	REPLACE cur_Detalle.fecEmis WITH This.Parent.txtFecEmis.Value ADDITIVE
	REPLACE cur_Detalle.fecVto WITH This.Parent.txtFecVto.Value ADDITIVE
	REPLACE cur_Detalle.tipoDoc WITH This.Parent.cmbTipoDoc.Value ADDITIVE
	REPLACE cur_Detalle.nroCuit WITH ALLTRIM(STR(This.Parent.txtNroCUIT.Value, 20, 0)) ADDITIVE
	REPLACE cur_Detalle.titular WITH This.Parent.txtTitular.Value ADDITIVE
	
	loPlanCta.Close_Query()
ENDIF

SELECT cur_Detalle
GO TOP

This.Parent.grdDetalle.Refresh()

This.Parent.txtTotalRec.Value = This.Parent.txtTotalRec.Value + This.Parent.txtImporte.Value

thisform.calc_saldoimputar()

This.Parent.sel_Banco.blanquear()
This.Parent.txtFecEmis.Value = {}
This.Parent.txtFecVto.Value = {}
This.Parent.txtImporte.Value = 0.00
This.Parent.txtSucursal.Value = ""
This.Parent.txtNroCheque.value = ""
This.Parent.cmbTipoDoc.ListIndex = 1
This.Parent.txtNroCUIT.Value = 0
This.Parent.txtTitular.Value = ""
This.Parent.sel_Banco.SetFocus()

RETURN .T.

ENDPROC


************************************************************
OBJETO: opgTipoPago
************************************************************
*** PROPIEDADES ***
BackStyle = 0
BorderStyle = 0
Height = 24
Left = 182
Top = 24
Width = 216
TabIndex = 1
Name = "opgTipoPago"
OPTION1.FontSize = 8
OPTION1.BackStyle = 0
OPTION1.Caption = "Cheque"
OPTION1.Height = 15
OPTION1.Left = 5
OPTION1.TabIndex = 1
OPTION1.Top = 5
OPTION1.Width = 77
OPTION1.ForeColor = 158,106,75
OPTION1.Name = "OPTION1"
OPTION2.FontSize = 8
OPTION2.BackStyle = 0
OPTION2.Caption = "Depósito Bancario"
OPTION2.Height = 15
OPTION2.Left = 89
OPTION2.TabIndex = 2
OPTION2.Top = 5
OPTION2.Width = 127
OPTION2.ForeColor = 158,106,75
OPTION2.Name = "OPTION2"

*** METODOS ***
PROCEDURE OPTION1.Click
IF This.Value = 1 THEN
	Thisform.Pgf.Page2.contenedor_cheques.txtFecEmis.Enabled = .T.
	Thisform.Pgf.Page2.contenedor_cheques.txtFecVto.Enabled = .T.
	Thisform.Pgf.Page2.contenedor_cheques.txtNroCheque.Enabled = .T.
	Thisform.Pgf.Page2.contenedor_cheques.cmbTipoDoc.Enabled = .T.
	Thisform.Pgf.Page2.contenedor_cheques.txtNroCUIT.Enabled = .T.
	Thisform.Pgf.Page2.contenedor_cheques.txtTitular.Enabled = .T.
ENDIF
ENDPROC
PROCEDURE OPTION2.Click
IF This.Value = 1 THEN
	Thisform.Pgf.Page2.contenedor_cheques.txtFecEmis.Enabled = .F.
	Thisform.Pgf.Page2.contenedor_cheques.txtFecVto.Enabled = .F.
	Thisform.Pgf.Page2.contenedor_cheques.txtNroCheque.Enabled = .F.
	Thisform.Pgf.Page2.contenedor_cheques.cmbTipoDoc.Enabled = .F.
	Thisform.Pgf.Page2.contenedor_cheques.txtNroCUIT.Enabled = .F.
	Thisform.Pgf.Page2.contenedor_cheques.txtTitular.Enabled = .F.
ENDIF
ENDPROC


************************************************************
OBJETO: Clsetiqueta9
************************************************************
*** PROPIEDADES ***
Caption = "Seleccione la forma de Pago:"
Height = 15
Left = 14
Top = 29
Width = 172
TabIndex = 12
Name = "Clsetiqueta9"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta10
************************************************************
*** PROPIEDADES ***
Caption = "Total:"
Height = 15
Left = 14
Top = 307
Width = 47
TabIndex = 25
Name = "Clsetiqueta10"

*** METODOS ***


************************************************************
OBJETO: txtTotalRec
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Left = 58
TabIndex = 13
Top = 304
isnumeric = .T.
Name = "txtTotalRec"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta8
************************************************************
*** PROPIEDADES ***
Caption = "Tipo Doc:"
Height = 15
Left = 15
Top = 102
Width = 77
TabIndex = 17
Name = "Clsetiqueta8"

*** METODOS ***


************************************************************
OBJETO: cmbTipoDoc
************************************************************
*** PROPIEDADES ***
ControlSource = ""
Height = 21
Left = 96
TabIndex = 8
Top = 99
Width = 100
Name = "cmbTipoDoc"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta11
************************************************************
*** PROPIEDADES ***
Caption = "Nro:"
Height = 15
Left = 210
Top = 103
Width = 32
TabIndex = 20
Name = "Clsetiqueta11"

*** METODOS ***


************************************************************
OBJETO: txtNroCUIT
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 241
MaxLength = 11
TabIndex = 9
Top = 99
Width = 184
isinteger = .T.
ischaracter = .F.
Name = "txtNroCUIT"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta12
************************************************************
*** PROPIEDADES ***
Caption = "Titular:"
Height = 15
Left = 428
Top = 103
Width = 39
TabIndex = 18
Name = "Clsetiqueta12"

*** METODOS ***


************************************************************
OBJETO: txtTitular
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 473
MaxLength = 60
TabIndex = 10
Top = 99
Width = 294
isinteger = .F.
ischaracter = .T.
Name = "txtTitular"

*** METODOS ***


************************************************************
OBJETO: CLSLINEA2
************************************************************
*** PROPIEDADES ***
Height = 1
Left = 7
Top = 21
Width = 840
Name = "CLSLINEA2"

*** METODOS ***


************************************************************
OBJETO: Clsdelete1
************************************************************
*** PROPIEDADES ***
Top = 77
Left = 817
TabIndex = 12
Name = "Clsdelete1"

*** METODOS ***
PROCEDURE Click
LOCAL lnResp

lnResp = MESSAGEBOX("¿Está seguro que desea eliminar este ítem?", 4+32, Thisform.Caption)

IF lnResp = 6 THEN
	SELECT cur_Detalle
	This.Parent.txtTotalRec.Value = This.Parent.txtTotalRec.Value - cur_detalle.importe

	thisform.calc_saldoimputar()

	SELECT cur_Detalle
	DELETE

	Thisform.pgf.page2.contenedor_cheques.grdDETALLE.Refresh()
	This.Parent.sel_Banco.SetFocus()
ENDIF

ENDPROC


************************************************************
OBJETO: CLSETIQUETA1
************************************************************
*** PROPIEDADES ***
Caption = "Saldo a Imputar:"
Height = 15
Left = 12
Top = 507
Width = 106
TabIndex = 5
Name = "CLSETIQUETA1"

*** METODOS ***


************************************************************
OBJETO: txtSaldoImputar
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 115
TabIndex = 6
Top = 504
Width = 123
isnumeric = .T.
Name = "txtSaldoImputar"

*** METODOS ***


************************************************************
OBJETO: contenedor_Ret
************************************************************
*** PROPIEDADES ***
Top = 400
Left = 8
Width = 864
Height = 101
BackStyle = 1
TabIndex = 4
Name = "contenedor_Ret"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Retenciones"
Height = 15
Left = 7
Top = 4
Width = 131
TabIndex = 9
ForeColor = 0,0,0
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta6
************************************************************
*** PROPIEDADES ***
Caption = "IIBB:"
Height = 15
Left = 15
Top = 31
Width = 27
TabIndex = 11
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta7
************************************************************
*** PROPIEDADES ***
Caption = "IVA:"
Height = 15
Left = 15
Top = 79
Width = 30
TabIndex = 14
Name = "Clsetiqueta7"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta8
************************************************************
*** PROPIEDADES ***
Caption = "Ganancias:"
Height = 15
Left = 435
Top = 31
Width = 67
TabIndex = 15
Name = "Clsetiqueta8"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta9
************************************************************
*** PROPIEDADES ***
Caption = "SUSS:"
Height = 15
Left = 434
Top = 55
Width = 34
TabIndex = 16
Name = "Clsetiqueta9"

*** METODOS ***


************************************************************
OBJETO: txtRetIIBB
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 46
TabIndex = 1
Top = 27
Width = 74
isnumeric = .T.
Name = "txtRetIIBB"

*** METODOS ***
PROCEDURE LostFocus
DODEFAULT()

IF this.Value < 0 THEN 
	MESSAGEBOX("No se pueden ingresar valores negativos",0+48,Thisform.Caption)
	This.SetFocus()
	RETURN .F.
ENDIF 

thisform.calc_saldoimputar()

ENDPROC


************************************************************
OBJETO: txtRetIVA
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 46
TabIndex = 5
Top = 75
Width = 74
isnumeric = .T.
Name = "txtRetIVA"

*** METODOS ***
PROCEDURE LostFocus
DODEFAULT()

IF this.Value < 0 THEN 
	MESSAGEBOX("No se pueden ingresar valores negativos",0+48,Thisform.Caption)
	This.SetFocus()
	RETURN .F.
ENDIF 

thisform.calc_saldoimputar()

ENDPROC


************************************************************
OBJETO: txtRetGan
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 502
TabIndex = 8
Top = 28
Width = 74
isnumeric = .T.
Name = "txtRetGan"

*** METODOS ***
PROCEDURE LostFocus
DODEFAULT()

IF this.Value < 0 THEN 
	MESSAGEBOX("No se pueden ingresar valores negativos",0+48,Thisform.Caption)
	This.SetFocus()
	RETURN .F.
ENDIF 

thisform.calc_saldoimputar()

ENDPROC


************************************************************
OBJETO: txtRetSUSS
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 502
TabIndex = 11
Top = 51
Width = 74
isnumeric = .T.
Name = "txtRetSUSS"

*** METODOS ***
PROCEDURE LostFocus
DODEFAULT()

IF this.Value < 0 THEN 
	MESSAGEBOX("No se pueden ingresar valores negativos",0+48,Thisform.Caption)
	This.SetFocus()
	RETURN .F.
ENDIF 

thisform.calc_saldoimputar()

ENDPROC


************************************************************
OBJETO: CLSLINEA2
************************************************************
*** PROPIEDADES ***
Height = 1
Left = 7
Top = 20
Width = 840
Name = "CLSLINEA2"

*** METODOS ***


************************************************************
OBJETO: txtFecIIBB
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 168
TabIndex = 2
Top = 27
Width = 74
isdatetime = .T.
Name = "txtFecIIBB"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Fecha:"
Height = 15
Left = 127
Top = 31
Width = 37
TabIndex = 11
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: txtCbteIIBB
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 298
TabIndex = 3
Top = 27
Width = 100
isinteger = .T.
Name = "txtCbteIIBB"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "N° Cbte:"
Height = 15
Left = 251
Top = 31
Width = 45
TabIndex = 11
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: txtFecIVA
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 168
TabIndex = 6
Top = 75
Width = 74
isdatetime = .T.
Name = "txtFecIVA"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Fecha:"
Height = 15
Left = 127
Top = 79
Width = 37
TabIndex = 11
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: txtCbteIVA
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 298
TabIndex = 7
Top = 75
Width = 100
isnumeric = .F.
isinteger = .T.
Name = "txtCbteIVA"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "N° Cbte:"
Height = 15
Left = 251
Top = 79
Width = 45
TabIndex = 11
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: txtFecGAN
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 625
TabIndex = 9
Top = 28
Width = 74
isdatetime = .T.
Name = "txtFecGAN"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta10
************************************************************
*** PROPIEDADES ***
Caption = "Fecha:"
Height = 15
Left = 584
Top = 32
Width = 37
TabIndex = 11
Name = "Clsetiqueta10"

*** METODOS ***


************************************************************
OBJETO: txtCbteGAN
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 755
TabIndex = 10
Top = 28
Width = 100
isinteger = .T.
Name = "txtCbteGAN"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta11
************************************************************
*** PROPIEDADES ***
Caption = "N° Cbte:"
Height = 15
Left = 708
Top = 32
Width = 45
TabIndex = 11
Name = "Clsetiqueta11"

*** METODOS ***


************************************************************
OBJETO: txtFecSUSS
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 625
TabIndex = 12
Top = 52
Width = 74
isdatetime = .T.
Name = "txtFecSUSS"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta12
************************************************************
*** PROPIEDADES ***
Caption = "Fecha:"
Height = 15
Left = 584
Top = 56
Width = 37
TabIndex = 11
Name = "Clsetiqueta12"

*** METODOS ***


************************************************************
OBJETO: txtCbteSUSS
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 755
TabIndex = 13
Top = 52
Width = 100
isinteger = .T.
Name = "txtCbteSUSS"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta13
************************************************************
*** PROPIEDADES ***
Caption = "N° Cbte:"
Height = 15
Left = 708
Top = 56
Width = 45
TabIndex = 11
Name = "Clsetiqueta13"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta14
************************************************************
*** PROPIEDADES ***
Caption = "Provincia:"
Height = 15
Left = 25
Top = 54
Width = 60
TabIndex = 11
Name = "Clsetiqueta14"

*** METODOS ***


************************************************************
OBJETO: sel_provincia
************************************************************
*** PROPIEDADES ***
Top = 49
Left = 85
Width = 324
Height = 25
TabIndex = 4
esnumerico = .T.
nombre_campo_codigo = idProvin
nombre_campo_desc = descripcio
nombre_tabla = provincias
pkfield = idProvin
Name = "sel_provincia"
txtCodigo.Height = 21
txtCodigo.Left = 2
txtCodigo.Top = 2
txtCodigo.Width = 44
txtCodigo.Name = "txtCodigo"
txtDescripcion.Height = 21
txtDescripcion.Left = 50
txtDescripcion.Top = 2
txtDescripcion.Width = 263
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: Clscerrar1
************************************************************
*** PROPIEDADES ***
Top = 555
Left = 840
Height = 44
Width = 45
TabIndex = 5
Name = "Clscerrar1"

*** METODOS ***


************************************************************
OBJETO: btnGrabar
************************************************************
*** PROPIEDADES ***
Comment = ""
Top = 555
Left = 794
Height = 44
Width = 45
Enabled = .F.
TabIndex = 4
Name = "btnGrabar"

*** METODOS ***
PROCEDURE Click
LOCAL loDT
LOCAL lnResp
LOCAL loRes
LOCAL lcSql
LOCAL lcImpresora
LOCAL lnCopias
LOCAL llUsaTicket

loDT = CREATEOBJECT("datetime")

IF !Thisform.validar_pago() THEN
	RETURN .F.
ENDIF

goConn.BeginTransaction()


thisform.recibos.cbte = "RC"
thisform.recibos.idconccj = 3 && Aplicacion de comprobante
thisform.recibos.idcliente = thisform.idcliente
thisform.recibos.imp_efec = thisform.Pgf.Page2.contenedor_efvo.txtImpEfvo.Value 
thisform.recibos.imp_td = thisform.Pgf.Page2.contenedor_efvo.txtImpTD.Value 
thisform.recibos.imp_tc = thisform.Pgf.page2.contenedor_efvo.txtImpTC.Value 
thisform.recibos.imp_ib = thisform.Pgf.page2.contenedor_Ret.txtRetIIBB.Value
thisform.recibos.num_ib = thisform.Pgf.page2.contenedor_Ret.txtCbteIIBB.Value 
thisform.recibos.fec_ib = thisform.Pgf.page2.contenedor_Ret.txtFecIIBB.Value 
thisform.recibos.idprovin_ib = thisform.Pgf.page2.contenedor_Ret.sel_provincia.valcpoid
thisform.recibos.imp_iva = thisform.Pgf.page2.contenedor_Ret.txtretIVA.Value 
thisform.recibos.num_iva = thisform.Pgf.page2.contenedor_Ret.txtCbteIVA.Value 
thisform.recibos.fec_iva = thisform.Pgf.page2.contenedor_Ret.txtFecIVA.Value 
thisform.recibos.imp_gan = thisform.Pgf.page2.contenedor_Ret.txtRetGAN.Value
thisform.recibos.num_gan = thisform.Pgf.page2.contenedor_Ret.txtCbteGAN.Value 
thisform.recibos.fec_gan = thisform.Pgf.page2.contenedor_Ret.txtFecGAN.Value  
thisform.recibos.imp_suss = thisform.Pgf.page2.contenedor_Ret.txtRetSUSS.Value 
thisform.recibos.num_suss = thisform.Pgf.page2.contenedor_Ret.txtCbteSUSS.Value 
thisform.recibos.fec_suss = thisform.Pgf.page2.contenedor_Ret.txtFecSUSS.Value 
thisform.recibos.imp_fc = thisform.pgf.page1.contenedor.txtimporteFC.Value
thisform.recibos.imp_rc = thisform.pgf.page1.contenedor.txtimprecibido.Value
thisform.recibos.ptovta = ALLTRIM(Thisform.pgf.page1.contenedor.txtPtoVta.Value)
thisform.recibos.nrocbte = ALLTRIM(Thisform.Pgf.Page1.contenedor.txtNroRec.Value)
thisform.recibos.fec_emis = loDT.toMySql(Thisform.pgf.page1.contenedor.txtFecha.Value)

thisform.recibos.grabar_movcaja = .F.

IF !Thisform.recibos.grabar() THEN 
	RETURN .F.
ENDIF

goConn.Commit()

* Levanto la impresora configurada en recibos
loRes = CREATEOBJECT("odbc_result")
TEXT TO lcSql NOSHOW
	SELECT
		impresoras.impresora,
		impresoras.copias,    
		impresoras.usa_ticket
	FROM
		impresoras
			INNER JOIN numerador ON numerador.idNum = impresoras.idNum
	WHERE
		numerador.ptoVta = ?ptovta AND
		numerador.cbte = ?cbte AND
		impresoras.hostName = ?hostname;
ENDTEXT
lcSql = loRes.AddParameter(lcSql, "ptovta", ALLTRIM(Thisform.recibos.Ptovta), .F., .F.)
lcSql = loRes.AddParameter(lcSql, "cbte", ALLTRIM(Thisform.recibos.Cbte), .T., .F.)
lcSql = loRes.AddParameter(lcSql, "hostname", ALLTRIM(SYS(0)), .T., .F.)
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"
loRes.OpenQuery(lcSql)
lcImpresora = ALLTRIM(cur_x.impresora)
lnCopias = cur_x.copias
llUsaTicket = cur_x.usa_ticket
loRes.Close_Query()

* Mando a imprimir el recibo
IF !llUsaTicket THEN
	* Lo mando a la impresora comun
	thisform.imprimir(lcImpresora, lnCopias)
ELSE
	* Lo mando a la ticketeadora
	IF Thisform.pgf.page1.chkImprimir.value THEN
		thisform.Imprimir_ticket(lcImpresora, lnCopias)
	ENDIF
ENDIF

Thisform.blanquear()
IF Thisform.abrir_fc THEN
	DO FORM "frm_factura_fe"
	Thisform.Release()
ENDIF

RETURN .T.
ENDPROC


************************************************************
OBJETO: btnCancelar
************************************************************
*** PROPIEDADES ***
Top = 555
Left = 3
Height = 44
Width = 45
TabIndex = 6
Name = "btnCancelar"

*** METODOS ***
PROCEDURE Click
Thisform.blanquear()
ENDPROC


************************************************************
OBJETO: recibos
************************************************************
*** PROPIEDADES ***
Top = 564
Left = 60
Height = 17
Width = 24
Name = "recibos"

*** METODOS ***


************************************************************
OBJETO: o_ticket
************************************************************
*** PROPIEDADES ***
Top = 564
Left = 96
Height = 17
Width = 25
Name = "o_ticket"

*** METODOS ***


************************************************************
OBJETO: 
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


