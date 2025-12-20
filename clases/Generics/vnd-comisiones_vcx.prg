************************************************************
OBJETO: cls_form_calccomis
************************************************************
*** PROPIEDADES ***
BorderStyle = 2
Height = 512
Width = 946
DoCreate = .T.
Caption = "Comisiones de vendedores"
Name = "cls_form_calccomis"
CONTENIDO.Name = "CONTENIDO"

*** METODOS ***
PROCEDURE Init
DODEFAULT()
THISFORM.comisiones.crear_cursor()

SELECT cur_movcom
ZAP

SELECT cur_movcom
THISFORM.Contenido.grdComisiones.alias_name = "cur_movcom"
THISFORM.Contenido.grdComisiones.RecordSource = "cur_movcom"
THISFORM.Contenido.grdComisiones.list_controlsource = "fecRC,idCliente,razSoc,nroRec,impRC,porComis,importe"
THISFORM.Contenido.grdComisiones.lista_ancho_cols = "100,70,250,100,100,100,100"
THISFORM.Contenido.grdComisiones.titulos_cabeceras = "Fecha,Cliente,Razón Social,Nro Rec.,Imp. RC.,% Com.,Importe"
THISFORM.Contenido.grdComisiones.generar_grid()

THISFORM.Contenido.btnGrabar.Enabled = .F.
THISFORM.Contenido.txtFecDesde.Value = CTOD("01/" + ALLTRIM(STR(MONTH(DATE()))) + "/" + ALLTRIM(STR(YEAR(DATE()))))
THISFORM.Contenido.txtFecHasta.Value = DATE()
ENDPROC


************************************************************
OBJETO: comisiones
************************************************************
*** PROPIEDADES ***
Top = 480
Left = 816
Height = 17
Width = 24
Name = "comisiones"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Vendedor:"
Height = 15
Left = 12
Top = 13
Width = 72
TabIndex = 8
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: sel_vendedor
************************************************************
*** PROPIEDADES ***
Top = 9
Left = 96
TabIndex = 1
autocompletar_ceros = .F.
esnumerico = .T.
nombre_campo_codigo = idVendedor
nombre_campo_desc = nombre
nombre_tabla = vendedores
pkfield = idVendedor
Name = "sel_vendedor"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: btnBuscar
************************************************************
*** PROPIEDADES ***
Top = 10
Left = 582
Height = 46
Width = 56
TabIndex = 4
ToolTipText = "Calcular"
Name = "btnBuscar"

*** METODOS ***
PROCEDURE Click
IF THISFORM.Contenido.sel_vendedor.valcpoid = 0 THEN
	MESSAGEBOX("Debe ingresar el vendedor", 0+48, THISFORM.Caption)
	THISFORM.Contenido.sel_vendedor.txtCodigo.SetFocus()
	RETURN
ENDIF

IF !THISFORM.Comisiones.calcular_comision(THISFORM.Contenido.sel_vendedor.valcpoid, THISFORM.Contenido.txtFecDesde.Value, THISFORM.Contenido.txtFecHasta.Value) THEN
	MESSAGEBOX(THISFORM.Comisiones.ErrorMessage, 0+48, Thisform.Caption)
	RETURN
ENDIF

SELECT cur_movcom
IF RECCOUNT("cur_movcom") > 0 THEN
	GO TOP
ENDIF

THISFORM.Contenido.grdComisiones.Refresh()
THISFORM.Contenido.txtTotal.Value = ROUND(THISFORM.Comisiones.total, 2)
THISFORM.Contenido.btnGrabar.Enabled = .T.
ENDPROC


************************************************************
OBJETO: grdComisiones
************************************************************
*** PROPIEDADES ***
Height = 360
Left = 5
TabIndex = 9
Top = 61
Width = 938
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdComisiones"
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
OBJETO: btnGrabar
************************************************************
*** PROPIEDADES ***
Top = 461
Left = 853
TabIndex = 5
Name = "btnGrabar"

*** METODOS ***
PROCEDURE Click
LOCAL m.idVendedor
LOCAL m.nombre
LOCAL m.total
LOCAL m.fecdesde
LOCAL m.fechasta

m.idVendedor = THISFORM.Contenido.sel_vendedor.valcpoid
m.nombre = THISFORM.Contenido.sel_vendedor.txtDescripcion.Value
m.total = THISFORM.Contenido.txtTotal.Value
m.fecdesde = THISFORM.Contenido.txtFecDesde.Value
m.fechasta = THISFORM.Contenido.txtFecHasta.Value

