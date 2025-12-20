&& Este programa permite compilar el proyecto
LOCAL lnElementos, lcNroVersion
CLEAR ALL
SET SAFETY OFF
WAIT WINDOW "Compilando ..." NOWAIT
BUILD EXE "Release\SISCOM_GHIOC1\siscom_ghioc1.exe" FROM siscom_ghio RECOMPILE
COPY FILE "Release\SISCOM_GHIOC1\siscom_ghioc1.exe" TO "Release\SISCOM_GHIOC2\siscom_ghio_dmo.exe"

lnElementos = AGETFILEVERSION(laVersion, "Release\SISCOM_GHIOC1\siscom_ghioc1.exe")
IF lnElementos > 0 THEN
	lcNroVersion = laVersion[4]
	=STRTOFILE(lcNroVersion, "Release\SISCOM_GHIOC1\version.txt", 0)
ENDIF

** Envío a deploy
COPY FILE "Release\SISCOM_GHIOC1\siscom_ghioc1.exe" TO "D:\sistemas\lg-v1-dev\deploys\ghio\siscom_ghioc1.exe"
COPY FILE "Release\SISCOM_GHIOC1\version.txt" TO "D:\sistemas\lg-v1-dev\deploys\ghio\version.txt"
COPY FILE "Release\SISCOM_GHIOC2\siscom_ghio_dmo.exe" TO "D:\sistemas\lg-v1-dev\deploys\ghio\siscom_ghio_dmo.exe"

WAIT WINDOW "Sistema compilado..." NOWAIT