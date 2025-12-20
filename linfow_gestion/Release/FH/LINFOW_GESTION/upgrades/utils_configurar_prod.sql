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

-- Configuración de menues módulo de reconstrucciones.
CALL agregar_menu('14', 'Reconstrucciones', '', 0, 14, '', 14000);
CALL agregar_menu('14.4', 'Estados de craters', 'DO FORM frm_rcn_abm_estcra', 1, 14, '', 14004);
CALL agregar_menu('14.5', 'Operadores', 'DO FORM frm_rcn_abm_operadores', 1, 14, '', 14005);
CALL agregar_menu('14.6', 'Motivos de rechazo', 'DO FORM frm_abm_motrec', 1, 14, '', 14006);
CALL agregar_menu('14.7', '\\-', '', 1, 14, '', 14007);
CALL agregar_menu('14.8', 'Ingreso de remitos', 'DO FORM frm_rcn_ingreso_remitos', 1, 14, '', 14008);
CALL agregar_menu('14.9', 'Gestionar fichas', 'DO FORM frm_rcn_fichas', 1, 14, '', 14009);

-- Parametros de configuración
CALL globalcfg_insert('RCIMPSEL', 'L', 'false', 1);
CALL globalcfg_insert('NRC_AUTO', 'L', 'true', 1);
CALL globalcfg_insert('PTOINCIVA', 'L', 'true', 1);