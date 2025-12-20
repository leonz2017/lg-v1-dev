************************************************************
OBJETO: cls_login_vend
************************************************************
*** PROPIEDADES ***
DoCreate = .T.
Name = "cls_login_vend"
contenido.Clsetiqueta1.Name = "Clsetiqueta1"
contenido.Clsetiqueta2.Name = "Clsetiqueta2"
contenido.txtUsuario.Name = "txtUsuario"
contenido.txtPassword.Name = "txtPassword"
contenido.BTNCERRAR.Name = "BTNCERRAR"
contenido.Clsetiqueta3.Name = "Clsetiqueta3"
contenido.CLSLINEA1.Name = "CLSLINEA1"
contenido.btnlogin.Name = "btnlogin"
contenido.Name = "contenido"

*** METODOS ***
PROCEDURE contenido.btnlogin.Click
LOCAL lcUsuario, lcClave
LOCAL rsUser, lcSql

rsUser = CREATEOBJECT("odbc_result")
lcSql = ""

WITH Thisform.contenido
	IF ALLTRIM(.txtUsuario.Value) == ""
		MESSAGEBOX("Debe ingresar el usuario", 0+48, Thisform.Caption)
		.txtUsuario.SetFocus
		RETURN .F.
	ENDIF
	
	IF ALLTRIM(.txtPassword.Value) == ""
		MESSAGEBOX("Debe ingresar la clave", 0+48, Thisform.Caption)
		.txtPassword.SetFocus()
		RETURN .F.
	ENDIF
	
	lcUsuario = .txtUsuario.Value
	lcClave = .txtPassword.Value
ENDWITH

lcSql = "select idUsuario, CodUsu, Password, habilitado from usuarios where CodUsu = '" + ALLTRIM(lcUsuario) + "'"
rsUser.ActiveConnection = goConn.ActiveConnection
rsUser.Cursor_Name = "cur_User"

