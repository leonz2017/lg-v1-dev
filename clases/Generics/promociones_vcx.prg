************************************************************
OBJETO: cls_resultados_promociones
************************************************************
*** PROPIEDADES ***
DataSession = 1
BorderStyle = 2
Height = 610
Width = 949
DoCreate = .T.
Caption = "Resultados de promociones"
o_promociones = .NULL.
upd_promo_ok = .F.
upd_merchandising_ok = .F.
Name = "cls_resultados_promociones"

*** METODOS ***
PROCEDURE calcular_resultados_promo
**
* Permite calcular el resultado de la promoción
**

&& Calculo las promociones
IF !Thisform.O_promociones.Calcular_Promocion() THEN
	MESSAGEBOX(Thisform.O_promociones.GetErrorMessage(), 0+48, Thisform.Caption)
ELSE
	&& Genero el informe en el cursor
	Thisform.O_promociones.Get_Informe()
	SELECT cur_promocli
	Thisform.grdResultados.Refresh()
	
	&& Valor inicial del primer registro del grid de resultados de promociones
	&& en merchandising.
	Thisform.Calcular_merchandising()
	
	* Paso los merchandising por cliente a JSON
	Thisform.o_promociones.ExportarMerchandisingAJSON()		
ENDIF





ENDPROC
PROCEDURE calcular_merchandising
**
* Calcula los merchandisign del cliente seleccionado
*
* Desarrollado por: LINFOW - Leonardo D. Zulli
* Fecha: 30/08/2021
**

&& Obtengo el resultado de merchandisign
Thisform.O_promociones.Get_Informe_Merchandising(cur_promocli.idCliente)
SELECT cur_cli_merch
Thisform.grdMerchandising.Refresh

ENDPROC
PROCEDURE Init
* Vinculo la grilla al cursor
SELECT cur_promocli
Thisform.grdResultados.Alias_name = "cur_promocli"
Thisform.grdResultados.RecordSource = "cur_promocli"
Thisform.grdResultados.List_controlsource = "nombre,idCliente,razSoc,imp_tope,total_vend,faltan"
Thisform.grdResultados.Lista_ancho_cols = "120,70,200,100,100,100"
Thisform.grdResultados.Titulos_cabeceras = "Promoción,Nº Cliente,Razón Social,Importe tope,Total Vend.,Faltan"
Thisform.grdResultados.Generar_grid()

* Configuro la grilla de merchandising
select cur_cli_merch 
Thisform.grdMerchandising.Alias_name = "cur_cli_merch"
Thisform.grdMerchandising.RecordSource = "cur_cli_merch"
Thisform.grdMerchandising.List_controlsource = "codArt,descripcio,cantidad"
Thisform.grdMerchandising.Lista_ancho_cols = "150,200,100"
Thisform.grdMerchandising.Titulos_cabeceras = "Código,Descripción,Cantidad"
Thisform.grdMerchandising.Generar_grid()

Thisform.upd_promo_ok = .F.
Thisform.upd_merchandising_ok = .F.
ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "A continuación se muestra el rankeo de los clientes que se arriman a ganar la promoción"
Height = 15
Left = 24
Top = 12
Width = 540
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 562
Left = 888
Name = "btnCerrar"

*** METODOS ***


************************************************************
OBJETO: grdResultados
************************************************************
*** PROPIEDADES ***
Height = 207
Left = 12
Top = 30
Width = 929
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdResultados"
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
Thisform.Calcular_merchandising()
ENDPROC


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "A continuación se muestran el/los merchandising de los clientes"
Height = 15
Left = 13
Top = 243
Width = 371
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: grdMerchandising
************************************************************
*** PROPIEDADES ***
Height = 174
Left = 12
Top = 264
Width = 929
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdMerchandising"
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
OBJETO: btnActualizarPromoWeb
************************************************************
*** PROPIEDADES ***
Top = 562
Left = 837
Picture = ..\imagen\iconos bajados\sincronizar-icono-5476.ico
ToolTipText = "Actualizar resultados de promociones en la web"
Name = "btnActualizarPromoWeb"

*** METODOS ***
PROCEDURE Click
LOCAL lcUrl

Thisform.lblMensaje.Caption = "Subiendo promociones a la web"
Thisform.lblMensaje.Refresh()

* Verifico si está configurado para usar SFTP o FTP
IF !GetGlobalCFG("USA_SFTP") THEN
	* Transfiero por FTP
	Thisform.o_promociones.SubirArchivosJSON()
