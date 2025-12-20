LOCAL llRes
LOCAL lnPtoVta
LOCAL lnTipoDoc, lcTipoDoc
LOCAL lnRetAlva
LOCAL lnCantIVA
LOCAL lnImpBase21
LOCAL lnImpBase105
LOCAL lcNumero
LOCAL lcMensaje
LOCAL lnImpBaseSIVA
LOCAL lnIndice
LOCAL lnTotalIVA
LOCAL lnModo
LOCAL lcCUIT
LOCAL lcCertif
LOCAL lcLicencia
LOCAL lcPassword
LOCAL loRsCab
LOCAL loRsDet
LOCAL loRsVtaRel
LOCAL lcSql

lnTipoDoc = 0
lcTipoDoc = ""
lnPtoVta = ""
lnRetAlva = 0
lnCantIVA = 0
lnImpBase21 = 0
lnImpBase105 = 0
lnImpBaseSIVA = 0
lcNumero = ""
lcMensaje = ""
lnIndice = 0
lnTotalIVA = 0.00
loRsCab = CREATEOBJECT("odbc_result")
loRsDet = CREATEOBJECT("odbc_result")
loResVtaRel = CREATEOBJECT("odbc_result")

&& Parametros para la conexión con WSFEv1
lnModo = IIF(getGlobalCFG("FEDEBUG"), 0, 1)
lcCUIT = ALLTRIM(getGlobalCFG("FECUIT"))
lcCertif = ALLTRIM(getGlobalCFG("FE_FILE"))
lcLicencia = ALLTRIM(getGlobalCFG("FE_LIC"))
lcPassword = ALLTRIM(getGlobalCFG("FE_PWD"))

&& Acá tengo que levantar el comprobante a actualizar actual
*!*	lcSql = "SELECT *, tipodoc.tipoDoc as tdoc "
*!*	lcSql = lcSql + "FROM ventascab "
*!*	lcSql = lcSql + "	INNER JOIN tipodoc ON tipodoc.idTipoDoc = ventascab.idTipoDoc "
*!*	lcSql = lcSql + "WHERE idVentasC = " + ALLTRIM(STR(cur_CbtePendi.idVentasC))

lcSql = "CALL ventascab_GetById(?idVentasC)"
lcSql = loRsCab.AddParameter(lcSql, "idVentasC", ALLTRIM(STR(cur_CbtePendi.idVentasC)), .f., .f.)
loRsCab.ActiveConnection = goConn.ActiveConnection
loRsCab.Cursor_Name = "cur_cabecera"

IF !loRsCab.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRsCab.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

lnPtoVta = cur_cabecera.ptoVta
lcTipoDoc = cur_cabecera.tipoDoc
Thisform.cbte = cur_cabecera.cbte

&& Tengo que acordarme que en el tercer parámetro tengo que pasar
&& la ruta y el nombre de archivo del certificado.

