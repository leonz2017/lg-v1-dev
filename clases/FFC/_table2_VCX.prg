************************************************************
OBJETO: _nav2picbuttons
************************************************************
*** PROPIEDADES ***
Width = 71
Height = 36
Name = "_nav2picbuttons"
cmgNav.Command1.AutoSize = .F.
cmgNav.Command1.Top = 5
cmgNav.Command1.Left = 5
cmgNav.Command1.Height = 24
cmgNav.Command1.Width = 24
cmgNav.Command1.Picture = graphics\previous.bmp
cmgNav.Command1.Caption = ""
cmgNav.Command1.ToolTipText = "Previous Record"
cmgNav.Command1.Name = "Command1"
cmgNav.Command2.AutoSize = .F.
cmgNav.Command2.Top = 5
cmgNav.Command2.Left = 29
cmgNav.Command2.Height = 24
cmgNav.Command2.Width = 24
cmgNav.Command2.Picture = graphics\next.bmp
cmgNav.Command2.Caption = ""
cmgNav.Command2.ToolTipText = "Next Record"
cmgNav.Command2.Name = "Command2"
cmgNav.Height = 34
cmgNav.Left = 8
cmgNav.Top = 0
cmgNav.Width = 57
cmgNav.Name = "cmgNav"
cusTableNav.Name = "cusTableNav"

*** METODOS ***


************************************************************
OBJETO: _nav2picbuttons
************************************************************
*** PROPIEDADES ***
MS Sans Serif, 1, 9, 6, 13, 11, 12, 2, 0

*** METODOS ***


************************************************************
OBJETO: _sortbutton
************************************************************
*** PROPIEDADES ***
Caption = "\<Sort..."
cclass = _sortdialog
Name = "_sortbutton"

*** METODOS ***


************************************************************
OBJETO: _sortbutton
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 21, 3, 0

*** METODOS ***


************************************************************
OBJETO: _sortselect
************************************************************
*** PROPIEDADES ***
Width = 47
Height = 22
Name = "_sortselect"

*** METODOS ***
PROCEDURE dosort
LPARAMETER lDescending
THIS.cusTableSort.lDescending = m.lDescending
THIS.cusTableSort.DoSort()
ENDPROC


************************************************************
OBJETO: cusTableSort
************************************************************
*** PROPIEDADES ***
Top = 0
Left = 12
Name = "cusTableSort"

*** METODOS ***


************************************************************
OBJETO: cmdSortUp
************************************************************
*** PROPIEDADES ***
AutoSize = .F.
Top = 0
Left = 0
Height = 22
Width = 23
Picture = graphics\sortup.bmp
Caption = ""
ToolTipText = "Sort Ascending"
ZOrderSet = 1
Name = "cmdSortUp"

*** METODOS ***
PROCEDURE Click
THIS.Parent.DoSort()
ENDPROC


************************************************************
OBJETO: cmdSortDown
************************************************************
*** PROPIEDADES ***
AutoSize = .F.
Top = 0
Left = 23
Height = 22
Width = 23
Picture = graphics\sortdown.bmp
Caption = ""
ToolTipText = "Sort Descending"
ZOrderSet = 2
Name = "cmdSortDown"

*** METODOS ***
PROCEDURE Click
THIS.Parent.DoSort(.T.)
ENDPROC


************************************************************
OBJETO: _sortselect
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 21, 3, 0

*** METODOS ***


