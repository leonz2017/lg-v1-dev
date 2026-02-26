************************************************************
OBJETO: cls_frm_chequear_autorizados
************************************************************
*** PROPIEDADES ***
BorderStyle = 2
Height = 543
Width = 934
DoCreate = .T.
Caption = "Consultar comprobante desde ARCA"
o_arca_service = 
ptovta = 0
tipocbte = 0
nro_cbte = 
Name = "cls_frm_chequear_autorizados"

*** METODOS ***
PROCEDURE consultar_comprobante
******************************************************************************
* Permite consultar el comprobante directamente en ARCA.
******************************************************************************
LOCAL loData, lcFecha, lcNroCbte

This.o_arca_service.crear_cursores()
loData = This.o_arca_service.consultar_comprobante(This.ptovta, This.tipocbte, This.nro_cbte)

IF ISNULL(This.o_arca_service.consultar_comprobante(This.ptovta, This.tipocbte, This.nro_cbte)) THEN
	MESSAGEBOX(This.o_arca_service.error_message, 0+48, Thisform.Caption)
ENDIF

&& Recuperar datos

IF VARTYPE(loData) # "O" THEN
	MESSAGEBOX(This.o_arca_service.error_message, 0+48, Thisform.Caption)
	RETURN
ENDIF

Thisform.txtNroCAE.Value = loData.cae

lcFecha = loData.fecha_cbte
Thisform.txtFechaCbte.Value = Date(Val(Left(lcFecha,4)), Val(Substr(lcFecha,5,2)), Val(Right(lcFecha,2)))

lcFecha = loData.vto_cae
Thisform.txtFecVtoCAE.Value = Date(Val(Left(lcFecha,4)), Val(Substr(lcFecha,5,2)), Val(Right(lcFecha,2)))

Thisform.txtImporteFactura.Value = loData.importe
Thisform.txtTipoEmision.Value = loData.tipo_emision
Thisform.txtResultado.Value = loData.resultado

lcNroCbte = "(" + PADL(ALLTRIM(STR(loData.cbte_tipo)), 2, "0") + ") "
lcNroCbte = lcNroCbte + PADL(ALLTRIM(STR(loData.punto_vta)), 5, "0") + "-"
lcNroCbte = lcNroCbte + PADL(ALLTRIM(TRANSFORM(loData.doc_nro)), 8, "0")

Thisform.txtNroCbte.Value = lcNroCbte
Thisform.txtImporteNeto.Value = loData.imp_neto
Thisform.txtImpIva.Value = loData.imp_iva
Thisform.txtImporteExento.Value = loData.imp_op_ex
Thisform.txtConceptosNoGravados.Value = loData.imp_tot_conc
Thisform.txtOtrosTributos.value = loData.imp_trib



ENDPROC
PROCEDURE cargar_datos
******************************************************************
* Inicializo formulario
******************************************************************

This.o_arca_service = CREATEOBJECT("cls_arca_service")
This.consultar_comprobante()

&& Inicializo la grilla para mostrar el detalle de IVAS
SELECT cur_detalle_iva
Thisform.pgf.page1.grd_detalle_iva.alias_name = "cur_detalle_iva"
Thisform.pgf.page1.grd_detalle_iva.RecordSource = "cur_detalle_iva"
Thisform.pgf.page1.grd_detalle_iva.list_controlsource = "baseimp,ivaimp"
Thisform.pgf.page1.grd_detalle_iva.lista_ancho_cols = "100, 100"
Thisform.pgf.page1.grd_detalle_iva.titulos_cabeceras = "Base Imponible, Importe I.V.A."
Thisform.pgf.page1.grd_detalle_iva.generar_grid()

