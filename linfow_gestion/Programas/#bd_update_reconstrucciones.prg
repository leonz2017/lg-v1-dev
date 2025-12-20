************************************************************
* Permite crear y/o actualizar las estructuras de las tablas
* del módulo de reconstrucciones.
************************************************************

PROCEDURE update_reconstrucciones
	* Módulo de reconstruccion de neumáticos
	crearTablaRcnTiporto()
	crearTablaRcnEstado()
	crearTablaRcnEscare()
	crearTablaRcnRemito()
	crearTablaRcnEstcra()
	crearTablaRcnoperad()
	crearTablaRcnMotivosRechazos()
	crearTablaFicha()
	crearTablaFichaDet()
	crearTablaItemsAuxiliar()
	crearTablaAuxiliarFichaDetalle()
	limpiarModuloReconstrucciones()
	crearTablaTemporalRemitosSalida()
ENDPROC

PROCEDURE crearTablaRcnTiporto
	**
	* Creo la tabla rcn_tiporto si no existe
	**
	LOCAL lcSql
	WAIT WINDOW "Creando tabla rcn_tiporto si no existe" NOWAIT
	TEXT TO lcSql NOSHOW
		CREATE TABLE IF NOT EXISTS rcn_tiporto (
			id_tiporto INT NOT NULL UNIQUE,
			descripcio VARCHAR(30) NOT NULL,
			usuAlta VARCHAR(5) NOT NULL,
			fecAlta DATETIME NOT NULL,
			idHostAlta VARCHAR(50) NOT NULL,
			usuModi VARCHAR(5),
			fecModi DATETIME,
			idHostModi VARCHAR(50),
			usuBaja VARCHAR(5),
			fecBaja DATETIME,
			idHostBaja VARCHAR(50),
			PRIMARY KEY(id_tiporto) 
		) ENGINE=InnoDB
	ENDTEXT
	ejecutar_comando(lcSql)
ENDPROC

PROCEDURE crearTablaRcnEstado
	**
	* Creo la tabla rcn_estado si no existe
	**
	LOCAL lcSql
	WAIT WINDOW "Creando tabla rcn_estado si no existe" NOWAIT
	TEXT TO lcSql NOSHOW
		CREATE TABLE IF NOT EXISTS rcn_estado (
			id_estado INT NOT NULL UNIQUE,
			descripcio VARCHAR(30) NOT NULL,
			usuAlta VARCHAR(5) NOT NULL,
			fecAlta DATETIME NOT NULL,
			idHostAlta VARCHAR(50) NOT NULL,
			usuModi VARCHAR(5),
			fecModi DATETIME,
			idHostModi VARCHAR(50),
			usuBaja VARCHAR(5),
			fecBaja DATETIME,
			idHostBaja VARCHAR(50),
			PRIMARY KEY(id_estado) 
		) ENGINE=InnoDB
	ENDTEXT
	ejecutar_comando(lcSql)
ENDPROC

PROCEDURE crearTablaRcnEscare
	**
	* Creo la tabla rcn_escare si no existe
	**
	LOCAL lcSql
	WAIT WINDOW "Creando tabla rcn_escare si no existe" NOWAIT
	TEXT TO lcSql NOSHOW
		CREATE TABLE IF NOT EXISTS rcn_escare (
			id_escare INT NOT NULL UNIQUE,
			descripcio VARCHAR(30) NULL,
			usuAlta VARCHAR(5) NOT NULL,
			fecAlta DATETIME NOT NULL,
			idHostAlta VARCHAR(50) NOT NULL,
			usuModi VARCHAR(5),
			fecModi DATETIME,
			idHostModi VARCHAR(50),
			usuBaja VARCHAR(5),
			fecBaja DATETIME,
			idHostBaja VARCHAR(50),
			PRIMARY KEY(id_escare) 
		) ENGINE=InnoDB
	ENDTEXT
	ejecutar_comando(lcSql)
ENDPROC

