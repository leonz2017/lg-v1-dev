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
OBJETO: FRM_IMP_PRECIOS
************************************************************
*** PROPIEDADES ***
BorderStyle = 0
Height = 445
Width = 700
DoCreate = .T.
Caption = "Importación y actualización de Articulos"
WindowType = 1
WindowState = 0
Name = "FRM_IMP_PRECIOS"
contenido.Top = 0
contenido.Left = 1
contenido.Width = 700
contenido.Height = 445
contenido.Name = "contenido"

*** METODOS ***
PROCEDURE imp_xls
LOCAL lcRuta, loExcel, lcCategorizar
LOCAL lnPrLista, lnBonif1, lnBonif2, lnBonif3, lnMargen, lnPorcentaje, lnPrListaExt
LOCAL lnAlicIVA, lcFamilia, lcSubFam, lcObserv

lnPrListaExt = 0.00
lnPrLista = 0.00
lnBonif1 = 0.00
lnBonif2 = 0.00
lnBonif3 = 0.00
lnMargen = 0.00
lnMargenMin = 0.00
lnPorcentaje = 0.00
lnAlicIVA = 0.00
lcCategorizar = getConfig("COLCATXLS")
lcFamilia = ""
lcSubFam = ""
lcObserv = ""
lcRuta = ""
loExcel = CREATEOBJECT("Excel.Application")
progressBar = CREATEOBJECT("_thermometer")

lcRuta = THISFORM.contenido.txtArchivo.VALUE

&& SELECT cur_Artic
&& APPEND FROM (lcRuta) TYPE XLS

