************************************************************
OBJETO: cls_frm_editoftas
************************************************************
*** PROPIEDADES ***
BorderStyle = 1
Height = 220
Width = 570
DoCreate = .T.
Caption = "Cargar Oferta - Se aplica solo a clientes Mayoristas"
Closable = .F.
presiono_aceptar = .F.
Name = "cls_frm_editoftas"

*** METODOS ***
PROCEDURE validar_campos
IF Thisform.txtFecVigDD.Value = {} THEN
	MESSAGEBOX("Debe ingresar la fecha de vigencia desde", 0+48, Thisform.Caption)
	Thisform.txtFecVigDD.SetFocus()
	RETURN .F.
ENDIF

IF Thisform.txtFecVigHH.Value = {} THEN
	MESSAGEBOX("Debe ingresar la fecha de vigencia hasta", 0+48, Thisform.Caption)
	Thisform.txtFecVigHH.SetFocus()
	RETURN .F.
ENDIF

IF Thisform.txtFecVigHH.Value <= Thisform.txtFecVigDD.Value THEN
	MESSAGEBOX("La fecha hasta debe ser mayor a la fecha desde", 0+48, Thisform.Caption)
	Thisform.txtFecVigHH.SetFocus()
	RETURN .F.
ENDIF

*IF Thisform.txtPorOfta.Value = 0 THEN
*	MESSAGEBOX("Debe ingresar el procentaje de oferta", 0+48, Thisform.Caption)
*	Thisform.txtPorOfta.SetFocus()
*	RETURN .F.
*ENDIF

IF Thisform.txtPrOfertaMay.Value = 0 THEN
	MESSAGEBOX("Debe ingresar el precio de oferta", 0+48, Thisform.Caption)
	Thisform.txtPrOfertaMay.SetFocus()
	RETURN .F.
ENDIF

RETURN .T.

ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Código:"
Height = 15
Left = 12
Top = 12
Width = 60
TabIndex = 9
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Descripción:"
Height = 15
Left = 12
Top = 37
Width = 84
TabIndex = 10
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: txtCodArt
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 144
ReadOnly = .T.
TabIndex = 1
Top = 10
Width = 169
Name = "txtCodArt"

*** METODOS ***


************************************************************
OBJETO: txtDescripcion
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 144
ReadOnly = .T.
TabIndex = 2
Top = 34
Width = 421
Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta6
************************************************************
*** PROPIEDADES ***
Caption = "Oferta en (%):"
Height = 15
Left = 12
Top = 85
Width = 80
TabIndex = 11
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: txtPorOfta
************************************************************
*** PROPIEDADES ***
OLEDragMode = 0
Height = 21
Left = 144
TabIndex = 5
Top = 82
Width = 122
isnumeric = .T.
Name = "txtPorOfta"

*** METODOS ***
PROCEDURE Valid
LOCAL lnPO, lnPL, lnDif
LOCAL lnPDesc

lnPO = 0.00
lnDif = 0.00
lnPL = Thisform.txtPrMay.Value
lnPDesc = Thisform.txtPorOfta.Value

lnPO = lnPL - (lnPL * (lnPDesc / 100))
lnDif = lnPL - lnPO

Thisform.txtPrOfertaMay.Value = ROUND(lnPO, 2)
thisform.txtDifMay.Value = lnDif
ENDPROC


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Precio de Venta:"
Height = 15
Left = 13
Top = 130
Width = 108
TabIndex = 12
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta8
************************************************************
*** PROPIEDADES ***
Caption = "Pr. Lista"
Height = 15
Left = 144
Top = 109
Width = 60
TabIndex = 13
Name = "Clsetiqueta8"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta9
************************************************************
*** PROPIEDADES ***
Caption = "Oferta"
Height = 15
Left = 239
Top = 109
Width = 39
TabIndex = 14
Name = "Clsetiqueta9"

*** METODOS ***


