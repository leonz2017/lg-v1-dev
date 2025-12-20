CALL globalcfg_insert('UPD_URL', 'C', 'D:\\sistemas\\lg-v1-dev\\deploys\\rolon\\', 1);
CALL globalcfg_insert('FELOCAL', 'L', 'true', 1);
CALL globalcfg_insert('FETKDIRFTP', 'C', '/var/www/html/wsafip/ticket/desa', 1);

-- Nombre del archivo ejecutable
CALL globalcfg_insert('UPD_EXEC1', 'C', 'linfow_gestionc1.exe', 1);
CALL globalcfg_insert('UPD_EXEC2', 'C', 'linfow_gestionc2.exe', 1);

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

-- Configuración del comportamiento para presupuestos
-- CALL globalcfg_insert('PTOINCIVA', 'L', 'true', 1); -- Indica si toma el IVA o No.

-- Configuro a todos los clientes con mi mail para testear
UPDATE
	clientes
SET
	clientes.envCbte = 0,
	clientes.mailFC = "info@linfow.com.ar",
	clientes.printCbte = 1;
	
-- Agrego menú de ABM para artículos exceptuados de IVA en presupuestos
-- CALL agregar_menu ('7.4', 'Artículos Exceptuados IVA PTO', 'DO FORM frm_abm_art_exivapto', 1, 7, '', 7004);

-- Nuevos parámetros (Opciones de recibos)
CALL globalcfg_insert('RCIMPSEL', 'L', 'false', 1);

-- Menu de consulta de ordenes de pagos
CALL agregar_menu('10.7', '\\-', '', 1, 10, '', 10007);
CALL agregar_menu('10.8', 'Consulta de ordenes de pagos', 'DO FORM frm_orden_pago_consulta', 1, 10, '', 10007);

-- Menu automatización de cuentas corrientes.
CALL agregar_menu('5.14', '\\-', '', 1, 5, '', 5014);
CALL agregar_menu('5.15', 'Enviar Resumenes', 'DO FORM frm_envio_resumen_ctactecli', 1, 5, '', 5015);