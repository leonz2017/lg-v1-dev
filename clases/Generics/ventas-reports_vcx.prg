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


************************************************************
OBJETO: cls_form_ventasportipopago
************************************************************
*** PROPIEDADES ***
Height = 600
Width = 1075
DoCreate = .T.
Caption = "Ventas por tipo de pago"
Name = "cls_form_ventasportipopago"

*** METODOS ***
PROCEDURE llenar_grilla
LOCAL loRes
LOCAL lcSql
LOCAL lnIdTipoPago
LOCAL lnTotal

lnTotal = 0.00

loRes = CREATEOBJECT("odbc_result")

&& Filtro si va a traer TODOS los resultados o solo el seleccionado en el combo.
IF Thisform.contenedor1.contenedor_filtros.cbo_tipospagos.ListIndex = 1 THEN
	lnIdTipoPago = ALLTRIM(STR(0))
ELSE
	SELECT cur_tipospagos
	GO (Thisform.contenedor1.contenedor_filtros.cbo_tipospagos.ListIndex -1)
	lnIdTipoPago = ALLTRIM(STR(cur_tipospagos.idTipoPago))
ENDIF

&& Llamo al SP que me devuelve los resultados de la consulta.
lcSql = "CALL ventas_getByTipoPago(?xFechaDesde, ?xFechaHasta, ?xTipoPago)"
lcSql = loRes.AddParameter(lcSql, "xFechaDesde", This.contenedor1.Contenedor_filtros.txtFechaDesde.Value, .f., .t.)
lcSql = loRes.AddParameter(lcSql, "xFechaHasta", This.contenedor1.Contenedor_filtros.txtFechaHasta.Value, .f., .t.)
lcSql = loRes.AddParameter(lcSql, "xTipoPago", lnIdTipoPago , .f., .f.)
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"
loRes.OpenQuery(lcSql)

&& Asigno los valores al cursor.
SELECT cur_articulos
ZAP
APPEND FROM DBF("cur_x")
loRes.Close_Query()
SELECT cur_articulos
IF RECCOUNT("cur_articulos") > 0 THEN
	GO TOP
	This.contenedor1.grdArticulos.Refresh()
ELSE
	MESSAGEBOX("No se encontraron comprobantes", 0+48, Thisform.Caption)
ENDIF

&& Sumo los importes y lo asigno al total.
SELECT cur_articulos
DO WHILE !EOF("cur_articulos")
	lnTotal = lnTotal + cur_articulos.importe
	SKIP
ENDDO

thisform.contenedor1.txtTotal.Value = lnTotal
ENDPROC
PROCEDURE validar_datos
IF Thisform.contenedor1.contenedor_filtros.txtFechaDesde.Value = {} THEN
	MESSAGEBOX("Debe ingresar la fecha desde", 0+48, This.Caption)
	Thisform.contenido.txtFecDesde.SetFocus()
	RETURN .F.	
ENDIF

IF Thisform.contenedor1.contenedor_filtros.txtFechaHasta.Value = {} THEN
	MESSAGEBOX("Debe ingresar la fecha hasta", 0+48, This.Caption)
	Thisform.contenido.txtFecHasta.SetFocus()
	RETURN .F.
ENDIF

RETURN .T.
ENDPROC
PROCEDURE cambiar_estado_botones
PARAMETERS tlEstado

thisform.contenedor1.clsexcel1.Enabled = tlEstado
ENDPROC
PROCEDURE llenar_cbo_tipospagos
************************************************************
* Permite llenar el combobox de tipos de pagos.
* Fecha: 26/05/2025
************************************************************

&& Agrego como primer valor del combo la opción "TODOS"
Thisform.contenedor1.contenedor_filtros.cbo_tipospagos.AddItem("TODOS", 1)

&& Obtengo todos los tipos de pagos y los cargo en el combo.
Thisform.get_tipospagos()
SELECT cur_tipospagos
GO TOP
DO WHILE !EOF("cur_tipospagos")
	Thisform.contenedor1.contenedor_filtros.cbo_tipospagos.AddItem(ALLTRIM(cur_tipospagos.descripcio), (cur_tipospagos.idTipoPago + 1))
	SELECT cur_tipospagos
	SKIP
ENDDO

SELECT cur_tipospagos
GO TOP
Thisform.contenedor1.contenedor_filtros.cbo_tipospagos.ListIndex = 1
ENDPROC
PROCEDURE get_tipospagos
******************************************************
* Permite recuperar los tipos de pagos.
* Fecha: 26/05/2025
******************************************************
LOCAL lcSql
LOCAL loRes

