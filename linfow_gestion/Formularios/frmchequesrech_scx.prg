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
OBJETO: FRMCHEQUESRECH
************************************************************
*** PROPIEDADES ***
Height = 500
Width = 776
DoCreate = .T.
Caption = "Listado de Cheques Rechazados"
WindowType = 0
WindowState = 0
Name = "FRMCHEQUESRECH"

*** METODOS ***
PROCEDURE limpiar

thisform.contenedor.contenedor1.sel_ClienteDesde.txtCodigo.Enabled = .F.
thisform.contenedor.contenedor1.sel_ClienteHasta.txtCodigo.Enabled = .F.
thisform.contenedor.contenedor2.sel_BancoDesde.txtCodigo.Enabled = .F.
thisform.contenedor.contenedor2.sel_BancoHasta.txtCodigo.Enabled = .F.

thisform.contenedor.contenedor3.txtfecemisdesde.Value = DATE(2013,01,01)
thisform.contenedor.contenedor3.txtFecEmisHasta.Value = DATE()

thisform.contenedor.contenedor4.txtFecVtoDesde.Value = DATE(2013,01,01)
thisform.contenedor.contenedor4.txtFecVtoHasta.Value = DATE(2099,12,31)

thisform.contenedor.contenedor1.sel_ClienteDesde.blanquear()
thisform.contenedor.contenedor1.sel_ClienteHasta.blanquear()
thisform.contenedor.contenedor2.sel_BancoDesde.blanquear()
thisform.contenedor.contenedor2.sel_BancoHasta.blanquear()

thisform.contenedor.contenedor1.sel_ClienteDesde.valcpoid = 0
thisform.contenedor.contenedor1.sel_ClienteHasta.valcpoid = 0
thisform.contenedor.contenedor2.sel_BancoDesde.valcpoid = 0
thisform.contenedor.contenedor2.sel_BancoHasta.valcpoid = 0

SELECT cur_chequescar
ZAP
ENDPROC
PROCEDURE Load
DODEFAULT()

CREATE CURSOR cur_chequescar(;
	Codigo			int,;
	RazSoc			C(60),;
	NroCheque		C(8),;
	CodBco			C(5),;
	Banco			C(60),;
	Tipo			C(1),;
	Importe			float(10,2),;
	FecEmis			date,;
	FecVto			date,;
	tipoDoc			varchar(5),;
	nroCUIT			varchar(20),;
	titular			varchar(60),;
	NroRec			varchar(13))
	

SELECT cur_chequescar
INDEX ON Codigo	TAG Codigo ASCENDING
INDEX ON RazSoc TAG RazSoc ASCENDING ADDITIVE
INDEX ON NroCheque TAG NroCheque ASCENDING ADDITIVE
INDEX ON CodBco TAG CodBco ASCENDING ADDITIVE
INDEX ON Banco TAG Banco ASCENDING ADDITIVE
INDEX ON Tipo TAG Tipo ASCENDING ADDITIVE
INDEX ON Importe TAG Importe ASCENDING ADDITIVE
INDEX ON FecEmis TAG FecEmis ASCENDING ADDITIVE
INDEX ON FecVto TAG FecVto ASCENDING ADDITIVE
INDEX ON tipoDoc TAG tipoDoc ASCENDING ADDITIVE
INDEX ON nroCUIT TAG nroCUIT ASCENDING ADDITIVE
INDEX ON titular TAG titular ASCENDING ADDITIVE
INDEX ON NroRec TAG NroRec ASCENDING ADDITIVE

SELECT cur_chequescar
SET ORDER TO TAG NroCheque ASCENDING 
ENDPROC
PROCEDURE Init

thisform.contenedor.contenedor1.sel_ClienteDesde.txtCodigo.Enabled = .F.
thisform.contenedor.contenedor1.sel_ClienteHasta.txtCodigo.Enabled = .F.
thisform.contenedor.contenedor2.sel_BancoDesde.txtCodigo.Enabled = .F.
thisform.contenedor.contenedor2.sel_BancoHasta.txtCodigo.Enabled = .F.

thisform.contenedor.contenedor3.txtfecemisdesde.Value = DATE(2013,01,01)
thisform.contenedor.contenedor3.txtFecEmisHasta.Value = DATE()

thisform.contenedor.contenedor4.txtFecVtoDesde.Value = DATE(2013,01,01)
thisform.contenedor.contenedor4.txtFecVtoHasta.Value = DATE(2099,12,31)