************************************************************
OBJETO: txtPrMay
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 144
TabIndex = 15
Top = 126
Width = 88
isnumeric = .T.
Name = "txtPrMay"

*** METODOS ***


************************************************************
OBJETO: txtPrOfertaMay
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 237
TabIndex = 6
Top = 126
Width = 88
isnumeric = .T.
Name = "txtPrOfertaMay"

*** METODOS ***
PROCEDURE Valid
LOCAL lnPO, lnPL, lnX

lnPO = 0.00
lnPL = 0.00
lnX = 0.00

lnPO = Thisform.txtPrOfertaMay.Value
lnPL = Thisform.txtPrMay.Value

lnX = 100 - ((lnPO * 100) / lnPL)

Thisform.txtPorOfta.Value = ROUND(lnX, 2)

ENDPROC
PROCEDURE InteractiveChange
LOCAL lnPO, lnPL, lnDif

lnPO = 0.00
lnPL = 0.00
lnDif = 0.00

lnPO = Thisform.txtPrOfertaMay.Value
lnPL = Thisform.txtPrMay.Value

lnDif = lnPL - lnPO

Thisform.txtDifMay.Value = lnDif

ENDPROC


************************************************************
OBJETO: Clsetiqueta10
************************************************************
*** PROPIEDADES ***
Caption = "Diferencia"
Height = 15
Left = 330
Top = 109
Width = 60
TabIndex = 16
Name = "Clsetiqueta10"

*** METODOS ***


************************************************************
OBJETO: txtDifMay
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 329
TabIndex = 17
Top = 126
Width = 88
isnumeric = .T.
Name = "txtDifMay"

*** METODOS ***


************************************************************
OBJETO: btnAceptar
************************************************************
*** PROPIEDADES ***
Top = 171
Left = 471
Height = 44
Width = 45
TabIndex = 7
Name = "btnAceptar"

*** METODOS ***
PROCEDURE Click
IF Thisform.validar_campos() THEN
	thisform.presiono_aceptar = .T.
	Thisform.Hide()
ENDIF
ENDPROC


************************************************************
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 171
Left = 518
Height = 44
Width = 45
TabIndex = 8
Name = "btnCerrar"

*** METODOS ***
PROCEDURE Click
Thisform.presiono_aceptar = .F.
Thisform.Hide()
ENDPROC


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Fecha Vigencia Desde:"
Height = 15
Left = 12
Top = 61
Width = 127
TabIndex = 18
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Fecha Vigencia Hasta:"
Height = 15
Left = 281
Top = 61
Width = 124
TabIndex = 19
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: txtFecVigDD
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 144
TabIndex = 3
Top = 58
Width = 122
isdatetime = .T.
Name = "txtFecVigDD"

*** METODOS ***


************************************************************
OBJETO: txtFEcVigHH
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 406
TabIndex = 4
Top = 58
Width = 122
isdatetime = .T.
Name = "txtFEcVigHH"

*** METODOS ***


************************************************************
OBJETO: cls_frm_editoftas
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_frm_ofertas
************************************************************
*** PROPIEDADES ***
BorderStyle = 1
Height = 520
Width = 1177
DoCreate = .T.
Caption = "Confeccionar Ofertas"
WindowState = 0
Name = "cls_frm_ofertas"
contenido.OLEDropEffects = 3
contenido.Top = -1
contenido.Left = -1
contenido.Width = 1251
contenido.Height = 522
contenido.Name = "contenido"

*** METODOS ***
PROCEDURE buscar_articulos
LOCAL loResArt, lcSql, lcValorBuscado
LOCAL loProg, lnCont, loDT
LOCAL lcFechaDD, lcFechaHH

loProg = CREATEOBJECT("_thermometer")
lnCont = 0
loResArt = CREATEOBJECT("odbc_result")
lcSql = ""
lcValorBuscado = ""
loDT = CREATEOBJECT("datetime")

IF Thisform.Contenido.txtFecVigDD.Value <> {} THEN
	lcFechaDD = loDT.ToMySql(Thisform.Contenido.txtFecVigDD.Value)