************************************************************
OBJETO: _nav4picbuttons
************************************************************
*** PROPIEDADES ***
Width = 118
Height = 38
Name = "_nav4picbuttons"
cmgNav.Command1.AutoSize = .F.
cmgNav.Command1.Top = 5
cmgNav.Command1.Left = 29
cmgNav.Command1.Height = 24
cmgNav.Command1.Width = 24
cmgNav.Command1.Picture = graphics\previous.bmp
cmgNav.Command1.Caption = ""
cmgNav.Command1.ToolTipText = "Previous Record"
cmgNav.Command1.Name = "Command1"
cmgNav.Command2.AutoSize = .F.
cmgNav.Command2.Top = 5
cmgNav.Command2.Left = 53
cmgNav.Command2.Height = 24
cmgNav.Command2.Width = 24
cmgNav.Command2.Picture = graphics\next.bmp
cmgNav.Command2.Caption = ""
cmgNav.Command2.ToolTipText = "Next Record"
cmgNav.Command2.Name = "Command2"
cmgNav.Height = 33
cmgNav.Left = 8
cmgNav.Top = 0
cmgNav.Width = 106
cmgNav.TabIndex = 2
cmgNav.Name = "cmgNav"
cusTableNav.Name = "cusTableNav"
cmdTop.AutoSize = .F.
cmdTop.Top = 5
cmdTop.Left = 13
cmdTop.Height = 24
cmdTop.Width = 24
cmdTop.Picture = graphics\top.bmp
cmdTop.Caption = ""
cmdTop.TabIndex = 1
cmdTop.ToolTipText = "First Record"
cmdTop.Name = "cmdTop"
cmdBottom.AutoSize = .F.
cmdBottom.Top = 5
cmdBottom.Left = 85
cmdBottom.Height = 24
cmdBottom.Width = 24
cmdBottom.Picture = graphics\bottom.bmp
cmdBottom.Caption = ""
cmdBottom.TabIndex = 3
cmdBottom.ToolTipText = "Last Record"
cmdBottom.Name = "cmdBottom"

*** METODOS ***


************************************************************
OBJETO: _nav4picbuttons
************************************************************
*** PROPIEDADES ***
MS Sans Serif, 1, 9, 6, 13, 11, 12, 2, 0

*** METODOS ***


************************************************************
OBJETO: _navmenu
************************************************************
*** PROPIEDADES ***
Width = 74
Height = 27
BackStyle = 0
BorderWidth = 0
Visible = .F.
BackColor = 0,0,255
cclass = 
cclasslib = 
Name = "_navmenu"

*** METODOS ***
PROCEDURE domenu
IF EMPTY(ALIAS())
	RETURN
ENDIF

PRIVATE oTHIS
oTHIS = THIS
THIS.oMenu.showmenu()
THIS.RefreshForm()

ENDPROC
PROCEDURE setmenu
LOCAL oGoMenu
oGoMenu = THIS.oMenu.NewMenu()
WITH oGoMenu
	.AddMenuBar(MENU_TOP_LOC,"oTHIS.oNav.GoTop()")
	.AddMenuBar(MENU_BOTTOM_LOC,"oTHIS.oNav.GoBottom()")
	.AddMenuBar(MENU_NEXT_LOC,"oTHIS.oNav.GoNext()")
	.AddMenuBar(MENU_PREV_LOC,"oTHIS.oNav.GoPrevious()")
	.AddMenuBar(MENU_RECORD_LOC,"oTHIS.DoGoto")
ENDWITH

WITH THIS.oMenu
	.AddMenuBar(MENU_GOTO_LOC,oGoMenu)
	.AddMenuSeparator
	.AddMenuBar(MENU_ADD_LOC,"oTHIS.AddRecord")
	.AddMenuBar(MENU_DELETE_LOC,"oTHIS.DeleteRecord")
	.AddMenuSeparator
	.AddMenuBar(MENU_SORT_LOC,"oTHIS.DoSort")
	.AddMenuBar(MENU_FILTER_LOC,"oTHIS.DoFilter")
	.AddMenuBar(MENU_FILTER2_LOC,"oTHIS.DoFilter2")
ENDWITH
ENDPROC
PROCEDURE dodialog
LOCAL lcfile, loDialog, lcclass

IF !EMPTY(THIS.cClasslib)
	lcfile = FULLPATH(THIS.cClasslib)
ELSE
	lcfile = FULLPATH(THIS.ClassLibrary)
ENDIF
IF NOT FILE(lcfile)
   WAIT WINDOW ERR_NOVCXLIB_LOC
   RETURN .F.
ENDIF
lcclass = THIS.cClass
IF EMPTY(lcclass)
   WAIT WINDOW ERR_NOCLASS_LOC
   RETURN .F.
ENDIF
loDialog = NEWOBJECT(lcclass,lcfile)
loDialog.Show(1)

ENDPROC
PROCEDURE dosort
THIS.cClass = "_sortdialog"
THIS.cClassLib = THIS.ClassLibrary
THIS.DoDialog()

