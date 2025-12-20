************************************************************
OBJETO: cls_data_codigos_invalidos
************************************************************
*** PROPIEDADES ***
Name = "cls_data_codigos_invalidos"

*** METODOS ***
PROCEDURE crear_cursores
*******************************************************
* Crea el cursor de la tabla de códigos inválidos.
*******************************************************
Create Cursor cur_pedinv ( ;
	idCliente int,;
	idPedCab int,;
	razSoc varchar(20),;
	fecEmis date)
	
Create Cursor cur_pedextinv ( ;
	id int,;
	idPedCab int,;
	idCliente int,;
	idArticulo int null,;
	idVentasC int null,;
	fecEmis datetime not null,;
	codArt varchar(20) not null,;
	cantidad N(10,2),;
	observ M NULL,;
	tipoSist int,;
	descripcio varchar(200) NULL,;
	mensaje varchar(60) NULL)
ENDPROC
PROCEDURE leer_datos
*******************************************************
* Permite leer los códigos inválidos desde la tabla
* pedextinv
*******************************************************

Local loRes
Local lcSql

loRes = CreateObject("odbc_result")

Text To lcSql Noshow

	Select
	    pedextinv.idCliente,
	    idPedCab,
	    MAX(clientes.razSoc) AS 'razSoc',
	    max(fecEmis) as 'fecEmis'
	from
		pedextinv
			INNER JOIN clientes ON clientes.idCliente = pedextinv.idCliente
	group by
		idCliente,
		idPedCab
	order by
		idCliente asc,
		idPedCab asc
EndText

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"
loRes.OpenQuery(lcSql)

Select cur_pedinv 
ZAP
Append From Dbf("cur_x")
loRes.Close_Query()

Select cur_pedinv
Go top

ENDPROC
PROCEDURE leer_items_invalidos
**********************************************
* Permite leer los items invalidos. 
**********************************************

Local loRes
Local lcSql
LOCAL lnIdArticulo
LOCAL lcDescripcion
lcSql = ""
lnIdArticulo = 0
loRes = CreateObject("odbc_result")

Text To lcSql Noshow

	SELECT
		pedextinv.id,
		pedextinv.idPedCab,
		pedextinv.idCliente,
		pedextinv.idArticulo,
		pedextinv.idVentasC,
		pedextinv.fecEmis,
		pedextinv.codArt,
	    pedextinv.cantidad,
	    pedextinv.observ,
	    pedextinv.tipoSist,
	    articulos.descripcio
	from
		pedextinv
			LEFT JOIN articulos ON pedextinv.idArticulo = articulos.idArticulo
	WHERE
		articulos.fecBaja IS null;
			
EndText

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"
loRes.OpenQuery(lcSql)

Select cur_pedextinv
Append From Dbf("cur_x")
loRes.Close_Query()

Select cur_pedextinv
Go top

DO WHILE !EOF("cur_pedextinv")
	lnIdArticulo = This.chequear_codigo(cur_pedextinv.codArt)
	
	IF lnIdArticulo = 0 then
		SELECT cur_pedextinv
		LOCK()
		REPLACE cur_pedextinv.idArticulo WITH lnIdArticulo
		REPLACE cur_pedextinv.mensaje WITH 'ERROR_CODIGO' ADDITIVE
		UNLOCK	
	ELSE
		
		TEXT TO lcSql noshow
		SELECT descripcio
		from articulos
		where idArticulo = ?xidArticulo
		ENDTEXT
		lcSql = loRes.AddParameter(lcSql, "xidArticulo", ALLTRIM(STR(lnIdArticulo )), .f., .f.)
		loRes.ActiveConnection = goConn.ActiveConnection
		loRes.Cursor_Name = "cur_art"
		loRes.OpenQuery(lcSql)
		
		SELECT cur_art
		lcDescripcion = cur_art.descripcio
		loRes.Close_Query()
		
		SELECT cur_pedextinv
		LOCK()
		replace cur_pedextinv.descripcio WITH lcDescripcion
		replace cur_pedextinv.mensaje WITH 'ERROR_CANTIDAD' additive
		UNLOCK
		
	ENDIF		
		
	SELECT cur_pedextinv
	SKIP
ENDDO

SELECT cur_pedextinv
GO TOP


ENDPROC
PROCEDURE chequear_codigo
LPARAMETERS tcCodigo

LOCAL loRes
LOCAL lcSql
LOCAL lnIdArticulo

loRes = CREATEOBJECT("odbc_result")

TEXT TO lcSql NOSHOW
	SELECT idArticulo FROM articulos WHERE codArt = ?xCodArt
ENDTEXT

lcSql = loRes.AddParameter(lcSql, "xCodArt", ALLTRIM(tcCodigo), .t., .f.)
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"
loRes.OpenQuery(lcSql)

SELECT cur_x
IF RECCOUNT("cur_x") = 0 THEN
	lnIdArticulo = 0
ELSE
	lnIdArticulo = cur_x.idArticulo
ENDIF
loRes.Close_Query()

