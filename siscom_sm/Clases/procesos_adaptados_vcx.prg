************************************************************
OBJETO: actu_precios_adaptado
************************************************************
*** PROPIEDADES ***
Name = "actu_precios_adaptado"

*** METODOS ***
PROCEDURE crear_cursor
********************************************************
* Creo el cursor que contiene los artículos a modificar
*
* 14/06/2021: Agrego el campo código de proveedor.
********************************************************

CREATE CURSOR cur_artic (	;
	selected	L,;
	idArticulo	int,;
	codArt		varchar(20),;
	codArtPV	varchar(20) NULL,;
	descripcio	varchar(60),;
	alicIVA		float(10,2),;
	prLista		float(10,2),;
	bonif1		float(10,2),;
	bonif2		float(10,2),;
	bonif3		float(10,2),;
	bonif4		float(10,2),;
	costoRep	float(10,2),;
	margenMax	float(10,2),;
	margenMin	float(10,2),;
	prVentaMax	float(10,2),;
	prVentaMin	float(10,2),;
	prFinalMax	float(10,2),;
	prFinalMin	float(10,2))
ENDPROC


