************************************************************
OBJETO: cls_envio_resumen_ctactecli
************************************************************
*** PROPIEDADES ***
Height = 436
Width = 770
DoCreate = .T.
BorderStyle = 2
Caption = "Enviar resumenes de Cuenta Corriente"
WindowState = 0
Name = "cls_envio_resumen_ctactecli"

*** METODOS ***
PROCEDURE Init
LOCAL lcSql, loResult

SELECT cur_resumen
thisform.grdResumen.Alias_name = "cur_resumen"
thisform.grdResumen.RecordSource = "cur_resumen"
thisform.grdResumen.list_controlsource = "Selected,Codigo,RazSoc,Saldo"
thisform.grdResumen.lista_ancho_cols = "25,70,200,120"
thisform.grdResumen.titulos_cabeceras = "Sel.,Código,Razón Social,Saldo"
thisform.grdResumen.permitir_busqueda = .f.
thisform.grdResumen.permitir_ordenamiento = .f.
thisform.grdResumen.generar_grid()

loResult = CREATEOBJECT("odbc_result")

lcSql = " SELECT  vendedores.idvendedor as 'CodVend', "
lcSql = lcSql + " vendedores.nombre, "
lcSql = lcSql + " clientes.idcliente as 'Codigo', "
lcSql = lcSql + " clientes.razsoc, "
lcSql = lcSql + " clientes.telefono, "
lcSql = lcSql + " clientes.mailFC as 'email', "
lcSql = lcSql + " ROUND(SUM(cc.impdebe - cc.imphaber),2) as Saldo "
lcSql = lcSql + " FROM    vendedores inner join clientes on vendedores.idvendedor = clientes.idvendedor"
lcSql = lcSql + "             inner join cc_cli cc on clientes.idcliente = cc.idcliente "
lcSql = lcSql + " WHERE   clientes.idCondPago <> 1 "
lcSql = lcSql + "         and (cc.usubaja is null or cc.usubaja = '') "
lcSql = lcSql + " GROUP BY vendedores.idvendedor, "
lcSql = lcSql + "         vendedores.nombre, "
lcSql = lcSql + "         clientes.idcliente, "
lcSql = lcSql + "         clientes.razsoc, "
lcSql = lcSql + "         clientes.telefono, "
lcSql = lcSql + "         clientes.email "
lcSql = lcSql + " HAVING ROUND(SUM(cc.impdebe - cc.imphaber),2) != 0 "
lcSql = lcSql + " ORDER BY clientes.idvendedor, clientes.idcliente"

loResult.ActiveConnection = goConn.ActiveConnection
loResult.cursor_name = "cur_temp"
loResult.OpenQuery(lcSql) 

SELECT cur_resumen
ZAP
APPEND FROM DBF("cur_temp")

loResult.Close_Query()

* Marcar todas las filas como seleccionadas (Selected = .T.) y el checkbox
SELECT cur_resumen
GO TOP

Thisform.clscheckbox1.Value = 1

DO WHILE !EOF()
    REPLACE cur_resumen.Selected WITH .T.
    SKIP
ENDDO

SELECT cur_resumen
GO TOP

thisform.grdResumen.Refresh()
ENDPROC
PROCEDURE Load
DODEFAULT()

CREATE CURSOR cur_resumen(;
    CodVend            int,;
    Nombre            C(60),;
    Codigo            int,;
    RazSoc            C(60),;
    Telefono        C(20) NULL,;
    Email            C(60) NULL,;
    Saldo            float(10,2),;
    Selected		L)

CREATE CURSOR cur_todosmov(;
	CodVend int ,;
	Nombre C(60),;
	Codigo INT, ;
	RazSoc C(60), ;
	Telefono c(20) NULL, ;
	Email C(60) NULL,;
	Idoper INT,;
	observ VARCHAR(100),;
	FecEmis DATETIME,;
	Fecha DATETIME,;
	Cbte C(3),;
	TipoDoc C(1),;
	NumCbte C(14),;
	Debe FLOAT(10,2),;
	Haber FLOAT(10,2),;
	Saldo FLOAT(10,2))
	

ENDPROC


************************************************************
OBJETO: brnEnviar
************************************************************
*** PROPIEDADES ***
Top = 388
Left = 593
Height = 36
Width = 97
Caption = "Enviar"
Name = "brnEnviar"

*** METODOS ***
PROCEDURE Click
LOCAL lcSql, loResult, loPDF, lcFileName, lcMailMsg, lcMailTo
LOCAL m.titulo
LOCAL m.tipolistado
LOCAL m.fecha
LOCAL m.clidesde
LOCAL m.clihasta
LOCAL m.femisd
LOCAL m.femish
LOCAL m.venddesde
LOCAL m.vendhasta

