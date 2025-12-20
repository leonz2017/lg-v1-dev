************************************************************
OBJETO: cls_localidad_dao
************************************************************
*** PROPIEDADES ***
idlocalid = 0
idprovin = 0
idpais = 0
codpostal = 
descripcio = 
provincia = 
pais = 
error_message = 
Name = "cls_localidad_dao"

*** METODOS ***
PROCEDURE get_by_id
****************************************************************************
* Permite obtener la localidad y sus datos vinculados por id de la misma.
* Desarrollado por: Zulli, Leonardo Diego
* Fecha: 10/12/2025
****************************************************************************

LPARAMETERS tnIdLocalid

LOCAL loRes
LOCAL lcSql
LOCAL llOk

TRY
	loRes = CREATEOBJECT("odbc_result")
	llOk = .F.
	
	TEXT TO lcSql NOSHOW
		SELECT
			localidad.idLocalid,
			localidad.codPostal,
			localidad.descripcio AS 'localidad',
			localidad.idProvin,
			provincias.descripcio AS 'provincia',
			localidad.idPais,
			paises.descripcio AS 'pais'
		FROM
			localidad
				INNER JOIN provincias ON provincias.idProvin = localidad.idProvin
				INNER JOIN paises ON paises.idPais = localidad.idPais
		WHERE
			localidad.idLocalid = ?xidLocalid
	ENDTEXT
	
	lcSql = loRes.addParameter(lcSql, "xidLocalid", ALLTRIM(STR(tnIdLocalid)), .F., .F.)
	loRes.ActiveConnection = goConn.ActiveConnection
	loRes.Cursor_Name = "cur_x"
	loRes.OpenQuery(lcSql)
	
	SELECT cur_x
	IF RECCOUNT("cur_x") > 0 THEN
		This.idlocalid = cur_x.idLocalid
		This.descripcio = ALLTRIM(cur_x.localidad)
		This.codpostal = ALLTRIM(cur_x.codPostal)
		This.idProvin = cur_x.idProvin
		This.provincia = ALLTRIM(cur_x.provincia)
		This.idpais = cur_x.idPais
		this.pais = ALLTRIM(cur_x.pais)
		
		llOk = .T.
	ELSE
		llOk = .F.
		This.error_message = "Localidad no encontrada"
	ENDIF
	
CATCH TO oException
	This.error_message = oException.Message + " en " + oException.Procedure + " Detalles: " + oException.Details
	llOk = .F.
FINALLY
	loRes.Close_Query()
	RELEASE loRes
ENDTRY

RETURN llOk

ENDPROC


************************************************************
OBJETO: cls_frm_consulta_remitos
************************************************************
*** PROPIEDADES ***
Height = 495
Width = 946
DoCreate = .T.
BorderStyle = 2
Caption = "Consulta y Reimpresión de Remitos"
idvtarto = 0
idventasc = 0
Name = "cls_frm_consulta_remitos"
contenido.Top = 0
contenido.Left = 0
contenido.Width = 946
contenido.Height = 494
contenido.Name = "contenido"

*** METODOS ***
PROCEDURE inicializar_parametros
*******************************************************************************
* Permite inicializar los parámetros de filtro 
* Fecha: 04/12/2025
*******************************************************************************
Thisform.contenido.cnt_parametros.sel_cliente.blanquear()
Thisform.contenido.cnt_parametros.txt_fecha_desde.Value = DATE() - 30
Thisform.contenido.cnt_parametros.txt_fecha_hasta.Value = DATE()
Thisform.contenido.cnt_parametros.sel_cliente.txtCodigo.SetFocus()

SELECT cur_rtos
ZAP
Thisform.contenido.grd_remitos.Refresh()
ENDPROC
PROCEDURE ver_detalle
*************************************************************************
* Muestro el modal con el detalle del remito seleccionado
* Fecha: 04/12/2025
*************************************************************************
LOCAL loForm

loForm = CREATEOBJECT("cls_frm_detalle_remito")
SELECT cur_rtos
loForm.idVtaRto = cur_rtos.idVtaRto
loForm.idVentasC = cur_rtos.idVentasC
loForm.idcliente = cur_rtos.idCliente
loForm.fecha = cur_rtos.fecha
loForm.nrocomp = cur_rtos.nrocomp
loForm.razsoccliente = cur_rtos.razSoc
loForm.razsoctrn = cur_rtos.razSocTrn
loForm.direccionTrn = cur_rtos.direccionTrn
loForm.codPostalTrn = cur_rtos.codPostalTrn
loForm.localidadTrn = cur_rtos.localidadTrn
loForm.provinciaTrn = cur_rtos.provinciaTrn
loForm.init_form()
loForm.show(1)
ENDPROC
PROCEDURE cambiar_estado
**************************************************************************************
* Cambia el estado de los controles de usuarios
* Desarrollado por: Zulli, Leonardo Diego
* Parametros:
*	tlEstado: .T. => Habilita los parámetros | .F. => Deshabilita los parámetros
* Fecha: 10/12/2025
**************************************************************************************
LPARAMETERS tlEstado

Thisform.contenido.cnt_parametros.sel_cliente.txtCodigo.Enabled = tlEstado
Thisform.contenido.cnt_parametros.txt_fecha_desde.Enabled = tlEstado
Thisform.contenido.cnt_parametros.txt_fecha_hasta.Enabled = tlEstado
Thisform.contenido.cnt_parametros.btnBuscar.Enabled = tlEstado

Thisform.contenido.btn_ver_detalle.Enabled = !tlEstado
ENDPROC
PROCEDURE buscar
*******************************************************************
* Busca los remitos
* Fecha: 05/12/2025
*******************************************************************

LOCAL lnIdCliente
LOCAL ldFechaDesde
LOCAL ldFechaHasta

lnIdCliente = Thisform.contenido.cnt_parametros.sel_cliente.valcpoid
ldFechaDesde = Thisform.contenido.cnt_parametros.txt_fecha_desde.Value
ldFechaHasta = Thisform.contenido.cnt_parametros.txt_fecha_hasta.Value

IF !Thisform.o_vtasrtos_dao.consultar(lnIdCliente, ldFechaDesde, ldFechaHasta) THEN
	MESSAGEBOX(Thisform.o_vtasrtos_dao.error_message, 0+48, Thisform.Caption)
ELSE
	SELECT cur_rtos
	Thisform.contenido.grd_remitos.Refresh()
	Thisform.cambiar_estado(.F.)
ENDIF

ENDPROC
PROCEDURE Init
*****************************************************************
* Inicializo el formulario
* Fecha: 04/12/2025
*****************************************************************

Thisform.o_vtasrtos_dao.crear_cursores()

SELECT cur_rtos
Thisform.contenido.grd_remitos.alias_name = "cur_rtos"
Thisform.contenido.grd_remitos.RecordSource = "cur_rtos"
Thisform.contenido.grd_remitos.list_controlsource = "fecha,nrocomp,idCliente,razSoc,razSocTrn"
Thisform.contenido.grd_remitos.lista_ancho_cols = "100,150,100,200,200"
Thisform.contenido.grd_remitos.titulos_cabeceras = "Fecha,Remito,Cliente Nº,Razón Social,Transporte"
Thisform.contenido.grd_remitos.generar_grid()

Thisform.inicializar_parametros()
Thisform.cambiar_estado(.T.)
ENDPROC


************************************************************
OBJETO: o_vtasrtos_dao
************************************************************
*** PROPIEDADES ***
Top = 497
Left = 221
Height = 17
Width = 18
Name = "o_vtasrtos_dao"

*** METODOS ***


************************************************************
OBJETO: cnt_parametros
************************************************************
*** PROPIEDADES ***
Anchor = 11
Top = 3
Left = 3
Width = 940
Height = 96
Name = "cnt_parametros"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Búsqueda de Facturas"
Height = 12
Left = 9
Top = 5
Width = 132
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Cliente:"
Height = 15
Left = 76
Top = 34
Width = 50
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Fecha Desde:"
Height = 15
Left = 45
Top = 58
Width = 84
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Fecha Hasta:"
Height = 15
Left = 251
Top = 58
Width = 84
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: sel_cliente
************************************************************
*** PROPIEDADES ***
Top = 28
Left = 126
criterio_filtro = fecBaja IS NULL
esnumerico = .T.
nombre_tabla = clientes
pkfield = idCliente
nombre_campo_codigo = idCliente
nombre_campo_desc = razSoc
title_cols = Razón Social
Name = "sel_cliente"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: txt_fecha_desde
************************************************************
*** PROPIEDADES ***
Left = 128
Top = 55
isdatetime = .T.
Name = "txt_fecha_desde"