IF !THISFORM.Comisiones.grabar(THISFORM.Contenido.sel_vendedor.valcpoid) THEN
	MESSAGEBOX(THISFORM.Comisiones.ErrorMessage, 0+48, THISFORM.Caption)
	RETURN
ENDIF

THISFORM.Contenido.btnGrabar.Enabled = .F.

THISFORM.Contenido.sel_vendedor.blanquear()

REPORT FORM "rep-liq-comisiones" TO PRINTER PROMPT
SELECT cur_movcom
ZAP

THISFORM.Contenido.grdComisiones.Refresh()
THISFORM.Contenido.txtTotal.Value = 0.00
THISFORM.Contenido.btnGrabar.Enabled = .F.
THISFORM.Contenido.sel_vendedor.txtCodigo.SetFocus()
THISFORM.Refresh()


ENDPROC


************************************************************
OBJETO: btnSalir
************************************************************
*** PROPIEDADES ***
Top = 461
Left = 899
TabIndex = 6
Name = "btnSalir"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Total a liquidar:"
Left = 714
Top = 428
TabIndex = 10
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: txtTotal
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 805
TabIndex = 11
Top = 425
Width = 137
Name = "txtTotal"

*** METODOS ***


************************************************************
OBJETO: btnNuevo
************************************************************
*** PROPIEDADES ***
Top = 461
Left = 6
TabIndex = 7
Name = "btnNuevo"

*** METODOS ***
PROCEDURE Click
THISFORM.Contenido.sel_vendedor.blanquear()

SELECT cur_movcom
ZAP

THISFORM.Contenido.grdComisiones.Refresh()
THISFORM.Contenido.txtTotal.Value = 0.00
THISFORM.Contenido.btnGrabar.Enabled = .F.
THISFORM.Contenido.sel_vendedor.txtCodigo.SetFocus()

ENDPROC


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Fecha desde:"
Height = 15
Left = 12
Top = 37
Width = 75
TabIndex = 12
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Fecha hasta:"
Height = 15
Left = 203
Top = 37
Width = 75
TabIndex = 13
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: txtFecDesde
************************************************************
*** PROPIEDADES ***
Left = 98
TabIndex = 2
Top = 34
isdatetime = .T.
Name = "txtFecDesde"

*** METODOS ***


************************************************************
OBJETO: txtFecHasta
************************************************************
*** PROPIEDADES ***
Left = 279
TabIndex = 3
Top = 34
isdatetime = .T.
Name = "txtFecHasta"

*** METODOS ***


************************************************************
OBJETO: cls_form_calccomis
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_comisiones
************************************************************
*** PROPIEDADES ***
errormessage = 
total = 0.00
Name = "cls_comisiones"

*** METODOS ***
PROCEDURE crear_cursor
&& Este script permite crear el cursor con los movimientos de
&& comisiones

CREATE CURSOR cur_movcom (	;
	idMovCom	int,;
	idVendedor	int,;
	idRCCob_C	int,;
	idCliente	int,;
	razSoc		varchar(60),;
	fecRC		datetime,;
	nroRec		varchar(13),;
	impRC		float(10,2),;
	porComis	float(10,2),;
	importe		float(10,2))
	

ENDPROC
PROCEDURE calcular_comision
PARAMETERS tnIdVendedor, tdFecDesde, tdFecHasta

LOCAL loRes, lcSql
LOCAL loTherm, loDateTime

lcSql = ""
loRes = CREATEOBJECT("odbc_result")
loTherm = CREATEOBJECT("_thermometer")
loDateTime = CREATEOBJECT("datetime")

lcSql = "SELECT	clientes.idVendedor, "
lcSql = lcSql + " 	rccob_c.idRCCob_C, "
lcSql = lcSql + "	rccob_c.nroRec, "
lcSql = lcSql + "	clientes.idCliente, "
lcSql = lcSql + "	clientes.razSoc, "
lcSql = lcSql + "	rccob_c.fecEmis, "
lcSql = lcSql + "	rccob_c.nroRec, "
lcSql = lcSql + "	rccob_c.importe, "
lcSql = lcSql + "	vendedores.porComis, "
lcSql = lcSql + "	round(rccob_c.importe * (vendedores.porComis / 100), 2) as impComis "
lcSql = lcSql + "FROM	rccob_c	"
lcSql = lcSql + "	INNER JOIN clientes ON rccob_c.idCliente = clientes.idCliente "
lcSql = lcSql + "	INNER JOIN vendedores ON vendedores.idVendedor = clientes.idVendedor "
lcSql = lcSql + "WHERE	rccob_c.idRCCob_C NOT IN ( "
lcSql = lcSql + "			SELECT	movcom.idRCCob_C "
lcSql = lcSql + "			FROM	movcom) "
lcSql = lcSql + "	AND vendedores.idVendedor = " + ALLTRIM(STR(tnIdVendedor)) + " "
lcSql = lcSql + " AND rccob_c.fecBaja IS NULL "

