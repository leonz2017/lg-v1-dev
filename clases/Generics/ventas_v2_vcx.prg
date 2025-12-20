************************************************************
OBJETO: cls_wsafip
************************************************************
*** PROPIEDADES ***
obj_fe = 
modo_testing = .F.
fe_cuit = 
fe_certificado = 
fe_lic = 
fe_tls = 0
error_message = 
id_ventac = 0
qr_path = 
fe_ticket_acceso = 
modo_local = .F.
fe_password = 
qr_file_image = 
punto_venta = 0
ultimo_numcbte_autorizado = 0
fe_tipocbte = 0
total_iva = 0.00
cliente_nrodoc = 0
imp_neto = 0.00
totanograv = 0.00
total_facturado = 0.00
fecha_emision = {}
response_message = 
cbte = 
tipodoc = 
cliente_tipo_documento = 
aut_numero = 0
aut_cae = 
aut_cae_vto = 
aut_resultado = 
aut_motivo = 
Name = "cls_wsafip"

*** METODOS ***
PROCEDURE iniciar
***************************************************************************
* Este evento se ejecuta al construir el objeto.
* Fecha: 03/12/2022
* Desarrollador: Leonardo D. Zulli
***************************************************************************
LOCAL lnModo
LOCAL llRes
LOCAL loRs
LOCAL lcSql

lnModo = IIF(This.modo_testing, 0, 1)

this.obj_fe = CREATEOBJECT("WSAFIPFEOCX.WSAFIPFEx")

* Inicio el WebService
llRes = This.obj_fe.iniciar(lnModo, This.fe_cuit, ;
	SYS(5) + SYS(2003) + "\wsafip\" + This.fe_certificado, ;
	This.fe_lic)
	
* Establezco la versión de seguridad TLS
This.obj_fe.tls = this.fe_tls

* Verifico el estado de la inicialización
IF !llRes THEN
	This.error_message = "No se pudo iniciar el servicio web de AFIP. " + This.obj_fe.ultimoMensajeError
	RETURN .f.
ENDIF

* Establezco la password de acceso a WebService, valido el ticket y si
* no es válido lo genero.
This.obj_fe.ArchivoCertificadoPassword = ALLTRIM(This.fe_password)
IF !This.generar_ticket_acceso() THEN
	RETURN .f.
ENDIF

* Configuro las rutas de los archivos XML e imagen QR
This.configurar_salidas_archivos_ws()

* Recupero el últmo número de comprobante autorizado.
This.ultimo_numcbte_autorizado = this.obj_fe.f1CompUltimoAutorizado(this.punto_venta, this.fe_tipocbte)

RETURN .t.
ENDPROC
PROCEDURE generar_ticket_acceso
********************************************************************
* Verifica si el ticket de acceso es váldio, si no lo es crea uno
* nuevo.
* Fecha: 04/12/2022
* Desarrollador: Leonardo D. Zulli
********************************************************************

LOCAL llTicketValido
LOCAL lhFile
LOCAL lcTicket

llTicketValido = .F.

* Si el ticket no está en modo local entonces valido fechas y descargo
* desde el cloud server de ser necesario.
IF !This.modo_local THEN
	IF DATE() > FDATE(ALLTRIM(this.fe_ticket_acceso)) THEN
		descargar_ticket_acceso(ALLTRIM(this.fe_ticket_acceso))
	ENDIF
ENDIF

* Verifico si existe el archivo de ticket de acceso.
IF FILE(ALLTRIM(This.fe_ticket_acceso)) THEN
	lhFile = FOPEN(ALLTRIM(This.fe_ticket_acceso), 12)
	IF lhFile < 0 THEN
		This.response_message = "Error al intentar leer el ticket de acceso. " ;
			+ "Verifique que la ruta  esté accesible: " + ALLTRIM(This.fe_ticket_acceso)
		FCLOSE(lhFile)
		
		* Lo corto de una para que no siga haciendo más nada en esta
		* situación.
		RETURN .F.
	ELSE
		FCLOSE(lhFile)
		
		lcTicket = FILETOSTR(ALLTRIM(This.fe_ticket_acceso))
		This.obj_fe.f1RestaurarTicketAcceso(lcTicket)
		llTicketValido = This.obj_fe.f1TicketEsValido		
	ENDIF
ELSE
	* Si no existe el archivo pongo que el ticket no es válido para
	* forzar a que lo genere.
	llTicketValido = .F.
ENDIF

* Si el ticket no es válido elimino el txt actual y lo vuelvo a generar.
IF !llTicketValido THEN
	IF This.obj_fe.f1ObtenerTicketAcceso() THEN
		lcTicket = This.obj_fe.f1GuardarTicketAcceso()
		
		* Grabo el archivo ticket.
		llTicketValido = This.tk_crear_archivo(lcTicket)
	ELSE
		This.response_message = "Error de acceso al Web Service " + ALLTRIM(This.obj_fe.ultimoMensajeError)
		llTicketValido = .F.
	ENDIF
ENDIF

RETURN llTicketValido
ENDPROC
PROCEDURE tk_crear_archivo
****************************************************************
* Permite crear el archivo que contiene el ticket de acceso.
* Parametros:
*	tcTicket: String que contiene el ticket generado por WSAFIP.
* Fecha: 04/12/2022
* Desarrollador: Leonardo D. Zulli
****************************************************************
LPARAMETERS tcTicket

LOCAL lhFile

DELETE FILE ALLTRIM(this.fe_ticket_acceso)

lhFile = FCREATE(ALLTRIM(this.fe_ticket_acceso))
IF lhFile < 0 THEN
	This.response_message = "Error al generar el ticket de acceso, verificar que la ruta se encuentra accesible: " ;
		+ this.fe_ticket_acceso
	RETURN .F.	
ENDIF

FWRITE(lhFile, tcTicket)
FCLOSE(lhFile)

* Si no está trabajando dentro de la LAN entonces lo envío al
* cloud server.
IF !This.modo_local THEN
	enviar_ticket_acceso(ALLTRIM(this.fe_ticket_acceso))
ENDIF

RETURN .T.
ENDPROC
PROCEDURE configurar_salidas_archivos_ws
*****************************************************************
* Configura los parámetros para los nombres de archivos xmls
* de envío y recepción.
* Fecha: 04/12/2022
* Desarrollador: Leonardo D. Zulli
*****************************************************************
LOCAL lcXMLFileEnv
LOCAL lcXMLFileRec

lcXMLFileEnv = SYS(5) + SYS(2003) + "\wsafip\xml\" + ALLTRIM(STR(this.id_ventac)) + "_env_" ;
	+ ALLTRIM(STR(YEAR(DATETIME()))) ;
	+ ALLTRIM(STR(MONTH(DATETIME()))) ;
	+ ALLTRIM(STR(DAY(DATETIME()))) ;
	+ ALLTRIM(STR(HOUR(DATETIME()))) ;
	+ ALLTRIM(STR(MINUTE(DATETIME()))) ;
	+ ALLTRIM(STR(SEC(DATETIME())))

lcXMLFileRec = SYS(5) + SYS(2003) + "\wsafip\xml\" + ALLTRIM(STR(this.id_ventac)) + "_rec_" ;
	+ ALLTRIM(STR(YEAR(DATETIME()))) ;
	+ ALLTRIM(STR(MONTH(DATETIME()))) ;
	+ ALLTRIM(STR(DAY(DATETIME()))) ;
	+ ALLTRIM(STR(HOUR(DATETIME()))) ;
	+ ALLTRIM(STR(MINUTE(DATETIME()))) ;
	+ ALLTRIM(STR(SEC(DATETIME())))
	
this.obj_fe.ArchivoXMLEnviado = lcXMLFileEnv
this.obj_fe.ArchivoXMLRecibido = lcXMLFileRec

* Configuro el path donde se aloja el archivo QR para imprimir en la
* factura.
this.qr_file_image = this.qr_path ;
	+ ALLTRIM(STR(this.id_ventac)) + "-" ;
	+ ALLTRIM(STR(YEAR(DATETIME()))) ;
	+ ALLTRIM(STR(MONTH(DATETIME()))) ;
	+ ALLTRIM(STR(DAY(DATETIME()))) ;
	+ ALLTRIM(STR(HOUR(DATETIME()))) ;
	+ ALLTRIM(STR(MINUTE(DATETIME()))) ;
	+ ALLTRIM(STR(SEC(DATETIME())))

ENDPROC
PROCEDURE get_tipocbte
********************************************************************
* Obtiene el código de AFIP del tipo de comprobante que se va a
* enviar a autorizar.
* Fecha: 09/12/2022
* Desarrollador: Leonardo D. Zulli
********************************************************************

LOCAL loVentasModel

loVentasModel = CREATEOBJECT("cls_ventas_model")
loVentasModel.oActiveConnection = goConn.ActiveConnection
loVentasModel.cbte = this.cbte
loVentasModel.tipoDoc = this.tipodoc
this.fe_tipocbte = loVentasModel.get_tipocbte()
RELEASE loVentasModel


ENDPROC
PROCEDURE get_tipodoc_afip
*************************************************************
* Permite obtener el código según AFIP del tipo de
* documento del cliente al que se le genera el comprobante.
* Fecha: 20/12/2022
* Desarrollado por: Leonardo D. Zulli
*************************************************************

LOCAL loRes
LOCAL lcSql
LOCAL lnTipoDocAfip

loRes = CREATEOBJECT("odbc_result")

TEXT TO lcSql NOSHOW
	SELECT
		CodAfip
	FROM
		tipodoc
	WHERE
		TipoDoc = ?tcTipoDoc
ENDTEXT

lcSql = loRes.AddParameter(lcSql, "tcTipoDoc", ALLTRIM(this.cliente_tipo_documento), .t., .f.)

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"
loRes.OpenQuery(lcSql)
SELECT cur_x
lnTipoDocAfip = cur_x.CodAfip
loRes.Close_Query()


RETURN lnTipoDocAfip
ENDPROC
PROCEDURE set_totales_ivas
******************************************************************************
* Permite calcular los totales del comprobante actual que se enviarán como
* parámetro a autorizar.
* Fecha: 26/12/2022
* Autor: Leonardo D. Zulli
******************************************************************************
LOCAL loVentas

loVentas = CREATEOBJECT("cls_ventas_model")
loVentas.oActiveConnection = goConn.ActiveConnection
loVentas.idventasc = this.id_ventac
loVentas.crear_cursores_wsafip()
loVentas.calcular_totales_ivas_afip()

* Para incluir el IVA verifico que no sean comprobantes del
* tipo C.
IF this.obj_fe.F1CabeceraCbteTipo <> 11 .AND. ;
	this.obj_fe.F1CabeceraCbteTipo <> 12 .AND. ;
	this.obj_fe.F1CabeceraCbteTipo <> 13 THEN
	
	this.total_iva = 0.00
	SELECT cur_afpivas
	GO TOP
	DO WHILE !EOF("cur_afpivas")
		* Asignar parametros IVA.
		this.obj_fe.F1DetalleIvaItemCantidad = cur_afpivas.item_cant
		this.obj_fe.F1IndiceItem = cur_afpivas.indice_item
		this.obj_fe.F1DetalleIvaId = cur_afpivas.iva_id
		this.obj_fe.F1DetalleIvaBaseImp = cur_afpivas.imp_base
		this.obj_fe.F1DetalleIvaImporte = cur_afpivas.imp_iva
		
		this.total_iva = this.total_iva	+ cur_afpivas.imp_iva
		SELECT cur_afpivas
		SKIP
	ENDDO
ENDIF

* Seteo el parámetro del total de importe de IVA.
this.obj_fe.F1DetalleImpIva = ROUND(this.total_iva, 2)

* Cierro el cursor.
USE IN cur_afpivas

ENDPROC
PROCEDURE set_totales
***********************************************************************
* Permite setear los totales del comprobante.
* Fecha: 04/01/2023
* Desarrollado por: Leonardo D. Zulli
***********************************************************************
this.obj_fe.F1DetalleConcepto = 1
this.obj_fe.F1DetalleImpNeto = ROUND(this.imp_neto, 2)
this.obj_fe.F1DetalleImpTotalConc = ROUND(this.totanograv, 2)
this.obj_fe.F1DetalleImpIva = ROUND(this.total_iva, 2)
this.obj_fe.F1DetalleImpOpEx = 0
this.obj_fe.F1DetalleImpTrib = ROUND(this.obj_fe.F1DetalleTributoImporte, 2)
this.obj_fe.F1DetalleMonId = "PES"
this.obj_fe.F1DetalleMonCotiz = 1
this.obj_fe.F1DetalleImpTotal = ROUND(this.total_facturado, 2)


ENDPROC
PROCEDURE set_qr
*************************************************************************
* Establece la configuración para generar el archivo QR.
* Fecha: 04/01/2023
* Desarrollador: Leonardo D. Zulli
*************************************************************************

this.qr_file_image = ALLTRIM(STR(this.id_ventac)) + ".jpg"
this.obj_fe.F1DetalleQrArchivo = this.qr_path + this.qr_file_image
this.obj_fe.F1DetalleQrFormato = 1
this.obj_fe.F1DetalleQrResolucion = 5
this.obj_fe.F1DetalleQrTolerancia = 0


ENDPROC
PROCEDURE get_datos_cabecera
*****************************************************************************************
* Obtiene los datos de cabecera del comprobante que se está autorizando.
* Fecha: 04/03/2022
* Desarrollador: Leonardo D. Zulli
*****************************************************************************************

loRs = CREATEOBJECT("odbc_result")

TEXT TO lcSql NOSHOW
	SELECT
		ventascab.cbte,
		ventascab.tipoDoc,
		ventascab.ptoVta,
		tipodoc.TipoDoc AS 'cliTipoDoc',
		ventascab.nroDoc,
		ventascab.fecEmision,
		ROUND(ventascab.impFinal, 2) AS 'impNeto',
		ROUND(ventascab.totaNoGrav, 2) AS 'totaNoGrav',
		ROUND(ventascab.impIVA21 + ventascab.impIVA105, 2) AS 'total_iva',
		ROUND(ventascab.totFact, 2) AS 'totFact'
	FROM
		ventascab
			INNER JOIN tipodoc ON tipodoc.idTipoDoc = ventascab.idTipoDoc
	WHERE
		ventascab.idVentasC = ?xid
ENDTEXT

