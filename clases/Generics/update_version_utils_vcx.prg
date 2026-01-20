************************************************************
OBJETO: cls_update_version_ventas
************************************************************
*** PROPIEDADES ***
Name = "cls_update_version_ventas"

*** METODOS ***
PROCEDURE instalar_tabla_pedext_invalidos
*********************************************************************
* Permite agregar una tabla vinculada a pedext para los ítems
* inválidos.
*********************************************************************
Local lcSql

Text To lcSql Noshow
	Create Table If Not Exists pedextinv (
		id int not null unique auto_increment,
		idPedCab int not null,
		idCliente int not null,
		idArticulo int null,
		idVentasC int null,
		fecEmis datetime,
		codArt varchar(20),
		cantidad decimal(10, 5),
		observ text null,
		tipoSist int not null,
		primary Key(id),
		Foreign Key (idCliente) References clientes (idCliente),
		Foreign Key (idArticulo) References articulos (idArticulo))
EndText

this.ejecutar_comando(lcSql)
ENDPROC
PROCEDURE actualizar_base
*******************************************************
* Cambios de estructuras de tablas del módulo de ventas
*******************************************************
This.instalar_tabla_pedext_invalidos()
ENDPROC


************************************************************
OBJETO: cls_update_version_articulos
************************************************************
*** PROPIEDADES ***
Name = "cls_update_version_articulos"

*** METODOS ***
PROCEDURE agregar_campos_en_articulos
********************************************************
* Permite agregar campos en la tabla artículos
********************************************************
Local lcSql

&& Agrego el campo para indicar si un artículo lleva o no stock
If !This.existe_campo("articulos", "llevastk") Then
	lcSql = "ALTER TABLE articulos ADD llevastk bit NOT NULL DEFAULT 0"
	This.ejecutar_comando(lcSql)
EndIf
ENDPROC
PROCEDURE actualizar_base
****************************************************
* Actualiza las bases de la gestión de artículos
****************************************************
This.agregar_campos_en_articulos()
ENDPROC


************************************************************
OBJETO: cls_update_tabla_arca
************************************************************
*** PROPIEDADES ***
Name = "cls_update_tabla_arca"

*** METODOS ***
PROCEDURE actualizar_unidades_medidas
*******************************************************************
* Agrega campo para ARCA.
*******************************************************************

LOCAL lcSql

IF !This.existe_campo("unidmed", "cod_arca") THEN
	TEXT TO lcSql NOSHOW
		ALTER TABLE unidmed ADD cod_arca VARCHAR(10) NULL AFTER descripcio
	ENDTEXT
	This.ejecutar_comando(lcSql)
	
	* Actualizo campos
	lcSql = "UPDATE unidmed SET cod_arca = '07' WHERE codUM = 'UNI'"
	This.ejecutar_comando(lcSql)
	lcSql = "UPDATE unidmed SET cod_arca = '02' WHERE codUM = 'MET'"
	This.ejecutar_comando(lcSql)
ENDIF
ENDPROC
PROCEDURE actualizar_base
*********************************************************
* Actualiza la base de datos para mayor compatibilidad
* con ARCA.
*********************************************************
This.actualizar_unidades_medidas()
ENDPROC


************************************************************
OBJETO: cls_update_version
************************************************************
*** PROPIEDADES ***
url = 
nombre_ejecutable_c1 = 
nombre_ejecutable_c2 = 
modo_desa = .F.
current_path = 
es_cuenta_1 = .F.
version_actual = 
Name = "cls_update_version"

*** METODOS ***
PROCEDURE actualizar_version
**********************************************************************
* Método principal que permite actualizar la versión del sistema.
**********************************************************************
Local lnResp
Local loUpdBD
Local loUpdBDVentas
Local loUpdBDArticulos
LOCAL loUpdDBLogistica

* Verifico que el compartido esté disponible
If !this.modo_desa Then
	If !This.verificar_compartido() Then
		MessageBox("La ruta " + Alltrim(This.url) + " no se encuentra accesible", 0+16, "Actualización de sistema")
		Return
	EndIf
EndIf

* Actualizo la base de datos haya o no haya versión nueva.
loUpdBD = CreateObject("cls_update_version_bd")
loUpdBDVentas = CreateObject("cls_update_version_ventas")
loUpdBDArticulos = CreateObject("cls_update_version_articulos")
loUpdBDTablasArca = CREATEOBJECT("cls_update_tabla_arca")
loUpdDBLogistica = CREATEOBJECT("cls_update_logistica")