loRes = CREATEOBJECT("odbc_result")
lcSql = ""

TEXT TO lcSql NOSHOW
	SELECT
		idTipoPago,
		codTipoPag,
		descripcio
	FROM
		tipospagos
ENDTEXT

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"
loRes.OpenQuery(lcSql)
SELECT cur_tipospagos
APPEND FROM DBF("cur_x")
loRes.Close_Query()

SELECT cur_tipospagos
GO TOP
ENDPROC
PROCEDURE Load
DODEFAULT()
&& Creo el cursor donde voy a guardar los resultados de los artículos
CREATE CURSOR cur_articulos ( ;
	idCliente int,;
	razSoc varchar(60),;
	nroRec varchar(60),;
	fecAlta date,;
	usuAlta varchar(60),;
	idHostAlta varchar(60),;
	importe n(20,2),;
	descripcio varchar(200))
	
* Creo el cursor para mostrar los tipos de pago en el desplegable.
CREATE CURSOR cur_tipospagos ( ;
	idTipoPago int,;
	codTipoPag varchar(10),;
	descripcio varchar(200))
ENDPROC
PROCEDURE Init
&& Cargo el cbo
Thisform.llenar_cbo_tipospagos()

&& Configuro la grilla
SELECT cur_articulos
This.contenedor1.grdArticulos.alias_name = "cur_articulos"
This.contenedor1.grdArticulos.RecordSource = "cur_articulos"
This.contenedor1.grdArticulos.list_controlsource = "idCliente,razSoc,nroRec,fecAlta,usuAlta,idHostAlta,descripcio,importe"
This.contenedor1.grdArticulos.lista_ancho_cols = "50,325,90,70,60,200,135,70"
This.contenedor1.grdArticulos.titulos_cabeceras = "Cliente,Razón Social,Número,Fecha Emis.,Usuario,Host,Tipo de Pago,Importe"
This.contenedor1.grdArticulos.generar_grid()

&& Establezco la fecha predeterminada
This.contenedor1.Contenedor_filtros.txtFechaDesde.Value = DATE()
This.contenedor1.Contenedor_filtros.txtFechaHasta.Value = DATE()

&& Deshabilito los botones por defecto
Thisform.cambiar_estado_botones(.f.)

&& Valor total por defecto
Thisform.contenedor1.txtTotal.Value = 0.00
	

ENDPROC


************************************************************
OBJETO: Contenedor1
************************************************************
*** PROPIEDADES ***
Top = -1
Left = -3
Width = 1100
Height = 620
BackColor = 241,236,235
Name = "Contenedor1"

*** METODOS ***


************************************************************
OBJETO: grdArticulos
************************************************************
*** PROPIEDADES ***
Height = 394
Left = 19
Top = 123
Width = 1040
Name = "grdArticulos"
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
OBJETO: Clscancelar1
************************************************************
*** PROPIEDADES ***
Top = 540
Left = 939
Height = 48
Width = 48
TabIndex = 6
Name = "Clscancelar1"

*** METODOS ***
PROCEDURE Click
Thisform.cambiar_estado_botones(.f.)

&& Asigno los valores por defecto
Thisform.contenedor1.contenedor_filtros.txtFechaDesde.Value = DATE()
Thisform.contenedor1.contenedor_filtros.txtFechaHasta.Value = DATE()
Thisform.contenedor1.contenedor_filtros.cbo_tipospagos.ListIndex = 1
Thisform.contenedor1.txtTotal.Value = 0.00

&& Limpio el grid
SELECT cur_articulos
ZAP
Thisform.contenedor1.grdArticulos.Refresh()
ENDPROC


************************************************************
OBJETO: Clsexcel1
************************************************************
*** PROPIEDADES ***
Top = 540
Left = 203
Height = 48
Width = 48
TabIndex = 5
Name = "Clsexcel1"

*** METODOS ***
PROCEDURE Click
SELECT cur_articulos
genexcel("cur_articulos","VENTAS")
ENDPROC


************************************************************
OBJETO: CLSCERRAR1
************************************************************
*** PROPIEDADES ***
Top = 540
Left = 1006
Height = 48
Width = 48
TabIndex = 7
Name = "CLSCERRAR1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Total: "
Height = 29
Left = 27
Top = 554
Width = 84
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: txtTotal
************************************************************
*** PROPIEDADES ***
Height = 24
Left = 63
ReadOnly = .T.
Top = 550
Width = 97
isdatetime = .F.
Name = "txtTotal"

