************************************************************
OBJETO: datequivs
************************************************************
*** PROPIEDADES ***
Name = "datequivs"

*** METODOS ***
PROCEDURE create_cursor
LOCAL i, cField

cField = ""

rs = CREATEOBJECT("odbc_Result")

rs.Cursor_Name = "cur_Equivs"

rs.ActiveConnection = goConn.ActiveConnection

rs.OpenQuery("SELECT idmaearti, codarti, nomarti FROM MaeArti WHERE 1 = 2")

&& Creo los índices para el cursor

SELECT (rs.Cursor_Name)
FOR i = 1 TO FCOUNT()
	cField = ALLTRIM(FIELD(i, rs.Cursor_Name))
	cField = SUBSTR(cField, 1, 10)
	
	IF i = 1
		IF TYPE(cField) != "M" .AND. TYPE(cField) != "G"
			INDEX ON &cField TAG &cField ASCENDING
		ENDIF
	ELSE
		IF TYPE(cField) != "M" .AND. TYPE(cField) != "G"
			INDEX ON &cField TAG &cField ASCENDING ADDITIVE
		ENDIF
	ENDIF
NEXT i

&& Me posiciono sobre el primer registro
IF RECCOUNT() > 0
	GO TOP
ENDIF
ENDPROC


************************************************************
OBJETO: cl_ingreso_merc
************************************************************
*** PROPIEDADES ***
codusu = 
idhostalta = 
errormessage = 
Name = "cl_ingreso_merc"

*** METODOS ***
PROCEDURE crear_cursor
***********************************************************************
* Creo el cursor con los remitos pendientes a controlar
***********************************************************************

CREATE CURSOR cur_busq_rtos (	;
	idIngCab		int,;
	idprov 			int,;
	cbte			varchar(3),;
	tipo			varchar(1),;
	numero			varchar(13),;
	fecha			datetime,;
	controla		L)

SELECT cur_busq_rtos
INDEX on idIngCab TAG idIngCab ASCENDING 
INDEX on idprov TAG idprov ASCENDING ADDITIVE 
INDEX on cbte TAG cbte ASCENDING ADDITIVE 
INDEX on tipo TAG tipo ASCENDING ADDITIVE 
INDEX on numero TAG numero ASCENDING ADDITIVE 
INDEX on fecha TAG fecha ASCENDING ADDITIVE 
INDEX on controla TAG controla ASCENDING ADDITIVE

SET ORDER TO TAG fecha ASCENDING 
ENDPROC
PROCEDURE leer_det_rto
***************************************************************************
* Este método permite leer los remitos pendientes de controlar físicamente
***************************************************************************
PARAMETERS lnidIngCab

LOCAL lcSql, loRsRtos

lcSql = ""
loRsRtos = CREATEOBJECT("odbc_result")

SELECT cur_det_rto
ZAP

lcSql = "SELECT	stk_ingdet.*, "
lcSql = lcSql + "	articulos.descripcio "
lcSql = lcSql + "FROM	stk_ingdet "
lcSql = lcSql + "	INNER JOIN articulos ON articulos.idArticulo = stk_ingdet.idArticulo "
lcSql = lcSql + "WHERE stk_ingdet.idingcab = " + ALLTRIM(STR(lnidIngCab)) + " "
lcSql = lcSql + "ORDER BY stk_ingdet.codArt ASC"

loRsRtos.ActiveConnection = goConn.ActiveConnection
loRsRtos.Cursor_Name = "cur_tempo"
loRsRtos.OpenQuery(lcSql)

SELECT cur_tempo
IF RECCOUNT("cur_tempo") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_tempo")
	SELECT cur_det_rto
	APPEND BLANK
	REPLACE cur_det_rto.codArt WITH cur_tempo.codArt ADDITIVE
	REPLACE cur_det_rto.descripcio WITH cur_tempo.descripcio ADDITIVE
	REPLACE cur_det_rto.cantidad WITH cur_tempo.cantidad ADDITIVE
	REPLACE cur_det_rto.cantReci WITH IIF(cur_busq_rtos.controla = .F., 0, cur_tempo.cantReci) ADDITIVE
	REPLACE cur_det_rto.nroPart WITH cur_tempo.nroPart ADDITIVE

	SELECT cur_tempo
	SKIP
ENDDO

loRsRtos.Close_Query()

SELECT cur_det_rto
IF RECCOUNT("cur_det_rto") > 0 THEN
	GO TOP
ENDIF
ENDPROC
PROCEDURE buscar_rtos
******************************************************************************************************
* Este método permite buscar los ingreso de mercaderia de acuerdo a lo filtrado
******************************************************************************************************
PARAMETERS lcfecDesde, lcfecHasta, lnProvDesde, lnProvHasta, lccbte, lctipo, lcnumero, lclistcbtes 

LOCAL lcSql, loRsRtos

lcSql = ""
loRsRtos = CREATEOBJECT("odbc_result")

SELECT cur_busq_rtos
ZAP

lcSql = "SELECT	stk_ingcab.idingcab, "
lcSql = lcSql + "	stk_ingcab.idProv, "
lcSql = lcSql + "	stk_ingcab.cbte, "
lcSql = lcSql + "	stk_ingcab.tipo, "
lcSql = lcSql + "	stk_ingcab.numero, "
lcSql = lcSql + "	stk_ingcab.fecha, "
lcSql = lcSql + "	stk_ingcab.controla "
lcSql = lcSql + "FROM	stk_ingcab "
lcSql = lcSql + "WHERE "

IF INT(VAL(getConfig("SQLSRV"))) = 1 THEN
	lcSql = lcSql + "         (CONVERT(CHAR(8), fecha , 112) BETWEEN " + lcFecDesde + " AND " + lcFecHasta + ") "
ELSE
	IF INT(VAL(getConfig("SQLSRV"))) = 0 THEN
		lcSql = lcSql + "         (CAST(fecha AS DATE) BETWEEN " + lcFecDesde + " AND " + lcFecHasta + ") "
	ELSE
		lcSql = lcSql + "         (fecha BETWEEN " + lcFecDesde + " AND " + lcFecHasta + ") "
	ENDIF
ENDIF

IF lnProvDesde <> 0 THEN
	lcSql = lcSql + " AND idProv >= " + ALLTRIM(STR(lnProvDesde))
ENDIF 

IF lnProvHasta <> 0 THEN
	lcSql = lcSql + " AND idProv <= " + ALLTRIM(STR(lnProvHasta)) 
ENDIF 

IF ALLTRIM(lccbte) == "Todos" THEN 
	lcSql = lcSql + "	  AND Cbte IN (" + lclistcbtes + ")"
ELSE 
	lcSql = lcSql + "	  AND Cbte = '" + ALLTRIM(lccbte) + "' "
ENDIF 

IF ALLTRIM(lctipo) != "Todos" THEN 
	lcSql = lcSql + "	  AND tipo = '" + ALLTRIM(lctipo) + "' "
ENDIF 

IF ALLTRIM(lcnumero) != "0000-00000000" THEN
	lcSql = lcSql + " AND numero = '" + lcnumero + "' "  
ENDIF 

lcSql = lcSql + "ORDER BY stk_ingcab.fecha ASC"

loRsRtos.ActiveConnection = goConn.ActiveConnection
loRsRtos.Cursor_Name = "cur_tempo"
loRsRtos.OpenQuery(lcSql)

SELECT cur_tempo
IF RECCOUNT("cur_tempo") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_tempo")
	SELECT cur_busq_rtos
	APPEND BLANK
	REPLACE cur_busq_rtos.idIngCab WITH cur_tempo.idIngCab 
	REPLACE cur_busq_rtos.idProv WITH cur_tempo.idProv ADDITIVE
	REPLACE cur_busq_rtos.cbte WITH cur_tempo.cbte ADDITIVE
	REPLACE cur_busq_rtos.tipo WITH cur_tempo.tipo ADDITIVE
	REPLACE cur_busq_rtos.numero WITH cur_tempo.numero ADDITIVE
	REPLACE cur_busq_rtos.fecha WITH cur_tempo.fecha ADDITIVE
	REPLACE cur_busq_rtos.controla WITH cur_tempo.controla ADDITIVE 

	SELECT cur_tempo
	SKIP
ENDDO

loRsRtos.Close_Query()

SELECT cur_busq_rtos
IF RECCOUNT("cur_busq_rtos") > 0 THEN
	GO TOP
ENDIF
ENDPROC
PROCEDURE crear_cursor_detalle
***********************************************************
* Creo el cursor de detalle
***********************************************************

CREATE CURSOR cur_det_rto (	;
	idIngDet		int,;
	idIngCab		int,;
	idArticulo		int,;
	codArt			varchar(20),;
	descripcio		varchar(60),;
	cbte			varchar(3),;
	tipo			varchar(1),;
	nroPart			varchar(30),;
	numero			varchar(13),;
	cantidad		float(10, 2),;
	cantReci		float(10, 2))
	
	
SELECT cur_det_rto
INDEX on idIngDet TAG idIngDet ASCENDING 
INDEX on idIngCab TAG idIngCab ASCENDING ADDITIVE 
INDEX on idArticulo TAG idArticulo ASCENDING ADDITIVE 
INDEX on codArt TAG codArt ASCENDING ADDITIVE 
INDEX on descripcio TAG descripcio ASCENDING ADDITIVE 
INDEX on cbte TAG cbte ASCENDING ADDITIVE 
INDEX on tipo TAG   ASCENDING ADDITIVE 
INDEX on nroPart TAG nroPart ASCENDING ADDITIVE 
INDEX on numero TAG numero ASCENDING ADDITIVE 
INDEX on cantidad TAG cantidad ASCENDING ADDITIVE 
INDEX on cantReci TAG cantReci ASCENDING ADDITIVE 

SET ORDER TO TAG codart ASCENDING 
ENDPROC
PROCEDURE Init
this.codusu = ALLTRIM(gcCodUsu)
this.idHostAlta = ALLTRIM(SYS(0))

ENDPROC


************************************************************
OBJETO: cl_procvtas
************************************************************
*** PROPIEDADES ***
connectionstring = 
conexion = 
errormessage = 
fecdesde = {}
fechasta = {}
Name = "cl_procvtas"

*** METODOS ***
PROCEDURE crear_cursor
***********************************************************************
* Creo el cursor que va a tener el sistema
***********************************************************************

CREATE CURSOR cur_ventas (	;
	idVentaC		int,;
	Fecha			datetime,;
	tipo_Comp		varchar(3),;
	letra			varchar(1),;
	ptoVta			varchar(4),;
	numero			varchar(8),;
	codCli			varchar(6),;
	razSoc			varchar(40),;
	cod_Juris		varchar(3),;
	juris			varchar(30),;
	cat				varchar(3),;
	cuit			varchar(11),;
	imp_exento		float(10,2),;
	imp_Grav21		float(10,2),;
	imp_Grav105		float(10,2),;
	iva_21			float(10,2),;
	iva_105			float(10,2),;
	percepcion		float(10,2))
	

ENDPROC
PROCEDURE leer_datos
LOCAL lcSql, loVentas, loItems, loProg, lnCont, loDT
LOCAL lnGravado21, lnGravado105

lcSql = ""
ldFecha = DATE()
loVentas = CREATEOBJECT("odbc_result")
loItems = CREATEOBJECT("odbc_result")
loProg = CREATEOBJECT("_thermometer")
loDT = CREATEOBJECT("datetime")
lnGravado21 = 0.00
lnGravado105 = 0.00
lnCont = 0

lcFecDesde = loDT.toMySql(This.fecDesde)
lcFecHasta = loDT.toMySql(This.fecHasta)

WAIT WINDOW "Generando ventas..." NOWAIT

*!*	lcSql = "SELECT		ventascab.idVentasC, "
*!*	lcSql = lcSql + "	ventascab.fecEmision, "
*!*	lcSql = lcSql + "	ventascab.cbte, "
*!*	lcSql = lcSql + "	ventascab.tipoDoc, "
*!*	lcSql = lcSql + "	REPLICATE('0', 4 - LEN(LTRIM(RTRIM(ventascab.ptoVta)))) + LTRIM(RTRIM(ventascab.ptoVta)) AS ptoVta, "
*!*	lcSql = lcSql + "	REPLICATE('0', 8 - LEN(LTRIM(RTRIM(ventascab.numCbte)))) + LTRIM(RTRIM(ventascab.numCbte)) AS numero, "
*!*	lcSql = lcSql + "	clientes.idCliente, "
*!*	lcSql = lcSql + "	clientes.razSoc, "
*!*	lcSql = lcSql + "	REPLICATE('0', 3 - LEN(LTRIM(RTRIM(localidad.idProvin)))) + LTRIM(RTRIM(localidad.idProvin)) AS codJuris, "
*!*	lcSql = lcSql + "	provincias.descripcio AS juris, "
*!*	lcSql = lcSql + "	CASE WHEN clientes.idSitIVA = 1 THEN 'RI' "
*!*	lcSql = lcSql + "		ELSE (CASE WHEN clientes.idSitIVA = 3 THEN 'CF' "
*!*	lcSql = lcSql + "		ELSE (CASE WHEN clientes.idSitIVA = 6 THEN 'MON' "
*!*	lcSql = lcSql + "		ELSE 'X' END) END) END Cat, "
*!*	lcSql = lcSql + "	clientes.nroCuit, "
*!*	lcSql = lcSql + "	0 AS impExento, "
*!*	lcSql = lcSql + "	ventascab.impIVA21 AS imp_iva21, "
*!*	lcSql = lcSql + "	ventascab.impIVA105 AS imp_iva105, "
*!*	lcSql = lcSql + "	ventascab.impIIBB AS percepcion "	
*!*	lcSql = lcSql + "FROM	ventascab "
*!*	lcSql = lcSql + "	INNER JOIN clientes ON clientes.idCliente = ventascab.idCliente "
*!*	lcSql = lcSql + "	INNER JOIN localidad ON localidad.idLocalid = clientes.idLocalid "
*!*	lcSql = lcSql + "	INNER JOIN provincias ON provincias.idProvin = localidad.idProvin "

*!*	IF INT(VAL(getConfig("SQLSRV"))) = 1 THEN
*!*		lcSql = lcSql + "WHERE CONVERT(CHAR(8), ventascab.fecEmision, 112) BETWEEN " + loDT.toMySql(This.fecDesde) + " AND " + loDT.toMySql(This.fecHasta)
*!*	ELSE
*!*		lcSql = lcSql + "WHERE ventascab.fecEmision BETWEEN " + loDT.toMySql(This.fecDesde) + " AND " + loDT.toMySql(This.fecHasta)
*!*	ENDIF


&& Hago un select con los cbte que tienen detalle y lo uno a las NC y ND por concepto.
lcSql = "SELECT  ventascab.IdVentasc, "
lcSql = lcSql + " ventascab.FecEmision, "
lcSql = lcSql + " ventascab.Cbte, "
lcSql = lcSql + " ventascab.TipoDoc, "
lcSql = lcSql + " REPLICATE('0', 4 - LEN(LTRIM(RTRIM(ventascab.ptoVta)))) + LTRIM(RTRIM(ventascab.ptoVta)) AS ptoVta, "
lcSql = lcSql + " REPLICATE('0', 8 - LEN(LTRIM(RTRIM(ventascab.numCbte)))) + LTRIM(RTRIM(ventascab.numCbte)) AS numero, "
lcSql = lcSql + " clientes.idCliente, "
lcSql = lcSql + " clientes.razsoc, "
lcSql = lcSql + " REPLICATE('0', 3 - LEN(LTRIM(RTRIM(localidad.idProvin)))) + LTRIM(RTRIM(localidad.idProvin)) AS codJuris, "
lcSql = lcSql + " provincias.descripcio as 'Juris', "
lcSql = lcSql + " Case sitiva.idsitiva "
lcSql = lcSql + " 	When 1 Then 'RI' "
lcSql = lcSql + " 	When 3 Then 'CF' "
lcSql = lcSql + " 	When 6 Then 'MON' "
lcSql = lcSql + "	Else 'EXE' "
lcSql = lcSql + " End as 'Cat', " 
lcSql = lcSql + " clientes.Nrocuit, "
lcSql = lcSql + "	0 AS impExento, "
lcSql = lcSql + " Round(SUM(Case When ventasdet.AlicIVA = 21 Then ventasdet.TotNeto Else 0 End) * (Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'Grav_P_21', "
lcSql = lcSql + " Round(SUM(Case When ventasdet.AlicIVA = 10.5 Then ventasdet.TotNeto Else 0 End) * (Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'Grav_P_105', "
lcSql = lcSql + " Round(ventascab.impIIBB * (Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'Per_IIBB', "
lcSql = lcSql + " Round(ventascab.impIVA21 * (Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'IVA_21', "
lcSql = lcSql + " Round(ventascab.impIVA105 * (Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'IVA_105' "
lcSql = lcSql + " FROM    ventascab "
lcSql = lcSql + " 	left join ventasdet on ventascab.idventasc = ventasdet.idventasc "
lcSql = lcSql + "   inner join clientes on ventascab.idcliente = clientes.idcliente "
lcSql = lcSql + "   inner join localidad on clientes.idlocalid = localidad.idlocalid "
lcSql = lcSql + "   inner join provincias on localidad.idprovin = provincias.idprovin"
lcSql = lcSql + "   inner join sitiva on clientes.idsitiva = sitiva.idsitiva "
lcSql = lcSql + " WHERE   ventascab.Cbte NOT IN ('PED','COT','PTO') "
lcSql = lcSql + " 		AND ventascab.idventasc NOT IN (select idventasc from vtadcp) "

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
lcSql = lcSql + "             clientes.idcliente, "
lcSql = lcSql + "             clientes.razsoc, "
lcSql = lcSql + "             localidad.idprovin, "
lcSql = lcSql + "             clientes.nrocuit, "
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
lcSql = lcSql + " REPLICATE('0', 4 - LEN(LTRIM(RTRIM(ventascab.ptoVta)))) + LTRIM(RTRIM(ventascab.ptoVta)) AS ptoVta, "
lcSql = lcSql + " REPLICATE('0', 8 - LEN(LTRIM(RTRIM(ventascab.numCbte)))) + LTRIM(RTRIM(ventascab.numCbte)) AS numero, "
lcSql = lcSql + " clientes.idCliente, "
lcSql = lcSql + " clientes.razsoc, "
lcSql = lcSql + " REPLICATE('0', 3 - LEN(LTRIM(RTRIM(localidad.idProvin)))) + LTRIM(RTRIM(localidad.idProvin)) AS codJuris, "
lcSql = lcSql + " provincias.descripcio as 'Juris', "
lcSql = lcSql + " Case sitiva.idsitiva "
lcSql = lcSql + " 	When 1 Then 'RI' "
lcSql = lcSql + " 	When 3 Then 'CF' "
lcSql = lcSql + " 	When 6 Then 'MON' "
lcSql = lcSql + "	Else 'EXE' "
lcSql = lcSql + " End as 'Cat', " 
lcSql = lcSql + " clientes.Nrocuit, "
lcSql = lcSql + "	0 AS impExento, "
lcSql = lcSql + " Round(SUM(Case When vtadcp.ivaPor = 21 Then vtadcp.impNeto Else 0 End) * (Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'Grav_P_21', "
lcSql = lcSql + " Round(SUM(Case When vtadcp.ivaPor = 10.5 Then vtadcp.impNeto Else 0 End) * (Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'Grav_P_105', "
lcSql = lcSql + " Round(ventascab.impIIBB * (Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'Per_IIBB', "
lcSql = lcSql + " Round(ventascab.impIVA21 * (Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'IVA_21', "
lcSql = lcSql + " Round(ventascab.impIVA105 * (Case When ventascab.Cbte = 'NC' Then -1 Else 1 End),2) as 'IVA_105' "
lcSql = lcSql + " FROM    ventascab "
lcSql = lcSql + " 	left join vtadcp on ventascab.idventasc = vtadcp.idventasc "
lcSql = lcSql + "   inner join clientes on ventascab.idcliente = clientes.idcliente "
lcSql = lcSql + "   inner join localidad on clientes.idlocalid = localidad.idlocalid "
lcSql = lcSql + "   inner join provincias on localidad.idprovin = provincias.idprovin"
lcSql = lcSql + "   inner join sitiva on clientes.idsitiva = sitiva.idsitiva "
lcSql = lcSql + " WHERE   ventascab.Cbte NOT IN ('PED','COT','PTO') "
lcSql = lcSql + " 		AND ventascab.idventasc IN (select idventasc from vtadcp) "

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
lcSql = lcSql + "             clientes.idcliente, "
lcSql = lcSql + "             clientes.razsoc, "
lcSql = lcSql + "             localidad.idprovin, "
lcSql = lcSql + "             clientes.nrocuit, "
lcSql = lcSql + "             provincias.descripcio, "
lcSql = lcSql + "             sitiva.idsitiva, "
lcSql = lcSql + "             vtadcp.IdVentasc, "
lcSql = lcSql + "             ventascab.ImpNeto, "
lcSql = lcSql + "             ventascab.impIIBB, "
lcSql = lcSql + "             ventascab.impIVA21, "
lcSql = lcSql + "             ventascab.impIVA105, "
lcSql = lcSql + "             ventascab.totfact "
lcSql = lcSql + " ORDER BY 	  ventascab.IdVentasc "

loVentas.ActiveConnection = goConn.ActiveConnection
loVentas.Cursor_Name = "cur_tmpVtas"

IF !loVentas.OpenQuery(lcSql) THEN
	This.errorMessage = loVentas.Error_Message
	RETURN .F.
ENDIF

loProg.Show()

SELECT cur_tmpVtas
IF RECCOUNT("cur_tmpVtas") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_tmpVtas")
	SELECT cur_ventas
	APPEND BLANK
	REPLACE cur_ventas.idVentaC WITH cur_tmpVtas.idVentasC
	REPLACE cur_ventas.Fecha WITH cur_tmpVtas.fecEmision ADDITIVE
	REPLACE cur_ventas.tipo_Comp WITH cur_tmpVtas.cbte ADDITIVE
	REPLACE cur_ventas.letra WITH cur_tmpVtas.tipoDoc ADDITIVE
	REPLACE cur_ventas.ptoVta WITH cur_tmpVtas.ptoVta ADDITIVE
	REPLACE cur_ventas.numero WITH cur_tmpVtas.numero ADDITIVE
	REPLACE cur_ventas.codCli WITH ALLTRIM(STR(cur_tmpVtas.idCliente)) ADDITIVE
	REPLACE cur_ventas.razSoc WITH ALLTRIM(cur_tmpVtas.razSoc) ADDITIVE
	REPLACE cur_ventas.cod_Juris WITH ALLTRIM(cur_tmpVtas.codJuris) ADDITIVE
	REPLACE cur_ventas.juris WITH ALLTRIM(cur_tmpVtas.juris) ADDITIVE
	REPLACE cur_ventas.cat WITH ALLTRIM(cur_tmpVtas.Cat) ADDITIVE
	REPLACE cur_ventas.cuit WITH cur_tmpVtas.nroCuit ADDITIVE
	REPLACe cur_ventas.imp_exento WITH cur_tmpVtas.impExento ADDITIVE
	REPLACE cur_ventas.imp_Grav21 WITH cur_tmpVtas.Grav_P_21 ADDITIVE
	REPLACE cur_ventas.imp_Grav105 WITH cur_tmpVtas.Grav_P_105 ADDITIVE
	REPLACE cur_ventas.iva_21 WITH cur_tmpVtas.IVA_21 ADDITIVE
	REPLACE cur_ventas.iva_105 WITH cur_tmpVtas.IVA_105 ADDITIVE
	REPLACE cur_ventas.percepcion WITH cur_tmpVtas.Per_IIBB ADDITIVE

	lnCont = lnCont + 1
	WAIT WINDOW "Procesando " + ALLTRIM(STR(lnCont)) + " de " + ALLTRIM(STR(RECCOUNT("cur_tmpVtas"))) + "..." NOWAIT
	loProg.Update((lnCont * 100) / RECCOUNT("cur_ventas"), "Generando Ventas...")
	SELECT cur_tmpVtas
	SKIP
ENDDO

loVentas.Close_Query()
WAIT WINDOW "Registros Generados..." NOWAIT

SELECT cur_ventas
IF RECCOUNT("cur_ventas") > 0 THEN
	GO TOP
ENDIF

loProg.Complete()

RETURN .T.
ENDPROC
PROCEDURE grabar
LOCAL lcSql, loCommand, loConn, loProg
LOCAL lnCont, loDT

lcSql = ""
loCommand = CREATEOBJECT("odbc_command")
loConn = CREATEOBJECT("odbc_connect")
loProg = CREATEOBJECT("_thermometer")
loDT = CREATEOBJECT("datetime")
lnCont = 0

loProg.Show()

loConn.ConnectionString = "Driver=Microsoft Access Driver (*.mdb);uid=admin;pwd=;DBQ=data\EstudioContable.mdb"
IF !loConn.Open() THEN
	This.ErrorMessage = loConn.ErrorMessage
	RETURN .F.
ENDIF

lcSql = "DELETE FROM ventas"
loCommand.ActiveConnection = loConn.ActiveConnection
loCommand.CommandText = lcSql

IF !loCommand.Execute() THEN
	This.ErrorMessage = loCommand.ErrorMessage
	RETURN .F.
ENDIF