*** METODOS ***


************************************************************
OBJETO: txt_fecha_hasta
************************************************************
*** PROPIEDADES ***
Left = 326
Top = 55
isdatetime = .T.
Name = "txt_fecha_hasta"

*** METODOS ***


************************************************************
OBJETO: btnBuscar
************************************************************
*** PROPIEDADES ***
Top = 41
Left = 830
Anchor = 12
Name = "btnBuscar"

*** METODOS ***
PROCEDURE Click
********************************************************************
* Evento que permite buscar las facturas para emitir remitos
* Desarrollado por: Zulli, Leonardo Diego
* Fecha: 03/12/2025
********************************************************************

Thisform.buscar()
ENDPROC


************************************************************
OBJETO: btnCancelar
************************************************************
*** PROPIEDADES ***
Top = 41
Left = 879
Anchor = 12
Name = "btnCancelar"

*** METODOS ***
PROCEDURE Click
****************************************************************
* Cancela la búsqueda
* Desarrollado por: Zulli, Leonardo Diego
* Fecha: 03/12/2025
****************************************************************
Thisform.inicializar_parametros()
Thisform.cambiar_estado(.T.)
ENDPROC


************************************************************
OBJETO: grd_remitos
************************************************************
*** PROPIEDADES ***
Height = 340
Left = 4
Top = 101
Width = 939
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grd_remitos"
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
PROCEDURE press_enter
**********************************************************
* Entro al detalle al presionar Enter sobre un registro
* Fecha: 05/12/2025
**********************************************************
Thisform.ver_detalle()
ENDPROC


************************************************************
OBJETO: btn_ver_detalle
************************************************************
*** PROPIEDADES ***
Top = 444
Left = 847
Name = "btn_ver_detalle"

*** METODOS ***
PROCEDURE Click
***************************************************************
* Muestro el modal con el detalle
* Fecha: 05/12/2025
***************************************************************
Thisform.ver_detalle()
ENDPROC


************************************************************
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 444
Left = 895
Name = "btnCerrar"

*** METODOS ***


************************************************************
OBJETO: cls_frm_consulta_remitos
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_frm_main_remitos
************************************************************
*** PROPIEDADES ***
Height = 574
Width = 946
DoCreate = .T.
BorderStyle = 3
Caption = "Emisión de Remitos"
MaxButton = .T.
MinButton = .T.
Name = "cls_frm_main_remitos"
contenido.Top = -1
contenido.Left = -1
contenido.Width = 948
contenido.Height = 577
contenido.Name = "contenido"

*** METODOS ***
PROCEDURE blanquear_parametros
*****************************************************************
* Blanquea los controles de los parámetros
* Desarrollado por: Zulli, Leonardo Diego
* Fecha: 03/12/2025
*****************************************************************
Thisform.contenido.cnt_parametros.sel_cliente.blanquear()
Thisform.contenido.cnt_parametros.txt_fecha_desde.Value = DATE() - 1
Thisform.contenido.cnt_parametros.txt_fecha_hasta.Value = DATE()
Thisform.contenido.cnt_parametros.btnBuscar.Enabled = .T.
Thisform.contenido.cnt_facturas.pgf.page2.lbl_factura_seleccionada.Caption = ""

* Blanqueo los cursores y los controles de remitos para que haga una
* cancelación total

SELECT cur_facturas
ZAP
SELECT cur_aux
ZAP

Thisform.contenido.cnt_facturas.pgf.page2.sel_transporte.blanquear()
Thisform.contenido.cnt_facturas.pgf.page1.SetFocus()
Thisform.contenido.cnt_parametros.sel_cliente.txtCodigo.SetFocus()

ENDPROC
PROCEDURE generar_remito
**********************************************************
* Permite generar el remito de la factura seleccionada.
* Desarrollado por: Zulli, Leonardo Diego
* Fecha: 04/12/2025
**********************************************************

LOCAL lnIdVentasC
LOCAL lnIdTransp
LOCAL ldFecha

IF !Thisform.validardetalle() THEN
	* Si los datos no son válidos corto la ejecución del método
	RETURN .F.
ENDIF

SELECT cur_facturas
lnIdVentasC = cur_facturas.idVentasC
lnIdTransp = Thisform.contenido.cnt_facturas.pgf.page2.sel_transporte.valcpoid
ldFecha = Thisform.contenido.cnt_facturas.pgf.page2.txt_fecha_emision.Value

