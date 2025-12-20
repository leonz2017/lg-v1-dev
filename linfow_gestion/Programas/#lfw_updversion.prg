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
	LOCAL lcExeFilePSCP
	LOCAL lcFileConfiguracion
	LOCAL oshell AS "WScript.Shell"
	LOCAL laVersion[1], lcVersionActual, lnElemento, lnResp
	

	TRY
		&& Instalo los SPs iniciales
		instalarSPInicial()
					
		&& Actualizo estrucutras de base de datos	
		actualizar_bd()
		
		&& Cargo configuración inicial si los parámetros no existen.
		inicializar_configuracion()
		
		&& Actualización de parámetros
		configurar_sistema()	
				
		&& Configuro las URL de descarga
		lcURL = getGlobalCFG("UPD_URL")
		lcExeFileNameC1 = getGlobalCFG("UPD_EXEC1")
		lcExeFileNameC2 = getGlobalCFG("UPD_EXEC2")
		lcExeFilePSCP = "pscp.exe"
		lcFileConfiguracion = "utils_configurar_prod.sql"
		
		&& Componentes
		
		&& Verifico si hay actualización del sistema siempre y cuando la PC
		&& se encuentre conectada a internet
		IF internet() THEN
			* Descargo el archivo de configuración actualizado
			VFPHTTP(lcURL + lcFileConfiguracion, "upgrades/" + lcFileConfiguracion)
							
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
			
			* Instalacion de componentes
			IF !FILE(lcExeFilePSCP) THEN
				* Instalo el ejecutable para transferir archivos por SFTP
				VFPHTTP(lcURL + lcExeFilePSCP, lcExeFilePSCP)
			ENDIF
						
			&& Actualizo los cambios en la base de datos.
			&& Esta actualización se ejecuta siempre porque a veces puede que
			&& haga un ajuste en algún SP sin necesidad de pisar el ejecutable.
			WAIT WINDOW "Actualizando base..." NOWAIT			
			=checkSqlDirectory()		&& Verifico si el directorio de scripts existe sino lo crea.
			&& Solo instalo los scripts si el sistema está en producción.
			=instalar_scripts(lcURL)
			
			* Actualiza procedimientos almacenados y funciones.
			actualizarSPs()
			actualizar_funciones()
			
			* Agrego los valores predeterminados para la pantalla nueva de facturación.
			vta_insert_alic_ivas()
			
			* Genero el COU para los artículos que no lo tienen.
			cou_actualizar_bd()
			&& Agrego menu
			*WAIT WINDOW "Chequeando menues..." NOWAIT
			*agregarMenu("4.19", "Promociones", "DO FORM frm_abm_promociones", .T., 4, "", 4019)
			
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
	*instalarCpoImpuIntArticulos()
	instalarCpoImpuIntVentas()
	instalarCpoPromocionArticulo()
	acomodarDtosArticulos()
	agregarCampoReportNameEnNumerador()
	ampliarClienteCampoTelefono()
	ampliarProvCampoTelefono()
	agregarNroTransfTablaRCOB_D()
	agregarCamposTablaVendedores()
	upd_create_art_exivapto()
	cja_agregarCampos()
	instalarTablaLogSP()
	vta_agregar_ventasdet_tmp()
	bd_actualizar_numerador()
	bd_acomodar_codafip_numerador()
	agregarCamposCheques()
	vta_agregar_tabla_alicivas()
	ampliarCamposStkCab()
	vta_addCpoVentasDet()
	update_reconstrucciones()
	generarCamposStkCab()
	actualizar_version_pagos()
	ampliarCampoNumeroCheque()
	actualizar_ordenes_trabajo()
	instalar_tabla_pedext_invalidos()
ENDPROC

*********************************************************
* El siguiente procedimiento permite crear los parámetros
* de configuración inicial.
********************************************************* 
PROCEDURE inicializar_configuracion
	addOrUpdateGlobalCFG("MODODESA", "L", "false", .F.)
	addOrUpdateGlobalCFG("UPDSQLLOC", "L", "false", .F.)
	IF !FILE("upgrades/utils_configurar_prod.sql") THEN
		MESSAGEBOX("El archivo utils_configurar_prod.sql no existe", 0+64, "Mensaje del sistema")
	ENDIF
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

PROCEDURE agregarCamposTablaVendedores
	******************************************************
	* Agrego campos en la tabla de vendedores.
	******************************************************
	
	IF !existe_campo("vendedores", "porcomis") THEN
		lcSql = "ALTER TABLE vendedores ADD porcomis DECIMAL(5, 2) NOT NULL DEFAULT 0"
		ejecutar_comando(lcSql)
	ENDIF
ENDPROC

PROCEDURE instalarTablaLogSP
	********************************************************************
	* Agrego la tabla para hacer trace de procedimientos almacenados
	********************************************************************
	LOCAL lcSql
	TEXT TO lcSql NOSHOW
		CREATE TABLE IF NOT EXISTS log_sps (
			id int not null unique auto_increment,
			sp_name varchar(60) not null,
			fecha datetime not null default current_timestamp,
			msgerror text not null,
			usuario varchar(5) not null,
			host varchar(50) not null,
			PRIMARY KEY (id)) ENGINE=MyISAM
	ENDTEXT
	ejecutar_comando(lcSql)
ENDPROC