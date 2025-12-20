&& Este programa permite compilar el proyecto
CLEAR ALL
WAIT WINDOW "Compilando SISCOM MG..." NOWAIT
BUILD EXE "Release\SISCOM_MG\siscom_mg.exe" FROM siscom_mg RECOMPILE
WAIT WINDOW "Compilando SISCOM MG DMO..." NOWAIT
BUILD EXE "Release\SISCOM_MG_DMO\siscom_mg_dmo.exe" FROM siscom_mg RECOMPILE
WAIT WINDOW "Proceso finalizado..." NOWAIT