&& Inicializo la grilla para mostrar el detalle de impuestos internos.
SELECT cur_detalle_trib
Thisform.pgf.page2.grd_detalle_otros_tributos.alias_name = "cur_detalle_trib"
Thisform.pgf.page2.grd_detalle_otros_tributos.RecordSource = "cur_detalle_trib"
Thisform.pgf.page2.grd_detalle_otros_tributos.list_controlsource = "descripcio,baseimp,alicuota,importe"
Thisform.pgf.page2.grd_detalle_otros_tributos.lista_ancho_cols = "200,100,100,100"
Thisform.pgf.page2.grd_detalle_otros_tributos.titulos_cabeceras = "Descripción,Base Imp.,Alícuota,Importe"
Thisform.pgf.page2.grd_detalle_otros_tributos.generar_grid()
ENDPROC
PROCEDURE Destroy
*********************************************************************
* Destruyo los objetos creados en la RAM
*********************************************************************

This.o_arca_service = NULL
ENDPROC


************************************************************
OBJETO: pgf
************************************************************
*** PROPIEDADES ***
ErasePage = .T.
Top = 125
Left = 12
Width = 912
Height = 367
Name = "pgf"
PAGE1.Caption = "Detalle IVA"
PAGE1.Name = "PAGE1"
PAGE2.Caption = "Detalle Otros Tributos"
PAGE2.Name = "PAGE2"

*** METODOS ***


************************************************************
OBJETO: grd_detalle_iva
************************************************************
*** PROPIEDADES ***
Height = 327
Left = 9
Top = 4
Width = 893
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grd_detalle_iva"
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
OBJETO: grd_detalle_otros_tributos
************************************************************
*** PROPIEDADES ***
Height = 327
Left = 8
Top = 4
Width = 893
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grd_detalle_otros_tributos"
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
Top = 495
Left = 878
Name = "CLSCERRAR1"

*** METODOS ***


************************************************************
OBJETO: CLSETIQUETA1
************************************************************
*** PROPIEDADES ***
Caption = "Comprobante:"
Height = 15
Left = 49
Top = 12
Width = 83
Name = "CLSETIQUETA1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Número de C.A.E.:"
Height = 15
Left = 603
Top = 12
Width = 104
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Vencimiento C.A.E.:"
Height = 15
Left = 23
Top = 35
Width = 113
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Resultado:"
Height = 15
Left = 265
Top = 35
Width = 70
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Total Facturado:"
Height = 15
Left = 703
Top = 97
Width = 89
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta6
************************************************************
*** PROPIEDADES ***
Caption = "Tipo de emisión:"
Height = 15
Left = 377
Top = 35
Width = 96
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta7
************************************************************
*** PROPIEDADES ***
Caption = "Fecha Comprobante:"
Height = 15
Left = 355
Top = 12
Width = 124
Name = "Clsetiqueta7"

*** METODOS ***


************************************************************
OBJETO: txtNroCbte
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 135
ReadOnly = .T.
Top = 8
Width = 214
ischaracter = .T.
Name = "txtNroCbte"

*** METODOS ***


************************************************************
OBJETO: txtFechaCbte
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 473
ReadOnly = .T.
Top = 8
Width = 124
isdatetime = .T.
Name = "txtFechaCbte"

*** METODOS ***


************************************************************
OBJETO: txtNroCAE
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 704
ReadOnly = .T.
Top = 8
Width = 221
ischaracter = .T.
Name = "txtNroCAE"

*** METODOS ***


************************************************************
OBJETO: txtFecVtoCAE
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 135
ReadOnly = .T.
Top = 31
Width = 124
isdatetime = .T.
Name = "txtFecVtoCAE"

*** METODOS ***


************************************************************
OBJETO: txtResultado
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 329
ReadOnly = .T.
Top = 31
Width = 37
ischaracter = .T.
Name = "txtResultado"

*** METODOS ***


************************************************************
OBJETO: txtImporteFactura
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 796
ReadOnly = .T.
Top = 93
Width = 124
isnumeric = .T.
Name = "txtImporteFactura"

*** METODOS ***


