************************************************************
OBJETO: cls_lst_clientes
************************************************************
*** PROPIEDADES ***
BorderStyle = 1
Height = 351
Width = 626
DoCreate = .T.
Caption = "Nomina de Clientes"
Name = "cls_lst_clientes"
contenido.Name = "contenido"

*** METODOS ***
PROCEDURE generar_listado
LOCAL lnIdClienteDD, lnIdClienteHH
LOCAL lnIdVendedorDD, lnIdVendedorHH
LOCAL lnIdLocalidDD, lnIdLocalidHH
LOCAL lnIdPciaDD, lnIdPciaHH
LOCAL lcSql, loResult

lnIdClienteDD = Thisform.Contenido.sel_clienteDD.valcpoid
lnIdClienteHH = Thisform.Contenido.sel_clienteHH.valcpoid
lnIdVendedorDD = Thisform.Contenido.sel_VendedorDD.valcpoid
lnIdVendedorHH = Thisform.Contenido.sel_vendedorHH.valcpoid
lnIdLocalidDD = Thisform.Contenido.sel_LocalidadDD.valcpoid
lnIdLocalidHH = Thisform.Contenido.sel_localidadHH.valcpoid
lnIdPciaDD = Thisform.Contenido.sel_ProvinciaDD.valcpoid
lnIdPciaHH = Thisform.Contenido.sel_ProvinciaHH.valcpoid

lcSql = ""
loResult = CREATEOBJECT("odbc_result")

IF lnIdClienteHH = 0 THEN
	lnIdClienteHH = 999999
ENDIF

IF lnIdVendedorHH = 0 THEN
	lnIdVendedorHH = 999999
ENDIF

IF lnIdLocalidHH = 0 THEN
	lnIdLocalidHH = 999999
ENDIF

IF lnIdPciaHH = 0 THEN
	lnIdPciaHH = 999999
ENDIF

lcSql = "SELECT	clientes.idCliente, clientes.razSoc, clientes.nomFant, clientes.direccion, "
lcSql = lcSql + "localidad.codPostal, localidad.descripcio AS localidad, condpagos.descripcio AS condPago, provincias.descripcio AS provincia, "
lcSql = lcSql + "sitiva.descripcio AS sitiva, vendedores.nombre as vendedor, tiposcli.descripcio as tipocli, transp.razSoc as transporte, "
lcSql = lcSql + "clientes.nroCUIT, clientes.telefono, clientes.celular, clientes.fax, clientes.email, clientes.contacto, clientes.mayorista, "
lcSql = lcSql + "clientes.desc1, clientes.desc2, clientes.desc3, clientes.desc4, ramos.descripcio as ramo "
lcSql = lcSql + "FROM clientes "
lcSql = lCsql + "	INNER JOIN localidad ON localidad.idLocalid = clientes.idLocalid "
lcSql = lcSql + "	INNER JOIN provincias ON provincias.idProvin = localidad.idProvin "
lcSql = lcSql + "	INNER JOIN condpagos ON condpagos.idCondPago = clientes.idCondPago "
lcSql = lcSql + "	INNER JOIN sitiva ON sitiva.idSitIVA = clientes.idSitIVA "
lcSql = lcSql + "	INNER JOIN vendedores ON vendedores.idVendedor = clientes.idVendedor "
lcSql = lcSql + "	INNER JOIN tiposcli ON tiposcli.idTipoCli = clientes.idTipoCli "
lcSql = lcSql + "	INNER JOIN transp ON transp.idTransp = clientes.idTransp "
lcSql = lcSql + "	INNER JOIN ramos ON ramos.idRamo = clientes.idRamo "

