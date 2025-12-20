************************************************************
OBJETO: cls_ordtrab_dal
************************************************************
*** PROPIEDADES ***
mensaje = 
facturado = .F.
id_cliente = 0
detalle = 
cantidad = 0
fecha = 
precio = 0
usuario = 
host = 
active_connection = 
mensaje_error = 
id_orden = 0
Name = "cls_ordtrab_dal"

*** METODOS ***
PROCEDURE insert
*******************************************************************
* Permite insertar un registro de orden de trabajo
* Fecha: 28/12/2023
*******************************************************************
LOCAL loRes
LOCAL lcSql

loRes = CREATEOBJECT("odbc_result")
loRes.ActiveConnection = this.active_connection

TEXT TO lcSql NOSHOW
	CALL ordtrabajo_insert (
		?xidCliente, ?xFecha, ?xCantidad,
		?xDetalle, ?xPrecio, ?xFacturado,
		?xusuario, ?xhost)

ENDTEXT
lcSql = loRes.AddParameter(lcSql, "xidCliente", ALLTRIM(STR(this.id_cliente)), .F., .F.)
lcSql = loRes.AddParameter(lcSql, "xFecha", this.fecha, .F., .T.)
lcSql = loRes.AddParameter(lcSql, "xCantidad", ALLTRIM(STR(this.cantidad, 20, 2)), .F., .F.)
lcSql = loRes.AddParameter(lcSql, "xDetalle", ALLTRIM(this.detalle), .T., .F.)
lcSql = loRes.AddParameter(lcSql, "xPrecio", ALLTRIM(STR(this.precio, 20, 2)), .F., .F.)
lcSql = loRes.AddParameter(lcSql, "xFacturado", ALLTRIM(STR(this.facturado)), .F., .F.)
lcSql = loRes.AddParameter(lcSql, "xusuario", ALLTRIM(gcCodUsu), .T., .F.)
lcSql = loRes.AddParameter(lcSql, "xhost", ALLTRIM(SYS(0)), .T., .F.)

loRes.cursor_name = "cur_result"
loRes.OpenQuery(lcSql)

SELECT cur_result
IF cur_result.result == 0 THEN
	this.mensaje_error = cur_result.mensaje
	RETURN .F.
ENDIF

This.id_orden = cur_result.result
loRes.Close_Query()

RETURN .T.
ENDPROC
PROCEDURE update
************************************************************************
* Este método permite modificar los datos de una orden de trabajo.
* Fecha: 28/12/2023
************************************************************************
LOCAL loRes
LOCAL lcSql
LOCAL lnFacturado

loRes = CREATEOBJECT("odbc_result")
loRes.ActiveConnection = this.active_connection

lnFacturado = estandarizar_checkbox_value(Thisform.contenedor1.CheckboxFacturado.Value)

TEXT TO lcSql NOSHOW
	CALL ordtrabajo_update (
		?xId, ?xidCliente, ?xFecha, ?xCantidad,
		?xDetalle, ?xPrecio, ?xFacturado,
		?xusuario, ?xhost)
ENDTEXT
lcSql = loRes.AddParameter(lcSql, "xId", ALLTRIM(STR(this.id_orden)), .F., .F.)
lcSql = loRes.AddParameter(lcSql, "xidCliente", ALLTRIM(STR(this.id_cliente)), .F., .F.)
lcSql = loRes.AddParameter(lcSql, "xFecha", this.fecha, .F., .T.)
lcSql = loRes.AddParameter(lcSql, "xCantidad", ALLTRIM(STR(this.cantidad, 20, 2)), .F., .F.)
lcSql = loRes.AddParameter(lcSql, "xDetalle", ALLTRIM(this.detalle), .T., .F.)
lcSql = loRes.AddParameter(lcSql, "xPrecio", ALLTRIM(STR(this.precio, 20, 2)), .F., .F.)
lcSql = loRes.AddParameter(lcSql, "xFacturado", ALLTRIM(STR(lnFacturado)), .F., .F.)
lcSql = loRes.AddParameter(lcSql, "xusuario", ALLTRIM(gcCodUsu), .T., .F.)
lcSql = loRes.AddParameter(lcSql, "xhost", ALLTRIM(SYS(0)), .T., .F.)

loRes.cursor_name = "cur_result"
loRes.OpenQuery(lcSql)

SELECT cur_result
IF cur_result.result == 0 THEN
	this.mensaje_error = cur_result.mensaje
	RETURN .F.
ENDIF

This.id_orden = cur_result.result
loRes.Close_Query()

RETURN .T.
ENDPROC
PROCEDURE marcar_facturado
************************************************************************
* Este método permite marcar una orden de trabajo como facturada.
* Fecha: 18/12/2023
************************************************************************
LPARAMETERS ;
	tnId

