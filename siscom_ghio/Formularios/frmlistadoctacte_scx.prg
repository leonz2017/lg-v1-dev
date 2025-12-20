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
OBJETO: FRMLISTADOCTACTE
************************************************************
*** PROPIEDADES ***
Height = 380
Width = 724
DoCreate = .T.
Caption = "Listado de Cuentas Corrientes de Clientes"
WindowType = 0
WindowState = 0
mailfc = 
Name = "FRMLISTADOCTACTE"

*** METODOS ***
PROCEDURE limpiar

thisform.contenedor.contenedor1.sel_ClienteDesde.txtCodigo.Enabled = .F.
thisform.contenedor.contenedor1.sel_ClienteHasta.txtCodigo.Enabled = .F.

thisform.contenedor.contenedor4.sel_VendDesde.txtCodigo.Enabled = .F.
thisform.contenedor.contenedor4.sel_VendHasta.txtCodigo.Enabled = .F.

thisform.contenedor.contenedor3.txtfecemisdesde.Value = DATE(2013,01,01)
thisform.contenedor.contenedor3.txtFecEmisHasta.Value = DATE()

thisform.contenedor.contenedor1.sel_ClienteDesde.blanquear()
thisform.contenedor.contenedor1.sel_ClienteHasta.blanquear()

thisform.contenedor.contenedor4.sel_VendDesde.blanquear()
thisform.contenedor.contenedor4.sel_VendHasta.blanquear()

thisform.contenedor.contenedor1.sel_ClienteDesde.valcpoid = 0
thisform.contenedor.contenedor1.sel_ClienteHasta.valcpoid = 0

thisform.contenedor.contenedor4.sel_VendDesde.valcpoid = 0
thisform.contenedor.contenedor4.sel_VendHasta.valcpoid = 0

IF !USED("cur_resumen")
	SELECT cur_resumen
	ZAP
ENDIF 

IF !USED("cur_todosmov")
	SELECT cur_todosmov
	ZAP
ENDIF 

IF !USED("cur_fcsaldos")
	SELECT cur_fcsaldos
	ZAP
ENDIF 

IF !USED("cur_saldoparc")
	SELECT cur_saldoparc
	ZAP
ENDIF 

IF !USED("cur_salmora")
	SELECT cur_salmora
	ZAP
ENDIF 
ENDPROC
PROCEDURE resumen
PARAMETERS lnIdCliDesde, lnIdCliHasta, lnIdVendDesde, lnIdVendHasta, tcFechaHH

LOCAL lcSql, loResult
loResult = CREATEOBJECT("odbc_result")

lcSql = " SELECT  vendedores.idvendedor, "
lcSql = lcSql + " vendedores.nombre, "
lcSql = lcSql + " clientes.idcliente, "
lcSql = lcSql + " clientes.razsoc, "
lcSql = lcSql + " clientes.telefono, "
lcSql = lcSql + " clientes.email, "
lcSql = lcSql + " ROUND(SUM(cc.impdebe - cc.imphaber),2) as Saldo "
lcSql = lcSql + " FROM vendedores INNER JOIN clientes ON vendedores.idvendedor = clientes.idvendedor"
lcSql = lcSql + " 		INNER JOIN cc_cli cc ON clientes.idcliente = cc.idcliente "
lcSql = lcSql + " WHERE        clientes.idcliente >= " + ALLTRIM(STR(lnIdCliDesde)) + " AND clientes.idcliente <= " +  ALLTRIM(STR(lnIdCliHasta)) + " "
lcSql = lcSql + "		AND clientes.idCondPago <> 1 "
lcSql = lcSql + "       AND clientes.idvendedor >= " + ALLTRIM(STR(lnIdVendDesde)) + " AND clientes.idvendedor <= " +  ALLTRIM(STR(lnIdVendHasta)) + " "
lcSql = lcSql + "		AND CAST(fecemis AS DATE) <= " + tcFechaHH + " "
lcSql = lcSql + "       AND (cc.usubaja is null or cc.usubaja = '') "
lcSql = lcSql + " GROUP BY vendedores.idvendedor, "
lcSql = lcSql + " 		vendedores.nombre, "
lcSql = lcSql + " 		clientes.idcliente, "
lcSql = lcSql + " 		clientes.razsoc, "
lcSql = lcSql + " 		clientes.telefono, "
lcSql = lcSql + " 		clientes.email "
lcSql = lcSql + " HAVING ROUND(SUM(cc.impdebe - cc.imphaber),2) != 0 "
lcSql = lcSql + " ORDER BY clientes.idvendedor, clientes.idcliente"	

loResult.ActiveConnection = goConn.ActiveConnection
loResult.cursor_name = "cur_tempo"
loResult.OpenQuery(lcSql) 

SELECT cur_tempo
IF RECCOUNT() > 0      
 GO TOP 
ENDIF

SELECT cur_resumen
ZAP

SELECT cur_tempo
DO WHILE !EOF("cur_tempo")
	SELECT cur_resumen
	APPEND BLANK
	REPLACE cur_resumen.CodVend WITH cur_tempo.idvendedor
	REPLACE cur_resumen.Nombre WITH cur_tempo.nombre ADDITIVE
	REPLACE cur_resumen.Codigo WITH cur_tempo.idcliente ADDITIVE 
	REPLACE cur_resumen.RazSoc WITH cur_tempo.razsoc ADDITIVE
	REPLACE cur_resumen.telefono WITH cur_tempo.telefono ADDITIVE 
	REPLACE cur_resumen.email WITH cur_tempo.email ADDITIVE 
	REPLACE cur_resumen.saldo WITH cur_tempo.saldo ADDITIVE 
	
	SELECT cur_tempo
	SKIP 
ENDDO 

loResult.close_query()

SELECT cur_resumen
IF RECCOUNT() > 0
	GO top
ELSE 
	RETURN .F.
ENDIF

RETURN .T.
ENDPROC
PROCEDURE todosmov
PARAMETERS lnIdCliDesde, lnIdCliHasta, lcFecEmisDesde, lcFecEmisHasta, lnIdVendDesde, lnIdVendHasta

LOCAL lcSql, loResult
LOCAL lnmaxidoper

loResult = CREATEOBJECT("odbc_result")

lcSql = " SELECT  vendedores.idvendedor, "
lcSql = lcSql + " vendedores.nombre, "
lcSql = lcSql + " clientes.idcliente, "
lcSql = lcSql + " clientes.razsoc, "
lcSql = lcSql + " clientes.telefono, "
lcSql = lcSql + " clientes.email, "
lcSql = lcSql + " cc.idoper, "
lcSql = lcSql + " cc.observ, "
lcSql = lcSql + " cc.fecemis, "
lcSql = lcSql + " cc.cbte, "
lcSql = lcSql + " cc.tipodoc, "
lcSql = lcSql + " cc.ptovta, "
lcSql = lcSql + " cc.nroCbte, "	
lcSql = lcSql + " ROUND(cc.impdebe,2) AS Debe, "
lcSql = lcSql + " ROUND(cc.imphaber,2) AS Haber, "
lcSql = lcSql + " ROUND(cc.impdebe - cc.imphaber,2) AS Saldo, "
lcSql = lcSql + "(CASE WHEN operfc.fecfc is null THEN (CASE WHEN operadnd.fecadnd is null THEN fecemis ELSE operadnd.fecadnd END) ELSE operfc.fecfc END) AS fecha, "
lcSql = lcSql + "(CASE WHEN cbte = 'PTO' OR cbte = 'FC' OR cbte = 'FCO' THEN  1 ELSE "
lcSql = lcSql + "	(CASE WHEN cbte = 'RC' OR cbte = 'RCC' OR cbte = 'PA' THEN  4 ELSE "
lcSql = lcSql + "		(CASE WHEN cbte = 'NC' THEN  5 ELSE "
lcSql = lcSql + "			(CASE WHEN cbte = 'AC' THEN  6 ELSE "
lcSql = lcSql + "				(CASE WHEN cbte = 'AD' THEN  3 ELSE "
lcSql = lcSql + "					(CASE WHEN cbte = 'ND' THEN  2 ELSE "
lcSql = lcSql + "						(CASE WHEN cbte = 'AN' THEN  2 ELSE 0 END) "
lcSql = lcSql + "					END) "
lcSql = lcSql + "				END) "
lcSql = lcSql + "			END) "
lcSql = lcSql + "		END) "
lcSql = lcSql + "	END) "
lcSql = lcSql + "END) AS Orden2 "
lcSql = lcSql + " FROM    vendedores inner join clientes on vendedores.idvendedor = clientes.idvendedor	"
lcSql = lcSql + " 	      inner join cc_cli cc on clientes.idcliente = cc.idcliente "
lcSql = lcSql + " 	left join (SELECT idoper, MAX(fecemis) AS 'fecfc' "
lcSql = lcSql + " 				FROM cc_cli "
lcSql = lcSql + " 				WHERE cbte = 'FC' and idoper != 0"
lcSql = lcSql + " 				GROUP BY idoper) AS operfc ON cc.idoper = operfc.idoper "
lcSql = lcSql + " 	left join ( SELECT idoper, MAX(fecemis) AS 'fecadnd' "
lcSql = lcSql + " 				FROM cc_cli "
lcSql = lcSql + " 				WHERE cbte IN ('AD','ND') and idoper != 0"
lcSql = lcSql + " 				GROUP BY idoper) AS operadnd ON cc.idoper = operadnd.idoper "
lcSql = lcSql + " WHERE        clientes.idcliente >= " + ALLTRIM(STR(lnIdCliDesde)) + " and clientes.idcliente <= " +  ALLTRIM(STR(lnIdCliHasta)) + " "
lcSql = lcSql + " 			and clientes.idvendedor >= " + ALLTRIM(STR(lnIdVendDesde)) + " and clientes.idvendedor <= " +  ALLTRIM(STR(lnIdVendHasta)) + " "
&&lcSql = lcSql + "		  	and clientes.idCondPago <> 1 "

