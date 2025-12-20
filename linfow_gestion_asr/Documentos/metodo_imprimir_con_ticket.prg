LOCAL m.NroCli, m.RazSoc, m.Telefono, m.direccion, m.localidad, m.codPostal, m.pcia, m.TipoIVA, m.nroCUIT
LOCAL m.Total, m.tipoDoc, m.NroCbte, m.Fecha, m.leyenda, m.fecVto, m.tipoDoc, m.ptoVta
LOCAL m.porDesc1, m.porDesc2, m.porDesc3, m.porDesc4, m.porRec
LOCAL m.impDesc1, m.impDesc2, m.impDesc3, m.impDesc4
LOCAL m.porIIBB, m.impIIBB, m.observ, m.vendedor
LOCAL m.porIVA105, m.impIVA105, m.porIVA21, m.impIVA21, m.impNeto, m.impFinal
LOCAL lcSql, loNumerador, lcPrinterName, lnCantCpia
LOCAL m.cae, m.caevto, lcDia, lcMes, lcAnio
LOCAL m.codigoCbte, m.barcode, m.code, m.condPago, m.qr
LOCAL lnIdNum, lnResp, m.NroRto, m.nroOC
LOCAL loPDF, lcMailMsg
LOCAL lcNomEmp, llUsaTicket, m.motivo, m.totaNoGrav
LOCAL lcRepName
LOCAL m.saldodeudor_total

&& Calculo los saldos para imprimir. Solo lo calculo si la condición de pago
&& no es contado
IF Thisform.contenido.sel_FormaPago.valcpoid <> 1 THEN
	thisform.calcular_saldo_deudor_c1()
	thisform.calcular_saldo_deudor_c2()
ELSE
	thisform.saldodeudor = 0.00
	thisform.saldodeudor_c2 = 0.00
ENDIF

loNumerador = CREATEOBJECT("odbc_result")
lcSql = ""
m.NroCli = Thisform.contenido.sel_Cliente.txtCodigo.Value
m.RazSoc = Thisform.contenido.sel_Cliente.txtDescripcion.Value
m.Telefono = ALLTRIM(Thisform.cli_telefono)
m.direccion = ALLTRIM(Thisform.cli_calle)
m.localidad = ALLTRIM(Thisform.cli_localidad)
m.codPostal = ALLTRIM(Thisform.cli_codPostal)
m.pcia = ALLTRIM(Thisform.cli_Pcia)
m.nroCUIT = ALLTRIM(Thisform.contenido.txtCuit.Value)
m.TipoIVA = Thisform.Contenido.txtSitIVA.Value
m.totaNoGrav = 0.00 && Agrego el no gravado
m.Total = 0.00
m.tipoDoc = ""
m.ptoVta = ""
m.NroCbte = ""
m.leyenda = ""
m.Fecha = Thisform.Contenido.txtFecEmis.Value
m.porIVA105 = 0.00
m.porIVA21 = 0.00
m.impIVA105 = 0.00
m.impIVA21 = 0.00
m.impNeto = 0.00
m.impFinal = 0.00
m.fecVto = Thisform.Contenido.txtFecEmis.Value + thisform.cp_cntdias
m.tipoDoc = Thisform.tipodoc
m.porIIBB = 0.00
m.impIIBB = 0.00
lnCantCpia = 0
m.observ = ""
m.vendedor = thisform.nombre_usuario
m.cae = thisform.aut_cae
m.codigoCbte = REPLICATE("0", 2 - LEN(ALLTRIM(STR(Thisform.codigo_cbte)))) + ALLTRIM(STR(Thisform.codigo_cbte))
m.barcode = ""
m.code = ""
lnIdNum = 0
lnResp = 0
m.NroRto = ""
m.nroOC = Thisform.contenido.txtoc.Value
lcNomEmp = getconfig("NOMEMP")
m.condPago = IIF(This.idCondPago = 1, "CONTADO", "CUENTAS CORRIENTES")
m.qr = Thisform.qr_image
llUsaTicket = .T.
m.saldodeudor_total = thisform.saldodeudor + thisform.saldodeudor_c2

lcAnio = SUBSTR(Thisform.aut_cae_vto, 1, 4)
lcMes = SUBSTR(Thisform.aut_cae_vto, 5, 2)
lcDia = SUBSTR(Thisform.aut_cae_vto, 7, 2)

m.caevto = lcDia + "/" + lcMes + "/" + lcAnio
m.ptovta = INT(VAL(ALLTRIM(getconfig("PTOVTA"))))

