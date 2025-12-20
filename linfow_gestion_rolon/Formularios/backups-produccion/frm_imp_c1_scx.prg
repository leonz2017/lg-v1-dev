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
OBJETO: FRM_IMP_C1
************************************************************
*** PROPIEDADES ***
BorderStyle = 2
Height = 328
Width = 732
DoCreate = .T.
Caption = "Importador de Datos"
Name = "FRM_IMP_C1"
CONTENIDO.Comment = ""
CONTENIDO.Name = "CONTENIDO"

*** METODOS ***
PROCEDURE actualizar_articulos
****************************************************************************
* Este método permite actualizar la base de artículo de cuenta 2
****************************************************************************

LOCAL loConn, loMarcas, loFamilia, loSubFam, loProv, loArt, loCodiArt, loEquiv, loCommand
LOCAL lcSql, loResult, loDT, loProg, lnCant, lcCodigo

loConn = CREATEOBJECT("odbc_connect")
loCommand = CREATEOBJECT("odbc_command")
loFamilia = CREATEOBJECT("odbc_result")
loSubFam = CREATEOBJECT("odbc_result")
loProv = CREATEOBJECT("odbc_result")
loMarcas = CREATEOBJECT("odbc_result")
loArt = CREATEOBJECT("odbc_result")
loCodiArt = CREATEOBJECT("odbc_result")
loEquiv = CREATEOBJECT("odbc_result")
loResult = CREATEOBJECT("odbc_result")
loDT = CREATEOBJECT("datetime")
loProg = CREATEOBJECT("_thermometer")
lcSqlSrv = INT(VAL(getconfig("SQLSRV")))
lcSql = ""
lcCodigo = ""

loConn.ConnectionString = ALLTRIM(getConfig("ODBC_C1"))

IF !loConn.Open() THEN
	MESSAGEBOX(loConn.ErrorMessage, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

loProg.Show()

goConn.BeginTransaction()

***********************************************************************************************************
* Actualizo las marcas
***********************************************************************************************************
Thisform.Contenido.txtDetalles.Value = Thisform.Contenido.txtDetalles.Value + CHR(13) + "Actualizando Marcas..."

lcSql = "select * from marcas"
loMarcas.ActiveConnection = loConn.ActiveConnection
loMarcas.Cursor_Name = "cur_marcas"
loMarcas.OpenQuery(lcSql)

lnCant = 0
SELECT cur_marcas
DO WHILE !EOF("cur_marcas")
	lcSql = "select COUNT(*) as cantReg from marcas where idMarca = " + ALLTRIM(STR(cur_marcas.idMarca))
	loResult.ActiveConnection = goConn.ActiveConnection
	loResult.Cursor_Name = "cur_tmp"
	loResult.OpenQuery(lcSql)
	
	IF IIF(INT(VAL(getConfig("SQLSRV"))) = 1, cur_tmp.CantReg, VAL(cur_tmp.CantReg)) = 0 THEN
		lcSql = "INSERT INTO marcas ("
		lcSql = lcSql + "	idMarca, "
		lcSql = lcSql + "	descripcio, "
		lcSql = lcSql + "	usuAlta, "
		lcSql = lcSql + "	fecAlta, "
		lcSql = lcSql + "	idHostAlta, "
		lcSql = lcSql + "	usuBaja, "
		lcSql = lcSql + "	fecBaja, "
		lcSql = lcSql + "	idHostBaja) VALUES ( "
		lcSql = lcSql + ALLTRIM(STR(cur_marcas.idMarca)) + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_marcas.descripcio) + "', "
		lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
		lcSql = lcSql + loDT.getDateTime() + ", "
		lcSql = lcSql + "'" + ALLTRIM(STR(0)) + "', "
		lcSql = lcSql + IIF(ISNULL(cur_marcas.usuBaja),"NULL", "'" + ALLTRIM(cur_marcas.usuBaja) + "'") + ", "
		lcSql = lcSql + IIF(ISNULL(cur_marcas.fecBaja),"NULL", loDT.toMySql(cur_marcas.fecBaja)) + ", "
		lcSql = lcSql + IIF(ISNULL(cur_marcas.idHostBaja),"NULL", "'" + ALLTRIM(cur_marcas.idHostBaja) + "'") + ") "		
	ELSE
		lcSql = "UPDATE marcas SET descripcio = '" + ALLTRIM(cur_marcas.descripcio) + "', "
		lcSql = lcSql + "usuModi = '" + ALLTRIM(gcCodUsu) + "', "
		lcSql = lcSql + "fecModi = " + loDT.getDateTime() + ", "
		lcSql = lcSql + "idHostModi = '" + ALLTRIM(SYS(0)) + "', "
		lcSql = lcSql + "usuBaja = " + IIF(ISNULL(cur_marcas.usuBaja),"NULL", "'" + ALLTRIM(cur_marcas.usuBaja) + "'") + ", "
		lcSql = lcSql + "fecBaja = " + IIF(ISNULL(cur_marcas.fecBaja),"NULL", loDT.toMySql(cur_marcas.fecBaja)) + ", "
		lcSql = lcSql + "idHostBaja = " + IIF(ISNULL(cur_marcas.idHostBaja),"NULL", "'" + ALLTRIM(cur_marcas.idHostBaja) + "'") + " "		
		lcSql = lcSql + "WHERE marcas.idMarca = " + ALLTRIM(STR(cur_marcas.idMarca))
	ENDIF
	
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute() THEN
		goConn.Rollback()
		RETURN .F.
	ENDIF
	
	loProg.update((RECNO("cur_marcas") * 100) / RECCOUNT("cur_marcas"), "Actualizando Marcas...")
	SELECT cur_marcas
	SKIP
ENDDO

loProg.Complete()
loMarcas.close_query()

***********************************************************************************************************
* Actualizo las familias
***********************************************************************************************************
Thisform.Contenido.txtDetalles.Value = Thisform.Contenido.txtDetalles.Value + CHR(13) + "Actualizando Familias..."

lcSql = "SELECT * FROM familias"
loFamilia.ActiveConnection = loConn.ActiveConnection
loFamilia.Cursor_Name = "cur_Familia"
loFamilia.OpenQuery(lcSql)

lnCant = 0
SELECT cur_Familia
DO WHILE !EOF()
	lcSql = "SELECT COUNT(*) AS CantReg FROM familias WHERE idFamilia = " + ALLTRIM(STR(cur_Familia.idFamilia))
	loResult.ActiveConnection = goConn.ActiveConnection
	loResult.Cursor_Name = "cur_tmp"
	loResult.OpenQuery(lcSql)
	
	IF IIF(INT(VAL(getConfig("SQLSRV"))) = 1, cur_tmp.CantReg, VAL(cur_tmp.CantReg)) = 0 THEN
		lcSql = "INSERT INTO familias ("
		lcSql = lcSql + "	idFamilia, "
		lcSql = lcSql + "	descripcio, "
		lcSql = lcSql + "	usuAlta, "
		lcSql = lcSql + "	fecAlta, "
		lcSql = lcSql + "	idHostAlta, "
		lcSql = lcSql + "	usuBaja, "
		lcSql = lcSql + "	fecBaja, "
		lcSql = lcSql + "	idHostBaja) VALUES ( "
		lcSql = lcSql + ALLTRIM(STR(cur_Familia.idFamilia)) + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_Familia.descripcio) + "', "
		lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
		lcSql = lcSql + loDT.getDateTime() + ", "
		lcSql = lcSql + "'" + ALLTRIM(STR(0)) + "', "
		lcSql = lcSql + IIF(ISNULL(cur_Familia.usuBaja),"NULL", "'" + ALLTRIM(cur_Familia.usuBaja) + "'") + ", "
		lcSql = lcSql + IIF(ISNULL(cur_Familia.fecBaja),"NULL", loDT.toMySql(cur_Familia.fecBaja)) + ", "
		lcSql = lcSql + IIF(ISNULL(cur_Familia.idHostBaja),"NULL", "'" + ALLTRIM(cur_Familia.idHostBaja) + "'") + ") "	
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			RETURN .F.
		ENDIF
	ELSE
		lcSql = "UPDATE familias SET descripcio = '" + ALLTRIM(cur_Familia.descripcio) + "', "
		lcSql = lcSql + "usuModi = '" + ALLTRIM(gcCodUsu) + "', "
		lcSql = lcSql + "fecModi = " + loDT.getDateTime() + ", "
		lcSql = lcSql + "idHostModi = '" + ALLTRIM(SYS(0)) + "', "
		lcSql = lcSql + "usuBaja = " + IIF(ISNULL(cur_Familia.usuBaja),"NULL", "'" + ALLTRIM(cur_Familia.usuBaja) + "'") + ", "
		lcSql = lcSql + "fecBaja = " + IIF(ISNULL(cur_Familia.fecBaja),"NULL", loDT.toMySql(cur_Familia.fecBaja)) + ", "
		lcSql = lcSql + "idHostBaja = " + IIF(ISNULL(cur_Familia.idHostBaja),"NULL", "'" + ALLTRIM(cur_Familia.idHostBaja) + "'") + " "
		lcSql = lcSql + "WHERE idFamilia = " + ALLTRIM(STR(cur_Familia.idFamilia))
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			RETURN .F.
		ENDIF
	ENDIF
	
	loResult.Close_Query()
	
	SELECT cur_Familia
	lnCant = lnCant + 1
	loProg.update((lnCant * 100) / RECCOUNT(), "Actualizando Familias...")
	SELECT cur_Familia
	SKIP
ENDDO

loFamilia.Close_Query()
loProg.Complete()

***********************************************************************************************************
* Actualizo las SubFamilias
***********************************************************************************************************
Thisform.Contenido.txtDetalles.Value = Thisform.Contenido.txtDetalles.Value + CHR(13) + "Actualizando Subfamilias..."

lcSql = "SELECT * FROM subfam"
loSubFam.ActiveConnection = loConn.ActiveConnection
loSubFam.Cursor_Name = "cur_SubFam"
loSubFam.OpenQuery(lcSql)

loProg.show()

lnCant = 0
SELECT cur_SubFam
DO WHILE !EOF()
	lcSql = "SELECT COUNT(*) AS CantReg FROM subfam WHERE idSubFam = " + ALLTRIM(STR(cur_SubFam.idSubFam))
	loResult.ActiveConnection = goConn.ActiveConnection
	loResult.Cursor_Name = "cur_tmp"
	loResult.OpenQuery(lcSql)
	
	IF IIF(INT(VAL(getConfig("SQLSRV"))) = 1, cur_tmp.CantReg, VAL(cur_tmp.CantReg)) = 0 THEN
		lcSql = "INSERT INTO subfam ("
		lcSql = lcSql + "	idSubFam, "
		lcSql = lcSql + "	descripcio, "
		lcSql = lcSql + "	usuAlta, "
		lcSql = lcSql + "	fecAlta, "
		lcSql = lcSql + "	idHostAlta, "
		lcSql = lcSql + "	usuBaja, "
		lcSql = lcSql + "	fecBaja, "
		lcSql = lcSql + "	idHostBaja) VALUES ( "
		lcSql = lcSql + ALLTRIM(STR(cur_SubFam.idSubFam)) + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_SubFam.descripcio) + "', "
		lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
		lcSql = lcSql + loDT.getDateTime() + ", "
		lcSql = lcSql + "'" + ALLTRIM(STR(0)) + "', "
		lcSql = lcSql + IIF(ISNULL(cur_SubFam.usuBaja),"NULL", "'" + ALLTRIM(cur_SubFam.usuBaja) + "'") + ", "
		lcSql = lcSql + IIF(ISNULL(cur_SubFam.fecBaja),"NULL", loDT.toMySql(cur_SubFam.fecBaja)) + ", "
		lcSql = lcSql + IIF(ISNULL(cur_SubFam.idHostBaja),"NULL", "'" + ALLTRIM(cur_SubFam.idHostBaja) + "'") + ") "	
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			RETURN .F.
		ENDIF
	ELSE
		lcSql = "UPDATE subfam SET descripcio = '" + ALLTRIM(cur_SubFam.descripcio) + "', "
		lcSql = lcSql + "usuModi = '" + ALLTRIM(gcCodUsu) + "', "
		lcSql = lcSql + "fecModi = " + loDT.getDateTime() + ", "
		lcSql = lcSql + "idHostModi = '" + ALLTRIM(SYS(0)) + "', "
		lcSql = lcSql + "usuBaja = " + IIF(ISNULL(cur_SubFam.usuBaja),"NULL", "'" + ALLTRIM(cur_SubFam.usuBaja) + "'") + ", "
		lcSql = lcSql + "fecBaja = " + IIF(ISNULL(cur_SubFam.fecBaja),"NULL", loDT.toMySql(cur_SubFam.fecBaja)) + ", "
		lcSql = lcSql + "idHostBaja = " + IIF(ISNULL(cur_SubFam.idHostBaja),"NULL", "'" + ALLTRIM(cur_SubFam.idHostBaja) + "'") + " "
		lcSql = lcSql + "WHERE idSubFam = " + ALLTRIM(STR(cur_SubFam.idSubFam))
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			RETURN .F.
		ENDIF
	ENDIF
	
	loResult.Close_Query()		
	
	SELECT cur_SubFam
	lnCant = lnCant + 1
	loProg.update((lnCant * 100) / RECCOUNT(), "Actualizando Subfamilias...")
	SELECT cur_SubFam
	SKIP
ENDDO

loProg.complete()
loSubFam.Close_Query()

***********************************************************************************************************
* Actualizo los Proveedores
***********************************************************************************************************
Thisform.Contenido.txtDetalles.Value = Thisform.Contenido.txtDetalles.Value + CHR(13) + "Actualizando Proveedores..."

lcSql = "select * from proveedor"
loProv.ActiveConnection = loConn.ActiveConnection
loProv.Cursor_Name = "cur_prov"

loProg.Show()

IF !loProv.OpenQuery(lcSql) THEN
	goConn.Rollback()
	RETURN .F.
ENDIF

