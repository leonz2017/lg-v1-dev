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
OBJETO: FRM_ACTU_LISTA
************************************************************
*** PROPIEDADES ***
BorderStyle = 0
Height = 475
Width = 953
DoCreate = .T.
Caption = "Actualización de listas de precios"
KeyPreview = .F.
Name = "FRM_ACTU_LISTA"
CONTENIDO.Top = 4
CONTENIDO.Left = 3
CONTENIDO.Width = 948
CONTENIDO.Height = 469
CONTENIDO.Name = "CONTENIDO"

*** METODOS ***
PROCEDURE convertir
&& Hago la conversion e la moneda en base al cambio seleccionado
LOCAL ln_resultado, ln_importe, ln_cambio

ln_resultado = 0.00
ln_importe = cur_Precios.listapv
ln_cambio = thisform.contenido.txtCbio.Value

IF thisform.contenido.cboTipoCbio.Value != "Pesos"
	ln_resultado = ln_importe * ln_cambio
ELSE
	ln_resultado = ln_importe
ENDIF

RETURN ROUND(ln_resultado, 2)
ENDPROC
PROCEDURE calcular_costo
&& Calculo el precio de costo

LOCAL ln_importe, ln_bonif1, ln_bonif2, ln_bonif3, ln_costo

ln_importe = cur_Precios.listapv
ln_bonif1 = thisform.contenido.txtBonif1.Value
ln_bonif2 = thisform.contenido.txtBonif2.Value
ln_bonif3 = thisform.contenido.txtBonif3.Value
ln_bonif4 = thisform.contenido.txtBonif4.Value
ln_costo = 0.00

ln_costo = ln_importe - (ln_importe * (ln_bonif1 / 100))
ln_costo = ln_costo - (ln_costo *(ln_bonif2 / 100))
ln_costo = ln_costo - (ln_costo *(ln_bonif3 / 100))
ln_costo = ln_costo - (ln_costo * (ln_bonif4 / 100))

RETURN ROUND(ln_costo, 2)




ENDPROC
PROCEDURE calcular_lista
&& Calculo del precio de lista

LOCAL ln_costo, ln_utlista, ln_lista

ln_lista = 0.00
ln_costo = cur_Precios.costorep
ln_utlista = thisform.contenido.txtpcioLista.Value
ln_lista = ln_costo + (ln_costo * (ln_utlista / 100))

RETURN ROUND(ln_lista, 2)
ENDPROC
PROCEDURE calcular_oferta
&& Calculo el precio de oferta

LOCAL ln_costo, ln_utoferta, ln_oferta

ln_oferta = 0.00
ln_utoferta = thisform.contenido.txtPcioOferta.Value
ln_costo = cur_Precios.costorep

ln_oferta = ln_costo + (ln_costo * (ln_utoferta / 100))

RETURN ROUND(ln_oferta, 2)
ENDPROC
PROCEDURE calcular_ofertaiva
&& Calculo del precio de oferta mas iva

LOCAL ln_lista, ln_aliciva, ln_ofertaiva

ln_ofertaiva = 0.00
ln_lista = cur_Precios.oferta
ln_aliciva = cur_Precios.iva

ln_ofertaiva = ln_lista + (ln_lista * (ln_aliciva / 100))

RETURN ROUND(ln_ofertaiva, 2)
ENDPROC
PROCEDURE calcular_ventaiva
&& Calculo del precio de venta mas iva

LOCAL ln_lista, ln_aliciva, ln_ventaiva

ln_ventaiva = 0.00
ln_lista = cur_Precios.lista
ln_aliciva = cur_Precios.iva

ln_ventaiva = ln_lista + (ln_lista * (ln_aliciva / 100))

RETURN ROUND(ln_ventaiva, 2)
ENDPROC
PROCEDURE cambiar_lista
&& Cambio el precio de lista

LOCAL ln_importe, ln_variacion, ln_nuevoimp

ln_variacion = thisform.contenido.txtlistaProv.Value

&& Solo hago el cálculo si el usuario habilitó que va a variar el precio de lista
&& en caso contrario devuelvo el mismo importe que estaba

IF thisform.contenido.chkListaProv.Value = 1
	&& Defino el precio de lista a cambiar en base a la moneda que corresponde.
	
	IF ALLTRIM(cur_Precios.tipocbio) == "Pesos"
		ln_importe = cur_Precios.listapv
	ELSE
		IF thisform.contenido.cboTipoCbio.Value = "Dolar"
			ln_importe = cur_Precios.listapvus
		ELSE
			ln_importe = cur_Precios.listapveu
		ENDIF
	ENDIF
	
	&& Hago el calculo del nuevo precio de lista
	ln_nuevoimp = ln_importe + (ln_importe * (ln_variacion / 100))
ELSE
	ln_nuevoimp = ln_importe
ENDIF

RETURN ROUND(ln_nuevoimp, 2)
ENDPROC
PROCEDURE limpiar
&& Blanqueo los controles