&& Levanto el talonario del numerador solo para tomar la configuración de la impresora
lcSql = "select * from numerador where cbte = '" + ALLTRIM(Thisform.cbte) + "' and tipoDoc = '" + ALLTRIM(m.tipoDoc) + "' AND ptoVta = " + ALLTRIM(STR(m.ptoVta))
loNumerador = CREATEOBJECT("odbc_result")
loNumerador.ActiveConnection = goConn.ActiveConnection
loNumerador.Cursor_Name = "cur_num"
loNumerador.OpenQuery(lcSql)

SELECT cur_num
GO TOP
lnIdNum = cur_num.idNum
lcRepName = ALLTRIM(cur_num.repname)

loNumerador.close_query()

&& Levanto la impresora configurada en el puesto de trabajo actual
lcSql = "SELECT * FROM impresoras WHERE hostName = '" + ALLTRIM(SYS(0)) + "' AND "
lcSql = lcSql + "idNum = " + ALLTRIM(STR(lnIdNum))

loNumerador.ActiveConnection = goConn.ActiveConnection
loNumerador.Cursor_Name = "cur_imp"

IF !loNumerador.OpenQuery(lcSql) THEN
	MESSAGEBOX(loNumerador.Error_Message, 0+48, Thisform.Caption)
	RETURN
ENDIF

SELECT cur_imp
IF RECCOUNT("cur_imp") = 0 THEN
	MESSAGEBOX("La impresora no se encuentra configurada en el puesto de trabajo actual", 0+48, Thisform.Caption)
	loNumerador.Close_Query()
	RETURN
ENDIF

lcPrinterName = ALLTRIM(cur_imp.impresora)
lnCantCpia = cur_imp.copias
llUsaTicket = cur_imp.usa_ticket

loNumerador.Close_Query()

&& Lo pongo aca porque tengo que saber si usa o no el ticket
IF Thisform.sitivacli = 6 THEN
	&& Solo extraigo el motivo si es monotributista
	IF !llUsaTicket THEN
		m.motivo = "El crédito fiscal discriminado en el presente comprobante, " ;
			+ "sólo podrá ser computado a efectos del Régimen de Sostenimiento e Inclusión Fiscal para Pequeños Contribuyentes de la Ley Nº 27.618"
	ELSE
		m.motivo =   "El crédito fiscal discriminado en el presente" + CHR(13) + CHR(10) ;
				   + "comprobante, sólo podrá ser computado a " + CHR(13) + CHR(10) ;
				   + "efectos del Régimen de Sostenimiento e " + CHR(13) + CHR(10) ;
				   + "Inclusión Fiscal para Pequeños Contri-" + CHR(13) + CHR(10) ;
				   + "buyentes de la Ley Nº 27.618"
	ENDIF
ELSE
	m.motivo = ""
ENDIF

m.NroCbte = REPLICATE("0", 4 - LEN(ALLTRIM(STR(Thisform.ptovta)))) + ALLTRIM(STR(Thisform.ptovta)) + "-" + REPLICATE("0", 8 - LEN(ALLTRIM(STR(Thisform.nrocbte)))) + ALLTRIM(STR(Thisform.nrocbte))

IF ALLTRIM(Thisform.cbte) == "COT"
	m.leyenda = "COTIZACION"
	m.tipoDoc = "X"
	m.Total = cur_Subtotal.totFact
ELSE 
	IF ALLTRIM(Thisform.cbte) == "PTO"
		m.leyenda = "PRESUPUESTO"
		m.tipoDoc = "X"
		m.Total = cur_Subtotal.impFinal
	ELSE
		IF ALLTRIM(Thisform.cbte) == "PED"
			m.leyenda = "NOTA DE PEDIDO"
			m.tipoDoc = "P"
			m.Total = Thisform.contenido.txtTotFact.Value
		ELSE
			IF ALLTRIM(Thisform.Cbte) == "FC"
				m.leyenda = "FACTURA"
				m.Total = cur_Subtotal.totFact
			ELSE
				IF ALLTRIM(Thisform.Cbte) == "NC"
					m.Leyenda = "NOTA DE CREDITO"
					m.Total = cur_Subtotal.totFact
				ELSE
					IF ALLTRIM(Thisform.Cbte) == "ND"
						m.leyenda = "NOTA DE DEBITO"
						m.Total = cur_Subtotal.totFact
					ENDIF
				ENDIF
			ENDIF
		ENDIF
	ENDIF
ENDIF

