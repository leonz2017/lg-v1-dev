/*
 * Configurar solo en cuenta 1
*/

-- Saco la pregunta de imprimir remitos
CALL globalcfg_insert('PRINT_RTO', 'L', 'false', 1);

-- Agrego menú para la pantalla de facturación de mostrador.
CALL `agregar_menu`('4.22', '\\-', '', 1, 4, '', 4022);
CALL `agregar_menu`('4.23', 'Emitir Remitos', 'DO FORM frm_emision_remitos', 1, 4, '', 4023);
CALL `agregar_menu`('4.24', 'Consulta y reimpresion de remitos', 'DO FORM frm_rtos_consulta', 1, 4, '', 4024);