Thisform.Contenido.sel_FamDesde.blanquear()
Thisform.Contenido.sel_FamHasta.blanquear()
Thisform.Contenido.sel_MarcaDD.blanquear()
Thisform.Contenido.sel_MarcaHH.blanquear()
Thisform.Contenido.sel_ProvDesde.blanquear()
Thisform.Contenido.sel_ProvHasta.blanquear()
Thisform.Contenido.sel_SubFamDesde.blanquear()
Thisform.Contenido.sel_SubFamHasta.blanquear()
Thisform.contenido.txtBonif1.Value = 0.00
Thisform.Contenido.txtBonif2.Value = 0.00
Thisform.Contenido.txtBonif3.Value = 0.00
Thisform.Contenido.txtBonif4.Value = 0.00
Thisform.Contenido.txtListaProv.Value = 0.00
Thisform.Contenido.txtMargenMax.Value = 0.00
Thisform.Contenido.txtMargenMin.Value = 0.00
Thisform.Contenido.chkBonif1.Value = 0
Thisform.Contenido.chkBonif2.Value = 0
Thisform.Contenido.chkBonif3.Value = 0
Thisform.Contenido.chkBonif4.Value = 0
Thisform.Contenido.chkMargenMay.Value = 0
Thisform.Contenido.chkMargenMin.Value = 0
Thisform.Contenido.chkListaProv.Value = 0
Thisform.Contenido.txtBonif1.Enabled = .F.
Thisform.Contenido.txtBonif2.Enabled = .F.
Thisform.Contenido.txtBonif3.Enabled = .F.
Thisform.Contenido.txtBonif4.Enabled = .F.
Thisform.Contenido.txtListaProv.Enabled = .F.
Thisform.Contenido.txtMargenMax.Enabled = .F.
Thisform.Contenido.txtMargenMin.Enabled = .F.
Thisform.contenido.cboTipoCbio.ListIndex = 1
Thisform.contenido.txtCbio.Value = 0.00

SELECT cur_Artic
ZAP

Thisform.Contenido.grdDatos.Refresh()
Thisform.Contenido.btnAceptar.Enabled = .T.
Thisform.Contenido.btnGrabar.Enabled = .F.
Thisform.Contenido.btnCancelar.Enabled = .F.
Thisform.Contenido.btnVerDif.Enabled = .F.





ENDPROC
PROCEDURE Init
DODEFAULT()

thisform.contenido.btngrabar.Enabled = .f.
thisform.contenido.btncancelar.Enabled = .f.
Thisform.Contenido.btnVerDif.Enabled = .f.

SELECT cur_Artic
thisform.contenido.grdDatos.list_controlsource = "codArt,descripcio,alicIVA,prLista,bonif1,bonif2,bonif3,bonif4,costoRep,margenMax,margenMin,prventaMax,prventaMin,prfinalMax,prfinalMin"
thisform.contenido.grdDatos.lista_ancho_cols = "100,300,70,70,70,70,70,70,70,70,70,70,70,70,70"
thisform.contenido.grdDatos.titulos_cabeceras = "Codigo,Descripcion,Alic. IVA,Lista,Bonif. 1,Bonif. 2,Bonif. 3,Bonif. 4,Costo Rep.,Margen May.,Margen Min.,Pr. Venta. May.,Pr. Venta Min, P. Final May.,P. Final Min"
thisform.contenido.grdDatos.RecordSource = "cur_Artic"
thisform.contenido.grdDatos.generar_grid()

thisform.contenido.cboTipoCbio.AddItem("PSO")
thisform.contenido.cboTipoCbio.AddItem("DOL")
thisform.contenido.cboTipoCbio.AddItem("EUR")
thisform.contenido.cboTipoCbio.ListIndex = 1

thisform.contenido.txtbonif1.Enabled = .f.
thisform.contenido.txtbonif2.Enabled = .f.
thisform.contenido.txtbonif3.Enabled = .f.
thisform.contenido.txtbonif4.Enabled = .f.
thisform.contenido.txtmargenMax.Enabled = .f.
thisform.contenido.txtmargenMin.Enabled = .f.
thisform.contenido.txtListaProv.Enabled = .f.
thisform.contenido.cboTipoCbio.Enabled = .f.
thisform.contenido.txtCbio.Enabled = .f.
ENDPROC
PROCEDURE Load
DODEFAULT()

LOCAL rs

&& Creo el cursor que voy a necesitar para procesar

CREATE CURSOR cur_Artic (	;
	idArticulo		integer	,;
	idProv			integer	,;
	idFamilia		integer	,;
	idSubFam		integer	,;
	idMarca			integer	,;
	codArt			C(20)	,;
	descripcio		C(60)	,;
	alicIVA			float(10,2)	,;
	prLista			float(10,2)	,;
	prListaExt		float(10,2) ,;
	bonif1			float(10,2)	,;
	bonif2			float(10,2)	,;
	bonif3			float(10,2)	,;
	bonif4			float(10,2)	,;
	costoRep		float(10,2)	,;
	margenMax		float(10,2)	,;
	margenMin		float(10,2)	,;
	prventaMax		float(10,2)	,;
	prventaMin		float(10,2)	,;
	prfinalMax		float(10,2)	,;
	prfinalMin		float(10,2)	,;
	observ			text)

