************************************************************
OBJETO: mg_pedidos_online_edit
************************************************************
*** PROPIEDADES ***
DoCreate = .T.
tipo_sistema = 0
db_web_connection = 
Name = "mg_pedidos_online_edit"
CLSETIQUETA1.Name = "CLSETIQUETA1"
Clsetiqueta2.Name = "Clsetiqueta2"
Clsetiqueta3.Name = "Clsetiqueta3"
Clsetiqueta4.Name = "Clsetiqueta4"
txtCodArtOrigen.Name = "txtCodArtOrigen"
txtDescripcion.Name = "txtDescripcion"
sel_articulo.txtCodigo.Name = "txtCodigo"
sel_articulo.txtDescripcion.Name = "txtDescripcion"
sel_articulo.Name = "sel_articulo"
btnGrabar.Name = "btnGrabar"
btnCancelar.Name = "btnCancelar"
grdSugerencias.COLUMN1.Header1.Name = "Header1"
grdSugerencias.COLUMN1.Text1.Name = "Text1"
grdSugerencias.COLUMN1.Name = "COLUMN1"
grdSugerencias.COLUMN2.Header1.Name = "Header1"
grdSugerencias.COLUMN2.Text1.Name = "Text1"
grdSugerencias.COLUMN2.Name = "COLUMN2"
grdSugerencias.COLUMN3.Header1.Name = "Header1"
grdSugerencias.COLUMN3.Text1.Name = "Text1"
grdSugerencias.COLUMN3.Name = "COLUMN3"
grdSugerencias.COLUMN4.Header1.Name = "Header1"
grdSugerencias.COLUMN4.Text1.Name = "Text1"
grdSugerencias.COLUMN4.Name = "COLUMN4"
grdSugerencias.COLUMN5.Header1.Name = "Header1"
grdSugerencias.COLUMN5.Text1.Name = "Text1"
grdSugerencias.COLUMN5.Name = "COLUMN5"
grdSugerencias.COLUMN6.Header1.Name = "Header1"
grdSugerencias.COLUMN6.Text1.Name = "Text1"
grdSugerencias.COLUMN6.Name = "COLUMN6"
grdSugerencias.COLUMN7.Header1.Name = "Header1"
grdSugerencias.COLUMN7.Text1.Name = "Text1"
grdSugerencias.COLUMN7.Name = "COLUMN7"
grdSugerencias.COLUMN8.Header1.Name = "Header1"
grdSugerencias.COLUMN8.Text1.Name = "Text1"
grdSugerencias.COLUMN8.Name = "COLUMN8"
grdSugerencias.COLUMN9.Header1.Name = "Header1"
grdSugerencias.COLUMN9.Text1.Name = "Text1"
grdSugerencias.COLUMN9.Name = "COLUMN9"
grdSugerencias.COLUMN10.Header1.Name = "Header1"
grdSugerencias.COLUMN10.Text1.Name = "Text1"
grdSugerencias.COLUMN10.Name = "COLUMN10"
grdSugerencias.COLUMN11.Header1.Name = "Header1"
grdSugerencias.COLUMN11.Text1.Name = "Text1"
grdSugerencias.COLUMN11.Name = "COLUMN11"
grdSugerencias.COLUMN12.Header1.Name = "Header1"
grdSugerencias.COLUMN12.Text1.Name = "Text1"
grdSugerencias.COLUMN12.Name = "COLUMN12"
grdSugerencias.COLUMN13.Header1.Name = "Header1"
grdSugerencias.COLUMN13.Text1.Name = "Text1"
grdSugerencias.COLUMN13.Name = "COLUMN13"
grdSugerencias.COLUMN14.Header1.Name = "Header1"
grdSugerencias.COLUMN14.Text1.Name = "Text1"
grdSugerencias.COLUMN14.Name = "COLUMN14"
grdSugerencias.COLUMN15.Header1.Name = "Header1"
grdSugerencias.COLUMN15.Text1.Name = "Text1"
grdSugerencias.COLUMN15.Name = "COLUMN15"
grdSugerencias.COLUMN16.Header1.Name = "Header1"
grdSugerencias.COLUMN16.Text1.Name = "Text1"
grdSugerencias.COLUMN16.Name = "COLUMN16"
grdSugerencias.COLUMN17.Header1.Name = "Header1"
grdSugerencias.COLUMN17.Text1.Name = "Text1"
grdSugerencias.COLUMN17.Name = "COLUMN17"
grdSugerencias.COLUMN18.Header1.Name = "Header1"
grdSugerencias.COLUMN18.Text1.Name = "Text1"
grdSugerencias.COLUMN18.Name = "COLUMN18"
grdSugerencias.COLUMN19.Header1.Name = "Header1"
grdSugerencias.COLUMN19.Text1.Name = "Text1"
grdSugerencias.COLUMN19.Name = "COLUMN19"
grdSugerencias.COLUMN20.Header1.Name = "Header1"
grdSugerencias.COLUMN20.Text1.Name = "Text1"
grdSugerencias.COLUMN20.Name = "COLUMN20"
grdSugerencias.Name = "grdSugerencias"