SELECT cur_prov
GO TOP
DO WHILE !EOF("cur_prov")
	lcSql = "select count(*) as cantReg from proveedor where idProv = " + ALLTRIM(STR(cur_prov.idProv))
	loResult.ActiveConnection = goConn.ActiveConnection
	loResult.Cursor_Name = "cur_tempo"
	loResult.OpenQuery(lcSql)
	
	IF IIF(INT(VAL(getConfig("SQLSRV"))) = 0, VAL(cur_tempo.cantReg), cur_tempo.cantReg) = 0 THEN
		lcSql = "insert into proveedor ( "
		lcSql = lcSql + "idProv, "
		lcSql = lcSql + "razSoc, "
		lcSql = lcSql + "nomFant, "
		lcSql = lcSql + "direccion, "
		lcSql = lcSql + "idLocalid, "
		lcSql = lcSql + "idCondPago, "
		lcSql = lcSql + "idSitIVA, "
		lcSql = lcSql + "nroCUIT, "
		lcSql = lcSql + "telefono, "
		lcSql = lcSql + "fax, "
		lcSql = lcSql + "eMail, "
		lcSql = lcSql + "pagWeb, "
		lcSql = lcSql + "observ, "
		lcSql = lcSql + "contacto, "
		lcSql = lcSql + "habilitado, "
		lcSql = lcSql + "tMon, "
		lcSql = lcSql + "cotizac, "
		lcSql = lcSql + "idTransp, "
		lcSql = lcSql + "usuAlta, "
		lcSql = lcSql + "fecAlta, "
		lcSql = lcSql + "idHostAlta, "
		lcSql = lcSql + "usuBaja, "
		lcSql = lcSql + "fecBaja, "
		lcSql = lcSql + "idHostBaja, "
		lcSql = lcSql + "idTipoDoc) "
		lcSql = lcSql + "values ( "
		lcSql = lcSql + ALLTRIM(STR(cur_prov.idProv)) + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_prov.razSoc) + "', "
		lcSql = lcSql + "'" + ALLTRIM(cur_prov.nomFant) + "', "
		lcSql = lcSql + "'" + ALLTRIM(cur_prov.direccion) + "', "
		lcSql = lcSql + ALLTRIM(STR(cur_prov.idLocalid)) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_prov.idCondPago)) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_prov.idSitIVA)) + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_prov.nroCUIT) + "', "
		lcSql = lcSql + "'" + ALLTRIM(cur_prov.telefono) + "', "
		lcSql = lcSql + "'" + ALLTRIM(cur_prov.fax) + "', "
		lcSql = lcSql + "'" + ALLTRIM(cur_prov.eMail) + "', "
		lcSql = lcSql + "'" + ALLTRIM(cur_prov.pagWeb) + "', "
		lcSql = lcSql + "'" + ALLTRIM(cur_prov.observ) + "', "
		lcSql = lcSql + "'" + ALLTRIM(cur_prov.contacto) + "', "
		lcSql = lcSql + IIF(cur_prov.habilitado, "1", "0") + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_prov.tMon) + "', "
		lcSql = lcSql + "0, "
		lcSql = lcSql + ALLTRIM(STR(cur_prov.idTransp)) + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_prov.usuAlta) + "', "
		lcSql = lcSql + loDT.toMySql(cur_prov.fecAlta) + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_prov.idHostAlta) + "', "
		lcSql = lcSql + IIF(ISNULL(cur_prov.usuBaja),"NULL", "'" + ALLTRIM(cur_prov.usuBaja) + "'") + ", "
		lcSql = lcSql + IIF(ISNULL(cur_prov.fecBaja),"NULL", loDT.toMySql(cur_prov.fecBaja)) + ", "
		lcSql = lcSql + IIF(ISNULL(cur_prov.idHostBaja),"NULL", "'" + ALLTRIM(cur_prov.idHostBaja) + "'") + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_prov.idTipoDoc)) + ") "	
	ELSE
		lcSql = "update proveedor "
		lcSql = lcSql + "set razSoc = '" + ALLTRIM(cur_prov.razSoc) + "', "
		lcSql = lcSql + "	nomFant = '" + ALLTRIM(cur_prov.nomFant) + "', "
		lcSql = lcSql + "	direccion = '" + ALLTRIM(cur_prov.direccion) + "', "
		lcSql = lcSql + "	idLocalid = " + ALLTRIM(STR(cur_prov.idLocalid)) + ", "
		lcSql = lcSql + "	idCondPago = " + ALLTRIM(STR(cur_prov.idCondPago)) + ", "
		lcSql = lcSql + "	idSitIVA = " + ALLTRIM(STR(cur_prov.idSitIVA)) + ", "
		lcSql = lcSql + "	nroCUIT = '" + ALLTRIM(cur_prov.nroCUIT) + "', "
		lcSql = lcSql + "	telefono = '" + ALLTRIM(cur_prov.telefono) + "', "
		lcSql = lcSql + "	fax = '" + ALLTRIM(cur_prov.fax) + "', "
		lcSql = lcSql + "	eMail = '" + ALLTRIM(cur_prov.eMail) + "', "
		lcSql = lcSql + "	pagWeb = '" + ALLTRIM(cur_prov.pagWeb) + "', "
		lcSql = lcSql + "	observ = '" + ALLTRIM(cur_prov.observ) + "', "
		lcSql = lcSql + "	contacto = '" + ALLTRIM(cur_prov.contacto) + "', "
		lcSql = lcSql + "	habilitado = " + IIF(cur_prov.habilitado, "1", "0") + ", "
		lcSql = lcSql + "	tMon = '" + ALLTRIM(cur_prov.tMon) + "', "
		lcSql = lcSql + "	cotizac = " + ALLTRIM(STR(cur_prov.cotizac, 10, 2)) + ", "
		lcSql = lcSql + "	idTransp = " + ALLTRIM(STR(cur_prov.idTransp)) + ", "
		lcSql = lcSql + "	usuModi = '" + ALLTRIM(gcCodUsu) + "', "
		lcSql = lcSql + "	fecModi = " + loDT.toMySql(DATETIME()) + ", "
		lcSql = lcSql + "	idHostModi = '" + ALLTRIM(SYS(0)) + "', "
		lcSql = lcSql + "	usuBaja = " + IIF(ISNULL(cur_prov.usuBaja),"NULL", "'" + ALLTRIM(cur_prov.usuBaja) + "'") + ", "
		lcSql = lcSql + "	fecBaja = " + IIF(ISNULL(cur_prov.fecBaja),"NULL", loDT.toMySql(cur_prov.fecBaja)) + ", "
		lcSql = lcSql + "	idHostBaja = " + IIF(ISNULL(cur_prov.idHostBaja),"NULL", "'" + ALLTRIM(cur_prov.idHostBaja) + "'") + ", "
		lcSql = lcSql + "	idTipoDoc = " + ALLTRIM(STR(cur_prov.idTipoDoc)) + " "	
		lcSql = lcSql + "where idProv = " + ALLTRIM(STR(cur_prov.idProv))
	ENDIF
	
	loResult.Close_Query()
	
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql

	IF !loCommand.execute() THEN
		goConn.Rollback()
		RETURN .F.
	ENDIF
	
	loProg.update((RECNO("cur_prov") * 100) / RECCOUNT("cur_prov"), "Actualizando Proveedores...")
	SELECT cur_prov
	SKIP 
ENDDO

loProg.Complete()
loProv.close_query()

***********************************************************************************************************
* Actualizo los Artículos
***********************************************************************************************************
Thisform.Contenido.txtDetalles.Value = Thisform.Contenido.txtDetalles.Value + CHR(13) + "Actualizando Artículos..."

lcSql = "SELECT * FROM articulos"
loArt.ActiveConnection = loConn.ActiveConnection
loArt.Cursor_Name = "cur_art"
loArt.OpenQuery(lcSql)

lnCant = 0
SELECT cur_art
DO WHILE !EOF("cur_art")
	lcSql = "SELECT COUNT(*) AS Cantidad FROM articulos WHERE idArticulo = " + ALLTRIM(STR(cur_art.idArticulo))
	loResult.ActiveConnection = goConn.ActiveConnection
	loResult.Cursor_Name = "cur_tmp"
	loResult.OpenQuery(lcSql)
	
	IF IIF(INT(VAL(getConfig("SQLSRV"))) = 1, cur_tmp.Cantidad, VAL(cur_tmp.Cantidad)) = 0 THEN
		lcSql = "INSERT INTO articulos ( "
		lcSql = lcSql + "	idArticulo, "
		lcSql = lcSql + "	idProv, "
		lcSql = lcSql + "	idFamilia, "
		lcSql = lcSql + "	idSubFam, "
		lcSql = lcSql + "	idMarca, "
		lcSql = lcSql + "	codArt, "
		lcSql = lcSql + "	descripcio, "
		lcSql = lcSql + "	alicIVA, "
		lcSql = lcSql + "	tMon, "
		lcSql = lcSql + "	prListaExt, "
		lcSql = lcSql + "	cotizac, "
		lcSql = lcSql + "	prLista, "
		lcSql = lcSql + "	bonif1, "
		lcSql = lcSql + "	bonif2, "
		lcSql = lcSql + "	bonif3, "
		lcSql = lcSql + "	bonif4, "
		lcSql = lcSql + "	costoRep, "
		lcSql = lcSql + "	margenMax, "
		lcSql = lcSql + "	margenMin, "
		lcSql = lcSql + "	prVentaMax, "
		lcSql = lcSql + "	prVentaMin, "
		lcSql = lcSql + "	prFinalMax, "
		lcSql = lcSql + "	prFinalMin, "
		lcSql = lcSql + "	observ, "
		lcSql = lcSql + "	habilitado, "
		lcSql = lcSql + "	linkFoto, "
		lcSql = lcSql + "	usuAlta, "
		lcSql = lcSql + "	fecAlta, "
		lcSql = lcSql + "	idHostAlta, "
		lcSql = lcSql + "	usuBaja, "
		lcSql = lcSql + "	fecBaja, "
		lcSql = lcSql + "	idHostBaja, "
		lcSql = lcSql + "	esServ, "
		lcSql = lcSql + "	mostrador, "
		lcSql = lcSql + "	idUniMed, "	
		lcSql = lcSql + "	codArtPV) VALUES ("
		lcSql = lcSql + ALLTRIM(STR(cur_art.idArticulo)) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_art.idProv)) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_art.idFamilia)) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_art.idSubFam)) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_art.idMarca)) + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_art.codArt) + "', "
		lcSql = lcSql + "'" + ALLTRIM(STRTRAN(cur_art.descripcio, "'", "''")) + "', "
		lcSql = lcSql + ALLTRIM(STR(cur_art.alicIVA, 10, 2)) + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_art.tMon) + "', "
		lcSql = lcSql + IIF(ISNULL(cur_art.prListaExt), "0", ALLTRIM(STR(cur_art.prListaExt, 10, 2))) + ", "
		lcSql = lcSql + IIF(ISNULL(cur_art.cotizac), "0", ALLTRIM(STR(cur_art.cotizac, 10, 2))) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_art.prLista, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_art.bonif1, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_art.bonif2, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_art.bonif3, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_art.bonif4, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_art.costoRep, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_art.margenMax, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_art.margenMin, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_art.prVentaMax, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_art.prVentaMin, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_art.prFinalMax, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_art.prFinalMin, 10, 2)) + ", "
		lcSql = lcSql +  IIF(ISNULL(cur_art.observ), "NULL", "'" + ALLTRIM(cur_art.observ) + "'") + ", "
		lcSql = lcSql + IIF(cur_art.habilitado, "1", "0") + ", "
		lcSql = lcSql + "'" + ALLTRIM(IIF(ISNULL(cur_art.linkFoto), "", cur_art.linkFoto)) + "', "
		lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
		lcSql = lcsql + loDT.getDateTime() + ", "
		lcSql = lcSql + "'" + SYS(0) + "', "
		lcSql = lcSql + IIF(ISNULL(cur_art.usuBaja),"NULL", "'" + ALLTRIM(cur_art.usuBaja) + "'") + ", "
		lcSql = lcSql + IIF(ISNULL(cur_art.fecBaja),"NULL", loDT.toMySql(cur_art.fecBaja)) + ", "
		lcSql = lcSql + IIF(ISNULL(cur_art.idHostBaja),"NULL", "'" + ALLTRIM(cur_art.idHostBaja) + "'") + ", "			
		lcSql = lcSql + IIF(cur_art.esServ, "1", "0") + ", "
		lcSql = lcSql + IIF(cur_art.mostrador, "1", "0") + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_art.idUniMed)) + ", "
		lcSql = lcSql + IIF(ISNULL(cur_art.codArtPV), "NULL", "'" + ALLTRIM(cur_art.codArtPv) + "'") + ") "
		_cliptext = lcSql
	ELSE
		lcSql = "UPDATE articulos "
		lcSql = lcSql + "SET 	idProv = " + ALLTRIM(STR(cur_art.idProv)) + ", "
		lcSql = lcSql + "		idFamilia = " + ALLTRIM(STR(cur_art.idFamilia)) + ", "
		lcSql = lcSql + " 		idSubFam = " + ALLTRIM(STR(cur_art.idSubFam)) + ", "
		lcSql = lcSql + " 		idMarca = " + ALLTRIM(STR(cur_art.idMarca)) + ", "
		lcSql = lcSql + "		codArt = '" + ALLTRIM(cur_art.codArt) + "', "
		lcSql = lcSql + "		descripcio = '" + ALLTRIM(STRTRAN(cur_art.descripcio, "'", "''")) + "', "
		lcSql = lcSql + "		alicIVA = " + ALLTRIM(STR(cur_art.alicIVA, 10, 2)) + ", "
		lcSql = lcSql + "		tMon = '" + ALLTRIM(cur_art.tMon) + "', "
		lcSql = lcSql + "		prListaExt = " + ALLTRIM(STR(cur_art.prListaExt, 10, 2)) + ", "
		lcSql = lcSql + "		cotizac = " + ALLTRIM(STR(cur_art.cotizac, 10, 2)) + ", "
		lcSql = lcSql + "		prLista = " + ALLTRIM(STR(cur_art.prLista, 10, 2)) + ", "
		lcSql = lcSql + "		bonif1 = " + ALLTRIM(STR(cur_art.bonif1, 10, 2)) + ", "
		lcSql = lcSql + "		bonif2 = " + ALLTRIM(STR(cur_art.bonif2, 10, 2)) + ", "
		lcSql = lcSql + "		bonif3 = " + ALLTRIM(STR(cur_art.bonif3, 10, 2)) + ", "
		lcSql = lcSql + "		bonif4 = " + ALLTRIM(STR(cur_art.bonif4, 10, 2)) + ", "
		lcSql = lcSql + "		costoRep = " + ALLTRIM(STR(cur_art.costoRep, 10, 2)) + ", "
		lcSql = lcSql + "		margenMax = " + ALLTRIM(STR(cur_art.margenMax, 10, 2)) + ", "
		lcSql = lcSql + "		margenMin = " + ALLTRIM(STR(cur_art.margenMin, 10, 2)) + ", "
		lcSql = lcSql + "		prVentaMax = " + ALLTRIM(STR(cur_art.prVentaMax, 10, 2)) + ", "
		lcSql = lcSql + "		prVentaMin = " + ALLTRIM(STR(cur_art.prVentaMin, 10, 2)) + ", "
		lcSql = lcSql + "		prFinalMax = " + ALLTRIM(STR(cur_art.prFinalMax, 10, 2)) + ", "
		lcSql = lcSql + "		prFinalMin = " + ALLTRIM(STR(cur_art.prFinalMin, 10, 2)) + ", "
		lcSql = lcSql + "		observ = '" + ALLTRIM(cur_art.observ) + "', "
		lcSql = lcSql + "		habilitado = " + ALLTRIM(STR(IIF(cur_art.habilitado, 1, 0))) + ", "
		lcSql = lcSql + "		linkFoto = '" + ALLTRIM(IIF(ISNULL(cur_art.linkFoto), "", cur_art.linkFoto)) + "', "
		lcSql = lcSql + "		usuModi = '" + ALLTRIM(gcCodUsu) + "', "
		lcSql = lcSql + "		fecModi = " + loDT.getDateTime() + ", "
		lcSql = lcSql + "		idHostModi = '" + ALLTRIM(SYS(0)) + "', "
		lcSql = lcSql + "		usuBaja = " + IIF(ISNULL(cur_art.usuBaja),"NULL", "'" + ALLTRIM(cur_art.usuBaja) + "'") + ", "
		lcSql = lcSql + "		fecBaja = " + IIF(ISNULL(cur_art.fecBaja),"NULL", loDT.toMySql(cur_art.fecBaja)) + ", "
		lcSql = lcSql + "		idHostBaja = " + IIF(ISNULL(cur_art.idHostBaja),"NULL", "'" + ALLTRIM(cur_art.idHostBaja) + "'") + ", "		
		lcSql = lcSql + "		esServ = " + IIF(cur_art.esServ, "1", "0") + ", "
		lcSql = lcSql + "		mostrador = " + IIF(cur_art.mostrador, "1", "0") + ", "
		lcSql = lcSql + "		idUniMed = " + ALLTRIM(STR(cur_art.idUniMed)) + ", "
		lcSql = lcSql + "		codArtPv = " + IIF(ISNULL(cur_art.codArtPV), "NULL", "'" + ALLTRIM(cur_art.codArtPv) + "'") + " "
		lcSql = lcSql + "WHERE	idArticulo = " + ALLTRIM(STR(cur_art.idArticulo))
	ENDIF

	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute() THEN
		loCommand.Rollback()
		RETURN .F.
	ENDIF
	
	loResult.Close_Query()
		
	SELECT cur_art
	lnCant = lnCant + 1
	loProg.update((lnCant * 100) / RECCOUNT(), "Actualizando Artículos...")
	SELECT cur_art
	SKIP
ENDDO

loArt.Close_Query()


***********************************************************************************************************
* Actualizo CodiArt
***********************************************************************************************************
loProg.Show()
Thisform.Contenido.txtDetalles.Value = Thisform.Contenido.txtDetalles.Value + CHR(13) + "Actualizando Códigos de Artículos..."

lcSql = "DELETE FROM codiart"

loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = lcSql

IF !loCommand.Execute() THEN
	goConn.Rollback()
	RETURN .F.
ENDIF

lcSql = "SELECT * FROM codiart WHERE idArticulo IN (SELECT idArticulo FROM articulos)"
loCodiArt.ActiveConnection = loConn.ActiveConnection
loCodiArt.Cursor_Name = "cur_codiart"
loCodiArt.OpenQuery(lcSql)
lnCant = 0

