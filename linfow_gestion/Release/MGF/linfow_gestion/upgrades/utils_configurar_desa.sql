CALL globalcfg_insert('UPD_URL', 'C', 'D:\\sistemas\\lg-v1-dev\\deploys\\mg_gf\\', 1);
CALL globalcfg_insert('FELOCAL', 'L', 'true', 1);
CALL globalcfg_insert('FETKDIRFTP', 'C', '/var/www/html/wsafip/ticket/desa', 1);

-- Nombre del archivo ejecutable
CALL globalcfg_insert('UPD_EXEC1', 'C', 'linfow_gestion.exe', 1);
CALL globalcfg_insert('UPD_EXEC2', 'C', 'linfow_gestion_demo.exe', 1);

-- Configuro acceso FTP
CALL globalcfg_insert('FTPHOST', 'C', 'localhost', 1);
CALL globalcfg_insert('FTPUSER', 'C', 'root', 1);
CALL globalcfg_insert('FTPPASS', 'C', 'l4ld81', 1);
CALL globalcfg_insert('FTPPORT', 'C', '2222', 1);
CALL globalcfg_insert('FTPINIDIR', 'C', '/var/www/html/mg_server_updater_v2/data/Temp/', 1);
CALL globalcfg_insert('USA_SFTP', 'L', 'false', 1);

CALL globalcfg_insert('URLUPDATER', 'C', 'http://localhost:9000/mg_server_updater_v2', 1);
CALL globalcfg_insert('FEDEBUG', 'L', 'true', 1);
CALL globalcfg_insert('FECUIT', 'C', '20280456919', 1);
CALL globalcfg_insert('FE_FILE', 'C', '20280456919.pfx', 1);
CALL globalcfg_insert('FE_LIC', 'C', '', 1);
CALL globalcfg_insert('FE_PWD', 'C', '2048', 1);
CALL globalcfg_insert('FE_TICKACC', 'C', 'D:\\sistemas\\lg-v1-dev\\archivos-afip\\ticket\\ticket.txt', 1);
CALL globalcfg_insert('FETLS', 'N', '12', 1);
CALL globalcfg_insert('FE_IVAREC', 'L', 'true', 1);

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
CALL globalcfg_insert('APIPEDWEB', 'C', 'http://localhost:9000/mg_server_updater_v2/pedidos-download.php', 1);
CALL globalcfg_insert('APIPEDSCL', 'C', 'http://localhost:9000/ws_siscom/download_pedidos_siscli.php', 1);
CALL globalcfg_insert('APIPEDREW', 'C', 'http://localhost:9000/mg_server_updater_v2/pedidos-recepcionar.php', 1);
CALL globalcfg_insert('APIPEDRES', 'C', 'http://localhost:9000/ws_siscom/marcar_procesado_siscli.php', 1);

-- Configuración del comportamiento para presupuestos
CALL globalcfg_insert('PTOINCIVA', 'L', 'false', 0); -- Indica si toma el IVA o No.

-- Agrego parametros para habilitar y deshabilitar descuentos
CALL globalcfg_insert('FCDESC1', 'L', 'true', 1);
CALL globalcfg_insert('FCDESC2', 'L', 'true', 1);
CALL globalcfg_insert('FCDESC3', 'L', 'true', 1);
CALL globalcfg_insert('FCDESC4', 'L', 'true', 1);

-- Configuro los reportes de los numeradores
UPDATE numerador SET repname = 'mg_repcbtesvta' WHERE cbte = 'FC' AND tipoDoc = 'A';
UPDATE numerador SET repname = 'mg_repcbtesvta_b' WHERE cbte = 'FC' AND tipoDoc = 'B';
UPDATE numerador SET repname = 'reppedido' WHERE cbte = 'PED';

UPDATE numerador SET repname = 'mg_repcbtesvta', repnamecp = 'mg_repncnd' WHERE cbte = 'NC' AND tipoDoc = 'A';
UPDATE numerador SET repname = 'mg_repcbtesvta_b', repnamecp = 'mg_repncnd_b' WHERE cbte = 'NC' AND tipoDoc = 'B';
UPDATE numerador SET repname = 'reppto', repnamecp = 'repncnd_x' WHERE cbte = 'NC' AND ptoVta = 9999;

UPDATE numerador SET repname = NULL, repnamecp = 'mg_repncnd' WHERE cbte = 'ND' AND tipoDoc = 'A';
UPDATE numerador SET repname = NULL, repnamecp = 'mg_repncnd_b' WHERE cbte = 'ND' AND tipoDoc = 'B';
UPDATE numerador SET repname = NULL, repnamecp = 'repncnd_x' WHERE cbte = 'ND' AND ptoVta = 9999;

UPDATE numerador SET repname = 'rep_recibos', repnamecp = NULL WHERE cbte = 'RC';
UPDATE numerador SET repname = 'reppto', repnamecp = NULL WHERE cbte = 'PTO';
UPDATE numerador SET repname = 'repcot', repnamecp = NULL WHERE cbte = 'COT';
UPDATE numerador SET repname = 'rep_rtos', repnamecp = NULL WHERE cbte = 'RTO';

-- Configuro a todos los clientes con mi mail para testear
UPDATE
	clientes
SET
	clientes.envCbte = 0,
	clientes.mailFC = "info@linfow.com.ar",
	clientes.printCbte = 1;
	
-- Configuración de menues
CALL agregar_menu ('4.20', 'Reimprimir remitos', 'DO FORM frm_reimprimir_remitos', 1, 4, '', 4020);

-- Cambio de versión del formulario de presupuesto.

UPDATE menues SET Procedim = 'DO FORM frm_pto_c2_v2' WHERE idMenue = 88;
UPDATE menues SET Procedim = 'DO FORM frm_pedidos_online_v2' WHERE idMenue = 93;