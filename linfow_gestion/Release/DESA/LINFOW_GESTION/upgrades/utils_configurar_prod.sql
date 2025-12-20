CALL globalcfg_insert("UPDSQLLOC", "L", "true", 0);
CALL globalcfg_insert("UPD_URL", "C", "q:\\LINFOW\\upgrades\\linfow_gestion\\", 0);
CALL globalcfg_insert("FELOCAL", "L", "true", 0);
CALL globalcfg_insert("FETKDIRFTP", "C", "/var/www/html/wsafip/ticket/desa", 0);
CALL globalcfg_insert("UPD_EXEC1", "C", "linfow_gestion.exe", 0);
CALL globalcfg_insert("UPD_EXEC2", "C", "linfow_gestion_demo.exe", 0);
CALL globalcfg_insert("TEMPDIR", "C", "D:\\TEMP\\", 1);
CALL globalcfg_insert("FTPHOST", "C", "", 0);
CALL globalcfg_insert("FTPUSER", "C", "", 0);
CALL globalcfg_insert("FTPPASS", "C", "", 0);
CALL globalcfg_insert("FTPPORT", "C", "", 0);
CALL globalcfg_insert("FTPINIDIR", "C", "", 0);
CALL globalcfg_insert("USA_SFTP", "L", "true", 0);
CALL globalcfg_insert("URLUPDATER", "C", "", 0);
CALL globalcfg_insert("MODODESA", "L", "false", 0);

-- Configuro los reportes de los numeradores
UPDATE numerador SET repname = 'repcbtesvta' WHERE cbte = 'FC' AND tipoDoc = 'A';
UPDATE numerador SET repname = 'repcbtesvta_b' WHERE cbte = 'FC' AND tipoDoc = 'B';
UPDATE numerador SET repname = 'reppedido' WHERE cbte = 'PED';

UPDATE numerador SET repname = 'repcbtesvta', repnamecp = 'repncnd' WHERE cbte = 'NC' AND tipoDoc = 'A';
UPDATE numerador SET repname = 'repcbtesvta_b', repnamecp = 'repncnd_b' WHERE cbte = 'NC' AND tipoDoc = 'B';
UPDATE numerador SET repname = 'reppto', repnamecp = 'repncnd_x' WHERE cbte = 'NC' AND ptoVta = 9999;

UPDATE numerador SET repname = NULL, repnamecp = 'repncnd' WHERE cbte = 'ND' AND tipoDoc = 'A';
UPDATE numerador SET repname = NULL, repnamecp = 'repncnd_b' WHERE cbte = 'ND' AND tipoDoc = 'B';
UPDATE numerador SET repname = NULL, repnamecp = 'repncnd_x' WHERE cbte = 'ND' AND ptoVta = 9999;

UPDATE numerador SET repname = 'rep_recibos', repnamecp = NULL WHERE cbte = 'RC';
UPDATE numerador SET repname = 'reppto', repnamecp = NULL WHERE cbte = 'PTO';
UPDATE numerador SET repname = 'repcot', repnamecp = NULL WHERE cbte = 'COT';
UPDATE numerador SET repname = 'rep_rtos', repnamecp = NULL WHERE cbte = 'RTO';