RETURN lnIdArticulo
ENDPROC
PROCEDURE chequear_cantidad
********************************************************************
* Este método me devuelve el valor correcto de cantidad de despacho
********************************************************************
LPARAMETERS tnIdArticulo

LOCAL loRes
LOCAL lcSql
LOCAL lnCantidadDesp

loRes = CREATEOBJECT("odbc_result")
TEXT TO lcSql NOSHOW
	SELECT MIN(codiart.cantiDesp) AS 'cantiDesp' 
	FROM codiart 
	WHERE 
		codiart.idArticulo =  ?xId AND 
		(codiart.circuito = 'CV' OR codiart.circuito = 'V');
ENDTEXT

lcSql = loRes.AddParameter(lcSql, "xId", ALLTRIM(STR(tnIdArticulo)), .f., .f.)
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_name = "cur_x"
loRes.OpenQuery(lcSql)

SELECT cur_x
lnCantidadDesp = cur_x.cantiDesp

loRes.Close_Query()

RETURN lnCantidadDesp
ENDPROC
PROCEDURE es_multiplo
********************************************
* Devuelve True o False si es multiplo o no
********************************************
LPARAMETERS tnCantidad, tnDespacho
RETURN ((tnCantidad % tnDespacho) = 0)
ENDPROC


************************************************************
OBJETO: cls_form_corregir_pedido
************************************************************
*** PROPIEDADES ***
BorderStyle = 2
Height = 457
Width = 847
DoCreate = .T.
Caption = "Corregir Pedido"
BackColor = 255,217,217
id_cliente = 0
id_pedcab = 0
o_pedinv = 
Name = "cls_form_corregir_pedido"

*** METODOS ***
PROCEDURE recuperar_datos
*************************************************
* Permite recuperar los datos de pedidos invalido.
*************************************************
SELECT cur_pedinv 
thisform.txt_cliente.value = ALLTRIM(STR(cur_pedinv.idCliente)) + " - " + ALLTRIM(cur_pedinv.razSoc)
thisform.txt_fecha.Value = cur_pedinv.fecEmis

SELECT cur_pedextinv
GO Top

Thisform.grd_items.Refresh()
thisform.grd_items.SetFocus()
ENDPROC
PROCEDURE llenar_formulario
*************************************
* Llenar datos de formulario
*************************************
SELECT cur_pedextinv
IF cur_pedextinv.idArticulo <> 0 THEN
	* Si paso por acá es porque el código está bien
	thisform.cnt_edit_items.sel_articulos.txtCodigo.Value = ALLTRIM(cur_pedextinv.codArt)
	thisform.cnt_edit_items.sel_articulos.txtDescripcion.Value = ALLTRIM(cur_pedextinv.descripcio)
	thisform.cnt_edit_items.sel_articulos.valcpoid = cur_pedextinv.idArticulo	
ENDIF
thisform.cnt_edit_items.txt_cantidad.Value = cur_pedextinv.cantidad


ENDPROC
PROCEDURE blanquear_formulario
********************************************************
* Permite blanquear el formulario
********************************************************

Thisform.cnt_edit_items.sel_Articulos.blanquear()
Thisform.cnt_edit_items.txt_cantidad.Value = 0.00
ENDPROC
PROCEDURE Init
Thisform.o_pedinv = CREATEOBJECT("cls_data_codigos_invalidos")
Thisform.o_pedinv.crear_cursores()
Thisform.o_pedinv.leer_datos()
thisform.o_pedinv.leer_items_invalidos()

SELECT cur_pedextinv
thisform.grd_items.Alias_name = "cur_pedextinv"
thisform.grd_items.RecordSource = "cur_pedextinv"
thisform.grd_items.list_controlsource = "cantidad,codArt,descripcio,mensaje"
thisform.grd_items.lista_ancho_cols = "70,100,150,120"
thisform.grd_items.titulos_cabeceras = "Cantidad,Codigo,Descripcion,Mensaje"
thisform.grd_items.generar_grid()

SELECT cur_pedextinv
GO top
thisform.grd_items.Refresh()
ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Cliente:"
Left = 10
Top = 24
TabIndex = 7
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: txt_cliente
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 72
ReadOnly = .T.
TabIndex = 1
Top = 20
Width = 365
Name = "txt_cliente"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Fecha:"
Left = 10
Top = 52
TabIndex = 8
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: txt_fecha
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 72
ReadOnly = .T.
TabIndex = 2
Top = 49
Width = 143
isdatetime = .T.
Name = "txt_fecha"

*** METODOS ***


************************************************************
OBJETO: grd_items
************************************************************
*** PROPIEDADES ***
Height = 174
Left = 4
TabIndex = 3
Top = 90
Width = 839
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
PROCEDURE press_enter
Thisform.cnt_edit_items.sel_Articulos.txtCodigo.SetFocus()



ENDPROC
PROCEDURE AfterRowColChange
LPARAMETERS nColIndex
thisform.blanquear_formulario()
thisform.llenar_formulario()

ENDPROC