*** METODOS ***


************************************************************
OBJETO: contenedor_filtros
************************************************************
*** PROPIEDADES ***
Top = 10
Left = 17
Width = 1042
Height = 84
BackColor = 240,240,240
Name = "contenedor_filtros"

*** METODOS ***


************************************************************
OBJETO: clsfecha
************************************************************
*** PROPIEDADES ***
Caption = "Fecha desde: "
Height = 29
Left = 21
Top = 57
Width = 84
Name = "clsfecha"

*** METODOS ***


************************************************************
OBJETO: clstipopago
************************************************************
*** PROPIEDADES ***
Caption = "Tipo de Pago: "
Height = 26
Left = 20
Top = 16
Width = 84
Name = "clstipopago"

*** METODOS ***


************************************************************
OBJETO: txtFechaDesde
************************************************************
*** PROPIEDADES ***
Height = 24
Left = 116
TabIndex = 2
Top = 54
Width = 97
isdatetime = .T.
Name = "txtFechaDesde"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Fecha hasta: "
Height = 29
Left = 234
Top = 57
Width = 84
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: txtFechaHasta
************************************************************
*** PROPIEDADES ***
Height = 24
Left = 319
TabIndex = 3
Top = 54
Width = 98
isdatetime = .T.
Name = "txtFechaHasta"

*** METODOS ***


************************************************************
OBJETO: Clsbuscar1
************************************************************
*** PROPIEDADES ***
Top = 17
Left = 970
Height = 48
Width = 48
TabIndex = 4
Name = "Clsbuscar1"

*** METODOS ***
PROCEDURE Click
IF Thisform.validar_datos() THEN
	Thisform.llenar_grilla()
	Thisform.cambiar_estado_botones(.t.)
ENDIF
ENDPROC


************************************************************
OBJETO: cbo_tipospagos
************************************************************
*** PROPIEDADES ***
Height = 24
Left = 117
TabIndex = 1
Top = 8
Width = 157
Name = "cbo_tipospagos"

*** METODOS ***


************************************************************
OBJETO: cls_form_ventasportipopago
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_form_totalventas
************************************************************
*** PROPIEDADES ***
Height = 550
Width = 1000
DoCreate = .T.
Caption = "Listado total de ventas"
Name = "cls_form_totalventas"

*** METODOS ***
PROCEDURE cambiar_estado_botones
PARAMETERS tlEstado

thisform.contenido.clsexcel1.Enabled = tlEstado
thisform.contenido.clsimprimir1.Enabled = tlEstado
ENDPROC
PROCEDURE llenar_grilla
LOCAL loRes
LOCAL lcSql

loRes = CREATEOBJECT("odbc_result")