ELSE
	lcFechaDD = ""
ENDIF

IF Thisform.Contenido.txtFecVigHH.Value <> {} THEN
	lcFechaHH = loDT.ToMySql(Thisform.Contenido.txtFecVigHH.Value)
ELSE
	lcFechaHH = ""
ENDIF

lcSql = lcSql + "SELECT	"
lcSql = lcSql + "	IFNULL(ofertas.idOferta, 0) AS idOferta, "
lcSql = lcSql + "	articulos.idArticulo, "
lcSql = lcSql + "	articulos.codArt, "
lcSql = lcSql + "	articulos.descripcio, "
lcSql = lcSql + "	proveedor.razSoc, "
lcSql = lcSql + "	familias.descripcio AS familia,	"
lcSql = lcSql + "	subfam.descripcio AS subfam, "
lcSql = lcSql + "	ofertas.fecVigDD, "
lcSql = lcSql + "	ofertas.fecVigHH, "
lcSql = lcSql + "	ofertas.porOfert, "
lcSql = lcSql + "	ofertas.impOfert "
lcSql = lcSql + "FROM articulos INNER JOIN proveedor ON proveedor.idProv = articulos.idProv	"
lcSql = lcSql + "	INNER JOIN familias ON familias.idFamilia = articulos.idFamilia	"
lcSql = lcSql + "	INNER JOIN subfam ON subfam.idSubFam = articulos.idSubFam "
lcSql = lcSql + "	LEFT OUTER JOIN ( "
lcSql = lcSql + "		SELECT * "
lcSql = lcSql + "		FROM ofertas "
lcSql = lcSql + "		WHERE ofertas.fecBaja IS NULL) AS ofertas ON ofertas.idArticulo = articulos.idArticulo "
lcSql = lcSql + "WHERE (articulos.fecBaja IS NULL OR ofertas.fecBaja IS NULL) "

IF !(ALLTRIM(lcFechaDD) == "") .AND. !(ALLTRIM(lcFechaHH) == "") THEN
	lcSql = lcSql + "	AND ofertas.fecVigDD >= " + lcFechaDD + " "
	lcSql = lcSql + "	AND ofertas.fecVigHH <= " + lcFechaHH + " "
ELSE
	lcSql = lcSql + " AND (ofertas.fecVigDD <= CURRENT_DATE OR ofertas.fecVigDD IS NULL) "
	lcSql = lcSql + " AND (ofertas.fecVigHH >= CURRENT_DATE OR ofertas.fecVigHH IS NULL) "
ENDIF

IF !(ALLTRIM(thisform.contenido.txtValorBuscado.Value) == "") THEN
	lcValorBuscado = ALLTRIM(thisform.contenido.txtValorBuscado.Value)
	
	lcSql = lcSql + " AND (articulos.descripcio LIKE '%" + lcValorBuscado + "%' "
	lcSql = lcSql + "	OR proveedor.razSoc LIKE '%" + lcValorBuscado + "%' "
	lcSql = lcSql + "	OR familias.descripcio LIKE '%" + lcValorBuscado + "%' "
	lcSql = lcSql + "	OR subfam.descripcio LIKE '%" + lcValorBuscado + "%' "
	lcSql = lcSql + "	OR articulos.codArt LIKE '%" + lcValorBuscado + "%') "
ENDIF
lcSql = lcSql + "ORDER BY articulos.codArt "
_cliptext = lcSql
loResArt.ActiveConnection = goConn.ActiveConnection
loResArt.Cursor_Name = "cur_Art"

IF !loResArt.OpenQuery(lcSql) THEN
	MESSAGEBOX(lOResArt.Error_Message, 0+48, Thisform.Caption)
	Thisform.contenido.txtValorBuscado.SetFocus()
	RETURN .F.
ENDIF

SELECT cur_ofertas
ZAP

SELECT cur_Art
IF RECCOUNT("cur_Art") > 0 THEN
	GO TOP