SELECT cur_codiart
DO WHILE !EOF()
	 
	&& Le doy formato a los codigos de barra, sino tira error.
	lcCodigo = ALLTRIM(IIF(ISNULL(cur_codiart.codigos), "", STRTRAN(cur_codiart.codigos, "'", "''")))
	lcCodigo = IIF(lcSqlSrv = 1, lcCodigo, STRTRAN(lcCodigo, "\", "\\"))
	
	lcSql = "INSERT INTO codiart ("
	lcSql = lcSql + "	idCodArt, "
	lcSql = lcSql + "	idArticulo, "
	lcSql = lcSql + "	codArt, "
	lcSql = lcSql + "	codigos, "
	lcSql = lcSql + "	tipo, "
	lcSql = lcSql + "	cantidesp, "
	lcSql = lcSql + "	procesado, "
	lcSql = lcSql + "	circuito) VALUES ( "
	lcSql = lcSql + ALLTRIM(STR(cur_codiart.idCodArt)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_codiart.idArticulo)) + ", "
	lcSql = lcSql + "'" + ALLTRIM(cur_codiart.codArt) + "', "
	lcSql = lcSql + "'" + lcCodigo + "', "
	lcSql = lcSql + "'" + ALLTRIM(cur_codiart.tipo) + "', "
	lcSql = lcSql + ALLTRIM(STR(cur_codiart.cantidesp, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(IIF(cur_codiart.procesado, "1", "0")) + ", "
	lcSql = lcSql + "'" + ALLTRIM(cur_codiart.circuito) + "') "
	
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql

	IF !loCommand.Execute() THEN	
		MESSAGEBOX(cur_codiart.idcodart)
		goConn.Rollback()
		RETURN .F.
	ENDIF
	
	SELECT cur_codiart
	lnCant = lnCant + 1
	loProg.update((lnCant * 100) / RECCOUNT(), "Actualizando Códigos de Artículos...")
	SELECT cur_codiart
	SKIP
ENDDO

loCodiArt.Close_Query()
loProg.Complete()


***********************************************************************************************************
* Actualizo Equivalencias
***********************************************************************************************************
loProg.Show()
Thisform.Contenido.txtDetalles.Value = Thisform.Contenido.txtDetalles.Value + CHR(13) + "Actualizando Equivalencias..."

lcSql = "DELETE FROM art_equiv"

loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = lcSql

IF !loCommand.Execute() THEN
	goConn.Rollback()
	RETURN .F.
ENDIF

lcSql = "SELECT * FROM art_equiv"
loEquiv.ActiveConnection = loConn.ActiveConnection
loEquiv.Cursor_Name = "cur_equiv"
loEquiv.OpenQuery(lcSql)
lnCant = 0

SELECT cur_equiv
DO WHILE !EOF()
	
	lcSql = "INSERT INTO art_equiv ("
	lcSql = lcSql + "	idArtEqui, "
	lcSql = lcSql + "	idArtic_A, "
	lcSql = lcSql + "	idArtic_B, "
	lcSql = lcSql + "	codArt_A, "
	lcSql = lcSql + "	codArt_B) VALUES ( "
	lcSql = lcSql + ALLTRIM(STR(cur_equiv.idArtEqui)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_equiv.idArtic_A)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_equiv.idArtic_B)) + ", "
	lcSql = lcSql + "'" + ALLTRIM(cur_equiv.codArt_A) + "', "
	lcSql = lcSql + "'" + ALLTRIM(cur_equiv.codArt_B) + "') "
	
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql

	IF !loCommand.Execute() THEN	
		MESSAGEBOX(cur_equiv.idcodart)
		goConn.Rollback()
		RETURN .F.
	ENDIF
	
	SELECT cur_equiv
	lnCant = lnCant + 1
	loProg.update((lnCant * 100) / RECCOUNT(), "Actualizando Equivalencias...")
	SELECT cur_equiv
	SKIP
ENDDO

loEquiv.Close_Query()
loProg.Complete()


goConn.Commit()

RETURN .T.
ENDPROC
PROCEDURE actualizar_clientes
LOCAL lcSql, loResult, loCommand, loConn, loResCli, loDT, loProg
LOCAL lnIdCliente, lcRazSoc, lcNomFant, lcDireccion, idLocalidad
LOCAL lnIdCondPago, lnIdSitIVA, lcNroCUIT, lcTelefono, lcFax, lcEMail
LOCAL lcPagWeb, lcObserv, lcContacto, lnHabilitado, lnMayorista
LOCAL lnDesc1, lnDesc2, lnDesc3, lnDesc4, lnIdTransp, lcUsuAlta
LOCAL ldFecAlta, lcIdHostAlta, lnCont, lnIdVendedor, lnIdTipoCli, lcCelular 
LOCAL lnCtrMoro, lnRecargo, lnContrCM, lnCredMax, lnIdTipoDoc, lnIdRamo
LOCAL lcEMailFC, llEnvCbte, llPrintCbte

lcSql = ""
loConn = CREATEOBJECT("odbc_connect")
loResult = CREATEOBJECT("odbc_result")
loResCli = CREATEOBJECT("odbc_result")
loCommand = CREATEOBJECT("odbc_command")
loDT = CREATEOBJECT("datetime")
loProg = CREATEOBJECT("_thermometer")

loConn.ConnectionString = ALLTRIM(getConfig("ODBC_C1"))

IF !loConn.Open() THEN
	MESSAGEBOX(loConn.ErrorMessage, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

lcSql = "SELECT * FROM clientes"
loResult.ActiveConnection = loConn.ActiveConnection
loResult.Cursor_Name = "cur_cli"

IF !loResult.OpenQuery(lcSql) THEN
	MESSAGEBOX(loResult.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

loProg.show()

Thisform.Contenido.txtDetalles.Value = Thisform.Contenido.txtDetalles.Value + CHR(13) + "Actualizando Clientes..."
goConn.BeginTransaction()

lnCont = 0

SELECT cur_cli
DO WHILE !EOF("cur_cli")
	lcRazSoc = cur_cli.razSoc
	lcNomFant = IIF(ISNULL(cur_cli.nomFant), "", cur_cli.nomFant)
	lcDireccion = cur_cli.direccion
	lnIdLocalidad = cur_cli.idLocalid
	lnIdCondPago = cur_cli.idCondPago
	lnIdSitIVA = cur_cli.idSitIVA
	lnIdVendedor = cur_cli.idVendedor
	lnIdTipoCli = cur_cli.idTipoCli
	lnIdTransp = cur_cli.idTransp
	lcNroCUIT = cur_cli.nroCUIT
	lcTelefono = cur_cli.telefono
	lcCelular = cur_cli.celular
	lcFax = cur_cli.fax
	lcEMail = IIF(ISNULL(cur_cli.eMail), "", cur_cli.eMail)
	lcPagWeb = IIF(ISNULL(cur_cli.pagWeb), "", cur_cli.pagWeb)
	lcObserv = IIF(ISNULL(cur_cli.observ), "", cur_cli.observ)
	lcContacto = IIF(ISNULL(cur_cli.contacto), "", cur_cli.contacto)	
	lnHabilitado = cur_cli.habilitado
	lnMayorista = cur_cli.mayorista
	lnDesc1 = cur_cli.desc1
	lnDesc2 = cur_cli.desc2
	lnDesc3 = cur_cli.desc3
	lnDesc4 = cur_cli.desc4
	lnCtrMoro = cur_cli.ctrMoro
	lnRecargo = cur_cli.recargo
	lnContrCM = cur_cli.contrCM
	lnCredMax = IIF(ISNULL(cur_cli.credmax), 0.00, cur_cli.credmax)
	lcUsuAlta = cur_cli.usuAlta
	ldFecAlta = cur_cli.fecAlta
	lcIdHostAlta = cur_cli.idHostAlta	
	lnIdTipoDoc = cur_cli.idTipoDoc
	lnIdRamo = cur_cli.idRamo
	lcEMailFC = IIF(ISNULL(cur_cli.mailFC), "", cur_cli.mailFC)
	llEnvCbte = cur_cli.envCbte
	llPrintCbte = cur_cli.printCbte
	
	lcSql = "SELECT * FROM clientes WHERE idCliente = " + ALLTRIM(STR(cur_cli.idCliente))
	loResCli.ActiveConnection = goConn.ActiveConnection
	loResCli.Cursor_Name = "cur_tempo"
	
	IF !loResCli.OpenQuery(lcSql) THEN
		MESSAGEBOX(loResCli.Error_Message, 0+48, Thisform.Caption)
		RETURN .F.
	ENDIF
	
	SELECT cur_tempo
	IF RECCOUNT("cur_tempo") = 0 THEN
		lnIdCliente = cur_cli.idCliente
	
		lcSql = "INSERT INTO clientes ("
		lcSql = lcSql + "idCliente, "
		lcSql = lcSql + "razSoc, "
		lcSql = lcSql + "nomFant, "
		lcSql = lcSql + "direccion, "
		lcSql = lcSql + "idLocalid, "
		lcSql = lcSql + "idCondPago, "
		lcSql = lcSql + "idSitIVA, "
		lcSql = lcSql + "idVendedor, "
		lcSql = lcSql + "idTipoCli, "
		lcSql = lcSql + "idTransp, "
		lcSql = lcSql + "nroCUIT, "
		lcSql = lcSql + "telefono, "
		lcSql = lcSql + "celular, "
		lcSql = lcSql + "fax, "
		lcSql = lcSql + "eMail, "
		lcSql = lcSql + "pagWeb, "
		lcSql = lcSql + "observ, "
		lcSql = lcSql + "contacto, "
		lcSql = lcSql + "habilitado, "
		lcSql = lcSql + "mayorista, "
		lcSql = lcSql + "desc1, "
		lcSql = lcSql + "desc2, "
		lcSql = lcSql + "desc3, "
		lcSql = lcSql + "desc4, "
		lcSql = lcSql + "ctrMoro, "
		lcSql = lcSql + "recargo, "
		lcSql = lcSql + "contrCM, "
		lcSql = lcSql + "credMax, "
		lcSql = lcSql + "idRamo, "
		lcSql = lcSql + "idTipoDoc, "
		lcSql = lcSql + "mailFC, "
		lcSql = lcSql + "envCbte, "
		lcSql = lcSql + "printCbte, "
		lcSql = lcSql + "usuAlta, "
		lcSql = lcSql + "fecAlta, "
		lcSql = lcSql + "idHostAlta, "
		lcSql = lcSql + "usuBaja, "
		lcSql = lcSql + "fecBaja, "
		lcSql = lcSql + "idHostBaja) "
		lcSql = lcSql + "VALUES ( "
		lcSql = lcSql + ALLTRIM(STR(lnIdCliente)) + ", "
		lcSql = lcSql + "'" + ALLTRIM(STRTRAN(lcRazSoc, "'", "''")) + "', "
		lcSql = lcSql + "'" + ALLTRIM(IIF(ISNULL(lcNomFant), "", STRTRAN(lcNomFant, "'", "''"))) + "', "
		lcSql = lcSql + "'" + ALLTRIM(IIF(ISNULL(lcDireccion), "", STRTRAN(lcDireccion, "'", "''"))) + "', "
		lcSql = lcSql + ALLTRIM(STR(lnIdLocalidad)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnIdCondPago)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnIdSitIVA)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnIdVendedor)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnIdTipoCli)) + ", "
		lcSql = lcSql + ALLTRIM(STR(IIF(ISNULL(lnIdTransp), 0, lnIdTransp))) + ", "
		lcSql = lcSql + "'" + ALLTRIM(IIF(ISNULL(lcNroCUIT), "", lcNroCUIT)) + "', "
		lcSql = lcSql + "'" + ALLTRIM(IIF(ISNULL(lcTelefono), "", lcTelefono)) + "', "
		lcSql = lcSql + "'" + ALLTRIM(IIF(ISNULL(lcCelular), "", lcCelular)) + "', "
		lcSql = lcSql + "'" + ALLTRIM(IIF(ISNULL(lcFax), "", lcFax)) + "', "
		lcSql = lcSql + "'" + ALLTRIM(IIF(ISNULL(lcEMail), "", lcEMail)) + "', "
		lcSql = lcSql + "'" + ALLTRIM(IIF(ISNULL(lcPagWeb), "", lcPagWeb)) + "', "
		lcSql = lcSql + "'" + ALLTRIM(IIF(ISNULL(lcObserv), "", lcObserv)) + "', "
		lcSql = lcSql + "'" + ALLTRIM(IIF(ISNULL(lcContacto), "", lcContacto)) + "', "
		lcSql = lcSql + ALLTRIM(IIF(lnHabilitado, "1", "0")) + ", "
		lcSql = lcSql + ALLTRIM(IIF(lnMayorista, "1", "0")) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnDesc1, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnDesc2, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnDesc3, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnDesc4, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(IIF(lnCtrMoro, "1", "0")) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnRecargo, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(IIF(lnContrCM, "1", "0")) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnCredMax, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnIdRamo)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnIdTipoDoc)) + ", "
		lcSql = lcSql + "'" + ALLTRIM(lcEMailFC) + "', "
		lcSql = lcSql + IIF(llEnvCbte, "1", "0") + ", "
		lcSql = lcSql + IIF(llPrintCbte, "1", "0") + ", "
		lcSql = lcSql + "'" + ALLTRIM(lcUsuAlta) + "', "
		lcSql = lcSql + loDT.toMySql(ldFecAlta) + ", "
		lcSql = lcSql + "'" + ALLTRIM(lcIdHostAlta) + "', "
		lcSql = lcSql + IIF(ISNULL(cur_cli.usuBaja),"NULL", "'" + ALLTRIM(cur_cli.usuBaja) + "'") + ", "
		lcSql = lcSql + IIF(ISNULL(cur_cli.fecBaja),"NULL", loDT.toMySql(cur_cli.fecBaja)) + ", "
		lcSql = lcSql + IIF(ISNULL(cur_cli.idHostBaja),"NULL", "'" + ALLTRIM(cur_cli.idHostBaja) + "'") + ") "		
	ELSE
		lcSql = "UPDATE clientes SET "
		lcSql = lcSql + "razSoc = '" + ALLTRIM(STRTRAN(lcRazSoc, "'", "''")) + "', "
		lcSql = lcSql + "nomFant = '" + ALLTRIM(STRTRAN(lcNomFant, "'", "''")) + "', "
		lcSql = lcSql + "direccion = '" + ALLTRIM(STRTRAN(lcDireccion, "'", "''")) + "', "
		lcSql = lcSql + "idLocalid = " + ALLTRIM(STR(lnIdLocalidad)) + ", "
		lcSql = lcSql + "idCondPago = " + ALLTRIM(STR(lnIdCondPago)) + ", "
		lcSql = lcSql + "idSitIVA = " + ALLTRIM(STR(lnIdSitIVA)) + ", "
		lcSql = lcSql + "idVendedor = " + ALLTRIM(STR(lnIdVendedor)) + ", "
		lcSql = lcSql + "idTipoCli = " + ALLTRIM(STR(cur_cli.idTipoCli)) + ", "
		lcSql = lcSql + "idTransp = " + ALLTRIM(STR(lnIdTransp)) + ", "
		lcSql = lcSql + "nroCUIT = '" + ALLTRIM(lcNroCUIT) + "', "
		lcSql = lcSql + "telefono = '" + ALLTRIM(lcTelefono) + "', "
		lcSql = lcSql + "celular = '" + ALLTRIM(lcCelular) + "', "
		lcSql = lcSql + "fax = '" + ALLTRIM(lcFax) + "', "
		lcSql = lcSql + "eMail = '" + ALLTRIM(lcEMail) + "', "
		lcSql = lcSql + "pagWeb = '" + ALLTRIM(lcPagWeb) + "', "
		lcSql = lcSql + "observ = '" + ALLTRIM(lcObserv) + "', "
		lcSql = lcSql + "contacto = '" + ALLTRIM(lcContacto) + "', "
		lcSql = lcSql + "habilitado = " + ALLTRIM(IIF(lnHabilitado, "1", "0")) + ", "
		lcSql = lcSql + "mayorista = " + ALLTRIM(IIF(lnMayorista, "1", "0")) + ", "
		lcSql = lcSql + "desc1 = " + ALLTRIM(STR(lnDesc1, 10, 2)) + ", "
		lcSql = lcSql + "desc2 = " + ALLTRIM(STR(lnDesc2, 10, 2)) + ", "
		lcSql = lcSql + "desc3 = " + ALLTRIM(STR(lnDesc3, 10, 2)) + ", "
		lcSql = lcSql + "desc4 = " + ALLTRIM(STR(lnDesc4, 10, 2)) + ", "
		lcSql = lcSql + "ctrMoro = " + ALLTRIM(IIF(lnCtrMoro, "1", "0")) + ", "
		lcSql = lcSql + "recargo = " + ALLTRIM(STR(lnRecargo, 10, 2)) + ", "
		lcSql = lcSql + "contrCM = " + ALLTRIM(IIF(lnContrCM, "1", "0")) + ", "
		lcSql = lcSql + "credMax = " + ALLTRIM(STR(lnCredMax, 10, 2)) + ", "
		lcSql = lcSql + "idTipoDoc = " + ALLTRIM(STR(lnIdTipoDoc)) + ", "
		lcSql = lcSql + "mailFC = '" + ALLTRIM(lcEMailFC) + "', "
		lcSql = lcSql + "envCbte = " + IIF(llEnvCbte, "1", "0") + ", "
		lcSql = lcSql + "printCbte = " + IIF(llPrintCbte, "1", "0") + ", "
		lcSql = lcSql + "idRamo = " + ALLTRIM(STR(lnIdRamo)) + ", "
		lcSql = lcSql + "usuModi = '" + ALLTRIM(gcCodUsu) + "', "
		lcSql = lcSql + "fecModi = " + loDT.getDateTime() + ", "
		lcSql = lcSql + "idHostModi = '" + ALLTRIM(SYS(0)) + "', "
		lcSql = lcSql + "usuBaja = " + IIF(ISNULL(cur_cli.usuBaja),"NULL", "'" + ALLTRIM(cur_cli.usuBaja) + "'") + ", "
		lcSql = lcSql + "fecBaja = " + IIF(ISNULL(cur_cli.fecBaja),"NULL", loDT.toMySql(cur_cli.fecBaja)) + ", "
		lcSql = lcSql + "idHostBaja = " + IIF(ISNULL(cur_cli.idHostBaja),"NULL", "'" + ALLTRIM(cur_cli.idHostBaja) + "'") + " "			
		lcSql = lcSql + "WHERE idCliente = " + ALLTRIM(STR(cur_cli.idCliente))	
	ENDIF
	
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute() THEN
		goConn.Rollback()
		MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
		RETURN .F.
	ENDIF
	
	loResCli.Close_Query()
	
	SELECT cur_cli
	lnCont = lnCont + 1
	loProg.update((lnCont * 100) / RECCOUNT("cur_cli"), "Actualizando Clientes")
	
	SELECT cur_cli
	SKIP