LOCAL loRes
LOCAL lcSql

loRes = CREATEOBJECT("odbc_result")
TEXT TO lcSql NOSHOW
	CALL ordtrabajo_marcar_facturado (?xId)
ENDTEXT

lcSql = loRes.AddParameter(lcSql, "xId", ALLTRIM(STR(tnId)), .F., .F.)

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_result"
SELECT cur_result
This.mensaje = ALLTRIM(cur_result.mensaje)
loRes.Close_Query()

ENDPROC
PROCEDURE delete
****************************************************************************
* Este método permite eliminar un registro de la tabla de ordenes de trabajo.
* Fecha: 28/12/2023
****************************************************************************
LPARAMETERS ;
	tnId

*!*	LOCAL loRes
*!*	LOCAL lcSql
*!*	LOCAL loCommand

*!*	loRes = CREATEOBJECT("odbc_result")
*!*	loCommand = CREATEOBJECT("odbc_command")
*!*	loRes.ActiveConnection = this.active_connection

*!*	TEXT TO lcSql NOSHOW
*!*		CALL ordtrabajo_delete (?xId, ?xusuario, ?xhost)
*!*	ENDTEXT

*!*	lcSql = loRes.AddParameter(lcSql, "xId", ALLTRIM(STR(tnId)), .F., .F.)
*!*	lcSql = loRes.AddParameter(lcSql, "xusuario", ALLTRIM(gcCodUsu), .T., .F.)
*!*	lcSql = loRes.AddParameter(lcSql, "xhost", ALLTRIM(SYS(0)), .T., .F.)

*!*	loRes.cursor_name = "cur_result"
*!*	loRes.OpenQuery(lcSql)

*!*	SELECT cur_result
*!*	MESSAGEBOX(this.mensaje_error = cur_result.mensaje)
*!*	IF cur_result.result == 0 THEN
*!*		this.mensaje_error = cur_result.mensaje
*!*		RETURN .F.
*!*	ENDIF

*!*	This.id_orden = cur_result.result
*!*	loRes.Close_Query()
*!*	RETURN .T.

*****************************************************************************
LOCAL lcSql
LOCAL loCommand

lcSql = ""
loCommand = CREATEOBJECT("odbc_command")

goConn.BeginTransaction()

lcSql = "CALL ordtrabajo_delete (" + ALLTRIM(STR(tnId)) + ", '" + ALLTRIM(gcCodUsu) + "', '" + ALLTRIM(SYS(0)) + "')"

loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = lcSql
_cliptext = loCommand.CommandText
IF!loCommand.Execute() THEN
    THIS.ErrorMessage = loCommand.ErrorMessage
    goConn.Rollback()
    RETURN.F.
ENDIF

goConn.Commit()

RETURN.T.




ENDPROC
PROCEDURE getall
****************************************
* Obtiene todas las ordenes de trabajos
* Fecha: 28/12/2023
****************************************
LPARAMETERS tcFilter

LOCAL lcSql
LOCAL loRes

lcSql = ""

loRes = CREATEOBJECT("odbc_result")

TEXT TO lcSql NOSHOW
	SELECT
		ot.id as "CodigoOrden", ot.idCliente as "CodigoCliente", cli.razSoc as "NombreCliente",
		ot.fecha as "FechaOrden", ot.cantidad as "Cantidad", ot.detalle as "Detalle",
		ot.precio as "Precio", ot.facturado as "Facturado"
	FROM
		ordtrabajo ot
			INNER JOIN clientes cli ON cli.idCliente = ot.idCliente
	WHERE
		ot.fecBaja IS NULL	
ENDTEXT

* Si viene filtro, lo concateno a la consulta
IF !(ALLTRIM(tcFilter) == "") THEN
	lcSql = lcSql + " AND " + tcFilter
ENDIF

* Establezco el orden de las ordenes
lcSql = lcSql + " ORDER BY ot.id ASC"

_cliptext = lcSql

loRes.ActiveConnection = this.active_connection
loRes.Cursor_Name = "cur_x"
loRes.OpenQuery(lcSql)

SELECT cur_ordenes
ZAP
APPEND FROM DBF("cur_x")

loRes.close_query()

SELECT cur_ordenes
GO TOP



ENDPROC
PROCEDURE crear_cursores
CREATE CURSOR cur_ordtrab ( ;
    CodigoOrden int,;
    CodigoCliente int,;
    RazSoc C(60),;
    FechaOrden DATETIME,;
    Cantidad decimal(10,2),;
    Detalle varchar(100),;
    Precio decimal(20,2),;
    Facturado L)