ENDIF

loProg.Show()
lnCont = 0

SELECT cur_Art
DO WHILE !EOF("cur_Art")
	SELECT cur_ofertas
	APPEND BLANK
	REPLACE cur_ofertas.marcado WITH .F.
	REPLACE cur_ofertas.idOferta WITH INT(VAL(cur_Art.idOferta)) ADDITIVE
	REPLACE cur_ofertas.idArticulo WITH cur_Art.idArticulo ADDITIVE
	REPLACE cur_ofertas.codArt WITH cur_Art.codArt ADDITIVE
	REPLACE cur_ofertas.descripcio WITH cur_Art.descripcio ADDITIVE
	REPLACE cur_ofertas.razSoc WITH cur_Art.razSoc ADDITIVE
	REPLACE cur_ofertas.familia WITH cur_Art.familia ADDITIVE
	REPLACE cur_ofertas.subfam WITH cur_Art.subfam ADDITIVE
	REPLACE cur_ofertas.fecVigDD WITH IIF(ISNULL(cur_Art.fecVigDD), {}, cur_Art.fecVigDD) ADDITIVE
	REPLACE cur_ofertas.fecVigHH WITH IIF(ISNULL(cur_Art.fecVigHH), {}, cur_Art.fecVigHH) ADDITIVE
	REPLACE cur_ofertas.porOfert WITH IIF(ISNULL(cur_Art.porOfert), 0, cur_Art.porOfert) ADDITIVE
	REPLACE cur_ofertas.impOfert WITH IIF(ISNULL(cur_Art.impOfert), 0, cur_Art.impOfert) ADDITIVE

	lnCont = lnCont + 1
	loProg.Update((lnCont * 100) / RECCOUNT("cur_Art"), "Aguarde por favor, leyendo artículos...")
	SELECT cur_Art
	SKIP
ENDDO

loProg.Complete()

loResArt.Close_Query()

SELECT cur_ofertas
IF RECCOUNT("cur_ofertas") > 0 THEN
	GO TOP
ENDIF

Thisform.contenido.grdArticulos.Refresh()

RETURN .T.
ENDPROC
PROCEDURE cargar_oferta
LOCAL loForm, loResul, lcSql


loForm = CREATEOBJECT("cls_frm_editoftas")
loResult = CREATEOBJECT("odbc_result")
lcSql = ""

SELECT cur_ofertas
lcSql = "SELECT * FROM articulos WHERE idArticulo = " + ALLTRIM(STR(cur_ofertas.idArticulo))
loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_art"

IF !loResult.OpenQuery(lcSql) THEN
	MESSAGEBOX(loResult.Error_Message, 0+48, Thisform.Caption)
	RETURN
ENDIF

loForm.txtCodArt.Value = cur_art.codArt
loForm.txtDescripcion.Value = cur_art.descripcio
loForm.txtPrMay.value = cur_art.prventaMax
loForm.txtFecVigDD.Value = cur_ofertas.fecVigDD
loForm.txtFecVigHH.Value = cur_ofertas.fecVigHH
loForm.txtPorOfta.value = cur_ofertas.porOfert
loForm.txtPrOfertaMay.Value = cur_ofertas.impOfert

loResult.Close_Query()

loForm.Show()

IF loForm.presiono_aceptar THEN
	SELECT cur_ofertas
	LOCK()
	REPLACE cur_ofertas.marcado WITH .T. 
	REPLACE cur_ofertas.fecVigDD WITH loForm.txtFecVigDD.Value ADDITIVE 
	REPLACE cur_ofertas.fecVigHH WITH loForm.txtFecVigHH.Value ADDITIVE
	REPLACE cur_ofertas.porOfert WITH loForm.txtPorOfta.value ADDITIVE
	REPLACE cur_ofertas.impOfert WITH loForm.txtPrOfertaMay.value ADDITIVE
	UNLOCK
	
	Thisform.contenido.grdArticulos.Refresh()
