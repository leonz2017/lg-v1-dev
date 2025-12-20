LOCAL llRes
LOCAL lnPtoVta
LOCAL lnTipoDoc, lcTipoDoc
LOCAL lnRetAlva
LOCAL lnCantIVA
LOCAL lnImpBase21
LOCAL lnImpBase105
LOCAL lcNumero
LOCAL lcMensaje
LOCAL lnModo
LOCAL lnTotalIVA
LOCAL lnImpBaseSIVA
LOCAL lnIndice
LOCAL lcMensaje

lnTipoDoc = 0
lcTipoDoc = ""
lnPtoVta = INT(VAL(getConfig("PTOVTA")))
lnRetAlva = 0
lnCantIVA = 0
lnImpBase21 = 0
lnImpBase105 = 0
lnImpBaseSIVA = 0
lcNumero = ""
lcMensaje = ""
lnTotalIVA = 0.00
lnIndice = 0
Thisform.error_message = ""

lcMensaje = lcMensaje + DTOC(DATETIME()) + " - Iniciando autoriazción" + CHR(13) + CHR(10)
IF !Thisform.verificar_cbte() THEN
	Thisform.error_message = "Por alguna razón el comprobante no se ha grabado."
	RETURN .F.
ENDIF
lcTipoDoc = Thisform.calcular_tipodoc()

&& Tengo que acordarme que en el tercer parámetro tengo que pasar
&& la ruta y el nombre de archivo del certificado.

