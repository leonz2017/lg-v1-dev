CALL globalcfg_insert('UPD_URL', 'C', 'D:\\sistemas\\lg-v1-dev\\deploys\\fh_neumaticos\\', 1);
CALL globalcfg_insert('FELOCAL', 'L', 'true', 1);
CALL globalcfg_insert('FETKDIRFTP', 'C', '/var/www/html/wsafip/ticket/desa', 1);

-- Nombre del archivo ejecutable
CALL globalcfg_insert('UPD_EXEC1', 'C', 'linfow_gestion.exe', 1);
CALL globalcfg_insert('UPD_EXEC2', 'C', 'linfow_gestion_demo.exe', 1);

-- Configuro acceso FTP
CALL globalcfg_insert('FTPHOST', 'C', '', 1);
CALL globalcfg_insert('FTPUSER', 'C', '', 1);
CALL globalcfg_insert('FTPPASS', 'C', '', 1);
CALL globalcfg_insert('FTPPORT', 'C', '', 1);
CALL globalcfg_insert('FTPINIDIR', 'C', '', 1);
CALL globalcfg_insert('USA_SFTP', 'L', 'true', 1);

CALL globalcfg_insert('URLUPDATER', 'C', '', 1);
CALL globalcfg_insert('FEDEBUG', 'L', 'true', 1);
CALL globalcfg_insert('FECUIT', 'C', '20280456919', 1);
CALL globalcfg_insert('FE_FILE', 'C', '20280456919.pfx', 1);
CALL globalcfg_insert('FE_LIC', 'C', '', 1);
CALL globalcfg_insert('FE_PWD', 'C', '2048', 1);
CALL globalcfg_insert('FE_TICKACC', 'C', 'D:\\sistemas\\lg-v1-dev\\archivos-afip\\ticket\\ticket.txt', 1);
CALL globalcfg_insert('FETLS', 'N', '12', 1);
CALL globalcfg_insert('QRPATH', 'C', 'D:\\sistemas\\lg-v1-dev\\archivos-afip\\qr\\', 1);
CALL globalcfg_insert('FACPDFPATH', 'C', 'D:\\sistemas\\lg-v1-dev\\archivos-afip\\cbtes\\', 1);
CALL globalcfg_insert('UPDSQLPATH', 'C', 'D:\\sistemas\\lg-v1-dev\\bd-linfow-gestion\\sp', 1);
CALL globalcfg_insert('UPDSQLLOC', 'L', 'true', 1);
CALL globalcfg_insert('TEMPDIR', 'C', 'D:\\Temp\\lf-v1-db\\', 1);

-- Configuro las cuentas de mails para desarrollo
CALL globalcfg_insert('EMAILSMTP', 'C', 'c0050506.ferozo.com', 1);
CALL globalcfg_insert('EMAILPORT', 'N', '465', 1);
CALL globalcfg_insert('EMAILSSL', 'L', 'true', 1);
CALL globalcfg_insert('EMAILEMP', 'C', 'LINFOW DESA', 1);
CALL globalcfg_insert('EMAILADDR', 'C', 'no-reply@c0050506.ferozo.com', 1);
CALL globalcfg_insert('EMAILUSR', 'C', 'no-reply@c0050506.ferozo.com', 1);
CALL globalcfg_insert('EMAILPWD', 'C', 'EkWTtS4NGv', 1);
CALL globalcfg_insert('EMAILFIRMA', 'C', 'LINFOW Gestión DESA', 1);
CALL globalcfg_insert('EMAILCC', 'C', 'ldz.software@gmail.com', 1);

CALL globalcfg_insert('URLUPDATER', 'C', '', 1);


-- Configuración del comportamiento para presupuestos
-- CALL globalcfg_insert('PTOINCIVA', 'L', 'true', 1); -- Indica si toma el IVA o No.