************************************************************
OBJETO: cnt_edit_items
************************************************************
*** PROPIEDADES ***
Top = 267
Left = 4
Width = 840
Height = 120
BackStyle = 1
TabIndex = 4
BackColor = 222,254,223
Name = "cnt_edit_items"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Articulo:"
Left = 87
Top = 44
TabIndex = 4
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Cantidad:"
Left = 87
Top = 72
TabIndex = 5
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: txt_cantidad
************************************************************
*** PROPIEDADES ***
Height = 22
Left = 150
TabIndex = 2
Top = 69
Width = 100
isnumeric = .T.
Name = "txt_cantidad"

*** METODOS ***
PROCEDURE Valid
LOCAL lnCantDesp

SELECT cur_pedextinv
lnCantDesp = thisform.o_pedinv.chequear_cantidad(cur_pedextinv.idArticulo)

IF this.Value <= 0 then
	MESSAGEBOX("Ingrese una cantidad válida", 0 + 48, thisform.Caption)
	RETURN .f.
ENDIF

IF !thisform.o_pedinv.es_multiplo(this.value, lnCantDesp) then
	MESSAGEBOX("Ingrese una cantidad multiplo de: " + ALLTRIM(STR(lnCantDesp)), 0 + 48, thisform.Caption)
	RETURN .f.	
ENDIF

RETURN .t.
ENDPROC


************************************************************
OBJETO: btn_aceptar
************************************************************
*** PROPIEDADES ***
Top = 60
Left = 748
TabIndex = 3
Name = "btn_aceptar"

*** METODOS ***
PROCEDURE Click
**********************************
* Corregir el error
**********************************
LOCAL loCmd
LOCAL lnId

loCmd = CREATEOBJECT("odbc_command")

SELECT cur_pedextinv
lnId = cur_pedextinv.id

	IF this.Parent.sel_articulos.valcpoid = 0 then
		MESSAGEBOX("Falta seleccionar el articulo", 48 + 0, thisform.Caption)
		thisform.cnt_edit_items.sel_Articulos.SetFocus()
		return
	endif	
	
	IF !thisform.cnt_edit_items.txt_cantidad.Valid() then
		thisform.cnt_edit_items.txt_cantidad.setFocus()
		return
	endif
	
	SELECT cur_pedextinv	
	LOCK()
	REPLACE cur_pedextinv.idArticulo with This.Parent.sel_articulos.valcpoid
	REPLACE cur_pedextinv.codArt with This.Parent.sel_articulos.txtCodigo.Value additive
	REPLACE cur_pedextinv.descripcio with This.Parent.sel_articulos.txtDescripcion.Value additive
	replace cur_pedextinv.cantidad WITH this.Parent.txt_cantidad.Value additive
	REPLACE cur_pedextinv.mensaje WITH "CORREGIDO" additive
	UNLOCK
	
	* HAGO UN UPDATE CON LOS DATOS NUEVOS	
	TEXT TO loCmd.CommandText NOSHOW
		update pedextinv
		set 
			idArticulo = ?xidArticulo,
			codArt = ?xcodArt,
			cantidad = ?xcantidad
		where
			id = ?xid 
	ENDTEXT
	loCmd.AddParameter("xidArticulo", ALLTRIM(STR(cur_pedextinv.idArticulo)), .F., .F.)
	loCmd.AddParameter("xcodArt", ALLTRIM(cur_pedextinv.codArt), .T., .F.)
	loCmd.AddParameter("xcantidad", ALLTRIM(STR(cur_pedextinv.cantidad)), .F., .F.)
	loCmd.AddParameter("xid", ALLTRIM(STR(cur_pedextinv.id)), .F., .F.)
	
	loCmd.ActiveConnection = goConn.ActiveConnection
	
	IF !loCmd.execute() THEN
		MESSAGEBOX(loCmd.ErrorMessage, 0+48, Thisform.Caption)
		RETURN
	ENDIF
	
	* Saco el regitro corregido de inválidos
	*TEXT TO loCmd.CommandText NOSHOW
	
	*	DELETE FROM pedextinv WHERE id = ?xid
	*ENDTEXT
	
	*loCmd.AddParameter("xid", ALLTRIM(STR(cur_pedextinv.id)), .F., .F.)
	
	*IF !loCmd.execute() THEN
	*	MESSAGEBOX(loCmd.ErrorMessage, 0+48, Thisform.Caption)
	*	RETURN
	*ENDIF

	SELECT cur_pedextinv
	thisform.grd_items.Refresh()	


Thisform.grd_items.SetFocus()



ENDPROC


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
FontSize = 10
Caption = "Corregir articulo:"
Height = 17
Left = 10
Top = 3
Width = 117
TabIndex = 6
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clslinea1
************************************************************
*** PROPIEDADES ***
Height = 0
Left = 3
Top = 21
Width = 833
BorderColor = 224,232,219
Name = "Clslinea1"

*** METODOS ***


************************************************************
OBJETO: lbl_mensaje
************************************************************
*** PROPIEDADES ***
FontSize = 9
Caption = ""
Height = 15
Left = 255
Top = 72
Width = 372
TabIndex = 7
ForeColor = 255,0,0
Name = "lbl_mensaje"

*** METODOS ***


