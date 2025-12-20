************************************************************
OBJETO: cls_form_rankings
************************************************************
*** PROPIEDADES ***
BorderStyle = 2
Height = 223
Width = 544
DoCreate = .T.
Caption = "Genrador de Rankings de Ventas"
Name = "cls_form_rankings"
contenido.Comment = ""
contenido.Name = "contenido"

*** METODOS ***
PROCEDURE Init
thisform.contenido.txtFecDesde.Value = DATE() -30
thisform.contenido.txtFecHasta.Value = DATE()
ENDPROC
PROCEDURE Load
DODEFAULT()

CREATE CURSOR cur_ranking (	;
	codigo		int,;
	anio		int,;
	mes			varchar(20),;
	descripcio	varchar(60),;
	importe		float(10,2),;
	porVta		float(10,2))


ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Generar ranking de:"
Height = 15
Left = 24
Top = 19
Width = 120
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: opt_group
************************************************************
*** PROPIEDADES ***
ButtonCount = 4
Height = 35
Left = 13
Top = 11
Width = 527
Name = "opt_group"
Option1.FontSize = 8
Option1.Caption = "Clientes"
Option1.Height = 16
Option1.Left = 132
Option1.Top = 8
Option1.Width = 72
Option1.ForeColor = 158,106,75
Option1.Name = "Option1"
Option2.FontSize = 8
Option2.Caption = "Proveedores"
Option2.Height = 16
Option2.Left = 214
Option2.Top = 8
Option2.Width = 92
Option2.ForeColor = 158,106,75
Option2.Name = "Option2"
Option3.FontBold = .T.
Option3.FontSize = 8
Option3.Caption = "Marcas"
Option3.Height = 17
Option3.Left = 317
Option3.Top = 8
Option3.Width = 65
Option3.ForeColor = 158,106,75
Option3.Name = "Option3"
Option4.FontBold = .T.
Option4.FontSize = 8
Option4.Caption = "Sub-Familia"
Option4.Height = 17
Option4.Left = 391
Option4.Top = 8
Option4.Width = 89
Option4.ForeColor = 158,106,75
Option4.Name = "Option4"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Fecha desde:"
Height = 15
Left = 13
Top = 61
Width = 81
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Fecha Hasta:"
Height = 15
Left = 202
Top = 61
Width = 74
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: txtFecDesde
************************************************************
*** PROPIEDADES ***
Left = 94
Top = 57
isdatetime = .T.
Name = "txtFecDesde"

*** METODOS ***


************************************************************
OBJETO: txtFecHasta
************************************************************
*** PROPIEDADES ***
Left = 277
Top = 57
isdatetime = .T.
Name = "txtFecHasta"

*** METODOS ***


************************************************************
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 175
Left = 495
Name = "btnCerrar"

*** METODOS ***


************************************************************
OBJETO: btnImprimir
************************************************************
*** PROPIEDADES ***
Comment = ""
Top = 175
Left = 400
Name = "btnImprimir"

*** METODOS ***
PROCEDURE Click
* option1 = clientes
* option2 = proveedores
* option3 = marcas
* option4 = subfamilia

LOCAL loRes
LOCAL loDT
LOCAL loTherm
LOCAL lcSql
LOCAL m.titulo, m.titulo_grupo
LOCAL lImpTotal

loRes = CREATEOBJECT("odbc_result")
loTherm = CREATEOBJECT("_thermometer")
loDT = CREATEOBJECT("datetime")
lImpTotal = 0.00

m.titulo = ""
m.titulo_grupo = ""

IF thisform.contenido.opt_group.option1.Value = 1 THEN
	&& Rankign de clientes
	
	lcSql = "SELECT 	clientes.idCliente AS codigo, "
	
	IF thisform.contenido.chkDetalleMes.Value = 1 THEN
		lcSql = lcSql + "   YEAR(ventascab.fecEmision) AS anio, "
		lcSql = lcSql + "   MONTH(ventascab.fecEmision) AS mes, "
	ENDIF
	
	lcSql = lcSql + "   MAX(clientes.razSoc) AS descripcio, "
	lcSql = lcSql + "   ROUND(SUM(CASE WHEN ventascab.cbte = 'NC' THEN ventasdet.totNeto * -1 ELSE ventasdet.totNeto END), 2) AS importe "
    lcSql = lcSql + "FROM ventascab "
    lcSql = lcSql + "		INNER JOIN ventasdet ON ventasdet.idVentasC = ventascab.idVentasC "
	lcSql = lcSql + "     	INNER JOIN clientes ON ventascab.idCliente = clientes.idCliente "
    lcSql = lcSql + "WHERE ventascab.cbte NOT IN ('PED', 'COT', 'ND') "
   	lcSql = lcSql + "	AND ventascab.fecEmision BETWEEN " + loDT.toMySql(thisform.contenido.txtFecDesde.Value) + " AND " + loDT.toMySql(thisform.contenido.txtFecHasta.Value) + " "
    
    IF thisform.contenido.chkDetalleMes.Value = 1 THEN
    	lcSql = lcSql + "GROUP BY 	clientes.idCliente, "
	    lcSql = lcSql + " 	YEAR(ventascab.fecEmision), "
	    lcSql = lcSql + " 	MONTH(ventascab.fecEmision) "
	ELSE
		lcSql = lcSql + "GROUP BY 	clientes.idCliente "
	ENDIF
	    
    IF thisform.contenido.chkDetalleMes.Value = 1 THEN
    	lcSql = lcSql + "ORDER BY	clientes.idCliente, "
	    lcSql = lcSql + " 	YEAR(ventascab.fecEmision), "
	    lcSql = lcSql + " 	MONTH(ventascab.fecEmision) "
	ELSE
		lcSql = lcSql + "ORDER BY ROUND(SUM(CASE WHEN ventascab.cbte = 'FC' THEN ventascab.impNeto ELSE ventascab.impNeto * -1 END), 2) DESC "
	ENDIF

    m.titulo = "CLIENTES"
    m.titulo_grupo = "CLIENTE:"