loUpdBD.Actualizar_Base()
loUpdBDVentas.Actualizar_Base()
loUpdBDArticulos.actualizar_base()
loUpdBDTablasArca.actualizar_base()
loUpdDBLogistica.actualizar_base()

* Verifico si hay una versión nueva del ejecutable
If This.hay_version_nueva() Then
	lnResp = MessageBox("Se detectó una versión nueva del sistema, querés actualizarla", 4+32, "Actualizar sistema")
	If lnResp = 6 Then
		This.obtener_actualizacion()
		
		* Actualizo el Ejecutable
		This.actualizar_ejecutables()
	EndIF
EndIf
ENDPROC
PROCEDURE obtener_actualizacion
************************************************************
* Permite copiar los archivos de una nueva actualización
* desde el compartido a la estación de trabajo.
************************************************************

Local lcOrigen
Local lcDestino

lcOrigen = ""
lcDestino = ""

* Tomo el ejecutable dependiendo de si es demo o no.
If This.es_cuenta_1 Then
	lcOrigen = this.url +  this.nombre_ejecutable_c1
	lcDestino = This.current_path + "upgrades\" + this.nombre_ejecutable_c1
	Delete File lcDestino
Else
	lcOrigen = this.url +  this.nombre_ejecutable_c2
	lcDestino = this.current_path + "upgrades\" + this.nombre_ejecutable_c2
	Delete File lcDestino
EndIf

* Copio el archivo a la carpeta upgrade
Copy File (lcOrigen) To (lcDestino)




ENDPROC
PROCEDURE hay_version_nueva
******************************************************************
* Este método verifica la versión actual del ejecutable
******************************************************************

Local laVersion[1], lcVersionActual, lnElemento, lnResp

* Valido que las rutas estén accesibles
If !File(this.url + "version.txt") Then
	MessageBox("No se encontró el archivo" + this.url + "version.txt", 0+48, "Actualización del sistema")
	Return .F.
EndIf

If !File(this.current_path + "upgrades\version.txt") Then
	MessageBox("No se encontró el archivo" + this.current_path + "upgrades\version.txt", 0+48, "Actualización del sistema")
	Return .F.
Endif

Copy File (this.url + "version.txt") to (this.current_path + "upgrades\version.txt")

* Verifico si el ejecutable es de c1 o c2
If File(This.current_path + This.nombre_ejecutable_c1) Then
	This.es_cuenta_1 = .t.
	lnElemento = AGetFileVersion(laVersion, This.nombre_ejecutable_c1)
Else
	This.es_cuenta_1 = .f.
	lnElemento = AGetFileVersion(laVersion, This.nombre_ejecutable_c2)
EndIf

* Levanto la versión actual
If lnElemento > 0 Then
	lcVersionActual = laVersion[4]
EndIf
this.version_actual = lcVersionActual
If !(FileToStr("upgrades\version.txt") == lcVersionActual) Then
	Return .T.
EndIf

Return .F.
ENDPROC
PROCEDURE actualizar_ejecutables
******************************************************************
* Permite actualizar los archivos ejecutables. La actualización
* la hace ejecutando el archivo upgrade.bat
******************************************************************
Local oShell

oShell = CreateObject("WScript.Shell")
oShell.Run(This.current_path + "\upgrade.bat")
ENDPROC
PROCEDURE verificar_compartido
************************************************
* Verifica que el compartido esté visible o no.
************************************************
Return Directory(this.url)

ENDPROC
PROCEDURE Init
*******************************************************************
* Inicializo las variables con los valores de la tabla de
* configuración.
* NOTA: URL va a ser en realidad un path pero queda por tema de
* compatibilidad
*******************************************************************

Set Safety Off

This.url = getGlobalCFG("UPD_URL")
This.nombre_ejecutable_c1 = getGlobalCFG("UPD_EXEC1")
This.nombre_ejecutable_c2 = getGlobalCFG("UPD_EXEC2")
This.current_path = Sys(5) + Sys(2003) + "\"
This.modo_desa = getGlobalCFG("MODODESA")
ENDPROC


************************************************************
OBJETO: cls_update_logistica
************************************************************
*** PROPIEDADES ***
Name = "cls_update_logistica"

*** METODOS ***
PROCEDURE crear_tabla_remito
**************************************************************
* Permite crear la tabla de remitos.
* Desarrollado por: Zulli, Leonardo Diego
* Fecha: 01/12/2025
**************************************************************

LOCAL lcSql
LOCAL loCmd