IF INT(VAL(getConfig("SQLSRV"))) = 1 THEN
	lcSql = lcSql + "         and CONVERT(CHAR(8), fecemis, 112) between " + lcFecEmisDesde + " and " + lcFecEmisHasta + " "
ELSE
	lcSql = lcSql + "         and CAST(fecemis AS DATE) between " + lcFecEmisDesde + " and " + lcFecEmisHasta + " "
ENDIF

lcSql = lcSql + "         and (cc.usubaja is null or cc.usubaja = '') "
lcSql = lcSql + " ORDER BY idvendedor, idcliente, fecha, idOper, Orden2, nrocbte"	

loResult.ActiveConnection = goConn.ActiveConnection
loResult.cursor_name = "cur_tempo"
loResult.OpenQuery(lcSql) 

SELECT cur_tempo
IF RECCOUNT() > 0      
 GO TOP 
ENDIF
 
SELECT cur_todosmov
ZAP

SELECT cur_tempo
DO WHILE !EOF()
	SELECT cur_todosmov
	APPEND BLANK
	REPLACE CodVend WITH cur_tempo.idvendedor
	REPLACE Nombre WITH cur_tempo.nombre ADDITIVE
	REPLACE Codigo WITH cur_tempo.idcliente ADDITIVE
	REPLACE RazSoc WITH cur_tempo.razsoc ADDITIVE
	REPLACE telefono WITH cur_tempo.telefono ADDITIVE 
	REPLACE email WITH cur_tempo.email ADDITIVE 
	REPLACE idoper WITH cur_tempo.idoper ADDITIVE 
	REPLACE observ WITH IIF(ISNULL(cur_tempo.observ), "", cur_tempo.observ) ADDITIVE
	REPLACE fecemis WITH cur_tempo.fecemis ADDITIVE
	REPLACE fecha WITH cur_tempo.fecha ADDITIVE  
	REPLACE cbte WITH cur_tempo.cbte ADDITIVE 
	REPLACE tipodoc WITH cur_tempo.tipodoc ADDITIVE
	REPLACE numCbte WITH getPtoVta(cur_tempo.ptoVta) + "-" + getNroCbte(cur_tempo.nroCbte) ADDITIVE
   	REPLACE debe WITH cur_tempo.debe ADDITIVE
   	REPLACE haber WITH cur_tempo.haber ADDITIVE   
	REPLACE saldo WITH cur_tempo.saldo ADDITIVE 
	
	SELECT cur_tempo
	SKIP 
ENDDO 

loResult.close_query()

SELECT cur_todosmov
IF RECCOUNT() > 0
	GO TOP
ELSE 
	RETURN .F.
ENDIF 

&& Busco los registros con idoper en cero y les asigno un valor para que salgan correctamente en el listado
lcSql = "SELECT MAX(idoper) AS maxidoper FROM cc_cli"

loResult.ActiveConnection = goConn.ActiveConnection
loResult.cursor_name = "cur_max"
loResult.OpenQuery(lcSql) 

lnmaxidoper = cur_max.maxidoper

SELECT cur_todosmov
DO WHILE !EOF()
	
	IF cur_todosmov.idoper = 0
		lnmaxidoper = lnmaxidoper + 1
	
		SELECT cur_todosmov
		REPLACE idoper WITH lnmaxidoper
	ENDIF 
	
	SELECT cur_todosmov
	SKIP 
ENDDO 

loResult.close_query()

RETURN .T.
ENDPROC
PROCEDURE cbtesconsaldos
PARAMETERS lnIdCliDesde, lnIdCliHasta, lcFecEmisDesde, lcFecEmisHasta, lnIdVendDesde, lnIdVendHasta

LOCAL lcSql, loResult

loResult = CREATEOBJECT("odbc_result")

lcSql = " SELECT  vendedores.idvendedor, "
lcSql = lcSql + " vendedores.nombre, "
lcSql = lcSql + " clientes.idcliente, "
lcSql = lcSql + " clientes.razsoc, "
lcSql = lcSql + " clientes.telefono, "
lcSql = lcSql + " clientes.email, "
lcSql = lcSql + " cc.idoper, "
lcSql = lcSql + " cc.observ, "
lcSql = lcSql + " cc.fecemis, "
lcSql = lcSql + " cc.cbte, "
lcSql = lcSql + " cc.tipodoc, "
lcSql = lcSql + " cc.ptovta, "
lcSql = lcSql + " cc.nroCbte, "	
lcSql = lcSql + " ROUND(cc.impdebe,2) AS Debe, "
lcSql = lcSql + " ROUND(cc.imphaber,2) AS Haber, "
lcSql = lcSql + " ROUND(cc.impdebe - cc.imphaber,2) AS Saldo, "
lcSql = lcSql + "(CASE WHEN operfc.fecfc is null THEN (CASE WHEN operadnd.fecadnd is null THEN fecemis ELSE operadnd.fecadnd END) ELSE operfc.fecfc END) AS fecha, "
lcSql = lcSql + "(CASE WHEN cbte = 'PTO' OR cbte = 'FC' OR cbte = 'FCO' THEN  1 ELSE "
lcSql = lcSql + "	(CASE WHEN cbte = 'RC' OR cbte = 'RCC' OR cbte = 'PA' THEN  4 ELSE "
lcSql = lcSql + "		(CASE WHEN cbte = 'NC' THEN  5 ELSE "
lcSql = lcSql + "			(CASE WHEN cbte = 'AC' THEN  6 ELSE "
lcSql = lcSql + "				(CASE WHEN cbte = 'AD' THEN  3 ELSE "
lcSql = lcSql + "					(CASE WHEN cbte = 'ND' THEN  2 ELSE "
lcSql = lcSql + "						(CASE WHEN cbte = 'AN' THEN  2 ELSE 0 END) "
lcSql = lcSql + "					END) "
lcSql = lcSql + "				END) "
lcSql = lcSql + "			END) "
lcSql = lcSql + "		END) "
lcSql = lcSql + "	END) "
lcSql = lcSql + "END) AS Orden2 "
lcSql = lcSql + " FROM    vendedores inner join clientes on vendedores.idvendedor = clientes.idvendedor	 "
lcSql = lcSql + " 		  inner join cc_cli cc on clientes.idcliente = cc.idcliente "
lcSql = lcSql + " 	left join ( SELECT idoper, MAX(fecemis) AS 'fecfc' "
lcSql = lcSql + " 				FROM cc_cli "
lcSql = lcSql + " 				WHERE cbte = 'FC' and idoper != 0"
lcSql = lcSql + " 				GROUP BY idoper) AS operfc ON cc.idoper = operfc.idoper "
lcSql = lcSql + " 	left join ( SELECT idoper, MAX(fecemis) AS 'fecadnd' "
lcSql = lcSql + " 				FROM cc_cli "
lcSql = lcSql + " 				WHERE cbte IN ('AD','ND') and idoper != 0"
lcSql = lcSql + " 				GROUP BY idoper) AS operadnd ON cc.idoper = operadnd.idoper "
lcSql = lcSql + " 	left join ( SELECT cc2.idoper, ROUND(SUM(cc2.impdebe - cc2.imphaber),2) as SaldoTot "
lcSql = lcSql + " 				FROM cc_cli cc2 "
lcSql = lcSql + " 				WHERE cc2.idcliente >= " + ALLTRIM(STR(lnIdCliDesde)) + " and cc2.idcliente <= " +  ALLTRIM(STR(lnIdCliHasta)) + " "
lcSql = lcSql + "         			and (cc2.usubaja is null or cc2.usubaja = '') "
lcSql = lcSql + "         			and idoper != 0 "
lcSql = lcSql + "         		GROUP BY cc2.idoper) AS Saldos ON cc.idoper = Saldos.idoper "
lcSql = lcSql + " WHERE       clientes.idcliente >= " + ALLTRIM(STR(lnIdCliDesde)) + " and clientes.idcliente <= " +  ALLTRIM(STR(lnIdCliHasta)) + " "
lcSql = lcSql + " 		  	  and clientes.idvendedor >= " + ALLTRIM(STR(lnIdVendDesde)) + " and clientes.idvendedor <= " +  ALLTRIM(STR(lnIdVendHasta)) + " "
&&lcSql = lcSql + "		  	  and clientes.idCondPago <> 1 "

IF INT(VAL(getConfig("SQLSRV"))) = 1 THEN
	lcSql = lcSql + "         and CONVERT(CHAR(8), fecemis, 112) between " + lcFecEmisDesde + " and " + lcFecEmisHasta + " "
ELSE
	lcSql = lcSql + "         and CAST(fecemis AS DATE) between " + lcFecEmisDesde + " and " + lcFecEmisHasta + " "
ENDIF

lcSql = lcSql + "         and (cc.usubaja is null or cc.usubaja = '') "
lcSql = lcSql + "         and (SaldoTot != 0 or SaldoTot is null) "
lcSql = lcSql + " ORDER BY idvendedor, idcliente, fecha, idOper, Orden2, nroCbte"