ELSE
	IF thisform.contenido.opt_group.option2.Value = 1 THEN
		&& Ranking de proveedores
		
		lcSql = "SELECT	proveedor.idProv AS codigo, "
		
		IF thisform.contenido.chkDetalleMes.Value = 1 THEN
			lcSql = lcSql + "		YEAR(ventascab.fecEmision) AS anio, "
			lcSql = lcSql + "		MONTH(ventascab.fecEmision) AS mes, "   
		ENDIF
		
		lcSql = lcSql + "		MAX(proveedor.razSoc) AS descripcio, "
		lcSql = lcSql + "		ROUND(SUM(CASE WHEN ventascab.cbte = 'NC' THEN ventasdet.totNeto * -1 ELSE ventasdet.totNeto END), 2) AS importe "
		lcSql = lcSql + "FROM ventascab "
		lcSql = lcSql + "	INNER JOIN ventasdet ON ventasdet.idVentasC = ventascab.idVentasC "
		lcSql = lcSql + "	INNER JOIN articulos ON articulos.idArticulo = ventasdet.idArticulo "        
		lcSql = lcSql + "	INNER JOIN proveedor ON proveedor.idProv = articulos.idProv "
		lcSql = lcSql + "WHERE	ventascab.cbte NOT IN ('PED', 'COT', 'ND') "
		lcSql = lcSql + "	AND ventascab.fecEmision BETWEEN " + loDT.toMySql(thisform.contenido.txtFecDesde.Value) + " AND " + loDT.toMySql(thisform.contenido.txtFecHasta.Value) + " "
		
		IF thisform.contenido.chkDetalleMes.Value = 1 THEN
			lcSql = lcSql + "GROUP BY proveedor.idProv, "
			lcSql = lcSql + "	YEAR(ventascab.fecEmision), "
			lcSql = lcSql + "	MONTH(ventascab.fecEmision) "
		ELSE
			lcSql = lcSql + "GROUP BY proveedor.idProv "
		ENDIF
		
		IF thisform.contenido.chkDetalleMes.Value = 1 THEN
			lcSql = lcSql + "ORDER BY proveedor.idProv, "
			lcSql = lcSql + "	YEAR(ventascab.fecEmision), "
			lcSql = lcSql + "	MONTH(ventascab.fecEmision)	"
		ELSE
			lcSql = lcSql + "ORDER BY ROUND(SUM(CASE WHEN ventascab.cbte = 'FC' THEN ventasdet.totNeto ELSE ventasdet.totNeto * -1 END), 2) DESC "
		ENDIF
		
	    m.titulo = "PROVEEDORES"
	    m.titulo_grupo = "PROVEEDOR:"
	ELSE
		IF thisform.contenido.opt_group.option3.Value = 1 THEN
			&& Ranking de marcas
			
			lcSql = "SELECT	marcas.idmarca AS codigo, "
			
			IF thisform.contenido.chkDetalleMes.Value = 1 THEN
				lcSql = lcSql + "		YEAR(ventascab.fecEmision) AS anio, "
				lcSql = lcSql + "		MONTH(ventascab.fecEmision) AS mes, "   
			ENDIF
			
			lcSql = lcSql + "		MAX(marcas.descripcio) AS descripcio, "
			lcSql = lcSql + "		ROUND(SUM(CASE WHEN ventascab.cbte = 'NC' THEN ventasdet.totNeto * -1 ELSE ventasdet.totNeto END), 2) AS importe "
			lcSql = lcSql + "FROM ventascab "
			lcSql = lcSql + "	INNER JOIN ventasdet ON ventasdet.idVentasC = ventascab.idVentasC "
			lcSql = lcSql + "	INNER JOIN articulos ON articulos.idArticulo = ventasdet.idArticulo "        
			lcSql = lcSql + "	INNER JOIN marcas ON marcas.idmarca = articulos.idmarca "
			lcSql = lcSql + "WHERE	ventascab.cbte NOT IN ('PED', 'COT', 'ND') "
			lcSql = lcSql + "	AND ventascab.fecEmision BETWEEN " + loDT.toMySql(thisform.contenido.txtFecDesde.Value) + " AND " + loDT.toMySql(thisform.contenido.txtFecHasta.Value) + " "
						
			IF thisform.contenido.chkDetalleMes.Value = 1 THEN
				lcSql = lcSql + "GROUP BY marcas.idmarca, "
				lcSql = lcSql + "	YEAR(ventascab.fecEmision), "
				lcSql = lcSql + "	MONTH(ventascab.fecEmision) "
			ELSE
				lcSql = lcSql + "GROUP BY marcas.idmarca "
			ENDIF
			
			IF thisform.contenido.chkDetalleMes.Value = 1 THEN
				lcSql = lcSql + "ORDER BY marcas.idmarca, "
				lcSql = lcSql + "	YEAR(ventascab.fecEmision), "
				lcSql = lcSql + "	MONTH(ventascab.fecEmision)	"
			ELSE
				lcSql = lcSql + "ORDER BY ROUND(SUM(CASE WHEN ventascab.cbte = 'FC' THEN ventasdet.totNeto ELSE ventasdet.totNeto * -1 END), 2) DESC "
			ENDIF
			
		    m.titulo = "MARCAS"
		    m.titulo_grupo = "MARCA:"			
		ELSE
			IF thisform.contenido.opt_group.option4.Value = 1 THEN
				&& Ranking de subfamilias
				
				lcSql = "SELECT	subfam.idSubFam AS codigo, "
				
				IF thisform.contenido.chkDetalleMes.Value = 1 THEN
					lcSql = lcSql + "		YEAR(ventascab.fecEmision) AS anio, "
					lcSql = lcSql + "		MONTH(ventascab.fecEmision) AS mes, "   
				ENDIF
				
				lcSql = lcSql + "		MAX(subfam.descripcio) AS descripcio, "
				lcSql = lcSql + "		ROUND(SUM(CASE WHEN ventascab.cbte = 'NC' THEN ventasdet.totNeto * -1 ELSE ventasdet.totNeto END), 2) AS importe "
				lcSql = lcSql + "FROM ventascab "
				lcSql = lcSql + "	INNER JOIN ventasdet ON ventasdet.idVentasC = ventascab.idVentasC "
				lcSql = lcSql + "	INNER JOIN articulos ON articulos.idArticulo = ventasdet.idArticulo "        
				lcSql = lcSql + "	INNER JOIN subfam ON subfam.idSubFam = articulos.idSubFam "
				lcSql = lcSql + "WHERE	ventascab.cbte NOT IN ('PED', 'COT', 'ND') "
				lcSql = lcSql + "	AND ventascab.fecEmision BETWEEN " + loDT.toMySql(thisform.contenido.txtFecDesde.Value) + " AND " + loDT.toMySql(thisform.contenido.txtFecHasta.Value) + " "
				
				IF thisform.contenido.chkDetalleMes.Value = 1 THEN
					lcSql = lcSql + "GROUP BY subfam.idSubFam, "
					lcSql = lcSql + "	YEAR(ventascab.fecEmision), "
					lcSql = lcSql + "	MONTH(ventascab.fecEmision) "
				ELSE
					lcSql = lcSql + "GROUP BY subfam.idSubFam "
				ENDIF
				
				IF thisform.contenido.chkDetalleMes.Value = 1 THEN
					lcSql = lcSql + "ORDER BY subfam.idSubFam, "
					lcSql = lcSql + "	YEAR(ventascab.fecEmision), "
					lcSql = lcSql + "	MONTH(ventascab.fecEmision)	"
				ELSE
					lcSql = lcSql + "ORDER BY ROUND(SUM(CASE WHEN ventascab.cbte = 'FC' THEN ventasdet.totNeto ELSE ventasdet.totNeto * -1 END), 2) DESC "
				ENDIF
				
			    m.titulo = "SUB-FAMILIAS"
			    m.titulo_grupo = "SUB-FAMILIA:"							
			ENDIF
		ENDIF
	ENDIF
