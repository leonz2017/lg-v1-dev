************************************************************
OBJETO: _cbolookup
************************************************************
*** PROPIEDADES ***
FontName = "MS Sans Serif"
FontSize = 8
Height = 23
Style = 2
Width = 175
display_column = 
lookup_table = 
return_column = 
order_column = 
Name = "_cbolookup"

*** METODOS ***
PROCEDURE Destroy
LOCAL cAlias

cAlias = THIS.name
IF USED(m.cAlias) THEN
	USE IN &cAlias
ENDIF

ENDPROC
PROCEDURE Error
LPARAMETERS nError, cMethod, nLine

#DEFINE INVALID_COLUMN_LOC "An invalid display column or return column has been specified in the 'display_column' or 'return_column' properties (combo box " + THIS.name + ")."
#DEFINE INVALID_TABLE_LOC "An invalid table has been specified in the 'display_column' or 'lookup_table' property (combo box " + THIS.name + ")."
#DEFINE INVALID_SORT_LOC "An invalid column has been specified in the 'order_column' property (combo box " + THIS.name + ")."

DO CASE
	CASE nError = 1806
		=MESSAGEBOX(INVALID_COLUMN_LOC,48)
	CASE nError = 1808
		=MESSAGEBOX(INVALID_SORT_LOC,48)
	CASE nError = 1802
		=MESSAGEBOX(INVALID_TABLE_LOC,48)
	OTHERWISE
		=MESSAGEBOX(MESSAGE(),48)
ENDCASE

ENDPROC
PROCEDURE Init
LOCAL lOK, nSQL

lOK = .T.
DO CASE
	CASE EMPTY(THIS.lookup_table)
		=MESSAGEBOX(NO_LOOKUP_TABLE_LOC,48)
		lOK = .F.
	CASE EMPTY(THIS.display_column)
		=MESSAGEBOX(NO_DISPLAY_COLUMN_LOC,48)
		lOK = .F.
	CASE EMPTY(THIS.return_column)
		=MESSAGEBOX(NO_RETURN_COLUMN_LOC,48)
		lOK = .F.
ENDCASE

IF lOK THEN
	IF !EMPTY(THIS.order_column)
		nSQL = "SELECT " + THIS.display_column + "," + THIS.return_column + " FROM " + THIS.lookup_table + " ORDER BY " + THIS.order_column + " INTO CURSOR " + THIS.name
	ELSE
		nSQL = "SELECT " + THIS.display_column + "," + THIS.return_column + " FROM " + THIS.lookup_table + " INTO CURSOR " + THIS.name
	ENDIF
	THIS.RowSourceType = 3
	THIS.RowSource = nSQL
	THIS.BoundColumn = 2
ENDIF
THIS.Refresh
ENDPROC


************************************************************
OBJETO: _cbolookup
************************************************************
*** PROPIEDADES ***
MS Sans Serif, 0, 8, 5, 13, 11, 11, 2, 0

*** METODOS ***


************************************************************
OBJETO: _qbf
************************************************************
*** PROPIEDADES ***
Width = 80
Height = 97
BackStyle = 0
BorderWidth = 0
qbf_table = 
Name = "_qbf"

*** METODOS ***
PROCEDURE parsecondition
LPARAMETERS cCondition, cControlSource
LOCAL lcRetCondition, lcFieldName
IF TYPE('cCondition') = 'C'
	cCondition = ALLTRIM(cCondition)
ENDIF

lcFieldName = SUBSTRC(cControlSource,(RATC(".",cControlSource)+1))

*!* NOTE: If you add a checkbox, radio button, or command group to
*!* the form, this routine will need to be changed to handle that
*!* specific datatype.