ENDDO

goConn.Commit()

RETURN .T.

ENDPROC
PROCEDURE actualizar_tablas
****************************************************************************
* Este método permite actualizar las tablas: paises, provincias, localidades,
* condpagos, sitiva, vendedores, tiposcli, transportes, unidmed
****************************************************************************

LOCAL loConn, loPaises, loProv, loLoc, loCondPagos, loSitIva, loVend, loTiposCli, loTransp
LOCAL loUnidMed, loBancos, loCtaCja, loPlanctas, loUsuarios, loRamos
LOCAL lcSql, loCommand, loResult, loDT, loProg, lnCant, lcSqlSrv

loConn = CREATEOBJECT("odbc_connect")
loCommand = CREATEOBJECT("odbc_command")
loPaises = CREATEOBJECT("odbc_result")
loProv = CREATEOBJECT("odbc_result")
loLoc = CREATEOBJECT("odbc_result")
loCondPagos = CREATEOBJECT("odbc_result")
loSitIva = CREATEOBJECT("odbc_result")
loVend = CREATEOBJECT("odbc_result")
loTiposCli = CREATEOBJECT("odbc_result")
loTransp = CREATEOBJECT("odbc_result")
loUnidMed = CREATEOBJECT("odbc_result")
loBancos = CREATEOBJECT("odbc_result")
loCtaCja = CREATEOBJECT("odbc_result")
loPlanctas = CREATEOBJECT("odbc_result")
loUsuarios = CREATEOBJECT("odbc_result")
loRamos = CREATEOBJECT("odbc_result")
loResult = CREATEOBJECT("odbc_result")
loDT = CREATEOBJECT("datetime")
loProg = CREATEOBJECT("_thermometer")
lcSql = ""

loConn.ConnectionString = ALLTRIM(getConfig("ODBC_C1"))

IF !loConn.Open() THEN
	MESSAGEBOX(loConn.ErrorMessage, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

goConn.BeginTransaction()

***********************************************************************************************************
* Actualizo paises
***********************************************************************************************************
loProg.Show()
Thisform.Contenido.txtDetalles.Value = "Actualizando Países..."

lcSql = "SELECT * FROM paises"
loPaises.ActiveConnection = loConn.ActiveConnection
loPaises.Cursor_Name = "cur_paises"
loPaises.OpenQuery(lcSql)
lnCant = 0

SELECT cur_paises
DO WHILE !EOF()
	lcSql = "SELECT COUNT(*) AS CantReg FROM paises WHERE idPais = " + ALLTRIM(STR(cur_paises.idPais))
	loResult.ActiveConnection = goConn.ActiveConnection
	loResult.Cursor_Name = "cur_tmp"
	loResult.OpenQuery(lcSql)
	
	IF IIF(INT(VAL(getConfig("SQLSRV"))) = 1, cur_tmp.CantReg, VAL(cur_tmp.CantReg)) = 0 THEN
		lcSql = "INSERT INTO paises ("
		lcSql = lcSql + "	idPais, "
		lcSql = lcSql + "	descripcio, "
		lcSql = lcSql + "	usuAlta, "
		lcSql = lcSql + "	fecAlta, "
		lcSql = lcSql + "	idHostAlta, "
		lcSql = lcSql + "	usuModi, "
		lcSql = lcSql + "	fecModi, "
		lcSql = lcSql + "	idHostModi, "
		lcSql = lcSql + "	usuBaja, "
		lcSql = lcSql + "	fecBaja, "
		lcSql = lcSql + "	idHostBaja) VALUES ( "
		lcSql = lcSql + ALLTRIM(STR(cur_paises.idPais)) + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_paises.descripcio) + "', "
		lcSql = lcSql + "'" + ALLTRIM(cur_paises.usuAlta) + "', "
		lcSql = lcSql + loDT.toMySql(cur_paises.fecAlta) + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_paises.idHostAlta) + "', "
		lcSql = lcSql + IIF(ISNULL(cur_paises.usuModi),"NULL", "'" + ALLTRIM(cur_paises.usuModi) + "'") + ", "
		lcSql = lcSql + IIF(ISNULL(cur_paises.fecModi),"NULL", loDT.toMySql(cur_paises.fecModi)) + ", "
		lcSql = lcSql + IIF(ISNULL(cur_paises.idHostModi),"NULL", "'" + ALLTRIM(cur_paises.idHostModi) + "'") + ", "
		lcSql = lcSql + IIF(ISNULL(cur_paises.usuBaja),"NULL", "'" + ALLTRIM(cur_paises.usuBaja) + "'") + ", "
		lcSql = lcSql + IIF(ISNULL(cur_paises.fecBaja),"NULL", loDT.toMySql(cur_paises.fecBaja)) + ", "
		lcSql = lcSql + IIF(ISNULL(cur_paises.idHostBaja),"NULL", "'" + ALLTRIM(cur_paises.idHostBaja) + "'") + ")"
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
	
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			RETURN .F.
		ENDIF
	ELSE
		lcSql = "UPDATE paises SET descripcio = '" + ALLTRIM(cur_paises.descripcio) + "', "
		lcSql = lcSql + "usuModi = " + IIF(ISNULL(cur_paises.usuModi),"NULL", "'" + ALLTRIM(cur_paises.usuModi) + "'")+ ", "
		lcSql = lcSql + "fecModi = " + IIF(ISNULL(cur_paises.fecModi),"NULL", loDT.toMySql(cur_paises.fecModi)) + ", "
		lcSql = lcSql + "idHostModi = " + IIF(ISNULL(cur_paises.idHostModi),"NULL", "'" + ALLTRIM(cur_paises.idHostModi) + "'")+ ", "
		lcSql = lcSql + "usuBaja = " + IIF(ISNULL(cur_paises.usuBaja),"NULL", "'" + ALLTRIM(cur_paises.usuBaja) + "'")+ ", "
		lcSql = lcSql + "fecBaja = " + IIF(ISNULL(cur_paises.fecBaja),"NULL", loDT.toMySql(cur_paises.fecBaja)) + ", "
		lcSql = lcSql + "idHostBaja = " + IIF(ISNULL(cur_paises.idHostBaja),"NULL", "'" + ALLTRIM(cur_paises.idHostBaja) + "'") + " "
		lcSql = lcSql + "WHERE idPais = " + ALLTRIM(STR(cur_paises.idPais))

		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			RETURN .F.
		ENDIF
	ENDIF
	
	loResult.Close_Query()
	
	SELECT cur_paises
	lnCant = lnCant + 1
	loProg.update((lnCant * 100) / RECCOUNT(), "Actualizando Países...")
	SELECT cur_paises
	SKIP
ENDDO

loPaises.Close_Query()
loProg.Complete()

***********************************************************************************************************
* Actualizo provincias
***********************************************************************************************************
loProg.Show()
Thisform.Contenido.txtDetalles.Value = Thisform.Contenido.txtDetalles.Value + CHR(13) + "Actualizando Provincias..."

lcSql = "SELECT * FROM provincias"
loProv.ActiveConnection = loConn.ActiveConnection
loProv.Cursor_Name = "cur_provincias"
loProv.OpenQuery(lcSql)
lnCant = 0

SELECT cur_provincias
DO WHILE !EOF()
	lcSql = "SELECT COUNT(*) AS CantReg FROM provincias WHERE idProvin = " + ALLTRIM(STR(cur_provincias.idProvin))
	loResult.ActiveConnection = goConn.ActiveConnection
	loResult.Cursor_Name = "cur_tmp"
	loResult.OpenQuery(lcSql)
	
	IF IIF(INT(VAL(getConfig("SQLSRV"))) = 1, cur_tmp.CantReg, VAL(cur_tmp.CantReg)) = 0 THEN
		lcSql = "INSERT INTO provincias("
		lcSql = lcSql + "	idProvin, "
		lcSql = lcSql + "	descripcio, "
		lcSql = lcSql + "	usuAlta, "
		lcSql = lcSql + "	fecAlta, "
		lcSql = lcSql + "	idHostAlta, "
		lcSql = lcSql + "	usuModi, "
		lcSql = lcSql + "	fecModi, "
		lcSql = lcSql + "	idHostModi, "
		lcSql = lcSql + "	usuBaja, "
		lcSql = lcSql + "	fecBaja, "
		lcSql = lcSql + "	idHostBaja) VALUES ( "
		lcSql = lcSql + ALLTRIM(STR(cur_provincias.idProvin)) + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_provincias.descripcio) + "', "
		lcSql = lcSql + "'" + ALLTRIM(cur_provincias.usuAlta) + "', "
		lcSql = lcSql + loDT.toMySql(cur_provincias.fecAlta) + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_provincias.idHostAlta) + "', "
		lcSql = lcSql + IIF(ISNULL(cur_provincias.usuModi),"NULL", "'" + ALLTRIM(cur_provincias.usuModi) + "'") + ", "
		lcSql = lcSql + IIF(ISNULL(cur_provincias.fecModi),"NULL", loDT.toMySql(cur_provincias.fecModi)) + ", "
		lcSql = lcSql + IIF(ISNULL(cur_provincias.idHostModi),"NULL", "'" + ALLTRIM(cur_provincias.idHostModi) + "'") + ", "
		lcSql = lcSql + IIF(ISNULL(cur_provincias.usuBaja),"NULL", "'" + ALLTRIM(cur_provincias.usuBaja) + "'") + ", "
		lcSql = lcSql + IIF(ISNULL(cur_provincias.fecBaja),"NULL", loDT.toMySql(cur_provincias.fecBaja)) + ", "
		lcSql = lcSql + IIF(ISNULL(cur_provincias.idHostBaja),"NULL", "'" + ALLTRIM(cur_provincias.idHostBaja) + "'") + ")"
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
	
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			RETURN .F.
		ENDIF
	ELSE
		lcSql = "UPDATE provincias SET descripcio = '" + ALLTRIM(cur_provincias.descripcio) + "', "
		lcSql = lcSql + "usuModi = " + IIF(ISNULL(cur_provincias.usuModi),"NULL", "'" + ALLTRIM(cur_provincias.usuModi) + "'")+ ", "
		lcSql = lcSql + "fecModi = " + IIF(ISNULL(cur_provincias.fecModi),"NULL", loDT.toMySql(cur_provincias.fecModi)) + ", "
		lcSql = lcSql + "idHostModi = " + IIF(ISNULL(cur_provincias.idHostModi),"NULL", "'" + ALLTRIM(cur_provincias.idHostModi) + "'")+ ", "
		lcSql = lcSql + "usuBaja = " + IIF(ISNULL(cur_provincias.usuBaja),"NULL", "'" + ALLTRIM(cur_provincias.usuBaja) + "'")+ ", "
		lcSql = lcSql + "fecBaja = " + IIF(ISNULL(cur_provincias.fecBaja),"NULL", loDT.toMySql(cur_provincias.fecBaja)) + ", "
		lcSql = lcSql + "idHostBaja = " + IIF(ISNULL(cur_provincias.idHostBaja),"NULL", "'" + ALLTRIM(cur_provincias.idHostBaja) + "'") + " "
		lcSql = lcSql + "WHERE idProvin = " + ALLTRIM(STR(cur_provincias.idProvin))

		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			RETURN .F.
		ENDIF
	ENDIF
	
	loResult.Close_Query()
	
	SELECT cur_provincias
	lnCant = lnCant + 1
	loProg.update((lnCant * 100) / RECCOUNT(), "Actualizando Provincias...")
	SELECT cur_provincias
	SKIP
ENDDO

loProv.Close_Query()
loProg.Complete()

***********************************************************************************************************
* Actualizo localidades
***********************************************************************************************************
loProg.Show()
Thisform.Contenido.txtDetalles.Value = Thisform.Contenido.txtDetalles.Value + CHR(13) + "Actualizando Localidades..."

lcSql = "SELECT * FROM localidad"
loLoc.ActiveConnection = loConn.ActiveConnection
loLoc.Cursor_Name = "cur_loc"
loLoc.OpenQuery(lcSql)
lnCant = 0

SELECT cur_loc
DO WHILE !EOF()
	lcSql = "SELECT COUNT(*) AS CantReg FROM localidad WHERE idLocalid = " + ALLTRIM(STR(cur_loc.idLocalid))
	loResult.ActiveConnection = goConn.ActiveConnection
	loResult.Cursor_Name = "cur_tmp"
	loResult.OpenQuery(lcSql)
	
	IF IIF(INT(VAL(getConfig("SQLSRV"))) = 1, cur_tmp.CantReg, VAL(cur_tmp.CantReg)) = 0 THEN
		lcSql = "INSERT INTO localidad ("
		lcSql = lcSql + "	idLocalid, "
		lcSql = lcSql + "	idProvin, "
		lcSql = lcSql + "	idPais, "
		lcSql = lcSql + "	codPostal, "						
		lcSql = lcSql + "	descripcio, "
		lcSql = lcSql + "	usuAlta, "
		lcSql = lcSql + "	fecAlta, "
		lcSql = lcSql + "	idHostAlta, "
		lcSql = lcSql + "	usuModi, "
		lcSql = lcSql + "	fecModi, "
		lcSql = lcSql + "	idHostModi, "
		lcSql = lcSql + "	usuBaja, "
		lcSql = lcSql + "	fecBaja, "
		lcSql = lcSql + "	idHostBaja) VALUES ( "
		lcSql = lcSql + ALLTRIM(STR(cur_loc.idLocalid)) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_loc.idProvin)) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_loc.idPais)) + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_loc.codPostal) + "', "						
		lcSql = lcSql + "'" + ALLTRIM(STRTRAN(cur_loc.descripcio,"'","''")) + "', "
		lcSql = lcSql + "'" + ALLTRIM(cur_loc.usuAlta) + "', "
		lcSql = lcSql + loDT.toMySql(cur_loc.fecAlta) + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_loc.idHostAlta) + "', "
		lcSql = lcSql + IIF(ISNULL(cur_loc.usuModi),"NULL", "'" + ALLTRIM(cur_loc.usuModi) + "'") + ", "
		lcSql = lcSql + IIF(ISNULL(cur_loc.fecModi),"NULL", loDT.toMySql(cur_loc.fecModi)) + ", "
		lcSql = lcSql + IIF(ISNULL(cur_loc.idHostModi),"NULL", "'" + ALLTRIM(cur_loc.idHostModi) + "'") + ", "
		lcSql = lcSql + IIF(ISNULL(cur_loc.usuBaja),"NULL", "'" + ALLTRIM(cur_loc.usuBaja) + "'") + ", "
		lcSql = lcSql + IIF(ISNULL(cur_loc.fecBaja),"NULL", loDT.toMySql(cur_loc.fecBaja)) + ", "
		lcSql = lcSql + IIF(ISNULL(cur_loc.idHostBaja),"NULL", "'" + ALLTRIM(cur_loc.idHostBaja) + "'") + ")"
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
	
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			RETURN .F.
		ENDIF
	ELSE
		lcSql = "UPDATE localidad SET idProvin = " + ALLTRIM(STR(cur_loc.idProvin)) + ", "
		lcSql = lcSql + "idPais = " + ALLTRIM(STR(cur_loc.idPais)) + ", "
		lcSql = lcSql + "codPostal = '" + ALLTRIM(cur_loc.codPostal) + "', "
		lcSql = lcSql + "descripcio = '" + ALLTRIM(STRTRAN(cur_loc.descripcio,"'","''")) + "', "
		lcSql = lcSql + "usuModi = " + IIF(ISNULL(cur_loc.usuModi),"NULL", "'" + ALLTRIM(cur_loc.usuModi) + "'")+ ", "
		lcSql = lcSql + "fecModi = " + IIF(ISNULL(cur_loc.fecModi),"NULL", loDT.toMySql(cur_loc.fecModi)) + ", "
		lcSql = lcSql + "idHostModi = " + IIF(ISNULL(cur_loc.idHostModi),"NULL", "'" + ALLTRIM(cur_loc.idHostModi) + "'")+ ", "
		lcSql = lcSql + "usuBaja = " + IIF(ISNULL(cur_loc.usuBaja),"NULL", "'" + ALLTRIM(cur_loc.usuBaja) + "'")+ ", "
		lcSql = lcSql + "fecBaja = " + IIF(ISNULL(cur_loc.fecBaja),"NULL", loDT.toMySql(cur_loc.fecBaja)) + ", "
		lcSql = lcSql + "idHostBaja = " + IIF(ISNULL(cur_loc.idHostBaja),"NULL", "'" + ALLTRIM(cur_loc.idHostBaja) + "'") + " "
		lcSql = lcSql + "WHERE idLocalid = " + ALLTRIM(STR(cur_loc.idLocalid))

		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			RETURN .F.
		ENDIF
	ENDIF
	
	loResult.Close_Query()
	
	SELECT cur_loc
	lnCant = lnCant + 1
	loProg.update((lnCant * 100) / RECCOUNT(), "Actualizando Localidades...")
	SELECT cur_loc
	SKIP