*** METODOS ***
PROCEDURE connet_to_web
LOCAL lcCadenaConexion

lcCadenaConexion = getConfig("SCWCONN")
Thisform.db_web_connection = CREATEOBJECT("odbc_connect")
Thisform.db_web_connection.ConnectionString = lcCadenaConexion
IF !Thisform.db_web_connection.Open() THEN
	MESSAGEBOX(Thisform.db_web_connection.ErrorMessage, 0+16, Thisform.Caption)
	RETURN .F.
ENDIF
RETURN .T.
ENDPROC
PROCEDURE disconnect_from_web
thisform.db_web_connection.close()
ENDPROC
PROCEDURE grabar
LOCAL loRes
LOCAL lcSql

loRes = CREATEOBJECT("odbc_result")

IF Thisform.sel_articulo.valcpoid = 0 THEN
	MESSAGEBOX("No ha seleccionado ningún artículo para corregir", 0+48, Thisform.Caption)
	Thisform.sel_articulo.txtCodigo.SetFocus()
	RETURN
ENDIF

lcSql = "CALL pedidos_corregir (?pIdPedArch, ?pIdItem, ?pCodArt)"
lcSql = loRes.AddParameter(lcSql, "pIdPedArch", ALLTRIM(STR(Thisform.idpedarch)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "pIdItem", ALLTRIM(STR(Thisform.iditem)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "pCodArt", ALLTRIM(Thisform.sel_articulo.txtCodigo.Value), .t., .f.)

if This.tipo_sistema = 1 then
	* Se conecta a la base del catálogo web
	Thisform.connet_to_web()
	loRes.ActiveConnection = Thisform.db_web_connection.activeConnection
else
	* Se conecta a la base del siscli
	Thisform.connect_tocloud_w32()
	loRes.ActiveConnection = Thisform.siscli_w32_conn.activeConnection
endif

loRes.Cursor_Name = "cur_x"
loRes.OpenQuery(lcSql)
SELECT cur_x
IF !(ALLTRIM(cur_x.result) == "OK") THEN
	MESSAGEBOX(cur_x.result, 0+48, Thisform.Caption)
ELSE
	MESSAGEBOX("La corrección fué existosa, vuelva a descargar los pedidos, hace clic en descargar nuevamente.", 0+64, Thisform.Caption)
	Thisform.Release()
ENDIF
loRes.Close_Query()

if this.tipo_sistema = 1 then
	* Si el pedido vino de la web entonces se desconecta de la web
	thisform.disconnect_from_web()
else
	* Si el pedido vino por el siscli entonces se desconecta de la base del siscli
	Thisform.diconnect_fromcloud_w32()
endif

ENDPROC


************************************************************
OBJETO: mg_pedidos_online_edit
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