WITH loExcel.APPLICATION
	.VISIBLE = .F.
	.workbooks.OPEN(lcRuta)
	lnCol = .ActiveSheet.UsedRange.COLUMNS.COUNT
	lnFil = .ActiveSheet.UsedRange.ROWS.COUNT
	progressBar.SHOW()

	FOR i = 2 TO lnFil
		* Valido que el precio tenga algo o que la información esté bien cargada
		IF !THISFORM.validar_datos_numericos(.ActiveSheet.cells(i, 5).VALUE) THEN
			MESSAGEBOX("El precio está vacío o contiene un dato erróneo en la fila : " + ALLTRIM(STR(i)) + ;
				". Corrija la planilla y vuelva a intentarlo", 0+48, THISFORM.CAPTION)
			.workbooks.CLOSE()
			.QUIT
			RELEASE loExcel
			THISFORM.contenido.btncancelar.CLICK()
			RETURN .F.
		ENDIF

		IF THISFORM.contenido.opgMoneda.option2.VALUE = 1 .OR. THISFORM.contenido.opgMoneda.option3.VALUE = 1
			lnPrListaExt = .ActiveSheet.cells(i, 5).VALUE
			lnPrLista = lnPrListaExt * THISFORM.contenido.txtCotizadcion.VALUE
		ELSE
			lnPrLista 	= .ActiveSheet.cells(i, 5).VALUE
		ENDIF

		* Valido bonificación los campos de bonificaciones, margenes y alícuota
		IF !THISFORM.validar_datos_numericos(.ActiveSheet.cells(i, 6).VALUE) THEN
			MESSAGEBOX("La bonificación 1 está vacío o contiene un dato erróneo en la fila : " + ALLTRIM(STR(i)) + ;
				". Corrija la planilla y vuelva a intentarlo", 0+48, THISFORM.CAPTION)
			.workbooks.CLOSE()
			.QUIT
			RELEASE loExcel
			THISFORM.contenido.btncancelar.CLICK()
			RETURN .F.
		ENDIF

		IF !THISFORM.validar_datos_numericos(.ActiveSheet.cells(i, 7).VALUE) THEN
			MESSAGEBOX("La bonificación 2 está vacío o contiene un dato erróneo en la fila : " + ALLTRIM(STR(i)) + ;
				". Corrija la planilla y vuelva a intentarlo", 0+48, THISFORM.CAPTION)
			.workbooks.CLOSE()
			.QUIT
			RELEASE loExcel
			THISFORM.contenido.btncancelar.CLICK()
			RETURN .F.
		ENDIF

		IF !THISFORM.validar_datos_numericos(.ActiveSheet.cells(i, 8).VALUE) THEN
			MESSAGEBOX("La bonificación 3 está vacío o contiene un dato erróneo en la fila : " + ALLTRIM(STR(i)) + ;
				". Corrija la planilla y vuelva a intentarlo", 0+48, THISFORM.CAPTION)
			.workbooks.CLOSE()
			.QUIT
			RELEASE loExcel
			THISFORM.contenido.btncancelar.CLICK()
			RETURN .F.
		ENDIF

		IF !THISFORM.validar_datos_numericos(.ActiveSheet.cells(i, 9).VALUE) THEN
			MESSAGEBOX("La Margen Mayorista está vacío o contiene un dato erróneo en la fila : " + ALLTRIM(STR(i)) + ;
				". Corrija la planilla y vuelva a intentarlo", 0+48, THISFORM.CAPTION)
			.workbooks.CLOSE()
			.QUIT
			RELEASE loExcel
			THISFORM.contenido.btncancelar.CLICK()
			RETURN .F.
		ENDIF

		IF !THISFORM.validar_datos_numericos(.ActiveSheet.cells(i, 10).VALUE) THEN
			MESSAGEBOX("La Margen Minorista está vacío o contiene un dato erróneo en la fila : " + ALLTRIM(STR(i)) + ;
				". Corrija la planilla y vuelva a intentarlo", 0+48, THISFORM.CAPTION)
			.workbooks.CLOSE()
			.QUIT
			RELEASE loExcel
			THISFORM.contenido.btncancelar.CLICK()
			RETURN .F.
		ENDIF

		IF !THISFORM.validar_datos_numericos(.ActiveSheet.cells(i, 11).VALUE) THEN
			MESSAGEBOX("El alícuota de IVA está vacío o contiene un dato erróneo en la fila: " + ALLTRIM(STR(i)) + ;
				". Corrija la planilla y vuelva a intentarlo", 0+48, THISFORM.CAPTION)
			.workbooks.CLOSE()
			.QUIT
			RELEASE loExcel
			THISFORM.contenido.btncancelar.CLICK()
			RETURN .F.
		ENDIF

		lnBonif1 	= .ActiveSheet.cells(i, 6).VALUE
		lnBonif2 	= .ActiveSheet.cells(i, 7).VALUE
		lnBonif3 	= .ActiveSheet.cells(i, 8).VALUE
		lnMargen 	= .ActiveSheet.cells(i, 9).VALUE
		lnMargenMin = .ActiveSheet.cells(i, 10).VALUE
		lnAlicIVA 	= .ActiveSheet.cells(i, 11).VALUE

		* Valido familias y subfamilias
		IF ISNULL(.ActiveSheet.cells(i, 12).VALUE) THEN
			MESSAGEBOX("La familia esta vacía en la fila: " + ALLTRIM(STR(i)) + ;
				". Corrija la planilla y vuelva a intentarlo", 0+48, THISFORM.CAPTION)
			.workbooks.CLOSE()
			.QUIT
			RELEASE loExcel
			THISFORM.contenido.btncancelar.CLICK()
			RETURN .F.
		ENDIF
		
		* Valido que la familia no supere los 60 caracteres
		IF !Thisform.validate_text_field(ALLTRIM(.ActiveSheet.cells(i, 12).VALUE), 60, i, "familia") THEN
			.workbooks.close()
			.quit
			RELEASE loExcel
			THISFORM.contenido.btnCancelar.CLICK()
			RETURN .F.
		ENDIF

		IF ISNULL(.ActiveSheet.cells(i, 13).VALUE) THEN
			MESSAGEBOX("La subfamilia esta vacía en la fila: " + ALLTRIM(STR(i)) + ;
				". Corrija la planilla y vuelva a intentarlo", 0+48, THISFORM.CAPTION)
			.workbooks.CLOSE()
			.QUIT
			RELEASE loExcel
			THISFORM.contenido.btncancelar.CLICK()
			RETURN .F.
		ENDIF
		
		* Valido que la subfamilia no supere los 60 caracteres
		IF !Thisform.validate_text_field(ALLTRIM(.ActiveSheet.cells(i, 13).VALUE), 60, "Subfamilia") THEN
			.workbooks.close()
			.quit
			RELEASE loExcel
			THISFORM.contenido.btnCancelar.CLICK()
			RETURN .F.
		ENDIF		

		* Si pasa las validaciones, agrego el artículo al cursor
		SELECT cur_Artic
		APPEND BLANK

		IF TYPE(".activesheet.cells(i, 1).value") == "C" THEN
			IF !(ALLTRIM(.ActiveSheet.cells(i, 1).VALUE) == "") THEN
				IF !Thisform.validate_text_field(ALLTRIM(.ActiveSheet.cells(i, 1).VALUE), 20, i, 'código de artículo') THEN
					.workbooks.close()
					.quit
					RELEASE loExcel
					THISFORM.contenido.btnCancelar.CLICK()
					RETURN .F.
				ENDIF
				
				REPLACE Codigo WITH ALLTRIM(.ActiveSheet.cells(i, 1).VALUE)
			ELSE
				MESSAGEBOX("Error en la fila " + ALLTRIM(STR(i)) + " columna 1",0+48,"Error de importación")
				.workbooks.CLOSE()
				.QUIT
				THISFORM.contenido.btnCancelar.CLICK()
				RELEASE loExcel
				RETURN .F.
			ENDIF
		ELSE
			IF !ISNULL(.ActiveSheet.cells(i, 1).VALUE) THEN
				IF !Thisform.validate_text_field(ALLTRIM(.ActiveSheet.cells(i, 1).VALUE), 20, i, 'código de artículo') THEN
					.workbooks.close()
					.quit
					RELEASE loExcel
					THISFORM.contenido.btnCancelar.CLICK()
					RETURN .F.
				ENDIF
			
				REPLACE Codigo WITH ALLTRIM(STR(.ActiveSheet.cells(i, 1).VALUE))
			ELSE
				MESSAGEBOX("Error en la fila " + ALLTRIM(STR(i)) + " columna 1",0+48,"Error de importación")
				.workbooks.CLOSE()
				.QUIT
				THISFORM.contenido.btnCancelar.CLICK()
				RELEASE loExcel
				RETURN .F.
			ENDIF
		ENDIF

		IF TYPE(".activesheet.cells(i, 2).value") == "C" THEN
			IF !(ALLTRIM(.ActiveSheet.cells(i, 2).VALUE) == "") THEN
				IF !Thisform.validate_text_field(ALLTRIM(.ActiveSheet.cells(i, 2).VALUE), 45, i, 'código de artículo proveedor') THEN
					.workbooks.CLOSE()
					.QUIT
					RELEASE loExcel
					THISFORM.contenido.btnCancelar.CLICK()
					RETURN .F.
				ENDIF
				
				REPLACE CodArtPV WITH ALLTRIM(.ActiveSheet.cells(i, 2).VALUE) ADDITIVE
			ELSE
				MESSAGEBOX("Error en la fila " + ALLTRIM(STR(i)) + " columna 2",0+48,"Error de importación")
				.workbooks.CLOSE()
				.QUIT
				RELEASE loExcel
				RETURN .F.
			ENDIF
		ELSE
			IF !ISNULL(.ActiveSheet.cells(i, 2).VALUE) THEN
				IF !Thisform.validate_text_field(ALLTRIM(.ActiveSheet.cells(i, 2).VALUE), 45, i, 'código de artículo proveedor') THEN
					.workbooks.close()
					.quit
					RELEASE loExcel
					THISFORM.contenido.btnCancelar.CLICK()
					RETURN .F.
				ENDIF
				REPLACE CodArtPV WITH ALLTRIM(STR(.ActiveSheet.cells(i, 2).VALUE)) ADDITIVE
			ELSE
				MESSAGEBOX("Error en la fila " + ALLTRIM(STR(i)) + " columna 2",0+48,"Error de importación")
				.workbooks.CLOSE()
				.QUIT
				RELEASE loExcel
				RETURN .F.
			ENDIF
		ENDIF

		* Valido de que la descripción no venga nula
		IF ISNULL(.ActiveSheet.cells(i, 3).VALUE) THEN
			MESSAGEBOX("No hay descripción en la fila " + ALLTRIM(STR(i)) + ". Corrija la planilla y vuelva a intentarlo", 0+48, THISFORM.CAPTION)
			.workbooks.CLOSE()
			.QUIT
			RELEASE loExcel
			THISFORM.contenido.btnCancelar.CLICK()
			RETURN .F.
		ELSE
			IF !Thisform.validate_text_field(ALLTRIM(.ActiveSheet.cells(i, 3).VALUE), 100, i, 'descripcion') THEN
				.workbooks.CLOSE()
				.QUIT
				RELEASE loExcel
				THISFORM.contenido.btnCancelar.CLICK()
				RETURN .F.
			ENDIF
			REPLACE Descripcio 	WITH UPPER(STRTRAN(ALLTRIM(.ActiveSheet.cells(i, 3).VALUE), "'", " ")) ADDITIVE
		ENDIF
		
		* Valido que la marca no supere los 60 caracteres
		IF !Thisform.validate_text_field(ALLTRIM(.ActiveSheet.cells(i, 4).VALUE), 60, i, "marca") THEN
			.workbooks.close()
			.quit
			RELEASE loExcel
			Thisform.contenido.btnCancelar.Click()
			RETURN .F.
		ENDIF
		
		IF ISNULL(.ActiveSheet.cells(i, 4).VALUE)
			REPLACE Marca 		WITH "INDEFINIDO" ADDITIVE
		ELSE
			REPLACE Marca 		WITH UPPER(ALLTRIM(.ActiveSheet.cells(i, 4).VALUE)) ADDITIVE
		ENDIF

		REPLACE PrLista 	WITH ROUND(lnPrLista, 2)	ADDITIVE
		REPLACE PrExt		WITH ROUND(lnPrListaExt, 2)	ADDITIVE
		REPLACE Bonif_1 	WITH ROUND(lnBonif1, 2) 	ADDITIVE
		REPLACE Bonif_2 	WITH ROUND(lnBonif2, 2) 	ADDITIVE
		REPLACE Bonif_3 	WITH ROUND(lnBonif3, 2) 	ADDITIVE
		REPLACE Margen_May	WITH ROUND(lnMargen, 2) 	ADDITIVE
		REPLACE Margen_Min	WITH ROUND(lnMargenMin, 2) 	ADDITIVE
		REPLACE AlicIVA		WITH ROUND(lnAlicIVA, 2)	ADDITIVE

		lcFamilia = UPPER(.ActiveSheet.cells(i, 12).VALUE)
		lcSubFam = UPPER(.ActiveSheet.cells(i, 13).VALUE)
		lcObserv = .ActiveSheet.cells(i, 14).VALUE

		REPLACE familia WITH lcFamilia ADDITIVE
		REPLACE SubFam WITH lcSubFam ADDITIVE

		IF !ISNULL(lcObserv)
			REPLACE Observ WITH ALLTRIM(lcObserv) ADDITIVE
		ENDIF

		lnPorcentaje = (i * 100) / (lnFil - 2)
		WAIT WINDOW "Leyendo: " + STR(i) + " registro de " + STR(lnFil) NOWAIT
		progressBar.UPDATE(lnPorcentaje)
	ENDFOR

	.workbooks.CLOSE()
	.QUIT
