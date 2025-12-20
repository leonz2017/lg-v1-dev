************************************************************
OBJETO: cls_db_script
************************************************************
*** PROPIEDADES ***
BorderStyle = 2
Height = 420
Width = 821
DoCreate = .T.
Caption = "SQL Script"
Name = "cls_db_script"

*** METODOS ***


************************************************************
OBJETO: txtScript
************************************************************
*** PROPIEDADES ***
FontBold = .T.
FontName = "Source Code Pro Black"
FontSize = 9
Height = 361
Left = 4
Top = 6
Width = 812
Name = "txtScript"

*** METODOS ***


************************************************************
OBJETO: btnAceptar
************************************************************
*** PROPIEDADES ***
Top = 372
Left = 378
Name = "btnAceptar"

*** METODOS ***
PROCEDURE Click
Thisform.Release()
ENDPROC


************************************************************
OBJETO: cls_db_script
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Source Code Pro Black, 1, 9, 7, 15, 12, 12, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_db_comparador
************************************************************
*** PROPIEDADES ***
Height = 575
Width = 941
DoCreate = .T.
Caption = "LINFOW DB Manager - Comparador"
MaxButton = .T.
MinButton = .T.
WindowState = 0
current_db = 
o_conn = 
Name = "cls_db_comparador"
contenido.TabIndex = 1
contenido.Name = "contenido"

*** METODOS ***
PROCEDURE obtener_tablas
LOCAL loRes
LOCAL lcSql

TEXT TO lcSql
	SELECT
		TABLE_NAME
	FROM
		information_schema.TABLES
	WHERE
		TABLE_SCHEMA = ?currentDB AND
		TABLE_NAME NOT IN	(
				SELECT
					TABLE_NAME
				FROM
					information_schema.TABLES
				WHERE
					TABLE_SCHEMA = ?destiny_db
			)
	ORDER BY
		TABLE_NAME;
ENDTEXT

loRes = CREATEOBJECT("odbc_result")
lcSql = loRes.AddParameter(lcSql, "currentDB", ALLTRIM(this.current_db), .t., .f.)
lcSql = loRes.AddParameter(lcSql, "destiny_db", ALLTRIM(This.contenido.txtNombreBase.Value), .t., .f.)
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"
IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF
SELECT cur_tables
ZAP
APPEND FROM DBF("cur_x")
GO TOP
This.Contenido.pages.page1.grdTablas.Refresh()
loRes.Close_Query()

RETURN .T.
ENDPROC
PROCEDURE obtener_columnas
LOCAL loRes
LOCAL lcSql

TEXT TO lcSql
	SELECT
		TABLE_NAME,
		COLUMN_NAME,
		COLUMN_TYPE,
		IS_NULLABLE,
		COLUMN_DEFAULT,
		COLUMN_KEY,
		COLUMN_COMMENT
	FROM
		information_schema.COLUMNS
	WHERE
		TABLE_SCHEMA = ?currentDB AND
		COLUMN_NAME NOT IN (
			SELECT
				COLUMN_NAME
			FROM
				information_schema.COLUMNS
			WHERE
				TABLE_SCHEMA = ?destiny_db)
	ORDER BY
		TABLE_NAME;
ENDTEXT

loRes = CREATEOBJECT("odbc_result")
lcSql = loRes.AddParameter(lcSql, "currentDB", ALLTRIM(this.current_db), .t., .f.)
lcSql = loRes.AddParameter(lcSql, "destiny_db", ALLTRIM(This.contenido.txtNombreBase.Value), .t., .f.)
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"
IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF
SELECT cur_columns
ZAP
APPEND FROM DBF("cur_x")
GO TOP
This.Contenido.pages.page1.grdColumnas.Refresh()
loRes.Close_Query()

RETURN .T.
ENDPROC
PROCEDURE obtener_procedimientos
LOCAL loRes
LOCAL lcSql

loRes = CREATEOBJECT("odbc_result")

TEXT TO lcSql NOSHOW
	SELECT
		ROUTINE_NAME,
		ROUTINE_TYPE
	FROM
		information_schema.routines
	WHERE
		routine_schema = ?currentDB AND
		routine_name NOT IN (
			SELECT 
				routine_name
			FROM 
				information_schema.routines
			WHERE 
				routine_schema = ?destiny_db);	