SELECT cur_Artic
INDEX ON idArticulo TAG idArticulo ASCENDING
INDEX ON idProv TAG idProv ASCENDING ADDITIVE
INDEX ON idFamilia TAG idFamilia ASCENDING ADDITIVE
INDEX ON idSubFam TAG idSubFam ASCENDING ADDITIVE
INDEX ON idMarca TAG idMarca ASCENDING ADDITIVE
INDEX ON codArt TAG codArt ASCENDING ADDITIVE
INDEX ON descripcio TAG descripcio ASCENDING ADDITIVE

SELECT cur_Artic
SET ORDER to tag codart ASCENDING 


ENDPROC
PROCEDURE CONTENIDO.LostFocus


ENDPROC


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Proveedor"
Height = 15
Left = 7
Top = 18
Width = 72
TabIndex = 31
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Desde:"
Height = 15
Left = 72
Top = 18
Width = 52
TabIndex = 32
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Hasta:"
Height = 15
Left = 72
Top = 41
Width = 52
TabIndex = 33
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Familias"
Height = 15
Left = 470
Top = 18
Width = 65
TabIndex = 34
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Desde:"
Height = 15
Left = 549
Top = 18
Width = 46
TabIndex = 36
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta6
************************************************************
*** PROPIEDADES ***
Caption = "Hasta:"
Height = 15
Left = 549
Top = 41
Width = 46
TabIndex = 39
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta7
************************************************************
*** PROPIEDADES ***
Caption = "SubFamilias"
Height = 15
Left = 469
Top = 64
Width = 71
TabIndex = 40
Name = "Clsetiqueta7"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta8
************************************************************
*** PROPIEDADES ***
Caption = "Desde:"
Height = 15
Left = 549
Top = 64
Width = 52
TabIndex = 41
Name = "Clsetiqueta8"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta9
************************************************************
*** PROPIEDADES ***
Caption = "Hasta:"
Height = 15
Left = 550
Top = 87
Width = 52
TabIndex = 42
Name = "Clsetiqueta9"

*** METODOS ***


************************************************************
OBJETO: Clslinea1
************************************************************
*** PROPIEDADES ***
Height = 1
Left = 6
Top = 122
Width = 927
Name = "Clslinea1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta10
************************************************************
*** PROPIEDADES ***
Caption = "Lista de Proveedor:"
Height = 15
Left = 18
Top = 133
Width = 120
TabIndex = 43
Name = "Clsetiqueta10"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta11
************************************************************
*** PROPIEDADES ***
Caption = "Moneda:"
Height = 15
Left = 17
Top = 165
Visible = .T.
Width = 68
TabIndex = 45
Name = "Clsetiqueta11"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta12
************************************************************
*** PROPIEDADES ***
Caption = "Dto. Prov. 1:"
Height = 15
Left = 411
Top = 132
Width = 74
TabIndex = 46
Name = "Clsetiqueta12"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta13
************************************************************
*** PROPIEDADES ***
Caption = "Dto. Prov. 2:"
Height = 15
Left = 411
Top = 155
Width = 74
TabIndex = 47
Name = "Clsetiqueta13"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta14
************************************************************
*** PROPIEDADES ***
Caption = "Dto. Prov. 3:"
Height = 15
Left = 411
Top = 177
Width = 74
TabIndex = 48
Name = "Clsetiqueta14"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta15
************************************************************
*** PROPIEDADES ***
Caption = "Dto. Prov. 4:"
Height = 15
Left = 411
Top = 200
Width = 73
TabIndex = 49
Name = "Clsetiqueta15"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta16
************************************************************
*** PROPIEDADES ***
Caption = "Margen Mayorista:"
Height = 15
Left = 630
Top = 133
Width = 104
TabIndex = 50
Name = "Clsetiqueta16"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta17
************************************************************
*** PROPIEDADES ***
Caption = "Margen Minorista:"
Height = 15
Left = 630
Top = 156
Visible = .T.
Width = 111
TabIndex = 51
Name = "Clsetiqueta17"

*** METODOS ***


************************************************************
OBJETO: chkListaProv
************************************************************
*** PROPIEDADES ***
Top = 132
Left = 136
Height = 18
Width = 17
Alignment = 0
Caption = ""
Value = 0
TabIndex = 23
Visible = .T.
Name = "chkListaProv"

*** METODOS ***
PROCEDURE Click
IF this.Value = 1
	thisform.contenido.txtListaProv.Enabled = .t.
ELSE
	thisform.contenido.txtListaProv.Enabled = .f.
ENDIF

ENDPROC