CREATE CURSOR cur_ordenes(;
    CodigoOrden int,;
    CodigoCliente int,;
    NombreCliente C(60),;
    FechaOrden DATETIME,;
    Cantidad FLOAT(10,2),;
    Detalle C(100),;
    Precio FLOAT(10,2),;
    Facturado L,;
    UsuarioAlta C(100),;
    IDHostAlta C(100),;
    UsuarioModificacion C(100) NULL,;
    FechaModificacion DATETIME NULL,;
    IDHostModificacion int NULL)
ENDPROC
PROCEDURE get_by_id
****************************************
* Obtiene todas las ordenes de trabajos
* Fecha: 28/12/2023
****************************************
LPARAMETERS ;
	tnId

LOCAL lcSql
LOCAL loRes

loRes = CREATEOBJECT("odbc_result")
TEXT TO lcSql NOSHOW
	SELECT
		ot.id, ot.idCliente, ot.razSoc,
		ot.fecha, ot.cantidad, ot.detalle,
		ot.precio, ot.facturado
	FROM
		ordtrabajo ot
			INNER JOIN clientes cli ON cli.idCliente = ot.idCliente
	WHERE
		ot.fecBaja IS NULL AND
		ot.id = ?xid
	ORDER BY
		ot.id DESC
ENDTEXT

lcSql = loRes.AddParameter(lcSql, "xid", tnId, .F., .F.)

loRes.ActiveConnection = goConn.ActiveConnection
*loRes.Cursor_Name = "cur_x"
SELECT cur_ordtrab
ZAP
*APPEND FROM DBF("cur_x")
*loRes.Close_Query()
ENDPROC
PROCEDURE validar_campos
** ESTE METODO VA A PERMITIR VALIDAR LOS CAMPOS DEL AGREGAR/EDITAR ORDEN 
ENDPROC


************************************************************
OBJETO: cls_form_edit_ot
************************************************************
*** PROPIEDADES ***
DataSession = 1
Height = 210
Width = 533
DoCreate = .T.
Caption = "Agregar orden de trabajo"
WindowState = 0
es_nuevo = .F.
id_orden = 0
Name = "cls_form_edit_ot"

*** METODOS ***
PROCEDURE recuperar_datos
**********************************************************
* Permite recuperar los datos de las ordenes.
* Fecha: 29/05/2023
**********************************************************
SELECT cur_ordenes

* Recupero los datos
IF !Thisform.es_nuevo THEN
	Thisform.id_orden = cur_ordenes.CodigoOrden
ENDIF
Thisform.contenedor1.sel_Cliente.txtCodigo.Value = cur_ordenes.CodigoCliente
Thisform.contenedor1.sel_Cliente.txtDescripcion.Value = cur_ordenes.NombreCliente
Thisform.contenedor1.txtDetalle.Value = cur_ordenes.Detalle
Thisform.contenedor1.txtCantidad.Value = cur_ordenes.Cantidad
Thisform.contenedor1.txtPrecio.Value = cur_ordenes.Precio
Thisform.contenedor1.txtFecha.Value = cur_ordenes.FechaOrden
Thisform.contenedor1.checkboxFacturado.Value = cur_ordenes.Facturado
ENDPROC
PROCEDURE inicializar
*This.ord_trabajos_main = CREATEOBJECT("cls_ordenes_trabajo")

* Configuración de conexión a la base de datos
Thisform.oOrdenesDal.active_connection = goConn.ActiveConnection

IF !Thisform.es_nuevo THEN
	* Paso por acá cuando estoy editando.
	*Thisform.contenedor1.sel_cliente.txtCodigo.Enabled = .F.
	
	*Thisform.contenedor1.sel_Cliente.Enabled = .F.
ELSE
	Thisform.contenedor1.txtCantidad.Value = 1
	Thisform.contenedor1.txtFecha.Value = DATE()
