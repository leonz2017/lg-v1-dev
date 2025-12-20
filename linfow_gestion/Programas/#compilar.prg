&& Este programa permite compilar el proyecto
LOCAL lnElementos, lcNroVersion
CLEAR ALL
SET SAFETY OFF

* Compilo el sistema
WAIT WINDOW "Compilando LINFOW GESTION ..." NOWAIT
BUILD EXE "Release\DESA\LINFOW_GESTION\linfow_gestion.exe" FROM linfow_gestion RECOMPILE
WAIT WINDOW "Generando ejecutable C2 ..." NOWAIT
COPY FILE "Release\DESA\LINFOW_GESTION\linfow_gestion.exe" TO "Release\DESA\LINFOW_GESTION_DEMO\linfow_gestion_demo.exe"
lnElementos = AGETFILEVERSION(laVersion, "Release\DESA\LINFOW_GESTION\linfow_gestion.exe")
IF lnElementos > 0 THEN
	lcNroVersion = laVersion[4]
	=STRTOFILE(lcNroVersion, "Release\DESA\LINFOW_GESTION\version.txt", 0)
ENDIF

WAIT WINDOW "Copiando a deploy..." NOWAIT
COPY FILE "Release\DESA\LINFOW_GESTION\linfow_gestion.exe" TO "D:\sistemas\lg-v1-dev\deploys\linfow_gestion\linfow_gestion.exe"
COPY FILE "Release\DESA\LINFOW_GESTION\version.txt" TO "D:\sistemas\lg-v1-dev\deploys\linfow_gestion\version.txt"
COPY FILE "Release\DESA\LINFOW_GESTION\linfow_gestion.exe" TO "D:\sistemas\lg-v1-dev\deploys\linfow_gestion\linfow_gestion_demo.exe"

* Copio el ejecutable de la versión en los release de clientes.
* Esto lo hago porque cada cliente se conecta a una base diferente y así evitarme
* a la hora de testear de tener que cambiar el archivo siscom.conf

* Actualización para EJB Repuestos
WAIT WINDOW "Actualizando EJB..." NOWAIT
COPY FILE "Release\DESA\LINFOW_GESTION\linfow_gestion.exe" TO "Release\EJB\LINFOW_GESTION\linfow_gestion.exe"
COPY FILE "Release\DESA\LINFOW_GESTION\version.txt" TO "Release\EJB\LINFOW_GESTION\version.txt"
COPY FILE "Release\DESA\LINFOW_GESTION\linfow_gestion.exe" TO "Release\EJB\LINFOW_GESTION_DEMO\linfow_gestion_demo.exe"

COPY FILE "Release\DESA\LINFOW_GESTION\linfow_gestion.exe" TO "D:\sistemas\lg-v1-dev\deploys\ejb\linfow_gestion.exe"
COPY FILE "Release\DESA\LINFOW_GESTION\version.txt" TO "D:\sistemas\lg-v1-dev\deploys\ejb\version.txt"
COPY FILE "Release\DESA\LINFOW_GESTION\linfow_gestion.exe" TO "D:\sistemas\lg-v1-dev\deploys\ejb\linfow_gestion_demo.exe"

* Actualización para MG Carburación Central.
WAIT WINDOW "Actualizando MG..." NOWAIT

* MG: Actualización para MG Guillermo Fernandez.
COPY FILE "Release\DESA\LINFOW_GESTION\linfow_gestion.exe" TO "Release\MGF\linfow_gestion\linfow_gestion.exe"
COPY FILE "Release\DESA\LINFOW_GESTION\version.txt" TO "Release\MGF\linfow_gestion\version.txt"
COPY FILE "Release\DESA\LINFOW_GESTION\linfow_gestion.exe" TO "Release\MGF\linfow_gestion_demo\linfow_gestion_demo.exe"

* MG: Copio a deploy
COPY FILE "Release\DESA\LINFOW_GESTION\linfow_gestion.exe" TO "D:\sistemas\lg-v1-dev\deploys\mg_gf\linfow_gestion.exe"
COPY FILE "Release\DESA\LINFOW_GESTION\version.txt" TO "D:\sistemas\lg-v1-dev\deploys\mg_gf\version.txt"
COPY FILE "Release\DESA\LINFOW_GESTION\linfow_gestion.exe" TO "D:\sistemas\lg-v1-dev\deploys\mg_gf\linfow_gestion_demo.exe"

* ERA: Actualización del ejectauble
WAIT WINDOW "Actualizando ERA..." NOWAIT
COPY FILE "Release\DESA\LINFOW_GESTION\linfow_gestion.exe" TO "Release\ERA\siscom_electc1\siscom_electc1.exe"
COPY FILE "Release\DESA\LINFOW_GESTION\version.txt" TO "Release\ERA\siscom_electc1\version.txt"
COPY FILE "Release\DESA\LINFOW_GESTION\linfow_gestion.exe" TO "Release\ERA\siscom_electc2\siscom_electc2.exe"