m.titulo = "Listado de Cuentas Corrientes"
m.tipolistado = "Comprobantes con Saldo"
m.fecha = DATETIME()
m.femisd = "1/1/2000"
m.femish = DATETIME()
m.venddesde = 0
m.vendhasta = 99999

lcMailServer = getGlobalCFG("EMAILSMTP")  && Dirección del servidor 
lnMailPort = getGlobalCFG("EMAILPORT")  && Puerto del servidor 
lcMailUsername = getGlobalCFG("EMAILUSR")  && Nombre de usuario del servidor 
lcMailPassword = getGlobalCFG("EMAILPWD")  && Contraseña del servidor 

loResult = CREATEOBJECT("odbc_result")

SELECT cur_resumen
GO TOP
DO WHILE !EOF("cur_resumen")
	IF cur_resumen.Selected = .T.
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
		lcSql = lcSql + " 				WHERE cc2.idcliente = " + ALLTRIM(STR(cur_resumen.Codigo)) + " "
		lcSql = lcSql + "         			and (cc2.usubaja is null or cc2.usubaja = '') "
		lcSql = lcSql + "         			and idoper != 0 "
		lcSql = lcSql + "         		GROUP BY cc2.idoper) AS Saldos ON cc.idoper = Saldos.idoper "
		lcSql = lcSql + " WHERE       clientes.idcliente = " + ALLTRIM(STR(cur_resumen.Codigo))
		lcSql = lcSql + "         and (cc.usubaja is null or cc.usubaja = '') "
		lcSql = lcSql + "          and cc.idOper != 0 "
		lcSql = lcSql + "         and (SaldoTot != 0 or SaldoTot is null) "
		lcSql = lcSql + " ORDER BY idvendedor, idcliente, fecha, idOper, Orden2, nroCbte"
		    
	    loResult.ActiveConnection = goConn.ActiveConnection
	    loResult.cursor_name = "cur_tempo"
	    loResult.OpenQuery(lcSql) 

	    SELECT cur_todosmov
	    ZAP

	    SELECT cur_tempo
	    IF RECCOUNT() > 0      
	        GO TOP 
	    ENDIF

	    DO WHILE !EOF()
		    SELECT cur_todosmov
			APPEND BLANK
			REPLACE CodVend WITH cur_tempo.idvendedor 
			REPLACE Nombre WITH cur_tempo.nombre ADDITIVE
			REPLACE Codigo WITH cur_tempo.idcliente ADDITIVE 
			REPLACE RazSoc WITH cur_tempo.razsoc ADDITIVE
			REPLACE Telefono WITH cur_tempo.telefono ADDITIVE 
			REPLACE Email WITH cur_tempo.email ADDITIVE 
			REPLACE Idoper WITH cur_tempo.idoper ADDITIVE 
			REPLACE Observ WITH IIF(ISNULL(cur_tempo.observ), "", cur_tempo.observ) ADDITIVE
			REPLACE FecEmis WITH cur_tempo.fecemis ADDITIVE
			REPLACE Fecha WITH cur_tempo.fecha ADDITIVE  
			REPLACE Cbte WITH cur_tempo.cbte ADDITIVE 
			REPLACE TipoDoc WITH cur_tempo.tipodoc ADDITIVE
			REPLACE NumCbte WITH getPtoVta(cur_tempo.ptoVta) + "-" + getNroCbte(cur_tempo.nroCbte) ADDITIVE
		   	REPLACE Debe WITH cur_tempo.debe ADDITIVE
		   	REPLACE Haber WITH cur_tempo.haber ADDITIVE   
			REPLACE Saldo WITH cur_tempo.saldo ADDITIVE 
	        
	        SELECT cur_tempo
	        SKIP 
	    ENDDO 
	    
	    loResult.close_query()

	    m.clidesde = cur_resumen.codigo
	    m.clihasta = cur_resumen.codigo
	    
	    lcMailTo = cur_resumen.email  && Almacena la dirección de correo electrónico del cliente en una variable

	    lcFileName = ALLTRIM(GetGlobalCfg('FACPDFPATH')) + ;
	        ALLTRIM(STR(cur_resumen.codigo)) + '_resumen.pdf'
	    
	    loPDF = CREATEOBJECT('Bullzip.PDFPrinterSettings')
	    loPDF.SetValue('output', lcFileName)
	    loPDF.SetValue('DisableOptionDialog', 'no')
	    loPDF.SetValue('ConfirmOverwrite', 'no')
	    loPDF.SetValue('Showsettings', 'never')
	    loPDF.SetValue('ShowSaveAs', 'nofile')
	    loPDF.SetValue('ShowPdf', 'no')
	    loPDF.WriteSettings(.t.)
	    
	    SET CONSOLE OFF
	    SET PRINTER TO NAME("Bullzip PDF Printer")

	    SELECT cur_todosmov
	    REPORT FORM repctactemov NOCONSOLE TO PRINTER
	    
	    SET PRINTER TO DEFAULT
	    SET CONSOLE ON
	    
	    WAIT WINDOW "Generando resumen PDF Cliente: " + ALLTRIM(STR(cur_resumen.codigo)) NOWAIT
	    DO WHILE !FILE(lcFileName)
	    
	    ENDDO

	    SELECT cur_todosmov
	    IF RECCOUNT() > 0      
	        GO TOP 
	    ENDIF
	    
	    * Envío el PDF por correo electrónico.
	    lcMailMsg = CREATEOBJECT("CDO.Message")
	    lcMailMsg.From = getGlobalCFG("EMAILEMP") + " <" + getGlobalCFG("EMAILADDR") + ">"
	    lcMailMsg.Subject = "ERA - Reporte de Cuentas Corrientes con Saldos"
		lcMailMsg.TextBody = "Estimado cliente, le adjuntamos el resumen de Cuentas Corrientes en formato PDF." + CHR(13) + CHR(10) + ;
	                    "Por favor, no responder a esta dirección de mail."


	    lcMailMsg.AddAttachment(lcFileName)

	    * Agrega los destinatarios del correo electrónico
	    lcMailMsg.To = lcMailTo
	    If EMPTY(lcMailTo) THEN
	    	MessageBox("El cliente " + Alltrim(cur_resumen.RazSoc) + " no tiene correo asignado.", 0+48, "")
	    endif
	    * Si necesitas enviar el correo a múltiples destinatarios, puedes agregar más direcciones de correo electrónico separadas por coma.

	    * Configura los parámetros SMTP
	    lcMailMsg.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = lcMailServer
	    lcMailMsg.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = lnMailPort
	    lcMailMsg.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
	    lcMailMsg.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1
	    lcMailMsg.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendusername") = lcMailUsername
	    lcMailMsg.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendpassword") = lcMailPassword
	    
	    * Habilita SSL
	    lcMailMsg.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = .T.
	    
	    lcMailMsg.Configuration.Fields.Update()

	    lcMailMsg.Send()

	    * Elimina el archivo PDF después de enviar el correo electrónico
	    DELETE FILE (lcFileName)

	    SELECT cur_todosmov
	    IF RECCOUNT() > 0      
	        GO TOP 
	    ENDIF
	ENDIF
    SELECT cur_resumen
    SKIP