ENDIF
ENDPROC
PROCEDURE actualizar_cursor
IF Thisform.es_nuevo THEN
	* Agrego el registro nuevo al cursor
	SELECT cur_ordenes
	APPEND BLANK
	REPLACE cur_ordenes.CodigoOrden WITH Thisform.oordenesDal.id_orden
	REPLACE cur_ordenes.CodigoCliente WITH Thisform.contenedor1.sel_cliente.txtCodigo.Value ADDITIVE
	REPLACE cur_ordenes.NombreCliente WITH Thisform.contenedor1.sel_cliente.TxtDescripcion.Value ADDITIVE
	REPLACE cur_ordenes.FechaOrden WITH Thisform.contenedor1.txtFecha.Value ADDITIVE
	REPLACE cur_ordenes.Cantidad WITH Thisform.contenedor1.txtCantidad.Value ADDITIVE
	REPLACE cur_ordenes.Detalle WITH Thisform.contenedor1.txtDetalle.Value ADDITIVE
	REPLACE cur_ordenes.Precio WITH Thisform.contenedor1.txtPrecio.Value ADDITIVE
	REPLACE cur_ordenes.Facturado WITH IIF(estandarizar_checkbox_value(Thisform.contenedor1.CheckboxFacturado.Value) = 1, .t., .f.) ADDITIVE
	REPLACE cur_ordenes.UsuarioAlta WITH ALLTRIM(gcCodUsu) ADDITIVE
	REPLACE cur_ordenes.IDHostAlta WITH ALLTRIM(Sys(0)) ADDITIVE
	REPLACE cur_ordenes.UsuarioModificacion WITH Null ADDITIVE
	REPLACE cur_ordenes.FechaModificacion WITH Null ADDITIVE
	REPLACE cur_ordenes.IDHostModificacion WITH Null ADDITIVE
ELSE
	* Actualizo los datos si estoy editando
	SELECT cur_ordenes
	LOCK()
	REPLACE cur_ordenes.CodigoOrden WITH Thisform.id_orden
	REPLACE cur_ordenes.CodigoCliente WITH Thisform.contenedor1.sel_cliente.txtCodigo.Value ADDITIVE
	REPLACE cur_ordenes.NombreCliente WITH Thisform.contenedor1.sel_cliente.TxtDescripcion.Value ADDITIVE
	REPLACE cur_ordenes.FechaOrden WITH Thisform.contenedor1.txtFecha.Value ADDITIVE
	REPLACE cur_ordenes.Cantidad WITH Thisform.contenedor1.txtCantidad.Value ADDITIVE
	REPLACE cur_ordenes.Detalle WITH Thisform.contenedor1.txtDetalle.Value ADDITIVE
	REPLACE cur_ordenes.Precio WITH Thisform.contenedor1.txtPrecio.Value ADDITIVE
	REPLACE cur_ordenes.Facturado WITH IIF(estandarizar_checkbox_value(Thisform.contenedor1.CheckboxFacturado.Value) = 1, .t., .f.) ADDITIVE
	REPLACE cur_ordenes.UsuarioAlta WITH ALLTRIM(gcCodUsu) ADDITIVE
	REPLACE cur_ordenes.IDHostAlta WITH ALLTRIM(Sys(0)) ADDITIVE
	REPLACE cur_ordenes.UsuarioModificacion WITH Null ADDITIVE
	REPLACE cur_ordenes.FechaModificacion WITH Null ADDITIVE
	REPLACE cur_ordenes.IDHostModificacion WITH Null ADDITIVE
	UNLOCK
ENDIF
ENDPROC
PROCEDURE validar_datos
IF Thisform.contenedor1.sel_cliente.valcpoid = 0 THEN
	MESSAGEBOX("Falta ingresar el cliente", 0+48, Thisform.Caption)
	Thisform.contenedor1.sel_cliente.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

IF thisform.contenedor1.txtCantidad.Value < 0 THEN
	MESSAGEBOX("No se puede ingresar una cantidad negativa.", 0+48, Thisform.Caption)
	thisform.contenedor1.txtCantidad.SetFocus()
	RETURN .F.
ENDIF

IF thisform.contenedor1.txtprecio.Value < 0 THEN
	MESSAGEBOX("No se puede ingresar un precio negativo.", 0+48, Thisform.Caption)
	thisform.contenedor1.txtprecio.SetFocus()
	RETURN .F.
ENDIF

IF YEAR(Thisform.contenedor1.txtfecha.Value) <> YEAR(date()) THEN
	MESSAGEBOX("No se puede ingresar un año distinto al de la orden actual.", 0+48, Thisform.Caption)
	thisform.contenedor1.txtfecha.SetFocus()
	RETURN .F.
ENDIF

IF EMPTY(thisform.contenedor1.txtDetalle.Value) THEN
	MESSAGEBOX("No se puede grabar una orden sin detalle.", 0+48, Thisform.Caption)
	thisform.contenedor1.txtDetalle.SetFocus()
	RETURN .F.
ENDIF
RETURN .T.
ENDPROC


************************************************************
OBJETO: Contenedor1
************************************************************
*** PROPIEDADES ***
Anchor = 0
Top = 3
Left = 1
Width = 528
Height = 153
Name = "Contenedor1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Anchor = 3
Caption = "Cantidad:"
Height = 15
Left = 293
Top = 47
Width = 55
TabIndex = 11
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Anchor = 3
Caption = "Fecha:"
Height = 15
Left = 294
Top = 82
Width = 55
TabIndex = 8
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: txtCantidad
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 378
TabIndex = 3
Top = 43
Width = 137
isnumeric = .T.
Name = "txtCantidad"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Anchor = 3
Caption = "Precio:"
Height = 15
Left = 14
Top = 77
Width = 55
TabIndex = 10
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: txtFecha
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 378
TabIndex = 5
Top = 78
Width = 137
isdatetime = .T.
Name = "txtFecha"

