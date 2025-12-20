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
OBJETO: FRMACTU_CATALOGO_LISTA
************************************************************
*** PROPIEDADES ***
BorderStyle = 2
Height = 185
Width = 585
DoCreate = .T.
Caption = "Actualización de Listas"
WindowState = 0
tipo_lista = ITUPER
Name = "FRMACTU_CATALOGO_LISTA"

*** METODOS ***
PROCEDURE Init
DODEFAULT()

Thisform.btnGrabar.Enabled = .F.
ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Descuento 1:"
Left = 12
Top = 36
TabIndex = 10
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Descuento 2:"
Left = 12
Top = 60
TabIndex = 11
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Descuento 3:"
Left = 12
Top = 83
TabIndex = 12
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Descuento 4:"
Left = 12
Top = 106
TabIndex = 13
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Margen Mayorista:"
Height = 15
Left = 204
Top = 37
Width = 115
TabIndex = 14
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta6
************************************************************
*** PROPIEDADES ***
Caption = "Margen Minorista:"
Height = 15
Left = 204
Top = 61
Width = 115
TabIndex = 15
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: txtDesc1
************************************************************
*** PROPIEDADES ***
Left = 98
TabIndex = 2
Top = 34
isnumeric = .T.
Name = "txtDesc1"

*** METODOS ***


************************************************************
OBJETO: txtDesc2
************************************************************
*** PROPIEDADES ***
Left = 98
TabIndex = 3
Top = 57
isnumeric = .T.
Name = "txtDesc2"

*** METODOS ***


************************************************************
OBJETO: txtDesc3
************************************************************
*** PROPIEDADES ***
Left = 98
TabIndex = 4
Top = 80
isnumeric = .T.
Name = "txtDesc3"

*** METODOS ***


************************************************************
OBJETO: txtDesc4
************************************************************
*** PROPIEDADES ***
Left = 98
TabIndex = 5
Top = 103
isnumeric = .T.
Name = "txtDesc4"

*** METODOS ***


************************************************************
OBJETO: txtMargenMay
************************************************************
*** PROPIEDADES ***
Left = 312
TabIndex = 6
Top = 34
isnumeric = .T.
Name = "txtMargenMay"

*** METODOS ***


************************************************************
OBJETO: txtMargenMin
************************************************************
*** PROPIEDADES ***
Left = 312
TabIndex = 7
Top = 57
isnumeric = .T.
Name = "txtMargenMin"

*** METODOS ***


************************************************************
OBJETO: btnGrabar
************************************************************
*** PROPIEDADES ***
Top = 137
Left = 489
TabIndex = 8
Name = "btnGrabar"

*** METODOS ***
PROCEDURE Click
LOCAL lcProcName

SELECT proveedor
lcProcName = ALLTRIM(proveedor.proc_name)

IF !(lcProcName == "") THEN
	DO &lcProcName WITH Thisform.selProv.valcpoid, Thisform.txtDesc1.Value, Thisform.txtDesc2.Value,; 
		Thisform.txtDesc3.Value, Thisform.txtDesc4.Value, Thisform.txtMargenMay.Value, Thisform.txtMargenMin.Value
ENDIF
ENDPROC


************************************************************
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 137
Left = 537
TabIndex = 9
Name = "btnCerrar"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta7
************************************************************
*** PROPIEDADES ***
Caption = "Proveedor:"
Left = 12
Top = 13
TabIndex = 16
Name = "Clsetiqueta7"

*** METODOS ***


************************************************************
OBJETO: selProv
************************************************************
*** PROPIEDADES ***
Top = 9
Left = 96
Width = 484
Height = 25
TabIndex = 1
nombre_tabla = proveedor
pkfield = idProv
nombre_campo_codigo = idProv
nombre_campo_desc = razSoc
autocompletar_ceros = .F.
esnumerico = .T.
Name = "selProv"
TXTCODIGO.Name = "TXTCODIGO"
TXTDESCRIPCION.Name = "TXTDESCRIPCION"

*** METODOS ***
PROCEDURE recuperar_datos
SELECT proveedor

IF ALLTRIM(proveedor.proc_name) == "" THEN
	MESSAGEBOX("Este proveedor no tiene software de catálogo asignado", 0+48, Thisform.Caption)
	Thisform.btnGrabar.Enabled = .F.
ELSE
	Thisform.btnGrabar.Enabled = .T.
ENDIF
ENDPROC


************************************************************
OBJETO: 
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


