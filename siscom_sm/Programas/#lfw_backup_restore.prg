**************************************************************************
* Este script permite restaurar bases de datos a partir de los backups
* descargados.
*
* Autor: LINFOW - Leonardo D. Zulli
* Fecha: 19/10/2021
**************************************************************************

SET EXACT OFF
SET SAFETY OFF

WAIT WINDOW "Restaurando backup..." NOWAIT
TEXT TO lcCmd NOSHOW
	RUN "d:\proyectos\linfow_gestion_src\Gestion\siscom_sm\bd_backups\restaurar_backups.bat"
ENDTEXT
&lcCmd

MESSAGEBOX("Backup restaurado", 0+64, "Restauración de copia")