ENDDO

loLoc.Close_Query()
loProg.Complete()


***********************************************************************************************************
* Actualizo Usuarios
***********************************************************************************************************
loProg.Show()
Thisform.Contenido.txtDetalles.Value = Thisform.Contenido.txtDetalles.Value + CHR(13) + "Actualizando Usuarios..."

lcSql = "SELECT * FROM usuarios"
loUsuarios.ActiveConnection = loConn.ActiveConnection
loUsuarios.Cursor_Name = "cur_usuarios"
loUsuarios.OpenQuery(lcSql)
lnCant = 0

SELECT cur_usuarios
DO WHILE !EOF()
	lcSql = "SELECT COUNT(*) AS CantReg FROM usuarios WHERE idUsuario = " + ALLTRIM(STR(cur_usuarios.idUsuario))
	loResult.ActiveConnection = goConn.ActiveConnection
	loResult.Cursor_Name = "cur_tmp"
	loResult.OpenQuery(lcSql)
	
	IF IIF(INT(VAL(getConfig("SQLSRV"))) = 1, cur_tmp.CantReg, VAL(cur_tmp.CantReg)) = 0 THEN
		lcSql = "INSERT INTO usuarios ("
		lcSql = lcSql + "	idUsuario, "
		lcSql = lcSql + "	codUsu, "
		lcSql = lcSql + "	apelNom, "
		lcSql = lcSql + "	password, "
		lcSql = lcSql + "	habilitado, "
		lcSql = lcSql + "	usuAlta, "
		lcSql = lcSql + "	fecAlta, "
		lcSql = lcSql + "	idHostAlta, "
		lcSql = lcSql + "	usuModi, "
		lcSql = lcSql + "	fecModi, "
		lcSql = lcSql + "	idHostModi, "
		lcSql = lcSql + "	usuBaja, "
		lcSql = lcSql + "	fecBaja, "
		lcSql = lcSql + "	idHostBaja) VALUES ( "
		lcSql = lcSql + ALLTRIM(STR(cur_usuarios.idUsuario)) + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_usuarios.codUsu) + "', "
		lcSql = lcSql + "'" + ALLTRIM(cur_usuarios.apelNom) + "', "
		lcSql = lcSql + "'" + ALLTRIM(cur_usuarios.password) + "', "
		lcSql = lcSql + ALLTRIM(IIF(cur_usuarios.habilitado, "1", "0")) + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_usuarios.usuAlta) + "', "
		lcSql = lcSql + loDT.toMySql(cur_usuarios.fecAlta) + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_usuarios.idHostAlta) + "', "
		lcSql = lcSql + IIF(ISNULL(cur_usuarios.usuModi),"NULL", "'" + ALLTRIM(cur_usuarios.usuModi) + "'") + ", "
		lcSql = lcSql + IIF(ISNULL(cur_usuarios.fecModi),"NULL", loDT.toMySql(cur_usuarios.fecModi)) + ", "
		lcSql = lcSql + IIF(ISNULL(cur_usuarios.idHostModi),"NULL", "'" + ALLTRIM(cur_usuarios.idHostModi) + "'") + ", "
		lcSql = lcSql + IIF(ISNULL(cur_usuarios.usuBaja),"NULL", "'" + ALLTRIM(cur_usuarios.usuBaja) + "'") + ", "
		lcSql = lcSql + IIF(ISNULL(cur_usuarios.fecBaja),"NULL", loDT.toMySql(cur_usuarios.fecBaja)) + ", "
		lcSql = lcSql + IIF(ISNULL(cur_usuarios.idHostBaja),"NULL", "'" + ALLTRIM(cur_usuarios.idHostBaja) + "'") + ")"
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
	
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			RETURN .F.
		ENDIF
	ELSE
		lcSql = "UPDATE usuarios SET codUsu = '" + ALLTRIM(cur_usuarios.codUsu) + "', "
		lcSql = lcSql + "apelNom = '" + ALLTRIM(cur_usuarios.apelNom) + "', "
		lcSql = lcSql + "password = '" + ALLTRIM(cur_usuarios.password) + "', "
		lcSql = lcSql + "habilitado = " + ALLTRIM(IIF(cur_usuarios.habilitado, "1", "0")) + ", "
		lcSql = lcSql + "usuModi = " + IIF(ISNULL(cur_usuarios.usuModi),"NULL", "'" + ALLTRIM(cur_usuarios.usuModi) + "'")+ ", "
		lcSql = lcSql + "fecModi = " + IIF(ISNULL(cur_usuarios.fecModi),"NULL", loDT.toMySql(cur_usuarios.fecModi)) + ", "
		lcSql = lcSql + "idHostModi = " + IIF(ISNULL(cur_usuarios.idHostModi),"NULL", "'" + ALLTRIM(cur_usuarios.idHostModi) + "'")+ ", "
		lcSql = lcSql + "usuBaja = " + IIF(ISNULL(cur_usuarios.usuBaja),"NULL", "'" + ALLTRIM(cur_usuarios.usuBaja) + "'")+ ", "
		lcSql = lcSql + "fecBaja = " + IIF(ISNULL(cur_usuarios.fecBaja),"NULL", loDT.toMySql(cur_usuarios.fecBaja)) + ", "
		lcSql = lcSql + "idHostBaja = " + IIF(ISNULL(cur_usuarios.idHostBaja),"NULL", "'" + ALLTRIM(cur_usuarios.idHostBaja) + "'") + " "
		lcSql = lcSql + "WHERE idUsuario = " + ALLTRIM(STR(cur_usuarios.idUsuario))

		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			RETURN .F.
		ENDIF
	ENDIF
	
	loResult.Close_Query()
	
	SELECT cur_usuarios
	lnCant = lnCant + 1
	loProg.update((lnCant * 100) / RECCOUNT(), "Actualizando Usuarios...")
	SELECT cur_usuarios
	SKIP
ENDDO

loUsuarios.Close_Query()
loProg.Complete()


***********************************************************************************************************
* Actualizo condpagos
***********************************************************************************************************
loProg.Show()
Thisform.Contenido.txtDetalles.Value = Thisform.Contenido.txtDetalles.Value + CHR(13) + "Actualizando Condiciones de Pago..."

lcSql = "SELECT * FROM condpagos"
loCondPagos.ActiveConnection = loConn.ActiveConnection
loCondPagos.Cursor_Name = "cur_condpagos"
loCondPagos.OpenQuery(lcSql)
lnCant = 0

SELECT cur_condpagos
DO WHILE !EOF()
	lcSql = "SELECT COUNT(*) AS CantReg FROM condpagos WHERE idCondPago = " + ALLTRIM(STR(cur_condpagos.idCondPago))
	loResult.ActiveConnection = goConn.ActiveConnection
	loResult.Cursor_Name = "cur_tmp"
	loResult.OpenQuery(lcSql)
	
	IF IIF(INT(VAL(getConfig("SQLSRV"))) = 1, cur_tmp.CantReg, VAL(cur_tmp.CantReg)) = 0 THEN
		lcSql = "INSERT INTO condpagos ("
		lcSql = lcSql + "	idcondpago, "
		lcSql = lcSql + "	descripcio, "
		lcSql = lcSql + "	cntdias, "						
		lcSql = lcSql + "	usuAlta, "
		lcSql = lcSql + "	fecAlta, "
		lcSql = lcSql + "	idHostAlta, "
		lcSql = lcSql + "	usuModi, "
		lcSql = lcSql + "	fecModi, "
		lcSql = lcSql + "	idHostModi, "
		lcSql = lcSql + "	usuBaja, "
		lcSql = lcSql + "	fecBaja, "
		lcSql = lcSql + "	idHostBaja) VALUES ( " 
		lcSql = lcSql + ALLTRIM(STR(cur_condpagos.idcondpago)) + ", "					
		lcSql = lcSql + "'" + ALLTRIM(cur_condpagos.descripcio) + "', "
		lcSql = lcSql + ALLTRIM(STR(cur_condpagos.cntdias)) + ", "	
		lcSql = lcSql + "'" + ALLTRIM(cur_condpagos.usuAlta) + "', "
		lcSql = lcSql + loDT.toMySql(cur_condpagos.fecAlta) + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_condpagos.idHostAlta) + "', "
		lcSql = lcSql + IIF(ISNULL(cur_condpagos.usuModi),"NULL", "'" + ALLTRIM(cur_condpagos.usuModi) + "'") + ", "
		lcSql = lcSql + IIF(ISNULL(cur_condpagos.fecModi),"NULL", loDT.toMySql(cur_condpagos.fecModi)) + ", "
		lcSql = lcSql + IIF(ISNULL(cur_condpagos.idHostModi),"NULL", "'" + ALLTRIM(cur_condpagos.idHostModi) + "'") + ", "
		lcSql = lcSql + IIF(ISNULL(cur_condpagos.usuBaja),"NULL", "'" + ALLTRIM(cur_condpagos.usuBaja) + "'") + ", "
		lcSql = lcSql + IIF(ISNULL(cur_condpagos.fecBaja),"NULL", loDT.toMySql(cur_condpagos.fecBaja)) + ", "
		lcSql = lcSql + IIF(ISNULL(cur_condpagos.idHostBaja),"NULL", "'" + ALLTRIM(cur_condpagos.idHostBaja) + "'") + ")"
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
	
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			RETURN .F.
		ENDIF
	ELSE
		lcSql = "UPDATE condpagos SET descripcio = '" + ALLTRIM(cur_condpagos.descripcio) + "', "
		lcSql = lcSql + "cntDias = " + ALLTRIM(STR(cur_condpagos.cntDias)) + ", "
		lcSql = lcSql + "usuModi = " + IIF(ISNULL(cur_condpagos.usuModi),"NULL", "'" + ALLTRIM(cur_condpagos.usuModi) + "'")+ ", "
		lcSql = lcSql + "fecModi = " + IIF(ISNULL(cur_condpagos.fecModi),"NULL", loDT.toMySql(cur_condpagos.fecModi)) + ", "
		lcSql = lcSql + "idHostModi = " + IIF(ISNULL(cur_condpagos.idHostModi),"NULL", "'" + ALLTRIM(cur_condpagos.idHostModi) + "'")+ ", "
		lcSql = lcSql + "usuBaja = " + IIF(ISNULL(cur_condpagos.usuBaja),"NULL", "'" + ALLTRIM(cur_condpagos.usuBaja) + "'")+ ", "
		lcSql = lcSql + "fecBaja = " + IIF(ISNULL(cur_condpagos.fecBaja),"NULL", loDT.toMySql(cur_condpagos.fecBaja)) + ", "
		lcSql = lcSql + "idHostBaja = " + IIF(ISNULL(cur_condpagos.idHostBaja),"NULL", "'" + ALLTRIM(cur_condpagos.idHostBaja) + "'") + " "
		lcSql = lcSql + "WHERE idCondPago = " + ALLTRIM(STR(cur_condpagos.idCondPago))

		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			RETURN .F.
		ENDIF
	ENDIF
	
	loResult.Close_Query()
	
	SELECT cur_condpagos
	lnCant = lnCant + 1
	loProg.update((lnCant * 100) / RECCOUNT(), "Actualizando Condiciones de Pago...")
	SELECT cur_condpagos
	SKIP
ENDDO

loCondPagos.Close_Query()
loProg.Complete()


***********************************************************************************************************
* Actualizo sitiva
***********************************************************************************************************
loProg.Show()
Thisform.Contenido.txtDetalles.Value = Thisform.Contenido.txtDetalles.Value + CHR(13) + "Actualizando Situaciones de IVA..."

lcSql = "SELECT * FROM sitiva"
loSitIva.ActiveConnection = loConn.ActiveConnection
loSitIva.Cursor_Name = "cur_sitiva"
loSitIva.OpenQuery(lcSql)
lnCant = 0

SELECT cur_sitiva
DO WHILE !EOF()
	lcSql = "SELECT COUNT(*) AS CantReg FROM sitiva WHERE idSitIva = " + ALLTRIM(STR(cur_sitiva.idSitIva))
	loResult.ActiveConnection = goConn.ActiveConnection
	loResult.Cursor_Name = "cur_tmp"
	loResult.OpenQuery(lcSql)
	
	IF IIF(INT(VAL(getConfig("SQLSRV"))) = 1, cur_tmp.CantReg, VAL(cur_tmp.CantReg)) = 0 THEN
		lcSql = "INSERT INTO sitiva ("
		lcSql = lcSql + "	idsitiva, "
		lcSql = lcSql + "	descripcio, "
		lcSql = lcSql + "	codfiscal, "						
		lcSql = lcSql + "	usuAlta, "
		lcSql = lcSql + "	fecAlta, "
		lcSql = lcSql + "	idHostAlta, "
		lcSql = lcSql + "	usuModi, "
		lcSql = lcSql + "	fecModi, "
		lcSql = lcSql + "	idHostModi, "
		lcSql = lcSql + "	usuBaja, "
		lcSql = lcSql + "	fecBaja, "
		lcSql = lcSql + "	idHostBaja) VALUES ( " 
		lcSql = lcSql + ALLTRIM(STR(cur_sitiva.idsitiva)) + ", "					
		lcSql = lcSql + "'" + ALLTRIM(cur_sitiva.descripcio) + "', "
		lcSql = lcSql + ALLTRIM(STR(cur_sitiva.codfiscal)) + ", "	
		lcSql = lcSql + "'" + ALLTRIM(cur_sitiva.usuAlta) + "', "
		lcSql = lcSql + loDT.toMySql(cur_sitiva.fecAlta) + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_sitiva.idHostAlta) + "', "
		lcSql = lcSql + IIF(ISNULL(cur_sitiva.usuModi),"NULL", "'" + ALLTRIM(cur_sitiva.usuModi) + "'") + ", "
		lcSql = lcSql + IIF(ISNULL(cur_sitiva.fecModi),"NULL", loDT.toMySql(cur_sitiva.fecModi)) + ", "
		lcSql = lcSql + IIF(ISNULL(cur_sitiva.idHostModi),"NULL", "'" + ALLTRIM(cur_sitiva.idHostModi) + "'") + ", "
		lcSql = lcSql + IIF(ISNULL(cur_sitiva.usuBaja),"NULL", "'" + ALLTRIM(cur_sitiva.usuBaja) + "'") + ", "
		lcSql = lcSql + IIF(ISNULL(cur_sitiva.fecBaja),"NULL", loDT.toMySql(cur_sitiva.fecBaja)) + ", "
		lcSql = lcSql + IIF(ISNULL(cur_sitiva.idHostBaja),"NULL", "'" + ALLTRIM(cur_sitiva.idHostBaja) + "'") + ")"
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
	
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			RETURN .F.
		ENDIF
	ELSE
		lcSql = "UPDATE sitiva SET descripcio = '" + ALLTRIM(cur_sitiva.descripcio) + "', "
		lcSql = lcSql + "codFiscal = " + ALLTRIM(STR(cur_sitiva.codFiscal)) + ", "
		lcSql = lcSql + "usuModi = " + IIF(ISNULL(cur_sitiva.usuModi),"NULL", "'" + ALLTRIM(cur_sitiva.usuModi) + "'")+ ", "
		lcSql = lcSql + "fecModi = " + IIF(ISNULL(cur_sitiva.fecModi),"NULL", loDT.toMySql(cur_sitiva.fecModi)) + ", "
		lcSql = lcSql + "idHostModi = " + IIF(ISNULL(cur_sitiva.idHostModi),"NULL", "'" + ALLTRIM(cur_sitiva.idHostModi) + "'")+ ", "
		lcSql = lcSql + "usuBaja = " + IIF(ISNULL(cur_sitiva.usuBaja),"NULL", "'" + ALLTRIM(cur_sitiva.usuBaja) + "'")+ ", "
		lcSql = lcSql + "fecBaja = " + IIF(ISNULL(cur_sitiva.fecBaja),"NULL", loDT.toMySql(cur_sitiva.fecBaja)) + ", "
		lcSql = lcSql + "idHostBaja = " + IIF(ISNULL(cur_sitiva.idHostBaja),"NULL", "'" + ALLTRIM(cur_sitiva.idHostBaja) + "'") + " "
		lcSql = lcSql + "WHERE idsitiva = " + ALLTRIM(STR(cur_sitiva.idsitiva))

		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			RETURN .F.
		ENDIF
	ENDIF
	
	loResult.Close_Query()
	
	SELECT cur_sitiva
	lnCant = lnCant + 1
	loProg.update((lnCant * 100) / RECCOUNT(), "Actualizando Situaciones de IVA...")
	SELECT cur_sitiva
	SKIP
