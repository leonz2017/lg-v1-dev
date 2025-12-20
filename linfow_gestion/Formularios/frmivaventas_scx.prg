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
OBJETO: FRMIVAVENTAS
************************************************************
*** PROPIEDADES ***
DataSession = 2
BorderStyle = 1
Height = 166
Width = 404
DoCreate = .T.
ShowTips = .T.
Picture = ..\
Caption = "Listado IVA Ventas"
WindowType = 0
Name = "FRMIVAVENTAS"

*** METODOS ***
PROCEDURE generar_citivtas_v40
LOCAL loRes
LOCAL lcSql
LOCAL lcFecDesde
LOCAL lcFecHasta
LOCAL loDateTime
LOCAL lcMes
LOCAL lcDia
LOCAL lcRegistro

* Las siguientes variables son para generar cada campo que va a ir
* plasmado en el txt

LOCAL lcTipoReg			&& Tipo de registro
LOCAL lcFecCbte			&& Fecha del comprobante
LOCAL lcTipoCbte		&& Tipo de comprobante
LOCAL lcCtrlFisc		&& Controlador Fiscal
LOCAL lcPtoVta			&& Punto de venta
LOCAL lcNroCbte			&& Número de comprobante
LOCAL lcNroCbteHH		&& Número de comprobante hasta
LOCAL lcCodDoc			&& Código de documento
LOCAL lcNroDoc			&& Número de documento
LOCAL lcRazSoc			&& Razón Social
LOCAL lcImpTotOper		&& Importe total de la operación
LOCAL lcTotConc			&& Total de conceptos que no integran precio neto
LOCAL lcImpNetoGrav		&& Importe neto gravado
LOCAL lcAlicIVA			&& Alícuota de IVA
LOCAL lcImpLiquid		&& Impuesto liquidado
LOCAL lcImpLiqRNI		&& Impuesto liquidado a RNI perc. a no categoriz
LOCAL lcImpOpeExt		&& Impuesto de operaciones externas
LOCAL lcImpPerIN		&& Importe de percecp. o pagos a cta de impuesto nac.
LOCAL lcImpPerIIBB		&& Importe de percepciones de Ingresos Brutos
LOCAL lcImpPerIM		&& Importe de percepciones de Impuestos Municipales
LOCAL lcIIInt			&& Importe de impuestos internos
LOCAL lcTipoResp		&& Tipo de Responsable
LOCAL lcCodMon			&& Código de moneda
LOCAL lcTipoCbio		&& Tipo de cambio
LOCAL lcCantAlicIVA		&& Cantidad de alícuota de IVA
LOCAL lcCodOper			&& Código de operación
LOCAL lcCAI				&& CAI
LOCAL lcFecVto			&& Fecha de vencimiento
LOCAL lcFecAnul			&& Fecha de anulación del comprobante
LOCAL lcInfoAdic		&& Información adicional
LOCAL lcFecPagoRet		&& Fecha de pago de retensión
LOCAL lcImpRet			&& Importe de retensión

loDateTime = CREATEOBJECT("datetime")
loRes = CREATEOBJECT("odbc_result")
lcMes = ""
lcDia = ""
lcRegistro = ""
lcSql = ""

lcTipoReg = ""
lcFecCbte = ""
lcTipoCbte = ""
lcCtrlFisc = ""
lcPtoVta = ""
lcNroCbte = ""
lcNroCbteHH = ""
lcCodDoc = ""
lcNroDoc = ""
lcRazSoc = ""
lcImpTotOper = ""
lcTotConc = ""
lcImpNetoGrav = ""
lcAlicIVA = ""
lcImpLiquid = ""
lcImpLiqRNI = ""
lcImpOpeExt = ""
lcImpPerIN = ""
lcImpPerIIBB = ""
lcImpPerIM = ""
lcIIInt = ""
lcTipoResp = ""
lcCodMon = ""
lcTipoCbio = ""
lcCantAlicIVA = ""
lcCodOper = ""
lcCAI = ""
lcFecVto = ""
lcFecAnul = ""
lcInfoAdic = ""
lcFecPagoRet = ""
lcImpRet = ""

lcFecDesde = loDateTime.toMySql(Thisform.txtFecDesde.Value)
lcFecHasta = loDateTime.toMySql(Thisform.txtFecHasta.Value)

lcSql = "SELECT ventascab.fecEmision, "
lcSql = lcSql + "   ventascab.cbte, "
lcSql = lcSql + "	ventascab.aut_tipoCbte, "
lcSql = lcSql + "   ventascab.ptoVta, "
lcSql = lcSql + "   ventascab.numCbte, "
lcSql = lcSql + "   tipodoc.CodAfip, "
lcSql = lcSql + "   ventascab.nroDoc, "
lcSql = lcSql + "   ventascab.razSoc, "
lcSql = lcSql + "   ventascab.totFact, "
lcSql = lcSql + "   ventascab.impFinal, "
lcSql = lcSql + "   ventascab.porIVA21, "
lcSql = lcSql + "   ventascab.impIVA21, "
lcSql = lcSql + "   ventascab.porIVA105, "
lcSql = lcSql + "	ventascab.impIVA105 "
lcSql = lcSql + "FROM ventascab "
lcSql = lcSql + "  INNER JOIN tipodoc ON tipodoc.idTipoDoc = ventascab.idTipoDoc "
lcSql = lcSql + "WHERE  "

IF INT(VAL(getConfig("SQLSRV"))) = 1 THEN
	lcSql = lcSql + "CONVERT(CHAR(8), ventascab.FecEmision, 112) between " + lcFecDesde + " and " + lcFecHasta + " "
ELSE
	lcSql = lcSql + "CAST(ventascab.FecEmision AS DATE) between " + lcFecDesde + " and " + lcFecHasta + " "
ENDIF

lcSql = lcSql + " AND ventascab.cbte NOT IN ('PED', 'COT', 'PTO')"

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_ventas"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_ventas
GO TOP