************************************************************
OBJETO: txtTipoEmision
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 473
ReadOnly = .T.
Top = 31
Width = 103
ischaracter = .T.
Name = "txtTipoEmision"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta8
************************************************************
*** PROPIEDADES ***
Caption = "Importe Neto:"
Height = 15
Left = 53
Top = 58
Width = 79
Name = "Clsetiqueta8"

*** METODOS ***


************************************************************
OBJETO: txtImporteNeto
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 135
ReadOnly = .T.
Top = 54
Width = 124
isnumeric = .T.
Name = "txtImporteNeto"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta9
************************************************************
*** PROPIEDADES ***
Caption = "Imp. I.V.A.:"
Height = 15
Left = 266
Top = 58
Width = 63
Name = "Clsetiqueta9"

*** METODOS ***


************************************************************
OBJETO: txtImpIva
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 330
ReadOnly = .T.
Top = 54
Width = 124
isnumeric = .T.
Name = "txtImpIva"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta10
************************************************************
*** PROPIEDADES ***
Caption = "Imp. Exento:"
Height = 15
Left = 458
Top = 58
Width = 70
Name = "Clsetiqueta10"

*** METODOS ***


************************************************************
OBJETO: txtImporteExento
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 528
ReadOnly = .T.
Top = 54
Width = 124
isnumeric = .T.
Name = "txtImporteExento"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta11
************************************************************
*** PROPIEDADES ***
Caption = "Conceptos no gravados:"
Height = 15
Left = 657
Top = 58
Width = 139
Name = "Clsetiqueta11"

*** METODOS ***


************************************************************
OBJETO: txtConceptosNoGravados
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 796
ReadOnly = .T.
Top = 54
Width = 124
isnumeric = .T.
Name = "txtConceptosNoGravados"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta12
************************************************************
*** PROPIEDADES ***
Caption = "Otros Tributos:"
Height = 15
Left = 46
Top = 81
Width = 86
Name = "Clsetiqueta12"

*** METODOS ***


************************************************************
OBJETO: txtOtrosTributos
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 135
ReadOnly = .T.
Top = 77
Width = 124
isnumeric = .T.
Name = "txtOtrosTributos"

*** METODOS ***


************************************************************
OBJETO: cls_frm_chequear_autorizados
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


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
	
	IF This.id_ventasc = 0 THEN
		This.error_message = "El Id. de venta no se encuentra definido"
		THROW CREATEOBJECT("Exception")
	ENDIF

	IF !This.ws_iniciar() THEN
		THROW CREATEOBJECT("Exception")
	ENDIF
	
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

	&& Llama al método que configura las rutas de XMLs y QR
	This.ws_configurar_rutas()
		
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
	
	&& Llamo al método que permite setear los parámetros para QR
	This.ws_set_qr_parametros()

	llRes = This.fe.f1CAESolicitar()
	
	IF !This.ws_get_respuesta(llRes, lnPtoVta) THEN
		THROW CREATEOBJECT("Exception")
	ENDIF
	
	llOk = .T.
CATCH TO oException
	IF oException.ErrorNo = 2071 THEN
		This.error_message = "No se pudo establecer la comunicación con el webservice. Posiblemente ARCA no esté disponible o verifique su conexión a internet"
	ELSE
		This.error_message = getErrorForCatch(oException)
	ENDIF
	
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
PROCEDURE consultar_comprobante
LPARAMETERS tnPtoVta, tnTipoCbte, tcNroCbte

LOCAL lnModo, lcCUIT, lcCertif, loData, i, llOk, llResultadoARCA
loData = CREATEOBJECT("Empty")
llOk = .F.