ELSE
	* Transfiero por SFTP
	Thisform.o_promociones.SubirArchivosJSONPorSFTP()
ENDIF

* Invoco a los PHP para que actualice la base del serivdor
* a partir de los archivos subidos
Thisform.lblMensaje.Caption = "Ejecutando actualización en el servidor"
Thisform.lblMensaje.Refresh()
lcUrl = getGlobalCFG("URLUPDATER")
Thisform.webpromo.Navigate(lcUrl + "/update_promo_cli.php")
Thisform.webmerchandising.Navigate(lcUrl + "/update-promo-merchandising.php")

ENDPROC


************************************************************
OBJETO: webpromo
************************************************************
*** PROPIEDADES ***
Top = 444
Left = 12
Height = 108
Width = 461
Anchor = 0
Name = "webpromo"

*** METODOS ***
PROCEDURE BeforeNavigate2
*** ActiveX Control Event ***
LPARAMETERS pdisp, url, flags, targetframename, postdata, headers, cancel

thisform.upd_promo_ok = .T.

ENDPROC
PROCEDURE NavigateComplete2
*** ActiveX Control Event ***
LPARAMETERS pdisp, url


ENDPROC
PROCEDURE DocumentComplete
*** ActiveX Control Event ***
LPARAMETERS pdisp, url

thisform.lblMensaje.Caption = "Promociones actualizada en la web"

ENDPROC


************************************************************
OBJETO: webmerchandising
************************************************************
*** PROPIEDADES ***
Top = 444
Left = 479
Height = 108
Width = 462
Name = "webmerchandising"

*** METODOS ***
PROCEDURE BeforeNavigate2
*** ActiveX Control Event ***
LPARAMETERS pdisp, url, flags, targetframename, postdata, headers, cancel

ENDPROC
PROCEDURE NavigateComplete2
*** ActiveX Control Event ***
LPARAMETERS pdisp, url



ENDPROC
PROCEDURE DocumentComplete
*** ActiveX Control Event ***
LPARAMETERS pdisp, url

thisform.upd_merchandising_ok = .T.
thisform.lblMensaje.Caption = "Promociones actualizada en la web"
ENDPROC


************************************************************
OBJETO: lblMensaje
************************************************************
*** PROPIEDADES ***
Caption = ""
Height = 16
Left = 277
Top = 568
Width = 384
ForeColor = 0,128,0
Name = "lblMensaje"

*** METODOS ***