DO WHILE !EOF("cur_ventas")
	lcTipoReg = "1"
	
	IF LEN(ALLTRIM(STR(DAY(cur_ventas.fecEmision)))) = 1 THEN
		lcDia = "0" + ALLTRIM(STR(DAY(cur_ventas.fecEmision)))
	ELSE
		lcDia = ALLTRIM(STR(DAY(cur_ventas.fecEmision)))
	ENDIF
	
	IF LEN(ALLTRIM(STR(MONTH(cur_ventas.fecEmision)))) = 1 THEN
		lcMes = "0" + ALLTRIM(STR(MONTH(cur_ventas.fecEmision)))
	ELSE
		lcMes = ALLTRIM(STR(MONTH(cur_ventas.fecEmision)))
	ENDIF
	
	lcFecCbte = ALLTRIM(STR(YEAR(cur_ventas.fecEmision))) + ALLTRIM(lcMes) + ALLTRIM(lcDia)
	lcTipoCbte = ALLTRIM(cur_ventas.aut_tipoCbte)
	lcCtrlFisc = SPACE(1)
	
	lcPtoVta = REPLICATE("0", 4 - LEN(ALLTRIM(STR(cur_ventas.ptoVta)))) + ;
			ALLTRIM(STR(cur_ventas.ptoVta))
	
	lcNroCbte = REPLICATE("0", 20 - LEN(ALLTRIM(STR(cur_ventas.numCbte)))) + ;
			ALLTRIM(STR(cur_ventas.numCbte))
	
	lcNroCbteHH = lcNroCbte
	lcCodDoc = ALLTRIM(cur_ventas.codAfip)
	lcNroDoc = REPLICATE("0", 11 - LEN(ALLTRIM(cur_ventas.nroDoc))) + ;
			ALLTRIM(cur_ventas.nroDoc)
	
	IF LEN(ALLTRIM(cur_ventas.razSoc)) > 30 THEN
		lcRazSoc = SUBSTR(ALLTRIM(cur_ventas.razSoc), 1, 30)
	ELSE
		lcRazSoc = ALLTRIM(cur_ventas.razSoc) + ;
				REPLICATE(SPACE(1), 30 - LEN(ALLTRIM(cur_ventas.razSoc)))
	ENDIF
	
	lcImpTotOper = STRTRAN(ALLTRIM(STR(cur_ventas.totFact)), ".", "")
	lcImpTotOper = REPLICATE("0", 15 - LEN(ALLTRIM(lcImpTotOper))) + ALLTRIM(lcImpTotOper)
	
	lcTotConc = REPLICATE("0", 15)
	
	lcImpNetoGrav = STRTRAN(ALLTRIM(STR(cur_ventas.impFinal)), ".", "")
	lcImpNetoGrav = REPLICATE("0", 15 - LEN(ALLTRIM(lcImpNetoGrav))) + ALLTRIM(lcImpNetoGrav)
	
	IF cur_ventas.porIVA21 <> 0 THEN
		lcAlicIVA = "2100"
		lcImpLiquid = STRTRAN(ALLTRIM(STR(cur_ventas.impIVA21)), ".", "")
		lcImpLiquid = REPLICATE("0", 15 - LEN(ALLTRIM(lcImpLiquid))) + ALLTRIM(lcImpLiquid)
	ELSE
		lcAlicIVA = "1050"
		lcImpLiquid = STRTRAN(ALLTRIM(STR(cur_ventas.impIVA105)), ".", "")
		lcImpLiquid = REPLICATE("0", 15 - LEN(ALLTRIM(lcImpLiquid))) + ALLTRIM(lcImpLiquid)
	ENDIF
	
	lcImpLiqRNI = REPLICATE("0", 15)
	lcImpOpeExt = REPLICATE("0", 15)
	lcImpPerIN = REPLICATE("0", 15)
	lcImpPerIIBB = REPLICATE("0", 15)
	lcImpPerIM = REPLICATE("0", 15)
	lcIIInt = REPLICATE("0", 15)
	lcTipoResp = SPACE(2)
	lcCodMon = SPACE(3)
	lcTipoCbio = SPACE(10)
	
	IF cur_ventas.impIVA21 <> 0 .AND. cur_ventas.impIVA105 <> 0 THEN
		lcCantAlicIVA = "2"
	ELSE
		lcCantAlicIVA = "1"
	ENDIF
	
	lcCodOper = SPACE(1)
	lcCAI = SPACE(14)
	lcFecVto = SPACE(8)
	lcFecAnul = SPACE(8)
	lcInfoAdic = SPACE(75)
	lcFecPagoRet = REPLICATE("0", 8)
	lcImpRet = REPLICATE("0", 15)
	
	IF cur_ventas.impIVA21 <> 0 THEN
		SELECT cur_citivtas
		APPEND BLANK
		REPLACE cur_citivtas.campo1 WITH lcTipoReg
		REPLACE cur_citivtas.campo2 WITH lcFecCbte ADDITIVE
		REPLACE cur_citivtas.campo3 WITH lcTipoCbte ADDITIVE
		REPLACE cur_citivtas.campo4 WITH lcCtrlFisc ADDITIVE
		REPLACE cur_citivtas.campo5 WITH lcPtoVta ADDITIVE
		REPLACE cur_citivtas.campo6 WITH lcNroCbte ADDITIVE
		REPLACE cur_citivtas.campo7 WITH lcNroCbteHH ADDITIVE
		REPLACE cur_citivtas.campo8 WITH lcCodDoc ADDITIVE
		REPLACE cur_citivtas.campo9 WITH lcNroDoc ADDITIVE
		REPLACE cur_citivtas.campo10 WITH lcRazSoc ADDITIVE
		REPLACE cur_citivtas.campo11 WITH lcImpTotOper ADDITIVE
		REPLACE cur_citivtas.campo12 WITH lcTotConc ADDITIVE
		REPLACE cur_citivtas.campo13 WITH lcImpNetoGrav ADDITIVE
		REPLACE cur_citivtas.campo14 WITH lcAlicIVA ADDITIVE
		REPLACE cur_citivtas.campo15 WITH lcImpLiquid ADDITIVE
		REPLACE cur_citivtas.campo16 WITH lcImpLiqRNI ADDITIVE
		REPLACE cur_citivtas.campo17 WITH lcImpOpeExt ADDITIVE
		REPLACE cur_citivtas.campo18 WITH lcImpPerIN ADDITIVE
		REPLACE cur_citivtas.campo19 WITH lcImpPerIIBB ADDITIVE
		REPLACE cur_citivtas.campo20 WITH lcImpPerIM ADDITIVE
		REPLACE cur_citivtas.campo21 WITH lcIIInt ADDITIVE
		REPLACE cur_citivtas.campo22 WITH lcTipoResp ADDITIVE
		REPLACE cur_citivtas.campo23 WITH lcCodMon ADDITIVE
		REPLACE cur_citivtas.campo24 WITH lcTipoCbio ADDITIVE
		REPLACE cur_citivtas.campo25 WITH lcCantAlicIVA ADDITIVE
		REPLACE cur_citivtas.campo26 WITH lcCodOper ADDITIVE
		REPLACE cur_citivtas.campo27 WITH lcCAI ADDITIVE
		REPLACE cur_citivtas.campo28 WITH lcFecVto ADDITIVE
		REPLACE cur_citivtas.campo29 WITH lcFecAnul ADDITIVE
		REPLACE cur_citivtas.campo30 WITH lcInfoAdic ADDITIVE
		REPLACE cur_citivtas.campo31 WITH lcFecPagoRet ADDITIVE
		REPLACE cur_citivtas.campo32 WITH lcImpRet ADDITIVE
	ENDIF
	
	IF cur_ventas.impIVA105 <> 0 THEN
		SELECT cur_citivtas
		APPEND BLANK
		REPLACE cur_citivtas.campo1 WITH lcTipoReg
		REPLACE cur_citivtas.campo2 WITH lcFecCbte ADDITIVE
		REPLACE cur_citivtas.campo3 WITH lcTipoCbte ADDITIVE
		REPLACE cur_citivtas.campo4 WITH lcCtrlFisc ADDITIVE
		REPLACE cur_citivtas.campo5 WITH lcPtoVta ADDITIVE
		REPLACE cur_citivtas.campo6 WITH lcNroCbte ADDITIVE
		REPLACE cur_citivtas.campo7 WITH lcNroCbteHH ADDITIVE
		REPLACE cur_citivtas.campo8 WITH lcCodDoc ADDITIVE
		REPLACE cur_citivtas.campo9 WITH lcNroDoc ADDITIVE
		REPLACE cur_citivtas.campo10 WITH lcRazSoc ADDITIVE
		REPLACE cur_citivtas.campo11 WITH lcImpTotOper ADDITIVE
		REPLACE cur_citivtas.campo12 WITH lcTotConc ADDITIVE
		REPLACE cur_citivtas.campo13 WITH lcImpNetoGrav ADDITIVE
		REPLACE cur_citivtas.campo14 WITH lcAlicIVA ADDITIVE
		REPLACE cur_citivtas.campo15 WITH lcImpLiquid ADDITIVE
		REPLACE cur_citivtas.campo16 WITH lcImpLiqRNI ADDITIVE
		REPLACE cur_citivtas.campo17 WITH lcImpOpeExt ADDITIVE
		REPLACE cur_citivtas.campo18 WITH lcImpPerIN ADDITIVE
		REPLACE cur_citivtas.campo19 WITH lcImpPerIIBB ADDITIVE
		REPLACE cur_citivtas.campo20 WITH lcImpPerIM ADDITIVE
		REPLACE cur_citivtas.campo21 WITH lcIIInt ADDITIVE
		REPLACE cur_citivtas.campo22 WITH lcTipoResp ADDITIVE
		REPLACE cur_citivtas.campo23 WITH lcCodMon ADDITIVE
		REPLACE cur_citivtas.campo24 WITH lcTipoCbio ADDITIVE
		REPLACE cur_citivtas.campo25 WITH lcCantAlicIVA ADDITIVE
		REPLACE cur_citivtas.campo26 WITH lcCodOper ADDITIVE
		REPLACE cur_citivtas.campo27 WITH lcCAI ADDITIVE
		REPLACE cur_citivtas.campo28 WITH lcFecVto ADDITIVE
		REPLACE cur_citivtas.campo29 WITH lcFecAnul ADDITIVE
		REPLACE cur_citivtas.campo30 WITH lcInfoAdic ADDITIVE
		REPLACE cur_citivtas.campo31 WITH lcFecPagoRet ADDITIVE
		REPLACE cur_citivtas.campo32 WITH lcImpRet ADDITIVE
	ENDIF
	
	SELECT cur_ventas
	SKIP