ENDIF

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_tempo"

IF !loRes.OpenQuery(lcSql) THEN	
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_tempo
IF RECCOUNT("cur_tempo") > 0 THEN
	GO TOP
ELSE
	MESSAGEBOX("No hay registros para mostrar", 0+48, Thisform.Caption)
	loRes.Close_Query()
	RETURN .F.
ENDIF

&& Calculo la venta total
SELECT ROUND(SUM(cur_tempo.importe), 2) AS total FROM cur_tempo INTO CURSOR cur_x
lnImpTotal = cur_x.total

USE IN cur_x

SELECT cur_ranking
ZAP

loTherm.show()
DO WHILE !EOF("cur_tempo")
	SELECT cur_ranking
	APPEND BLANK
	REPLACE cur_ranking.codigo WITH cur_tempo.codigo
	
	IF thisform.contenido.chkDetalleMes.Value = 1 THEN
		REPLACE cur_ranking.anio WITH cur_tempo.anio ADDITIVE
		REPLACE cur_ranking.mes WITH loDT.getNombreMes(cur_tempo.mes) ADDITIVE
	ELSE
		REPLACE cur_ranking.porVta WITH (cur_tempo.importe * 100) / lnImpTotal ADDITIVE
	ENDIF
	
	REPLACE cur_ranking.descripcio WITH cur_tempo.descripcio ADDITIVE
	REPLACE cur_ranking.importe WITH cur_tempo.importe ADDITIVE
	
	loTherm.update((RECNO("cur_tempo") * 100) / RECCOUNT("cur_tempo"), "Generando reporte, aguarde por favor...")
	SELECT cur_tempo
	SKIP
