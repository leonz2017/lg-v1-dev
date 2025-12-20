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
OBJETO: frmVerTodosPr
************************************************************
*** PROPIEDADES ***
DataSession = 1
BorderStyle = 2
Height = 442
Width = 912
DoCreate = .T.
Caption = "Ver todos los precios posibles"
idarticulo = 0
Name = "frmVerTodosPr"

*** METODOS ***
PROCEDURE Load
CREATE CURSOR cur_Precios ( ;
	descripcio	varchar(60),;
	porDto1		float(10,2),;
	porDto2		float(10,2),;
	porDto3		float(10,2),;
	porDto4		float(10,2),;
	prFinalMax	float(10,2),;
	prFinalMin	float(10,2),;
	prVentaMax	float(10,2),;
	prVentaMin	float(10,2))
	

ENDPROC
PROCEDURE Init
LOCAL lcSql, loResult
LOCAL lnPorDto1, lnPorDto2, lnPorDto3, lnPorDto4
LOCAL lnPrVentaMax, lnPrVentaMin, lnPrFinalMax, lnPrFinalMin
LOCAL lnPrecio1, lnPrecio2, lnPrecio3, lnPrecio4

loResult = CREATEOBJECT("odbc_result")
lnPorDto1 = 0.00
lnPorDto2 = 0.00
lnPorDto3 = 0.00
lnPorDto4 = 0.00
lnPrVentaMax = 0.00
lnPrVentaMin = 0.00
lnPrFinalMax = 0.00
lnPrFinalMin = 0.00
lnPrecio1 = 0.00
lnPrecio2 = 0.00
lnPrecio3 = 0.00
lnPrecio4 = 0.00

lcSql = "SELECT * FROM art_dtos WHERE fecBaja IS NULL"
loResult.ActiveConnection = goConn.ActiveConnection
loResult.Cursor_Name = "cur_Dtos"
loResult.OpenQuery(lcSql)

SELECT cur_Dtos
DO WHILE !EOF("cur_Dtos")
	lnPrVentaMax = cur_Artic.prVentaMax
	lnPrVentaMin = cur_Artic.prVentaMin
	lnPrFinalMax = cur_Artic.prFinalMax
	lnPrFinalMin = cur_Artic.prFinalMin
	lnPorDto1 = cur_Dtos.porDto1 * -1
	lnPorDto2 = cur_Dtos.porDto2 * -1
	lnPorDto3 = cur_Dtos.porDto3 * -1
	lnPorDto4 = cur_Dtos.porDto4 * -1
	
	&& Calculo el precio mayorista con el descuento
	lnPrecio1 = lnPrVentaMax + (lnPrVentaMax * (lnPorDto1 / 100))
	lnPrecio2 = lnPrecio1 + (lnPrecio1 * (lnPorDto2 / 100))
	lnPrecio3 = lnPrecio2 + (lnPrecio2 * (lnPorDto3 / 100))
	lnPrecio4 = lnPrecio3 + (lnPrecio3 * (lnPorDto4 / 100))
	lnPrVentaMax = lnPrecio4
	
	&& Calculo el precio minorista con el descuento
	lnPrecio1 = lnPrVentaMin + (lnPrVentaMin * (lnPorDto1 / 100))
	lnPrecio2 = lnPrecio1 + (lnPrecio1 * (lnPorDto2 / 100))
	lnPrecio3 = lnPrecio2 + (lnPrecio2 * (lnPorDto3 / 100))
	lnPrecio4 = lnPrecio3 + (lnPrecio3 * (lnPorDto4 / 100))
	lnPrVentaMin = lnPrecio4
	
	&& Calculo el precio final mayorista con el descuento
	lnPrecio1 = lnPrFinalMax + (lnPrFinalMax * (lnPorDto1 / 100))
	lnPrecio2 = lnPrecio1 + (lnPrecio1 * (lnPorDto2 / 100))
	lnPrecio3 = lnPrecio2 + (lnPrecio2 * (lnPorDto3 / 100))
	lnPrecio4 = lnPrecio3 + (lnPrecio3 * (lnPorDto4 / 100))
	lnPrFinalMax = lnPrecio4
	
	&& Calculo el precio final minorista con el descuento
	lnPrecio1 = lnPrFinalMin + (lnPrFinalMin * (lnPorDto1 / 100))
	lnPrecio2 = lnPrecio1 + (lnPrecio1 * (lnPorDto2 / 100))
	lnPrecio3 = lnPrecio2 + (lnPrecio2 * (lnPorDto3 / 100))
	lnPrecio4 = lnPrecio3 + (lnPrecio3 * (lnPorDto4 / 100))
	lnPrFinalMin = lnPrecio4
	
	&& Agrego el registro en el cursor de precios
	SELECT cur_Precios
	APPEND BLANK
	REPLACE descripcio WITH ALLTRIM(cur_Dtos.descripcio)
	REPLACE porDto1 WITH cur_Dtos.porDto1 ADDITIVE
	REPLACE porDto2 WITH cur_Dtos.porDto2 ADDITIVE
	REPLACE porDto3 WITH cur_Dtos.porDto3 ADDITIVE
	REPLACE porDto4 WITH cur_Dtos.porDto4 ADDITIVE
	REPLACE prVentaMax WITH lnPrVentaMax ADDITIVE
	REPLACE prVentaMin WITH lnPrVentaMin ADDITIVE
	REPLACE prFinalMax WITH lnPrFinalMax ADDITIVE
	REPLACE prFinalMin WITH lnPrFinalMin ADDITIVE

	SELECT cur_Dtos
	SKIP
ENDDO

loResult.Close_Query()

&& Vinculo los precios con la grilla
Thisform.grdPrecios.RecordSource = "cur_Precios"
Thisform.grdPrecios.alias_name = "cur_Precios"
Thisform.grdPrecios.list_controlsource = "descripcio,porDto1,porDto2,porDto3,porDto4,prFinalMax,prFinalMin,prVentaMax,prVentaMin"
Thisform.grdPrecios.lista_ancho_cols = "200,70,70,70,70,70,70,70,70"
Thisform.grdPrecios.titulos_cabeceras = "Descripción,Dto1.,Dto2.,Dto3.,Dto4.,Final May.,Final Min.,Lista May.,Lista Min."
Thisform.grdPrecios.generar_grid()

SELECT cur_Precios
IF RECCOUNT("cur_Precios") > 0 THEN
	GO TOP
ENDIF

ENDPROC


************************************************************
OBJETO: grdPrecios
************************************************************
*** PROPIEDADES ***
Height = 394
Left = 2
Top = 2
Width = 907
permitir_busqueda = .F.
permitir_ordenamiento = .F.
Name = "grdPrecios"
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
OBJETO: CLSCERRAR1
************************************************************
*** PROPIEDADES ***
Top = 397
Left = 864
Height = 44
Width = 45
Name = "CLSCERRAR1"

*** METODOS ***


************************************************************
OBJETO: 
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