SELECT cur_ventas
DO WHILE !EOF("cur_ventas")
	lcSql = "INSERT INTO ventas ( "
	lcSql = lcSql + "ID, "
	lcSql = lcSql + "Fecha, "
	lcSql = lcSql + "Tipo_Comp, "
	lcSql = lcSql + "Letra, "
	lcSql = lcSql + "PtoVta, "
	lcSql = lcSql + "Numero, "
	lcSql = lcSql + "CodCli, "
	lcSql = lcSql + "RazSoc, "
	lcSql = lcSql + "Cod_Juris, "
	lcSql = lcSql + "Juris, "
	lcSql = lcSql + "Cat, "
	lcSql = lcSql + "Cuit, "
	lcSql = lcSql + "Imp_Exento, "
	lcSql = lcSql + "Imp_Gravado_21, "
	lcSql = lcSql + "Imp_Gravado_105, "
	lcSql = lcSql + "IVA_21, "
	lcSql = lcSql + "IVA_105, "
	lcSql = lcSql + "Percepcion) VALUES ( "
	lcSql = lcSql + ALLTRIM(STR(cur_ventas.idVentaC)) + ", "
	lcSql = lcSql + "#" + ALLTRIM(STR(YEAR(cur_ventas.Fecha))) + "-" + ALLTRIM(STR(MONTH(cur_ventas.Fecha))) + "-" + ALLTRIM(STR(DAY(cur_ventas.Fecha))) + "#, "
	lcSql = lcSql + "'" + ALLTRIM(cur_ventas.Tipo_Comp) + "', "
	lcSql = lcSql + "'" + ALLTRIM(cur_ventas.Letra) + "', "
	lcSql = lcSql + "'" + ALLTRIM(cur_ventas.ptoVta) + "', "
	lcSql = lcSql + "'" + ALLTRIM(cur_ventas.Numero) + "', "
	lcSql = lcSql + "'" + ALLTRIM(cur_ventas.codCli) + "', "
	lcSql = lcSql + "'" + ALLTRIM(cur_ventas.razSoc) + "', "
	lcSql = lcSql + "'" + ALLTRIM(cur_ventas.cod_Juris) + "', "
	lcSql = lcSql + "'" + ALLTRIM(cur_ventas.Juris) + "', "
	lcSql = lcSql + "'" + ALLTRIM(cur_ventas.cat) + "', "
	lcSql = lcSql + "'" + ALLTRIM(cur_ventas.Cuit) + "', "
	lcSql = lcSql + ALLTRIM(STR(cur_ventas.imp_Exento, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_ventas.imp_Grav21, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_ventas.imp_Grav105, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_ventas.iva_21, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_ventas.iva_105, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_ventas.percepcion, 10, 2)) + ")"
	
	loCommand.ActiveConnection = loConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute() THEN
		This.ErrorMessage = loCommand.ErrorMessage
		RETURN .F.
	ENDIF

	lnCont = lnCont + 1
	loProg.Update((lnCont * 100) / RECCOUNT("cur_ventas"), "Generando ventas para estudio contable")
	SELECT cur_ventas
	SKIP
ENDDO

loConn.Close()
loProg.Complete()

RETURN .T.
ENDPROC


************************************************************
OBJETO: cl_padron_iibb
************************************************************
*** PROPIEDADES ***
mes = 
filename = 
cantidad_registros = 0
errormessage = 
Name = "cl_padron_iibb"

*** METODOS ***
PROCEDURE crear_cursor
***************************************************************
* Este método permite crear el cursor compatible con el archivo
* txt correspondiente al padrón.
***************************************************************

LOCAL loRes, lcSql

loRes = CREATEOBJECT("odbc_result")
lcSql = ""

*CREATE CURSOR cur_padronIIBB (	;
*	fecPub		varchar(8),;
*	vi_desde	varchar(8),;
*	vi_hasta	varchar(8),;
*	cuit		varchar(20),;
*	tipo		varchar(1),;
*	estado		varchar(1),;
*	ca_alic		varchar(1),;
*	alic_per	varchar(4),;
*	alic_ret	varchar(4),;
*	noGrupoPer	int,;
*	noGrupoRet	int)

CREATE CURSOR cur_padronIIBB ( ;
	regimen 	varchar(1)  ,;
	fecPub		varchar(8)	,;
	vi_desde	varchar(8),;
	vi_hasta	varchar(8),;
	cuit		varchar(20),;
	tipo		varchar(1),;
	estado		varchar(1),;
	ca_alic		varchar(1),;
	alicuota	varchar(4),;
	noGrupo		int)
	
CREATE CURSOR cur_cuits (	;
	cuit varchar(20))
	
SELECT cur_padronIIBB
INDEX ON cuit TAG cuit ASCENDING

SELECT cur_cuits
INDEX ON cuit TAG cuit ASCENDING

lcSql = "SELECT nroCUIT FROM clientes WHERE fecBaja IS NULL GROUP BY nroCUIT"
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_cli"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_cli
DO WHILE !EOF("cur_cli")
	SELECT cur_cuits
	APPEND BLANK
	REPLACE cuit WITH cur_cli.nroCUIT

	SELECT cur_cli
	SKIP
ENDDO 

loRes.Close_Query()

SELECT cur_cuits
IF RECCOUNT("cur_cuits") > 0 THEN
	GO TOP
ENDIF

RETURN .T.
ENDPROC
PROCEDURE leer_archivo
LOCAL lcFileName, lcRegistro, lcMes

lcFileName = this.filename

WAIT WINDOW "Leyendo archivo..." NOWAIT
SELECT cur_padronIIBB
APPEND FROM (lcFileName) DELIMITED WITH CHARACTER ";"

SELECT cur_padronIIBB

IF RECCOUNT("cur_padronIIBB") > 0 THEN
	This.cantidad_registros = RECCOUNT("cur_padronIIBB")
	GO TOP
ENDIF

WAIT WINDOW "Lectura finalizada..." NOWAIT
ENDPROC
PROCEDURE grabar
LOCAL loCommand, lcSql, loProg, loDT, i
LOCAL loResult

loCommand = CREATEOBJECT("odbc_command")
loResult = CREATEOBJECT("odbc_result")
loProg = CREATEOBJECT("_thermometer")
loDT = CREATEOBJECT("datetime")
lcSql = ""

loProg.show()

&& Hago que levanto solo los cuits de los clientes que están cargados en el sistema para
&& agilizar el proceso de actualización.
*SELECT * FROM cur_padronIIBB INNER JOIN cur_cuits ON ALLTRIM(cur_cuits.cuit) = ALLTRIM(cur_padronIIBB.CUIT) ;
INTO CURSOR cur_padron

SELECT cur_cuits
IF RECCOUNT("cur_cuits") > 0 THEN
	GO TOP
ENDIF

i = 0
DO WHILE !EOF("cur_cuits")

	goConn.BeginTransaction()
	
	SELECT * FROM cur_padronIIBB WHERE ALLTRIM(CUIT) = ALLTRIM(cur_cuits.cuit) ;
	INTO CURSOR cur_padron
	
	IF RECCOUNT("cur_padron") > 0 THEN		
		lcSql = "select * from padronib where cuit = '" + ALLTRIM(cur_padron.cuit) + "'"
		loResult.ActiveConnection = goConn.ActiveConnection
		loResult.Cursor_Name = "cur_tempo"
		
		IF !loResult.OpenQuery(lcSql) THEN
			this.ErrorMessage = loResult.Error_Message
			RETURN .F.
		ENDIF

		SELECT cur_tempo
		
		IF RECCOUNT("cur_tempo") = 0 THEN
			lcSql = "INSERT INTO PadronIB ( "
			lcSql = lcSql + "Publicacion, "
			lcSql = lcSql + "Vigencia_Desde, "
			lcSql = lcSql + "Vigencia_Hasta, "
			lcSql = lcSql + "CUIT, "
			lcSql = lcSql + "Tipo, "
			lcSql = lcSql + "Estado, "
			lcSql = lcSql + "CambioAlicuota, "
			lcSql = lcSql + "AlicuotaPer, "
			lcSql = lcSql + "AlicuotaRet, "
			lcSql = lcSql + "NoGrupoPer, "
			lcSql = lcSql + "NoGrupoRet) "
			lcSql = lcSql + "VALUES ( "
			lcSql = lcSql + loDT.toMySql(This.convertir_a_fecha(cur_padron.fecPub)) + ", "
			lcSql = lcSql + loDT.toMySql(This.convertir_a_fecha(cur_padron.vi_desde)) + ", "
			lcSql = lcSql + loDT.toMySql(This.convertir_a_fecha(cur_padron.vi_hasta)) + ", "
			lcSql = lcSql + "'" + ALLTRIM(cur_padron.cuit) + "', "
			lcSql = lcSql + "'" + ALLTRIM(cur_padron.tipo) + "', "
			lcSql = lcSql + "'" + ALLTRIM(cur_padron.estado) + "', "
			lcSql = lcSql + "'" + ALLTRIM(cur_padron.ca_alic) + "', "
			lcSql = lcSql + ALLTRIM(STRTRAN(IIF(ALLTRIM(cur_padron.regimen) == 'P', cur_padron.alicuota, "0"), ",", ".")) + ", "
			lcSql = lcSql + ALLTRIM(STRTRAN(IIF(ALLTRIM(cur_padron.regimen) == 'R', cur_padron.alicuota, "0"), ",", ".")) + ", "
			lcSql = lcSql + ALLTRIM(STR(IIF(ALLTRIM(cur_padron.regimen) == 'P', cur_padron.noGrupo, 0))) + ", "
			lcSql = lcSql + ALLTRIM(STR(IIF(ALLTRIM(cur_padron.regimen) == 'R', cur_padron.noGrupo, 0))) + ")"
		ELSE
			lcSql = "UPDATE PadronIB SET "
			
			IF ALLTRIM(cur_padron.regimen) == "P" THEN
				&& Pasa por aca si es percepcion
				lcSql = lcSql + "AlicuotaPer = " + ALLTRIM(STRTRAN(IIF(ALLTRIM(cur_padron.regimen) == 'P', cur_padron.alicuota, "0"), ",", ".")) + ", "
				lcSql = lcSql + "noGrupoPer = " + ALLTRIM(STR(cur_padron.noGrupo)) + " "
			ELSE
				&& Pasa por aca si es retención
				lcSql = lcSql + "AlicuotaRet = " + ALLTRIM(STRTRAN(IIF(ALLTRIM(cur_padron.regimen) == 'P', cur_padron.alicuota, "0"), ",", ".")) + ", "
				lcSql = lcSql + "noGrupoRet = " + ALLTRIM(STR(cur_padron.noGrupo)) + " "
			ENDIF
			
			lcSql = lcsql + "WHERE cuit = " + ALLTRIM(cur_padron.cuit)
		ENDIF
		
		loResult.Close_Query()

		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			This.ErrorMessage = loCommand.ErrorMessage
			RETURN .F.
		ENDIF
	ENDIF	
	
	USE IN cur_padron

	goConn.Commit()
	
	i = i + 1
	loProg.update((i * 100) / RECCOUNT("cur_cuits"), "Actualizando el padrón de Ingresos Brutos...")
	WAIT WINDOW "importando " + ALLTRIM(STR(i)) + " registros de " + ALLTRIM(STR(RECCOUNT("cur_cuits"))) + "..." NOWAIT
	
	SELECT cur_cuits
	SKIP
ENDDO


WAIT WINDOW "Importación finalizada..." NOWAIT
loProg.complete()
USE IN cur_cuits

USE IN cur_padronIIBB

RETURN .T.
ENDPROC
PROCEDURE convertir_a_fecha
PARAMETERS tcFecha

LOCAL lcDay, lcMonth, lcYear
LOCAL lcFechaComp, ldResult

lcDay = SUBSTR(tcFecha, 1, 2)
lcMonth = SUBSTR(tcFecha, 3, 2)
lcYear = SUBSTR(tcFecha, 5, 4)

lcFechaComp = lcDay + "/" + lcMonth + "/" + lcYear

RETURN CTOD(lcFechaComp)

ENDPROC
PROCEDURE eliminar
LOCAL lcSql, loCommand

lcSql = ""
loCommand = CREATEOBJECT("odbc_command")

lcSql = "DELETE FROM PadronIB"
loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = lcSql

IF !loCommand.Execute() THEN
	goConn.Rollback()
	This.ErrorMessage = loCommnad.ErrorMessage
	RETURN .F.
ENDIF

RETURN .T.
ENDPROC


************************************************************
OBJETO: cl_env_merc
************************************************************
*** PROPIEDADES ***
Name = "cl_env_merc"

*** METODOS ***
PROCEDURE crear_cursor
* Creo el cursor donde voy a levantar los PTOS

CREATE CURSOR cur_ptos (	;
	idVtaDER	int			,;
	idArticulo	int			,;
	cpte		varchar(3)	,;
	tipo		varchar(1)	,;
	numero		varchar(13)	,;
	nroPed		int			,;
	fecPed		datetime	,;
	codArt		varchar(20)	,;
	descripcio	varchar(60) ,;
	nroPart		varchar(30) ,;
	cantidad	float(10, 2))

INDEX ON idVtaDER TAG idVtaDET ASCENDING
INDEX ON cpte TAG cpte ASCENDING ADDITIVE
INDEX ON tipo TAG tipo ASCENDING ADDITIVE
INDEX ON numero TAG numero ASCENDING ADDITIVE
INDEX ON nroPed TAG nroPed ASCENDING ADDITIVE
INDEX ON fecPed TAG fecPed ASCENDING ADDITIVE
INDEX ON codArt TAG codArt ASCENDING ADDITIVE
INDEX ON descripcio TAG descripcio ASCENDING ADDITIVE
INDEX ON cantidad TAG cantidad ASCENDING ADDITIVE
ENDPROC
PROCEDURE leer_ptos
LOCAL lcSql, loRes, loRes1
LOCAL loConn, lcHostName

loConn = CREATEOBJECT("odbc_connect")
loRes = CREATEOBJECT("odbc_result")
loRes1 = CREATEOBJECT("odbc_result")
lcSql = ""
lcHostName = ALLTRIM(GETWORDNUM(SYS(0), 1, "#"))

SELECT cur_ptos
ZAP

loConn.ConnectionString = ALLTRIM(getConfig("ODBC_CONN2"))
IF !loConn.Open() THEN
	MESSAGEBOX(loConn.ErrorMessage, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

lcSql = "SELECT		VentasCab.Id_VentasCab, "
lcSql = lcSql + "	VentasCab.Cpte, "
lcSql = lcSql + "	VentasCab.Tipo, "
lcSql = lcSql + "	VentasCab.Numero, "
lcSql = lcSql + "	VentasCab.Id_Pedido, "
lcSql = lcSql + "	VentasCab.Fecha, "
lcSql = lcSql + "	VentasDet.CodArt, "
lcSql = lcSql + "	Articulos.Descripcion, "
lcSql = lcSql + "	Despachos.despacho, "
lcSql = lcSql + "	VentasDet.Cantidad "
lcSql = lcSql + "FROM	VentasCab INNER JOIN VentasDet ON VentasDet.Id_VentasCab = VentasCab.Id_VentasCab "
lcSql = lcSql + "	INNER JOIN Articulos ON Articulos.Id_Articulo = VentasDet.Id_Articulo "
lcSql = lcSql + "	LEFT JOIN Despachos ON VentasDet.Id_Despacho = Despachos.Id_Despacho "
lcSql = lcSql + "WHERE	VentasCab.Cpte = 'PTO' "
lcSql = lcSql + "	AND VentasCab.Tipo = 'X' "
lcSql = lcSql + "	AND VentasCab.Id_Cliente = 3667 "
lcSql = lcSql + "	AND VentasCab.FecAlta >= {d '2014-03-11'} "
lcSql = lcSql + "	AND Articulos.Merchandising = 0 "
&&lcSql = lcSql + "	AND VentasCab.IdHostAlta = '" + lcHostName + "'"

loRes.ActiveConnection = loConn.ActiveConnection
loRes.Cursor_Name = "cur_tmp"
loRes.OpenQuery(lcSql)

SELECT cur_tmp
IF RECCOUNT("cur_tmp") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_tmp")
	lcSql = "SELECT COUNT(*) AS Cantidad FROM stk_IngCab WHERE numero = '" + ALLTRIM(cur_tmp.Numero) + "'"
	loRes1.ActiveConnection = goConn.ActiveConnection
	loRes1.Cursor_Name = "cur_proc"
	loRes1.OpenQuery(lcSql)
	
	IF IIF(INT(VAL(getConfig("SQLSRV"))) = 1, cur_proc.Cantidad, INT(VAL(cur_proc.Cantidad))) = 0 THEN
		SELECT cur_ptos
		APPEND BLANK
		REPLACE idVtaDER WITH cur_tmp.Id_VentasCab
		REPLACE cpte WITH cur_tmp.Cpte ADDITIVE
		REPLACE tipo WITH cur_tmp.Tipo ADDITIVE
		REPLACE numero WITH cur_tmp.Numero ADDITIVE
		REPLACE nroPed WITH cur_tmp.Id_Pedido ADDITIVE
		REPLACE fecPed WITH cur_tmp.Fecha ADDITIVE
		REPLACE codArt WITH cur_tmp.CodArt ADDITIVE
		REPLACE descripcio WITH cur_tmp.Descripcion ADDITIVE
		REPLACE cantidad WITH cur_tmp.Cantidad ADDITIVE
		REPLACE nroPart WITH IIF(ISNULL(cur_tmp.despacho), "", cur_tmp.despacho) ADDITIVE
	ENDIF
	
	loRes1.Close_Query()
	
	SELECT cur_tmp
	SKIP
ENDDO

loRes.Close_Query()
SELECT cur_ptos
IF RECCOUNT("cur_ptos") > 0 THEN
	GO TOP
ENDIF

This.verificar_articulos()

RETURN .T.

ENDPROC
PROCEDURE grabar
PARAMETERS lnIdProv

LOCAL lcSql, loCommand, loResult
LOCAL lnProxID, lcCbte
LOCAL lnControla, loDT, lnContReng
LOCAL loProg, lnCont

loCommand = CREATEOBJECT("odbc_command")
loResult = CREATEOBJECT("odbc_result")
loDT = CREATEOBJECT("datetime")
loProg = CREATEOBJECT("_thermometer")
lnProxID = 0
&&lnIdProv = 1
lcCbte = "RTO"
lnControla = 0
lnContReng = 0
lnCont = 0

goConn.BeginTransaction()

&& Ahora tengo que agrupar los datos del cursor por número
&&  de PTO, ya que cada PTO que haya se deberá ingresar como
&& un remito nuevo

SELECT	numero, tipo	;
FROM	cur_ptos ;
GROUP BY numero, tipo ;
ORDER BY numero ;
INTO CURSOR cur_remitos

loProg.Show()
SELECT cur_remitos
GO TOP

DO WHILE !EOF("cur_remitos")
	&& Genero la cabecera del remito
	lnProxID = goConn.GetNextID("stk_ingcab", "idIngCab")
	
	lcSql = "INSERT INTO stk_ingcab ( "
	lcSql = lcSql + "idIngCab, "
	lcSql = lcSql + "idProv, "
	lcSql = lcSql + "cbte, "
	lcSql = lcSql + "tipo, "
	lcSql = lcSql + "numero, "
	lcSql = lcSql + "fecha, "
	lcSql = lcSql + "controla, "
	lcSql = lcSql + "usuAlta, "
	lcSql = lcSql + "fecAlta, "
	lcSql = lcSql + "idHostAlta) "
	lcSql = lcSql + "VALUES ( "
	lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnIdProv)) + ", "
	lcSql = lcSql + "'" + ALLTRIM(lcCbte) + "', "
	lcSql = lcSql + "'" + ALLTRIM(cur_remitos.tipo) + "', "
	lcSql = lcSql + "'" + ALLTRIM(cur_remitos.numero) + "', "
	lcSql = lcSql + loDT.getDateTime() + ", "
	lcSql = lcSql + ALLTRIM(STR(lnControla)) + ", "
	lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
	lcSql = lcSql + loDT.getDateTime() + ", "
	lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "')"
	
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute() THEN
		goConn.Rollback()
		RETURN .F.
	ENDIF
	
	&& Levanto el detalle del remito actual
	SELECT	*	;
	FROM	cur_ptos ;
	WHERE	ALLTRIM(cur_ptos.numero) = ALLTRIM(cur_remitos.numero) ;
	INTO CURSOR cur_detaux
	
	lnContReng = 1
	
	SELECT cur_detaux
	GO TOP
		
	DO WHILE !EOF("cur_detaux")
		lcSql = "INSERT INTO stk_ingdet ( "
		lcSql = lcSql + "idIngDet, "
		lcSql = lcSql + "idIngCab, "
		lcSql = lcSql + "idArticulo, "
		lcSql = lcSql + "codArt, "
		lcSql = lcSql + "nroPart, "
		lcSql = lcSql + "cantidad, "
		lcSql = lcSql + "cantReci) "
		lcSql = lcSql + "VALUES ( "
		lcSql = lcSql + ALLTRIM(STR(lnContReng)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_detaux.idArticulo)) + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_detaux.codArt) + "', "
		lcSql = lcSql + "'" + ALLTRIM(cur_detaux.nroPart) + "', "
		lcSql = lcSql + ALLTRIM(STR(cur_detaux.cantidad)) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_detaux.cantidad)) + ") "
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			RETURN .F.
		ENDIF
	
		lnContReng = lnContReng + 1
		SELECT cur_detaux
		SKIP
	ENDDO
	
	USE IN cur_detaux
	
	lnCont = lnCont + 1
	loProg.update((lnCont * 100) / RECCOUNT("cur_remitos"), "Guardando remitos...")
	
	SELECT cur_remitos
	SKIP
ENDDO

USE IN cur_remitos
goConn.Commit()

loProg.Complete()
RETURN .T.
ENDPROC
PROCEDURE verificar_articulos
LOCAL loResult, lcSql
LOCAL lnIdArticulo

lnIdArticulo = 0
loResult = CREATEOBJECT("odbc_result")
lcSql = ""

SELECT cur_ptos
IF RECCOUNT("cur_ptos") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_ptos")
	lcSql = "SELECT idArticulo FROM articulos WHERE codArt = '" + ALLTRIM(cur_ptos.codArt) + "'"
	loResult.ActiveConnection = goConn.ActiveConnection
	loResult.Cursor_Name = "cur_art"
	loResult.OpenQuery(lcSql)
	
	SELECT cur_art
	IF RECCOUNT("cur_art") > 0 THEN
		lnIdArticulo = cur_art.idArticulo
	ELSE
		lnIdArticulo = 0
	ENDIF
	
	loResult.Close_Query()
	
	SELECT cur_ptos
	LOCK()
	REPLACE cur_ptos.idArticulo WITH lnIdArticulo
	UNLOCK

	SELECT cur_ptos
	SKIP
ENDDO

SELECT cur_ptos
GO TOP

ENDPROC
PROCEDURE limpiar
SELECT cur_ptos
ZAP
ENDPROC
PROCEDURE agregar_item
PARAMETERS ;
	tnIdVtaDER		,;
	tnIdArticulo	,;
	tcCpte			,;
	tcTipo			,;
	tcNumero		,;
	tnNroPed		,;
	tdFecPed		,;
	tcCodArt		,;
	tcDescripcio	,;
	tcNroPart		,;
	tnCantidad	
	
SELECT cur_ptos
APPEND BLANK
REPLACE idVtaDER WITH tnIdVtaDER
REPLACE idArticulo WITH tnIdArticulo ADDITIVE
REPLACE cpte WITH tcCpte ADDITIVE
REPLACE tipo WITH tcTipo ADDITIVE
REPLACE numero WITH tcNumero ADDITIVE
REPLACE nroPed WITH tnNroPed ADDITIVE
REPLACE fecPed WITH tdFecPed ADDITIVE
REPLACE codArt WITH tcCodArt ADDITIVE
REPLACE descripcio WITH tcDescripcio ADDITIVE
REPLACE nroPart WITH tcNroPart ADDITIVE
REPLACE cantidad WITH tnCantidad ADDITIVE


ENDPROC


************************************************************
OBJETO: cls_numeradores
************************************************************
*** PROPIEDADES ***
idnum = 0
cbte = 
tipodoc = 
ptovta = 0
numactual = 0
fecvto = {}
impresora = 
cantcpia = 0
Name = "cls_numeradores"

*** METODOS ***
PROCEDURE bloquear
LOCAL lcSql, lnPtoVta, lcTipoDoc, lcCbte
LOCAL loCommand, loConDMO

loConDMO = CREATEOBJECT("odbc_connect")
loCommand = CREATEOBJECT("odbc_command")
lcSql = ""

lcSql = "UPDATE numerador SET bloqueado = 1 WHERE ptoVta = " + ALLTRIM(STR(this.ptovta)) + " AND " + ;
	"tipoDoc = '" + ALLTRIM(this.tipoDoc) + "' AND cbte = '" + ALLTRIM(this.cbte) + "'"
	
goConn.BeginTransaction()
loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = lcSql

IF !loCommand.execute() THEN
	MESSAGEBOX(loCommand.ErrorMessage, 0+48, "Error Numerador")
	goConn.Rollback()
	RETURN .F.
ENDIF

goConn.Commit()
RETURN .T.
ENDPROC
PROCEDURE desbloquear
LOCAL lcSql, lnPtoVta, lcTipoDoc, lcCbte
LOCAL loCommand, loConDMO

loConDMO = CREATEOBJECT("odbc_connect")
loCommand = CREATEOBJECT("odbc_command")
lcSql = ""

lcSql = "UPDATE numerador SET bloqueado = 0 WHERE ptoVta = " + ALLTRIM(STR(this.ptovta)) + " AND " + ;
	"tipoDoc = '" + ALLTRIM(this.tipoDoc) + "' AND cbte = '" + ALLTRIM(this.cbte) + "'"
	
goConn.BeginTransaction()
loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = lcSql