************************************************************
OBJETO: cls_resultados_promociones
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_abm_promociones
************************************************************
*** PROPIEDADES ***
BorderStyle = 1
Height = 543
Width = 939
DoCreate = .T.
Caption = "ABM de Promociones"
_memberdata = 
o_promociones = .NULL.
listctrlsource = idpromo_c,nombre,vigencia_d,vigencia_h,imp_tope
listwidthcols = 50,300,150,150,70
titulos_cabeceras = #,Nombre,Vigencia Desde,Vigencia Hasta,Imp. Tope
pk_fieldname = idpromo_c
cnombretabla = promo_cab
Name = "cls_abm_promociones"
Herramientas.cmdNuevo.Name = "cmdNuevo"
Herramientas.cmdEditar.Name = "cmdEditar"
Herramientas.cmdEliminar.Name = "cmdEliminar"
Herramientas.cmdCerrar.Top = 1
Herramientas.cmdCerrar.Left = 888
Herramientas.cmdCerrar.Name = "cmdCerrar"
Herramientas.cmdGrabar.Name = "cmdGrabar"
Herramientas.cmdCancelar.Name = "cmdCancelar"
Herramientas.cmdExcel.Top = 1
Herramientas.cmdExcel.Left = 231
Herramientas.cmdExcel.Name = "cmdExcel"
Herramientas.Top = 1
Herramientas.Left = 2
Herramientas.Width = 931
Herramientas.Height = 36
Herramientas.Name = "Herramientas"
Pgf.ErasePage = .T.
Pgf.Page1.grdDatos.COLUMN1.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN1.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN1.Name = "COLUMN1"
Pgf.Page1.grdDatos.COLUMN2.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN2.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN2.Name = "COLUMN2"
Pgf.Page1.grdDatos.COLUMN3.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN3.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN3.Name = "COLUMN3"
Pgf.Page1.grdDatos.COLUMN4.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN4.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN4.Name = "COLUMN4"
Pgf.Page1.grdDatos.COLUMN5.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN5.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN5.Name = "COLUMN5"
Pgf.Page1.grdDatos.COLUMN6.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN6.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN6.Name = "COLUMN6"
Pgf.Page1.grdDatos.COLUMN7.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN7.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN7.Name = "COLUMN7"
Pgf.Page1.grdDatos.COLUMN8.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN8.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN8.Name = "COLUMN8"
Pgf.Page1.grdDatos.COLUMN9.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN9.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN9.Name = "COLUMN9"
Pgf.Page1.grdDatos.COLUMN10.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN10.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN10.Name = "COLUMN10"
Pgf.Page1.grdDatos.COLUMN11.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN11.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN11.Name = "COLUMN11"
Pgf.Page1.grdDatos.COLUMN12.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN12.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN12.Name = "COLUMN12"
Pgf.Page1.grdDatos.COLUMN13.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN13.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN13.Name = "COLUMN13"
Pgf.Page1.grdDatos.COLUMN14.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN14.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN14.Name = "COLUMN14"
Pgf.Page1.grdDatos.COLUMN15.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN15.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN15.Name = "COLUMN15"
Pgf.Page1.grdDatos.COLUMN16.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN16.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN16.Name = "COLUMN16"
Pgf.Page1.grdDatos.COLUMN17.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN17.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN17.Name = "COLUMN17"
Pgf.Page1.grdDatos.COLUMN18.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN18.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN18.Name = "COLUMN18"
Pgf.Page1.grdDatos.COLUMN19.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN19.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN19.Name = "COLUMN19"
Pgf.Page1.grdDatos.COLUMN20.Header1.Name = "Header1"
Pgf.Page1.grdDatos.COLUMN20.Text1.Name = "Text1"
Pgf.Page1.grdDatos.COLUMN20.Name = "COLUMN20"
Pgf.Page1.grdDatos.Height = 468
Pgf.Page1.grdDatos.Left = 2
Pgf.Page1.grdDatos.Top = 3
Pgf.Page1.grdDatos.Width = 921
Pgf.Page1.grdDatos.Name = "grdDatos"
Pgf.Page1.Name = "Page1"
Pgf.Page2.cnt_fields.Top = 7
Pgf.Page2.cnt_fields.Left = 9
Pgf.Page2.cnt_fields.Width = 917
Pgf.Page2.cnt_fields.Height = 465
Pgf.Page2.cnt_fields.Name = "cnt_fields"
Pgf.Page2.Name = "Page2"
Pgf.Top = 38
Pgf.Left = 2
Pgf.Width = 934
Pgf.Height = 502
Pgf.Name = "Pgf"

*** METODOS ***
PROCEDURE agregar_marca
**
* Agrego una marca a la promoción
**

WITH thisform.pgf.page2.cnt_fields.pgf_interno.Page1
	IF .sel_marca.Estavacio() THEN
		MESSAGEBOX("Debe seleccionar la marca", 0+48, Thisform.Caption)
		.sel_marca.txtCodigo.SetFocus()
		RETURN
	ENDIF
	
	&& Agrego el registro en el cursor
	select cur_marcas
	APPEND BLANK
	REPLACE cur_marcas.idmarca WITH .sel_marca.Valcpoid
	REPLACE cur_marcas.descripcio WITH .sel_marca.txtDescripcion.value ADDITIVE
	
	SELECT cur_marcas
	.grdMarcas.Refresh()
EndWith
Thisform.pgf.page2.Cnt_fields.pgf_interno.page1.sel_marca.blanquear()
Thisform.pgf.page2.Cnt_fields.pgf_interno.page1.sel_marca.SetFocus()
ENDPROC
PROCEDURE agregar_merchandising
**
* Agrega un merchandising a la promoción
**

WITH Thisform.pgf.page2.cnt_fields.pgf_interno.Page2
	IF ALLTRIM(.sel_articulo.txtCodigo.value) == "" THEN
		MESSAGEBOX("Debe ingresar el merchandising", 0+48, Thisform.Caption)
		.sel_articulo.txtCodigo.SetFocus()
		RETURN
	ENDIF
	
	&& Agrego el registro en el cursor cur_merchandising
	SELECT cur_merchandising
	APPEND BLANK
	REPLACE cur_merchandising.idArticulo WITH .sel_articulo.Valcpoid
	REPLACE cur_merchandising.codArt	 WITH .sel_articulo.txtCodigo.value ADDITIVE
	REPLACE cur_merchandising.descripcio WITH .sel_articulo.txtDescripcion.value ADDITIVE
	
	SELECT cur_merchandising
	.grdMerchandising.Refresh()
