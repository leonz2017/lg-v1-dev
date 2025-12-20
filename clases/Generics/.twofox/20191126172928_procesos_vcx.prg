************************************************************
OBJETO: actu_papierttei
************************************************************
*** PROPIEDADES ***
filename = 
excel_app = 
Name = "actu_papierttei"

*** METODOS ***
PROCEDURE crear_cursor
*************************************
* Creo el cursor donde guardo los
* datos del excel
*************************************

*CREATE CURSOR cur_Art (	;
	
ENDPROC


************************************************************
OBJETO: actualiza_ituper
************************************************************
*** PROPIEDADES ***
access_path = 
activeconnection = 
error_message = 
idprov = 0
desc1 = 0.00
desc2 = 0.00
desc3 = 0.00
desc4 = 0.00
alic_iva = 0.00
margen_may = 0.00
margen_min = 0.00
Name = "actualiza_ituper"

*** METODOS ***
PROCEDURE procesar
IF !This.conectar() THEN
	RETURN .F.
ENDIF

This.ActiveConnection.BeginTransaction()

IF !This.actualizar_marcas() THEN
	This.ActiveConnection.Rollback()
	RETURN .F.
ENDIF

IF !This.actualizar_familias() THEN
	This.ActiveConnection.RollBack()
	RETURN .F.
ENDIF

IF !This.actualizar_articulos() THEN
	This.ActiveConnection.Rollback()
	RETURN .F.
ENDIF

This.ActiveConnection.Commit()
RETURN .T.
ENDPROC
PROCEDURE conectar
LOCAL lcStringConn

lcStringConn = "Driver=Microsoft Access Driver (*.mdb);uid=admin;pwd=;DBQ=" + ALLTRIM(this.access_path) + "\Ituper2k.mde"
This.ActiveConnection.ConnectionString = lcStringConn

IF !This.ActiveConnection.Open() THEN
	this.error_message = "No se puede conectar a Ituper2K.mde"
	RETURN .F.
ENDIF

this.error_message = ""
RETURN .T.

ENDPROC
PROCEDURE actualizar_marcas
*****************************************************************************
* Este método permite actualizar las marcas de la base de ITUPER
*****************************************************************************

LOCAL loCommand, loProv, lcSql, loMarcas, lnProxID
LOCAL loDT, loProg, lnCont

loCommand = CREATEOBJECT("odbc_command")
loProv = CREATEOBJECT("odbc_result")
loMarcas = CREATEOBJECT("odbc_result")
loDT = CREATEOBJECT("datetime")
loProg = CREATEOBJECT("_thermometer")
lcSql = ""
lnCont = 0

loProg.show()

lcSql = "SELECT * FROM Proveedores"
loProv.ActiveConnection = this.ActiveConnection.ActiveConnection
loProv.Cursor_Name = "cur_proveedor"
loProv.OpenQuery(lcSql)

SELECT cur_proveedor
DO WHILE !EOF("cur_proveedor")
	lcSql = "SELECT * FROM marcas WHERE LTRIM(RTRIM(descripcio)) = '" + ALLTRIM(cur_proveedor.marca) + "'"
	loMarcas.ActiveConnection = goConn.ActiveConnection
	loMarcas.Cursor_Name = "cur_tmp"
	loMarcas.OpenQuery(lcSql)
	
	SELECT cur_tmp
	IF RECCOUNT("cur_tmp") = 0 THEN
		lnProxID = goConn.GetNextID("marcas", "idmarca")
		lcSql = "INSERT INTO marcas (idmarca, descripcio, usuAlta, fecAlta, idHostAlta) VALUES ("
		lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", '" + ALLTRIM(cur_proveedor.marca) + "', "
		lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
		lcSql = lcSql + loDT.getDateTime() + ", "
		lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "')"
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			This.error_message = loCommand.ErrorMessage
			RETURN .F.
		ENDIF
	ENDIF
	
	loMarcas.Close_Query()
	
	SELECT cur_proveedor
	lnCont = lnCont + 1
	loProg.update((lnCont * 100) / RECCOUNT("cur_proveedor"), "Actualizando marcas ITUPER")
	SELECT cur_proveedor
	SKIP
ENDDO

loProv.Close_Query()
loProg.Complete()

RETURN .T.
ENDPROC
PROCEDURE actualizar_familias
*****************************************************************************
* Este método permite actualizar las subfamilias de la base de ITUPER
*****************************************************************************

LOCAL loCommand, loFam, lcSql, loFamilias, lnProxID
LOCAL loDT, loProg, lnCont

loCommand = CREATEOBJECT("odbc_command")
loFam = CREATEOBJECT("odbc_result")
loFamilias = CREATEOBJECT("odbc_result")
loDT = CREATEOBJECT("datetime")
loProg = CREATEOBJECT("_thermometer")
lcSql = ""
lnCont = 0

lcSql = "SELECT * FROM Familias"
loFam.ActiveConnection = this.ActiveConnection.ActiveConnection
loFam.Cursor_Name = "cur_subfam"
loFam.OpenQuery(lcSql)

loProg.show()

SELECT cur_subfam
DO WHILE !EOF("cur_subfam")
	lcSql = "SELECT * FROM subfam WHERE LTRIM(RTRIM(descripcio)) = '" + ALLTRIM(cur_subfam.Descripcion) + "'"
	loFamilias.ActiveConnection = goConn.ActiveConnection
	loFamilias.Cursor_Name = "cur_tmp"
	loFamilias.OpenQuery(lcSql)
	
	SELECT cur_tmp
	IF RECCOUNT("cur_tmp") = 0 THEN
		lnProxID = goConn.GetNextID("subfam", "idSubFam")
		lcSql = "INSERT INTO subfam (idSubFam, descripcio, usuAlta, fecAlta, idHostAlta) VALUES ("
		lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", '" + ALLTRIM(cur_subfam.Descripcion) + "', "
		lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
		lcSql = lcSql + loDT.getDateTime() + ", "
		lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "')"
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			This.error_message = loCommand.ErrorMessage
			RETURN .F.
		ENDIF
	ENDIF
	
	loFamilias.Close_Query()
	
	SELECT cur_subfam
	lnCont = lnCont + 1
	loProg.update((lnCont * 100) / RECCOUNT("cur_subfam"), "Actualizando marcas ITUPER")
	SELECT cur_subfam
	SKIP
ENDDO

loFam.Close_Query()
loProg.Complete()

RETURN .T.
ENDPROC
PROCEDURE actualizar_articulos
***************************************************************************
* Actualizo los artículos
***************************************************************************
LOCAL loCommand, lcSql, loArticulos, loResult
LOCAL loITU, loRes1
LOCAL loDT, loProg, lnCont, lnProxID, lnIdSubFam
LOCAL lnPrLista, lnCostoRep, lnPrVentaMax, lnPrVentaMin
LOCAL lnFinalMax, lnFinalMin, lcCodigo,lnIdMarca

loCommand 	= CREATEOBJECT("odbc_command")
loArticulos = CREATEOBJECT("odbc_result")
loResult 	= CREATEOBJECT("odbc_result")
loITU 		= CREATEOBJECT("odbc_result")
loRes1		= CREATEOBJECT("odbc_result")
loDT 		= CREATEOBJECT("datetime")
loProg 		= CREATEOBJECT("_thermometer")
lcSql 		= ""
lnCont 		= 0
lnPrLista	= 0.00
lnCostoRep	= 0.00
lnPrVentaMax = 0.00
lnPrVentaMin = 0.00
lnFinalMax = 0.00
lnFinalMin = 0.00
lcCodigo 	= ""
lnProxID 	= 0
lnIdSubFam	= 0
lnIdMarca 	= 0

loProg.Show()

lcSql = "SELECT * FROM Articulos"
loArticulos.ActiveConnection = this.activeconnection.ActiveConnection
loArticulos.Cursor_Name = "cur_Articulos"
loArticulos.OpenQuery(lcSql)

SELECT cur_Articulos
DO WHILE !EOF("cur_Articulos")
	* Busco el id de subrubro
	lcSql = "SELECT * FROM Familias WHERE ID_Familia = " + ALLTRIM(STR(cur_Articulos.Familia))
	loITU.ActiveConnection = This.ActiveConnection.ActiveConnection
	loITU.Cursor_Name = "cur_sf"
	loITU.OpenQuery(lcSql)
	
	lcSql = "SELECT * FROM subfam WHERE descripcio = '" + ALLTRIM(cur_sf.Descripcion) + "'"
	loRes1.ActiveConnection = goConn.ActiveConnection
	loRes1.Cursor_Name = "cur_subfam"
	loRes1.OpenQuery(lcSql)
	
	SELECT cur_subfam
	IF RECCOUNT("cur_subfam") > 0 THEN
		lnIdSubFam = cur_subfam.idSubFam
	ENDIF
	
	loITU.Close_Query()
	loRes1.Close_Query()
	
	lcSql = "SELECT * FROM Proveedores WHERE ID_DatosProveedor = " + ALLTRIM(STR(cur_Articulos.Proveedor))
	loITU.ActiveConnection = This.ActiveConnection.ActiveConnection
	loITU.Cursor_Name = "cur_prov"
	loITU.OpenQuery(lcSql)
	
	SELECT cur_prov
	lcSql = "SELECT * FROM Marcas WHERE descripcio = '" + ALLTRIM(cur_prov.Marca) + "'"
	loRes1.Cursor_Name = "cur_marca"
	loRes1.ActiveConnection = goConn.ActiveConnection
	loRes1.OpenQuery(lcSql)
	
	SELECT cur_marca
	IF RECCOUNT("cur_marca") > 0 THEN
		lnIdMarca = cur_marca.idMarca
	ENDIF
	
	loITU.Close_Query()
	loRes1.Close_Query()
	
	* Calculo el precio de venta
	lnPrLista = cur_Articulos.Precio
	lnCostoRep = calcular_costo(lnPrLista, this.desc1, this.desc2, this.desc3, this.desc4, 0)
	lnPrVentaMax = lnCostoRep + (lnCostoRep * (this.margen_may / 100))
	lnPrVentaMin = lnCostoRep + (lnCostoRep * (this.margen_min / 100))
	lnFinalMax = lnPrVentaMax + (lnPrVentaMax * (this.alic_iva / 100))
	lnFinalMin = lnPrVentaMin + (lnPrVentaMin * (this.alic_iva / 100))
	lcCodigo = "ITU" + ALLTRIM(cur_Articulos.Codigo)

	lcSql = "SELECT * FROM articulos WHERE codArt = '" + lcCodigo + "' AND idSubFam = " + ALLTRIM(STR(lnIdSubFam))
	loResult.ActiveConnection = goConn.ActiveConnection
	loResult.Cursor_Name = "cur_tmp"
	loResult.OpenQuery(lcSql)
	
	SELECT cur_tmp
	IF RECCOUNT("cur_tmp") = 0 THEN
		lnProxID = goConn.GetNextID("articulos", "idArticulo")
		
		lcSql = "INSERT INTO articulos ( "
		lcSql = lcSql + "	idArticulo, "
		lcSql = lcSql + "	idProv, "
		lcSql = lcSql + "	idFamilia, "
		lcSql = lcSql + "	idSubFam, "
		lcSql = lcSql + "	idMarca, "
		lcSql = lcSql + "	codArt, "
		lcSql = lcSql + "	descripcio, "
		lcSql = lcSql + "	alicIVA, "
		lcSql = lcSql + "	tmon, "
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
		lcSql = lcSql + "	prventaMax, "
		lcSql = lcSql + "	prventaMin, "
		lcSql = lcSql + "	prfinalMax, "
		lcSql = lcSql + "	prfinalMin, "
		lcSql = lcSql + "	observ, "
		lcSql = lcSql + "	idUniMed, "
		lcSql = lcSql + "	habilitado, "
		lcSql = lcSql + "	usuAlta, "
		lcSql = lcSql + "	fecAlta, "
		lcSql = lcSql + "	idHostAlta) "
		lcSql = lcSql + "VALUES ( "
		lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", "
		lcSql = lcSql + ALLTRIM(STR(This.idProv)) + ", "
		lcSql = lcSql + "1, " 											&& Familia
		lcSql = lcSql + ALLTRIM(STR(lnIdSubFam)) + ", "					&& SubFamilia
		lcSql = lcSql + ALLTRIM(STR(lnIdMarca)) + ", " 					&& Marca
		lcSql = lcSql + "'" + ALLTRIM(lcCodigo) + "', "
		lcSql = lcSql + "'" + ALLTRIM(STRTRAN(STRTRAN(cur_Articulos.Descripcion, "'", " "), "\", " ")) + "', "
		lcSql = lcSql + ALLTRIM(STR(This.alic_iva, 10, 2)) + ", "
		lcSql = lcSql + "'PSO', "
		lcSql = lcSql + "0, "											&& Precio de lista ext.
		lcSql = lcSql + "0, "											&& Cotización
		lcSql = lcSql + ALLTRIM(STR(lnPrLista, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(This.desc1, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(This.desc2, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(This.desc3, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(This.desc4, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnCostoRep, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(This.margen_may, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(This.margen_min, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnPrVentaMax, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnPrVentaMin, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnFinalMax, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnFinalMin, 10, 2)) + ", "
		lcSql = lcSql + "'', " && Observ
		lcSql = lcSql + "1, "
		lcSql = lcSql + "1, "
		lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
		lcSql = lcSql + loDT.getDateTime() + ", "
		lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "')"
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			This.error_message = loCommand.ErrorMessage
			RETURN .F.
		ENDIF
	ELSE
		&& En caso de existir el código, modifico el artículo
		lcSql = "UPDATE articulos "
		lcSql = lcSql + "SET 	prLista = " + ALLTRIM(STR(lnPrLista, 10, 2)) + ", "
		lcSql = lcSql + "		bonif1 = " + ALLTRIM(STR(This.desc1, 10, 2)) + ", "
		lcSql = lcSql + "		bonif2 = " + ALLTRIM(STR(This.desc2, 10, 2)) + ", "
		lcSql = lcSql + "		bonif3 = " + ALLTRIM(STR(This.desc3, 10, 2)) + ", "
		lcSql = lcSql + "		bonif4 = " + ALLTRIM(STR(This.desc4, 10, 2)) + ", "
		lcSql = lcSql + "		costoRep = " + ALLTRIM(STR(lnCostoRep, 10, 2)) + ", "
		lcSql = lcSql + "		margenMax = " + ALLTRIM(STR(This.margen_may, 10, 2)) + ", "
		lcSql = lcSql + "		margenMin = " + ALLTRIM(STR(This.margen_min, 10, 2)) + ", "
		lcSql = lcSql + "		prventaMax = " + ALLTRIM(STR(lnPrVentaMax, 10, 2)) + ", "
		lcSql = lcSql + "		prventaMin = " + ALLTRIM(STR(lnPrVentaMin, 10, 2)) + ", "
		lcSql = lcSql + "		prfinalMax = " + ALLTRIM(STR(lnFinalMax, 10, 2)) + ", "
		lcSql = lcSql + "		prfinalMin = " + ALLTRIM(STR(lnFinalMin, 10, 2)) + ", "
		lcSql = lcSql + "		usuModi = '" + ALLTRIM(gcCodUsu) + "', "
		lcSql = lcSql + "		fecModi = " + loDT.getdatetime() + ", "
		lcSql = lcSql + "		idHostModi = '" + ALLTRIM(SYS(0)) + "' "
		lcSql = lcSql + "WHERE codArt = '" + ALLTRIM(lcCodigo) + "' AND idSubFam = " + ALLTRIM(STR(lnIdSubFam))
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			this.error_message = loCommand.ErrorMessage
			RETURN .F.
		ENDIF		
	ENDIF
	
	loResult.Close_Query()

	SELECT cur_Articulos
	lnCont = lnCont + 1
	loProg.Update((lnCont * 100) / RECCOUNT("cur_Articulos"), "Actualizando Precios")
	SELECT cur_Articulos
	SKIP
ENDDO

loArticulos.Close_Query()
loProg.Complete()

RETURN .T.


ENDPROC
PROCEDURE Init
this.activeconnection = CREATEOBJECT("odbc_connect")

ENDPROC


************************************************************
OBJETO: actu_arze
************************************************************
*** PROPIEDADES ***
object_excel = 
nombre_archivo = 
errormessage = 
desc1 = 0.00
desc2 = 0.00
desc3 = 0.00
desc4 = 0.00
margen_may = 0.00
margen_min = 0.00
idprov = 0
alic_iva = 21
Name = "actu_arze"

*** METODOS ***
PROCEDURE open
LOCAL lnFilas, lValue, lValue2, lcSubFam
LOCAL loProg

lnFilas = 6
lValue = ""
lValue2 = ""
lcSubFam = ""

This.crear_cursor()
This.object_excel = CREATEOBJECT("Excel.Application")

IF ALLTRIM(This.nombre_archivo) == "" THEN
	This.ErrorMessage = "Debe ingresar el nombre del archivo"
	RETURN .F.
ENDIF

This.object_excel.Workbooks.Open(This.nombre_archivo)

DO WHILE !ISNULL(This.object_excel.cells[lnFilas, 1].Value)
	lValue = IIF(TYPE("This.object_excel.cells[lnFilas, 1].Value") == "C", STRTRAN(ALLTRIM(This.object_excel.cells[lnFilas, 1].Value), " ", ""), STR(This.object_excel.cells[lnFilas, 1].Value))
	
	IF !ISNULL(This.object_excel.cells[lnFilas, 4].Value) THEN
		lValue2 = IIF(TYPE("This.object_excel.cells[lnFilas, 4].Value") == "C", This.object_excel.cells[lnFilas, 4].Value, "")
	ELSE
		lValue2 = ""
	ENDIF
	
	IF ALLTRIM(lValue) <> "CODIGO" THEN
		IF !This.object_excel.cells[lnFilas, 1].Font.Bold THEN
			IF !(SUBSTR(ALLTRIM(RIGHT(lValue2, 2)), 1, 1) == "%") THEN
				SELECT cur_arze
				APPEND BLANK
				REPLACE cur_arze.codigo WITH "ARZ" + ALLTRIM(lValue)
				REPLACE cur_arze.descripcio WITH ALLTRIM(This.object_excel.cells[lnFilas, 2].Value) ADDITIVE
				REPLACE cur_arze.modelo WITH ALLTRIM(IIF(ISNULL(This.object_excel.cells[lnFilas, 3].Value), "", This.object_excel.cells[lnFilas, 3].Value)) ADDITIVE
				REPLACE cur_arze.subfam WITH ALLTRIM(cur_subfam.descripcio) ADDITIVE
				REPLACE cur_arze.precio WITH This.object_excel.cells[lnFilas, 4].Value ADDITIVE
			ELSE
				SELECT cur_arzepor
				APPEND BLANK
				REPLACE cur_arzepor.codigo WITH "ARZ" + ALLTRIM(lValue)
				REPLACE cur_arzepor.descripcio WITH ALLTRIM(This.object_excel.cells[lnFilas, 2].Value) ADDITIVE
				REPLACE cur_arzepor.modelo WITH ALLTRIM(IIF(ISNULL(This.object_excel.cells[lnFilas, 3].Value), "", This.object_excel.cells[lnFilas, 3].Value)) ADDITIVE
				REPLACE cur_arzepor.precio WITH This.object_excel.cells[lnFilas, 4].Value ADDITIVE
			ENDIF
		ELSE
			IF TYPE("This.object_excel.cells[lnFilas, 1].Value") == "C" THEN
				lcSubFam = This.object_excel.cells[lnFilas, 1].Value
				SELECT cur_subfam
				APPEND BLANK
				REPLACE descripcio WITH ALLTRIM(lcSubFam)
			ENDIF
		ENDIF
	ENDIF	

	lnFilas = lnFilas + 1
	WAIT WINDOW "Procesando: " + ALLTRIM(STR(lnFilas)) NOWAIT
ENDDO

SELECT cur_arze
IF RECCOUNT("cur_arze") > 0 THEN
	GO TOP
ENDIF

This.object_excel.quit()
RETURN .T.
ENDPROC
PROCEDURE crear_cursor
CREATE CURSOR cur_subfam (	;
	descripcio varchar(60))

CREATE CURSOR cur_arze (	;
	codigo		varchar(20),;
	descripcio	varchar(60),;
	modelo		varchar(60),;
	subfam		varchar(60),;
	precio		float(10,2))
	
SELECT cur_arze
INDEX ON codigo TAG codigo ASCENDING
INDEX ON descripcio TAG descripcio ASCENDING ADDITIVE
INDEX ON modelo TAG modelo ASCENDING ADDITIVE

CREATE CURSOR cur_arzepor (	;
	codigo		varchar(20),;
	descripcio	varchar(60),;
	modelo		varchar(60),;
	precio		varchar(10))

SELECT cur_arzepor
INDEX ON codigo TAG codigo ASCENDING
INDEX ON descripcio TAG descripcio ASCENDING ADDITIVE
INDEX ON modelo TAG modelo ASCENDING ADDITIVE
ENDPROC
PROCEDURE grabar
***********************************************
* Este método permite grabar los precios en la
* base de datos
***********************************************
LOCAL loCommand, lcSql, loRes1, loRes2, lnIdMarca
LOCAL loDT, loProg, lnCont
LOCAL lnProxID, lnIdSubFam, lcCodigo, lnPrLista
LOCAL lnPrVentaMax, lnPrVentaMin, lnPrFinalMax, lnPrFinalMin

loCommand = CREATEOBJECT("odbc_command")
loRes1 = CREATEOBJECT("odbc_result")
loRes2 = CREATEOBJECT("odbc_result")
loDT = CREATEOBJECT("datetime")
loProg = CREATEOBJECT("_thermometer")
lcSql = ""

lnProxID = 0
lnIdSubFam = 0
lcCodigo = ""
lnIdMarca = 0
lnPrLista = 0.00
lnPrVentaMax = 0.00
lnPrVentaMin = 0.00
lnPrFinalMax = 0.00
lnPrFinalMin = 0.00

SELECT cur_subfam
IF RECCOUNT("cur_subfam") > 0 THEN
	GO TOP
ENDIF

loProg.Show()

goConn.BeginTransaction()

SELECT cur_subfam
IF RECCOUNT("cur_subfam") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_subfam")
	lcSql = "SELECT idSubFam FROM subfam WHERE LTRIM(RTRIM(descripcio)) = '" + ALLTRIM(cur_subfam.descripcio) + "'"
	loRes1.ActiveConnection = goConn.ActiveConnection
	loRes1.Cursor_Name = "cur_tempo"
	
	IF !loRes1.OpenQuery(lcSql) THEN
		MESSAGEBOX(loRes1.Error_Message, 0+48, Thisform.Caption)
		RETURN .F.
	ENDIF
	
	SELECT cur_tempo
	IF RECCOUNT("cur_tempo") = 0 THEN	
		lnIdSubFam = goConn.GetNextID("subfam", "idSubFam")
		
		lcSql = "INSERT INTO subfam (idSubFam, descripcio, usuAlta, fecAlta, idHostAlta) VALUES ("
		lcSql = lcSql + ALLTRIM(STR(lnIdSubFam)) + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_subfam.descripcio) + "', "
		lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
		lcSql = lcSql + loDT.getDateTime() + ", "
		lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "')"
		
		loCommand.ActiveConnection = goConn.activeConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			RETURN .F.
		ENDIF
	ENDIF
	
	loRes1.Close_Query()
	
	SELECT cur_subfam
	SKIP
ENDDO

SELECT cur_arze
IF RECCOUNT("cur_arze") > 0 THEN
	GO TOP
ENDIF

lnCont = 0

DO WHILE !EOF("cur_arze")
	&& Busco la subfamilia que le corresponde al artículo
	lcSql = "SELECT * FROM subfam WHERE descripcio = '" + ALLTRIM(cur_arze.subfam) + "'"
	loRes1.ActiveConnection = goConn.ActiveConnection
	loRes1.Cursor_Name = "cur_sf"
	loRes1.OpenQuery(lcSql)
	
	SELECT cur_sf
	lnIdSubFam = cur_sf.idSubFam
	
	loRes1.Close_Query()
	
	lcCodigo = ALLTRIM(cur_arze.codigo)
	
	IF ALLTRIM(cur_arze.modelo) != "" THEN
		lcSql = "SELECT idmarca FROM marcas WHERE descripcio = '" + ALLTRIM(cur_arze.modelo) + "'"
		loRes1.ActiveConnection = goConn.ActiveConnection
		loRes1.Cursor_Name = "cur_mrc"
		loRes1.OpenQuery(lcSql)
		
		SELECT cur_mrc
		IF RECCOUNT("cur_mrc") > 0 THEN
			lnIdMarca = cur_mrc.idmarca
		ELSE
			lnIdMarca = goConn.GetNextID("marcas", "idmarca")
		
			lcSql = "INSERT INTO marcas ( "
			lcSql = lcSql + "idmarca, "
			lcSql = lcSql + "descripcio, "
			lcSql = lcSql + "usuAlta, "
			lcSql = lcSql + "fecAlta, "
			lcSql = lcSql + "idHostAlta) "
			lcSql = lcSql + "VALUES ( "
			lcSql = lcSql + ALLTRIM(STR(lnIdMarca)) + ", "
			lcSql = lcSql + "'" + ALLTRIM(cur_arze.modelo) + "', "
			lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
			lcSql = lcSql + loDT.getdatetime() + ", "
			lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "')"
			
			loCommand.ActiveConnection = goConn.ActiveConnection
			loCommand.CommandText = lcSql
			
			IF !loCommand.Execute() THEN
				goConn.Rollback()
				This.ErrorMessage = loCommand.ErrorMessage
				RETURN .F.
			ENDIF
		ENDIF
		
		loRes1.Close_Query()
	ELSE
		lnIdMarca = 1
	ENDIF
	
	lnPrLista = cur_arze.precio
	lnCostoRep = calcular_costo(lnPrLista, this.desc1, this.desc2, this.desc3, this.desc4, 0)
	lnPrVentaMax = lnCostoRep + (lnCostoRep * (this.margen_may / 100))
	lnPrVentaMin = lnCostoRep + (lnCostoRep * (this.margen_min / 100))
	lnPrFinalMax = lnPrVentaMax + (lnPrVentaMax * (this.alic_iva / 100))
	lnPrFinalMin = lnPrVentaMin + (lnPrVentaMin * (this.alic_iva / 100))	
	
	lcSql = "SELECT COUNT(*) AS cantReg FROM articulos WHERE codArt = '" + ALLTRIM(cur_arze.codigo) + "'"
	loRes1.ActiveConnection = goConn.ActiveConnection
	loRes1.Cursor_Name = "cur_tmp"
	IF !loRes1.OpenQuery(lcSql) THEN
		MESSAGEBOX(loRes1.Error_Message, 0+48, Thisform.Caption)
		goConn.Rollback()
		RETURN .F.
	ENDIF
	
	SELECT cur_tmp
	IF INT(VAL(ALLTRIM(cur_tmp.cantReg))) = 0 THEN
		lnProxID = goConn.GetNextID("articulos", "idArticulo")
	
		&& Agrego un nuevo registro
		lcSql = "INSERT INTO articulos ( "
		lcSql = lcSql + "	idArticulo, "
		lcSql = lcSql + "	idProv, "
		lcSql = lcSql + "	idFamilia, "
		lcSql = lcSql + "	idSubFam, "
		lcSql = lcSql + "	idMarca, "
		lcSql = lcSql + "	codArt, "
		lcSql = lcSql + "	descripcio, "
		lcSql = lcSql + "	alicIVA, "
		lcSql = lcSql + "	tmon, "
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
		lcSql = lcSql + "	prventaMax, "
		lcSql = lcSql + "	prventaMin, "
		lcSql = lcSql + "	prfinalMax, "
		lcSql = lcSql + "	prfinalMin, "
		lcSql = lcSql + "	observ, "
		lcSql = lcSql + "	idUniMed, "
		lcSql = lcSql + "	habilitado, "
		lcSql = lcSql + "	usuAlta, "
		lcSql = lcSql + "	fecAlta, "
		lcSql = lcSql + "	idHostAlta) "
		lcSql = lcSql + "VALUES ( "
		lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", "
		lcSql = lcSql + ALLTRIM(STR(This.idProv)) + ", "
		lcSql = lcSql + "1, " 											&& Familia
		lcSql = lcSql + ALLTRIM(STR(lnIdSubFam)) + ", "					&& SubFamilia
		lcSql = lcSql + ALLTRIM(STR(lnIdMarca)) + ", " 					&& Marca
		lcSql = lcSql + "'" + ALLTRIM(lcCodigo) + "', "
		lcSql = lcSql + "'" + ALLTRIM(STRTRAN(cur_arze.descripcio, "'"," ")) + "', "
		lcSql = lcSql + ALLTRIM(STR(This.alic_iva, 10, 2)) + ", "
		lcSql = lcSql + "'PSO', "
		lcSql = lcSql + "0, "											&& Precio de lista ext.
		lcSql = lcSql + "0, "											&& Cotización
		lcSql = lcSql + ALLTRIM(STR(lnPrLista, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(This.desc1, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(This.desc2, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(This.desc3, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(This.desc4, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnCostoRep, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(This.margen_may, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(This.margen_min, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnPrVentaMax, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnPrVentaMin, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnPrFinalMax, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnPrFinalMin, 10, 2)) + ", "
		lcSql = lcSql + "'', " 											&& Observ
		lcSql = lcSql + "1, "
		lcSql = lcSql + "1, "
		lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
		lcSql = lcSql + loDT.getDateTime() + ", "
		lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "')"		
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			RETURN .F.
		ENDIF
	ELSE
		&& En caso de existir el código, modifico el artículo
		lcSql = "UPDATE articulos "
		lcSql = lcSql + "SET 	prLista = " + ALLTRIM(STR(lnPrLista, 10, 2)) + ", "
		lcSql = lcSql + "		bonif1 = " + ALLTRIM(STR(This.desc1, 10, 2)) + ", "
		lcSql = lcSql + "		bonif2 = " + ALLTRIM(STR(This.desc2, 10, 2)) + ", "
		lcSql = lcSql + "		bonif3 = " + ALLTRIM(STR(This.desc3, 10, 2)) + ", "
		lcSql = lcSql + "		bonif4 = " + ALLTRIM(STR(This.desc4, 10, 2)) + ", "
		lcSql = lcSql + "		costoRep = " + ALLTRIM(STR(lnCostoRep, 10, 2)) + ", "
		lcSql = lcSql + "		margenMax = " + ALLTRIM(STR(This.margen_may, 10, 2)) + ", "
		lcSql = lcSql + "		margenMin = " + ALLTRIM(STR(This.margen_min, 10, 2)) + ", "
		lcSql = lcSql + "		prventaMax = " + ALLTRIM(STR(lnPrVentaMax, 10, 2)) + ", "
		lcSql = lcSql + "		prventaMin = " + ALLTRIM(STR(lnPrVentaMin, 10, 2)) + ", "
		lcSql = lcSql + "		prfinalMax = " + ALLTRIM(STR(lnPrFinalMax, 10, 2)) + ", "
		lcSql = lcSql + "		prfinalMin = " + ALLTRIM(STR(lnPrFinalMin, 10, 2)) + ", "
		lcSql = lcSql + "		alicIVA = " + ALLTRIM(STR(This.alic_iva, 10, 2)) + ", "
		lcSql = lcSql + "		usuModi = '" + ALLTRIM(gcCodUsu) + "', "
		lcSql = lcSql + "		fecModi = " + loDT.getdatetime() + ", "
		lcSql = lcSql + "		idHostModi = '" + ALLTRIM(SYS(0)) + "' "
		lcSql = lcSql + "WHERE codArt = '" + ALLTRIM(lcCodigo) + "'"
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			this.error_message = loCommand.ErrorMessage
			RETURN .F.
		ENDIF
	ENDIF

	lnCont = lnCont + 1
	loProg.update((lnCont * 100) / RECCOUNT("cur_arze"), "Actualizando precios de ARZE")
	SELECT cur_arze
	SKIP
ENDDO

goConn.Commit()
RETURN .T.
ENDPROC


************************************************************
OBJETO: actu_distrimar
************************************************************
*** PROPIEDADES ***
access_path = 
activeconnection = 
error_message = 
idprov = 0
desc1 = 0.00
desc2 = 0.00
desc3 = 0.00
desc4 = 0.00
alic_iva = 0.00
margen_may = 0.00
margen_min = 0.00
Name = "actu_distrimar"

*** METODOS ***
PROCEDURE procesar
IF !This.conectar() THEN
	RETURN .F.
ENDIF

This.ActiveConnection.BeginTransaction()

IF !This.actualizar_marcas() THEN
	This.ActiveConnection.Rollback()
	RETURN .F.
ENDIF

*!*	IF !This.actualizar_familias() THEN
*!*		This.ActiveConnection.RollBack()
*!*		RETURN .F.
*!*	ENDIF

IF !This.actualizar_articulos() THEN
	This.ActiveConnection.Rollback()
	RETURN .F.
ENDIF

This.ActiveConnection.Commit()

&&MESSAGEBOX("La actualización de la lista se realizó correctamente.", 0+64, thisform.Caption)

RETURN .T.
ENDPROC
PROCEDURE conectar
LOCAL lcStringConn

this.access_path = ALLTRIM(getglobalcfg("DIST_PATCH"))

lcStringConn = "Driver=Microsoft Access Driver (*.mdb);uid=admin;pwd=;DBQ=" + ALLTRIM(this.access_path)
This.ActiveConnection.ConnectionString = lcStringConn

IF !This.ActiveConnection.Open() THEN
	this.error_message = "No se puede conectar a distrimar.mdb"
	RETURN .F.
ENDIF

this.error_message = ""
RETURN .T.

ENDPROC
PROCEDURE actualizar_marcas
*****************************************************************************
* Este método permite actualizar las marcas de la base de DISTRIMAR
*****************************************************************************

LOCAL loCommand, loProv, lcSql, loMarcas, lnProxID
LOCAL loDT, loProg, lnCont, lcMarcas

loCommand = CREATEOBJECT("odbc_command")
loProv = CREATEOBJECT("odbc_result")
loMarcas = CREATEOBJECT("odbc_result")
loDT = CREATEOBJECT("datetime")
loProg = CREATEOBJECT("_thermometer")
lcSql = ""
lnCont = 0
lcMarcas = ALLTRIM(getglobalcfg("DISTRIMAR"))

loProg.show()

lcSql = "SELECT * FROM Proveedo WHERE prCodi IN (" + ALLTRIM(lcMarcas) + ")"
loProv.ActiveConnection = this.ActiveConnection.ActiveConnection
loProv.Cursor_Name = "cur_proveedor"
loProv.OpenQuery(lcSql)

SELECT cur_proveedor
DO WHILE !EOF("cur_proveedor")
	lcSql = "SELECT * FROM marcas WHERE LTRIM(RTRIM(descripcio)) = '" + ALLTRIM(cur_proveedor.prrazo) + "'"
	loMarcas.ActiveConnection = goConn.ActiveConnection
	loMarcas.Cursor_Name = "cur_tmp"
	loMarcas.OpenQuery(lcSql)
	
	SELECT cur_tmp
	IF RECCOUNT("cur_tmp") = 0 THEN
		lnProxID = goConn.GetNextID("marcas", "idmarca")
		lcSql = "INSERT INTO marcas (idmarca, descripcio, usuAlta, fecAlta, idHostAlta) VALUES ("
		lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", '" + ALLTRIM(cur_proveedor.prrazo) + "', "
		lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
		lcSql = lcSql + loDT.getDateTime() + ", "
		lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "')"
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			This.error_message = loCommand.ErrorMessage
			RETURN .F.
		ENDIF
	ENDIF
	
	loMarcas.Close_Query()
	
	SELECT cur_proveedor
	lnCont = lnCont + 1
	loProg.update((lnCont * 100) / RECCOUNT("cur_proveedor"), "Actualizando Marcas DISTRIMAR")
	SELECT cur_proveedor
	SKIP
ENDDO

loProv.Close_Query()
loProg.Complete()

RETURN .T.
ENDPROC
PROCEDURE actualizar_familias
*****************************************************************************
* Este método permite actualizar las subfamilias de la base de DISTRIMAR
*****************************************************************************

LOCAL loCommand, loFam, lcSql, loFamilias, lnProxID
LOCAL loDT, loProg, lnCont

loCommand = CREATEOBJECT("odbc_command")
loFam = CREATEOBJECT("odbc_result")
loFamilias = CREATEOBJECT("odbc_result")
loDT = CREATEOBJECT("datetime")
loProg = CREATEOBJECT("_thermometer")
lcSql = ""
lnCont = 0

lcSql = "SELECT * FROM Familias"
loFam.ActiveConnection = this.ActiveConnection.ActiveConnection
loFam.Cursor_Name = "cur_subfam"
loFam.OpenQuery(lcSql)

loProg.show()

SELECT cur_subfam
DO WHILE !EOF("cur_subfam")
	lcSql = "SELECT * FROM subfam WHERE LTRIM(RTRIM(descripcio)) = '" + ALLTRIM(cur_subfam.fadesc) + "'"
	loFamilias.ActiveConnection = goConn.ActiveConnection
	loFamilias.Cursor_Name = "cur_tmp"
	loFamilias.OpenQuery(lcSql)
	
	SELECT cur_tmp
	IF RECCOUNT("cur_tmp") = 0 THEN
		lnProxID = goConn.GetNextID("subfam", "idSubFam")
		lcSql = "INSERT INTO subfam (idSubFam, descripcio, usuAlta, fecAlta, idHostAlta) VALUES ("
		lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", '" + ALLTRIM(cur_subfam.fadesc) + "', "
		lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
		lcSql = lcSql + loDT.getDateTime() + ", "
		lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "')"
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			This.error_message = loCommand.ErrorMessage
			RETURN .F.
		ENDIF
	ENDIF
	
	loFamilias.Close_Query()
	
	SELECT cur_subfam
	lnCont = lnCont + 1
	loProg.update((lnCont * 100) / RECCOUNT("cur_subfam"), "Actualizando SubFamilias DISTRIMAR")
	SELECT cur_subfam
	SKIP
ENDDO

loFam.Close_Query()
loProg.Complete()

RETURN .T.
ENDPROC
PROCEDURE actualizar_articulos
***************************************************************************
* Actualizo los artículos
***************************************************************************
LOCAL loCommand, lcSql, loArticulos, loResult
LOCAL loDIS, loRes1
LOCAL loDT, loProg, lnCont, lnProxID, lnIdSubFam
LOCAL lnPrLista, lnCostoRep, lnPrVentaMax, lnPrVentaMin
LOCAL lnFinalMax, lnFinalMin, lcCodigo, lnIdMarca, lnIdFamilia, lcMarcas
LOCAL loRes, lnPrAnt, lnVariacion, lnIdArticulo

loCommand 	= CREATEOBJECT("odbc_command")
loArticulos = CREATEOBJECT("odbc_result")
loResult 	= CREATEOBJECT("odbc_result")
loDIS		= CREATEOBJECT("odbc_result")
loRes1		= CREATEOBJECT("odbc_result")
loDT 		= CREATEOBJECT("datetime")
loProg 		= CREATEOBJECT("_thermometer")
lcSql 		= ""
lnCont 		= 0
lnPrLista	= 0.00
lnCostoRep	= 0.00
lnPrVentaMax = 0.00
lnPrVentaMin = 0.00
lnFinalMax = 0.00
lnFinalMin = 0.00
lcCodigo 	= ""
lnProxID 	= 0
lnIdSubFam	= 58
lnIdMarca 	= 0
lnIdFamilia = 23
lcMarcas = ALLTRIM(getglobalcfg("DISTRIMAR"))
loRes = CREATEOBJECT("odbc_result")
lnPrAnt = 0.00
lnVariacion = 0.00
lnIdArticulo = 0

loProg.Show()

lcSql = "SELECT * FROM Articulo WHERE ArProv IN (" + lcMarcas + ")" + " AND ArArti <> ''"
loArticulos.ActiveConnection = this.activeconnection.ActiveConnection
loArticulos.Cursor_Name = "cur_Articulos"
loArticulos.OpenQuery(lcSql)

SELECT cur_Articulos
DO WHILE !EOF("cur_Articulos")
	* Busco el id de subrubro
*!*		lcSql = "SELECT * FROM Familias WHERE FaCodi = " + ALLTRIM(STR(cur_Articulos.ArFlia))
*!*		loDIS.ActiveConnection = This.ActiveConnection.ActiveConnection
*!*		loDIS.Cursor_Name = "cur_sf"
*!*		loDIS.OpenQuery(lcSql)
*!*		
*!*		lcSql = "SELECT * FROM subfam WHERE descripcio = '" + ALLTRIM(cur_sf.FaDesc) + "'"
*!*		loRes1.ActiveConnection = goConn.ActiveConnection
*!*		loRes1.Cursor_Name = "cur_subfam"
*!*		loRes1.OpenQuery(lcSql)
*!*		
*!*		SELECT cur_subfam
*!*		IF RECCOUNT("cur_subfam") > 0 THEN
*!*			lnIdSubFam = cur_subfam.idSubFam
*!*		ENDIF
*!*		
*!*		loDIS.Close_Query()
*!*		loRes1.Close_Query()
	
	lcSql = "SELECT * FROM Proveedo WHERE PrCodi = " + ALLTRIM(STR(cur_Articulos.ArProv))
	loDIS.ActiveConnection = This.ActiveConnection.ActiveConnection
	loDIS.Cursor_Name = "cur_prov"
	loDIS.OpenQuery(lcSql)
	
	SELECT cur_prov
	lcSql = "SELECT * FROM Marcas WHERE descripcio = '" + ALLTRIM(cur_prov.PrRazo) + "'"
	loRes1.Cursor_Name = "cur_marca"
	loRes1.ActiveConnection = goConn.ActiveConnection
	loRes1.OpenQuery(lcSql)
	
	SELECT cur_marca
	IF RECCOUNT("cur_marca") > 0 THEN
		lnIdMarca = cur_marca.idMarca
	ELSE
		MESSAGEBOX("La Marca " + ALLTRIM(cur_prov.PrRazo) + " no existe.", 0+48, thisform.Caption)
		loDIS.Close_Query()
		loRes1.Close_Query()
		loArticulos.Close_Query()
		RETURN .F.
	ENDIF
	
	loDIS.Close_Query()
	loRes1.Close_Query()
	
	&&lcCodigo = "DIS" + ALLTRIM(cur_Articulos.ArArti)
	lcCodigo = ALLTRIM(cur_Articulos.ArArti)

	&&lcSql = "SELECT * FROM articulos WHERE codArt = '" + lcCodigo + "' AND idSubFam = " + ALLTRIM(STR(lnIdSubFam))
	lcSql = "SELECT * FROM articulos WHERE codArt = '" + lcCodigo + "'"
	loResult.ActiveConnection = goConn.ActiveConnection
	loResult.Cursor_Name = "cur_tmp"
	loResult.OpenQuery(lcSql)
	
	SELECT cur_tmp
	IF RECCOUNT("cur_tmp") = 0 THEN
		lnProxID = goConn.GetNextID("articulos", "idArticulo")
		
		* Calculo el precio de venta
		lnPrLista = cur_Articulos.AROO
		lnCostoRep = calcular_costo(lnPrLista, this.desc1, this.desc2, this.desc3, this.desc4, 0)
		lnPrVentaMax = lnCostoRep + (lnCostoRep * (this.margen_may / 100))
		lnPrVentaMin = lnCostoRep + (lnCostoRep * (this.margen_min / 100))
		lnFinalMax = lnPrVentaMax + (lnPrVentaMax * (this.alic_iva / 100))
		lnFinalMin = lnPrVentaMin + (lnPrVentaMin * (this.alic_iva / 100))		
		
		lcSql = "INSERT INTO articulos ( "
		lcSql = lcSql + "	idArticulo, "
		lcSql = lcSql + "	idProv, "
		lcSql = lcSql + "	idFamilia, "
		lcSql = lcSql + "	idSubFam, "
		lcSql = lcSql + "	idMarca, "
		lcSql = lcSql + "	codArt, "
		lcSql = lcSql + "	descripcio, "
		lcSql = lcSql + "	alicIVA, "
		lcSql = lcSql + "	tmon, "
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
		lcSql = lcSql + "	prventaMax, "
		lcSql = lcSql + "	prventaMin, "
		lcSql = lcSql + "	prfinalMax, "
		lcSql = lcSql + "	prfinalMin, "
		lcSql = lcSql + "	observ, "
		lcSql = lcSql + "	idUniMed, "
		lcSql = lcSql + "	habilitado, "
		lcSql = lcSql + "	usuAlta, "
		lcSql = lcSql + "	fecAlta, "
		lcSql = lcSql + "	idHostAlta) "
		lcSql = lcSql + "VALUES ( "
		lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", "
		lcSql = lcSql + ALLTRIM(STR(This.idProv)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnIdFamilia)) + ", "				&& Familia
		lcSql = lcSql + ALLTRIM(STR(lnIdSubFam)) + ", "					&& SubFamilia
		lcSql = lcSql + ALLTRIM(STR(lnIdMarca)) + ", " 					&& Marca
		lcSql = lcSql + "'" + UPPER(SUBSTR(ALLTRIM(lcCodigo),1,20)) + "', "
		lcSql = lcSql + "'" + UPPER(SUBSTR(ALLTRIM(STRTRAN(STRTRAN(cur_Articulos.ArMode, "'", " "), "\", " ")),1,200)) + "', "
		lcSql = lcSql + ALLTRIM(STR(This.alic_iva, 10, 2)) + ", "
		lcSql = lcSql + "'PSO', "
		lcSql = lcSql + "0, "											&& Precio de lista ext.
		lcSql = lcSql + "0, "											&& Cotización
		lcSql = lcSql + ALLTRIM(STR(lnPrLista, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(This.desc1, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(This.desc2, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(This.desc3, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(This.desc4, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnCostoRep, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(This.margen_may, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(This.margen_min, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnPrVentaMax, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnPrVentaMin, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnFinalMax, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnFinalMin, 10, 2)) + ", "
		lcSql = lcSql + "'" + UPPER(ALLTRIM(cur_Articulos.ArObse)) + "', " && Observ
		lcSql = lcSql + "1, "
		lcSql = lcSql + "1, "
		lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
		lcSql = lcSql + loDT.getDateTime() + ", "
		lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "')"
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			This.error_message = loCommand.ErrorMessage
			RETURN .F.
		ENDIF
	ELSE
		* Calculo el precio de venta
		lnPrLista = cur_Articulos.AROO

		lcSql = "select idArticulo, prLista from articulos where codArt = '" + ALLTRIM(lcCodigo) + "'"
		loRes.ActiveConnection = goConn.ActiveConnection
		loRes.cursor_name = "tempo"
		
		IF !loRes.OpenQuery(lcSql) THEN
			this.ErrorMessage = loRes.Error_Message
			RETURN .F.
		ENDIF
		
		lnIdArticulo = tempo.idArticulo
		lnPrAnt = tempo.prLista
		lnVariacion = (1 - (lnPrAnt / lnPrLista)) * 100
		
		loRes.Close_Query()
		
		IF lnVariacion <> 0 THEN
			lnCostoRep = calcular_costo(lnPrLista, ;
				IIF(this.desc1 = 0, cur_tmp.bonif1, this.desc1),; 
				IIF(this.desc2 = 0, cur_tmp.bonif2, this.desc2),; 
				IIF(this.desc3 = 0, cur_tmp.bonif3, this.desc3),; 
				IIF(this.desc4 = 0, cur_tmp.bonif4, this.desc4), 0)
				
			this.margen_may = IIF(this.margen_may = 0, cur_tmp.margenMax, this.margen_may)
			this.margen_min = IIF(this.margen_min = 0, cur_tmp.margenMin, this.margen_min)
				
			lnPrVentaMax = lnCostoRep + (lnCostoRep * (this.margen_may / 100))
			lnPrVentaMin = lnCostoRep + (lnCostoRep * (this.margen_min / 100))
			lnFinalMax = lnPrVentaMax + (lnPrVentaMax * (this.alic_iva / 100))
			lnFinalMin = lnPrVentaMin + (lnPrVentaMin * (this.alic_iva / 100))	
		
			&& En caso de existir el código, modifico el artículo
			lcSql = "UPDATE articulos "
			lcSql = lcSql + "SET 	prLista = " + ALLTRIM(STR(lnPrLista, 10, 2)) + ", "
			lcSql = lcSql + "		bonif1 = " + ALLTRIM(STR(This.desc1, 10, 2)) + ", "
			lcSql = lcSql + "		bonif2 = " + ALLTRIM(STR(This.desc2, 10, 2)) + ", "
			lcSql = lcSql + "		bonif3 = " + ALLTRIM(STR(This.desc3, 10, 2)) + ", "
			lcSql = lcSql + "		bonif4 = " + ALLTRIM(STR(This.desc4, 10, 2)) + ", "
			lcSql = lcSql + "		costoRep = " + ALLTRIM(STR(lnCostoRep, 10, 2)) + ", "
			lcSql = lcSql + "		margenMax = " + ALLTRIM(STR(This.margen_may, 10, 2)) + ", "
			lcSql = lcSql + "		margenMin = " + ALLTRIM(STR(This.margen_min, 10, 2)) + ", "
			lcSql = lcSql + "		prventaMax = " + ALLTRIM(STR(lnPrVentaMax, 10, 2)) + ", "
			lcSql = lcSql + "		prventaMin = " + ALLTRIM(STR(lnPrVentaMin, 10, 2)) + ", "
			lcSql = lcSql + "		prfinalMax = " + ALLTRIM(STR(lnFinalMax, 10, 2)) + ", "
			lcSql = lcSql + "		prfinalMin = " + ALLTRIM(STR(lnFinalMin, 10, 2)) + ", "
			lcSql = lcSql + "		usuModi = '" + ALLTRIM(gcCodUsu) + "', "
			lcSql = lcSql + "		fecModi = " + loDT.getdatetime() + ", "
			lcSql = lcSql + "		idHostModi = '" + ALLTRIM(SYS(0)) + "' "
			&&lcSql = lcSql + "WHERE codArt = '" + ALLTRIM(lcCodigo) + "' AND idSubFam = " + ALLTRIM(STR(lnIdSubFam))
			lcSql = lcSql + "WHERE codArt = '" + ALLTRIM(lcCodigo) + "'"
			loCommand.ActiveConnection = goConn.ActiveConnection
			loCommand.CommandText = lcSql
			
			IF !loCommand.Execute() THEN
				this.error_message = loCommand.ErrorMessage
				RETURN .F.
			ENDIF	

			&& Agrego el insert que permite registrar los cambios de precios de los artículos
			lnProxID = goConn.GetNextID("art_cbios", "idArtCbios")
			
			lcSql = "insert into art_cbios ( "
			lcSql = lcSql + "idArtCbios, idArticulo, fecha, prAnt, prNuevo, porVar) values ("
			lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", "
			lcSql = lcSql + ALLTRIM(STR(lnIdArticulo)) + ", "
			lcSql = lcSql + "current_timestamp, "
			lcSql = lcSql + ALLTRIM(STR(lnPrAnt, 10, 2)) + ", "
			lcSql = lcSql + ALLTRIM(STR(lnPrLista, 10, 2)) + ", "
			lcSql = lcSql + ALLTRIM(STR(lnVariacion, 10, 2)) + ") "
			
			loCommand.ActiveConnection = goConn.ActiveConnection
			loCommand.CommandText = lcSql
			
			IF !loCommand.Execute() THEN
				this.ErrorMessage = loCommand.ErrorMessage
				goConn.Rollback()
				RETURN .F.
			ENDIF			
		ENDIF	
	ENDIF
	
	loResult.Close_Query()

	SELECT cur_Articulos
	lnCont = lnCont + 1
	loProg.Update((lnCont * 100) / RECCOUNT("cur_Articulos"), "Actualizando Precios")
	SELECT cur_Articulos
	SKIP
ENDDO

loArticulos.Close_Query()
loProg.Complete()

RETURN .T.


ENDPROC
PROCEDURE Init
this.activeconnection = CREATEOBJECT("odbc_connect")

ENDPROC


************************************************************
OBJETO: actu_sisurbana
************************************************************
*** PROPIEDADES ***
path_db = 
errormessage = 
idprov = 0
dto1 = 0.00
dto2 = 0.00
dto3 = 0.00
dto4 = 0.00
rentab1 = 0.00
rentab2 = 0.00
aliciva = 21
Name = "actu_sisurbana"

*** METODOS ***
PROCEDURE grabar
***************************************************
* Grabo los datos de los artículos
***************************************************

LOCAL loResult, loCommand, lcSql
LOCAL loProg, lnIdMarca, lnIdSubFam, lnIdFamilia
LOCAL lcCodArt, lnPrLista, lnBonif1, lnBonif2, lnBonif3, lnBonif4
LOCAL lnCostoRep, lnRentab1, lnRentab2, lnPrVentaMax, lnPrVentaMin
LOCAL lnPrFinalMax, lnPrFinalMin, lnAlicIVA, lnIdArticulo
LOCAL loRes, lnProxID, lnPrAnt, lnVariacion

loResult = CREATEOBJECT("odbc_result")
loCommand = CREATEOBJECT("odbc_command")
loProg = CREATEOBJECT("_thermometer")
loRes = CREATEOBJECT("odbc_result")
lnProxID = 0
lnPrAnt = 0
lnVariacion = 0

lnIdMarca = 0
lnIdSubFam = 0
lnIdFamilia = 8 &&=> Le dejo la familia ELECTRICIDAD como fija
lcCodArt = ""
lnPrLista = 0.00
lnBonif1 = 0.00
lnBonif2 = 0.00
lnBonif3 = 0.00
lnBonif4 = 0.00
lnCostoRep = 0.00
lnRentab1 = 0.00
lnRentab2 = 0.00
lnPrVentaMax = 0.00
lnPrVentaMin = 0.00
lnPrFinalMax = 0.00
lnPrFinalMin = 0.00
lnAlicIVA = 0.00
lnIdArticulo = 0

loProg.show()

SELECT cur_articulos
IF RECCOUNT("cur_articulos") > 0 THEN	
	GO TOP
ENDIF

DO WHILE !EOF("cur_articulos")	
	goConn.BeginTransaction()

	lcSql = "SELECT * FROM marcas WHERE descripcio = '" + ALLTRIM(cur_articulos.nombreline) + "'"
	loResult.ActiveConnection = goConn.ActiveConnection
	loResult.Cursor_Name = "cur_x"
	
	IF !loResult.OpenQuery(lcSql) THEN
		this.errorMessage = loResult.Error_Message
		goConn.rollback()
		RETURN .F.
	ENDIF
	
	IF RECCOUNT("cur_x") = 0 THEN
		lnIdMarca = goConn.GetNextID("marcas", "idMarca")
		
		lcSql = "insert into marcas ("
		lcSql = lcSql + "idMarca, "
		lcSql = lcSql + "descripcio, "
		lcSql = lcSql + "usuAlta, "
		lcSql = lcSql + "fecAlta, "
		lcSql = lcSql + "idHostAlta) "
		lcSql = lcSql + "VALUES ( "
		lcSql = lcSql + ALLTRIM(STR(lnIdMarca)) + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_articulos.nombreLine) + "', "
		lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
		lcSql = lcSql + "current_timestamp, "
		lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "')"
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			this.errorMessage = loCommand.ErrorMessage
			goConn.rollback()
			RETURN .F.
		ENDIF
	ELSE
		lnIdMarca = cur_x.idMarca
	ENDIF
	
	loResult.Close_Query()
	
	lcSql = "select * from subfam where descripcio = '" + ALLTRIM(cur_articulos.nombrerubr) + "'"
	loResult.ActiveConnection = goConn.ActiveConnection
	loResult.Cursor_Name = "cur_x"
	
	IF !loResult.OpenQuery(lcSql) THEN
		this.errorMessage = loResult.Error_Message
		goConn.rollback()
		RETURN .F.
	ENDIF
	
	SELECT cur_x
	IF RECCOUNT("cur_x") = 0 THEN
		lnIdSubFam = goConn.GetNextID("subfam", "idSubFam")
		
		lcSql = "insert into subfam ( "
		lcSql = lcSql + "idSubFAm, "
		lcSql = lcSql + "descripcio, "
		lcSql = lcSql + "usuAlta, "
		lcSql = lcSql + "fecAlta, "
		lcSql = lcSql + "idHostAlta) "
		lcSql = lcSql + "VALUES ( "
		lcSql = lcSql + ALLTRIM(STR(lnIdSubFam)) + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_articulos.nombrerubr) + "', "
		lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
		lcSql = lcSql + "current_timestamp, "
		lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "')"
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			this.errorMessage = loCommand.ErrorMessage
			goConn.rollback()
			RETURN .F.
		ENDIF
	ELSE
		lnIdSubFam = cur_x.idSubFam
	ENDIF
	
	loResult.Close_Query()
	
	&& Ahora cargo los artículos
	lcCodArt = STRTRAN(cur_articulos.codigo, " ", "") + "URB"
	
	lcSql = "select * from articulos where codart = '" + ALLTRIM(lcCodArt) + "'"
	loResult.ActiveConnection = goConn.ActiveConnection
	loResult.Cursor_Name = "cur_x"
	
	IF !loResult.OpenQuery(lcSql) THEN
		this.errorMessage = loResult.Error_Message
		goConn.rollback()
		RETURN .F.
	ENDIF
	
	lnPrLista = cur_articulos.precio
	lnAlicIVA = this.aliciva
	
	IF RECCOUNT("cur_x") = 0 THEN
		lnIdArticulo = goConn.GetNextID("articulos", "idArticulo")
		
		lnBonif1 = this.dto1
		lnBonif2 = this.dto2
		lnBonif3 = this.dto3
		lnBonif4 = this.dto4	
		lnRentab1 = this.rentab1
		lnRentab2 = this.rentab2	
		
		&& A continuación hago los cálculos de los precios
		lnCostoRep = calcular_costo(lnPrLista, lnBonif1, lnBonif2, lnBonif3, lnBonif4, 0)
		lnPrVentaMax = lnCostoRep + (lnCostoRep * (lnRentab1 / 100))
		lnPrVentaMin = lnCostoRep + (lnCostoRep * (lnRentab2 / 100))
		lnPrFinalMax = lnPrVentaMax + (lnPrVentaMax * (lnAlicIVA / 100))
		lnPrFinalMin = lnPrVentaMin + (lnPrVentaMin * (lnAlicIVA / 100))
	
		lcSql = "insert into articulos ("
		lcSql = lcSql + "idArticulo, "
		lcSql = lcSql + "idProv, "
		lcSql = lcSql + "idFamilia, "
		lcSql = lcSql + "idSubFam, "
		lcSql = lcSql + "idMarca, "
		lcSql = lcSql + "codArt, "
		lcSql = lcSql + "descripcio, "
		lcSql = lcSql + "alicIVA, "
		lcSql = lcSql + "tmon, "
		lcSql = lcSql + "prListaExt, "
		lcSql = lcSql + "cotizac, "
		lcSql = lcSql + "prLista, "
		lcSql = lcSql + "bonif1, "
		lcSql = lcSql + "bonif2, "
		lcSql = lcSql + "bonif3, "
		lcSql = lcSql + "bonif4, "
		lcSql = lcSql + "costoRep, "
		lcSql = lcSql + "margenMax, "
		lcSql = lcSql + "margenMin, "
		lcSql = lcSql + "prventaMax, "
		lcSql = lcSql + "prventaMin, "
		lcSql = lcSql + "prfinalMax, "
		lcSql = lcSql + "prfinalMin, "
		lcSql = lcSql + "observ, "
		lcSql = lcSql + "idUniMed, "
		lcSql = lcSql + "habilitado, "
		lcSql = lcSql + "usuAlta, "
		lcSql = lcSql + "fecAlta, "
		lcSql = lcSql + "idHostAlta) "
		lcSql = lcSql + "values ( "
		lcSql = lcSql + ALLTRIM(STR(lnIdArticulo)) + ", "
		lcSql = lcSql + ALLTRIM(STR(this.idprov)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnIdFamilia)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnIdSubFam)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnIdMarca)) + ", "
		lcSql = lcSql + "'" + ALLTRIM(lcCodArt) + "', "
		lcSql = lcSql + "'" + ALLTRIM(cur_articulos.descripcio) + "', "
		lcSql = lcSql + ALLTRIM(STR(lnAlicIVA, 10, 2)) + ", "
		lcSql = lcSql + "'PSO', "
		lcSql = lcSql + "0, "
		lcSql = lcSql + "0, "
		lcSql = lcSql + ALLTRIM(STR(lnPrLista, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnBonif1, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnBonif2, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnBonif3, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnBonif4, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnCostoRep, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnRentab1, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnRentab2, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnPrVentaMax, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnPrVentaMin, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnPrFinalMax, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnPrFinalMin, 10, 2)) + ", "
		lcSql = lcSql + "'', "
		lcSql = lcSql + "1, "
		lcSql = lcSql + "1, "
		lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
		lcSql = lcSql + "current_timestamp, "
		lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "')"
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql

		IF !loCommand.Execute() THEN
			this.errorMessage = loCommand.ErrorMessage
			goConn.rollback()
			RETURN .F.
		ENDIF
		
		&& Agrego el registro al codiart
		lcSql = "insert into codiArt ( "
		lcSql = lcSql + "	idCodArt, "
		lcSql = lcSql + "	idArticulo, "
		lcSql = lcSql + "	codArt, "
		lcSql = lcSql + "	codigos, "
		lcSql = lcSql + "	tipo, "
		lcSql = lcSQl + "	cantiDesp, "
		lcSql = lcSql + "	procesado, "
		lcSql = lcSql + "	circuito) "
		lcSql = lcSql + "values ( "
		lcSql = lcSql + ALLTRIM(STR(goConn.GetNextID("codiArt", "idCodArt"))) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnIdArticulo)) + ", "
		lcSql = lcSql + "'" + ALLTRIM(lcCodArt) + "', "
		lcSql = lcSql + "'" + ALLTRIM(lcCodArt) + "', "
		lcSql = lcSql + "'CP', "
		lcSql = lcSql + "1, "
		lcSql = lcSql + "0, "
		lcSql = lcSql + "'CV')"
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			this.errorMessage = loCommand.ErrorMessage
			goConn.rollback()
			RETURN .F.
		ENDIF
	ELSE
		IF lnPrLista <> 0 THEN	
			lnIdArticulo = cur_x.idArticulo		
			lnPrAnt = cur_x.prLista
			* lnVariacion = ROUND((1 - (lnPrAnt / lnPrLista)) * 100, 2)
			IF lnPrAnt <> 0 THEN
				lnVariacion = ((lnPrLista - lnPrAnt) / lnPrAnt) * 100
			ELSE
				lnVariacion = 0
			ENDIF
			
			IF lnVariacion <> 0 THEN
				lnBonif1 = IIF(this.dto1 = 0, cur_x.bonif1, this.dto1)
				lnBonif2 = IIF(this.dto2 = 0, cur_x.bonif2, this.dto2)
				lnBonif3 = IIF(this.dto3 = 0, cur_x.bonif3, this.dto3)
				lnBonif4 = IIF(this.dto4 = 0, cur_x.bonif4, this.dto4)
				
				lnRentab1 = IIF(this.rentab1 = 0, cur_x.margenMax, this.rentab1)
				lnRentab2 = IIF(this.rentab2 = 0, cur_x.margenMin, this.rentab2)		
						
				&& A continuación hago los cálculos de los precios
				lnCostoRep = calcular_costo(lnPrLista, lnBonif1, lnBonif2, lnBonif3, lnBonif4, 0)
				lnPrVentaMax = lnCostoRep + (lnCostoRep * (lnRentab1 / 100))
				lnPrVentaMin = lnCostoRep + (lnCostoRep * (lnRentab2 / 100))
				lnPrFinalMax = lnPrVentaMax + (lnPrVentaMax * (lnAlicIVA / 100))
				lnPrFinalMin = lnPrVentaMin + (lnPrVentaMin * (lnAlicIVA / 100))
				
				lcSql = "update articulos "
				lcSql = lcSql + "set alicIVA = " + ALLTRIM(STR(lnAlicIVA, 10, 2)) + ", "
				lcSql = lcSql + "	prLista = " + ALLTRIM(STR(lnPrLista, 10, 2)) + ", "
				lcSql = lcSql + "	bonif1 = " + ALLTRIM(STR(lnBonif1, 10, 2)) + ", "
				lcSql = lcSql + "	bonif2 = " + ALLTRIM(STR(lnBonif2, 10, 2)) + ", "
				lcSql = lcSql + "	bonif3 = " + ALLTRIM(STR(lnBonif3, 10, 2)) + ", "
				lcSql = lcSql + "	bonif4 = " + ALLTRIM(STR(lnBonif4, 10, 2)) + ", "
				lcSql = lcSql + "	costoRep = " + ALLTRIM(STR(lnCostoRep, 10, 2)) + ", "
				lcSql = lcSql + "	margenMax = " + ALLTRIM(STR(lnRentab1, 10, 2)) + ", "
				lcSql = lcSql + "	margenMin = " + ALLTRIM(STR(lnRentab2, 10, 2)) + ", "
				lcSql = lcSql + "	prventaMax = " + ALLTRIM(STR(lnPrVentaMax, 10, 2)) + ", "
				lcSql = lcSql + "	prventaMin = " + ALLTRIM(STR(lnPrVentaMin, 10, 2)) + ", "
				lcSql = lcSql + "	prfinalMax = " + ALLTRIM(STR(lnPrFinalMax, 10, 2)) + ", "
				lcSql = lcSql + "	prfinalMin = " + ALLTRIM(STR(lnPrFinalMin, 10, 2)) + ", "
				lcSql = lcSql + "	observ = '', "
				lcSql = lcSql + "	habilitado = 1, "
				lcSql = lcSql + "	usuAlta = '" + ALLTRIM(gcCodUsu) + "', "
				lcSql = lcSql + "	fecAlta = current_timestamp, "
				lcSql = lcSql + "	idHostAlta = '" + ALLTRIM(SYS(0)) + "' "
				lcSql = lcSql + "where idArticulo = " + ALLTRIM(STR(lnIdArticulo))
				
				loCommand.ActiveConnection = goConn.ActiveConnection
				loCommand.CommandText = lcSql

				IF !loCommand.Execute() THEN
					this.errorMessage = loCommand.ErrorMessage
					goConn.rollback()
					RETURN .F.
				ENDIF				
			
				&& Agrego el insert que permite registrar los cambios de precios de los artículos
				lnProxID = goConn.GetNextID("art_cbios", "idArtCbios")
				
				lcSql = "insert into art_cbios ( "
				lcSql = lcSql + "idArtCbios, idArticulo, fecha, prAnt, prNuevo, porVar) values ("
				lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", "
				lcSql = lcSql + ALLTRIM(STR(lnIdArticulo)) + ", "
				lcSql = lcSql + "current_timestamp, "
				lcSql = lcSql + ALLTRIM(STR(lnPrAnt, 10, 2)) + ", "
				lcSql = lcSql + ALLTRIM(STR(lnPrLista, 10, 2)) + ", "
				lcSql = lcSql + ALLTRIM(STR(lnVariacion, 10, 2)) + ") "
				
				loCommand.ActiveConnection = goConn.ActiveConnection
				loCommand.CommandText = lcSql
				
				IF !loCommand.Execute() THEN
					this.ErrorMessage = loCommand.ErrorMessage
					goConn.Rollback()
					RETURN .F.
				ENDIF		
			ENDIF
		ENDIF
	ENDIF

	loResult.Close_Query()
	goConn.commit()
	
	WAIT WINDOW "Procesando " + ALLTRIM(STR(RECNO("cur_articulos"))) + " de " + ALLTRIM(STR(RECCOUNT("cur_articulos"))) NOWAIT
	loProg.update((RECNO("cur_articulos") * 100) / RECCOUNT("cur_articulos"), "Actualizando artículos")
	
	SELECT cur_articulos
	SKIP
ENDDO

loProg.Complete()

RETURN .T.
ENDPROC
PROCEDURE crear_cursor
**********************************************************************
* Este método crear el cursor que tiene el formato correspondiente al
* sisurbana
**********************************************************************

CREATE CURSOR cur_articulos( ;
	codigoline	int,;
	nombreline	varchar(30),;
	codigorubr	int,;
	nombrerubr	varchar(35),;
	codigo		varchar(20),;
	descripcio	varchar(150),;
	precio		float(10, 2),;
	dto			float(10, 2))
ENDPROC
PROCEDURE leer_articulos
LOCAL lcPath, loProg

lcPath = getglobalcfg("SISUR_DB")
loProg = CREATEOBJECT("_thermometer")

loProg.show()

SET PATH TO (lcPath) ADDITIVE

select	*;
from	listaprecios ;
into CURSOR cur_tempo

SELECT cur_tempo
DO WHILE !EOF("cur_tempo")
	SELECT cur_articulos
	APPEND BLANK
	REPLACE cur_articulos.codigoline WITH INT(VAL(cur_tempo.codigoline))
	REPLACE cur_articulos.nombreline WITH ALLTRIM(cur_tempo.nombreline) ADDITIVE
	REPLACE cur_articulos.codigorubr WITH INT(VAL(cur_tempo.codigorubr)) ADDITIVE
	REPLACE cur_articulos.nombrerubr WITH ALLTRIM(cur_tempo.nombrerubr) ADDITIVE
	REPLACE cur_articulos.codigo WITH ALLTRIM(cur_tempo.codigo) ADDITIVE
	REPLACE cur_articulos.descripcio WITH ALLTRIM(cur_tempo.descripcio) ADDITIVE
	REPLACE cur_articulos.precio WITH cur_tempo.precio ADDITIVE
	REPLACE cur_articulos.dto WITH cur_tempo.dto ADDITIVE

	loProg.update((RECNO("cur_tempo") * 100) / RECCOUNT("cur_tempo"), "Leyendo artículos...")
	SELECT cur_tempo
	SKIP 
ENDDO

loProg.complete()

USE IN cur_tempo
ENDPROC


************************************************************
OBJETO: cls_xls_sheet_config
************************************************************
*** PROPIEDADES ***
DataSession = 1
BorderStyle = 2
Height = 421
Width = 773
DoCreate = .T.
Caption = "Definición de hojas"
idhoja = 0
press_aceptar = .F.
idplanilla = 0
isedit = .F.
idtabla = 0
Name = "cls_xls_sheet_config"

*** METODOS ***
PROCEDURE Activate
IF Thisform.isEdit THEN
	SELECT tablas
	Thisform.txtTableName.Value = tablas.tableName
	Thisform.txtNroFilaDD.Value = tablas.nFilaDD
	Thisform.txtNroFilaHH.Value = tablas.nFilaHH
ENDIF
ENDPROC
PROCEDURE Init

&& Configuro la grilla correspondiente a a las columnas
SELECT columnas
GO TOP
Thisform.grdColumnas.alias_name = "columnas"
Thisform.grdColumnas.RecordSource = "columnas"
Thisform.grdColumnas.list_controlsource = "fieldName,dataType,nroColRef"
Thisform.grdColumnas.lista_ancho_cols = "200,70,70"
Thisform.grdColumnas.titulos_cabeceras = "Campo,Tipo Dato,Nº Columna"
Thisform.grdColumnas.generar_grid()

Thisform.grdColumnas.Columns[3].ReadOnly = .F.

&& Cargo las opciones del combo datatype
Thisform.cmbTipoDato.AddItem("C")
Thisform.cmbTipoDato.AddItem("N")

Thisform.cmbTipoDato.ListIndex = 1

ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Tabla:"
Height = 15
Left = 24
Top = 21
Width = 48
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Nro. Fila Desde:"
Height = 15
Left = 226
Top = 21
Width = 91
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Nro. Fila Hasta:"
Height = 15
Left = 403
Top = 21
Width = 91
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: txtTableName
************************************************************
*** PROPIEDADES ***
Format = ""
Height = 21
Left = 61
Top = 16
Width = 161
ischaracter = .T.
Name = "txtTableName"

*** METODOS ***


************************************************************
OBJETO: txtNroFilaDD
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 316
Top = 16
Width = 75
isinteger = .T.
Name = "txtNroFilaDD"

*** METODOS ***


************************************************************
OBJETO: txtNroFilaHH
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 487
Top = 16
Width = 75
isinteger = .T.
Name = "txtNroFilaHH"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Nombre Campo:"
Height = 15
Left = 36
Top = 73
Width = 96
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: txtNombreCampo
************************************************************
*** PROPIEDADES ***
Format = ""
Height = 21
Left = 132
Top = 69
Width = 195
ischaracter = .T.
Name = "txtNombreCampo"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Tipo de Datos:"
Height = 15
Left = 333
Top = 73
Width = 87
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: cmbTipoDato
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 415
Top = 69
Width = 60
Name = "cmbTipoDato"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta6
************************************************************
*** PROPIEDADES ***
Caption = "Nro. Col. Ref.:"
Height = 15
Left = 485
Top = 73
Width = 79
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: txtNroColRef
************************************************************
*** PROPIEDADES ***
Alignment = 0
Height = 21
Left = 565
Top = 69
Width = 49
isinteger = .T.
Name = "txtNroColRef"

*** METODOS ***


************************************************************
OBJETO: btnAgregarCampo
************************************************************
*** PROPIEDADES ***
Top = 54
Left = 625
Height = 37
Width = 40
ToolTipText = "Agregar Campo"
Name = "btnAgregarCampo"

*** METODOS ***
PROCEDURE Click
IF ALLTRIM(Thisform.txtNombreCampo.Value) == "" THEN
	MESSAGEBOX("Debe ingresar el nombre de la columna", 0+48, Thisform.Caption)
	Thisform.txtNombreCampo.SetFocus()
	RETURN
ENDIF

IF Thisform.txtNroColRef.Value = 0 THEN
	MESSAGEBOX("El número de columna de referencia no puede ser 0 (cero)", 0+48, Thisform.Caption)
	Thisform.txtNroColRef.SetFocus()
	RETURN
ENDIF

SELECT columnas
APPEND BLANK
REPLACE columnas.idColumna WITH RECCOUNT("columnas") + 1
REPLACE columnas.idTabla WITH IIF(Thisform.isEdit, Thisform.idTabla, 0) ADDITIVE
REPLACE columnas.fieldName WITH ALLTRIM(Thisform.txtNombreCampo.Value) ADDITIVE
REPLACE columnas.dataType WITH ALLTRIM(Thisform.cmbTipoDato.Value) ADDITIVE
REPLACE columnas.nroColRef WITH Thisform.txtNroColref.Value ADDITIVE
REPLACE columnas.insertar WITH .T. ADDITIVE
REPLACE columnas.modificar WITH .F. ADDITIVE
REPLACE columnas.eliminar WITH .F. ADDITIVE

SELECT columnas
GO TOP
Thisform.grdColumnas.Refresh()
Thisform.txtNombreCampo.blanquear()
Thisform.txtNroColRef.blanquear()
Thisform.txtNombreCampo.SetFocus()

ENDPROC


************************************************************
OBJETO: btnEliminarCampo
************************************************************
*** PROPIEDADES ***
Top = 53
Left = 667
Height = 38
Width = 42
ToolTipText = "Eliminar Campo"
Name = "btnEliminarCampo"

*** METODOS ***
PROCEDURE Click
LOCAL lnResp

lnResp = MESSAGEBOX("¿Está seguro que desea eliminar la columna?", 4+32, Thisform.Caption)
IF lnResp = 6 THEN
	SELECT columnas
	LOCK()
	REPLACE columnas.eliminar WITH .T.
	UNLOCK
	
	Thisform.grdColumnas.Refresh()
ENDIF
ENDPROC


************************************************************
OBJETO: grdColumnas
************************************************************
*** PROPIEDADES ***
Height = 275
Left = 12
Top = 94
Width = 750
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdColumnas"
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
PROCEDURE COLUMN3.Text1.Valid
SELECT columnas
LOCK()
REPLACE columnas.insertar WITH .F.
REPLACE columnas.modificar WITH .T.
UNLOCK
ENDPROC


************************************************************
OBJETO: btnAceptar
************************************************************
*** PROPIEDADES ***
Top = 371
Left = 670
Name = "btnAceptar"

*** METODOS ***
PROCEDURE Click
LOCAL lnProxID

lnProxID = 0

IF ALLTRIM(Thisform.txtTableName.Value) == "" THEN
	MESSAGEBOX("Debe ingresr el nombre de la tabla", 0+48, Thisform.Caption)
	RETURN
ENDIF

IF !Thisform.isEdit THEN
	SELECT MAX(idTabla) AS maxID FROM tablas ;
	INTO CURSOR tempo;

	IF ISNULL(tempo.maxID) THEN
		lnProxID = 1
	ELSE
		lnProxID = tempo.maxID + 1
	ENDIF

	USE IN tempo

	SELECT tablas
	APPEND BLANK
	REPLACE tablas.idTabla WITH lnProxID
	REPLACE tablas.idHoja WITH Thisform.idhoja ADDITIVE
	REPLACE tablas.idPlanilla WITH Thisform.idPlanilla ADDITIVE
	REPLACE tablas.tableName WITH ALLTRIM(Thisform.txtTableName.Value) ADDITIVE
	REPLACE tablas.nFilaDD WITH Thisform.txtNroFilaDD.Value ADDITIVE
	REPLACE tablas.nFilaHH WITH Thisform.txtNroFilaHH.Value ADDITIVE
	REPLACE tablas.insertar WITH .T. ADDITIVE
	REPLACE tablas.modificar WITH .F. ADDITIVE
	REPLACE tablas.eliminar WITH .F. ADDITIVE
ELSE
	SELECT tablas
	LOCK()
	REPLACE tablas.idHoja WITH Thisform.idhoja ADDITIVE
	REPLACE tablas.idPlanilla WITH Thisform.idPlanilla ADDITIVE
	REPLACE tablas.tableName WITH ALLTRIM(Thisform.txtTableName.Value) ADDITIVE
	REPLACE tablas.nFilaDD WITH Thisform.txtNroFilaDD.Value ADDITIVE
	REPLACE tablas.nFilaHH WITH Thisform.txtNroFilaHH.Value ADDITIVE
	REPLACE tablas.insertar WITH .F. ADDITIVE
	REPLACE tablas.modificar WITH .T. ADDITIVE
	REPLACE tablas.eliminar WITH .F. ADDITIVE
	UNLOCK
ENDIF

UPDATE columnas ;
SET columnas.idTabla = lnProxID ;
WHERE columnas.idTabla = 0

Thisform.press_aceptar = .T.
Thisform.Hide()
ENDPROC


************************************************************
OBJETO: btnCancelar
************************************************************
*** PROPIEDADES ***
Top = 371
Left = 718
Name = "btnCancelar"

*** METODOS ***
PROCEDURE Click
Thisform.press_aceptar = .F.
Thisform.Hide()
ENDPROC


************************************************************
OBJETO: CLSLINEA1
************************************************************
*** PROPIEDADES ***
Height = 1
Left = 24
Top = 48
Width = 732
Name = "CLSLINEA1"

*** METODOS ***


************************************************************
OBJETO: cls_xls_sheet_config
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: actutxt_pagano
************************************************************
*** PROPIEDADES ***
idprov = 0
dto1 = 0.00
dto2 = 0.00
dto3 = 0.00
dto4 = 0.00
margenmay = 0.00
margenmin = 0.00
errormessage = 
path_txt = 
Name = "actutxt_pagano"

*** METODOS ***
PROCEDURE grabar
LOCAL loRes
LOCAL loCommand
LOCAL loTherm
LOCAL lcSql
LOCAL lnArchivo
LOCAL lcLinea
LOCAL lcCodigo
LOCAL lcDescripcion
LOCAL lcPrNeto
LOCAL lcPrFinal
LOCAL i
LOCAL lnIdArticulo
LOCAL lnBonif1, lnBonif2, lnBonif3, lnBonif4
LOCAL lnMargenMay, lnMargenMin, lnCosto, lnPrVentaMay, lnPrVentaMin
LOCAL lnPrLista, lnAlicIVA, lnPrListaAnt, lnPorVar
LOCAL lnIdArtCbio, llEncontrado
LOCAL m.proveedor

This.abrir_txt()

IF !FILE(This.path_txt) THEN
	This.errorMessage = "El archivo de texto seleccionado no existe"
	RETURN .F.
ENDIF

loRes = CREATEOBJECT("odbc_result")
loCommand = CREATEOBJECT("odbc_command")
loTherm = CREATEOBJECT("_Thermometer")
lcSql = ""

lnIdArticulo = 0
lcCodigo = ""
lcDescripcion = ""
lcPrNeto = ""
lcPrFinal = ""
lnAlicIVA = 0
lnBonif1 = 0.00
lnBonif2 = 0.00
lnBonif3 = 0.00
lnBonif4 = 0.00
lnMargenMay = 0.00
lnMargenMin = 0.00
lnCosto = 0.00
lnPrVentaMay = 0.00
lnPrVentaMin = 0.00
lnPrLista = 0.00
lnPrListaAnt = 0.00
lnPorVar = 0.00
lnIdArtCbio = 0
llEncontrado = .F.

lnArchivo = FOPEN(This.path_txt, 0)
IF lnArchivo < 0 THEN
	This.ErrorMessage = "No se pudo abrir el archivo"
	RETURN .F.
ENDIF

i = 0
DO WHILE !FEOF(lnArchivo)
	lcLinea = FGETS(lnArchivo);
	
	lcCodigo = ALLTRIM(SUBSTR(lcLinea, 1, 21))
	lcDescripcion = ALLTRIM(SUBSTR(lcLinea, 22, 41))
	lcPrNeto = ALLTRIM(SUBSTR(lcLinea, 63, 8))
	lcPrFinal = ALLTRIM(SUBSTR(lcLinea, 73, 8))
	
	SELECT cur_articulos
	APPEND BLANK
	REPLACE cur_articulos.codigo WITH lcCodigo
	REPLACE cur_articulos.descripcio WITH lcDescripcion ADDITIVE
	REPLACE cur_articulos.prLstNeto WITH ALLTRIM(lcPrNeto) ADDITIVE
	REPLACE cur_articulos.prLstFinal WITH ALLTRIM(lcPrFinal) ADDITIVE
	
	i = i + 1
	WAIT WINDOW "Leyendo linea nro. " + ALLTRIM(STR(i)) NOWAIT
ENDDO

=FCLOSE(lnArchivo)

loTherm.show()

SELECT cur_articulos
GO TOP

DO WHILE !EOF("cur_articulos")
	llEncontrado = .T.

	lcSql = "SELECT * FROM articulos "
	lcSql = lcSql + "WHERE articulos.codArtPV = '" + ALLTRIM(cur_articulos.codigo) + "' "
	lcSql = lcSql + "	AND articulos.idProv = " + ALLTRIM(STR(This.idProv))
	
	loRes.ActiveConnection = goConn.ActiveConnection
	loRes.Cursor_Name = "cur_temp"
	
	IF !loRes.OpenQuery(lcSql) THEN
		MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
		RETURN
	ENDIF
	
	IF RECCOUNT("cur_temp") = 0 THEN
		llEncontrado = .F.
	ENDIF
	
	lnPrListaAnt = cur_temp.prLista
	lnAlicIVA = cur_temp.alicIVA
	lnIdArticulo = cur_temp.idArticulo
	
	lnBonif1 = IIF(This.dto1 = 0, cur_temp.bonif1, This.dto1)
	lnBonif2 = IIF(This.dto2 = 0, cur_temp.bonif2, This.dto2)
	lnBonif3 = IIF(This.dto3 = 0, cur_temp.bonif3, This.dto3)
	lnBonif4 = IIF(This.dto4 = 0, cur_temp.bonif4, This.dto4)
	
	lnMargenMay = IIF(This.margenmay = 0, cur_temp.margenMax, This.margenmay)
	lnMargenMin = IIF(This.margenmin = 0, cur_temp.margenMin, This.margenmin)
	
	lnAlicIVA = cur_temp.alicIVA
	
	loRes.Close_Query()
	
	IF llEncontrado THEN
		lnPrLista = VAL(cur_articulos.prLstNeto) / 100
		lnCosto = calcular_costo(lnPrLista, lnBonif1, lnBonif2, lnBonif3, lnBonif4, 0)
		lnPrVentaMay = lnCosto + (lnCosto * (lnMargenMay / 100))
		lnPrVentaMin = lnCosto + (lnCosto * (lnMargenMin / 100))
		
		IF lnPrLista <> 0 THEN
			lnPorVar = (lnPrLista - (lnPrListaAnt / lnPrLista)) * 100
		ELSE
			lnPorVar = 100
		ENDIF
		
		IF lnPorVar <> 0 THEN
			goConn.BeginTransaction()
			
			lcSql = "UPDATE articulos "
			lcSql = lcSql + "SET articulos.prLista = " + ALLTRIM(STR(lnPrLista, 10, 2)) + ", "
			lcSql = lcSql + "	articulos.bonif1 = " + ALLTRIM(STR(lnBonif1, 10, 2)) + ", "
			lcSql = lcSql + "	articulos.bonif2 = " + ALLTRIM(STR(lnBonif2, 10, 2)) + ", "
			lcSql = lcSql + "	articulos.bonif3 = " + ALLTRIM(STR(lnBonif3, 10, 2)) + ", "
			lcSql = lcSql + "	articulos.bonif4 = " + ALLTRIM(STR(lnBonif4, 10, 2)) + ", "
			lcSql = lcSql + "	articulos.costoRep = " + ALLTRIM(STR(lnCosto, 10, 2)) + ", "
			lcSql = lcSql + "	articulos.margenMax = " + ALLTRIM(STR(lnMargenMay, 10, 2)) + ", "
			lcSql = lcSql + "	articulos.margenMin = " + ALLTRIM(STR(lnMargenMin, 10, 2)) + ", "
			lcSql = lcSql + "	articulos.prventaMax = " + ALLTRIM(STR(lnPrVentaMay, 10, 2)) + ", "
			lcSql = lcSql + "	articulos.prventaMin = " + ALLTRIM(STR(lnPrVentaMin, 10, 2)) + ", "
			lcSql = lcSql + "	articulos.alicIVA = " + ALLTRIM(STR(lnAlicIVA, 10, 2)) + ", "
			lcSql = lcSql + "	articulos.prfinalMax = " + ALLTRIM(STR(lnPrVentaMay + (lnPrVentaMay * (lnAlicIVA / 100)), 10, 2)) + ", "
			lcSql = lcSql + "	articulos.prfinalMin = " + ALLTRIM(STR(lnPrVentaMin + (lnPrVentaMin * (lnAlicIVA / 100)), 10, 2)) + ", "
			lcSql = lcSql + "	articulos.usuModi = '" + ALLTRIM(gcCodUsu) + "', "
			lcSql = lcSql + "	articulos.fecModi = current_timestamp, "
			lcSql = lcSql + "	articulos.idHostModi = '" + ALLTRIM(SYS(0)) + "' "
			lcSql = lcSql + "WHERE articulos.idArticulo = " + ALLTRIM(STR(lnIdArticulo))

			loCommand.ActiveConnection = goConn.ActiveConnection
			loCommand.CommandText = lcSql
			
			IF !loCommand.Execute() THEN
				goConn.Rollback()
				MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
				RETURN
			ENDIF
			
			lnIdArtCbio = goConn.GetNextID("art_cbios", "idArtCbios")

			lcSql = "INSERT INTO art_cbios ( "
			lcSql = lcSql + "idArtCbios, "
			lcSql = lcSql + "idArticulo, "
			lcSql = lcSql + "fecha, "
			lcSql = lcSql + "prAnt, "
			lcSql = lcSql + "prNuevo, "
			lcSql = lcSql + "porVar) "
			lcSql = lcSql + "VALUES ( "
			lcSql = lcSql + ALLTRIM(STR(lnIdArtCbio)) + ", "
			lcSql = lcSql + ALLTRIM(STR(lnIdArticulo)) + ", "
			lcSql = lcSql + "current_timestamp, "
			lcSql = lcSql + ALLTRIM(STR(lnPrListaAnt, 10, 2)) + ", "
			lcSql = lcSql + ALLTRIM(STR(lnPrLista, 10, 2)) + ", "
			lcSql = lcSql + ALLTRIM(STR(lnPorVar, 10, 2)) + ")"
			
			loCommand.ActiveConnection = goConn.ActiveConnection
			loCommand.CommandText = lcSql
			
			IF !loCommand.Execute() THEN
				goConn.Rollback()
				MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
				RETURN
			ENDIF
			
			goConn.Commit()
		ENDIF
	ELSE
		SELECT artnoenc
		APPEND BLANK
		REPLACE artnoenc.codArt WITH cur_articulos.codigo
		REPLACE artnoenc.prListaPV WITH (VAL(cur_articulos.prLstNeto) / 100) ADDITIVE
	ENDIF
	
	loTherm.update((RECNO("cur_articulos") * 100) / RECCOUNT("cur_articulos"), "Actualizándo artículos...") 

	SELECT cur_articulos
	SKIP
ENDDO

loTherm.Complete()

lcSql = "SELECT idProv, razSoc FROM proveedor WHERE idProv = " + ALLTRIM(STR(This.idprov))
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
ENDIF

SELECT artnoenc
m.proveedor = ALLTRIM(STR(cur_x.idProv)) + " - " + ALLTRIM(cur_x.razSoc)
	
loRes.Close_Query()

SELECT artnoenc
IF RECCOUNT("artnoenc") > 0 THEN
	REPORT FORM "rep_xls_noenc" TO PRINTER PROMPT NODIALOG PREVIEW
ENDIF

RETURN .T.


ENDPROC
PROCEDURE abrir_txt
This.path_txt = GETFILE("txt", "Abrir archivo de texto a procesar")

IF ALLTRIM(This.path_txt) == "" THEN
	This.ErrorMessage = "No ha seleccionado ningún archivo de texto, por lo tanto el proceso no funcionará"
ENDIF
ENDPROC
PROCEDURE crear_cursor
CREATE CURSOR cur_articulos (	;
	codigo 		varchar(20),;
	descripcio 	varchar(30),;
	prLstNeto 	varchar(8),;
	prLstFinal	varchar(8))
	
CREATE CURSOR artnoenc (	;
	codArt		varchar(20),;
	prListaPV	float(10,2))
ENDPROC


************************************************************
OBJETO: cls_upd_sc_web
************************************************************
*** PROPIEDADES ***
Height = 16
Width = 100
conexion_web = 
Name = "cls_upd_sc_web"

*** METODOS ***
PROCEDURE upd_vendedores
LOCAL loRes, loResValid, lcSql, lnCantReg
LOCAL loCommand, loTherm

loTherm = CREATEOBJECT("_thermometer")
loRes = CREATEOBJECT("odbc_result")
loResValid = CREATEOBJECT("odbc_result")
loCommand = CREATEOBJECT("odbc_command")
lnCantReg = 0

lcSql = "select * from vendedores where fecBaja is null"
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_vend"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

loTherm.Show()

SELECT cur_vend
GO TOP

DO WHILE !EOF("cur_vend")
	lcSql = "select COUNT(*) as cantReg from vendedores where idVendedor = " + ALLTRIM(STR(cur_vend.idVendedor))
	loResValid.ActiveConnection = this.conexion_web.ActiveConnection
	loResValid.Cursor_Name = "cur_tempo"
	
	IF !loResValid.OpenQuery(lcSql) THEN
		MESSAGEBOX(loResValid.Error_Message, 0+48, THisform.Caption)
		RETURN .F.
	ENDIF
	
	lnCantReg = IIF(INT(VAL(getConfig("SQLSRV"))) = 1, cur_tempo.cantReg, INT(VAL(cur_tempo.cantReg)))
	
	loResValid.Close_Query()
	
	IF lnCantReg > 0 THEN
		lcSql = "update vendedores set apelNom = '" + ALLTRIM(cur_vend.Nombre) + "' where idVendedor = " + ALLTRIM(STR(cur_vend.idVendedor))
	ELSE
		lcSql = "insert into vendedores (idVendedor, apelNom) "
		lcSql = lcSql + "values (" + ALLTRIM(STR(cur_vend.idVendedor)) + ", '" + ALLTRIM(cur_vend.nombre) + "')"
	ENDIF
	
	this.conexion_web.beginTransaction()
	loCommand.activeConnection = this.conexion_web.activeConnection
	loCommand.commandText = lcSql
	
	IF !loCommand.Execute() THEN
		this.conexion_web.rollback()
		MESSAGEBOX(loCommand.ErrorMessage, 0+48, "Error de actualización")
		RETURN .F.
	ENDIF
	
	this.conexion_web.commit()
	
	loTherm.update((RECNO("cur_vend") * 100) / RECCOUNT("cur_vend"), "Actualizando vendedores...")
	SELECT cur_vend
	SKIP
ENDDO

loRes.close_query()
loTherm.Complete()

RETURN .T.
ENDPROC
PROCEDURE upd_clientes
LOCAL loRes, loResValid, lcSql
LOCAL loCommand, loTherm, lnCantReg
LOCAL loSqlFMT, lcUsuario, lcClave
LOCAL lcRZ

loRes = CREATEOBJECT("odbc_result")
loResValid = CREATEOBJECT("odbc_result")
lcSql = ""
loCommand = CREATEOBJECT("odbc_command")
loTherm = CREATEOBJECT("_thermometer")
lnCantReg = 0
loSqlFMT = CREATEOBJECT("cls_dataformat")
lcUsuario = ""
lcClave = ""

lcSql = "select	clientes.idCliente,						"
lcSql = lcSql + "	clientes.idVendedor,				"
lcSql = lcSql + "	clientes.razSoc,					"
lcSql = lcSql + "	clientes.nomFant,					"
lcSql = lcSql + "	clientes.direccion,					"
lcSql = lcSql + "	localidad.descripcio as localidad,	"
lcSql = lcSql + "	provincias.descripcio as provincia,	"
lcSql = lcSql + "	localidad.codPostal,				"
lcSql = lcSql + "	sitiva.descripcio as sit_iva,		"
lcSql = lcSql + "	clientes.nroCUIT,					"
lcSql = lcSql + "	condpagos.descripcio as condPago,	"
lcSql = lcSql + "	clientes.telefono,					"
lcSql = lcSql + "	clientes.fax,						"
lcSql = lcSql + "	clientes.email,						"
lcSql = lcSql + "	clientes.habilitado,				"
lcSql = lcSql + "	clientes.mayorista, 				"
lcSql = lcSql + "	'' as usuario,						"
lcSql = lcSql + "	'' as clave							"
lcSql = lcSql + "from	clientes						"
lcSql = lcSql + "	inner join sitiva on clientes.idSitIVA = sitiva.idSitIVA	"
lcSql = lcSql + "	inner join condpagos on clientes.idCondPago = condpagos.idCondPago	"
lcSql = lcSql + "	inner join localidad on clientes.idLocalid = localidad.idLocalid	"
lcSql = lcSql + "	inner join provincias on provincias.idProvin = localidad.idProvin "
lcSql = lcSql + "where idCliente <> 0"

loRes.activeConnection = goConn.activeConnection
loRes.cursor_Name = "cur_cli"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

loTherm.show()

SELECT cur_cli
GO TOP 

DO WHILE !EOF("cur_cli")
	lcSql = "select count(*) as cantReg from clientes where idCliente = " + ALLTRIM(STR(cur_cli.idCliente))
	loResValid.activeConnection = this.conexion_web.activeConnection
	loResValid.cursor_Name = "cur_temp"
	
	IF !loResValid.OpenQuery(lcSql) THEN
		MESSAGEBOX(loRes.Error_Message, 0+48, "Error en actualización")
		RETURN .F.
	ENDIF
	
	lnCantReg = IIF(INT(VAL(getConfig("SQLSRV"))) = 1, cur_temp.cantReg, INT(VAL(cur_temp.cantReg)))
	
	loResValid.close_query()
	
	IF lnCantReg <> 0 THEN
		lcSql = "update clientes "
		lcSql = lcSql + "set razSoc = " + loSqlFMT.str_sqlfmt(ALLTRIM(cur_cli.razSoc)) + ", "
		lcSql = lcSql + "	nomFant = " + loSqlFMT.str_sqlfmt(IIF(ISNULL(cur_cli.nomFant), "", cur_cli.nomFant)) + ", "
		lcSql = lcSql + "	direccion = " + loSqlFMT.str_sqlfmt(ALLTRIM(cur_cli.direccion)) + ", "
		lcSql = lcSql + "	localidad = " + loSqlFMT.str_sqlfmt(ALLTRIM(cur_cli.localidad)) + ", "
		lcSql = lcSql + "	provincia = " + loSqlFMT.str_sqlfmt(ALLTRIM(cur_cli.provincia)) + ", "
		lcSql = lcSql + "	codPostal = " + loSqlFMT.str_sqlfmt(ALLTRIM(cur_cli.codPostal)) + ", "
		lcSql = lcSql + "	sitIVA = " + loSqlFMT.str_sqlfmt(ALLTRIM(cur_cli.sit_iva)) + ", "
		lcSql = lcSql + "	nroCUIT = " + loSqlFMT.str_sqlfmt(cur_cli.nroCUIT) + ", "
		lcSql = lcSql + "	condPago = " + loSqlFMT.str_sqlfmt(cur_cli.condPago) + ", "
		lcSql = lcSql + "	telefono = " + loSqlFMT.str_sqlfmt(IIF(ISNULL(cur_cli.telefono), "", cur_cli.telefono)) + ", "
		lcSql = lcSql + "	fax = " + loSqlFMT.str_sqlfmt(IIF(ISNULL(cur_cli.fax), "", cur_cli.fax)) + ", "
		lcSql = lcSql + "	email = " + loSqlFMT.str_sqlfmt(IIF(ISNULL(cur_cli.email), "", ALLTRIM(cur_cli.email))) + ", "
		lcSql = lcSql + "	habilitado = " + ALLTRIM(IIF(cur_cli.habilitado, "1", "0")) + ", "
		lcSql = lcSql + "	esMayorista = " + ALLTRIM(IIF(cur_cli.mayorista, "1", "0")) + " "
		lcSql = lcSql + "where idCliente = " + ALLTRIM(STR(cur_cli.idCliente))
	ELSE
		lcRZ = SUBSTR(GETWORDNUM(cur_cli.razSoc, 1, " "), 1, 1) + SUBSTR(GETWORDNUM(cur_cli.razSoc, 2, " "), 1, 1) + ;
			SUBSTR(GETWORDNUM(cur_cli.razSoc, 3, " "), 1, 1)
	
		&& Genero el usuario y contraseña
		lcUsuario = ALLTRIM(STR(cur_cli.idCliente))
		lcClave = SUBSTR(SUBSTR(ALLTRIM(cur_cli.nroCUIT), LEN(ALLTRIM(cur_cli.nroCUIT)) - 3, LEN(ALLTRIM(cur_cli.nroCUIT))) + ;
			ALLTRIM(lcRZ) + ALLTRIM(STR(cur_cli.idCliente)), 1, 10)
	
		lcSql = "insert into clientes ( "
		lcSql = lcSql + "idCliente, "
		lcSql = lcSql + "idVendedor, "
		lcSql = lcSql + "razSoc, "
		lcSql = lcSql + "nomFant, "
		lcSql = lcSql + "direccion, "
		lcSql = lcSql + "localidad, "
		lcSql = lcSql + "provincia, "
		lcSql = lcSql + "codPostal, "
		lcSql = lcSql + "sitIVA, "
		lcSql = lcSql + "nroCUIT, "
		lcSql = lcSql + "condPago, "
		lcSql = lcSql + "telefono, "
		lcSql = lcSql + "fax, "
		lcSql = lcSql + "email, "
		lcSql = lcSql + "habilitado, "
		lcSql = lcSql + "esMayorista, "
		lcSql = lcSql + "usuario, "
		lcSql = lcSql + "clave) "
		lcSql = lcSql + "values ( "
		lcSql = lcSql + ALLTRIM(STR(cur_cli.idCliente)) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_cli.idVendedor)) + ", "
		lcSql = lcSql + loSqlFMT.str_sqlfmt(ALLTRIM(cur_cli.razSoc)) + ", "
		lcSql = lcSql + loSqlFMT.str_sqlfmt(ALLTRIM(cur_cli.nomFant)) + ", "
		lcSql = lcSql + loSqlFMT.str_sqlfmt(ALLTRIM(cur_cli.direccion)) + ", "
		lcSql = lcSql + loSqlFMT.str_sqlfmt(ALLTRIM(cur_cli.localidad)) + ", "
		lcSql = lcSql + loSqlFMT.str_sqlfmt(ALLTRIM(cur_cli.provincia)) + ", "
		lcSql = lcSql + loSqlFMT.str_sqlfmt(ALLTRIM(cur_cli.codPostal)) + ", "
		lcSql = lcSql + loSqlFMT.str_sqlfmt(ALLTRIM(cur_cli.sit_iva)) + ", "
		lcSql = lcSql + loSqlFMT.str_sqlfmt(ALLTRIM(cur_cli.nroCUIT)) + ", "
		lcSql = lcSql + loSqlFMT.str_sqlfmt(ALLTRIM(cur_cli.condPago)) + ", "
		lcSql = lcSql + loSqlFMT.str_sqlfmt(ALLTRIM(IIF(ISNULL(cur_cli.telefono), "", cur_cli.telefono))) + ", "
		lcSql = lcSql + loSqlFMT.str_sqlfmt(ALLTRIM(IIF(ISNULL(cur_cli.fax), "", cur_cli.fax))) + ", "
		lcSql = lcSql + loSqlFMT.str_sqlfmt(ALLTRIM(IIF(ISNULL(cur_cli.email), "", cur_cli.email))) + ", "
		lcSql = lcSql + ALLTRIM(IIF(cur_cli.habilitado, "1", "0")) + ", "
		lcSql = lcSql + IIF(cur_cli.mayorista, "1", "0") + ", "
		lcSql = lcSql + loSqlFMT.str_sqlfmt(ALLTRIM(lcUsuario)) + ", "
		lcSql = lcSql + loSqlFMT.str_sqlfmt(ALLTRIM(lcClave)) + ")"
	ENDIF
	
	this.conexion_web.beginTransaction()
	
	loCommand.activeConnection = this.conexion_web.activeConnection
	loCommand.commandText = lcSql
	
	IF !loCommand.Execute() THEN
		this.conexion_web.rollback()
		MESSAGEBOX(loCommand.Error_Message, 0+48, "Proceso de actualización...")
		RETURN .F.
	ENDIF
	
	this.conexion_web.commit()
	
	loTherm.update((RECNO("cur_cli") * 100) / RECCOUNT("cur_cli"), "Actualizando clientes...")
	SELECT cur_cli
	SKIP
ENDDO

loTherm.complete()
loRes.Close_Query

RETURN .T.
ENDPROC
PROCEDURE upd_articulos
LOCAL loRes, loResValid, lcSql, lnCantReg
LOCAL loCommand, loTherm, loSqlFMT
LOCAL lnProxIDCbio, lnPorcentaje

loTherm = CREATEOBJECT("_thermometer")
loRes = CREATEOBJECT("odbc_result")
loResValid = CREATEOBJECT("odbc_result")
loCommand = CREATEOBJECT("odbc_command")
loSqlFMT = CREATEOBJECT("cls_dataformat")
lnCantReg = 0
lnProxIDCbio = 0
lnPorcentaje = 0.00

lcSql = "select	articulos.idArticulo,	"
lcSql = lcSql + "	articulos.codArt,	"
lcSql = lcSql + "	articulos.descripcio, "		
lcSql = lcSql + "	marcas.descripcio as linea,	"
lcSql = lcSql + "	familias.descripcio as familia,	"
lcSql = lcSql + "	subfam.descripcio as subfam, "	
lcSql = lcSql + "	articulos.alicIVA, "
lcSql = lcSql + "	articulos.prventaMin as pr_lista_min,	"
lcSql = lcSql + "	articulos.prventaMax as pr_lista_may,	"	
lcSql = lcSql + "	0 as desc1,	"
lcSql = lcSql + "	0 as desc2,	"	
lcSql = lcSql + "	0 as desc3,	"	
lcSql = lcSql + "	0 as desc4,	"	
lcSql = lcSql + "	articulos.prLista as costoCli,	"
lcSql = lcSql + "	0 as rentabilidad, "	
lcSql = lcSql + "	articulos.linkFoto as linkFoto,	"
lcSql = lcSql + "	articulos.habilitado as habilitado,	"
lcSql = lcSql + "	if(articulos.fecBaja is null, 0, 1) as baja "
lcSql = lcSql + "from	articulos	"
lcSql = lcSql + "	inner join familias on familias.idFamilia = articulos.idFamilia	"
lcSql = lcSql + "	inner join subfam on subfam.idSubFam = articulos.idSubFam "
lcSql = lcSql + "	inner join marcas on marcas.idMarca = articulos.idMarca	"
lcSql = lcSql + "	inner join proveedor on proveedor.idProv = articulos.idProv "
lcSql = lcSql + "where right(articulos.codArt, 3) != 'ARX' " 

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_art"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

loTherm.Show()

SELECT cur_art
GO TOP

DO WHILE !EOF("cur_art")
	this.conexion_web.beginTransaction()

	lcSql = "select * from articulos where idArticulo = " + ALLTRIM(STR(cur_art.idArticulo))	
	loResValid.ActiveConnection = this.conexion_web.ActiveConnection
	loResValid.Cursor_Name = "cur_tempo"
	
	IF !loResValid.OpenQuery(lcSql) THEN
		MESSAGEBOX(loResValid.Error_Message, 0+48, THisform.Caption)
		RETURN .F.
	ENDIF
	
	lnCantReg = RECCOUNT("cur_tempo")
	
	
	IF lnCantReg = 0 THEN
		lcSql = "insert into articulos ("
		lcSql = lcSql + "idArticulo, "
		lcSql = lcSql + "codArt, "
		lcSql = lcSql + "descripcio, "
		lcSql = lcSql + "linea, "
		lcSql = lcSql + "familia, "
		lcSql = lcSql + "subfam, "
		lcSql = lcSql + "alicIVA, "
		lcSql = lcSql + "pr_lista_min, "
		lcSql = lcSql + "pr_lista_may, "
		lcSql = lcSql + "desc1, "
		lcSql = lcSql + "desc2, "
		lcSql = lcSql + "desc3, "
		lcSql = lcSql + "desc4, "
		lcSql = lcSql + "costoCli, "
		lcSql = lcSql + "rentabilidad, "
		lcSql = lcSql + "pr_vta, "
		lcSql = lcSql + "linkFoto, "
		lcSql = lcSql + "habilitado, "
		lcSql = lcSql + "baja) "
		lcSql = lcSql + "VALUES ( "
		lcSql = lcSql + ALLTRIM(STR(cur_art.idArticulo)) + ", "
		lcSql = lcSql + loSqlFMT.str_sqlfmt(cur_art.codArt) + ", "
		lcSql = lcSql + loSqlFMT.str_sqlfmt(cur_art.descripcio) + ", "
		lcSql = lcSql + loSqlFMT.str_sqlfmt(cur_art.linea) + ", "
		lcSql = lcSql + loSqlFMT.str_sqlfmt(cur_art.familia) + ", "
		lcSql = lcSql + loSqlFMT.str_sqlfmt(cur_art.subFam) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_art.alicIVA, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_art.pr_lista_min, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_art.pr_lista_may, 10, 2)) + ", "
		lcSql = lcSql + "0, "
		lcSql = lcSql + "0, "
		lcSql = lcSql + "0, "
		lcSql = lcSql + "0, "
		lcSql = lcSql + ALLTRIM(STR(cur_art.costoCli, 10, 2)) + ", "
		lcSql = lcSql + "0, "
		lcSql = lcSql + "0, "
		lcSql = lcSql + loSqlFMT.str_sqlfmt(IIF(ISNULL(cur_art.linkFoto), "", STRTRAN(STRTRAN(ALLTRIM(cur_art.linkFoto), "C:\MG_FOTOS\", "fotos\"), "\", "/"))) + ", "
		lcSql = lcSql + IIF(cur_art.habilitado, "1", "0") + ", "
		lcSql = lcSql + ALLTRIM(cur_art.baja) + ")"
		
		loCommand.activeConnection = this.conexion_web.activeConnection
		loCommand.commandText = lcSql
		
		IF !loCommand.Execute() THEN
			this.conexion_web.rollback()
			MESSAGEBOX(loCommand.ErrorMessage, 0+48, "Error de actualización")
			RETURN .F.
		ENDIF
		
	ELSE
		lcSql = "update articulos "
		lcSql = lcSql + "set descripcio = " + loSqlFMT.str_sqlfmt(cur_art.descripcio) + ", "
		lcSql = lcSql + "linea = " + loSqlFMT.str_sqlfmt(cur_art.linea) + ", "
		lcSql = lcSql + "familia = " + loSqlFMT.str_sqlfmt(cur_art.familia) + ", "
		lcSql = lcSql + "subfam = " + loSqlFMT.str_sqlfmt(cur_art.subFam) + ", "
		lcSql = lcSql + "alicIVA = " + loSqlFMT.float_sqlfmt(cur_art.alicIVA, 10, 2) + ", "
		lcSql = lcSql + "pr_lista_min = " + loSqlFMT.float_sqlfmt(cur_art.pr_lista_min, 10, 2) + ", "
		lcSql = lcSql + "pr_lista_may = " + loSqlFMT.float_sqlfmt(cur_art.pr_lista_may, 10, 2) + ", "
		lcSql = lcSql + "desc1 = desc1, " 
		lcSql = lcSql + "desc2 = desc2, " 
		lcSql = lcSql + "desc3 = desc2, " 
		lcSql = lcSql + "desc4 = desc4, " 
		lcSql = lcSql + "costoCli = costoCli, " 
		lcSql = lcSql + "rentabilidad = rentabilidad, " 
		lcSql = lcSql + "pr_vta = pr_vta, " 
		lcSql = lcSql + "linkFoto = " + loSqlFMT.str_sqlfmt(IIF(ISNULL(cur_art.linkFoto), "", STRTRAN(STRTRAN(ALLTRIM(cur_art.linkFoto), "C:\MG_FOTOS\", "fotos\"), "\", "/"))) + ", " 
		lcSql = lcSql + "habilitado = " + IIF(cur_art.habilitado, "1", "0") + ", "
		lcSql = lcSql + "baja = " + ALLTRIM(cur_art.baja) + " " 
		lcSql = lcSql + "where idArticulo = " + ALLTRIM(STR(cur_art.idArticulo))

		loCommand.activeConnection = this.conexion_web.activeConnection
		loCommand.commandText = lcSql
		
		IF !loCommand.Execute() THEN
			this.conexion_web.rollback()
			MESSAGEBOX(loCommand.ErrorMessage, 0+48, "Error de actualización")
			RETURN .F.
		ENDIF
		
		IF cur_tempo.pr_lista_may <> cur_art.pr_lista_may THEN 
			&& A continuación genero el registro con el aumento
			lnProxIDCbio = this.conexion_web.getNextID("hist_cbioart", "idHistCbioArt")
			
			IF cur_art.pr_lista_may = 0 THEN
				lnPorcentaje = 100
			ELSE
				lnPorcentaje = (1 - (cur_tempo.pr_lista_may / cur_art.pr_lista_may)) * 100
			ENDIF
			
			lcSql = "insert into hist_cbioart ( "
			lcSql = lcSql + "idHistCbioArt, idArticulo, codArt, fecha, anio, mes, dia, porcent, notas) "
			lcSql = lcSql + "values ( "
			lcSql = lcSql + ALLTRIM(STR(lnProxIDCbio)) + ", "
			lcSql = lcSql + ALLTRIM(STR(cur_art.idArticulo)) + ", "
			lcSql = lcSql + loSqlFMT.str_sqlfmt(cur_art.codArt) + ", "
			lcSql = lcSql + IIF(INT(VAL(getConfig("SQLSRV"))) = 1, "getdate()", "current_timestamp") + ", "
			lcSql = lcSql + ALLTRIM(STR(YEAR(DATETIME()))) + ", "
			lcSql = lcSql + ALLTRIM(STR(MONTH(DATETIME()))) + ", "
			lcSql = lcSql + ALLTRIM(STR(DAY(DATETIME()))) + ", "
			lcSql = lcSql + loSqlFMT.float_sqlfmt(lnPorcentaje, 10, 2) + ", "
			lcSql = lcSql + "'')"
		ENDIF
		
		loCommand.activeConnection = this.conexion_web.activeConnection
		loCommand.commandText = lcSql
		
		IF !loCommand.Execute() THEN
			this.conexion_web.rollback()
			MESSAGEBOX(loCommand.ErrorMessage, 0+48, "Error de actualización")
			RETURN .F.
		ENDIF
	ENDIF
	
	loResValid.Close_Query()
	
	this.conexion_web.commit()
	
	loTherm.update((RECNO("cur_art") * 100) / RECCOUNT("cur_art"), "Actualizando artículos...")
	SELECT cur_art
	SKIP
ENDDO

loRes.close_query()
loTherm.Complete()

RETURN .T.
ENDPROC
PROCEDURE conectar
LOCAL loConn

this.conexion_web = CREATEOBJECT("odbc_connect")

this.conexion_web.ConnectionString = alltrim(getConfig("SCWCONN"));

IF !this.conexion_web.Open()
	MESSAGEBOX(this.conexion_web.ErrorMessage, 1+16, "Database Connection")
	DO FORM "frmConfiguracion"
	RETURN .F.
ENDIF

RETURN .T.

ENDPROC
PROCEDURE upd_cc_cli
LOCAL loRes, loResValid, lcSql
LOCAL loCommand, lnCantReg, loTherm
LOCAL loSqlFMT

loSqlFMT = CREATEOBJECT("cls_dataformat")
loRes = CREATEOBJECT("odbc_result")
loResValid = CREATEOBJECT("odbc_result")
loCommand = CREATEOBJECT("odbc_command")
lcSql = ""
lnCantReg = 0
loTherm = CREATEOBJECT("_thermometer")

lcSql = "select idCC_Cli, "
lcSql = lcSql + "idCliente,	"
lcSql = lcSql + "idVendedor, "
lcSql = lcSql + "idCC_Orig,	"	
lcSql = lcSql + "idVentasC,	"	
lcSql = lcSql + "cbte,		"
lcSql = lcSql + "tipoDoc,	"	
lcSql = lcSql + "ptoVta,	"	
lcSql = lcSql + "nroCbte,	"	
lcSql = lcSql + "fecEmis,	"	
lcSql = lcSql + "fecVto,	"	
lcSql = lcSql + "impDebe,	"	
lcSql = lcSql + "impHaber,	"	
lcSql = lcSql + "idOper,	"	
lcSql = lcSql + "observ,	"	
lcSql = lcSql + "'' as linkArchCbte "
lcSql = lcSql + "from 	cc_cli "
lcSql = lcSql + "where	cc_cli.fecBaja is null	"
lcSql = lcSql + "	and cc_cli.idCliente <> 0 "
*lcSql = lcSql + "	and cc_cli.idOper in (		"
*lcSql = lcSql + "		select	cc_cli.idOper	"	
*lcSql = lcSql + "		from	cc_cli		"
*lcSql = lcSql + "		group by cc_cli.idOper	"	
*lcSql = lcSql + "		having (sum(cc_cli.impDebe) - sum(cc_cli.impHaber)) <> 0) "
lcSql = lcSql + "order by cc_cli.idOper, cc_cli.idCliente, cc_cli.idCC_Cli "

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_cc"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, "Error en proceso")
	RETURN .F.
ENDIF

loTherm.show()

SELECT cur_cc
GO TOP

DO WHILE !EOF("cur_cc")
	lcSql = "select count(*) as cantReg from cc_cli where idCC_Cli = " + ALLTRIM(STR(cur_cc.idCC_Cli))
	loResValid.ActiveConnection = this.conexion_web.ActiveConnection
	loResValid.Cursor_Name = "cur_temp"
	
	IF !loResValid.OpenQuery(lcSql) THEN
		MESSAGEBOX(loRes.Error_Message, 0+48, "Error en proceso")
		RETURN .F.
	ENDIF	
	
	lnCantReg = IIF(INT(VAL(getConfig("SQLSRV"))) = 1, cur_temp.cantReg, INT(VAL(cur_temp.cantReg)))
	loResValid.Close_Query()
	
	IF lnCantReg = 0 THEN
		lcSql = "insert into cc_cli ( "
		lcSql = lcSql + "idCC_Cli, "
		lcSql = lcSql + "idCliente, "
		lcSql = lcSql + "idVendedor, "
		lcSql = lcSql + "idCC_Orig, "
		lcSql = lcSql + "idVentasC, "
		lcSql = lcSql + "cbte, "
		lcSql = lcSql + "tipoDoc, "
		lcSql = lcSql + "ptoVta, "
		lcSql = lcSql + "nroCbte, "
		lcSql = lcSql + "fecEmis, "
		lcSql = lcSql + "fecVto, "
		lcSql = lcSql + "impDebe, "
		lcSql = lcSql + "impHaber, "
		lcSql = lcSql + "idOper, "
		lcSql = lcSql + "observ, "
		lcSql = lcSql + "linkArchCbte) "
		lcSql = lcSql + "values ( "
		lcSql = lcSql + ALLTRIM(STR(cur_cc.idCC_Cli)) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_cc.idCliente)) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_cc.idVendedor)) + ", "
		lcSql = lcSql + IIF(!ISNULL(cur_cc.idCC_Orig), ALLTRIM(STR(cur_cc.idCC_Orig)), "null") + ", "
		lcSql = lcSql + IIF(!ISNULL(cur_cc.idVentasC), ALLTRIM(STR(cur_cc.idVentasC)), "null") + ", "
		lcSql = lcSql + loSqlFMT.str_sqlfmt(cur_cc.cbte) + ", "
		lcSql = lcSql + loSqlFMT.str_sqlfmt(cur_cc.tipoDoc) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_cc.ptoVta)) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_cc.nroCbte)) + ", "
		lcSql = lcSql + loSqlFMT.datetime_sqlfmt(cur_cc.fecEmis) + ", "
		lcSql = lcSql + IIF(!ISNULL(cur_cc.fecVto), loSqlFMT.datetime_sqlfmt(cur_cc.fecVto), "null") + ", "
		lcSql = lcSql + loSqlFMT.float_sqlfmt(cur_cc.impDebe, 10, 2) + ", "
		lcSql = lcSql + loSqlFMT.float_sqlfmt(cur_cc.impHaber, 10, 2) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_cc.idOper)) + ", "
		lcSql = lcSql + loSqlFMT.str_sqlfmt(IIF(ISNULL(cur_cc.observ), "", cur_cc.observ)) + ", "
		lcSql = lcSql + "'')"
	ENDIF

	this.conexion_web.beginTransaction
	loCommand.ActiveConnection = this.conexion_web.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.execute() THEN
		this.conexion_web.rollback()
		MESSAGEBOX(loCommnad.ErrorMessage, 0+48, "Error en proceso")
		RETURN .F.
	ENDIF
	
	this.conexion_web.commit()
	
	loTherm.update((RECNO("cur_cc") * 100) / RECCOUNT("cur_cc"), "Actualizando cuentas corrientes...")
	SELECT cur_cc
	SKIP
ENDDO

loRes.Close_Query()
loTherm.complete()

RETURN .T.
ENDPROC


************************************************************
OBJETO: actu_tommasi
************************************************************
*** PROPIEDADES ***
activeconnection = 
alic_iva = 21.00
desc1 = 0.00
desc2 = 0.00
desc3 = 0.00
desc4 = 0.00
error_message = 
idprov = 0
margen_may = 0.00
margen_min = 0.00
Name = "actu_tommasi"

*** METODOS ***
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
WHERE Li IN (SELECT rubro FROM C:\TOMMASIW\arti WHERE Descrip LIKE "%BOSCH%" OR Descrip LIKE "%HELLUX%" ;
	OR Descrip LIKE "%LITHO%" ) ;
INTO CURSOR cur_rubros

SELECT cur_rubros
IF RECCOUNT("cur_rubros") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_rubros")
	&& Actualizo los rubros
		
	lcSql = "SELECT * FROM subfam where descripcio = '" + ALLTRIM(rubros.Titulo) + "'"
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
		lcSql = lcSql + "'" + ALLTRIM(rubros.Titulo) + "', "
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
		AND (Descrip LIKE "%BOSCH%" OR Descrip LIKE "%HELLUX%" OR Descrip LIKE "%LITHO%") AND NOT (Codigo LIKE "CRI%") ;
	INTO CURSOR cur_arti

	SELECT cur_arti
	IF RECCOUNT("cur_arti") > 0 THEN 
		GO TOP
	ENDIF
	
	DO WHILE !EOF("cur_arti")
		lcSql = "SELECT * FROM articulos WHERE codArt = '" + ALLTRIM(cur_arti.Codigo) + "'"
		loResult.ActiveConnection = goConn.ActiveConnection
		loResult.Cursor_Name = "cur_tmp"
		loResult.OpenQuery(lcSql)
		
		lcCodigo = ALLTRIM(cur_arti.Codigo)
		lnIdMarca = -1
		
		SELECT cur_tmp
		IF RECCOUNT("cur_tmp") = 0 THEN
			&& Calculo de los precios.		
			lnPrLista = cur_arti.Precio
			lnCostoRep = calcular_costo(lnPrLista, this.desc1, this.desc2, this.desc3, this.desc4, 0)
			lnPrVentaMax = lnCostoRep + (lnCostoRep * (this.margen_may / 100))
			lnPrVentaMin = lnCostoRep + (lnCostoRep * (this.margen_min / 100))
			lnPrFinalMax = lnPrVentaMax + (lnPrVentaMax * (this.alic_iva / 100))
			lnPrFinalMin = lnPrVentaMin + (lnPrVentaMin * (this.alic_iva / 100))		
		
			lnProxID = goConn.GetNextID("articulos", "idArticulo")
		
			&& Agrego un nuevo registro
			lcSql = "INSERT INTO articulos ( "
			lcSql = lcSql + "	idArticulo, "
			lcSql = lcSql + "	idProv, "
			lcSql = lcSql + "	idFamilia, "
			lcSql = lcSql + "	idSubFam, "
			lcSql = lcSql + "	idMarca, "
			lcSql = lcSql + "	codArt, "
			lcSql = lcSql + "	descripcio, "
			lcSql = lcSql + "	alicIVA, "
			lcSql = lcSql + "	tmon, "
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
			lcSql = lcSql + "	prventaMax, "
			lcSql = lcSql + "	prventaMin, "
			lcSql = lcSql + "	prfinalMax, "
			lcSql = lcSql + "	prfinalMin, "
			lcSql = lcSql + "	observ, "
			lcSql = lcSql + "	idUniMed, "
			lcSql = lcSql + "	habilitado, "
			lcSql = lcSql + "	usuAlta, "
			lcSql = lcSql + "	fecAlta, "
			lcSql = lcSql + "	idHostAlta) "
			lcSql = lcSql + "VALUES ( "
			lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", "
			lcSql = lcSql + ALLTRIM(STR(This.idProv)) + ", "
			lcSql = lcSql + "1, " 											&& Familia
			lcSql = lcSql + ALLTRIM(STR(lnIdSubFam)) + ", "					&& SubFamilia
			lcSql = lcSql + ALLTRIM(STR(lnIdMarca)) + ", " 					&& Marca
			lcSql = lcSql + "'" + ALLTRIM(lcCodigo) + "', "
			lcSql = lcSql + "'" + ALLTRIM(STRTRAN(cur_arti.Descrip, "'"," ")) + "', "
			lcSql = lcSql + ALLTRIM(STR(This.alic_iva, 10, 2)) + ", "
			lcSql = lcSql + "'PSO', "
			lcSql = lcSql + "0, "											&& Precio de lista ext.
			lcSql = lcSql + "0, "											&& Cotización
			lcSql = lcSql + ALLTRIM(STR(lnPrLista, 10, 2)) + ", "
			lcSql = lcSql + ALLTRIM(STR(This.desc1, 10, 2)) + ", "
			lcSql = lcSql + ALLTRIM(STR(This.desc2, 10, 2)) + ", "
			lcSql = lcSql + ALLTRIM(STR(This.desc3, 10, 2)) + ", "
			lcSql = lcSql + ALLTRIM(STR(This.desc4, 10, 2)) + ", "
			lcSql = lcSql + ALLTRIM(STR(lnCostoRep, 10, 2)) + ", "
			lcSql = lcSql + ALLTRIM(STR(This.margen_may, 10, 2)) + ", "
			lcSql = lcSql + ALLTRIM(STR(This.margen_min, 10, 2)) + ", "
			lcSql = lcSql + ALLTRIM(STR(lnPrVentaMax, 10, 2)) + ", "
			lcSql = lcSql + ALLTRIM(STR(lnPrVentaMin, 10, 2)) + ", "
			lcSql = lcSql + ALLTRIM(STR(lnPrFinalMax, 10, 2)) + ", "
			lcSql = lcSql + ALLTRIM(STR(lnPrFinalMin, 10, 2)) + ", "
			lcSql = lcSql + "'', " 											&& Observ
			lcSql = lcSql + "1, "
			lcSql = lcSql + "1, "
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
			
			&& Agrego el registro al codiart
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
			lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", "
			lcSql = lcSql + "'" + ALLTRIM(lcCodigo) + "', "
			lcSql = lcSql + "'" + ALLTRIM(lcCodigo) + "', "
			lcSql = lcSql + "'CP', "
			lcSql = lcSql + "1, "
			lcSql = lcSql + "0, "
			lcSql = lcSql + "'CV')"
			
			loCommand.ActiveConnection = goConn.ActiveConnection
			loCommand.CommandText = lcSql
			
			IF !loCommand.Execute() THEN
				this.errorMessage = loCommand.ErrorMessage
				goConn.rollback()
				RETURN .F.
			ENDIF					
		ENDIF
		
		* Genero el registro en el log de catálogo
		lcSql = "INSERT INTO logupdcat ( "
		lcSql = lcSql + "idUpdCat, "
		lcSql = lcSql + "descripcio, "
		lcSql = lcSql + "accion, "
		lcSql = lcSql + "idArticulo, "
		lcSql = lcSql + "codArt, "
		lcSql = lcSql + "bonif1, "
		lcSql = lcSql + "bonif2, "
		lcSql = lcSql + "bonif3, "
		lcSql = lcSql + "bonif4, "
		lcSql = lcSql + "margenMay, "
		lcSql = lcSql + "margenMin, "
		lcSql = lcSql + "prListaAnt, "
		lcSql = lcSql + "prListaNew, "
		lcSql = lcSql + "porVar) "
		lcSql = lcSql + "VALUES ( "
		lcSql = lcSql + STR(goConn.GetNextID("logupdcat", "idUpdCat")) + ", "
		lcSql = lcSql + "'TOMMASSIW',"
		lcSql = lcSql + "'LOG_CARGAR_NUEVOS', "
		lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", "
		lcSql = lcSql + "'" + ALLTRIM(lcCodigo) + "', "
		lcSql = lcSql + ALLTRIM(STR(this.desc1, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(this.desc2, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(this.desc3, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(this.desc4, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(this.margen_may, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(this.margen_min, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(0, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnPrLista, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(0, 10, 2)) + ")"
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
			RETURN .F.
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
loCommand = CREATEOBJECT("odbc_command")
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
	WHERE ALLTRIM(codigo) == ALLTRIM(cur_articulos.codArt) ;
	INTO CURSOR cur_tmssi
	
	SELECT cur_tmssi
	lnPrLista = cur_tmssi.precio
	
	IF lnPrAnt <> 0 THEN
		lnPorVar = ((lnPrLista - lnPrAnt) / lnPrAnt) * 100
	ELSE
		lnPorVar = 100
	ENDIF
	
	IF lnPorVar <> 0 THEN	
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
		
		lcSql = "UPDATE articulos "
		lcSql = lcSql + "SET articulos.prLista = " + ALLTRIM(STR(lnPrLista, 10, 2)) + ", "
		lcSql = lcSql + "articulos.bonif1 = " + ALLTRIM(STR(IIF(this.desc1 = 0, cur_articulos.bonif1, this.desc1), 10, 2)) + ", "
		lcSql = lcSql + "articulos.bonif2 = " + ALLTRIM(STR(IIF(this.desc2 = 0, cur_articulos.bonif2, this.desc2), 10, 2)) + ", "
		lcSql = lcSql + "articulos.bonif3 = " + ALLTRIM(STR(IIF(this.desc3 = 0, cur_articulos.bonif3, this.desc3), 10, 2)) + ", "
		lcSql = lcSql + "articulos.bonif4 = " + ALLTRIM(STR(IIF(this.desc4 = 0, cur_articulos.bonif4, this.desc4), 10, 2)) + ", "
		lcSql = lcSql + "articulos.costoRep = " + ALLTRIM(STR(lnCostoRep, 10, 2)) + ", "
		lcSql = lcSql + "articulos.margenMax = " + ALLTRIM(STR(IIF(this.margen_may = 0, cur_articulos.margenMax, this.margen_may), 10, 2)) + ", "
		lcSql = lcSql + "articulos.margenMin = " + ALLTRIM(STR(IIF(this.margen_min = 0, cur_articulos.margenMin, this.margen_min), 10, 2)) + ", "
		lcSql = lcSql + "articulos.prventaMax = " + ALLTRIM(STR(lnPrVentaMax, 10, 2)) + ", "
		lcSql = lcSql + "articulos.prventaMin = " + ALLTRIM(STR(lnPrVentaMin, 10, 2)) + ", "
		lcSql = lcSql + "articulos.prFinalMax = " + ALLTRIM(STR(lnPrFinalMax, 10, 2)) + ", "
		lcSql = lcSql + "articulos.prFinalMin = " + ALLTRIM(STR(lnPrFinalMin, 10, 2)) + ", "
		lcSql = lcSql + "articulos.usuModi = '" + ALLTRIM(gcCodUsu) + "', "
		lcSql = lcSql + "articulos.fecModi = current_timestamp, "
		lcSql = lcSql + "articulos.idHostModi = '" + ALLTRIM(SYS(0)) + "' "
		lcSql = lcSql + "WHERE articulos.codArt = '" + ALLTRIM(cur_articulos.codArt) + "' "
		lcSql = lcSql + "	AND articulos.idProv = " + ALLTRIM(STR(This.idProv))
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
			RETURN .F.
		ENDIF
		
		lnProxID = goConn.GetNextID("art_cbios", "idArtCbios")
		
		lcSql = "INSERT INTO art_cbios ( "
		lcSql = lcSql + "idArtCbios, idArticulo, fecha, prAnt, prNuevo, porVar) "
		lcSql = lcSql + "VALUES (" + ALLTRIM(STR(lnProxID)) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_articulos.idArticulo)) + ", "
		lcSql = lcSql + "current_timestamp, "
		lcSql = lcSql + ALLTRIM(STR(lnPrAnt, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnPrLista, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnPorVar, 10, 2)) + ") "
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
			RETURN .F.
		ENDIF
	ENDIF
	
	* Genero el registro en el log de catálogo
	lcSql = "INSERT INTO logupdcat ( "
	lcSql = lcSql + "idUpdCat, "
	lcSql = lcSql + "descripcio, "
	lcSql = lcSql + "accion, "
	lcSql = lcSql + "idArticulo, "
	lcSql = lcSql + "codArt, "
	lcSql = lcSql + "bonif1, "
	lcSql = lcSql + "bonif2, "
	lcSql = lcSql + "bonif3, "
	lcSql = lcSql + "bonif4, "
	lcSql = lcSql + "margenMay, "
	lcSql = lcSql + "margenMin, "
	lcSql = lcSql + "prListaAnt, "
	lcSql = lcSql + "prListaNew, "
	lcSql = lcSql + "porVar) "
	lcSql = lcSql + "VALUES ( "
	lcSql = lcSql + STR(goConn.GetNextID("logupdcat", "idUpdCat")) + ", "
	lcSql = lcSql + "'TOMMASSIW',"
	lcSql = lcSql + "'LOG_ACTUALIZAR_EXISTENTES', "
	lcSql = lcSql + ALLTRIM(STR(cur_articulos.idArticulo)) + ", "
	lcSql = lcSql + "'" + ALLTRIM(cur_articulos.codArt) + "', "
	lcSql = lcSql + ALLTRIM(STR(IIF(this.desc1 = 0, cur_articulos.bonif1, this.desc1), 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(IIF(this.desc2 = 0, cur_articulos.bonif2, this.desc2), 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(IIF(this.desc3 = 0, cur_articulos.bonif3, this.desc3), 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(IIF(this.desc4 = 0, cur_articulos.bonif4, this.desc4), 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(IIF(this.margen_may = 0, cur_articulos.margenMax, this.margen_may), 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(IIF(this.margen_min = 0, cur_articulos.margenMin, this.margen_min), 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPrAnt, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPrLista, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPorVar, 10, 2)) + ")"
	
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute() THEN
		goConn.Rollback()
		MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
		RETURN .F.
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


************************************************************
OBJETO: cls_xls_config
************************************************************
*** PROPIEDADES ***
BorderStyle = 2
Height = 538
Width = 777
DoCreate = .T.
Caption = "Configuración del importador inteligente"
idplanilla = 0
isedit = .F.
Name = "cls_xls_config"
contenido.Name = "contenido"

*** METODOS ***
PROCEDURE seleccionar_hoja
SELECT tablas
SET FILTER TO tablas.idHoja = hojas.idHoja IN "tablas"
Thisform.contenido.grdTablas.Refresh()

SELECT tablas
GO TOP
Thisform.seleccionar_tabla()
ENDPROC
PROCEDURE seleccionar_tabla
SELECT columnas
SET FILTER TO columnas.idTabla = tablas.idTabla IN columnas
ENDPROC
PROCEDURE Load
DODEFAULT()


CREATE CURSOR hojas (	;
	idHoja		int,;
	idPlanilla	int,;
	nombre		varchar(100),;
	insertar	L,;
	modificar	L,;
	eliminar	L)
	
CREATE CURSOR tablas (	;
	idTabla		int,;
	idHoja		int,;
	idPlanilla	int,;
	tableName	varchar(15),;
	nFilaDD		int,;
	nFilaHH		int,;
	insertar	L,;
	modificar	L,;
	eliminar	L)
	
CREATE CURSOR columnas (	;
	idColumna	int,;
	idTabla		int,;
	fieldName	varchar(15),;
	dataType	varchar(1),;
	nroColRef	int,;
	insertar	L,;
	modificar	L,;
	eliminar	L)
	

ENDPROC
PROCEDURE Init
SELECT hojas
Thisform.contenido.grdHojas.alias_name = "hojas"
Thisform.contenido.grdHojas.RecordSource = "hojas"
Thisform.contenido.grdHojas.list_controlsource = "nombre"
Thisform.contenido.grdHojas.lista_ancho_cols = "100"
Thisform.contenido.grdHojas.titulos_cabeceras = "Nombre"
Thisform.contenido.grdHojas.generar_grid()

Thisform.contenido.grdHojas.Columns[1].DynamicBackColor = "IIF(hojas.eliminar = .T., RGB(255, 0, 0), RGB(255, 255, 255))"
Thisform.contenido.grdHojas.Columns[1].DynamicForeColor = "IIF(tablas.eliminar = .T., RGB(255, 255, 255), RGB(0, 0, 0))"

SELECT tablas
Thisform.contenido.grdTablas.alias_name = "tablas"
Thisform.contenido.grdTablas.RecordSource = "tablas"
Thisform.contenido.grdTablas.list_controlsource = "tableName,nFilaDD,nFilaHH"
Thisform.contenido.grdTablas.lista_ancho_cols = "200,100,100"
Thisform.contenido.grdTablas.titulos_cabeceras = "Tabla,Fila Desde,Fila Hasta"
Thisform.contenido.grdTablas.generar_grid()

Thisform.contenido.grdTablas.Columns[1].DynamicBackColor = "IIF(tablas.eliminar = .T., RGB(255, 0, 0), RGB(255, 255, 255))"
Thisform.contenido.grdTablas.Columns[1].DynamicForeColor = "IIF(tablas.eliminar = .T., RGB(255, 255, 255), RGB(0, 0, 0))"
Thisform.contenido.grdTablas.Columns[2].DynamicBackColor = "IIF(tablas.eliminar = .T., RGB(255, 0, 0), RGB(255, 255, 255))"
Thisform.contenido.grdTablas.Columns[2].DynamicForeColor = "IIF(tablas.eliminar = .T., RGB(255, 255, 255), RGB(0, 0, 0))"
Thisform.contenido.grdTablas.Columns[3].DynamicBackColor = "IIF(tablas.eliminar = .T., RGB(255, 0, 0), RGB(255, 255, 255))"
Thisform.contenido.grdTablas.Columns[3].DynamicForeColor = "IIF(tablas.eliminar = .T., RGB(255, 255, 255), RGB(0, 0, 0))"

Thisform.seleccionar_hoja()
ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Proveedor:"
Height = 15
Left = 16
Top = 17
Width = 68
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: sel_proveedor
************************************************************
*** PROPIEDADES ***
Top = 12
Left = 83
nombre_campo_codigo = idProv
esnumerico = .T.
nombre_campo_desc = razSoc
nombre_tabla = proveedor
pkfield = idProv
alternative_cols = nomFant
anchos_cols = 200,200
title_cols = Descripción,Nombre de Fantasía
Name = "sel_proveedor"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***
PROCEDURE recuperar_datos
&& En este método al seleccionar el proveedor recupero la configuración de la planilla que tenga
&& asociada el proveedor
LOCAL loRes, lcSql
LOCAL loResCol

loRes = CREATEOBJECT("odbc_result")
loResCol = CREATEOBJECT("odbc_result")
lcSql = ""

SELECT hojas
ZAP
SELECT tablas
ZAP
SELECT columnas
ZAP

lcSql = "SELECT * FROM planillas WHERE idProv = " + ALLTRIM(STR(This.valcpoid))
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_tempo"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN
ENDIF

SELECT cur_tempo
GO TOP
IF RECCOUNT("cur_tempo") > 0 THEN
	Thisform.idPlanilla = cur_tempo.idPlanilla
	Thisform.contenido.txtFileName.Value = cur_tempo.ruta
	Thisform.isEdit = .T.
ELSE
	Thisform.isEdit = .F.
	Thisform.idPlanilla = 0
	MESSAGEBOX("No hay planillas configuradas para este proveedor", 0+64, Thisform.Caption)
	RETURN
ENDIF

loRes.Close_Query()

&& Recupero las hojas que tiene la planilla
lcSql = "SELECT * FROM hojas WHERE idPlanilla = " + ALLTRIM(STR(Thisform.idPlanilla))
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_tempo"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN
ENDIF

SELECT cur_tempo
GO TOP

DO WHILE !EOF("cur_tempo")
	SELECT hojas
	APPEND BLANK
	REPLACE hojas.idHoja WITH cur_tempo.idHoja
	REPLACE hojas.idPlanilla WITH cur_tempo.idPlanilla ADDITIVE
	REPLACE hojas.nombre WITH cur_tempo.nombre ADDITIVE

	SELECT cur_tempo
	SKIP
ENDDO

loRes.Close_Query()

lcSql = "SELECT * FROM tablas WHERE idPlanilla = " + ALLTRIM(STR(Thisform.idPlanilla))
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_tempo"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN
ENDIF

SELECT cur_tempo
GO TOP

DO WHILE !EOF("cur_tempo")
	SELECT tablas
	APPEND BLANK
	REPLACE tablas.idTabla WITH cur_tempo.idTabla
	REPLACE tablas.idHoja WITH cur_tempo.idHoja ADDITIVE
	REPLACE tablas.idPlanilla WITH cur_tempo.idPlanilla ADDITIVE
	REPLACE tablas.tableName WITH ALLTRIM(cur_tempo.tableName) ADDITIVE
	REPLACE tablas.nFilaDD WITH cur_tempo.nFilaDD ADDITIVE
	REPLACE tablas.nFilaHH WITH cur_tempo.nFilaHH ADDITIVE
	
	lcSql = "SELECT * FROM columnas WHERE idTabla = " + ALLTRIM(STR(tablas.idTabla))
	loResCol.ActiveConnection = goConn.ActiveConnection
	loResCol.Cursor_Name = "cur_col"
	
	IF !loResCol.OpenQuery(lcSql) THEN
		MESSAGEBOX(loResCol.Error_Message, 0+48, Thisform.Caption)
		RETURN
	ENDIF
	
	SELECT cur_col
	GO TOP
	DO WHILE !EOF("cur_col")
		SELECT columnas
		APPEND BLANK
		REPLACE columnas.idColumna WITH cur_col.idColumna
		REPLACE columnas.idTabla WITH cur_col.idTabla ADDITIVE
		REPLACE columnas.fieldName WITH cur_col.fieldName ADDITIVE
		REPLACE columnas.dataType WITH cur_col.dataType ADDITIVE
		REPLACE columnas.nroColRef WITH cur_col.nroColRef ADDITIVE
		REPLACE columnas.insertar WITH .F. ADDITIVE
		REPLACE columnas.modificar WITH .F. ADDITIVE
		REPLACE columnas.eliminar WITH .F. ADDITIVE
	
		SELECT cur_col
		SKIP
	ENDDO
	
	loResCol.Close_Query()

	SELECT cur_tempo
	SKIP
ENDDO

loRes.Close_Query()

SELECT hojas
GO TOP
Thisform.Contenido.grdHojas.Refresh()
SELECT tablas
SET FILTER TO tablas.idHoja = hojas.idHoja IN "tablas"
GO TOP
Thisform.Contenido.grdTablas.Refresh()
SELECT columnas
SET FILTER TO columnas.idTabla = tablas.idTabla IN "columnas"
GO TOP

ENDPROC


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Archivo:"
Height = 15
Left = 16
Top = 44
Width = 68
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: txtFileName
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 85
Top = 40
Width = 480
ischaracter = .T.
Name = "txtFileName"

*** METODOS ***


************************************************************
OBJETO: btnBuscar
************************************************************
*** PROPIEDADES ***
Top = 38
Left = 566
Height = 25
Width = 35
Caption = "..."
Name = "btnBuscar"

*** METODOS ***
PROCEDURE Click
LOCAL lcFileName

lcFileName = GETFILE("xls;xlsx;odt", "Seleccionar")

IF ALLTRIM(lcFileName) == "" THEN
	Thisform.contenido.txtFileName.Value = ""
ELSE
	Thisform.contenido.txtFileName.Value = lcFileName
ENDIF


ENDPROC


************************************************************
OBJETO: btnGrabar
************************************************************
*** PROPIEDADES ***
Top = 493
Left = 672
Name = "btnGrabar"

*** METODOS ***
PROCEDURE Click
LOCAL loRes
LOCAL loCommand
LOCAL lcSql
LOCAL lnProxID
LOCAL lnIdPlanilla, lnIdHoja, lnIdTabla, lnIdColumna
LOCAL lcFileName

loRes = CREATEOBJECT("odbc_result")
loCommand = CREATEOBJECT("odbc_command")
lcSql = ""
lnIdHoja = 0
lnIdTabla = 0
lnIdColumna = 0
lcFileName = ""

SELECT hojas
SET FILTER TO

SELECT tablas
SET FILTER TO

SELECT columnas
SET FILTER TO

IF Thisform.Contenido.sel_proveedor.valcpoid = 0 THEN
	MESSAGEBOX("No hay ningún proveedor cargado", 0+48, Thisform.Caption)
	RETURN
ENDIF

IF ALLTRIM(Thisform.Contenido.txtFileName.Value) == "" THEN
	MESSAGEBOX("No hay ningún archivo asignado", 0+48, Thisform.Caption)
	RETURN
ENDIF

SELECT hojas
IF RECCOUNT("hojas") = 0 THEN
	MESSAGEBOX("No hay hojas cargadas", 0+48, Thisform.Caption)
	RETURN
ENDIF

SELECT tablas
IF RECCOUNT("tablas") = 0 THEN
	MESSAGEBOX("No hay tablas cargadas", 0+48, Thisform.Caption)
	RETURN
ENDIF

SELECT columnas
IF RECCOUNT("columnas") = 0 THEN
	MESSAGEBOX("No hay columnas definidas")
	RETURN
ENDIF

lcFileName = IIF(VAL(getConfig("SQLSRV")) = 1, ;
		Thisform.Contenido.txtFileName.Value, ;
		STRTRAN(Thisform.Contenido.txtFileName.Value, "\", "\\"))

goConn.BeginTransaction()

IF !Thisform.isEdit THEN
	lnIdPlanilla = goConn.GetNextID("planillas", "idPlanilla")

	lcSql = "INSERT INTO planillas ( "
	lcSql = lcSql + "	idPlanilla, "
	lcSql = lcSql + "	idProv, "
	lcSql = lcSql + "	ruta) "
	lcSql = lcSql + "VALUES ( "
	lcSql = lcSQl + ALLTRIM(STR(lnIdPlanilla)) + ", "
	lcSql = lcSql + ALLTRIM(STR(Thisform.Contenido.sel_proveedor.valcpoid)) + ", "
	lcSql = lcSql + "'" + ALLTRIM(lcFileName) + "')"

	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql

	IF !loCommand.Execute() THEN
		goConn.Rollback()
		MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
		RETURN
	ENDIF
ELSE
	lnIdPlanilla = Thisform.idPlanilla
	
	lcSql = "UPDATE planillas "
	lcSql = lcSql + "SET planillas.ruta = '" + ALLTRIM(lcFileName) + "' "
	lcSql = lcSql + "WHERE planillas.idPlanilla = " + ALLTRIM(STR(lnIdPlanilla))
	
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql 
	
	IF !loCommand.Execute() THEN
		goConn.Rollback()
		MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
		RETURN
	ENDIF
ENDIF

SELECT hojas
GO TOP

DO WHILE !EOF("hojas")
	
	IF hojas.insertar THEN
		lnIdHoja = hojas.idHoja
		
		lcSql = "INSERT INTO hojas (idHoja, idPlanilla, Nombre) "
		lcSql = lcSql + "VALUES ( "
		lcSql = lcSql + ALLTRIM(STR(lnIdHoja)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnIdPlanilla)) + ", "
		lcSql = lcSql + "'" + ALLTRIM(hojas.nombre) + "')"
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
			RETURN
		ENDIF
	ELSE
		IF hojas.modificar THEN
			lnIdHoja = hojas.idHoja
			
			lcSql = "UPDATE hojas "
			lcSql = lcSql + "SET nombre = '" + ALLTRIM(hojas.nombre) + "' "
			lcSql = lcSql + "WHERE idHoja = " + ALLTRIM(STR(lnIdHoja)) + " "
			lcSql = lcSql + "	AND idPlanilla = " + ALLTRIM(STR(lnIdPlanilla))
			
			loCommand.ActiveConnection = goConn.ActiveConnection
			loCommand.CommandText = lcSql
			
			IF !loCommand.Execute() THEN
				goConn.Rollback()
				MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
				RETURN
			ENDIF
			
		ELSE
			IF hojas.eliminar THEN
				lnIdHoja = hojas.idHoja
				&& Tengo que eliminar por orden las tablas relacionadas
				
				SELECT tablas
				GO TOP
				
				DO WHILE !EOF("tablas")
					IF tablas.idHoja = hojas.idHoja THEN
						lcSql = "DELETE FROM columnas WHERE idTabla = " + ALLTRIM(STR(tablas.idTabla))
						loCommand.ActiveConnection = goConn.ActiveConnection
						loCommand.CommandText = lcSql
						
						IF !loCommand.Execute() THEN
							goConn.Rollback()
							MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
							RETURN
						ENDIF
						
						lcSql = "DELETE FROM tablas WHERE idTabla = " + ALLTRIM(STR(tablas.idTabla))
						loCommand.ActiveConnection = goConn.ActiveConnection
						loCommand.CommandText = lcSql
						
						IF !loCommand.Execute() THEN
							goConn.Rollback()
							MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
							RETURN
						ENDIF
					ENDIF
				
					SELECT tablas
					SKIP
				ENDDO
			
				lcSql = "DELETE FROM hojas WHERE idHoja = " + ALLTRIM(STR(lnIdHoja))
				
				loCommand.ActiveConnection = goConn.ActiveConnection
				loCommand.CommandText = lcSql
				
				IF !loCommand.execute() THEN
					goConn.Rollback()
					MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
					RETURN
				ENDIF
			ENDIF
		ENDIF
	ENDIF
	
	SELECT tablas
	GO TOP
	
	DO WHILE !EOF("tablas")
		lnIdTabla = tablas.idTabla
		
		IF tablas.idHoja = hojas.idHoja THEN
			&& Tengo que hacer el proceso de insersión o actualización de registro
			&& de las tablas
			
			IF tablas.insertar THEN
				lnIdTabla = goConn.GetNextID("tablas", "idTabla")
			
				lcSql = "INSERT INTO tablas ("
				lcSql = lcSql + "idTabla, idHoja, idPlanilla, tableName, nFilaDD, nFilaHH) "
				lcSql = lcSql + "VALUES ( " + ALLTRIM(STR(lnIdTabla)) + ", "
				lcSql = lcSql + ALLTRIM(STR(IIF(lnIdHoja = 0, hojas.idHoja, lnIdHoja))) + ", "
				lcSql = lcSql + ALLTRIM(STR(lnIdPlanilla)) + ", "
				lcSql = lcSql + "'" + ALLTRIM(tablas.tableName) + "', "
				lcSql = lcSql + ALLTRIM(STR(nFilaDD)) + ", "
				lcSql = lcSql + ALLTRIM(STR(nFilaHH)) + ")"
				
				loCommand.ActiveConnection = goConn.ActiveConnection
				loCommand.CommandText = lcSql
				
				IF !loCommand.Execute() THEN
					goConn.Rollback()
					MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
					RETURN
				ENDIF
				
			ELSE
				IF tablas.modificar THEN
					lnIdTabla = tablas.idTabla
					
					lcSql = "UPDATE tablas "
					lcSql = lcSql + "SET tablas.tableName = '" + ALLTRIM(tablas.tableName) + "', "
					lcSql = lcSql + "	tablas.nFilaDD = " + ALLTRIM(STR(tablas.nFilaDD)) + ", "
					lcSql = lcSql + "	tablas.nFilaHH = " + ALLTRIM(STR(tablas.nFilaHH)) + " "
					lcSql = lcSql + "WHERE idTabla = " + ALLTRIM(STR(tablas.idTabla))
					
					loCommand.ActiveConnection = goConn.ActiveConnection
					loCommand.CommandText = lcSql
					
					IF !loCommand.Execute() THEN
						goConn.Rollback()
						MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
						RETURN
					ENDIF
				ELSE
					IF tablas.eliminar THEN
						lnIdTabla = tablas.idTabla
						
						lcSql = "DELETE FROM columnas WHERE idTabla = " + ALLTRIM(STR(lnIdTabla))
						
						loCommand.ActiveConnection = goConn.ActiveConnection
						loCommand.CommandText = lcSql
						
						IF !loCommand.Execute() THEN
							goConn.Rollback()
							MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
							RETURN
						ENDIF
						
						lcSql = "DELETE FROM tablas WHERE idTabla = " + ALLTRIM(STR(lnIdTabla))
						
						loCommand.ActiveConnection = goConn.ActiveConnection
						loCommand.CommandText = lcSql
						
						IF !loCommand.Execute() THEN
							goConn.Rollback()
							MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
							RETURN
						ENDIF
					ENDIF
				ENDIF
			ENDIF
			
			SELECT columnas
			GO TOP
			
			DO WHILE !EOF("columnas")
				IF columnas.idTabla = tablas.idTabla THEN
					IF columnas.insertar THEN
						&& lnIdColumna = goConn.GetNextID("columnas", "idColumna")
						
						lcSql = "SELECT MAX(idColumna) AS maxID "
						lcSql = lcSql + "FROM columnas "
						lcSql = lcSql + "WHERE columnas.idTabla = " + ALLTRIM(STR(lnIdTabla))
						
						loRes.ActiveConnection = goConn.ActiveConnection
						loRes.Cursor_Name = "cur_temp"
						
						IF !loRes.OpenQuery(lcSql) THEN
							goConn.Rollback()
							MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
							RETURN
						ENDIF
						
						SELECT cur_temp
						IF ISNULL(cur_temp.maxID) THEN
							lnIdColumna = 1
						ELSE
							lnIdColumna = cur_temp.maxID + 1
						ENDIF
						
						loRes.Close_Query()
						
						lcSql = "INSERT INTO columnas ( "
						lcSql = lcSql + "idColumna, idTabla, fieldName, dataType, nroColRef) "
						lcSql = lcSql + "VALUES ( "
						lcSql = lcSql + ALLTRIM(STR(lnIdColumna)) + ", "
						lcSql = lcSql + ALLTRIM(STR(IIF(lnIdTabla = 0, tablas.idTabla, lnIdTabla))) + ", "
						lcSql = lcSql + "'" + ALLTRIM(columnas.fieldName) + "', "
						lcSql = lcSql + "'" + ALLTRIM(columnas.dataType) + "', "
						lcSql = lcSql + ALLTRIM(STR(columnas.nroColRef)) + ")"
						
						loCommand.ActiveConnection = goConn.ActiveConnection
						loCommand.CommandText = lcSql
						
						IF !loCommand.Execute() THEN
							goConn.Rollback()
							MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
							RETURN
						ENDIF
					ELSE
						IF columnas.modificar THEN
							lnIdColumna = columnas.idColumna
							
							lcSql = "UPDATE columnas "
							lcSql = lcSql + "SET columnas.fieldName = '" + ALLTRIM(columnas.fieldName) + "', "
							lcSql = lcSql + "	columnas.dataType = '" + ALLTRIM(columnas.dataType) + "', "
							lcSql = lcSql + "	columnas.nroColRef = " + ALLTRIM(STR(columnas.nroColRef)) + " "
							lcSql = lcSql + "WHERE columnas.idColumna = " + ALLTRIM(STR(lnIdColumna)) + " "
							lcSql = lcSql + "	AND columnas.idTabla = " + ALLTRIM(STR(lnIdTabla))
							
							loCommand.ActiveConnection = goConn.ActiveConnection
							loCommand.CommandText = lcSql
							
							IF !loCommand.Execute() THEN
								goConn.Rollback()
								MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
								RETURN
							ENDIF
						ELSE
							IF columnas.eliminar THEN
								lnIdColumna = columnas.idColumna
								
								lcSql = "DELETE FROM columnas WHERE idColumna = " + ALLTRIM(STR(lnIdColumna))
								lcSql = lcSql + " AND idTabla = " + ALLTRIM(STR(lnIdTabla))
								
								loCommand.ActiveConnection = goConn.ActiveConnection
								loCommand.CommandText = lcSql
								
								IF !loCommand.Execute() THEN
									goConn.Rollback()
									MESSAGEBOX(loCommand.ErrorMessage, 0+487, Thisform.Caption)
									RETURN
								ENDIF
							ENDIF
						ENDIF
					ENDIF
				ENDIF
			
				SELECT columnas
				SKIP
			ENDDO					
		ENDIF
	
		SELECT tablas
		SKIP
	ENDDO
	
	SELECT hojas
	SKIP
ENDDO

goConn.Commit()

SELECT hojas
ZAP
SELECT tablas
ZAP
SELECT columnas
ZAP

Thisform.Contenido.txtFileName.blanquear()
Thisform.Contenido.sel_proveedor.blanquear()

MESSAGEBOX("La planilla fué configurada con éxito", 0+64, Thisform.Caption)
ENDPROC


************************************************************
OBJETO: btnCancelar
************************************************************
*** PROPIEDADES ***
Top = 493
Left = 720
Name = "btnCancelar"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Nombre de Hoja:"
Height = 15
Left = 16
Top = 103
Width = 100
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: txtNombreHoja
************************************************************
*** PROPIEDADES ***
Format = ""
Height = 21
Left = 119
MaxLength = 100
Top = 99
Width = 274
ischaracter = .T.
Name = "txtNombreHoja"

*** METODOS ***


************************************************************
OBJETO: btnAgregar
************************************************************
*** PROPIEDADES ***
Top = 85
Left = 398
Height = 37
Width = 39
ToolTipText = "Agregar Hoja"
Name = "btnAgregar"

*** METODOS ***
PROCEDURE Click
IF ALLTRIM(This.Parent.txtNombreHoja.Value) == "" THEN
	MESSAGEBOX("Debe ingresar el nombre de la hoja", 0+48, Thisform.Caption)
	RETURN
ENDIF

SELECT hojas
APPEND BLANK
REPLACE hojas.idHoja WITH RECCOUNT("hojas")
REPLACE hojas.idPlanilla WITH Thisform.idPlanilla ADDITIVE
REPLACE hojas.nombre WITH This.Parent.txtNombreHoja.Value ADDITIVE
REPLACE hojas.insertar WITH .T. ADDITIVE
REPLACE hojas.modificar WITH .F. ADDITIVE
REPLACE hojas.eliminar WITH .F. ADDITIVE

SELECT hojas
This.Parent.grdHojas.Refresh
This.Parent.txtNombreHoja.blanquear()
This.Parent.txtNombreHoja.SetFocus()

GO BOTTOM
Thisform.seleccionar_hoja()
ENDPROC


************************************************************
OBJETO: grdHojas
************************************************************
*** PROPIEDADES ***
Height = 344
Left = 15
Top = 147
Width = 238
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdHojas"
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
Thisform.seleccionar_hoja()

ENDPROC


************************************************************
OBJETO: btnEliminar
************************************************************
*** PROPIEDADES ***
Top = 85
Left = 438
Height = 37
Width = 41
Caption = ""
Name = "btnEliminar"

*** METODOS ***
PROCEDURE Click
LOCAL lnResp

lnResp = 0
lnResp = MESSAGEBOX("¿Está seguro que desea eliminar esta hoja?", 4+32, Thisform.Caption)

IF lnResp = 6 THEN
	SELECT tablas
	GO TOP
	
	DO WHILE !EOF("tablas")
		SELECT columnas
		GO TOP
		
		DO WHILE !EOF("columnas")
			IF columnas.idTabla = tablas.idTabla THEN
				SELECT columnas
				LOCK()
				REPLACE columnas.eliminar WITH .T.
				UNLOCK
			ENDIF
		
			SELECT columnas
			SKIP
		ENDDO
	
		IF tablas.idHoja = hojas.idHoja THEN
			SELECT tablas
			LOCK()
			REPLACE tablas.eliminar WITH .T.
			UNLOCK
		ENDIF
	
		SELECT tablas
		SKIP
	ENDDO
	
	SELECT hojas
	LOCK()
	REPLACE hojas.eliminar WITH .T.
	UNLOCK
ENDIF

SELECT hojas
Thisform.Contenido.grdHojas.Refresh()
SELECT tablas
Thisform.Contenido.grdTablas.Refresh()

ENDPROC


************************************************************
OBJETO: grdTablas
************************************************************
*** PROPIEDADES ***
Height = 344
Left = 255
Top = 147
Width = 461
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdTablas"
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
Thisform.seleccionar_tabla()
ENDPROC


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Hojas"
Height = 15
Left = 20
Top = 130
Width = 100
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Tablas"
Height = 15
Left = 267
Top = 130
Width = 58
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: btnAgregarTabla
************************************************************
*** PROPIEDADES ***
Top = 146
Left = 719
ToolTipText = "Nueva Tabla"
Name = "btnAgregarTabla"

*** METODOS ***
PROCEDURE Click
LOCAL loForm

SELECT columnas
SET FILTER TO columnas.idTabla = 0

loForm = CREATEOBJECT("cls_xls_sheet_config")
loForm.idHoja = hojas.idHoja
loForm.idPlanilla = Thisform.idPlanilla
loForm.Caption = "Tablas de la " + ALLTRIM(hojas.nombre)
loForm.isEdit = .F.
loForm.show()

IF loForm.press_aceptar THEN
	SELECT tablas
	Thisform.contenido.grdTablas.Refresh()
	SELECT tablas
	GO BOTTOM
	Thisform.seleccionar_tabla()
ENDIF

loForm.release()

ENDPROC


************************************************************
OBJETO: btnEditarTabla
************************************************************
*** PROPIEDADES ***
Top = 193
Left = 719
ToolTipText = "Editar Tabla"
Name = "btnEditarTabla"

*** METODOS ***
PROCEDURE Click
LOCAL loForm

SELECT tablas
IF RECCOUNT("tablas") = 0 THEN
	MESSAGEBOX("No hay tablas selccionadas", 0+48, Thisform.Caption)
	RETURN
ENDIF

IF tablas.eliminar THEN
	MESSAGEBOX("Esta tabla ha sido eliminada, no se puede editar", 0+64, Thisform.Caption)
	RETURN
ENDIF

SELECT columnas

loForm = CREATEOBJECT("cls_xls_sheet_config")
loForm.idHoja = hojas.idHoja
loForm.idPlanilla = Thisform.idPlanilla
loForm.idTabla = tablas.idTabla
loForm.Caption = "Tablas de la " + ALLTRIM(hojas.nombre)
loForm.isEdit = .T.
loForm.show()

IF loForm.press_aceptar THEN
	SELECT tablas
	Thisform.contenido.grdTablas.Refresh()
ENDIF

loForm.release()

ENDPROC


************************************************************
OBJETO: btnEliminiarTabla
************************************************************
*** PROPIEDADES ***
Top = 238
Left = 719
ToolTipText = "EliminarTabla"
Name = "btnEliminiarTabla"

*** METODOS ***
PROCEDURE Click
LOCAL lnResp

lnResp = MESSAGEBOX("¿Está seguro que desea eliminar la columna?", 4+32, Thisform.Caption)

IF lnResp = 6 THEN
	SELECT columnas
	GO TOP
	DO WHILE !EOF("columnas")
		IF columnas.idTabla = tablas.idTabla THEN
			LOCK()
			REPLACE columnas.insertar WITH .F.
			REPLACE columnas.modificar WITH .F. ADDITIVE
			REPLACE columnas.eliminar WITH .T. ADDITIVE
			UNLOCK
		ENDIF
	
		SELECT columnas
		SKIP
	ENDDO

	SELECT tablas
	LOCK()
	REPLACE tablas.insertar WITH .F.
	REPLACE tablas.modificar WITH .F. ADDITIVE
	REPLACE tablas.eliminar WITH .T. ADDITIVE
	UNLOCK
ENDIF

SELECT tablas
Thisform.Contenido.grdTablas.Refresh()
ENDPROC


************************************************************
OBJETO: CLSLINEA1
************************************************************
*** PROPIEDADES ***
Height = 0
Left = 13
Top = 73
Width = 755
Name = "CLSLINEA1"

*** METODOS ***


************************************************************
OBJETO: cls_xls_config
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: actu_tressols
************************************************************
*** PROPIEDADES ***
Height = 16
Width = 100
desc1 = 0.00
desc2 = 0.00
desc3 = 0.00
desc4 = 0.00
margenmay = 0.00
margenmin = 0.00
idprov = 0
path = 
error_message = 
alic_iva = 21
Name = "actu_tressols"

*** METODOS ***
PROCEDURE open
CREATE CURSOR cur_art(	;
	Codigo			C(20)	,;
	Descrip			C(100)	,;
	Precio			C(20)	,;
	Cod_Rubro		C(20)	,;
	Rubro			C(100)	,;
	Cod_Marca		C(20)	,;
	Marca			C(100)	,;
	Descuento		C(20)	,;
	Nov				C(20)	)


CREATE CURSOR cur_artic(	;
	Codigo			C(20)	,;
	Descrip			C(100)	,;
	Precio			float(10,2)	,;
	Codsrb			C(20)	,;
	SubRubro		C(100)	,;
	Cod_Marca		C(20)	,;
	Marca			C(100)	,;
	Descuento		C(20)	,;
	Nov				C(20)	)

SELECT cur_art
INDEX ON Codigo TAG Codigo ASCENDING

SELECT cur_artic
INDEX ON Codigo TAG Codigo ASCENDING

WAIT WINDOW "Leyendo artículos desde TRESSOLS..." NOWAIT

SELECT cur_art
APPEND FROM this.path + "TRESSOLS.CSV " DELIMITER WITH CHARACTER "," AS 1252 

SELECT cur_art

INSERT INTO cur_artic ;
	SELECT STRTRAN(ALLTRIM(Codigo),"'"," ") AS Codigo, descrip, float(VAL(precio)), cod_rubro, rubro, cod_marca, marca, descuento, nov ;
	FROM cur_art ;
	WHERE STRTRAN(ALLTRIM(Codigo),"'"," ") NOT LIKE '%Tapice%'

USE IN cur_art 

SELECT cur_artic
IF RECCOUNT("cur_artic") > 0 THEN
	GO TOP
ENDIF
ENDPROC
PROCEDURE actualizar_articulos
LOCAL loResult, loCommand, lcSql, lnIdFamilia, lnIdSubFam
LOCAL lnIdMarca, lcCodigo, lcDescripcio, lnPrecio
LOCAL lcFamilia, lcSubFam, lcMarca, loDT, lcLinkFoto, lcObserv
LOCAL loProg, i, lnTotReg

loResult = CREATEOBJECT("odbc_result")
loCommand = CREATEOBJECT("odbc_command")
loDT = CREATEOBJECT("datetime")
loProg = CREATEOBJECT("_thermometer")
lcSql = ""
lnIdFamilia = 0
lnIdSubFam = 0
lnIdMarca = 0
lcCodigo = ""
lcDescripcio = ""
lnPrecio = 0.00
lcFamilia = ""
lcSubFam = ""
lcMarca = ""
lcLinkFoto = ""
lcObserv = ""
lnTotReg = 0 
i = 0

This.descargar()
This.open()
loProg.Show()

&& Establezco el nivel de aislamiento de lectura no confirmada
loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = "set session transaction isolation level read uncommitted"

IF !loCommand.Execute() THEN
	goConn.Rollback()
	This.error_message = loCommand.ErrorMessage
	RETURN .F.
ENDIF

goConn.BeginTransaction()



&& Recorro los articulos y comienzo la actualizacion articulo por articulo
SELECT cur_artic
lnTotReg = RECCOUNT("cur_artic")

DO WHILE !EOF("cur_artic")
	lcCodigo = ALLTRIM(cur_artic.codigo)
	lcDescripcio = ALLTRIM(cur_artic.descrip)
	lnPrecio = cur_artic.precio
	lcFamilia = "VARIOS"
	lcSubFam = ALLTRIM(cur_artic.subrubro)
	lcMarca = ALLTRIM(cur_artic.marca)
	&& lcLinkFoto = ALLTRIM(cur_artic.linkfoto)
	
	**********************************************************************************************
	&& Levanto la familia
	**********************************************************************************************
	lcSql = "SELECT * FROM familias WHERE LTRIM(RTRIM(descripcio)) = '" + ALLTRIM(lcFamilia) + "'"
	loResult.ActiveConnection = goConn.ActiveConnection
	loResult.Cursor_Name = "cur_Familia"

	IF !loResult.OpenQuery(lcSql) THEN
		This.Error_Message = loResult.Error_Message
		goConn.Rollback()
		RETURN .F.
	ENDIF

	SELECT cur_Familia
	IF RECCOUNT("cur_Familia") = 0 THEN
		lnIdFamilia = goConn.GetNextID("familias", "idFamilia")

		lcSql = "INSERT INTO familias ( "
		lcSql = lcSql + "idFamilia, "
		lcSql = lcSql + "descripcio, "
		lcSql = lcSql + "usuAlta, "
		lcSql = lcSql + "fecAlta, "
		lcSql = lcSql + "idHostAlta) VALUES ( "
		lcSql = lcSql + ALLTRIM(STR(lnIdFamilia)) + ", "
		lcSql = lcSql + "'" + lcFamilia + "', "
		lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
		lcSql = lcSql + loDT.getDateTime() + ", "
		lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "')"
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			This.Error_Message = loCommand.ErrorMessage
			loResult.Close_Query()
			RETURN .F.
		ENDIF
	ELSE
		lnIdFamilia = cur_Familia.IdFamilia
	ENDIF

	loResult.Close_Query()


	**********************************************************************************************
	&& Levanto la subfamilia
	**********************************************************************************************
	IF !EMPTY(ALLTRIM(lcSubFam)) THEN 
		lcSql = "SELECT * FROM subfam WHERE LTRIM(RTRIM(descripcio)) = '" + ALLTRIM(lcSubFam) + "'"
		loResult.ActiveConnection = goConn.ActiveConnection
		loResult.Cursor_Name = "cur_SubFam"

		IF !loResult.OpenQuery(lcSql) THEN
			This.Error_Message = loResult.Error_Message
			goConn.Rollback()
			loResult.Close_Query()
			RETURN .F.
		ENDIF

		IF RECCOUNT("cur_SubFam") = 0 THEN
			lnIdSubFam = goConn.GetNextID("subfam", "idSubFam")

			lcSql = "INSERT INTO subfam ( "
			lcSql = lcSql + "	idSubFam, "
			lcSql = lcSql + "	descripcio, "
			lcSql = lcSql + "	usuAlta, "
			lcSql = lcSql + "	fecAlta, "
			lcSql = lcSql + "	idHostAlta) VALUES ("
			lcSql = lcSql + ALLTRIM(STR(lnIdSubFam)) + ", "
			lcSql = lcSql + "'" + lcSubFam + "', "
			lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
			lcSql = lcSql + loDT.getDateTime() + ", "
			lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "')"
			
			loCommand.ActiveConnection = goConn.ActiveConnection
			loCommand.CommandText = lcSql
			
			IF !loCommand.Execute() THEN
				This.Error_Message = loCommand.ErrorMessage
				goConn.Rollback()
				loResult.Close_Query()
				RETURN .F.
			ENDIF
		ELSE
			lnIdSubFam = cur_SubFam.idSubFam
		ENDIF

		loResult.Close_Query()
	ENDIF 
	
	**********************************************************************************************
	&& Levanto la marca
	**********************************************************************************************
	IF !EMPTY(ALLTRIM(lcMarca)) THEN 
		lcSql = "SELECT * FROM marcas WHERE LTRIM(RTRIM(descripcio)) = '" + ALLTRIM(lcMarca) + "'"
		loResult.ActiveConnection = goConn.ActiveConnection
		loResult.Cursor_Name = "cur_mrcs"
		
		IF !loResult.OpenQuery(lcSql) THEN
			goConn.Rollback()
			This.Error_Message = loResult.Error_Message
			RETURN .F.
		ENDIF
		
		SELECT cur_mrcs
		IF RECCOUNT("cur_mrcs") = 0 THEN
			lnIdMarca = goConn.GetNextID("marcas", "idMarca")
			
			lcSql = "INSERT INTO marcas ( "
			lcSql = lcSql + "idmarca, "
			lcSql = lcSql + "descripcio, "
			lcSql = lcSql + "usuAlta, "
			lcSql = lcSql + "fecAlta, "
			lcSql = lcSql + "idHostAlta) VALUES ( "
			lcSql = lcSql + ALLTRIM(STR(lnIdMarca)) + ", "
			lcSql = lcSql + "'" + ALLTRIM(lcMarca) + "', "
			lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
			lcSql = lcSql + loDT.getDateTime() + ", "
			lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "')"
			
			loCommand.ActiveConnection = goConn.ActiveConnection
			loCommand.CommandText = lcSql
			
			IF !loCommand.Execute() THEN
				goConn.Rollback()
				This.Error_Message = loCommand.ErrorMessage
				loResult.Close_Query()
				RETURN .F.
			ENDIF
		ELSE
			lnIdMarca = cur_mrcs.idmarca
		ENDIF
		
		loResult.Close_Query()
	
	ENDIF 
	
	**************************************************************
	&& Doy de alta el artículo en la base de datos
	**************************************************************
	IF !This.insertar_articulo(lnIdFamilia, lnIdSubFam, lnIdMarca, lcCodigo, ;
			lcDescripcio, lnPrecio, lcLinkFoto, lcObserv) THEN
		goConn.Rollback()
		RETURN .F.
	ENDIF
	
	i = i + 1
	WAIT WINDOW "Procesando " + ALLTRIM(STR(i)) + " de " + ALLTRIM(STR(lnTotReg)) + "..." NOWAIT
	loProg.Update((i * 100) / lnTotReg, "Actualizando artículos desde TRESSOLS...")
	
	SELECT cur_artic
	SKIP
ENDDO

goConn.Commit()

&& Establezco el nivel de aislamiento de lectura confirmada
loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = "set session transaction isolation level read committed"

IF !loCommand.Execute() THEN
	goConn.Rollback()
	This.error_message = loCommand.ErrorMessage
	RETURN .F.
ENDIF

loProg.Complete()
RETURN .T.
ENDPROC
PROCEDURE insertar_articulo
PARAMETERS tnIdFamilia, tnIdSubFam, tnIdMarca, tcCodArt, tcDescripcio, tnPrLista, tnLinkFoto, tcObserv

LOCAL 	lnCostoRep, lnMargenMax, lnMargenMin, lnPrVentaMax, lnPrVentaMin,;
		lnFinalMax, lnFinalMin, lcObserv, lnPrLista
LOCAL 	lnBonif1, lnBonif2, lnBonif3, lnBonif4		
LOCAL 	loCommand, lcSql, loResult, lnProxID, loDT, loUniDesp
LOCAL 	lnProxID, lnPrAnt, lnUniDesp, lnPrDif, lnPorVar, lbActuFoto 

loDT = CREATEOBJECT("datetime")
loCommand = CREATEOBJECT("odbc_command")
loResult = CREATEOBJECT("odbc_result")
loUniDesp = CREATEOBJECT("odbc_result")
lcSql = ""
lnCostoRep = 0.00
lnMargenMax = 0.00
lnMargenMin = 0.00
lnPrVentaMax = 0.00
lnPrVentaMin = 0.00
lnFinalMax = 0.00
lnFinalMin = 0.00
lcObserv = ""
lnPrLista = 0.00
lnProxID = 0.00
lnBonif1 = 0.00
lnBonif2 = 0.00
lnBonif3 = 0.00
lnBonif4 = 0.00
lnProxID = 0
lnPrAnt = 0.00
lnUniDesp = 0.00
lnPrDif = 0.00
lnPorVar = 0.00

lcCodigo = ALLTRIM(tcCodArt)
&& lbActuFoto = getglobalcfg("VERFOTODER")

IF INT(VAL(getconfig("SQLSRV"))) = 0 THEN 
	tnLinkFoto = ALLTRIM(STRTRAN(tnLinkFoto,"\","\\"))
ENDIF 

lcSql = "SELECT * FROM articulos WHERE codArt = '" + lcCodigo + "'"
loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_tmp"

IF !loResult.OpenQuery(lcSql) THEN
	MESSAGEBOX(loResult.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_tmp
IF RECCOUNT("cur_tmp") = 0 THEN
	lnBonif1 = this.desc1
	lnBonif2 = this.desc2
	lnBonif3 = this.desc3
	lnBonif4 = this.desc4
	lnMargenMax = this.margenmay
	lnMargenMin = this.margenmin
	
	* Calculo el precio de venta
	lnPrLista = tnPrLista
	lnCostoRep = calcular_costo(lnPrLista, lnBonif1, lnBonif2, lnBonif3, lnBonif4, 0)
	lnPrVentaMax = lnCostoRep + (lnCostoRep * (lnMargenMax / 100))
	lnPrVentaMin = lnCostoRep + (lnCostoRep * (lnMargenMin / 100))
	lnFinalMax = lnPrVentaMax + (lnPrVentaMax * (this.alic_iva / 100))
	lnFinalMin = lnPrVentaMin + (lnPrVentaMin * (this.alic_iva / 100))

	lnProxID = goConn.GetNextID("articulos", "idArticulo")

	lcSql = "INSERT INTO articulos ( "
	lcSql = lcSql + "	idArticulo, "
	lcSql = lcSql + "	idProv, "
	lcSql = lcSql + "	idFamilia, "
	lcSql = lcSql + "	idSubFam, "
	lcSql = lcSql + "	idMarca, "
	lcSql = lcSql + "	codArt, "
	lcSql = lcSql + "	descripcio, "
	lcSql = lcSql + "	alicIVA, "
	lcSql = lcSql + "	tmon, "
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
	lcSql = lcSql + "	prventaMax, "
	lcSql = lcSql + "	prventaMin, "
	lcSql = lcSql + "	prfinalMax, "
	lcSql = lcSql + "	prfinalMin, "
	lcSql = lcSql + "	observ, "
	lcSql = lcSql + "	idUniMed, "
	lcSql = lcSql + "	habilitado, "
	lcSql = lcSql + "	linkfoto, "
	lcSql = lcSql + "	usuAlta, "
	lcSql = lcSql + "	fecAlta, "
	lcSql = lcSql + "	idHostAlta) "
	lcSql = lcSql + "VALUES ( "
	lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", "					&& idAticulo
	lcSql = lcSql + ALLTRIM(STR(This.idProv)) + ", " 				&& Proveedor
	lcSql = lcSql + ALLTRIM(STR(tnIdFamilia)) + ", " 				&& Familia
	lcSql = lcSql + ALLTRIM(STR(tnIdSubFam)) + ", "					&& SubFamilia
	lcSql = lcSql + ALLTRIM(STR(tnIdMarca)) + ", " 					&& Marca
	lcSql = lcSql + "'" + UPPER(ALLTRIM(lcCodigo)) + "', "					&& CodArt
	lcSql = lcSql + "'" + UPPER(STRTRAN(ALLTRIM(tcDescripcio), "'", " ")) + "', "	&& Descripcio
	lcSql = lcSql + ALLTRIM(STR(This.alic_iva, 10, 2)) + ", "		&& alicIVA
	lcSql = lcSql + "'PSO', "										&& tMon
	lcSql = lcSql + "0, "											&& Precio de lista ext.
	lcSql = lcSql + "0, "											&& Cotización
	lcSql = lcSql + ALLTRIM(STR(lnPrLista, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(This.desc1, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(This.desc2, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(This.desc3, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(This.desc4, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnCostoRep, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(This.margenmay, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(This.margenmin, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPrVentaMax, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPrVentaMin, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnFinalMax, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnFinalMin, 10, 2)) + ", "
	lcSql = lcSql + "'" + UPPER(STRTRAN(ALLTRIM(tcObserv), "'", " ")) + "', " && Observ
	lcSql = lcSql + "1, "											&& idUniMed
	lcSql = lcSql + "1, "											&& habilitado
	
&&	IF !lbActuFoto THEN 
&&		lcSql = lcSql + "NULL, " 	
&&	ELSE 
		lcSql = lcSql + "'" + UPPER(ALLTRIM(tnLinkFoto)) + "', "	
&&	ENDIF 
			
	lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
	lcSql = lcSql + loDT.getDateTime() + ", "
	lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "')"

	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute() THEN
		This.error_message = loCommand.ErrorMessage
		loResult.Close_Query()
		RETURN .F.
	ENDIF
	
	&& Agrego el registro al codiart
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
	lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", "
	lcSql = lcSql + "'" + UPPER(ALLTRIM(lcCodigo)) + "', "
	lcSql = lcSql + "'" + UPPER(ALLTRIM(lcCodigo)) + "', "
	lcSql = lcSql + "'CP', "
	lcSql = lcSql + "1, "
	lcSql = lcSql + "0, "
	lcSql = lcSql + "'CV')"
	
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute() THEN
		this.errorMessage = loCommand.ErrorMessage
		loResult.Close_Query()
		RETURN .F.
	ENDIF	
	
ELSE
	&& Me fijo si en art_unid esta el articulo
	lcSql = "SELECT	* "
	lcSql = lcSql + "FROM art_unid "
	lcSql = lcSql + "WHERE art_unid.idArticulo = " + ALLTRIM(STR(cur_tmp.IdArticulo))

	loUniDesp.ActiveConnection = goConn.ActiveConnection
	loUniDesp.Cursor_Name = "cur_ud"

	IF !loUniDesp.OpenQuery(lcSql) THEN
		MESSAGEBOX(loUniDesp.Error_Message, 0+48, Thisform.Caption)
		loResult.Close_Query()
		RETURN .F.
	ENDIF

	SELECT cur_ud
	IF RECCOUNT("cur_ud") > 0 THEN
		lnUniDesp = cur_ud.cantUD
	ELSE
		lnUniDesp = 0.00
	ENDIF

	loUniDesp.Close_Query()

	&& Calculo la variacion en el cambio de precio
	lnPrAnt = cur_tmp.prLista
	
	IF tnPrLista > lnPrAnt THEN
		lnPrDif = tnPrLista  - lnPrAnt 
		IF lnPrAnt <> 0 THEN
			lnPorVar = (lnPrDif * 100) / lnPrAnt 
		ELSE
			lnPorVar = 100
		ENDIF
	ELSE
		lnPrDif = lnPrAnt  - tnPrLista 
		IF lnPrAnt <> 0 THEN
			lnPorVar = ((lnPrDif * 100) / lnPrAnt) * -1
		ELSE
			lnPorVar = 100
		ENDIF
	ENDIF
	
	lnBonif1 = IIF(this.desc1 = 0, cur_tmp.bonif1, this.desc1)
	lnBonif2 = IIF(this.desc2 = 0, cur_tmp.bonif2, this.desc2)
	lnBonif3 = IIF(this.desc3 = 0, cur_tmp.bonif3, this.desc3)
	lnBonif4 = IIF(this.desc4 = 0, cur_tmp.bonif4, this.desc3)
	lnMargenMax = IIF(this.margenmay = 0, cur_tmp.margenMax, this.margenmay)
	lnMargenMin = IIF(this.margenmin = 0, cur_tmp.margenMin, this.margenmin)

	* Calculo el precio de venta
	IF lnUniDesp <> 0 THEN 
		lnPrLista = tnPrLista / lnUniDesp 
	ELSE 
		lnPrLista = tnPrLista
	ENDIF 

	lnCostoRep = calcular_costo(lnPrLista, lnBonif1, lnBonif2, lnBonif3, lnBonif4, 0)
	lnPrVentaMax = lnCostoRep + (lnCostoRep * (lnMargenMax / 100))
	lnPrVentaMin = lnCostoRep + (lnCostoRep * (lnMargenMin / 100))
	lnFinalMax = lnPrVentaMax + (lnPrVentaMax * (this.alic_iva / 100))
	lnFinalMin = lnPrVentaMin + (lnPrVentaMin * (this.alic_iva / 100))

	&& En caso de existir el código, modifico el artículo
	lcSql = "UPDATE articulos "
	lcSql = lcSql + "SET 	idProv = " + ALLTRIM(STR(This.idProv)) + ", " 				
&&	lcSql = lcSql + "		idFamilia = " + ALLTRIM(STR(tnIdFamilia)) + ", " 			
&&	lcSql = lcSql + "		idSubFam = " + ALLTRIM(STR(tnIdSubFam)) + ", "					
&&	lcSql = lcSql + "		idMarca = " + ALLTRIM(STR(tnIdMarca)) + ", " 					
&&	lcSql = lcSql + "		descripcio = '" + STRCONV(STRTRAN(ALLTRIM(tcDescripcio), "'", " "),11) + "', "
	lcSql = lcSql + "		descripcio = '" + UPPER(STRTRAN(ALLTRIM(tcDescripcio), "'", " ")) + "', "
	lcSql = lcSql + "		alicIVA = " + ALLTRIM(STR(This.alic_iva, 10, 2)) + ", "
	lcSql = lcSql + "		prLista = " + ALLTRIM(STR(lnPrLista, 10, 2)) + ", "
	lcSql = lcSql + "		bonif1 = " + ALLTRIM(STR(lnBonif1, 10, 2)) + ", "
	lcSql = lcSql + "		bonif2 = " + ALLTRIM(STR(lnBonif2, 10, 2)) + ", "
	lcSql = lcSql + "		bonif3 = " + ALLTRIM(STR(lnBonif3, 10, 2)) + ", "
	lcSql = lcSql + "		bonif4 = " + ALLTRIM(STR(lnBonif4, 10, 2)) + ", "
	lcSql = lcSql + "		costoRep = " + ALLTRIM(STR(lnCostoRep, 10, 2)) + ", "
	lcSql = lcSql + "		margenMax = " + ALLTRIM(STR(lnMargenMax, 10, 2)) + ", "
	lcSql = lcSql + "		margenMin = " + ALLTRIM(STR(lnMargenMin, 10, 2)) + ", "
	lcSql = lcSql + "		prventaMax = " + ALLTRIM(STR(lnPrVentaMax, 10, 2)) + ", "
	lcSql = lcSql + "		prventaMin = " + ALLTRIM(STR(lnPrVentaMin, 10, 2)) + ", "
	lcSql = lcSql + "		prfinalMax = " + ALLTRIM(STR(lnFinalMax, 10, 2)) + ", "
	lcSql = lcSql + "		prfinalMin = " + ALLTRIM(STR(lnFinalMin, 10, 2)) + ", "
	lcSql = lcSql + "		observ =  '" + UPPER(STRTRAN(ALLTRIM(tcObserv), "'", " ")) + "', "
	
	&&IF lbActuFoto THEN 
		lcSql = lcSql + "	linkfoto = '" + UPPER(ALLTRIM(tnLinkFoto)) + "', "	
	&&ENDIF 
	
	lcSql = lcSql + "		usuModi = '" + ALLTRIM(gcCodUsu) + "', "
	lcSql = lcSql + "		fecModi = " + loDT.getdatetime() + ", "
	lcSql = lcSql + "		idHostModi = '" + ALLTRIM(SYS(0)) + "' "
	lcSql = lcSql + "WHERE codArt = '" + ALLTRIM(lcCodigo) + "'"
	
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute() THEN
		this.error_message = loCommand.ErrorMessage
		loResult.Close_Query()
		RETURN .F.
	ENDIF

	IF lnPorVar <> 0 THEN
		&& Agrego el insert que permite registrar los cambios de precios de los artículos
		lnProxID = goConn.GetNextID("art_cbios", "idArtCbios")
		
		lcSql = "insert into art_cbios ( "
		lcSql = lcSql + "idArtCbios, idArticulo, fecha, prAnt, prNuevo, porVar) values ("
		lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_tmp.idArticulo)) + ", "
		lcSql = lcSql + loDT.getDateTime() + ", "
		lcSql = lcSql + ALLTRIM(STR(lnPrAnt, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnPrLista, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnPorVar, 10, 2)) + ") "
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			this.ErrorMessage = loCommand.ErrorMessage
			loResult.Close_Query()
			RETURN .F.
		ENDIF
	ENDIF
ENDIF

loResult.Close_Query()

RETURN .T.
ENDPROC
PROCEDURE descargar

Dele FILE This.path + "DATOS_TRESSOLS.ZIP"
Dele FILE This.path + "TRESSOLS.CSV"

IF !internet() THEN 
	MESSAGEBOX("No se puede realizar la actualización, la PC no se encuentra conectada a internet.", 16, "Actualización de precios On-line - Tressols S.A.")
	RETURN .F.
ENDIF

&& vZip = Createobject("XStandard.Zip")

=VFPHTTP("http://www.tressols.com.ar/datos/datos.zip",this.path + "DATOS_TRESSOLS.zip")

&& vZip.UnPack(vRuta+"\ACT\DATOS.zip", vRuta+"\ACT")

&& Descomprimo el archivo
oZip=CREATEOBJECT('Zip.Zip')
oZip.ArchivoZip = This.path + "datos_tressols.zip"
oZip.DirectorioDestino = This.path
oZip.Descomprimir()
ENDPROC


************************************************************
OBJETO: actu_electrodiesel
************************************************************
*** PROPIEDADES ***
Height = 16
Width = 100
desc1 = 0.00
desc2 = 0.00
desc3 = 0.00
desc4 = 0.00
margenmay = 0.00
margenmin = 0.00
idprov = 0
path = 
error_message = 
alic_iva = 21
Name = "actu_electrodiesel"

*** METODOS ***
PROCEDURE open
CREATE CURSOR cur_art(	;
	Codigo			C(20)	,;
	Descrip			C(100)	,;
	Descrip2		C(100)	,;
	Descrip3		C(100)	,;
	Precio			C(20)	,;
	Fecha			D		,;
	Marca			C(60)	)


CREATE CURSOR cur_artic(	;
	Codigo			C(20)	,;
	Descrip			C(100)	,;
	Descrip2		C(100)	,;
	Descrip3		C(100)	,;
	Precio			float(10,2)	,;
	Fecha			D		,;
	Marca			C(60)	)

SELECT cur_art
INDEX ON Codigo TAG Codigo ASCENDING

SELECT cur_artic
INDEX ON Codigo TAG Codigo ASCENDING

WAIT WINDOW "Leyendo artículos desde ELECTRODIESEL..." NOWAIT

SELECT cur_art
APPEND FROM this.path + "ELECTRODIESEL.CSV " DELIMITER WITH CHARACTER ";" AS 1252

SELECT cur_art

INSERT INTO cur_artic ;
	SELECT codigo, descrip, descrip2, descrip3, float(VAL(STRTRAN(strtran(precio,".",""),",","."))), fecha, marca ;
	FROM cur_art

USE IN cur_art 

SELECT cur_artic
IF RECCOUNT("cur_artic") > 0 THEN
	GO TOP
ENDIF
ENDPROC
PROCEDURE actualizar_articulos
LOCAL loResult, loCommand, lcSql, lnIdFamilia, lnIdSubFam
LOCAL lnIdMarca, lcCodigo, lcDescripcio, lnPrecio
LOCAL lcFamilia, lcSubFam, lcMarca, loDT, lcLinkFoto, lcObserv
LOCAL loProg, i, lnTotReg

loResult = CREATEOBJECT("odbc_result")
loCommand = CREATEOBJECT("odbc_command")
loDT = CREATEOBJECT("datetime")
loProg = CREATEOBJECT("_thermometer")
lcSql = ""
lnIdFamilia = 0
lnIdSubFam = 0
lnIdMarca = 0
lcCodigo = ""
lcDescripcio = ""
lnPrecio = 0.00
lcFamilia = ""
lcSubFam = ""
lcMarca = ""
lcLinkFoto = ""
lcObserv = ""
lnTotReg = 0 
i = 0

This.descargar()
This.open()
loProg.Show()

&& Establezco el nivel de aislamiento de lectura no confirmada
loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = "set session transaction isolation level read uncommitted"

IF !loCommand.Execute() THEN
	goConn.Rollback()
	This.error_message = loCommand.ErrorMessage
	RETURN .F.
ENDIF

goConn.BeginTransaction()

**********************************************************************************************
&& Levanto la familia
**********************************************************************************************
lcFamilia = "VARIOS"

lcSql = "SELECT * FROM familias WHERE LTRIM(RTRIM(descripcio)) = '" + ALLTRIM(lcFamilia) + "'"
loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_Familia"

IF !loResult.OpenQuery(lcSql) THEN
	This.Error_Message = loResult.Error_Message
	goConn.Rollback()
	RETURN .F.
ENDIF

SELECT cur_Familia
IF RECCOUNT("cur_Familia") = 0 THEN
	lnIdFamilia = goConn.GetNextID("familias", "idFamilia")

	lcSql = "INSERT INTO familias ( "
	lcSql = lcSql + "idFamilia, "
	lcSql = lcSql + "descripcio, "
	lcSql = lcSql + "usuAlta, "
	lcSql = lcSql + "fecAlta, "
	lcSql = lcSql + "idHostAlta) VALUES ( "
	lcSql = lcSql + ALLTRIM(STR(lnIdFamilia)) + ", "
	lcSql = lcSql + "'" + lcFamilia + "', "
	lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
	lcSql = lcSql + loDT.getDateTime() + ", "
	lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "')"
	
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute() THEN
		goConn.Rollback()
		This.Error_Message = loCommand.ErrorMessage
		loResult.Close_Query()
		RETURN .F.
	ENDIF
ELSE
	lnIdFamilia = cur_Familia.IdFamilia
ENDIF

loResult.Close_Query()


**********************************************************************************************
&& Levanto la subfamilia
**********************************************************************************************
lcSubFam = "VARIOS"

lcSql = "SELECT * FROM subfam WHERE LTRIM(RTRIM(descripcio)) = '" + ALLTRIM(lcSubFam) + "'"
loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_SubFam"

IF !loResult.OpenQuery(lcSql) THEN
	This.Error_Message = loResult.Error_Message
	goConn.Rollback()
	loResult.Close_Query()
	RETURN .F.
ENDIF

IF RECCOUNT("cur_SubFam") = 0 THEN
	lnIdSubFam = goConn.GetNextID("subfam", "idSubFam")

	lcSql = "INSERT INTO subfam ( "
	lcSql = lcSql + "	idSubFam, "
	lcSql = lcSql + "	descripcio, "
	lcSql = lcSql + "	usuAlta, "
	lcSql = lcSql + "	fecAlta, "
	lcSql = lcSql + "	idHostAlta) VALUES ("
	lcSql = lcSql + ALLTRIM(STR(lnIdSubFam)) + ", "
	lcSql = lcSql + "'" + lcSubFam + "', "
	lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
	lcSql = lcSql + loDT.getDateTime() + ", "
	lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "')"
	
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute() THEN
		This.Error_Message = loCommand.ErrorMessage
		goConn.Rollback()
		loResult.Close_Query()
		RETURN .F.
	ENDIF
ELSE
	lnIdSubFam = cur_SubFam.idSubFam
ENDIF

loResult.Close_Query()

&& Recorro los articulos y comienzo la actualizacion articulo por articulo
SELECT cur_artic
lnTotReg = RECCOUNT("cur_artic")

DO WHILE !EOF("cur_artic")
	lcCodigo = ALLTRIM(cur_artic.codigo)
	lcDescripcio = ALLTRIM(cur_artic.descrip)
	lnPrecio = cur_artic.precio
	lcMarca = ALLTRIM(cur_artic.marca)
	&& lcLinkFoto = ALLTRIM(cur_artic.linkfoto)
	lcObserv = ALLTRIM(cur_artic.descrip2)
	
	**********************************************************************************************
	&& Levanto la marca
	**********************************************************************************************
	lcSql = "SELECT * FROM marcas WHERE LTRIM(RTRIM(descripcio)) = '" + ALLTRIM(lcMarca) + "'"
	loResult.ActiveConnection = goConn.ActiveConnection
	loResult.Cursor_Name = "cur_mrcs"
	
	IF !loResult.OpenQuery(lcSql) THEN
		goConn.Rollback()
		This.Error_Message = loResult.Error_Message
		RETURN .F.
	ENDIF
	
	SELECT cur_mrcs
	IF RECCOUNT("cur_mrcs") = 0 THEN
		lnIdMarca = goConn.GetNextID("marcas", "idMarca")
		
		lcSql = "INSERT INTO marcas ( "
		lcSql = lcSql + "idmarca, "
		lcSql = lcSql + "descripcio, "
		lcSql = lcSql + "usuAlta, "
		lcSql = lcSql + "fecAlta, "
		lcSql = lcSql + "idHostAlta) VALUES ( "
		lcSql = lcSql + ALLTRIM(STR(lnIdMarca)) + ", "
		lcSql = lcSql + "'" + ALLTRIM(lcMarca) + "', "
		lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
		lcSql = lcSql + loDT.getDateTime() + ", "
		lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "')"
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			This.Error_Message = loCommand.ErrorMessage
			loResult.Close_Query()
			RETURN .F.
		ENDIF
	ELSE
		lnIdMarca = cur_mrcs.idmarca
	ENDIF
	
	loResult.Close_Query()

	**************************************************************
	&& Doy de alta el artículo en la base de datos
	**************************************************************
	IF !This.insertar_articulo(lnIdFamilia, lnIdSubFam, lnIdMarca, lcCodigo, ;
			lcDescripcio, lnPrecio, lcLinkFoto, lcObserv) THEN
		goConn.Rollback()
		RETURN .F.
	ENDIF

	i = i + 1
	WAIT WINDOW "Procesando " + ALLTRIM(STR(i)) + " de " + ALLTRIM(STR(lnTotReg)) + "..." NOWAIT
	loProg.Update((i * 100) / lnTotReg, "Actualizando artículos desde ELECTRODIESEL...")
	
	SELECT cur_artic
	SKIP
ENDDO

goConn.Commit()

&& Establezco el nivel de aislamiento de lectura confirmada
loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = "set session transaction isolation level read committed"

IF !loCommand.Execute() THEN
	goConn.Rollback()
	This.error_message = loCommand.ErrorMessage
	RETURN .F.
ENDIF

loProg.Complete()
RETURN .T.
ENDPROC
PROCEDURE insertar_articulo
PARAMETERS tnIdFamilia, tnIdSubFam, tnIdMarca, tcCodArt, tcDescripcio, tnPrLista, tnLinkFoto, tcObserv

LOCAL 	lnCostoRep, lnMargenMax, lnMargenMin, lnPrVentaMax, lnPrVentaMin,;
		lnFinalMax, lnFinalMin, lcObserv, lnPrLista
LOCAL 	lnBonif1, lnBonif2, lnBonif3, lnBonif4		
LOCAL 	loCommand, lcSql, loResult, lnProxID, loDT, loUniDesp
LOCAL 	lnProxID, lnPrAnt, lnUniDesp, lnPrDif, lnPorVar, lbActuFoto 

loDT = CREATEOBJECT("datetime")
loCommand = CREATEOBJECT("odbc_command")
loResult = CREATEOBJECT("odbc_result")
loUniDesp = CREATEOBJECT("odbc_result")
lcSql = ""
lnCostoRep = 0.00
lnMargenMax = 0.00
lnMargenMin = 0.00
lnPrVentaMax = 0.00
lnPrVentaMin = 0.00
lnFinalMax = 0.00
lnFinalMin = 0.00
lcObserv = ""
lnPrLista = 0.00
lnProxID = 0.00
lnBonif1 = 0.00
lnBonif2 = 0.00
lnBonif3 = 0.00
lnBonif4 = 0.00
lnProxID = 0
lnPrAnt = 0.00
lnUniDesp = 0.00
lnPrDif = 0.00
lnPorVar = 0.00

lcCodigo = ALLTRIM(tcCodArt)
&& lbActuFoto = getglobalcfg("VERFOTODER")

IF INT(VAL(getconfig("SQLSRV"))) = 0 THEN 
	tnLinkFoto = ALLTRIM(STRTRAN(tnLinkFoto,"\","\\"))
ENDIF 

lcSql = "SELECT * FROM articulos WHERE codArt = '" + lcCodigo + "'"
loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_tmp"

IF !loResult.OpenQuery(lcSql) THEN
	MESSAGEBOX(loResult.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_tmp
IF RECCOUNT("cur_tmp") = 0 THEN
	lnBonif1 = this.desc1
	lnBonif2 = this.desc2
	lnBonif3 = this.desc3
	lnBonif4 = this.desc4
	lnMargenMax = this.margenmay
	lnMargenMin = this.margenmin
	
	* Calculo el precio de venta
	lnPrLista = tnPrLista
	lnCostoRep = calcular_costo(lnPrLista, lnBonif1, lnBonif2, lnBonif3, lnBonif4, 0)
	lnPrVentaMax = lnCostoRep + (lnCostoRep * (lnMargenMax / 100))
	lnPrVentaMin = lnCostoRep + (lnCostoRep * (lnMargenMin / 100))
	lnFinalMax = lnPrVentaMax + (lnPrVentaMax * (this.alic_iva / 100))
	lnFinalMin = lnPrVentaMin + (lnPrVentaMin * (this.alic_iva / 100))

	lnProxID = goConn.GetNextID("articulos", "idArticulo")

	lcSql = "INSERT INTO articulos ( "
	lcSql = lcSql + "	idArticulo, "
	lcSql = lcSql + "	idProv, "
	lcSql = lcSql + "	idFamilia, "
	lcSql = lcSql + "	idSubFam, "
	lcSql = lcSql + "	idMarca, "
	lcSql = lcSql + "	codArt, "
	lcSql = lcSql + "	descripcio, "
	lcSql = lcSql + "	alicIVA, "
	lcSql = lcSql + "	tmon, "
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
	lcSql = lcSql + "	prventaMax, "
	lcSql = lcSql + "	prventaMin, "
	lcSql = lcSql + "	prfinalMax, "
	lcSql = lcSql + "	prfinalMin, "
	lcSql = lcSql + "	observ, "
	lcSql = lcSql + "	idUniMed, "
	lcSql = lcSql + "	habilitado, "
	lcSql = lcSql + "	linkfoto, "
	lcSql = lcSql + "	usuAlta, "
	lcSql = lcSql + "	fecAlta, "
	lcSql = lcSql + "	idHostAlta) "
	lcSql = lcSql + "VALUES ( "
	lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", "					&& idAticulo
	lcSql = lcSql + ALLTRIM(STR(This.idProv)) + ", " 				&& Proveedor
	lcSql = lcSql + ALLTRIM(STR(tnIdFamilia)) + ", " 				&& Familia
	lcSql = lcSql + ALLTRIM(STR(tnIdSubFam)) + ", "					&& SubFamilia
	lcSql = lcSql + ALLTRIM(STR(tnIdMarca)) + ", " 					&& Marca
	lcSql = lcSql + "'" + UPPER(ALLTRIM(lcCodigo)) + "', "					&& CodArt
	lcSql = lcSql + "'" + UPPER(STRTRAN(ALLTRIM(tcDescripcio), "'", " ")) + "', "	&& Descripcio
	lcSql = lcSql + ALLTRIM(STR(This.alic_iva, 10, 2)) + ", "		&& alicIVA
	lcSql = lcSql + "'PSO', "										&& tMon
	lcSql = lcSql + "0, "											&& Precio de lista ext.
	lcSql = lcSql + "0, "											&& Cotización
	lcSql = lcSql + ALLTRIM(STR(lnPrLista, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(This.desc1, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(This.desc2, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(This.desc3, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(This.desc4, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnCostoRep, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(This.margenmay, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(This.margenmin, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPrVentaMax, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPrVentaMin, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnFinalMax, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnFinalMin, 10, 2)) + ", "
	lcSql = lcSql + "'" + UPPER(STRTRAN(ALLTRIM(tcObserv), "'", " ")) + "', " && Observ
	lcSql = lcSql + "1, "											&& idUniMed
	lcSql = lcSql + "1, "											&& habilitado
	
&&	IF !lbActuFoto THEN 
&&		lcSql = lcSql + "NULL, " 	
&&	ELSE 
		lcSql = lcSql + "'" + UPPER(ALLTRIM(tnLinkFoto)) + "', "	
&&	ENDIF 
			
	lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
	lcSql = lcSql + loDT.getDateTime() + ", "
	lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "')"

	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute() THEN
		This.error_message = loCommand.ErrorMessage
		loResult.Close_Query()
		RETURN .F.
	ENDIF
	
	&& Agrego el registro al codiart
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
	lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", "
	lcSql = lcSql + "'" + UPPER(ALLTRIM(lcCodigo)) + "', "
	lcSql = lcSql + "'" + UPPER(ALLTRIM(lcCodigo)) + "', "
	lcSql = lcSql + "'CP', "
	lcSql = lcSql + "1, "
	lcSql = lcSql + "0, "
	lcSql = lcSql + "'CV')"
	
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute() THEN
		this.errorMessage = loCommand.ErrorMessage
		loResult.Close_Query()
		RETURN .F.
	ENDIF	
	
ELSE
	&& Me fijo si en art_unid esta el articulo
	lcSql = "SELECT	* "
	lcSql = lcSql + "FROM art_unid "
	lcSql = lcSql + "WHERE art_unid.idArticulo = " + ALLTRIM(STR(cur_tmp.IdArticulo))

	loUniDesp.ActiveConnection = goConn.ActiveConnection
	loUniDesp.Cursor_Name = "cur_ud"

	IF !loUniDesp.OpenQuery(lcSql) THEN
		MESSAGEBOX(loUniDesp.Error_Message, 0+48, Thisform.Caption)
		loResult.Close_Query()
		RETURN .F.
	ENDIF

	SELECT cur_ud
	IF RECCOUNT("cur_ud") > 0 THEN
		lnUniDesp = cur_ud.cantUD
	ELSE
		lnUniDesp = 0.00
	ENDIF

	loUniDesp.Close_Query()

	&& Calculo la variacion en el cambio de precio
	lnPrAnt = cur_tmp.prLista
	
	IF tnPrLista > lnPrAnt THEN
		lnPrDif = tnPrLista  - lnPrAnt 
		IF lnPrAnt <> 0 THEN
			lnPorVar = (lnPrDif * 100) / lnPrAnt 
		ELSE
			lnPorVar = 100
		ENDIF
	ELSE
		lnPrDif = lnPrAnt  - tnPrLista 
		IF lnPrAnt <> 0 THEN
			lnPorVar = ((lnPrDif * 100) / lnPrAnt) * -1
		ELSE
			lnPorVar = 100
		ENDIF
	ENDIF
	
	lnBonif1 = IIF(this.desc1 = 0, cur_tmp.bonif1, this.desc1)
	lnBonif2 = IIF(this.desc2 = 0, cur_tmp.bonif2, this.desc2)
	lnBonif3 = IIF(this.desc3 = 0, cur_tmp.bonif3, this.desc3)
	lnBonif4 = IIF(this.desc4 = 0, cur_tmp.bonif4, this.desc3)
	lnMargenMax = IIF(this.margenmay = 0, cur_tmp.margenMax, this.margenmay)
	lnMargenMin = IIF(this.margenmin = 0, cur_tmp.margenMin, this.margenmin)

	* Calculo el precio de venta
	IF lnUniDesp <> 0 THEN 
		lnPrLista = tnPrLista / lnUniDesp 
	ELSE 
		lnPrLista = tnPrLista
	ENDIF 

	lnCostoRep = calcular_costo(lnPrLista, lnBonif1, lnBonif2, lnBonif3, lnBonif4, 0)
	lnPrVentaMax = lnCostoRep + (lnCostoRep * (lnMargenMax / 100))
	lnPrVentaMin = lnCostoRep + (lnCostoRep * (lnMargenMin / 100))
	lnFinalMax = lnPrVentaMax + (lnPrVentaMax * (this.alic_iva / 100))
	lnFinalMin = lnPrVentaMin + (lnPrVentaMin * (this.alic_iva / 100))

	&& En caso de existir el código, modifico el artículo
	lcSql = "UPDATE articulos "
	lcSql = lcSql + "SET 	idProv = " + ALLTRIM(STR(This.idProv)) + ", " 				
&&	lcSql = lcSql + "		idFamilia = " + ALLTRIM(STR(tnIdFamilia)) + ", " 			
&&	lcSql = lcSql + "		idSubFam = " + ALLTRIM(STR(tnIdSubFam)) + ", "					
&&	lcSql = lcSql + "		idMarca = " + ALLTRIM(STR(tnIdMarca)) + ", " 					
&&	lcSql = lcSql + "		descripcio = '" + STRCONV(STRTRAN(ALLTRIM(tcDescripcio), "'", " "),11) + "', "
	lcSql = lcSql + "		descripcio = '" + UPPER(STRTRAN(ALLTRIM(tcDescripcio), "'", " ")) + "', "
	lcSql = lcSql + "		alicIVA = " + ALLTRIM(STR(This.alic_iva, 10, 2)) + ", "
	lcSql = lcSql + "		prLista = " + ALLTRIM(STR(lnPrLista, 10, 2)) + ", "
	lcSql = lcSql + "		bonif1 = " + ALLTRIM(STR(lnBonif1, 10, 2)) + ", "
	lcSql = lcSql + "		bonif2 = " + ALLTRIM(STR(lnBonif2, 10, 2)) + ", "
	lcSql = lcSql + "		bonif3 = " + ALLTRIM(STR(lnBonif3, 10, 2)) + ", "
	lcSql = lcSql + "		bonif4 = " + ALLTRIM(STR(lnBonif4, 10, 2)) + ", "
	lcSql = lcSql + "		costoRep = " + ALLTRIM(STR(lnCostoRep, 10, 2)) + ", "
	lcSql = lcSql + "		margenMax = " + ALLTRIM(STR(lnMargenMax, 10, 2)) + ", "
	lcSql = lcSql + "		margenMin = " + ALLTRIM(STR(lnMargenMin, 10, 2)) + ", "
	lcSql = lcSql + "		prventaMax = " + ALLTRIM(STR(lnPrVentaMax, 10, 2)) + ", "
	lcSql = lcSql + "		prventaMin = " + ALLTRIM(STR(lnPrVentaMin, 10, 2)) + ", "
	lcSql = lcSql + "		prfinalMax = " + ALLTRIM(STR(lnFinalMax, 10, 2)) + ", "
	lcSql = lcSql + "		prfinalMin = " + ALLTRIM(STR(lnFinalMin, 10, 2)) + ", "
	lcSql = lcSql + "		observ =  '" + UPPER(STRTRAN(ALLTRIM(tcObserv), "'", " ")) + "', "
	
	&&IF lbActuFoto THEN 
		lcSql = lcSql + "	linkfoto = '" + UPPER(ALLTRIM(tnLinkFoto)) + "', "	
	&&ENDIF 
	
	lcSql = lcSql + "		usuModi = '" + ALLTRIM(gcCodUsu) + "', "
	lcSql = lcSql + "		fecModi = " + loDT.getdatetime() + ", "
	lcSql = lcSql + "		idHostModi = '" + ALLTRIM(SYS(0)) + "' "
	lcSql = lcSql + "WHERE codArt = '" + ALLTRIM(lcCodigo) + "'"
	
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute() THEN
		this.error_message = loCommand.ErrorMessage
		loResult.Close_Query()
		RETURN .F.
	ENDIF

	IF lnPorVar <> 0 THEN
		&& Agrego el insert que permite registrar los cambios de precios de los artículos
		lnProxID = goConn.GetNextID("art_cbios", "idArtCbios")
		
		lcSql = "insert into art_cbios ( "
		lcSql = lcSql + "idArtCbios, idArticulo, fecha, prAnt, prNuevo, porVar) values ("
		lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_tmp.idArticulo)) + ", "
		lcSql = lcSql + loDT.getDateTime() + ", "
		lcSql = lcSql + ALLTRIM(STR(lnPrAnt, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnPrLista, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnPorVar, 10, 2)) + ") "
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			this.ErrorMessage = loCommand.ErrorMessage
			loResult.Close_Query()
			RETURN .F.
		ENDIF
	ENDIF
ENDIF

loResult.Close_Query()

RETURN .T.
ENDPROC
PROCEDURE descargar

Dele FILE This.path + "DATOS.ZIP"
Dele FILE This.path + "ELECTRODIESEL.CSV"

IF !internet() THEN 
	MESSAGEBOX("No se puede realizar la actualización, la PC no se encuentra conectada a internet.", 16, "Actualización de precios On-line - Electrodiesel Argentina S.R.L.")
	RETURN .F.
ENDIF

&& vZip = Createobject("XStandard.Zip")
WAIT WINDOWS 'Estableciendo conexión...' NOWAIT
sz_ftp = CREATEOBJECT('ftp_service')
IF sz_ftp.OpenInternet("tapice@electrodiesel.com.ar", "Tapice2015", "ftp.electrodiesel.com.ar", "21")
	IF sz_ftp.ChangeFtpDirectory("/datos")

		WAIT WINDOWS 'Descargando...' NOWAIT

		IF sz_ftp.GetFtpFile("datos.zip", this.path + "DATOS.zip")

			&& vZip.UnPack(vRuta+"\ACT\DATOS.zip", vRuta+"\ACT")
			
			&& Descomprimo el archivo
			oZip=CREATEOBJECT('Zip.Zip')
			oZip.ArchivoZip = This.path + "datos.zip"
			oZip.DirectorioDestino = This.path
			oZip.Descomprimir()
		ELSE
			MESSAGEBOX("No se pudo descargar la actualización.", 16, "Electrodiesel Argentina S.R.L.")
			sz_ftp.CloseInternet()
			?sz_ftp.GetErrorCode(.T.)
		ENDIF
	ELSE
		MESSAGEBOX("No se pudo descargar la actualización. Error al acceder a la carpeta /datos. ", 16, "Electrodiesel Argentina S.R.L.")
		sz_ftp.CloseInternet()
		?sz_ftp.GetErrorCode(.T.)
	ENDIF
ELSE
	MESSAGEBOX("No se pudo establecer la conexión.", 16, "Electrodiesel Argentina S.R.L.")
	sz_ftp.CloseInternet()
	?sz_ftp.GetErrorCode(.T.)
ENDIF

ENDPROC


************************************************************
OBJETO: actu_bba
************************************************************
*** PROPIEDADES ***
Height = 15
Width = 100
desc1 = 0.00
desc2 = 0.00
desc3 = 0.00
desc4 = 0.00
margenmay = 0.00
margenmin = 0.00
idprov = 0
path = 
error_message = 
alic_iva = 21
Name = "actu_bba"

*** METODOS ***
PROCEDURE open
CREATE CURSOR cur_art(	;
	Codigo			C(20)	,;
	CodArtPV		C(20)	,;
	Descrip			C(200)	,;
	Marca			C(60)	,;
	Precio			C(20)	,;
	Iva				C(5)	,;
	Subrubro		C(60)	)


CREATE CURSOR cur_artic(	;
	Codigo			C(20)	,;
	CodArtPV		C(20)	,;
	Descrip			C(200)	,;
	Marca			C(60)	,;
	Precio			float(10,2)	,;
	Iva				float(10,2)	,;
	Subrubro		C(60)	)

SELECT cur_art
INDEX ON Codigo TAG Codigo ASCENDING

SELECT cur_artic
INDEX ON Codigo TAG Codigo ASCENDING

WAIT WINDOW "Leyendo artículos desde BBA..." NOWAIT

SELECT cur_art
APPEND FROM this.path + "cromoupdate_bba.csv" DELIMITER WITH CHARACTER ";" AS 1252

SELECT cur_art

lcCodProv = "-" + REPLICATE("0", 3 - LEN(ALLTRIM(STR(this.idprov)))) + ALLTRIM(STR(this.idprov))

INSERT INTO cur_artic ;
	SELECT MAX(ALLTRIM(codigo) + lcCodProv), ALLTRIM(codartPV), MAX(ALLTRIM(descrip)), MAX(ALLTRIM(marca)), MAX(float(VAL(STRTRAN(precio,",",".")))), MAX(float(VAL(STRTRAN(iva,",",".")))), MAX(ALLTRIM(Subrubro)) ;
	FROM cur_art ;
	GROUP BY codartPV

USE IN cur_art 

SELECT cur_artic
IF RECCOUNT("cur_artic") > 0 THEN
	GO TOP
ENDIF
ENDPROC
PROCEDURE actualizar_articulos
LOCAL loResult, loCommand, lcSql, lnIdFamilia, lnIdSubFam
LOCAL lnIdMarca, lcCodigo, lcDescripcio, lnPrecio
LOCAL lcFamilia, lcSubFam, lcMarca, loDT, lcLinkFoto, lcObserv
LOCAL loProg, i, lnTotReg, lcCodArtPV, lnIVA

loResult = CREATEOBJECT("odbc_result")
loCommand = CREATEOBJECT("odbc_command")
loDT = CREATEOBJECT("datetime")
loProg = CREATEOBJECT("_thermometer")
lcSql = ""
lnIdFamilia = 0
lnIdSubFam = 0
lnIdMarca = 0
lcCodigo = ""
lcDescripcio = ""
lnPrecio = 0.00
lcFamilia = ""
lcSubFam = ""
lcMarca = ""
lcLinkFoto = ""
lcObserv = ""
lnTotReg = 0 
i = 0
lcCodArtPV = ""
lnIVA = 0.00

&&This.descargar()
This.open()
loProg.Show()

&& Establezco el nivel de aislamiento de lectura no confirmada
loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = "set session transaction isolation level read uncommitted"

IF !loCommand.Execute() THEN
	goConn.Rollback()
	This.error_message = loCommand.ErrorMessage
	RETURN .F.
ENDIF

goConn.BeginTransaction()



&& Recorro los articulos y comienzo la actualizacion articulo por articulo
SELECT cur_artic
lnTotReg = RECCOUNT("cur_artic")

DO WHILE !EOF("cur_artic")
	lcCodigo = ALLTRIM(cur_artic.codigo)
	lcCodArtPV = ALLTRIM(cur_artic.codArtPV)
	lcDescripcio = ALLTRIM(cur_artic.descrip)
	lnPrecio = cur_artic.precio
	lcFamilia = "VARIOS"
	lcSubFam = ALLTRIM(cur_artic.subrubro)
	lcMarca = ALLTRIM(cur_artic.marca)
	lnIVA = cur_artic.iva
	&& lcLinkFoto = ALLTRIM(cur_artic.linkfoto)
	
	**********************************************************************************************
	&& Levanto la familia
	**********************************************************************************************
	lcSql = "SELECT * FROM familias WHERE LTRIM(RTRIM(descripcio)) = '" + ALLTRIM(lcFamilia) + "'"
	loResult.ActiveConnection = goConn.ActiveConnection
	loResult.Cursor_Name = "cur_Familia"

	IF !loResult.OpenQuery(lcSql) THEN
		This.Error_Message = loResult.Error_Message
		goConn.Rollback()
		RETURN .F.
	ENDIF

	SELECT cur_Familia
	IF RECCOUNT("cur_Familia") = 0 THEN
		lnIdFamilia = goConn.GetNextID("familias", "idFamilia")

		lcSql = "INSERT INTO familias ( "
		lcSql = lcSql + "idFamilia, "
		lcSql = lcSql + "descripcio, "
		lcSql = lcSql + "usuAlta, "
		lcSql = lcSql + "fecAlta, "
		lcSql = lcSql + "idHostAlta) VALUES ( "
		lcSql = lcSql + ALLTRIM(STR(lnIdFamilia)) + ", "
		lcSql = lcSql + "'" + lcFamilia + "', "
		lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
		lcSql = lcSql + loDT.getDateTime() + ", "
		lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "')"
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			This.Error_Message = loCommand.ErrorMessage
			loResult.Close_Query()
			RETURN .F.
		ENDIF
	ELSE
		lnIdFamilia = cur_Familia.IdFamilia
	ENDIF

	loResult.Close_Query()


	**********************************************************************************************
	&& Levanto la subfamilia
	**********************************************************************************************
	IF !EMPTY(ALLTRIM(lcSubFam)) THEN 
		lcSql = "SELECT * FROM subfam WHERE LTRIM(RTRIM(descripcio)) = '" + ALLTRIM(lcSubFam) + "'"
		loResult.ActiveConnection = goConn.ActiveConnection
		loResult.Cursor_Name = "cur_SubFam"

		IF !loResult.OpenQuery(lcSql) THEN
			This.Error_Message = loResult.Error_Message
			goConn.Rollback()
			loResult.Close_Query()
			RETURN .F.
		ENDIF

		IF RECCOUNT("cur_SubFam") = 0 THEN
			lnIdSubFam = goConn.GetNextID("subfam", "idSubFam")

			lcSql = "INSERT INTO subfam ( "
			lcSql = lcSql + "	idSubFam, "
			lcSql = lcSql + "	descripcio, "
			lcSql = lcSql + "	usuAlta, "
			lcSql = lcSql + "	fecAlta, "
			lcSql = lcSql + "	idHostAlta) VALUES ("
			lcSql = lcSql + ALLTRIM(STR(lnIdSubFam)) + ", "
			lcSql = lcSql + "'" + lcSubFam + "', "
			lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
			lcSql = lcSql + loDT.getDateTime() + ", "
			lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "')"
			
			loCommand.ActiveConnection = goConn.ActiveConnection
			loCommand.CommandText = lcSql
			
			IF !loCommand.Execute() THEN
				This.Error_Message = loCommand.ErrorMessage
				goConn.Rollback()
				loResult.Close_Query()
				RETURN .F.
			ENDIF
		ELSE
			lnIdSubFam = cur_SubFam.idSubFam
		ENDIF

		loResult.Close_Query()
	ENDIF 
	
	**********************************************************************************************
	&& Levanto la marca
	**********************************************************************************************
	IF !EMPTY(ALLTRIM(lcMarca)) THEN 
		lcSql = "SELECT * FROM marcas WHERE LTRIM(RTRIM(descripcio)) = '" + ALLTRIM(lcMarca) + "'"
		loResult.ActiveConnection = goConn.ActiveConnection
		loResult.Cursor_Name = "cur_mrcs"
		
		IF !loResult.OpenQuery(lcSql) THEN
			goConn.Rollback()
			This.Error_Message = loResult.Error_Message
			RETURN .F.
		ENDIF
		
		SELECT cur_mrcs
		IF RECCOUNT("cur_mrcs") = 0 THEN
			lnIdMarca = goConn.GetNextID("marcas", "idMarca")
			
			lcSql = "INSERT INTO marcas ( "
			lcSql = lcSql + "idmarca, "
			lcSql = lcSql + "descripcio, "
			lcSql = lcSql + "usuAlta, "
			lcSql = lcSql + "fecAlta, "
			lcSql = lcSql + "idHostAlta) VALUES ( "
			lcSql = lcSql + ALLTRIM(STR(lnIdMarca)) + ", "
			lcSql = lcSql + "'" + ALLTRIM(lcMarca) + "', "
			lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
			lcSql = lcSql + loDT.getDateTime() + ", "
			lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "')"
			
			loCommand.ActiveConnection = goConn.ActiveConnection
			loCommand.CommandText = lcSql
			
			IF !loCommand.Execute() THEN
				goConn.Rollback()
				This.Error_Message = loCommand.ErrorMessage
				loResult.Close_Query()
				RETURN .F.
			ENDIF
		ELSE
			lnIdMarca = cur_mrcs.idmarca
		ENDIF
		
		loResult.Close_Query()
	
	ENDIF 
	
	**************************************************************
	&& Doy de alta el artículo en la base de datos
	**************************************************************
	IF !This.insertar_articulo(lnIdFamilia, lnIdSubFam, lnIdMarca, lcCodigo, ;
			lcDescripcio, lnPrecio, lcLinkFoto, lcObserv, lcCodArtPV, lnIVA) THEN
		goConn.Rollback()
		RETURN .F.
	ENDIF
	
	i = i + 1
	WAIT WINDOW "Procesando " + ALLTRIM(STR(i)) + " de " + ALLTRIM(STR(lnTotReg)) + "..." NOWAIT
	loProg.Update((i * 100) / lnTotReg, "Actualizando artículos desde BBA...")
	
	SELECT cur_artic
	SKIP
ENDDO

goConn.Commit()

&& Establezco el nivel de aislamiento de lectura confirmada
loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = "set session transaction isolation level read committed"

IF !loCommand.Execute() THEN
	goConn.Rollback()
	This.error_message = loCommand.ErrorMessage
	RETURN .F.
ENDIF

loProg.Complete()
RETURN .T.
ENDPROC
PROCEDURE insertar_articulo
PARAMETERS tnIdFamilia, tnIdSubFam, tnIdMarca, tcCodArt, tcDescripcio, tnPrLista, tnLinkFoto, tcObserv, tcCodArtPV, tnIVA

LOCAL 	lnCostoRep, lnMargenMax, lnMargenMin, lnPrVentaMax, lnPrVentaMin,;
		lnFinalMax, lnFinalMin, lcObserv, lnPrLista
LOCAL 	lnBonif1, lnBonif2, lnBonif3, lnBonif4		
LOCAL 	loCommand, lcSql, loResult, lnProxID, loDT, loUniDesp
LOCAL 	lnProxID, lnPrAnt, lnUniDesp, lnPrDif, lnPorVar, lbActuFoto 

loDT = CREATEOBJECT("datetime")
loCommand = CREATEOBJECT("odbc_command")
loResult = CREATEOBJECT("odbc_result")
loUniDesp = CREATEOBJECT("odbc_result")
lcSql = ""
lnCostoRep = 0.00
lnMargenMax = 0.00
lnMargenMin = 0.00
lnPrVentaMax = 0.00
lnPrVentaMin = 0.00
lnFinalMax = 0.00
lnFinalMin = 0.00
lcObserv = ""
lnPrLista = 0.00
lnProxID = 0.00
lnBonif1 = 0.00
lnBonif2 = 0.00
lnBonif3 = 0.00
lnBonif4 = 0.00
lnProxID = 0
lnPrAnt = 0.00
lnUniDesp = 0.00
lnPrDif = 0.00
lnPorVar = 0.00

lcCodigo = ALLTRIM(tcCodArt)
&& lbActuFoto = getglobalcfg("VERFOTODER")

IF INT(VAL(getconfig("SQLSRV"))) = 0 THEN 
	tnLinkFoto = ALLTRIM(STRTRAN(tnLinkFoto,"\","\\"))
ENDIF 

lcSql = "SELECT * FROM articulos WHERE codArt = '" + lcCodigo + "'"
loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_tmp"

IF !loResult.OpenQuery(lcSql) THEN
	MESSAGEBOX(loResult.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_tmp
IF RECCOUNT("cur_tmp") = 0 THEN
	lnBonif1 = this.desc1
	lnBonif2 = this.desc2
	lnBonif3 = this.desc3
	lnBonif4 = this.desc4
	lnMargenMax = this.margenmay
	lnMargenMin = this.margenmin
	
	* Calculo el precio de venta
	lnPrLista = tnPrLista
	lnCostoRep = calcular_costo(lnPrLista, lnBonif1, lnBonif2, lnBonif3, lnBonif4, 0)
	lnPrVentaMax = lnCostoRep + (lnCostoRep * (lnMargenMax / 100))
	lnPrVentaMin = lnCostoRep + (lnCostoRep * (lnMargenMin / 100))
	lnFinalMax = lnPrVentaMax + (lnPrVentaMax * (tnIVA / 100))
	lnFinalMin = lnPrVentaMin + (lnPrVentaMin * (tnIVA / 100))

	lnProxID = goConn.GetNextID("articulos", "idArticulo")

	lcSql = "INSERT INTO articulos ( "
	lcSql = lcSql + "	idArticulo, "
	lcSql = lcSql + "	idProv, "
	lcSql = lcSql + "	idFamilia, "
	lcSql = lcSql + "	idSubFam, "
	lcSql = lcSql + "	idMarca, "
	lcSql = lcSql + "	codArt, "
	lcSql = lcSql + "	codArtPV, "
	lcSql = lcSql + "	descripcio, "
	lcSql = lcSql + "	alicIVA, "
	lcSql = lcSql + "	tmon, "
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
	lcSql = lcSql + "	prventaMax, "
	lcSql = lcSql + "	prventaMin, "
	lcSql = lcSql + "	prfinalMax, "
	lcSql = lcSql + "	prfinalMin, "
	lcSql = lcSql + "	observ, "
	lcSql = lcSql + "	idUniMed, "
	lcSql = lcSql + "	habilitado, "
	lcSql = lcSql + "	linkfoto, "
	lcSql = lcSql + "	usuAlta, "
	lcSql = lcSql + "	fecAlta, "
	lcSql = lcSql + "	idHostAlta) "
	lcSql = lcSql + "VALUES ( "
	lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", "					&& idAticulo
	lcSql = lcSql + ALLTRIM(STR(This.idProv)) + ", " 				&& Proveedor
	lcSql = lcSql + ALLTRIM(STR(tnIdFamilia)) + ", " 				&& Familia
	lcSql = lcSql + ALLTRIM(STR(tnIdSubFam)) + ", "					&& SubFamilia
	lcSql = lcSql + ALLTRIM(STR(tnIdMarca)) + ", " 					&& Marca
	lcSql = lcSql + "'" + UPPER(ALLTRIM(lcCodigo)) + "', "			&& CodArt
	lcSql = lcSql + "'" + UPPER(ALLTRIM(tcCodArtPV)) + "', "		&& CodArtPV
	lcSql = lcSql + "'" + UPPER(STRTRAN(ALLTRIM(tcDescripcio), "'", " ")) + "', "	&& Descripcio
	lcSql = lcSql + ALLTRIM(STR(tnIVA, 10, 2)) + ", "				&& alicIVA
	lcSql = lcSql + "'PSO', "										&& tMon
	lcSql = lcSql + "0, "											&& Precio de lista ext.
	lcSql = lcSql + "0, "											&& Cotización
	lcSql = lcSql + ALLTRIM(STR(lnPrLista, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(This.desc1, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(This.desc2, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(This.desc3, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(This.desc4, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnCostoRep, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(This.margenmay, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(This.margenmin, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPrVentaMax, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPrVentaMin, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnFinalMax, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnFinalMin, 10, 2)) + ", "
	lcSql = lcSql + "'" + UPPER(STRTRAN(ALLTRIM(tcObserv), "'", " ")) + "', " && Observ
	lcSql = lcSql + "1, "											&& idUniMed
	lcSql = lcSql + "1, "											&& habilitado
	
&&	IF !lbActuFoto THEN 
&&		lcSql = lcSql + "NULL, " 	
&&	ELSE 
		lcSql = lcSql + "'" + UPPER(ALLTRIM(tnLinkFoto)) + "', "	
&&	ENDIF 
			
	lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
	lcSql = lcSql + loDT.getDateTime() + ", "
	lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "')"

	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute() THEN
		This.error_message = loCommand.ErrorMessage
		loResult.Close_Query()
		RETURN .F.
	ENDIF
	
	&& Agrego el registro al codiart
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
	lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", "
	lcSql = lcSql + "'" + UPPER(ALLTRIM(lcCodigo)) + "', "
	lcSql = lcSql + "'" + UPPER(ALLTRIM(lcCodigo)) + "', "
	lcSql = lcSql + "'CP', "
	lcSql = lcSql + "1, "
	lcSql = lcSql + "0, "
	lcSql = lcSql + "'CV')"
	
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute() THEN
		this.errorMessage = loCommand.ErrorMessage
		loResult.Close_Query()
		RETURN .F.
	ENDIF	
	
ELSE
	&& Me fijo si en art_unid esta el articulo
	lcSql = "SELECT	* "
	lcSql = lcSql + "FROM art_unid "
	lcSql = lcSql + "WHERE art_unid.idArticulo = " + ALLTRIM(STR(cur_tmp.IdArticulo))

	loUniDesp.ActiveConnection = goConn.ActiveConnection
	loUniDesp.Cursor_Name = "cur_ud"

	IF !loUniDesp.OpenQuery(lcSql) THEN
		MESSAGEBOX(loUniDesp.Error_Message, 0+48, Thisform.Caption)
		loResult.Close_Query()
		RETURN .F.
	ENDIF

	SELECT cur_ud
	IF RECCOUNT("cur_ud") > 0 THEN
		lnUniDesp = cur_ud.cantUD
	ELSE
		lnUniDesp = 0.00
	ENDIF

	loUniDesp.Close_Query()

	&& Calculo la variacion en el cambio de precio
	lnPrAnt = cur_tmp.prLista
	
	IF tnPrLista > lnPrAnt THEN
		lnPrDif = tnPrLista  - lnPrAnt 
		IF lnPrAnt <> 0 THEN
			lnPorVar = (lnPrDif * 100) / lnPrAnt 
		ELSE
			lnPorVar = 100
		ENDIF
	ELSE
		lnPrDif = lnPrAnt  - tnPrLista 
		IF lnPrAnt <> 0 THEN
			lnPorVar = ((lnPrDif * 100) / lnPrAnt) * -1
		ELSE
			lnPorVar = 100
		ENDIF
	ENDIF
	
	lnBonif1 = IIF(this.desc1 = 0, cur_tmp.bonif1, this.desc1)
	lnBonif2 = IIF(this.desc2 = 0, cur_tmp.bonif2, this.desc2)
	lnBonif3 = IIF(this.desc3 = 0, cur_tmp.bonif3, this.desc3)
	lnBonif4 = IIF(this.desc4 = 0, cur_tmp.bonif4, this.desc3)
	lnMargenMax = IIF(this.margenmay = 0, cur_tmp.margenMax, this.margenmay)
	lnMargenMin = IIF(this.margenmin = 0, cur_tmp.margenMin, this.margenmin)

	* Calculo el precio de venta
	IF lnUniDesp <> 0 THEN 
		lnPrLista = tnPrLista / lnUniDesp 
	ELSE 
		lnPrLista = tnPrLista
	ENDIF 

	lnCostoRep = calcular_costo(lnPrLista, lnBonif1, lnBonif2, lnBonif3, lnBonif4, 0)
	lnPrVentaMax = lnCostoRep + (lnCostoRep * (lnMargenMax / 100))
	lnPrVentaMin = lnCostoRep + (lnCostoRep * (lnMargenMin / 100))
	lnFinalMax = lnPrVentaMax + (lnPrVentaMax * (this.alic_iva / 100))
	lnFinalMin = lnPrVentaMin + (lnPrVentaMin * (this.alic_iva / 100))

	&& En caso de existir el código, modifico el artículo
	lcSql = "UPDATE articulos "
	lcSql = lcSql + "SET 	idProv = " + ALLTRIM(STR(This.idProv)) + ", " 				
&&	lcSql = lcSql + "		idFamilia = " + ALLTRIM(STR(tnIdFamilia)) + ", " 			
&&	lcSql = lcSql + "		idSubFam = " + ALLTRIM(STR(tnIdSubFam)) + ", "					
&&	lcSql = lcSql + "		idMarca = " + ALLTRIM(STR(tnIdMarca)) + ", " 					
&&	lcSql = lcSql + "		descripcio = '" + STRCONV(STRTRAN(ALLTRIM(tcDescripcio), "'", " "),11) + "', "
	lcSql = lcSql + "		descripcio = '" + UPPER(STRTRAN(ALLTRIM(tcDescripcio), "'", " ")) + "', "
	lcSql = lcSql + "		alicIVA = " + ALLTRIM(STR(tnIVA, 10, 2)) + ", "
	lcSql = lcSql + "		prLista = " + ALLTRIM(STR(lnPrLista, 10, 2)) + ", "
	lcSql = lcSql + "		bonif1 = " + ALLTRIM(STR(lnBonif1, 10, 2)) + ", "
	lcSql = lcSql + "		bonif2 = " + ALLTRIM(STR(lnBonif2, 10, 2)) + ", "
	lcSql = lcSql + "		bonif3 = " + ALLTRIM(STR(lnBonif3, 10, 2)) + ", "
	lcSql = lcSql + "		bonif4 = " + ALLTRIM(STR(lnBonif4, 10, 2)) + ", "
	lcSql = lcSql + "		costoRep = " + ALLTRIM(STR(lnCostoRep, 10, 2)) + ", "
	lcSql = lcSql + "		margenMax = " + ALLTRIM(STR(lnMargenMax, 10, 2)) + ", "
	lcSql = lcSql + "		margenMin = " + ALLTRIM(STR(lnMargenMin, 10, 2)) + ", "
	lcSql = lcSql + "		prventaMax = " + ALLTRIM(STR(lnPrVentaMax, 10, 2)) + ", "
	lcSql = lcSql + "		prventaMin = " + ALLTRIM(STR(lnPrVentaMin, 10, 2)) + ", "
	lcSql = lcSql + "		prfinalMax = " + ALLTRIM(STR(lnFinalMax, 10, 2)) + ", "
	lcSql = lcSql + "		prfinalMin = " + ALLTRIM(STR(lnFinalMin, 10, 2)) + ", "
	lcSql = lcSql + "		observ =  '" + UPPER(STRTRAN(ALLTRIM(tcObserv), "'", " ")) + "', "
	
	&&IF lbActuFoto THEN 
		lcSql = lcSql + "	linkfoto = '" + UPPER(ALLTRIM(tnLinkFoto)) + "', "	
	&&ENDIF 
	
	lcSql = lcSql + "		usuModi = '" + ALLTRIM(gcCodUsu) + "', "
	lcSql = lcSql + "		fecModi = " + loDT.getdatetime() + ", "
	lcSql = lcSql + "		idHostModi = '" + ALLTRIM(SYS(0)) + "' "
	lcSql = lcSql + "WHERE codArt = '" + ALLTRIM(lcCodigo) + "'"
	
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute() THEN
		this.error_message = loCommand.ErrorMessage
		loResult.Close_Query()
		RETURN .F.
	ENDIF

	IF lnPorVar <> 0 THEN
		&& Agrego el insert que permite registrar los cambios de precios de los artículos
		lnProxID = goConn.GetNextID("art_cbios", "idArtCbios")
		
		lcSql = "insert into art_cbios ( "
		lcSql = lcSql + "idArtCbios, idArticulo, fecha, prAnt, prNuevo, porVar) values ("
		lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_tmp.idArticulo)) + ", "
		lcSql = lcSql + loDT.getDateTime() + ", "
		lcSql = lcSql + ALLTRIM(STR(lnPrAnt, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnPrLista, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnPorVar, 10, 2)) + ") "
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			this.ErrorMessage = loCommand.ErrorMessage
			loResult.Close_Query()
			RETURN .F.
		ENDIF
	ENDIF
ENDIF

loResult.Close_Query()

RETURN .T.
ENDPROC
PROCEDURE descargar

Dele FILE This.path + "DATOS_TRESSOLS.ZIP"
Dele FILE This.path + "TRESSOLS.CSV"

IF !internet() THEN 
	MESSAGEBOX("No se puede realizar la actualización, la PC no se encuentra conectada a internet.", 16, "Actualización de precios On-line - Tressols S.A.")
	RETURN .F.
ENDIF

&& vZip = Createobject("XStandard.Zip")

=VFPHTTP("http://www.tressols.com.ar/datos/datos.zip",this.path + "DATOS_TRESSOLS.zip")

&& vZip.UnPack(vRuta+"\ACT\DATOS.zip", vRuta+"\ACT")

&& Descomprimo el archivo
oZip=CREATEOBJECT('Zip.Zip')
oZip.ArchivoZip = This.path + "datos_tressols.zip"
oZip.DirectorioDestino = This.path
oZip.Descomprimir()
ENDPROC


************************************************************
OBJETO: actu_dm
************************************************************
*** PROPIEDADES ***
Height = 15
Width = 100
desc1 = 0.00
desc2 = 0.00
desc3 = 0.00
desc4 = 0.00
margenmay = 0.00
margenmin = 0.00
idprov = 0
path = 
error_message = 
alic_iva = 21
Name = "actu_dm"

*** METODOS ***
PROCEDURE open
CREATE CURSOR cur_artic(	;
	Codigo			C(20)	,;
	Marca			C(60)	,;
	Descrip			C(100)	,;
	Precio			float(10,2))

SELECT cur_artic
INDEX ON Codigo TAG Codigo ASCENDING
INDEX ON Marca TAG Marca ASCENDING
INDEX ON Descrip TAG Descrip ASCENDING
INDEX ON Precio TAG Precio ASCENDING
********************************************************************************************************
LOCAL lcRuta, loExcel, lnPorcentaje

lnPorcentaje = 0.00
lcRuta = ""
loExcel = CREATEOBJECT("Excel.Application")
progressBar = CREATEOBJECT("_thermometer")

lcRuta = GETFILE("XLS,XLSX")
WAIT WINDOW "Leyendo artículos desde DM..." NOWAIT

WITH loExcel.Application
	.visible = .F.
	.workbooks.open(lcRuta)
	lnCol = .ActiveSheet.UsedRange.Columns.Count
	lnFil = .ActiveSheet.UsedRange.Rows.Count
	progressBar.show()

	FOR i = 2 TO lnFil
		
		SELECT cur_Artic
		APPEND BLANK
		
		IF TYPE(".activesheet.cells(i, 1).value") == "C" THEN
			IF !(ALLTRIM(.activesheet.cells(i, 1).value) == "") THEN
				REPLACE Codigo WITH ALLTRIM(.activesheet.cells(i, 1).value)
			ELSE
				MESSAGEBOX("Elimine del Excel la fila " + ALLTRIM(STR(i)) + " que se encuentra vacía",0+48,"Error de importación")
				.workbooks.close()
				.quit
				RELEASE loExcel
				RETURN .F.
			ENDIF
		ELSE
			IF !ISNULL(.activesheet.cells(i, 1).value) THEN
				REPLACE Codigo WITH ALLTRIM(STR(.activesheet.cells(i, 1).value))
			ELSE
				MESSAGEBOX("Elimine del Excel la fila " + ALLTRIM(STR(i)) + " que se encuentra vacía",0+48,"Error de importación")
				.workbooks.close()
				.quit
				RELEASE loExcel
				RETURN .F.
			ENDIF
		ENDIF
		
		IF ISNULL(.activesheet.cells(i, 2).value) THEN 
			REPLACE Marca 		WITH "VARIOS" ADDITIVE
		ELSE
			REPLACE Marca 		WITH UPPER(ALLTRIM(.activesheet.cells(i, 2).value)) ADDITIVE
		ENDIF
		
		REPLACE Descrip 	WITH UPPER(STRTRAN(ALLTRIM(.activesheet.cells(i, 4).value), "'", " ")) ADDITIVE
		REPLACE Precio		WITH ROUND(.activesheet.cells(i, 6).value, 2)	ADDITIVE
		
		lnPorcentaje = (i * 100) / (lnFil - 2)
		WAIT WINDOW "Leyendo: " + STR(i) + " registro de " + STR(lnFil) NOWAIT 
		progressBar.update(lnPorcentaje)
	ENDFOR

	.workbooks.close()
	.quit
ENDWITH

progressBar.complete()
progressBar.release()

RELEASE loExcel
SELECT cur_Artic
IF RECCOUNT() > 0
	GO TOP
ENDIF

ENDPROC
PROCEDURE actualizar_articulos
LOCAL loResult, loCommand, lcSql, lnIdFamilia, lnIdSubFam
LOCAL lnIdMarca, lcCodigo, lcDescripcio, lnPrecio
LOCAL lcFamilia, lcSubFam, lcMarca, loDT, lcLinkFoto, lcObserv
LOCAL loProg, i, lnTotReg

loResult = CREATEOBJECT("odbc_result")
loCommand = CREATEOBJECT("odbc_command")
loDT = CREATEOBJECT("datetime")
loProg = CREATEOBJECT("_thermometer")
lcSql = ""
lnIdFamilia = 0
lnIdSubFam = 0
lnIdMarca = 0
lcCodigo = ""
lcDescripcio = ""
lnPrecio = 0.00
lcFamilia = ""
lcSubFam = ""
lcMarca = ""
lcLinkFoto = ""
lcObserv = ""
lnTotReg = 0 
i = 0

&&This.descargar()
IF !This.open() THEN 
	RETURN .F.
ENDIF 

loProg.Show()

&& Establezco el nivel de aislamiento de lectura no confirmada
loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = "set session transaction isolation level read uncommitted"

IF !loCommand.Execute() THEN
	goConn.Rollback()
	This.error_message = loCommand.ErrorMessage
	RETURN .F.
ENDIF

goConn.BeginTransaction()

**********************************************************************************************
&& Levanto la familia
**********************************************************************************************
lcFamilia = "VARIOS"

lcSql = "SELECT * FROM familias WHERE LTRIM(RTRIM(descripcio)) = '" + ALLTRIM(lcFamilia) + "'"
loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_Familia"

IF !loResult.OpenQuery(lcSql) THEN
	This.Error_Message = loResult.Error_Message
	goConn.Rollback()
	RETURN .F.
ENDIF

SELECT cur_Familia
IF RECCOUNT("cur_Familia") = 0 THEN
	lnIdFamilia = goConn.GetNextID("familias", "idFamilia")

	lcSql = "INSERT INTO familias ( "
	lcSql = lcSql + "idFamilia, "
	lcSql = lcSql + "descripcio, "
	lcSql = lcSql + "usuAlta, "
	lcSql = lcSql + "fecAlta, "
	lcSql = lcSql + "idHostAlta) VALUES ( "
	lcSql = lcSql + ALLTRIM(STR(lnIdFamilia)) + ", "
	lcSql = lcSql + "'" + lcFamilia + "', "
	lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
	lcSql = lcSql + loDT.getDateTime() + ", "
	lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "')"
	
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute() THEN
		goConn.Rollback()
		This.Error_Message = loCommand.ErrorMessage
		loResult.Close_Query()
		RETURN .F.
	ENDIF
ELSE
	lnIdFamilia = cur_Familia.IdFamilia
ENDIF

loResult.Close_Query()


**********************************************************************************************
&& Levanto la subfamilia
**********************************************************************************************
lcSubFam = "VARIOS"

lcSql = "SELECT * FROM subfam WHERE LTRIM(RTRIM(descripcio)) = '" + ALLTRIM(lcSubFam) + "'"
loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_SubFam"

IF !loResult.OpenQuery(lcSql) THEN
	This.Error_Message = loResult.Error_Message
	goConn.Rollback()
	loResult.Close_Query()
	RETURN .F.
ENDIF

IF RECCOUNT("cur_SubFam") = 0 THEN
	lnIdSubFam = goConn.GetNextID("subfam", "idSubFam")

	lcSql = "INSERT INTO subfam ( "
	lcSql = lcSql + "	idSubFam, "
	lcSql = lcSql + "	descripcio, "
	lcSql = lcSql + "	usuAlta, "
	lcSql = lcSql + "	fecAlta, "
	lcSql = lcSql + "	idHostAlta) VALUES ("
	lcSql = lcSql + ALLTRIM(STR(lnIdSubFam)) + ", "
	lcSql = lcSql + "'" + lcSubFam + "', "
	lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
	lcSql = lcSql + loDT.getDateTime() + ", "
	lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "')"
	
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute() THEN
		This.Error_Message = loCommand.ErrorMessage
		goConn.Rollback()
		loResult.Close_Query()
		RETURN .F.
	ENDIF
ELSE
	lnIdSubFam = cur_SubFam.idSubFam
ENDIF

loResult.Close_Query()

&& Recorro los articulos y comienzo la actualizacion articulo por articulo
SELECT cur_artic
lnTotReg = RECCOUNT("cur_artic")

DO WHILE !EOF("cur_artic")
	lcCodigo = ALLTRIM(cur_artic.codigo)
	lcDescripcio = ALLTRIM(cur_artic.descrip)
	lnPrecio = cur_artic.precio
	lcMarca = ALLTRIM(cur_artic.marca)
	&& lcLinkFoto = ALLTRIM(cur_artic.linkfoto)
	&&lcObserv = ALLTRIM(cur_artic.descrip2)
	
	**********************************************************************************************
	&& Levanto la marca
	**********************************************************************************************
	lcSql = "SELECT * FROM marcas WHERE LTRIM(RTRIM(descripcio)) = '" + ALLTRIM(lcMarca) + "'"
	loResult.ActiveConnection = goConn.ActiveConnection
	loResult.Cursor_Name = "cur_mrcs"
	
	IF !loResult.OpenQuery(lcSql) THEN
		goConn.Rollback()
		This.Error_Message = loResult.Error_Message
		RETURN .F.
	ENDIF
	
	SELECT cur_mrcs
	IF RECCOUNT("cur_mrcs") = 0 THEN
		lnIdMarca = goConn.GetNextID("marcas", "idMarca")
		
		lcSql = "INSERT INTO marcas ( "
		lcSql = lcSql + "idmarca, "
		lcSql = lcSql + "descripcio, "
		lcSql = lcSql + "usuAlta, "
		lcSql = lcSql + "fecAlta, "
		lcSql = lcSql + "idHostAlta) VALUES ( "
		lcSql = lcSql + ALLTRIM(STR(lnIdMarca)) + ", "
		lcSql = lcSql + "'" + ALLTRIM(lcMarca) + "', "
		lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
		lcSql = lcSql + loDT.getDateTime() + ", "
		lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "')"
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			This.Error_Message = loCommand.ErrorMessage
			loResult.Close_Query()
			RETURN .F.
		ENDIF
	ELSE
		lnIdMarca = cur_mrcs.idmarca
	ENDIF
	
	loResult.Close_Query()

	**************************************************************
	&& Doy de alta el artículo en la base de datos
	**************************************************************
	IF !This.insertar_articulo(lnIdFamilia, lnIdSubFam, lnIdMarca, lcCodigo, ;
			lcDescripcio, lnPrecio, lcLinkFoto, lcObserv) THEN
		goConn.Rollback()
		RETURN .F.
	ENDIF

	i = i + 1
	WAIT WINDOW "Procesando " + ALLTRIM(STR(i)) + " de " + ALLTRIM(STR(lnTotReg)) + "..." NOWAIT
	loProg.Update((i * 100) / lnTotReg, "Actualizando artículos desde DM...")
	
	SELECT cur_artic
	SKIP
ENDDO

goConn.Commit()

&& Establezco el nivel de aislamiento de lectura confirmada
loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = "set session transaction isolation level read committed"

IF !loCommand.Execute() THEN
	goConn.Rollback()
	This.error_message = loCommand.ErrorMessage
	RETURN .F.
ENDIF

loProg.Complete()
RETURN .T.
ENDPROC
PROCEDURE insertar_articulo
PARAMETERS tnIdFamilia, tnIdSubFam, tnIdMarca, tcCodArt, tcDescripcio, tnPrLista, tnLinkFoto, tcObserv

LOCAL 	lnCostoRep, lnMargenMax, lnMargenMin, lnPrVentaMax, lnPrVentaMin,;
		lnFinalMax, lnFinalMin, lcObserv, lnPrLista
LOCAL 	lnBonif1, lnBonif2, lnBonif3, lnBonif4		
LOCAL 	loCommand, lcSql, loResult, lnProxID, loDT, loUniDesp
LOCAL 	lnProxID, lnPrAnt, lnUniDesp, lnPrDif, lnPorVar, lbActuFoto 

loDT = CREATEOBJECT("datetime")
loCommand = CREATEOBJECT("odbc_command")
loResult = CREATEOBJECT("odbc_result")
loUniDesp = CREATEOBJECT("odbc_result")
lcSql = ""
lnCostoRep = 0.00
lnMargenMax = 0.00
lnMargenMin = 0.00
lnPrVentaMax = 0.00
lnPrVentaMin = 0.00
lnFinalMax = 0.00
lnFinalMin = 0.00
lcObserv = ""
lnPrLista = 0.00
lnProxID = 0.00
lnBonif1 = 0.00
lnBonif2 = 0.00
lnBonif3 = 0.00
lnBonif4 = 0.00
lnProxID = 0
lnPrAnt = 0.00
lnUniDesp = 0.00
lnPrDif = 0.00
lnPorVar = 0.00

lcCodigo = ALLTRIM(tcCodArt)
&& lbActuFoto = getglobalcfg("VERFOTODER")

IF INT(VAL(getconfig("SQLSRV"))) = 0 THEN 
	tnLinkFoto = ALLTRIM(STRTRAN(tnLinkFoto,"\","\\"))
ENDIF 

lcSql = "SELECT * FROM articulos WHERE codArt = '" + lcCodigo + "'"
loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_tmp"

IF !loResult.OpenQuery(lcSql) THEN
	MESSAGEBOX(loResult.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_tmp
IF RECCOUNT("cur_tmp") = 0 THEN
	lnBonif1 = this.desc1
	lnBonif2 = this.desc2
	lnBonif3 = this.desc3
	lnBonif4 = this.desc4
	lnMargenMax = this.margenmay
	lnMargenMin = this.margenmin
	
	* Calculo el precio de venta
	lnPrLista = tnPrLista
	lnCostoRep = calcular_costo(lnPrLista, lnBonif1, lnBonif2, lnBonif3, lnBonif4, 0)
	lnPrVentaMax = lnCostoRep + (lnCostoRep * (lnMargenMax / 100))
	lnPrVentaMin = lnCostoRep + (lnCostoRep * (lnMargenMin / 100))
	lnFinalMax = lnPrVentaMax + (lnPrVentaMax * (this.alic_iva / 100))
	lnFinalMin = lnPrVentaMin + (lnPrVentaMin * (this.alic_iva / 100))

	lnProxID = goConn.GetNextID("articulos", "idArticulo")

	lcSql = "INSERT INTO articulos ( "
	lcSql = lcSql + "	idArticulo, "
	lcSql = lcSql + "	idProv, "
	lcSql = lcSql + "	idFamilia, "
	lcSql = lcSql + "	idSubFam, "
	lcSql = lcSql + "	idMarca, "
	lcSql = lcSql + "	codArt, "
	lcSql = lcSql + "	descripcio, "
	lcSql = lcSql + "	alicIVA, "
	lcSql = lcSql + "	tmon, "
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
	lcSql = lcSql + "	prventaMax, "
	lcSql = lcSql + "	prventaMin, "
	lcSql = lcSql + "	prfinalMax, "
	lcSql = lcSql + "	prfinalMin, "
	lcSql = lcSql + "	observ, "
	lcSql = lcSql + "	idUniMed, "
	lcSql = lcSql + "	habilitado, "
	lcSql = lcSql + "	linkfoto, "
	lcSql = lcSql + "	usuAlta, "
	lcSql = lcSql + "	fecAlta, "
	lcSql = lcSql + "	idHostAlta) "
	lcSql = lcSql + "VALUES ( "
	lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", "					&& idAticulo
	lcSql = lcSql + ALLTRIM(STR(This.idProv)) + ", " 				&& Proveedor
	lcSql = lcSql + ALLTRIM(STR(tnIdFamilia)) + ", " 				&& Familia
	lcSql = lcSql + ALLTRIM(STR(tnIdSubFam)) + ", "					&& SubFamilia
	lcSql = lcSql + ALLTRIM(STR(tnIdMarca)) + ", " 					&& Marca
	lcSql = lcSql + "'" + UPPER(ALLTRIM(lcCodigo)) + "', "					&& CodArt
	lcSql = lcSql + "'" + UPPER(STRTRAN(ALLTRIM(tcDescripcio), "'", " ")) + "', "	&& Descripcio
	lcSql = lcSql + ALLTRIM(STR(This.alic_iva, 10, 2)) + ", "		&& alicIVA
	lcSql = lcSql + "'PSO', "										&& tMon
	lcSql = lcSql + "0, "											&& Precio de lista ext.
	lcSql = lcSql + "0, "											&& Cotización
	lcSql = lcSql + ALLTRIM(STR(lnPrLista, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(This.desc1, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(This.desc2, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(This.desc3, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(This.desc4, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnCostoRep, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(This.margenmay, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(This.margenmin, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPrVentaMax, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPrVentaMin, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnFinalMax, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnFinalMin, 10, 2)) + ", "
	lcSql = lcSql + "'" + UPPER(STRTRAN(ALLTRIM(tcObserv), "'", " ")) + "', " && Observ
	lcSql = lcSql + "1, "											&& idUniMed
	lcSql = lcSql + "1, "											&& habilitado
	
&&	IF !lbActuFoto THEN 
&&		lcSql = lcSql + "NULL, " 	
&&	ELSE 
		lcSql = lcSql + "'" + UPPER(ALLTRIM(tnLinkFoto)) + "', "	
&&	ENDIF 
			
	lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
	lcSql = lcSql + loDT.getDateTime() + ", "
	lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "')"

	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute() THEN
		This.error_message = loCommand.ErrorMessage
		loResult.Close_Query()
		RETURN .F.
	ENDIF
	
	&& Agrego el registro al codiart
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
	lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", "
	lcSql = lcSql + "'" + UPPER(ALLTRIM(lcCodigo)) + "', "
	lcSql = lcSql + "'" + UPPER(ALLTRIM(lcCodigo)) + "', "
	lcSql = lcSql + "'CP', "
	lcSql = lcSql + "1, "
	lcSql = lcSql + "0, "
	lcSql = lcSql + "'CV')"
	
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute() THEN
		this.errorMessage = loCommand.ErrorMessage
		loResult.Close_Query()
		RETURN .F.
	ENDIF	
	
ELSE
	&& Me fijo si en art_unid esta el articulo
	lcSql = "SELECT	* "
	lcSql = lcSql + "FROM art_unid "
	lcSql = lcSql + "WHERE art_unid.idArticulo = " + ALLTRIM(STR(cur_tmp.IdArticulo))

	loUniDesp.ActiveConnection = goConn.ActiveConnection
	loUniDesp.Cursor_Name = "cur_ud"

	IF !loUniDesp.OpenQuery(lcSql) THEN
		MESSAGEBOX(loUniDesp.Error_Message, 0+48, Thisform.Caption)
		loResult.Close_Query()
		RETURN .F.
	ENDIF

	SELECT cur_ud
	IF RECCOUNT("cur_ud") > 0 THEN
		lnUniDesp = cur_ud.cantUD
	ELSE
		lnUniDesp = 0.00
	ENDIF

	loUniDesp.Close_Query()

	&& Calculo la variacion en el cambio de precio
	lnPrAnt = cur_tmp.prLista
	
	IF tnPrLista > lnPrAnt THEN
		lnPrDif = tnPrLista  - lnPrAnt 
		IF lnPrAnt <> 0 THEN
			lnPorVar = (lnPrDif * 100) / lnPrAnt 
		ELSE
			lnPorVar = 100
		ENDIF
	ELSE
		lnPrDif = lnPrAnt  - tnPrLista 
		IF lnPrAnt <> 0 THEN
			lnPorVar = ((lnPrDif * 100) / lnPrAnt) * -1
		ELSE
			lnPorVar = 100
		ENDIF
	ENDIF
	
	lnBonif1 = IIF(this.desc1 = 0, cur_tmp.bonif1, this.desc1)
	lnBonif2 = IIF(this.desc2 = 0, cur_tmp.bonif2, this.desc2)
	lnBonif3 = IIF(this.desc3 = 0, cur_tmp.bonif3, this.desc3)
	lnBonif4 = IIF(this.desc4 = 0, cur_tmp.bonif4, this.desc3)
	lnMargenMax = IIF(this.margenmay = 0, cur_tmp.margenMax, this.margenmay)
	lnMargenMin = IIF(this.margenmin = 0, cur_tmp.margenMin, this.margenmin)

	* Calculo el precio de venta
	IF lnUniDesp <> 0 THEN 
		lnPrLista = tnPrLista / lnUniDesp 
	ELSE 
		lnPrLista = tnPrLista
	ENDIF 

	lnCostoRep = calcular_costo(lnPrLista, lnBonif1, lnBonif2, lnBonif3, lnBonif4, 0)
	lnPrVentaMax = lnCostoRep + (lnCostoRep * (lnMargenMax / 100))
	lnPrVentaMin = lnCostoRep + (lnCostoRep * (lnMargenMin / 100))
	lnFinalMax = lnPrVentaMax + (lnPrVentaMax * (this.alic_iva / 100))
	lnFinalMin = lnPrVentaMin + (lnPrVentaMin * (this.alic_iva / 100))

	&& En caso de existir el código, modifico el artículo
	lcSql = "UPDATE articulos "
	lcSql = lcSql + "SET 	idProv = " + ALLTRIM(STR(This.idProv)) + ", " 				
&&	lcSql = lcSql + "		idFamilia = " + ALLTRIM(STR(tnIdFamilia)) + ", " 			
&&	lcSql = lcSql + "		idSubFam = " + ALLTRIM(STR(tnIdSubFam)) + ", "					
&&	lcSql = lcSql + "		idMarca = " + ALLTRIM(STR(tnIdMarca)) + ", " 					
&&	lcSql = lcSql + "		descripcio = '" + STRCONV(STRTRAN(ALLTRIM(tcDescripcio), "'", " "),11) + "', "
	lcSql = lcSql + "		descripcio = '" + UPPER(STRTRAN(ALLTRIM(tcDescripcio), "'", " ")) + "', "
	lcSql = lcSql + "		alicIVA = " + ALLTRIM(STR(This.alic_iva, 10, 2)) + ", "
	lcSql = lcSql + "		prLista = " + ALLTRIM(STR(lnPrLista, 10, 2)) + ", "
	lcSql = lcSql + "		bonif1 = " + ALLTRIM(STR(lnBonif1, 10, 2)) + ", "
	lcSql = lcSql + "		bonif2 = " + ALLTRIM(STR(lnBonif2, 10, 2)) + ", "
	lcSql = lcSql + "		bonif3 = " + ALLTRIM(STR(lnBonif3, 10, 2)) + ", "
	lcSql = lcSql + "		bonif4 = " + ALLTRIM(STR(lnBonif4, 10, 2)) + ", "
	lcSql = lcSql + "		costoRep = " + ALLTRIM(STR(lnCostoRep, 10, 2)) + ", "
	lcSql = lcSql + "		margenMax = " + ALLTRIM(STR(lnMargenMax, 10, 2)) + ", "
	lcSql = lcSql + "		margenMin = " + ALLTRIM(STR(lnMargenMin, 10, 2)) + ", "
	lcSql = lcSql + "		prventaMax = " + ALLTRIM(STR(lnPrVentaMax, 10, 2)) + ", "
	lcSql = lcSql + "		prventaMin = " + ALLTRIM(STR(lnPrVentaMin, 10, 2)) + ", "
	lcSql = lcSql + "		prfinalMax = " + ALLTRIM(STR(lnFinalMax, 10, 2)) + ", "
	lcSql = lcSql + "		prfinalMin = " + ALLTRIM(STR(lnFinalMin, 10, 2)) + ", "
	lcSql = lcSql + "		observ =  '" + UPPER(STRTRAN(ALLTRIM(tcObserv), "'", " ")) + "', "
	
	&&IF lbActuFoto THEN 
		lcSql = lcSql + "	linkfoto = '" + UPPER(ALLTRIM(tnLinkFoto)) + "', "	
	&&ENDIF 
	
	lcSql = lcSql + "		usuModi = '" + ALLTRIM(gcCodUsu) + "', "
	lcSql = lcSql + "		fecModi = " + loDT.getdatetime() + ", "
	lcSql = lcSql + "		idHostModi = '" + ALLTRIM(SYS(0)) + "' "
	lcSql = lcSql + "WHERE codArt = '" + ALLTRIM(lcCodigo) + "'"
	
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute() THEN
		this.error_message = loCommand.ErrorMessage
		loResult.Close_Query()
		RETURN .F.
	ENDIF

	IF lnPorVar <> 0 THEN
		&& Agrego el insert que permite registrar los cambios de precios de los artículos
		lnProxID = goConn.GetNextID("art_cbios", "idArtCbios")
		
		lcSql = "insert into art_cbios ( "
		lcSql = lcSql + "idArtCbios, idArticulo, fecha, prAnt, prNuevo, porVar) values ("
		lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_tmp.idArticulo)) + ", "
		lcSql = lcSql + loDT.getDateTime() + ", "
		lcSql = lcSql + ALLTRIM(STR(lnPrAnt, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnPrLista, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnPorVar, 10, 2)) + ") "
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			this.ErrorMessage = loCommand.ErrorMessage
			loResult.Close_Query()
			RETURN .F.
		ENDIF
	ENDIF
ENDIF

loResult.Close_Query()

RETURN .T.
ENDPROC
PROCEDURE descargar

Dele FILE This.path + "DATOS.ZIP"
Dele FILE This.path + "ELECTRODIESEL.CSV"

IF !internet() THEN 
	MESSAGEBOX("No se puede realizar la actualización, la PC no se encuentra conectada a internet.", 16, "Actualización de precios On-line - Electrodiesel Argentina S.R.L.")
	RETURN .F.
ENDIF

&& vZip = Createobject("XStandard.Zip")
WAIT WINDOWS 'Estableciendo conexión...' NOWAIT
sz_ftp = CREATEOBJECT('ftp_service')
IF sz_ftp.OpenInternet("tapice@electrodiesel.com.ar", "Tapice2015", "ftp.electrodiesel.com.ar", "21")
	IF sz_ftp.ChangeFtpDirectory("/datos")

		WAIT WINDOWS 'Descargando...' NOWAIT

		IF sz_ftp.GetFtpFile("datos.zip", this.path + "DATOS.zip")

			&& vZip.UnPack(vRuta+"\ACT\DATOS.zip", vRuta+"\ACT")
			
			&& Descomprimo el archivo
			oZip=CREATEOBJECT('Zip.Zip')
			oZip.ArchivoZip = This.path + "datos.zip"
			oZip.DirectorioDestino = This.path
			oZip.Descomprimir()
		ELSE
			MESSAGEBOX("No se pudo descargar la actualización.", 16, "Electrodiesel Argentina S.R.L.")
			sz_ftp.CloseInternet()
			?sz_ftp.GetErrorCode(.T.)
		ENDIF
	ELSE
		MESSAGEBOX("No se pudo descargar la actualización. Error al acceder a la carpeta /datos. ", 16, "Electrodiesel Argentina S.R.L.")
		sz_ftp.CloseInternet()
		?sz_ftp.GetErrorCode(.T.)
	ENDIF
ELSE
	MESSAGEBOX("No se pudo establecer la conexión.", 16, "Electrodiesel Argentina S.R.L.")
	sz_ftp.CloseInternet()
	?sz_ftp.GetErrorCode(.T.)
ENDIF

ENDPROC


************************************************************
OBJETO: actu_cromosol
************************************************************
*** PROPIEDADES ***
Height = 15
Width = 100
desc1 = 0.00
desc2 = 0.00
desc3 = 0.00
desc4 = 0.00
margenmay = 0.00
margenmin = 0.00
idprov = 0
path = 
error_message = 
alic_iva = 21
Name = "actu_cromosol"

*** METODOS ***
PROCEDURE open
CREATE CURSOR cur_art(	;
	Codigo			C(20)	,;
	CodArtPV		C(20)	,;
	Descrip			C(200)	,;
	Marca			C(60)	,;
	Precio			C(20)	,;
	Iva				C(5)	,;
	Subrubro		C(60)	)


CREATE CURSOR cur_artic(	;
	Codigo			C(20)	,;
	CodArtPV		C(20)	,;
	Descrip			C(200)	,;
	Marca			C(60)	,;
	Precio			float(10,2)	,;
	Iva				float(10,2)	,;
	Subrubro		C(60)	)

SELECT cur_art
INDEX ON Codigo TAG Codigo ASCENDING

SELECT cur_artic
INDEX ON Codigo TAG Codigo ASCENDING

WAIT WINDOW "Leyendo artículos desde CROMOSOL..." NOWAIT

SELECT cur_art
APPEND FROM this.path + "cromoupdate_cromosol.csv" DELIMITER WITH CHARACTER ";" AS 1252

SELECT cur_art

lcCodProv = "-" + REPLICATE("0", 3 - LEN(ALLTRIM(STR(this.idprov)))) + ALLTRIM(STR(this.idprov))

INSERT INTO cur_artic ;
	SELECT MAX(ALLTRIM(codigo) + lcCodProv), ALLTRIM(codartPV), MAX(ALLTRIM(descrip)), MAX(ALLTRIM(marca)), MAX(float(VAL(STRTRAN(precio,",",".")))), MAX(float(VAL(STRTRAN(iva,",",".")))), MAX(ALLTRIM(Subrubro)) ;
	FROM cur_art ;
	GROUP BY codartPV

USE IN cur_art 

SELECT cur_artic
IF RECCOUNT("cur_artic") > 0 THEN
	GO TOP
ENDIF
ENDPROC
PROCEDURE actualizar_articulos
LOCAL loResult, loCommand, lcSql, lnIdFamilia, lnIdSubFam
LOCAL lnIdMarca, lcCodigo, lcDescripcio, lnPrecio
LOCAL lcFamilia, lcSubFam, lcMarca, loDT, lcLinkFoto, lcObserv
LOCAL loProg, i, lnTotReg, lcCodArtPV, lnIVA

loResult = CREATEOBJECT("odbc_result")
loCommand = CREATEOBJECT("odbc_command")
loDT = CREATEOBJECT("datetime")
loProg = CREATEOBJECT("_thermometer")
lcSql = ""
lnIdFamilia = 0
lnIdSubFam = 0
lnIdMarca = 0
lcCodigo = ""
lcDescripcio = ""
lnPrecio = 0.00
lcFamilia = ""
lcSubFam = ""
lcMarca = ""
lcLinkFoto = ""
lcObserv = ""
lnTotReg = 0 
i = 0
lcCodArtPV = ""
lnIVA = 0.00

This.descargar()
This.open()
loProg.Show()

&& Establezco el nivel de aislamiento de lectura no confirmada
loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = "set session transaction isolation level read uncommitted"

IF !loCommand.Execute() THEN
	goConn.Rollback()
	This.error_message = loCommand.ErrorMessage
	RETURN .F.
ENDIF

goConn.BeginTransaction()



&& Recorro los articulos y comienzo la actualizacion articulo por articulo
SELECT cur_artic
lnTotReg = RECCOUNT("cur_artic")

DO WHILE !EOF("cur_artic")
	lcCodigo = ALLTRIM(cur_artic.codigo)
	lcCodArtPV = ALLTRIM(cur_artic.codArtPV)
	lcDescripcio = ALLTRIM(cur_artic.descrip)
	lnPrecio = cur_artic.precio
	lcFamilia = "VARIOS"
	lcSubFam = ALLTRIM(cur_artic.subrubro)
	lcMarca = ALLTRIM(cur_artic.marca)
	lnIVA = cur_artic.iva
	&& lcLinkFoto = ALLTRIM(cur_artic.linkfoto)
	
	**********************************************************************************************
	&& Levanto la familia
	**********************************************************************************************
	lcSql = "SELECT * FROM familias WHERE LTRIM(RTRIM(descripcio)) = '" + ALLTRIM(lcFamilia) + "'"
	loResult.ActiveConnection = goConn.ActiveConnection
	loResult.Cursor_Name = "cur_Familia"

	IF !loResult.OpenQuery(lcSql) THEN
		This.Error_Message = loResult.Error_Message
		goConn.Rollback()
		RETURN .F.
	ENDIF

	SELECT cur_Familia
	IF RECCOUNT("cur_Familia") = 0 THEN
		lnIdFamilia = goConn.GetNextID("familias", "idFamilia")

		lcSql = "INSERT INTO familias ( "
		lcSql = lcSql + "idFamilia, "
		lcSql = lcSql + "descripcio, "
		lcSql = lcSql + "usuAlta, "
		lcSql = lcSql + "fecAlta, "
		lcSql = lcSql + "idHostAlta) VALUES ( "
		lcSql = lcSql + ALLTRIM(STR(lnIdFamilia)) + ", "
		lcSql = lcSql + "'" + lcFamilia + "', "
		lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
		lcSql = lcSql + loDT.getDateTime() + ", "
		lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "')"
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			This.Error_Message = loCommand.ErrorMessage
			loResult.Close_Query()
			RETURN .F.
		ENDIF
	ELSE
		lnIdFamilia = cur_Familia.IdFamilia
	ENDIF

	loResult.Close_Query()


	**********************************************************************************************
	&& Levanto la subfamilia
	**********************************************************************************************
	IF !EMPTY(ALLTRIM(lcSubFam)) THEN 
		lcSql = "SELECT * FROM subfam WHERE LTRIM(RTRIM(descripcio)) = '" + ALLTRIM(lcSubFam) + "'"
		loResult.ActiveConnection = goConn.ActiveConnection
		loResult.Cursor_Name = "cur_SubFam"

		IF !loResult.OpenQuery(lcSql) THEN
			This.Error_Message = loResult.Error_Message
			goConn.Rollback()
			loResult.Close_Query()
			RETURN .F.
		ENDIF

		IF RECCOUNT("cur_SubFam") = 0 THEN
			lnIdSubFam = goConn.GetNextID("subfam", "idSubFam")

			lcSql = "INSERT INTO subfam ( "
			lcSql = lcSql + "	idSubFam, "
			lcSql = lcSql + "	descripcio, "
			lcSql = lcSql + "	usuAlta, "
			lcSql = lcSql + "	fecAlta, "
			lcSql = lcSql + "	idHostAlta) VALUES ("
			lcSql = lcSql + ALLTRIM(STR(lnIdSubFam)) + ", "
			lcSql = lcSql + "'" + lcSubFam + "', "
			lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
			lcSql = lcSql + loDT.getDateTime() + ", "
			lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "')"
			
			loCommand.ActiveConnection = goConn.ActiveConnection
			loCommand.CommandText = lcSql
			
			IF !loCommand.Execute() THEN
				This.Error_Message = loCommand.ErrorMessage
				goConn.Rollback()
				loResult.Close_Query()
				RETURN .F.
			ENDIF
		ELSE
			lnIdSubFam = cur_SubFam.idSubFam
		ENDIF

		loResult.Close_Query()
	ENDIF 
	
	**********************************************************************************************
	&& Levanto la marca
	**********************************************************************************************
	IF !EMPTY(ALLTRIM(lcMarca)) THEN 
		lcSql = "SELECT * FROM marcas WHERE LTRIM(RTRIM(descripcio)) = '" + ALLTRIM(lcMarca) + "'"
		loResult.ActiveConnection = goConn.ActiveConnection
		loResult.Cursor_Name = "cur_mrcs"
		
		IF !loResult.OpenQuery(lcSql) THEN
			goConn.Rollback()
			This.Error_Message = loResult.Error_Message
			RETURN .F.
		ENDIF
		
		SELECT cur_mrcs
		IF RECCOUNT("cur_mrcs") = 0 THEN
			lnIdMarca = goConn.GetNextID("marcas", "idMarca")
			
			lcSql = "INSERT INTO marcas ( "
			lcSql = lcSql + "idmarca, "
			lcSql = lcSql + "descripcio, "
			lcSql = lcSql + "usuAlta, "
			lcSql = lcSql + "fecAlta, "
			lcSql = lcSql + "idHostAlta) VALUES ( "
			lcSql = lcSql + ALLTRIM(STR(lnIdMarca)) + ", "
			lcSql = lcSql + "'" + ALLTRIM(lcMarca) + "', "
			lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
			lcSql = lcSql + loDT.getDateTime() + ", "
			lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "')"
			
			loCommand.ActiveConnection = goConn.ActiveConnection
			loCommand.CommandText = lcSql
			
			IF !loCommand.Execute() THEN
				goConn.Rollback()
				This.Error_Message = loCommand.ErrorMessage
				loResult.Close_Query()
				RETURN .F.
			ENDIF
		ELSE
			lnIdMarca = cur_mrcs.idmarca
		ENDIF
		
		loResult.Close_Query()
	
	ENDIF 
	
	**************************************************************
	&& Doy de alta el artículo en la base de datos
	**************************************************************
	IF !This.insertar_articulo(lnIdFamilia, lnIdSubFam, lnIdMarca, lcCodigo, ;
			lcDescripcio, lnPrecio, lcLinkFoto, lcObserv, lcCodArtPV, lnIVA) THEN
		goConn.Rollback()
		RETURN .F.
	ENDIF
	
	i = i + 1
	WAIT WINDOW "Procesando " + ALLTRIM(STR(i)) + " de " + ALLTRIM(STR(lnTotReg)) + "..." NOWAIT
	loProg.Update((i * 100) / lnTotReg, "Actualizando artículos desde CROMOSOL...")
	
	SELECT cur_artic
	SKIP
ENDDO

goConn.Commit()

&& Establezco el nivel de aislamiento de lectura confirmada
loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = "set session transaction isolation level read committed"

IF !loCommand.Execute() THEN
	goConn.Rollback()
	This.error_message = loCommand.ErrorMessage
	RETURN .F.
ENDIF

loProg.Complete()
RETURN .T.
ENDPROC
PROCEDURE insertar_articulo
PARAMETERS tnIdFamilia, tnIdSubFam, tnIdMarca, tcCodArt, tcDescripcio, tnPrLista, tnLinkFoto, tcObserv, tcCodArtPV, tnIVA

LOCAL 	lnCostoRep, lnMargenMax, lnMargenMin, lnPrVentaMax, lnPrVentaMin,;
		lnFinalMax, lnFinalMin, lcObserv, lnPrLista
LOCAL 	lnBonif1, lnBonif2, lnBonif3, lnBonif4		
LOCAL 	loCommand, lcSql, loResult, lnProxID, loDT, loUniDesp
LOCAL 	lnProxID, lnPrAnt, lnUniDesp, lnPrDif, lnPorVar, lbActuFoto 

loDT = CREATEOBJECT("datetime")
loCommand = CREATEOBJECT("odbc_command")
loResult = CREATEOBJECT("odbc_result")
loUniDesp = CREATEOBJECT("odbc_result")
lcSql = ""
lnCostoRep = 0.00
lnMargenMax = 0.00
lnMargenMin = 0.00
lnPrVentaMax = 0.00
lnPrVentaMin = 0.00
lnFinalMax = 0.00
lnFinalMin = 0.00
lcObserv = ""
lnPrLista = 0.00
lnProxID = 0.00
lnBonif1 = 0.00
lnBonif2 = 0.00
lnBonif3 = 0.00
lnBonif4 = 0.00
lnProxID = 0
lnPrAnt = 0.00
lnUniDesp = 0.00
lnPrDif = 0.00
lnPorVar = 0.00

lcCodigo = ALLTRIM(tcCodArt)
&& lbActuFoto = getglobalcfg("VERFOTODER")

IF INT(VAL(getconfig("SQLSRV"))) = 0 THEN 
	tnLinkFoto = ALLTRIM(STRTRAN(tnLinkFoto,"\","\\"))
ENDIF 

lcSql = "SELECT * FROM articulos WHERE codArt = '" + lcCodigo + "'"
loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_tmp"

IF !loResult.OpenQuery(lcSql) THEN
	MESSAGEBOX(loResult.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_tmp
IF RECCOUNT("cur_tmp") = 0 THEN
	lnBonif1 = this.desc1
	lnBonif2 = this.desc2
	lnBonif3 = this.desc3
	lnBonif4 = this.desc4
	lnMargenMax = this.margenmay
	lnMargenMin = this.margenmin
	
	* Calculo el precio de venta
	lnPrLista = tnPrLista
	lnCostoRep = calcular_costo(lnPrLista, lnBonif1, lnBonif2, lnBonif3, lnBonif4, 0)
	lnPrVentaMax = lnCostoRep + (lnCostoRep * (lnMargenMax / 100))
	lnPrVentaMin = lnCostoRep + (lnCostoRep * (lnMargenMin / 100))
	lnFinalMax = lnPrVentaMax + (lnPrVentaMax * (tnIVA / 100))
	lnFinalMin = lnPrVentaMin + (lnPrVentaMin * (tnIVA / 100))

	lnProxID = goConn.GetNextID("articulos", "idArticulo")

	lcSql = "INSERT INTO articulos ( "
	lcSql = lcSql + "	idArticulo, "
	lcSql = lcSql + "	idProv, "
	lcSql = lcSql + "	idFamilia, "
	lcSql = lcSql + "	idSubFam, "
	lcSql = lcSql + "	idMarca, "
	lcSql = lcSql + "	codArt, "
	lcSql = lcSql + "	codArtPV, "
	lcSql = lcSql + "	descripcio, "
	lcSql = lcSql + "	alicIVA, "
	lcSql = lcSql + "	tmon, "
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
	lcSql = lcSql + "	prventaMax, "
	lcSql = lcSql + "	prventaMin, "
	lcSql = lcSql + "	prfinalMax, "
	lcSql = lcSql + "	prfinalMin, "
	lcSql = lcSql + "	observ, "
	lcSql = lcSql + "	idUniMed, "
	lcSql = lcSql + "	habilitado, "
	lcSql = lcSql + "	linkfoto, "
	lcSql = lcSql + "	usuAlta, "
	lcSql = lcSql + "	fecAlta, "
	lcSql = lcSql + "	idHostAlta) "
	lcSql = lcSql + "VALUES ( "
	lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", "					&& idAticulo
	lcSql = lcSql + ALLTRIM(STR(This.idProv)) + ", " 				&& Proveedor
	lcSql = lcSql + ALLTRIM(STR(tnIdFamilia)) + ", " 				&& Familia
	lcSql = lcSql + ALLTRIM(STR(tnIdSubFam)) + ", "					&& SubFamilia
	lcSql = lcSql + ALLTRIM(STR(tnIdMarca)) + ", " 					&& Marca
	lcSql = lcSql + "'" + UPPER(ALLTRIM(lcCodigo)) + "', "			&& CodArt
	lcSql = lcSql + "'" + UPPER(ALLTRIM(tcCodArtPV)) + "', "		&& CodArtPV
	lcSql = lcSql + "'" + UPPER(STRTRAN(ALLTRIM(tcDescripcio), "'", " ")) + "', "	&& Descripcio
	lcSql = lcSql + ALLTRIM(STR(tnIVA, 10, 2)) + ", "				&& alicIVA
	lcSql = lcSql + "'PSO', "										&& tMon
	lcSql = lcSql + "0, "											&& Precio de lista ext.
	lcSql = lcSql + "0, "											&& Cotización
	lcSql = lcSql + ALLTRIM(STR(lnPrLista, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(This.desc1, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(This.desc2, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(This.desc3, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(This.desc4, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnCostoRep, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(This.margenmay, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(This.margenmin, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPrVentaMax, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPrVentaMin, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnFinalMax, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnFinalMin, 10, 2)) + ", "
	lcSql = lcSql + "'" + UPPER(STRTRAN(ALLTRIM(tcObserv), "'", " ")) + "', " && Observ
	lcSql = lcSql + "1, "											&& idUniMed
	lcSql = lcSql + "1, "											&& habilitado
	
&&	IF !lbActuFoto THEN 
&&		lcSql = lcSql + "NULL, " 	
&&	ELSE 
		lcSql = lcSql + "'" + UPPER(ALLTRIM(tnLinkFoto)) + "', "	
&&	ENDIF 
			
	lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
	lcSql = lcSql + loDT.getDateTime() + ", "
	lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "')"

	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute() THEN
		This.error_message = loCommand.ErrorMessage
		loResult.Close_Query()
		RETURN .F.
	ENDIF
	
	&& Agrego el registro al codiart
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
	lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", "
	lcSql = lcSql + "'" + UPPER(ALLTRIM(lcCodigo)) + "', "
	lcSql = lcSql + "'" + UPPER(ALLTRIM(lcCodigo)) + "', "
	lcSql = lcSql + "'CP', "
	lcSql = lcSql + "1, "
	lcSql = lcSql + "0, "
	lcSql = lcSql + "'CV')"
	
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute() THEN
		this.errorMessage = loCommand.ErrorMessage
		loResult.Close_Query()
		RETURN .F.
	ENDIF	
	
ELSE
	&& Me fijo si en art_unid esta el articulo
	lcSql = "SELECT	* "
	lcSql = lcSql + "FROM art_unid "
	lcSql = lcSql + "WHERE art_unid.idArticulo = " + ALLTRIM(STR(cur_tmp.IdArticulo))

	loUniDesp.ActiveConnection = goConn.ActiveConnection
	loUniDesp.Cursor_Name = "cur_ud"

	IF !loUniDesp.OpenQuery(lcSql) THEN
		MESSAGEBOX(loUniDesp.Error_Message, 0+48, Thisform.Caption)
		loResult.Close_Query()
		RETURN .F.
	ENDIF

	SELECT cur_ud
	IF RECCOUNT("cur_ud") > 0 THEN
		lnUniDesp = cur_ud.cantUD
	ELSE
		lnUniDesp = 0.00
	ENDIF

	loUniDesp.Close_Query()

	&& Calculo la variacion en el cambio de precio
	lnPrAnt = cur_tmp.prLista
	
	IF tnPrLista > lnPrAnt THEN
		lnPrDif = tnPrLista  - lnPrAnt 
		IF lnPrAnt <> 0 THEN
			lnPorVar = (lnPrDif * 100) / lnPrAnt 
		ELSE
			lnPorVar = 100
		ENDIF
	ELSE
		lnPrDif = lnPrAnt  - tnPrLista 
		IF lnPrAnt <> 0 THEN
			lnPorVar = ((lnPrDif * 100) / lnPrAnt) * -1
		ELSE
			lnPorVar = 100
		ENDIF
	ENDIF
	
	lnBonif1 = IIF(this.desc1 = 0, cur_tmp.bonif1, this.desc1)
	lnBonif2 = IIF(this.desc2 = 0, cur_tmp.bonif2, this.desc2)
	lnBonif3 = IIF(this.desc3 = 0, cur_tmp.bonif3, this.desc3)
	lnBonif4 = IIF(this.desc4 = 0, cur_tmp.bonif4, this.desc3)
	lnMargenMax = IIF(this.margenmay = 0, cur_tmp.margenMax, this.margenmay)
	lnMargenMin = IIF(this.margenmin = 0, cur_tmp.margenMin, this.margenmin)

	* Calculo el precio de venta
	IF lnUniDesp <> 0 THEN 
		lnPrLista = tnPrLista / lnUniDesp 
	ELSE 
		lnPrLista = tnPrLista
	ENDIF 

	lnCostoRep = calcular_costo(lnPrLista, lnBonif1, lnBonif2, lnBonif3, lnBonif4, 0)
	lnPrVentaMax = lnCostoRep + (lnCostoRep * (lnMargenMax / 100))
	lnPrVentaMin = lnCostoRep + (lnCostoRep * (lnMargenMin / 100))
	lnFinalMax = lnPrVentaMax + (lnPrVentaMax * (this.alic_iva / 100))
	lnFinalMin = lnPrVentaMin + (lnPrVentaMin * (this.alic_iva / 100))

	&& En caso de existir el código, modifico el artículo
	lcSql = "UPDATE articulos "
	lcSql = lcSql + "SET 	idProv = " + ALLTRIM(STR(This.idProv)) + ", " 				
&&	lcSql = lcSql + "		idFamilia = " + ALLTRIM(STR(tnIdFamilia)) + ", " 			
&&	lcSql = lcSql + "		idSubFam = " + ALLTRIM(STR(tnIdSubFam)) + ", "					
&&	lcSql = lcSql + "		idMarca = " + ALLTRIM(STR(tnIdMarca)) + ", " 					
&&	lcSql = lcSql + "		descripcio = '" + STRCONV(STRTRAN(ALLTRIM(tcDescripcio), "'", " "),11) + "', "
	lcSql = lcSql + "		descripcio = '" + UPPER(STRTRAN(ALLTRIM(tcDescripcio), "'", " ")) + "', "
	lcSql = lcSql + "		alicIVA = " + ALLTRIM(STR(tnIVA, 10, 2)) + ", "
	lcSql = lcSql + "		prLista = " + ALLTRIM(STR(lnPrLista, 10, 2)) + ", "
	lcSql = lcSql + "		bonif1 = " + ALLTRIM(STR(lnBonif1, 10, 2)) + ", "
	lcSql = lcSql + "		bonif2 = " + ALLTRIM(STR(lnBonif2, 10, 2)) + ", "
	lcSql = lcSql + "		bonif3 = " + ALLTRIM(STR(lnBonif3, 10, 2)) + ", "
	lcSql = lcSql + "		bonif4 = " + ALLTRIM(STR(lnBonif4, 10, 2)) + ", "
	lcSql = lcSql + "		costoRep = " + ALLTRIM(STR(lnCostoRep, 10, 2)) + ", "
	lcSql = lcSql + "		margenMax = " + ALLTRIM(STR(lnMargenMax, 10, 2)) + ", "
	lcSql = lcSql + "		margenMin = " + ALLTRIM(STR(lnMargenMin, 10, 2)) + ", "
	lcSql = lcSql + "		prventaMax = " + ALLTRIM(STR(lnPrVentaMax, 10, 2)) + ", "
	lcSql = lcSql + "		prventaMin = " + ALLTRIM(STR(lnPrVentaMin, 10, 2)) + ", "
	lcSql = lcSql + "		prfinalMax = " + ALLTRIM(STR(lnFinalMax, 10, 2)) + ", "
	lcSql = lcSql + "		prfinalMin = " + ALLTRIM(STR(lnFinalMin, 10, 2)) + ", "
	lcSql = lcSql + "		observ =  '" + UPPER(STRTRAN(ALLTRIM(tcObserv), "'", " ")) + "', "
	
	&&IF lbActuFoto THEN 
		lcSql = lcSql + "	linkfoto = '" + UPPER(ALLTRIM(tnLinkFoto)) + "', "	
	&&ENDIF 
	
	lcSql = lcSql + "		usuModi = '" + ALLTRIM(gcCodUsu) + "', "
	lcSql = lcSql + "		fecModi = " + loDT.getdatetime() + ", "
	lcSql = lcSql + "		idHostModi = '" + ALLTRIM(SYS(0)) + "' "
	lcSql = lcSql + "WHERE codArt = '" + ALLTRIM(lcCodigo) + "'"
	
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute() THEN
		this.error_message = loCommand.ErrorMessage
		loResult.Close_Query()
		RETURN .F.
	ENDIF

	IF lnPorVar <> 0 THEN
		&& Agrego el insert que permite registrar los cambios de precios de los artículos
		lnProxID = goConn.GetNextID("art_cbios", "idArtCbios")
		
		lcSql = "insert into art_cbios ( "
		lcSql = lcSql + "idArtCbios, idArticulo, fecha, prAnt, prNuevo, porVar) values ("
		lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_tmp.idArticulo)) + ", "
		lcSql = lcSql + loDT.getDateTime() + ", "
		lcSql = lcSql + ALLTRIM(STR(lnPrAnt, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnPrLista, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnPorVar, 10, 2)) + ") "
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			this.ErrorMessage = loCommand.ErrorMessage
			loResult.Close_Query()
			RETURN .F.
		ENDIF
	ENDIF
ENDIF

loResult.Close_Query()

RETURN .T.
ENDPROC
PROCEDURE descargar

Dele FILE This.path + "cromoupdate_cromosol.csv"
Dele FILE This.path + "cromoupdate_bba.csv"

*!*	IF !internet() THEN 
*!*		MESSAGEBOX("No se puede realizar la actualización, la PC no se encuentra conectada a internet.", 16, "Actualización de precios On-line - Tressols S.A.")
*!*		RETURN .F.
*!*	ENDIF

&& Hago el llamado al actualizador.
launchProgram("/data/Cromosol_update","CromosolExport.exe",0,.T.)


ENDPROC


************************************************************
OBJETO: cls_xls_updater
************************************************************
*** PROPIEDADES ***
BorderStyle = 2
Height = 574
Width = 948
DoCreate = .T.
Comment = ""
Caption = "Price Sheet Updater"
idplanilla = 0
Name = "cls_xls_updater"
contenido.Comment = ""
contenido.Name = "contenido"

*** METODOS ***
PROCEDURE xls_analizer
LOCAL loRsArt
LOCAL lcSql
LOCAL loExcel, loSheet, lnFila, lnColumna
LOCAL i
LOCAL m.codArtPV
LOCAL m.idArticulo
LOCAL m.codArt
LOCAL m.descripcio
LOCAL m.alicIVA
LOCAL m.bonif1
LOCAL m.bonif2
LOCAL m.bonif3
LOCAL m.bonif4
LOCAL m.margenMin
LOCAL m.margenMay
LOCAL m.precio
LOCAL m.prListaAnt
LOCAL lnColRef
LOCAL llOK
LOCAL lnIdProv

loRsArt = CREATEOBJECT("odbc_result")
lcSql = ""

m.bonif1 = 0.00
m.bonif2 = 0.00
m.bonif3 = 0.00
m.bonif4 = 0.00
m.margenMin = 0.00
m.margenMay = 0.00
m.precio = 0.00
m.prListaAnt = 0.00
lnFila = 0
lnColumna = 0
i = 0
lnColRef = 0
llOK = .F.

SELECT artnoenc
ZAP

IF Thisform.Contenido.sel_proveedor.valcpoid = 0 THEN	
	MESSAGEBOX("No ha seleccionado ningún proveedor", 0+48, Thisform.Caption)
	Thisform.Contenido.sel_proveedor.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

IF ALLTRIM(Thisform.Contenido.txtFileName.Value) == "" THEN
	MESSAGEBOX("No se puede procesar porque no está cargada la ruta de acceso de la planilla, resuelva el problema desde Sistemas / Configurar Excels", 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT hojas
IF RECCOUNT("hojas") = 0 THEN
	MESSAGEBOX("No hay hojas para configurada para esta planilla, resuelva el problema desde Sistemas / Configurar Excels", 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT tablas
IF RECCOUNT("tablas") = 0 THEN
	MESSAGEBOX("No hay tablas configuradas para este proveedor, resuelva el problema desde Sistemas / Configurar Excels", 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT columnas
IF RECCOUNT("columnas") = 0 THEN
	MESSAGEBOX("No hay colummas configuradas para este proveedor, resuelva el problema desde Sistemas / Configurar Excels", 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

loExcel = CREATEOBJECT("Excel.Application")
loExcel.Visible = .F.

loExcel.WorkBooks.Open(ALLTRIM(Thisform.Contenido.txtFileName.Value))

&& Tengo que comenzar recorriendo las hojas que tienen configuradas
SELECT hojas
GO TOP
DO WHILE !EOF("hojas")
	FOR i = 1 TO loExcel.Sheets.Count
		IF ALLTRIM(loExcel.Sheets[i].Name) == ALLTRIM(hojas.nombre) THEN
			loExcel.Sheets[i].Select()
			loSheet = loExcel.ActiveSheet()
			
			SELECT tablas
			SET FILTER TO tablas.idHoja = hojas.idHoja
			GO TOP
			DO WHILE !EOF("tablas")
				IF tablas.nFilaHH <> 0 THEN
					&& Cuando nFilaHH no es cero significa que hay que respetar el límite de la tabla
					&& según se configuró.
					
					FOR lnFila = tablas.nFilaDD TO tablas.nFilaHH
						llOK = .T.
					
						SELECT columnas
						SET FILTER TO columnas.idTabla = tablas.idTabla
						GO TOP
						
						DO WHILE !EOF("columnas")
							IF UPPER(ALLTRIM(columnas.fieldName)) == "CODARTPV" .OR. UPPER(ALLTRIM(columnas.fieldName)) == "CODART" THEN
								IF TYPE("loSheet.Cells(lnFila, columnas.nroColRef).Value") == "C" THEN
									m.codArtPV = ALLTRIM(loSheet.Cells(lnFila, columnas.nroColRef).Value)
								ELSE
									IF !ISNULL(loSheet.Cells(lnFila, columnas.nroColRef).Value) THEN
										m.codArtPV = ALLTRIM(STR(loSheet.Cells(lnFila, columnas.nroColRef).Value))
									ELSE
										m.codArtPV = ""
									ENDIF
								ENDIF
																
								lcSql = "SELECT * FROM articulos WHERE articulos." + ALLTRIM(columnas.fieldName) + " = '" + ALLTRIM(m.codArtPV) + "' "
								lcSql = lcSql + " AND articulos.idProv = " + ALLTRIM(STR(Thisform.Contenido.sel_proveedor.valcpoid))
								
								loRsArt.ActiveConnection = goConn.ActiveConnection
								loRsArt.Cursor_Name = "cur_tmp"
								
								IF !loRsArt.OpenQuery(lcSql) THEN
									loExcel.WorkBooks.Close()
									loExcel.Quit()
									MESSAGEBOX(loRsArt.Error_Message, 0+48, Thisform.Caption)
									RETURN
								ENDIF
								
								SELECT cur_tmp
								IF RECCOUNT("cur_tmp") = 0 THEN
									&& Pasa por aca en caso de que el artículo no se encuentre cargado
									&& en la base de datos
									llOK = .F.
								ENDIF								
								
								SELECT cur_tmp
								m.idArticulo = cur_tmp.idArticulo
								m.codArt = cur_tmp.codArt
								m.descripcio = cur_tmp.descripcio
								m.alicIVA = cur_tmp.alicIVA
								m.bonif1 = IIF(Thisform.contenido.txtBonif1.Value = 0, cur_tmp.bonif1, Thisform.contenido.txtBonif1.Value)
								m.bonif2 = IIF(Thisform.contenido.txtBonif2.Value = 0, cur_tmp.bonif2, Thisform.contenido.txtBonif2.Value)
								m.bonif3 = IIF(Thisform.contenido.txtBonif3.value = 0, cur_tmp.bonif3, Thisform.contenido.txtBonif3.Value)
								m.bonif4 = IIF(Thisform.contenido.txtBonif4.Value = 0, cur_tmp.bonif4, Thisform.contenido.txtBonif4.Value)
								m.margenMin = IIF(Thisform.contenido.txtMargenMin.Value = 0, cur_tmp.margenMin, Thisform.contenido.txtMargenMin.Value)
								m.margenMay = IIF(Thisform.contenido.txtMargenMay.Value = 0, cur_tmp.margenMax, Thisform.contenido.txtMargenMay.Value)
								m.prListaAnt = cur_tmp.prLista
								
								loRsArt.Close_Query()
							ELSE
								IF ALLTRIM(columnas.dataType) == "N" THEN
									IF ISNULL(loSheet.Cells(lnFila, columnas.nroColRef).value) THEN
										m.precio = 0
									ELSE
										m.precio = loSheet.Cells(lnFila, columnas.nroColRef).value
									ENDIF
								ENDIF
							ENDIF
							
							SELECT columnas
							SKIP
						ENDDO
						
						IF !llOK THEN
							&& Si está marcado que el artículo no fué encontrado entonces lo
							&& carga en el cursor "artículos no encontrado".
							IF !(ALLTRIM(m.codArtPV) == "") THEN
								SELECT artnoenc
								APPEND BLANK
								REPLACE artnoenc.codArt WITH "" 
								REPLACE artnoenc.codArtPV WITH ALLTRIM(m.codArtPV) ADDITIVE
								REPLACE artnoenc.descripcio WITH "[COMPLETAR DESCRIPCION]" ADDITIVE
								REPLACE artnoenc.prListaPV WITH IIF(!(TYPE("m.precio") == "N"), 0, m.precio) ADDITIVE
								REPLACE artnoenc.bonif_1 WITH 0 ADDITIVE
								REPLACE artnoenc.bonif_2 WITH 0 ADDITIVE
								REPLACE artnoenc.bonif_3 WITH 0 ADDITIVE
								REPLACE artnoenc.margen_may WITH 0 ADDITIVE
								REPLACE artnoenc.margen_min WITH 0 ADDITIVE
								REPLACE artnoenc.alicIVA WITH 21 ADDITIVE
								REPLACE artnoenc.familia WITH "VARIOS" ADDITIVE
								REPLACE artnoenc.subFam WITH "VARIOS" ADDITIVE
								REPLACE artnoenc.observac WITH "" ADDITIVE
							ENDIF
						ELSE
							IF !(ALLTRIM(m.codArt) == "") .AND. !(ALLTRIM(m.codArtPV) == "") THEN
								&& Agrego la fila al cursor
								SELECT registros
								APPEND BLANK
								REPLACE registros.idArticulo WITH m.idArticulo
								REPLACE registros.codArt WITH m.codArt ADDITIVE
								REPLACE registros.codArtPV WITH m.codArtPV ADDITIVE
								REPLACE registros.descripcio WITH m.descripcio ADDITIVE
								REPLACE registros.alicIVA WITH m.alicIVA ADDITIVE
								REPLACE registros.bonif1 WITH m.bonif1 ADDITIVE
								REPLACE registros.bonif2 WITH m.bonif2 ADDITIVE
								REPLACE registros.bonif3 WITH m.bonif3 ADDITIVE
								REPLACE registros.bonif4 WITH m.bonif4 ADDITIVE
								REPLACE registros.margenMin WITH m.margenMin ADDITIVE
								REPLACE registros.margenMay WITH m.margenMay ADDITIVE
								REPLACE registros.prListaPV WITH m.precio ADDITIVE
								REPLACE registros.prListaAnt WITH m.prListaAnt ADDITIVE
							ENDIF
						ENDIF
						
						WAIT WINDOW "Procesando registro " + ALLTRIM(STR(lnFila)) NOWAIT
					NEXT lnFila
				ELSE
					&& Cuando nFilaHH es cero, entonces singnifica que hay que detectar
					&& el final del archivo cuando la columna codigo se encuentra en blanco.
					
					lnFila = tablas.nFilaDD
					
					lnColRef = thisform.getnrorefcod()
					IF TYPE("loSheet.Cells(lnFila, lnColRef).Value") == "N" THEN
						m.codArtPV = ALLTRIM(STR(loSheet.Cells(lnFila, lnColRef).Value))
					ELSE
						m.codArtPV = ALLTRIM(loSheet.Cells(lnFila, lnColRef).Value)
					ENDIF
					
					DO WHILE !(ALLTRIM(m.codArtPV) == "")
						llOK = .T.							
					
						SELECT columnas
						SET FILTER TO columnas.idTabla = tablas.idTabla
						GO TOP
						
						DO WHILE !EOF("columnas")
							IF UPPER(ALLTRIM(columnas.fieldName)) == "CODARTPV" .OR. UPPER(ALLTRIM(columnas.fieldName)) == "CODART" THEN
								lcSql = "SELECT * FROM articulos WHERE articulos." + ALLTRIM(columnas.fieldName) + " = '" + ALLTRIM(m.codArtPV) + "' "
								lcSql = lcSql + " AND articulos.idProv = " + ALLTRIM(STR(Thisform.Contenido.sel_proveedor.valcpoid))
								
								loRsArt.ActiveConnection = goConn.ActiveConnection
								loRsArt.Cursor_Name = "cur_tmp"
								
								IF !loRsArt.OpenQuery(lcSql) THEN
									loExcel.WorkBooks.Close()
									loExcel.Quit()								
									MESSAGEBOX(loRsArt.Error_Message, 0+48, Thisform.Caption)
									RETURN
								ENDIF
								
								SELECT cur_tmp
								IF RECCOUNT("cur_tmp") = 0 THEN
									&& Pasa por aca en caso de que el artículo no se encuentre cargado
									&& en la base de datos
									llOK = .F.
								ENDIF								
								
								m.idArticulo = cur_tmp.idArticulo
								m.codArt = cur_tmp.codArt
								m.descripcio = cur_tmp.descripcio
								m.alicIVA = cur_tmp.alicIVA
								m.bonif1 = IIF(Thisform.contenido.txtBonif1.Value = 0, cur_tmp.bonif1, Thisform.contenido.txtBonif1.Value)
								m.bonif2 = IIF(Thisform.contenido.txtBonif2.Value = 0, cur_tmp.bonif2, Thisform.contenido.txtBonif2.Value)
								m.bonif3 = IIF(Thisform.contenido.txtBonif3.value = 0, cur_tmp.bonif3, Thisform.contenido.txtBonif3.Value)
								m.bonif4 = IIF(Thisform.contenido.txtBonif4.Value = 0, cur_tmp.bonif4, Thisform.contenido.txtBonif4.Value)
								m.margenMin = IIF(Thisform.contenido.txtMargenMin.Value = 0, cur_tmp.margenMin, Thisform.contenido.txtMargenMin.Value)
								m.margenMay = IIF(Thisform.contenido.txtMargenMay.Value = 0, cur_tmp.margenMax, Thisform.contenido.txtMargenMay.Value)
								m.prListaAnt = cur_tmp.prLista
								
								loRsArt.Close_Query()
							ELSE
								IF ALLTRIM(columnas.dataType) == "N" THEN
									IF ISNULL(loSheet.Cells(lnFila, columnas.nroColRef).value) THEN
										m.precio = 0
									ELSE
										m.precio = loSheet.Cells(lnFila, columnas.nroColRef).value
									ENDIF
								ENDIF
							ENDIF
						
							SELECT columnas
							SKIP
						ENDDO

						IF !llOK THEN
							&& Si está marcado que el artículo no fué encontrado entonces lo
							&& carga en el cursor "artículos no encontrado".
							IF !(ALLTRIM(m.codArtPV) == "") THEN
								SELECT artnoenc
								APPEND BLANK
								REPLACE artnoenc.codArt WITH "" 
								REPLACE artnoenc.codArtPV WITH ALLTRIM(m.codArtPV) ADDITIVE
								REPLACE artnoenc.descripcio WITH "[COMPLETAR DESCRIPCION]" ADDITIVE
								REPLACE artnoenc.prListaPV WITH IIF(!(TYPE("m.precio") == "N"), 0, m.precio) ADDITIVE
								REPLACE artnoenc.bonif_1 WITH 0 ADDITIVE
								REPLACE artnoenc.bonif_2 WITH 0 ADDITIVE
								REPLACE artnoenc.bonif_3 WITH 0 ADDITIVE
								REPLACE artnoenc.margen_may WITH 0 ADDITIVE
								REPLACE artnoenc.margen_min WITH 0 ADDITIVE
								REPLACE artnoenc.alicIVA WITH 21 ADDITIVE
								REPLACE artnoenc.familia WITH "VARIOS" ADDITIVE
								REPLACE artnoenc.subFam WITH "VARIOS" ADDITIVE
								REPLACE artnoenc.observac WITH "" ADDITIVE
							ENDIF
						ELSE
							IF !(ALLTRIM(m.codArt) == "") .AND. !(ALLTRIM(m.codArtPV) == "") THEN
								&& Agrego la fila al cursor
								SELECT registros
								APPEND BLANK
								REPLACE registros.idArticulo WITH m.idArticulo
								REPLACE registros.codArt WITH m.codArt ADDITIVE
								REPLACE registros.codArtPV WITH m.codArtPV ADDITIVE
								REPLACE registros.descripcio WITH m.descripcio ADDITIVE
								REPLACE registros.alicIVA WITH m.alicIVA ADDITIVE
								REPLACE registros.bonif1 WITH m.bonif1 ADDITIVE
								REPLACE registros.bonif2 WITH m.bonif2 ADDITIVE
								REPLACE registros.bonif3 WITH m.bonif3 ADDITIVE
								REPLACE registros.bonif4 WITH m.bonif4 ADDITIVE
								REPLACE registros.margenMin WITH m.margenMin ADDITIVE
								REPLACE registros.margenMay WITH m.margenMay ADDITIVE
								REPLACE registros.prListaPV WITH m.precio ADDITIVE
								REPLACE registros.prListaAnt WITH m.prListaAnt ADDITIVE
							ENDIF
						ENDIF						
						
						WAIT WINDOW "Procesando registro " + ALLTRIM(STR(lnFila)) NOWAIT
						lnFila = lnFila + 1
						
						lnColRef = thisform.getnrorefcod()
						IF TYPE("loSheet.Cells(lnFila, lnColRef).Value") == "N" THEN
							m.codArtPV = ALLTRIM(STR(loSheet.Cells(lnFila, lnColRef).Value))
						ELSE
							m.codArtPV = ALLTRIM(loSheet.Cells(lnFila, lnColRef).Value)
						ENDIF						
					ENDDO
				ENDIF
					
				SELECT tablas
				SKIP
			ENDDO
		ENDIF
	NEXT i

	SELECT hojas
	SKIP
ENDDO

loExcel.WorkBooks.Close()
loExcel.Quit()
RELEASE loExcel

SELECT registros
GO TOP
Thisform.Contenido.grdRegistros.Refresh()
WAIT WINDOW "Lectura finalizada" NOWAIT

RETURN .T.

ENDPROC
PROCEDURE actualizar_articulos
LOCAL loRsArt
LOCAL lcSql
LOCAL loCommand
LOCAL loTherm
LOCAL lnCostoRep
LOCAL lnPrVentaMay
LOCAL lnPrVentaMin
LOCAL lnPrVtaFinalMay
LOCAL lnPrVtaFinalMin
LOCAL lnIdArtCbio
LOCAL lnPorVar
LOCAL lcFileName

loRsArt = CREATEOBJECT("odbc_result")
loCommand = CREATEOBJECT("odbc_command")
loTherm = CREATEOBJECT("_thermometer")
lcSql = ""
lnCostoRep = 0.00
lnPrVentaMay = 0.00
lnPrVentaMin = 0.00
lnPrVtaFinalMay = 0.00
lnPrVtaFinalMin = 0.00
lnIdArtCbio = 0
lnPorVar = 0.00

loTherm.show()

SELECT registros
GO TOP

DO WHILE !EOF("registros")
	lnCostoRep = calcular_costo(registros.prListaPV, registros.bonif1, registros.bonif2, registros.bonif3, registros.bonif4, 0)
	lnPrVentaMay = lnCostoRep + (lnCostoRep * (registros.margenMay / 100))
	lnPrVentaMin = lnCostoRep + (lnCostoRep * (registros.margenMin / 100))
	lnPrVtaFinalMay = lnPrVentaMay + (lnPrVentaMay * (registros.alicIVA / 100))
	lnPrVtaFinalMin = lnPrVentaMin + (lnPrVentaMin * (registros.alicIVA / 100))
	
	IF registros.prListaAnt = 0 THEN
		lnPorVar = 100
	ELSE
		lnPorVar = ((registros.prListaPV - registros.prListaAnt) / registros.prListaAnt)
	ENDIF
	
	IF lnPorVar <> 0 THEN	
		goConn.BeginTransaction()
		
		lcSql = "UPDATE articulos "
		lcSql = lcSql + "SET prLista = " + ALLTRIM(STR(registros.prListaPV, 10, 2)) + ", "
		lcSql = lcSql + "	bonif1 = " + ALLTRIM(STR(registros.bonif1, 10, 2)) + ", "
		lcSql = lcSql + "	bonif2 = " + ALLTRIM(STR(registros.bonif2, 10, 2)) + ", "
		lcSql = lcSql + "	bonif3 = " + ALLTRIM(STR(registros.bonif3, 10, 2)) + ", "
		lcSql = lcSql + "	bonif4 = " + ALLTRIM(STR(registros.bonif4, 10, 2)) + ", "
		lcSql = lcSql + "	costoRep = " + ALLTRIM(STR(lnCostoRep, 10, 2)) + ", "
		lcSql = lcSql + "	margenMax = " + ALLTRIM(STR(registros.margenMay, 10, 2)) + ", "
		lcSql = lcSql + "	margenMin = " + ALLTRIM(STR(registros.margenMin, 10, 2)) + ", "
		lcSql = lcSql + "	prventaMax = " + ALLTRIM(STR(lnPrVentaMay, 10, 2)) + ", "
		lcSql = lcSql + "	prventaMin = " + ALLTRIM(STR(lnPrVentaMin, 10, 2)) + ", "
		lcSql = lcSql + "	prfinalMax = " + ALLTRIM(STR(lnPrVtaFinalMay, 10, 2)) + ", "
		lcSql = lcSql + "	prfinalMin = " + ALLTRIM(STR(lnPrVtaFinalMin, 10, 2)) + ", "
		lcSql = lcSql + "	usuModi = '" + ALLTRIM(gcCodUsu) + "', "
		lcSql = lcSql + "	fecModi = current_timestamp, "
		lcSql = lcSql + "	idHostModi = '" + ALLTRIM(SYS(0)) + "' "
		lcSql = lcSql + "WHERE idArticulo = " + ALLTRIM(STR(registros.idArticulo))
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.execute() THEN
			goConn.Rollback()
			MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
			RETURN .F.
		ENDIF
			
		lnIdArtCbio = goConn.GetNextID("art_cbios", "idArtCbios")
		
		lcSql = "INSERT INTO art_cbios ( "
		lcSql = lcSql + "idArtCbios, idArticulo, fecha, prAnt, prNuevo, porVar) "
		lcSql = lcSql + "VALUES (" + ALLTRIM(STR(lnIdArtCbio)) + ", "
		lcSql = lcSql + ALLTRIM(STR(registros.idArticulo)) + ", "
		lcSql = lcSql + "current_timestamp, "
		lcSql = lcSql + ALLTRIM(STR(registros.prListaAnt, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(registros.prListaPV, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnPorVar, 10, 2)) + ")"
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
			RETURN .F.
		ENDIF
	ENDIF
	
	goConn.Commit()
		
	loTherm.update((RECNO("registros") * 100) / RECCOUNT("registros"), "Actualizando precios...")
	SELECT registros
	SKIP
ENDDO

loTherm.Complete()

RETURN .T.
ENDPROC
PROCEDURE blanquear
SELECT hojas
ZAP
SELECT tablas
ZAP
SELECT columnas
ZAP
SELECT registros
ZAP
SELECT artnoenc
ZAP

Thisform.Contenido.sel_proveedor.blanquear()
Thisform.Contenido.txtBonif1.blanquear()
Thisform.Contenido.txtBonif2.blanquear()
Thisform.Contenido.txtBonif3.blanquear()
Thisform.Contenido.txtBonif4.blanquear()
Thisform.Contenido.txtMargenMay.blanquear()
Thisform.Contenido.txtMargenMin.blanquear()

Thisform.Contenido.sel_proveedor.txtCodigo.SetFocus()

thisform.contenido.btnGrabar.Enabled = .F.
thisform.contenido.btnAceptar.Enabled = .T.
ENDPROC
PROCEDURE getnrorefcod
SELECT columnas
GO TOP

DO WHILE !EOF("columnas")
	IF UPPER(ALLTRIM(columnas.fieldName)) == "CODARTPV" .OR. UPPER(ALLTRIM(columnas.fieldName)) == "CODART" THEN
		RETURN columnas.nroColRef
	ENDIF

	SELECT columnas
	SKIP
ENDDO

SELECT columnas
GO TOP

RETURN -1
ENDPROC
PROCEDURE Init
SELECT registros
Thisform.Contenido.grdRegistros.alias_name = "registros"
Thisform.Contenido.grdRegistros.RecordSource = "registros"
Thisform.Contenido.grdRegistros.list_controlsource = "codArt,codArtPV,descripcio,prListaPV,bonif1,bonif2,bonif3,bonif4,margenMay,margenMin"
Thisform.Contenido.grdRegistros.lista_ancho_cols = "100,100,250,70,70,70,70,70,70,70"
Thisform.Contenido.grdRegistros.titulos_cabeceras = "Código,Código Prov.,Descripción,Precio Lista,Bonif.1,Bonif.2,Bonif.3,Bonif.4,Margen May.,Margen Min."
Thisform.Contenido.grdRegistros.generar_grid()

thisform.contenido.btnGrabar.Enabled = .F.
thisform.contenido.btnAceptar.Enabled = .T.
ENDPROC
PROCEDURE Load
DODEFAULT()


CREATE CURSOR hojas (	;
	idHoja		int,;
	idPlanilla	int,;
	nombre		varchar(100))
	
CREATE CURSOR tablas (	;
	idTabla		int,;
	idHoja		int,;
	idPlanilla	int,;
	tableName	varchar(15),;
	nFilaDD		int,;
	nFilaHH		int)
	
CREATE CURSOR columnas (	;
	idColumna	int,;
	idTabla		int,;
	fieldName	varchar(15),;
	dataType	varchar(1),;
	nroColRef	int)
	
CREATE CURSOR registros (	;
	idArticulo	int,;
	codArt		varchar(20),;
	codArtPV	varchar(20),;
	descripcio	varchar(100),;
	alicIVA		float(10,2),;
	bonif1		float(10,2),;
	bonif2		float(10,2),;
	bonif3		float(10,2),;
	bonif4		float(10,2),;
	margenMin	float(10,2),;
	margenMay	float(10,2),;
	prListaAnt	float(10,2),;
	prListaPV	float(10,2))

CREATE CURSOR artnoenc (	;
	codArt		varchar(20),;
	codArtPV	varchar(20),;
	descripcio	varchar(254),;
	marca		varchar(60),;
	prListaPV	float(10,2),;
	bonif_1		float(10, 2),;
	bonif_2		float(10, 2),;
	bonif_3		float(10, 2),;
	margen_may	float(10, 2),;
	margen_min	float(10, 2),;
	alicIVA		float(10, 2),;
	familia		varchar(30),;
	subFam		varchar(30),;
	observac	varchar(254))
ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Proveedor:"
Height = 15
Left = 13
Top = 15
Width = 71
TabIndex = 14
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: sel_proveedor
************************************************************
*** PROPIEDADES ***
Top = 8
Left = 83
Width = 487
Height = 25
TabIndex = 1
nombre_campo_codigo = idProv
esnumerico = .T.
nombre_campo_desc = razSoc
nombre_tabla = proveedor
pkfield = idProv
alternative_cols = nomFant
anchos_cols = 200,200
title_cols = Descripción,Nombre de Fantasía
Name = "sel_proveedor"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***
PROCEDURE recuperar_datos
&& En este método al seleccionar el proveedor recupero la configuración de la planilla que tenga
&& asociada el proveedor
LOCAL loRes, lcSql
LOCAL loResCol

loRes = CREATEOBJECT("odbc_result")
loResCol = CREATEOBJECT("odbc_result")
lcSql = ""

lcSql = "SELECT * FROM planillas WHERE idProv = " + ALLTRIM(STR(This.valcpoid))
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_tempo"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN
ENDIF

SELECT cur_tempo
GO TOP
IF RECCOUNT("cur_tempo") > 0 THEN
	Thisform.idPlanilla = cur_tempo.idPlanilla
	Thisform.contenido.txtFileName.Value = ALLTRIM(cur_tempo.ruta)
ELSE
	Thisform.idPlanilla = 0
	MESSAGEBOX("No hay planillas configuradas para este proveedor", 0+64, Thisform.Caption)
	RETURN
ENDIF

loRes.Close_Query()

&& Recupero las hojas que tiene la planilla
lcSql = "SELECT * FROM hojas WHERE idPlanilla = " + ALLTRIM(STR(Thisform.idPlanilla))
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_tempo"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN
ENDIF

SELECT cur_tempo
GO TOP

DO WHILE !EOF("cur_tempo")
	SELECT hojas
	APPEND BLANK
	REPLACE hojas.idHoja WITH cur_tempo.idHoja
	REPLACE hojas.idPlanilla WITH cur_tempo.idPlanilla ADDITIVE
	REPLACE hojas.nombre WITH cur_tempo.nombre ADDITIVE

	SELECT cur_tempo
	SKIP
ENDDO

loRes.Close_Query()

lcSql = "SELECT * FROM tablas WHERE idPlanilla = " + ALLTRIM(STR(Thisform.idPlanilla))
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_tempo"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN
ENDIF

SELECT cur_tempo
GO TOP

DO WHILE !EOF("cur_tempo")
	SELECT tablas
	APPEND BLANK
	REPLACE tablas.idTabla WITH cur_tempo.idTabla
	REPLACE tablas.idHoja WITH cur_tempo.idHoja ADDITIVE
	REPLACE tablas.idPlanilla WITH cur_tempo.idPlanilla ADDITIVE
	REPLACE tablas.tableName WITH ALLTRIM(cur_tempo.tableName) ADDITIVE
	REPLACE tablas.nFilaDD WITH cur_tempo.nFilaDD ADDITIVE
	REPLACE tablas.nFilaHH WITH cur_tempo.nFilaHH ADDITIVE
	
	lcSql = "SELECT * FROM columnas WHERE idTabla = " + ALLTRIM(STR(tablas.idTabla))
	loResCol.ActiveConnection = goConn.ActiveConnection
	loResCol.Cursor_Name = "cur_col"
	
	IF !loResCol.OpenQuery(lcSql) THEN
		MESSAGEBOX(loResCol.Error_Message, 0+48, Thisform.Caption)
		RETURN
	ENDIF
	
	SELECT cur_col
	GO TOP
	DO WHILE !EOF("cur_col")
		SELECT columnas
		APPEND BLANK
		REPLACE columnas.idColumna WITH cur_col.idColumna
		REPLACE columnas.idTabla WITH cur_col.idTabla ADDITIVE
		REPLACE columnas.fieldName WITH cur_col.fieldName ADDITIVE
		REPLACE columnas.dataType WITH cur_col.dataType ADDITIVE
		REPLACE columnas.nroColRef WITH cur_col.nroColRef ADDITIVE
	
		SELECT cur_col
		SKIP
	ENDDO
	
	loResCol.Close_Query()

	SELECT cur_tempo
	SKIP
ENDDO

loRes.Close_Query()

SELECT hojas
GO TOP
SELECT tablas
GO TOP

ENDPROC


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Archivo:"
Height = 15
Left = 13
Top = 37
Width = 60
TabIndex = 15
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: txtFileName
************************************************************
*** PROPIEDADES ***
Enabled = .T.
Height = 21
Left = 85
ReadOnly = .T.
TabIndex = 2
Top = 35
Width = 824
Name = "txtFileName"

*** METODOS ***


************************************************************
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 524
Left = 889
TabIndex = 13
Name = "btnCerrar"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Bonificaciónes:"
Height = 15
Left = 13
Top = 67
Width = 86
TabIndex = 16
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: txtBonif1
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 100
TabIndex = 4
Top = 64
Width = 69
isnumeric = .T.
Name = "txtBonif1"

*** METODOS ***


************************************************************
OBJETO: txtBonif2
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 172
TabIndex = 5
Top = 64
Width = 69
isnumeric = .T.
Name = "txtBonif2"

*** METODOS ***


************************************************************
OBJETO: txtBonif3
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 244
TabIndex = 6
Top = 64
Width = 69
isnumeric = .T.
Name = "txtBonif3"

*** METODOS ***


************************************************************
OBJETO: txtBonif4
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 316
TabIndex = 7
Top = 64
Width = 69
isnumeric = .T.
Name = "txtBonif4"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Margen Mayorísta:"
Height = 15
Left = 13
Top = 90
Width = 107
TabIndex = 17
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: txtMargenMay
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 122
TabIndex = 8
Top = 87
Width = 69
isnumeric = .T.
Name = "txtMargenMay"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Margen Minorista:"
Height = 15
Left = 207
Top = 90
Width = 107
TabIndex = 18
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: txtMargenMin
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 316
TabIndex = 9
Top = 87
Width = 69
isnumeric = .T.
Name = "txtMargenMin"

*** METODOS ***


************************************************************
OBJETO: grdRegistros
************************************************************
*** PROPIEDADES ***
Height = 394
Left = 13
TabIndex = 19
Top = 121
Width = 927
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdRegistros"
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
OBJETO: btnAceptar
************************************************************
*** PROPIEDADES ***
Top = 64
Left = 393
TabIndex = 10
Name = "btnAceptar"

*** METODOS ***
PROCEDURE Click
LOCAL m.proveedor
LOCAL lnResp

lnResp = 0

thisform.xls_analizer()

m.proveedor = ALLTRIM(STR(Thisform.contenido.sel_proveedor.txtCodigo.Value)) + ;
	" - " + ALLTRIM(Thisform.contenido.sel_proveedor.txtDescripcion.Value)

SELECT artnoenc
IF RECCOUNT("artnoenc") <> 0 THEN
	lnResp = MESSAGEBOX("Se han detectado " + ALLTRIM(STR(RECCOUNT("artnoenc"))) + " artículos nuevos. " + ;
		"A continuación elija la ubicación para guardar la planilla en Excel.", 4+32, Thisform.Caption)
	
	IF lnResp = 6 THEN
		lcFileName = PUTFILE("Guardar planilla", ;
			"ArtAlta_Prov_" + ALLTRIM(STR(Thisform.contenido.sel_proveedor.txtCodigo.Value)) + ".xls",;
			"xls;xlsx")
			
		IF !(ALLTRIM(lcFileName) == "") THEN
			SELECT artnoenc
			EXPORT TO ALLTRIM(lcFileName) TYPE XLS
			MESSAGEBOX("El excel se ha generado correctamente!", 0+64, Thisform.Caption)
		ENDIF
	ENDIF
ENDIF

thisform.contenido.btnGrabar.Enabled = .T.
thisform.contenido.btnAceptar.Enabled = .F.

ENDPROC


************************************************************
OBJETO: btnGrabar
************************************************************
*** PROPIEDADES ***
Top = 524
Left = 409
TabIndex = 11
Name = "btnGrabar"

*** METODOS ***
PROCEDURE Click
IF Thisform.actualizar_articulos() THEN
	Thisform.blanquear()
	MESSAGEBOX("Los precios fueron actualizados correctamente", 0+64, Thisform.Caption)
ENDIF
ENDPROC


************************************************************
OBJETO: btnCancelar
************************************************************
*** PROPIEDADES ***
Top = 524
Left = 457
TabIndex = 12
Name = "btnCancelar"

*** METODOS ***
PROCEDURE Click
Thisform.blanquear()
ENDPROC


************************************************************
OBJETO: btnAbrirArchivo
************************************************************
*** PROPIEDADES ***
Top = 34
Left = 910
Height = 23
Width = 30
Caption = "..."
TabIndex = 3
Name = "btnAbrirArchivo"

*** METODOS ***
PROCEDURE Click
LOCAL lcFileName

lcFileName = GETFILE("xls;xlsx", "Abrir planilla Excel")

IF ALLTRIM(lcFileName) == "" THEN
	RETURN
ENDIF

Thisform.Contenido.txtFileName.Value = ALLTRIM(lcFileName)
ENDPROC


************************************************************
OBJETO: cls_xls_updater
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_articulos_baja
************************************************************
*** PROPIEDADES ***
DataSession = 1
BorderStyle = 1
Height = 454
Width = 770
DoCreate = .T.
Caption = "Artículos no encontrados en la planilla"
Name = "cls_articulos_baja"

*** METODOS ***
PROCEDURE deshabilitar_articulos
LOCAL loCmd
LOCAL lcSql
LOCAL loTherm

loCmd = CREATEOBJECT("odbc_command")
lcSql = ""
loTherm = CREATEOBJECT("_thermometer")

SELECT * FROM cur_artbaja WHERE sel = .T. INTO CURSOR cur_x
IF RECCOUNT("cur_x") = 0 THEN
	MESSAGEBOX("No ha seleccionado ningún artículo", 0+64, Thisform.Caption)
	USE IN cur_x
ELSE
	loTherm.show()
	SELECT cur_artbaja
	DO WHILE !EOF("cur_artbaja")
		IF cur_artbaja.sel THEN
			lcSql = "UPDATE articulos "
			lcSql = lcSql + "SET articulos.habilitado = 0 "
			lcSql = lcSql + "WHERE articulos.idArticulo = " + ALLTRIM(STR(cur_artbaja.idArticulo))
			
			loCmd.ActiveConnection = goConn.ActiveConnection
			loCmd.CommandText = lcSql
			IF !loCmd.Execute() THEN
				MESSAGEBOX(loCmd.ErrorMessage, 0+48, Thisform.Caption)
				RETURN .F.
			ENDIF
		ENDIF
		
		loTherm.update((RECNO("cur_artbaja") * 100) / RECCOUNT("cur_artbaja"), "Actualizando precios...")
		SELECT cur_artbaja
		SKIP
	ENDDO
	
	loTherm.Complete()
	USE IN cur_x
	MESSAGEBOX("Los artículos seleccionados ueron deshabilitados satisfactoriamente", 0+64, Thisform.Caption)
ENDIF
ENDPROC
PROCEDURE Init
SELECT cur_artbaja
Thisform.grdArticulos.Alias_Name = "cur_artbaja"
Thisform.grdArticulos.RecordSource = "cur_artbaja"
Thisform.grdArticulos.list_controlsource = "sel,codArt,codArtPV,descripcio"
Thisform.grdArticulos.lista_ancho_cols = "70,150,150,250"
Thisform.grdArticulos.titulos_cabeceras = "Sel.,Código,Código Alt.,Descripción"
Thisform.grdArticulos.Generar_Grid()
ENDPROC


************************************************************
OBJETO: grdArticulos
************************************************************
*** PROPIEDADES ***
Height = 343
Left = 3
Top = 52
Width = 764
Name = "grdArticulos"
COLUMN1.Header1.Name = "Header1"
COLUMN1.Text1.ReadOnly = .F.
COLUMN1.Text1.Name = "Text1"
COLUMN1.CurrentControl = "CLSCHECKBOX1"
COLUMN1.ReadOnly = .F.
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
OBJETO: CLSCHECKBOX1
************************************************************
*** PROPIEDADES ***
Top = 35
Left = 46
Alignment = 0
Caption = ""
ReadOnly = .F.
Name = "CLSCHECKBOX1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Los siguientes códigos no se encontraron en la planilla. Marque aquellos artículos que desea deshabilitar"
Height = 12
Left = 12
Top = 12
Width = 744
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: btnAceptar
************************************************************
*** PROPIEDADES ***
Top = 403
Left = 669
Name = "btnAceptar"

*** METODOS ***
PROCEDURE Click
LOCAL lnResp

lnResp = MESSAGEBOX("¿Está seguro que desea deshabilitar los artículos seleccionados?", 4+32, Thisform.Caption)
IF lnResp = 6 THEN
	=thisform.deshabilitar_articulos()
	=Thisform.Release()
ENDIF
ENDPROC


************************************************************
OBJETO: btnCancelar
************************************************************
*** PROPIEDADES ***
Top = 403
Left = 717
Name = "btnCancelar"

*** METODOS ***
PROCEDURE Click
Thisform.Release()
ENDPROC


************************************************************
OBJETO: chkMarcarTodos
************************************************************
*** PROPIEDADES ***
Top = 33
Left = 12
Alignment = 0
Caption = "Marcar / Desmarcar todos"
Name = "chkMarcarTodos"

*** METODOS ***
PROCEDURE Click
IF This.Value = 1 THEN
	SELECT cur_artbaja
	GO TOP
	DO WHILE !EOF("cur_artbaja")
		SELECT cur_artbaja
		=LOCK()
		REPLACE cur_artbaja.sel WITH .T.
		UNLOCK
	
		SELECT cur_artbaja
		SKIP
	ENDDO
	SELECT cur_artbaja
	GO TOP
	Thisform.grdArticulos.Refresh()
ELSE
	SELECT cur_artbaja
	GO TOP
	DO WHILE !EOF("cur_artbaja")
		SELECT cur_artbaja
		=LOCK()
		REPLACE cur_artbaja.sel WITH .F.
		UNLOCK
	
		SELECT cur_artbaja
		SKIP
	ENDDO
	SELECT cur_artbaja
	GO TOP
	Thisform.grdArticulos.Refresh()
ENDIF
ENDPROC


************************************************************
OBJETO: cls_articulos_baja
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: actu_precios
************************************************************
*** PROPIEDADES ***
idprov_dd = 0
idprov_hh = 0
idfamilia_dd = 0
idfamilia_hh = 0
idsubfam_dd = 0
idsubfam_hh = 0
idmarca_dd = 0
idmarca_hh = 0
errormessage = 
codart_dd = 0
codart_hh = 0
Name = "actu_precios"

*** METODOS ***
PROCEDURE crear_cursor
******************************************************
* Creo el cursor que contiene los artículos a modificar
******************************************************

CREATE CURSOR cur_artic (	;
	selected	L,;
	idArticulo	int,;
	codArt		varchar(20),;
	descripcio	varchar(60),;
	alicIVA		float(10,2),;
	prLista		float(10,2),;
	bonif1		float(10,2),;
	bonif2		float(10,2),;
	bonif3		float(10,2),;
	bonif4		float(10,2),;
	costoRep	float(10,2),;
	margenMax	float(10,2),;
	margenMin	float(10,2),;
	prVentaMax	float(10,2),;
	prVentaMin	float(10,2),;
	prFinalMax	float(10,2),;
	prFinalMin	float(10,2))

ENDPROC
PROCEDURE grabar
***********************************************************
* Este método permite realizar la modificación sobre
* la base de datos.
***********************************************************
LOCAL loCommand, lcSql, loProg
LOCAL lnCont

loCommand = CREATEOBJECT("odbc_command")
loProg = CREATEOBJECT("_thermometer")
lcSql = ""
lnCont = 0

loProg.show()
goConn.BeginTransaction()

SELECT cur_artic
IF RECCOUNT("cur_artic") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_artic")
	IF cur_artic.selected THEN
		lcSql = "UPDATE articulos "
		lcSql = lcSql + "SET prLista = " + ALLTRIM(STR(cur_artic.prLista, 10, 2)) + ", "
		lcSql = lcSql + "	bonif1 = " + ALLTRIM(STR(cur_artic.bonif1, 10, 2)) + ", "
		lcSql = lcSql + "	bonif2 = " + ALLTRIM(STR(cur_artic.bonif2, 10, 2)) + ", "
		lcSql = lcSql + "	bonif3 = " + ALLTRIM(STR(cur_artic.bonif3, 10, 2)) + ", "
		lcSql = lcSql + "	bonif4 = " + ALLTRIM(STR(cur_artic.bonif4, 10, 2)) + ", "
		lcSql = lcSql + "	costoRep = " + ALLTRIM(STR(cur_artic.costoRep, 10, 2)) + ", "
		lcSql = lcSql + "	margenMax = " + ALLTRIM(STR(cur_artic.margenMax, 10, 2)) + ", "
		lcSql = lcSql + "	margenMin = " + ALLTRIM(STR(cur_artic.margenMin, 10, 2)) + ", "
		lcSql = lcSql + "	prVentaMax = " + ALLTRIM(STR(cur_artic.prVentaMax, 10, 2)) + ", "
		lcSql = lcSql + "	prVentaMin = " + ALLTRIM(STR(cur_artic.prVentaMin, 10, 2)) + ", "
		lcSql = lcSql + "	prFinalMax = " + ALLTRIM(STR(cur_artic.prFinalMax, 10, 2)) + ", "
		lcSql = lcSql + "	prFinalMin = " + ALLTRIM(STR(cur_artic.prFinalMin, 10, 2)) + ", "
		lcSql = lcSql + "	usuModi = '" + ALLTRIM(gcCodUsu) + "', "
		lcSql = lcSql + "	fecModi = current_timestamp, "
		lcSql = lcSql + "	idHostModi = '" + ALLTRIM(SYS(0)) + "' "
		lcSql = lcSql + "WHERE idArticulo = " + ALLTRIM(STR(cur_artic.idArticulo))
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			this.ErrorMessage = loCommand.ErrorMessage
			RETURN .F.
		ENDIF
	ENDIF
	
	lnCont = lnCont + 1
	loProg.Update((lnCont * 100) / RECCOUNT("cur_artic"), "Actualizando precios...")
	
	SELECT cur_artic
	SKIP
ENDDO

loProg.Complete()

goConn.Commit()

RETURN .T.
ENDPROC
PROCEDURE open
LOCAL loResult, lcSql
LOCAL lnIdMarcaDD, lnIdMarcaHH, lnIdFamiliaDD, lnIdFamiliaHH
LOCAL lnIdSubFamDD, lnIdSubFamHH, lnIdProvDD, lnIdProvHH
LOCAL lcCodArtDD, lcCodArtHH

IF this.idfamilia_dd = 0 THEN
	this.idfamilia_dd = 0
	this.idfamilia_hh = 999999
ENDIF

IF this.idmarca_dd = 0 THEN
	this.idmarca_dd = 0
	this.idmarca_hh = 999999
ENDIF

IF this.idprov_dd = 0 THEN
	this.idprov_dd = 0
	this.idprov_hh = 999999
ENDIF

IF this.idsubfam_dd = 0 THEN
	this.idsubfam_dd = 0
	this.idsubfam_hh = 999999
ENDIF

IF ALLTRIM(this.codart_dd) == "" THEN
	this.codart_dd = ""
	this.codart_hh = ""
ENDIF

lnIdMarcaDD = this.idmarca_dd
lnIdMarcaHH = this.idmarca_hh
lnIdFamiliaDD = this.idfamilia_dd
lnIdFamiliaHH = this.idfamilia_hh
lnIdSubFamDD = this.idsubfam_dd
lnIdSubFamHH = this.idsubfam_hh
lnIdProvDD = this.idprov_dd
lnIdProvHH = this.idprov_hh
lcCodArtDD = this.codart_dd
lcCodArtHH = this.codart_hh
loResult = CREATEOBJECT("odbc_result")

lcSql = "SELECT	 idArticulo, "
lcSql = lcSql + "codArt, "
lcSql = lcSql + "descripcio, "
lcSql = lcSql + "alicIVA, "
lcSql = lcSql + "prLista, "
lcSql = lcSql + "bonif1, "
lcSql = lcSql + "bonif2, "
lcSql = lcSql + "bonif3, "
lcSql = lcSql + "bonif4, "
lcSql = lcSql + "costoRep, "
lcSql = lcSql + "margenMax, "
lcSql = lcSql + "margenMin, "
lcSql = lcSql + "prVentaMax, "
lcSql = lcSql + "prVentaMin, "
lcSql = lcSql + "prFinalMax, "
lcSql = lcSql + "prFinalMin "
lcSql = lcSql + "FROM articulos "
lcSql = lcSql + "WHERE articulos.fecBaja IS NULL "
lcSql = lcSql + " 	AND (idProv BETWEEN " + ALLTRIM(STR(lnIdProvDD)) + " AND " + ALLTRIM(STR(lnIdProvHH)) + ") "
lcSql = lcSql + "	AND (idFamilia BETWEEN " + ALLTRIM(STR(lnIdFamiliaDD)) + " AND " + ALLTRIM(STR(lnIdFamiliaHH)) + ") "
lcSql = lcSql + "	AND (idSubFam BETWEEN " + ALLTRIM(STR(lnIdSubFamDD)) + " AND " + ALLTRIM(STR(lnIdSubFamHH)) + ") "
lcSql = lcSql + "	AND (idMarca BETWEEN " + ALLTRIM(STR(lnIdMarcaDD)) + " AND " + ALLTRIM(STR(lnIdMarcaHH)) + ") "

IF !(ALLTRIM(this.codart_dd) == "") .AND. !(ALLTRIM(this.codart_hh)) == "" THEN
	lcSql = lcSql + "	AND (codArt BETWEEN '" + ALLTRIM(this.codart_dd) + "' AND '" + ALLTRIM(this.codart_hh) + "') "
ENDIF

lcSql = lcSql + "ORDER BY articulos.codArt ASC"

loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_tmp"

IF !loResult.OpenQuery(lcSql) THEN
	this.ErrorMessage = loResult.Error_Message
	RETURN .F.
ENDIF

SELECT cur_artic
ZAP

SELECT cur_tmp
DO WHILE !EOF("cur_tmp")
	SELECT cur_artic
	APPEND BLANK
	REPLACE selected WITH .F.
	REPLACE idArticulo WITH cur_tmp.idArticulo ADDITIVE
	REPLACE codArt WITH cur_tmp.codArt ADDITIVE
	REPLACE descripcio WITH cur_tmp.descripcio ADDITIVE
	REPLACE alicIVA WITH cur_tmp.alicIVA ADDITIVE	
	REPLACE prLista WITH cur_tmp.prLista ADDITIVE
	REPLACE bonif1 WITH cur_tmp.bonif1 ADDITIVE
	REPLACE bonif2 WITH cur_tmp.bonif2 ADDITIVE
	REPLACE bonif3 WITH cur_tmp.bonif3 ADDITIVE
	REPLACE bonif4 WITH cur_tmp.bonif4 ADDITIVE
	REPLACE costoRep WITH cur_tmp.costoRep ADDITIVE
	REPLACE margenMax WITH cur_tmp.margenMax ADDITIVE
	REPLACE margenMin WITH cur_tmp.margenMin ADDITIVE
	REPLACE prVentaMax WITH cur_tmp.prVentaMax ADDITIVE
	REPLACE prVentaMin WITH cur_tmp.prVentaMin ADDITIVE
	REPLACE prFinalMax WITH cur_tmp.prFinalMax ADDITIVE
	REPLACE prFinalMin WITH cur_tmp.prFinalMin ADDITIVE

	SELECT cur_tmp
	SKIP
ENDDO

loResult.Close_Query()

SELECT cur_artic
IF RECCOUNT("cur_artic") > 0 THEN
	GO TOP
ENDIF

RETURN .T.
ENDPROC
PROCEDURE cambiar_precio
LOCAL lnCostoRep, lnPrVentaMax, lnPrVentaMin, lnFinalMax, lnFinalMin

lnCostoRep = 0.00
lnPrVentaMax = 0.00
lnPrVentaMin = 0.00
lnFinalMax = 0.00
lnFinalMin = 0.00

lnCostoRep = calcular_costo(cur_artic.prLista, cur_artic.bonif1, cur_artic.bonif2, cur_artic.bonif3, cur_artic.bonif4, 0)
lnPrVentaMax = lnCostoRep + (lnCostoRep * (cur_artic.margenMax / 100))
lnPrVentaMin = lnCostoRep + (lnCostoRep * (cur_artic.margenMin / 100))
lnFinalMax = lnPrVentaMax + (lnPrVentaMax * (cur_artic.alicIVA /100))
lnFinalMin = lnPrVentaMin + (lnPrVentaMin * (cur_artic.alicIVA / 100))

SELECT cur_artic
LOCK()
REPLACE cur_artic.costoRep WITH lnCostoRep
REPLACE cur_artic.prVentaMax WITH lnPrVentaMax ADDITIVE
REPLACE cur_artic.prVentaMin WITH lnPrVentaMin ADDITIVE
REPLACE cur_artic.prFinalMax WITH lnFinalMax ADDITIVE
REPLACE cur_artic.prFinalMin WITH lnFinalMin ADDITIVE
UNLOCK
ENDPROC
PROCEDURE limpiar
SELECT cur_artic
ZAP
ENDPROC


************************************************************
OBJETO: cls_xls_franse_updater
************************************************************
*** PROPIEDADES ***
DoCreate = .T.
Caption = "Actualizar Franse"
Name = "cls_xls_franse_updater"
contenido.Name = "contenido"

*** METODOS ***


************************************************************
OBJETO: cls_xls_franse_updater
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: papierttei_updater
************************************************************
*** PROPIEDADES ***
Name = "papierttei_updater"

*** METODOS ***
PROCEDURE copiar_planilla_a_cursor
PARAMETERS tcFileName

LOCAL lnFila
LOCAL lcCodigo
LOCAL llEsNuevo

SELECT cur_articulos
ZAP

=this.abrir_planilla(tcFileName)
lnFila = 1
DO WHILE !(ALLTRIM(this.obtener_valor_celda(lnFila, 1)) == "")
	lcCodigo = STRTRAN(ALLTRIM(this.obtener_valor_celda(lnFila, 3)), " ", "")
	IF !ISNULL(lcCodigo) THEN
		llEsNuevo = !this.verificar_articulo(lcCodigo)
		this.obtener_porcentajes()
		INSERT INTO cur_articulos ( ;
			idArticulo, stock, codigo, articulo, linea, rubro, venta, lista, costo,;
			codArt, esNuevo) ;
		VALUES (this.id_articulo_actual, "NADA", ;
			this.obtener_valor_celda(lnFila, 3), this.obtener_valor_celda(lnFila, 4), ;
			"NADA", "NADA", 0, this.obtener_valor_celda(lnFila, 5), ;
			0, lcCodigo, llEsNuevo)			
	ENDIF
	
	WAIT WINDOW ALLTRIM(STR(lnFila)) NOWAIT
	lnFila = lnFila + 1
ENDDO
=this.cerrar_planilla()
SELECT cur_articulos
GO TOP

ENDPROC


************************************************************
OBJETO: tommasi_updater
************************************************************
*** PROPIEDADES ***
Name = "tommasi_updater"

*** METODOS ***
PROCEDURE copiar_planilla_a_cursor
PARAMETERS tcFileName

LOCAL lnFila
LOCAL lcCodigo
LOCAL llEsNuevo

SELECT cur_articulos
ZAP

=this.abrir_planilla(tcFileName)
lnFila = 1
DO WHILE !(ALLTRIM(this.obtener_valor_celda(lnFila, 1)) == "")
	lcCodigo = ALLTRIM(this.obtener_valor_celda(lnFila, 1))
	IF !ISNULL(lcCodigo) THEN
		llEsNuevo = !this.verificar_articulo(lcCodigo)
		this.obtener_porcentajes()
		INSERT INTO cur_articulos ( ;
			idArticulo, stock, codigo, articulo, linea, rubro, venta, lista, costo,;
			codArt, esNuevo) ;
		VALUES (this.id_articulo_actual, "NO DEFINIDO", ;
			this.obtener_valor_celda(lnFila, 1), this.obtener_valor_celda(lnFila, 2), ;
			"NO DEFINIDO", "NO DEFINIDO", 0, this.obtener_valor_celda(lnFila, 3), 0, ;
			lcCodigo, llEsNuevo)			
	ENDIF
	
	WAIT WINDOW ALLTRIM(STR(lnFila)) NOWAIT
	lnFila = lnFila + 1
ENDDO
=this.cerrar_planilla()
SELECT cur_articulos
GO TOP
ENDPROC


************************************************************
OBJETO: oggi_updater
************************************************************
*** PROPIEDADES ***
Name = "oggi_updater"

*** METODOS ***
PROCEDURE copiar_planilla_a_cursor
PARAMETERS tcFileName

LOCAL lnFila
LOCAL lcCodigo
LOCAL llEsNuevo

SELECT cur_articulos
ZAP

=this.abrir_planilla(tcFileName)
lnFila = 2
DO WHILE !(ALLTRIM(this.obtener_valor_celda(lnFila, 1)) == "")
	lcCodigo = STRTRAN(ALLTRIM(this.obtener_valor_celda(lnFila, 1)), " ", "")
	IF !ISNULL(lcCodigo) THEN
		llEsNuevo = !this.verificar_articulo(lcCodigo)
		this.obtener_porcentajes()
		INSERT INTO cur_articulos ( ;
			idArticulo, stock, codigo, articulo, linea, rubro, venta, lista, costo,;
			codArt, esNuevo) ;
		VALUES (this.id_articulo_actual, "NO DEFINIDO", ;
			this.obtener_valor_celda(lnFila, 1), this.obtener_valor_celda(lnFila, 2), ;
			"NO DEFINIDO", "NO DEFINIDO", 0, this.obtener_valor_celda(lnFila, 3), 0, ;
			lcCodigo, llEsNuevo)			
	ENDIF
	
	WAIT WINDOW ALLTRIM(STR(lnFila)) NOWAIT
	lnFila = lnFila + 1
ENDDO
=this.cerrar_planilla()
SELECT cur_articulos
GO TOP
ENDPROC


************************************************************
OBJETO: taranto_updater
************************************************************
*** PROPIEDADES ***
Name = "taranto_updater"

*** METODOS ***
PROCEDURE copiar_planilla_a_cursor
PARAMETERS tcFileName

LOCAL lnFila
LOCAL lcCodigo
LOCAL lcCodAux
LOCAL lcDescripcion
LOCAL llEsNuevo

SELECT cur_articulos
ZAP

=this.abrir_planilla(tcFileName)
lnFila = 2
lcCodAux = this.obtener_valor_celda(lnFila, 1)
lcCodigo = STRTRAN(ALLTRIM(IIF(TYPE("lcCodAux") == "C", lcCodAux, STR(lcCodAux))), " ", "")
DO WHILE !(ALLTRIM(lcCodigo) == "") .AND. !ISNULL(lcCodAux)
	lcDescripcion = this.obtener_valor_celda(lnFila, 2)
	lcDescripcion = IIF (TYPE("lcDescripcion") == "C", ALLTRIM(lcDescripcion), ALLTRIM(STR(lcDescripcion)))
	IF !ISNULL(lcCodigo) THEN
		llEsNuevo = !this.verificar_articulo(lcCodigo)
		this.obtener_porcentajes()
		INSERT INTO cur_articulos ( ;
			idArticulo, stock, codigo, articulo, linea, rubro, venta, lista, costo,;
			codArt, esNuevo) ;
		VALUES (this.id_articulo_actual, "NO DEFINIDO", ;
			lcCodigo, lcDescripcion, "NO DEFINIDO", "NO DEFINIDO", ;
			0, this.obtener_valor_celda(lnFila, 3), 0, lcCodigo, llEsNuevo)			
	ENDIF
	
	WAIT WINDOW ALLTRIM(STR(lnFila)) NOWAIT
	lnFila = lnFila + 1
	lcCodAux = this.obtener_valor_celda(lnFila, 1)
	IF !ISNULL(lcCodAux) THEN
		lcCodigo = STRTRAN(ALLTRIM(IIF(TYPE("lcCodAux") == "C", lcCodAux, STR(lcCodAux))), " ", "")
	ENDIF
ENDDO
=this.cerrar_planilla()
SELECT cur_articulos
GO TOP

ENDPROC


************************************************************
OBJETO: autopiezas_updater
************************************************************
*** PROPIEDADES ***
Name = "autopiezas_updater"

*** METODOS ***
PROCEDURE copiar_planilla_a_cursor
PARAMETERS tcFileName

LOCAL lnFila
LOCAL lcCodigo
LOCAL lcCodAux
LOCAL lcDescripcion
LOCAL llEsNuevo

SELECT cur_articulos
ZAP

=this.abrir_planilla(tcFileName)
lnFila = 2
lcCodAux = this.obtener_valor_celda(lnFila, 1)
lcCodigo = STRTRAN(ALLTRIM(IIF(TYPE("lcCodAux") == "C", lcCodAux, STR(lcCodAux))), " ", "")
DO WHILE !(ALLTRIM(lcCodigo) == "") .AND. !ISNULL(lcCodAux)
	lcDescripcion = this.obtener_valor_celda(lnFila, 2)
	lcDescripcion = IIF (TYPE("lcDescripcion") == "C", ALLTRIM(lcDescripcion), ALLTRIM(STR(lcDescripcion)))
	IF !ISNULL(lcCodigo) THEN
		llEsNuevo = !this.verificar_articulo(lcCodigo)
		this.obtener_porcentajes()
		INSERT INTO cur_articulos ( ;
			idArticulo, stock, codigo, articulo, linea, rubro, venta, lista, costo,;
			codArt, esNuevo) ;
		VALUES (this.id_articulo_actual, "NO DEFINIDO", ;
			lcCodigo, lcDescripcion, "NO DEFINIDO", "NO DEFINIDO", ;
			0, this.obtener_valor_celda(lnFila, 3), 0, lcCodigo, llEsNuevo)			
	ENDIF
	
	WAIT WINDOW ALLTRIM(STR(lnFila)) NOWAIT
	lnFila = lnFila + 1
	lcCodAux = this.obtener_valor_celda(lnFila, 1)
	IF !ISNULL(lcCodAux) THEN
		lcCodigo = STRTRAN(ALLTRIM(IIF(TYPE("lcCodAux") == "C", lcCodAux, STR(lcCodAux))), " ", "")
	ENDIF
ENDDO
=this.cerrar_planilla()
SELECT cur_articulos
GO TOP

ENDPROC


************************************************************
OBJETO: bohnos_updater
************************************************************
*** PROPIEDADES ***
Name = "bohnos_updater"

*** METODOS ***
PROCEDURE copiar_planilla_a_cursor
PARAMETERS tcFileName

LOCAL lnFila
LOCAL lcCodigo
LOCAL lcLinea
LOCAL llEsNuevo
SELECT cur_articulos
ZAP

=this.abrir_planilla(tcFileName)
lnFila = 1
lcCodAux = this.obtener_valor_celda(lnFila, 1)
lcCodigo = STRTRAN(ALLTRIM(IIF(TYPE("lcCodAux") == "C", lcCodAux, STR(lcCodAux))), " ", "")
DO WHILE !(ALLTRIM(lcCodigo) == "") .AND. !ISNULL(lcCodAux)
	IF !ISNULL(lcCodigo) THEN
		llEsNuevo = !this.verificar_articulo(lcCodigo)
		this.obtener_porcentajes()
		lcLinea = IIF(ISNULL(this.obtener_valor_celda(lnFila, 3)), "NO DEFINIDO", ;
			ALLTRIM(this.obtener_valor_celda(lnFila, 3)))
		INSERT INTO cur_articulos ( ;
			idArticulo, stock, codigo, articulo, linea, rubro, venta, lista, costo,;
			codArt, esNuevo) ;
		VALUES (this.id_articulo_actual, "NADA", ;
			lcCodigo, ALLTRIM(this.obtener_valor_celda(lnFila, 2)), ;
			lcLinea, "NO DEFINIDO", ;
			0, this.obtener_valor_celda(lnFila, 5), 0, lcCodigo, llEsNuevo)
	ENDIF
	
	WAIT WINDOW ALLTRIM(STR(lnFila)) NOWAIT
	lnFila = lnFila + 1
	lcCodAux = this.obtener_valor_celda(lnFila, 1)
	IF !ISNULL(lcCodAux) THEN
		lcCodigo = STRTRAN(ALLTRIM(IIF(TYPE("lcCodAux") == "C", lcCodAux, STR(lcCodAux))), " ", "")
	ENDIF	
ENDDO
=this.cerrar_planilla()
SELECT cur_articulos
GO TOP
ENDPROC


************************************************************
OBJETO: picborg_updater
************************************************************
*** PROPIEDADES ***
Name = "picborg_updater"

*** METODOS ***
PROCEDURE formatear_codigo
PARAMETERS tCodigo, tcDescripcion

LOCAL lcCodigo

IF !ISNULL(tCodigo) THEN
	IF TYPE("tCodigo") == "C" THEN
		lcCodigo = ALLTRIM(tCodigo)
	ELSE
		lcCodigo = ALLTRIM(STR(tCodigo))
	ENDIF

	lcCodigo = UPPER(lcCodigo)
	lcCodigo = STRTRAN(lcCodigo, " ", "")
	lcCodigo = STRTRAN(lcCodigo, "°", "")
	lcCodigo = STRTRAN(lcCodigo, "-", "")
	lcCodigo = STRTRAN(lcCodigo, "º", "")
	
	IF SUBSTR(lcCodigo, 1, 1) == "N" THEN
		lcCodigo = lcCodigo + "-" + SUBSTR(ALLTRIM(tcDescripcion), 1, 1)
	ENDIF
ELSE
	lcCodigo = ""
ENDIF

RETURN lcCodigo


ENDPROC
PROCEDURE copiar_planilla_a_cursor
PARAMETERS tcFileName

LOCAL lnFila
LOCAL lcCodigo
LOCAL llEsNuevo

SELECT cur_articulos
ZAP

=this.abrir_planilla(tcFileName)
lnFila = 2
DO WHILE !(this.formatear_codigo(this.obtener_valor_celda(lnFila, 1), this.obtener_valor_celda(lnFila, 2)) == "")
	lcCodigo = this.formatear_codigo(this.obtener_valor_celda(lnFila, 1), this.obtener_valor_celda(lnFila, 2))
	IF !ISNULL(lcCodigo) THEN
		llEsNuevo = !this.verificar_articulo(lcCodigo)
		this.obtener_porcentajes()
		INSERT INTO cur_articulos ( ;
			idArticulo, stock, codigo, articulo, linea, rubro, venta, lista, costo,;
			codArt, esNuevo) ;
		VALUES (this.id_articulo_actual, "NO DEFINIDO", ;
			lcCodigo, this.obtener_valor_celda(lnFila, 2), ;
			"NO DEFINIDO", "NO DEFINIDO", 0, this.obtener_valor_celda(lnFila, 3), 0, ;
			lcCodigo, llEsNuevo)			
	ENDIF
	
	WAIT WINDOW ALLTRIM(STR(lnFila)) NOWAIT
	lnFila = lnFila + 1
ENDDO
=this.cerrar_planilla()
SELECT cur_articulos
GO TOP
ENDPROC


************************************************************
OBJETO: estatomac_upgrade
************************************************************
*** PROPIEDADES ***
Name = "estatomac_upgrade"

*** METODOS ***
PROCEDURE Init
PARAMETERS tcFileName

LOCAL lnFila
LOCAL lcCodigo
LOCAL llEsNuevo

SELECT cur_articulos
ZAP

=this.abrir_planilla(tcFileName)
lnFila = 2
DO WHILE !(ALLTRIM(this.obtener_valor_celda(lnFila, 1)) == "")
	lcCodigo = STRTRAN(ALLTRIM(this.obtener_valor_celda(lnFila, 1)), " ", "")
	IF !ISNULL(lcCodigo) THEN
		llEsNuevo = !this.verificar_articulo(lcCodigo)
		this.obtener_porcentajes()
		INSERT INTO cur_articulos ( ;
			idArticulo, stock, codigo, articulo, linea, rubro, venta, lista, costo,;
			codArt, esNuevo) ;
		VALUES (this.id_articulo_actual, "NO DEFINIDO", ;
			this.obtener_valor_celda(lnFila, 1), this.obtener_valor_celda(lnFila, 2), ;
			"NO DEFINIDO", "NO DEFINIDO", 0, this.obtener_valor_celda(lnFila, 3), 0, ;
			lcCodigo, llEsNuevo)			
	ENDIF
	
	WAIT WINDOW ALLTRIM(STR(lnFila)) NOWAIT
	lnFila = lnFila + 1
ENDDO
=this.cerrar_planilla()
SELECT cur_articulos
GO TOP
ENDPROC


************************************************************
OBJETO: franse_updater
************************************************************
*** PROPIEDADES ***
Name = "franse_updater"

*** METODOS ***
PROCEDURE copiar_planilla_a_cursor
PARAMETERS tcFileName

LOCAL lnFila
LOCAL lcCodigo
LOCAL llEsNuevo

SELECT cur_articulos
ZAP

=this.abrir_planilla(tcFileName)
=this.obtener_porcentajes()
lnFila = 4
DO WHILE !(ALLTRIM(this.obtener_valor_celda(lnFila, 1)) == "")
	lcCodigo = ALLTRIM(this.obtener_valor_celda(lnFila, 2)) ;
		+ ALLTRIM(this.obtener_valor_celda(lnFila, 4))
	IF !ISNULL(lcCodigo) THEN
		llEsNuevo = !this.verificar_articulo(lcCodigo)
		INSERT INTO cur_articulos ( ;
			idArticulo, stock, codigo, articulo, linea, rubro, venta, lista, costo,;
			codArt, esNuevo) ;
		VALUES (this.id_articulo_actual, this.obtener_valor_celda(lnFila, 1), ;
			this.obtener_valor_celda(lnFila, 2), this.obtener_valor_celda(lnFila, 3), ;
			this.obtener_valor_celda(lnFila, 4), this.obtener_valor_celda(lnFila, 5), ;
			this.obtener_valor_celda(lnFila, 6), this.obtener_valor_celda(lnFila, 7), ;
			this.obtener_valor_celda(lnFila, 8), lcCodigo, llEsNuevo)			
	ENDIF
	
	WAIT WINDOW ALLTRIM(STR(lnFila - 4)) NOWAIT
	lnFila = lnFila + 1
ENDDO
=this.cerrar_planilla()
SELECT cur_articulos
GO TOP
ENDPROC


************************************************************
OBJETO: ferman_updater
************************************************************
*** PROPIEDADES ***
Name = "ferman_updater"

*** METODOS ***
PROCEDURE copiar_planilla_a_cursor
PARAMETERS tcFileName

LOCAL lnFile
LOCAL lcLinea
LOCAL lcSaltoLinea
LOCAL lcCodigo
LOCAL lcDescripcion
LOCAL lnLista
LOCAL lnPrecio
LOCAL llEsNuevo
LOCAL lnIndex

lcLinea = ""
lcSaltoLinea = CHR(13) + CHR(10)
lcCodigo = ""
lcDescripcion = ""
lnLista = 0.00
lnPrecio = 0.00
lnIndex = 0

this.obtener_porcentajes()
lnFile = FOPEN(tcFileName)
IF lnFile < 0 THEN
	MESSAGEBOX("Error al abrir el archivo", 0+48, "Actualizador FERMAN")
	RETURN
ENDIF
lcLinea = FGETS(lnFile)
DO WHILE !FEOF(lnFile)
	IF SUBSTR(lcLinea, 1, 1) == ":" THEN
		lcCodigo = ALLTRIM(STRTRAN(SUBSTR(lcLinea, 3, 16), " ", ""))
		IF !(LOWER(ALLTRIM(lcCodigo)) == "código") THEN
			WAIT WINDOW "Procesando línea nº " + ALLTRIM(STR(lnIndex)) NOWAIT
			llEsNuevo = !this.verificar_articulo(lcCodigo)
			lcDescripcion = ALLTRIM(SUBSTR(lcLinea, 19, 47))
			lnLista = VAL(SUBSTR(lcLinea, 104, 10))
			lnPrecio = VAL(SUBSTR(lcLinea, 115, 10))
			SELECT cur_articulos
			INSERT INTO cur_articulos ( ;
				idArticulo, stock, codigo, articulo, linea, rubro, venta, lista, costo,;
				codArt, esNuevo) ;
			VALUES (this.id_articulo_actual, "NADA", ;
				lcCodigo, lcDescripcion, ;
				"NADA", "NADA", 0, lnLista, ;
				0, lcCodigo, llEsNuevo)
			lnIndex = lnIndex + 1
		ENDIF
	ENDIF
	lcLinea = FGETS(lnFile)
ENDDO

FCLOSE(lnFile)
SELECT cur_articulos

ENDPROC


************************************************************
OBJETO: actu_dercli
************************************************************
*** PROPIEDADES ***
desc1 = 0.00
desc2 = 0.00
desc3 = 0.00
desc4 = 0.00
margenmay = 0.00
margenmin = 0.00
idprov = 0
path = C:\DERCLI6\DATOS\
error_message = 
alic_iva = 21
Name = "actu_dercli"

*** METODOS ***
PROCEDURE open
LOCAL  lcTabRubro, lcTabSrb, lcTabMrc, lcTabArt, lcMarcas

lcTabRubro = This.path + "rubros"
lcTabSrb = This.Path + "subrubros"
lcTabMrc = This.path + "marcas"
lcTabArt = This.path + "articulos"
lcMarcas = ALLTRIM(getglobalcfg("DERCLI_MRC"))

WAIT WINDOW "Leyendo artículos desde DERCLI6..." NOWAIT

IF ALLTRIM(lcMarcas) == "" THEN
	&& Si no tiene filtro cofigurado por marca, entonces, ejecuta esta instrucción
	SELECT	artic.codart		AS codigo 		,;
			artic.descripcio	AS descripcio	,;
			rub.descripcio 		AS familia		,;
			srb.descripcio 		AS subfam		,;
			mrc.descripcio 		AS marca		,;
			artic.prLista 		AS precio		,;
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

SELECT cur_artic
IF RECCOUNT("cur_artic") > 0 THEN
	GO TOP
ENDIF
ENDPROC
PROCEDURE grabar
LOCAL loResult, loCommand, lcSql, lnIdFamilia, lnIdSubFam
LOCAL lnIdMarca, lcCodigo, lcDescripcio, lnPrecio
LOCAL lcFamilia, lcSubFam, lcMarca, loDT, lcLinkFoto
LOCAL loProg, i

loResult = CREATEOBJECT("odbc_result")
loCommand = CREATEOBJECT("odbc_command")
loDT = CREATEOBJECT("datetime")
loProg = CREATEOBJECT("_thermometer")
lcSql = ""
lnIdFamilia = 0
lnIdSubFam = 0
lnIdMarca = 0
lcCodigo = ""
lcDescripcio = ""
lnPrecio = 0.00
lcFamilia = ""
lcSubFam = ""
lcMarca = ""
lcLinkFoto = ""

loProg.Show()

&& Establezco el nivel de aislamiento de lectura no confirmada
loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = "set session transaction isolation level read uncommitted"

IF !loCommand.Execute() THEN
	goConn.Rollback()
	This.error_message = loCommand.ErrorMessage
	RETURN .F.
ENDIF

i = 0

goConn.BeginTransaction()
SELECT cur_artic
DO WHILE !EOF("cur_artic")
	lcCodigo = ALLTRIM(cur_artic.codigo)
	lcDescripcio = ALLTRIM(cur_artic.descripcio)
	lnPrecio = cur_artic.precio
	lcFamilia = ALLTRIM(cur_artic.familia)
	lcSubFam = ALLTRIM(cur_artic.subfam)
	lcMarca = ALLTRIM(cur_artic.marca)
	lcLinkFoto = ALLTRIM(cur_artic.linkfoto)
	
	lcSql = "SELECT * FROM familias WHERE LTRIM(RTRIM(descripcio)) = '" + ALLTRIM(lcFamilia) + "'"
	loResult.ActiveConnection = goConn.ActiveConnection
	loResult.Cursor_Name = "cur_Familia"
	
	IF !loResult.OpenQuery(lcSql) THEN
		This.Error_Message = loResult.Error_Message
		goConn.Rollback()
		RETURN .F.
	ENDIF
	
	SELECT cur_Familia
	IF RECCOUNT("cur_Familia") = 0 THEN
		lnIdFamilia = goConn.GetNextID("familias", "idFamilia")
	
		lcSql = "INSERT INTO familias ( "
		lcSql = lcSql + "idFamilia, "
		lcSql = lcSql + "descripcio, "
		lcSql = lcSql + "usuAlta, "
		lcSql = lcSql + "fecAlta, "
		lcSql = lcSql + "idHostAlta) VALUES ( "
		lcSql = lcSql + ALLTRIM(STR(lnIdFamilia)) + ", "
		lcSql = lcSql + "'" + lcFamilia + "', "
		lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
		lcSql = lcSql + loDT.getDateTime() + ", "
		lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "')"
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			This.Error_Message = loCommand.ErrorMessage
			loResult.Close_Query()
			RETURN .F.
		ENDIF
	ELSE
		lnIdFamilia = cur_Familia.IdFamilia
	ENDIF
	
	loResult.Close_Query()
	
	lcSql = "SELECT * FROM subfam WHERE LTRIM(RTRIM(descripcio)) = '" + ALLTRIM(lcSubFam) + "'"
	loResult.ActiveConnection = goConn.ActiveConnection
	loResult.Cursor_Name = "cur_SubFam"

	IF !loResult.OpenQuery(lcSql) THEN
		This.Error_Message = loResult.Error_Message
		goConn.Rollback()
		loResult.Close_Query()
		RETURN .F.
	ENDIF
	
	IF RECCOUNT("cur_SubFam") = 0 THEN
		lnIdSubFam = goConn.GetNextID("subfam", "idSubFam")
	
		lcSql = "INSERT INTO subfam ( "
		lcSql = lcSql + "	idSubFam, "
		lcSql = lcSql + "	descripcio, "
		lcSql = lcSql + "	usuAlta, "
		lcSql = lcSql + "	fecAlta, "
		lcSql = lcSql + "	idHostAlta) VALUES ("
		lcSql = lcSql + ALLTRIM(STR(lnIdSubFam)) + ", "
		lcSql = lcSql + "'" + lcSubFam + "', "
		lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
		lcSql = lcSql + loDT.getDateTime() + ", "
		lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "')"
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			This.Error_Message = loCommand.ErrorMessage
			goConn.Rollback()
			loResult.Close_Query()
			RETURN .F.
		ENDIF
	ELSE
		lnIdSubFam = cur_SubFam.idSubFam
	ENDIF
	
	loResult.Close_Query()
	
	lcSql = "SELECT * FROM marcas WHERE LTRIM(RTRIM(descripcio)) = '" + ALLTRIM(lcMarca) + "'"
	loResult.ActiveConnection = goConn.ActiveConnection
	loResult.Cursor_Name = "cur_mrcs"
	
	IF !loResult.OpenQuery(lcSql) THEN
		goConn.Rollback()
		This.Error_Message = loResult.Error_Message
		RETURN .F.
	ENDIF
	
	SELECT cur_mrcs
	IF RECCOUNT("cur_mrcs") = 0 THEN
		lnIdMarca = goConn.GetNextID("marcas", "idMarca")
		
		lcSql = "INSERT INTO marcas ( "
		lcSql = lcSql + "idmarca, "
		lcSql = lcSql + "descripcio, "
		lcSql = lcSql + "usuAlta, "
		lcSql = lcSql + "fecAlta, "
		lcSql = lcSql + "idHostAlta) VALUES ( "
		lcSql = lcSql + ALLTRIM(STR(lnIdMarca)) + ", "
		lcSql = lcSql + "'" + ALLTRIM(lcMarca) + "', "
		lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
		lcSql = lcSql + loDT.getDateTime() + ", "
		lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "')"
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			This.Error_Message = loCommand.ErrorMessage
			loResult.Close_Query()
			RETURN .F.
		ENDIF
	ELSE
		lnIdMarca = cur_mrcs.idmarca
	ENDIF
	
	loResult.Close_Query()
	
	**************************************************************
	* Doy de alta el artículo en la base de datos
	**************************************************************
	IF !This.insertar_articulo(lnIdFamilia, lnIdSubFam, lnIdMarca, lcCodigo, ;
			cur_artic.descripcio, cur_artic.precio, cur_artic.linkfoto) THEN
		goConn.Rollback()
		RETURN .F.
	ENDIF
		
	i = i + 1
	WAIT WINDOW "Procesando " + ALLTRIM(STR(i)) + " de " + ALLTRIM(STR(RECCOUNT("cur_artic"))) + "..." NOWAIT
	loProg.Update((i * 100) / RECCOUNT("cur_artic"), "Actualizando artículos desde DERCLI6...")
	
	SELECT cur_artic
	SKIP
ENDDO

goConn.Commit()

&& Establezco el nivel de aislamiento de lectura confirmada
loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = "set session transaction isolation level read committed"

IF !loCommand.Execute() THEN
	goConn.Rollback()
	This.error_message = loCommand.ErrorMessage
	RETURN .F.
ENDIF

loProg.Complete()
RETURN .T.
ENDPROC
PROCEDURE insertar_articulo
PARAMETERS tnIdFamilia, tnIdSubFam, tnIdMarca, tcCodArt, tcDescripcio, tnPrLista, tcLinkFoto

LOCAL 	lnCostoRep, lnMargenMax, lnMargenMin, lnPrVentaMax, lnPrVentaMin,;
		lnFinalMax, lnFinalMin, lcObserv, lnPrLista
LOCAL 	lnBonif1, lnBonif2, lnBonif3, lnBonif4		
LOCAL 	loCommand, lcSql, loResult, lnProxID, loDT, loUniDesp
LOCAL 	lnProxID, lnPrAnt, lnUniDesp, lnPrDif, lnPorVar, lbActuFoto 

loDT = CREATEOBJECT("datetime")
loCommand = CREATEOBJECT("odbc_command")
loResult = CREATEOBJECT("odbc_result")
loUniDesp = CREATEOBJECT("odbc_result")
lcSql = ""
lnCostoRep = 0.00
lnMargenMax = 0.00
lnMargenMin = 0.00
lnPrVentaMax = 0.00
lnPrVentaMin = 0.00
lnFinalMax = 0.00
lnFinalMin = 0.00
lcObserv = ""
lnPrLista = 0.00
lnProxID = 0.00
lnBonif1 = 0.00
lnBonif2 = 0.00
lnBonif3 = 0.00
lnBonif4 = 0.00
lnProxID = 0
lnPrAnt = 0.00
lnUniDesp = 0.00
lnPrDif = 0.00
lnPorVar = 0.00

lcCodigo = ALLTRIM(tcCodArt)
lbActuFoto = getglobalcfg("VERFOTODER")

IF INT(VAL(getconfig("SQLSRV"))) = 0 THEN 
	tcLinkFoto = ALLTRIM(STRTRAN(tcLinkFoto,"\","\\"))
ENDIF 

lcSql = "SELECT * FROM articulos WHERE codArt = '" + ALLTRIM(lcCodigo) + "' "
lcSql = lcSql + "AND articulos.idprov = " + ALLTRIM(STR(this.idprov))
loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_tmp"

IF !loResult.OpenQuery(lcSql) THEN
	MESSAGEBOX(loResult.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_tmp
IF RECCOUNT("cur_tmp") = 0 THEN
	lnBonif1 = this.desc1
	lnBonif2 = this.desc2
	lnBonif3 = this.desc3
	lnBonif4 = this.desc4
	lnMargenMax = this.margenmay
	lnMargenMin = this.margenmin
	
	* Calculo el precio de venta
	lnPrLista = tnPrLista
	lnCostoRep = calcular_costo(lnPrLista, lnBonif1, lnBonif2, lnBonif3, lnBonif4, 0)
	lnPrVentaMax = lnCostoRep + (lnCostoRep * (lnMargenMax / 100))
	lnPrVentaMin = lnCostoRep + (lnCostoRep * (lnMargenMin / 100))
	lnFinalMax = lnPrVentaMax + (lnPrVentaMax * (this.alic_iva / 100))
	lnFinalMin = lnPrVentaMin + (lnPrVentaMin * (this.alic_iva / 100))

	lnProxID = goConn.GetNextID("articulos", "idArticulo")

	lcSql = "INSERT INTO articulos ( "
	lcSql = lcSql + "	idArticulo, "
	lcSql = lcSql + "	idProv, "
	lcSql = lcSql + "	idFamilia, "
	lcSql = lcSql + "	idSubFam, "
	lcSql = lcSql + "	idMarca, "
	lcSql = lcSql + "	codArt, "
	lcSql = lcSql + "	descripcio, "
	lcSql = lcSql + "	alicIVA, "
	lcSql = lcSql + "	tmon, "
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
	lcSql = lcSql + "	prventaMax, "
	lcSql = lcSql + "	prventaMin, "
	lcSql = lcSql + "	prfinalMax, "
	lcSql = lcSql + "	prfinalMin, "
	lcSql = lcSql + "	observ, "
	lcSql = lcSql + "	idUniMed, "
	lcSql = lcSql + "	habilitado, "
	lcSql = lcSql + "	linkfoto, "
	lcSql = lcSql + "	fecActuPre, "
	lcSql = lcSql + "	usuAlta, "
	lcSql = lcSql + "	fecAlta, "
	lcSql = lcSql + "	idHostAlta) "
	lcSql = lcSql + "VALUES ( "
	lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", "					&& idAticulo
	lcSql = lcSql + ALLTRIM(STR(This.idProv)) + ", " 				&& Proveedor
	lcSql = lcSql + ALLTRIM(STR(tnIdFamilia)) + ", " 				&& Familia
	lcSql = lcSql + ALLTRIM(STR(tnIdSubFam)) + ", "					&& SubFamilia
	lcSql = lcSql + ALLTRIM(STR(tnIdMarca)) + ", " 					&& Marca
	lcSql = lcSql + "'" + ALLTRIM(lcCodigo) + "', "					&& CodArt
	lcSql = lcSql + "'" + ALLTRIM(STRTRAN(tcDescripcio, "'"," ")) + "', "	&& Descripcio
	lcSql = lcSql + ALLTRIM(STR(This.alic_iva, 10, 2)) + ", "		&& alicIVA
	lcSql = lcSql + "'PSO', "										&& tMon
	lcSql = lcSql + "0, "											&& Precio de lista ext.
	lcSql = lcSql + "0, "											&& Cotización
	lcSql = lcSql + ALLTRIM(STR(lnPrLista, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(This.desc1, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(This.desc2, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(This.desc3, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(This.desc4, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnCostoRep, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(This.margenmay, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(This.margenmin, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPrVentaMax, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPrVentaMin, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnFinalMax, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnFinalMin, 10, 2)) + ", "
	lcSql = lcSql + "'', " 											&& Observ
	lcSql = lcSql + "1, "											&& idUniMed
	lcSql = lcSql + "1, "											&& habilitado
	
	IF !lbActuFoto THEN 
		lcSql = lcSql + "NULL, " 	
	ELSE 
		lcSql = lcSql + "'" + ALLTRIM(tcLinkFoto) + "', "	
	ENDIF 
	
	lcSql = lcSql + "current_timestamp, "
	lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
	lcSql = lcSql + loDT.getDateTime() + ", "
	lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "')"

	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute() THEN
		This.error_message = loCommand.ErrorMessage
		loResult.Close_Query()
		RETURN .F.
	ENDIF
	
	&& Agrego el registro al codiart
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
	lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", "
	lcSql = lcSql + "'" + ALLTRIM(lcCodigo) + "', "
	lcSql = lcSql + "'" + ALLTRIM(lcCodigo) + "', "
	lcSql = lcSql + "'CP', "
	lcSql = lcSql + "1, "
	lcSql = lcSql + "0, "
	lcSql = lcSql + "'CV')"
	
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute() THEN
		this.errorMessage = loCommand.ErrorMessage
		loResult.Close_Query()
		RETURN .F.
	ENDIF	
	
ELSE
	&& Me fijo si en art_unid esta el articulo
	lcSql = "SELECT	* "
	lcSql = lcSql + "FROM art_unid "
	lcSql = lcSql + "WHERE art_unid.idArticulo = " + ALLTRIM(STR(cur_tmp.IdArticulo))

	loUniDesp.ActiveConnection = goConn.ActiveConnection
	loUniDesp.Cursor_Name = "cur_ud"

	IF !loUniDesp.OpenQuery(lcSql) THEN
		MESSAGEBOX(loUniDesp.Error_Message, 0+48, Thisform.Caption)
		loResult.Close_Query()
		RETURN .F.
	ENDIF

	SELECT cur_ud
	IF RECCOUNT("cur_ud") > 0 THEN
		lnUniDesp = cur_ud.cantUD
	ELSE
		lnUniDesp = 0.00
	ENDIF

	loUniDesp.Close_Query()

	&& Calculo la variacion en el cambio de precio
	lnPrAnt = cur_tmp.prLista
	
	IF tnPrLista > lnPrAnt THEN
		lnPrDif = tnPrLista  - lnPrAnt 
		IF lnPrAnt <> 0 THEN
			lnPorVar = (lnPrDif * 100) / lnPrAnt 
		ELSE
			lnPorVar = 100
		ENDIF
	ELSE
		lnPrDif = lnPrAnt  - tnPrLista 
		IF lnPrAnt <> 0 THEN
			lnPorVar = ((lnPrDif * 100) / lnPrAnt) * -1
		ELSE
			lnPorVar = 100
		ENDIF
	ENDIF
	
	lnBonif1 = IIF(this.desc1 = 0, cur_tmp.bonif1, this.desc1)
	lnBonif2 = IIF(this.desc2 = 0, cur_tmp.bonif2, this.desc2)
	lnBonif3 = IIF(this.desc3 = 0, cur_tmp.bonif3, this.desc3)
	lnBonif4 = IIF(this.desc4 = 0, cur_tmp.bonif4, this.desc3)
	lnMargenMax = IIF(this.margenmay = 0, cur_tmp.margenMax, this.margenmay)
	lnMargenMin = IIF(this.margenmin = 0, cur_tmp.margenMin, this.margenmin)

	* Calculo el precio de venta
	IF lnUniDesp <> 0 THEN 
		lnPrLista = tnPrLista / lnUniDesp 
	ELSE 
		lnPrLista = tnPrLista
	ENDIF 

	lnCostoRep = calcular_costo(lnPrLista, lnBonif1, lnBonif2, lnBonif3, lnBonif4, 0)
	lnPrVentaMax = lnCostoRep + (lnCostoRep * (lnMargenMax / 100))
	lnPrVentaMin = lnCostoRep + (lnCostoRep * (lnMargenMin / 100))
	lnFinalMax = lnPrVentaMax + (lnPrVentaMax * (this.alic_iva / 100))
	lnFinalMin = lnPrVentaMin + (lnPrVentaMin * (this.alic_iva / 100))
	
	&& En caso de existir el código, modifico el artículo
	lcSql = "UPDATE articulos "
	lcSql = lcSql + "SET 	idProv = " + ALLTRIM(STR(This.idProv)) + ", " 				
	lcSql = lcSql + "		alicIVA = " + ALLTRIM(STR(This.alic_iva, 10, 2)) + ", "
	lcSql = lcSql + "		prLista = " + ALLTRIM(STR(lnPrLista, 10, 2)) + ", "
	lcSql = lcSql + "		bonif1 = " + ALLTRIM(STR(lnBonif1, 10, 2)) + ", "
	lcSql = lcSql + "		bonif2 = " + ALLTRIM(STR(lnBonif2, 10, 2)) + ", "
	lcSql = lcSql + "		bonif3 = " + ALLTRIM(STR(lnBonif3, 10, 2)) + ", "
	lcSql = lcSql + "		bonif4 = " + ALLTRIM(STR(lnBonif4, 10, 2)) + ", "
	lcSql = lcSql + "		costoRep = " + ALLTRIM(STR(lnCostoRep, 10, 2)) + ", "
	lcSql = lcSql + "		margenMax = " + ALLTRIM(STR(lnMargenMax, 10, 2)) + ", "
	lcSql = lcSql + "		margenMin = " + ALLTRIM(STR(lnMargenMin, 10, 2)) + ", "
	lcSql = lcSql + "		prventaMax = " + ALLTRIM(STR(lnPrVentaMax, 10, 2)) + ", "
	lcSql = lcSql + "		prventaMin = " + ALLTRIM(STR(lnPrVentaMin, 10, 2)) + ", "
	lcSql = lcSql + "		prfinalMax = " + ALLTRIM(STR(lnFinalMax, 10, 2)) + ", "
	lcSql = lcSql + "		prfinalMin = " + ALLTRIM(STR(lnFinalMin, 10, 2)) + ", "
	IF lbActuFoto THEN 
		lcSql = lcSql + "	linkfoto = '" + ALLTRIM(tcLinkFoto) + "', "	
	ENDIF 
	lcSql = lcSql + "		fecActuPre = CURRENT_TIMESTAMP, "
	lcSql = lcSql + "		usuModi = '" + ALLTRIM(gcCodUsu) + "', "
	lcSql = lcSql + "		fecModi = " + loDT.getdatetime() + ", "
	lcSql = lcSql + "		idHostModi = '" + ALLTRIM(SYS(0)) + "' "
	lcSql = lcSql + "WHERE codArt = '" + ALLTRIM(lcCodigo) + "'"

	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute() THEN
		this.error_message = loCommand.ErrorMessage
		loResult.Close_Query()
		RETURN .F.
	ENDIF

	IF lnPorVar <> 0 THEN
		&& Agrego el insert que permite registrar los cambios de precios de los artículos
		lnProxID = goConn.GetNextID("art_cbios", "idArtCbios")
		
		lcSql = "insert into art_cbios ( "
		lcSql = lcSql + "idArtCbios, idArticulo, fecha, prAnt, prNuevo, porVar) values ("
		lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_tmp.idArticulo)) + ", "
		lcSql = lcSql + loDT.getDateTime() + ", "
		lcSql = lcSql + ALLTRIM(STR(lnPrAnt, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnPrLista, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnPorVar, 10, 2)) + ") "
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			this.ErrorMessage = loCommand.ErrorMessage
			loResult.Close_Query()
			RETURN .F.
		ENDIF
	ENDIF
ENDIF

loResult.Close_Query()

RETURN .T.
ENDPROC


************************************************************
OBJETO: updater_net_clouddb
************************************************************
*** PROPIEDADES ***
nombre_archivo = 
fecha_actualizacion = {}
conexionactiva = 
url = 
idprov = 0
mensaje = 
Name = "updater_net_clouddb"

*** METODOS ***
PROCEDURE conectar
LOCAL lcConnectionString
LOCAL lcDriver
LOCAL lcServer
LOCAL lnPort
LOCAL lcUser
LOCAL lcPassword
LOCAL lcDatabase

this.conexionactiva = CREATEOBJECT("odbc_connect")

lcDriver 	= getGlobalCFG("UPD_DRIVER")
lcServer 	= getGlobalCFG("UPD_SERVER")
lnPort 		= getGlobalCFG("UPD_PORT")
lcUser 		= getGlobalCFG("UPD_USER")
lcPassword 	= getGlobalCFG("UPD_PASS")
lcDatabase 	= getGlobalCFG("UPD_DB")

lcConnectionString = "DRIVER={" + lcDriver + "};" ;
	+ "SERVER=" + ALLTRIM(lcServer) + ";" ;
	+ "PORT=" + ALLTRIM(STR(lnPort)) + ";" ;
	+ "UID=" + ALLTRIM(lcUser) + ";" ;
	+ "PWD=" + ALLTRIM(lcPassword) + ";" ;
	+ "DATABASE=" + ALLTRIM(lcDatabase) + ";" ;
	+ "OPTION=3"
	
this.conexionactiva.connectionstring = lcConnectionString
this.conexionactiva.open()

	
ENDPROC
PROCEDURE desconectar
this.conexionactiva.close()
ENDPROC
PROCEDURE obtener_actualizacion_activa
LOCAL loRes
LOCAL lcSql
LOCAL llOk

loRes = CREATEOBJECT("odbc_result")
lcSql = ""
llOk = .f.

lcSql = "CALL listas_getActivaByProv (" ;
	+ ALLTRIM(STR(this.idprov)) + ")"

this.conectar()
loRes.ActiveConnection = this.conexionactiva.ActiveConnection
loRes.Cursor_Name = "cur_tmp"
loRes.OpenQuery(lcSql)
SELECT cur_tmp
IF RECCOUNT("cur_tmp") = 0 THEN
	this.mensaje = "No hay actualización activa para este proveedor"
	llOk = .f.
ELSE
	SELECT cur_tmp
	this.nombre_archivo = cur_tmp.fileName
	this.fecha_actualizacion = cur_tmp.fecha
	llOk = .t.
ENDIF
loRes.Close_Query()

this.desconectar()
RETURN llOk



ENDPROC


************************************************************
OBJETO: cls_xls_updater_v2
************************************************************
*** PROPIEDADES ***
DoCreate = .T.
Caption = "Actualizador de precios desde Excel"
Name = "cls_xls_updater_v2"
contenido.Clsetiqueta1.TabIndex = 16
contenido.Clsetiqueta1.Name = "Clsetiqueta1"
contenido.sel_proveedor.txtCodigo.Name = "txtCodigo"
contenido.sel_proveedor.txtDescripcion.Name = "txtDescripcion"
contenido.sel_proveedor.TabIndex = 1
contenido.sel_proveedor.Name = "sel_proveedor"
contenido.Clsetiqueta2.TabIndex = 17
contenido.Clsetiqueta2.Name = "Clsetiqueta2"
contenido.txtFileName.TabIndex = 2
contenido.txtFileName.Name = "txtFileName"
contenido.btnCerrar.TabIndex = 15
contenido.btnCerrar.Name = "btnCerrar"
contenido.Clsetiqueta3.TabIndex = 18
contenido.Clsetiqueta3.Name = "Clsetiqueta3"
contenido.txtBonif1.TabIndex = 4
contenido.txtBonif1.Name = "txtBonif1"
contenido.txtBonif2.TabIndex = 5
contenido.txtBonif2.Name = "txtBonif2"
contenido.txtBonif3.TabIndex = 6
contenido.txtBonif3.Name = "txtBonif3"
contenido.txtBonif4.TabIndex = 7
contenido.txtBonif4.Name = "txtBonif4"
contenido.Clsetiqueta4.TabIndex = 19
contenido.Clsetiqueta4.Name = "Clsetiqueta4"
contenido.txtMargenMay.TabIndex = 8
contenido.txtMargenMay.Name = "txtMargenMay"
contenido.Clsetiqueta5.TabIndex = 20
contenido.Clsetiqueta5.Name = "Clsetiqueta5"
contenido.txtMargenMin.TabIndex = 9
contenido.txtMargenMin.Name = "txtMargenMin"
contenido.grdRegistros.COLUMN1.Header1.Name = "Header1"
contenido.grdRegistros.COLUMN1.Text1.Name = "Text1"
contenido.grdRegistros.COLUMN1.Name = "COLUMN1"
contenido.grdRegistros.COLUMN2.Header1.Name = "Header1"
contenido.grdRegistros.COLUMN2.Text1.Name = "Text1"
contenido.grdRegistros.COLUMN2.Name = "COLUMN2"
contenido.grdRegistros.COLUMN3.Header1.Name = "Header1"
contenido.grdRegistros.COLUMN3.Text1.Name = "Text1"
contenido.grdRegistros.COLUMN3.Name = "COLUMN3"
contenido.grdRegistros.COLUMN4.Header1.Name = "Header1"
contenido.grdRegistros.COLUMN4.Text1.Name = "Text1"
contenido.grdRegistros.COLUMN4.Name = "COLUMN4"
contenido.grdRegistros.COLUMN5.Header1.Name = "Header1"
contenido.grdRegistros.COLUMN5.Text1.Name = "Text1"
contenido.grdRegistros.COLUMN5.Name = "COLUMN5"
contenido.grdRegistros.COLUMN6.Header1.Name = "Header1"
contenido.grdRegistros.COLUMN6.Text1.Name = "Text1"
contenido.grdRegistros.COLUMN6.Name = "COLUMN6"
contenido.grdRegistros.COLUMN7.Header1.Name = "Header1"
contenido.grdRegistros.COLUMN7.Text1.Name = "Text1"
contenido.grdRegistros.COLUMN7.Name = "COLUMN7"
contenido.grdRegistros.COLUMN8.Header1.Name = "Header1"
contenido.grdRegistros.COLUMN8.Text1.Name = "Text1"
contenido.grdRegistros.COLUMN8.Name = "COLUMN8"
contenido.grdRegistros.COLUMN9.Header1.Name = "Header1"
contenido.grdRegistros.COLUMN9.Text1.Name = "Text1"
contenido.grdRegistros.COLUMN9.Name = "COLUMN9"
contenido.grdRegistros.COLUMN10.Header1.Name = "Header1"
contenido.grdRegistros.COLUMN10.Text1.Name = "Text1"
contenido.grdRegistros.COLUMN10.Name = "COLUMN10"
contenido.grdRegistros.COLUMN11.Header1.Name = "Header1"
contenido.grdRegistros.COLUMN11.Text1.Name = "Text1"
contenido.grdRegistros.COLUMN11.Name = "COLUMN11"
contenido.grdRegistros.COLUMN12.Header1.Name = "Header1"
contenido.grdRegistros.COLUMN12.Text1.Name = "Text1"
contenido.grdRegistros.COLUMN12.Name = "COLUMN12"
contenido.grdRegistros.COLUMN13.Header1.Name = "Header1"
contenido.grdRegistros.COLUMN13.Text1.Name = "Text1"
contenido.grdRegistros.COLUMN13.Name = "COLUMN13"
contenido.grdRegistros.COLUMN14.Header1.Name = "Header1"
contenido.grdRegistros.COLUMN14.Text1.Name = "Text1"
contenido.grdRegistros.COLUMN14.Name = "COLUMN14"
contenido.grdRegistros.COLUMN15.Header1.Name = "Header1"
contenido.grdRegistros.COLUMN15.Text1.Name = "Text1"
contenido.grdRegistros.COLUMN15.Name = "COLUMN15"
contenido.grdRegistros.COLUMN16.Header1.Name = "Header1"
contenido.grdRegistros.COLUMN16.Text1.Name = "Text1"
contenido.grdRegistros.COLUMN16.Name = "COLUMN16"
contenido.grdRegistros.COLUMN17.Header1.Name = "Header1"
contenido.grdRegistros.COLUMN17.Text1.Name = "Text1"
contenido.grdRegistros.COLUMN17.Name = "COLUMN17"
contenido.grdRegistros.COLUMN18.Header1.Name = "Header1"
contenido.grdRegistros.COLUMN18.Text1.Name = "Text1"
contenido.grdRegistros.COLUMN18.Name = "COLUMN18"
contenido.grdRegistros.COLUMN19.Header1.Name = "Header1"
contenido.grdRegistros.COLUMN19.Text1.Name = "Text1"
contenido.grdRegistros.COLUMN19.Name = "COLUMN19"
contenido.grdRegistros.COLUMN20.Header1.Name = "Header1"
contenido.grdRegistros.COLUMN20.Text1.Name = "Text1"
contenido.grdRegistros.COLUMN20.Name = "COLUMN20"
contenido.grdRegistros.TabIndex = 11
contenido.grdRegistros.Name = "grdRegistros"
contenido.btnAceptar.TabIndex = 10
contenido.btnAceptar.Name = "btnAceptar"
contenido.btnGrabar.TabIndex = 13
contenido.btnGrabar.Name = "btnGrabar"
contenido.btnCancelar.TabIndex = 14
contenido.btnCancelar.Name = "btnCancelar"
contenido.btnAbrirArchivo.TabIndex = 3
contenido.btnAbrirArchivo.Name = "btnAbrirArchivo"
contenido.TabIndex = 1
contenido.Name = "contenido"

*** METODOS ***
PROCEDURE leer_planilla
LOCAL loExcel
LOCAL loSheet
LOCAL lnIndex
LOCAL lcCodArtPV
LOCAL lnIndexError

lnIndex = 0
lnCodArtPV = 0
lnIndexError = 0

SELECT artnoenc
ZAP

IF Thisform.Contenido.sel_proveedor.valcpoid = 0 THEN	
	MESSAGEBOX("No ha seleccionado ningún proveedor", 0+48, Thisform.Caption)
	Thisform.Contenido.sel_proveedor.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

IF ALLTRIM(Thisform.Contenido.txtFileName.Value) == "" THEN
	MESSAGEBOX("No se puede procesar porque no está cargada la ruta de acceso de la planilla, " + ;
		"resuelva el problema desde Sistemas / Configurar Excels", 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

loExcel = CREATEOBJECT("Excel.Application")
loExcel.Visible = .F.

loExcel.WorkBooks.Open(ALLTRIM(Thisform.Contenido.txtFileName.Value))
loExcel.Sheets[1].Select()
loSheet = loExcel.ActiveSheet()

lnIndex = 2

IF TYPE('loSheet.cells(lnIndex, 1).Value') == "N" THEN
	lcCodArtPV = STR(loSheet.cells(lnIndex, 1).Value)
ELSE
	lcCodArtPV = loSheet.cells(lnIndex, 1).Value
ENDIF

DO WHILE !(ALLTRIM(lcCodArtPV) == "") .AND. !ISNULL(loSheet.cells(lnIndex, 2).Value)
	SELECT cur_xls
	APPEND BLANK
	REPLACE cur_xls.codArtPV WITH ALLTRIM(lcCodArtPV)
	REPLACE cur_xls.precio WITH loSheet.cells(lnIndex, 2).Value ADDITIVE
	
	WAIT WINDOW "Leyendo " + ALLTRIM(STR(lnIndex)) NOWAIT
	lnIndex = lnIndex + 1
	
	IF TYPE('loSheet.cells(lnIndex, 1).Value') == "N" THEN
		lcCodArtPV = STR(loSheet.cells(lnIndex, 1).Value)
	ELSE
		lcCodArtPV = loSheet.cells(lnIndex, 1).Value
	ENDIF
ENDDO

loExcel.Workbooks.Close()
loExcel.Quit()
RELEASE loExcel
RELEASE loSheet

SELECT cur_xls
GO TOP
MESSAGEBOX("Cantidad de registros leídos: " + ALLTRIM(STR(lnIndex)), 0+64, Thisform.Caption)

ENDPROC
PROCEDURE Init
DODEFAULT()

Thisform.contenido.btnDeshabilitar.Enabled = .F.
ENDPROC
PROCEDURE xls_analizer
LOCAL loRes
LOCAL lcSql
LOCAL llOk
LOCAL lnIndex

=This.leer_planilla()

loRes = CREATEOBJECT("odbc_result")
lcSql = ""
llOk = .T.
lnIndex = 0

SELECT cur_xls
GO TOP
DO WHILE !EOF("cur_xls")
	lcSql = "SELECT "
	lcSql = lcSql + "articulos.idArticulo, "
	lcSql = lcSql + "articulos.codArt, "
	lcSql = lcSql + "articulos.codArtPV, "
	lcSql = lcSql + "articulos.descripcio, "
	lcSql = lcSql + "articulos.alicIVA, "
	lcSql = lcSql + "articulos.bonif1, "
	lcSql = lcSql + "articulos.bonif2, "
	lcSql = lcSql + "articulos.bonif3, "
	lcSql = lcSql + "articulos.bonif4, "
	lcSql = lcSql + "articulos.margenMin, "
	lcSql = lcSql + "articulos.margenMax, "
	lcSql = lcSql + "articulos.prLista "
	lcSql = lcSql + "FROM articulos "
	lcSql = lcSql + "WHERE articulos.codArtPV = '" + ALLTRIM(cur_xls.codArtPV) + "' "
	lcSql = lcSql + " AND articulos.idProv = " + ALLTRIM(STR(Thisform.Contenido.sel_proveedor.valcpoid))
	
	IF ALLTRIM(cur_xls.codArtPV) == "315" THEN
		_cliptext = lcSql
	ENDIF
	
	loRes.ActiveConnection = goConn.ActiveConnection
	loRes.Cursor_Name = "cur_art"
	IF !loRes.OpenQuery(lcSql) THEN
		MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
		llOK = .F.
	ELSE
		IF RECCOUNT("cur_art") = 1 THEN
			SELECT registros
			APPEND BLANK
			REPLACE registros.idArticulo WITH cur_art.idArticulo
			REPLACE registros.codArt WITH cur_art.codArt ADDITIVE
			REPLACE registros.codArtPV WITH cur_art.codArtPV ADDITIVE
			REPLACE registros.descripcio WITH cur_art.descripcio ADDITIVE
			REPLACE registros.alicIVA WITH cur_art.alicIVA ADDITIVE
			REPLACE registros.bonif1 WITH cur_art.bonif1 ADDITIVE
			REPLACE registros.bonif2 WITH cur_art.bonif2 ADDITIVE
			REPLACE registros.bonif3 WITH cur_art.bonif3 ADDITIVE
			REPLACE registros.bonif4 WITH cur_art.bonif4 ADDITIVE
			REPLACE registros.margenMin WITH cur_art.margenMin ADDITIVE
			REPLACE registros.margenMay WITH cur_art.margenMax ADDITIVE
			REPLACE registros.prListaPV WITH cur_xls.precio ADDITIVE
			REPLACE registros.prListaAnt WITH cur_art.prLista ADDITIVE
		ENDIF
	
		loRes.Close_Query()
	ENDIF

	lnIndex = lnIndex + 1
	WAIT WINDOW "Escaneando registro N° " + ALLTRIM(STR(lnIndex)) + "..." NOWAIT
	SELECT cur_xls
	SKIP
ENDDO

SELECT cur_xls
GO TOP

SELECT registros
GO TOP
Thisform.Contenido.grdRegistros.Refresh

&& Ahora obtengo los artículos que no están cargados en el sistema

SELECT cur_xls.* ;
FROM cur_xls ;
	LEFT OUTER JOIN registros ON cur_xls.codArtPV = registros.codArtPV ;
WHERE registros.codArtPV IS NULL ;
INTO CURSOR cur_nuevos

SELECT cur_nuevos
GO TOP
DO WHILE !EOF("cur_nuevos")
	SELECT artnoenc
	APPEND BLANK
	REPLACE artnoenc.codArt WITH ""
	REPLACE artnoenc.codArtPV WITH cur_nuevos.codArtPV ADDITIVE
	REPLACE artnoenc.descripcio WITH "" ADDITIVE
	REPLACE artnoenc.marca WITH "" ADDITIVE
	REPLACE artnoenc.prListaPV WITH cur_nuevos.precio ADDITIVE
	REPLACE artnoenc.bonif_1 WITH 0 ADDITIVE
	REPLACE artnoenc.bonif_2 WITH 0 ADDITIVE
	REPLACE artnoenc.bonif_3 WITH 0 ADDITIVE
	REPLACE artnoenc.margen_may WITH 0 ADDITIVE
	REPLACE artnoenc.margen_min WITH 0 ADDITIVE
	REPLACE artnoenc.alicIVA WITH 21 ADDITIVE
	REPLACE artnoenc.familia WITH "VARIOS" ADDITIVE
	REPLACE artnoenc.subFam WITH "VARIOS" ADDITIVE
	REPLACE artnoenc.observac WITH "" ADDITIVE
	
	SELECT cur_nuevos
	SKIP
ENDDO

USE IN cur_nuevos

&& Busco los artículos que tengan mayores posibilidades
&& de tener que deshabilitarlos.

lcSql = "SELECT "
lcSql = lcSql + "articulos.idArticulo, "
lcSql = lcSql + "articulos.codArt, "
lcSql = lcSql + "articulos.codArtPV, "
lcSql = lcSql + "articulos.descripcio, "
lcSql = lcSql + "articulos.alicIVA, "
lcSql = lcSql + "articulos.bonif1, "
lcSql = lcSql + "articulos.bonif2, "
lcSql = lcSql + "articulos.bonif3, "
lcSql = lcSql + "articulos.bonif4, "
lcSql = lcSql + "articulos.margenMin, "
lcSql = lcSql + "articulos.margenMax, "
lcSql = lcSql + "articulos.prLista "
lcSql = lcSql + "FROM articulos "
lcSql = lcSql + "WHERE articulos.idProv = " + ALLTRIM(STR(Thisform.Contenido.sel_proveedor.valcpoid))
lcSql = lcSql + " AND articulos.fecBaja IS NULL"

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"
IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
ELSE
	SELECT cur_x.* ;
	FROM cur_x;
		LEFT OUTER JOIN cur_xls ON cur_xls.codArtPV = cur_x.codArtPV ;
	WHERE cur_xls.codArtPV IS NULL ;
	INTO CURSOR cur_baja

	SELECT cur_baja
	GO TOP
	DO WHILE !EOF("cur_baja")
		SELECT cur_artbaja
		APPEND BLANK
		REPLACE cur_artbaja.sel WITH .F.
		REPLACE cur_artbaja.idArticulo WITH cur_baja.idArticulo ADDITIVE
		REPLACE cur_artbaja.codArt WITH ALLTRIM(cur_baja.codArt) ADDITIVE
		REPLACE cur_artbaja.codArtPV WITH ALLTRIM(IIF(ISNULL(cur_baja.codArtPV), "SIN CODIGO", cur_baja.codArtPV)) ADDITIVE
		REPLACE cur_artbaja.descripcio WITH ALLTRIM(cur_baja.descripcio) ADDITIVE
		REPLACE cur_artbaja.precio WITH cur_baja.prLista ADDITIVE

		SELECT cur_baja
		SKIP
	ENDDO

	USE IN cur_baja
	loRes.Close_Query()
ENDIF

SELECT cur_artbaja
GO TOP

RETURN .T.
ENDPROC
PROCEDURE Load
DODEFAULT()

CREATE CURSOR cur_xls ( ;
	codArtPV varchar(20),;
	precio float(10, 2))
	
	
CREATE CURSOR cur_artbaja ( ;
	sel l,;
	idArticulo int,;
	codArt varchar(20),;
	codArtPV varchar(20),;
	descripcio varchar(254),;
	precio double)
ENDPROC
PROCEDURE contenido.btnAceptar.Click
DODEFAULT()
Thisform.contenido.btnDeshabilitar.Enabled = .T.
ENDPROC


************************************************************
OBJETO: btnDeshabilitar
************************************************************
*** PROPIEDADES ***
Top = 524
Left = 361
Picture = ..\imagen\iconos bajados\editar-borrar-icono-5828.ico
TabIndex = 12
ToolTipText = "Deshabilitar artículos"
Name = "btnDeshabilitar"

*** METODOS ***
PROCEDURE Click
LOCAL loForm

loForm = CREATEOBJECT("cls_articulos_baja")
loForm.show()
ENDPROC


************************************************************
OBJETO: cls_xls_updater_v2
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: generic_updater
************************************************************
*** PROPIEDADES ***
Height = 16
Width = 99
o_excel = 
o_sheet = 
alic_iva = 0.00
desc1 = 0.00
desc2 = 0.00
desc3 = 0.00
desc4 = 0.00
margenmay = 0.00
margenmin = 0.00
idprov = 0
idmarca_actual = 0
id_articulo_actual = 0
Name = "generic_updater"

*** METODOS ***
PROCEDURE crear_cursor
CREATE CURSOR cur_articulos ( ;
	idArticulo int NULL ,;
	idProv int NULL,;
	stock varchar(10) NULL,;
	codigo varchar(20) NULL,;
	codArt varchar(20) NULL,;
	articulo varchar(200) NULL,;
	linea varchar(60) NULL,;
	rubro varchar(60) NULL,;
	venta double NULL,;
	lista double NULL,;
	bonif1 double NULL,;
	bonif2 double NULL,;
	bonif3 double NULL,;
	bonif4 double NULL,;
	margenMax double NULL,;
	margenMin double NULL,;
	costo double NULL,;
	esNuevo L)
ENDPROC
PROCEDURE abrir_planilla
PARAMETERS tcFileName

this.o_excel = CREATEOBJECT("Excel.Application")
this.o_excel.Visible = .f.
this.o_excel.WorkBooks.Open(ALLTRIM(tcFileName))
this.o_excel.Sheets[1].Select()
this.o_sheet = this.o_excel.ActiveSheet()

ENDPROC
PROCEDURE cerrar_planilla
this.o_excel.WorkBooks.Close()
this.o_excel.Quit()

ENDPROC
PROCEDURE obtener_valor_celda
PARAMETERS tnFila, tnColumna
RETURN this.o_sheet.cells(tnFila, tnColumna).Value
ENDPROC
PROCEDURE copiar_planilla_a_cursor
PARAMETERS tcFileName

LOCAL lnFila
LOCAL lcCodigo
LOCAL lcDescripcion
LOCAL lnPrecio
LOCAL llEsNuevo

lcCodigo = ""
lcDescripcion = ""
lnPrecio = 0.00

SELECT cur_articulos
ZAP

=this.abrir_planilla(tcFileName)
lnFila = 2
lcCodigo = this.formatear_codigo(this.obtener_valor_celda(lnFila, 1))
DO WHILE !(ALLTRIM(lcCodigo)) == "")
	lcDescripcion = this.formatear_descripcion(this.obtener_valor_celda(lnFila, 2))
	lnPrecio = this.formatear_precio(this.obtener_valor_celda(lnFila, 3))
	IF !ISNULL(lcCodigo) .AND. lnPrecio <> 0 THEN
		llEsNuevo = !this.verificar_articulo(lcCodigo)
		this.obtener_porcentajes()
		INSERT INTO cur_articulos ( ;
			idArticulo, stock, codigo, articulo, linea, rubro, venta, lista, costo,;
			codArt, esNuevo) ;
		VALUES (this.id_articulo_actual, "NO DEFINIDO", lcCodigo, lcDescripcion, ;
			"NO DEFINIDO", "NO DEFINIDO", 0, lnPrecio, 0, ;
			lcCodigo, llEsNuevo)
	ENDIF
	WAIT WINDOW ALLTRIM(STR(lnFila - 1)) NOWAIT
	lnFila = lnFila + 1
	lcCodigo = this.formatear_codigo(this.obtener_valor_celda(lnFila, 1))
ENDDO
=this.cerrar_planilla()
SELECT cur_articulos
GO TOP

ENDPROC
PROCEDURE grabar
LOCAL loTherm
LOCAL i

loTherm = CREATEOBJECT("_thermometer")

loTherm.Show()
i = 0
SELECT cur_articulos
GO TOP
DO WHILE !EOF("cur_articulos")
	
	goConn.BeginTransaction()
	IF !this.verificar_marca() THEN
		IF !this.insertar_marca() THEN
			MESSAGEBOX("Error al insertar una marca", 0+48, "Actualizacion artículos de artículos...")
			goConn.Rollback()
			RETURN .F.
		ENDIF
	ENDIF

	IF cur_articulos.esNuevo THEN
		IF this.ingresar_articulo() = -1 THEN
			MESSAGEBOX("Error al insertar un nuevo artículo", 0+48, "Actualizacion artículos de artículos...")
			goConn.Rollback()
			RETURN .F.
		ENDIF
	ELSE
		IF !this.actualizar_articulo() THEN
			MESSAGEBOX("Error al actualizar un artículo", 0+48, "Actualizacion artículos de artículos...")
			goConn.Rollback()
			RETURN .F.
		ENDIF
	ENDIF
	
	goConn.Commit()
	
	loTherm.Update((i * 100) / RECCOUNT("cur_articulos"), "Actualizando artículos...")
	i = i + 1
	SELECT cur_articulos
	SKIP
ENDDO

loTherm.Complete()
RELEASE loTherm

MESSAGEBOX("El proceso finalizó con éxito", 0+64, "Actualización de artículos")
RETURN .T.
ENDPROC
PROCEDURE verificar_articulo
PARAMETERS tcCodigo

LOCAL loRes
LOCAL lcSql
LOCAL llOk

loRes = CREATEOBJECT("odbc_result")
lcSql = ""
llOk = .F.

lcSql = "CALL upd_artVerify( " + ALLTRIM(STR(this.idprov)) + ", " + ;
	"'" + ALLTRIM(tcCodigo) + "')"
loRes.Cursor_Name = "cur_tmp"
loRes.ActiveConnection = goConn.ActiveConnection
loRes.OpenQuery(lcSql)
SELECT cur_tmp
IF RECCOUNT("cur_tmp") > 0 THEN
	this.id_articulo_actual = cur_tmp.idArticulo
	llOk = .T.
ELSE
	this.id_articulo_actual = -1
	llOk = .F.
ENDIF
loRes.Close_Query()

RETURN llOk

ENDPROC
PROCEDURE ingresar_articulo
LOCAL loCmd
LOCAL loFunciones
LOCAL lcSql
LOCAL lnCosto
LOCAL lnPrVentaMay
LOCAL lnPrVentaMin
LOCAL lnPrFinalMay
LOCAL lnPrFinalMin

loCmd = CREATEOBJECT("odbc_command")
loFunciones = CREATEOBJECT("funciones")
lcSql = ""
lnCosto = loFunciones.calcular_costo(cur_articulos.lista, ;
	this.desc1, this.desc2, this.desc3, this.desc4, 0)
lnPrVentaMay = loFunciones.Calcular_Venta(lnCosto, this.margenmay)
lnPrVentaMin = loFunciones.Calcular_Venta(lnCosto, this.margenmin)
lnPrFinalMay = lnPrVentaMay + (lnPrVentaMay * (this.alic_iva / 100))
lnPrFinalMin = lnPrVentaMin + (lnPrVentaMin * (this.alic_iva / 100))

lcSql = "CALL upd_artInsert (" + ;
	+ ALLTRIM(STR(this.idprov)) + ", " ;
	+ "1, 1, " + ALLTRIM(STR(this.idmarca_actual)) + ", " ;
	+ "'" + ALLTRIM(cur_articulos.codArt) + "', " ;
	+ "'" + ALLTRIM(cur_articulos.codArt) + "', " ;
	+ "'" + STRTRAN(ALLTRIM(cur_articulos.articulo), "'", "''") + "', " + ;
	+ "21, 0, 0, " + ALLTRIM(STR(cur_articulos.lista, 10, 2)) + ", " ;
	+ ALLTRIM(STR(this.desc1, 10, 2)) + ", " ;
	+ ALLTRIM(STR(this.desc2, 10, 2)) + ", " ;
	+ ALLTRIM(STR(this.desc3, 10, 2)) + ", " ;
	+ ALLTRIM(STR(this.desc4, 10, 2)) + ", " ;
	+ ALLTRIM(STR(lnCosto, 10, 2)) + ", " ;
	+ ALLTRIM(STR(this.margenmay, 10, 2)) + ", " ;
	+ ALLTRIM(STR(this.margenmin, 10, 2)) + ", " ;
	+ ALLTRIM(STR(lnPrVentaMay, 10, 2)) + ", " ;
	+ ALLTRIM(STR(lnprVentaMin, 10, 2)) + ", " ;
	+ ALLTRIM(STR(lnPrFinalMay, 10, 2)) + ", " ;
	+ ALLTRIM(STR(lnPrFinalMin, 10, 2)) + ", " ;
	+ IIF(cur_articulos.esNuevo, "1", "0") + ", " ;
	+ "1, '" + ALLTRIM(gcCodUsu) + "', " ;
	+ "'" + SYS(0) + "')"

loCmd.ActiveConnection = goConn.ActiveConnection
loCmd.CommandText = lcSql
IF !loCmd.Execute() THEN
	RETURN -1
ENDIF

RETURN 0

ENDPROC
PROCEDURE obtener_porcentajes
LOCAL loRes
LOCAL lcSql

IF This.usar_descuentos_existente() .OR. this.usar_margenes_existentes() THEN
	lcSql = "CALL upd_getPorcentajes ( " + ALLTRIM(STR(this.idprov)) + ")"
	loRes = CREATEOBJECT("odbc_result")
	loRes.Cursor_Name = "cur_tmp"
	loRes.ActiveConnection = goConn.ActiveConnection
	loRes.OpenQuery(lcSql)
	SELECT cur_tmp
	IF This.usar_descuentos_existente() THEN
		this.desc1 = cur_tmp.bonif1
		this.desc2 = cur_tmp.bonif2
		this.desc3 = cur_tmp.bonif3
		this.desc4 = cur_tmp.bonif4
	ENDIF
	IF This.usar_margenes_existentes() THEN
		this.margenmay = cur_tmp.margenMax
		this.margenmin = cur_tmp.margenMin
	ENDIF
	loRes.Close_Query()
ENDIF
ENDPROC
PROCEDURE usar_descuentos_existente
IF this.desc1 = 0 .AND. this.desc1 = 0 ;
	.AND. this.desc3 = 0 .AND. this.desc4 = 0 THEN
	RETURN .T.
ELSE
	RETURN .F.
ENDIF
ENDPROC
PROCEDURE usar_margenes_existentes
IF this.margenmay = 0 .AND. this.margenmin = 0 THEN
	RETURN .T.
ELSE
	RETURN .F.
ENDIF
ENDPROC
PROCEDURE verificar_marca
LOCAL loRes
LOCAL lcSql

loRes = CREATEOBJECT("odbc_result")
lcSql = ""

lcSql = "CALL upd_marcasVerify ('" + ALLTRIM(cur_articulos.linea) + "')"
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_tmp"
loRes.OpenQuery(lcSql)
SELECT cur_tmp
IF RECCOUNT("cur_tmp") > 0 THEN
	this.idmarca_actual = cur_tmp.idMarca
	loRes.Close_Query()
	RETURN .T.
ELSE
	this.idmarca_actual = -1
	loRes.Close_Query()
	RETURN .F.
ENDIF
ENDPROC
PROCEDURE insertar_marca
LOCAL loRes
LOCAL lcSql

loREs = CREATEOBJECT("odbc_result")
lcSql = ""
lcSql = "CALL upd_marcaInsert (?descripcio, ?usuAlta, ?idHostAlta)"
lcSql = loRes.AddParameter(lcSql, "descripcio", ALLTRIM(cur_articulos.linea), .t., .f.)
lcSql = loRes.AddParameter(lcSql, "usuAlta", ALLTRIM(gcCodUsu), .t., .f.)
lcSql = loRes.AddParameter(lcSql, "idHostAlta", ALLTRIM(SYS(0)), .t., .f.)

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"
IF !loRes.OpenQuery(lcSql) THEN
	RETURN .F.
ENDIF
SELECT cur_x
this.idmarca_actual = cur_x.proxID
loRes.Close_Query()
RETURN .t.

ENDPROC
PROCEDURE actualizar_articulo
LOCAL loCmd
LOCAL loFunciones
LOCAL lcSql
LOCAL lnCosto
LOCAL lnPrVentaMay
LOCAL lnPrVentaMin
LOCAL lnPrFinalMay
LOCAL lnPrFinalMin

loCmd = CREATEOBJECT("odbc_command")
loFunciones = CREATEOBJECT("funciones")
lcSql = ""
lnCosto = loFunciones.calcular_costo(cur_articulos.lista, ;
	this.desc1, this.desc2, this.desc3, this.desc4, 0)
lnPrVentaMay = loFunciones.Calcular_Venta(lnCosto, this.margenmay)
lnPrVentaMin = loFunciones.Calcular_Venta(lnCosto, this.margenmin)
lnPrFinalMay = lnPrVentaMay + (lnPrVentaMay * (this.alic_iva / 100))
lnPrFinalMin = lnPrVentaMin + (lnPrVentaMin * (this.alic_iva / 100))

lcSql = "CALL upd_artUpdate ( " + ;
	ALLTRIM(STR(cur_articulos.idArticulo)) + ", " + ;
	ALLTRIM(STR(cur_articulos.lista, 10, 2)) + ", " + ;
	ALLTRIM(STR(this.desc1, 10, 2)) + ", " + ;
	ALLTRIM(STR(this.desc2, 10, 2)) + ", " + ;
	ALLTRIM(STR(this.desc3, 10, 2)) + ", " + ;
	ALLTRIM(STR(this.desc4, 10, 2)) + ", " + ;
	ALLTRIM(STR(lnCosto, 10, 2)) + ", " + ;
	ALLTRIM(STR(this.margenmay, 10, 2)) + ", " + ;
	ALLTRIM(STR(this.margenmin, 10, 2)) + ", " + ;
	ALLTRIM(STR(lnPrVentaMay, 10, 2)) + ", " + ;
	ALLTRIM(STR(lnPrVentaMin, 10, 2)) + ", " + ;
	ALLTRIM(STR(lnPrFinalMay, 10, 2)) + ", " + ;
	ALLTRIM(STR(lnPrFinalMin, 10, 2)) + ", " + ;
	ALLTRIM(STR(this.idmarca_actual)) + ", " + ;
	"'" + ALLTRIM(gcCodUsu) + "', " + ;
	"'" + SYS(0) + "')"
	
loCmd.ActiveConnection = goConn.ActiveConnection
loCmd.CommandText = lcSql
RETURN loCmd.Execute()
ENDPROC
PROCEDURE calcular_costo
&& Nombre del programa: calcular_costo
&& Calcula el costo de reposición

PARAMETERS tf_PrLista,; 
	tf_Bonif1, tf_Bonif2, tf_Bonif3,;
	tf_Bonif4, tf_PorGtos

LOCAL lfCosto1, lfCosto2,; 
	lfCosto3, lfCosto4, lfCosto5

lfCosto1 = 0.00
lfCosto2 = 0.00
lfCosto3 = 0.00
lfCosto4 = 0.00
lfCosto5 = 0.00

lfCosto1 = tf_PrLista - (tf_PrLista * tf_Bonif1 / 100)
lfCosto2 = lfCosto1 - (lfCosto1 * tf_Bonif2 / 100)
lfCosto3 = lfCosto2 - (lfCosto2 * tf_Bonif3 / 100)
lfCosto4 = lfCosto3 - (lfCosto3 * tf_Bonif4 / 100)
lfCosto5 = lfCosto4 + (lfCosto4 * tf_PorGtos / 100)

RETURN ROUND(lfCosto5, 2)
ENDPROC
PROCEDURE importar_planilla
PARAMETERS tcFileName

LOCAL lnFila
LOCAL lcCodigo
LOCAL loCmd

loCmd = CREATEOBJECT("odbc_command")
goConn.BeginTransaction()
loCmd.ActiveConnection = goConn.ActiveConnection
loCmd.CommandText = "DELETE FROM updtemp_franse"
IF !loCmd.Execute() THEN
	goConn.Rollback()
ELSE
	goConn.Commit()
ENDIF

=this.abrir_planilla(tcFileName)
lnFila = 4
DO WHILE !(ALLTRIM(this.obtener_valor_celda(lnFila, 1)) == "")
	lcCodigo = ALLTRIM(this.obtener_valor_celda(lnFila, 2)) ;
		+ ALLTRIM(this.obtener_valor_celda(lnFila, 4))
	IF !ISNULL(lcCodigo) THEN
		loCmd.CommandText = "INSERT INTO updtemp_franse ( ";
			+ "stock, codigo, codArt, articulo, linea, rubro, venta, lista, ";
			+ "bonif1, bonif2, bonif3, bonif4, margenMax, margenMin, costo, esNuevo)";
			+ "VALUES ( ";
			+ "'" + ALLTRIM(this.obtener_valor_celda(lnFila, 1)) + "', ";
			+ "'" + ALLTRIM(this.obtener_valor_celda(lnFila, 2)) + "', ";
			+ "'" + ALLTRIM(lcCodigo) + "', ";
			+ "'" + ALLTRIM(this.obtener_valor_celda(lnFila, 3)) + "', ";
			+ "'" + ALLTRIM(this.obtener_valor_celda(lnFila, 4)) + "', ";
			+ "'" + ALLTRIM(this.obtener_valor_celda(lnFila, 5)) + "', ";
			+ "'" + ALLTRIM(STR(this.obtener_valor_celda(lnFila, 6), 10, 2)) + "', ";
			+ ALLTRIM(STR(this.obtener_valor_celda(lnFila, 7), 10, 2)) + ", ";
			+ ALLTRIM(STR(this.desc1, 10, 2)) + ", ";
			+ ALLTRIM(STR(this.desc2, 10, 2)) + ", ";
			+ ALLTRIM(STR(this.desc3, 10, 2)) + ", ";
			+ ALLTRIM(STR(this.desc4, 10, 2)) + ", ";
			+ ALLTRIM(STR(this.margenmay, 10, 2)) + ", ";
			+ ALLTRIM(STR(this.margenmin, 10, 2)) + ", ";
			+ ALLTRIM(STR(this.obtener_valor_celda(lnFila, 8), 10, 2)) + ", ";
			+ "1)"
			
		goConn.BeginTransaction
		loCmd.ActiveConnection = goConn.ActiveConnection
		IF !loCmd.Execute() THEN
			goConn.Rollback()
		ELSE
			goConn.Commit()
		ENDIF
	ENDIF
	
	WAIT WINDOW ALLTRIM(STR(lnFila - 4)) NOWAIT
	lnFila = lnFila + 1
ENDDO
=this.cerrar_planilla()
SELECT cur_articulos
GO TOP
ENDPROC
PROCEDURE insertar_codiart
PARAMETERS tnIdArticulo

LOCAL loCmd
LOCAL lcSql
LOCAL lnProxID

lnProxID = goConn.GetNextID("codiart", "idCodArt")

lcSql = "INSERT INTO codiart ( " ;
	+ "idCodArt, idArticulo, codArt, codigos, tipo, cantiDesp, procesado, circuito)" ;
	+ "VALUES ( " + ALLTRIM(STR(lnProxID)) + ", " ;
	+ ALLTRIM(STR(tnIdArticulo)) + ", " ;
	+ "'" + ALLTRIM(cur_articulos.codArt) + "', " ;
	+ "'" + ALLTRIM(cur_articulos.codArt) + "', " ;
	+ "'CP', 1, 0, 'CV')"
	
loCmd = CREATEOBJECT("odbc_command")
loCmd.CommandText = lcSql
loCmd.ActiveConnection = goConn.ActiveConnection
loCmd.Execute()
ENDPROC
PROCEDURE formatear_codigo
PARAMETERS tCodigo

LOCAL lcResultado

lcResultado = ""
IF TYPE("tCodigo") == "N" THEN
	lcResultado = STRTRAN(ALLTRIM(STR(tCodigo)), " ", "")
ELSE
	lcResultado = ALLTRIM(tCodigo)
ENDIF

RETURN lcResultado
ENDPROC
PROCEDURE formatear_precio
PARAMETERS tPrecio

LOCAL lnPrecio

lnPrecio = 0.00

IF ISNULL(tPrecio) THEN
	lnPrecio = 0.00
ELSE
	IF TYPE("tPrecio") == "C" THEN
		IF ALLTRIM(tPrecio) == "" THEN
			lnPrecio = 0.00
		ELSE
			lnPrecio = VAL(tPrecio)
		ENDIF
	ELSE
		lnPrecio = tPrecio
	ENDIF
ENDIF

RETURN lnPrecio
ENDPROC
PROCEDURE formatear_descripcion
PARAMETERS tDescripcion

LOCAL lcDescripcion

lcDescripcion = ""
IF ISNULL(tDescripcion) THEN
	lcDescripcion = "SIN DESCRIPCION"
ELSE
	IF ALLTRIM(tDescripcion) == "" THEN
		lcDescripcion = "SIN DESCRIPCION"
	ELSE
		lcDescripcion = tDescripcion
	ENDIF
ENDIF

RETURN lcDescripcion
ENDPROC
PROCEDURE art_upd_temp_limpiar
LOCAL loRes
LOCAL lcSql

loRes = CREATEOBJECT("odbc_result")
lcSql = ""

lcSql = "CALL art_upd_tempo_limpiar (?idProv)"
lcSql = loRes.AddParameter(lcSql, "idProv", ALLTRIM(STR(this.idprov)), .f., .f.)
loRes.Cursor_Name = "resultado"
loRes.ActiveConnection = goConn.ActiveConnection
loRes.OpenQuery(lcSql)
llOk = IIF(VAL(resultado.result) = 1, .T., .F.)
loRes.Close_Query()
IF !llOk THEN
	this.mensaje = "Error al intentar limpiar los datos temporales"
	RETURN .F.
ENDIF

RETURN .T.

ENDPROC
PROCEDURE art_upd_temp_procesar
LOCAL loRes
LOCAL lcSql

loRes = CREATEOBJECT("odbc_result")
lcSql = ""

WAIT WINDOW "Procesando registros temporales, espere por favor..." NOWAIT
lcSql = "CALL art_upd_tempo_procesar (?pIdProv, " ;
	+ "?pBonif1, ?pBonif2, ?pBonif3, ?pBonif4, ?pMargenMax, ?pMargenMin)"
lcSql = loRes.AddParameter(lcSql, "pIdProv", ALLTRIM(STR(this.idprov)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "pBonif1", ALLTRIM(STR(this.desc1, 10, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "pBonif2", ALLTRIM(STR(this.desc2, 10, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "pBonif3", ALLTRIM(STR(this.desc3, 10, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "pBonif4", ALLTRIM(STR(this.desc4, 10, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "pMargenMax", ALLTRIM(STR(this.margenmay, 10, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "pMargenMin", ALLTRIM(STR(this.margenmin, 10, 2)), .f., .f.)
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_res"
loRes.OpenQuery(lcSql)
llOk = IIF(VAL(cur_res.result) = 1, .T., .F.)
loRes.Close_Query()
IF !llOk THEN
	this.mensaje = "Error al procesar los registros temporales"
	RETURN .F.
ENDIF
WAIT WINDOW "Listo..." NOWAIT

RETURN .T.
ENDPROC
PROCEDURE art_upd_temp_leer
LOCAL loRes
LOCAL lcSql

loRes = CREATEOBJECT("odbc_result")
lcSql = ""

lcSql = "CALL art_upd_tempo_getByPv (?pIdProv)"
lcSql = loRes.AddParameter(lcSql, "pIdProv", ALLTRIM(STR(this.idprov)), .f., .f.)
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_temp"
loRes.OpenQuery(lcSql)
SELECT cur_articulos
APPEND FROM DBF("cur_temp")
loRes.Close_Query()

SELECT cur_articulos
GO TOP
ENDPROC


************************************************************
OBJETO: cls_updater_net_artedit
************************************************************
*** PROPIEDADES ***
DataSession = 1
BorderStyle = 2
Height = 295
Width = 667
DoCreate = .T.
Caption = "Editor de artículos nuevos"
Name = "cls_updater_net_artedit"

*** METODOS ***
PROCEDURE validar_datos
IF ALLTRIM(thisform.txtCodigo.Value) == "" THEN
	MESSAGEBOX("Debe ingresar el código de artículo", 0+48, Thisform.Caption)
	thisform.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

IF ALLTRIM(thisform.txtDescripcion.Value) == "" THEN
	MESSAGEBOX("Debe ingresar la descripción del producto", 0+48, Thisform.Caption)
	thisform.txtDescripcion.SetFocus()
	RETURN .F.
ENDIF

IF Thisform.sel_Familia.valcpoid = 0 THEN
	MESSAGEBOX("Debe asignar una familia", 0+48, Thisform.Caption)
	Thisform.sel_Familia.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

IF Thisform.sel_SubFamilia.valcpoid = 0 THEn
	MESSAGEBOX("Debe asignar una subfamilia", 0+48, Thisform.Caption)
	Thisform.sel_subFamilia.SetFocus()
	RETURN .F.
ENDIF

RETURN .T.
ENDPROC
PROCEDURE recupear_datos
SELECT art_tempo
Thisform.txtCodigo.Value = art_tempo.codArt
Thisform.txtDescripcion.Value = art_tempo.descripcio
Thisform.txtCodArtPV.Value = art_tempo.codArtPV
Thisform.txtAlicIVA.Value = art_tempo.alicIVA

ENDPROC
PROCEDURE grabar_continuar
LOCAL loCmd

loCmd = CREATEOBJECT("odbc_command")
loCmd.ActiveConnection = goConn.ActiveConnection
loCmd.CommandText = "CALL upd_ArtTempUpdate(" ;
		+ "?idFamilia, " ;
		+ "?idSubFam, " ;
		+ "?idMarca, " ;
		+ "?codigo, " ;
		+ "?codArtPV, " ;
		+ "?descripcio, " ;
		+ "?alicIVA, " ;
		+ "?prListaPV, " ;
		+ "?bonif1, " ;
		+ "?bonif2, " ;
		+ "?bonif3, " ;
		+ "?bonif4, " ;
		+ "?costoRep, " ;
		+ "?margenMay, " ;
		+ "?margenMin, " ;
		+ "?prVentaMay, " ;
		+ "?prVentaMin, " ;
		+ "0)"
loCmd.AddParameter("idFamilia", ALLTRIM(STR(thisform.sel_Familia.valcpoid)), .f., .f.)
loCmd.AddParameter("idSubFam", ALLTRIM(STR(thisform.sel_subFamilia.valcpoid)), .f., .f.)
loCmd.AddParameter("idMarca", ALLTRIM(STR(thisform.sel_marca.valcpoid)), .f., .f.)
loCmd.AddParameter("codigo", ALLTRIM(thisform.txtCodigo.Value), .t., .f.)
loCmd.AddParameter("codArtPV", ALLTRIM(thisform.txtCodArtPV.Value), .t., .f.)
loCmd.AddParameter("descripcio", ALLTRIM(thisform.txtDescripcion.Value), .t., .f.)
loCmd.AddParameter("alicIVA", ALLTRIM(STR(thisform.txtAlicIVA.Value, 10, 2)), .f., .f.)
loCmd.AddParameter("prListaPV", ALLTRIM(STR(art_tempo.prListaPV, 10, 2)), .f., .f.)
loCmd.AddParameter("bonif1", ALLTRIM(STR(art_tempo.bonif1, 10, 2)), .f., .f.)
loCmd.AddParameter("bonif2", ALLTRIM(STR(art_tempo.bonif2, 10, 2)), .f., .f.)
loCmd.AddParameter("bonif3", ALLTRIM(STR(art_tempo.bonif3, 10, 2)), .f., .f.)
loCmd.AddParameter("bonif4", ALLTRIM(STR(art_tempo.bonif4, 10, 2)), .f., .f.)
loCmd.AddParameter("costoRep", ALLTRIM(STR(art_tempo.costoRep, 10, 2)), .f., .f.)
loCmd.AddParameter("margenMay", ALLTRIM(STR(art_tempo.margenMay, 10, 2)), .f., .f.)
loCmd.AddParameter("margenMin", ALLTRIM(STR(art_tempo.margenMin, 10, 2)), .f., .f.)
loCmd.AddParameter("prVentaMay", ALLTRIM(STR(art_tempo.prVentaMay, 10, 2)), .f., .f.)
loCmd.AddParameter("prVentaMin", ALLTRIM(STR(art_tempo.prVentaMin, 10, 2)), .f., .f.)
IF !loCmd.Execute() THEN
	MESSAGEBOX(loCmd.ErrorMessage, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT art_tempo
thisform.actualizar_cursor()
SKIP

IF EOF("art_tempo") THEN
	MESSAGEBOX("Ha llegado al final de la lista", 0+64, Thisform.Caption)
ENDIF
thisform.recupear_datos()

RETURN .T.

ENDPROC
PROCEDURE actualizar_cursor
SELECT art_tempo
LOCK()
REPLACE art_tempo.codArt WITH ALLTRIM(thisform.txtCodigo.Value)
REPLACE art_tempo.descripcio WITH ALLTRIM(thisform.txtDescripcion.Value) ADDITIVE
REPLACE art_tempo.idFamilia WITH thisform.sel_Familia.valcpoid ADDITIVE
REPLACE art_tempo.idSubFam WITH thisform.sel_SubFamilia.valcpoid ADDITIVE
REPLACE art_tempo.idMarca WITH thisform.sel_Marca.valcpoid ADDITIVE
REPLACE art_tempo.alicIVA WITH thisform.txtAlicIVA.Value ADDITIVE
UNLOCK
ENDPROC
PROCEDURE Init
thisform.recupear_datos()
ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Código:"
Height = 15
Left = 67
Top = 11
Width = 47
TabIndex = 10
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Descripción:"
Height = 15
Left = 42
Top = 35
Width = 73
TabIndex = 11
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: txtCodigo
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 120
MaxLength = 20
TabIndex = 1
Top = 6
Width = 191
Name = "txtCodigo"

*** METODOS ***


************************************************************
OBJETO: txtDescripcion
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 120
MaxLength = 200
TabIndex = 2
Top = 30
Width = 510
Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: btnGrabar
************************************************************
*** PROPIEDADES ***
Top = 234
Left = 422
Height = 44
Width = 160
Caption = "Grabar y continuar"
TabIndex = 8
Name = "btnGrabar"

*** METODOS ***
PROCEDURE Click
IF !thisform.validar_datos() THEN
	RETURN
ENDIF

thisform.grabar_continuar()
thisform.txtCodigo.SetFocus()
ENDPROC


************************************************************
OBJETO: Clscerrar1
************************************************************
*** PROPIEDADES ***
Top = 234
Left = 585
TabIndex = 9
Name = "Clscerrar1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Cód. proveedor:"
Height = 15
Left = 21
Top = 58
Width = 95
TabIndex = 12
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: txtCodArtPV
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 120
MaxLength = 20
ReadOnly = .T.
TabIndex = 3
Top = 54
Width = 191
Name = "txtCodArtPV"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Familia:"
Height = 15
Left = 69
Top = 82
Width = 44
TabIndex = 13
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta6
************************************************************
*** PROPIEDADES ***
Caption = "SubFamilia:"
Height = 15
Left = 48
Top = 106
Width = 65
TabIndex = 14
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: sel_Familia
************************************************************
*** PROPIEDADES ***
Top = 76
Left = 118
Width = 516
Height = 25
TabIndex = 4
nombre_tabla = familias
nombre_campo_codigo = idfamilia
nombre_campo_desc = descripcio
cfieldname = idfamilia
esnumerico = .T.
pkfield = idfamilia
msgerror = Debe seleccionar una Familia
criterio_filtro = familias.fecBaja IS NULL
Name = "sel_Familia"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Height = 21
txtDescripcion.Left = 106
txtDescripcion.Top = 2
txtDescripcion.Width = 406
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: Sel_SubFamilia
************************************************************
*** PROPIEDADES ***
Top = 100
Left = 118
Width = 518
Height = 25
TabIndex = 5
nombre_tabla = subfam
nombre_campo_codigo = idsubfam
nombre_campo_desc = descripcio
cfieldname = idsubfam
esnumerico = .T.
pkfield = idsubfam
msgerror = Debe seleccionar una SubFamilia
criterio_filtro = subfam.fecBaja IS NULL
Name = "Sel_SubFamilia"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Height = 21
txtDescripcion.Left = 106
txtDescripcion.Top = 2
txtDescripcion.Width = 406
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Alic. I.V.A.:"
Height = 15
Left = 54
Top = 152
Width = 60
TabIndex = 15
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: txtAlicIVA
************************************************************
*** PROPIEDADES ***
Left = 120
TabIndex = 7
Top = 148
isnumeric = .T.
Name = "txtAlicIVA"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta7
************************************************************
*** PROPIEDADES ***
Caption = "Marca:"
Height = 15
Left = 73
Top = 128
Width = 44
TabIndex = 16
Name = "Clsetiqueta7"

*** METODOS ***


************************************************************
OBJETO: Sel_Marca
************************************************************
*** PROPIEDADES ***
Top = 123
Left = 118
Width = 528
Height = 25
TabIndex = 6
nombre_tabla = marcas
nombre_campo_codigo = idmarca
nombre_campo_desc = descripcio
cfieldname = idmarca
esnumerico = .T.
pkfield = idmarca
msgerror = Debe seleccionar una Marca
criterio_filtro = marcas.fecBaja IS NULL
Name = "Sel_Marca"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Height = 21
txtDescripcion.Left = 106
txtDescripcion.Top = 2
txtDescripcion.Width = 406
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: cls_updater_net_artedit
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: updater_net
************************************************************
*** PROPIEDADES ***
nombre_archivo = 
mensaje = 
nombre_archivo_local = 
grabar_nuevos = .F.
Name = "updater_net"

*** METODOS ***
PROCEDURE descargar_csv
LOCAL lcURL

lcURL = getGlobalCFG("UPDFILEURL") + ALLTRIM(this.nombre_archivo)
this.nombre_archivo_local = getGlobalCFG("UPDTMPPATH") + "\" + ALLTRIM(this.nombre_archivo)
=VFPHTTP(lcURL, this.nombre_archivo_local)
this.mensaje = "Archivo descargado"
ENDPROC
PROCEDURE grabar
LOCAL loRes
LOCAL lcSql
LOCAL lcResult

loRes = CREATEOBJECT("odbc_result")
lcSql = "CALL upd_actualizar (?idProv, ?usuario, ?idHost)"
lcSql = loRes.AddParameter(lcSql, "idProv", ALLTRIM(STR(This.idprov)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "usuario", ALLTRIM(gcCodUsu), .t., .f.)
lcSql = loRes.AddParameter(lcSql, "idHost", ALLTRIM(SYS(0)), .t., .f.)
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_res"
loRes.OpenQuery(lcSql)
lcResult = cur_res.result
loRes.Close_Query()
IF !(ALLTRIM(lcResult) == "OK") THEN
	this.mensaje = lcResult
	RETURN .F.
ENDIF

this.mensaje = "Los artículos se actualizaron satisfactoriamente"
RETURN .T.
ENDPROC
PROCEDURE copiar_planilla_a_cursor
PARAMETERS tcFileName

LOCAL loRes
LOCAL lcSql
LOCAL lnFile
LOCAL lcLinea
LOCAL lcCodigo
LOCAL lcDescripcion
LOCAL lnLista
LOCAL lnIndex
LOCAL llEsNuevo
LOCAL lnFile
LOCAL llOk

loRes = CREATEOBJECT("odbc_result")
lcSql = ""
lcCodigo = ""
lcDescripcion = ""
lnLista = 0.00
lnIndex = 0
llEsNuevo = .f.
llOk = .f.

IF !this.art_upd_temp_limpiar() THEN
	RETURN .F.
ENDIF

this.descargar_csv()
tcFileName = this.nombre_archivo_local
lnFile = FOPEN(tcFileName)
IF lnFile < 0 THEN
	this.mensaje = "Error al abrir el archivo"
	RETURN .f.
ENDIF

lcLinea = FGETS(lnFile)
DO WHILE !FEOF(lnFile)
	WAIT WINDOW "Procesando línea nº " + ALLTRIM(STR(lnIndex)) NOWAIT
	lcCodigo = ALLTRIM(GETWORDNUM(lcLinea, 1, "|"))
	lcDescripcion = ALLTRIM(GETWORDNUM(lcLinea, 2, "|"))
	lcDescripcion = IIF(ALLTRIM(lcDescripcion) == "", "SIN DESCRIPCION", lcDescripcion)
	lnLista = VAL(GETWORDNUM(lcLinea, 3, "|"))

	lcSql = "call art_upd_tempo_insert ( " ;
		+ "?pIdArticulo, ?pIdProv, ?pStock, ?pCodigo, " ;
		+ "?pCodArt, ?pArticulo, ?pLinea, ?pRubro, ?pVenta, ?pLista, ?pCosto)"
	lcSql = loRes.AddParameter(lcSql, "pIdArticulo", ALLTRIM(STR(this.id_articulo_actual)), .f., .f.)
	lcSql = loRes.AddParameter(lcSql, "pIdProv", ALLTRIM(STR(this.idprov)), .f., .f.)
	lcSql = loRes.AddParameter(lcSql, "pStock", "NADA", .t., .f.)
	lcSql = loRes.AddParameter(lcSql, "pCodigo", ALLTRIM(lcCodigo), .t., .f.)
	lcSql = loRes.AddParameter(lcSql, "pCodArt", ALLTRIM(lcCodigo), .t., .f.)
	lcSql = loRes.AddParameter(lcSql, "pArticulo", ALLTRIM(lcDescripcion), .t., .f.)
	lcSql = loRes.AddParameter(lcSql, "pLinea", "NADA", .t., .f.)
	lcSql = loRes.AddParameter(lcSql, "pRubro", "NADA", .t., .f.)
	lcSql = loRes.AddParameter(lcSql, "pVenta", "0", .f., .f.)
	lcSql = loRes.AddParameter(lcSql, "pLista", ALLTRIM(STR(lnLista, 10, 2)), .f., .f.)
	lcSql = loRes.AddParameter(lcSql, "pCosto", "0", .f., .f.)
	loRes.ActiveConnection = goConn.ActiveConnection
	loRes.Cursor_Name = "cur_res"
	loRes.OpenQuery(lcSql)
	llOk = IIF(VAL(cur_res.result) = 1, .T., .F.)
	loRes.Close_Query()
	IF !llOk THEN
		this.mensaje = "Ha ocurrido un error al generar el registro temporal del artículo"
		RETURN .F.
	ENDIF
	
	lnIndex = lnIndex + 1
	lcLinea = FGETS(lnFile)
ENDDO

FCLOSE(lnFile)

IF !this.art_upd_temp_procesar() THEN
	RETURN .F.
ENDIF

this.art_upd_temp_leer()

RETURN .T.
ENDPROC


************************************************************
OBJETO: cls_updater_net_artnuevos
************************************************************
*** PROPIEDADES ***
Height = 586
Width = 946
DoCreate = .T.
Caption = "Artículos nuevos"
MaxButton = .T.
MinButton = .T.
WindowState = 2
Name = "cls_updater_net_artnuevos"
CONTENIDO.Top = -1
CONTENIDO.Left = -1
CONTENIDO.Width = 948
CONTENIDO.Height = 587
CONTENIDO.Name = "CONTENIDO"

*** METODOS ***
PROCEDURE leer_pendientes
LOCAL loRes
LOCAL lcSql

loRes = CREATEOBJECT("odbc_result")
lcSql = "CALL upd_ArtNuevosLeerPend( ?idProv )"
lcSql = loRes.AddParameter(lcSql, "idProv", ALLTRIM(STR(thisform.contenido.sel_proveedor.valcpoid)), .f., .f.)
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"
loRes.OpenQuery(lcSql)
SELECT cur_x
GO TOP
SELECT art_tempo
ZAP
APPEND FROM DBF("cur_x")
loRes.Close_Query()
SELECT art_tempo
GO TOP
thisform.contenido.grdArticulos.Refresh()
ENDPROC
PROCEDURE grabar_temporal
LOCAL loRes
LOCAL lcSql
LOCAL lcResult

loRes = CREATEOBJECT("odbc_result")
lcSql = "CALL upd_ArtNuevosProcesar (?idProv, ?bonif1, ?bonif2, ?bonif3, ?bonif4, " ;
		+ "?margenMay, ?margenMin)"
lcSql = loRes.AddParameter(lcSql, "idProv", ALLTRIM(STR(Thisform.contenido.sel_proveedor.valcpoid)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "bonif1", ALLTRIM(STR(Thisform.contenido.txtBonif1.Value, 10, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "bonif2", ALLTRIM(STR(Thisform.contenido.txtBonif2.Value, 10, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "bonif3", ALLTRIM(STR(Thisform.contenido.txtBonif3.value, 10, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "bonif4", ALLTRIM(STR(Thisform.contenido.txtBonif4.Value, 10, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "margenMay", ALLTRIM(STR(Thisform.contenido.txtMargenMay.Value, 10, 2)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "margenMin", ALLTRIM(STR(Thisform.contenido.txtMargenMin.Value, 10, 2)), .f., .f.)
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_res"
loRes.OpenQuery(lcSql)
SELECT cur_res
lcResult = cur_res.result
loRes.Close_Query()
IF !(ALLTRIM(lcResult) == "OK") THEN
	MESSAGEBOX(lcResult, 0+48, Thisform.Caption)
ENDIF

ENDPROC
PROCEDURE grabar_articulos
LOCAL loRes
LOCAL lcSql
LOCAL lcResult

WAIT WINDOW "Dando de alta artículos, espere por favor..." NOWAIT
loRes = CREATEOBJECT("odbc_result")
lcSql = "CALL upd_ArtNuevoGrabar (?idProv, ?usuario, ?idHost)"
lcSql = loRes.AddParameter(lcSql, "idProv", ALLTRIM(STR(Thisform.contenido.sel_proveedor.valcpoid)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "usuario", ALLTRIM(gcCodUsu), .t., .f.)
lcSql = loRes.AddParameter(lcSql, "idHost", ALLTRIM(SYS(0)), .t., .f.)
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_res"
loRes.OpenQuery(lcSql)
lcResult = cur_res.result
loRes.Close_Query()
IF !(ALLTRIM(lcResult) == "OK") THEN
	MESSAGEBOX(lcResult, 0+48, Thisform.Caption)
	RETURN .F.
ELSE
	MESSAGEBOX("Los artículos se dieron de alta satisfactoriamente", 0+64, Thisform.Caption)
	Thisform.limpiar()
	RETURN .T.
ENDIF

ENDPROC
PROCEDURE validar_datos
SELECT art_tempo
IF art_tempo.idFamilia = 0 THEN
	MESSAGEBOX("El artículo: " + ALLTRIM(art_tempo.codArt) + " no tiene familia asignada", 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

IF art_tempo.idSubFam = 0 THEN
	MESSAGEBOX("El artículo: " + ALLTRIM(art_tempo.codArt) + " no tiene subfamilia asignada", 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

RETURN .T.
ENDPROC
PROCEDURE Init
SELECT art_tempo
thisform.contenido.grdArticulos.RecordSourceType = 1
thisform.contenido.grdArticulos.alias_name = "art_tempo"
thisform.contenido.grdArticulos.RecordSource = "art_tempo"
thisform.contenido.grdArticulos.List_ControlSource = "codArt," ;
		+ "codArtPV, " ;
		+ "descripcio," ;
		+ "prListaPV," ;
		+ "bonif1," ;
		+ "bonif2," ;
		+ "bonif3," ;
		+ "bonif4," ;
		+ "costoRep, ";
		+ "margenMay," ;
		+ "prVentaMay, ";
		+ "margenMin," ;
		+ "prVentaMin"

thisform.contenido.grdArticulos.Lista_ancho_cols = "100,100,300,70,70,70,70,70,70,70,70,70,70"
thisform.contenido.grdArticulos.Titulos_Cabeceras = "Código," ;
		+ "Cód.Prov.," ;
		+ "Descripción,";
		+ "Pr. Lista,";
		+ "Bonif.1," ;
		+ "Bonif.2," ;
		+ "Bonif.3," ;
		+ "Bonif.4," ;
		+ "Costo,"	 ;
		+ "Margen May.,";
		+ "Pr.Vta.May.,";
		+ "Margen Min.,";
		+ "Pr.Vta.Min."
thisform.contenido.grdArticulos.generar_grid()
ENDPROC
PROCEDURE Load
DODEFAULT()

CREATE CURSOR art_tempo ( ;
	idArtTempo int not null,;
	idprov int not null,;
	idFamilia int not null,;
	idSubFam int not null,;
	idMarca int not null,;
	codArt varchar(20) not null,;
	codArtPV varchar(20) null,;
	descripcio varchar(200) null,;
	alicIVA double not null,;
	prListaPV double not null,;
	bonif1 double not null,;
	bonif2 double not null,;
	bonif3 double not null,;
	bonif4 double not null,;
	costoRep double not null,;
	margenMay double not null,;
	margenMin double not null,;
	prVentaMay double not null,;
	prVentaMin double not null,;
	procesado L)
INDEX ON codArt TAG codArt ASCENDING
INDEX ON codArtPV TAG codArtPV ASCENDING ADDITIVE
INDEX ON descripcio TAG descripcio ASCENDING ADDITIVE
INDEX ON bonif1 TAG bonif1 ASCENDING ADDITIVE
INDEX ON bonif2 TAG bonif2 ASCENDING ADDITIVE
INDEX ON bonif3 TAG bonif3 ASCENDING ADDITIVE
INDEX ON bonif4 TAG bonif4 ASCENDING ADDITIVE
INDEX ON margenMay TAG margenMay ASCENDING ADDITIVE
INDEX ON margenMin TAG margenMin ASCENDING ADDITIVE
INDEX ON costoRep TAG costoRep ASCENDING ADDITIVE
INDEX ON prVentaMay TAG prVentaMay ASCENDING ADDITIVE
INDEX ON prVentaMIn TAG prVentaMin ASCENDING ADDITIVE
SET ORDER TO TAG codArt ASCENDING

ENDPROC
PROCEDURE limpiar
SELECT art_tempo
ZAP
Thisform.contenido.sel_proveedor.blanquear()
Thisform.contenido.txtBonif1.Value = 0
Thisform.contenido.txtBonif2.Value = 0
Thisform.contenido.txtBonif3.Value = 0
Thisform.contenido.txtBonif4.Value = 0
Thisform.contenido.txtMargenMay.Value = 0
Thisform.contenido.txtMargenMin.Value = 0

ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Anchor = 3
Caption = "Proveedor:"
Left = 13
Top = 13
TabIndex = 9
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: sel_proveedor
************************************************************
*** PROPIEDADES ***
Anchor = 3
Top = 7
Left = 85
TabIndex = 1
nombre_tabla = proveedor
nombre_campo_codigo = idprov
nombre_campo_desc = razSoc
pkfield = idprov
title_cols = Razón Social
autocompletar_ceros = .F.
esnumerico = .T.
Name = "sel_proveedor"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***
PROCEDURE recuperar_datos
thisform.leer_pendientes()
ENDPROC


************************************************************
OBJETO: grdArticulos
************************************************************
*** PROPIEDADES ***
Anchor = 11
Height = 445
Left = 13
TabIndex = 10
Top = 86
Width = 925
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
PROCEDURE press_enter
LOCAL loForm

loForm = CREATEOBJECT("cls_updater_net_artedit")
loForm.show()
ENDPROC


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Anchor = 3
Caption = "Bonificación 1"
Height = 15
Left = 21
Top = 37
Width = 79
TabIndex = 11
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Anchor = 3
Caption = "Bonificación 2"
Height = 15
Left = 135
Top = 37
Width = 79
TabIndex = 12
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Anchor = 3
Caption = "Bonificación 3"
Height = 15
Left = 251
Top = 37
Width = 79
TabIndex = 13
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Anchor = 3
Caption = "Bonificación 4"
Height = 15
Left = 367
Top = 37
Width = 79
TabIndex = 14
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: txtBonif1
************************************************************
*** PROPIEDADES ***
Anchor = 3
Height = 21
Left = 20
TabIndex = 2
Top = 52
Width = 85
isnumeric = .T.
Name = "txtBonif1"

*** METODOS ***


************************************************************
OBJETO: txtBonif2
************************************************************
*** PROPIEDADES ***
Anchor = 3
Height = 21
Left = 136
TabIndex = 3
Top = 52
Width = 85
isnumeric = .T.
Name = "txtBonif2"

*** METODOS ***


************************************************************
OBJETO: txtBonif3
************************************************************
*** PROPIEDADES ***
Anchor = 3
Height = 21
Left = 252
TabIndex = 4
Top = 52
Width = 85
isnumeric = .T.
Name = "txtBonif3"

*** METODOS ***


************************************************************
OBJETO: txtBonif4
************************************************************
*** PROPIEDADES ***
Anchor = 3
Height = 21
Left = 368
TabIndex = 5
Top = 52
Width = 85
isnumeric = .T.
Name = "txtBonif4"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta6
************************************************************
*** PROPIEDADES ***
Anchor = 3
Caption = "Margen mayorista"
Height = 15
Left = 512
Top = 37
Width = 107
TabIndex = 15
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta7
************************************************************
*** PROPIEDADES ***
Anchor = 3
Caption = "Margen minorista"
Height = 15
Left = 627
Top = 37
Width = 107
TabIndex = 16
Name = "Clsetiqueta7"

*** METODOS ***


************************************************************
OBJETO: txtMargenMay
************************************************************
*** PROPIEDADES ***
Anchor = 3
Height = 21
Left = 511
TabIndex = 6
Top = 52
Width = 85
isnumeric = .T.
Name = "txtMargenMay"

*** METODOS ***


************************************************************
OBJETO: txtMargenMin
************************************************************
*** PROPIEDADES ***
Anchor = 3
Height = 21
Left = 628
TabIndex = 7
Top = 52
Width = 85
isnumeric = .T.
Name = "txtMargenMin"

*** METODOS ***


************************************************************
OBJETO: btnGrabar
************************************************************
*** PROPIEDADES ***
Top = 534
Left = 846
Anchor = 12
TabIndex = 17
Name = "btnGrabar"

*** METODOS ***
PROCEDURE Click
thisform.grabar_articulos()

ENDPROC


************************************************************
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 534
Left = 894
Anchor = 12
TabIndex = 18
Name = "btnCerrar"

*** METODOS ***


************************************************************
OBJETO: btnAplicar
************************************************************
*** PROPIEDADES ***
Top = 45
Left = 748
Height = 29
Width = 120
Anchor = 3
Caption = "Procesar"
TabIndex = 8
Name = "btnAplicar"

*** METODOS ***
PROCEDURE Click
*!*	LOCAL loTherm
*!*	LOCAL i

*!*	loTherm = CREATEOBJECT("_thermometer")
*!*	loTherm.show()
*!*	i = 0
*!*	SELECT art_tempo
*!*	GO TOP
*!*	DO WHILE !EOF("art_tempo")
*!*		SELECT art_tempo
*!*		LOCK()
*!*		REPLACE art_tempo.codArt WITH thisform.formatear_codigo(art_tempo.codArtPV)
*!*		REPLACE art_tempo.bonif1 WITH thisform.contenido.txtBonif1.Value ADDITIVE
*!*		REPLACE art_tempo.bonif2 WITH thisform.contenido.txtBonif2.Value ADDITIVE
*!*		REPLACE art_tempo.bonif3 WITH thisform.contenido.txtBonif3.Value ADDITIVE
*!*		REPLACE art_tempo.bonif4 WITH thisform.contenido.txtBonif4.Value ADDITIVE
*!*		REPLACE art_tempo.costoRep WITH calcular_costo(art_tempo.prListaPV, ;
*!*				thisform.contenido.txtBonif1.Value, ;
*!*				thisform.contenido.txtBonif2.Value, ;
*!*				thisform.contenido.txtBonif3.Value, ;
*!*				thisform.contenido.txtBonif4.Value, 0) ADDITIVE
*!*		REPLACE art_tempo.margenMay WITH thisform.contenido.txtMargenMay.Value ADDITIVE
*!*		REPLACE art_tempo.margenMin WITH thisform.contenido.txtMargenMin.Value ADDITIVE
*!*		REPLACE art_tempo.prVentaMay WITH calcular_venta(art_tempo.costoRep, ;
*!*				thisform.contenido.txtMargenMay.Value, 0) ADDITIVE
*!*		REPLACE art_tempo.prVentaMin WITH calcular_venta(art_tempo.costoRep, ;
*!*				thisform.contenido.txtMargenMin.Value, 0) ADDITIVE
*!*		UNLOCK
*!*		thisform.grabar_temporal()
*!*		loTherm.update((i * 100) / RECCOUNT("art_tempo"), "Formateando registros")
*!*		i = i + 1
*!*		SELECT art_tempo
*!*		SKIP
*!*	ENDDO
*!*	loTherm.complete()
*!*	SELECT art_tempo
*!*	GO TOP
*!*	thisform.contenido.grdArticulos.Refresh()

thisform.grabar_temporal()
thisform.leer_pendientes()
SELECT art_tempo
GO TOP
thisform.contenido.grdArticulos.Refresh()
ENDPROC


************************************************************
OBJETO: Clsnew1
************************************************************
*** PROPIEDADES ***
Top = 534
Left = 13
Anchor = 6
TabIndex = 19
Name = "Clsnew1"

*** METODOS ***


************************************************************
OBJETO: cls_updater_net_artnuevos
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_updater_net_form
************************************************************
*** PROPIEDADES ***
BorderStyle = 2
Height = 521
Width = 1151
DoCreate = .T.
Caption = "Actualizador de precios"
o_updater = 
Name = "cls_updater_net_form"

*** METODOS ***
PROCEDURE validar_pendientes
LOCAL loRes
LOCAL lcSql
LOCAL llResult

loRes = CREATEOBJECT("odbc_result")
lcSql = "CALL upd_ArtNuevoTienePend( ?idProv )"
lcSql = loRes.AddParameter(lcSql, "idProv", ALLTRIM(STR(thisform.pages.page1.sel_proveedor.valcpoid)), .f., .f.)
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"
loRes.OpenQuery(lcSql)
llResult = cur_x.result
loRes.Close_Query()
RETURN llResult

ENDPROC
PROCEDURE limpiar
SELECT cur_artnuevos
ZAP
Thisform.pages.page2.grdArticulos.Refresh()
SELECT cur_articulos
ZAP
Thisform.pages.page1.grdVistaPrevia.Refresh()
Thisform.pages.page1.sel_proveedor.blanquear()
Thisform.pages.page1.txtFileName.Value = ""
Thisform.pages.page1.txtFecha.Value = {}
Thisform.pages.page1.txtBonif1.Value = 0
Thisform.pages.page1.txtBonif2.Value = 0
Thisform.pages.page1.txtBonif3.Value = 0
Thisform.pages.page1.txtBonif4.Value = 0
Thisform.pages.page1.txtMargenMay.Value = 0
Thisform.pages.page1.txtMargenMin.Value = 0
Thisform.pages.page1.SetFocus()
ENDPROC
PROCEDURE Init
thisform.o_updater = CREATEOBJECT("updater_net")
thisform.o_updater.crear_cursor()

CREATE CURSOR cur_ArtNuevos ( 	;
	codArt varchar(20), 		;
	descripcio varchar(200),	;
	precio double)
SELECT cur_ArtNuevos
INDEX ON precio TAG precio ASCENDING
INDEX ON descripcio TAG descripcio ASCENDING ADDITIVE
INDEX ON codArt TAG codArt ASCENDING ADDITIVE

SELECT cur_ArtNuevos
thisform.pages.page2.grdArticulos.alias_name = "cur_ArtNuevos"
thisform.pages.page2.grdArticulos.RecordSource = "cur_ArtNuevos"
thisform.pages.page2.grdArticulos.RecordSourceType = 1
thisform.pages.page2.grdArticulos.list_controlsource = "codArt,descripcio,precio"
thisform.pages.page2.grdArticulos.lista_ancho_cols = "150,500,100"
thisform.pages.page2.grdArticulos.titulos_cabeceras = "Código,Descripción,Precio"
thisform.pages.page2.grdArticulos.generar_grid()

SELECT cur_articulos
thisform.pages.page1.grdVistaPrevia.alias_name = "cur_articulos"
thisform.pages.page1.grdVistaPrevia.RecordSource = "cur_articulos"
thisform.pages.page1.grdVistaPrevia.RecordSourceType = 1
thisform.pages.page1.grdVistaPrevia.list_controlsource = "codigo,articulo,lista"
thisform.pages.page1.grdVistaPrevia.titulos_cabeceras = "Código,Descripción,Precio Lista"
thisform.pages.page1.grdVistaPrevia.lista_ancho_cols = "100,250,70"
thisform.pages.page1.grdVistaPrevia.generar_grid()

Thisform.pages.page1.sel_proveedor.txtCodigo.SetFocus()
ENDPROC


************************************************************
OBJETO: pages
************************************************************
*** PROPIEDADES ***
ErasePage = .T.
Top = 12
Left = 10
Width = 1133
Height = 450
Name = "pages"
Page1.Caption = "Parametros de actualización"
Page1.Name = "Page1"
Page2.Caption = "Resultados"
Page2.Name = "Page2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Proveedor:"
Height = 15
Left = 96
Top = 12
Width = 65
TabIndex = 11
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: sel_proveedor
************************************************************
*** PROPIEDADES ***
Top = 6
Left = 166
TabIndex = 1
nombre_tabla = proveedor
nombre_campo_codigo = idprov
nombre_campo_desc = razSoc
pkfield = idprov
title_cols = Razón Social
autocompletar_ceros = .F.
esnumerico = .T.
Name = "sel_proveedor"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***
PROCEDURE recuperar_datos
LOCAL loCloudDB
LOCAL lcMensaje

loCloudDB = CREATEOBJECT("updater_net_clouddb")

loCloudDB.idProv = this.valcpoid
IF !loCloudDB.obtener_actualizacion_activa() THEN
	MESSAGEBOX(loCloudDB.mensaje, 0+64, thisform.Caption)
ELSE
	this.Parent.txtFileName.Value = loCloudDB.nombre_archivo
	this.Parent.txtFecha.Value = loCloudDB.fecha_actualizacion
	IF thisform.validar_pendientes() THEN
		lcMensaje = "Atención, hay artículos nuevos sin procesar para este proveedor, " ;
			+ "verifique los mismos antes de ejecutar el proceso de actualización. " ;
			+ "Tenga en cuenta de que después de procesar se eliminarán los artículos nuevos que " ;
			+ "no hayan sido procesados."
		MESSAGEBOX(lcMensaje, 0+48, thisform.Caption)
	ENDIF
ENDIF
ENDPROC


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Bonificación 1"
Height = 15
Left = 25
Top = 92
Width = 79
TabIndex = 12
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Bonificación 2"
Height = 15
Left = 139
Top = 92
Width = 79
TabIndex = 13
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Bonificación 3"
Height = 15
Left = 255
Top = 92
Width = 79
TabIndex = 14
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Bonificación 4"
Height = 15
Left = 371
Top = 92
Width = 79
TabIndex = 15
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: txtBonif1
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 24
TabIndex = 4
Top = 107
Width = 85
isnumeric = .T.
Name = "txtBonif1"

*** METODOS ***


************************************************************
OBJETO: txtBonif2
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 140
TabIndex = 5
Top = 107
Width = 85
isnumeric = .T.
Name = "txtBonif2"

*** METODOS ***


************************************************************
OBJETO: txtBonif3
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 256
TabIndex = 6
Top = 107
Width = 85
isnumeric = .T.
Name = "txtBonif3"

*** METODOS ***


************************************************************
OBJETO: txtBonif4
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 372
TabIndex = 7
Top = 107
Width = 85
isnumeric = .T.
Name = "txtBonif4"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta6
************************************************************
*** PROPIEDADES ***
Caption = "Margen mayorista"
Height = 15
Left = 619
Top = 92
Width = 107
TabIndex = 16
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta7
************************************************************
*** PROPIEDADES ***
Caption = "Margen minorista"
Height = 15
Left = 734
Top = 92
Width = 107
TabIndex = 17
Name = "Clsetiqueta7"

*** METODOS ***


************************************************************
OBJETO: txtMargenMay
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 618
TabIndex = 8
Top = 107
Width = 85
isnumeric = .T.
Name = "txtMargenMay"

*** METODOS ***


************************************************************
OBJETO: txtMargenMin
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 735
TabIndex = 9
Top = 107
Width = 85
isnumeric = .T.
Name = "txtMargenMin"

*** METODOS ***


************************************************************
OBJETO: btnProcesar
************************************************************
*** PROPIEDADES ***
Top = 92
Left = 964
Height = 36
Width = 132
FontBold = .T.
Caption = "Procesar"
TabIndex = 10
Name = "btnProcesar"

*** METODOS ***
PROCEDURE Click
thisform.o_updater.idprov = thisform.pages.page1.sel_proveedor.valcpoid
thisform.o_updater.desc1 = thisform.pages.page1.txtBonif1.Value
thisform.o_updater.desc2 = thisform.pages.page1.txtBonif2.Value
thisform.o_updater.desc3 = thisform.pages.page1.txtBonif3.Value
thisform.o_updater.desc4 = thisform.pages.page1.txtBonif4.Value
thisform.o_updater.margenmay = thisform.pages.page1.txtMargenMay.Value
thisform.o_updater.margenmin = thisform.pages.page1.txtMargenMin.Value
thisform.o_updater.nombre_archivo = this.Parent.txtFileName.Value
thisform.o_updater.copiar_planilla_a_cursor("")
INSERT INTO cur_ArtNuevos ;
	SELECT codArt, articulo, lista;
	FROM cur_articulos ;
	WHERE esNuevo = .T.
SELECT cur_ArtNuevos
GO TOP
thisform.pages.page2.grdArticulos.Refresh()
SELECT cur_articulos
GO TOP
thisform.pages.page1.grdVistaPrevia.Refresh()

thisform.pages.page2.txtActualizados.Value = RECCOUNT("cur_articulos")
thisform.pages.page2.txtNuevos.Value = RECCOUNT("cur_ArtNuevos")
ENDPROC


************************************************************
OBJETO: Clsetiqueta8
************************************************************
*** PROPIEDADES ***
Caption = "Actualización detectada:"
Height = 15
Left = 25
Top = 37
Width = 141
TabIndex = 18
Name = "Clsetiqueta8"

*** METODOS ***


************************************************************
OBJETO: txtFileName
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 168
TabIndex = 2
Top = 34
Width = 928
Name = "txtFileName"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta9
************************************************************
*** PROPIEDADES ***
Caption = "Fecha de actualización:"
Height = 15
Left = 31
Top = 63
Width = 131
TabIndex = 19
Name = "Clsetiqueta9"

*** METODOS ***


************************************************************
OBJETO: txtFecha
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 168
TabIndex = 3
Top = 60
Width = 150
isdatetime = .T.
Name = "txtFecha"

*** METODOS ***


************************************************************
OBJETO: grdVistaPrevia
************************************************************
*** PROPIEDADES ***
Height = 224
Left = 13
Top = 188
Width = 1080
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdVistaPrevia"
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
OBJETO: Clsetiqueta10
************************************************************
*** PROPIEDADES ***
Caption = "Vista previa"
Height = 15
Left = 17
Top = 171
Width = 79
TabIndex = 12
Name = "Clsetiqueta10"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Total de registros:"
Height = 15
Left = 25
Top = 12
Width = 130
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Cantidad nuevos:"
Height = 15
Left = 284
Top = 12
Width = 113
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: txtActualizados
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 156
Top = 8
Width = 85
isnumeric = .T.
Name = "txtActualizados"

*** METODOS ***


************************************************************
OBJETO: txtNuevos
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 21
Left = 389
Top = 8
Width = 85
isnumeric = .T.
Name = "txtNuevos"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Artículos nuevos"
Height = 15
Left = 25
Top = 37
Width = 130
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: grdArticulos
************************************************************
*** PROPIEDADES ***
Height = 292
Left = 24
Top = 56
Width = 1099
permitir_busqueda = .T.
permitir_ordenamiento = .T.
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
OBJETO: btnGrabar
************************************************************
*** PROPIEDADES ***
Top = 372
Left = 1031
Name = "btnGrabar"

*** METODOS ***
PROCEDURE Click
WAIT WINDOW "Actualizando artículos, espere por favor..." NOWAIT
IF !thisform.o_updater.grabar() THEN
	MESSAGEBOX(Thisform.o_updater.mensaje, 0+48, Thisform.Caption)
ELSE
	MESSAGEBOX(Thisform.o_updater.mensaje, 0+64, Thisform.Caption)
ENDIF
WAIT WINDOW "Listo..." NOWAIT
Thisform.limpiar()
ENDPROC


************************************************************
OBJETO: btnCancelar
************************************************************
*** PROPIEDADES ***
Top = 372
Left = 1079
Name = "btnCancelar"

*** METODOS ***
PROCEDURE Click
Thisform.limpiar()
ENDPROC


************************************************************
OBJETO: Clscerrar1
************************************************************
*** PROPIEDADES ***
Top = 471
Left = 1098
Name = "Clscerrar1"

*** METODOS ***


************************************************************
OBJETO: cls_updater_net_form
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 9, 6, 15, 12, 32, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


