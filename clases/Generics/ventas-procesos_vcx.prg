************************************************************
OBJETO: cls_export_ventas_rcel_form
************************************************************
*** PROPIEDADES ***
DoCreate = .T.
Caption = "RCEL- Exportación de comprobantes"
Name = "cls_export_ventas_rcel_form"

*** METODOS ***


************************************************************
OBJETO: CLSETIQUETA1
************************************************************
*** PROPIEDADES ***
Caption = "Mes:"
Height = 15
Left = 60
Top = 24
Width = 36
Name = "CLSETIQUETA1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Año:"
Height = 15
Left = 60
Top = 47
Width = 36
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: txtMes
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 96
Top = 19
Width = 42
Name = "txtMes"

*** METODOS ***


************************************************************
OBJETO: txtAnio
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 96
Top = 44
Width = 98
Name = "txtAnio"

*** METODOS ***


************************************************************
OBJETO: btnExportar
************************************************************
*** PROPIEDADES ***
Top = 132
Left = 428
Height = 44
Width = 45
Picture = ..\imagen\floppy_drive.ico
TabIndex = 5
ToolTipText = "Generar archivos CITI Ventas"
Name = "btnExportar"

*** METODOS ***
PROCEDURE Init
thisform.txtMes.value = MONTH(DATE())
thisform.txtAnio.value = YEAR(DATE())
ENDPROC
PROCEDURE Click
**************************************************************
* Ejecuta la exportación de RCEL
**************************************************************
o_rcel = CREATEOBJECT("cls_export_ventas_rcel")
o_rcel.n_mes = thisform.txtMes.value
o_rcel.n_anio = thisform.txtAnio.value

o_rcel.exportar_cabecera()
ENDPROC


************************************************************
OBJETO: Clscerrar1
************************************************************
*** PROPIEDADES ***
Top = 132
Left = 477
Name = "Clscerrar1"

*** METODOS ***


************************************************************
OBJETO: cls_export_ventas_rcel_form
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_export_ventas_rcel
************************************************************
*** PROPIEDADES ***
Height = 17
Width = 98
n_mes = 0
n_anio = 0
c_path = 
Name = "cls_export_ventas_rcel"

*** METODOS ***
PROCEDURE exportar_cabecera
*************************************************************
* Permite exportar la cabecera de comprobantes duplicados
* RCEL - Régimen de comprobantes
*************************************************************

LOCAL loRes, lcSql, lcFileName, lcFileNameDetalle, lnFileHandler, lnFileHandlerDetalle, lcLinea, lcSalto
LOCAL loDateTime, lcMes, lcDia

* Las siguientes variables son para generar cada campo que va a ir
* plasmado en el txt

LOCAL lcTipoRegistro && tipo de registro
LOCAL lcFecCbte 	&& Fecha del comprobante
LOCAL lcTipoCbte 	&& Tipo de comprobante
LOCAL lcPtoVta		&& Punto de Venta
LOCAL lcNroCbte		&& Número de comprobante
LOCAL lcNroCbteReg	&& Número de comprobante registrado
LOCAL lcCodDoc		&& Código de documento
LOCAL lcNroDoc		&& Número de documento
LOCAL lcRazSoc		&& Razón Social
LOCAL lcImpTotOper	&& Importe total de la operación
LOCAL lcTotConc		&& Importe de conceptos que no integran el precio neto
LOCAL lcPercNoCat 	&& Percepcion no categorizado / Importe neto gravado
LOCAL lcImpNtoGrav
LOCAL lcImpOpcExt	&& Impuesto de operacion exentas
LOCAL lcImpPerIN	&& Importe de percepcines de impuestos nacionales
LOCAL lcImpPerIIBB	&& Importe de percepcines de ingresos brutos
LOCAL lcImpPerIM	&& Importe de percepcines de impuestos Municipales
LOCAL lcIIInt		&& Importe de impuestos internos
LOCAL lcTransporte	&& que es?
LOCAL lcTipRespo	&& Tipo de responsable
LOCAL lcCodMon		&& Código de moneda
LOCAL lcTipoCbio	&& Tipo de cambio
LOCAL lcCantAlicIVA	&& Cantidad de alícuota de IVA
LOCAL lcCodOper		&& Código de operación
LOCAL lcCAE			&& CAI CAE CAEA CESP
LOCAL lcFecVto		&& Fecha vencimiento
LOCAL lcFecAnuCbte	&& Fecha de anulación de comprobante
LOCAL lcOtroTrib	&& Otros tributos
LOCAL lcConFiscal  && Controlador fiscal
&& Alícuotas
LOCAL lcCantHojas && Cantidad de hojas
LOCAL lcAlicIVA		&& Alícuota de IVA
LOCAL lcImpLiq		&& Impuesto liquidado
LOCAL lcCAE

