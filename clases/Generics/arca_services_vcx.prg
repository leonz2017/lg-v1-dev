************************************************************
OBJETO: cls_arca_service
************************************************************
*** PROPIEDADES ***
id_ventasc = 0
fe = 
error_message = 
aut_numero = 
aut_cae = 
aut_cae_vto = 
aut_resultado = 
aut_motivo = 
arca_message = 
ptovta = 0
nrocbte = 0
cbte = 
mov_stock = 
idcliente = 0
tipodoc = 
aut_qr = 
cbte_por_cpto = .F.
cnt_dias = 0
tipo_cbte_arca = 
aut_tipocbte = 
Name = "cls_arca_service"

*** METODOS ***
PROCEDURE obtener_cae
***************************************************************************
* Este método permite autorizar todos los comprobantes de ventas emitidos
* por el sistema.
* Fecha: 21/01/2026
***************************************************************************
LOCAL llRes, lnPtoVta, lnTipoDoc, lcTipoDoc, lnRetAlva, lnCantIVA
LOCAL lnImpBase21, lnImpBase105, lcNumero, lcMensaje, lnImpBaseSIVA
LOCAL lnIndice, lnTotalIVA, lnModo, lcCUIT, lcCertif, lcLicencia
LOCAL lcPassword, loRsCab, loRsDet, loRsVtaRel, lcSql, llOk


&& Inicializo las variables
STORE 0 TO lnTipoDoc, lnRetAlva, lnCantIVA, lnImpBase21, lnImpBase105,;
	lnImpBaseSIVA, lnIndice, lnPtoVta
	
STORE "" TO lcTipoDoc, lcNumero, lcMensaje, lcSql

lnTotalIVA = 0.00
llOk = .F.
loRsCab = NULL
loRsDet = NULL
loRsVtaRel = NULL