IF !loCommand.execute() THEN
	MESSAGEBOX(loCommand.ErrorMessage, 0+48, "Error Numerador")
	goConn.Rollback()
	RETURN .F.
ENDIF

goConn.Commit()
RETURN .T.
ENDPROC
PROCEDURE esta_bloqueado
LOCAL loRes, lcSql

loRes = CREATEOBJECT("odbc_result")
lcSql = ""

lcSql = "SELECT bloqueado FROM numerador WHERE ptoVta = " + ALLTRIM(STR(this.ptovta)) + " AND " + ;
	"tipoDoc = '" + ALLTRIM(this.tipodoc) + "' AND cbte = '" + ALLTRIM(this.cbte) + "'"
	
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "_BLOQ"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, "Error Numerador")
	RETURN .F.
ENDIF

SELECT _BLOQ
IF !_BLOQ.bloqueado THEN
	loRes.Close_Query()
	RETURN .F.
ENDIF

loRes.Close_Query()

RETURN .T.


ENDPROC
PROCEDURE getproxnum
LOCAL lcSql, loRes
LOCAL lnNumActual, ldFecVto

lcSql = ""
loRes = CREATEOBJECT("odbc_result")

lcSql = "select	numActual, fecVto, impresora, cantCpia "
lcSql = lcSql + "from numerador "
lcSql = lcSql + "where cbte = '" + ALLTRIM(this.cbte) + "' "
lcSql = lcSql + "	and tipoDoc = '" + ALLTRIM(this.tipodoc) + "' "
lcSql = lcSql + "	and ptoVta = " + ALLTRIM(STR(this.ptovta)) + " "

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_tempo"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, "Error Numerador")
	RETURN -1
ENDIF

SELECT cur_tempo
IF RECCOUNT("cur_tempo") = 0 THEN
	MESSAGEBOX("No se encuentra configurado el numerador del comprobante " + ALLTRIM(this.cbte) + " Punto de Venta: " + ALLTRIM(STR(this.ptovta)) + " Letra: " + ALLTRIM(this.tipodoc), 0+48, "Error numerador")
	loRes.Close_Query()
	RETURN -1
ENDIF

ldFecVto = cur_tempo.fecVto

IF DATE() > ldFecVto THEN
	MESSAGEBOX("El talonario se encuentra vencido, por favor, cambie el talonario por uno válido", 0+48, "Error Numerador")
	loRes.Close_Query()
	RETURN -1	
ENDIF

lnNumActual = cur_tempo.numActual + 1

this.numactual = lnNumActual
this.impresora = cur_tempo.impresora
this.cantcpia = cur_tempo.cantCpia

loRes.Close_Query()

RETURN lnNumActual




ENDPROC
PROCEDURE actualizar
LOCAL lcSql, loCommand

lcSql = ""
loCommand = CREATEOBJECT("odbc_command")

lcSql = "update numerador set numActual = " + ALLTRIM(STR(this.numactual)) + ;
	" where cbte = '" + ALLTRIM(this.cbte) + "' and tipoDoc = '" + ALLTRIM(this.tipodoc) + "' and ptoVta = " + ALLTRIM(STR(this.ptovta))

loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = lcSql

IF !loCommand.Execute()
	RETURN .F.
ENDIF	

RETURN .T.
ENDPROC
PROCEDURE getptovta
LOCAL lcSql, loRes
LOCAL ldFecVto, lnNumActual 

lcSql = ""
loRes = CREATEOBJECT("odbc_result")
lnNumActual = 0

lcSql = "select	tipodoc, ptovta, numActual, fecVto, impresora, cantCpia "
lcSql = lcSql + "from numerador "
lcSql = lcSql + "where cbte = '" + ALLTRIM(this.cbte) + "' "
lcSql = lcSql + "	and tipoDoc = '" + ALLTRIM(this.tipodoc) + "' "

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_tempo"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, "Error Numerador")
	RETURN .F.
ENDIF

SELECT cur_tempo
IF RECCOUNT("cur_tempo") = 0 THEN
	MESSAGEBOX("No se encuentra configurado el numerador del comprobante " + ALLTRIM(this.cbte) + " Punto de Venta: " + ALLTRIM(STR(this.ptovta)) + " Letra: " + ALLTRIM(this.tipodoc), 0+48, "Error numerador")
	loRes.Close_Query()
	RETURN .F.
ENDIF

ldFecVto = cur_tempo.fecVto

IF DATE() > ldFecVto THEN
	MESSAGEBOX("El talonario se encuentra vencido, por favor, cambie el talonario por uno válido", 0+48, "Error Numerador")
	loRes.Close_Query()
	RETURN .F.	
ENDIF

lnNumActual = cur_tempo.numActual + 1

this.tipodoc = cur_tempo.tipodoc
this.ptovta = cur_tempo.ptovta
this.numactual = lnNumActual
this.impresora = cur_tempo.impresora
this.cantCpia = cur_tempo.cantCpia

loRes.Close_Query()

RETURN .T.




ENDPROC


************************************************************
OBJETO: cl_ctrl_fisico
************************************************************
*** PROPIEDADES ***
codusu = 
idhostalta = 
errormessage = 
Name = "cl_ctrl_fisico"

*** METODOS ***
PROCEDURE crear_cursor
***********************************************************************
* Creo el cursor con los remitos pendientes a controlar
***********************************************************************

CREATE CURSOR cur_busq_rtos (	;
	idIngCab		int,;
	idprov 			int,;
	cbte			varchar(3),;
	tipo			varchar(1),;
	numero			varchar(13),;
	fecha			datetime)

SELECT cur_busq_rtos
INDEX on idIngCab TAG idIngCab ASCENDING 
INDEX on idprov TAG idprov ASCENDING ADDITIVE 
INDEX on cbte TAG cbte ASCENDING ADDITIVE 
INDEX on tipo TAG tipo ASCENDING ADDITIVE 
INDEX on numero TAG numero ASCENDING ADDITIVE 
INDEX on fecha TAG fecha ASCENDING ADDITIVE 


ENDPROC
PROCEDURE leer_rtos
***************************************************************************
* Este método permite leer los remitos pendientes de controlar físicamente
***************************************************************************
PARAMETERS lnidIngCab

LOCAL lcSql, loRsRtos
LOCAL loRsUD, lnUniDesp

lcSql = ""
loRsRtos = CREATEOBJECT("odbc_result")
loRsRtos = CREATEOBJECT("odbc_result")
loRsUD = CREATEOBJECT("odbc_result")
lnUniDesp = 0.00

SELECT cur_rtos
ZAP

SELECT cur_dif
ZAP

lcSql = "SELECT	stk_ingdet.*, "
lcSql = lcSql + "	stk_ingcab.idProv, "
lcSql = lcSql + "	proveedor.razSoc, "
lcSql = lcSql + "	articulos.descripcio, "
lcSql = lcSql + "	stk_ingcab.cbte, "
lcSql = lcSql + "	stk_ingcab.tipo, "
lcSql = lcSql + "	stk_ingcab.numero "
lcSql = lcSql + "FROM	stk_ingdet INNER JOIN stk_ingcab ON stk_ingcab.idIngCab = stk_ingdet.idIngCab "
lcSql = lcSql + "	INNER JOIN articulos ON articulos.idArticulo = stk_ingdet.idArticulo "
lcSql = lcSql + "	INNER JOIN proveedor ON proveedor.idProv = articulos.idProv "
lcSql = lcSql + "WHERE stk_ingcab.controla = 0 "
lcSql = lcSql + "	AND stk_ingcab.idingcab = " + ALLTRIM(STR(lnidIngCab)) + " "
lcSql = lcSql + "ORDER BY stk_ingcab.numero, stk_ingdet.codArt ASC"

loRsRtos.ActiveConnection = goConn.ActiveConnection
loRsRtos.Cursor_Name = "cur_tempo"
loRsRtos.OpenQuery(lcSql)

SELECT cur_tempo
IF RECCOUNT("cur_tempo") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_tempo")
	lcSql = "SELECT * FROM art_unid WHERE idArticulo = " + ALLTRIM(STR(cur_tempo.idArticulo))
	loRsUD.ActiveConnection = goConn.ActiveConnection
	loRsUD.Cursor_Name = "cur_au"
	
	IF !loRsUD.OpenQuery(lcSql) THEN
		this.ErrorMessage = loRsUD.Error_Message
		RETURN .F.
	ENDIF
	
	SELECT cur_au
	IF RECCOUNT("cur_au") > 0 THEN
		lnUniDesp = cur_au.cantUD
	ELSE
		lnUniDesp = 0.00
	ENDIF
	
	loRsUD.Close_Query()

	SELECT cur_rtos
	APPEND BLANK
	REPLACE cur_rtos.idIngDet WITH cur_tempo.idIngDet
	REPLACE cur_rtos.idIngCab WITH cur_tempo.idIngCab ADDITIVE
	REPLACE cur_rtos.idProv	  WITH cur_tempo.idProv ADDITIVE
	REPLACE cur_rtos.razSoc	  WITH cur_tempo.razSoc ADDITIVE
	REPLACE cur_rtos.idArticulo WITH cur_tempo.idArticulo ADDITIVE
	REPLACE cur_rtos.codArt WITH cur_tempo.codArt ADDITIVE
	
	IF lnUniDesp > 0 THEN
		REPLACE cur_rtos.cantidad WITH cur_tempo.cantidad * lnUniDesp ADDITIVE
		REPLACE cur_rtos.cantReci WITH cur_tempo.cantReci * lnUniDesp ADDITIVE
	ELSE
		REPLACE cur_rtos.cantidad WITH cur_tempo.cantidad ADDITIVE
		REPLACE cur_rtos.cantReci WITH cur_tempo.cantReci ADDITIVE
	ENDIF
	
	REPLACE cur_rtos.descripcio WITH cur_tempo.descripcio ADDITIVE
	REPLACE cur_rtos.cbte WITH cur_tempo.cbte ADDITIVE
	REPLACE cur_rtos.tipo WITH cur_tempo.tipo ADDITIVE
	REPLACE cur_rtos.numero WITH cur_tempo.numero ADDITIVE
	REPLACE cur_rtos.nroPart WITH cur_tempo.nroPart ADDITIVE

	SELECT cur_tempo
	SKIP
ENDDO

loRsRtos.Close_Query()

SELECT cur_rtos
IF RECCOUNT("cur_rtos") > 0 THEN
	GO TOP
ENDIF
ENDPROC
PROCEDURE grabar
*****************************************************************************
* Este método permite grabar el control físico
*****************************************************************************

LOCAL lcSql, loCommand, loDT

lcSql = ""
loCommand = CREATEOBJECT("odbc_command")
loDT = CREATEOBJECT("datetime")

goConn.BeginTransaction()

SELECT cur_rtos
IF RECCOUNT("cur_rtos") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_rtos")
	&& Marco el remito como controlado
	lcSql = "UPDATE stk_ingcab SET controla = 1, "
	lcSql = lcSql + "	usuCtrl = '" + ALLTRIM(This.codusu) + "', "
	lcSql = lcSql + "	fecCtrl = " + loDT.getDateTime() + ", "
	lcSql = lcSql + "	idHostCtrl = '" + ALLTRIM(This.idHostAlta) + "' "
	lcsql = lcSql + "WHERE idIngCab = " + ALLTRIM(STR(cur_rtos.idIngCab))
	
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute() THEN
		This.ErrorMessage = loCommand.ErrorMessage
		goConn.Rollback()
		RETURN .F.
	ENDIF
	
	&& Actualizo la cantidad del control físico en el detalle
	lcSql = "UPDATE stk_ingdet SET cantReci = " + ALLTRIM(STR(cur_rtos.cantReci)) + " "
	lcSql = lcSql + "WHERE idIngCab = " + ALLTRIM(STR(cur_rtos.idIngCab)) + " "
	lcSql = lcSql + "	AND idIngDet = " + ALLTRIM(STR(cur_rtos.idIngDet))
	
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute() THEN
		This.ErrorMessage = loCommand.ErrorMessage
		goConn.Rollback()
		RETURN .F.
	ENDIF
	
	IF ((cur_rtos.cantReci - cur_rtos.cantidad) <> 0) THEN
		SELECT cur_dif
		APPEND BLANK
		REPLACE idProv WITH cur_rtos.idProv
		REPLACE razSoc WITH cur_rtos.razSoc ADDITIVE
		REPLACE codArt WITH ALLTRIM(cur_rtos.codArt) ADDITIVE
		REPLACE descripcio WITH cur_rtos.descripcio ADDITIVE
		REPLACE cbte WITH "RTO-" + ALLTRIM(cur_rtos.tipo) + "-" + ALLTRIM(cur_rtos.numero) ADDITIVE
		REPLACE diferencia WITH (cur_rtos.cantReci - cur_rtos.cantidad) ADDITIVE
		REPLACE nroPart WITH cur_rtos.nroPart ADDITIVE
	ENDIF

	SELECT cur_rtos
	SKIP
ENDDO

goConn.Commit()
RETURN .T.
ENDPROC
PROCEDURE enviar_mail
***************************************************
* Este procedimiento permite enviar un mail
* con las diferencias
***************************************************
LOCAL lo_SoapClient, loSoapClientURL, lnResult
LOCAL lcMensaje, lcSaltoLinea

lcSaltoLinea = CHR(13) + CHR(10)
lcMensaje = ""

loSoapClient = CREATEOBJECT("MSSOAP.SoapClient30")
* loSoapClientURL = "http://www.lp-soft.com.ar/ws_siscom/der/ctrl_fisico/sendErrorMails.php?wsdl"
loSoapClientURL = ALLTRIM(getGlobalCFG("CTRFCO_WSA"))
loSoapClient.MSSoapInit(loSoapClientURL)

lcMensaje = "Las cantidades negativas significan que son faltantes y las positivas indican que son sobrantes." + lcSaltoLinea
lcMensaje = lcMensaje + "A continuación se presentan las diferencias encontradas: " + lcSaltoLinea
lcMensaje = lcMensaje + "*********************************************************" + lcSaltoLinea

SELECT cur_dif
IF RECCOUNT("cur_dif") > 0 THEN
	GO TOP

	DO WHILE !EOF("cur_dif")
		lcMensaje = lcMensaje + ALLTRIM(cur_dif.nroPart) + " | "
		lcMensaje = lcMensaje + ALLTRIM(cur_dif.cbte) + " | "
		lcMensaje = lcMensaje + ALLTRIM(STR(cur_dif.diferencia)) + " | "
		lcMensaje = lcMensaje + ALLTRIM(cur_dif.codArt) + " | "
		lcMensaje = lcMensaje + ALLTRIM(cur_dif.descripcio) + lcSaltoLinea
		

		SELECT cur_dif
		SKIP
	ENDDO

	lcMensaje = lcMensaje + "*********************************************************" + lcSaltoLinea
	lcMensaje = lcMensaje + "(Mail enviado desde mostrador)" + lcSaltoLinea

	lnResult = loSoapClient.sendMail("Diferencia en Envío de Mercadería a Mostrador", lcMensaje)

	IF lnResult = -1 THEN
		This.ErrorMessage = "Error al intentar enviar un mail."
		RETURN .F.
	ENDIF
ENDIF

RETURN .T.
ENDPROC
PROCEDURE buscar_rtos
******************************************************************************************************
* Este método permite buscar los remitos pendientes de controlar físicamente de acuerdo a lo filtrador
******************************************************************************************************
PARAMETERS lcfecDesde, lcfecHasta, lccbte, lctipo, lcnumero, lclistcbtes 

LOCAL lcSql, loRsRtos

lcSql = ""
loRsRtos = CREATEOBJECT("odbc_result")

SELECT cur_busq_rtos
ZAP

lcSql = "SELECT	stk_ingcab.idingcab, "
lcSql = lcSql + "	stk_ingcab.idProv, "
lcSql = lcSql + "	stk_ingcab.cbte, "
lcSql = lcSql + "	stk_ingcab.tipo, "
lcSql = lcSql + "	stk_ingcab.numero, "
lcSql = lcSql + "	stk_ingcab.fecha "
lcSql = lcSql + "FROM	stk_ingcab "
lcSql = lcSql + "WHERE stk_ingcab.controla = 0 "

IF INT(VAL(getConfig("SQLSRV"))) = 1 THEN
	lcSql = lcSql + "         AND (CONVERT(CHAR(8), fecha , 112) BETWEEN " + lcFecDesde + " AND " + lcFecHasta + ") "
ELSE
	IF INT(VAL(getConfig("SQLSRV"))) = 0 THEN
		lcSql = lcSql + "         AND (CAST(fecha AS DATE) BETWEEN " + lcFecDesde + " AND " + lcFecHasta + ") "
	ELSE
		lcSql = lcSql + "         AND (fecha BETWEEN " + lcFecDesde + " AND " + lcFecHasta + ") "
	ENDIF
ENDIF

IF ALLTRIM(lccbte) == "Todos" THEN 
	lcSql = lcSql + "	  AND Cbte IN (" + lclistcbtes + ")"
ELSE 
	lcSql = lcSql + "	  AND Cbte = '" + ALLTRIM(lccbte) + "' "
ENDIF 

IF ALLTRIM(lctipo) != "Todos" THEN 
	lcSql = lcSql + "	  AND tipo = '" + ALLTRIM(lctipo) + "' "
ENDIF 

IF ALLTRIM(lcnumero) != "0000-00000000" THEN
	lcSql = lcSql + " AND numero = '" + lcnumero + "' "  
ENDIF 

lcSql = lcSql + "ORDER BY stk_ingcab.fecha ASC"

loRsRtos.ActiveConnection = goConn.ActiveConnection
loRsRtos.Cursor_Name = "cur_tempo"
IF !loRsRtos.OpenQuery(lcSql) THEN
	this.ErrorMessage = loRsRtos.Error_Message
	WAIT WINDOW this.ErrorMessage
	RETURN .F.
ENDIF

SELECT cur_tempo
IF RECCOUNT("cur_tempo") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_tempo")
	SELECT cur_busq_rtos
	APPEND BLANK
	REPLACE cur_busq_rtos.idIngCab WITH cur_tempo.idIngCab 
	REPLACE cur_busq_rtos.idProv WITH cur_tempo.idProv ADDITIVE
	REPLACE cur_busq_rtos.cbte WITH cur_tempo.cbte ADDITIVE
	REPLACE cur_busq_rtos.tipo WITH cur_tempo.tipo ADDITIVE
	REPLACE cur_busq_rtos.numero WITH cur_tempo.numero ADDITIVE
	REPLACE cur_busq_rtos.fecha WITH cur_tempo.fecha ADDITIVE

	SELECT cur_tempo
	SKIP
ENDDO

loRsRtos.Close_Query()

SELECT cur_busq_rtos
IF RECCOUNT("cur_busq_rtos") > 0 THEN
	GO TOP
ENDIF

RETURN .T.
ENDPROC
PROCEDURE crear_cursor_detalle
***********************************************************
* Creo el cursor de detalle
***********************************************************

CREATE CURSOR cur_rtos (	;
	idIngDet		int,;
	idIngCab		int,;
	idProv			int,;
	razSoc			varchar(60),;
	idArticulo		int,;
	codArt			varchar(20),;
	descripcio		varchar(60),;
	cbte			varchar(3),;
	tipo			varchar(1),;
	nroPart			varchar(30),;
	numero			varchar(13),;
	cantidad		float(10, 2),;
	cantReci		float(10, 2))

CREATE CURSOR cur_dif (	;
	idProv			int,;
	razSoc			varchar(60),;
	codArt			varchar(20),;
	descripcio		varchar(20),;
	nroPart			varchar(30),;
	cbte			varchar(30),;
	diferencia		float(10, 2))
	
SELECT cur_rtos
INDEX on idIngDet TAG idIngDet ASCENDING 
INDEX on idIngCab TAG idIngCab ASCENDING ADDITIVE
INDEX on idArticulo TAG idArticulo ASCENDING ADDITIVE
INDEX on codArt TAG codArt ASCENDING ADDITIVE
INDEX on descripcio TAG descripcio ASCENDING ADDITIVE
INDEX on cbte TAG cbte ASCENDING ADDITIVE 
INDEX on tipo TAG tipo ASCENDING ADDITIVE 
INDEX on nroPart TAG nroPart ASCENDING ADDITIVE 
INDEX on numero TAG numero ASCENDING ADDITIVE 
INDEX on cantidad TAG cantidad ASCENDING ADDITIVE 
INDEX on cantReci TAG cantReci ASCENDING ADDITIVE 

SET ORDER TO tag codart ASCENDING 


ENDPROC
PROCEDURE update_idstkcab
*****************************************************************************
* Este método permite grabar el numero de movimiento de stock en el ingreso
*****************************************************************************
PARAMETERS lnidStkCab

LOCAL lcSql, loCommand

lcSql = ""
loCommand = CREATEOBJECT("odbc_command")

goConn.BeginTransaction()

SELECT cur_rtos
IF RECCOUNT("cur_rtos") > 0 THEN
	GO TOP
ENDIF

&& Actualizo el num de mov de stock
lcSql = "UPDATE stk_ingcab SET idstkcab = " + ALLTRIM(STR(lnidStkCab))
lcsql = lcSql + " WHERE idIngCab = " + ALLTRIM(STR(cur_rtos.idIngCab))

loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = lcSql

IF !loCommand.Execute() THEN
	This.ErrorMessage = loCommand.ErrorMessage
	goConn.Rollback()
	RETURN .F.
ENDIF


goConn.Commit()
RETURN .T.
ENDPROC
PROCEDURE imprimir_diferencia
***************************************************
* Este procedimiento permite enviar un mail
* con las diferencias
***************************************************
LOCAL lo_SoapClient, loSoapClientURL, lnResult
LOCAL lcMensaje, lcSaltoLinea

m.usuario = ALLTRIM(gcCodUsu)

SELECT cur_dif
GO TOP

REPORT FORM "rep_ctrlfisico" PREVIEW

RETURN .T.
ENDPROC
PROCEDURE Init
this.codusu = ALLTRIM(gcCodUsu)
this.idHostAlta = ALLTRIM(SYS(0))

ENDPROC


************************************************************
OBJETO: cl_asig_artdep
************************************************************
*** PROPIEDADES ***
idstkdep = 0
idarticulo = 0
usualta = 
idhostalta = 
usumodi = 
idhostmodi = 
usubaja = 
idhostbaja = 
valor_buscado = 
errormessage = 
Name = "cl_asig_artdep"

*** METODOS ***
PROCEDURE crear_cursor
&& Creo el cursor
CREATE CURSOR cur_Articulos (	;
	sel			L,;
	idArticulo	int,;
	codArt		varchar(20),;
	descripcio	varchar(60))
	
INDEX ON codArt TAG codArt ASCENDING
INDEX ON descripcio TAG descripcio ASCENDING ADDITIVE			

ENDPROC
PROCEDURE asignar
LOCAL loCommand, loDT, lcSql, lnIdProx, loRes
LOCAL lnCont, i, loProg

loCommand = CREATEOBJECT("odbc_command")
loRes = CREATEOBJECT("odbc_result")
loDT = CREATEOBJECT("datetime")
lcSql = ""
lnIdProx = 0
lnCont = 0
i = 0
loProg = CREATEOBJECT("_thermometer")

loProg.Show()
goConn.BeginTransaction()

SELECT cur_Articulos
IF RECCOUNT("cur_Articulos") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_Articulos")
	This.idArticulo = cur_Articulos.idArticulo
		
	IF cur_Articulos.Sel THEN	
		IF !This.EsDuplicado() THEN
			&& Tengo que verificar si hay registros para ese artículo en otros depósitos, hay
			&& que darlos de baja.
			lcSql = "SELECT * FROM art_dep WHERE idArticulo = " + ALLTRIM(STR(cur_Articulos.idArticulo))
			loRes.ActiveConnection = goConn.ActiveConnection
			loRes.Cursor_Name = "cur_artdep"
			
			IF !loRes.OpenQuery(lcSql) THEN
				MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
				RETURN .F.
			ENDIF
			
			SELECT cur_artdep
			IF RECCOUNT("cur_artdep") > 0 THEN
				lcSql = "UPDATE art_dep "
				lcSql = lcSql + "SET usuBaja = '" + ALLTRIM(This.usuBaja) + "', "
				lcSql = lcSql + "	 fecBaja = " + loDT.getDateTime() + ", "
				lcSql = lcSql + "	 idHostBaja = '" + ALLTRIM(This.idHostAlta) + "' "
				lcSql = lcSql + "WHERE idArticulo = " + ALLTRIM(STR(cur_Articulos.idArticulo))
				
				loCommand.ActiveConnection = goConn.ActiveConnection
				loCommand.CommandText = lcSql
				
				IF !loCommand.Execute() THEN
					goConn.Rollback()
					MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
					RETURN .F.
				ENDIF
			ENDIF
			
			loRes.Close_Query()			
		
			lcSql = "INSERT INTO art_dep ( "
			lcSql = lcSql + "	idArticulo, "
			lcSql = lcSql + "	idStkDep, "
			lcSql = lcSql + "	usuAlta, "
			lcSql = lcSql + "	fecAlta, "
			lcSql = lcSql + "	idHostAlta) VALUES ( "
			lcSql = lcSql + ALLTRIM(STR(This.idArticulo)) + ", "
			lcSql = lcSql + ALLTRIM(STR(This.idStkDep)) + ", "
			lcSql = lcSql + "'" + ALLTRIM(This.usuAlta) + "', "
			lcSql = lcSql + loDT.getDateTime() + ", "
			lcSql = lcSql + "'" + This.idHostAlta + "')"

			loCommand.ActiveConnection = goConn.ActiveConnection
			loCommand.CommandText = lcSql

			IF !loCommand.Execute() THEN
				This.ErrorMessage = loCommand.ErrorMessage
				goConn.Rollback()
				RETURN .F.
			ENDIF
			
			&& Actualizo los movimientos de stock de ese artículo al nuevo depósito asignado
			lcSql = "UPDATE stk_det SET idStkDep = " + ALLTRIM(STR(This.idStkDep)) + " "
			lcSql = lcSql + "WHERE idArticulo = " + ALLTRIM(STR(cur_Articulos.idArticulo))
			
			loCommand.ActiveConnection = goConn.ActiveConnection
			loCommand.CommandText = lcSql 
			
			IF !loCommand.Execute() THEN
				This.ErrorMessage = loCommand.ErrorMessage
				goConn.Rollback()
				RETURN .F.
			ENDIF
		ELSE
			lnCont = lnCont + 1
		ENDIF
	ENDIF
	
	i = i + 1
	loProg.update((i * 100) / RECCOUNT("cur_Articulos"), "Asignando artículos...")		
	SELECT cur_Articulos
	SKIP
