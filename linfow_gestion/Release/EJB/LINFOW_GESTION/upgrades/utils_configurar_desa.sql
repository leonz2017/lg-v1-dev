CALL globalcfg_insert('UPDSQLLOC', 'L', 'true', 1);
CALL globalcfg_insert('UPD_URL', 'C', 'D:\\sistemas\\lg-v1-dev\\deploys\\ejb\\', 1);
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

-- Configuración del comportamiento para presupuestos
CALL globalcfg_insert('PTOINCIVA', 'L', 'true', 1); -- Indica si toma el IVA o No.
CALL globalcfg_insert('RCIMPSEL', 'L', 'true', 1);

-- Agrego parametros para habilitar y deshabilitar descuentos
CALL globalcfg_insert('FCDESC1', 'L', 'true', 1);
CALL globalcfg_insert('FCDESC2', 'L', 'true', 1);
CALL globalcfg_insert('FCDESC3', 'L', 'true', 1);
CALL globalcfg_insert('FCDESC4', 'L', 'true', 1);

-- Configuro los reportes de los numeradores
UPDATE numerador SET repname = 'ejb_repcbtesvta' WHERE cbte = 'FC' AND tipoDoc = 'A';
UPDATE numerador SET repname = 'ejb_repcbtesvta_b' WHERE cbte = 'FC' AND tipoDoc = 'B';
UPDATE numerador SET repname = 'ejb_reppedido' WHERE cbte = 'PED';

UPDATE numerador SET repname = 'ejb_repcbtesvta', repnamecp = 'ejb_repncnd' WHERE cbte = 'NC' AND tipoDoc = 'A';
UPDATE numerador SET repname = 'ejb_repcbtesvta_b', repnamecp = 'ejb_repncnd_b' WHERE cbte = 'NC' AND tipoDoc = 'B';
UPDATE numerador SET repname = 'ejb_reppto', repnamecp = 'repncnd_x' WHERE cbte = 'NC' AND ptoVta = 9999;

UPDATE numerador SET repname = NULL, repnamecp = 'ejb_repncnd' WHERE cbte = 'ND' AND tipoDoc = 'A';
UPDATE numerador SET repname = NULL, repnamecp = 'ejb_repncnd_b' WHERE cbte = 'ND' AND tipoDoc = 'B';
UPDATE numerador SET repname = NULL, repnamecp = 'repncnd_x' WHERE cbte = 'ND' AND ptoVta = 9999;

UPDATE numerador SET repname = 'rep_recibos', repnamecp = NULL WHERE cbte = 'RC';
UPDATE numerador SET repname = 'ejb_reppto', repnamecp = NULL WHERE cbte = 'PTO';
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
UPDATE
	menues
SET
	Procedim = 'DO FORM frm_pedidos_online_v2'
WHERE
	idMenue = 93;
	
UPDATE menues SET Procedim = 'DO FORM frm_pto_c2_v2' WHERE idMenue = 88;
	
-- Agrego menú de ABM para artículos exceptuados de IVA en presupuestos
CALL agregar_menu ('7.4', 'Articulos Exceptuados IVA PTO', 'DO FORM frm_abm_art_exivapto', 1, 7, '', 7004);

-- Menu de consulta de ordenes de pagos
CALL agregar_menu('10.7', '\\-', '', 1, 10, '', 10007);
CALL agregar_menu('10.8', 'Consulta de ordenes de pagos', 'DO FORM frm_orden_pago_consulta', 1, 10, '', 10007);