************************************************************
OBJETO: txtListaProv
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 154
TabIndex = 9
Top = 128
Width = 101
isnumeric = .T.
Name = "txtListaProv"

*** METODOS ***


************************************************************
OBJETO: txtBonif1
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 489
TabIndex = 12
Top = 128
Width = 65
isnumeric = .T.
Name = "txtBonif1"

*** METODOS ***


************************************************************
OBJETO: txtBonif2
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 489
TabIndex = 13
Top = 151
Width = 65
isnumeric = .T.
Name = "txtBonif2"

*** METODOS ***


************************************************************
OBJETO: txtBonif3
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 489
TabIndex = 14
Top = 174
Width = 65
isnumeric = .T.
Name = "txtBonif3"

*** METODOS ***


************************************************************
OBJETO: txtBonif4
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 489
TabIndex = 15
Top = 197
Width = 65
isnumeric = .T.
Name = "txtBonif4"

*** METODOS ***


************************************************************
OBJETO: txtMargenMax
************************************************************
*** PROPIEDADES ***
Left = 743
TabIndex = 16
Top = 128
isnumeric = .T.
Name = "txtMargenMax"

*** METODOS ***


************************************************************
OBJETO: txtMargenMin
************************************************************
*** PROPIEDADES ***
Left = 743
TabIndex = 17
Top = 151
Visible = .T.
isnumeric = .T.
Name = "txtMargenMin"

*** METODOS ***


************************************************************
OBJETO: cboTipoCbio
************************************************************
*** PROPIEDADES ***
Height = 22
Left = 155
TabIndex = 10
Top = 160
Visible = .T.
Width = 61
Name = "cboTipoCbio"

*** METODOS ***


************************************************************
OBJETO: txtCbio
************************************************************
*** PROPIEDADES ***
Enabled = .F.
Height = 22
Left = 155
TabIndex = 11
Top = 184
Visible = .T.
Width = 99
isnumeric = .T.
Name = "txtCbio"

*** METODOS ***


************************************************************
OBJETO: sel_FamDesde
************************************************************
*** PROPIEDADES ***
Top = 12
Left = 593
Width = 345
Height = 25
TabIndex = 5
esnumerico = .T.
cfieldname = idFamilia
nombre_campo_codigo = idFamilia
nombre_campo_desc = descripcio
nombre_tabla = familias
pkfield = idFamilia
Name = "sel_FamDesde"
TXTCODIGO.Name = "TXTCODIGO"
TXTDESCRIPCION.Height = 21
TXTDESCRIPCION.Left = 106
TXTDESCRIPCION.Top = 2
TXTDESCRIPCION.Width = 236
TXTDESCRIPCION.Name = "TXTDESCRIPCION"

*** METODOS ***


************************************************************
OBJETO: sel_FamHasta
************************************************************
*** PROPIEDADES ***
Top = 35
Left = 593
Width = 345
Height = 25
TabIndex = 6
esnumerico = .T.
cfieldname = idFamilia
nombre_campo_codigo = idFamilia
nombre_campo_desc = descripcio
nombre_tabla = familias
pkfield = idFamilia
Name = "sel_FamHasta"
TXTCODIGO.Name = "TXTCODIGO"
TXTDESCRIPCION.Height = 21
TXTDESCRIPCION.Left = 106
TXTDESCRIPCION.Top = 2
TXTDESCRIPCION.Width = 236
TXTDESCRIPCION.Name = "TXTDESCRIPCION"

*** METODOS ***


************************************************************
OBJETO: sel_SubFamDesde
************************************************************
*** PROPIEDADES ***
Top = 58
Left = 593
Width = 345
Height = 25
TabIndex = 7
esnumerico = .T.
cfieldname = idSubFam
nombre_campo_codigo = idSubFam
nombre_campo_desc = descripcio
nombre_tabla = subfam
pkfield = idSubFam
Name = "sel_SubFamDesde"
TXTCODIGO.Name = "TXTCODIGO"
TXTDESCRIPCION.Height = 21
TXTDESCRIPCION.Left = 106
TXTDESCRIPCION.Top = 2
TXTDESCRIPCION.Width = 236
TXTDESCRIPCION.Name = "TXTDESCRIPCION"

*** METODOS ***


************************************************************
OBJETO: sel_SubFamHasta
************************************************************
*** PROPIEDADES ***
Top = 81
Left = 593
Width = 345
Height = 25
TabIndex = 8
esnumerico = .T.
cfieldname = idSubFam
nombre_campo_codigo = idSubFam
nombre_campo_desc = Descripcio
nombre_tabla = subfam
pkfield = idSubFam
Name = "sel_SubFamHasta"
TXTCODIGO.Name = "TXTCODIGO"
TXTDESCRIPCION.Height = 21
TXTDESCRIPCION.Left = 106
TXTDESCRIPCION.Top = 2
TXTDESCRIPCION.Width = 236
TXTDESCRIPCION.Name = "TXTDESCRIPCION"