EndWith
Thisform.pgf.page2.cnt_fields.pgf_interno.page2.sel_articulo.blanquear()
Thisform.pgf.page2.cnt_fields.pgf_interno.page2.sel_articulo.SetFocus()
ENDPROC
PROCEDURE eliminar_marca
***********************************************************
* Permite eliminar una marca asignada a una promoción
*
* Fecha: 23/09/2021
* Desarrollado por: LINFOW - Leonardo D. Zulli
***********************************************************
LOCAL lnRes

lnRes = MESSAGEBOX("¿Está seguro que desea sacar la marca?", 4+32, Thisform.Caption)

IF lnRes = 6 THEN
	SELECT cur_marcas
	DELETE
	Thisform.Pgf.Page2.cnt_fields.pgf_interno.Page1.grdMarcas.Refresh()
ENDIF
ENDPROC
PROCEDURE eliminar_merchandising
*******************************************************************
* Permite eliminar un merchandisign asignado a la promoción.
*
* Fecha: 23/09/2021
* Autor: LINFOW - Leonardo D. Zulli
*******************************************************************
LOCAL lnRes

lnRes = MESSAGEBOX("¿Está seguro que desea eliminar el merchandising?", 4+32, Thisform.Caption)

IF lnRes = 6 THEN
	SELECT cur_merchandising
	DELETE
	Thisform.pgf.page2.cnt_fields.pgf_interno.page2.grdMerchandising.Refresh()
ENDIF

ENDPROC
PROCEDURE actualizar_cursor
DODEFAULT()

SELECT cur_Tempo
LOCK()
REPLACE cur_Tempo.idpromo_c WITH thisform.o_promociones.IdPromo_C
UNLOCK

ENDPROC
PROCEDURE blanquear
**
* Blanqueado de formulario
**
&& Ejecuto el código del padre
DODEFAULT()

&& Limpio los cursores
Thisform.o_promociones.Vaciar_Cursores()
ENDPROC
PROCEDURE cambiarestado
**
* Código propio de este ABM para cambiar estados
**

LPARAMETERS tl_Estado

DODEFAULT(tl_estado)	&& Ejecuta el código del padre

&& Cambio el estado de los controles que agregan marcas y merchandising
WITH Thisform.Pgf.Page2.cnt_fields.pgf_interno
	.Page1.sel_marca.txtCodigo.Enabled 		= !tl_estado
	.page1.btnAgregar.Enabled 				= !tl_Estado
	.Page1.btnEliminar.Enabled 				= !tl_Estado
	.Page2.sel_articulo.txtCodigo.Enabled 	= !tl_Estado
	.Page2.btnAgregar.Enabled				= !tl_Estado
	.Page2.btnEliminar.Enabled				= !tl_Estado
ENDWITH

ENDPROC
PROCEDURE validardatos
**
* Valida que los datos se encuentren bien cargados
**

DODEFAULT()

SELECT cur_marcas
IF RECCOUNT("cur_marcas") = 0 THEN
	MESSAGEBOX("Debe ingresar al menos una marca", 0+48, Thisform.Caption)
	Thisform.pgf.page2.cnt_fields.pgf_interno.page1.SetFocus()
	Thisform.pgf.page2.cnt_fields.pgf_interno.page1.sel_marca.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

SELECT cur_merchandising
IF RECCOUNT("cur_merchandising") = 0 THEN
	MESSAGEBOX("Debe ingresar al menos un merchandisign", 0+48, Thisform.Caption)
	Thisform.pgf.page2.cnt_fields.pgf_interno.page2.SetFocus()
	Thisform.pgf.page2.cnt_fields.pgf_interno.Page2.sel_articulo.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

RETURN .T.
ENDPROC
PROCEDURE Init
**
* Configuraciones al iniciar el formulario
**

thisform.o_promociones = CREATEOBJECT("cls_promociones")
thisform.o_promociones.crear_cursores()
thisform.O_promociones.crear_cursor_promocli()

