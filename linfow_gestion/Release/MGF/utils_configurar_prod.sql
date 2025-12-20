CALL globalcfg_insert('APIPEDWEB', 'C', 'https://mgrepuestos.ar/mg_server_updater_v2/pedidos-download.php', 1);
CALL globalcfg_insert('APIPEDSCL', 'C', 'https://mgrepuestos.ar/ws_siscom/download_pedidos_siscli.php', 1);
CALL globalcfg_insert('APIPEDREW', 'C', 'https://mgrepuestos.ar/mg_server_updater_v2/pedidos-recepcionar.php', 1);
CALL globalcfg_insert('APIPEDRES', 'C', 'https://mgrepuestos.ar/ws_siscom/marcar_procesado_siscli.php', 1);

UPDATE menues SET Procedim = 'DO FORM frm_pedidos_online_v2' WHERE idMenue = 93;