IF INT(VAL(getConfig("SQLSRV"))) = 1 THEN
	lcSql = lcSql + " AND CONVERT(CHAR(8), fecemis, 112) BETWEEN " + loDateTime.toMySql(tdFecDesde) + " AND " + loDateTime.toMySql(tdFecHasta) + " "
ELSE
	lcSql = lcSql + " AND fecemis BETWEEN " + loDateTime.toMySql(tdFecDesde) + " AND " + loDateTime.toMySql(tdFecHasta) + " "
ENDIF

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_comis"

IF !loRes.OpenQuery(lcSql) THEN
	THIS.ErrorMessage = loRes.Error_Message
	RETURN .F.
ENDIF

loTherm.show()

THIS.total = 0.00

SELECT cur_comis
DO WHILE !EOF("cur_comis")
	SELECT cur_movcom
	APPEND BLANK
	REPLACE cur_movcom.idMovCom WITH 0
	REPLACE cur_movcom.idVendedor WITH tnIdVendedor ADDITIVE
	REPLACE cur_movcom.idRCCob_C WITH cur_comis.idRCCob_C ADDITIVE
	REPLACE cur_movcom.fecRC WITH cur_comis.fecEmis ADDITIVE
	REPLACE cur_movcom.nroRec WITH cur_comis.nroRec ADDITIVE
	REPLACE cur_movcom.idCliente WITH cur_comis.idCliente ADDITIVE
	REPLACE cur_movcom.razSoc WITH ALLTRIM(cur_comis.razSoc) ADDITIVE
	REPLACE cur_movcom.impRC WITH cur_comis.importe ADDITIVE
	REPLACE cur_movcom.porComis WITH cur_comis.porComis ADDITIVE
	REPLACE cur_movcom.importe WITH cur_comis.impComis ADDITIVE
	
	THIS.total = THIS.total + cur_comis.impComis
	loTherm.update((RECNO("cur_comis") * 100) / RECCOUNT("cur_comis"), "Calculando comisiones, espere por favor...")
	SELECT cur_comis
	SKIP
ENDDO

loTherm.Complete()
loRes.Close_Query()

RETURN .T.

ENDPROC
PROCEDURE grabar
PARAMETERS tnIdVendedor

LOCAL loCommand, lcSql
LOCAL loTherm, lnProxID

loCommand = CREATEOBJECT("odbc_command")
lcSql = ""
loTherm = CREATEOBJECT("_thermometer")
lnProxID = 0

SELECT cur_movcom
IF RECCOUNT("cur_movcom") > 0 THEN
	GO TOP
ENDIF

loTherm.Show()

goConn.BeginTransaction()
DO WHILE !EOF("cur_movcom")
	lnProxID = goConn.getNextID("movcom", "idMovCom")
	
	lcSql = "insert into movcom ( "
	lcSql = lcSql + "idMovCom, "
	lcSql = lcSql + "idVendedor, "
	lcSql = lcSql + "idRCCob_C, "
	lcSql = lcSql + "fecha, "
	lcSql = lcSql + "porComis, "
	lcSql = lcSql + "importe) "
	lcSql = lcSql + "VALUES ( "
	lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", "
	lcSql = lcSql + ALLTRIM(STR(tnIdVendedor)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_movcom.idRCCob_C)) + ", "
	lcSql = lcSql + IIF(INT(VAL(getConfig("SQLSRV"))) = 1, "GETDATE(), ", "current_timestamp, ")
	lcSql = lcSql + ALLTRIM(STR(cur_movcom.porComis, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_movcom.importe, 10, 2)) + ")"
	
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute() THEN
		goConn.Rollback()
		THIS.ErrorMessage = loCommand.ErrorMessage
		RETURN .F.
	ENDIF
	
	loTherm.update((RECNO("cur_movcom") * 100) / RECCOUNT("cur_movcom"), "Grabando comisiones...")
	SELECT cur_movcom
	SKIP
ENDDO

goConn.Commit()
RETURN .T.
ENDPROC