IF !EMPTY(cCondition) THEN
	*!* If the type is Character or Memo, check to see if the 
	*!* user has entered a complex condition (if so, take that 
	*!* condition literally without any manipulation
	IF TYPE('cCondition')$ "CM" 
		IF ("<"	 	$ cCondition OR ;
			"==" 	$ cCondition OR ;
			"LIKE" 	$ cCondition OR ;
			"<>" 	$ cCondition OR ;
			"!=" 	$ cCondition OR ;
			"#" 	$ cCondition OR ;
			"=" 	$ cCondition OR ;
			">=" 	$ cCondition OR ;
			"<=" 	$ cCondition OR ;
			">" 	$ cCondition)
		  	lcRetCondition = lcFieldName + cCondition
		ENDIF
	ENDIF
	*!* If a complex condition wasn't found above (lcRetCondition will be empty)
	*!* Then we need to create the WHERE condition ourselves
	IF EMPTY(lcRetCondition)
		*!* The RATC() Functions figure out the column to compare based on the 
		*!* controlSource of the control and any delimiters needed for the 
		*!* datatype are added around the values (not all conditions are
		*!* assumed to be = when we construct them ourselves
		DO CASE
			CASE TYPE(cControlSource) $ "CM"
				lcRetCondition = lcFieldName + " = " + CHR(34) + cCondition + CHR(34)
			CASE TYPE(cControlSource) $ "DT"
				lcRetCondition = lcFieldName + " = {" + DTOC(cCondition) + "}"
			OTHERWISE
				lcRetCondition = lcFieldName + " = " + STR(cCondition)
		ENDCASE	
	ENDIF
ELSE
	lcRetCondition = ""
ENDIF

RETURN lcRetCondition
ENDPROC


************************************************************
OBJETO: cmdQBFMode
************************************************************
*** PROPIEDADES ***
AutoSize = .F.
Top = 3
Left = 4
Height = 23
Width = 72
FontBold = .F.
FontName = "MS Sans Serif"
FontSize = 8
Caption = "\<Enter QBF"
TabIndex = 23
Name = "cmdQBFMode"

*** METODOS ***
PROCEDURE Click

*!* In order to clear out all the controls with a controlSource,
*!* we need to start a transaction and append a record (then when
*!* we are done we'll rollback the transaction so the new record
*!* doesn't get added to the table

IF !EMPTY(THIS.Parent.QBF_table) THEN
	SELECT (THIS.Parent.QBF_table)
ENDIF

BEGIN TRANSACTION

APPEND BLANK

THIS.Enabled = .F.

THIS.Parent.cmdExecuteQBF.Enabled = .T.
THIS.Parent.cmdClearFilter.enabled = .F.

THISFORM.Refresh
ENDPROC


************************************************************
OBJETO: cmdExecuteQBF
************************************************************
*** PROPIEDADES ***
Top = 31
Left = 4
Height = 23
Width = 72
FontBold = .F.
FontName = "MS Sans Serif"
FontSize = 8
Caption = "\<Query"
Enabled = .F.
TabIndex = 24
Name = "cmdExecuteQBF"

*** METODOS ***
PROCEDURE Click
LOCAL cFilter,nCnt,cCondition
cFilter = ""

*!* First, we need to walk all the controls on the form and find
*!* all controls with a controlSource and has a value in the value property.

FOR nCnt = 1 to THISFORM.ControlCount
	IF TYPE('THISFORM.Controls(nCnt).controlSource') <> "U" THEN
		IF !EMPTY(THISFORM.Controls(nCnt).ControlSource) AND ;
		  TYPE('THISFORM.Controls(nCnt).value') <> "U" THEN
		  
		    *!* Now we need to parse the value property into a proper
		    *!* condition using the parseCondition method of the form
			cCondition = THIS.Parent.parseCondition(THISFORM.Controls(nCnt).value,THISFORM.Controls(nCnt).controlSource)
			
			*!* If there is a condition, add it to are overall filter
			IF !EMPTY(cCondition) THEN
				cFilter = cFilter + " AND " + cCondition
			ENDIF
		ENDIF
	ENDIF
ENDFOR

*!* We need to rollback the transaction to discard the APPEND'ed record
ROLLBACK

THIS.Enabled = .F.
THIS.Parent.cmdQBFMode.Enabled = .T.

*!* This removes the " AND " keyword that is not needed for the 
*!* first condition added to cFilter
IF !EMPTY(cFilter) THEN
	cFilter = ALLTRIM(SUBSTRC(cFilter,5))
ENDIF

*!* Now we are ready to apply the filter
SET FILTER TO &cFilter

THIS.Parent.cmdClearFilter.enabled = .T.

GO TOP
THISFORM.Refresh
ENDPROC


************************************************************
OBJETO: cmdClearFilter
************************************************************
*** PROPIEDADES ***
AutoSize = .F.
Top = 71
Left = 4
Height = 23
Width = 72
FontBold = .F.
FontName = "MS Sans Serif"
FontSize = 8
Caption = "\<Clear Filter"
Enabled = .F.
TabIndex = 25
Name = "cmdClearFilter"

*** METODOS ***
PROCEDURE Click

*!* Clear the filter that was set
SET FILTER TO
GO TOP
THIS.enabled = .F.

THISFORM.Refresh
ENDPROC


************************************************************
OBJETO: _qbf
************************************************************
*** PROPIEDADES ***
MS Sans Serif, 0, 8, 5, 13, 11, 11, 2, 0

*** METODOS ***


************************************************************
OBJETO: _cbodistinctvalues
************************************************************
*** PROPIEDADES ***
FontName = "MS Sans Serif"
FontSize = 8
Height = 23
Width = 175
Name = "_cbodistinctvalues"

*** METODOS ***
PROCEDURE Destroy
LOCAL cCursor

cCursor = "c" + THIS.name
IF USED(m.cCursor) THEN
	USE IN &cCursor
ENDIF

ENDPROC
PROCEDURE Init
LOCAL cSQL, cAlias, cColumn

IF !EMPTY(THIS.controlSource) THEN
	IF NOT "." $ THIS.controlSource THEN
		=MESSAGEBOX(NO_TABLE_LOC)
	ELSE
		cAlias = LEFTC(THIS.controlSource,(ATC(".",THIS.controlSource)-1))
		cColumn = RIGHTC(THIS.controlSource,(LENC(THIS.controlSource)-ATC(".",THIS.controlSource)))
		IF INLIST(TYPE(m.cAlias+"."+m.cColumn),"D","T","M","G","L")
			RETURN
		ENDIF
		THIS.rowSourceType = 3
		cSQL = "SELECT DISTINCT " + m.cColumn + " FROM " + m.cAlias + ;
		  " INTO CURSOR c" + THIS.name
		THIS.rowSource = m.cSQL
	ENDIF
ENDIF

ENDPROC


************************************************************
OBJETO: _cbodistinctvalues
************************************************************
*** PROPIEDADES ***
MS Sans Serif, 0, 8, 5, 13, 11, 11, 2, 0

*** METODOS ***


************************************************************
OBJETO: _execsp
************************************************************
*** PROPIEDADES ***
Height = 19
Width = 97
Name = "_execsp"

*** METODOS ***
PROCEDURE dosql
LOCAL nError
nError = SQLEXEC (this.hConnectHandle, this.cSQL, this.cCursorName)
IF nError < 0
	this.ProcessError
ENDIF

ENDPROC
PROCEDURE setsql
IF THIS.lUseSQLSyntax
	THIS.cSQL = "exec " + this.cSPName	+" " +this.SetParams() &&SQL Server specific
ELSE
	THIS.cSQL = "{call " + this.cSPName + "("+this.SetParams()+ ")}"
ENDIF

ENDPROC
PROCEDURE setparams
LOCAL nArrayCount,cParms
cParms=""
FOR nArrayCount = 1 TO ALEN (this.aParams)
	cParms = cParms + this.aParams[nArrayCount]
	IF nArrayCount <> ALEN (this.aParams)
		cParms= cParms + ','
	ENDIF
ENDFOR
RETURN cParms
ENDPROC
PROCEDURE processerror
LOCAL cMessageText
DIMENSION aSQLError[5]

=AERROR (aSQLError)
cMessageText = aSQLError[1,2]
=MESSAGEBOX (cMessageText)

ENDPROC
PROCEDURE getsql
RETURN this.cSQL

ENDPROC
PROCEDURE Init
* This class library is used for SQL Pass Thru and can allow you to execute stored procedures
* on your host database. For example, the sample belows shows how you might want to called a stored
* procedure called "UpdateAuthorName" on the database "pubs". The result set is returned to a cursor.

*	Sample code
*!*	sqldisconn(0)
*!*	DIME aParams[3]
*!*	aParams[1] = "'172-32-1176'"
*!*	aParams[2] = "'S'"
*!*	aParams[3] = "'E'"
*!*	hConnect = SQLCONNECT ('pubs','sa','')
*!*	set classlib to HOME()+"classes\utility.vcx"
*!*	x=createobj('ExecSP', 'UpdateAuthorName', hConnect, @aParams)
*!*	x.dosql()

PARAMETERS cSPName, hConnectHandle, aParams, cCursorName

IF PCOUNT() < 3
	MESSAGEBOX(BADPARMS_LOC)
	RETURN .F.
ENDIF

DIMENSION this.aParams[1]
ACOPY(aParams,this.aParams)

IF NOT EMPTY (m.cSPName)
	this.cSPName = m.cSPName
ENDIF

this.hConnectHandle = m.hConnectHandle

IF PCOUNT() = 3
	this.cCursorName = 'sqlresult'
ELSE
	this.cCursorName = m.cCursorName
ENDIF

this.SetSQL()

ENDPROC


************************************************************
OBJETO: _conflicts
************************************************************
*** PROPIEDADES ***
Height = 183
Width = 490
DoCreate = .T.
AutoCenter = .T.
Caption = "Resolve Conflicts"
MaxButton = .F.
MinButton = .F.
WindowType = 1
AlwaysOnTop = .T.
conflictalias = 
cursoralias = 
lautocheck = .T.
Name = "_conflicts"

*** METODOS ***
PROCEDURE nextconflict
LPARAMETERS lnStartRow

LOCAL lnRow, lcUserField, lnBuffering, nCursorType, lnFields, i 

IF EMPTY(THIS.CursorAlias)
	THIS.Alert(CS_NOALIAS_LOC)
	THISFORM.release()
	RETURN .F.
ENDIF

SELECT (THIS.CursorAlias)

* default start row is current row
IF PCOUNT() = 0
	lnStartRow = RECNO()
ENDIF

* close form after single row conflicts
lnBuffering = CURSORGETPROP('Buffering')
IF lnBuffering = 1
	THIS.Alert(CS_NOBUFFER_LOC)
	THISFORM.release()
	RETURN .F.
ENDIF

IF lnBuffering<4 AND lnStartRow#0
	THISFORM.release()
	RETURN .F.
ENDIF

nCursorType = CURSORGETPROP("SourceType",THIS.CursorAlias)

IF lnBuffering>3
	* for table buffering move to next row
	lnRow = GETNEXTMODIFIED(lnStartRow,THIS.CursorAlias)
	IF lnRow # 0
		GO lnRow IN (THIS.CursorAlias)
	ENDIF
ELSE
	* handle row buffering
	lnFields = GETFLDSTATE(-1)
	IF REPLICATE("1",LEN(lnFields))#TRANS(lnFields)
		lnRow = RECNO()
	ELSE
		lnRow = 0	
	ENDIF
ENDIF

THIS.lblConflicts.caption = CS_ROWCONFLICT_LOC + LTRIM(STR(lnRow,10 , 0))
IF lnRow = 0
	THIS.Alert(IIF(m.lnStartRow=0,CS_NOCONFLICTS1_LOC,CS_NOCONFLICTS_LOC))
	THISFORM.Release()
	RETURN .F.
ENDIF

* load original values
SELECT (THIS.ConflictAlias)
GO TOP
FOR m.i = 1 TO ALEN(THIS.aConflicts, 1)
	REPLACE (THIS.aConflicts[m.i,1]) WITH OLDVAL(THIS.aConflicts[m.i,1], THIS.CursorAlias)
ENDFOR

* load current values
* add error code here

IF m.nCursorType # 3	&& refresh if not a table
	REFRESH(1, 0, THIS.CursorAlias)
ENDIF

SKIP
FOR m.i = 1 TO ALEN(THIS.aConflicts, 1)
	REPLACE (THIS.aConflicts[m.i,1]) WITH CURVAL(THIS.aConflicts[m.i,1], THIS.CursorAlias)
ENDFOR

* load user values
SKIP
FOR m.i = 1 TO ALEN(THIS.aConflicts, 1)
	lcUserField = THIS.CursorAlias + '.' + THIS.aConflicts[m.i,1]
	REPLACE (THIS.aConflicts[m.i,1]) WITH EVALUATE(lcUserField)
ENDFOR

GO TOP
THIS.grdConflicts.Refresh

SELECT (THIS.CursorAlias)

ENDPROC
PROCEDURE startcheck
LOCAL aTmpConflicts

IF !EMPTY(ALIAS()) AND EMPTY(THIS.CursorAlias)
	THIS.CursorAlias = ALIAS()
ENDIF

IF EMPTY(THIS.CursorAlias)
	THIS.Alert(CS_NOALIAS_LOC)
	RETURN .F.
ENDIF

DIMENSION aTmpConflicts[1]
DIMENSION THIS.aConflicts[1]
AFIELDS(aTmpConflicts)
ACOPY(aTmpConflicts,THIS.aConflicts)

SELECT 0
CREATE CURSOR _conflicts FROM ARRAY aTmpConflicts
THIS.ConflictAlias = ALIAS()

* append conflict records
APPEND BLANK
APPEND BLANK
APPEND BLANK

THIS.grdConflicts.RecordSource = THIS.ConflictAlias
THIS.grdConflicts.Visible = .T.

* move on first conflict
IF THIS.NextConflict(0)
	THISFORM.Visible = .T.
ELSE
	RETURN .F.
ENDIF

ENDPROC
PROCEDURE alert
LPARAMETERS cMessage
WAIT WINDOW m.cMessage TIMEOUT 2

ENDPROC
PROCEDURE QueryUnload
thisform.RELEASE()
ENDPROC
PROCEDURE Init
IF !EMPTY(ALIAS()) AND EMPTY(THIS.CursorAlias)
	THIS.CursorAlias = ALIAS()
ENDIF
IF THIS.lAutoCheck
	IF !THIS.StartCheck()
		RETURN .F.
	ENDIF
ENDIF
ENDPROC
PROCEDURE Release
IF !EMPTY(THISFORM.ConflictAlias) AND USED(THISFORM.ConflictAlias)
	SELECT (THISFORM.ConflictAlias)
	USE
ENDIF

IF !EMPTY(THISFORM.CursorAlias) AND USED(THISFORM.CursorAlias)
	SELECT (THISFORM.CursorAlias)
ENDIF

ENDPROC


************************************************************
OBJETO: grdConflicts
************************************************************
*** PROPIEDADES ***
ColumnCount = -1
Height = 90
Highlight = .F.
HighlightRow = .F.
Left = 108
ReadOnly = .T.
RecordSource = ""
ScrollBars = 1
Top = 48
Visible = .F.
Width = 370
Name = "grdConflicts"

*** METODOS ***


************************************************************
OBJETO: cmdUpdate
************************************************************
*** PROPIEDADES ***
Top = 149
Left = 190
Height = 23
Width = 72
Caption = "\<Update"
Name = "cmdUpdate"

*** METODOS ***
PROCEDURE Click
IF EMPTY(THISFORM.CursorAlias)
	WAIT WINDOW CS_NOALIAS_LOC TIMEOUT 2
	RETURN .F.
ENDIF

LOCAL llUpdate

* force-update current row
llUpdate = TABLEUPDATE(.F., .T.)

THISFORM.CheckSource()

* Display whether update was successful or failed (e.g., primary key changed)
IF m.llUpdate
	THISFORM.Alert(WAIT_UPDATEOK_LOC)
ELSE
	THISFORM.Alert(WAIT_UPDATEFAIL1_LOC)
ENDIF

THISFORM.NextConflict

ENDPROC


************************************************************
OBJETO: cmdRevert
************************************************************
*** PROPIEDADES ***
Top = 149
Left = 262
Height = 23
Width = 72
Caption = "\<Revert"
Name = "cmdRevert"

*** METODOS ***
PROCEDURE Click
IF EMPTY(THISFORM.CursorAlias)
	WAIT WINDOW CS_NOALIAS_LOC TIMEOUT 2
	RETURN .F.
ENDIF

LOCAL lnRows 

lnRows = TABLEREVERT(.F.)
THISFORM.CheckSource()

* no conflicts, no row or one row reverted
THISFORM.Alert( IIF(lnRows = 0,WAIT_REVERTFAIL_LOC,WAIT_REVERT1_LOC))
THISFORM.NextConflict()

ENDPROC


************************************************************
OBJETO: cmdClose
************************************************************
*** PROPIEDADES ***
Top = 149
Left = 406
Height = 23
Width = 72
Caption = "\<Close"
Name = "cmdClose"

*** METODOS ***
PROCEDURE Click
THISFORM.release()

ENDPROC


************************************************************
OBJETO: Label1
************************************************************
*** PROPIEDADES ***
Caption = "Old value"
Height = 15
Left = 8
Top = 68
Width = 96
Name = "Label1"

*** METODOS ***


************************************************************
OBJETO: Label2
************************************************************
*** PROPIEDADES ***
Caption = "Current value"
Height = 15
Left = 8
Top = 88
Width = 96
Name = "Label2"

*** METODOS ***


************************************************************
OBJETO: Label3
************************************************************
*** PROPIEDADES ***
Caption = "New value"
Height = 15
Left = 8
Top = 108
Width = 84
Name = "Label3"

*** METODOS ***


************************************************************
OBJETO: cmdSkip
************************************************************
*** PROPIEDADES ***
Top = 149
Left = 334
Height = 23
Width = 72
Caption = "\<Ignore"
Name = "cmdSkip"

*** METODOS ***
PROCEDURE Click
THISFORM.NextConflict

ENDPROC


************************************************************
OBJETO: lblConflicts
************************************************************
*** PROPIEDADES ***
Caption = "Conflicts on row:"
Height = 17
Left = 8
Top = 17
Width = 158
Name = "lblConflicts"

*** METODOS ***


************************************************************
OBJETO: _conflicts
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: _offline
************************************************************
*** PROPIEDADES ***
Width = 119
Height = 64
BackStyle = 0
BorderWidth = 0
lrevertonfail = .T.
lupdateviews = .T.
lusecurrentdbc = .T.
Name = "_offline"

*** METODOS ***
PROCEDURE gooffline
LOCAL i,j

IF !EMPTY(THIS.cDatabase) AND (SET("DATABASE") # THIS.cDatabase)
	SET DATABASE TO (THIS.cDatabase)
ENDIF

IF EMPTY(THIS.cViews[1])
	THIS.Alert(C_NOVIEWS_LOC)
	RETURN .F.
ENDIF

FOR i = 1 TO ALEN(THIS.cViews)
	* Check if already offline
	IF DBGETPROP(THIS.cViews[m.i],"VIEW","OFFLINE")
		LOOP
	ENDIF
	IF !CREATEOFFLINE(THIS.cViews[m.i])
		THIS.Alert(C_FAILOFFLINE_LOC+THIS.cViews[m.i])
		IF THIS.lRevertOnFail
			FOR j = 1 TO i-1
				DROPOFFLINE(THIS.cViews[m.i])
			ENDFOR
			THIS.ogOffline.value = 1
			RETURN .F.
		ENDIF
	ENDIF
ENDFOR

THIS.Alert(C_OKOFFLINE_LOC)

ENDPROC
PROCEDURE goonline
LOCAL lUpdateSuccess,lDropSuccess,aUpdateErrors[1],i,lAbort,lAlreadyUsed,nSaveArea

lAbort = .F.

DIMENSION THIS.aUpdateErrors[1]
THIS.aUpdateErrors[1] = 0

IF !EMPTY(THIS.cDatabase) AND (SET("DATABASE") # THIS.cDatabase)
	SET DATABASE TO (THIS.cDatabase)
ENDIF

IF EMPTY(THIS.cViews[1])
	THIS.Alert(C_NOVIEWS_LOC)
	RETURN
ENDIF

nSaveArea = SELECT()
FOR i = 1 TO ALEN(THIS.cViews)
	* Check if already online
	IF !DBGETPROP(THIS.cViews[m.i],"VIEW","OFFLINE")
		LOOP
	ENDIF
	IF THIS.lUpdateViews
		lAlreadyUsed = USED(THIS.cViews[m.i])
		IF m.lAlreadyUsed 
			SELECT (THIS.cViews[m.i])
		ELSE
			SELECT 0
		ENDIF
		USE (THIS.cViews[m.i]) ONLINE EXCLUSIVE
		IF EMPTY(ALIAS())
			* Failed to open exclusively
			MESSAGEBOX(C_NOOPEN_LOC+THIS.cViews[m.i])
			lAbort = .T.
			EXIT
		ENDIF
		lUpdateSuccess = TableUpdate(2,aUpdateErrors)
		USE IN (THIS.cViews[m.i])
		IF !m.lUpdateSuccess
			ACOPY(aUpdateErrors,THIS.aUpdateErrors)
			MESSAGEBOX(C_RECORDCONLICT_LOC+THIS.cViews[m.i])
			lAbort = .T.
			EXIT
		ENDIF
	ENDIF
	lDropSuccess = DROPOFFLINE(THIS.cViews[m.i])
	IF m.lAlreadyUsed
		USE (THIS.cViews[m.i])
	ENDIF
	IF !m.lDropSuccess
		MESSAGEBOX(C_FAILONLINE_LOC+THIS.cViews[m.i])
		lAbort = .T.
		EXIT
	ENDIF
ENDFOR

IF m.lAbort
	THIS.ogOffline.value = 2
ELSE
	THIS.Alert(C_OKONLINE_LOC)
ENDIF
SELECT (m.nSaveArea)

ENDPROC
PROCEDURE checkoffline
LOCAL lOffline,i

IF !EMPTY(THIS.cDatabase) AND (SET("DATABASE") # THIS.cDatabase)
	SET DATABASE TO (THIS.cDatabase)
ENDIF

IF EMPTY(THIS.cDatabase) OR EMPTY(THIS.cViews[1])
	*THIS.Alert(C_NODATABASE_LOC)
	THIS.ogOffline.Option1.Enabled = .F.
	THIS.ogOffline.Option2.Enabled = .F.
	RETURN 
ENDIF

THIS.ogOffline.Option1.Enabled = .T.
THIS.ogOffline.Option2.Enabled = .T.

FOR i = 1 TO ALEN(THIS.cViews)
	lOffline = DBGETPROP(THIS.cViews[m.i],"VIEW","OFFLINE")
	IF !lOffline
		EXIT
	ENDIF
ENDFOR

THIS.ogOffline.value = IIF(m.lOffline,2,1)

ENDPROC
PROCEDURE alert
LPARAMETER cMessage
WAIT WINDOW m.cMessage TIMEOUT 2
ENDPROC
PROCEDURE setviews
* Abstract class to setup THIS.cViews array and THIS.cDatabase (optional)
IF THIS.lAllViews
	LOCAL aTmpViews,nTotViews
	DIMENSION aTmpViews[1]
	IF !EMPTY(THIS.cDatabase) AND (SET("DATABASE")#THIS.cDatabase)
		SET DATABASE TO (THIS.cDatabase)
	ENDIF
	nTotViews = ADBOBJECT(aTmpViews,"VIEW")
	IF nTotViews>0
		DIMENSION THIS.cViews[1]
		ACOPY(aTmpViews,THIS.cViews)
	ENDIF
ENDIF

ENDPROC
PROCEDURE Init
IF THIS.lUseCurrentDBC AND EMPTY(THIS.cDatabase)
	THIS.cDatabase = SET("DATABASE")
ENDIF
THIS.SetViews()
THIS.CheckOffline()

ENDPROC


************************************************************
OBJETO: ogOffline
************************************************************
*** PROPIEDADES ***
AutoSize = .F.
ButtonCount = 2
BorderStyle = 0
Value = 1
Height = 62
Top = 3
Width = 122
Name = "ogOffline"
Option1.Picture = graphics\online.ico
Option1.Caption = "Online"
Option1.Value = 1
Option1.Height = 59
Option1.Left = 5
Option1.Style = 1
Option1.Top = 0
Option1.Width = 55
Option1.Name = "Option1"
Option2.Picture = graphics\offline.ico
Option2.Caption = "Offline"
Option2.Height = 59
Option2.Left = 64
Option2.Style = 1
Option2.Top = 0
Option2.Width = 55
Option2.Name = "Option2"

*** METODOS ***
PROCEDURE Option1.Click
THIS.Parent.Parent.GoOnline()
ENDPROC
PROCEDURE Option2.Click
THIS.Parent.Parent.GoOffline()
ENDPROC


************************************************************
OBJETO: _offline
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


