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
OBJETO: FRM_OFERTAS
************************************************************
*** PROPIEDADES ***
DoCreate = .T.
Name = "FRM_OFERTAS"
contenido.Clsetiqueta1.Name = "Clsetiqueta1"
contenido.Clsetiqueta2.Name = "Clsetiqueta2"
contenido.txtFecVigDD.Name = "txtFecVigDD"
contenido.txtFecVigHH.Name = "txtFecVigHH"
contenido.Clsetiqueta3.Name = "Clsetiqueta3"
contenido.Clslinea1.Name = "Clslinea1"
contenido.Clsetiqueta4.Name = "Clsetiqueta4"
contenido.txtValorBuscado.Name = "txtValorBuscado"
contenido.btnBuscar.Name = "btnBuscar"
contenido.btnGrabar.Name = "btnGrabar"
contenido.btnCancelar.Name = "btnCancelar"
contenido.btnCerrar.Name = "btnCerrar"
contenido.grdArticulos.COLUMN1.Header1.Name = "Header1"
contenido.grdArticulos.COLUMN1.Text1.Name = "Text1"
contenido.grdArticulos.COLUMN1.Name = "COLUMN1"
contenido.grdArticulos.COLUMN2.Header1.Name = "Header1"
contenido.grdArticulos.COLUMN2.Text1.Name = "Text1"
contenido.grdArticulos.COLUMN2.Name = "COLUMN2"
contenido.grdArticulos.COLUMN3.Header1.Name = "Header1"
contenido.grdArticulos.COLUMN3.Text1.Name = "Text1"
contenido.grdArticulos.COLUMN3.Name = "COLUMN3"
contenido.grdArticulos.COLUMN4.Header1.Name = "Header1"
contenido.grdArticulos.COLUMN4.Text1.Name = "Text1"
contenido.grdArticulos.COLUMN4.Name = "COLUMN4"
contenido.grdArticulos.COLUMN5.Header1.Name = "Header1"
contenido.grdArticulos.COLUMN5.Text1.Name = "Text1"
contenido.grdArticulos.COLUMN5.Name = "COLUMN5"
contenido.grdArticulos.COLUMN6.Header1.Name = "Header1"
contenido.grdArticulos.COLUMN6.Text1.Name = "Text1"
contenido.grdArticulos.COLUMN6.Name = "COLUMN6"
contenido.grdArticulos.COLUMN7.Header1.Name = "Header1"
contenido.grdArticulos.COLUMN7.Text1.Name = "Text1"
contenido.grdArticulos.COLUMN7.Name = "COLUMN7"
contenido.grdArticulos.COLUMN8.Header1.Name = "Header1"
contenido.grdArticulos.COLUMN8.Text1.Name = "Text1"
contenido.grdArticulos.COLUMN8.Name = "COLUMN8"
contenido.grdArticulos.COLUMN9.Header1.Name = "Header1"
contenido.grdArticulos.COLUMN9.Text1.Name = "Text1"
contenido.grdArticulos.COLUMN9.Name = "COLUMN9"
contenido.grdArticulos.COLUMN10.Header1.Name = "Header1"
contenido.grdArticulos.COLUMN10.Text1.Name = "Text1"
contenido.grdArticulos.COLUMN10.Name = "COLUMN10"
contenido.grdArticulos.COLUMN11.Header1.Name = "Header1"
contenido.grdArticulos.COLUMN11.Text1.Name = "Text1"
contenido.grdArticulos.COLUMN11.Name = "COLUMN11"
contenido.grdArticulos.COLUMN12.Header1.Name = "Header1"
contenido.grdArticulos.COLUMN12.Text1.Name = "Text1"
contenido.grdArticulos.COLUMN12.Name = "COLUMN12"
contenido.grdArticulos.COLUMN13.Header1.Name = "Header1"
contenido.grdArticulos.COLUMN13.Text1.Name = "Text1"
contenido.grdArticulos.COLUMN13.Name = "COLUMN13"
contenido.grdArticulos.COLUMN14.Header1.Name = "Header1"
contenido.grdArticulos.COLUMN14.Text1.Name = "Text1"
contenido.grdArticulos.COLUMN14.Name = "COLUMN14"
contenido.grdArticulos.COLUMN15.Header1.Name = "Header1"
contenido.grdArticulos.COLUMN15.Text1.Name = "Text1"
contenido.grdArticulos.COLUMN15.Name = "COLUMN15"
contenido.grdArticulos.COLUMN16.Header1.Name = "Header1"
contenido.grdArticulos.COLUMN16.Text1.Name = "Text1"
contenido.grdArticulos.COLUMN16.Name = "COLUMN16"
contenido.grdArticulos.COLUMN17.Header1.Name = "Header1"
contenido.grdArticulos.COLUMN17.Text1.Name = "Text1"
contenido.grdArticulos.COLUMN17.Name = "COLUMN17"
contenido.grdArticulos.COLUMN18.Header1.Name = "Header1"
contenido.grdArticulos.COLUMN18.Text1.Name = "Text1"
contenido.grdArticulos.COLUMN18.Name = "COLUMN18"
contenido.grdArticulos.COLUMN19.Header1.Name = "Header1"
contenido.grdArticulos.COLUMN19.Text1.Name = "Text1"
contenido.grdArticulos.COLUMN19.Name = "COLUMN19"
contenido.grdArticulos.COLUMN20.Header1.Name = "Header1"
contenido.grdArticulos.COLUMN20.Text1.Name = "Text1"
contenido.grdArticulos.COLUMN20.Name = "COLUMN20"
contenido.grdArticulos.Name = "grdArticulos"
contenido.Name = "contenido"
btnEliminar.Name = "btnEliminar"

*** METODOS ***
PROCEDURE cargar_oferta
LOCAL loForm, loResul, lcSql


loForm = CREATEOBJECT("cls_frm_editoftas")
loResult = CREATEOBJECT("odbc_result")
lcSql = ""

SELECT cur_ofertas
lcSql = "SELECT * FROM articulos WHERE idArticulo = " + ALLTRIM(STR(cur_ofertas.idArticulo))
loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_art"

IF !loResult.OpenQuery(lcSql) THEN
	MESSAGEBOX(loResult.Error_Message, 0+48, Thisform.Caption)
	RETURN
ENDIF

loForm.txtCodArt.Value = cur_art.codArt
loForm.txtDescripcion.Value = cur_art.descripcio
loForm.txtPrMay.value = cur_art.prventaMin
loForm.txtFecVigDD.Value = cur_ofertas.fecVigDD
loForm.txtFecVigHH.Value = cur_ofertas.fecVigHH
loForm.txtPorOfta.value = cur_ofertas.porOfert
loForm.txtPrOfertaMay.Value = cur_ofertas.impOfert

loResult.Close_Query()

loForm.Show()

IF loForm.presiono_aceptar THEN
	SELECT cur_ofertas
	LOCK()
	REPLACE cur_ofertas.marcado WITH .T. 
	REPLACE cur_ofertas.fecVigDD WITH loForm.txtFecVigDD.Value ADDITIVE 
	REPLACE cur_ofertas.fecVigHH WITH loForm.txtFecVigHH.Value ADDITIVE
	REPLACE cur_ofertas.porOfert WITH loForm.txtPorOfta.value ADDITIVE
	REPLACE cur_ofertas.impOfert WITH loForm.txtPrOfertaMay.value ADDITIVE
	UNLOCK
	
	Thisform.contenido.grdArticulos.Refresh()
ENDIF

loForm.release()

ENDPROC


************************************************************
OBJETO: 
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


