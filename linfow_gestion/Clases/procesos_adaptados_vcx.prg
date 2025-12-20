************************************************************
OBJETO: actu_tommasi_v2
************************************************************
*** PROPIEDADES ***
Name = "actu_tommasi_v2"

*** METODOS ***
PROCEDURE actualizar_articulos
&& Hago los llamados a los métodos correspondiente
&& a la actualización de precios.

IF !This.cargar_nuevos() THEN
	RETURN .F.
ENDIF

IF !This.actualizar_existentes() THEN
	RETURN .F.
ENDIF

RETURN .T.

ENDPROC
PROCEDURE cargar_nuevos
LOCAL loProg, loResult, loCommand, i, lnIdMarca
LOCAL lcSql, loDT
LOCAL lnProxID, lnIdSubFam, lcCodigo, lnPrLista
LOCAL lnPrVentaMax, lnPrVentaMin, lnPrFinalMax, lnPrFinalMin
LOCAL lnPrAnt, lnVariacion, loRes, lnIdArticulo

loProg = CREATEOBJECT("_thermometer")
loResult = CREATEOBJECT("odbc_result")
loCommand = CREATEOBJECT("odbc_command")
loDT = CREATEOBJECT("datetime")
i = 0
lcSql = ""
lnPrAnt = 0.00
lnVariacion = 0.00
loRes = CREATEOBJECT("odbc_result")
lnIdArticulo = 0

lnProxID = 0
lnIdSubFam = 0
lcCodigo = ""
lnIdMarca = 0
lnPrLista = 0.00
lnPrVentaMax = 0.00
lnPrVentaMin = 0.00
lnPrFinalMax = 0.00
lnPrFinalMin = 0.00

loProg.Show()
goConn.BeginTransaction()

SELECT * FROM C:\TOMMASIW\RUBROS ;
WHERE Li IN (SELECT rubro FROM C:\TOMMASIW\arti) ;
INTO CURSOR cur_rubros