ENDDO

goCOnn.Commit()

loProg.Complete()
*!*	SELECT cur_Articulos
*!*	IF RECCOUNT("cur_Articulos") = lnCont THEN
*!*		MESSAGEBOX("Todos los artículos de la lista se encuentran asignados", 0+64, "Información")
*!*	ELSE
*!*		MESSAGEBOX("Los artículos fueron asignados con éxito", 0+64, "Información")
*!*	ENDIF

RETURN .T.

ENDPROC
PROCEDURE eliminar_asignacion
LOCAL loCommand, lcSql, loDT

loCommand = CREATEOBJECT("odbc_command")
lcSql = ""
loDT = CREATEOBJECT("datetime")

lcSql = "UPDATE art_dep "
lcSql = lcSql + "SET 	usuBaja = '" + This.usuBaja + "', "
lcSql = lcSql + "		fecBaja = " + loDT.getDateTime() + ", "
lcSql = lcSql + "		idHostBaja = '" + This.idHostBaja + "' "
lcSql = lcSql + "WHERE idArticulo = " + ALLTRIM(STR(This.idArticulo))
lcSql = lcSql + "	AND idStkDep = " + ALLTRIM(STR(This.idStkDep))

goConn.BeginTransaction()

loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = lcSql

IF !loCommand.Execute() THEN
	This.ErrorMessage = loCommand.ErrorMessage
	goConn.Rollback()
	RETURN .F.
ENDIF

goConn.Commit()
RETURN .T.

ENDPROC
PROCEDURE buscar_articulo
LOCAL loResult, lcSql

loResult = CREATEOBJECT("odbc_result")
lcSql = ""

lcSql = "SELECT articulos.idArticulo, articulos.codArt, articulos.descripcio "
lcSql = lcSql + "FROM articulos "
lcSql = lcSql + "	INNER JOIN familias ON familias.idFamilia = articulos.idFamilia "
lcSql = lcSql + "	INNER JOIN subfam ON subfam.idSubFam = articulos.idSubFam "
lcSql = lcSql + "	INNER JOIN proveedor ON proveedor.idProv = articulos.idProv "
lcSql = lcSql + "WHERE articulos.fecbaja IS NULL "
lcSql = lcSql + "	AND(articulos.codArt LIKE '%" + ALLTRIM(THis.valor_buscado) + "%' "
lcSql = lcSql + "	OR articulos.descripcio LIKE '%" + ALLTRIM(THis.valor_buscado) + "%' "
lcSql = lcSql + "	OR familias.descripcio LIKE '%" + ALLTRIM(THis.valor_buscado) + "%' "
lcSql = lcSql + "	OR subfam.descripcio LIKE '%" + ALLTRIM(THis.valor_buscado) + "%' "
lcSql = lcSql + "	OR proveedor.razSoc LIKE '%" + ALLTRIM(THis.valor_buscado) + "%') "

loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_tmp"

IF !loResult.OpenQuery(lcSql) THEN
	This.ErrorMessage = loResult.Error_Message
	RETURN .F.
ENDIF

SELECT cur_tmp
DO WHILE !EOF("cur_tmp")
	SELECT cur_Articulos
	APPEND BLANK
	REPLACE sel WITH .F.
	REPLACE cur_Articulos.idArticulo WITH cur_tmp.idArticulo ADDITIVE
	REPLACE cur_Articulos.codArt WITH cur_tmp.codArt ADDITIVE
	REPLACE cur_Articulos.descripcio WITH cur_tmp.descripcio ADDITIVE

	SELECT cur_tmp
	SKIP
ENDDO

loResult.Close_Query()

SELECT cur_Articulos
IF RECCOUNT("cur_Articulos") > 0 THEN
	GO TOP
ENDIF

RETURN .T.

ENDPROC
PROCEDURE limpiar
This.idStkDep = 0
This.idArticulo = 0

SELECT cur_Articulos
ZAP

ENDPROC
PROCEDURE validar_datos
LOCAL lnCont

IF This.idStkDep = 0 THEN
	This.ErrorMessage = "Debe ingresar el depósito"
ENDIF

lnCont = 0

SELECT cur_Articulos
IF RECCOUNT("cur_Articulos") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_Articulos")
	IF cur_Articulos.Sel THEN
		lnCont = lnCont + 1
	ENDIF

	SELECT cur_Articulos
	SKIP
ENDDO

IF lnCont = 0 THEN
	This.ErrorMessage = "Debe seleccionar al menos un artículo"
	RETURN .F.
ENDIF

RETURN .T.	

ENDPROC
PROCEDURE esduplicado
LOCAL loResult, lcSql, lnCount

loResult = CREATEOBJECT("odbc_result")
lcSql = ""
lnCount = 0

lcSql = "SELECT COUNT(*) AS Cantidad FROM art_dep WHERE idArticulo = " + ALLTRIM(STR(This.idArticulo))
lcSql = lcSql + "	AND idStkDep = " + ALLTRIM(STR(This.idStkDep)) + " "
lcSql = lcSql + "	AND fecBaja IS NULL "

loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_tmp"
loResult.OpenQuery(lcSql) 

IF TYPE("cur_tmp.Cantidad") == "C" THEN
	lnCount = INT(VAL(cur_tmp.Cantidad))
ELSE
	lnCount = cur_tmp.Cantidad
ENDIF

SELECT cur_tmp
IF lnCount <> 0 THEN
	loResult.Close_Query()
	RETURN .T.
ENDIF

loResult.Close_Query()
RETURN .F.
ENDPROC
PROCEDURE marcar_todos
SELECT cur_Articulos
IF RECCOUNT("cur_Articulos") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_Articulos")
	LOCK()
	REPLACE cur_Articulos.Sel WITH .T.
	UNLOCK
	
	SELECT cur_Articulos
	SKIP
ENDDO

SELECT cur_Articulos
IF RECCOUNT("cur_Articulos") > 0 THEN
	GO TOP
ENDIF
ENDPROC
PROCEDURE desmarcar_todos
SELECT cur_Articulos
IF RECCOUNT("cur_Articulos") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_Articulos")
	LOCK()
	REPLACE cur_Articulos.Sel WITH .F.
	UNLOCK
	
	SELECT cur_Articulos
	SKIP
ENDDO

SELECT cur_Articulos
IF RECCOUNT("cur_Articulos") > 0 THEN
	GO TOP
ENDIF
ENDPROC
PROCEDURE rastrear_movstock
PARAMETERS tnIdArticulo

LOCAL lcSql, loRes

lcSql = ""
loRes = CREATEOBJECT("odbc_result")

lcSql = "SELECT COUNT(*) AS Cantidad "
lcSql = lcSql + "FROM stk_det INNER JOIN stk_cab ON stk_det.idStkCab = stk_cab.idStkCab "
lcSql = lcSql + "WHERE idArticulo = " + ALLTRIM(STR(tnIdArticulo))

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_stock"

IF !loRes.OpenQuery(lcSql) THEN
	This.ErrorMessage = loRes.ErrorMessage
	RETURN .F.
ENDIF

IF cur_stock.Cantidad = 0 THEN
	loRes.Close_Query()
	RETURN .F.
ENDIF

loRes.Close_Query()
RETURN .T.
ENDPROC
PROCEDURE busqueda_avanzada
PARAMETERS tnIdProvDD, tnIdProvHH, tnIdMarcaDD, tnIdMarcaHH, tnIdFamDD, tnIdFamHH, tnIdSubFamDD, tnIdSubFamHH, tnIdArtDD, tnIdArtHH

LOCAL loResult, lcSql

loResult = CREATEOBJECT("odbc_result")
lcSql = ""

lcSql = "SELECT articulos.idArticulo, articulos.codArt, articulos.descripcio "
lcSql = lcSql + "FROM articulos "
lcSql = lcSql + "	INNER JOIN familias ON familias.idFamilia = articulos.idFamilia "
lcSql = lcSql + "	INNER JOIN subfam ON subfam.idSubFam = articulos.idSubFam "
lcSql = lcSql + "	INNER JOIN proveedor ON proveedor.idProv = articulos.idProv "


IF tnIdProvDD = 0 .AND. tnIdProvHH = 0 THEN
	tnIdProvHH = 999999
ENDIF

IF tnIdMarcaDD = 0 .AND. tnIdMarcaHH = 0 THEN
	tnIdMarcaHH = 9999
ENDIF

IF tnIdFamDD = 0 .AND. tnIdFamHH = 0 THEN
	tnIdFamHH = 9999
ENDIF

IF tnIdSubFamDD = 0 .AND. tnIdSubFamHH = 0 THEN
	tnIdSubFamHH = 9999
ENDIF

IF tnIdArtDD = 0 .AND. tnIdArtHH = 0 THEN
	tnIdArtHH = 9999999
ENDIF

lcSql = lcSql + "WHERE articulos.fecbaja IS NULL "
lcSql = lcSql + "	AND articulos.idProv 		BETWEEN " + ALLTRIM(STR(tnIdProvDD)) + " AND " + ALLTRIM(STR(tnIdProvHH)) + " "
lcSql = lcSql + "	AND articulos.idFamilia 	BETWEEN " + ALLTRIM(STR(tnIdFamDD)) + " AND " + ALLTRIM(STR(tnIdFamHH)) + " "
lcSql = lcSql + "	AND articulos.idSubFam 		BETWEEN " + ALLTRIM(STR(tnIdSubFamDD)) + " AND " + ALLTRIM(STR(tnIdSubFamHH)) + " "
lcSql = lcSql + "	AND articulos.idMarca 		BETWEEN " + ALLTRIM(STR(tnIdMarcaDD)) + " AND " + ALLTRIM(STR(tnIdMarcaHH)) + " "
lcSql = lcSql + "	AND articulos.idArticulo 	BETWEEN " + ALLTRIM(STR(tnIdArtDD)) + " AND " + ALLTRIM(STR(tnIdArtHH))

loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_tmp"

IF !loResult.OpenQuery(lcSql) THEN
	This.ErrorMessage = loResult.Error_Message
	RETURN .F.
ENDIF

SELECT cur_tmp
DO WHILE !EOF("cur_tmp")
	SELECT cur_Articulos
	APPEND BLANK
	REPLACE sel WITH .F.
	REPLACE cur_Articulos.idArticulo WITH cur_tmp.idArticulo ADDITIVE
	REPLACE cur_Articulos.codArt WITH cur_tmp.codArt ADDITIVE
	REPLACE cur_Articulos.descripcio WITH cur_tmp.descripcio ADDITIVE

	SELECT cur_tmp
	SKIP
ENDDO

loResult.Close_Query()

SELECT cur_Articulos
IF RECCOUNT("cur_Articulos") > 0 THEN
	GO TOP
ENDIF

RETURN .T.


ENDPROC
PROCEDURE Init
This.idArticulo = 0
This.idStkDep = 0
This.usuAlta = ALLTRIM(gcCodUsu)
This.idHostAlta = ALLTRIM(SYS(0))
This.usuModi = ALLTRIM(gcCodUsu)
This.idHostModi = ALLTRIM(SYS(0))
This.usuBaja = ALLTRIM(gcCodUsu)
This.idHostBaja = ALLTRIM(SYS(0))
ENDPROC


************************************************************
OBJETO: cl_mov_stock
************************************************************
*** PROPIEDADES ***
idstkcab = 0
tipomov = 
codusu = 
idhost = 
circuito = 
cbte = 
tipodoc = 
numcbte = 
errormessage = 
idcliente = 0
idprov = 0
idventasc = 0
Name = "cl_mov_stock"

*** METODOS ***
PROCEDURE grabar
PARAMETER tnIdProv

LOCAL lcSql, loCommand, loDT
LOCAL lnCont, lnProxIDPart

lcSql = ""
loCommand = CREATEOBJECT("odbc_command")
loDT = CREATEOBJECT("datetime")
lnCont = 0
lnProxIDPart = 0

IF tnIdProv <> 0 THEN
	this.idprov = tnIdProv
ENDIF

This.idStkCab = goConn.GetNextID("stk_cab", "idStkCab")

goConn.BeginTransaction()

lcSql = "INSERT INTO stk_cab ( "
lcSql = lcSql + "	idStkCab, "

IF This.idCliente <> 0 THEN
	lcSql = lcSql + " idCliente,"
ENDIF

IF This.idProv <> 0 THEN
	lcSql = lcSql + " idProv, "
ENDIF

lcSql = lcSql + "	circuito, "
lcSql = lcSql + "	cbte, "
lcSql = lcSql + "	tipoDoc, "
lcSql = lcSql + "	numCbte, "
lcSql = lcSql + "	usuAlta, "
lcSql = lcSql + "	fecAlta, "
lcSql = lcSql + "	idHostAlta) "
lcSql = lcSql + "VALUES ( "
lcSql = lcSql + ALLTRIM(STR(This.idStkCab)) + ", "

IF This.idCliente <> 0 THEN
	lcSql = lcSql + ALLTRIM(STR(This.idCliente)) + ", "
ENDIF

IF This.idProv <> 0 THEN
	lcSql = lcSql + ALLTRIM(STR(This.idprov)) + ", "
ENDIF

lcSql = lcSql + "'" + ALLTRIM(This.circuito) + "', "
lcSql = lcSql + "'" + ALLTRIM(This.Cbte) + "', "
lcSql = lcSql + "'" + ALLTRIM(This.TipoDoc) + "', "
lcSql = lcSql + "'" + ALLTRIM(This.numCbte) + "', "
lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
lcSql = lcSql + loDT.GetDateTime() + ", "
lcSql = lcSql + "'" + ALLTRIM(This.idHost) + "')"

loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = lcSql

IF !loCommand.Execute() THEN
	This.ErrorMessage = loCommand.ErrorMessage
	goConn.Rollback()
	RETURN .F.
ENDIF

IF tnIdProv <> 0 THEN
	SELECT	* ;
	FROM	cur_stkdet ;
	WHERE	idProv = tnIdProv ;
	INTO CURSOR cur_det

	SELECT cur_det
	IF RECCOUNT("cur_det") > 0 THEN
		GO TOP
	ENDIF

	DO WHILE !EOF("cur_det")
		lnCont = lnCont + 1
		
		lcSql = "INSERT INTO stk_det ( "
		lcSql = lcSql + "idStkDet, "
		lcSql = lcSql + "idStkCab, "
		lcSql = lcSql + "idArticulo, "
		lcSql = lcSql + "idStkDep, "
		lcSql = lcSql + "tipoMov, "
		lcSql = lcSql + "costoRep, "
		lcSql = lcSql + "cantidad, "
		lcSql = lcSql + "nroPart) "
		lcSql = lcSql + "VALUES ( "
		lcsql = lcSql + ALLTRIM(STR(lnCont)) + ", "
		lcSql = lcSql + ALLTRIM(STR(This.idStkCab)) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_det.idArticulo)) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_det.idStkDep)) + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_det.tipoMov) + "', "		
		lcSql = lcSql + "'" + ALLTRIM(STR(cur_det.costoRep, 10, 2)) + "', "
		lcSql = lcSql + ALLTRIM(STR(cur_det.cantidad, 10, 2)) + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_det.nroPart) + "')"
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			This.ErrorMessage = loCommand.ErrorMessage
			goConn.Rollback()
			RETURN .F.
		ENDIF
		
		&& Si el número de partida no está vacío, entonces,
		&& genero el registro en stk_part
		
		IF !(ALLTRIM(cur_det.nroPart) == "") THEN		
			lnProxIDPart = goConn.GetNextID("stk_part", "idStkPart")
			
			lcSql = "INSERT INTO stk_part ( "
			lcSql = lcSql + "	idStkPart, "
			lcSql = lcSql + "	idStkCab, "
			lcSql = lcSql + "	idArticulo, "
			lcSql = lcSql + "	codArt, "
			lcSql = lcSql + "	nroPart, "
			lcSql = lcSql + "	cantidad, "
			lcSql = lcSql + "	fecha) "
			lcSql = lcSql + "VALUES ( "
			lcSql = lcSql + ALLTRIM(STR(lnProxIDPart)) + ", "
			lcSql = lcSql + ALLTRIM(STR(this.idStkCab)) + ", "
			lcSql = lcSql + ALLTRIM(STR(cur_det.idArticulo)) + ", "
			lcSql = lcSql + "'" + ALLTRIM(cur_det.codArt) + "', "
			lcSql = lcSql + "'" + ALLTRIM(cur_det.nroPart) + "', "
			lcSql = lcSql + ALLTRIM(STR(cur_det.cantidad, 10, 2)) + ", "
			lcSql = lcSql + loDT.getDateTime()
			lcSql = lcSql + ")"
			
			
			loCommand.ActiveConnection = goConn.ActiveConnection
			loCommand.CommandText = lcSql
			
			IF !loCommand.Execute() THEN
				This.ErrorMessage = loCommand.ErrorMessage
				goConn.Rollback()
				RETURN .F.
			ENDIF
		ENDIF
		
		SELECT cur_det
		SKIP
	ENDDO
	
	USE IN cur_det
ELSE
	SELECT cur_stkdet
	IF RECCOUNT("cur_stkdet") > 0 THEN
		GO TOP
	ENDIF

	DO WHILE !EOF("cur_stkdet")
		lnCont = lnCont + 1
		
		lcSql = "INSERT INTO stk_det ( "
		lcSql = lcSql + "idStkDet, "
		lcSql = lcSql + "idStkCab, "
		lcSql = lcSql + "idArticulo, "
		lcSql = lcSql + "idStkDep, "
		lcSql = lcSql + "tipoMov, "
		lcSql = lcSql + "costoRep, "
		lcSql = lcSql + "cantidad, "
		lcSql = lcSql + "nroPart) "
		lcSql = lcSql + "VALUES ( "
		lcsql = lcSql + ALLTRIM(STR(lnCont)) + ", "
		lcSql = lcSql + ALLTRIM(STR(This.idStkCab)) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_stkdet.idArticulo)) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_stkdet.idStkDep)) + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_stkdet.tipoMov) + "', "
		lcSql = lcSql + "'" + ALLTRIM(STR(cur_stkdet.costoRep, 10, 2)) + "', "
		lcSql = lcSql + ALLTRIM(STR(cur_stkdet.cantidad, 10, 2)) + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_stkdet.nroPart) + "')"
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			This.ErrorMessage = loCommand.ErrorMessage
			goConn.Rollback()
			RETURN .F.
		ENDIF
		
		&& Si el número de partida no está vacío, entonces,
		&& genero el registro en stk_part
		
		IF !(ALLTRIM(cur_stkdet.nroPart) == "") THEN		
			lnProxIDPart = goConn.GetNextID("stk_part", "idStkPart")
			
			lcSql = "INSERT INTO stk_part ( "
			lcSql = lcSql + "	idStkPart, "
			lcSql = lcSql + "	idStkCab, "
			lcSql = lcSql + "	idArticulo, "
			lcSql = lcSql + "	codArt, "
			lcSql = lcSql + "	nroPart, "
			lcSql = lcSql + "	cantidad, "
			lcSql = lcSql + "	fecha) "
			lcSql = lcSql + "VALUES ( "
			lcSql = lcSql + ALLTRIM(STR(lnProxIDPart)) + ", "
			lcSql = lcSql + ALLTRIM(STR(this.idStkCab)) + ", "
			lcSql = lcSql + ALLTRIM(STR(cur_stkdet.idArticulo)) + ", "
			lcSql = lcSql + "'" + ALLTRIM(cur_stkdet.codArt) + "', "
			lcSql = lcSql + "'" + ALLTRIM(cur_stkdet.nroPart) + "', "
			lcSql = lcSql + ALLTRIM(STR(cur_stkdet.cantidad, 10, 2)) + ", "
			lcSql = lcSql + loDT.getDateTime()
			lcSql = lcSql + ")"
			
			loCommand.ActiveConnection = goConn.ActiveConnection
			loCommand.CommandText = lcSql
			
			IF !loCommand.Execute() THEN
				This.ErrorMessage = loCommand.ErrorMessage
				goConn.Rollback()
				RETURN .F.
			ENDIF				
		ENDIF

		SELECT cur_stkdet
		SKIP
	ENDDO
ENDIF

IF INT(VAL(getConfig("DEMO"))) = 0 THEN
	IF !This.asignar_dep() THEN
		MESSAGEBOX("No se han podido asignar los depósitos correctamente.",0+16,"Error") 
		goConn.Rollback()
		RETURN .F.
	ENDIF 
ENDIF 

goConn.Commit()

RETURN .T.
ENDPROC
PROCEDURE crear_cursor
&& Creo el cursor que va a tener el detalle del movimiento

CREATE CURSOR cur_stkdet (	;
	idStkDet	int,;
	idStkCab	int,;
	idArticulo	int,;
	nroPart		varchar(30),;
	tipoMov		varchar(3),;
	codArt		varchar(20),;
	descripcio	varchar(60),;
	idProv		int,;
	razSoc		varchar(60),;
	idStkDep	int,;
	deposito	varchar(60),;
	costoRep	float(10,2),;
	cantidad	float(10, 2))

CREATE CURSOR cur_artSD (;
	idArticulo	int,;
	codArt		varchar(20),;
	descripcio	varchar(100))
	

	
ENDPROC
PROCEDURE agregar_articulo
PARAMETERS tnIdArticulo, tnCantidad, tcNroPart

LOCAL lcSql, loRes, lnExistencia
LOCAL lnIdStkDep, lcCodArt, lcDescripcio
LOCAL lnIdProv, lcRazSoc, lcDescDep, lnCostoRep, loConn

lcSql = ""
loRes = CREATEOBJECT("odbc_result")
loConn = CREATEOBJECT("odbc_connect")
lnIdProv = 0
lcRazSoc = ""
lcDescDep = ""
lnCostoRep = 0.00
lnExistencia = 0

&& Le asigno el deposito 1 por default, por si no tiene asignado ningun dep el articulo. 
&& El motivo es porque sino se asigna dep no se hace el mov de stock del articulo, tanto en ventas como en compras.
lnIdStkDep = 1 

IF INT(VAL(getConfig("DEMO"))) = 1 THEN
	&& Si es la versión DEMO entonces genero la conexion contra la base de cuenta 1.

	loConn.ConnectionString = ALLTRIM(getConfig("ODBC_C1"))

	IF !loConn.Open() THEN
		MESSAGEBOX(loConn.ErrorMessage, 0+48, Thisform.Caption)
		RETURN .F.
	ENDIF
ELSE
	loConn.ActiveConnection = goConn.ActiveConnection
ENDIF 

lcSql = "SELECT * FROM articulos WHERE idArticulo = " + ALLTRIM(STR(tnIdArticulo))
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_tempo"
loRes.OpenQuery(lcSql)

SELECT cur_tempo
lcCodArt = cur_tempo.codArt
lcDescripcio = cur_tempo.descripcio
lnIdProv = cur_tempo.idProv
lnCostoRep = cur_tempo.costoRep
loRes.Close_Query()

lcSql = "SELECT razSoc FROM proveedor WHERE idProv = " + ALLTRIM(STR(lnIdProv))
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_tempo"
loRes.OpenQuery(lcSql)

SELECT cur_tempo
lcRazSoc = cur_tempo.razSoc
loRes.Close_Query()

&& Valido que el artículo tenga depósito asignado
IF getGlobalCFG("STK_MODULE") THEN
	lcSql = "SELECT idStkDep FROM art_dep WHERE idArticulo = " + ALLTRIM(STR(tnIdArticulo))
	lcSql = lcSql + " AND fecbaja IS NULL"
	loRes.ActiveConnection = loConn.ActiveConnection
	loRes.Cursor_Name = "cur_tempo"
	loRes.OpenQuery(lcSql)

	SELECT cur_tempo
	IF RECCOUNT("cur_tempo") > 0 THEN
		lnIdStkDep = cur_tempo.idStkDep
		
		loRes.Close_Query()
		
		lcSql = "SELECT descripcio FROM stk_deps WHERE idStkDep = " + ALLTRIM(STR(lnIdStkDep))
		loRes.ActiveConnection = loConn.ActiveConnection
		loRes.Cursor_Name = "cur_tempo"
		loRes.OpenQuery(lcSql)

		SELECT cur_tempo
		IF RECCOUNT("cur_tempo") > 0 THEN
			lcDescDep = cur_tempo.descripcio
		ENDIF
		
		loRes.Close_Query()
	ELSE
		SELECT cur_artSD
		APPEND BLANK
		REPLACE cur_artSD.idArticulo WITH tnIdArticulo
		REPLACE cur_artSD.codArt WITH ALLTRIM(lcCodArt) ADDITIVE
		REPLACE cur_artSD.descripcio WITH ALLTRIM(lcDescripcio) ADDITIVE
		
		SELECT cur_artSD
		GO TOP
		
		&&This.ErrorMessage = "Este artículo no tiene un depósito asignado"
		loRes.Close_Query()
		&&RETURN .F.
	ENDIF
