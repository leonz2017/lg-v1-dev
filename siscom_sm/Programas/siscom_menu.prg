SET SYSMENU TO
SET SYSMENU AUTOMATIC

LOCAL lcSql, li_IDX, ll_Ok, liIndice, oRes, loResPopup
LOCAL lcNombreMenu, lcNombrePopup, lcProcedim, lcTitle

oRes = CREATEOBJECT("odbc_result")
loResPopup = CREATEOBJECT("odbc_result")
DIMENSION laCodMenues[1]

lcSql = "SELECT  menues.* "
lcSql = lcSql + "FROM    menues, accesos  "
lcSql = lcSql + "WHERE   menues.idMenue = accesos.idMenue "
lcSql = lcSql + "   AND accesos.idUsuario = " + ALLTRIM(STR(gnUserID)) + " AND menues.fecBaja IS NULL "
lcSql = lcSql + "ORDER BY menues.orden ASC "

oRes.ActiveConnection = goConn.ActiveConnection
oRes.Cursor_Name = "cur_Menu"
oRes.OpenQuery(lcSql)

SELECT cur_Menu

IF RECCOUNT() > 0
	GO TOP
ENDIF

li_IDX = 1
liIndice = 0
SELECT cur_Menu
DO WHILE !EOF("cur_Menu")
	
	lcNombreMenu = "M" + ALLTRIM(STR(cur_Menu.enlace))
	lcNombrePopup = "_popup" + ALLTRIM(STR(cur_Menu.enlace))
	lcTitle = cur_Menu.Nombre
	
	IF !cur_Menu.isChild THEN
		liIndice = 1
		DEFINE PAD (lcNombreMenu) OF _MSYSMENU PROMPT ALLTRIM(lcTitle) COLOR SCHEME 3
		ON PAD (lcNombreMenu) OF _MSYSMENU ACTIVATE POPUP (lcNombrePopup)
		DEFINE POPUP (lcNombrePopup) MARGIN RELATIVE SHADOW COLOR SCHEME 4	
	ELSE
		*lcProcedim = "DO FORM " + ALLTRIM(cur_Menu.Procedim)
		lcProcedim = IIF(ALLTRIM(cur_Menu.Procedim) == "-", "", ALLTRIM(cur_Menu.Procedim))
			
		DEFINE BAR (liIndice) OF (lcNombrePopup) PROMPT ALLTRIM(cur_Menu.Nombre)
		ON SELECTION BAR (liIndice) OF (lcNombrePopup) &lcProcedim
		
		liIndice = liIndice + 1
	ENDIF
	
	li_IDX = li_IDX + 1	
	SELECT cur_Menu
	SKIP
ENDDO

USE IN cur_Menu

DEFINE PAD soporte OF _MSYSMENU PROMPT "\<Soporte" COLOR SCHEME 3 ;
	KEY ALT+A, ""
ON PAD soporte OF _MSYSMENU ACTIVATE POPUP soporte


DEFINE POPUP soporte MARGIN RELATIVE SHADOW COLOR SCHEME 4
DEFINE BAR 1 OF soporte PROMPT "\<Mesa de ayuda"
DEFINE BAR 2 OF soporte PROMPT "\<Acerca de..."
ON SELECTION BAR 1 OF soporte DO FORM "frm_soporte"
ON SELECTION BAR 2 OF soporte DO FORM "frmacercade"

DEFINE PAD Cerrar OF _MSYSMENU PROMPT "\<Cerrar" COLOR SCHEME 3 
ON PAD Cerrar OF _MSYSMENU ACTIVATE POPUP Cerrar

DEFINE POPUP Cerrar MARGIN RELATIVE SHADOW COLOR SCHEME 4
DEFINE BAR 1 OF Cerrar PROMPT "\<Salir"
ON SELECTION BAR 1 OF Cerrar ;
	DO _3w017ocpj


PROCEDURE _3w017ocpj
*LOCAL lcSql, loCommand

*lcSql = ""
*loCommand = CREATEOBJECT("odbc_command")

*lcSql = "delete from terminales where idTerminal = " + ALLTRIM(STR(gnIdTerminal))
*loCommand.ActiveConnection = goConn.ActiveConnection
*loCommand.CommandText = lcSql
*loCommand.Execute()

CLEAR ALL
CLOSE DATABASES ALL
QUIT

