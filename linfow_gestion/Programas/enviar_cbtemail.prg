PROCEDURE enviar_cbtemail
PARAMETERS ;
		tcReportName,;
		tcCbte		,;
		tcTipoDoc	,;
		tcNroCbte	,;
		tcMailFC	,;
		tdFecha		,;
		tnNroCli	,;
		tcRazSoc	,;
		tcDireccion	,;
		tcCodPostal	,;
		tcLocalidad	,;
		tcPcia		,;
		tcTipoIVA	,;
		tdFecVto	,;
		tcNroCUIT	,;
		tcNroOC		,;
		tcLeyenda	,;
		tnImpNeto	,;
		tnTotal		,;
		tnImpIVA21	,;
		tnImpIVA105	,;
		tnPorIIBB	,;
		tnImpIIBB	,;
		tnTotal		,;
		tcObserv
		
	LOCAL m.tipoDoc
	LOCAL m.NroCbte
	LOCAL m.Fecha
	LOCAL m.nroCli
	LOCAL m.razSoc
	LOCAL m.direccion
	LOCAL m.codPostal
	LOCAL m.localidad
	LOCAL m.pcia
	LOCAL m.tipoIVA
	LOCAL m.fecVto
	LOCAL m.nroCUIT
	LOCAL m.nroOC
	LOCAL m.leyenda
	LOCAL m.impNeto
	LOCAL m.Total
	LOCAL m.impIVA21
	LOCAL m.impIVA105
	LOCAL m.porIIBB
	LOCAL m.impIIBB
	LOCAL m.Total
	LOCAL m.observ
	LOCAL lcNomEmp
	LOCAL lcMailMsg

	lcFileName = getGlobalCFG("FACPDFPATH") + tcCbte + "_" + tcNroCbte + ".pdf"
	m.NroCbte = tcNroCbte
	m.tipoDoc = tcTipoDoc
	m.Fecha = tdFecha
	m.nroCli = tnNroCli
	m.razSoc = tcRazSoc
	m.direccion = tcDireccion
	m.codPostal = tcCodPostal
	m.localidad = tcLocalidad
	m.pcia = tcPcia
	m.tipoIVA = tcTipoIVA
	m.fecVto = tdFecVto
	m.NroCUIT = tcNroCUIT
	m.nroOC = tcNroOC
	m.leyenda = tcLeyenda
	m.impNeto = tnImpNeto
	m.Total = tnTotal
	m.impIVA21 = tnImpIVA21
	m.impIVA105 = tnImpIVA105
	m.porIIBB = tnPorIIBB
	m.impIIBB = tnImpIIBB
	m.Total = tnTotal
	m.observ = tcObserv
	lcNomEmp = getconfig("NOMEMP")
	
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
	SELECT cur_aux
	REPORT FORM &tcReportName NOCONSOLE TO PRINTER
	SET PRINTER TO DEFAULT
	SET CONSOLE ON
	
	DO WHILE !FILE(lcFileName)
		WAIT WINDOW "El archivo PDF se está generando, aguarde unos segundos..." NOWAIT	
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
	[firma]
	
	--
	Mail generado por sistema SISCOM de LINFOW. Para más detalles acceda a www.linfow.com.ar
	
	ENDTEXT
	lcMailMsg = lcMailMsg + lcNomEmp
	lcMailMsg = STRTRAN(lcMailMsg, "[firma]", getGlobalCFG("EMAILFIRMA"))

	&& Procedo a hacer el envío de mail
	DO LOCFILE("FoxyPreviewer.App")
	WITH _screen.oFoxyPreviewer	
		.cEmailType = "PDF"
		.nEmailMode = 2
		.cEMailTo = ALLTRIM(tcMailFC)
		.cEmailCC = ALLTRIM(getGlobalCFG("EMAILCC"))
		.cSMTPServer = getGlobalCFG("EMAILSMTP")
		.cEmailFrom = getGlobalCFG("EMAILEMP") + "<" + getGlobalCFG("EMAILADDR") + ">"
		IF ALLTRIM(tcCbte) == "PTO" THEN
			.cEMailSubject = "Presupuesto " + m.NroCbte
		ELSE
			.cEMailSubject = "Comprobante Electrónico " + tcCbte + " " + m.NroCbte
		ENDIF
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
ENDPROC