ENDDO

loTherm.complete()
loRes.Close_Query()

m.fechaDD = thisform.contenido.txtFecDesde.Value
m.fechaHH = thisform.contenido.txtFecHasta.Value

SELECT cur_ranking
GO TOP

IF thisform.contenido.chkDetalleMes.Value = 1 THEN
	REPORT FORM "rep_rankings" PREVIEW
ELSE
	REPORT FORM "rep_rankings_2" PREVIEW
ENDIF

RETURN .T.
ENDPROC


************************************************************
OBJETO: btnExcel
************************************************************
*** PROPIEDADES ***
Top = 175
Left = 352
Name = "btnExcel"

*** METODOS ***
PROCEDURE Click
* option1 = clientes
* option2 = proveedores
* option3 = marcas
* option4 = subfamilia

LOCAL loRes
LOCAL loDT
LOCAL loTherm
LOCAL lcSql
LOCAL m.titulo, m.titulo_grupo
LOCAL lImpTotal
LOCAL lcFileName

loRes = CREATEOBJECT("odbc_result")
loTherm = CREATEOBJECT("_thermometer")
loDT = CREATEOBJECT("datetime")
lImpTotal = 0.00
lcFileName = ""

m.titulo = ""
m.titulo_grupo = ""

IF thisform.contenido.opt_group.option1.Value = 1 THEN
	&& Rankign de clientes
	
	lcSql = "SELECT 	clientes.idCliente AS codigo, "
	
	IF thisform.contenido.chkDetalleMes.Value = 1 THEN
		lcSql = lcSql + "   YEAR(ventascab.fecEmision) AS anio, "
		lcSql = lcSql + "   MONTH(ventascab.fecEmision) AS mes, "
	ENDIF
	
	lcSql = lcSql + "   MAX(clientes.razSoc) AS descripcio, "
	lcSql = lcSql + "   ROUND(SUM(CASE WHEN ventascab.cbte = 'NC' THEN ventasdet.totNeto * -1 ELSE ventasdet.totNeto END), 2) AS importe "
    lcSql = lcSql + "FROM ventascab "
    lcSql = lcSql + "		INNER JOIN ventasdet ON ventasdet.idVentasC = ventascab.idVentasC "
	lcSql = lcSql + "     	INNER JOIN clientes ON ventascab.idCliente = clientes.idCliente "
    lcSql = lcSql + "WHERE ventascab.cbte NOT IN ('PED', 'COT', 'ND') "
   	lcSql = lcSql + "	AND ventascab.fecEmision BETWEEN " + loDT.toMySql(thisform.contenido.txtFecDesde.Value) + " AND " + loDT.toMySql(thisform.contenido.txtFecHasta.Value) + " "
    
    IF thisform.contenido.chkDetalleMes.Value = 1 THEN
    	lcSql = lcSql + "GROUP BY 	clientes.idCliente, "
	    lcSql = lcSql + " 	YEAR(ventascab.fecEmision), "
	    lcSql = lcSql + " 	MONTH(ventascab.fecEmision) "
	ELSE
		lcSql = lcSql + "GROUP BY 	clientes.idCliente "
	ENDIF
	    
    IF thisform.contenido.chkDetalleMes.Value = 1 THEN
    	lcSql = lcSql + "ORDER BY	clientes.idCliente, "
	    lcSql = lcSql + " 	YEAR(ventascab.fecEmision), "
	    lcSql = lcSql + " 	MONTH(ventascab.fecEmision) "
	ELSE
		lcSql = lcSql + "ORDER BY ROUND(SUM(CASE WHEN ventascab.cbte = 'FC' THEN ventascab.impNeto ELSE ventascab.impNeto * -1 END), 2) DESC "
	ENDIF

    m.titulo = "CLIENTES"
    m.titulo_brupo = "CLIENTE:"