ENDDO

loRes.Close_Query()

SELECT cur_citivtas
GO TOP
COPY TO SYS(5) + SYS(2003) + "\intercambio\siscom_citivta_cab.txt" TYPE SDF

RETURN .T.
ENDPROC
PROCEDURE generar_citivtas_v10
LOCAL loRes
LOCAL loResAlic
LOCAL lcSql
LOCAL lcFecDesde
LOCAL lcFecHasta
LOCAL loDateTime
LOCAL lcMes
LOCAL lcDia
LOCAL lcRegistro
LOCAL lnIdVentaC

* Las siguientes variables son para generar cada campo que va a ir
* plasmado en el txt

LOCAL lcFecCbte			&& Fecha del comprobante
LOCAL lcTipoCbte		&& Tipo de comprobante
LOCAL lcPtoVta			&& Punto de venta
LOCAL lcNroCbte			&& Número de comprobante
LOCAL lcNroCbteHH		&& Número de comprobante hasta
LOCAL lcCodDoc			&& Código de documento
LOCAL lcNroDoc			&& Número de documento
LOCAL lcRazSoc			&& Razón Social
LOCAL lcImpTotOper		&& Importe total de la operación
LOCAL lcTotConc			&& Total de conceptos que no integran precio neto
LOCAL lcPercNoCat		&& Importe neto gravado
LOCAL lcImpOpeExt		&& Impuesto de operaciones exenas
LOCAL lcImpPerIN		&& Importe de percepciones de Impuestos imp. nacionales
LOCAL lcImpPerIIBB		&& Importe de percepciones de Ingresos Brutos
LOCAL lcImpPerIM		&& Importe de percepciones de Impuestos Municipales
LOCAL lcIIInt			&& Importe de impuestos internos
LOCAL lcCodMon			&& Código de moneda
LOCAL lcTipoCbio		&& Tipo de cambio
LOCAL lcCantAlicIVA		&& Cantidad de alícuota de IVA
LOCAL lcCodOper			&& Código de operación
LOCAL lcOtroTrib		&& Otros tributos
LOCAL lcFecVto			&& Fecha de vencimiento

&& Alicuotas
LOCAL lcImpNtoGrav		&& Importe neto gravado
LOCAL lcAlicIVA			&& Alícuota de IVA
LOCAL lcImpLiq			&& Impuesto liquidado

loDateTime = CREATEOBJECT("datetime")
loRes = CREATEOBJECT("odbc_result")
loResAlic = CREATEOBJECT("odbc_result")
lcMes = ""
lcDia = ""
lcRegistro = ""
lcSql = ""
lnIdVentaC = 0

lcFecCbte = ""
lcTipoCbte = ""
lcPtoVta = ""
lcNroCbte = ""
lcNroCbteHH = ""
lcCodDoc = ""
lcNroDoc = ""
lcRazSoc = ""
lcImpTotOper = ""
lcTotConc = ""
lcPercNoCat = ""
lcImpOpeExt = ""
lcImpPerIN = ""
lcImpPerIIBB = ""
lcImpPerIM = ""
lcIIInt = ""
lcCodMon = ""
lcTipoCbio = ""
lcCantAlicIVA = ""
lcCodOper = ""
lcOtroTrib = ""
lcFecVto = ""

lcFecDesde = loDateTime.toMySql(Thisform.txtFecDesde.Value)
lcFecHasta = loDateTime.toMySql(Thisform.txtFecHasta.Value)

SELECT cur_citivta10
ZAP
SELECT cur_aliciva10
ZAP