loResult.ActiveConnection = goConn.ActiveConnection
loResult.cursor_name = "cur_tempo"
loResult.OpenQuery(lcSql) 

SELECT cur_tempo
IF RECCOUNT() > 0      
 GO TOP 
ENDIF
 
SELECT cur_todosmov
ZAP

SELECT cur_tempo
DO WHILE !EOF()
	SELECT cur_todosmov
	APPEND BLANK
	REPLACE CodVend WITH cur_tempo.idvendedor 
	REPLACE Nombre WITH cur_tempo.nombre ADDITIVE
	REPLACE Codigo WITH cur_tempo.idcliente ADDITIVE 
	REPLACE RazSoc WITH cur_tempo.razsoc ADDITIVE
	REPLACE telefono WITH cur_tempo.telefono ADDITIVE 
	REPLACE email WITH cur_tempo.email ADDITIVE 
	REPLACE idoper WITH cur_tempo.idoper ADDITIVE 
	REPLACE observ WITH IIF(ISNULL(cur_tempo.observ), "", cur_tempo.observ) ADDITIVE
	REPLACE fecemis WITH cur_tempo.fecemis ADDITIVE
	REPLACE fecha WITH cur_tempo.fecha ADDITIVE  
	REPLACE cbte WITH cur_tempo.cbte ADDITIVE 
	REPLACE tipodoc WITH cur_tempo.tipodoc ADDITIVE
	REPLACE numCbte WITH getPtoVta(cur_tempo.ptoVta) + "-" + getNroCbte(cur_tempo.nroCbte) ADDITIVE
   	REPLACE debe WITH cur_tempo.debe ADDITIVE
   	REPLACE haber WITH cur_tempo.haber ADDITIVE   
	REPLACE saldo WITH cur_tempo.saldo ADDITIVE 
	
	SELECT cur_tempo
	SKIP 
ENDDO 

loResult.close_query()

SELECT cur_todosmov
IF RECCOUNT() > 0
	GO top
ELSE 
	RETURN .F.
ENDIF 

&& Busco los registros con idoper en cero y les asigno un valor para que salgan correctamente en el listado
lcSql = "SELECT MAX(idoper) AS maxidoper FROM cc_cli"

loResult.ActiveConnection = goConn.ActiveConnection
loResult.cursor_name = "cur_max"
loResult.OpenQuery(lcSql) 

lnmaxidoper = cur_max.maxidoper

SELECT cur_todosmov
DO WHILE !EOF()
	
	IF cur_todosmov.idoper = 0
		lnmaxidoper = lnmaxidoper + 1
	
		SELECT cur_todosmov
		REPLACE idoper WITH lnmaxidoper
	ENDIF 
	
	SELECT cur_todosmov
	SKIP 
ENDDO 

loResult.close_query()

RETURN .T.
ENDPROC
PROCEDURE fcconsaldos
PARAMETERS lnIdCliDesde, lnIdCliHasta, lcFecEmisDesde, lcFecEmisHasta, lnIdVendDesde, lnIdVendHasta

LOCAL lcSql, loResult

loResult = CREATEOBJECT("odbc_result")

lcSql = " SELECT  vendedores.idvendedor, "
lcSql = lcSql + " vendedores.nombre, "
lcSql = lcSql + " clientes.idcliente, "
lcSql = lcSql + " clientes.razsoc, "
lcSql = lcSql + " clientes.telefono, "
lcSql = lcSql + " clientes.email, "
lcSql = lcSql + " cc.idoper, "
lcSql = lcSql + " cc.observ, "
lcSql = lcSql + " cc.fecemis, "
lcSql = lcSql + " cc.cbte, "
lcSql = lcSql + " cc.tipodoc, "
lcSql = lcSql + " cc.ptovta, "
lcSql = lcSql + " cc.nroCbte, "	
lcSql = lcSql + " ROUND(cc.impdebe,2) AS Debe, "
lcSql = lcSql + " ROUND(cc.imphaber,2) AS Haber, "
lcSql = lcSql + " ROUND(cc.impdebe - cc.imphaber,2) AS Saldo, "

IF ALLTRIM(getconfig("SQLSRV")) == "1" THEN
	lcSql = lcSql + " (CASE WHEN Saldos.SaldoTot is null THEN ROUND(cc.impdebe - cc.imphaber,2) ELSE Saldos.SaldoTot END) AS SaldoTot "
ELSE 
	IF ALLTRIM(getconfig("SQLSRV")) == "0" THEN
		lcSql = lcSql + " (CASE WHEN Saldos.SaldoTot is null THEN ROUND(cc.impdebe - cc.imphaber,2) ELSE Saldos.SaldoTot END) AS SaldoTot "
	ENDIF
ENDIF 

lcSql = lcSql + " FROM    vendedores inner join clientes on vendedores.idvendedor = clientes.idvendedor "
lcSql = lcSql + "   	  inner join cc_cli cc on clientes.idcliente = cc.idcliente "
lcSql = lcSql + " 	left join ( SELECT cc2.idoper, ROUND(SUM(cc2.impdebe - cc2.imphaber),2) as SaldoTot "
lcSql = lcSql + " 				FROM cc_cli cc2 "
lcSql = lcSql + " 				WHERE cc2.idcliente >= " + ALLTRIM(STR(lnIdCliDesde)) + " and cc2.idcliente <= " +  ALLTRIM(STR(lnIdCliHasta)) + " "
lcSql = lcSql + "         			and (cc2.usubaja is null or cc2.usubaja = '') "
lcSql = lcSql + "         			and idoper != 0 "
lcSql = lcSql + "         		GROUP BY cc2.idoper) AS Saldos ON cc.idoper = Saldos.idoper "
lcSql = lcSql + " WHERE       clientes.idcliente >= " + ALLTRIM(STR(lnIdCliDesde)) + " and clientes.idcliente <= " +  ALLTRIM(STR(lnIdCliHasta)) + " "
lcSql = lcSql + " 			  and clientes.idvendedor >= " + ALLTRIM(STR(lnIdVendDesde)) + " and clientes.idvendedor <= " +  ALLTRIM(STR(lnIdVendHasta)) + " "
&&lcSql = lcSql + "		  	  and clientes.idCondPago <> 1 "

IF INT(VAL(getConfig("SQLSRV"))) = 1 THEN
	lcSql = lcSql + "         and CONVERT(CHAR(8), fecemis, 112) between " + lcFecEmisDesde + " and " + lcFecEmisHasta + " "
ELSE
	lcSql = lcSql + "         and CAST(fecemis AS DATE) between " + lcFecEmisDesde + " and " + lcFecEmisHasta + " "
ENDIF

lcSql = lcSql + "         and (cc.usubaja is null or cc.usubaja = '') "
lcSql = lcSql + "         and (SaldoTot <> 0 or SaldoTot is null) "
lcSql = lcSql + "         and cbte = 'FC' "
lcSql = lcSql + " ORDER BY idvendedor, idcliente, fecemis, idoper, nrocbte"	

loResult.ActiveConnection = goConn.ActiveConnection
loResult.cursor_name = "cur_tempo"
loResult.OpenQuery(lcSql) 

SELECT cur_tempo
IF RECCOUNT() > 0      
 GO TOP 
ENDIF
 
SELECT cur_fcsaldos
ZAP

SELECT cur_tempo
DO WHILE !EOF()
	SELECT cur_fcsaldos
	APPEND BLANK
	REPLACE CodVend WITH cur_tempo.idvendedor
	REPLACE Nombre WITH cur_tempo.nombre ADDITIVE
	REPLACE Codigo WITH cur_tempo.idcliente ADDITIVE
	REPLACE RazSoc WITH cur_tempo.razsoc ADDITIVE
	REPLACE telefono WITH cur_tempo.telefono ADDITIVE 
	REPLACE email WITH cur_tempo.email ADDITIVE 
	REPLACE idoper WITH cur_tempo.idoper ADDITIVE 
	REPLACE observ WITH IIF(ISNULL(cur_tempo.observ), "", cur_tempo.observ) ADDITIVE
	REPLACE fecemis WITH cur_tempo.fecemis ADDITIVE
	REPLACE cbte WITH cur_tempo.cbte ADDITIVE 
	REPLACE tipodoc WITH cur_tempo.tipodoc ADDITIVE
	REPLACE numCbte WITH getPtoVta(cur_tempo.ptoVta) + "-" + getNroCbte(cur_tempo.nroCbte) ADDITIVE
   	REPLACE debe WITH cur_tempo.debe ADDITIVE
   	REPLACE haber WITH cur_tempo.haber ADDITIVE   
	REPLACE saldo WITH cur_tempo.saldo ADDITIVE 
	REPLACE saldotot WITH cur_tempo.saldotot ADDITIVE 
	
	SELECT cur_tempo
	SKIP 
ENDDO 

loResult.close_query()

SELECT cur_fcsaldos
IF RECCOUNT() > 0
	GO top
ELSE 
	RETURN .F.
ENDIF 

&& Busco los registros con idoper en cero y les asigno un valor para que salgan correctamente en el listado
lcSql = "SELECT MAX(idoper) AS maxidoper FROM cc_cli"

loResult.ActiveConnection = goConn.ActiveConnection
loResult.cursor_name = "cur_max"
loResult.OpenQuery(lcSql) 

