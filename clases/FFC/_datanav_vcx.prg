************************************************************
OBJETO: _cmdbottom
************************************************************
*** PROPIEDADES ***
Height = 24
Width = 29
Picture = graphics\bottom.bmp
ToolTipText = "Bottom"
Name = "vcrbottom"

*** METODOS ***
PROCEDURE Click
IF NOT this.SetSession()
	RETURN .F.
ENDIF
GO BOTTOM
this.RefreshForm()
RETURN

ENDPROC


************************************************************
OBJETO: _cmdbottom
************************************************************
*** PROPIEDADES ***
Arial, 0, 10, 6, 16, 13, 14, 3, 0

*** METODOS ***


************************************************************
OBJETO: _cmdnext
************************************************************
*** PROPIEDADES ***
Height = 24
Width = 29
Picture = graphics\next.bmp
ToolTipText = "Next"
Name = "_cmdnext"

*** METODOS ***
PROCEDURE Click
IF NOT this.SetSession()
	RETURN .F.
ENDIF
IF NOT EOF()
	SKIP
ENDIF
IF EOF()
	SKIP -1
ENDIF
this.RefreshForm()
RETURN

ENDPROC


************************************************************
OBJETO: _cmdnext
************************************************************
*** PROPIEDADES ***
Arial, 0, 10, 6, 16, 13, 14, 3, 0

*** METODOS ***


************************************************************
OBJETO: _cmdprevious
************************************************************
*** PROPIEDADES ***
Height = 24
Width = 29
Picture = graphics\previous.bmp
ToolTipText = "Previous"
Name = "_cmdprevious"

*** METODOS ***
PROCEDURE Click
IF NOT this.SetSession()
	RETURN .F.
ENDIF
IF NOT BOF()
	SKIP -1
ENDIF
this.RefreshForm()
RETURN

ENDPROC


************************************************************
OBJETO: _cmdprevious
************************************************************
*** PROPIEDADES ***
Arial, 0, 10, 6, 16, 13, 14, 3, 0

*** METODOS ***


************************************************************
OBJETO: _cmdtop
************************************************************
*** PROPIEDADES ***
Height = 24
Width = 29
Picture = graphics\top.bmp
Caption = ""
TabIndex = 1
ToolTipText = "Top"
Name = "_cmdtop"

*** METODOS ***
PROCEDURE Click
IF NOT this.SetSession()
	RETURN .F.
ENDIF
GO TOP
this.RefreshForm()
RETURN

ENDPROC


************************************************************
OBJETO: _cmdtop
************************************************************
*** PROPIEDADES ***
Arial, 0, 10, 6, 16, 13, 14, 3, 0

*** METODOS ***


************************************************************
OBJETO: _basicnavbtns
************************************************************
*** PROPIEDADES ***
Width = 48
Height = 25
Name = "_basicnavbtns"

*** METODOS ***
PROCEDURE setdefault
LPARAMETERS oBtn
oBtn.LastSelect=this.LastSelect
oBtn.TableAlias=this.TableAlias
oBtn.ManyAlias=this.ManyAlias
oBtn.ManyKey=this.ManyKey

ENDPROC
PROCEDURE Init
this.SetDefault(this.VCRPrevious)
this.SetDefault(this.VCRNext)
IF TYPE('thisform')=='O'
	thisform.ShowTips=.T.
ENDIF

ENDPROC


************************************************************
OBJETO: Vcrprevious
************************************************************
*** PROPIEDADES ***
Top = 0
Left = 0
Height = 24
Width = 24
Picture = graphics\previous.bmp
Name = "Vcrprevious"

*** METODOS ***


************************************************************
OBJETO: Vcrnext
************************************************************
*** PROPIEDADES ***
Top = 0
Left = 24
Height = 24
Width = 24
Picture = graphics\next.bmp
Name = "Vcrnext"

*** METODOS ***


************************************************************
OBJETO: _basicnavbtns
************************************************************
*** PROPIEDADES ***
Arial, 0, 10, 6, 16, 13, 23, 3, 0

*** METODOS ***


