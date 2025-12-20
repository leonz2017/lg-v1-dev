&& Este programa permite compilar el proyecto
WAIT WINDOW "Compilando SISCOM General..." NOWAIT
BUILD EXE siscom.exe FROM siscom2013 RECOMPILE
WAIT WINDOW "Compilando SISCOM MG..." NOWAIT
BUILD EXE "C:\DESA\SISCOM\Release\SISCOM_MYSQL\siscom_mysql.exe" FROM siscom2013 RECOMPILE
WAIT WINDOW "Compilando SISCOM DER..." NOWAIT
BUILD EXE "C:\DESA\SISCOM\Release\SISCOM_SQLSRV\siscom_sqlsrv.exe" FROM siscom2013 RECOMPILE
WAIT WINDOW "Compilación Finalizada..." NOWAIT