ELSE
	IF thisform.contenido.opt_group.option2.Value = 1 THEN
		&& Ranking de proveedores
		
		lcSql = "SELECT	proveedor.idProv AS codigo, "
		
		IF thisform.contenido.chkDetalleMes.Value = 1 THEN
			lcSql = lcSql + "		YEAR(ventascab.fecEmision) AS anio, "
			lcSql = lcSql + "		MONTH(ventascab.fecEmision) AS mes, "   
		ENDIF
		
		lcSql = lcSql + "		MAX(proveedor.razSoc) AS descripcio, "
		lcSql = lcSql + "		ROUND(SUM(CASE WHEN ventascab.cbte = 'FC' THEN ventasdet.totNeto ELSE ventasdet.totNeto * -1 END), 2) AS importe "
		lcSql = lcSql + "FROM ventascab "
		lcSql = lcSql + "	INNER JOIN ventasdet ON ventasdet.idVentasC = ventascab.idVentasC "
		lcSql = lcSql + "	INNER JOIN articulos ON articulos.idArticulo = ventasdet.idArticulo "        
		lcSql = lcSql + "	INNER JOIN proveedor ON proveedor.idProv = articulos.idProv "
		lcSql = lcSql + "WHERE	ventascab.cbte NOT IN ('PED', 'COT') "
		lcSql = lcSql + "	AND ventascab.fecEmision BETWEEN " + loDT.toMySql(thisform.contenido.txtFecDesde.Value) + " AND " + loDT.toMySql(thisform.contenido.txtFecHasta.Value) + " "
		
		IF thisform.contenido.chkDetalleMes.Value = 1 THEN
			lcSql = lcSql + "GROUP BY proveedor.idProv, "
			lcSql = lcSql + "	YEAR(ventascab.fecEmision), "
			lcSql = lcSql + "	MONTH(ventascab.fecEmision) "
		ELSE
			lcSql = lcSql + "GROUP BY proveedor.idProv "
		ENDIF
		
		IF thisform.contenido.chkDetalleMes.Value = 1 THEN
			lcSql = lcSql + "ORDER BY proveedor.idProv, "
			lcSql = lcSql + "	YEAR(ventascab.fecEmision), "
			lcSql = lcSql + "	MONTH(ventascab.fecEmision)	"
		ELSE
			lcSql = lcSql + "ORDER BY ROUND(SUM(CASE WHEN ventascab.cbte = 'FC' THEN ventasdet.totNeto ELSE ventasdet.totNeto * -1 END), 2) DESC "
		ENDIF
		
	    m.titulo = "PROVEEDORES"
	    m.titulo_brupo = "PROVEEDOR:"
	ELSE
		IF thisform.contenido.opt_group.option3.Value = 1 THEN
			&& Ranking de marcas
			
			lcSql = "SELECT	marcas.idmarca AS codigo, "
			
			IF thisform.contenido.chkDetalleMes.Value = 1 THEN
				lcSql = lcSql + "		YEAR(ventascab.fecEmision) AS anio, "
				lcSql = lcSql + "		MONTH(ventascab.fecEmision) AS mes, "   
			ENDIF
			
			lcSql = lcSql + "		MAX(marcas.descripcio) AS descripcio, "
			lcSql = lcSql + "		ROUND(SUM(CASE WHEN ventascab.cbte = 'FC' THEN ventasdet.totNeto ELSE ventasdet.totNeto * -1 END), 2) AS importe "
			lcSql = lcSql + "FROM ventascab "
			lcSql = lcSql + "	INNER JOIN ventasdet ON ventasdet.idVentasC = ventascab.idVentasC "
			lcSql = lcSql + "	INNER JOIN articulos ON articulos.idArticulo = ventasdet.idArticulo "        
			lcSql = lcSql + "	INNER JOIN marcas ON marcas.idmarca = articulos.idmarca "
			lcSql = lcSql + "WHERE	ventascab.cbte NOT IN ('PED', 'COT') "
			lcSql = lcSql + "	AND ventascab.fecEmision BETWEEN " + loDT.toMySql(thisform.contenido.txtFecDesde.Value) + " AND " + loDT.toMySql(thisform.contenido.txtFecHasta.Value) + " "
						
			IF thisform.contenido.chkDetalleMes.Value = 1 THEN
				lcSql = lcSql + "GROUP BY marcas.idmarca, "
				lcSql = lcSql + "	YEAR(ventascab.fecEmision), "
				lcSql = lcSql + "	MONTH(ventascab.fecEmision) "
			ELSE
				lcSql = lcSql + "GROUP BY marcas.idmarca "
			ENDIF
			
			IF thisform.contenido.chkDetalleMes.Value = 1 THEN
				lcSql = lcSql + "ORDER BY marcas.idmarca, "
				lcSql = lcSql + "	YEAR(ventascab.fecEmision), "
				lcSql = lcSql + "	MONTH(ventascab.fecEmision)	"
			ELSE
				lcSql = lcSql + "ORDER BY ROUND(SUM(CASE WHEN ventascab.cbte = 'FC' THEN ventasdet.totNeto ELSE ventasdet.totNeto * -1 END), 2) DESC "
			ENDIF
			
		    m.titulo = "MARCAS"
		    m.titulo_brupo = "MARCA:"			
		ELSE
			IF thisform.contenido.opt_group.option4.Value = 1 THEN
				&& Ranking de subfamilias
				
				lcSql = "SELECT	subfam.idSubFam AS codigo, "
				
				IF thisform.contenido.chkDetalleMes.Value = 1 THEN
					lcSql = lcSql + "		YEAR(ventascab.fecEmision) AS anio, "
					lcSql = lcSql + "		MONTH(ventascab.fecEmision) AS mes, "   
				ENDIF
				
				lcSql = lcSql + "		MAX(subfam.descripcio) AS descripcio, "
				lcSql = lcSql + "		ROUND(SUM(CASE WHEN ventascab.cbte = 'FC' THEN ventasdet.totNeto ELSE ventasdet.totNeto * -1 END), 2) AS importe "
				lcSql = lcSql + "FROM ventascab "
				lcSql = lcSql + "	INNER JOIN ventasdet ON ventasdet.idVentasC = ventascab.idVentasC "
				lcSql = lcSql + "	INNER JOIN articulos ON articulos.idArticulo = ventasdet.idArticulo "        
				lcSql = lcSql + "	INNER JOIN subfam ON subfam.idSubFam = articulos.idSubFam "
				lcSql = lcSql + "WHERE	ventascab.cbte NOT IN ('PED', 'COT') "
				lcSql = lcSql + "	AND ventascab.fecEmision BETWEEN " + loDT.toMySql(thisform.contenido.txtFecDesde.Value) + " AND " + loDT.toMySql(thisform.contenido.txtFecHasta.Value) + " "
				
				IF thisform.contenido.chkDetalleMes.Value = 1 THEN
					lcSql = lcSql + "GROUP BY subfam.idSubFam, "
					lcSql = lcSql + "	YEAR(ventascab.fecEmision), "
					lcSql = lcSql + "	MONTH(ventascab.fecEmision) "
				ELSE
					lcSql = lcSql + "GROUP BY subfam.idSubFam "
				ENDIF
				
				IF thisform.contenido.chkDetalleMes.Value = 1 THEN
					lcSql = lcSql + "ORDER BY subfam.idSubFam, "
					lcSql = lcSql + "	YEAR(ventascab.fecEmision), "
					lcSql = lcSql + "	MONTH(ventascab.fecEmision)	"
				ELSE
					lcSql = lcSql + "ORDER BY ROUND(SUM(CASE WHEN ventascab.cbte = 'FC' THEN ventasdet.totNeto ELSE ventasdet.totNeto * -1 END), 2) DESC "
				ENDIF
				
			    m.titulo = "SUB-FAMILIAS"
			    m.titulo_brupo = "SUB-FAMILIA:"							
			ENDIF
		ENDIF
	ENDIF
