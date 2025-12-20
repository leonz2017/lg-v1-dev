*************************************************************************************
* Función.......: cls_planillaprecios.prg
* Descripción...: Clase que permite generar la planilla de precios que requiere GHIO
* Dependencias..: fuciones.prg
* Fecha.........: 15/09/2021
* Autor.........: LINFOW - Leonardo D. Zulli
*************************************************************************************

DEFINE CLASS PlanillaPrecios AS Custom
	PROTECTED pcPath
	PROTECTED poExcel
	PROTECTED poApplicaction
	PROTECTED pcErrorMessage
	PROTECTED poRsFamilias
	PROTECTED poRsSubFamilias
	PROTECTED poRsArticulos
	
	PROCEDURE SetPath
		LPARAMETERS tcPath
		****************************************************************
		* Método.......: SetPath()
		* Descripción..: Establece la ruta y nombre de archivo.
		****************************************************************
		This.pcPath = tcPath
	ENDPROC
	
	FUNCTION GetErrorMessage
		RETURN This.pcErrorMessage
	ENDFUNC
	
	PROCEDURE Iniciar
		This.__IniciarExcel()
		This.poRsFamilias = CREATEOBJECT("odbc_result")
		This.poRsSubFamilias = CREATEOBJECT("odbc_result")
		This.poRsArticulos = CREATEOBJECT("odbc_result")
	ENDPROC
	
	PROTECTED FUNCTION __IniciarExcel
		****************************************************************
		* Método.......: VerificarExcel
		* Descripción..: Verifica si el Excel está instalado y crea instancia.
		****************************************************************
		This.poExcel = CREATEOBJECT("Excel.Application")
		IF !(VARTYPE(This.poExcel) == "O") THEN
			This.pcErrorMessage = "El Excel no se encuentra instalado"
			RETURN .F.
		ENDIF
		This.poApplicaction = This.poExcel.Application
		This.poApplicaction.visible =  .T.
		This.poApplicaction.WorkBooks.Add()
		RETURN .T.
	ENDFUNC

	FUNCTION Procesar
		****************************************************************
		* Método.......: Procesar()
		* Descripción..: Genera los datos en el Excel
		****************************************************************		
		LOCAL lnFila
		LOCAL lnCountProcess
		LOCAL loTherm
		
		lnFila = 1
		lnCountProcess = 0
		loTherm = CREATEOBJECT("_thermometer")
		
		loTherm.Show()
		&& Recorro las familias
		This.GetFamilias()
		SELECT cur_familias
		DO WHILE !EOF("cur_familias")
			&& Agrego título
			This.poApplicaction.cells(lnFila, 2).value = ALLTRIM(cur_familias.descripcio)
			This.poApplicaction.cells(lnFila, 2).Font.Bold = .T.
			This.poApplicaction.cells(lnFila, 2).Interior.ColorIndex = 15
			lnFila = lnFila + 1
			
			&& Recorro las subfamilias
			This.GetSubFamiliasByFam(cur_familias.idFamilia)
			DO WHILE !EOF("cur_subfam")
				&& Agrego subtítulo
				This.poApplicaction.cells(lnFila, 2).value = ALLTRIM(cur_subfam.descripcio)
				This.poApplicaction.cells(lnFila, 2).Font.Bold = .T.
				This.poApplicaction.cells(lnFila, 2).Interior.ColorIndex = 15
				lnFila = lnFila + 1
				
				&& Recorro los artículos
				This.GetArticulosBySF(cur_familias.idFamilia, cur_subfam.idSubFam)
				DO WHILE !EOF("cur_articulos")
					This.poApplicaction.cells(lnFila, 1).value = LEFT(ALLTRIM(cur_articulos.codArt), LEN(ALLTRIM(cur_articulos.codArt)) - 3)
					This.poApplicaction.cells(lnFila, 2).value = ALLTRIM(cur_articulos.descripcio)
					This.poApplicaction.cells(lnFila, 2).Font.Bold = .F.
					This.poApplicaction.cells(lnFila, 3).value = VAL(ALLTRIM(STR(cur_articulos.prventamax, 20, 2)))
					lnFila = lnFila + 1
				
					SELECT cur_articulos
					SKIP
				ENDDO
				This.poRsArticulos.Close_Query()
				
				SELECT cur_subfam
				SKIP
			ENDDO
			This.poRsSubFamilias.Close_Query()
			
			lnCountProcess = lnCountProcess + 1
			loTherm.Update((lnCountProcess * 100) / RECCOUNT("cur_familias"), "Haciendo planilla...")
			SELECT "cur_familias"
			SKIP
		ENDDO
		&& Cierro el cursor de familias
		This.poRsFamilias.Close_Query()
		loTherm.Complete()
		
		&& Autoajusto los anchos de columnas
		This.poApplicaction.cells.select()
		This.poApplicaction.cells.EntireColumn.AutoFit()
	ENDPROC
	
	PROTECTED PROCEDURE GetFamilias()
		****************************************************************
		* Método.......: GetFamilias()
		* Descripción..: Levanta la tabla de rubros
		****************************************************************
		LOCAL lcSql
		
		&& Script para levantar las familias que estén vienentes y tengan
		&& artículos vigentes asociados
		TEXT TO lcSql NOSHOW
			SELECT
				familias.idFamilia,
				familias.descripcio
			FROM
				familias
					INNER JOIN articulos ON articulos.idFamilia = familias.idFamilia
			WHERE
				familias.fecBaja IS NULL AND
				articulos.fecBaja IS NULL AND
				articulos.codArt NOT LIKE '%ARX'
			GROUP BY
				familias.idFamilia
			ORDER BY
				familias.descripcio ASC;
		ENDTEXT
		
		This.poRsFamilias.ActiveConnection = goConn.ActiveConnection
		This.poRsFamilias.Cursor_Name = "cur_familias"
		This.poRsFamilias.OpenQuery(lcSql)
	ENDPROC

	PROTECTED PROCEDURE GetSubFamiliasByFam
		LPARAMETERS tnIdFamilia
		****************************************************************
		* Método.......: GetSubFamiliasByFam()
		* Descripción..: Levanta la tabla de subfamilias de la familia
		*				 actual.
		****************************************************************
		LOCAL lcSql
		
		&& SQL que recupera las subfamilias de la familia actual siempre
		&& y cuando tenga artículos asociados
		TEXT TO lcSql NOSHOW
			SELECT
				subfam.idSubFam,
				subfam.descripcio
			FROM
				subfam
					INNER JOIN articulos ON articulos.idSubFam = subfam.idSubFam
			WHERE
				articulos.idFamilia = ?xidFamilia AND
				subfam.fecBaja IS NULL AND
				articulos.fecBaja IS NULL AND
				articulos.codArt NOT LIKE '%ARX'
			GROUP BY
				subfam.idSubFam
			ORDER BY
				subfam.descripcio ASC;
		ENDTEXT
		lcSql = This.poRsSubFamilias.AddParameter(lcSql, "xidFamilia", ALLTRIM(STR(tnIdFamilia)), .F., .F.)
		This.poRsSubFamilias.Cursor_Name = "cur_subfam"
		This.poRsSubFamilias.ActiveConnection = goConn.ActiveConnection
		This.poRsSubFamilias.OpenQuery(lcSql)
	ENDPROC
	
	PROTECTED PROCEDURE GetArticulosBySF
		LPARAMETERS tnIdFamilia, tnIdSubFamilia
		****************************************************************
		* Método.......: GetArticulosBySF()
		* Descripción..: Levanta los artículos por familia y subfamilia.
		****************************************************************
		LOCAL lcSql
		
		&& SQL que recupera los artículos de la familia y subfamilia
		&& actual.
		TEXT TO lcSql NOSHOW
			SELECT
				articulos.idArticulo,
				articulos.codArt,
				articulos.descripcio,
				articulos.prventaMax
			FROM
				articulos
			WHERE
				articulos.idFamilia = ?xidfamilia AND
				articulos.idSubFam = ?xidsubfam AND
				articulos.fecBaja IS NULL AND
				articulos.codArt NOT LIKE '%ARX' AND
				articulos.habilitado = 1
			ORDER BY
				articulos.descripcio ASC;
		ENDTEXT
		lcSql = This.poRsArticulos.AddParameter(lcSql, "xidfamilia", ALLTRIM(STR(tnIdFamilia)), .f., .f.)
		lcSql = This.poRsArticulos.AddParameter(lcSql, "xidsubfam", ALLTRIM(STR(tnIdSubFamilia)), .f., .f.)
		This.poRsArticulos.Cursor_Name = "cur_articulos"
		This.poRsArticulos.ActiveConnection = goConn.ActiveConnection
		This.poRsArticulos.OpenQuery(lcSql)
	ENDFUNC
	
	PROCEDURE Cerrar
		***************************************************************
		* Método: Cerrar
		* Descripción: Elimina los objetos de memoria
		***************************************************************
		This.poRsArticulos.Release()
		This.poRsFamilias.Release()
		This.poRsSubFamilias.Release()
	ENDPROC
ENDDEFINE