ENDPROC
PROCEDURE dogoto
THIS.cClass = "_gotodialog"
THIS.cClassLib =IIF(VERSION(2)=0,"",HOME()+"FFC\")+"_table.vcx"
THIS.DoDialog()

ENDPROC
PROCEDURE dofilter
THIS.cClass = "_filterdialog"
THIS.cClassLib =IIF(VERSION(2)=0,"",HOME()+"FFC\")+"_table.vcx"
THIS.DoDialog()

ENDPROC
PROCEDURE dofilter2
THIS.cClass = "_filterexpr"
THIS.cClassLib =IIF(VERSION(2)=0,"",HOME()+"FFC\")+"_table.vcx"
THIS.DoDialog()

ENDPROC
PROCEDURE addrecord
APPEND BLANK
THIS.RefreshForm()

ENDPROC
PROCEDURE deleterecord
IF MESSAGEBOX(C_DELREC_LOC,MB_QUESTIONYESNO) = MB_ISYES
	DELETE
	SKIP
	IF EOF()
		GO BOTTOM
	ENDIF
	THIS.RefreshForm()
ENDIF

ENDPROC
PROCEDURE refreshform
IF VARTYPE(_SCREEN.ActiveForm)="O"
	_SCREEN.ActiveForm.Refresh
ENDIF

ENDPROC
PROCEDURE Error
LPARAMETERS nerror,cmethod,nline
DO CASE
CASE nError = 5  &&record out of range
	IF EOF()
		GO BOTTOM
	ELSE
		GO TOP
	ENDIF
CASE nError = 1884 AND 	CURSORGETPROP("buffering")=1
	* Uniqueness ID error
	MESSAGEBOX(ERR_UNIQUEKEY_LOC)
CASE nError = 1884	
	IF MESSAGEBOX(ERR_UNIQUEKEY_LOC+" "+ERR_UNIQUEKEY2_LOC,36)=6
		TABLEREVERT(.T.)
	ENDIF
ENDCASE
ENDPROC
PROCEDURE Init
THIS.SetMenu()

ENDPROC


************************************************************
OBJETO: oMenu
************************************************************
*** PROPIEDADES ***
Top = 5
Left = 12
Height = 15
Width = 18
Name = "oMenu"

*** METODOS ***


************************************************************
OBJETO: oNav
************************************************************
*** PROPIEDADES ***
Top = 6
Left = 48
Height = 16
Width = 24
Name = "oNav"

*** METODOS ***


************************************************************
OBJETO: _filterbutton
************************************************************
*** PROPIEDADES ***
Caption = "\<Filter..."
cexprclass = _filterexpr
cfilterclass = _filterdialog
cclass = _filterdialog
cclasslib = (IIF(VERSION(2)=0,"",HOME()+"FFC\")+"_table.vcx")
Name = "_filterbutton"

*** METODOS ***
PROCEDURE dodialog
THIS.cClass = IIF(THIS.lExprDialog,THIS.cExprClass,THIS.cFilterClass)
DODEFAULT()
ENDPROC


************************************************************
OBJETO: _filterbutton
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 21, 3, 0

*** METODOS ***


************************************************************
OBJETO: _gotobutton
************************************************************
*** PROPIEDADES ***
Caption = "\<Go To..."
cclass = _gotodialog
cclasslib = (IIF(VERSION(2)=0,"",HOME()+"FFC\")+"_table.vcx")
Name = "_gotobutton"

*** METODOS ***


************************************************************
OBJETO: _gotobutton
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 21, 3, 0

*** METODOS ***


************************************************************
OBJETO: _locatebutton
************************************************************
*** PROPIEDADES ***
Caption = "\<Locate..."
cclasslib = (IIF(VERSION(2)=0,"",HOME()+"FFC\")+"_table.vcx")
cclass = _finddialog
Name = "_locatebutton"

*** METODOS ***


************************************************************
OBJETO: _locatebutton
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 21, 3, 0

*** METODOS ***


************************************************************
OBJETO: _sortdialog
************************************************************
*** PROPIEDADES ***
Height = 107
Width = 324
DoCreate = .T.
AutoCenter = .T.
Caption = "Sort"
Name = "_sortdialog"

*** METODOS ***
PROCEDURE dosort
IF ALLTRIM(THIS._cboTags.Value) = C_NONE_LOC
	SET ORDER TO
ELSE
	THIS.cusTableSort.DoSort(,,ALLTRIM(THIS._cboTags.Value),THIS.opgDirection.Value#1)
ENDIF

ENDPROC
PROCEDURE Init
IF EMPTY(ALIAS())
	RETURN .F.
ENDIF
IF TYPE("THIS._cboTags.Baseclass")#"C"
	RETURN .F.
ENDIF
ENDPROC


************************************************************
OBJETO: _shape1
************************************************************
*** PROPIEDADES ***
Top = 19
Left = 10
Height = 50
Width = 212
SpecialEffect = 0
Name = "_shape1"

*** METODOS ***


************************************************************
OBJETO: opgDirection
************************************************************
*** PROPIEDADES ***
Height = 51
Left = 232
Top = 19
Width = 84
TabIndex = 2
Name = "opgDirection"
Option1.Picture = graphics\sortup.bmp
Option1.Caption = ""
Option1.Height = 32
Option1.Left = 11
Option1.Style = 1
Option1.Top = 10
Option1.Width = 32
Option1.AutoSize = .F.
Option1.Name = "Option1"
Option2.Picture = graphics\sortdown.bmp
Option2.Caption = ""
Option2.Height = 32
Option2.Left = 43
Option2.Style = 1
Option2.Top = 10
Option2.Width = 32
Option2.AutoSize = .F.
Option2.Name = "Option2"

*** METODOS ***
PROCEDURE Init
IF ATC(" DESCENDING",SET("ORDER"))#0
	THIS.Value = 2
ENDIF

ENDPROC


************************************************************
OBJETO: _cboTags
************************************************************
*** PROPIEDADES ***
FontName = "MS Sans Serif"
FontSize = 8
Height = 24
Left = 20
Style = 2
TabIndex = 1
Top = 32
Width = 192
Name = "_cboTags"

*** METODOS ***
PROCEDURE Init
LOCAL nTotalTags,i
nTotalTags = TAGCOUNT('')

IF nTotalTags = 0
	WAIT WINDOW ERR_NOTAGS_LOC
	RETURN .F.
ENDIF

THIS.AddItem(C_NONE_LOC)
FOR i = 1 TO m.nTotalTags
	THIS.AddItem(TAG(m.i))
ENDFOR

THIS.Value = IIF(EMPTY(TAG()),C_NONE_LOC,TAG())
IF THIS.Value = C_NONE_LOC
	THIS.Parent.opgDirection.Option1.Enabled = .F.
	THIS.Parent.opgDirection.Option2.Enabled = .F.
ENDIF

ENDPROC
PROCEDURE InteractiveChange
THIS.Parent.opgDirection.Option1.Enabled = (THIS.Value # C_NONE_LOC)
THIS.Parent.opgDirection.Option2.Enabled = (THIS.Value # C_NONE_LOC)

ENDPROC


************************************************************
OBJETO: cmdSort
************************************************************
*** PROPIEDADES ***
Top = 78
Left = 169
Height = 23
Width = 72
FontName = "MS Sans Serif"
FontSize = 8
Caption = "\<Sort"
Default = .T.
TabIndex = 3
Name = "cmdSort"

*** METODOS ***
PROCEDURE Click
THISFORM.DoSort
THISFORM.Release

ENDPROC


************************************************************
OBJETO: cmdCancel
************************************************************
*** PROPIEDADES ***
Top = 78
Left = 244
Height = 23
Width = 72
FontName = "MS Sans Serif"
FontSize = 8
Cancel = .T.
Caption = "Cancel"
TabIndex = 4
Name = "cmdCancel"

*** METODOS ***
PROCEDURE Click
THISFORM.Release

ENDPROC


************************************************************
OBJETO: _label1
************************************************************
*** PROPIEDADES ***
AutoSize = .T.
FontName = "MS Sans Serif"
FontSize = 8
Caption = "Sort direction:"
Left = 236
Top = 12
TabIndex = 5
Name = "_label1"

*** METODOS ***


************************************************************
OBJETO: _label2
************************************************************
*** PROPIEDADES ***
AutoSize = .T.
FontName = "MS Sans Serif"
FontSize = 8
Caption = "Select field:"
Left = 16
Top = 12
TabIndex = 6
Name = "_label2"

*** METODOS ***


************************************************************
OBJETO: cusTableSort
************************************************************
*** PROPIEDADES ***
Top = 72
Left = 48
Name = "cusTableSort"

*** METODOS ***


************************************************************
OBJETO: _sortdialog
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 21, 3, 0
MS Sans Serif, 0, 8, 5, 13, 11, 11, 2, 0

*** METODOS ***


************************************************************
OBJETO: _navtoolbarclass
************************************************************
*** PROPIEDADES ***
Width = 21
Height = 24
BackStyle = 0
BorderWidth = 0
otoolbar = 
cclasslib = 
cclass = _tbrnavigation
Name = "_navtoolbarclass"

*** METODOS ***
PROCEDURE Init
LOCAL lcfile, lcclass, lhastoolbar,i
lhastoolbar = .F.

* Check if toolbar already exists...
FOR i = 1 TO _VFP.FORMS.COUNT
	IF UPPER(_VFP.FORMS[m.i].NAME)==UPPER(THIS.cClass)
		lhastoolbar = .T.
		EXIT
	ENDIF
ENDFOR

IF !EMPTY(THIS.cClasslib)
	lcfile = FULLPATH(THIS.cClasslib)
ELSE
	lcfile = FULLPATH(THIS.ClassLibrary)
ENDIF
IF NOT FILE(lcfile)
   WAIT WINDOW ERR_NOVCXLIB_LOC
   RETURN .F.
ENDIF
lcclass = THIS.cClass
IF EMPTY(lcclass)
   WAIT WINDOW ERR_NOCLASS_LOC
   RETURN .F.
ENDIF
THIS.oToolbar = NEWOBJECT(lcclass,lcfile)

IF !m.lhastoolbar
	THIS.oToolbar.Show()
ELSE
	THIS.oToolbar.Visible = .F.
	THIS.tmrCheckToolbar.Interval = 500
ENDIF

ENDPROC
PROCEDURE Destroy
IF VARTYPE(THIS.oToolbar)="O"
	THIS.oToolbar.Name = SYS(2015)
	INKEY(.1)
	THIS.oToolbar.Release
	THIS.oToolbar = null
ENDIF

ENDPROC


************************************************************
OBJETO: tmrCheckToolbar
************************************************************
*** PROPIEDADES ***
Top = 0
Left = 0
Height = 23
Width = 23
Name = "tmrCheckToolbar"

*** METODOS ***
PROCEDURE Timer
* Check if toolbar still exists...
LOCAL oForm,i
FOR i = 1 TO _VFP.FORMS.COUNT
	oForm = _VFP.FORMS[m.i]
	IF TYPE("oForm ")#"U" AND;
	  UPPER(oForm.NAME)==UPPER(THIS.Parent.cClass);
	  AND oForm.Visible
	  	WITH THIS.Parent
			.nLastTop = oForm.Top 
			.nLastLeft = oForm.Left
			.lDocked = oForm.Docked
		ENDWITH
		RETURN
	ENDIF
ENDFOR

THIS.Interval = 0
THIS.Parent.oToolbar.Top = THIS.Parent.nLastTop 
THIS.Parent.oToolbar.Left = THIS.Parent.nLastLeft 
IF THIS.Parent.lDocked
	THIS.Parent.oToolbar.Dock(0)
ENDIF
THIS.Parent.oToolbar.Show()

ENDPROC


************************************************************
OBJETO: _dialogbutton
************************************************************
*** PROPIEDADES ***
Caption = "\<Run..."
cclass = 
cclasslib = 
lmodal = .T.
odialog = .NULL.
cparms = 
Name = "_dialogbutton"

*** METODOS ***
PROCEDURE dodialog
LOCAL lcfile, lcclass, lnModal
IF !EMPTY(THIS.cClasslib)
	lcfile = FULLPATH(THIS.cClasslib)
ELSE
	lcfile = FULLPATH(THIS.ClassLibrary)
ENDIF
IF NOT FILE(lcfile)
   WAIT WINDOW ERR_NOVCXLIB_LOC
   RETURN .F.
ENDIF
lcclass = THIS.cClass
IF EMPTY(lcclass)
   WAIT WINDOW ERR_NOCLASS_LOC
   RETURN .F.
ENDIF
IF EMPTY(THIS.cParms) AND VARTYPE(THIS.cParms)="C"
	THIS.oDialog = NEWOBJECT(lcclass,lcfile)
ELSE
	THIS.oDialog = NEWOBJECT(lcclass,lcfile,"",THIS.cParms)
ENDIF
IF VARTYPE(THIS.oDialog)="O"
	lnModal = IIF(THIS.lModal,1,0)
	THIS.SetDialogPEMs()	&&abstract method
	THIS.oDialog.Show(lnModal)
ENDIF

ENDPROC
PROCEDURE Click
THIS.DoDialog()
ENDPROC
PROCEDURE Destroy
THIS.oDialog=null
ENDPROC


************************************************************
OBJETO: _dialogbutton
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 21, 3, 0

*** METODOS ***


************************************************************
OBJETO: _tbrnavigation
************************************************************
*** PROPIEDADES ***
Caption = "Navigation"
Height = 28
Left = 0
Top = 0
Width = 291
calias = 
Name = "_tbrnavigation"

*** METODOS ***
PROCEDURE Refresh
LOCAL lcDataSession
IF NOT THIS.lDisabledForModal
  lcDataSession=SET("DataSession")
  IF TYPE("_screen.activeform.name")="C"
	  SET DataSession TO _screen.activeform.DataSessionID
  ENDIF
  THIS.cAlias = ALIAS()
  STORE THIS.cAlias TO ;
        THIS._GoTo.cusTableNav.cAlias, ;
        THIS._Nav4picbuttons.cusTableNav.cAlias, ;
        THIS._SortSelect.cusTableSort.cAlias
  THIS.Setall("Enabled",NOT EMPTY(THIS.cAlias))
  THIS._GoTo.InitData()
  DODEFAULT()
  SET DataSession TO lcDataSession
ENDIF

ENDPROC


************************************************************
OBJETO: _nav4picbuttons
************************************************************
*** PROPIEDADES ***
Top = 3
Left = 5
Width = 93
Height = 22
Name = "_nav4picbuttons"
cmgNav.Command1.Top = 0
cmgNav.Command1.Left = 16
cmgNav.Command1.Height = 22
cmgNav.Command1.Width = 23
cmgNav.Command1.Name = "Command1"
cmgNav.Command2.Top = 0
cmgNav.Command2.Left = 39
cmgNav.Command2.Height = 22
cmgNav.Command2.Width = 23
cmgNav.Command2.Name = "Command2"
cmgNav.BorderStyle = 0
cmgNav.Name = "cmgNav"
cusTableNav.Top = 5
cusTableNav.Left = 68
cusTableNav.Height = 13
cusTableNav.Width = 17
cusTableNav.Name = "cusTableNav"
cmdTop.Top = 0
cmdTop.Left = 1
cmdTop.Height = 22
cmdTop.Width = 23
cmdTop.Name = "cmdTop"
cmdBottom.Top = 0
cmdBottom.Left = 70
cmdBottom.Height = 22
cmdBottom.Width = 23
cmdBottom.Name = "cmdBottom"

*** METODOS ***
PROCEDURE tablenav
LPARAMETERS tcAction
IF EMPTY(tcAction) OR VARTYPE(tcAction)#"C"
  RETURN
ENDIF  
DODEFAULT(tcAction)
THISFORM.REFRESH()
ENDPROC


************************************************************
OBJETO: Separator2
************************************************************
*** PROPIEDADES ***
Top = 3
Left = 105
Height = 30742164
Width = 30742164
Name = "Separator2"

*** METODOS ***


************************************************************
OBJETO: _goto
************************************************************
*** PROPIEDADES ***
Top = 3
Left = 105
Name = "_goto"
cusTableNav.Name = "cusTableNav"
spnGoTo.Name = "spnGoTo"

*** METODOS ***


************************************************************
OBJETO: Separator1
************************************************************
*** PROPIEDADES ***
Top = 3
Left = 196
Height = 55249180
Width = 55249180
Name = "Separator1"

*** METODOS ***


************************************************************
OBJETO: _sortselect
************************************************************
*** PROPIEDADES ***
Top = 3
Left = 196
Width = 46
Height = 22
Name = "_sortselect"
cusTableSort.Name = "cusTableSort"
cmdSortUp.Name = "cmdSortUp"
cmdSortDown.Name = "cmdSortDown"

*** METODOS ***


************************************************************
OBJETO: cmdFilter
************************************************************
*** PROPIEDADES ***
Top = 3
Left = 241
Height = 22
Width = 23
Picture = graphics\filter.bmp
Caption = ""
ToolTipText = "Set Filter..."
Name = "cmdFilter"

*** METODOS ***


************************************************************
OBJETO: cmdLocate
************************************************************
*** PROPIEDADES ***
Top = 3
Left = 263
Height = 22
Width = 23
Picture = graphics\find.bmp
Caption = ""
ToolTipText = "Locate..."
Name = "cmdLocate"

*** METODOS ***


************************************************************
OBJETO: _tbrnavigation
************************************************************
*** PROPIEDADES ***
Arial, 1, 9, 6, 15, 12, 32, 3, 0
MS Sans Serif, 0, 8, 5, 13, 11, 11, 2, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: _goto
************************************************************
*** PROPIEDADES ***
Width = 84
Height = 22
BorderWidth = 0
Name = "_goto"

*** METODOS ***
PROCEDURE gorecord
THIS.cusTableNav.GoToRecord(THIS.spnGoTo.Value)
* we may not have moved but we may have reverted data
* so we have to refresh whether the pointer has moved or not

THIS.cusTableNav.RefreshLastWindowAfterChange()

ENDPROC
PROCEDURE initdata
LOCAL llReturn
IF EMPTY(THIS.cusTableNav.cAlias) OR ;
    NOT USED(THIS.cusTableNav.cAlias) OR ;
    RECCOUNT(THIS.cusTableNav.cAlias) < 2
     llReturn = .F.
ELSE
     WITH THIS.spnGoTo
     	STORE 1 TO .SpinnerLowValue, .KeyBoardLowValue
     	 STORE RECCOUNT(THIS.cusTableNav.cAlias) TO ;
                  .SpinnerHighValue, .KeyBoardHighValue
       .Value = RECNO(THIS.cusTableNav.cAlias)
       .Value = MIN(.Value,.SpinnerHighValue) && EOF()
      ENDWITH
ENDIF
RETURN llReturn

ENDPROC
PROCEDURE Init
THIS.InitData()
ENDPROC


************************************************************
OBJETO: cusTableNav
************************************************************
*** PROPIEDADES ***
Top = 24
Left = 48
Name = "cusTableNav"

*** METODOS ***
PROCEDURE Init
LOCAL llReturn
llReturn = DODEFAULT()
IF llReturn
   THIS.cAlias = THIS.GetCurrentAlias()
ENDIF
RETURN llReturn
ENDPROC


************************************************************
OBJETO: spnGoTo
************************************************************
*** PROPIEDADES ***
FontName = "MS Sans Serif"
FontSize = 8
Height = 22
Increment =   1.00
InputMask = "9999999999"
Left = 0
Top = 0
Width = 84
Format = ""
Name = "spnGoTo"

*** METODOS ***
PROCEDURE Refresh
DO CASE
CASE EMPTY(THIS.Parent.cusTableNav.cAlias) AND EMPTY(ALIAS())
	RETURN
CASE EMPTY(THIS.Parent.cusTableNav.cAlias)
	THIS.Value = RECNO()
CASE SELECT(THIS.Parent.cusTableNav.cAlias)=0
	RETURN
OTHERWISE
	THIS.Value = RECNO(THIS.Parent.cusTableNav.cAlias)
ENDCASE
ENDPROC
PROCEDURE InteractiveChange
THIS.Parent.GoRecord()
ENDPROC


************************************************************
OBJETO: _goto
************************************************************
*** PROPIEDADES ***
MS Sans Serif, 0, 8, 5, 13, 11, 11, 2, 0

*** METODOS ***