IF !Thisform.o_vtasrtos_dao.grabar(lnIdVentasC, lnIdTransp, ldFecha)
	MESSAGEBOX(Thisform.o_vtasrtos_dao.error_message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

Thisform.imprimir_remito()
MESSAGEBOX("El remito se generó satisfactoriamente", 0+64, Thisform.Caption)

Thisform.deshabilitar_remito()

* Referesco la grilla de facturas para que vayan desapareciendo aquellas
* donde los remitos fueron emitidos
Thisform.o_vtasrtos_dao.eliminar_factura_de_cursor()
Thisform.contenido.cnt_facturas.pgf.page1.grd_facturas.Refresh()

RETURN .T.
ENDPROC
PROCEDURE deshabilitar_remito
*****************************************************************
* Permite blanquear los remitos
* Desarrollado por: Zulli, Leonardo Diego
* Fecha: 04/12/2025
*****************************************************************

SELECT cur_aux
ZAP

Thisform.contenido.cnt_facturas.pgf.page2.sel_transporte.blanquear()
Thisform.contenido.cnt_facturas.pgf.page2.txt_fecha_emision.Value = {}
Thisform.contenido.cnt_facturas.pgf.page2.Enabled = .F.
Thisform.contenido.cnt_facturas.pgf.page1.Enabled = .T.
Thisform.contenido.cnt_facturas.pgf.ActivePage = 1
Thisform.contenido.cnt_facturas.pgf.page1.grd_facturas.SetFocus()
ENDPROC
PROCEDURE habilitar_remitos
*************************************************************
* Habilita la pestaña de remitos para emitirlo y deshabilita
* la selección de facturas.
* Desarrollado por: Zulli, Leonardo Diego
* Fecha: 04/12/2025
*************************************************************

Thisform.contenido.cnt_facturas.pgf.page1.Enabled = .F.
Thisform.contenido.cnt_facturas.pgf.page2.Enabled = .T.
Thisform.contenido.cnt_facturas.pgf.ActivePage = 2

ENDPROC
PROCEDURE imprimir_remito
**********************************************************************
* Permite enviar a imprimir el remito.
* Desarrollado por: Zulli, Leonardo Diego
* Fecha: 04/12/2025
**********************************************************************

LOCAL m.Fecha
LOCAL m.NroCli
LOCAL m.RazSoc
LOCAL m.direccion
LOCAL m.codPostal
LOCAL m.localidad
LOCAL m.pcia
LOCAL m.TipoIva
LOCAL m.fecVto
LOCAL m.nroCUIT
LOCAL m.nroOC
LOCAL m.tipoDoc
LOCAL m.NroCbte
LOCAL lnCopias
LOCAL lcRepName
LOCAL m.razSocTransp
LOCAL m.direccionTransp
LOCAL m.Total
LOCAL m.nroCopia
LOCAL m.nroRto
LOCAL m.observ

* Obtengo los datos de cabecera de la factura seleccionada actualmente
SELECT cur_facturas
m.Fecha = cur_facturas.fecEmision
m.NroCli = cur_facturas.idCliente
m.RazSoc = ALLTRIM(cur_facturas.razSoc)
m.direccion = ALLTRIM(cur_facturas.direccion)
m.codPostal = ALLTRIM(cur_facturas.codPostal)
m.localidad = ALLTRIM(cur_facturas.localidad)
m.pcia = ALLTRIM(cur_facturas.provincia)
m.TipoIva = ALLTRIM(cur_facturas.tipoIVA)
m.fecVto = cur_facturas.fecVto
m.nroCUIT = ALLTRIM(cur_facturas.nroCUIT)
m.nroOC = cur_facturas.nroOC
m.tipoDoc = ALLTRIM(cur_facturas.tipoDoc)
m.observ = ALLTRIM(cur_facturas.observ)

m.NroCbte = REPLICATE("0", 5 - LEN(ALLTRIM(STR(cur_facturas.ptovta)))) + ALLTRIM(STR(cur_facturas.ptovta)) ;
	+ "-" + REPLICATE("0", 8 - LEN(ALLTRIM(STR(cur_facturas.nroCbte)))) + ALLTRIM(STR(cur_facturas.nroCbte))
	
m.razSocTransp = ALLTRIM(Thisform.contenido.cnt_facturas.pgf.page2.sel_transporte.txtdescripcion.Value)
m.direccionTransp = ALLTRIM(Thisform.contenido.cnt_facturas.pgf.page2.txtdireccion_transp.Value)
m.Total = Thisform.contenido.cnt_facturas.pgf.page2.txttotal.Value

m.nroRto = thisform.o_vtasrtos_dao.nro_rto


* Tengo que levantar el nombre de impresora y el nombre del report
* configurado en numeradores.

FOR lnCopias = 1 TO Thisform.o_vtasrtos_dao.copias
	m.nroCopia = lnCopias
	lcRepName = This.o_vtasrtos_dao.repname
	SET PRINTER TO NAME ALLTRIM(Thisform.o_vtasrtos_dao.impresora)
	SELECT cur_aux
	REPORT FORM &lcRepName NOCONSOLE TO PRINTER
ENDFOR
ENDPROC
PROCEDURE cambiar_estado
***********************************************************************************
* Cambia el estado de los controles de usuario
* Desarrollado por: Zulli, Leonardo Diego
* Parametros:
*	tlEstado: 
*		.T. => Habilita parametros y desahbilita pestañas.
*		.F. => Deshabilita parámetros y habilita pestañas.
* Fecha: 10/12/2025
***********************************************************************************

LPARAMETERS tlEstado

Thisform.contenido.cnt_parametros.btnBuscar.Enabled = tlEstado
Thisform.contenido.cnt_parametros.sel_cliente.txtCodigo.Enabled = tlEstado
Thisform.contenido.cnt_parametros.txt_fecha_desde.Enabled = tlEstado
Thisform.contenido.cnt_parametros.txt_fecha_hasta.Enabled = tlEstado

Thisform.contenido.cnt_facturas.pgf.Enabled = !tlEstado
ENDPROC
PROCEDURE buscar
********************************************************************
* Evento que permite buscar las facturas para emitir remitos
* Desarrollado por: Zulli, Leonardo Diego
* Fecha: 03/12/2025
********************************************************************

LOCAL lnIdCliente
LOCAL ldFechaDesde
LOCAL ldFechaHasta

IF !Thisform.validarcampos() THEN
	* Corto la ejecución del evento
	RETURN
ENDIF

lnIdCliente = Thisform.contenido.Cnt_parametros.sel_cliente.valcpoid	
ldFechaDesde = Thisform.contenido.cnt_parametros.txt_fecha_desde.Value
ldFechaHasta = Thisform.contenido.cnt_parametros.txt_fecha_hasta.Value

* Busco la factura, si tira error lo muestro sino refresco la grilla
IF !Thisform.o_vtasrtos_dao.buscar_facturas(lnIdCliente, ldFechaDesde, ldFechaHasta) THEN
	MESSAGEBOX(thisform.o_vtasrtos_dao.error_message, 0+48, Thisform.Caption)
ELSE
	Thisform.cambiar_estado(.F.)
	Thisform.contenido.cnt_facturas.pgf.ActivePage = 1
	Thisform.contenido.cnt_facturas.pgf.page1.Refresh()
	
	SELECT cur_facturas
	GO TOP IN "cur_facturas"

	Thisform.contenido.cnt_facturas.pgf.page1.grd_facturas.Refresh()
	Thisform.contenido.cnt_facturas.pgf.page1.grd_facturas.SetFocus()
ENDIF

ENDPROC
PROCEDURE validardetalle
*****************************************************************
* Uso este método para validar los datos del remito
* Desarrollado por: Zulli, Leonardo Diego
* Fecha: 04/12/2025
*****************************************************************
IF Thisform.contenido.cnt_facturas.pgf.page2.sel_transporte.valcpoid = 0 THEN
	MESSAGEBOX("Debe seleccionar al menos un transporte", 0+48, Thisform.Caption)
	Thisform.contenido.cnt_facturas.pgf.page2.sel_transporte.SetFocus()
	RETURN .F.
ENDIF

IF Thisform.contenido.cnt_facturas.pgf.page2.txt_fecha_emision.Value = {} THEN
	MESSAGEBOX("Debe ingresar la fecha de emisión", 0+48, Thisform.Caption)
	Thisform.contenido.cnt_facturas.pgf.page2.txt_fecha_emision.SetFocus()
	RETURN .F.
ENDIF

RETURN .T.
ENDPROC
PROCEDURE Init
**********************************************************************
* Inicializo el formulario
* Desarrollado por: Zulli, Leonardo Diego
* Fecha: 02/12/2025
**********************************************************************

Thisform.o_vtasrtos_dao.crear_cursores()

&& Establezco la fecha desde y hasta predeterminada

Thisform.contenido.cnt_parametros.txt_fecha_desde.Value = DATE() - 1
Thisform.contenido.cnt_parametros.txt_fecha_hasta.Value = DATE()

&& Configuro la grilla de facturas
SELECT cur_facturas
Thisform.contenido.cnt_facturas.pgf.page1.grd_facturas.alias_name = "cur_facturas"
Thisform.contenido.cnt_facturas.pgf.page1.grd_facturas.RecordSource = "cur_facturas"
Thisform.contenido.cnt_facturas.pgf.page1.grd_facturas.list_controlsource = "fecEmision,nroComp,idCliente,razSoc,totFact"
Thisform.contenido.cnt_facturas.pgf.page1.grd_facturas.titulos_cabeceras = "Fecha,Comprobante,Cliente,Razón Social,Total"
Thisform.contenido.cnt_facturas.pgf.page1.grd_facturas.lista_ancho_cols = "150,200,70,250,100"
Thisform.contenido.cnt_facturas.pgf.page1.grd_facturas.generar_grid()

&& Configuro la grilla de ítems de remito
SELECT cur_aux
Thisform.contenido.cnt_facturas.pgf.page2.grd_rto_item.alias_name = "cur_aux"
Thisform.contenido.cnt_facturas.pgf.page2.grd_rto_item.RecordSource = "cur_aux"
Thisform.contenido.cnt_facturas.pgf.page2.grd_rto_item.list_controlsource = "cantidad,codArt,descripcio"
Thisform.contenido.cnt_facturas.pgf.page2.grd_rto_item.titulos_cabeceras = "Cantidad,Código,Descripción"
Thisform.contenido.cnt_facturas.pgf.page2.grd_rto_item.lista_ancho_cols = "70,150,400"
Thisform.contenido.cnt_facturas.pgf.page2.grd_rto_item.generar_grid()

&& Inicio el tipo de comprobante y punto de venta en el objeto DAO
Thisform.o_vtasrtos_dao.cbte = "RTO"
Thisform.o_vtasrtos_dao.tipodoc = "R"
Thisform.o_vtasrtos_dao.ptovta = INT(VAL(getConfig("PTOVTARTO")))

&& Deshabilito la pestaña de remitos.
Thisform.cambiar_estado(.T.)
ENDPROC
PROCEDURE validarcampos
***********************************************************************
* Valida los parametros que estén cargados.
* Desarrollado por: Zulli, Leonardo Diego
* Fecha: 03/12/2025
***********************************************************************

IF Thisform.contenido.cnt_parametros.txt_fecha_desde.Value = {} THEN
	MESSAGEBOX("Debe ingresar la fecha desde", 0+48, Thisform.Caption)
	Thisform.contenido.cnt_parametros.txt_fecha_desde.SetFocus()
	RETURN .F.
ENDIF

IF Thisform.contenido.cnt_parametros.txt_fecha_hasta.Value = {} THEN
	MESSAGEBOX("Debe ingresar la fecha hasta", 0+48,  Thisform.Caption)
	Thisform.contenido.cnt_parametros.txt_fecha_hasta.SetFocus()
	RETURN .F.
ENDIF

IF Thisform.contenido.cnt_parametros.txt_fecha_desde.Value > Thisform.contenido.cnt_parametros.txt_fecha_hasta.Value THEN
	MESSAGEBOX("La fecha desde no puede ser mayor a la fecha hasta", 0+48, Thisform.Caption)
	Thisform.contenido.cnt_parametros.txt_fecha_desde.SetFocus()
	RETURN .F.
ENDIF

RETURN .T.
ENDPROC


************************************************************
OBJETO: o_vtasrtos_dao
************************************************************
*** PROPIEDADES ***
Top = 528
Left = 108
Height = 17
Width = 43
Name = "o_vtasrtos_dao"

*** METODOS ***


************************************************************
OBJETO: o_localidad_dao
************************************************************
*** PROPIEDADES ***
Top = 532
Left = 238
Height = 17
Width = 26
Name = "o_localidad_dao"

*** METODOS ***


************************************************************
OBJETO: btncerrar
************************************************************
*** PROPIEDADES ***
Top = 526
Left = 899
Anchor = 12
Name = "btncerrar"

*** METODOS ***


************************************************************
OBJETO: cnt_parametros
************************************************************
*** PROPIEDADES ***
Anchor = 11
Top = 3
Left = 4
Width = 940
Height = 96
Name = "cnt_parametros"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Búsqueda de Facturas"
Height = 12
Left = 9
Top = 5
Width = 132
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Cliente:"
Height = 15
Left = 76
Top = 34
Width = 50
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Fecha Desde:"
Height = 15
Left = 45
Top = 58
Width = 84
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Fecha Hasta:"
Height = 15
Left = 251
Top = 58
Width = 84
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: sel_cliente
************************************************************
*** PROPIEDADES ***
Top = 28
Left = 126
criterio_filtro = fecBaja IS NULL
esnumerico = .T.
nombre_tabla = clientes
pkfield = idCliente
nombre_campo_codigo = idCliente
nombre_campo_desc = razSoc
title_cols = Razón Social
Name = "sel_cliente"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: txt_fecha_desde
************************************************************
*** PROPIEDADES ***
Left = 128
Top = 55
isdatetime = .T.
Name = "txt_fecha_desde"

*** METODOS ***


************************************************************
OBJETO: txt_fecha_hasta
************************************************************
*** PROPIEDADES ***
Left = 326
Top = 55
isdatetime = .T.
Name = "txt_fecha_hasta"

*** METODOS ***


************************************************************
OBJETO: btnBuscar
************************************************************
*** PROPIEDADES ***
Top = 41
Left = 830
Anchor = 12
Name = "btnBuscar"

*** METODOS ***
PROCEDURE Click
********************************************************************
* Evento que permite buscar las facturas para emitir remitos
* Desarrollado por: Zulli, Leonardo Diego
* Fecha: 03/12/2025
********************************************************************

Thisform.buscar()
ENDPROC


************************************************************
OBJETO: btnCancelar
************************************************************
*** PROPIEDADES ***
Top = 41
Left = 879
Anchor = 12
Name = "btnCancelar"

*** METODOS ***
PROCEDURE Click
****************************************************************
* Cancela la búsqueda
* Desarrollado por: Zulli, Leonardo Diego
* Fecha: 03/12/2025
****************************************************************
Thisform.blanquear_parametros()
Thisform.cambiar_estado(.T.)
ENDPROC


************************************************************
OBJETO: cnt_facturas
************************************************************
*** PROPIEDADES ***
Anchor = 15
Top = 103
Left = 4
Width = 940
Height = 422
Name = "cnt_facturas"

*** METODOS ***


************************************************************
OBJETO: pgf
************************************************************
*** PROPIEDADES ***
ErasePage = .T.
Anchor = 15
Top = 5
Left = 6
Width = 930
Height = 414
Name = "pgf"
Page1.Caption = "Selección de facturas"
Page1.Name = "Page1"
Page2.Caption = "Emisión de remito"
Page2.Name = "Page2"

*** METODOS ***


************************************************************
OBJETO: grd_facturas
************************************************************
*** PROPIEDADES ***
Anchor = 15
Height = 380
Left = 5
Top = 4
Width = 915
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grd_facturas"
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
PROCEDURE press_enter
********************************************************************
* Al presionar enter sobre un registro se debe generar el remito
* en la solapa de emisión
* Desarrollador por: Zulli, Leonardo Diego
* Fecha: 03/12/2025
********************************************************************

SELECT cur_facturas
** Pongo el total de la factura seleccionada
Thisform.contenido.cnt_facturas.pgf.page2.txtTotal.Value = cur_facturas.totFact

** Armo los ítems del remito
Thisform.o_vtasrtos_dao.get_items(cur_facturas.idVentasC)

IF !Thisform.o_vtasrtos_dao.get_transporte_por_cliente(cur_facturas.idCliente) THEN
	MESSAGEBOX(Thisform.o_vtasrtos_dao.error_message, 0+48, Thisform.Caption)
	RETURN
ENDIF

* Levanto los datos del transporte predeterminado de ese cliente.
Thisform.contenido.cnt_facturas.pgf.page2.sel_transporte.valcpoid = Thisform.o_vtasrtos_dao.idtransp
Thisform.contenido.cnt_facturas.pgf.page2.sel_transporte.txtCodigo.Value = Thisform.o_vtasrtos_dao.codtrans
Thisform.contenido.cnt_facturas.pgf.page2.sel_transporte.txtDescripcion.Value = ALLTRIM(Thisform.o_vtasrtos_dao.razsoc)

* Dirección de transporte
Thisform.contenido.cnt_facturas.pgf.page2.txtdireccion_transp.Value = ALLTRIM(Thisform.o_vtasrtos_dao.direcciontrn) ;
	+ " (" + ALLTRIM(Thisform.o_vtasrtos_dao.cod_postal_transp) + ") " ;
	+ ALLTRIM(Thisform.o_vtasrtos_dao.localidad_transp)

Thisform.contenido.cnt_facturas.pgf.page2.lbl_factura_seleccionada.Caption = "Factura seleccionada: " + ALLTRIM(cur_facturas.nroComp)

* Cargo los ítems en la grilla de remitos
SELECT cur_aux
GO TOP
Thisform.contenido.cnt_facturas.pgf.page2.grd_rto_item.Refresh()

* Pongo la fecha actual como predeterminada en la fecha de emisión
Thisform.contenido.cnt_facturas.pgf.page2.txt_fecha_emision.Value = DATE()

Thisform.habilitar_remitos()
ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Anchor = 3
Caption = "Transporte:"
Height = 15
Left = 20
Top = 13
Width = 71
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: sel_transporte
************************************************************
*** PROPIEDADES ***
Anchor = 3
Top = 9
Left = 97
pkfield = idTransp
nombre_tabla = transp
nombre_campo_codigo = idTransp
nombre_campo_desc = razSoc
title_cols = Razón Social
esnumerico = .T.
criterio_filtro = fecBaja IS NULL
Name = "sel_transporte"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***
PROCEDURE recuperar_datos
*******************************************************************
* Recupero los datos del transporte en caso de que cambie.
* Desarrollado por: Zulli, Leonardo Diego
* Fecha: 10/12/2025
*******************************************************************

SELECT transp
This.Parent.txtdireccion_transp.Value = ALLTRIM(transp.direccion)

IF !Thisform.o_localidad_dao.get_by_id(transp.idLocalid) THEN
	MESSAGEBOX(Thisform.o_localidad_dao.error_message, 0+48, Thisform.Caption)
ELSE
	* Si está OK, entonces levanto los datos del transporte
	Thisform.contenido.cnt_facturas.pgf.page2.txtdireccion_transp.Value = ALLTRIM(transp.direccion) ;
		+ " (" + ALLTRIM(Thisform.o_localidad_dao.codpostal) + ") " ;
		+ ALLTRIM(Thisform.o_localidad_dao.descripcio)
ENDIF
ENDPROC


************************************************************
OBJETO: grd_rto_item
************************************************************
*** PROPIEDADES ***
Anchor = 15
Height = 242
Left = 14
Top = 69
Width = 900
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grd_rto_item"
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
Top = 340
Left = 422
Anchor = 6
ToolTipText = "Grabar y emitir remito"
Name = "btnGrabar"

*** METODOS ***
PROCEDURE Click
*************************************************************
* Evento click del botón grabar y emitir remitos
* Desarrollado por: Zulli, Leonardo Diego
* Fecha: 04/12/2025
*************************************************************

Thisform.generar_remito()
ENDPROC


************************************************************
OBJETO: btn_volver
************************************************************
*** PROPIEDADES ***
Top = 340
Left = 470
Anchor = 6
Picture = ..\imagen\arrow-right.ico
ToolTipText = "Volver a la selección de facturas"
Name = "btn_volver"

*** METODOS ***
PROCEDURE Click
**********************************************
* Vuelvo a la solapa anterior
**********************************************

Thisform.deshabilitar_remito()
ENDPROC


************************************************************
OBJETO: lbl_factura_seleccionada
************************************************************
*** PROPIEDADES ***
FontSize = 9
Anchor = 3
Caption = ""
Height = 17
Left = 605
Top = 37
Width = 302
ForeColor = 0,128,0
Name = "lbl_factura_seleccionada"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Anchor = 3
Caption = "Fecha Emisión:"
Height = 15
Left = 647
Top = 13
Width = 91
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: txt_fecha_emision
************************************************************
*** PROPIEDADES ***
Anchor = 3
Height = 21
Left = 742
Top = 10
Width = 123
Name = "txt_fecha_emision"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Anchor = 3
Caption = "Dirección:"
Height = 15
Left = 22
Top = 37
Width = 65
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: txtdireccion_transp
************************************************************
*** PROPIEDADES ***
Anchor = 3
Height = 21
Left = 99
ReadOnly = .T.
Top = 35
Width = 478
Name = "txtdireccion_transp"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Anchor = 12
Caption = "Total de la factura:"
Height = 15
Left = 655
Top = 317
Width = 104
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: txttotal
************************************************************
*** PROPIEDADES ***
Anchor = 12
Height = 21
Left = 769
ReadOnly = .T.
Top = 314
Width = 144
isnumeric = .T.
Name = "txttotal"

*** METODOS ***


************************************************************
OBJETO: cls_frm_main_remitos
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_vtasrtos_dao
************************************************************
*** PROPIEDADES ***
error_message = 
idtransp = 0
codtrans = 
razsoc = 
impresora = 
copias = 0
cbte = 
tipodoc = 
ptovta = 0
id_num = 0
repname = 
direcciontrn = 
idlocalid_transp = 0
localidad_transp = 
idprovin_transp = 
provincia_transp = 0
cod_postal_transp = 
nro_rto = 
Name = "cls_vtasrtos_dao"

*** METODOS ***
PROCEDURE crear_cursores
*********************************************************************
* Permite crear los cursores requeridos para la emisión de remitos.
* Desarrollado por: Zulli, Leonardo Diego
* Fecha: 01/12/2025
*********************************************************************
	
* Cursor para mostrar facturas a seleccionar
CREATE CURSOR cur_facturas ( 			 ;
	idVentasC	int NOT NULL 			,;
	idCliente	int NOT null			,;
	razSoc		varchar(60) NOT NULL	,;
	direccion	varchar(60) NOT null	,;
	codPostal	varchar(10) NOT NULL	,;
	localidad	varchar(60) NOT NULL	,;
	provincia	varchar(60) NOT null	,;
	pais		varchar(60) NOT NULL	,;
	tipoIVA		varchar(60) NOT NULL	,;	
	nroCUIT		varchar(20) NOT null	,;	
	fecEmision	datetime NOT NULL 		,;
	fecVto		datetime NOT NULL 		,;
	nroComp		varchar(20) NOT NULL 	,;
	totFact		N(20, 2)				,;
	nroOC		int NULL				,;
	tipoDoc		varchar(1) NOT null		,;
	nroCbte		int NOT NULL			,;
	ptovta		int NOT NULL			,;
	observ		M NULL)

	
* Cursor para imprimir el detalle del remito.
* Dejo el nombre cur_aux para no cambiarlo en el report.
CREATE CURSOR cur_aux (			 		 ;
	idVentasD 	int NOT NULL 			,;
	idVentasC	int NOT NULL 			,;
	idArticulo	int NOT NULL 			,;
	cantidad	N(20, 2) NOT NULL 		,;
	codArt		varchar(20) NOT NULL 	,;
	Descripcio	varchar(200) NOT NULL)	
	
* Cursor para la grilal de consulta y reimpresión de remitos
CREATE CURSOR cur_rtos ( 		 	 	 	;
	idVtaRto 		int NOT NULL			,;
	idVentasC		int NOT NULL			,;
	fecha			D NOT NULL				,;
	nrocomp			varchar(20) NOT NULL	,;
	idCliente		int NOT NULL			,;
	razSoc			varchar(60) NOT NULL	,;
	razSocTrn		varchar(60) NOT NULL	,;
	direccionTrn 	varchar(60) NULL		,;
	codPostalTrn	varchar(10) NULL		,;
	localidadTrn	varchar(60) NULL		,;
	provinciaTrn	varchar(60) NULL)

ENDPROC
PROCEDURE grabar
*******************************************************************
* Permite grabar un remito.
* Parámetros:
*	tnIdVentasC => Id. del comprobante de venta asociado
*	tnIdTransp => Transporte
*	tnFecha => Fecha de emisión del remito
*	tnPtoVta => Punto de venta
* Desarrollado por: Zulli, Leonardo Diego
* Fecha: 01/12/2025
*******************************************************************
LPARAMETERS ;
	tnIdVentasC,;
	tnIdTransp,;
	tnFecha

LOCAL loRes
LOCAL llOk
LOCAL lcSql

IF !This.get_tipo_cbte() THEN
	RETURN .F.
ENDIF

TRY
	loRes = CREATEOBJECT("odbc_result")
	llOk = .F.
	
	TEXT TO lcSql NOSHOW
		CALL vtasrtos_generar (
			?xidVentasC,
			?xidTransp,
			?xidNum,
			?xfecha,
			?xusuario,
			?xhost
		)
	ENDTEXT
	
	lcSql = loRes.addParameter(lcSql, "xidVentasC", ALLTRIM(STR(tnIdVentasC)), .F., .F.)
	lcSql = loRes.addParameter(lcSql, "xidTransp", ALLTRIM(STR(tnIdTransp)), .F., .F.)
	lcSql = loRes.addParameter(lcSql, "xidNum", ALLTRIM(STR(this.id_num)), .T., .F.)
	lcSql = loRes.addParameter(lcSql, "xfecha", tnFecha, .F., .T.)
	lcSql = loRes.addParameter(lcSql, "xusuario", ALLTRIM(gcCodUsu), .T., .F.)
	lcSql = loRes.addParameter(lcSql, "xhost", ALLTRIM(SYS(0)), .T., .F.)
	
	loRes.ActiveConnection = goConn.ActiveConnection
	loRes.Cursor_Name = "cur_result"
	loRes.OpenQuery(lcSql)
	
	SELECT cur_result
	IF ALLTRIM(cur_result.result) != "OK" THEN
		MESSAGEBOX(cur_result.result, 0+48, Thisform.Caption)
		llOk = .F.
	ELSE
		this.nro_rto = cur_result.nro_rto	
		llOk = .T.
	ENDIF
CATCH TO oException
	This.error_message = oException.Message + " en " + oException.Procedure + " Detalles: " + oException.Details
	llOk = .F.
FINALLY
	RELEASE loCmd
ENDTRY

RETURN llOk
ENDPROC
PROCEDURE buscar_facturas
*****************************************************************
* Este método permite buscar las facturas
* Desarrollado por: Zulli, Leonardo Diego
* Parámetros:
*	tnIdCliente => Id. del cliente seleccionado. Si es 0, trae todo.
*	tnFechaDesde => Fecha de emisión desde.
*	tnFechaHasta => Fecha de emisión hasta.
* Fecha: 01/12/2025
*****************************************************************
LPARAMETERS ;
	tnIdCliente, ;
	tdFechaDesde, ;
	tdFechaHasta

LOCAL loRes
LOCAL lcSql
LOCAL llOk

TRY
	loRes = CREATEOBJECT("odbc_result")
	
	* Limpio el cursor antes de volverlo a cargar
	SELECT cur_facturas
	ZAP	

	TEXT TO lcSql NOSHOW
		SELECT
			idVentasC, 
			ventascab.idCliente,
			clientes.razSoc,
			clientes.direccion,
			localidad.codPostal,
			localidad.descripcio AS 'localidad',
			provincias.descripcio AS 'provincia',
			paises.descripcio AS 'pais',
			sitiva.descripcio AS 'tipoIVA',
			clientes.nroCUIT,
			ventascab.fecEmision, 
			ventascab.fecvto,
			CONCAT(ventascab.cbte, ' ' , ventascab.tipoDoc, ' ', 
				REPEAT('0', 5 - LENGTH(ventascab.ptoVta)), ventascab.ptovta,
				'-', REPEAT('0', 8 - LENGTH(ventascab.numCbte)), ventascab.numCbte) 
			AS 'nroComp',
			ventascab.totFact,
			ventascab.nroOC,
			ventascab.tipoDoc,
			ventascab.numCbte AS 'nroCbte',
			ventascab.ptoVta,
			ventascab.totFact,
			ventascab.observ
		FROM
			ventascab
				INNER JOIN clientes ON ventascab.idCliente = clientes.idCliente
				INNER JOIN localidad ON localidad.idLocalid = clientes.idLocalid
				INNER JOIN provincias ON provincias.idProvin = localidad.idProvin
				INNER JOIN paises ON paises.idPais = localidad.idPais
				INNER JOIN sitiva ON sitiva.idSitIVA = ventascab.idSitIVA
		WHERE
			CASE WHEN ?xidCliente = 0 THEN 1 ELSE ventascab.idCliente = ?xidCliente END AND
			ventascab.fecEmision BETWEEN ?xfechaDesde AND ?xfechaHasta AND
			ventascab.aut_Resultado = 'A' AND
			ventascab.cbte = 'FC' AND
			ventascab.idVentasC NOT IN (
				SELECT
					idVentasC
				FROM
					vtasrtos
			)
	ENDTEXT
	
	lcSql = loRes.addParameter(lcSql, "xidCliente", ALLTRIM(STR(tnIdCliente)), .F., .F.)
	lcSql = loRes.addParameter(lcSql, "xfechaDesde", tdFechaDesde, .F., .T.)
	lcSql = loRes.addParameter(lcSql, "xfechaHasta", tdFechaHasta, .F., .T.)

	loRes.ActiveConnection = goConn.ActiveConnection
	loRes.cursor_name = "cur_x"
	loRes.OpenQuery(lcSql)

	SELECT cur_facturas
	APPEND FROM DBF("cur_x")

	SELECT cur_facturas
	GO TOP
	
	llOk = .T.
CATCH TO oException
	This.error_message = oException.Message + " en " + oException.Procedure + " Detalles: " + oException.Details
	llOk = .F.
FINALLY
	* Fuerzo el cierre del cursor
	IF USED("cur_x") THEN
		loRes.Close_Query()
	ENDIF
ENDTRY

RETURN llOk
ENDPROC
PROCEDURE consultar
******************************************************************
* Permite realizar la consutla de remitos en la consulta y
* reimpresión de remitos
* Parametros:
*	tnIdCliente => Id. del cliente seleccionado. Si es 0 obvia el filtro
*	tdFechaDesde => Fecha Desde
*	tdFechaHasta => Fecha Hasta
* Desarrollado por: Zulli, Leonardo Diego
* Fecha: 05/12/2025
******************************************************************
LPARAMETERS ;
	tnIdCliente,;
	tdFechaDesde,;
	tdFechaHasta
	
LOCAL loRes
LOCAL lcSql
LOCAL llOk

TRY
	llOk = .F.
	loRes = CREATEOBJECT("odbc_result")
	
	TEXT TO lcSql NOSHOW
		SELECT
			vtasrtos.idVtaRto,
			vtasrtos.idVentasC,
			CAST(vtasrtos.fecha AS DATE) AS 'fecha',
			vtasrtos.nrocomp,
			clientes.idCliente,
			clientes.razSoc,
			vtasrtos.razSocTrn,
			transp.direccion AS 'direccionTrn',
			localidad.codPostal AS 'codPostalTrn',
			localidad.descripcio AS 'localidadTrn',
			provincias.descripcio AS 'provinciaTrn'
			
		FROM
			vtasrtos
				INNER JOIN ventascab ON ventascab.idVentasC = vtasrtos.idVentasC
				INNER JOIN clientes ON clientes.idCliente = ventascab.idCliente
				INNER JOIN transp ON transp.idTransp = vtasrtos.idTransp
				INNER JOIN localidad ON localidad.idLocalid = transp.idLocalid
				INNER JOIN provincias ON provincias.idProvin = localidad.idProvin
		WHERE
			CASE WHEN ?xidCliente = 0 THEN 1 ELSE clientes.idCliente = ?xidCliente END AND
			vtasrtos.fecha BETWEEN ?xfechaDesde AND ?xfechaHasta
		ORDER BY
			vtasrtos.fecha DESC
	ENDTEXT
	
	lcSql = loRes.addParameter(lcSql, "xidCliente", ALLTRIM(STR(tnIdCliente)), .F., .F.)
	lcSql = loRes.addParameter(lcSql, "xfechaDesde", tdFechaDesde, .F., .T.)
	lcSql = loRes.addParameter(lcSql, "xfechaHasta", tdFechaHasta, .F., .T.)

	loRes.ActiveConnection = goConn.ActiveConnection
	loRes.Cursor_Name = "cur_x"
	loRes.OpenQuery(lcSql)
	SELECT cur_rtos
	ZAP
	APPEND FROM DBF("cur_x")
	GO TOP IN "cur_rtos"
	
	llOk = .T.
CATCH TO oException
	This.error_message = oException.Message + " en " + oException.Procedure + " Detalles: " + oException.Details
	llOk = .F.
FINALLY
	IF USED("cur_x") THEN
		loRes.Close_Query()
	ENDIF
	
	RELEASE loRes
ENDTRY

RETURN llOk

ENDPROC
PROCEDURE get_items
*******************************************************************
* Prepara los ítems para imprimir en cur_aux
* Desarrollado por: Zulli, Leonardo Diego
* Parametros:
*	tnIdVentasC => Id. del comprobante de venta seleccionado
* Fecha: 01/12/2025
*******************************************************************
LPARAMETERS tnIdVentasC

LOCAL loRes
LOCAL lcSql
LOCAL llOk

TRY
	loRes = CREATEOBJECT("odbc_result")
	
	* Limpio el cursor antes de cargarlo para evitar duplicaciones
	SELECT cur_aux
	ZAP
	
	TEXT TO lcSql NOSHOW
		SELECT
			ventasdet.idVentasD, ventasdet.idVentasC, ventasdet.idArticulo,
			ventasdet.cantidad, articulos.codArt, ventasdet.descripcio
		FROM
			ventasdet
				INNER JOIN articulos ON articulos.idArticulo = ventasdet.idArticulo
		WHERE
			ventasdet.idVentasC = ?xidVentasC
		ORDER BY
			ventasdet.idVentasD ASC, ventasdet.idVentasC ASC;		
	ENDTEXT
	
	lcSql = loRes.addParameter(lcSql, "xidVentasC", ALLTRIM(STR(tnIdVentasC)), .F., .F.)
	
	loRes.ActiveConnection = goConn.ActiveConnection
	loRes.Cursor_Name = "cur_x"
	loRes.OpenQuery(lcSql)
	SELECT cur_aux
	APPEND FROM DBF("cur_x")
	
	SELECT cur_aux
	GO TOP
	
	llOk = .T.
CATCH TO oException
	This.error_message = oException.Message + " en " + oException.Procedure + " Detalles: " + oException.Details
	llOk = .F.
FINALLY
	IF USED("cur_x") THEN
		loRes.Close_Query()
	ENDIF
	
	RELEASE loRes
ENDTRY

RETURN llOk
ENDPROC
PROCEDURE get_transporte_por_cliente
**************************************************************************
* Permite traer el transporte del cliente asociado a la factura
* Desarrollado por: Zulli, Leonardo Diego
* Fecha: 03/12/2025
**************************************************************************
LPARAMETERS tnIdCliente

LOCAL loRes
LOCAL lcSql
LOCAL llOk

TRY
	loRes = CREATEOBJECT("odbc_result")
	
	TEXT TO lcSql NOSHOW
		SELECT
			transp.idTransp,
			transp.codTrans,
			transp.razSoc,
			transp.direccion,
			localidad.idLocalid,
			localidad.codPostal,
			localidad.descripcio AS 'localidad',
			provincias.idProvin,
			provincias.descripcio AS 'provincia'
		FROM
			transp
				INNER JOIN clientes ON transp.idTransp = clientes.idTransp
				INNER JOIN localidad ON localidad.idLocalid = transp.idLocalid
				INNER JOIN provincias ON provincias.idProvin = localidad.idProvin
		WHERE
			clientes.idCliente = ?xidCliente	
	ENDTEXT
	
	lcSql = loRes.addParameter(lcSql, "xidCliente", ALLTRIM(STR(tnIdCliente)), .F., .F.)
	
	loRes.ActiveConnection = goConn.ActiveConnection
	loRes.Cursor_Name = "cur_x"
	loRes.OpenQuery(lcSql)
	
	SELECT cur_x
	This.idtransp = cur_x.idTransp
	This.codtrans = cur_x.codTrans
	This.razsoc = ALLTRIM(cur_x.razSoc)
	This.direcciontrn = ALLTRIM(cur_X.direccion)
	This.idlocalid_transp = cur_x.idLocalid
	This.cod_postal_transp = ALLTRIM(cur_x.codPostal)
	This.localidad_transp = ALLTRIM(cur_x.localidad)
	This.idProvin_transp = cur_x.idProvin
	This.provincia_transp = ALLTRIM(cur_x.provincia)

	llOk = .T.
CATCH TO oException
	This.error_message = oException.Message + " en " + oException.Procedure + " Detalles: " + oException.Details
	llOk = .F.
FINALLY
	IF USED("cur_x") THEN
		loRes.Close_Query()
	ENDIF
	
	RELEASE loRes
ENDTRY

RETURN llOk

ENDPROC
PROCEDURE get_tipo_cbte
******************************************************************
* Obtiene el tipo de comprobante para saber a qué impresora
* enviar a imprimir.
* Desarrollador por: Zulli, Leonardo Diego
* Parametros:
*	tcCbte 		=> Código de comprobante
*	tcTipoDoc 	=> Letra del comprobante
*	tnPtoVta 	=> Punto de venta del comprobante
* Fecha: 04/12/2025
******************************************************************
LOCAL loRes
LOCAL lcSql
LOCAL llOk
LOCAL lnPtoVta

TRY
	loRes = CREATEOBJECT("odbc_result")
	
	TEXT TO lcSql NOSHOW
		SELECT
			numerador.idNum,
			numerador.cbte,
			numerador.ptoVta,
			numerador.tipoDoc,
			numerador.repname,
			impresoras.impresora,
			impresoras.copias
		FROM
			numerador
				INNER JOIN impresoras ON impresoras.idNum = numerador.idNum
		WHERE
			numerador.cbte = ?xcbte AND
			numerador.tipoDoc = ?xtipoDoc AND
			numerador.ptoVta = ?xptoVta AND
			impresoras.hostName = ?xHost
	ENDTEXT
	
	lcSql = loRes.addParameter(lcSql, "xcbte", ALLTRIM(This.cbte), .T., .F.)
	lcSql = loRes.addParameter(lcSql, "xtipoDoc", ALLTRIM(This.tipodoc), .T., .F.)
	lcSql = loRes.addParameter(lcSql, "xptoVta", ALLTRIM(STR(This.ptovta)), .F., .F.)
	lcSql = loRes.addParameter(lcSql, "xHost", ALLTRIM(SYS(0)), .T., .F.)
	
	loRes.ActiveConnection = goConn.ActiveConnection
	loRes.Cursor_Name = "cur_x"
	loRes.OpenQuery(lcSql)
	SELECT cur_x
	IF RECCOUNT("cur_x") = 0 THEN
		this.error_message = "No hay numerador y/o impresora configurada para éste comprobante en éste puesto de trabajo"
	ELSE
		This.id_num = cur_x.idNum
		This.impresora = ALLTRIM(cur_x.impresora)
		this.copias = cur_x.copias
		This.repname = ALLTRIM(cur_x.repname)
	ENDIF

	llOk = .T.
CATCH TO oException
	This.error_message = oException.Message + " en " + oException.Procedure + " Detalles: " + oException.Details
	llOk = .F.
FINALLY
	loRes.Close_Query()
	RELEASE loRes
ENDTRY
ENDPROC
PROCEDURE eliminar_factura_de_cursor
************************************************************************
* Permite eliminar la factura del cursor de selección de facturas para
* que no se muestre más aquellas que se emitieron remitos.
* Desarrollado por: Zulli, Leonardo Diego
* Fecha: 04/12/2025
************************************************************************
SELECT cur_facturas
DELETE
GO TOP

ENDPROC
PROCEDURE get_detalle
*****************************************************************
* Obtiene el detalle para la consulta y reimpresión 
* Desarrollado por: Zulli, Leonardo Diego
* Parámetros:
*	tnIdVtaRto => Id del remito
*	tnIdVentasC => Id del comprobante de venta asociado
* NOTA: Ambos son clave primaria compuesta
* Fecha: 01/12/2025
*****************************************************************
LPARAMETERS ;
	tnIdVtaRto,;
	tnIdVentasC

LOCAL loRes
LOCAL lcSql
LOCAL llOk

TRY
	loRes = CREATEOBJECT("odbc_result")
	
	* Limpio el cursor antes de volverlo a cargar
	SELECT cur_facturas
	ZAP	

	TEXT TO lcSql NOSHOW
		SELECT
			ventascab.idVentasC, 
			ventascab.idCliente,
			clientes.razSoc,
			clientes.direccion,
			localidad.codPostal,
			localidad.descripcio AS 'localidad',
			provincias.descripcio AS 'provincia',
			paises.descripcio AS 'pais',
			sitiva.descripcio AS 'tipoIVA',
			clientes.nroCUIT,
			ventascab.fecEmision, 
			ventascab.fecvto,
			CONCAT(ventascab.cbte, ' ' , ventascab.tipoDoc, ' ', 
				REPEAT('0', 5 - LENGTH(ventascab.ptoVta)), ventascab.ptovta,
				'-', REPEAT('0', 8 - LENGTH(ventascab.numCbte)), ventascab.numCbte) 
			AS 'nroComp',
			ventascab.totFact,
			ventascab.nroOC,
			ventascab.tipoDoc,
			ventascab.numCbte AS 'nroCbte',
			ventascab.ptoVta,
			ventascab.observ
		FROM
			ventascab
				INNER JOIN clientes ON ventascab.idCliente = clientes.idCliente
				INNER JOIN localidad ON localidad.idLocalid = clientes.idLocalid
				INNER JOIN provincias ON provincias.idProvin = localidad.idProvin
				INNER JOIN paises ON paises.idPais = localidad.idPais
				INNER JOIN sitiva ON sitiva.idSitIVA = ventascab.idSitIVA
				INNER JOIN vtasrtos ON vtasrtos.idVentasC = ventascab.idVentasC
		WHERE
			vtasrtos.idVtaRto = ?xidVtaRto AND
			vtasrtos.idVentasC = ?xidVentasC
	ENDTEXT
	
	lcSql = loRes.addParameter(lcSql, "xidVtaRto", ALLTRIM(STR(tnIdVtaRto)), .F., .F.)
	lcSql = loRes.addParameter(lcSql, "xidVentasC", ALLTRIM(STR(tnIdVentasC)), .F., .F.)
	
	loRes.ActiveConnection = goConn.ActiveConnection
	loRes.cursor_name = "cur_x"
	loRes.OpenQuery(lcSql)

	SELECT cur_facturas
	APPEND FROM DBF("cur_x")

	SELECT cur_facturas
	GO TOP
	
	* Levanto los ítems
	This.get_items(tnIdVentasC)
	
	llOk = .T.
CATCH TO oException
	This.error_message = oException.Message + " en " + oException.Procedure + " Detalles: " + oException.Details
	llOk = .F.
FINALLY
	* Fuerzo el cierre del cursor
	IF USED("cur_x") THEN
		loRes.Close_Query()
	ENDIF
ENDTRY

RETURN llOk
ENDPROC
PROCEDURE Destroy
**********************************************************
* Cuando se destruye el objeto (Release) elimino los
* cursores de memoria.
* Fecha: 05/12/2025
**********************************************************

IF USED("cur_facturas") THEN
	USE IN cur_facturas
ENDIF

IF USED("cur_aux") THEN
	USE IN cur_aux
ENDIF

IF USED("cur_rtos") THEN
	USE IN cur_rtos
ENDIF
ENDPROC


************************************************************
OBJETO: cls_frm_detalle_remito
************************************************************
*** PROPIEDADES ***
Height = 453
Width = 947
DoCreate = .T.
BorderStyle = 2
Caption = "Detalle del remito"
idvtarto = 0
idventasc = 0
fecha = {}
nrocomp = 
idcliente = 0
razsoccliente = 
razsoctrn = 
direcciontrn = 
codpostaltrn = 
localidadtrn = 
provinciatrn = 
Name = "cls_frm_detalle_remito"

*** METODOS ***
PROCEDURE init_form
************************************************************************
* Inicializo el formulario recuperando los datos a mostrar
* Fecha: 05/12/2025
************************************************************************

Thisform.o_vtasrtos_dao.crear_cursores()
IF !Thisform.o_vtasrtos_dao.get_detalle(This.idvtarto, This.idventasc) THEN
	MESSAGEBOX(Thisform.o_vtasrtos_dao.error_message, 0+48, Thisform.Caption)
ELSE
	SELECT cur_rtos
	Thisform.txtRemito.Value = This.nrocomp
	Thisform.txtCliente.Value = ALLTRIM(STR(This.idcliente)) + " - " + ALLTRIM(This.razsoccliente)
	Thisform.txtFecha.Value = This.fecha
	Thisform.txtTransporte.Value = ALLTRIM(this.razsoctrn)

	SELECT cur_aux
	GO TOP IN "cur_aux"
	Thisform.grd_items.alias_name = "cur_aux"
	Thisform.grd_items.RecordSource = "cur_aux"
	Thisform.grd_items.list_controlsource = "cantidad,codArt,Descripcio"
	Thisform.grd_items.lista_ancho_cols = "100,150,300"
	Thisform.grd_items.titulos_cabeceras = "Cantidad,Código,Descripción"
	Thisform.grd_items.generar_grid()
	Thisform.grd_items.Refresh()
	
	&& Inicio el tipo de comprobante y punto de venta en el objeto DAO
	Thisform.o_vtasrtos_dao.cbte = "RTO"
	Thisform.o_vtasrtos_dao.tipodoc = "R"
	Thisform.o_vtasrtos_dao.ptovta = INT(VAL(getConfig("PTOVTARTO")))	
ENDIF

ENDPROC
PROCEDURE reimprimir_remito
*************************************************************
* Permite reimprimir el remito
* Fecha: 05/12/2025
*************************************************************
LOCAL m.Fecha
LOCAL m.NroCli
LOCAL m.RazSoc
LOCAL m.direccion
LOCAL m.codPostal
LOCAL m.localidad
LOCAL m.pcia
LOCAL m.TipoIva
LOCAL m.fecVto
LOCAL m.nroCUIT
LOCAL m.nroOC
LOCAL m.tipoDoc
LOCAL m.NroCbte
LOCAL lnCopias
LOCAL lcRepName
LOCAL m.razSocTransp
LOCAL m.direccionTransp
LOCAL m.localidadTrn
LOCAL m.Total
LOCAL m.nroCopia
LOCAL m.nroRto
LOCAL m.observ


* Obtengo los datos del remito
m.razSocTransp = ALLTRIM(This.razsoctrn)
m.direccionTransp = ALLTRIM(this.localidadtrn) + "(" + ALLTRIM(this.codpostaltrn) + ") " ;
	+ ALLTRIM(this.localidadtrn)


* Obtengo los datos de cabecera de la factura seleccionada actualmente
SELECT cur_facturas
m.Fecha = cur_facturas.fecEmision
m.NroCli = cur_facturas.idCliente
m.RazSoc = ALLTRIM(cur_facturas.razSoc)
m.direccion = ALLTRIM(cur_facturas.direccion)
m.codPostal = ALLTRIM(cur_facturas.codPostal)
m.localidad = ALLTRIM(cur_facturas.localidad)
m.pcia = ALLTRIM(cur_facturas.provincia)
m.TipoIva = ALLTRIM(cur_facturas.tipoIVA)
m.fecVto = cur_facturas.fecVto
m.nroCUIT = ALLTRIM(cur_facturas.nroCUIT)
m.nroOC = cur_facturas.nroOC
m.tipoDoc = ALLTRIM(cur_facturas.tipoDoc)
m.observ = ALLTRIM(cur_facturas.observ)

m.NroCbte = REPLICATE("0", 5 - LEN(ALLTRIM(STR(cur_facturas.ptovta)))) + ALLTRIM(STR(cur_facturas.ptovta)) ;
	+ "-" + REPLICATE("0", 8 - LEN(ALLTRIM(STR(cur_facturas.nroCbte)))) + ALLTRIM(STR(cur_facturas.nroCbte))
	
m.Total = cur_facturas.totFact
SELECT cur_rtos
m.nroRto = this.nrocomp

IF !Thisform.o_vtasrtos_dao.get_tipo_cbte() THEN
	MESSAGEBOX(Thisform.o_vtasrtos_dao.error_message, 0+48, Thisform.Caption)
ELSE
	m.nroCopia = 4
	lcRepName = Thisform.o_vtasrtos_dao.repname
	SELECT cur_aux
	REPORT FORM &lcRepName PREVIEW
ENDIF

ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Remito seleccionado:"
Height = 15
Left = 24
Top = 12
Width = 129
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Cliente:"
Height = 15
Left = 371
Top = 12
Width = 59
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Fecha:"
Height = 15
Left = 716
Top = 12
Width = 48
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Transporte:"
Height = 15
Left = 24
Top = 34
Width = 129
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Artículos"
Height = 15
Left = 24
Top = 58
Width = 72
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: txtRemito
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 157
Top = 7
Width = 199
ischaracter = .T.
Name = "txtRemito"

*** METODOS ***


************************************************************
OBJETO: txtCliente
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 422
Top = 7
Width = 279
ischaracter = .T.
Name = "txtCliente"

*** METODOS ***


************************************************************
OBJETO: txtFecha
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 762
Top = 7
Width = 138
ischaracter = .F.
isdatetime = .T.
Name = "txtFecha"

*** METODOS ***


************************************************************
OBJETO: txtTransporte
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 156
Top = 31
Width = 279
ischaracter = .T.
Name = "txtTransporte"

*** METODOS ***


************************************************************
OBJETO: grd_items
************************************************************
*** PROPIEDADES ***
Height = 326
Left = 24
Top = 76
Width = 913
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grd_items"
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
OBJETO: btnImprimir
************************************************************
*** PROPIEDADES ***
Top = 407
Left = 843
Name = "btnImprimir"

*** METODOS ***
PROCEDURE Click
***********************************************
* Llamo al método para reimprimir
* Fecha: 05/12/2025
***********************************************
Thisform.reimprimir_remito()
ENDPROC


************************************************************
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 407
Left = 893
Name = "btnCerrar"

*** METODOS ***


************************************************************
OBJETO: o_vtasrtos_dao
************************************************************
*** PROPIEDADES ***
Top = 413
Left = 112
Height = 17
Width = 32
Name = "o_vtasrtos_dao"

*** METODOS ***


************************************************************
OBJETO: cls_frm_detalle_remito
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