PROCEDURE crearTablaRcnRemito
	**
	* Creo la tabla de remitos
	**
	LOCAL lcSql
	WAIT WINDOW "Creando tabla rcn_remito si no existe" NOWAIT
	TEXT TO lcSql NOSHOW
		CREATE TABLE IF NOT EXISTS rcn_remito (
			id_rtoent INT NOT NULL UNIQUE,
			id_tiporto INT NOT NULL,
			idCliente INT NOT NULL,
			numero VARCHAR(20) NOT NULL,
			destino VARCHAR(200) NOT NULL,
			observaciones TEXT,
			usuAlta VARCHAR(5) NOT NULL,
			fecAlta DATETIME NOT NULL,
			idHostAlta VARCHAR(50) NOT NULL,
			usuModi VARCHAR(5),
			fecModi DATETIME,
			idHostModi VARCHAR(50),
			usuBaja VARCHAR(5),
			fecBaja DATETIME,
			idHostBaja VARCHAR(50),
			PRIMARY KEY(id_rtoent),
			CONSTRAINT fk_rcn_tiporto_id_tiporto FOREIGN KEY (id_tiporto) REFERENCES rcn_tiporto (id_tiporto),
			CONSTRAINT fk_clientes_idCliente FOREIGN KEY (idCliente) REFERENCES clientes (idCliente)
		) ENGINE=InnoDB
	ENDTEXT
	ejecutar_comando(lcSql)
ENDPROC

PROCEDURE crearTablaRcnEstcra
	**
	* Creo la tabla de los estados de crater
	**
	LOCAL lcSql
	WAIT WINDOW "Creando tabla rcn_estcra si no existe" NOWAIT
	TEXT TO lcSql NOSHOW
		CREATE TABLE IF NOT EXISTS rcn_estcra (
			id_estcra INT NOT NULL UNIQUE,
			descripcio VARCHAR(30) NOT NULL,
			usuAlta VARCHAR(5) NOT NULL,
			fecAlta DATETIME NOT NULL,
			idHostAlta VARCHAR(50) NOT NULL,
			usuModi VARCHAR(5),
			fecModi DATETIME,
			idHostModi VARCHAR(50),
			usuBaja VARCHAR(5),
			fecBaja DATETIME,
			idHostBaja VARCHAR(50),
			PRIMARY KEY(id_estcra)
		) ENGINE=InnoDB
	ENDTEXT
	ejecutar_comando(lcSql)
ENDPROC

PROCEDURE crearTablaRcnoperad
	**
	* Creo la tabla de los estados de operadores
	**
	LOCAL lcSql
	WAIT WINDOW "Creando tabla rcn_operad si no existe" NOWAIT
	TEXT TO lcSql NOSHOW
		CREATE TABLE IF NOT EXISTS rcn_operad(
			id_operad INT NOT NULL,
			apelnom VARCHAR(60) NOT NULL,
			usuAlta VARCHAR(5) NOT NULL,
			fecAlta DATETIME NOT NULL,
			idHostAlta VARCHAR(50) NOT NULL,
			usuModi VARCHAR(5),
			fecModi DATETIME,
			idHostModi VARCHAR(50),
			usuBaja VARCHAR(5),
			fecBaja DATETIME,
			idHostBaja VARCHAR(50),
			PRIMARY KEY(id_operad)
		) ENGINE=InnoDB
	ENDTEXT
	ejecutar_comando(lcSql)
ENDPROC

PROCEDURE crearTablaRcnMotivosRechazos
	* Creo la tabla de motivos de rechazos
	LOCAL lcSql
	
	TEXT TO lcSql NOSHOW
		CREATE TABLE IF NOT EXISTS rcn_motrec (
			id_motrec int not null unique,
			descripcio varchar(30) not null,
			usuAlta VARCHAR(5) NOT NULL,
			fecAlta DATETIME NOT NULL,
			idHostAlta VARCHAR(50) NOT NULL,
			usuModi VARCHAR(5),
			fecModi DATETIME,
			idHostModi VARCHAR(50),
			usuBaja VARCHAR(5),
			fecBaja DATETIME,
			idHostBaja VARCHAR(50),
			PRIMARY KEY (id_motrec)) ENGINE=InnoDB
	ENDTEXT
	ejecutar_comando(lcSql)
ENDPROC