ENDIF

loForm.release()

ENDPROC
PROCEDURE eliminar
LOCAL loCmd
LOCAL lcSql
LOCAL lnResp

loCmd = CREATEOBJECT("odbc_command")
lcSql = ""
lnResp = 0

SELECT cur_ofertas
IF RECCOUNT("cur_ofertas") = 0 THEN
	MESSAGEBOX("No hay registros para eliminar", 0+48, Thisform.Caption)
ELSE
	lnResp = MESSAGEBOX("¿Está seguro que desea eliminar la oferta?", 4+32, Thisform.Caption)
	IF lnResp = 6 THEN
		goConn.BeginTransaction()
		SELECT cur_ofertas
		lcSql = "UPDATE ofertas "
		lcSql = lcSql + "SET usuBaja = '" + ALLTRIM(gcCodUsu) + "', "
		lcSql = lcSql + "	fecBaja = current_timestamp, "
		lcSql = lcSql + "	idHostBaja = '" + ALLTRIM(SYS(0)) + "' "
		lcSql = lcSql + "WHERE ofertas.idOferta = " + ALLTRIM(STR(cur_ofertas.idOferta))
				
		loCmd.CommandText = lcSql
		loCmd.ActiveConnection = goConn.ActiveConnection
		IF !loCmd.Execute() THEN
			goConn.Rollback()
			MESSAGEBOX(loCmd.ErrorMessage, 0+48, Thisform.Caption)
		ELSE
			goConn.Commit()
			MESSAGEBOX("La oferta fué eliminada satisfactoriamente", 0+64, Thisform.Caption)
		ENDIF
	ENDIF
ENDIF

ENDPROC
PROCEDURE Load
DODEFAULT()
&& Creo el cursor donde voy a preparar los artículos en ofertas

CREATE CURSOR cur_ofertas (	;
	marcado		l,;
	idOferta	int,;
	idArticulo	int,;
	codArt		varchar(20),;
	descripcio	varchar(60),;
	razSoc		varchar(60),;
	familia		varchar(60),;
	subfam		varchar(60),;
	fecVigDD	date,;
	fecVigHH	date,;
	porOfert	float(10, 2),;
	impOfert	float(10, 2))

SELECT cur_ofertas	
INDEX ON idArticulo TAG idArticulo ASCENDING
INDEX ON fecVigDD TAG fecVigDD ASCENDING ADDITIVE
INDEX ON fecVigHH TAG fecVigHH ASCENDING ADDITIVE
INDEX ON porOfert TAG porOfert ASCENDING ADDITIVE
INDEX ON impOfert TAG impOfert ASCENDING ADDITIVE
INDEX ON razSoc TAG razSoc ASCENDING ADDITIVE
INDEX ON familia TAG familia ASCENDING ADDITIVE 
INDEX ON subfam TAG subfam ASCENDING ADDITIVE
INDEX ON codArt TAG codArt ASCENDING ADDITIVE
INDEX ON descripcio TAG descripcio ASCENDING ADDITIVE 

	

ENDPROC
PROCEDURE Init
DODEFAULT()

SELECT cur_ofertas
thisform.contenido.grdArticulos.alias_name = "cur_ofertas"
thisform.contenido.grdArticulos.RecordSource = "cur_ofertas"
thisform.contenido.grdArticulos.list_controlsource = "codArt,descripcio,razSoc,familia,subfam,fecVigDD,fecVigHH,porOfert,impOfert"
thisform.contenido.grdArticulos.lista_ancho_cols = "100,300,150,150,100,100,100,70,70"
thisform.contenido.grdArticulos.titulos_cabeceras = "Código,Descripción,Proveedor,Familia,SubFamilia,Vig. Desde,Vig. Hasta, Porcentaje,Importe"
thisform.contenido.grdArticulos.generar_grid()


ENDPROC
PROCEDURE validardetalle
LOCAL lnCont, lnResp

lnCont = 0

