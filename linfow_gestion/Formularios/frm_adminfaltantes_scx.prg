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
OBJETO: FRM_ADMINFALTANTES
************************************************************
*** PROPIEDADES ***
DoCreate = .T.
Name = "FRM_ADMINFALTANTES"
CONTENIDO.grdFaltantes.COLUMN1.HEADER1.Name = "HEADER1"
CONTENIDO.grdFaltantes.COLUMN1.TEXT1.Name = "TEXT1"
CONTENIDO.grdFaltantes.COLUMN1.CLSCHECKBOX1.Alignment = 0
CONTENIDO.grdFaltantes.COLUMN1.CLSCHECKBOX1.Name = "CLSCHECKBOX1"
CONTENIDO.grdFaltantes.COLUMN1.Name = "COLUMN1"
CONTENIDO.grdFaltantes.COLUMN2.HEADER1.Name = "HEADER1"
CONTENIDO.grdFaltantes.COLUMN2.TEXT1.Name = "TEXT1"
CONTENIDO.grdFaltantes.COLUMN2.Name = "COLUMN2"
CONTENIDO.grdFaltantes.COLUMN3.HEADER1.Name = "HEADER1"
CONTENIDO.grdFaltantes.COLUMN3.TEXT1.Name = "TEXT1"
CONTENIDO.grdFaltantes.COLUMN3.Name = "COLUMN3"
CONTENIDO.grdFaltantes.COLUMN4.HEADER1.Name = "HEADER1"
CONTENIDO.grdFaltantes.COLUMN4.TEXT1.Name = "TEXT1"
CONTENIDO.grdFaltantes.COLUMN4.Name = "COLUMN4"
CONTENIDO.grdFaltantes.COLUMN5.HEADER1.Name = "HEADER1"
CONTENIDO.grdFaltantes.COLUMN5.TEXT1.Name = "TEXT1"
CONTENIDO.grdFaltantes.COLUMN5.Name = "COLUMN5"
CONTENIDO.grdFaltantes.COLUMN6.HEADER1.Name = "HEADER1"
CONTENIDO.grdFaltantes.COLUMN6.TEXT1.Name = "TEXT1"
CONTENIDO.grdFaltantes.COLUMN6.Name = "COLUMN6"
CONTENIDO.grdFaltantes.COLUMN7.HEADER1.Name = "HEADER1"
CONTENIDO.grdFaltantes.COLUMN7.TEXT1.Name = "TEXT1"
CONTENIDO.grdFaltantes.COLUMN7.Name = "COLUMN7"
CONTENIDO.grdFaltantes.COLUMN8.HEADER1.Name = "HEADER1"
CONTENIDO.grdFaltantes.COLUMN8.TEXT1.Name = "TEXT1"
CONTENIDO.grdFaltantes.COLUMN8.Name = "COLUMN8"
CONTENIDO.grdFaltantes.COLUMN9.HEADER1.Name = "HEADER1"
CONTENIDO.grdFaltantes.COLUMN9.TEXT1.Name = "TEXT1"
CONTENIDO.grdFaltantes.COLUMN9.Name = "COLUMN9"
CONTENIDO.grdFaltantes.COLUMN10.HEADER1.Name = "HEADER1"
CONTENIDO.grdFaltantes.COLUMN10.TEXT1.Name = "TEXT1"
CONTENIDO.grdFaltantes.COLUMN10.Name = "COLUMN10"
CONTENIDO.grdFaltantes.COLUMN11.HEADER1.Name = "HEADER1"
CONTENIDO.grdFaltantes.COLUMN11.TEXT1.Name = "TEXT1"
CONTENIDO.grdFaltantes.COLUMN11.Name = "COLUMN11"
CONTENIDO.grdFaltantes.COLUMN12.HEADER1.Name = "HEADER1"
CONTENIDO.grdFaltantes.COLUMN12.TEXT1.Name = "TEXT1"
CONTENIDO.grdFaltantes.COLUMN12.Name = "COLUMN12"
CONTENIDO.grdFaltantes.COLUMN13.HEADER1.Name = "HEADER1"
CONTENIDO.grdFaltantes.COLUMN13.TEXT1.Name = "TEXT1"
CONTENIDO.grdFaltantes.COLUMN13.Name = "COLUMN13"
CONTENIDO.grdFaltantes.COLUMN14.HEADER1.Name = "HEADER1"
CONTENIDO.grdFaltantes.COLUMN14.TEXT1.Name = "TEXT1"
CONTENIDO.grdFaltantes.COLUMN14.Name = "COLUMN14"
CONTENIDO.grdFaltantes.COLUMN15.HEADER1.Name = "HEADER1"
CONTENIDO.grdFaltantes.COLUMN15.TEXT1.Name = "TEXT1"
CONTENIDO.grdFaltantes.COLUMN15.Name = "COLUMN15"
CONTENIDO.grdFaltantes.COLUMN16.HEADER1.Name = "HEADER1"
CONTENIDO.grdFaltantes.COLUMN16.TEXT1.Name = "TEXT1"
CONTENIDO.grdFaltantes.COLUMN16.Name = "COLUMN16"
CONTENIDO.grdFaltantes.COLUMN17.HEADER1.Name = "HEADER1"
CONTENIDO.grdFaltantes.COLUMN17.TEXT1.Name = "TEXT1"
CONTENIDO.grdFaltantes.COLUMN17.Name = "COLUMN17"
CONTENIDO.grdFaltantes.COLUMN18.HEADER1.Name = "HEADER1"
CONTENIDO.grdFaltantes.COLUMN18.TEXT1.Name = "TEXT1"
CONTENIDO.grdFaltantes.COLUMN18.Name = "COLUMN18"
CONTENIDO.grdFaltantes.COLUMN19.HEADER1.Name = "HEADER1"
CONTENIDO.grdFaltantes.COLUMN19.TEXT1.Name = "TEXT1"
CONTENIDO.grdFaltantes.COLUMN19.Name = "COLUMN19"
CONTENIDO.grdFaltantes.COLUMN20.HEADER1.Name = "HEADER1"
CONTENIDO.grdFaltantes.COLUMN20.TEXT1.Name = "TEXT1"
CONTENIDO.grdFaltantes.COLUMN20.Name = "COLUMN20"
CONTENIDO.grdFaltantes.Name = "grdFaltantes"
CONTENIDO.BTNGRABAR.Name = "BTNGRABAR"
CONTENIDO.BTNCERRAR.Name = "BTNCERRAR"
CONTENIDO.CLSETIQUETA1.Name = "CLSETIQUETA1"
CONTENIDO.SEL_MARCA.TXTCODIGO.Name = "TXTCODIGO"
CONTENIDO.SEL_MARCA.TXTDESCRIPCION.Name = "TXTDESCRIPCION"
CONTENIDO.SEL_MARCA.Name = "SEL_MARCA"
CONTENIDO.BTNBUSCAR.Name = "BTNBUSCAR"
CONTENIDO.CLSETIQUETA2.Name = "CLSETIQUETA2"
CONTENIDO.OC.Name = "OC"
CONTENIDO.faltantes.Name = "faltantes"
CONTENIDO.CLSEXCEL1.Name = "CLSEXCEL1"
CONTENIDO.Clsdelete1.Name = "Clsdelete1"
CONTENIDO.Name = "CONTENIDO"

