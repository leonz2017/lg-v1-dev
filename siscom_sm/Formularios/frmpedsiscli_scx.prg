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
OBJETO: FRMPEDSISCLI
************************************************************
*** PROPIEDADES ***
BorderStyle = 1
Height = 390
Width = 713
DoCreate = .T.
Caption = "Listado de Pedidos Pendientes SISCLI"
Name = "FRMPEDSISCLI"

*** METODOS ***
PROCEDURE Load
LOCAL loSoapCli, lcIds, lnId, lcRegistro
LOCAL lnCodCli, lcSql, loResult

lcIds = ""
lnId = 0
lcRegistro = ""
lnCodCli = 0
lcSql = ""
loResult = CREATEOBJECT("odbc_result")

DODEFAULT()

&& El siguiente cursor graba los archivos pendientes
&& de pedidos que hay que descargar

CREATE TABLE cur_pend (	;
	idPedArch	int,;
	fecha		varchar(10)	,;
	fileName	varchar(60)	,;
	codCli		int			,;
	razSoc		varchar(60))
	
loSoapCli = CREATEOBJECT("MSSOAP.SoapClient30")
loSoapCli.MSSoapInit(gcUrlWS)

lcIds = loSoapCli.getIdsNoProc(0)

IF ALLTRIM(lcIds) == "-1" THEN
	RETURN
ENDIF

FOR i = 1 TO GETWORDCOUNT(lcIds, "|")
	lnId = GETWORDNUM(lcIds, i, "|")
	lcRegistro = loSoapCli.getByID(lnId)
	lnCodCli = INT(VAL(GETWORDNUM(lcRegistro, 4, "|")))
	
	lcSql = "SELECT * FROM clientes WHERE idCliente = " + ALLTRIM(STR(lnCodCli))
	loResult.ActiveConnection = goConn.ActiveConnection
	loResult.Cursor_Name = "cur_tmp"
	loResult.OpenQuery(lcSql)
	
	SELECT cur_Pend
	APPEND BLANK
	REPLACE idPedArch WITH INT(VAL(GETWORDNUM(lcRegistro, 1, "|")))
	REPLACE fecha WITH GETWORDNUM(lcRegistro, 2, "|") ADDITIVE
	REPLACE fileName WITH GETWORDNUM(lcRegistro, 3, "|") ADDITIVE
	REPLACE codCli WITH INT(VAL(GETWORDNUM(lcRegistro, 4, "|"))) ADDITIVE
	REPLACE razSoc WITH ALLTRIM(cur_tmp.razSoc) ADDITIVE
	
	loResult.Close_Query()
NEXT i

SELECT cur_Pend
IF RECCOUNT("cur_Pend") > 0 THEN
	GO TOP
ENDIF
ENDPROC
PROCEDURE Init
DODEFAULT()

SELECT cur_Pend
Thisform.grdPendi.RecordSource = "cur_Pend"
Thisform.grdPendi.alias_name = "cur_Pend"
Thisform.grdPendi.titulos_cabeceras = "Nro. Arch.,Cliente,razSoc,Fecha"
Thisform.grdPendi.list_controlsource = "idPedArch,codCli,razSoc,fecha"
Thisform.grdPendi.lista_ancho_cols = "70,70,200,70"
Thisform.grdPendi.generar_grid()
ENDPROC


************************************************************
OBJETO: grdPendi
************************************************************
*** PROPIEDADES ***
Height = 343
Left = 0
Top = 0
Width = 713
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdPendi"
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
Top = 345
Left = 667
Height = 44
Width = 45
Caption = ""
Name = "btnCerrar"

*** METODOS ***


************************************************************
OBJETO: btnMarcarPedido
************************************************************
*** PROPIEDADES ***
Top = 345
Left = 4
Height = 44
Width = 156
Caption = "\<Marcar como descargado"
Name = "btnMarcarPedido"

*** METODOS ***
PROCEDURE Click
LOCAL lnResp

SELECT cur_Pend
IF RECCOUNT("cur_Pend") = 0 THEN
	MESSAGEBOX("No hay pedido para marcar", 0+64, Thisform.Caption)
ELSE
	lnResp = MESSAGEBOX("El pédido " + ALLTRIM(STR(cur_Pend.idPedArch)) + " se está por marcar, ¿desea continuar?", 4+32, Thisform.Caption)
	
	IF lnResp = 6 THEN
		loSoapCli = CREATEOBJECT("MSSOAP.SoapClient30")
		loSoapCli.MSSoapInit(gcUrlWS)
		loSoapCli.marcarProcesado(cur_Pend.idPedArch)

		MESSAGEBOX("El pedido " + ALLTRIM(STR(cur_Pend.idPedArch)) + " ha sido marcado como procesado", 0+64, Thisform.Caption)
	ENDIF
ENDIF
ENDPROC


************************************************************
OBJETO: 
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