lnmaxidoper = cur_max.maxidoper

SELECT cur_fcsaldos
DO WHILE !EOF()
	
	IF cur_fcsaldos.idoper = 0
		lnmaxidoper = lnmaxidoper + 1
	
		SELECT cur_fcsaldos
		REPLACE idoper WITH lnmaxidoper
	ENDIF 
	
	SELECT cur_fcsaldos
	SKIP 
ENDDO 

loResult.close_query()

RETURN .T.
ENDPROC
PROCEDURE saldosparc
PARAMETERS lnIdCliDesde, lnIdCliHasta, lcFecEmisDesde, lcFecEmisHasta, lnIdVendDesde, lnIdVendHasta

LOCAL loRes
LOCAL loRSA
LOCAL lcSql
LOCAL lnSaldo
LOCAL lnIdCliAnt

loRes = CREATEOBJECT("odbc_result")
loRSA = CREATEOBJECT("odbc_result")
lcSql = ""
lnIdCliAnt = 0
lnSaldo = 0.00 

&& Calculo el saldo anterior
lcSql = "SELECT cc.idCliente, "
lcSql = lcSql + "MAX(clientes.razSoc) AS razSoc, "
IF INT(VAL(getConfig("SQLSRV"))) = 1 THEN
	lcSql = lcSql + "ISNULL(ROUND(SUM(cc.impDebe - cc.impHaber),2), 0) AS saldo "
ELSE
	lcSql = lcSql + "IFNULL(ROUND(SUM(cc.impDebe - cc.impHaber),2), 0) AS saldo "
ENDIF
lcSql = lcSql + "FROM cc_cli cc "
lcSql = lcSql + "  INNER JOIN clientes ON clientes.idCliente = cc.idCliente "
lcSql = lcSql + "WHERE  clientes.idcliente >= " + ALLTRIM(STR(lnIdCliDesde)) + " and clientes.idcliente <= " +  ALLTRIM(STR(lnIdCliHasta)) + " "
lcSql = lcSql + " 	AND clientes.idvendedor >= " + ALLTRIM(STR(lnIdVendDesde)) + " and clientes.idvendedor <= " +  ALLTRIM(STR(lnIdVendHasta)) + " "
lcSql = lcSql + "   AND (cc.usubaja is null or cc.usubaja = '') "
&&lcSql = lcSql + "	AND clientes.idCondPago <> 1 "

IF INT(VAL(getConfig("SQLSRV"))) = 1 THEN
	lcSql = lcSql + " AND CONVERT(CHAR(8), fecemis, 112) < " + lcFecEmisDesde + " "
ELSE
	lcSql = lcSql + " AND CAST(fecemis AS DATE) < " + lcFecEmisDesde + " "
ENDIF

lcSql = lcSql + "GROUP BY idCliente "
lcSql = lcSql + "ORDER BY idCliente "

loRSA.ActiveConnection = goConn.ActiveConnection
loRSA.Cursor_Name = "cur_sa"

IF !loRSA.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_sa
GO TOP

lcSql = " SELECT  vendedores.idvendedor, "
lcSql = lcSql + " MAX(vendedores.nombre) AS nombre, "
lcSql = lcSql + " clientes.idCliente, "
lcSql = lcSql + " MAX(clientes.razsoc) AS razsoc, "
lcSql = lcSql + " MAX(cc.observ) AS observ, "
lcSql = lcSql + " MAX(cc.fecemis) AS fecemis, "
lcSql = lcSql + " MAX(cc.fecVto) AS fecVto, "
lcSql = lcSql + " cc.cbte, "
lcSql = lcSql + " cc.tipoDoc, "
lcSql = lcSql + " cc.ptoVta, "
lcSql = lcSql + " cc.nroCbte, "
lcSql = lcSql + " ROUND(SUM(cc.impdebe),2) AS Debe, "
lcSql = lcSql + " ROUND(SUM(cc.imphaber),2) AS Haber, "
lcSql = lcSql + " ROUND(SUM(cc.impdebe - cc.imphaber),2) AS Saldo "
lcSql = lcSql + "FROM vendedores inner join clientes on vendedores.idvendedor = clientes.idvendedor	"
lcSql = lcSql + "	INNER JOIN cc_cli cc ON clientes.idCliente = cc.idCliente "
lcSql = lcSql + " WHERE       clientes.idcliente >= " + ALLTRIM(STR(lnIdCliDesde)) + " and clientes.idcliente <= " +  ALLTRIM(STR(lnIdCliHasta)) + " "
lcSql = lcSql + " 	AND clientes.idvendedor >= " + ALLTRIM(STR(lnIdVendDesde)) + " and clientes.idvendedor <= " +  ALLTRIM(STR(lnIdVendHasta)) + " "
lcSql = lcSql + "   AND (cc.usubaja is null or cc.usubaja = '') "
&&lcSql = lcSql + "	AND clientes.idCondPago <> 1 "

IF INT(VAL(getConfig("SQLSRV"))) = 1 THEN
	lcSql = lcSql + "     AND CONVERT(CHAR(8), fecemis, 112) between " + lcFecEmisDesde + " and " + lcFecEmisHasta + " "
ELSE
	lcSql = lcSql + "     AND CAST(fecemis AS DATE) between " + lcFecEmisDesde + " and " + lcFecEmisHasta + " "
ENDIF

lcSql = lcSql + " GROUP BY vendedores.idvendedor, "
lcSql = lcSql + " 	clientes.idCliente, "
lcSql = lcSql + " 	cc.cbte, "
lcSql = lcSql + " 	cc.tipoDoc, "
lcSql = lcSql + " 	cc.ptoVta, "
lcSql = lcSql + " 	cc.nroCbte "
lcSql = lcSql + " ORDER BY clientes.idvendedor, clientes.idcliente, fecEmis, nroCbte"
_cliptext = lcSql
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_tempo"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_tempo
IF RECCOUNT() > 0      
 GO TOP 
ENDIF

SELECT cur_saldoparc
ZAP

DO WHILE !EOF("cur_tempo")
	IF lnIdCliAnt <> cur_tempo.idCliente THEN
		SELECT cur_sa
		GO TOP
		LOCATE FOR cur_sa.idCliente = cur_tempo.idCliente
		
		IF FOUND() .AND. (cur_sa.saldo <> 0) THEN
			SELECT cur_saldoparc
			APPEND BLANK
			
			REPLACE CodVend WITH cur_tempo.idvendedor 
			REPLACE Nombre WITH cur_tempo.nombre ADDITIVE
			REPLACE Codigo WITH cur_sa.idCliente ADDITIVE
			REPLACE razSoc WITH cur_sa.razSoc ADDITIVE
			REPLACE fecEmis WITH NULL ADDITIVE
			REPLACE fecVto WITH NULL ADDITIVE
			REPLACE cbte WITH "SAA" ADDITIVE
			REPLACE tipoDoc WITH "" ADDITIVE
			REPLACE numCbte WITH "Saldo Ant." ADDITIVE
			
			IF (cur_sa.saldo > 0) THEN
				REPLACE	Debe WITH cur_sa.saldo ADDITIVE
			ELSE
				REPLACE Haber WITH cur_sa.saldo * -1 ADDITIVE
			ENDIF
			
			REPLACE saldo WITH cur_sa.saldo ADDITIVE
		
*!*				lnSaldo = cur_sa.saldo
*!*			ELSE
*!*				lnSaldo = 0
*!*			ENDIF
*!*		
*!*			IF cur_tempo.Debe <> 0 THEN
*!*				lnSaldo = lnSaldo + cur_tempo.Debe
*!*			ELSE
*!*				lnSaldo = lnSaldo - cur_tempo.Haber
*!*			ENDIF
*!*		ELSE
*!*			IF cur_tempo.Debe <> 0 THEN
*!*				lnSaldo = lnSaldo + cur_tempo.Debe
*!*			ELSE
*!*				lnSaldo = lnSaldo - cur_tempo.Haber
		ENDIF
	ENDIF

	SELECT cur_saldoparc
	APPEND BLANK
	
	REPLACE CodVend WITH cur_tempo.idvendedor 
	REPLACE Nombre WITH cur_tempo.nombre ADDITIVE
	REPLACE Codigo WITH cur_tempo.idCliente ADDITIVE
	REPLACE razSoc WITH cur_tempo.razSoc ADDITIVE
	REPLACE observ WITH IIF(ISNULL(cur_tempo.observ), "", cur_tempo.observ) ADDITIVE
	REPLACE fecEmis WITH IIF(ISNULL(cur_tempo.fecEmis), "-", cur_tempo.fecEmis) ADDITIVE
	REPLACE fecVto WITH IIF(ISNULL(cur_tempo.fecVto ), "-", cur_tempo.fecVto ) ADDITIVE
	REPLACE cbte WITH cur_tempo.cbte ADDITIVE
	REPLACE tipoDoc WITH cur_tempo.tipoDoc ADDITIVE
	REPLACE numCbte WITH getPtoVta(cur_tempo.ptoVta) + "-" + getNroCbte(cur_tempo.nroCbte) ADDITIVE	
	REPLACE Debe WITH cur_tempo.Debe ADDITIVE
	REPLACE Haber WITH cur_tempo.Haber ADDITIVE	
	REPLACE saldo WITH cur_tempo.Saldo ADDITIVE
	
	lnIdCliAnt = cur_tempo.idcliente
	
	SELECT cur_tempo
	SKIP
ENDDO