*** METODOS ***


************************************************************
OBJETO: txtPrecio
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 98
TabIndex = 4
Top = 74
Width = 137
isnumeric = .T.
Name = "txtPrecio"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Anchor = 3
Caption = "Cliente:"
Height = 15
Left = 13
Top = 10
Width = 55
TabIndex = 7
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: sel_cliente
************************************************************
*** PROPIEDADES ***
Top = 5
Left = 95
Width = 420
Height = 25
TabIndex = 1
nombre_tabla = clientes
pkfield = idCliente
nombre_campo_codigo = idCliente
nombre_campo_desc = razSoc
title_cols = Razón Social
esnumerico = .T.
Name = "sel_cliente"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Anchor = 3
Caption = "Detalle:"
Height = 15
Left = 13
Top = 47
Width = 55
TabIndex = 9
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: txtDetalle
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 97
TabIndex = 2
Top = 43
Width = 166
Name = "txtDetalle"

*** METODOS ***


************************************************************
OBJETO: checkboxFacturado
************************************************************
*** PROPIEDADES ***
Top = 112
Left = 407
Height = 18
Width = 106
Alignment = 0
Caption = "Facturado"
TabIndex = 6
Name = "checkboxFacturado"

*** METODOS ***


************************************************************
OBJETO: Clsgrabar1
************************************************************
*** PROPIEDADES ***
Top = 161
Left = 431
TabIndex = 7
Name = "Clsgrabar1"

*** METODOS ***
PROCEDURE Click
********************************************************
* Permite insertar o modificar una orden de trabajo.
* Desarrollador: Enzo Alzueta
********************************************************
Thisform.oOrdenesDal.id_cliente = thisform.contenedor1.sel_Cliente.valcpoid
thisform.oOrdenesDal.fecha = thisform.contenedor1.txtfecha.Value
thisform.oOrdenesDal.cantidad = thisform.contenedor1.txtCantidad.Value
thisform.oOrdenesDal.detalle = thisform.contenedor1.txtdetalle.Value
thisform.oOrdenesDal.precio = thisform.contenedor1.txtprecio.Value
thisform.oOrdenesDal.facturado = thisform.contenedor1.checkboxFacturado.Value

IF Thisform.validar_datos() THEN
	IF Thisform.es_nuevo THEN
		IF thisform.oOrdenesDal.insert() THEN
			MESSAGEBOX("La orden se grabó satisfactoriamente", 0+64, Thisform.Caption)
			Thisform.actualizar_cursor()
			Thisform.Release()
		ELSE
			MESSAGEBOX(Thisform.oOrdenesDal.mensaje_error, 0+64, Thisform.Caption)
		ENDIF
	ELSE
		Thisform.oOrdenesDal.id_orden = thisform.id_orden
				
		IF thisform.oOrdenesDal.update() THEN
			MESSAGEBOX("La orden se editó satisfactoriamente", 0+64, Thisform.Caption)
			Thisform.actualizar_cursor()
			Thisform.Release()
		ELSE
			MESSAGEBOX(Thisform.oOrdenesDal.mensaje_error, 0+64, Thisform.Caption)
		ENDIF
	ENDIF
ENDIF

ENDPROC


************************************************************
OBJETO: Clscerrar1
************************************************************
*** PROPIEDADES ***
Top = 161
Left = 484
TabIndex = 8
Name = "Clscerrar1"

*** METODOS ***


************************************************************
OBJETO: oOrdenesDal
************************************************************
*** PROPIEDADES ***
Top = 178
Left = 40
cantidad = 
detalle = 
facturado = 
fecha = 
id_cliente = 
precio = 
Name = "oOrdenesDal"

*** METODOS ***


************************************************************
OBJETO: cls_form_edit_ot
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_ordenes_trabajo
************************************************************
*** PROPIEDADES ***
DoCreate = .T.
Caption = "Ordenes de trabajo"
MaxButton = .T.
MinButton = .T.
WindowState = 2
obj_otdal = 
Name = "cls_ordenes_trabajo"
contenido.Name = "contenido"

*** METODOS ***
PROCEDURE filtrar_ordenes
***********************************************************************
* Permite filtrar las ordenes según el estado seleccionado.
* Fecha: 21/05/2024
***********************************************************************
LOCAL lcCriterio