* ERA: copio a deploy
COPY FILE "Release\DESA\LINFOW_GESTION\linfow_gestion.exe" TO "D:\sistemas\lg-v1-dev\deploys\era\siscom_electc1.exe"
COPY FILE "Release\DESA\LINFOW_GESTION\version.txt" TO "D:\sistemas\lg-v1-dev\deploys\era\version.txt"
COPY FILE "Release\DESA\LINFOW_GESTION\linfow_gestion.exe" TO "D:\sistemas\lg-v1-dev\deploys\era\siscom_electc2.exe"

* Actualización para Casa Renato
WAIT WINDOW "Actualizando CR..." NOWAIT
COPY FILE "Release\DESA\LINFOW_GESTION\linfow_gestion.exe" TO "Release\CR\siscom_crc1\siscom_crc1.exe"
COPY FILE "Release\DESA\LINFOW_GESTION\version.txt" TO "Release\CR\siscom_crc1\version.txt"
COPY FILE "Release\DESA\LINFOW_GESTION\linfow_gestion.exe" TO "Release\CR\siscom_crc2\siscom_crc2.exe"

COPY FILE "Release\DESA\LINFOW_GESTION\linfow_gestion.exe" TO "D:\sistemas\lg-v1-dev\deploys\cr\siscom_crc1.exe"
COPY FILE "Release\DESA\LINFOW_GESTION\version.txt" TO "D:\sistemas\lg-v1-dev\deploys\cr\version.txt"
COPY FILE "Release\DESA\LINFOW_GESTION\linfow_gestion.exe" TO "D:\sistemas\lg-v1-dev\deploys\cr\siscom_crc2.exe"

* Actualización para Neumáticos Palá
*!*	WAIT WINDOW "Actualizando Neumáticos PALA..." NOWAIT
*!*	COPY FILE "Release\DESA\LINFOW_GESTION\linfow_gestion.exe" TO "Release\PALA\LINFOW_GESTION\linfow_gestion.exe"
*!*	COPY FILE "Release\DESA\LINFOW_GESTION\version.txt" TO "Release\PALA\LINFOW_GESTION\version.txt"
*!*	COPY FILE "Release\DESA\LINFOW_GESTION\linfow_gestion.exe" TO "Release\PALA\LINFOW_GESTION_DEMO\linfow_gestion_demo.exe"

*!*	COPY FILE "Release\DESA\LINFOW_GESTION\linfow_gestion.exe" TO "D:\sistemas\lg-v1-dev\deploys\pala\linfow_gestion.exe"
*!*	COPY FILE "Release\DESA\LINFOW_GESTION\version.txt" TO "D:\sistemas\lg-v1-dev\deploys\pala\version.txt"
*!*	COPY FILE "Release\DESA\LINFOW_GESTION\linfow_gestion.exe" TO "D:\sistemas\lg-v1-dev\deploys\pala\linfow_gestion_demo.exe"

* Actualización FH Neumáticos
WAIT WINDOW "Actualizando FH Reconstructora de neumáticos" NOWAIT
COPY FILE "Release\DESA\LINFOW_GESTION\linfow_gestion.exe" TO "Release\FH\LINFOW_GESTION\linfow_gestion.exe"
COPY FILE "Release\DESA\LINFOW_GESTION\version.txt" TO "Release\FH\LINFOW_GESTION\version.txt"
COPY FILE "Release\DESA\LINFOW_GESTION\linfow_gestion.exe" TO "Release\FH\LINFOW_GESTION_DEMO\linfow_gestion_demo.exe"

COPY FILE "Release\DESA\LINFOW_GESTION\linfow_gestion.exe" TO "D:\sistemas\lg-v1-dev\deploys\fh_neumaticos\linfow_gestion.exe"
COPY FILE "Release\DESA\LINFOW_GESTION\version.txt" TO "D:\sistemas\lg-v1-dev\deploys\fh_neumaticos\version.txt"
COPY FILE "Release\DESA\LINFOW_GESTION\linfow_gestion.exe" TO "D:\sistemas\lg-v1-dev\deploys\fh_neumaticos\linfow_gestion_demo.exe"

* Actualización MONTIEL
*!*	WAIT WINDOW "Actualizando MONTIEL" NOWAIT
*!*	COPY FILE "Release\DESA\LINFOW_GESTION\linfow_gestion.exe" TO "Release\MONTIEL\LINFOW_GESTION\linfow_gestion.exe"
*!*	COPY FILE "Release\DESA\LINFOW_GESTION\version.txt" TO "Release\MONTIEL\LINFOW_GESTION\version.txt"
*!*	COPY FILE "Release\DESA\LINFOW_GESTION\linfow_gestion.exe" TO "Release\MONTIEL\LINFOW_GESTION_DEMO\linfow_gestion_demo.exe"

*!*	COPY FILE "Release\DESA\LINFOW_GESTION\linfow_gestion.exe" TO "D:\sistemas\lg-v1-dev\deploys\montiel\linfow_gestion.exe"
*!*	COPY FILE "Release\DESA\LINFOW_GESTION\version.txt" TO "D:\sistemas\lg-v1-dev\deploys\montiel\version.txt"
*!*	COPY FILE "Release\DESA\LINFOW_GESTION\linfow_gestion.exe" TO "D:\sistemas\lg-v1-dev\deploys\montiel\linfow_gestion_demo.exe"


WAIT WINDOW "Sistema compilado..." NOWAIT