ENDIF

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_tempo"

IF !loRes.OpenQuery(lcSql) THEN	
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_tempo
IF RECCOUNT("cur_tempo") > 0 THEN
	GO TOP
ELSE
	MESSAGEBOX("No hay registros para mostrar", 0+48, Thisform.Caption)
	loRes.Close_Query()
	RETURN .F.
ENDIF

&& Calculo la venta total
SELECT ROUND(SUM(cur_tempo.importe), 2) AS total FROM cur_tempo INTO CURSOR cur_x
lnImpTotal = cur_x.total

USE IN cur_x

SELECT cur_ranking
ZAP

loTherm.show()
DO WHILE !EOF("cur_tempo")
	SELECT cur_ranking
	APPEND BLANK
	REPLACE cur_ranking.codigo WITH cur_tempo.codigo
	
	IF thisform.contenido.chkDetalleMes.Value = 1 THEN
		REPLACE cur_ranking.anio WITH cur_tempo.anio ADDITIVE
		REPLACE cur_ranking.mes WITH loDT.getNombreMes(cur_tempo.mes) ADDITIVE
	ELSE
		REPLACE cur_ranking.porVta WITH (cur_tempo.importe * 100) / lnImpTotal ADDITIVE
	ENDIF
	
	REPLACE cur_ranking.descripcio WITH cur_tempo.descripcio ADDITIVE
	REPLACE cur_ranking.importe WITH cur_tempo.importe ADDITIVE
	
	loTherm.update((RECNO("cur_tempo") * 100) / RECCOUNT("cur_tempo"), "Generando reporte, aguarde por favor...")
	SELECT cur_tempo
	SKIP
ENDDO

loTherm.complete()
loRes.Close_Query()

m.fechaDD = thisform.contenido.txtFecDesde.Value
m.fechaHH = thisform.contenido.txtFecHasta.Value

SELECT cur_ranking
GO TOP

lcFileName = PUTFILE("Guardar como", "", "xls")

IF !(ALLTRIM(lcFileName) == "") THEN
	=Exp2Excel( "cur_ranking", lcFileName, m.titulo )
ENDIF

RETURN .T.
ENDPROC


************************************************************
OBJETO: chkDetalleMes
************************************************************
*** PROPIEDADES ***
Top = 86
Left = 13
Height = 18
Width = 132
Alignment = 0
Caption = "Detallar por mes"
Value = 0
Name = "chkDetalleMes"

*** METODOS ***


************************************************************
OBJETO: cls_form_rankings
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_form_artporcli
************************************************************
*** PROPIEDADES ***
BorderStyle = 2
Height = 437
Width = 859
DoCreate = .T.
Caption = "Consulta Ventas de Artículos por Cliente"
Name = "cls_form_artporcli"

*** METODOS ***
PROCEDURE Load
DODEFAULT()

CREATE CURSOR cur_ArtCli ( ;
	fecha datetime,;
	idCliente int,;
	razSoc varchar(60),;
	cbte varchar(3),;
	tipoDoc varchar(1),;
	numero varhcar(13),;
	cantV float(10, 2),;
	prUni float(10, 2),;
	prTot float(10, 2))