ENDWITH

progressBar.COMPLETE()
progressBar.RELEASE()

RELEASE loExcel
SELECT cur_Artic
IF RECCOUNT() > 0
	GO TOP
ENDIF

THISFORM.contenido.grdPrecios.REFRESH()

ENDPROC
PROCEDURE imp_txt
LOCAL lcRuta

lcRuta = GETFILE("TXT")
Thisform.Contenido.txtArchivo.Value = lcRuta

IF ALLTRIM(lcRuta) == ""
	RETURN
ENDIF

SELECT cur_Precios
APPEND FROM (lcRuta) DELIMITED WITH TAB

Thisform.Contenido.grdPrecios.Refresh()
ENDPROC
PROCEDURE comparar_lista_ant
LOCAL progress, regAct, porcentaje, rs, ln_idmaearti, lc_sql, lcCodigo, lcExpr

progress = CREATEOBJECT("_Thermometer")
rs = CREATEOBJECT("odbc_Result")
lcCodigo = ""
lcExpr = ""

progress.show()

porcentaje = 0
regAct = 0

&&SET STEP ON

SELECT cur_Precios
GO TOP

SELECT cur_Precios
DO WHILE !EOF()
	lcCodigo = ALLTRIM(cur_Precios.codigo)

	rs.ActiveConnection = goConn.ActiveConnection
	rs.cursor_name = "cur_CodiP"
	
	lc_sql = "select idmaearti from codiprod where (LTRIM(RTRIM(codigos)) = '" + lcCodigo + "' "
	lc_sql = lc_sql + " OR  LTRIM(RTRIM(codarti)) = '" + lcCodigo + "') "
	lc_sql = lc_sql + " AND (CodProv = " + ALLTRIM(STR(thisform.Contenido.sel_prov.valcpoid)) + ") "
	lc_sql = lc_sql + " AND (tipo = 'CV' OR tipo = 'CP')"

	rs.OpenQuery(lc_sql)
	
	SELECT cur_CodiP
	IF RECCOUNT("cur_CodiP") = 1
		&& Esta consulta la hago para levantar la lista de precios anterior y comparar contra
		&& la lista nueva.
		
		lc_sql = "select * from maearti where idmaearti = " + ALLTRIM(STR(cur_CodiP.idmaearti))
		rs.cursor_name = "cur_art"
		rs.OpenQuery(lc_sql)
		
		SELECT cur_art
		IF RECCOUNT("cur_art") = 1
			&& Si encuentra el artículo, entonces, actualizo el cursor
			
			SELECT cur_Precios
			REPLACE cur_Precios.IdMaeArti WITH cur_art.idmaearti ,;
				cur_Precios.Encont WITH .T. ,;
				cur_Precios.PrAnt WITH cur_art.ListaPVPso					
		ELSE
			&& Si no lo encuentra indico que el artículo no está dentro de la lista
			&& del proveedor

			SELECT cur_Precios
			REPLACE cur_Precios.Encont WITH .F.
		ENDIF
		
		USE IN cur_art
	ELSE
		SELECT cur_Precios
		REPLACE cur_Precios.Encont WITH .F.
	ENDIF
	
	USE IN cur_CodiP

	regAct = regAct + 1
	porcentaje = (regAct * 100) / RECCOUNT("cur_Precios")
	progress.update(regAct)
	
	SELECT cur_Precios
	SKIP