loCmd = CREATEOBJECT("odbc_command")
TEXT TO lcSql NOSHOW
	CREATE TABLE IF NOT EXISTS vtasrtos (
		idVtaRto int not null COMMENT 'Identificación única del remito',
		idVentasC int not null COMMENT 'Id. de comprobante de venta asociado',
		idTransp int not null COMMENT 'Id. de transporte asociado',
		codTrans int not null COMMENT 'Código de transporte asociado',
		razSocTrn varchar(60) not null COMMENT 'Razón Social del transporte asociado',
		fecha datetime not null default current_timestamp COMMENT 'Fecha de emisión del remito',
		cbte varchar(3) not null COMMENT 'Tipo de comprobante',
		tipoDoc varchar(1) not null COMMENT 'Letra del comprobante',
		ptovta int not null COMMENT 'Punto de venta de donde sale el remito',
		numCbte int not null COMMENT 'Número de remito',
		nrocomp varchar(20) not null COMMENT 'Número completo de remito',
		cantItems int not null COMMENT 'Cantidad de ítem que tiene el remito',
		usuAlta varchar(5) not null COMMENT 'Usuario de alta',
		fecAlta datetime not null default current_timestamp COMMENT 'Usuario de baja',
		idHostAlta varchar(50) not null COMMENT 'Host de alta',
		usuModi varchar(5) null COMMENT 'Usuario de modificación',
		fecModi datetime null COMMENT 'Fecha de modificación',
		idHostModi varchar(50) null COMMENT 'Host de modificación',
		usuBaja varchar(5) null COMMENT 'Usuario de baja',
		fecBaja datetime null COMMENT 'Fecha de baja',
		idHostBaja varchar(50) null COMMENT 'Host de baja',
		PRIMARY KEY (idVtaRto, idVentasC),
		FOREIGN KEY (idVentasC) REFERENCES ventascab (idVentasC),
		FOREIGN KEY (idTransp) REFERENCES transp (idTransp)
	)ENGINE=InnoDB
ENDTEXT

loCmd.ActiveConnection = goConn.ActiveConnection
loCmd.CommandText = lcSql
IF !loCmd.Execute() THEN
	This.error_message = "Error al generar la tabla remitos"
	RETURN .F.
ENDIF

RELEASE loCmd

RETURN .T.
ENDPROC
PROCEDURE agregar_parametros
*****************************************************************
* Agrego los parámetros para impresión de remitos.
*****************************************************************

&& El siguente parámetro sirve para que pregunte por factura o no
This.ejecutar_comando("CALL globalcfg_insert('RTOIMPXFC', 'L', 'false', 0)")
ENDPROC
PROCEDURE actualizar_base
************************************************************************
* Actualiza la base de datos del módulo de logística.
* Desarrollado por: Zulli, Leonardo Diego
* Fecha: 01/12/2025
************************************************************************

This.crear_tabla_remito()
This.agregar_parametros()
ENDPROC


************************************************************
OBJETO: cls_update_version_bd
************************************************************
*** PROPIEDADES ***
Height = 16
Width = 100
upd_sql_loc = .F.
upd_sql_path = 
modo_desa = .F.
error_message = 
upd_script_filename = 
current_path = 
url = 
Name = "cls_update_version_bd"

*** METODOS ***
PROCEDURE actualizar_base
*************************************************************************
* Método principal para actualizar estructura de base de datos.
*************************************************************************
LOCAL lcSQLScripts

* Agrego los parámetros nuevos
This.agregar_parametros()

* Creo o actualizo los SPs iniciales
This.configurar_sistema()

TEXT TO lcSQLScripts NOSHOW PRETEXT 15
	sp_test.sql, sp_citicpa_generarAlic.sql, sp_citicpas_generarCabecera.sql,
	sp_citicpas_obtenerAlicuotas.sql, sp_articulos_update.sql, sp_articulos_insert.sql,
	sp_ventascab_getbyid.sql, sp_articulos_updateByPrecioFinal.sql, sp_vtasrtos_generar.sql,
	sp_vtasrtos_generar_c2.sql, sp_ranking_ventas.sql,
ENDTEXT

This.actualizar_spfn(ALLTRIM(lcSQLScripts))
This.agregar_condicion_iva_receptor_id()
This.instalar_tabla_tipospagos()


ENDPROC
PROCEDURE ejecutar_upd_spfn
************************************************************************
* Permite actualizar los procedimientos almacenados
************************************************************************
LPARAMETERS tcScript
LOCAL lcTempScript, lcSql, lnIndex, lnCommandCount

lcTempScript = ALLTRIM(tcScript)
lnCommandCount = GETWORDCOUNT(lcTempScript, "$$")