TRY
	IF !This.ws_iniciar() THEN
		THROW CREATEOBJECT("Exception")
	ENDIF
    
	This.fe.f1cabeceracantreg = 1
	This.fe.f1indice = 0
	This.fe.f1indiceitem = 0    
    
    && Llamo al método que configura las rutas de XMLS y QR
	This.ws_configurar_rutas()

	&& LLamo al método que permite setear los parámetros del QR
	This.ws_set_qr_parametros()
    
    * 2. Ejecución de la consulta
    * f1CompConsultarS devuelve .T. si el comprobante existe en ARCA [6, 10]
    llResultadoARCA = This.fe.f1CompConsultarS(tnPtoVta, tnTipoCbte, ALLTRIM(tcNroCbte))
    
    IF llResultadoARCA .AND. EMPTY(This.fe.UltimoMensajeError) THEN
        This.fe.f1Indice = 0 
        
        * Mapeo de cabecera [11, 12]
        ADDPROPERTY(loData, "punto_vta",	This.fe.f1CabeceraPtoVta)
        ADDPROPERTY(loData, "cae",          This.fe.f1respuestadetalleCAE)
        ADDPROPERTY(loData, "vto_cae",      This.fe.f1respuestadetalleCAEFchVto)
        ADDPROPERTY(loData, "resultado",    This.fe.f1respuestadetalleresultado)
        ADDPROPERTY(loData, "importe",      This.fe.F1DetalleImpTotal)
        ADDPROPERTY(loData, "tipo_emision", This.fe.f1RespuestaDetalleEmisionTipo)
        ADDPROPERTY(loData, "fecha_cbte",   This.fe.f1DetalleCbteFch)
        ADDPROPERTY(loData, "imp_neto",		This.fe.F1DetalleImpNeto) && Neto Gravado
        ADDPROPERTY(loData, "imp_iva",		This.fe.F1DetalleImpIva) && IVA Liquidado
        ADDPROPERTY(loData, "imp_op_ex",	This.fe.F1DetalleImpOpEx) && Importe Exento
        ADDPROPERTY(loData, "imp_tot_conc",	This.fe.F1DetalleImpTotalConc) && Conceptos No Gravados
        ADDPROPERTY(loData, "imp_trib",		This.fe.F1DetalleImpTrib) && Suma de Otros Tributos
        ADDPROPERTY(loData, "doc_tipo", 	This.fe.F1DetalleDocTipo)
        ADDPROPERTY(loData, "cbte_tipo",	This.fe.f1CabeceraCbteTipo) && Tipo de comprobante
        ADDPROPERTY(loData, "doc_nro",		This.fe.F1DetalleCbteDesde)
        	
        
        * 3. Procesamiento de Alícuotas de IVA [2, 13]
        IF This.fe.f1DetalleIvaItemCantidad > 0 THEN
        	SELECT cur_detalle_iva
        	ZAP
        	
            FOR i = 0 TO This.fe.f1DetalleIvaItemCantidad - 1
                This.fe.f1IndiceItem = i && Indispensable para mover el puntero interno [3]
                
                SELECT cur_detalle_iva
                APPEND BLANK
                REPLACE id      WITH This.fe.f1DetalleIvaId, ;
                        baseimp WITH This.fe.f1DetalleIvaBaseImp, ;
                        ivaimp  WITH This.fe.f1DetalleIvaImporte
            ENDFOR
            
            SELECT cur_detalle_iva
            GO TOP
        ENDIF

        * 4. Procesamiento de Otros Tributos (Impuestos Internos) [14-16]
        IF This.fe.f1DetalleTributoItemCantidad > 0 THEN
        	SELECT cur_detalle_trib
        	ZAP
        
            FOR i = 0 TO This.fe.f1DetalleTributoItemCantidad - 1
                This.fe.f1IndiceItem = i && Indispensable para leer cada tributo [3]
                
                SELECT cur_detalle_trib
                APPEND BLANK
                REPLACE id         WITH This.fe.f1DetalleTributoId, ;
                        descripcio WITH This.fe.f1DetalleTributoDesc, ;
                        baseimp    WITH This.fe.f1DetalleTributoBaseImp, ;
                        alicuota   WITH This.fe.f1DetalleTributoAlic, ;
                        importe    WITH This.fe.f1DetalleTributoImporte
            ENDFOR
            
            SELECT cur_detalle_trib
            GO TOP
        ENDIF
        
        llOk = .T. && La consulta fue exitosa
    ELSE    
        * Manejo de errores devueltos por el WS [7, 17, 18]
        This.error_message = This.fe.UltimoMensajeError
        IF This.fe.f1ErrorItemCantidad > 0 THEN
            This.fe.f1IndiceItem = 0 && Apuntamos al primer error de la lista [4]
            This.error_message = This.error_message + " - Detalle: " + This.fe.f1ErrorMsg
        ENDIF
        llOk = .F.
    ENDIF    

