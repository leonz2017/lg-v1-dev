************************************************************
OBJETO: Dataenvironment
************************************************************
*** PROPIEDADES ***
Top = 0
Left = 0
Width = 0
Height = 0
DataSource = .NULL.
Name = "Dataenvironment"

*** METODOS ***


************************************************************
OBJETO: frmbajadapedido
************************************************************
*** PROPIEDADES ***
Height = 239
Width = 658
DoCreate = .T.
BorderStyle = 2
Caption = "Bajada de Pedidos"
Name = "frmbajadapedido"

*** METODOS ***
PROCEDURE Load
DODEFAULT()
CREATE CURSOR cur_files (fileName varchar(60))
ENDPROC
PROCEDURE Init
LOCAL loResult, lcSql, lnMaxID, lnPorc
LOCAL loProgress, lcFileName

DODEFAULT()

loProgress = CREATEOBJECT("_thermometer")
loResult = CREATEOBJECT("odbc_result")
lcSql = ""
lnMaxID = 0
lnPorc = 0.00

SELECT cur_files
Thisform.grdFiles.RecordSource = "cur_files"
Thisform.grdFiles.list_controlsource = "fileName"
Thisform.grdFiles.lista_ancho_cols = "300"
Thisform.grdFiles.titulos_cabeceras = "Archivos Encontrados"

lcSql = "SELECT MAX(idCliente) AS maxCliente FROM clientes"
loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_cli"
loResult.OpenQuery(lcSql)

SELECT cur_Cli
lnMaxID = cur_Cli.maxCliente
loResult.Close_Query

loProgress.show()

&& Recorro todos los números de clientes posibles
FOR nroCli = 1 TO lnMaxID
	FOR dia = 1 TO DAY(DATE())
		FOR nroPedExt = 1 TO 100
			lcFileName = REPLICATE("0", 2 - LEN(ALLTRIM(STR(dia)))) + ALLTRIM(STR(dia)) + ;
				REPLICATE("0", 2 - LEN(ALLTRIM(STR(MONTH(DATE()))))) + ALLTRIM(STR(MONTH(DATE()))) + ;
				ALLTRIM(STR(YEAR(DATE()))) + "_" + ALLTRIM(STR(nroCli)) + "_" + ALLTRIM(STR(nroPedExt)) + ".txt"
			
			IF VFPHTTP("http://www.siscom.hol.es/mg/Pedidos/" + lcFileName, "intercambio\" + lcFileName) THEN
				SELECT cur_files
				APPEND BLANK
				REPLACE fileName WITH lcFileName
				Thisform.grdFiles.Refresh()	
			ENDIF	
		ENDFOR
	ENDFOR
	
	lnPorc = (nroCli * 100) / lnMaxID
	loProgress.update(lnPorc)
ENDFOR

loProgress.Complete()

SELECT cur_files
IF RECCOUNT("cur_files") > 0 THEN
	GO TOP
ENDIF

Thisform.grdFiles.Refresh()

ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Cant. Pedido Bajados:"
Height = 15
Left = 24
Top = 12
Width = 132
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: txtCantPed
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Left = 159
Top = 8
isnumeric = .T.
Name = "txtCantPed"

*** METODOS ***


************************************************************
OBJETO: grdFiles
************************************************************
*** PROPIEDADES ***
Height = 157
Left = 4
Top = 36
Width = 651
Name = "grdFiles"
COLUMN1.Header1.Name = "Header1"
COLUMN1.Text1.Name = "Text1"
COLUMN1.Name = "COLUMN1"
COLUMN2.Header1.Name = "Header1"
COLUMN2.Text1.Name = "Text1"
COLUMN2.Name = "COLUMN2"
COLUMN3.Header1.Name = "Header1"
COLUMN3.Text1.Name = "Text1"
COLUMN3.Name = "COLUMN3"
COLUMN4.Header1.Name = "Header1"
COLUMN4.Text1.Name = "Text1"
COLUMN4.Name = "COLUMN4"
COLUMN5.Header1.Name = "Header1"
COLUMN5.Text1.Name = "Text1"
COLUMN5.Name = "COLUMN5"
COLUMN6.Header1.Name = "Header1"
COLUMN6.Text1.Name = "Text1"
COLUMN6.Name = "COLUMN6"
COLUMN7.Header1.Name = "Header1"
COLUMN7.Text1.Name = "Text1"
COLUMN7.Name = "COLUMN7"
COLUMN8.Header1.Name = "Header1"
COLUMN8.Text1.Name = "Text1"
COLUMN8.Name = "COLUMN8"
COLUMN9.Header1.Name = "Header1"
COLUMN9.Text1.Name = "Text1"
COLUMN9.Name = "COLUMN9"
COLUMN10.Header1.Name = "Header1"
COLUMN10.Text1.Name = "Text1"
COLUMN10.Name = "COLUMN10"
COLUMN11.Header1.Name = "Header1"
COLUMN11.Text1.Name = "Text1"
COLUMN11.Name = "COLUMN11"
COLUMN12.Header1.Name = "Header1"
COLUMN12.Text1.Name = "Text1"
COLUMN12.Name = "COLUMN12"
COLUMN13.Header1.Name = "Header1"
COLUMN13.Text1.Name = "Text1"
COLUMN13.Name = "COLUMN13"
COLUMN14.Header1.Name = "Header1"
COLUMN14.Text1.Name = "Text1"
COLUMN14.Name = "COLUMN14"
COLUMN15.Header1.Name = "Header1"
COLUMN15.Text1.Name = "Text1"
COLUMN15.Name = "COLUMN15"
COLUMN16.Header1.Name = "Header1"
COLUMN16.Text1.Name = "Text1"
COLUMN16.Name = "COLUMN16"
COLUMN17.Header1.Name = "Header1"
COLUMN17.Text1.Name = "Text1"
COLUMN17.Name = "COLUMN17"
COLUMN18.Header1.Name = "Header1"
COLUMN18.Text1.Name = "Text1"
COLUMN18.Name = "COLUMN18"
COLUMN19.Header1.Name = "Header1"
COLUMN19.Text1.Name = "Text1"
COLUMN19.Name = "COLUMN19"
COLUMN20.Header1.Name = "Header1"
COLUMN20.Text1.Name = "Text1"
COLUMN20.Name = "COLUMN20"

*** METODOS ***


************************************************************
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 197
Left = 609
Height = 36
Width = 45
Name = "btnCerrar"

*** METODOS ***


************************************************************
OBJETO: 
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 13, 11, 11, 2, 0
Arial, 1, 8, 6, 13, 11, 12, 2, 0
Arial, 0, 9, 5, 13, 11, 11, 2, 0

*** METODOS ***