SELECT cur_ofertas
IF RECCOUNT("cur_ofertas") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_ofertas")
	IF cur_ofertas.marcado THEN
		lnCont = lnCont + 1
	ENDIF
	
	SELECT cur_ofertas
	SKIP
ENDDO

SELECT cur_ofertas
IF RECCOUNT("cur_ofertas") > 0 THEN
	GO TOP
ENDIF

IF lnCont > 0 THEN
	lnResp = MESSAGEBOX("Tiene artículos marcados para incluir en oferta, si no graba perderá los datos cargados, ¿desea continuar?", 4+32, Thisform.Caption)
	IF lnResp = 6 THEN
		RETURN .T.
	ELSE
		RETURN .F.
	ENDIF
ENDIF

RETURN .T.
ENDPROC


************************************************************
OBJETO: btnEliminar
************************************************************
*** PROPIEDADES ***
Top = 474
Left = 1032
Name = "btnEliminar"

*** METODOS ***
PROCEDURE Click
Thisform.eliminar()
Thisform.buscar_articulos()
Thisform.Contenido.grdArticulos.Refresh()
ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Fec. Vigencia Desde:"
Height = 15
Left = 24
Top = 52
Width = 144
TabIndex = 8
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Fec. Vigencia Hasta:"
Height = 15
Left = 288
Top = 52
Width = 121
TabIndex = 9
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: txtFecVigDD
************************************************************
*** PROPIEDADES ***
Alignment = 3
Value = {}
Height = 21
Left = 144
TabIndex = 2
Top = 49
Width = 121
Name = "txtFecVigDD"

*** METODOS ***


************************************************************
OBJETO: txtFecVigHH
************************************************************
*** PROPIEDADES ***
Alignment = 3
Value = {}
Height = 21
Left = 407
TabIndex = 3
Top = 49
Width = 124
Name = "txtFecVigHH"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Buscador de Artículos"
Height = 15
Left = 10
Top = 6
Width = 131
TabIndex = 10
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clslinea1
************************************************************
*** PROPIEDADES ***
Height = 0
Left = 143
Top = 14
Width = 1010
Name = "Clslinea1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Valor Buscado:"
Left = 23
Top = 28
TabIndex = 11
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: txtValorBuscado
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 144
TabIndex = 1
Top = 25
Width = 552
Name = "txtValorBuscado"

*** METODOS ***


************************************************************
OBJETO: btnBuscar
************************************************************
*** PROPIEDADES ***
Top = 40
Left = 722
TabIndex = 4
Name = "btnBuscar"

*** METODOS ***
PROCEDURE Click
IF thisform.validardetalle() THEN
	thisform.buscar_articulos()
ENDIF

Thisform.contenido.grdArticulos.SetFocus()
ENDPROC


************************************************************
OBJETO: btnGrabar
************************************************************
*** PROPIEDADES ***
Top = 475
Left = 1081
Height = 44
Width = 45
TabIndex = 6
Name = "btnGrabar"

*** METODOS ***
PROCEDURE Click
LOCAL loCommand, lcSql, loResult, lnProxID, loDT

loDT = CREATEOBJECT("datetime")
loCommand = CREATEOBJECT("odbc_command")
lcSql = ""
loResult = CREATEOBJECT("odbc_result")
lnProxID = 0

goConn.BeginTransaction()