ENDPROC
PROCEDURE Init
SELECT cur_ArtCli
Thisform.grdResults.alias_name = "cur_ArtCli"
Thisform.grdResults.RecordSource = "cur_ArtCli"
Thisform.grdResults.list_controlsource = "fecha,idCliente,razSoc,cbte,tipoDoc,numero,cantV,prUni,prTot"
Thisform.grdResults.titulos_cabeceras = "Fecha,Cliente,Razón Social,Cbte.,Letra,Número,Cant. Vend.,Pr. Un. S/IVA,Total"
Thisform.grdResults.lista_ancho_cols = "100,60,200,70,70,100,70,70,70"
Thisform.grdResults.generar_grid()



ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Artículo:"
Left = 24
Top = 12
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Cliente:"
Left = 24
Top = 36
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Fecha Desde:"
Height = 15
Left = 607
Top = 36
Width = 78
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: sel_articulo
************************************************************
*** PROPIEDADES ***
Top = 7
Left = 120
autocompletar_ceros = .F.
nombre_campo_codigo = codArt
nombre_campo_desc = descripcio
nombre_tabla = articulos
pkfield = idArticulo
Name = "sel_articulo"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: sel_cliente
************************************************************
*** PROPIEDADES ***
Top = 31
Left = 120
autocompletar_ceros = .F.
esnumerico = .T.
nombre_campo_codigo = idCliente
nombre_campo_desc = razSoc
nombre_tabla = clientes
pkfield = idCliente
Name = "sel_cliente"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: txtFechaDD
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 684
Top = 33
Width = 100
isdatetime = .T.
Name = "txtFechaDD"

*** METODOS ***


************************************************************
OBJETO: btnBuscar
************************************************************
*** PROPIEDADES ***
Top = 17
Left = 814
Height = 38
Width = 40
Name = "btnBuscar"

*** METODOS ***
PROCEDURE Click
LOCAL loRes
LOCAL loDT
LOCAL lcSql
LOCAL lnIdArtic
LOCAL lnIdCli
LOCAL ldFechaDD
LOCAL lcPtoVta
LOCAL lcNro

loRes = CREATEOBJECT("odbc_result")
loDT = CREATEOBJECT("datetime")
lnIdArtic = 0
lnIdCli = 0
ldFechaDD = {}
lcPtoVta = ""
lcNro = ""

IF (Thisform.sel_articulo.valcpoid = 0) THEN
	MESSAGEBOX("Debe filtrar por artículo obligatoriamente", 0+48, ;
		Thisform.Caption)
	RETURN
ENDIF

lnIdArtic = Thisform.sel_articulo.valcpoid
lnIdCli = Thisform.sel_cliente.valcpoid
ldFechaDD = Thisform.txtFechaDD.Value

SELECT cur_ArtCli
ZAP

lcSql = "SELECT "
lcSql = lcSql + "  ventascab.fecEmision, "
lcSql = lcSql + "  ventascab.idCliente, "
lcSql = lcSql + "  clientes.razSoc, "
lcSql = lcSql + "  ventascab.cbte, "
lcSql = lcSql + "  ventascab.tipoDoc, "
lcSql = lcSql + "  ventascab.ptoVta, "
lcSql = lcSql + "  ventascab.numCbte, "
lcSql = lcSql + "  ventasdet.cantidad, "
lcSql = lcSql + "  ventasdet.prVenta, "
lcSql = lcSql + "  (ventasdet.cantidad * ventasdet.prVenta) AS prTotal "
lcSql = lcSql + "FROM ventasdet "
lcSql = lcSql + "  INNER JOIN ventascab ON ventascab.idVentasC = ventasdet.idVentasC "
lcSql = lcSql + "  INNER JOIN clientes ON clientes.idCliente = ventascab.idCliente "
lcSql = lcSql + "WHERE ventascab.fecBaja IS NULL "
lcSql = lcSql + "	AND CASE WHEN ventascab.tipoDoc <> 'X' THEN ventascab.aut_Resultado = 'A' "
lcSql = lcSql + "		ELSE true END "
lcSql = lcSql + "  	AND ventasdet.idArticulo = " + ALLTRIM(STR(lnIdArtic)) + " "

IF lnIdCli <> 0 THEN
	lcSql = lcSql + "AND ventascab.idCliente = " + ALLTRIM(STR(lnIdCli)) + " "
ENDIF

IF ldFechaDD <> {} THEN
	lcSql = lcSql + "AND ventascab.fecEmision >= " + loDT.ToMySql(ldFechaDD) + " "
ENDIF

lcSql = lcSql + "ORDER BY ventascab.fecEmision "

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"
IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN
ENDIF