*** METODOS ***


************************************************************
OBJETO: sel_ProvDesde
************************************************************
*** PROPIEDADES ***
Top = 13
Left = 118
Width = 345
Height = 25
TabIndex = 1
esnumerico = .T.
nombre_tabla = proveedor
pkfield = idProv
nombre_campo_codigo = idProv
nombre_campo_desc = razSoc
cfieldname = idProv
Name = "sel_ProvDesde"
TXTCODIGO.Name = "TXTCODIGO"
TXTDESCRIPCION.Height = 21
TXTDESCRIPCION.Left = 106
TXTDESCRIPCION.Top = 2
TXTDESCRIPCION.Width = 236
TXTDESCRIPCION.Name = "TXTDESCRIPCION"

*** METODOS ***


************************************************************
OBJETO: sel_ProvHasta
************************************************************
*** PROPIEDADES ***
Top = 36
Left = 118
Width = 345
Height = 25
TabIndex = 2
esnumerico = .T.
cfieldname = idProv
nombre_campo_codigo = idProv
nombre_campo_desc = razSoc
nombre_tabla = proveedor
pkfield = idProv
Name = "sel_ProvHasta"
TXTCODIGO.Name = "TXTCODIGO"
TXTDESCRIPCION.Height = 21
TXTDESCRIPCION.Left = 106
TXTDESCRIPCION.Top = 2
TXTDESCRIPCION.Width = 236
TXTDESCRIPCION.Name = "TXTDESCRIPCION"

*** METODOS ***


************************************************************
OBJETO: btnAceptar
************************************************************
*** PROPIEDADES ***
Top = 177
Left = 893
Height = 44
Width = 45
TabIndex = 18
Visible = .T.
Name = "btnAceptar"

*** METODOS ***
PROCEDURE Click
LOCAL lnIdFamDD
LOCAL lnIdFamHH
LOCAL lnIdSubFamDD
LOCAL lnIdSubFamHH
LOCAL lnIdProvDD
LOCAL lnIdProvHH
LOCAL lnIdMarcaDD
LOCAL lnIdMarcaHH
LOCAL lnBonif1
LOCAL lnBonif2
LOCAL lnBonif3
LOCAL lnBonif4
LOCAL lnCostoRep
LOCAL lnMargenMax
LOCAL lnMargenMin
LOCAL lnPorVariacion
LOCAL lnCotizac

lnIdFamDD = 0
lnIdFamHH = 0
lnIdSubFamDD = 0
lnIdSubFamHH = 0
lnIdProvDD = 0
lnIdProvHH = 0
lnIdMarcaDD = 0
lnIdMarcaHH = 0
lnBonif1 = 0.00
lnBonif2 = 0.00
lnBonif3 = 0.00
lnBonif4 = 0.00
lnCostoRep = 0.00
lnMargenMax = 0.00
lnMargenMin = 0.00
lnPorVariacion = 0.00
lnCotizac = 0.00

IF(thisform.contenido.sel_ProvDesde.valcpoid <> 0) .and. (thisform.contenido.sel_ProvHasta.valcpoid <> 0)
	lnIdProvDD = thisform.contenido.sel_ProvDesde.valcpoid
	lnIdProvHH = thisform.contenido.sel_ProvHasta.valcpoid
ELSE
	lnIdProvDD = -1
	lnIdProvHH = -1
ENDIF

IF(thisform.contenido.sel_FamDesde.valcpoid <> 0) .and. (thisform.contenido.sel_FamHasta.valcpoid <> 0)
	lnIdFamDD = thisform.contenido.sel_FamDesde.valcpoid
	lnIdFamHH = thisform.contenido.sel_FamHasta.valcpoid
ELSE
	lnIdFamDD = -1
	lnIdFamHH = -1
ENDIF

IF(thisform.contenido.sel_SubFamDesde.valcpoid <> 0) .and. (thisform.contenido.sel_subFamHasta.valcpoid <> 0)
	lnIdSubFamDD = thisform.contenido.sel_SubFamDesde.valcpoid
	lnIdSubFamHH = thisform.contenido.sel_SubFamHasta.valcpoid
ELSE
	lnIdSubFamDD = -1
	lnIdSubFamHH = -1
ENDIF

IF thisform.contenido.sel_MarcaDD.valcpoid <> 0 .and. thisform.contenido.sel_MarcaHH.valcpoid <> 0
	lnIdMarcaDD = thisform.contenido.sel_MarcaDD.valcpoid
	lnIdMarcaHH = thisform.contenido.sel_MarcaHH.valcpoid
ELSE	
	lnIdMarcaDD = -1
	lnIdMarcaHH = -1
ENDIF