IF Thisform.contenido.cnt_opciones.pgf_opciones.page1.chk_pendientes.Value = 1 THEN
	lcCriterio = "ot.facturado = 0" + " "
ENDIF
IF Thisform.contenido.cnt_opciones.pgf_opciones.page1.chk_pendientes.Value = 0 THEN
	lcCriterio = ""
ENDIF

IF Thisform.contenido.cnt_opciones.pgf_opciones.page1.sel_Cliente.valcpoid <> 0 THEN
	IF ALLTRIM(lcCriterio) == "" THEN
		lcCriterio = "cli.idCliente = " + ALLTRIM(STR(Thisform.contenido.cnt_opciones.pgf_opciones.page1.sel_Cliente.valcpoid)) + " "
	ELSE
		lcCriterio = lcCriterio + "AND cli.idCliente = " + ALLTRIM(STR(Thisform.contenido.cnt_opciones.pgf_opciones.page1.sel_Cliente.valcpoid)) + " "
	ENDIF
ENDIF

Thisform.oordenesDal.getall(lcCriterio)

* Me posiciono en el último registro seleccionado y
* refresco la grilla.
SELECT cur_ordenes
IF RECCOUNT("cur_ordenes") > 0 THEN
	GO TOP
	thisform.Contenido.GrdOrdenesTrabajos.Refresh()
ENDIF
ENDPROC
PROCEDURE Init
*********************************************************************
* Inicializo las propiedades y el estado del formulario
* Fecha: 28/12/2023
*********************************************************************

*!*	This.obj_otdal = CREATEOBJECT("cls_ordtrab_dal")
*!*	This.obj_otdal.crear_cursores()
*!*	*********************************************************************

*!*	LOCAL lcSql, loResult

*!*	SELECT cur_ordenes
*!*	thisform.contenido.grdOrdenesTrabajos.Alias_name = "cur_ordenes"
*!*	thisform.contenido.grdOrdenesTrabajos.RecordSource = "cur_ordenes"
*!*	thisform.contenido.grdOrdenesTrabajos.list_controlsource = "Facturado,CodigoOrden,NombreCliente,Detalle,FechaOrden,Cantidad,Precio"
*!*	thisform.contenido.grdOrdenesTrabajos.lista_ancho_cols = "60,50,450,300,90,70,50,120"
*!*	thisform.contenido.grdOrdenesTrabajos.titulos_cabeceras = "Facturado,Orden,Razón Social,Detalle,Fecha,Cantidad,Importe"

*!*	Thisform.contenido.grdOrdenesTrabajos.SetAll("DynamicBackColor", "iif(cur_ordenes.facturado, RGB(255,205,155), RGB(255,255,255))", "Column")
*!*	Thisform.contenido.grdOrdenesTrabajos.Columns[1].visible = .F.

*!*	thisform.contenido.grdOrdenesTrabajos.generar_grid()

*!*	loResult = CREATEOBJECT("odbc_result")

*!*	lcSql = "SELECT ordtrabajo.id AS 'CodigoOrden', "
*!*	lcSql = lcSql + "    clientes.idCliente AS 'CodigoCliente', "
*!*	lcSql = lcSql + "    clientes.razsoc AS 'NombreCliente', "
*!*	lcSql = lcSql + "    ordtrabajo.fecha AS 'FechaOrden', "
*!*	lcSql = lcSql + "    ordtrabajo.cantidad as 'Cantidad', "
*!*	lcSql = lcSql + "    ordtrabajo.detalle as 'Detalle', "
*!*	lcSql = lcSql + "    ordtrabajo.precio as 'Precio', "
*!*	lcSql = lcSql + "    ordtrabajo.facturado as 'Facturado', "
*!*	lcSql = lcSql + "    ordtrabajo.usuAlta AS 'UsuarioAlta', "
*!*	lcSql = lcSql + "    ordtrabajo.fecAlta AS 'FechaAlta', "
*!*	lcSql = lcSql + "    ordtrabajo.idHostAlta AS 'IDHostAlta', "
*!*	lcSql = lcSql + "    ordtrabajo.usuModi AS 'UsuarioModificacion', "
*!*	lcSql = lcSql + "    ordtrabajo.fecModi AS 'FechaModificacion', "
*!*	lcSql = lcSql + "    ordtrabajo.idHostModi AS 'IDHostModificacion' "
*!*	lcSql = lcSql + "FROM "
*!*	lcSql = lcSql + "    ordtrabajo "
*!*	lcSql = lcSql + "INNER JOIN "
*!*	lcSql = lcSql + "    clientes ON ordtrabajo.idCliente = clientes.idCliente "
*!*	lcSql = lcSql + "WHERE "
*!*	lcSql = lcSql + "	ordtrabajo.fecBaja is null"