SELECT cur_x
GO TOP
DO WHILE !EOF("cur_x")
	lcPtoVta = REPLICATE("0", 4 - LEN(ALLTRIM(STR(cur_x.ptoVta)))) + ;
		ALLTRIM(STR(cur_x.ptoVta))
	lcNumCbte = REPLICATE("0", 8 - LEN(ALLTRIM(STR(cur_x.numCbte)))) + ;
		ALLTRIM(STR(cur_x.numCbte))

	SELECT cur_ArtCli
	APPEND BLANK
	REPLACE cur_ArtCli.fecha WITH cur_x.fecEmision
	REPLACE cur_ArtCli.idCliente WITH cur_x.idCliente ADDITIVE
	REPLACE cur_ArtCli.razSoc WITH cur_x.razSoc ADDITIVE
	REPLACE cur_ArtCli.cbte WITH cur_x.cbte ADDITIVE
	REPLACE cur_ArtCli.tipoDoc WITH cur_x.tipoDoc ADDITIVE
	REPLACE cur_ArtCli.numero WITH lcPtoVta + "-" + lcNumCbte ADDITIVE
	REPLACE cur_ArtCli.cantV WITH cur_x.cantidad ADDITIVE
	REPLACE cur_ArtCli.prUni WITH cur_x.prVenta ADDITIVE
	REPLACE cur_ArtCli.prTot WITH cur_x.prTotal ADDITIVE

	SELECT cur_x
	SKIP
ENDDO

loRes.Close_Query()

SELECT cur_ArtCli
GO TOP

Thisform.grdResults.Refresh()

ENDPROC


************************************************************
OBJETO: grdResults
************************************************************
*** PROPIEDADES ***
Height = 310
Left = 12
Top = 61
Width = 841
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdResults"
COLUMN1.Header1.Name = "Header1"
COLUMN1.Text1.Name = "Text1"
COLUMN1.Name = "COLUMN1"
COLUMN2.Header1.Name = "Header1"
COLUMN2.Text1.Name = "Text1"
COLUMN2.Name = "COLUMN2"
COLUMN3.Header1.Name = "Header1"
COLUMN3.Text1.Name = "Text1"
COLUMN3.Name = "COLUMN3"
COLUMN4.Header1.Name = "Header1"
COLUMN4.Text1.Name = "Text1"
COLUMN4.Name = "COLUMN4"
COLUMN5.Header1.Name = "Header1"
COLUMN5.Text1.Name = "Text1"
COLUMN5.Name = "COLUMN5"
COLUMN6.Header1.Name = "Header1"
COLUMN6.Text1.Name = "Text1"
COLUMN6.Name = "COLUMN6"
COLUMN7.Header1.Name = "Header1"
COLUMN7.Text1.Name = "Text1"
COLUMN7.Name = "COLUMN7"
COLUMN8.Header1.Name = "Header1"
COLUMN8.Text1.Name = "Text1"
COLUMN8.Name = "COLUMN8"
COLUMN9.Header1.Name = "Header1"
COLUMN9.Text1.Name = "Text1"
COLUMN9.Name = "COLUMN9"
COLUMN10.Header1.Name = "Header1"
COLUMN10.Text1.Name = "Text1"
COLUMN10.Name = "COLUMN10"
COLUMN11.Header1.Name = "Header1"
COLUMN11.Text1.Name = "Text1"
COLUMN11.Name = "COLUMN11"
COLUMN12.Header1.Name = "Header1"
COLUMN12.Text1.Name = "Text1"
COLUMN12.Name = "COLUMN12"
COLUMN13.Header1.Name = "Header1"
COLUMN13.Text1.Name = "Text1"
COLUMN13.Name = "COLUMN13"
COLUMN14.Header1.Name = "Header1"
COLUMN14.Text1.Name = "Text1"
COLUMN14.Name = "COLUMN14"
COLUMN15.Header1.Name = "Header1"
COLUMN15.Text1.Name = "Text1"
COLUMN15.Name = "COLUMN15"
COLUMN16.Header1.Name = "Header1"
COLUMN16.Text1.Name = "Text1"
COLUMN16.Name = "COLUMN16"
COLUMN17.Header1.Name = "Header1"
COLUMN17.Text1.Name = "Text1"
COLUMN17.Name = "COLUMN17"
COLUMN18.Header1.Name = "Header1"
COLUMN18.Text1.Name = "Text1"
COLUMN18.Name = "COLUMN18"
COLUMN19.Header1.Name = "Header1"
COLUMN19.Text1.Name = "Text1"
COLUMN19.Name = "COLUMN19"
COLUMN20.Header1.Name = "Header1"
COLUMN20.Text1.Name = "Text1"
COLUMN20.Name = "COLUMN20"

*** METODOS ***


************************************************************
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 383
Left = 809
Name = "btnCerrar"

*** METODOS ***


************************************************************
OBJETO: btnImprimir
************************************************************
*** PROPIEDADES ***
Top = 383
Left = 763
Name = "btnImprimir"

*** METODOS ***
PROCEDURE Click
LOCAL m.articulo

m.articulo = ALLTRIM(Thisform.sel_articulo.txtCodigo.Value)
m.fechaDD = thisform.txtFechaDD.Value

SELECT cur_ArtCli
REPORT FORM rep_infoarticli TO PRINTER PROMPT PREVIEW 
ENDPROC


************************************************************
OBJETO: cls_form_artporcli
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


