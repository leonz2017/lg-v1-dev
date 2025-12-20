-- Agrego menú para la pantalla de facturación de mostrador.
CALL `agregar_menu`('4.15', '\\-', '', 1, 4, '', 4015);
CALL `agregar_menu`('4.16', 'Emitir Remitos', 'DO FORM frm_emision_remitos', 1, 4, '', 4016);
CALL `agregar_menu`('4.17', 'Consulta y reimpresion de remitos', 'DO FORM frm_rtos_consulta', 1, 4, '', 4017);