lcSql = "CALL ventascab_getCITIVta (?fechaDD, ?fechaHH)"
lcSql = loRes.AddParameter(lcSql, "fechaDD", Thisform.txtFecDesde.Value, .f., .t.)
lcSql = loRes.AddParameter(lcSql, "fechaHH", Thisform.txtFecHasta.Value, .f., .t.)
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_ventas"
IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_ventas
GO TOP
DO WHILE !EOF("cur_ventas")	
	IF LEN(ALLTRIM(STR(DAY(cur_ventas.fecEmision)))) = 1 THEN
		lcDia = "0" + ALLTRIM(STR(DAY(cur_ventas.fecEmision)))
	ELSE
		lcDia = ALLTRIM(STR(DAY(cur_ventas.fecEmision)))
	ENDIF
	
	IF LEN(ALLTRIM(STR(MONTH(cur_ventas.fecEmision)))) = 1 THEN
		lcMes = "0" + ALLTRIM(STR(MONTH(cur_ventas.fecEmision)))
	ELSE
		lcMes = ALLTRIM(STR(MONTH(cur_ventas.fecEmision)))
	ENDIF
	
	lcFecCbte = ALLTRIM(STR(YEAR(cur_ventas.fecEmision))) + ALLTRIM(lcMes) + ALLTRIM(lcDia)
	lcTipoCbte = REPLICATE("0", 3 - LEN(ALLTRIM(cur_ventas.aut_tipoCbte))) + ALLTRIM(cur_ventas.aut_tipoCbte)
	
	lcPtoVta = REPLICATE("0", 5 - LEN(ALLTRIM(STR(cur_ventas.ptoVta)))) + ;
			ALLTRIM(STR(cur_ventas.ptoVta))
	
	lcNroCbte = REPLICATE("0", 20 - LEN(ALLTRIM(STR(cur_ventas.numCbte)))) + ;
			ALLTRIM(STR(cur_ventas.numCbte))
	
	lcNroCbteHH = lcNroCbte
	lcCodDoc = ALLTRIM(cur_ventas.codAfip)
	lcNroDoc = REPLICATE("0", 20 - LEN(ALLTRIM(cur_ventas.nroDoc))) + ;
			ALLTRIM(cur_ventas.nroDoc)
	
	IF LEN(ALLTRIM(cur_ventas.razSoc)) > 30 THEN
		lcRazSoc = SUBSTR(ALLTRIM(cur_ventas.razSoc), 1, 30)
	ELSE
		lcRazSoc = ALLTRIM(cur_ventas.razSoc) + ;
				REPLICATE(SPACE(1), 30 - LEN(ALLTRIM(cur_ventas.razSoc)))
	ENDIF
	
	lcImpTotOper = STRTRAN(ALLTRIM(STR(cur_ventas.totFact, 10, 2)), ".", "")
	lcImpTotOper = REPLICATE("0", 15 - LEN(ALLTRIM(lcImpTotOper))) + ALLTRIM(lcImpTotOper)
	lcTotConc = REPLICATE("0", 15)
	lcPercNoCat = REPLICATE("0", 15)
		
	lcImpOpeExt = REPLICATE("0", 15)
	lcImpPerIN = REPLICATE("0", 15)
	lcImpPerIIBB = REPLICATE("0", 15)
	lcImpPerIM = REPLICATE("0", 15)
	* lcIIInt = REPLICATE("0", 15)
	lcIIInt = STRTRAN(ALLTRIM(STR(cur_ventas.totaNoGrav, 20, 2)), ".", "")
	lcIIInt = REPLICATE("0", 15 - LEN(ALLTRIM(lcIIInt))) + ALLTRIM(lcIIInt)	
	lcCodMon = "PES"
	lcTipoCbio = "0001000000"
	
	IF cur_ventas.impIVA21 <> 0 .AND. cur_ventas.impIVA105 <> 0 THEN
		lcCantAlicIVA = "2"
	ELSE
		lcCantAlicIVA = "1"
	ENDIF
	
	lcCodOper = "0"
	lcOtroTrib = REPLICATE("0", 15)
	
	IF LEN(ALLTRIM(STR(DAY(cur_ventas.fecVto)))) = 1 THEN
		lcDia = "0" + ALLTRIM(STR(DAY(cur_ventas.fecVto)))
	ELSE
		lcDia = ALLTRIM(STR(DAY(cur_ventas.fecVto)))
	ENDIF
	
	IF LEN(ALLTRIM(STR(MONTH(cur_ventas.fecVto)))) = 1 THEN
		lcMes = "0" + ALLTRIM(STR(MONTH(cur_ventas.fecVto)))
	ELSE
		lcMes = ALLTRIM(STR(MONTH(cur_ventas.fecVto)))
	ENDIF
	
	lcFecVto = ALLTRIM(STR(YEAR(cur_ventas.fecVto))) + ALLTRIM(lcMes) + ALLTRIM(lcDia)
	
	lnIdVentaC = cur_ventas.idVentasC
	
	SELECT cur_citivta10
	APPEND BLANK
	REPLACE cur_citivta10.campo01 WITH lcFecCbte
	REPLACE cur_citivta10.campo02 WITH lcTipoCbte ADDITIVE
	REPLACE cur_citivta10.campo03 WITH lcPtoVta ADDITIVE
	REPLACE cur_citivta10.campo04 WITH lcNroCbte ADDITIVE
	REPLACE cur_citivta10.campo05 WITH lcNroCbteHH ADDITIVE
	REPLACE cur_citivta10.campo06 WITH lcCodDoc ADDITIVE
	REPLACE cur_citivta10.campo07 WITH lcNroDoc ADDITIVE
	REPLACE cur_citivta10.campo08 WITH lcRazSoc ADDITIVE
	REPLACE cur_citivta10.campo09 WITH lcImpTotOper ADDITIVE
	REPLACE cur_citivta10.campo10 WITH lcTotConc ADDITIVE
	REPLACE cur_citivta10.campo11 WITH lcPercNoCat ADDITIVE
	REPLACE cur_citivta10.campo12 WITH lcImpOpeExt ADDITIVE
	REPLACE cur_citivta10.campo13 WITH lcImpPerIN ADDITIVE
	REPLACE cur_citivta10.campo14 WITH lcImpPerIIBB ADDITIVE
	REPLACE cur_citivta10.campo15 WITH lcImpPerIM ADDITIVE
	REPLACE cur_citivta10.campo16 WITH lcIIInt ADDITIVE
	REPLACE cur_citivta10.campo17 WITH lcCodMon ADDITIVE
	REPLACE cur_citivta10.campo18 WITH lcTipoCbio ADDITIVE
	REPLACE cur_citivta10.campo19 WITH lcCantAlicIVA ADDITIVE
	REPLACE cur_citivta10.campo20 WITH lcCodOper ADDITIVE
	REPLACE cur_citivta10.campo21 WITH lcOtroTrib ADDITIVE
	REPLACE cur_citivta10.campo22 WITH lcFecVto ADDITIVE
	
	&& Levanto las alícuotas del detalle de los comprobantes
	lcSql = "CALL ventascab_CITIVtaAlic (?pIdVentasC)"
	lcSql = loResAlic.AddParameter(lcSql, "pIdVentasC", ALLTRIM(STR(lnIdVentaC)), .f., .f.)
	loResAlic.ActiveConnection = goConn.ActiveConnection
	loResAlic.Cursor_Name = "cur_x"
	loResAlic.OpenQuery(lcSql)
	SELECT cur_x
	DO WHILE !EOF("cur_x")
		lcImpNtoGrav = STRTRAN(ALLTRIM(STR(cur_x.impNeto, 10, 2)), ".", "")
		lcImpNtoGrav = REPLICATE("0", 15 - LEN(ALLTRIM(lcImpNtoGrav))) + ALLTRIM(lcImpNtoGrav)
		lcImpLiq = STRTRAN(ALLTRIM(STR(cur_x.impIva, 10, 2)), ".", "")
		lcImpLiq = REPLICATE("0", 15 - LEN(ALLTRIM(lcImpLiq))) + ALLTRIM(lcImpLiq)
		
		SELECT cur_aliciva10
		APPEND BLANK
		REPLACE cur_aliciva10.campo01 WITH ALLTRIM(lcTipoCbte)
		REPLACE cur_aliciva10.campo02 WITH ALLTRIM(lcPtoVta) ADDITIVE
		REPLACE cur_aliciva10.campo03 WITH ALLTRIM(lcNroCbte) ADDITIVE
		REPLACE cur_aliciva10.campo04 WITH ALLTRIM(lcImpNtoGrav) ADDITIVE
		REPLACE cur_aliciva10.campo05 WITH ALLTRIM(cur_x.codAlicIVA) ADDITIVE
		REPLACE cur_aliciva10.campo06 WITH lcImpLiq ADDITIVE
	
		SELECT cur_x
		SKIP
	ENDDO
	loResAlic.Close_Query()
	
	&& Levanto las alícuotas de los comprobantes emitidos por conceptos
	lcSql = "CALL ventascab_CITIVtaAlicCptos (?pIdVentasC)"
	lcSql = loResAlic.AddParameter(lcSql, "pIdVentasC", ALLTRIM(STR(lnIdventaC)), .f., .f.)
	loResAlic.ActiveConnection = goConn.ActiveConnection
	loResAlic.Cursor_Name = "cur_x"
	loResAlic.OpenQuery(lcSql)
	SELECT cur_x
	DO WHILE !EOF("cur_x")
		lcImpNtoGrav = STRTRAN(ALLTRIM(STR(cur_x.impNeto, 10, 2)), ".", "")
		lcImpNtoGrav = REPLICATE("0", 15 - LEN(ALLTRIM(lcImpNtoGrav))) + ALLTRIM(lcImpNtoGrav)
		lcImpLiq = STRTRAN(ALLTRIM(STR(cur_x.impIva, 10, 2)), ".", "")
		lcImpLiq = REPLICATE("0", 15 - LEN(ALLTRIM(lcImpLiq))) + ALLTRIM(lcImpLiq)
		
		SELECT cur_aliciva10
		APPEND BLANK
		REPLACE cur_aliciva10.campo01 WITH ALLTRIM(lcTipoCbte)
		REPLACE cur_aliciva10.campo02 WITH ALLTRIM(lcPtoVta) ADDITIVE
		REPLACE cur_aliciva10.campo03 WITH ALLTRIM(lcNroCbte) ADDITIVE
		REPLACE cur_aliciva10.campo04 WITH ALLTRIM(lcImpNtoGrav) ADDITIVE
		REPLACE cur_aliciva10.campo05 WITH ALLTRIM(cur_x.codAlicIVA) ADDITIVE
		REPLACE cur_aliciva10.campo06 WITH lcImpLiq ADDITIVE
		
		SELECT cur_x
		SKIP
	ENDDO
	loResAlic.Close_Query()
	
	SELECT cur_ventas
	SKIP