lcSql = loRs.AddParameter(lcSql, "xid", ALLTRIM(STR(this.id_ventac)), .f., .f.)
loRs.ActiveConnection = goConn.ActiveConnection
loRs.cursor_name = "cur_x"
loRs.OpenQuery(lcSql)

SELECT cur_x
this.cbte = cur_x.cbte
this.tipodoc = cur_x.tipoDoc
this.punto_venta = cur_x.ptoVta
this.cliente_tipo_documento = cur_x.cliTipoDoc
this.cliente_nrodoc = INT(VAL(cur_x.nroDoc))
this.imp_neto = cur_x.impNeto
this.totanograv = cur_x.totaNoGrav
this.total_iva = cur_x.total_iva
this.total_facturado = cur_x.totFact
this.fecha_emision = cur_x.fecEmision

loRs.Close_Query()
ENDPROC
PROCEDURE autorizar_comprobante
*********************************************************************
* Permite enviar a autorizar el comprobante.
* Fecha: 04/03/2022
* Desarrollador: Leonardo D. Zulli
*********************************************************************
this.get_datos_cabecera()
this.get_tipocbte()

IF !this.iniciar() THEN
	RETURN .F.
ENDIF 

this.obj_fe.F1CabeceraCantReg = 1
this.obj_fe.F1CabeceraPtoVta = this.punto_venta
this.obj_fe.F1CabeceraCbteTipo = this.fe_tipocbte
this.obj_fe.F1DetalleDocTipo = this.get_tipodoc_afip()
this.obj_fe.F1DetalleDocNro = this.cliente_nrodoc
this.obj_fe.F1DetalleCbteDesde = this.ultimo_numcbte_autorizado + 1
this.obj_fe.F1DetalleCbteHasta = this.ultimo_numcbte_autorizado + 1

* Fecha de emisión
this.obj_fe.F1DetalleCbteFch = ALLTRIM(STR(YEAR(this.fecha_emision))) + ;
	IIF(LEN(ALLTRIM(STR(MONTH(this.fecha_emision)))) < 2, "0" + ;
	ALLTRIM(STR(MONTH(this.fecha_emision))), ;
	ALLTRIM(STR(MONTH(this.fecha_emision)))) + ;
	IIF(LEN(ALLTRIM(STR(DAY(this.fecha_emision)))) < 2, "0" + ;
	ALLTRIM(STR(DAY(this.fecha_emision))), ALLTRIM(STR(DAY(this.fecha_emision))))
	
this.set_totales_ivas()
this.set_totales()
this.set_qr()

RETURN this.get_response()
ENDPROC
PROCEDURE get_response
*********************************************************
* Permite obtener la respuesta del WebService
* Fecha: 04/01/2023
* Desarrollador: Leonardo D. Zulli
*********************************************************
LOCAL llRes

llRes = this.obj_fe.f1CAESolicitar()

IF llRes THEN
	IF ALLTRIM(This.obj_fe.F1RespuestaResultado) == "A" THEN
		lcNumero = REPLICATE("0", 4 - LEN(ALLTRIM(STR(this.punto_venta)))) + ALLTRIM(STR(this.punto_venta)) + "-" + ;
			REPLICATE("0", 8 - LEN(ALLTRIM(STR(This.obj_fe.F1RespuestaDetalleCbteDesde)))) + ALLTRIM(STR(This.obj_fe.F1RespuestaDetalleCbteDesde))
		
		This.aut_numero = INT(VAL(This.obj_fe.F1RespuestaDetalleCbteDesdeS))
		
		this.response_message = "CAE: " + This.obj_fe.F1RespuestaDetalleCae + CHR(13)+ CHR(10)
		this.response_message = this.response_message + "FECHA VTO: " + This.obj_fe.F1RespuestaDetalleCaeFchVto + CHR(13) + CHR(10)
		this.response_message = this.response_message + "MOTIVO: " + This.obj_fe.F1RespuestaDetalleObservacionMsg + CHR(13) + CHR(10)
		this.response_message = this.response_message + "RESULTADO: " + This.obj_fe.F1RespuestaResultado + CHR(13) + CHR(10)
		this.response_message = this.response_message + "PROCESO: " + This.obj_fe.F1RespuestaReProceso + CHR(13) + CHR(10)
		this.response_message = this.response_message + "El comprobante fué aprobado con éxito"
		
		This.aut_cae = This.obj_fe.F1RespuestaDetalleCae
		This.aut_cae_vto = This.obj_fe.F1RespuestaDetalleCaeFchVto
		This.aut_resultado = This.obj_fe.F1RespuestaResultado
		This.aut_motivo = This.obj_fe.F1RespuestaDetalleObservacionMsg
	ELSE
		* Pasa por acá si la solicidud fue satisfactoria pero la factura fue
		* rechazada.
		
		this.response_message = "ATENCION: Factura rechazada por el AFIP" + CHR(13) + CHR(10)
		this.response_message = this.response_message + "MOTIVO: " + This.obj_fe.F1RespuestaDetalleObservacionMsg + CHR(13) + CHR(10)		
		RETURN .F.
	ENDIF
ELSE
	IF !(ISNULL(This.obj_fe.F1RespuestaReProceso) .OR. This.obj_fe.F1RespuestaResultado == "R") THEN
		this.response_message = "ATENCION: Falló la solicitud de CAE" + CHR(13) + CHR(10)
		this.response_message = this.response_message + "RESULTADO: " + This.obj_fe.F1RespuestaResultado + CHR(13) + CHR(10)
		this.response_message = this.response_message + "MOTIVO: " + This.obj_fe.UltimoMensajeError + CHR(13) + CHR(10)
		RETURN .F.
	ELSE
		this.response_message = "MOTIVO: " + This.obj_fe.F1RespuestaDetalleObservacionMsg + CHR(13) + CHR(10)
		this.response_message = this.response_message + "ERROR: " + This.obj_fe.f1ErrorMsg1 + CHR(13) + CHR(10)
		this.response_message = this.response_message + "ULTIMO: " + This.obj_fe.UltimoMensajeError
		RETURN .F.
	ENDIF
ENDIF

RETURN .T.
ENDPROC
PROCEDURE Init
*******************************************************
* Inicializo las propiedades de facturación electrónica
* a partir de los parámetros de global_cfg.
*******************************************************

this.modo_testing = getGlobalCFG("FEDEBUG")
this.fe_cuit = ALLTRIM(getGlobalCFG("FECUIT"))
this.fe_certificado = ALLTRIM(getGlobalCFG("FE_FILE"))
this.fe_lic = ALLTRIM(getGlobalCFG("FE_LIC"))
this.fe_tls = getGlobalCFG("FETLS")
this.fe_password = ALLTRIM(getGlobalCFG("FE_PWD"))
this.qr_path = getGlobalCFG("QRPATH")
this.modo_local = getGlobalCFG("FELOCAL")
this.fe_ticket_acceso = ALLTRIM(getGlobalCFG("FE_TICKACC"))
ENDPROC


************************************************************
OBJETO: cls_ventas_model
************************************************************
*** PROPIEDADES ***
idventasc = 0
idcliente = 0
idcondpago = 0
idsitiva = 0
idvendedor = 0
usuario = 
host = 
aut_cae = 
aut_cae_vto = 
aut_resultado = 
aut_motivo = 
aut_tipocbte = 
aut_qr = 
error_message = 
cbte = 
tipodoc = 
cliente_mayorista = .F.
cliente_descuento = 0.00
idventasd = 1
total_facturado = 0.00
modo_presupuesto = .F.
oactiveconnection = 
total_neto = 0.00
tot_impdesc1 = 0.00
tot_impdesc2 = 0.00
tot_impdesc3 = 0.00
tot_impdesc4 = 0.00
tot_impiva21 = 0.00
tot_impiva105 = 0.00
message_error = 
ptovta = 0
numcbte = 0
fe_totiva = 0.00
o_con_c2 = 
oconexionc2 = 
total_no_gravado = 0.00
tot_imp_neto = 0.00
Name = "cls_ventas_model"

*** METODOS ***
PROCEDURE crear_cursor_items
***************************************************************************
* Crea el cursor para almacenar el detalle de la factura a medida que se
* vaya pickeando y cargando artículos.
***************************************************************************

CREATE CURSOR cur_items ( ;
	idVentasD int ,;
	idArticulo int ,;
	codArt varchar(20) ,;
	descripcio varchar(200) ,;
	cantidad N(20, 2) ,;
	costoRep N(20, 2) ,;
	prUnit N(20, 2),;
	porDesc1 N(5, 2) ,;
	porDesc2 N(5, 2) DEFAULT 0,;
	porDesc3 N(5, 2) DEFAULT 0,;
	porDesc4 N(5, 2) DEFAULT 0,;
	impDesc1 N(20, 2) ,;
	impDesc2 N(20, 2) DEFAULT 0,;
	impDesc3 N(20, 2) DEFAULT 0,;
	impDesc4 N(20 , 2) DEFAULT 0,;
	porRec N(5, 2) DEFAULT 0,;
	impRec N(5, 2) DEFAULT 0,;
	porDesItm1 N(5, 2) DEFAULT 0,;
	porDesItm2 N(5, 2) DEFAULT 0,;
	porDesItm3 N(5, 2) DEFAULT 0,;
	porDesItm4 N(5, 2) DEFAULT 0,;
	ImpDesItm1 N(20, 2) DEFAULT 0,;
	impDesItm2 N(20, 2) DEFAULT 0,;
	impDesItm3 N(20, 2) DEFAULT 0,;
	impDesItm4 N(20, 2) DEFAULT 0,;
	porRecItm N(5, 2) DEFAULT 0,;
	impRecItm N(20, 2) DEFAULT 0,;
	impNeto N(20, 2),;
	usarImpuIn L,;
	porImpuIn N(5, 2),;
	impImInMay N(20, 2),;
	impImInMin N(20, 2),;
	porNoGrav N(20, 2),;
	baseGrav N(20, 2),;
	subtNoGrav N(20, 2),;
	totNeto N(20, 2),;
	alicIVA N(5, 2) ,;
	impIVA N(20, 2),;
	subTotal N(20, 2),;
	nroPart varchar(30) DEFAULT '',;
	esOferta L,;
	uniDesp N(20, 2) ,;
	cantPack N(20, 2),;
	codUM varchar(3))

ENDPROC
PROCEDURE validar_comprobante
**************************************************************************
* Valida que los datos de cabecera de la factura se encuentren seteados.
**************************************************************************

IF This.idcliente = 0 THEN
	this.error_message = "El cliente no se enceuntra cargado"
	RETURN .F.
ENDIF

IF this.idcondpago = 0 THEN
	this.error_message = "La condición de pago no se encuentra cargada"
	RETURN .F.
ENDIF

IF this.idsitiva = 0 THEN
	this.error_message = "La situación de IVA no se encuentra cargada"
	RETURN .F.
ENDIF

IF this.idvendedor = 0 THEN
	this.error_message = "El vendedor no se encuentra cargado"
	RETURN .F.
ENDIF

SELECT cur_items
IF RECCOUNT("cur_items") = 0 THEN
	this.error_message = "No hay artículos cargados en el comprobante"
	RETURN .F.
ENDIF

RETURN .T.
ENDPROC
PROCEDURE validar_detalle
***************************************************************
* Valida el ingreso del detalle del comprobante
***************************************************************
PARAMETERS tcCodigo, tnCantidad

IF ALLTRIM(tcCodigo) == "" THEN
	this.error_message = "El código de artículo no está cargado"
	RETURN .F.
ENDIF

IF tnCantidad = 0 THEN
	this.error_message = "La cantidad no puede ser 0 (cero)"
	RETURN .F.
ENDIF

IF tnCantidad > 500 THEN
	this.error_message = "Está ingresando una cantidad superior a 500 unidades, CUIDADO!!!"
	RETURN .F.
ENDIF

RETURN .T.
ENDPROC
PROCEDURE recalcular
*********************************************************
* Permite recalcular el comprobante.
*********************************************************
SELECT cur_items
GO TOP



ENDPROC
PROCEDURE calcular_totales
***************************************************
* Calcula el total de la factura 
***************************************************

SELECT									  	;
	SUM(impNeto * cantidad) AS totImpNeto,	;
	SUM(totNeto) AS totNeto,			  	;
	SUM(impDesc1 * cantidad) AS impDesc1 ,	;
	SUM(impDesc2 * cantidad) AS impDesc2 ,	;
	SUM(impDesc3 * cantidad) AS impDesc3 ,	;
	SUM(impDesc4 * cantidad) AS impDesc4 ,	;
	SUM(subtNoGrav * cantidad) AS subtNoGrav,;
	SUM(subTotal) AS total				  	;
FROM									  	;
	cur_items							  	;
INTO CURSOR cur_total

This.total_no_gravado = cur_total.subtNoGrav
This.total_facturado = cur_total.total
This.tot_imp_neto = cur_total.totImpNeto
This.total_neto = cur_total.totNeto
This.tot_impdesc1 = cur_total.impDesc1
This.tot_impdesc2 = cur_total.impDesc2
This.tot_impdesc3 = cur_total.impDesc3
This.tot_impdesc4 = cur_total.impDesc4

* Calculo los importes totales de IVA

* Saco el importe total del IVA al 21%
SELECT ;
	SUM(impIVA) AS totIVA ;
FROM ;
	cur_items ;
WHERE ;
	cur_items.alicIVA = 21 ;
INTO CURSOR cur_totiva21

SELECT cur_totiva21
this.tot_impiva21 = IIF(ISNULL(cur_totiva21.totIVA), 0, cur_totiva21.totIVA)
USE IN cur_totiva21

* Saco el importe total de IVA al 10,5%
SELECT 						;
	SUM(impIVA) AS totIVA 	;
FROM 						;
	cur_items 				;
WHERE 						;
	cur_items.alicIVA = 10.5;
INTO CURSOR cur_totiva105

SELECT cur_totiva105
this.tot_impiva105 = IIF(ISNULL(cur_totiva105.totIVA), 0, cur_totiva105.totIVA)
USE IN cur_totiva105

USE IN cur_total



ENDPROC
PROCEDURE calcular_letra
**************************************************************************
* Obtiene la letra del comprobante según la situación de IVA del cliente
* contra la empresa.
**************************************************************************

LOCAL lnIdSitIVAEmpresa

lnIdSitIVAEmpresa = INT(VAL(getConfig("SITIVAEMP")))