lnBonif1 = IIF(Thisform.contenido.chkBonif1.Value = 1, Thisform.contenido.txtBonif1.Value, -1)
lnBonif2 = IIF(Thisform.contenido.chkBonif2.Value = 1, Thisform.contenido.txtBonif2.Value, -1)
lnBonif3 = IIF(Thisform.contenido.chkBonif3.Value = 1, Thisform.contenido.txtBonif3.Value, -1)
lnBonif4 = IIF(Thisform.contenido.chkBonif4.Value = 1, Thisform.contenido.txtBonif4.Value, -1)
lnMargenMax = IIF(Thisform.contenido.chkMargenMay.Value = 1, Thisform.contenido.txtMargenMax.Value, -1)
lnMargenMin = IIF(Thisform.contenido.chkMargenMin.Value = 1, Thisform.contenido.txtMargenMin.Value, -1)
lnPorVariacion = IIF(thisform.contenido.chkListaProv.Value = 1, Thisform.contenido.txtListaProv.Value, 0)
lnCotizac = thisform.contenido.txtCbio.Value

SELECT cur_Artic
ZAP
rsArtic = CREATEOBJECT("odbc_Result")
lcSql = "CALL articulos_actPrecProcesar (" ;
	+ "?pIdFamiliaDD, " ;
	+ "?pIdFamiliaHH, " ;
	+ "?pIdSubFamDD, " ;
	+ "?pIdSubFamHH, " ;
	+ "?pIdProvDD, " ;
	+ "?pIdProvHH, " ;
	+ "?pIdMarcaDD, " ;
	+ "?pIdMarcaHH, " ;
	+ "?pBonif1, " ;
	+ "?pBonif2, " ;
	+ "?pBonif3, " ;
	+ "?pBonif4, " ;
	+ "?pMargenMax, " ;
	+ "?pMargenMin, " ;
	+ "?pPorVariacion," ;
	+ "?pTMon, " ;
	+ "?pCotizac)"
lcSql = rsArtic.addParameter(lcSql, "pIdFamiliaDD", ALLTRIM(STR(lnIdFamDD)), .f., .f.)
lcSql = rsArtic.addParameter(lcSql, "pIdFamiliaHH", ALLTRIM(STR(lnIdFamHH)), .f., .f.)
lcSql = rsArtic.addParameter(lcSql, "pIdSubFamDD", ALLTRIM(STR(lnIdSubFamDD)), .f., .f.)
lcSql = rsArtic.addParameter(lcSql, "pIdSubFamHH", ALLTRIM(STR(lnIdSubFamHH)), .f., .f.)
lcSql = rsArtic.addParameter(lcSql, "pIdProvDD", ALLTRIM(STR(lnIdProvDD)), .f., .f.)
lcSql = rsArtic.addParameter(lcSql, "pIdProvHH", ALLTRIM(STR(lnIdProvHH)), .f., .f.)
lcSql = rsArtic.addParameter(lcSql, "pIdMarcaDD", ALLTRIM(STR(lnIdMarcaDD)), .f., .f.)
lcSql = rsArtic.addParameter(lcSql, "pIdMarcaHH", ALLTRIM(STR(lnIdMarcaHH)), .f., .f.)
lcSql = rsArtic.addParameter(lcSql, "pBonif1", ALLTRIM(STR(lnBonif1)), .f., .f.)
lcSql = rsArtic.addParameter(lcSql, "pBonif2", ALLTRIM(STR(lnBonif2)), .f., .f.)
lcSql = rsArtic.addParameter(lcSql, "pBonif3", ALLTRIM(STR(lnBonif3)), .f., .f.)
lcSql = rsArtic.addParameter(lcSql, "pBonif4", ALLTRIM(STR(lnBonif4)), .f., .f.)
lcSql = rsArtic.addParameter(lcSql, "pMargenMax", ALLTRIM(STR(lnMargenMax)), .f., .f.)
lcSql = rsArtic.addParameter(lcSql, "pMargenMin", ALLTRIM(STR(lnMargenMin)), .f., .f.)
lcSql = rsArtic.addParameter(lcSql, "pPorVariacion", ALLTRIM(STR(lnPorVariacion)), .f., .f.)
lcSql = rsArtic.addParameter(lcSql, "pTMon", ALLTRIM(thisform.contenido.cboTipoCbio.Value), .t., .f.)
lcSql = rsArtic.addParameter(lcSql, "pCotizac", ALLTRIM(STR(lnCotizac, 10, 2)), .f., .f.)
rsArtic.ActiveConnection = goConn.ActiveConnection
rsArtic.cursor_name = "cur_tmpart"
rsArtic.OpenQuery(lcSql)
SELECT cur_Artic
APPEND FROM DBF("cur_tmpart")
SELECT cur_Artic
IF RECCOUNT() > 0
	GO TOP
ENDIF

thisform.contenido.grdDatos.Refresh()
thisform.contenido.btngrabar.Enabled = .t.
thisform.contenido.btncancelar.Enabled = .t.
thisform.contenido.btnAceptar.Enabled = .F.
Thisform.Contenido.btnVerDif.Enabled = .T.
ENDPROC


