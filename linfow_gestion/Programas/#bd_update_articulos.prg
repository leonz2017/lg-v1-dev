*******************************************************
* Actualización de base de datos módulo artículos
*******************************************************

** Permite agregar o actualizar menues.
PROCEDURE upd_menues
	agregarMenu("2.17", "\\-", "-", .T., 2, "", 2017)
	agregarMenu("2.18", "DO FORM frm_articulos_actualizar_codiart", .T., 2, "", 2018)
ENDPROC