PROCEDURE crearTablaFicha
	****************************************************
	* Crea la tabla de ficha.
	****************************************************
	LOCAL lcSql
	
	TEXT TO lcSql NOSHOW
		CREATE TABLE IF NOT EXISTS rcn_ficha (
			id_ficha BIGINT NOT NULL UNIQUE AUTO_INCREMENT COMMENT 'Id. de ficha',
			id_estado INT NOT NULL COMMENT 'Estado',
			id_motrec INT NULL COMMENT 'Motivo de rechazo',
			idmarca INT NOT NULL COMMENT 'Marca de la cubierta',
			medida DECIMAL(20, 2) NOT NULL,
			nro_serie VARCHAR(20) NOT NULL,
			trabajo VARCHAR(100) NOT NULL,
			matricula VARCHAR(100) COMMENT 'Matricula',
			referencia INT COMMENT 'Número de referencia',
			radio DECIMAL(20, 2) COMMENT 'Radio',
			perimetro DECIMAL(20, 2) COMMENT 'Perimetro',
			ancho DECIMAL(20, 2) COMMENT 'Ancho',
			id_rtoent INT,
			id_operad INT,
			id_estcra INT,
			usuAlta VARCHAR(5) NOT NULL,
			fecAlta DATETIME NOT NULL,
			idHostAlta VARCHAR(50) NOT NULL,
			usuModi VARCHAR(5),
			fecModi DATETIME,
			idHostModi VARCHAR(50),
			usuBaja VARCHAR(5),
			fecBaja DATETIME,
			idHostBaja VARCHAR(50),
			PRIMARY KEY (id_ficha),
			FOREIGN KEY (id_rtoent) REFERENCES rcn_remito (id_rtoent),
			FOREIGN KEY (id_operad) REFERENCES rcn_operad (id_operad),
			FOREIGN KEY (id_estcra) REFERENCES rcn_estcra (id_estcra),
			FOREIGN KEY (id_estado) REFERENCES rcn_estado (id_estado),
			FOREIGN KEY (id_motrec) REFERENCES rcn_motrec (id_motrec),
			FOREIGN KEY (idmarca) REFERENCES marcas (idmarca)
		) ENGINE=InnoDB;	
	ENDTEXT
	ejecutar_comando(lcSql)
	
	IF !existe_campo("rcn_ficha", "camsecgdo") THEN
		TEXT TO lcSql NOSHOW
			ALTER TABLE rcn_ficha ADD camsecgdo DECIMAL(20, 2) NULL AFTER referencia, COMMENT 'Cámara de secado grados'
		ENDTEXT
		ejecutar_comando(lcSql)
	ENDIF
	
	IF !existe_campo("rcn_ficha", "observ") THEN
		TEXT TO lcSql NOSHOW
			ALTER TABLE rcn_ficha ADD observ TEXT NULL AFTER ancho, COMMENT 'Observaciones'
		ENDTEXT
		ejecutar_comando(lcSql)
	ENDIF
	
	IF !existe_campo("rcn_ficha", "parch_ant") THEN
		TEXT TO lcSql NOSHOW
			ALTER TABLE rcn_ficha ADD parch_ant bit NOT NULL DEFAULT 0 AFTER observ, COMMENT 'Observaciones'
		ENDTEXT
		ejecutar_comando(lcSql)	
	ENDIF
	
	IF !existe_campo("rcn_ficha", "idop_recep") THEN
		TEXT TO lcSql NOSHOW
			ALTER TABLE rcn_ficha ADD idop_recep INT NULL COMMENT 'Id. Operador recepcion'
		ENDTEXT
		ejecutar_comando(lcSql)
	ENDIF
	
	IF !existe_campo("rcn_ficha", "idop_exapr") THEN
		TEXT TO lcSql NOSHOW
			ALTER TABLE rcn_ficha ADD idop_exapr INT NULL COMMENT 'Id. Operador examen preliminar'
		ENDTEXT
		ejecutar_comando(lcsql)
	ENDIF
	
	IF !existe_campo("rcn_ficha", "idop_rasp") THEN
		TEXT TO lcSql NOSHOW
			ALTER TABLE rcn_ficha ADD idop_rasp INT NULL COMMENT 'Id. operador raspado'
		ENDTEXT
		ejecutar_comando(lcSql)
	ENDIF
	
	IF !existe_campo("rcn_ficha", "idop_esca") THEN
		TEXT TO lcSql NOSHOW
			ALTER TABLE rcn_ficha ADD idop_esca INT NULL COMMENT 'Id. operador ecareacion'
		ENDTEXT
		ejecutar_comando(lcSql)
	ENDIF
	
	IF !existe_campo("rcn_ficha", "idop_appar") THEN
		TEXT TO lcSql NOSHOW
			ALTER TABLE rcn_ficha ADD idop_appar INT NULL COMMENT 'Id. operador de aplicación de parches'
		ENDTEXT
		ejecutar_comando(lcSql)
	ENDIF
	
	IF !existe_campo("rcn_ficha", "vulcaniza") THEN
		TEXT TO lcSql NOSHOW
			ALTER TABLE rcn_ficha ADD vulcaniza bit NOT NULL DEFAULT 0 AFTER referencia, COMMENT 'Vulcanizado' 
		ENDTEXT
		ejecutar_comando(lcSql)
	ENDIF
	
	IF !existe_campo("rcn_ficha", "aprobado") THEN
		TEXT TO lcSql NOSHOW
			ALTER TABLE rcn_ficha ADD aprobado bit NOT NULL DEFAULT 0 AFTER vulcaniza, COMMENT 'Aprobado'
		ENDTEXT
		ejecutar_comando(lcSql)
	ENDIF
	
	IF !existe_campo("rcn_ficha", "aprob_sg") THEN
		TEXT TO lcSql NOSHOW
			ALTER TABLE rcn_ficha ADD aprob_sg bit NOT NULL DEFAULT 0 AFTER aprobado, COMMENT 'Aprobado sin garantía'
		ENDTEXT
		ejecutar_comando(lcSql)
	ENDIF
	
	IF !existe_campo("rcn_ficha", "rechazado") THEN
		TEXT TO lcSql NOSHOW
			ALTER TABLE rcn_ficha ADD rechazado bit NOT NULL DEFAULT 0 AFTER aprob_sg, COMMENT 'Rechazado'
		ENDTEXT
		ejecutar_comando(lcSql)
	ENDIF
	
	IF !existe_campo("rcn_ficha", "id_rtosal") THEN
		* Creo el campo
		TEXT TO lcSql NOSHOW
			ALTER TABLE rcn_ficha ADD id_rtosal INT NULL AFTER id_rtoent, COMMENT 'Id. de remito de salida'
		ENDTEXT
		ejecutar_comando(lcSql)
		
		* Agrego la foreign key con la tabla rcn_remitos
		TEXT TO lcSql NOSHOW
			ALTER TABLE rcn_ficha
				ADD CONSTRAINT fk_rcn_ficha_rcn_remito_salida
					FOREIGN KEY (id_rtosal)
					REFERENCES rcn_remito(id_rtoent)		
		ENDTEXT
		ejecutar_comando(lcSql)
	ENDIF
	
	* Agrego la asociación con ventas.
	IF !existe_campo("rcn_ficha", "idVentasC") THEN
		TEXT TO lcSql NOSHOW
			ALTER TABLE	rcn_ficha ADD idVentasC int NULL, COMMENT 'Factura asociadas'
		ENDTEXT
		ejecutar_comando(lcSql)
		
		TEXT TO lcSql NOSHOW
			ALTER TABLE rcn_ficha
				ADD CONSTRAINT fk_rcn_ficha_rcn_ventas
					FOREIGN KEY (idVentasC) REFERENCES ventascab (idVentasC)
		ENDTEXT
		ejecutar_comando(lcSql)
	ENDIF