ENDDO

loRes.Close_Query()

SELECT cur_citivta10
GO TOP
COPY TO SYS(5) + SYS(2003) + "\intercambio\siscom_citivta_cab.txt" TYPE SDF

SELECT cur_aliciva10
GO TOP
COPY TO SYS(5) + SYS(2003) + "\intercambio\siscom_aliciva.txt" TYPE SDF

MESSAGEBOX("Los archivos para importar CITI Ventas fueron generados satisfactoriamente", 0+64, Thisform.Caption)

RETURN .T.
ENDPROC
PROCEDURE listado_porcbte
LOCAL loRes
LOCAL lcSql
LOCAL lcFecDesde
LOCAL lcFecHasta
LOCAL loDateTime
LOCAL m.fechaDD
LOCAL m.fechaHH
LOCAL lnImpNeto
LOCAL lnImpIVA
LOCAL lnImpRNI
LOCAL lnNoGrav
LOCAL lnExentos
LOCAL lnImpInt
LOCAL lnExporta
LOCAL lnImpuest
LOCAL lnRetIVA
LOCAL lnTotal

loRes = CREATEOBJECT("odbc_result")
loDateTime = CREATEOBJECT("datetime")
lcSql = ""
m.fechaDD = thisform.txtFecDesde.Value
m.fechaHH = thisform.txtFecHasta.Value
lcFecDesde = loDateTime.toMySql(thisform.txtFecDesde.Value)
lcFecHasta = loDateTime.toMySql(thisform.txtFecHasta.Value)

lnImpNeto = 0.00
lnImpIVA = 0.00
lnImpRNI = 0.00
lnNoGrav = 0.00
lnExentos = 0.00
lnImpInt = 0.00
lnExporta = 0.00
lnImpuest = 0.00
lnRetIVA = 0.00
lnTotal = 0.00

lcSql = "SELECT ventascab.cbte, ventascab.tipoDoc, "
lcSql = lcSql + "ventascab.ptoVta, ventascab.impFinal, "
lcSql = lcSql + "ventascab.impIVA21 + impIVA105 AS impIVA, "
lcSql = lcSql + "ventascab.totFact, ventascab.idSitIVA, sitiva.descripcio AS descSitIVA "
lcSql = lcSql + "FROM ventascab "
lcSql = lcSql + "	INNER JOIN sitiva ON sitiva.idSitIVA = ventascab.idSitIVA "
lcSql = lcSql + "WHERE ventascab.cbte NOT IN ('PED', 'COT') "
lcSql = lcSql + "	AND ventascab.fecBaja IS NULL "
lcSql = lcSql + "	AND ventascab.aut_Resultado = 'A' "

IF INT(VAL(getConfig("SQLSRV"))) = 1 THEN
	lcSql = lcSql + " AND CONVERT(CHAR(8), ventascab.FecEmision, 112) between " + lcFecDesde + " and " + lcFecHasta + " "
ELSE
	lcSql = lcSql + " AND CAST(ventascab.FecEmision AS DATE) between " + lcFecDesde + " and " + lcFecHasta + " "
ENDIF

lcSql = lcSql + "ORDER BY ventascab.idSitIVA, ventascab.cbte, ventascab.tipoDoc, ventascab.ptoVta"

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_ventas"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_ventas
GO TOP
DO WHILE !EOF("cur_ventas")
	lnImpNeto = cur_ventas.impFinal
	lnImpIVA = cur_ventas.impIVA
	lnImpRNI = 0
	lnNoGrav = 0
	lnExentos = 0
	lnImpInt = 0
	lnExporta = 0
	lnImpuest = 0
	lnRetIVA = 0
	lnTotal = cur_ventas.totFact

	IF ALLTRIM(cur_ventas.cbte) == "NC" THEN
		lnImpNeto = lnImpNeto * (-1)
		lnImpIVA = lnImpIVA * (-1)
		lnTotal = lnTotal * (-1)
	ENDIF

	SELECT cur_vtabycbte
	APPEND BLANK
	REPLACE cur_vtabycbte.idSitIVA WITH cur_ventas.idSitIVA
	REPLACE cur_vtabycbte.descSIVA WITH cur_ventas.descSitIVA ADDITIVE
	REPLACE cur_vtabycbte.cbte WITH ALLTRIM(cur_ventas.cbte) ADDITIVE
	REPLACE cur_vtabycbte.tipoDoc WITH ALLTRIM(cur_ventas.tipoDoc) ADDITIVE
	
	REPLACE cur_vtabycbte.ptoVta WITH REPLICATE("0", 4 - LEN(ALLTRIM(STR(cur_ventas.ptoVta)))) + ;
			ALLTRIM(STR(cur_ventas.ptoVta)) ADDITIVE
			
	REPLACE cur_vtabycbte.impNeto WITH lnImpNeto ADDITIVE
	REPLACE cur_vtabycbte.impIVA WITH lnImpIVA ADDITIVE
	REPLACE cur_vtabycbte.impRNI WITH lnImpRNI ADDITIVE
	REPLACE cur_vtabycbte.noGrav WITH lnNoGrav ADDITIVE
	REPLACE cur_vtabycbte.exentos WITH lnExentos ADDITIVE
	REPLACE cur_vtabycbte.impInt WITH lnImpInt ADDITIVE
	REPLACE cur_vtabycbte.exporta WITH lnExporta ADDITIVE
	REPLACE cur_vtabycbte.impuest WITH lnImpuest ADDITIVE
	REPLACE cur_vtabycbte.total WITH lnTotal ADDITIVE

	SELECT cur_ventas
	SKIP