&& Configuro la grilla de marcas
WITH Thisform.pgf.Page2.cnt_fields.pgf_interno.Page1
	SELECT cur_marcas
	.grdMarcas.Alias_name = "cur_marcas"
	.grdMarcas.RecordSource = "cur_marcas"
	.grdMarcas.List_controlsource = "idmarca,descripcio"
	.grdMarcas.Lista_ancho_cols = "70, 500"
	.grdMarcas.Titulos_cabeceras = "Nro. Marca,Descripción"
	.grdMarcas.Generar_grid()
ENDWITH

&& Configuro la grilla de merchandising
WITH Thisform.pgf.page2.cnt_fields.pgf_interno.Page2
	SELECT cur_merchandising
	.grdMerchandising.Alias_name = "cur_merchandising"
	.grdMerchandising.RecordSource = "cur_merchandising"
	.grdMerchandising.List_controlsource = "codArt,descripcio"
	.grdMerchandising.Lista_ancho_cols = "100,500"
	.grdMerchandising.Titulos_cabeceras = "Código,Descripción"
	.grdMerchandising.Generar_grid()
ENDWITH

&& Ejecuto el código padre acá porque primero tengo que instanciar el objeto
&& de promociones y configurar las grillas internas
DODEFAULT()

ENDPROC
PROCEDURE recuperardatos
**
* Código especifico de promociones para recuperar datos
**

LOCAL loRes
LOCAL lcSql

&& Ejecuto el código padre
DODEFAULT()

&& Recupero los datos de la promoción seleccionada. La propiedad IdPromo_C ya
&& se setea dentro del método.
Thisform.o_promociones.Recuperar_Promocion(cur_Tempo.idpromo_c)

&& Refresco las grillas
SELECT cur_marcas
Thisform.Pgf.page2.cnt_fields.pgf_interno.Page1.grdMarcas.Refresh()

SELECT cur_merchandising
Thisform.pgf.page2.cnt_fields.pgf_interno.Page2.grdMerchandising.Refresh()

ENDPROC
PROCEDURE Herramientas.grabar
**
* Armo el grabar a medida por lo que no hay que usar un DODEFAULT() para cortar
* la cadena de herencia
**

PARAMETERS tl_AutoAssing

&& Valido que los datos hayan sido cargados
IF !Thisform.validardatos() THEN
	MESSAGEBOX(thisform.msgerror, 0+48, thisform.Caption)
	Thisform.datos_ok = .F.
	RETURN .F.
ENDIF

WITH This.Parent.o_promociones
	IF thisform.Lnuevo THEN
		.IdPromo_C = 0
		.EsNuevo = .T.
	ELSE
		.EsNuevo = .F.
	ENDIF
	
	&& Asigno las propiedades con los valores de la cabecera
	.Nombre 	= Thisform.Pgf.Page2.cnt_fields.txtNombre.value
	.Vigencia_D = Thisform.Pgf.Page2.cnt_fields.txtVigenciaDesde.value
	.Vigencia_H = Thisform.Pgf.Page2.cnt_fields.txtVigenciaHasta.value
	.Imp_Tope	= Thisform.Pgf.Page2.cnt_fields.txtImporteTope.value
	.UsuarioActual = gcCodUsu
	
	&& Grabo la promoción
	IF !.grabar() THEN
		MESSAGEBOX(.GetErrorMessage(), 0+16, Thisform.Caption)
	ENDIF
ENDWITH

&& Actualizo el cursor para refrescar los cambios en la grilla
Thisform.actualizar_cursor()

&& Cambio el estado de los controles de usuario
WITH Thisform
	.RecuperarDatos()
	.CambiarEstado(.T.)
	.pgf.Page1.Enabled = .T.
	.pgf.Page1.setfocus()
	.Pgf.Page1.grdDatos.SetFocus()
	.Pgf.Page2.Enabled = .f.
ENDWITH

ENDPROC


************************************************************
OBJETO: btnVerInforme
************************************************************
*** PROPIEDADES ***
Top = 1
Left = 271
Height = 34
Width = 41
Picture = ..\imagen\iconos bajados\ver_informe.png
Name = "btnVerInforme"

*** METODOS ***
PROCEDURE Click
LOCAL loForm

