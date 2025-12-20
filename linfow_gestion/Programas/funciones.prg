*************************************************************
* Funciones.prg
* Descripción
*	Contiene las funciones de la que depende el sistema
*	para funcionar.
* Autor: Leonardo D. Zulli
* Fecha: 26/07/2021
*************************************************************

**
* Descarga los scripts desde el servidor
**
PROCEDURE instalar_scripts
	LPARAMETERS tcURL
	descomprimir_scripts(.T.)
	IF !getGlobalCFG("UPDSQLLOC") THEN
		VFPHTTP(tcURL + "scripts.zip", "upgrades/scripts/scripts.zip")
		descomprimir_scripts(.F.)
		seleccionar_scripts()
	ENDIF
ENDPROC


**
* Descomprime el archivo ZIP y lo elimina
* tlActualizados (bool): Indica si se descomprime el archivo actual
*	en la carpeta OLD para su comparación.
**
PROCEDURE descomprimir_scripts
	PARAMETERS tlActualizados
	LOCAL loZip
	LOCAL lcUbicacion
	LOCAL lcUbicacionDestino

	lcUbicacion = get_ubicacion()
	IF tlActualizados THEN
		lcUbicacionDestino = lcUbicacion + "\actualizados"
	ELSE
		lcUbicacionDestino = lcUbicacion
	ENDIF

	descomprimir_fichero(lcUbicacion + "\scripts.zip", lcUbicacionDestino)
ENDPROC

**
* Descomprime cualquier fichero zip
**
PROCEDURE descomprimir_fichero
	PARAMETERS tcArchivoZip, tcDirectorioDestino
	loZip = CREATEOBJECT("Zip.Zip")
	loZip.ArchivoZip = tcArchivoZip
	loZip.DirectorioDestino = tcDirectorioDestino
	loZip.Descomprimir()
ENDPROC

**
* Obtengo la ubicación donde grabo el script
**
FUNCTION get_ubicacion
	IF !getGlobalCFG("UPDSQLLOC") THEN
		RETURN ALLTRIM(SYS(5) + SYS(2003) + "\upgrades\scripts")
	ELSE
		RETURN getGlobalCFG("UPDSQLPATH")
	ENDIF
ENDFUNC