&& Llamo al SP que me devuelve los resultados de la consulta.
lcSql = "CALL articulos_getTotVendidoDesc(?xidArticulo, ?xFechaDesde, ?xFechaHasta)"
lcSql = loRes.AddParameter(lcSql, "xidArticulo", ALLTRIM(STR(Thisform.contenido.sel_ARTICULO.valcpoid)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "xFechaDesde",Thisform.contenido.txtfecDesde.Value, .f., .t.)
lcSql = loRes.AddParameter(lcSql, "xFechaHasta", Thisform.contenido.txtfecHasta.Value, .f., .t.)
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"
loRes.OpenQuery(lcSql)
SELECT cur_cbtes
ZAP
APPEND FROM DBF("cur_x")
loRes.Close_Query()
SELECT cur_cbtes
IF RECCOUNT("cur_cbtes") > 0 THEN
	GO TOP
	This.contenido.grdVentas.Refresh()
ELSE
	MESSAGEBOX("No se encontraron comprobantes", 0+48, Thisform.Caption)
ENDIF
ENDPROC
PROCEDURE validar_datos
*!*	IF 	Thisform.contenido.sel_ARTICULO.valcpoid = 0 THEN
*!*		MESSAGEBOX("Debe seleccionar un artículo. Si no recuerda el código presione F1", 0+48, This.Caption)
*!*		Thisform.contenido.sel_ARTICULO.txtCodigo.SetFocus()
*!*		RETURN .F.
*!*	ENDIF

IF Thisform.contenido.txtFecDesde.Value = {} THEN
	MESSAGEBOX("Debe ingresar la fecha desde", 0+48, This.Caption)
	Thisform.contenido.txtFecDesde.SetFocus()
	RETURN .F.	
ENDIF

IF Thisform.contenido.txtFecHasta.Value = {} THEN
	MESSAGEBOX("Debe ingresar la fecha hasta", 0+48, This.Caption)
	Thisform.contenido.txtFecHasta.SetFocus()
	RETURN .F.
ENDIF

RETURN .T.
ENDPROC
PROCEDURE cargar_total
LOCAL loRes
LOCAL lcSql

loRes = CREATEOBJECT("odbc_result")

&& Llamo al SP que me devuelve el total vendido y el total de importe vendido.
lcSql = "CALL articulos_getTotVendido(?xidArticulo, ?xFechaDesde, ?xFechaHasta)"
lcSql = loRes.AddParameter(lcSql, "xidArticulo", ALLTRIM(STR(Thisform.contenido.sel_ARTICULO.valcpoid)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "xFechaDesde",Thisform.contenido.txtfecDesde.Value, .f., .t.)
lcSql = loRes.AddParameter(lcSql, "xFechaHasta", Thisform.contenido.txtfecHasta.Value, .f., .t.)
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"
loRes.OpenQuery(lcSql)
SELECT cur_total
ZAP
APPEND FROM DBF("cur_x")
loRes.Close_Query()

&& Cargo los campos.
SELECT cur_total
IF RECCOUNT("cur_cbtes") > 0 THEN
	GO TOP
	Thisform.contenido.txtVtotal.Value = cur_total.vtotal
	Thisform.contenido.txtVtotalImporte.Value = cur_total.importe_total
&&ELSE
&&	MESSAGEBOX("No se encontraron comprobantes", 0+48, Thisform.Caption)
ENDIF
ENDPROC
PROCEDURE Init
&& Configuro la grilla
SELECT cur_cbtes
This.contenido.grdVentas.alias_name = "cur_cbtes"
This.contenido.grdVentas.RecordSource = "cur_cbtes"
This.contenido.grdVentas.list_controlsource = "codigo,cliente,fecemis,cbte,cantidad,importe"
This.contenido.grdVentas.lista_ancho_cols = "150,350,150,150,75,125"
This.contenido.grdVentas.titulos_cabeceras = "Codigo,Cliente,Fecha de Emisión,Tipo de Comprobante,Cantidad,Importe"
This.contenido.grdVentas.generar_grid()

&& Establezco la fecha predeterminada
This.contenido.txtFecDesde.Value = DATE() - 30
This.contenido.txtFecHasta.Value = DATE()

&& Deshabilito los botones por defecto
Thisform.cambiar_estado_botones(.f.)
ENDPROC
PROCEDURE Load
DODEFAULT()
&& Creo el cursor donde voy a guardar los resultados
CREATE CURSOR cur_cbtes ( ;
	codigo varchar(60),;
	cliente varchar(60),;
	fecemis D,;
	cbte varchar(20),;
	descripcion varchar(200),;
	cantidad N(20, 2),;
	importe N(20,2))

CREATE CURSOR cur_total ( ;
	vtotal N(20, 2),;
	importe_total N(20, 2))
ENDPROC


************************************************************
OBJETO: contenido
************************************************************
*** PROPIEDADES ***
Anchor = 15
Top = -1
Left = -1
Width = 1100
Height = 560
BackColor = 241,236,235
Name = "contenido"

*** METODOS ***


************************************************************
OBJETO: labArticulo
************************************************************
*** PROPIEDADES ***
Caption = "Artículo: "
Height = 12
Left = 16
Top = 28
Width = 48
Name = "labArticulo"

*** METODOS ***


************************************************************
OBJETO: labFecDesde
************************************************************
*** PROPIEDADES ***
Caption = "Fecha desde: "
Height = 12
Left = 15
Top = 67
Width = 74
Name = "labFecDesde"

*** METODOS ***


************************************************************
OBJETO: labFecHasta
************************************************************
*** PROPIEDADES ***
Caption = "Fecha hasta: "
Height = 12
Left = 215
Top = 67
Width = 73
Name = "labFecHasta"

*** METODOS ***


************************************************************
OBJETO: txtFecDesde
************************************************************
*** PROPIEDADES ***
Height = 24
Left = 96
Top = 61
Width = 98
isdatetime = .T.
Name = "txtFecDesde"

*** METODOS ***


************************************************************
OBJETO: txtFecHasta
************************************************************
*** PROPIEDADES ***
Height = 24
Left = 296
Top = 61
Width = 97
isdatetime = .T.
Name = "txtFecHasta"

*** METODOS ***


************************************************************
OBJETO: grdVentas
************************************************************
*** PROPIEDADES ***
Height = 300
Left = 13
Top = 109
Width = 972
Name = "grdVentas"
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
OBJETO: Clsexcel1
************************************************************
*** PROPIEDADES ***
Top = 486
Left = 36
Height = 48
Width = 48
Name = "Clsexcel1"

*** METODOS ***
PROCEDURE Click
SELECT cur_cbtes
genexcel("cur_cbtes","TOTAL DE ARTÍCULOS VENDIDOS")
ENDPROC


************************************************************
OBJETO: CLSCERRAR1
************************************************************
*** PROPIEDADES ***
Top = 487
Left = 927
Height = 48
Width = 48
Alignment = 1
Name = "CLSCERRAR1"

*** METODOS ***


************************************************************
OBJETO: Clsimprimir1
************************************************************
*** PROPIEDADES ***
Top = 486
Left = 96
Height = 48
Width = 48
Name = "Clsimprimir1"

*** METODOS ***
PROCEDURE Click
LOCAL m.codart, m.descripcion
LOCAL m.fecDesde, m.fecHasta
LOCAL m.total

m.codart = ALLTRIM(Thisform.contenido.sel_Articulo.txtCodigo.Value)
m.descripcion = ALLTRIM(Thisform.contenido.sel_Articulo.txtdescripcion.Value)
m.fecDesde = Thisform.Contenido.txtFecDesde.Value
m.totalCantidad = ALLTRIM(STR(Thisform.Contenido.txtVtotal.Value))
m.totalImporte = ALLTRIM(STR(Thisform.Contenido.txtvtotalImporte.Value))

SELECT cur_cbtes
REPORT FORM "rep_vtasporarticulo" PREVIEW 
ENDPROC


************************************************************
OBJETO: Clscancelar1
************************************************************
*** PROPIEDADES ***
Top = 488
Left = 867
Height = 48
Width = 48
Alignment = 1
Name = "Clscancelar1"

*** METODOS ***
PROCEDURE Click
Thisform.cambiar_estado_botones(.f.)

Thisform.contenido.txtFecDesde.Value = DATE() - 30
Thisform.contenido.txtFecHasta.Value = DATE()
Thisform.contenido.sel_ARTICULO.TxtCodigo.Value = " "
Thisform.contenido.sel_ARTICULO.txtDescripcion.Value = " "
Thisform.contenido.txtvtotal.Value = " "

SELECT cur_cbtes
ZAP
Thisform.contenido.grdVentas.Refresh()
ENDPROC


************************************************************
OBJETO: sel_Articulo
************************************************************
*** PROPIEDADES ***
Top = 23
Left = 93
Width = 496
Height = 25
TabIndex = 3
nombre_campo_codigo = codArt
nombre_campo_desc = descripcio
nombre_tabla = articulos
pkfield = idArticulo
autocompletar_ceros = .F.
esnumerico = .F.
Name = "sel_Articulo"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***
PROCEDURE recuperar_datos
SELECT articulos

ENDPROC


************************************************************
OBJETO: Clsbuscar1
************************************************************
*** PROPIEDADES ***
Top = 37
Left = 925
Height = 48
Width = 48
Picture = ..\imagen\iconos bajados\buscar-buscar-ampliar-icono-9630.ico
Name = "Clsbuscar1"

*** METODOS ***
PROCEDURE Click
IF Thisform.validar_datos() THEN
	Thisform.llenar_grilla()
	Thisform.cargar_total()
	Thisform.cambiar_estado_botones(.t.)
ENDIF




ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Total cantidad vendida:"
Height = 12
Left = 476
Top = 442
Width = 129
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: txtVtotal
************************************************************
*** PROPIEDADES ***
Height = 24
Left = 608
ReadOnly = .T.
Top = 437
Width = 96
Name = "txtVtotal"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Total importe vendido:"
Height = 12
Left = 730
Top = 442
Width = 129
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: txtVtotalImporte
************************************************************
*** PROPIEDADES ***
Height = 24
Left = 862
ReadOnly = .T.
Top = 435
Width = 96
Name = "txtVtotalImporte"

*** METODOS ***


************************************************************
OBJETO: cls_form_totalventas
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_form_rankings
************************************************************
*** PROPIEDADES ***
BorderStyle = 2
Height = 223
Width = 600
DoCreate = .T.
Caption = "Genrador de Rankings de Ventas"
titulo = 
titulo_grupo = 
es_ranking_articulos = .F.
Name = "cls_form_rankings"
contenido.Comment = ""
contenido.Top = -12
contenido.Left = 0
contenido.Name = "contenido"

*** METODOS ***
PROCEDURE calcular_ranking_v1
* option1 = clientes
* option2 = proveedores
* option3 = marcas
* option4 = subfamilia

LOCAL loRes, loDT, loTherm, lcSql
LOCAL lImpTotal, lcFileName

loRes = CREATEOBJECT("odbc_result")
loTherm = CREATEOBJECT("_thermometer")
loDT = CREATEOBJECT("datetime")
lImpTotal = 0.00
lcFileName = ""

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
				
			    this.titulo = "SUB-FAMILIAS"
			    this.titulo_grupo = "SUB-FAMILIA:"	
			    
		ELSE
			IF thisform.contenido.opt_group.option5.Value = 1 THEN
			
				&& Llamo al SP que me devuelve los resultados de la consulta.
				lcSql = "CALL ranking_Articulos(?x_SeparoPorMes, ?x_fechaInicio, ?x_fechaFin)"
				lcSql = loRes.AddParameter(lcSql, "x_SeparoPorMes", ALLTRIM(STR(thisform.contenido.chkDetalleMes.Value)), .f., .f.)
				lcSql = loRes.AddParameter(lcSql, "x_fechaInicio",thisform.contenido.txtFecDesde.Value, .f., .t.)
				lcSql = loRes.AddParameter(lcSql, "x_fechaFin", thisform.contenido.txtFecHasta.Value, .f., .t.)
				loRes.ActiveConnection = goConn.ActiveConnection
				loRes.Cursor_Name = "cur_x"
				loRes.OpenQuery(lcSql)
				
				SELECT cur_rank_art
				ZAP
				APPEND FROM DBF("cur_x")
				loRes.Close_Query()
				
				&& Mando el Excel
				IF RECCOUNT("cur_rank_art") > 0 THEN
					SELECT cur_rank_art
					GO TOP
					
					SELECT codart, descripcio, cantidad FROM cur_rank_art ORDER BY cantidad DESC INTO CURSOR cur_temp
			
					genexcel("cur_temp","TOTAL DE ARTÍCULOS VENDIDOS")

					RETURN .T.
				ELSE
					MESSAGEBOX("No se encontraron artículos", 0+48, Thisform.Caption)
				ENDIF						
			ENDIF
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
SELECT cur_ranking
ZAP

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

RETURN .T.
ENDPROC
PROCEDURE calcular_ranking_v2
**********************************************************************
* Permite calcular los rankings de ventas según el SP ranking_ventas
* En ésta versión se centraliza todo en un solo proceso.
**********************************************************************
LOCAL loRes, loTherm, loDT, lcSql, lcErrorMessage
LOCAL lnImpTotal, lcTipoRanking, lnDetalleMes, lnInlcuirIVA
LOCAL ldFechaInicio, ldFechaFin, llEsRankingArticulo, llOk

STORE "" TO lcSql, lcErrorMessage, lcTipoRanking, lcOpcion
STORE 0.00 TO lnImpTotal
STORE .F. TO This.es_ranking_articulos, llOk

ldFechaInicio = Thisform.contenido.txtFecDesde.Value
ldFechaFin = Thisform.contenido.txtFecHasta.Value
lnDetalleMes = Thisform.contenido.chkDetalleMes.Value
lnInlcuirIVA = Thisform.contenido.chk_importe_con_iva.Value

DO CASE
	CASE Thisform.contenido.opt_group.option1.Value = 1
		lcTipoRanking = "clientes"
		This.titulo = "Clientes"
		This.titulo_grupo = "Cliente:"
	CASE Thisform.contenido.opt_group.option2.Value = 1
		lcTipoRanking = "proveedores"
		This.titulo = "Proveedores"
		This.titulo_grupo = "Proveedor:"
	CASE Thisform.contenido.opt_group.option3.Value = 1
		lcTipoRanking = "marcas"
		This.titulo = "Marcas"
		This.titulo_grupo = "Marca:"
	CASE Thisform.contenido.opt_group.option4.Value = 1
		lcTipoRanking = "subfamilias"
		This.titulo = "Subfamilias"
		This.titulo_grupo = "Subfamilia:"
	CASE Thisform.contenido.opt_group.option5.Value = 1
		lcTipoRanking = "articulos"
		This.es_ranking_articulos = .T.
		This.titulo = "Artículos"
		This.titulo_grupo = "Artículo:"
ENDCASE

TRY
	loRes = CREATEOBJECT("odbc_result")	
	loTherm = CREATEOBJECT("_thermometer")
	loDT = CREATEOBJECT("datetime")
	
	&& Limpio los cursores
	SELECT cur_rank_art
	ZAP
	SELECT cur_ranking
	ZAP	
	
	TEXT TO lcSql NOSHOW PRETEXT 15
		CALL ranking_ventas(?pTipoRanking, ?pDetalleMes, ?pFechaInicio, ?pFechaFin, ?pIncluirIVA)	
	ENDTEXT
	
	lcSql = loRes.AddParameter(lcSql, "pTipoRanking", ALLTRIM(lcTipoRanking), .T., .F.)
	lcSql = loRes.AddParameter(lcSql, "pDetalleMes", ALLTRIM(STR(lnDetalleMes)), .F., .F.)
	lcSql = loRes.AddParameter(lcSql, "pFechaInicio", ldFechaInicio, .F., .T.)
	lcSql = loRes.AddParameter(lcSql, "pFechaFin", ldFechaFin, .F., .T.)
	lcSql = loRes.AddParameter(lcSql, "pIncluirIVA", ALLTRIM(STR(lnInlcuirIVA)), .F., .F.)

	loRes.ActiveConnection = goConn.ActiveConnection
	loRes.Cursor_Name = "cur_x"
	
	IF !loRes.OpenQuery(lcSql) THEN
		MESSAGEBOX("Error al ejecutar el procedimiento: " + lcSql, 0+48, Thisform.Caption)
		llOk = .F.
	ELSE
		llOk = .T.
	ENDIF
	
	IF llOk THEN
		SELECT cur_x	
		IF RECCOUNT("cur_x") = 0 THEN
			MESSAGEBOX("No hay registros para mostrar", 0+64, Thisform.Caption)
			llOk = .F.
		ENDIF	
	
		IF This.es_ranking_articulos THEN
			&& Si es ranking de artículos lo guardo en cur_rank_art ya que el reporte está
			&& apuntando a ese cursor.
			SELECT cur_rank_art
			GO TOP
			APPEND FROM DBF("cur_x")
			
			SELECT cur_rank_art
			GO TOP
		ELSE
			&& Paso por acá si no es ranking de artículos.
			
			loTherm.show()
			
			&& Calculo el total de ventas
			SELECT ROUND(SUM(cur_x.importe), 2) AS total FROM cur_x INTO CURSOR cur_total
			lnImpTotal = cur_total.total			
			
			SELECT cur_x
			GO TOP
			DO WHILE !EOF("cur_x")
				SELECT cur_ranking
				APPEND BLANK
				REPLACE cur_ranking.codigo WITH cur_x.codigo
				REPLACE cur_ranking.descripcio WITH cur_x.descripcio ADDITIVE
				REPLACE cur_ranking.importe WITH cur_x.importe ADDITIVE
				
				IF lnDetalleMes = 1 THEN
					* Si hay que dividir por mes, completo los campos.
					REPLACE cur_ranking.anio WITH cur_x.anio ADDITIVE
					REPLACE cur_ranking.mes WITH loDT.getNombreMes(cur_x.mes) ADDITIVE
				ELSE
					REPLACE cur_ranking.porVta WITH (cur_x.importe * 100) / lnImpTotal ADDITIVE
				ENDIF
				
				&& Sumo al progressbar y paso al siguiente registro
				loTherm.update((RECNO("cur_x") * 100) / RECCOUNT("cur_x"), "Generando reporte, aguarde por favor...")			
				SELECT cur_x
				SKIP
			ENDDO
			
			loTherm.complete()
			SELECT cur_ranking
			GO TOP
		ENDIF
	ENDIF
	
	llOk = .T.
CATCH TO oException
	_cliptext = lcSql
	llOk = .F.
	lcErrorMessage = getErrorForCatch(oException)
	MESSAGEBOX(lcErrorMessage, 0+48, Thisform.Caption)
FINALLY
	loRes.Close_Query()
	
	IF USED("cur_total") THEN
		USE IN cur_total
	ENDIF
	
	RELEASE loRes
	RELEASE loTherm
ENDTRY

RETURN llOk



ENDPROC
PROCEDURE exportar_a_excel
************************************************************************************
* Este método permite exportar a Excel los rankings según la selección.
************************************************************************************


m.fechaDD = thisform.contenido.txtFecDesde.Value
m.fechaHH = thisform.contenido.txtFecHasta.Value

lcFileName = PUTFILE("Guardar como", "", "xls")

IF !This.es_ranking_articulos THEN
	&& Paso por acá si no es ranking de artículos
	
	SELECT cur_ranking
	GO TOP

	IF !(ALLTRIM(lcFileName) == "") THEN
		Exp2Excel("cur_ranking", lcFileName, this.titulo)
	ENDIF
ELSE
	&& Exportación para ranking de artículos
	
	SELECT cur_rank_art
	GO TOP

	IF !(ALLTRIM(lcFileName) == "") THEN
		Exp2Excel("cur_rank_art", lcFileName, this.titulo)
	ENDIF
ENDIF
ENDPROC
PROCEDURE mostrar_vista_previa
***************************************************************************
* Permite mostrar la vista previa y enviar a imprimir en caso de
* requerirlo.
***************************************************************************

LOCAL m.fechaDD, m.fechaHH, m.titulo, m.titulo_grupo

m.fechaDD = thisform.contenido.txtFecDesde.Value
m.fechaHH = thisform.contenido.txtFecHasta.Value
m.titulo = This.titulo
m.titulo_grupo = this.titulo_grupo

IF This.es_ranking_articulos THEN
	&& Si es un ranking de artículos llama al reporte que se comunica con el
	&& cursor cur_rank_art
	SELECT cur_rank_art
	GO TOP
	
	IF thisform.contenido.chkDetalleMes.Value = 1 THEN
		REPORT FORM "rep_ranking_art" TO PRINTER PROMPT PREVIEW
	ELSE
		REPORT FORM "rep_ranking_art_2" TO PRINTER PROMPT PREVIEW
	ENDIF
ELSE
	&& Para el resto de los rankings
	SELECT cur_ranking
	GO TOP	
	
	IF thisform.contenido.chkDetalleMes.Value = 1 THEN
		REPORT FORM "rep_rankings" TO PRINTER PROMPT PREVIEW
	ELSE
		REPORT FORM "rep_rankings_2" TO PRINTER PROMPT PREVIEW
	ENDIF
ENDIF
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

CREATE CURSOR cur_rank_art ( ;
	idarticulo	int,;
	codart		varchar(10),;
	descripcio	varchar(60),;
	cantidad	int,;
	importe int,;
	anio		int,;
	mes			varchar(20))
ENDPROC
PROCEDURE Init
thisform.contenido.txtFecDesde.Value = DATE() -30
thisform.contenido.txtFecHasta.Value = DATE()
ENDPROC


************************************************************
OBJETO: opt_group
************************************************************
*** PROPIEDADES ***
ButtonCount = 5
Height = 35
Left = 1
Top = 11
Width = 600
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
Option4.Left = 390
Option4.Top = 8
Option4.Width = 89
Option4.ForeColor = 158,106,75
Option4.Name = "Option4"
Option5.FontBold = .T.
Option5.FontSize = 8
Option5.Caption = "Artículo"
Option5.Height = 17
Option5.Left = 491
Option5.Top = 8
Option5.Width = 61
Option5.ForeColor = 158,106,75
Option5.Name = "Option5"

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
*****************************************************************
* Muestro vista previa para enviar a imprimir el comprobante.
*****************************************************************
IF Thisform.calcular_ranking_v2() THEN
	Thisform.mostrar_vista_previa()
ENDIF
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
****************************************************************
* Permite exportar los ranking de ventas a Excel
****************************************************************
IF Thisform.calcular_ranking_v2()
	Thisform.exportar_a_excel()
ENDIF
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
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Generar ranking de:"
Height = 15
Left = 6
Top = 20
Width = 115
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: chk_importe_con_iva
************************************************************
*** PROPIEDADES ***
Top = 86
Left = 157
Height = 18
Width = 203
Alignment = 0
Caption = "Calcular sobre importe con IVA"
Name = "chk_importe_con_iva"

*** METODOS ***


************************************************************
OBJETO: cls_form_rankings
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


