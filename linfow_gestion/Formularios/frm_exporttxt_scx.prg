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
OBJETO: FRM_EXPORTTXT
************************************************************
*** PROPIEDADES ***
BorderStyle = 2
Height = 60
Width = 600
DoCreate = .T.
ShowTips = .T.
Caption = "Generar archivo de precios"
Name = "FRM_EXPORTTXT"
CONTENIDO.Top = -1
CONTENIDO.Left = 0
CONTENIDO.Width = 600
CONTENIDO.Height = 60
CONTENIDO.Name = "CONTENIDO"

*** METODOS ***
PROCEDURE exportar_ofertas
LOCAL loData, lcSql, lcRuta, lnErrFile, lcLinea
LOCAL lcFTPPath, loDT
LOCAL lcFTADDR

lcSql = ""
loData = CREATEOBJECT("odbc_result")
lcRuta = ""
lnErrFile = ""
lcLinea = ""
loDT = CREATEOBJECT("datetime")

lcFTPPath = ""
* lcRuta = PUTFILE("Guardar archivo", "update_list.txt")
lcRuta = "update_oferta.txt"
lcFTADDR = GetConfig("FT_ADDR")

IF ALLTRIM(lcRuta) == ""
	RETURN .F.
ENDIF

lnErrFile = FCREATE(lcRuta)