SELECT cur_ofertas
IF RECCOUNT("cur_ofertas") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_ofertas")
	IF cur_ofertas.marcado THEN
		IF cur_ofertas.idOferta = 0 THEN
			lnProxID = goConn.getNextID("ofertas", "idOferta")
			
			lcSql = "INSERT INTO ofertas ( "
			lcSql = lcSql + "	idOferta, "
			lcSql = lcSql + "	idArticulo, "
			lcSql = lcSql + "	codArt, "
			lcSql = lcSql + "	fecVigDD, "
			lcSql = lcSql + "	fecVigHH, "
			lcSql = lcSql + "	porOfert, "
			lcSql = lcSql + "	impOfert, "
			lcSql = lcSql + "	usuAlta, "
			lcSql = lcSql + "	fecAlta, "
			lcSql = lcSql + "	idHostAlta) "
			lcSql = lcSql + "VALUES ( "
			lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", "
			lcSql = lcSql + ALLTRIM(STR(cur_ofertas.idArticulo)) + ", "
			lcSql = lcSql + "'" + ALLTRIM(cur_ofertas.codArt) + "', "
			lcSql = lcSql + loDT.toMySql(cur_ofertas.fecVigDD) + ", "
			lcSql = lcSql + loDT.toMySql(cur_ofertas.fecVigHH) + ", "
			lcSql = lcSql + ALLTRIM(STR(cur_ofertas.porOfert, 10, 2)) + ", "
			lcSql = lcSql + ALLTRIM(STR(cur_ofertas.impOfert, 10, 2)) + ", "
			lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
			lcSql = lcSql + loDT.getDateTime() + ", "
			lcSql = lcSql + "'" + SYS(0) + "')"
		ELSE
			lcSql = "UPDATE ofertas "
			lcSql = lcSql + "SET ofertas.fecVigDD = " + loDT.toMySql(cur_ofertas.fecVigDD) + ", "
			lcSql = lcSql + "	ofertas.fecVigHH = " + loDT.toMySql(cur_ofertas.fecVigHH) + ", "
			lcSql = lcSql + "	ofertas.porOfert = " + ALLTRIM(STR(cur_ofertas.porOfert, 10, 2)) + ", "
			lcSql = lcSql + "	ofertas.impOfert = " + ALLTRIM(STR(cur_ofertas.impOfert, 10, 2)) + ", "
			lcSql = lcSql + "	ofertas.usuModi = '" + ALLTRIM(gcCodUsu) + "', "
			lcSql = lcSql + "	ofertas.fecModi = current_timestamp, "
			lcSql = lcSql + "	ofertas.idHostModi = '" + ALLTRIM(SYS(0)) + "' "
			lcSql = lcSql + "WHERE ofertas.idOferta = " + ALLTRIM(STR(cur_ofertas.idOferta))
		ENDIF
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
			goConn.Rollback()
			RETURN .F.
		ENDIF
	ENDIF
		
	SELECT cur_ofertas
	SKIP
ENDDO

goConn.Commit()

MESSAGEBOX("Las ofertas fueron generadas satisfactoriamente. Si desea seguir incorporando artículos en ofertas, realice una nueva búsqueda", 0+64, thisform.Caption)
thisform.contenido.txtFecVigDD.Value = {}
thisform.contenido.txtFecVigHH.Value = {}
thisform.contenido.txtValorBuscado.Value = ""

SELECT cur_Ofertas
ZAP
thisform.contenido.grdArticulos.Refresh()

RETURN .T.
ENDPROC


************************************************************
OBJETO: btnCancelar
************************************************************
*** PROPIEDADES ***
Top = 475
Left = 5
Height = 44
Width = 45
TabIndex = 12
Name = "btnCancelar"

*** METODOS ***
PROCEDURE Click
SELECT cur_ofertas
ZAP

thisform.contenido.txtFecVigDD.Value = {}
thisform.contenido.txtFecVigHH.Value = {}
thisform.contenido.txtValorBuscado.Value = ""
thisform.contenido.grdArticulos.Refresh()
thisform.contenido.txtValorBuscado.SetFocus()
ENDPROC


************************************************************
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 475
Left = 1129
Height = 44
Width = 45
TabIndex = 7
Name = "btnCerrar"

*** METODOS ***


************************************************************
OBJETO: grdArticulos
************************************************************
*** PROPIEDADES ***
Height = 380
Left = 4
TabIndex = 5
Top = 89
Width = 1169
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
PROCEDURE press_enter
thisform.cargar_oferta()
ENDPROC


************************************************************
OBJETO: cls_frm_ofertas
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