ENDTEXT
lcSql = loRes.AddParameter(lcSql, "currentDB", ALLTRIM(this.current_db), .t., .f.)
lcSql = loRes.AddParameter(lcSql, "destiny_db", ALLTRIM(this.contenido.txtNombreBase.Value), .t., .f.)
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"
IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, THisform.Caption)
	RETURN .F.
ENDIF
SELECT cur_routines
ZAP
APPEND FROM DBF("cur_x")
GO TOP
loRes.Close_Query()
this.contenido.pages.page2.grdProcedimientos.Refresh()

RETURN .T.
ENDPROC
PROCEDURE obtener_configuraciones
LOCAL loRes
LOCAL lcSql

loRes = CREATEOBJECT("odbc_result")
TEXT TO lcSql NOSHOW
	SELECT 
		idGlobalCF,
		cfg_key,
		cfg_type,
		cfg_value,
		usuAlta,
		idHostAlta
	FROM 
		?currentDB.global_cfg
	WHERE
		cfg_key NOT IN (
			SELECT 
				cfg_key
			FROM
				?destiny_db.global_cfg);
ENDTEXT
lcSql = loRes.AddParameter(lcSql, "currentDB", ALLTRIM(this.current_db), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "destiny_db", ALLTRIM(this.contenido.txtNombreBase.Value), .f., .f.)
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"
IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF
SELECT cur_configs
ZAP
APPEND FROM DBF("cur_x")
GO TOP
loRes.Close_Query()
Thisform.Contenido.Pages.Page3.grdConfiguraciones.Refresh()

RETURN .T.
ENDPROC
PROCEDURE conectar_destino
LOCAL lcConnectionString
LOCAL loRes
LOCAL lcSql
LOCAL lcCurrentDB

IF ALLTRIM(This.Contenido.txtNombreBase.Value) == "" THEN
	MESSAGEBOX("Debe ingresar el nombre de la base a comparar", 0+48, thisform.Caption)
	This.Contenido.txtNombreBase.SetFocus()
	RETURN .F.
ENDIF

lcSql = "SELECT DATABASE() AS dbname"
loRes = CREATEOBJECT("odbc_result")
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"
IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+16, Thisform.Caption)
	RETURN .F.
ENDIF
SELECT cur_x
lcCurrentDB = ALLTRIM(cur_x.dbname)
loRes.Close_Query()

thisform.o_conn = CREATEOBJECT("odbc_connect")
lcConnectionString = getconfig("ODBC_CONN")
lcConnectionString = STRTRAN(lcConnectionString, lcCurrentDB, This.Contenido.txtNombreBase.Value)
This.o_conn.ConnectionString = lcConnectionString
IF !This.o_conn.Open() THEN
	MESSAGEBOX(This.o_conn.ErrorMessage, 0+16, Thisform.Caption)
	RETURN .F.
ENDIF

this.current_db = lcCurrentDB

RETURN .T.
ENDPROC
PROCEDURE desconectar_destino
This.o_conn.Close()
ENDPROC
PROCEDURE exportar_tablas
LOCAL loForm
LOCAL loRes
LOCAL lcSql
LOCAL lcSaltoLinea
LOCAL lcScript
LOCAL lcSqlFile


lcSaltoLinea = CHR(10) + CHR(13)
loRes = CREATEOBJECT("odbc_result")
loForm = CREATEOBJECT("cls_db_script")

lcScript = ""
SELECT cur_tables
DO WHILE !EOF()
	lcSql = "SHOW CREATE TABLE ?tableName"
	lcSql = loRes.AddParameter(lcSql, "tableName", ALLTRIM(cur_tables.table_name), .f., .f.)
	loRes.ActiveConnection = goConn.ActiveConnection
	loRes.Cursor_Name = "cur_tmp"
	IF !loRes.OpenQuery(lcSql) THEN
		MESSAGEBOX(loRes.Error_Message, 0+16, Thisform.Caption)
		RETURN .F.
	ENDIF
	loForm.txtScript.value = loForm.txtScript.value + cur_tmp.Create_table + ";" + lcSaltoLinea + lcSaltoLinea
		
	SELECT cur_tables
	SKIP
ENDDO
loRes.Close_Query()

SELECT cur_tables
GO TOP
This.Contenido.Pages.Page1.grdTablas.Refresh()
loForm.Show()
RETURN .T.
ENDPROC
PROCEDURE obtener_sp_script
LOCAL loRes
LOCAL lcSql