SELECT cur_rubros
IF RECCOUNT("cur_rubros") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_rubros")
	&& Actualizo los rubros
		
	lcSql = "SELECT * FROM subfam where descripcio = '" + ALLTRIM(cur_rubros.Titulo) + "'"
	loResult.ActiveConnection = goConn.ActiveConnection
	loResult.Cursor_Name = "cur_subfam"
	
	IF !loResult.OpenQuery(lcSql) THEN
		This.Error_message = loResult.Error_Message
		goConn.Rollback()
		RETURN .F.
	ENDIF
	
	SELECT cur_subfam
	IF RECCOUNT("cur_subfam") = 0 THEN
		lnIdSubFam = goConn.getNextID("subfam", "idSubFam")
		
		lcSql = "INSERT INTO subfam ( idSubFam, descripcio, usuAlta, fecAlta, idHostAlta ) VALUES ("
		lcSql = lcSql + ALLTRIM(STR(lnIdSubFam)) + ", "
		lcSql = lcSql + "'" + UPPER(ALLTRIM(cur_rubros.Titulo)) + "', "
		lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
		lcSql = lcSql + loDT.getDateTime() + ", "
		lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "')"
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			this.error_message = loCommand.ErrorMessage
			goConn.Rollback()
			RETURN .F.
		ENDIF
	ELSE
		lnIdSubFam = cur_SubFam.idSubFam
	ENDIF
	
	loResult.Close_Query()
	
	&& Actualizo los artículos	
	SELECT * FROM C:\TOMMASIW\arti 	;
	WHERE arti.rubro = cur_rubros.Li 	;
	INTO CURSOR cur_arti

	SELECT cur_arti
	IF RECCOUNT("cur_arti") > 0 THEN 
		GO TOP
	ENDIF
	
	DO WHILE !EOF("cur_arti")
		lcSql = "SELECT * FROM articulos WHERE codArtPV = '" + ALLTRIM(cur_arti.Codigo) + "'"
		loResult.ActiveConnection = goConn.ActiveConnection
		loResult.Cursor_Name = "cur_tmp"
		loResult.OpenQuery(lcSql)
		
		lcCodigo = ALLTRIM(cur_arti.Codigo) + "-P" + ALLTRIM(STR(This.idprov))
		lnIdMarca = 1
		
		SELECT cur_tmp
		IF RECCOUNT("cur_tmp") = 0 THEN
			&& Calculo de los precios.		
			lnPrLista = cur_arti.Precio
			lnCostoRep = calcular_costo(lnPrLista, this.desc1, this.desc2, this.desc3, this.desc4, 0)
			lnPrVentaMax = lnCostoRep + (lnCostoRep * (this.margen_may / 100))
			lnPrVentaMin = lnCostoRep + (lnCostoRep * (this.margen_min / 100))
			lnPrFinalMax = lnPrVentaMax + (lnPrVentaMax * (this.alic_iva / 100))
			lnPrFinalMin = lnPrVentaMin + (lnPrVentaMin * (this.alic_iva / 100))
			
			TEXT TO loCommand.CommandText NOSHOW 
				CALL articulos_insert (
					?idProv, 
					?idFamilia, 
					?idSubFam, 
					?idMarca,
					?codArt, 
					?descripcio, 
					?alicIVA, 
					?tMon,
					?prListaExt, 
					?cotizac, 
					?prLista, 
					?bonif1,
					?bonif2, 
					?bonif3, 
					?bonif4, 
					?costoRep,
					?margenMax, 
					?margenMin, 
					?prVentaMax, 
					?prVentaMin,
					?prFinalMax, 
					?prFinalMin, 
					?observ, 
					?habilitado,
					?linkFoto, 
					?usuAlta, 
					?idHostAlta, 
					?esServ,
					?idUniMed, 
					?cdaProv, 
					?mostrador)
			ENDTEXT
			loCommand.AddParameter("idProv", ALLTRIM(STR(This.idProv)), .f., .f.)
			loCommand.AddParameter("idFamilia", "1", .f., .f.)
			loCommand.AddParameter("idSubFam", ALLTRIM(STR(lnIdSubFam)), .f., .f.)
			loCommand.AddParameter("idMarca", ALLTRIM(STR(lnIdMarca)), .f., .f.)
			loCommand.AddParameter("codArt", ALLTRIM(lcCodigo), .t., .f.)
			loCommand.AddParameter("descripcio", UPPER(ALLTRIM(STRTRAN(cur_arti.Descrip, "'"," "))), .t., .f.)
			loCommand.AddParameter("alicIVA", ALLTRIM(STR(This.alic_iva, 10, 2)), .f., .f.)
			loCommand.AddParameter("tMon", "PSO", .t., .f.)
			loCommand.AddParameter("prListaExt", "0", .f., .f.)
			loCommand.AddParameter("cotizac", "0", .f., .f.)
			loCommand.AddParameter("prLista", ALLTRIM(STR(lnPrLista, 10, 2)), .f., .f.)
			loCommand.AddParameter("bonif1", ALLTRIM(STR(this.desc1, 10, 2)), .f., .f.)
			loCommand.AddParameter("bonif2", ALLTRIM(STR(this.desc2, 10, 2)), .f., .f.)
			loCommand.AddParameter("bonif3", ALLTRIM(STR(this.desc3, 10, 2)), .f., .f.)
			loCommand.AddParameter("bonif4", ALLTRIM(STR(this.desc4, 10, 2)), .f., .f.)
			loCommand.AddParameter("costoRep", ALLTRIM(STR(lnCostoRep, 10, 2)), .f., .f.)
			loCommand.AddParameter("margenMax", ALLTRIM(STR(This.margen_may, 10, 2)), .f., .f.)
			loCommand.AddParameter("margenMin", ALLTRIM(STR(This.margen_min, 10, 2)), .f., .f.)
			loCommand.AddParameter("prVentaMax", ALLTRIM(STR(lnPrVentaMax, 10, 2)), .f., .f.)
			loCommand.AddParameter("prVentaMin", ALLTRIM(STR(lnPrVentaMin, 10, 2)), .f., .f.)
			loCommand.AddParameter("prFinalMax", ALLTRIM(STR(lnPrFinalMax, 10, 2)), .f., .f.)
			loCommand.AddParameter("prFinalMin", ALLTRIM(STR(lnPrFinalMin, 10, 2)), .f., .f.)
			loCommand.AddParameter("observ", "", .t., .f.)
			loCommand.AddParameter("habilitado", "1", .f., .f.)
			loCommand.AddParameter("linkFoto", "", .t., .f.)
			loCommand.AddParameter("usuAlta", ALLTRIM(gcCodUsu), .t., .f.)
			loCommand.AddParameter("idHostAlta", ALLTRIM(SYS(0)), .t., .f.)
			loCommand.AddParameter("esServ", "0", .f., .f.)
			loCommand.AddParameter("idUniMed", "1", .f., .f.)
			loCommand.AddParameter("cdaProv", ALLTRIM(cur_arti.Codigo), .t., .f.)
			loCommand.AddParameter("mostrador", "1", .f., .f.)

			loCommand.ActiveConnection = goConn.ActiveConnection
			IF !loCommand.Execute() THEN
				this.error_message = loCommand.ErrorMessage
				goConn.Rollback()
				RETURN .F.
			ENDIF					
		ENDIF		
			
		SELECT cur_arti
		SKIP 
	ENDDO
			
	i = i + 1
	loProg.update((i * 100) / RECCOUNT("cur_rubros"), "Escaneando artículos nuevos y procesando...")
	SELECT cur_rubros
	SKIP