************************************************************
OBJETO: _navbtns
************************************************************
*** PROPIEDADES ***
Width = 97
Height = 25
BackStyle = 0
BorderWidth = 0
lastselect = 1
tablealias = 
manyalias = 
manykey = 
builder = vcrtlbrb.scx
Name = "_navbtns"

*** METODOS ***
PROCEDURE setdefault
LPARAMETERS oBtn
oBtn.LastSelect=this.LastSelect
oBtn.TableAlias=this.TableAlias
oBtn.ManyAlias=this.ManyAlias
oBtn.ManyKey=this.ManyKey
ENDPROC
PROCEDURE Init
this.SetDefault(this.VCRTop)
this.SetDefault(this.VCRPrevious)
this.SetDefault(this.VCRNext)
this.SetDefault(this.VCRBottom)
IF TYPE('thisform')=='O'
	thisform.ShowTips=.T.
ENDIF


ENDPROC


************************************************************
OBJETO: Vcrtop
************************************************************
*** PROPIEDADES ***
Top = 0
Left = 0
Height = 24
Width = 24
Picture = graphics\top.bmp
Name = "Vcrtop"

*** METODOS ***


************************************************************
OBJETO: Vcrprevious
************************************************************
*** PROPIEDADES ***
Top = 0
Left = 24
Height = 24
Width = 24
Picture = graphics\previous.bmp
Name = "Vcrprevious"

*** METODOS ***


************************************************************
OBJETO: Vcrnext
************************************************************
*** PROPIEDADES ***
Top = 0
Left = 48
Height = 24
Width = 24
Picture = graphics\next.bmp
Name = "Vcrnext"

*** METODOS ***


************************************************************
OBJETO: Vcrbottom
************************************************************
*** PROPIEDADES ***
Top = 0
Left = 72
Height = 24
Width = 24
Picture = graphics\bottom.bmp
Name = "Vcrbottom"

*** METODOS ***


************************************************************
OBJETO: _navbtns
************************************************************
*** PROPIEDADES ***
Arial, 0, 10, 6, 16, 13, 23, 3, 0

*** METODOS ***


************************************************************
OBJETO: _cmdnavbtn
************************************************************
*** PROPIEDADES ***
Height = 24
Width = 29
FontSize = 10
Caption = ""
ForeColor = 0,0,0
tablealias = 
manyalias = 
manykey = 
lastselect = 1
Name = "_cmdnavbtn"

*** METODOS ***
PROCEDURE refreshform
IF NOT EMPTY(this.ManyAlias) AND NOT EMPTY(this.ManyKey)
	THIS.UpdateMany()	&&special handling for 1-Many side if needed.
ENDIF
DO CASE
	CASE TYPE('thisformset')=='O'
		thisformset.Refresh()
	CASE TYPE('_screen.ActiveForm')=='O'
		_screen.ActiveForm.Refresh()
ENDCASE
SELECT (this.LastSelect)
RETURN

ENDPROC
PROCEDURE setsession
IF TYPE('_screen.ActiveForm')#'O'
	RETURN .F.
ENDIF
IF NOT TYPE('thisformset')=='O'
	***	SET SESSION TO (_screen.ActiveForm.DataSessionID)
ENDIF
this.LastSelect=SELECT()
IF NOT EMPTY(this.TableAlias)
	IF NOT USED(this.TableAlias)
		RETURN .F.
	ENDIF
	SELECT (this.TableAlias)
ENDIF
IF NOT USED()
	RETURN .F.
ENDIF

ENDPROC


************************************************************
OBJETO: _cmdnavbtn
************************************************************
*** PROPIEDADES ***
Arial, 0, 10, 6, 16, 13, 23, 3, 0

*** METODOS ***


************************************************************
OBJETO: _datachecker
************************************************************
*** PROPIEDADES ***
Height = 15
Width = 23
Name = "_datachecker"