************************************************************
OBJETO: sel_Articulos
************************************************************
*** PROPIEDADES ***
Top = 39
Left = 148
Width = 564
Height = 25
TabIndex = 1
autocompletar_ceros = .F.
esnumerico = .F.
nombre_campo_codigo = codArt
nombre_campo_desc = descripcio
nombre_tabla = articulos
permitir_agregar_regs = .F.
pkfield = idArticulo
requerido = .F.
alternative_cols = prFinalMax,prFinalMin
anchos_cols = 400,70,70
title_cols = Descripción,Precio May, Precio Min
criterio_filtro = articulos.habilitado = 1 AND articulos.fecBaja IS NULL
Name = "sel_Articulos"
txtCodigo.Height = 21
txtCodigo.Left = 2
txtCodigo.Top = 2
txtCodigo.Width = 181
txtCodigo.Name = "txtCodigo"
txtDescripcion.Left = 185
txtDescripcion.Top = 2
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: btn_grabar
************************************************************
*** PROPIEDADES ***
Top = 396
Left = 751
Height = 44
Width = 45
TabIndex = 5
Name = "btn_grabar"

*** METODOS ***
PROCEDURE Click
****************************************************
* Permite pasar los cambios a la tabla pedext
****************************************************
LOCAL loCmd

loCmd = CREATEOBJECT("odbc_command")

SELECT cur_pedextinv
GO TOP
DO WHILE !EOF("cur_pedextinv")
		
	IF cur_pedextinv.mensaje <> "CORREGIDO" THEN
		MESSAGEBOX("Quedan códigos por verificar", 0+48, thisform.Caption)
		RETURN
	ENDIF
	
	TEXT TO loCmd.CommandText NOSHOW
		CALL pedext_insert (?xidPedCab, ?xidCliente, ?xtipoSist, 
			?xidArticulo, ?xfecEmis, ?xcodArt, ?xcantidad, ?xobserv)
	ENDTEXT
	loCmd.AddParameter("xidPedCab", ALLTRIM(STR(cur_pedextinv.idPedCab)), .F., .F.)
	loCmd.AddParameter("xidCliente", ALLTRIM(STR(cur_pedextinv.idCliente)), .F., .F.)
	loCmd.AddParameter("xtipoSist", ALLTRIM(STR(cur_pedextinv.tipoSist)), .F., .F.)
	loCmd.AddParameter("xidArticulo", ALLTRIM(STR(cur_pedextinv.idArticulo)), .F., .F.)
	loCmd.AddParameter("xfecEmis", cur_pedextinv.fecEmis, .F., .T.)
	loCmd.AddParameter("xcodArt", ALLTRIM(cur_pedextinv.codArt), .T., .F.)
	loCmd.AddParameter("xcantidad", ALLTRIM(STR(cur_pedextinv.cantidad, 10, 2)), .F., .F.)
	loCmd.AddParameter("xobserv", ALLTRIM(cur_pedextinv.observ), .T., .F.)
	
	loCmd.ActiveConnection = goConn.ActiveConnection
	
	IF !loCmd.execute() THEN
		MESSAGEBOX(loCmd.ErrorMessage, 0+48, Thisform.Caption)
		RETURN
	ENDIF
	
	* Elimino el registro que se inserto dentro de pedext, para mantener la tabla
	* invalidos limpia
	
	TEXT TO loCmd.CommandText noshow
		delete 
		from pedextinv 
		where idArticulo = ?xidArticulo
	ENDTEXT
	loCmd.AddParameter("xidArticulo", ALLTRIM(STR(cur_pedextinv.idArticulo)), .F., .F.)

	IF !loCmd.execute() THEN
		MESSAGEBOX(loCmd.ErrorMessage, 0+48, Thisform.Caption)
		RETURN
	ENDIF
	
	SELECT cur_pedextinv
	SKIP
ENDDO
MESSAGEBOX("El pedido se corrigió satisfactoriamente, proceda a descargarlo", 0+64, Thisform.Caption)
thisform.Release()

ENDPROC


************************************************************
OBJETO: btn_salir
************************************************************
*** PROPIEDADES ***
Top = 396
Left = 798
Height = 44
Width = 45
TabIndex = 6
Name = "btn_salir"

*** METODOS ***
PROCEDURE Click
LOCAL lnResp

lnResp = MESSAGEBOX("Se perderán los cambios, ¿está seguro que desea salir?", 4+32, Thisform.Caption)
IF lnResp = 6 THEN
	DODEFAULT()
ENDIF
ENDPROC


************************************************************
OBJETO: cls_form_corregir_pedido
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_form_pedidos_online_v2
************************************************************
*** PROPIEDADES ***
Height = 566
Width = 308
DoCreate = .T.
BorderStyle = 3
Caption = "Pedidos On-Line"
WindowType = 1
Dockable = 1
o_pedidos_online = 
o_invalidos = 
Name = "cls_form_pedidos_online_v2"