if(lnErrFile < 0)
	MESSAGEBOX("No se puede generar el archivo", 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

lcSql = "SELECT * FROM ofertas WHERE fecVigDD <= " + loDT.toMySql(DATE()) + " AND fecVigHH >= " + loDT.toMySql(DATE()) + " AND Fecbaja IS NULL"
loData.ActiveConnection = goConn.ActiveConnection
loData.Cursor_Name = "cur_oftas"

IF !loData.OpenQuery(lcSql) THEN
	MESSAGEBOX(loData.Error_Message, 0+48, Thisform.Caption)
	loData.Close_Query()
	RETURN .F.
ENDIF

SELECT cur_oftas
DO WHILE !EOF("cur_oftas")
	lcLinea = ALLTRIM(STR(cur_oftas.idOferta)) + "|"
	lcLinea = lcLinea + ALLTRIM(STR(cur_oftas.idArticulo)) + "|"
	lcLinea = lcLinea + ALLTRIM(cur_oftas.CodArt) + "|"
	lcLinea = lcLinea + ALLTRIM(DTOC(cur_oftas.fecVigDD)) + "|"
	lcLinea = lcLinea + ALLTRIM(DTOC(cur_oftas.fecVigHH)) + "|"
	lcLinea = lcLinea + ALLTRIM(STR(cur_oftas.porOfert, 10, 2)) + "|"
	lcLinea = lcLinea + ALLTRIM(STR(cur_oftas.impOfert, 10, 2)) + "|" + CHR(13) + CHR(10)
	
	FWRITE(lnErrFile, lcLinea)	
	
	SELECT cur_oftas
	SKIP
ENDDO

loData.Close_Query()
FCLOSE(lnErrFile)

&& Ahora hago la transferencia por FTP al hosting
IF connect2ftp("www.mgcarburacion.com.ar", "Yt64EaZR", "Mbcg53Az") THEN
	lcFtpPath = ALLTRIM(lcFTADDR) + "/update_oferta.txt"
	WAIT WINDOW "Subiendo ofertas: " + ALLTRIM(STR(ROUND((local2ftp(hFtpSession, lcRuta, lcFtpPath) / 1024) / 1024, 2), 10, 2)) NOWAIT
ENDIF

=InternetCloseHandle(hFtpSession)
=InternetCloseHandle(hOpen)

DELETE FILE lcRuta

Thisform.Contenido.btnAceptar.Enabled = .F.

RETURN .T.

ENDPROC
PROCEDURE exportar_equivs
LOCAL loData, lcSql, lcRuta, lnErrFile, lcLinea
LOCAL lcFTPPath, loDT
LOCAL lcFTADDR

lcSql = ""
loData = CREATEOBJECT("odbc_result")
lcRuta = ""
lnErrFile = ""
lcLinea = ""
loDT = CREATEOBJECT("datetime")

lcFTPPath = ""
* lcRuta = PUTFILE("Guardar archivo", "update_list.txt")
lcRuta = "update_equivs.txt"
lcFTADDR = GetConfig("FT_ADDR")

IF ALLTRIM(lcRuta) == ""
	RETURN .F.
ENDIF

lnErrFile = FCREATE(lcRuta)

if(lnErrFile < 0)
	MESSAGEBOX("No se puede generar el archivo", 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

lcSql = "SELECT * FROM art_equiv "
loData.ActiveConnection = goConn.ActiveConnection
loData.Cursor_Name = "cur_equivs"

IF !loData.OpenQuery(lcSql) THEN
	MESSAGEBOX(loData.Error_Message, 0+48, Thisform.Caption)
	loData.Close_Query()
	RETURN .F.
ENDIF

SELECT cur_equivs
DO WHILE !EOF("cur_equivs")
	lcLinea = ALLTRIM(STR(cur_equivs.idArtEqui)) + "|"
	lcLinea = lcLinea + ALLTRIM(STR(cur_equivs.idArtic_A)) + "|"
	lcLinea = lcLinea + ALLTRIM(STR(cur_equivs.idArtic_B)) + "|"
	lcLinea = lcLinea + ALLTRIM(STR(0)) + "|"
	lcLinea = lcLinea + ALLTRIM(STR(0)) + "|" + CHR(13) + CHR(10)
	
	FWRITE(lnErrFile, lcLinea)	
	
	SELECT cur_equivs
	SKIP
ENDDO

loData.Close_Query()
FCLOSE(lnErrFile)

&& Ahora hago la transferencia por FTP al hosting
IF connect2ftp("www.mgcarburacion.com.ar", "Yt64EaZR", "Mbcg53Az") THEN
	lcFtpPath = ALLTRIM(lcFTADDR) + "/update_equivs.txt"
	WAIT WINDOW "Subiendo Equivalencias: " + ALLTRIM(STR(ROUND((local2ftp(hFtpSession, lcRuta, lcFtpPath) / 1024) / 1024, 2), 10, 2)) NOWAIT
ENDIF

=InternetCloseHandle(hFtpSession)
=InternetCloseHandle(hOpen)

DELETE FILE lcRuta

Thisform.Contenido.btnAceptar.Enabled = .F.

RETURN .T.

ENDPROC
PROCEDURE Init
thisform.contenido.sel_Proveedor.txtCodigo.Enabled = .F.

ENDPROC
PROCEDURE Load
DODEFAULT()

CREATE CURSOR cur_articulo ( ;
	idarticulo int,;
	idfamilia int,;
	descfam varchar(60),;
	idsubfam int,;
	descsubfam varchar(60),;
	idmarca int,;
	descmarca varchar(60),;
	codart varchar(20),;
	descripcio varchar(200),;
	prlista float(10,2),;
	prant float(10,2),;
	alicIva float(10,2),;
	observac varchar(250),;
	espacio varchar(1),;
	linkFoto varchar(100),;
	discont varchar(5),;
	fecha datetime,;
	marcDirWeb varchar(60),;
	existencia int)
	
CREATE CURSOR ofertas (	;
	idOferta	int,;
	idArticulo	int,;
	fecVigDD	datetime,;
	fecVigHH	datetime,;
	porOfert	float(10, 2),;
	impOfert	float(10, 2))

CREATE CURSOR equivs (	;
	idArtic_A	int,;
	idArtic_B	int,;
	codart_A varchar(20),;
	codart_B varchar(20))
ENDPROC


************************************************************
OBJETO: chkFiltrarProv
************************************************************
*** PROPIEDADES ***
Top = 6
Left = 12
Height = 18
Width = 96
Alignment = 0
Caption = "Proveedor:"
Visible = .F.
Name = "chkFiltrarProv"

*** METODOS ***
PROCEDURE Click
IF this.Value = 1
	thisform.contenido.sel_Proveedor.txtCodigo.Enabled = .t.
ELSE
	thisform.contenido.sel_Proveedor.txtCodigo.Enabled = .f.
ENDIF

ENDPROC


************************************************************
OBJETO: sel_proveedor
************************************************************
*** PROPIEDADES ***
Top = 2
Left = 108
Visible = .F.
requerido = .F.
nombre_campo_codigo = idprov
nombre_campo_desc = razSoc
nombre_tabla = proveedor
pkfield = idprov
autocompletar_ceros = .F.
esnumerico = .T.
Name = "sel_proveedor"
TXTCODIGO.Name = "TXTCODIGO"
TXTDESCRIPCION.Name = "TXTDESCRIPCION"

*** METODOS ***


************************************************************
OBJETO: btnAceptar
************************************************************
*** PROPIEDADES ***
Top = 9
Left = 502
Name = "btnAceptar"

*** METODOS ***
PROCEDURE Click
LOCAL loData, lcSql, lcRuta, lnErrFile, lcLinea
LOCAL lcFTPPath
LOCAL lcFTADDR
LOCAL loSoap
LOCAL lnResult
LOCAL loTherm

lcFTPPath = ""
* lcRuta = PUTFILE("Guardar archivo", "update_list.txt")
lcRuta = "update_list.txt"
lcFTADDR = GetConfig("FT_ADDR")

loTherm = CREATEOBJECT("_thermometer")
loSoap = CREATEOBJECT("MSSOAP.SoapClient30")
loSoap.MSSoapInit("http://192.168.1.250/mgcarburacion/mg/update_serv.php?wsdl")

IF ALLTRIM(lcRuta) == ""
	RETURN .F.
ENDIF

** lnErrFile = FCREATE(lcRuta)

**if(lnErrFile < 0)
**	MESSAGEBOX("No se puede generar el archivo", 0+48, Thisform.Caption)
**	RETURN .F.
**ENDIF

lcSql = "select articulos.*, "
lcSql = lcSql + " 	familias.descripcio as descfam, "
lcSql = lcSql + "	subfam.descripcio as descsubfam, "
lcSql = lcSql + " 	marcas.descripcio as descmarca "
lcSql = lcSql + "from articulos, familias, subfam, marcas "
lcSql = lcSql + "where articulos.idfamilia = familias.idfamilia "
lcSql = lcSql + "  	and articulos.idsubfam = subfam.idsubfam "
lcSql = lcSql + "  	and articulos.idmarca = marcas.idmarca "
lcSql = lcSql + "	and articulos.mostrador = 0 "

IF thisform.contenido.chkFiltrarProv.Value = 1
	lcSql = lcSql + " and articulos.idProv = " + ALLTRIM(STR(thisform.contenido.sel_Proveedor.valcpoid)) + " "
ENDIF

lcSql = lcSql + "order by idArticulo asc "

loData = CREATEOBJECT("odbc_result")
loData.ActiveConnection = goConn.ActiveConnection
loData.Cursor_Name = "cur_tempo"
loData.OpenQuery(lcSql)

SELECT cur_tempo
IF RECCOUNT() > 0
	GO TOP
ENDIF

loTherm.show()
lcResult = loSoap.createFile(lcRuta)
IF (lcResult <> 0) THEN
	MESSAGEBOX("Error al crear el archivo", 0+48, Thisform.Caption)
	RETURN
ENDIF

SELECT cur_tempo
DO WHILE !EOF()
	SELECT cur_articulo
	APPEND BLANK
	REPLACE cur_articulo.idArticulo WITH cur_tempo.idarticulo
	REPLACE cur_articulo.idFamilia WITH cur_tempo.idFamilia ADDITIVE
	REPLACE cur_articulo.DescFam WITH ALLTRIM(cur_tempo.descFam) ADDITIVE
	REPLACE cur_articulo.idsubfam WITH cur_tempo.idsubfam ADDITIVE
	REPLACE cur_articulo.DescSubFam WITH ALLTRIM(cur_tempo.descSubFam) ADDITIVE
	REPLACE cur_articulo.idMarca WITH cur_tempo.idMarca ADDITIVE
	REPLACE cur_articulo.descMarca WITH ALLTRIM(cur_tempo.descMarca) ADDITIVE
	REPLACE cur_articulo.codArt WITH ALLTRIM(cur_tempo.codArt) ADDITIVE
	REPLACE cur_articulo.descripcio WITH ALLTRIM(cur_tempo.Descripcio) ADDITIVE
	REPLACE cur_articulo.prLista WITH cur_tempo.prventaMax ADDITIVE
	REPLACE cur_articulo.prAnt WITH 0 ADDITIVE
	REPLACE cur_articulo.alicIVA WITH cur_tempo.alicIVA ADDITIVE
	REPLACE cur_articulo.observac WITH ALLTRIM(cur_tempo.observ) ADDITIVE
	REPLACE cur_articulo.espacio WITH " " ADDITIVE
	REPLACE cur_articulo.linkFoto WITH IIF(ISNULL(cur_tempo.linkFoto), "", ALLTRIM(cur_tempo.linkFoto)) ADDITIVE
	REPLACE cur_articulo.discont WITH IIF(!ISNULL(cur_tempo.FecBaja),"True",IIF(!cur_tempo.habilitado,"True","False")) ADDITIVE
	REPLACE cur_articulo.fecha WITH DATETIME() ADDITIVE
	REPLACE cur_articulo.marcDirWeb WITH "" ADDITIVE
	REPLACE cur_articulo.existencia WITH 0 ADDITIVE
	
	lcLinea = ALLTRIM(STR(cur_articulo.idArticulo)) + "|"
	lcLinea = lcLinea + ALLTRIM(STR(cur_articulo.idFamilia)) + "|"
	lcLinea = lcLinea + ALLTRIM(cur_articulo.descFam) + "|"
	lcLinea = lcLinea + ALLTRIM(STR(cur_articulo.idsubfam)) + "|"
	lcLinea = lcLinea + ALLTRIM(cur_articulo.DescSubFam) + "|"
	lcLinea = lcLinea + ALLTRIM(STR(cur_articulo.idMarca)) + "|"
	lcLinea = lcLinea + ALLTRIM(cur_articulo.descMarca) + "|"
	lcLinea = lcLinea + ALLTRIM(cur_articulo.codart) + "|"
	lcLinea = lcLinea + ALLTRIM(cur_articulo.descripcio) + "|"
	lcLinea = lcLinea + ALLTRIM(STR(cur_articulo.prLista * 100, 10,2)) + "|"
	lcLinea = lcLinea + ALLTRIM(STR(cur_articulo.prAnt * 100, 10, 2)) + "|"
	lcLinea = lcLinea + ALLTRIM(STR(cur_articulo.alicIVA * 100, 10, 2)) + "|"
	lcLinea = lcLinea + ALLTRIM(cur_articulo.observac) + "|"
	&& lcLinea = lcLinea + cur_articulo.espacio + "|"
	lcLinea = lcLinea + ALLTRIM(cur_articulo.linkFoto) + "|"
	lcLinea = lcLinea + ALLTRIM(cur_articulo.discont) + "|"
	lcLinea = lcLinea + ALLTRIM(DTOC(cur_articulo.fecha)) + "|"
	lcLinea = lcLinea + ALLTRIM(cur_articulo.marcDirWeb) + "|"
	lcLinea = lcLinea + ALLTRIM("0") + "|" + CHR(13) + CHR(10)

	**FWRITE(lnErrFile, lcLinea)
	lnResult = loSoap.insertToFile(lcRuta, lcLinea)
	IF (lnResult = 0) THEN
		MESSAGEBOX("No se puede abrir el archivo", 0+48, thisform.Caption)
		RETURN 
	ELSE
		IF (lnResult = -1) THEN
			MESSAGEBOX("No se puede escribir el archivo", 0+48, thisform.Caption)
			RETURN 
		ENDIF
	ENDIF
	loTherm.update((RECNO() * 100) / RECCOUNT(), "Generando update_list.txt")

	SELECT cur_tempo
	SKIP
ENDDO

**FCLOSE(lnErrFile)
loTherm.Complete()
RELEASE loSoap

loData.Close_Query()

SELECT cur_articulo
IF RECCOUNT() > 0
	GO TOP
ENDIF

USE IN cur_articulo

&& Ahora hago la transferencia por FTP al hosting
**IF connect2ftp("168.181.185.95", "root", "uAA8jCeJY5QD") THEN
**	lcFtpPath = ALLTRIM(lcFTADDR) + "/update_list.txt"
**	WAIT WINDOW "Subiendo lista: " + ALLTRIM(STR(ROUND((local2ftp(hFtpSession, lcRuta, lcFtpPath) / 1024) / 1024, 2), 10, 2)) NOWAIT
**ENDIF

**=InternetCloseHandle(hFtpSession)
**=InternetCloseHandle(hOpen)

DELETE FILE lcRuta

*thisform.exportar_ofertas()
*thisform.exportar_equivs()

MESSAGEBOX("El proceso ha finalizado con éxito", 0+64, Thisform.Caption)
Thisform.Contenido.btnAceptar.Enabled = .F.

RETURN .T.
ENDPROC


************************************************************
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 9
Left = 548
Name = "btnCerrar"

*** METODOS ***


************************************************************
OBJETO: Label1
************************************************************
*** PROPIEDADES ***
Caption = 'Presione "Aceptar" para iniciar la creación del archivo de precios.'
Height = 17
Left = 16
Top = 24
Width = 360
Name = "Label1"

*** METODOS ***


************************************************************
OBJETO: 
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