IF lnIdSitIVAEmpresa = 1 THEN
	DO CASE
		CASE this.idsitiva = 1
			* RI
			this.tipodoc = "A"
		CASE this.idsitiva = 3
			* CF
			this.tipodoc = "B"
		CASE this.idsitiva = 6
			* MONOTRIBUTO
			this.tipodoc = "A"
	ENDCASE
ENDIF

IF lnIdSitIVAEmpresa = 6 THEN
	this.tipodoc = "C"
ENDIF

IF this.modo_presupuesto THEN
	this.tipodoc = "X"
ENDIF

ENDPROC
PROCEDURE grabar
***************************************************************
* Permite grabar el comprobante.
***************************************************************
LOCAL loRes
LOCAL lcSql

loRes = CREATEOBJECT("odbc_result")
TEXT TO lcSql NOSHOW
	CALL ventas_generar_cbtes (
		?xidCliente,
		?xidCondPago,
		?xidSitIVA,
		?xidVendedor,
		?xfecEmision,
		?xfecVto,
		?xcbte,
		?xtipoDoc,
		?xptoVta,
		?xnumCbte,
		?ximpNeto,
		?ximpFinal,
		?xporIVA21,
		?ximpIVA21,
		?xporIVA105,
		?ximpIVA105,
		?xporIIBB,
		?ximpIIBB,
		?xporDesc1,
		?ximpDesc1,
		?xporDesc2,
		?ximpDesc2,
		?xporDesc3,
		?ximpDesc3,
		?xporDesc4,
		?ximpDesc4,
		?xporRec,
		?ximpRec,
		?xtotaNoGrav,
		?xtotFact,
		?xsaldo,
		?xusuario,
		?xhost,
		?xidTipoDoc,
		?xnroDoc,
		?xrazSoc)
ENDTEXT

