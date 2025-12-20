************************************************************
OBJETO: cls_retiros_pendi
************************************************************
*** PROPIEDADES ***
DataSession = 1
Height = 216
Width = 904
DoCreate = .T.
BorderStyle = 2
Caption = "Retiros pendientes de facturar"
idcliente = 0
Name = "cls_retiros_pendi"

*** METODOS ***
PROCEDURE leer_retiros_pendi
this.retiros.crear_cursor()
this.retiros.leer_pendfc(this.idcliente)

SELECT cur_Retiros
thisform.grdPendiFact.RecordSource = "cur_Retiros"
thisform.grdPendiFact.alias_name = "cur_Retiros"
thisform.grdPendiFact.list_controlsource = "codArt,descripcio,cantidad,fecRetiro,prVenta,nombre,nom_retiro"
thisform.grdPendiFact.lista_ancho_cols = "100,250,70,70,70,150,150"
thisform.grdPendiFact.titulos_cabeceras = "Código,Descripción,Cantidad,Fecha,Prec.S/IVA,vendedor,Retiró"
thisform.grdPendiFact.generar_grid()

SELECT cur_Retiros
GO TOP
thisform.grdPendiFact.Refresh()
ENDPROC
PROCEDURE Init
DODEFAULT()


ENDPROC


************************************************************
OBJETO: grdPendiFact
************************************************************
*** PROPIEDADES ***
Anchor = 75
Height = 173
Left = 0
Top = 0
Width = 901
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdPendiFact"
COLUMN1.HEADER1.Name = "HEADER1"
COLUMN1.TEXT1.Name = "TEXT1"
COLUMN1.Name = "COLUMN1"
COLUMN2.HEADER1.Name = "HEADER1"
COLUMN2.TEXT1.Name = "TEXT1"
COLUMN2.Name = "COLUMN2"
COLUMN3.HEADER1.Name = "HEADER1"
COLUMN3.TEXT1.Name = "TEXT1"
COLUMN3.Name = "COLUMN3"
COLUMN4.HEADER1.Name = "HEADER1"
COLUMN4.TEXT1.Name = "TEXT1"
COLUMN4.Name = "COLUMN4"
COLUMN5.HEADER1.Name = "HEADER1"
COLUMN5.TEXT1.Name = "TEXT1"
COLUMN5.Name = "COLUMN5"
COLUMN6.HEADER1.Name = "HEADER1"
COLUMN6.TEXT1.Name = "TEXT1"
COLUMN6.Name = "COLUMN6"
COLUMN7.HEADER1.Name = "HEADER1"
COLUMN7.TEXT1.Name = "TEXT1"
COLUMN7.Name = "COLUMN7"
COLUMN8.HEADER1.Name = "HEADER1"
COLUMN8.TEXT1.Name = "TEXT1"
COLUMN8.Name = "COLUMN8"
COLUMN9.HEADER1.Name = "HEADER1"
COLUMN9.TEXT1.Name = "TEXT1"
COLUMN9.Name = "COLUMN9"
COLUMN10.HEADER1.Name = "HEADER1"
COLUMN10.TEXT1.Name = "TEXT1"
COLUMN10.Name = "COLUMN10"
COLUMN11.HEADER1.Name = "HEADER1"
COLUMN11.TEXT1.Name = "TEXT1"
COLUMN11.Name = "COLUMN11"
COLUMN12.HEADER1.Name = "HEADER1"
COLUMN12.TEXT1.Name = "TEXT1"
COLUMN12.Name = "COLUMN12"
COLUMN13.HEADER1.Name = "HEADER1"
COLUMN13.TEXT1.Name = "TEXT1"
COLUMN13.Name = "COLUMN13"
COLUMN14.HEADER1.Name = "HEADER1"
COLUMN14.TEXT1.Name = "TEXT1"
COLUMN14.Name = "COLUMN14"
COLUMN15.HEADER1.Name = "HEADER1"
COLUMN15.TEXT1.Name = "TEXT1"
COLUMN15.Name = "COLUMN15"
COLUMN16.HEADER1.Name = "HEADER1"
COLUMN16.TEXT1.Name = "TEXT1"
COLUMN16.Name = "COLUMN16"
COLUMN17.HEADER1.Name = "HEADER1"
COLUMN17.TEXT1.Name = "TEXT1"
COLUMN17.Name = "COLUMN17"
COLUMN18.HEADER1.Name = "HEADER1"
COLUMN18.TEXT1.Name = "TEXT1"
COLUMN18.Name = "COLUMN18"
COLUMN19.HEADER1.Name = "HEADER1"
COLUMN19.TEXT1.Name = "TEXT1"
COLUMN19.Name = "COLUMN19"
COLUMN20.HEADER1.Name = "HEADER1"
COLUMN20.TEXT1.Name = "TEXT1"
COLUMN20.Name = "COLUMN20"

*** METODOS ***


************************************************************
OBJETO: CLSCERRAR1
************************************************************
*** PROPIEDADES ***
Top = 175
Left = 855
Height = 38
Width = 45
Cancel = .T.
Name = "CLSCERRAR1"

*** METODOS ***


************************************************************
OBJETO: retiros
************************************************************
*** PROPIEDADES ***
Top = 192
Left = 132
Name = "retiros"

*** METODOS ***


************************************************************
OBJETO: cls_retiros_pendi
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_retiros_a_eliminar
************************************************************
*** PROPIEDADES ***
DataSession = 1
BorderStyle = 1
Height = 477
Width = 885
DoCreate = .T.
Caption = "Retiros a eliminar"
presiono_aceptar = .F.
Name = "cls_retiros_a_eliminar"

*** METODOS ***
PROCEDURE Init
DODEFAULT()

SELECT cur_DelRet
Thisform.grdRegEliminar.alias_name = "cur_DelRet"
Thisform.grdRegEliminar.RecordSource = "cur_DelRet"
Thisform.grdRegEliminar.list_controlsource = "codArt,descripcio,cantidad"
Thisform.grdRegEliminar.lista_ancho_cols = "100,250,70"
Thisform.grdRegEliminar.titulos_cabeceras = "Código,Descripción,Cantidad"
Thisform.grdRegEliminar.generar_grid()

SELECT cur_DelRet
GO TOP


ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
FontSize = 10
Caption = "ATENCION: Los los siguientes artículos van a ser eliminados, ¿está seguro que desea continuar con la grabación?"
Height = 18
Left = 12
Top = 12
Width = 744
ForeColor = 255,0,0
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: grdRegEliminar
************************************************************
*** PROPIEDADES ***
Height = 344
Left = 12
Top = 60
Width = 864
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdRegEliminar"
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
OBJETO: CLSPICTURE1
************************************************************
*** PROPIEDADES ***
Picture = ..\imagen\symbol-help.ico
Height = 46
Left = 756
Top = 0
Width = 49
Name = "CLSPICTURE1"

*** METODOS ***


************************************************************
OBJETO: btnAceptar
************************************************************
*** PROPIEDADES ***
Top = 414
Left = 432
ToolTipText = "Si"
Name = "btnAceptar"

*** METODOS ***
PROCEDURE Click
Thisform.presiono_aceptar = .T.
Thisform.Hide()
ENDPROC


************************************************************
OBJETO: btnCancelar
************************************************************
*** PROPIEDADES ***
Top = 414
Left = 480
ToolTipText = "No"
Name = "btnCancelar"

*** METODOS ***
PROCEDURE Click
Thisform.presiono_aceptar = .F.
Thisform.Hide()
ENDPROC


************************************************************
OBJETO: cls_retiros_a_eliminar
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_form_devret
************************************************************
*** PROPIEDADES ***
BorderStyle = 2
Height = 534
Width = 980
DoCreate = .T.
Caption = "Devoluciones de Retiros"
Name = "cls_form_devret"
CONTENIDO.Top = -1
CONTENIDO.Left = -1
CONTENIDO.Width = 982
CONTENIDO.Height = 536
CONTENIDO.Name = "CONTENIDO"

*** METODOS ***
PROCEDURE Load
DODEFAULT()

thisform.retiros.crear_cursor()

SELECT cur_Retiros
INDEX ON nom_retiro TAG nom_retiro ASCENDING
INDEX ON idVendedor TAG idVendedor ASCENDING ADDITIVE
INDEX ON nombre TAG nombre ASCENDING ADDITIVE
INDEX ON fecRetiro TAG fecRetiro ASCENDING ADDITIVE
INDEX ON cantidad TAG cantidad ASCENDING ADDITIVE
INDEX ON cantDev TAG cantDev ASCENDING ADDITIVE
INDEX ON descripcio TAG descripcio ASCENDING ADDITIVE
INDEX ON codArt TAG codArt ASCENDING ADDITIVE

ENDPROC
PROCEDURE Init
DODEFAULT()

SELECT cur_retiros
thisform.contenido.grdRetiros.alias_name = "cur_retiros"
thisform.contenido.grdRetiros.RecordSource = "cur_retiros"
thisform.contenido.grdRetiros.list_controlsource = "fecRetiro,codArt,descripcio,cantidad,cantDev,idVendedor,nombre,nom_retiro"
thisform.contenido.grdRetiros.lista_ancho_cols = "100,100,200,70,70,70,200,100"
thisform.contenido.grdRetiros.titulos_cabeceras = "Fecha,Código,Descripción,Cantidad,Devuelve,Cód. Vend.,Nombre,Retiró"
thisform.contenido.grdRetiros.generar_grid()
thisform.contenido.grdRetiros.Columns[5].ReadOnly = .F.

SELECT cur_devret
thisform.contenido.grdDevoluciones.alias_name = "cur_devret"
thisform.contenido.grdDevoluciones.RecordSource = "cur_devret"
thisform.contenido.grdDevoluciones.list_controlsource = "codArt,descripcio,cantidad"
thisform.contenido.grdDevoluciones.lista_ancho_cols = "100,300,70"
thisform.contenido.grdDevoluciones.titulos_cabeceras = "Código,Descripción,Cantidad"
thisform.contenido.grdDevoluciones.generar_grid()

thisform.contenido.btnBuscar.Enabled = .T.
thisform.contenido.sel_Cliente.Enabled = .T.
thisform.contenido.btnAceptar.Enabled = .F.
thisform.contenido.btnCancelar.Enabled = .F.
thisform.contenido.btnGrabar.Enabled = .F.


ENDPROC


************************************************************
OBJETO: retiros
************************************************************
*** PROPIEDADES ***
Top = 504
Left = 744
Height = 17
Width = 48
Name = "retiros"

*** METODOS ***


************************************************************
OBJETO: CLSETIQUETA1
************************************************************
*** PROPIEDADES ***
Caption = "Cliente:"
Height = 15
Left = 17
Top = 17
Width = 60
TabIndex = 7
Name = "CLSETIQUETA1"

*** METODOS ***


************************************************************
OBJETO: sel_cliente
************************************************************
*** PROPIEDADES ***
Top = 11
Left = 87
TabIndex = 1
autocompletar_ceros = .F.
nombre_tabla = clientes
nombre_campo_codigo = idCliente
nombre_campo_desc = razSoc
pkfield = idCliente
esnumerico = .T.
Name = "sel_cliente"
TXTCODIGO.Name = "TXTCODIGO"
TXTDESCRIPCION.Name = "TXTDESCRIPCION"

*** METODOS ***


************************************************************
OBJETO: btnAceptar
************************************************************
*** PROPIEDADES ***
Top = 235
Left = 888
Height = 42
Width = 42
TabIndex = 3
Name = "btnAceptar"

*** METODOS ***
PROCEDURE Click
SELECT cur_retiros
IF RECCOUNT("cur_retiros") = 0 THEN
	MESSAGEBOX("No hay registros para procesar", 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

GO TOP

DO WHILE !EOF("cur_retiros")
	IF cur_retiros.cantDev <> 0 THEN
		SELECT cur_devret
		APPEND BLANK
		REPLACE cur_devret.idRetiroC WITH cur_retiros.idRetiroC
		REPLACE cur_devret.idRetiroD WITH cur_retiros.idRetiroD ADDITIVE
		REPLACE cur_devret.idArticulo WITH cur_retiros.idArticulo ADDITIVE
		REPLACE cur_devret.codArt WITH cur_retiros.codArt ADDITIVE
		REPLACE cur_devret.descripcio WITH cur_retiros.descripcio ADDITIVE
		REPLACE cur_devret.cantidad WITH cur_retiros.cantDev ADDITIVE
		REPLACE cur_devret.cantRet WITH cur_retiros.cantidad ADDITIVE
	ENDIF

	SELECT cur_retiros
	SKIP
ENDDO

SELECT cur_retiros
GO TOP

SELECT cur_devret
GO TOP
thisform.contenido.grdDevoluciones.Refresh()

ENDPROC


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Cargar devoluciones"
Height = 15
Left = 17
Top = 57
Width = 128
TabIndex = 8
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: CLSLINEA1
************************************************************
*** PROPIEDADES ***
Height = 0
Left = 13
Top = 49
Width = 958
Name = "CLSLINEA1"

*** METODOS ***


************************************************************
OBJETO: grdRetiros
************************************************************
*** PROPIEDADES ***
Height = 156
Left = 13
TabIndex = 9
Top = 76
Width = 961
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdRetiros"
COLUMN1.HEADER1.Name = "HEADER1"
COLUMN1.TEXT1.Name = "TEXT1"
COLUMN1.Name = "COLUMN1"
COLUMN2.HEADER1.Name = "HEADER1"
COLUMN2.TEXT1.Name = "TEXT1"
COLUMN2.Name = "COLUMN2"
COLUMN3.HEADER1.Name = "HEADER1"
COLUMN3.TEXT1.Name = "TEXT1"
COLUMN3.Name = "COLUMN3"
COLUMN4.HEADER1.Name = "HEADER1"
COLUMN4.TEXT1.Name = "TEXT1"
COLUMN4.Name = "COLUMN4"
COLUMN5.HEADER1.Name = "HEADER1"
COLUMN5.TEXT1.Name = "TEXT1"
COLUMN5.Name = "COLUMN5"
COLUMN6.HEADER1.Name = "HEADER1"
COLUMN6.TEXT1.Name = "TEXT1"
COLUMN6.Name = "COLUMN6"
COLUMN7.HEADER1.Name = "HEADER1"
COLUMN7.TEXT1.Name = "TEXT1"
COLUMN7.Name = "COLUMN7"
COLUMN8.HEADER1.Name = "HEADER1"
COLUMN8.TEXT1.Name = "TEXT1"
COLUMN8.Name = "COLUMN8"
COLUMN9.HEADER1.Name = "HEADER1"
COLUMN9.TEXT1.Name = "TEXT1"
COLUMN9.Name = "COLUMN9"
COLUMN10.HEADER1.Name = "HEADER1"
COLUMN10.TEXT1.Name = "TEXT1"
COLUMN10.Name = "COLUMN10"
COLUMN11.HEADER1.Name = "HEADER1"
COLUMN11.TEXT1.Name = "TEXT1"
COLUMN11.Name = "COLUMN11"
COLUMN12.HEADER1.Name = "HEADER1"
COLUMN12.TEXT1.Name = "TEXT1"
COLUMN12.Name = "COLUMN12"
COLUMN13.HEADER1.Name = "HEADER1"
COLUMN13.TEXT1.Name = "TEXT1"
COLUMN13.Name = "COLUMN13"
COLUMN14.HEADER1.Name = "HEADER1"
COLUMN14.TEXT1.Name = "TEXT1"
COLUMN14.Name = "COLUMN14"
COLUMN15.HEADER1.Name = "HEADER1"
COLUMN15.TEXT1.Name = "TEXT1"
COLUMN15.Name = "COLUMN15"
COLUMN16.HEADER1.Name = "HEADER1"
COLUMN16.TEXT1.Name = "TEXT1"
COLUMN16.Name = "COLUMN16"
COLUMN17.HEADER1.Name = "HEADER1"
COLUMN17.TEXT1.Name = "TEXT1"
COLUMN17.Name = "COLUMN17"
COLUMN18.HEADER1.Name = "HEADER1"
COLUMN18.TEXT1.Name = "TEXT1"
COLUMN18.Name = "COLUMN18"
COLUMN19.HEADER1.Name = "HEADER1"
COLUMN19.TEXT1.Name = "TEXT1"
COLUMN19.Name = "COLUMN19"
COLUMN20.HEADER1.Name = "HEADER1"
COLUMN20.TEXT1.Name = "TEXT1"
COLUMN20.Name = "COLUMN20"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Devoluciones confirmadas"
Height = 15
Left = 13
Top = 282
Width = 168
TabIndex = 10
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: btnBuscar
************************************************************
*** PROPIEDADES ***
Top = 3
Left = 577
Height = 38
Width = 42
TabIndex = 2
Name = "btnBuscar"

*** METODOS ***
PROCEDURE Click
IF thisform.contenido.sel_cliente.valcpoid = 0 THEN
	MESSAGEBOX("No se ha ingresado el código de cliente", 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

thisform.retiros.leer_pendfc(thisform.contenido.sel_cliente.valcpoid)
thisform.contenido.grdRetiros.Refresh()
thisform.contenido.grdDevoluciones.Refresh()

thisform.contenido.btnBuscar.Enabled = .F.
thisform.contenido.sel_Cliente.Enabled = .F.
thisform.contenido.btnAceptar.Enabled = .T.
thisform.contenido.btnCancelar.Enabled = .T.
thisform.contenido.btnGrabar.Enabled = .T.

ENDPROC


************************************************************
OBJETO: btnCancelar
************************************************************
*** PROPIEDADES ***
Top = 235
Left = 933
Height = 42
Width = 42
TabIndex = 4
Name = "btnCancelar"

*** METODOS ***
PROCEDURE Click
SELECT cur_devret
ZAP

UPDATE cur_retiros SET cantDev = 0
thisform.contenido.grdRetiros.Refresh()

SELECT cur_retiros
GO TOP
ENDPROC


************************************************************
OBJETO: grdDevoluciones
************************************************************
*** PROPIEDADES ***
Height = 156
Left = 13
TabIndex = 11
Top = 304
Width = 958
Name = "grdDevoluciones"
COLUMN1.HEADER1.Name = "HEADER1"
COLUMN1.TEXT1.Name = "TEXT1"
COLUMN1.Name = "COLUMN1"
COLUMN2.HEADER1.Name = "HEADER1"
COLUMN2.TEXT1.Name = "TEXT1"
COLUMN2.Name = "COLUMN2"
COLUMN3.HEADER1.Name = "HEADER1"
COLUMN3.TEXT1.Name = "TEXT1"
COLUMN3.Name = "COLUMN3"
COLUMN4.HEADER1.Name = "HEADER1"
COLUMN4.TEXT1.Name = "TEXT1"
COLUMN4.Name = "COLUMN4"
COLUMN5.HEADER1.Name = "HEADER1"
COLUMN5.TEXT1.Name = "TEXT1"
COLUMN5.Name = "COLUMN5"
COLUMN6.HEADER1.Name = "HEADER1"
COLUMN6.TEXT1.Name = "TEXT1"
COLUMN6.Name = "COLUMN6"
COLUMN7.HEADER1.Name = "HEADER1"
COLUMN7.TEXT1.Name = "TEXT1"
COLUMN7.Name = "COLUMN7"
COLUMN8.HEADER1.Name = "HEADER1"
COLUMN8.TEXT1.Name = "TEXT1"
COLUMN8.Name = "COLUMN8"
COLUMN9.HEADER1.Name = "HEADER1"
COLUMN9.TEXT1.Name = "TEXT1"
COLUMN9.Name = "COLUMN9"
COLUMN10.HEADER1.Name = "HEADER1"
COLUMN10.TEXT1.Name = "TEXT1"
COLUMN10.Name = "COLUMN10"
COLUMN11.HEADER1.Name = "HEADER1"
COLUMN11.TEXT1.Name = "TEXT1"
COLUMN11.Name = "COLUMN11"
COLUMN12.HEADER1.Name = "HEADER1"
COLUMN12.TEXT1.Name = "TEXT1"
COLUMN12.Name = "COLUMN12"
COLUMN13.HEADER1.Name = "HEADER1"
COLUMN13.TEXT1.Name = "TEXT1"
COLUMN13.Name = "COLUMN13"
COLUMN14.HEADER1.Name = "HEADER1"
COLUMN14.TEXT1.Name = "TEXT1"
COLUMN14.Name = "COLUMN14"
COLUMN15.HEADER1.Name = "HEADER1"
COLUMN15.TEXT1.Name = "TEXT1"
COLUMN15.Name = "COLUMN15"
COLUMN16.HEADER1.Name = "HEADER1"
COLUMN16.TEXT1.Name = "TEXT1"
COLUMN16.Name = "COLUMN16"
COLUMN17.HEADER1.Name = "HEADER1"
COLUMN17.TEXT1.Name = "TEXT1"
COLUMN17.Name = "COLUMN17"
COLUMN18.HEADER1.Name = "HEADER1"
COLUMN18.TEXT1.Name = "TEXT1"
COLUMN18.Name = "COLUMN18"
COLUMN19.HEADER1.Name = "HEADER1"
COLUMN19.TEXT1.Name = "TEXT1"
COLUMN19.Name = "COLUMN19"
COLUMN20.HEADER1.Name = "HEADER1"
COLUMN20.TEXT1.Name = "TEXT1"
COLUMN20.Name = "COLUMN20"

*** METODOS ***


************************************************************
OBJETO: btnGrabar
************************************************************
*** PROPIEDADES ***
Top = 487
Left = 878
Height = 43
Width = 45
TabIndex = 5
Name = "btnGrabar"

*** METODOS ***
PROCEDURE Click
SELECT cur_devret
IF RECCOUNT("cur_devret") = 0 THEN
	MESSAGEBOX("No ha ingresado ningún artículo para devolver", 0+48, Thisform.Caption)
	RETURN
ENDIF

if !thisform.retiros.dar_baja() THEN
	RETURN
ENDIF

thisform.contenido.btnBuscar.Enabled = .T.
thisform.contenido.sel_Cliente.Enabled = .T.
thisform.contenido.btnAceptar.Enabled = .F.
thisform.contenido.btnCancelar.Enabled = .F.
thisform.contenido.btnGrabar.Enabled = .F.

ENDPROC


************************************************************
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 487
Left = 926
Height = 43
Width = 45
TabIndex = 6
Name = "btnCerrar"

*** METODOS ***


************************************************************
OBJETO: cls_form_devret
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cl_form_consretiro
************************************************************
*** PROPIEDADES ***
Height = 499
Width = 936
DoCreate = .T.
Caption = "Consulta de Retiros"
MaxButton = .T.
MinButton = .T.
MaxHeight = -1
MinHeight = 469
MinWidth = 936
WindowState = 2
Name = "cl_form_consretiro"
CONTENIDO.Top = 0
CONTENIDO.Left = -1
CONTENIDO.BackColor = 255,255,255
CONTENIDO.Name = "CONTENIDO"

*** METODOS ***
PROCEDURE Init
DODEFAULT()

thisform.contenido.txtFecDesde.Value = DATE() - 30
thisform.contenido.txtFecHasta.Value = DATE()

SELECT cur_PendiFac
thisform.contenido.grdPendiFact.RecordSource = "cur_PendiFac"
thisform.contenido.grdPendiFact.alias_name = "cur_PendiFac"
thisform.contenido.grdPendiFact.list_controlsource = "codArt,descripcio,fecRetiro,cantidad,vendedor,nom_retiro"
thisform.contenido.grdpendiFact.lista_ancho_cols = "100,200,100,70,100,100"
thisform.contenido.grdPendiFact.titulos_cabeceras = "Código,Descripción,Fecha,Cantidad,Vendedor,Retiró"
thisform.contenido.grdPendiFact.generar_grid()

SELECT cur_facturad
thisform.contenido.grdFacts.RecordSource = "cur_facturad"
thisform.contenido.grdFacts.alias_name = "cur_facturad"
thisform.contenido.grdFacts.list_controlsource = "codArt,descripcio,fecRetiro,cantidad,vendedor,nom_retiro,cbte,tipoDoc,ptoVta,nroCbte"
thisform.contenido.grdFacts.lista_ancho_cols = "100,200,70,70,100,100,50,50,70,100"
thisform.contenido.grdFacts.titulos_cabeceras = "Código,Descripción,Fecha,Cantidad,Vendedor,Retiró,CBTE,Letra,Pto. Vta.,Nro. CBTE"
thisform.contenido.grdFacts.generar_grid()
ENDPROC
PROCEDURE Load
DODEFAULT()

CREATE CURSOR cur_PendiFac (	;
	codArt	varchar(20),;
	descripcio varchar(60),;
	fecRetiro D,;
	cantidad float(10, 2),;
	vendedor varchar(60),;
	nom_retiro varchar(60))
	
CREATE CURSOR cur_facturad (	;
	codArt		varchar(20),;
	descripcio 	varchar(60),;
	fecRetiro 	D,;
	cantidad 	float(10, 2),;
	vendedor 	varchar(60),;
	nom_retiro 	varchar(60),;
	cbte		varchar(3),;
	tipoDoc		varchar(1),;
	ptoVta		varchar(4),;
	nroCbte		varchar(8))
	
SELECT cur_PendiFac
INDEX ON codArt TAG codArt ASCENDING
INDEX ON descripcio TAG descripcio ASCENDING ADDITIVE
INDEX ON fecRetiro TAG fecRetiro ASCENDING ADDITIVE
INDEX ON cantidad TAG cantidad ASCENDING ADDITIVE
INDEX ON vendedor TAG vendedor ASCENDING ADDITIVE
INDEX ON nom_retiro TAG nom_retiro ASCENDING ADDITIVE

SELECT cur_facturad
INDEX ON codArt TAG codArt ASCENDING
INDEX ON descripcio TAG descripcio ASCENDING ADDITIVE
INDEX ON fecRetiro TAG fecRetiro ASCENDING ADDITIVE
INDEX ON cantidad TAG cantidad ASCENDING ADDITIVE
INDEX ON vendedor TAG vendedor ASCENDING ADDITIVE
INDEX ON nom_retiro TAG nom_retiro ASCENDING ADDITIVE
INDEX ON cbte TAG cbte ASCENDING ADDITIVE
INDEX ON tipoDoc TAG tipoDoc ASCENDING ADDITIVE
INDEX ON ptoVta TAG ptoVta ASCENDING ADDITIVE
INDEX ON nroCbte TAG nroCbte ASCENDING ADDITIVE


ENDPROC


************************************************************
OBJETO: CLSETIQUETA1
************************************************************
*** PROPIEDADES ***
Anchor = 3
Caption = "Cliente:"
Height = 15
Left = 13
Top = 13
Width = 60
TabIndex = 5
Name = "CLSETIQUETA1"

*** METODOS ***


************************************************************
OBJETO: sel_clientes
************************************************************
*** PROPIEDADES ***
Anchor = 3
Top = 7
Left = 97
TabIndex = 1
nombre_tabla = clientes
pkfield = idCliente
nombre_campo_codigo = idCliente
nombre_campo_desc = razSoc
autocompletar_ceros = .F.
esnumerico = .T.
Name = "sel_clientes"
TXTCODIGO.Name = "TXTCODIGO"
TXTDESCRIPCION.Name = "TXTDESCRIPCION"

*** METODOS ***


************************************************************
OBJETO: Clspicture1
************************************************************
*** PROPIEDADES ***
Anchor = 11
Picture = ..\imagen\gestion\title_bar.jpg
Height = 26
Left = 12
Top = 65
Width = 912
Name = "Clspicture1"

*** METODOS ***


************************************************************
OBJETO: CLSETIQUETA2
************************************************************
*** PROPIEDADES ***
Anchor = 11
Caption = "Artículos pendientes de facturar"
Height = 15
Left = 33
Top = 70
Width = 207
TabIndex = 6
ForeColor = 0,64,128
Name = "CLSETIQUETA2"

*** METODOS ***


************************************************************
OBJETO: Clspicture2
************************************************************
*** PROPIEDADES ***
Anchor = 26
Picture = ..\imagen\gestion\title_bar.jpg
Height = 28
Left = 12
Top = 264
Width = 912
Name = "Clspicture2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Anchor = 26
Caption = "Articulos Facturado"
Height = 15
Left = 33
Top = 270
Width = 207
TabIndex = 7
ForeColor = 0,64,128
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: grdPendiFact
************************************************************
*** PROPIEDADES ***
Anchor = 75
Height = 156
Left = 17
TabIndex = 8
Top = 97
Width = 901
Name = "grdPendiFact"
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
OBJETO: grdFacts
************************************************************
*** PROPIEDADES ***
Anchor = 30
Height = 148
Left = 17
TabIndex = 9
Top = 298
Width = 901
Name = "grdFacts"
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
Top = 449
Left = 874
Anchor = 12
TabIndex = 10
Name = "btnCerrar"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Anchor = 3
Caption = "Fecha Desde:"
Height = 15
Left = 13
Top = 36
Width = 84
TabIndex = 11
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Anchor = 3
Caption = "Fecha Hasta:"
Height = 15
Left = 214
Top = 36
Width = 84
TabIndex = 12
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: txtFecDesde
************************************************************
*** PROPIEDADES ***
Anchor = 3
Left = 99
TabIndex = 2
Top = 33
isdatetime = .T.
Name = "txtFecDesde"

*** METODOS ***


************************************************************
OBJETO: txtFecHasta
************************************************************
*** PROPIEDADES ***
Anchor = 3
Left = 295
TabIndex = 3
Top = 33
isdatetime = .T.
Name = "txtFecHasta"

*** METODOS ***
PROCEDURE Valid
IF thisform.contenido.txtFecHasta.Value < thisform.contenido.txtFecDesde.Value THEN
	MESSAGEBOX("La fecha hasta no puede ser menor a la fecha desde", 0+48, Thisform.Caption)
	RETURN 0
ENDIF

RETURN 1
ENDPROC


************************************************************
OBJETO: btnBuscar
************************************************************
*** PROPIEDADES ***
Top = 9
Left = 587
Anchor = 3
TabIndex = 4
Name = "btnBuscar"

*** METODOS ***
PROCEDURE Click
LOCAL loResult, lcSql, loDT

loDT = CREATEOBJECT("datetime")
loResult = CREATEOBJECT("odbc_result")
lcSql = ""

SELECT cur_PendiFac
ZAP
SELECT cur_facturad
ZAP

lcSql = lcSql + "SELECT	retirosdet.idArticulo, "
lcSql = lcSql + "		articulos.codArt, "
lcSql = lcSql + "		articulos.descripcio, "
lcSql = lcSql + "		retirosdet.fecRetiro, "
lcSql = lcSql + "		retirosdet.cantidad, "
lcSql = lcSql + "		retirosdet.cantFact, "
lcSql = lcSql + "		retirosdet.idVendedor, "
lcSql = lcSql + "		vendedores.nombre, "
lcSql = lcSql + "		retirosdet.nom_retiro, "
lcSql = lcSql + "		retirosdet.facturado, "
lcSql = lcSql + "		retirosdet.cbte, "
lcSql = lcSql + "		retirosdet.tipoDoc, "
lcSql = lcSql + "		retirosdet.ptoVta, "
lcSql = lcSql + "		retirosdet.nroCbte "
lcSql = lcSql + "FROM	retiroscab INNER JOIN retirosdet ON retiroscab.idRetiroC = retirosdet.idRetiroC "
lcSql = lcSql + "	INNER JOIN articulos ON retirosdet.idArticulo = articulos.idArticulo "
lcSql = lcSql + "	INNER JOIN vendedores ON retirosdet.idVendedor = vendedores.idVendedor "
lcSql = lcSql + "WHERE	retiroscab.idCliente = " + ALLTRIM(STR(clientes.idCliente)) + " AND "
lcSql = lcSql + "	retirosdet.fecRetiro BETWEEN " + loDT.toMySql(thisform.contenido.txtFecDesde.Value) + " AND " + loDT.toMySql(thisform.contenido.txtFecHasta.Value)
lcSql = lcSql + "	AND retirosdet.fecBaja IS NULL "

loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_retiros"

IF !loResult.OpenQuery(lcSql) THEN
	MESSAGEBOX(loResult.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_retiros
IF RECCOUNT("cur_retiros") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_retiros")
	IF !cur_retiros.facturado THEN
		SELECT cur_PendiFac
		APPEND BLANK
		REPLACE cur_PendiFac.codArt WITH cur_retiros.codArt
		REPLACE cur_PendiFac.descripcio WITH cur_retiros.descripcio ADDITIVE
		REPLACE cur_PendiFac.fecRetiro WITH cur_retiros.fecRetiro ADDITIVE
		REPLACE cur_PendiFac.cantidad WITH cur_retiros.cantidad - cur_retiros.cantFact ADDITIVE
		REPLACE cur_PendiFac.vendedor WITH cur_retiros.nombre ADDITIVE
		REPLACE cur_PendiFac.nom_retiro WITH cur_retiros.nom_retiro ADDITIVE
	ELSE
		SELECT cur_facturad
		APPEND BLANK
		REPLACE cur_facturad.codArt WITH cur_retiros.codArt
		REPLACE cur_facturad.descripcio WITH cur_retiros.descripcio ADDITIVE
		REPLACE cur_facturad.fecRetiro WITH cur_retiros.fecRetiro ADDITIVE
		REPLACE cur_facturad.cantidad WITH cur_retiros.cantFact ADDITIVE
		REPLACE cur_facturad.vendedor WITH cur_retiros.nombre ADDITIVE
		REPLACE cur_facturad.nom_retiro WITH cur_retiros.nom_retiro ADDITIVE
		REPLACE cur_facturad.cbte WITH cur_retiros.cbte ADDITIVE
		REPLACE cur_facturad.tipoDoc WITH cur_retiros.tipoDoc ADDITIVE
		REPLACE cur_facturad.ptoVta WITH REPLICATE("0", 4 - LEN(ALLTRIM(STR(cur_retiros.ptoVta)))) + ALLTRIM(STR(cur_retiros.ptoVta)) ADDITIVE
		REPLACe cur_facturad.nroCbte WITH REPLICATE("0", 8 - LEN(ALLTRIM(STR(cur_retiros.nroCbte)))) + ALLTRIM(STR(cur_retiros.nroCbte)) ADDITIVE
	ENDIF

	SELECT cur_retiros
	SKIP
ENDDO

lOResult.Close_Query()

thisform.contenido.grdFacts.Refresh()
thisform.contenido.grdPendiFact.Refresh()

ENDPROC


************************************************************
OBJETO: cl_form_consretiro
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_form_ingserv
************************************************************
*** PROPIEDADES ***
DataSession = 1
BorderStyle = 1
Height = 394
Width = 933
DoCreate = .T.
Caption = "Ingreso de Servicios"
idcliente = 0
cli_direccion = 
cli_telefono = 
cli_razsoc = 
idvendedor = 0
Name = "cls_form_ingserv"

*** METODOS ***
PROCEDURE Init
DODEFAULT()
SELECT cur_servicios
thisform.grdServicios.alias_name = "cur_servicios"
thisform.grdServicios.RecordSource = "cur_servicios"
thisform.grdServicios.list_controlsource = "selected,fecAlta,descripcio,cantidad,precio,vendedor"
thisform.grdServicios.titulos_cabeceras = "Sel.,Fecha,Descripción,Cantidad,Precio,Vendedor"
thisform.grdServicios.lista_ancho_cols = "50,100,450,70,70,100"
thisform.grdServicios.generar_grid()

SELECT cur_servicios
IF RECCOUNT("cur_servicios") > 0 THEN
	GO TOP
ENDIF

thisform.grdServicios.Refresh()
ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Descripción:"
Left = 6
Top = 12
TabIndex = 9
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: txtDescripcion
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 104
MaxLength = 60
TabIndex = 1
Top = 8
Width = 406
ischaracter = .T.
Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Cantidad:"
Left = 6
Top = 37
TabIndex = 10
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Precio:"
Left = 6
Top = 61
TabIndex = 11
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: txtCantidad
************************************************************
*** PROPIEDADES ***
Left = 104
TabIndex = 2
Top = 33
isnumeric = .T.
Name = "txtCantidad"

*** METODOS ***


************************************************************
OBJETO: txtPrecio
************************************************************
*** PROPIEDADES ***
Left = 104
TabIndex = 3
Top = 59
isnumeric = .T.
Name = "txtPrecio"

*** METODOS ***


************************************************************
OBJETO: btnAceptar
************************************************************
*** PROPIEDADES ***
Top = 45
Left = 209
Height = 37
Width = 45
Picture = ..\imagen\iconos bajados\agregar-editar-icono-6607.ico
TabIndex = 4
ToolTipText = "Agregar"
Name = "btnAceptar"

*** METODOS ***
PROCEDURE Click
IF ALLTRIM(thisform.txtDescripcion.Value) == "" THEN
	MESSAGEBOX("Debe ingresar la descripción del servicio", 0+48, Thisform.Caption)
	thisform.txtDescripcion.SetFocus
	RETURN
ENDIF

IF thisform.txtCantidad.Value = 0 THEN
	MESSAGEBOX("Debe ingresar la cantidad", 0+48, Thisform.Caption)
	thisform.txtCantidad.SetFocus()
	RETURN
ENDIF

SELECT cur_servicios
APPEND BLANK
REPLACE cur_servicios.selected WITH .F.
REPLACE cur_servicios.idServ WITH 0 ADDITIVE
REPLACE cur_servicios.idCliente WITH thisform.idcliente ADDITIVE
REPLACE cur_servicios.idVendedor WITH Thisform.idvendedor ADDITIVE
REPLACE cur_servicios.descripcio WITH thisform.txtDescripcion.Value ADDITIVE
REPLACE cur_servicios.cantidad WITH thisform.txtCantidad.Value ADDITIVE
REPLACE cur_servicios.precio WITH thisform.txtPrecio.Value ADDITIVE
REPLACE cur_servicios.usuAlta WITH ALLTRIM(gcCodUsu) ADDITIVE
REPLACE cur_servicios.fecAlta WITH DATETIME() ADDITIVE
REPLACE cur_servicios.idHostAlta WITH SYS(0) ADDITIVE

thisform.grdServicios.Refresh()

thisform.txtDescripcion.blanquear()
thisform.txtCantidad.blanquear()
thisform.txtPrecio.blanquear()

thisform.txtDescripcion.SetFocus()

ENDPROC


************************************************************
OBJETO: btnSalir
************************************************************
*** PROPIEDADES ***
Top = 347
Left = 885
Height = 41
Width = 45
TabIndex = 8
Name = "btnSalir"

*** METODOS ***


************************************************************
OBJETO: grdServicios
************************************************************
*** PROPIEDADES ***
Height = 260
Left = 6
TabIndex = 6
Top = 84
Width = 923
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdServicios"
COLUMN1.Header1.Name = "Header1"
COLUMN1.Text1.ReadOnly = .F.
COLUMN1.Text1.Name = "Text1"
COLUMN1.CurrentControl = "CLSCHECKBOX1"
COLUMN1.ReadOnly = .F.
COLUMN1.Sparse = .F.
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
OBJETO: CLSCHECKBOX1
************************************************************
*** PROPIEDADES ***
Top = 35
Left = 31
Alignment = 0
Caption = ""
ReadOnly = .F.
Name = "CLSCHECKBOX1"

*** METODOS ***


************************************************************
OBJETO: btnEliminar
************************************************************
*** PROPIEDADES ***
Top = 45
Left = 255
Height = 37
Width = 45
TabIndex = 5
Name = "btnEliminar"

*** METODOS ***
PROCEDURE Click
LOCAL lnResp

lnResp = MESSAGEBOX("Está seguro que desea eliminar el servicio?", 4+32, thisform.Caption)

IF lnResp = 6 THEN
	SELECT cur_SrvEliminar
	APPEND BLANK
	REPLACE cur_SrvEliminar.idServ WITH cur_servicios.idServ

	SELECT cur_servicios
	DELETE
	
	thisform.grdServicios.Refresh()
ENDIF
ENDPROC


************************************************************
OBJETO: btnImprimir
************************************************************
*** PROPIEDADES ***
Top = 347
Left = 839
Height = 41
Width = 45
TabIndex = 7
Name = "btnImprimir"

*** METODOS ***
PROCEDURE Click
SELECT cur_ServPrint
ZAP

SELECT cur_servicios
GO TOP

DO WHILE !EOF("cur_servicios")
	IF cur_servicios.selected THEN
		SELECT cur_ServPrint
		APPEND BLANK
		REPLACE cur_ServPrint.idServ WITH cur_servicios.idServ
		REPLACE cur_ServPrint.idCliente WITH cur_servicios.idCliente ADDITIVE
		REPLACE cur_ServPrint.descripcio WITH ALLTRIM(cur_servicios.descripcio) ADDITIVE
		REPLACE cur_ServPrint.cantidad WITH cur_servicios.cantidad ADDITIVE
		REPLACE cur_ServPrint.precio WITH cur_servicios.precio ADDITIVE
		REPLACE cur_ServPrint.vendedor WITH ALLTRIM(cur_servicios.vendedor) ADDITIVE
	ENDIF
	
	SELECT cur_servicios
	SKIP
ENDDO

SELECT cur_servicios
GO TOP

SELECT cur_ServPrint
GO TOP

m.direccion = thisform.cli_direccion
m.telefono = thisform.cli_telefono
m.idCliente = thisform.idcliente
m.razSoc = thisform.cli_razsoc

REPORT FORM "rep_servicios" PREVIEW NOCONSOLE
ENDPROC


************************************************************
OBJETO: cls_form_ingserv
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_cotizador_retiros
************************************************************
*** PROPIEDADES ***
DoCreate = .T.
Caption = "Presupuestar"
cbte = PED
Name = "cls_cotizador_retiros"
contenido.Clsetiqueta1.Name = "Clsetiqueta1"
contenido.sel_Cliente.txtCodigo.Name = "txtCodigo"
contenido.sel_Cliente.txtDescripcion.Name = "txtDescripcion"
contenido.sel_Cliente.Name = "sel_Cliente"
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
contenido.Clsetiqueta28.Name = "Clsetiqueta28"
contenido.sel_vendedor.txtCodigo.Name = "txtCodigo"
contenido.sel_vendedor.txtDescripcion.Name = "txtDescripcion"
contenido.sel_vendedor.Name = "sel_vendedor"
contenido.Name = "contenido"
mov_stock.Name = "mov_stock"
faltantes.Name = "faltantes"
fe.Top = 452
fe.Left = 632
fe.Height = 24
fe.Width = 36
fe.Name = "fe"

*** METODOS ***
PROCEDURE imprimir
LOCAL m.NroCli, m.RazSoc, m.Telefono, m.direccion, m.localidad, m.codPostal, m.pcia, m.TipoIVA, m.nroCUIT
LOCAL m.Total, m.tipoDoc, m.NroCbte, m.Fecha, m.leyenda, m.fecVto, m.tipoDoc, m.ptoVta
LOCAL m.porDesc1, m.porDesc2, m.porDesc3, m.porDesc4
LOCAL m.impDesc1, m.impDesc2, m.impDesc3, m.impDesc4
LOCAL m.porIIBB, m.impIIBB, m.observ, m.vendedor
LOCAL m.porIVA105, m.impIVA105, m.porIVA21, m.impIVA21, m.impNeto, m.impFinal
LOCAL lcSql, loNumerador, lcPrinterName, lnCantCpia

loNumerador = CREATEOBJECT("odbc_result")
lcSql = ""
m.NroCli = Thisform.contenido.sel_Cliente.txtCodigo.Value
m.RazSoc = Thisform.contenido.sel_Cliente.txtDescripcion.Value
m.Telefono = ALLTRIM(Thisform.cli_telefono)
m.direccion = ALLTRIM(Thisform.cli_calle)
m.localidad = ALLTRIM(Thisform.cli_localidad)
m.codPostal = ALLTRIM(Thisform.cli_codPostal)
m.pcia = ALLTRIM(Thisform.cli_Pcia)
m.nroCUIT = ALLTRIM(Thisform.Contenido.txtCuit.Value)
m.TipoIVA = Thisform.Contenido.txtSitIVA.Value
m.Total = 0.00
m.tipoDoc = ""
m.ptoVta = ""
m.NroCbte = ""
m.leyenda = ""
m.Fecha = DATETIME()
m.porIVA105 = 0.00
m.porIVA21 = 0.00
m.impIVA105 = 0.00
m.impIVA21 = 0.00
m.impNeto = 0.00
m.impFinal = 0.00
m.fecVto = DATE() + thisform.cp_cntdias
m.tipoDoc = Thisform.tipodoc
m.porIIBB = 0.00
m.impIIBB = 0.00
lnCantCpia = 0
m.observ = ""


*!*	lcSql = "select * from numerador where cbte = '" + ALLTRIM(Thisform.cbte) + "' and tipoDoc = '" + ALLTRIM(m.tipoDoc) + "' AND ptoVta = " + ALLTRIM(STR(INT(VAL(m.ptoVta))))
*!*	loNumerador = CREATEOBJECT("odbc_result")
*!*	loNumerador.ActiveConnection = goConn.ActiveConnection
*!*	loNumerador.Cursor_Name = "cur_num"
*!*	loNumerador.OpenQuery(lcSql)

*!*	SELECT cur_num
*!*	m.NroCbte = m.ptoVta + "-" + REPLICATE("0", 8 - LEN(ALLTRIM(STR(cur_num.numActual)))) + ALLTRIM(STR(cur_num.numActual))
*!*	lcPrinterName = cur_num.impresora
*!*	lnCantCpia = cur_num.cantCpia

*!*	loNumerador.close_query()

m.NroCbte = Thisform.ptovta + "-" + REPLICATE("0", 8 - LEN(ALLTRIM(STR(Thisform.nrocbte)))) + ALLTRIM(STR(Thisform.nrocbte))
lcPrinterName = Thisform.printerdevice
lnCantCpia = Thisform.cant_copias

IF ALLTRIM(Thisform.cbte) == "COT"
	m.leyenda = "PRESUPUESTO"
	m.tipoDoc = "X"
	m.Total = cur_Subtotal.totFact
ELSE 
	IF ALLTRIM(Thisform.cbte) == "PTO"
		m.leyenda = "PRESUPUESTO"
		m.tipoDoc = "X"
		m.Total = cur_Subtotal.impFinal
	ELSE
		IF ALLTRIM(Thisform.cbte) == "PED"
			m.leyenda = "NOTA DE PEDIDO"
			m.tipoDoc = "P"
			m.Total = Thisform.contenido.txtTotFact.Value
		ELSE
			IF ALLTRIM(Thisform.Cbte) == "FC"
				m.leyenda = "FACTURA"
				m.Total = cur_Subtotal.totFact
			ELSE
				IF ALLTRIM(Thisform.Cbte) == "NC"
					m.Leyenda = "NOTA DE CREDITO"
					m.Total = cur_Subtotal.totFact
				ELSE
					IF ALLTRIM(Thisform.Cbte) == "ND"
						m.leyenda = "NOTA DE DEBITO"
						m.Total = cur_Subtotal.totFact
					ENDIF
				ENDIF
			ENDIF
		ENDIF
	ENDIF
ENDIF 

m.NroCli = clientes.idCliente
m.RazSoc = clientes.razSoc
m.Telefono = clientes.telefono

IF (ALLTRIM(Thisform.cbte) == "NC") .OR. (ALLTRIM(Thisform.cbte) == "FC") .OR. (ALLTRIM(Thisform.cbte) == "PTO") .OR. (ALLTRIM(Thisform.cbte) == "COT") THEN
	m.porDesc1 = cur_Subtotal.porDesc1 
	m.porDesc2 = cur_Subtotal.porDesc2 
	m.porDesc3 = cur_Subtotal.porDesc3 
	m.porDesc4 = cur_Subtotal.porDesc4 
	m.impDesc1 = cur_Subtotal.impDesc1
	m.impDesc2 = cur_Subtotal.impDesc2
	m.impDesc3 = cur_Subtotal.impDesc3
	m.impDesc4 = cur_Subtotal.impDesc4
	m.porIVA105 = cur_Subtotal.porIVA105
	m.porIVA21 = cur_Subtotal.porIVA21
	m.impIVA105 = cur_Subtotal.impIVA105
	m.impIVA21 = cur_Subtotal.impIVA21
	m.impNeto = cur_Subtotal.impFinal
	m.impFinal = cur_Subtotal.impFinal
	m.porIIBB = cur_Subtotal.porIIBB
	m.impIIBB = cur_Subtotal.impIIBB
	
	SET PRINTER TO NAME ALLTRIM(lcPrinterName)
	SELECT cur_aux
ELSE 
	m.porDesc1 = Thisform.Contenido.txtDesc1.Value
	m.porDesc2 = Thisform.Contenido.txtDesc2.Value
	m.porDesc3 = Thisform.Contenido.txtDesc3.Value
	m.porDesc4 = Thisform.Contenido.txtDesc4.Value
	m.impDesc1 = Thisform.Contenido.txtImpDesc1.Value
	m.impDesc2 = Thisform.Contenido.txtImpDesc2.Value
	m.impDesc3 = Thisform.Contenido.txtImpDesc3.Value
	m.impDesc4 = Thisform.Contenido.txtImpDesc4.Value
	m.porIVA105 = Thisform.contenido.txtPorIVA105.Value
	m.porIVA21 = Thisform.Contenido.txtPorIVA21.value
	m.impIVA105 = Thisform.Contenido.txtImpIVA105.Value
	m.impIVA21 = Thisform.Contenido.txtImpIVA21.Value
	m.impNeto = Thisform.Contenido.txtST.Value
	m.impFinal = Thisform.Contenido.txtTotFact.Value
	m.porIIBB = Thisform.Contenido.txtPorIIBB.Value
	m.impIIBB = Thisform.Contenido.txtImpIIBB.Value
	
	SET PRINTER TO NAME ALLTRIM(lcPrinterName)
	SELECT cur_detalle
ENDIF 

m.observ = thisform.contenido.txtObserv.Value

FOR i = 1 TO lnCantCpia
	IF (this.cbte == "COT") THEN
		&& Imprime un presupuesto
		SELECT cur_aux
		REPORT FORM "repcot.frx" TO PRINTER NOCONSOLE
	ELSE
		IF (this.cbte == "PTO") THEN
			&& Imprime un presupuesto
			SELECT cur_aux
			REPORT FORM "reppto.frx" TO PRINTER NOCONSOLE
		ELSE
			&& Si el comprobante es "PED" entonces, tiene que enviar a imprimir una nota de pedido
			IF ALLTRIM(Thisform.cbte) == "PED" THEN
				SELECT cur_detalle
				m.observ = Thisform.contenido.txtObserv.Value
				REPORT FORM "reppedido.frx" TO PRINTER NOCONSOLE
			ELSE 
				IF ALLTRIM(Thisform.tipodoc) == "A" THEN
					&& Imprime el comprobante de tipo "A"
					SELECT cur_aux
					REPORT FORM "repcbtesvta.frx" TO PRINTER NOCONSOLE
				ELSE
					&& Imprime el comprobante de tipo "B"
					SELECT cur_aux
					REPORT FORM "repcbtesvta_b.frx" TO PRINTER NOCONSOLE
				ENDIF
			ENDIF
		ENDIF
	ENDIF
NEXT

*IF thisform.contenido.chkImprimeDup.Value = 1
*	REPORT FORM "reppto.frx" TO PRINTER NOCONSOLE
*ENDIF


ENDPROC
PROCEDURE grabar_cbte_part
&& Grabo la info en la base

LOCAL lnIdVentasC, lnIdCliente, lcFecEmis, lcCbte, lcTipoDoc, lnPtoVta
LOCAL lnNroCbte, llAnulado, lnImpNeto, lnImpFinal, lnPorIVA21, lnImpIVA21
LOCAL lnPorIVA105, lnImpIVA105, lnPorDesc1, lnPorDesc2, lnPorDesc3, lnPorDesc4
LOCAL lnImpDesc1, lnImpDesc2, lnImpDesc3, lnImpDesc4, lnTotFact
LOCAL lnIdVentasD, lnIdArticulo, lnCantidad, lnCostoRep, lnPrVenta, lnAlicIVA, lnImpIVA
LOCAL lnTotNeto, lnSubTotal, lnSaldo, lcObserv, lnPorIIBB, lnImpIIBB
LOCAL lnPDtoVta1, lnPDtoVta2, lnPDtoVta3, lnPDtoVta4, lnIDtoVta1, lnIDtoVta2, lnIDtoVta3, lnIDtoVta4
LOCAL lnIdCondPago, lnIdSitIVA, lnPrArtic
LOCAL ldFecVto, lnIdOper, oDT
LOCAL loNumerador, lcSql, loCommand, loArtic, loOper, lnSqlSrv, lnPrNeto, lnIdCCOrig, loCliente, lnIdVendedor
LOCAL loConDMO, loResult, lnResto, lnIntentos, lcRazSoc, lcNroDoc, lcDescripcion

&& Inicializo las variables del detalle

loResult = CREATEOBJECT("odbc_result")
lnIdVentasD = 0
lnIdArticulo = 0
lnCantidad = 0.00
lnCostoRep = 0.00
lnPrVenta = 0.00
lnAlicIVA = 0.00
lnImpIVA = 0.00
lnTotNeto = 0.00
lnSubTotal = 0.00
ldFecVto = {}
lnIdOper = 0
lnSaldo = 0
oDT = CREATEOBJECT("datetime")
loArtic = CREATEOBJECT("odbc_result")
loOper = CREATEOBJECT("odbc_result")
loCliente = CREATEOBJECT("odbc_result")
loCommand = CREATEOBJECT("odbc_command")
lnSqlSrv = INT(VAL(getconfig("SQLSRV")))
lcObserv = Thisform.Contenido.txtObserv.Value
lnPorIIBB = 0.00
lnImpIIBB = 0.00
lnPDtoVta1 = 0.00
lnPDtoVta2 = 0.00
lnPDtoVta3 = 0.00
lnPDtoVta4 = 0.00
lnIDtoVta1 = 0.00
lnIDtoVta2 = 0.00
lnIDtoVta3 = 0.00
lnIDtoVta4 = 0.00
lnPrNeto = 0.00
lnIdCondPago = 0
lnIdSitIVA = 0
lnIdVendedor = 0
loConDMO = CREATEOBJECT("odbc_connect")
lnPrArtic = 0.00
lnResto = 0.00
lcRazSoc = Thisform.contenido.sel_Cliente.txtDescripcion.Value
lcDescripcion = ""
lcNroDoc = Thisform.Contenido.txtCuit.Value

lcCbte = Thisform.Cbte

IF ALLTRIM(lcCbte) == "PTO" THEN
	&& Si es un comprobante PTO, entonces, abro la base DMO para generar el registro.

	loConDMO.ConnectionString = ALLTRIM(getConfig("DMO_CC"))

	IF !loConDMO.Open() THEN
		MESSAGEBOX(loConDMO.ErrorMessage, 0+48, Thisform.Caption)
		RETURN .F.
	ENDIF
ENDIF

&& Asigno los valores de la cabecera

lnIdCliente = Thisform.Contenido.sel_Cliente.ValCpoId

&& Asigno el idvendedor
lcSql = "SELECT * FROM clientes WHERE idCliente = " + ALLTRIM(STR(lnIdCliente))
loCliente.ActiveConnection = goConn.ActiveConnection
loCliente.Cursor_Name = "cur_cliente"
loCliente.OpenQuery(lcSql)

lnIdVendedor = cur_cliente.idVendedor

loCliente.Close_Query()

lcFecEmis = ALLTRIM(STR(YEAR(DATETIME()))) + "-" + ALLTRIM(STR(MONTH(DATETIME()))) + " - " + ;
	ALLTRIM(STR(DAY(DATETIME())))

IF lcCbte == "COT"
	lcTipoDoc = "X"
	Thisform.tipodoc = lcTipoDoc
ELSE
	&& Aca tengo que agregar el cálculo en caso que sea
	&& comprobante fiscal
	IF lcCbte == "PED"
		lcTipoDoc = "P"
		Thisform.tipodoc = lcTipoDoc
	ELSE
		lcTipoDoc = thisform.calcular_tipodoc()
		Thisform.tipodoc = lcTipoDoc
	ENDIF
ENDIF

IF lcCbte == "PTO" THEN
	lnPtoVta = 9999
	lcTipoDoc = "X"
	Thisform.tipodoc = lcTipoDoc
ELSE
	lnPtoVta = INT(VAL(ALLTRIM(getconfig("PTOVTA"))))
ENDIF

Thisform.ptovta = REPLICATE("0", 4 - LEN(ALLTRIM(STR(lnPtoVta)))) + ALLTRIM(STR(lnPtoVta))
	
lcSql = "select * from numerador where cbte = '" + ALLTRIM(lcCbte) + "' and tipoDoc = '" + ALLTRIM(lcTipoDoc) + "' AND ptoVta = " + ALLTRIM(STR(lnPtoVta))
loNumerador = CREATEOBJECT("odbc_result")

&& Si es PTO entonces asigno la conexión activa correspondiente a la base DMO
&& En caso contrario, apunto a la base REAL
IF ALLTRIM(lcCbte) == "PTO" THEN
	loNumerador.ActiveConnection = loConDMO.ActiveConnection
ELSE
	loNumerador.ActiveConnection = goConn.ActiveConnection
ENDIF

loNumerador.Cursor_Name = "cur_num"
loNumerador.OpenQuery(lcSql)
SELECT cur_num

IF RECCOUNT("cur_num") = 0 THEN
	MESSAGEBOX("No se encuentra configurado el numerador del comprobante " + ALLTRIM(lcCbte) + " Punto de Venta: " + ALLTRIM(STR(lnPtoVta)) + " Letra: " + ALLTRIM(lcTipoDoc), 0+48, thisform.Caption)
	loNumerador.close_query()
	RETURN .F.
ENDIF

IF !ALLTRIM(thisform.cbte) == "PTO" THEN
	IF DATE() > cur_Num.fecVto THEN
		MESSAGEBOX("El talonario actual está vencido, por favor, verifique que su talonario se encuentre en orden", 0+48, Thisform.Caption)
		loNumerador.close_query()
		RETURN .F.
	ENDIF
ENDIF

SELECT cur_num
lnNroCbte = cur_num.numActual + 1
Thisform.printerDevice = cur_num.impresora
Thisform.cant_copias = cur_num.cantCpia
Thisform.nrocbte = lnNroCbte

loNumerador.close_query()

&& Esta rutina genera intentos
lnIntentos = 0 
DO WHILE thisform.num_bloqueado()
	WAIT WINDOW "OTRO USUARIO ESTA EMITIENDO UNA FACTURA,AGUARDE POR FAVOR... (Intetnos: " + ALLTRIM(STR(lnIntentos)) + ")"  NOWAIT
	lnIntentos = lnIntentos + 1
ENDDO

&& Bloqueo el numerador
thisform.bloquear_numerador()

IF ALLTRIM(lcCbte) == "PTO" THEN
	loConDMO.BeginTransaction()	
ELSE
	goConn.BeginTransaction()
ENDIF

&& Actualizo el numerador
lcSql = "update numerador set numActual = " + ALLTRIM(STR(lnNroCbte)) + ;
	" where cbte = '" + ALLTRIM(lcCbte) + "' and tipoDoc = '" + ALLTRIM(lcTipoDoc) + "' and ptoVta = " + ALLTRIM(STR(lnPtoVta))

IF ALLTRIM(lcCbte) == "PTO" THEN
	loCommand.ActiveConnection = loConDMO.ActiveConnection
	loCommand.CommandText = lcSql

	IF !loCommand.Execute()
		thisform.desbloq_numerador()
		loConDMO.Rollback()
		RETURN .F.
	ENDIF	
ELSE
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql

	IF !loCommand.Execute()
		thisform.desbloq_numerador()
		goConn.Rollback()
		RETURN .F.
	ENDIF	
ENDIF


llAnulado = .F.
lnImpNeto = cur_Subtotal.impNeto
lnImpFinal = cur_Subtotal.impFinal
lnPorIVA21 = cur_Subtotal.porIVA21
lnPorIVA105 = cur_Subtotal.porIVA105
lnImpIVA21 = cur_Subtotal.impIVA21
lnImpIVA105 = cur_Subtotal.impIVA105
lnPorIIBB= cur_Subtotal.porIIBB
lnImpIIBB = cur_Subtotal.impIIBB
lnPorDesc1 = cur_Subtotal.porDesc1
lnPorDesc2 = cur_Subtotal.porDesc2
lnPorDesc3 = cur_Subtotal.porDesc3
lnPorDesc4 = cur_Subtotal.porDesc4
lnImpDesc1 = cur_Subtotal.impDesc1
lnImpDesc2 = cur_Subtotal.impDesc2
lnImpDesc3 = cur_Subtotal.impDesc3
lnImpDesc4 = cur_Subtotal.impDesc4
lnTotFact = cur_Subtotal.totFact
lnIdCondPago = clientes.idCondPago
lnIdSitIVA = clientes.idSitIVA

IF ALLTRIM(thisform.cbte) == "PTO"
	lnIdVentasC = loConDMO.GetNextID("ventascab", "idVentasC")
ELSE
	lnIdVentasC = goConn.GetNextID("ventascab", "idVentasC")
ENDIF

Thisform.id_ventasc = lnIdVentasC

&& Calculo la fecha de vencimiento correspondiente a la factura
IF ALLTRIM(Thisform.cbte) == "FC" THEN 
	IF thisform.cp_cntdias <> 0 THEN
		ldFecVto = DATE() + thisform.cp_cntdias
	ELSE
		ldFecVto = DATE()
	ENDIF 
ELSE
	ldFecVto = DATE()
ENDIF

IF ALLTRIM(Thisform.cbte) == "FC" .OR. ALLTRIM(Thisform.cbte) == "PTO" THEN
	lnSaldo = lnTotFact
ELSE
	lnSaldo = 0
ENDIF
	
lcSql = "INSERT INTO ventascab ( "
lcSql = lcSql + "idVentasC, idCliente, razSoc, idTipoDoc, nroDoc, fecEmision, cbte, tipoDoc, ptoVta, numCbte, anulado, idCondPago, idSitIVA, idVendedor,"
lcSql = lcSql + "impNeto, impFinal, porIVA21, impIVA21, porIVA105, impIVA105, porDesc1, "
lcSql = lcSql + "porDesc2, porDesc3, porDesc4, impDesc1, impDesc2, impDesc3, impDesc4, totFact, Saldo, usuAlta, fecAlta, idHostAlta, observ, porIIBB, impIIBB, fecVto) VALUES ("
lcSql = lcSql + ALLTRIM(STR(lnIdVentasC)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnIdCliente)) + ", "
lcSql = lcSql + "'" + STRTRAN(ALLTRIM(lcRazSoc), "'", "''") + "', "
lcSql = lcSql + "1, "
lcSql = lcSql + "'" + ALLTRIM(lcNroDoc) + "', "
lcSql = lcSql + oDT.getDateTime() + ", "
lcSql = lcSql + "'" + IIF(ALLTRIM(lcCbte) == "PTO", "FC", ALLTRIM(lcCbte)) + "', "
lcSql = lcSql + "'" + ALLTRIM(lcTipoDoc) + "', "
lcSql = lcSql + ALLTRIM(STR(lnPtoVta)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnNroCbte)) + ", "
lcSql = lcSql + IIF(lnSqlSrv = 0, "false", "0") + ", "
lcSql = lcSql + ALLTRIM(STR(lnIdCondPago)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnIdSitIVA)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnIdVendedor)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnImpNeto, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnImpFinal, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnPorIVA21, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnImpIVA21, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnPorIVA105, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnImpIVA105, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnPorDesc1, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnPorDesc2, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnPorDesc3, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnPorDesc4, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnImpDesc1, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnImpDesc2, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnImpDesc3, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnImpDesc4, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnTotFact, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnSaldo, 10, 2)) + ", "
lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', " 
lcSql = lcSql + oDT.getDateTime() + ", "
lcSql = lcSql + "'" + SYS(0) + "', '" + ALLTRIM(lcObserv) + "', "
lcSql = lcSql + ALLTRIM(STR(lnPorIIBB, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnImpIIBB, 10, 2)) + ", "
lcSql = lcSql + oDT.toMySql(ldFecVto) + ")"

loCommand.CommandText = lcSql

IF ALLTRIM(lcCbte) == "PTO" THEN
	loCommand.ActiveConnection = loConDMO.ActiveConnection
	
	IF !loCommand.Execute()
		thisform.desbloq_numerador()
		loConDMO.Rollback()
		RETURN .F.
	ENDIF	
ELSE
	loCommand.ActiveConnection = goConn.ActiveConnection
	IF !loCommand.Execute()
		thisform.desbloq_numerador()
		goConn.Rollback()
		RETURN .F.
	ENDIF
ENDIF

&& Grabo el detalle del comprobante

SELECT cur_aux
IF RECCOUNT() > 0
	GO TOP
ENDIF

lnIdVentasD = 0

DO WHILE !EOF()
	lnIdVentasD = lnIdVentasD + 1
	
	lnIdArticulo = cur_aux.idArticulo
	lcDescripcion = cur_aux.descripcio
	lnCantidad = cur_aux.cantidad
	lnAlicIVA = cur_aux.alicIVA
	lnPrVenta = cur_aux.PrVta
	lnImpIVA = cur_aux.impIVA
	lnPrNeto = cur_aux.impNeto
	lnTotNeto = cur_aux.totNeto
	lnSubTotal = cur_aux.subTotal
	lnPDtoVta1 = cur_aux.pDtoVta1
	lnPDtoVta2 = cur_aux.pDtoVta2
	lnPDtoVta3 = cur_aux.pDtoVta3
	lnPDtoVta4 = cur_aux.pDtoVta4
	lnIDtoVta1 = cur_aux.iDtoVta1
	lnIDtoVta2 = cur_aux.iDtoVta2
	lnIDtoVta3 = cur_aux.iDtoVta3
	lnIDtoVta4 = cur_aux.iDtoVta4
	
	lnPorDesc1 = cur_aux.pDtoCli1
	lnPorDesc2 = cur_aux.pDtoCli2
	lnPorDesc3 = cur_aux.pDtoCli3
	lnPorDesc4 = cur_aux.pDtoCli4
	lnImpDesc1 = cur_aux.iDtoCli1
	lnImpDesc2 = cur_aux.iDtoCli2
	lnImpDesc3 = cur_aux.iDtoCli3
	lnImpDesc4 = cur_aux.iDtoCli4
	
	lnPrArtic = cur_aux.prArtic
	
	lcSql = "SELECT * FROM articulos WHERE idArticulo = " + ALLTRIM(STR(lnIdArticulo))
	
	IF ALLTRIM(lcCbte) == "PTO" THEN
		loArtic.ActiveConnection = loConDMO.ActiveConnection
	ELSE
		loArtic.ActiveConnection = goConn.ActiveConnection
	ENDIF
	
	loArtic.Cursor_Name = "cur_Artic"
	loArtic.OpenQuery(lcSql)
	
	SELECT cur_Artic
	lnCostoRep = cur_Artic.costoRep
	
	loArtic.close_query()

	lcSql = "INSERT INTO ventasdet ( "
	lcSql = lcSql + "idVentasD, "
	lcSql = lcSql + "idVentasC, "
	lcSql = lcSql + "idArticulo, "
	lcSql = lcSql + "descripcio, "
	lcSql = lcSQl + "nroPart, "
	lcSql = lcSql + "Cantidad, "
	lcSql = lcSql + "costoRep, "
	lcSql = lcSql + "prVenta, "
	lcSql = lcSql + "alicIVA, "
	lcSql = lcSql + "impIVA, "
	lcSql = lcSql + "subTotal, "
	lcSql = lcSql + "porDesc1, "
	lcSql = lcSql + "porDesc2, "
	lcSql = lcSql + "porDesc3, "
	lcSql = lcSql + "porDesc4, "
	lcSql = lcSql + "impDesc1, "
	lcSql = lcSql + "impDesc2, "
	lcSql = lcSql + "impDesc3, "
	lcSql = lcSql + "impDesc4, "
	lcSql = lcSql + "pDtoVta1, "
	lcSql = lcSql + "pDtoVta2, "
	lcSql = lcSql + "pDtoVta3, "
	lcSql = lcSql + "pDtoVta4, "
	lcSql = lcSql + "iDtoVta1, "
	lcSql = lcSql + "iDtoVta2, "
	lcSql = lcSql + "iDtoVta3, "
	lcSql = lcSql + "iDtoVta4, "
	lcSql = lcSql + "impNeto, "
	lcSql = lcSql + "totNeto, "
	lcSql = lcSql + "prArtic, "
	lcSql = lcSql + "esOferta) VALUES ( "
	lcSql = lcSql + ALLTRIM(STR(lnIdVentasD)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnIdVentasC)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnIdArticulo)) + ", "
	lcSql = lcSql + "'" + STRTRAN(ALLTRIM(lcDescripcion), "'", "''") + "', "
	lcSql = lcSql + "'" + ALLTRIM(cur_aux.nroPart) + "', "
	lcSql = lcSql + ALLTRIM(STR(lnCantidad, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnCostoRep, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPrVenta, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnAlicIVA, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnImpIVA, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnSubTotal, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPorDesc1, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPorDesc2, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPorDesc3, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPorDesc4, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnImpDesc1, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnImpDesc2, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnImpDesc3, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnImpDesc4, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPDtoVta1, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPDtoVta2, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPDtoVta3, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPDtoVta4, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnIDtoVta1, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnIDtoVta2, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnIDtoVta3, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnIDtoVta4, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPrNeto, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnTotNeto, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPrArtic, 10, 2)) + ", "
	lcSql = lcSql + IIF(cur_aux.esOferta, "1", "0") + ")"
	
	*******************************************************************************************
	
	loCommand.CommandText = lcSql

	IF ALLTRIM(lcCbte) == "PTO" 
		loCommand.ActiveConnection = loConDMO.ActiveConnection
		IF !loCommand.Execute()
			thisform.desbloq_numerador()
			loConDMO.Rollback()
			RETURN .F.
		ENDIF	
	ELSE
		loCommand.ActiveConnection = goConn.ActiveConnection
		IF !loCommand.Execute()
			thisform.desbloq_numerador()
			goConn.Rollback()
			RETURN .F.
		ENDIF
	ENDIF	
	
	&& Si es nota de crédito entonces, actualizo la cantidad de NC en los
	&& items de la factura.
	&& Actualizar este dato tiene como objetivo de que si se hace más una NC
	&& que no se pueda hacer dos veces sobre la misma cantidad de un producto
	&& sino que por el resto.
	
	IF ALLTRIM(Thisform.cbte) == "NC" THEN
		lcSql = "UPDATE ventasdet SET cantNC = cantNC + " + ALLTRIM(STR(lnCantidad, 10, 2)) + " "
		lcSql = lcSql + "WHERE idVentasC = " + ALLTRIM(STR(Thisform.idorigen)) + " "
		lcSql = lcSql + " AND idArticulo = " + ALLTRIM(STR(cur_aux.idArticulo))
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			thisform.desbloq_numerador()
			goConn.Rollback()
			RETURN .F.
		ENDIF
	ENDIF
	
	SELECT cur_aux
	SKIP
ENDDO

IF ALLTRIM(thisform.cbte) == "FC" .OR. ALLTRIM(thisform.cbte) == "PTO" THEN
	IF ALLTRIM(thisform.cbte) == "PTO" THEN
		lnProxID = loConDMO.GetNextId("cc_cli", "idCC_Cli")
	ELSE
		lnProxID = goConn.GetNextId("cc_cli", "idCC_Cli")
	ENDIF
	
	lnIdCliente = Thisform.contenido.sel_Cliente.valcpoid
	lnIdOper = goConn.GetNextID("cc_cli", "idOper")
	
	&& Inserto el registro correspondiente a la factura en la tabla de cuentas corrientes
	lcSql = "INSERT INTO cc_cli (idCC_Cli, idCliente, idCC_Orig, cbte, nroCbte, tipoDoc, ptoVta, idCondPago, idSitIVA, idVendedor, "
	lcSql = lcSql + "fecEmis, fecVto, impDebe, impHaber, idOper, idVentasC, usuAlta, fecAlta, idHostAlta) VALUES ( "
	lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", " + ALLTRIM(STR(lnIdCliente)) + ", null, '" + IIF(ALLTRIM(lcCbte) == "PTO", "FC", ALLTRIM(lcCbte)) + "', "
	lcSql = lcSql + ALLTRIM(STR(lnNroCbte)) + ", '" + ALLTRIM(lcTipoDoc) + "', " + ALLTRIM(STR(lnPtoVta)) + ", " + ALLTRIM(STR(lnIdCondPago)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnIdSitIVA)) + ", " + ALLTRIM(STR(lnIdVendedor)) + ", " + oDT.getDateTime() + ", "
	lcSql = lcsql + oDT.toMySql(ldFecVto) + ", " + ALLTRIM(STR(lnTotFact, 10, 2)) + ", 0, " + ALLTRIM(STR(lnIdOper)) + ", " + ALLTRIM(STR(lnIdVentasC)) + ", "
	lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', " + oDT.getDateTime() + ", '" + ALLTRIM(SYS(0)) + "')"

	IF ALLTRIM(thisform.cbte) == "PTO" THEN	
		loCommand.ActiveConnection = loConDMO.ActiveConnection
	ELSE
		loCommand.ActiveConnection = goConn.ActiveConnection
	ENDIF
	
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute()
		thisform.desbloq_numerador()
		goConn.Rollback()
		RETURN .F.
	ENDIF
ELSE
	IF ALLTRIM(Thisform.cbte) == "NC" THEN
		&& Verifico si tiene numero de operación asignado
		lcSql = "SELECT idCC_Cli, idOper FROM cc_cli WHERE idVentasC = " + ALLTRIM(STR(Thisform.idorigen))
		loOper.ActiveConnection = goConn.ActiveConnection
		loOper.Cursor_Name = "cur_Oper"
		loOper.OpenQuery(lcSql)
		
		lnIdCCOrig = cur_Oper.idCC_Cli
		lnIdOper = cur_Oper.idOper
		
		loOper.Close_Query()
		
		&& Tengo que calcular el Id de Operación para vincular ambos comprobantes
		IF lnIdOper = 0 THEN
			lcSql = "SELECT MAX(cc_cli.idOper) AS maxIdOper FROM cc_cli"
			loOper.ActiveConnection = goConn.ActiveConnection
			loOper.Cursor_Name = "cur_Oper"
			loOper.OpenQuery(lcSql)
			
			lnIdOper = cur_Oper.maxIdOper + 1
			
			loOper.Close_Query()
		
			&& Actualizo el comprobante de origen con el Id de Operación calculado
			lcSql = "UPDATE cc_cli SET idOper = " + ALLTRIM(STR(lnIdOper)) + " WHERE idVentasC = " + ALLTRIM(STR(Thisform.idorigen))
			loCommand.ActiveConnection = goConn.ActiveConnection
			loCommand.CommandText = lcSql
		
			IF !loCommand.Execute()
				thisform.desbloq_numerador()
				goConn.Rollback()
				RETURN .F.
			ENDIF	
		ENDIF
		
		&& Genero el registro de la nota de crédito en las cuentas corrientes del cliente
		
		lnProxID = goConn.GetNextId("cc_cli", "idCC_Cli")
		lnIdCliente = Thisform.contenido.sel_Cliente.valcpoid	
		
		lcSql = "INSERT INTO cc_cli (idCC_Cli, idCliente, idCC_Orig, cbte, nroCbte, tipoDoc, ptoVta, idCondPago, idSitIVA, idVendedor, "
		lcSql = lcSql + "fecEmis, fecvto, impDebe, impHaber, idOper, idVentasC, usuAlta, fecAlta, idHostAlta) VALUES ( "
		lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", " + ALLTRIM(STR(lnIdCliente)) + ", " + ALLTRIM(STR(lnIdCCOrig)) + ", '" + ALLTRIM(lcCbte) + "', "
		lcSql = lcSql + ALLTRIM(STR(lnNroCbte)) + ", '" + ALLTRIM(lcTipoDoc) + "', " + ALLTRIM(STR(lnPtoVta)) + ", " + ALLTRIM(STR(lnIdCondPago)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnIdSitIVA)) + ", " + ALLTRIM(STR(lnIdVendedor)) + ", " + oDT.getDateTime() + ", "
		lcSql = lcsql + oDT.toMySql(ldFecVto) + ", 0, " + ALLTRIM(STR(lnTotFact, 10, 2)) + ", " + ALLTRIM(STR(lnIdOper)) + ", " + ALLTRIM(STR(lnIdVentasC)) + ", "
		lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', " + oDT.getDateTime() + ", '" + ALLTRIM(SYS(0)) + "')"
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute()
			thisform.desbloq_numerador()
			goConn.Rollback()
			RETURN .F.
		ENDIF
		
		lnSaldo = Thisform.saldo_fc - lnTotFact 
		
		&& Actualizo el Saldo en la factura para validar que no se pueda
		&& aplicar un importe superior al saldo.
		lcSql = "UPDATE ventascab SET saldo = " + ALLTRIM(STR(lnSaldo, 10, 2)) + ", "
		lcSql = lcSql + "usuModi = '" + ALLTRIM(gcCodUsu) + "', "
		lcSql = lcSql + "fecModi = " + oDT.getDateTime() + ", "
		lcSql = lcSql + "idHostModi = '" + ALLTRIM(SYS(0)) + "' " 				
		lcSql = lcSql + "WHERE idVentasC = " + ALLTRIM(STR(Thisform.idorigen))
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		
		loCommand.CommandText = lcSql
		IF !loCommand.Execute()
			thisform.desbloq_numerador()
			goConn.Rollback()
			RETURN .F.
		ENDIF	
	ENDIF
ENDIF

&& Ahora tengo que generar la relación entre el comprobante de origen con el comprobante
&& de destino
IF (ALLTRIM(Thisform.cbte) == "NC") .OR. (ALLTRIM(Thisform.Cbte) == "FC") .OR. (ALLTRIM(Thisform.cbte) == "PTO") THEN
	IF Thisform.idorigen <> 0 THEN
		IF ALLTRIM(thisform.cbte) == "PTO" THEN
			lnProxID = loConDMO.GetNextId("ventasrel", "idVtaRel")
		ELSE
			lnProxID = goConn.GetNextId("ventasrel", "idVtaRel")
		ENDIF
		
		lcSql = "INSERT INTO ventasrel (idVtaRel, idVtaCO, idVtaCD) VALUES ("
		lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", " + ALLTRIM(STR(Thisform.idorigen)) + ", " + ALLTRIM(STR(lnIdVentasC)) + ")"
		
		loCommand.CommandText = lcSql

		IF ALLTRIM(lcCbte) == "PTO" 
			loCommand.ActiveConnection = loConDMO.ActiveConnection
			IF !loCommand.Execute()
				thisform.desbloq_numerador()
				loConDMO.Rollback()
				RETURN .F.
			ENDIF	
		ELSE
			loCommand.ActiveConnection = goConn.ActiveConnection
			IF !loCommand.Execute()
				thisform.desbloq_numerador()
				goConn.Rollback()
				RETURN .F.
			ENDIF
		ENDIF
	ENDIF
ENDIF

IF ALLTRIM(thisform.cbte) == "PTO" THEN
	loConDMO.Commit()	
	loConDMO.close()
ELSE
	goConn.Commit()
ENDIF

thisform.desbloq_numerador()

thisform.Release()
RETURN .T.
ENDPROC
PROCEDURE particionar_cbte
************************************************************************************
** Esta función permite grabar una factura cada 25 items.
** Pablo Díaz
************************************************************************************

LOCAL ln_cantitems

ln_cantitems = 0

SELECT cur_aux
ZAP 

SELECT cur_detalle
IF RECCOUNT() > 0 THEN 
	GO TOP
ELSE 
	RETURN 
ENDIF 

************************************************************************************
** Paso de a 25 items del cursor de detalle al cursor auxiliar
************************************************************************************
SELECT cur_detalle
DO WHILE !EOF()
	ln_cantitems = ln_cantitems + 1
	
	SELECT cur_aux
	APPEND BLANK	
	
	REPLACE cur_aux.idDetalle WITH cur_detalle.idDetalle
	REPLACE cur_aux.idArticulo WITH cur_detalle.idArticulo ADDITIVE
	REPLACE cur_aux.codArt WITH cur_detalle.codArt ADDITIVE
	REPLACE cur_aux.descripcio WITH cur_detalle.descripcio ADDITIVE
	REPLACE cur_aux.nroPart WITH cur_detalle.nroPart ADDITIVE
	REPLACE cur_aux.cantidad WITH cur_detalle.cantidad ADDITIVE
	REPLACE cur_aux.prVta WITH cur_detalle.prVta ADDITIVE
	REPLACE cur_aux.pDtoVta1 WITH cur_detalle.pDtoVta1 ADDITIVE
	REPLACE cur_aux.pDtoVta2 WITH cur_detalle.pDtoVta2 ADDITIVE
	REPLACE cur_aux.pDtoVta3 WITH cur_detalle.pDtoVta3 ADDITIVE
	REPLACE cur_aux.pDtoVta4 WITH cur_detalle.pDtoVta4 ADDITIVE
	REPLACE cur_aux.iDtoVta1 WITH cur_detalle.iDtoVta1 ADDITIVE
	REPLACE cur_aux.iDtoVta2 WITH cur_detalle.iDtoVta2 ADDITIVE
	REPLACE cur_aux.iDtoVta3 WITH cur_detalle.iDtoVta3 ADDITIVE
	REPLACE cur_aux.iDtoVta4 WITH cur_detalle.iDtoVta4 ADDITIVE
	REPLACE cur_aux.pDtoCli1 WITH cur_detalle.pDtoCli1 ADDITIVE
	REPLACE cur_aux.pDtoCli2 WITH cur_detalle.pDtoCli2 ADDITIVE
	REPLACE cur_aux.pDtoCli3 WITH cur_detalle.pDtoCli3 ADDITIVE
	REPLACE cur_aux.pDtoCli4 WITH cur_detalle.pDtoCli4 ADDITIVE
	REPLACE cur_aux.iDtoCli1 WITH cur_detalle.iDtoCli1 ADDITIVE
	REPLACE cur_aux.iDtoCli2 WITH cur_detalle.iDtoCli2 ADDITIVE
	REPLACE cur_aux.iDtoCli3 WITH cur_detalle.iDtoCli3 ADDITIVE
	REPLACE cur_aux.iDtoCli4 WITH cur_detalle.iDtoCli4 ADDITIVE
	REPLACE cur_aux.alicIVA WITH cur_detalle.alicIVA ADDITIVE
	REPLACE cur_aux.impIVA WITH cur_detalle.impIVA ADDITIVE
	REPLACE cur_aux.impNeto WITH cur_detalle.impNeto ADDITIVE
	REPLACE cur_aux.totNeto WITH cur_detalle.totNeto ADDITIVE
	REPLACE cur_aux.subTotal WITH cur_detalle.subTotal ADDITIVE
	REPLACE cur_aux.prArtic WITH cur_detalle.prArtic ADDITIVE
	REPLACE cur_aux.esOferta WITH cur_detalle.esOferta ADDITIVE
	REPLACE cur_aux.pRecVta WITH cur_detalle.pRecVta ADDITIVE
	REPLACE cur_aux.iRecVta WITH cur_detalle.iRecVta ADDITIVE
	REPLACE cur_aux.uniDesp WITH cur_detalle.uniDesp ADDITIVE
	REPLACE cur_aux.cantPack WITH cur_detalle.cantPack ADDITIVE
	
	&& Cuando el contador llegue a 25 items grabo una factura nueva.
	IF ln_cantitems = 25
		&& tengo que hacer el calculo de los totales y el grabado		
		Thisform.calc_subtot_cur_aux()
		
		IF !thisform.grabar_cbte_part()
			MESSAGEBOX("Error al intentar grabar el comprobante", 0+16, Thisform.Caption)
			RETURN .F.
		ENDIF	
		
		IF ALLTRIM(Thisform.cbte) == "FC" THEN
			IF !Thisform.enviar_wsafipfe() THEN
				MESSAGEBOX("El comprobante no fué autorizado. Por favor intente más tarde desde la autorización diferida", 0+48, Thisform.Caption)
			ELSE
				Thisform.fe_set_cae()
			ENDIF
		ELSE
			IF ALLTRIM(Thisform.cbte) == "COT" THEN
				Thisform.imprimir()
			ENDIF
		ENDIF
			
		ln_cantitems = 0
		
		SELECT cur_aux
		ZAP					
	ENDIF 
	
	SELECT cur_detalle
	SKIP  
ENDDO 

&& En el caso que la ultima factura no haya llegado a los 25 items
&& tengo que hacer una nueva factura con los items restantes.
IF ln_cantitems <> 0 
	&& tengo que hacer el calculo de los totales y el grabado
	Thisform.calc_subtot_cur_aux()
	
	IF !thisform.grabar_cbte_part()
		MESSAGEBOX("Error al intentar grabar el comprobante", 0+16, Thisform.Caption)
		RETURN .F.
	ENDIF

	IF ALLTRIM(Thisform.cbte) == "FC" THEN
		IF !Thisform.enviar_wsafipfe() THEN
			MESSAGEBOX("El comprobante no fué autorizado. Por favor intente más tarde desde la autorización diferida", 0+48, Thisform.Caption)
			RETURN .F.
		ELSE
			Thisform.fe_set_cae()
		ENDIF
	ELSE
		IF ALLTRIM(Thisform.cbte) == "PED" THEN
			Thisform.imprimir()
		ENDIF
	ENDIF
ENDIF 

RETURN .T.
ENDPROC
PROCEDURE contenido.btnGrabar.Click
IF !Thisform.ValidarCampos()
	RETURN .F.
ENDIF

IF Thisform.Contenido.sel_vendedor.valcpoid = 0 THEN
	MESSAGEBOX("Debe ingresar el vendedor", 0+48, Thisform.Caption)
	Thisform.Contenido.sel_vendedor.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

IF !thisform.agregar_item() THEN
	MESSAGEBOX("Ha ocurrido un error mientras se estaba preparando los ítems para facturar", 0+48, thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_Detalle
GO TOP

Thisform.particionar_cbte()
* Thisform.imprimir()

Thisform.mov_stock.limpiar()

IF Thisform.cerrar_cbte THEN
	Thisform.blanquear()
	Thisform.Hide()
ENDIF

RETURN .T.
ENDPROC


************************************************************
OBJETO: cls_cotizador_retiros
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 9, 6, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_pto_retiros
************************************************************
*** PROPIEDADES ***
DoCreate = .T.
cbte = PTO
tipodoc = X
Name = "cls_pto_retiros"
contenido.Clsetiqueta1.Name = "Clsetiqueta1"
contenido.sel_Cliente.txtCodigo.Name = "txtCodigo"
contenido.sel_Cliente.txtDescripcion.Name = "txtDescripcion"
contenido.sel_Cliente.Name = "sel_Cliente"
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
contenido.CLSETIQUETA26.Name = "CLSETIQUETA26"
contenido.TXTCUIT.Name = "TXTCUIT"
contenido.CLSETIQUETA27.Name = "CLSETIQUETA27"
contenido.CBOUNIDVTA.Name = "CBOUNIDVTA"
contenido.TXTCANTPACK.Name = "TXTCANTPACK"
contenido.Clsetiqueta28.Name = "Clsetiqueta28"
contenido.sel_vendedor.txtCodigo.Name = "txtCodigo"
contenido.sel_vendedor.txtDescripcion.Name = "txtDescripcion"
contenido.sel_vendedor.Name = "sel_vendedor"
contenido.BackColor = 217,234,228
contenido.Name = "contenido"
mov_stock.Name = "mov_stock"
FALTANTES.Name = "FALTANTES"
FE.Top = 452
FE.Left = 632
FE.Height = 24
FE.Width = 36
FE.Name = "FE"

*** METODOS ***
PROCEDURE grabar_cbte_part
&& Grabo la info en la base

LOCAL lnIdVentasC, lnIdCliente, lcFecEmis, lcCbte, lcTipoDoc, lnPtoVta
LOCAL lnNroCbte, llAnulado, lnImpNeto, lnImpFinal, lnPorIVA21, lnImpIVA21
LOCAL lnPorIVA105, lnImpIVA105, lnPorDesc1, lnPorDesc2, lnPorDesc3, lnPorDesc4
LOCAL lnImpDesc1, lnImpDesc2, lnImpDesc3, lnImpDesc4, lnTotFact
LOCAL lnIdVentasD, lnIdArticulo, lnCantidad, lnCostoRep, lnPrVenta, lnAlicIVA, lnImpIVA
LOCAL lnTotNeto, lnSubTotal, lnSaldo, lcObserv, lnPorIIBB, lnImpIIBB
LOCAL lnPDtoVta1, lnPDtoVta2, lnPDtoVta3, lnPDtoVta4, lnIDtoVta1, lnIDtoVta2, lnIDtoVta3, lnIDtoVta4
LOCAL lnIdCondPago, lnIdSitIVA, lnPrArtic
LOCAL ldFecVto, lnIdOper, oDT
LOCAL loNumerador, lcSql, loCommand, loArtic, loOper, lnSqlSrv, lnPrNeto, lnIdCCOrig, loCliente, lnIdVendedor
LOCAL loConDMO, loResult, lnResto, lnIntentos
LOCAL lnResp

&& Inicializo las variables del detalle

loResult = CREATEOBJECT("odbc_result")
lnIdVentasD = 0
lnIdArticulo = 0
lnCantidad = 0.00
lnCostoRep = 0.00
lnPrVenta = 0.00
lnAlicIVA = 0.00
lnImpIVA = 0.00
lnTotNeto = 0.00
lnSubTotal = 0.00
ldFecVto = {}
lnIdOper = 0
lnSaldo = 0
oDT = CREATEOBJECT("datetime")
loArtic = CREATEOBJECT("odbc_result")
loOper = CREATEOBJECT("odbc_result")
loCliente = CREATEOBJECT("odbc_result")
loCommand = CREATEOBJECT("odbc_command")
lnSqlSrv = INT(VAL(getconfig("SQLSRV")))
lcObserv = Thisform.Contenido.txtObserv.Value
lnPorIIBB = 0.00
lnImpIIBB = 0.00
lnPDtoVta1 = 0.00
lnPDtoVta2 = 0.00
lnPDtoVta3 = 0.00
lnPDtoVta4 = 0.00
lnIDtoVta1 = 0.00
lnIDtoVta2 = 0.00
lnIDtoVta3 = 0.00
lnIDtoVta4 = 0.00
lnPrNeto = 0.00
lnIdCondPago = 0
lnIdSitIVA = 0
lnIdVendedor = 0
loConDMO = CREATEOBJECT("odbc_connect")
lnPrArtic = 0.00
lnResto = 0.00
lnResp = 0

lcCbte = Thisform.Cbte

&& Asigno los valores de la cabecera

lnIdCliente = Thisform.Contenido.sel_Cliente.ValCpoId

&& Asigno el idvendedor
lcSql = "SELECT * FROM clientes WHERE idCliente = " + ALLTRIM(STR(lnIdCliente))
loCliente.ActiveConnection = goConn.ActiveConnection
loCliente.Cursor_Name = "cur_cliente"
loCliente.OpenQuery(lcSql)

lnIdVendedor = cur_cliente.idVendedor

loCliente.Close_Query()

lcFecEmis = ALLTRIM(STR(YEAR(DATETIME()))) + "-" + ALLTRIM(STR(MONTH(DATETIME()))) + " - " + ;
	ALLTRIM(STR(DAY(DATETIME())))

IF lcCbte == "COT"
	lcTipoDoc = "X"
	Thisform.tipodoc = lcTipoDoc
ELSE
	&& Aca tengo que agregar el cálculo en caso que sea
	&& comprobante fiscal
	IF lcCbte == "PED"
		lcTipoDoc = "P"
		Thisform.tipodoc = lcTipoDoc
	ELSE
		lcTipoDoc = thisform.calcular_tipodoc()
		Thisform.tipodoc = lcTipoDoc
	ENDIF
ENDIF

IF lcCbte == "COT" THEN
	lnPtoVta = 1
	lcTipoDoc = "X"
	Thisform.tipodoc = lcTipoDoc
ELSE
	IF lcCbte == "PTO" THEN
		lnPtoVta = 0
		lcTipoDoc = "X"
	ELSE
		lnPtoVta = INT(VAL(ALLTRIM(getconfig("PTOVTA"))))
	ENDIF
ENDIF

Thisform.ptovta = REPLICATE("0", 4 - LEN(ALLTRIM(STR(lnPtoVta)))) + ALLTRIM(STR(lnPtoVta))
	
lcSql = "select * from numerador where cbte = '" + ALLTRIM(lcCbte) + "' and tipoDoc = '" + ALLTRIM(lcTipoDoc) + "' AND ptoVta = " + ALLTRIM(STR(lnPtoVta))
loNumerador = CREATEOBJECT("odbc_result")

loNumerador.ActiveConnection = goConn.ActiveConnection

loNumerador.Cursor_Name = "cur_num"
loNumerador.OpenQuery(lcSql)
SELECT cur_num

IF RECCOUNT("cur_num") = 0 THEN
	MESSAGEBOX("No se encuentra configurado el numerador del comprobante " + ALLTRIM(lcCbte) + " Punto de Venta: " + ALLTRIM(STR(lnPtoVta)) + " Letra: " + ALLTRIM(lcTipoDoc), 0+48, thisform.Caption)
	loNumerador.close_query()
	RETURN .F.
ENDIF

SELECT cur_num
lnNroCbte = cur_num.numActual + 1
Thisform.nrocbte = REPLICATE("0", 8 - LEN(ALLTRIM(STR(lnNroCbte)))) + ALLTRIM(STR(lnNroCbte))
Thisform.printerDevice = cur_num.impresora
Thisform.cant_copias = cur_num.cantCpia

loNumerador.close_query()

&& Esta rutina genera intentos
lnIntentos = 0 
DO WHILE thisform.num_bloqueado()
	WAIT WINDOW "OTRO USUARIO ESTA EMITIENDO UNA FACTURA,AGUARDE POR FAVOR... (Intetnos: " + ALLTRIM(STR(lnIntentos)) + ")"  NOWAIT
	lnIntentos = lnIntentos + 1
ENDDO

&& Bloqueo el numerador
thisform.bloquear_numerador()
goConn.BeginTransaction()

&& Actualizo el numerador
lcSql = "update numerador set numActual = " + ALLTRIM(STR(lnNroCbte)) + ;
	" where cbte = '" + ALLTRIM(lcCbte) + "' and tipoDoc = '" + ALLTRIM(lcTipoDoc) + "' and ptoVta = " + ALLTRIM(STR(lnPtoVta))

loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = lcSql

IF !loCommand.Execute()
	thisform.desbloq_numerador()
	goConn.Rollback()
	RETURN .F.
ENDIF	

llAnulado = .F.
lnImpNeto = cur_Subtotal.impNeto
lnImpFinal = cur_Subtotal.impFinal
lnPorIVA21 = cur_Subtotal.porIVA21
lnPorIVA105 = cur_Subtotal.porIVA105
lnImpIVA21 = cur_Subtotal.impIVA21
lnImpIVA105 = cur_Subtotal.impIVA105
lnPorIIBB= cur_Subtotal.porIIBB
lnImpIIBB = cur_Subtotal.impIIBB
lnPorDesc1 = cur_Subtotal.porDesc1
lnPorDesc2 = cur_Subtotal.porDesc2
lnPorDesc3 = cur_Subtotal.porDesc3
lnPorDesc4 = cur_Subtotal.porDesc4
lnImpDesc1 = cur_Subtotal.impDesc1
lnImpDesc2 = cur_Subtotal.impDesc2
lnImpDesc3 = cur_Subtotal.impDesc3
lnImpDesc4 = cur_Subtotal.impDesc4
lnTotFact = cur_Subtotal.totFact
lnIdCondPago = clientes.idCondPago
lnIdSitIVA = clientes.idSitIVA

lnIdVentasC = goConn.GetNextID("ventascab", "idVentasC")

&& Calculo la fecha de vencimiento correspondiente a la factura
IF ALLTRIM(Thisform.cbte) == "FC" THEN 
	IF thisform.cp_cntdias <> 0 THEN
		ldFecVto = DATE() + thisform.cp_cntdias
	ELSE
		ldFecVto = DATE()
	ENDIF 
ELSE
	ldFecVto = DATE()
ENDIF

IF ALLTRIM(Thisform.cbte) == "FC" .OR. ALLTRIM(Thisform.cbte) == "PTO" THEN
	lnSaldo = lnTotFact
ELSE
	lnSaldo = 0
ENDIF
	
lcSql = "INSERT INTO ventascab ( "
lcSql = lcSql + "idVentasC, idCliente, fecEmision, cbte, tipoDoc, ptoVta, numCbte, anulado, idCondPago, idSitIVA, idVendedor,"
lcSql = lcSql + "impNeto, impFinal, porIVA21, impIVA21, porIVA105, impIVA105, porDesc1, "
lcSql = lcSql + "porDesc2, porDesc3, porDesc4, impDesc1, impDesc2, impDesc3, impDesc4, totFact, Saldo, usuAlta, fecAlta, idHostAlta, observ, porIIBB, impIIBB, fecVto) VALUES ("
lcSql = lcSql + ALLTRIM(STR(lnIdVentasC)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnIdCliente)) + ", "
lcSql = lcSql + oDT.getDateTime() + ", "
lcSql = lcSql + "'" + IIF(ALLTRIM(lcCbte) == "PTO", "FC", ALLTRIM(lcCbte)) + "', "
lcSql = lcSql + "'" + ALLTRIM(lcTipoDoc) + "', "
lcSql = lcSql + ALLTRIM(STR(lnPtoVta)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnNroCbte)) + ", "
lcSql = lcSql + IIF(lnSqlSrv = 0, "false", "0") + ", "
lcSql = lcSql + ALLTRIM(STR(lnIdCondPago)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnIdSitIVA)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnIdVendedor)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnImpNeto, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnImpFinal, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnPorIVA21, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnImpIVA21, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnPorIVA105, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnImpIVA105, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnPorDesc1, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnPorDesc2, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnPorDesc3, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnPorDesc4, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnImpDesc1, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnImpDesc2, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnImpDesc3, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnImpDesc4, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnTotFact, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnSaldo, 10, 2)) + ", "
lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', " 
lcSql = lcSql + oDT.getDateTime() + ", "
lcSql = lcSql + "'" + SYS(0) + "', '" + ALLTRIM(lcObserv) + "', "
lcSql = lcSql + ALLTRIM(STR(lnPorIIBB, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnImpIIBB, 10, 2)) + ", "
lcSql = lcSql + oDT.toMySql(ldFecVto) + ")"

loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = lcSql

IF !loCommand.Execute()
	thisform.desbloq_numerador()
	goConn.Rollback()
	RETURN .F.
ENDIF

&& Grabo el detalle del comprobante

SELECT cur_aux
IF RECCOUNT() > 0
	GO TOP
ENDIF

lnIdVentasD = 0

DO WHILE !EOF()
	lnIdVentasD = lnIdVentasD + 1
	
	lnIdArticulo = cur_aux.idArticulo
	lnCantidad = cur_aux.cantidad
	lnAlicIVA = cur_aux.alicIVA
	lnPrVenta = cur_aux.PrVta
	lnImpIVA = cur_aux.impIVA
	lnPrNeto = cur_aux.impNeto
	lnTotNeto = cur_aux.totNeto
	lnSubTotal = cur_aux.subTotal
	lnPDtoVta1 = cur_aux.pDtoVta1
	lnPDtoVta2 = cur_aux.pDtoVta2
	lnPDtoVta3 = cur_aux.pDtoVta3
	lnPDtoVta4 = cur_aux.pDtoVta4
	lnIDtoVta1 = cur_aux.iDtoVta1
	lnIDtoVta2 = cur_aux.iDtoVta2
	lnIDtoVta3 = cur_aux.iDtoVta3
	lnIDtoVta4 = cur_aux.iDtoVta4
	
	lnPorDesc1 = cur_aux.pDtoCli1
	lnPorDesc2 = cur_aux.pDtoCli2
	lnPorDesc3 = cur_aux.pDtoCli3
	lnPorDesc4 = cur_aux.pDtoCli4
	lnImpDesc1 = cur_aux.iDtoCli1
	lnImpDesc2 = cur_aux.iDtoCli2
	lnImpDesc3 = cur_aux.iDtoCli3
	lnImpDesc4 = cur_aux.iDtoCli4
	
	lnPrArtic = cur_aux.prArtic
	
	lcSql = "SELECT * FROM articulos WHERE idArticulo = " + ALLTRIM(STR(lnIdArticulo))
	
	loArtic.ActiveConnection = goConn.ActiveConnection
	loArtic.Cursor_Name = "cur_Artic"
	loArtic.OpenQuery(lcSql)
	
	SELECT cur_Artic
	lnCostoRep = cur_Artic.costoRep
	
	loArtic.close_query()

	lcSql = "INSERT INTO ventasdet ( "
	lcSql = lcSql + "idVentasD, "
	lcSql = lcSql + "idVentasC, "
	lcSql = lcSql + "idArticulo, "
	lcSql = lcSQl + "nroPart, "
	lcSql = lcSql + "Cantidad, "
	lcSql = lcSql + "costoRep, "
	lcSql = lcSql + "prVenta, "
	lcSql = lcSql + "alicIVA, "
	lcSql = lcSql + "impIVA, "
	lcSql = lcSql + "subTotal, "
	lcSql = lcSql + "porDesc1, "
	lcSql = lcSql + "porDesc2, "
	lcSql = lcSql + "porDesc3, "
	lcSql = lcSql + "porDesc4, "
	lcSql = lcSql + "impDesc1, "
	lcSql = lcSql + "impDesc2, "
	lcSql = lcSql + "impDesc3, "
	lcSql = lcSql + "impDesc4, "
	lcSql = lcSql + "pDtoVta1, "
	lcSql = lcSql + "pDtoVta2, "
	lcSql = lcSql + "pDtoVta3, "
	lcSql = lcSql + "pDtoVta4, "
	lcSql = lcSql + "iDtoVta1, "
	lcSql = lcSql + "iDtoVta2, "
	lcSql = lcSql + "iDtoVta3, "
	lcSql = lcSql + "iDtoVta4, "
	lcSql = lcSql + "impNeto, "
	lcSql = lcSql + "totNeto, "
	lcSql = lcSql + "prArtic, "
	lcSql = lcSql + "esOferta) VALUES ( "
	lcSql = lcSql + ALLTRIM(STR(lnIdVentasD)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnIdVentasC)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnIdArticulo)) + ", "
	lcSql = lcSql + "'" + ALLTRIM(cur_aux.nroPart) + "', "
	lcSql = lcSql + ALLTRIM(STR(lnCantidad, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnCostoRep, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPrVenta, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnAlicIVA, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnImpIVA, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnSubTotal, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPorDesc1, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPorDesc2, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPorDesc3, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPorDesc4, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnImpDesc1, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnImpDesc2, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnImpDesc3, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnImpDesc4, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPDtoVta1, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPDtoVta2, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPDtoVta3, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPDtoVta4, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnIDtoVta1, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnIDtoVta2, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnIDtoVta3, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnIDtoVta4, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPrNeto, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnTotNeto, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPrArtic, 10, 2)) + ", "
	lcSql = lcSql + IIF(cur_aux.esOferta, "1", "0") + ")"
	
	*******************************************************************************************
	
	loCommand.CommandText = lcSql

	loCommand.ActiveConnection = goConn.ActiveConnection
	IF !loCommand.Execute()
		thisform.desbloq_numerador()
		goConn.Rollback()
		RETURN .F.
	ENDIF
	
	&& Si es nota de crédito entonces, actualizo la cantidad de NC en los
	&& items de la factura.
	&& Actualizar este dato tiene como objetivo de que si se hace más una NC
	&& que no se pueda hacer dos veces sobre la misma cantidad de un producto
	&& sino que por el resto.
	
	IF ALLTRIM(Thisform.cbte) == "NC" THEN
		lcSql = "UPDATE ventasdet SET cantNC = cantNC + " + ALLTRIM(STR(lnCantidad, 10, 2)) + " "
		lcSql = lcSql + "WHERE idVentasC = " + ALLTRIM(STR(Thisform.idorigen)) + " "
		lcSql = lcSql + " AND idArticulo = " + ALLTRIM(STR(cur_aux.idArticulo))
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			thisform.desbloq_numerador()
			goConn.Rollback()
			RETURN .F.
		ENDIF
	ENDIF
	
	SELECT cur_aux
	SKIP
ENDDO

IF ALLTRIM(thisform.cbte) == "FC" .OR. ALLTRIM(thisform.cbte) == "PTO" THEN
	lnProxID = goConn.GetNextId("cc_cli", "idCC_Cli")
	
	lnIdCliente = Thisform.contenido.sel_Cliente.valcpoid
	lnIdOper = goConn.GetNextID("cc_cli", "idOper")
	
	&& Inserto el registro correspondiente a la factura en la tabla de cuentas corrientes
	lcSql = "INSERT INTO cc_cli (idCC_Cli, idCliente, idCC_Orig, cbte, nroCbte, tipoDoc, ptoVta, idCondPago, idSitIVA, idVendedor, "
	lcSql = lcSql + "fecEmis, fecVto, impDebe, impHaber, idOper, idVentasC, usuAlta, fecAlta, idHostAlta) VALUES ( "
	lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", " + ALLTRIM(STR(lnIdCliente)) + ", null, '" + IIF(ALLTRIM(lcCbte) == "PTO", "FC", ALLTRIM(lcCbte)) + "', "
	lcSql = lcSql + ALLTRIM(STR(lnNroCbte)) + ", '" + ALLTRIM(lcTipoDoc) + "', " + ALLTRIM(STR(lnPtoVta)) + ", " + ALLTRIM(STR(lnIdCondPago)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnIdSitIVA)) + ", " + ALLTRIM(STR(lnIdVendedor)) + ", " + oDT.getDateTime() + ", "
	lcSql = lcsql + oDT.toMySql(ldFecVto) + ", " + ALLTRIM(STR(lnTotFact, 10, 2)) + ", 0, " + ALLTRIM(STR(lnIdOper)) + ", " + ALLTRIM(STR(lnIdVentasC)) + ", "
	lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', " + oDT.getDateTime() + ", '" + ALLTRIM(SYS(0)) + "')"

	loCommand.ActiveConnection = goConn.ActiveConnection	
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute()
		thisform.desbloq_numerador()
		goConn.Rollback()
		RETURN .F.
	ENDIF
ELSE
	IF ALLTRIM(Thisform.cbte) == "NC" THEN
		&& Verifico si tiene numero de operación asignado
		lcSql = "SELECT idCC_Cli, idOper FROM cc_cli WHERE idVentasC = " + ALLTRIM(STR(Thisform.idorigen))
		loOper.ActiveConnection = goConn.ActiveConnection
		loOper.Cursor_Name = "cur_Oper"
		loOper.OpenQuery(lcSql)
		
		lnIdCCOrig = cur_Oper.idCC_Cli
		lnIdOper = cur_Oper.idOper
		
		loOper.Close_Query()
		
		&& Tengo que calcular el Id de Operación para vincular ambos comprobantes
		IF lnIdOper = 0 THEN
			lcSql = "SELECT MAX(cc_cli.idOper) AS maxIdOper FROM cc_cli"
			loOper.ActiveConnection = goConn.ActiveConnection
			loOper.Cursor_Name = "cur_Oper"
			loOper.OpenQuery(lcSql)
			
			lnIdOper = cur_Oper.maxIdOper + 1
			
			loOper.Close_Query()
		
			&& Actualizo el comprobante de origen con el Id de Operación calculado
			lcSql = "UPDATE cc_cli SET idOper = " + ALLTRIM(STR(lnIdOper)) + " WHERE idVentasC = " + ALLTRIM(STR(Thisform.idorigen))
			loCommand.ActiveConnection = goConn.ActiveConnection
			loCommand.CommandText = lcSql
		
			IF !loCommand.Execute()
				thisform.desbloq_numerador()
				goConn.Rollback()
				RETURN .F.
			ENDIF	
		ENDIF
		
		&& Genero el registro de la nota de crédito en las cuentas corrientes del cliente
		
		lnProxID = goConn.GetNextId("cc_cli", "idCC_Cli")
		lnIdCliente = Thisform.contenido.sel_Cliente.valcpoid	
		
		lcSql = "INSERT INTO cc_cli (idCC_Cli, idCliente, idCC_Orig, cbte, nroCbte, tipoDoc, ptoVta, idCondPago, idSitIVA, idVendedor, "
		lcSql = lcSql + "fecEmis, fecvto, impDebe, impHaber, idOper, idVentasC, usuAlta, fecAlta, idHostAlta) VALUES ( "
		lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", " + ALLTRIM(STR(lnIdCliente)) + ", " + ALLTRIM(STR(lnIdCCOrig)) + ", '" + ALLTRIM(lcCbte) + "', "
		lcSql = lcSql + ALLTRIM(STR(lnNroCbte)) + ", '" + ALLTRIM(lcTipoDoc) + "', " + ALLTRIM(STR(lnPtoVta)) + ", " + ALLTRIM(STR(lnIdCondPago)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnIdSitIVA)) + ", " + ALLTRIM(STR(lnIdVendedor)) + ", " + oDT.getDateTime() + ", "
		lcSql = lcsql + oDT.toMySql(ldFecVto) + ", 0, " + ALLTRIM(STR(lnTotFact, 10, 2)) + ", " + ALLTRIM(STR(lnIdOper)) + ", " + ALLTRIM(STR(lnIdVentasC)) + ", "
		lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', " + oDT.getDateTime() + ", '" + ALLTRIM(SYS(0)) + "')"
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute()
			thisform.desbloq_numerador()
			goConn.Rollback()
			RETURN .F.
		ENDIF
		
		lnSaldo = Thisform.saldo_fc - lnTotFact 
		
		&& Actualizo el Saldo en la factura para validar que no se pueda
		&& aplicar un importe superior al saldo.
		lcSql = "UPDATE ventascab SET saldo = " + ALLTRIM(STR(lnSaldo, 10, 2)) + ", "
		lcSql = lcSql + "usuModi = '" + ALLTRIM(gcCodUsu) + "', "
		lcSql = lcSql + "fecModi = " + oDT.getDateTime() + ", "
		lcSql = lcSql + "idHostModi = '" + ALLTRIM(SYS(0)) + "' " 				
		lcSql = lcSql + "WHERE idVentasC = " + ALLTRIM(STR(Thisform.idorigen))
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		
		loCommand.CommandText = lcSql
		IF !loCommand.Execute()
			thisform.desbloq_numerador()
			goConn.Rollback()
			RETURN .F.
		ENDIF	
	ENDIF
ENDIF

&& Ahora tengo que generar la relación entre el comprobante de origen con el comprobante
&& de destino
IF (ALLTRIM(Thisform.cbte) == "NC") .OR. (ALLTRIM(Thisform.Cbte) == "FC") .OR. (ALLTRIM(Thisform.cbte) == "PTO") THEN
	IF Thisform.idorigen <> 0 THEN
		lnProxID = goConn.GetNextId("ventasrel", "idVtaRel")
		
		lcSql = "INSERT INTO ventasrel (idVtaRel, idVtaCO, idVtaCD) VALUES ("
		lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", " + ALLTRIM(STR(Thisform.idorigen)) + ", " + ALLTRIM(STR(lnIdVentasC)) + ")"
		
		loCommand.CommandText = lcSql

		loCommand.ActiveConnection = goConn.ActiveConnection
		IF !loCommand.Execute()
			thisform.desbloq_numerador()
			goConn.Rollback()
			RETURN .F.
		ENDIF
	ENDIF
ENDIF

*!*	lnResp = MESSAGEBOX("¿Desea reservar el stock para esta cotización?", 4+32, thisform.Caption)

*!*	&& Si el usuario responde que si, entonces, marca los retiros como facturado
*!*	IF lnResp = 6 THEN
*!*		&& Actualizo los registros del retiro
	SELECT cur_aux
	IF RECCOUNT("cur_aux") > 0 THEN
		GO TOP
	ENDIF

	DO WHILE !EOF("cur_aux")
		lcSql = "SELECT	idArticulo, idRetiroC, idRetiroD, cantidad "
		lcSql = lcSql + "FROM retirosdet "
		lcSql = lcSql + "WHERE idRetiroC = " + ALLTRIM(STR(this.idretiroc)) + " "
		lcSql = lcSql + "	AND idArticulo = " + ALLTRIM(STR(cur_aux.idArticulo)) + " "
		lcSql = lcsql + "ORDER BY retirosdet.cantidad ASC"
		
		loResult.ActiveConnection = goConn.ActiveConnection		
		loResult.Cursor_Name = "cur_artret"
		
		IF !loResult.OpenQuery(lcSql) THEN
			MESSAGEBOX(loResult.Error_Message, 0+48, thisform.Caption)
			thisform.desbloq_numerador()
			goCon.Rollback()
		ENDIF
		
		lnResto = cur_aux.cantidad
		
		SELECT cur_artret
		GO TOP
		DO WHILE !EOF("cur_artret")
			lcSql = "UPDATE retirosdet SET "
			
			&& Solamente marco el retiro como facturado si se facturó el 100% de la cantidad
			&& correspondiente al retiro.
			
			IF (cur_artret.cantidad - lnResto) <= 0 THEN
				lcSql = lcSql + "	 retirosdet.facturado = 1, "
			ELSE
				lcSql = lcSql + "	 retirosdet.facturado = 0, "
			ENDIF
			
			lcSql = lcSql + "	 retirosdet.cbte = '" + ALLTRIM(lcCbte) + "', "
			lcSql = lcSql + "	 retirosdet.tipoDoc = '" + ALLTRIM(lcTipoDoc) + "', "
			lcSql = lcSql + "	 retirosdet.ptoVta = " + ALLTRIM(STR(lnPtoVta)) + ", "
			lcSql = lcSql + "	 retirosdet.nroCbte = " + ALLTRIM(STR(lnNroCbte)) + ", "
			
			IF lnResto >= cur_artret.cantidad THEN
				lcSql = lcSql + "	 retirosdet.fecFact = " + oDT.getDateTime() + ", "
				lcSql = lcSql + " retirosdet.cantFact = " + ALLTRIM(STR(cur_artret.cantidad, 10, 2)) + " "
			ELSE
				IF lnResto < 0 THEN
					lcSql = lcSql + " retirosdet.cantFact = 0 "
				ELSE
					lcSql = lcSql + " retirosdet.cantFact = " + ALLTRIM(STR(lnResto, 10, 2)) + " "
				ENDIF
			ENDIF
			
			lcSql = lcSql + "WHERE retirosdet.idRetiroC = " + ALLTRIM(STR(this.idretiroc)) + " "
			lcSql = lcSql + " AND retirosdet.idRetiroD = " + ALLTRIM(STR(cur_artret.idRetiroD)) + " "
			
			
			loCommand.ActiveConnection = goConn.ActiveConnection		
			loCommand.CommandText = lcSql
			
			IF !loCommand.Execute() THEN
				MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
				thisform.desbloq_numerador()
				goConn.Rollback()				
				RETURN .F.
			ENDIF
			
			lnResto = lnResto - cur_artret.cantidad
			SELECT cur_artret
			SKIP
		ENDDO
		
		loResult.close_query()

		SELECT cur_aux
		SKIP
	ENDDO

	* A continuación verifico si hay artículos que corresponde hacer el movimiento de stock
	* para esta factura.

*!*		thisform.generar_reg_stock()
*!*		SELECT cur_movstock
*!*		IF RECCOUNT("cur_movstock") > 0 THEN
*!*			IF getGlobalCFG("STK_MODULE") .AND. ALLTRIM(Thisform.cbte) <> "NC" THEN
*!*				thisform.mov_stock.limpiar()
*!*				
*!*				IF ALLTRIM(Thisform.cbte) == "COT" THEN
*!*					Thisform.mov_stock.circuito = "S"
*!*					Thisform.mov_stock.tipodoc = ""
*!*					Thisform.mov_stock.cbte = ""
*!*				ELSE
*!*					Thisform.mov_stock.circuito = "V"
*!*					Thisform.mov_stock.idcliente = Thisform.contenido.sel_cliente.valcpoid
*!*					Thisform.mov_stock.idProv = 0
*!*					Thisform.mov_stock.cbte = IIF(ALLTRIM(lcCbte) == "PTO", "SAL", lcCbte)
*!*					Thisform.mov_stock.numcbte =  REPLICATE("0", 4 - LEN(ALLTRIM(STR(lnPtoVta)))) + ALLTRIM(STR(lnPtoVta)) + "-" + REPLICATE("0", 8 - LEN(ALLTRIM(STR(lnNroCbte)))) + ALLTRIM(STR(lnNroCbte))
*!*				ENDIF
*!*				
*!*				SELECT cur_movstock
*!*				GO TOP
*!*				
*!*				DO WHILE !EOF("cur_movstock")
*!*					Thisform.mov_stock.agregar_articulo(cur_movstock.idArticulo, cur_movstock.cantidad, cur_movstock.nroPart)
*!*					
*!*					SELECT cur_movstock
*!*					SKIP
*!*				ENDDO
*!*				
*!*				&& Grabo los movimientos de stock
*!*				IF !(ALLTRIM(Thisform.cbte) == "PED") THEN
*!*					IF !Thisform.mov_stock.grabar2() THEN
*!*						MESSAGEBOX(Thisform.mov_stock.ErrorMessage, 0+48, Thisform.Caption)
*!*						thisform.desbloq_numerador()
*!*						goConn.Rollback()
*!*						RETURN .F.
*!*					ENDIF
*!*				ENDIF
*!*			ENDIF
*!*		ENDIF
*!*	ENDIF

goConn.Commit()

thisform.desbloq_numerador()

MESSAGEBOX("El comprobante: " + ALLTRIM(lcCbte) + " " + ALLTRIM(lcTipoDoc) + " " + REPLICATE("0", 4 - LEN(ALLTRIM(STR(lnPtoVta)))) + ALLTRIM(STR(lnPtoVta)) + "-" + ;
	REPLICATE("0", 8 - LEN(ALLTRIM(STR(lnNroCbte)))) + ALLTRIM(STR(lnNroCbte)) + " se ha generado exitosamente...", 0+64, Thisform.Caption)

Thisform.nrocbte = lnNroCbte
Thisform.Release()
RETURN .T.
ENDPROC
PROCEDURE contenido.btnGrabar.Click
IF !Thisform.ValidarCampos()
	RETURN .F.
ENDIF

IF !thisform.agregar_item() THEN
	MESSAGEBOX("Ha ocurrido un error mientras se estaba preparando los ítems para facturar", 0+48, thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_Detalle
GO TOP

IF !Thisform.particionar_cbte() THEN
	RETURN .F.
ENDIF

Thisform.imprimir()
Thisform.actualizar_servicios()	&& Marco los servicios que fueron facturados en esta factura

Thisform.mov_stock.limpiar()

IF Thisform.cerrar_cbte THEN
	Thisform.blanquear()
	Thisform.Hide()
ENDIF

RETURN .T.
ENDPROC


************************************************************
OBJETO: cls_pto_retiros
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 9, 6, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_form_retiros
************************************************************
*** PROPIEDADES ***
BorderStyle = 2
Height = 547
Width = 946
DoCreate = .T.
Comment = ""
Caption = "Retiro de Mercadería"
MaxButton = .F.
MinButton = .F.
saldodeudor = 0.00
cli_direccion = 
cli_telefono = 
cant_sel = 0
esnuevo = .F.
Name = "cls_form_retiros"
contenido.Top = -1
contenido.Left = -1
contenido.Width = 948
contenido.Height = 552
contenido.TabIndex = 1
contenido.Name = "contenido"

*** METODOS ***
PROCEDURE cambiar_estado
PARAMETERS tlEstado

thisform.contenido.sel_clientes.txtCodigo.Enabled = tlEstado
thisform.contenido.sel_vendedor.txtCodigo.Enabled = tlEstado
thisform.contenido.btnAceptar.Enabled = tlEstado
thisform.contenido.btnAgregar.Enabled = !tlEstado
thisform.contenido.sel_articulos.txtCodigo.Enabled = !tlEstado
thisform.contenido.sel_articulos.txtCodigo.Enabled = !tlEstado
thisform.contenido.txtCantidad.Enabled = !tlEstado
thisform.contenido.txtRetiro.Enabled = !tlEstado
thisform.contenido.btnimprimir.Enabled = !tlEstado
thisform.contenido.btngrabar.Enabled = !tlestado
thisform.contenido.btnCancelar.Enabled = !tlEstado
thisform.contenido.btnFacturar.Enabled = !tlEstado
thisform.contenido.btnPres.Enabled = !tlEstado
thisform.contenido.btnVerMorosidad.Enabled = !tlEstado
thisform.contenido.btnServicios.Enabled = !tlEstado
thisform.contenido.cntBuscador.btnRestaurarFiltro.Enabled = !tlEstado
thisform.contenido.btnEliminar.Enabled = !tlEstado
ENDPROC
PROCEDURE mostrar_morosidades
LOCAL loRes, lcSql, loForm

loRes = CREATEOBJECT("odbc_result")
lcSql = ""

CREATE CURSOR cur_cbtemoro (	;
	idVentasC		int,;
	cbte			varchar(3),;
	tipoDoc			varchar(1),;
	ptoVta			varchar(4),;
	numCbte			varchar(8),;
	fecEmis			D,;
	fecVto			D,;
	saldo 			float(10, 2))


lcSql = "SELECT		ventascab.idVentasC, "
lcSql = lcSql + "	ventascab.cbte, "
lcSql = lcSql + "	ventascab.tipoDoc, "
lcSql = lcSql + "	ventascab.ptoVta, "
lcSql = lcSql + "	ventascab.numCbte, "
lcSql = lcSql + "	ventascab.fecEmision, "
lcSql = lcSql + "	ventascab.fecVto,  "
lcSql = lcSql + "	ventascab.saldo "
lcSql = lcSql + "FROM	ventascab "
lcSql = lcSql + "WHERE	" + IIF(INT(VAL(getConfig("SQLSRV"))) = 1, "GETDATE()", "current_date") + " > ventascab.fecVto "
lcSql = lcSql + "	AND ventascab.idCliente = " + ALLTRIM(STR(thisform.contenido.sel_clientes.valcpoid))
lcSql = lcSql + "	AND ventascab.idVentasC IN ( "
lcSql = lcSql + "		SELECT	MAX(idVentasC) "
lcSql = lcSql + "		FROM	cc_cli  "
lcSql = lcSql + "		WHERE	idCliente = " + ALLTRIM(STR(thisform.contenido.sel_clientes.valcpoid)) + " "
lcSql = lcSql + "		GROUP BY idOper "
lcSql = lcSql + "		HAVING (SUM(impDebe) - SUM(impHaber)) <> 0) "

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_moro"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_cbtemoro
ZAP

SELECT cur_moro
IF RECCOUNT("cur_moro") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_moro")
	SELECT cur_cbtemoro
	APPEND BLANK
	REPLACE cur_cbtemoro.idVentasC 	WITH cur_moro.idVentasC
	REPLACE cur_cbtemoro.cbte 		WITH cur_moro.cbte ADDITIVE
	REPLACE cur_cbtemoro.tipoDoc 	WITH cur_moro.tipoDoc ADDITIVE
	REPLACE cur_cbtemoro.ptoVta 	WITH REPLICATE("0", 4 - LEN(ALLTRIM(STR(cur_moro.ptoVta)))) + ALLTRIM(STR(cur_moro.ptoVta)) ADDITIVE
	REPLACE cur_cbtemoro.numCbte 	WITH REPLICATE("0", 8 - LEN(ALLTRIM(STR(cur_moro.numCbte)))) + ALLTRIM(STR(cur_moro.numCbte)) ADDITIVE
	REPLACE cur_cbtemoro.fecEmis 	WITH cur_moro.fecEmision ADDITIVE
	REPLACE cur_cbtemoro.fecVto 	WITH cur_moro.fecVto ADDITIVE
	REPLACE cur_cbtemoro.saldo 		WITH cur_moro.saldo ADDITIVE
	
	SELECT cur_moro
	SKIP
ENDDO

SELECT cur_cbtemoro
IF RECCOUNT("cur_cbtemoro") > 0 THEN
	GO TOP
	
	loForm = CREATEOBJECT("cls_cbte_moro")
	loForm.generar_registros()
	loForm.show()
ELSE
	RETURN .F.
ENDIF

USE IN cur_cbtemoro 

RETURN .T.
ENDPROC
PROCEDURE imprimir_retiro
m.idCliente = thisform.contenido.sel_clientes.txtCodigo.Value
m.RazSoc = thisform.contenido.sel_clientes.txtDescripcion.Value
m.direccion = ALLTRIM(thisform.cli_direccion)
m.telefono =  ALLTRIM(thisform.cli_telefono)

SELECT cur_RetPrint
IF RECCOUNT("cur_RetPrint") >	0 THEN
	GO TOP
	REPORT FORM "rep_retiros" TO PRINTER NOCONSOLE
ELSE
	MESSAGEBOX("No hay retiros nuevos para imprimir", 0+64, Thisform.Caption)
ENDIF
ENDPROC
PROCEDURE calcular_saldo_deudor
LOCAL loRes, lcSql

loRes = CREATEOBJECT("odbc_result")
lcSql = ""

lcSql = "SELECT		ventascab.idVentasC, "
lcSql = lcSql + "	ventascab.cbte, "
lcSql = lcSql + "	ventascab.tipoDoc, "
lcSql = lcSql + "	ventascab.ptoVta, "
lcSql = lcSql + "	ventascab.numCbte, "
lcSql = lcSql + "	ventascab.fecEmision, "
lcSql = lcSql + "	ventascab.fecVto,  "
lcSql = lcSql + "	ventascab.saldo "
lcSql = lcSql + "FROM	ventascab "
lcSql = lcSql + "WHERE ventascab.idCliente = " + ALLTRIM(STR(thisform.contenido.sel_clientes.valcpoid))
lcSql = lcSql + "	AND ventascab.idVentasC IN ( "
lcSql = lcSql + "			SELECT	MAX(idVentasC) "
lcSql = lcSql + "			FROM	cc_cli  "
lcSql = lcSql + "			WHERE	idCliente = " + ALLTRIM(STR(thisform.contenido.sel_clientes.valcpoid)) + " "
lcSql = lcSql + "			GROUP BY idOper "
lcSql = lcSql + "			HAVING (SUM(impDebe) - SUM(impHaber)) <> 0) "

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_moro"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF


thisform.saldodeudor = 0.00

SELECT cur_moro
IF RECCOUNT("cur_moro") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_moro")
	
	thisform.saldodeudor = thisform.saldodeudor + cur_moro.saldo

	SELECT cur_moro
	SKIP
ENDDO

loRes.Close_Query()

IF thisform.saldoDeudor <> 0 THEN
	thisform.contenido.lblSaldo.Caption = "Saldo Deudor: " + ALLTRIM(STR(thisform.saldoDeudor, 10, 2))
ELSE
	thisform.contenido.lblSaldo.Caption = "LIBRE DE DEUDA"
ENDIF

RETURN .T.
ENDPROC
PROCEDURE grabar_servicios
LOCAL loCommand, lcSql, lnProxID

loCommand = CREATEOBJECT("odbc_command")
lcSql = ""
lnProxID = 0

goConn.beginTransaction()

SELECT cur_servicios
IF RECCOUNT("cur_servicios") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_servicios")
	&& Si el id de servicio es cero entonces significa que es un servicio
	&& nuevo
	IF cur_servicios.idServ = 0 THEN
		lnProxID = goConn.getNextID("servicios", "idServ")
	
		lcSql = "insert into servicios ("
		lcSql = lcSql + "idServ, "
		lcSql = lcSql + "idCliente, "
		lcSql = lcSql + "idVendedor, "
		lcSql = lcSql + "descripcio, "
		lcSql = lcSql + "cantidad, "
		lcSql = lcSql + "precio, "
		lcSql = lcSql + "usuAlta, "
		lcSql = lcSql + "fecAlta, "
		lcSql = lcSql + "idHostAlta) "
		lcSql = lcSql + "values ( "
		lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_servicios.idCliente)) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_servicios.idVendedor)) + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_servicios.descripcio) + "', "
		lcSql = lcSql + ALLTRIM(STR(cur_servicios.cantidad, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_servicios.precio, 10, 2)) + ", "
		lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "		
		lcSql = lcSql + IIF(INT(VAL(getConfig("SQLSRV"))) = 1, "GETDATE()", "current_timestamp") + ", "
		lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "')"
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql

		IF !loCommand.Execute() THEN
			goConn.Rollback()
			MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
			RETURN .F.
		ENDIF
	ENDIF

	SELECT cur_servicios
	SKIP
ENDDO

&& Ahora rastreo los servicios que hay que eliminar
SELECT cur_SrvEliminar
IF RECCOUNT("cur_SrvEliminar") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_SrvEliminar")
	lcSql = "update servicios "
	lcSql = lcSql + "set usuBaja = '" + ALLTRIM(gcCodUsu) + "', "
	lcSql = lcSql + "	fecBaja = " + IIF(INT(VAL(getConfig("SQLSRV"))) = 1, "getdate(), ", "current_timestamp, ")
	lcSql = lcSql + "	idHostBaja = '" + ALLTRIM(SYS(0)) + "' "
	lcSql = lcSql + "where idServ = " + ALLTRIM(STR(cur_SrvEliminar.idServ))
	
	loCommand.CommandText = lcSql
	loCommand.ActiveConnection = goConn.ActiveConnection
	
	IF !loCommand.Execute() THEN
		goConn.Rollback()
		RETURN .F.
	ENDIF
	
	SELECT cur_SrvEliminar
	SKIP
ENDDO

goConn.Commit()

RETURN .T.
ENDPROC
PROCEDURE leer_servicios
LOCAL loRes, lcSql

lcSql = ""
loRes = CREATEOBJECT("odbc_result")

SELECT cur_servicios
ZAP

lcSql = "select servicios.*, vendedores.nombre from servicios "
lcSql = lcSql + "	inner join vendedores on vendedores.idVendedor = servicios.idVendedor "
lcSql = lcSql + " where idCliente = " + ALLTRIM(STR(thisform.contenido.sel_clientes.valcpoid))
lcSql = lcSql + " and servicios.fecFact is null and servicios.fecBaja is null"
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_temp"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_temp
IF RECCOUNT("cur_temp") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_temp")
	SELECT cur_servicios
	APPEND BLANK
	REPLACE cur_servicios.idServ WITH cur_temp.idServ
	REPLACE cur_servicios.idCliente WITH cur_temp.idCliente ADDITIVE
	REPLACE cur_servicios.descripcio WITH cur_temp.descripcio ADDITIVE
	REPLACE cur_servicios.cantidad WITH cur_temp.cantidad ADDITIVE
	REPLACE cur_servicios.precio WITH cur_temp.precio ADDITIVE
	REPLACE cur_servicios.vendedor WITH ALLTRIM(STR(cur_temp.idVendedor)) + " - " + ALLTRIM(cur_temp.nombre) ADDITIVE
	REPLACE cur_servicios.usuAlta WITH cur_temp.usuAlta ADDITIVE
	REPLACE cur_servicios.fecAlta WITH cur_temp.fecAlta ADDITIVE
	REPLACE cur_servicios.idHostAlta WITH cur_temp.idHostAlta ADDITIVE

	SELECT cur_temp
	SKIP
ENDDO

loRes.Close_Query()

SELECT cur_servicios
IF RECCOUNT("cur_servicios") > 0 THEN
	GO TOP
ENDIF

RETURN .T.

ENDPROC
PROCEDURE validar_eliminar
LOCAL lnCantSel

lnCantSel = 0

SELECT cur_Retiros
GO TOP

DO WHILE !EOF("cur_Retiros")
	IF cur_Retiros.facturar THEN
		lnCantSel = lnCantSel + 1
	ENDIF

	SELECT cur_Retiros
	SKIP
ENDDO

this.cant_sel = lnCantSel

SELECT cur_Retiros
GO TOP
IF RECCOUNT("cur_Retiros") = lnCantSel THEN
	RETURN .F.
ENDIF

RETURN .T.
ENDPROC
PROCEDURE Init
DODEFAULT()

thisform.retiros.crear_cursor()

SELECT cur_Retiros
thisform.contenido.grdDetalle.RecordSource = "cur_Retiros"
thisform.contenido.grdDetalle.alias_name = "cur_Retiros"
thisform.contenido.grdDetalle.list_controlsource = "facturar,codArt,descripcio,cantidad,fecRetiro,prVenta,nombre,nom_retiro"
thisform.contenido.grdDetalle.lista_ancho_cols = "50,100,250,70,100,100,150,150"
thisform.contenido.grdDetalle.titulos_cabeceras = "#,Código,Descripción,Cantidad,Fecha,Prec.S/IVA,vendedor,Retiró"
thisform.contenido.grdDetalle.generar_grid()
thisform.contenido.grdDetalle.Columns[1].ReadOnly = .F.

thisform.cambiar_estado(.t.)

ENDPROC
PROCEDURE validarcampos
IF !thisform.retiros.tiene_item() .AND. RECCOUNT("cur_servicios") = 0 THEN
	MESSAGEBOX("No hay ni retiros ni servicios para grabar.", 0+48, Thisform.Caption)
	thisform.contenido.sel_articulos.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

RETURN .T.
ENDPROC
PROCEDURE Load
DODEFAULT()

CREATE CURSOR cur_servicios ( ;
	selected l,;
	idServ int,;
	idCliente int,;
	idVendedor int,;
	descripcio varchar(100),;
	cantidad float(10,2),;
	precio float(10,2),;
	vendedor varchar(60),;
	usuAlta varchar(5),;
	fecAlta D,;
	idHostAlta varchar(60))
		
&& En el siguiente cursor se graban los registros que
&& se van a eliminar al grabar

CREATE CURSOR cur_SrvEliminar ( ;
	idServ int)
	
&& El siguiente cursor lo agrego para levantar los servicios
&& seleccionados que se quieren imprimir

CREATE CURSOR cur_ServPrint (	;
	idServ	int,;
	idCliente int,;
	descripcio varchar(100)	,;
	cantidad float(10,2)	,;
	precio float(10,2)		,;
	vendedor varchar(60))
	
ENDPROC


************************************************************
OBJETO: retiros
************************************************************
*** PROPIEDADES ***
Top = 504
Left = 516
Height = 17
Width = 46
Name = "retiros"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Anchor = 3
Caption = "Cliente:"
Height = 15
Left = 23
Top = 13
Width = 60
TabIndex = 19
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: sel_clientes
************************************************************
*** PROPIEDADES ***
Comment = ""
Anchor = 11
Top = 8
Left = 87
TabIndex = 1
cfieldname = 
esnumerico = .T.
nombre_campo_codigo = idCliente
nombre_campo_desc = razSoc
nombre_tabla = clientes
pkfield = idCliente
title_cols = Descripción,Nro. Fiscal
anchos_cols = 400,100
alternative_cols = nroCUIT
Name = "sel_clientes"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***
PROCEDURE recuperar_datos
&& Levanto los datos de la localidad
LOCAL loRs, lcSql

thisform.retiros.idCliente = clientes.idCliente
thisform.retiros.codcli = clientes.idCliente
thisform.retiros.printcbte = clientes.printCbte
thisform.retiros.envcbte = clientes.envCbte

loRes = CREATEOBJECT("odbc_result")
lcSql = ""

lcSql = "SELECT localidad.codPostal, localidad.descripcio, provincias.descripcio as pcia "
lcSql = lcSql + "FROM localidad INNER JOIN provincias ON localidad.idProvin = provincias.idProvin "
lcSql = lcSql + "WHERE idLocalid = " + ALLTRIM(STR(clientes.idLocalid))

loRes.Cursor_Name = "cur_loc"
loRes.ActiveConnection = goConn.ActiveConnection

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

thisform.cli_direccion = ALLTRIM(clientes.direccion) + " " + ;
	ALLTRIM(cur_loc.descripcio) + " (" + ALLTRIM(cur_loc.codPostal) + ") - " + ;
	ALLTRIM(cur_loc.pcia)
thisform.cli_telefono = ALLTRIM(clientes.telefono)

loRes.Close_Query()
ENDPROC


************************************************************
OBJETO: Clslinea1
************************************************************
*** PROPIEDADES ***
Anchor = 10
Height = 0
Left = 10
Top = 74
Width = 926
Name = "Clslinea1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Anchor = 3
Caption = "Vendedor:"
Height = 15
Left = 23
Top = 38
Width = 60
TabIndex = 20
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: sel_vendedor
************************************************************
*** PROPIEDADES ***
Anchor = 11
Top = 33
Left = 87
TabIndex = 2
esnumerico = .T.
nombre_campo_codigo = idVendedor
nombre_campo_desc = nombre
nombre_tabla = vendedores
pkfield = idVendedor
Name = "sel_vendedor"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Anchor = 3
Caption = "Artículo:"
Height = 15
Left = 23
Top = 108
Width = 60
TabIndex = 21
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: sel_articulos
************************************************************
*** PROPIEDADES ***
Anchor = 11
Top = 102
Left = 88
TabIndex = 5
nombre_campo_codigo = codArt
nombre_campo_desc = descripcio
nombre_tabla = articulos
pkfield = idArticulo
Name = "sel_articulos"
txtCodigo.MaxLength = 0
txtCodigo.autocompleta = .F.
txtCodigo.ischaracter = .T.
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Anchor = 3
Caption = "Cantidad:"
Height = 15
Left = 577
Top = 108
Width = 60
TabIndex = 22
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: txtCantidad
************************************************************
*** PROPIEDADES ***
Anchor = 3
Left = 636
TabIndex = 6
Top = 104
isinteger = .F.
isnumeric = .T.
Name = "txtCantidad"

*** METODOS ***


************************************************************
OBJETO: btnAceptar
************************************************************
*** PROPIEDADES ***
Top = 12
Left = 573
Anchor = 9
TabIndex = 3
Name = "btnAceptar"

*** METODOS ***
PROCEDURE Click
IF Thisform.contenido.sel_clientes.valcpoid = 0 THEN
	MESSAGEBOX("Debe ingresar el cliente", 0+48, Thisform.Caption)
	Thisform.contenido.sel_vendedor.txtCodigo.SetFocus()
	RETURN
ENDIF

IF Thisform.contenido.sel_vendedor.valcpoid = 0 THEN
	MESSAGEBOX("Debe ingresar el vendedor", 0+48, Thisform.Caption)
	Thisform.contenido.sel_vendedor.txtCodigo.SetFocus()
	RETURN
ENDIF

IF !thisform.retiros.leer_pendfc(clientes.idCliente) THEN
	MESSAGEBOX(thisform.retiros.error_message, 0+64, thisform.Caption)
ENDIF

thisform.contenido.grdDetalle.Refresh()

IF !thisform.leer_servicios() THEN
	RETURN
ENDIF

IF thisform.retiros.cant_item <> 0 THEN
	thisform.cambiar_estado(.f.)
	thisform.contenido.sel_vendedor.SetFocus()
ENDIF

thisform.contenido.lblSaldo.Caption = ""
IF clientes.ctrMoro THEN
	thisform.mostrar_morosidades()
ENDIF


thisform.calcular_saldo_deudor()

IF clientes.contrCM THEN
	IF thisform.saldoDeudor >= clientes.credMax THEN
		MESSAGEBOX("Este cliente ha alcanzado el límite de crédito, no se le puede otorgar más retiros", 0+48, Thisform.Caption)
		RETURN
	ENDIF
ENDIF

thisform.cambiar_estado(.f.)
&& thisform.contenido.sel_vendedor.SetFocus()
thisform.contenido.txtRetiro.SetFocus()
ENDPROC


************************************************************
OBJETO: btnAgregar
************************************************************
*** PROPIEDADES ***
Top = 83
Left = 845
Anchor = 9
TabIndex = 7
Name = "btnAgregar"

*** METODOS ***
PROCEDURE Click
LOCAL lnResp

IF thisform.contenido.sel_vendedor.valcpoid = 0 THEN
	MESSAGEBOX("Debe ingresar el vendedor", 0+48, thisform.Caption)
	thisform.contenido.sel_vendedor.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

IF thisform.contenido.sel_articulos.valcpoid = 0 THEN
	MESSAGEBOX("Debe ingresar el artículo", 0+48, thisform.Caption)
	thisform.contenido.sel_vendedor.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

IF thisform.contenido.txtCantidad.Value = 0 THEN
	MESSAGEBOX("La cantidad no puede ser 0 (cero)", 0+48, thisform.Caption)
	Thisform.contenido.txtCantidad.SetFocus()
	RETURN .F.
ENDIF

IF ALLTRIM(thisform.contenido.txtRetiro.Value) == "" THEN
	MESSAGEBOX("Debe ingresar el nombre de quién retiró la mercadería", 0+48, Thisform.Caption)
	Thisform.contenido.txtRetiro.SetFocus()
	RETURN .F.
ENDIF

IF !thisform.retiros.validar_stock(thisform.contenido.sel_articulos.valcpoid, thisform.contenido.txtCantidad.Value) THEN
	lnResp = MESSAGEBOX(thisform.retiros.error_message + ". ¿Desea registrar el retiro de todos modos?", 4+32, thisform.Caption)
	IF lnResp <> 6 THEN
		RETURN .F.
	ENDIF
ENDIF

IF !thisform.retiros.agregar_item(0, 0, thisform.contenido.sel_vendedor.valcpoid, ;
		thisform.contenido.sel_articulos.valcpoid, thisform.contenido.txtCantidad.Value, DATE(), thisform.contenido.txtRetiro.Value, .T., .T.) THEN
	MESSAGEBOX(thisform.retiros.error_message, 0+48, thisform.Caption)
	RETURN .F.
ENDIF


&& Agrego el item para imprimir

IF !thisform.retiros.agregar_item_printer(thisform.contenido.sel_vendedor.valcpoid, thisform.contenido.sel_articulos.valcpoid,; 
		thisform.contenido.txtCantidad.Value, DATE(), thisform.contenido.txtRetiro.Value, .T.) THEN
	MESSAGEBOX(thisform.retiros.error_message, 0+48, thisform.Caption)
	RETURN .F.	
ENDIF

thisform.contenido.grdDetalle.Refresh()
thisform.contenido.sel_articulos.blanquear()
thisform.contenido.txtcantidad.blanquear()
thisform.contenido.sel_articulos.txtCodigo.SetFocus()

RETURN .T.
ENDPROC


************************************************************
OBJETO: grdDetalle
************************************************************
*** PROPIEDADES ***
Anchor = 15
Height = 257
Left = 9
TabIndex = 23
Top = 129
Width = 927
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdDetalle"
COLUMN1.Header1.Name = "Header1"
COLUMN1.Text1.Name = "Text1"
COLUMN1.CurrentControl = "CLSCHECKBOX1"
COLUMN1.Sparse = .F.
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
OBJETO: CLSCHECKBOX1
************************************************************
*** PROPIEDADES ***
Top = 27
Left = 41
Alignment = 0
Caption = ""
Name = "CLSCHECKBOX1"

*** METODOS ***


************************************************************
OBJETO: btnGrabar
************************************************************
*** PROPIEDADES ***
Top = 499
Left = 717
Anchor = 6
TabIndex = 16
Name = "btnGrabar"

*** METODOS ***
PROCEDURE Click
LOCAL resp
LOCAL loForm

IF !thisform.validarcampos()
	RETURN .F.
ENDIF

&& Verifico si hay items a eliminar, si lo hay muestro los muestros y pido confirmación

SELECT cur_DelRet
IF RECCOUNT("cur_DelRet") <> 0 THEN
	loForm = CREATEOBJECT("cls_retiros_a_eliminar")
	loForm.show()
	
	IF !loForm.presiono_aceptar THEN
		RETURN .F.
	ENDIF
ENDIF

IF thisform.retiros.tiene_item() THEN
	thisform.retiros.idcliente = thisform.contenido.sel_clientes.valcpoid
	thisform.retiros.idvendedor = thisform.contenido.sel_vendedor.valcpoid

	IF !thisform.retiros.grabar_2() THEN
		RETURN .F.
	ENDIF
	
	resp = MESSAGEBOX("¿Desea imprimir el retiro?", 4+32, Thisform.Caption)
	
	IF resp = 6 THEN
		thisform.imprimir_retiro()
		thisform.imprimir_retiro()
	ENDIF

	thisform.retiros.limpiar_cursor()
	thisform.cambiar_estado(.t.)
ENDIF

SELECT cur_servicios
IF RECCOUNT("cur_servicios") > 0 THEN
	IF !thisform.grabar_servicios() THEN
		RETURN .F.
	ENDIF
ENDIF

thisform.contenido.sel_articulos.blanquear()
thisform.contenido.sel_clientes.blanquear()
thisform.contenido.sel_vendedor.blanquear()
thisform.contenido.txtCantidad.blanquear()
thisform.contenido.txtRetiro.blanquear()
Thisform.contenido.cntBuscador.txtValorBuscado.blanquear()
thisform.retiros.limpiar_cursor()
thisform.contenido.grdDetalle.Refresh()
SELECT cur_DelRet
ZAP

RETURN .T.
ENDPROC


************************************************************
OBJETO: btnCancelar
************************************************************
*** PROPIEDADES ***
Top = 499
Left = 764
Anchor = 6
TabIndex = 17
Name = "btnCancelar"

*** METODOS ***
PROCEDURE Click
thisform.contenido.sel_articulos.blanquear()
thisform.contenido.sel_clientes.blanquear()
thisform.contenido.sel_vendedor.blanquear()
thisform.contenido.txtCantidad.blanquear()
thisform.contenido.txtRetiro.blanquear()
Thisform.contenido.cntBuscador.txtValorBuscado.blanquear()
thisform.retiros.limpiar_cursor()
thisform.contenido.grdDetalle.Refresh()
thisform.cambiar_estado(.t.)
thisform.contenido.sel_clientes.txtCodigo.SetFocus()

SELECT cur_DelRet
ZAP
ENDPROC


************************************************************
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 499
Left = 892
Anchor = 12
TabIndex = 18
Name = "btnCerrar"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Anchor = 3
Caption = "Retiró:"
Height = 15
Left = 23
Top = 85
Width = 60
TabIndex = 24
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: txtRetiro
************************************************************
*** PROPIEDADES ***
Anchor = 11
Height = 21
Left = 90
MaxLength = 60
TabIndex = 4
Top = 81
Width = 646
ischaracter = .T.
Name = "txtRetiro"

*** METODOS ***


************************************************************
OBJETO: btnFacturar
************************************************************
*** PROPIEDADES ***
Top = 499
Left = 10
Height = 44
Width = 108
Anchor = 6
Caption = "FACTURAR"
TabIndex = 11
Name = "btnFacturar"

*** METODOS ***
PROCEDURE Click
LOCAL lnResp

thisform.retiros.idcliente = thisform.contenido.sel_clientes.valcpoid

IF !thisform.retiros.grabar_2() THEN
	RETURN .F.
ENDIF

SELECT cur_servicios
IF RECCOUNT("cur_servicios") > 0 THEN
	IF !thisform.grabar_servicios() THEN
		RETURN .F.
	ENDIF
ENDIF

thisform.imprimir_retiro()

lnResp = MESSAGEBOX("¿Desea cotizar este retiro?", 0+4, Thisform.Caption)

IF lnResp = 6 THEN
	thisform.retiros.facturar_x()
ELSE
	thisform.retiros.facturar()
ENDIF

thisform.contenido.sel_articulos.blanquear()
thisform.contenido.sel_clientes.blanquear()
thisform.contenido.sel_vendedor.blanquear()
thisform.contenido.txtCantidad.blanquear()
Thisform.contenido.cntBuscador.txtValorBuscado.blanquear()
thisform.retiros.limpiar_cursor()
thisform.contenido.grdDetalle.Refresh()
thisform.cambiar_estado(.t.)
thisform.contenido.sel_clientes.txtCodigo.SetFocus()
SELECT cur_DelRet
ZAP

SELECT cur_servicios
ZAP
ENDPROC


************************************************************
OBJETO: btnVerMorosidad
************************************************************
*** PROPIEDADES ***
Top = 499
Left = 230
Height = 44
Width = 108
Anchor = 6
Caption = "VER MOROSID."
TabIndex = 13
Name = "btnVerMorosidad"

*** METODOS ***
PROCEDURE Click
thisform.mostrar_morosidades()
ENDPROC


************************************************************
OBJETO: chkMarcarTodos
************************************************************
*** PROPIEDADES ***
Top = 389
Left = 9
Height = 18
Width = 256
Alignment = 0
Caption = "Marcar o desmarcar todos para facturar"
TabIndex = 9
Name = "chkMarcarTodos"

*** METODOS ***
PROCEDURE InteractiveChange
SELECT cur_retiros
IF RECCOUNT("cur_retiros") > 0 THEN
	GO TOP
ENDIF

SELECT cur_retiros
DO WHILE !EOF("cur_retiros")
	IF this.Value = 1 THEN
		SELECT cur_retiros
		LOCK()
		REPLACE cur_retiros.facturar WITH .T.
		UNLOCK
	ELSE
		LOCK()
		REPLACE cur_retiros.facturar WITH .F.
		UNLOCK
	ENDIF

    SELECT cur_retiros
    SKIP 
ENDDO

IF RECCOUNT("cur_retiros") > 0 THEN
	GO TOP
ENDIF

thisform.contenido.grdDetalle.Refresh()
ENDPROC


************************************************************
OBJETO: lblSaldo
************************************************************
*** PROPIEDADES ***
FontSize = 12
Caption = ""
Height = 24
Left = 630
Top = 13
Width = 308
TabIndex = 25
ForeColor = 255,0,0
Name = "lblSaldo"

*** METODOS ***


************************************************************
OBJETO: btnServicios
************************************************************
*** PROPIEDADES ***
Top = 499
Left = 342
Height = 44
Width = 108
Anchor = 6
Caption = "SERVICIOS"
TabIndex = 14
ToolTipText = "Haga clic aquí para ingresarle servicios al cliente"
Name = "btnServicios"

*** METODOS ***
PROCEDURE Click
LOCAL loForm


loForm = CREATEOBJECT("cls_form_ingserv")
loForm.idCliente = thisform.contenido.sel_clientes.valcpoid
loForm.cli_razSoc = thisform.contenido.sel_clientes.txtDescripcion.Value
loForm.cli_direccion = thisform.cli_direccion
loForm.cli_telefono = thisform.cli_telefono
loForm.idVendedor = Thisform.Contenido.sel_vendedor.valcpoid
loForm.show()
ENDPROC


************************************************************
OBJETO: btnPres
************************************************************
*** PROPIEDADES ***
Top = 499
Left = 120
Height = 44
Width = 108
Anchor = 6
Caption = "VALORIZAR"
TabIndex = 12
Name = "btnPres"

*** METODOS ***
PROCEDURE Click
thisform.retiros.idcliente = thisform.contenido.sel_clientes.valcpoid

IF !thisform.retiros.grabar_2() THEN
	RETURN .F.
ENDIF

thisform.imprimir_retiro()

thisform.retiros.valorizar()

thisform.contenido.sel_articulos.blanquear()
thisform.contenido.sel_clientes.blanquear()
thisform.contenido.sel_vendedor.blanquear()
thisform.contenido.txtCantidad.blanquear()
Thisform.contenido.cntBuscador.txtValorBuscado.blanquear()
thisform.retiros.limpiar_cursor()
thisform.contenido.grdDetalle.Refresh()
thisform.cambiar_estado(.t.)
thisform.contenido.sel_clientes.txtCodigo.SetFocus()
SELECT cur_DelRet
ZAP
ENDPROC


************************************************************
OBJETO: btnImprimir
************************************************************
*** PROPIEDADES ***
Top = 499
Left = 618
TabIndex = 15
Name = "btnImprimir"

*** METODOS ***
PROCEDURE Click
SELECT cur_Retiros

&& Vacío el cursor de impresión de retiros.
SELECT cur_RetPrint
ZAP

SELECT cur_Retiros
GO TOP

DO WHILE !EOF("cur_Retiros")
	IF cur_Retiros.facturar THEN
		Thisform.retiros.agregar_item_printer(cur_Retiros.idVendedor, cur_Retiros.idArticulo, cur_Retiros.cantidad, ;
			cur_Retiros.fecRetiro, cur_Retiros.nom_retiro, .F.)
	ENDIF

	SELECT cur_Retiros
	SKIP
ENDDO

SELECT cur_Retiros
GO TOP

m.idCliente = Thisform.Contenido.sel_clientes.txtCodigo.Value
m.RazSoc = Thisform.Contenido.sel_clientes.txtDescripcion.Value
m.direccion = Thisform.cli_direccion
m.telefono = thisform.cli_telefono

SELECT cur_RetPrint
GO TOP
REPORT FORM "rep_retiros" PREVIEW NOCONSOLE

Thisform.Contenido.grdDetalle.Refresh()

SELECT cur_RetPrint
ZAP
ENDPROC


************************************************************
OBJETO: btnEliminar
************************************************************
*** PROPIEDADES ***
Top = 83
Left = 892
TabIndex = 8
Name = "btnEliminar"

*** METODOS ***
PROCEDURE Click
LOCAL lnResp

IF !Thisform.validar_eliminar() THEN
	lnResp = MESSAGEBOX("ATENCION: Ha seleccionado todos los retiros, ¿está seguro que desea proceder al eliminado de todos los retiros?", 4+32, Thisform.Caption)
	
	IF lnResp <> 6 THEN
		RETURN
	ENDIF
ENDIF

IF Thisform.cant_sel = 0 THEN
	MESSAGEBOX("No ha seleccionado ningún retiro para eliminar. Seleccione los que necesita dar de baja marcando en la columna #.", 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

lnResp = MESSAGEBOX("¿Está seguro que desea eliminar los retiros seleccionados?", 4+32, Thisform.Caption)

IF lnResp = 6 THEN
	Thisform.retiros.eliminar_selected()
	Thisform.contenido.grdDetalle.Refresh()
ENDIF
ENDPROC


************************************************************
OBJETO: Clslinea2
************************************************************
*** PROPIEDADES ***
Anchor = 10
Height = 0
Left = 11
Top = 493
Width = 926
Name = "Clslinea2"

*** METODOS ***


************************************************************
OBJETO: cntBuscador
************************************************************
*** PROPIEDADES ***
Top = 409
Left = 25
Width = 910
Height = 79
TabIndex = 10
Name = "cntBuscador"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Ingresar el valor buscado:"
Height = 15
Left = 7
Top = 5
Width = 173
TabIndex = 3
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: txtValorBuscado
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 24
TabIndex = 1
ToolTipText = "El valor buscado puede ser el código de artículo o parte del mismo, o la descripción o parte de la misma del artículo."
Top = 24
Width = 564
ischaracter = .T.
Name = "txtValorBuscado"

*** METODOS ***
PROCEDURE InteractiveChange
SELECT cur_Retiros
Thisform.retiros.buscar_articulos(ALLTRIM(This.Value))
Thisform.contenido.grdDetalle.Refresh()
ENDPROC


************************************************************
OBJETO: btnRestaurarFiltro
************************************************************
*** PROPIEDADES ***
Top = 46
Left = 484
Height = 31
Width = 105
Caption = "\<Mostrar Todos"
TabIndex = 2
Name = "btnRestaurarFiltro"

*** METODOS ***
PROCEDURE Click
SELECT cur_Retiros
Thisform.retiros.buscar_articulos('')
Thisform.contenido.cntBuscador.txtValorBuscado.Value = ""
Thisform.contenido.grdDetalle.Refresh()
ENDPROC


************************************************************
OBJETO: cls_form_retiros
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cl_retiros_mercs
************************************************************
*** PROPIEDADES ***
idcliente = 0
error_message = 
cant_item = 0
idretirosel = 0
codcli = 
cbte_m2 = 
idvendedor = 0
printcbte = .F.
envcbte = .F.
Name = "cl_retiros_mercs"

*** METODOS ***
PROCEDURE agregar_item
PARAMETERS tn_idRetiroC, tn_idRetiroD, tn_idVendedor, tn_idArticulo, tn_Cantidad, td_FecRetiro, tc_NomRetiro, tl_AddStock, tlEsNUevo

LOCAL loResArt, lcSql, lnIdRetiroD
LOCAL loResVend, lnResp

loResArt = CREATEOBJECT("odbc_result")
loResVend = CREATEOBJECT("odbc_result")
lcSql = ""
lnIdRetiroD = 0
lnResp = 0

&& Si tn_idRetiroD es 0 (cero), entonces calculo el próximo id
&& sino tomo el que recibe por parámetro

IF tn_idRetiroD = 0  THEN
	SELECT MAX(cur_Retiros.idRetiroD) AS maxID FROM cur_Retiros ;
	INTO CURSOR cur_maxid
	
	SELECT cur_maxid
	IF ISNULL(cur_maxid.maxID) THEN
		tn_idRetiroD = 1
	ELSE
		tn_idRetiroD = cur_maxid.maxID + 1
	ENDIF
	
	USE IN cur_maxid
ENDIF

lcSql = "SELECT * FROM vendedores WHERE idVendedor = " + ALLTRIM(STR(tn_idVendedor))

loResVend.ActiveConnection = goConn.ActiveConnection
loResVend.Cursor_Name = "cur_vend"

IF !loResVend.OpenQuery(lcSql) THEN
	this.error_message = loResVend.Error_Message
	RETURN .F.
ENDIF

lcSql = "SELECT * FROM articulos WHERE idArticulo = " + ALLTRIM(STR(tn_idArticulo))
loResArt.ActiveConnection = goConn.ActiveConnection
loResArt.Cursor_Name = "cur_artic"

IF !loResArt.OpenQuery(lcSql) THEN
	this.error_message = loResArt.Error_Message
	RETURN .F.
ENDIF

SELECT cur_artic
IF RECCOUNT("cur_artic") > 0 THEN
	GO TOP
ELSE
	this.error_message = "El artículo no existe en la base"
	RETURN .F.
ENDIF

SELECT cur_Retiros
APPEND BLANK
REPLACE cur_Retiros.facturar	WITH .F.
REPLACE cur_Retiros.idRetiroC 	WITH tn_idRetiroC ADDITIVE
REPLACE cur_Retiros.idRetiroD 	WITH tn_idRetiroD ADDITIVE
REPLACE cur_Retiros.idArticulo 	WITH tn_idArticulo ADDITIVE
REPLACE cur_Retiros.codArt 		WITH cur_artic.codArt ADDITIVE
REPLACE cur_Retiros.descripcio 	WITH cur_artic.descripcio ADDITIVE
REPLACE cur_Retiros.idVendedor	WITH tn_idVendedor ADDITIVE
REPLACE cur_Retiros.nombre		WITH cur_vend.Nombre ADDITIVE
REPLACE cur_Retiros.cantidad	WITH tn_Cantidad ADDITIVE
REPLACE cur_Retiros.fecRetiro 	WITH td_FecRetiro ADDITIVE
REPLACE cur_Retiros.alicIVA 	WITH cur_artic.alicIVA ADDITIVE
REPLACE cur_Retiros.nom_retiro	WITH IIF(ISNULL(tc_NomRetiro), "", tc_NomRetiro) ADDITIVE
REPLACE cur_Retiros.add_stock 	WITH tl_AddStock ADDITIVE
REPLACE cur_Retiros.esNuevo		WITH tlEsNUevo ADDITIVE

IF clientes.mayorista THEN
	REPLACE cur_Retiros.prVenta WITH cur_artic.prVentaMax ADDITIVE
ELSE
	REPLACE cur_Retiros.prVenta WITH cur_artic.prVentaMin ADDITIVE
ENDIF

REPLACE cur_Retiros.cantDev	WITH 0 ADDITIVE

&& El siguiente método búsca si el artículo tiene alguna partida asignada
this.asignar_partida(cur_Retiros.idArticulo, cur_Retiros.cantidad)

loResArt.Close_Query()
loResVend.close_query()

RETURN .T.
ENDPROC
PROCEDURE crear_cursor
&& Armo el cursor de detalle correspondiente a los remitos
CREATE CURSOR cur_Retiros (	;
	facturar	L,;
	idRetiroC	int,;
	idRetiroD	int,;
	idArticulo	int,;
	codArt		varchar(20),;
	descripcio	varchar(60),;
	idVendedor	int,;
	nombre		varchar(60),;
	cantidad	float(10, 2),;
	cantFact	float(10, 2),;
	cantDev		float(10, 2),;
	fecRetiro	D,;
	alicIVA		float(10, 2),;
	prVenta		float(10, 2),;
	nom_retiro	varchar(60),;
	nroPart		varchar(30),;
	add_stock	L,;
	esNuevo		L)	&& Agrego este campo para identificar los retiros que se carguen nuevos.
	

&& Este cursor es para imprimir los retiros	
CREATE CURSOR cur_RetPrint (	;
	idRetiroC	int,;
	idRetiroD	int,;
	idArticulo	int,;
	codArt		varchar(20),;
	descripcio	varchar(60),;
	idVendedor	int,;
	nombre		varchar(60),;
	cantidad	float(10, 2),;
	cantFact	float(10, 2),;
	fecRetiro	D,;
	alicIVA		float(10, 2),;
	prVenta		float(10, 2),;
	nom_retiro	varchar(60))
	
&& Agrego este cursor por partida
CREATE CURSOR cur_DetPart (		 ;
	idArticulo	int				,;
	nroPart		varchar(30)		,;
	cantidad	float(10, 2))
	
&& Agrego un cursor para ingresar las devoluciones
&& de retiros
CREATE CURSOR cur_devret (	;
	idRetiroC	int,;
	idRetiroD	int,;
	idArticulo	int,;
	codArt		varchar(20),;
	descripcio	varchar(60),;
	cantidad	float(10, 2),;
	cantRet		float(10, 2),;
	nroPart		varchar(30))
	
&& El siguiente cursor es para identificar los retiros que hay que eliminar.

CREATE CURSOR cur_DelRet (	;
	idRetiroC	int,;
	idRetiroD	int,;
	idArticulo	int,;
	codArt		varchar(20),;
	descripcio	varchar(60),;
	cantidad	float(10,2))

ENDPROC
PROCEDURE leer_pendfc
PARAMETERS tnIdCliente

LOCAL loResCab, lcSql, loResDet
LOCAL loProg, lnCont

lcSql = ""
loResCab = CREATEOBJECT("odbc_result")
loResDet = CREATEOBJECT("odbc_result")
loProg = CREATEOBJECT("_thermometer")
lnCont = 0

loProg.Show()

&& Levanto el retiro siempre y cuando no se encuentre dado de baja, ni facturado
lcSql = lcSql + "SELECT	retiroscab.idRetiroC, "
lcSql = lcSql + "		retiroscab.idCliente, "
lcSql = lcSql + "		retiroscab.usuAlta, "
lcSql = lcSql + "		retiroscab.fecAlta, "
lcSql = lcSql + "		retiroscab.idHostAlta "
lcSql = lcSql + "FROM	retiroscab "
lcSql = lcSql + "WHERE	idCliente = " + ALLTRIM(STR(tnIdCliente)) + " "
lcSql = lcSql + "	AND fecBaja IS NULL "
lcSql = lcSql + "	AND idRetiroC IN ( "
lcSql = lcSql + "		SELECT	idRetiroC "
lcSql = lcSql + "		FROM	retirosdet "
lcSql = lcSql + "		WHERE	retirosdet.fecFact IS NULL "
lcSql = lcSql + "			AND retirosdet.idRetiroC = retiroscab.idRetiroC "
lcSql = lcSql + "			AND retirosdet.fecBaja IS NULL) "


loResCab.ActiveConnection = goConn.ActiveConnection
loResCab.Cursor_Name = "cur_retpend"

IF !loResCab.OpenQuery(lcSql) THEN
	this.error_message = loResCab.Error_Message
	RETURN .F.
ENDIF

this.idretirosel = 0

SELECT cur_retpend
IF RECCOUNT("cur_retpend") > 0 THEN
	GO TOP
	SELECT cur_retpend
	this.idcliente = tnIdCliente
	this.idretirosel = cur_retpend.idRetiroC
ELSE
	this.error_message = "No hay retiro asignado para este cliente"
	RETURN .F.
ENDIF

lcSql = "SELECT * FROM retirosdet WHERE idRetiroC = " + ALLTRIM(STR(cur_retpend.idRetiroC)) + " AND retirosdet.fecBaja IS NULL"
loResDet.ActiveConnection = goConn.ActiveConnection
loResDet.Cursor_Name = "cur_detret"

IF !loResDet.OpenQuery(lcSql) THEN
	this.error_message = loResDet.Error_Message
	RETURN .F.
ENDIF

this.cant_item = 0

SELECT cur_detret
IF RECCOUNT("cur_detret") > 0 THEN
	this.cant_item = RECCOUNT("cur_detret")
	GO TOP
ELSE 
	this.error_message = "No hay registro para mostrar"
	RETURN .F.
ENDIF

DO WHILE !EOF("cur_detret")
	IF !cur_detret.facturado THEN
		this.agregar_item(cur_detret.idRetiroC, cur_detret.idRetiroD, ;
				cur_detret.idVendedor, cur_detret.idArticulo, ;
				(cur_detret.cantidad - IIF(ISNULL(cur_detret.cantFact), 0 , cur_detret.cantFact)), ;
				cur_detret.fecRetiro, cur_detret.nom_retiro, .F., .F.)
	ENDIF
	
	lnCont = lnCont + 1
	loProg.update((lnCont * 100) / RECCOUNT("cur_detret"), "Leyendo retiro...")
	
	SELECT cur_detret
	SKIP
ENDDO

SELECT cur_retiros
IF RECCOUNT("cur_retiros") > 0 THEN
	GO TOP
ENDIF

loProg.Complete()
loResDet.Close_Query()
loResCab.Close_Query()

RETURN .T.
ENDPROC
PROCEDURE grabar
LOCAL loCommand, lcSql, loProg
LOCAL lnProxID, lnNroReng, loDT
LOCAL loStock

loStock = CREATEOBJECT("cl_mov_stock")
loDT = CREATEOBJECT("datetime")
loCommand = CREATEOBJECT("odbc_command")
lcSql = ""
loProg = CREATEOBJECT("_thermometer")
lnProxID = 0
lnNroReng = 0

loStock.crear_cursor()
loStock.tipoMov = "SAL"

goConn.BeginTransaction()

&& Si no se abrió ningún retiro, entonces, genero un número de retiro nuevo
IF this.idretirosel = 0 THEN
	lnProxID = goConn.GetNextID("retiroscab", "idRetiroC")
	
*!*		lcSql = "INSERT INTO retiroscab ( "
*!*		lcSql = lcSql + "	idRetiroC, "
*!*		lcSql = lcSql + "	idCliente, "
*!*		lcSql = lcSql + "	usuAlta, "
*!*		lcSql = lcSql + "	fecAlta, "
*!*		lcSql = lcSql + "	idHostAlta) "
*!*		lcSql = lcSql + "VALUES ( "
*!*		lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", "
*!*		lcSql = lcSql + ALLTRIM(STR(this.idcliente)) + ", "
*!*		lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
*!*		lcSql = lcSql + loDT.getDateTime() + ", "
*!*		lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "')"
	TEXT TO lcSql NOSHOW
		INSERT INTO retiroscab (
			idRetiroC,
			idCliente,
			idVendedor,
			usuAlta,
			fecAlta,
			idHostAlta)
		VALUES (
			?idRetiroC,
			?idCliente,
			?idVendedor,
			?usuAlta,
			current_timestamp,
			?idHostAlta)
	ENDTEXT

	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	loCommand.AddParameter("idRetiroC", ALLTRIM(STR(lnProxID)), .f., .f.)
	loCommand.AddParameter("idCliente", ALLTRIM(STR(this.idcliente)), .f., .f.)
	loCommand.AddParameter("idVendedor", ALLTRIM(STR(this.idVendedor)), .f., .f.)
	loCommand.AddParameter("usuAlta", ALLTRIM(gcCodUsu), .t., .f.)
	loCommand.AddParameter("idHostAlta", ALLTRIM(SYS(0)), .t., .f.)

	IF !loCommand.Execute() THEN
		goConn.Rollback()
		this.error_message = loCommand.ErrorMessage
		RETURN .F.
	ENDIF
ELSE
	lnProxID = this.idretirosel
ENDIF

&& Elimino los ítems del retiro para que los vuelva a cargar con el cursor
&& actualizado.

lcSql = "DELETE FROM retirosdet WHERE idRetiroC = " + ALLTRIM(STR(this.idretirosel))
loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = lcSql

IF !loCommand.Execute() THEN
	goConn.Rollback()
	this.error_message = loCommand.ErrorMessage
	RETURN .F.
ENDIF

SELECT cur_Retiros
IF RECCOUNT("cur_Retiros") > 0 THEN
	GO TOP
ENDIF

lnNroReng = 1
SELECT cur_Retiros
DO WHILE !EOF("cur_Retiros")
	lcSql = "INSERT INTO retirosdet ( "
	lcSql = lcSql + "	idRetiroC, "
	lcSql = lcSql + "	idRetiroD, "
	lcSql = lcSql + "	idArticulo, "
	lcSql = lcSql + "	idVendedor, "
	lcSql = lcSql + "	cantidad, "
	lcSql = lcSql + "	fecRetiro, "
	lcSql = lcSql + "	alicIVA, "
	lcSql = lcSql + "	prVenta, "
	lcSql = lcSql + "	nom_retiro, "
	lcSql = lcSql + "	usuAlta, "
	lcSql = lcSql + "	fecAlta, "
	lcSql = lcSql + "	idHostAlta) "
	lcSql = lcSql + "VALUES ( "
	lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnNroReng)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_Retiros.idArticulo)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_Retiros.idVendedor)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_Retiros.cantidad, 10, 2)) + ", "
	lcSql = lcSql + loDT.toMySql(cur_Retiros.fecRetiro) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_Retiros.alicIVA, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(cur_Retiros.prVenta, 10, 2)) + ", "
	lcSql = lcSql + "'" + ALLTRIM(cur_Retiros.nom_retiro) + "', "
	lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
	lcSql = lcSql + loDT.getDateTime() + ", "
	lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "')"
	
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute() THEN
		goConn.Rollback()
		this.error_message = loCommand.ErrorMessage
		RETURN .F.
	ENDIF
	
	&& Agrego los artículos a descontar al stock
	&& Para asignar el movimiento de stock valida si el artículo tiene alguna partida asociada
	IF cur_Retiros.add_stock THEN
		IF !this.asignar_partida(cur_Retiros.idArticulo,cur_Retiros.cantidad) THEN
			this.error_message = "Error al intentar asignar la partida"
			RETURN .F.
		ENDIF
		
		SELECT cur_DetPart
		IF RECCOUNT("cur_DetPart") = 0 THEN
			loStock.agregar_articulo(cur_Retiros.idArticulo, cur_Retiros.cantidad, '')
		ELSE
			SELECT cur_DetPart
			GO TOP
			
			DO WHILE !EOF("cur_DetPart")
				loStock.agregar_articulo(cur_DetPart.idArticulo, cur_DetPart.cantidad, cur_DetPart.nroPart)
				
				SELECT cur_DetPart
				SKIP				
			ENDDO
		ENDIF
	ENDIF

	lnNroReng = lnNroReng + 1
	
	SELECT cur_Retiros
	SKIP
ENDDO

&& Verifico si el sistema está configurado para llevar el módulo de stock
IF getGlobalCFG("STK_MODULE") THEN
	loStock.circuito = "V"
	loStock.codUsu = gcCodUsu
	loStock.idCliente = this.idcliente
	loStock.idHost = SYS(0)
	loStock.numCbte = REPLICATE("0", 8 - LEN(ALLTRIM(STR(lnProxID)))) + ALLTRIM(STR(lnProxID))
	loStock.tipoDoc = ""
	loStock.cbte = "SAL"
	
	IF !loStock.grabar2() THEN
		goConn.Rollback()
		this.error_message = loStock.errrorMessage
		RETURN .F.
	ENDIF
ENDIF

goConn.Commit()

this.idretirosel = lnProxID

RETURN .T.
ENDPROC
PROCEDURE limpiar_cursor
SELECT cur_Retiros
ZAP

SELECT cur_RetPrint
ZAP
ENDPROC
PROCEDURE eliminar_item
&& Agrego el registro para la baja de retiros
SELECT cur_DelRet
APPEND BLANK
REPLACE cur_DelRet.idRetiroC WITH cur_Retiros.idRetiroC
REPLACE cur_DelRet.idRetiroD WITH cur_Retiros.idRetiroD ADDITIVE
REPLACE cur_DelRet.idArticulo WITH cur_Retiros.idArticulo ADDITIVE
REPLACE cur_DelRet.codArt WITH cur_Retiros.codArt ADDITIVE
REPLACE cur_DelRet.descripcio WITH cur_Retiros.descripcio ADDITIVE
REPLACE cur_DelRet.cantidad WITH cur_Retiros.cantidad ADDITIVE

SELECT cur_Retiros
DELETE
ENDPROC
PROCEDURE tiene_item
SELECT cur_Retiros
IF RECCOUNT("cur_Retiros") = 0 THEN
	RETURN .F.
ENDIF

RETURN .T.
ENDPROC
PROCEDURE asignar_partida
PARAMETERS tnIdArticulo, tnCantidad

LOCAL lcSql, loResult, lnResto, lnCant

lcSql = ""
loResult = CREATEOBJECT("odbc_result")
lnResto = 0.00
lnCant = 0.00

SELECT cur_DetPart
ZAP

lcSql = "SELECT		nroPart, "
lcSql = lcSql + "	MIN(fecha) AS fecha, "
lcSql = lcSql + "	SUM(cantidad) AS totCant "
lcSql = lcSql + "FROM	stk_part "
lcSql = lcSql + "WHERE	idArticulo = " + ALLTRIM(STR(tnIdArticulo)) + " "
lcSql = lcSql + "GROUP BY nroPart "
lcSql = lcSql + "HAVING SUM(cantidad) <> 0 "
lcSql = lcSql + "ORDER BY MIN(fecha), nroPart "

loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_partida"

IF !loResult.OpenQuery(lcSql) THEN
	this.error_message = loResult.error_message
	RETURN .F.
ENDIF

lnResto = tnCantidad

SELECT cur_partida
GO TOP

DO WHILE !EOF("cur_partida") 
	IF lnResto > cur_partida.totCant THEN
		lnCant = cur_partida.totCant
		lnResto = lnResto - cur_partida.totCant
	ELSE
		lnCant = lnResto
		lnResto = lnResto - cur_partida.totCant
	ENDIF
	
	SELECT cur_DetPart
	APPEND BLANK
	REPLACE cur_DetPart.idArticulo WITH tnIdArticulo 
	REPLACE cur_DetPart.nroPart WITH cur_partida.nroPart ADDITIVE
	REPLACE cur_DetPart.cantidad WITH ROUND(lnCant, 2) ADDITIVE
		
	IF lnResto <= 0  THEN
		EXIT
	ENDIF
	
	SELECT cur_partida
	SKIP
ENDDO

&& Verifico si el resto es mayor a cero, si lo es significa que no tengo mas stock por partida 
&& y lo tengo que sacar normalmente.
SELECT cur_partida
GO TOP

IF RECCOUNT("cur_partida") > 0
	IF lnResto > 0
		SELECT cur_DetPart
		APPEND BLANK
		REPLACE cur_DetPart.idArticulo WITH tnIdArticulo 
		REPLACE cur_DetPart.nroPart WITH "" ADDITIVE
		REPLACE cur_DetPart.cantidad WITH ROUND(lnResto, 2) ADDITIVE
	ENDIF 
ENDIF 

loResult.Close_Query()

SELECT cur_DetPart
GO TOP

RETURN .T.
ENDPROC
PROCEDURE validar_stock
PARAMETERS tnIdArticulo, tnCantidad

LOCAL loResult, lcSql, lnExistencia

loResult = CREATEOBJECT("odbc_result")
lcSql = ""
lnExistencia = 0

lcSql = "SELECT	SUM(stk_det.cantidad) AS existencia "
lcSql = lcSql + "FROM	stk_det "
lcSql = lcSql + "WHERE	stk_det.idArticulo = " + ALLTRIM(STR(tnIdArticulo)) + " "
lcSql = lcSql + "GROUP BY stk_det.idArticulo"

loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_exist"

IF !loResult.OpenQuery(lcSql) THEN
	this.error_message = loResult.Error_Message
	RETURN .F.
ENDIF

SELECT cur_exist
IF RECCOUNT("cur_exist") = 0 THEN
	lnExistencia = 0
ELSE
	lnExistencia = cur_exist.existencia
ENDIF

loResult.close_query()

IF tnCantidad > lnExistencia THEN
	this.error_message = "Stock insuficiente, el stock disponible es: " + ALLTRIM(STR(lnExistencia, 10, 2))
	RETURN .F.
ENDIF

RETURN .T.

ENDPROC
PROCEDURE facturar
This.cbte_m2 = CREATEOBJECT("cls_cbtes_retiros_sf")	

This.cbte_m2.cbte = "FC"								&& Indica que tipo de comprobante se va a emitir desde la consulta de artículos.
This.cbte_m2.cerrar_cbte = .F.							&& Establece el falso la propiedad para que no se cierre el comprobante.
This.cbte_m2.pciomaydef = .F.							&& Esta propiedad indica que al cargar un ítem, tome por defecto el precio mayorista.
This.cbte_m2.Caption = "Ingreso de Facturas"			&& Establece el título de la ventana.
This.cbte_m2.printCbte = this.printcbte					&& Indica si debe imprimir el comprobante
This.cbte_m2.envCbte = this.envcbte						&& Indica si debe enviar el comprobante.
This.cbte_m2.idRetiroC = this.idretirosel

&& Pongo el número de cliente y hago que busque
This.cbte_m2.contenido.sel_cliente.txtCodigo.Value = this.codcli
This.cbte_m2.contenido.sel_cliente.txtCodigo.LostFocus()

&& Armo el cursor para enviar a facturar por idArticulo ya que si
&& se repite tengo que sumar las cantidades en la factura.

*!*	SELECT	idArticulo,;
*!*			MAX(codArt) AS codArt,;
*!*			SUM(cantidad) AS cantidad ;
*!*	FROM 	cur_Retiros ;
*!*	WHERE	cur_Retiros.facturar = .T. ;
*!*	GROUP BY idArticulo ;
*!*	INTO CURSOR cur_RetFact;

SELECT	idArticulo,;
		codArt,;
		cantidad ;
FROM 	cur_Retiros ;
WHERE	cur_Retiros.facturar = .T. ;
INTO CURSOR cur_RetFact;

SELECT cur_RetFact
IF RECCOUNT("cur_RetFact") = 0 THEN
	this.error_message = "No se puede facturar, no hay ítem(s) seleccionado(s)"
ELSE 
	GO TOP
ENDIF

DO WHILE !EOF("cur_RetFact")
	this.cbte_m2.contenido.sel_articulo.txtCodigo.value = cur_RetFact.codArt
	this.cbte_m2.contenido.sel_articulo.txtCodigo.LostFocus()
	this.cbte_m2.contenido.txtCantidad.value = cur_RetFact.cantidad
	this.cbte_m2.contenido.txtCantidad.LostFocus()
	&& this.cbte_m2.contenido.btnAgregar.Click()
	this.cbte_m2.add_desde_retiro()

	SELECT cur_RetFact
	SKIP
ENDDO

this.cbte_m2.agregar_servicios()

this.cbte_m2.contenido.sel_articulo.txtCodigo.value = ""
this.cbte_m2.contenido.sel_articulo.txtCodigo.LostFocus()
this.cbte_m2.contenido.sel_vendedor.txtCodigo.SetFocus()

USE IN cur_RetFact

this.cbte_m2.show()

SELECT cur_Retiros
SET FILTER TO


ENDPROC
PROCEDURE agregar_item_printer
PARAMETERS tn_idVendedor, tn_idArticulo, tn_Cantidad, td_FecRetiro, tc_NomRetiro, tl_AddStock

LOCAL loResArt, lcSql, lnIdRetiroD
LOCAL loResVend, lnResp

loResArt = CREATEOBJECT("odbc_result")
loResVend = CREATEOBJECT("odbc_result")
lcSql = ""
lnIdRetiroD = 0
lnResp = 0

lcSql = "SELECT * FROM vendedores WHERE idVendedor = " + ALLTRIM(STR(tn_idVendedor))

loResVend.ActiveConnection = goConn.ActiveConnection
loResVend.Cursor_Name = "cur_vend"

IF !loResVend.OpenQuery(lcSql) THEN
	this.error_message = loResVend.Error_Message
	RETURN .F.
ENDIF

lcSql = "SELECT * FROM articulos WHERE idArticulo = " + ALLTRIM(STR(tn_idArticulo))
loResArt.ActiveConnection = goConn.ActiveConnection
loResArt.Cursor_Name = "cur_artic"

IF !loResArt.OpenQuery(lcSql) THEN
	this.error_message = loResArt.Error_Message
	RETURN .F.
ENDIF

SELECT cur_artic
IF RECCOUNT("cur_artic") > 0 THEN
	GO TOP
ELSE
	this.error_message = "El artículo no existe en la base"
	RETURN .F.
ENDIF

SELECT cur_RetPrint
APPEND BLANK
REPLACE cur_RetPrint.codArt 	WITH cur_artic.codArt ADDITIVE
REPLACE cur_RetPrint.descripcio	WITH cur_artic.descripcio ADDITIVE
REPLACE cur_RetPrint.idVendedor	WITH tn_idVendedor ADDITIVE
REPLACE cur_RetPrint.nombre		WITH cur_vend.Nombre ADDITIVE
REPLACE cur_RetPrint.cantidad	WITH tn_Cantidad ADDITIVE
REPLACE cur_RetPrint.fecRetiro 	WITH DATE() ADDITIVE
REPLACE cur_RetPrint.alicIVA 	WITH cur_artic.alicIVA ADDITIVE
REPLACE cur_RetPrint.nom_retiro	WITH IIF(ISNULL(tc_NomRetiro), "", tc_NomRetiro) ADDITIVE

IF clientes.mayorista THEN
	REPLACE cur_RetPrint.prVenta WITH cur_artic.prVentaMax ADDITIVE
ELSE
	REPLACE cur_RetPrint.prVenta WITH cur_artic.prVentaMin ADDITIVE
ENDIF

loResArt.Close_Query()
loResVend.close_query()

RETURN .T.
ENDPROC
PROCEDURE dar_baja
LOCAL lcSql, loCommand, loStock

lcSql = ""
loCommand = CREATEOBJECT("odbc_command")
loStock = CREATEOBJECT("cl_mov_stock")
lnCantReg = 0

SELECT cur_devret
IF RECCOUNT("cur_devret") = 0 THEN
	this.error_message = "No hay devoluciones cargadas"
	RETURN .F.
ENDIF

loStock.crear_cursor()

goConn.BeginTransaction()

SELECT cur_devret
GO TOP

DO WHILE !EOF("cur_devret")
	IF cur_devret.cantidad = cur_devret.cantRet THEN
		lcSql = "update retirosdet set cantidad = 0, "
		lcSql = lcSql + "	 	usuBaja = '" + ALLTRIM(gcCodUsu) + "', "
		lcSql = lcSql + "		fecBaja = " + IIF(INT(VAL(getConfig("SQLSRV"))) = 1, "GETDATE(), ", "current_date, ")
		lcSql = lcSql + "		idHostBaja = '" + SYS(0) + "' "
		lcSql = lcSql + "where idRetiroD = " + ALLTRIM(STR(cur_devret.idRetiroD)) + " "
		lcSql = lcSql + "	and idRetiroC = " + ALLTRIM(STR(this.idretirosel))
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			this.error_message = loCommand.ErrorMessage
			goConn.Rollback()
			RETURN .F.
		ENDIF
	ELSE
		IF cur_devret.cantidad < cur_devret.cantRet THEN
			lcSql = "update retirosdet set "
			lcSql = lcSql + "cantidad = " + ALLTRIM(STR(cur_devret.cantRet - cur_devret.cantidad, 10, 2)) + ", "
			lcSql = lcSql + "	 	usuModi = '" + ALLTRIM(gcCodUsu) + "', "
			lcSql = lcSql + "		fecModi = " + IIF(INT(VAL(getConfig("SQLSRV"))) = 1, "GETDATE(), ", "current_date, ")
			lcSql = lcSql + "		idHostModi = '" + SYS(0) + "' "			
			lcSql = lcSql + "where idRetiroD = " + ALLTRIM(STR(cur_devret.idRetiroD)) + " "
			lcSql = lcSql + "	and idRetiroC = " + ALLTRIM(STR(this.idretirosel))
			
			loCommand.ActiveConnection = goConn.ActiveConnection
			loCommand.CommandText = lcSql
			
			IF !loCommand.Execute() THEN
				this.error_message = loCommand.ErrorMessage
				goConn.Rollback()
				RETURN .F.
			ENDIF
		ELSE
			this.error_message = "La cantidad de la devolución no puede ser superior a la retirada"
			goConn.Rollback()
			RETURN .F.
		ENDIF
	ENDIF
	
	loStock.agregar_articulo(cur_devret.idArticulo, cur_devret.cantidad, cur_devret.nroPart)
	
	SELECT cur_devret
	SKIP
ENDDO

&& Verifico si el sistema está configurado para llevar el módulo de stock
IF getGlobalCFG("STK_MODULE") THEN
	loStock.circuito = "V"
	loStock.codUsu = gcCodUsu
	loStock.idCliente = this.idcliente
	loStock.idHost = SYS(0)
	loStock.numCbte = ""
	loStock.tipoDoc = ""
	loStock.cbte = "ENT"

	IF !loStock.grabar2() THEN
		goConn.Rollback()
		this.error_message = loStock.errrorMessage
		RETURN .F.
	ENDIF
ENDIF

goConn.Commit()
RETURN .T.

ENDPROC
PROCEDURE agregar_devolucion
PARAMETERS ;	
	tnIdRetiroD, 	;
	tnIdRetiroC, 	;
	tnIdArticulo,	;
	tcCodArt,		;
	tcDescripcio,	;
	tnCantidad
	
SELECT cur_devret
APPEND BLANK
REPLACE cur_devret.idRetiroD WITH tnIdRetiroD
REPLACE cur_devret.idRetiroC WITH tnIdRetiroC ADDITIVE
REPLACE cur_devret.idArticulo WITH tnIdArticulo ADDITIVE
REPLACE cur_devret.codArt WITH ALLTRIM(tcCodArt) ADDITIVE
REPLACE cur_devret.descripcio WITH ALLTRIM(tcDescripcio) ADDITIVE
REPLACE cur_devret.cantidad WITH tnCantidad ADDITIVE


ENDPROC
PROCEDURE facturar_x
This.cbte_m2 = CREATEOBJECT("cls_pto_retiros")	

This.cbte_m2.cbte = "PTO"
This.cbte_m2.cerrar_cbte = .F.			&& Establece el falso la propiedad para que no se cierre el comprobante.
This.cbte_m2.pciomaydef = .F.			&& Esta propiedad indica que al cargar un ítem, tome por defecto el precio mayorista.
This.cbte_m2.Caption = "Cotización"		&& Establece el título de la ventana.

This.cbte_m2.idRetiroC = this.idretirosel

&& Pongo el número de cliente y hago que busque
This.cbte_m2.contenido.sel_cliente.txtCodigo.Value = this.codcli
This.cbte_m2.contenido.sel_cliente.txtCodigo.LostFocus()

&& Armo el cursor para enviar a facturar por idArticulo ya que si
&& se repite tengo que sumar las cantidades en la factura.

SELECT	idArticulo,;
		MAX(codArt) AS codArt,;
		SUM(cantidad) AS cantidad ;
FROM 	cur_Retiros ;
WHERE	cur_Retiros.facturar = .T. ;
GROUP BY idArticulo ;
INTO CURSOR cur_RetFact;

SELECT cur_RetFact
IF RECCOUNT("cur_RetFact") = 0 THEN
	this.error_message = "No se puede facturar, no hay ítem(s) seleccionado(s)"
ELSE 
	GO TOP
ENDIF

DO WHILE !EOF("cur_RetFact")
	this.cbte_m2.contenido.sel_articulo.txtCodigo.value = cur_RetFact.codArt
	this.cbte_m2.contenido.sel_articulo.txtCodigo.LostFocus()
	this.cbte_m2.contenido.txtCantidad.value = cur_RetFact.cantidad
	this.cbte_m2.contenido.txtCantidad.LostFocus()
	&& this.cbte_m2.contenido.btnAgregar.Click()
	this.cbte_m2.add_desde_retiro()

	SELECT cur_RetFact
	SKIP
ENDDO

this.cbte_m2.agregar_servicios()

this.cbte_m2.contenido.sel_articulo.txtCodigo.value = ""
this.cbte_m2.contenido.sel_articulo.txtCodigo.LostFocus()
this.cbte_m2.contenido.sel_vendedor.txtCodigo.setfocus()

USE IN cur_RetFact

this.cbte_m2.show()

SELECT cur_Retiros
SET FILTER TO

ENDPROC
PROCEDURE valorizar
This.cbte_m2 = CREATEOBJECT("cls_cotizador_retiros")	

*This.cbte_m2.cbte = "COT"
This.cbte_m2.cbte = "PED"
This.cbte_m2.cerrar_cbte = .F.					&& Establece el falso la propiedad para que no se cierre el comprobante.
This.cbte_m2.pciomaydef = .F.					&& Esta propiedad indica que al cargar un ítem, tome por defecto el precio mayorista.
This.cbte_m2.Caption = "Ingreso de Pedidos"		&& Establece el título de la ventana.

This.cbte_m2.idRetiroC = this.idretirosel

&& Pongo el número de cliente y hago que busque
This.cbte_m2.contenido.sel_cliente.txtCodigo.Value = this.codcli
This.cbte_m2.contenido.sel_cliente.txtCodigo.LostFocus()

&& Armo el cursor para enviar a facturar por idArticulo ya que si
&& se repite tengo que sumar las cantidades en la factura.

SELECT	idArticulo,;
		MAX(codArt) AS codArt,;
		SUM(cantidad) AS cantidad ;
FROM 	cur_Retiros ;
WHERE	cur_Retiros.facturar = .T. ;
GROUP BY idArticulo ;
INTO CURSOR cur_RetFact;

SELECT cur_RetFact
IF RECCOUNT("cur_RetFact") = 0 THEN
	this.error_message = "No se puede valorizar, no hay ítem(s) seleccionado(s)"
ELSE 
	GO TOP
ENDIF

DO WHILE !EOF("cur_RetFact")
	this.cbte_m2.contenido.sel_articulo.txtCodigo.value = cur_RetFact.codArt
	this.cbte_m2.contenido.sel_articulo.txtCodigo.LostFocus()
	this.cbte_m2.contenido.txtCantidad.value = cur_RetFact.cantidad
	this.cbte_m2.contenido.txtCantidad.LostFocus()
	&& this.cbte_m2.contenido.btnAgregar.Click()
	this.cbte_m2.add_desde_retiro()

	SELECT cur_RetFact
	SKIP
ENDDO

this.cbte_m2.agregar_servicios()

this.cbte_m2.contenido.sel_articulo.txtCodigo.value = "0000"
this.cbte_m2.contenido.sel_articulo.txtCodigo.LostFocus()
this.cbte_m2.contenido.btnGrabar.setfocus()

USE IN cur_RetFact

this.cbte_m2.show()

SELECT cur_Retiros
SET FILTER TO

ENDPROC
PROCEDURE buscar_articulos
&& Este método permite localizar artículos puntuales dentro de un
&& retiro
&& Si el parametro tcValorBuscado es vacío, entonces, deshabilita el filtro aplicado
PARAMETERS tcValorBuscado
LOCAL lcExpresion

lcExpresion = ""

IF ALLTRIM(tcValorBuscado) == "" THEN
	SELECT cur_Retiros
	SET FILTER TO
ELSE
	lcExpresion = "LIKE('*" + tcValorBuscado + "*', cur_Retiros.codArt) "
	lcExpresion = lcExpresion + " .OR. LIKE('*" + tcValorBuscado + "*', cur_Retiros.descripcio) "
	lcExpresion = lcExpresion + " .OR. LIKE ('*" +  tcValorBuscado + "*', cur_Retiros.nombre) "
	lcExpresion = lcExpresion + " .OR. LIKE ('*" + tcValorBuscado + "*', cur_Retiros.nom_retiro) "

	SELECT cur_Retiros
	SET FILTER TO &lcExpresion
ENDIF
	

ENDPROC
PROCEDURE grabar_2
LOCAL loCommand, lcSql, loProg
LOCAL lnProxID, lnNroReng, loDT
LOCAL loStock, loRes

loStock = CREATEOBJECT("cl_mov_stock")
loDT = CREATEOBJECT("datetime")
loCommand = CREATEOBJECT("odbc_command")
loRes = CREATEOBJECT("odbc_result")
lcSql = ""
loProg = CREATEOBJECT("_thermometer")
lnProxID = 0
lnNroReng = 0

loStock.crear_cursor()
loStock.tipoMov = "SAL"

goConn.BeginTransaction()

&& Si no se abrió ningún retiro, entonces, genero un número de retiro nuevo
IF this.idretirosel = 0 THEN
	lnProxID = goConn.GetNextID("retiroscab", "idRetiroC")
	
	TEXT TO lcSql NOSHOW
		INSERT INTO retiroscab (
			idRetiroC,
			idCliente,
			idVendedor,
			usuAlta,
			fecAlta,
			idHostAlta)
		VALUES (
			?idRetiroC,
			?idCliente,
			?idVendedor,
			?usuAlta,
			current_timestamp,
			?idHostAlta)
	ENDTEXT

	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	loCommand.AddParameter("idRetiroC", ALLTRIM(STR(lnProxID)), .f., .f.)
	loCommand.AddParameter("idCliente", ALLTRIM(STR(this.idcliente)), .f., .f.)
	loCommand.AddParameter("idVendedor", ALLTRIM(STR(this.idVendedor)), .f., .f.)
	loCommand.AddParameter("usuAlta", ALLTRIM(gcCodUsu), .t., .f.)
	loCommand.AddParameter("idHostAlta", ALLTRIM(SYS(0)), .t., .f.)

	IF !loCommand.Execute() THEN
		goConn.Rollback()
		this.error_message = loCommand.ErrorMessage
		RETURN .F.
	ENDIF
ELSE
	lnProxID = this.idretirosel
ENDIF

&& Procedo al eliminado lógico de los retiros a eliminar.
SELECT cur_DelRet
GO TOP

DO WHILE !EOF("cur_DelRet")
	lcSql = "UPDATE retirosdet "
	lcSql = lcSql + "SET usuBaja = '" + ALLTRIM(gcCodUsu) + "', "
	lcSql = lcSql + "	fecBaja = current_timestamp, "
	lcSql = lcSql + "	idHostBaja = '" + SYS(0) + "' "
	lcSql = lcSql + "WHERE idRetiroC = " + ALLTRIM(STR(cur_DelRet.idRetiroC)) + " "
	lcSql = lcSql + "	AND idRetiroD = " + ALLTRIM(STR(cur_DelRet.idRetiroD)) + " "
	lcSql = lcSql + "	AND idArticulo = " + ALLTRIM(STR(cur_DelRet.idArticulo)) + " "

	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute() THEN
		goConn.Rollback()
		This.error_message = loCommand.ErrorMessage
		RETURN .F.
	ENDIF

	SELECT cur_DelRet
	SKIP
ENDDO

SELECT cur_Retiros
IF RECCOUNT("cur_Retiros") > 0 THEN
	GO TOP
ENDIF

lnNroReng = 1
SELECT cur_Retiros
DO WHILE !EOF("cur_Retiros")
	IF cur_Retiros.esNuevo THEN
		&& Tengo que calcular el proximo número de renglon
		lcSql = "SELECT MAX(idRetiroD) AS maxID FROM retirosdet WHERE idRetiroC = " + ALLTRIM(STR(lnProxID))
		loRes.ActiveConnection = goConn.ActiveConnection
		loRes.Cursor_Name = "cur_max"
		
		IF !loRes.OpenQuery(lcSql) THEN
			MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
			RETURN .F.
		ENDIF
		
		IF ISNULL(cur_max.maxID) THEN
			lnNroReng = 1
		ELSE
			lnNroReng = cur_max.maxID + 1
		ENDIF
		
		loRes.Close_Query()
	
		lcSql = "INSERT INTO retirosdet ( "
		lcSql = lcSql + "	idRetiroC, "
		lcSql = lcSql + "	idRetiroD, "
		lcSql = lcSql + "	idArticulo, "
		lcSql = lcSql + "	idVendedor, "
		lcSql = lcSql + "	cantidad, "
		lcSql = lcSql + "	fecRetiro, "
		lcSql = lcSql + "	alicIVA, "
		lcSql = lcSql + "	prVenta, "
		lcSql = lcSql + "	nom_retiro, "
		lcSql = lcSql + "	usuAlta, "
		lcSql = lcSql + "	fecAlta, "
		lcSql = lcSql + "	idHostAlta) "
		lcSql = lcSql + "VALUES ( "
		lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", "
		lcSql = lcSql + ALLTRIM(STR(lnNroReng)) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_Retiros.idArticulo)) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_Retiros.idVendedor)) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_Retiros.cantidad, 10, 2)) + ", "
		lcSql = lcSql + loDT.toMySql(cur_Retiros.fecRetiro) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_Retiros.alicIVA, 10, 2)) + ", "
		lcSql = lcSql + ALLTRIM(STR(cur_Retiros.prVenta, 10, 2)) + ", "
		lcSql = lcSql + "'" + ALLTRIM(cur_Retiros.nom_retiro) + "', "
		lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', "
		lcSql = lcSql + loDT.getDateTime() + ", "
		lcSql = lcSql + "'" + ALLTRIM(SYS(0)) + "')"
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			this.error_message = loCommand.ErrorMessage
			RETURN .F.
		ENDIF
		
		&& Agrego los artículos a descontar al stock
		&& Para asignar el movimiento de stock valida si el artículo tiene alguna partida asociada
		IF cur_Retiros.add_stock THEN
			IF !this.asignar_partida(cur_Retiros.idArticulo,cur_Retiros.cantidad) THEN
				this.error_message = "Error al intentar asignar la partida"
				RETURN .F.
			ENDIF
			
			SELECT cur_DetPart
			IF RECCOUNT("cur_DetPart") = 0 THEN
				loStock.agregar_articulo(cur_Retiros.idArticulo, cur_Retiros.cantidad, '')
			ELSE
				SELECT cur_DetPart
				GO TOP
				
				DO WHILE !EOF("cur_DetPart")
					loStock.agregar_articulo(cur_DetPart.idArticulo, cur_DetPart.cantidad, cur_DetPart.nroPart)
					
					SELECT cur_DetPart
					SKIP				
				ENDDO
			ENDIF
		ENDIF
	ENDIF

	lnNroReng = lnNroReng + 1
	
	SELECT cur_Retiros
	SKIP
ENDDO

&& Verifico si el sistema está configurado para llevar el módulo de stock
IF getGlobalCFG("STK_MODULE") THEN
	loStock.circuito = "V"
	loStock.codUsu = gcCodUsu
	loStock.idCliente = this.idcliente
	loStock.idHost = SYS(0)
	loStock.numCbte = REPLICATE("0", 8 - LEN(ALLTRIM(STR(lnProxID)))) + ALLTRIM(STR(lnProxID))
	loStock.tipoDoc = ""
	loStock.cbte = "SAL"
	
	IF !loStock.grabar2() THEN
		goConn.Rollback()
		this.error_message = loStock.errrorMessage
		RETURN .F.
	ENDIF
ENDIF

goConn.Commit()

this.idretirosel = lnProxID

RETURN .T.
ENDPROC
PROCEDURE eliminar_selected
SELECT cur_Retiros
GO TOP

DO WHILE !EOF("cur_Retiros")
	IF cur_Retiros.facturar THEN
		SELECT cur_DelRet
		APPEND BLANK
		REPLACE cur_DelRet.idRetiroC WITH cur_Retiros.idRetiroC
		REPLACE cur_DelRet.idRetiroD WITH cur_Retiros.idRetiroD ADDITIVE
		REPLACE cur_DelRet.idArticulo WITH cur_Retiros.idArticulo ADDITIVE
		REPLACE cur_DelRet.codArt WITH cur_Retiros.codArt ADDITIVE
		REPLACE cur_DelRet.descripcio WITH cur_Retiros.descripcio ADDITIVE
		REPLACE cur_DelRet.cantidad WITH cur_Retiros.cantidad ADDITIVE		
		
		SELECT cur_Retiros
		DELETE
		
	ENDIF	

	SELECT cur_Retiros
	SKIP
ENDDO

SELECT cur_Retiros
GO TOP
ENDPROC


************************************************************
OBJETO: cls_cbtes_retiros_sf
************************************************************
*** PROPIEDADES ***
DataSession = 1
DoCreate = .T.
Comment = ""
WindowType = 1
cerrar_cbte = .F.
idretiroc = 0
aut_numero = 
aut_cae = 
aut_cae_vto = 
aut_resultado = 
aut_motivo = 
id_ventasc = 0
Name = "cls_cbtes_retiros_sf"
CONTENIDO.Clsetiqueta1.Left = 9
CONTENIDO.Clsetiqueta1.Top = 11
CONTENIDO.Clsetiqueta1.TabIndex = 35
CONTENIDO.Clsetiqueta1.Name = "Clsetiqueta1"
CONTENIDO.SEL_CLIENTE.txtCodigo.Name = "txtCodigo"
CONTENIDO.SEL_CLIENTE.txtDescripcion.Name = "txtDescripcion"
CONTENIDO.SEL_CLIENTE.Top = 4
CONTENIDO.SEL_CLIENTE.Left = 111
CONTENIDO.SEL_CLIENTE.TabIndex = 1
CONTENIDO.SEL_CLIENTE.alternative_cols = nroCUIT
CONTENIDO.SEL_CLIENTE.anchos_cols = 400,100
CONTENIDO.SEL_CLIENTE.title_cols = Descripción,Nro. Fiscal
CONTENIDO.SEL_CLIENTE.Name = "SEL_CLIENTE"
CONTENIDO.Clsetiqueta2.Left = 9
CONTENIDO.Clsetiqueta2.Top = 33
CONTENIDO.Clsetiqueta2.TabIndex = 37
CONTENIDO.Clsetiqueta2.Name = "Clsetiqueta2"
CONTENIDO.Clsetiqueta3.Left = 10
CONTENIDO.Clsetiqueta3.Top = 56
CONTENIDO.Clsetiqueta3.TabIndex = 38
CONTENIDO.Clsetiqueta3.Name = "Clsetiqueta3"
CONTENIDO.TXTSITIVA.Left = 113
CONTENIDO.TXTSITIVA.TabIndex = 28
CONTENIDO.TXTSITIVA.Top = 29
CONTENIDO.TXTSITIVA.Name = "TXTSITIVA"
CONTENIDO.SEL_FORMAPAGO.txtCodigo.Name = "txtCodigo"
CONTENIDO.SEL_FORMAPAGO.txtDescripcion.Name = "txtDescripcion"
CONTENIDO.SEL_FORMAPAGO.Top = 50
CONTENIDO.SEL_FORMAPAGO.Left = 111
CONTENIDO.SEL_FORMAPAGO.TabIndex = 3
CONTENIDO.SEL_FORMAPAGO.Name = "SEL_FORMAPAGO"
CONTENIDO.CLSLINEA1.Left = 8
CONTENIDO.CLSLINEA1.Top = 134
CONTENIDO.CLSLINEA1.Name = "CLSLINEA1"
CONTENIDO.Clsetiqueta4.Left = 9
CONTENIDO.Clsetiqueta4.Top = 145
CONTENIDO.Clsetiqueta4.TabIndex = 39
CONTENIDO.Clsetiqueta4.Name = "Clsetiqueta4"
CONTENIDO.SEL_ARTICULO.txtCodigo.Alignment = 3
CONTENIDO.SEL_ARTICULO.txtCodigo.MaxLength = 0
CONTENIDO.SEL_ARTICULO.txtCodigo.ischaracter = .T.
CONTENIDO.SEL_ARTICULO.txtCodigo.autocompleta = .F.
CONTENIDO.SEL_ARTICULO.txtCodigo.Name = "txtCodigo"
CONTENIDO.SEL_ARTICULO.txtDescripcion.Name = "txtDescripcion"
CONTENIDO.SEL_ARTICULO.Top = 139
CONTENIDO.SEL_ARTICULO.Left = 112
CONTENIDO.SEL_ARTICULO.TabIndex = 10
CONTENIDO.SEL_ARTICULO.Name = "SEL_ARTICULO"
CONTENIDO.Clsetiqueta5.Left = 853
CONTENIDO.Clsetiqueta5.Top = 145
CONTENIDO.Clsetiqueta5.TabIndex = 41
CONTENIDO.Clsetiqueta5.Name = "Clsetiqueta5"
CONTENIDO.TXTCANTIDAD.Left = 911
CONTENIDO.TXTCANTIDAD.TabIndex = 12
CONTENIDO.TXTCANTIDAD.Top = 141
CONTENIDO.TXTCANTIDAD.Name = "TXTCANTIDAD"
CONTENIDO.btnAgregar.Top = 198
CONTENIDO.btnAgregar.Left = 904
CONTENIDO.btnAgregar.TabIndex = 18
CONTENIDO.btnAgregar.Name = "btnAgregar"
CONTENIDO.GRDDETALLES.COLUMN1.Header1.Name = "Header1"
CONTENIDO.GRDDETALLES.COLUMN1.Text1.Name = "Text1"
CONTENIDO.GRDDETALLES.COLUMN1.Name = "COLUMN1"
CONTENIDO.GRDDETALLES.COLUMN2.Header1.Name = "Header1"
CONTENIDO.GRDDETALLES.COLUMN2.Text1.Name = "Text1"
CONTENIDO.GRDDETALLES.COLUMN2.Name = "COLUMN2"
CONTENIDO.GRDDETALLES.COLUMN3.Header1.Name = "Header1"
CONTENIDO.GRDDETALLES.COLUMN3.Text1.Name = "Text1"
CONTENIDO.GRDDETALLES.COLUMN3.Name = "COLUMN3"
CONTENIDO.GRDDETALLES.COLUMN4.Header1.Name = "Header1"
CONTENIDO.GRDDETALLES.COLUMN4.Text1.Name = "Text1"
CONTENIDO.GRDDETALLES.COLUMN4.Name = "COLUMN4"
CONTENIDO.GRDDETALLES.COLUMN5.Header1.Name = "Header1"
CONTENIDO.GRDDETALLES.COLUMN5.Text1.Name = "Text1"
CONTENIDO.GRDDETALLES.COLUMN5.Name = "COLUMN5"
CONTENIDO.GRDDETALLES.COLUMN6.Header1.Name = "Header1"
CONTENIDO.GRDDETALLES.COLUMN6.Text1.Name = "Text1"
CONTENIDO.GRDDETALLES.COLUMN6.Name = "COLUMN6"
CONTENIDO.GRDDETALLES.COLUMN7.Header1.Name = "Header1"
CONTENIDO.GRDDETALLES.COLUMN7.Text1.Name = "Text1"
CONTENIDO.GRDDETALLES.COLUMN7.Name = "COLUMN7"
CONTENIDO.GRDDETALLES.COLUMN8.Header1.Name = "Header1"
CONTENIDO.GRDDETALLES.COLUMN8.Text1.Name = "Text1"
CONTENIDO.GRDDETALLES.COLUMN8.Name = "COLUMN8"
CONTENIDO.GRDDETALLES.COLUMN9.Header1.Name = "Header1"
CONTENIDO.GRDDETALLES.COLUMN9.Text1.Name = "Text1"
CONTENIDO.GRDDETALLES.COLUMN9.Name = "COLUMN9"
CONTENIDO.GRDDETALLES.COLUMN10.Header1.Name = "Header1"
CONTENIDO.GRDDETALLES.COLUMN10.Text1.Name = "Text1"
CONTENIDO.GRDDETALLES.COLUMN10.Name = "COLUMN10"
CONTENIDO.GRDDETALLES.COLUMN11.Header1.Name = "Header1"
CONTENIDO.GRDDETALLES.COLUMN11.Text1.Name = "Text1"
CONTENIDO.GRDDETALLES.COLUMN11.Name = "COLUMN11"
CONTENIDO.GRDDETALLES.COLUMN12.Header1.Name = "Header1"
CONTENIDO.GRDDETALLES.COLUMN12.Text1.Name = "Text1"
CONTENIDO.GRDDETALLES.COLUMN12.Name = "COLUMN12"
CONTENIDO.GRDDETALLES.COLUMN13.Header1.Name = "Header1"
CONTENIDO.GRDDETALLES.COLUMN13.Text1.Name = "Text1"
CONTENIDO.GRDDETALLES.COLUMN13.Name = "COLUMN13"
CONTENIDO.GRDDETALLES.COLUMN14.Header1.Name = "Header1"
CONTENIDO.GRDDETALLES.COLUMN14.Text1.Name = "Text1"
CONTENIDO.GRDDETALLES.COLUMN14.Name = "COLUMN14"
CONTENIDO.GRDDETALLES.COLUMN15.Header1.Name = "Header1"
CONTENIDO.GRDDETALLES.COLUMN15.Text1.Name = "Text1"
CONTENIDO.GRDDETALLES.COLUMN15.Name = "COLUMN15"
CONTENIDO.GRDDETALLES.COLUMN16.Header1.Name = "Header1"
CONTENIDO.GRDDETALLES.COLUMN16.Text1.Name = "Text1"
CONTENIDO.GRDDETALLES.COLUMN16.Name = "COLUMN16"
CONTENIDO.GRDDETALLES.COLUMN17.Header1.Name = "Header1"
CONTENIDO.GRDDETALLES.COLUMN17.Text1.Name = "Text1"
CONTENIDO.GRDDETALLES.COLUMN17.Name = "COLUMN17"
CONTENIDO.GRDDETALLES.COLUMN18.Header1.Name = "Header1"
CONTENIDO.GRDDETALLES.COLUMN18.Text1.Name = "Text1"
CONTENIDO.GRDDETALLES.COLUMN18.Name = "COLUMN18"
CONTENIDO.GRDDETALLES.COLUMN19.Header1.Name = "Header1"
CONTENIDO.GRDDETALLES.COLUMN19.Text1.Name = "Text1"
CONTENIDO.GRDDETALLES.COLUMN19.Name = "COLUMN19"
CONTENIDO.GRDDETALLES.COLUMN20.Header1.Name = "Header1"
CONTENIDO.GRDDETALLES.COLUMN20.Text1.Name = "Text1"
CONTENIDO.GRDDETALLES.COLUMN20.Name = "COLUMN20"
CONTENIDO.GRDDETALLES.Left = 6
CONTENIDO.GRDDETALLES.TabIndex = 42
CONTENIDO.GRDDETALLES.Top = 239
CONTENIDO.GRDDETALLES.Name = "GRDDETALLES"
CONTENIDO.btnGrabar.TabIndex = 22
CONTENIDO.btnGrabar.Name = "btnGrabar"
CONTENIDO.btnCancelar.TabIndex = 24
CONTENIDO.btnCancelar.Name = "btnCancelar"
CONTENIDO.CLSCERRAR1.Picture = ..\imagen\cerrar.ico
CONTENIDO.CLSCERRAR1.TabIndex = 23
CONTENIDO.CLSCERRAR1.Name = "CLSCERRAR1"
CONTENIDO.CLSETIQUETA10.Left = 9
CONTENIDO.CLSETIQUETA10.Top = 168
CONTENIDO.CLSETIQUETA10.TabIndex = 62
CONTENIDO.CLSETIQUETA10.Name = "CLSETIQUETA10"
CONTENIDO.TXTPRMAY.Left = 114
CONTENIDO.TXTPRMAY.TabIndex = 25
CONTENIDO.TXTPRMAY.Top = 164
CONTENIDO.TXTPRMAY.Name = "TXTPRMAY"
CONTENIDO.CLSETIQUETA11.Left = 223
CONTENIDO.CLSETIQUETA11.Top = 168
CONTENIDO.CLSETIQUETA11.TabIndex = 64
CONTENIDO.CLSETIQUETA11.Name = "CLSETIQUETA11"
CONTENIDO.TXTPRMINORISTA.Left = 328
CONTENIDO.TXTPRMINORISTA.TabIndex = 13
CONTENIDO.TXTPRMINORISTA.Top = 164
CONTENIDO.TXTPRMINORISTA.Name = "TXTPRMINORISTA"
CONTENIDO.CLSETIQUETA12.Left = 207
CONTENIDO.CLSETIQUETA12.Top = 214
CONTENIDO.CLSETIQUETA12.TabIndex = 70
CONTENIDO.CLSETIQUETA12.Name = "CLSETIQUETA12"
CONTENIDO.TXTALICIVA.Left = 290
CONTENIDO.TXTALICIVA.TabIndex = 71
CONTENIDO.TXTALICIVA.Top = 210
CONTENIDO.TXTALICIVA.Name = "TXTALICIVA"
CONTENIDO.BTNELIMINAR.Top = 198
CONTENIDO.BTNELIMINAR.Left = 946
CONTENIDO.BTNELIMINAR.TabIndex = 19
CONTENIDO.BTNELIMINAR.Name = "BTNELIMINAR"
CONTENIDO.CHKIMPRIMEDUP.Top = 540
CONTENIDO.CHKIMPRIMEDUP.Left = 612
CONTENIDO.CHKIMPRIMEDUP.Alignment = 0
CONTENIDO.CHKIMPRIMEDUP.TabIndex = 78
CONTENIDO.CHKIMPRIMEDUP.Name = "CHKIMPRIMEDUP"
CONTENIDO.BTNCBTEORIGEN.Top = 4
CONTENIDO.BTNCBTEORIGEN.Left = 839
CONTENIDO.BTNCBTEORIGEN.TabIndex = 26
CONTENIDO.BTNCBTEORIGEN.Name = "BTNCBTEORIGEN"
CONTENIDO.TXTOBSERV.Left = 6
CONTENIDO.TXTOBSERV.TabIndex = 21
CONTENIDO.TXTOBSERV.Top = 428
CONTENIDO.TXTOBSERV.Name = "TXTOBSERV"
CONTENIDO.Clsetiqueta6.Left = 8
CONTENIDO.Clsetiqueta6.Top = 470
CONTENIDO.Clsetiqueta6.TabIndex = 43
CONTENIDO.Clsetiqueta6.Name = "Clsetiqueta6"
CONTENIDO.Clsetiqueta7.Left = 299
CONTENIDO.Clsetiqueta7.Top = 470
CONTENIDO.Clsetiqueta7.TabIndex = 46
CONTENIDO.Clsetiqueta7.Name = "Clsetiqueta7"
CONTENIDO.Clsetiqueta8.Height = 15
CONTENIDO.Clsetiqueta8.Left = 480
CONTENIDO.Clsetiqueta8.Top = 470
CONTENIDO.Clsetiqueta8.Width = 56
CONTENIDO.Clsetiqueta8.TabIndex = 48
CONTENIDO.Clsetiqueta8.Name = "Clsetiqueta8"
CONTENIDO.Clsetiqueta9.Left = 8
CONTENIDO.Clsetiqueta9.Top = 494
CONTENIDO.Clsetiqueta9.TabIndex = 49
CONTENIDO.Clsetiqueta9.Name = "Clsetiqueta9"
CONTENIDO.TXTTOTNETO.Left = 44
CONTENIDO.TXTTOTNETO.TabIndex = 51
CONTENIDO.TXTTOTNETO.Top = 466
CONTENIDO.TXTTOTNETO.Name = "TXTTOTNETO"
CONTENIDO.TXTPORIVA21.Height = 21
CONTENIDO.TXTPORIVA21.Left = 349
CONTENIDO.TXTPORIVA21.TabIndex = 54
CONTENIDO.TXTPORIVA21.Top = 466
CONTENIDO.TXTPORIVA21.Width = 44
CONTENIDO.TXTPORIVA21.Name = "TXTPORIVA21"
CONTENIDO.TXTPORIVA105.Height = 21
CONTENIDO.TXTPORIVA105.Left = 537
CONTENIDO.TXTPORIVA105.TabIndex = 55
CONTENIDO.TXTPORIVA105.Top = 466
CONTENIDO.TXTPORIVA105.Width = 45
CONTENIDO.TXTPORIVA105.Name = "TXTPORIVA105"
CONTENIDO.TXTIMPIVA21.Height = 21
CONTENIDO.TXTIMPIVA21.Left = 396
CONTENIDO.TXTIMPIVA21.TabIndex = 57
CONTENIDO.TXTIMPIVA21.Top = 466
CONTENIDO.TXTIMPIVA21.Width = 79
CONTENIDO.TXTIMPIVA21.Name = "TXTIMPIVA21"
CONTENIDO.TXTIMPIVA105.Left = 587
CONTENIDO.TXTIMPIVA105.TabIndex = 58
CONTENIDO.TXTIMPIVA105.Top = 466
CONTENIDO.TXTIMPIVA105.Name = "TXTIMPIVA105"
CONTENIDO.txtTotal.Left = 44
CONTENIDO.txtTotal.TabIndex = 59
CONTENIDO.txtTotal.Top = 489
CONTENIDO.txtTotal.Name = "txtTotal"
CONTENIDO.CLSETIQUETA14.Left = 613
CONTENIDO.CLSETIQUETA14.Top = 56
CONTENIDO.CLSETIQUETA14.TabIndex = 73
CONTENIDO.CLSETIQUETA14.Name = "CLSETIQUETA14"
CONTENIDO.TXTDESC1.Height = 21
CONTENIDO.TXTDESC1.Left = 704
CONTENIDO.TXTDESC1.TabIndex = 6
CONTENIDO.TXTDESC1.Top = 52
CONTENIDO.TXTDESC1.Width = 48
CONTENIDO.TXTDESC1.Name = "TXTDESC1"
CONTENIDO.TXTDESC2.Height = 21
CONTENIDO.TXTDESC2.Left = 754
CONTENIDO.TXTDESC2.TabIndex = 7
CONTENIDO.TXTDESC2.Top = 52
CONTENIDO.TXTDESC2.Width = 49
CONTENIDO.TXTDESC2.Name = "TXTDESC2"
CONTENIDO.TXTDESC3.Height = 21
CONTENIDO.TXTDESC3.Left = 804
CONTENIDO.TXTDESC3.TabIndex = 8
CONTENIDO.TXTDESC3.Top = 52
CONTENIDO.TXTDESC3.Width = 49
CONTENIDO.TXTDESC3.Name = "TXTDESC3"
CONTENIDO.TXTDESC4.Height = 21
CONTENIDO.TXTDESC4.Left = 854
CONTENIDO.TXTDESC4.TabIndex = 9
CONTENIDO.TXTDESC4.Top = 52
CONTENIDO.TXTDESC4.Width = 52
CONTENIDO.TXTDESC4.Name = "TXTDESC4"
CONTENIDO.TXTIMPDESC1.TabIndex = 30
CONTENIDO.TXTIMPDESC1.Name = "TXTIMPDESC1"
CONTENIDO.TXTIMPDESC2.TabIndex = 31
CONTENIDO.TXTIMPDESC2.Name = "TXTIMPDESC2"
CONTENIDO.TXTIMPDESC3.TabIndex = 32
CONTENIDO.TXTIMPDESC3.Name = "TXTIMPDESC3"
CONTENIDO.TXTIMPDESC4.TabIndex = 33
CONTENIDO.TXTIMPDESC4.Name = "TXTIMPDESC4"
CONTENIDO.CLSETIQUETA15.Left = 684
CONTENIDO.CLSETIQUETA15.Top = 56
CONTENIDO.CLSETIQUETA15.TabIndex = 72
CONTENIDO.CLSETIQUETA15.Name = "CLSETIQUETA15"
CONTENIDO.CLSETIQUETA16.TabIndex = 75
CONTENIDO.CLSETIQUETA16.Name = "CLSETIQUETA16"
CONTENIDO.CLSETIQUETA17.Left = 868
CONTENIDO.CLSETIQUETA17.Top = 470
CONTENIDO.CLSETIQUETA17.TabIndex = 50
CONTENIDO.CLSETIQUETA17.Name = "CLSETIQUETA17"
CONTENIDO.TXTTOTFACT.Left = 911
CONTENIDO.TXTTOTFACT.TabIndex = 60
CONTENIDO.TXTTOTFACT.Top = 466
CONTENIDO.TXTTOTFACT.Name = "TXTTOTFACT"
CONTENIDO.Clsetiqueta18.Left = 676
CONTENIDO.Clsetiqueta18.Top = 469
CONTENIDO.Clsetiqueta18.TabIndex = 47
CONTENIDO.Clsetiqueta18.Name = "Clsetiqueta18"
CONTENIDO.txtPorIIBB.Height = 21
CONTENIDO.txtPorIIBB.Left = 737
CONTENIDO.txtPorIIBB.TabIndex = 53
CONTENIDO.txtPorIIBB.Top = 466
CONTENIDO.txtPorIIBB.Width = 49
CONTENIDO.txtPorIIBB.Name = "txtPorIIBB"
CONTENIDO.txtImpIIBB.Left = 788
CONTENIDO.txtImpIIBB.TabIndex = 56
CONTENIDO.txtImpIIBB.Top = 466
CONTENIDO.txtImpIIBB.Name = "txtImpIIBB"
CONTENIDO.Clsetiqueta19.Left = 148
CONTENIDO.Clsetiqueta19.Top = 470
CONTENIDO.Clsetiqueta19.TabIndex = 74
CONTENIDO.Clsetiqueta19.Name = "Clsetiqueta19"
CONTENIDO.txtST.Left = 207
CONTENIDO.txtST.TabIndex = 52
CONTENIDO.txtST.Top = 466
CONTENIDO.txtST.Name = "txtST"
CONTENIDO.Clsetiqueta20.Left = 9
CONTENIDO.Clsetiqueta20.Top = 190
CONTENIDO.Clsetiqueta20.TabIndex = 61
CONTENIDO.Clsetiqueta20.Name = "Clsetiqueta20"
CONTENIDO.txtPorDesc1.Left = 114
CONTENIDO.txtPorDesc1.ReadOnly = .F.
CONTENIDO.txtPorDesc1.TabIndex = 14
CONTENIDO.txtPorDesc1.Top = 187
CONTENIDO.txtPorDesc1.Name = "txtPorDesc1"
CONTENIDO.txtImpDescItem1.Left = 182
CONTENIDO.txtImpDescItem1.TabIndex = 79
CONTENIDO.txtImpDescItem1.Top = 187
CONTENIDO.txtImpDescItem1.Name = "txtImpDescItem1"
CONTENIDO.txtPorDesc2.Left = 250
CONTENIDO.txtPorDesc2.ReadOnly = .F.
CONTENIDO.txtPorDesc2.TabIndex = 15
CONTENIDO.txtPorDesc2.Top = 187
CONTENIDO.txtPorDesc2.Name = "txtPorDesc2"
CONTENIDO.txtImpDescItem2.Left = 319
CONTENIDO.txtImpDescItem2.TabIndex = 80
CONTENIDO.txtImpDescItem2.Top = 187
CONTENIDO.txtImpDescItem2.Name = "txtImpDescItem2"
CONTENIDO.txtPorDesc3.Left = 387
CONTENIDO.txtPorDesc3.ReadOnly = .F.
CONTENIDO.txtPorDesc3.TabIndex = 16
CONTENIDO.txtPorDesc3.Top = 187
CONTENIDO.txtPorDesc3.Name = "txtPorDesc3"
CONTENIDO.txtImpDescItem3.Left = 455
CONTENIDO.txtImpDescItem3.TabIndex = 81
CONTENIDO.txtImpDescItem3.Top = 187
CONTENIDO.txtImpDescItem3.Name = "txtImpDescItem3"
CONTENIDO.txtPorDesc4.Left = 523
CONTENIDO.txtPorDesc4.ReadOnly = .F.
CONTENIDO.txtPorDesc4.TabIndex = 17
CONTENIDO.txtPorDesc4.Top = 187
CONTENIDO.txtPorDesc4.Name = "txtPorDesc4"
CONTENIDO.txtImpDescItem4.Left = 591
CONTENIDO.txtImpDescItem4.TabIndex = 82
CONTENIDO.txtImpDescItem4.Top = 187
CONTENIDO.txtImpDescItem4.Name = "txtImpDescItem4"
CONTENIDO.Clsetiqueta21.Left = 363
CONTENIDO.Clsetiqueta21.Top = 213
CONTENIDO.Clsetiqueta21.TabIndex = 69
CONTENIDO.Clsetiqueta21.Name = "Clsetiqueta21"
CONTENIDO.txtImpIVA.Left = 430
CONTENIDO.txtImpIVA.TabIndex = 83
CONTENIDO.txtImpIVA.Top = 210
CONTENIDO.txtImpIVA.Name = "txtImpIVA"
CONTENIDO.Clsetiqueta22.Left = 9
CONTENIDO.Clsetiqueta22.Top = 214
CONTENIDO.Clsetiqueta22.TabIndex = 65
CONTENIDO.Clsetiqueta22.Name = "Clsetiqueta22"
CONTENIDO.txtSTNeto.Left = 114
CONTENIDO.txtSTNeto.TabIndex = 67
CONTENIDO.txtSTNeto.Top = 210
CONTENIDO.txtSTNeto.Name = "txtSTNeto"
CONTENIDO.CLSETIQUETA13.Left = 505
CONTENIDO.CLSETIQUETA13.Top = 214
CONTENIDO.CLSETIQUETA13.TabIndex = 76
CONTENIDO.CLSETIQUETA13.Name = "CLSETIQUETA13"
CONTENIDO.txtSubTotal.Left = 579
CONTENIDO.txtSubTotal.TabIndex = 77
CONTENIDO.txtSubTotal.Top = 210
CONTENIDO.txtSubTotal.Name = "txtSubTotal"
CONTENIDO.Clsetiqueta23.Left = 665
CONTENIDO.Clsetiqueta23.Top = 190
CONTENIDO.Clsetiqueta23.TabIndex = 63
CONTENIDO.Clsetiqueta23.Name = "Clsetiqueta23"
CONTENIDO.txtPrNeto.Left = 740
CONTENIDO.txtPrNeto.TabIndex = 66
CONTENIDO.txtPrNeto.Top = 187
CONTENIDO.txtPrNeto.Name = "txtPrNeto"
CONTENIDO.lblExistencia.Left = 692
CONTENIDO.lblExistencia.Top = 213
CONTENIDO.lblExistencia.TabIndex = 68
CONTENIDO.lblExistencia.Name = "lblExistencia"
CONTENIDO.txtExistencia.Left = 759
CONTENIDO.txtExistencia.TabIndex = 84
CONTENIDO.txtExistencia.Top = 210
CONTENIDO.txtExistencia.Name = "txtExistencia"
CONTENIDO.Clsetiqueta24.Left = 613
CONTENIDO.Clsetiqueta24.Top = 33
CONTENIDO.Clsetiqueta24.TabIndex = 44
CONTENIDO.Clsetiqueta24.Name = "Clsetiqueta24"
CONTENIDO.txtPorRec.Left = 704
CONTENIDO.txtPorRec.TabIndex = 5
CONTENIDO.txtPorRec.Top = 29
CONTENIDO.txtPorRec.Name = "txtPorRec"
CONTENIDO.txtImpRec.Left = 814
CONTENIDO.txtImpRec.TabIndex = 85
CONTENIDO.txtImpRec.Top = 29
CONTENIDO.txtImpRec.Name = "txtImpRec"
CONTENIDO.txtRecItem.TabIndex = 34
CONTENIDO.txtRecItem.Name = "txtRecItem"
CONTENIDO.Clsetiqueta25.Left = 333
CONTENIDO.Clsetiqueta25.Top = 33
CONTENIDO.Clsetiqueta25.TabIndex = 36
CONTENIDO.Clsetiqueta25.Name = "Clsetiqueta25"
CONTENIDO.txtTelefono.Left = 389
CONTENIDO.txtTelefono.TabIndex = 27
CONTENIDO.txtTelefono.Top = 29
CONTENIDO.txtTelefono.Name = "txtTelefono"
CONTENIDO.Clsetiqueta26.Left = 656
CONTENIDO.Clsetiqueta26.Top = 11
CONTENIDO.Clsetiqueta26.TabIndex = 45
CONTENIDO.Clsetiqueta26.Name = "Clsetiqueta26"
CONTENIDO.txtcuit.Left = 688
CONTENIDO.txtcuit.TabIndex = 2
CONTENIDO.txtcuit.Top = 6
CONTENIDO.txtcuit.Name = "txtcuit"
CONTENIDO.Clsetiqueta27.Left = 674
CONTENIDO.Clsetiqueta27.Top = 145
CONTENIDO.Clsetiqueta27.Visible = .T.
CONTENIDO.Clsetiqueta27.TabIndex = 40
CONTENIDO.Clsetiqueta27.Name = "Clsetiqueta27"
CONTENIDO.cboUnidVta.Left = 732
CONTENIDO.cboUnidVta.TabIndex = 11
CONTENIDO.cboUnidVta.Top = 141
CONTENIDO.cboUnidVta.Visible = .T.
CONTENIDO.cboUnidVta.Name = "cboUnidVta"
CONTENIDO.txtCantPack.Left = 794
CONTENIDO.txtCantPack.TabIndex = 20
CONTENIDO.txtCantPack.Top = 141
CONTENIDO.txtCantPack.Visible = .T.
CONTENIDO.txtCantPack.Name = "txtCantPack"
CONTENIDO.Clsetiqueta28.Left = 489
CONTENIDO.Clsetiqueta28.Top = 56
CONTENIDO.Clsetiqueta28.Name = "Clsetiqueta28"
CONTENIDO.txtOC.Left = 516
CONTENIDO.txtOC.Top = 52
CONTENIDO.txtOC.Name = "txtOC"
CONTENIDO.Clsetiqueta29.Left = 440
CONTENIDO.Clsetiqueta29.Top = 168
CONTENIDO.Clsetiqueta29.Name = "Clsetiqueta29"
CONTENIDO.txtPorRecItem.Height = 21
CONTENIDO.txtPorRecItem.Left = 523
CONTENIDO.txtPorRecItem.Top = 164
CONTENIDO.txtPorRecItem.Width = 66
CONTENIDO.txtPorRecItem.Name = "txtPorRecItem"
CONTENIDO.Clsetiqueta30.Left = 10
CONTENIDO.Clsetiqueta30.Top = 101
CONTENIDO.Clsetiqueta30.Name = "Clsetiqueta30"
CONTENIDO.txtFecEmis.Left = 113
CONTENIDO.txtFecEmis.Top = 98
CONTENIDO.txtFecEmis.Name = "txtFecEmis"
CONTENIDO.Clsetiqueta31.Left = 245
CONTENIDO.Clsetiqueta31.Top = 102
CONTENIDO.Clsetiqueta31.Name = "Clsetiqueta31"
CONTENIDO.txtMailFC.Left = 321
CONTENIDO.txtMailFC.Top = 98
CONTENIDO.txtMailFC.Name = "txtMailFC"
CONTENIDO.chkEnviarMail.Top = 100
CONTENIDO.chkEnviarMail.Left = 629
CONTENIDO.chkEnviarMail.Alignment = 0
CONTENIDO.chkEnviarMail.Name = "chkEnviarMail"
CONTENIDO.lblPrecioUnitFinal.Name = "lblPrecioUnitFinal"
CONTENIDO.txtPrUnitFinal.Name = "txtPrUnitFinal"
CONTENIDO.chkImprimirCbte.Alignment = 0
CONTENIDO.chkImprimirCbte.Name = "chkImprimirCbte"
CONTENIDO.btnAgregarCliente.Name = "btnAgregarCliente"
CONTENIDO.Clsetiqueta32.Name = "Clsetiqueta32"
CONTENIDO.txt_subtotal_no_grav.Name = "txt_subtotal_no_grav"
CONTENIDO.Clsetiqueta33.Name = "Clsetiqueta33"
CONTENIDO.txt_total_no_grav.Name = "txt_total_no_grav"
CONTENIDO.Name = "CONTENIDO"
mov_stock.Name = "mov_stock"
faltantes.Name = "faltantes"

*** METODOS ***
PROCEDURE modificar_item
LOCAL lnDesc1, lnDesc2, lnDesc3, lnDesc4, lnNeto
LOCAL lnImpDesc1, lnImpDesc2, lnImpDesc3, lnImpDesc4
LOCAL lnImpIVA, lnAlicIVA, lnPos

SELECT cur_Deta_View
lnDesc1 = cur_Deta_View.pDtoVta1
lnDesc2 = cur_Deta_View.pDtoVta2
lnDesc3 = cur_Deta_View.pDtoVta3
lnDesc4 = cur_Deta_View.pDtoVta4
lnAlicIVA = cur_Deta_View.alicIVA
lnPos = 0

lnImpDesc1 = 0.00
lnImpDesc2 = 0.00
lnImpDesc3 = 0.00
lnImpDesc4 = 0.00

lnNeto = cur_Deta_View.prVta

&& Hago el descuento extra
lnImpDesc1 = lnNeto * (lnDesc1 / 100)
lnImpDesc2 = (lnNeto - lnImpDesc1) * (lnDesc2 / 100)
lnImpDesc3 = (lnNeto - lnImpDesc1 - lnImpDesc2) * (lnDesc3 / 100)
lnImpDesc4 = (lnNeto - lnImpDesc1 - lnImpDesc2 - lnImpDesc3) * (lnDesc4 /100)

lnNeto = lnNeto - ROUND(lnImpDesc1,2) - ROUND(lnImpDesc2,2) - ROUND(lnImpDesc3,2) - ROUND(lnImpDesc4,2)

SELECT cur_Deta_View
=LOCK()
REPLACE cur_Deta_View.iDtoVta1 WITH ROUND(lnImpDesc1, 2)
REPLACE cur_Deta_View.iDtoVta2 WITH ROUND(lnImpDesc2, 2) ADDITIVE
REPLACE cur_Deta_View.iDtoVta3 WITH ROUND(lnImpDesc3, 2) ADDITIVE
REPLACE cur_Deta_View.iDtoVta4 WITH ROUND(lnImpDesc4, 2) ADDITIVE
REPLACE cur_Deta_View.impNeto WITH ROUND(lnNeto, 2) ADDITIVE
REPLACE cur_Deta_View.totNeto WITH ROUND((lnNeto * cur_Deta_View.cantidad), 2) ADDITIVE

* Calculo el IVA
IF (ALLTRIM(Thisform.cbte) == "PTO") THEN 
	REPLACE cur_Deta_View.subTotal WITH ROUND(cur_Deta_View.totNeto + cur_Deta_View.impIVA, 2) ADDITIVE
ELSE
	REPLACE cur_Deta_View.impIVA WITH cur_Deta_View.totNeto * (cur_Deta_View.alicIVA / 100) ADDITIVE
	REPLACE cur_Deta_View.subTotal WITH cur_Deta_View.totNeto + cur_Deta_View.impIVA ADDITIVE
ENDIF 

UNLOCK

SELECT cur_Deta_View
lnPos = RECNO("cur_Deta_View")

thisform.sumar_items()
thisform.calcular_ret_iibb()

SELECT cur_Deta_View
GO lnPos

thisform.contenido.grdDetalles.Refresh()

ENDPROC
PROCEDURE generar_reg_stock
LOCAL lnTotCant

SELECT cur_retiros
IF RECCOUNT("cur_retiros") > 0 THEN
	GO TOP
ENDIF

SELECT cur_aux
IF RECCOUNT("cur_aux") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_aux")
	&& Agrego el artículo al stock siempre y cuando no sea un servicio
	IF !(ALLTRIM(cur_aux.codArt) == "9999") THEN
		lnTotCant = 0

		&& Busco por cada detalle de la factura si el artículo
		SELECT cur_retiros
		LOCATE FOR cur_retiros.idArticulo = cur_aux.idArticulo .AND. cur_retiros.facturar = .T.
		
		DO WHILE FOUND()
			lnTotCant = lnTotCant + (cur_retiros.cantidad - cur_retiros.cantFact)
		
			CONTINUE
		ENDDO
		
		IF lnTotCant = 0 THEN
			&& Si la cantidad total es 0 (cero), significa que el artículo no existe en en retiro,
			&& por lo tanto se lo considera como un artículo agregando a mano y se debe
			&& hacer movimiento de stock de salida.
			SELECT cur_movstock
			APPEND BLANK
			REPLACE cur_movstock.idArticulo WITH cur_aux.idArticulo
			REPLACE cur_movstock.codArt WITH cur_aux.codArt ADDITIVE
			REPLACE cur_movstock.cantidad WITH cur_aux.cantidad ADDITIVE
		ELSE
			&& Si la cantidad de la factura supera a la cantidad del retiro, entonces,
			&& tengo que hacer que el movimiento de stock se haga por la diferencia.
			IF cur_aux.cantidad > lnTotCant THEN
				SELECT cur_movstock
				APPEND BLANK
				REPLACE cur_movstock.idArticulo WITH cur_aux.idArticulo
				REPLACE cur_movstock.codArt WITH cur_aux.codArt ADDITIVE
				REPLACE cur_movstock.cantidad WITH cur_aux.cantidad - lnTotCant
			ENDIF
		ENDIF
	ENDIF
		
	SELECT cur_aux
	SKIP
ENDDO

SELECT cur_aux
GO TOP

ENDPROC
PROCEDURE leer_servicios
LOCAL lcSql, loRes, loForm

lcSql = ""
loRes = CREATEOBJECT("odbc_result")

lcSql = "select * from servicios "
lcSql = lcSql + "where idCliente = " + ALLTRIM(STR(thisform.contenido.sel_cliente.valcpoid)) + " "
lcSql = lcSql + "	and servicios.fecFact is null and servicios.fecBaja is null"

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_tempo"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN
ENDIF

SELECT cur_tempo
IF RECCOUNT("cur_tempo") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_tempo")
	SELECT cur_servicios
	APPEND BLANK
	REPLACE cur_servicios.sel WITH .F.
	REPLACE cur_servicios.idServ WITH cur_tempo.idServ ADDITIVE
	REPLACE cur_servicios.idCliente WITH cur_tempo.idCliente ADDITIVE
	REPLACE cur_servicios.descripcio WITH cur_tempo.descripcio ADDITIVE
	REPLACE cur_servicios.cantidad WITH cur_tempo.cantidad ADDITIVE
	REPLACE cur_servicios.precio WITH cur_tempo.precio ADDITIVE
	REPLACE cur_servicios.subTotal WITH cur_tempo.cantidad * cur_tempo.precio ADDITIVE
	REPLACE cur_servicios.usuAlta WITH cur_tempo.usuAlta ADDITIVE
	REPLACE cur_servicios.fecAlta WITH cur_tempo.fecAlta ADDITIVE
	REPLACE cur_servicios.idHostAlta WITH cur_tempo.idHostAlta ADDITIVE
	REPLACE cur_servicios.usuFact WITH ALLTRIM(gcCodUsu) ADDITIVE
	REPLACE cur_servicios.fecFact WITH DATETIME() ADDITIVE
	REPLACE cur_servicios.idHostFact WITH ALLTRIM(SYS(0)) ADDITIVE

	SELECT cur_tempo
	SKIP
ENDDO

loRes.Close_Query()

SELECT cur_servicios
IF RECCOUNT("cur_servicios") > 0 THEN
	GO TOP
	
	loForm = CREATEOBJECT("cls_form_servicios")
	loForm.show()
ENDIF

RETURN .T.
ENDPROC
PROCEDURE agregar_item_viewer_ret
LOCAL lnPDtoCli1, lnPDtoCli2, lnPDtoCli3, lnPDtoCli4
LOCAL lnIDtoCli1, lnIDtoCli2, lnIDtoCli3, lnIDtoCli4, lnCantAnt
LOCAL loResult, lcSql, lnPrecio, llEsOferta, lnproferta, lnAlicIva
LOCAL llServicio

lnPDtoCli1 = Thisform.contenido.txtDesc1.Value
lnPDtoCli2 = Thisform.contenido.txtDesc2.Value
lnPDtoCli3 = Thisform.contenido.txtDesc3.Value
lnPDtoCli4 = Thisform.contenido.txtDesc4.Value
lnIDtoCli1 = 0.00
lnIDtoCli2 = 0.00
lnIDtoCli3 = 0.00
lnIDtoCli4 = 0.00
lnPrecio = 0.00
loResult = CREATEOBJECT("odbc_result")
lcSql = ""
llEsOferta = .F.
lnproferta = 0.00
lnAlicIva = 0.00
lnCantAnt = 0.00
llServicio = .F.

lcSql = "SELECT * FROM articulos WHERE idArticulo = " + ALLTRIM(STR(Thisform.contenido.sel_Articulo.valcpoid))
loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_Art"
loResult.OpenQuery(lcSql)

IF RIGHT(ALLTRIM(Thisform.Contenido.sel_Articulo.txtCodigo.Value), 3) == "ARX" THEN
	lnPrecio = Thisform.prarti_x
ELSE	
	IF clientes.mayorista THEN 
		lnPrecio = thisform.get_precio_oferta()
		lnproferta = lnPrecio
		
		IF lnPrecio = 0 THEN
			lnPrecio = cur_Art.prVentaMax
			llEsOferta = .F.
		ELSE
			llEsOferta = .T.
		ENDIF
	ELSE
		lnPrecio = cur_Art.prVentaMin
		llEsOferta = .F.
	ENDIF		
ENDIF

llServicio = cur_Art.esServ
loResult.Close_Query()

IF glVersionBeta THEN
	SELECT cur_Deta_View
	IF RECCOUNT() = 5 THEN
		MESSAGEBOX("Usted está utilizando una versión límitada del sistema, si desea comprarlo envíe un mail a ldz.software@gmail.com", 0+64, Thisform.Caption)
		RETURN .F.
	ENDIF
ENDIF

* Valido si el artículo ya se encuentra cargado en el presupuesto
*!*	SELECT cur_Deta_View
*!*	IF RECCOUNT() > 0
*!*		GO TOP
*!*	ENDIF

*!*	SELECT cur_Deta_View
*!*	DO WHILE !EOF()
*!*		IF ALLTRIM(cur_Deta_View.codArt) == ALLTRIM(Thisform.contenido.sel_Articulo.txtCodigo.Value) THEN
*!*			IF MESSAGEBOX("El artículo ya se encuentra cargado, ¿Desea acumular la cantidad?",4+32, Thisform.Caption) == 6 THEN
*!*				lnCantAnt = Thisform.contenido.txtcantidad.Value
*!*				Thisform.contenido.txtcantidad.Value = Thisform.contenido.txtcantidad.Value + cur_Deta_View.cantidad
*!*							
*!*				Thisform.calc_item_desc()
*!*				
*!*				SELECT cur_Deta_View
*!*				DELETE
*!*			ELSE 
*!*				Thisform.contenido.sel_Articulo.txtCodigo.SetFocus()
*!*				RETURN .F.
*!*			ENDIF 
*!*		ENDIF

*!*		SELECT cur_Deta_View
*!*		SKIP
*!*	ENDDO

SELECT cur_Deta_View
APPEND BLANK
REPLACE cur_Deta_View.idDetalle WITH RECCOUNT("cur_Deta_View")
REPLACE cur_Deta_View.idArticulo WITH Thisform.contenido.sel_Articulo.valcpoid ADDITIVE
REPLACE cur_Deta_View.codArt WITH Thisform.contenido.sel_Articulo.txtCodigo.Value ADDITIVE
REPLACE cur_Deta_View.descripcio WITH Thisform.contenido.sel_Articulo.txtDescripcion.Value ADDITIVE
REPLACE cur_Deta_View.cantidad WITH Thisform.contenido.txtCantidad.Value ADDITIVE

*******************************************************************************************************************************
* Verifico el tipo de cliente que es para saber desde donde tomar el precio
*******************************************************************************************************************************
IF RIGHT(ALLTRIM(Thisform.Contenido.sel_Articulo.txtCodigo.Value), 3) == "ARX" THEN
	&& Si es artículo X, siempre cargo el contenido de lo que el usuario haya ingresado
	REPLACE cur_Deta_View.prVta WITH Thisform.contenido.txtPrMinorista.Value ADDITIVE
	REPLACE cur_Deta_View.prArtic WITH Thisform.contenido.txtPrMinorista.Value ADDITIVE
ELSE
	IF clientes.mayorista THEN 
		REPLACE cur_Deta_View.prVta WITH Thisform.contenido.txtPrMay.Value ADDITIVE
		
		IF lnproferta = 0 THEN
			REPLACE cur_Deta_View.prArtic WITH thisform.pr_mayorista ADDITIVE
		ELSE
			REPLACE cur_Deta_View.prArtic WITH thisform.pr_oferta ADDITIVE
		ENDIF
	ELSE
		REPLACE cur_Deta_View.prVta WITH Thisform.contenido.txtPrMinorista.Value ADDITIVE
		REPLACE cur_Deta_View.prArtic WITH Thisform.pr_minorista ADDITIVE
	ENDIF
	
	* Levanto el stock actual solo en caso que no sea ARX
	REPLACE cur_Deta_View.stkDisp  WITH Thisform.mov_stock.get_exist_byart(Thisform.contenido.sel_Articulo.valcpoid) ADDITIVE
ENDIF

&& Valida si es un servicio, entonces, carga los precios del servico en prArtic para que
&& pueda ser tomado por la NC.
IF llServicio THEN
	REPLACE cur_Deta_View.prVta WITH Thisform.Contenido.txtPrMinorista.Value ADDITIVE
	REPLACE cur_Deta_View.prArtic WITH Thisform.Contenido.txtPrMinorista.Value ADDITIVE
ENDIF

REPLACE cur_Deta_View.pDtoVta1 WITH Thisform.contenido.txtPorDesc1.Value
REPLACE cur_Deta_View.pDtoVta2 WITH Thisform.contenido.txtPorDesc2.Value
REPLACE cur_Deta_View.pDtoVta3 WITH Thisform.contenido.txtPorDesc3.Value
REPLACE cur_Deta_View.pDtoVta4 WITH Thisform.contenido.txtPorDesc4.Value
REPLACE cur_Deta_View.iDtoVta1 WITH Thisform.contenido.txtImpDescItem1.Value
REPLACE cur_Deta_View.iDtoVta2 WITH Thisform.contenido.txtImpDescItem2.Value 
REPLACE cur_Deta_View.iDtoVta3 WITH Thisform.contenido.txtImpDescItem3.Value
REPLACE cur_Deta_View.iDtoVta4 WITH Thisform.contenido.txtImpDescItem4.Value
REPLACE cur_Deta_View.impNeto WITH Thisform.contenido.txtPrNeto.Value

*******************************************************************************************************************************
* Hago el cálculo del IVA
*******************************************************************************************************************************
IF (ALLTRIM(Thisform.cbte) == "PTO") THEN
	REPLACE cur_Deta_View.impIVA WITH 0 ADDITIVE
	REPLACE cur_Deta_View.alicIVA WITH 0 ADDITIVE
ELSE
	lnAlicIva = Thisform.contenido.txtAlicIVA.Value
	REPLACE cur_Deta_View.impIVA WITH ROUND(ROUND(ROUND(cur_Deta_View.impNeto, 2) * (ROUND(lnAlicIva, 2) / 100), 2) * cur_Deta_View.Cantidad, 2) ADDITIVE
	REPLACE cur_Deta_View.alicIVA WITH lnAlicIva ADDITIVE
ENDIF

REPLACE cur_Deta_View.totNeto WITH Thisform.contenido.txtSTNeto.Value ADDITIVE
REPLACE cur_Deta_View.subTotal WITH Thisform.contenido.txtSubTotal.Value ADDITIVE

*******************************************************************************************************************************
* Calculo el descuento del cliente en el ítem para grabar
*******************************************************************************************************************************
lnIDtoCli1 = lnPrecio * (lnPDtoCli1 / 100)
lnIDtoCli2 = (lnPrecio - lnIDtoCli1) * (lnPDtoCli2 / 100)
lnIDtoCli3 = (lnPrecio - lnIDtoCli1 - lnIDtoCli2) * (lnPDtoCli3 / 100)
lnIDtoCli4 = (lnPrecio - lnIDtoCli1 - lnIDtoCli2 - lnIDtoCli3) * (lnPDtoCli4 / 100)

REPLACE cur_Deta_View.pDtoCli1 WITH lnPDtoCli1 ADDITIVE
REPLACE cur_Deta_View.pDtoCli2 WITH lnPDtoCli2 ADDITIVE
REPLACE cur_Deta_View.pDtoCli3 WITH lnPDtoCli3 ADDITIVE
REPLACE cur_Deta_View.pDtoCli4 WITH lnPDtoCli4 ADDITIVE
REPLACE cur_Deta_View.iDtoCli1 WITH lnIDtoCli1 ADDITIVE
REPLACE cur_Deta_View.iDtoCli2 WITH lnIDtoCli2 ADDITIVE
REPLACE cur_Deta_View.iDtoCli3 WITH lnIDtoCli3 ADDITIVE
REPLACE cur_Deta_View.iDtoCli4 WITH lnIDtoCli4 ADDITIVE
REPLACE cur_Deta_View.esOferta WITH llEsOferta ADDITIVE

*******************************************************************************************************************************
* Agrego el recargo del item
*******************************************************************************************************************************
REPLACE cur_Deta_View.pRecVta WITH Thisform.contenido.txtporrec.Value ADDITIVE
REPLACE cur_Deta_View.iRecVta WITH Thisform.contenido.txtrecitem.Value ADDITIVE


RETURN .T.


ENDPROC
PROCEDURE add_desde_retiro
IF thisform.agregar_item_viewer_ret() THEN
	Thisform.contenido.sel_Articulo.blanquear()
	Thisform.contenido.txtprMay.Value = 0.00
	Thisform.contenido.txtPrMinorista.Value = 0.00
	Thisform.contenido.txtCantidad.Value = 0.00
	Thisform.contenido.txtPrNeto.Value = 0.00
	Thisform.contenido.txtSubTotal.Value = 0.00
	Thisform.contenido.txtAlicIVA.Value = 0.00
	Thisform.contenido.txtImpIVA.Value = 0.00
	Thisform.contenido.txtSTNeto.Value = 0.00
	Thisform.contenido.txtPorDesc1.Value = 0.00
	Thisform.contenido.txtPorDesc2.Value = 0.00
	Thisform.contenido.txtPorDesc3.Value = 0.00
	Thisform.contenido.txtPorDesc4.Value = 0.00
	Thisform.contenido.txtImpDescItem1.Value = 0.00
	Thisform.contenido.txtImpDescItem2.Value = 0.00
	Thisform.contenido.txtImpDescItem3.Value = 0.00
	Thisform.contenido.txtImpDescItem4.Value = 0.00
	Thisform.pr_mayorista = 0.00
	Thisform.pr_minorista = 0.00

	Thisform.sumar_items()
	Thisform.calcular_ret_iibb()
	
	SELECT cur_Deta_View 
	GO BOTTOM
	Thisform.contenido.grdDetalles.Refresh()

	Thisform.contenido.sel_Articulo.txtCodigo.SetFocus()
	Thisform.contenido.sel_Articulo.txtDescripcion.Enabled = .F.
ENDIF
ENDPROC
PROCEDURE agregar_servicios
LOCAL loRes, lcSql
LOCAL lnIdArticulo, lcCodArt
LOCAL lnTotNeto

loRes = CREATEOBJECT("odbc_result")
lcSql = ""
lnTotNeto = 0.00

lcSql = "select * from articulos where codArt = '9999'"
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_temp"

IF !loRes.OpenQuery(lcSql) THEN
	MESSAGEBOX(loRes.Error_Message, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_temp
IF RECCOUNT("cur_temp") > 0 THEN
	GO TOP
	lnIdArticulo = cur_temp.idArticulo
	lcCodArt = cur_temp.codArt
ELSE
	loRes.Close_Query()
	MESSAGEBOX("Para poder facturar servicios debe tener el artículo código 9999 cargado", 0+64, Thisform.Caption)
	RETURN .F.
ENDIF

lnTotNeto = Thisform.contenido.txtTotNeto.Value

SELECT cur_servicios
GO TOP

DO WHILE !EOF("cur_servicios")
	IF cur_servicios.sel THEN
		SELECT cur_Deta_View
		APPEND BLANK
		REPLACE cur_Deta_View.idDetalle WITH 0 
		REPLACE cur_Deta_View.idArticulo WITH lnIdArticulo ADDITIVE
		REPLACE cur_Deta_View.codArt WITH lcCodArt ADDITIVE
		REPLACE cur_Deta_View.descripcio WITH ALLTRIM(cur_servicios.descripcio) ADDITIVE	
		REPLACE cur_Deta_View.cantidad WITH cur_servicios.cantidad ADDITIVE
		REPLACE cur_Deta_View.prVta WITH cur_servicios.precio ADDITIVE
		REPLACE cur_Deta_View.pDtoVta1 	WITH 0 ADDITIVE
		REPLACE cur_Deta_View.pDtoVta2 	WITH 0 ADDITIVE
		REPLACE cur_Deta_View.pDtoVta3 	WITH 0 ADDITIVE
		REPLACE cur_Deta_View.pDtoVta4 	WITH 0 ADDITIVE
		REPLACE cur_Deta_View.iDtoVta1 	WITH 0 ADDITIVE
		REPLACE cur_Deta_View.iDtoVta2 	WITH 0 ADDITIVE
		REPLACE cur_Deta_View.iDtoVta3 	WITH 0 ADDITIVE
		REPLACE cur_Deta_View.iDtoVta4 	WITH 0 ADDITIVE
		REPLACE cur_Deta_View.pDtoCli1 	WITH 0 ADDITIVE
		REPLACE cur_Deta_View.pDtoCli2 	WITH 0 ADDITIVE
		REPLACE cur_Deta_View.pDtoCli3 	WITH 0 ADDITIVE
		REPLACE cur_Deta_View.pDtoCli4 	WITH 0 ADDITIVE
		REPLACE cur_Deta_View.iDtoCli1 	WITH 0 ADDITIVE
		REPLACE cur_Deta_View.iDtoCli2 	WITH 0 ADDITIVE
		REPLACE cur_Deta_View.iDtoCli3 	WITH 0 ADDITIVE
		REPLACE cur_Deta_View.iDtoCli4 	WITH 0 ADDITIVE
		REPLACE cur_Deta_View.alicIVA 	WITH cur_temp.alicIVA ADDITIVE
		REPLACE cur_Deta_View.impIVA	WITH (cur_servicios.precio * (cur_temp.alicIVA / 100)) *  cur_servicios.cantidad ADDITIVE
		REPLACE cur_Deta_View.impNeto	WITH cur_servicios.precio ADDITIVE
		REPLACE cur_Deta_View.totNeto	WITH cur_servicios.precio * cur_servicios.cantidad ADDITIVE
		REPLACE cur_Deta_View.subTotal 	WITH (cur_servicios.precio * cur_servicios.cantidad) + cur_Deta_View.impIVA ADDITIVE
		REPLACE cur_Deta_View.stkDisp	WITH 0 ADDITIVE
		REPLACE cur_Deta_View.prArtic	WITH cur_servicios.precio ADDITIVE
		REPLACE cur_Deta_View.esOferta 	WITH .F. ADDITIVE
		REPLACE cur_Deta_View.pRecVta	WITH 0 ADDITIVE
		REPLACE cur_Deta_View.iRecVta	WITH 0 ADDITIVE
		
		lnTotNeto = lnTotNeto + (cur_servicios.precio * cur_servicios.cantidad)
	ENDIF
	
	SELECT cur_servicios
	SKIP
ENDDO

loRes.Close_Query()

Thisform.sumar_items()
Thisform.calcular_ret_iibb()

SELECT cur_Deta_View 
GO BOTTOM
Thisform.contenido.grdDetalles.Refresh()

*Thisform.contenido.txtTotNeto.Value = ROUND(lnTotNeto, 2)

RETURN .T.
ENDPROC
PROCEDURE actualizar_servicios
LOCAL loCommand, lcSql

loCommand = CREATEOBJECT("odbc_command")
lcSql = ""

SELECT cur_servicios
IF RECCOUNT("cur_servicios") > 0 THEN
	GO TOP
ENDIF

goConn.BeginTransaction()

SELECT cur_servicios
DO WHILE !EOF("cur_servicios")
	IF cur_servicios.sel THEN
		lcSql = "update servicios set "
		lcSql = lcSql + "usuFact = '" + ALLTRIM(gcCodUsu) + "', "
		lcSql = lcSql + "fecFact = " + IIF(INT(VAL(getConfig("SQLSRV"))) = 1, "GETDATE()", "current_date") + ", "
		lcSql = lcSql + "idHostFact = '" + ALLTRIM(SYS(0)) + "' "
		lcSql = lcSql + "where idServ = " + ALLTRIM(STR(cur_servicios.idServ))
		
		loCommand.ActiveConnection = goConn.ActiveConnection
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			goConn.Rollback()
			MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
			RETURN .F.
		ENDIF
	ENDIF

	SELECT cur_servicios
	SKIP
ENDDO

goConn.Commit()
RETURN .T.
ENDPROC
PROCEDURE enviar_wsafipfe
LOCAL llRes
LOCAL lnPtoVta
LOCAL lnTipoDoc, lcTipoDoc
LOCAL lnRetAlva
LOCAL lnCantIVA
LOCAL lnImpBase21
LOCAL lnImpBase105
LOCAL lcNumero
LOCAL lcMensaje
LOCAL lnImpBaseSIVA
LOCAL lnIndice
LOCAL lnModo
LOCAL lcCUIT
LOCAL lcCertif
LOCAL lcLicencia
LOCAL lcPassword
LOCAL lnTotalIVA

lnTipoDoc = 0
lcTipoDoc = ""
lnPtoVta = INT(VAL(getConfig("PTOVTA")))
lnRetAlva = 0
lnCantIVA = 0
lnImpBase21 = 0
lnImpBase105 = 0
lnImpBaseSIVA = 0
lcNumero = ""
lcMensaje = ""
lnIndice = 0
m.impIVA = 0

lnModo = IIF(getGlobalCFG("FEDEBUG"), 0, 1)
lcCUIT = ALLTRIM(getGlobalCFG("FECUIT"))
lcCertif = ALLTRIM(getGlobalCFG("FE_FILE"))
lcLicencia = ALLTRIM(getGlobalCFG("FE_LIC"))
lcPassword = ALLTRIM(getGlobalCFG("FE_PWD"))

lcTipoDoc = Thisform.calcular_tipodoc()

&& Tengo que acordarme que en el tercer parámetro tengo que pasar
&& la ruta y el nombre de archivo del certificado.

llRes = Thisform.fe.iniciar(lnModo, lcCUIT, SYS(5) + SYS(2003) + "\wsafip\" + lcCertif, lcLicencia)
&& llRes = Thisform.fe.iniciar(0, "20364791969", SYS(5) + SYS(2003) + "\Release\SISCOM_BETA\wsafip\20364791969.pfx", "")

IF !llRes THEN
	MESSAGEBOX("Falló al iniciar: " + Thisform.fe.ultimoMensajeError, 0+32, Thisform.Caption)
	RETURN .F.
ENDIF

Thisform.fe.ArchivoCertificadoPassWord = lcPassword
IF !Thisform.ticket_valido() THEN
	MESSAGEBOX("No se pudo generar Ticket de Acceso", 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

Thisform.fe.ArchivoXMLRecibido = SYS(5) + SYS(2003) + "\wsafip\xml\rec_" + ALLTRIM(STR(YEAR(DATETIME()))) + ;
	ALLTRIM(STR(MONTH(DATETIME()))) + ALLTRIM(STR(DAY(DATETIME()))) + ALLTRIM(STR(HOUR(DATETIME()))) + ;
	ALLTRIM(STR(MINUTE(DATETIME()))) + ALLTRIM(STR(SEC(DATETIME()))) + ".xml"
	
Thisform.fe.archivoXMLEnviado = SYS(5) + SYS(2003) + "\wsafip\xml\env_" + ALLTRIM(STR(YEAR(DATETIME()))) + ;
	ALLTRIM(STR(MONTH(DATETIME()))) + ALLTRIM(STR(DAY(DATETIME()))) + ALLTRIM(STR(HOUR(DATETIME()))) + ;
	ALLTRIM(STR(MINUTE(DATETIME()))) + ALLTRIM(STR(SEC(DATETIME()))) + ".xml"
	
lnRetAlva = Thisform.fe.f1CompUltimoAutorizado(lnPtoVta, Thisform.fe_get_tipocbte_afip(ALLTRIM(lcTipoDoc)))

Thisform.fe.F1CabeceraCantReg = 1
Thisform.fe.F1CabeceraPtoVta = lnPtoVta
Thisform.fe.F1CabeceraCbteTipo = Thisform.fe_get_tipocbte_afip(ALLTRIM(lcTipoDoc))

Thisform.fe.F1DetalleDocTipo = Thisform.fe_convertir_tipodoc(ALLTRIM(Thisform.cli_tipodoc))
Thisform.fe.F1DetalleDocNro = Thisform.cli_cuit
Thisform.fe.F1DetalleCbteDesde = lnRetAlva + 1
Thisform.fe.F1DetalleCbteHasta = lnRetAlva + 1

Thisform.fe.F1DetalleCbteFch = ALLTRIM(STR(YEAR(DATE()))) + IIF(LEN(ALLTRIM(STR(MONTH(DATE())))) < 2, "0" + ALLTRIM(STR(MONTH(DATE()))), ALLTRIM(STR(MONTH(DATE())))) + ;
	IIF(LEN(ALLTRIM(STR(DAY(DATE())))) < 2, "0" + ALLTRIM(STR(DAY(DATE()))), ALLTRIM(STR(DAY(DATE()))))


&& Tengo que calcular la suma del neto de los articulos con 21 de IVA y con el 10.5 de IVA
&& por separado.
SELECT cur_aux
GO TOP
DO WHILE !EOF("cur_aux")
	IF cur_aux.alicIVA = 21 THEN
		lnImpBase21 = lnImpBase21 + cur_aux.TotNeto
	ENDIF
	
	IF cur_aux.alicIVA = 10.5 THEN
		lnImpBase105 = lnImpBase105 + cur_aux.TotNeto
	ENDIF
	
	IF cur_aux.alicIVA = 0 THEN
		lnImpBaseSIVA = lnImpBaseSIVA + cur_aux.TotNeto
	ENDIF

	SELECT cur_aux
	SKIP
ENDDO

lnTotalIVA = 0
lnIndice = 0
IF lnImpBase21 <> 0 THEN
	Thisform.fe.F1DetalleIvaItemCantidad = Thisform.fe.F1DetalleIvaItemCantidad + 1
	Thisform.fe.f1IndiceItem = lnIndice
	Thisform.fe.F1DetalleIvaId = 5
	Thisform.fe.F1DetalleIvaBaseImp = ROUND(lnImpBase21, 2)
	Thisform.fe.F1DetalleIvaImporte = ROUND(lnImpBase21 * (Thisform.contenido.txtPorIVA21.Value / 100), 2)
	lnIndice = lnIndice + 1
	lnTotalIVA = lnTotalIVA + Thisform.fe.F1DetalleIvaImporte
ENDIF

IF lnImpBase105 <> 0 THEN
	Thisform.fe.F1DetalleIvaItemCantidad = Thisform.fe.F1DetalleIvaItemCantidad + 1
	Thisform.fe.f1IndiceItem = lnIndice
	Thisform.fe.F1DetalleIvaId = 4
	Thisform.fe.F1DetalleIvaBaseImp = ROUND(lnImpBase105, 2)
	Thisform.fe.F1DetalleIvaImporte = ROUND(lnImpBase105 * (Thisform.Contenido.txtPorIVA105.Value / 100), 2)
	lnIndice = lnIndice + 1
	lnTotalIVA = lnTotalIVA + Thisform.fe.F1DetalleIvaImporte
ENDIF

IF lnImpBaseSIVA <> 0 THEN
	Thisform.fe.F1DetalleIvaItemCantidad = Thisform.fe.F1DetalleIvaItemCantidad + 1
	Thisform.fe.f1IndiceItem = lnIndice
	Thisform.fe.F1DetalleIvaId = 3
	Thisform.fe.F1DetalleIvaBaseImp = ROUND(lnImpBaseSIVA, 2)
&&	Thisform.fe.F1DetalleImpIva = 0
ENDIF

&& Agrego los conceptos de IIBB

IF Thisform.Contenido.txtPorIIBB.Value <> 0 THEN
	Thisform.FE.F1DetalleTributoItemCantidad = 1
	Thisform.FE.f1IndiceItem = 0
	Thisform.FE.F1DetalleTributoId = 2
	Thisform.FE.F1DetalleTributoDesc = "IIBB Pcia Bs AS"
	Thisform.FE.F1DetalleTributoBaseImp = ROUND(lnImpBase21 + lnImpBase105 + lnImpBaseSIVA, 2)
	Thisform.FE.F1DetalleTributoAlic = Thisform.Contenido.txtPorIIBB.Value 
	Thisform.FE.F1DetalleTributoImporte = ROUND((lnImpBase21 + lnImpBase105 + lnImpBaseSIVA) * (Thisform.Contenido.txtPorIIBB.Value / 100), 2)
ENDIF

Thisform.fe.F1DetalleConcepto = 1
Thisform.fe.F1DetalleImpNeto = ROUND(lnImpBase21 + lnImpBase105 + lnImpBaseSIVA, 2)
Thisform.fe.F1DetalleImpTotalConc = ROUND(lnImpBase21 + lnImpBase105 + lnImpBaseSIVA, 2) * (Thisform.Contenido.txtPorIIBB.Value / 100)
Thisform.fe.F1DetalleImpIva = lnTotalIVA
Thisform.fe.F1DetalleImpOpEx = 0
Thisform.fe.F1DetalleImpTrib = Thisform.FE.F1DetalleTributoImporte
Thisform.fe.F1DetalleMonId = "PES"
Thisform.fe.F1DetalleMonCotiz = 1
Thisform.fe.F1DetalleImpTotal = ROUND(Thisform.fe.F1DetalleImpNeto + Thisform.fe.F1DetalleImpIva + Thisform.fe.F1DetalleImpTotalConc + Thisform.fe.F1DetalleImpOpEx + Thisform.fe.F1DetalleImpTrib, 2)

llRes = Thisform.fe.f1CAESolicitar()

&& llRes = Thisform.fe.registrar(lnPtoVta, Thisform.fe_get_tipocbte_afip(ALLTRIM(lcTipoDoc)), "1") 

IF llRes THEN
	lcNumero = REPLICATE("0", 4 - LEN(ALLTRIM(STR(lnPtoVta)))) + ALLTRIM(STR(lnPtoVta)) + "-" + ;
		REPLICATE("0", 8 - LEN(ALLTRIM(STR(Thisform.fe.F1RespuestaDetalleCbteDesde)))) + ALLTRIM(STR(Thisform.fe.F1RespuestaDetalleCbteDesde))
	
	Thisform.ptovta = lnPtoVta
	Thisform.nrocbte = INT(VAL(Thisform.fe.F1RespuestaDetalleCbteDesdeS))
	
	lcMensaje = "CAE: " + Thisform.fe.F1RespuestaDetalleCae + CHR(13)+ CHR(10)
	lcMensaje = lcMensaje + "FECHA VTO: " + Thisform.fe.F1RespuestaDetalleCaeFchVto + CHR(13) + CHR(10)
	lcMensaje = lcMensaje + "MOTIVO: " + Thisform.fe.F1RespuestaDetalleObservacionMsg + CHR(13) + CHR(10)
	lcMensaje = lcMensaje + "PROCESO: " + Thisform.fe.F1RespuestaReProceso
	MESSAGEBOX(lcMensaje, 0+64, Thisform.Caption)
	
	Thisform.aut_numero = lcNumero
	Thisform.aut_cae = Thisform.fe.F1RespuestaDetalleCae
	Thisform.aut_cae_vto = Thisform.fe.F1RespuestaDetalleCaeFchVto
	Thisform.aut_resultado = Thisform.fe.F1RespuestaResultado
	Thisform.aut_motivo = Thisform.fe.F1RespuestaDetalleObservacionMsg
ELSE
	IF !(ISNULL(Thisform.fe.F1RespuestaReProceso) .OR. Thisform.fe.F1RespuestaReProceso == "R") THEN
		lcNumero = REPLICATE("0", 4 - LEN(ALLTRIM(STR(lnPtoVta)))) + ALLTRIM(STR(lnPtoVta)) + "-" + ;
			REPLICATE("0", 4 - LEN(ALLTRIM(STR(Thisform.fe.F1RespuestaDetalleCbteDesde)))) + ALLTRIM(STR(Thisform.fe.F1RespuestaDetalleCbteDesde))
		
		lcMensaje = "CAE: " + Thisform.fe.F1RespuestaDetalleCae + CHR(13)+ CHR(10)
		lcMensaje = lcMensaje + "FECHA VTO: " + Thisform.fe.F1RespuestaDetalleCaeFchVto + CHR(13) + CHR(10)		
		lcMensaje = lcMensaje + "MOTIVO: " + Thisform.fe.F1RespuestaDetalleObservacionMsg + CHR(13) + CHR(10)
		lcMensaje = lcMensaje + "PROCESO: " + Thisform.fe.F1RespuestaReProceso
		MESSAGEBOX(lcMensaje, 0+64, Thisform.Caption)
		
		Thisform.aut_numero = lcNumero
		Thisform.aut_cae = Thisform.fe.F1RespuestaDetalleCae
		Thisform.aut_cae_vto = Thisform.fe.F1RespuestaDetalleCaeFchVto
		Thisform.aut_resultado = Thisform.fe.F1RespuestaResultado
		Thisform.aut_motivo = Thisform.fe.F1RespuestaDetalleObservacionMsg
		RETURN .F.
	ELSE
		lcMensaje = "MOTIVO: " + Thisform.fe.F1RespuestaDetalleObservacionMsg + CHR(13) + CHR(10)
		lcMensaje = lcMensaje + "ERROR: " + Thisform.fe.f1ErrorMsg1 + CHR(13) + CHR(10)
		lcMensaje = lcMensaje + "ULTIMO: " + Thisform.fe.UltimoMensajeError
		MESSAGEBOX(lcMensaje, 0+64, Thisform.Caption)
		
		Thisform.aut_numero = lcNumero
		Thisform.aut_cae = ""
		Thisform.aut_cae_vto = ""
		Thisform.aut_resultado = Thisform.fe.F1RespuestaResultado
		Thisform.aut_motivo = Thisform.fe.F1RespuestaDetalleObservacionMsg
		
		RETURN .F.
	ENDIF
ENDIF

IF ALLTRIM(thisform.aut_resultado) == "R" THEN
	RETURN .F.
ENDIF

RETURN .T.
ENDPROC
PROCEDURE fe_convertir_tipodoc
PARAMETERS tcTipoDoc
LOCAL lnResultado

lnResultado = 99 && Código que corresponde a sin identificación en el diccionario

DO CASE
	CASE ALLTRIM(tcTipoDoc) == "CUIT"
		lnResultado = 80
	CASE ALLTRIM(tcTipoDoc) == "CUIL"
		lnResultado = 86
	CASE ALLTRIM(tcTipoDoc) == "CI"
		lnResultado = 87
	CASE ALLTRIM(tcTipoDoc) == "LE"
		lnResultado = 89
	CASE ALLTRIM(tcTipoDoc) == "LC"
		lnResultado = 90
	CASE ALLTRIM(tcTipoDoc) == "CIE"
		lnResultado = 91
	CASE ALLTRIM(tcTipoDoc) == "PAS"
		lnResultado = 94
	CASE ALLTRIM(tcTipoDoc) == "DNI"
		lnResultado = 96
ENDCASE

RETURN lnResultado

ENDPROC
PROCEDURE fe_get_tipocbte_afip
PARAMETERS tc_letra

DO CASE
	CASE ALLTRIM(thisform.cbte) == "FC"
		DO CASE
			CASE ALLTRIM(tc_letra) == "A"
				RETURN 1
			CASE ALLTRIM(tc_letra) == "B"
				RETURN 6
			CASE ALLTRIM(tc_letra) == "C" 
				RETURN 11
		ENDCASE
	CASE ALLTRIM(thisform.cbte) == "ND"
		DO CASE
			CASE ALLTRIM(tc_letra) == "A"
				RETURN 2
			CASE ALLTRIM(tc_letra) == "B"
				RETURN 7
			CASE ALLTRIM(tc_letra) == "C"
				RETURN 12
		ENDCASE
	CASE ALLTRIM(thisform.cbte) == "NC"
		DO CASE
			CASE ALLTRIM(tc_letra) == "A"
				RETURN 3
			CASE ALLTRIM(tc_letra) == "B"
				RETURN 8
			CASE ALLTRIM(tc_letra) == "C"
				RETURN 13
		ENDCASE	
ENDCASE

RETURN -1

ENDPROC
PROCEDURE fe_set_cae
LOCAL loCommand, lcSql
LOCAL loDT, ldFecVto
LOCAL lcAnio, lcMes, lcDia
LOCAL lcPtoVta, lcNumCbte

loDT = CREATEOBJECT("datetime")
loCommand = CREATEOBJECT("odbc_command")
lcSql = ""

lcAnio = SUBSTR(Thisform.aut_cae_vto, 1, 4)
lcMes = SUBSTR(Thisform.aut_cae_vto, 5, 2)
lcDia = SUBSTR(Thisform.aut_cae_vto, 7, 2)

IF ALLTRIM(Thisform.aut_resultado) == "R" THEN
	lcSql = "update ventascab "
	lcSql = lcSql + "set "
	lcSql = lcSql + "	ptoVta = " + ALLTRIM(STR(Thisform.ptovta)) + ", "
	lcSql = lcSql + "	numCbte = " + ALLTRIM(STR(Thisform.nrocbte)) + ", "
	lcSql = lcSql + "	aut_CAE = '" + ALLTRIM(Thisform.aut_cae) + "', "
	lcSql = lcSql + "	aut_Resultado = '" + ALLTRIM(Thisform.aut_resultado) + "', "
	lcSql = lcSql + "	aut_Motivo = '" + ALLTRIM(STRTRAN(Thisform.aut_motivo, "'", "''")) + "', "
	lcSql = lcsql + "	aut_tipoCbte = '" + REPLICATE("0", 2 - LEN(ALLTRIM(STR(Thisform.fe.F1CabeceraCbteTipo)))) + ALLTRIM(STR(Thisform.fe.F1CabeceraCbteTipo)) + "' "
	lcSql = lcSql + "where idVentasC = " + ALLTRIM(STR(Thisform.id_ventasc))
ELSE
	lcSql = "update ventascab "
	lcSql = lcSql + "set "
	lcSql = lcSql + "	ptoVta = " + ALLTRIM(STR(Thisform.ptovta)) + ", "
	lcSql = lcSql + "	numCbte = " + ALLTRIM(STR(Thisform.nrocbte)) + ", "
	lcSql = lcSql + "	aut_CAE = '" + ALLTRIM(Thisform.aut_cae) + "', "
	lcSql = lcSql + "	aut_CAE_vto = " + loDT.toMySql(CTOD(lcDia + "/" + lcMes + "/" + lcAnio)) + ", "
	lcSql = lcSql + "	aut_Resultado = '" + ALLTRIM(Thisform.aut_resultado) + "', "
	lcSql = lcSql + "	aut_Motivo = '" + ALLTRIM(STRTRAN(Thisform.aut_motivo, "'", "''")) + "', "
	lcSql = lcsql + "	aut_tipoCbte = '" + REPLICATE("0", 2 - LEN(ALLTRIM(STR(Thisform.fe.F1CabeceraCbteTipo)))) + ALLTRIM(STR(Thisform.fe.F1CabeceraCbteTipo)) + "' "
	lcSql = lcSql + "where idVentasC = " + ALLTRIM(STR(Thisform.id_ventasc))
ENDIF

goConn.BeginTransaction()

loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = lcSql

IF !loCommand.Execute() THEN
	MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

lcSql = "update cc_cli set nroCbte = " + ALLTRIM(STR(Thisform.nrocbte)) + " "
lcSql = lcSql + "WHERE idVentasC = " + ALLTRIM(STR(Thisform.id_ventasc))

loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = lcSql

IF !loCommand.Execute() THEN
	goConn.Rollback()
	MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

&& Asigno el número de comprobante al movimiento de stock
lcPtoVta = REPLICATE("0", 4 - LEN(ALLTRIM(STR(Thisform.ptovta)))) + ALLTRIM(STR(Thisform.ptovta))
lcNumCbte = REPLICATE("0", 8 - LEN(ALLTRIM(STR(Thisform.nrocbte)))) + ALLTRIM(STR(Thisform.nrocbte))

lcSql = "UPDATE stk_cab "
lcSql = lcSql + "SET stk_cab.numCbte = '" + lcPtoVta + "-" + lcNumCbte + "' "
lcSql = lcSql + "WHERE idVentasC = " + ALLTRIM(STR(Thisform.id_ventasc))

loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = lcSql

IF !loCommand.Execute() THEN
	goConn.Rollback()
	MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

IF VAL(getConfig("SQLSRV")) = 1 THEN
	lcSql = "UPDATE retirosdet "
	lcSql = lcSql + "SET retirosdet.nroCbte = ventascab.numCbte "
	lcSql = lcSql + "FROM ventascab "
	lcSql = lcSql + "WHERE retirosdet.idVentasC = ventascab.idVentasC "
ELSE
	lcSql = "UPDATE retirosdet "
	lcSql = lcSql + "INNER JOIN ventascab ON ventascab.idVentasC = retirosdet.idVentasC "
	lcSql = lcSql + "SET retirosdet.nroCbte = ventascab.numCbte "
	lcSql = lcSql + "WHERE retirosdet.idVentasC = ventascab.idVentasC "
ENDIF

loCommand.ActiveConnection = goConn.ActiveConnection
loCommand.CommandText = lcSql

IF !loCommand.Execute() THEN
	goConn.Rollback()
	MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
	RETURN
ENDIF

goConn.Commit()

Thisform.imprimir()

RETURN .T.
ENDPROC
PROCEDURE calc_digito_verificador
&& El prefijo E1, E2, En... indica a la etapa del algoritmo que pertenece el coeficiente

PARAMETERS tcCodigo

LOCAL lnDigito
LOCAL lnSumaE1
LOCAL lnSumaE3
LOCAL lnProductoE2
LOCAL lnSumaE4
LOCAL lnMin
LOCAL lnPos

lnDigito = 0
lnSumaE1 = 0
lnSumaE3 = 0
lnSumaE4 = 0
lnMin = 0

FOR i = 1 TO LEN(ALLTRIM(tcCodigo))
	lnDigito = INT(VAL(SUBSTR(tcCodigo, i, 1)))
	
	IF MOD(i, 2) <> 0 THEN
		&& Etapa 1 (posiciones impares)
		lnSumaE1 = lnSumaE1 + lnDigito
	ELSE
		&& Etapa 3 (posiciones pares)
		lnSumaE3 = lnSumaE3 + lnDigito
	ENDIF
NEXT i

lnProductoE2 = lnSumaE1 * 3 && Etapa 2
lnSumaE4 = lnProductoE2 + lnSumaE3 && Etapa 4

&& Etapa 5
lnPos = 0
FOR i = 1 TO LEN(ALLTRIM(tcCodigo))
	lnDigito = INT(VAL(SUBSTR(tcCodigo, i, 1)))
	
	IF MOD(lnSumaE4 + lnDigito, 10) = 0 THEN
		IF lnPos = 0 THEN
			lnMin = lnDigito
		ELSE
			IF lnDigito < lnMin THEN
				lnMin = lnDigito
			ENDIF
		ENDIF
		
		lnPos = lnPos + 1
	ENDIF
NEXT i

RETURN lnMin
ENDPROC
PROCEDURE ticket_valido
LOCAL llTkValido
LOCAL lcTicket
LOCAL lcFileTicket
LOCAL lcTK
LOCAL hndFile

llTkValido = .F.
lcTicket = ""
lcTK = ""
lcFileTicket = getGlobalCFG("FE_TICKACC")

IF FILE(ALLTRIM(lcFileTicket)) THEN
	hndFile = FOPEN(lcFileTicket, 12)
	IF hndFile < 0 THEN
		=MESSAGEBOX("Error al intentar leer el ticket de acceso", 0+48, Thisform.Caption)
		=FCLOSE(hndFile)
	ELSE
		=FCLOSE(hndFile)
		
		lcTK = FILETOSTR(ALLTRIM(lcFileTicket))
		Thisform.fe.f1RestaurarTicketAcceso(lcTK)
		
		IF Thisform.fe.f1TicketEsValido THEN
			llTkValido = .T.
		ELSE
			llTkValido = .F.
		ENDIF
	ENDIF
	
	IF !llTkValido THEN
		DELETE FILE ALLTRIM(lcFileTicket)
		
		IF Thisform.fe.f1ObtenerTicketAcceso() THEN
			lcTK = Thisform.fe.f1GuardarTicketAcceso()
			hndFile = FCREATE(lcFileTicket)
			
			IF hndFile < 0 THEN
				=MESSAGEBOX("Error al generar el archivo, por favor verifique la ruta se encuentre accesible", 0+48, Thisform.Caption)
			ELSE
				=FWRITE(hndFile, lcTK)
				llTkValido = .T.
			ENDIF
			
			=FCLOSE(hndFile)
		ENDIF
	ENDIF
ELSE
	IF Thisform.fe.f1ObtenerTicketAcceso() THEN
		lcTK = Thisform.fe.f1GuardarTicketAcceso()
		hndFile = FCREATE(lcFileTicket)
		
		IF hndFile < 0 THEN
			=MESSAGEBOX("Error al generar el archivo, por favor verifique la ruta se encuentre accesible", 0+48, Thisform.Caption)
		ELSE
			=FWRITE(hndFile, lcTK)
			llTkValido = .T.
		ENDIF
		
		=FCLOSE(hndFile)
	ENDIF
ENDIF

RETURN llTkValido
ENDPROC
PROCEDURE buscar_en_retiros
PARAMETERS tnIdArticulo
LOCAL lnResult

lnResult = -1

DO WHILE !EOF("cur_Retiros")
	IF cur_Retiros.idArticulo = tnIdArticulo ;
		.AND. cur_Retiros.facturar THEN
		lnResult = cur_Retiros.idRetiroD
		IF RECNO() < RECCOUNT() THEN
			SELECT cur_Retiros
			SKIP
		ENDIF
		RETURN lnResult
	ENDIF

	SELECT cur_Retiros
	SKIP
ENDDO

RETURN lnResult
ENDPROC
PROCEDURE imprimir
LOCAL m.NroCli, m.RazSoc, m.Telefono, m.direccion, m.localidad, m.codPostal, m.pcia, m.TipoIVA, m.nroCUIT
LOCAL m.Total, m.tipoDoc, m.NroCbte, m.Fecha, m.leyenda, m.fecVto, m.tipoDoc, m.ptoVta
LOCAL m.porDesc1, m.porDesc2, m.porDesc3, m.porDesc4
LOCAL m.impDesc1, m.impDesc2, m.impDesc3, m.impDesc4
LOCAL m.porIIBB, m.impIIBB, m.observ, m.vendedor, m.nroOC
LOCAL m.porIVA105, m.impIVA105, m.porIVA21, m.impIVA21, m.impNeto, m.impFinal
LOCAL lcSql, loNumerador, lcPrinterName, lnCantCpia
LOCAL m.cae, m.caevto, lcDia, lcMes, lcAnio
LOCAL m.codigoCbte, m.barcode, m.saldoDeudor, m.code
LOCAL lnIdNum, lcNomEmp

loNumerador = CREATEOBJECT("odbc_result")
lcSql = ""
m.NroCli = Thisform.contenido.sel_Cliente.txtCodigo.Value
m.RazSoc = Thisform.contenido.sel_Cliente.txtDescripcion.Value
m.Telefono = ALLTRIM(Thisform.cli_telefono)
m.direccion = ALLTRIM(Thisform.cli_calle)
m.localidad = ALLTRIM(Thisform.cli_localidad)
m.codPostal = ALLTRIM(Thisform.cli_codPostal)
m.pcia = ALLTRIM(Thisform.cli_Pcia)
m.nroCUIT = ALLTRIM(Thisform.cli_cuit)
m.TipoIVA = Thisform.Contenido.txtSitIVA.Value
m.Total = 0.00
m.tipoDoc = ""
m.ptoVta = ""
m.NroCbte = ""
m.leyenda = ""
m.Fecha = DATETIME()
m.porIVA105 = 0.00
m.porIVA21 = 0.00
m.impIVA105 = 0.00
m.impIVA21 = 0.00
m.impNeto = 0.00
m.impFinal = 0.00
m.fecVto = DATE() + thisform.cp_cntdias
m.tipoDoc = Thisform.tipodoc
m.porIIBB = 0.00
m.impIIBB = 0.00
lnCantCpia = 0
m.observ = ""
m.vendedor = ALLTRIM(thisform.contenido.sel_vendedor.txtDescripcion.Value)
m.cae = thisform.aut_cae
m.codigoCbte = REPLICATE("0", 2 - LEN(ALLTRIM(STR(Thisform.fe.F1CabeceraCbteTipo)))) + ALLTRIM(STR(Thisform.fe.F1CabeceraCbteTipo))
m.barcode = ""
m.saldoDeudor = Thisform.saldodeudor
m.code = ""
lnIdNum = 0
m.nroOC = Thisform.contenido.txtoc.Value
lcNomEmp = getconfig("NOMEMP")

lcAnio = SUBSTR(Thisform.aut_cae_vto, 1, 4)
lcMes = SUBSTR(Thisform.aut_cae_vto, 5, 2)
lcDia = SUBSTR(Thisform.aut_cae_vto, 7, 2)

m.caevto = lcDia + "/" + lcMes + "/" + lcAnio
m.ptovta = INT(VAL(ALLTRIM(getconfig("PTOVTA"))))

&& Levanto el talonario del numerador solo para tomar la configuración de la impresora
lcSql = "select * from numerador where cbte = '" + ALLTRIM(Thisform.cbte) + "' and tipoDoc = '" + ALLTRIM(m.tipoDoc) + "' AND ptoVta = " + ALLTRIM(STR(m.ptoVta))

loNumerador = CREATEOBJECT("odbc_result")
loNumerador.ActiveConnection = goConn.ActiveConnection
loNumerador.Cursor_Name = "cur_num"
loNumerador.OpenQuery(lcSql)

SELECT cur_num
lnIdNum = cur_num.idNum

loNumerador.close_query()

&& Levanto la impresora configurada en el puesto de trabajo actual
lcSql = "SELECT * FROM impresoras WHERE hostName = '" + ALLTRIM(SYS(0)) + "' AND "
lcSql = lcSql + "idNum = " + ALLTRIM(STR(lnIdNum))

loNumerador.ActiveConnection = goConn.ActiveConnection
loNumerador.Cursor_Name = "cur_imp"

IF !loNumerador.OpenQuery(lcSql) THEN
	MESSAGEBOX(loNumerador.Error_Message, 0+48, Thisform.Caption)
	RETURN
ENDIF

SELECT cur_imp
IF RECCOUNT("cur_imp") = 0 THEN
	MESSAGEBOX("La impresora no se encuentra configurada en el puesto de trabajo actual", 0+48, Thisform.Caption)
	loNumerador.Close_Query()
	RETURN
ENDIF

lcPrinterName = ALLTRIM(cur_imp.impresora)
lnCantCpia = cur_imp.copias

loNumerador.Close_Query()

IF ALLTRIM(Thisform.cbte) == "FC" THEN
	m.NroCbte = REPLICATE("0", 4 - LEN(ALLTRIM(STR(Thisform.ptovta)))) + ALLTRIM(STR(Thisform.ptovta)) + "-" + REPLICATE("0", 8 - LEN(ALLTRIM(STR(Thisform.nrocbte)))) + ALLTRIM(STR(Thisform.nrocbte))
ELSE
	m.NroCbte = ALLTRIM(Thisform.ptovta) + "-" + REPLICATE("0", 8 - LEN(ALLTRIM(STR(Thisform.nrocbte)))) + ALLTRIM(STR(Thisform.nrocbte))
ENDIF

IF ALLTRIM(Thisform.cbte) == "COT"
	m.leyenda = "PRESUPUESTO"
	m.tipoDoc = "X"
	m.Total = cur_Subtotal.totFact
ELSE 
	IF ALLTRIM(Thisform.cbte) == "PTO"
		m.leyenda = "PRESUPUESTO"
		m.tipoDoc = "X"
		m.Total = cur_Subtotal.impFinal
	ELSE
		IF ALLTRIM(Thisform.cbte) == "PED"
			m.leyenda = "NOTA DE PEDIDO"
			m.tipoDoc = "P"
			m.Total = Thisform.contenido.txtTotFact.Value
		ELSE
			IF ALLTRIM(Thisform.Cbte) == "FC"
				m.leyenda = "FACTURA"
				m.Total = cur_Subtotal.totFact
			ELSE
				IF ALLTRIM(Thisform.Cbte) == "NC"
					m.Leyenda = "NOTA DE CREDITO"
					m.Total = cur_Subtotal.totFact
				ELSE
					IF ALLTRIM(Thisform.Cbte) == "ND"
						m.leyenda = "NOTA DE DEBITO"
						m.Total = cur_Subtotal.totFact
					ENDIF
				ENDIF
			ENDIF
		ENDIF
	ENDIF
ENDIF

m.NroCli = clientes.idCliente
m.RazSoc = clientes.razSoc
m.Telefono = clientes.telefono

IF (ALLTRIM(Thisform.cbte) == "NC") .OR. (ALLTRIM(Thisform.cbte) == "FC") .OR. (ALLTRIM(Thisform.cbte) == "PTO") .OR. (ALLTRIM(Thisform.cbte) == "COT") THEN
	m.porDesc1 = cur_Subtotal.porDesc1 
	m.porDesc2 = cur_Subtotal.porDesc2 
	m.porDesc3 = cur_Subtotal.porDesc3 
	m.porDesc4 = cur_Subtotal.porDesc4 
	m.impDesc1 = cur_Subtotal.impDesc1
	m.impDesc2 = cur_Subtotal.impDesc2
	m.impDesc3 = cur_Subtotal.impDesc3
	m.impDesc4 = cur_Subtotal.impDesc4
	m.porIVA105 = cur_Subtotal.porIVA105
	m.porIVA21 = cur_Subtotal.porIVA21
	m.impIVA105 = cur_Subtotal.impIVA105
	m.impIVA21 = cur_Subtotal.impIVA21
	m.impNeto = cur_Subtotal.impFinal
	m.impFinal = cur_Subtotal.impFinal
	m.porIIBB = cur_Subtotal.porIIBB
	m.impIIBB = cur_Subtotal.impIIBB
	
	SELECT cur_aux
ELSE 
	m.porDesc1 = Thisform.Contenido.txtDesc1.Value
	m.porDesc2 = Thisform.Contenido.txtDesc2.Value
	m.porDesc3 = Thisform.Contenido.txtDesc3.Value
	m.porDesc4 = Thisform.Contenido.txtDesc4.Value
	m.impDesc1 = Thisform.Contenido.txtImpDesc1.Value
	m.impDesc2 = Thisform.Contenido.txtImpDesc2.Value
	m.impDesc3 = Thisform.Contenido.txtImpDesc3.Value
	m.impDesc4 = Thisform.Contenido.txtImpDesc4.Value
	m.porIVA105 = Thisform.contenido.txtPorIVA105.Value
	m.porIVA21 = Thisform.Contenido.txtPorIVA21.value
	m.impIVA105 = Thisform.Contenido.txtImpIVA105.Value
	m.impIVA21 = Thisform.Contenido.txtImpIVA21.Value
	m.impNeto = Thisform.Contenido.txtST.Value
	m.impFinal = Thisform.Contenido.txtTotFact.Value
	m.porIIBB = Thisform.Contenido.txtPorIIBB.Value
	m.impIIBB = Thisform.Contenido.txtImpIIBB.Value
	
	SELECT cur_detalle
ENDIF 

m.observ = thisform.contenido.txtObserv.Value

&& Generación del código de barra
m.barcode = ALLTRIM(Thisform.cli_cuit)
m.barcode = m.barcode + ALLTRIM(m.codigoCbte)
m.barcode = m.barcode + REPLICATE("0", 4 - LEN(ALLTRIM(STR(m.ptovta)))) + ALLTRIM(STR(m.ptovta))
m.barcode = m.barcode + ALLTRIM(m.cae)
m.barcode = m.barcode + ALLTRIM(lcAnio)
m.barcode = m.barcode + REPLICATE("0", 2 - LEN(ALLTRIM(lcMes))) + ALLTRIM(lcMes)
m.barcode = m.barcode + REPLICATE("0", 2 - LEN(ALLTRIM(lcDia))) + ALLTRIM(lcDia)
m.barcode = m.barcode + ALLTRIM(STR(Thisform.calc_digito_verificador(m.barcode)))
m.code = m.barcode
m.barcode = getcodbarras(m.barcode)

IF thisform.printcbte THEN
	SET PRINTER TO NAME ALLTRIM(lcPrinterName)
	FOR i = 1 TO lnCantCpia
		IF (this.cbte == "COT") THEN
			&& Imprime un presupuesto
			SELECT cur_aux
			REPORT FORM "repcot.frx" TO PRINTER NOCONSOLE
		ELSE
			IF (this.cbte == "PTO") THEN
				&& Imprime un presupuesto
				SELECT cur_aux
				REPORT FORM "reppto.frx" TO PRINTER NOCONSOLE
			ELSE
				&& Si el comprobante es "PED" entonces, tiene que enviar a imprimir una nota de pedido
				IF ALLTRIM(Thisform.cbte) == "PED" THEN
					SELECT cur_detalle
					m.observ = Thisform.contenido.txtObserv.Value
					REPORT FORM "reppedido.frx" TO PRINTER NOCONSOLE
				ELSE 
					IF ALLTRIM(Thisform.tipodoc) == "A" THEN
						&& Imprime el comprobante de tipo "A"
						SELECT cur_aux
						REPORT FORM "repcbtesvta.frx" TO PRINTER NOCONSOLE
					ELSE
						&& Imprime el comprobante de tipo "B"
						SELECT cur_aux
						REPORT FORM "repcbtesvta_b.frx" TO PRINTER NOCONSOLE
					ENDIF
				ENDIF
			ENDIF
		ENDIF
	NEXT
ENDIF

IF thisform.envcbte THEN
	lcFileName = SYS(5) + SYS(2003) + "\wsafip\ComprobantesPDF\" + this.cbte + "_" + m.NroCbte + ".pdf"
	
	loPDF = CREATEOBJECT("Bullzip.PDFPrinterSettings")
		loPDF.SetValue('output', lcFileName)
		loPDF.SetValue('DisableOptionDialog', 'no') 
		loPDF.SetValue('ConfirmOverwrite', 'no')
		loPDF.SetValue('Showsettings', 'never') 
		loPDF.SetValue('ShowSaveAS', 'nofile') 
		loPDF.SetValue('ShowPdf', 'no') 
		loPDF.WriteSettings(.t.)
	
	SET CONSOLE OFF
	SET PRINTER TO NAME("Bullzip PDF Printer")
	IF ALLTRIM(Thisform.tipodoc) == "A" THEN
		&& Imprime el comprobante de tipo "A"
		SELECT cur_aux
		REPORT FORM "repcbtesvta.frx" NOCONSOLE TO PRINTER
	ELSE
		&& Imprime el comprobante de tipo "B"
		SELECT cur_aux
		REPORT FORM "repcbtesvta_b.frx" NOCONSOLE TO PRINTER
	ENDIF
	SET PRINTER TO DEFAULT
	SET CONSOLE ON
	
	WAIT WINDOW "El archivo PDF se está generando, aguarde unos segundos..." NOWAIT
	DO WHILE !FILE(lcFileName)
		
	ENDDO
	
	TEXT TO lcMailMsg NOSHOW
	Estimado cliente,
	Le adjuntamos el comprobante electrónico de su compra en formato PDF.
	
	Muchas gracias!
	Saludos cordiales,
	
	ENDTEXT
	lcMailMsg = lcMailMsg + lcNomEmp

	&& Procedo a hacer el envío de mail
	DO LOCFILE("FoxyPreviewer.App")
	WITH _screen.oFoxyPreviewer	
		.cEmailType = "PDF"
		.nEmailMode = 2
		.cEMailTo = thisform.mailfc
		.cSMTPServer = getGlobalCFG("EMAILSMTP")
		.cEmailFrom = lcNomEmp + "<" + getGlobalCFG("EMAILADDR") + ">"
		.cEMailSubject = "Comprobante Electrónico " + this.cbte + " " + m.NroCbte
		.nSMTPPort = INT(VAL(getGlobalCFG("EMAILPORT")))
		.lSMTPUseSSL = getGlobalCFG("EMAILSSL")
		.cSMTPUserName = getGlobalCFG("EMAILADDR")
		.cSMTPPassword = getGlobalCFG("EMAILPWD")
		.lReadReceipt  = .F.
		.lPriority = .F.
		.cEmailBody = lcMailMsg
		.SendEmailUsingCDO(lcFileName)
	ENDWITH	
ENDIF


ENDPROC
PROCEDURE Load
DODEFAULT()

&& El siguien cursor es para generar los registros de aquellos artículos
&& que se le debe hacer el movimiento de salida de stock

CREATE CURSOR cur_movstock (	;
	idArticulo	int,;
	codArt		varchar(20),;
	nroPart		varchar(30),;
	cantidad	int)

&& El siguiente cursor contiene la facturación de servicios
CREATE CURSOR cur_servicios (	;
	sel			l,;
	idServ		int,;
	idCliente	int,;
	descripcio	varchar(60),;
	vendedor varchar(60),;
	cantidad	float(10, 2),;
	precio		float(10, 2),;
	subTotal	float(10, 2),;
	usuAlta		varchar(5),;
	fecAlta		datetime,;
	idHostAlta	varchar(60),;
	usuFact		varchar(5),;
	fecFact		datetime,;
	idHostFact	varchar(60))
ENDPROC
PROCEDURE grabar_cbte_part
&& Grabo la info en la base

LOCAL lnIdVentasC, lnIdCliente, lcFecEmis, lcCbte, lcTipoDoc, lnPtoVta
LOCAL lnNroCbte, llAnulado, lnImpNeto, lnImpFinal, lnPorIVA21, lnImpIVA21
LOCAL lnPorIVA105, lnImpIVA105, lnPorDesc1, lnPorDesc2, lnPorDesc3, lnPorDesc4
LOCAL lnImpDesc1, lnImpDesc2, lnImpDesc3, lnImpDesc4, lnTotFact
LOCAL lnIdVentasD, lnIdArticulo, lnCantidad, lnCostoRep, lnPrVenta, lnAlicIVA, lnImpIVA
LOCAL lnTotNeto, lnSubTotal, lnSaldo, lcObserv, lnPorIIBB, lnImpIIBB
LOCAL lnPDtoVta1, lnPDtoVta2, lnPDtoVta3, lnPDtoVta4, lnIDtoVta1, lnIDtoVta2, lnIDtoVta3, lnIDtoVta4
LOCAL lnIdCondPago, lnIdSitIVA, lnPrArtic
LOCAL ldFecVto, lnIdOper, oDT
LOCAL loNumerador, lcSql, loCommand, loArtic, loOper, lnSqlSrv, lnPrNeto, lnIdCCOrig, loCliente, lnIdVendedor
LOCAL loConDMO, loResult, lnResto, lnIntentos

&& Inicializo las variables del detalle

loResult = CREATEOBJECT("odbc_result")
lnIdVentasD = 0
lnIdArticulo = 0
lnCantidad = 0.00
lnCostoRep = 0.00
lnPrVenta = 0.00
lnAlicIVA = 0.00
lnImpIVA = 0.00
lnTotNeto = 0.00
lnSubTotal = 0.00
ldFecVto = {}
lnIdOper = 0
lnSaldo = 0
oDT = CREATEOBJECT("datetime")
loArtic = CREATEOBJECT("odbc_result")
loOper = CREATEOBJECT("odbc_result")
loCliente = CREATEOBJECT("odbc_result")
loCommand = CREATEOBJECT("odbc_command")
lnSqlSrv = INT(VAL(getconfig("SQLSRV")))
lcObserv = Thisform.Contenido.txtObserv.Value
lnPorIIBB = 0.00
lnImpIIBB = 0.00
lnPDtoVta1 = 0.00
lnPDtoVta2 = 0.00
lnPDtoVta3 = 0.00
lnPDtoVta4 = 0.00
lnIDtoVta1 = 0.00
lnIDtoVta2 = 0.00
lnIDtoVta3 = 0.00
lnIDtoVta4 = 0.00
lnPrNeto = 0.00
lnIdCondPago = 0
lnIdSitIVA = 0
lnIdVendedor = 0
loConDMO = CREATEOBJECT("odbc_connect")
lnPrArtic = 0.00
lnResto = 0.00
lnPorRec = 0.00
lnImpRec = 0.00
lnUniDesp = 0.00
lnCantPack = 0.00
lcUniMed = ""

lcCbte = Thisform.Cbte

IF ALLTRIM(lcCbte) == "PTO" THEN
	&& Si es un comprobante PTO, entonces, abro la base DMO para generar el registro.

	loConDMO.ConnectionString = ALLTRIM(getConfig("DMO_CC"))

	IF !loConDMO.Open() THEN
		MESSAGEBOX(loConDMO.ErrorMessage, 0+48, Thisform.Caption)
		RETURN .F.
	ENDIF
ENDIF

&& Asigno los valores de la cabecera

lnIdCliente = Thisform.Contenido.sel_Cliente.ValCpoId
lnIdVendedor = Thisform.Contenido.sel_vendedor.valcpoid

&& Asigno el idvendedor
lcSql = "SELECT * FROM clientes WHERE idCliente = " + ALLTRIM(STR(lnIdCliente))
loCliente.ActiveConnection = goConn.ActiveConnection
loCliente.Cursor_Name = "cur_cliente"
loCliente.OpenQuery(lcSql)

lnIdVendedor = cur_cliente.idVendedor

loCliente.Close_Query()

lcFecEmis = ALLTRIM(STR(YEAR(DATETIME()))) + "-" + ALLTRIM(STR(MONTH(DATETIME()))) + " - " + ;
	ALLTRIM(STR(DAY(DATETIME())))

IF lcCbte == "COT"
	lcTipoDoc = "X"
	Thisform.tipodoc = lcTipoDoc
ELSE
	&& Aca tengo que agregar el cálculo en caso que sea
	&& comprobante fiscal
	IF lcCbte == "PED"
		lcTipoDoc = "P"
		Thisform.tipodoc = lcTipoDoc
	ELSE
		lcTipoDoc = thisform.calcular_tipodoc()
		Thisform.tipodoc = lcTipoDoc
	ENDIF
ENDIF

IF lcCbte == "PTO" THEN
	lnPtoVta = 9999
	lcTipoDoc = "X"
	Thisform.tipodoc = lcTipoDoc
ELSE
	lnPtoVta = INT(VAL(ALLTRIM(getconfig("PTOVTA"))))
ENDIF

Thisform.ptovta = REPLICATE("0", 4 - LEN(ALLTRIM(STR(lnPtoVta)))) + ALLTRIM(STR(lnPtoVta))
	
lcSql = "select * from numerador where cbte = '" + ALLTRIM(lcCbte) + "' and tipoDoc = '" + ALLTRIM(lcTipoDoc) + "' AND ptoVta = " + ALLTRIM(STR(lnPtoVta))
loNumerador = CREATEOBJECT("odbc_result")

&& Si es PTO entonces asigno la conexión activa correspondiente a la base DMO
&& En caso contrario, apunto a la base REAL
IF ALLTRIM(lcCbte) == "PTO" THEN
	loNumerador.ActiveConnection = loConDMO.ActiveConnection
ELSE
	loNumerador.ActiveConnection = goConn.ActiveConnection
ENDIF

loNumerador.Cursor_Name = "cur_num"
loNumerador.OpenQuery(lcSql)
SELECT cur_num

IF RECCOUNT("cur_num") = 0 THEN
	MESSAGEBOX("No se encuentra configurado el numerador del comprobante " + ALLTRIM(lcCbte) + " Punto de Venta: " + ALLTRIM(STR(lnPtoVta)) + " Letra: " + ALLTRIM(lcTipoDoc), 0+48, thisform.Caption)
	loNumerador.close_query()
	RETURN .F.
ENDIF

IF !ALLTRIM(thisform.cbte) == "PTO" THEN
	IF DATE() > cur_Num.fecVto THEN
		MESSAGEBOX("El talonario actual está vencido, por favor, verifique que su talonario se encuentre en orden", 0+48, Thisform.Caption)
		loNumerador.close_query()
		RETURN .F.
	ENDIF
ENDIF

SELECT cur_num
&& lnNroCbte = cur_num.numActual + 1
Thisform.printerDevice = cur_num.impresora
Thisform.cant_copias = cur_num.cantCpia

loNumerador.close_query()

lnNroCbte = 0

&& Esta rutina genera intentos
lnIntentos = 0 
DO WHILE thisform.num_bloqueado()
	WAIT WINDOW "OTRO USUARIO ESTA EMITIENDO UNA FACTURA,AGUARDE POR FAVOR... (Intetnos: " + ALLTRIM(STR(lnIntentos)) + ")"  NOWAIT
	lnIntentos = lnIntentos + 1
ENDDO

&& Bloqueo el numerador
thisform.bloquear_numerador()

IF ALLTRIM(lcCbte) == "PTO" THEN
	loConDMO.BeginTransaction()	
ELSE
	goConn.BeginTransaction()
ENDIF

&& Actualizo el numerador
lcSql = "update numerador set numActual = " + ALLTRIM(STR(lnNroCbte)) + ;
	" where cbte = '" + ALLTRIM(lcCbte) + "' and tipoDoc = '" + ALLTRIM(lcTipoDoc) + "' and ptoVta = " + ALLTRIM(STR(lnPtoVta))

IF ALLTRIM(lcCbte) == "PTO" THEN
	loCommand.ActiveConnection = loConDMO.ActiveConnection
	loCommand.CommandText = lcSql

	IF !loCommand.Execute()
		thisform.desbloq_numerador()
		loConDMO.Rollback()
		RETURN .F.
	ENDIF	
ELSE
	loCommand.ActiveConnection = goConn.ActiveConnection
	loCommand.CommandText = lcSql

	IF !loCommand.Execute()
		thisform.desbloq_numerador()
		goConn.Rollback()
		RETURN .F.
	ENDIF	
ENDIF


llAnulado = .F.
lnImpNeto = cur_Subtotal.impNeto
lnImpFinal = cur_Subtotal.impFinal
lnPorIVA21 = cur_Subtotal.porIVA21
lnPorIVA105 = cur_Subtotal.porIVA105
lnImpIVA21 = cur_Subtotal.impIVA21
lnImpIVA105 = cur_Subtotal.impIVA105
lnPorIIBB= cur_Subtotal.porIIBB
lnImpIIBB = cur_Subtotal.impIIBB
lnPorDesc1 = cur_Subtotal.porDesc1
lnPorDesc2 = cur_Subtotal.porDesc2
lnPorDesc3 = cur_Subtotal.porDesc3
lnPorDesc4 = cur_Subtotal.porDesc4
lnImpDesc1 = cur_Subtotal.impDesc1
lnImpDesc2 = cur_Subtotal.impDesc2
lnImpDesc3 = cur_Subtotal.impDesc3
lnImpDesc4 = cur_Subtotal.impDesc4
lnTotFact = cur_Subtotal.totFact
lnIdCondPago = clientes.idCondPago
lnIdSitIVA = clientes.idSitIVA
lnPorRec = cur_Subtotal.porRec
lnImpRec = cur_Subtotal.impRec

IF ALLTRIM(thisform.cbte) == "PTO"
	lnIdVentasC = loConDMO.GetNextID("ventascab", "idVentasC")
ELSE
	lnIdVentasC = goConn.GetNextID("ventascab", "idVentasC")
ENDIF

Thisform.id_ventasc = lnIdVentasC

&& Calculo la fecha de vencimiento correspondiente a la factura
IF ALLTRIM(Thisform.cbte) == "FC" THEN 
	IF thisform.cp_cntdias <> 0 THEN
		ldFecVto = DATE() + thisform.cp_cntdias
	ELSE
		ldFecVto = DATE()
	ENDIF 
ELSE
	ldFecVto = DATE()
ENDIF

IF ALLTRIM(Thisform.cbte) == "FC" .OR. ALLTRIM(Thisform.cbte) == "PTO" THEN
	lnSaldo = lnTotFact
ELSE
	lnSaldo = 0
ENDIF
	
lcSql = "INSERT INTO ventascab ( "
lcSql = lcSql + "idVentasC, idCliente, razSoc, idTipoDoc, nroDoc, fecEmision, cbte, tipoDoc, ptoVta, numCbte, anulado, idCondPago, idSitIVA, idVendedor,"
lcSql = lcSql + "impNeto, impFinal, porIVA21, impIVA21, porIVA105, impIVA105, porDesc1, "
lcSql = lcSql + "porDesc2, porDesc3, porDesc4, impDesc1, impDesc2, impDesc3, impDesc4, totFact, Saldo, usuAlta, fecAlta, idHostAlta, observ, porIIBB, impIIBB, fecVto, porRec, impRec) VALUES ("
lcSql = lcSql + ALLTRIM(STR(lnIdVentasC)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnIdCliente)) + ", "
lcSql = lcSql + "'" + STRTRAN(ALLTRIM(Thisform.Contenido.sel_cliente.txtDescripcion.Value), "'", "''") + "', "
lcSql = lcSql + ALLTRIM(STR(Thisform.cli_idTipoDoc)) + ", "
lcSql = lcSql + "'" + ALLTRIM(Thisform.contenido.txtCuit.Value) + "', "
lcSql = lcSql + oDT.getDateTime() + ", "
lcSql = lcSql + "'" + IIF(ALLTRIM(lcCbte) == "PTO", "FC", ALLTRIM(lcCbte)) + "', "
lcSql = lcSql + "'" + ALLTRIM(lcTipoDoc) + "', "
lcSql = lcSql + ALLTRIM(STR(lnPtoVta)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnNroCbte)) + ", "
lcSql = lcSql + IIF(lnSqlSrv = 0, "false", "0") + ", "
lcSql = lcSql + ALLTRIM(STR(lnIdCondPago)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnIdSitIVA)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnIdVendedor)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnImpNeto, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnImpFinal, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnPorIVA21, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnImpIVA21, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnPorIVA105, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnImpIVA105, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnPorDesc1, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnPorDesc2, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnPorDesc3, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnPorDesc4, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnImpDesc1, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnImpDesc2, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnImpDesc3, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnImpDesc4, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnTotFact, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnSaldo, 10, 2)) + ", "
lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', " 
lcSql = lcSql + oDT.getDateTime() + ", "
lcSql = lcSql + "'" + SYS(0) + "', '" + ALLTRIM(lcObserv) + "', "
lcSql = lcSql + ALLTRIM(STR(lnPorIIBB, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnImpIIBB, 10, 2)) + ", "
lcSql = lcSql + oDT.toMySql(ldFecVto) + ","
lcSql = lcSql + ALLTRIM(STR(lnPorRec, 10, 2)) + ", "
lcSql = lcSql + ALLTRIM(STR(lnImpRec, 10, 2)) + ")"

loCommand.CommandText = lcSql

IF ALLTRIM(lcCbte) == "PTO" THEN
	loCommand.ActiveConnection = loConDMO.ActiveConnection
	
	IF !loCommand.Execute()
		thisform.desbloq_numerador()
		loConDMO.Rollback()
		RETURN .F.
	ENDIF	
ELSE
	loCommand.ActiveConnection = goConn.ActiveConnection
	IF !loCommand.Execute()
		thisform.desbloq_numerador()
		goConn.Rollback()
		RETURN .F.
	ENDIF
ENDIF

&& Grabo el detalle del comprobante

SELECT cur_aux
IF RECCOUNT() > 0
	GO TOP
ENDIF

lnIdVentasD = 0

DO WHILE !EOF()
	lnIdVentasD = lnIdVentasD + 1
	
	lnIdArticulo = cur_aux.idArticulo
	lnCantidad = cur_aux.cantidad
	lnAlicIVA = cur_aux.alicIVA
	lnPrVenta = cur_aux.PrVta
	lnImpIVA = cur_aux.impIVA
	lnPrNeto = cur_aux.impNeto
	lnTotNeto = cur_aux.totNeto
	lnSubTotal = cur_aux.subTotal
	lnPDtoVta1 = cur_aux.pDtoVta1
	lnPDtoVta2 = cur_aux.pDtoVta2
	lnPDtoVta3 = cur_aux.pDtoVta3
	lnPDtoVta4 = cur_aux.pDtoVta4
	lnIDtoVta1 = cur_aux.iDtoVta1
	lnIDtoVta2 = cur_aux.iDtoVta2
	lnIDtoVta3 = cur_aux.iDtoVta3
	lnIDtoVta4 = cur_aux.iDtoVta4
	
	lnPorDesc1 = cur_aux.pDtoCli1
	lnPorDesc2 = cur_aux.pDtoCli2
	lnPorDesc3 = cur_aux.pDtoCli3
	lnPorDesc4 = cur_aux.pDtoCli4
	lnImpDesc1 = cur_aux.iDtoCli1
	lnImpDesc2 = cur_aux.iDtoCli2
	lnImpDesc3 = cur_aux.iDtoCli3
	lnImpDesc4 = cur_aux.iDtoCli4
	
	lnPrArtic = cur_aux.prArtic
	lnPorRec = cur_aux.pRecVta
	lnImpRec = cur_aux.iRecVta
	lnUniDesp = cur_aux.uniDesp
	lnCantPack = cur_aux.cantPack
	lcUniMed = cur_aux.uniMed	
	
	lcSql = "SELECT * FROM articulos WHERE idArticulo = " + ALLTRIM(STR(lnIdArticulo))
	
	IF ALLTRIM(lcCbte) == "PTO" THEN
		loArtic.ActiveConnection = loConDMO.ActiveConnection
	ELSE
		loArtic.ActiveConnection = goConn.ActiveConnection
	ENDIF
	
	loArtic.Cursor_Name = "cur_Artic"
	loArtic.OpenQuery(lcSql)
	
	SELECT cur_Artic
	lnCostoRep = cur_Artic.costoRep
	
	loArtic.close_query()

	lcSql = "INSERT INTO ventasdet ( "
	lcSql = lcSql + "idVentasD, "
	lcSql = lcSql + "idVentasC, "
	lcSql = lcSql + "idArticulo, "
	lcSql = lcSql + "descripcio, "
	lcSql = lcSQl + "nroPart, "
	lcSql = lcSql + "Cantidad, "
	lcSql = lcSql + "costoRep, "
	lcSql = lcSql + "prVenta, "
	lcSql = lcSql + "alicIVA, "
	lcSql = lcSql + "impIVA, "
	lcSql = lcSql + "subTotal, "
	lcSql = lcSql + "porDesc1, "
	lcSql = lcSql + "porDesc2, "
	lcSql = lcSql + "porDesc3, "
	lcSql = lcSql + "porDesc4, "
	lcSql = lcSql + "impDesc1, "
	lcSql = lcSql + "impDesc2, "
	lcSql = lcSql + "impDesc3, "
	lcSql = lcSql + "impDesc4, "
	lcSql = lcSql + "pDtoVta1, "
	lcSql = lcSql + "pDtoVta2, "
	lcSql = lcSql + "pDtoVta3, "
	lcSql = lcSql + "pDtoVta4, "
	lcSql = lcSql + "iDtoVta1, "
	lcSql = lcSql + "iDtoVta2, "
	lcSql = lcSql + "iDtoVta3, "
	lcSql = lcSql + "iDtoVta4, "
	lcSql = lcSql + "impNeto, "
	lcSql = lcSql + "totNeto, "
	lcSql = lcSql + "prArtic, "
	lcSql = lcSql + "pRecVta, "
	lcSql = lcSql + "iRecVta, "
	lcSql = lcSql + "uniDesp, "
	lcSql = lcSql + "cantPack, "	
	lcSql = lcSql + "esOferta) VALUES ( "
	lcSql = lcSql + ALLTRIM(STR(lnIdVentasD)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnIdVentasC)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnIdArticulo)) + ", "
	lcSql = lcSql + "'" + STRTRAN(ALLTRIM(cur_aux.descripcio), "'", "''") + "', "
	lcSql = lcSql + "'" + ALLTRIM(cur_aux.nroPart) + "', "
	lcSql = lcSql + ALLTRIM(STR(lnCantidad, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnCostoRep, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPrVenta, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnAlicIVA, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnImpIVA, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnSubTotal, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPorDesc1, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPorDesc2, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPorDesc3, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPorDesc4, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnImpDesc1, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnImpDesc2, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnImpDesc3, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnImpDesc4, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPDtoVta1, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPDtoVta2, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPDtoVta3, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPDtoVta4, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnIDtoVta1, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnIDtoVta2, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnIDtoVta3, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnIDtoVta4, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPrNeto, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnTotNeto, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPrArtic, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnPorRec, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnImpRec, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnUniDesp, 10, 2)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnCantPack, 10, 2)) + ", "
	lcSql = lcSql + IIF(cur_aux.esOferta, "1", "0") + ")"
		
	*******************************************************************************************
	
	loCommand.CommandText = lcSql

	IF ALLTRIM(lcCbte) == "PTO" 
		loCommand.ActiveConnection = loConDMO.ActiveConnection
		IF !loCommand.Execute()
			thisform.desbloq_numerador()
			loConDMO.Rollback()
			RETURN .F.
		ENDIF	
	ELSE
		loCommand.ActiveConnection = goConn.ActiveConnection
		IF !loCommand.Execute()
			thisform.desbloq_numerador()
			goConn.Rollback()
			RETURN .F.
		ENDIF
	ENDIF	
	
	&& Si es nota de crédito entonces, actualizo la cantidad de NC en los
	&& items de la factura.
	&& Actualizar este dato tiene como objetivo de que si se hace más una NC
	&& que no se pueda hacer dos veces sobre la misma cantidad de un producto
	&& sino que por el resto.
	
*!*		IF ALLTRIM(Thisform.cbte) == "NC" THEN
*!*			lcSql = "UPDATE ventasdet SET cantNC = cantNC + " + ALLTRIM(STR(lnCantidad, 10, 2)) + " "
*!*			lcSql = lcSql + "WHERE idVentasC = " + ALLTRIM(STR(Thisform.idorigen)) + " "
*!*			lcSql = lcSql + " AND idArticulo = " + ALLTRIM(STR(cur_aux.idArticulo))
*!*			
*!*			loCommand.ActiveConnection = goConn.ActiveConnection
*!*			loCommand.CommandText = lcSql
*!*			
*!*			IF !loCommand.Execute() THEN
*!*				thisform.desbloq_numerador()
*!*				goConn.Rollback()
*!*				RETURN .F.
*!*			ENDIF
*!*		ENDIF
	
	SELECT cur_aux
	SKIP
ENDDO

&& Dejo para que grabe solamente si es PTO
&& Condicional origial: IF ALLTRIM(thisform.cbte) == "FC" .OR. ALLTRIM(thisform.cbte) == "PTO" THEN
IF ALLTRIM(thisform.cbte) == "PTO" THEN
	lnProxID = loConDMO.GetNextId("cc_cli", "idCC_Cli")
	lnIdCliente = Thisform.contenido.sel_Cliente.valcpoid
	lnIdOper = goConn.GetNextID("cc_cli", "idOper")
	
	&& Inserto el registro correspondiente a la factura en la tabla de cuentas corrientes
	lcSql = "INSERT INTO cc_cli (idCC_Cli, idCliente, idCC_Orig, cbte, nroCbte, tipoDoc, ptoVta, idCondPago, idSitIVA, idVendedor, "
	lcSql = lcSql + "fecEmis, fecVto, impDebe, impHaber, idOper, idVentasC, usuAlta, fecAlta, idHostAlta) VALUES ( "
	lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", " + ALLTRIM(STR(lnIdCliente)) + ", null, '" + IIF(ALLTRIM(lcCbte) == "PTO", "FC", ALLTRIM(lcCbte)) + "', "
	lcSql = lcSql + ALLTRIM(STR(lnNroCbte)) + ", '" + ALLTRIM(lcTipoDoc) + "', " + ALLTRIM(STR(lnPtoVta)) + ", " + ALLTRIM(STR(lnIdCondPago)) + ", "
	lcSql = lcSql + ALLTRIM(STR(lnIdSitIVA)) + ", " + ALLTRIM(STR(lnIdVendedor)) + ", " + oDT.getDateTime() + ", "
	lcSql = lcsql + oDT.toMySql(ldFecVto) + ", " + ALLTRIM(STR(lnTotFact, 10, 2)) + ", 0, " + ALLTRIM(STR(lnIdOper)) + ", " + ALLTRIM(STR(lnIdVentasC)) + ", "
	lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', " + oDT.getDateTime() + ", '" + ALLTRIM(SYS(0)) + "')"

	IF ALLTRIM(thisform.cbte) == "PTO" THEN	
		loCommand.ActiveConnection = loConDMO.ActiveConnection
	ELSE
		loCommand.ActiveConnection = goConn.ActiveConnection
	ENDIF
	
	loCommand.CommandText = lcSql
	
	IF !loCommand.Execute()
		thisform.desbloq_numerador()
		goConn.Rollback()
		RETURN .F.
	ENDIF
*!*	ELSE
*!*		IF ALLTRIM(Thisform.cbte) == "NC" THEN
*!*			&& Verifico si tiene numero de operación asignado
*!*			lcSql = "SELECT idCC_Cli, idOper FROM cc_cli WHERE idVentasC = " + ALLTRIM(STR(Thisform.idorigen))
*!*			loOper.ActiveConnection = goConn.ActiveConnection
*!*			loOper.Cursor_Name = "cur_Oper"
*!*			loOper.OpenQuery(lcSql)
*!*			
*!*			lnIdCCOrig = cur_Oper.idCC_Cli
*!*			lnIdOper = cur_Oper.idOper
*!*			
*!*			loOper.Close_Query()
*!*			
*!*			&& Tengo que calcular el Id de Operación para vincular ambos comprobantes
*!*			IF lnIdOper = 0 THEN
*!*				lcSql = "SELECT MAX(cc_cli.idOper) AS maxIdOper FROM cc_cli"
*!*				loOper.ActiveConnection = goConn.ActiveConnection
*!*				loOper.Cursor_Name = "cur_Oper"
*!*				loOper.OpenQuery(lcSql)
*!*				
*!*				lnIdOper = cur_Oper.maxIdOper + 1
*!*				
*!*				loOper.Close_Query()
*!*			
*!*				&& Actualizo el comprobante de origen con el Id de Operación calculado
*!*				lcSql = "UPDATE cc_cli SET idOper = " + ALLTRIM(STR(lnIdOper)) + " WHERE idVentasC = " + ALLTRIM(STR(Thisform.idorigen))
*!*				loCommand.ActiveConnection = goConn.ActiveConnection
*!*				loCommand.CommandText = lcSql
*!*			
*!*				IF !loCommand.Execute()
*!*					thisform.desbloq_numerador()
*!*					goConn.Rollback()
*!*					RETURN .F.
*!*				ENDIF	
*!*			ENDIF
*!*			
*!*			&& Genero el registro de la nota de crédito en las cuentas corrientes del cliente
*!*			
*!*			lnProxID = goConn.GetNextId("cc_cli", "idCC_Cli")
*!*			lnIdCliente = Thisform.contenido.sel_Cliente.valcpoid	
*!*			
*!*			lcSql = "INSERT INTO cc_cli (idCC_Cli, idCliente, idCC_Orig, cbte, nroCbte, tipoDoc, ptoVta, idCondPago, idSitIVA, idVendedor, "
*!*			lcSql = lcSql + "fecEmis, fecvto, impDebe, impHaber, idOper, idVentasC, usuAlta, fecAlta, idHostAlta) VALUES ( "
*!*			lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", " + ALLTRIM(STR(lnIdCliente)) + ", " + ALLTRIM(STR(lnIdCCOrig)) + ", '" + ALLTRIM(lcCbte) + "', "
*!*			lcSql = lcSql + ALLTRIM(STR(lnNroCbte)) + ", '" + ALLTRIM(lcTipoDoc) + "', " + ALLTRIM(STR(lnPtoVta)) + ", " + ALLTRIM(STR(lnIdCondPago)) + ", "
*!*			lcSql = lcSql + ALLTRIM(STR(lnIdSitIVA)) + ", " + ALLTRIM(STR(lnIdVendedor)) + ", " + oDT.getDateTime() + ", "
*!*			lcSql = lcsql + oDT.toMySql(ldFecVto) + ", 0, " + ALLTRIM(STR(lnTotFact, 10, 2)) + ", " + ALLTRIM(STR(lnIdOper)) + ", " + ALLTRIM(STR(lnIdVentasC)) + ", "
*!*			lcSql = lcSql + "'" + ALLTRIM(gcCodUsu) + "', " + oDT.getDateTime() + ", '" + ALLTRIM(SYS(0)) + "')"
*!*			
*!*			loCommand.ActiveConnection = goConn.ActiveConnection
*!*			loCommand.CommandText = lcSql
*!*			
*!*			IF !loCommand.Execute()
*!*				thisform.desbloq_numerador()
*!*				goConn.Rollback()
*!*				RETURN .F.
*!*			ENDIF
*!*			
*!*			lnSaldo = Thisform.saldo_fc - lnTotFact 
*!*			
*!*			&& Actualizo el Saldo en la factura para validar que no se pueda
*!*			&& aplicar un importe superior al saldo.
*!*			lcSql = "UPDATE ventascab SET saldo = " + ALLTRIM(STR(lnSaldo, 10, 2)) + ", "
*!*			lcSql = lcSql + "usuModi = '" + ALLTRIM(gcCodUsu) + "', "
*!*			lcSql = lcSql + "fecModi = " + oDT.getDateTime() + ", "
*!*			lcSql = lcSql + "idHostModi = '" + ALLTRIM(SYS(0)) + "' " 				
*!*			lcSql = lcSql + "WHERE idVentasC = " + ALLTRIM(STR(Thisform.idorigen))
*!*			
*!*			loCommand.ActiveConnection = goConn.ActiveConnection
*!*			
*!*			loCommand.CommandText = lcSql
*!*			IF !loCommand.Execute()
*!*				thisform.desbloq_numerador()
*!*				goConn.Rollback()
*!*				RETURN .F.
*!*			ENDIF	
*!*		ENDIF
ENDIF

&& Ahora tengo que generar la relación entre el comprobante de origen con el comprobante
&& de destino
&& Condicional original: IF (ALLTRIM(Thisform.cbte) == "NC") .OR. (ALLTRIM(Thisform.Cbte) == "FC") .OR. (ALLTRIM(Thisform.cbte) == "PTO") THEN
IF (ALLTRIM(Thisform.Cbte) == "FC") .OR. (ALLTRIM(Thisform.cbte) == "PTO") THEN
	IF Thisform.idorigen <> 0 THEN
		IF ALLTRIM(thisform.cbte) == "PTO" THEN
			lnProxID = loConDMO.GetNextId("ventasrel", "idVtaRel")
		ELSE
			lnProxID = goConn.GetNextId("ventasrel", "idVtaRel")
		ENDIF
		
		lcSql = "INSERT INTO ventasrel (idVtaRel, idVtaCO, idVtaCD) VALUES ("
		lcSql = lcSql + ALLTRIM(STR(lnProxID)) + ", " + ALLTRIM(STR(Thisform.idorigen)) + ", " + ALLTRIM(STR(lnIdVentasC)) + ")"
		
		loCommand.CommandText = lcSql

		IF ALLTRIM(lcCbte) == "PTO" 
			loCommand.ActiveConnection = loConDMO.ActiveConnection
			IF !loCommand.Execute()
				thisform.desbloq_numerador()
				loConDMO.Rollback()
				RETURN .F.
			ENDIF	
		ELSE
			loCommand.ActiveConnection = goConn.ActiveConnection
			IF !loCommand.Execute()
				thisform.desbloq_numerador()
				goConn.Rollback()
				RETURN .F.
			ENDIF
		ENDIF
	ENDIF
ENDIF

&& Me paro en la primera posición del cursor de retiros
&& por unica vez
SELECT cur_Retiros
GO TOP

&& Actualizo los registros del retiro
SELECT cur_aux
IF RECCOUNT("cur_aux") > 0 THEN
	GO TOP
ENDIF

DO WHILE !EOF("cur_aux")
	lcSql = "SELECT	idArticulo, idRetiroC, idRetiroD, cantidad "
	lcSql = lcSql + "FROM retirosdet "
	lcSql = lcSql + "WHERE idRetiroC = " + ALLTRIM(STR(this.idretiroc)) + " "
	lcSql = lcSql + "	AND idRetiroD = " + ALLTRIM(STR(Thisform.buscar_en_retiros(cur_aux.idArticulo))) + " "
	lcSql = lcsql + "ORDER BY retirosdet.cantidad ASC"
	
	IF ALLTRIM(thisform.cbte) == "PTO" THEN
		loResult.ActiveConnection = loConDMO.ActiveConnection
	ELSE
		loResult.ActiveConnection = goConn.ActiveConnection
	ENDIF
	
	loResult.Cursor_Name = "cur_artret"
	
	IF !loResult.OpenQuery(lcSql) THEN
		MESSAGEBOX(loResult.Error_Message, 0+48, thisform.Caption)
		
		IF ALLTRIM(thisform.cbte) == "PTO" THEN
			thisform.desbloq_numerador()
			loConDMO.Rollback()
			loConDMO.close()
		ELSE
			thisform.desbloq_numerador()
			goCon.Rollback()
		ENDIF
	ENDIF
	
	lnResto = cur_aux.cantidad
	
	SELECT cur_artret
	GO TOP
	DO WHILE !EOF("cur_artret")
		lcSql = "UPDATE retirosdet SET "
		
		&& Solamente marco el retiro como facturado si se facturó el 100% de la cantidad
		&& correspondiente al retiro.
		
		IF (cur_artret.cantidad - lnResto) <= 0 THEN
			lcSql = lcSql + "	 retirosdet.facturado = 1, "
		ELSE
			lcSql = lcSql + "	 retirosdet.facturado = 0, "
		ENDIF
		
		lcSql = lcSql + "	 retirosdet.idVentasC = " + ALLTRIM(STR(Thisform.id_ventasc)) + ", "
		lcSql = lcSql + "	 retirosdet.cbte = '" + ALLTRIM(lcCbte) + "', "
		lcSql = lcSql + "	 retirosdet.tipoDoc = '" + ALLTRIM(lcTipoDoc) + "', "
		lcSql = lcSql + "	 retirosdet.ptoVta = " + ALLTRIM(STR(lnPtoVta)) + ", "
		lcSql = lcSql + "	 retirosdet.nroCbte = " + ALLTRIM(STR(lnNroCbte)) + ", "
		
		IF lnResto >= cur_artret.cantidad THEN
			lcSql = lcSql + "	 retirosdet.fecFact = " + oDT.getDateTime() + ", "
			lcSql = lcSql + " retirosdet.cantFact = " + ALLTRIM(STR(cur_artret.cantidad, 10, 2)) + " "
		ELSE
			IF lnResto < 0 THEN
				lcSql = lcSql + " retirosdet.cantFact = 0 "
			ELSE
				lcSql = lcSql + " retirosdet.cantFact = " + ALLTRIM(STR(lnResto, 10, 2)) + " "
			ENDIF
		ENDIF
		
		lcSql = lcSql + "WHERE retirosdet.idRetiroC = " + ALLTRIM(STR(this.idretiroc)) + " "
		lcSql = lcSql + " AND retirosdet.idRetiroD = " + ALLTRIM(STR(cur_artret.idRetiroD)) + " "
		
		
		IF ALLTRIM(thisform.cbte) == "PTO" THEN
			loCommand.ActiveConnection = loConDMO.ActiveConnection
		ELSE
			loCommand.ActiveConnection = goConn.ActiveConnection
		ENDIF
		
		loCommand.CommandText = lcSql
		
		IF !loCommand.Execute() THEN
			MESSAGEBOX(loCommand.ErrorMessage, 0+48, Thisform.Caption)
			
			IF ALLTRIM(thisform.cbte) == "PTO" THEN
				thisform.desbloq_numerador()
				loConDMO.Rollback()
			ELSE
				thisform.desbloq_numerador()
				goConn.Rollback()
			ENDIF
			
			RETURN .F.
		ENDIF
		
		lnResto = lnResto - cur_artret.cantidad
		SELECT cur_artret
		SKIP
	ENDDO
	
	loResult.close_query()

	SELECT cur_aux
	SKIP
ENDDO

* A continuación verifico si hay artículos que corresponde hacer el movimiento de stock
* para esta factura.

thisform.generar_reg_stock()
SELECT cur_movstock
IF RECCOUNT("cur_movstock") > 0 THEN
	IF getGlobalCFG("STK_MODULE") .AND. (ALLTRIM(Thisform.cbte) <> "COT" .OR. ALLTRIM(Thisform.cbte) <> "NC") THEN
		thisform.mov_stock.limpiar()
		
		IF ALLTRIM(Thisform.cbte) == "PTO" THEN
			Thisform.mov_stock.circuito = "S"
			Thisform.mov_stock.tipodoc = ""
			Thisform.mov_stock.cbte = ""
		ELSE
			Thisform.mov_stock.circuito = "V"
			Thisform.mov_stock.idVentasC = lnIdVentasC
			Thisform.mov_stock.idcliente = Thisform.contenido.sel_cliente.valcpoid
			Thisform.mov_stock.idProv = 0
			Thisform.mov_stock.cbte = IIF(ALLTRIM(lcCbte) == "PTO", "SAL", lcCbte)
			Thisform.mov_stock.numcbte =  REPLICATE("0", 4 - LEN(ALLTRIM(STR(lnPtoVta)))) + ALLTRIM(STR(lnPtoVta)) + "-" + REPLICATE("0", 8 - LEN(ALLTRIM(STR(lnNroCbte)))) + ALLTRIM(STR(lnNroCbte))
		ENDIF
		
		SELECT cur_movstock
		GO TOP
		
		DO WHILE !EOF("cur_movstock")
			Thisform.mov_stock.agregar_articulo(cur_movstock.idArticulo, cur_movstock.cantidad, cur_movstock.nroPart)
			
			SELECT cur_movstock
			SKIP
		ENDDO
		
		&& Grabo los movimientos de stock
		IF !(ALLTRIM(Thisform.cbte) == "PED") THEN
			IF !Thisform.mov_stock.grabar2() THEN
				MESSAGEBOX(Thisform.mov_stock.ErrorMessage, 0+48, Thisform.Caption)
				thisform.desbloq_numerador()
				goConn.Rollback()
				RETURN .F.
			ENDIF
		ENDIF
	ENDIF
ENDIF

IF ALLTRIM(thisform.cbte) == "PTO" THEN
	loConDMO.Commit()	
	loConDMO.close()
ELSE
	goConn.Commit()
ENDIF

thisform.desbloq_numerador()

thisform.Release()
RETURN .T.
ENDPROC
PROCEDURE Init
thisform.ShowTips = .T.
Thisform.Closable = .F.
DODEFAULT()

thisform.contenido.btnCbteOrigen.Visible = .F.
&& Habilito para modificar la columna 3
Thisform.contenido.grdDetalles.Columns[3].ReadOnly = .F.

ENDPROC
PROCEDURE validardetalle
LOCAL lnResp

IF ALLTRIM(Thisform.Contenido.sel_Articulo.txtCodigo.Value) == "" THEN
	MESSAGEBOX("Debe ingresar el artículo", 0+48, Thisform.Caption)
	Thisform.Contenido.sel_Articulo.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

IF Thisform.Contenido.txtCantidad.Value = 0 THEN
	MESSAGEBOX("Falta ingresar la cantidad", 0+48, Thisform.Caption)
	Thisform.Contenido.txtCantidad.SetFocus()
	RETURN .F.
ENDIF

IF Thisform.Contenido.txtCantidad.Value < 0 THEN
	MESSAGEBOX("La cantidad ingresada no puede ser un valor negativo", 0+48, Thisform.Caption)
	Thisform.Contenido.txtCantidad.SetFocus()
	RETURN .F.
ENDIF

IF (ALLTRIM(Thisform.cbte) != "COT") .AND. (ALLTRIM(Thisform.cbte) != "NC") THEN
	&& Valido el stock solo en caso que no sea artículo X
	IF RIGHT(ALLTRIM(Thisform.Contenido.sel_Articulo.txtCodigo.Value), 3) != "ARX" THEN
		IF getGlobalCFG("STK_MODULE") THEN
			IF Thisform.mov_stock.get_exist_byart(Thisform.Contenido.sel_Articulo.valcpoid) <= 0 THEN
				Thisform.Contenido.sel_Articulo.txtCodigo.SetFocus()
				
				lnResp = MESSAGEBOX("No hay stock disponible, ¿Desea facturarlo de todos modos?", 4+32, Thisform.Caption)				
				IF lnResp <> 6 THEN
					RETURN .F.
				ENDIF
			ENDIF
			
			&& Valido si está o no cubierto al 100%
			IF Thisform.Contenido.txtCantidad.Value > Thisform.Contenido.txtExistencia.Value THEN
				lnResp = MESSAGEBOX("No hay stock suficiente para cubrir la cantidad ingresada, ¿Desea facturarlo de todos modos?", 4+32, Thisform.Caption)				
				IF lnResp <> 6 THEN
					RETURN .F.
				ENDIF
			ENDIF
		ENDIF
	ENDIF
ENDIF

RETURN .T.


ENDPROC
PROCEDURE particionar_cbte
************************************************************************************
** Esta función permite grabar una factura cada 25 items.
** Pablo Díaz
************************************************************************************

LOCAL ln_cantitems

ln_cantitems = 0

SELECT cur_aux
ZAP 

SELECT cur_detalle
IF RECCOUNT() > 0 THEN 
	GO TOP
ELSE 
	RETURN 
ENDIF 

************************************************************************************
** Paso de a 25 items del cursor de detalle al cursor auxiliar
************************************************************************************
SELECT cur_detalle
DO WHILE !EOF()
	ln_cantitems = ln_cantitems + 1
	
	SELECT cur_aux
	APPEND BLANK	
	
	REPLACE cur_aux.idDetalle WITH cur_detalle.idDetalle
	REPLACE cur_aux.idArticulo WITH cur_detalle.idArticulo ADDITIVE
	REPLACE cur_aux.codArt WITH cur_detalle.codArt ADDITIVE
	REPLACE cur_aux.descripcio WITH cur_detalle.descripcio ADDITIVE
	REPLACE cur_aux.nroPart WITH cur_detalle.nroPart ADDITIVE
	REPLACE cur_aux.cantidad WITH cur_detalle.cantidad ADDITIVE
	REPLACE cur_aux.prVta WITH cur_detalle.prVta ADDITIVE
	REPLACE cur_aux.pDtoVta1 WITH cur_detalle.pDtoVta1 ADDITIVE
	REPLACE cur_aux.pDtoVta2 WITH cur_detalle.pDtoVta2 ADDITIVE
	REPLACE cur_aux.pDtoVta3 WITH cur_detalle.pDtoVta3 ADDITIVE
	REPLACE cur_aux.pDtoVta4 WITH cur_detalle.pDtoVta4 ADDITIVE
	REPLACE cur_aux.iDtoVta1 WITH cur_detalle.iDtoVta1 ADDITIVE
	REPLACE cur_aux.iDtoVta2 WITH cur_detalle.iDtoVta2 ADDITIVE
	REPLACE cur_aux.iDtoVta3 WITH cur_detalle.iDtoVta3 ADDITIVE
	REPLACE cur_aux.iDtoVta4 WITH cur_detalle.iDtoVta4 ADDITIVE
	REPLACE cur_aux.pDtoCli1 WITH cur_detalle.pDtoCli1 ADDITIVE
	REPLACE cur_aux.pDtoCli2 WITH cur_detalle.pDtoCli2 ADDITIVE
	REPLACE cur_aux.pDtoCli3 WITH cur_detalle.pDtoCli3 ADDITIVE
	REPLACE cur_aux.pDtoCli4 WITH cur_detalle.pDtoCli4 ADDITIVE
	REPLACE cur_aux.iDtoCli1 WITH cur_detalle.iDtoCli1 ADDITIVE
	REPLACE cur_aux.iDtoCli2 WITH cur_detalle.iDtoCli2 ADDITIVE
	REPLACE cur_aux.iDtoCli3 WITH cur_detalle.iDtoCli3 ADDITIVE
	REPLACE cur_aux.iDtoCli4 WITH cur_detalle.iDtoCli4 ADDITIVE
	REPLACE cur_aux.alicIVA WITH cur_detalle.alicIVA ADDITIVE
	REPLACE cur_aux.impIVA WITH cur_detalle.impIVA ADDITIVE
	REPLACE cur_aux.impNeto WITH cur_detalle.impNeto ADDITIVE
	REPLACE cur_aux.totNeto WITH cur_detalle.totNeto ADDITIVE
	REPLACE cur_aux.subTotal WITH cur_detalle.subTotal ADDITIVE
	REPLACE cur_aux.prArtic WITH cur_detalle.prArtic ADDITIVE
	REPLACE cur_aux.esOferta WITH cur_detalle.esOferta ADDITIVE
	REPLACE cur_aux.pRecVta WITH cur_detalle.pRecVta ADDITIVE
	REPLACE cur_aux.iRecVta WITH cur_detalle.iRecVta ADDITIVE
	REPLACE cur_aux.uniDesp WITH cur_detalle.uniDesp ADDITIVE
	REPLACE cur_aux.cantPack WITH cur_detalle.cantPack ADDITIVE
	
	&& Cuando el contador llegue a 25 items grabo una factura nueva.
	IF ln_cantitems = 25
		&& tengo que hacer el calculo de los totales y el grabado		
		Thisform.calc_subtot_cur_aux()
		
		IF !thisform.grabar_cbte_part()
			MESSAGEBOX("Error al intentar grabar el comprobante", 0+16, Thisform.Caption)
			RETURN .F.
		ENDIF	
		
		IF ALLTRIM(Thisform.cbte) == "FC" THEN
			IF !Thisform.enviar_wsafipfe() THEN
				MESSAGEBOX("El comprobante no fué autorizado. Por favor intente más tarde desde la autorización diferida", 0+48, Thisform.Caption)
			ELSE
				IF Thisform.fe_set_cae() THEN
					Thisform.grabar_ctacte(Thisform.id_ventasc)
				ENDIF
			ENDIF
		ENDIF
			
		ln_cantitems = 0
		
		SELECT cur_aux
		ZAP					
	ENDIF 
	
	SELECT cur_detalle
	SKIP  
ENDDO 

&& En el caso que la ultima factura no haya llegado a los 25 items
&& tengo que hacer una nueva factura con los items restantes.
IF ln_cantitems <> 0 
	&& tengo que hacer el calculo de los totales y el grabado
	Thisform.calc_subtot_cur_aux()
	
	IF !thisform.grabar_cbte_part()
		MESSAGEBOX("Error al intentar grabar el comprobante", 0+16, Thisform.Caption)
		RETURN .F.
	ENDIF

	IF ALLTRIM(Thisform.cbte) == "FC" THEN
		IF !Thisform.enviar_wsafipfe() THEN
			MESSAGEBOX("El comprobante no fué autorizado. Por favor intente más tarde desde la autorización diferida", 0+48, Thisform.Caption)
			RETURN .F.
		ELSE
			IF Thisform.fe_set_cae() THEN
				Thisform.grabar_ctacte(Thisform.id_ventasc)
			ENDIF
		ENDIF
	ENDIF
ENDIF 

RETURN .T.

ENDPROC
PROCEDURE CONTENIDO.SEL_CLIENTE.recuperar_datos
DODEFAULT()
Thisform.Contenido.btnGrabar.Enabled = .T.
thisform.leer_servicios()

IF This.valcpoid = getglobalcfg("CLI_CF") THEN
	This.txtDescripcion.ReadOnly = .F.
	This.txtDescripcion.Enabled = .T.
	This.txtDescripcion.SetFocus()
ELSE
	This.txtDescripcion.ReadOnly = .T.
	This.txtDescripcion.Enabled = .F.
ENDIF

Thisform.contenido.sel_vendedor.txtCodigo.SetFocus()
ENDPROC
PROCEDURE CONTENIDO.SEL_ARTICULO.txtCodigo.LostFocus
IF !(ALLTRIM(this.Value)) == "0000" THEN
	DODEFAULT()
ENDIF
ENDPROC
PROCEDURE CONTENIDO.GRDDETALLES.COLUMN3.Text1.LostFocus
thisform.modificar_item()
ENDPROC
PROCEDURE CONTENIDO.GRDDETALLES.COLUMN4.Text1.Valid
LOCAL lnCurrentRow, lnResp

IF this.Value = 0 THEN
	RETURN .F.
ENDIF

SELECT cur_deta_view

IF (ALLTRIM(Thisform.cbte) != "COT") .AND. (ALLTRIM(Thisform.cbte) != "NC") THEN
	&& Valido el stock solo en caso que no sea artículo X
	IF RIGHT(ALLTRIM(cur_deta_view.codArt), 3) != "ARX" THEN
		IF getGlobalCFG("STK_MODULE") THEN
			IF Thisform.mov_stock.get_exist_byart(cur_deta_view.idArticulo) <= 0 THEN
				lnResp = MESSAGEBOX("No hay stock disponible. ¿Desea facturarlo de todos modos?", 4+32, Thisform.Caption)	
				IF lnResp <> 6 THEN
					RETURN .F.
				ENDIF
			ENDIF
			
			&& Valido si está o no cubierto al 100%
			IF this.Value > Thisform.mov_stock.get_exist_byart(cur_deta_view.idArticulo) THEN
				lnResp = MESSAGEBOX("No hay stock suficiente para cubrir la cantidad ingresada. ¿Desea facturarlo de todos modos?", 4+32, Thisform.Caption)
				IF lnResp <> 6 THEN
					RETURN .F.
				ENDIF
			ENDIF
		ENDIF
	ENDIF
ENDIF

SELECT cur_deta_view
lnCurrentRow = RECNO("cur_deta_view")

thisform.recalcular_todo_2()

SELECT cur_deta_view
GO lnCurrentRow

RETURN .T.
ENDPROC
PROCEDURE CONTENIDO.GRDDETALLES.COLUMN5.Text1.Valid
LOCAL lnCurrentRow, lnResp

IF this.Value = 0 THEN
	RETURN .F.
ENDIF

SELECT cur_deta_view
lnCurrentRow = RECNO("cur_deta_view")

thisform.recalcular_todo_2()

SELECT cur_deta_view
GO lnCurrentRow

RETURN .T.
ENDPROC
PROCEDURE CONTENIDO.btnGrabar.Click
IF !Thisform.ValidarCampos()
	RETURN .F.
ENDIF

IF Thisform.Contenido.sel_vendedor.valcpoid = 0 THEN
	MESSAGEBOX("Debe ingresar el vendedor", 0+48, Thisform.Caption)
	Thisform.Contenido.sel_vendedor.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

IF !thisform.agregar_item() THEN
	MESSAGEBOX("Ha ocurrido un error mientras se estaba preparando los ítems para facturar", 0+48, thisform.Caption)
	RETURN .F.
ENDIF

SELECT cur_Detalle
GO TOP

Thisform.particionar_cbte()
Thisform.actualizar_servicios()	&& Marco los servicios que fueron facturados en esta factura

Thisform.mov_stock.limpiar()

IF Thisform.cerrar_cbte THEN
	Thisform.blanquear()
	Thisform.Hide()
ENDIF

RETURN .T.
ENDPROC
PROCEDURE CONTENIDO.CLSCERRAR1.Click
DODEFAULT()
ENDPROC


************************************************************
OBJETO: Clsetiqueta28
************************************************************
*** PROPIEDADES ***
Caption = "Vendedor:"
Left = 10
Top = 77
TabIndex = 86
Name = "Clsetiqueta28"

*** METODOS ***


************************************************************
OBJETO: sel_vendedor
************************************************************
*** PROPIEDADES ***
Top = 73
Left = 111
TabIndex = 4
nombre_campo_codigo = idVendedor
nombre_campo_desc = Nombre
nombre_tabla = vendedores
pkfield = idVendedor
requerido = .F.
esnumerico = .T.
Name = "sel_vendedor"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: cls_cbtes_retiros_sf
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 9, 6, 15, 12, 32, 3, 0

*** METODOS ***