*** METODOS ***
PROCEDURE handlerecord
*---------------------------------------------------------------*
*  This method is called from the CheckConflicts method and the 
*  VerifyEachChange method.  It loops through each field in the
*  current record and compares the current value with the value
*  stored in the table. If a value of 1 is passed to this method,
*  the method also compares the current value with the value in
*  the field before user made any edits.
*
*  RETURNS NUMERIC VALUES:
*    0 -- No Change Made to the Current Value
*    1 -- Successfully Made User-Specified Change
*	 2 -- Unable to Make User-Specifed Change
*---------------------------------------------------------------*

LPARAMETERS lnScope

*--Valid values for lnScope:
* 	0 - Only manage conflicts   && default
*   1 - Also prompt for changed values

* Verify parameter
IF TYPE("m.lnScope") != "N"
	m.lnScope = 0 
ENDIF
IF !BETWEEN(m.lnScope, 0, 1)
	WAIT WINDOW WINDMSG_LOC
ENDIF

LOCAL lnChoice, lnField, lcField, luOldVal, luCurVal, luField, llMadeChange, llSuccess
m.llMadeChange = .F.
m.llSuccess = .T.

* refresh current record in views before checking for conflicts
IF CURSORGETPROP('SourceType') != 3 && not a local table
	=REFRESH()
ENDIF

* Check each field in the record for conflict or value change
FOR m.lnField = 1 to FCOUNT()
	m.lnChoice = 0
	
	m.lcField = FIELD(m.lnField)
	IF TYPE(m.lcField) = "G"
		LOOP && Can't check general fields
	ENDIF
	m.luOldVal = OLDVAL(m.lcField)
	m.luCurVal = CURVAL(m.lcField)
	
	DO CASE
		* -----< check for conflicts only >--------
		CASE m.lnScope = 0
			IF m.luOldVal != m.luCurVal
				m.llMadeChange = .T.  
				m.lnChoice = MESSAGEBOX(VALCHG1_LOC + CR_LOC + FIELD_LOC + lcField + CR_LOC + ;
				RECORD_LOC + ALLTRIM(STR(RECNO())) + ;
					IIF(TYPE("m.lcField") != "M", CR_LOC + CR_LOC + ORG_LOC + THIS.String(m.luOldVal) + ;
					CR_LOC + CUR_LOC + THIS.String(m.luCurVal) + ;
					CR_LOC + CHG_LOC + THIS.String(EVAL(m.lcField)), CR_LOC + CR_LOC + m.lcField + MEMO_LOC) + ;
					CR_LOC + CR_LOC + SAVE_LOC, + 3+48+0, CONFLICT_LOC)					
			ENDIF
		* -----< check for conflicts and verify all changes >--------
		CASE m.lnScope = 1 && Verify all changes
			m.luField = EVAL(m.lcField)
			IF m.luOldVal != m.luField OR m.luCurVal != m.luField
				m.llMadeChange = .T.  
				m.lnChoice = MESSAGEBOX(VALCHG2_LOC + CR_LOC + FIELD_LOC + m.lcField + CR_LOC + ;
				RECORD_LOC + ALLTRIM(STR(RECNO())) + ;
					IIF(TYPE("m.lcField") != "M", CR_LOC + CR_LOC + ORG_LOC + THIS.String(m.luOldVal) + ;
					CR_LOC + CUR_LOC + THIS.String(m.luCurVal) + ;
					CR_LOC + CHG_LOC + THIS.String(EVAL(m.lcField)), CR_LOC  + CR_LOC + m.lcField + MEMO_LOC) + ;
				CR_LOC + CR_LOC + SAVE_LOC, + 3+48+0, VERIFY_LOC)
			ENDIF
	ENDCASE
	DO CASE
	CASE m.lnChoice = 7 && No, don't save changes
		REPLACE (m.lcField) WITH m.luCurVal
	CASE m.lnChoice = 2 && Cancel, restore original value
		REPLACE (m.lcField) WITH m.luOldVal
	ENDCASE
ENDFOR
IF m.llMadeChange
	m.llSuccess = TABLEUPDATE(.F., .T.)
	RETURN IIF(m.llSuccess, 1, 2)
ELSE
	RETURN 0 
ENDIF