lnModo = IIF(getGlobalCFG("FEDEBUG"), 0, 1)
llRes = Thisform.fe.iniciar(lnModo, getGlobalCFG("FECUIT"), SYS(5) + SYS(2003) + "\wsafip\" + getGlobalCFG("FE_FILE"), ALLTRIM(getGlobalCFG("FE_LIC")))
Thisform.fe.tls = getGlobalCFG("FETLS")
IF !llRes THEN
	Thisform.error_message = "Falló al iniciar: " + Thisform.fe.ultimoMensajeError
	RETURN .F.
EndIf

&& Verifico si el servicio está en línea
IF !Thisform.fe.dummy() THEN 
	MESSAGEBOX("Los Web Services de AFIP no se encuentran disponibles.",0+16,Thisform.Caption)
	Return .F.
ENDIF 

Thisform.fe.ArchivoCertificadoPassWord = ALLTRIM(getGlobalCFG("FE_PWD"))
IF !Thisform.ticket_valido() THEN
	MESSAGEBOX("No se pudo generar Ticket de Acceso", 0+48, Thisform.Caption)
	Thisform.error_message = "No se pudo crear el ticket de acceso, por favor verifique que la unidad de red "
	Thisform.error_message = Thisform.error_message + "se encuentre accesible."
	RETURN .F.
ENDIF

Thisform.fe.ArchivoXMLRecibido = SYS(5) + SYS(2003) + "\wsafip\xml\" + ALLTRIM(STR(thisform.id_ventasc)) + "_rec_" + ALLTRIM(STR(YEAR(DATETIME()))) + ;
	ALLTRIM(STR(MONTH(DATETIME()))) + ALLTRIM(STR(DAY(DATETIME()))) + ALLTRIM(STR(HOUR(DATETIME()))) + ;
	ALLTRIM(STR(MINUTE(DATETIME()))) + ALLTRIM(STR(SEC(DATETIME()))) + ".xml"
	
Thisform.fe.archivoXMLEnviado = SYS(5) + SYS(2003) + "\wsafip\xml\" + ALLTRIM(STR(thisform.id_ventasc)) + "_env_" + ALLTRIM(STR(YEAR(DATETIME()))) + ;
	ALLTRIM(STR(MONTH(DATETIME()))) + ALLTRIM(STR(DAY(DATETIME()))) + ALLTRIM(STR(HOUR(DATETIME()))) + ;
	ALLTRIM(STR(MINUTE(DATETIME()))) + ALLTRIM(STR(SEC(DATETIME()))) + ".xml"
	
Thisform.qr_image = getGlobalCFG("QRPATH") + ALLTRIM(STR(thisform.id_ventasc)) + "_" + ALLTRIM(STR(YEAR(DATETIME()))) + ;
	ALLTRIM(STR(MONTH(DATETIME()))) + ALLTRIM(STR(DAY(DATETIME()))) + ALLTRIM(STR(HOUR(DATETIME()))) + ;
	ALLTRIM(STR(MINUTE(DATETIME()))) + ALLTRIM(STR(SEC(DATETIME()))) + ".jpg"
	
lnRetAlva = Thisform.fe.f1CompUltimoAutorizado(lnPtoVta, Thisform.fe_get_tipocbte_afip(ALLTRIM(lcTipoDoc)))

* x = Thisform.condicion_iva_receptor_id (Asignar el parámetro cuando habiliten la condición iva receptor
Thisform.fe.F1CabeceraCantReg = 1
Thisform.fe.F1CabeceraPtoVta = lnPtoVta
Thisform.fe.F1CabeceraCbteTipo = Thisform.fe_get_tipocbte_afip(ALLTRIM(lcTipoDoc))
Thisform.codigo_cbte = Thisform.fe.F1CabeceraCbteTipo
Thisform.fe.F1DetalleDocTipo = Thisform.fe_convertir_tipodoc(ALLTRIM(Thisform.cli_tipodoc))
Thisform.fe.F1DetalleDocNro = Thisform.cli_cuit
Thisform.fe.F1DetalleCbteDesde = lnRetAlva + 1
Thisform.fe.F1DetalleCbteHasta = lnRetAlva + 1

** Verifico si está activado el condición iva receptor, si está en true informo el parámetro
If getGlobalCFG("FE_IVAREC") THEN
	Thisform.fe.F1DetalleCondicionIvaReceptor = Thisform.condicion_iva_receptor_id
ENDIF

*Thisform.fe.F1DetalleCbteFch = ALLTRIM(STR(YEAR(DATE()))) + IIF(LEN(ALLTRIM(STR(MONTH(DATE())))) < 2, "0" + ALLTRIM(STR(MONTH(DATE()))), ALLTRIM(STR(MONTH(DATE())))) + ;
	IIF(LEN(ALLTRIM(STR(DAY(DATE())))) < 2, "0" + ALLTRIM(STR(DAY(DATE()))), ALLTRIM(STR(DAY(DATE()))))

Thisform.fe.F1DetalleCbteFch = ALLTRIM(STR(YEAR(Thisform.Contenido.txtFecEmis.Value))) + ;
	IIF(LEN(ALLTRIM(STR(MONTH(Thisform.Contenido.txtFecEmis.Value)))) < 2, "0" + ;
	ALLTRIM(STR(MONTH(Thisform.Contenido.txtFecEmis.Value))), ;
	ALLTRIM(STR(MONTH(Thisform.Contenido.txtFecEmis.Value)))) + ;
	IIF(LEN(ALLTRIM(STR(DAY(Thisform.Contenido.txtFecEmis.Value)))) < 2, "0" + ;
	ALLTRIM(STR(DAY(Thisform.Contenido.txtFecEmis.Value))), ALLTRIM(STR(DAY(Thisform.Contenido.txtFecEmis.Value))))

&& Tengo que calcular la suma del neto de los articulos con 21 de IVA y con el 10.5 de IVA por separado

SELECT cur_aux
GO TOP
DO WHILE !EOF("cur_aux")
	IF cur_aux.alicIVA = 21 THEN
		lnImpBase21 = lnImpBase21 + cur_aux.TotNeto
	ENDIF
	
	IF cur_aux.alicIVA = 10.5 THEN
		lnImpBase105 = lnImpBase105 + cur_aux.TotNeto
	ENDIF
	
	IF cur_aux.alicIVA = 0 THEN
		lnImpBaseSIVA = lnImpBaseSIVA + cur_aux.TotNeto
	ENDIF

	SELECT cur_aux
	SKIP
ENDDO

IF Thisform.fe.F1CabeceraCbteTipo <> 11 ;
		.AND. Thisform.fe.F1CabeceraCbteTipo <> 12 ;
		.AND. Thisform.fe.F1CabeceraCbteTipo <> 13 THEN
	lnIndice = 0
	lnTotalIVA = 0.00
	IF lnImpBase21 <> 0 THEN
		Thisform.fe.F1DetalleIvaItemCantidad = 1
		Thisform.fe.f1IndiceItem = lnIndice
		Thisform.fe.F1DetalleIvaId = 5
		Thisform.fe.F1DetalleIvaBaseImp = ROUND(lnImpBase21, 2)
		Thisform.fe.F1DetalleIvaImporte = cur_subtotal.impIVA21
		lnTotalIVA = lnTotalIVA + cur_subtotal.impIVA21
		lnIndice = lnIndice + 1
	ENDIF

	IF lnImpBase105 <> 0 THEN
		Thisform.fe.F1DetalleIvaItemCantidad = Thisform.fe.F1DetalleIvaItemCantidad + 1
		Thisform.fe.f1IndiceItem = lnIndice
		Thisform.fe.F1DetalleIvaId = 4
		Thisform.fe.F1DetalleIvaBaseImp = ROUND(lnImpBase105, 2)
		Thisform.fe.F1DetalleIvaImporte = cur_subtotal.impIVA105
		lnTotalIVA = lnTotalIVA + cur_subtotal.impIVA105
		lnIndice = lnIndice + 1
	ENDIF

	IF lnImpBaseSIVA <> 0 THEN
		Thisform.fe.F1DetalleIvaItemCantidad = Thisform.fe.F1DetalleIvaItemCantidad + 1
		Thisform.fe.f1IndiceItem = lnIndice
		Thisform.fe.F1DetalleIvaId = 3
		Thisform.fe.F1DetalleIvaBaseImp = ROUND(lnImpBaseSIVA, 2)
	ENDIF
ENDIF

&& Agrego los conceptos de IIBB

IF Thisform.Contenido.txtPorIIBB.Value <> 0 THEN
	Thisform.FE.F1DetalleTributoItemCantidad = 1
	Thisform.FE.f1IndiceItem = 0
	Thisform.FE.F1DetalleTributoId = 2
	Thisform.FE.F1DetalleTributoDesc = "IIBB Pcia Bs AS"
	Thisform.FE.F1DetalleTributoBaseImp = cur_subtotal.impfinal
	Thisform.FE.F1DetalleTributoAlic = cur_subtotal.porIIBB
	Thisform.FE.F1DetalleTributoImporte = cur_subtotal.impIIBB
ENDIF

Thisform.fe.F1DetalleConcepto = 1
Thisform.fe.F1DetalleImpNeto = ROUND(cur_subtotal.impfinal, 2)			&& Importe total del comprobante
Thisform.fe.F1DetalleImpTotalConc = ROUND(cur_subtotal.totaNoGrav, 2)		&& Importe neto no gravado
Thisform.fe.F1DetalleImpIva = ROUND(lnTotalIVA, 2)
Thisform.fe.F1DetalleImpOpEx = 0
Thisform.fe.F1DetalleImpTrib = ROUND(Thisform.FE.F1DetalleTributoImporte, 2)
Thisform.fe.F1DetalleMonId = "PES"
Thisform.fe.F1DetalleMonCotiz = 1
Thisform.fe.F1DetalleImpTotal = ROUND(cur_subtotal.totfact, 2)

* Agrego la generación del QR
Thisform.fe.f1DEtalleQrArchivo = Thisform.qr_image
Thisform.fe.f1DEtalleQrFormato = 1
Thisform.fe.f1DetalleQrResolucion = 5
Thisform.fe.f1DetalleQrTolerancia = 0

llRes = Thisform.fe.f1CAESolicitar()

IF llRes THEN
	IF ALLTRIM(Thisform.fe.F1RespuestaResultado) == "A" THEN
		lcNumero = REPLICATE("0", 4 - LEN(ALLTRIM(STR(lnPtoVta)))) + ALLTRIM(STR(lnPtoVta)) + "-" + ;
			REPLICATE("0", 8 - LEN(ALLTRIM(STR(Thisform.fe.F1RespuestaDetalleCbteDesde)))) + ALLTRIM(STR(Thisform.fe.F1RespuestaDetalleCbteDesde))
		
		Thisform.ptovta = lnPtoVta
		Thisform.nrocbte = INT(VAL(Thisform.fe.F1RespuestaDetalleCbteDesdeS))
		
		lcMensaje = "CAE: " + Thisform.fe.F1RespuestaDetalleCae + CHR(13)+ CHR(10)
		lcMensaje = lcMensaje + "FECHA VTO: " + Thisform.fe.F1RespuestaDetalleCaeFchVto + CHR(13) + CHR(10)
		lcMensaje = lcMensaje + "MOTIVO: " + Thisform.fe.F1RespuestaDetalleObservacionMsg + CHR(13) + CHR(10)
		lcMensaje = lcMensaje + "RESULTADO: " + Thisform.fe.F1RespuestaResultado + CHR(13) + CHR(10)
		lcMensaje = lcMensaje + "PROCESO: " + Thisform.fe.F1RespuestaReProceso + CHR(13) + CHR(10)
		lcMensaje = lcMensaje + "El comprobante fué aprobado con éxito"
		MESSAGEBOX(lcMensaje, 0+64, Thisform.Caption)
		
		Thisform.aut_numero = lcNumero
		Thisform.aut_cae = Thisform.fe.F1RespuestaDetalleCae
		Thisform.aut_cae_vto = Thisform.fe.F1RespuestaDetalleCaeFchVto
		Thisform.aut_resultado = Thisform.fe.F1RespuestaResultado
		Thisform.aut_motivo = Thisform.fe.F1RespuestaDetalleObservacionMsg
	ELSE
		* Pasa por acá si la solicidud fue satisfactoria pero la factura fue
		* rechazada.
		
		lcMensaje = "ATENCION: Factura rechazada por el AFIP" + CHR(13) + CHR(10)
		lcMensaje = lcMensaje + "MOTIVO: " + Thisform.fe.F1RespuestaDetalleObservacionMsg + CHR(13) + CHR(10)		
		Thisform.error_message = lcMensaje
		RETURN .F.
	ENDIF
ELSE
	IF !(ISNULL(Thisform.fe.F1RespuestaReProceso) .OR. Thisform.fe.F1RespuestaResultado == "R") THEN
		lcMensaje = "ATENCION: Falló la solicitud de CAE" + CHR(13) + CHR(10)
		lcMensaje = lcMensaje + "RESULTADO: " + Thisform.fe.F1RespuestaResultado + CHR(13) + CHR(10)
		lcMensaje = lcMensaje + "MOTIVO: " + Thisform.fe.UltimoMensajeError + CHR(13) + CHR(10)
		MESSAGEBOX(lcMensaje, 0+48, Thisform.Caption)
		RETURN .F.
	ELSE
		lcMensaje = "MOTIVO: " + Thisform.fe.F1RespuestaDetalleObservacionMsg + CHR(13) + CHR(10)
		lcMensaje = lcMensaje + "ERROR: " + Thisform.fe.f1ErrorMsg1 + CHR(13) + CHR(10)
		lcMensaje = lcMensaje + "ULTIMO: " + Thisform.fe.UltimoMensajeError
		Thisform.error_message = lcMensaje
		RETURN .F.
	ENDIF
ENDIF

RETURN .T.