loRes = CREATEOBJECT("odbc_result")
SELECT cur_routines
IF ALLTRIM(cur_routines.routine_type) == "PROCEDURE" THEN
	lcSql = "SHOW CREATE PROCEDURE ?routine_name"
ELSE
	lcSql = "SHOW CREATE FUNCTION ?routine_name"
ENDIF
lcSql = loRes.AddParameter(lcSql, "routine_name", ALLTRIM(cur_routines.routine_name), .f., .f.)
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"
IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN .f.
ENDIF
SELECT cur_x
IF ALLTRIM(cur_routines.routine_type) == "PROCEDURE" THEN
	Thisform.Contenido.Pages.Page2.txtScript.Value = cur_x.Create_procedure
ELSE
	Thisform.Contenido.Pages.Page2.txtScript.Value = cur_x.Create_function
ENDIF
Thisform.Contenido.Pages.Page2.txtScript.FontName = "Liberation Mono"
Thisform.Contenido.Pages.Page2.txtScript.FontSize = 9

loRes.Close_Query()

RETURN .t.
ENDPROC
PROCEDURE exportar_columnas
LOCAL lcSaltoLinea
LOCAL lcAlterTable
LOCAL lcScript
LOCAL lcFile

lcSaltoLinea = CHR(13) + CHR(10)
lcAlterTable = ""
lcScript = ""
SELECT cur_columns
GO TOP
DO WHILE !EOF("cur_columns")

	lcAlterTable = "ALTER TABLE table_name ADD column_name dataType isNull default;"
	lcAlterTable = STRTRAN(lcAlterTable, "table_name", ALLTRIM(cur_columns.table_name))
	lcAlterTable = STRTRAN(lcAlterTable, "column_name", ALLTRIM(cur_columns.column_name))
	lcAlterTable = STRTRAN(lcAlterTable, "dataType", ALLTRIM(cur_columns.column_type))
	IF ALLTRIM(cur_columns.is_nullable) == "YES" THEN
		lcAlterTable = STRTRAN(lcAlterTable, "isNull", "NULL")
		lcAlterTable = STRTRAN(lcAlterTable, "default", "")
	ELSE
		lcAlterTable = STRTRAN(lcAlterTable, "isNull", "NOT NULL")
		lcAlterTable = STRTRAN(lcAlterTable, "default", "DEFAULT " + ALLTRIM(cur_columns.column_default))
	ENDIF
	lcScript = lcScript + lcAlterTable + lcSaltoLinea

	SELECT cur_columns
	SKIP
ENDDO
SELECT cur_columns
GO TOP
lcFile = PUTFILE("SQL Script:", "columnas_faltantes.sql", "sql")
IF EMPTY(lcFile) THEN
	RETURN .F.
ENDIF
STRTOFILE(lcScript, lcFile)
MESSAGEBOX("Las columnas fueron exportadas satisfactoriamente", 0+64, Thisform.Caption)
RETURN .T.
ENDPROC
PROCEDURE exportar_configuraciones
LOCAL lcScript
LOCAL lcScr
LOCAL lcSalto
LOCAL lcFile

lcScr = ""
lcSalto = CHR(13) + CHR(10)
SELECT cur_configs
GO TOP
DO WHILE !EOF("cur_configs")
	TEXT TO lcScript NOSHOW
	SET @proxID = (SELECT MAX(idGlobalCF) + 1 FROM global_cfg);
	INSERT INTO global_cfg (idGlobalCF, cfg_key, cfg_Type, cfg_Value, usuAlta, fecAlta, idHostAlta)
	VALUES (@proxID, 'clave', 'dataType', 'value', 'user', CURRENT_TIMESTAMP, 'hostName');
	ENDTEXT
	lcScript = STRTRAN(lcScript, "clave", ALLTRIM(cur_configs.cfg_key))
	lcScript = STRTRAN(lcScript, "dataType", ALLTRIM(cur_configs.cfg_type))
	lcScript = STRTRAN(lcScript, "value", ALLTRIM(cur_configs.cfg_value))
	lcScript = STRTRAN(lcScript, "user", ALLTRIM(cur_configs.usuAlta))
	lcScript = STRTRAN(lcScript, "hostName", ALLTRIM(cur_configs.idHostAlta))
	lcScript = lcScript + lcSalto + lcSalto
	lcScr = lcScr + lcScript

	SELECT cur_configs
	SKIP