loRSA.Close_Query()
loRes.Close_Query()

SELECT cur_saldoparc
IF RECCOUNT() > 0
	GO top
ELSE 
	RETURN .F.
ENDIF 

RETURN .T.
ENDPROC
PROCEDURE saldos_mora
PARAMETERS tnIdClienteDD, tnIdClienteHH, ;
	tnIdVendedorDD, tnIdVendedorHH, ;
	tnIdLocalidDD, tnIdLocalidHH

LOCAL loRsSDM	&& Conjunto de resultado saldo morosos
LOCAL lcSql

loRsSDM = CREATEOBJECT("odbc_result")
lcSql = ""

SELECT cur_salmora
ZAP

&& Ejecuto el SP que trae la información armada para presentar en el report
lcSql = "CALL cccli_getSaldoMoroso (?tnIdClienteDD, ?tnIdClienteHH, ?tnIdVendedorDD, ?tnIdVendedorHH, ?tnIdLocalidadDD, ?tnIdLocalidadHH);"
lcSql = loRsSDM.AddParameter(lcSql, "tnIdClienteDD", ALLTRIM(STR(tnIdClienteDD)), .f., .f.)
lcSql = loRsSDM.AddParameter(lcSql, "tnIdClienteHH", ALLTRIM(STR(tnIdClienteHH)), .f., .f.)
lcSql = loRsSDM.AddParameter(lcSql, "tnIdVendedorDD", ALLTRIM(STR(tnIdVendedorDD)), .f., .f.)
lcSql = loRsSDM.AddParameter(lcSql, "tnIdVendedorHH", ALLTRIM(STR(tnIdVendedorHH)), .f., .f.)
lcSql = loRsSDM.AddParameter(lcSql, "tnIdLocalidadDD", ALLTRIM(STR(tnIdLocalidDD)), .f., .f.)
lcSql = loRsSDM.AddParameter(lcSql, "tnIdLocalidadHH", ALLTRIM(STR(tnIdLocalidHH)), .f., .f.)

loRsSDM.ActiveConnection = goConn.ActiveConnection
loRsSDM.Cursor_Name = "cur_sdm"
IF !loRsSDM.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRsSDM.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

&& Cargo todos los registros que se detectaron con saldo morosos.
SELECT cur_sdm
GO TOP
DO WHILE !EOF("cur_sdm")
	SELECT cur_salmora
	APPEND BLANK
	REPLACE cur_salmora.idCliente WITH cur_sdm.idCliente
	REPLACE cur_salmora.razSoc WITH cur_sdm.razSoc ADDITIVE
	REPLACE cur_salmora.idLocalid WITH cur_sdm.idLocalid ADDITIVE
	REPLACE cur_salmora.codPostal WITH cur_sdm.codPostal ADDITIVE
	REPLACE cur_salmora.localidad WITH cur_sdm.localidad ADDITIVE
	REPLACE cur_salmora.telefono WITH cur_sdm.telefono ADDITIVE
	REPLACE cur_salmora.mail WITH cur_sdm.mail ADDITIVE
	REPLACE cur_salmora.sdmoro WITH cur_sdm.saldo ADDITIVE
	REPLACE cur_salmora.diasmo WITH cur_sdm.dias ADDITIVE
	REPLACE cur_salmora.sdactu WITH cur_sdm.saldo_actual ADDITIVE

	SELECT cur_sdm
	SKIP
ENDDO
loRsSDM.Close_Query()

RETURN .T.
ENDPROC
PROCEDURE Load
DODEFAULT()

CREATE CURSOR cur_resumen(;
	CodVend			int,;
	Nombre			C(60),;	
	Codigo			int,;
	RazSoc			C(60),;
	Localidad		C(60) NULL,;
	CodPostal		C(10) NULL,;
	idLocalid		int,;
	Telefono		C(20) NULL,;
	Email			C(60) NULL,;
	Saldo			float(10,2))
	
CREATE CURSOR cur_todosmov(;
	CodVend			int,;
	Nombre			C(60),;	
	Codigo			int,;
	RazSoc			C(60),;
	Telefono		C(20) NULL,;
	Email			C(60) NULL,;
	Idoper			int,;
	observ			varchar(100),;
	FecEmis			datetime,;
	Fecha			datetime,;
	Cbte			C(3),;
	TipoDoc			C(1),;
	NumCbte			C(14),;
	Debe			float(10,2),;
	Haber			float(10,2),;
	Saldo			float(10,2))
			
CREATE CURSOR cur_fcsaldos(;
	CodVend			int,;
	Nombre			C(60),;	
	Codigo			int,;
	RazSoc			C(60),;
	Telefono		C(20) NULL,;
	Email			C(60) NULL,;
	Idoper			int,;
	observ			varchar(100),;
	FecEmis			datetime,;
	Cbte			C(3),;
	TipoDoc			C(1),;
	NumCbte			C(14),;
	Debe			float(10,2),;
	Haber			float(10,2),;
	Saldo			float(10,2),;
	SaldoTot		float(10,2))
	
CREATE CURSOR cur_saldoparc ( ;
	CodVend		int,;
	Nombre		varchar(60),;	
	Codigo		int,;
	razSoc		varchar(60),;
	observ		varchar(100),;	
	fecEmis		datetime NULL,;
	fecVto		datetime NULL,;
	cbte		varchar(3),;
	tipoDoc		varchar(1),;
	NumCbte		varchar(14),;
	Debe		float(10,2),;
	Haber		float(10,2),;
	saldo		float(10,2))

CREATE CURSOR cur_salmora ( ;
	idCliente int,;
	razSoc varchar(60),;
	idLocalid int,;
	codPostal varchar(10),;
	localidad varchar(60),;
	telefono varchar(20),;
	mail varchar(60),;
	sdmoro double,;
	diasmo double,;
	sdactu double)
		
SELECT cur_todosmov
INDEX ON CodVend TAG CodVend ASCENDING
INDEX ON Nombre TAG Nombre ASCENDING ADDITIVE
INDEX ON Codigo	TAG Codigo ASCENDING ADDITIVE  
INDEX ON RazSoc TAG RazSoc ASCENDING ADDITIVE
INDEX ON Telefono TAG Telefono ASCENDING ADDITIVE
INDEX ON Email TAG Email ASCENDING ADDITIVE
INDEX ON Idoper TAG Idoper ASCENDING ADDITIVE
INDEX ON FecEmis TAG FecEmis ASCENDING ADDITIVE
INDEX ON Fecha TAG Fecha ASCENDING ADDITIVE
INDEX ON Cbte TAG Cbte ASCENDING ADDITIVE
INDEX ON TipoDoc TAG TipoDoc ASCENDING ADDITIVE
INDEX ON NumCbte TAG NumCbte ASCENDING ADDITIVE
INDEX ON Debe TAG Debe ASCENDING ADDITIVE
INDEX ON Haber TAG Haber ASCENDING ADDITIVE
INDEX ON Saldo TAG Saldo ASCENDING ADDITIVE

SELECT cur_fcsaldos
INDEX ON CodVend TAG CodVend ASCENDING
INDEX ON Nombre TAG Nombre ASCENDING ADDITIVE
INDEX ON Codigo	TAG Codigo ASCENDING ADDITIVE
INDEX ON RazSoc TAG RazSoc ASCENDING ADDITIVE
INDEX ON Telefono TAG Telefono ASCENDING ADDITIVE
INDEX ON Email TAG Email ASCENDING ADDITIVE
INDEX ON Idoper TAG Idoper ASCENDING ADDITIVE
INDEX ON FecEmis TAG FecEmis ASCENDING ADDITIVE
INDEX ON Cbte TAG Cbte ASCENDING ADDITIVE
INDEX ON TipoDoc TAG TipoDoc ASCENDING ADDITIVE
INDEX ON NumCbte TAG NumCbte ASCENDING ADDITIVE
INDEX ON Debe TAG Debe ASCENDING ADDITIVE
INDEX ON Haber TAG Haber ASCENDING ADDITIVE
INDEX ON Saldo TAG Saldo ASCENDING ADDITIVE

SELECT cur_resumen
SET ORDER to tag codvend ASCENDING 

SELECT cur_todosmov
SET ORDER to tag codvend ASCENDING 

SELECT cur_fcsaldos
SET ORDER to tag codvend ASCENDING 

SELECT cur_saldoparc 
SET ORDER to tag codvend ASCENDING 
ENDPROC
PROCEDURE Init

thisform.contenedor.contenedor1.sel_ClienteDesde.txtCodigo.Enabled = .F.
thisform.contenedor.contenedor1.sel_ClienteHasta.txtCodigo.Enabled = .F.

thisform.contenedor.contenedor4.sel_VendDesde.txtCodigo.Enabled = .F.
thisform.contenedor.contenedor4.sel_VendHasta.txtCodigo.Enabled = .F.

thisform.contenedor.contenedor3.txtFecemisdesde.Value = DATE(2013,01,01)
thisform.contenedor.contenedor3.txtFecEmisHasta.Value = DATE()

thisform.contenedor.contenedor3.txtFecEmisDesde.Enabled = .T.
thisform.contenedor.contenedor3.txtFecEmisHasta.Enabled = .T.
ENDPROC


************************************************************
OBJETO: Contenedor
************************************************************
*** PROPIEDADES ***
Top = 4
Left = 4
Width = 718
Height = 375
BackColor = 241,236,235
Name = "Contenedor"

*** METODOS ***


