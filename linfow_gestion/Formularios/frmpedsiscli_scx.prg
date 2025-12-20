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
Caption = "Pedidos externos pendientes"
Name = "FRMPEDSISCLI"

*** METODOS ***
PROCEDURE Load
LOCAL loRes
LOCAL lcSql

DODEFAULT()

&& El siguiente cursor graba los archivos pendientes
&& de pedidos que hay que descargar

CREATE TABLE cur_pend (	;
	idPedCab	int,;
	fecha		datetime	,;
	idCliente	int			,;
	razSoc		varchar(60))
	
loRes = CREATEOBJECT("odbc_result")
lcSql = ""

lcSql = "SELECT pedext.idPedCab, "
lcSql = lcSql + "MAX(pedext.fecEmis) AS fecEmis, "
lcSql = lcSql + "MAX(pedext.idCliente) AS idCliente, "
lcSql = lcSql + "MAX(clientes.razSoc) AS razSoc "
lcSql = lcSql + "FROM pedext "
lcSql = lcSql + " INNER JOIN clientes ON clientes.idCliente = pedext.idCliente "
lcSql = lcSql + "WHERE pedext.procesado = 0 "
lcSql = lcSql + "GROUP BY pedext.idPedCab "

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_temp"
IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN
ENDIF

SELECT cur_temp
DO WHILE !EOF("cur_temp")
	SELECT cur_pend
	APPEND BLANK
	REPLACE cur_pend.idPedCab WITH cur_temp.idPedCab
	REPLACE cur_pend.fecha WITH cur_temp.fecEmis ADDITIVE
	REPLACE cur_pend.idCliente WITH cur_temp.idCliente ADDITIVE
	REPLACE cur_pend.razSoc WITH cur_temp.razSoc ADDITIVE

	SELECT cur_temp
	SKIP
ENDDO

loRes.Close_Query()

SELECT cur_pend
GO TOP

ENDPROC
PROCEDURE Init
DODEFAULT()

SELECT cur_Pend
Thisform.grdPendi.RecordSource = "cur_Pend"
Thisform.grdPendi.alias_name = "cur_Pend"
Thisform.grdPendi.titulos_cabeceras = "Nro. Arch.,Cliente,razSoc,Fecha"
Thisform.grdPendi.list_controlsource = "idPedCab,idCliente,razSoc,fecha"
Thisform.grdPendi.lista_ancho_cols = "70,70,200,150"
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
OBJETO: 
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


