**
* Archivo: cls_promociones.prg
* Descripción: Contiene la clase para gestionar las promociones.
*
* Desarrollado por: LINFOW - Leonardo D. Zulli
* Fecha: 25/08/2021
**

DEFINE CLASS cls_promociones AS Custom
	&& Propiedades
	IdPromo_C 		= 0			&& Id. cabecera promoción
	Nombre 			= ""		&& Nombre de la promoción
	Vigencia_D 		= {}		&& Fecha de vigencia desde
	Vigencia_H 		= {}		&& Fecha de vigencia hasta
	Imp_Tope 		= 0.00		&& Importe tope
	UsuarioActual 	= ""		&& Usuario actualmente logueado
	Host 			= SYS(0)	&& Host actual
	EsNuevo 		= .T.		&& Indica si es un registro nuevo o no.
	
	PROTECTED __ErrorMessage
		
	PROCEDURE GetErrorMessage()
		**
		* Devuelve el mensaje de error
		**
		RETURN this.__ErrorMessage
	ENDPROC

	PROCEDURE crear_cursores
		**
		* Permite crear los cursores que se requieren para el manejo de las
		* promociones.
		**
		
		CREATE CURSOR cur_marcas ( 	 ;
			idmarca 	int			,;
			descripcio 	varchar(60)  ;
		)
		
		CREATE CURSOR cur_merchandising (	;
			idArticulo	int,				;
			codArt		varchar(20),		;
			descripcio	varchar(200)		;
		)		
	ENDPROC
	
	FUNCTION grabar
		**
		* Permite grabar la promoción
		**
		LOCAL llResult
		
		llResult  = .F.
		
		&& Creo las tablas temporales
		this.crear_tablas_temporales()
		&& Continuar agregando los datos del cursor a las temporales
		this.add_marcas_to_temp()
		this.add_artic_to_temp()
		
		&& Verifico si se trata de un nuevo registro o no.
		IF this.EsNuevo THEN
			&& Inserto una promo nueva
			llResult = this.insertar_promo()
		ELSE
			&& Actualizo la promo
			llResult = this.actualizar_promo()
		ENDIF
		
		RETURN llResult
	ENDPROC
	
	PROTECTED PROCEDURE crear_tablas_temporales
		**
		* Crea las tablas temporales para esta sección en la base de daots
		**
		LOCAL loCmd
		loCmd = CREATEOBJECT("odbc_command")
		loCmd.ActiveConnection = goConn.ActiveConnection
		loCmd.CommandText = "CALL promo_create_temps()"
		IF !loCmd.Execute() THEN
			this.__ErrorMessage = "Error al ejecutar CALL promo_create_temps()"
			RETURN .F.
		ENDIF
	ENDPROC
	
	PROTECTED PROCEDURE add_marcas_to_temp
		**
		* Este método agrega los datos del cursor cur_marcas en la temporal
		**
		LOCAL loCmd
		
		loCmd = CREATEOBJECT("odbc_command")
		
		SELECT cur_marcas
		GO TOP
		DO WHILE !EOF("cur_marcas")
			loCmd.CommandText = "CALL promo_tempo_marcas_insert(?xidpromo_c, ?xidmarca)"
			loCmd.AddParameter("xidpromo_c", ALLTRIM(STR(this.IdPromo_C)), .F., .F.)
			loCmd.AddParameter("xidmarca", ALLTRIM(STR(cur_marcas.idmarca)), .F., .F.)
			loCmd.ActiveConnection = goConn.ActiveConnection
			IF !loCmd.Execute() THEN
				this.__ErrorMessage = "Error al ejecutar " + loCmd.CommandText
				RETURN
			ENDIF
			
			SELECT cur_marcas
			SKIP
		ENDDO
	ENDPROC
	
	PROTECTED PROCEDURE add_artic_to_temp
		**
		* Agrega los artículos de merchandising en la tabla temporal
		**
		LOCAL loCmd
		
		loCmd = CREATEOBJECT("odbc_command")
		
		SELECT cur_merchandising
		GO TOP
		DO WHILE !EOF("cur_merchandising")
			loCmd.CommandText = "CALL promo_tempo_artic_insert(?xidpromo_c, ?xidArticulo)"
			loCmd.AddParameter("xidpromo_c", ALLTRIM(STR(this.IdPromo_C)), .F., .F.)
			loCmd.AddParameter("xidArticulo", ALLTRIM(STR(cur_merchandising.idArticulo)), .F., .F.)
			loCmd.ActiveConnection = goConn.ActiveConnection
			IF !loCmd.Execute() THEN
				this.__ErrorMessage = "Error al ejecutar " + loCmd.CommandText
				RETURN
			ENDIF
		
			SELECT cur_merchandising
			SKIP
		ENDDO
	ENDPROC
	
	PROTECTED FUNCTION insertar_promo
		**
		* Inserto una promoción nueva
		**
		
		LOCAL loRes
		LOCAL lcSql
		
		loRes = CREATEOBJECT("odbc_result")
		
		&& Armo el SQL
		TEXT TO lcSql NOSHOW
			CALL promo_insert (
			    ?xnombre,
			    ?xvigencia_d, 
			    ?xvigencia_h, 
			    ?ximp_tope,
			    ?xusuarioActual,
			    ?xhost
			);
		ENDTEXT
		lcSql = loRes.AddParameter(lcSql, "xnombre", ALLTRIM(this.Nombre), .T., .F.)
		lcSql = loRes.AddParameter(lcSql, "xvigencia_d", this.vigencia_d, .F., .T.)
		lcSql = loRes.AddParameter(lcSql, "xvigencia_h", this.vigencia_h, .F., .T.)
		lcSql = loRes.AddParameter(lcSql, "ximp_tope", ALLTRIM(STR(this.Imp_Tope, 20, 2)), .F., .F.)
		lcSql = loRes.AddParameter(lcSql, "xusuarioActual", ALLTRIM(this.UsuarioActual), .T., .F.)
		lcSql = loRes.AddParameter(lcSql, "xhost", ALLTRIM(this.Host), .T., .F.)
		
		loRes.ActiveConnection = goConn.ActiveConnection
		loRes.Cursor_Name = "cur_x"
		IF !loRes.OpenQuery(lcSql) THEN
			this.__ErrorMessage = "Error al ejecutar " + lcSql
			RETURN .F.
		ENDIF
		
		SELECT cur_x
		IF !(ALLTRIM(cur_x.result) == "OK") THEN
			this.__ErrorMessage = ALLTRIM(cur_x.result)
			? cur_x.result
			loRes.Close_Query()
			RETURN .F.
		ENDIF
		loRes.Close_Query()
		
		&& Pongo el id generado en la propiedad IdPromo_C
		this.IdPromo_C = this.obtener_ultimo_id()
		
		this.__ErrorMessage = ""		
		RETURN .T.
	ENDPROC
	
	PROTECTED FUNCTION obtener_ultimo_id
		**
		* Obtiene el último id insertado en la tabla promo_cab
		**
		LOCAL loRes
		LOCAL lcSql
		LOCAL lnUltimoId
		
		loRes = CREATEOBJECT("odbc_result")
		lcSql = "SELECT MAX(idpromo_c) AS ultimo_id FROM promo_cab"
		loRes.ActiveConnection = goConn.ActiveConnection
		loRes.Cursor_Name = "cur_x"
		loRes.OpenQuery(lcSql)
		SELECT cur_x
		lnUltimoId = cur_x.ultimo_id
		loRes.Close_Query()
		RETURN lnUltimoId
	ENDPROC
	
	PROTECTED PROCEDURE actualizar_promo
		**
		* Actualiza una promoción existente.
		**
		LOCAL loRes
		LOCAL lcSql
		
		loRes = CREATEOBJECT("odbc_result")
		
		&& Armo el SQL
		TEXT TO lcSql NOSHOW
			CALL promo_update (
				?xidpromo_c,
			    ?xnombre,
			    ?xvigencia_d, 
			    ?xvigencia_h, 
			    ?ximp_tope,
			    ?xusuarioActual,
			    ?xhost
			);
		ENDTEXT
		lcSql = loRes.AddParameter(lcSql, "xidpromo_c", ALLTRIM(STR(this.IdPromo_C)), .F., .F.)
		lcSql = loRes.AddParameter(lcSql, "xnombre", ALLTRIM(this.Nombre), .T., .F.)
		lcSql = loRes.AddParameter(lcSql, "xvigencia_d", this.vigencia_d, .F., .T.)
		lcSql = loRes.AddParameter(lcSql, "xvigencia_h", this.vigencia_h, .F., .T.)
		lcSql = loRes.AddParameter(lcSql, "ximp_tope", ALLTRIM(STR(this.Imp_Tope, 20, 2)), .F., .F.)
		lcSql = loRes.AddParameter(lcSql, "xusuarioActual", ALLTRIM(this.UsuarioActual), .T., .F.)
		lcSql = loRes.AddParameter(lcSql, "xhost", ALLTRIM(this.Host), .T., .F.)
		
		loRes.ActiveConnection = goConn.ActiveConnection
		loRes.Cursor_Name = "cur_x"
		IF !loRes.OpenQuery(lcSql) THEN
			this.__ErrorMessage = "Error al ejecutar " + lcSql
			RETURN .F.
		ENDIF
		
		SELECT cur_x
		IF !(ALLTRIM(cur_x.result) == "OK") THEN
			this.__ErrorMessage = ALLTRIM(cur_x.result)		
			loRes.Close_Query()
			RETURN .F.
		ENDIF
		loRes.Close_Query()
		
		this.__ErrorMessage = ""		
		RETURN .T.	
	ENDPROC
	
	PROCEDURE Recuperar_Promocion
		LPARAMETERS tnIdPromo_C
		**
		* Permite recuperar una promoción completa
		**
		
		this.Promo_Cab_getById(tnIdPromo_C)
		this.IdPromo_C = tnIdPromo_C
		this.Vaciar_Cursores()
		this.Promo_marcas_getByCab(tnIdPromo_C)
		this.Promo_Artic_getByCab(tnIdPromo_C)
	ENDPROC
	
	PROCEDURE Promo_Cab_getById
		LPARAMETERS tnIdPromo_C
		**
		* Lee el registro de cabecera por su id.
		**
		
		LOCAL loRes
		LOCAL lcSql
		
		loRes = CREATEOBJECT("odbc_result")
		lcSql = "CALL promo_cab_getById(?xidpromo_cab)"
		lcSql = loRes.AddParameter(lcSql, "xidpromo_cab", ALLTRIM(STR(tnIdPromo_C)), .F., .F.)
		loRes.ActiveConnection = goConn.ActiveConnection
		loRes.Cursor_Name = "cur_x"
		loRes.OpenQuery(lcSql)
		SELECT cur_x
		this.IdPromo_C = cur_x.idpromo_c
		this.Nombre = cur_x.nombre
		this.Vigencia_D = cur_x.vigencia_d
		this.Vigencia_H = cur_x.vigencia_h
		this.Imp_Tope = cur_x.imp_tope
		loRes.Close_Query()
	ENDPROC
	
	PROCEDURE Promo_marcas_getByCab
		LPARAMETERS tnIdPromoCab
		
		**
		* Promo_Marcas_getByCab
		* Permite recuperar las marcas de asignadas a una promoción.
		**
		
		LOCAL loRes
		LOCAL lcSql
		
		loRes = CREATEOBJECT("odbc_result")
		lcSql = "CALL promo_marcas_getByCab (?xidpromo_cab)"
		lcSql = loRes.AddParameter(lcSql, "xidpromo_cab", ALLTRIM(STR(tnIdPromoCab)), .F., .F.)
		loRes.ActiveConnection = goConn.Activeconnection
		loRes.Cursor_Name = "cur_x"
		loRes.OpenQuery(lcSql)
		SELECT cur_x
		GO TOP
		DO WHILE !EOF("cur_x")
			SELECT cur_marcas
			APPEND BLANK
			REPLACE cur_marcas.idmarca WITH cur_x.idmarca
			REPLACE cur_marcas.descripcio WITH cur_x.descripcio ADDITIVE
		
			SELECT cur_x
			SKIP
		ENDDO
		loRes.Close_Query()
		SELECT cur_marcas
		GO TOP
	ENDPROC
	
	PROCEDURE Vaciar_Cursores
		**
		* Permite limpiar los cursores que se crearon en el método crear_cursores
		**
		select cur_marcas
		ZAP
		select cur_merchandising
		ZAP
	ENDPROC
	
	PROCEDURE Promo_Artic_getByCab
		LPARAMETERS tnIdPromoCab
		
		**
		* Permite recuperar los merchandising asignados a una promoción
		**
		
		LOCAL loRes
		LOCAL lcSql
		
		loRes = CREATEOBJECT("odbc_result")
		lcSql = "CALL promo_artic_getByCab(?xidpromo_c)"
		lcSql = loRes.AddParameter(lcSql, "xidpromo_c", ALLTRIM(STR(tnIdPromoCab)), .F., .F.)
		loRes.ActiveConnection = goConn.Activeconnection
		loRes.Cursor_Name = "cur_x"
		loRes.OpenQuery(lcSql)
		SELECT cur_x
		GO TOP
		DO WHILE !EOF("cur_x")
			SELECT cur_merchandising
			APPEND BLANK
			REPLACE cur_merchandising.idArticulo WITH cur_x.idArticulo
			REPLACE cur_merchandising.codArt WITH cur_x.codArt ADDITIVE
			REPLACE cur_merchandising.descripcio WITH cur_x.descripcio ADDITIVE
		
			SELECT cur_x
			SKIP
		ENDDO
		loRes.Close_Query()
		SELECT cur_merchandising
		GO TOP		
	ENDPROC
	
	**
	* El siguiente método permite crear el cursor para generar los resultados
	**
	PROCEDURE crear_cursor_promocli
		CREATE CURSOR cur_promocli (		;
			idpromo_c	int,				;
			nombre		varchar(60),		;
			idCliente	int,				;
			razSoc		varchar(60),		;
			imp_tope	N(20, 2),			;
			total_vend	N(20, 2),			;
			faltan		N(20, 2))
			
		CREATE CURSOR cur_cli_merch (		;
			id			int,				;
			idpromocli 	int,				;
			idCliente 	int,				;
			idArticulo 	int,				;
			codArt		varchar(20),		;
			descripcio	varchar(200),		;
			cantidad	N(20, 2))
	ENDPROC
		
	**
	* El siguiente método permite cacular los importes y chequearlos contra las
	* promociones cargadas.
	*
	* Si el método falla devuelve .F.
	**
	FUNCTION Calcular_Promocion
		LOCAL loRes
		LOCAL lcSql
		LOCAL llResult
		
		loRes = CREATEOBJECT("odbc_result")
		lcSql = "CALL promo_calcular_importes()"
		loRes.ActiveConnection = goConn.ActiveConnection
		loRes.Cursor_Name = "cur_x"
		loRes.OpenQuery(lcSql)
		SELECT cur_x
		IF !(ALLTRIM(cur_x.result) == "OK") THEN
			this.__ErrorMessage = cur_x.result
			llResult = .F.
		ELSE
			llResult = .T.
		ENDIF
		loRes.Close_Query()
		RETURN llResult
	ENDFUNC

	**
	* Permite obtener el informe de promociones por clientes
	**
	PROCEDURE Get_Informe
		LOCAL loRes
		LOCAL lcSql
		LOCAL lcJSON
		
		SELECT cur_promocli
		ZAP
		
		loRes = CREATEOBJECT("odbc_result")
		lcSql = "CALL promo_getInforme()"
		loRes.ActiveConnection = goConn.ActiveConnection
		loRes.Cursor_Name = "cur_x"
		loRes.OpenQuery(lcSql)
		SELECT cur_promocli
		APPEND FROM DBF("cur_x")
		GO TOP
		loRes.Close_Query()
		
		lcJSON = ConvertCursorToJSON("cur_promocli")
		STRTOFILE(lcJSON, getGlobalCFG("TEMPDIR") + "promocli.json")
		SELECT cur_promocli
		GO TOP
	ENDPROC
	
	**
	* Permite obtener el informe de resultados de merchandising.
	**
	PROCEDURE Get_Informe_Merchandising
		LPARAMETERS tnIdCliente
		
		LOCAL loRes
		LOCAL lcSql
		
		SELECT cur_cli_merch
		ZAP
		
		loRes = CREATEOBJECT("odbc_result")
		lcSql = "CALL promo_getInformeMerchandising(?xidcliente)"
		lcSql = loRes.AddParameter(lcSql, "xidcliente", ALLTRIM(STR(tnIdCliente)), .F., .F.)
		loRes.ActiveConnection = goConn.ActiveConnection
		loRes.Cursor_Name = "cur_x"
		loRes.OpenQuery(lcSql)
		SELECT cur_cli_merch
		APPEND FROM DBF("cur_x")
		GO TOP
		loRes.Close_Query()		
	ENDPROC
	
	***********************************************************************
	* Exporto la tabla promo_clim a JSON para transferirlo al servidor
	***********************************************************************
	PROCEDURE ExportarMerchandisingAJSON
		LOCAL loRes
		LOCAL lcSql
		LOCAL lcJSON
		
		TEXT TO lcSql NOSHOW
			SELECT * FROM promo_clim
		ENDTEXT
		
		loRes = CREATEOBJECT("odbc_result")
		loRes.Cursor_Name = "cur_x"
		loRes.ActiveConnection = goConn.ActiveConnection
		loRes.OpenQuery(lcSql)
		SELECT cur_x
		lcJSON = ConvertCursorToJSON("cur_x")
		STRTOFILE(lcJSON, getGlobalCFG("TEMPDIR") + "promo_merchandising_cliente.json")
		loRes.Close_Query()
	ENDPROC
	
	
	***********************************************************************
	* Sube los archivos al FTP para que mg_server_updater los procese.
	***********************************************************************
	PROCEDURE SubirArchivosJSON
		Run "subir_archivos_ftp.bat"
	ENDPROC

	******************************************************************************
	* Permite subir los archivos JSON vía SFTP	
	******************************************************************************
	PROCEDURE SubirArchivosJSONPorSFTP
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
			RUN pscp -P puerto -pw "clave" nombre_archivo_1 nombre_archivo_2 usuario@dominio:ruta_destino
		ENDTEXT
		lcCmd = STRTRAN(lcCmd, "puerto", lcFtpPort)
		lcCmd = STRTRAN(lcCmd, "clave", lcFtpPassword)
		lcCmd = STRTRAN(lcCmd, "nombre_archivo_1", getGlobalCFG("TEMPDIR") + "promocli.json")
		lcCmd = STRTRAN(lcCmd, "nombre_archivo_2", getGlobalCFG("TEMPDIR") + "promo_merchandising_cliente.json")
		lcCmd = STRTRAN(lcCmd, "usuario", lcFtpUser)
		lcCmd = STRTRAN(lcCmd, "dominio", lcFtpHost)
		lcCmd = STRTRAN(lcCmd, "ruta_destino", getGlobalCFG("FTPINIDIR"))
		
		* Ejecuto el comando
		&lcCmd
	ENDPROC
	
	
ENDDEFINE