************************************************************
OBJETO: CLSETIQUETA1
************************************************************
*** PROPIEDADES ***
Caption = "Clientes"
Left = 15
Top = 9
Name = "CLSETIQUETA1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Tipo de Listado"
Left = 15
Top = 190
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Fecha"
Height = 15
Left = 14
Top = 263
Width = 42
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clscerrar1
************************************************************
*** PROPIEDADES ***
Top = 324
Left = 665
TabIndex = 23
Name = "Clscerrar1"

*** METODOS ***


************************************************************
OBJETO: Clscancelar1
************************************************************
*** PROPIEDADES ***
Top = 324
Left = 14
TabIndex = 22
Name = "Clscancelar1"

*** METODOS ***
PROCEDURE Click
thisform.limpiar()
ENDPROC


************************************************************
OBJETO: Contenedor1
************************************************************
*** PROPIEDADES ***
Top = 27
Left = 13
Width = 696
Height = 63
TabIndex = 17
TabStop = .T.
BackColor = 240,240,240
BorderColor = 192,192,192
Name = "Contenedor1"

*** METODOS ***


************************************************************
OBJETO: sel_ClienteDesde
************************************************************
*** PROPIEDADES ***
Top = 4
Left = 206
TabIndex = 3
cfieldname = idcliente
nombre_campo_codigo = idcliente
nombre_campo_desc = razsoc
nombre_tabla = clientes
esnumerico = .T.
pkfield = idcliente
Name = "sel_ClienteDesde"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: Sel_ClienteHasta
************************************************************
*** PROPIEDADES ***
Top = 34
Left = 206
TabIndex = 4
esnumerico = .T.
nombre_campo_codigo = idcliente
nombre_campo_desc = razsoc
nombre_tabla = clientes
pkfield = idcliente
cfieldname = idcliente
Name = "Sel_ClienteHasta"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Desde:"
Height = 15
Left = 153
Top = 11
Width = 48
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Hasta:"
Height = 15
Left = 153
Top = 40
Width = 36
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Contenedor2
************************************************************
*** PROPIEDADES ***
Top = 208
Left = 13
Width = 696
Height = 52
TabIndex = 18
TabStop = .T.
BackColor = 240,240,240
BorderColor = 192,192,192
Name = "Contenedor2"

*** METODOS ***


************************************************************
OBJETO: Optiongroup2
************************************************************
*** PROPIEDADES ***
ButtonCount = 6
BorderStyle = 0
Value = 1
Height = 46
Left = 11
Top = 3
Width = 681
Name = "Optiongroup2"
Option1.FontBold = .T.
Option1.Caption = "Comprobantes con Saldo"
Option1.Value = 1
Option1.Height = 17
Option1.Left = 105
Option1.TabIndex = 6
Option1.TabStop = .T.
Option1.Top = 3
Option1.Width = 182
Option1.Name = "optCompSaldos"
Option2.FontBold = .T.
Option2.Caption = "Todos los movimientos"
Option2.Height = 17
Option2.Left = 520
Option2.TabIndex = 8
Option2.TabStop = .T.
Option2.Top = 3
Option2.Width = 156
Option2.Name = "optMov"
Option3.FontBold = .T.
Option3.Caption = "Resumen"
Option3.Height = 17
Option3.Left = 4
Option3.TabIndex = 5
Option3.Top = 3
Option3.Width = 98
Option3.Name = "optResumen"
Option4.FontBold = .T.
Option4.Caption = "Facturas Vencidas con Saldo"
Option4.Height = 17
Option4.Left = 304
Option4.TabIndex = 7
Option4.Top = 3
Option4.Width = 187
Option4.Name = "optFactSaldos"
Option5.FontBold = .T.
Option5.Caption = "Saldos Parciales"
Option5.Height = 17
Option5.Left = 4
Option5.Top = 27
Option5.Width = 172
Option5.Name = "optSaldoParcial"
Option6.FontBold = .T.
Option6.Caption = "Resumen con saldos morosos"
Option6.Height = 17
Option6.Left = 143
Option6.Top = 26
Option6.Width = 201
Option6.Name = "optSaldosMorosos"

*** METODOS ***
PROCEDURE optCompSaldos.Click
IF this.Value = 1
	thisform.contenedor.contenedor3.txtFecEmisDesde.Enabled = .T.
	thisform.contenedor.contenedor3.txtFecEmisHasta.Enabled = .T.
ENDIF
ENDPROC
PROCEDURE optMov.Click
IF this.Value = 1
	thisform.contenedor.contenedor3.txtFecEmisDesde.Enabled = .T.
	thisform.contenedor.contenedor3.txtFecEmisHasta.Enabled = .T.
ENDIF
ENDPROC
PROCEDURE optResumen.Click
IF this.Value = 1
	thisform.contenedor.contenedor3.txtFecEmisDesde.Enabled = .F.
	thisform.contenedor.contenedor3.txtFecEmisHasta.Enabled = .T.
ENDIF
ENDPROC
PROCEDURE optFactSaldos.Click
IF this.Value = 1
	thisform.contenedor.contenedor3.txtFecEmisDesde.Enabled = .T.
	thisform.contenedor.contenedor3.txtFecEmisHasta.Enabled = .T.
ENDIF
ENDPROC
PROCEDURE optSaldoParcial.Click
IF this.Value = 1
	thisform.contenedor.contenedor3.txtFecEmisDesde.Enabled = .T.
	thisform.contenedor.contenedor3.txtFecEmisHasta.Enabled = .T.
ENDIF
ENDPROC
PROCEDURE optSaldosMorosos.Click
IF this.Value = 1
	thisform.contenedor.contenedor3.txtFecEmisDesde.Enabled = .F.
	thisform.contenedor.contenedor3.txtFecEmisHasta.Enabled = .F.
ENDIF
ENDPROC


************************************************************
OBJETO: Contenedor3
************************************************************
*** PROPIEDADES ***
Top = 281
Left = 14
Width = 334
Height = 34
TabIndex = 19
TabStop = .T.
BackColor = 240,240,240
BorderColor = 192,192,192
Name = "Contenedor3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Desde:"
Height = 15
Left = 10
Top = 11
Width = 48
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Hasta:"
Height = 15
Left = 182
Top = 11
Width = 36
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: txtFecEmisDesde
************************************************************
*** PROPIEDADES ***
Left = 58
TabIndex = 9
Top = 7
isdatetime = .T.
Name = "txtFecEmisDesde"

*** METODOS ***


************************************************************
OBJETO: txtFecEmisHasta
************************************************************
*** PROPIEDADES ***
Left = 221
TabIndex = 10
Top = 7
isdatetime = .T.
Name = "txtFecEmisHasta"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Vendedores"
Height = 15
Left = 16
Top = 99
Width = 76
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: Contenedor4
************************************************************
*** PROPIEDADES ***
Top = 117
Left = 14
Width = 696
Height = 63
TabIndex = 17
TabStop = .T.
BackColor = 240,240,240
BorderColor = 192,192,192
Name = "Contenedor4"

*** METODOS ***


************************************************************
OBJETO: Sel_VendDesde
************************************************************
*** PROPIEDADES ***
Top = 4
Left = 206
TabIndex = 3
cfieldname = idvendedor
nombre_campo_codigo = idvendedor
nombre_campo_desc = nombre
nombre_tabla = vendedores
esnumerico = .T.
pkfield = idvendedor
Name = "Sel_VendDesde"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: Sel_VendHasta
************************************************************
*** PROPIEDADES ***
Top = 34
Left = 206
TabIndex = 4
esnumerico = .T.
nombre_campo_codigo = idvendedor
nombre_campo_desc = nombre
nombre_tabla = vendedores
pkfield = idvendedor
cfieldname = idvendedor
Name = "Sel_VendHasta"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Desde:"
Height = 15
Left = 153
Top = 11
Width = 48
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Hasta:"
Height = 15
Left = 153
Top = 40
Width = 36
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: ClsExcel
************************************************************
*** PROPIEDADES ***
Top = 324
Left = 61
TabIndex = 21
Name = "ClsExcel"

*** METODOS ***
PROCEDURE Click
LOCAL loDateTime, lcFecEmisDesde, lcFecEmisHasta, lnIdCliDesde, lnIdCliHasta, lnIdVendDesde, lnIdVendHasta

loDateTime = CREATEOBJECT("datetime")

lcFecEmisDesde = loDateTime.toMySql(thisform.contenedor.contenedor3.txtfecemisdesde.Value)
lcFecEmisHasta = loDateTime.toMySql(thisform.contenedor.contenedor3.txtFecEmisHasta.Value)

IF thisform.contenedor.contenedor1.sel_ClienteDesde.valcpoid <> 0 .AND. thisform.contenedor.contenedor1.sel_ClienteHasta.valcpoid <> 0
	lnIdCliDesde = thisform.contenedor.contenedor1.sel_ClienteDesde.valcpoid
	lnIdCliHasta = thisform.contenedor.contenedor1.sel_ClienteHasta.valcpoid
ELSE
	lnIdCliDesde = 0
	lnIdCliHasta = 999999
ENDIF

IF thisform.contenedor.contenedor4.sel_VendDesde.valcpoid <> 0 .AND. thisform.contenedor.contenedor4.sel_VendHasta.valcpoid <> 0
	lnIdVendDesde = thisform.contenedor.contenedor4.sel_VendDesde.valcpoid
	lnIdVendHasta = thisform.contenedor.contenedor4.sel_VendHasta.valcpoid