*!*	loResult.ActiveConnection = goConn.ActiveConnection
*!*	loResult.cursor_name = "cur_temp"
*!*	loResult.OpenQuery(lcSql) 

*!*	SELECT cur_ordenes
*!*	ZAP
*!*	APPEND FROM DBF("cur_temp")

*!*	loResult.Close_Query()

*!*	SELECT cur_ordenes
*!*	GO TOP

*!*	thisform.Contenido.GrdOrdenesTrabajos.Refresh()


************************************************
* Inicializo los componentes del formulario
* Fecha: 24/05/2023
************************************************

thisform.oordenesDal.active_connection = goConn.ActiveConnection
thisform.oordenesDal.crear_cursores()

* Levanto las fichas
Thisform.oordenesDal.getall("")
SELECT cur_ordenes

thisform.contenido.grdOrdenesTrabajos.Alias_name = "cur_ordenes"
thisform.contenido.grdOrdenesTrabajos.RecordSource = "cur_ordenes"
thisform.contenido.grdOrdenesTrabajos.list_controlsource = "Facturado,CodigoOrden,NombreCliente,Detalle,FechaOrden,Cantidad,Precio"
thisform.contenido.grdOrdenesTrabajos.lista_ancho_cols = "60,50,450,300,103,50,100"
thisform.contenido.grdOrdenesTrabajos.titulos_cabeceras = "Facturado,Orden,Razón Social,Detalle,Fecha,Cantidad,Importe"

Thisform.contenido.grdOrdenesTrabajos.SetAll("DynamicBackColor", "iif(cur_ordenes.facturado, RGB(255,205,155), RGB(255,255,255))", "Column")
Thisform.contenido.grdOrdenesTrabajos.Columns[1].visible = .F.

thisform.contenido.grdOrdenesTrabajos.generar_grid()
Thisform.contenido.cnt_opciones.pgf_opciones.page1.chk_pendientes.Value = 0
ENDPROC


************************************************************
OBJETO: oOrdenesDal
************************************************************
*** PROPIEDADES ***
Top = 528
Left = 24
Name = "oOrdenesDal"

*** METODOS ***


************************************************************
OBJETO: cnt_opciones
************************************************************
*** PROPIEDADES ***
Anchor = 11
Top = 1
Left = 1
Width = 946
Height = 77
BackStyle = 1
BorderWidth = 0
BackColor = 0,70,140
Name = "cnt_opciones"

*** METODOS ***


************************************************************
OBJETO: pgf_opciones
************************************************************
*** PROPIEDADES ***
ErasePage = .T.
Anchor = 11
Top = 3
Left = 5
Width = 938
Height = 71
Name = "pgf_opciones"
Page1.Caption = "Filtros"
Page1.BackColor = 0,128,128
Page1.Name = "Page1"
Page2.Caption = "Operaciones"
Page2.BackColor = 0,128,128
Page2.Name = "Page2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Anchor = 3
Caption = "Cliente:"
Height = 15
Left = 16
Top = 17
Width = 48
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: sel_Cliente
************************************************************
*** PROPIEDADES ***
Anchor = 3
Top = 11
Left = 68
Width = 483
Height = 25
TabIndex = 1
cfieldname = 
esnumerico = .T.
nombre_tabla = clientes
pkfield = idCliente
nombre_campo_codigo = idCliente
nombre_campo_desc = razSoc
msgerror = Debe ingresar el cliente
autocompletar_ceros = .F.
permitir_agregar_regs = .F.
nombre_alta_form = frmaltaartic
criterio_filtro = clientes.habilitado = 1 AND clientes.fecBaja IS NULL
Name = "sel_Cliente"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Height = 21
txtDescripcion.Left = 106
txtDescripcion.Top = 2
txtDescripcion.Width = 374
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: chk_pendientes
************************************************************
*** PROPIEDADES ***
Top = 15
Left = 580
Height = 18
Width = 216
Anchor = 3
Alignment = 0
Caption = "Ver solo los pendientes de facturar"
Value = 1
Name = "chk_pendientes"

*** METODOS ***


************************************************************
OBJETO: btnBuscar
************************************************************
*** PROPIEDADES ***
Top = 5
Left = 836
Height = 36
Width = 36
Name = "btnBuscar"

*** METODOS ***
PROCEDURE Click
*************************************************************
* Filtro los registros de la grilla en base a lo seleccionado
*************************************************************
Thisform.filtrar_ordenes()
ENDPROC


************************************************************
OBJETO: btnCancelar
************************************************************
*** PROPIEDADES ***
Top = 5
Left = 889
Height = 36
Width = 36
Name = "btnCancelar"