ENDDO
SELECT cur_configs
GO TOP
lcFile = PUTFILE("SQL Script", "configuraciones_faltantes.sql", "sql")
IF EMPTY(lcFile) THEN
	RETURN .F.
ENDIF
STRTOFILE(ALLTRIM(lcScr), lcFile)
RETURN .T.
ENDPROC
PROCEDURE Load
DODEFAULT()

CREATE CURSOR cur_tables (table_name varchar(30))

CREATE CURSOR cur_columns ( ;
	table_name varchar(30),;
	column_name varchar(30),;
	column_type varchar(30) NULL,;
	is_nullable varchar(10) NULL,;
	column_default varchar(30) NULL,;
	column_key varchar(5) NULL,;
	column_comment varchar(254) NULL)
	
CREATE CURSOR cur_routines ( ;
	routine_name varchar(100) ,;
	routine_type varchar(60))
	
CREATE CURSOR cur_configs ( ;
	idGlobalCF int,;
	cfg_key varchar(10),;
	cfg_type varchar(1),;
	cfg_value varchar(254),;
	usuAlta varchar(5),;
	idHostAlta varchar(60))
ENDPROC
PROCEDURE Init
SELECT cur_tables
This.Contenido.Pages.Page1.grdTablas.RecordSource = "cur_tables"
This.Contenido.Pages.Page1.grdTablas.Alias_name = "cur_tables"
This.Contenido.Pages.Page1.grdTablas.list_controlsource = "table_name"
This.Contenido.Pages.Page1.grdTablas.lista_ancho_cols = "150"
This.Contenido.Pages.Page1.grdTablas.titulos_cabeceras = "Tabla"
This.Contenido.Pages.Page1.grdTablas.generar_grid()

SELECT cur_columns
This.Contenido.Pages.Page1.grdColumnas.RecordSource = "cur_columns"
This.Contenido.Pages.Page1.grdColumnas.alias_name = "cur_columns"
This.Contenido.Pages.Page1.grdColumnas.list_controlsource = "table_name,column_name,column_type,is_nullable,column_default,column_key,column_comment"
This.Contenido.Pages.Page1.grdColumnas.lista_ancho_cols = "150,150,100,100,100,150,200"
This.Contenido.Pages.Page1.grdColumnas.titulos_cabeceras = "Tabla,Nombre Col.,Tipo,Es Nulo,Val. Pred.,Clave,Comentarios"
This.Contenido.Pages.Page1.grdColumnas.generar_grid()

SELECT cur_routines
This.Contenido.Pages.Page2.grdProcedimientos.RecordSource = "cur_routines"
This.Contenido.Pages.Page2.grdProcedimientos.Alias_name = "cur_routines"
This.Contenido.Pages.Page2.grdProcedimientos.list_controlsource = "routine_name,routine_type"
This.Contenido.Pages.Page2.grdProcedimientos.lista_ancho_cols = "200,200"
This.Contenido.Pages.Page2.grdProcedimientos.titulos_cabeceras = "Nombre,Tipo"
This.Contenido.Pages.Page2.grdProcedimientos.generar_grid()

SELECT cur_configs
This.Contenido.Pages.Page3.grdConfiguraciones.RecordSource = "cur_configs"
This.Contenido.Pages.Page3.grdConfiguraciones.Alias_name = "cur_configs"
This.Contenido.Pages.Page3.grdConfiguraciones.list_controlsource = "cfg_key,cfg_type,cfg_value"
This.Contenido.Pages.Page3.grdConfiguraciones.lista_ancho_cols = "100,70,200"
This.Contenido.Pages.Page3.grdConfiguraciones.titulos_cabeceras = "Clave,Tipo,Valor"
This.Contenido.Pages.Page3.grdConfiguraciones.generar_grid()


ENDPROC
PROCEDURE QueryUnload
This.desconectar_destino()
ENDPROC


************************************************************
OBJETO: pages
************************************************************
*** PROPIEDADES ***
ErasePage = .T.
PageCount = 3
Anchor = 15
Top = 34
Left = 7
Width = 934
Height = 495
TabIndex = 3
Name = "pages"
Page1.Caption = "Tablas/Columnas faltantes"
Page1.Name = "Page1"
Page2.Caption = "Procedimientos faltantes"
Page2.Name = "Page2"
Page3.FontBold = .T.
Page3.FontItalic = .T.
Page3.FontSize = 8
Page3.Caption = "Configuración global faltantes"
Page3.ForeColor = 128,64,64
Page3.Name = "Page3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Anchor = 3
Caption = "Tablas"
Height = 15
Left = 17
Top = 10
Width = 72
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: grdTablas
************************************************************
*** PROPIEDADES ***
Anchor = 7
Height = 396
Left = 16
Top = 30
Width = 186
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdTablas"
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
PROCEDURE AfterRowColChange
LPARAMETERS nColIndex

