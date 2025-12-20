************************************************************
OBJETO: _cls_debug_ingcbtes
************************************************************
*** PROPIEDADES ***
BorderStyle = 2
Height = 288
Width = 492
DoCreate = .T.
Caption = "Parametros para testing de ingresos de comprobantes"
cant_cbtes = 0
cant_items = 0
press_aceptar = .F.
por_rec = 0.00
pordesc1 = 0.00
pordesc2 = 0.00
pordesc3 = 0.00
pordesc4 = 0.00
Name = "_cls_debug_ingcbtes"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Cantidad de comprobantes a generar:"
Height = 14
Left = 12
Top = 44
Width = 228
TabIndex = 10
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Cantidad de items por comprobante:"
Height = 14
Left = 12
Top = 71
Width = 228
TabIndex = 11
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: txtCantCbtes
************************************************************
*** PROPIEDADES ***
Left = 240
TabIndex = 1
Top = 41
isinteger = .T.
Name = "txtCantCbtes"

*** METODOS ***


************************************************************
OBJETO: txtCantItems
************************************************************
*** PROPIEDADES ***
Left = 240
TabIndex = 2
Top = 66
isinteger = .T.
Name = "txtCantItems"

*** METODOS ***


************************************************************
OBJETO: btnAceptar
************************************************************
*** PROPIEDADES ***
Top = 240
Left = 396
TabIndex = 8
Name = "btnAceptar"

*** METODOS ***
PROCEDURE Click
IF (Thisform.txtCantCbtes.Value = 0) THEN
	MESSAGEBOX("Debe ingresar la cantidad de comprobantes a generar", + 0+48, Thisform.Caption)
	thisform.txtCantCbtes.SetFocus()
	RETURN
ENDIF

IF (thisform.txtCantItems.Value = 0) THEN
	MESSAGEBOX("Debe ingresar la cantidad de ítems", 0+48, Thisform.Caption)
	thisform.txtCantItems.SetFocus()
	RETURN
ENDIF

thisform.cant_cbtes = thisform.txtCantCbtes.Value
thisform.cant_items = thisform.txtCantItems.Value
thisform.por_rec = thisform.txtPorRec.Value
thisform.pordesc1 = thisform.txtDesc1.Value
thisform.pordesc2 = thisform.txtDesc2.Value
thisform.pordesc3 = thisform.txtDesc3.Value
thisform.pordesc4 = thisform.txtDesc4.Value
thisform.press_aceptar = .t.

thisform.Hide()
ENDPROC


************************************************************
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 240
Left = 444
TabIndex = 9
Name = "btnCerrar"

*** METODOS ***
PROCEDURE Click
thisform.press_aceptar = .f.
thisform.Hide()
ENDPROC


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "CUIDADO: Este procedimiento generará facturas aleatoria a modo prueba."
Height = 14
Left = 12
Top = 12
Width = 467
TabIndex = 12
ForeColor = 255,0,0
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta14
************************************************************
*** PROPIEDADES ***
Caption = "Descuentos"
Height = 15
Left = 8
Top = 123
Width = 77
TabIndex = 14
Name = "Clsetiqueta14"

*** METODOS ***


************************************************************
OBJETO: txtDesc1
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 99
ReadOnly = .F.
TabIndex = 4
Top = 119
Width = 70
isnumeric = .T.
Name = "txtDesc1"

*** METODOS ***


************************************************************
OBJETO: txtDesc2
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 170
ReadOnly = .F.
TabIndex = 5
Top = 119
Width = 70
isnumeric = .T.
Name = "txtDesc2"

*** METODOS ***


************************************************************
OBJETO: txtDesc3
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 241
ReadOnly = .F.
TabIndex = 6
Top = 119
Width = 70
isnumeric = .T.
Name = "txtDesc3"

*** METODOS ***


************************************************************
OBJETO: txtDesc4
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 312
ReadOnly = .F.
TabIndex = 7
Top = 119
Width = 70
isnumeric = .T.
Name = "txtDesc4"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta24
************************************************************
*** PROPIEDADES ***
Caption = "Recargo %:"
Height = 15
Left = 8
Top = 100
Width = 70
TabIndex = 13
Name = "Clsetiqueta24"

*** METODOS ***


************************************************************
OBJETO: txtPorRec
************************************************************
*** PROPIEDADES ***
Enabled = .T.
Height = 21
Left = 99
TabIndex = 3
Top = 96
Width = 70
isnumeric = .T.
Name = "txtPorRec"

*** METODOS ***


************************************************************
OBJETO: _cls_debug_ingcbtes
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: _cls_debug_ingmerc
************************************************************
*** PROPIEDADES ***
DoCreate = .T.
Caption = "Testing Ingreso de Mercaderías"
press_aceptar = .F.
cant_rtos = 0
cant_items = 0
genera_nropart = .F.
Name = "_cls_debug_ingmerc"

*** METODOS ***


************************************************************
OBJETO: CLSETIQUETA1
************************************************************
*** PROPIEDADES ***
Caption = "Cantidad de Remitos:"
Height = 15
Left = 24
Top = 14
Width = 132
Name = "CLSETIQUETA1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Cantidad items a cargar:"
Height = 15
Left = 24
Top = 38
Width = 144
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: txtCantRtos
************************************************************
*** PROPIEDADES ***
Left = 180
Top = 10
isinteger = .T.
Name = "txtCantRtos"

*** METODOS ***


************************************************************
OBJETO: txtCantItems
************************************************************
*** PROPIEDADES ***
Left = 180
Top = 34
isinteger = .T.
Name = "txtCantItems"

*** METODOS ***


************************************************************
OBJETO: btnAceptar
************************************************************
*** PROPIEDADES ***
Top = 132
Left = 420
Name = "btnAceptar"

*** METODOS ***
PROCEDURE Click
IF Thisform.txtCantRtos.Value = 0 THEN
	MESSAGEBOX("La cantidad de remitos no puede ser cero", 0+48, Thisform.Caption)
	Thisform.txtCantRtos.SetFocus()
	RETURN .F.
ENDIF

IF Thisform.txtCantItems.Value = 0 THEN
	MESSAGEBOX("La cantidad de items no puede ser cero", 0+48, Thisform.Caption)
	Thisform.txtCantItems.SetFocus()
	RETURN .F.
ENDIF

Thisform.press_aceptar = .T.
Thisform.cant_rtos = Thisform.txtCantRtos.Value
Thisform.cant_items = Thisform.txtCantItems.Value
Thisform.genera_nropart = Thisform.chkGenerarPartida.Value

Thisform.Hide()
ENDPROC


************************************************************
OBJETO: btnCancelar
************************************************************
*** PROPIEDADES ***
Top = 132
Left = 468
Name = "btnCancelar"

*** METODOS ***
PROCEDURE Click
Thisform.press_aceptar = .F.
Thisform.Hide()
ENDPROC


************************************************************
OBJETO: chkGenerarPartida
************************************************************
*** PROPIEDADES ***
Top = 12
Left = 324
Height = 12
Width = 180
Alignment = 0
Caption = "Generar número de partida"
requerido = 0
Name = "chkGenerarPartida"

*** METODOS ***


************************************************************
OBJETO: _cls_debug_ingmerc
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