IF (ALLTRIM(Thisform.cbte) == "NC") .OR. (ALLTRIM(Thisform.cbte) == "FC") .OR. (ALLTRIM(Thisform.cbte) == "PTO") .OR. (ALLTRIM(Thisform.cbte) == "COT") THEN
	m.porDesc1 = cur_Subtotal.porDesc1 
	m.porDesc2 = cur_Subtotal.porDesc2 
	m.porDesc3 = cur_Subtotal.porDesc3 
	m.porDesc4 = cur_Subtotal.porDesc4 
	m.impDesc1 = cur_Subtotal.impDesc1
	m.impDesc2 = cur_Subtotal.impDesc2
	m.impDesc3 = cur_Subtotal.impDesc3
	m.impDesc4 = cur_Subtotal.impDesc4
	m.porIVA105 = cur_Subtotal.porIVA105
	m.porIVA21 = cur_Subtotal.porIVA21
	m.impIVA105 = cur_Subtotal.impIVA105
	m.impIVA21 = cur_Subtotal.impIVA21
	m.impNeto = cur_Subtotal.impFinal
	m.impFinal = cur_Subtotal.impFinal
	m.porIIBB = cur_Subtotal.porIIBB
	m.impIIBB = cur_Subtotal.impIIBB
	m.porRec = cur_Subtotal.porRec
	
	&& Agrego el no gravado
	m.totaNoGrav = cur_Subtotal.totaNoGrav
	
	SELECT cur_aux
ELSE 
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
	m.porRec = Thisform.contenido.txtPorRec.Value
	
	SELECT cur_detalle
ENDIF 

m.observ = thisform.contenido.txtObserv.Value + ""

&& Generación del código de barra
m.barcode = ALLTRIM(Thisform.cli_cuit)
m.barcode = m.barcode + ALLTRIM(m.codigoCbte)
m.barcode = m.barcode + REPLICATE("0", 4 - LEN(ALLTRIM(STR(m.ptovta)))) + ALLTRIM(STR(m.ptovta))
m.barcode = m.barcode + ALLTRIM(m.cae)
m.barcode = m.barcode + ALLTRIM(lcAnio)
m.barcode = m.barcode + REPLICATE("0", 2 - LEN(ALLTRIM(lcMes))) + ALLTRIM(lcMes)
m.barcode = m.barcode + REPLICATE("0", 2 - LEN(ALLTRIM(lcDia))) + ALLTRIM(lcDia)
m.barcode = m.barcode + ALLTRIM(STR(Thisform.calc_digito_verificador(m.barcode)))
m.code = m.barcode
m.barcode = getcodbarras(m.barcode)

IF thisform.contenido.chkImprimirCbte.Value THEN
	SET PRINTER TO NAME ALLTRIM(lcPrinterName)

	FOR i = 1 TO lnCantCpia 
		IF ALLTRIM(Thisform.tipodoc) == "A" THEN
			&& Imprime el comprobante de tipo "A"
			SELECT cur_aux
			IF llUsaTicket THEN
				****************************************************************************
				* Envío a imprimir el ticket
				****************************************************************************
				Thisform.oticket.limpiar_datos()
				Thisform.oticket.codigo_cbte = m.codigoCbte
				Thisform.oticket.leyenda = m.leyenda
				Thisform.oticket.letra = m.tipoDoc
				Thisform.oticket.nro_cbte = m.nroCbte
				Thisform.oticket.fecha_cbte = m.fecha
				Thisform.oticket.fecha_vencimiento = m.fecVto
				Thisform.oticket.numero_cliente = m.NroCli
				Thisform.oticket.razon_social = m.razSoc
				Thisform.oticket.direccion = m.direccion
				Thisform.oticket.codigo_postal = m.codPostal 
				Thisform.oticket.localidad = m.localidad
				Thisform.oticket.provincia = m.pcia
				Thisform.oticket.tipo_iva = m.TipoIVA
				Thisform.oticket.condicion_pago = m.condPago
				SELECT cur_aux
				GO TOP
				DO WHILE !EOF("cur_aux")
					Thisform.oticket.add_item(cur_aux.codArt, cur_aux.descripcio, cur_aux.cantidad,;
							cur_aux.alicIVA, cur_aux.impNeto, cur_aux.totNeto)
					SELECT cur_aux
					SKIP
				ENDDO
				Thisform.oticket.total_neto = m.impNeto
				Thisform.oticket.total_imp_iva21 = m.impIVA21
				Thisform.oticket.total_imp_iva105 = m.impIVA105
				Thisform.oticket.total = m.Total
				Thisform.oticket.qr_image = Thisform.qr_image
				Thisform.oticket.nro_cae = m.cae
				Thisform.oticket.vto_cae = m.caevto
				Thisform.oticket.motivo = m.motivo
				Thisform.oticket.imprimir()
			ELSE
				REPORT FORM &lcRepName TO PRINTER NOCONSOLE
			ENDIF
		ELSE
			&& Imprime el comprobante de tipo "B"
			SELECT cur_aux
			IF llUsaTicket THEN
				****************************************************************************
				* Envío a imprimir el ticket
				****************************************************************************
				Thisform.oticket.limpiar_datos()
				Thisform.oticket.codigo_cbte = m.codigoCbte
				Thisform.oticket.leyenda = m.leyenda
				Thisform.oticket.letra = m.tipoDoc
				Thisform.oticket.nro_cbte = m.nroCbte
				Thisform.oticket.fecha_cbte = m.fecha
				Thisform.oticket.fecha_vencimiento = m.fecVto
				Thisform.oticket.numero_cliente = m.NroCli
				Thisform.oticket.razon_social = m.razSoc
				Thisform.oticket.direccion = m.direccion
				Thisform.oticket.codigo_postal = m.codPostal 
				Thisform.oticket.localidad = m.localidad
				Thisform.oticket.provincia = m.pcia
				Thisform.oticket.tipo_iva = m.TipoIVA
				Thisform.oticket.condicion_pago = m.condPago
				SELECT cur_aux
				GO TOP
				DO WHILE !EOF("cur_aux")
					Thisform.oticket.add_item(cur_aux.codArt, cur_aux.descripcio, cur_aux.cantidad,;
							cur_aux.alicIVA, cur_aux.impNeto, cur_aux.totNeto)
					SELECT cur_aux
					SKIP
				ENDDO
				Thisform.oticket.total_neto = m.impNeto
				Thisform.oticket.total_imp_iva21 = m.impIVA21
				Thisform.oticket.total_imp_iva105 = m.impIVA105
				Thisform.oticket.total = m.Total
				Thisform.oticket.qr_image = Thisform.qr_image
				Thisform.oticket.nro_cae = m.cae
				THisform.oticket.vto_cae = m.caevto
				Thisform.oticket.motivo = m.motivo
				Thisform.oticket.imprimir()
			ELSE
				REPORT FORM &lcRepName TO PRINTER NOCONSOLE
			ENDIF
		ENDIF
	NEXT