-- Configuro los reportes de los numeradores
UPDATE numerador SET repname = 'fh_repcbtesvta' WHERE cbte = 'FC' AND tipoDoc = 'A';
UPDATE numerador SET repname = 'fh_repcbtesvta_b' WHERE cbte = 'FC' AND tipoDoc = 'B';
UPDATE numerador SET repname = 'reppedido' WHERE cbte = 'PED';

UPDATE numerador SET repname = 'fh_repcbtesvta', repnamecp = 'fh_repncnd' WHERE cbte = 'NC' AND tipoDoc = 'A';
UPDATE numerador SET repname = 'fh_repcbtesvta_b', repnamecp = 'fh_repncnd_b' WHERE cbte = 'NC' AND tipoDoc = 'B';
UPDATE numerador SET repname = 'reppto', repnamecp = 'repncnd_x' WHERE cbte = 'NC' AND ptoVta = 9999;

UPDATE numerador SET repname = NULL, repnamecp = 'fh_repncnd' WHERE cbte = 'ND' AND tipoDoc = 'A';
UPDATE numerador SET repname = NULL, repnamecp = 'fh_repncnd_b' WHERE cbte = 'ND' AND tipoDoc = 'B';
UPDATE numerador SET repname = NULL, repnamecp = 'repncnd_x' WHERE cbte = 'ND' AND ptoVta = 9999;

UPDATE numerador SET repname = 'rep_recibos', repnamecp = NULL WHERE cbte = 'RC';
UPDATE numerador SET repname = 'reppto', repnamecp = NULL WHERE cbte = 'PTO';
UPDATE numerador SET repname = 'fh_repcot', repnamecp = NULL WHERE cbte = 'COT';
UPDATE numerador SET repname = 'rep_rtos', repnamecp = NULL WHERE cbte = 'RTO';

-- Configuro a todos los clientes con mi mail para testear
UPDATE
	clientes
SET
	clientes.envCbte = 0,
	clientes.mailFC = "info@linfow.com.ar",
	clientes.printCbte = 1;
	
-- Configuro los menues
CALL `agregar_menu`('2.17', '\\-', '-', 1, 2, '', 2017);
CALL `agregar_menu`('2.18', 'Actualizar x C.B y precio final', 'DO FORM frm_articulos_actualizar_codiart', 1, 2, '', 2018);

-- Agrego menú para la pantalla de facturación de mostrador.
CALL `agregar_menu`('4.20', '\\-', '-', 1, 2, '', 4020);
CALL `agregar_menu`('4.21', 'Factura de mostrador', 'DO FORM frm_facturar_mostrador', 1, 4, '', 4021);

-- Agrego menú de ABM para artículos exceptuados de IVA en presupuestos
CALL agregar_menu ('7.4', 'Artículos Exceptuados IVA PTO', 'DO FORM frm_abm_art_exivapto', 1, 7, '', 7004);

-- Nuevos parámetros (Opciones de recibos)
CALL globalcfg_insert('RCIMPSEL', 'L', 'false', 1);

-- Configuración de menues módulo de reconstrucciones.
CALL agregar_menu('14', 'Reconstrucciones', '', 0, 14, '', 14000);
CALL agregar_menu('14.4', 'Estados de craters', 'DO FORM frm_rcn_abm_estcra', 1, 14, '', 14004);
CALL agregar_menu('14.5', 'Operadores', 'DO FORM frm_rcn_abm_operadores', 1, 14, '', 14005);
CALL agregar_menu('14.6', 'Motivos de rechazo', 'DO FORM frm_abm_motrec', 1, 14, '', 14006);
CALL agregar_menu('14.7', '\\-', '', 1, 14, '', 14007);
CALL agregar_menu('14.8', 'Ingreso de remitos', 'DO FORM frm_rcn_ingreso_remitos', 1, 14, '', 14008);
CALL agregar_menu('14.9', 'Gestionar fichas', 'DO FORM frm_rcn_fichas', 1, 14, '', 14009);