ENDDO

SELECT cur_Precios

progress.complete()
progress.Release()

SELECT cur_Precios
IF RECCOUNT("cur_Precios") > 0
	GO TOP
ENDIF

&& En la siguiente expresion marco con colores el estado del articulo
&& para dar información visual con el siguiente algoritmo:

&& Si el articulo existe en la base, entonces:
&&	Si el precio anterior es distinto al precio actual, entonces:
&&		Marco con Amarillo
&&	Caso Contrario
&&		No marco y lo dejo en blanco
&& Caso Contrario
&&	Marco con Rojo
&& Fin del Condicional

lcExpr = "iif(cur_Precios.Encont, "
lcExpr = lcExpr + "iif(cur_Precios.prAnt <> cur_Precios.prActual, RGB(255,255,128), RGB(255,255,255)), RGB(253,47,36))"

Thisform.Contenido.grdPrecios.SetAll("DynamicBackColor", lcExpr, "Column")
Thisform.Contenido.grdPrecios.Refresh()

ENDPROC
PROCEDURE validar_datos_numericos
* Permite validar datos numéricos.
lparameters tValor

if isnull(tValor) .or. !alltrim(type("tValor")) <> "C" then
	return .f.		
endif

return .t.
ENDPROC
PROCEDURE validate_text_field
******************************************************************
* Permite validar los campos de textos
* tcValue: Valor de campo a validar
* tnLen: Tamaño del campo máximo
* tnRow: Número de fila a chequear
* Fecha: 25/11/2025
******************************************************************
LPARAMETERS tcValue, tnLen, tnRow, tcFielName

