************************************************************
OBJETO: cl_ingmov
************************************************************
*** PROPIEDADES ***
BorderStyle = 2
Height = 600
Width = 870
DoCreate = .T.
Caption = "Ingreso de Movimientos de Caja"
Closable = .F.
WindowType = 1
BackColor = 241,236,235
dialogresult = 0
idcliente = 0
Name = "cl_ingmov"

*** METODOS ***
PROCEDURE verificar_cajaabierta
LOCAL lcSql, loResult, lnCount

&& Verifico si se abrió la caja
lcSql = "SELECT COUNT(*) AS Cantidad FROM movcjacab WHERE estado = 'A'"
loResult = CREATEOBJECT("odbc_result")
lnCount = 0

loResult.Cursor_Name = "cur_tmp"
loResult.ActiveConnection = goConn.ActiveConnection
loResult.OpenQuery(lcSql)

IF TYPE("cur_tmp.Cantidad") == "C" THEN
	lnCount = INT(VAL(cur_tmp.Cantidad)) 
ELSE
	lnCount = cur_tmp.Cantidad
ENDIF

loResult.Close_Query()

IF lnCount = 0 THEN
	MESSAGEBOX("Debe realizar la apertura de caja antes de intentar generar movimientos", 0+48, Thisform.Caption)
	RETURN .F.
ELSE 
	lcSql = "SELECT idMovCjaC FROM movcjacab WHERE estado = 'A'"
	loResult.Cursor_Name = "cur_cab"
	loResult.ActiveConnection = goConn.ActiveConnection
	loResult.OpenQuery(lcSql)
	
	thisform.recibos.idmovcjac = cur_Cab.idMovCjaC
	
	loResult.Close_Query()
ENDIF
ENDPROC
PROCEDURE calc_saldoimputar
&& Calculo el importe del pago
LOCAL lnImputado

lnImputado = 0

lnImputado = Thisform.contenedor_efvo.txtImpEfvo.value + ;
	Thisform.contenedor_efvo.txtImpTC.Value + ;
	Thisform.contenedor_efvo.txtImpTD.Value + ;
	Thisform.contenedor_cheques.txtTotalRec.Value + ;
	Thisform.contenedor_ret.txtRetGan.Value + ;
	Thisform.contenedor_ret.txtRetIIBB.Value + ;
	Thisform.contenedor_ret.txtRetIVA.Value + ;
	Thisform.contenedor_ret.txtRetSUSS.Value

Thisform.txtPagoCon.Value = lnImputado


ENDPROC
PROCEDURE cargar_tipodoc
&& Cargo el combobox con los tipos de documento

LOCAL lcSql, loResult

lcSql = ""
loResult = CREATEOBJECT("odbc_result")

lcSql = "SELECT * FROM tipodoc"
loResult.ActiveConnection = goConn.ActiveConnection
loResult.cursor_name = "cur_tipodoc"