lcSql = lcSql + "WHERE clientes.idCliente BETWEEN " + ALLTRIM(STR(lnIdClienteDD)) + " AND " + ALLTRIM(STR(lnIdClienteHH)) + " "
lcSql = lcSql + "	AND clientes.idVendedor BETWEEN " + ALLTRIM(STR(lnIdVendedorDD)) + " AND " + ALLTRIM(STR(lnIdVendedorHH)) + " "
lcSql = lcSql + "	AND clientes.idLocalid BETWEEN " + ALLTRIM(STR(lnIdLocalidDD)) + " AND " + ALLTRIM(STR(lnIdLocalidHH)) + " "
lcSql = lcSql + "	AND localidad.idProvin BETWEEN " + ALLTRIM(STR(lnIdPciaDD)) + " AND " + ALLTRIM(STR(lnIdPciaHH)) + " "

loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_cli"

IF !loResult.OpenQuery(lcSql) THEN
	MESSAGEBOX(loResult.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_cli
IF RECCOUNT("cur_cli") = 0 THEN
	MESSAGEBOX("No hay registros para mostrar", 0+64, Thisform.Caption)
	loResult.Close_Query()
	RETURN .F.
ENDIF

SELECT cur_clientes
ZAP

SELECT cur_cli
GO TOP
DO WHILE !EOF("cur_cli")
	SELECT cur_clientes
	APPEND BLANK
	REPLACE cur_clientes.idCliente WITH cur_cli.idCliente
	REPLACE cur_clientes.razSoc WITH cur_cli.razSoc ADDITIVE
	REPLACE cur_clientes.nomFant WITH IIF(ISNULL(cur_cli.nomFant), "", cur_cli.nomFant) ADDITIVE
	REPLACE cur_clientes.direccion WITH IIF(ISNULL(cur_cli.direccion), "", cur_cli.direccion) ADDITIVE
	REPLACE cur_clientes.codPostal WITH IIF(ISNULL(cur_cli.codPostal), "", cur_cli.codPostal) ADDITIVE
	REPLACE cur_clientes.localidad WITH IIF(ISNULL(cur_cli.localidad), "", cur_cli.localidad) ADDITIVE
	REPLACE cur_clientes.provincia WITH IIF(ISNULL(cur_cli.provincia), "", cur_cli.provincia) ADDITIVE
	REPLACE cur_clientes.condPago WITH IIF(ISNULL(cur_cli.condPago), "", cur_cli.condPago) ADDITIVE
	REPLACE cur_clientes.sitIVA WITH IIF(ISNULL(cur_cli.sitIVA), "", cur_cli.sitIVA) ADDITIVE
	REPLACE cur_clientes.nroCUIT WITH IIF(ISNULL(cur_cli.nroCUIT), "", cur_cli.nroCUIT) ADDITIVE
	REPLACE cur_clientes.vendedor WITH IIF(ISNULL(cur_cli.vendedor), "", cur_cli.vendedor) ADDITIVE
	REPLACE cur_clientes.tipoCliente WITH IIF(ISNULL(cur_cli.tipoCli), "", cur_cli.tipoCli) ADDITIVE
	REPLACE cur_clientes.transporte WITH IIF(ISNULL(cur_cli.transporte), "", cur_cli.transporte) ADDITIVE
	REPLACE cur_clientes.telefono WITH IIF(ISNULL(cur_cli.telefono), "", cur_cli.telefono) ADDITIVE
	REPLACE cur_clientes.celular WITH IIF(ISNULL(cur_cli.celular), "", cur_cli.celular) ADDITIVE
	REPLACE cur_clientes.fax WITH IIF(ISNULL(cur_cli.fax), "", cur_cli.fax) ADDITIVE
	REPLACE cur_clientes.email WITH IIF(ISNULL(cur_cli.email), "", cur_cli.email) ADDITIVE
	REPLACE cur_clientes.contacto WITH IIF(ISNULL(cur_cli.contacto), "", cur_cli.contacto) ADDITIVE
	REPLACE cur_clientes.tipoVenta WITH IIF(cur_cli.mayorista, "MAYORISTA", "MINORISTA") ADDITIVE
	REPLACE cur_clientes.desc1 WITH cur_cli.desc1 ADDITIVE
	REPLACE cur_clientes.desc2 WITH cur_cli.desc2 ADDITIVE
	REPLACE cur_clientes.desc3 WITH cur_cli.desc3 ADDITIVE
	REPLACE cur_clientes.desc4 WITH cur_cli.desc4 ADDITIVE
	REPLACE cur_clientes.ramo WITH IIF(ISNULL(cur_cli.ramo), "", cur_cli.ramo) ADDITIVE

	SELECT cur_cli
	SKIP
ENDDO

loResult.Close_Query()

SELECT cur_clientes
GO TOP

RETURN .T.
ENDPROC
PROCEDURE Load
DODEFAULT()

CREATE CURSOR cur_clientes ( ;
	idCliente	int,;
	razSoc		varchar(60),;
	nomFant		varchar(60),;
	direccion	varchar(60),;
	codPostal	varchar(10),;
	localidad	varchar(60),;
	provincia	varchar(100),;
	condPago	varchar(60),;
	sitIVA		varchar(30),;
	nroCUIT		varchar(20),;
	vendedor	varchar(30),;
	tipoCliente	varchar(60),;
	transporte	varchar(30),;
	telefono	varchar(30),;
	celular		varchar(30),;
	fax			varchar(30),;
	email		varchar(100),;
	contacto	varchar(100),;
	tipoVenta	varchar(30),;
	desc1		float(10, 2),;
	desc2		float(10, 2),;
	desc3		float(10, 2),;
	desc4		float(10, 2),;
	ramo		varchar(30))
	
	

ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Cliente desde:"
Height = 15
Left = 25
Top = 25
Width = 104
TabIndex = 9
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Cliente hasta:"
Height = 15
Left = 25
Top = 50
Width = 109
TabIndex = 10
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Vendedor desde:"
Height = 15
Left = 25
Top = 89
Width = 110
TabIndex = 11
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Vendedor hasta:"
Height = 15
Left = 25
Top = 114
Width = 109
TabIndex = 12
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Localidad desde:"
Height = 15
Left = 25
Top = 153
Width = 108
TabIndex = 13
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: sel_clienteDD
************************************************************
*** PROPIEDADES ***
Top = 20
Left = 133
TabIndex = 1
nombre_tabla = clientes
nombre_campo_codigo = idCliente
nombre_campo_desc = razSoc
pkfield = idCliente
autocompletar_ceros = .F.
esnumerico = .T.
Name = "sel_clienteDD"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: sel_clienteHH
************************************************************
*** PROPIEDADES ***
Top = 45
Left = 133
TabIndex = 2
nombre_campo_codigo = idCliente
nombre_campo_desc = razSoc
nombre_tabla = clientes
pkfield = idCliente
esnumerico = .T.
autocompletar_ceros = .F.
Name = "sel_clienteHH"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: sel_vendedorDD
************************************************************
*** PROPIEDADES ***
Top = 84
Left = 133
TabIndex = 3
nombre_campo_codigo = idVendedor
nombre_campo_desc = nombre
nombre_tabla = vendedores
pkfield = idVendedor
autocompletar_ceros = .F.
esnumerico = .T.
Name = "sel_vendedorDD"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: sel_vendedorHH
************************************************************
*** PROPIEDADES ***
Top = 109
Left = 133
TabIndex = 4
nombre_campo_codigo = idVendedor
nombre_campo_desc = nombre
nombre_tabla = vendedores
pkfield = idVendedor
esnumerico = .T.
autocompletar_ceros = .F.
Name = "sel_vendedorHH"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: sel_localidadDD
************************************************************
*** PROPIEDADES ***
Top = 148
Left = 133
TabIndex = 5
nombre_campo_codigo = codPostal
nombre_campo_desc = descripcio
pkfield = idLocalid
nombre_tabla = localidad
autocompletar_ceros = .F.
esnumerico = .T.
Name = "sel_localidadDD"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta6
************************************************************
*** PROPIEDADES ***
Caption = "Localidad hasta:"
Height = 15
Left = 25
Top = 179
Width = 106
TabIndex = 14
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: sel_localidadHH
************************************************************
*** PROPIEDADES ***
Top = 173
Left = 133
TabIndex = 6
nombre_campo_codigo = codPostal
nombre_campo_desc = descripcio
nombre_tabla = localidad
pkfield = idLocalid
esnumerico = .T.
autocompletar_ceros = .F.
Name = "sel_localidadHH"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta7
************************************************************
*** PROPIEDADES ***
Caption = "Provincia desde:"
Height = 15
Left = 25
Top = 219
Width = 108
TabIndex = 15
Name = "Clsetiqueta7"

*** METODOS ***


************************************************************
OBJETO: sel_provinciaDD
************************************************************
*** PROPIEDADES ***
Top = 214
Left = 133
TabIndex = 7
nombre_campo_codigo = idProvin
nombre_campo_desc = descripcio
nombre_tabla = provincias
pkfield = idProvin
autocompletar_ceros = .F.
esnumerico = .T.
Name = "sel_provinciaDD"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta8
************************************************************
*** PROPIEDADES ***
Caption = "Provincia hasta:"
Height = 15
Left = 25
Top = 245
Width = 106
TabIndex = 16
Name = "Clsetiqueta8"

*** METODOS ***


************************************************************
OBJETO: sel_provinciaHH
************************************************************
*** PROPIEDADES ***
Top = 239
Left = 133
TabIndex = 8
nombre_campo_codigo = idProvin
nombre_campo_desc = descripcio
nombre_tabla = provincias
pkfield = idProvin
esnumerico = .T.
autocompletar_ceros = .F.
Name = "sel_provinciaHH"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: btnImprimir
************************************************************
*** PROPIEDADES ***
Top = 289
Left = 217
Name = "btnImprimir"

*** METODOS ***
PROCEDURE Click
LOCAL m.clienteDD, m.clienteHH
LOCAL m.vendedorDD, m.vendedorHH
LOCAL m.localidadDD, m.localidadHH
LOCAL m.provinciaDD, m.provinciaHH

IF !Thisform.generar_listado() THEN
	RETURN .F.
ENDIF

m.clienteDD = ALLTRIM(Thisform.Contenido.sel_clienteDD.txtDescripcion.Value)
m.clienteHH = ALLTRIM(Thisform.Contenido.sel_clienteHH.txtDescripcion.Value)
m.vendedorDD = ALLTRIM(Thisform.Contenido.sel_vendedorDD.txtDescripcion.Value)
m.vendedorHH = ALLTRIM(Thisform.Contenido.sel_vendedorHH.txtDescripcion.Value)
m.localidadDD = ALLTRIM(Thisform.Contenido.sel_localidadDD.txtDescripcion.Value)
m.localidadHH = ALLTRIM(Thisform.Contenido.sel_localidadHH.txtDescripcion.Value)
m.provinciaDD = ALLTRIM(Thisform.Contenido.sel_provinciaDD.txtDescripcion.Value)
m.provinciaHH = ALLTRIM(Thisform.Contenido.sel_provinciaHH.txtDescripcion.Value)

SELECT cur_clientes
REPORT FORM "rep_nomina_clientes" PREVIEW
ENDPROC


************************************************************
OBJETO: btnExcel
************************************************************
*** PROPIEDADES ***
Top = 289
Left = 266
Name = "btnExcel"

*** METODOS ***
PROCEDURE Click
IF !Thisform.generar_listado() THEN
	RETURN .F.
ENDIF

SELECT cur_clientes
genexcel("cur_clientes","NOMINA DE CLIENTES")

RETURN .T.
ENDPROC


************************************************************
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 289
Left = 569
Name = "btnCerrar"

*** METODOS ***


************************************************************
OBJETO: cls_lst_clientes
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_lst_artpedbyprov
************************************************************
*** PROPIEDADES ***
BorderStyle = 2
Height = 544
Width = 967
DoCreate = .T.
Caption = "Artículos pedidos por proveedor"
cbte = PED
Name = "cls_lst_artpedbyprov"
contenido.Top = 0
contenido.Left = 0
contenido.Width = 966
contenido.Height = 544
contenido.Name = "contenido"

*** METODOS ***
PROCEDURE crear_cursores
***********************************************************************
* Crea el cursor que se necesita para emitir este listado.
***********************************************************************

CREATE CURSOR cur_listado ( ;
	idProv int NOT null,;
	razSoc varchar(60) NOT NULL,;
	codArt varchar(40) NOT NULL,;
	descripcio varchar(200) NOT NULL)

CREATE CURSOR cur_lisprov ( ;
	idProv int NOT NULL,;
	razSoc varchar(40) NOT NULL)
	
CREATE CURSOR cur_lisart (;
	codArt varchar(40) NOT NULL,;
	descripcio varchar(200))
ENDPROC
PROCEDURE get_ventasdet_by_prov
*******************************************************************
* Obtiene los artículos pedidos por proveedor.
*******************************************************************

LOCAL loRes
LOCAL lcSql

LOCAL ldFechaDD
LOCAL ldFechaHH
LOCAL lnIdProvDD
LOCAL lnIdProvHH

* Recupero los parámetros que el usuario carga en el formulario
ldFechaDD = Thisform.contenido.pgf.Page1.txtFechaDesde.value
ldFechaHH = Thisform.contenido.pgf.Page1.txtFechaHasta.value
lnIdProvDD = Thisform.contenido.pgf.Page1.sel_proveedor_desde.Valcpoid
lnIdProvHH = Thisform.contenido.pgf.Page1.sel_proveedor_hasta.Valcpoid

* Configuro el objeto result y armo el SQL con sus parámetros
loRes = CREATEOBJECT("odbc_result")
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"

TEXT TO lcSql NOSHOW
	SELECT
		proveedor.idProv,
		proveedor.razSoc,
		articulos.codArt,
		articulos.descripcio
	FROM
		ventasdet
			INNER JOIN ventascab ON ventascab.idVentasC = ventasdet.idVentasC
			INNER JOIN articulos ON articulos.idArticulo = ventasdet.idArticulo
			INNER JOIN proveedor ON proveedor.idProv = articulos.idProv
	WHERE
		ventascab.cbte = ?pcbte AND
		(ventascab.fecEmision BETWEEN ?pfechaDesde AND ?pfechaHasta) AND
		(CASE WHEN ?pidProvDD = 0 THEN 1 ELSE proveedor.idProv BETWEEN ?pidProvDD AND ?pidProvHH END)
	GROUP BY
		proveedor.idprov,
		articulos.codArt
	ORDER BY
		proveedor.idProv,
		articulos.codArt
ENDTEXT

lcSql = loRes.AddParameter(lcSql, "pcbte", ALLTRIM(Thisform.cbte), .T., .F.)
lcSql = loRes.AddParameter(lcSql, "pfechaDesde", ldFechaDD, .F., .T.)
lcSql = loRes.AddParameter(lcSql, "pfechaHasta", ldFechaHH, .F., .T.)
lcSql = loRes.AddParameter(lcSql, "pidProvDD", ALLTRIM(STR(lnIdProvDD)), .F., .F.)
lcSql = loRes.AddParameter(lcSql, "pidProvHH", ALLTRIM(STR(lnIdProvHH)), .F., .F.)

loRes.OpenQuery(lcSql)
SELECT cur_listado
APPEND FROM DBF("cur_x")
loRes.Close_Query()

ENDPROC
PROCEDURE llenar_grid_proveedores
****************************************************
* Llena la grilla de proveedores
****************************************************

SELECT ;
	idProv,;
	MAX(razSoc) AS razSoc;
FROM ;
	cur_listado ;
GROUP BY ;
	idProv ;
ORDER BY ;
	idProv ;
INTO CURSOR cur_x

SELECT cur_lisprov
ZAP
APPEND FROM DBF("cur_x")
USE IN cur_x

select cur_lisprov
GO TOP 
thisform.contenido.pgf.Page2.grdProveedores.Refresh()
ENDPROC
PROCEDURE llenar_grid_articulos
****************************************************
* Llena la grilla de artículos en base al proveedor
* seleccionado.
****************************************************

SELECT ;
	codArt,;
	descripcio;
FROM;
	cur_listado;
WHERE;
	cur_listado.idProv = cur_lisprov.idProv;
INTO CURSOR cur_x

SELECT cur_lisart
ZAP
APPEND FROM DBF("cur_x")
USE IN cur_x

select cur_lisart
GO TOP
thisform.contenido.pgf.page2.grdArticulos.Refresh()
ENDPROC
PROCEDURE configurar_grillas
**************************************************************
* Configura las grillas de resultados.
**************************************************************

* Configuro la grilla de proveedores
select cur_lisprov
thisform.contenido.pgf.page2.grdProveedores.Alias_name = "cur_lisprov"
thisform.contenido.pgf.page2.grdProveedores.RecordSource = "cur_lisprov"
thisform.contenido.pgf.page2.grdProveedores.List_controlsource = "idProv,razSoc"
thisform.contenido.pgf.page2.grdProveedores.Lista_ancho_cols = "70,300"
thisform.contenido.pgf.page2.grdProveedores.Titulos_cabeceras = "Prov. Nº,Razón Social"
thisform.contenido.pgf.page2.grdProveedores.Generar_grid()

* Configuro la grilla de articulos
select cur_lisart
thisform.contenido.pgf.page2.grdArticulos.Alias_name = "cur_lisart"
thisform.contenido.pgf.page2.grdArticulos.RecordSource = "cur_lisart"
thisform.contenido.pgf.page2.grdArticulos.List_controlsource = "codArt,descripcio"
thisform.contenido.pgf.page2.grdArticulos.Lista_ancho_cols = "100,300"
thisform.contenido.pgf.page2.grdArticulos.Titulos_cabeceras = "Código,Descripción"
thisform.contenido.pgf.page2.grdArticulos.Generar_grid()
ENDPROC
PROCEDURE blanquear
********************************************
* Blanqueo los controles del formulario y
* vuelvo a la primara pestaña.
********************************************
thisform.contenido.pgf.page1.Enabled =  .t.
thisform.contenido.pgf.page2.Enabled =  .f.
thisform.contenido.pgf.page1.SetFocus()

thisform.contenido.pgf.page1.txtFechaDesde.value = DATE() - 30
thisform.contenido.pgf.page1.txtFechaHasta.Value = DATE()
thisform.contenido.pgf.Page1.sel_proveedor_desde.Blanquear()
thisform.contenido.pgf.page1.sel_proveedor_hasta.Blanquear()

thisform.contenido.pgf.page1.txtFechaDesde.SetFocus()
ENDPROC
PROCEDURE imprimir
********************************************************
* Permite imprimir los resultados.
********************************************************
LOCAL ldFechaDesde
LOCAL ldFechaHasta
LOCAL lcProveedorDesde
LOCAL lcProveedorHasta

ldFechaDesde = Thisform.contenido.pgf.page1.txtFechaDesde.value
ldFechaHasta = Thisform.contenido.pgf.Page1.txtFechaHasta.value
lcProveedorDesde = "(" ;
	+ ALLTRIM(STR(Thisform.contenido.pgf.page1.sel_proveedor_desde.txtCodigo.value)) + ") " ;
	+ ALLTRIM(Thisform.contenido.pgf.page1.sel_proveedor_desde.txtDescripcion.value)
	
lcProveedorHasta = "(" ;
	+ ALLTRIM(STR(Thisform.contenido.pgf.page1.sel_proveedor_hasta.txtCodigo.value)) + ") " ;
	+ ALLTRIM(Thisform.contenido.pgf.page1.sel_proveedor_hasta.txtDescripcion.value)

SELECT cur_listado
REPORT FORM "rep_artpedbyprov" PREVIEW
ENDPROC
PROCEDURE Load
DODEFAULT()
thisform.Crear_cursores()
ENDPROC
PROCEDURE Init
******************************************************************
* Establezco los contoles en su estado inicial.
******************************************************************

Thisform.Configurar_grillas()
Thisform.Blanquear()
ENDPROC


************************************************************
OBJETO: pgf
************************************************************
*** PROPIEDADES ***
ErasePage = .T.
Top = 3
Left = 4
Width = 961
Height = 497
Name = "pgf"
Page1.Caption = "Filtros"
Page1.Name = "Page1"
Page2.Caption = "Resultados"
Page2.Name = "Page2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Fecha desde:"
Left = 52
Top = 21
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Fecha desde:"
Left = 284
Top = 22
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: txtFechaDesde
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 138
Top = 17
Width = 116
isdatetime = .T.
Name = "txtFechaDesde"

*** METODOS ***


************************************************************
OBJETO: txtFechaHasta
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 368
Top = 17
Width = 116
isdatetime = .T.
Name = "txtFechaHasta"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Proveedor desde:"
Height = 15
Left = 25
Top = 45
Width = 108
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Proveedor hasta:"
Height = 15
Left = 30
Top = 69
Width = 101
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: sel_proveedor_desde
************************************************************
*** PROPIEDADES ***
Top = 39
Left = 136
nombre_tabla = proveedor
pkfield = idProv
title_cols = Razón Social
esnumerico = .T.
nombre_campo_codigo = idProv
nombre_campo_desc = razSoc
Name = "sel_proveedor_desde"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: sel_proveedor_hasta
************************************************************
*** PROPIEDADES ***
Top = 64
Left = 136
nombre_tabla = proveedor
pkfield = idProv
title_cols = Razón Social
esnumerico = .T.
nombre_campo_codigo = idProv
nombre_campo_desc = razSoc
Name = "sel_proveedor_hasta"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: btnBuscar
************************************************************
*** PROPIEDADES ***
Top = 44
Left = 666
Picture = ..\imagen\iconos bajados\buscar-buscar-ampliar-icono-9630.ico
ToolTipText = "Buscar"
Name = "btnBuscar"

*** METODOS ***
PROCEDURE Click
**********************************************
* Evento click del botón de búsqueda
**********************************************
thisform.Get_ventasdet_by_prov()
thisform.Llenar_grid_proveedores()
thisform.contenido.pgf.page2.Enabled =  .t.
thisform.contenido.pgf.page1.Enabled =  .f.
thisform.contenido.pgf.page2.SetFocus()

thisform.contenido.pgf.page2.grdProveedores.SetFocus()
ENDPROC


************************************************************
OBJETO: grdProveedores
************************************************************
*** PROPIEDADES ***
Height = 384
Left = 7
Top = 33
Width = 456
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdProveedores"
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
thisform.Llenar_grid_articulos()
ENDPROC


************************************************************
OBJETO: grdArticulos
************************************************************
*** PROPIEDADES ***
Height = 384
Left = 467
Top = 33
Width = 485
permitir_busqueda = .F.
permitir_ordenamiento = .F.
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
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Proveedores"
Left = 164
Top = 15
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Artículos del proveedor seleccionado"
Height = 15
Left = 590
Top = 15
Width = 269
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: btnImprimir
************************************************************
*** PROPIEDADES ***
Top = 421
Left = 418
Name = "btnImprimir"

*** METODOS ***
PROCEDURE Click
Thisform.imprimir()
ENDPROC


************************************************************
OBJETO: btnCancelar
************************************************************
*** PROPIEDADES ***
Top = 421
Left = 467
Name = "btnCancelar"

*** METODOS ***
PROCEDURE Click
thisform.Blanquear()
ENDPROC


************************************************************
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 498
Left = 918
Name = "btnCerrar"

*** METODOS ***


************************************************************
OBJETO: cls_lst_artpedbyprov
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