* Variables para el registro de tipo 2
LOCAL lcCantidadReg, lnImporteTotal, lnTotalNetoGravado, lnTotalLiquidado, lnTotalIIBB 

lnImporteTotal = 0
lnCantidadReg= 0
lnTotalNetoGravado = 0
lnTotalLiquidado = 0
lnTotalIIBB = 0

* Inicializo las variables. 
loDateTime = CREATEOBJECT("datetime")
loRes = CREATEOBJECT("odbc_result")
lcDia = ""
lcMes = ""
lcSql = ""

lcFecCbte = ""
lcTipoCbte = ""
lcPtoVta = ""
lcNroCbte = ""
lcNroCbteReg = ""
lcCodDoc = ""
lcNroDoc = ""
lcRazSoc = ""
lcImpTotOper = ""
lcImpNtoGrav = ""
lcTotConc = ""
lcPercNoCat = ""
lcImpOpcExt = ""
lcImpPerIN = ""
lcImpPerIIBB = ""
lcImpPerIM = ""
lcIIInt = ""
lcTransporte = ""
lcTipRespo = ""
lcCodMon = ""
lcTipoCbio = ""
lcCantAlicIVA = ""
lcCAE = ""
lcFecVto = ""
lcFecAnuCbte = ""
lcOtroTrib = ""

lcConFiscal = REPLICATE(SPACE(1), 1)
lcTipoRegistro = "1"
lcCantHojas = "001"
lcTransporte = REPLICATE("0", 15)
lcCodOper = REPLICATE(SPACE(1), 1)
lcSalto = CHR(13) + CHR(10)

TEXT TO lcSql NOSHOW
	SELECT		
		ventascab.fecEmision, 	
		ventascab.aut_tipoCbte, 	
		ventascab.ptoVta,   
		ventascab.numCbte,	
		tipodoc.CodAfip, 	
		ventascab.nroDoc, 	
		ventascab.razSoc, 	
		ventascab.impFinal,
		ventascab.totFact, 	
		ventascab.totaNoGrav,	
		ventascab.impNeto, 	
		ventascab.impIIBB,	   
		ventascab.idSitIVA,   
		ventascab.impIVA21,	
		ventascab.impIVA105,
		ventascab.aut_CAE, 	
		ventascab.fecVto, 	
		ventascab.idVentasC 
	FROM ventascab   
	INNER JOIN 
		tipodoc ON tipodoc.idTipoDoc = ventascab.idTipoDoc   
	WHERE  
		MONTH(ventascab.FecEmision) = ?pMes AND
		YEAR(ventascab.FecEmision ) = ?pAnio AND 
		ventascab.cbte NOT IN ('PED', 'COT', 'PTO') AND 
		ventascab.fecBaja IS NULL AND 
		ventascab.aut_Resultado = 'A';
ENDTEXT