ENDPROC


************************************************************
OBJETO: Contenedor
************************************************************
*** PROPIEDADES ***
Top = 4
Left = 4
Width = 768
Height = 492
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
Caption = "Bancos"
Left = 15
Top = 93
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Fecha de Emisión"
Height = 15
Left = 14
Top = 178
Width = 107
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Fecha de Vencimiento"
Height = 15
Left = 374
Top = 177
Width = 143
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: grdCheques
************************************************************
*** PROPIEDADES ***
Height = 203
Left = 8
Top = 238
Width = 752
alias_name = cur_chequescar
titulos_cabeceras = Código,Razon Social, N° Cheque,Cod. Banco, Banco,Tipo,Importe,Fec. Emisión, Fec. Vto,Tipo Doc.,Nro. Doc.,Titular,Nro. Recibo
list_controlsource = Codigo,Razsoc,Nrocheque,codbco,banco,tipo,importe,fecemis,fecvto,tipoDoc,nroCUIT,titular,NroRec
lista_ancho_cols = 70,150,100,70,150,50,70,80,80,70,70,150,100
Name = "grdCheques"
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
COLUMN11.Header1.Alignment = 2
COLUMN11.Header1.Name = "Header1"
COLUMN11.Text1.Name = "Text1"
COLUMN11.Name = "COLUMN11"
COLUMN12.Header1.Alignment = 2
COLUMN12.Header1.Name = "Header1"
COLUMN12.Text1.Name = "Text1"
COLUMN12.Name = "COLUMN12"
COLUMN13.Header1.Alignment = 2
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
PROCEDURE COLUMN11.Header1.Click
IF This.Parent.Parent.permitir_busqueda
	This.Parent.Parent.ordenar_datos(This.Parent.ControlSource)
ENDIF
ENDPROC
PROCEDURE COLUMN11.Text1.KeyPress
LPARAMETERS nKeyCode, nShiftAltCtrl

IF nKeyCode = 5 .Or. nKeyCode = 4 .Or. nKeyCode = 19 .Or. nKeyCode = 24
	This.Parent.Parent.pos_actual_texto = 0
	This.Parent.Parent.texto_busqueda = ""
ENDIF

IF This.Parent.Parent.permitir_busqueda
	This.Parent.Parent.localizar_registros(This.Parent.ControlSource, This.Parent.ControlSource, nKeyCode)
	This.Parent.Parent.Refresh()
ENDIF

IF nKeyCode = 13
	this.Parent.Parent.press_enter()
ENDIF
ENDPROC
PROCEDURE COLUMN12.Header1.Click
IF This.Parent.Parent.permitir_busqueda
	This.Parent.Parent.ordenar_datos(This.Parent.ControlSource)
ENDIF
ENDPROC
PROCEDURE COLUMN12.Text1.KeyPress
LPARAMETERS nKeyCode, nShiftAltCtrl

IF nKeyCode = 5 .Or. nKeyCode = 4 .Or. nKeyCode = 19 .Or. nKeyCode = 24
	This.Parent.Parent.pos_actual_texto = 0
	This.Parent.Parent.texto_busqueda = ""
ENDIF

IF This.Parent.Parent.permitir_busqueda
	This.Parent.Parent.localizar_registros(This.Parent.ControlSource, This.Parent.ControlSource, nKeyCode)
	This.Parent.Parent.Refresh()
ENDIF

IF nKeyCode = 13
	this.Parent.Parent.press_enter()
ENDIF
ENDPROC
PROCEDURE COLUMN13.Header1.Click
IF This.Parent.Parent.permitir_busqueda
	This.Parent.Parent.ordenar_datos(This.Parent.ControlSource)
ENDIF
ENDPROC
PROCEDURE COLUMN13.Text1.KeyPress
LPARAMETERS nKeyCode, nShiftAltCtrl

IF nKeyCode = 5 .Or. nKeyCode = 4 .Or. nKeyCode = 19 .Or. nKeyCode = 24
	This.Parent.Parent.pos_actual_texto = 0
	This.Parent.Parent.texto_busqueda = ""
ENDIF

IF This.Parent.Parent.permitir_busqueda
	This.Parent.Parent.localizar_registros(This.Parent.ControlSource, This.Parent.ControlSource, nKeyCode)
	This.Parent.Parent.Refresh()
ENDIF