*** METODOS ***
PROCEDURE actualizar_pedidos
*****************************************************************
* Permite verificar si hay pedidos nuevos para confeccionar
*****************************************************************
Thisform.o_pedidos_online.get_pedidos_pendientes()
select cur_bajados
go top
Thisform.grd_pedidos.Refresh()
Thisform.lbl_ultima_descarga.Caption = "Pendientes " + str(reccount("cur_bajados")) + " pedidos."
Thisform.lbl_ultima_descarga.Refresh()
ENDPROC
PROCEDURE descargar_pedidos
LOCAL lcUsaSiscli

Thisform.o_pedidos_online.descargar_pedidos_web()

lcUsaSiscli = getGlobalCFG("APIPEDSCL")

IF !EMPTY(lcUsaSiscli) then
	Thisform.o_pedidos_online.descargar_pedidos_siscli()
ENDIF

ENDPROC
PROCEDURE refrescar_pedidos
Thisform.descargar_pedidos()
Thisform.actualizar_pedidos()
select cur_bajados
Thisform.configurar_grilla()
Thisform.grd_pedidos.Refresh()

* Refresco la grilla de inválidos
thisform.o_invalidos.leer_datos()
SELECT cur_pedinv
Thisform.grd_invalidos.Refresh()
ENDPROC
PROCEDURE configurar_grilla
select cur_bajados
Thisform.grd_pedidos.RecordSource = "cur_bajados"
Thisform.grd_pedidos.Alias_name = "cur_bajados"
Thisform.grd_pedidos.list_controlsource = "fecEmis,idCliente,razSoc"
Thisform.grd_pedidos.lista_ancho_cols = "70,70,120"
Thisform.grd_pedidos.titulos_cabeceras = "Fecha,Cliente,Razón Social"
Thisform.grd_pedidos.generar_grid()

SELECT cur_pedinv
thisform.grd_invalidos.RecordSource = "cur_pedinv"
thisform.grd_invalidos.Alias_name = "cur_pedinv"
thisform.grd_invalidos.list_controlsource = "fecEmis,idCliente,razSoc"
this.grd_invalidos.lista_ancho_cols = "70,70,120"
thisform.grd_invalidos.titulos_cabeceras = "Fecha,Cliente,Razón Social"
thisform.grd_invalidos.generar_grid()



ENDPROC
PROCEDURE Init
***************************************************
* Configuro los controles del formulario en su
* estado inicial
***************************************************
* Configuro el timer
Thisform.o_timer.Enabled = .t.
&& Reviso cada 1 minuto
Thisform.o_timer.Interval = 60000


Thisform.o_pedidos_online = createobject("cls_data_pedidos_online")
Thisform.o_pedidos_online.crear_cursores()
thisform.o_invalidos = CREATEOBJECT("cls_data_codigos_invalidos")
thisform.o_invalidos.crear_cursores()
thisform.o_invalidos.leer_datos()
Thisform.configurar_grilla()

Thisform.o_pedidos_online.get_pedidos_pendientes()
Thisform.grd_pedidos.Refresh()

Thisform.Dock(2)

ENDPROC


************************************************************
OBJETO: grd_pedidos
************************************************************
*** PROPIEDADES ***
Anchor = 11
Height = 241
Left = 3
Top = 3
Width = 303
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grd_pedidos"
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
OBJETO: btnRefrescar
************************************************************
*** PROPIEDADES ***
Top = 507
Left = 216
Anchor = 12
Picture = ..\imagen\iconos bajados\nuevo-icono-9846.ico
Name = "btnRefrescar"

*** METODOS ***
PROCEDURE Click
*****************************************************************
* Permite verificar si hay pedidos nuevos para confeccionar
*****************************************************************
Thisform.refrescar_pedidos()
ENDPROC


************************************************************
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 508
Left = 262
Anchor = 12
Name = "btnCerrar"

*** METODOS ***


************************************************************
OBJETO: o_timer
************************************************************
*** PROPIEDADES ***
Top = 515
Left = 144
Height = 23
Width = 23
Name = "o_timer"

*** METODOS ***
PROCEDURE Timer
*thisform.btnRefrescar.SetFocus()
*thisform.btnRefrescar.Click()
Thisform.refrescar_pedidos()
ENDPROC


************************************************************
OBJETO: lbl_ultima_descarga
************************************************************
*** PROPIEDADES ***
FontSize = 12
Anchor = 14
Caption = ""
Height = 24
Left = 12
Top = 360
Width = 288
ForeColor = 0,128,0
Name = "lbl_ultima_descarga"

*** METODOS ***


************************************************************
OBJETO: grd_invalidos
************************************************************
*** PROPIEDADES ***
Anchor = 15
Height = 190
Left = 4
Top = 274
Width = 302
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grd_invalidos"
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
FontSize = 11
Anchor = 2
Caption = "PEDIDOS CON ITEMS INVALIDOS"
Height = 16
Left = 7
Top = 250
Width = 240
ForeColor = 255,0,0
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: btnModificar
************************************************************
*** PROPIEDADES ***
Top = 474
Left = 12
Height = 41
Width = 46
Anchor = 6
Picture = ..\imagen\btnmodify.png
Name = "btnModificar"