IF !loResult.OpenQuery(lcSql)
	MESSAGEBOX(loResult.error_message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF 

SELECT cur_tipodoc
IF RECCOUNT("cur_tipodoc") > 0 THEN 
	GO TOP
ELSE 
	RETURN .F.
ENDIF 

DO WHILE !EOF("cur_tipodoc")
	SELECT cur_tipodoc
	Thisform.contenedor_cheques.cmbTipoDoc.AddItem(ALLTRIM(cur_tipodoc.tipodoc))
	
	SKIP 
ENDDO 

loResult.close_query()

Thisform.contenedor_cheques.cmbTipoDoc.ListIndex = 1

ENDPROC
PROCEDURE validar_pago
&& Valido que se haya ingresado un concepto de caja
IF ALLTRIM(thisform.sel_ConcCJ.txtCodigo.Value) == "" THEN 
	MESSAGEBOX("Debe ingresar el concepto", 0+48, Thisform.Caption)
	thisform.sel_ConcCJ.txtCodigo.SetFocus()
	RETURN .F.
ENDIF 

&& Valido que se haya ingresado el cliente
*!*	IF thisform.sel_cliente.txtCodigo.Value = 0 THEN 
*!*		MESSAGEBOX("Debe ingresar el cliente", 0+48, Thisform.Caption)
*!*		thisform.sel_cliente.txtCodigo.SetFocus()
*!*		RETURN .F.
*!*	ENDIF 

thisform.idcliente = thisform.sel_cliente.txtCodigo.Value

&& Valido que se haya ingresado algun importe en el pago.
IF thisform.txtPagoCon.Value = 0 THEN 
	MESSAGEBOX("Debe ingresar el importe del pago", 0+48, Thisform.Caption)
	thisform.txtPagoCon.SetFocus()
	RETURN .F.
ENDIF 

&& Valido que los cheques ingresados no esten ya cargados en la base
IF !Thisform.recibos.validar_todosloscheques(thisform.idcliente)
	RETURN .F.
ENDIF 	

&& Valido que se ingresen todos los datos de IIBB
IF thisform.contenedor_Ret.txtRetIIBB.Value <> 0 THEN 
	IF thisform.contenedor_Ret.txtfecIIBB.Value = {} THEN 
		MESSAGEBOX("Debe ingresar la fecha de retención IIBB", 0+48, Thisform.Caption)
		thisform.contenedor_Ret.txtfecIIBB.SetFocus()
		RETURN .F.
	ENDIF 
	
	IF thisform.contenedor_Ret.txtCbteIIBB.Value = 0 THEN 
		MESSAGEBOX("Debe ingresar el Nº de comprobante de retención IIBB", 0+48, Thisform.Caption)
		thisform.contenedor_Ret.txtCbteIIBB.SetFocus()
		RETURN .F.
	ENDIF 
	
	IF thisform.contenedor_Ret.sel_provincia.txtCodigo.Value = 0 THEN 
		MESSAGEBOX("Debe ingresar la provincia de retención IIBB", 0+48, Thisform.Caption)
		thisform.contenedor_Ret.sel_provincia.txtCodigo.SetFocus()
		RETURN .F.
	ENDIF 
ENDIF 

&& Valido que se ingresen todos los datos de IVA
IF thisform.contenedor_Ret.txtRetIVA.Value <> 0 THEN 
	IF thisform.contenedor_Ret.txtfecIVA.Value = {} THEN 
		MESSAGEBOX("Debe ingresar la fecha de retención IVA", 0+48, Thisform.Caption)
		thisform.contenedor_Ret.txtfecIVA.SetFocus()
		RETURN .F.
	ENDIF 
	
	IF thisform.contenedor_Ret.txtCbteIVA.Value = 0 THEN 
		MESSAGEBOX("Debe ingresar el Nº de comprobante de retención IVA", 0+48, Thisform.Caption)
		thisform.contenedor_Ret.txtCbteIVA.SetFocus()
		RETURN .F.
	ENDIF 
ENDIF 

&& Valido que se ingresen todos los datos de GANANCIAS
IF thisform.contenedor_Ret.txtRetGAN.Value <> 0 THEN 
	IF thisform.contenedor_Ret.txtfecGAN.Value = {} THEN 
		MESSAGEBOX("Debe ingresar la fecha de retención Ganancias", 0+48, Thisform.Caption)
		thisform.contenedor_Ret.txtfecGAN.SetFocus()
		RETURN .F.
	ENDIF 
	
	IF thisform.contenedor_Ret.txtCbteGAN.Value = 0 THEN 
		MESSAGEBOX("Debe ingresar el Nº de comprobante de retención Ganancias", 0+48, Thisform.Caption)
		thisform.contenedor_Ret.txtCbteGAN.SetFocus()
		RETURN .F.
	ENDIF 
ENDIF 

&& Valido que se ingresen todos los datos de SUSS
IF thisform.contenedor_Ret.txtRetSUSS.Value <> 0 THEN 
	IF thisform.contenedor_Ret.txtfecSUSS.Value = {} THEN 
		MESSAGEBOX("Debe ingresar la fecha de retención SUSS", 0+48, Thisform.Caption)
		thisform.contenedor_Ret.txtfecSUSS.SetFocus()
		RETURN .F.
	ENDIF 
	
	IF thisform.contenedor_Ret.txtCbteSUSS.Value = 0 THEN 
		MESSAGEBOX("Debe ingresar el Nº de comprobante de retención SUSS", 0+48, Thisform.Caption)
		thisform.contenedor_Ret.txtCbteSUSS.SetFocus()
		RETURN .F.
	ENDIF 
ENDIF 


RETURN .T.
ENDPROC
PROCEDURE Load
DODEFAULT()
ENDPROC
PROCEDURE Init
thisform.recibos.crear_cursor()

Thisform.verificar_cajaabierta()

&& Armo la grilla correspondiente al detalle del recibo
SELECT cur_Detalle
Thisform.contenedor_cheques.grdDetalle.RecordSource = "cur_Detalle"
Thisform.contenedor_cheques.grdDetalle.list_controlsource = "tipoPago,chq_nro,descripcio,tipoDoc,nroCuit,titular,fecvto,importe"
Thisform.contenedor_cheques.grdDetalle.lista_ancho_cols = "70,80,170,70,80,200,70,70"
Thisform.contenedor_cheques.grdDetalle.titulos_cabeceras = "Tipo Pago,Nº Cheque,Descripción,Tipo Doc.,Nº Doc.,Titular,Fecha Vto.,Importe"
Thisform.contenedor_cheques.grdDetalle.generar_grid();

&& Cargo los tipos de documento
Thisform.cargar_tipodoc()

Thisform.sel_ConcCJ.txtCodigo.SetFocus()
ENDPROC


************************************************************
OBJETO: btnGrabar
************************************************************
*** PROPIEDADES ***
Top = 554
Left = 776
Height = 44
Width = 45
TabIndex = 6
Name = "btnGrabar"

*** METODOS ***
PROCEDURE Click
LOCAL loDT

loDT = CREATEOBJECT("datetime")

IF !Thisform.verificar_cajaabierta()
	RETURN .F.
ENDIF

IF !Thisform.validar_pago()
	RETURN .F.
ENDIF


goConn.BeginTransaction()

thisform.recibos.cbte = "CJA"
thisform.recibos.idconccj = thisform.sel_ConcCJ.valcpoid
thisform.recibos.idcliente = thisform.idcliente
thisform.recibos.imp_efec = thisform.contenedor_efvo.txtImpEfvo.Value 
thisform.recibos.imp_td = thisform.contenedor_efvo.txtImpTD.Value 
thisform.recibos.imp_tc = thisform.contenedor_efvo.txtImpTC.Value 
thisform.recibos.imp_ib = thisform.contenedor_Ret.txtRetIIBB.Value
thisform.recibos.num_ib = thisform.contenedor_Ret.txtCbteIIBB.Value 
thisform.recibos.fec_ib = thisform.contenedor_Ret.txtFecIIBB.Value 
thisform.recibos.idprovin_ib = thisform.contenedor_Ret.sel_provincia.valcpoid
thisform.recibos.imp_iva = thisform.contenedor_Ret.txtretIVA.Value 
thisform.recibos.num_iva = thisform.contenedor_Ret.txtCbteIVA.Value 
thisform.recibos.fec_iva = thisform.contenedor_Ret.txtFecIVA.Value 
thisform.recibos.imp_gan = thisform.contenedor_Ret.txtRetGAN.Value
thisform.recibos.num_gan = thisform.contenedor_Ret.txtCbteGAN.Value 
thisform.recibos.fec_gan = thisform.contenedor_Ret.txtFecGAN.Value  
thisform.recibos.imp_suss = thisform.contenedor_Ret.txtRetSUSS.Value 
thisform.recibos.num_suss = thisform.contenedor_Ret.txtCbteSUSS.Value 
thisform.recibos.fec_suss = thisform.contenedor_Ret.txtFecSUSS.Value 
thisform.recibos.imp_rc = thisform.txtPagoCon.Value 
thisform.recibos.fec_emis = loDT.getDateTime()
thisform.recibos.grabar_movcaja = .T.

IF !Thisform.recibos.grabar() THEN 
	RETURN .F.
ENDIF 


goConn.Commit()

Thisform.Hide()
Thisform.dialogresult = 1

RETURN .T.
ENDPROC


************************************************************
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 554
Left = 823
Height = 44
Width = 45
TabIndex = 7
Name = "btnCerrar"

*** METODOS ***
PROCEDURE Click
Thisform.Hide()
Thisform.dialogresult = 0

ENDPROC


************************************************************
OBJETO: contenedor_efvo
************************************************************
*** PROPIEDADES ***
Top = 55
Left = 3
Width = 864
Height = 58
BackStyle = 1
TabIndex = 3
Name = "contenedor_efvo"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Efectivo / Tarjetas"
Height = 15
Left = 7
Top = 4
Width = 131
TabIndex = 9
ForeColor = 0,0,0
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Efectivo:"
Height = 15
Left = 14
Top = 33
Width = 67
TabIndex = 10
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: txtImpEfvo
************************************************************
*** PROPIEDADES ***
Left = 72
TabIndex = 1
Top = 30
isnumeric = .T.
Name = "txtImpEfvo"

*** METODOS ***
PROCEDURE LostFocus
DODEFAULT()

IF this.Value < 0 THEN 
	this.Value = this.Value * -1
ENDIF 

thisform.calc_saldoimputar()

ENDPROC


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Tarjeta de Débito:"
Height = 15
Left = 206
Top = 34
Width = 101
TabIndex = 12
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Tarjeta de Crédito:"
Height = 15
Left = 453
Top = 34
Width = 101
TabIndex = 13
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: txtImpTD
************************************************************
*** PROPIEDADES ***
Left = 316
TabIndex = 2
Top = 31
isnumeric = .T.
Name = "txtImpTD"

*** METODOS ***
PROCEDURE LostFocus
DODEFAULT()

IF this.Value < 0 THEN 
	this.Value = this.Value * -1
ENDIF 

thisform.calc_saldoimputar()

ENDPROC


************************************************************
OBJETO: txtImpTC
************************************************************
*** PROPIEDADES ***
Left = 563
TabIndex = 3
Top = 31
isnumeric = .T.
Name = "txtImpTC"

*** METODOS ***
PROCEDURE LostFocus
DODEFAULT()

IF this.Value < 0 THEN 
	this.Value = this.Value * -1
ENDIF 

thisform.calc_saldoimputar()

ENDPROC


************************************************************
OBJETO: CLSLINEA2
************************************************************
*** PROPIEDADES ***
Height = 1
Left = 7
Top = 20
Width = 840
Name = "CLSLINEA2"

*** METODOS ***


************************************************************
OBJETO: contenedor_Ret
************************************************************
*** PROPIEDADES ***
Top = 450
Left = 3
Width = 864
Height = 101
BackStyle = 1
TabIndex = 5
Name = "contenedor_Ret"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Retenciones"
Height = 15
Left = 7
Top = 4
Width = 131
TabIndex = 9
ForeColor = 0,0,0
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta6
************************************************************
*** PROPIEDADES ***
Caption = "IIBB:"
Height = 15
Left = 15
Top = 31
Width = 27
TabIndex = 11
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta7
************************************************************
*** PROPIEDADES ***
Caption = "IVA:"
Height = 15
Left = 15
Top = 79
Width = 30
TabIndex = 14
Name = "Clsetiqueta7"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta8
************************************************************
*** PROPIEDADES ***
Caption = "Ganancias:"
Height = 15
Left = 435
Top = 31
Width = 67
TabIndex = 15
Name = "Clsetiqueta8"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta9
************************************************************
*** PROPIEDADES ***
Caption = "SUSS:"
Height = 15
Left = 434
Top = 55
Width = 34
TabIndex = 16
Name = "Clsetiqueta9"

*** METODOS ***


************************************************************
OBJETO: txtRetIIBB
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 46
TabIndex = 1
Top = 27
Width = 74
isnumeric = .T.
Name = "txtRetIIBB"

*** METODOS ***
PROCEDURE LostFocus
DODEFAULT()

IF this.Value < 0 THEN 
	this.Value = this.Value * -1
ENDIF 

thisform.calc_saldoimputar()

ENDPROC


************************************************************
OBJETO: txtRetIVA
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 46
TabIndex = 5
Top = 75
Width = 74
isnumeric = .T.
Name = "txtRetIVA"

*** METODOS ***
PROCEDURE LostFocus
DODEFAULT()

IF this.Value < 0 THEN 
	this.Value = this.Value * -1
ENDIF 

thisform.calc_saldoimputar()

ENDPROC


************************************************************
OBJETO: txtRetGan
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 502
TabIndex = 8
Top = 28
Width = 74
isnumeric = .T.
Name = "txtRetGan"

*** METODOS ***
PROCEDURE LostFocus
DODEFAULT()

IF this.Value < 0 THEN 
	this.Value = this.Value * -1
ENDIF 

thisform.calc_saldoimputar()
	

ENDPROC


************************************************************
OBJETO: txtRetSUSS
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 502
TabIndex = 11
Top = 51
Width = 74
isnumeric = .T.
Name = "txtRetSUSS"

*** METODOS ***
PROCEDURE LostFocus
DODEFAULT()

IF this.Value < 0 THEN 
	this.Value = this.Value * -1
ENDIF 

thisform.calc_saldoimputar()
ENDPROC


************************************************************
OBJETO: CLSLINEA2
************************************************************
*** PROPIEDADES ***
Height = 1
Left = 7
Top = 20
Width = 840
Name = "CLSLINEA2"

*** METODOS ***


************************************************************
OBJETO: txtFecIIBB
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 168
TabIndex = 2
Top = 27
Width = 74
isdatetime = .T.
Name = "txtFecIIBB"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Fecha:"
Height = 15
Left = 127
Top = 31
Width = 37
TabIndex = 11
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: txtCbteIIBB
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 298
TabIndex = 3
Top = 27
Width = 100
isinteger = .T.
Name = "txtCbteIIBB"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "N° Cbte:"
Height = 15
Left = 251
Top = 31
Width = 45
TabIndex = 11
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: txtFecIVA
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 168
TabIndex = 6
Top = 75
Width = 74
isdatetime = .T.
Name = "txtFecIVA"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Fecha:"
Height = 15
Left = 127
Top = 79
Width = 37
TabIndex = 11
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: txtCbteIVA
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 298
TabIndex = 7
Top = 75
Width = 100
isnumeric = .F.
isinteger = .T.
Name = "txtCbteIVA"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "N° Cbte:"
Height = 15
Left = 251
Top = 79
Width = 45
TabIndex = 11
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: txtFecGAN
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 625
TabIndex = 9
Top = 28
Width = 74
isdatetime = .T.
Name = "txtFecGAN"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta10
************************************************************
*** PROPIEDADES ***
Caption = "Fecha:"
Height = 15
Left = 584
Top = 32
Width = 37
TabIndex = 11
Name = "Clsetiqueta10"

*** METODOS ***


************************************************************
OBJETO: txtCbteGAN
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 755
TabIndex = 10
Top = 28
Width = 100
isinteger = .T.
Name = "txtCbteGAN"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta11
************************************************************
*** PROPIEDADES ***
Caption = "N° Cbte:"
Height = 15
Left = 708
Top = 32
Width = 45
TabIndex = 11
Name = "Clsetiqueta11"

*** METODOS ***


************************************************************
OBJETO: txtFecSUSS
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 625
TabIndex = 12
Top = 52
Width = 74
isdatetime = .T.
Name = "txtFecSUSS"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta12
************************************************************
*** PROPIEDADES ***
Caption = "Fecha:"
Height = 15
Left = 584
Top = 56
Width = 37
TabIndex = 11
Name = "Clsetiqueta12"

*** METODOS ***


************************************************************
OBJETO: txtCbteSUSS
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 755
TabIndex = 13
Top = 52
Width = 100
isinteger = .T.
Name = "txtCbteSUSS"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta13
************************************************************
*** PROPIEDADES ***
Caption = "N° Cbte:"
Height = 15
Left = 708
Top = 56
Width = 45
TabIndex = 11
Name = "Clsetiqueta13"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta14
************************************************************
*** PROPIEDADES ***
Caption = "Provincia:"
Height = 15
Left = 25
Top = 54
Width = 60
TabIndex = 11
Name = "Clsetiqueta14"

*** METODOS ***


************************************************************
OBJETO: sel_provincia
************************************************************
*** PROPIEDADES ***
Top = 49
Left = 85
Width = 324
Height = 25
TabIndex = 4
esnumerico = .T.
nombre_campo_codigo = idProvin
nombre_campo_desc = descripcio
nombre_tabla = provincias
pkfield = idProvin
Name = "sel_provincia"
txtCodigo.Height = 21
txtCodigo.Left = 2
txtCodigo.Top = 2
txtCodigo.Width = 44
txtCodigo.Name = "txtCodigo"
txtDescripcion.Height = 21
txtDescripcion.Left = 50
txtDescripcion.Top = 2
txtDescripcion.Width = 263
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: contenedor_cheques
************************************************************
*** PROPIEDADES ***
Top = 116
Left = 3
Width = 864
Height = 331
BackStyle = 1
TabIndex = 4
Name = "contenedor_cheques"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Cheque / Depósito Bancario"
Height = 15
Left = 7
Top = 5
Width = 175
TabIndex = 14
ForeColor = 0,0,0
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Banco:"
Height = 15
Left = 15
Top = 55
Width = 58
TabIndex = 15
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Sucursal:"
Height = 15
Left = 588
Top = 56
Width = 57
TabIndex = 16
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Nro. Cheque:"
Height = 15
Left = 15
Top = 79
Width = 81
TabIndex = 19
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Fecha Emisión:"
Height = 15
Left = 237
Top = 80
Width = 87
TabIndex = 21
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta6
************************************************************
*** PROPIEDADES ***
Caption = "Fecha de Vto.:"
Height = 15
Left = 428
Top = 80
Width = 87
TabIndex = 22
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta7
************************************************************
*** PROPIEDADES ***
Caption = "Importe:"
Height = 15
Left = 619
Top = 79
Width = 50
TabIndex = 23
Name = "Clsetiqueta7"

*** METODOS ***


************************************************************
OBJETO: sel_Banco
************************************************************
*** PROPIEDADES ***
Top = 49
Left = 94
TabIndex = 2
nombre_campo_codigo = codBco
nombre_campo_desc = descripcio
nombre_tabla = bancos
pkfield = idBanco
Name = "sel_Banco"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: txtSucursal
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 645
TabIndex = 3
Top = 51
Width = 215
ischaracter = .T.
Name = "txtSucursal"

*** METODOS ***


************************************************************
OBJETO: txtNroCheque
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 96
MaxLength = 8
TabIndex = 4
Top = 75
Width = 136
ischaracter = .T.
autocompleta = .T.
Name = "txtNroCheque"

*** METODOS ***


************************************************************
OBJETO: txtFecEmis
************************************************************
*** PROPIEDADES ***
Left = 325
TabIndex = 5
Top = 75
isdatetime = .T.
Name = "txtFecEmis"

*** METODOS ***


************************************************************
OBJETO: txtFecVto
************************************************************
*** PROPIEDADES ***
Left = 513
TabIndex = 6
Top = 75
isdatetime = .T.
Name = "txtFecVto"

*** METODOS ***


************************************************************
OBJETO: txtImporte
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 672
TabIndex = 7
Top = 75
Width = 95
isnumeric = .T.
Name = "txtImporte"

*** METODOS ***
PROCEDURE Click
IF this.Value < 0 THEN 
	MESSAGEBOX("El importe no puede ser negativo",0+48,thisform.Caption)
	this.SetFocus()
	RETURN .F.
ENDIF 
ENDPROC


************************************************************
OBJETO: grdDetalle
************************************************************
*** PROPIEDADES ***
Height = 173
Left = 4
TabIndex = 24
Top = 126
Width = 859
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdDetalle"
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
OBJETO: btnAgregarCheque
************************************************************
*** PROPIEDADES ***
Top = 77
Left = 771
Height = 44
Width = 45
TabIndex = 11
Name = "btnAgregarCheque"

*** METODOS ***
PROCEDURE Click
&& Este método permite agregar un nuevo item al movimiento
LOCAL loPlanCta, lcSql, llEsCheque, lnIdCliente, lnIdBanco, lc_nrocheque

lcSql = ""
loPlanCta = CREATEOBJECT("odbc_result")
lnIdBanco = thisform.contenedor_cheques.sel_Banco.valcpoid
lnIdCliente = thisform.sel_cliente.valcpoid
lc_nrocheque = thisform.contenedor_cheques.txtNroCheque.Value 

IF This.Parent.opgTipoPago.Option1.Value = 1 THEN
	llEsCheque = .T.
ELSE
	llEsCheque = .F.
ENDIF

&& Valido que se hayan ingresado los datos del cheque
IF This.Parent.sel_Banco.valcpoid = 0 THEN
	MESSAGEBOX("Debe seleccionar el banco", 0+48, Thisform.Caption)
	this.Parent.sel_Banco.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

IF llEsCheque THEN
	IF (This.Parent.txtNroCheque.Value == "") .OR. (This.Parent.txtNroCheque.Value == "00000000") THEN
		MESSAGEBOX("Debe ingresar el número de cheque", 0+48, Thisform.Caption)
		This.Parent.txtNroCheque.SetFocus()
		RETURN .F.
	ENDIF

	IF This.Parent.txtFecEmis.Value = {} THEN
		MESSAGEBOX("Debe ingresar la fecha de emisión", 0+48, Thisform.Caption)
		This.Parent.txtFecEmis.SetFocus()
		RETURN .F.
	ENDIF

	IF This.Parent.txtFecVto.Value = {} THEN
		MESSAGEBOX("Debe ingresar la fecha de vencimiento", 0+48, Thisform.Caption)
		This.Parent.txtFecVto.SetFocus()
		RETURN .F.
	ENDIF
	
	IF !Thisform.recibos.validar_cheques(lnIdCliente, lnIdBanco, lc_nrocheque)
		RETURN .F.
	ENDIF 	
ENDIF

IF This.Parent.txtImporte.Value = 0 THEN
	MESSAGEBOX("Debe ingresar el importe", 0+48, Thisform.Caption)
	this.Parent.txtImporte.SetFocus()
	RETURN .F.
ENDIF


SELECT cur_Detalle
APPEND BLANK
REPLACE cur_Detalle.idDetalle WITH 0
REPLACE cur_Detalle.idCheque WITH 0 ADDITIVE
REPLACE cur_Detalle.importe WITH This.Parent.txtImporte.Value ADDITIVE
REPLACE cur_Detalle.idBanco WITH This.Parent.sel_Banco.valcpoid ADDITIVE

IF !llEsCheque THEN
	&& Si el pago es por deposito bancario, entonces, tengo que hacer
	&& que se genere los datos del banco:
	
	REPLACE cur_Detalle.descripcio WITH This.Parent.sel_Banco.txtDescripcion.Value ADDITIVE
	REPLACE cur_Detalle.tipoPago WITH "DEP" ADDITIVE
	REPLACE cur_Detalle.sucursal WITH this.Parent.txtSucursal.Value ADDITIVE 
ELSE
	&& Si es pago con Cheque entonces busco la cuenta cheques en cartera
	&& en el plan de cuenta y lo asigno:
	
	lcSql = "SELECT * FROM planctas WHERE esChqT = 1"
	loPlanCta.Cursor_Name = "cur_PlanCta"
	loPlanCta.ActiveConnection = goConn.ActiveConnection
	loPlanCta.OpenQuery(lcSql)

	REPLACE cur_Detalle.tipoPago WITH "CHEQ" ADDITIVE
	REPLACE cur_Detalle.sucursal WITH this.Parent.txtSucursal.Value ADDITIVE 
	REPLACE cur_Detalle.chq_nro WITH This.Parent.txtNroCheque.Value ADDITIVE
	REPLACE cur_Detalle.idPlanCta WITH cur_PlanCta.idPlanCta ADDITIVE
	REPLACE cur_Detalle.descripcio WITH This.Parent.sel_Banco.txtDescripcion.Value ADDITIVE
	REPLACE cur_Detalle.fecEmis WITH This.Parent.txtFecEmis.Value ADDITIVE
	REPLACE cur_Detalle.fecVto WITH This.Parent.txtFecVto.Value ADDITIVE
	REPLACE cur_Detalle.tipoDoc WITH This.Parent.cmbTipoDoc.Value ADDITIVE
	REPLACE cur_Detalle.nroCuit WITH ALLTRIM(STR(This.Parent.txtNroCUIT.Value, 20, 0)) ADDITIVE
	REPLACE cur_Detalle.titular WITH This.Parent.txtTitular.Value ADDITIVE
	
	loPlanCta.Close_Query()
ENDIF

SELECT cur_Detalle
GO TOP

This.Parent.grdDetalle.Refresh()

This.Parent.txtTotalRec.Value = This.Parent.txtTotalRec.Value + This.Parent.txtImporte.Value

thisform.calc_saldoimputar()

This.Parent.sel_Banco.blanquear()
This.Parent.txtFecEmis.Value = {}
This.Parent.txtFecVto.Value = {}
This.Parent.txtImporte.Value = 0.00
This.Parent.txtSucursal.Value = ""
This.Parent.txtNroCheque.value = ""
This.Parent.cmbTipoDoc.ListIndex = 1
This.Parent.txtNroCUIT.Value = 0
This.Parent.txtTitular.Value = ""
This.Parent.sel_Banco.SetFocus()

RETURN .T.

ENDPROC


************************************************************
OBJETO: opgTipoPago
************************************************************
*** PROPIEDADES ***
BackStyle = 0
BorderStyle = 0
Height = 24
Left = 182
Top = 24
Width = 216
TabIndex = 1
Name = "opgTipoPago"
OPTION1.FontSize = 8
OPTION1.BackStyle = 0
OPTION1.Caption = "Cheque"
OPTION1.Height = 15
OPTION1.Left = 5
OPTION1.TabIndex = 1
OPTION1.Top = 5
OPTION1.Width = 77
OPTION1.ForeColor = 158,106,75
OPTION1.Name = "OPTION1"
OPTION2.FontSize = 8
OPTION2.BackStyle = 0
OPTION2.Caption = "Depósito Bancario"
OPTION2.Height = 15
OPTION2.Left = 89
OPTION2.TabIndex = 2
OPTION2.Top = 5
OPTION2.Width = 127
OPTION2.ForeColor = 158,106,75
OPTION2.Name = "OPTION2"

*** METODOS ***
PROCEDURE OPTION1.Click
IF This.Value = 1 THEN
	Thisform.contenedor_cheques.txtFecEmis.Enabled = .T.
	Thisform.contenedor_cheques.txtFecVto.Enabled = .T.
	Thisform.contenedor_cheques.txtNroCheque.Enabled = .T.
	Thisform.contenedor_cheques.cmbTipoDoc.Enabled = .T.
	Thisform.contenedor_cheques.txtNroCUIT.Enabled = .T.
	Thisform.contenedor_cheques.txtTitular.Enabled = .T.
	Thisform.contenedor_cheques.sel_Banco.txtCodigo.SetFocus()
ENDIF
ENDPROC
PROCEDURE OPTION2.Click
IF This.Value = 1 THEN
	Thisform.contenedor_cheques.txtFecEmis.Enabled = .F.
	Thisform.contenedor_cheques.txtFecVto.Enabled = .F.
	Thisform.contenedor_cheques.txtNroCheque.Enabled = .F.
	Thisform.contenedor_cheques.cmbTipoDoc.Enabled = .F.
	Thisform.contenedor_cheques.txtNroCUIT.Enabled = .F.
	Thisform.contenedor_cheques.txtTitular.Enabled = .F.
	Thisform.contenedor_cheques.sel_Banco.txtCodigo.SetFocus()
ENDIF
ENDPROC


************************************************************
OBJETO: Clsetiqueta9
************************************************************
*** PROPIEDADES ***
Caption = "Seleccione la forma de Pago:"
Height = 15
Left = 14
Top = 29
Width = 172
TabIndex = 12
Name = "Clsetiqueta9"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta10
************************************************************
*** PROPIEDADES ***
Caption = "Total:"
Height = 15
Left = 14
Top = 307
Width = 47
TabIndex = 25
Name = "Clsetiqueta10"

*** METODOS ***


************************************************************
OBJETO: txtTotalRec
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Left = 58
TabIndex = 13
Top = 304
isnumeric = .T.
Name = "txtTotalRec"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta8
************************************************************
*** PROPIEDADES ***
Caption = "Tipo Doc:"
Height = 15
Left = 15
Top = 102
Width = 77
TabIndex = 17
Name = "Clsetiqueta8"

*** METODOS ***


************************************************************
OBJETO: cmbTipoDoc
************************************************************
*** PROPIEDADES ***
ControlSource = ""
Height = 21
Left = 96
TabIndex = 8
Top = 99
Width = 100
Name = "cmbTipoDoc"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta11
************************************************************
*** PROPIEDADES ***
Caption = "Nro:"
Height = 15
Left = 210
Top = 103
Width = 32
TabIndex = 20
Name = "Clsetiqueta11"

*** METODOS ***


************************************************************
OBJETO: txtNroCUIT
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 241
MaxLength = 11
TabIndex = 9
Top = 99
Width = 184
isinteger = .T.
ischaracter = .F.
Name = "txtNroCUIT"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta12
************************************************************
*** PROPIEDADES ***
Caption = "Titular:"
Height = 15
Left = 428
Top = 103
Width = 39
TabIndex = 18
Name = "Clsetiqueta12"

*** METODOS ***


************************************************************
OBJETO: txtTitular
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 473
MaxLength = 60
TabIndex = 10
Top = 99
Width = 294
isinteger = .F.
ischaracter = .T.
Name = "txtTitular"

*** METODOS ***


************************************************************
OBJETO: CLSLINEA2
************************************************************
*** PROPIEDADES ***
Height = 1
Left = 7
Top = 21
Width = 840
Name = "CLSLINEA2"

*** METODOS ***


************************************************************
OBJETO: Clsdelete1
************************************************************
*** PROPIEDADES ***
Top = 77
Left = 817
TabIndex = 12
Name = "Clsdelete1"

*** METODOS ***
PROCEDURE Click
LOCAL lnResp

lnResp = MESSAGEBOX("¿Está seguro que desea eliminar este ítem?", 4+32, Thisform.Caption)

IF lnResp = 6 THEN
	SELECT cur_Detalle
	This.Parent.txtTotalRec.Value = This.Parent.txtTotalRec.Value - cur_detalle.importe

	thisform.calc_saldoimputar()

	SELECT cur_Detalle
	DELETE

	Thisform.contenedor_cheques.grdDetalle.Refresh()
	This.Parent.sel_Banco.SetFocus()
ENDIF

ENDPROC


************************************************************
OBJETO: CLSETIQUETA1
************************************************************
*** PROPIEDADES ***
Caption = "Concepto:"
Height = 15
Left = 18
Top = 10
Width = 72
Name = "CLSETIQUETA1"

*** METODOS ***


************************************************************
OBJETO: sel_ConcCJ
************************************************************
*** PROPIEDADES ***
Top = 5
Left = 89
TabIndex = 1
autocompletar_ceros = .F.
nombre_tabla = conccj
nombre_campo_codigo = codConcCJ
nombre_campo_desc = descripcio
pkfield = idConcCJ
Name = "sel_ConcCJ"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Importe Ingresado:"
Height = 15
Left = 12
Top = 567
Width = 109
TabIndex = 12
ForeColor = 0,0,0
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: txtPagoCon
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 124
ReadOnly = .T.
TabIndex = 7
Top = 563
Width = 80
isnumeric = .T.
Name = "txtPagoCon"

*** METODOS ***
PROCEDURE InteractiveChange
LOCAL lnImputado

lnImputado = 0.00
lnImputado = thisform.sumar_items()
Thisform.Contenido.Pages.Page1.CntAplicar.txtCambio.Value = lnImputado - Thisform.Contenido.Pages.Page1.CntAplicar.txtPagoCon.Value
ENDPROC


************************************************************
OBJETO: Recibos
************************************************************
*** PROPIEDADES ***
Top = 569
Left = 272
Height = 17
Width = 40
Name = "Recibos"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Cliente:"
Height = 15
Left = 18
Top = 33
Width = 72
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: sel_Cliente
************************************************************
*** PROPIEDADES ***
Top = 29
Left = 89
TabIndex = 2
esnumerico = .T.
nombre_campo_codigo = idCliente
nombre_campo_desc = razSoc
nombre_tabla = clientes
pkfield = idCliente
Name = "sel_Cliente"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: cl_ingmov
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cl_control_cja
************************************************************
*** PROPIEDADES ***
BorderStyle = 1
Height = 540
Width = 833
DoCreate = .T.
Caption = "Consulta de Control de Caja Diaria"
Name = "cl_control_cja"
contenido.Name = "contenido"

*** METODOS ***
PROCEDURE Init
&& Grilla donde se muestran las cajas diarias
SELECT cur_CjaDiaria
Thisform.Contenido.grdCjaDiaria.RecordSource = "cur_CjaDiaria"
Thisform.Contenido.grdCjaDiaria.list_controlsource = "fecha,concepto,cuenta,impDebe,impHaber,saldo"
Thisform.Contenido.grdCjaDiaria.lista_ancho_cols = "70,200,200,70,70,70"
Thisform.Contenido.grdCjaDiaria.titulos_cabeceras = "Fecha,Concepto,Cuenta,Debe,Haber,Saldo"
Thisform.Contenido.grdCjaDiaria.generar_grid()

&& Grilla donde se muestran los resumenes de caja
SELECT cur_ResCja
Thisform.Contenido.grdResCaja.RecordSource = "cur_ResCja"
Thisform.Contenido.grdResCaja.list_controlsource = "cuenta,importe"
Thisform.Contenido.grdResCaja.lista_ancho_cols = "200,70"
Thisform.Contenido.grdResCaja.titulos_cabeceras = "Cuenta,Importe"
Thisform.Contenido.grdResCaja.generar_grid()

&& grilla donde se muestran las facturas diarias
SELECT cur_Fact
thisform.contenido.grdFacturas.RecordSource = "cur_Fact"
thisform.contenido.grdFacturas.list_controlsource = "descripcio,totFact"
thisform.contenido.grdFacturas.lista_ancho_cols = "300,100"
thisform.contenido.grdFacturas.titulos_cabeceras = "Descripción,Total Fact."
thisform.contenido.grdFacturas.generar_grid()

Thisform.recuperardatos()


ENDPROC
PROCEDURE Load
DODEFAULT()

CREATE CURSOR cur_CjaDiaria (	;
	fecha		datetime,;
	concepto	varchar(60),;
	idCtaCja	int,;
	cuenta		varchar(60),;
	impDebe		float(10, 2),;
	impHaber	float(10, 2),;
	saldo		float(10, 2))


CREATE CURSOR cur_ResCja (	;
	cuenta		varchar(60),;
	importe		float(10, 2))


CREATE CURSOR cur_ResConc (	;
	codConc		varchar(20),;
	concepto	varchar(60),;
	codCjaCta	varchar(20),;
	ctacja		varchar(60),;
	importe		float(10, 2))
	
CREATE CURSOR cur_ResCta (	;
	codigo		varchar(20),;
	descripcio	varchar(60),;
	importe		float(10, 2))

CREATE CURSOR cur_fact( 	;
	descripcio	varchar(60) ,;
	totFact		float(10, 2))
ENDPROC
PROCEDURE recuperardatos
&& Levanto los datos de la caja diaria
LOCAL lcSql, loResult, lnDebe, lnHaber, lnSaldo, lcNroDoc

lcSql = ""
loResult = CREATEOBJECT("odbc_result")
lnDebe = 0.00
lnHaber = 0.00
lnSaldo = 0.00


SELECT cur_CjaDiaria
ZAP
SELECT cur_ResCja
ZAP
SELECT cur_Fact
ZAP

lcSql = "SELECT	movcjadet.fecha, "
lcSql = lcSql + "conccj.descripcio AS concepto, "
lcSql = lcSql + "movcjadet.idCtaCja, "
lcSql = lcSql + "ctacja.descripcio AS cuenta, "
lcSql = lcSql + "movcjadet.importe "
lcSql = lcSql + "FROM	movcjadet, "
lcSql = lcSql + "movcjacab, "
lcSql = lcSql + "ctacja, "
lcSql = lcSql + "conccj "
lcSql = lcSql + "WHERE	movcjadet.idCtaCja = ctacja.idCtaCja "
lcSql = lcSql + "	AND movcjadet.idMovCjaC = movcjacab.idMovCjaC "
lcSql = lcSql + "	AND	movcjadet.idConcCJ = conccj.idConcCJ "
lcSql = lcSql + "	AND movcjacab.estado = 'A' "
lcSql = lcSql + "ORDER BY idMovCjaD ASC "

loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_mov"
loResult.OpenQuery(lcSql)

SELECT cur_mov
IF RECCOUNT("cur_mov") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_mov")
	lnDebe = 0.00
	lnHaber = 0.00
	
	IF cur_mov.importe > 0 THEN
		lnDebe = cur_mov.importe
		lnSaldo = lnSaldo + lnDebe
	ELSE
		lnHaber = cur_mov.importe * -1
		lnSaldo = lnSaldo - lnHaber
	ENDIF

	SELECT cur_CjaDiaria
	APPEND BLANK
	REPLACE fecha		WITH cur_mov.fecha
	REPLACE concepto	WITH cur_mov.concepto 	ADDITIVE
	REPLACE idCtaCja	WITH cur_mov.idCtaCja 	ADDITIVE
	REPLACE cuenta		WITH cur_mov.cuenta		ADDITIVE
	REPLACE impDebe		WITH lnDebe				ADDITIVE
	REPLACE impHaber	WITH lnHaber			ADDITIVE
	REPLACE saldo		WITH lnSaldo			ADDITIVE

	SELECT cur_mov
	SKIP
ENDDO

loResult.Close_Query()

SELECT cur_CjaDiaria
IF RECCOUNT("cur_CjaDiaria") > 0 THEN
	GO TOP
ENDIF

Thisform.Contenido.grdCjaDiaria.Refresh()

&& Genero el resumen de caja por cuenta

lcSql = "SELECT		ctacja.codCtaCJ, "
lcSql = lcSql + " 	MAX(ctacja.descripcio) AS descripcio, "
lcSql = lcSql + " 	SUM(importe) AS total	"
lcSql = lcSql + " FROM	movcjadet, "
lcSql = lcSql + " 		movcjacab, "
lcSql = lcSql + " 		ctacja "
lcSql = lcSql + " WHERE	movcjadet.idMovCjaC = movcjacab.idMovCjaC "
lcSql = lcSql + " 	AND ctacja.idCtaCja = movcjadet.idCtaCja "
lcSql = lcSql + " 	AND movcjacab.estado = 'A' "
lcSql = lcSql + " GROUP BY ctacja.codCtaCJ "
lcSql = lcSql + " ORDER BY ctacja.codCtaCJ "

loResult.Cursor_Name = "cur_tmp"
loResult.ActiveConnection = goConn.ActiveConnection
loResult.OpenQuery(lcSql)

SELECT cur_tmp
DO WHILE !EOF("cur_tmp")
	SELECT cur_ResCja 
	APPEND BLANK
	REPLACE cuenta WITH cur_tmp.descripcio
	REPLACE importe WITH cur_tmp.total ADDITIVE

	SELECT cur_tmp
	SKIP
ENDDO

loResult.Close_Query()

SELECT cur_ResCja
IF RECCOUNT("cur_ResCja") > 0 THEN
	GO TOP
ENDIF

Thisform.Contenido.grdResCaja.Refresh()

&& Levanto lo facturado en el día

lcSql = "SELECT  CASE WHEN ventascab.idCondPago = 1 THEN 'CONTADO' ELSE 'CUENTA CORRIENTE' END descripcio, "
lcSql = lcSql + "	ventascab.totFact "
lcSql = lcSql + "FROM    ventascab INNER JOIN clientes "
lcSql = lcSql + "             ON ventascab.idCliente = clientes.idCliente "
lcSql = lcSql + "WHERE   ventascab.anulado = 0 AND ventascab.fecBaja IS NULL "

IF INT(VAL(getConfig("SQLSRV"))) = 1 THEN
	lcSql = lcSql + "	AND DAY(ventascab.fecAlta) = DAY(GETDATE()) "
	lcSql = lcSql + "	AND MONTH(ventascab.fecAlta) = MONTH(GETDATE()) "
	lcSql = lcSql + "	AND YEAR(ventascab.fecAlta) = YEAR(GETDATE()) "
ELSE
	lcSql = lcSql + "	AND DAY(ventascab.fecAlta) = DAY(current_timestamp) "
	lcSql = lcSql + "	AND MONTH(ventascab.fecAlta) = MONTH(current_timestamp) "
	lcSql = lcSql + "	AND YEAR(ventascab.fecAlta) = YEAR(current_timestamp) "

ENDIF
	
loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_vtas"

IF !loResult.OpenQuery(lcSql) THEN
	MESSAGEBOX(loResult.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT	descripcio, SUM(totFact) AS total ;
FROM cur_vtas ;
GROUP BY descripcio ;
ORDER BY descripcio ASC INTO CURSOR cur_tempo

SELECT cur_tempo
IF RECCOUNT("cur_tempo") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_tempo")
	SELECT cur_fact
	APPEND BLANK
	REPLACE descripcio WITH ALLTRIM(cur_tempo.descripcio)
	REPLACE totFact WITH ROUND(cur_tempo.total, 2) ADDITIVE
	
	SELECT cur_tempo
	SKIP
ENDDO

USE IN cur_tempo
loResult.close_query()

SELECT cur_fact
IF RECCOUNT("cur_fact") > 0 THEN
	GO TOP
ENDIF

Thisform.contenido.grdFacturas.Refresh()

ENDPROC


************************************************************
OBJETO: grdCjaDiaria
************************************************************
*** PROPIEDADES ***
Height = 139
Left = 13
TabIndex = 1
Top = 24
Width = 808
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdCjaDiaria"
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
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Resumen de caja por cuenta:"
Height = 15
Left = 14
Top = 169
Width = 174
TabIndex = 7
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: grdResCaja
************************************************************
*** PROPIEDADES ***
Height = 139
Left = 13
TabIndex = 2
Top = 185
Width = 808
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdResCaja"
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
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Resumen por cuenta caja:"
Height = 15
Left = 13
Top = 7
Width = 174
TabIndex = 8
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 494
Left = 778
Height = 44
Width = 45
TabIndex = 6
Name = "btnCerrar"

*** METODOS ***


************************************************************
OBJETO: btnRefresh
************************************************************
*** PROPIEDADES ***
Top = 493
Left = 13
TabIndex = 4
Name = "btnRefresh"

*** METODOS ***
PROCEDURE Click
Thisform.recuperardatos()
Thisform.Contenido.grdCjaDiaria.Refresh()
Thisform.Contenido.grdResCaja.Refresh()
ENDPROC


************************************************************
OBJETO: btnImprimirParc
************************************************************
*** PROPIEDADES ***
Top = 493
Left = 59
TabIndex = 5
Name = "btnImprimirParc"

*** METODOS ***
PROCEDURE Click
LOCAL loResult, lcSql, lnCntFC, loDT

loResult = CREATEOBJECT("odbc_result")
loDT = CREATEOBJECT("datetime")
lcSql = ""
lnCntFC = 0

SELECT cur_ResCta
ZAP
SELECT cur_ResConc
ZAP

* -----------------------------------------------------------------------------------------------
* Armo el resumen por cuenta

lcSql = "SELECT	movcjadet.idCtaCja, "
lcSql = lcSql + "		MAX(ctacja.codCtaCJ) AS codigo, "
lcSql = lcSql + "		MAX(ctacja.descripcio) AS descripcio, "
lcSql = lcSql + "		SUM(movcjadet.importe) AS importe "
lcSql = lcSql + "FROM	movcjadet INNER JOIN movcjacab ON movcjacab.idMovCjaC = movcjadet.idMovCjaC "
lcSql = lcSql + "	INNER JOIN ctacja ON ctacja.idCtaCja = movcjadet.idCtaCja "
lcSql = lcSql + "WHERE	movcjacab.estado = 'A' "
lcSql = lcSql + "GROUP BY movcjadet.idCtaCja  "

loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_temp"

IF !loResult.OpenQuery(lcSql) THEN
	MESSAGEBOX(loResult.ErrorMessage, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_temp
IF RECCOUNT("cur_temp") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_temp") 
	SELECT cur_ResCta
	APPEND BLANK
	REPLACE cur_ResCta.codigo WITH cur_temp.codigo
	REPLACE cur_ResCta.descripcio WITH cur_temp.descripcio ADDITIVE
	REPLACE cur_ResCta.importe WITH cur_temp.importe ADDITIVE

	SELECT cur_temp
	SKIP
ENDDO

loResult.Close_Query()

* -----------------------------------------------------------------------------------------------------
* Resumen por Concepto / Cuenta

lcSql = "SELECT	movcjadet.idConcCJ, "
lcSql = lcSql + "	movcjadet.idCtaCja, "
lcSql = lcSql + "	MAX(conccj.codConcCJ)		AS codConc, "
lcSql = lcSql + "	MAX(conccj.descripcio)		AS concepto, "
lcSql = lcSql + "	MAX(ctacja.codCtaCJ)		AS codCjaCta, "
lcSql = lcSql + "	MAX(ctacja.descripcio)		AS ctaCja, "
lcSql = lcSql + "	SUM(movcjadet.importe)		AS importe "
lcSql = lcSql + "FROM	movcjadet INNER JOIN movcjacab ON movcjacab.idMovCjaC = movcjadet.idMovCjaC "
lcSql = lcSql + "	INNER JOIN conccj ON conccj.idConcCJ = movcjadet.idConcCJ "
lcSql = lcSql + "	INNER JOIN ctacja ON movcjadet.idCtaCja = ctacja.idCtaCja "
lcSql = lcSql + "WHERE	movcjacab.estado = 'A' "
lcSql = lcSql + "GROUP BY movcjadet.idConcCJ, movcjadet.idCtaCja "

loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_temp"

IF !loResult.OpenQuery(lcSql) THEN
	MESSAGEBOX(loResult.ErrorMessage, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_temp
IF RECCOUNT("cur_temp") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_temp")
	SELECT cur_ResConc
	APPEND BLANK
	REPLACE cur_ResConc.codConc WITH cur_temp.codConc
	REPLACE cur_ResConc.concepto WITH cur_temp.concepto ADDITIVE
	REPLACE cur_ResConc.codCjaCta WITH cur_temp.codCjaCta ADDITIVE
	REPLACE cur_ResConc.ctaCja WITH cur_temp.ctacja ADDITIVE
	REPLACE cur_ResConc.importe WITH cur_temp.importe ADDITIVE

	SELECT cur_temp
	SKIP
ENDDO

loResult.Close_Query()


* Calculo la cantidad de facturas aplicadas
lcSql = "SELECT	COUNT(*) AS CantFC "
lcSql = lcSql + "FROM	ventascab "
lcSql = lcSql + "WHERE	ventascab.cbte = 'FC' "

IF INT(VAL(getConfig("SQLSRV"))) = 1 THEN
	lcSql = lcSql + "	AND CONVERT(CHAR(8), ventascab.fecEmision, 112) = " + loDT.toMySql(DATE())
ELSE
	lcSql = lcSql + "	AND ventascab.fecEmision = " + loDT.getDateTime()
ENDIF

loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_cntFC"
loResult.OpenQuery(lcSql)
lnCntFC = cur_cntFC.CantFC
loResult.Close_Query()

SELECT cur_ResCta
REPORT FORM "rep_res_cjacta" TO PRINTER PROMPT PREVIEW 
SELECT cur_ResConc
REPORT FORM "rep_res_cjaconc" TO PRINTER PROMPT PREVIEW 

RETURN .T.

ENDPROC


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Facturas Emitidas"
Height = 15
Left = 14
Top = 333
Width = 174
TabIndex = 9
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: grdFacturas
************************************************************
*** PROPIEDADES ***
Height = 139
Left = 13
TabIndex = 3
Top = 349
Width = 808
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdFacturas"
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
OBJETO: cl_control_cja
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cl_apercaja
************************************************************
*** PROPIEDADES ***
BorderStyle = 2
Height = 140
Width = 260
DoCreate = .T.
Caption = "Apertura de Caja"
WindowType = 0
Name = "cl_apercaja"

*** METODOS ***
PROCEDURE Init
LOCAL lcSql, loResult, lnCount

Thisform.txtFecha.Value = DATE()
Thisform.txtHora.value = TIME()

&& Verifico si se abrió la caja
lcSql = "SELECT COUNT(*) AS Cantidad FROM movcjacab WHERE estado = 'A'"
loResult = CREATEOBJECT("odbc_result")
lnCount = 0

loResult.Cursor_Name = "cur_tmp"
loResult.ActiveConnection = goConn.ActiveConnection
loResult.OpenQuery(lcSql)

IF TYPE("cur_tmp.Cantidad") == "C" THEN
	lnCount = INT(VAL(cur_tmp.Cantidad)) 
ELSE
	lnCount = cur_tmp.Cantidad
ENDIF

loResult.Close_Query()

IF lnCount > 0 THEN
	MESSAGEBOX("Ya tiene una caja diaria abierta, debe cerrar la caja actual", 0+48, Thisform.Caption)
	Thisform.Release()
	RETURN .F.
ENDIF

thisform.recibos.crear_cursor()

RETURN .T.
ENDPROC


************************************************************
OBJETO: btnGrabar
************************************************************
*** PROPIEDADES ***
Top = 89
Left = 158
TabIndex = 4
Name = "btnGrabar"

*** METODOS ***
PROCEDURE Click
LOCAL lcSql, loCommand, loDT
LOCAL lnIdMovCjaC, lnIdMovCjaD, lnIdVentasC, lnIdConcCJ, lnImporte

lcSql = ""
loCommand = CREATEOBJECT("odbc_command")
loDT = CREATEOBJECT("datetime")
lnIdMovCjaC = 0
lnIdMovCjaD = 1
lnIdConcCJ = 1
lnImporte = 0.00

IF Thisform.txtSaldoInic.Value = 0 THEN
	MESSAGEBOX("Debe ingresar el saldo inicial", 0+48, Thisform.Caption)
	Thisform.txtSaldoInic.SetFocus()
	RETURN .F.
ENDIF

lnImporte = Thisform.txtSaldoInic.Value 

goConn.BeginTransaction()
lnIdMovCjaC = goConn.getNextId("movcjacab", "idMovCjaC")

&& Tengo que armar la cabecera de los movimientos de caja diaria
lcSql = "INSERT INTO movcjacab (idMovCjaC, fecha, estado, usuAlta, fecAlta, idHostAlta) VALUES ( "
lcSql = lcSql + ALLTRIM(STR(lnIdMovCjaC)) + ", " + loDT.getDateTime() + ", 'A', '" + ALLTRIM(gcCodUsu) + "', " + loDT.getDateTime() + ", '" + SYS(0) + "')"

loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = lcSql

IF !loCommand.Execute() THEN
	goConn.Rollback()
	MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

thisform.recibos.cbte = "CJA"
thisform.recibos.idmovcjac = lnIdMovCjaC
thisform.recibos.idconccj = lnIdConcCJ
thisform.recibos.imp_efec = lnImporte 
thisform.recibos.imp_rc = lnImporte
thisform.recibos.fec_emis = loDT.getDateTime()
thisform.recibos.grabar_movcaja = .T.

IF !Thisform.recibos.grabar() THEN 
	RETURN .F.
ENDIF 

goConn.Commit()
MESSAGEBOX("La caja fue abierta correctamente", 0+64, Thisform.Caption)
Thisform.Release()
RETURN .T.
ENDPROC


************************************************************
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 89
Left = 205
TabIndex = 5
Name = "btnCerrar"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Fecha:"
Height = 15
Left = 6
Top = 11
Width = 48
TabIndex = 6
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Hora:"
Height = 15
Left = 6
Top = 36
Width = 48
TabIndex = 7
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Saldo Inicial:"
Height = 15
Left = 6
Top = 61
Width = 78
TabIndex = 8
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: txtFecha
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 91
TabIndex = 1
Top = 6
Width = 123
Name = "txtFecha"

*** METODOS ***


************************************************************
OBJETO: txtHora
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 91
TabIndex = 2
Top = 32
Width = 123
Name = "txtHora"

*** METODOS ***


************************************************************
OBJETO: txtSaldoInic
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 91
TabIndex = 3
Top = 58
Width = 123
autocompleta = .F.
isnumeric = .T.
Name = "txtSaldoInic"

*** METODOS ***


************************************************************
OBJETO: recibos
************************************************************
*** PROPIEDADES ***
Top = 108
Left = 24
Height = 17
Width = 24
Name = "recibos"

*** METODOS ***


************************************************************
OBJETO: cl_apercaja
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cl_cierrecja
************************************************************
*** PROPIEDADES ***
BorderStyle = 2
Height = 253
Width = 620
DoCreate = .T.
Caption = "Cierre de Caja"
WindowType = 0
idmovcjac = 0
Name = "cl_cierrecja"

*** METODOS ***
PROCEDURE imprimir_cierre
LOCAL loResult, lcSql, lnCntFC, loDT

loResult = CREATEOBJECT("odbc_result")
loDT = CREATEOBJECT("datetime")
lcSql = ""
lnCntFC = 0

SELECT cur_ResCta
ZAP
SELECT cur_ResConc
ZAP

**************************************************************************************************
&& Armo el resumen por cuenta
**************************************************************************************************
lcSql = "SELECT	movcjadetp.idCtaCja, "
lcSql = lcSql + "		MAX(ctacja.codCtaCJ) AS codigo, "
lcSql = lcSql + "		MAX(ctacja.descripcio) AS descripcio, "
lcSql = lcSql + "		SUM(CASE WHEN conccj.signo = 1 THEN movcjadetp.importe ELSE movcjadetp.importe * -1 END) AS importe "
lcSql = lcSql + "FROM	movcjacab INNER JOIN movcjadet ON movcjacab.idMovCjaC = movcjadet.idMovCjaC "
lcSql = lcSql + "	INNER JOIN movcjadetp ON movcjadet.idMovCjaD = movcjadetp.idMovCjaD AND movcjadet.idMovCjaC = movcjadetp.idMovCjaC "
lcSql = lcSql + "	INNER JOIN ctacja ON ctacja.idCtaCja = movcjadetp.idCtaCja "
lcSql = lcSql + "	INNER JOIN conccj ON conccj.idConcCJ = movcjadet.idConcCJ "
lcSql = lcSql + "WHERE	movcjacab.estado = 'A' "
lcSql = lcSql + "	AND movcjacab.usuBaja IS NULL "
lcSql = lcSql + "	AND movcjadet.usuBaja IS NULL "
lcSql = lcSql + "GROUP BY movcjadetp.idCtaCja "

loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_temp"

IF !loResult.OpenQuery(lcSql) THEN
	MESSAGEBOX(loResult.ErrorMessage, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_temp
IF RECCOUNT("cur_temp") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_temp") 
	SELECT cur_ResCta
	APPEND BLANK
	REPLACE cur_ResCta.codigo WITH cur_temp.codigo
	REPLACE cur_ResCta.descripcio WITH cur_temp.descripcio ADDITIVE
	REPLACE cur_ResCta.importe WITH ROUND(cur_temp.importe, 2) ADDITIVE

	SELECT cur_temp
	SKIP
ENDDO

loResult.Close_Query()

**************************************************************************************************
&& Armo el resumen por concepto/cuenta
**************************************************************************************************
lcSql = "SELECT	movcjadet.idConcCJ, "
lcSql = lcSql + "	movcjadetp.idCtaCja, "
lcSql = lcSql + "	MAX(conccj.codConcCJ)		AS codConc, "
lcSql = lcSql + "	MAX(conccj.descripcio)		AS concepto, "
lcSql = lcSql + "	MAX(ctacja.codCtaCJ)		AS codCjaCta, "
lcSql = lcSql + "	MAX(ctacja.descripcio)		AS ctaCja, "
lcSql = lcSql + "	SUM(CASE WHEN conccj.signo = 1 THEN movcjadetp.importe ELSE movcjadetp.importe * -1 END) AS importe "
lcSql = lcSql + "FROM	movcjadet INNER JOIN movcjacab ON movcjacab.idMovCjaC = movcjadet.idMovCjaC "
lcSql = lcSql + "	INNER JOIN movcjadetp ON movcjadetp.idMovCjaD = movcjadet.idMovCjaD AND movcjadet.idMovCjaC = movcjadetp.idMovCjaC"
lcSql = lcSql + "	INNER JOIN conccj ON conccj.idConcCJ = movcjadet.idConcCJ "
lcSql = lcSql + "	INNER JOIN ctacja ON movcjadetp.idCtaCja = ctacja.idCtaCja "
lcSql = lcSql + "WHERE	movcjacab.estado = 'A' "
lcSql = lcSql + "	AND movcjacab.usuBaja IS NULL "
lcSql = lcSql + "	AND movcjadet.usuBaja IS NULL "
lcSql = lcSql + "GROUP BY movcjadet.idConcCJ, movcjadetp.idCtaCja "
lcSql = lcSql + "ORDER BY idconccj, idctacja "

loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_temp"

IF !loResult.OpenQuery(lcSql) THEN
	MESSAGEBOX(loResult.ErrorMessage, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_temp
IF RECCOUNT("cur_temp") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_temp")
	SELECT cur_ResConc
	APPEND BLANK
	REPLACE cur_ResConc.codConc WITH cur_temp.codConc
	REPLACE cur_ResConc.concepto WITH cur_temp.concepto ADDITIVE
	REPLACE cur_ResConc.codCjaCta WITH cur_temp.codCjaCta ADDITIVE
	REPLACE cur_ResConc.ctaCja WITH cur_temp.ctacja ADDITIVE
	REPLACE cur_ResConc.importe WITH ROUND(cur_temp.importe, 2) ADDITIVE

	SELECT cur_temp
	SKIP
ENDDO

loResult.Close_Query()


* Calculo la cantidad de facturas aplicadas
lcSql = "SELECT	COUNT(*) AS CantFC "
lcSql = lcSql + "FROM	ventascab "
lcSql = lcSql + "WHERE	ventascab.cbte = 'FC' "

IF INT(VAL(getConfig("SQLSRV"))) = 1 THEN
	lcSql = lcSql + "	AND CONVERT(CHAR(8), ventascab.fecEmision, 112) = " + loDT.toMySql(DATE())
ELSE
	lcSql = lcSql + "	AND ventascab.fecEmision = " + loDT.getDateTime()
ENDIF

loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_cntFC"
loResult.OpenQuery(lcSql)

lnCntFC = cur_cntFC.CantFC

loResult.Close_Query()

SELECT cur_ResCta
REPORT FORM "rep_res_cjacta" TO PRINTER PROMPT PREVIEW 

SELECT cur_ResConc
REPORT FORM "rep_res_cjaconc" TO PRINTER PROMPT PREVIEW 

RETURN .T.

ENDPROC
PROCEDURE control_fisico
LOCAL lcSql, loResult, lnDif, lnContDif

lcSql = ""
loResult = CREATEOBJECT("odbc_result")
lnDif = 0.00
lnContDif = 0

lcSql = "SELECT	movcjadetp.idCtaCja, "
lcSql = lcSql + "		MAX(ctacja.codCtaCJ) AS codigo, "
lcSql = lcSql + "		MAX(ctacja.descripcio) AS cuenta, "
lcSql = lcSql + "		SUM(CASE WHEN conccj.signo = 1 THEN movcjadetp.importe ELSE movcjadetp.importe * -1 END) AS totimp "
lcSql = lcSql + "FROM	movcjacab INNER JOIN movcjadet ON movcjacab.idMovCjaC = movcjadet.idMovCjaC "
lcSql = lcSql + "	INNER JOIN movcjadetp ON movcjadet.idMovCjaD = movcjadetp.idMovCjaD AND movcjadet.idMovCjaC = movcjadetp.idMovCjaC "
lcSql = lcSql + "	INNER JOIN ctacja ON ctacja.idCtaCja = movcjadetp.idCtaCja "
lcSql = lcSql + "	INNER JOIN conccj ON conccj.idConcCJ = movcjadet.idConcCJ "
lcSql = lcSql + "WHERE	movcjacab.estado = 'A' "
lcSql = lcSql + "	AND movcjacab.usuBaja IS NULL "
lcSql = lcSql + "	AND movcjadet.usuBaja IS NULL "
lcSql = lcSql + "GROUP BY movcjadetp.idCtaCja "

loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_tempo"

IF !loResult.OpenQuery(lcSql) THEN
	MESSAGEBOX(loResult.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_tempo
DO WHILE !EOF("cur_tempo")
	SELECT cur_CtaCja
	GO TOP
	LOCATE FOR cur_CtaCja.idCtaCja = cur_tempo.idCtaCja
	IF FOUND() THEN
		lnDif = cur_CtaCja.imp_conteo - cur_tempo.totimp
		
		IF lnDif <> 0 THEN
			lnContDif = lnContDif + 1
		ENDIF
	
		LOCK()
		REPLACE cur_CtaCja.imp_sistema WITH cur_tempo.totimp
		REPLACE cur_CtaCja.difer WITH lnDif 
		UNLOCK
	ENDIF

	SELECT cur_tempo
	SKIP
ENDDO

loResult.Close_Query()

IF lnContDif > 0 THEN
	RETURN .F.
ENDIF

SELECT cur_CtaCja
IF RECCOUNT("cur_CtaCja") > 0 THEN
	GO TOP
ENDIF

Thisform.grdMovimientos.Refresh()

RETURN .T.

ENDPROC
PROCEDURE verificar_cajaabierta
LOCAL lcSql, loResult, lnCount

&& Verifico si se abrió la caja
lcSql = "SELECT COUNT(*) AS Cantidad FROM movcjacab WHERE estado = 'A'"
loResult = CREATEOBJECT("odbc_result")
lnCount = 0

loResult.Cursor_Name = "cur_tmp"
loResult.ActiveConnection = goConn.ActiveConnection
loResult.OpenQuery(lcSql)

IF TYPE("cur_tmp.Cantidad") == "C" THEN
	lnCount = INT(VAL(cur_tmp.Cantidad)) 
ELSE
	lnCount = cur_tmp.Cantidad
ENDIF

loResult.Close_Query()

IF lnCount = 0 THEN
	MESSAGEBOX("No hay caja abierta para cerrar", 0+48, Thisform.Caption)
	RETURN .F.
ELSE 
	lcSql = "SELECT idMovCjaC FROM movcjacab WHERE estado = 'A'"
	loResult.Cursor_Name = "cur_cab"
	loResult.ActiveConnection = goConn.ActiveConnection
	loResult.OpenQuery(lcSql)
	
	thisform.idmovcjac = cur_Cab.idMovCjaC
	
	loResult.Close_Query()
ENDIF

RETURN .T.
ENDPROC
PROCEDURE Init
DODEFAULT()

IF !Thisform.verificar_cajaabierta() THEN 
	Thisform.Release()
	RETURN .F.
ENDIF 

SELECT cur_CtaCja
Thisform.grdMovimientos.RecordSource = "cur_CtaCja"
Thisform.grdmovimientos.Alias_name = "cur_CtaCja"
Thisform.grdMovimientos.list_controlsource = "codCtaCJ, descripcio, imp_conteo, difer"
Thisform.grdMovimientos.lista_ancho_cols = "70,250,70,70"
Thisform.grdMovimientos.titulos_cabeceras = "Código,Descripción,Importe,Dif."
Thisform.grdMovimientos.generar_grid()

Thisform.grdMovimientos.Columns[3].ReadOnly = .F.


ENDPROC
PROCEDURE Load
LOCAL lcSql, loResult

DODEFAULT()

lcSql = ""
loResult = CREATEOBJECT("odbc_result")

CREATE CURSOR cur_CtaCja (	;
	idCtaCja	int,;
	codCtaCJ	varchar(5),;
	descripcio	varchar(60),;
	idPlanCta 	int,;
	imp_sistema	float(10,2),;
	imp_conteo	float(10,2),;
	difer		float(10,2))

* --------------------------------------------------

CREATE CURSOR cur_ResCta (	 ;
	codigo		varchar(5)	,;
	descripcio	varchar(60)	,;
	importe		float(10,2))
	
* --------------------------------------------------

CREATE CURSOR cur_ResConc (	;
	codConc		varchar(5)	,;
	concepto	varchar(60)	,;
	codCjaCta	varchar(5)	,;
	ctaCja		varchar(60)	,;
	importe		float(10, 2))
	
&& Levanto los registros de la cuentas de caja a contar

lcSql = "SELECT idCtaCja, codCtaCJ, descripcio, idPlanCta FROM ctacja ORDER BY descripcio ASC"

loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_tempo"

IF !loResult.OpenQuery(lcSql) THEN
	MESSAGEBOX(loResult.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_tempo
DO WHILE !EOF("cur_tempo")
	SELECT cur_CtaCja
	APPEND BLANK
	REPLACE idCtaCja WITH cur_tempo.idCtaCja
	REPLACE codCtaCJ WITH cur_tempo.codCtaCJ ADDITIVE
	REPLACE descripcio WITH cur_tempo.descripcio ADDITIVE
	REPLACE idPlanCta WITH IIF(ISNULL(cur_tempo.idPlanCta), 0, cur_tempo.idPlanCta) ADDITIVE
	REPLACE imp_sistema WITH 0.00 ADDITIVE
	REPLACE imp_conteo WITH 0.00 ADDITIVE

	SELECT cur_tempo
	SKIP
ENDDO

loResult.Close_Query()

SELECT cur_CtaCja
IF RECCOUNT("cur_CtaCja") > 0 THEN
	GO TOP
ENDIF

RETURN .T.
ENDPROC


************************************************************
OBJETO: grdMovimientos
************************************************************
*** PROPIEDADES ***
Height = 207
Left = 0
TabIndex = 1
Top = 0
Width = 621
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdMovimientos"
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
OBJETO: btnCerrarCaja
************************************************************
*** PROPIEDADES ***
Top = 208
Left = 525
TabIndex = 2
Name = "btnCerrarCaja"

*** METODOS ***
PROCEDURE Click
LOCAL lcSql, loResult, loCommand, loDT, lnResp, lnIdMovCjaDif, lb_dif

lcSql = ""
loResult = CREATEOBJECT("odbc_result")
loCommand = CREATEOBJECT("odbc_command")
loDT = CREATEOBJECT("datetime")
lnIdMovCjaDif = 0
lb_dif = .F.

&& Realizo el control fisico
IF !Thisform.control_fisico() THEN
	lnResp = MESSAGEBOX("Se han detectado diferencias en la caja. ¿Desea imprimir la caja de todas formas?", 4+32, Thisform.Caption)
	
	IF lnResp = 7 THEN
		RETURN .F.
	ENDIF
	
	lb_dif = .T.
	
	&& Si decide cerrar, emito el reporte con las diferencias de caja
	SELECT cur_CtaCja
	REPORT FORM "rep_dif_caja" TO PRINTER PROMPT PREVIEW
ENDIF

&& Primero imprimo el cierre de caja y después procedo a realizar el cierre en la base
Thisform.imprimir_cierre()

goConn.BeginTransaction()

&& Grabo el cierre de caja
lcSql = "UPDATE movcjacab SET estado = 'C', "
lcSql = lcSql + "conDiferencia = " + IIF(lb_dif, "1", "0") + ", "
lcSql = lcSql + "usuModi = '" + ALLTRIM(gcCodUsu) + "', "
lcSql = lcSql + "fecModi = " + loDT.getDateTime() + ", " 
lcSql = lcSql + "idHostModi = '" + ALLTRIM(SYS(0)) + "' " 
lcSql = lcSql + "WHERE idMovCjaC = " + ALLTRIM(STR(Thisform.idmovcjac))

loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = lcSql

IF !loCommand.Execute() THEN
	goConn.Rollback()
	MESSAGEBOX("Error al intentar grabar el cierre de caja", 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

&& Aca tengo que hacer que grabe el cierre 
************************************************************************************************
&& Hago el insert en la tabla MovCjaDetP
************************************************************************************************

SELECT cur_CtaCja
IF RECCOUNT("cur_CtaCja") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_CtaCja")

	&& Levanto el ID de MovCjaDetP
	lcSql = "SELECT MAX(idMovCjaDif) AS maxID FROM movcjadif WHERE IdMovCjaC = " + ALLTRIM(STR(Thisform.idmovcjac))
	loResult.Cursor_Name = "cur_det"
	loResult.ActiveConnection = goConn.ActiveConnection
	
	IF !loResult.OpenQuery(lcSql) THEN
		goConn.Rollback()
		MESSAGEBOX(loResult.Error_Message, 0+48, Thisform.Caption)
		RETURN .F.
	ENDIF

	IF ISNULL(cur_det.maxID) THEN
		lnIdMovCjaDif = 1
	ELSE
		lnIdMovCjaDif = cur_det.maxID + 1
	ENDIF

	loResult.Close_Query()

	&& Genera el detalle en MovCjaDetP
	lcSql = "INSERT INTO movcjadif (IdMovCjaDif, IdMovCjaC, idPlanCta, idCtaCja, descripcio, importe,  imp_fisico, diferencia, usuCierre, fecCierre, idHostCierre) "
	lcSql = lcSql + "VALUES (" + ALLTRIM(STR(lnIdMovCjaDif)) + ", " + ALLTRIM(STR(Thisform.idmovcjac)) + ", " + IIF(cur_CtaCja.idPlanCta = 0, "NULL", ALLTRIM(STR(cur_CtaCja.idPlanCta))) + ", " 
	lcSql = lcSql + ALLTRIM(STR(cur_CtaCja.IdCtaCja)) + ", '" + ALLTRIM(cur_CtaCja.descripcio) + "', " + ALLTRIM(STR(cur_CtaCja.imp_sistema, 10, 2)) + ", " 
	lcSql = lcSql + ALLTRIM(STR(cur_CtaCja.imp_conteo, 10, 2)) + ", " + ALLTRIM(STR(cur_CtaCja.difer, 10, 2)) + ", " 
	lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', " + loDT.getDateTime() + ", '" + ALLTRIM(SYS(0)) + "')"
			
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql

	IF !loCommand.Execute() THEN
		goConn.Rollback()
		MESSAGEBOX(ALLTRIM(loCommand.ErrorMessage), 0+48, Thisform.Caption)
		RETURN .F.
	ENDIF
	
	SELECT cur_CtaCja
	SKIP 
ENDDO


goConn.Commit()

MESSAGEBOX("La caja se cerró correctamente", 0+64, Thisform.Caption)
Thisform.Release()
RETURN .T.


ENDPROC


************************************************************
OBJETO: btnCancelar
************************************************************
*** PROPIEDADES ***
Top = 208
Left = 572
TabIndex = 3
Name = "btnCancelar"

*** METODOS ***


************************************************************
OBJETO: cl_cierrecja
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: cl_consulta_caja
************************************************************
*** PROPIEDADES ***
Height = 600
Width = 890
DoCreate = .T.
Caption = "Consulta de Caja"
Name = "cl_consulta_caja"

*** METODOS ***
PROCEDURE leer_cajadiaria
&& Levanto los datos de la caja diaria
PARAMETERS lnIdMovCjaCab

LOCAL lcSql, loResult, lnDebe, lnHaber, lnSaldo

lcSql = ""
loResult = CREATEOBJECT("odbc_result")
lnDebe = 0.00
lnHaber = 0.00
lnSaldo = 0.00
lcNroCbte = ""


SELECT cur_movCaja
ZAP

*****************************************************************************
&& Levanto los datos a la grilla grdMovCaja
*****************************************************************************
lcSql = "SELECT	movcjadet.idMovCjaD, "
lcSql = lcSql + "movcjadet.idMovCjaC, "
lcSql = lcSql + "movcjadet.fecha, "
lcSql = lcSql + "conccj.descripcio AS concepto, "
lcSql = lcSql + "conccj.signo, "
lcSql = lcSql + "movcjadet.cbte, "
lcSql = lcSql + "movcjadet.tipodoc,  "
lcSql = lcSql + "movcjadet.ptovta, "
lcSql = lcSql + "movcjadet.nrocbte, "
lcSql = lcSql + "movcjadet.importe "
lcSql = lcSql + "FROM	movcjadet, "
lcSql = lcSql + "movcjacab, "
lcSql = lcSql + "conccj "
lcSql = lcSql + "WHERE	movcjadet.idMovCjaC = movcjacab.idMovCjaC "
lcSql = lcSql + "	AND	movcjadet.idConcCJ = conccj.idConcCJ "
lcSql = lcSql + "	AND movcjacab.usuBaja IS NULL "
lcSql = lcSql + "	AND movcjadet.usuBaja IS NULL "
lcSql = lcSql + "	AND movcjacab.idMovCjaC = " + ALLTRIM(STR(lnIdMovCjaCab)) + " "
lcSql = lcSql + "ORDER BY idMovCjaD ASC "

loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_mov"
loResult.OpenQuery(lcSql)

SELECT cur_mov
IF RECCOUNT("cur_mov") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_mov")
	lcNroCbte = REPLICATE("0", 4 - LEN(ALLTRIM(STR(cur_mov.ptovta)))) + ALLTRIM(STR(cur_mov.ptovta)) + "-" + REPLICATE("0", 8 - LEN(ALLTRIM(STR(cur_mov.nrocbte)))) + ALLTRIM(STR(cur_mov.nrocbte))
	lnDebe = 0.00
	lnHaber = 0.00
	
	IF cur_mov.signo = 1 THEN
		lnDebe = cur_mov.importe
		lnSaldo = lnSaldo + lnDebe
	ELSE
		lnHaber = cur_mov.importe
		lnSaldo = lnSaldo - lnHaber
	ENDIF

	SELECT cur_movCaja
	APPEND BLANK
	
	REPLACE idMovCjaD 	WITH cur_mov.idMovCjaD	
	REPLACE idMovCjaC	WITH cur_mov.idMovCjaC	ADDITIVE
	REPLACE fecha		WITH cur_mov.fecha		ADDITIVE
	REPLACE conCcj		WITH cur_mov.concepto 	ADDITIVE
	REPLACE cbte		WITH cur_mov.cbte 		ADDITIVE
	REPLACE tipodoc		WITH cur_mov.tipodoc	ADDITIVE
	REPLACE nrocbte		WITH ALLTRIM(lcNroCbte)	ADDITIVE
	REPLACE impDebe		WITH lnDebe				ADDITIVE
	REPLACE impHaber	WITH lnHaber			ADDITIVE
	REPLACE saldo		WITH lnSaldo			ADDITIVE

	SELECT cur_mov
	SKIP
ENDDO

loResult.Close_Query()

SELECT cur_movCaja
IF RECCOUNT("cur_movCaja") > 0 THEN
	GO TOP
ENDIF

Thisform.contenedor.pgf.page2.grdMovCaja.Refresh()
Thisform.leer_detcajadiaria()
ENDPROC
PROCEDURE leer_detcajadiaria
LOCAL lcSql, loResult, lcNroCbte

lcSql = ""
loResult = CREATEOBJECT("odbc_result")
lcNroCbte = ""

SELECT cur_movCajaDet
ZAP
SELECT cur_movCajaCbte
ZAP


*****************************************************************************
&& Levanto los datos a la grilla grdMovCajaDet
*****************************************************************************
lcSql = "SELECT	ctacja.descripcio AS ctacja, "
lcSql = lcSql + "movcjadetp.importe, "
lcSql = lcSql + "bancos.descripcio AS banco, "
lcSql = lcSql + "movcjadetp.chq_nro, "
lcSql = lcSql + "provincias.descripcio AS provincia, "
lcSql = lcSql + "movcjadetp.retCompro, "
lcSql = lcSql + "movcjadetp.retFecha "
lcSql = lcSql + "FROM movcjadetp "
lcSql = lcSql + "	INNER JOIN ctacja ON movcjadetp.idCtaCja = ctacja.idCtaCja "
lcsql = lcSql + " 	LEFT JOIN bancos ON movcjadetp.idBanco = bancos.idBanco "
lcsql = lcSql + " 	LEFT JOIN provincias ON movcjadetp.idProvin = provincias.idProvin "
lcSql = lcSql + "WHERE movcjadetp.idMovCjaC = " + ALLTRIM(STR(cur_movCaja.idMovCjaC)) + " "
lcSql = lcSql + "	AND movcjadetp.idMovCjaD = " + ALLTRIM(STR(cur_movCaja.idMovCjaD)) + " "
lcSql = lcSql + "ORDER BY ctacja ASC "

loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_mov"
loResult.OpenQuery(lcSql)

SELECT cur_mov
IF RECCOUNT("cur_mov") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_mov")
	SELECT cur_movCajaDet
	APPEND BLANK

	REPLACE ctaCja		WITH cur_mov.ctaCja 	ADDITIVE
	REPLACE importe		WITH cur_mov.importe 	ADDITIVE
	REPLACE banco		WITH IIF(ISNULL(cur_mov.banco), "", cur_mov.banco) ADDITIVE
	REPLACE nrocheque	WITH IIF(ISNULL(cur_mov.chq_nro), "", cur_mov.chq_nro) ADDITIVE
	REPLACE provincia	WITH IIF(ISNULL(cur_mov.provincia), "", cur_mov.provincia) ADDITIVE
	REPLACE retcompro	WITH IIF(ISNULL(cur_mov.retCompro), 0, cur_mov.retCompro) ADDITIVE
	REPLACE retfecha	WITH IIF(ISNULL(cur_mov.retFecha), {}, cur_mov.retFecha) ADDITIVE

	SELECT cur_mov
	SKIP
ENDDO

loResult.Close_Query()

SELECT cur_movCajaDet
IF RECCOUNT("cur_movCajaDet") > 0 THEN
	GO TOP
ENDIF

Thisform.contenedor.pgf.page2.grdMovCajaDet.Refresh()


*****************************************************************************
&& Levanto los datos a la grilla grdMovCajaCbte
*****************************************************************************
lcSql = "SELECT	movcjarel.idMovCjaR, "
lcSql = lcSql + "cc_cli.fecEmis AS fecEmision, "
lcSql = lcSql + "cc_cli.idCliente, "
lcSql = lcSql + "clientes.razSoc, "
lcSql = lcSql + "movcjarel.cbte, "
lcSql = lcSql + "movcjarel.tipoDoc, "
lcSql = lcSql + "movcjarel.ptoVta, "
lcSql = lcSql + "movcjarel.numCbte, "
lcSql = lcSql + "movcjarel.importe, "
lcSql = lcSql + "movcjarel.saldo "
lcSql = lcSql + "FROM movcjarel "
lcSql = lcSql + "	INNER JOIN cc_cli ON movcjarel.idCC_Cli = cc_cli.idCC_Cli "
lcsql = lcSql + " 	INNER JOIN clientes ON cc_cli.idCliente = clientes.idCliente "
lcSql = lcSql + "WHERE movcjarel.idMovCjaC = " + ALLTRIM(STR(cur_movCaja.idMovCjaC)) + " "
lcSql = lcSql + "	AND movcjarel.idMovCjaD = " + ALLTRIM(STR(cur_movCaja.idMovCjaD)) + " "
lcSql = lcSql + "ORDER BY idMovCjaR ASC "

loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_mov"
loResult.OpenQuery(lcSql)

SELECT cur_mov
IF RECCOUNT("cur_mov") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_mov")
	lcNroCbte = REPLICATE("0", 4 - LEN(ALLTRIM(STR(cur_mov.ptovta)))) + ALLTRIM(STR(cur_mov.ptovta)) + "-" + REPLICATE("0", 8 - LEN(ALLTRIM(STR(cur_mov.numcbte)))) + ALLTRIM(STR(cur_mov.numcbte))
	SELECT cur_movCajaCbte
	APPEND BLANK

	REPLACE idMovCjaR	WITH cur_mov.idMovCjaR 	ADDITIVE
	REPLACE fecha		WITH cur_mov.fecEmision	ADDITIVE
	REPLACE idCliente	WITH cur_mov.idCliente 	ADDITIVE
	REPLACE RazSoc		WITH cur_mov.razSoc		ADDITIVE
	REPLACE cbte		WITH cur_mov.cbte 		ADDITIVE
	REPLACE tipodoc		WITH cur_mov.tipoDoc	ADDITIVE
	REPLACE nrocbte		WITH ALLTRIM(lcNroCbte) ADDITIVE
	REPLACE importe		WITH cur_mov.importe	ADDITIVE
	REPLACE saldo		WITH cur_mov.saldo	 	ADDITIVE

	SELECT cur_mov
	SKIP
ENDDO

loResult.Close_Query()

SELECT cur_movCajaCbte
IF RECCOUNT("cur_movCajaCbte") > 0 THEN
	GO TOP
ENDIF

Thisform.contenedor.pgf.page2.grdMovCajaCbte.Refresh()
ENDPROC
PROCEDURE limpiar
Thisform.contenedor.txtFecDesde.Value = DATE() - 30
Thisform.contenedor.txtFecHasta.Value = DATE()
Thisform.contenedor.txtnumero.Value = 0
Thisform.contenedor.chkDiferencia.Value = 0 

SELECT cur_cab
ZAP 

SELECT cur_movCaja
ZAP

SELECT cur_movCajaDet
ZAP

SELECT cur_movCajaCbte
ZAP

Thisform.contenedor.pgf.page1.grdMovCajaCab.Refresh()
Thisform.contenedor.pgf.page2.grdMovCaja.Refresh()
Thisform.contenedor.pgf.page2.grdMovCajaCbte.Refresh()
Thisform.contenedor.pgf.page2.grdMovCajaDet.Refresh()

ENDPROC
PROCEDURE Load
DODEFAULT()

CREATE CURSOR cur_cab(;
	idMovCjaC	int,;
	fecha		datetime,;
	estado 		varchar(1),;
	usuAlta		varchar(5),;
	idHostAlta	varchar(50),;
	conDiferencia l)
	

CREATE CURSOR cur_MovCaja (;
	idMovCjaD	int,;
	idMovCjaC	int,;
	fecha		datetime,;
	conCcj		varchar(60),;
	cbte		varchar(3),;
	tipodoc		varchar(1),;
	nrocbte		varchar(13),;
	impDebe		float(10, 2),;
	impHaber	float(10, 2),;
	saldo		float(10, 2))
	

CREATE CURSOR cur_MovCajaDet (;
	ctaCja		varchar(60),;
	importe		float(10, 2),;
	banco		varchar(60),;
	nrocheque	varchar(8),;
	provincia	varchar(60),;
	retCompro	int,;
	retFecha	datetime)
	

CREATE CURSOR cur_MovCajaCbte (;
	idMovCjaR	int,;
	fecha		datetime,;
	idCliente	int,;
	RazSoc		varchar(60),;
	cbte		varchar(3),;
	tipodoc		varchar(1),;
	nrocbte		varchar(13),;
	importe		float(10, 2),;
	saldo		float(10, 2))
	
	
CREATE CURSOR cur_ResCta (	 ;
	codigo		varchar(5)	,;
	descripcio	varchar(60)	,;
	importe		float(10,2))
	

CREATE CURSOR cur_ResConc (	;
	codConc		varchar(5)	,;
	concepto	varchar(60)	,;
	codCjaCta	varchar(5)	,;
	ctaCja		varchar(60)	,;
	importe		float(10, 2))	
ENDPROC
PROCEDURE Init

Thisform.contenedor.txtFecDesde.Value = DATE() - 30
Thisform.contenedor.txtFecHasta.Value = DATE()

&& Grilla donde se muestran las cabeceras de cajas diaria
SELECT cur_cab
Thisform.contenedor.pgf.page1.grdMovCajaCab.RecordSource = "cur_cab"
Thisform.contenedor.pgf.page1.grdMovCajaCab.list_controlsource = "idMovCjaC,fecha,estado,usualta,idHostAlta,conDiferencia"
Thisform.contenedor.pgf.page1.grdMovCajaCab.lista_ancho_cols = "50,130,70,70,150,100"
Thisform.contenedor.pgf.page1.grdMovCajaCab.titulos_cabeceras = "Nº Caja.,Fecha,Estado,Usuario,Host,Con Diferencia"
Thisform.contenedor.pgf.page1.grdMovCajaCab.permitir_busqueda = .F.
Thisform.contenedor.pgf.page1.grdMovCajaCab.permitir_ordenamiento = .F.
Thisform.contenedor.pgf.page1.grdMovCajaCab.generar_grid()

&& Grilla donde se muestran las cabeceras de los movimientos de la cajas diaria
SELECT cur_MovCaja
Thisform.contenedor.pgf.page2.grdMovCaja.RecordSource = "cur_MovCaja"
Thisform.contenedor.pgf.page2.grdMovCaja.list_controlsource = "idMovCjaD,fecha,conccj,cbte,tipodoc,nrocbte,impdebe,imphaber,saldo"
Thisform.contenedor.pgf.page2.grdMovCaja.lista_ancho_cols = "50,130,240,50,50,100,70,70,70"
Thisform.contenedor.pgf.page2.grdMovCaja.titulos_cabeceras = "Nº Mov.,Fecha,Concepto,Cbte,Tipo,Número,Debe,Haber,Saldo"
Thisform.contenedor.pgf.page2.grdMovCaja.permitir_busqueda = .F.
Thisform.contenedor.pgf.page2.grdMovCaja.permitir_ordenamiento = .F.
Thisform.contenedor.pgf.page2.grdMovCaja.generar_grid()


&& Grilla donde se muestran los medios de pago utilizados por cada movimiento
SELECT cur_MovCajaDet
Thisform.contenedor.pgf.page2.grdMovCajaDet.RecordSource = "cur_MovCajaDet"
Thisform.contenedor.pgf.page2.grdMovCajaDet.list_controlsource = "ctaCja,importe,banco,nrocheque,provincia,retCompro,retFecha"
Thisform.contenedor.pgf.page2.grdMovCajaDet.lista_ancho_cols = "200,70,150,70,120,70,130"
Thisform.contenedor.pgf.page2.grdMovCajaDet.titulos_cabeceras = "Cuenta,Importe,Banco,Nº Cheque,Ret. Prov.,Ret. Cbte,Ret. Fecha"
Thisform.contenedor.pgf.page2.grdMovCajaDet.permitir_busqueda = .F.
Thisform.contenedor.pgf.page2.grdMovCajaDet.permitir_ordenamiento = .F.
Thisform.contenedor.pgf.page2.grdMovCajaDet.generar_grid()


&& Grilla donde se muestran los cbtes aplicados por cada movimiento
SELECT cur_MovCajaCbte
Thisform.contenedor.pgf.page2.grdMovCajaCbte.RecordSource = "cur_MovCajaCbte"
Thisform.contenedor.pgf.page2.grdMovCajaCbte.list_controlsource = "fecha,idCliente,RazSoc,cbte,tipodoc,nrocbte,importe,saldo"
Thisform.contenedor.pgf.page2.grdMovCajaCbte.lista_ancho_cols = "130,70,200,50,50,100,70,70"
Thisform.contenedor.pgf.page2.grdMovCajaCbte.titulos_cabeceras = "Fecha, Nº Cliente,Razon Social,Cbte,Tipo,Número,Importe,Saldo"
Thisform.contenedor.pgf.page2.grdMovCajaCbte.permitir_busqueda = .F.
Thisform.contenedor.pgf.page2.grdMovCajaCbte.permitir_ordenamiento = .F.
Thisform.contenedor.pgf.page2.grdMovCajaCbte.generar_grid()
ENDPROC


************************************************************
OBJETO: Contenedor
************************************************************
*** PROPIEDADES ***
Top = 0
Left = 0
Width = 891
Height = 601
BackColor = 241,236,235
Name = "Contenedor"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Fecha Desde:"
Height = 15
Left = 10
Top = 16
Width = 84
TabIndex = 15
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Fecha Hasta:"
Height = 15
Left = 209
Top = 16
Width = 84
TabIndex = 16
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: txtFecDesde
************************************************************
*** PROPIEDADES ***
Left = 100
TabIndex = 1
Top = 12
isdatetime = .T.
Name = "txtFecDesde"

*** METODOS ***


************************************************************
OBJETO: txtFecHasta
************************************************************
*** PROPIEDADES ***
Left = 286
TabIndex = 2
Top = 12
isdatetime = .T.
Name = "txtFecHasta"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Movimiento:"
Height = 15
Left = 407
Top = 16
Width = 72
TabIndex = 14
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: txtnumero
************************************************************
*** PROPIEDADES ***
Alignment = 3
Value = 
Height = 21
Left = 481
MaxLength = 8
TabIndex = 3
Top = 12
Width = 90
ischaracter = .F.
autocompleta = .F.
isnumeric = .F.
isinteger = .T.
Name = "txtnumero"

*** METODOS ***


************************************************************
OBJETO: btnSalir
************************************************************
*** PROPIEDADES ***
Top = 554
Left = 840
TabIndex = 9
Name = "btnSalir"

*** METODOS ***


************************************************************
OBJETO: btnBuscar
************************************************************
*** PROPIEDADES ***
Top = 3
Left = 825
TabIndex = 5
Name = "btnBuscar"

*** METODOS ***
PROCEDURE Click
LOCAL lcSql, loResult, loDT
LOCAL lcFecDesde, lcFecHasta, lnNumero, lb_dif


lcSql = ""
loResult = CREATEOBJECT("odbc_result")
loDT = CREATEOBJECT("datetime")

lcFecDesde = loDT.toMySql(thisform.contenedor.txtFecDesde.Value)
lcFecHasta = loDT.toMySql(thisform.contenedor.txtFecHasta.Value)
lnNumero = Thisform.contenedor.txtnumero.Value
lb_dif = Thisform.contenedor.chkDiferencia.Value

SELECT cur_cab
ZAP

lcSql = "SELECT	* "
lcSql = lcSql + "FROM movcjacab "
lcSql = lcSql + "WHERE usubaja is null "

IF INT(VAL(getConfig("SQLSRV"))) = 1 THEN
	lcSql = lcSql + "         AND (CONVERT(CHAR(8), fecha , 112) BETWEEN " + lcFecDesde + " AND " + lcFecHasta + ") "
ELSE
	IF INT(VAL(getConfig("SQLSRV"))) = 0 THEN
		lcSql = lcSql + "         AND (CAST(fecha AS DATE) BETWEEN " + lcFecDesde + " AND " + lcFecHasta + ") "
	ELSE
		lcSql = lcSql + "         AND (fecha BETWEEN " + lcFecDesde + " AND " + lcFecHasta + ") "
	ENDIF
ENDIF

IF lnNumero <> 0 THEN
	lcSql = lcSql + " AND idMovCjaC = " + ALLTRIM(STR(lnNumero)) + " "  
ENDIF 

IF lb_dif = 1 THEN
	lcSql = lcSql + " AND conDiferencia = 1 "  
ENDIF 

lcSql = lcSql + "ORDER BY idMovCjaC ASC"

loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_tempo"

IF !loResult.OpenQuery(lcSql) THEN
	MESSAGEBOX(loResult.error_message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_tempo
IF RECCOUNT("cur_tempo") > 0 THEN
	GO TOP 
ENDIF

DO WHILE !EOF("cur_tempo")
	
	SELECT cur_cab
	APPEND BLANK
	REPLACE cur_cab.idMovCjaC WITH cur_tempo.idMovCjaC
	REPLACE cur_cab.fecha WITH cur_tempo.fecha ADDITIVE
	REPLACE cur_cab.estado WITH cur_tempo.estado ADDITIVE
	REPLACE cur_cab.usualta WITH IIF(ISNULL(cur_tempo.usualta),"",cur_tempo.usualta) ADDITIVE
	REPLACE cur_cab.idHostAlta WITH IIF(ISNULL(cur_tempo.idHostAlta),"",cur_tempo.idHostAlta) ADDITIVE
	REPLACE cur_cab.conDiferencia WITH IIF(cur_tempo.conDiferencia, .T., .F.) ADDITIVE
	 
	SELECT cur_tempo
	SKIP
ENDDO

loResult.Close_Query()

SELECT cur_cab
IF RECCOUNT("cur_cab") > 0 THEN
	GO TOP
ENDIF

Thisform.contenedor.pgf.page1.grdMovCajaCab.Refresh()

RETURN .T.


ENDPROC


************************************************************
OBJETO: chkDiferencia
************************************************************
*** PROPIEDADES ***
Top = 14
Left = 589
Height = 18
Width = 147
Alignment = 0
Caption = "Cierre con Diferencias"
TabIndex = 4
Name = "chkDiferencia"

*** METODOS ***


************************************************************
OBJETO: pgf
************************************************************
*** PROPIEDADES ***
ErasePage = .T.
PageCount = 2
Top = 50
Left = 4
Width = 886
Height = 503
Name = "pgf"
Page1.Caption = "Cabecera de Caja"
Page1.Name = "Page1"
Page2.Caption = "Detalle Movimientos"
Page2.Name = "Page2"

*** METODOS ***
PROCEDURE Page2.SetFocus
SELECT cur_cab
IF RECCOUNT("cur_cab") > 0 THEN 
	Thisform.leer_cajadiaria(cur_cab.idMovCjaC)	
ENDIF 

Thisform.contenedor.pgf.page2.grdMovCaja.SetFocus()

ENDPROC
PROCEDURE Page2.Click
SELECT cur_cab
IF RECCOUNT("cur_cab") > 0 THEN 
	Thisform.leer_cajadiaria(cur_cab.idMovCjaC)	
ENDIF 

Thisform.contenedor.pgf.page2.grdMovCaja.SetFocus()

ENDPROC


************************************************************
OBJETO: grdMovCajaCab
************************************************************
*** PROPIEDADES ***
Height = 464
Left = 4
TabIndex = 6
Top = 10
Width = 872
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdMovCajaCab"
COLUMN1.Header1.Name = "Header1"
COLUMN1.Text1.ReadOnly = .T.
COLUMN1.Text1.Name = "Text1"
COLUMN1.CurrentControl = "Text1"
COLUMN1.ReadOnly = .T.
COLUMN1.Sparse = .T.
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
COLUMN6.Header1.Caption = "Header1"
COLUMN6.Header1.Name = "Header1"
COLUMN6.Text1.Name = "Text1"
COLUMN6.ControlSource = ""
COLUMN6.CurrentControl = "chkConDif"
COLUMN6.Sparse = .F.
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
PROCEDURE AfterRowColChange
LPARAMETERS nColIndex


ENDPROC
PROCEDURE press_enter
&&Thisform.contenedor.pgf.page2.Click()
Thisform.contenedor.pgf.page2.SetFocus()

ENDPROC


************************************************************
OBJETO: Clscheckbox1
************************************************************
*** PROPIEDADES ***
Top = 30
Left = 14
Alignment = 0
Caption = ""
ControlSource = ""
ReadOnly = .F.
Name = "Clscheckbox1"

*** METODOS ***
PROCEDURE Click
IF this.Value THEN
	Thisform.txtImpImputar.Value = Thisform.txtImpImputar.Value + cur_facturas.saldo
	Thisform.txtimpcbtes.Value = Thisform.txtimpcbtes.Value + cur_facturas.saldo
ELSE
	Thisform.txtImpImputar.Value = Thisform.txtImpImputar.Value - cur_facturas.saldo
	Thisform.txtimpcbtes.Value = Thisform.txtimpcbtes.Value - cur_facturas.saldo
ENDIF

Thisform.calc_saldoimputar()
ENDPROC


************************************************************
OBJETO: chkConDif
************************************************************
*** PROPIEDADES ***
Top = 24
Left = 8
Alignment = 0
Centered = .T.
Caption = ""
ReadOnly = .T.
Name = "chkConDif"

*** METODOS ***


************************************************************
OBJETO: grdMovCaja
************************************************************
*** PROPIEDADES ***
Height = 165
Left = 3
Top = 21
Width = 876
Name = "grdMovCaja"
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
PROCEDURE AfterRowColChange
LPARAMETERS nColIndex

Thisform.leer_detcajadiaria()
ENDPROC


************************************************************
OBJETO: grdMovCajaDet
************************************************************
*** PROPIEDADES ***
Height = 150
Left = 3
Top = 205
Width = 876
Name = "grdMovCajaDet"
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
OBJETO: grdMovCajaCbte
************************************************************
*** PROPIEDADES ***
Height = 96
Left = 3
Top = 376
Width = 876
Name = "grdMovCajaCbte"
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
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Movimientos de Caja"
Height = 15
Left = 6
Top = 3
Width = 180
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Medios de pago"
Height = 14
Left = 6
Top = 188
Width = 180
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Comprobantes cancelados"
Height = 12
Left = 6
Top = 359
Width = 180
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: btnImprimir
************************************************************
*** PROPIEDADES ***
Top = 554
Left = 794
TabIndex = 8
ToolTipText = "Imprimir Parcial"
Name = "btnImprimir"

*** METODOS ***
PROCEDURE Click
LOCAL loResult, lcSql, lnCntFC, loDT

loResult = CREATEOBJECT("odbc_result")
loDT = CREATEOBJECT("datetime")
lcSql = ""
lnCntFC = 0


IF RECCOUNT("cur_cab") = 0 THEN 
	RETURN .F.
ENDIF 

SELECT cur_ResCta
ZAP
SELECT cur_ResConc
ZAP

**************************************************************************************************
&& Armo el resumen por cuenta
**************************************************************************************************
lcSql = "SELECT	movcjadetp.idCtaCja, "
lcSql = lcSql + "		MAX(ctacja.codCtaCJ) AS codigo, "
lcSql = lcSql + "		MAX(ctacja.descripcio) AS descripcio, "
lcSql = lcSql + "		SUM(CASE WHEN conccj.signo = 1 THEN movcjadetp.importe ELSE movcjadetp.importe * -1 END) AS importe "
lcSql = lcSql + "FROM	movcjacab INNER JOIN movcjadet ON movcjacab.idMovCjaC = movcjadet.idMovCjaC "
lcSql = lcSql + "	INNER JOIN movcjadetp ON movcjadet.idMovCjaD = movcjadetp.idMovCjaD AND movcjadet.idMovCjaC = movcjadetp.idMovCjaC "
lcSql = lcSql + "	INNER JOIN ctacja ON ctacja.idCtaCja = movcjadetp.idCtaCja "
lcSql = lcSql + "	INNER JOIN conccj ON conccj.idConcCJ = movcjadet.idConcCJ "
lcSql = lcSql + "WHERE	movcjacab.usuBaja IS NULL "
lcSql = lcSql + "	AND movcjadet.usuBaja IS NULL "
lcSql = lcSql + "	AND movcjacab.idMovCjaC = " + ALLTRIM(STR(cur_cab.idMovCjaC)) + " "
lcSql = lcSql + "GROUP BY movcjadetp.idCtaCja "

loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_temp"

IF !loResult.OpenQuery(lcSql) THEN
	MESSAGEBOX(loResult.ErrorMessage, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_temp
IF RECCOUNT("cur_temp") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_temp") 
	SELECT cur_ResCta
	APPEND BLANK
	REPLACE cur_ResCta.codigo WITH cur_temp.codigo
	REPLACE cur_ResCta.descripcio WITH cur_temp.descripcio ADDITIVE
	REPLACE cur_ResCta.importe WITH ROUND(cur_temp.importe, 2) ADDITIVE

	SELECT cur_temp
	SKIP
ENDDO

loResult.Close_Query()

**************************************************************************************************
&& Armo el resumen por concepto/cuenta
**************************************************************************************************
lcSql = "SELECT	movcjadet.idConcCJ, "
lcSql = lcSql + "	movcjadetp.idCtaCja, "
lcSql = lcSql + "	MAX(conccj.codConcCJ)		AS codConc, "
lcSql = lcSql + "	MAX(conccj.descripcio)		AS concepto, "
lcSql = lcSql + "	MAX(ctacja.codCtaCJ)		AS codCjaCta, "
lcSql = lcSql + "	MAX(ctacja.descripcio)		AS ctaCja, "
lcSql = lcSql + "	SUM(CASE WHEN conccj.signo = 1 THEN movcjadetp.importe ELSE movcjadetp.importe * -1 END) AS importe "
lcSql = lcSql + "FROM	movcjadet INNER JOIN movcjacab ON movcjacab.idMovCjaC = movcjadet.idMovCjaC "
lcSql = lcSql + "	INNER JOIN movcjadetp ON movcjadetp.idMovCjaD = movcjadet.idMovCjaD AND movcjadet.idMovCjaC = movcjadetp.idMovCjaC"
lcSql = lcSql + "	INNER JOIN conccj ON conccj.idConcCJ = movcjadet.idConcCJ "
lcSql = lcSql + "	INNER JOIN ctacja ON movcjadetp.idCtaCja = ctacja.idCtaCja "
lcSql = lcSql + "WHERE	movcjacab.usuBaja IS NULL "
lcSql = lcSql + "	AND movcjadet.usuBaja IS NULL "
lcSql = lcSql + "	AND movcjacab.idMovCjaC = " + ALLTRIM(STR(cur_cab.idMovCjaC)) + " "
lcSql = lcSql + "GROUP BY movcjadet.idConcCJ, movcjadetp.idCtaCja "
lcSql = lcSql + "ORDER BY idconccj, idctacja "

loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_temp"

IF !loResult.OpenQuery(lcSql) THEN
	MESSAGEBOX(loResult.ErrorMessage, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_temp
IF RECCOUNT("cur_temp") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_temp")
	SELECT cur_ResConc
	APPEND BLANK
	REPLACE cur_ResConc.codConc WITH cur_temp.codConc
	REPLACE cur_ResConc.concepto WITH cur_temp.concepto ADDITIVE
	REPLACE cur_ResConc.codCjaCta WITH cur_temp.codCjaCta ADDITIVE
	REPLACE cur_ResConc.ctaCja WITH cur_temp.ctacja ADDITIVE
	REPLACE cur_ResConc.importe WITH ROUND(cur_temp.importe, 2) ADDITIVE

	SELECT cur_temp
	SKIP
ENDDO

loResult.Close_Query()


&& Calculo la cantidad de facturas aplicadas
lcSql = "SELECT	COUNT(*) AS CantFC "
lcSql = lcSql + "FROM	ventascab "
lcSql = lcSql + "WHERE	ventascab.cbte = 'FC' "

IF INT(VAL(getConfig("SQLSRV"))) = 1 THEN
	lcSql = lcSql + "	AND CONVERT(CHAR(8), ventascab.fecEmision, 112) = " + loDT.toMySql(DATE())
ELSE
	lcSql = lcSql + "	AND ventascab.fecEmision = " + loDT.getDateTime()
ENDIF

loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_cntFC"
loResult.OpenQuery(lcSql)

lnCntFC = cur_cntFC.CantFC

loResult.Close_Query()

SELECT cur_ResCta
REPORT FORM "rep_res_cjacta" TO PRINTER PROMPT PREVIEW 

SELECT cur_ResConc
REPORT FORM "rep_res_cjaconc" TO PRINTER PROMPT PREVIEW

RETURN .T.

ENDPROC


************************************************************
OBJETO: btnCancelar
************************************************************
*** PROPIEDADES ***
Top = 553
Left = 5
TabIndex = 7
Name = "btnCancelar"

*** METODOS ***
PROCEDURE Click
Thisform.limpiar()
ENDPROC


************************************************************
OBJETO: cl_consulta_caja
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: cl_control_caja
************************************************************
*** PROPIEDADES ***
Height = 590
Width = 830
DoCreate = .T.
Caption = "Control de Caja"
idmovcjac1 = 0
idmovcjac2 = 0
Name = "cl_control_caja"

*** METODOS ***
PROCEDURE levantar_datos
LOCAL lcSql, loResult, loResult2, loDT, loConC2, lbCajaAbierta1, lbCajaAbierta2 
LOCAL lnApertura, lnTotPagoCon, lnTotPagoCC, lnTotOtros, lnTotPago 

lcSql = ""
loResult = CREATEOBJECT("odbc_result")
loResult2 = CREATEOBJECT("odbc_result")
loDT = CREATEOBJECT("datetime")
loConC2 = CREATEOBJECT("odbc_connect")
lbCajaAbierta1 = IIF(thisform.idmovcjac1 = 0, .F., .T.)
lbCajaAbierta2 = IIF(thisform.idmovcjac2 = 0, .F., .T.)

lnApertura = 0
lnTotPagoCon = 0.00
lnTotPagoCC = 0.00
lnTotOtros = 0.00
lnTotPago = 0.00

&& Abro la conexion con la base de cuenta 1
loConC2.ConnectionString = ALLTRIM(getConfig("DMO_CC"))
IF !loConC2.Open() THEN
	MESSAGEBOX(loConC2.ErrorMessage, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

************************************************************************************
&& Busco el importe con el que se abrio la caja de cuenta 1
************************************************************************************
IF lbCajaAbierta1 = .T. THEN 
	lcSql = "SELECT * FROM movcjadet WHERE idConcCJ = 1 AND usuBaja IS NULL AND idMovCjaC = " + ALLTRIM(STR(thisform.idmovcjac1)) 
	loResult.Cursor_Name = "cur_tmp"
	loResult.ActiveConnection = goConn.ActiveConnection
	
	IF !loResult.OpenQuery(lcSql) THEN
		MESSAGEBOX(loResult.Error_Message, 0+48, Thisform.Caption)
		RETURN .F.
	ENDIF
	
	lnApertura = cur_tmp.importe
	loResult.Close_Query()
ENDIF 

************************************************************************************
&& Busco el importe con el que se abrio la caja de cuenta 2
************************************************************************************
IF lbCajaAbierta2 = .T. THEN 
	lcSql = "SELECT * FROM movcjadet WHERE idConcCJ = 1 AND usuBaja IS NULL AND idMovCjaC = " + ALLTRIM(STR(thisform.idmovcjac2))
	loResult.Cursor_Name = "cur_tmp"
	loResult.ActiveConnection = loConC2.ActiveConnection
	
	IF !loResult.OpenQuery(lcSql) THEN
		MESSAGEBOX(loResult.Error_Message, 0+48, Thisform.Caption)
		RETURN .F.
	ENDIF
	
	lnApertura = lnApertura + cur_tmp.importe
	loResult.Close_Query()
ENDIF 

thisform.contenido.txtApertura.value = lnApertura


************************************************************************************
&& Levanto la Facturacion del dia de cuenta 1
************************************************************************************
lcSql = "SELECT  CASE WHEN condpagos.cntDias = 0 THEN 0 ELSE 1 END condpago, "
lcSql = lcSql + "	ventascab.totFact "
lcSql = lcSql + "FROM ventascab "
lcSql = lcSql + "	INNER JOIN clientes ON ventascab.idCliente = clientes.idCliente "
lcSql = lcSql + "   INNER JOIN condpagos ON ventascab.idCondPago = condpagos.idCondPago "
lcSql = lcSql + "WHERE ventascab.cbte IN ('FC','NC','ND')  "
lcSql = lcSql + "	AND	ventascab.anulado = 0 "
lcSql = lcSql + "	AND ventascab.usuBaja IS NULL "
lcSql = lcSql + "	AND DAY(ventascab.fecAlta) = DAY(" + loDT.getDateTime() + ") "
lcSql = lcSql + "	AND MONTH(ventascab.fecAlta) = MONTH(" + loDT.getDateTime() + ") "
lcSql = lcSql + "	AND YEAR(ventascab.fecAlta) = YEAR(" + loDT.getDateTime() + ") "

loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_vtas"

IF !loResult.OpenQuery(lcSql) THEN
	MESSAGEBOX(loResult.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

&& Levanto lo de contado
SELECT SUM(totFact) AS totContadoC1 ;
FROM cur_vtas ;
WHERE condpago = 0;
GROUP BY condpago;
ORDER BY condpago ASC INTO CURSOR cur_tempo

SELECT cur_tempo
IF RECCOUNT("cur_tempo") > 0 THEN
	GO TOP
	Thisform.contenido.txtFactCont.Value = ROUND(cur_tempo.totContadoC1, 2)
ENDIF

USE IN cur_tempo

&& Levanto lo de cuenta corriente
SELECT SUM(totFact) AS totCtaCteC1 ;
FROM cur_vtas ;
WHERE condpago = 1;
GROUP BY condpago;
ORDER BY condpago ASC INTO CURSOR cur_tempo

SELECT cur_tempo
IF RECCOUNT("cur_tempo") > 0 THEN
	GO TOP
	Thisform.contenido.txtFactCC.Value = ROUND(cur_tempo.totCtaCteC1, 2)
ENDIF

USE IN cur_tempo
loResult.Close_Query()



************************************************************************************
&& Levanto la Facturacion del dia de cuenta 2
************************************************************************************
lcSql = "SELECT  CASE WHEN condpagos.cntDias = 0 THEN 0 ELSE 1 END condpago, "
lcSql = lcSql + "	ventascab.totFact "
lcSql = lcSql + "FROM ventascab "
lcSql = lcSql + "	INNER JOIN clientes ON ventascab.idCliente = clientes.idCliente "
lcSql = lcSql + "   INNER JOIN condpagos ON ventascab.idCondPago = condpagos.idCondPago "
lcSql = lcSql + "WHERE ventascab.cbte IN ('FC','NC','ND')  "
lcSql = lcSql + "	AND	ventascab.anulado = 0 "
lcSql = lcSql + "	AND ventascab.usuBaja IS NULL "
lcSql = lcSql + "	AND DAY(ventascab.fecAlta) = DAY(" + loDT.getDateTime() + ") "
lcSql = lcSql + "	AND MONTH(ventascab.fecAlta) = MONTH(" + loDT.getDateTime() + ") "
lcSql = lcSql + "	AND YEAR(ventascab.fecAlta) = YEAR(" + loDT.getDateTime() + ") "

loResult.ActiveConnection = loConC2.ActiveConnection
loResult.Cursor_Name = "cur_vtas"

IF !loResult.OpenQuery(lcSql) THEN
	MESSAGEBOX(loResult.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

&& Levanto lo de contado
SELECT SUM(totFact) AS totContadoC2 ;
FROM cur_vtas ;
WHERE condpago = 0;
GROUP BY condpago;
ORDER BY condpago ASC INTO CURSOR cur_tempo

SELECT cur_tempo
IF RECCOUNT("cur_tempo") > 0 THEN
	GO TOP
	Thisform.contenido.txtPtoCont.Value = ROUND(cur_tempo.totContadoC2, 2)
ENDIF

USE IN cur_tempo

&& Levanto lo de cuenta corriente
SELECT SUM(totFact) AS totCtaCteC2 ;
FROM cur_vtas ;
WHERE condpago = 1;
GROUP BY condpago;
ORDER BY condpago ASC INTO CURSOR cur_tempo

SELECT cur_tempo
IF RECCOUNT("cur_tempo") > 0 THEN
	GO TOP
	Thisform.contenido.txtPtoCC.Value = ROUND(cur_tempo.totCtaCteC2, 2)
ENDIF

USE IN cur_tempo
loResult.Close_Query()


*****************************************************************************
&& Levanto los datos a la grilla de contado
*****************************************************************************
&& Primero levanto lo de cuenta 1
lcSql = "SELECT  ctacja.codCtaCJ, "
lcSql = lcSql + "		MAX(ctacja.descripcio) AS cuenta, " 
lcSql = lcSql + " 		SUM(CASE WHEN conccj.signo = 1 THEN movcjadetp.importe ELSE movcjadetp.importe * -1 END) AS importe " 
lcSql = lcSql + "FROM movcjadet " 
lcSql = lcSql + " 	INNER JOIN movcjadetp ON movcjadet.idMovCjaD = movcjadetp.idMovCjaD AND movcjadet.idMovCjaC = movcjadetp.idMovCjaC "
lcSql = lcSql + " 	INNER JOIN ctacja ON movcjadetp.idCtaCja = ctacja.idCtaCja " 
lcSql = lcSql + " 	INNER JOIN conccj ON conccj.idConcCJ = movcjadet.idConcCJ " 
lcSql = lcSql + "WHERE movcjadet.usuBaja IS NULL " 
lcSql = lcSql + "	AND movcjadet.idConcCj = 3 "
lcSql = lcSql + " 	AND movcjadet.idMovCjaD in (select idMovCjaD "
lcSql = lcSql + "								from movcjarel "
lcSql = lcSql + "									INNER JOIN ventascab ON movcjarel.idVentasC = ventascab.idVentasC "
lcSql = lcSql + "									INNER JOIN condpagos ON ventascab.idCondPago = condpagos.idCondPago "
lcSql = lcSql + "								where condpagos.cntDias = 0 "
lcSql = lcSql + "									and movcjarel.idMovCjaC = " + ALLTRIM(STR(thisform.idmovcjac1)) + ") "
lcSql = lcSql + "	AND movcjadet.idMovCjaC = " + ALLTRIM(STR(thisform.idmovcjac1)) + " "
lcSql = lcSql + "GROUP BY ctacja.codCtaCJ "

loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_tmp"

IF !loResult.OpenQuery(lcSql) THEN
	MESSAGEBOX(loResult.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_tmp
IF RECCOUNT("cur_tmp") > 0 THEN
	GO TOP
ENDIF

SELECT cur_tmp
DO WHILE !EOF("cur_tmp")
	SELECT cur_contado 
	APPEND BLANK
	REPLACE cuenta WITH cur_tmp.cuenta
	REPLACE importe WITH cur_tmp.importe ADDITIVE

	SELECT cur_tmp
	SKIP
ENDDO

loResult.Close_Query()

&& Luego levanto lo de cuenta 2
lcSql = "SELECT  ctacja.codCtaCJ, "
lcSql = lcSql + "		MAX(ctacja.descripcio) AS cuenta, " 
lcSql = lcSql + " 		SUM(CASE WHEN conccj.signo = 1 THEN movcjadetp.importe ELSE movcjadetp.importe * -1 END) AS importe " 
lcSql = lcSql + "FROM movcjadet " 
lcSql = lcSql + " 	INNER JOIN movcjadetp ON movcjadet.idMovCjaD = movcjadetp.idMovCjaD AND movcjadet.idMovCjaC = movcjadetp.idMovCjaC "
lcSql = lcSql + " 	INNER JOIN ctacja ON movcjadetp.idCtaCja = ctacja.idCtaCja " 
lcSql = lcSql + " 	INNER JOIN conccj ON conccj.idConcCJ = movcjadet.idConcCJ " 
lcSql = lcSql + "WHERE movcjadet.usuBaja IS NULL " 
lcSql = lcSql + "	AND movcjadet.idConcCj = 3 "
lcSql = lcSql + " 	AND movcjadet.idMovCjaD in (select idMovCjaD "
lcSql = lcSql + "								from movcjarel "
lcSql = lcSql + "									INNER JOIN ventascab ON movcjarel.idVentasC = ventascab.idVentasC "
lcSql = lcSql + "									INNER JOIN condpagos ON ventascab.idCondPago = condpagos.idCondPago "
lcSql = lcSql + "								where condpagos.cntDias = 0 "
lcSql = lcSql + "									and movcjarel.idMovCjaC = " + ALLTRIM(STR(thisform.idmovcjac2)) + ") "
lcSql = lcSql + "	AND movcjadet.idMovCjaC = " + ALLTRIM(STR(thisform.idmovcjac2)) + " "
lcSql = lcSql + "GROUP BY ctacja.codCtaCJ "

loResult.ActiveConnection = loConC2.ActiveConnection
loResult.Cursor_Name = "cur_tmp"

IF !loResult.OpenQuery(lcSql) THEN
	MESSAGEBOX(loResult.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_tmp
IF RECCOUNT("cur_tmp") > 0 THEN
	GO TOP
ENDIF

SELECT cur_tmp
DO WHILE !EOF("cur_tmp")
	SELECT cur_contado 
	APPEND BLANK
	REPLACE cuenta WITH cur_tmp.cuenta
	REPLACE importe WITH cur_tmp.importe ADDITIVE

	SELECT cur_tmp
	SKIP
ENDDO

loResult.Close_Query()

&& Ahora tomo el cursor cur_contado y agrupo por cuenta para sumar los importes
SELECT cuenta, SUM(importe) AS importe;
FROM cur_contado ; 
GROUP BY cuenta ;
INTO CURSOR cur_totcont ;

&& Vacio el cursor cur_contado para poder insertar los valores definitivos
SELECT cur_contado
ZAP 

SELECT cur_totcont
IF RECCOUNT("cur_totcont") > 0 THEN
	GO TOP
ENDIF

SELECT cur_totcont
DO WHILE !EOF("cur_totcont")
	SELECT cur_contado 
	APPEND BLANK
	REPLACE cuenta WITH cur_totcont.cuenta
	REPLACE importe WITH cur_totcont.importe ADDITIVE

	SELECT cur_totcont
	SKIP
ENDDO

USE IN cur_totcont

SELECT cur_contado
IF RECCOUNT("cur_contado") > 0 THEN
	GO TOP
ENDIF
*****************************************************************************
&& Levanto los datos a la grilla de ctacte
*****************************************************************************
&& Primero levanto lo de cuenta 1
lcSql = "SELECT  ctacja.codCtaCJ, "
lcSql = lcSql + "		MAX(ctacja.descripcio) AS cuenta, " 
lcSql = lcSql + " 		SUM(CASE WHEN conccj.signo = 1 THEN movcjadetp.importe ELSE movcjadetp.importe * -1 END) AS importe " 
lcSql = lcSql + "FROM movcjadet " 
lcSql = lcSql + " 	INNER JOIN movcjadetp ON movcjadet.idMovCjaD = movcjadetp.idMovCjaD AND movcjadet.idMovCjaC = movcjadetp.idMovCjaC "
lcSql = lcSql + " 	INNER JOIN ctacja ON movcjadetp.idCtaCja = ctacja.idCtaCja " 
lcSql = lcSql + " 	INNER JOIN conccj ON conccj.idConcCJ = movcjadet.idConcCJ " 
lcSql = lcSql + "WHERE movcjadet.usuBaja IS NULL " 
lcSql = lcSql + "	AND movcjadet.idConcCj = 3 "
lcSql = lcSql + " 	AND movcjadet.idMovCjaD in (select idMovCjaD "
lcSql = lcSql + "								from movcjarel "
lcSql = lcSql + "									INNER JOIN ventascab ON movcjarel.idVentasC = ventascab.idVentasC "
lcSql = lcSql + "									INNER JOIN condpagos ON ventascab.idCondPago = condpagos.idCondPago "
lcSql = lcSql + "								where condpagos.cntDias <> 0 "
lcSql = lcSql + "									and movcjarel.idMovCjaC = " + ALLTRIM(STR(thisform.idmovcjac1)) + ") "
lcSql = lcSql + "	AND movcjadet.idMovCjaC = " + ALLTRIM(STR(thisform.idmovcjac1)) + " "
lcSql = lcSql + "GROUP BY ctacja.codCtaCJ "

loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_tmp"

IF !loResult.OpenQuery(lcSql) THEN
	MESSAGEBOX(loResult.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_tmp
IF RECCOUNT("cur_tmp") > 0 THEN
	GO TOP
ENDIF

SELECT cur_tmp
DO WHILE !EOF("cur_tmp")
	SELECT cur_cc
	APPEND BLANK
	REPLACE cuenta WITH cur_tmp.cuenta
	REPLACE importe WITH cur_tmp.importe ADDITIVE

	SELECT cur_tmp
	SKIP
ENDDO

loResult.Close_Query()

&& Luego levanto lo de cuenta 2
lcSql = "SELECT  ctacja.codCtaCJ, "
lcSql = lcSql + "		MAX(ctacja.descripcio) AS cuenta, " 
lcSql = lcSql + " 		SUM(CASE WHEN conccj.signo = 1 THEN movcjadetp.importe ELSE movcjadetp.importe * -1 END) AS importe " 
lcSql = lcSql + "FROM movcjadet " 
lcSql = lcSql + " 	INNER JOIN movcjadetp ON movcjadet.idMovCjaD = movcjadetp.idMovCjaD AND movcjadet.idMovCjaC = movcjadetp.idMovCjaC "
lcSql = lcSql + " 	INNER JOIN ctacja ON movcjadetp.idCtaCja = ctacja.idCtaCja " 
lcSql = lcSql + " 	INNER JOIN conccj ON conccj.idConcCJ = movcjadet.idConcCJ " 
lcSql = lcSql + "WHERE movcjadet.usuBaja IS NULL " 
lcSql = lcSql + "	AND movcjadet.idConcCj = 3 "
lcSql = lcSql + " 	AND movcjadet.idMovCjaD in (select idMovCjaD "
lcSql = lcSql + "								from movcjarel "
lcSql = lcSql + "									INNER JOIN ventascab ON movcjarel.idVentasC = ventascab.idVentasC "
lcSql = lcSql + "									INNER JOIN condpagos ON ventascab.idCondPago = condpagos.idCondPago "
lcSql = lcSql + "								where condpagos.cntDias <> 0 "
lcSql = lcSql + "									and movcjarel.idMovCjaC = " + ALLTRIM(STR(thisform.idmovcjac2)) + ") "
lcSql = lcSql + "	AND movcjadet.idMovCjaC = " + ALLTRIM(STR(thisform.idmovcjac2)) + " "
lcSql = lcSql + "GROUP BY ctacja.codCtaCJ "

loResult.ActiveConnection = loConC2.ActiveConnection
loResult.Cursor_Name = "cur_tmp"

IF !loResult.OpenQuery(lcSql) THEN
	MESSAGEBOX(loResult.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_tmp
IF RECCOUNT("cur_tmp") > 0 THEN
	GO TOP
ENDIF

SELECT cur_tmp
DO WHILE !EOF("cur_tmp")
	SELECT cur_cc
	APPEND BLANK
	REPLACE cuenta WITH cur_tmp.cuenta
	REPLACE importe WITH cur_tmp.importe ADDITIVE

	SELECT cur_tmp
	SKIP
ENDDO

loResult.Close_Query()

&& Ahora tomo el cursor cur_cc y agrupo por cuenta para sumar los importes
SELECT cuenta, SUM(importe) AS importe;
FROM cur_cc; 
GROUP BY cuenta ;
INTO CURSOR cur_totcc ;

&& Vacio el cursor cur_cc para poder insertar los valores definitivos
SELECT cur_cc
ZAP 

SELECT cur_totcc 
IF RECCOUNT("cur_totcc") > 0 THEN
	GO TOP
ENDIF

SELECT cur_totcc 
DO WHILE !EOF("cur_totcc")
	SELECT cur_cc 
	APPEND BLANK
	REPLACE cuenta WITH cur_totcc.cuenta
	REPLACE importe WITH cur_totcc.importe ADDITIVE

	SELECT cur_totcc
	SKIP
ENDDO

USE IN cur_totcc

SELECT cur_cc 
IF RECCOUNT("cur_cc") > 0 THEN
	GO TOP
ENDIF

*****************************************************************************
&& Levanto los datos a la grilla de Otros Conceptos
*****************************************************************************
&& Primero levanto lo de cuenta 1
lcSql = "SELECT  ctacja.codCtaCJ, "
lcSql = lcSql + "		MAX(ctacja.descripcio) AS cuenta, " 
lcSql = lcSql + " 		SUM(CASE WHEN conccj.signo = 1 THEN movcjadetp.importe ELSE movcjadetp.importe * -1 END) AS importe " 
lcSql = lcSql + "FROM movcjadet " 
lcSql = lcSql + " 	INNER JOIN movcjadetp ON movcjadet.idMovCjaD = movcjadetp.idMovCjaD AND movcjadet.idMovCjaC = movcjadetp.idMovCjaC "
lcSql = lcSql + " 	INNER JOIN ctacja ON movcjadetp.idCtaCja = ctacja.idCtaCja " 
lcSql = lcSql + " 	INNER JOIN conccj ON conccj.idConcCJ = movcjadet.idConcCJ " 
lcSql = lcSql + "WHERE movcjadet.usuBaja IS NULL " 
lcSql = lcSql + " 	AND movcjadet.idMovCjaD not in (select idMovCjaD "
lcSql = lcSql + " 									from movcjarel "
lcSql = lcSql + "									where movcjarel.idMovCjaC = " + ALLTRIM(STR(thisform.idmovcjac1)) + ") "
lcSql = lcSql + "	AND movcjadet.idMovCjaC = " + ALLTRIM(STR(thisform.idmovcjac1)) + " "
lcSql = lcSql + "GROUP BY ctacja.codCtaCJ "

loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_tmp"

IF !loResult.OpenQuery(lcSql) THEN
	MESSAGEBOX(loResult.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_tmp
IF RECCOUNT("cur_tmp") > 0 THEN
	GO TOP
ENDIF

SELECT cur_tmp
DO WHILE !EOF("cur_tmp")
	SELECT cur_otros
	APPEND BLANK
	REPLACE cuenta WITH cur_tmp.cuenta
	REPLACE importe WITH cur_tmp.importe ADDITIVE

	SELECT cur_tmp
	SKIP
ENDDO

loResult.Close_Query()

&& Luego levanto lo de cuenta 2
lcSql = "SELECT  ctacja.codCtaCJ, "
lcSql = lcSql + "		MAX(ctacja.descripcio) AS cuenta, " 
lcSql = lcSql + " 		SUM(CASE WHEN conccj.signo = 1 THEN movcjadetp.importe ELSE movcjadetp.importe * -1 END) AS importe " 
lcSql = lcSql + "FROM movcjadet " 
lcSql = lcSql + " 	INNER JOIN movcjadetp ON movcjadet.idMovCjaD = movcjadetp.idMovCjaD AND movcjadet.idMovCjaC = movcjadetp.idMovCjaC "
lcSql = lcSql + " 	INNER JOIN ctacja ON movcjadetp.idCtaCja = ctacja.idCtaCja " 
lcSql = lcSql + " 	INNER JOIN conccj ON conccj.idConcCJ = movcjadet.idConcCJ " 
lcSql = lcSql + "WHERE movcjadet.usuBaja IS NULL " 
lcSql = lcSql + " 	AND movcjadet.idMovCjaD not in (select idMovCjaD "
lcSql = lcSql + " 									from movcjarel "
lcSql = lcSql + "									where movcjarel.idMovCjaC = " + ALLTRIM(STR(thisform.idmovcjac2)) + ") "
lcSql = lcSql + "	AND movcjadet.idMovCjaC = " + ALLTRIM(STR(thisform.idmovcjac2)) + " "
lcSql = lcSql + "GROUP BY ctacja.codCtaCJ "

loResult.ActiveConnection = loConC2.ActiveConnection
loResult.Cursor_Name = "cur_tmp"

IF !loResult.OpenQuery(lcSql) THEN
	MESSAGEBOX(loResult.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_tmp
IF RECCOUNT("cur_tmp") > 0 THEN
	GO TOP
ENDIF

SELECT cur_tmp
DO WHILE !EOF("cur_tmp")
	SELECT cur_otros
	APPEND BLANK
	REPLACE cuenta WITH cur_tmp.cuenta
	REPLACE importe WITH cur_tmp.importe ADDITIVE

	SELECT cur_tmp
	SKIP
ENDDO

loResult.Close_Query()

&& Ahora tomo el cursor cur_otros y agrupo por cuenta para sumar los importes
SELECT cuenta, SUM(importe) AS importe;
FROM cur_otros; 
GROUP BY cuenta ;
INTO CURSOR cur_tototros ;

&& Vacio el cursor cur_otros para poder insertar los valores definitivos
SELECT cur_otros
ZAP 

SELECT cur_tototros
IF RECCOUNT("cur_tototros") > 0 THEN
	GO TOP
ENDIF

SELECT cur_tototros
DO WHILE !EOF("cur_tototros")
	SELECT cur_otros
	APPEND BLANK
	REPLACE cuenta WITH cur_tototros.cuenta
	REPLACE importe WITH cur_tototros.importe ADDITIVE

	SELECT cur_tototros
	SKIP
ENDDO

USE IN cur_tototros

SELECT cur_otros
IF RECCOUNT("cur_otros") > 0 THEN
	GO TOP
ENDIF

*****************************************************************************
&& Calculo los totales de contado
*****************************************************************************
SELECT cur_contado
DO WHILE !EOF("cur_contado")
	lnTotPagoCon = lnTotPagoCon + cur_contado.importe

	SELECT cur_contado 
	SKIP 
ENDDO 

Thisform.contenido.txtTotFactCont.Value = Thisform.contenido.txtFactCont.Value + Thisform.contenido.txtPtoCont.Value
Thisform.contenido.txtTotPagoCont.Value = lnTotPagoCon

*****************************************************************************
&& Calculo los totales de ctacte
*****************************************************************************
SELECT cur_cc
DO WHILE !EOF("cur_cc")
	lnTotPagoCC = lnTotPagoCC + cur_cc.importe
	
	SELECT cur_cc
	SKIP 
ENDDO 

Thisform.contenido.txtTotFactCC.Value = Thisform.contenido.txtFactCC.Value + Thisform.contenido.txtPtoCC.Value
Thisform.contenido.txtTotPagoCC.Value = lnTotPagoCC 

*****************************************************************************
&& Calculo los totales de otros
*****************************************************************************
SELECT cur_otros
DO WHILE !EOF("cur_otros")
	lnTotOtros = lnTotOtros + cur_otros.importe
	
	SELECT cur_otros
	SKIP 
ENDDO 

Thisform.contenido.txtTotOtros.Value = lnTotOtros

*****************************************************************************
&& Lleno la grilla de totales 
*****************************************************************************
SELECT cur_contado
IF RECCOUNT("cur_contado") > 0 THEN
	GO TOP
ENDIF

SELECT cur_contado
DO WHILE !EOF("cur_contado")
	SELECT cur_totales
	APPEND BLANK
	REPLACE cuenta WITH cur_contado.cuenta
	REPLACE importe WITH cur_contado.importe ADDITIVE

	SELECT cur_contado
	SKIP
ENDDO

SELECT cur_cc
IF RECCOUNT("cur_cc") > 0 THEN
	GO TOP
ENDIF

SELECT cur_cc
DO WHILE !EOF("cur_cc")
	SELECT cur_totales
	APPEND BLANK
	REPLACE cuenta WITH cur_cc.cuenta
	REPLACE importe WITH cur_cc.importe ADDITIVE

	SELECT cur_cc
	SKIP
ENDDO

SELECT cur_otros
IF RECCOUNT("cur_otros") > 0 THEN
	GO TOP
ENDIF

SELECT cur_otros
DO WHILE !EOF("cur_otros")
	SELECT cur_totales
	APPEND BLANK
	REPLACE cuenta WITH cur_otros.cuenta
	REPLACE importe WITH cur_otros.importe ADDITIVE

	SELECT cur_otros
	SKIP
ENDDO


&& Ahora tomo el cursor cur_totales y agrupo por cuenta para sumar los importes
SELECT cuenta, SUM(importe) AS importe;
FROM cur_totales; 
GROUP BY cuenta ;
INTO CURSOR cur_tot ;

&& Vacio el cursor cur_totales para poder insertar los valores definitivos
SELECT cur_totales
ZAP 

SELECT cur_tot
IF RECCOUNT("cur_tot") > 0 THEN
	GO TOP
ENDIF

SELECT cur_tot
DO WHILE !EOF("cur_tot")
	SELECT cur_totales
	APPEND BLANK
	REPLACE cuenta WITH cur_tot.cuenta
	REPLACE importe WITH cur_tot.importe ADDITIVE

	SELECT cur_tot
	SKIP
ENDDO

USE IN cur_tot

SELECT cur_totales
IF RECCOUNT("cur_totales") > 0 THEN
	GO TOP
ENDIF


*****************************************************************************
&& Calculo los totales
*****************************************************************************

lnTotPago = lnTotPagoCon + lnTotPagoCC + lnTotOtros

Thisform.contenido.txtTotVentas.Value = Thisform.contenido.txtTotFactCont.Value + Thisform.contenido.txtTotFactCC.Value
Thisform.contenido.txtTotPagos.Value = lnTotPago


SELECT cur_contado 
IF RECCOUNT("cur_contado") > 0 THEN
	GO TOP
ENDIF

SELECT cur_cc 
IF RECCOUNT("cur_cc") > 0 THEN
	GO TOP
ENDIF

SELECT cur_otros
IF RECCOUNT("cur_otros") > 0 THEN
	GO TOP
ENDIF

SELECT cur_totales
IF RECCOUNT("cur_totales") > 0 THEN
	GO TOP
ENDIF

&& Cierro la conexion con la base de cuenta 1
loConC2.close()
ENDPROC
PROCEDURE verificar_cajaabierta
LOCAL lcSql, loResult, lnCount
LOCAL loConC2

lcSql = ""
loResult = CREATEOBJECT("odbc_result")
lnCount = 0
loConC2 = CREATEOBJECT("odbc_connect")


&& Abro la conexion con la base de cuenta 1
loConC2.ConnectionString = ALLTRIM(getConfig("DMO_CC"))
IF !loConC2.Open() THEN
	MESSAGEBOX(loConC2.ErrorMessage, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

*************************************************************************
&& Verifico si se abrió la caja de Cuenta 1
*************************************************************************
lcSql = "SELECT COUNT(*) AS Cantidad FROM movcjacab WHERE estado = 'A'"
loResult.Cursor_Name = "cur_tmp"
loResult.ActiveConnection = goConn.ActiveConnection
loResult.OpenQuery(lcSql)

IF TYPE("cur_tmp.Cantidad") == "C" THEN
	lnCount = INT(VAL(cur_tmp.Cantidad)) 
ELSE
	lnCount = cur_tmp.Cantidad
ENDIF

loResult.Close_Query()

IF lnCount = 0 THEN
	&&MESSAGEBOX("La caja se encuentra cerrada, no se puede realizar el control", 0+48, Thisform.Caption)
	&&RETURN .F.
	thisform.idmovcjac1 = 0
ELSE 
	lcSql = "SELECT idMovCjaC FROM movcjacab WHERE estado = 'A'"
	loResult.Cursor_Name = "cur_cab"
	loResult.ActiveConnection = goConn.ActiveConnection
	loResult.OpenQuery(lcSql)
	
	thisform.idmovcjac1 = cur_Cab.idMovCjaC
	
	loResult.Close_Query()
ENDIF

*************************************************************************
&& Verifico si se abrió la caja de Cuenta 2
*************************************************************************
lcSql = "SELECT COUNT(*) AS Cantidad FROM movcjacab WHERE estado = 'A'"
loResult.Cursor_Name = "cur_tmp"
loResult.ActiveConnection = loConC2.ActiveConnection
loResult.OpenQuery(lcSql)

IF TYPE("cur_tmp.Cantidad") == "C" THEN
	lnCount = INT(VAL(cur_tmp.Cantidad)) 
ELSE
	lnCount = cur_tmp.Cantidad
ENDIF

loResult.Close_Query()

IF lnCount = 0 THEN
	&&MESSAGEBOX("La caja 2 se encuentra cerrada, no se puede realizar el control", 0+48, Thisform.Caption)
	&&RETURN .F.
	thisform.idmovcjac2 = 0
ELSE 
	lcSql = "SELECT idMovCjaC FROM movcjacab WHERE estado = 'A'"
	loResult.Cursor_Name = "cur_cab"
	loResult.ActiveConnection = loConC2.ActiveConnection
	loResult.OpenQuery(lcSql)
	
	thisform.idmovcjac2 = cur_Cab.idMovCjaC
	
	loResult.Close_Query()
ENDIF

loConC2.close()	

IF thisform.idmovcjac1 = 0 .AND. thisform.idmovcjac2 = 0 THEN 
	MESSAGEBOX("La caja se encuentra cerrada, no se puede realizar el control", 0+48, Thisform.Caption)
	RETURN .F.
ENDIF 

RETURN .T.
ENDPROC
PROCEDURE Init
Thisform.verificar_cajaabierta()

&& Grilla donde se muestran las cajas diarias
SELECT cur_contado
Thisform.Contenido.grdContado.RecordSource = "cur_contado"
Thisform.Contenido.grdContado.list_controlsource = "cuenta,importe"
Thisform.Contenido.grdContado.lista_ancho_cols = "200,70"
Thisform.Contenido.grdContado.titulos_cabeceras = "Cuenta,Importe"
Thisform.Contenido.grdContado.generar_grid()

&& Grilla donde se muestran los resumenes de caja
SELECT cur_cc
Thisform.Contenido.grdCC.RecordSource = "cur_cc"
Thisform.Contenido.grdCC.list_controlsource = "cuenta,importe"
Thisform.Contenido.grdCC.lista_ancho_cols = "200,70"
Thisform.Contenido.grdCC.titulos_cabeceras = "Cuenta,Importe"
Thisform.Contenido.grdCC.generar_grid()

&& Grilla donde se muestran los resumenes de otros conceptos
SELECT cur_otros
Thisform.Contenido.grdOtros.RecordSource = "cur_otros"
Thisform.Contenido.grdOtros.list_controlsource = "cuenta,importe"
Thisform.Contenido.grdOtros.lista_ancho_cols = "200,70"
Thisform.Contenido.grdOtros.titulos_cabeceras = "Cuenta,Importe"
Thisform.Contenido.grdOtros.generar_grid()


&& grilla donde se muestran las facturas diarias
SELECT cur_totales
thisform.contenido.grdTotales.RecordSource = "cur_totales"
thisform.contenido.grdTotales.list_controlsource = "cuenta,importe"
thisform.contenido.grdTotales.lista_ancho_cols = "200,70"
thisform.contenido.grdTotales.titulos_cabeceras = "Cuenta,Importe"
thisform.contenido.grdTotales.generar_grid()

thisform.levantar_datos()

ENDPROC
PROCEDURE Load
DODEFAULT()

CREATE CURSOR cur_contado(	;
	cuenta		varchar(60),;
	importe		float(10, 2))

CREATE CURSOR cur_cc(	;
	cuenta		varchar(60),;
	importe		float(10, 2))

CREATE CURSOR cur_otros(	;
	cuenta		varchar(60),;
	importe		float(10, 2))

CREATE CURSOR cur_totales(	;
	cuenta		varchar(60),;
	importe		float(10, 2))

ENDPROC


************************************************************
OBJETO: contenido
************************************************************
*** PROPIEDADES ***
Top = 0
Left = 0
Width = 830
Height = 590
BackColor = 241,236,235
Name = "contenido"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Apertura de Caja:"
Height = 15
Left = 9
Top = 11
Width = 108
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: txtApertura
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Left = 112
Top = 8
Visible = .T.
isnumeric = .T.
Name = "txtApertura"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Facturación:"
Height = 15
Left = 10
Top = 73
Width = 72
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: txtFactCont
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Left = 84
Top = 70
Visible = .T.
isnumeric = .T.
Name = "txtFactCont"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Pto:"
Height = 15
Left = 207
Top = 73
Width = 32
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: txtPtoCont
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Left = 236
Top = 70
Visible = .T.
isnumeric = .T.
Name = "txtPtoCont"

*** METODOS ***


************************************************************
OBJETO: grdContado
************************************************************
*** PROPIEDADES ***
Height = 170
Left = 7
TabIndex = 1
Top = 95
Width = 400
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdContado"
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
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Detalle Contado"
Height = 15
Left = 9
Top = 42
Width = 97
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: grdCC
************************************************************
*** PROPIEDADES ***
Height = 170
Left = 420
TabIndex = 1
Top = 95
Width = 400
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdCC"
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
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Detalle Cuenta Corriente"
Height = 15
Left = 425
Top = 42
Width = 187
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta6
************************************************************
*** PROPIEDADES ***
Caption = "Total Facturación:"
Height = 15
Left = 7
Top = 272
Width = 103
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: txtTotFactCont
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Left = 110
Top = 269
Visible = .T.
isnumeric = .T.
Name = "txtTotFactCont"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta7
************************************************************
*** PROPIEDADES ***
Caption = "Total Pagos:"
Height = 15
Left = 216
Top = 272
Width = 103
Name = "Clsetiqueta7"

*** METODOS ***


************************************************************
OBJETO: txtTotPagoCont
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Left = 289
Top = 269
Visible = .T.
isnumeric = .T.
Name = "txtTotPagoCont"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta8
************************************************************
*** PROPIEDADES ***
Caption = "Total Facturación:"
Height = 15
Left = 421
Top = 272
Width = 103
Name = "Clsetiqueta8"

*** METODOS ***


************************************************************
OBJETO: txtTotFactCC
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Left = 524
Top = 269
Visible = .T.
isnumeric = .T.
Name = "txtTotFactCC"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta9
************************************************************
*** PROPIEDADES ***
Caption = "Total Pagos:"
Height = 15
Left = 633
Top = 272
Width = 103
Name = "Clsetiqueta9"

*** METODOS ***


************************************************************
OBJETO: txtTotPagoCC
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Left = 702
Top = 269
Visible = .T.
isnumeric = .T.
Name = "txtTotPagoCC"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta10
************************************************************
*** PROPIEDADES ***
Caption = "Facturación:"
Height = 15
Left = 426
Top = 73
Width = 72
Name = "Clsetiqueta10"

*** METODOS ***


************************************************************
OBJETO: txtFactCC
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Left = 500
Top = 70
Visible = .T.
isnumeric = .T.
Name = "txtFactCC"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta11
************************************************************
*** PROPIEDADES ***
Caption = "Pto:"
Height = 15
Left = 621
Top = 73
Width = 32
Name = "Clsetiqueta11"

*** METODOS ***


************************************************************
OBJETO: txtPtoCC
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Left = 649
Top = 70
Visible = .T.
isnumeric = .T.
Name = "txtPtoCC"

*** METODOS ***


************************************************************
OBJETO: Clslinea1
************************************************************
*** PROPIEDADES ***
Height = 1
Left = 7
Top = 60
Width = 400
Name = "Clslinea1"

*** METODOS ***


************************************************************
OBJETO: Clslinea2
************************************************************
*** PROPIEDADES ***
Height = 1
Left = 423
Top = 60
Width = 400
Name = "Clslinea2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta12
************************************************************
*** PROPIEDADES ***
Caption = "Totales (Contado + Cuenta Corriente)"
Height = 15
Left = 422
Top = 302
Width = 219
Name = "Clsetiqueta12"

*** METODOS ***


************************************************************
OBJETO: grdTotales
************************************************************
*** PROPIEDADES ***
Height = 170
Left = 420
TabIndex = 1
Top = 327
Width = 400
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdTotales"
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
OBJETO: Clsetiqueta13
************************************************************
*** PROPIEDADES ***
Caption = "Total Facturación:"
Height = 15
Left = 422
Top = 503
Width = 103
Name = "Clsetiqueta13"

*** METODOS ***


************************************************************
OBJETO: txtTotVentas
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Left = 525
Top = 500
Visible = .T.
isnumeric = .T.
Name = "txtTotVentas"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta14
************************************************************
*** PROPIEDADES ***
Caption = "Total Pagos:"
Height = 15
Left = 635
Top = 504
Width = 103
Name = "Clsetiqueta14"

*** METODOS ***


************************************************************
OBJETO: txtTotPagos
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Left = 706
Top = 501
Visible = .T.
isnumeric = .T.
Name = "txtTotPagos"

*** METODOS ***


************************************************************
OBJETO: Clscerrar1
************************************************************
*** PROPIEDADES ***
Top = 542
Left = 776
TabIndex = 3
Name = "Clscerrar1"

*** METODOS ***


************************************************************
OBJETO: Clsimprimir1
************************************************************
*** PROPIEDADES ***
Top = 542
Left = 682
TabIndex = 1
Visible = .F.
Name = "Clsimprimir1"

*** METODOS ***


************************************************************
OBJETO: Clsrefresh1
************************************************************
*** PROPIEDADES ***
Top = 542
Left = 729
TabIndex = 2
Name = "Clsrefresh1"

*** METODOS ***
PROCEDURE Click

SELECT cur_contado
ZAP 

SELECT cur_cc
ZAP 

SELECT cur_otros
ZAP 

SELECT cur_totales
ZAP
 
Thisform.contenido.grdCC.Refresh()
Thisform.contenido.grdContado.Refresh()
Thisform.contenido.grdOtros.Refresh()
Thisform.contenido.grdTotales.Refresh()

Thisform.verificar_cajaabierta()
Thisform.levantar_datos()

Thisform.contenido.grdCC.Refresh()
Thisform.contenido.grdContado.Refresh()
Thisform.contenido.grdOtros.Refresh()
Thisform.contenido.grdTotales.Refresh()
ENDPROC


************************************************************
OBJETO: Clslinea3
************************************************************
*** PROPIEDADES ***
Height = 1
Left = 422
Top = 320
Width = 400
Name = "Clslinea3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta15
************************************************************
*** PROPIEDADES ***
Caption = "Otros"
Height = 15
Left = 9
Top = 302
Width = 51
Name = "Clsetiqueta15"

*** METODOS ***


************************************************************
OBJETO: grdOtros
************************************************************
*** PROPIEDADES ***
Height = 170
Left = 7
TabIndex = 1
Top = 327
Width = 400
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdOtros"
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
OBJETO: Clsetiqueta16
************************************************************
*** PROPIEDADES ***
Caption = "Total Otros:"
Height = 15
Left = 9
Top = 503
Width = 103
Name = "Clsetiqueta16"

*** METODOS ***


************************************************************
OBJETO: txtTotOtros
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Left = 88
Top = 500
Visible = .T.
isnumeric = .T.
Name = "txtTotOtros"

*** METODOS ***


************************************************************
OBJETO: Clslinea4
************************************************************
*** PROPIEDADES ***
Height = 1
Left = 9
Top = 320
Width = 400
Name = "Clslinea4"

*** METODOS ***


************************************************************
OBJETO: cl_control_caja
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: cl_caja
************************************************************
*** PROPIEDADES ***
Height = 600
Width = 889
DoCreate = .T.
Caption = "Caja"
WindowType = 0
idcliente = 0
Name = "cl_caja"

*** METODOS ***
PROCEDURE limpiar

&& Page 1
Thisform.Pgf.Page1.sel_Cliente.blanquear()
Thisform.Pgf.Page1.txtPtoVta.Value = ""
Thisform.Pgf.Page1.txtNroRec.Value = ""

&& Page 2
&& Efectivo/Tarjetas
Thisform.Pgf.Page2.contenedor_efvo.txtImpEfvo.Value = 0.00
thisform.pgf.page2.contenedor_efvo.txtImpTC.Value = 0.00
Thisform.pgf.page2.contenedor_efvo.txtImpTD.Value = 0.00

&& Cheques/Depositos
Thisform.pgf.page2.contenedor_cheques.opgTipoPago.option1.Value = 1
Thisform.pgf.page2.contenedor_cheques.opgTipoPago.option2.Value = 0
Thisform.pgf.page2.contenedor_cheques.sel_Banco.blanquear()
Thisform.pgf.page2.contenedor_cheques.txtsucursal.Value = ""
Thisform.pgf.page2.contenedor_cheques.txtnroCheque.Value = ""
Thisform.pgf.page2.contenedor_cheques.txtFecEmis.Value = {}
Thisform.pgf.page2.contenedor_cheques.txtFecVto.Value = {}
Thisform.pgf.page2.contenedor_cheques.cmbTipoDoc.ListIndex = 1
Thisform.pgf.page2.contenedor_cheques.txtnroCUIT.Value = 0
Thisform.pgf.page2.contenedor_cheques.txtTitular.Value = ""
Thisform.pgf.page2.contenedor_cheques.txtimporte.Value = 0.00
Thisform.pgf.page2.contenedor_cheques.txttotalRec.Value = 0.00

&& Retenciones
Thisform.pgf.page2.contenedor_ret.txtRetGan.Value = 0.00
Thisform.pgf.page2.contenedor_ret.txtRetIIBB.Value = 0.00
Thisform.pgf.page2.contenedor_ret.txtRetIVA.Value = 0.00
Thisform.pgf.page2.contenedor_ret.txtRetSUSS.Value = 0.00
Thisform.pgf.page2.contenedor_ret.txtFecGAN.Value = {}
Thisform.pgf.page2.contenedor_ret.txtFecIIBB.Value = {}
Thisform.pgf.page2.contenedor_ret.txtFecIVA.Value = {}
Thisform.pgf.page2.contenedor_ret.txtFecSUSS.Value = {}
Thisform.pgf.page2.contenedor_ret.txtCbteGAN.Value = 0
Thisform.pgf.page2.contenedor_ret.txtCbteIIBB.Value = 0
Thisform.pgf.page2.contenedor_ret.txtCbteIVA.Value = 0
Thisform.pgf.page2.contenedor_ret.txtCbteSUSS.Value = 0
Thisform.pgf.page2.contenedor_Ret.sel_provincia.blanquear()

&& Totales
Thisform.txtImpCbtes.Value = 0.00
Thisform.txtImpImputar.Value = 0.00
Thisform.txtPagoCon.Value = 0.00
Thisform.txtCambio.Value = 0.00

Thisform.pgf.page1.txtNroRec.Enabled = .F.
Thisform.pgf.page1.txtPtoVta.Enabled = .F.

&& Limpio los cursores y vuelvo a levantar los datos.

Thisform.Recibos.limpiar() && Limpia los cursores de facturas y detalle
Thisform.leer_cajadiaria && Levanta los datos de la caja diaria
Thisform.leer_cbtes_contados()

Thisform.pgf.page1.optCliente.option1.Value = 1
Thisform.pgf.page1.optCliente.option2.Value = 0
Thisform.Pgf.Page1.SetFocus()
thisform.pgf.page1.sel_Cliente.txtCodigo.SetFocus()
ENDPROC
PROCEDURE leer_cbtes_contados
LOCAL loVtas, lcSql, lcPtoVta, lcNumero

loVtas = CREATEOBJECT("odbc_result")
lcSql = ""
lcPtoVta = ""
lcNumero = ""

lcSql = "SELECT	cc.*, SaldoTot, ventascab.razsoc "
lcSql = lcSql + "FROM  cc_cli cc INNER JOIN clientes ON cc.idCliente = clientes.idCliente "
lcSql = lcSql + "	INNER JOIN condpagos ON condpagos.idCondPago = cc.idCondPago "
lcSql = lcSql + " 	left join ( SELECT idoper, MAX(fecemis) AS 'fecfc' "
lcSql = lcSql + " 				FROM cc_cli "
lcSql = lcSql + " 				WHERE cbte IN ('FC') and idoper != 0 "
lcSql = lcSql + " 				GROUP BY idoper) AS operfc ON cc.idoper = operfc.idoper "
lcSql = lcSql + " 	left join ( SELECT idoper, MAX(fecemis) AS 'fecnd' "
lcSql = lcSql + " 				FROM cc_cli "
lcSql = lcSql + " 				WHERE cbte IN ('ND') and idoper != 0 "
lcSql = lcSql + " 				GROUP BY idoper) AS opernd ON cc.idoper = opernd.idoper "
lcSql = lcSql + "	inner join ( SELECT cc2.idoper, ROUND(SUM(cc2.impdebe - cc2.imphaber),2) as SaldoTot "
lcSql = lcSql + " 				FROM cc_cli cc2 "
lcSql = lcSql + " 				WHERE (cc2.usubaja is null or cc2.usubaja = '') "
lcSql = lcSql + "         			and idoper != 0 "
lcSql = lcSql + "         		GROUP BY cc2.idoper) AS Saldos ON cc.idoper = Saldos.idoper "
lcSql = lcSql + "	left JOIN ventascab ON ventascab.idVentasC = cc.idVentasC "
lcSql = lcSql + "WHERE (cc.UsuBaja IS NULL OR cc.UsuBaja = '') "
lcSql = lcSql + "   AND SaldoTot > 0 "
lcSql = lcSql + "   AND (SUBSTRING(cc.CBTE,1,2)='FC' OR (cc.CBTE='ND' AND fecfc IS NULL)) " 
lcSql = lcSql + " 	AND condpagos.cntDias = 0 "
lcSql = lcSql + "	AND CASE WHEN ventascab.ptoVta = 9999 THEN 1 ELSE ventascab.aut_Resultado = 'A' END "
lcSql = lcSql + "ORDER BY fecemis ASC "

loVtas.Cursor_Name = "cur_vta"
loVtas.ActiveConnection = goConn.ActiveConnection
loVtas.OpenQuery(lcSql)

* Limpio el cursor de facturas
SELECT cur_facturas
ZAP

SELECT cur_vta
IF RECCOUNT("cur_vta") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_vta")
	lcPtoVta = REPLICATE("0", 4 - LEN(ALLTRIM(STR(cur_vta.ptoVta)))) + ALLTRIM(STR(cur_vta.ptoVta))
	lcNumero = REPLICATE("0", 8 - LEN(ALLTRIM(STR(cur_vta.nroCbte)))) + ALLTRIM(STR(cur_vta.nroCbte))

	SELECT cur_facturas
	APPEND BLANK
	REPLACE cur_facturas.selected 	WITH .F.
	REPLACE cur_facturas.idCC_Cli	WITH cur_vta.idCC_Cli ADDITIVE
	REPLACE cur_facturas.idVentasC 	WITH IIF(ISNULL(cur_vta.idVentasC), 0, cur_vta.idVentasC) ADDITIVE
	REPLACE cur_facturas.idCliente	WITH cur_vta.idCliente ADDITIVE
	REPLACE cur_facturas.idCondPago WITH cur_vta.idCondPago ADDITIVE
	REPLACE cur_facturas.idSitIVA 	WITH cur_vta.idSitIVA ADDITIVE
	REPLACE cur_facturas.idVendedor WITH cur_vta.idVendedor ADDITIVE
	REPLACE cur_facturas.razSoc		WITH cur_vta.razSoc ADDITIVE
	REPLACE cur_facturas.fecEmis 	WITH cur_vta.fecEmis ADDITIVE
	REPLACE cur_facturas.cbte 		WITH ALLTRIM(cur_vta.cbte) ADDITIVE
	REPLACE cur_facturas.numCbte1 	WITH lcPtoVta + "-" + lcNumero ADDITIVE
	REPLACE cur_facturas.TipoDoc	WITH cur_vta.tipoDoc ADDITIVE
	REPLACE cur_facturas.PtoVta 	WITH cur_vta.ptoVta ADDITIVE
	REPLACE cur_facturas.numCbte	WITH cur_vta.nroCbte ADDITIVE
	REPLACE cur_facturas.importe 	WITH cur_vta.impdebe ADDITIVE	
	REPLACE cur_facturas.saldo 		WITH cur_vta.saldotot ADDITIVE
	REPLACE cur_facturas.idOper 	WITH cur_vta.idOper ADDITIVE

	SELECT cur_vta
	SKIP
ENDDO

loVtas.close_query()

SELECT cur_Facturas
IF RECCOUNT("cur_Facturas") > 0 THEN
	GO TOP
ENDIF

Thisform.pgf.Page1.grdCbtes.Refresh()

ENDPROC
PROCEDURE leer_cajadiaria
&& Levanto los datos de la caja diaria
LOCAL lcSql, loResult, lnDebe, lnHaber, lnSaldo

lcSql = ""
loResult = CREATEOBJECT("odbc_result")
lnDebe = 0.00
lnHaber = 0.00
lnSaldo = 0.00
lcNroCbte = ""


SELECT cur_movCaja
ZAP

*****************************************************************************
&& Levanto los datos a la grilla grdMovCaja
*****************************************************************************
lcSql = "SELECT	movcjadet.idMovCjaD, "
lcSql = lcSql + "movcjadet.idMovCjaC, "
lcSql = lcSql + "movcjadet.fecha, "
lcSql = lcSql + "conccj.descripcio AS concepto, "
lcSql = lcSql + "conccj.signo, "
lcSql = lcSql + "movcjadet.cbte, "
lcSql = lcSql + "movcjadet.tipodoc,  "
lcSql = lcSql + "movcjadet.ptovta, "
lcSql = lcSql + "movcjadet.nrocbte, "
lcSql = lcSql + "movcjadet.importe "
lcSql = lcSql + "FROM	movcjadet, "
lcSql = lcSql + "movcjacab, "
lcSql = lcSql + "conccj "
lcSql = lcSql + "WHERE	movcjadet.idMovCjaC = movcjacab.idMovCjaC "
lcSql = lcSql + "	AND	movcjadet.idConcCJ = conccj.idConcCJ "
lcSql = lcSql + "	AND movcjacab.estado = 'A' "
lcSql = lcSql + "	AND movcjacab.usuBaja IS NULL "
lcSql = lcSql + "	AND movcjadet.usuBaja IS NULL "
lcSql = lcSql + "ORDER BY idMovCjaD ASC "

loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_mov"
loResult.OpenQuery(lcSql)

SELECT cur_mov
IF RECCOUNT("cur_mov") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_mov")
	lcNroCbte = REPLICATE("0", 4 - LEN(ALLTRIM(STR(cur_mov.ptovta)))) + ALLTRIM(STR(cur_mov.ptovta)) + "-" + REPLICATE("0", 8 - LEN(ALLTRIM(STR(cur_mov.nrocbte)))) + ALLTRIM(STR(cur_mov.nrocbte))
	lnDebe = 0.00
	lnHaber = 0.00
	
	IF cur_mov.signo = 1 THEN
		lnDebe = cur_mov.importe
		lnSaldo = lnSaldo + lnDebe
	ELSE
		lnHaber = cur_mov.importe
		lnSaldo = lnSaldo - lnHaber
	ENDIF

	SELECT cur_movCaja
	APPEND BLANK
	
	REPLACE idMovCjaD 	WITH cur_mov.idMovCjaD	
	REPLACE idMovCjaC	WITH cur_mov.idMovCjaC	ADDITIVE
	REPLACE fecha		WITH cur_mov.fecha		ADDITIVE
	REPLACE conCcj		WITH cur_mov.concepto 	ADDITIVE
	REPLACE cbte		WITH cur_mov.cbte 		ADDITIVE
	REPLACE tipodoc	WITH cur_mov.tipodoc	ADDITIVE
	REPLACE nrocbte	WITH ALLTRIM(lcNroCbte)	ADDITIVE
	REPLACE impDebe	WITH lnDebe				ADDITIVE
	REPLACE impHaber	WITH lnHaber			ADDITIVE
	REPLACE saldo		WITH lnSaldo			ADDITIVE

	SELECT cur_mov
	SKIP
ENDDO

loResult.Close_Query()

SELECT cur_movCaja
IF RECCOUNT("cur_movCaja") > 0 THEN
	GO TOP
ENDIF

Thisform.pgf.page3.grdMovCaja.Refresh()
Thisform.leer_detcajadiaria()
ENDPROC
PROCEDURE cargar_tipodoc
&& Cargo el combobox con los tipos de documento

LOCAL lcSql, loResult

lcSql = ""
loResult = CREATEOBJECT("odbc_result")

lcSql = "SELECT * FROM tipodoc"
loResult.ActiveConnection = goConn.ActiveConnection
loResult.cursor_name = "cur_tipodoc"

IF !loResult.OpenQuery(lcSql)
	MESSAGEBOX(loResult.error_message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF 

SELECT cur_tipodoc
IF RECCOUNT("cur_tipodoc") > 0 THEN 
	GO TOP
ELSE 
	RETURN .F.
ENDIF 

DO WHILE !EOF("cur_tipodoc")
	SELECT cur_tipodoc
	Thisform.pgf.page2.contenedor_cheques.cmbTipoDoc.AddItem(ALLTRIM(cur_tipodoc.tipodoc))
	
	SKIP 
ENDDO 

loResult.close_query()

Thisform.pgf.page2.contenedor_cheques.cmbTipoDoc.ListIndex = 1

ENDPROC
PROCEDURE calc_saldoimputar
&& Calculo los importes: a imputar, ingresado y cambio.
LOCAL lnImpCbtes, lnImputado

lnImpCbtes = thisform.txtImpCbtes.Value 
lnImputado = 0


lnImputado = Thisform.Pgf.Page2.contenedor_efvo.txtImpEfvo.value + ;
	Thisform.Pgf.Page2.contenedor_efvo.txtImpTC.Value + ;
	Thisform.Pgf.Page2.contenedor_efvo.txtImpTD.Value + ;
	Thisform.Pgf.Page2.contenedor_cheques.txtTotalRec.Value + ;
	Thisform.Pgf.Page2.contenedor_ret.txtRetGan.Value + ;
	Thisform.Pgf.Page2.contenedor_ret.txtRetIIBB.Value + ;
	Thisform.Pgf.Page2.contenedor_ret.txtRetIVA.Value + ;
	Thisform.Pgf.Page2.contenedor_ret.txtRetSUSS.Value

IF (lnImpCbtes - lnImputado) < 0 THEN
	Thisform.txtCambio.Value = (lnImpCbtes - lnImputado) * -1
ELSE 
	Thisform.txtCambio.Value = 0 
ENDIF

Thisform.txtImpImputar.Value = lnImpCbtes - lnImputado
Thisform.txtPagoCon.Value = lnImputado




ENDPROC
PROCEDURE validar_pago
LOCAL lnCantSel, lnImporte, lnImputado, lnSuma

lnCantSel = 0
lnImporte = 0.00
lnImputado = Thisform.txtPagoCon.Value 
lnSuma = 0

IF thisform.pgf.page1.optCliente.option2.Value = 1 THEN
	&& Valido que se haya ingresado el punto de venta
	IF  ALLTRIM(Thisform.pgf.Page1.txtPtoVta.Value) == "" .OR. ALLTRIM(Thisform.pgf.Page1.txtPtoVta.Value) == "0000" THEN
		MESSAGEBOX("Debe ingresar el punto de venta correspondiente al número de recibo", 0+48, Thisform.Caption)
		Thisform.pgf.Page1.txtPtoVta.SetFocus()
		RETURN .F.
	ENDIF
	&& Valido que se haya ingresado el numero de recibo	
	IF ALLTRIM(Thisform.pgf.Page1.txtNroRec.Value) == "" .OR. ALLTRIM(Thisform.pgf.Page1.txtNroRec.Value) == "00000000" THEN
		MESSAGEBOX("Debe ingresar el número de recibo", 0+48, Thisform.Caption)
		Thisform.pgf.Page1.txtNroRec.SetFocus()
		RETURN .F.
	ENDIF
	
	IF !thisform.recibos.validar_numero(ALLTRIM(Thisform.pgf.Page1.txtPtoVta.Value), ALLTRIM(Thisform.pgf.Page1.txtNroRec.Value)) THEN 
		RETURN .F.
	ENDIF 
ENDIF

&& Valido los comprobantes seleccionados
SELECT cur_facturas
IF RECCOUNT("cur_facturas") > 0 THEN
	GO TOP
ENDIF

SELECT	idCliente ;
FROM	cur_facturas ;
WHERE	selected = .T.;
GROUP BY idCliente INTO CURSOR cur_x

SELECT cur_x

IF RECCOUNT("cur_x") = 0 THEN && Valido que se haya seleccionado al menos un comprobante
	IF Thisform.pgf.page1.optCliente.option1.Value = 1 THEN  
		MESSAGEBOX("Debe seleccionar al menos un comprobante para aplicar el pago", 0+48, Thisform.Caption)
		USE IN cur_x
		RETURN .F.
	ENDIF 
ELSE
	IF RECCOUNT("cur_x") > 1 THEN  && Valido que se haya seleccionado solo un cliente en el caso que sea cheque
		SELECT cur_detalle
		IF RECCOUNT("cur_detalle") > 0 THEN
			GO TOP
		ENDIF

		SELECT	idCheque ;
		FROM	cur_detalle ;
		WHERE	tipoPago = "CHEQ";
		GROUP BY idCheque INTO CURSOR cur_cheques

		SELECT cur_cheques
		IF RECCOUNT("cur_cheques") > 0 THEN
			MESSAGEBOX("Tiene seleccionado comprobantes de diferentes clientes, no se puede aplicar cheques al pago.", 0+48, Thisform.Caption)
			USE IN cur_x
			USE IN cur_cheques
			RETURN .F.
		ENDIF  
		
		USE IN cur_cheques
	ELSE 
		Thisform.idcliente = cur_x.idCliente	&& Si el cliente seleccionado es uno solo guardo el numero.
	ENDIF 
ENDIF

USE IN cur_x


&& Valido que se haya ingresado algun importe en el pago.
IF thisform.txtPagoCon.Value = 0 THEN 
	MESSAGEBOX("No ingreso importes en el pago", 0+48, Thisform.Caption)
	RETURN .F.
ENDIF 


&& Valido que no se hayan seleccionado mas facturas de las que se puede cancelar con el pago.
SELECT COUNT(*) AS cantSel FROM cur_facturas WHERE selected = .T. ;
INTO CURSOR cur_x

SELECT cur_x
lnCantSel = cur_x.cantSel
USE IN cur_x

SELECT cur_facturas 
IF RECCOUNT("cur_facturas") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_facturas")
	IF cur_facturas.selected THEN
		IF (lnCantSel > 1) .AND. lnImputado <= 0 THEN
			MESSAGEBOX("El pago no es válido, se seleccionaron más comprobantes de los que pueden ser imputados. Por favor verifique las facturas seleccionadas.", 0+48, Thisform.Caption)
			RETURN .F.
		ELSE
			lnImputado = lnImputado - cur_facturas.saldo
		ENDIF
	ENDIF

	SELECT cur_facturas
	SKIP
ENDDO

SELECT cur_facturas
IF RECCOUNT("cur_facturas") > 0 THEN
	GO TOP
ENDIF


&& Valido que los cheques ingresados no esten ya cargados en la base
IF !Thisform.recibos.validar_todosloscheques(thisform.idcliente)
	RETURN .F.
ENDIF 	

&& Valido que se ingresen todos los datos de IIBB
IF thisform.pgf.page2.contenedor_Ret.txtRetIIBB.Value <> 0 THEN 
	IF thisform.pgf.page2.contenedor_Ret.txtfecIIBB.Value = {} THEN 
		MESSAGEBOX("Debe ingresar la fecha de retención IIBB", 0+48, Thisform.Caption)
		thisform.pgf.page2.contenedor_Ret.txtfecIIBB.SetFocus()
		RETURN .F.
	ENDIF 
	
	IF thisform.pgf.page2.contenedor_Ret.txtCbteIIBB.Value = 0 THEN 
		MESSAGEBOX("Debe ingresar el Nº de comprobante de retención IIBB", 0+48, Thisform.Caption)
		thisform.pgf.page2.contenedor_Ret.txtCbteIIBB.SetFocus()
		RETURN .F.
	ENDIF 
	
	IF thisform.pgf.page2.contenedor_Ret.sel_provincia.txtCodigo.Value = 0 THEN 
		MESSAGEBOX("Debe ingresar la provincia de retención IIBB", 0+48, Thisform.Caption)
		thisform.pgf.page2.contenedor_Ret.sel_provincia.txtCodigo.SetFocus()
		RETURN .F.
	ENDIF 
ENDIF 

&& Valido que se ingresen todos los datos de IVA
IF thisform.pgf.page2.contenedor_Ret.txtRetIVA.Value <> 0 THEN 
	IF thisform.pgf.page2.contenedor_Ret.txtfecIVA.Value = {} THEN 
		MESSAGEBOX("Debe ingresar la fecha de retención IVA", 0+48, Thisform.Caption)
		thisform.pgf.page2.contenedor_Ret.txtfecIVA.SetFocus()
		RETURN .F.
	ENDIF 
	
	IF thisform.pgf.page2.contenedor_Ret.txtCbteIVA.Value = 0 THEN 
		MESSAGEBOX("Debe ingresar el Nº de comprobante de retención IVA", 0+48, Thisform.Caption)
		thisform.pgf.page2.contenedor_Ret.txtCbteIVA.SetFocus()
		RETURN .F.
	ENDIF 
ENDIF 

&& Valido que se ingresen todos los datos de GANANCIAS
IF thisform.pgf.page2.contenedor_Ret.txtRetGAN.Value <> 0 THEN 
	IF thisform.pgf.page2.contenedor_Ret.txtfecGAN.Value = {} THEN 
		MESSAGEBOX("Debe ingresar la fecha de retención Ganancias", 0+48, Thisform.Caption)
		thisform.pgf.page2.contenedor_Ret.txtfecGAN.SetFocus()
		RETURN .F.
	ENDIF 
	
	IF thisform.pgf.page2.contenedor_Ret.txtCbteGAN.Value = 0 THEN 
		MESSAGEBOX("Debe ingresar el Nº de comprobante de retención Ganancias", 0+48, Thisform.Caption)
		thisform.pgf.page2.contenedor_Ret.txtCbteGAN.SetFocus()
		RETURN .F.
	ENDIF 
ENDIF 

&& Valido que se ingresen todos los datos de SUSS
IF thisform.pgf.page2.contenedor_Ret.txtRetSUSS.Value <> 0 THEN 
	IF thisform.pgf.page2.contenedor_Ret.txtfecSUSS.Value = {} THEN 
		MESSAGEBOX("Debe ingresar la fecha de retención SUSS", 0+48, Thisform.Caption)
		thisform.pgf.page2.contenedor_Ret.txtfecSUSS.SetFocus()
		RETURN .F.
	ENDIF 
	
	IF thisform.pgf.page2.contenedor_Ret.txtCbteSUSS.Value = 0 THEN 
		MESSAGEBOX("Debe ingresar el Nº de comprobante de retención SUSS", 0+48, Thisform.Caption)
		thisform.pgf.page2.contenedor_Ret.txtCbteSUSS.SetFocus()
		RETURN .F.
	ENDIF 
ENDIF 


RETURN .T.
ENDPROC
PROCEDURE verificar_cajaabierta
LOCAL lcSql, loResult, lnCount

&& Verifico si se abrió la caja
lcSql = "SELECT COUNT(*) AS Cantidad FROM movcjacab WHERE estado = 'A'"
loResult = CREATEOBJECT("odbc_result")
lnCount = 0

loResult.Cursor_Name = "cur_tmp"
loResult.ActiveConnection = goConn.ActiveConnection
loResult.OpenQuery(lcSql)

IF TYPE("cur_tmp.Cantidad") == "C" THEN
	lnCount = INT(VAL(cur_tmp.Cantidad)) 
ELSE
	lnCount = cur_tmp.Cantidad
ENDIF

loResult.Close_Query()

IF lnCount = 0 THEN
	MESSAGEBOX("Debe realizar la apertura de caja antes de intentar generar movimientos", 0+48, Thisform.Caption)
	RETURN .F.
ELSE 
	lcSql = "SELECT idMovCjaC FROM movcjacab WHERE estado = 'A'"
	loResult.Cursor_Name = "cur_cab"
	loResult.ActiveConnection = goConn.ActiveConnection
	loResult.OpenQuery(lcSql)
	
	thisform.recibos.idmovcjac = cur_Cab.idMovCjaC
	
	loResult.Close_Query()
ENDIF
ENDPROC
PROCEDURE leer_detcajadiaria
LOCAL lcSql, loResult, lcNroCbte

lcSql = ""
loResult = CREATEOBJECT("odbc_result")
lcNroCbte = ""

SELECT cur_movCajaDet
ZAP
SELECT cur_movCajaCbte
ZAP


*****************************************************************************
&& Levanto los datos a la grilla grdMovCajaDet
*****************************************************************************
lcSql = "SELECT	ctacja.descripcio AS ctacja, "
lcSql = lcSql + "movcjadetp.importe, "
lcSql = lcSql + "bancos.descripcio AS banco, "
lcSql = lcSql + "movcjadetp.chq_nro, "
lcSql = lcSql + "provincias.descripcio AS provincia, "
lcSql = lcSql + "movcjadetp.retCompro, "
lcSql = lcSql + "movcjadetp.retFecha "
lcSql = lcSql + "FROM movcjadetp "
lcSql = lcSql + "	INNER JOIN ctacja ON movcjadetp.idCtaCja = ctacja.idCtaCja "
lcsql = lcSql + " 	LEFT JOIN bancos ON movcjadetp.idBanco = bancos.idBanco "
lcsql = lcSql + " 	LEFT JOIN provincias ON movcjadetp.idProvin = provincias.idProvin "
lcSql = lcSql + "WHERE movcjadetp.idMovCjaC = " + ALLTRIM(STR(cur_movCaja.idMovCjaC)) + " "
lcSql = lcSql + "	AND movcjadetp.idMovCjaD = " + ALLTRIM(STR(cur_movCaja.idMovCjaD)) + " "
lcSql = lcSql + "ORDER BY ctacja ASC "

loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_mov"
loResult.OpenQuery(lcSql)

SELECT cur_mov
IF RECCOUNT("cur_mov") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_mov")
	SELECT cur_movCajaDet
	APPEND BLANK

	REPLACE ctaCja		WITH cur_mov.ctaCja 	ADDITIVE
	REPLACE importe		WITH cur_mov.importe 	ADDITIVE
	REPLACE banco		WITH IIF(ISNULL(cur_mov.banco), "", cur_mov.banco) ADDITIVE
	REPLACE nrocheque	WITH IIF(ISNULL(cur_mov.chq_nro), "", cur_mov.chq_nro) ADDITIVE
	REPLACE provincia	WITH IIF(ISNULL(cur_mov.provincia), "", cur_mov.provincia) ADDITIVE
	REPLACE retcompro	WITH IIF(ISNULL(cur_mov.retCompro), 0, cur_mov.retCompro) ADDITIVE
	REPLACE retfecha	WITH IIF(ISNULL(cur_mov.retFecha), {}, cur_mov.retFecha) ADDITIVE

	SELECT cur_mov
	SKIP
ENDDO

loResult.Close_Query()

SELECT cur_movCajaDet
IF RECCOUNT("cur_movCajaDet") > 0 THEN
	GO TOP
ENDIF

Thisform.pgf.page3.grdMovCajaDet.Refresh()


*****************************************************************************
&& Levanto los datos a la grilla grdMovCajaCbte
*****************************************************************************
lcSql = "SELECT	movcjarel.idMovCjaR, "
lcSql = lcSql + "cc_cli.fecEmis AS fecEmision, "
lcSql = lcSql + "cc_cli.idCliente, "
lcSql = lcSql + "clientes.razSoc, "
lcSql = lcSql + "movcjarel.cbte, "
lcSql = lcSql + "movcjarel.tipoDoc, "
lcSql = lcSql + "movcjarel.ptoVta, "
lcSql = lcSql + "movcjarel.numCbte, "
lcSql = lcSql + "movcjarel.importe, "
lcSql = lcSql + "movcjarel.saldo "
lcSql = lcSql + "FROM movcjarel "
lcSql = lcSql + "	INNER JOIN cc_cli ON movcjarel.idCC_Cli = cc_cli.idCC_Cli "
lcsql = lcSql + " 	INNER JOIN clientes ON cc_cli.idCliente = clientes.idCliente "
lcSql = lcSql + "WHERE movcjarel.idMovCjaC = " + ALLTRIM(STR(cur_movCaja.idMovCjaC)) + " "
lcSql = lcSql + "	AND movcjarel.idMovCjaD = " + ALLTRIM(STR(cur_movCaja.idMovCjaD)) + " "
lcSql = lcSql + "ORDER BY idMovCjaR ASC "

loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_mov"
loResult.OpenQuery(lcSql)

SELECT cur_mov
IF RECCOUNT("cur_mov") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_mov")
	lcNroCbte = REPLICATE("0", 4 - LEN(ALLTRIM(STR(cur_mov.ptovta)))) + ALLTRIM(STR(cur_mov.ptovta)) + "-" + REPLICATE("0", 8 - LEN(ALLTRIM(STR(cur_mov.numcbte)))) + ALLTRIM(STR(cur_mov.numcbte))
	SELECT cur_movCajaCbte
	APPEND BLANK

	REPLACE idMovCjaR	WITH cur_mov.idMovCjaR 	ADDITIVE
	REPLACE fecha		WITH cur_mov.fecEmision	ADDITIVE
	REPLACE idCliente	WITH cur_mov.idCliente 	ADDITIVE
	REPLACE RazSoc		WITH cur_mov.razSoc		ADDITIVE
	REPLACE cbte		WITH cur_mov.cbte 		ADDITIVE
	REPLACE tipodoc		WITH cur_mov.tipoDoc	ADDITIVE
	REPLACE nrocbte		WITH ALLTRIM(lcNroCbte) ADDITIVE
	REPLACE importe		WITH cur_mov.importe	ADDITIVE
	REPLACE saldo		WITH cur_mov.saldo	 	ADDITIVE

	SELECT cur_mov
	SKIP
ENDDO

loResult.Close_Query()

SELECT cur_movCajaCbte
IF RECCOUNT("cur_movCajaCbte") > 0 THEN
	GO TOP
ENDIF

Thisform.pgf.page3.grdMovCajaCbte.Refresh()
ENDPROC
PROCEDURE Load
DODEFAULT()

thisform.recibos.crear_cursor()


CREATE CURSOR cur_MovCaja (;
	idMovCjaD	int,;
	idMovCjaC	int,;
	fecha		datetime,;
	conCcj		varchar(60),;
	cbte		varchar(3),;
	tipodoc		varchar(1),;
	nrocbte		varchar(13),;
	impDebe		float(10, 2),;
	impHaber	float(10, 2),;
	saldo		float(10, 2))
	

CREATE CURSOR cur_MovCajaDet (;
	ctaCja		varchar(60),;
	importe		float(10, 2),;
	banco		varchar(60),;
	nrocheque	varchar(8),;
	provincia	varchar(60),;
	retCompro	int,;
	retFecha	datetime)
	

CREATE CURSOR cur_MovCajaCbte (;
	idMovCjaR	int,;
	fecha		datetime,;
	idCliente	int,;
	RazSoc		varchar(60),;
	cbte		varchar(3),;
	tipodoc		varchar(1),;
	nrocbte		varchar(13),;
	importe		float(10, 2),;
	saldo		float(10, 2))


CREATE CURSOR cur_ResCta (	 ;
	codigo		varchar(5)	,;
	descripcio	varchar(60)	,;
	importe		float(10,2))
	

CREATE CURSOR cur_ResConc (	;
	codConc		varchar(5)	,;
	concepto	varchar(60)	,;
	codCjaCta	varchar(5)	,;
	ctaCja		varchar(60)	,;
	importe		float(10, 2))	
ENDPROC
PROCEDURE Init
Thisform.verificar_cajaabierta()

&& Armo la grilla que corresponde a la selección de facturas
SELECT cur_facturas
Thisform.Pgf.Page1.grdCbtes.RecordSource = "cur_facturas"
Thisform.Pgf.Page1.grdCbtes.list_controlsource = "selected,idCliente,razSoc,fecEmis,cbte,tipodoc,numCbte1,Saldo"
Thisform.Pgf.Page1.grdCbtes.lista_ancho_cols = "50,70,150,150,70,50,150,70"
Thisform.Pgf.Page1.grdCbtes.titulos_cabeceras = "Sel.,Cliente,Razón Social,Fecha,Cbte,Tipo,Número,Saldo"
Thisform.Pgf.Page1.grdCbtes.generar_grid()


&& Armo la grilla correspondiente al detalle del recibo
SELECT cur_Detalle
Thisform.pgf.Page2.contenedor_cheques.grdDetalle.RecordSource = "cur_Detalle"
Thisform.Pgf.Page2.contenedor_cheques.grdDetalle.list_controlsource = "tipoPago,chq_nro,descripcio,tipoDoc,nroCuit,titular,fecvto,importe"
Thisform.Pgf.Page2.contenedor_cheques.grdDetalle.lista_ancho_cols = "70,80,170,70,80,200,70,70"
Thisform.Pgf.Page2.contenedor_cheques.grdDetalle.titulos_cabeceras = "Tipo Pago,Nº Cheque,Descripción,Tipo Doc.,Nº Doc.,Titular,Fecha Vto.,Importe"
Thisform.Pgf.Page2.contenedor_cheques.grdDetalle.generar_grid();


&& Grilla donde se muestran las cabeceras de los movimientos de la cajas diaria
SELECT cur_MovCaja
Thisform.pgf.page3.grdMovCaja.RecordSource = "cur_MovCaja"
Thisform.pgf.page3.grdMovCaja.list_controlsource = "idMovCjaD,fecha,conccj,cbte,tipodoc,nrocbte,impdebe,imphaber,saldo"
Thisform.pgf.page3.grdMovCaja.lista_ancho_cols = "50,130,240,50,50,100,70,70,70"
Thisform.pgf.page3.grdMovCaja.titulos_cabeceras = "Nº Mov.,Fecha,Concepto,Cbte,Tipo,Número,Debe,Haber,Saldo"
Thisform.pgf.page3.grdMovCaja.permitir_busqueda = .F.
Thisform.pgf.page3.grdMovCaja.permitir_ordenamiento = .F.
Thisform.pgf.page3.grdMovCaja.generar_grid()


&& Grilla donde se muestran los medios de pago utilizados por cada movimiento
SELECT cur_MovCajaDet
Thisform.pgf.page3.grdMovCajaDet.RecordSource = "cur_MovCajaDet"
Thisform.pgf.page3.grdMovCajaDet.list_controlsource = "ctaCja,importe,banco,nrocheque,provincia,retCompro,retFecha"
Thisform.pgf.page3.grdMovCajaDet.lista_ancho_cols = "200,70,150,70,120,70,130"
Thisform.pgf.page3.grdMovCajaDet.titulos_cabeceras = "Cuenta,Importe,Banco,Nº Cheque,Ret. Prov.,Ret. Cbte,Ret. Fecha"
Thisform.pgf.page3.grdMovCajaDet.permitir_busqueda = .F.
Thisform.pgf.page3.grdMovCajaDet.permitir_ordenamiento = .F.
Thisform.pgf.page3.grdMovCajaDet.generar_grid()


&& Grilla donde se muestran los cbtes aplicados por cada movimiento
SELECT cur_MovCajaCbte
Thisform.pgf.page3.grdMovCajaCbte.RecordSource = "cur_MovCajaCbte"
Thisform.pgf.page3.grdMovCajaCbte.list_controlsource = "fecha,idCliente,RazSoc,cbte,tipodoc,nrocbte,importe,saldo"
Thisform.pgf.page3.grdMovCajaCbte.lista_ancho_cols = "130,70,200,50,50,100,70,70"
Thisform.pgf.page3.grdMovCajaCbte.titulos_cabeceras = "Fecha, Nº Cliente,Razon Social,Cbte,Tipo,Número,Importe,Saldo"
Thisform.pgf.page3.grdMovCajaCbte.permitir_busqueda = .F.
Thisform.pgf.page3.grdMovCajaCbte.permitir_ordenamiento = .F.
Thisform.pgf.page3.grdMovCajaCbte.generar_grid()

Thisform.pgf.page1.txtNroRec.Enabled = .F.
Thisform.pgf.page1.txtPtoVta.Enabled = .F.


&& Cargo los tipos de documento
Thisform.cargar_tipodoc()

Thisform.leer_cajadiaria()
Thisform.leer_cbtes_contados()
Thisform.pgf.page1.sel_Cliente.txtCodigo.SetFocus()
ENDPROC


************************************************************
OBJETO: pgf
************************************************************
*** PROPIEDADES ***
ErasePage = .T.
PageCount = 3
Top = 1
Left = 2
Width = 886
Height = 551
Name = "pgf"
Page1.Caption = "Comprobantes a Aplicar"
Page1.Name = "Page1"
Page2.Caption = "Pagos"
Page2.Name = "Page2"
Page3.FontBold = .T.
Page3.FontItalic = .T.
Page3.FontSize = 8
Page3.Caption = "Movimientos"
Page3.ForeColor = 128,64,64
Page3.Name = "Page3"

*** METODOS ***
PROCEDURE Page2.Click
Thisform.Pgf.Page2.contenedor_efvo.txtImpEfvo.SetFocus()
ENDPROC
PROCEDURE Page3.Click
Thisform.pgf.page3.grdMovCaja.SetFocus()
ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Cliente:"
Height = 15
Left = 9
Top = 77
Width = 48
TabIndex = 4
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: sel_Cliente
************************************************************
*** PROPIEDADES ***
Top = 72
Left = 60
TabIndex = 1
esnumerico = .T.
nombre_campo_codigo = idCliente
nombre_campo_desc = razSoc
nombre_tabla = clientes
pkfield = idCliente
alternative_cols = nomfant,nrocuit
anchos_cols = 270,270,80
title_cols = Descripción, Nom. Fantasía, Nro. Doc.
Name = "sel_Cliente"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***
PROCEDURE recuperar_datos
LOCAL loVtas, lcSql, lcPtoVta, lcNumero

loVtas = CREATEOBJECT("odbc_result")
lcSql = ""
lcPtoVta = ""
lcNumero = ""
thisform.idcliente = clientes.idcliente

*********************************************************
&& Limpio

Thisform.Pgf.Page2.contenedor_efvo.txtImpEfvo.Value = 0.00
thisform.pgf.page2.contenedor_efvo.txtImpTC.Value = 0.00
Thisform.pgf.page2.contenedor_efvo.txtImpTD.Value = 0.00
Thisform.pgf.page2.contenedor_cheques.opgTipoPago.option1.Value = 1
Thisform.pgf.page2.contenedor_cheques.opgTipoPago.option2.Value = 0
Thisform.pgf.page2.contenedor_cheques.sel_Banco.blanquear()
Thisform.pgf.page2.contenedor_cheques.txtsucursal.Value = ""
Thisform.pgf.page2.contenedor_cheques.txtnroCheque.Value = ""
Thisform.pgf.page2.contenedor_cheques.txtFecEmis.Value = {}
Thisform.pgf.page2.contenedor_cheques.txtFecVto.Value = {}
Thisform.pgf.page2.contenedor_cheques.cmbTipoDoc.ListIndex = 1
Thisform.pgf.page2.contenedor_cheques.txtnroCUIT.Value = 0
Thisform.pgf.page2.contenedor_cheques.txtTitular.Value = ""
Thisform.pgf.page2.contenedor_cheques.txtimporte.Value = 0.00
Thisform.pgf.page2.contenedor_cheques.txttotalRec.Value = 0.00
Thisform.pgf.page2.contenedor_ret.txtRetGan.Value = 0.00
Thisform.pgf.page2.contenedor_ret.txtRetIIBB.Value = 0.00
Thisform.pgf.page2.contenedor_ret.txtRetIVA.Value = 0.00
Thisform.pgf.page2.contenedor_ret.txtRetSUSS.Value = 0.00
Thisform.pgf.page2.contenedor_ret.txtFecGAN.Value = {}
Thisform.pgf.page2.contenedor_ret.txtFecIIBB.Value = {}
Thisform.pgf.page2.contenedor_ret.txtFecIVA.Value = {}
Thisform.pgf.page2.contenedor_ret.txtFecSUSS.Value = {}
Thisform.pgf.page2.contenedor_ret.txtCbteGAN.Value = 0
Thisform.pgf.page2.contenedor_ret.txtCbteIIBB.Value = 0
Thisform.pgf.page2.contenedor_ret.txtCbteIVA.Value = 0
Thisform.pgf.page2.contenedor_ret.txtCbteSUSS.Value = 0
Thisform.pgf.page2.contenedor_Ret.sel_provincia.blanquear()

Thisform.txtImpCbtes.Value = 0.00
Thisform.txtImpImputar.Value = 0.00
Thisform.txtPagoCon.Value = 0.00
Thisform.txtCambio.Value = 0.00

Thisform.leer_cajadiaria()
Thisform.Recibos.limpiar()

*********************************************************
*!*	lcSql = "SELECT		cc_cli.idVentasC, "
*!*	lcSql = lcSql + "	cc_cli.idCliente, "
*!*	lcSql = lcSql + "	cc_cli.idCondPago, "
*!*	lcSql = lcSql + "	cc_cli.idSitIVA, "
*!*	lcSql = lcSql + "	cc_cli.idVendedor, "
*!*	lcSql = lcSql + "	ventascab.razSoc, "
*!*	lcSql = lcSql + "	cc_cli.fecEmis, "
*!*	lcSql = lcSql + "	cc_cli.tipoDoc, "
*!*	lcSql = lcSql + "	cc_cli.cbte, "
*!*	lcSql = lcSql + "	cc_cli.ptoVta, "
*!*	lcSql = lcSql + "	cc_cli.nroCbte, "
*!*	lcSql = lcSql + "	Saldos.saldo "
*!*	lcSql = lcSql + " FROM cc_cli INNER JOIN clientes ON cc_cli.idCliente = clientes.idCliente "
*!*	lcSql = lcSql + "	LEFT JOIN (SELECT cc2.idoper, ROUND(SUM(cc2.impdebe - cc2.imphaber),2) as Saldo "
*!*	lcSql = lcSql + "				FROM cc_cli cc2 "
*!*	lcSql = lcSql + "				WHERE (cc2.usubaja is null or cc2.usubaja = '') "
*!*	lcSql = lcSql + "				GROUP BY cc2.idoper) AS Saldos ON cc_cli.idoper = Saldos.idoper "
*!*	lcSql = lcSql + "	INNER JOIN ventascab ON ventascab.idVentasC = cc_cli.idVentasC "
*!*	lcSql = lcSql + " WHERE ventascab.cbte IN ('FC','ND') "
*!*	lcSql = lcSql + " 	AND Saldos.Saldo > 0 "
*!*	lcSql = lcSql + " 	AND cc_cli.idCliente = " + ALLTRIM(STR(Thisform.pgf.Page1.sel_cliente.valcpoid)) + " "
*!*	lcSql = lcSql + " ORDER BY cc_cli.fecEmis ASC"

lcSql = "SELECT	cc.*, SaldoTot, clientes.razsoc "
lcSql = lcSql + "FROM  cc_cli cc INNER JOIN clientes ON cc.idCliente = clientes.idCliente "
lcSql = lcSql + " 	left join ( SELECT idoper, MAX(fecemis) AS 'fecfc' "
lcSql = lcSql + " 				FROM cc_cli "
lcSql = lcSql + " 				WHERE cbte IN ('FC') and idoper != 0 "
lcSql = lcSql + " 				GROUP BY idoper) AS operfc ON cc.idoper = operfc.idoper "
lcSql = lcSql + " 	left join ( SELECT idoper, MAX(fecemis) AS 'fecnd' "
lcSql = lcSql + " 				FROM cc_cli "
lcSql = lcSql + " 				WHERE cbte IN ('ND') and idoper != 0 "
lcSql = lcSql + " 				GROUP BY idoper) AS opernd ON cc.idoper = opernd.idoper "
lcSql = lcSql + " 	left join ( SELECT idoper, MAX(fecemis) AS 'fecad' "
lcSql = lcSql + " 				FROM cc_cli "
lcSql = lcSql + " 				WHERE cbte IN ('AD') and idoper != 0 "
lcSql = lcSql + " 				GROUP BY idoper) AS operad ON cc.idoper = operad.idoper "
lcSql = lcSql + "	inner join ( SELECT cc2.idoper, ROUND(SUM(cc2.impdebe - cc2.imphaber),2) as SaldoTot "
lcSql = lcSql + " 				FROM cc_cli cc2 "
lcSql = lcSql + " 				WHERE cc2.idcliente = " + ALLTRIM(STR(Thisform.pgf.Page1.sel_cliente.valcpoid)) + " "
lcSql = lcSql + "         			and (cc2.usubaja is null or cc2.usubaja = '') "
lcSql = lcSql + "         			and idoper != 0 "
lcSql = lcSql + "         		GROUP BY cc2.idoper) AS Saldos ON cc.idoper = Saldos.idoper "
lcSql = lcSql + "WHERE cc.idCliente = " + ALLTRIM(STR(Thisform.pgf.Page1.sel_cliente.valcpoid)) + " "
lcSql = lcSql + " 	AND (cc.UsuBaja IS NULL OR cc.UsuBaja = '') "
lcSql = lcSql + "    AND SaldoTot > 0 "
lcSql = lcSql + "    AND (SUBSTRING(CBTE,1,2)='FC' OR (CBTE='ND' AND fecfc IS NULL) OR (CBTE='AD' AND fecfc IS NULL AND fecnd IS NULL)) " 
lcSql = lcSql + "ORDER BY fecemis ASC "

loVtas.ActiveConnection = goConn.ActiveConnection
loVtas.Cursor_Name = "cur_vta"

IF !loVtas.OpenQuery(lcSql) THEN
	MESSAGEBOX(loVtas.error_message, 0+16, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_vta
IF RECCOUNT("cur_vta") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_vta")
	lcPtoVta = REPLICATE("0", 4 - LEN(ALLTRIM(STR(cur_vta.ptoVta)))) + ALLTRIM(STR(cur_vta.ptoVta))
	lcNumero = REPLICATE("0", 8 - LEN(ALLTRIM(STR(cur_vta.nroCbte)))) + ALLTRIM(STR(cur_vta.nroCbte))

	SELECT cur_facturas
	APPEND BLANK
	REPLACE cur_facturas.selected 	WITH .F.
	REPLACE cur_facturas.idCC_Cli	WITH cur_vta.idCC_Cli ADDITIVE
	REPLACE cur_facturas.idVentasC 	WITH IIF(ISNULL(cur_vta.idVentasC), 0, cur_vta.idVentasC) ADDITIVE
	REPLACE cur_facturas.idCliente	WITH cur_vta.idCliente ADDITIVE
	REPLACE cur_facturas.idCondPago WITH cur_vta.idCondPago ADDITIVE
	REPLACE cur_facturas.idSitIVA 	WITH cur_vta.idSitIVA ADDITIVE
	REPLACE cur_facturas.idVendedor WITH cur_vta.idVendedor ADDITIVE
	REPLACE cur_facturas.razSoc		WITH cur_vta.razSoc ADDITIVE
	REPLACE cur_facturas.fecEmis 	WITH cur_vta.fecEmis ADDITIVE
	REPLACE cur_facturas.cbte 		WITH ALLTRIM(cur_vta.cbte) ADDITIVE
	REPLACE cur_facturas.numCbte1 	WITH lcPtoVta + "-" + lcNumero ADDITIVE
	REPLACE cur_facturas.TipoDoc	WITH cur_vta.tipoDoc ADDITIVE
	REPLACE cur_facturas.PtoVta 	WITH cur_vta.ptoVta ADDITIVE
	REPLACE cur_facturas.numCbte	WITH cur_vta.nroCbte ADDITIVE
	REPLACE cur_facturas.importe 	WITH cur_vta.impdebe ADDITIVE	
	REPLACE cur_facturas.saldo 		WITH cur_vta.saldotot ADDITIVE
	REPLACE cur_facturas.idOper 	WITH cur_vta.idOper ADDITIVE

	SELECT cur_vta
	SKIP
ENDDO

loVtas.close_query()

SELECT cur_facturas
IF RECCOUNT("cur_facturas") > 0 THEN
	GO TOP
ENDIF

Thisform.pgf.page1.grdCbtes.Refresh()

IF clientes.idCondPago <> 1 THEN 
	Thisform.pgf.Page1.sel_Cliente.txtCodigo.Enabled = .T.
	thisform.pgf.Page1.sel_Cliente.txtCodigo.SetFocus()
	Thisform.pgf.page1.optCliente.option1.Value = 0
	Thisform.pgf.page1.optCliente.option2.Value = 1

	IF getGlobalCFG("NRC_AUTO") THEN
		thisform.pgf.page1.txtPtoVta.Value = "AUTO"
		thisform.pgf.page1.txtNroRec.Value = "MATICO"
	ELSE 
		Thisform.pgf.Page1.txtPtoVta.blanquear()
		Thisform.pgf.Page1.txtNroRec.blanquear()
		thisform.pgf.Page1.txtNroRec.Enabled = .T.
		thisform.pgf.Page1.txtPtoVta.Enabled = .T.
	ENDIF

ELSE
	Thisform.pgf.Page1.txtPtoVta.blanquear()
	Thisform.pgf.Page1.txtNroRec.blanquear()
	Thisform.pgf.page1.txtPtoVta.Enabled = .F.
	Thisform.pgf.page1.txtNroRec.Enabled = .F.
	Thisform.pgf.page1.optCliente.option1.Value = 1
	Thisform.pgf.page1.optCliente.option2.Value = 0
ENDIF
ENDPROC


************************************************************
OBJETO: grdCbtes
************************************************************
*** PROPIEDADES ***
Height = 408
Left = 5
TabIndex = 6
Top = 112
Width = 872
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdCbtes"
COLUMN1.Header1.Name = "Header1"
COLUMN1.Text1.ReadOnly = .F.
COLUMN1.Text1.Name = "Text1"
COLUMN1.CurrentControl = "Clscheckbox1"
COLUMN1.ReadOnly = .F.
COLUMN1.Sparse = .F.
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
OBJETO: Clscheckbox1
************************************************************
*** PROPIEDADES ***
Top = 30
Left = 14
Alignment = 0
Caption = ""
ControlSource = ""
ReadOnly = .F.
Name = "Clscheckbox1"

*** METODOS ***
PROCEDURE Click
IF this.Value THEN
	Thisform.txtImpImputar.Value = Thisform.txtImpImputar.Value + cur_facturas.saldo
	Thisform.txtimpcbtes.Value = Thisform.txtimpcbtes.Value + cur_facturas.saldo
ELSE
	Thisform.txtImpImputar.Value = Thisform.txtImpImputar.Value - cur_facturas.saldo
	Thisform.txtimpcbtes.Value = Thisform.txtimpcbtes.Value - cur_facturas.saldo
ENDIF

Thisform.calc_saldoimputar()
ENDPROC


************************************************************
OBJETO: optCliente
************************************************************
*** PROPIEDADES ***
Height = 36
Left = 8
Top = 25
Width = 850
Name = "optCliente"
Option1.Caption = "Contado"
Option1.Height = 16
Option1.Left = 245
Option1.Top = 8
Option1.Width = 115
Option1.Name = "Option1"
Option2.Caption = "Recibo"
Option2.Height = 24
Option2.Left = 495
Option2.Top = 6
Option2.Width = 132
Option2.Name = "Option2"

*** METODOS ***
PROCEDURE Option1.Click
IF This.Value = 1 THEN
	thisform.recibos.limpiar()
	Thisform.leer_cbtes_contados()
	&&Thisform.pgf.Page1.sel_Cliente.txtCodigo.Enabled = .F.
	Thisform.pgf.Page1.sel_cliente.blanquear()
	Thisform.pgf.Page1.sel_cliente.valcpoid = 0
	Thisform.pgf.Page1.txtPtoVta.blanquear()
	Thisform.pgf.Page1.txtNroRec.blanquear()
	thisform.pgf.Page1.txtPtoVta.Enabled = .F.
	thisform.pgf.Page1.txtNroRec.Enabled = .F.
	thisform.pgf.page1.sel_Cliente.txtCodigo.SetFocus()
	Thisform.txtImpCbtes.Value = 0.00
	Thisform.txtImpImputar.Value = 0.00
	&&Thisform.txtPagoCon.Value = 0.00
	Thisform.txtCambio.Value = 0.00
	Thisform.calc_saldoimputar()
ENDIF
ENDPROC
PROCEDURE Option2.Click
IF This.Value = 1 THEN
	Thisform.pgf.Page1.sel_Cliente.txtCodigo.Enabled = .T.
	Thisform.pgf.Page1.sel_cliente.blanquear()
	Thisform.pgf.Page1.sel_cliente.valcpoid = 0
	thisform.pgf.Page1.sel_Cliente.txtCodigo.SetFocus()
	thisform.recibos.limpiar()
	
	IF getGlobalCFG("NRC_AUTO") THEN
		thisform.pgf.page1.txtPtoVta.Value = "AUTO"
		thisform.pgf.page1.txtNroRec.Value = "MATICO"
	ELSE 
		Thisform.pgf.Page1.txtPtoVta.blanquear()
		Thisform.pgf.Page1.txtNroRec.blanquear()
		thisform.pgf.Page1.txtNroRec.Enabled = .T.
		thisform.pgf.Page1.txtPtoVta.Enabled = .T.
	ENDIF
	
	Thisform.txtImpCbtes.Value = 0.00
	Thisform.txtImpImputar.Value = 0.00
	&&Thisform.txtPagoCon.Value = 0.00
	Thisform.txtCambio.Value = 0.00
	Thisform.calc_saldoimputar()
ENDIF
ENDPROC


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Nro. Recibo:"
Height = 15
Left = 566
Top = 77
Width = 77
TabIndex = 10
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: txtPtoVta
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 644
MaxLength = 4
TabIndex = 4
Top = 73
Width = 64
autocompleta = .T.
isnumeric = .F.
ischaracter = .T.
Name = "txtPtoVta"

*** METODOS ***


************************************************************
OBJETO: txtNroRec
************************************************************
*** PROPIEDADES ***
Tag = "edit"
Height = 21
Left = 710
MaxLength = 8
TabIndex = 5
Top = 73
Width = 118
ischaracter = .T.
autocompleta = .T.
Name = "txtNroRec"

*** METODOS ***


************************************************************
OBJETO: contenedor_efvo
************************************************************
*** PROPIEDADES ***
Top = 4
Left = 8
Width = 864
Height = 58
BackStyle = 1
TabIndex = 1
Name = "contenedor_efvo"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Efectivo / Tarjetas"
Height = 15
Left = 7
Top = 4
Width = 131
TabIndex = 9
ForeColor = 0,0,0
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Efectivo:"
Height = 15
Left = 14
Top = 33
Width = 67
TabIndex = 10
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: txtImpEfvo
************************************************************
*** PROPIEDADES ***
Left = 72
TabIndex = 1
Top = 30
isnumeric = .T.
Name = "txtImpEfvo"

*** METODOS ***
PROCEDURE LostFocus
DODEFAULT()

IF this.Value < 0 THEN 
	MESSAGEBOX("No se pueden ingresar valores negativos",0+48,Thisform.Caption)
	This.SetFocus()
	RETURN .F.
ENDIF 

thisform.calc_saldoimputar()

ENDPROC


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Tarjeta de Débito:"
Height = 15
Left = 206
Top = 34
Width = 101
TabIndex = 12
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Tarjeta de Crédito:"
Height = 15
Left = 453
Top = 34
Width = 101
TabIndex = 13
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: txtImpTD
************************************************************
*** PROPIEDADES ***
Left = 316
TabIndex = 2
Top = 31
isnumeric = .T.
Name = "txtImpTD"

*** METODOS ***
PROCEDURE LostFocus
DODEFAULT()

IF this.Value < 0 THEN 
	MESSAGEBOX("No se pueden ingresar valores negativos",0+48,Thisform.Caption)
	This.SetFocus()
	RETURN .F.
ENDIF 

thisform.calc_saldoimputar()

ENDPROC


************************************************************
OBJETO: txtImpTC
************************************************************
*** PROPIEDADES ***
Left = 563
TabIndex = 3
Top = 31
isnumeric = .T.
Name = "txtImpTC"

*** METODOS ***
PROCEDURE LostFocus
DODEFAULT()

IF this.Value < 0 THEN 
	MESSAGEBOX("No se pueden ingresar valores negativos",0+48,Thisform.Caption)
	This.SetFocus()
	RETURN .F.
ENDIF 

thisform.calc_saldoimputar()

ENDPROC


************************************************************
OBJETO: CLSLINEA2
************************************************************
*** PROPIEDADES ***
Height = 1
Left = 7
Top = 20
Width = 840
Name = "CLSLINEA2"

*** METODOS ***


************************************************************
OBJETO: contenedor_cheques
************************************************************
*** PROPIEDADES ***
Top = 65
Left = 8
Width = 864
Height = 331
BackStyle = 1
TabIndex = 2
Name = "contenedor_cheques"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Cheque / Depósito Bancario"
Height = 15
Left = 7
Top = 5
Width = 175
TabIndex = 14
ForeColor = 0,0,0
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Banco:"
Height = 15
Left = 15
Top = 55
Width = 58
TabIndex = 15
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Sucursal:"
Height = 15
Left = 588
Top = 56
Width = 57
TabIndex = 16
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Nro. Cheque:"
Height = 15
Left = 15
Top = 79
Width = 81
TabIndex = 19
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Fecha Emisión:"
Height = 15
Left = 237
Top = 80
Width = 87
TabIndex = 21
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta6
************************************************************
*** PROPIEDADES ***
Caption = "Fecha de Vto.:"
Height = 15
Left = 428
Top = 80
Width = 87
TabIndex = 22
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta7
************************************************************
*** PROPIEDADES ***
Caption = "Importe:"
Height = 15
Left = 619
Top = 79
Width = 50
TabIndex = 23
Name = "Clsetiqueta7"

*** METODOS ***


************************************************************
OBJETO: sel_Banco
************************************************************
*** PROPIEDADES ***
Top = 49
Left = 94
TabIndex = 2
nombre_campo_codigo = codBco
nombre_campo_desc = descripcio
nombre_tabla = bancos
pkfield = idBanco
Name = "sel_Banco"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: txtSucursal
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 645
TabIndex = 3
Top = 51
Width = 215
ischaracter = .T.
Name = "txtSucursal"

*** METODOS ***


************************************************************
OBJETO: txtNroCheque
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 96
MaxLength = 8
TabIndex = 4
Top = 75
Width = 136
ischaracter = .T.
autocompleta = .T.
Name = "txtNroCheque"

*** METODOS ***


************************************************************
OBJETO: txtFecEmis
************************************************************
*** PROPIEDADES ***
Left = 325
TabIndex = 5
Top = 75
isdatetime = .T.
Name = "txtFecEmis"

*** METODOS ***


************************************************************
OBJETO: txtFecVto
************************************************************
*** PROPIEDADES ***
Left = 513
TabIndex = 6
Top = 75
isdatetime = .T.
Name = "txtFecVto"

*** METODOS ***


************************************************************
OBJETO: txtImporte
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 672
TabIndex = 7
Top = 75
Width = 95
isnumeric = .T.
Name = "txtImporte"

*** METODOS ***
PROCEDURE LostFocus
DODEFAULT()

IF this.Value < 0 THEN 
	MESSAGEBOX("No se pueden ingresar valores negativos",0+48,Thisform.Caption)
	This.SetFocus()
	RETURN .F.
ENDIF 

thisform.calc_saldoimputar()

ENDPROC


************************************************************
OBJETO: grdDetalle
************************************************************
*** PROPIEDADES ***
Height = 173
Left = 4
TabIndex = 24
Top = 126
Width = 859
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdDetalle"
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
OBJETO: btnAgregarCheque
************************************************************
*** PROPIEDADES ***
Top = 77
Left = 771
Height = 44
Width = 45
TabIndex = 11
Name = "btnAgregarCheque"

*** METODOS ***
PROCEDURE Click
&& Este método permite agregar un nuevo item al recibo
LOCAL loPlanCta, lcSql, llEsCheque, lnIdCliente, lnIdBanco, lc_nrocheque

lcSql = ""
loPlanCta = CREATEOBJECT("odbc_result")
lnIdCliente = thisform.pgf.page1.sel_Cliente.valcpoid
lnIdBanco = thisform.pgf.page2.contenedor_cheques.sel_Banco.valcpoid
lc_nrocheque = thisform.pgf.page2.contenedor_cheques.txtNroCheque.Value 

IF This.Parent.opgTipoPago.Option1.Value = 1 THEN
	llEsCheque = .T.
ELSE
	llEsCheque = .F.
ENDIF

&& Valido que se haya seleccionado solo un cliente en el caso que sea cheque
IF llEsCheque THEN 
	SELECT	idCliente ;
	FROM	cur_facturas ;
	WHERE	selected = .T. ;
	GROUP BY idCliente INTO CURSOR cur_x
	
	SELECT cur_x
	
	IF RECCOUNT("cur_x") > 1 THEN
		MESSAGEBOX("Tiene seleccionado comprobantes de diferentes clientes, no se puede aplicar cheques al pago.", 0+48, Thisform.Caption)
		USE IN cur_x
		RETURN .F.
	ENDIF
	
	IF lnIdCliente = 0 THEN
		lnIdCliente = cur_x.idCliente
	ENDIF 
	
	USE IN cur_x
ENDIF 



&& Valido que se hayan ingresado los datos del cheque
IF This.Parent.sel_Banco.valcpoid = 0 THEN
	MESSAGEBOX("Debe seleccionar el banco", 0+48, Thisform.Caption)
	this.Parent.sel_Banco.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

IF llEsCheque THEN
	IF (This.Parent.txtNroCheque.Value == "") .OR. (This.Parent.txtNroCheque.Value == "00000000") THEN
		MESSAGEBOX("Debe ingresar el número de cheque", 0+48, Thisform.Caption)
		This.Parent.txtNroCheque.SetFocus()
		RETURN .F.
	ENDIF

	IF This.Parent.txtFecEmis.Value = {} THEN
		MESSAGEBOX("Debe ingresar la fecha de emisión", 0+48, Thisform.Caption)
		This.Parent.txtFecEmis.SetFocus()
		RETURN .F.
	ENDIF

	IF This.Parent.txtFecVto.Value = {} THEN
		MESSAGEBOX("Debe ingresar la fecha de vencimiento", 0+48, Thisform.Caption)
		This.Parent.txtFecVto.SetFocus()
		RETURN .F.
	ENDIF
	
	IF !Thisform.recibos.validar_cheques(lnIdCliente, lnIdBanco, lc_nrocheque)
		RETURN .F.
	ENDIF 	
ENDIF

IF This.Parent.txtImporte.Value = 0 THEN
	MESSAGEBOX("Debe ingresar el importe", 0+48, Thisform.Caption)
	this.Parent.txtImporte.SetFocus()
	RETURN .F.
ENDIF


SELECT cur_Detalle
APPEND BLANK
REPLACE cur_Detalle.idDetalle WITH 0
REPLACE cur_Detalle.idCheque WITH 0 ADDITIVE
REPLACE cur_Detalle.importe WITH This.Parent.txtImporte.Value ADDITIVE
REPLACE cur_Detalle.idBanco WITH This.Parent.sel_Banco.valcpoid ADDITIVE

IF !llEsCheque THEN
	&& Si el pago es por deposito bancario, entonces, tengo que hacer
	&& que se genere los datos del banco:
	
	REPLACE cur_Detalle.descripcio WITH This.Parent.sel_Banco.txtDescripcion.Value ADDITIVE
	REPLACE cur_Detalle.tipoPago WITH "DEP" ADDITIVE
	REPLACE cur_Detalle.sucursal WITH this.Parent.txtSucursal.Value ADDITIVE 
ELSE
	&& Si es pago con Cheque entonces busco la cuenta cheques en cartera
	&& en el plan de cuenta y lo asigno:
	
	lcSql = "SELECT * FROM planctas WHERE esChqT = 1"
	loPlanCta.Cursor_Name = "cur_PlanCta"
	loPlanCta.ActiveConnection = goConn.ActiveConnection
	loPlanCta.OpenQuery(lcSql)

	REPLACE cur_Detalle.tipoPago WITH "CHEQ" ADDITIVE
	REPLACE cur_Detalle.sucursal WITH this.Parent.txtSucursal.Value ADDITIVE 
	REPLACE cur_Detalle.chq_nro WITH This.Parent.txtNroCheque.Value ADDITIVE
	REPLACE cur_Detalle.idPlanCta WITH cur_PlanCta.idPlanCta ADDITIVE
	REPLACE cur_Detalle.descripcio WITH This.Parent.sel_Banco.txtDescripcion.Value ADDITIVE
	REPLACE cur_Detalle.fecEmis WITH This.Parent.txtFecEmis.Value ADDITIVE
	REPLACE cur_Detalle.fecVto WITH This.Parent.txtFecVto.Value ADDITIVE
	REPLACE cur_Detalle.tipoDoc WITH This.Parent.cmbTipoDoc.Value ADDITIVE
	REPLACE cur_Detalle.nroCuit WITH ALLTRIM(STR(This.Parent.txtNroCUIT.Value, 20, 0)) ADDITIVE
	REPLACE cur_Detalle.titular WITH This.Parent.txtTitular.Value ADDITIVE
	
	loPlanCta.Close_Query()
ENDIF

SELECT cur_Detalle
GO TOP

This.Parent.grdDetalle.Refresh()

This.Parent.txtTotalRec.Value = This.Parent.txtTotalRec.Value + This.Parent.txtImporte.Value

thisform.calc_saldoimputar()

This.Parent.sel_Banco.blanquear()
This.Parent.txtFecEmis.Value = {}
This.Parent.txtFecVto.Value = {}
This.Parent.txtImporte.Value = 0.00
This.Parent.txtSucursal.Value = ""
This.Parent.txtNroCheque.value = ""
This.Parent.cmbTipoDoc.ListIndex = 1
This.Parent.txtNroCUIT.Value = 0
This.Parent.txtTitular.Value = ""
This.Parent.sel_Banco.SetFocus()

RETURN .T.

ENDPROC


************************************************************
OBJETO: opgTipoPago
************************************************************
*** PROPIEDADES ***
BackStyle = 0
BorderStyle = 0
Height = 24
Left = 182
Top = 24
Width = 216
TabIndex = 1
Name = "opgTipoPago"
OPTION1.FontSize = 8
OPTION1.BackStyle = 0
OPTION1.Caption = "Cheque"
OPTION1.Height = 15
OPTION1.Left = 5
OPTION1.TabIndex = 1
OPTION1.Top = 5
OPTION1.Width = 77
OPTION1.ForeColor = 158,106,75
OPTION1.Name = "OPTION1"
OPTION2.FontSize = 8
OPTION2.BackStyle = 0
OPTION2.Caption = "Depósito Bancario"
OPTION2.Height = 15
OPTION2.Left = 89
OPTION2.TabIndex = 2
OPTION2.Top = 5
OPTION2.Width = 127
OPTION2.ForeColor = 158,106,75
OPTION2.Name = "OPTION2"

*** METODOS ***
PROCEDURE OPTION1.Click
IF This.Value = 1 THEN
	Thisform.Pgf.Page2.contenedor_cheques.txtFecEmis.Enabled = .T.
	Thisform.Pgf.Page2.contenedor_cheques.txtFecVto.Enabled = .T.
	Thisform.Pgf.Page2.contenedor_cheques.txtNroCheque.Enabled = .T.
	Thisform.Pgf.Page2.contenedor_cheques.cmbTipoDoc.Enabled = .T.
	Thisform.Pgf.Page2.contenedor_cheques.txtNroCUIT.Enabled = .T.
	Thisform.Pgf.Page2.contenedor_cheques.txtTitular.Enabled = .T.
	Thisform.pgf.page2.contenedor_cheques.sel_Banco.txtCodigo.SetFocus()
ENDIF
ENDPROC
PROCEDURE OPTION2.Click
IF This.Value = 1 THEN
	Thisform.Pgf.Page2.contenedor_cheques.txtFecEmis.Enabled = .F.
	Thisform.Pgf.Page2.contenedor_cheques.txtFecVto.Enabled = .F.
	Thisform.Pgf.Page2.contenedor_cheques.txtNroCheque.Enabled = .F.
	Thisform.Pgf.Page2.contenedor_cheques.cmbTipoDoc.Enabled = .F.
	Thisform.Pgf.Page2.contenedor_cheques.txtNroCUIT.Enabled = .F.
	Thisform.Pgf.Page2.contenedor_cheques.txtTitular.Enabled = .F.
	Thisform.pgf.page2.contenedor_cheques.sel_Banco.txtCodigo.SetFocus()
ENDIF
ENDPROC


************************************************************
OBJETO: Clsetiqueta9
************************************************************
*** PROPIEDADES ***
Caption = "Seleccione la forma de Pago:"
Height = 15
Left = 14
Top = 29
Width = 172
TabIndex = 12
Name = "Clsetiqueta9"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta10
************************************************************
*** PROPIEDADES ***
Caption = "Total:"
Height = 15
Left = 14
Top = 307
Width = 47
TabIndex = 25
Name = "Clsetiqueta10"

*** METODOS ***


************************************************************
OBJETO: txtTotalRec
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Left = 58
TabIndex = 13
Top = 304
isnumeric = .T.
Name = "txtTotalRec"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta8
************************************************************
*** PROPIEDADES ***
Caption = "Tipo Doc:"
Height = 15
Left = 15
Top = 102
Width = 77
TabIndex = 17
Name = "Clsetiqueta8"

*** METODOS ***


************************************************************
OBJETO: cmbTipoDoc
************************************************************
*** PROPIEDADES ***
ControlSource = ""
Height = 21
Left = 96
TabIndex = 8
Top = 99
Width = 100
Name = "cmbTipoDoc"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta11
************************************************************
*** PROPIEDADES ***
Caption = "Nro:"
Height = 15
Left = 210
Top = 103
Width = 32
TabIndex = 20
Name = "Clsetiqueta11"

*** METODOS ***


************************************************************
OBJETO: txtNroCUIT
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 241
MaxLength = 11
TabIndex = 9
Top = 99
Width = 184
isinteger = .T.
ischaracter = .F.
Name = "txtNroCUIT"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta12
************************************************************
*** PROPIEDADES ***
Caption = "Titular:"
Height = 15
Left = 428
Top = 103
Width = 39
TabIndex = 18
Name = "Clsetiqueta12"

*** METODOS ***


************************************************************
OBJETO: txtTitular
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 473
MaxLength = 60
TabIndex = 10
Top = 99
Width = 294
isinteger = .F.
ischaracter = .T.
Name = "txtTitular"

*** METODOS ***


************************************************************
OBJETO: CLSLINEA2
************************************************************
*** PROPIEDADES ***
Height = 1
Left = 7
Top = 21
Width = 840
Name = "CLSLINEA2"

*** METODOS ***


************************************************************
OBJETO: Clsdelete1
************************************************************
*** PROPIEDADES ***
Top = 77
Left = 817
TabIndex = 12
Name = "Clsdelete1"

*** METODOS ***
PROCEDURE Click
LOCAL lnResp

lnResp = MESSAGEBOX("¿Está seguro que desea eliminar este ítem?", 4+32, Thisform.Caption)

IF lnResp = 6 THEN
	SELECT cur_Detalle
	This.Parent.txtTotalRec.Value = This.Parent.txtTotalRec.Value - cur_detalle.importe

	thisform.calc_saldoimputar()

	SELECT cur_Detalle
	DELETE

	Thisform.pgf.page2.contenedor_cheques.grdDETALLE.Refresh()
	This.Parent.sel_Banco.SetFocus()
ENDIF

ENDPROC


************************************************************
OBJETO: contenedor_Ret
************************************************************
*** PROPIEDADES ***
Top = 399
Left = 8
Width = 864
Height = 120
BackStyle = 1
TabIndex = 3
Name = "contenedor_Ret"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Retenciones"
Height = 15
Left = 7
Top = 4
Width = 131
TabIndex = 9
ForeColor = 0,0,0
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta6
************************************************************
*** PROPIEDADES ***
Caption = "IIBB:"
Height = 15
Left = 15
Top = 31
Width = 27
TabIndex = 11
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta7
************************************************************
*** PROPIEDADES ***
Caption = "IVA:"
Height = 15
Left = 15
Top = 79
Width = 30
TabIndex = 14
Name = "Clsetiqueta7"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta8
************************************************************
*** PROPIEDADES ***
Caption = "Ganancias:"
Height = 15
Left = 435
Top = 31
Width = 67
TabIndex = 15
Name = "Clsetiqueta8"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta9
************************************************************
*** PROPIEDADES ***
Caption = "SUSS:"
Height = 15
Left = 434
Top = 55
Width = 34
TabIndex = 16
Name = "Clsetiqueta9"

*** METODOS ***


************************************************************
OBJETO: txtRetIIBB
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 46
TabIndex = 1
Top = 27
Width = 74
isnumeric = .T.
Name = "txtRetIIBB"

*** METODOS ***
PROCEDURE LostFocus
DODEFAULT()

IF this.Value < 0 THEN 
	MESSAGEBOX("No se pueden ingresar valores negativos",0+48,Thisform.Caption)
	This.SetFocus()
	RETURN .F.
ENDIF 

thisform.calc_saldoimputar()

ENDPROC


************************************************************
OBJETO: txtRetIVA
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 46
TabIndex = 5
Top = 75
Width = 74
isnumeric = .T.
Name = "txtRetIVA"

*** METODOS ***
PROCEDURE LostFocus
DODEFAULT()

IF this.Value < 0 THEN 
	MESSAGEBOX("No se pueden ingresar valores negativos",0+48,Thisform.Caption)
	This.SetFocus()
	RETURN .F.
ENDIF 

thisform.calc_saldoimputar()

ENDPROC


************************************************************
OBJETO: txtRetGan
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 502
TabIndex = 8
Top = 28
Width = 74
isnumeric = .T.
Name = "txtRetGan"

*** METODOS ***
PROCEDURE LostFocus
DODEFAULT()

IF this.Value < 0 THEN 
	MESSAGEBOX("No se pueden ingresar valores negativos",0+48,Thisform.Caption)
	This.SetFocus()
	RETURN .F.
ENDIF 

thisform.calc_saldoimputar()

ENDPROC


************************************************************
OBJETO: txtRetSUSS
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 502
TabIndex = 11
Top = 51
Width = 74
isnumeric = .T.
Name = "txtRetSUSS"

*** METODOS ***
PROCEDURE LostFocus
DODEFAULT()

IF this.Value < 0 THEN 
	MESSAGEBOX("No se pueden ingresar valores negativos",0+48,Thisform.Caption)
	This.SetFocus()
	RETURN .F.
ENDIF 

thisform.calc_saldoimputar()

ENDPROC


************************************************************
OBJETO: CLSLINEA2
************************************************************
*** PROPIEDADES ***
Height = 1
Left = 7
Top = 20
Width = 840
Name = "CLSLINEA2"

*** METODOS ***


************************************************************
OBJETO: txtFecIIBB
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 168
TabIndex = 2
Top = 27
Width = 74
isdatetime = .T.
Name = "txtFecIIBB"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Fecha:"
Height = 15
Left = 127
Top = 31
Width = 37
TabIndex = 11
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: txtCbteIIBB
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 298
TabIndex = 3
Top = 27
Width = 100
isinteger = .T.
Name = "txtCbteIIBB"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "N° Cbte:"
Height = 15
Left = 251
Top = 31
Width = 45
TabIndex = 11
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: txtFecIVA
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 168
TabIndex = 6
Top = 75
Width = 74
isdatetime = .T.
Name = "txtFecIVA"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Fecha:"
Height = 15
Left = 127
Top = 79
Width = 37
TabIndex = 11
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: txtCbteIVA
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 298
TabIndex = 7
Top = 75
Width = 100
isnumeric = .F.
isinteger = .T.
Name = "txtCbteIVA"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "N° Cbte:"
Height = 15
Left = 251
Top = 79
Width = 45
TabIndex = 11
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: txtFecGAN
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 625
TabIndex = 9
Top = 28
Width = 74
isdatetime = .T.
Name = "txtFecGAN"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta10
************************************************************
*** PROPIEDADES ***
Caption = "Fecha:"
Height = 15
Left = 584
Top = 32
Width = 37
TabIndex = 11
Name = "Clsetiqueta10"

*** METODOS ***


************************************************************
OBJETO: txtCbteGAN
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 755
TabIndex = 10
Top = 28
Width = 100
isinteger = .T.
Name = "txtCbteGAN"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta11
************************************************************
*** PROPIEDADES ***
Caption = "N° Cbte:"
Height = 15
Left = 708
Top = 32
Width = 45
TabIndex = 11
Name = "Clsetiqueta11"

*** METODOS ***


************************************************************
OBJETO: txtFecSUSS
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 625
TabIndex = 12
Top = 52
Width = 74
isdatetime = .T.
Name = "txtFecSUSS"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta12
************************************************************
*** PROPIEDADES ***
Caption = "Fecha:"
Height = 15
Left = 584
Top = 56
Width = 37
TabIndex = 11
Name = "Clsetiqueta12"

*** METODOS ***


************************************************************
OBJETO: txtCbteSUSS
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 755
TabIndex = 13
Top = 52
Width = 100
isinteger = .T.
Name = "txtCbteSUSS"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta13
************************************************************
*** PROPIEDADES ***
Caption = "N° Cbte:"
Height = 15
Left = 708
Top = 56
Width = 45
TabIndex = 11
Name = "Clsetiqueta13"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta14
************************************************************
*** PROPIEDADES ***
Caption = "Provincia:"
Height = 15
Left = 25
Top = 54
Width = 60
TabIndex = 11
Name = "Clsetiqueta14"

*** METODOS ***


************************************************************
OBJETO: sel_provincia
************************************************************
*** PROPIEDADES ***
Top = 49
Left = 85
Width = 324
Height = 25
TabIndex = 4
esnumerico = .T.
nombre_campo_codigo = idProvin
nombre_campo_desc = descripcio
nombre_tabla = provincias
pkfield = idProvin
Name = "sel_provincia"
txtCodigo.Height = 21
txtCodigo.Left = 2
txtCodigo.Top = 2
txtCodigo.Width = 44
txtCodigo.Name = "txtCodigo"
txtDescripcion.Height = 21
txtDescripcion.Left = 50
txtDescripcion.Top = 2
txtDescripcion.Width = 263
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: grdMovCaja
************************************************************
*** PROPIEDADES ***
Height = 165
Left = 3
Top = 27
Width = 876
Name = "grdMovCaja"
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
PROCEDURE AfterRowColChange
LPARAMETERS nColIndex

Thisform.leer_detcajadiaria()
ENDPROC


************************************************************
OBJETO: grdMovCajaDet
************************************************************
*** PROPIEDADES ***
Height = 150
Left = 3
Top = 211
Width = 876
Name = "grdMovCajaDet"
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
OBJETO: grdMovCajaCbte
************************************************************
*** PROPIEDADES ***
Height = 96
Left = 3
Top = 382
Width = 876
Name = "grdMovCajaCbte"
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
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Movimientos de Caja"
Height = 15
Left = 6
Top = 9
Width = 180
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Medios de pago"
Height = 14
Left = 6
Top = 194
Width = 180
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Comprobantes cancelados"
Height = 12
Left = 6
Top = 365
Width = 180
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsnew1
************************************************************
*** PROPIEDADES ***
Top = 479
Left = 5
ToolTipText = "Ingresar Movimiento"
Visible = .T.
Name = "Clsnew1"

*** METODOS ***
PROCEDURE Click
LOCAL loForm

loForm = CREATEOBJECT("cl_ingmov")
loForm.Show()

IF ALLTRIM(TYPE('loForm')) == "O" THEN
	IF loForm.dialogResult = 1 THEN
		Thisform.leer_cajadiaria()
	ENDIF
	
	loForm.Release()
ENDIF


ENDPROC


************************************************************
OBJETO: Clsimprimir1
************************************************************
*** PROPIEDADES ***
Top = 479
Left = 51
ToolTipText = "Imprimir Parcial"
Name = "Clsimprimir1"

*** METODOS ***
PROCEDURE Click
LOCAL loResult, lcSql, lnCntFC, loDT

loResult = CREATEOBJECT("odbc_result")
loDT = CREATEOBJECT("datetime")
lcSql = ""
lnCntFC = 0

SELECT cur_ResCta
ZAP
SELECT cur_ResConc
ZAP

**************************************************************************************************
&& Armo el resumen por cuenta
**************************************************************************************************
lcSql = "SELECT	movcjadetp.idCtaCja, "
lcSql = lcSql + "		MAX(ctacja.codCtaCJ) AS codigo, "
lcSql = lcSql + "		MAX(ctacja.descripcio) AS descripcio, "
lcSql = lcSql + "		SUM(CASE WHEN conccj.signo = 1 THEN movcjadetp.importe ELSE movcjadetp.importe * -1 END) AS importe "
lcSql = lcSql + "FROM	movcjacab INNER JOIN movcjadet ON movcjacab.idMovCjaC = movcjadet.idMovCjaC "
lcSql = lcSql + "	INNER JOIN movcjadetp ON movcjadet.idMovCjaD = movcjadetp.idMovCjaD AND movcjadet.idMovCjaC = movcjadetp.idMovCjaC "
lcSql = lcSql + "	INNER JOIN ctacja ON ctacja.idCtaCja = movcjadetp.idCtaCja "
lcSql = lcSql + "	INNER JOIN conccj ON conccj.idConcCJ = movcjadet.idConcCJ "
lcSql = lcSql + "WHERE	movcjacab.estado = 'A' "
lcSql = lcSql + "	AND movcjacab.usuBaja IS NULL "
lcSql = lcSql + "	AND movcjadet.usuBaja IS NULL "
lcSql = lcSql + "GROUP BY movcjadetp.idCtaCja "

loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_temp"

IF !loResult.OpenQuery(lcSql) THEN
	MESSAGEBOX(loResult.ErrorMessage, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_temp
IF RECCOUNT("cur_temp") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_temp") 
	SELECT cur_ResCta
	APPEND BLANK
	REPLACE cur_ResCta.codigo WITH cur_temp.codigo
	REPLACE cur_ResCta.descripcio WITH cur_temp.descripcio ADDITIVE
	REPLACE cur_ResCta.importe WITH ROUND(cur_temp.importe, 2) ADDITIVE

	SELECT cur_temp
	SKIP
ENDDO

loResult.Close_Query()

**************************************************************************************************
&& Armo el resumen por concepto/cuenta
**************************************************************************************************
lcSql = "SELECT	movcjadet.idConcCJ, "
lcSql = lcSql + "	movcjadetp.idCtaCja, "
lcSql = lcSql + "	MAX(conccj.codConcCJ)		AS codConc, "
lcSql = lcSql + "	MAX(conccj.descripcio)		AS concepto, "
lcSql = lcSql + "	MAX(ctacja.codCtaCJ)		AS codCjaCta, "
lcSql = lcSql + "	MAX(ctacja.descripcio)		AS ctaCja, "
lcSql = lcSql + "	SUM(CASE WHEN conccj.signo = 1 THEN movcjadetp.importe ELSE movcjadetp.importe * -1 END) AS importe "
lcSql = lcSql + "FROM	movcjadet INNER JOIN movcjacab ON movcjacab.idMovCjaC = movcjadet.idMovCjaC "
lcSql = lcSql + "	INNER JOIN movcjadetp ON movcjadetp.idMovCjaD = movcjadet.idMovCjaD AND movcjadet.idMovCjaC = movcjadetp.idMovCjaC"
lcSql = lcSql + "	INNER JOIN conccj ON conccj.idConcCJ = movcjadet.idConcCJ "
lcSql = lcSql + "	INNER JOIN ctacja ON movcjadetp.idCtaCja = ctacja.idCtaCja "
lcSql = lcSql + "WHERE	movcjacab.estado = 'A' "
lcSql = lcSql + "	AND movcjacab.usuBaja IS NULL "
lcSql = lcSql + "	AND movcjadet.usuBaja IS NULL "
lcSql = lcSql + "GROUP BY movcjadet.idConcCJ, movcjadetp.idCtaCja "
lcSql = lcSql + "ORDER BY idconccj, idctacja "

loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_temp"

IF !loResult.OpenQuery(lcSql) THEN
	MESSAGEBOX(loResult.ErrorMessage, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_temp
IF RECCOUNT("cur_temp") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_temp")
	SELECT cur_ResConc
	APPEND BLANK
	REPLACE cur_ResConc.codConc WITH cur_temp.codConc
	REPLACE cur_ResConc.concepto WITH cur_temp.concepto ADDITIVE
	REPLACE cur_ResConc.codCjaCta WITH cur_temp.codCjaCta ADDITIVE
	REPLACE cur_ResConc.ctaCja WITH cur_temp.ctacja ADDITIVE
	REPLACE cur_ResConc.importe WITH ROUND(cur_temp.importe, 2) ADDITIVE

	SELECT cur_temp
	SKIP
ENDDO

loResult.Close_Query()


&& Calculo la cantidad de facturas aplicadas
lcSql = "SELECT	COUNT(*) AS CantFC "
lcSql = lcSql + "FROM	ventascab "
lcSql = lcSql + "WHERE	ventascab.cbte = 'FC' "

IF INT(VAL(getConfig("SQLSRV"))) = 1 THEN
	lcSql = lcSql + "	AND CONVERT(CHAR(8), ventascab.fecEmision, 112) = " + loDT.toMySql(DATE())
ELSE
	lcSql = lcSql + "	AND ventascab.fecEmision = " + loDT.getDateTime()
ENDIF

loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_cntFC"
loResult.OpenQuery(lcSql)

lnCntFC = cur_cntFC.CantFC

loResult.Close_Query()

SELECT cur_ResCta
REPORT FORM "rep_res_cjacta" TO PRINTER PROMPT PREVIEW 

SELECT cur_ResConc
REPORT FORM "rep_res_cjaconc" TO PRINTER PROMPT PREVIEW

RETURN .T.

ENDPROC


************************************************************
OBJETO: Clscerrar1
************************************************************
*** PROPIEDADES ***
Top = 555
Left = 840
Height = 44
Width = 45
TabIndex = 5
Name = "Clscerrar1"

*** METODOS ***


************************************************************
OBJETO: btnCancelar
************************************************************
*** PROPIEDADES ***
Top = 555
Left = 3
Height = 44
Width = 45
TabIndex = 6
Name = "btnCancelar"

*** METODOS ***
PROCEDURE Click
Thisform.limpiar()
ENDPROC


************************************************************
OBJETO: txtImpImputar
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 329
ReadOnly = .T.
TabIndex = 6
Top = 565
Width = 80
isnumeric = .T.
Name = "txtImpImputar"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta6
************************************************************
*** PROPIEDADES ***
FontSize = 8
Caption = "Cambio:"
Height = 15
Left = 619
Top = 569
Width = 47
TabIndex = 14
ForeColor = 255,0,0
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Importe a Imputar:"
Height = 15
Left = 223
Top = 569
Width = 104
TabIndex = 12
ForeColor = 0,0,0
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Importe Ingresado:"
Height = 15
Left = 418
Top = 569
Width = 109
TabIndex = 12
ForeColor = 0,0,0
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: btnGrabar
************************************************************
*** PROPIEDADES ***
Top = 555
Left = 795
Height = 44
Width = 45
Enabled = .T.
TabIndex = 4
Name = "btnGrabar"

*** METODOS ***
PROCEDURE Click
LOCAL loDT

loDT = CREATEOBJECT("datetime")

IF !Thisform.verificar_cajaabierta()
	RETURN .F.
ENDIF

IF !Thisform.validar_pago() THEN
	RETURN .F.
ENDIF

goConn.BeginTransaction()

thisform.recibos.cbte = IIF(thisform.pgf.page1.optCliente.option2.Value = 1, "RC", "CJA")
thisform.recibos.idconccj = 3 && Aplicacion de comprobante
thisform.recibos.idcliente = thisform.idcliente
thisform.recibos.imp_efec = thisform.Pgf.Page2.contenedor_efvo.txtImpEfvo.Value 
thisform.recibos.imp_td = thisform.Pgf.Page2.contenedor_efvo.txtImpTD.Value 
thisform.recibos.imp_tc = thisform.Pgf.page2.contenedor_efvo.txtImpTC.Value 
thisform.recibos.imp_ib = thisform.Pgf.page2.contenedor_Ret.txtRetIIBB.Value
thisform.recibos.num_ib = thisform.Pgf.page2.contenedor_Ret.txtCbteIIBB.Value 
thisform.recibos.fec_ib = thisform.Pgf.page2.contenedor_Ret.txtFecIIBB.Value 
thisform.recibos.idprovin_ib = thisform.Pgf.page2.contenedor_Ret.sel_provincia.valcpoid
thisform.recibos.imp_iva = thisform.Pgf.page2.contenedor_Ret.txtretIVA.Value 
thisform.recibos.num_iva = thisform.Pgf.page2.contenedor_Ret.txtCbteIVA.Value 
thisform.recibos.fec_iva = thisform.Pgf.page2.contenedor_Ret.txtFecIVA.Value 
thisform.recibos.imp_gan = thisform.Pgf.page2.contenedor_Ret.txtRetGAN.Value
thisform.recibos.num_gan = thisform.Pgf.page2.contenedor_Ret.txtCbteGAN.Value 
thisform.recibos.fec_gan = thisform.Pgf.page2.contenedor_Ret.txtFecGAN.Value  
thisform.recibos.imp_suss = thisform.Pgf.page2.contenedor_Ret.txtRetSUSS.Value 
thisform.recibos.num_suss = thisform.Pgf.page2.contenedor_Ret.txtCbteSUSS.Value 
thisform.recibos.fec_suss = thisform.Pgf.page2.contenedor_Ret.txtFecSUSS.Value 
thisform.recibos.imp_fc = thisform.txtImpCbtes.Value
thisform.recibos.imp_rc = thisform.txtPagoCon.Value 
thisform.recibos.ptovta = ALLTRIM(Thisform.Pgf.Page1.txtPtoVta.Value)
thisform.recibos.nrocbte = ALLTRIM(Thisform.Pgf.Page1.txtNroRec.Value)
thisform.recibos.fec_emis = loDT.getDateTime()
thisform.recibos.grabar_movcaja = .T.

IF !Thisform.recibos.grabar() THEN 
	RETURN .F.
ENDIF 

goConn.Commit()

Thisform.limpiar()

RETURN .T.
ENDPROC


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Importe cbtes:"
Height = 15
Left = 51
Top = 569
Width = 86
TabIndex = 12
ForeColor = 0,0,0
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: txtPagoCon
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 530
ReadOnly = .T.
TabIndex = 7
Top = 565
Width = 80
isnumeric = .T.
Name = "txtPagoCon"

*** METODOS ***
PROCEDURE InteractiveChange
LOCAL lnImputado

lnImputado = 0.00
lnImputado = thisform.sumar_items()
Thisform.Contenido.Pages.Page1.CntAplicar.txtCambio.Value = lnImputado - Thisform.Contenido.Pages.Page1.CntAplicar.txtPagoCon.Value
ENDPROC


************************************************************
OBJETO: txtCambio
************************************************************
*** PROPIEDADES ***
FontSize = 8
Enabled = .F.
Height = 21
Left = 668
ReadOnly = .T.
TabIndex = 10
Top = 565
Width = 80
ForeColor = 255,0,0
isnumeric = .T.
Name = "txtCambio"

*** METODOS ***


************************************************************
OBJETO: txtImpCbtes
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 136
ReadOnly = .T.
TabIndex = 6
Top = 565
Width = 80
isnumeric = .T.
Name = "txtImpCbtes"

*** METODOS ***


************************************************************
OBJETO: Recibos
************************************************************
*** PROPIEDADES ***
Top = 556
Left = 60
Height = 17
Width = 22
Name = "Recibos"

*** METODOS ***


************************************************************
OBJETO: btnActualizar
************************************************************
*** PROPIEDADES ***
Top = 555
Left = 750
Height = 44
Width = 45
Name = "btnActualizar"

*** METODOS ***
PROCEDURE Click
Thisform.leer_cbtes_contados()
ENDPROC


************************************************************
OBJETO: cl_caja
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 9, 6, 15, 12, 32, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