ENDDO

loSitIva.Close_Query()
loProg.Complete()

***********************************************************************************************************
* Actualizo Bancos
***********************************************************************************************************
loProg.Show()
Thisform.Contenido.txtDetalles.Value = Thisform.Contenido.txtDetalles.Value + CHR(13) + "Actualizando Bancos..."

lcSql = "SELECT * FROM bancos"
loBancos.ActiveConnection = loConn.ActiveConnection
loBancos.Cursor_Name = "cur_bancos"
loBancos.OpenQuery(lcSql)
lnCant = 0

SELECT cur_bancos
DO WHILE !EOF()
	lcSql = "SELECT COUNT(*) AS CantReg FROM bancos WHERE idBanco = " + ALLTRIM(STR(cur_bancos.idBanco))
	loResult.ActiveConnection = goConn.ActiveConnection
	loResult.Cursor_Name = "cur_tmp"
	loResult.OpenQuery(lcSql)
	
	IF IIF(INT(VAL(getConfig("SQLSRV"))) = 1, cur_tmp.CantReg, VAL(cur_tmp.CantReg)) = 0 THEN
		lcSql = "INSERT INTO bancos ("
		lcSql = lcSql + "	idBanco, "
		lcSql = lcSql + "	codBco, "
		lcSql = lcSql + "	descripcio, "
		lcSql = lcSql + "	nroCuit, "
		lcSql = lcSql + "	usuAlta, "
		lcSql = lcSql + "	fecAlta, "
		lcSql = lcSql + "	idHostAlta, "
		lcSql = lcSql + "	usuModi, "
		lcSql = lcSql + "	fecModi, "
		lcSql = lcSql + "	idHostModi, "
		lcSql = lcSql + "	usuBaja, "
		lcSql = lcSql + "	fecBaja, "
		lcSql = lcSql + "	idHostBaja) VALUES ( "
		lcSql = lcSql + ALLTRIM(STR(cur_bancos.idBanco)) + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_bancos.codBco) + "', "
		lcSql = lcSql + "'" + ALLTRIM(cur_bancos.descripcio) + "', "
		lcSql = lcSql + "'" + ALLTRIM(cur_bancos.nroCuit) + "', "
		lcSql = lcSql + "'" + ALLTRIM(cur_bancos.usuAlta) + "', "
		lcSql = lcSql + loDT.toMySql(cur_bancos.fecAlta) + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_bancos.idHostAlta) + "', "
		lcSql = lcSql + IIF(ISNULL(cur_bancos.usuModi),"NULL", "'" + ALLTRIM(cur_bancos.usuModi) + "'") + ", "
		lcSql = lcSql + IIF(ISNULL(cur_bancos.fecModi),"NULL", loDT.toMySql(cur_bancos.fecModi)) + ", "
		lcSql = lcSql + IIF(ISNULL(cur_bancos.idHostModi),"NULL", "'" + ALLTRIM(cur_bancos.idHostModi) + "'") + ", "
		lcSql = lcSql + IIF(ISNULL(cur_bancos.usuBaja),"NULL", "'" + ALLTRIM(cur_bancos.usuBaja) + "'") + ", "
		lcSql = lcSql + IIF(ISNULL(cur_bancos.fecBaja),"NULL", loDT.toMySql(cur_bancos.fecBaja)) + ", "
		lcSql = lcSql + IIF(ISNULL(cur_bancos.idHostBaja),"NULL", "'" + ALLTRIM(cur_bancos.idHostBaja) + "'") + ")"
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
	
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			RETURN .F.
		ENDIF
	ELSE
		lcSql = "UPDATE bancos SET codBco = '" + ALLTRIM(cur_bancos.codBco) + "', "
		lcSql = lcSql + "descripcio = '" + ALLTRIM(cur_bancos.descripcio) + "', "
		lcSql = lcSql + "nroCuit = '" + ALLTRIM(cur_bancos.nroCuit) + "', "
		lcSql = lcSql + "usuModi = " + IIF(ISNULL(cur_bancos.usuModi),"NULL", "'" + ALLTRIM(cur_bancos.usuModi) + "'")+ ", "
		lcSql = lcSql + "fecModi = " + IIF(ISNULL(cur_bancos.fecModi),"NULL", loDT.toMySql(cur_bancos.fecModi)) + ", "
		lcSql = lcSql + "idHostModi = " + IIF(ISNULL(cur_bancos.idHostModi),"NULL", "'" + ALLTRIM(cur_bancos.idHostModi) + "'")+ ", "
		lcSql = lcSql + "usuBaja = " + IIF(ISNULL(cur_bancos.usuBaja),"NULL", "'" + ALLTRIM(cur_bancos.usuBaja) + "'")+ ", "
		lcSql = lcSql + "fecBaja = " + IIF(ISNULL(cur_bancos.fecBaja),"NULL", loDT.toMySql(cur_bancos.fecBaja)) + ", "
		lcSql = lcSql + "idHostBaja = " + IIF(ISNULL(cur_bancos.idHostBaja),"NULL", "'" + ALLTRIM(cur_bancos.idHostBaja) + "'") + " "
		lcSql = lcSql + "WHERE idBanco = " + ALLTRIM(STR(cur_bancos.idBanco))

		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			RETURN .F.
		ENDIF
	ENDIF
	
	loResult.Close_Query()
	
	SELECT cur_bancos
	lnCant = lnCant + 1
	loProg.update((lnCant * 100) / RECCOUNT(), "Actualizando Bancos...")
	SELECT cur_bancos
	SKIP
ENDDO

loBancos.Close_Query()
loProg.Complete()


***********************************************************************************************************
* Actualizo Planctas
***********************************************************************************************************
loProg.Show()
Thisform.Contenido.txtDetalles.Value = Thisform.Contenido.txtDetalles.Value + CHR(13) + "Actualizando Plan de Cuentas..."

lcSql = "SELECT * FROM planctas"
loPlanctas.ActiveConnection = loConn.ActiveConnection
loPlanctas.Cursor_Name = "cur_planctas"
loPlanctas.OpenQuery(lcSql)
lnCant = 0

SELECT cur_planctas
DO WHILE !EOF()
	lcSql = "SELECT COUNT(*) AS CantReg FROM planctas WHERE idPlancta = " + ALLTRIM(STR(cur_planctas.idPlancta))
	loResult.ActiveConnection = goConn.ActiveConnection
	loResult.Cursor_Name = "cur_tmp"
	loResult.OpenQuery(lcSql)
	
	IF IIF(INT(VAL(getConfig("SQLSRV"))) = 1, cur_tmp.CantReg, VAL(cur_tmp.CantReg)) = 0 THEN
		lcSql = "INSERT INTO planctas ("
		lcSql = lcSql + "	idPlanCta, "
		lcSql = lcSql + "	codPlanCta, "
		lcSql = lcSql + "	descripcio, "
		lcSql = lcSql + "	esImput, "
		lcSql = lcSql + "	esCtaBco, "
		lcSql = lcSql + "	codAbr, "
		lcSql = lcSql + "	esChqT, "
		lcSql = lcSql + "	usuAlta, "
		lcSql = lcSql + "	fecAlta, "
		lcSql = lcSql + "	idHostAlta, "
		lcSql = lcSql + "	usuModi, "
		lcSql = lcSql + "	fecModi, "
		lcSql = lcSql + "	idHostModi, "
		lcSql = lcSql + "	usuBaja, "
		lcSql = lcSql + "	fecBaja, "
		lcSql = lcSql + "	idHostBaja) VALUES ( "
		lcSql = lcSql + ALLTRIM(STR(cur_planctas.idPlanCta)) + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_planctas.codPlanCta) + "', "
		lcSql = lcSql + "'" + ALLTRIM(cur_planctas.descripcio) + "', "
		lcSql = lcSql + ALLTRIM(IIF(cur_planctas.esImput, "1", "0")) + ", "
		lcSql = lcSql + ALLTRIM(IIF(cur_planctas.esCtaBco, "1", "0")) + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_planctas.codAbr) + "', "
		lcSql = lcSql + ALLTRIM(IIF(cur_planctas.esChqT, "1", "0")) + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_planctas.usuAlta) + "', "
		lcSql = lcSql + loDT.toMySql(cur_planctas.fecAlta) + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_planctas.idHostAlta) + "', "
		lcSql = lcSql + IIF(ISNULL(cur_planctas.usuModi),"NULL", "'" + ALLTRIM(cur_planctas.usuModi) + "'") + ", "
		lcSql = lcSql + IIF(ISNULL(cur_planctas.fecModi),"NULL", loDT.toMySql(cur_planctas.fecModi)) + ", "
		lcSql = lcSql + IIF(ISNULL(cur_planctas.idHostModi),"NULL", "'" + ALLTRIM(cur_planctas.idHostModi) + "'") + ", "
		lcSql = lcSql + IIF(ISNULL(cur_planctas.usuBaja),"NULL", "'" + ALLTRIM(cur_planctas.usuBaja) + "'") + ", "
		lcSql = lcSql + IIF(ISNULL(cur_planctas.fecBaja),"NULL", loDT.toMySql(cur_planctas.fecBaja)) + ", "
		lcSql = lcSql + IIF(ISNULL(cur_planctas.idHostBaja),"NULL", "'" + ALLTRIM(cur_planctas.idHostBaja) + "'") + ")"
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
	
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			RETURN .F.
		ENDIF
	ELSE
		lcSql = "UPDATE planctas SET codPlanCta = '" + ALLTRIM(cur_planctas.codPlanCta) + "', "
		lcSql = lcSql + "descripcio = '" + ALLTRIM(cur_planctas.descripcio) + "', "
		lcSql = lcSql + "esImput = " + ALLTRIM(IIF(cur_planctas.esImput, "1", "0")) + ", "
		lcSql = lcSql + "esCtaBco = " + ALLTRIM(IIF(cur_planctas.esCtaBco, "1", "0")) + ", "
		lcSql = lcSql + "codAbr = '" + ALLTRIM(cur_planctas.codAbr) + "', "
		lcSql = lcSql + "esChqT = " + ALLTRIM(IIF(cur_planctas.esChqT, "1", "0")) + ", "
		lcSql = lcSql + "usuModi = " + IIF(ISNULL(cur_planctas.usuModi),"NULL", "'" + ALLTRIM(cur_planctas.usuModi) + "'")+ ", "
		lcSql = lcSql + "fecModi = " + IIF(ISNULL(cur_planctas.fecModi),"NULL", loDT.toMySql(cur_planctas.fecModi)) + ", "
		lcSql = lcSql + "idHostModi = " + IIF(ISNULL(cur_planctas.idHostModi),"NULL", "'" + ALLTRIM(cur_planctas.idHostModi) + "'")+ ", "
		lcSql = lcSql + "usuBaja = " + IIF(ISNULL(cur_planctas.usuBaja),"NULL", "'" + ALLTRIM(cur_planctas.usuBaja) + "'")+ ", "
		lcSql = lcSql + "fecBaja = " + IIF(ISNULL(cur_planctas.fecBaja),"NULL", loDT.toMySql(cur_planctas.fecBaja)) + ", "
		lcSql = lcSql + "idHostBaja = " + IIF(ISNULL(cur_planctas.idHostBaja),"NULL", "'" + ALLTRIM(cur_planctas.idHostBaja) + "'") + " "
		lcSql = lcSql + "WHERE idPlanCta = " + ALLTRIM(STR(cur_planctas.idPlanCta))

		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			RETURN .F.
		ENDIF
	ENDIF
	
	loResult.Close_Query()
	
	SELECT cur_planctas
	lnCant = lnCant + 1
	loProg.update((lnCant * 100) / RECCOUNT(), "Actualizando Plan de Cuentas...")
	SELECT cur_planctas
	SKIP
ENDDO

loPlanctas.Close_Query()
loProg.Complete()


***********************************************************************************************************
* Actualizo CtaCja
***********************************************************************************************************
loProg.Show()
Thisform.Contenido.txtDetalles.Value = Thisform.Contenido.txtDetalles.Value + CHR(13) + "Actualizando Cuentas de Caja..."

lcSql = "SELECT * FROM ctacja"
loCtaCja.ActiveConnection = loConn.ActiveConnection
loCtaCja.Cursor_Name = "cur_ctacja"
loCtaCja.OpenQuery(lcSql)
lnCant = 0

SELECT cur_ctacja
DO WHILE !EOF()
	lcSql = "SELECT COUNT(*) AS CantReg FROM ctacja WHERE idCtaCja = " + ALLTRIM(STR(cur_ctacja.idCtaCja))
	loResult.ActiveConnection = goConn.ActiveConnection
	loResult.Cursor_Name = "cur_tmp"
	loResult.OpenQuery(lcSql)

	IF IIF(INT(VAL(getConfig("SQLSRV"))) = 1, cur_tmp.CantReg, VAL(cur_tmp.CantReg)) = 0 THEN
		lcSql = "INSERT INTO ctacja ("
		lcSql = lcSql + "	idCtaCja, "
		lcSql = lcSql + "	codCtaCj, "
		lcSql = lcSql + "	descripcio, "
		lcSql = lcSql + "	esCheque, "
		lcSql = lcSql + "	esVale, "
		lcSql = lcSql + "	idPlancta, "
		lcSql = lcSql + "	esRetIB, "
		lcSql = lcSql + "	esRetIVA, "
		lcSql = lcSql + "	esRetSUSS, "
		lcSql = lcSql + "	esGcias, "
		lcSql = lcSql + "	usuAlta, "
		lcSql = lcSql + "	fecAlta, "
		lcSql = lcSql + "	idHostAlta, "
		lcSql = lcSql + "	usuModi, "
		lcSql = lcSql + "	fecModi, "
		lcSql = lcSql + "	idHostModi, "
		lcSql = lcSql + "	usuBaja, "
		lcSql = lcSql + "	fecBaja, "
		lcSql = lcSql + "	idHostBaja) VALUES ( "
		lcSql = lcSql + ALLTRIM(STR(cur_ctacja.idCtaCja)) + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_ctacja.codCtaCj) + "', "
		lcSql = lcSql + "'" + ALLTRIM(cur_ctacja.descripcio) + "', "
		lcSql = lcSql + ALLTRIM(IIF(cur_ctacja.esCheque, "1", "0")) + ", "
		lcSql = lcSql + ALLTRIM(IIF(cur_ctacja.esVale, "1", "0")) + ", "
		lcSql = lcSql + ALLTRIM(IIF(ISNULL(cur_ctacja.idPlancta),"NULL",STR(cur_ctacja.idPlancta))) + ", "
		lcSql = lcSql + ALLTRIM(IIF(cur_ctacja.esRetIB, "1", "0")) + ", "
		lcSql = lcSql + ALLTRIM(IIF(cur_ctacja.esRetIVA, "1", "0")) + ", "
		lcSql = lcSql + ALLTRIM(IIF(cur_ctacja.esRetSUSS, "1", "0")) + ", "
		lcSql = lcSql + ALLTRIM(IIF(cur_ctacja.esGcias, "1", "0")) + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_ctacja.usuAlta) + "', "
		lcSql = lcSql + loDT.toMySql(cur_ctacja.fecAlta) + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_ctacja.idHostAlta) + "', "
		lcSql = lcSql + IIF(ISNULL(cur_ctacja.usuModi),"NULL", "'" + ALLTRIM(cur_ctacja.usuModi) + "'") + ", "
		lcSql = lcSql + IIF(ISNULL(cur_ctacja.fecModi),"NULL", loDT.toMySql(cur_ctacja.fecModi)) + ", "
		lcSql = lcSql + IIF(ISNULL(cur_ctacja.idHostModi),"NULL", "'" + ALLTRIM(cur_ctacja.idHostModi) + "'") + ", "
		lcSql = lcSql + IIF(ISNULL(cur_ctacja.usuBaja),"NULL", "'" + ALLTRIM(cur_ctacja.usuBaja) + "'") + ", "
		lcSql = lcSql + IIF(ISNULL(cur_ctacja.fecBaja),"NULL", loDT.toMySql(cur_ctacja.fecBaja)) + ", "
		lcSql = lcSql + IIF(ISNULL(cur_ctacja.idHostBaja),"NULL", "'" + ALLTRIM(cur_ctacja.idHostBaja) + "'") + ")"
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
	
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			RETURN .F.
		ENDIF
	ELSE
		lcSql = "UPDATE ctacja SET codCtaCj = '" + ALLTRIM(cur_ctacja.codCtaCj) + "', "
		lcSql = lcSql + "descripcio = '" + ALLTRIM(cur_ctacja.descripcio) + "', "
		lcSql = lcSql + "esCheque = " + ALLTRIM(IIF(cur_ctacja.esCheque, "1", "0")) + ", "
		lcSql = lcSql + "esVale = " + ALLTRIM(IIF(cur_ctacja.esVale, "1", "0")) + ", "
		lcSql = lcSql + "idPlancta = " + ALLTRIM(IIF(ISNULL(cur_ctacja.idPlancta),"NULL",STR(cur_ctacja.idPlancta))) + ", "
		lcSql = lcSql + "esRetIB = " + ALLTRIM(IIF(cur_ctacja.esRetIB, "1", "0")) + ", "
		lcSql = lcSql + "esRetIVA = " + ALLTRIM(IIF(cur_ctacja.esRetIVA, "1", "0")) + ", "
		lcSql = lcSql + "esRetSUSS = " + ALLTRIM(IIF(cur_ctacja.esRetSUSS, "1", "0")) + ", "
		lcSql = lcSql + "esGcias = " + ALLTRIM(IIF(cur_ctacja.esGcias, "1", "0")) + ", "
		lcSql = lcSql + "usuModi = " + IIF(ISNULL(cur_ctacja.usuModi),"NULL", "'" + ALLTRIM(cur_ctacja.usuModi) + "'")+ ", "
		lcSql = lcSql + "fecModi = " + IIF(ISNULL(cur_ctacja.fecModi),"NULL", loDT.toMySql(cur_ctacja.fecModi)) + ", "
		lcSql = lcSql + "idHostModi = " + IIF(ISNULL(cur_ctacja.idHostModi),"NULL", "'" + ALLTRIM(cur_ctacja.idHostModi) + "'")+ ", "
		lcSql = lcSql + "usuBaja = " + IIF(ISNULL(cur_ctacja.usuBaja),"NULL", "'" + ALLTRIM(cur_ctacja.usuBaja) + "'")+ ", "
		lcSql = lcSql + "fecBaja = " + IIF(ISNULL(cur_ctacja.fecBaja),"NULL", loDT.toMySql(cur_ctacja.fecBaja)) + ", "
		lcSql = lcSql + "idHostBaja = " + IIF(ISNULL(cur_ctacja.idHostBaja),"NULL", "'" + ALLTRIM(cur_ctacja.idHostBaja) + "'") + " "
		lcSql = lcSql + "WHERE idCtaCja = " + ALLTRIM(STR(cur_ctacja.idCtaCja))

		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			RETURN .F.
		ENDIF
	ENDIF
	
	loResult.Close_Query()
	
	SELECT cur_ctacja
	lnCant = lnCant + 1
	loProg.update((lnCant * 100) / RECCOUNT(), "Actualizando Cuentas de Caja...")
	SELECT cur_ctacja
	SKIP
