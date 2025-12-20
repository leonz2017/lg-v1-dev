*********************************************************
* Programa para actualizar el módulo de promociones
*********************************************************

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