ENDDO

goConn.Commit()
loProg.Complete()

RETURN .T.
ENDPROC
PROCEDURE actualizar_existentes
LOCAL loRes, lcSql
LOCAL loCommand
LOCAL loTherm
LOCAL lnPrLista
LOCAL lnCostoRep
LOCAL lnPrVentaMax
LOCAL lnPrVentaMin
LOCAL lnPrAnt
LOCAL lnPorVar
LOCAL lnProxID

loRes = CREATEOBJECT("odbc_result")
loCommand = CREATEOBJECT("odbc_result")
loTherm = CREATEOBJECT("_thermometer")
lcSql = ""
lnPrLista = 0.00
lnCostoRep = 0.00
lnPrVentaMax = 0.00
lnPrVentaMin = 0.00
lnPrAnt = 0.00
lnPorVar = 0.00
lnProxID = 0

lcSql = "SELECT * FROM articulos "
lcSql = lcSql + "WHERE articulos.idProv = " + ALLTRIM(STR(This.idProv))

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_articulos"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

goConn.BeginTransaction()

loTherm.show()

SELECT cur_articulos
GO TOP
DO WHILE !EOF("cur_articulos")
	lnPrAnt = cur_articulos.prLista

	SELECT * FROM C:\TOMMASIW\arti ;
	WHERE ALLTRIM(codigo) == ALLTRIM(cur_articulos.codArtPV) ;
	INTO CURSOR cur_tmssi
	
	SELECT cur_tmssi
	lnPrLista = cur_tmssi.precio
		
	IF lnPrLista <> 0 THEN
		lnCostoRep = calcular_costo(lnPrLista, ;
			IIF(this.desc1 = 0, cur_articulos.bonif1, this.desc1), ;
			IIF(this.desc2 = 0, cur_articulos.bonif2, this.desc2), ;
			IIF(this.desc3 = 0, cur_articulos.bonif3, this.desc3), ;
			IIF(this.desc4 = 0, cur_articulos.bonif4, this.desc4), 0)
			
		this.margen_may = IIF(this.margen_may = 0, cur_articulos.margenMax, this.margen_may)
		this.margen_min = IIF(this.margen_min = 0, cur_articulos.margenMin, this.margen_min)			
			
		lnPrVentaMax = lnCostoRep + (lnCostoRep * (this.margen_may / 100))
		lnPrVentaMin = lnCostoRep + (lnCostoRep * (this.margen_min / 100))
		lnPrFinalMax = lnPrVentaMax + (lnPrVentaMax * (this.alic_iva / 100))
		lnPrFinalMin = lnPrVentaMin + (lnPrVentaMin * (this.alic_iva / 100))
		
		lcSql = "CALL articulos_actuPreCatalogo ( " ;
			+ "?pCodArt, " ;
			+ "?pIdProv, " ;
			+ "?pPrLista, " ;
			+ "?pBonif1, " ; 
			+ "?pBonif2, " ; 
			+ "?pBonif3, " ;
			+ "?pBonif4, " ;
			+ "?pCostoRep, " ; 
			+ "?pMargenMax, " ;
			+ "?pMargenMin, " ;
			+ "?pPrVentaMax, " ;
			+ "?pPrVentaMin,  " ;
			+ "?pPrFinalMax, " ; 
			+ "?pPrFinalMin, " ;
			+ "?pCodUsu, " ;
			+ "?pIdHostModi) "
		lcSql = loCommand.AddParameter(lcSql, "pCodArt", ALLTRIM(cur_articulos.codArtPV), .t., .f.)
		lcSql = loCommand.AddParameter(lcSql, "pIdProv", ALLTRIM(STR(This.idProv)), .f., .f.)
		lcSql = loCommand.AddParameter(lcSql, "pPrLista", ALLTRIM(STR(lnPrLista, 10, 2)), .f., .f.)
		lcSql = loCommand.AddParameter(lcSql, "pBonif1", ALLTRIM(STR(IIF(this.desc1 = 0, cur_articulos.bonif1, this.desc1), 10, 2)), .f., .f.)
		lcSql = loCommand.AddParameter(lcSql, "pBonif2", ALLTRIM(STR(IIF(this.desc2 = 0, cur_articulos.bonif2, this.desc2), 10, 2)), .f., .f.)
		lcSql = loCommand.AddParameter(lcSql, "pBonif3", ALLTRIM(STR(IIF(this.desc3 = 0, cur_articulos.bonif3, this.desc3), 10, 2)), .f., .f.)
		lcSql = loCommand.AddParameter(lcSql, "pBonif4", ALLTRIM(STR(IIF(this.desc4 = 0, cur_articulos.bonif4, this.desc4), 10, 2)), .f., .f.)
		lcSql = loCommand.AddParameter(lcSql, "pCostoRep", ALLTRIM(STR(lnCostoRep, 10, 2)), .f., .f.)
		lcSql = loCommand.AddParameter(lcSql, "pMargenMax", ALLTRIM(STR(IIF(this.margen_may = 0, cur_articulos.margenMax, this.margen_may), 10, 2)), .f., .f.)
		lcSql = loCommand.AddParameter(lcSql, "pMargenMin", ALLTRIM(STR(IIF(this.margen_min = 0, cur_articulos.margenMin, this.margen_min), 10, 2)), .f., .f.)
		lcSql = loCommand.AddParameter(lcSql, "pPrVentaMax", ALLTRIM(STR(lnPrVentaMax, 10, 2)), .f., .f.)
		lcSql = loCommand.AddParameter(lcSql, "pPrVentaMin", ALLTRIM(STR(lnPrVentaMin, 10, 2)), .f., .f.)
		lcSql = loCommand.AddParameter(lcSql, "pPrFinalMax", ALLTRIM(STR(lnPrFinalMax, 10, 2)), .f., .f.)
		lcSql = loCommand.AddParameter(lcSql, "pPrFinalMin", ALLTRIM(STR(lnPrFinalMin, 10, 2)), .f., .f.)
		lcSql = loCommand.AddParameter(lcSql, "pCodUsu", ALLTRIM(gcCodUsu), .t., .f.)
		lcSql = loCommand.AddParameter(lcSql, "pIdHostModi", ALLTRIM(SYS(0)), .t., .f.)
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.Cursor_Name = "cur_res"
		IF !loCommand.OpenQuery(lcSql) THEN
			goConn.Rollback()
			MESSAGEBOX(loCommand.Error_Message, 0+48, Thisform.Caption)
			RETURN .F.
		ELSE
			IF !(ALLTRIM(cur_res.result) == "OK") THEN
				MESSAGEBOX(cur_res.result, 0+48, Thisform.Caption)
				loCommand.Close_Query()
				goConn.Rollback()
				RETURN .F.
			ENDIF
			loCommand.Close_Query()
		ENDIF
	ENDIF
	
	USE IN cur_tmssi
	loTherm.update((RECNO("cur_articulos") * 100) / RECCOUNT("cur_articulos"), "Actualizando artículos existentes...")
	SELECT cur_articulos
	SKIP