ENDDO

loCtaCja.Close_Query()
loProg.Complete()


***********************************************************************************************************
* Actualizo Vendedores
***********************************************************************************************************
loProg.Show()
Thisform.Contenido.txtDetalles.Value = Thisform.Contenido.txtDetalles.Value + CHR(13) + "Actualizando Vendedores..."

lcSql = "SELECT * FROM vendedores"
loVend.ActiveConnection = loConn.ActiveConnection
loVend.Cursor_Name = "cur_vend"
loVend.OpenQuery(lcSql)
lnCant = 0

SELECT cur_vend
DO WHILE !EOF()
	lcSql = "SELECT COUNT(*) AS CantReg FROM vendedores WHERE idVendedor= " + ALLTRIM(STR(cur_vend.idVendedor))
	loResult.ActiveConnection = goConn.ActiveConnection
	loResult.Cursor_Name = "cur_tmp"
	loResult.OpenQuery(lcSql)
	
	IF IIF(INT(VAL(getConfig("SQLSRV"))) = 1, cur_tmp.CantReg, VAL(cur_tmp.CantReg)) = 0 THEN
		lcSql = "INSERT INTO vendedores ("
		lcSql = lcSql + "	idVendedor, "
		lcSql = lcSql + "	nombre, "
		lcSql = lcSql + "	direccion, "
		lcSql = lcSql + "	idLocalid, "						
		lcSql = lcSql + "	telefono, "
		lcSql = lcSql + "	celular, "
		lcSql = lcSql + "	email, "
		lcSql = lcSql + "	habilitado, "								
		lcSql = lcSql + "	usuAlta, "
		lcSql = lcSql + "	fecAlta, "
		lcSql = lcSql + "	idHostAlta, "
		lcSql = lcSql + "	usuModi, "
		lcSql = lcSql + "	fecModi, "
		lcSql = lcSql + "	idHostModi, "
		lcSql = lcSql + "	usuBaja, "
		lcSql = lcSql + "	fecBaja, "
		lcSql = lcSql + "	idHostBaja) VALUES ( "
		lcSql = lcSql + ALLTRIM(STR(cur_vend.idVendedor)) + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_vend.nombre) + "', "		
		lcSql = lcSql + "'" + ALLTRIM(cur_vend.direccion) + "', "
		lcSql = lcSql + ALLTRIM(STR(cur_vend.idLocalid)) + ", "			
		lcSql = lcSql + "'" + ALLTRIM(cur_vend.telefono) + "', "			
		lcSql = lcSql + "'" + ALLTRIM(cur_vend.celular) + "', "	
		lcSql = lcSql + "'" + ALLTRIM(cur_vend.email) + "', "						
		lcSql = lcSql + ALLTRIM(IIF(cur_vend.habilitado, "1", "0")) + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_vend.usuAlta) + "', "
		lcSql = lcSql + loDT.toMySql(cur_vend.fecAlta) + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_vend.idHostAlta) + "', "
		lcSql = lcSql + IIF(ISNULL(cur_vend.usuModi),"NULL", "'" + ALLTRIM(cur_vend.usuModi) + "'") + ", "
		lcSql = lcSql + IIF(ISNULL(cur_vend.fecModi),"NULL", loDT.toMySql(cur_vend.fecModi)) + ", "
		lcSql = lcSql + IIF(ISNULL(cur_vend.idHostModi),"NULL", "'" + ALLTRIM(cur_vend.idHostModi) + "'") + ", "
		lcSql = lcSql + IIF(ISNULL(cur_vend.usuBaja),"NULL", "'" + ALLTRIM(cur_vend.usuBaja) + "'") + ", "
		lcSql = lcSql + IIF(ISNULL(cur_vend.fecBaja),"NULL", loDT.toMySql(cur_vend.fecBaja)) + ", "
		lcSql = lcSql + IIF(ISNULL(cur_vend.idHostBaja),"NULL", "'" + ALLTRIM(cur_vend.idHostBaja) + "'") + ")"
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
	
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			RETURN .F.
		ENDIF
	ELSE
		lcSql = "UPDATE vendedores SET nombre = '" + ALLTRIM(cur_vend.nombre) + "', "
		lcSql = lcSql + "direccion = '" + ALLTRIM(cur_vend.direccion) + "', "
		lcSql = lcSql + "idLocalid = " + ALLTRIM(STR(cur_vend.idLocalid)) + ", "
		lcSql = lcSql + "telefono = '" + ALLTRIM(cur_vend.telefono) + "', "
		lcSql = lcSql + "celular = '" + ALLTRIM(cur_vend.celular) + "', "
		lcSql = lcSql + "email = '" + ALLTRIM(cur_vend.email) + "', "
		lcSql = lcSql + "habilitado = " + ALLTRIM(IIF(cur_vend.habilitado, "1", "0")) + ", "
		lcSql = lcSql + "usuModi = " + IIF(ISNULL(cur_vend.usuModi),"NULL", "'" + ALLTRIM(cur_vend.usuModi) + "'")+ ", "
		lcSql = lcSql + "fecModi = " + IIF(ISNULL(cur_vend.fecModi),"NULL", loDT.toMySql(cur_vend.fecModi)) + ", "
		lcSql = lcSql + "idHostModi = " + IIF(ISNULL(cur_vend.idHostModi),"NULL", "'" + ALLTRIM(cur_vend.idHostModi) + "'")+ ", "
		lcSql = lcSql + "usuBaja = " + IIF(ISNULL(cur_vend.usuBaja),"NULL", "'" + ALLTRIM(cur_vend.usuBaja) + "'")+ ", "
		lcSql = lcSql + "fecBaja = " + IIF(ISNULL(cur_vend.fecBaja),"NULL", loDT.toMySql(cur_vend.fecBaja)) + ", "
		lcSql = lcSql + "idHostBaja = " + IIF(ISNULL(cur_vend.idHostBaja),"NULL", "'" + ALLTRIM(cur_vend.idHostBaja) + "'") + " "
		lcSql = lcSql + "WHERE idVendedor = " + ALLTRIM(STR(cur_vend.idVendedor))

		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			RETURN .F.
		ENDIF
	ENDIF
	
	loResult.Close_Query()
	
	SELECT cur_vend
	lnCant = lnCant + 1
	loProg.update((lnCant * 100) / RECCOUNT(), "Actualizando Vendedores...")
	SELECT cur_vend
	SKIP
ENDDO

loVend.Close_Query()
loProg.Complete()


***********************************************************************************************************
* Actualizo Transportes
***********************************************************************************************************
loProg.Show()
Thisform.Contenido.txtDetalles.Value = Thisform.Contenido.txtDetalles.Value + CHR(13) + "Actualizando Transportes..."

lcSql = "SELECT * FROM transp"
loTransp.ActiveConnection = loConn.ActiveConnection
loTransp.Cursor_Name = "cur_transp"
loTransp.OpenQuery(lcSql)
lnCant = 0

SELECT cur_transp
DO WHILE !EOF()
	lcSql = "SELECT COUNT(*) AS CantReg FROM transp WHERE idTransp= " + ALLTRIM(STR(cur_transp.idTransp))
	loResult.ActiveConnection = goConn.ActiveConnection
	loResult.Cursor_Name = "cur_tmp"
	loResult.OpenQuery(lcSql)
	
	IF IIF(INT(VAL(getConfig("SQLSRV"))) = 1, cur_tmp.CantReg, VAL(cur_tmp.CantReg)) = 0 THEN
		lcSql = "INSERT INTO transp("
		lcSql = lcSql + "	idTransp, "
		lcSql = lcSql + "	CodTrans, "
		lcSql = lcSql + "	razsoc, "
		lcSql = lcSql + "	direccion, "
		lcSql = lcSql + "	idLocalid, "						
		lcSql = lcSql + "	telefono, "
		lcSql = lcSql + "	fax, "
		lcSql = lcSql + "	email, "							
		lcSql = lcSql + "	usuAlta, "
		lcSql = lcSql + "	fecAlta, "
		lcSql = lcSql + "	idHostAlta, "
		lcSql = lcSql + "	usuModi, "
		lcSql = lcSql + "	fecModi, "
		lcSql = lcSql + "	idHostModi, "
		lcSql = lcSql + "	usuBaja, "
		lcSql = lcSql + "	fecBaja, "
		lcSql = lcSql + "	idHostBaja) VALUES ( "
		lcSql = lcSql + ALLTRIM(STR(cur_transp.idTransp)) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_transp.CodTrans)) + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_transp.razsoc) + "', "		
		lcSql = lcSql + "'" + ALLTRIM(cur_transp.direccion) + "', "
		lcSql = lcSql + ALLTRIM(STR(cur_transp.idLocalid)) + ", "			
		lcSql = lcSql + "'" + ALLTRIM(cur_transp.telefono) + "', "			
		lcSql = lcSql + "'" + ALLTRIM(cur_transp.fax) + "', "	
		lcSql = lcSql + "'" + ALLTRIM(cur_transp.email) + "', "						
		lcSql = lcSql + "'" + ALLTRIM(cur_transp.usuAlta) + "', "
		lcSql = lcSql + loDT.toMySql(cur_transp.fecAlta) + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_transp.idHostAlta) + "', "
		lcSql = lcSql + IIF(ISNULL(cur_transp.usuModi),"NULL", "'" + ALLTRIM(cur_transp.usuModi) + "'") + ", "
		lcSql = lcSql + IIF(ISNULL(cur_transp.fecModi),"NULL", loDT.toMySql(cur_transp.fecModi)) + ", "
		lcSql = lcSql + IIF(ISNULL(cur_transp.idHostModi),"NULL", "'" + ALLTRIM(cur_transp.idHostModi) + "'") + ", "
		lcSql = lcSql + IIF(ISNULL(cur_transp.usuBaja),"NULL", "'" + ALLTRIM(cur_transp.usuBaja) + "'") + ", "
		lcSql = lcSql + IIF(ISNULL(cur_transp.fecBaja),"NULL", loDT.toMySql(cur_transp.fecBaja)) + ", "
		lcSql = lcSql + IIF(ISNULL(cur_transp.idHostBaja),"NULL", "'" + ALLTRIM(cur_transp.idHostBaja) + "'") + ")"
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
	
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			RETURN .F.
		ENDIF
	ELSE
		lcSql = "UPDATE transp SET codTrans = " + ALLTRIM(STR(cur_transp.codTrans)) + ", "
		lcSql = lcSql + "razsoc = '" + ALLTRIM(cur_transp.razsoc) + "', "
		lcSql = lcSql + "direccion = '" + ALLTRIM(cur_transp.direccion) + "', "
		lcSql = lcSql + "idLocalid = " + ALLTRIM(STR(cur_transp.idLocalid)) + ", "
		lcSql = lcSql + "telefono = '" + ALLTRIM(cur_transp.telefono) + "', "
		lcSql = lcSql + "fax = '" + ALLTRIM(cur_transp.fax) + "', "
		lcSql = lcSql + "email = '" + ALLTRIM(cur_transp.email) + "', "
		lcSql = lcSql + "usuModi = " + IIF(ISNULL(cur_transp.usuModi),"NULL", "'" + ALLTRIM(cur_transp.usuModi) + "'")+ ", "
		lcSql = lcSql + "fecModi = " + IIF(ISNULL(cur_transp.fecModi),"NULL", loDT.toMySql(cur_transp.fecModi)) + ", "
		lcSql = lcSql + "idHostModi = " + IIF(ISNULL(cur_transp.idHostModi),"NULL", "'" + ALLTRIM(cur_transp.idHostModi) + "'")+ ", "
		lcSql = lcSql + "usuBaja = " + IIF(ISNULL(cur_transp.usuBaja),"NULL", "'" + ALLTRIM(cur_transp.usuBaja) + "'")+ ", "
		lcSql = lcSql + "fecBaja = " + IIF(ISNULL(cur_transp.fecBaja),"NULL", loDT.toMySql(cur_transp.fecBaja)) + ", "
		lcSql = lcSql + "idHostBaja = " + IIF(ISNULL(cur_transp.idHostBaja),"NULL", "'" + ALLTRIM(cur_transp.idHostBaja) + "'") + " "
		lcSql = lcSql + "WHERE idTransp = " + ALLTRIM(STR(cur_transp.idTransp))

		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			RETURN .F.
		ENDIF
	ENDIF
	
	loResult.Close_Query()
	
	SELECT cur_transp
	lnCant = lnCant + 1
	loProg.update((lnCant * 100) / RECCOUNT(), "Actualizando Transportes...")
	SELECT cur_transp
	SKIP
ENDDO

loTransp.Close_Query()
loProg.Complete()


***********************************************************************************************************
* Actualizo tiposcli
***********************************************************************************************************
loProg.Show()
Thisform.Contenido.txtDetalles.Value = Thisform.Contenido.txtDetalles.Value + CHR(13) + "Actualizando Tipos de Clientes..."

lcSql = "SELECT * FROM tiposcli"
loTiposCli.ActiveConnection = loConn.ActiveConnection
loTiposCli.Cursor_Name = "cur_tipos"
loTiposCli.OpenQuery(lcSql)
lnCant = 0