ELSE
	lnIdVendDesde = 0
	lnIdVendHasta = 999999
ENDIF

IF Thisform.contenedor.contenedor2.optiongroup2.optResumen.Value = 1
	IF Thisform.resumen(lnIdCliDesde, lnIdCliHasta, lnIdVendDesde, lnIdVendHasta, lcFecEmisHasta)
		SELECT cur_resumen
		genExcel("cur_resumen","Listado de Cuentas Corrientes (Resumen de Cuentas)")
	ELSE 
		MESSAGEBOX("No hay registros para exportar",0+48,"Listado de Cuentas Corrientes")
	ENDIF 
ENDIF

IF Thisform.contenedor.contenedor2.optiongroup2.optCompSaldos.Value = 1
	IF Thisform.cbtesconsaldos(lnIdCliDesde, lnIdCliHasta, lcFecEmisDesde, lcFecEmisHasta, lnIdVendDesde, lnIdVendHasta)
		SELECT cur_todosmov 
		genExcel("cur_todosmov","Listado de Cuentas Corrientes (Comprobantes con Saldo)")
	ELSE 
		MESSAGEBOX("No hay registros para exportar",0+48,"Listado de Cuentas Corrientes")
	ENDIF 
ENDIF

IF Thisform.contenedor.contenedor2.optiongroup2.optFactSaldos.Value = 1
	IF Thisform.fcconsaldos(lnIdCliDesde, lnIdCliHasta, lcFecEmisDesde, lcFecEmisHasta, lnIdVendDesde, lnIdVendHasta)
		SELECT cur_fcsaldos
		genExcel("cur_fcsaldos","Listado de Cuentas Corrientes (Facturas con Saldo)")
	ELSE 
		MESSAGEBOX("No hay registros para exportar",0+48,"Listado de Cuentas Corrientes")
	ENDIF 
ENDIF

IF Thisform.contenedor.contenedor2.optiongroup2.optMov.Value = 1
	IF Thisform.todosmov(lnIdCliDesde, lnIdCliHasta, lcFecEmisDesde, lcFecEmisHasta, lnIdVendDesde, lnIdVendHasta)
		SELECT cur_todosmov 
		genExcel("cur_todosmov","Listado de Cuentas Corrientes (Todos los Movimientos)")
	ELSE 
		MESSAGEBOX("No hay registros para exportar",0+48,"Listado de Cuentas Corrientes")
	ENDIF 
ENDIF

IF Thisform.contenedor.contenedor2.optiongroup2.optSaldoParcial.Value = 1
	IF Thisform.saldosparc(lnIdCliDesde, lnIdCliHasta, lcFecEmisDesde, lcFecEmisHasta, lnIdVendDesde, lnIdVendHasta)
		SELECT cur_saldoparc 
		genExcel("cur_saldoparc","Listado de Cuentas Corrientes (Saldos Parciales)")
	ELSE 
		MESSAGEBOX("No hay registros para exportar",0+48,"Listado de Cuentas Corrientes")
	ENDIF 
ENDIF
ENDPROC


************************************************************
OBJETO: ClsImprimir
************************************************************
*** PROPIEDADES ***
Top = 324
Left = 108
TabIndex = 20
Name = "ClsImprimir"

*** METODOS ***
PROCEDURE Click
LOCAL loDateTime, lcFecEmisDesde, lcFecEmisHasta, lnIdCliDesde, lnIdCliHasta, lnIdVendDesde, lnIdVendHasta
LOCAL m.fecha, m.clidesde, m.clihasta, m.femisd, m.femish, m.titulo, m.tipolistado, m.venddesde, m.vendhasta
LOCAL lcFileName, lcReportName, lcCursorName, lcMailMsg, lcMailFC
LOCAL loRes, lcSql, lcNomEmp

loDateTime = CREATEOBJECT("datetime")
loRes = CREATEOBJECT("odbc_result")
lcFileName = ""
lcReportName = ""
lcCursorName = ""
lcMailMsg = ""
lcMailFC = ""
lcSql = ""
lcNomEmp = getconfig("NOMEMP")

lcFecEmisDesde = loDateTime.toMySql(thisform.contenedor.contenedor3.txtfecemisdesde.Value)
lcFecEmisHasta = loDateTime.toMySql(thisform.contenedor.contenedor3.txtFecEmisHasta.Value)

IF thisform.contenedor.contenedor1.sel_ClienteDesde.valcpoid <> 0 .AND. ;
	thisform.contenedor.contenedor1.sel_ClienteHasta.valcpoid <> 0
	lnIdCliDesde = thisform.contenedor.contenedor1.sel_ClienteDesde.valcpoid
	lnIdCliHasta = thisform.contenedor.contenedor1.sel_ClienteHasta.valcpoid
ELSE
	lnIdCliDesde = 0
	lnIdCliHasta = 999999
ENDIF

IF Thisform.Contenedor.chkEnviarMail.Value = 1 THEN
	IF lnIdCliDesde <> lnIdCliHasta THEN
		MESSAGEBOX("Para enviar mail el cliente desde y hasta no puede ser distintos", 0+48, Thisform.Caption)
		RETURN
	ENDIF
ENDIF

IF thisform.contenedor.contenedor4.sel_VendDesde.valcpoid <> 0 .AND. ;
	thisform.contenedor.contenedor4.sel_VendHasta.valcpoid <> 0
	lnIdVendDesde = thisform.contenedor.contenedor4.sel_VendDesde.valcpoid
	lnIdVendHasta = thisform.contenedor.contenedor4.sel_VendHasta.valcpoid
ELSE
	lnIdVendDesde = 0
	lnIdVendHasta = 999999
ENDIF

m.fecha = DATETIME()
m.venddesde = lnIdVendDesde
m.vendhasta = lnIdVendHasta
m.clidesde = lnIdCliDesde
m.clihasta = lnIdCliHasta
m.femisd = thisform.contenedor.contenedor3.txtFecEmisDesde.Value
m.femish = thisform.contenedor.contenedor3.txtFecEmisHasta.Value
m.titulo = "Listado de Cuentas Corrientes"

IF Thisform.contenedor.contenedor2.optiongroup2.optResumen.Value = 1
	IF Thisform.resumen(lnIdCliDesde, lnIdCliHasta, lnIdVendDesde, lnIdVendHasta, lcFecEmisHasta)
		m.tipolistado = "Resumen de cuentas"
		IF Thisform.Contenedor.chkEnviarMail.Value = 0 THEN
			SELECT cur_resumen
			REPORT FORM repctacteresumen TO PRINTER PROMPT PREVIEW
		ELSE
			lcCursorName = "cur_resumen"
			lcReportName = "repctacteresumen"
			lcFileName = SYS(5) + SYS(2003) + "\wsafip\ComprobantesPDF\Resumen" + ;
				ALLTRIM(STR(lnIdCliDesde)) + "_" + STRTRAN(DTOC(DATE()),"/", "") + ".pdf"
		ENDIF
	ELSE 
		MESSAGEBOX("No hay registros para mostrar",0+64,"Listado de Cuentas Corrientes")
	ENDIF 
ENDIF

IF Thisform.contenedor.contenedor2.optiongroup2.optCompSaldos.Value = 1
	IF Thisform.cbtesconsaldos(lnIdCliDesde, lnIdCliHasta, lcFecEmisDesde, lcFecEmisHasta, lnIdVendDesde, lnIdVendHasta)
		m.tipolistado = "Comprobantes con Saldo"
		IF Thisform.Contenedor.chkEnviarMail.Value = 0 THEN
			SELECT cur_todosmov 
			REPORT FORM repctactemov TO PRINTER PROMPT PREVIEW
		ELSE
			lcCursorName = "cur_todosmov"
			lcReportName = "repctactemov"
			lcFileName = SYS(5) + SYS(2003) + "\wsafip\ComprobantesPDF\CbteConSaldo" + ;
				ALLTRIM(STR(lnIdCliDesde)) + "_" + STRTRAN(DTOC(DATE()),"/", "") + ".pdf"
		ENDIF
	ELSE 
		MESSAGEBOX("No hay registros para mostrar",0+64,"Listado de Cuentas Corrientes")
	ENDIF 
ENDIF

IF Thisform.contenedor.contenedor2.optiongroup2.optFactSaldos.Value = 1
	IF Thisform.fcconsaldos(lnIdCliDesde, lnIdCliHasta, lcFecEmisDesde, lcFecEmisHasta, lnIdVendDesde, lnIdVendHasta)
		m.tipolistado = "Facturas Vencidas con Saldo"
		IF Thisform.Contenedor.chkEnviarMail.Value = 0 THEN
			SELECT cur_fcsaldos
			REPORT FORM repctactefcsaldos TO PRINTER PROMPT PREVIEW 
		ELSE
			lcCursorName = "cur_fcsaldos"
			lcReportName = "repctactefcsaldos"
			lcFileName = SYS(5) + SYS(2003) + "\wsafip\ComprobantesPDF\ctactefcsaldos" + ;
				ALLTRIM(STR(lnIdCliDesde)) + "_" + STRTRAN(DTOC(DATE()),"/", "") + ".pdf"
		ENDIF
	ELSE 
		MESSAGEBOX("No hay registros para mostrar",0+64,"Listado de Cuentas Corrientes")
	ENDIF 
ENDIF

