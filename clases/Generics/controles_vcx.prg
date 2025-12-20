************************************************************
OBJETO: cls_ivavta_ivacpa
************************************************************
*** PROPIEDADES ***
BorderStyle = 2
Height = 384
Width = 585
DoCreate = .T.
Caption = "Controlar compras / ventas"
Name = "cls_ivavta_ivacpa"

*** METODOS ***
PROCEDURE obtener_totales_ventas
LOCAL loRes
LOCAL lcSql
LOCAL lnAnio
LOCAL lnMes

&& Obtengo el mes y año corriente
lnAnio = YEAR(DATE())
lnMes = MONTH(DATE())

loRes = CREATEOBJECT("odbc_result")
TEXT TO lcSql NOSHOW
	CALL ventascab_getIVAVtas_control (?anio, ?mes);
ENDTEXT
lcSql = loRes.AddParameter(lcSql, "anio", ALLTRIM(STR(lnAnio)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "mes", ALLTRIM(STR(lnMes)), .f., .f.)
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"
loRes.OpenQuery(lcSql)
SELECT cur_x
thisform.contenedor_ventas.txtTotNeto.Value = cur_x.totgrav_p21 + totgrav_p105
thisform.contenedor_ventas.txtTotIVA.Value = cur_x.totiva_21 + cur_x.totiva_105
thisform.contenedor_ventas.txtTotalVta.Value = cur_x.total
loRes.Close_Query()

ENDPROC
PROCEDURE obtener_totales_compras
LOCAL loRes
LOCAL lcSql
LOCAL lnAnio
LOCAL lnMes

&& Obtengo el mes y año corriente
lnAnio = YEAR(DATE())
lnMes = MONTH(DATE())

loRes = CREATEOBJECT("odbc_result")
TEXT TO lcSql NOSHOW
	CALL compras_libroIVA_control(?anio, ?mes);
ENDTEXT
lcSql = loRes.AddParameter(lcSql, "anio", ALLTRIM(STR(lnAnio)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "mes", ALLTRIM(STR(lnMes)), .f., .f.)
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"
loRes.OpenQuery(lcSql)
SELECT cur_x
thisform.contenedor_compras.txtTotNeto.value = cur_x.total_netograv
thisform.contenedor_compras.txtTotIVA.Value = cur_x.total_iva21 + cur_x.total_iva105 + cur_x.retIVA
thisform.contenedor_compras.txtTotalVta.Value = cur_x.total
loRes.Close_Query()

ENDPROC
PROCEDURE calcular_diferencias
this.contenedor_diferencias.txtDifNeto.Value ;
	= this.contenedor_ventas.txtTotNeto.Value - this.contenedor_compras.txtTotNeto.Value

this.contenedor_diferencias.txtDifIVA.Value ;
	= this.contenedor_ventas.txtTotIVA.Value - this.contenedor_compras.txtTotIVA.Value
	
this.contenedor_diferencias.txtDifVta.Value ;
	= this.contenedor_ventas.txtTotalVta.Value - this.contenedor_compras.txtTotalVta.Value
	
IF this.contenedor_diferencias.txtDifIVA.Value > 0 THEN
	this.contenedor_diferencias.lblResultado.ForeColor = RGB(255,0,0)
	this.contenedor_diferencias.lblResultado.Caption = "(+)"
ELSE
	this.contenedor_diferencias.lblResultado.ForeColor = RGB(0,128,0)
	this.contenedor_diferencias.lblResultado.Caption = "(-)"
ENDIF
ENDPROC
PROCEDURE Init
this.obtener_totales_ventas()
this.obtener_totales_compras()
this.calcular_diferencias()

ENDPROC


************************************************************
OBJETO: contenedor_ventas
************************************************************
*** PROPIEDADES ***
Top = 12
Left = 12
Width = 276
Height = 192
Name = "contenedor_ventas"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Ventas"
Height = 15
Left = 108
Top = 12
Width = 43
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Total Neto:"
Height = 15
Left = 12
Top = 54
Width = 72
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Total I.V.A.:"
Height = 15
Left = 12
Top = 78
Width = 72
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: txtTotNeto
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 84
ReadOnly = .T.
Top = 54
Width = 171
isnumeric = .T.
Name = "txtTotNeto"

*** METODOS ***


************************************************************
OBJETO: txtTotIVA
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 84
ReadOnly = .T.
Top = 77
Width = 171
isnumeric = .T.
Name = "txtTotIVA"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Total Venta:"
Height = 15
Left = 12
Top = 102
Width = 72
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: txtTotalVta
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 84
ReadOnly = .T.
Top = 100
Width = 171
isnumeric = .T.
Name = "txtTotalVta"

*** METODOS ***


************************************************************
OBJETO: contenedor_compras
************************************************************
*** PROPIEDADES ***
Top = 12
Left = 300
Width = 276
Height = 192
Name = "contenedor_compras"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Compras"
Height = 15
Left = 116
Top = 13
Width = 43
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Total Neto:"
Height = 15
Left = 20
Top = 55
Width = 72
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Total I.V.A.:"
Height = 15
Left = 20
Top = 79
Width = 72
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: txtTotNeto
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 92
ReadOnly = .T.
Top = 55
Width = 171
isnumeric = .T.
Name = "txtTotNeto"

*** METODOS ***


************************************************************
OBJETO: txtTotIVA
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 92
ReadOnly = .T.
Top = 78
Width = 171
isnumeric = .T.
Name = "txtTotIVA"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Total Venta:"
Height = 15
Left = 20
Top = 103
Width = 72
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: txtTotalVta
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 92
ReadOnly = .T.
Top = 101
Width = 171
isnumeric = .T.
Name = "txtTotalVta"

*** METODOS ***


************************************************************
OBJETO: Clscerrar1
************************************************************
*** PROPIEDADES ***
Top = 337
Left = 533
Name = "Clscerrar1"

*** METODOS ***


************************************************************
OBJETO: contenedor_diferencias
************************************************************
*** PROPIEDADES ***
Top = 207
Left = 12
Width = 564
Height = 129
Name = "contenedor_diferencias"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Diferencias"
Height = 15
Left = 8
Top = 4
Width = 76
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Total Neto:"
Height = 15
Left = 89
Top = 29
Width = 72
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Total I.V.A.:"
Height = 15
Left = 90
Top = 53
Width = 72
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: txtDifNeto
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 161
ReadOnly = .T.
Top = 29
Width = 171
isnumeric = .T.
Name = "txtDifNeto"

*** METODOS ***


************************************************************
OBJETO: txtDifIVA
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 161
ReadOnly = .T.
Top = 52
Width = 171
isnumeric = .T.
Name = "txtDifIVA"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Total Venta:"
Height = 15
Left = 89
Top = 77
Width = 72
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: txtDifVta
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 161
ReadOnly = .T.
Top = 75
Width = 171
isnumeric = .T.
Name = "txtDifVta"

*** METODOS ***


************************************************************
OBJETO: CLSETIQUETA5
************************************************************
*** PROPIEDADES ***
Caption = "Fórmula aplicada:"
Height = 12
Left = 351
Top = 9
Width = 108
Name = "CLSETIQUETA5"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta6
************************************************************
*** PROPIEDADES ***
Caption = "diferencia = venta - compras"
Height = 12
Left = 363
Top = 33
Width = 180
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: lblResultado
************************************************************
*** PROPIEDADES ***
FontSize = 30
Caption = "+/-"
Height = 48
Left = 16
Top = 34
Width = 60
ForeColor = 255,0,0
Name = "lblResultado"

*** METODOS ***


************************************************************
OBJETO: cls_ivavta_ivacpa
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_compra_venta
************************************************************
*** PROPIEDADES ***
Height = 702
Width = 833
DoCreate = .T.
Caption = "Control Compra y ventas"
WindowState = 0
Name = "cls_compra_venta"
Contenido.Top = 0
Contenido.Left = 0
Contenido.Width = 1026
Contenido.Height = 755
Contenido.Name = "Contenido"

*** METODOS ***
PROCEDURE configurar_grillas
*******************************
* Configuración de las grillas
*******************************
SELECT cur_compras
thisform.gridcompras.alias_name = "cur_compras"
thisform.gridcompras.RecordSource = "cur_compras"
thisform.gridcompras.list_controlsource = "anio, mes, total_iva, total_neto, total_compras"
thisform.gridcompras.lista_ancho_cols = "40, 40, 80, 80, 80"
thisform.gridcompras.titulos_cabeceras = "Año, Mes, Total IVA, Total Neto, Total"
thisform.gridcompras.generar_grid()

SELECT cur_ventas
thisform.gridventas.alias_name = "cur_ventas"
thisform.gridventas.RecordSource = "cur_ventas"
thisform.gridventas.list_controlsource = "anio, mes, total_neto_grav, total_IVA, total_ventas"
thisform.gridventas.lista_ancho_cols = "40, 40, 80, 80, 80"
thisform.gridventas.titulos_cabeceras = "Año, Mes, Total Neto, Total IVA, Total"
thisform.gridventas.generar_grid()

SELECT cur_resultado
thisform.gridresultado.alias_name = "cur_resultado"
thisform.gridresultado.RecordSource = "cur_resultado"
thisform.gridresultado.list_controlsource = "anio, mes, dif_neto, dif_total, dif_iva"
thisform.gridresultado.lista_ancho_cols = "40, 40, 80, 80, 80"
thisform.gridresultado.titulos_cabeceras = "Año, Mes, Dif. Neto, Dif. Total, Dif. IVA"
thisform.gridresultado.generar_grid()



thisform.gridresultado.SetAll("DynamicBackColor", "IIF(cur_resultado.dif_neto < 0 .or. cur_resultado.dif_total < 0 .or. cur_resultado.dif_iva < 0, ; 
RGB(244, 197, 168), RGB(255, 255, 255))")

ENDPROC
PROCEDURE Init
thisform.txtAnio.Value = 2020

oCompraVenta = CREATEOBJECT("cls_control_com_vent")

oCompraVenta.anio_desde = thisform.txtAnio.value
oCompraVenta.crear_cursor()

oCompraVenta.resultados_compra()
oCompraVenta.resultados_venta()
oCompraVenta.resultados_diferencia()

thisform.configurar_grillas()
ENDPROC


************************************************************
OBJETO: Container2
************************************************************
*** PROPIEDADES ***
Top = 84
Left = 10
Width = 812
Height = 605
BackColor = 255,255,255
Name = "Container2"

*** METODOS ***


************************************************************
OBJETO: gridcompras
************************************************************
*** PROPIEDADES ***
Height = 228
Left = 37
Top = 120
Width = 360
Name = "gridcompras"
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
OBJETO: gridventas
************************************************************
*** PROPIEDADES ***
Height = 228
Left = 36
Top = 384
Width = 360
Name = "gridventas"
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
OBJETO: gridresultado
************************************************************
*** PROPIEDADES ***
Height = 496
Left = 429
Top = 120
Width = 360
Name = "gridresultado"
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
PROCEDURE Init


ENDPROC


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Compras"
Left = 26
Top = 100
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Ventas"
Left = 26
Top = 368
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Resultado"
Left = 426
Top = 99
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: Cls_control_com_vent
************************************************************
*** PROPIEDADES ***
Top = 660
Left = 732
Name = "Cls_control_com_vent"

*** METODOS ***


************************************************************
OBJETO: Container1
************************************************************
*** PROPIEDADES ***
Top = 10
Left = 11
Width = 812
Height = 66
BackColor = 255,236,236
Name = "Container1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Año:"
Left = 27
Top = 34
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: txtAnio
************************************************************
*** PROPIEDADES ***
Left = 84
Top = 31
Name = "txtAnio"

*** METODOS ***


************************************************************
OBJETO: Clsbuscar1
************************************************************
*** PROPIEDADES ***
Top = 21
Left = 210
Height = 42
Width = 48
Name = "Clsbuscar1"

*** METODOS ***
PROCEDURE Click
oCompraVenta = CREATEOBJECT("cls_control_com_vent")

oCompraVenta.anio_desde = thisform.txtAnio.value

oCompraVenta.limpiar_cursor()

oCompraVenta.resultados_compra()
oCompraVenta.resultados_venta()

oCompraVenta.resultados_diferencia()

thisform.gridcompras.Refresh()
thisform.gridventas.Refresh()
thisform.gridresultado.Refresh()
ENDPROC


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
FontUnderline = .F.
Caption = "(*) Los campos marcados en rojo son aquellos que tienen al menos un valor negativo"
Height = 15
Left = 36
Top = 643
Width = 627
ColorSource = 4
ColorScheme = 1
ForeColor = 255,0,0
DisabledBackColor = 255,0,0
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: cls_compra_venta
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_control_com_vent
************************************************************
*** PROPIEDADES ***
anio_desde = .F.
Name = "cls_control_com_vent"

*** METODOS ***
PROCEDURE resultados_compra
********************************************
* Obtener resultados de la compra
********************************************
local loRes
local lcSql
loRes = createobject("odbc_result")

text to lcSql noshow
	CALL compras_getIvaAll (?p_anio);
endtext

lcSql = loRes.addParameter(lcSql, "p_anio", ALLTRIM(str(this.anio_desde)), .f., .f.)

loRes.ActiveConnection = goConn.ActiveConnection
loRes.cursor_Name = "cur_x"
loRes.OpenQuery(lcSql)

DO WHILE !EOF("cur_x")
	select cur_compras
		append blank
		replace cur_compras.anio with cur_x.anio
		replace cur_compras.mes with cur_x.mes additive
		replace cur_compras.total_IVA with cur_x.total_IVA additive
		replace cur_compras.total_neto with cur_x.total_neto additive
		replace cur_compras.total_compras with cur_x.total additive
	SELECT cur_x
	SKIP
enddo

loRes.close_query()
select cur_compras
go top
ENDPROC
PROCEDURE crear_cursor
*****************************************************************************
*Este método me permitirá crear los cursores para traer los datos de la base
*****************************************************************************

&& Creo el cursor que va a tener los resultados de compra
CREATE CURSOR cur_compras (	;
	anio			int,;
	mes				int,;
	total_IVA 		float(10,2),;
	total_Neto 		float(10, 2),;
	total_compras	float(10,2))

&& Creo el cursor que va a tener los resultados de venta
CREATE CURSOR cur_ventas (;
	anio			int,;
	mes				int,;
	total_Neto_grav	float(10, 2),;
	total_IVA 		float(10,2),;
	total_ventas	float(10,2))

&& Creo el cursor que va a tener los resultados 
CREATE CURSOR cur_resultado (;
	anio		int,;
	mes			int,;
	dif_neto 	float(10,2),;
	dif_total 	float(10, 2),;
	dif_iva		float(10,2))
ENDPROC
PROCEDURE limpiar_cursor
SELECT cur_compras
ZAP

SELECT cur_ventas
ZAP

SELECT cur_resultado
zap
ENDPROC
PROCEDURE resultados_venta
********************************************
* Obtener resultados de la venta
********************************************
local loRes
local lcSql
loRes = createobject("odbc_result")

text to lcSql noshow
	CALL IVA_Venta_para_estadisticas(?p_anio);
endtext

lcSql = loRes.addParameter(lcSql, "p_anio", ALLTRIM(str(this.anio_desde)), .f., .f.)

loRes.ActiveConnection = goConn.ActiveConnection
loRes.cursor_Name = "cur_x"
loRes.OpenQuery(lcSql)

DO WHILE !EOF("cur_x")
	select cur_ventas
		append blank
		replace cur_ventas.anio with cur_x.anio
		replace cur_ventas.mes with cur_x.mes additive
		replace cur_ventas.total_neto_grav with cur_x.total_neto_grav additive
		replace cur_ventas.total_iva with cur_x.total_iva additive
		replace cur_ventas.total_ventas with cur_x.total additive
	SELECT cur_x
	SKIP
enddo

loRes.close_query()
select cur_ventas
go top
ENDPROC
PROCEDURE resultados_diferencia
************************************
* Calcular diferencias
************************************
LOCAL lcVentasNeto, lcComprasNeto
LOCAL lcVentasIva, lcComprasIva
LOCAL lcVentasTotal, lcComprasTotal

lcVentasNeto = "total_neto_grav"
lcComprasNeto = "total_neto"

lcVentasIva = "total_iva"
lcComprasIva = "total_iva"

lcVentasTotal = "total_ventas"
lcComprasTotal = "total_compras"

SELECT ;    
	 V.anio, ;    
	 V.mes, ;    
	 (V.&lcVentasNeto - C.&lcComprasNeto) AS dif_neto, ;    
	 (V.&lcVentasTotal - C.&lcComprasTotal) AS dif_total, ;
	 (V.&lcVentasIva - C.&lcComprasIva) AS dif_iva ;    
FROM ;    
	Cur_Ventas V ;
INNER JOIN ;    
	Cur_Compras C ON V.anio  = C.anio AND V.Mes = C.Mes ;
INTO CURSOR cur_resumen ;
READWRITE

DO WHILE !EOF("cur_resumen")
	select cur_resultado
		append blank
		replace cur_resultado.anio with cur_resumen.anio
		replace cur_resultado.mes with cur_resumen.mes additive
		replace cur_resultado.dif_neto with cur_resumen.dif_neto additive
		replace cur_resultado.dif_total with cur_resumen.dif_total additive
		replace cur_resultado.dif_iva with cur_resumen.dif_iva additive
	SELECT cur_resumen
	SKIP
enddo
SELECT cur_resultado
GO top

RETURN .t.
ENDPROC