ENDPROC


************************************************************
OBJETO: grdColumnas
************************************************************
*** PROPIEDADES ***
Anchor = 15
Height = 396
Left = 207
Top = 30
Width = 715
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdColumnas"
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
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Anchor = 3
Caption = "Columnas"
Height = 15
Left = 209
Top = 10
Width = 72
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: btnExportarTablas
************************************************************
*** PROPIEDADES ***
Top = 431
Left = 16
Height = 28
Width = 186
Anchor = 6
Caption = "Ver create table"
Name = "btnExportarTablas"

*** METODOS ***
PROCEDURE Click
=Thisform.exportar_tablas()
ENDPROC


************************************************************
OBJETO: Clsgenerico1
************************************************************
*** PROPIEDADES ***
Top = 431
Left = 486
Height = 28
Width = 186
Anchor = 12
Caption = "Exportar columnas"
Name = "Clsgenerico1"

*** METODOS ***
PROCEDURE Click
=Thisform.exportar_columnas()
ENDPROC


************************************************************
OBJETO: grdProcedimientos
************************************************************
*** PROPIEDADES ***
Anchor = 7
Height = 460
Left = 5
TabIndex = 1
Top = 3
Width = 186
Name = "grdProcedimientos"
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
PROCEDURE AfterRowColChange
LPARAMETERS nColIndex
=Thisform.obtener_sp_script()
ENDPROC


************************************************************
OBJETO: txtScript
************************************************************
*** PROPIEDADES ***
FontName = "Liberation Mono"
FontSize = 8
Anchor = 15
Height = 459
Left = 195
ReadOnly = .T.
TabIndex = 2
Top = 3
Width = 732
Name = "txtScript"

*** METODOS ***


************************************************************
OBJETO: grdConfiguraciones
************************************************************
*** PROPIEDADES ***
Anchor = 15
Height = 429
Left = 5
TabIndex = 1
Top = 5
Width = 912
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdConfiguraciones"
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
OBJETO: btnExportarProcedimientos
************************************************************
*** PROPIEDADES ***
Top = 436
Left = 369
Height = 28
Width = 186
Anchor = 12
Caption = "Exportar configuraciones"
TabIndex = 2
Name = "btnExportarProcedimientos"

*** METODOS ***
PROCEDURE Click
MESSAGEBOX("RECORDATORIO: Si en la configuraciones hay Path, poner las doble barras invertidas", 0+64, Thisform.Caption)
=Thisform.exportar_configuraciones()
ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Anchor = 3
Caption = "Base a comparar:"
Height = 15
Left = 10
Top = 13
Width = 111
TabIndex = 5
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: txtNombreBase
************************************************************
*** PROPIEDADES ***
Anchor = 3
Height = 21
Left = 117
TabIndex = 1
Top = 8
Width = 388
Name = "txtNombreBase"

*** METODOS ***


************************************************************
OBJETO: btnConectar
************************************************************
*** PROPIEDADES ***
Top = 6
Left = 517
Height = 26
Width = 96
Anchor = 3
Caption = "Concectar"
TabIndex = 2
Name = "btnConectar"

*** METODOS ***
PROCEDURE Click
=Thisform.conectar_destino()
=Thisform.obtener_tablas()
=Thisform.obtener_columnas()
=Thisform.obtener_procedimientos()
=Thisform.obtener_configuraciones()

ENDPROC


************************************************************
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 527
Left = 894
Anchor = 12
TabIndex = 6
Name = "btnCerrar"

*** METODOS ***


************************************************************
OBJETO: btnRefrescar
************************************************************
*** PROPIEDADES ***
Top = 6
Left = 622
Height = 26
Width = 96
Anchor = 3
Caption = "Refrescar"
TabIndex = 4
Name = "btnRefrescar"

*** METODOS ***
PROCEDURE Click
=Thisform.obtener_tablas()
=Thisform.obtener_columnas()
=Thisform.obtener_procedimientos()
=Thisform.obtener_configuraciones()

ENDPROC


************************************************************
OBJETO: cls_db_comparador
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