IF Thisform.contenedor.contenedor2.optiongroup2.optMov.Value = 1
	IF Thisform.todosmov(lnIdCliDesde, lnIdCliHasta, lcFecEmisDesde, lcFecEmisHasta, lnIdVendDesde, lnIdVendHasta)
		m.tipolistado = "Todos los Movimientos"
		IF Thisform.Contenedor.chkEnviarMail.Value = 0 THEN
			SELECT cur_todosmov 
			REPORT FORM repctactemov TO PRINTER PROMPT PREVIEW 
		ELSE
			lcCursorName = "cur_todosmov"
			lcReportName = "repctactemov"
			lcFileName = SYS(5) + SYS(2003) + "\wsafip\ComprobantesPDF\ctactemov" + ;
				ALLTRIM(STR(lnIdCliDesde)) + "_" + STRTRAN(DTOC(DATE()),"/", "") + ".pdf"
		ENDIF
	ELSE 
		MESSAGEBOX("No hay registros para mostrar",0+64,"Listado de Cuentas Corrientes")
	ENDIF 
ENDIF

IF Thisform.contenedor.contenedor2.optionGroup2.optSaldoParcial.Value = 1 THEN
	IF Thisform.saldosparc(lnIdCliDesde, lnIdCliHasta, lcFecEmisDesde, lcFecEmisHasta, lnIdVendDesde, lnIdVendHasta) THEN
		m.tipolistado = "Saldos Parciales"
		IF Thisform.Contenedor.chkEnviarMail.Value = 0 THEN
			SELECT cur_saldoparc
			REPORT FORM rep_ctacte_saldoparc TO PRINTER PROMPT PREVIEW
		ELSE
			lcCursorName = "cur_saldoparc"
			lcReportName = "rep_ctacte_saldoparc"
			lcFileName = SYS(5) + SYS(2003) + "\wsafip\ComprobantesPDF\saldoparc" + ;
				ALLTRIM(STR(lnIdCliDesde)) + "_" + STRTRAN(DTOC(DATE()),"/", "") + ".pdf"
		ENDIF
	ELSE
		MESSAGEBOX("No hay registros para mostrar", 0+64, "Listado de Cuentas Corrientes")
	ENDIF
ENDIF

IF Thisform.Contenedor.Contenedor2.optiongroup2.optSaldosMorosos.Value = 1 THEN
	IF Thisform.saldos_mora(lnIdCliDesde, lnIdCliHasta, lnIdVendDesde, lnIdVendHasta, 0, 9999999) THEN
		IF Thisform.Contenedor.chkEnviarMail.Value = 0 THEN
			SELECT cur_salmora
			REPORT FORM rep_saldomora TO PRINTER PROMPT PREVIEW
		ELSE
			lcCursorName = "cur_salmora"
			lcReportName = "rep_saldomora"
			lcFileName = SYS(5) + SYS(2003) + "\wsafip\ComprobantesPDF\saldomora" + ;
				ALLTRIM(STR(lnIdCliDesde)) + "_" + STRTRAN(DTOC(DATE()),"/", "") + ".pdf"
		ENDIF
	ELSE
		MESSAGEBOX("No hay registros para mostrar", 0+64, "Listado de Cuentas Corrientes")
	ENDIF
ENDIF

IF Thisform.Contenedor.chkEnviarMail.Value = 1 THEN
	lcSql = "SELECT mailFC FROM clientes "
	lcSql = lcSql + " WHERE idCliente = " + ALLTRIM(STR(lnIdCliDesde))
	loRes.ActiveConnection = goConn.ActiveConnection
	loRes.Cursor_Name = "cur_x"
	IF !loRes.OpenQuery(lcSql) THEN
		MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	ELSE
		lcMailFC = ALLTRIM(cur_x.mailfc)
		
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
		SELECT (lcCursorName)
		REPORT FORM (lcReportName) NOCONSOLE TO PRINTER
		SET PRINTER TO DEFAULT
		SET CONSOLE ON
		
		WAIT WINDOW "El archivo PDF se está generando, aguarde unos segundos..." NOWAIT
		DO WHILE !FILE(lcFileName)
			
		ENDDO
		
		TEXT TO lcMailMsg NOSHOW
		Estimado cliente,
		
		Le adjuntamos el informe de cuentas corrientes de su cuenta en formato PDF.
		
		Muchas gracias!
		
		Saludos cordiales,
		
		ENDTEXT
		lcMailMsg = lcMailMsg + lcNomEmp

		&& Procedo a hacer el envío de mail
		DO LOCFILE("FoxyPreviewer.App")
		WITH _screen.oFoxyPreviewer	
			.cEmailType = "PDF"
			.nEmailMode = 2
			.cEMailTo = lcMailFC
			.cSMTPServer = "smtp.gmail.com"
			.cEmailFrom = lcNomEmp + "<noresponder.linfow@gmail.com>"
			.cEMailSubject = "Listado de Cuentas Corrientes"
			.nSMTPPort = 465
			.lSMTPUseSSL = .t.
			.cSMTPUserName = "noresponder.linfow@gmail.com"
			.cSMTPPassword = "22ldz904"
			.lReadReceipt  = .F.
			.lPriority = .F.
			.cEmailBody = lcMailMsg
			.SendEmailUsingCDO(lcFileName)
		ENDWITH
		DO LOCFILE("FoxyPreviewer.App") WITH "Release"
		
		loRes.Close_Query()
	ENDIF
ENDIF
ENDPROC


************************************************************
OBJETO: chkEnviarMail
************************************************************
*** PROPIEDADES ***
Top = 284
Left = 368
Height = 18
Width = 156
Alignment = 0
Caption = "Enviar el listado por mail."
Name = "chkEnviarMail"

*** METODOS ***


************************************************************
OBJETO: Optiongroup1
************************************************************
*** PROPIEDADES ***
ButtonCount = 2
BorderStyle = 0
Value = 1
Height = 58
Left = 27
Top = 33
Width = 71
Name = "Optiongroup1"
Option1.FontBold = .T.
Option1.Caption = "Todos"
Option1.Value = 1
Option1.Height = 17
Option1.Left = 5
Option1.TabStop = .T.
Option1.Top = 6
Option1.Width = 61
Option1.Name = "optCliTodos"
Option2.FontBold = .T.
Option2.Caption = "Filtrar"
Option2.Height = 17
Option2.Left = 5
Option2.TabStop = .T.
Option2.Top = 35
Option2.Width = 61
Option2.Name = "optCliFiltrar"

*** METODOS ***
PROCEDURE optCliTodos.Click
IF this.Value = 1
	thisform.contenedor.contenedor1.sel_ClienteDesde.txtCodigo.Enabled = .F.
	thisform.contenedor.contenedor1.sel_ClienteHasta.txtCodigo.Enabled = .F.	
	thisform.contenedor.contenedor1.sel_ClienteDesde.blanquear()
	thisform.contenedor.contenedor1.sel_ClienteHasta.blanquear()
	thisform.contenedor.contenedor1.sel_ClienteDesde.valcpoid = 0
	thisform.contenedor.contenedor1.sel_ClienteHasta.valcpoid = 0
ENDIF
ENDPROC
PROCEDURE optCliFiltrar.Click
IF this.Value = 1
	thisform.contenedor.contenedor1.sel_ClienteDesde.txtCodigo.Enabled = .T.
	thisform.contenedor.contenedor1.sel_ClienteHasta.txtCodigo.Enabled = .T.
	thisform.contenedor.contenedor1.sel_ClienteDesde.txtCODIGO.SetFocus()
ENDIF
ENDPROC


************************************************************
OBJETO: Optiongroup2
************************************************************
*** PROPIEDADES ***
ButtonCount = 2
BorderStyle = 0
Value = 1
Height = 58
Left = 27
Top = 123
Width = 71
Name = "Optiongroup2"
Option1.FontBold = .T.
Option1.Caption = "Todos"
Option1.Value = 1
Option1.Height = 17
Option1.Left = 5
Option1.TabStop = .T.
Option1.Top = 6
Option1.Width = 61
Option1.Name = "optCliTodos"
Option2.FontBold = .T.
Option2.Caption = "Filtrar"
Option2.Height = 17
Option2.Left = 5
Option2.TabStop = .T.
Option2.Top = 35
Option2.Width = 61
Option2.Name = "optCliFiltrar"

*** METODOS ***
PROCEDURE optCliTodos.Click
IF this.Value = 1
	thisform.contenedor.contenedor4.sel_VendDesde.txtCodigo.Enabled = .F.
	thisform.contenedor.contenedor4.sel_VendHasta.txtCodigo.Enabled = .F.	
	thisform.contenedor.contenedor4.sel_VendDesde.blanquear()
	thisform.contenedor.contenedor4.sel_VendHasta.blanquear()
	thisform.contenedor.contenedor4.sel_VendDesde.valcpoid = 0
	thisform.contenedor.contenedor4.sel_VendHasta.valcpoid = 0
ENDIF
ENDPROC
PROCEDURE optCliFiltrar.Click
IF this.Value = 1
	thisform.contenedor.contenedor4.sel_VendDesde.txtCodigo.Enabled = .T.
	thisform.contenedor.contenedor4.sel_VendHasta.txtCodigo.Enabled = .T.
	thisform.contenedor.contenedor4.sel_VendDesde.txtCODIGO.SetFocus()
ENDIF
ENDPROC


************************************************************
OBJETO: 
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 9, 6, 15, 12, 32, 3, 0

*** METODOS ***