ENDDO

SELECT cur_vtabycbte
GO TOP

REPORT FORM "rep_vtasporcbte" TO PRINTER PROMPT NODIALOG PREVIEW

RETURN .T.
ENDPROC
PROCEDURE generar_listado_ivavtas
LOCAL loDateTime, loResult, lcSql, lcGuardar, lnSqlSrv
LOCAL m.fechaDD, m.fechaHH

loDateTime = CREATEOBJECT("datetime")
loResult = CREATEOBJECT("odbc_result")

m.fechaDD = thisform.txtFecDesde.Value
m.fechaHH = thisform.txtFecHasta.Value

SELECT cur_iva
ZAP

lcSql = "CALL ventascab_getIVAVtas (?pFechaDD, ?pFechaHH)"
lcSql = loResult.AddParameter(lcSql, "pFechaDD", m.fechaDD, .f., .t.)
lcSql = loResult.AddParameter(lcSql, "pFechaHH", m.fechaHH, .f., .t.)
loResult.ActiveConnection = goConn.ActiveConnection
loResult.cursor_name = "cur_tempo"
loResult.openquery(lcSql) 

SELECT cur_tempo
IF RECCOUNT("cur_tempo") > 0 THEN 
	SELECT cur_tempo
	GO TOP
	DO WHILE !EOF("cur_tempo")
		SELECT cur_iva
		APPEND BLANK
		REPLACE cur_iva.fecEmis WITH cur_tempo.FecEmision
		REPLACE cur_iva.cbte WITH cur_tempo.cbte ADDITIVE
		REPLACE cur_iva.tipoDoc WITH cur_tempo.tipoDoc ADDITIVE
		REPLACE cur_iva.ptoVta WITH REPLICATE("0", 4 - LEN(ALLTRIM(STR(cur_tempo.ptoVta)))) + ALLTRIM(STR(cur_tempo.ptoVta)) ADDITIVE
		REPLACE cur_iva.nroCbte WITH REPLICATE("0", 8 - LEN(ALLTRIM(STR(cur_tempo.numCbte)))) + ALLTRIM(STR(cur_tempo.numCbte)) ADDITIVE
		REPLACE cur_iva.provincia WITH ALLTRIM(cur_tempo.juris) ADDITIVE
		REPLACE cur_iva.categ WITH ALLTRIM(cur_tempo.cat) ADDITIVE
		REPLACE cur_iva.nroDoc WITH ALLTRIM(cur_tempo.nroDoc) ADDITIVE
		REPLACE cur_iva.no_grav WITH cur_tempo.No_Grav ADDITIVE
		REPLACE cur_iva.grav_p_21 WITH cur_tempo.grav_p_21 ADDITIVE
		REPLACE cur_iva.grav_p_105 WITH cur_tempo.grav_p_105 ADDITIVE
		REPLACE cur_iva.perIIBB WITH cur_tempo.per_iibb ADDITIVE
		REPLACE cur_iva.iva_21 WITH cur_tempo.iva_21 ADDITIVE
		REPLACE cur_iva.iva_105 WITH cur_tempo.iva_105 ADDITIVE
		REPLACE cur_iva.total WITH cur_tempo.total ADDITIVE
	
		SELECT cur_tempo
		SKIP
	ENDDO
	
	SELECT cur_iva
	GO TOP
	REPORT FORM "rep_iva_ventas" TO PRINTER PROMPT NODIALOG PREVIEW
ELSE
	MESSAGEBOX("No hay registros para exportar",0+48,thisform.Caption)
ENDIF 


loResult.close_query()
ENDPROC
PROCEDURE Init
thisform.txtFecDesde.Value = DATE() - 30
Thisform.txtFecHasta.Value = DATE()
ENDPROC
PROCEDURE Load
DODEFAULT()

CREATE CURSOR cur_iva ( ;
	fecEmis d,;
	cbte varchar(3),;
	tipoDoc varchar(1),;
	ptoVta varchar(4),;
	nroCbte varchar(8),;
	provincia varchar(30),;
	categ varchar(3),;
	nroDoc varchar(13),;
	no_grav float(10, 2),;
	grav_p_21 float(10,2),;
	grav_p_105 float(10,2),;
	perIIBB float(10,2),;
	iva_21 float(10,2),;
	iva_105 float(10,2),;
	total float(10,2))
	
CREATE CURSOR cur_citivtas ( ;
	campo1 	varchar(1),;
	campo2 	varchar(8),;
	campo3	varchar(2),;
	campo4	varchar(1),;
	campo5	varchar(4),;
	campo6 	varchar(20),;
	campo7	varchar(20),;
	campo8	varchar(2),;
	campo9	varchar(11),;
	campo10	varchar(30),;
	campo11	varchar(15),;
	campo12 varchar(15),;
	campo13 varchar(15),;
	campo14 varchar(4),;
	campo15	varchar(15),;
	campo16 varchar(15),;
	campo17 varchar(15),;
	campo18 varchar(15),;
	campo19 varchar(15),;
	campo20 varchar(15),;
	campo21 varchar(15),;
	campo22 varchar(2),;
	campo23 varchar(3),;
	campo24 varchar(10),;
	campo25 varchar(1),;
	campo26 varchar(1),;
	campo27 varchar(14),;
	campo28 varchar(8),;
	campo29 varchar(8),;
	campo30 varchar(75),;
	campo31 varchar(8),;
	campo32 varchar(15))
	
CREATE CURSOR cur_citivta10 ( ;
	campo01 varchar(8)	,;
	campo02 varchar(3)	,;
	campo03 varchar(5)	,;
	campo04 varchar(20) ,;
	campo05 varchar(20)	,;
	campo06 varchar(2)	,;
	campo07 varchar(20)	,;
	campo08 varchar(30)	,;
	campo09	varchar(15)	,;
	campo10 varchar(15)	,;
	campo11 varchar(15)	,;
	campo12	varchar(15)	,;
	campo13	varchar(15)	,;
	campo14	varchar(15)	,;
	campo15	varchar(15)	,;
	campo16	varchar(15)	,;
	campo17	varchar(3)	,;
	campo18	varchar(10)	,;
	campo19	varchar(1)	,;
	campo20	varchar(1)	,;
	campo21	varchar(15)	,;
	campo22	varchar(8))
	
