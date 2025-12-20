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
OBJETO: FRM_UPDATE_NET_ARTNUEVOS
************************************************************
*** PROPIEDADES ***
DoCreate = .T.
Name = "FRM_UPDATE_NET_ARTNUEVOS"
CONTENIDO.Clsetiqueta1.Name = "Clsetiqueta1"
CONTENIDO.sel_proveedor.txtCodigo.Name = "txtCodigo"
CONTENIDO.sel_proveedor.txtDescripcion.Name = "txtDescripcion"
CONTENIDO.sel_proveedor.Name = "sel_proveedor"
CONTENIDO.grdArticulos.COLUMN1.Header1.Name = "Header1"
CONTENIDO.grdArticulos.COLUMN1.Text1.Name = "Text1"
CONTENIDO.grdArticulos.COLUMN1.Name = "COLUMN1"
CONTENIDO.grdArticulos.COLUMN2.Header1.Name = "Header1"
CONTENIDO.grdArticulos.COLUMN2.Text1.Name = "Text1"
CONTENIDO.grdArticulos.COLUMN2.Name = "COLUMN2"
CONTENIDO.grdArticulos.COLUMN3.Header1.Name = "Header1"
CONTENIDO.grdArticulos.COLUMN3.Text1.Name = "Text1"
CONTENIDO.grdArticulos.COLUMN3.Name = "COLUMN3"
CONTENIDO.grdArticulos.COLUMN4.Header1.Name = "Header1"
CONTENIDO.grdArticulos.COLUMN4.Text1.Name = "Text1"
CONTENIDO.grdArticulos.COLUMN4.Name = "COLUMN4"
CONTENIDO.grdArticulos.COLUMN5.Header1.Name = "Header1"
CONTENIDO.grdArticulos.COLUMN5.Text1.Name = "Text1"
CONTENIDO.grdArticulos.COLUMN5.Name = "COLUMN5"
CONTENIDO.grdArticulos.COLUMN6.Header1.Name = "Header1"
CONTENIDO.grdArticulos.COLUMN6.Text1.Name = "Text1"
CONTENIDO.grdArticulos.COLUMN6.Name = "COLUMN6"
CONTENIDO.grdArticulos.COLUMN7.Header1.Name = "Header1"
CONTENIDO.grdArticulos.COLUMN7.Text1.Name = "Text1"
CONTENIDO.grdArticulos.COLUMN7.Name = "COLUMN7"
CONTENIDO.grdArticulos.COLUMN8.Header1.Name = "Header1"
CONTENIDO.grdArticulos.COLUMN8.Text1.Name = "Text1"
CONTENIDO.grdArticulos.COLUMN8.Name = "COLUMN8"
CONTENIDO.grdArticulos.COLUMN9.Header1.Name = "Header1"
CONTENIDO.grdArticulos.COLUMN9.Text1.Name = "Text1"
CONTENIDO.grdArticulos.COLUMN9.Name = "COLUMN9"
CONTENIDO.grdArticulos.COLUMN10.Header1.Name = "Header1"
CONTENIDO.grdArticulos.COLUMN10.Text1.Name = "Text1"
CONTENIDO.grdArticulos.COLUMN10.Name = "COLUMN10"
CONTENIDO.grdArticulos.COLUMN11.Header1.Name = "Header1"
CONTENIDO.grdArticulos.COLUMN11.Text1.Name = "Text1"
CONTENIDO.grdArticulos.COLUMN11.Name = "COLUMN11"
CONTENIDO.grdArticulos.COLUMN12.Header1.Name = "Header1"
CONTENIDO.grdArticulos.COLUMN12.Text1.Name = "Text1"
CONTENIDO.grdArticulos.COLUMN12.Name = "COLUMN12"
CONTENIDO.grdArticulos.COLUMN13.Header1.Name = "Header1"
CONTENIDO.grdArticulos.COLUMN13.Text1.Name = "Text1"
CONTENIDO.grdArticulos.COLUMN13.Name = "COLUMN13"
CONTENIDO.grdArticulos.COLUMN14.Header1.Name = "Header1"
CONTENIDO.grdArticulos.COLUMN14.Text1.Name = "Text1"
CONTENIDO.grdArticulos.COLUMN14.Name = "COLUMN14"
CONTENIDO.grdArticulos.COLUMN15.Header1.Name = "Header1"
CONTENIDO.grdArticulos.COLUMN15.Text1.Name = "Text1"
CONTENIDO.grdArticulos.COLUMN15.Name = "COLUMN15"
CONTENIDO.grdArticulos.COLUMN16.Header1.Name = "Header1"
CONTENIDO.grdArticulos.COLUMN16.Text1.Name = "Text1"
CONTENIDO.grdArticulos.COLUMN16.Name = "COLUMN16"
CONTENIDO.grdArticulos.COLUMN17.Header1.Name = "Header1"
CONTENIDO.grdArticulos.COLUMN17.Text1.Name = "Text1"
CONTENIDO.grdArticulos.COLUMN17.Name = "COLUMN17"
CONTENIDO.grdArticulos.COLUMN18.Header1.Name = "Header1"
CONTENIDO.grdArticulos.COLUMN18.Text1.Name = "Text1"
CONTENIDO.grdArticulos.COLUMN18.Name = "COLUMN18"
CONTENIDO.grdArticulos.COLUMN19.Header1.Name = "Header1"
CONTENIDO.grdArticulos.COLUMN19.Text1.Name = "Text1"
CONTENIDO.grdArticulos.COLUMN19.Name = "COLUMN19"
CONTENIDO.grdArticulos.COLUMN20.Header1.Name = "Header1"
CONTENIDO.grdArticulos.COLUMN20.Text1.Name = "Text1"
CONTENIDO.grdArticulos.COLUMN20.Name = "COLUMN20"
CONTENIDO.grdArticulos.Name = "grdArticulos"
CONTENIDO.Clsetiqueta2.Name = "Clsetiqueta2"
CONTENIDO.Clsetiqueta3.Name = "Clsetiqueta3"
CONTENIDO.Clsetiqueta4.Name = "Clsetiqueta4"
CONTENIDO.Clsetiqueta5.Name = "Clsetiqueta5"
CONTENIDO.txtBonif1.Name = "txtBonif1"
CONTENIDO.txtBonif2.Name = "txtBonif2"
CONTENIDO.txtBonif3.Name = "txtBonif3"
CONTENIDO.txtBonif4.Name = "txtBonif4"
CONTENIDO.Clsetiqueta6.Name = "Clsetiqueta6"
CONTENIDO.Clsetiqueta7.Name = "Clsetiqueta7"
CONTENIDO.txtMargenMay.Name = "txtMargenMay"
CONTENIDO.txtMargenMin.Name = "txtMargenMin"
CONTENIDO.btnGrabar.Name = "btnGrabar"
CONTENIDO.BTNCERRAR.Name = "BTNCERRAR"
CONTENIDO.btnAplicar.Name = "btnAplicar"
CONTENIDO.Clsnew1.Name = "Clsnew1"
CONTENIDO.Name = "CONTENIDO"

*** METODOS ***
PROCEDURE formatear_codigo
PARAMETERS tcCodigo

LOCAL lcPermitidos
LOCAL lcLetra
LOCAL lcResult
LOCAL lnIdProv

lnIdProv = thisform.contenido.sel_proveedor.valcpoid
lcPermitidos = "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,0,1,2,3,4,5,6,7,8,9,/,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,-"
lcResult = ""
FOR i = 1 TO LEN(tcCodigo)
	FOR j = 1 TO GETWORDCOUNT(lcPermitidos, ",")
		IF SUBSTR(tcCodigo, i, 1) == GETWORDNUM(lcPermitidos, j, ",") THEN
			lcResult = lcResult + GETWORDNUM(lcPermitidos, j, ",")
		ENDIF
	NEXT
NEXT
lcResult = LEFT(STRTRAN(lcResult, SPACE(1), ""), 16)
IF lnIdProv < 10 THEN
	lcResult = ALLTRIM(lcResult) + "-P0" + ALLTRIM(STR(lnIdProv))
ELSE
	lcResult = ALLTRIM(lcResult) + "-P" + ALLTRIM(STR(lnIdProv))
ENDIF
RETURN ALLTRIM(lcResult)

ENDPROC


************************************************************
OBJETO: 
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