loForm = CREATEOBJECT("cls_resultados_promociones")
loForm.o_promociones = Thisform.O_promociones
loForm.calcular_resultados_promo()
loForm.Show()
ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Nombre:"
Height = 15
Left = 90
Top = 15
Width = 53
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Fec. Vigencia Desde:"
Height = 15
Left = 24
Top = 41
Width = 120
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Fec. Vigencia Hasta:"
Height = 15
Left = 29
Top = 67
Width = 114
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Importe Tope:"
Height = 15
Left = 60
Top = 93
Width = 84
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: txtNombre
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 147
MaxLength = 60
ToolTipText = "Nombre de la promoción"
Top = 13
Width = 321
ischaracter = .T.
msgerror = Debe ingresar la el nombre
cfieldname = nombre
Name = "txtNombre"

*** METODOS ***


************************************************************
OBJETO: txtVigenciaDesde
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 147
ToolTipText = "Fecha en que se inicia la promoción"
Top = 38
Width = 97
isdatetime = .T.
msgerror = Debe ingresar la fecha de vigencia desde
cfieldname = vigencia_d
Name = "txtVigenciaDesde"

*** METODOS ***


************************************************************
OBJETO: txtVigenciaHasta
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 147
ToolTipText = "Fecha en que finaliza la promoción"
Top = 63
Width = 97
isdatetime = .T.
msgerror = Debe ingresar la fecha de vigencia desde
ischaracter = .F.
cfieldname = vigencia_h
Name = "txtVigenciaHasta"

*** METODOS ***


************************************************************
OBJETO: txtImporteTope
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 147
ToolTipText = "Importe mínimo que tiene que comprar el cliente para llevarse el merchandising"
Top = 87
Width = 97
isnumeric = .T.
msgerror = Debe ingresar el importe tope
cfieldname = imp_tope
Name = "txtImporteTope"

*** METODOS ***


************************************************************
OBJETO: pgf_interno
************************************************************
*** PROPIEDADES ***
ErasePage = .T.
Top = 123
Left = 7
Width = 904
Height = 331
Name = "pgf_interno"
Page1.Caption = "Asignar marcas"
Page1.Name = "Page1"
Page2.Caption = "Asignar merchandising"
Page2.Name = "Page2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Marca:"
Height = 15
Left = 16
Top = 21
Width = 48
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: sel_marca
************************************************************
*** PROPIEDADES ***
Top = 16
Left = 64
nombre_tabla = marcas
esnumerico = .T.
pkfield = idmarca
cfieldname = idmarca
nombre_campo_codigo = idmarca
nombre_campo_desc = descripcio
Name = "sel_marca"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: btnAgregar
************************************************************
*** PROPIEDADES ***
Top = 5
Left = 556
Height = 36
Width = 38
Name = "btnAgregar"

*** METODOS ***
PROCEDURE Click
Thisform.Agregar_marca()
ENDPROC


************************************************************
OBJETO: btnEliminar
************************************************************
*** PROPIEDADES ***
Top = 5
Left = 597
Height = 36
Width = 39
Name = "btnEliminar"

*** METODOS ***
PROCEDURE Click
Thisform.eliminar_marca()
ENDPROC


************************************************************
OBJETO: grdMarcas
************************************************************
*** PROPIEDADES ***
Height = 253
Left = 16
Top = 48
Width = 880
Name = "grdMarcas"
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
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Artículo:"
Height = 15
Left = 8
Top = 20
Width = 56
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: sel_articulo
************************************************************
*** PROPIEDADES ***
Top = 15
Left = 79
nombre_tabla = articulos
esnumerico = .F.
pkfield = idArticulo
cfieldname = idArticulo
nombre_campo_codigo = codArt
nombre_campo_desc = descripcio
criterio_filtro = promocion = 1
Name = "sel_articulo"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: btnAgregar
************************************************************
*** PROPIEDADES ***
Top = 4
Left = 571
Height = 36
Width = 38
Name = "btnAgregar"

*** METODOS ***
PROCEDURE Click
Thisform.Agregar_merchandising()
ENDPROC


************************************************************
OBJETO: btnEliminar
************************************************************
*** PROPIEDADES ***
Top = 4
Left = 612
Height = 36
Width = 39
Name = "btnEliminar"

*** METODOS ***
PROCEDURE Click
Thisform.eliminar_merchandising()
ENDPROC


************************************************************
OBJETO: grdMerchandising
************************************************************
*** PROPIEDADES ***
Height = 253
Left = 8
Top = 47
Width = 886
Name = "grdMerchandising"
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
OBJETO: cls_abm_promociones
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