CREATE CURSOR cur_aliciva10 ( ;
	campo01 varchar(3) 	,;
	campo02 varchar(5) 	,;
	campo03 varchar(20) ,;
	campo04 varchar(15) ,;
	campo05 varchar(4)	,;
	campo06	varchar(15))
	
	
CREATE CURSOR cur_vtabycbte ( ;
	idSitIVA	int,;
	descSIVA	varchar(30),;
	cbte		varchar(3)	,;
	tipoDoc		varchar(1)	,;
	ptoVta		varchar(4)	,;
	impNeto		float(10, 2),;
	impIVA		float(10, 2),;
	impRNI		float(10, 2),;
	noGrav		float(10, 2),;
	exentos		float(10, 2),;
	impInt		float(10, 2),;
	exporta		float(10, 2),;
	impuest		float(10, 2),;
	retIVA		float(10, 2),;
	total		float(10, 2))

ENDPROC


************************************************************
OBJETO: CLSETIQUETA1
************************************************************
*** PROPIEDADES ***
Caption = "Fecha Desde:"
Height = 15
Left = 13
Top = 24
Width = 78
TabIndex = 6
Name = "CLSETIQUETA1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Fecha Hasta:"
Height = 15
Left = 212
Top = 24
Width = 76
TabIndex = 7
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: txtFecDesde
************************************************************
*** PROPIEDADES ***
Left = 92
TabIndex = 1
Top = 20
isdatetime = .T.
Name = "txtFecDesde"

*** METODOS ***


************************************************************
OBJETO: txtFecHasta
************************************************************
*** PROPIEDADES ***
Left = 290
TabIndex = 2
Top = 20
Name = "txtFecHasta"

*** METODOS ***


************************************************************
OBJETO: Clscerrar1
************************************************************
*** PROPIEDADES ***
Top = 114
Left = 346
TabIndex = 5
Name = "Clscerrar1"

*** METODOS ***


************************************************************
OBJETO: btnExport
************************************************************
*** PROPIEDADES ***
Top = 114
Left = 100
Picture = ..\..\clases\imagen\excel.ico
TabIndex = 4
Name = "btnExport"

*** METODOS ***
PROCEDURE Click
LOCAL lcFecDesde, lcFecHasta, loDateTime, loResult, lcSql, lcGuardar, lnSqlSrv

loDateTime = CREATEOBJECT("datetime")
loResult = CREATEOBJECT("odbc_result")

lcFecDesde = loDateTime.toMySql(thisform.txtFecDesde.Value)
lcFecHasta = loDateTime.toMySql(thisform.txtFecHasta.Value)

lnSqlSrv = VAL(getconfig("SQLSRV"))

&& Hago un select con los cbte que tienen detalle y lo uno a las NC y ND por concepto.
lcSql = "SELECT  ventascab.IdVentasc, "
lcSql = lcSql + " ventascab.FecEmision, "
lcSql = lcSql + " ventascab.Cbte, "
lcSql = lcSql + " ventascab.TipoDoc, "
lcSql = lcSql + " ventascab.PtoVta, "
lcSql = lcSql + " ventascab.NumCbte, "
lcSql = lcSql + " clientes.razsoc as 'Cliente', "
lcSql = lcSql + " provincias.descripcio as 'Juris', "
lcSql = lcSql + " Case sitiva.idsitiva "
lcSql = lcSql + " 	When 1 Then 'RI' "
lcSql = lcSql + " 	When 3 Then 'CF' "
lcSql = lcSql + " 	When 6 Then 'MON' "
lcSql = lcSql + "	Else 'EXE' "
lcSql = lcSql + " End as 'Cat', " 
lcSql = lcSql + " ventascab.nroDoc, "
lcSql = lcSql + " 0 as 'Grav_3', "
lcSql = lcSql + " 0 as 'Exen_3', "
lcSql = lcSql + " Round(SUM(Case When ventasdet.AlicIVA = 21 Then ventasdet.TotNeto Else 0 End) * (Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'Grav_P_21', "
lcSql = lcSql + " Round(SUM(Case When ventasdet.AlicIVA = 10.5 Then ventasdet.TotNeto Else 0 End) * (Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'Grav_P_105', "
lcSql = lcSql + " 0 as 'Exen_P', "
lcSql = lcSql + " Round(ventascab.impIIBB * (Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'Per_IIBB', "
lcSql = lcSql + " Round(ventascab.impIVA21 * (Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'IVA_21', "
lcSql = lcSql + " Round(ventascab.impIVA105 * (Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'IVA_105', "
lcSql = lcSql + " Round(ventascab.totfact * (Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'Total' "
lcSql = lcSql + " FROM    ventascab "
lcSql = lcSql + " 	left join ventasdet on ventascab.idventasc = ventasdet.idventasc "
lcSql = lcSql + "   inner join clientes on ventascab.idcliente = clientes.idcliente "
lcSql = lcSql + "   inner join localidad on clientes.idlocalid = localidad.idlocalid "
lcSql = lcSql + "   inner join provincias on localidad.idprovin = provincias.idprovin"
lcSql = lcSql + "   inner join sitiva on clientes.idsitiva = sitiva.idsitiva "
lcSql = lcSql + " WHERE   ventascab.Cbte NOT IN ('PED','COT','PTO') "
lcSql = lcSql + " 		AND ventascab.idventasc NOT IN (select idventasc from vtadcp) "
lcSql = lcSql + " 		AND ventascab.fecBaja IS NULL "
lcSql = lcSql + "		AND ventascab.aut_Resultado = 'A' "

IF INT(VAL(getConfig("SQLSRV"))) = 1 THEN
	lcSql = lcSql + "         and CONVERT(CHAR(8), ventascab.FecEmision, 112) between " + lcFecDesde + " and " + lcFecHasta + " "
ELSE
	lcSql = lcSql + "         and CAST(ventascab.FecEmision AS DATE) between " + lcFecDesde + " and " + lcFecHasta + " "
ENDIF

lcSql = lcSql + " GROUP BY    ventascab.IdVentasc, "
lcSql = lcSql + "             ventascab.FecEmision, "
lcSql = lcSql + "             ventascab.Cbte, "
lcSql = lcSql + "             ventascab.TipoDoc, "
lcSql = lcSql + "             ventascab.PtoVta, "
lcSql = lcSql + "             ventascab.NumCbte, "
lcSql = lcSql + "             clientes.razsoc, "
lcSql = lcSql + "             ventascab.nroDoc, "
lcSql = lcSql + "             provincias.descripcio, "
lcSql = lcSql + "             sitiva.idsitiva, "
lcSql = lcSql + "             ventasdet.IdVentasc, "
lcSql = lcSql + "             ventascab.ImpNeto, "
lcSql = lcSql + "             ventascab.impIIBB, "
lcSql = lcSql + "             ventascab.impIVA21, "
lcSql = lcSql + "             ventascab.impIVA105, "
lcSql = lcSql + "             ventascab.totfact "