CATCH TO oException
    This.error_message = getErrorForCatch(oException)
    llOk = .F.
ENDTRY

RETURN IIF(llOk, loData, NULL)
ENDPROC
PROCEDURE crear_cursores
*************************************************************************************
* Permite crear los cursores para consultar comprobantes autorizados directamente 
* desde el webservice de ARCA,
*************************************************************************************
CREATE CURSOR cur_detalle_iva ( ;
	id int NOT null,;
	baseimp N(20, 2) ,;
	ivaimp N(20, 2))
	
CREATE CURSOR cur_detalle_trib ( ;
	id int NOT NULL, ;
	descripcio varchar(80) NOT NULL,;
	baseimp N(20, 2) NOT NULL,;
	alicuota N(5, 2) NOT NULL,;
	importe N(20, 2) NOT NULL)
ENDPROC
PROCEDURE ws_iniciar
****************************************************************************
* Permite configurar e iniciar el webservice de ARCA.
****************************************************************************
LOCAL lnModo, lcCUIT, lcCertif, lcLicencia, lcPassword

&& Parametros para la conexión con WSFEv1
lnModo = IIF(getGlobalCFG("FEDEBUG"), 0, 1)
lcCUIT = ALLTRIM(getGlobalCFG("FECUIT"))
lcCertif = ALLTRIM(getGlobalCFG("FE_FILE"))
lcLicencia = ALLTRIM(getGlobalCFG("FE_LIC"))
lcPassword = ALLTRIM(getGlobalCFG("FE_PWD"))

