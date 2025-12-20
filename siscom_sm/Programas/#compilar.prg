&& Este programa permite compilar el proyecto
LOCAL lnElementos, lcNroVersion
CLEAR ALL
SET SAFETY OFF
WAIT WINDOW "Compilando ..." NOWAIT
BUILD EXE "Release\SM\SISCOM_SMC1\siscom_smc1.exe" FROM siscom_sm RECOMPILE
WAIT WINDOW "Generando ejecutable C2 ..." NOWAIT
COPY FILE "Release\SM\SISCOM_SMC1\siscom_smc1.exe" TO "Release\SM\SISCOM_SMC2\siscom_smc2.exe"
lnElementos = AGETFILEVERSION(laVersion, "Release\SM\SISCOM_SMC1\siscom_smc1.exe")
IF lnElementos > 0 THEN
	lcNroVersion = laVersion[4]
	=STRTOFILE(lcNroVersion, "Release\SM\SISCOM_SMC1\version.txt", 0)
ENDIF

COPY FILE "Release\SM\SISCOM_SMC1\siscom_smc1.exe" TO "Release\ST\linfow_gestion\linfow_gestion.exe"
COPY FILE "Release\SM\SISCOM_SMC1\siscom_smc1.exe" TO "Release\ST\linfow_gestion_demo\linfow_gestion_demo.exe"
COPY FILE "Release\SM\SISCOM_SMC1\version.txt" TO "Release\ST\linfow_gestion\version.txt"
COPY FILE "Release\SM\SISCOM_SMC1\version.txt" TO "Release\ST\linfow_gestion_demo\version.txt"
** Copiando a deploy
COPY FILE "Release\SM\SISCOM_SMC1\siscom_smc1.exe" TO "D:\sistemas\lg-v1-dev\deploys\sm\siscom_smc1.exe"
COPY FILE "Release\SM\SISCOM_SMC1\siscom_smc1.exe" TO "D:\sistemas\lg-v1-dev\deploys\sm\siscom_smc2.exe"
COPY FILE "Release\SM\SISCOM_SMC1\version.txt" TO "D:\sistemas\lg-v1-dev\deploys\sm\version.txt"

COPY FILE "Release\ST\linfow_gestion\linfow_gestion.exe" TO "D:\sistemas\lg-v1-dev\deploys\st\linfow_gestion.exe"
COPY FILE "Release\ST\linfow_gestion_demo\linfow_gestion_demo.exe" TO "D:\sistemas\lg-v1-dev\deploys\st\linfow_gestion_demo.exe"
COPY FILE "Release\ST\linfow_gestion\version.txt" TO "D:\sistemas\lg-v1-dev\deploys\st\version.txt"
WAIT WINDOW "Sistema compilado..." NOWAIT