&& Este programa permite compilar el proyecto
LOCAL lnElementos, lcNroVersion
CLEAR ALL
SET SAFETY OFF
WAIT WINDOW "Compilando ..." NOWAIT
BUILD EXE "Release\linfow_gestion_c1\linfow_gestionc1.exe" FROM lg-rolon RECOMPILE
WAIT WINDOW "Generando ejecutable C2 ..." NOWAIT
COPY FILE "Release\linfow_gestion_c1\linfow_gestionc1.exe" TO "Release\linfow_gestion_c2\linfow_gestionc2.exe"
lnElementos = AGETFILEVERSION(laVersion, "Release\linfow_gestion_c1\linfow_gestionc1.exe")
IF lnElementos > 0 THEN
	lcNroVersion = laVersion[4]
	=STRTOFILE(lcNroVersion, "Release\linfow_gestion_c1\version.txt", 0)
ENDIF

COPY FILE "Release\linfow_gestion_c1\linfow_gestionc1.exe" TO "D:\sistemas\lg-v1-dev\deploys\rolon\linfow_gestionc1.exe"
COPY FILE "Release\linfow_gestion_c2\linfow_gestionc2.exe" TO "D:\sistemas\lg-v1-dev\deploys\rolon\linfow_gestionc2.exe"
COPY FILE "Release\linfow_gestion_c1\version.txt" TO "D:\sistemas\lg-v1-dev\deploys\rolon\version.txt"
WAIT WINDOW "Sistema compilado..." NOWAIT