ENDIF

&& A continuación realiza los cálculos de movimientos de stock a generar
&& según los tipos de movimientos.

lcSql = "SELECT * FROM stk_tipomov WHERE codMov = '" + This.tipoMov + "'"

loRes.ActiveConnection = loConn.ActiveConnection
loRes.cursor_name = "cur_tipomov"
loRes.openquery(lcSql)

IF cur_tipomov.signo = -1 THEN
	tnCantidad = tnCantidad * -1
ELSE
	IF This.tipoMov == "AJU" THEN
		lnExistencia = This.get_exit_byartpart(tnIdArticulo, tcNroPart)
		tnCantidad = tnCantidad - lnExistencia
	ENDIF
ENDIF

loRes.close_query()

SELECT cur_stkdet
APPEND BLANK
REPLACE idStkCab WITH This.idStkCab
REPLACE idArticulo WITH tnIdArticulo ADDITIVE
REPLACE idStkDep WITH lnIdStkDep ADDITIVE
REPLACE tipoMov WITH This.tipoMov ADDITIVE
REPLACE deposito WITH ALLTRIM(lcDescDep) ADDITIVE
REPLACE idProv WITH lnIdProv ADDITIVE
REPLACE razSoc WITH ALLTRIM(lcRazSoc) ADDITIVE
REPLACE codArt WITH ALLTRIM(lcCodArt) ADDITIVE
REPLACE descripcio WITH ALLTRIM(lcDescripcio) ADDITIVE
REPLACE costoRep WITH lnCostoRep ADDITIVE
REPLACE cantidad WITH tnCantidad ADDITIVE
REPLACE nroPart WITH tcNroPart ADDITIVE

GO BOTTOM

RETURN .T.
ENDPROC
PROCEDURE limpiar
SELECT cur_stkdet
ZAP

This.idstkcab = 0
This.tipomov = "ENT"
This.codUsu = ALLTRIM(gcCodUsu)
This.idHost = ALLTRIM(SYS(0))
ENDPROC
PROCEDURE generar_cbtes
SELECT 	idProv, MAX(razSoc) AS razSoc ;
FROM 	cur_stkdet	;
GROUP BY idProv ;
ORDER BY idProv ;
INTO CURSOR cur_proveedor

SELECT cur_Proveedor
IF RECCOUNT("cur_Proveedor") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_Proveedor")
	WAIT WINDOW "Generando comprobante de stock del proveedor: " + ALLTRIM(cur_Proveedor.razSoc) NOWAIT

	IF !This.grabar(cur_Proveedor.idProv) THEN
		RETURN .F.
	ENDIF

	SELECT cur_Proveedor
	SKIP
ENDDO

USE IN cur_Proveedor
WAIT WINDOW "Creación de comprobantes finalizado..." NOWAIT

RETURN .T.

ENDPROC
PROCEDURE eliminar
PARAMETERS tnIdArticulo

SELECT cur_stkdet
DELETE FROM cur_stkdet WHERE cur_stkdet.idArticulo = tnIdArticulo

ENDPROC
PROCEDURE grabar2
LOCAL lcSql, loCommand, loDT
LOCAL lnCont, loProg

lcSql = ""
loCommand = CREATEOBJECT("odbc_command")
loDT = CREATEOBJECT("datetime")
loProg = CREATEOBJECT("_thermometer")
lnCont = 0

This.idStkCab = goConn.GetNextID("stk_cab", "idStkCab")

lcSql = "INSERT INTO stk_cab ( "
lcSql = lcSql + "	idStkCab, "

IF This.idCliente <> 0 THEN
	lcSql = lcSql + " idCliente,"
ENDIF

IF This.idProv <> 0 THEN
	lcSql = lcSql + " idProv, "
ENDIF

lcSql = lcSql + "	circuito, "
lcSql = lcSql + "	cbte, "
lcSql = lcSql + "	tipoDoc, "
lcSql = lcSql + "	numCbte, "
lcSql = lcSql + "	usuAlta, "
lcSql = lcSql + "	fecAlta, "
lcSql = lcSql + "	idHostAlta) "
lcSql = lcSql + "VALUES ( "
lcSql = lcSql + ALLTRIM(STR(This.idStkCab)) + ", "

IF This.idCliente <> 0 THEN
	lcSql = lcSql + ALLTRIM(STR(This.idCliente)) + ", "
ENDIF

IF This.idProv <> 0 THEN
	lcSql = lcSql + ALLTRIM(STR(This.idprov)) + ", "
ENDIF

lcSql = lcSql + "'" + ALLTRIM(This.circuito) + "', "
lcSql = lcSql + "'" + ALLTRIM(This.Cbte) + "', "
lcSql = lcSql + "'" + ALLTRIM(This.TipoDoc) + "', "
lcSql = lcSql + "'" + ALLTRIM(This.numCbte) + "', "
lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
lcSql = lcSql + loDT.GetDateTime() + ", "
lcSql = lcSql + "'" + ALLTRIM(This.idHost) + "')"

loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = lcSql

IF !loCommand.Execute() THEN
	This.ErrorMessage = loCommand.ErrorMessage
	RETURN .F.
ENDIF

loProg.Show()

SELECT cur_stkdet
IF RECCOUNT("cur_stkdet") > 0 THEN
	GO TOP
ENDIF

lnCont = 1
DO WHILE !EOF("cur_stkdet")
	lcSql = "INSERT INTO stk_det ( "
	lcSql = lcSql + "idStkDet, "
	lcSql = lcSql + "idStkCab, "
	lcSql = lcSql + "idArticulo, "
	lcSql = lcSql + "idStkDep, "
	lcSql = lcSql + "tipoMov, "
	lcSql = lcSql + "costoRep, "
	lcSql = lcSql + "cantidad, "
	lcSql = lcSql + "nroPart) "
	lcSql = lcSql + "VALUES ( "
	lcsql = lcSql + ALLTRIM(STR(lnCont)) + ", "
	lcSql = lcSql + ALLTRIM(STR(This.idStkCab)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_stkdet.idArticulo)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_stkdet.idStkDep)) + ", "
	lcSql = lcSql + "'" + ALLTRIM(cur_stkdet.tipoMov) + "', "		
	lcSql = lcSql + "'" + ALLTRIM(STR(cur_stkdet.costoRep, 10, 2)) + "', "
	lcSql = lcSql + ALLTRIM(STR(cur_stkdet.cantidad)) + ", "
	lcSql = lcSql + "'" + ALLTRIM(cur_stkdet.nroPart) + "')"
	
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute() THEN
		This.ErrorMessage = loCommand.ErrorMessage
		RETURN .F.
	ENDIF
	
	&& Si el número de partida no está vacío, entonces,
	&& genero el registro en stk_part
	
	IF !(ALLTRIM(cur_stkdet.nroPart) == "") THEN		
		lnProxIDPart = goConn.GetNextID("stk_part", "idStkPart")
		
		lcSql = "INSERT INTO stk_part ( "
		lcSql = lcSql + "	idStkPart, "
		lcSql = lcSql + "	idStkCab, "
		lcSql = lcSql + "	idArticulo, "
		lcSql = lcSql + "	codArt, "
		lcSql = lcSql + "	nroPart, "
		lcSql = lcSql + "	cantidad, "
		lcSql = lcSql + "	fecha) "
		lcSql = lcSql + "VALUES ( "
		lcSql = lcSql + ALLTRIM(STR(lnProxIDPart)) + ", "
		lcSql = lcSql + ALLTRIM(STR(this.idStkCab)) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_stkdet.idArticulo)) + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_stkdet.codArt) + "', "
		lcSql = lcSql + "'" + ALLTRIM(cur_stkdet.nroPart) + "', "
		lcSql = lcSql + ALLTRIM(STR(cur_stkdet.cantidad)) + ", "
		lcSql = lcSql + loDT.getDateTime()
		lcSql = lcSql + ")"
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			This.ErrorMessage = loCommand.ErrorMessage
			RETURN .F.
		ENDIF
	ENDIF	
	
	lnCont = lnCont + 1
	loProg.update((lnCont * 100) / RECCOUNT("cur_stkdet"), "Grabando Movimientos...")
	SELECT cur_stkdet
	SKIP
ENDDO

loProg.Complete()

IF INT(VAL(getConfig("DEMO"))) = 0 THEN
	IF !This.asignar_dep() THEN
		MESSAGEBOX("No se han podido asignar los depósitos correctamente.",0+16,"Error") 
		goConn.Rollback()
		RETURN .F.
	ENDIF 
ENDIF 

RETURN .T.
ENDPROC
PROCEDURE getmovs
PARAMETERS tdFecDD, tdFecHH, tnIdProvDD, tnIdProvHH, tnIdFamiliaDD, tnIdFamiliaHH, tnIdSubFamDD, tnIdSubFamHH, tnIdStkDepDD, tnIdStkDepHH,;
	tnIdMarcaDD, tnIdMarcaHH, tnIdArticuloDD, tnIdArticuloHH, lcTipoMov, lcUsuario

LOCAL loResult, lcSql, loDT

loResult = CREATEOBJECT("odbc_result")
loDT = CREATEOBJECT("datetime")
lcSql = ""

&& Genero el detalle de movimientos para emitir la consulta o reporte
lcSql = "SELECT		stk_cab.idStkCab, "
lcSql = lcSql + "	stk_cab.circuito, "
lcSql = lcSql + "	stk_cab.cbte, "
lcSql = lcSql + "	stk_cab.tipoDoc, "
lcSql = lcSql + "	stk_cab.numCbte, "
lcSql = lcSql + "	stk_det.idArticulo, "
lcSql = lcSql + "	LTRIM(RTRIM(articulos.codArt)) AS codArt, "
lcSql = lcSql + "	articulos.descripcio, "
lcSql = lcSql + "	proveedor.idProv, "
lcSql = lcSql + "	proveedor.razSoc, "
lcSql = lcSql + "	familias.idFamilia, "
lcSql = lcSql + "	familias.descripcio AS familia, "
lcSql = lcSql + "	subfam.idsubFam, "
lcSql = lcSql + "	subfam.descripcio AS subFam, "
lcSql = lcSql + "	stk_deps.idStkDep, "
lcSql = lcSql + "	stk_deps.descripcio AS deposito, "
lcSql = lcSql + "	marcas.idMarca, "
lcSql = lcSql + "	marcas.descripcio AS marca, "
lcSql = lcSql + "	stk_cab.fecAlta, "
lcSql = lcSql + "	LTRIM(RTRIM(stk_det.nroPart)) AS nroPart, "
lcSql = lcSql + "	stk_det.costoRep, "
lcSql = lcSql + "	clientes.idCliente, "
lcSql = lcSql + "	clientes.razSoc AS rsCli, "
lcSql = lcSql + "	CASE WHEN stk_det.cantidad > 0 THEN stk_det.cantidad ELSE 0 END Entrada, "
lcSql = lcSql + "	CASE WHEN stk_det.cantidad < 0 THEN stk_det.cantidad * -1 ELSE 0 END Salida "
lcSql = lcSql + "FROM stk_cab INNER JOIN stk_det ON stk_det.idStkCab = stk_cab.idStkCab "
lcSql = lcSql + "	INNER JOIN articulos ON articulos.idArticulo = stk_det.idArticulo "
lcSql = lcSql + "	INNER JOIN proveedor ON proveedor.idProv = articulos.idProv "
lcSql = lcSql + "	INNER JOIN familias ON familias.idFamilia = articulos.idFamilia "
lcSql = lcSql + "	INNER JOIN subfam ON subfam.idSubFam = articulos.idSubFam "
lcSql = lcSql + "	INNER JOIN stk_deps ON stk_deps.idStkDep = stk_det.idStkDep "
lcSql = lcSql + "	INNER JOIN marcas ON articulos.idMarca = marcas.idMarca "
lcSql = lcSql + "	LEFT JOIN clientes ON stk_cab.idCliente = clientes.idCliente "

IF INT(VAL(getConfig("SQLSRV"))) = 1 THEN
	lcSql = lcSql + "WHERE CONVERT(CHAR(8), stk_cab.fecAlta, 112) BETWEEN " + loDT.toMySql(tdFecDD) + " AND " + loDT.toMySql(tdFecHH) + " "
ELSE
	lcSql = lcSql + "WHERE CAST(stk_cab.fecAlta AS DATE) BETWEEN " + loDT.toMySql(tdFecDD) + " AND " + loDT.toMySql(tdFecHH) + " "
ENDIF

IF tnIdProvDD <> 0 .AND. tnIdProvHH <> 0 THEN
	lcSql = lcSql + "	AND articulos.idProv BETWEEN " + ALLTRIM(STR(tnIdProvDD)) + " AND " + ALLTRIM(STR(tnIdProvHH)) + " "
ENDIF

IF tnIdFamiliaDD <> 0 .AND. tnIdFamiliaHH <> 0 THEN
	lcSql = lcSql + "	AND articulos.idFamilia BETWEEN " + ALLTRIM(STR(tnIdFamiliaDD)) + " AND " + ALLTRIM(STR(tnIdFamiliaHH)) + " "
ENDIF

IF tnIdSubFamDD <> 0 .AND. tnIdSubFamHH <> 0 THEN
	lcSql = lcSql + "	AND articulos.idSubFam BETWEEN " + ALLTRIM(STR(tnIdSubFamDD)) + " AND " + ALLTRIM(STR(tnIdSubFamHH)) + " "
ENDIF

IF tnIdStkDepDD <> 0 .AND. tnIdStkDepHH <> 0 THEN
	lcSql = lcSql + "	AND stk_deps.idStkDep BETWEEN " + ALLTRIM(STR(tnIdStkDepDD)) + " AND " + ALLTRIM(STR(tnIdStkDepHH))
ENDIF

IF tnIdMarcaDD <> 0 .AND. tnIdMarcaHH <> 0 THEN
	lcSql = lcSql + "	AND marcas.idMarca BETWEEN " + ALLTRIM(STR(tnIdMarcaDD)) + " AND " + ALLTRIM(STR(tnIdMarcaHH)) + " "
ENDIF

IF tnIdArticuloDD <> 0 .AND. tnIdArticuloHH <> 0 THEN
	lcSql = lcSql + "	AND articulos.idArticulo BETWEEN " + ALLTRIM(STR(tnIdArticuloDD)) + " AND " + ALLTRIM(STR(tnIdArticuloHH)) + " "
ENDIF

IF lcTipoMov <> "Todos" THEN
	lcSql = lcSql + "	AND stk_det.tipoMov = '" + ALLTRIM(lcTipoMov) + "' "
ENDIF

IF lcUsuario <> "Todos" THEN
	lcSql = lcSql + "	AND stk_cab.UsuAlta = '" + ALLTRIM(lcUsuario) + "' "
ENDIF

lcSql = lcSql + " ORDER BY articulos.codArt, stk_det.nroPart, stk_cab.fecAlta ASC"

loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_MovStock"
IF !loResult.OpenQuery(lcSql) THEN
	This.ErrorMessage = loResult.Error_Message
	RETURN .F.
ENDIF

SELECT cur_MovStock
IF RECCOUNT("cur_MovStock") > 0 THEN
	GO TOP
ELSE
	This.ErrorMessage = "No hay datos para mostrar"	
	RETURN .F.
ENDIF

RETURN .T.

ENDPROC
PROCEDURE getexistencia
PARAMETERS tdFecDD, tdFecHH, tnIdProvDD, tnIdProvHH, tnIdFamiliaDD, tnIdFamiliaHH, tnIdSubFamDD, tnIdSubFamHH, tnIdStkDepDD, tnIdStkDepHH,;
	tnIdMarcaDD, tnIdMarcaHH, tnIdArticuloDD, tnIdArticuloHH

LOCAL loResult, lcSql, loDT

loResult = CREATEOBJECT("odbc_result")
loDT = CREATEOBJECT("datetime")
lcSql = ""

lcSql = "SELECT		stk_det.idArticulo, "
lcSql = lcSql + "	MAX(articulos.codArt) AS codArt, "
lcSql = lcSql + "	MAX(articulos.descripcio) AS descripcio, "
lcSql = lcSql + "	SUM(stk_det.cantidad) AS Existencia "
lcSql = lcSql + "FROM stk_cab INNER JOIN stk_det ON stk_det.idStkCab = stk_cab.idStkCab "
lcSql = lcSql + "	INNER JOIN articulos ON articulos.idArticulo = stk_det.idArticulo "
lcSql = lcSql + "	INNER JOIN proveedor ON proveedor.idProv = articulos.idProv "
lcSql = lcSql + "	INNER JOIN familias ON familias.idFamilia = articulos.idFamilia "
lcSql = lcSql + "	INNER JOIN subfam ON subfam.idSubFam = articulos.idSubFam "
lcSql = lcSql + "	INNER JOIN stk_deps ON stk_deps.idStkDep = stk_det.idStkDep "
lcSql = lcSql + "	INNER JOIN marcas ON articulos.idMarca = marcas.idMarca "

IF INT(VAL(getConfig("SQLSRV"))) = 1 THEN
	lcSql = lcSql + "WHERE CONVERT(CHAR(8), stk_cab.fecAlta, 112) BETWEEN " + loDT.toMySql(tdFecDD) + " AND " + loDT.toMySql(tdFecHH) + " "
ELSE
	lcSql = lcSql + "WHERE CAST(stk_cab.fecAlta AS DATE) BETWEEN " + loDT.toMySql(tdFecDD) + " AND " + loDT.toMySql(tdFecHH) + " "
ENDIF

IF tnIdProvDD <> 0 .AND. tnIdProvHH <> 0 THEN
	lcSql = lcSql + "	AND articulos.idProv BETWEEN " + ALLTRIM(STR(tnIdProvDD)) + " AND " + ALLTRIM(STR(tnIdProvHH)) + " "
ENDIF

IF tnIdFamiliaDD <> 0 .AND. tnIdFamiliaHH <> 0 THEN
	lcSql = lcSql + "	AND articulos.idFamilia BETWEEN " + ALLTRIM(STR(tnIdFamiliaDD)) + " AND " + ALLTRIM(STR(tnIdFamiliaHH)) + " "
ENDIF

IF tnIdSubFamDD <> 0 .AND. tnIdSubFamHH <> 0 THEN
	lcSql = lcSql + "	AND articulos.idSubFam BETWEEN " + ALLTRIM(STR(tnIdSubFamDD)) + " AND " + ALLTRIM(STR(tnIdSubFamHH)) + " "
ENDIF

IF tnIdStkDepDD <> 0 .AND. tnIdStkDepHH <> 0 THEN
	lcSql = lcSql + "	AND stk_deps.idStkDep BETWEEN " + ALLTRIM(STR(tnIdStkDepDD)) + " AND " + ALLTRIM(STR(tnIdStkDepHH))
ENDIF

IF tnIdMarcaDD <> 0 .AND. tnIdMarcaHH <> 0 THEN
	lcSql = lcSql + "	AND marcas.idMarca BETWEEN " + ALLTRIM(STR(tnIdMarcaDD)) + " AND " + ALLTRIM(STR(tnIdMarcaHH)) + " "
ENDIF

IF tnIdArticuloDD <> 0 .AND. tnIdArticuloHH <> 0 THEN
	lcSql = lcSql + "	AND articulos.idArticulo BETWEEN " + ALLTRIM(STR(tnIdArticuloDD)) + " AND " + ALLTRIM(STR(tnIdArticuloHH)) + " "
ENDIF

lcSql = lcSql + "GROUP BY stk_det.idArticulo "
lcSql = lcSql + "ORDER BY MAX(articulos.codArt)"

loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_MovStock"
IF !loResult.OpenQuery(lcSql) THEN
	This.ErrorMessage = loResult.Error_Message
	RETURN .F.
ENDIF

SELECT cur_MovStock
IF RECCOUNT("cur_MovStock") > 0 THEN
	GO TOP
ELSE
	This.ErrorMessage = "No hay datos para mostrar"
	RETURN .F.
ENDIF

RETURN .T.
ENDPROC
PROCEDURE get_stkval
PARAMETERS tdFecDD, tdFecHH, tnIdProvDD, tnIdProvHH, tnIdFamiliaDD, tnIdFamiliaHH, tnIdSubFamDD, tnIdSubFamHH, tnIdStkDepDD, tnIdStkDepHH,;
	tnIdMarcaDD, tnIdMarcaHH, tnIdArticuloDD, tnIdArticuloHH

LOCAL loResult, lcSql, loDT

loResult = CREATEOBJECT("odbc_result")
loDT = CREATEOBJECT("datetime")
lcSql = ""

lcSql = "SELECT		articulos.idArticulo, "
lcSql = lcSql + "	MAX(articulos.codArt) AS codArt, "
lcSql = lcSql + "	MAX(articulos.descripcio) AS descripcio, "
lcSql = lcSql + "	MAX(proveedor.idProv) AS idProv, "
lcSql = lcSql + "	MAX(proveedor.RazSoc) AS proveedor, "
lcSql = lcSql + "	MAX(marcas.idMarca) AS idMarca, "
lcSql = lcSql + "	MAX(marcas.descripcio) AS marca, "
lcSql = lcSql + "	MAX(familias.idFamilia) AS idFamilia, "
lcSql = lcSql + "	MAX(familias.descripcio) AS familia, "
lcSql = lcSql + "	MAX(subfam.idSubFam) AS idSubFam, "
lcSql = lcSql + "	MAX(subfam.descripcio) AS subFam, "
lcSql = lcSql + "	SUM(stk_det.cantidad) AS stock, "
lcSql = lcSql + "	MAX(articulos.costoRep) AS costo, "
lcSql = lcSql + "	(SUM(stk_det.cantidad) * MAX(articulos.costoRep)) AS StkVal "
lcSql = lcSql + "FROM	stk_cab INNER JOIN stk_det ON stk_det.idStkCab = stk_cab.idStkCab "
lcSql = lcSql + "	INNER JOIN articulos ON articulos.idArticulo = stk_det.idArticulo "
lcSql = lcSql + "	INNER JOIN proveedor ON proveedor.idProv = articulos.idProv " 
lcSql = lcSql + "	INNER JOIN familias ON familias.idFamilia = articulos.idFamilia "
lcSql = lcSql + "	INNER JOIN subfam ON subfam.idSubFam = articulos.idSubFam "
lcSql = lcSql + "	INNER JOIN stk_deps ON stk_deps.idStkDep = stk_det.idStkDep "
lcSql = lcSql + "	INNER JOIN marcas ON articulos.idMarca = marcas.idMarca "
IF INT(VAL(getConfig("SQLSRV"))) = 1 THEN
	lcSql = lcSql + "WHERE CONVERT(CHAR(8), stk_cab.fecAlta, 112) BETWEEN " + loDT.toMySql(tdFecDD) + " AND " + loDT.toMySql(tdFecHH) + " "
ELSE
	lcSql = lcSql + "WHERE CAST(stk_cab.fecAlta AS DATE) BETWEEN " + loDT.toMySql(tdFecDD) + " AND " + loDT.toMySql(tdFecHH) + " "
ENDIF

IF tnIdProvDD <> 0 .AND. tnIdProvHH <> 0 THEN
	lcSql = lcSql + "	AND articulos.idProv BETWEEN " + ALLTRIM(STR(tnIdProvDD)) + " AND " + ALLTRIM(STR(tnIdProvHH)) + " "
ENDIF

IF tnIdFamiliaDD <> 0 .AND. tnIdFamiliaHH <> 0 THEN
	lcSql = lcSql + "	AND articulos.idFamilia BETWEEN " + ALLTRIM(STR(tnIdFamiliaDD)) + " AND " + ALLTRIM(STR(tnIdFamiliaHH)) + " "
ENDIF

IF tnIdSubFamDD <> 0 .AND. tnIdSubFamHH <> 0 THEN
	lcSql = lcSql + "	AND articulos.idSubFam BETWEEN " + ALLTRIM(STR(tnIdSubFamDD)) + " AND " + ALLTRIM(STR(tnIdSubFamHH)) + " "
ENDIF

IF tnIdStkDepDD <> 0 .AND. tnIdStkDepHH <> 0 THEN
	lcSql = lcSql + "	AND stk_deps.idStkDep BETWEEN " + ALLTRIM(STR(tnIdStkDepDD)) + " AND " + ALLTRIM(STR(tnIdStkDepHH))
ENDIF

IF tnIdMarcaDD <> 0 .AND. tnIdMarcaHH <> 0 THEN
	lcSql = lcSql + "	AND marcas.idMarca BETWEEN " + ALLTRIM(STR(tnIdMarcaDD)) + " AND " + ALLTRIM(STR(tnIdMarcaHH)) + " "
ENDIF

IF tnIdArticuloDD <> 0 .AND. tnIdArticuloHH <> 0 THEN
	lcSql = lcSql + "	AND articulos.idArticulo BETWEEN " + ALLTRIM(STR(tnIdArticuloDD)) + " AND " + ALLTRIM(STR(tnIdArticuloHH)) + " "
ENDIF

lcSql = lcSql + "GROUP BY articulos.idArticulo "
lcSql = lcSql + "ORDER BY idprov, "
lcSql = lcSql + " 		idMarca, "
lcSql = lcSql + " 		codArt "

loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_MovStock"
IF !loResult.OpenQuery(lcSql) THEN
	This.ErrorMessage = loResult.Error_Message
	RETURN .F.
ENDIF

SELECT cur_MovStock
IF RECCOUNT("cur_MovStock") > 0 THEN
	GO TOP
ELSE
	This.ErrorMessage = "No hay datos para mostrar"
	RETURN .F.
ENDIF

