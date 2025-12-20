&& Este programa permite compilar el proyecto
LOCAL lnElementos, lcNroVersion
CLEAR ALL
SET SAFETY OFF
WAIT WINDOW "Compilando ..." NOWAIT
BUILD EXE "Release\linfow_gestion_c1\lfwgest.exe" FROM lg-supermarcha RECOMPILE
WAIT WINDOW "Generando ejecutable C2 ..." NOWAIT
COPY FILE "Release\linfow_gestion_c1\lfwgest.exe" TO "Release\linfow_gestion_c2\lfwgest_dmo.exe"

IF !FILE("Release\linfow_gestion_c1\lfwgest.exe") THEN
	MESSAGEBOX("No existe el ejecutable", 0+32, "Error de compilación")
ELSE
	lnElementos = AGETFILEVERSION(laVersion, sys(5) + sys(2003) + "\Release\linfow_gestion_c1\lfwgest.exe")
	IF lnElementos > 0 THEN
		lcNroVersion = laVersion[4]
		=STRTOFILE(lcNroVersion, "Release\linfow_gestion_c1\version.txt", 0)
	ELSE
		MESSAGEBOX("No se generó la matriz de versión", 0+32, "Error de compilación")
		RETURN
	ENDIF
ENDIF

** Copio a Deploy
WAIT WINDOW "Copiando a deploy..." NOWAIT
COPY FILE "Release\linfow_gestion_c1\lfwgest.exe" TO "D:\sistemas\lg-v1-dev\deploys\tito\lfwgest.exe"
COPY FILE "Release\linfow_gestion_c1\lfwgest.exe" TO "D:\sistemas\lg-v1-dev\deploys\tito\lfwgest_dmo.exe"
COPY FILE "Release\linfow_gestion_c1\version.txt" TO "D:\sistemas\lg-v1-dev\deploys\tito\version.txt"

WAIT WINDOW "Sistema compilado..." NOWAIT