IF nKeyCode = 13
	this.Parent.Parent.press_enter()
ENDIF
ENDPROC


************************************************************
OBJETO: Clscerrar1
************************************************************
*** PROPIEDADES ***
Top = 445
Left = 714
Name = "Clscerrar1"

*** METODOS ***


************************************************************
OBJETO: Clscancelar1
************************************************************
*** PROPIEDADES ***
Top = 445
Left = 10
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
Top = 111
Left = 13
Width = 696
Height = 63
BackColor = 240,240,240
BorderColor = 192,192,192
Name = "Contenedor2"

*** METODOS ***


************************************************************
OBJETO: Sel_BancoDesde
************************************************************
*** PROPIEDADES ***
Top = 4
Left = 206
TabIndex = 7
esnumerico = .F.
cfieldname = codbco
nombre_campo_codigo = codbco
nombre_campo_desc = descripcio
nombre_tabla = bancos
pkfield = codbco
autocompletar_ceros = .F.
Name = "Sel_BancoDesde"
txtCodigo.Value = 
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: Sel_BancoHasta
************************************************************
*** PROPIEDADES ***
Top = 34
Left = 206
TabIndex = 8
cfieldname = codbco
esnumerico = .F.
nombre_campo_codigo = codbco
nombre_campo_desc = descripcio
nombre_tabla = bancos
pkfield = codbco
autocompletar_ceros = .F.
Name = "Sel_BancoHasta"
txtCodigo.Value = 
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
OBJETO: Contenedor3
************************************************************
*** PROPIEDADES ***
Top = 196
Left = 14
Width = 334
Height = 34
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
OBJETO: Contenedor4
************************************************************
*** PROPIEDADES ***
Top = 196
Left = 374
Width = 334
Height = 34
BackColor = 240,240,240
BorderColor = 192,192,192
Name = "Contenedor4"

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
OBJETO: txtFecVtoDesde
************************************************************
*** PROPIEDADES ***
Left = 58
TabIndex = 11
Top = 7
isdatetime = .T.
Name = "txtFecVtoDesde"

*** METODOS ***


************************************************************
OBJETO: txtFecVtoHasta
************************************************************
*** PROPIEDADES ***
Left = 221
TabIndex = 12
Top = 7
isdatetime = .T.
Name = "txtFecVtoHasta"

*** METODOS ***


************************************************************
OBJETO: ClsExcel
************************************************************
*** PROPIEDADES ***
Top = 445
Left = 57
Name = "ClsExcel"

*** METODOS ***
PROCEDURE Click
SELECT cur_chequescar
IF RECCOUNT() > 0
	genexcel("cur_chequescar","Listado de Cheques en Rechazados")
ELSE 
	MESSAGEBOX("No hay registros para exportar",0+48,Thisform.Caption)
	RETURN
ENDIF 
ENDPROC


************************************************************
OBJETO: Clsaceptar1
************************************************************
*** PROPIEDADES ***
Top = 191
Left = 714
Name = "Clsaceptar1"

*** METODOS ***
PROCEDURE Click
LOCAL loDateTime, loResult, lcFecEmisDesde, lcFecEmisHasta, lcFecVtoDesde, lcFecVtoHasta, lcSql
LOCAL lnIdCliDesde, lnIdCliHasta, lcCodBcoDesde, lcCodBcoHasta 

loDateTime = CREATEOBJECT("datetime")
loResult = CREATEOBJECT("odbc_result")

lcFecEmisDesde = loDateTime.toMySql(thisform.contenedor.contenedor3.txtfecemisdesde.Value)
lcFecEmisHasta = loDateTime.toMySql(thisform.contenedor.contenedor3.txtFecEmisHasta.Value)
lcFecVtoDesde = loDateTime.toMySql(thisform.contenedor.contenedor4.txtFecVtoDesde.Value)
lcFecVtoHasta = loDateTime.toMySql(thisform.contenedor.contenedor4.txtFecVtoHasta.Value)

IF thisform.contenedor.contenedor1.sel_ClienteDesde.valcpoid <> 0 .AND. thisform.contenedor.contenedor1.sel_ClienteHasta.valcpoid <> 0
	lnIdCliDesde = thisform.contenedor.contenedor1.sel_ClienteDesde.valcpoid
	lnIdCliHasta = thisform.contenedor.contenedor1.sel_ClienteHasta.valcpoid