lcSql = lcSql + " UNION " && La UNION de ambos select

lcSql = lcSql + "SELECT  ventascab.IdVentasc, "
lcSql = lcSql + " ventascab.FecEmision, "
lcSql = lcSql + " ventascab.Cbte, "
lcSql = lcSql + " ventascab.TipoDoc, "
lcSql = lcSql + " ventascab.PtoVta, "
lcSql = lcSql + " ventascab.NumCbte, "
lcSql = lcSql + " clientes.razsoc as 'Cliente', "
lcSql = lcSql + " provincias.descripcio as 'Juris', "
lcSql = lcSql + " Case sitiva.idsitiva "
lcSql = lcSql + " 	When 1 Then 'RI' "
lcSql = lcSql + " 	When 3 Then 'CF' "
lcSql = lcSql + " 	When 6 Then 'MON' "
lcSql = lcSql + "	Else 'EXE' "
lcSql = lcSql + " End as 'Cat', " 
lcSql = lcSql + " ventascab.nroDoc, "
lcSql = lcSql + " 0 as 'Grav_3', "
lcSql = lcSql + " 0 as 'Exen_3', "
lcSql = lcSql + " Round(SUM(Case When vtadcp.ivaPor = 21 Then vtadcp.impNeto Else 0 End) * (Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'Grav_P_21', "
lcSql = lcSql + " Round(SUM(Case When vtadcp.ivaPor = 10.5 Then vtadcp.impNeto Else 0 End) * (Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'Grav_P_105', "
lcSql = lcSql + " 0 as 'Exen_P', "
lcSql = lcSql + " Round(ventascab.impIIBB * (Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'Per_IIBB', "
lcSql = lcSql + " Round(ventascab.impIVA21 * (Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'IVA_21', "
lcSql = lcSql + " Round(ventascab.impIVA105 * (Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'IVA_105', "
lcSql = lcSql + " Round(ventascab.totfact * (Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'Total' "
lcSql = lcSql + " FROM    ventascab "
lcSql = lcSql + " 	left join vtadcp on ventascab.idventasc = vtadcp.idventasc "
lcSql = lcSql + "   inner join clientes on ventascab.idcliente = clientes.idcliente "
lcSql = lcSql + "   inner join localidad on clientes.idlocalid = localidad.idlocalid "
lcSql = lcSql + "   inner join provincias on localidad.idprovin = provincias.idprovin"
lcSql = lcSql + "   inner join sitiva on clientes.idsitiva = sitiva.idsitiva "
lcSql = lcSql + " WHERE   ventascab.Cbte NOT IN ('PED','COT','PTO') "
lcSql = lcSql + " 		AND ventascab.idventasc IN (select idventasc from vtadcp) "
lcSql = lcSql + " 		AND ventascab.fecBaja IS NULL "
lcSql = lcSql + "		AND ventascab.aut_Resultado = 'A' "

IF INT(VAL(getConfig("SQLSRV"))) = 1 THEN
	lcSql = lcSql + "         and CONVERT(CHAR(8), ventascab.FecEmision, 112) between " + lcFecDesde + " and " + lcFecHasta + " "
ELSE
	lcSql = lcSql + "         and ventascab.FecEmision between " + lcFecDesde + " and " + lcFecHasta + " "
ENDIF

lcSql = lcSql + " GROUP BY    ventascab.IdVentasc, "
lcSql = lcSql + "             ventascab.FecEmision, "
lcSql = lcSql + "             ventascab.Cbte, "
lcSql = lcSql + "             ventascab.TipoDoc, "
lcSql = lcSql + "             ventascab.PtoVta, "
lcSql = lcSql + "             ventascab.NumCbte, "
lcSql = lcSql + "             clientes.razsoc, "
lcSql = lcSql + "             ventascab.nroDoc, "
lcSql = lcSql + "             provincias.descripcio, "
lcSql = lcSql + "             sitiva.idsitiva, "
lcSql = lcSql + "             vtadcp.IdVentasc, "
lcSql = lcSql + "             ventascab.ImpNeto, "
lcSql = lcSql + "             ventascab.impIIBB, "
lcSql = lcSql + "             ventascab.impIVA21, "
lcSql = lcSql + "             ventascab.impIVA105, "
lcSql = lcSql + "             ventascab.totfact "
lcSql = lcSql + " ORDER BY 	  IdVentasc "

loResult.ActiveConnection = goConn.ActiveConnection
loResult.cursor_name = "cur_tempo"
loResult.openquery(lcSql) 

SELECT cur_tempo
IF RECCOUNT("cur_tempo") > 0 THEN 
	genexcel("cur_tempo", "Listado IVA Ventas")
ELSE
	MESSAGEBOX("No hay registros para exportar",0+48,thisform.Caption)
ENDIF 


loResult.close_query()
ENDPROC


************************************************************
OBJETO: btnImprimir
************************************************************
*** PROPIEDADES ***
Top = 114
Left = 54
Picture = ..\..\clases\imagen\iconos bajados\aha-soft-large-business-printer.ico
TabIndex = 3
Name = "btnImprimir"

*** METODOS ***
PROCEDURE Click
IF Thisform.optgrp.option1.Value = 1 THEN
	Thisform.generar_listado_ivavtas()
ELSE
	IF Thisform.optgrp.option2.Value = 1 THEN
		Thisform.listado_porcbte()
	ELSE
		&& Aca hay que poner el listado por IVA
	ENDIF
ENDIF
ENDPROC


************************************************************
OBJETO: btnExportarCITI
************************************************************
*** PROPIEDADES ***
Top = 114
Left = 8
Height = 44
Width = 45
Picture = ..\..\clases\imagen\floppy_drive.ico
TabIndex = 3
ToolTipText = "Generar archivos CITI Ventas"
Name = "btnExportarCITI"

*** METODOS ***
PROCEDURE Click
IF !Thisform.generar_citivtas_v10() THEN
	MESSAGEBOX("Ha ocurrido un error al intentar generar CITI Ventas", 0+48, Thisform.Caption)
ENDIF
ENDPROC


************************************************************
OBJETO: optgrp
************************************************************
*** PROPIEDADES ***
ButtonCount = 2
BackStyle = 0
Height = 48
Left = 132
Top = 48
Width = 258
Name = "optgrp"
Option1.FontSize = 8
Option1.BackStyle = 0
Option1.Caption = "Listado I.V.A Ventas"
Option1.Height = 15
Option1.Left = 5
Option1.Top = 5
Option1.Width = 187
Option1.ForeColor = 158,106,75
Option1.Name = "Option1"
Option2.FontSize = 8
Option2.BackStyle = 0
Option2.Caption = "Listado de ventas por IVA y comprobante"
Option2.Height = 15
Option2.Left = 5
Option2.Top = 22
Option2.Width = 248
Option2.ForeColor = 158,106,75
Option2.Name = "Option2"

*** METODOS ***


************************************************************
OBJETO: 
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