*** METODOS ***
PROCEDURE Click
Thisform.contenido.cnt_opciones.pgf_opciones.page1.chk_pendientes.Value = 1
Thisform.contenido.cnt_opciones.pgf_opciones.page1.sel_Cliente.txtCodigo.Value = 0
Thisform.contenido.cnt_opciones.pgf_opciones.page1.sel_Cliente.txtDescripcion.Value = ""
Thisform.contenido.cnt_opciones.pgf_opciones.page1.sel_Cliente.valcpoid = 0
THisform.filtrar_ordenes()
ENDPROC


************************************************************
OBJETO: btnNuevo
************************************************************
*** PROPIEDADES ***
Top = 2
Left = 5
Height = 40
Width = 45
Anchor = 3
Name = "btnNuevo"

*** METODOS ***
PROCEDURE Click
*************************************************************************
* Permite cargar una nueva orden de trabajo.
* Fecha: 27/02/2024
*************************************************************************
LOCAL loForm

loForm = CREATEOBJECT("cls_form_edit_ot")
loForm.es_nuevo = .T.
SELECT cur_ordenes

*loForm.id_orden = cur_ordenes.CodigoOrden
loForm.inicializar()
loForm.show(1)

SELECT cur_ordenes
Thisform.contenido.grdOrdenesTrabajos.Refresh()
ENDPROC


************************************************************
OBJETO: btnEditar
************************************************************
*** PROPIEDADES ***
Top = 2
Left = 52
Height = 40
Width = 45
Anchor = 3
Name = "btnEditar"

*** METODOS ***
PROCEDURE Click
*************************************************************************
* Permite editar una nueva orden de trabajo.
* Fecha: 28/02/2024
*************************************************************************
LOCAL loForm

loForm = CREATEOBJECT("cls_form_edit_ot")
loForm.es_nuevo = .F.
SELECT cur_ordenes

*loForm.id_orden = cur_ordenes.CodigoOrden
loForm.inicializar()
loForm.recuperar_datos()
loForm.show(1)

SELECT cur_ordenes
Thisform.contenido.grdOrdenesTrabajos.Refresh()


ENDPROC


************************************************************
OBJETO: btnEliminar
************************************************************
*** PROPIEDADES ***
Top = 2
Left = 100
Height = 40
Width = 45
Anchor = 3
Name = "btnEliminar"

*** METODOS ***
PROCEDURE Click
LOCAL lnRespuesta
LOCAL lnIdOrden

lnRespuesta = MESSAGEBOX("¿Está seguro que desea eliminar la orden de trabajo?", 32+4, Thisform.Caption)
IF lnRespuesta = 6 THEN
	* Hacer el eliminar.
	SELECT cur_ordenes
	lnIdOrden = cur_ordenes.CodigoOrden
	thisform.oordenesDal.delete(lnIdOrden)
	* Actualizo el cursor
	SELECT cur_ordenes
	DELETE
	Thisform.contenido.grdOrdenesTrabajos.Refresh()
ENDIF
ENDPROC


************************************************************
OBJETO: btnImprimir
************************************************************
*** PROPIEDADES ***
Top = 3
Left = 180
Height = 39
Width = 45
Anchor = 3
Name = "btnImprimir"

*** METODOS ***
PROCEDURE Click
************************************************************************
* Imprime la/las ordenes de trabajo seleccionadas
************************************************************************
LOCAL m.titulo
LOCAL ldFechaActual

SELECT cur_ordenes
IF RECCOUNT() > 0
	GO TOP 
ELSE 
	MESSAGEBOX("No hay registros para imprimir",0+48,Thisform.Caption)
	RETURN
ENDIF 

m.titulo = "Listado de ordenes de trabajo"
ldFechaActual = DATE()

SELECT cur_ordenes
REPORT FORM repordtrab TO PRINTER PROMPT PREVIEW 


ENDPROC


************************************************************
OBJETO: Clscerrar1
************************************************************
*** PROPIEDADES ***
Top = 530
Left = 898
Height = 39
Width = 45
Anchor = 12
Name = "Clscerrar1"

*** METODOS ***


************************************************************
OBJETO: grdOrdenesTrabajos
************************************************************
*** PROPIEDADES ***
Anchor = 15
Height = 443
Left = 4
Top = 80
Width = 940
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdOrdenesTrabajos"
COLUMN1.Header1.Name = "Header1"
COLUMN1.Text1.Name = "Text1"
COLUMN1.CurrentControl = "chkFacturado"
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
OBJETO: chkFacturado
************************************************************
*** PROPIEDADES ***
Top = 28
Left = 46
Alignment = 0
Caption = ""
Name = "chkFacturado"

*** METODOS ***


************************************************************
OBJETO: cls_ordenes_trabajo
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


