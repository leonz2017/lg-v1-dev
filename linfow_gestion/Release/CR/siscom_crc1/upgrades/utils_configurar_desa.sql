CALL globalcfg_insert('UPD_URL', 'C', 'D:\\sistemas\\lg-v1-dev\\deploys\\CR\\', 1);
CALL globalcfg_insert('FELOCAL', 'L', 'true', 1);
CALL globalcfg_insert('FETKDIRFTP', 'C', '/var/www/html/wsafip/ticket/desa', 1);

-- Nombre del archivo ejecutable
CALL globalcfg_insert("UPD_EXEC1", "C", "siscom_crc1.exe", 1);
CALL globalcfg_insert("UPD_EXEC2", "C", "siscom_crc2.exe", 1);

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
CALL globalcfg_insert('EMAILADDR', 'C', 'noresponder@linfow.com.ar', 1);
CALL globalcfg_insert('EMAILUSR', 'C', 'noresponder@linfow.com.ar', 1);
CALL globalcfg_insert('EMAILPWD', 'C', 'kxC*sGa0rI', 1);
CALL globalcfg_insert('EMAILFIRMA', 'C', 'LINFOW Gestión DESA', 1);
CALL globalcfg_insert('EMAILCC', 'C', 'ldz.software@gmail.com', 1);

-- Configuración del comportamiento para presupuestos
CALL globalcfg_insert('PTOINCIVA', 'L', 'true', 1); -- Indica si toma el IVA o No.

-- Agrego parametros para habilitar y deshabilitar descuentos
CALL globalcfg_insert('FCDESC1', 'L', 'true', 1);
CALL globalcfg_insert('FCDESC2', 'L', 'true', 1);
CALL globalcfg_insert('FCDESC3', 'L', 'true', 1);
CALL globalcfg_insert('FCDESC4', 'L', 'true', 1);

-- Configuro los reportes de los numeradores
UPDATE numerador SET repname = 'cr_repcbtesvta' WHERE cbte = 'FC' AND tipoDoc = 'A';
UPDATE numerador SET repname = 'cr_repcbtesvta_b' WHERE cbte = 'FC' AND tipoDoc = 'B';
UPDATE numerador SET repname = 'reppedido' WHERE cbte = 'PED';

UPDATE numerador SET repname = 'cr_repcbtesvta', repnamecp = 'cr_repncnd' WHERE cbte = 'NC' AND tipoDoc = 'A';
UPDATE numerador SET repname = 'cr_repcbtesvta_b', repnamecp = 'cr_repncnd_b' WHERE cbte = 'NC' AND tipoDoc = 'B';
UPDATE numerador SET repname = 'reppto', repnamecp = 'repncnd_x' WHERE cbte = 'NC' AND ptoVta = 9999;

UPDATE numerador SET repname = NULL, repnamecp = 'cr_repncnd' WHERE cbte = 'ND' AND tipoDoc = 'A';
UPDATE numerador SET repname = NULL, repnamecp = 'cr_repncnd_b' WHERE cbte = 'ND' AND tipoDoc = 'B';
UPDATE numerador SET repname = NULL, repnamecp = 'repncnd_x' WHERE cbte = 'ND' AND ptoVta = 9999;

UPDATE numerador SET repname = 'rep_recibos', repnamecp = NULL WHERE cbte = 'RC';
UPDATE numerador SET repname = 'reppto', repnamecp = NULL WHERE cbte = 'PTO';
UPDATE numerador SET repname = 'repcot', repnamecp = NULL WHERE cbte = 'COT';
UPDATE numerador SET repname = 'rep_rtos', repnamecp = NULL WHERE cbte = 'RTO';

UPDATE numerador SET repname = 'cr_repcot' WHERE cbte = 'COT';

-- Configuro a todos los clientes con mi mail para testear
UPDATE
	clientes
SET
	clientes.envCbte = 0,
	clientes.mailFC = "info@linfow.com.ar",
	clientes.printCbte = 1;
	
CALL `agregar_menu`('5.11', '\\-', '-', 1, 5, '', 5011);
CALL `agregar_menu`('5.12', 'Consulta y baja de recibos', 'DO FORM frm_recibos_cons', 1, 5, '', 5012);

-- Agrego menú para la pantalla de facturación de mostrador.
CALL `agregar_menu`('4.15', '\\-', '', 1, 4, '', 4015);
CALL `agregar_menu`('4.16', 'Emitir Remitos', 'DO FORM frm_emision_remitos', 1, 4, '', 4016);
CALL `agregar_menu`('4.17', 'Consulta y reimpresion de remitos', 'DO FORM frm_rtos_consulta', 1, 4, '', 4017);