ENDPROC

PROCEDURE crearTablaFichaDet
	**************************************************
	* Crea la tabla del detalle de fichas
	**************************************************
	LOCAL lcSql
	
	TEXT TO lcSql NOSHOW
		CREATE TABLE IF NOT EXISTS rcn_fichadet (
			id_fichadet INT,
			id_ficha BIGINT,
		    idArticulo INT,
			cantidad DECIMAL(20, 2),
			codArt VARCHAR(20),
			descripcio VARCHAR(200),
			usuAlta VARCHAR(5) NOT NULL,
			fecAlta DATETIME NOT NULL,
			idHostAlta VARCHAR(50) NOT NULL,
			usuModi VARCHAR(5),
			fecModi DATETIME,
			idHostModi VARCHAR(50),
			usuBaja VARCHAR(5),
			fecBaja DATETIME,
			idHostBaja VARCHAR(50),
			PRIMARY KEY (id_fichadet, id_ficha),
			FOREIGN KEY (id_ficha) REFERENCES rcn_ficha (id_ficha),
			FOREIGN KEY (idArticulo) REFERENCES articulos (idArticulo)
		)ENGINE=InnoDB;	
	ENDTEXT
	ejecutar_comando(lcSql)
ENDPROC

PROCEDURE crearTablaItemsAuxiliar
	**************************************************************
	* Creo una tabla auxiliar con los ítems del remito a generar.
	**************************************************************
	LOCAL lcSql
	
	TEXT TO lcSql NOSHOW
		CREATE TABLE IF NOT EXISTS`rcn_aux_rtitem` (
		  `id` int(11) NOT NULL,
		  `idmarca` int(11) NOT NULL COMMENT 'Marca',
		  `medida` decimal(20,2) NOT NULL COMMENT 'Medida',
		  `nro_serie` varchar(20) NOT NULL COMMENT 'Número de serie',
		  `trabajo` varchar(100) NOT NULL COMMENT 'Trabajo a realizar',
		  `usuario` varchar(5) NOT NULL,
		  `host` varchar(50) NOT NULL,
		  PRIMARY KEY (`id`),
		  UNIQUE KEY `id` (`id`)
		) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
	ENDTEXT
	ejecutar_comando(lcSql)
