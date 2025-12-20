-- Menu de consulta de ordenes de pagos
CALL agregar_menu('10.7', '\\-', '', 1, 10, '', 10007);
CALL agregar_menu('10.8', 'Consulta de ordenes de pagos', 'DO FORM frm_orden_pago_consulta', 1, 10, '', 10007);

