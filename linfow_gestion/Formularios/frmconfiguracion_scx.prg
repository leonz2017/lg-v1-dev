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
OBJETO: FRMCONFIGURACION
************************************************************
*** PROPIEDADES ***
BorderStyle = 1
Height = 309
Width = 734
DoCreate = .T.
Caption = "Parámetros Locales"
WindowType = 0
Name = "FRMCONFIGURACION"

*** METODOS ***
PROCEDURE Unload
USE IN sysconfig
ENDPROC
PROCEDURE Load
DODEFAULT()

IF !USED("sysconfig")
	USE sysconfig ALIAS sysconfig AGAIN IN 0
ELSE
	SELECT sysconfig
ENDIF


ENDPROC


************************************************************
OBJETO: grdConfig
************************************************************
*** PROPIEDADES ***
Height = 259
Left = 3
ReadOnly = .F.
Top = 2
Width = 727
alias_name = sysconfig
list_controlsource = key,descrip,value
lista_ancho_cols = 100,300,200
titulos_cabeceras = Clave,Descripción,Valor
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdConfig"
COLUMN1.Header1.Name = "Header1"
COLUMN1.Text1.ReadOnly = .F.
COLUMN1.Text1.Name = "Text1"
COLUMN1.ReadOnly = .F.
COLUMN1.Name = "COLUMN1"
COLUMN2.Header1.Name = "Header1"
COLUMN2.Text1.ReadOnly = .F.
COLUMN2.Text1.Name = "Text1"
COLUMN2.ReadOnly = .F.
COLUMN2.Name = "COLUMN2"
COLUMN3.Header1.Name = "Header1"
COLUMN3.Text1.ReadOnly = .F.
COLUMN3.Text1.Name = "Text1"
COLUMN3.ReadOnly = .F.
COLUMN3.Name = "COLUMN3"
COLUMN4.Header1.Name = "Header1"
COLUMN4.Text1.ReadOnly = .F.
COLUMN4.Text1.Name = "Text1"
COLUMN4.ReadOnly = .F.
COLUMN4.Name = "COLUMN4"
COLUMN5.Header1.Name = "Header1"
COLUMN5.Text1.ReadOnly = .F.
COLUMN5.Text1.Name = "Text1"
COLUMN5.ReadOnly = .F.
COLUMN5.Name = "COLUMN5"
COLUMN6.Header1.Name = "Header1"
COLUMN6.Text1.ReadOnly = .F.
COLUMN6.Text1.Name = "Text1"
COLUMN6.ReadOnly = .F.
COLUMN6.Name = "COLUMN6"
COLUMN7.Header1.Name = "Header1"
COLUMN7.Text1.ReadOnly = .F.
COLUMN7.Text1.Name = "Text1"
COLUMN7.ReadOnly = .F.
COLUMN7.Name = "COLUMN7"
COLUMN8.Header1.Name = "Header1"
COLUMN8.Text1.ReadOnly = .F.
COLUMN8.Text1.Name = "Text1"
COLUMN8.ReadOnly = .F.
COLUMN8.Name = "COLUMN8"
COLUMN9.Header1.Name = "Header1"
COLUMN9.Text1.ReadOnly = .F.
COLUMN9.Text1.Name = "Text1"
COLUMN9.ReadOnly = .F.
COLUMN9.Name = "COLUMN9"
COLUMN10.Header1.Name = "Header1"
COLUMN10.Text1.ReadOnly = .F.
COLUMN10.Text1.Name = "Text1"
COLUMN10.ReadOnly = .F.
COLUMN10.Name = "COLUMN10"
COLUMN11.Header1.Name = "Header1"
COLUMN11.Text1.ReadOnly = .F.
COLUMN11.Text1.Name = "Text1"
COLUMN11.ReadOnly = .F.
COLUMN11.Name = "COLUMN11"
COLUMN12.Header1.Name = "Header1"
COLUMN12.Text1.ReadOnly = .F.
COLUMN12.Text1.Name = "Text1"
COLUMN12.ReadOnly = .F.
COLUMN12.Name = "COLUMN12"
COLUMN13.Header1.Name = "Header1"
COLUMN13.Text1.ReadOnly = .F.
COLUMN13.Text1.Name = "Text1"
COLUMN13.ReadOnly = .F.
COLUMN13.Name = "COLUMN13"
COLUMN14.Header1.Name = "Header1"
COLUMN14.Text1.ReadOnly = .F.
COLUMN14.Text1.Name = "Text1"
COLUMN14.ReadOnly = .F.
COLUMN14.Name = "COLUMN14"
COLUMN15.Header1.Name = "Header1"
COLUMN15.Text1.ReadOnly = .F.
COLUMN15.Text1.Name = "Text1"
COLUMN15.ReadOnly = .F.
COLUMN15.Name = "COLUMN15"
COLUMN16.Header1.Name = "Header1"
COLUMN16.Text1.ReadOnly = .F.
COLUMN16.Text1.Name = "Text1"
COLUMN16.ReadOnly = .F.
COLUMN16.Name = "COLUMN16"
COLUMN17.Header1.Name = "Header1"
COLUMN17.Text1.ReadOnly = .F.
COLUMN17.Text1.Name = "Text1"
COLUMN17.ReadOnly = .F.
COLUMN17.Name = "COLUMN17"
COLUMN18.Header1.Name = "Header1"
COLUMN18.Text1.ReadOnly = .F.
COLUMN18.Text1.Name = "Text1"
COLUMN18.ReadOnly = .F.
COLUMN18.Name = "COLUMN18"
COLUMN19.Header1.Name = "Header1"
COLUMN19.Text1.ReadOnly = .F.
COLUMN19.Text1.Name = "Text1"
COLUMN19.ReadOnly = .F.
COLUMN19.Name = "COLUMN19"
COLUMN20.Header1.Name = "Header1"
COLUMN20.Text1.ReadOnly = .F.
COLUMN20.Text1.Name = "Text1"
COLUMN20.ReadOnly = .F.
COLUMN20.Name = "COLUMN20"

*** METODOS ***


************************************************************
OBJETO: Clscerrar1
************************************************************
*** PROPIEDADES ***
Top = 264
Left = 686
Name = "Clscerrar1"

*** METODOS ***


************************************************************
OBJETO: 
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