ENDIF

IF thisform.contenido.chkEnviarMail.Value THEN
	Thisform.mailfc = Thisform.Contenido.txtMailFC.Value
	lcFileName = ALLTRIM(GetGlobalCfg("FACPDFPATH")) + ;
		this.cbte + "_" + m.NroCbte + ".pdf"
	
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
	IF ALLTRIM(Thisform.tipodoc) == "A" THEN
		&& Imprime el comprobante de tipo "A"
		SELECT cur_aux
		REPORT FORM &lcRepName NOCONSOLE TO PRINTER
	ELSE
		&& Imprime el comprobante de tipo "B"
		SELECT cur_aux
		REPORT FORM &lcRepName NOCONSOLE TO PRINTER
	ENDIF
	SET PRINTER TO DEFAULT
	SET CONSOLE ON
	
	WAIT WINDOW "El archivo PDF se está generando, aguarde unos segundos..." NOWAIT
	DO WHILE !FILE(lcFileName)
		
	ENDDO
	
	&&MESSAGEBOX("Archivo generado en " + lcFileName, 0+64, thisform.Caption)
	
	TEXT TO lcMailMsg NOSHOW
	Estimado cliente,
	
	Le adjuntamos el comprobante electrónico de su compra en formato PDF.
	Por favor no responder a este mail.
	
	Por favor, no responder a esta dirección de mail.
	
	Muchas gracias!
	--
	Mail generado por LINFOW Gestión.
		
	ENDTEXT
	lcMailMsg = lcMailMsg + getGlobalCFG("EMAILFIRMA") + CHR(13) + CHR(10)
	lcMailMsg = lcMailMsg + getGlobalCFG("EMAILEMP")

	&& Procedo a hacer el envío de mail
	DO LOCFILE("FoxyPreviewer.App")
	WITH _screen.oFoxyPreviewer	
		.cEmailType = "PDF"
		.nEmailMode = 2
		.cEMailTo = thisform.mailfc
		.cEmailCC = ALLTRIM(getGlobalCFG("EMAILCC"))
		.cSMTPServer = getGlobalCFG("EMAILSMTP")
		.cEmailFrom = getGlobalCFG("EMAILEMP") + " <" + getGlobalCFG("EMAILADDR") + ">"
		.cEMailSubject = "Comprobante Electrónico " + this.cbte + " " + m.NroCbte
		.nSMTPPort = getGlobalCFG("EMAILPORT")
		.lSMTPUseSSL = getGlobalCFG("EMAILSSL")
		.cSMTPUserName = getGlobalCFG("EMAILUSR")
		.cSMTPPassword = getGlobalCFG("EMAILPWD")
		.lReadReceipt  = .F.
		.lPriority = .F.
		.cEmailBody = lcMailMsg
		.SendEmailUsingCDO(lcFileName)
	ENDWITH	
ENDIF

DO FoxyPreviewer.App WITH "Release"