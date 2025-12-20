LOCAL m.NroCli, m.RazSoc, m.Telefono, m.direccion, m.localidad, m.codPostal, m.pcia, m.TipoIVA, m.nroCUIT
LOCAL m.Total, m.tipoDoc, m.NroCbte, m.Fecha, m.leyenda, m.fecVto, m.tipoDoc, m.ptoVta
LOCAL m.porDesc1, m.porDesc2, m.porDesc3, m.porDesc4, m.porRec
LOCAL m.impDesc1, m.impDesc2, m.impDesc3, m.impDesc4
LOCAL m.porIIBB, m.impIIBB, m.observ, m.vendedor, m.condPago
LOCAL m.porIVA105, m.impIVA105, m.porIVA21, m.impIVA21, m.impNeto, m.impFinal
LOCAL m.NroRto, m.nroOC
LOCAL lcSql, loNumerador, lcPrinterName, lnCantCpia
LOCAL llEnvMail, llUsaTicket

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
m.Total = 0.00
m.tipoDoc = ""
m.ptoVta = ""
m.NroCbte = ""
m.leyenda = ""
m.Fecha = DATETIME()
m.porIVA105 = 0.00
m.porIVA21 = 0.00
m.impIVA105 = 0.00
m.impIVA21 = 0.00
m.impNeto = 0.00
m.impFinal = 0.00
m.fecVto = DATE() + thisform.cp_cntdias
m.tipoDoc = Thisform.tipodoc
m.porIIBB = 0.00
m.impIIBB = 0.00
lnCantCpia = 0
m.observ = ""
m.vendedor = thisform.nombre_usuario
m.NroRto = ""
m.nroOC = Thisform.contenido.txtoc.Value
m.porRec = Thisform.Contenido.txtPorRec.Value
m.condPago = IIF(This.idCondPago = 1, "CONTADO", "CUENTAS CORRIENTES")
m.NroCbte = Thisform.ptovta + "-" + Thisform.nrocbte
llUsaTicket = .F.

&& Levanto la configuración de impresora para este puesto de trabajo

lcSql = "SELECT * FROM impresoras "
lcSql = lcSql + "WHERE hostName = '" + ALLTRIM(SYS(0)) + "' "
lcSql = lcSql + "	AND idNum = " + ALLTRIM(STR(Thisform.idNum))

loNumerador.ActiveConnection = goConn.ActiveConnection
loNumerador.Cursor_Name = "cur_num"

IF !loNumerador.OpenQuery(lcSql) THEN
	MESSAGEBOX(loNumerador.Error_Message, 0+48, Thisform.Caption)
	RETURN
ENDIF

SELECT cur_num
IF RECCOUNT("cur_num") = 0 THEN
	MESSAGEBOX("No hay impresora configurada para este puesto de trabajo", 0+48, Thisform.Caption)
	loNumerador.Close_Query()
	RETURN
ENDIF

lcPrinterName = ALLTRIM(cur_Num.impresora)
lnCantCpia = cur_Num.copias
llUsaTicket = cur_num.usa_ticket

loNumerador.Close_Query()
SELECT cur_Subtotal

m.leyenda = "PRESUPUESTO"
m.tipoDoc = "X"
m.Total = cur_Subtotal.totFact
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

SET PRINTER TO NAME ALLTRIM(lcPrinterName)
SELECT cur_aux

IF !(TYPE("thisform.contenido.txtObserv.Value") == "C") THEN
	m.observ = ""
ELSE
	m.observ = thisform.contenido.txtObserv.Value + " "
ENDIF

&& Verifico si hay que imprimir el comprobante y sea por ticket o impresora
IF Thisform.contenido.chkImprimirCbte.Value THEN
	FOR i = 1 TO lnCantCpia
		SET PRINTER TO NAME ALLTRIM(lcPrinterName)
		IF llUsaTicket THEN
			****************************************************************************
			* Envío a imprimir el ticket
			****************************************************************************
			Thisform.oticket.limpiar_datos()
			Thisform.oticket.codigo_cbte = "XX"
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
			SELECT cur_aux
			GO TOP
			DO WHILE !EOF("cur_aux")
				Thisform.oticket.add_item(cur_aux.codArt, cur_aux.descripcio, cur_aux.cantidad,;
						cur_aux.alicIVA, ROUND(cur_aux.impNeto + cur_aux.impNeto * (cur_aux.alicIVA / 100),2), cur_aux.subtotal)
				SELECT cur_aux
				SKIP
			ENDDO
			Thisform.oticket.total_neto = m.impNeto
			Thisform.oticket.total_imp_iva21 = m.impIVA21
			Thisform.oticket.total_imp_iva105 = m.impIVA105
			Thisform.oticket.total = m.Total
			Thisform.oticket.nro_cae = ""
			THisform.oticket.vto_cae = ""
			Thisform.oticket.imprimir()	
		ELSE
			&& Imprime un presupuesto
			SELECT cur_aux
			REPORT FORM "reppto.frx" TO PRINTER NOCONSOLE	
		ENDIF
	NEXT
ENDIF

IF TYPE("Thisform.Contenido.chkEnviarMail.Value") == "L" THEN
	llEnvMail = Thisform.Contenido.chkEnviarMail.Value
ELSE
	IF Thisform.Contenido.chkEnviarMail.Value = 1 THEN
		llEnvMail = .T.
	ELSE
		llEnvMail = .F.
	ENDIF
ENDIF

IF llEnvMail THEN
	&& Imprime un presupuesto
	SELECT cur_aux
	enviar_cbtemail("reppto.frx",  ALLTRIM(Thisform.cbte),;
			m.tipoDoc, m.NroCbte, ALLTRIM(Thisform.Contenido.txtMailFC.Value),;
			m.Fecha, m.nroCli, m.razSoc, m.direccion, m.codPostal,;
			m.localidad, m.pcia, m.tipoIVA, m.fecVto, m.nroCUIT	,;
			m.nroOC, m.leyenda, m.impNeto, m.Total, m.impIVA21,;
			m.impIVA105, m.porIIBB, m.impIIBB, m.Total, m.observ, m.condPago)
ENDIF