ENDPROC
PROCEDURE string
*---------------------------------------------------------------*
*  This method is called from the HandleRecord method.  It 
*  returns the character equivalent of the value passed in as a
*  parameter.  If a memo field is passed in, a notice to this
*  effect is returned rather than the value in the memo field so
*  that potentially large amounts of text aren't displayed in the 
*  messagebox.
*---------------------------------------------------------------*

LPARAMETERS luValue
LOCAL uType

m.uType = TYPE('m.luValue')
DO CASE
	CASE m.uType = 'C'
		RETURN ALLTRIM(m.luValue)
	CASE INLIST(m.uType, 'N', 'Y')
		RETURN ALLTRIM(STR(m.luValue))
	CASE m.uType = 'D'
		RETURN DTOC(m.luValue)
	CASE m.uType = 'T'
		RETURN TTOC('m.luValue')
	CASE m.uType = 'L'
		RETURN IIF(m.luValue, '.T.', '.F.')
	CASE uType = 'M'
		RETURN 'Memo field'
ENDCASE
ENDPROC
PROCEDURE verifychanges
*---------------------------------------------------------------*
*  If any changes have been made to the table or record, prompt the
*  user to save the changes.  If the user says 'yes,' all changes
*  are saved.  Any changes made to the data by other users after
*  this user made the change and before the change was committed
*  will be lost.
*
*  RETURNS NUMERIC VALUES:
*    0 -- No Changes Made to the Current Values
*    1 -- Successfully Made All User Changes
*	 2 -- Unable to Write One or More User-Specifed Changes to Table
*---------------------------------------------------------------*

LOCAL lnChoice, llMadeChange, lnSuccess
m.llMadeChange = .F.
m.lnSuccess = 0

* If the user has changed anything, prompt to save or discard changes
DO CASE
	CASE INLIST(CURSORGETPROP('Buffering'), 2,3) && Row Buffering
		IF '2' $ GETFLDSTATE(-1)
			m.llMadeChange = .T.
		ENDIF
	CASE INLIST(CURSORGETPROP('Buffering'), 4,5) && Table Buffering
		IF GETNEXTMODIFIED(0) > 0
			m.llMadeChange = .T.
		ENDIF
	OTHERWISE
		WAIT WINDOW NOBUFF_LOC NOWAIT
ENDCASE

IF m.llMadeChange
	m.lnChoice = MESSAGEBOX(SAVECHG_LOC, 4+32, SAVECHG2_LOC)
	IF m.lnChoice = 6 && Yes
		m.lnSuccess = IIF(TABLEUPDATE(.T.,.T.), 1, 2)
	ELSE
		=TABLEREVERT(.T.)
	ENDIF
ENDIF	
RETURN m.lnSuccess
ENDPROC
PROCEDURE verifyeachchange
*--------------------------------------------------------------------
*  If any changes have been made to the table or record, for each
*  change, display the old value and the new value, prompting the
*  user to save or discard the change.  Conflict management is also
*  included in the HandleRecord method.
*
*  RETURNS NUMERIC VALUES:
*    0 -- No Changes Made to the Current Values
*    1 -- Successfully Made User-Specified Changes
*	 2 -- Unable to Write One or More User-Specifed Changes to Table
*---------------------------------------------------------------*

LOCAL lnSuccess, lnRec
m.lnSuccess = 0

DO CASE
	CASE INLIST(CURSORGETPROP('Buffering'), 2,3) && Row Buffering
		IF '2' $ GETFLDSTATE(-1)				 && Data has changed
			m.lnSuccess = THIS.HandleRecord(1)
		ENDIF	
	CASE INLIST(CURSORGETPROP('Buffering'), 4,5) && Table Buffering
		m.lnRec = GETNEXTMODIFIED(0)
		DO WHILE m.lnRec > 0
			GO m.lnRec
			m.lnSuccess = IIF(m.lnSuccess != 2, THIS.HandleRecord(1), 2)
			m.lnRec = GETNEXTMODIFIED(m.lnRec)	
		ENDDO
	OTHERWISE									 && No Buffering
		WAIT WINDOW NOBUFF_LOC NOWAIT