RETURN .T.
ENDPROC
PROCEDURE get_exist_byart
PARAMETERS lnIdArticulo, tcNroPart

LOCAL loResult, lcSql, lnReturn

loResult = CREATEOBJECT("odbc_result")
lcSql = ""

*IF ALLTRIM(tcNroPart) == "" THEN
	lcSql = "SELECT SUM(stk_det.cantidad) AS existencia FROM stk_det WHERE idArticulo = " + ALLTRIM(STR(lnIdArticulo))
*ELSE
*	lcSql = "SELECT SUM(stk_det.cantidad) AS existencia FROM stk_det WHERE idArticulo = " + ALLTRIM(STR(lnIdArticulo)) + " " + ;
*		"AND nroPart = '" + ALLTRIM(tcNroPart) + "'"
*ENDIF

loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_exist"

IF !loResult.OpenQuery(lcSql) THEN
	This.ErrorMessage = loResult.Error_Message
	RETURN 0
ENDIF

SELECT cur_exist
IF ISNULL(cur_exist.existencia) THEN
	lnReturn = 0
ELSE
	lnReturn = cur_exist.existencia
ENDIF

RETURN lnReturn
ENDPROC
PROCEDURE get_exit_byartpart
PARAMETERS lnIdArticulo, tcNroPart

LOCAL loResult, lcSql, lnReturn

loResult = CREATEOBJECT("odbc_result")
lcSql = ""

IF ALLTRIM(tcNroPart) == "" THEN
	lcSql = "SELECT SUM(stk_det.cantidad) AS existencia FROM stk_det WHERE idArticulo = " + ALLTRIM(STR(lnIdArticulo))
ELSE
	lcSql = "SELECT SUM(stk_det.cantidad) AS existencia FROM stk_det WHERE idArticulo = " + ALLTRIM(STR(lnIdArticulo)) + " " + ;
		"AND nroPart = '" + ALLTRIM(tcNroPart) + "'"
ENDIF

loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_exist"

IF !loResult.OpenQuery(lcSql) THEN
	This.ErrorMessage = loResult.Error_Message
	RETURN 0
ENDIF

SELECT cur_exist
IF ISNULL(cur_exist.existencia) THEN
	lnReturn = 0
ELSE
	lnReturn = cur_exist.existencia
ENDIF

loResult.close_query()

RETURN lnReturn
ENDPROC
PROCEDURE grabar3
LOCAL lcSql, loCommand, loDT
LOCAL lnCont, loProg, loConDMO

loConDMO = CREATEOBJECT("odbc_connect")
lcSql = ""
loCommand = CREATEOBJECT("odbc_command")
loDT = CREATEOBJECT("datetime")
loProg = CREATEOBJECT("_thermometer")
lnCont = 0

loConDMO.ConnectionString = ALLTRIM(getConfig("ODBC_C1")) && Establezco la conexión con la base de cuena 1

IF !loConDMO.open() THEN
	This.ErrorMessage = "Error al intentar establecer la conexión con la base alternativa."
	RETURN .F.
ENDIF

loConDMO.BeginTransaction()

This.idStkCab = loConDMO.GetNextID("stk_cab", "idStkCab")
* this.numcbte = REPLICATE("0", 8 - LEN(ALLTRIM(STR(this.idStkcab)))) + ALLTRIM(STR(this.idStkCab))

lcSql = "INSERT INTO stk_cab ( "
lcSql = lcSql + "	idStkCab, "

IF This.idCliente <> 0 THEN
	lcSql = lcSql + " idCliente,"
ENDIF

IF This.idProv <> 0 THEN
	lcSql = lcSql + " idProv, "
ENDIF

lcSql = lcSql + "	circuito, "
lcSql = lcSql + "	cbte, "
lcSql = lcSql + "	tipoDoc, "
lcSql = lcSql + "	numCbte, "
lcSql = lcSql + "	usuAlta, "
lcSql = lcSql + "	fecAlta, "
lcSql = lcSql + "	idHostAlta) "
lcSql = lcSql + "VALUES ( "
lcSql = lcSql + ALLTRIM(STR(This.idStkCab)) + ", "

IF This.idCliente <> 0 THEN
	lcSql = lcSql + ALLTRIM(STR(This.idCliente)) + ", "
ENDIF

IF This.idProv <> 0 THEN
	lcSql = lcSql + ALLTRIM(STR(This.idprov)) + ", "
ENDIF

lcSql = lcSql + "'" + ALLTRIM(This.circuito) + "', "
lcSql = lcSql + "'" + ALLTRIM(This.Cbte) + "', "
lcSql = lcSql + "'" + ALLTRIM(This.TipoDoc) + "', "
lcSql = lcSql + "'" + ALLTRIM(This.numCbte) + "', "
lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
lcSql = lcSql + loDT.GetDateTime() + ", "
lcSql = lcSql + "'" + ALLTRIM(This.idHost) + "')"

loCommand.ActiveConnection = loConDMO.ActiveConnection
loCommand.CommandText = lcSql

IF !loCommand.Execute() THEN
	loConDMO.Rollback()
	lOConDMO.Close()
	This.ErrorMessage = loCommand.ErrorMessage
	RETURN .F.
ENDIF

loProg.Show()

SELECT cur_stkdet
IF RECCOUNT("cur_stkdet") > 0 THEN
	GO TOP
ENDIF

lnCont = 1
DO WHILE !EOF("cur_stkdet")
	lcSql = "INSERT INTO stk_det ( "
	lcSql = lcSql + "idStkDet, "
	lcSql = lcSql + "idStkCab, "
	lcSql = lcSql + "idArticulo, "
	lcSql = lcSql + "idStkDep, "
	lcSql = lcSql + "tipoMov, "
	lcSql = lcSql + "costoRep, "
	lcSql = lcSql + "cantidad, "
	lcSql = lcSql + "nroPart) "
	lcSql = lcSql + "VALUES ( "
	lcsql = lcSql + ALLTRIM(STR(lnCont)) + ", "
	lcSql = lcSql + ALLTRIM(STR(This.idStkCab)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_stkdet.idArticulo)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_stkdet.idStkDep)) + ", "
	lcSql = lcSql + "'" + ALLTRIM(cur_stkdet.tipoMov) + "', "		
	lcSql = lcSql + "'" + ALLTRIM(STR(cur_stkdet.costoRep, 10, 2)) + "', "
	lcSql = lcSql + ALLTRIM(STR(cur_stkdet.cantidad)) + ", "
	lcSql = lcSql + "'" + ALLTRIM(cur_stkdet.nroPart) + "')"
	
	loCommand.ActiveConnection = loConDMO.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute() THEN
		loConDMO.Rollback()
		lOConDMO.Close()
		This.ErrorMessage = loCommand.ErrorMessage
		RETURN .F.
	ENDIF
	
	&& Si el número de partida no está vacío, entonces,
	&& genero el registro en stk_part
	
	IF !(ALLTRIM(cur_stkdet.nroPart) == "") THEN		
		lnProxIDPart = loConDMO.GetNextID("stk_part", "idStkPart")
		
		lcSql = "INSERT INTO stk_part ( "
		lcSql = lcSql + "	idStkPart, "
		lcSql = lcSql + "	idStkCab, "
		lcSql = lcSql + "	idArticulo, "
		lcSql = lcSql + "	codArt, "
		lcSql = lcSql + "	nroPart, "
		lcSql = lcSql + "	cantidad, "
		lcSql = lcSql + "	fecha) "
		lcSql = lcSql + "VALUES ( "
		lcSql = lcSql + ALLTRIM(STR(lnProxIDPart)) + ", "
		lcSql = lcSql + ALLTRIM(STR(this.idStkCab)) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_stkdet.idArticulo)) + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_stkdet.codArt) + "', "
		lcSql = lcSql + "'" + ALLTRIM(cur_stkdet.nroPart) + "', "
		lcSql = lcSql + ALLTRIM(STR(cur_stkdet.cantidad)) + ", "
		lcSql = lcSql + loDT.getDateTime()
		lcSql = lcSql + ")"
		
		loCommand.ActiveConnection = loConDMO.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			loConDMO.Rollback()
			This.ErrorMessage = loCommand.ErrorMessage
			RETURN .F.
		ENDIF
	ENDIF	
	
	lnCont = lnCont + 1
	loProg.update((lnCont * 100) / RECCOUNT("cur_stkdet"), "Grabando Movimientos...")
	SELECT cur_stkdet
	SKIP
ENDDO

loConDMO.commit()
lOConDMO.Close()
loProg.Complete()


RETURN .T.


ENDPROC
PROCEDURE dar_baja_byvta
LOCAL loCommand
LOCAL lcSql
 
loCommand = CREATEOBJECT("odbc_command")
loDT = CREATEOBJECT("datetime")
lcSql = ""
 
lcSql = "UPDATE stk_cab "
lcSql = lcSql + "SET stk_cab.usuBaja = '" + ALLTRIM(gcCodUsu) + "', "
lcSql = lcSql + " stk_cab.fecBaja = " + loDT.getdatetime() + ", "
lcSql = lcSql + " stk_cab.idHostBaja = '" + ALLTRIM(SYS(0)) + "' "
lcSql = lcSql + "WHERE stk_cab.idVentasC = " + ALLTRIM(STR(This.idVentasC))
 
loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = lcSql
 
IF !loCommand.Execute() THEN
      This.ErrorMessage = loCommand.ErrorMessage
      RETURN .F.
ENDIF
 
RETURN .T.
ENDPROC
PROCEDURE asignar_dep
LOCAL lcSql, loCommand, loDT
LOCAL lnCont, loProg, loAsigDep

lcSql = ""
loCommand = CREATEOBJECT("odbc_command")
loDT = CREATEOBJECT("datetime")
loProg = CREATEOBJECT("_thermometer")
loAsigDep = CREATEOBJECT("cl_asig_artdep")
lnCont = 0

loAsigDep.crear_cursor()
loAsigDep.idStkDep = 1

SELECT cur_artSD
GO TOP 

IF RECCOUNT() = 0 THEN
	RETURN
ENDIF

DO WHILE !EOF()
	SELECT cur_Articulos
	APPEND BLANK
	
	REPLACE sel WITH .T.
	REPLACE cur_Articulos.idArticulo WITH cur_artSD.idArticulo ADDITIVE
	REPLACE cur_Articulos.codArt WITH cur_artSD.codArt ADDITIVE
	REPLACE cur_Articulos.descripcio WITH cur_artSD.descripcio ADDITIVE
	
	SELECT cur_artSD
	SKIP 
ENDDO 

IF !loAsigDep.asignar() THEN
	MESSAGEBOX(loAsigDep.ErrorMessage, 0+48, THisform.Caption)
	RETURN .F.
ENDIF

loAsigDep.limpiar()

RETURN .T.

ENDPROC
PROCEDURE Init
This.codUsu = ALLTRIM(gcCodUsu)
This.idHost = ALLTRIM(SYS(0))
This.idStkCab = 0
This.cbte = ""
This.tipoDoc = ""
This.numCbte = ""


ENDPROC
PROCEDURE limpiar_cursor
SELECT cur_stkdet
ZAP

ENDPROC


************************************************************
OBJETO: cl_bitacora
************************************************************
*** PROPIEDADES ***
Name = "cl_bitacora"

*** METODOS ***
PROCEDURE registrar_bitacora
PARAMETERS 		 ;
	tcCodigo	,;
	tcUsuario	,;
	tcHostName	,;
	tcAsunto	,;
	tcMensaje1	,;
	tcMensaje2	,;
	tcProgram	,;
	tnLineErr

LOCAL loCmd
LOCAL lcSql
LOCAL lnHora

loCmd = CREATEOBJECT("odbc_command")
lcSql = ""
lnHora = INT(VAL(STR(HOUR(DATETIME())) + STR(MINUTE(DATETIME())))) 

lcSql = "INSERT INTO bitacora ( "
lcSql = lcSql + "	codigo, "
lcSql = lcSql + "	fecha, "
lcSql = lcSql + "	hora, "
lcSql = lcSql + "	usuario, "
lcSql = lcSql + "	hostName, "
lcSql = lcSql + "	asunto, "
lcSql = lcSql + "	mensaje1, "
lcSql = lcSql + "	mensaje2, "
lcSql = lcSql + "	program, "
lcSql = lcSql + "	lineErr) "
lcSql = lcSql + "VALUES ( "
lcSql = lcSql + "'" + ALLTRIM(tcCodigo) + "', "
lcSql = lcSql + "current_timestamp, "
lcSql = lcSql + ALLTRIM(STR(lnHora)) + ", "
lcSql = lcSql + "'" + gcUsuario + "', "
lcSql = lcSql + "'" + SYS(0) + "', "
lcSql = lcSql + "'" + ALLTRIM(tcAsunto) + "', "
lcSql = lcSql + "'" + ALLTRIM(tcMensaje1) + "', "
lcSql = lcSql + "'" + ALLTRIM(tcMensaje2) + "', "
lcSql = lcSql + "'" + ALLTRIM(tcProgram) + "', "
lcSql = lcSql + "'" + ALLTRIM(STR(tnLineErr)) + ")"

