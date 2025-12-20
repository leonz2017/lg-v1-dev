**
* Instala el código COU para actualizaciones de listas.
*
* Desarrollado por: LINFOW - Leonardo D. Zulli
**

PROCEDURE cou_actualizar_bd
	**
	* Instala los campos COU (Código de Artículo Único) en las tablas de
	* actualizaciones.
	**
	LOCAL lcSql
	
	crearTablaArtTempo()
	crearTablaArtUpdTempo()
	
	IF !existe_campo("articulos", "cou") THEN
		lcSql = "alter table articulos add cou char(32);"
		ejecutar_comando(lcSql)
		lcSql = "alter table articulos add index idx_articulos_cou (cou asc);"
		ejecutar_comando(lcSql)
	ENDIF
	
	IF !existe_campo("art_upd_tempo", "cou") THEN
		lcSql = "alter table art_upd_tempo add cou char(32);"
		ejecutar_comando(lcSql)
		lcSql = "alter table art_upd_tempo add index idx_art_upd_tempo_cou (cou asc);"
		ejecutar_comando(lcSql)
	ENDIF
	
	IF !existe_campo("art_tempo", "cou") THEN
		lcSql = "alter table art_tempo add cou char(32);"
		ejecutar_comando(lcSql)
		lcSql = "alter table art_tempo add index idx_art_tempo_cou (cou asc);"
		ejecutar_comando(lcSql)
	ENDIF
	
	cou_inicializar()
ENDPROC

PROCEDURE cou_inicializar
	**
	* Genero los COU en los artículos que no tiene asignado para inicializar
	* los hasheados.
	**
	LOCAL lcSql
	WAIT WINDOW "Inicializando COU en artículos..." NOWAIT
	TEXT TO lcSql NOSHOW
		UPDATE
			articulos
		SET
			articulos.cou = art_generar_cdp(articulos.idProv, articulos.codArtPV, articulos.descripcio)
		WHERE
			articulos.cou IS NULL;
	ENDTEXT
	ejecutar_comando(lcSql)
ENDPROC

PROCEDURE crearTablaArtTempo
	******************************************************************
	* Creo la tabla art_tempo si no existe para que se actualice bien
	* en cuenta 2.
	******************************************************************
	LOCAL lcSql
	
	TEXT TO lcSql NOSHOW
		CREATE TABLE IF NOT EXISTS `art_tempo` (  
			`idArtTempo` int(11) NOT NULL AUTO_INCREMENT,  
			`idprov` int(11) NOT NULL,  
			`idFamilia` int(11) NOT NULL,  
			`idSubFam` int(11) NOT NULL,  
			`idMarca` int(11) NOT NULL,  
			`codArt` varchar(20) NOT NULL,  
			`codArtPV` varchar(40) DEFAULT NULL,  
			`descripcio` varchar(200) DEFAULT NULL,  
			`alicIVA` double NOT NULL,  
			`prListaPV` double NOT NULL,  
			`bonif1` double NOT NULL,  
			`bonif2` double NOT NULL,  
			`bonif3` double NOT NULL,  
			`bonif4` double NOT NULL,  
			`costoRep` double NOT NULL,  
			`margenMay` double NOT NULL,  
			`margenMin` double NOT NULL,  
			`prVentaMay` double NOT NULL,  
			`prVentaMin` double NOT NULL,  
			`procesado` bit(1) NOT NULL DEFAULT b'0',  
			`cou` char(32) DEFAULT NULL,  
			UNIQUE KEY `idArtTempo` (`idArtTempo`),  
			KEY `idx_art_tempo_cou` (`cou`)) ENGINE=InnoDB;
	ENDTEXT
	ejecutar_comando(lcSql)
ENDPROC

PROCEDURE crearTablaArtUpdTempo
	LOCAL lcSql
	TEXT TO lcSql NOSHOW
		CREATE TABLE IF NOT EXISTS `art_upd_tempo` (  
			`idArticulo` int(11) DEFAULT NULL,
			`idProv` int(11) NOT NULL,
			`stock` varchar(10) DEFAULT NULL, 
			`codigo` varchar(40) DEFAULT NULL, 
			`codArt` varchar(20) DEFAULT NULL, 
			`articulo` varchar(200) DEFAULT NULL,  
			`linea` varchar(60) DEFAULT NULL,  
			`rubro` varchar(60) DEFAULT NULL,  
			`venta` double DEFAULT NULL,  
			`lista` double DEFAULT NULL,  
			`bonif1` double DEFAULT NULL,  
			`bonif2` double DEFAULT NULL,  
			`bonif3` double DEFAULT NULL,  
			`bonif4` double DEFAULT NULL,  
			`margenMax` double DEFAULT NULL,  
			`margenMin` double DEFAULT NULL,  
			`costo` double DEFAULT NULL,  
			`esNuevo` bit(1) DEFAULT NULL,  
			`cou` char(32) DEFAULT NULL,  
			KEY `idx_artupdtempo_idArticulo` (`idArticulo`),  
			KEY `idx_artupdtempo_idProv` (`idProv`),  
			KEY `idx_artupdtempo_codigo` (`codigo`),  
			KEY `idx_artupdtempo_codArt` (`codArt`),  
			KEY `idx_art_upd_tempo_cou` (`cou`)) 
		ENGINE=MyISAM DEFAULT CHARSET=latin1;
	ENDTEXT
	ejecutar_comando(lcSql)
ENDPROC