SELECT cur_tipos
DO WHILE !EOF()
	lcSql = "SELECT COUNT(*) AS CantReg FROM tiposcli WHERE idTipoCli = " + ALLTRIM(STR(cur_tipos.idTipoCli))
	loResult.ActiveConnection = goConn.ActiveConnection
	loResult.Cursor_Name = "cur_tmp"
	loResult.OpenQuery(lcSql)
	
	IF IIF(INT(VAL(getConfig("SQLSRV"))) = 1, cur_tmp.CantReg, VAL(cur_tmp.CantReg)) = 0 THEN
		lcSql = "INSERT INTO tiposcli ("
		lcSql = lcSql + "	idTipoCli, "
		lcSql = lcSql + "	descripcio, "
		lcSql = lcSql + "	credmax_dd, "
		lcSql = lcSql + "	credmax_hh, "
		lcSql = lcSql + "	usuAlta, "
		lcSql = lcSql + "	fecAlta, "
		lcSql = lcSql + "	idHostAlta, "
		lcSql = lcSql + "	usuModi, "
		lcSql = lcSql + "	fecModi, "
		lcSql = lcSql + "	idHostModi, "
		lcSql = lcSql + "	usuBaja, "
		lcSql = lcSql + "	fecBaja, "
		lcSql = lcSql + "	idHostBaja) VALUES ( "
		lcSql = lcSql + ALLTRIM(STR(cur_tipos.idTipoCli)) + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_tipos.descripcio) + "', "
		lcSql = lcSql + ALLTRIM(STR(cur_tipos.credmax_dd, 20, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_tipos.credmax_hh, 20, 2)) + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_tipos.usuAlta) + "', "
		lcSql = lcSql + loDT.toMySql(cur_tipos.fecAlta) + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_tipos.idHostAlta) + "', "
		lcSql = lcSql + IIF(ISNULL(cur_tipos.usuModi),"NULL", "'" + ALLTRIM(cur_tipos.usuModi) + "'") + ", "
		lcSql = lcSql + IIF(ISNULL(cur_tipos.fecModi),"NULL", loDT.toMySql(cur_tipos.fecModi)) + ", "
		lcSql = lcSql + IIF(ISNULL(cur_tipos.idHostModi),"NULL", "'" + ALLTRIM(cur_tipos.idHostModi) + "'") + ", "
		lcSql = lcSql + IIF(ISNULL(cur_tipos.usuBaja),"NULL", "'" + ALLTRIM(cur_tipos.usuBaja) + "'") + ", "
		lcSql = lcSql + IIF(ISNULL(cur_tipos.fecBaja),"NULL", loDT.toMySql(cur_tipos.fecBaja)) + ", "
		lcSql = lcSql + IIF(ISNULL(cur_tipos.idHostBaja),"NULL", "'" + ALLTRIM(cur_tipos.idHostBaja) + "'") + ")"
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
	
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			RETURN .F.
		ENDIF
	ELSE
		lcSql = "UPDATE tiposcli SET descripcio = '" + ALLTRIM(cur_tipos.descripcio) + "', "
		lcSql = lcSql + "credmax_dd = " + ALLTRIM(STR(cur_tipos.credmax_dd, 20, 2)) + ", "
		lcSql = lcSql + "credmax_hh = " + ALLTRIM(STR(cur_tipos.credmax_hh, 20, 2)) + ", "
		lcSql = lcSql + "usuModi = " + IIF(ISNULL(cur_tipos.usuModi),"NULL", "'" + ALLTRIM(cur_tipos.usuModi) + "'")+ ", "
		lcSql = lcSql + "fecModi = " + IIF(ISNULL(cur_tipos.fecModi),"NULL", loDT.toMySql(cur_tipos.fecModi)) + ", "
		lcSql = lcSql + "idHostModi = " + IIF(ISNULL(cur_tipos.idHostModi),"NULL", "'" + ALLTRIM(cur_tipos.idHostModi) + "'")+ ", "
		lcSql = lcSql + "usuBaja = " + IIF(ISNULL(cur_tipos.usuBaja),"NULL", "'" + ALLTRIM(cur_tipos.usuBaja) + "'")+ ", "
		lcSql = lcSql + "fecBaja = " + IIF(ISNULL(cur_tipos.fecBaja),"NULL", loDT.toMySql(cur_tipos.fecBaja)) + ", "
		lcSql = lcSql + "idHostBaja = " + IIF(ISNULL(cur_tipos.idHostBaja),"NULL", "'" + ALLTRIM(cur_tipos.idHostBaja) + "'") + " "
		lcSql = lcSql + "WHERE idTipoCli= " + ALLTRIM(STR(cur_tipos.idTipoCli))

		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			RETURN .F.
		ENDIF
	ENDIF
	
	loResult.Close_Query()
	
	SELECT cur_tipos
	lnCant = lnCant + 1
	loProg.update((lnCant * 100) / RECCOUNT(), "Actualizando Tipos de Clientes...")
	SELECT cur_tipos
	SKIP
ENDDO

loTiposCli.Close_Query()
loProg.Complete()

***********************************************************************************************************
* Actualizo UnidMed
***********************************************************************************************************
loProg.Show()
Thisform.Contenido.txtDetalles.Value = Thisform.Contenido.txtDetalles.Value + CHR(13) + "Actualizando Unidades de Medida..."

lcSql = "SELECT * FROM unidmed"
loUnidMed.ActiveConnection = loConn.ActiveConnection
loUnidMed.Cursor_Name = "cur_unidmed"
loUnidMed.OpenQuery(lcSql)
lnCant = 0

SELECT cur_unidmed
DO WHILE !EOF()
	lcSql = "SELECT COUNT(*) AS CantReg FROM unidmed WHERE idUniMed = " + ALLTRIM(STR(cur_unidmed.idUniMed))
	loResult.ActiveConnection = goConn.ActiveConnection
	loResult.Cursor_Name = "cur_tmp"
	loResult.OpenQuery(lcSql)
	
	IF IIF(INT(VAL(getConfig("SQLSRV"))) = 1, cur_tmp.CantReg, VAL(cur_tmp.CantReg)) = 0 THEN
		lcSql = "INSERT INTO unidmed ("
		lcSql = lcSql + "	idUniMed, "
		lcSql = lcSql + "	codUM, "
		lcSql = lcSql + "	descripcio, "
		lcSql = lcSql + "	usuAlta, "
		lcSql = lcSql + "	fecAlta, "
		lcSql = lcSql + "	idHostAlta, "
		lcSql = lcSql + "	usuModi, "
		lcSql = lcSql + "	fecModi, "
		lcSql = lcSql + "	idHostModi, "
		lcSql = lcSql + "	usuBaja, "
		lcSql = lcSql + "	fecBaja, "
		lcSql = lcSql + "	idHostBaja) VALUES ( "
		lcSql = lcSql + ALLTRIM(STR(cur_unidmed.idUniMed)) + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_unidmed.codUM) + "', "
		lcSql = lcSql + "'" + ALLTRIM(cur_unidmed.descripcio) + "', "
		lcSql = lcSql + "'" + ALLTRIM(cur_unidmed.usuAlta) + "', "
		lcSql = lcSql + loDT.toMySql(cur_unidmed.fecAlta) + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_unidmed.idHostAlta) + "', "
		lcSql = lcSql + IIF(ISNULL(cur_unidmed.usuModi),"NULL", "'" + ALLTRIM(cur_unidmed.usuModi) + "'") + ", "
		lcSql = lcSql + IIF(ISNULL(cur_unidmed.fecModi),"NULL", loDT.toMySql(cur_unidmed.fecModi)) + ", "
		lcSql = lcSql + IIF(ISNULL(cur_unidmed.idHostModi),"NULL", "'" + ALLTRIM(cur_unidmed.idHostModi) + "'") + ", "
		lcSql = lcSql + IIF(ISNULL(cur_unidmed.usuBaja),"NULL", "'" + ALLTRIM(cur_unidmed.usuBaja) + "'") + ", "
		lcSql = lcSql + IIF(ISNULL(cur_unidmed.fecBaja),"NULL", loDT.toMySql(cur_unidmed.fecBaja)) + ", "
		lcSql = lcSql + IIF(ISNULL(cur_unidmed.idHostBaja),"NULL", "'" + ALLTRIM(cur_unidmed.idHostBaja) + "'") + ")"
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
	
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			RETURN .F.
		ENDIF
	ELSE
		lcSql = "UPDATE unidmed SET codUM = '" + ALLTRIM(cur_unidmed.codUM) + "', "
		lcSql = lcSql + "descripcio = '" + ALLTRIM(cur_unidmed.descripcio) + "', "
		lcSql = lcSql + "usuModi = " + IIF(ISNULL(cur_unidmed.usuModi),"NULL", "'" + ALLTRIM(cur_unidmed.usuModi) + "'")+ ", "
		lcSql = lcSql + "fecModi = " + IIF(ISNULL(cur_unidmed.fecModi),"NULL", loDT.toMySql(cur_unidmed.fecModi)) + ", "
		lcSql = lcSql + "idHostModi = " + IIF(ISNULL(cur_unidmed.idHostModi),"NULL", "'" + ALLTRIM(cur_unidmed.idHostModi) + "'")+ ", "
		lcSql = lcSql + "usuBaja = " + IIF(ISNULL(cur_unidmed.usuBaja),"NULL", "'" + ALLTRIM(cur_unidmed.usuBaja) + "'")+ ", "
		lcSql = lcSql + "fecBaja = " + IIF(ISNULL(cur_unidmed.fecBaja),"NULL", loDT.toMySql(cur_unidmed.fecBaja)) + ", "
		lcSql = lcSql + "idHostBaja = " + IIF(ISNULL(cur_unidmed.idHostBaja),"NULL", "'" + ALLTRIM(cur_unidmed.idHostBaja) + "'") + " "
		lcSql = lcSql + "WHERE idUniMed = " + ALLTRIM(STR(cur_unidmed.idUniMed))

		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			RETURN .F.
		ENDIF
	ENDIF
	
	loResult.Close_Query()
	
	SELECT cur_unidmed
	lnCant = lnCant + 1
	loProg.update((lnCant * 100) / RECCOUNT(), "Actualizando Unidades de Medida...")
	SELECT cur_unidmed
	SKIP
ENDDO

loUnidMed.Close_Query()
loProg.Complete()

***********************************************************************************************************
* Actualizo Ramos
***********************************************************************************************************
loProg.Show()
Thisform.Contenido.txtDetalles.Value = Thisform.Contenido.txtDetalles.Value + CHR(13) + "Actualizando Ramos..."

lcSql = "SELECT * FROM ramos"
loRamos.ActiveConnection = loConn.ActiveConnection
loRamos.Cursor_Name = "cur_ramos"
loRamos.OpenQuery(lcSql)
lnCant = 0

SELECT cur_ramos
DO WHILE !EOF()
	lcSql = "SELECT COUNT(*) AS CantReg FROM ramos WHERE idRamo = " + ALLTRIM(STR(cur_ramos.idRamo))
	loResult.ActiveConnection = goConn.ActiveConnection
	loResult.Cursor_Name = "cur_tmp"
	loResult.OpenQuery(lcSql)
	
	IF IIF(INT(VAL(getConfig("SQLSRV"))) = 1, cur_tmp.CantReg, VAL(cur_tmp.CantReg)) = 0 THEN
		lcSql = "INSERT INTO ramos ("
		lcSql = lcSql + "	idRamo, "
		lcSql = lcSql + "	descripcio, "
		lcSql = lcSql + "	usuAlta, "
		lcSql = lcSql + "	fecAlta, "
		lcSql = lcSql + "	idHostAlta, "
		lcSql = lcSql + "	usuModi, "
		lcSql = lcSql + "	fecModi, "
		lcSql = lcSql + "	idHostModi, "
		lcSql = lcSql + "	usuBaja, "
		lcSql = lcSql + "	fecBaja, "
		lcSql = lcSql + "	idHostBaja) VALUES ( "
		lcSql = lcSql + ALLTRIM(STR(cur_ramos.idRamo)) + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_ramos.descripcio) + "', "
		lcSql = lcSql + "'" + ALLTRIM(cur_ramos.usuAlta) + "', "
		lcSql = lcSql + loDT.toMySql(cur_ramos.fecAlta) + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_ramos.idHostAlta) + "', "
		lcSql = lcSql + IIF(ISNULL(cur_ramos.usuModi),"NULL", "'" + ALLTRIM(cur_ramos.usuModi) + "'") + ", "
		lcSql = lcSql + IIF(ISNULL(cur_ramos.fecModi),"NULL", loDT.toMySql(cur_ramos.fecModi)) + ", "
		lcSql = lcSql + IIF(ISNULL(cur_ramos.idHostModi),"NULL", "'" + ALLTRIM(cur_ramos.idHostModi) + "'") + ", "
		lcSql = lcSql + IIF(ISNULL(cur_ramos.usuBaja),"NULL", "'" + ALLTRIM(cur_ramos.usuBaja) + "'") + ", "
		lcSql = lcSql + IIF(ISNULL(cur_ramos.fecBaja),"NULL", loDT.toMySql(cur_ramos.fecBaja)) + ", "
		lcSql = lcSql + IIF(ISNULL(cur_ramos.idHostBaja),"NULL", "'" + ALLTRIM(cur_ramos.idHostBaja) + "'") + ")"
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
	
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			RETURN .F.
		ENDIF
	ELSE
		lcSql = "UPDATE ramos SET descripcio = '" + ALLTRIM(cur_ramos.descripcio) + "', "
		lcSql = lcSql + "usuModi = " + IIF(ISNULL(cur_ramos.usuModi),"NULL", "'" + ALLTRIM(cur_ramos.usuModi) + "'")+ ", "
		lcSql = lcSql + "fecModi = " + IIF(ISNULL(cur_ramos.fecModi),"NULL", loDT.toMySql(cur_ramos.fecModi)) + ", "
		lcSql = lcSql + "idHostModi = " + IIF(ISNULL(cur_ramos.idHostModi),"NULL", "'" + ALLTRIM(cur_ramos.idHostModi) + "'")+ ", "
		lcSql = lcSql + "usuBaja = " + IIF(ISNULL(cur_ramos.usuBaja),"NULL", "'" + ALLTRIM(cur_ramos.usuBaja) + "'")+ ", "
		lcSql = lcSql + "fecBaja = " + IIF(ISNULL(cur_ramos.fecBaja),"NULL", loDT.toMySql(cur_ramos.fecBaja)) + ", "
		lcSql = lcSql + "idHostBaja = " + IIF(ISNULL(cur_ramos.idHostBaja),"NULL", "'" + ALLTRIM(cur_ramos.idHostBaja) + "'") + " "
		lcSql = lcSql + "WHERE idRamo = " + ALLTRIM(STR(cur_ramos.idRamo))

		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			RETURN .F.
		ENDIF
	ENDIF
	
	loResult.Close_Query()
	
	SELECT cur_ramos
	lnCant = lnCant + 1
	loProg.update((lnCant * 100) / RECCOUNT(), "Actualizando Ramos...")
	SELECT cur_ramos
	SKIP
ENDDO

loRamos.Close_Query()
loProg.Complete()


goConn.Commit()

RETURN .T.
ENDPROC


************************************************************
OBJETO: txtDetalles
************************************************************
*** PROPIEDADES ***
Height = 223
Left = 6
ReadOnly = .T.
Top = 49
Width = 723
Name = "txtDetalles"

*** METODOS ***


************************************************************
OBJETO: btnImportar
************************************************************
*** PROPIEDADES ***
Top = 275
Left = 638
Height = 44
Width = 45
Picture = ..\..\clases\imagen\iconos bajados\descargar-flecha-naranja-icono-4016.ico
ToolTipText = "Importar"
Alignment = 2
Name = "btnImportar"

*** METODOS ***
PROCEDURE Click
LOCAL loConn, loVentasCab, loVentasDet, lcSql, loCommand
LOCAL loProg, lnProxID, loDT, lnCantReng, i, lnProxIdCC

loConn = CREATEOBJECT("odbc_connect")
loVentasCab = CREATEOBJECT("odbc_result")
loVentasDet = CREATEOBJECT("odbc_result")
loCommand = CREATEOBJECT("odbc_command")
loProg = CREATEOBJECT("_thermometer")
loDT = CREATEOBJECT("datetime")
lcSql = ""
lnProxID = 0
lnProxIdCC = 0
lnCantReng = 0

IF Thisform.Contenido.chkActualizarTablas.Value = 1 THEN
	IF !Thisform.actualizar_tablas() THEN
		Thisform.contenido.txtDetalles.Value = "Ha ocurrido un error al intentar actualizar las tablas..."	
		RETURN .F.
	ENDIF
ENDIF

IF Thisform.Contenido.chkActualizarClientes.Value = 1THEN
	IF !Thisform.Actualizar_clientes() THEN
		Thisform.Contenido.txtDetalles.Value = "Ha ocurrido un error al intentar actualizar los clientes..."
		RETURN .F.
	ENDIF
ENDIF

IF Thisform.Contenido.chkActualizarArticulos.Value = 1 THEN
	IF !Thisform.actualizar_articulos() THEN
		Thisform.contenido.txtDetalles.Value = "Ha ocurrido un error al intentar actualizar los artículos..."	
		RETURN .F.
	ENDIF
ENDIF

MESSAGEBOX("La importación ha finalizado con éxito", 0+64, Thisform.Caption)
RETURN .T.
ENDPROC


************************************************************
OBJETO: Clscerrar1
************************************************************
*** PROPIEDADES ***
Top = 275
Left = 684
Picture = ..\..\clases\imagen\iconos bajados\salir-de-mi-perfil-icono-3964.ico
Name = "Clscerrar1"

*** METODOS ***


************************************************************
OBJETO: chkActualizarTablas
************************************************************
*** PROPIEDADES ***
Top = 13
Left = 13
Height = 18
Width = 144
Alignment = 0
Caption = "Actualizar tablas"
Name = "chkActualizarTablas"

*** METODOS ***


************************************************************
OBJETO: chkActualizarClientes
************************************************************
*** PROPIEDADES ***
Top = 13
Left = 165
Height = 18
Width = 144
Alignment = 0
Caption = "Actualizar Clientes"
Name = "chkActualizarClientes"

*** METODOS ***


************************************************************
OBJETO: chkActualizarArticulos
************************************************************
*** PROPIEDADES ***
Top = 13
Left = 331
Height = 18
Width = 144
Alignment = 0
Caption = "Actualizar Artículos"
Name = "chkActualizarArticulos"

*** METODOS ***


************************************************************
OBJETO: 
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