goConn.BeginTransaction()
loCmd.ActiveConnection = goConn.ActiveConnection
loCmd.CommandText = lcSql
IF !loCmd.Execute() THEN
	goConn.Rollback()
	MESSAGEBOX(loCmd.ErrorMessage, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

goConn.Commit()
RETURN .T.
ENDPROC


************************************************************
OBJETO: datobject
************************************************************
*** PROPIEDADES ***
ctablename = 
cpkfieldname = 
nombre_cursor = 
propertycount = 
error_message = 
Name = "datobject"

*** METODOS ***
PROCEDURE getall
LOCAL i, cField
LOCAL cFldDefOrd

cField = ""
cFldDefOrd = ""

rs = CREATEOBJECT("odbc_Result")

IF ALLTRIM(this.nombre_cursor) == ""
	rs.Cursor_Name = "cur_Tempo"
ELSE
	rs.Cursor_Name = ALLTRIM(this.nombre_cursor)
ENDIF

rs.ActiveConnection = goConn.ActiveConnection
rs.OpenQuery("SELECT * FROM " + This.CTableName + " WHERE (fecBaja IS NULL)") 

&& Creo los índices para el cursor
SELECT (rs.Cursor_Name)
FOR i = 1 TO FCOUNT()
	cField = ALLTRIM(FIELD(i, rs.Cursor_Name))
	cField = SUBSTR(cField, 1, 10)
	
	IF i = 1
		IF TYPE(cField) != "M" .AND. TYPE(cField) != "G"
			INDEX ON &cField TAG &cField ASCENDING
			cFldDefOrd = cField
		ENDIF
	ELSE
		IF TYPE(cField) != "M" .AND. TYPE(cField) != "G"
			INDEX ON &cField TAG &cField ASCENDING ADDITIVE
		ENDIF
	ENDIF
NEXT i

SET ORDER TO &cFldDefOrd ASCENDING

&& Me posiciono sobre el primer registro
IF RECCOUNT() > 0
	GO TOP
ENDIF

ENDPROC
PROCEDURE insert
PARAMETERS lAutoTransaction

LOCAL 	cSql, cProxID, lResult, cRef, i, cFieldList, cValueList, cValue,;
		cField, oComando, cProperty, oDateTime

cSql = ""
cProxID = 0
lResult = .F.
cRef = ""
i = 0
cFieldList = ""
cValueList = ""
cField = ""
cProperty = ""
oDateTime = CREATEOBJECT("DateTime")


oComando = CREATEOBJECT("odbc_Command")
oComando.ActiveConnection = goConn.ActiveConnection

IF lAutoTransaction
	IF !goConn.BeginTransaction()
		RETURN .F.
	ENDIF
ENDIF

cProperty = "This." + ALLTRIM(This.cpkfieldname)
&cProperty = goConn.GetNextID(This.cTableName, This.cPkFieldName)

FOR i = 1 TO FCOUNT(this.nombre_cursor)
	cRef = "This." + ALLTRIM(FIELD(i, this.nombre_cursor))

	IF i = 1
		cValue = ALLTRIM(STR(&cProperty))
	ELSE
		DO CASE
			CASE UPPER(TYPE(cRef)) $ [C]
				IF LOWER(FIELD(i, this.nombre_cursor)) == "idhostalta" .OR. LOWER(FIELD(i, this.nombre_cursor)) == "idred"
					cValue = "'" + ALLTRIM(SYS(0)) + "'"
				ELSE
					&& Verifico si el campo tiene que ver con el codigo de usuario
					IF (LOWER(FIELD(i, this.nombre_cursor)) == "usualta") THEN
						cValue = "'" + ALLTRIM(gcCodUsu) + "'"
					ELSE
						cValue = "'" + ALLTRIM(&cRef) + "'"
					ENDIF
				ENDIF
				
			CASE UPPER(TYPE(cRef)) $ [U]
				cValue = "'" + ALLTRIM(STR(&cRef)) + "'"
			CASE UPPER(TYPE(cRef)) $ [D]
				IF LOWER(FIELD(i, this.nombre_cursor)) == "fecalta"
					cValue = "'" + oDateTime.toMySql(DATE()) + "'"
				ELSE
					cValue = "'" + oDateTime.ToMySql(&cRef) + "'"
				ENDIF
			CASE UPPER(TYPE(cRef)) $ [N,F,I]
				cValue = ALLTRIM(STR(&cRef, 10, 2))
			CASE UPPER(TYPE(cRef)) $ [L]
				IF &cRef
					cValue = "1"
				ELSE
					cValue = "0"
				ENDIF
		ENDCASE
		
		
		IF (LOWER(FIELD(i, this.nombre_cursor)) == "fecalta") THEN		
			cValue = IIF(INT(VAL(getConfig("SQLSRV"))) = 0, "current_timestamp", "GetDate()")
		ENDIF
	ENDIF
 
	IF i < FCOUNT(this.nombre_cursor)
		IF (LOWER(FIELD(i, this.nombre_cursor)) <> "fecmodi") .AND. (LOWER(FIELD(i, this.nombre_cursor)) <> "fecbaja") .AND. ;
		 (LOWER(FIELD(i, this.nombre_cursor)) <> "idhostmodi") .AND. (LOWER(FIELD(i, this.nombre_cursor)) <> "idhostbaja") .AND. ;
		 (LOWER(FIELD(i, this.nombre_cursor)) <> "usumodi") .AND. (LOWER(FIELD(i, this.nombre_cursor)) <> "usubaja") THEN
		 
			cFieldList = cFieldList + ALLTRIM(FIELD(i, "cur_Tempo")) + ", "	
			cValueList = cValueList + cValue + ", "
			
		ENDIF
	ELSE
		cFieldList = cFieldList + ALLTRIM(FIELD(i, "cur_Tempo")) + " "
		cValueList = cValueList + cValue + " "
	ENDIF
NEXT i

cSql = "INSERT INTO " + this.ctablename + "(" + cFieldList + ") VALUES (" + cValueList + ")"

oComando.CommandText = cSql
lResult = oComando.Execute()

IF !lResult
	IF lAutoTransaction
		goConn.RollBack()
	ENDIF
	
	this.error_message = oComando.errorMessage
	
	RETURN .F.
ENDIF

IF lAutoTransaction
	goConn.Commit()
ENDIF

RETURN .T.
ENDPROC
PROCEDURE update
PARAMETERS lAutoTransaction

LOCAL cField, cValue, cParameters, cWhere, i, oStr, numComas, cRef, cCpo, cFieldList,;
	oComando, oDateTime

cFieldList = ""
cField = ""
cValue = ""
cParameters = ""
cWhere = ""
i = 0
cRef = ""
oStr = CREATEOBJECT("Strings")
oDateTime = CREATEOBJECT("DateTime")

&& Verificar si hay mas de una clave primaria

numComas = oStr.GetCharCount(",", This.cPkFieldName)

IF numComas > 0
	FOR i = 1 TO GETWORDCOUNT(This.cPkFieldName, ",")
		cRef = "This." + ALLTRIM(This.cPkFieldName)
		IF i < 1
			cWhere = cWhere + " " + GETWORDNUM(This.cPkFieldName, ",") + " = " + ALLTRIM(STR(&cRef)) + " AND "
		ELSE
			cWhere = cWhere + " " + GETWORDNUM(This.cPkFieldName, ",") + " = " + ALLTRIM(STR(&cRef))
		ENDIF
	NEXT
ELSE
	cRef = "This." + ALLTRIM(This.cPkFieldName)
	IF TYPE(cRef) $ "NIF"
		cWhere = This.cPkFieldName + " = " + ALLTRIM(STR(&cRef))
	ELSE
		cWhere = This.cPkFieldName + " = '" + ALLTRIM(&cRef) + "'"
	ENDIF
ENDIF

SELECT cur_Tempo
FOR i = 2 TO FCOUNT("cur_Tempo")
	cRef = "This." + ALLTRIM(FIELD(i, "cur_Tempo")) 
	cCpo = ALLTRIM(FIELD(i, "cur_Tempo"))
	DO CASE
		CASE TYPE(cRef) $ [C]
			IF LOWER(cCpo) == "idhostmodi" .OR. LOWER(cCpo) == "idred"
				cFieldList = cFieldList + " " + cCpo + " = '" + ALLTRIM(SYS(0)) + "',"
			ELSE
				IF LOWER(cCpo) == "usumodi" THEN
					cFieldList = cFieldList + " " + cCpo + " = '" + ALLTRIM(gcCodUsu) + "',"
				ELSE
					IF (LOWER(cCpo) != "usualta") .and. (LOWER(cCpo) != "idhostbaja") .and. (LOWER(cCpo) != "idhostalta") .and. (LOWER(cCpo) != "usubaja") THEN
						cFieldList = cFieldList + " " + cCpo + " = '" + ALLTRIM(&cRef) + "',"
					ENDIF
				ENDIF
			ENDIF
		CASE TYPE(cRef) $ [D]
			IF LOWER(cCpo) == "fecmodi"
				cFieldList = cFieldList + " " + cCpo + " = " + oDateTime.toMySql(DATE()) + ","
			ELSE
				IF LOWER(cCpo) != "fecalta" .and. LOWER(cCpo) != "fecBaja" THEN
					cFieldList = cFieldList + " " + cCpo + " = " + oDateTime.toMySql(&cRef) + ","
				ENDIF
			ENDIF
		CASE TYPE(cRef) $ [N,I,F]
			cFieldList = cFieldList + " " + cCpo + " = " + ALLTRIM(STR(&cRef, 10, 2)) + ","
	ENDCASE
NEXT i

cFieldList = cFieldList + "fecModi = " + IIF(INT(VAL(getConfig("SQLSRV"))) = 0, "current_date,", "getDate(),")
cFieldList = SUBSTR(cFieldList, 1, LEN(cFieldList) - 1)

cSql = "UPDATE " + this.cTableName + " "
cSql = cSql + " SET " + cFieldList + " "
cSql = cSql + " WHERE " + cWhere

IF lAutoTransaction
	IF !goConn.BeginTransaction()
		RETURN .F.
	ENDIF
ENDIF

oComando = CREATEOBJECT("odbc_Command")
oComando.ActiveConnection = goConn.ActiveConnection
oComando.CommandText = cSql

IF !oComando.Execute()
	IF lAutoTransaction
		goConn.RollBack()
	ENDIF
	
	this.error_message = oComando.errorMessage
	
	RETURN .F.
ENDIF

IF lAutoTransaction
	goConn.Commit()
ENDIF

RETURN .T.

ENDPROC
PROCEDURE initializate
&& Cuando se inicia el formulario tengo que crear las propiedades
&& de la entidad

LOCAL i, cField, cSql, cRef

i = 0
cField = ""
cSql = ""
this.propertycount = 0
cRef = ""

IF this.nombre_cursor == ""
	this.nombre_cursor = "cur_Tempo"
ENDIF

rs = CREATEOBJECT("odbc_Result")
rs.Cursor_Name = "cur_x"
rs.ActiveConnection = goConn.ActiveConnection

cSql = "SELECT * FROM " + This.cTableName + " WHERE 1 = 2"
rs.OpenQuery(cSql)

SELECT cur_x
FOR i = 1 TO FCOUNT()
	cField = ALLTRIM(FIELD(i, "cur_x"))
	ADDPROPERTY(This, cField)
	cRef = rs.Cursor_Name + "." + cField
	
	DO CASE
		CASE TYPE(cRef) == "C"
			cRef = "This." + cField
			&cRef = ""
		CASE TYPE(cRef) == "D"
			cRef = "This." + cField
			&cRef = {}
		CASE TYPE(cRef) $ "I"
			cRef = "This." + cField
			&cRef = 0
		CASE TYPE(cRef) $ "NF"
			cRef = "This." + cField
			&cRef = 0.00
		CASE TYPE(cRef) == "L"
			cRef = "This." + cField
			&cRef = .F.
	ENDCASE
	
	this.propertycount = this.propertycount + 1
NEXT i

USE IN cur_x
ENDPROC
PROCEDURE getbyanything
PARAMETERS cpoFilter, cpoValue

LOCAL i, cField, cSqlCommand

cField = ""
cSqlCommand = ""

rs = CREATEOBJECT("odbc_Result")

&& El problema que esta viniendo con el valor cur_Tempo
IF ALLTRIM(this.nombre_cursor) == ""
	rs.Cursor_Name = "__curAux"
ELSE
	rs.Cursor_Name = ALLTRIM(this.nombre_cursor)
ENDIF

rs.ActiveConnection = goConn.ActiveConnection

IF TYPE("cpoValue") $ "NIF"
	cSqlCommand = "SELECT * FROM " + This.CTableName + " WHERE " + cpoFilter  + " = " + ALLTRIM(STR(cpoValue)) + " "
ENDIF

IF TYPE("cpoValue") $ "C"
	cSqlCommand = "SELECT * FROM " + This.CTableName + " WHERE " + cpoFilter + " = '" + ALLTRIM(cpoValue) + "' "
ENDIF

IF !rs.OpenQuery(cSqlCommand) THEN
	This.error_message = "Error en datObject::getByAnything() al intentar ejecutar el comando: " + ALLTRIM(cSqlCommand)
	RETURN .F.
ENDIF

SELECT (rs.Cursor_Name)

RETURN .T.

ENDPROC
PROCEDURE create_cursor
LOCAL i, cField

cField = ""

rs = CREATEOBJECT("odbc_Result")

IF ALLTRIM(this.nombre_cursor) == ""
	rs.Cursor_Name = "cur_Tempo"
ELSE
	rs.Cursor_Name = ALLTRIM(this.nombre_cursor)
ENDIF

rs.ActiveConnection = goConn.ActiveConnection

rs.OpenQuery("SELECT * FROM " + This.CTableName + " WHERE 1 = 2")

&& Creo los índices para el cursor

SELECT (rs.Cursor_Name)
FOR i = 1 TO FCOUNT()
	cField = ALLTRIM(FIELD(i, rs.Cursor_Name))
	cField = SUBSTR(cField, 1, 10)
	
	IF i = 1
		IF TYPE(cField) != "M" .AND. TYPE(cField) != "G"
			INDEX ON &cField TAG &cField ASCENDING
		ENDIF
	ELSE
		IF TYPE(cField) != "M" .AND. TYPE(cField) != "G"
			INDEX ON &cField TAG &cField ASCENDING ADDITIVE
		ENDIF
	ENDIF
NEXT i

&& Me posiciono sobre el primer registro
IF RECCOUNT() > 0
	GO TOP
ENDIF
ENDPROC
PROCEDURE delete
LOCAL oStr
LOCAL lnComas
LOCAL cWhere
LOCAL lcSql
LOCAL oComando

oStr = CREATEOBJECT("Strings")
lnComas = oStr.GetCharCount(",", This.cpkfieldname)

IF lnComas > 0
	FOR i = 1 TO GETWORDCOUNT(This.cpkfieldname, ",")
		cRef = "This." + ALLTRIM(This.cpkfieldname)
		IF i  < 1
			cWhere = cWhere + " " + GETWORDNUM(This.cpkfieldname, ",") + " = " + ALLTRIM(STR(&cRef)) + " AND "
		ELSE
			cWhere = cWhere + " " + GETWORDNUM(This.cpkfieldname, ",") + " = " + ALLTRIM(STR(&cRef)) + " AND "
		ENDIF
	ENDFOR
ELSE
	cRef = "This." + ALLTRIM(This.cpkfieldname)
	IF TYPE(cRef) $ "NIF"
		cWhere = This.cpkfieldname + " = " + ALLTRIM(STR(&cRef))
	ELSE
		cWhere = This.cpkfieldname + " = '" + ALLTRIM(STR(&cRef)) + "'"
	ENDIF
ENDIF

&& El DELETE es la sentencia que estaba antes
&& lcSql = "DELETE FROM " + this.ctablename + " WHERE " + cWhere

&& A partir de ahora antes de eliminar, completa los campos de baja
lcSql = "UPDATE " + ALLTRIM(this.ctablename) + " "
lcSql = lcSql + "SET 	usuBaja = '" + ALLTRIM(gcCodUsu) + "', "
lcSql = lcSql + "		fecBaja = " + IIF(INT(VAL(getConfig("SQLSRV"))) = 0, "current_date, ", "getDate(), ")
lcSql = lcSql + "		idHostBaja = '" + ALLTRIM(SYS(0)) + "' "
lcSql = lcSql + "WHERE " + cWhere

oComando = CREATEOBJECT("odbc_Command")
oComando.ActiveConnection = goConn.ActiveConnection
oComando.CommandText = lcSql

IF !oComando.Execute()
	This.error_message = oComando.errorMessage
	RETURN .F.
ENDIF

RETURN .T.

ENDPROC
PROCEDURE getbyany
PARAMETERS tcWhere

LOCAL i, cField

cField = ""

rs = CREATEOBJECT("odbc_Result")

IF ALLTRIM(this.nombre_cursor) == ""
	rs.Cursor_Name = "cur_Tempo"
ELSE
	rs.Cursor_Name = ALLTRIM(this.nombre_cursor)
ENDIF

rs.ActiveConnection = goConn.ActiveConnection
rs.OpenQuery("SELECT * FROM " + This.CTableName + " WHERE (fecBaja IS NULL) OR (fecBaja = '') " + ALLTRIM(tcWhere))

&& Creo los índices para el cursor
SELECT (rs.Cursor_Name)
FOR i = 1 TO FCOUNT()
	cField = ALLTRIM(FIELD(i, rs.Cursor_Name))
	cField = SUBSTR(cField, 1, 10)
	
	IF i = 1
		IF TYPE(cField) != "M" .AND. TYPE(cField) != "G"
			INDEX ON &cField TAG &cField ASCENDING
		ENDIF
	ELSE
		IF TYPE(cField) != "M" .AND. TYPE(cField) != "G"
			INDEX ON &cField TAG &cField ASCENDING ADDITIVE
		ENDIF
	ENDIF
NEXT i

&& Me posiciono sobre el primer registro
IF RECCOUNT() > 0
	GO TOP
ENDIF
ENDPROC


************************************************************
OBJETO: cl_recibos
************************************************************
*** PROPIEDADES ***
ptovta = 
nrocbte = 
idcliente = 0
imp_efec = 0
imp_td = 0
imp_tc = 0
imp_ib = 0
imp_iva = 0
imp_suss = 0
imp_gan = 0
idprovin_ib = 0
fec_ib = {}
fec_iva = {}
fec_gan = {}
fec_suss = {}
num_ib = 0
num_iva = 0
num_suss = 0
num_gan = 0
imp_rc = 0
imp_fc = 0
fec_emis = {}
cbte = 
idmovcjac = 0
tipo = 
grabar_movcaja = .F.
idconccj = 0
Name = "cl_recibos"

*** METODOS ***
PROCEDURE crear_cursor
&& El siguiente cursor contiene las facturas pendientes de saldo
CREATE CURSOR cur_facturas (	;
	selected	l	,;
	idVentasC	int	,;
	idCliente	int ,;
	idCondPago	int ,;
	idSitIVA	int ,;
	idVendedor  int ,;
	razSoc		varchar(60),;
	fecEmis		datetime,;
	cbte		varchar(2),;
	numCbte1	varchar(15),;
	tipoDoc		varchar(1),;
	ptoVta		int,;
	numCbte		int,;
	importe 	double,;
	impapl		double,;
	saldo		double)
	

&& Este cursor contiene el detalle del pago
CREATE CURSOR cur_Detalle (	;
	idDetalle int,;
	idCheque int,;
	idPlanCta int,;
	idBanco int,;
	descripcio varchar(60) ,;
	sucursal varchar(60),;
	chq_nro varchar(8),;
	tipoDoc	varchar(5),;
	nroCuit	varchar(20),;
	titular varchar(60),;
	fecEmis D,;
	fecVto D,;
	importe double,;
	tipoPago varchar(5),;
	idProvin int,;
	retCompro int,;
	retFecha datetime)
	



ENDPROC
PROCEDURE limpiar
SELECT cur_detalle
ZAP

SELECT cur_facturas
ZAP

ENDPROC
PROCEDURE validar_cheques
&& Este metodo valida que no se ingrese un mismo cheque en el 
&& recibo o que ya exista en la base de datos del mismo cliente.
PARAMETERS lnIdCliente, lnIdBanco, lcchq_nro

LOCAL loCheques, lcSql

loCheques = CREATEOBJECT("odbc_result")
lcSql = ""

SELECT cur_detalle
GO TOP

DO WHILE !EOF("cur_detalle")
	IF (cur_detalle.tipoPago == "CHEQ")
		IF (lnIdBanco == cur_detalle.idBanco) .AND. (lcchq_nro == cur_detalle.chq_nro)
			MESSAGEBOX("Este cheque ya fue ingresado en el pago", 0+16, Thisform.Caption)
			RETURN .F.
		ENDIF 
	ENDIF 

	SELECT cur_detalle
	SKIP
ENDDO

lcSql = "SELECT * "
lcSql = lcSql + " FROM cheques "
lcSql = lcSql + " WHERE idBanco = " + ALLTRIM(STR(lnIdBanco)) + " "
lcSql = lcSql + " 	AND chq_nro = " + lcchq_nro + " "
IF lnIdCliente = 0 THEN 
	lcSql = lcSql + " 	AND idCliente IS NULL "
ELSE 
	lcSql = lcSql + " 	AND idCliente = " + ALLTRIM(STR(lnIdCliente))
ENDIF 

loCheques.ActiveConnection = goConn.ActiveConnection
loCheques.cursor_name = "cur_cheques"

IF !loCheques.OpenQuery(lcSql)
	MESSAGEBOX(loCheques.error_message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF 

SELECT cur_cheques
IF RECCOUNT("cur_cheques") > 0 THEN 
	MESSAGEBOX("Este cheque ya fue ingresado en la base de datos", 0+16, Thisform.Caption)
	RETURN .F.
ENDIF 

loCheques.close_query()

RETURN .T.

ENDPROC
PROCEDURE validar_numero
PARAMETERS lc_ptovta, lc_nrorec

LOCAL loResult, lcSql, lcNroRec

lcNroRec = lc_ptovta + "-" + lc_nrorec

&& Valido que el recibo no exista
loResult = CREATEOBJECT("odbc_result")
loResult.Cursor_Name = "cur_X"

lcSql = "SELECT idrccob_c FROM rccob_c "
lcSql = lcSql + "WHERE nroRec = '" + ALLTRIM(lcNroRec) + "'"

loResult.ActiveConnection = goConn.ActiveConnection
loResult.OpenQuery(lcSql)

SELECT cur_X
IF RECCOUNT("cur_X") > 0 THEN
	loResult.Close_Query()
	MESSAGEBOX("El número de recibo " + lcNroRec + " ya existe", 0+16, Thisform.Caption)
	RETURN .F.
ENDIF

loResult.Close_Query()

RETURN .T.
ENDPROC
PROCEDURE grabar
LOCAL lnIdCliente, lcNroRec, ldFecEmis, lnImporte
LOCAL lnProxID_Det, lnIdCheque, lnIdPlanCta, lnIdBanco
LOCAL lcChq_Nro, lnImporte, lcTipoPago
LOCAL lcSucursal, ldFecVtoCheq, ldFecEmisCheq
LOCAL lnIdCC_Cli, lnIdCC_Orig, lnIdVentasC, lcCbte, lcPtoVta
LOCAL lcTipoDoc, lnCUIT, lcTitular
LOCAL lnImpDebe, lnImpHaber, lnIdOper
LOCAL loDT, lnIdRCCob_DV
LOCAL lcSql, lnProxID, loCommand, loResult
LOCAL lnImpDif, lnTotImpFC, lnImpImputar, lnImpGrabar, lnSaldo, lnBandera
LOCAL loNum, lcNumRC, lnResp
LOCAL lnIdProvin, lnRetCbte, ldRetFecha, lnEsNumerador, lcTipo

loCommand = CREATEOBJECT("odbc_Command")
loDT = CREATEOBJECT("datetime")
loResult = CREATEOBJECT("odbc_result")
loNum = CREATEOBJECT("cls_numeradores")

lnIdCliente = this.idcliente
ldFecEmis = this.fec_emis
ldFecAlta = loDT.getDateTime()
lcPtoVta = ALLTRIM(this.ptovta)
lcNumRC = ALLTRIM(this.nrocbte)
lcNroRec = ALLTRIM(this.ptovta) + "-" + ALLTRIM(This.nrocbte)
lcCbte = ALLTRIM(this.cbte)
lcTipo = ""

lnProxID_Det = 0
lnIdCheque = 0
lnIdPlanCta = 0
lnIdBanco = 0
lcTipoDoc = ""
lcChq_Nro = ""
lnImporte = 0.00
lcTipoPago = ""
lnIdRCCob_DV = 0
lnIdCC_Cli = 0
lnIdCC_Orig = 0
lnIdVentasC = 0
lnImpDebe = 0.00
lnImpHaber = 0.00
lnIdOper = 0
lnTotImpFC = this.imp_fc
lnImpImputar = 0.00
lnImpDif = lnTotImpFC - lnImpImputar
lnCUIT = ""
lcTitular = ""
lcSucursal = ""
lnImpGrabar = 0.00

lcSql = ""
lnProxID = 0
lnSaldo = 0.00
lnBandera = 0
lnIdProvin = 0
lnRetCbte = 0
ldRetFecha = {}
lbEsNumerado = .F.


**********************************************************************************
&& Levanto el numerador. Verifico si es RC (y si es automatico), sino es CJA.
**********************************************************************************
IF lcCbte == "RC" THEN
	lcTipo = "X"
	IF getGlobalCFG("NRC_AUTO") THEN
		loNum.cbte = lcCbte 
		loNum.tipoDoc = lcTipo
		
		IF !loNum.getptovta() THEN && Me levanta el ptovta y todos los demas datos del talonario.
			goConn.Rollback()	
			RETURN .F.
		ENDIF 
		
		DO WHILE loNum.esta_bloqueado()
			WAIT WINDOW "Otro usuario está emitiendo un recibo, por favor espere..." NOWAIT
		ENDDO

		loNum.bloquear()
		
		lcNroRec = REPLICATE("0", 4 - LEN(ALLTRIM(STR(loNum.ptoVta)))) +  ALLTRIM(STR(loNum.ptoVta)) + "-"
		lcNroRec = lcNroRec + REPLICATE("0", 8 - LEN(ALLTRIM(STR(loNum.numActual)))) + ALLTRIM(STR(loNum.numActual))
		lcPtoVta = ALLTRIM(STR(loNum.ptovta))
		lcNumRC = ALLTRIM(STR(loNum.numActual))
		lbEsNumerado = .T.
	ENDIF
ELSE 
		lcTipo = ""
		loNum.cbte = lcCbte 
		loNum.tipoDoc = lcTipo 
		
		IF !loNum.getptovta() THEN && Me levanta el ptovta y todos los demas datos del talonario.
			goConn.Rollback()	
			RETURN .F.
		ENDIF 
		
		DO WHILE loNum.esta_bloqueado()
			WAIT WINDOW "Otro usuario está emitiendo un movimiento de caja, por favor espere..." NOWAIT
		ENDDO

		loNum.bloquear()
		
		lcNroRec = REPLICATE("0", 4 - LEN(ALLTRIM(STR(loNum.ptoVta)))) +  ALLTRIM(STR(loNum.ptoVta)) + "-"
		lcNroRec = lcNroRec + REPLICATE("0", 8 - LEN(ALLTRIM(STR(loNum.numActual)))) + ALLTRIM(STR(loNum.numActual))
		lcPtoVta = ALLTRIM(STR(loNum.ptovta))
		lcNumRC = ALLTRIM(STR(loNum.numActual))
		lbEsNumerado = .T.
ENDIF 

************************************************************************
&& Agrego al detalle los pagos
************************************************************************

&& Agrego al detalle el pago en EFECTIVO
IF this.imp_efec <> 0 THEN
	loResult.ActiveConnection = goConn.ActiveConnection
	loResult.Cursor_Name = "cur_PlanCta"
	loResult.OpenQuery("SELECT * FROM planctas WHERE codAbr = 'CJP'")
	
	SELECT cur_PlanCta
	lnIdPlanCta = cur_PlanCta.idPlanCta

	loResult.Close_Query()
	
	IF lnIdPlanCta = 0 THEN
		MESSAGEBOX("Falta cargar la cuenta con código CJP en plan de cuentas", 0+48, Thisform.Caption)
		goConn.Rollback()
		
		IF lbEsNumerado THEN
			loNum.desbloquear()
		ENDIF		
		
		RETURN .F.
	ENDIF
	
	SELECT cur_Detalle
	APPEND BLANK
	
	REPLACE cur_Detalle.idDetalle WITH 0
	REPLACE cur_Detalle.importe WITH this.imp_efec ADDITIVE
	REPLACE cur_Detalle.tipoPago WITH "EFVO" ADDITIVE
	REPLACE cur_Detalle.idPlanCta WITH lnIdPlanCta ADDITIVE

ENDIF


&& Agrego al detalle el pago con TARJETA DE DEBITO
IF This.imp_td <> 0 THEN
	loResult.ActiveConnection = goConn.ActiveConnection
	loResult.Cursor_Name = "cur_PlanCta"
	loResult.OpenQuery("SELECT * FROM planctas WHERE codAbr = 'TARDB'")
	
	SELECT cur_PlanCta
	lnIdPlanCta = cur_PlanCta.idPlanCta
	
	loResult.Close_Query()
	
	IF lnIdPlanCta = 0 THEN
		MESSAGEBOX("Falta cargar la cuenta con código TARDB en plan de cuentas", 0+48, Thisform.Caption)
		goConn.Rollback()
		
		IF lbEsNumerado THEN
			loNum.desbloquear()
		ENDIF		
		
		RETURN .F.
	ENDIF

	SELECT cur_Detalle
	APPEND BLANK
	
	REPLACE cur_Detalle.idDetalle WITH 0
	REPLACE cur_Detalle.importe WITH this.imp_td ADDITIVE
	REPLACE cur_Detalle.tipoPago WITH "TADB" ADDITIVE
	REPLACE cur_Detalle.idPlanCta WITH lnIdPlanCta ADDITIVE
ENDIF


&& Agrego al detalle el pago con TARJETA DE CREDITO
IF This.imp_tc <> 0 THEN
	loResult.ActiveConnection = goConn.ActiveConnection
	loResult.Cursor_Name = "cur_PlanCta"
	loResult.OpenQuery("SELECT * FROM planctas WHERE codAbr = 'TARCR'")
	
	SELECT cur_PlanCta
	lnIdPlanCta = cur_PlanCta.idPlanCta
	
	loResult.Close_Query()
	
	IF lnIdPlanCta = 0 THEN
		MESSAGEBOX("Falta cargar la cuenta con código TARCR en plan de cuentas", 0+48, Thisform.Caption)
		goConn.Rollback()
		
		IF lbEsNumerado THEN
			loNum.desbloquear()
		ENDIF		
		
		RETURN .F.
	ENDIF

	SELECT cur_Detalle
	APPEND BLANK
	
	REPLACE cur_Detalle.idDetalle WITH 0
	REPLACE cur_Detalle.importe WITH this.imp_tc ADDITIVE
	REPLACE cur_Detalle.tipoPago WITH "TACR" ADDITIVE
	REPLACE cur_Detalle.idPlanCta WITH lnIdPlanCta ADDITIVE
ENDIF


&& Agrego al detalle el pago con RETENSION DE IVA
IF This.imp_iva <> 0 THEN
	loResult.ActiveConnection = goConn.ActiveConnection
	loResult.Cursor_Name = "cur_PlanCta"
	loResult.OpenQuery("SELECT * FROM planctas WHERE codAbr = 'RETDIVA'")
	
	SELECT cur_PlanCta
	lnIdPlanCta = cur_PlanCta.idPlanCta
	
	loResult.Close_Query()
	
	IF lnIdPlanCta = 0 THEN
		MESSAGEBOX("Falta cargar la cuenta con código RETDIVA en plan de cuentas", 0+48, Thisform.Caption)
		goConn.Rollback()
		
		IF lbEsNumerado THEN
			loNum.desbloquear()
		ENDIF		
		
		RETURN .F.
	ENDIF

	SELECT cur_Detalle
	APPEND BLANK
	
	REPLACE cur_Detalle.idDetalle WITH 0
	REPLACE cur_Detalle.importe WITH this.imp_iva ADDITIVE
	REPLACE cur_Detalle.tipoPago WITH "RIVA" ADDITIVE
	REPLACE cur_Detalle.idPlanCta WITH lnIdPlanCta ADDITIVE
	REPLACE cur_Detalle.retCompro WITH this.num_iva ADDITIVE
	REPLACE cur_Detalle.retFecha WITH this.fec_iva ADDITIVE
ENDIF


&& Agrego al detalle el pago con RETENSION DE IIBB
IF This.imp_ib <> 0 THEN
	loResult.ActiveConnection = goConn.ActiveConnection
	loResult.Cursor_Name = "cur_PlanCta"
	loResult.OpenQuery("SELECT * FROM planctas WHERE codAbr = 'RETDIB'")
	
	SELECT cur_PlanCta
	lnIdPlanCta = cur_PlanCta.idPlanCta
	
	loResult.Close_Query()
	
	IF lnIdPlanCta = 0 THEN
		MESSAGEBOX("Falta cargar la cuenta con código RETDIB en plan de cuentas", 0+48, Thisform.Caption)
		goConn.Rollback()
		
		IF lbEsNumerado THEN
			loNum.desbloquear()
		ENDIF		
		
		RETURN .F.
	ENDIF

	SELECT cur_Detalle
	APPEND BLANK
	
	REPLACE cur_Detalle.idDetalle WITH 0
	REPLACE cur_Detalle.importe WITH this.imp_ib ADDITIVE
	REPLACE cur_Detalle.tipoPago WITH "RIB" ADDITIVE
	REPLACE cur_Detalle.idPlanCta WITH lnIdPlanCta ADDITIVE
	REPLACE cur_Detalle.idProvin WITH this.idprovin_ib ADDITIVE
	REPLACE cur_Detalle.retCompro WITH this.num_ib ADDITIVE
	REPLACE cur_Detalle.retFecha WITH this.fec_ib ADDITIVE
ENDIF


&& Agrego al detalle el pago con RETENSION DE GANANCIA
IF This.imp_gan <> 0 THEN
	loResult.ActiveConnection = goConn.ActiveConnection
	loResult.Cursor_Name = "cur_PlanCta"
	loResult.OpenQuery("SELECT * FROM planctas WHERE codAbr = 'RETDGAN'")
	
	SELECT cur_PlanCta
	lnIdPlanCta = cur_PlanCta.idPlanCta

	loResult.Close_Query()
	
	IF lnIdPlanCta = 0 THEN
		MESSAGEBOX("Falta cargar la cuenta con código RETDGAN en plan de cuentas", 0+48, Thisform.Caption)
		goConn.Rollback()
		
		IF lbEsNumerado THEN
			loNum.desbloquear()
		ENDIF		
		
		RETURN .F.
	ENDIF

	SELECT cur_Detalle
	APPEND BLANK
	
	REPLACE cur_Detalle.idDetalle WITH 0
	REPLACE cur_Detalle.importe WITH this.imp_gan ADDITIVE
	REPLACE cur_Detalle.tipoPago WITH "RGAN" ADDITIVE
	REPLACE cur_Detalle.idPlanCta WITH lnIdPlanCta ADDITIVE
	REPLACE cur_Detalle.retCompro WITH this.num_gan ADDITIVE
	REPLACE cur_Detalle.retFecha WITH this.fec_gan ADDITIVE
ENDIF


&& Agrego al detalle el pago con RETENSION DE SUSS
IF This.imp_suss <> 0 THEN
	loResult.ActiveConnection = goConn.ActiveConnection
	loResult.Cursor_Name = "cur_PlanCta"
	loResult.OpenQuery("SELECT * FROM planctas WHERE codAbr = 'RETDSUS'")
	
	SELECT cur_PlanCta
	lnIdPlanCta = cur_PlanCta.idPlanCta
	
	loResult.Close_Query()
	
	IF lnIdPlanCta = 0 THEN
		MESSAGEBOX("Falta cargar la cuenta con código RETDSUS en plan de cuentas", 0+48, Thisform.Caption)
		goConn.Rollback()
		
		IF lbEsNumerado THEN
			loNum.desbloquear()
		ENDIF		
		
		RETURN .F.
	ENDIF

	SELECT cur_Detalle
	APPEND BLANK
	
	REPLACE cur_Detalle.idDetalle WITH 0
	REPLACE cur_Detalle.importe WITH this.imp_suss ADDITIVE
	REPLACE cur_Detalle.tipoPago WITH "RSUSS" ADDITIVE
	REPLACE cur_Detalle.idPlanCta WITH lnIdPlanCta ADDITIVE
	REPLACE cur_Detalle.retCompro WITH this.num_suss ADDITIVE
	REPLACE cur_Detalle.retFecha WITH this.fec_suss ADDITIVE
ENDIF


************************************************************************
&& Doy de alta los cheques en la tabla "cheques"
************************************************************************
SELECT cur_detalle
IF RECCOUNT("cur_detalle") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_detalle")
	IF ALLTRIM(cur_detalle.tipoPago) == "CHEQ" THEN
		lnIdCheque = goConn.getNextID("cheques", "idCheque")
		
		&& Actualizo el idCheque en el cursor
		SELECT cur_detalle
		LOCK()
		REPLACE idCheque WITH lnIdCheque ADDITIVE 
		UNLOCK
		
		lcSql = "INSERT INTO cheques (idCheque, idCliente, idBanco, tipo, sucursal, chq_nro, fecEmis, tipoDoc, nroCUIT, titular, fecVto, importe, estado, NroRec) "
		lcSql = lcSql + "VALUES ( " + ALLTRIM(STR(lnIdCheque)) + ", " + IIF(lnIdCliente = 0, "NULL", ALLTRIM(STR(lnIdCliente))) + ", " + ALLTRIM(STR(cur_detalle.idBanco)) + ", "
		lcSql = lcSql + "'T', '" + ALLTRIM(cur_detalle.sucursal) + "', '" + ALLTRIM(cur_detalle.chq_nro) + "', " + loDT.tomysql(cur_detalle.fecEmis) + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_detalle.tipoDoc) + "', '" + ALLTRIM(cur_detalle.nroCuit) + "', '" + ALLTRIM(cur_detalle.titular) + "', "
		lcSql = lcSql + loDT.tomysql(cur_detalle.fecVto) + ", " + ALLTRIM(STR(cur_detalle.importe, 10, 2)) + ", 'D', '" + ALLTRIM(lcNroRec) + "')"
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.execute() THEN
			goConn.Rollback()
			
			IF lbEsNumerado THEN
				loNum.desbloquear()
			ENDIF
			
			MESSAGEBOX(loCommand.errorMessage, 0+48, Thisform.Caption)
			RETURN .F.
		ENDIF		
	ENDIF
		
	SELECT cur_detalle
	SKIP
ENDDO


IF lcCbte = "RC" THEN 
	************************************************************************
	&& Genero la cabecera del recibo
	************************************************************************
	lnProxID = goConn.getNextID("rccob_c", "idRCCob_C")

	lcSql = "INSERT INTO rccob_c (idRCCob_C, idCliente, nroRec, fecEmis, importe, usuAlta, fecAlta, idHostAlta) "
	lcSql = lcSql + "VALUES (" + ALLTRIM(STR(lnProxID)) + ", " + ALLTRIM(STR(lnIdCliente)) + ", "
	lcSql = lcSql + "'" + ALLTRIM(lcNroRec) + "', " + ldFecEmis + ", " + ALLTRIM(STR(This.imp_rc, 10, 2)) + ", "
	lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', " + ldFecAlta + ", '" + SYS(0) + "')"

	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql

	IF !loCommand.execute() THEN
		goConn.Rollback()
		
		IF lbEsNumerado THEN
			loNum.desbloquear()
		ENDIF
		
		MESSAGEBOX(loCommand.errorMessage, 0+48, Thisform.Caption)
		RETURN .F.
	ENDIF

	************************************************************************
	&& Grabo el detalle del recibo
	************************************************************************

	SELECT cur_detalle
	IF RECCOUNT("cur_detalle") > 0 THEN
		GO TOP
	ENDIF

	DO WHILE !EOF("cur_detalle")
		lnProxID_Det = goConn.getNextID("rccob_d", "idRCCob_D")
		lnIdCheque = 0
		lnIdPlanCta = cur_detalle.idPlanCta
		lnIdBanco = cur_detalle.idBanco
		lnImporte = cur_detalle.importe
		lcTipoPago = cur_detalle.tipoPago
		
		lnIdProvin = cur_detalle.idProvin
		lnRetCbte = cur_detalle.retCompro
		ldRetFecha = cur_detalle.retFecha
		
		&& Doy de alta el cheque en la tabla "cheques"
		IF ALLTRIM(cur_detalle.tipoPago) == "CHEQ" THEN
			lnIdCheque = cur_detalle.idCheque
			lcChq_Nro = cur_detalle.chq_nro
			ldFecEmisCheq = cur_detalle.fecEmis
			ldFecVtoCheq = cur_detalle.fecVto
			lcTipoDoc = cur_detalle.tipoDoc
			lnCUIT = cur_detalle.nroCuit
			lcTitular = cur_detalle.titular
			lcSucursal = cur_detalle.sucursal		
		ENDIF
		
		lcSql = "INSERT INTO rccob_d (idRCCob_D, idRCCob_C, idCheque, idPlanCta, idBanco, chq_nro, importe, tipoPago, idProvin, retCompro, retFecha) "
		lcSql = lcSql + "VALUES (" + ALLTRIM(STR(lnProxID_Det)) + ", " + ALLTRIM(STR(lnProxID)) + ", " + IIF(lnIdCheque = 0, "NULL", ALLTRIM(STR(lnIdCheque))) + ", "
		lcSql = lcSql + IIF(lnIdPlanCta = 0, "NULL", ALLTRIM(STR(lnIdPlanCta))) + ", " + IIF(lnIdBanco = 0, "NULL", ALLTRIM(STR(lnIdBanco))) + ", " + IIF(ALLTRIM(cur_detalle.tipoPago) == "CHEQ", "'" + lcChq_Nro + "'", "NULL") + ", "
		lcSql = lcSql + ALLTRIM(STR(lnImporte, 10, 2)) + ", '" + ALLTRIM(lcTipoPago) + "', " + IIF(lnIdProvin = 0, "NULL", ALLTRIM(STR(lnIdProvin))) + ", "
		lcSql = lcSql + IIF(lnRetCbte = 0, "NULL", ALLTRIM(STR(lnRetCbte))) + ", " + IIF(ldRetFecha = {}, "NULL", loDT.tomysql(ldRetFecha)) + ")"
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.execute()
			goConn.RollBack()
			
			IF lbEsNumerado THEN
				loNum.desbloquear()
			ENDIF
					
			MESSAGEBOX(loCommand.errorMessage, 0+48, Thisform.Caption)
			RETURN .F.
		ENDIF

		SELECT cur_detalle
		SKIP
	ENDDO
ENDIF 


************************************************************************
&& Asocio el recibo con los comprobantes
************************************************************************

SELECT cur_facturas
IF RECCOUNT("cur_facturas") > 0 THEN
	GO TOP
ENDIF

lnImpImputar = this.imp_rc

DO WHILE !EOF("cur_facturas")
	IF cur_facturas.selected THEN
		
		lnIdCliente = cur_facturas.idCliente
				
		&& Hago el insert en la tabla cc_cli
		lnIdCC_Cli = goConn.GetNextID("cc_cli", "idCC_Cli")
		lnIdVentasC = cur_facturas.idVentasC
		
		IF lnImpImputar >= cur_facturas.saldo THEN
			lnImpGrabar = cur_facturas.saldo
			lnImpImputar = lnImpImputar - cur_facturas.saldo
			lnImpHaber = lnImpImputar
			lnSaldo = 0.00
		ELSE
			lnImpGrabar = lnImpImputar
			lnImpHaber = lnImpImputar - cur_facturas.saldo 
			lnSaldo = cur_facturas.saldo - lnImpImputar
		ENDIF
		
		&& Tengo que recuperar el Id de Cuenta Corriente correspondiente al comprobante de origen
		lcSql = "SELECT * FROM cc_cli WHERE idVentasC = " + ALLTRIM(STR(lnIdVentasC))
		loResult.ActiveConnection = goConn.ActiveConnection
		loResult.Cursor_Name = "cur_cc"
		loResult.OpenQuery(lcSql)
		
		SELECT cur_cc
		lnIdCC_Orig = cur_cc.idCC_Cli
		
		&& Agrego esto porque antes de aplicar el recibo puede que la factura tenga un
		&& id operacion asignado, entonces, debo agrupar el recibo dentro del mismo gurpo
		&& de operaciones
		IF cur_cc.idOper <> 0 THEN
			lnIdOper = cur_cc.idOper
		ENDIF
		
		loResult.Close_Query()
		
		&& Si no tengo IdOper asignado, entonces, lo creo nuevo
		IF lnIdOper = 0 THEN
			lcSql = "SELECT MAX(idOper) AS maxID FROM cc_cli"
			loResult.ActiveConnection = goConn.ActiveConnection
			loResult.Cursor_Name = "cur_Oper"
			loResult.OpenQuery(lcSql)

			SELECT cur_Oper
			IF ISNULL(cur_Oper.maxID) THEN
				lnIdOper = 1
			ELSE
				lnIdOper = cur_Oper.maxID + 1
			ENDIF

			loResult.Close_Query()		
		ENDIF

		&& Genero el registro en la tabla de cuentas corrientes			
		lcSql = "INSERT INTO cc_cli (idCC_Cli, idCliente, idCC_Orig, idVentasC, cbte, tipoDoc, ptoVta, nroCbte, fecEmis, fecvto, impDebe, impHaber, idOper, usuAlta, fecAlta, idHostAlta, idCondPago, idSitIVA, idvendedor) "
		lcSql = lcSql + "VALUES (" + ALLTRIM(STR(lnIdCC_Cli)) + ", " + ALLTRIM(STR(lnIdCliente)) + ", " + ALLTRIM(IIF(ISNULL(lnIdCC_Orig) .OR. lnIdCC_Orig = 0, "NULL", STR(lnIdCC_Orig))) + ", " 
		lcSql = lcSql +  " NULL, '" + ALLTRIM(lcCbte) + "', '" + ALLTRIM(lcTipo) + "', '" + ALLTRIM(lcPtoVta) + "', '" + ALLTRIM(lcNumRC) + "', " 
		lcSql = lcSql + ldFecEmis + ", " + ldFecEmis + ", 0, " + ALLTRIM(STR(IIF(lnImpGrabar < 0, lnImpGrabar * -1, lnImpGrabar), 10, 2)) + ", " + ALLTRIM(STR(lnIdOper)) + ", "
		lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', " + loDT.getDateTime() + ", '" + ALLTRIM(SYS(0)) + "', " + ALLTRIM(STR(cur_facturas.idCondPago)) + ", " + ALLTRIM(STR(cur_facturas.idSitIVA)) + ", " + ALLTRIM(STR(cur_facturas.idVendedor))+ ")"
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			
			IF lbEsNumerado THEN
				loNum.desbloquear()
			ENDIF
							
			MESSAGEBOX(loCommand.errorMessage, 0+48, Thisform.Caption)
			RETURN .F.
		ENDIF
		
		&& Actualizo el ID de Operacion en la tabla de cuentas corrientes
		lcSql = "UPDATE cc_cli SET idOper = " + ALLTRIM(STR(lnIdOper)) + ", "
		lcSql = lcSql + "usuModi = '" + ALLTRIM(gcCodUsu) + "', "
		lcSql = lcSql + "fecModi = " + loDT.getDateTime() + ", "
		lcSql = lcSql + "idHostModi = '" + ALLTRIM(SYS(0)) + "' " 
		lcSql = lcSql + " WHERE idVentasC = " + ALLTRIM(STR(lnIdVentasC))
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.execute() THEN
			goConn.Rollback()
			
			IF lbEsNumerado THEN
				loNum.desbloquear()
			ENDIF
			
			MESSAGEBOX(loCommand.errorMessage, 0+48, Thisform.Caption)
			RETURN .F.
		ENDIF
		
		&& Si es un RC grabo la relación entre los recibos y los comprobantes de ventas.
		IF lcCbte == "RC" THEN 
			lnIdRCCob_DV = goConn.getNextID("rccob_dv", "idRCCob_DV")
			
			lcSql = "INSERT INTO rccob_dv (idRCCob_DV, idRCCob_C, idVentasC, totCbte, impApl) "
			lcSql = lcSql + "VALUES (" + ALLTRIM(STR(lnIdRCCob_DV)) + ", " + ALLTRIM(STR(lnProxID)) + ", " + ALLTRIM(STR(cur_facturas.idVentasC)) + ", "
			lcSql = lcSql + ALLTRIM(STR(cur_facturas.importe, 10, 2)) + ", " + ALLTRIM(STR(IIF(lnImpGrabar < 0, lnImpGrabar * -1, lnImpGrabar), 10, 2)) + ")"
			
			loCommand.ActiveConnection = goConn.ActiveConnection
			loCommand.CommandText = lcSql
			
			IF !loCommand.execute() THEN
				IF lbEsNumerado THEN
					loNum.desbloquear()
				ENDIF
							
				MESSAGEBOX(loCommand.errorMessage, 0+48, Thisform.Caption)
				RETURN .F.
			ENDIF
			
			&& Actualizo el cursor de comprobantes
			SELECT cur_facturas
			LOCK()
			REPLACE cur_facturas.impApl WITH IIF(lnImpGrabar < 0, lnImpGrabar * -1, lnImpGrabar)
			UNLOCK
		ENDIF 		
		
		&& Actualizo el saldo en la tabla ventascab
		lcSql = "UPDATE ventascab SET saldo = " + ALLTRIM(STR(lnSaldo, 10, 2)) + ", "
		lcSql = lcSql + "usuModi = '" + ALLTRIM(gcCodUsu) + "', "
		lcSql = lcSql + "fecModi = " + loDT.getDateTime() + ", "
		lcSql = lcSql + "idHostModi = '" + ALLTRIM(SYS(0)) + "' " 		
		lcSql = lcSql + "WHERE idVentasC = " + ALLTRIM(STR(lnIdVentasC))
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.execute() THEN
			goConn.Rollback()
			
			IF lbEsNumerado THEN
				loNum.desbloquear()
			ENDIF
			
			MESSAGEBOX(loCommand.errorMessage, 0+48, Thisform.Caption)
			RETURN .F.
		ENDIF
	ENDIF
	
	lnIdOper = lnIdOper + 1
	
	SELECT cur_facturas
	SKIP
ENDDO

&& Si es RC y si la diferencia es positiva significa que tiene saldo a favor, entonces,
&& genero un comprobante RC con el saldo a favor.
IF lcCbte == "RC" THEN 
	IF lnImpHaber > 0 THEN
		lnIdCC_Cli = goConn.GetNextID("cc_cli", "idCC_Cli")
		lnIdOper = goConn.GetNextID("cc_cli", "idOper")

		&& Genero el registro en la tabla de cuentas corrientes			
		lcSql = "INSERT INTO cc_cli (idCC_Cli, idCliente, idCC_Orig, idVentasC, cbte, tipoDoc, ptoVta, nroCbte, fecEmis, fecvto, impDebe, impHaber, idOper, usuAlta, fecAlta, idHostAlta, idCondPago, idSitIVA, idvendedor) "
		lcSql = lcSql + "VALUES (" + ALLTRIM(STR(lnIdCC_Cli)) + ", " + ALLTRIM(STR(lnIdCliente)) + ", NULL, " 
		lcSql = lcSql + "NULL, '" + ALLTRIM(lcCbte) + "', '" + ALLTRIM(lcTipo) + "', '" + ALLTRIM(lcPtoVta) + "', '" + ALLTRIM(lcNumRC) + "', "
		lcSql = lcSql + ldFecEmis + ", " + ldFecEmis + ", 0, " + ALLTRIM(STR(lnImpHaber, 10, 2)) + ", " + ALLTRIM(STR(lnIdOper)) + ", "
		lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', " + loDT.getDateTime() + ", '" + ALLTRIM(SYS(0)) + "', " + ALLTRIM(STR(clientes.idCondPago)) + ", " + ALLTRIM(STR(clientes.idSitIVA)) + ", " + ALLTRIM(STR(clientes.idVendedor)) + ")"
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.execute() THEN
			goConn.Rollback()
			
			IF lbEsNumerado THEN
				loNum.desbloquear()
			ENDIF
			
			MESSAGEBOX(loCommand.errorMessage, 0+48, Thisform.Caption)
			RETURN .F.
		ENDIF	
	ENDIF
ENDIF 

&& Seteo las propiedades con el num de cbte para tener el dato al momento de generar el mov de caja
this.ptovta = lcPtoVta
this.nrocbte = lcNumRC
this.tipo = lcTipo

&& Genero los movimientos de caja en el caso que este en el modulo de caja.
IF this.grabar_movcaja THEN 
	IF !this.generar_movcaja() THEN 
		RETURN .F.
	ENDIF 
ENDIF 

IF lbEsNumerado THEN
	loNum.actualizar()
	loNum.desbloquear()
ENDIF

IF lcCbte == "RC" THEN 
	MESSAGEBOX("El Recibo " + lcNroRec + " fue creado con éxito!", 0+64, Thisform.Caption)
ENDIF 

RETURN .T.
ENDPROC
PROCEDURE generar_movcaja
LOCAL lcSql, loResult, loCommand, lnIdCtaCja
LOCAL lnIdMovCjaC, lnIdMovCjaD, lnIdMovCjaDP, lnIdConcCJ
LOCAL loDT, lnImpImputar, lnImpGrabar, lnSaldo, lnIdMovCjaR

lcSql = ""
loResult = CREATEOBJECT("odbc_result")
loCommand = CREATEOBJECT("odbc_command")
lnIdCtaCja = 0
lnIdMovCjaC = this.idmovcjac
lnIdMovCjaD = 0
lnIdMovCjaDP = 0
lnIdConcCJ = this.idconccj
loDT = CREATEOBJECT("datetime")
lnImpImputar = this.imp_rc
lnImpGrabar = 0.00
lnSaldo = 0.00
lnIdMovCjaR = 0

************************************************************************************************
&& Hago el insert en la tabla MovCjaDet
************************************************************************************************

&& Levanto el ID de MovCjaDet
lcSql = "SELECT MAX(idMovCjaD) AS maxID FROM movcjadet WHERE IdMovCjaC = " + ALLTRIM(STR(this.idmovcjac))
loResult.Cursor_Name = "cur_det"
loResult.ActiveConnection = goConn.ActiveConnection

IF !loResult.OpenQuery(lcSql) THEN
	goConn.Rollback()
	MESSAGEBOX(loResult.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

IF ISNULL(cur_det.maxID) THEN
	lnIdMovCjaD = 1
ELSE
	lnIdMovCjaD = cur_det.maxID + 1
ENDIF

loResult.Close_Query()

&& Genero el registro en MovCjaDet
lcSql = "INSERT INTO movcjadet (IdMovCjaD, IdMovCjaC, idConcCJ, fecha, cbte, tipodoc, ptovta, nrocbte, importe, usuAlta, fecAlta, idHostAlta) "
lcSql = lcSql + "VALUES (" + ALLTRIM(STR(lnIdMovCjaD)) + ", " + ALLTRIM(STR(lnIdMovCjaC)) + ", " + ALLTRIM(STR(lnIdConcCJ)) + ", " + loDT.getDateTime() + ", "
lcSql = lcSql + "'" + ALLTRIM(this.cbte) + "', '" + ALLTRIM(this.tipo) + "', " + ALLTRIM(this.ptovta) + ", " + ALLTRIM(this.nrocbte) + ", "
lcSql = lcSql + ALLTRIM(STR(this.imp_rc, 10, 2)) + ", '" + ALLTRIM(gcCodUsu) + "', " + loDT.getDateTime() + ", '" + ALLTRIM(SYS(0)) + "')"

loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = lcSql

IF !loCommand.Execute() THEN
	goConn.Rollback()
	MESSAGEBOX(ALLTRIM(loCommand.ErrorMessage), 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

************************************************************************************************
&& Hago el insert en la tabla MovCjaDetP
************************************************************************************************

SELECT cur_detalle
IF RECCOUNT("cur_detalle") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_detalle")

	&& Levanto el idCtaCja
	lcSql = "SELECT idCtaCja FROM ctacja WHERE codCtaCj = '" + ALLTRIM(cur_detalle.tipopago) + "'"
	loResult.Cursor_Name = "cur_ctacja"
	loResult.ActiveConnection = goConn.ActiveConnection
	
	IF !loResult.OpenQuery(lcSql) THEN
		goConn.Rollback()
		MESSAGEBOX(loResult.Error_Message, 0+48, Thisform.Caption)
		RETURN .F.
	ENDIF

	lnIdCtaCja = cur_ctacja.idCtaCja
	
	loResult.Close_Query()
	
	&& Levanto el ID de MovCjaDetP
	lcSql = "SELECT MAX(idMovCjaDP) AS maxID FROM movcjadetp WHERE IdMovCjaC = " + ALLTRIM(STR(this.idmovcjac)) + " AND idMovCjaD = " + ALLTRIM(STR(lnIdMovCjaD)) 
	loResult.Cursor_Name = "cur_det"
	loResult.ActiveConnection = goConn.ActiveConnection
	
	IF !loResult.OpenQuery(lcSql) THEN
		goConn.Rollback()
		MESSAGEBOX(loResult.Error_Message, 0+48, Thisform.Caption)
		RETURN .F.
	ENDIF

	IF ISNULL(cur_det.maxID) THEN
		lnIdMovCjaDP = 1
	ELSE
		lnIdMovCjaDP = cur_det.maxID + 1
	ENDIF

	loResult.Close_Query()

	&& Genera el detalle en MovCjaDetP
	lcSql = "INSERT INTO movcjadetp (IdMovCjaDP, IdMovCjaD, IdMovCjaC, idCtaCja, tipoPago, importe, idPlanCta, idBanco, idCheque, chq_nro, idProvin, retCompro, retFecha) "
	lcSql = lcSql + "VALUES (" + ALLTRIM(STR(lnIdMovCjaDP)) + ", " + ALLTRIM(STR(lnIdMovCjaD)) + ", " + ALLTRIM(STR(lnIdMovCjaC)) + ", " + ALLTRIM(STR(lnIdCtaCja)) + ", "
	lcSql = lcSql + "'" + ALLTRIM(cur_detalle.tipopago) + "', " + ALLTRIM(STR(cur_detalle.importe, 10, 2)) + ", " + IIF(cur_detalle.idPlanCta = 0, "NULL", ALLTRIM(STR(cur_detalle.idPlanCta))) + ", "
	lcSql = lcSql + IIF(cur_detalle.idBanco = 0, "NULL", ALLTRIM(STR(cur_detalle.idBanco))) + ", " + IIF(cur_detalle.idCheque = 0, "NULL", ALLTRIM(STR(cur_detalle.idCheque))) + ", " 
	lcSql = lcSql + IIF(ALLTRIM(cur_detalle.tipoPago) == "CHEQ", "'" + cur_detalle.chq_nro + "'", "NULL") + ", " + IIF(cur_detalle.idProvin = 0, "NULL", ALLTRIM(STR(cur_detalle.idProvin))) + ", "
	lcSql = lcSql + IIF(cur_detalle.retCompro = 0, "NULL", ALLTRIM(STR(cur_detalle.retCompro))) + ", " + IIF(cur_detalle.retFecha = {}, "NULL", loDT.tomysql(cur_detalle.retFecha)) + ")"
			
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql

	IF !loCommand.Execute() THEN
		goConn.Rollback()
		MESSAGEBOX(ALLTRIM(loCommand.ErrorMessage), 0+48, Thisform.Caption)
		RETURN .F.
	ENDIF
	
	SELECT cur_detalle
	SKIP 
ENDDO

************************************************************************************************
&& Vinculo los movimientos de caja con los comprobantes aplicados 
************************************************************************************************
SELECT cur_facturas
IF RECCOUNT("cur_facturas") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_facturas")
	IF cur_facturas.selected THEN
		lnIdMovCjaR = goConn.GetNextID("movcjarel", "idMovCjaR")
		
		&& Calculo el saldo del comprobante	
		IF lnImpImputar >= cur_facturas.saldo THEN
			lnImpGrabar = cur_facturas.saldo
			lnImpImputar = lnImpImputar - cur_facturas.saldo
			lnSaldo = 0.00
		ELSE
			lnImpGrabar = lnImpImputar
			lnSaldo = cur_facturas.saldo - lnImpImputar
		ENDIF
		
		lcSql = "INSERT INTO movcjarel ( "
		lcSql = lcSql + "idMovCjaR, "
		lcSql = lcSql + "idMovCjaD, "
		lcSql = lcSql + "idMovCjaC, "
		lcSql = lcSql + "idVentasC, "
		lcSql = lcSql + "cbte, "
		lcSql = lcSql + "tipoDoc, "
		lcSql = lcSql + "ptoVta, "
		lcSql = lcSql + "numCbte, "
		lcSql = lcSql + "importe, "
		lcSql = lcSql + "saldo) VALUES ( "
		lcSql = lcSql + ALLTRIM(STR(lnIdMovCjaR)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnIdMovCjaD)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnIdMovCjaC)) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_facturas.idVentasC)) + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_facturas.cbte) + "', "		
		lcSql = lcSql + "'" + ALLTRIM(cur_facturas.tipodoc) + "', "
		lcSql = lcSql + ALLTRIM(STR(cur_facturas.ptovta)) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_facturas.numcbte)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnImpGrabar, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnSaldo, 10, 2)) + ")"
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
			RETURN .F.
		ENDIF
	ENDIF 
	
	SELECT cur_facturas
	SKIP 
