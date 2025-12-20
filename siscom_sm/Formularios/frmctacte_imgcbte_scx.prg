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
OBJETO: FRMCTACTE_IMGCBTE
************************************************************
*** PROPIEDADES ***
DoCreate = .T.
Name = "FRMCTACTE_IMGCBTE"
contenido.GRDDETALLE.COLUMN1.Header1.Name = "Header1"
contenido.GRDDETALLE.COLUMN1.Text1.Name = "Text1"
contenido.GRDDETALLE.COLUMN1.Name = "COLUMN1"
contenido.GRDDETALLE.COLUMN2.Header1.Name = "Header1"
contenido.GRDDETALLE.COLUMN2.Text1.Name = "Text1"
contenido.GRDDETALLE.COLUMN2.Name = "COLUMN2"
contenido.GRDDETALLE.COLUMN3.Header1.Name = "Header1"
contenido.GRDDETALLE.COLUMN3.Text1.Name = "Text1"
contenido.GRDDETALLE.COLUMN3.Name = "COLUMN3"
contenido.GRDDETALLE.COLUMN4.Header1.Name = "Header1"
contenido.GRDDETALLE.COLUMN4.Text1.Name = "Text1"
contenido.GRDDETALLE.COLUMN4.Name = "COLUMN4"
contenido.GRDDETALLE.COLUMN5.Header1.Name = "Header1"
contenido.GRDDETALLE.COLUMN5.Text1.Name = "Text1"
contenido.GRDDETALLE.COLUMN5.Name = "COLUMN5"
contenido.GRDDETALLE.COLUMN6.Header1.Name = "Header1"
contenido.GRDDETALLE.COLUMN6.Text1.Name = "Text1"
contenido.GRDDETALLE.COLUMN6.Name = "COLUMN6"
contenido.GRDDETALLE.COLUMN7.Header1.Name = "Header1"
contenido.GRDDETALLE.COLUMN7.Text1.Name = "Text1"
contenido.GRDDETALLE.COLUMN7.Name = "COLUMN7"
contenido.GRDDETALLE.COLUMN8.Header1.Name = "Header1"
contenido.GRDDETALLE.COLUMN8.Text1.Name = "Text1"
contenido.GRDDETALLE.COLUMN8.Name = "COLUMN8"
contenido.GRDDETALLE.COLUMN9.Header1.Name = "Header1"
contenido.GRDDETALLE.COLUMN9.Text1.Name = "Text1"
contenido.GRDDETALLE.COLUMN9.Name = "COLUMN9"
contenido.GRDDETALLE.COLUMN10.Header1.Name = "Header1"
contenido.GRDDETALLE.COLUMN10.Text1.Name = "Text1"
contenido.GRDDETALLE.COLUMN10.Name = "COLUMN10"
contenido.GRDDETALLE.COLUMN11.Header1.Name = "Header1"
contenido.GRDDETALLE.COLUMN11.Text1.Name = "Text1"
contenido.GRDDETALLE.COLUMN11.Name = "COLUMN11"
contenido.GRDDETALLE.COLUMN12.Header1.Name = "Header1"
contenido.GRDDETALLE.COLUMN12.Text1.Name = "Text1"
contenido.GRDDETALLE.COLUMN12.Name = "COLUMN12"
contenido.GRDDETALLE.COLUMN13.Header1.Name = "Header1"
contenido.GRDDETALLE.COLUMN13.Text1.Name = "Text1"
contenido.GRDDETALLE.COLUMN13.Name = "COLUMN13"
contenido.GRDDETALLE.COLUMN14.Header1.Name = "Header1"
contenido.GRDDETALLE.COLUMN14.Text1.Name = "Text1"
contenido.GRDDETALLE.COLUMN14.Name = "COLUMN14"
contenido.GRDDETALLE.COLUMN15.Header1.Name = "Header1"
contenido.GRDDETALLE.COLUMN15.Text1.Name = "Text1"
contenido.GRDDETALLE.COLUMN15.Name = "COLUMN15"
contenido.GRDDETALLE.COLUMN16.Header1.Name = "Header1"
contenido.GRDDETALLE.COLUMN16.Text1.Name = "Text1"
contenido.GRDDETALLE.COLUMN16.Name = "COLUMN16"
contenido.GRDDETALLE.COLUMN17.Header1.Name = "Header1"
contenido.GRDDETALLE.COLUMN17.Text1.Name = "Text1"
contenido.GRDDETALLE.COLUMN17.Name = "COLUMN17"
contenido.GRDDETALLE.COLUMN18.Header1.Name = "Header1"
contenido.GRDDETALLE.COLUMN18.Text1.Name = "Text1"
contenido.GRDDETALLE.COLUMN18.Name = "COLUMN18"
contenido.GRDDETALLE.COLUMN19.Header1.Name = "Header1"
contenido.GRDDETALLE.COLUMN19.Text1.Name = "Text1"
contenido.GRDDETALLE.COLUMN19.Name = "COLUMN19"
contenido.GRDDETALLE.COLUMN20.Header1.Name = "Header1"
contenido.GRDDETALLE.COLUMN20.Text1.Name = "Text1"
contenido.GRDDETALLE.COLUMN20.Name = "COLUMN20"
contenido.GRDDETALLE.Name = "GRDDETALLE"
contenido.CLSCERRAR1.Name = "CLSCERRAR1"
contenido.TXTOBSERV.Name = "TXTOBSERV"
contenido.btnImprimir.Alignment = 2
contenido.btnImprimir.Name = "btnImprimir"
contenido.Name = "contenido"

