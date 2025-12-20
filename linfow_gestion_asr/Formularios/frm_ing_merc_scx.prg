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
OBJETO: frm_ing_merc
************************************************************
*** PROPIEDADES ***
DoCreate = .T.
Name = "frm_ing_merc"
contenido.Clsetiqueta1.Name = "Clsetiqueta1"
contenido.sel_prov.txtCodigo.Name = "txtCodigo"
contenido.sel_prov.txtDescripcion.Name = "txtDescripcion"
contenido.sel_prov.Name = "sel_prov"
contenido.btnAceptar.Name = "btnAceptar"
contenido.Clslinea1.Name = "Clslinea1"
contenido.Clsetiqueta2.Name = "Clsetiqueta2"
contenido.sel_artic.txtCodigo.Name = "txtCodigo"
contenido.sel_artic.txtDescripcion.Name = "txtDescripcion"
contenido.sel_artic.Name = "sel_artic"
contenido.Clsetiqueta3.Name = "Clsetiqueta3"
contenido.txtCantidad.Name = "txtCantidad"
contenido.btnAgregarItem.Name = "btnAgregarItem"
contenido.btnEliminaItem.Name = "btnEliminaItem"
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
contenido.btnGrabar.Name = "btnGrabar"
contenido.btnCancelar.Name = "btnCancelar"
contenido.btnCerrar.Name = "btnCerrar"
contenido.Clsetiqueta4.Name = "Clsetiqueta4"
contenido.txtPtoVta.Name = "txtPtoVta"
contenido.txtNumero.Name = "txtNumero"
contenido.Name = "contenido"
remito.Name = "remito"

*** METODOS ***
PROCEDURE contenido.btnEliminaItem.Click
SELECT cur_ptos
DELETE
Thisform.contenido.grdArticulos.Refresh()
ENDPROC


************************************************************
OBJETO: 
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 13, 11, 11, 2, 0
Arial, 1, 8, 6, 13, 11, 12, 2, 0

*** METODOS ***