ENDDO 	
ENDPROC
PROCEDURE validar_todosloscheques
&& Este metodo valida que no se ingrese un mismo cheque en el 
&& recibo o que ya exista en la base de datos del mismo cliente.
PARAMETERS lnIdCliente

LOCAL loCheques, lcSql

loCheques = CREATEOBJECT("odbc_result")
lcSql = ""

SELECT cur_detalle
GO TOP

DO WHILE !EOF("cur_detalle")
	IF (cur_detalle.tipoPago == "CHEQ") THEN 
		lcSql = "SELECT * "
		lcSql = lcSql + " FROM cheques "
		lcSql = lcSql + " WHERE idBanco = " + ALLTRIM(STR(cur_detalle.idBanco)) + " "
		lcSql = lcSql + " 	AND chq_nro = " + ALLTRIM(cur_detalle.chq_nro) + " "
		IF lnIdCliente = 0 THEN 
			lcSql = lcSql + " 	AND idCliente IS NULL "
		ELSE 
			lcSql = lcSql + " 	AND idCliente = " + ALLTRIM(STR(lnIdCliente))
		ENDIF 

		loCheques.ActiveConnection = goConn.ActiveConnection
		loCheques.cursor_name = "cur_cheques"

		IF !loCheques.OpenQuery(lcSql)
			MESSAGEBOX(loCheques.error_message, 0+48, Thisform.Caption)
			RETURN .F.
		ENDIF 

		SELECT cur_cheques
		IF RECCOUNT("cur_cheques") > 0 THEN 
			MESSAGEBOX("El cheque " + ALLTRIM(cur_detalle.chq_nro) + " ya fue ingresado en la base de datos. Verifique los datos.", 0+16, Thisform.Caption)
			RETURN .F.
		ENDIF 

		loCheques.close_query()
	ENDIF 

	SELECT cur_detalle
	SKIP
ENDDO

RETURN .T.

ENDPROC