ENDDO

ENDPROC


************************************************************
OBJETO: Clscerrar1
************************************************************
*** PROPIEDADES ***
Top = 389
Left = 708
Height = 36
Width = 48
Name = "Clscerrar1"

*** METODOS ***


************************************************************
OBJETO: grdResumen
************************************************************
*** PROPIEDADES ***
Height = 347
Left = 5
Top = 33
Width = 759
Name = "grdResumen"
COLUMN1.Header1.Name = "Header1"
COLUMN1.Text1.Alignment = 0
COLUMN1.Text1.ReadOnly = .F.
COLUMN1.Text1.Name = "Text1"
COLUMN1.Alignment = 0
COLUMN1.CurrentControl = "Clscheckbox1"
COLUMN1.ReadOnly = .F.
COLUMN1.Sparse = .F.
COLUMN1.Name = "COLUMN1"
COLUMN2.Header1.Name = "Header1"
COLUMN2.Text1.Name = "Text1"
COLUMN2.Name = "COLUMN2"
COLUMN3.Header1.Name = "Header1"
COLUMN3.Text1.Alignment = 2
COLUMN3.Text1.Name = "Text1"
COLUMN3.Alignment = 2
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
OBJETO: Clscheckbox1
************************************************************
*** PROPIEDADES ***
Top = 22
Left = 20
Alignment = 0
Centered = .T.
Caption = ""
TerminateRead = .F.
ReadOnly = .F.
Name = "Clscheckbox1"

*** METODOS ***


************************************************************
OBJETO: Clscheckbox1
************************************************************
*** PROPIEDADES ***
Top = 10
Left = 14
Height = 12
Width = 130
Alignment = 0
Caption = "Seleccionar todo"
Name = "Clscheckbox1"

*** METODOS ***
PROCEDURE Click
LOCAL lnSelected
lnSelected = IIF(This.Value = 1, .T., .F.)

SELECT cur_resumen
GO TOP
SCAN
	REPLACE Selected WITH lnSelected
ENDSCAN

Thisform.grdResumen.Refresh()
ENDPROC


************************************************************
OBJETO: cls_envio_resumen_ctactecli
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