IF !rsUser.OpenQuery(lcSql) THEN
	MESSAGEBOX(rsUser.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_User
IF RECCOUNT("cur_User") = 0
	MESSAGEBOX("Usuario incorrecto", 0+48, Thisform.Caption)
	rsUser.close_query()
	Thisform.Contenido.txtUsuario.SetFocus()
	RETURN .F.
ELSE
	IF !cur_User.habilitado THEN
		MESSAGEBOX("Este usuario no se encuentra habilitado", 0+48, Thisform.Caption)
		rsUser.close_query()
		thisform.contenido.txtUsuario.SetFocus()
		RETURN .F.
	ENDIF

	SET EXACT ON
	
	IF ALLTRIM(Thisform.Contenido.txtPassword.Value) != ALLTRIM(cur_User.Password)
		rsUser.close_query()
		MESSAGEBOX("Clave incorrecta", 0+48, Thisform.Caption)
		RETURN .F.
	ENDIF
	
	SET EXACT OFF
ENDIF

Thisform.IsAccept = .T.
gcCodUsu = cur_User.CodUsu

rsUser.close_query()
Thisform.Hide()

RETURN .T.
ENDPROC


************************************************************
OBJETO: cls_login_vend
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_ncdev_sm
************************************************************
*** PROPIEDADES ***
DoCreate = .T.
Name = "cls_ncdev_sm"
contenido.Clsetiqueta1.Name = "Clsetiqueta1"
contenido.sel_cliente.txtCodigo.Name = "txtCodigo"
contenido.sel_cliente.txtDescripcion.Name = "txtDescripcion"
contenido.sel_cliente.Name = "sel_cliente"
contenido.btnBuscarFC.Name = "btnBuscarFC"
contenido.paginas.ErasePage = .T.
contenido.paginas.Page1.grdItems.COLUMN1.Header1.Name = "Header1"
contenido.paginas.Page1.grdItems.COLUMN1.Text1.Name = "Text1"
contenido.paginas.Page1.grdItems.COLUMN1.Name = "COLUMN1"
contenido.paginas.Page1.grdItems.COLUMN2.Header1.Name = "Header1"
contenido.paginas.Page1.grdItems.COLUMN2.Text1.Name = "Text1"
contenido.paginas.Page1.grdItems.COLUMN2.Name = "COLUMN2"
contenido.paginas.Page1.grdItems.COLUMN3.Header1.Name = "Header1"
contenido.paginas.Page1.grdItems.COLUMN3.Text1.Name = "Text1"
contenido.paginas.Page1.grdItems.COLUMN3.Name = "COLUMN3"
contenido.paginas.Page1.grdItems.COLUMN4.Header1.Name = "Header1"
contenido.paginas.Page1.grdItems.COLUMN4.Text1.Name = "Text1"
contenido.paginas.Page1.grdItems.COLUMN4.Name = "COLUMN4"
contenido.paginas.Page1.grdItems.COLUMN5.Header1.Name = "Header1"
contenido.paginas.Page1.grdItems.COLUMN5.Text1.Name = "Text1"
contenido.paginas.Page1.grdItems.COLUMN5.Name = "COLUMN5"
contenido.paginas.Page1.grdItems.COLUMN6.Header1.Name = "Header1"
contenido.paginas.Page1.grdItems.COLUMN6.Text1.Name = "Text1"
contenido.paginas.Page1.grdItems.COLUMN6.Name = "COLUMN6"
contenido.paginas.Page1.grdItems.COLUMN7.Header1.Name = "Header1"
contenido.paginas.Page1.grdItems.COLUMN7.Text1.Name = "Text1"
contenido.paginas.Page1.grdItems.COLUMN7.Name = "COLUMN7"
contenido.paginas.Page1.grdItems.COLUMN8.Header1.Name = "Header1"
contenido.paginas.Page1.grdItems.COLUMN8.Text1.Name = "Text1"
contenido.paginas.Page1.grdItems.COLUMN8.Name = "COLUMN8"
contenido.paginas.Page1.grdItems.COLUMN9.Header1.Name = "Header1"
contenido.paginas.Page1.grdItems.COLUMN9.Text1.Name = "Text1"
contenido.paginas.Page1.grdItems.COLUMN9.Name = "COLUMN9"
contenido.paginas.Page1.grdItems.COLUMN10.Header1.Name = "Header1"
contenido.paginas.Page1.grdItems.COLUMN10.Text1.Name = "Text1"
contenido.paginas.Page1.grdItems.COLUMN10.Name = "COLUMN10"
contenido.paginas.Page1.grdItems.COLUMN11.Header1.Name = "Header1"
contenido.paginas.Page1.grdItems.COLUMN11.Text1.Name = "Text1"
contenido.paginas.Page1.grdItems.COLUMN11.Name = "COLUMN11"
contenido.paginas.Page1.grdItems.COLUMN12.Header1.Name = "Header1"
contenido.paginas.Page1.grdItems.COLUMN12.Text1.Name = "Text1"
contenido.paginas.Page1.grdItems.COLUMN12.Name = "COLUMN12"
contenido.paginas.Page1.grdItems.COLUMN13.Header1.Name = "Header1"
contenido.paginas.Page1.grdItems.COLUMN13.Text1.Name = "Text1"
contenido.paginas.Page1.grdItems.COLUMN13.Name = "COLUMN13"
contenido.paginas.Page1.grdItems.COLUMN14.Header1.Name = "Header1"
contenido.paginas.Page1.grdItems.COLUMN14.Text1.Name = "Text1"
contenido.paginas.Page1.grdItems.COLUMN14.Name = "COLUMN14"
contenido.paginas.Page1.grdItems.COLUMN15.Header1.Name = "Header1"
contenido.paginas.Page1.grdItems.COLUMN15.Text1.Name = "Text1"
contenido.paginas.Page1.grdItems.COLUMN15.Name = "COLUMN15"
contenido.paginas.Page1.grdItems.COLUMN16.Header1.Name = "Header1"
contenido.paginas.Page1.grdItems.COLUMN16.Text1.Name = "Text1"
contenido.paginas.Page1.grdItems.COLUMN16.Name = "COLUMN16"
contenido.paginas.Page1.grdItems.COLUMN17.Header1.Name = "Header1"
contenido.paginas.Page1.grdItems.COLUMN17.Text1.Name = "Text1"
contenido.paginas.Page1.grdItems.COLUMN17.Name = "COLUMN17"
contenido.paginas.Page1.grdItems.COLUMN18.Header1.Name = "Header1"
contenido.paginas.Page1.grdItems.COLUMN18.Text1.Name = "Text1"
contenido.paginas.Page1.grdItems.COLUMN18.Name = "COLUMN18"
contenido.paginas.Page1.grdItems.COLUMN19.Header1.Name = "Header1"
contenido.paginas.Page1.grdItems.COLUMN19.Text1.Name = "Text1"
contenido.paginas.Page1.grdItems.COLUMN19.Name = "COLUMN19"
contenido.paginas.Page1.grdItems.COLUMN20.Header1.Name = "Header1"
contenido.paginas.Page1.grdItems.COLUMN20.Text1.Name = "Text1"
contenido.paginas.Page1.grdItems.COLUMN20.Name = "COLUMN20"
contenido.paginas.Page1.grdItems.Name = "grdItems"
contenido.paginas.Page1.grdItemNC.COLUMN1.Header1.Name = "Header1"
contenido.paginas.Page1.grdItemNC.COLUMN1.Text1.Name = "Text1"
contenido.paginas.Page1.grdItemNC.COLUMN1.Name = "COLUMN1"
contenido.paginas.Page1.grdItemNC.COLUMN2.Header1.Name = "Header1"
contenido.paginas.Page1.grdItemNC.COLUMN2.Text1.Name = "Text1"
contenido.paginas.Page1.grdItemNC.COLUMN2.Name = "COLUMN2"
contenido.paginas.Page1.grdItemNC.COLUMN3.Header1.Name = "Header1"
contenido.paginas.Page1.grdItemNC.COLUMN3.Text1.Name = "Text1"
contenido.paginas.Page1.grdItemNC.COLUMN3.Name = "COLUMN3"
contenido.paginas.Page1.grdItemNC.COLUMN4.Header1.Name = "Header1"
contenido.paginas.Page1.grdItemNC.COLUMN4.Text1.Name = "Text1"
contenido.paginas.Page1.grdItemNC.COLUMN4.Name = "COLUMN4"
contenido.paginas.Page1.grdItemNC.COLUMN5.Header1.Name = "Header1"
contenido.paginas.Page1.grdItemNC.COLUMN5.Text1.Name = "Text1"
contenido.paginas.Page1.grdItemNC.COLUMN5.Name = "COLUMN5"
contenido.paginas.Page1.grdItemNC.COLUMN6.Header1.Name = "Header1"
contenido.paginas.Page1.grdItemNC.COLUMN6.Text1.Name = "Text1"
contenido.paginas.Page1.grdItemNC.COLUMN6.Name = "COLUMN6"
contenido.paginas.Page1.grdItemNC.COLUMN7.Header1.Name = "Header1"
contenido.paginas.Page1.grdItemNC.COLUMN7.Text1.Name = "Text1"
contenido.paginas.Page1.grdItemNC.COLUMN7.Name = "COLUMN7"
contenido.paginas.Page1.grdItemNC.COLUMN8.Header1.Name = "Header1"
contenido.paginas.Page1.grdItemNC.COLUMN8.Text1.Name = "Text1"
contenido.paginas.Page1.grdItemNC.COLUMN8.Name = "COLUMN8"
contenido.paginas.Page1.grdItemNC.COLUMN9.Header1.Name = "Header1"
contenido.paginas.Page1.grdItemNC.COLUMN9.Text1.Name = "Text1"
contenido.paginas.Page1.grdItemNC.COLUMN9.Name = "COLUMN9"
contenido.paginas.Page1.grdItemNC.COLUMN10.Header1.Name = "Header1"
contenido.paginas.Page1.grdItemNC.COLUMN10.Text1.Name = "Text1"
contenido.paginas.Page1.grdItemNC.COLUMN10.Name = "COLUMN10"
contenido.paginas.Page1.grdItemNC.COLUMN11.Header1.Name = "Header1"
contenido.paginas.Page1.grdItemNC.COLUMN11.Text1.Name = "Text1"
contenido.paginas.Page1.grdItemNC.COLUMN11.Name = "COLUMN11"
contenido.paginas.Page1.grdItemNC.COLUMN12.Header1.Name = "Header1"
contenido.paginas.Page1.grdItemNC.COLUMN12.Text1.Name = "Text1"
contenido.paginas.Page1.grdItemNC.COLUMN12.Name = "COLUMN12"
contenido.paginas.Page1.grdItemNC.COLUMN13.Header1.Name = "Header1"
contenido.paginas.Page1.grdItemNC.COLUMN13.Text1.Name = "Text1"
contenido.paginas.Page1.grdItemNC.COLUMN13.Name = "COLUMN13"
contenido.paginas.Page1.grdItemNC.COLUMN14.Header1.Name = "Header1"
contenido.paginas.Page1.grdItemNC.COLUMN14.Text1.Name = "Text1"
contenido.paginas.Page1.grdItemNC.COLUMN14.Name = "COLUMN14"
contenido.paginas.Page1.grdItemNC.COLUMN15.Header1.Name = "Header1"
contenido.paginas.Page1.grdItemNC.COLUMN15.Text1.Name = "Text1"
contenido.paginas.Page1.grdItemNC.COLUMN15.Name = "COLUMN15"
contenido.paginas.Page1.grdItemNC.COLUMN16.Header1.Name = "Header1"
contenido.paginas.Page1.grdItemNC.COLUMN16.Text1.Name = "Text1"
contenido.paginas.Page1.grdItemNC.COLUMN16.Name = "COLUMN16"
contenido.paginas.Page1.grdItemNC.COLUMN17.Header1.Name = "Header1"
contenido.paginas.Page1.grdItemNC.COLUMN17.Text1.Name = "Text1"
contenido.paginas.Page1.grdItemNC.COLUMN17.Name = "COLUMN17"
contenido.paginas.Page1.grdItemNC.COLUMN18.Header1.Name = "Header1"
contenido.paginas.Page1.grdItemNC.COLUMN18.Text1.Name = "Text1"
contenido.paginas.Page1.grdItemNC.COLUMN18.Name = "COLUMN18"
contenido.paginas.Page1.grdItemNC.COLUMN19.Header1.Name = "Header1"
contenido.paginas.Page1.grdItemNC.COLUMN19.Text1.Name = "Text1"
contenido.paginas.Page1.grdItemNC.COLUMN19.Name = "COLUMN19"
contenido.paginas.Page1.grdItemNC.COLUMN20.Header1.Name = "Header1"
contenido.paginas.Page1.grdItemNC.COLUMN20.Text1.Name = "Text1"
contenido.paginas.Page1.grdItemNC.COLUMN20.Name = "COLUMN20"
contenido.paginas.Page1.grdItemNC.Name = "grdItemNC"
contenido.paginas.Page1.Clsetiqueta1.Name = "Clsetiqueta1"
contenido.paginas.Page1.Clsetiqueta2.Name = "Clsetiqueta2"
contenido.paginas.Page1.btnAceptar.Name = "btnAceptar"
contenido.paginas.Page1.btnCancelar.Name = "btnCancelar"
contenido.paginas.Page1.Name = "Page1"
contenido.paginas.Page2.Clsetiqueta1.Name = "Clsetiqueta1"
contenido.paginas.Page2.Clsetiqueta2.Name = "Clsetiqueta2"
contenido.paginas.Page2.Clsetiqueta3.Name = "Clsetiqueta3"
contenido.paginas.Page2.Clsetiqueta4.Name = "Clsetiqueta4"
contenido.paginas.Page2.Clsetiqueta5.Name = "Clsetiqueta5"
contenido.paginas.Page2.Clsetiqueta6.Name = "Clsetiqueta6"
contenido.paginas.Page2.Clsetiqueta7.Name = "Clsetiqueta7"
contenido.paginas.Page2.Clsetiqueta8.Name = "Clsetiqueta8"
contenido.paginas.Page2.Clsetiqueta9.Name = "Clsetiqueta9"
contenido.paginas.Page2.Clslinea1.Name = "Clslinea1"
contenido.paginas.Page2.CLSLINEA2.Name = "CLSLINEA2"
contenido.paginas.Page2.Clsetiqueta10.Name = "Clsetiqueta10"
contenido.paginas.Page2.Clsetiqueta11.Name = "Clsetiqueta11"
contenido.paginas.Page2.txtFCImpNeto.Name = "txtFCImpNeto"
contenido.paginas.Page2.txtFCPorDto1.Name = "txtFCPorDto1"
contenido.paginas.Page2.txtFCPorDto2.Name = "txtFCPorDto2"
contenido.paginas.Page2.txtFCPorDto3.Name = "txtFCPorDto3"
contenido.paginas.Page2.txtFCPorDto4.Name = "txtFCPorDto4"
contenido.paginas.Page2.txtFCImpFinal.Name = "txtFCImpFinal"
contenido.paginas.Page2.txtFCImpIVA21.Name = "txtFCImpIVA21"
contenido.paginas.Page2.txtFCImpIVA105.Name = "txtFCImpIVA105"
contenido.paginas.Page2.txtFCTotFact.Name = "txtFCTotFact"
contenido.paginas.Page2.txtFCImpDto1.Name = "txtFCImpDto1"
contenido.paginas.Page2.txtFCImpDto2.Name = "txtFCImpDto2"
contenido.paginas.Page2.txtFCImpDto3.Name = "txtFCImpDto3"
contenido.paginas.Page2.txtFCImpDto4.Name = "txtFCImpDto4"
contenido.paginas.Page2.txtNCImpNeto.Name = "txtNCImpNeto"
contenido.paginas.Page2.txtNCPorDto1.Name = "txtNCPorDto1"
contenido.paginas.Page2.txtNCPorDto2.Name = "txtNCPorDto2"
contenido.paginas.Page2.txtNCPorDto3.Name = "txtNCPorDto3"
contenido.paginas.Page2.txtNCPorDto4.Name = "txtNCPorDto4"
contenido.paginas.Page2.txtNCImpFinal.Name = "txtNCImpFinal"
contenido.paginas.Page2.txtNCImpIVA21.Name = "txtNCImpIVA21"
contenido.paginas.Page2.txtNCImpIVA105.Name = "txtNCImpIVA105"
contenido.paginas.Page2.txtNCTotFact.Name = "txtNCTotFact"
contenido.paginas.Page2.txtNCImpDto1.Name = "txtNCImpDto1"
contenido.paginas.Page2.txtNCImpDto2.Name = "txtNCImpDto2"
contenido.paginas.Page2.txtNCImpDto3.Name = "txtNCImpDto3"
contenido.paginas.Page2.txtNCImpDto4.Name = "txtNCImpDto4"
contenido.paginas.Page2.Clslinea3.Name = "Clslinea3"
contenido.paginas.Page2.Clslinea4.Name = "Clslinea4"
contenido.paginas.Page2.Clsetiqueta12.Name = "Clsetiqueta12"
contenido.paginas.Page2.txtFCPorIIBB.Name = "txtFCPorIIBB"
contenido.paginas.Page2.txtFCimpIIBB.Name = "txtFCimpIIBB"
contenido.paginas.Page2.txtNCPorIIBB.Name = "txtNCPorIIBB"
contenido.paginas.Page2.txtNCImpIIBB.Name = "txtNCImpIIBB"
contenido.paginas.Page2.txtNCporRec.Name = "txtNCporRec"
contenido.paginas.Page2.txtNCimpRec.Name = "txtNCimpRec"
contenido.paginas.Page2.txtFCporRec.Name = "txtFCporRec"
contenido.paginas.Page2.txtFCimpRec.Name = "txtFCimpRec"
contenido.paginas.Page2.Clsetiqueta13.Name = "Clsetiqueta13"
contenido.paginas.Page2.Name = "Page2"
contenido.paginas.Name = "paginas"
contenido.btnCerrar.Name = "btnCerrar"
contenido.btnGrabar.Name = "btnGrabar"
contenido.btnNuevo.Name = "btnNuevo"
contenido.Clsetiqueta2.Name = "Clsetiqueta2"
contenido.txtcbte.Name = "txtcbte"
contenido.txttipo.Name = "txttipo"
contenido.txtnrocbte.Name = "txtnrocbte"
contenido.Name = "contenido"
datos_cbtes.Name = "datos_cbtes"

*** METODOS ***
PROCEDURE contenido.btnGrabar.Click
LOCAL loFormUser
LOCAL lcCurrentUser

lcCurrentUser = gcCodUsu

loFormUser = CREATEOBJECT("cls_login_vend")
loFormUser.show(1)

IF !loFormUser.IsAccept
	loFormUser.release()
	RETURN .F.
ENDIF

DODEFAULT()
gcCodUsu = lcCurrentUser

RETURN .T.
ENDPROC


************************************************************
OBJETO: cls_ncdev_sm
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: clsformcbte_sm
************************************************************
*** PROPIEDADES ***
DoCreate = .T.
codusu = 
Name = "clsformcbte_sm"
contenido.Clsetiqueta1.Name = "Clsetiqueta1"
contenido.SEL_CLIENTE.TXTCODIGO.Name = "TXTCODIGO"
contenido.SEL_CLIENTE.TXTDESCRIPCION.Name = "TXTDESCRIPCION"
contenido.SEL_CLIENTE.Name = "SEL_CLIENTE"
contenido.Clsetiqueta2.Name = "Clsetiqueta2"
contenido.Clsetiqueta3.Name = "Clsetiqueta3"
contenido.TXTSITIVA.Name = "TXTSITIVA"
contenido.SEL_FORMAPAGO.TXTCODIGO.Name = "TXTCODIGO"
contenido.SEL_FORMAPAGO.TXTDESCRIPCION.Name = "TXTDESCRIPCION"
contenido.SEL_FORMAPAGO.Name = "SEL_FORMAPAGO"
contenido.CLSLINEA1.Name = "CLSLINEA1"
contenido.Clsetiqueta4.Name = "Clsetiqueta4"
contenido.SEL_ARTICULO.TXTCODIGO.Name = "TXTCODIGO"
contenido.SEL_ARTICULO.TXTDESCRIPCION.Name = "TXTDESCRIPCION"
contenido.SEL_ARTICULO.Name = "SEL_ARTICULO"
contenido.Clsetiqueta5.Name = "Clsetiqueta5"
contenido.TXTCANTIDAD.Name = "TXTCANTIDAD"
contenido.btnAgregar.Name = "btnAgregar"
contenido.GRDDETALLES.COLUMN1.Header1.Name = "Header1"
contenido.GRDDETALLES.COLUMN1.Text1.Name = "Text1"
contenido.GRDDETALLES.COLUMN1.Name = "COLUMN1"
contenido.GRDDETALLES.COLUMN2.Header1.Name = "Header1"
contenido.GRDDETALLES.COLUMN2.Text1.Name = "Text1"
contenido.GRDDETALLES.COLUMN2.Name = "COLUMN2"
contenido.GRDDETALLES.COLUMN3.Header1.Name = "Header1"
contenido.GRDDETALLES.COLUMN3.Text1.Name = "Text1"
contenido.GRDDETALLES.COLUMN3.Name = "COLUMN3"
contenido.GRDDETALLES.COLUMN4.Header1.Name = "Header1"
contenido.GRDDETALLES.COLUMN4.Text1.Name = "Text1"
contenido.GRDDETALLES.COLUMN4.Name = "COLUMN4"
contenido.GRDDETALLES.COLUMN5.Header1.Name = "Header1"
contenido.GRDDETALLES.COLUMN5.Text1.Name = "Text1"
contenido.GRDDETALLES.COLUMN5.Name = "COLUMN5"
contenido.GRDDETALLES.COLUMN6.Header1.Name = "Header1"
contenido.GRDDETALLES.COLUMN6.Text1.Name = "Text1"
contenido.GRDDETALLES.COLUMN6.Name = "COLUMN6"
contenido.GRDDETALLES.COLUMN7.Header1.Name = "Header1"
contenido.GRDDETALLES.COLUMN7.Text1.Name = "Text1"
contenido.GRDDETALLES.COLUMN7.Name = "COLUMN7"
contenido.GRDDETALLES.COLUMN8.Header1.Name = "Header1"
contenido.GRDDETALLES.COLUMN8.Text1.Name = "Text1"
contenido.GRDDETALLES.COLUMN8.Name = "COLUMN8"
contenido.GRDDETALLES.COLUMN9.Header1.Name = "Header1"
contenido.GRDDETALLES.COLUMN9.Text1.Name = "Text1"
contenido.GRDDETALLES.COLUMN9.Name = "COLUMN9"
contenido.GRDDETALLES.COLUMN10.Header1.Name = "Header1"
contenido.GRDDETALLES.COLUMN10.Text1.Name = "Text1"
contenido.GRDDETALLES.COLUMN10.Name = "COLUMN10"
contenido.GRDDETALLES.COLUMN11.Header1.Name = "Header1"
contenido.GRDDETALLES.COLUMN11.Text1.Name = "Text1"
contenido.GRDDETALLES.COLUMN11.Name = "COLUMN11"
contenido.GRDDETALLES.COLUMN12.Header1.Name = "Header1"
contenido.GRDDETALLES.COLUMN12.Text1.Name = "Text1"
contenido.GRDDETALLES.COLUMN12.Name = "COLUMN12"
contenido.GRDDETALLES.COLUMN13.Header1.Name = "Header1"
contenido.GRDDETALLES.COLUMN13.Text1.Name = "Text1"
contenido.GRDDETALLES.COLUMN13.Name = "COLUMN13"
contenido.GRDDETALLES.COLUMN14.Header1.Name = "Header1"
contenido.GRDDETALLES.COLUMN14.Text1.Name = "Text1"
contenido.GRDDETALLES.COLUMN14.Name = "COLUMN14"
contenido.GRDDETALLES.COLUMN15.Header1.Name = "Header1"
contenido.GRDDETALLES.COLUMN15.Text1.Name = "Text1"
contenido.GRDDETALLES.COLUMN15.Name = "COLUMN15"
contenido.GRDDETALLES.COLUMN16.Header1.Name = "Header1"
contenido.GRDDETALLES.COLUMN16.Text1.Name = "Text1"
contenido.GRDDETALLES.COLUMN16.Name = "COLUMN16"
contenido.GRDDETALLES.COLUMN17.Header1.Name = "Header1"
contenido.GRDDETALLES.COLUMN17.Text1.Name = "Text1"
contenido.GRDDETALLES.COLUMN17.Name = "COLUMN17"
contenido.GRDDETALLES.COLUMN18.Header1.Name = "Header1"
contenido.GRDDETALLES.COLUMN18.Text1.Name = "Text1"
contenido.GRDDETALLES.COLUMN18.Name = "COLUMN18"
contenido.GRDDETALLES.COLUMN19.Header1.Name = "Header1"
contenido.GRDDETALLES.COLUMN19.Text1.Name = "Text1"
contenido.GRDDETALLES.COLUMN19.Name = "COLUMN19"
contenido.GRDDETALLES.COLUMN20.Header1.Name = "Header1"
contenido.GRDDETALLES.COLUMN20.Text1.Name = "Text1"
contenido.GRDDETALLES.COLUMN20.Name = "COLUMN20"
contenido.GRDDETALLES.Name = "GRDDETALLES"
contenido.BTNGRABAR.Name = "BTNGRABAR"
contenido.BTNCANCELAR.Name = "BTNCANCELAR"
contenido.Clscerrar1.Name = "Clscerrar1"
contenido.Clsetiqueta10.Name = "Clsetiqueta10"
contenido.TXTPRMAY.Name = "TXTPRMAY"
contenido.Clsetiqueta11.Name = "Clsetiqueta11"
contenido.TXTPRMINORISTA.Name = "TXTPRMINORISTA"
contenido.Clsetiqueta12.Name = "Clsetiqueta12"
contenido.txtAlicIVA.Name = "txtAlicIVA"
contenido.CHKCALCIVA.Alignment = 0
contenido.CHKCALCIVA.Name = "CHKCALCIVA"
contenido.BTNELIMINAR.Name = "BTNELIMINAR"
contenido.CHKIMPRIMEDUP.Alignment = 0
contenido.CHKIMPRIMEDUP.Name = "CHKIMPRIMEDUP"
contenido.BTNCBTEORIGEN.Name = "BTNCBTEORIGEN"
contenido.TXTOBSERV.Name = "TXTOBSERV"
contenido.Clsetiqueta6.Name = "Clsetiqueta6"
contenido.Clsetiqueta7.Name = "Clsetiqueta7"
contenido.Clsetiqueta8.Name = "Clsetiqueta8"
contenido.Clsetiqueta9.Name = "Clsetiqueta9"
contenido.TXTTOTNETO.Name = "TXTTOTNETO"
contenido.TXTPORIVA21.Name = "TXTPORIVA21"
contenido.TXTPORIVA105.Name = "TXTPORIVA105"
contenido.TXTIMPIVA21.Name = "TXTIMPIVA21"
contenido.TXTIMPIVA105.Name = "TXTIMPIVA105"
contenido.TXTTOTAL.Name = "TXTTOTAL"
contenido.CLSETIQUETA14.Name = "CLSETIQUETA14"
contenido.TXTDESC1.Name = "TXTDESC1"
contenido.TXTDESC2.Name = "TXTDESC2"
contenido.TXTDESC3.Name = "TXTDESC3"
contenido.TXTDESC4.Name = "TXTDESC4"
contenido.TXTIMPDESC1.Name = "TXTIMPDESC1"
contenido.TXTIMPDESC2.Name = "TXTIMPDESC2"
contenido.TXTIMPDESC3.Name = "TXTIMPDESC3"
contenido.TXTIMPDESC4.Name = "TXTIMPDESC4"
contenido.CLSETIQUETA15.Name = "CLSETIQUETA15"
contenido.CLSETIQUETA16.Name = "CLSETIQUETA16"
contenido.CLSETIQUETA17.Name = "CLSETIQUETA17"
contenido.TXTTOTFACT.Name = "TXTTOTFACT"
contenido.CLSETIQUETA18.Name = "CLSETIQUETA18"
contenido.TXTPORIIBB.Name = "TXTPORIIBB"
contenido.TXTIMPIIBB.Name = "TXTIMPIIBB"
contenido.CLSETIQUETA19.Name = "CLSETIQUETA19"
contenido.TXTST.Name = "TXTST"
contenido.CLSETIQUETA20.Name = "CLSETIQUETA20"
contenido.TXTPORDESC1.ReadOnly = .F.
contenido.TXTPORDESC1.Name = "TXTPORDESC1"
contenido.TXTIMPDESCITEM1.Name = "TXTIMPDESCITEM1"
contenido.TXTPORDESC2.ReadOnly = .F.
contenido.TXTPORDESC2.Name = "TXTPORDESC2"
contenido.TXTIMPDESCITEM2.Name = "TXTIMPDESCITEM2"
contenido.TXTPORDESC3.ReadOnly = .F.
contenido.TXTPORDESC3.Name = "TXTPORDESC3"
contenido.TXTIMPDESCITEM3.Name = "TXTIMPDESCITEM3"
contenido.TXTPORDESC4.ReadOnly = .F.
contenido.TXTPORDESC4.Name = "TXTPORDESC4"
contenido.TXTIMPDESCITEM4.Name = "TXTIMPDESCITEM4"
contenido.CLSETIQUETA21.Name = "CLSETIQUETA21"
contenido.TXTIMPIVA.Name = "TXTIMPIVA"
contenido.CLSETIQUETA22.Name = "CLSETIQUETA22"
contenido.TXTSTNETO.Name = "TXTSTNETO"
contenido.Clsetiqueta13.Name = "Clsetiqueta13"
contenido.TXTSUBTOTAL.Name = "TXTSUBTOTAL"
contenido.CLSETIQUETA23.Name = "CLSETIQUETA23"
contenido.TXTPRNETO.Name = "TXTPRNETO"
contenido.LBLEXISTENCIA.Name = "LBLEXISTENCIA"
contenido.txtExistencia.Name = "txtExistencia"
contenido.CLSETIQUETA24.Name = "CLSETIQUETA24"
contenido.TXTPORREC.Name = "TXTPORREC"
contenido.TXTIMPREC.Name = "TXTIMPREC"
contenido.TXTRECITEM.Name = "TXTRECITEM"
contenido.CLSETIQUETA25.Name = "CLSETIQUETA25"
contenido.TXTTELEFONO.Name = "TXTTELEFONO"
contenido.CLSETIQUETA26.Name = "CLSETIQUETA26"
contenido.TXTCUIT.Name = "TXTCUIT"
contenido.Clsetiqueta27.Name = "Clsetiqueta27"
contenido.cboUnidVta.Name = "cboUnidVta"
contenido.txtCantPack.Name = "txtCantPack"
contenido.Name = "contenido"
mov_stock.Name = "mov_stock"

*** METODOS ***
PROCEDURE imprimir
LOCAL loRes, lcSql, m.vendedor

m.vendedor = ""
lcSql = ""
loRes = CREATEOBJECT("odbc_result")

lcSql = "select * from usuarios where codUsu = '" + ALLTRIM(this.codusu) + "'"
loRes.ActiveConnection = goConn.ActiveConnection
loRes.cursor_name = "cur_x"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

thisform.nombre_usuario = ALLTRIM(cur_x.ApelNom)

loRes.Close_Query()

DODEFAULT()

RETURN .T.
ENDPROC
PROCEDURE contenido.BTNGRABAR.Click
LOCAL loFormUser
LOCAL lcCurrentUser

lcCurrentUser = gcCodUsu

loFormUser = CREATEOBJECT("cls_login_vend")
loFormUser.show(1)

IF !loFormUser.IsAccept
	loFormUser.release()
	RETURN .F.
ENDIF

thisform.codusu = gcCodUsu
DODEFAULT()
gcCodUsu = lcCurrentUser

RETURN .T.
ENDPROC


************************************************************
OBJETO: clsformcbte_sm
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 9, 6, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: clsformcbte_pto
************************************************************
*** PROPIEDADES ***
DoCreate = .T.
cbte = PTO
Name = "clsformcbte_pto"
contenido.Clsetiqueta1.Name = "Clsetiqueta1"
contenido.sel_cliente.txtCodigo.Name = "txtCodigo"
contenido.sel_cliente.txtDescripcion.Name = "txtDescripcion"
contenido.sel_cliente.Name = "sel_cliente"
contenido.Clsetiqueta2.Name = "Clsetiqueta2"
contenido.Clsetiqueta3.Name = "Clsetiqueta3"
contenido.txtSitIVA.Name = "txtSitIVA"
contenido.sel_FormaPago.txtCodigo.Name = "txtCodigo"
contenido.sel_FormaPago.txtDescripcion.Name = "txtDescripcion"
contenido.sel_FormaPago.Name = "sel_FormaPago"
contenido.Clslinea1.Name = "Clslinea1"
contenido.Clsetiqueta4.Name = "Clsetiqueta4"
contenido.sel_Articulo.txtCodigo.Name = "txtCodigo"
contenido.sel_Articulo.txtDescripcion.Name = "txtDescripcion"
contenido.sel_Articulo.Name = "sel_Articulo"
contenido.Clsetiqueta5.Name = "Clsetiqueta5"
contenido.txtCantidad.Name = "txtCantidad"
contenido.btnAgregar.Name = "btnAgregar"
contenido.grdDetalles.COLUMN1.Header1.Name = "Header1"
contenido.grdDetalles.COLUMN1.Text1.Name = "Text1"
contenido.grdDetalles.COLUMN1.Name = "COLUMN1"
contenido.grdDetalles.COLUMN2.Header1.Name = "Header1"
contenido.grdDetalles.COLUMN2.Text1.Name = "Text1"
contenido.grdDetalles.COLUMN2.Name = "COLUMN2"
contenido.grdDetalles.COLUMN3.Header1.Name = "Header1"
contenido.grdDetalles.COLUMN3.Text1.Name = "Text1"
contenido.grdDetalles.COLUMN3.Name = "COLUMN3"
contenido.grdDetalles.COLUMN4.Header1.Name = "Header1"
contenido.grdDetalles.COLUMN4.Text1.Name = "Text1"
contenido.grdDetalles.COLUMN4.Name = "COLUMN4"
contenido.grdDetalles.COLUMN5.Header1.Name = "Header1"
contenido.grdDetalles.COLUMN5.Text1.Name = "Text1"
contenido.grdDetalles.COLUMN5.Name = "COLUMN5"
contenido.grdDetalles.COLUMN6.Header1.Name = "Header1"
contenido.grdDetalles.COLUMN6.Text1.Name = "Text1"
contenido.grdDetalles.COLUMN6.Name = "COLUMN6"
contenido.grdDetalles.COLUMN7.Header1.Name = "Header1"
contenido.grdDetalles.COLUMN7.Text1.Name = "Text1"
contenido.grdDetalles.COLUMN7.Name = "COLUMN7"
contenido.grdDetalles.COLUMN8.Header1.Name = "Header1"
contenido.grdDetalles.COLUMN8.Text1.Name = "Text1"
contenido.grdDetalles.COLUMN8.Name = "COLUMN8"
contenido.grdDetalles.COLUMN9.Header1.Name = "Header1"
contenido.grdDetalles.COLUMN9.Text1.Name = "Text1"
contenido.grdDetalles.COLUMN9.Name = "COLUMN9"
contenido.grdDetalles.COLUMN10.Header1.Name = "Header1"
contenido.grdDetalles.COLUMN10.Text1.Name = "Text1"
contenido.grdDetalles.COLUMN10.Name = "COLUMN10"
contenido.grdDetalles.COLUMN11.Header1.Name = "Header1"
contenido.grdDetalles.COLUMN11.Text1.Name = "Text1"
contenido.grdDetalles.COLUMN11.Name = "COLUMN11"
contenido.grdDetalles.COLUMN12.Header1.Name = "Header1"
contenido.grdDetalles.COLUMN12.Text1.Name = "Text1"
contenido.grdDetalles.COLUMN12.Name = "COLUMN12"
contenido.grdDetalles.COLUMN13.Header1.Name = "Header1"
contenido.grdDetalles.COLUMN13.Text1.Name = "Text1"
contenido.grdDetalles.COLUMN13.Name = "COLUMN13"
contenido.grdDetalles.COLUMN14.Header1.Name = "Header1"
contenido.grdDetalles.COLUMN14.Text1.Name = "Text1"
contenido.grdDetalles.COLUMN14.Name = "COLUMN14"
contenido.grdDetalles.COLUMN15.Header1.Name = "Header1"
contenido.grdDetalles.COLUMN15.Text1.Name = "Text1"
contenido.grdDetalles.COLUMN15.Name = "COLUMN15"
contenido.grdDetalles.COLUMN16.Header1.Name = "Header1"
contenido.grdDetalles.COLUMN16.Text1.Name = "Text1"
contenido.grdDetalles.COLUMN16.Name = "COLUMN16"
contenido.grdDetalles.COLUMN17.Header1.Name = "Header1"
contenido.grdDetalles.COLUMN17.Text1.Name = "Text1"
contenido.grdDetalles.COLUMN17.Name = "COLUMN17"
contenido.grdDetalles.COLUMN18.Header1.Name = "Header1"
contenido.grdDetalles.COLUMN18.Text1.Name = "Text1"
contenido.grdDetalles.COLUMN18.Name = "COLUMN18"
contenido.grdDetalles.COLUMN19.Header1.Name = "Header1"
contenido.grdDetalles.COLUMN19.Text1.Name = "Text1"
contenido.grdDetalles.COLUMN19.Name = "COLUMN19"
contenido.grdDetalles.COLUMN20.Header1.Name = "Header1"
contenido.grdDetalles.COLUMN20.Text1.Name = "Text1"
contenido.grdDetalles.COLUMN20.Name = "COLUMN20"
contenido.grdDetalles.Name = "grdDetalles"
contenido.btnGrabar.Name = "btnGrabar"
contenido.btnCancelar.Name = "btnCancelar"
contenido.Clscerrar1.Name = "Clscerrar1"
contenido.Clsetiqueta10.Name = "Clsetiqueta10"
contenido.txtPrMay.Name = "txtPrMay"
contenido.Clsetiqueta11.Name = "Clsetiqueta11"
contenido.txtPrMinorista.Name = "txtPrMinorista"
contenido.Clsetiqueta12.Name = "Clsetiqueta12"
contenido.txtAlicIVA.Name = "txtAlicIVA"
contenido.chkCalcIVA.Alignment = 0
contenido.chkCalcIVA.Name = "chkCalcIVA"
contenido.btnEliminar.Name = "btnEliminar"
contenido.chkImprimeDup.Alignment = 0
contenido.chkImprimeDup.Name = "chkImprimeDup"
contenido.btnCbteOrigen.Name = "btnCbteOrigen"
contenido.txtObserv.Name = "txtObserv"
contenido.Clsetiqueta6.Name = "Clsetiqueta6"
contenido.Clsetiqueta7.Name = "Clsetiqueta7"
contenido.Clsetiqueta8.Name = "Clsetiqueta8"
contenido.Clsetiqueta9.Name = "Clsetiqueta9"
contenido.txtTotNeto.Name = "txtTotNeto"
contenido.txtPorIVA21.Name = "txtPorIVA21"
contenido.txtPorIVA105.Name = "txtPorIVA105"
contenido.txtImpIVA21.Name = "txtImpIVA21"
contenido.txtImpIVA105.Name = "txtImpIVA105"
contenido.txtTotal.Name = "txtTotal"
contenido.Clsetiqueta14.Name = "Clsetiqueta14"
contenido.txtDesc1.Name = "txtDesc1"
contenido.txtDesc2.Name = "txtDesc2"
contenido.txtDesc3.Name = "txtDesc3"
contenido.txtDesc4.Name = "txtDesc4"
contenido.txtImpDesc1.Name = "txtImpDesc1"
contenido.txtImpDesc2.Name = "txtImpDesc2"
contenido.txtImpDesc3.Name = "txtImpDesc3"
contenido.txtImpDesc4.Name = "txtImpDesc4"
contenido.Clsetiqueta15.Name = "Clsetiqueta15"
contenido.Clsetiqueta16.Name = "Clsetiqueta16"
contenido.Clsetiqueta17.Name = "Clsetiqueta17"
contenido.txtTotFact.Name = "txtTotFact"
contenido.Clsetiqueta18.Name = "Clsetiqueta18"
contenido.txtPorIIBB.Name = "txtPorIIBB"
contenido.txtImpIIBB.Name = "txtImpIIBB"
contenido.Clsetiqueta19.Name = "Clsetiqueta19"
contenido.txtST.Name = "txtST"
contenido.Clsetiqueta20.Name = "Clsetiqueta20"
contenido.txtPorDesc1.Name = "txtPorDesc1"
contenido.txtImpDescItem1.Name = "txtImpDescItem1"
contenido.txtPorDesc2.Name = "txtPorDesc2"
contenido.txtImpDescItem2.Name = "txtImpDescItem2"
contenido.txtPorDesc3.Name = "txtPorDesc3"
contenido.txtImpDescItem3.Name = "txtImpDescItem3"
contenido.txtPorDesc4.Name = "txtPorDesc4"
contenido.txtImpDescItem4.Name = "txtImpDescItem4"
contenido.Clsetiqueta21.Name = "Clsetiqueta21"
contenido.txtImpIVA.Name = "txtImpIVA"
contenido.Clsetiqueta22.Name = "Clsetiqueta22"
contenido.txtSTNeto.Name = "txtSTNeto"
contenido.Clsetiqueta13.Name = "Clsetiqueta13"
contenido.txtSubTotal.Name = "txtSubTotal"
contenido.Clsetiqueta23.Name = "Clsetiqueta23"
contenido.txtPrNeto.Name = "txtPrNeto"
contenido.lblExistencia.Name = "lblExistencia"
contenido.txtExistencia.Name = "txtExistencia"
contenido.Clsetiqueta24.Name = "Clsetiqueta24"
contenido.txtPorRec.Name = "txtPorRec"
contenido.txtImpRec.Name = "txtImpRec"
contenido.txtRecItem.Name = "txtRecItem"
contenido.Clsetiqueta25.Name = "Clsetiqueta25"
contenido.txtTelefono.Name = "txtTelefono"
contenido.Clsetiqueta26.Name = "Clsetiqueta26"
contenido.txtcuit.Name = "txtcuit"
contenido.Clsetiqueta27.Name = "Clsetiqueta27"
contenido.cboUnidVta.Name = "cboUnidVta"
contenido.txtCantPack.Name = "txtCantPack"
contenido.BackColor = 218,218,216
contenido.Name = "contenido"
mov_stock.Name = "mov_stock"

*** METODOS ***
PROCEDURE imprimir
LOCAL loRes, lcSql, m.vendedor

m.vendedor = ""
lcSql = ""
loRes = CREATEOBJECT("odbc_result")

lcSql = "select * from usuarios where codUsu = '" + ALLTRIM(this.codusu) + "'"
loRes.ActiveConnection = goConn.ActiveConnection
loRes.cursor_name = "cur_x"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

thisform.nombre_usuario = ALLTRIM(cur_x.ApelNom)

loRes.Close_Query()

DODEFAULT()

RETURN .T.
ENDPROC


************************************************************
OBJETO: clsformcbte_pto
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 9, 6, 15, 12, 32, 3, 0

*** METODOS ***


