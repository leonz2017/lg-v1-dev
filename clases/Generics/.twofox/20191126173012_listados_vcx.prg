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