* Arranco de la posición 2 para evitar que quiera ejecutar el DELIMITER
FOR lnIndex = 2 TO lnCommandCount
	lcSql = ALLTRIM(GETWORDNUM(lcTempScript, lnIndex, "$$"))

	IF !EMPTY(lcSql) THEN
		this.ejecutar_comando(lcSql)
	ENDIF
ENDFOR

RETURN .T.
ENDPROC
PROCEDURE actualizar_spfn
*-------------------------------------------------------------------------
* Método: actualizar_spfn()
* Propósito: Actualiza los procedimientos almacenados o funciones (SPFN)
* en la base de datos MariaDB.
*-------------------------------------------------------------------------
* Código del método que pasaste
****************************************************************************
* Permite actualizar procedimientos almacenados o funciones.
****************************************************************************
PARAMETERS tcSQLFiles
LOCAL lcSQLFile, lnFileCount, lnIndex, loProgressBar

loProgressBar = CreateObject("_thermometer")
loProgressBar.show()

lnFileCount = GETWORDCOUNT(tcSQLFiles, ",")

FOR lnIndex = 1 TO lnFileCount
	lcSQLFile = ALLTRIM(GETWORDNUM(tcSQLFiles, lnIndex, ","))
	
	IF !FILE(lcSQLFile) THEN
		MESSAGEBOX("No se encontró el archivo " + lcSQLFile + " en el proyecto.", 0+16, "Error de actualización")
		RETURN .F.
	ENDIF
	
	lcSQLContent = FILETOSTR(lcSQLFile)
	
	IF EMPTY(lcSQLContent) THEN
		This.error_message = "El archivo " + ALLTRIM(lcFilePath) + " está vacío."
		RETURN .F.
	ENDIF
	
	This.ejecutar_upd_spfn(lcSQLContent)
	
	loProgressBar.update(((lnIndex * 100) / lnFileCount), "Actualizando procedimiento/función " + lcSQLFile)
ENDFOR

loProgressBar.Complete()

RETURN .T.

ENDPROC
PROCEDURE configurar_sistema
******************************************************************************
* Permite configurar la base de datos de forma básica para modo desarrollo
* independientemente del cliente.
******************************************************************************

Local lcScriptFileName
Local lcScript
Local lcSql

lcScriptFileName = ""
lcScript = ""

If This.modo_desa Then
	* Si estoy en modo desa busco la configuración modo desa
	lcScriptFileName = This.current_path + "upgrades\utils_configurar_desa.sql"
Else
	* Si estoy en modo producción, busco la configuración de producción.
	lcScriptFileName = This.current_path + "upgrades\utils_configurar_prod.sql"
EndIf

* Proceso el script instrucción por instrucción
lcScript = FileToStr(lcScriptFileName)
For i = 1 to GetWordCount(lcScript, ";")
	lcSql = GetWordNum(lcScript, i, ";")
	
	* Me aseguro de que llegue una instrucción SQL
	If !Empty(lcSql) Then
		If !This.ejecutar_comando(lcSql) Then
			Return .F.
		EndIF
	EndIf
Next i

Return .T.
ENDPROC
PROCEDURE ejecutar_comando
**********************************************************************************
* Permite ejecutar un comando SQL para actualizaciones
**********************************************************************************
Lparameters tcSql

Local loCmd
loCmd = CreateObject("odbc_command")
loCmd.CommandText = tcSql
loCmd.ActiveConnection = goConn.ActiveConnection

If !loCmd.Execute() Then
	This.error_message = loCmd.ErrorMessage
	Return .F.
EndIf

Return .T.
ENDPROC
PROCEDURE instalar_globalcfg_insert
*******************************************************************
* Crea el SP globalcfg_insert
*******************************************************************
Local lcSql

lcSql = "DROP PROCEDURE IF EXISTS globalcfg_insert;"
If !This.Ejecutar_comando(lcSql) Then
	Return
EndIf

Text to lcSql NoShow
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
EndText

This.ejecutar_comando(lcSql)


ENDPROC
PROCEDURE instalar_agregar_menu
***************************************************************
* Crea o actualiza el SP agregar_menu
***************************************************************

Local lcSql

lcSql = "DROP PROCEDURE IF EXISTS agregar_menu"
If !This.Ejecutar_comando(lcSql) Then
	Return
EndIf

Text to lcSql NoShow
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
EndText

This.ejecutar_comando(lcSql)

ENDPROC
PROCEDURE existe_campo
*******************************************************************************
* Verifica si un campo existe o no.
*******************************************************************************