*** METODOS ***
PROCEDURE Load
LOCAL lcSql, loResult, loVentas, cbte
LOCAL llTieneDetalle

lcSql = ""
loResult = CREATEOBJECT("odbc_result")
loVentas = CREATEOBJECT("odbc_result")
cbte = ""
llTieneDetalle = .F.

* DODEFAULT()

CREATE CURSOR cur_Detalle (	;
	idDetalle		int			,;
	idArticulo		int 		,;
	codArt			C(20)		,;
	descripcio		C(60)		,;
	cantidad		float(10,2)	,;
	cantNC			float(10,2) ,;
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
	cantNC			float(10,2) ,;
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
	
CREATE CURSOR vtadcp (	;
	id_vtadcp		int,;
	idVentasC		int,;
	idPlanCta		int,;
	codPlanCta		varchar(20),;
	descPlan		varchar(60),;
	idBanco			int,;
	cheque_nro		varchar(20),;
	impNeto			float(10, 2),;
	ivaPor			float(10, 2),;
	ivaImp			float(10, 2),;
	total			float(10, 2))


lcSql = lcSql + "select  ventasdet.idventasc, "
lcSql = lcSql + "        ventasdet.idarticulo, "
lcSql = lcSql + "        articulos.codart, "
lcSql = lcSql + "        ventasdet.descripcio, "
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
lcSql = lcSql + "where idVentasC = " + ALLTRIM(STR(cur_CtaCte.idventasc))

loResult.ActiveConnection = goConn.ActiveConnection
loResult.cursor_name = "cur_tempo"
loResult.OpenQuery(lcSql)

lcSql = "select * from ventascab where idventasc = " + ALLTRIM(STR(cur_CtaCte.idventasc))
loVentas.Cursor_Name = "cur_vtas"
loVentas.ActiveConnection = goConn.ActiveConnection
loVentas.OpenQuery(lcSql)

cbte = ALLTRIM(cur_vtas.cbte)

loVentas.close_query()

SELECT cur_tempo
IF RECCOUNT() > 0 THEN
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
		REPLACE cur_aux.CantNC WITH cur_tempo.cantidad ADDITIVE
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
	
	thisform.contenido.grdDetalle.alias_name = "cur_aux"
	thisform.contenido.grdDetalle.RecordSource = "cur_aux"
	thisform.contenido.grdDetalle.list_controlsource = "cantidad,codArt,descripcio,prVta,AlicIVA,impIVA,totNeto,subTotal"
	thisform.contenido.grdDetalle.lista_ancho_cols = "70,100,200,70,70,70,70,70"
	thisform.contenido.grdDetalle.titulos_cabeceras = "Cantidad,Codigo,Descripción,Pr. Venta,Alic. I.V.A,Imp. I.V.A,Total Neto,SubTotal"
	thisform.contenido.grdDetalle.generar_grid()
	thisform.contenido.grdDetalle.Refresh()
ENDIF 

IF ALLTRIM(cbte) == "PED" THEN
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
		REPLACE cur_detalle.CantNC WITH cur_tempo.cantidad ADDITIVE
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

	thisform.contenido.grdDetalle.alias_name = "cur_detalle"
	thisform.contenido.grdDetalle.RecordSource = "cur_detalle"
	thisform.contenido.grdDetalle.list_controlsource = "cantidad,codArt,descripcio,prVta,AlicIVA,impIVA,totNeto,subTotal"
	thisform.contenido.grdDetalle.lista_ancho_cols = "70,100,200,70,70,70,70,70"
	thisform.contenido.grdDetalle.titulos_cabeceras = "Cantidad,Codigo,Descripción,Pr. Venta,Alic. I.V.A,Imp. I.V.A,Total Neto,SubTotal"
	thisform.contenido.grdDetalle.generar_grid()
	thisform.contenido.grdDetalle.Refresh()	
ENDIF

IF RECCOUNT("cur_tempo") > 0 THEN
	llTieneDetalle = .T.
ELSE
	llTieneDetalle = .F.
ENDIF

thisform.tienedetalle = llTieneDetalle

loResult.close_query()

&& Si no tiene detalle en ventasdet, entonces, tiene que tener concepto.
IF !llTieneDetalle THEN
	lcSql = "SELECT   vtadcp.*, "
	lcSql = lcSql + " vtadcp.idPlanCta, "
	lcSql = lcSql + " planctas.codPlanCta, "
	lcSql = lcSql + " planctas.descripcio "
	lcSql = lcSql + "FROM vtadcp INNER JOIN planctas ON vtadcp.idPlanCta = planctas.idPlanCta "
	lcSql = lcSql + "WHERE idVentasC = " + ALLTRIM(STR(cur_CtaCte.idventasc))
	
	loResult.ActiveConnection = goConn.ActiveConnection
	loResult.Cursor_Name = "cur_tempo"

	IF !loResult.OpenQuery(lcSql) THEN
		MESSAGEBOX(loResult.Error_Message, 0+48, Thisform.Caption)
		RETURN .F.
	ENDIF
	
	SELECT cur_tempo
	DO WHILE !EOF("cur_tempo")
		SELECT vtadcp
		APPEND BLANK
		REPLACE vtadcp.id_vtadcp WITH cur_tempo.id_vtadcp
		REPLACE vtadcp.idVentasC WITH cur_tempo.idVentasC ADDITIVE
		REPLACE vtadcp.idPlanCta WITH cur_tempo.idPlanCta ADDITIVE
		REPLACE vtadcp.codPlanCta WITH cur_tempo.codPlanCta ADDITIVE
		REPLACE vtadcp.descPlan WITH cur_tempo.descripcio ADDITIVE
		REPLACE vtadcp.idBanco WITH IIF(ISNULL(cur_tempo.idBanco), 0, cur_tempo.idBanco) ADDITIVE
		REPLACE vtadcp.cheque_nro WITH IIF(ISNULL(cur_tempo.cheque_nro), "", cur_tempo.cheque_nro) ADDITIVE
		REPLACE vtadcp.impNeto WITH cur_tempo.impNeto ADDITIVE
		REPLACE vtadcp.ivaPor WITH cur_tempo.ivaPor ADDITIVE
		REPLACE vtadcp.ivaImp WITH cur_tempo.ivaImp ADDITIVE
		REPLACE vtadcp.total WITH cur_tempo.total ADDITIVE
		
		SELECT cur_tempo
		SKIP
	ENDDO
	
	IF RECCOUNT("cur_tempo") > 0 THEN
		GO TOP
	ENDIF
	
	thisform.contenido.grdDetalle.alias_name = "vtadcp"
	thisform.contenido.grdDetalle.RecordSource = "vtadcp"
	thisform.contenido.grdDetalle.list_controlsource = "codPlanCta,descPlan,impNeto,ivaPor,ivaImp,total"
	thisform.contenido.grdDetalle.lista_ancho_cols = "100,300,70,70,70,70"
	thisform.contenido.grdDetalle.titulos_cabeceras = "Código,Descripción,Pr. Neto, IVA(%), IVA($),Total"
	thisform.contenido.grdDetalle.generar_grid()
	thisform.contenido.grdDetalle.Refresh()		
ENDIF
ENDPROC
PROCEDURE Init
Thisform.Contenido.txtObserv.Value = cur_ctacte.Observ
Thisform.Caption = Thisform.Caption + " " + cur_ctacte.numCbte
ENDPROC
PROCEDURE contenido.btnImprimir.Click
LOCAL m.NroCli, m.RazSoc, m.Telefono,  m.direccion, m.localidad, m.codPostal, m.pcia, m.tipoIVA, m.nroCuit
LOCAL m.Total, m.tipoDoc, m.NroCbte, m.Fecha, m.leyenda, m.fecVto, m.tipoDoc, m.ptoVta
LOCAL m.porDesc1, m.porDesc2, m.porDesc3, m.porDesc4
LOCAL m.impDesc1, m.impDesc2, m.impDesc3, m.impDesc4
LOCAL m.porIIBB, m.impIIBB, m.observ, m.vendedor
LOCAL m.porIVA105, m.impIVA105, m.porIVA21, m.impIVA21, m.impNeto, m.impFinal
LOCAL lcSql, loCV, loCD, lcPrinterName
LOCAL lo_rsSitIVA, lo_rsCondPago, lo_rsLocalidad, lo_rsPcia
LOCAL m.cae, m.caevto, m.condPago
LOCAL m.codigoCbte, m.barcode, m.code, m.nroOC
LOCAL lcDia, lcMes, lcAnio, m.motivo, m.totaNoGrav

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
m.Fecha = cur_CtaCte.fecemis
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
m.vendedor = ""
m.barcode = ""
m.code = ""
m.nroOC = ""
m.totaNoGrav = 0.00

lcDia = ""
lcMes = ""
lcAnio = ""

***********************************************************************************
&& Busco la cabecera de venta, cliente, localidad, provincia, cond pago, sir iva

lcSql = "select * from ventascab where idventasc = " + ALLTRIM(STR(cur_CtaCte.idventasc))
loCV.Cursor_Name = "cur_venta"
loCV.ActiveConnection = goConn.ActiveConnection
loCV.OpenQuery(lcSql)

m.cae = cur_venta.aut_CAE
m.caevto = DTOC(cur_venta.aut_CAE_vto)
m.codigoCbte = ALLTRIM(cur_venta.aut_tipoCbte)
m.nroOC = ALLTRIM(STR(cur_venta.nroOC))
&& Recupero el QR
IF ISNULL(cur_venta.aut_qr) .OR. ALLTRIM(cur_venta.aut_qr) == "" THEN
	IF INT(VAL(gnDEMO)) = 0 THEN
		m.qr = getglobalcfg("QRPATH") + "sin_qr.png"
	ELSE
		m.qr = ""
	ENDIF
ELSE
	m.qr = ALLTRIM(cur_venta.aut_qr)
ENDIF

lcDia = REPLICATE("0", 2 - LEN(ALLTRIM(STR(DAY(cur_venta.aut_CAE_vto))))) + ALLTRIM(STR(DAY(cur_venta.aut_CAE_vto)))
lcMes = REPLICATE("0", 2 - LEN(ALLTRIM(STR(MONTH(cur_venta.aut_CAE_vto))))) + ALLTRIM(STR(MONTH(cur_venta.aut_CAE_vto)))
lcAnio = ALLTRIM(STR(YEAR(cur_venta.aut_CAE_vto)))

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

lcSql = "SELECT * FROM sitiva WHERE idSitIVA = " + ALLTRIM(STR(cur_venta.idSitIVA))
lo_rsSitIVA.ActiveConnection = goConn.ActiveConnection
lo_rsSitIVA.Cursor_Name = "cur_SitIVA"
lo_rsSitIVA.OpenQuery(lcSql)

SELECT cur_SitIVA
m.tipoIVA = cur_SitIVA.descripcio

&& Si es monotributo extraigo la leyenda.
IF cur_SitIVA.idSitIVA = 6 THEN
	m.motivo = "El crédito fiscal discriminado en el presente comprobante, " ;
		+ "sólo podrá ser computado a efectos del Régimen de Sostenimiento e Inclusión Fiscal para Pequeños Contribuyentes de la Ley Nº 27.618"
ELSE
	m.motivo = ""
ENDIF

lo_rsSitIVA.close_query()

*!*	lcSql = "SELECT * FROM condpagos WHERE idCondPago = " + ALLTRIM(STR(cur_venta.idCondPago))
*!*	lo_rsCondPago.ActiveConnection = goConn.ActiveConnection
*!*	lo_rsCondPago.Cursor_Name = "cur_CondPago"
*!*	lo_rsCondPago.OpenQuery(lcSql)

*!*	SELECT cur_CondPago
*!*	m.fecVto = TTOD(cur_venta.fecEmision) + cur_CondPago.cntDias

*!*	lo_rsCondPago.close_query()
***********************************************************************************
m.fecVto = TTOD(cur_venta.fecVto)

IF ALLTRIM(cur_venta.cbte) == "COT"
	m.leyenda = "COTIZACION"
	m.Total = cur_venta.totfact
ELSE 
	IF (ALLTRIM(cur_venta.cbte) == "PTO") .OR. (ALLTRIM(cur_venta.cbte) == "FC" .AND. ALLTRIM(cur_venta.tipodoc)  == "X") THEN  
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
m.vendedor = cur_venta.usuAlta
m.condPago = IIF(cur_venta.idCondPago = 1, "CONTADO", "CUENTAS CORRIENTES")
&& Agrego no gravado
m.totaNoGrav = cur_venta.totaNoGrav

IF thisform.tienedetalle THEN
*!*		IF ALLTRIM(cur_venta.tipodoc)  == "X" THEN
*!*			SELECT cur_aux
*!*			REPORT FORM "reppto.frx" TO PRINTER PREVIEW
*!*			loCV.close_query()
*!*			RETURN .T.		
*!*		ENDIF

	IF ALLTRIM(cur_venta.cbte) == "COT" THEN
		&& Imprime una cotizacion
		SELECT cur_aux	
		REPORT FORM "repcot.frx" TO PRINTER PROMPT PREVIEW 
	ELSE 
		IF (ALLTRIM(cur_venta.cbte) == "PTO") .OR. (ALLTRIM(cur_venta.cbte) == "FC" .AND. ALLTRIM(cur_venta.tipodoc)  == "X") .OR. (ALLTRIM(cur_venta.cbte) == "NC" .AND. ALLTRIM(cur_venta.tipodoc)  == "X") THEN
			&& Imprime un presupuesto
			SELECT cur_aux
			REPORT FORM "reppto.frx" TO PRINTER PROMPT PREVIEW 
		ELSE
			&& Si el comprobante es "PED" entonces, tiene que enviar a imprimir una nota de pedido
			IF ALLTRIM(cur_venta.cbte) == "PED" THEN
				m.observ = Thisform.contenido.txtObserv.Value
				SELECT cur_detalle
				REPORT FORM "reppedido.frx" TO PRINTER PROMPT PREVIEW	
			ELSE 
				IF ALLTRIM(cur_venta.tipodoc) == "A" THEN
					&& Regenero el código de barras
					m.barcode = ALLTRIM(m.nroCuit)
					m.barcode = m.barcode + ALLTRIM(m.codigoCbte)
					m.barcode = m.barcode + ALLTRIM(m.ptoVta)
					m.barcode = m.barcode + ALLTRIM(m.cae)
					m.barcode = m.barcode + ALLTRIM(lcAnio)
					m.barcode = m.barcode + ALLTRIM(lcMes)
					m.barcode = m.barcode + ALLTRIM(lcDia)
					m.barcode = m.barcode + ALLTRIM(STR(Thisform.calc_digito_verificador(m.barcode)))
					m.code = m.barcode
					m.barcode = getcodbarras(m.barcode)					
					
					&& Imprime el comprobante de tipo "A"
					SELECT cur_aux	
					REPORT FORM "repcbtesvta.frx" TO PRINTER PROMPT PREVIEW	
				ELSE
					&& Regenero el código de barras
					m.barcode = ALLTRIM(m.nroCuit)
					m.barcode = m.barcode + ALLTRIM(m.codigoCbte)
					m.barcode = m.barcode + ALLTRIM(m.ptoVta)
					m.barcode = m.barcode + ALLTRIM(m.cae)
					m.barcode = m.barcode + ALLTRIM(lcAnio)
					m.barcode = m.barcode + ALLTRIM(lcMes)
					m.barcode = m.barcode + ALLTRIM(lcDia)
					m.barcode = m.barcode + ALLTRIM(STR(Thisform.calc_digito_verificador(m.barcode)))
					m.code = m.barcode
					m.barcode = getcodbarras(m.barcode)					
									
					&& Imprime el comprobante de tipo "B"
					SELECT cur_aux	
					REPORT FORM "repcbtesvta_b.frx" TO PRINTER PROMPT PREVIEW	 
				ENDIF
			ENDIF
		ENDIF
	ENDIF 
ELSE
	IF INT(VAL(gnDEMO)) = 1 THEN
			SELECT vtadcp
			REPORT FORM 'repncnd_x' TO PRINTER PROMPT PREVIEW		
	ELSE
		IF ALLTRIM(cur_venta.tipodoc) == "A" THEN
			SELECT vtadcp
			REPORT FORM 'repncnd' TO PRINTER PROMPT PREVIEW	
		ELSE
			SELECT vtadcp
			REPORT FORM 'repncnd_b' TO PRINTER PROMPT PREVIEW	
		ENDIF
	ENDIF
ENDIF

loCV.close_query()

ENDPROC


************************************************************
OBJETO: 
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