*** METODOS ***
PROCEDURE limpiar_faltantes
* ********************************************************************************
* Limpio los faltantes que tienen más de 30 días de antiguedad.
* Uso un DELETE y los elimino físcamente para aprovechar a que no se llene la
* tabla de faltantes.
* ********************************************************************************

LOCAL loCmd
LOCAL lcSql

loCmd = CREATEOBJECT("odbc_command")

TEXT TO lcSql NOSHOW
	DELETE
	FROM
		faltantes
	WHERE
		CAST(REPLACE(faltantes.fecAlta, ':', '') AS UNSIGNED) <= CAST(REPLACE(date_sub(current_date, INTERVAL 30 DAY), ':', '') AS UNSIGNED);
ENDTEXT

goConn.BeginTransaction()
loCmd.ActiveConnection = goConn.ActiveConnection
loCmd.CommandText = lcSql
IF !loCmd.execute() THEN
	goConn.Rollback()
	MESSAGEBOX(loCmd.ErrorMessage, 0+48, Thisform.Caption)
	RETURN .F.
ENDIF
goConn.Commit()

RETURN .T.
ENDPROC
PROCEDURE Init
DODEFAULT()

&& Limpio los faltantes en el momentoque se inicia el
&& formulario
* thisform.limpiar_faltantes()

ENDPROC


************************************************************
OBJETO: 
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