ENDCASE
RETURN m.lnSuccess
ENDPROC
PROCEDURE checkconflicts
*---------------------------------------------------------------*
*  Checks to see whether another user has changed the value 
*  stored in a table.  If so, calls HandleRecord to display
*  the new value and allow the user to decide what to do.
*
*  RETURNS NUMERIC VALUES:
*    0 -- No Changes Made to the Current Values
*    1 -- Successfully Made User-Specified Changes
*	 2 -- Unable to Make Write One or More User-Specifed Changes to Table
*---------------------------------------------------------------*

LOCAL lnSuccess, llnRec
m.lnSuccess = 0  

DO CASE
	CASE INLIST(CURSORGETPROP('Buffering'), 2,3) && Row Buffering
		IF '2' $ GETFLDSTATE(-1)				 && Data has changed
			m.lnSuccess = THIS.HandleRecord(0)
		ENDIF	
	CASE INLIST(CURSORGETPROP('Buffering'), 4,5) && Table Buffering
		m.llnRec = GETNEXTMODIFIED(0)
		DO WHILE m.llnRec > 0
			GO m.llnRec
			m.lnSuccess = IIF(m.lnSuccess != 2, THIS.HandleRecord(0), 2)
			m.llnRec = GETNEXTMODIFIED(m.llnRec)	
		ENDDO
	OTHERWISE									 && no buffering
		WAIT WINDOW NOBUFF_LOC NOWAIT
ENDCASE
RETURN m.lnSuccess
ENDPROC


************************************************************
OBJETO: _datanavbtns
************************************************************
*** PROPIEDADES ***
Width = 104
Height = 24
BorderWidth = 1
BackColor = 192,192,192
skiptable = 
enabledisableoninit = .T.
Name = "_datanavbtns"

*** METODOS ***
PROCEDURE recordpointermoved
IF TYPE('_VFP.ActiveForm') = 'O'
	_VFP.ActiveForm.Refresh
ENDIF

ENDPROC
PROCEDURE enabledisablebuttons
LOCAL nRec, nTop, nBottom
IF EMPTY(ALIAS()) OR EOF() && Table empty or no records match a filter
	THIS.SetAll("Enabled", .F.)
	RETURN
ENDIF

nRec = RECNO()
GO TOP
nTop = RECNO()
GO BOTTOM
nBottom = RECNO()
GO nRec

DO CASE
	CASE nRec = nTop
		THIS.cmdTop.Enabled = .F.
		THIS.cmdPrior.Enabled = .F.
		THIS.cmdNext.Enabled = .T.
		THIS.cmdBottom.Enabled = .T.
	CASE nRec = nBottom
		THIS.cmdTop.Enabled = .T.
		THIS.cmdPrior.Enabled = .T.
		THIS.cmdNext.Enabled = .F.
		THIS.cmdBottom.Enabled = .F.
	OTHERWISE
		THIS.SetAll("Enabled", .T.)
ENDCASE
ENDPROC
PROCEDURE beforerecordpointermoved
IF !EMPTY(This.SkipTable)
	SELECT (This.SkipTable)
ENDIF

ENDPROC
PROCEDURE Error
Parameters nError, cMethod, nLine

LOCAL cNewTable, nConflictStatus, lcMsg, lnAnswer 

DO CASE
	CASE nError = 13 && Alias not found
	*-----------------------------------------------------------
	* If the user tries to move the record pointer when no
	* table is open or when an invalid SkipTable property has been
	* specified, prompt the user for a table to open.
	*-----------------------------------------------------------
		cNewTable = GETFILE('DBF', SELTABLE_LOC, OPEN_LOC)
		IF FILE(cNewTable)
			SELECT 0
			USE (cNewTable)
			This.SkipTable = ALIAS()
		ELSE
			This.SkipTable = ""
		ENDIF
	CASE nError = 1585 
	*-----------------------------------------------------------
	* Update conflict handled by datachecker class.
	*-----------------------------------------------------------
		nConflictStatus = THIS.DataChecker1.CheckConflicts()
		IF nConflictStatus = 2
			WAIT WINDOW CONFLICT_LOC
		ENDIF
	OTHERWISE
	*-----------------------------------------------------------
	* Display information about an unanticipated error.
	*-----------------------------------------------------------
		lcMsg = NUM_LOC + ALLTRIM(STR(nError)) + CR_LOC + CR_LOC + ;
				MSG_LOC + MESSAGE( )+ CR_LOC + CR_LOC + ;
				PROG_LOC + PROGRAM(1)
		lnAnswer = MESSAGEBOX(lcMsg, 2+48+512)
		DO CASE
			CASE lnAnswer = 3 &&Abort
				CANCEL
			CASE lnAnswer = 4 &&Retry
				RETRY
			OTHERWISE
				RETURN
		ENDCASE