TRY 
	loRsCab = CREATEOBJECT("odbc_result")
	loRsDet = CREATEOBJECT("odbc_result")
	loRsVtaRel = CREATEOBJECT("odbc_result")


	&& Parametros para la conexión con WSFEv1
	lnModo = IIF(getGlobalCFG("FEDEBUG"), 0, 1)
	lcCUIT = ALLTRIM(getGlobalCFG("FECUIT"))
	lcCertif = ALLTRIM(getGlobalCFG("FE_FILE"))
	lcLicencia = ALLTRIM(getGlobalCFG("FE_LIC"))
	lcPassword = ALLTRIM(getGlobalCFG("FE_PWD"))

	lcSql = "CALL ventascab_GetById(?idVentasC)"
	lcSql = loRsCab.AddParameter(lcSql, "idVentasC", ALLTRIM(STR(this.id_ventasc)), .f., .f.)
	loRsCab.ActiveConnection = goConn.ActiveConnection
	loRsCab.Cursor_Name = "cur_arca_cab"

	IF !loRsCab.OpenQuery(lcSql) THEN
		this.error_message = loResCab.Error_Message
		llOk = .F.
		THROW CREATEOBJECT("Exception")
	ENDIF

	lnPtoVta = cur_arca_cab.ptoVta
	lcTipoDoc = cur_arca_cab.tipoDoc
	This.cbte = cur_arca_cab.cbte
	This.cnt_dias = cur_arca_cab.cntDias

	&& Tengo que acordarme que en el tercer parámetro tengo que pasar
	&& la ruta y el nombre de archivo del certificado.

	llRes = This.fe.iniciar(lnModo, lcCUIT, SYS(5) + SYS(2003) + "\wsafip\" + lcCertif, lcLicencia)
	This.fe.tls = getGlobalCFG("FETLS")

	IF !llRes THEN
		This.error_message = "Falló al iniciar: " + This.fe.ultimoMensajeError
		llOk = .F.
		THROW CREATEOBJECT("Exception")
	EndIf

	&& Verifico si el servicio está en línea
	IF !This.fe.dummy() THEN 
		This.error_message = "Los Web Services de AFIP no se encuentran disponibles."
		llOk = .F.
		THROW CREATEOBJECT("Exception")
	ENDIF 

	This.fe.ArchivoCertificadoPassWord = lcPassword
	IF !This.ticket_valido() THEN
		This.error_message = "No se pudo generar Ticket de Acceso"
		llOk = .F.
		THROW CREATEOBJECT("Exception")
	ENDIF

	This.fe.ArchivoXMLRecibido = SYS(5) + SYS(2003) + "\wsafip\xml\" + ALLTRIM(STR(This.id_ventasc)) + "_rec_" + ALLTRIM(STR(YEAR(DATETIME()))) + ;
		ALLTRIM(STR(MONTH(DATETIME()))) + ALLTRIM(STR(DAY(DATETIME()))) + ALLTRIM(STR(HOUR(DATETIME()))) + ;
		ALLTRIM(STR(MINUTE(DATETIME()))) + ALLTRIM(STR(SEC(DATETIME()))) + ".xml"
		
	This.fe.archivoXMLEnviado = SYS(5) + SYS(2003) + "\wsafip\xml\" + ALLTRIM(STR(This.id_ventasc)) + "_env_" + ALLTRIM(STR(YEAR(DATETIME()))) + ;
		ALLTRIM(STR(MONTH(DATETIME()))) + ALLTRIM(STR(DAY(DATETIME()))) + ALLTRIM(STR(HOUR(DATETIME()))) + ;
		ALLTRIM(STR(MINUTE(DATETIME()))) + ALLTRIM(STR(SEC(DATETIME()))) + ".xml"
		
	This.aut_qr = getGlobalCFG("QRPATH") + ALLTRIM(STR(This.id_ventasc)) + "_" + ALLTRIM(STR(YEAR(DATETIME()))) + ;
		ALLTRIM(STR(MONTH(DATETIME()))) + ALLTRIM(STR(DAY(DATETIME()))) + ALLTRIM(STR(HOUR(DATETIME()))) + ;
		ALLTRIM(STR(MINUTE(DATETIME()))) + ALLTRIM(STR(SEC(DATETIME()))) + ".jpg"
		
	This.tipo_cbte_arca = This.fe_get_tipocbte_afip(ALLTRIM(cur_arca_cab.tipoDoc))
		
	lnRetAlva = This.fe.f1CompUltimoAutorizado(lnPtoVta, This.tipo_cbte_arca)

	This.fe.F1CabeceraCantReg = 1
	This.fe.F1CabeceraPtoVta = lnPtoVta
	This.fe.F1CabeceraCbteTipo = This.fe_get_tipocbte_afip(ALLTRIM(cur_arca_cab.tipoDoc))
	This.fe.F1DetalleDocTipo = cur_arca_cab.codAfip
	This.fe.F1DetalleDocNro = cur_arca_cab.nroDoc
	This.fe.F1DetalleCbteDesde = lnRetAlva + 1
	This.fe.F1DetalleCbteHasta = lnRetAlva + 1

	If getGlobalCFG("FE_IVAREC") THEN
		This.fe.F1DetalleCondicionIvaReceptor = cur_arca_cab.conivareid
	EndIF

	This.fe.F1DetalleCbteFch = ALLTRIM(STR(YEAR(DATE()))) ;
		+ IIF(LEN(ALLTRIM(STR(MONTH(DATE())))) < 2, "0" + ALLTRIM(STR(MONTH(DATE()))), ALLTRIM(STR(MONTH(DATE())))) + ;
		IIF(LEN(ALLTRIM(STR(DAY(DATE())))) < 2, "0" + ALLTRIM(STR(DAY(DATE()))), ALLTRIM(STR(DAY(DATE()))))
		
	&& Si es una nota de crédito y/o una nota de débito, entonces, tengo que levantar
	&& el comprobante asociado.
	IF ALLTRIM(cur_arca_cab.cbte) == "NC" .OR. ALLTRIM(cur_arca_cab.cbte) == "ND" THEN
		lcSql = "CALL ventascab_getCbteRel (?idVentaC)"
		lcSql = loRsVtaRel.AddParameter(lcSql, "idVentaC", ALLTRIM(STR(cur_arca_cab.idVentasC)), .f., .f.)
		loRsVtaRel.Cursor_Name = "cur_vrel"
		loRsVtaRel.ActiveConnection = goConn.ActiveConnection
		IF !loRsVtaRel.OpenQuery(lcSql) THEN
			This.error_message = loRsVtaRel.Error_Message
			llOk = .F.
			THROW CREATEOBJECT("Exception")
		ENDIF
		
		IF RECCOUNT("cur_vrel") = 0 THEN
			This.error_message = "No hay comprobantes relacionados"
			llOk = .F.
			THROW CREATEOBJECT("Exception")
		ELSE
			This.fe.F1DetalleCbtesAsocItemCantidad = 1
			This.fe.F1DetalleCbtesAsocTipo = This.tipo_cbte_arca
			This.fe.F1DetalleCbtesAsocFecha = ALLTRIM(STR(YEAR(cur_vrel.fecEmision))) ;
				+ IIF(LEN(ALLTRIM(STR(MONTH(cur_vrel.fecEmision)))) < 2, "0" + ALLTRIM(STR(MONTH(cur_vrel.fecEmision))), ALLTRIM(STR(MONTH(cur_vrel.fecEmision)))) ;
				+ IIF(LEN(ALLTRIM(STR(DAY(cur_vrel.fecEmision)))) < 2, "0" + ALLTRIM(STR(DAY(cur_vrel.fecEmision))), ALLTRIM(STR(DAY(cur_vrel.fecEmision))))
			This.fe.F1DetalleCbtesAsocPtoVta = cur_vrel.ptoVta
			This.fe.F1DetalleCbtesAsocNro = cur_vrel.numCbte
		ENDIF
	ENDIF
		
	&& Tengo que calcular la suma del neto de los articulos con 21 de IVA y con el 10.5 de IVA
	&& por separado.

	TEXT TO lcSql PRETEXT 15 NOSHOW
		SELECT
			ventasdet.*, articulos.codArt
		FROM
			ventasdet
				INNER JOIN articulos ON articulos.idArticulo = ventasdet.idArticulo
		WHERE ventasdet.idVentasC = ?xidVentasC
	ENDTEXT

	lcSql = loRsDet.AddParameter(lcSql, "xidVentasC", ALLTRIM(STR(cur_arca_cab.idVentasC)), .F., .F.)

	loRsDet.ActiveConnection = goConn.ActiveConnection
	loRsDet.Cursor_Name = "cur_det_arca"

	IF !loRsDet.OpenQuery(lcSql) THEN
		This.error_message = loRsDet.Error_Message
		llOk = .F.
		THROW CREATEOBJECT("Exception")
	ENDIF

	SELECT cur_det_arca
	IF RECCOUNT("cur_det_arca") <> 0 THEN
		&& Entra por acá en caso de que el comprobante sea normal
				
		GO TOP
		DO WHILE !EOF("cur_det_arca")
			IF cur_det_arca.alicIVA = 21 THEN
				lnImpBase21 = lnImpBase21 + cur_det_arca.totNeto
			ENDIF
			
			IF cur_det_arca.alicIVA = 10.5 THEN
				lnImpBase105 = lnImpBase105 + cur_det_arca.totNeto
			ENDIF
			
			IF cur_det_arca.alicIVA = 0 THEN
				lnImpBaseSIVA = lnImpBaseSIVA + cur_det_arca.totNeto
			ENDIF
						
			SELECT cur_det_arca
			SKIP
		ENDDO
		
		This.cbte_por_cpto = .F.
	ELSE
		&& entra por acá en caso de que el comprobante sea por concepto
		
		lcSql = "select * from vtadcp where idVentasC = " + ALLTRIM(STR(cur_arca_cab.idVentasC))
		loRsDet.ActiveConnection = goConn.ActiveConnection
		loRsDet.Cursor_Name = "cur_det_arca"

		IF !loRsDet.OpenQuery(lcSql) THEN
			This.error_message = loRsDet.Error_Message
			llOk = .F.
			THROW CREATEOBJECT("Exception")
		ENDIF
		
		SELECT cur_det_arca
		GO TOP
		
		DO WHILE !EOF("cur_det_arca")
			IF cur_det_arca.ivaPor = 21 THEN
				lnImpBase21 = lnImpBase21 + cur_det_arca.impNeto
			ENDIF
			
			IF cur_det_arca.ivaPor = 10.5 THEN
				lnImpBase105 = lnImpBase105 + cur_det_arca.impNeto
			ENDIF
			
			IF cur_det_arca.ivaPor = 0 THEN
				lnImpBaseSIVA = lnImpBaseSIVA + cur_det_arca.impNeto
			ENDIF
			
			SELECT cur_det_arca
			SKIP
		ENDDO
		
		This.cbte_por_cpto = .T.
	ENDIF

	IF This.fe.F1CabeceraCbteTipo <> 11 ;
			.AND. This.fe.F1CabeceraCbteTipo <> 12 ;
			.AND. This.fe.F1CabeceraCbteTipo <> 13 THEN
			
		lnIndice = 0
		lnTotalIVA = 0.00
		IF lnImpBase21 <> 0 THEN
			This.fe.F1DetalleIvaItemCantidad = 1
			This.fe.f1IndiceItem = lnIndice
			This.fe.F1DetalleIvaId = 5
			This.fe.F1DetalleIvaBaseImp = ROUND(lnImpBase21, 2)
			This.fe.F1DetalleIvaImporte = ROUND(lnImpBase21 * 0.21, 2)
			lnTotalIVA = lnTotalIVA + (ROUND(lnImpBase21 * 0.21, 2))
			lnIndice = lnIndice + 1
		ENDIF

		IF lnImpBase105 <> 0 THEN
			This.fe.F1DetalleIvaItemCantidad = This.fe.F1DetalleIvaItemCantidad + 1
			This.fe.f1IndiceItem = lnIndice
			This.fe.F1DetalleIvaId = 4
			This.fe.F1DetalleIvaBaseImp = ROUND(lnImpBase105, 2)
			This.fe.F1DetalleIvaImporte = ROUND(lnImpBase105 * 0.105, 2)
			lnTotalIVA = lnTotalIVA + (ROUND(lnImpBase105 * 0.105, 2))
			lnIndice = lnIndice + 1
		ENDIF

		IF lnImpBaseSIVA <> 0 THEN
			This.fe.F1DetalleIvaItemCantidad = This.fe.F1DetalleIvaItemCantidad + 1
			This.fe.f1IndiceItem = lnIndice
			This.fe.F1DetalleIvaId = 3
			This.fe.F1DetalleIvaBaseImp = ROUND(lnImpBaseSIVA, 2)
		ENDIF
	ENDIF

	&& Agrego los conceptos de IIBB

	IF cur_arca_cab.porIIBB <> 0 THEN
		This.FE.F1DetalleTributoItemCantidad = 1
		This.FE.f1IndiceItem = 0
		This.FE.F1DetalleTributoId = 2
		This.FE.F1DetalleTributoDesc = "IIBB Pcia Bs AS"
		This.FE.F1DetalleTributoBaseImp = cur_arca_cab.impFinal
		This.FE.F1DetalleTributoAlic = cur_arca_cab.porIIBB
		This.FE.F1DetalleTributoImporte = cur_arca_cab.impIIBB
	ENDIF

	This.fe.F1DetalleConcepto = 1
	This.fe.F1DetalleImpNeto = ROUND(cur_arca_cab.impFinal, 2)			&& Total facturado
	This.fe.F1DetalleImpTotalConc = ROUND(cur_arca_cab.totaNoGrav, 2)	&& Total no gravado
	This.fe.F1DetalleImpIva = ROUND(lnTotalIVA, 2)
	This.fe.F1DetalleImpOpEx = 0
	This.fe.F1DetalleImpTrib = This.FE.F1DetalleTributoImporte
	This.fe.F1DetalleMonId = "PES"
	This.fe.F1DetalleMonCotiz = 1
	This.fe.F1DetalleImpTotal = ROUND(cur_arca_cab.totFact, 2)

	* Agrego la generación del QR
	This.fe.f1DEtalleQrArchivo = This.aut_qr
	This.fe.f1DEtalleQrFormato = 1
	This.fe.f1DetalleQrResolucion = 5
	This.fe.f1DetalleQrTolerancia = 0

	llRes = This.fe.f1CAESolicitar()

	IF llRes THEN
		IF ALLTRIM(This.fe.F1RespuestaResultado) == "A" THEN
			lcNumero = REPLICATE("0", 4 - LEN(ALLTRIM(STR(lnPtoVta)))) + ALLTRIM(STR(lnPtoVta)) + "-" + ;
				REPLICATE("0", 8 - LEN(ALLTRIM(STR(This.fe.F1RespuestaDetalleCbteDesde)))) + ALLTRIM(STR(This.fe.F1RespuestaDetalleCbteDesde))
			
			This.ptovta = lnPtoVta
			This.nrocbte = INT(VAL(This.fe.F1RespuestaDetalleCbteDesdeS))
			
			lcMensaje = "CAE: " + This.fe.F1RespuestaDetalleCae + CHR(13)+ CHR(10)
			lcMensaje = lcMensaje + "FECHA VTO: " + This.fe.F1RespuestaDetalleCaeFchVto + CHR(13) + CHR(10)
			lcMensaje = lcMensaje + "MOTIVO: " + This.fe.F1RespuestaDetalleObservacionMsg + CHR(13) + CHR(10)
			lcMensaje = lcMensaje + "RESULTADO: " + This.fe.F1RespuestaResultado + CHR(13) + CHR(10)		
			lcMensaje = lcMensaje + "PROCESO: " + This.fe.F1RespuestaReProceso + CHR(13) + CHR(10)
			lcMensaje = lcMensaje + "El comprobante fué aprobado con éxito"
			
			This.aut_numero = lcNumero
			This.aut_cae = This.fe.F1RespuestaDetalleCae
			This.aut_cae_vto = This.fe.F1RespuestaDetalleCaeFchVto
			This.aut_resultado = This.fe.F1RespuestaResultado
			This.aut_motivo = This.fe.F1RespuestaDetalleObservacionMsg
			This.aut_tipocbte = REPLICATE("0", 2 - LEN(ALLTRIM(STR(This.fe.F1CabeceraCbteTipo)))) + ALLTRIM(STR(This.fe.F1CabeceraCbteTipo))
			This.arca_message = lcMensaje
		ELSE
			lcMensaje = "ATENCION: Factura rechazada por el AFIP" + CHR(13) + CHR(10)
			lcMensaje = lcMensaje + "FECHA VTO: " + This.fe.F1RespuestaResultado+ CHR(13) + CHR(10)
			lcMensaje = lcMensaje + "MOTIVO: " + This.fe.F1RespuestaDetalleObservacionMsg + CHR(13) + CHR(10)
			
			This.arca_message = lcMensaje
			llOk = .F.
			THROW CREATEOBJECT("Exception")		
		ENDIF
	ELSE
		IF !(ISNULL(This.fe.F1RespuestaReProceso) .OR. This.fe.F1RespuestaReProceso == "R") THEN
			lcMensaje = "ATENCION: Falló la solicitud de CAE" + CHR(13) + CHR(10)
			lcMensaje = lcMensaje + "RESULTADO: " + This.fe.F1RespuestaResultado + CHR(13) + CHR(10)
			lcMensaje = lcMensaje + "MOTIVO: " + This.fe.UltimoMensajeError + CHR(13) + CHR(10)
			
			This.arca_message = lcMensaje
			llOk = .F.
			THROW CREATEOBJECT("Exception")
		ELSE
			lcMensaje = "MOTIVO: " + This.fe.F1RespuestaDetalleObservacionMsg + CHR(13) + CHR(10)
			lcMensaje = lcMensaje + "ERROR: " + This.fe.f1ErrorMsg1 + CHR(13) + CHR(10)
			lcMensaje = lcMensaje + "ULTIMO: " + This.fe.UltimoMensajeError
			
			This.arca_message = lcMensaje
			llOk = .F.
			THROW CREATEOBJECT("Exception")
		ENDIF
	ENDIF
	
	llOk = .T.
CATCH TO oException
	This.error_message = getErrorForCatch(oException)
	llOk = .F.
FINALLY
	loRsCab.Close_Query()
	loRsDet.Close_Query()
	loRsVtaRel.Close_Query()
	
	loRsCab = NULL
	loRsDet = NULL
	loRsVtarel = NULL
	
	SYS(1104)
ENDTRY

RETURN llOk

ENDPROC
PROCEDURE fe_get_tipocbte_afip
**************************************************************************
* Permite obtener el tipo de comprobante que se autoriza según el código
* de ARCA.
* Fecha: 21/01/2026
**************************************************************************
PARAMETERS tc_letra

DO CASE
	CASE ALLTRIM(This.cbte) == "FC"
		DO CASE
			CASE ALLTRIM(tc_letra) == "A"
				RETURN 1
			CASE ALLTRIM(tc_letra) == "B"
				RETURN 6
			CASE ALLTRIM(tc_letra) == "C" 
				RETURN 11
		ENDCASE
	CASE ALLTRIM(This.cbte) == "ND"
		DO CASE
			CASE ALLTRIM(tc_letra) == "A"
				RETURN 2
			CASE ALLTRIM(tc_letra) == "B"
				RETURN 7
			CASE ALLTRIM(tc_letra) == "C"
				RETURN 12
		ENDCASE
	CASE ALLTRIM(This.cbte) == "NC"
		DO CASE
			CASE ALLTRIM(tc_letra) == "A"
				RETURN 3
			CASE ALLTRIM(tc_letra) == "B"
				RETURN 8
			CASE ALLTRIM(tc_letra) == "C"
				RETURN 13
		ENDCASE	
ENDCASE

RETURN -1
ENDPROC
PROCEDURE fe_convertir_tipodoc
************************************************************************
* Permite convertir el tipo de documento del cliente según código ARCA
* Fecha: 21/01/2026
************************************************************************
PARAMETERS tcTipoDoc
LOCAL lnResultado

lnResultado = 99 && Código que corresponde a sin identificación en el diccionario

DO CASE
	CASE ALLTRIM(tcTipoDoc) == "CUIT"
		lnResultado = 80
	CASE ALLTRIM(tcTipoDoc) == "CUIL"
		lnResultado = 86
	CASE ALLTRIM(tcTipoDoc) == "CI"
		lnResultado = 87
	CASE ALLTRIM(tcTipoDoc) == "LE"
		lnResultado = 89
	CASE ALLTRIM(tcTipoDoc) == "LC"
		lnResultado = 90
	CASE ALLTRIM(tcTipoDoc) == "CIE"
		lnResultado = 91
	CASE ALLTRIM(tcTipoDoc) == "PAS"
		lnResultado = 94
	CASE ALLTRIM(tcTipoDoc) == "DNI"
		lnResultado = 96
ENDCASE

RETURN lnResultado
ENDPROC
PROCEDURE ticket_valido
******************************************************************************
* Permite verificar si el ticket de acceso actual es válido.
* Fecha: 23/01/2026
******************************************************************************
LOCAL llTkValido
LOCAL lcTicket
LOCAL lcFileTicket
LOCAL lcTK
LOCAL hndFile
LOCAL llModoLocal

llTkValido = .F.
lcTicket = ""
lcTK = ""
lcFileTicket = getGlobalCFG("FE_TICKACC")
llModoLocal = getGlobalCFG("FELOCAL")

IF !llModoLocal THEN
	** Si el ticket se está transfiriendo al cloud server, entonces,
	** Descargo el último ticket que está en el server para validar luego
	** si es válido o no.
	IF DATE() > FDATE(lcFileTicket) THEN
		* Si la fecha del archivo no coincide entonces descargo del FTP
		descargar_ticket_acceso(lcFileTicket)
	ENDIF
ENDIF

IF FILE(ALLTRIM(lcFileTicket)) THEN
	hndFile = FOPEN(lcFileTicket, 12)
	IF hndFile < 0 THEN
		This.error_message = "Error al intentar leer el ticket de acceso"
		=FCLOSE(hndFile)
	ELSE
		=FCLOSE(hndFile)

		lcTK = FILETOSTR(ALLTRIM(lcFileTicket))
		This.fe.f1RestaurarTicketAcceso(lcTK)

		IF This.fe.f1TicketEsValido THEN
			llTkValido = .T.
		ELSE
			llTkValido = .F.
		ENDIF
	ENDIF

	IF !llTkValido THEN
		** Si el ticket de acceso no es válido, elimino el txt actual y lo vuelvo a
		** generar con los nuevos datos.
		DELETE FILE ALLTRIM(lcFileTicket)

		IF This.fe.f1ObtenerTicketAcceso() THEN
			lcTK = This.fe.f1GuardarTicketAcceso()
			hndFile = FCREATE(lcFileTicket)

			IF hndFile < 0 THEN
				This.error_message = "Error al generar el archivo, por favor verifique la ruta se encuentre accesible"
			ELSE
				=FWRITE(hndFile, lcTK)
				llTkValido = .T.
			ENDIF

			=FCLOSE(hndFile)

			IF !llModoLocal THEN
				* Envío el ticket de acceso al FTP
				enviar_ticket_acceso(lcFileTicket)
			ENDIF
		ELSE
			This.error_message = "Fallo de acceso: " + ALLTRIM(This.fe.ultimoMensajeError)
			llTkValido = .F.
		ENDIF
	ENDIF
ELSE
	** Si no existe el archivo entonces lo creo y lo envío al servidor.
	IF This.fe.f1ObtenerTicketAcceso() THEN
		lcTK = This.fe.f1GuardarTicketAcceso()
		hndFile = FCREATE(lcFileTicket)

		IF hndFile < 0 THEN
			This.error_message = "Error al generar el archivo, por favor verifique la ruta se encuentre accesible"
		ELSE
			=FWRITE(hndFile, lcTK)
			llTkValido = .T.
		ENDIF

		=FCLOSE(hndFile)

		IF !llModoLocal THEN
			* Envío el ticket de acceso al FTP
			enviar_ticket_acceso(lcFileTicket)
		ENDIF
	ELSE
		This.error_message = "Fallo de acceso: " + ALLTRIM(This.fe.ultimoMensajeError)
		llTkValido = .F.
	ENDIF
ENDIF

RETURN llTkValido

ENDPROC
PROCEDURE regenerar_qr
*********************************************************************
* Esté método me permitira generar los qr sin ir a buscar la imagen
*********************************************************************
PARAMETERS tnPtoVta, tnTipoCbteAFIP, tcNumCbte

LOCAL llRes, lcNumero, lcMensaje, lnModo, lcRutaQR, lbRetornar

lcNumero = ""
lcMensaje = ""
lbRetornar = .t.
lcRutaQR = ""

lnModo = IIF(getGlobalCFG("FEDEBUG"), 0, 1)
llRes = This.fe.iniciar(lnModo, getGlobalCFG("FECUIT"), SYS(5) + SYS(2003) + "\wsafip\" + getGlobalCFG("FE_FILE"), ALLTRIM(getGlobalCFG("FE_LIC")))		
This.fe.tls = getGlobalCFG("FETLS")

IF !llRes then
	MESSAGEBOX("Falló al inciiar: " + This.fe.ultimoMensajeError, 0+48, This.Caption)
	RETURN .f.
ENDIF

IF !This.fe.dummy() then
	MESSAGEBOX("Los web services de ARCA no se encuentran disponibles.", 0+16, This.Caption)
	RETURN .f.
ENDIF

This.fe.ArchivoCertificadoPassWord = ALLTRIM(getGlobalCFG("FE_PWD"))
IF !This.ticket_valido() then
	MESSAGEBOX("No se pudo generar Ticket de Acceso", 0+48, This.Caption)
	RETURN .f.
ENDIF

This.fe.f1cabeceracantreg = 1
This.fe.f1indice = 0
This.fe.f1indiceitem = 0

This.qr_image = getGlobalCFG("QRPATH") + ALLTRIM(STR(this.id_ventasc)) + "_" + ALLTRIM(STR(YEAR(DATETIME()))) + ;
	ALLTRIM(STR(MONTH(DATETIME()))) + ALLTRIM(STR(DAY(DATETIME()))) + ALLTRIM(STR(HOUR(DATETIME()))) + ;
	ALLTRIM(STR(MINUTE(DATETIME()))) + ALLTRIM(STR(SEC(DATETIME()))) + ".jpg"

CLEAR RESOURCES &This.aut_qr

This.fe.F1DetalleQRArchivo = This.aut_qr
This.fe.f1detalleQRFormato = 6
This.fe.f1detalleqrresolucion = 4
This.fe.f1detalleqrtolerancia = 0
								
This.fe.ArchivoXMLRecibido = SYS(5) + SYS(2003) + "\wsafip\xml\" + ALLTRIM(STR(This.idventascab)) + "_rec_" + ALLTRIM(STR(YEAR(DATETIME()))) + ;
	ALLTRIM(STR(MONTH(DATETIME()))) + ALLTRIM(STR(DAY(DATETIME()))) + ALLTRIM(STR(HOUR(DATETIME()))) + ;
	ALLTRIM(STR(MINUTE(DATETIME()))) + ALLTRIM(STR(SEC(DATETIME()))) + ".xml"

TRY	
	llRes = This.fe.F1CompConsultarS(tnPtoVta, tnTipoCbteAFIP, tcNumCbte)	
	IF llRes THEN		
		lcNumero = REPLICATE("0", 4 - LEN(ALLTRIM(STR(tnPtoVta)))) + ALLTRIM(STR(tnPtoVta)) + "-" + ;			
		REPLICATE("0", 8 - LEN(ALLTRIM(STR(This.fe.F1RespuestaDetalleCbteDesde)))) + ALLTRIM(STR(This.fe.F1RespuestaDetalleCbteDesde))		
	ELSE				
		MESSAGEBOX("Comprobante no autorizado en AFIP. No se puede generar QR",0+16, This.Caption)				
		RETURN .F.	
	ENDIF 
CATCH TO oError	
	MESSAGEBOX("El Web Service de AFIP tardó demasiado en responder, puede estar saturado o fuera de servicio. Vuelva a intentarlo mas tarde.", 0+16, This.Caption)	
	lbRetornar = .F.
ENDTRY 

IF !lbRetornar THEN 	
	RETURN .F.
ENDIF 

RETURN .T.
ENDPROC
PROCEDURE Init
***********************************************************************
* Instancia el objeto fe a partir del OCX de facturación electrónica
***********************************************************************

This.fe = CREATEOBJECT("WSAFIPFEOCX.WSAFIPFEx")

ENDPROC
PROCEDURE Destroy
********************************************************************
* Elimina la instancia OCX de memoria
********************************************************************
IF USED("cur_arca_cab") THEN
	USE IN cur_arca_cab
ENDIF

IF USED("cur_vrel") THEN
	USE IN cur_vrel
ENDIF

IF USED("cur_det_arca") THEN
	USE IN cur_det_arca
ENDIF

This.fe = NULL
ENDPROC