Lparameters tcTabla, tcCampo

Local loRes
Local llReturn

Wait Window "Chequeando campo si existe " + tcCampo + "..." Nowait

loRes = Createobject("odbc_result")
loRes.Cursor_Name = "cur_x"
loRes.ActiveConnection = goConn.ActiveConnection
loRes.OpenQuery("describe " + tcTabla)
Select cur_x
Go Top
Do While !Eof("cur_x")
	If Lower(Alltrim(cur_x.Field)) == Lower(Alltrim(tcCampo)) Then
		loRes.Close_Query()
		Return .T.
	Endif

	Select cur_x
	Skip
Enddo
loRes.Close_Query()
Return .F.

ENDPROC
PROCEDURE agregar_condicion_iva_receptor_id
***********************************************************
* Permite agregar el condición iva recepctor id para
* los cambios ARCA
* Fecha: 20/02/2024
***********************************************************

Local lcSql
Local loCmd

lcSql = ""
loCmd = CreateObject("odbc_command")

If !This.existe_campo("sitiva", "conivareid") Then
	lcSql = "ALTER TABLE sitiva ADD conivareid int NOT NULL DEFAULT 0"
	loCmd.ActiveConnection = goConn.ActiveConnection
	this.ejecutar_comando(lcSql)
	
	&& Hago los updates
	lcSql = "UPDATE sitiva SET conivareid = 1 WHERE idSitIVA = 1"
	this.ejecutar_comando(lcSql)
	lcSql = "UPDATE sitiva SET conivareid = 5 WHERE idSitIVA = 3"
	this.ejecutar_comando(lcSql)
	lcSql = "UPDATE sitiva SET conivareid = 4 WHERE idSitIVA = 5"
	this.ejecutar_comando(lcSql)
	lcSql = "UPDATE sitiva SET conivareid = 6 WHERE idSitIVA = 6"
	this.ejecutar_comando(lcSql)
	lcSql = "UPDATE sitiva SET conivareid = 7 WHERE idSitIVA = 7"
	this.ejecutar_comando(lcSql)
EndIf

Return .t.
ENDPROC
PROCEDURE instalar_tabla_tipospagos
*****************************************************************
* Permite crear la tabla de tipos de pagos y cargar los
* registros predeterminados.
*****************************************************************

Local lcSql
Local loRes

Text To lcSql Noshow
	CREATE TABLE IF NOT EXISTS tipospagos (
		idTipoPago INT NOT NULL PRIMARY KEY,
		codTipoPag VARCHAR(10) NOT NULL UNIQUE,
		descripcio VARCHAR(200) NOT NULL);
EndText
This.ejecutar_comando(lcSql)

&& Inserto la los registros predeterminado
Text To LcSql NoShow
	REPLACE INTO tipospagos (idTipoPago, codTipoPag, descripcio)
	VALUE 
		(1, 'CHEQ', 'Cheque'), 
		(2, 'DEP', 'Depósito'), 
		(3, 'EFVO', 'Efectivo'), 
		(4, 'RIB', 'Retención Ingreso Brutos'), 
		(5, 'TACR', 'Tarjeta de Crédito'), 
		(6, 'TADB', 'Tarjeta de Débito'), 
		(7, 'TRB', 'Transferencia Bancaria');
EndText
This.ejecutar_comando(lcSql)




ENDPROC
PROCEDURE agregar_parametros
*******************************************************************************
* Permite agregar los parámetros nuevos a la tabla GlobalCFG evitando de
* que cada vez que se inicie el sistema se modifique el valor en caso de que
* existe y tenga una configuración ya establecida.
*******************************************************************************

LOCAL lcSql

&& Agrego el parámetro MODO MOSTRADOR para funcionalidad de ingreso cantidad*codigo_barra
This.ejecutar_comando("CALL globalcfg_insert('MODOMOST', 'L', 'false', 0)")
ENDPROC
PROCEDURE Init
*************************************************************
* Inicializo las propiedades
*************************************************************

This.current_path = Alltrim(Sys(5) + Sys(2003)) + "\"
This.upd_sql_loc = getGlobalCFG("UPDSQLLOC")
This.modo_desa = getGlobalCFG("MODODESA")
This.url = getGlobalCFG("UPD_URL")

If This.modo_desa Then
	* Busca ubicación en los fuentes (Modo desarrollo)
	This.upd_sql_path = getGlobalCFG("UPDSQLPATH")
Else
	* Busca ubicación en producción
	This.upd_sql_path = This.current_path + "upgrades\scripts\"
ENDIF
ENDPROC