ELSE
	lnIdCliDesde = 0
	lnIdCliHasta = 999999
ENDIF

IF !(ALLTRIM(thisform.contenedor.contenedor2.sel_BancoDesde.txtCodigo.Value) == "") .AND. !(ALLTRIM(thisform.contenedor.contenedor2.sel_BancoHasta.txtCodigo.Value) == "")
	lcCodBcoDesde= thisform.contenedor.contenedor2.sel_BancoDesde.txtCodigo.Value
	lcCodBcoHasta = thisform.contenedor.contenedor2.sel_BancoHasta.txtCodigo.Value
ELSE
	lcCodBcoDesde = "0"
	lcCodBcoHasta = "999999"
ENDIF

lcSql = " SELECT clientes.idcliente, "
lcSql = lcSql + " clientes.razsoc, "
lcSql = lcSql + " cheques.chq_nro, "
lcSql = lcSql + " bancos.codbco, "
lcSql = lcSql + " bancos.descripcio, "
lcSql = lcSql + " cheques.tipo, "
lcSql = lcSql + " cheques.tipoDoc, "
lcSql = lcSql + " cheques.nroCUIT, "
lcSql = lcSql + " cheques.titular, "
lcSql = lcSql + " cheques.importe, "
lcSql = lcSql + " cheques.fecemis, "
lcSql = lcSql + " cheques.fecvto, "
lcSql = lcSql + " cheques.NroRec "
lcSql = lcSql + " FROM    cheques "
lcSql = lcSql + " 	  	  left join clientes on cheques.idcliente = clientes.idcliente "
lcSql = lcSql + "         inner join bancos on cheques.idbanco = bancos.idbanco "
lcSql = lcSql + " WHERE   cheques.estado = 'R' "
lcSql = lcSql + "         and cheques.fecemis between " + lcFecEmisDesde + " and " + lcFecEmisHasta + " "
lcSql = lcSql + "         and cheques.fecvto between " + lcFecVtoDesde + " and " + lcFecVtoHasta + " "
lcSql = lcSql + "         and bancos.codbco between '" + lcCodBcoDesde + "' and '" + lcCodBcoHasta + "' "

IF INT(VAL(getconfig("SQLSRV"))) = 1 THEN
	lcSql = lcSql + "         and ISNULL(clientes.idcliente,0) >= " + ALLTRIM(STR(lnIdCliDesde)) + " and ISNULL(clientes.idcliente,0) <= " +  ALLTRIM(STR(lnIdCliHasta)) + " "
ELSE
	lcSql = lcSql + "         and IFNULL(clientes.idcliente,0) >= " + ALLTRIM(STR(lnIdCliDesde)) + " and IFNULL(clientes.idcliente,0) <= " +  ALLTRIM(STR(lnIdCliHasta)) + " "
ENDIF 

lcSql = lcSql + " ORDER BY cheques.chq_nro "

loResult.ActiveConnection = goConn.ActiveConnection
loResult.cursor_name = "cur_tempo"
loResult.OpenQuery(lcSql) 

SELECT cur_tempo
IF RECCOUNT() > 0      
 GO TOP 
ENDIF

SELECT cur_chequescar
ZAP

SELECT cur_tempo
DO WHILE !EOF()
	SELECT cur_chequescar
	APPEND BLANK
	REPLACE Codigo WITH IIF(ISNULL(cur_tempo.idcliente), 0, cur_tempo.idcliente)
	REPLACE RazSoc WITH IIF(ISNULL(cur_tempo.razsoc), "", cur_tempo.razsoc) ADDITIVE
	REPLACE NroCheque WITH cur_tempo.chq_nro ADDITIVE 
	REPLACE CodBco WITH cur_tempo.codbco ADDITIVE 
	REPLACE Banco WITH cur_tempo.descripcio ADDITIVE 
	REPLACE Tipo WITH cur_tempo.tipo ADDITIVE 
	REPLACE Importe WITH cur_tempo.importe ADDITIVE 
	REPLACE FecEmis WITH cur_tempo.fecemis ADDITIVE 
	REPLACE FecVto WITH cur_tempo.fecvto ADDITIVE 
	REPLACE tipoDoc WITH IIF(ISNULL(cur_tempo.tipoDoc), "", cur_tempo.tipoDoc) ADDITIVE
	REPLACE nroCUIT WITH IIF(ISNULL(cur_tempo.nroCUIT), "", cur_tempo.nroCUIT) ADDITIVE
	REPLACE titular WITH IIF(ISNULL(cur_tempo.titular), "", cur_tempo.titular) ADDITIVE
	REPLACE NroRec	WITH cur_tempo.NroRec ADDITIVE 
	
	SELECT cur_tempo
	SKIP 
