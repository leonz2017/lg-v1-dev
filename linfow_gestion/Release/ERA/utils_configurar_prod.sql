-- Menu automatización de cuentas corrientes.
CALL agregar_menu('5.13', '\\-', '', 1, 5, '', 5013);
CALL agregar_menu('5.14', 'Enviar Resumenes', 'DO FORM frm_envio_resumen_ctactecli', 1, 5, '', 5014);