ENDPROC

PROCEDURE crearTablaAuxiliarFichaDetalle
	***************************************************************
	* Permite crear la tabla de detalle de fichas.
	***************************************************************
	LOCAL lcSql
	TEXT TO lcSql NOSHOW
		CREATE TABLE IF NOT EXISTS rcn_aux_fichadet (
			id int not null unique auto_increment,
			id_ficha int not null,
			cantidad decimal(20, 2),
			idArticulo int NOT NULL,
			codArt varchar(20) not null,
			descripcio varchar(200) not null,
			usuario varchar(5) not null,
			host varchar(50) not null,
			PRIMARY KEY (id)
		)ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
	ENDTEXT
	ejecutar_comando(lcSql)
ENDPROC

PROCEDURE limpiarModuloReconstrucciones
	***************************************************************
	* Permite limpiar el módulo de reconstrucciones.
	* Fecha: 09/06/2023
	***************************************************************
	LOCAL lcSql
	LOCAL loRes
	LOCAL lnIdMenu
	
	lcSql = "DROP TABLE IF EXISTS rcn_rtitem"
	ejecutar_comando(lcSql)
	
	lcSql = "ALTER TABLE rcn_ficha DROP FOREIGN KEY IF EXISTS rcn_ficha_ibfk_4"
	ejecutar_comando(lcSql)
	
	lcSql = "ALTER TABLE rcn_ficha DROP INDEX IF EXISTS id_escare"
	ejecutar_comando(lcSql)
	
	lcSql = "ALTER TABLE rcn_ficha DROP COLUMN IF EXISTS id_escare"
	ejecutar_comando(lcSql)

	lcSql = "DROP TABLE IF EXISTS rcn_escare"
	ejecutar_comando(lcSql)

	loRes = CREATEOBJECT("odbc_result")
	lcSql = "SELECT * FROM menues WHERE CodMenu = '14.2'"
	loRes.ActiveConnection = goConn.ActiveConnection
	loRes.Cursor_Name = "cur_x"
	loRes.OpenQuery(lcSql)
	SELECT cur_x
	lnIdMenu = cur_x.idMenue
	loRes.Close_Query()
	
	lcSql = "DELETE FROM accesos WHERE idMenue = " + ALLTRIM(STR(lnIdMenu))
	ejecutar_comando(lcSql)
	lcSql = "DELETE FROM menues WHERE idMenue = " + ALLTRIM(STR(lnIdMenu))
	ejecutar_comando(lcSql)
ENDPROC


PROCEDURE crearTablaTemporalRemitosSalida
	*********************************************************
	* Permite crear una tabla temporal para las fichas
	* seleccionadas en el remito de salida.
	*********************************************************
	LOCAL lcSql
	
	TEXT TO lcSql NOSHOW
		CREATE TABLE IF NOT EXISTS rcn_aux_fichas_rtosal (
			id int not null unique auto_increment,
			id_ficha int not null,
			usuario varchar(5) not null,
			host varchar(50) not null,
			PRIMARY KEY (id))ENGINE=MyISAM
	ENDTEXT
	ejecutar_comando(lcSql)
ENDPROC