ENDDO 

loResult.close_query()

SELECT cur_chequescar
IF RECCOUNT() > 0
	GO top
ENDIF 

thisform.contenedor.grdCheques.Refresh()
ENDPROC


************************************************************
OBJETO: ClsImprimir
************************************************************
*** PROPIEDADES ***
Top = 445
Left = 104
Name = "ClsImprimir"

*** METODOS ***
PROCEDURE Click
LOCAL m.fecha, m.clidesde, m.clihasta, m.bandesde, m.banhasta, m.femisd, m.femish, m.fvtod, m.fvtoh, m.titulo

SELECT cur_chequescar
IF RECCOUNT() > 0
	GO TOP 
ELSE 
	MESSAGEBOX("No hay registros para mostrar",0+48,Thisform.Caption)
	RETURN
ENDIF 

m.fecha = DATETIME()
m.clidesde = thisform.contenedor.contenedor1.sel_ClienteDesde.txtCodigo.Value
m.clihasta = thisform.contenedor.contenedor1.sel_ClienteHasta.txtCodigo.Value
m.bandesde = thisform.contenedor.contenedor2.sel_BancoDesde.txtCodigo.Value
m.banhasta = thisform.contenedor.contenedor2.sel_BancoHasta.txtCodigo.Value
m.femisd = thisform.contenedor.contenedor3.txtFecEmisDesde.Value
m.femish = thisform.contenedor.contenedor3.txtFecEmisHasta.Value
m.fvtod = thisform.contenedor.contenedor4.txtFecVtoDesde.Value
m.fvtoh = thisform.contenedor.contenedor4.txtFecVtoHasta.Value 
m.titulo = "Listado de Cheques Rechazados"
SELECT cur_chequescar
REPORT FORM repcheqcar TO PRINTER PROMPT PREVIEW 
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
Top = 118
Width = 71
Name = "Optiongroup2"
Option1.FontBold = .T.
Option1.Caption = "Todos"
Option1.Value = 1
Option1.Height = 17
Option1.Left = 5
Option1.Top = 6
Option1.Width = 61
Option1.Name = "optBanTodos"
Option2.FontBold = .T.
Option2.Caption = "Filtrar"
Option2.Height = 17
Option2.Left = 5
Option2.Top = 35
Option2.Width = 61
Option2.Name = "optBanFiltrar"

*** METODOS ***
PROCEDURE optBanTodos.Click
IF this.Value = 1
	thisform.contenedor.contenedor2.sel_BancoDesde.txtCodigo.Enabled = .F.
	thisform.contenedor.contenedor2.sel_BancoHasta.txtCodigo.Enabled = .F.
	thisform.contenedor.contenedor2.sel_BancoDesde.blanquear()
	thisform.contenedor.contenedor2.sel_BancoHasta.blanquear()
	thisform.contenedor.contenedor2.sel_BancoDesde.valcpoid = 0
	thisform.contenedor.contenedor2.sel_BancoHasta.valcpoid = 0
ENDIF

ENDPROC
PROCEDURE optBanFiltrar.Click
IF this.Value = 1
	thisform.contenedor.contenedor2.sel_BancoDesde.txtCodigo.Enabled = .T.
	thisform.contenedor.contenedor2.sel_BancoHasta.txtCodigo.Enabled = .T.
ENDIF

ENDPROC


************************************************************
OBJETO: Optiongroup1
************************************************************
*** PROPIEDADES ***
ButtonCount = 2
BorderStyle = 0
Value = 1
Height = 58
Left = 27
Top = 34
Width = 71
Name = "Optiongroup1"
Option1.FontBold = .T.
Option1.Caption = "Todos"
Option1.Value = 1
Option1.Height = 17
Option1.Left = 5
Option1.Top = 6
Option1.Width = 61
Option1.Name = "optCliTodos"
Option2.FontBold = .T.
Option2.Caption = "Filtrar"
Option2.Height = 17
Option2.Left = 5
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
ENDIF
ENDPROC


************************************************************
OBJETO: 
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 9, 6, 15, 12, 32, 3, 0

*** METODOS ***