************************************************************
OBJETO: grdDatos
************************************************************
*** PROPIEDADES ***
Height = 189
Left = 4
TabIndex = 19
Top = 224
Width = 934
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdDatos"
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
OBJETO: btnGrabar
************************************************************
*** PROPIEDADES ***
Top = 418
Left = 846
TabIndex = 20
Name = "btnGrabar"

*** METODOS ***
PROCEDURE Click
LOCAL loRes
LOCAL lcSql

loRes = CREATEOBJECT("odbc_result")
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_result"
lcSql = "CALL articulos_actPreGrabar(?pUsuModi, ?pIdHostModi)"
lcSql = loRes.AddParameter(lcSql, "pUsuModi", ALLTRIM(gcCodUsu), .t., .f.)
lcSql = loRes.AddParameter(lcSql, "pIdHostModi", ALLTRIM(SYS(0)), .t., .f.)
loRes.OpenQuery(lcSql)
SELECT cur_result
IF ALLTRIM(cur_result.result) == "OK" THEN
	MESSAGEBOX("Los datos se han actualizado con éxito...", 0+64, thisform.Caption)
	Thisform.limpiar()
ELSE
	MESSAGEBOX(cur_result.result, 0+48, Thisform.Caption)
ENDIF


ENDPROC


************************************************************
OBJETO: btnCancelar
************************************************************
*** PROPIEDADES ***
Top = 416
Left = 5
Height = 44
Width = 45
TabIndex = 21
Name = "btnCancelar"

*** METODOS ***
PROCEDURE Click
Thisform.limpiar()
ENDPROC


************************************************************
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 418
Left = 893
Height = 44
Width = 45
TabIndex = 22
Name = "btnCerrar"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta18
************************************************************
*** PROPIEDADES ***
FontBold = .T.
Caption = "% Variacion (+)(-)"
Height = 15
Left = 285
Top = 131
Width = 115
TabIndex = 52
ForeColor = 255,0,0
Name = "Clsetiqueta18"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta19
************************************************************
*** PROPIEDADES ***
FontBold = .T.
Caption = "% Dto."
Height = 15
Left = 559
Top = 132
Width = 60
TabIndex = 53
ForeColor = 255,0,0
Name = "Clsetiqueta19"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta20
************************************************************
*** PROPIEDADES ***
FontBold = .T.
Caption = "% Dto."
Height = 15
Left = 559
Top = 154
Width = 60
TabIndex = 54
ForeColor = 255,0,0
Name = "Clsetiqueta20"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta21
************************************************************
*** PROPIEDADES ***
FontBold = .T.
Caption = "% Dto."
Height = 15
Left = 560
Top = 176
Width = 60
TabIndex = 55
ForeColor = 255,0,0
Name = "Clsetiqueta21"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta22
************************************************************
*** PROPIEDADES ***
FontBold = .T.
Caption = "% Dto."
Height = 15
Left = 560
Top = 199
Width = 60
TabIndex = 56
ForeColor = 255,0,0
Name = "Clsetiqueta22"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta23
************************************************************
*** PROPIEDADES ***
FontBold = .T.
Caption = "% Utilidad"
Height = 15
Left = 846
Top = 131
Width = 87
TabIndex = 57
ForeColor = 255,0,0
Name = "Clsetiqueta23"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta24
************************************************************
*** PROPIEDADES ***
FontBold = .T.
Caption = "% Utilidad"
Height = 15
Left = 847
Top = 155
Width = 87
TabIndex = 58
ForeColor = 255,0,0
Name = "Clsetiqueta24"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta26
************************************************************
*** PROPIEDADES ***
Caption = "Marca"
Height = 15
Left = 7
Top = 65
Width = 65
TabIndex = 35
Name = "Clsetiqueta26"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta27
************************************************************
*** PROPIEDADES ***
Caption = "Desde:"
Height = 15
Left = 71
Top = 65
Width = 46
TabIndex = 37
Name = "Clsetiqueta27"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta28
************************************************************
*** PROPIEDADES ***
Caption = "Hasta:"
Height = 15
Left = 71
Top = 88
Width = 46
TabIndex = 38
Name = "Clsetiqueta28"

*** METODOS ***


************************************************************
OBJETO: sel_MarcaDD
************************************************************
*** PROPIEDADES ***
Top = 59
Left = 118
Width = 345
Height = 25
TabIndex = 3
esnumerico = .T.
cfieldname = idMarca
nombre_campo_codigo = idMarca
nombre_campo_desc = descripcio
nombre_tabla = marcas
pkfield = idMarca
Name = "sel_MarcaDD"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Height = 21
txtDescripcion.Left = 106
txtDescripcion.Top = 2
txtDescripcion.Width = 236
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: sel_MarcaHH
************************************************************
*** PROPIEDADES ***
Top = 82
Left = 118
Width = 345
Height = 25
TabIndex = 4
esnumerico = .T.
cfieldname = idMarca
nombre_campo_codigo = idMarca
nombre_campo_desc = descripcio
nombre_tabla = marcas
pkfield = idMarca
Name = "sel_MarcaHH"
txtCodigo.Name = "txtCodigo"
txtDescripcion.Height = 21
txtDescripcion.Left = 106
txtDescripcion.Top = 2
txtDescripcion.Width = 236
txtDescripcion.Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: chkBonif1
************************************************************
*** PROPIEDADES ***
Top = 130
Left = 391
Height = 18
Width = 17
Alignment = 0
Caption = ""
Value = 0
TabIndex = 25
Visible = .T.
Name = "chkBonif1"