IF LEN(ALLTRIM(tcValue)) > tnLen THEN
	MESSAGEBOX("El campo " ;
		+ ALLTRIM(tcFielName) + " no admite más de " ;
		+ ALLTRIM(STR(tnLen)) ;
		+ ". Corregir en la fila: " ;
		+ ALLTRIM(STR(tnRow)), 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

RETURN .T.

ENDPROC
PROCEDURE grabar
&& Actualizo la lista de precios en la base de datos
&& Estructura del cursor de precios "cur_Precios"

LOCAL loCommand, loConnection
LOCAL ln_idMarca, lc_Marca

LOCAL ln_idArticulo, ln_IdProveedor, ln_IdFamilia
LOCAL ln_IdSubFam, lc_CodArt, lcCodArtPV, lc_Descripcion, ln_AlicIVA
LOCAL ln_PrLista, ln_Bonif1, ln_Bonif2, ln_Bonif3, ln_Bonif4, ln_CostoRep
LOCAL ln_MargenMax, ln_MargenMin, ln_PrVentaMax, ln_PrVentaMin, lnPrExt, lcTMon
LOCAL ln_PrFinalMax, ln_PrFinalMin
LOCAL lc_Observ, lb_Habilitado, lcFamilia, lcSubFam, lnProxIdFam, lnProxIdSubFam
LOCAL lnTotal, lnPorc, oTherm, i, lcSql
LOCAL lnCantTrans, llMostrador
LOCAL oData

llMostrador = .F.
lnCantTrans = 0
lnTotal = 0
lnPorc = 0.00
i = 0
oTherm = CREATEOBJECT("_thermometer")
oData = CREATEOBJECT("odbc_Result")
loCommand = CREATEOBJECT("odbc_command")

ln_idArticulo = 0
ln_IdProveedor = 0
ln_IdFamilia = 1
ln_IdSubFam = 1
lc_CodArt = ""
lcCodArtPV = ""
lc_Descripcion = ""
ln_AlicIVA = 0.00
ln_PrLista = 0.00
ln_Bonif1 = 0.00
ln_Bonif2 = 0.00
ln_Bonif3 = 0.00
ln_Bonif4 = 0.00
ln_CostoRep = 0.00
ln_MargenMax = 0.00
ln_MargenMin = 0.00
ln_PrVentaMax = 0.00
ln_PrVentaMin = 0.00
ln_PrFinalMax = 0.00
ln_PrFinalMin = 0.00
lc_Observ = ""
lb_Habilitado = .f.
lnTMon = ""
lnPrExt = 0.00

lcFamilia = ""
lcSubFam = ""

IF Thisform.Contenido.chkMostrador.Value = 1 THEN
	llMostrador = .T.
ELSE
	llMostrador = .F.
ENDIF

SELECT cur_Artic
GO TOP 
lnTotal = RECCOUNT("cur_Artic")

goConn.BeginTransaction()
loCommand.ActiveConnection = goConn.ActiveConnection
oTherm.show()

DO WHILE !EOF("cur_Artic")
	ln_IdProveedor = thisform.contenido.sel_prov.valcpoid
	lc_CodArt = cur_Artic.Codigo
	lcCodArtPV = cur_Artic.codArtPV
	lc_Descripcion = cur_Artic.Descripcio
	lcFamilia = cur_Artic.Familia
	lcSubFam = cur_Artic.SubFam
	lc_Marca = cur_Artic.Marca
	ln_AlicIVA = cur_Artic.AlicIVA
	ln_PrLista = cur_Artic.PrLista
	ln_Bonif1 = cur_Artic.Bonif_1
	ln_Bonif2 = cur_Artic.Bonif_2
	ln_Bonif3 = cur_Artic.Bonif_3
	ln_MargenMax = cur_Artic.Margen_May
	ln_MargenMin = cur_Artic.Margen_Min
	lc_Observ = cur_Artic.Observ

	IF Thisform.contenido.opgMoneda.option1.Value = 1
		lcTMon = "PSO"
		lnPrExt = 0.00
	ELSE
		IF thisform.contenido.opgMoneda.option2.Value = 1
			lcTMon = "DOL"
			lnPrExt = cur_Artic.prExt
			ln_PrLista = lnPrExt * thisform.contenido.txtCotizadcion.Value
		ELSE
			IF thisform.contenido.opgMoneda.option3.Value = 1
				lcTMon = "EUR"
				lnPrExt = cur_Artic.PrExt
				ln_PrLista = lnPrExt * thisform.contenido.txtCotizadcion.Value
			ENDIF
		ENDIF
	ENDIF
	
	ln_CostoRep = calcular_costo(ln_PrLista, ln_Bonif1, ln_Bonif2, ln_Bonif3, ln_Bonif4, 0)
	ln_PrVentaMax = calcular_venta(ln_CostoRep, ln_MargenMax, 0)
	ln_PrVentaMin = calcular_venta(ln_CostoRep, ln_MargenMin, 0)
	ln_PrFinalMax = ln_PrVentaMax + (ln_PrVentaMax * (ln_AlicIVA / 100))
	ln_PrFinalMin = ln_PrVentaMin + (ln_PrVentaMin * (ln_AlicIVA / 100))
	
	lcSql = "select * from marcas where descripcio = '" + ALLTRIM(lc_Marca) + "'"
	oData.ActiveConnection = goConn.ActiveConnection
	oData.cursor_name = "cur_marca"
	oData.OpenQuery(lcSql)
	
	SELECT cur_marca
	IF RECCOUNT() = 0
		ln_idMarca = goConn.GetNextID("marcas", "idmarca")
		lcSql = "INSERT INTO marcas (idMarca, Descripcio) VALUES ( "
		lcSql = lcSql + ALLTRIM(STR(ln_idMarca)) + ", '" + ALLTRIM(lc_Marca) + "')"
		
		loCommand.CommandText = lcSql
		IF !loCommand.execute()
			goConn.Rollback()
			RETURN .F.
		ENDIF
	ELSE
		ln_idMarca = cur_marca.idMarca
	ENDIF
	
	oData.Close_Query()
	
	lcSql = "select * from familias where descripcio = '" + ALLTRIM(lcFamilia) + "'"
	oData.ActiveConnection = goConn.ActiveConnection
	oData.Cursor_Name = "cur_familias"
	oData.OpenQuery(lcSql)
	
	SELECT cur_familias
	IF RECCOUNT() > 0
		ln_IdFamilia = cur_familias.idFamilia
		lcFamilia = cur_familias.descripcio
	ELSE
		ln_IdFamilia = goConn.GetNextId("familias", "idFamilia")
	
		lcSql = "INSERT INTO familias (idFamilia, descripcio) "
		lcSql = lcSql + "VALUES ( " + ALLTRIM(STR(ln_IdFamilia)) + ", '" + ALLTRIM(lcFamilia) + "')"
		
		loCommand.CommandText = lcSql
		IF !loCommand.execute()
			goConn.RollBack()
			RETURN .F.
		ENDIF
	ENDIF
	
	oData.Close_Query()
	
	
	lcSql = "select * from subfam where descripcio = '" + ALLTRIM(lcSubFam) + "'"
	oData.ActiveConnection = goConn.ActiveConnection
	oData.Cursor_Name = "cur_subfam"
	oData.OpenQuery(lcSql)
	
	SELECT cur_subfam
	IF RECCOUNT() > 0
		ln_IdSubFam = cur_subfam.idSubFam
		lcSubFam = cur_subfam.descripcio
	ELSE
		ln_IdSubFam = goConn.GetNextId("subfam", "idsubfam")
		
		lcSql = "INSERT INTO subfam (idSubFam, descripcio) "
		lcSql = lcSql + "VALUES (" + ALLTRIM(STR(ln_IdSubFam)) + ", '" + ALLTRIM(lcSubFam) + "')"
		
		loCommand.CommandText = lcSql
		IF !loCommand.execute()
			goConn.RollBack()
			RETURN .F.
		ENDIF
	ENDIF
	
	oData.Close_Query()
	
	lcSql = "select * from articulos where codArt = '" + lc_CodArt + "'"
	oData.ActiveConnection = goConn.ActiveConnection
	oData.cursor_name = "cur_art"
	oData.OpenQuery(lcSql)
	
	SELECT cur_art
	IF RECCOUNT("cur_art") = 0
		ln_idArticulo = goConn.GetNextID("articulos", "idArticulo")
		
		lcSql = "INSERT INTO articulos ( "
		lcSql = lcSql + "	idArticulo, "
		lcSql = lcSql + "	idProv, "
		lcSql = lcSql + "	idFamilia, "
		lcSql = lcSql + "	idSubFam, "
		lcSql = lcSql + "	idmarca, "
		lcSql = lcSql + "	codArt, "
		lcSql = lcSql + "	codArtPV, "
		lcSql = lcSql + "	descripcio, "
		lcSql = lcSql + "	alicIVA, "
		lcSql = lcSql + "	prLista, "
		lcSql = lcSql + "	tMon, "
		lcSql = lcSql + "	prListaExt, "
		lcSql = lcSql + " 	cotizac, "
		lcSql = lcSql + "	bonif1, "
		lcSql = lcSql + "	bonif2, "
		lcSql = lcSql + "	bonif3, "
		lcSql = lcSql + "	bonif4, "
		lcSql = lcSql + "	costoRep, "
		lcSql = lcSql + "	margenMax, "
		lcSql = lcSql + "	margenMin, "
		lcSql = lcSql + "	prventaMax, "
		lcSql = lcSql + "	prventaMin, "
		lcSql = lcSql + "	prfinalMax, "
		lcSql = lcSql + "	prfinalMin, "
		lcSql = lcSql + "	observ, "
		lcSql = lcSql + "	idUniMed, "		
		lcSql = lcSql + "	habilitado, "
		lcSql = lcSql + "	mostrador, "
		lcSql = lcSql + "	equiv, "
		lcSql = lcSql + "	fecAlta, "
		lcSql = lcSql + "	usuAlta, "
		lcSql = lcSql + "	idHostAlta) "
		lcSql = lcSql + "VALUES ( "
		lcSql = lcSql + ALLTRIM(STR(ln_idArticulo)) + ", "
		lcSql = lcSql + ALLTRIM(STR(ln_IdProveedor)) + ", "
		lcSql = lcSql + ALLTRIM(STR(ln_IdFamilia)) + ", "
		lcSql = lcSql + ALLTRIM(STR(ln_IdSubFam)) + ", "
		lcSql = lcSql + ALLTRIM(STR(ln_idMarca)) + ", "
		lcSql = lcSql + "'" + ALLTRIM(lc_CodArt) + "', "
		lcSql = lcSql + "'" + ALLTRIM(lcCodArtPV) + "', "
		lcSql = lcSql + "'" + ALLTRIM(lc_Descripcion) + "', "
		lcSql = lcSql + STR(ln_AlicIVA, 10, 2) + ", "
		lcSql = lcSql + STR(ln_PrLista, 10, 2) + ", "
		lcSql = lcSql + "'" + lcTMon + "', "
		lcSql = lcSql + STR(lnPrExt, 10, 2) + ", "
		lcSql = lcSql + STR(thisform.contenido.txtcotizadcion.Value, 10, 2) + ", "
		lcSql = lcSql + STR(ln_Bonif1, 10, 2) + ", "
		lcSql = lcSql + STR(ln_Bonif2, 10, 2) + ", "
		lcSql = lcSql + STR(ln_Bonif3, 10, 2) + ", "
		lcSql = lcSql + STR(ln_Bonif4, 10, 2) + ", "
		lcSql = lcSql + STR(ln_CostoRep, 10, 2) + ", "
		lcSql = lcSql + STR(ln_MargenMax, 10, 2) + ", "
		lcSql = lcSql + STR(ln_MargenMin, 10, 2) + ", "
		lcSql = lcSql + STR(ln_PrVentaMax, 10, 2) + ", "
		lcSql = lcSql + STR(ln_PrVentaMin, 10, 2) + ", "
		lcSql = lcSql + STR(ln_PrFinalMax, 10, 2) + ", "
		lcSql = lcSql + STR(ln_PrFinalMin, 10, 2) + ", "
		lcSql = lcSql + "'" + ALLTRIM(lc_Observ) + "', "
		lcSql = lcSql + "1, "
		lcSql = lcSql + "1, "
		lcSql = lcSql + IIF(llMostrador, "1", "0") + ", "
		lcSql = lcSql + ALLTRIM(STR(ln_idArticulo)) + ", "
		lcSql = lcSql + "current_date, "
		lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
		lcSql = lcSql + "'" + SYS(0) + "')"
		
		loCommand.CommandText = lcSql
		
		IF !loCommand.execute()
			goConn.Rollback()
			RETURN .F.
		ENDIF
		
		&& Ahora genero un registro en el codiart por default
		lcSql = "insert into codiart ( "
		lcSql = lcSql + "	idCodArt, "
		lcSql = lcSql + "	idArticulo, "
		lcSql = lcSql + "	codArt, "
		lcSql = lcSql + "	codigos, "
		lcSql = lcSql + "	tipo, "
		lcSql = lcSQl + "	cantiDesp, "
		lcSql = lcSql + "	procesado, "
		lcSql = lcSql + "	circuito) "
		lcSql = lcSql + "values ( "
		lcSql = lcSql + ALLTRIM(STR(goConn.GetNextID("codiart", "idCodArt"))) + ", "
		lcSql = lcSql + ALLTRIM(STR(ln_IdArticulo)) + ", "
		lcSql = lcSql + "'" + ALLTRIM(lc_CodArt) + "', "
		lcSql = lcSql + "'" + ALLTRIM(lc_CodArt) + "', "
		lcSql = lcSql + "'CP', "
		lcSql = lcSql + "1, "
		lcSql = lcSql + "0, "
		lcSql = lcSql + "'CV')"
		
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			RETURN .F.
		ENDIF
	ELSE
		lcSql = "update articulos "
		lcSql = lcSql + "set 	descripcio = '" + ALLTRIM(lc_Descripcion) + "', "
		lcSql = lcSql + "		alicIVA = " + STR(ln_AlicIVA, 10, 2) + ", "
		lcSql = lcSql + "		tMon = '" + lcTMon + "', "
		lcSql = lcSql + "		prListaExt = " + STR(lnPrExt, 10, 2) + ", "
		lcSql = lcSql + "		cotizac = " + STR(Thisform.Contenido.txtCotizadcion.Value, 10, 2) + ", "
		lcSql = lcSql + "		prLista = " + STR(ln_PrLista, 10, 2) + ", "
		lcSql = lcSql + "		bonif1 = " + STR(ln_Bonif1, 10, 2) + ", "
		lcSql = lcSql + "		bonif2 = " + STR(ln_Bonif2, 10, 2) + ", "
		lcSql = lcSql + "		bonif3 = " + STR(ln_Bonif3, 10, 2) + ", "
		lcSql = lcSql + "		bonif4 = " + STR(ln_Bonif4, 10, 2) + ", "
		lcSql = lcSql + "		costoRep = " + STR(ln_CostoRep, 10, 2) + ", "
		lcSql = lcSql + "		margenMax = " + STR(ln_margenMax, 10, 2) + ", "
		lcSql = lcSql + "		margenMin = " + STR(ln_margenMin, 10, 2) + ", "
		lcSql = lcSql + "		prVentaMax = " + STR(ln_PrVentaMax, 10, 2) + ", "
		lcSql = lcSql + "		prVentaMin = " + STR(ln_PrVentaMin, 10, 2) + ", "
		lcSql = lcSql + "		prFinalMax = " + STR(ln_PrFinalMax, 10, 2) + ", "
		lcSql = lcSql + "		prFinalMin = " + STR(ln_PrFinalMin, 10, 2) + ", "
		lcSql = lcSql + "		mostrador = " + IIF(llMostrador, "1", "0") + ", "
		lcSql = lcSql + "		usuModi = '" + ALLTRIM(gcCodUsu) + "', "
		
		IF ALLTRIM(getconfig("SQLSRV")) == "1" THEN
			lcSql = lcSql + "	fecModi = GETDATE(), "
		ELSE
			lcSql = lcSql + "	fecModi = current_date, "
		ENDIF
		
		lcSql = lcSql + "		idHostModi = '" + SYS(0) + "' "
		lcSql = lcSql + "where	codArt = '" + ALLTRIM(lc_CodArt) + "'"
		
		loCommand.CommandText = lcSql
		
		IF !loCommand.execute()
			goConn.Rollback()
			RETURN .F.
		ENDIF

	ENDIF
	
	oData.Close_Query()
	
	&& Cierro y comienza la transaccion
	lnCantTrans = lnCantTrans + 1	
	IF lnCantTrans = 1000
		goConn.Commit()
		goConn.BeginTransaction()
		lnCantTrans = 0
	ENDIF	
	
	SELECT cur_Artic
	SKIP
	
	i = i + 1
	lnPorc = (i * 100) / lnTotal
	oTherm.update(lnPorc)
ENDDO

goConn.Commit()

oTherm.complete()
oTherm.release()

RETURN .T.
ENDPROC
PROCEDURE Init
SELECT cur_Artic

Thisform.contenido.grdPrecios.RecordSource = "cur_Artic"
Thisform.contenido.grdPrecios.list_controlsource = "Codigo,CodArtPV,Descripcio,Marca,PrLista,PrExt,Bonif_1,Bonif_2,Bonif_3,Margen_May,Margen_Min,familia,subfam"
Thisform.contenido.grdPrecios.lista_ancho_cols = "100,100,300,200,70,70,70,70,70,70,70,100,100"
Thisform.contenido.grdPrecios.titulos_cabeceras = "Código,Cod. Alt.,Descripción,Marca,Pr. Lista,Mon. Ext,Bonif. 1,Bonif. 2,Bonif. 3,Margen May.,Margen Min.,Familia,SubFamilia"
Thisform.contenido.grdprecios.generar_grid()

Thisform.Contenido.btngrabar.Enabled = .F.
Thisform.Contenido.btnCancelar.Enabled = .F.
ENDPROC
PROCEDURE Load
DODEFAULT()

CREATE CURSOR cur_Artic (		;
	Codigo		C(20)			,;
	CodArtPv	C(20)			,;
	Descripcio	C(254)			,;
	Marca		C(60)			,;
	AlicIVA		Float(10,2)		,;
	PrLista		Float(10,2)		,;
	PrExt		Float(10,2)		,;
	Bonif_1		Float(10,2)		,;
	Bonif_2		Float(10,2)		,;
	Bonif_3		Float(10,2)		,;
	Margen_may	Float(10,2)		,;
	Margen_min	Float(10,2)		,;
	familia		C(60)			,;
	subfam		C(60)			,;
	observ		M)

SELECT cur_Artic


ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Proveedor:"
Left = 11
Top = 23
TabIndex = 11
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: sel_prov
************************************************************
*** PROPIEDADES ***
Top = 18
Left = 95
Width = 540
Height = 25
TabIndex = 1
cfieldname = idProv
nombre_campo_codigo = idProv
nombre_campo_desc = razSoc
nombre_tabla = proveedor
pkfield = idProv
esnumerico = .T.
Name = "sel_prov"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Height = 21
txtDescripcion.Left = 106
txtDescripcion.Top = 2
txtDescripcion.Width = 432
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***
PROCEDURE recuperar_datos
SELECT proveedor

IF proveedor.tMon == "PSO"
	thisform.contenido.opgMoneda.option1.Value = 1
	thisform.contenido.opgMoneda.option2.Value = 0
	thisform.contenido.opgMoneda.option3.Value = 0
ENDIF

IF proveedor.tMon == "DOL"
	thisform.contenido.opgMoneda.option1.Value = 0
	thisform.contenido.opgMoneda.option2.Value = 1
	thisform.contenido.opgMoneda.option3.Value = 0
ENDIF

IF proveedor.tMon == "EUR"
	thisform.contenido.opgMoneda.option1.Value = 0
	thisform.contenido.opgMoneda.option2.Value = 0
	thisform.contenido.opgMoneda.option3.Value = 1
ENDIF

IF proveedor.cotizac <> 0
	thisform.contenido.txtcotizadcion.Value = proveedor.cotizac
ENDIF
ENDPROC


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Archivo:"
Height = 15
Left = 11
Top = 81
Width = 84
TabIndex = 12
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clslinea1
************************************************************
*** PROPIEDADES ***
Height = 1
Left = 7
Top = 130
Width = 688
Name = "Clslinea1"

*** METODOS ***


************************************************************
OBJETO: btnAbrir
************************************************************
*** PROPIEDADES ***
Top = 76
Left = 95
Height = 24
Width = 36
Caption = "..."
TabIndex = 4
Name = "btnAbrir"

*** METODOS ***
PROCEDURE Click
LOCAL lcRuta

lcRuta = GETFILE("XLS,XLSX")
Thisform.Contenido.txtArchivo.Value = lcRuta

thisform.contenido.btnAceptar.SetFocus()

ENDPROC


************************************************************
OBJETO: txtArchivo
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 137
TabIndex = 13
Top = 77
Width = 496
Name = "txtArchivo"

*** METODOS ***


************************************************************
OBJETO: btnAceptar
************************************************************
*** PROPIEDADES ***
Top = 82
Left = 646
Height = 44
Width = 45
Picture = ..\..\clases\imagen\iconos bajados\aceptar-comprobar-si-puede-icono-9389.ico
TabIndex = 5
Name = "btnAceptar"

*** METODOS ***
PROCEDURE Click
LOCAL lcRuta

SELECT cur_Artic
ZAP

lcRuta = Thisform.Contenido.txtArchivo.Value

IF ALLTRIM(lcRuta) == ""
	Thisform.Contenido.btngrabar.Enabled = .F.
	Thisform.Contenido.btnCancelar.Enabled = .F.
	MESSAGEBOX("Seleccione la ruta del archivo",0+48,"Importación de Artículos")
	RETURN
ELSE 
	Thisform.imp_xls()
ENDIF

SELECT cur_Artic
IF RECCOUNT() > 0
	Thisform.Contenido.btngrabar.Enabled = .T.
	Thisform.Contenido.btnCancelar.Enabled = .T.
ENDIF 



ENDPROC


************************************************************
OBJETO: grdPrecios
************************************************************
*** PROPIEDADES ***
Height = 258
Left = 4
TabIndex = 10
Top = 136
Width = 692
permitir_ordenamiento = .F.
permitir_busqueda = .F.
Name = "grdPrecios"
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
Top = 396
Left = 605
Height = 44
Width = 45
TabIndex = 6
Name = "btnGrabar"

*** METODOS ***
PROCEDURE Click
IF thisform.contenido.sel_prov.valcpoid = 0 OR thisform.contenido.sel_prov.txtCodigo.Value = 0
	MESSAGEBOX("Debe seleccionar un proveedor",0+48,"Importación de Artículos")
	RETURN 
ENDIF 

Thisform.grabar()

SELECT cur_Artic
ZAP

Thisform.Contenido.btngrabar.Enabled = .F.
Thisform.Contenido.btnCancelar.Enabled = .F.
Thisform.Contenido.txtArchivo.Value = ""
Thisform.contenido.chkMostrador.Value = 0
Thisform.Contenido.sel_prov.blanquear()
Thisform.Contenido.Sel_prov.txtCodigo.SetFocus()
ENDPROC


************************************************************
OBJETO: btnCancelar
************************************************************
*** PROPIEDADES ***
Top = 396
Left = 5
Height = 44
Width = 45
TabIndex = 8
Name = "btnCancelar"

*** METODOS ***
PROCEDURE Click
Thisform.Contenido.btngrabar.Enabled = .F.
Thisform.Contenido.btnCancelar.Enabled = .F.

thisform.contenido.sel_prov.blanquear()
thisform.contenido.txtCotizadcion.Value = 0.00
thisform.contenido.txtArchivo.Value = ""
Thisform.contenido.chkMostrador.Value = 0
thisform.contenido.sel_prov.SetFocus()

SELECT cur_Artic
ZAP 
ENDPROC


************************************************************
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 396
Left = 652
Height = 44
Width = 45
TabIndex = 7
Name = "btnCerrar"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Tipo de moneda"
Height = 15
Left = 10
Top = 51
Width = 97
TabIndex = 14
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "cotizado a:"
Height = 15
Left = 342
Top = 50
Width = 67
TabIndex = 15
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: txtCotizadcion
************************************************************
*** PROPIEDADES ***
Left = 411
TabIndex = 3
Top = 47
isnumeric = .T.
Name = "txtCotizadcion"

*** METODOS ***


************************************************************
OBJETO: opgMoneda
************************************************************
*** PROPIEDADES ***
AutoSize = .T.
ButtonCount = 3
BackStyle = 0
BorderStyle = 1
Height = 25
Left = 113
Top = 45
Width = 213
TabIndex = 2
Name = "opgMoneda"
Option1.BackStyle = 0
Option1.Caption = "Pesos"
Option1.Height = 15
Option1.Left = 5
Option1.Top = 5
Option1.Width = 56
Option1.ColorScheme = 1
Option1.Name = "Option1"
Option2.BackStyle = 0
Option2.Caption = "Dolares"
Option2.Height = 15
Option2.Left = 77
Option2.Top = 5
Option2.Width = 84
Option2.Name = "Option2"
Option3.FontBold = .T.
Option3.BackStyle = 0
Option3.Caption = "Euro"
Option3.Height = 15
Option3.Left = 160
Option3.Top = 5
Option3.Width = 48
Option3.Name = "Option3"

*** METODOS ***


************************************************************
OBJETO: chkMostrador
************************************************************
*** PROPIEDADES ***
Top = 105
Left = 401
Height = 18
Width = 230
Alignment = 0
Caption = "Marcar como artículo de mostrador"
TabIndex = 9
Name = "chkMostrador"

*** METODOS ***


************************************************************
OBJETO: 
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 9, 6, 15, 12, 32, 3, 0

*** METODOS ***