ENDDO

goConn.Commit()
loTherm.Complete()

loRes.Close_Query()

RETURN .T.
ENDPROC


************************************************************
OBJETO: actu_tommasi_v3
************************************************************
*** PROPIEDADES ***
Name = "actu_tommasi_v3"

*** METODOS ***
PROCEDURE open
LOCAL lcTabRubro, lcTabSrb, lcTabMrc, lcTabArt, lcMarcas
LOCAL lcSql, loRes, loCmd
LOCAL i, lcPath, lcLocalServerTemp

lcSql = ""
loRes = CREATEOBJECT("odbc_result")
loCmd = CREATEOBJECT("odbc_command")
lcTabSrb = This.Path + "RUBROS"
lcTabArt = This.path + "arti"
lcMarcas = ALLTRIM(getglobalcfg("DERCLI_MRC"))
lcPath = getGlobalCFG("SRVPATHTMP")
lcLocalServerTemp = getGlobalCFG("LOCSRVTMP")

DELETE FILE ALLTRIM(lcPath) + "\actualizacion_tommasi.csv"

&& Acá armar la consulta y el cruce entre DBFS.
SELECT ;
	CODIGO AS codArt, ;
	DESCRIP AS descripcio, ;
	"VARIOS" AS familia, ;
	TITULO AS subfam,;
	"VARIOS" AS marca,;
	PRECIO AS prLista,;
	21 AS alicIVA,;
	"" AS linkFoto ;