ENDCASE

ENDPROC
PROCEDURE Init
IF THIS.EnableDisableOnInit
	THIS.EnableDisableButtons
ENDIF
ENDPROC


************************************************************
OBJETO: cmdTop
************************************************************
*** PROPIEDADES ***
Top = 0
Left = 0
Height = 24
Width = 26
FontBold = .T.
FontName = "Courier New"
FontSize = 11
Caption = "|<"
TabIndex = 1
ToolTipText = "Top"
Name = "cmdTop"

*** METODOS ***
PROCEDURE Click
THIS.Parent.BeforeRecordPointerMoved

GO TOP

THIS.Parent.RecordPointerMoved
THIS.Parent.EnableDisableButtons

ENDPROC
PROCEDURE Error
Parameters nError, cMethod, nLine
This.Parent.Error(nError, cMethod, nLine)
ENDPROC


************************************************************
OBJETO: cmdPrior
************************************************************
*** PROPIEDADES ***
Top = 0
Left = 26
Height = 24
Width = 26
FontBold = .T.
FontName = "Courier New"
FontSize = 11
Caption = "<"
TabIndex = 2
ToolTipText = "Prior"
Name = "cmdPrior"

*** METODOS ***
PROCEDURE Click
THIS.Parent.BeforeRecordPointerMoved

SKIP -1
IF BOF()
	GO TOP
ENDIF

THIS.Parent.RecordPointerMoved
THIS.Parent.EnableDisableButtons

ENDPROC
PROCEDURE Error
Parameters nError, cMethod, nLine
This.Parent.Error(nError, cMethod, nLine)
ENDPROC


************************************************************
OBJETO: cmdNext
************************************************************
*** PROPIEDADES ***
Top = 0
Left = 52
Height = 24
Width = 26
FontBold = .T.
FontName = "Courier New"
FontSize = 11
Caption = ">"
TabIndex = 3
ToolTipText = "Next"
Name = "cmdNext"

*** METODOS ***
PROCEDURE Click
THIS.Parent.BeforeRecordPointerMoved

SKIP 1
IF EOF()
	GO BOTTOM
ENDIF

THIS.Parent.RecordPointerMoved
THIS.Parent.EnableDisableButtons

ENDPROC
PROCEDURE Error
Parameters nError, cMethod, nLine
This.Parent.Error(nError, cMethod, nLine)
ENDPROC


************************************************************
OBJETO: cmdBottom
************************************************************
*** PROPIEDADES ***
Top = 0
Left = 78
Height = 24
Width = 26
FontBold = .T.
FontName = "Courier New"
FontSize = 11
Caption = ">|"
TabIndex = 4
ToolTipText = "Bottom"
Name = "cmdBottom"

*** METODOS ***
PROCEDURE Click
THIS.Parent.BeforeRecordPointerMoved

GO BOTTOM

THIS.Parent.EnableDisableButtons
THIS.Parent.RecordPointerMoved
ENDPROC
PROCEDURE Error
Parameters nError, cMethod, nLine
This.Parent.Error(nError, cMethod, nLine)
ENDPROC


************************************************************
OBJETO: Datachecker1
************************************************************
*** PROPIEDADES ***
Top = 6
Left = 44
Height = 15
Width = 23
Name = "Datachecker1"

*** METODOS ***


************************************************************
OBJETO: _datanavbtns
************************************************************
*** PROPIEDADES ***
Courier New, 1, 11, 9, 17, 12, 11, 5, 0

*** METODOS ***


