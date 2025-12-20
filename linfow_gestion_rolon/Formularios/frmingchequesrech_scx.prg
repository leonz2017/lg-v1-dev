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
OBJETO: FRMINGCHEQUESRECH
************************************************************
*** PROPIEDADES ***
Height = 220
Width = 669
DoCreate = .T.
Caption = "Ingreso de Cheques Rechazados"
WindowType = 0
Name = "FRMINGCHEQUESRECH"

*** METODOS ***
PROCEDURE limpiar

thisform.contenedor.contenedor1.sel_BancoDesde.txtCodigo.Enabled = .T.
thisform.contenedor.contenedor1.txtNroCheque.Enabled = .T.

thisform.contenedor.contenedor1.sel_BancoDesde.blanquear()
thisform.contenedor.contenedor1.txtNroCheque.Value = ""
thisform.contenedor.contenedor1.txtImporte.Value = 0.00

thisform.contenedor.contenedor1.sel_BancoDesde.valcpoid = 0

thisform.contenedor.clsgrabar1.Enabled = .F.

thisform.contenedor.contenedor1.sel_BancoDesde.SetFocus()

SELECT cur_cheques
ZAP
ENDPROC
PROCEDURE Load
DODEFAULT()

CREATE CURSOR cur_cheques(;
	Codigo			int,;
	RazSoc			C(60),;
	NroCheque		C(20),;
	IdBanco			int,;
	CodBco			C(5),;
	Banco			C(60),;
	Tipo			C(1),;
	Importe			float(10,2),;
	FecEmis			datetime,;
	FecVto			datetime)

ENDPROC
PROCEDURE Init
thisform.contenedor.contenedor1.sel_BancoDesde.txtCodigo.SetFocus()
thisform.contenedor.clsgrabar1.Enabled = .F.
ENDPROC


************************************************************
OBJETO: Contenedor
************************************************************
*** PROPIEDADES ***
Top = 3
Left = 4
Width = 660
Height = 212
BackColor = 241,236,235
Name = "Contenedor"

*** METODOS ***


************************************************************
OBJETO: CLSETIQUETA1
************************************************************
*** PROPIEDADES ***
Caption = "Datos del cheque"
Height = 15
Left = 15
Top = 9
Width = 113
Name = "CLSETIQUETA1"

*** METODOS ***


************************************************************
OBJETO: Clscerrar1
************************************************************
*** PROPIEDADES ***
Top = 165
Left = 604
Name = "Clscerrar1"

*** METODOS ***


************************************************************
OBJETO: Clscancelar1
************************************************************
*** PROPIEDADES ***
Top = 165
Left = 12
Name = "Clscancelar1"

*** METODOS ***
PROCEDURE Click
thisform.limpiar()
ENDPROC


************************************************************
OBJETO: Contenedor1
************************************************************
*** PROPIEDADES ***
Top = 33
Left = 13
Width = 635
Height = 125
BackColor = 240,240,240
BorderColor = 192,192,192
Name = "Contenedor1"

*** METODOS ***


************************************************************
OBJETO: sel_BancoDesde
************************************************************
*** PROPIEDADES ***
Top = 8
Left = 86
TabIndex = 2
esnumerico = .F.
cfieldname = codbco
nombre_campo_codigo = codbco
nombre_campo_desc = descripcio
nombre_tabla = bancos
pkfield = codbco
autocompletar_ceros = .F.
Name = "sel_BancoDesde"
txtCodigo.Value = 
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Banco:"
Height = 15
Left = 16
Top = 15
Width = 48
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Nº Cheque:"
Height = 15
Left = 16
Top = 42
Width = 72
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: txtNroCheque
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 88
MaxLength = 20
TabIndex = 3
Top = 37
Width = 243
ischaracter = .T.
autocompleta = .F.
Name = "txtNroCheque"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Importe:"
Height = 15
Left = 16
Top = 69
Width = 72
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: txtImporte
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Left = 88
Top = 64
isnumeric = .T.
Name = "txtImporte"

*** METODOS ***


************************************************************
OBJETO: Clsaceptar1
************************************************************
*** PROPIEDADES ***
Top = 5
Left = 581
TabIndex = 4
Name = "Clsaceptar1"

*** METODOS ***
PROCEDURE Click
LOCAL loResult, lcSql, lcCodBco, lcNroCheque

loResult = CREATEOBJECT("odbc_result")

IF ALLTRIM(thisform.contenedor.contenedor1.sel_BancoDesde.txtCodigo.Value) == ""
	MESSAGEBOX("Debe ingresar el Banco",0+48,"Ingreso de Cheques Rechazados")
	return
ELSE 
	lcCodBco = thisform.contenedor.contenedor1.sel_BancoDesde.txtCodigo.Value
ENDIF