FROM ;
	&lcTabArt AS artic,;
	&lcTabSrb AS rubros ;
WHERE ;
	rubros.li = artic.rubro ;
INTO CURSOR cur_artic

WAIT WINDOW "Leyendo artículos desde DERCLI6..." NOWAIT
WAIT WINDOW "Creando tabla temporal..." NOWAIT
loCmd.ActiveConnection = goConn.ActiveConnection
loCmd.CommandText = "CALL artcat_CrearTemps (?pIdProv, ?permitirDuplicados)"
loCmd.AddParameter("pIdProv", ALLTRIM(STR(this.idprov)), .f., .f.)
loCmd.AddParameter("permitirDuplicados", "1", .f., .f.)
loCmd.Execute()

WAIT WINDOW "Enviando datos al servidor..." NOWAIT
SELECT cur_artic
COPY TO ALLTRIM(lcPath) + "\actualizacion_tommasi.csv" DELIMITED WITH "" WITH CHARACTER "|"

WAIT WINDOW "Creando tabla temporal..." NOWAIT
loCmd.ActiveConnection = goConn.ActiveConnection
loCmd.CommandText = "CALL artcat_CrearTemps_v2(?idProv)"
loCmd.AddParameter("idProv", ALLTRIM(STR(this.idprov)), .f., .f.)

WAIT WINDOW "Leyendo archivo de artículos..." NOWAIT
lcSql = "LOAD DATA INFILE '" + ALLTRIM(lcLocalServerTemp) + "\\actualizacion_tommasi.csv' " ;
	+ "INTO TABLE tmp_artcat " ;
	+ "CHARACTER SET latin1 " ;
	+ "FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n' " ;
	+ "(codArt, descripcio, familia, subfam, marca, prLista, alicIVA, linkFoto);"
loCmd.ActiveConnection = goConn.ActiveConnection
loCmd.CommandText = lcSql
loCmd.Execute()