SELECT cur_ventascab
lcSql = loRes.AddParameter(lcSql, "xidCliente", ALLTRIM(STR(cur_ventascab.idCliente)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "xidCondPago", ALLTRIM(STR(cur_ventascab.idCondPago)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "xidSitIVA", ALLTRIM(STR(cur_ventascab.idSitIVA)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "xidVendedor", ALLTRIM(STR(cur_ventascab.idVendedor)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "xfecEmision", cur_ventascab.fecEmision, .f., .t.)
lcSql = loRes.AddParameter(lcSql, "xfecVto", cur_ventascab.fecVto, .f., .t.)
lcSql = loRes.AddParameter(lcSql, "xcbte", ALLTRIM(cur_ventascab.cbte), .t., .f.)
lcSql = loRes.AddParameter(lcSql, "xtipoDoc", ALLTRIM(cur_ventascab.tipoDoc), .t., .f.)
lcSql = loRes.AddParameter(lcSql, "xptoVta", ALLTRIM(STR(cur_ventascab.ptoVta)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "xnumCbte", ALLTRIM(STR(cur_ventascab.numCbte)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "ximpNeto", ALLTRIM(STR(cur_ventascab.impNeto, 20, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "ximpFinal", ALLTRIM(STR(cur_ventascab.impFinal, 20, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "xporIVA21", ALLTRIM(STR(cur_ventascab.porIVA21, 5, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "ximpIVA21", ALLTRIM(STR(cur_ventascab.impIVA21, 5, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "xporIVA105", ALLTRIM(STR(cur_ventascab.porIVA105, 5, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "ximpIVA105", ALLTRIM(STR(cur_ventascab.impIVA105, 20, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "xporIIBB", ALLTRIM(STR(cur_ventascab.porIIBB, 5, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "ximpIIBB", ALLTRIM(STR(cur_ventascab.impIIBB, 20, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "xporDesc1", ALLTRIM(STR(cur_ventascab.porDesc1, 5, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "ximpDesc1", ALLTRIM(STR(cur_ventascab.impDesc1, 20, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "xporDesc2", ALLTRIM(STR(cur_ventascab.porDesc2, 5, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "ximpDesc2", ALLTRIM(STR(cur_ventascab.impDesc2, 20, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "xporDesc3", ALLTRIM(STR(cur_ventascab.porDesc3, 5, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "ximpDesc3", ALLTRIM(STR(cur_ventascab.impDesc3, 20, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "xporDesc4", ALLTRIM(STR(cur_ventascab.porDesc4, 5, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "ximpDesc4", ALLTRIM(STR(cur_ventascab.impDesc4, 20, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "xporRec", ALLTRIM(STR(cur_ventascab.porRec, 5, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "ximpRec", ALLTRIM(STR(cur_ventascab.impRec, 20, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "xtotaNoGrav", ALLTRIM(STR(cur_ventascab.totaNoGrav, 20, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "xtotFact", ALLTRIM(STR(cur_ventascab.totFact, 20, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "xsaldo", ALLTRIM(STR(cur_ventascab.saldo, 20, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "xusuario", ALLTRIM(cur_ventascab.usuAlta), .t., .f.)
lcSql = loRes.AddParameter(lcSql, "xhost", ALLTRIM(cur_ventascab.idHostAlta), .t., .f.)
lcSql = loRes.AddParameter(lcSql, "xidTipoDoc", ALLTRIM(STR(cur_ventascab.idTipoDoc)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "xnroDoc", ALLTRIM(cur_ventascab.nroDoc), .t., .f.)
lcSql = loRes.AddParameter(lcSql, "xrazSoc", ALLTRIM(cur_ventascab.razSoc), .t., .f.)

loRes.ActiveConnection = this.oActiveConnection

loRes.Cursor_Name = "cur_x"
loRes.OpenQuery(lcSql)

SELECT cur_x
IF getCursorResultValue(cur_x.result) = 0 THEN
	MESSAGEBOX(cur_x.mensaje, 0+16, "Error de base de datos")
	loRes.Close_Query()
	RETURN .F.
ENDIF

* Recupero el idVentasC generado para mantener el valor
* ya que lo necesito para el resto de las operaciones.
this.idventasc = cur_x.result

loRes.Close_Query()

RETURN .T.

ENDPROC
PROCEDURE modificar_item
**************************************************************************
* Modifica la cantidad de un ítem y recalcula los valores.
* Fecha: 18/02/2023
* Desarrollador: Leonardo D. Zulli
**************************************************************************
LPARAMETERS tnIdArticulo, tnCantidad
This.calcular_importes_items(tnIdArticulo, tnCantidad, .T.)
This.calcular_totales()
ENDPROC
PROCEDURE eliminar_item
***********************************************************
* Elimina el ítem seleccionado del comprobante.
***********************************************************

SELECT cur_items
DELETE
This.calcular_totales()
ENDPROC
PROCEDURE setcliente
******************************************************************
* Establece el id cliente seleccionado y recupera los datos
* del mismo.
******************************************************************
LPARAMETERS tnIdCliente

LOCAL loRes
LOCAL lcSql

* Inicializo las variables
loRes = CREATEOBJECT("odbc_result")
lcSql = ""

this.idcliente = tnIdCliente

* Recupero los datos que necesito del cliente
TEXT TO lcSql NOSHOW
	SELECT
		idCondPago,
		idSitIVA,
		idVendedor,
		mayorista,
		desc1
	FROM
		clientes
	WHERE
		clientes.idCliente = ?id
ENDTEXT

lcSql = loRes.AddParameter(lcSql, "id", ALLTRIM(STR(this.idcliente)), .F., .F.)

loRes.ActiveConnection = this.oActiveConnection
loRes.cursor_name = "cur_x"
loRes.OpenQuery(lcSql)

SELECT cur_x
this.idcondpago = cur_x.idCondPago
this.idsitiva = cur_x.idSitIVA
this.idvendedor = cur_x.idVendedor
this.cliente_mayorista = cur_x.mayorista
this.cliente_descuento = cur_x.desc1

loRes.Close_Query()

ENDPROC
PROCEDURE agregar_item
******************************************************************
* Agrega un ítem al detalle de la factura
******************************************************************
LPARAMETERS tnIdArticulo, tnCantidad
This.calcular_importes_items(tnIdArticulo, tnCantidad, .F.)
This.calcular_totales()
ENDPROC
PROCEDURE vaciar_cursor_items
**************************************************************
* Vacía el cursor de items.
**************************************************************

SELECT cur_items
ZAP
ENDPROC
PROCEDURE cambiar_modo
*******************************************************************
* Cambia al modo presupuesto.
*******************************************************************

IF !this.modo_presupuesto THEN
	this.cbte = "PTO"
	this.ptovta = 9999
	this.tipodoc = "X"
	this.modo_presupuesto = .t.
	this.oActiveConnection = this.oConexionC2.ActiveConnection
ELSE
	this.cbte = "FC"
	this.modo_presupuesto = .f.
	this.oActiveConnection = goConn.ActiveConnection
ENDIF
ENDPROC
PROCEDURE crear_cursor_cab
********************************************************************
* Permite crear el cursor de cabecera para almacenar los datos
* temporalmente.
* Fecha: 15/10/2022
* Autor: Leonardo D. Zulli
********************************************************************

CREATE CURSOR cur_ventascab (  ;
	idCliente 		int NOT NULL,; 
	idCondPago 		int NOT NULL,;
	idSitIVA 		int NOT NULL,;
	idVendedor 		int NOT NULL DEFAULT 1,;
	fecEmision 		datetime NULL,;
	fecVto 			datetime NULL,;
	cbte 			varchar(3) NOT NULL,;
	tipoDoc 		varchar(1) NOT NULL,;
	ptoVta 			int NOT NULL,;
	numCbte 		int NOT NULL,;  
	anulado 		L NOT NULL DEFAULT .F.,;
	impNeto 		N(20, 2) NOT NULL,;	
	impFinal 		N(20, 2) NOT NULL,;  
	porIVA21 		N(20, 2) NOT NULL,;  
	impIVA21 		N(20, 2) NOT NULL,;  
	porIVA105 		N(20, 2) NOT NULL,;
	impIVA105 		N(20, 2) NOT NULL,; 
	porIIBB 		N(20, 2) NULL,;
	impIIBB 		N(20, 2) NULL,; 
	porDesc1 		N(5, 2) NOT NULL,;
	impDesc1 		N(20, 2) NOT NULL,; 
	porDesc2 		N(5, 2) NOT NULL,; 
	impDesc2 		N(20, 2) NOT NULL,; 
	porDesc3 		N(5, 2) NOT NULL,; 
	impDesc3 		N(20, 2) NOT NULL,; 
	porDesc4 		N(5, 2) NOT NULL,; 
	impDesc4 		N(20, 2) NOT NULL,; 
	totaNoGrav 		N(20, 2) NOT NULL DEFAULT 0.00,;
	totFact 		N(20, 2) NOT NULL,;
	saldo 			N(20, 2) NULL,;
	esPendi 		L NOT NULL DEFAULT .F.,;
	observ 			M NULL,;
	procesado 		L NOT NULL DEFAULT .F.,;
	usuAlta 		varchar(5) NOT NULL,;
	fecAlta 		datetime NOT NULL,;
	idHostAlta 		varchar(50) NOT NULL,;
	usuModi 		varchar(5) NULL,;
	fecModi 		datetime NULL,;
	idHostModi 		varchar(50) NULL,;
	usuBaja 		varchar(5) NULL,;
	fecBaja 		datetime NULL,;
	idHostBaja 		varchar(50) NULL,;
	porRec 			N(5, 2) NOT NULL DEFAULT 0,;
	impRec 			N(20, 2) NOT NULL DEFAULT 0,; 
	razSoc 			varchar(60) NULL,;
	idTipoDoc 		int NULL,;
	nroDoc 			varchar(20) NULL;
)
ENDPROC
PROCEDURE get_punto_venta
***********************************************************
* Este método permite obtener el punto de venta de la 
* estación de trabajo actual.
***********************************************************

LOCAL lnPtoVta
LOCAL loNumerador
LOCAL loRes
LOCAL lcSql

* Si no es modo presupuesto levanto el punto de venta configurado
* en la estación de trabajo.
IF !This.modo_presupuesto  THEN
	lnPtoVta = INT(VAL(getConfig("PTOVTA")))
ELSE
	lnPtoVta = this.ptovta
	this.tipodoc = "X"
ENDIF

loRes = CREATEOBJECT("odbc_result")

loNumerador = CREATEOBJECT("cls_numeradores")
loNumerador.cbte = This.cbte
loNumerador.ptovta = lnPtoVta
loNumerador.tipoDoc = This.tipodoc
loNumerador.getPtoVta()

SELECT cur_talonario
ZAP
APPEND BLANK
REPLACE cur_talonario.idNum WITH loNumerador.idNum
REPLACE cur_talonario.cbte WITH loNumerador.cbte ADDITIVE
REPLACE cur_talonario.tipoDoc WITH loNumerador.tipoDoc ADDITIVE
REPLACE cur_talonario.ptoVta WITH loNumerador.ptoVta ADDITIVE
REPLACE cur_talonario.numActual WITH loNumerador.numactual ADDITIVE

* Recupero los datos de la impresora
TEXT TO lcSql NOSHOW
	SELECT
		*
	FROM
		impresoras
	WHERE
		impresoras.idNum = ?xid
ENDTEXT
lcSql = loRes.AddParameter(lcSql, "xid", ALLTRIM(STR(loNumerador.idNum)), .F., .F.)
loRes.ActiveConnection = this.oActiveConnection
loRes.Cursor_Name = "cur_x"
loRes.OpenQuery(lcSql)
SELECT cur_x
REPLACE cur_talonario.impresora WITH cur_x.impresora ADDITIVE
REPLACE cur_talonario.copias WITH cur_x.copias ADDITIVE

loRes.Close_Query()

ENDPROC
PROCEDURE crear_cursores_auxiliares
*******************************************************************************
* Permite crear cursores auxiliares para grabar datos que se requieren para
* grabar los comprobantes.
* Fecha: 15/10/2022
* Autor: Leonardo D. Zulli
*******************************************************************************

CREATE CURSOR cur_condpagos ( ;
	idCondPago int,;
	descripcio varchar(60),;
	cntDias int)
	
CREATE CURSOR cur_talonario ( ;
	idNum int,;
	cbte varchar(3),;
	tipoDoc varchar(1) NULL,;
	ptoVta int,;
	numActual int DEFAULT 0,;
	impresora varchar(100),;
	copias int,;
	usa_ticket L)
ENDPROC
PROCEDURE get_condicion_pago
*******************************************************************************
* Permite recuperar el registro de condiciones de pagos.
*******************************************************************************
LOCAL lcSql
LOCAL loRes

loRes = CREATEOBJECT("odbc_result")

TEXT TO lcSql NOSHOW
	SELECT
		*
	FROM
		condpagos
	WHERE
		condpagos.idCondPago = ?xid
ENDTEXT

lcSql = loRes.AddParameter(lcSql, "xid", ALLTRIM(STR(this.idcondpago)), .F., .F.)
loRes.ActiveConnection = this.oActiveConnection
loRes.Cursor_Name = "cur_x"
loRes.OpenQuery(lcSql)
SELECT cur_condpagos
REPLACE cur_condpagos.idCondPago WITH cur_x.idCondPago
REPLACE cur_condpagos.descripcio WITH cur_x.descripcio ADDITIVE
REPLACE cur_condpagos.cntDias WITH cur_x.cntDias ADDITIVE

loRes.Close_Query()
ENDPROC
PROCEDURE enviar_items_a_temporal
************************************************************************************
* Carga los ítems que se encuentran en cur_items a la tabla temporal ventasdet_tmp.
* Fecha: 16/10/2022
* Autor: Leonardo D. Zulli
************************************************************************************
LOCAL loRes
LOCAL lcSql

loRes = CREATEOBJECT("odbc_result")

SELECT cur_items
GO TOP
DO WHILE !EOF("cur_items")
	TEXT TO lcSql NOSHOW
		CALL ventasdet_temp_insert (
			?xidArticulo,
			?xcantidad,
			?xcantNC,     
			?xcostoRep,     
			?xprArtic,     
			?xprVenta,     
			?xporDesc1,     
			?xporDesc2,     
			?xporDesc3,     
			?xporDesc4,     
			?ximpDesc1,     
			?ximpDesc2,     
			?ximpDesc3,     
			?ximpDesc4,     
			?xpDtoVta1,     
			?xpDtoVta2,     
			?xpDtoVta3,     
			?xpDtoVta4,     
			?xiDtoVta1,     
			?xiDtoVta2,     
			?xiDtoVta3,     
			?xiDtoVta4,     
			?ximpNeto,     
			?xporNoGrav,     
			?xbaseGrav,     
			?xsubtNoGrav,     
			?xtotNeto,     
			?xalicIVA,     
			?ximpIVA,     
			?xsubTotal,     
			?xnroPart,     
			?xesOferta,     
			?xpRecVta,     
			?xiRecVta,     
			?xUniDesp,     
			?xcantPack,     
			?xcodUM,     
			?xcant_pri1,     
			?xcant_pri2,     
			?xcant_pri3,     
			?xdescripcio,     
			?xcant_falt,     
			?xpRecItem,     
			?xiRecItem,     
			?xusuario,     
			?xhost);
	ENDTEXT
	lcSql = loRes.AddParameter(lcSql, "xidArticulo", ALLTRIM(STR(cur_items.idArticulo)), .f., .f.)
	lcSql = loRes.AddParameter(lcSql, "xcantidad", ALLTRIM(STR(cur_items.cantidad, 20, 2)), .f., .f.)
	lcSql = loRes.AddParameter(lcSql, "xcantNC", "0", .f., .f.)
	
	* xcostoRep hay que agregarlo al cursor cur_items.
	lcSql = loRes.AddParameter(lcSql, "xcostoRep", ALLTRIM(STR(cur_items.costoRep, 20, 2)), .f., .f.)
	
	* Estos dos campos están repetidos pero los dejo por las dudas que se usen ambos
	* en otra parte del sistema.
	lcSql = loRes.AddParameter(lcSql, "xprArtic", ALLTRIM(STR(cur_items.prUnit, 20, 2)), .f., .f.)
	lcSql = loRes.AddParameter(lcSql, "xprVenta", ALLTRIM(STR(cur_items.prUnit, 20, 2)), .f., .f.)
	
	* Descuentos general del comprobante
	lcSql = loRes.AddParameter(lcSql, "xporDesc1", ALLTRIM(STR(cur_items.porDesc1, 5, 2)), .f., .f.)
	lcSql = loRes.AddParameter(lcSql, "xporDesc2", ALLTRIM(STR(cur_items.porDesc2, 5, 2)), .f., .f.)
	lcSql = loRes.AddParameter(lcSql, "xporDesc3", ALLTRIM(STR(cur_items.porDesc3, 5, 2)), .f., .f.)
	lcSql = loRes.AddParameter(lcSql, "xporDesc4", ALLTRIM(STR(cur_items.porDesc4, 5, 2)), .f., .f.)
	lcSql = loRes.AddParameter(lcSql, "ximpDesc1", ALLTRIM(STR(cur_items.impDesc1, 20, 2)), .f., .f.)
	lcSql = loRes.AddParameter(lcSql, "ximpDesc2", ALLTRIM(STR(cur_items.impDesc2, 20, 2)), .f., .f.)
	lcSql = loRes.AddParameter(lcSql, "ximpDesc3", ALLTRIM(STR(cur_items.impDesc3, 20, 2)), .f., .f.)
	lcSql = loRes.AddParameter(lcSql, "ximpDesc4", ALLTRIM(STR(cur_items.impDesc4, 20, 2)), .f., .f.)
	
	* Descuentos por ítem.
	lcSql = loRes.AddParameter(lcSql, "xpDtoVta1", ALLTRIM(STR(cur_items.porDesItm1, 5, 2)), .f., .f.)
	lcSql = loRes.AddParameter(lcSql, "xpDtoVta2", ALLTRIM(STR(cur_items.porDesItm2, 5, 2)), .f., .f.)
	lcSql = loRes.AddParameter(lcSql, "xpDtoVta3", ALLTRIM(STR(cur_items.porDesItm3, 5, 2)), .f., .f.)
	lcSql = loRes.AddParameter(lcSql, "xpDtoVta4", ALLTRIM(STR(cur_items.porDesItm4, 5, 2)), .f., .f.)
	lcSql = loRes.AddParameter(lcSql, "xiDtoVta1", ALLTRIM(STR(cur_items.impDesItm1, 20, 2)), .f., .f.)
	lcSql = loRes.AddParameter(lcSql, "xiDtoVta2", ALLTRIM(STR(cur_items.impDesItm2, 20, 2)), .f., .f.)
	lcSql = loRes.AddParameter(lcSql, "xiDtoVta3", ALLTRIM(STR(cur_items.impDesItm3, 20, 2)), .f., .f.)
	lcSql = loRes.AddParameter(lcSql, "xiDtoVta4", ALLTRIM(STR(cur_items.impDesItm4, 20, 2)), .f., .f.)
	
	lcSql = loRes.AddParameter(lcSql, "ximpNeto", ALLTRIM(STR(cur_items.impNeto, 20, 2)), .f., .f.)
	lcSql = loRes.AddParameter(lcSql, "xporNoGrav", ALLTRIM(STR(cur_items.porNoGrav, 20, 2)), .f., .f.)
	lcSql = loRes.AddParameter(lcSql, "xbaseGrav", ALLTRIM(STR(cur_items.baseGrav, 20, 2)), .f., .f.)
	lcSql = loRes.AddParameter(lcSql, "xsubtNoGrav", ALLTRIM(STR(cur_items.subtNoGrav, 20, 2)), .f., .f.)
	lcSql = loRes.AddParameter(lcSql, "xtotNeto", ALLTRIM(STR(cur_items.totNeto, 20, 2)), .f., .f.)
	lcSql = loRes.AddParameter(lcSql, "xalicIVA", ALLTRIM(STR(cur_items.alicIVA, 5, 2)), .f., .f.)
	lcSql = loRes.AddParameter(lcSql, "ximpIVA", ALLTRIM(STR(cur_items.impIVA, 20, 2)), .f., .f.)
	lcSql = loRes.AddParameter(lcSql, "xsubTotal", ALLTRIM(STR(cur_items.subTotal, 20, 2)), .f., .f.)
	lcSql = loRes.AddParameter(lcSql, "xnroPart", ALLTRIM(cur_items.nroPart), .t., .f.)
	lcSql = loRes.AddParameter(lcSql, "xesOferta", ALLTRIM(STR(IIF(cur_items.esOferta, 1, 0))), .f., .f.)
	
	* Recargo general del comprobante
	lcSql = loRes.AddParameter(lcSql, "xpRecVta", ALLTRIM(STR(cur_items.porRec, 5, 2)), .f., .f.)
	lcSql = loRes.AddParameter(lcSql, "xiRecVta", ALLTRIM(STR(cur_items.impRec, 10, 2)), .f., .f.)
	
	lcSql = loRes.AddParameter(lcSql, "xUniDesp", ALLTRIM(STR(cur_items.uniDesp, 20, 2)), .f., .f.)
	lcSql = loRes.AddParameter(lcSql, "xcantPack", ALLTRIM(STR(cur_items.cantPack, 20, 2)), .f., .f.)
	lcSql = loRes.AddParameter(lcSql, "xcodUM", ALLTRIM(cur_items.codUM), .t., .f.)
	
	* Si alguna vez lo enlazo con pedidos entonces tengo que habilitar los siguientes
	* tres parametros y agregarlos al cursor cur_items.
	lcSql = loRes.AddParameter(lcSql, "xcant_pri1", "0", .f., .f.)
	lcSql = loRes.AddParameter(lcSql, "xcant_pri2", "0", .f., .f.)
	lcSql = loRes.AddParameter(lcSql, "xcant_pri3", "0", .f., .f.)
	
	lcSql = loRes.AddParameter(lcSql, "xdescripcio", ALLTRIM(cur_items.descripcio), .t., .f.)
	
	* Si alguna vez tengo que contemplar faltantes tengo que habilitar el siguiente
	* campo y agregarlo al cursor cur_items.
	lcSql = loRes.AddParameter(lcSql ,"xcant_falt", "0", .f., .f.)
	
	* Recargo por ítem.
	lcSql = loRes.AddParameter(lcSql, "xpRecItem", ALLTRIM(STR(cur_items.porRecItm, 5, 2)), .f., .f.)
	lcSql = loRes.AddParameter(lcSql, "xiRecItem", ALLTRIM(STR(cur_items.impRecItm, 20, 2)), .f., .f.)
	
	lcSql = loRes.AddParameter(lcSql, "xusuario", ALLTRIM(gcCodUsu), .t., .f.)
	lcSql = loRes.AddParameter(lcSql, "xhost", ALLTRIM(SYS(0)), .t., .f.)
	
	loRes.ActiveConnection = This.oActiveConnection
	loRes.cursor_name = "cur_res"
	loRes.OpenQuery(lcSql)
	
	SELECT cur_res
	IF cur_res.result = 0 THEN
		loRes.Close_Query()
		This.Message_error = "Error al enviar ítems a temporal"
		RETURN .F.
	ENDIF
	
	loRes.Close_Query()
	
	SELECT cur_items
	SKIP
ENDDO

SELECT cur_items
GO TOP

RETURN .T.
ENDPROC
PROCEDURE limpiar_tabla_temporal
***************************************************************************
* Limpia la tabla temporal ventasdet_tmp para el usuario y host actual.
* Fecha: 16/10/2022
* Autor: Leonardo D. Zulli
***************************************************************************

LOCAL loCmd

loCmd = CREATEOBJECT("odbc_command")

TEXT TO loCmd.CommandText NOSHOW
	DELETE
	FROM
		ventasdet_tmp
	WHERE
		ventasdet_tmp.usuario = ?xusuario AND
		ventasdet_tmp.host = ?xhost
ENDTEXT

loCmd.AddParameter("xusuario", ALLTRIM(gcCodUsu), .t., .f.)
loCmd.AddParameter("xhost", ALLTRIM(SYS(0)), .t., .f.)
loCmd.ActiveConnection = This.oActiveConnection
IF !loCmd.Execute() THEN
	This.error_message = loCmd.ErrorMessage
	RETURN .F.
ENDIF

RETURN .T.
ENDPROC
PROCEDURE grabar_movimiento_ctacte
*********************************************************************
* Este método permite generar el movimiento de cuentas corrientes
* Fecha: 22/11/2022
*********************************************************************
LOCAL loCmd

loCmd = CREATEOBJECT("odbc_command")
TEXT TO loCmd.CommandText NOSHOW
	CALL cccli_insertarFactura (?xidVentaC)
ENDTEXT
loCmd.AddParameter("xidVentaC", ALLTRIM(STR(this.Idventasc)), .f., .f.)
loCmd.ActiveConnection = this.oActiveConnection
IF !loCmd.Execute() THEN
	this.Error_message = loCmd.ErrorMessage
	RETURN .F.
ENDIF

RETURN .T.
ENDPROC
PROCEDURE set_cae
*****************************************************************
* Permite grabar los resultados de la autorización de AFIP.
* Fecha: 25/11/2022.
* Desarrollador: Leonardo D. Zulli
*****************************************************************

LOCAL loCmd

loCmd = CREATEOBJECT("odbc_command")

TEXT TO loCmd.CommandText NOSHOW
	CALL ventas_setcae (
		?xidventac,
		?xptoVta,
		?xnumcbte,
		?xautCAE,
		?xautVencimiento,
		?xautResultado,
		?xautMotivo,
		?xautTipoCbte,
		?xautQR)
ENDTEXT

loCmd.AddParameter("xidventac", ALLTRIM(STR(this.idventasc)), .f., .f.)
loCmd.AddParameter("xptoVta", ALLTRIM(STR(cur_ventascab.ptoVta)), .f., .f.)
loCmd.AddParameter("xnumcbte", ALLTRIM(STR(this.numCbte)), .f., .f.)
loCmd.AddParameter("xautCAE", ALLTRIM(this.aut_cae), .t., .f.)
loCmd.AddParameter("xautVencimiento", ALLTRIM(this.aut_cae_vto), .t., .f.)
loCmd.AddParameter("xautResultado", ALLTRIM(this.aut_resultado), .t., .f.)
loCmd.AddParameter("xautMotivo", ALLTRIM(this.aut_motivo), .t., .f.)
loCmd.AddParameter("xautTipoCbte", ALLTRIM(STR(this.aut_tipocbte)), .t., .f.)
loCmd.AddParameter("xautQR", ALLTRIM(this.aut_qr), .t., .f.)

loCmd.ActiveConnection = goConn.ActiveConnection
IF !loCmd.Execute() THEN
	this.error_message = loCmd.ErrorMessage
	RETURN .F.
ENDIF

RETURN .T.
ENDPROC
PROCEDURE grabar_movimientos_stock
*****************************************************************
* Este código permite grabar los movimientos de stock de un
* determinado comprobante.
* Fecha: 27/11/2022
* Desarrollado por: Leonardo D. Zulli
*****************************************************************

LOCAL loCmd

loCmd = CREATEOBJECT("odbc_command")
TEXT TO loCmd.CommandText NOSHOW
	CALL ventas_restar_stock (
		?xidVentaC,
		?xusuario,
		?xhost,
		?xautoTransaction)	
ENDTEXT

loCmd.AddParameter("xidVentaC", ALLTRIM(STR(this.idventasc)), .f., .f.)
loCmd.AddParameter("xusuario", ALLTRIM(this.usuario), .t., .f.)
loCmd.AddParameter("xhost", ALLTRIM(this.host), .t., .f.)

&& Manejo la transacción desde acá
loCmd.AddParameter("xautoTransaction", "1", .f., .f.)

loCmd.ActiveConnection = goConn.ActiveConnection
IF !loCmd.Execute() THEN
	this.error_message = loCmd.ErrorMessage
	RETURN .F.
ENDIF

RETURN .T.




ENDPROC
PROCEDURE get_tipocbte
*******************************************************************
* Obtiene el código del comprobante según AFIP.
* Fecha: 09/12/2022
* Desarrollador: Leonardo D. Zulli
*******************************************************************
LOCAL loRes
LOCAL lcSql
LOCAL lnCodAFIP

loRes = CREATEOBJECT("odbc_result")
lnCodAFIP = 0

TEXT TO lcSql NOSHOW
	SELECT
		codafip
	FROM
		numerador
	WHERE
		numerador.cbte = ?xcbte AND
		numerador.tipoDoc = ?xtipoDoc
ENDTEXT

lcSql = loRes.addParameter(lcSql, "xcbte", ALLTRIM(this.cbte), .t., .f.)
lcSql = loRes.addParameter(lcSql, "xtipoDoc", ALLTRIM(this.tipodoc), .t., .f.)

loRes.ActiveConnection = this.oactiveconnection
loRes.Cursor_Name = "cur_x"
loRes.OpenQuery(lcSql)
SELECT cur_x
lnCodAFIP = cur_x.codafip
loRes.Close_Query()

RETURN lnCodAFIP
ENDPROC
PROCEDURE calcular_totales_ivas_afip
*********************************************************************
* Permite calcular los totales del comprobanet actual para enviar
* al webservice de AFIP para su autorización.
* Fecha: 20/12/2022
* Desarrollado por: Leonardo D. Zulli
*********************************************************************

LOCAL loRes
LOCAL lcSql

loRes = CREATEOBJECT("odbc_result")

TEXT TO lcSql NOSHOW
	SELECT
		(@itemcant := @itemcant + 1) AS 'item_cant',
	    (@indice_item := @indice_item + 1) AS 'indice_item',
	    ivaId AS 'iva_id',
	    alicIVA,
	    imp_base,
	    imp_iva
	FROM
		(SELECT 
			@itemcant := 0,
	        @indice_item := -1,
			CASE
				WHEN alicIVA = 21 THEN 5
				WHEN alicIVA = 10.5 THEN 4
				WHEN alicIVA = 0 THEN 3
			END 'ivaId',
			alicIVA,
			ROUND(SUM(totNeto), 2) AS 'imp_base',
			ROUND(SUM(impIVA), 2) AS 'imp_iva'
		FROM
			ventasdet 
		WHERE
			idVentasC = ?id
		GROUP BY
			alicIVA
		ORDER BY
			alicIVA) AS ivas
ENDTEXT

lcSql = loRes.AddParameter(lcSql, "id", ALLTRIM(STR(this.idventasc)), .f., .f.)
loRes.ActiveConnection = this.oactiveconnection
loRes.Cursor_Name = "cur_x"
loRes.OpenQuery(lcSql)

SELECT cur_afpivas
APPEND FROM DBF("cur_x")
loRes.Close_Query()

** Calculo el total de IVA.
This.fe_totiva = 0.00
SELECT cur_afpivas
GO TOP
DO WHILE !EOF("cur_afpivas")
	This.fe_totiva = this.fe_totiva + cur_afpivas.imp_iva
	
	SELECT cur_afpivas
	SKIP
ENDDO

SELECT cur_afpivas
GO TOP



ENDPROC
PROCEDURE crear_cursores_wsafip
****************************************************************************************
* Crea los cursores para almacenar la información que se necesita enviar a autorizar.
* Fecha: 20/12/2022
* Desarrollado por: Leonardo D. Zulli
****************************************************************************************

CREATE CURSOR cur_afpivas ( ;
	item_cant int,;
	indice_item int,;
	iva_id int,;
	alicIVA N(5, 2),;
	imp_base N(20, 2),;
	imp_iva N(20, 2))
	

ENDPROC
PROCEDURE validar_stock
*****************************************************************
* Este método permite validar si hay stock.
* Fecha: 30/01/2023
*****************************************************************
LPARAMETERS tnIdArticulo, tnCantidad

LOCAL lcSql
LOCAL loRes
LOCAL llResult
LOCAL lnDiferencia

loRes = CREATEOBJECT("odbc_result")
lcSql = ""
llResult = .f.

TEXT TO lcSql NOSHOW
	SELECT
		SUM(cantidad) AS existencia
	FROM
		stk_det
	WHERE
		idArticulo = ?xid
	GROUP BY
		idArticulo
ENDTEXT

lcSql = loRes.AddParameter(lcSql, "xid", ALLTRIM(STR(tnIdArticulo)), .f., .f.)
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"
loRes.OpenQuery(lcSql)

SELECT cur_x
lnDiferencia = cur_x.existencia - tnCantidad

IF lnDiferencia <= 0 THEN
	llResult = .f.
ELSE
	llResult = .t.
ENDIF

loRes.Close_Query()

RETURN llResult
ENDPROC
PROCEDURE grabar_movimientos_stock_c2
*********************************************************************
* Permite grabar el movmiento de stock para cuenta 2 como ajuste.
* Desarrollador: Leonardo D. Zulli
* Fecha: 10/02/2023
*********************************************************************

LOCAL lcSql
LOCAL loRes
LOCAL loResDeposito
LOCAL lcCmd
LOCAL lnProxID
LOCAL lnRegistro

lcSql = ""
loRes = CREATEOBJECT("odbc_result")
loResDeposito = CREATEOBJECT("odbc_result")
loCmd = CREATEOBJECT("odbc_command")

lnProxID = goConn.getNextID("stk_cab", "idStkCab")
goConn.BeginTransaction()

&& Grabo la cabecera

TEXT TO loCmd.CommandText NOSHOW
	INSERT INTO stk_cab (
		idStkCab, circuito, cbte, tipoDoc, numCbte, idCliente, usuAlta, fecAlta, idHostAlta)
	VALUES (
		?xidStkCab, 'S', 'AJU', NULL, NULL, NULL, ?xusuario, current_timestamp, ?xhost);	
ENDTEXT
loCmd.AddParameter("xidStkCab", ALLTRIM(STR(lnProxID)), .f., .f.)
loCmd.AddParameter("xusuario", ALLTRIM(gcCodUsu), .t., .f.)
loCmd.AddParameter("xhost", ALLTRIM(SYS(0)), .t., .f.)
loCmd.ActiveConnection = goConn.ActiveConnection

IF !loCmd.Execute() THEN
	this.error_message = "Error al grabar el movimiento de stock"
	goConn.Rollback()
	RETURN .F.
ENDIF

&& Recupero los datos de ventas
TEXT TO lcSql NOSHOW
	SELECT
		ventasdet.idVentasD, ventasdet.idArticulo,
		ventasdet.cantidad * -1 AS cantidad, articulos.costoRep, '' AS nroPart
	FROM
		ventasdet
			INNER JOIN articulos ON articulos.idArticulo = ventasdet.idArticulo
	WHERE
		ventasdet.idVentasC = ?xidVentaC
ENDTEXT

lcSql = loRes.AddParameter(lcSql, "xidVentaC", ALLTRIM(STR(This.idventasc)), .f., .f.)

loRes.ActiveConnection = this.oActiveConnection
loRes.Cursor_Name = "cur_vtadet"
loRes.OpenQuery(lcSql)

lnRegistro = 0
SELECT cur_vtadet
GO TOP
DO WHILE !EOF("cur_vtadet")
	TEXT TO lcSql NOSHOW
		SELECT
			idStkDep
		FROM
			art_dep
		WHERE
			art_dep.idArticulo = ?xidArticulo
	ENDTEXT
	lcSql = loResDeposito.addParameter(lcSql, "xidArticulo", ALLTRIM(STR(cur_vtadet.idArticulo)), .f., .f.)
	loResDeposito.ActiveConnection = goConn.ActiveConnection
	loResDeposito.Cursor_Name = "cur_deposito"
	loResDeposito.OpenQuery(lcSql)
	
	&& Acá tengo que grabar el detalle
	TEXT TO loCmd.CommandText NOSHOW
		INSERT INTO stk_det (
			idStkDet, idStkCab, idArticulo, idStkDep,
			tipoMov, cantidad, costoRep, nroPart)
		VALUES (
			?xidStkDet, ?xidStkCab, ?xidArticulo, ?xidStkDep,
			'SAL', ?xcantidad, ?xcostoRep, ?xnroPart)
	ENDTEXT
	loCmd.addParameter("xidStkDet", ALLTRIM(STR(lnRegistro)), .f., .f.)
	loCmd.addParameter("xidStkCab", ALLTRIM(STR(lnProxID)), .f., .f.)
	loCmd.addParameter("xidArticulo", ALLTRIM(STR(cur_vtadet.idArticulo)), .f., .f.)
	loCmd.addParameter("xidStkDep", ALLTRIM(STR(cur_deposito.idStkDep)), .f., .f.)
	loCmd.addParameter("xcantidad", ALLTRIM(STR(cur_vtadet.cantidad, 20, 2)), .f., .f.)
	loCmd.addParameter("xcostoRep", ALLTRIM(STR(cur_vtadet.costoRep, 20, 2)), .f., .f.)
	loCmd.addParameter("xnroPart", ALLTRIM(cur_vtadet.nroPart), .t., .f.)
	
	IF !loCmd.Execute() THEN
		this.error_message = loCmd.ErrorMessage
		goConn.Rollback()
		loRes.Close_Query()
		RETURN .F.
	ENDIF
	
	loResDeposito.Close_Query()
	SELECT cur_vtadet
	SKIP
ENDDO

loRes.Close_Query()

goConn.Commit()
RETURN .T.
ENDPROC
PROCEDURE calcular_importes_items
**********************************************************************************
* Permite calcular los subtotales del ítem tanto para cuando se agrega o modifica
* la cantidad del mismo.
* Fecha: 18/02/2023
* Desarrollo: Leonardo D. Zulli
**********************************************************************************
LPARAMETERS tnIdArticulo, tnCantidad, tlModificar

LOCAL loRes
LOCAL lcSql
LOCAL lcCodArt
LOCAL lcDescripcion
LOCAL lnAlicIVA
LOCAL llUsarImpuIn
LOCAL lnImpImInMay
LOCAL lnImpImInMin
LOCAL lnCostoRep
LOCAL lnPrVentaMayorista
LOCAL lnPrVentaMinorista
LOCAL lnPrVentaFinalMayorista
LOCAL lnPrVentaFinalMinorista
LOCAL lnPrecioUnitario
LOCAL lnImpDesc1
LOCAL lnTotNeto
LOCAL lnImpIVA
LOCAL lnSubTotal
LOCAL lnUniDesp
LOCAL lcCodUM

* Variales para manejar los impuestos internos.
LOCAL lnPorNoGrav
LOCAL lnBaseGrav
LOCAL lnSubtNoGrav

loRes = CREATEOBJECT("odbc_result")
lcSql = ""

lcCodArt = ""
lcDescripcion = ""
lcAlicIVA = ""
llUsarImpuIn = .F.
llImpImInMay = 0.00
llImpImInMin = 0.00
lnCostoRep = 0.00
lnPrVentaMayorista = 0.00
lnPrVentaMinorista = 0.00
lnPrVentaFinalMayorista = 0.00
lnPrVentaFinalMinorista = 0.00
lnPrecioUnitario = 0.00
lnImpDesc1 = 0.00
lnTotNeto = 0.00
lnImpIVA = 0.00
lnSubTotal = 0.00
lcCodUM = ""
lnUniDesp = 1.00 && Usar cuando incorpore las unidades de despacho

* Inicializo las variables de impuestos internos.
lnPorNoGrav = 0.00
lnBaseGrav = 0.00
lnSubtNoGrav = 0.00

* Recupero la información que necesito del artículo
TEXT TO lcSql NOSHOW
	SELECT
		art.idArticulo,
		art.codArt,
		art.descripcio,
		art.costoRep,
		art.alicIVA,
		art.usarImpuIn,
		art.porImpuIn,
		art.impImInMay,
		art.impImInMin,
		art.prventaMax,
		art.prventaMin,
		art.prfinalMax,
		art.prfinalMin,
		unidmed.codUM
	FROM
		articulos art
			INNER JOIN unidmed ON unidmed.idUniMed = art.idUniMed
	WHERE
		art.idArticulo = ?id
ENDTEXT
lcSql = loRes.AddParameter(lcSql, "id", ALLTRIM(STR(tnIdArticulo)), .f., .f.)
loRes.ActiveConnection = this.oActiveConnection
loRes.Cursor_Name = "cur_x"
loRes.OpenQuery(lcSql)

SELECT cur_x
lcCodArt = ALLTRIM(cur_x.codArt)
lcDescripcion = ALLTRIM(cur_x.descripcio)
lnCostoRep = cur_x.costoRep
lnAlicIVA = cur_x.alicIVA
llUsarImpuIn = cur_x.usarImpuIn
lnPorNoGrav = cur_x.porImpuIn
lnImpImInMay = cur_x.impImInMay
lnImpImInMin = cur_x.impImInMin
lnPrVentaMayorista = cur_x.prventaMax
lnPrVentaMinorista = cur_x.prventaMin
lnPrVentaFinalMayorista = cur_x.prfinalMax
lnPrVentaFinalMinorista = cur_x.prfinalMin
lcCodUM = ALLTRIM(cur_x.codUM)

loRes.Close_Query()

* Ahora tengo que realizar los cálculos

IF this.cliente_mayorista THEN
	* Si el cliente seleccionado es mayorista, hago los cálculos
	* en base a los precios mayoristas establecido en los artículos.
	lnPrecioUnitario = lnPrVentaMayorista
ELSE
	* Paso por acá si el cliente es minorista.
	lnPrecioUnitario = lnPrVentaMinorista
ENDIF

* Realizo los cálculos del ítem
lnImpDesc1 = lnPrecioUnitario * (This.cliente_descuento / 100)
lnPrecioUnitario = lnPrecioUnitario - lnImpDesc1
lnTotNeto = lnPrecioUnitario * tnCantidad
lnImpIVA = lnTotNeto * (lnAlicIVA / 100)
lnSubTotal = lnTotNeto + lnImpIVA

* Realizo los cálculos de impuestos internos.
* lnPorNoGrav lo levanto de la tabla artículos del campo porImpuIn y solo
* lo calculo si el artículo tiene marcado usar impuestos internos.
IF llUsarImpuIn THEN
	lnSubtNoGrav = ROUND(lnSubTotal * (lnPorNoGrav / 100), 2)
	lnBaseGrav = ROUND((lnSubTotal - lnSubtNoGrav) / (1 + (lnAlicIVA / 100)), 2)
	
	* Recalculo el IVA y el subtotal en base a los impuestos.
	lnTotNeto = lnBaseGrav
	lnImpIVA = lnTotNeto * (lnAlicIVA / 100)
	lnSubTotal = lnTotNeto + lnImpIVA	
ELSE
	lnBaseGrav = lnTotNeto
ENDIF

SELECT cur_items
IF !tlModificar THEN
	APPEND BLANK
ELSE
	LOCK()
ENDIF
REPLACE cur_items.idVentasD WITH This.idventasd
REPLACE cur_items.idArticulo WITH tnIdArticulo ADDITIVE
REPLACE cur_items.codArt WITH lcCodArt ADDITIVE
REPLACE cur_items.descripcio WITH lcDescripcion ADDITIVE
REPLACE cur_items.cantidad WITH tnCantidad ADDITIVE
REPLACE cur_items.costoRep WITH lnCostoRep ADDITIVE
REPLACE cur_items.prUnit WITH lnPrecioUnitario ADDITIVE
REPLACE cur_items.porDesc1 WITH This.cliente_descuento ADDITIVE
REPLACE cur_items.impDesc1 WITH lnImpDesc1 ADDITIVE
REPLACE cur_items.impNeto WITH lnPrecioUnitario ADDITIVE

* Esto lo tengo que retocar cuando incorpore los cáculos de los
* impuestos internos.
REPLACE cur_items.usarImpuIn WITH llUsarImpuIn ADDITIVE
REPLACE cur_items.impImInMay WITH lnImpImInMay ADDITIVE
REPLACE cur_items.impImInMin WITH lnImpImInMin ADDITIVE
REPLACE cur_items.porNoGrav WITH lnPorNoGrav ADDITIVE
REPLACE cur_items.baseGrav WITH lnBaseGrav ADDITIVE
REPLACE cur_items.subtNoGrav WITH lnSubtNoGrav ADDITIVE
REPLACE cur_items.totNeto WITH lnTotNeto ADDITIVE
REPLACE cur_items.alicIVA WITH lnAlicIVA ADDITIVE
REPLACE cur_items.impIVA WITH lnImpIVA ADDITIVE
REPLACE cur_items.subTotal WITH (lnSubTotal + lnSubtNoGrav) ADDITIVE

* Esto modificar cuando incorpore las ofertas.
REPLACE cur_items.esOferta WITH .F. ADDITIVE

* Modificar cuando incorpore los cálculos de las unidades de despacho.
REPLACE cur_items.uniDesp WITH lnUniDesp ADDITIVE
REPLACE cur_items.cantPack WITH tnCantidad ADDITIVE
REPLACE cur_items.codUM WITH lcCodUM ADDITIVE

IF tlModificar THEN
	UNLOCK
ENDIF

This.idventasd = This.idventasd + 1
ENDPROC
PROCEDURE Destroy
this.oConexionC2.close()
ENDPROC
PROCEDURE Init
**********************************************************
* Inicializo las propiedades que llevan valores por
* defecto
**********************************************************
LOCAL lcConnectionString

this.usuario = ALLTRIM(gcCodUsu)
this.host = SYS(0)
this.cbte = "FC"

* Por default establezaco la conexión a cuenta 1
this.oActiveConnection = goConn.ActiveConnection

lcConnectionString = getConfig("DMO_CC")
this.oConexionC2 = CREATEOBJECT("odbc_connect")
this.oConexionC2.ConnectionString = lcConnectionString

IF !this.oConexionC2.open() THEN
	MESSAGEBOX("Error al conectase a la base de datos", 0+48, "Error de conexión")
ENDIF
ENDPROC
PROCEDURE imprimir_ticket
******************************************************************
* Permite enviar el comprobante a la ticketeadora. 
******************************************************************

LOCAL lcSql
LOCAL loResCab
LOCAL loResCli
LOCAL loResItems
LOCAL loTicket

loTicket = CREATEOBJECT("cls_tickets")
loResCab = CREATEOBJECT("odbc_result")
loResCab.ActiveConnection = goConn.ActiveConnection
loResCab.Cursor_Name = "cur_cab"

TEXT TO lcSql NOSHOW
	CALL ventascab_getById (?xid)
ENDTEXT

lcSql = loRes.AddParameter(lcSql, "xid", ALLTRIM(STR(This.idventasc)), .f., .f.)

loResCab.OpenQuery(lcSql)

** Mando los datos de cabecera del comprobante.
SELECT cur_cab
loTicket.limpiar_datos()
loTicket.codigo_cbte = cur_cab.CodAfip
loTicket.leyenda = "FACTURA"
loTicket.letra = cur_cab.tipoDoc
loTicket.nro_cbte = cur_cab.numCbte
loTicket.fecha_cbte = cur_cab.fecEmision
loTicket.fecha_vencimiento = cur_cab.fecVto

** Cargo los datos del cliente en el ticket
loResCli = CREATEOBJECT("odbc_result")
TEXT TO lcSql NOSHOW
	SELECT t1.*, t2.codPostal, t2.descripcio AS 'localidad', t3.descripcio AS 'provincia', t4.descripcio AS 'pais',
		t5.descripcio AS 'tipo_iva'
	FROM 
		clientes t1
			INNER JOIN localid t2 ON t2.idLocalid = t1.idLocalid
			INNER JOIN provincias t3 ON t3.idProvin = t2.idProvin
			INNER JOIN paises t4 ON t4.idPais = t2.idPais
			INNER JOIN sitiva t5 ON t5.idSitIVA = t1.idSitIVA
	WHERE id_cliente = ?xid
ENDTEXT
lcSql = loResCli.AddParameter(lcSql, "xid", ALLTRIM(STR(cur_cab.id_cliente)), .f., .f.)
loResCli.Cursor_Name = "cur_cli"
loResCli.ActiveConnection = goConn.ActiveConnection
loResCli.OpenQuery(lcSql)
SELECT cur_cli

loTicket.nuemero_cliente = cur_cli.id_cliente
loTicket.razon_social = m.razSoc
loTicket.direccion = cur_cli.direccion
loTicket.codigo_postal = cur_cli.CodPostal
loTicket.localidad = cur_cli.localidad
loTicket.provincia = cur_cli.provincia
loTicket.tipo_iva = cur_cli.tipo_iva

loResCli.Close_Query()

loTicket.total_neto = cur_cab.impNeto
loTicket.imp_iva21 = cur_cab.impIVA21
loTicket.imp_iva105 = cur_cab.impIVA105
loTicket.total = cur_cab.totFact
loTicket.qr_image = cur_cab.aut_qr
loTicket.nro_cae = cur_cab.aut_CAE
loTicket.vto_cae = cur_cab.aut_CAE_vto
loTicket.motivo = cur_cab.aut_motivo

loResCab.Close_Query()

** Cargo los ítems al comprobante
loResItems = CREATEOBJECT("odbc_result")
TEXT TO lcSql NOSHOW
	SELECT	
		t2.codArt, t2.descripcio, t1.cantidad, t1.alicIVA, t1.impNeto, t1.totNeto
	FROM
		ventasdet t1
			INNER JOIN articulos t2 ON t1.idArticulo = t2.idArticulo
	WHERE
		ventasdet.idVentasC = ?xid;
ENDTEXT

lcSql = loRes.AddParameter(lcSql, "xid", ALLTRIM(STR(This.idventasc)), .f., .f.)
loResItems.cursor_name = "cur_detalle"
loResItems.ActiveConnection = goConn.ActiveConnection
loResItems.OpenQuery(lcSql)

SELECT cur_detalle
GO TOP
DO WHILE !EOF("cur_detalle")
	loTicket.add_item(cur_detalle.codArt, cur_detalle.descripcio, cur_detalle.cantidad, ;
		cur_detalle.alicIVA, cur_detalle.impNeto, cur_detalle.totNeto)
	
	SELECT cur_detalle
	SKIP
ENDDO

loResItems.Close_Query()

loTicket.imprimir()
ENDPROC


************************************************************
OBJETO: form_ingreso_factura
************************************************************
*** PROPIEDADES ***
Height = 674
Width = 1020
DoCreate = .T.
Caption = "Ventas"
obj_ventas = 
modo_edicion_items = .F.
oafip = 
Name = "form_ingreso_factura"
contenido.Anchor = 15
contenido.Top = 0
contenido.Left = 0
contenido.Width = 1020
contenido.Height = 698
contenido.TabIndex = 1
contenido.Name = "contenido"

*** METODOS ***
PROCEDURE configurar_grid
******************************************************
* Configuro la grilla de detalle
******************************************************

SELECT cur_items
Thisform.contenido.grid_item.alias_name = "cur_items"
Thisform.contenido.grid_item.RecordSource = "cur_items"
Thisform.contenido.grid_item.list_controlsource = "cantidad,codArt,descripcio,prUnit,impIVA,subTotal"
Thisform.contenido.grid_item.lista_ancho_cols = "70,250,400,120,120,120"
Thisform.contenido.grid_item.titulos_cabeceras = "Cant.,Código,Descripción,Pr. U.,I.V.A.,Total"

Thisform.contenido.grid_item.generar_grid()

ENDPROC
PROCEDURE blanquear_ingreso_items
********************************************************
* Blanquea los controles que se corresponden al ingreso
* de ítems.
********************************************************

Thisform.contenido.cnt_items.sel_articulos.blanquear()
Thisform.contenido.cnt_items.txtCantidad.Value = 1
Thisform.contenido.cnt_items.sel_articulos.txtCodigo.SetFocus()
ENDPROC
PROCEDURE blanquear
****************************************************************************
* Limpia la factura para cargar una nueva
****************************************************************************

Thisform.obj_ventas.vaciar_cursor_items()
Thisform.contenido.grid_item.Refresh()

Thisform.contenido.cnt_cabecera.sel_cliente.txtCodigo.Value = getGlobalCFG("CLI_CF")
Thisform.contenido.cnt_cabecera.sel_cliente.txtCodigo.LostFocus()

Thisform.contenido.cnt_items.sel_articulos.blanquear()
Thisform.contenido.txtTotal.Value = 0.00
Thisform.contenido.cnt_items.sel_articulos.txtCodigo.SetFocus()
ENDPROC
PROCEDURE cambiar_modo
*********************************************************
* Realiza el cambio al modo presupuesto o factura
*********************************************************

thisform.obj_ventas.cambiar_modo()
IF thisform.obj_ventas.modo_presupuesto THEN
	* Cambio color de fondo si esta en modo presupuesto
	thisform.contenido.BackColor = RGB(187,218,255)
ELSE
	* Vuelvo al color de fondo original si está en modo factura
	thisform.contenido.BackColor = RGB(241,236,235)
ENDIF

ENDPROC
PROCEDURE seleccionar_items
thisform.contenido.grid_item.SetFocus()
thisform.modo_edicion_items = .t.
ENDPROC
PROCEDURE set_ingreso_articulos
thisform.contenido.cnt_items.sel_articulos.txtCodigo.SetFocus()
thisform.modo_edicion_items = .f.
ENDPROC
PROCEDURE eliminar_item
**************************************************************************************
* Elimina un ítem siempre y cuando el usuario se haya posicionado en la grilla.
**************************************************************************************

IF thisform.modo_edicion_items THEN
	Thisform.obj_ventas.eliminar_item()
	Thisform.contenido.grid_item.Refresh()
	Thisform.contenido.txtTotal.Value = Thisform.obj_ventas.total_facturado
ELSE
	MESSAGEBOX("Antes de eliminar presione la tecla F2 para editar un ítem", 0+64, Thisform.Caption)
ENDIF
ENDPROC
PROCEDURE agregar_item
*************************************************************
* Agrego el ítem al salirse del foco.
*************************************************************
LOCAL llStockValido

IF getGlobalCFG("STK_MODULE") THEN
	* Si tengo el módulo de stock habilitado, entonces, valido stock
	llStockValido = Thisform.obj_ventas.validar_stock(;
		Thisform.contenido.cnt_items.sel_articulos.valcpoid, ;
		Thisform.contenido.cnt_items.txtCantidad.Value)

	IF !llStockValido THEN
		MESSAGEBOX("ATENCION: No hay stock disponible en el sistema, verifique el stock de este producto.", 0+64, Thisform.Caption)
	ENDIF
ENDIF

Thisform.obj_ventas.agregar_item( ;
	Thisform.contenido.cnt_items.sel_articulos.valcpoid, ;
	Thisform.contenido.cnt_items.txtCantidad.Value)

* Refresco la grilla
SELECT cur_items
Thisform.contenido.grid_item.Refresh()
Thisform.blanquear_ingreso_items()

Thisform.contenido.txtTotal.Value = Thisform.obj_ventas.total_facturado
Thisform.contenido.cnt_items.sel_articulos.txtCodigo.SetFocus()
ENDPROC
PROCEDURE asignar_datos_a_grabar
*******************************************************************************
* Este método permite llenar los datos del comprobante para enviarlos a la
* base de datos.
* Fecha: 15/10/2022
* Autor: Leonardo D. Zulli
*******************************************************************************
Thisform.obj_ventas.calcular_letra()
Thisform.obj_ventas.get_punto_venta()
Thisform.obj_ventas.get_condicion_pago()

* Limpio el cursor de cabecera
SELECT cur_ventascab
ZAP

* Asigno los datos de cabecera a grabar.
SELECT cur_ventascab
APPEND BLANK
REPLACE cur_ventascab.idCliente WITH clientes.idCliente
REPLACE cur_ventascab.idCondPago WITH clientes.idCondPago ADDITIVE
REPLACE cur_ventascab.idSitIVA WITH clientes.idSitIVA ADDITIVE
REPLACE cur_ventascab.idVendedor WITH clientes.idVendedor ADDITIVE
REPLACE cur_ventascab.cbte WITH Thisform.obj_ventas.cbte ADDITIVE
REPLACE cur_ventascab.tipoDoc WITH thisform.obj_ventas.tipoDoc ADDITIVE
REPLACE cur_ventascab.ptoVta WITH cur_talonario.ptoVta ADDITIVE

* Establezco fecha de emisión y calculo fecha de vencimiento.
REPLACE cur_ventascab.fecEmision WITH DATE() ADDITIVE
REPLACE cur_ventascab.fecVto WITH DATE() + cur_condpagos.cntDias ADDITIVE

* Se completa directamente desde el SP o cuando WSAFIP devuelve el número.
REPLACE cur_ventascab.numCbte WITH 0 ADDITIVE

REPLACE cur_ventascab.anulado WITH .F. ADDITIVE

* Estos campos están repetidos pero no los saco porque no sé que se usa
* en otro lado del sistema.
REPLACE cur_ventascab.impNeto WITH Thisform.obj_ventas.tot_imp_neto ADDITIVE
REPLACE cur_ventascab.impFinal WITH Thisform.obj_ventas.total_neto ADDITIVE

IF Thisform.obj_ventas.tot_impiva21 <> 0 THEN
	REPLACE cur_ventascab.porIVA21 WITH 21 ADDITIVE
	REPLACE cur_ventascab.impIVA21 WITH thisform.obj_ventas.tot_impiva21 ADDITIVE
ENDIF

IF Thisform.obj_ventas.tot_impiva105 <> 0 THEN
	REPLACE cur_ventascab.poriva105 WITH 10.5 ADDITIVE
	REPLACE cur_ventascab.impiva105 WITH thisform.obj_ventas.tot_impiva105 ADDITIVE
ENDIF

REPLACE cur_ventascab.porIIBB WITH 0 ADDITIVE
REPLACE cur_ventascab.impIIBB WITH 0 ADDITIVE

* Por ahora contemplo un solo descuento para la facturación de mostrador.
REPLACE cur_ventascab.porDesc1 WITH Thisform.obj_ventas.cliente_descuento ADDITIVE
REPLACE cur_ventascab.impDesc1 WITH Thisform.obj_ventas.tot_impdesc1 ADDITIVE

* Por ahora no contemplo porcentajes de rectados en este modo de facturación.
REPLACE cur_ventascab.porRec WITH 0 ADDITIVE
REPLACE cur_ventascab.impRec WITH 0 ADDITIVE

&& Calculo el total no gravado para el caso de impuestos
&& internos.
SELECT ;
	SUM(subtNoGrav) AS totaNoGrav ;
FROM ;
	cur_items ;
INTO CURSOR cur_totnogra

SELECT cur_totnogra
REPLACE cur_ventascab.totaNoGrav WITH cur_totnogra.totaNoGrav ADDITIVE
USE IN cur_totnogra

SELECT cur_ventascab
REPLACE cur_ventascab.totFact WITH this.obj_ventas.total_facturado ADDITIVE
REPLACE cur_ventascab.saldo WITH this.obj_ventas.total_facturado ADDITIVE

REPLACE cur_ventascab.esPendi WITH .F. ADDITIVE
REPLACE cur_ventascab.observ WITH "" ADDITIVE
REPLACE cur_ventascab.procesado WITH .F. ADDITIVE
REPLACE cur_ventascab.usuAlta WITH ALLTRIM(gcCodUsu) ADDITIVE
REPLACE cur_ventascab.fecAlta WITH DATETIME() ADDITIVE
REPLACE cur_ventascab.idHostAlta WITH SYS(0) ADDITIVE
REPLACE cur_ventascab.razSoc WITH clientes.razSoc ADDITIVE
REPLACE cur_ventascab.nroDoc WITH clientes.nroCUIT ADDITIVE
REPLACE cur_ventascab.idTipoDoc WITH clientes.idTipoDoc ADDITIVE

* Envío los ítems al a tabla temporal ventasdet_tmp
Thisform.obj_ventas.limpiar_tabla_temporal()
IF !Thisform.obj_ventas.enviar_items_a_temporal() THEN
	MESSAGEBOX(Thisform.error_message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

RETURN .T.
ENDPROC
PROCEDURE autorizar_en_afip
*********************************************************
* Este método permite autorizar el comprobante en AFIP.
* Fecha: 04/01/2023
* Desarrollado por: Leonardo D. Zulli
*********************************************************

LOCAL llResult

this.oafip.id_ventac = this.obj_ventas.idventasc
IF !this.oafip.autorizar_comprobante() THEN
	MESSAGEBOX(this.oafip.response_message, 0+48, Thisform.Caption)
	llResult = .F.
ELSE
	IF ALLTRIM(this.oafip.aut_resultado) == "A" THEN
		MESSAGEBOX(this.oafip.response_message, 0+64, Thisform.Caption)
	ELSE
		MESSAGEBOX(this.oafip.response_message, 0+48, Thisform.Caption)
	ENDIF
	llResult = .T.
ENDIF

RETURN llResult
ENDPROC
PROCEDURE modificar_cliente
*************************************************************************
* Cambiar cliente
*************************************************************************
Thisform.contenido.cnt_cabecera.sel_cliente.txtCodigo.SetFocus()

ENDPROC
PROCEDURE Init
****************************************************************
* Inicializo el formulario
****************************************************************
LOCAL lnIdClienteCF

Thisform.obj_ventas = CREATEOBJECT("cls_ventas_model")
This.oafip = CREATEOBJECT("cls_wsafip")
Thisform.obj_ventas.oActiveConnection = goConn.ActiveConnection
Thisform.obj_ventas.crear_cursores_auxiliares()
Thisform.obj_ventas.crear_cursor_cab()
Thisform.obj_ventas.crear_cursor_items()
Thisform.configurar_grid()

lnIdClienteCF = GetGlobalCFG("CLI_CF")
Thisform.contenido.cnt_cabecera.sel_cliente.txtCodigo.Value = lnIdClienteCF
Thisform.contenido.cnt_cabecera.sel_cliente.txtCodigo.LostFocus()

Thisform.contenido.cnt_items.txtCantidad.Value = 1
Thisform.contenido.cnt_items.sel_articulos.txtCodigo.SetFocus()
Thisform.contenido.cnt_items.txtCantidad.ReadOnly = .T.

ON KEY LABEL CTRL+P _screen.ActiveForm.cambiar_modo()
ON KEY LABEL DEL _screen.ActiveForm.eliminar_item()
ON KEY LABEL F2 _screen.ActiveForm.seleccionar_items()
ON KEY LABEL F3 _screen.ActiveForm.set_ingreso_articulos()
ON KEY LABEL F4 _screen.ActiveForm.modificar_cliente()
ON KEY LABEL F7 _screen.ActiveForm.blanquear()
ON KEY LABEL F8 _screen.ActiveForm.grabar()

* Estado de pantalla maximizado
Thisform.WindowState = 2
ENDPROC
PROCEDURE grabar
*******************************************************************************
* Este método permite grabar el comprobante.
*******************************************************************************
Thisform.asignar_datos_a_grabar()
IF !Thisform.Obj_ventas.grabar() THEN
	MESSAGEBOX("No se pudo grabar el comprobante", 0+48, Thisform.Caption)
ELSE
	* Verifico si estoy en modo presupuesto. En caso de estarlo no envío a autorizar
	* nada.
	IF Thisform.obj_ventas.modo_presupuesto THEN
		* Genero el movimiento de cuentas corrientes en cuenta 2.
		Thisform.obj_ventas.grabar_movimiento_ctacte()
		IF getGlobalCFG("STK_MODULE") THEN
			IF !Thisform.obj_ventas.grabar_movimientos_stock_c2() THEN
				MESSAGEBOX(Thisform.obj_ventas.error_message, 0+48, Thisform.Caption)
			ENDIF
		ENDIF
			
		MESSAGEBOX("El comprobante se grabó satisfactoriamente", 0+64, Thisform.Caption)
	ELSE
		IF Thisform.autorizar_en_afip() THEN
			* Actualizo los datos del AFIP en el comprobante.
			Thisform.obj_ventas.idventasc = this.oafip.id_ventac
			Thisform.obj_ventas.ptovta = this.oafip.punto_venta
			Thisform.obj_ventas.numCbte = this.oafip.aut_numero
			Thisform.obj_ventas.aut_cae = this.oafip.aut_cae
			Thisform.obj_ventas.aut_cae_vto = this.oafip.aut_cae_vto
			Thisform.obj_ventas.aut_resultado = this.oafip.aut_resultado
			Thisform.obj_ventas.aut_motivo = this.oafip.aut_motivo
			Thisform.obj_ventas.aut_tipocbte = this.oafip.fe_tipocbte
			Thisform.obj_ventas.aut_qr = This.oafip.qr_path + This.oafip.qr_file_image
			Thisform.obj_ventas.set_cae()
			
			* Genero el movimiento de cuentas corrientes en cuenta 1.
			Thisform.obj_ventas.grabar_movimiento_ctacte()
			IF getGlobalCFG("STK_MODULE") THEN
				Thisform.obj_ventas.grabar_movimientos_stock()
			ENDIF
			
			* En este punto tengo que enviar a imprimir
			* el comprobante.
			thisform.obj_ventas.imprimir_ticket()
		ENDIF
	ENDIF
ENDIF

thisform.blanquear()
ENDPROC


************************************************************
OBJETO: cnt_instrucciones
************************************************************
*** PROPIEDADES ***
Anchor = 14
Top = 611
Left = 5
Width = 1011
Height = 61
BackStyle = 1
BackColor = 255,255,198
Name = "cnt_instrucciones"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
FontSize = 10
FontUnderline = .F.
Anchor = 6
Caption = "[F2]: Ir a la grilla"
Height = 17
Left = 8
Top = 40
Width = 107
ForeColor = 0,128,0
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
FontSize = 10
FontUnderline = .F.
Anchor = 6
Caption = "[Supr]: Eliminar ítem"
Height = 17
Left = 135
Top = 40
Width = 133
ForeColor = 0,128,0
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
FontSize = 10
FontUnderline = .F.
Anchor = 6
Caption = "[F3]: Ir a ingreso artículo"
Height = 17
Left = 293
Top = 40
Width = 160
ForeColor = 0,128,0
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
FontSize = 10
FontUnderline = .F.
Anchor = 6
Caption = "[F7]: Nuevo"
Height = 17
Left = 635
Top = 40
Width = 74
ForeColor = 0,128,0
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
FontSize = 10
FontUnderline = .F.
Anchor = 6
Caption = "[F8]: Grabar y emitir comprobante"
Height = 17
Left = 726
Top = 40
Width = 221
ForeColor = 0,128,0
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta6
************************************************************
*** PROPIEDADES ***
FontSize = 10
FontUnderline = .F.
Anchor = 6
Caption = "[F4]: Cambiar cliente"
Height = 17
Left = 476
Top = 40
Width = 137
ForeColor = 0,128,0
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta7
************************************************************
*** PROPIEDADES ***
FontSize = 10
FontUnderline = .F.
Anchor = 6
Caption = 'La cantidad de un artículo se puede modificar presionando F2 para ir a la grilla e ingresando la cantidad en la columna "cantidad" del artículo seleccionado.'
Height = 17
Left = 4
Top = 7
Width = 1004
ForeColor = 0,128,0
Name = "Clsetiqueta7"

*** METODOS ***


************************************************************
OBJETO: cnt_items
************************************************************
*** PROPIEDADES ***
Anchor = 11
Top = 79
Left = 5
Width = 1011
Height = 102
BackStyle = 1
TabIndex = 2
BackColor = 255,255,255
Name = "cnt_items"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
FontSize = 12
Anchor = 3
Caption = "Artículo"
Height = 22
Left = 10
Top = 34
Width = 144
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: sel_articulos
************************************************************
*** PROPIEDADES ***
Anchor = 3
Top = 57
Left = 9
Width = 730
Height = 36
nombre_campo_codigo = codArt
nombre_campo_desc = descripcio
nombre_tabla = articulos
pkfield = idArticulo
criterio_filtro = habilitado = 1
Name = "sel_articulos"
txtCodigo.FontSize = 12
txtCodigo.Height = 29
txtCodigo.Left = 2
txtCodigo.Top = 2
txtCodigo.Width = 196
txtCodigo.Name = "txtCodigo"
txtDescripcion.FontSize = 12
txtDescripcion.Height = 29
txtDescripcion.Left = 201
txtDescripcion.Top = 2
txtDescripcion.Width = 527
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***
PROCEDURE recuperar_datos
IF This.valcpoid <> 0 THEN
	Thisform.agregar_item()
ENDIF

ENDPROC
PROCEDURE txtCodigo.InteractiveChange
* Si presiona * (aterisco) paso el número a la cantidad.
IF ATC("*", This.Value) <> 0 THEN
	Thisform.contenido.cnt_items.txtCantidad.Value = VAL(This.Value)
	This.blanquear()
	This.SetFocus()
ENDIF
ENDPROC
PROCEDURE txtCodigo.LostFocus
* Pruebo agregar la búsqueda en codiart desde acá.
LOCAL loRes
LOCAL lcSql

loRes = CREATEOBJECT("odbc_result")
TEXT TO lcSql NOSHOW
	SELECT
		codiart.idArticulo,
		codiart.codArt,
		codiart.cantiDesp
	FROM
		codiart
	WHERE
		codiart.codigos = ?xidArticulo AND
		(codiart.circuito = 'V' OR codiart.circuito = 'CV')
ENDTEXT

lcSql = loRes.AddParameter(lcSql, "xidArticulo", ALLTRIM(this.Value), .t., .f.)
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"
loRes.OpenQuery(lcSql)

SELECT cur_x
GO TOP
IF RECCOUNT("cur_x") = 1 THEN
	this.Value = cur_x.codArt
	loRes.close_query()
	DODEFAULT()
	RETURN .F.
ELSE
	this.Value = cur_x.codArt
	DODEFAULT()
	RETURN .F.
ENDIF

IF RECCOUNT("cur_x") = 0 THEN
	DODEFAULT()
ENDIF

RETURN .T.



ENDPROC


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
FontSize = 12
Anchor = 3
Caption = "Detalles"
Height = 22
Left = 7
Top = 4
Width = 168
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
FontSize = 12
Anchor = 3
Caption = "Cantidad"
Height = 22
Left = 759
Top = 34
Width = 89
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
FontSize = 12
Caption = "Precio"
Height = 22
Left = 895
Top = 34
Width = 65
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: txtCantidad
************************************************************
*** PROPIEDADES ***
FontSize = 12
Anchor = 3
Height = 29
Left = 754
Top = 59
Width = 109
isnumeric = .T.
Name = "txtCantidad"

*** METODOS ***
PROCEDURE GotFocus
This.Parent.sel_articulos.txtCodigo.SetFocus()
ENDPROC


************************************************************
OBJETO: txtPrecio
************************************************************
*** PROPIEDADES ***
FontSize = 12
Anchor = 3
Height = 29
Left = 866
ReadOnly = .T.
Top = 59
Width = 109
isnumeric = .T.
Name = "txtPrecio"

*** METODOS ***


************************************************************
OBJETO: grid_item
************************************************************
*** PROPIEDADES ***
FontSize = 12
FontUnderline = .F.
Anchor = 15
Height = 364
Left = 5
RowHeight = 23
TabIndex = 3
Top = 184
Width = 1011
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grid_item"
COLUMN1.Header1.FontSize = 12
COLUMN1.Header1.FontUnderline = .F.
COLUMN1.Header1.Name = "Header1"
COLUMN1.Text1.FontSize = 12
COLUMN1.Text1.FontUnderline = .F.
COLUMN1.Text1.ReadOnly = .F.
COLUMN1.Text1.Name = "Text1"
COLUMN1.FontSize = 12
COLUMN1.FontUnderline = .F.
COLUMN1.ReadOnly = .F.
COLUMN1.Name = "COLUMN1"
COLUMN2.Header1.FontSize = 12
COLUMN2.Header1.FontUnderline = .F.
COLUMN2.Header1.Name = "Header1"
COLUMN2.Text1.FontSize = 12
COLUMN2.Text1.FontUnderline = .F.
COLUMN2.Text1.Name = "Text1"
COLUMN2.FontSize = 12
COLUMN2.FontUnderline = .F.
COLUMN2.Name = "COLUMN2"
COLUMN3.Header1.FontSize = 12
COLUMN3.Header1.FontUnderline = .F.
COLUMN3.Header1.Name = "Header1"
COLUMN3.Text1.FontSize = 12
COLUMN3.Text1.FontUnderline = .F.
COLUMN3.Text1.Name = "Text1"
COLUMN3.FontSize = 12
COLUMN3.FontUnderline = .F.
COLUMN3.Name = "COLUMN3"
COLUMN4.Header1.FontSize = 12
COLUMN4.Header1.FontUnderline = .F.
COLUMN4.Header1.Name = "Header1"
COLUMN4.Text1.FontSize = 12
COLUMN4.Text1.FontUnderline = .F.
COLUMN4.Text1.Name = "Text1"
COLUMN4.FontSize = 12
COLUMN4.FontUnderline = .F.
COLUMN4.Name = "COLUMN4"
COLUMN5.Header1.FontSize = 12
COLUMN5.Header1.FontUnderline = .F.
COLUMN5.Header1.Name = "Header1"
COLUMN5.Text1.FontSize = 12
COLUMN5.Text1.FontUnderline = .F.
COLUMN5.Text1.Name = "Text1"
COLUMN5.FontSize = 12
COLUMN5.FontUnderline = .F.
COLUMN5.Name = "COLUMN5"
COLUMN6.Header1.FontSize = 12
COLUMN6.Header1.FontUnderline = .F.
COLUMN6.Header1.Name = "Header1"
COLUMN6.Text1.FontSize = 12
COLUMN6.Text1.FontUnderline = .F.
COLUMN6.Text1.Name = "Text1"
COLUMN6.FontSize = 12
COLUMN6.FontUnderline = .F.
COLUMN6.Name = "COLUMN6"
COLUMN7.Header1.FontSize = 12
COLUMN7.Header1.FontUnderline = .F.
COLUMN7.Header1.Name = "Header1"
COLUMN7.Text1.FontSize = 12
COLUMN7.Text1.FontUnderline = .F.
COLUMN7.Text1.Name = "Text1"
COLUMN7.FontSize = 12
COLUMN7.FontUnderline = .F.
COLUMN7.Name = "COLUMN7"
COLUMN8.Header1.FontSize = 12
COLUMN8.Header1.FontUnderline = .F.
COLUMN8.Header1.Name = "Header1"
COLUMN8.Text1.FontSize = 12
COLUMN8.Text1.FontUnderline = .F.
COLUMN8.Text1.Name = "Text1"
COLUMN8.FontSize = 12
COLUMN8.FontUnderline = .F.
COLUMN8.Name = "COLUMN8"
COLUMN9.Header1.FontSize = 12
COLUMN9.Header1.FontUnderline = .F.
COLUMN9.Header1.Name = "Header1"
COLUMN9.Text1.FontSize = 12
COLUMN9.Text1.FontUnderline = .F.
COLUMN9.Text1.Name = "Text1"
COLUMN9.FontSize = 12
COLUMN9.FontUnderline = .F.
COLUMN9.Name = "COLUMN9"
COLUMN10.Header1.FontSize = 12
COLUMN10.Header1.FontUnderline = .F.
COLUMN10.Header1.Name = "Header1"
COLUMN10.Text1.FontSize = 12
COLUMN10.Text1.FontUnderline = .F.
COLUMN10.Text1.Name = "Text1"
COLUMN10.FontSize = 12
COLUMN10.FontUnderline = .F.
COLUMN10.Name = "COLUMN10"
COLUMN11.Header1.FontSize = 12
COLUMN11.Header1.FontUnderline = .F.
COLUMN11.Header1.Name = "Header1"
COLUMN11.Text1.FontSize = 12
COLUMN11.Text1.FontUnderline = .F.
COLUMN11.Text1.Name = "Text1"
COLUMN11.FontSize = 12
COLUMN11.FontUnderline = .F.
COLUMN11.Name = "COLUMN11"
COLUMN12.Header1.FontSize = 12
COLUMN12.Header1.FontUnderline = .F.
COLUMN12.Header1.Name = "Header1"
COLUMN12.Text1.FontSize = 12
COLUMN12.Text1.FontUnderline = .F.
COLUMN12.Text1.Name = "Text1"
COLUMN12.FontSize = 12
COLUMN12.FontUnderline = .F.
COLUMN12.Name = "COLUMN12"
COLUMN13.Header1.FontSize = 12
COLUMN13.Header1.FontUnderline = .F.
COLUMN13.Header1.Name = "Header1"
COLUMN13.Text1.FontSize = 12
COLUMN13.Text1.FontUnderline = .F.
COLUMN13.Text1.Name = "Text1"
COLUMN13.FontSize = 12
COLUMN13.FontUnderline = .F.
COLUMN13.Name = "COLUMN13"
COLUMN14.Header1.FontSize = 12
COLUMN14.Header1.FontUnderline = .F.
COLUMN14.Header1.Name = "Header1"
COLUMN14.Text1.FontSize = 12
COLUMN14.Text1.FontUnderline = .F.
COLUMN14.Text1.Name = "Text1"
COLUMN14.FontSize = 12
COLUMN14.FontUnderline = .F.
COLUMN14.Name = "COLUMN14"
COLUMN15.Header1.FontSize = 12
COLUMN15.Header1.FontUnderline = .F.
COLUMN15.Header1.Name = "Header1"
COLUMN15.Text1.FontSize = 12
COLUMN15.Text1.FontUnderline = .F.
COLUMN15.Text1.Name = "Text1"
COLUMN15.FontSize = 12
COLUMN15.FontUnderline = .F.
COLUMN15.Name = "COLUMN15"
COLUMN16.Header1.FontSize = 12
COLUMN16.Header1.FontUnderline = .F.
COLUMN16.Header1.Name = "Header1"
COLUMN16.Text1.FontSize = 12
COLUMN16.Text1.FontUnderline = .F.
COLUMN16.Text1.Name = "Text1"
COLUMN16.FontSize = 12
COLUMN16.FontUnderline = .F.
COLUMN16.Name = "COLUMN16"
COLUMN17.Header1.FontSize = 12
COLUMN17.Header1.FontUnderline = .F.
COLUMN17.Header1.Name = "Header1"
COLUMN17.Text1.FontSize = 12
COLUMN17.Text1.FontUnderline = .F.
COLUMN17.Text1.Name = "Text1"
COLUMN17.FontSize = 12
COLUMN17.FontUnderline = .F.
COLUMN17.Name = "COLUMN17"
COLUMN18.Header1.FontSize = 12
COLUMN18.Header1.FontUnderline = .F.
COLUMN18.Header1.Name = "Header1"
COLUMN18.Text1.FontSize = 12
COLUMN18.Text1.FontUnderline = .F.
COLUMN18.Text1.Name = "Text1"
COLUMN18.FontSize = 12
COLUMN18.FontUnderline = .F.
COLUMN18.Name = "COLUMN18"
COLUMN19.Header1.FontSize = 12
COLUMN19.Header1.FontUnderline = .F.
COLUMN19.Header1.Name = "Header1"
COLUMN19.Text1.FontSize = 12
COLUMN19.Text1.FontUnderline = .F.
COLUMN19.Text1.Name = "Text1"
COLUMN19.FontSize = 12
COLUMN19.FontUnderline = .F.
COLUMN19.Name = "COLUMN19"
COLUMN20.Header1.FontSize = 12
COLUMN20.Header1.FontUnderline = .F.
COLUMN20.Header1.Name = "Header1"
COLUMN20.Text1.FontSize = 12
COLUMN20.Text1.FontUnderline = .F.
COLUMN20.Text1.Name = "Text1"
COLUMN20.FontSize = 12
COLUMN20.FontUnderline = .F.
COLUMN20.Name = "COLUMN20"

*** METODOS ***
PROCEDURE KeyPress
LPARAMETERS nKeyCode, nShiftAltCtrl
ENDPROC
PROCEDURE COLUMN1.Text1.Valid
SELECT cur_items
Thisform.obj_ventas.modificar_item(cur_items.idArticulo, cur_items.cantidad)
Thisform.obj_ventas.calcular_totales()
Thisform.contenido.grid_item.Refresh()
Thisform.contenido.txtTotal.Value = Thisform.obj_ventas.total_facturado


ENDPROC


************************************************************
OBJETO: cnt_cabecera
************************************************************
*** PROPIEDADES ***
Anchor = 11
Top = 7
Left = 5
Width = 1010
Height = 70
BackStyle = 1
TabIndex = 1
BackColor = 255,255,255
Name = "cnt_cabecera"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
FontSize = 12
Anchor = 3
Caption = "Cliente"
Height = 22
Left = 10
Top = 7
Width = 144
TabIndex = 4
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: sel_cliente
************************************************************
*** PROPIEDADES ***
Anchor = 3
Top = 30
Left = 9
Width = 826
Height = 36
TabIndex = 1
cfieldname = idcliente
esnumerico = .T.
pkfield = idcliente
nombre_tabla = clientes
criterio_filtro = fecBaja IS NULL AND habilitado = 1
nombre_campo_codigo = idCliente
nombre_campo_desc = razSoc
Name = "sel_cliente"
txtCodigo.FontSize = 12
txtCodigo.Height = 29
txtCodigo.Left = 2
txtCodigo.Top = 2
txtCodigo.Width = 196
txtCodigo.Name = "txtCodigo"
txtDescripcion.FontSize = 12
txtDescripcion.Height = 29
txtDescripcion.Left = 201
txtDescripcion.Top = 2
txtDescripcion.Width = 613
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***
PROCEDURE recuperar_datos
************************************************************
* Recupero los datos que necesito del cliente.
************************************************************
Thisform.obj_ventas.setCliente(This.valcpoid)
ENDPROC


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
FontSize = 12
Anchor = 9
Caption = "Descuento"
Height = 22
Left = 866
Top = 7
Width = 107
TabIndex = 6
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: txtDescuento
************************************************************
*** PROPIEDADES ***
FontSize = 12
Anchor = 9
Height = 29
Left = 867
TabIndex = 2
Top = 32
Width = 109
isnumeric = .T.
Name = "txtDescuento"

*** METODOS ***
PROCEDURE calcular
*********************************************************
* Cargo el descuento del cliente en el modelo
*********************************************************
Thisform.obj_ventas.cliente_descuento = This.Value
ENDPROC


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
FontSize = 12
Anchor = 12
Caption = "Total"
Height = 22
Left = 817
Top = 557
Width = 43
TabIndex = 9
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: txtTotal
************************************************************
*** PROPIEDADES ***
FontSize = 12
Anchor = 12
Height = 29
Left = 867
ReadOnly = .T.
TabIndex = 8
Top = 553
Width = 148
isnumeric = .T.
Name = "txtTotal"

*** METODOS ***


************************************************************
OBJETO: btnGrabar
************************************************************
*** PROPIEDADES ***
Top = 550
Left = 53
Anchor = 6
TabIndex = 7
Name = "btnGrabar"

*** METODOS ***
PROCEDURE Click
***********************************************
* Ejecuta la grabación del comprobante.
***********************************************
Thisform.grabar()
ENDPROC


************************************************************
OBJETO: btnNuevo
************************************************************
*** PROPIEDADES ***
Top = 550
Left = 6
Anchor = 6
TabIndex = 6
Name = "btnNuevo"

*** METODOS ***
PROCEDURE Click
Thisform.blanquear()
ENDPROC


************************************************************
OBJETO: form_ingreso_factura
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 12, 8, 20, 15, 42, 4, 1

*** METODOS ***