IF ALLTRIM(thisform.contenedor.contenedor1.txtNroCheque.Value) == ""
	MESSAGEBOX("Debe ingresar el Nº de Cheque ",0+48,"Ingreso de Cheques Rechazados")
	return
ELSE
	lcNroCheque = thisform.contenedor.contenedor1.txtNroCheque.Value
ENDIF

lcSql = " SELECT  clientes.idcliente, "
lcSql = lcSql + " clientes.razsoc, "
lcSql = lcSql + " cheques.chq_nro, "
lcSql = lcSql + " bancos.idbanco, "
lcSql = lcSql + " bancos.codbco, "
lcSql = lcSql + " bancos.descripcio, "
lcSql = lcSql + " cheques.tipo, "
lcSql = lcSql + " cheques.importe, "
lcSql = lcSql + " cheques.fecemis, "
lcSql = lcSql + " cheques.fecvto "
lcSql = lcSql + " FROM    cheques "
lcSql = lcSql + " 	  	  inner join clientes on cheques.idcliente = clientes.idcliente "
lcSql = lcSql + "         inner join bancos on cheques.idbanco = bancos.idbanco "
lcSql = lcSql + " WHERE   cheques.estado in ('D', 'U', 'T') "
lcSql = lcSql + "         and bancos.codbco = '" + lcCodBco + "'"
lcSql = lcSql + "         and cheques.chq_nro = '" + lcNroCheque + "'"

loResult.ActiveConnection = goConn.ActiveConnection
loResult.cursor_name = "cur_tempo"
loResult.OpenQuery(lcSql) 

SELECT cur_tempo
IF RECCOUNT() > 0      
 GO TOP 
ENDIF

SELECT cur_cheques
ZAP


SELECT cur_tempo
DO WHILE !EOF()
	SELECT cur_cheques
	APPEND BLANK
	REPLACE Codigo WITH cur_tempo.idcliente
	REPLACE RazSoc WITH cur_tempo.razsoc ADDITIVE
	REPLACE NroCheque WITH cur_tempo.chq_nro ADDITIVE 
	REPLACE IdBanco WITH cur_tempo.IdBanco ADDITIVE 
	REPLACE CodBco WITH cur_tempo.codbco ADDITIVE 
	REPLACE Banco WITH cur_tempo.descripcio ADDITIVE 
	REPLACE Tipo WITH cur_tempo.tipo ADDITIVE 
	REPLACE Importe WITH cur_tempo.importe ADDITIVE 
	REPLACE FecEmis WITH cur_tempo.fecemis ADDITIVE 
	REPLACE FecVto WITH cur_tempo.fecvto ADDITIVE 
	
	SELECT cur_tempo
	SKIP 
ENDDO 

loResult.close_query()

SELECT cur_cheques
IF RECCOUNT() > 0
	GO top
ENDIF 

IF RECCOUNT() >0
	thisform.contenedor.contenedor1.txtImporte.Value = cur_cheques.importe
	thisform.contenedor.contenedor1.sel_BancoDesde.txtCodigo.Enabled = .F.
	thisform.contenedor.contenedor1.txtNroCheque.Enabled = .F.
	thisform.contenedor.clsgrabar1.Enabled = .T.
	thisform.contenedor.clsgrabar1.SetFocus()
ELSE 
	MESSAGEBOX("El cheque no existe",0+48,"Ingreso de Cheques Rechazados")
ENDIF 

ENDPROC


************************************************************
OBJETO: Clsgrabar1
************************************************************
*** PROPIEDADES ***
Top = 165
Left = 557
TabIndex = 5
Name = "Clsgrabar1"

*** METODOS ***
PROCEDURE Click
LOCAL loResult, lcSql

&& Inicio la transacción
goConn.BeginTransaction()	

loCommand = CREATEOBJECT("odbc_command")

lcSql = " Update  cheques "
lcSql = lcSql + " SET cheques.estado = 'R' "
lcSql = lcSql + " WHERE   cheques.estado in ('D','U','T') "
lcSql = lcSql + "         and cheques.idcliente = " + ALLTRIM(STR(cur_cheques.codigo))
lcSql = lcSql + "         and cheques.idbanco = " + ALLTRIM(STR(cur_cheques.idbanco))
lcSql = lcSql + "         and cheques.chq_nro = '" + cur_cheques.nrocheque + "'"

loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.commandtext = lcSql

IF !loCommand.execute()
	goConn.Rollback()
	RETURN .F.
ENDIF 

SELECT cur_cheques
ZAP

goConn.Commit()

MESSAGEBOX("El cheque rechazado se ingresó correctamente",0+64,"Ingreso de Cheques Rechazados")

thisform.limpiar()
ENDPROC


************************************************************
OBJETO: Clslinea1
************************************************************
*** PROPIEDADES ***
Height = 0
Left = 15
Top = 25
Width = 634
Name = "Clslinea1"

*** METODOS ***


************************************************************
OBJETO: 
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