WAIT WINDOW "Subiendo datos a la tabla temporal" NOWAIT 
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"
lcSql = "CALL artcat_insertToTemp (?idProv, ?bonif1, ?bonif2, ?bonif3, ?bonif4, ?margenMay, ?margenMin, ?host)"
lcSql = loRes.AddParameter(lcSql, "idProv", ALLTRIM(STR(this.idprov)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "bonif1", ALLTRIM(STR(this.desc1, 20, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "bonif2", ALLTRIM(STR(this.desc2, 20, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "bonif3", ALLTRIM(STR(this.desc3, 20, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "bonif4", ALLTRIM(STR(this.desc4, 20, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "margenMay", ALLTRIM(STR(this.margenMay, 20, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "margenMin", ALLTRIM(STR(this.margenMin, 20, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "host", ALLTRIM(SYS(0)), .t., .f.)
loRes.OpenQuery(lcSql)
loRes.Close_Query()

WAIT WINDOW "Archivo procesado" NOWAIT
ENDPROC


************************************************************
OBJETO: actu_siscli
************************************************************
*** PROPIEDADES ***
path = C:\SISCLI\DATOS
Name = "actu_siscli"

*** METODOS ***
PROCEDURE open
LOCAL lcTabRubro, lcTabSrb, lcTabMrc, lcTabArt, lcMarcas
LOCAL lcSql, loRes, loCmd
LOCAL i, lcPath, lcLocalServerTemp

lcSql = ""
loRes = CREATEOBJECT("odbc_result")
loCmd = CREATEOBJECT("odbc_command")
lcTabRubro = This.path + "rubros"
lcTabSrb = This.Path + "subrubros"
lcTabMrc = This.path + "marcas"
lcTabArt = This.path + "articulos"
lcMarcas = ALLTRIM(getglobalcfg("DERCLI_MRC"))
lcPath = getGlobalCFG("SRVPATHTMP")
lcLocalServerTemp = getGlobalCFG("LOCSRVTMP")

DELETE FILE ALLTRIM(lcPath) + "\actualizacion_mg.csv"

WAIT WINDOW "Leyendo artículos desde DERCLI6..." NOWAIT

IF ALLTRIM(lcMarcas) == "" THEN
	&& Si no tiene filtro cofigurado por marca, entonces, ejecuta esta instrucción
	SELECT	artic.codart		AS codigo 		,;
			artic.descripcio	AS descripcio	,;
			rub.descripcio 		AS familia		,;
			srb.descripcio 		AS subfam		,;
			mrc.descripcio 		AS marca		,;
			artic.prLista 		AS precio		,;
			artic.aliciva		As aliciva		,;
			artic.linkfoto		AS linkfoto		;
	FROM	&lcTabArt AS artic,					;
			&lcTabRubro AS rub,					;
			&lcTabSrb AS srb,					;
			&lcTabMrc AS mrc 					;
	WHERE	artic.id_rubro = rub.id_rubro		;
		AND artic.id_srb = srb.id_srb			;
		AND artic.id_marca = mrc.id_marca		;
		AND artic.discont = .F.					;
	INTO CURSOR cur_artic
ELSE
	&& En caso que esté configurado el filtro por marca, entonces, ejecuta el SELECT aplicando
	&& dicho filtro
	SELECT	artic.codart		AS codigo 		,;
			artic.descripcio	AS descripcio	,;
			rub.descripcio 		AS familia		,;
			srb.descripcio 		AS subfam		,;
			mrc.descripcio 		AS marca		,;
			artic.prLista 		AS precio		,;
			artic.aliciva		As aliciva		,;
			artic.linkfoto		AS linkfoto		;
	FROM	&lcTabArt AS artic,					;
			&lcTabRubro AS rub,					;
			&lcTabSrb AS srb,					;
			&lcTabMrc AS mrc 					;
	WHERE	artic.id_rubro = rub.id_rubro		;
		AND artic.id_srb = srb.id_srb			;
		AND artic.id_marca = mrc.id_marca		;
		AND artic.discont = .F.					;
		AND artic.id_marca IN (&lcMarcas) 		;
	INTO CURSOR cur_artic
ENDIF

WAIT WINDOW "Creando tabla temporal..." NOWAIT
loCmd.ActiveConnection = goConn.ActiveConnection
loCmd.CommandText = "CALL artcat_CrearTemps (?pIdProv, ?permitirDuplicados)"
loCmd.AddParameter("pIdProv", ALLTRIM(STR(this.idprov)), .f., .f.)
loCmd.AddParameter("permitirDuplicados", "1", .f., .f.)
loCmd.Execute()

WAIT WINDOW "Enviando datos al servidor..." NOWAIT
SELECT cur_artic
COPY TO ALLTRIM(lcPath) + "\actualizacion_mg.csv" DELIMITED WITH "" WITH CHARACTER "|"

WAIT WINDOW "Creando tabla temporal..." NOWAIT
loCmd.ActiveConnection = goConn.ActiveConnection
loCmd.CommandText = "CALL artcat_CrearTemps_v2(?idProv)"
loCmd.AddParameter("idProv", ALLTRIM(STR(this.idprov)), .f., .f.)

WAIT WINDOW "Leyendo archivo de artículos..." NOWAIT
lcSql = "LOAD DATA INFILE '" + ALLTRIM(lcLocalServerTemp) + "\\actualizacion_mg.csv' " ;
	+ "INTO TABLE tmp_artcat " ;
	+ "CHARACTER SET latin1 " ;
	+ "FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n' " ;
	+ "(codArt, descripcio, familia, subfam, marca, prLista, alicIVA, linkFoto);"
loCmd.ActiveConnection = goConn.ActiveConnection
loCmd.CommandText = lcSql
loCmd.Execute()

WAIT WINDOW "Subiendo datos a la tabla temporal" NOWAIT 
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"
lcSql = "CALL artcat_insertToTemp (?idProv, ?bonif1, ?bonif2, ?bonif3, ?bonif4, ?margenMay, ?margenMin, ?host)"
lcSql = loRes.AddParameter(lcSql, "idProv", ALLTRIM(STR(this.idprov)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "bonif1", ALLTRIM(STR(this.desc1, 20, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "bonif2", ALLTRIM(STR(this.desc2, 20, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "bonif3", ALLTRIM(STR(this.desc3, 20, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "bonif4", ALLTRIM(STR(this.desc4, 20, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "margenMay", ALLTRIM(STR(this.margenMay, 20, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "margenMin", ALLTRIM(STR(this.margenMin, 20, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "host", ALLTRIM(SYS(0)), .t., .f.)
loRes.OpenQuery(lcSql)
loRes.Close_Query()

WAIT WINDOW "Archivo procesado" NOWAIT
ENDPROC


************************************************************
OBJETO: actu_dercli_v2
************************************************************
*** PROPIEDADES ***
Name = "actu_dercli_v2"

*** METODOS ***
PROCEDURE open
LOCAL lcTabRubro, lcTabSrb, lcTabMrc, lcTabArt, lcMarcas
LOCAL lcSql, loRes, loCmd
LOCAL i, lcPath, lcLocalServerTemp

lcSql = ""
loRes = CREATEOBJECT("odbc_result")
loCmd = CREATEOBJECT("odbc_command")
lcTabRubro = This.path + "rubros"
lcTabSrb = This.Path + "subrubros"
lcTabMrc = This.path + "marcas"
lcTabArt = This.path + "articulos"
lcMarcas = ALLTRIM(getglobalcfg("DERCLI_MRC"))
lcPath = getGlobalCFG("SRVPATHTMP")
lcLocalServerTemp = getGlobalCFG("LOCSRVTMP")

DELETE FILE ALLTRIM(lcPath) + "\actualizacion_der.csv"

WAIT WINDOW "Leyendo artículos desde DERCLI6..." NOWAIT

IF ALLTRIM(lcMarcas) == "" THEN
	&& Si no tiene filtro cofigurado por marca, entonces, ejecuta esta instrucción
	SELECT	artic.codart		AS codigo 		,;
			artic.descripcio	AS descripcio	,;
			rub.descripcio 		AS familia		,;
			srb.descripcio 		AS subfam		,;
			mrc.descripcio 		AS marca		,;
			artic.prLista 		AS precio		,;
			artic.aliciva		As aliciva		,;
			artic.linkfoto		AS linkfoto		;
	FROM	&lcTabArt AS artic,					;
			&lcTabRubro AS rub,					;
			&lcTabSrb AS srb,					;
			&lcTabMrc AS mrc 					;
	WHERE	artic.id_rubro = rub.id_rubro		;
		AND artic.id_srb = srb.id_srb			;
		AND artic.id_marca = mrc.id_marca		;
		AND artic.baja = .F.					;
		AND artic.habilitado = .T.				;
		AND artic.mercha = .F.					;
		AND artic.discont = .F.					;
	INTO CURSOR cur_artic
ELSE
	&& En caso que esté configurado el filtro por marca, entonces, ejecuta el SELECT aplicando
	&& dicho filtro
	SELECT	artic.codart		AS codigo 		,;
			artic.descripcio	AS descripcio	,;
			rub.descripcio 		AS familia		,;
			srb.descripcio 		AS subfam		,;
			mrc.descripcio 		AS marca		,;
			artic.prLista 		AS precio		,;
			artic.aliciva		As aliciva		,;
			artic.linkfoto		AS linkfoto		;
	FROM	&lcTabArt AS artic,					;
			&lcTabRubro AS rub,					;
			&lcTabSrb AS srb,					;
			&lcTabMrc AS mrc 					;
	WHERE	artic.id_rubro = rub.id_rubro		;
		AND artic.id_srb = srb.id_srb			;
		AND artic.id_marca = mrc.id_marca		;
		AND artic.baja = .F.					;
		AND artic.habilitado = .T.				;
		AND artic.mercha = .F.					;
		AND artic.discont = .F.					;
		AND artic.id_marca IN (&lcMarcas) ;
	INTO CURSOR cur_artic
ENDIF

WAIT WINDOW "Creando tabla temporal..." NOWAIT
loCmd.ActiveConnection = goConn.ActiveConnection
loCmd.CommandText = "CALL artcat_CrearTemps (?pIdProv, ?permitirDuplicados)"
loCmd.AddParameter("pIdProv", ALLTRIM(STR(this.idprov)), .f., .f.)
loCmd.AddParameter("permitirDuplicados", "0", .f., .f.)
loCmd.Execute()

WAIT WINDOW "Enviando datos al servidor..." NOWAIT
SELECT cur_artic
COPY TO ALLTRIM(lcPath) + "\actualizacion_der.csv" DELIMITED WITH "" WITH CHARACTER "|"

WAIT WINDOW "Creando tabla temporal..." NOWAIT
loCmd.ActiveConnection = goConn.ActiveConnection
loCmd.CommandText = "CALL artcat_CrearTemps_v2(?idProv)"
loCmd.AddParameter("idProv", ALLTRIM(STR(this.idprov)), .f., .f.)

WAIT WINDOW "Leyendo archivo de artículos..." NOWAIT

lcSql = "LOAD DATA INFILE '" + ALLTRIM(lcLocalServerTemp) + "\\actualizacion_der.csv' " ;
	+ "INTO TABLE tmp_artcat " ;
	+ "CHARACTER SET latin1 " ;
	+ "FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n' " ;
	+ "(codArt, descripcio, familia, subfam, marca, prLista, alicIVA, linkFoto);"
loCmd.ActiveConnection = goConn.ActiveConnection
loCmd.CommandText = lcSql
loCmd.Execute()

WAIT WINDOW "Subiendo datos a la tabla temporal" NOWAIT 
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"
lcSql = "CALL artcat_insertToTemp (?idProv, ?bonif1, ?bonif2, ?bonif3, ?bonif4, ?margenMay, ?margenMin, ?host)"
lcSql = loRes.AddParameter(lcSql, "idProv", ALLTRIM(STR(this.idprov)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "bonif1", ALLTRIM(STR(this.desc1, 20, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "bonif2", ALLTRIM(STR(this.desc2, 20, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "bonif3", ALLTRIM(STR(this.desc3, 20, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "bonif4", ALLTRIM(STR(this.desc4, 20, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "margenMay", ALLTRIM(STR(this.margenMay, 20, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "margenMin", ALLTRIM(STR(this.margenMin, 20, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "host", ALLTRIM(SYS(0)), .t., .f.)
loRes.OpenQuery(lcSql)
loRes.Close_Query()

WAIT WINDOW "Archivo procesado" NOWAIT
ENDPROC