*** METODOS ***
PROCEDURE Click
IF this.Value = 1
	thisform.contenido.txtBonif1.Enabled = .t.
ELSE
	thisform.contenido.txtBonif1.Enabled = .f.
ENDIF

ENDPROC


************************************************************
OBJETO: chkBonif2
************************************************************
*** PROPIEDADES ***
Top = 153
Left = 391
Height = 18
Width = 17
Alignment = 0
Caption = ""
Value = 0
TabIndex = 27
Visible = .T.
Name = "chkBonif2"

*** METODOS ***
PROCEDURE Click
IF this.Value = 1
	thisform.contenido.txtBonif2.Enabled = .t.
ELSE
	thisform.contenido.txtBonif2.Enabled = .f.
ENDIF

ENDPROC


************************************************************
OBJETO: chkBonif3
************************************************************
*** PROPIEDADES ***
Top = 175
Left = 391
Height = 18
Width = 17
Alignment = 0
Caption = ""
Value = 0
TabIndex = 30
Visible = .T.
Name = "chkBonif3"

*** METODOS ***
PROCEDURE Click
IF this.Value = 1
	thisform.contenido.txtBonif3.Enabled = .t.
ELSE
	thisform.contenido.txtBonif3.Enabled = .f.
ENDIF

ENDPROC


************************************************************
OBJETO: chkBonif4
************************************************************
*** PROPIEDADES ***
Top = 198
Left = 391
Height = 18
Width = 17
Alignment = 0
Caption = ""
Value = 0
TabIndex = 24
Visible = .T.
Name = "chkBonif4"

*** METODOS ***
PROCEDURE Click
IF this.Value = 1
	thisform.contenido.txtBonif4.Enabled = .t.
ELSE
	thisform.contenido.txtBonif4.Enabled = .f.
ENDIF

ENDPROC


************************************************************
OBJETO: chkMargenMay
************************************************************
*** PROPIEDADES ***
Top = 131
Left = 606
Height = 18
Width = 17
Alignment = 0
Caption = ""
Value = 0
TabIndex = 28
Visible = .T.
Name = "chkMargenMay"

*** METODOS ***
PROCEDURE Click
IF this.Value = 1
	thisform.contenido.txtMargenMax.Enabled = .t.
ELSE
	thisform.contenido.txtMargenMax.Enabled = .f.
ENDIF

ENDPROC


************************************************************
OBJETO: chkMargenMin
************************************************************
*** PROPIEDADES ***
Top = 156
Left = 606
Height = 18
Width = 17
Alignment = 0
Caption = ""
Value = 0
TabIndex = 29
Visible = .T.
Name = "chkMargenMin"

*** METODOS ***
PROCEDURE Click
IF this.Value = 1
	thisform.contenido.txtMargenMin.Enabled = .t.
ELSE
	thisform.contenido.txtMargenMin.Enabled = .f.
ENDIF

ENDPROC


************************************************************
OBJETO: btnVerDif
************************************************************
*** PROPIEDADES ***
Top = 421
Left = 54
Height = 36
Width = 108
Caption = "Ver \<Diferencia"
TabIndex = 59
Name = "btnVerDif"

*** METODOS ***
PROCEDURE Click
DO FORM "frmVerDifPrecio"
ENDPROC


************************************************************
OBJETO: chkCotizacion
************************************************************
*** PROPIEDADES ***
Top = 163
Left = 136
Height = 18
Width = 17
Alignment = 0
Caption = ""
Value = 0
TabIndex = 26
Visible = .T.
Name = "chkCotizacion"

*** METODOS ***
PROCEDURE Click
IF this.Value = 1
	thisform.contenido.cboTipoCbio.Enabled = .t.
	thisform.contenido.txtCbio.Enabled = .t.
ELSE
	thisform.contenido.cboTipoCbio.Enabled = .f.
	thisform.contenido.txtCbio.Enabled = .f.
	thisform.contenido.cboTipoCbio.ListIndex = 1
	thisform.contenido.txtCbio.Value = 0.00
ENDIF

ENDPROC


************************************************************
OBJETO: Clsetiqueta25
************************************************************
*** PROPIEDADES ***
Caption = "Cotización en $:"
Height = 15
Left = 17
Top = 187
Visible = .T.
Width = 100
TabIndex = 44
Name = "Clsetiqueta25"

*** METODOS ***


************************************************************
OBJETO: 
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


