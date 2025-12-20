-- Agrego menú de ABM para artículos exceptuados de IVA en presupuestos
CALL agregar_menu ('7.4', 'Artículos Exceptuados IVA PTO', 'DO FORM frm_abm_art_exivapto', 1, 7, '', 7004);
CALL globalcfg_insert('RCIMPSEL', 'L', 'true', 1);

-- Configuración de menues
UPDATE
	menues
SET
	Procedim = 'DO FORM form_pedido_online_std'
WHERE
	idMenue = 93;