**
* Compara el contenido de los archivos que ya fueron actualizados con
* el nuevo ZIP descargado. Si el contenido cambia entonces lo deja para
* ejecutar en los siguientes pasos.
**
PROCEDURE seleccionar_scripts
	LOCAL lcUbicacionNuevos
	LOCAL lcUbicacionViejos
	LOCAL lnFileCountNuevos

	lcUbicacionNuevos = get_ubicacion()
	lcUbicacionViejos = get_ubicacion() + "\actualizados"
	lnFileCountNuevos = ADIR(laFiles, lcUbicacionNuevos + "\*.sql")

	&& Comienzo la comparación
	FOR i = 1 TO lnFileCountNuevos
		&& Si el script existe dentro de actualizados, entonces, comparo
		IF FILE(lcUbicacionViejos + "\" + laFiles(i, 1)) THEN
			IF FILETOSTR(lcUbicacionNuevos + "\" + laFiles(i, 1)) == FILETOSTR(lcUbicacionViejos + "\" + laFiles(i, 1)) THEN
				* Son iguales, por lo tanto elimino el archivo nuevo para que no se ejecute
				DELETE FILE lcUbicacionNuevos + "\" + laFiles(i, 1)
			ENDIF
		ENDIF
	ENDFOR
ENDPROC

**
* Verifica si el directorio de scripts existe, en caso de que no exista entonces
* lo crea.
**
PROCEDURE checkSqlDirectory()
	lcUbicacion = get_ubicacion()
	IF !DIRECTORY(lcUbicacion + "\actualizados", 0) THEN
		MKDIR lcUbicacion + "\actualizados"
	ENDIF
ENDPROC

**
* Permite actualizar procedimientos almacenados
**
PROCEDURE actualizarSPs
	LOCAL lcUbicacion
	LOCAL lnFileCount
	LOCAL lcFileName
	PRIVATE laFiles	&& Lo pongo como private porque es un array

	lcFileName = ""
	lnFileCount = 0
	lcUbicacion = get_ubicacion()
	lnFileCount = ADIR(laFiles, lcUbicacion + "\sp.*.sql")
	FOR i = 1 TO lnFileCount
		lcFileName = laFiles(i, 1)
		ejecutar_SP(lcUbicacion, lcFileName)
	ENDFOR
ENDPROC

**
* Permite ejecutar el script que crea el procedimiento almacenado
**
PROCEDURE ejecutar_SP
	PARAMETERS tcUbicacion, tcFileName
	LOCAL loCommand
	LOCAL lcScript
	LOCAL lcSPName

	loCommand = CREATEOBJECT("odbc_command")

	lcSPName = GETWORDNUM(tcFileName, 2, ".")
	WAIT WINDOW "Actualizando procedimiento almacenado " + lcSPName + "..." NOWAIT
	lcScript = "DROP PROCEDURE IF EXISTS " + ALLTRIM(lcSPName)
	loCommand.CommandText = lcScript
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.execute()

	lcScript = FILETOSTR(tcUbicacion + "\" + tcFileName)
	loCommand.CommandText = lcScript
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.execute()
ENDPROC

**
* Permite actualizar funciones de base de datos
**
PROCEDURE actualizar_funciones
	LOCAL lcUbicacion
	LOCAL lnFileCount
	LOCAL lcFileName
	PRIVATE laFiles	&& Lo pongo como private porque es un array
	
	lcFileName = ""
	lnFileCount = 0
	lcUbicacion = get_ubicacion()

	lnFileCount = ADIR(laFiles, lcUbicacion + "\fn.*.sql")
	FOR i = 1 TO lnFileCount
		lcFileName = laFiles(i, 1)
		ejecutar_fn(lcUbicacion, lcFileName)
	ENDFOR
ENDPROC

**
* Permite eliminar y crear la función para que se actualice el código.
**
PROCEDURE ejecutar_fn
	PARAMETERS tcUbicacion, tcFileName
	LOCAL loCommand
	LOCAL lcScript
	LOCAL lcSPName

	loCommand = CREATEOBJECT("odbc_command")

	lcSPName = GETWORDNUM(tcFileName, 2, ".")
	WAIT WINDOW "Actualizando función " + lcSPName + "..." NOWAIT
	IF existe_fn(lcSPName) THEN
		lcScript = "DROP FUNCTION IF EXISTS " + ALLTRIM(lcSPName)
		loCommand.CommandText = lcScript
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.execute()
	ENDIF

	lcScript = FILETOSTR(tcUbicacion + "\" + tcFileName)
	loCommand.CommandText = lcScript
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.execute()
ENDPROC

***
* Verifica si una función existe en la base de datos.
***
FUNCTION existe_fn
	PARAMETERS tcFnName
	
	LOCAL lcSql
	LOCAL loRes
	LOCAL lcBDNombre
	LOCAL llResult
	
	lcBDNombre = ALLTRIM(goConn.current_db)
	
	TEXT TO lcSql NOSHOW
		select	
			count(*) as cantReg
		from	
			information_schema.routines
		where	
			specific_name = ?xcFnName and    
			routine_schema = ?xBD
	ENDTEXT
	loRes = CREATEOBJECT("odbc_result")
	lcSql = loRes.AddParameter(lcSql, "xcFnName", tcFnName, .T., .F.)
	lcSql = loRes.AddParameter(lcSql, "xBD", lcBDNombre, .T., .F.)

	loRes.ActiveConnection = goConn.ActiveConnection
	loRes.Cursor_Name = "cur_x"
	loRes.OpenQuery(lcSql)
	
	SELECT cur_x
	IF INT(VAL(cur_x.cantReg)) = 0 THEN
		llResult = .F.
	ELSE
		llResult = .T.
	ENDIF
	
	loRes.Close_Query()
	
	RETURN llResult
ENDFUNC

***
* Permite configurar el sistema ya sea para modo desarrollo
* o producción según el parámetro MODODESA
***
PROCEDURE configurar_sistema
	LOCAL llModoDesa
	LOCAL lcScript
	LOCAL lcSql
	LOCAL lcUrl
	
	TRY 
	
		lcUrl = getGlobalCFG("UPD_URL")
		
		WAIT WINDOW "Chequeando parametros..." NOWAIT
		llModoDesa = getGlobalCFG("MODODESA")
		
		IF llModoDesa THEN
			lcScript = FILETOSTR(ALLTRIM(SYS(5) + SYS(2003) + "\upgrades\utils_configurar_desa.sql"))
		ELSE
			lcScript = FILETOSTR(ALLTRIM(SYS(5) + SYS(2003) + "\upgrades\utils_configurar_prod.sql"))
		ENDIF
		
		FOR i = 1 TO GETWORDCOUNT(lcScript, ";")
			lcSql = GETWORDNUM(lcScript, i, ";")
			* Verifico que el sql no venga vacío.
			IF !EMPTY(lcSql) THEN
				ejecutar_comando(lcSql)
			ENDIF
		NEXT i
		WAIT WINDOW "Parámetros chequeados" NOWAIT
	CATCH TO oException
		STRTOFILE("Error: " + STR(oException.ErrorNo) + " " + oException.Message + " " + oException.Procedure ;
			+ STR(oException.LineNo), "error.log")
	ENDTRY
ENDPROC

&& Inserta un registro en la tabla log_transacciones.
&& Esto lo hago para hacer un seguimiento de los procesos.
PROCEDURE insert_log
	PARAMETERS tcComponente, tcModulo, tcDescripcion, tcValoresRef, tnLineaCod, tcSql, tcError
	LOCAL loCmd

	loCmd = CREATEOBJECT("odbc_command")
	TEXT TO loCmd.CommandText NOSHOW
		CALL log_transacciones_insert (
		    ?xcomponente,
		    ?xmodulo,
		    ?xdescripcio,
		    ?xvaloresref,
		    ?xlinea_cod,
		    ?xsql_stmt,
		    ?xerror_msg)
	ENDTEXT
	loCmd.AddParameter("xcomponente", ALLTRIM(tcComponente), .T., .F.)
	loCmd.AddParameter("xmodulo", ALLTRIM(tcModulo), .T., .F.)
	loCmd.AddParameter("xdescripcio", ALLTRIM(tcDescripcion), .T., .F.)
	loCmd.AddParameter("xvaloresref", ALLTRIM(tcValoresRef), .T., .F.)
	loCmd.AddParameter("xlinea_cod", ALLTRIM(STR(tnLineaCod)), .T., .F.)
	loCmd.AddParameter("xsql_stmt", ALLTRIM(tcSql), .T., .F.)
	loCmd.AddParameter("xerror_msg", ALLTRIM(tcError), .T., .F.)
	loCmd.ActiveConnection = goConn.ActiveConnection
	IF !loCmd.execute() THEN
		MESSAGEBOX("Error al insertar una transaccion", 0 + 48, "Error del sistema")
	ENDIF
ENDPROC

**
* Permite estandarizar los valores de los checkbox debido a que a veces levanta
* un valor booleano y a veces levanta un valor un numérico 0 o 1. Lo paso siempre
* a numérico que es como lo tengo que pasar a la base de datos.
**
FUNCTION estandarizar_checkbox_value
	LPARAMETERS tValue
	IF TYPE("tValue") == "L" THEN
		tValue = IIF(tValue, 1, 0)
	ENDIF
	RETURN tValue
ENDFUNC

**
* Ejecuta un comando SQL
**
PROCEDURE ejecutar_comando
	LPARAMETERS tcSql
	
	LOCAL loCmd
	LOCAL lcSql
	
	goConn.BeginTransaction()
	loCmd = CREATEOBJECT("odbc_command")
	loCmd.ActiveConnection = goConn.ActiveConnection
	loCmd.CommandText = tcSql
	IF !loCmd.execute()	THEN
		goConn.Rollback()
		MESSAGEBOX(loCmd.ErrorMessage, 0+48, "Actualización de sistema")
		RETURN
	ENDIF
	goConn.Commit()
ENDPROC

**
* Verifica si un campo ya fué creado
**
FUNCTION existe_campo
	LPARAMETERS tcTabla, tcCampo
	
	LOCAL loRes
	LOCAL llReturn
	
	WAIT WINDOW "Chequeando campo si existe " + tcCampo + "..." NOWAIT
	
	loRes = CREATEOBJECT("odbc_result")
	loRes.Cursor_Name = "cur_x"
	loRes.ActiveConnection = goConn.ActiveConnection
	loRes.OpenQuery("describe " + tcTabla)
	SELECT cur_x
	GO TOP
	DO WHILE !EOF("cur_x")
		IF LOWER(ALLTRIM(cur_x.Field)) == LOWER(ALLTRIM(tcCampo)) THEN
			loRes.Close_Query()
			RETURN .T.
		ENDIF
	
		SELECT cur_x
		SKIP
	ENDDO
	loRes.Close_Query()
	RETURN .F.
ENDFUNC

**
* Agrega un menú al sistema
**
PROCEDURE agregarMenu
	LPARAMETERS tcCodMenu, tcNombre, tcProcedim, tlIsChild, tnEnlace, tcAccKey, tnOrden
	
	LOCAL loCmd
	
	loCmd = CREATEOBJECT("odbc_command")
	TEXT TO loCmd.CommandText NOSHOW
		CALL agregar_menu(?xCodMenu, ?xNombre, ?xProcedim, ?xIsChild, ?xEnlace, ?xacc_key, ?xorden)
	ENDTEXT
	loCmd.AddParameter("xCodMenu", ALLTRIM(tcCodMenu), .T., .F.)
	loCmd.AddParameter("xNombre", ALLTRIM(tcNombre), .T., .F.)
	loCmd.AddParameter("xProcedim", ALLTRIM(tcProcedim), .T., .F.)
	loCmd.AddParameter("xIsChild", IIF(tlIsChild = .T., "1", "0"), .F., .F.)
	loCmd.AddParameter("xEnlace", ALLTRIM(STR(tnEnlace)), .F., .F.)
	loCmd.AddParameter("xacc_key", ALLTRIM(tcAccKey), .T., .F.)
	loCmd.AddParameter("xorden", ALLTRIM(STR(tnOrden)), .F., .F.)
	loCmd.ActiveConnection = goConn.ActiveConnection
	loCmd.Execute()
ENDPROC

**
* Agrega o actualiza parámetros
**
PROCEDURE addOrUpdateGlobalCFG
	LPARAMETERS tcKey, tcType, tcValue, tlReemplazar
	
	LOCAL loCmd
	
	loCmd = CREATEOBJECT("odbc_command")
	TEXT TO loCmd.CommandText NOSHOW
		CALL globalcfg_insert (?xkey, ?xtype, ?xvalue, ?xreemplazar)
	ENDTEXT
	loCmd.AddParameter("xkey", ALLTRIM(tcKey), .T., .F.)
	loCmd.AddParameter("xtype", ALLTRIM(tcType), .T., .F.)
	loCmd.AddParameter("xvalue", ALLTRIM(tcValue), .T., .F.)
	loCmd.AddParameter("xreemplazar", IIF(tlReemplazar = .T., "1", "0"), .F., .F.)
	loCmd.ActiveConnection = goConn.ActiveConnection
	loCmd.Execute()
ENDPROC

************** Utilidades para JSON ********************************

********************************************************************
* Convierte un cursor en un string JSON. Esto es para hacer
* transferencias de datos.
*
* Fecha: 06/10/2021
********************************************************************
FUNCTION ConvertCursorToJSON
	LPARAMETERS tcCursorName
	
	LOCAL lnCantCampos
	LOCAL lnIndexCampo
	LOCAL lnIndexRegistro
	LOCAL lcJSONString
	LOCAL lcReferencia
	
	* Recorror los registros del cursor
	SELECT (tcCursorName)
	GO TOP
	lnIndexRegistro = 1
	lcJSONString = "["
	DO WHILE !EOF(tcCursorName)
		lcJSONString = lcJSONString + "{"
		
		* Por cada registro recorro los campos y obtengo el nombre y los valores
		FOR lnIndexCampo = 1 TO FCOUNT()
			lcReferencia = tcCursorName + "." + FIELD(lnIndexCampo)
			DO CASE
				CASE TYPE(lcReferencia) == "C"
					lcJSONString = lcJSONString + '"' + LOWER(FIELD(lnIndexCampo)) ;
						+ '": "' + ALLTRIM(&lcReferencia) + '"' + IIF(lnIndexCampo < FCOUNT(tcCursorName), ",", "")
				CASE TYPE(lcReferencia) == "N"
					lcJSONString = lcJSONString + '"' + LOWER(FIELD(lnIndexCampo)) ;
						+ '": ' + ALLTRIM(STR(&lcReferencia, 20, 2)) + "" + IIF(lnIndexCampo < FCOUNT(tcCursorName), ",", "")
			ENDCASE
		ENDFOR
		lcJSONString = lcJSONString + "}" + IIF(lnIndexRegistro < RECCOUNT(tcCursorName), ",", "")
	
		lnIndexRegistro = lnIndexRegistro + 1
		SELECT (tcCursorName)
		SKIP
	ENDDO
	lcJSONString = lcJSONString + "]"
	
	RETURN lcJSONString
ENDFUNC

** Funciones útiles para facturación electrónica
*********************************************************************

PROCEDURE descargar_ticket_acceso
	*****************************************************************
	* Permite descargar el ticket de acceso del cloud server.
	* Autor: LINFOW - Leonardo D. Zulli
	* Fecha: 23/11/2021
	*****************************************************************
	LPARAMETERS lcTicketAccesoFileName

	LOCAL lcFtpHost
	LOCAL lcFtpUSer
	LOCAL lcFtpPassword
	LOCAL lcFtpPort
	LOCAL lcRemotePath
	LOCAL lcLocalPath
	LOCAL lcCmd

	lcFtpHost = getGlobalCFG("FTPHOST")
	lcFtpUser = getGlobalCFG("FTPUSER")
	lcFtpPassword = getGlobalCFG("FTPPASS")
	lcFtpPort = getGlobalCFG("FTPPORT")
	lcRemotePath = getGlobalCFG("FETKDIRFTP") + "/ticket.txt"
	lcLocalPath = lcTicketAccesoFileName

	TEXT TO lcCmd NOSHOW
		RUN pscp -P puerto -pw "clave" usuario@host:remote_path local_path
	ENDTEXT

	lcCmd = STRTRAN(lcCmd, "puerto", ALLTRIM(lcFtpPort))
	lcCmd = STRTRAN(lcCmd, "clave", ALLTRIM(lcFtpPassword))
	lcCmd = STRTRAN(lcCmd, "usuario", ALLTRIM(lcFtpUser))
	lcCmd = STRTRAN(lcCmd, "host", ALLTRIM(lcFtpHost))
	lcCmd = STRTRAN(lcCmd, "remote_path", ALLTRIM(lcRemotePath))
	lcCmd = STRTRAN(lcCmd, "local_path", ALLTRIM(lcLocalPath))

	&lcCmd
ENDPROC

PROCEDURE enviar_ticket_acceso
	********************************************************************************
	* Permite enviar el ticket de acceso al servidor.
	* Autor: LINFOW - Leonardo D. Zulli
	* Fecha: 23/11/2021	
	********************************************************************************
	LPARAMETERS tcTicketAccesoFileName

	LOCAL lcFtpHost
	LOCAL lcFtpUSer
	LOCAL lcFtpPassword
	LOCAL lcFtpPort
	LOCAL lcCmd

	lcFtpHost = getGlobalCFG("FTPHOST")
	lcFtpUser = getGlobalCFG("FTPUSER")
	lcFtpPassword = getGlobalCFG("FTPPASS")
	lcFtpPort = getGlobalCFG("FTPPORT")

	* Armo el comando a ejecutar mediante una macro de sustitución
	TEXT TO lcCmd NOSHOW
	    RUN pscp -P puerto -pw "clave" nombre_archivo_1 usuario@dominio:ruta_destino
	ENDTEXT
	lcCmd = STRTRAN(lcCmd, "puerto", lcFtpPort)
	lcCmd = STRTRAN(lcCmd, "clave", lcFtpPassword)
	lcCmd = STRTRAN(lcCmd, "nombre_archivo_1", tcTicketAccesoFileName)
	lcCmd = STRTRAN(lcCmd, "usuario", lcFtpUser)
	lcCmd = STRTRAN(lcCmd, "dominio", lcFtpHost)
	lcCmd = STRTRAN(lcCmd, "ruta_destino", getGlobalCFG("FETKDIRFTP"))

	* Ejecuto el comando
	&lcCmd
ENDPROC

FUNCTION getCursorResultValue
	**********************************************************
	* Verifica el tipo de datos que devuelve del valor result
	* cuando se ejecuta un procedimiento almacenado.
	* Fecha: 06/02/2023
	**********************************************************
	LPARAMETERS tValue
	
	IF TYPE("tValue") == "N" THEN
		RETURN tValue
	ELSE
		RETURN INT(VAL(tValue))
	ENDIF
ENDFUNC

FUNCTION proximoMultiplo
LPARAMETERS cantidad, multiplo
	**********************************************************
	* Esta función devuelve el próximo múltiplo de un número.
	**********************************************************

	LOCAL resto, proximo

	IF cantidad % multiplo = 0
	    proximo = cantidad
	ELSE
	    resto = cantidad % multiplo
	    proximo = cantidad + (multiplo - resto)
	ENDIF

	RETURN proximo
ENDFUNC

**************************************************
* Permite validar el CUIT con el dígito
* verificador
**************************************************
FUNCTION ValidarCUIT
	LPARAMETERS tcCUIT
	LOCAL lnSuma, llRet
	
	IF EMPTY(tcCuit)
		llRet = .F.
	ELSE
		IF TYPE('tcCuit') = 'C' AND LEN(tcCuit) = 11
			lnSuma = VAL(SUBS(tcCUIT,10,1)) * 2 + ;
				VAL(SUBS(tcCUIT,9,1)) * 3 + ;
				VAL(SUBS(tcCUIT,8,1)) * 4 + ;
				VAL(SUBS(tcCUIT,7,1)) * 5 + ;
				VAL(SUBS(tcCUIT,6,1)) * 6 + ;
				VAL(SUBS(tcCUIT,5,1)) * 7 + ;
				VAL(SUBS(tcCUIT,4,1)) * 2 + ;
				VAL(SUBS(tcCUIT,3,1)) * 3 + ;
				VAL(SUBS(tcCUIT,2,1)) * 4 + ;
				VAL(SUBS(tcCUIT,1,1)) * 5
			llRet = VAL(SUBS(tcCUIT,11,1)) = ;
			IIF(MOD(lnSuma,11) = 0, 0, 11-MOD(lnSuma,11))
		ELSE
			*--- No es Char o no tiene el largo correcto
			llRet = .F.
		ENDIF
	ENDIF	
	RETURN llRet
ENDFUNC

***************************************************************
* Permite consumir un API Rest desde Visual Foxpro
* Recurso: Stack Overflow
***************************************************************
FUNCTION WinHttp(lcUrl, lcVerb, lcPostData, lcContentType)
	LOCAL lcResult

	*** FOR DEMOS ONLY!
	IF EMPTY(lcUrl)    
	   RETURN null
	ENDIF
	IF EMPTY(lcVerb)
	   lcVerb = "GET"
	   IF !EMPTY(lcPostData)
	      lcVerb = "POST"
	   ENDIF
	ENDIF   

	*** Example of using simplistic WinHttp client to retreive HTTP content
	LOCAL loHttp as WinHttp.WinHttpRequest.5.1, lcResult
	loHTTP = CREATEOBJECT("WinHttp.WinHttpRequest.5.1")    

	loHTTP.Open(lcVerb, lcUrl,.F.)

	IF !EMPTY(lcContentType) AND lcVerb = "POST" OR lcVerb = "PUT" 
	    loHttp.SetRequestHeader("Content-Type",lcContentType)
	ENDIF   

	*** If using POST you can post content as a parameter
	IF !EMPTY(lcPostData)
	    loHTTP.Send(lcPostData)
	ELSE
	   loHttp.Send()    
	ENDIF

	lcResult = loHttp.ResponseText

	loHttp = NULL 

RETURN lcResult


*************************************************************
* Archivo: excel_export.prg
* Autor: Leonardo D. Zulli
* Fecha: 03/09/2025
* Descripción: Procedimiento que exporta un cursor a un archivo
* Excel, respetando las convenciones de codificación.
* Maneja la conversión de tipos de datos para asegurar
* un formato correcto en Excel.
*************************************************************

**
* Procedimiento exportar_a_excel
*
* Objetivo: Exportar un cursor de Visual FoxPro a un archivo de Excel.
*
* Parámetros:
* tcCursor  (Caracter): Alias del cursor a exportar. Si está vacío,
* utiliza el alias del área de trabajo actual.
* tcFileSave (Caracter): Nombre y ruta del archivo de Excel a guardar.
* Si está vacío, la aplicación de Excel se
* mantendrá visible para el usuario.
* tcTitulo  (Caracter): Título que se coloca en la primera fila del informe.
*
**
PROCEDURE exportar_a_excel
	LPARAMETERS tcCursor, tcFileSave, tcTitulo

	LOCAL lnSelectArea, ;
	      lcOriginalArea, ;
	      loExcel, ;
	      loWorkBook, ;
	      loWorkSheet, ;
	      lnColCount, ;
	      lnRowCount, ;
	      lnRow, ;
	      lnCol, ;
	      laFields[1], ;
	      lcFieldType, ;
	      lcWarning

	lcWarning = "Exportar a Excel"

	*-- Validación de parámetros y entorno
	IF VARTYPE(tcCursor) # 'C'
	    tcCursor = ALIAS()
	ENDIF

	IF EMPTY(tcCursor) OR !USED(tcCursor)
	    MESSAGEBOX("Parámetros Inválidos o el cursor no está abierto.", 16, lcWarning)
	    RETURN .F.
	ENDIF

	lnSelectArea = SELECT()
	SELECT (tcCursor)
	lcOriginalArea = ALIAS()
	IF RECCOUNT() = 0
	    MESSAGEBOX("El cursor no contiene registros.", 48, lcWarning)
	    SELECT (lnSelectArea)
	    RETURN .F.
	ENDIF

	WAIT WINDOW "Abriendo Excel y exportando datos..." NOWAIT

	*-- Creación de los objetos de Excel
	loExcel = CREATEOBJECT("Excel.Application")
	IF ISNULL(loExcel)
	    MESSAGEBOX("No se pudo iniciar la aplicación de Excel.", 16, lcWarning)
	    RETURN .F.
	ENDIF

	loExcel.Visible = .T.
	loWorkBook = loExcel.Workbooks.ADD()
	loWorkSheet = loWorkBook.Worksheets(1)

	*-- Escritura del título y los encabezados de columna
	lnRowCount = 1
	IF VARTYPE(tcTitulo) = 'C' AND !EMPTY(tcTitulo)
	    loWorkSheet.Cells(lnRowCount, 1).Value = tcTitulo
	    loWorkSheet.Cells(lnRowCount, 1).FONT.Bold = .T.
	    loWorkSheet.Cells(lnRowCount, 1).FONT.Size = 12
	    loWorkSheet.Range(loWorkSheet.Cells(lnRowCount, 1), loWorkSheet.Cells(lnRowCount, AFIELDS(laFields))).MergeCells = .T.
	    lnRowCount = lnRowCount + 1
	ENDIF

	*-- Obtener la estructura del cursor y escribir los encabezados
	lnColCount = AFIELDS(laFields)
	FOR lnCol = 1 TO lnColCount
	    loWorkSheet.Cells(lnRowCount, lnCol).Value = laFields[lnCol, 1]
	    loWorkSheet.Cells(lnRowCount, lnCol).FONT.Bold = .T.
	    loWorkSheet.Cells(lnRowCount, lnCol).Interior.Color = 15658734  && Un color gris claro
	NEXT
	lnRowCount = lnRowCount + 1

	*-- Escritura de los datos
	GO TOP
	DO WHILE !EOF()
	    FOR lnCol = 1 TO lnColCount
	        lcFieldType = ALLTRIM(UPPER(laFields[lnCol, 2]))

	        *-- Manejo del tipo de dato y formato
	        DO CASE
	            CASE lcFieldType == "C" OR lcFieldType == "M"
	            	loWorkSheet.Cells(lnRowCount, lnCol).NumberFormat = "@"
	                loWorkSheet.Cells(lnRowCount, lnCol).Value = ALLTRIM(EVAL(laFields[lnCol, 1]))
	            CASE lcFieldType == "D" OR lcFieldType == "T"
	            	loWorkSheet.Cells(lnRowCount, lnCol).NumberFormat = "dd/mm/yyyy"  && Formato de fecha y hora
	                loWorkSheet.Cells(lnRowCount, lnCol).Value = EVAL(laFields[lnCol, 1])
	            CASE lcFieldType == "N" OR lcFieldType == "F" OR lcFieldType == "B" OR lcFieldType == "Y"
	                *-- Para los campos numéricos, se inserta el valor como texto
	                *-- reemplazando el punto decimal por una coma.
	                loWorkSheet.Cells(lnRowCount, lnCol).NumberFormat = "0.00"
	                loWorkSheet.Cells(lnRowCount, lnCol).Value = STRTRAN(STR(EVAL(laFields[lnCol, 1])), ".", ",")
	            OTHERWISE
	                loWorkSheet.Cells(lnRowCount, lnCol).Value = EVAL(laFields[lnCol, 1])
	        ENDCASE
	    NEXT
	    SKIP
	    lnRowCount = lnRowCount + 1
	ENDDO

	*-- Ajuste de las columnas
	loWorkSheet.COLUMNS.AUTOFIT()

	*-- Congelar los paneles de la primera fila para mejor visualización
	loExcel.ActiveWindow.SplitRow = 1
	loExcel.ActiveWindow.FreezePanes = .T.

	*-- Guardar o mostrar el archivo
	IF VARTYPE(tcFileSave) = 'C' AND !EMPTY(tcFileSave)
	    loWorkBook.SAVEAS(tcFileSave)
	    loWorkBook.CLOSE(.F.)
	    loExcel.QUIT()
	    MESSAGEBOX("El archivo Excel se ha guardado en: " + tcFileSave, 64, lcWarning)
	ELSE
	    loExcel.Visible = .T.
	    loExcel.Activate()
	    MESSAGEBOX("El archivo Excel ha sido generado en memoria.", 64, lcWarning)
	ENDIF

	*-- Restaurar el área de trabajo original
	SELECT (lnSelectArea)

	RETURN .T.
ENDPROC