llRes = Thisform.fe.iniciar(lnModo, lcCUIT, SYS(5) + SYS(2003) + "\wsafip\" + lcCertif, lcLicencia)
Thisform.fe.tls = getGlobalCFG("FETLS")

IF !llRes THEN
	MESSAGEBOX("Falló al iniciar: " + Thisform.fe.ultimoMensajeError, 0+32, Thisform.Caption)
	RETURN .F.
EndIf

&& Verifico si el servicio está en línea
IF !Thisform.fe.dummy() THEN 
	MESSAGEBOX("Los Web Services de AFIP no se encuentran disponibles.",0+16,Thisform.Caption)
	Return .F.
ENDIF 

Thisform.fe.ArchivoCertificadoPassWord = lcPassword
IF !Thisform.ticket_valido() THEN
	MESSAGEBOX("No se pudo generar Ticket de Acceso", 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

Thisform.fe.ArchivoXMLRecibido = SYS(5) + SYS(2003) + "\wsafip\xml\" + ALLTRIM(STR(cur_CbtePendi.idVentasC)) + "_rec_" + ALLTRIM(STR(YEAR(DATETIME()))) + ;
	ALLTRIM(STR(MONTH(DATETIME()))) + ALLTRIM(STR(DAY(DATETIME()))) + ALLTRIM(STR(HOUR(DATETIME()))) + ;
	ALLTRIM(STR(MINUTE(DATETIME()))) + ALLTRIM(STR(SEC(DATETIME()))) + ".xml"
	
Thisform.fe.archivoXMLEnviado = SYS(5) + SYS(2003) + "\wsafip\xml\" + ALLTRIM(STR(cur_CbtePendi.idVentasC)) + "_env_" + ALLTRIM(STR(YEAR(DATETIME()))) + ;
	ALLTRIM(STR(MONTH(DATETIME()))) + ALLTRIM(STR(DAY(DATETIME()))) + ALLTRIM(STR(HOUR(DATETIME()))) + ;
	ALLTRIM(STR(MINUTE(DATETIME()))) + ALLTRIM(STR(SEC(DATETIME()))) + ".xml"
	
Thisform.qr_image = getGlobalCFG("QRPATH") + ALLTRIM(STR(cur_CbtePendi.idVentasC)) + "_" + ALLTRIM(STR(YEAR(DATETIME()))) + ;
	ALLTRIM(STR(MONTH(DATETIME()))) + ALLTRIM(STR(DAY(DATETIME()))) + ALLTRIM(STR(HOUR(DATETIME()))) + ;
	ALLTRIM(STR(MINUTE(DATETIME()))) + ALLTRIM(STR(SEC(DATETIME()))) + ".xml"
	
lnRetAlva = Thisform.fe.f1CompUltimoAutorizado(lnPtoVta, Thisform.fe_get_tipocbte_afip(ALLTRIM(cur_cabecera.tipoDoc)))

Thisform.fe.F1CabeceraCantReg = 1
Thisform.fe.F1CabeceraPtoVta = lnPtoVta
Thisform.fe.F1CabeceraCbteTipo = Thisform.fe_get_tipocbte_afip(ALLTRIM(cur_cabecera.tipoDoc))
Thisform.fe.F1DetalleDocTipo = cur_cabecera.codAfip
Thisform.fe.F1DetalleDocNro = cur_cabecera.nroDoc
Thisform.fe.F1DetalleCbteDesde = lnRetAlva + 1
Thisform.fe.F1DetalleCbteHasta = lnRetAlva + 1

If getGlobalCFG("FE_IVAREC") THEN
	Thisform.fe.F1DetalleCondicionIvaReceptor = cur_cabecera.conivareid
EndIF

Thisform.fe.F1DetalleCbteFch = ALLTRIM(STR(YEAR(DATE()))) ;
	+ IIF(LEN(ALLTRIM(STR(MONTH(DATE())))) < 2, "0" + ALLTRIM(STR(MONTH(DATE()))), ALLTRIM(STR(MONTH(DATE())))) + ;
	IIF(LEN(ALLTRIM(STR(DAY(DATE())))) < 2, "0" + ALLTRIM(STR(DAY(DATE()))), ALLTRIM(STR(DAY(DATE()))))
	
&& Si es una nota de crédito y/o una nota de débito, entonces, tengo que levantar
&& el comprobante asociado.
IF ALLTRIM(cur_cabecera.cbte) == "NC" .OR. ALLTRIM(cur_cabecera.cbte) == "ND" THEN
	lcSql = "CALL ventascab_getCbteRel (?idVentaC)"
	lcSql = loResVtaRel.AddParameter(lcSql, "idVentaC", ALLTRIM(STR(cur_cabecera.idVentasC)), .f., .f.)
	loResVtaRel.Cursor_Name = "cur_vrel"
	loResVtaRel.ActiveConnection = goConn.ActiveConnection
	IF !loResVtaRel.OpenQuery(lcSql) THEN
		MESSAGEBOX(loResVtaRel.Error_Message, 0+48, Thisform.Caption)
		RETURN .F.
	ENDIF
	IF RECCOUNT("cur_vrel") = 0 THEN
		MESSAGEBOX("No hay comprobantes relacionados", 0+48, Thisform.Caption)
		loResVtaRel.Close_Query()
		RETURN .F.
	ELSE
		Thisform.fe.F1DetalleCbtesAsocItemCantidad = 1
		Thisform.fe.F1DetalleCbtesAsocTipo = cur_vrel.aut_tipoCbte
		Thisform.fe.F1DetalleCbtesAsocFecha = ALLTRIM(STR(YEAR(cur_vrel.fecEmision))) ;
			+ IIF(LEN(ALLTRIM(STR(MONTH(cur_vrel.fecEmision)))) < 2, "0" + ALLTRIM(STR(MONTH(cur_vrel.fecEmision))), ALLTRIM(STR(MONTH(cur_vrel.fecEmision)))) ;
			+ IIF(LEN(ALLTRIM(STR(DAY(cur_vrel.fecEmision)))) < 2, "0" + ALLTRIM(STR(DAY(cur_vrel.fecEmision))), ALLTRIM(STR(DAY(cur_vrel.fecEmision))))
		*Thisform.fe.F1DetalleCbtesAsocCUIT = INT(VAL(cur_vrel.nroDoc))
		Thisform.fe.F1DetalleCbtesAsocPtoVta = cur_vrel.ptoVta
		Thisform.fe.F1DetalleCbtesAsocNro = cur_vrel.numCbte
	ENDIF
	
	loResVtaRel.Close_Query()
ENDIF
	
&& Tengo que calcular la suma del neto de los articulos con 21 de IVA y con el 10.5 de IVA
&& por separado.

lcSql = "SELECT * FROM ventasdet "
lcSql = lcSql + "WHERE ventasdet.idVentasC = " + ALLTRIM(STR(cur_cabecera.idVentasC))

loRsDet.ActiveConnection = goConn.ActiveConnection
loRsDet.Cursor_Name = "cur_detalle"

IF !loRsDet.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRsDet.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_detalle
IF RECCOUNT("cur_detalle") <> 0 THEN
	&& Entra por acá en caso de que el comprobante sea normal
	
	* Limpio el objeto Mov_Stock por las dudas que manden a autorizar varios
	* comprobantes sin cerrar la pantalla.
	This.Mov_Stock.limpiar_cursor()
	This.Mov_Stock.Limpiar()
	
	GO TOP
	DO WHILE !EOF("cur_detalle")
		IF cur_detalle.alicIVA = 21 THEN
			lnImpBase21 = lnImpBase21 + cur_detalle.totNeto
		ENDIF
		
		IF cur_detalle.alicIVA = 10.5 THEN
			lnImpBase105 = lnImpBase105 + cur_detalle.totNeto
		ENDIF
		
		IF cur_detalle.alicIVA = 0 THEN
			lnImpBaseSIVA = lnImpBaseSIVA + cur_detalle.totNeto
		ENDIF
		
		* Agrego los artículos en Stock
		IF ALLTRIM(cur_CbtePendi.cbte) == "NC" THEN
			Thisform.mov_stock.tipomov = "ENT"
		ELSE
			Thisform.mov_stock.tipomov = "SAL"
		ENDIF		
		
		This.Mov_Stock.agregar_articulo(cur_detalle.idArticulo, cur_detalle.cantidad, cur_detalle.nroPart)
		
		SELECT cur_detalle
		SKIP
	ENDDO
	
	loRsDet.Close_Query()
	Thisform.cbte_por_cpto = .F.
ELSE
	&& entra por acá en caso de que el comprobante sea por concepto
	loRsDet.Close_Query()
	
	lcSql = "select * from vtadcp where idVentasC = " + ALLTRIM(STR(cur_cabecera.idVentasC))
	loRsDet.ActiveConnection = goConn.ActiveConnection
	loRsDet.Cursor_Name = "cur_detalle"

	IF !loRsDet.OpenQuery(lcSql) THEN
		MESSAGEBOX(loRsDet.Error_Message, 0+48, Thisform.Caption)
		RETURN .F.
	ENDIF
	
	SELECT cur_detalle
	GO TOP
	
	DO WHILE !EOF("cur_detalle")
		IF cur_detalle.ivaPor = 21 THEN
			lnImpBase21 = lnImpBase21 + cur_detalle.impNeto
		ENDIF
		
		IF cur_detalle.ivaPor = 10.5 THEN
			lnImpBase105 = lnImpBase105 + cur_detalle.impNeto
		ENDIF
		
		IF cur_detalle.ivaPor = 0 THEN
			lnImpBaseSIVA = lnImpBaseSIVA + cur_detalle.impNeto
		ENDIF
		
		SELECT cur_detalle
		SKIP
	ENDDO
	
	loRsDet.Close_Query()
	Thisform.cbte_por_cpto = .T.
ENDIF

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
		Thisform.fe.F1DetalleIvaImporte = ROUND(lnImpBase21 * 0.21, 2)
		lnTotalIVA = lnTotalIVA + (ROUND(lnImpBase21 * 0.21, 2))
		lnIndice = lnIndice + 1
	ENDIF

	IF lnImpBase105 <> 0 THEN
		Thisform.fe.F1DetalleIvaItemCantidad = Thisform.fe.F1DetalleIvaItemCantidad + 1
		Thisform.fe.f1IndiceItem = lnIndice
		Thisform.fe.F1DetalleIvaId = 4
		Thisform.fe.F1DetalleIvaBaseImp = ROUND(lnImpBase105, 2)
		Thisform.fe.F1DetalleIvaImporte = ROUND(lnImpBase105 * 0.105, 2)
		lnTotalIVA = lnTotalIVA + (ROUND(lnImpBase105 * 0.105, 2))
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

IF cur_cabecera.porIIBB <> 0 THEN
	Thisform.FE.F1DetalleTributoItemCantidad = 1
	Thisform.FE.f1IndiceItem = 0
	Thisform.FE.F1DetalleTributoId = 2
	Thisform.FE.F1DetalleTributoDesc = "IIBB Pcia Bs AS"
	Thisform.FE.F1DetalleTributoBaseImp = cur_cabecera.impFinal
	Thisform.FE.F1DetalleTributoAlic = cur_cabecera.porIIBB
	Thisform.FE.F1DetalleTributoImporte = cur_cabecera.impIIBB
ENDIF

Thisform.fe.F1DetalleConcepto = 1
Thisform.fe.F1DetalleImpNeto = ROUND(cur_cabecera.impFinal, 2)			&& Total facturado
Thisform.fe.F1DetalleImpTotalConc = ROUND(cur_cabecera.totaNoGrav, 2)	&& Total no gravado
Thisform.fe.F1DetalleImpIva = ROUND(lnTotalIVA, 2)
Thisform.fe.F1DetalleImpOpEx = 0
Thisform.fe.F1DetalleImpTrib = Thisform.FE.F1DetalleTributoImporte
Thisform.fe.F1DetalleMonId = "PES"
Thisform.fe.F1DetalleMonCotiz = 1
Thisform.fe.F1DetalleImpTotal = ROUND(cur_cabecera.totFact, 2)

* Agrego la generación del QR
Thisform.fe.f1DEtalleQrArchivo = Thisform.qr_image
Thisform.fe.f1DEtalleQrFormato = 1
Thisform.fe.f1DetalleQrResolucion = 5
Thisform.fe.f1DetalleQrTolerancia = 0

llRes = Thisform.fe.f1CAESolicitar()

&& llRes = Thisform.fe.registrar(lnPtoVta, Thisform.fe_get_tipocbte_afip(ALLTRIM(lcTipoDoc)), "1") 
loRsCab.Close_Query()

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
		lcMensaje = "ATENCION: Factura rechazada por el AFIP" + CHR(13) + CHR(10)
		lcMensaje = lcMensaje + "FECHA VTO: " + Thisform.fe.F1RespuestaResultado+ CHR(13) + CHR(10)
		lcMensaje = lcMensaje + "MOTIVO: " + Thisform.fe.F1RespuestaDetalleObservacionMsg + CHR(13) + CHR(10)
		MESSAGEBOX(lcMensaje, 0+48, Thisform.Caption)
		RETURN .F.		
	ENDIF
ELSE
	IF !(ISNULL(Thisform.fe.F1RespuestaReProceso) .OR. Thisform.fe.F1RespuestaReProceso == "R") THEN
		lcMensaje = "ATENCION: Falló la solicitud de CAE" + CHR(13) + CHR(10)
		lcMensaje = lcMensaje + "RESULTADO: " + Thisform.fe.F1RespuestaResultado + CHR(13) + CHR(10)
		lcMensaje = lcMensaje + "MOTIVO: " + Thisform.fe.UltimoMensajeError + CHR(13) + CHR(10)
		MESSAGEBOX(lcMensaje, 0+48, Thisform.Caption)
		RETURN .F.
	ELSE
		lcMensaje = "MOTIVO: " + Thisform.fe.F1RespuestaDetalleObservacionMsg + CHR(13) + CHR(10)
		lcMensaje = lcMensaje + "ERROR: " + Thisform.fe.f1ErrorMsg1 + CHR(13) + CHR(10)
		lcMensaje = lcMensaje + "ULTIMO: " + Thisform.fe.UltimoMensajeError
		MESSAGEBOX(lcMensaje, 0+48, Thisform.Caption)
		RETURN .F.
	ENDIF
ENDIF

RETURN .T.