*** METODOS ***
PROCEDURE Click
LOCAL loForm_invalidos
loForm_invalidos = CREATEOBJECT("cls_form_corregir_pedido")
SELECT cur_pedinv
loForm_invalidos.id_cliente = cur_pedinv.idCliente
loForm_invalidos.id_pedcab = cur_pedinv.idPedCab
loForm_invalidos.recuperar_datos()
loForm_invalidos.show(1)
ENDPROC


************************************************************
OBJETO: cls_form_pedidos_online_v2
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_data_pedidos_online
************************************************************
*** PROPIEDADES ***
Name = "cls_data_pedidos_online"

*** METODOS ***
PROCEDURE get_pedidos_pendientes
*****************************************************************
* Obtiene los pedidos pendientes de confeccionar a partir de
* la tabla pedext.
* Fecha: 11/07/2024
*****************************************************************
LOCAL loRes
LOCAL lcSql

lcSql = "CALL pedext_getDescargados()"
loRes = CREATEOBJECT("odbc_result")
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"
loRes.OpenQuery(lcSql)
SELECT cur_bajados
ZAP
APPEND FROM DBF("cur_x")
loRes.Close_Query()
SELECT cur_bajados
GO TOP

ENDPROC
PROCEDURE crear_cursores
**********************************************************
* Crea los cursores que necesito para gestionar los
* pedidos descargados.
**********************************************************

create cursor cur_bajados ( ;
	idPedCab int,;
	idCliente int,;
	fecEmis D,;
	razSoc varchar(60))

create cursor cur_pedext ( ;
	idPedCab int,;
	idCliente int,;
	idArticulo int,;
	idVentaC int,;
	fecEmis datetime,;
	codArt varchar(20),;
	cantidad N(20, 2),;
	observ M,;
	proceado L,;
	tipoSist int)
ENDPROC
PROCEDURE descargar_pedidos_web
***************************************************
* Permite descargar los pedidos desde el hosting
***************************************************
local lcResult
local oPedidos
local loCmd
local lnDia
local lnMes
local lnAnio
local lcURL
local lcParametrosRecepcion
local i, j

lcURL = getGlobalCFG("APIPEDWEB")

lcResult = WinHttp(lcURL)
if alltrim(lcResult) == "[]" then
	return
endif

oPedidos = json_decode(lcResult)

loCmd = createobject("odbc_command")

for i = 1 to alen(oPedidos.array)
	for j = 1 to alen(oPedidos.array[i]._items.array)
		text to loCmd.CommandText noshow
			call pedext_insert (?xidPedCab, ?xidCliente, ?xtipoSist, ?xidArticulo, ?xfecEmis, ?xcodArt, ?xcantidad, ?xobserv)
		endtext
		loCmd.AddParameter("xidPedCab", alltrim(oPedidos.array[i]._idPedCab), .f., .f.)
		loCmd.AddParameter("xidCliente", alltrim(oPedidos.array[i]._idCliente), .f., .f.)
		loCmd.AddParameter("xtipoSist", alltrim(oPedidos.array[i]._tipoSist), .f., .f.)
		loCmd.AddParameter("xidArticulo", alltrim(oPedidos.array[i]._items.array[j]._idArticulo), .f., .f.)
		
		lnAnio = int(val(substr(oPedidos.array[i]._fecEmis, 1, 4)))
		lnMes = int(val(substr(oPedidos.array[i]._fecEmis, 6, 2)))
		lnDia = int(val(substr(oPedidos.array[i]._fecEmis, 9, 2)))
		
		loCmd.AddParameter("xfecEmis", datetime(lnAnio, lnMes, lnDia), .f., .t.)
		loCmd.AddParameter("xcodArt", alltrim(oPedidos.array[i]._items.array[j]._codart), .t., .f.)
		loCmd.AddParameter("xcantidad", alltrim(oPedidos.array[i]._items.array[j]._cantidad), .f., .f.)
		loCmd.AddParameter("xobserv", alltrim(oPedidos.array[i]._observ), .t., .f.)
		
		loCmd.ActiveConnection = goConn.ActiveConnection
		loCmd.execute()
	EndFor
	
	* Cambio el estado del pedido descargado	
	lcURL = getGlobalCFG("APIPEDREW")
	text to lcParametrosRecepcion noshow
	{"idPedCab": ?xidPedido}
	endtext
	lcParametrosRecepcion = trim(strtran(lcParametrosRecepcion, "?xidPedido", oPedidos.array[i]._idPedCab))
	lcResult = WinHttp(lcURL, "POST", lcParametrosRecepcion, "application/json")
EndFor

ENDPROC
PROCEDURE descargar_pedidos_siscli
***************************************************
* Permite descargar los pedidos desde el hosting
***************************************************
local lcResult
local oPedidos
local loCmd
local lnDia
local lnMes
local lnAnio
local lcURL
local lcParametrosRecepcion
LOCAL lnIdArticulo, lcMensaje, lnResp

* Agrego varible para la cantidad de despacho
LOCAL loPedInv
LOCAL lnCantDesp
LOCAL lnCantidad

local i, j
lcURL = getGlobalCFG("APIPEDSCL")
lcResult = WinHttp(lcURL)