lcSql = loRes.AddParameter(lcSql, "pMes", ALLTRIM(STR(This.n_mes)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "pAnio", ALLTRIM(STR(This.n_anio)), .f., .f.)

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_rcelcab"
loRes.OpenQuery(lcSql)

SELECT cur_rcelcab
IF RECCOUNT() = 0 then
	MESSAGEBOX("No hay registro en este mes")
	RETURN .f. 
ELSE

	lcFileName = "CABECERA"
	lcFileNameDetalle = "DETALLE"

	lcFileName = PUTFILE("Guardar Como:", lcFileName, "txt")
	lcFileNameDetalle = PUTFILE("Guardar Como:", lcFileNameDetalle, "txt")


	lnFileHandler = FCREATE(lcFileName)
	lnFileHandlerDetalle = FCREATE(lcFileNameDetalle)
endif

** Formatear los datos para generar el archivo.
SELECT cur_rcelcab
GO top
DO WHILE !EOF("cur_rcelcab")
	
	IF LEN(ALLTRIM(STR(DAY(cur_rcelcab.fecEmision)))) = 1 then
		lcDia = "0" + ALLTRIM(STR(DAY(cur_rcelcab.fecEmision)))
	ELSE 
		lcDia = ALLTRIM(STR(DAY(cur_rcelcab.fecEmision)))
	ENDIF
	
	IF LEN(ALLTRIM(STR(MONTH(cur_rcelcab.fecEmision)))) = 1 then
		lcMes = "0" + ALLTRIM(STR(MONTH(cur_rcelcab.fecEmision)))
	ELSE
		lcMes = ALLTRIM(STR(MONTH(cur_rcelcab.fecEmision)))
	ENDIF
	
	lcFecCbte = ALLTRIM(STR(YEAR(cur_rcelcab.fecEmision))) + ALLTRIM(lcMes) + ALLTRIM(lcDia)
	lcTipoCbte = ALLTRIM(cur_rcelcab.aut_tipoCbte)
	lcPtoVta = REPLICATE("0", 4 - LEN(ALLTRIM(STR(cur_rcelcab.ptoVta)))) + ALLTRIM(STR(cur_rcelcab.ptoVta))
	
	lcNroCbte = REPLICATE("0", 8 - LEN(ALLTRIM(STR(cur_rcelcab.numCbte)))) + ALLTRIM(STR(cur_rcelcab.numCbte))
	lcNroCbteReg = lcNroCbte
	lcCodDoc = ALLTRIM(cur_rcelcab.codAfip)
	lcNroDoc = REPLICATE("0", 11 - LEN(ALLTRIM(cur_rcelcab.nroDoc))) + ALLTRIM(cur_rcelcab.nroDoc)
	
	IF LEN(ALLTRIM(cur_rcelcab.razSoc)) > 30 then
		lcRazSoc = SUBSTR(ALLTRIM(cur_rcelcab.razSoc), 1, 30)
	ELSE
		lcRazSoc = ALLTRIM(cur_rcelcab.razSoc) + REPLICATE(SPACE(1), 30 - LEN(ALLTRIM(cur_rcelcab.razSoc)))
	ENDIF 
	
	lcImpTotOper = STRTRAN(ALLTRIM(STR(cur_rcelcab.totFact, 10, 2)), ".", "")
	lcImpTotOper = REPLICATE("0", 15 - LEN(ALLTRIM(lcImpTotOper))) + ALLTRIM(lcImpTotOper)
	
	lcTotConce= REPLICATE("0", 15)
	
	lcImpNtoGrav = STRTRAN(ALLTRIM(STR(cur_rcelcab.impFinal, 10, 2)), ".", "")
	lcImpNtoGrav = REPLICATE("0", 15 - LEN(ALLTRIM(lcImpNtoGrav))) + ALLTRIM(lcImpNtoGrav)
	
	lcImpLiq = cur_rcelcab.impIVA21 + cur_rcelcab.impIVA105

*	Agrego la suma del total liquidado para el registro de tipo 2.	
	lnTotalLiquidado = lnTotalLiquidado + lcImpLiq

	lcImpLiq = STRTRAN(ALLTRIM(STR(lcImpLiq, 10, 2)), ".", "")
	lcImpLiq = REPLICATE("0", 15 - LEN(ALLTRIM(lcImpLiq))) + ALLTRIM(lcImpLiq)
	
	lcPerNoCat = REPLICATE("0", 15)
	lcImpOpcExt = REPLICATE("0", 15)
	lcImpPerIN = REPLICATE("0", 15)
	lcImpPerIIBB = STRTRAN(ALLTRIM(STR(cur_rcelcab.impIIBB, 10, 2)), ".", "")
	lcImpPerIIBB = REPLICATE("0", 15 - LEN(ALLTRIM(lcImpPerIIBB))) + ALLTRIM(lcImpPerIIBB)
	lcImpPerIM = REPLICATE("0", 15)
	lcIIInt = REPLICATE("0", 15)
	lcTipRespo = REPLICATE("0", 2 - LEN(ALLTRIM(STR(cur_rcelcab.idSitIVA)))) + ALLTRIM(STR(cur_rcelcab.idSitIVA))
	lcCodMon = "PES"
	lcTipoCbio = "0001000000"
	
	IF cur_rcelcab.impIVA21 <> 0 .and. cur_rcelcab.impIVA105 <> 0 then
		lcCantAlicIVA = "2"
	ELSE
		lcCantAlicIVA = "1"
	ENDIF
	
	lcCAE = REPLICATE("0", 14 - LEN(ALLTRIM(cur_rcelcab.aut_CAE))) + ALLTRIM(cur_rcelcab.aut_CAE)

	IF LEN(ALLTRIM(STR(DAY(cur_rcelcab.fecVto)))) = 1 then
		lcDia = "0" + ALLTRIM(STR(DAY(cur_rcelcab.fecVto)))
	ELSE
		lcDia = ALLTRIM(STR(DAY(cur_rcelcab.fecVto)))
	ENDIF	
	
	IF LEN(ALLTRIM(STR(MONTH(cur_rcelcab.fecVto)))) = 1 then
		lcMes = "0" + ALLTRIM(STR(MONTH(cur_rcelcab.fecVto)))
	ELSE
		lcMes = ALLTRIM(STR(MONTH(cur_rcelcab.fecVto)))
	ENDIF
	
	lcFecVto = ALLTRIM(STR(YEAR(cur_rcelcab.fecVto))) + ALLTRIM(lcMes) + ALLTRIM(lcDia)
	lcFecAnuCbte = REPLICATE(SPACE(1), 8)
	
	lnIdVentaC = cur_rcelcab.idVentasC
	this.exportar_detalle(lnIdVentaC, lnFileHandlerDetalle)
	
	** Agrego las sumas para los importe del registro 2
	lnImporteTotal = lnImporteTotal + cur_rcelcab.totFact
	lnCantidadReg= lnCantidadReg + 1
	lnTotalNetoGravado = lnTotalNetoGravado + cur_rcelcab.impFinal
	lnTotalIIBB = lnTotalIIBB + cur_rcelcab.impIIBB
	
	lcLinea = lcTipoRegistro;
		+ lcFecCbte ;
		+ lcTipoCbte ;
		+ lcConFiscal ;
		+ lcPtoVta ;
		+ lcNroCbte ;
		+ lcNroCbteReg ;
		+ lcCantHojas ;
		+ lcCodDoc ;
		+ lcNroDoc ;
		+ lcRazSoc ; 
		+ lcImpTotOper ;
		+ lcTotConce ;
		+ lcImpNtoGrav ;
		+ lcImpLiq ;
		+ lcPerNoCat ;
		+ lcImpOpcExt ;
		+ lcImpPerIN ;
		+ lcImpPerIIBB ;
		+ lcImpPerIM ;
		+ lcIIInt ;
		+ lcTransporte ;
		+ lcTipRespo ;
		+ lcCodMon ;
		+ lcTipoCbio ;
		+ lcCantAlicIVA ;
		+ lcCodOper ;
		+ lcCAE; 
		+ lcFecVto ;
		+ lcFecAnuCbte ;
		+ lcOtroTrib ;
		+ lcSalto
	FWRITE(lnFileHandler, lcLinea)
*	Realizar la suma de los campos que necesito	
	SELECT cur_rcelcab
	skip
ENDDO 
* Armar la línea de los campos sumados para el registro de tipo 2.
lcLinea = this.calcular_registro(lnCantidadReg, lnImporteTotal, lnTotalNetoGravado, lnTotalLiquidado, lnTotalIIBB)

FWRITE(lnFileHandler, lcLinea)

loRes.Close_Query()

FCLOSE(lnFileHandler)
FCLOSE(lnFileHandlerDetalle)

MESSAGEBOX("Archivo creado en el directorio: " + lcFileName)
ENDPROC
PROCEDURE exportar_detalle
*************************************************************************
* Permite exportar el detalle de comprobantes duplicados.
* RCEL - Régimen de comprobantes
*************************************************************************
PARAMETERS lnIdVentaC, lnFileHandler 

LOCAL loRes, lcSql 
LOCAL lcLinea, lcSalto, lcDia, lcMes

LOCAL lcTipoCbte, lcConFisc, lcFecEmision, lcPtoVta, lcNumCbte, lcNumCbteReg 
LOCAL lcCantidad, lcUnidadMedida, lcPrVenta, lcImpBonificacion, lcImpAjuste, lcSubTotal
LOCAL lcAliCuota, lcIndicaExtGrav, lcAnulado, lcDescripcion

loRes = CREATEOBJECT("odbc_result")

***** Variables para el txt
lcTipoCbte = ""
lcFecEmision = ""
lcConFisc = REPLICATE(SPACE(1), 1)
lcPtoVta = ""
lcNumCbte = ""
lcNumCbteReg = ""
lcCantidad = ""
lcUnidadMedida = ""
lcPrVenta = "" 
lcImpBonificacion = ""
lcImpAjuste = ""
lcSubTotal = ""
lcAliCuota = ""
lcIndicaExtGrav = ""
lcAnulado = REPLICATE(SPACE(1), 1)
lcDescripcion = ""

lcDia = ""
lcMes = ""
lcSql = ""
lcSalto = CHR(13) + CHR(10)

TEXT TO lcSql NOSHOW
	select 	
		ventascab.aut_tipoCbte,    
		ventascab.fecEmision,    
		ventascab.ptoVta,    
		ventascab.numCbte,    
		ventasdet.cantidad,    
		ventasdet.codUM,    
		ventasdet.prVenta,
		ventasdet.iDtoVta1,
		ventasdet.iDtoVta2,
		ventasdet.iDtoVta3,
		ventasdet.iDtoVta4,    
		ventasdet.subTotal,    
		ventasdet.alicIVA,    
		ventasdet.descripcio
	from 	
		ventasdet 
	inner join	
		ventascab on ventascab.idVentasC = ventasdet.idVentasC
	where 	
		ventasdet.idVentasC = ?pVentas;
endtext

lcSql = loRes.AddParameter(lcSql, "pVentas", ALLTRIM(STR(lnIdVentaC)), .f., .f.)

loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_name = "cur_rceldet"
loRes.OpenQuery(lcSql)

SELECT cur_rceldet
GO top
DO WHILE !EOF("cur_rceldet")
	lcTipoCbte = ALLTRIM(cur_rceldet.aut_tipoCbte)

	IF LEN(ALLTRIM(STR(DAY(cur_rceldet.fecEmision)))) = 1 then
		lcDia = "0" + ALLTRIM(STR(DAY(cur_rceldet.fecEmision)))
	ELSE 
		lcDia = ALLTRIM(STR(DAY(cur_rceldet.fecEmision)))
	ENDIF

	IF LEN(ALLTRIM(STR(MONTH(cur_rceldet.fecEmision)))) = 1 then
		lcMes = "0" + ALLTRIM(STR(month(cur_rceldet.fecEmision)))
	ELSE
		lcMes = ALLTRIM(STR(month(cur_rceldet.fecEmision)))
	ENDIF 

	lcFecEmision = ALLTRIM(STR(YEAR(cur_rceldet.fecEmision))) + ALLTRIM(lcMes) + ALLTRIM(lcDia)
	lcPtoVta = REPLICATE("0", 4 - LEN(ALLTRIM(STR(cur_rceldet.ptoVta)))) + ALLTRIM(STR(cur_rceldet.ptoVta))

	lcNumCbte = REPLICATE("0", 8 - LEN(ALLTRIM(STR(cur_rceldet.numCbte)))) + ALLTRIM(STR(cur_rceldet.numCbte))
	lcNumCbteReg = lcNumCbte

	lcCantidad = TRANSFORM(cur_rceldet.cantidad, "9999999.99999")
	lcCantidad = STRTRAN(lcCantidad, " ", "0")
	lcCantidad = STRTRAN(lcCantidad, ".", "")
	lcCantidad = REPLICATE("0", 12 - LEN(ALLTRIM(lcCantidad))) + ALLTRIM(lcCantidad)

	IF ALLTRIM(cur_rceldet.codUM) = 'UNI' then
		lcUnidadMedida = "07"
	ELSE
		lcUnidadMedida = "02"
	ENDIF 

	lcPrVenta = STRTRAN(ALLTRIM(STR(cur_rceldet.prVenta, 13, 3)), ".", "")
	lcPrVenta= REPLICATE("0", 16 - LEN(ALLTRIM(lcPrVenta))) + ALLTRIM(lcPrVenta)

	IF cur_rceldet.iDtoVta1 <> 0 .or. cur_rceldet.iDtoVta2 <> 0 .or. cur_rceldet.iDtoVta3 <> 0 .or. cur_rceldet.iDtoVta4 <> 0 THEN
		lcImpBonificacion = cur_rceldet.iDtoVta1 + cur_rceldet.iDtoVta2 + cur_rceldet.iDtoVta3 + cur_rceldet.iDtoVta4
		lcImpBonificacion = STRTRAN(ALLTRIM(STR(lcImpBonificacion, 13, 3)), ".", "")
		lcImpBonificacion = REPLICATE("0", 15 - LEN(ALLTRIM(lcImpBonificacion))) + ALLTRIM(lcImpBonificacion)
	ELSE 
		lcImpBonificacion = REPLICATE("0", 15)
	ENDIF

	lcImpAjuste = REPLICATE("0", 16)

	lcSubTotal = STRTRAN(ALLTRIM(STR(cur_rceldet.subtotal, 13 , 3)), ".", "")
	lcSubTotal = REPLICATE("0", 16 - LEN(ALLTRIM(lcSubTotal))) + ALLTRIM(lcSubTotal)

	lcAliCuota = ALLTRIM(STR(cur_rceldet.alicIVA)) + replicate("0", 4 - LEN(ALLTRIM(STR(cur_rceldet.alicIVA)))) 

	IF lcAliCuota <> "0000" then
		lcIndicaExtGrav = "G"
	ELSE
		lcIndicaExtGrav = "N"
	ENDIF

	lcDescripcion = ALLTRIM(cur_rceldet.descripcio) + REPLICATE(SPACE(1), 75 - LEN(ALLTRIM(cur_rceldet.descripcio)))

	lcLinea = lcTipoCbte ;
			+ lcConFisc ;
			+ lcFecEmision ;
			+ lcPtoVta ;
			+ lcNumCbte ;
			+ lcNumCbteReg ;
			+ lcCantidad ;
			+ lcUnidadMedida ;
			+ lcPrVenta ;
			+ lcImpBonificacion ;
			+ lcImpAjuste ;
			+ lcSubTotal ;
			+ lcAliCuota ;
			+ lcIndicaExtGrav ;
			+ lcAnulado;
			+ lcDescripcion ;
			+ lcSalto
			
	FWRITE(lnFileHandler, lcLinea)

	SELECT cur_rceldet
		skip
ENDDO
ENDPROC
PROCEDURE calcular_registro
***********************************************************************************
* Esté método lo voy a usar para calcular los importes para el registor de tipo 2
***********************************************************************************
PARAMETERS lcCantidadReg, lcImporteTotal, lcTotalNetoGravado, lcTotalLiquidado, lcTotalIIBB 

LOCAL lcLinea
LOCAL lcTipoRegistro, lcFecPeriodo, lcFeCuit, lcTotConce
LOCAL lcNoCate, lcExten, lcImpNac, lcImpInt, lcImpMun

lcLinea = ""
lcTipoRegistro = "2"
lcFecPeriodo = ""
lcTotConce = ""
lcNoCate = ""
lcExten = ""
lcImpNac = ""
lcImpInt = ""
lcImpMun = ""
IF LEN(alltrim(STR(this.n_mes))) = 1 then
	lcFecPeriodo = "0" + ALLTRIM(STR(this.n_mes))
ELSE
	lcFecPeriodo = ALLTRIM(str(this.n_mes))
endif 

lcFecPeriodo = ALLTRIM(STR(this.n_anio)) + ALLTRIM(lcFecPeriodo)
lcCantidadReg= REPLICATE("0", 8 - LEN(ALLTRIM(STR(lcCantidadReg)))) + ALLTRIM(STR(lcCantidadReg))

lcImporteTotal= STRTRAN(ALLTRIM(STR(lcImporteTotal, 13, 2)), ".", "")
lcImporteTotal = REPLICATE("0", 15 - LEN(ALLTRIM(lcImporteTotal))) + ALLTRIM(lcImporteTotal)

lcTotalNetoGravado = STRTRAN(ALLTRIM(STR(lcTotalNetoGravado, 13, 2)), ".", "")
lcTotalNetoGravado = REPLICATE("0", 15 - LEN(ALLTRIM(lcTotalNetoGravado))) + ALLTRIM(lcTotalNetoGravado)

lcFeCuit = getGlobalCFG("fecuit")
lcFeCuit = ALLTRIM(lcFeCuit)

lcTotConce = REPLICATE("0", 15)

lcTotalLiquidado = STRTRAN(ALLTRIM(STR(lcTotalLiquidado, 13, 2)), ".", "")
lcTotalLiquidado = REPLICATE("0", 15 - LEN(ALLTRIM(lcTotalLiquidado))) + ALLTRIM(lcTotalLiquidado)

lcNoCate = REPLICATE("0", 15)
lcExten = REPLICATE("0", 15)
lcImpNac = REPLICATE("0", 15)

lcTotalIIBB= STRTRAN(ALLTRIM(STR(cur_rcelcab.impIIBB, 10, 2)), ".", "")
lcTotalIIBB= REPLICATE("0", 15 - LEN(ALLTRIM(lcTotalIIBB))) + ALLTRIM(lcTotalIIBB)

lcImpInt = REPLICATE("0", 15)
lcImpMun = REPLICATE("0", 15)

lcLinea = lcTipoRegistro;
		+ lcFecPeriodo;
		+ REPLICATE(SPACE(1),13);
		+ lcCantidadReg;
		+ REPLICATE(SPACE(1), 17);
		+ lcFeCuit;
		+ REPLICATE(SPACE(1), 22);
		+ lcImporteTotal;
		+ lcTotConce;
		+ lcTotalNetoGravado;
		+ lcTotalLiquidado;
		+ lcNoCate ;
		+ lcExten ;
		+ lcImpNac ;
		+ lcTotalIIBB ;
		+ lcImpInt ;
		+ lcImpMun ;
		+ REPLICATE(SPACE(1), 62)

RETURN lcLinea

ENDPROC