llRes = This.fe.iniciar(lnModo, lcCUIT, SYS(5) + SYS(2003) + "\wsafip\" + lcCertif, lcLicencia)
This.fe.tls = getGlobalCFG("FETLS")

IF !llRes THEN
	This.error_message = "Falló al iniciar: " + This.fe.ultimoMensajeError
	RETURN .F.
ENDIF

&& Verifico si el servicio está en línea
IF !This.fe.dummy() THEN 
	This.error_message = "Los Web Services de AFIP no se encuentran disponibles."
	RETURN .F.
ENDIF 

This.fe.ArchivoCertificadoPassWord = lcPassword
IF !This.ticket_valido() THEN
	This.error_message = "No se pudo generar Ticket de Acceso"
	RETURN .F.
ENDIF

RETURN .T.
ENDPROC
PROCEDURE ws_configurar_rutas
*********************************************************************************
* Permite configurar las rutas del webservice de los XML y QR
*********************************************************************************
This.fe.ArchivoXMLRecibido = SYS(5) + SYS(2003) + "\wsafip\xml\" + ALLTRIM(STR(This.id_ventasc)) + "_rec_" + ALLTRIM(STR(YEAR(DATETIME()))) + ;
	ALLTRIM(STR(MONTH(DATETIME()))) + ALLTRIM(STR(DAY(DATETIME()))) + ALLTRIM(STR(HOUR(DATETIME()))) + ;
	ALLTRIM(STR(MINUTE(DATETIME()))) + ALLTRIM(STR(SEC(DATETIME()))) + ".xml"
	
This.fe.archivoXMLEnviado = SYS(5) + SYS(2003) + "\wsafip\xml\" + ALLTRIM(STR(This.id_ventasc)) + "_env_" + ALLTRIM(STR(YEAR(DATETIME()))) + ;
	ALLTRIM(STR(MONTH(DATETIME()))) + ALLTRIM(STR(DAY(DATETIME()))) + ALLTRIM(STR(HOUR(DATETIME()))) + ;
	ALLTRIM(STR(MINUTE(DATETIME()))) + ALLTRIM(STR(SEC(DATETIME()))) + ".xml"
	
This.aut_qr = getGlobalCFG("QRPATH") + ALLTRIM(STR(this.id_ventasc)) + "_" + ALLTRIM(STR(YEAR(DATETIME()))) + ;
	ALLTRIM(STR(MONTH(DATETIME()))) + ALLTRIM(STR(DAY(DATETIME()))) + ALLTRIM(STR(HOUR(DATETIME()))) + ;
	ALLTRIM(STR(MINUTE(DATETIME()))) + ALLTRIM(STR(SEC(DATETIME()))) + ".jpg"
	
CLEAR RESOURCES &This.aut_qr
ENDPROC
PROCEDURE ws_set_qr_parametros
***********************************************************************************
* Permite setear los parámetros para generar la imagen QR que se mostrará en la 
* impresión y reimpresión de comprobantes.
***********************************************************************************

This.fe.f1DEtalleQrArchivo = This.aut_qr
This.fe.f1DEtalleQrFormato = 1
This.fe.f1DetalleQrResolucion = 5
This.fe.f1DetalleQrTolerancia = 0

ENDPROC
PROCEDURE ws_get_respuesta
*************************************************************************************
*Permite obtener la repuesta del WebService de ARCA después procesar la autorización.
*************************************************************************************
LPARAMETERS tbResult, tnPtoVta

LOCAL lcMensaje, lcNumero

IF tbResult THEN
	IF ALLTRIM(This.fe.F1RespuestaResultado) == "A" THEN
		lcNumero = REPLICATE("0", 4 - LEN(ALLTRIM(STR(tnPtoVta)))) + ALLTRIM(STR(tnPtoVta)) + "-" + ;
			REPLICATE("0", 8 - LEN(ALLTRIM(STR(This.fe.F1RespuestaDetalleCbteDesde)))) + ALLTRIM(STR(This.fe.F1RespuestaDetalleCbteDesde))
		
		This.ptovta = tnPtoVta
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
		RETURN .F.
	ENDIF
ELSE
	IF !(ISNULL(This.fe.F1RespuestaReProceso) .OR. This.fe.F1RespuestaReProceso == "R") THEN
		lcMensaje = "ATENCION: Falló la solicitud de CAE" + CHR(13) + CHR(10)
		lcMensaje = lcMensaje + "RESULTADO: " + This.fe.F1RespuestaResultado + CHR(13) + CHR(10)
		lcMensaje = lcMensaje + "MOTIVO: " + This.fe.UltimoMensajeError + CHR(13) + CHR(10)
		
		This.arca_message = lcMensaje
		RETURN .F.
	ELSE
		lcMensaje = "MOTIVO: " + This.fe.F1RespuestaDetalleObservacionMsg + CHR(13) + CHR(10)
		lcMensaje = lcMensaje + "ERROR: " + This.fe.f1ErrorMsg1 + CHR(13) + CHR(10)
		lcMensaje = lcMensaje + "ULTIMO: " + This.fe.UltimoMensajeError
		
		This.arca_message = lcMensaje
		RETURN .F.
	ENDIF
ENDIF

RETURN .T.
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

IF USED("cur_detalle_iva ") THEN
	USE IN cur_detalle_iva
ENDIF

IF USED("cur_detalle_trib") THEN
	USE IN cur_detalle_trib
ENDIF

This.fe = NULL
ENDPROC
PROCEDURE Init
***********************************************************************
* Instancia el objeto fe a partir del OCX de facturación electrónica
***********************************************************************

This.fe = CREATEOBJECT("WSAFIPFEOCX.WSAFIPFEx")
This.crear_cursores()
ENDPROC