loPedInv = CREATEOBJECT("cls_data_codigos_invalidos")

if alltrim(lcResult) == "[]" then
	return
endif

oPedidos = json_decode(lcResult)

loCmd = createobject("odbc_command")

FOR i = 1 TO ALEN(oPedidos.array)
	
	* Valido que el subarray _items exista
	IF ALLTRIM(VARTYPE(oPedidos.array[i]._items)) == "U" THEN
		lcMensaje = "El pedido Id Externo: " + alltrim(str(oPedidos.array[i]._idPedCab)) + " no se pudo descargar. " + CHR(10) + CHR(13);
			+ "Cliente: " + alltrim(str(oPedidos.array[i]._idCliente)) + CHR(10) + CHR(13) + CHR(10) + CHR(13);
			+ "Sugerencias: " + CHR(10) + CHR(13);
			+ "1. Espere unos minutos y vuelva a intentarlo, es posible que las conexión del hosting estén saturadas. " + CHR(10) + CHR(13) + CHR(10) + CHR(13);
			+ "2. A continuación anular el pedido y solicitarle al cliente que lo vuelva a enviar. Esto puede ocurrir debido a algún microcorte de internet en el cliente y que no haya levantado el pedido correctamente. " + CHR(10) + CHR(13) + CHR(10) + CHR(13);
			+ "3. Si el error persiste comuniquese con LINFOW. Por favor, enviar captura de éste mensaje" + CHR(13) + CHR(10) + CHR(13) + CHR(10) ;
			+ "Este pedido se envió desde el SISCLI."
		MESSAGEBOX(lcMensaje, 0+48, "Descargando pedidos")
		
		lnResp = MESSAGEBOX("¿Desea anular éste pedido y solicitar al cliente que lo reenvíe?", 4+32, "Descargando pedidos")
		IF lnResp = 6 THEN
			* Cambio el estado del pedido descargado	
			lcURL = getGlobalCFG("APIPEDRES")
			TEXT TO lcParametrosRecepcion NOSHOW
			{"idPedCab": ?xidPedido}
			ENDTEXT
			lcParametrosRecepcion = trim(strtran(lcParametrosRecepcion, "?xidPedido", alltrim(str(oPedidos.array[i]._idPedCab))))
			lcResult = WinHttp(lcURL, "POST", lcParametrosRecepcion, "application/json")
			
			* Vuelvo a invocar recursivamente a éste método
			This.descargar_pedidos_siscli()		
		ENDIF
	ELSE
	
		IF ALEN(oPedidos.array[i]._items.array) = oPedidos.array[i]._cantidad_items THEN
		
			FOR j = 1 TO ALEN(oPedidos.array[i]._items.array)
				* Filtro el idArticulo usando el codArt
				lnIdArticulo = this.get_idarticulo_by_codart(oPedidos.array[i]._items.array[j]._codArt)		
				* Variable para buscar si la cantidad está bien
				
				IF lnIdArticulo <> -1 then
					lnCantidad = oPedidos.array[i]._items.array[j]._cantidad
					lnCantDesp = loPedInv.chequear_cantidad(lnIdArticulo)			
				ENDIF
				
			*  Si el articulo es valido y la cantidad es mutiplo, agrega en pedinv
				If lnIdArticulo <> -1 .AND. loPedInv.es_multiplo(lnCantidad, lnCantDesp) Then
					* Si el artículo lo encuentra entonces, grabo el ítem en la tabla pedext para generar
					* el pedido en el sistema.
					
					TEXT TO loCmd.CommandText NOSHOW
						call pedext_insert (?xidPedCab, ?xidCliente, ?xtipoSist, ?xidArticulo, ?xfecEmis, ?xcodArt, ?xcantidad, ?xobserv)
					ENDTEXT
					
					loCmd.AddParameter("xidPedCab", alltrim(str(oPedidos.array[i]._idPedCab)), .f., .f.)
					loCmd.AddParameter("xidCliente", alltrim(str(oPedidos.array[i]._idCliente)), .f., .f.)
					loCmd.AddParameter("xtipoSist", alltrim(str(oPedidos.array[i]._tipoSist)), .f., .f.)
					loCmd.AddParameter("xidArticulo", ALLTRIM(STR(lnIdArticulo)), .f., .f.)
					
					lnAnio = int(val(substr(oPedidos.array[i]._fecEmis, 1, 4)))
					lnMes = int(val(substr(oPedidos.array[i]._fecEmis, 6, 2)))
					lnDia = int(val(substr(oPedidos.array[i]._fecEmis, 9, 2)))
					
					loCmd.AddParameter("xfecEmis", datetime(lnAnio, lnMes, lnDia), .f., .t.)
					loCmd.AddParameter("xcodArt", alltrim(oPedidos.array[i]._items.array[j]._codart), .t., .f.)
					loCmd.AddParameter("xcantidad", alltrim(str(oPedidos.array[i]._items.array[j]._cantidad)), .f., .f.)
					loCmd.AddParameter("xobserv", alltrim(oPedidos.array[i]._observ), .t., .f.)
					
					loCmd.ActiveConnection = goConn.ActiveConnection
					loCmd.execute()
				ELSE
					* Acá guardo en la tabla de códigos inválidos
					lnAnio = int(val(substr(oPedidos.array[i]._fecEmis, 1, 4)))
					lnMes = int(val(substr(oPedidos.array[i]._fecEmis, 6, 2)))
					lnDia = int(val(substr(oPedidos.array[i]._fecEmis, 9, 2)))
					IF lnIdArticulo <> -1 then
						IF !loPedInv.es_multiplo(lnCantidad, lnCantDesp)then
						* Dentro de esté if guardo cuando la cantidad no es multiplo
							TEXT TO loCmd.CommandText Noshow
								Insert Into pedextinv (idPedCab, idCliente, idArticulo, fecEmis, codArt, cantidad, observ, tipoSist)
								Values (?xidPedCab, ?xidCliente, ?xidArticulo, ?xfecEmis, ?xCodArt, ?xCantidad, ?xObserv, ?xTipoSist)
							ENDTEXT
							
							loCmd.AddParameter("xidPedCab", ALLTRIM(STR(oPedidos.array[i]._idPedCab)), .f., .f.)
							loCmd.AddParameter("xidCliente", ALLTRIM(STR(oPedidos.array[i]._idCliente)), .f., .f.)
							loCmd.AddParameter("xidArticulo", ALLTRIM(STR(lnIdArticulo)), .f., .f.)
							loCmd.AddParameter("xfecEmis", DATETIME(lnAnio, lnMes, lnDia), .f., .t.)
							loCmd.AddParameter("xCodArt", ALLTRIM(oPedidos.array[i]._items.array[j]._codart), .t., .f.)
							
							loCmd.AddParameter("xCantidad", ALLTRIM(STR(oPedidos.array[i]._items.array[j]._cantidad)), .f., .f.)
							
							loCmd.AddParameter("xObserv", ALLTRIM(oPedidos.array[i]._observ), .t., .f.)
							loCmd.AddParameter("xTipoSist", ALLTRIM(STR(oPedidos.array[i]._tipoSist)), .f., .f.)
							loCmd.ActiveConnection = goConn.ActiveConnection
							loCmd.execute()
						ENDIF
					ELSE
						* Si es multiplo pero, no es valido el codigo, entrá por acá 
						Text To loCmd.CommandText NoShow
						Insert Into pedextinv (idPedCab, idCliente, fecEmis, codArt, cantidad, observ, tipoSist)
						Values (?xidPedCab, ?xidCliente, ?xfecEmis, ?xCodArt, ?xCantidad, ?xObserv, ?xTipoSist)
						EndText
						
						loCmd.AddParameter("xidPedCab", alltrim(str(oPedidos.array[i]._idPedCab)), .f., .f.)
						loCmd.AddParameter("xidCliente", Alltrim(Str(oPedidos.array[i]._idCliente)), .f., .f.)
						loCmd.AddParameter("xfecEmis", datetime(lnAnio, lnMes, lnDia), .f., .t.)
						loCmd.AddParameter("xCodArt", Alltrim(oPedidos.array[i]._items.array[j]._codart), .t., .f.)
							
						loCmd.AddParameter("xCantidad", alltrim(str(oPedidos.array[i]._items.array[j]._cantidad)), .f., .f.)
							
						loCmd.AddParameter("xObserv", alltrim(oPedidos.array[i]._observ), .t., .f.)
						loCmd.AddParameter("xTipoSist", alltrim(str(oPedidos.array[i]._tipoSist)), .f., .f.)
						loCmd.ActiveConnection = goConn.ActiveConnection
						loCmd.execute()
					ENDIF						
				ENDIF
			ENDFOR
		
			* Cambio el estado del pedido descargado	
			lcURL = getGlobalCFG("APIPEDRES")
			TEXT TO lcParametrosRecepcion NOSHOW
			{"idPedCab": ?xidPedido}
			ENDTEXT
			lcParametrosRecepcion = trim(strtran(lcParametrosRecepcion, "?xidPedido", alltrim(str(oPedidos.array[i]._idPedCab))))
			lcResult = WinHttp(lcURL, "POST", lcParametrosRecepcion, "application/json")
		ENDIF
	ENDIF
ENDFOR

ENDPROC
PROCEDURE get_idarticulo_by_codart
*******************************************************
* Este metodo retorna el idArticulo usando como filtro
* el codArt del mismo.
*******************************************************

LPARAMETERS codArt
LOCAL loResult, lcSql
LOCAL lnIdArticulo

lnIdArticulo = 0
loResult = CREATEOBJECT("odbc_result")
lcSql = ""

lcSql = "SELECT idArticulo FROM articulos WHERE codArt = '" + ALLTRIM(codArt) + "'"
loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_art"
loResult.OpenQuery(lcSql)

SELECT cur_art
If Reccount("cur_art") > 0 Then
	GO TOP
	lnIdArticulo = cur_art.idArticulo
Else
	lnIdArticulo = -1
EndIf

RETURN lnIdArticulo
ENDPROC


