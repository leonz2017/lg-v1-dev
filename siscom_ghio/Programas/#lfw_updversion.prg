**
* lfw_updversion.prg
* Contiene las funciones principales para actualizar las bases de
* datos del sistema
*
* Desarrollado por: LINFOW - Leonardo D. Zulli
* Fecha: 09/09/2021
**

FUNCTION actualizarVersion
	**
	* Verifica si hay una versión nueva y lo encuentra lo actualiza.
	**
	LOCAL lcURL
	LOCAL lcExeFileNameC1
	LOCAL lcExeFileNameC2
	LOCAL oshell AS "WScript.Shell"
	LOCAL laVersion[1], lcVersionActual, lnElemento, lnResp
	
	TRY
		&& Instalo los SPs iniciales
		instalarSPInicial()
	
		&& Actualización de parámetros
		agregarOActualizarParametros()
		
		&& Configuro las URL de descarga
		lcURL = getGlobalCFG("UPD_URL")
		lcExeFileNameC1 = getGlobalCFG("UPD_EXEC1")
		lcExeFileNameC2 = getGlobalCFG("UPD_EXEC2")
		
		&& Verifico si hay actualización del sistema siempre y cuando la PC
		&& se encuentre conectada a internet
		IF internet() THEN
			IF FILE(SYS(5) + SYS(2003) + "\" + lcExeFileNameC1) THEN
				lnElemento = AGETFILEVERSION(laVersion, lcExeFileNameC1)
			ELSE
				lnElemento = AGETFILEVERSION(laVersion, lcExeFileNameC2)
			ENDIF
			IF lnElemento > 0 THEN
				lcVersionActual = laVersion[4]
			ENDIF
			
			&& Verifico si hay una versión nueva para actualizar
			=VFPHTTP(lcURL + "version.txt", "upgrades/version.txt")
			IF !(FILETOSTR("upgrades\version.txt") == lcVersionActual) THEN
				lnResp = MESSAGEBOX("Hay una actualización disponible!!!, ¿desea actualizar ahora?", 4+32, "Mensaje del sistema")
				IF lnResp = 6 THEN
					IF FILE(SYS(5) + SYS(2003) + "\" + lcExeFileNameC1) THEN
						=VFPHTTP(lcURL + lcExeFileNameC1, "upgrades/" + lcExeFileNameC1)
					ELSE
						=VFPHTTP(lcURL + lcExeFileNameC2, "upgrades/" + lcExeFileNameC2)
					ENDIF
					oshell = CREATEOBJECT("WScript.Shell")
					oshell.run(SYS(5) + SYS(2003) + "\upgrade.bat")
				ENDIF
			ENDIF
			
			&& Actualizo los cambios en la base de datos.
			&& Esta actualización se ejecuta siempre porque a veces puede que
			&& haga un ajuste en algún SP sin necesidad de pisar el ejecutable.
			WAIT WINDOW "Actualizando base..." NOWAIT			
			=checkSqlDirectory()		&& Verifico si el directorio de scripts existe sino lo crea.
			&& Solo instalo los scripts si el sistema está en producción.
			=instalar_scripts(lcURL)
			
			&& Actualizo estrucutras de base de datos	
			actualizar_bd()
			actualizarSPs()
			actualizar_funciones()
			
			&& Agrego menues
			*WAIT WINDOW "Chequeando menues..." NOWAIT
			*agregarMenu("4.19", "Promociones", "DO FORM frm_abm_promociones", .T., 4, "", 4019)
			agregarMenu("4.20", "Artículos pedidos por proveedor", "DO FORM frm_artped_byprov", .T., 4, "", 4020)
			
			
			WAIT WINDOW "Base actualizada" NOWAIT
		ELSE
			MESSAGEBOX("La PC no tiene acceso a internet en estos momentos", 0+48, "")
		ENDIF
	CATCH TO oException
		MESSAGEBOX(oException.message ;
			+ " " ; 
			+ oException.Procedure;
			+ " ";
			+ STR(oException.LineNo), 0+16, "Sistema")
	ENDTRY
	RETURN lcVersionActual
ENDFUNC

PROCEDURE instalarSPInicial
	**
	* Cargo los Sps Iniciales
	**
	LOCAL loCmd
	
	ejecutar_comando("DROP PROCEDURE IF EXISTS globalcfg_insert;")
	
	loCmd = CREATEOBJECT("odbc_command")
	TEXT TO loCmd.CommandText NOSHOW
		CREATE PROCEDURE globalcfg_insert (
			xkey varchar(10),
		    xtype varchar(1),
		    xvalue varchar(255),
		    xreemplazar bit
		)
		BEGIN
		    DECLARE proximoId int;
			DECLARE existeParametro bit;
		    SET existeParametro = (
		        SELECT
		            CASE WHEN count(*) > 0 THEN 1 ELSE 0 END
		        FROM
		            global_cfg
		        WHERE 
		            global_cfg.cfg_key = xkey
		    );

		    IF NOT existeParametro THEN
		        SET proximoId = (
		            SELECT
		                MAX(idGlobalCF) + 1
		            FROM
		                global_cfg
		        );

		        INSERT INTO global_cfg (
		            idGlobalCF,
		            cfg_key,
		            cfg_Type,
		            cfg_Value,
		            usuAlta,
		            fecAlta,
		            idHostAlta
		        ) VALUES (
		            proximoId,
		            xkey,
		            xtype,
		            xvalue,
		            'ROOT',
		            current_timestamp,
		            'LINFOW GESTION # Upgrade'
		        );
		    ELSE
		    	-- Solo reemplazo el valor si le indico que lo tiene que hacer.
		    	IF xreemplazar = 1 THEN
		    		UPDATE
		    			global_cfg
		    		SET
		    			cfg_value = xvalue,
		    			usuModi = 'DESA',
		    			fecModi = current_timestamp,
		    			idHostModi = 'ESCRITORIO # Leonardo'
		    		WHERE
		    			cfg_key = xkey;
		    	END IF;
		    END IF;
		END 	
	ENDTEXT
	loCmd.ActiveConnection = goConn.ActiveConnection
	loCmd.Execute()
	
	crearOActualizarSPAgregarMenu()
ENDPROC

PROCEDURE crearOActualizarSPAgregarMenu
	**
	* Crea o actualiza el procedimiento almacenado para agregar menues
	**
	LOCAL lcSql
	
	ejecutar_comando("DROP PROCEDURE IF EXISTS agregar_menu")
	TEXT TO lcSql NOSHOW
		CREATE PROCEDURE agregar_menu (
		  xCodMenu	varchar(20),
		  xNombre	varchar(60),
		  xProcedim	varchar(60),
		  xIsChild	bit(1),
		  xEnlace	int(11),
		  xacc_key	varchar(30),
		  xorden	int
		)
		BEGIN
			/**
		     * Agrega un menú al sistema si no existe.
		    */
			DECLARE vProxId int;
		    DECLARE vExisteMenu bit;
		    DECLARE vIdAcceso int;
		    DECLARE mensaje text;

		    DECLARE EXIT HANDLER FOR SQLEXCEPTION
		    BEGIN
		    	ROLLBACK;
		        GET DIAGNOSTICS CONDITION 1 mensaje = MESSAGE_TEXT;
		        SELECT mensaje;
		    END;

		    SET vExisteMenu = (
		    	SELECT
		        	CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END
		        FROM
		        	menues
		        WHERE
		        	menues.CodMenu = xCodMenu);

		    IF vExisteMenu = 0 THEN
		    	START TRANSACTION;

				SET vProxId = (
		        	SELECT
		            	CASE WHEN MAX(idMenue) IS NULL THEN 1 ELSE MAX(idMenue) + 1 END
		            FROM
		            	menues);

		        INSERT INTO menues (
		          idMenue,
		          CodMenu,
		          Nombre,
		          Procedim,
		          IsChild,
		          Enlace,
		          acc_key,
		          orden,
		          usuAlta,
		          fecAlta,
		          idHostAlta)
		        VALUES (
		          vProxId,
		          xCodMenu,
		          xNombre,
		          xProcedim,
		          xIsChild,
		          xEnlace,
		          xacc_key,
		          xorden,
		          'SUPER',
		          current_timestamp,
		          'SISTEMA');

		    	/* Asocio el menú al usuario SUPER */
		        SET vIdAcceso = (
		        	SELECT
		            	CASE WHEN MAX(idAcceso) IS NULL THEN 1 ELSE MAX(idAcceso) + 1 END
		            FROM
		            	accesos);

		        INSERT INTO accesos (
		        	idAcceso,
		            idUsuario,
		            idMenue
		        ) VALUES (
		        	vIdAcceso,
		            1,
					vProxId);

				COMMIT;
		    END IF;
		END	
	ENDTEXT
	ejecutar_comando(lcSql)
ENDPROC

PROCEDURE actualizar_bd
	**
	* Programa principal para actualizar la base de datos
	**
	crearTablaPromoCab()
	crearTablaPromoMarcas()
	creatTablaPromoArtic()
	crearTablaPromoCli()
	crearTablaPromoClim()
	instalarCpoImpuIntArticulos()
	instalarCpoImpuIntVentas()
	instalarCpoPromocionArticulo()
	acomodarDtosArticulos()
	agregarCampoReportNameEnNumerador()
	acomodarDatosReportesTalonarios()
	agregarNroTransfTablaRCOB_D()
	upd_create_art_exivapto()	
	* cambiarVersionFormPTO()
ENDPROC

PROCEDURE crearTablaPromoCab
	**
	* Creo la tabla de promociones de cabecera
	**
	LOCAL lcSql
	WAIT WINDOW "Creando tabla promo_cab si no existe" NOWAIT
	TEXT TO lcSql NOSHOW
		create table if not exists promo_cab (
			idpromo_c 		int not null unique AUTO_INCREMENT			    comment 'Id. de promoción',
		    nombre 			varchar(60) not null							comment 'Nombre de la promoción',
		    vigencia_d 		datetime not null								comment 'Fecha de vigencia desde',
		    vigencia_h 		datetime not null								comment 'Fecha de vigencia hasta',
		    imp_tope 		decimal(20, 2) not null							comment 'Importe tope',
		    usuAlta			varchar(5) not null								comment 'Usuario de alta',
		    fecAlta			datetime not null default current_timestamp 	comment 'Fecha de alta',
		    idHostAlta		varchar(50) not null							comment 'Id. Host de alta',
		    usuModi			varchar(5) null									comment 'Usuario de modificación',
		    fecModi			datetime null									comment 'Fecha de modificación',
		    idHostModi		varchar(50) null								comment 'Id. host de modificación',
		    usuBaja			varchar(5) null									comment 'Usuario de baja',
		    fecBaja			datetime null									comment 'Fecha de baja',
		    idHostBaja		varchar(50) null								comment 'Id. host baja',
		    primary key (idpromo_c)) comment 'Cabecera de promociones';    		
	ENDTEXT
	ejecutar_comando(lcSql)
ENDPROC

PROCEDURE crearTablaPromoMarcas
	**
	* Crea la tabla promociones x marcas
	**
	LOCAL lcSql
	WAIT WINDOW "Creando tabla promo_marcas si no existe" NOWAIT
	TEXT TO lcSql NOSHOW
		create table if not exists promo_marcas (
			idpromo_c int not null	comment 'Id. de cabecera de promoción',
		    idmarca int not null	comment 'Id. de marca asocada',
		    primary key (idpromo_c, idmarca),
		    foreign key (idpromo_c) references promo_cab (idpromo_c),
		    foreign key (idmarca) references marcas (idmarca)) comment 'Marcas que intervienen en la promoción'; 	
	ENDTEXT
	ejecutar_comando(lcSql)
ENDPROC

PROCEDURE creatTablaPromoArtic
	**
	* Creo la tabla promociones por artículo
	**
	LOCAL lcSql
	WAIT WINDOW "Creando tabla promo_artic si no existe" NOWAIT
	TEXT TO lcSql NOSHOW
		create table if not exists promo_artic (
			idpromo_c int not null	comment 'Id. de cabecera de promoción',
		    idArticulo int not null	comment 'Id. de artículo merchandising',
		    primary key (idpromo_c, idArticulo),
		    foreign key (idpromo_c) references promo_cab (idpromo_c),
		    foreign key (idArticulo) references articulos (idArticulo)
		) comment 'Merchandising asociado a la promoción';	
	ENDTEXT
	ejecutar_comando(lcSql)
ENDPROC

PROCEDURE crearTablaPromoCli
	**
	* Crea la tabla promociones por clientes
	**
	LOCAL lcSql
	WAIT WINDOW "Creando tabla promo_cli si no existe" NOWAIT
	TEXT TO lcSql NOSHOW
		CREATE TABLE IF NOT EXISTS promo_cli (
		    id int not null auto_increment      COMMENT 'Id. de medición',
		    idpromo_c int not null              COMMENT 'Id. de cabecera de promoción a analizar',
		    idCliente int not null              COMMENT 'Id. de cliente analizado',
		    idVentasC int not null              COMMENT 'Id. de cabecera de venta',
		    cbte varchar(3) not null            COMMENT 'Tipo de comprobante',
		    cuenta int not null                 COMMENT 'Indica si los valores corresponden a cuenta 1 o 2',
		    imp_tope decimal(20, 2) not null    COMMENT 'Importe tope de la promoción',
		    total_vend decimal(20, 2) not null  COMMENT 'Total vendido vendido de las marcas que se incluyen en la promo',
		    PRIMARY KEY (id),
		    FOREIGN KEY (idpromo_c) REFERENCES promo_cab (idpromo_c),
		    FOREIGN KEY (idCliente) REFERENCES clientes (idCliente)
		) COMMENT 'Esta tabla contiene las mediciones por cliente para alcanzar la promo';	
	ENDTEXT
	ejecutar_comando(lcSql)
ENDPROC

PROCEDURE crearTablaPromoClim
	**
	* Crea la tabla promociones, clientes x merchandising
	**
	LOCAL lcSql
	WAIT WINDOW "Creando tabla promo_clim si no existe" NOWAIT
	TEXT TO lcSql NOSHOW
		CREATE TABLE IF NOT EXISTS promo_clim (
		    id                      int not null auto_increment COMMENT 'Id.',
		    idpromocli              int not null                COMMENT 'Id. de medición asociada',
		    idCliente               int not null                COMMENT 'Id. de cliente asociado',
		    idArticulo              int not null                COMMENT 'Id. de artículo',
		    codArt                  varchar(20) not null        COMMENT 'Código de artículo merchandisign',
		    descripcio              varchar(200) not null       COMMENT 'Descripción del artículo merchandising',
		    cantidad                decimal(20, 2) not null     COMMENT 'Cantidad que se lleva',
		    PRIMARY KEY (id),
		    FOREIGN KEY (idpromocli) REFERENCES promo_cli (id),
		    FOREIGN KEY (idCliente) REFERENCES clientes (idCliente),
		    FOREIGN KEY (idArticulo) REFERENCES articulos (idArticulo)
		) COMMENT 'Esta tabla contiene los merchandasing que se llevará el cliente si alcanza el tope'; 	
	ENDTEXT
	ejecutar_comando(lcSql)
ENDPROC

PROCEDURE instalarCpoImpuIntArticulos
	**
	* Instalo los campos de impuestos internos en la tabla de artículos.
	**

	LOCAL lcSql
	LOCAL lcTabla
	lcTabla = "articulos"
	IF !existe_campo(lcTabla, "usarMonExt") THEN
		WAIT WINDOW "Agregando campo usarMonExt en articulos" NOWAIT
		lcSql = "alter table articulos add usarMonExt bit not null default 0 after tmon; -- Indica si usa moneda extranjera"
		ejecutar_comando(lcSql)
	ENDIF
	
	IF !existe_campo(lcTabla, "usarImpuIn") THEN
		WAIT WINDOW "Agregando campo usarImpuIn en articulos" NOWAIT
		lcSql = "alter table articulos add usarImpuIn bit not null default 0 after prfinalMin; -- Indica si usa impuestos internos"
		ejecutar_comando(lcSql)
	ENDIF
	
	IF !existe_campo(lcTabla, "porImpuIn") THEN
		WAIT WINDOW "Agregando campo porImpuIn en articulos" NOWAIT
		lcSql = "alter table articulos add porImpuIn decimal(5, 2) default 0 after usarImpuIn; -- Porcentaje de impuestos internos"
		ejecutar_comando(lcSql)
	ENDIF
	
	IF !existe_campo(lcTabla, "impImInMay") THEN
		WAIT WINDOW "Agregando campo impImInMay en articulos" NOWAIT
		lcSql = "alter table articulos add impImInMay decimal (20, 2) default 0 after porImpuIn; -- Importe de impuestos internos mayorista."
		ejecutar_comando(lcSql)
	ENDIF
	
	IF !existe_campo(lcTabla, "impImInMin") THEN
		WAIT WINDOW "Agregando campo impImInMin en articulos" NOWAIT
		lcSql = "alter table articulos add impImInMin decimal (20, 2) default 0 after impImInMay; -- Importe de impuestos internos minorista."
		ejecutar_comando(lcSql)
	ENDIF
ENDPROC

PROCEDURE instalarCpoImpuIntVentas
	**
	* Instalo el campo de impuestos internos en las tablas de ventas.
	**

	LOCAL lcSql
	
	IF !existe_campo("ventascab", "totaNoGrav") THEN
		WAIT WINDOW "Agregando campo totaNoGrav en ventascab" NOWAIT
		lcSql = "alter table ventascab add totaNoGrav decimal(20, 2) not null default 0 after impDesc4; -- Total no gravado"
		ejecutar_comando(lcSql)
	ENDIF
	
	IF !existe_campo("ventasdet", "porNoGrav") THEN
		WAIT WINDOW "Agregando campo porNoGrav en ventasdet" NOWAIT
		lcSql = "alter table ventasdet add porNoGrav decimal(5, 2) not null default 0 after impNeto; -- Porcentaje no gravado en el ítem."
		ejecutar_comando(lcSql)
	ENDIF
	
	IF !existe_campo("ventasdet", "baseGrav") THEN
		WAIT WINDOW "Agregando campo baseGrav en ventasdet" NOWAIT
		lcSql = "alter table ventasdet add baseGrav decimal(20, 2) not null default 0 after porNoGrav; -- Base gravada en el ítem. Queda igual a impNeto"
		ejecutar_comando(lcSql)
	ENDIF
	
	IF !existe_campo("ventasdet", "subtNoGrav") THEN
		WAIT WINDOW "Agregando campo subtNoGrav en ventasdet" NOWAIT
		lcSql = "alter table ventasdet add subtNoGrav decimal(20, 2) not null default 0 after baseGrav; -- Base no gravada en el ítem."
		ejecutar_comando(lcSql)
	ENDIF
ENDPROC

PROCEDURE instalarCpoPromocionArticulo
	**
	* Instalo el campo promocion en la tabla de artíoculos
	**
	LOCAL lcSql
	
	IF !existe_campo("articulos", "promocion") THEN
		WAIT WINDOW "Agregando campo promocion en articulos" NOWAIT
		lcSql = "ALTER TABLE articulos ADD promocion bit NOT NULL DEFAULT 0 COMMENT 'Indica si es merchandising o no';"
		ejecutar_comando(lcSql)
	ENDIF
ENDPROC

PROCEDURE agregarOActualizarParametros
	**
	* Agrega o actualiza los parámetros en global_cfg
	**
	WAIT WINDOW "Actualizando parámetros..." NOWAIT
		
	&& Si es modo desa hago que levante los scripts SQL localmente
	IF getGlobalCFG("MODODESA") THEN
		addOrUpdateGlobalCFG("UPDSQLLOC", "L", "true", .T.)
		addOrUpdateGlobalCFG("UPD_URL", "C", "http://localhost/upgrades/ghio/", .T.)
		** Agrego parámetros para sincronización de tickets en forma local o remota
		addOrUpdateGlobalCFG("FELOCAL", "L", "true", .T.)
		addOrUpdateGlobalCFG("FETKDIRFTP", "C", "/var/www/html/wsafip/ticket/desa", .T.)
		addOrUpdateGlobalCFG("UPDSQLPATH", "C", "D:\linfow-projects\www\projects\lfwgst\sql", .T.)
		addOrUpdateGlobalCFG("PTOINCIVA", "L", "false", .T.)
	ELSE
		addOrUpdateGlobalCFG("UPDSQLLOC", "L", "false", .T.)
		addOrUpdateGlobalCFG("UPD_URL", "C", "http://www.linfow.com.ar/linfow_gestion_upgrades/ghio/", .T.)
		
		** Agrego parámetros para sincronización de tickets en forma local o remota
		addOrUpdateGlobalCFG("FELOCAL", "L", "false", .F.)
		addOrUpdateGlobalCFG("FETKDIRFTP", "C", "/var/www/html/wsafip/ticket/produccion", .F.)
		addOrUpdateGlobalCFG("FE_TICKACC", "C", "Q:\wsafip\ticket.txt", .F.)
		addOrUpdateGlobalCFG("PTOINCIVA", "L", "false", .F.)
	ENDIF
	
	addOrUpdateGlobalCFG("UPD_EXEC1", "C", "siscom_ghioc1.exe", .F.)
	addOrUpdateGlobalCFG("UPD_EXEC2", "C", "siscom_ghio_dmo.exe", .F.)
	
	* Agrego parámetro para directorio temporal
	addOrUpdateGlobalCFG("TEMPDIR", "C", "", .F.)
	
	* Agrego parámetros para FTP
	addOrUpdateGlobalCFG("FTPHOST", "C", "", .t.)
	addOrUpdateGlobalCFG("FTPUSER", "C", "", .t.)
	addOrUpdateGlobalCFG("FTPPASS", "C", "", .t.)
	addOrUpdateGlobalCFG("FTPPORT", "C", "", .t.)
	addOrUpdateGlobalCFG("FTPINIDIR", "C", "", .t.)
	addOrUpdateGlobalCFG("USA_SFTP", "L", "", .t.)
	
	* URL de actualizador
	addOrUpdateGlobalCFG("URLUPDATER", "C", "", .F.)
ENDPROC

PROCEDURE acomodarDtosArticulos
	**
	* Acomoda datos de artículos de los que por lo general se viene generando algún dato en blanco al
	* arrancar el sistema.
	**
	LOCAL lcSql
	lcSql = "UPDATE articulos SET tmon = 'PSO' WHERE tmon = '' AND prListaExt = 0"
	ejecutar_comando(lcSql)
	
	&& Agrego función para que marque usarMonExt en 1 a los que tienen tmon <> 'PSO' porque este
	&& campo es nuevo
	lcSql = "UPDATE articulos SET usarMonExt = 1 WHERE tmon <> 'PSO'"
	ejecutar_comando(lcSql)
ENDPROC

PROCEDURE agregarCampoReportNameEnNumerador
	***************************************************************
	* Permite agregar el campo repname para establecer el nombre de
	* reporte que debe invocar al imprimir el comprobante.
	***************************************************************
	IF !existe_campo("numerador", "repname") THEN
		lcSql = "ALTER TABLE numerador ADD repname varchar(100) NULL COMMENT 'Nombre de reporte a invocar';"
		ejecutar_comando(lcSql)
		lcSql = "ALTER TABLE numerador ADD repnamecp varchar(100) NULL COMMENT 'Nombre de reporte a invocar en comprobantes por conceptos';"
		ejecutar_comando(lcSql)
	ENDIF
ENDPROC

****************************************************************
* Acomoda los nombres de reportes a usar en el talonario.
*****************************************************************
PROCEDURE acomodarDatosReportesTalonarios
	LOCAL lcSql

	lcSql = "UPDATE numerador SET repname = 'repcbtesvta' WHERE cbte = 'FC' AND tipoDoc = 'A'"
	ejecutar_comando(lcSql)
	lcSql = "UPDATE numerador SET repname = 'repcbtesvta_b' WHERE cbte = 'FC' AND tipoDoc = 'B'"
	ejecutar_comando(lcSql)
	lcSql = "UPDATE numerador SET repname = 'reppedido' WHERE cbte = 'PED'"
	ejecutar_comando(lcSql)

	lcSql = "UPDATE numerador SET repname = 'repcbtesvta', repnamecp = 'repncnd' WHERE cbte = 'NC' AND tipoDoc = 'A'"
	ejecutar_comando(lcSql)
	lcSql = "UPDATE numerador SET repname = 'repcbtesvta_b', repnamecp = 'repncnd_b' WHERE cbte = 'NC' AND tipoDoc = 'B'"
	ejecutar_comando(lcSql)
	lcSql = "UPDATE numerador SET repname = 'reppto', repnamecp = 'repncnd_x' WHERE cbte = 'NC' AND ptoVta = 9999"
	ejecutar_comando(lcSql)

	lcSql = "UPDATE numerador SET repname = NULL, repnamecp = 'repncnd' WHERE cbte = 'ND' AND tipoDoc = 'A'"
	ejecutar_comando(lcSql)
	lcSql = "UPDATE numerador SET repname = NULL, repnamecp = 'repncnd_b' WHERE cbte = 'ND' AND tipoDoc = 'B'"
	ejecutar_comando(lcSql)
	lcSql = "UPDATE numerador SET repname = NULL, repnamecp = 'repncnd_x' WHERE cbte = 'ND' AND ptoVta = 9999"
	ejecutar_comando(lcSql)

	lcSql = "UPDATE numerador SET repname = 'rep_recibos', repnamecp = NULL WHERE cbte = 'RC'"
	ejecutar_comando(lcSql)
	lcSql = "UPDATE numerador SET repname = 'reppto', repnamecp = NULL WHERE cbte = 'PTO'"
	ejecutar_comando(lcSql)
	lcSql = "UPDATE numerador SET repname = 'repcot', repnamecp = NULL WHERE cbte = 'COT'"
	ejecutar_comando(lcSql)
	lcSql = "UPDATE numerador SET repname = 'rep_rtos', repnamecp = NULL WHERE cbte = 'RTO'" 
	ejecutar_comando(lcSql)
ENDPROC

PROCEDURE agregarNroTransfTablaRCOB_D
	****************************************************************
	* Agrega el campo número de transferencia en rccob_d
	****************************************************************
	LOCAL lcSql
	
	IF !existe_campo("rccob_d", "nroTransf") THEN
		lcSql = "ALTER TABLE rccob_d ADD nroTransf varchar(20)"
		ejecutar_comando(lcSql)
	ENDIF
ENDPROC 

*************************************************
* Permite crear la tabla art_exivapto en donde
* se almacenarán los artículos que no deben
* incluir IVA en presupuestos.
*************************************************
PROCEDURE upd_create_art_exivapto
	LOCAL lcSql
	
	TEXT TO lcSql NOSHOW
		CREATE TABLE IF NOT EXISTS art_exivapto (
			id int not null unique auto_increment,
			idArticulo int not null,
			habilitado bit not null default 1,
			usualta varchar(5) not null,
			fecalta datetime not null,
			idhostalta varchar(50) not null,
			usumodi varchar(5) null,
			fecmodi datetime null,
			idhostmodi varchar(50) null,
			usubaja varchar(5) null,
			fecbaja datetime null,
			idhostbaja varchar(50),
			PRIMARY KEY (id),
			FOREIGN KEY (idArticulo) REFERENCES articulos (idArticulo))
	ENDTEXT
	ejecutar_comando(lcSql)
ENDPROC

PROCEDURE cambiarVersionFormPTO
	** Cambia la versión del ingreso de presupuesto en PTO. **
	LOCAL lcSql
	
	TEXT TO lcSql NOSHOW
		UPDATE menues SET Procedim = 'DO FORM frm_pto_c2_v2' WHERE idMenue = 88
	ENDTEXT
	ejecutar_comando(lcSql)
ENDPROC