************************************************************
OBJETO: _moverlists
************************************************************
*** PROPIEDADES ***
Width = 409
Height = 132
BackStyle = 0
BorderWidth = 0
mousex = 0
mousey = 0
candropicon = DRAGMOVE.CUR
nodropicon = NODROP01.CUR
dragthreshold = 8
Name = "_moverlists"

*** METODOS ***
PROCEDURE selectall
LPARAMETERS oList
LOCAL lnCnt
FOR lnCnt = 1 to oList.ListCount
	oList.Selected(lnCnt) = .T.
ENDFOR
ENDPROC
PROCEDURE Init
This.lstSource.DragIcon = This.CanDropIcon
This.lstSelected.DragIcon = This.CanDropIcon

ENDPROC


************************************************************
OBJETO: lstSource
************************************************************
*** PROPIEDADES ***
DragMode = 0
DragIcon = grid\
FontBold = .F.
FontName = "MS Sans Serif"
FontSize = 8
ColumnCount = 0
ColumnWidths = ""
RowSourceType = 0
RowSource = ""
ControlSource = ""
Height = 132
Left = 0
MultiSelect = .T.
NumberOfElements = 0
TabIndex = 1
Top = 0
Width = 169
Name = "lstSource"

*** METODOS ***
PROCEDURE KeyPress
LPARAMETERS nKeyCode, nShiftAltCtrl
IF nKeyCode = 63 AND nShiftAltCtrl = 1
	THIS.Parent.SelectAll(THIS)
ENDIF
ENDPROC
PROCEDURE MouseMove
LPARAMETERS nButton, nShift, nXCoord, nYCoord
IF nButton = 1 && Left Mouse
	IF ABS(nXCoord - THIS.Parent.MouseX) > THIS.Parent.DragThreshold OR ;
			ABS(nYCoord - THIS.Parent.MouseY) > THIS.Parent.DragThreshold
		THIS.Drag
	ENDIF
ENDIF

ENDPROC
PROCEDURE MouseDown
LPARAMETERS nButton, nShift, nXCoord, nYCoord
THIS.Parent.MouseX = nXCoord
THIS.Parent.MouseY = nYCoord

ENDPROC
PROCEDURE DragDrop
LPARAMETERS oSource, nXCoord, nYCoord
IF oSource.Name != THIS.Name
	THIS.Parent.cmdRemove.Click
ENDIF

ENDPROC
PROCEDURE DblClick
THIS.Parent.lstSelected.AddItem(This.List(This.ListIndex))
This.RemoveItem(This.ListIndex)

ENDPROC
PROCEDURE DragOver
LPARAMETERS oSource, nXCoord, nYCoord, nState
DO CASE
	CASE nState = 0 && Enter
		oSource.DragIcon = THIS.Parent.CanDropIcon
	CASE nState = 1 && Leave
		oSource.DragIcon = THIS.Parent.NoDropIcon
ENDCASE


ENDPROC


************************************************************
OBJETO: lstSelected
************************************************************
*** PROPIEDADES ***
DragMode = 0
DragIcon = grid\
FontBold = .F.
FontName = "MS Sans Serif"
FontSize = 8
ColumnCount = 0
ColumnWidths = ""
RowSourceType = 0
RowSource = ""
ControlSource = ""
FirstElement = 1
Height = 132
Left = 240
MoverBars = .T.
MultiSelect = .T.
NumberOfElements = 0
TabIndex = 2
Top = 0
Width = 169
Name = "lstSelected"

*** METODOS ***
PROCEDURE KeyPress
LPARAMETERS nKeyCode, nShiftAltCtrl
IF nKeyCode = 63 AND nShiftAltCtrl = 1
	THIS.Parent.SelectAll(THIS)
ENDIF
ENDPROC
PROCEDURE MouseMove
LPARAMETERS nButton, nShift, nXCoord, nYCoord
IF nButton = 1 && Left Mouse
	IF ABS(nXCoord - THIS.Parent.MouseX) > THIS.Parent.DragThreshold OR ;
			ABS(nYCoord - THIS.Parent.MouseY) > THIS.Parent.DragThreshold
		THIS.Drag
	ENDIF
ENDIF

ENDPROC
PROCEDURE MouseDown
LPARAMETERS nButton, nShift, nXCoord, nYCoord
THIS.Parent.MouseX = nXCoord
THIS.Parent.MouseY = nYCoord

ENDPROC
PROCEDURE DragDrop
LPARAMETERS oSource, nXCoord, nYCoord
IF oSource.Name != THIS.Name
	THIS.Parent.cmdAdd.Click
ENDIF

ENDPROC
PROCEDURE DblClick
THIS.Parent.lstSource.AddItem(This.List(This.ListIndex))
This.RemoveItem(This.ListIndex)

ENDPROC
PROCEDURE DragOver
LPARAMETERS oSource, nXCoord, nYCoord, nState
DO CASE
	CASE nState = 0 && Enter
		oSource.DragIcon = THIS.Parent.CanDropIcon
	CASE nState = 1 && Leave
		oSource.DragIcon = THIS.Parent.NoDropIcon
ENDCASE

ENDPROC


************************************************************
OBJETO: cmdAdd
************************************************************
*** PROPIEDADES ***
Top = 2
Left = 186
Height = 25
Width = 37
FontBold = .T.
FontName = "Courier New"
FontSize = 11
Caption = ">"
TabIndex = 3
ToolTipText = "Add Selected Items"
Name = "cmdAdd"

*** METODOS ***
PROCEDURE Click
LOCAL nCnt
THISFORM.LockScreen = .T.
* The ListCount value changes whenever the RemoveItem method is called
nCnt = 1
DO WHILE m.nCnt <= THIS.Parent.lstSource.ListCount
	IF THIS.Parent.lstSource.Selected(m.nCnt)
		THIS.Parent.lstSelected.AddItem(THIS.Parent.lstSource.List(m.nCnt))
		THIS.Parent.lstSource.RemoveItem(m.nCnt)
	ELSE
		nCnt = m.nCnt + 1
	ENDIF
ENDDO
THISFORM.LockScreen = .F.
ENDPROC


************************************************************
OBJETO: cmdAddAll
************************************************************
*** PROPIEDADES ***
Top = 33
Left = 186
Height = 25
Width = 37
FontBold = .T.
FontName = "Courier New"
FontSize = 11
Caption = ">>"
TabIndex = 4
ToolTipText = "Add All Items"
Name = "cmdAddAll"

*** METODOS ***
PROCEDURE Click
LOCAL i
THISFORM.LockScreen = .T.
FOR i = 1 to THIS.Parent.lstSource.ListCount
	THIS.Parent.lstSelected.AddItem(THIS.Parent.lstSource.List(m.i))
ENDFOR
THIS.Parent.lstSource.Clear
THISFORM.LockScreen = .F.
ENDPROC


************************************************************
OBJETO: cmdRemove
************************************************************
*** PROPIEDADES ***
Top = 71
Left = 186
Height = 25
Width = 37
FontBold = .T.
FontName = "Courier New"
FontSize = 11
Caption = "<"
TabIndex = 5
ToolTipText = "Remove Selected Items"
Name = "cmdRemove"

*** METODOS ***
PROCEDURE Click
LOCAL nCnt
THISFORM.LockScreen = .T.
nCnt = 1
DO WHILE m.nCnt <= THIS.Parent.lstSelected.ListCount
	IF THIS.Parent.lstSelected.Selected(m.nCnt)
		THIS.Parent.lstSource.AddItem(THIS.Parent.lstSelected.List(m.nCnt))
		THIS.Parent.lstSelected.RemoveItem(m.nCnt)
	ELSE
		nCnt = m.nCnt + 1
	ENDIF
ENDDO
THISFORM.LockScreen = .F.
ENDPROC


************************************************************
OBJETO: cmdRemoveAll
************************************************************
*** PROPIEDADES ***
Top = 102
Left = 186
Height = 25
Width = 37
FontBold = .T.
FontName = "Courier New"
FontSize = 11
Caption = "<<"
TabIndex = 6
ToolTipText = "Remove All Items"
Name = "cmdRemoveAll"

*** METODOS ***
PROCEDURE Click
LOCAL i
THISFORM.LockScreen = .T.
FOR i = 1 to THIS.Parent.lstSelected.ListCount
	THIS.Parent.lstSource.AddItem(THIS.Parent.lstSelected.List(m.i))
ENDFOR
THIS.Parent.lstSelected.Clear
THISFORM.LockScreen = .F.
ENDPROC


************************************************************
OBJETO: _moverlists
************************************************************
*** PROPIEDADES ***
MS Sans Serif, 0, 8, 5, 13, 11, 11, 2, 0
Courier New, 1, 11, 9, 17, 12, 11, 5, 0

*** METODOS ***


************************************************************
OBJETO: _resizable
************************************************************
*** PROPIEDADES ***
Height = 19
Width = 27
initialresize = .T.
initialformheight = 0
initialformwidth = 0
Name = "_resizable"

*** METODOS ***
PROCEDURE adjustcontrols
IF THIS.InitialResize
	THIS.LoopThroughControls("INITIALIZE_AND_ADJUST")
	THIS.InitialResize = .F.
ELSE
	THIS.LoopThroughControls("ADJUST")
ENDIF
ENDPROC
PROCEDURE addtoarray
LPARAMETERS oControl
LOCAL nLen
nLen = ALEN(THIS.aControlStats,1)
THIS.aControlStats[nLen,1] = oControl.Top / THIS.InitialFormHeight
THIS.aControlStats[nLen,2] = oControl.Left / THIS.InitialFormWidth
THIS.aControlStats[nLen,3] = oControl.Height / THIS.InitialFormHeight
THIS.aControlStats[nLen,4] = oControl.Width / THIS.InitialFormWidth
THIS.aControlStats[nLen,5] = IIF(TYPE("oControl.FontSize") = 'U', 0, oControl.FontSize)
DIMENSION THIS.aControlStats[nLen+1, 5]

ENDPROC
PROCEDURE setsize
LPARAMETERS oControl, nPos
oControl.Top = THISFORM.Height * THIS.aControlStats[nPos,1]
oControl.Left = THISFORM.Width * THIS.aControlStats[nPos,2]
oControl.Width = THISFORM.Width * THIS.aControlStats[nPos,4]
IF !oControl.Baseclass $ "Textbox Spinner"
	oControl.Height = THISFORM.Height * THIS.aControlStats[nPos,3]
ENDIF

ENDPROC
PROCEDURE loopthroughcontrols
LPARAMETERS cTask
* Valid parameters for cTask are 'Initialize_And_Adjust' and 'Adjust'

LOCAL nOldDecimal, nPos, i, j, k, oControl 

cTask = UPPER(cTask)

nOldDecimal = SET("DECIMAL")
SET DECIMAL TO 4

#define BASE_CLASS "Commandbutton Combobox Checkbox Listbox Form Grid Textbox Label Shape Editbox Olecontrol Pageframe Image Spinner"

nPos = 0
THISFORM.LockScreen = .T.
FOR m.i = 1 TO THISFORM.ControlCount
	oControl = THISFORM.Controls[m.i]
	IF oControl.Baseclass$BASE_CLASS
		nPos = nPos + 1
		DO CASE
			CASE cTask = 'INITIALIZE_AND_ADJUST'
				THIS.AddToArray(oControl)
				THIS.SetSize(oControl, nPos)
			CASE cTask = 'ADJUST'
				THIS.SetSize(oControl, nPos)
		ENDCASE
	ENDIF
	*A pageframe can contain only pages
	IF THISFORM.Controls[m.i].Baseclass$"Pageframe"
		*Loop through each page of the pageframe
		FOR m.j = 1 TO THISFORM.Controls[m.i].PageCount
			WITH THISFORM.Controls[m.i].pages[m.j]
				*loop through all the controls on the page
				FOR m.k = 1 TO .ControlCount
					IF .Controls[m.k].Baseclass$BASE_CLASS
						nPos = nPos + 1
						DO CASE
							CASE cTask = 'INITIALIZE_AND_ADJUST'
								THIS.AddToArray(.Controls[m.k])
								THIS.SetSize(.Controls[m.k], nPos)
							CASE cTask = 'ADJUST'
								THIS.SetSize(.Controls[m.k], nPos)
						ENDCASE
					ENDIF
				ENDFOR
			ENDWITH
		ENDFOR
	ENDIF			
ENDFOR

THISFORM.LockScreen = .F.
SET DECIMAL TO nOldDecimal
ENDPROC
PROCEDURE reset
THIS.InitialResize = .T.
DIMENSION THIS.aControlStats[1,5]
ENDPROC
PROCEDURE Init
THIS.InitialFormHeight = THISFORM.Height
THIS.InitialFormWidth = THISFORM.Width
ENDPROC


************************************************************
OBJETO: _folder
************************************************************
*** PROPIEDADES ***
Width = 336
Height = 125
BorderWidth = 0
clastprojectfile = 
cext = .pjx
Name = "_folder"

*** METODOS ***
PROCEDURE trimfile
LPARAMETERS tcFileName
LOCAL lcFileName,lnAtPos
lnAtPos=RATC("\",tcFileName)
lcFileName=ALLTRIM(IIF(lnAtPos=0,tcFileName,LEFTC(tcFileName,lnAtPos)))
RETURN LOWER(lcFileName)

ENDPROC
PROCEDURE release
IF this.lRelease
	NODEFAULT
	RETURN .F.
ENDIF
this.lRelease=.T.
RELEASE this

ENDPROC


************************************************************
OBJETO: lblProjectName
************************************************************
*** PROPIEDADES ***
FontName = "MS Sans Serif"
FontSize = 8
Caption = "P\<roject name:"
Height = 23
Left = 10
Top = 8
Width = 98
TabIndex = 1
Name = "lblProjectName"

*** METODOS ***


************************************************************
OBJETO: txtProjectName
************************************************************
*** PROPIEDADES ***
FontName = "MS Sans Serif"
FontSize = 8
Height = 22
InputMask = (REPLICATE("X",128))
Left = 10
TabIndex = 2
Top = 23
Width = 315
Name = "txtProjectName"

*** METODOS ***
PROCEDURE KeyPress
LPARAMETERS nKeyCode, nShiftAltCtrl

IF AT(CHR(nKeyCode),"?/\,=:;{}[]!@#$%^&*.<>()+|"+CHR(34)+CHR(39))>0
	NODEFAULT
	RETURN .F.
ENDIF

ENDPROC
PROCEDURE Valid
LOCAL lcValue

lcValue=ALLTRIM(this.Value)
IF ":"$lcValue OR "\"$lcValue OR "."$lcValue
	this.Value=JustStem(ALLTRIM(lcValue))
ENDIF
IF EMPTY(lcValue) AND NOT EMPTY(this.parent.txtProjectFile.Value)
	this.parent.txtProjectFile.Value=THIS.Parent.cLastProjectFile
ENDIF
THIS.Parent.cLastProjectFile=""

ENDPROC
PROCEDURE InteractiveChange
LOCAL lcProjectDir,lcProjectDir2,lcProjectDir3,lcProjectFile,lcProjectFile2
LOCAL lcBadChars,lnAtPos

lcBadChars=" ?/\,=:;{}[]!@#$%^&*.<>()+|"+CHR(34)+CHR(39)
IF EMPTY(this.parent.cLastProjectFile)
	lcProjectDir=THIS.Parent.TrimFile(ALLTRIM(this.parent.txtProjectFile.Value))
	lcProjectDir3=lcProjectDir
	lcProjectFile2=JustStem(ALLTRIM(this.parent.txtProjectFile.Value))
	IF EMPTY(lcProjectDir)
		lcProjectDir=LOWER(SYS(5)+CURDIR())
		IF lcProjectDir==LOWER(HOME())
			lcProjectDir=LOWER(SYS(5)+"\")
		ENDIF
	ENDIF
	IF NOT "\"$lcProjectDir
		lcProjectDir="\"+lcProjectDir
	ENDIF
	lcProjectFile=ALLTRIM(CHRTRANC(LEFTC(ALLTRIM(this.Value),16),lcBadChars,""))
	lnAtPos=AT_C("\",lcProjectDir)
	IF lnAtPos>0
		lcProjectDir2=ALLTRIM(SUBSTRC(lcProjectDir,MIN(lnAtPos+1,LENC(lcProjectDir))))
		IF RIGHTC(lcProjectDir2,1)=="\"
			lcProjectDir2=ALLTRIM(LEFTC(lcProjectDir2,LENC(lcProjectDir2)-1))
		ENDIF
		IF LOWER(lcProjectDir2)==LOWER(lcProjectFile2)
			lnAtPos=AT_C("\",lcProjectDir3)
			lcProjectDir=ALLTRIM(LEFTC(lcProjectDir3,lnAtPos-1))+"\"+lcProjectFile+"\"
		ENDIF
	ENDIF
	IF NOT ":"$lcProjectDir AND LEFTC(lcProjectDir,2)#"\\"
		lcProjectDir=LOWER(SYS(5))+lcProjectDir
	ENDIF
	IF RIGHTC(lcProjectDir,2)==":\"
		lcProjectDir=lcProjectDir+lcProjectFile+"\"
	ENDIF
	IF NOT LOWER(RIGHTC(lcProjectFile,4))==THIS.PARENT.cExt
		lcProjectFile=lcProjectFile+THIS.PARENT.cExt
	ENDIF
	this.parent.txtProjectFile.Value=lcProjectDir+lcProjectFile
ENDIF
this.parent.txtProjectFile.Refresh
this.parent.cmdProjectFile.Refresh

ENDPROC
PROCEDURE ProgrammaticChange
this.InteractiveChange

ENDPROC
PROCEDURE GotFocus
LOCAL lcProjectFile

lcProjectFile=ALLTRIM(this.parent.txtProjectFile.Value)
IF LOWER(JustStem(lcProjectFile))=LOWER(ALLTRIM(this.Value))
	lcProjectFile=""
ENDIF
this.parent.cLastProjectFile=lcProjectFile

ENDPROC


************************************************************
OBJETO: lblProjectFile
************************************************************
*** PROPIEDADES ***
FontName = "MS Sans Serif"
FontSize = 8
FontExtend = .T.
Caption = "Proj\<ect file:"
Height = 23
Left = 10
Top = 53
Width = 86
TabIndex = 3
Name = "lblProjectFile"

*** METODOS ***


************************************************************
OBJETO: txtProjectFile
************************************************************
*** PROPIEDADES ***
FontName = "MS Sans Serif"
FontSize = 8
Height = 22
InputMask = (REPLICATE("X",128))
Left = 10
TabIndex = 4
Top = 68
Width = 243
Name = "txtProjectFile"

*** METODOS ***
PROCEDURE InteractiveChange
LOCAL lcValue,lcProjectFile,lcBadChars,lnSelStart

lnSelStart=this.SelStart
lcBadChars="?/,=;{}[]!@#$%^&*<>()+|"+CHR(34)+CHR(39)
lcValue=this.Value
lcProjectFile=CHRTRANC(lcValue,lcBadChars,"")

IF NOT lcValue=lcProjectFile
	this.Value=lcProjectFile
	this.SelStart=MAX(lnSelStart-1,0)
ENDIF

ENDPROC
PROCEDURE Refresh
this.Enabled=(NOT EMPTY(this.parent.txtProjectName.Value))

ENDPROC
PROCEDURE Valid
LOCAL lcValue,lcExt,lcProjectFile,lcProjectPath

lcValue=ALLTRIM(this.Value)
lcExt = IIF(EMPTY(THIS.PARENT.cExt),"PJX",ALLTRIM(THIS.PARENT.cExt))
IF EMPTY(lcValue)
	this.parent.txtProjectName.InteractiveChange
	RETURN (NOT EMPTY(this.Value))
ENDIF
IF lcValue=="\" OR lcValue==":" OR RIGHTC(lcValue,1)=="\"
	RETURN .F.
ENDIF

lcProjectFile=FORCEEXT(ALLTRIM(LEFTC(JUSTSTEM(lcValue),16)),lcExt)
lcProjectPath=ADDBS(ALLTRIM(JUSTPATH(lcValue)))

* check for invalid path (also handle network drives)
IF RATC("\\",lcProjectPath)>1
	lcProjectPath=STRTRAN(lcProjectPath,"\\","\",IIF(LEFTC(lcValue,2)="\\",2,1))
ENDIF
lcProjectFile=LOWER(FORCEPATH(lcProjectFile,lcProjectPath))
IF NOT lcValue==lcProjectFile
	this.Value=lcProjectFile
ENDIF

RETURN NOT EMPTY(JustStem(lcValue))

ENDPROC


************************************************************
OBJETO: cmdProjectFile
************************************************************
*** PROPIEDADES ***
Top = 68
Left = 260
Height = 23
Width = 66
FontName = "MS Sans Serif"
FontSize = 8
Caption = "Bro\<wse..."
TabIndex = 5
Name = "cmdProjectFile"

*** METODOS ***
PROCEDURE Valid
LOCAL lcProjectFile

lcProjectFile=ALLTRIM(this.parent.txtProjectFile.Value)
IF NOT EMPTY(lcProjectFile) AND NOT LOWER(RIGHTC(lcProjectFile,4))==THIS.PARENT.cExt
	lcProjectFile=lcProjectFile+THIS.PARENT.cExt
	this.parent.txtProjectFile.Value=lcProjectFile
ENDIF

ENDPROC
PROCEDURE Click
LOCAL lcDirectory,lcProjectFile

lcDirectory=LOWER(GETDIR())
IF EMPTY(lcDirectory)
	RETURN
ENDIF
lcProjectFile=JustStem(ALLTRIM(this.parent.txtProjectFile.Value))
IF EMPTY(lcProjectFile)
	lcProjectFile=JustStem(ALLTRIM(this.parent.txtProjectName.Value))
ENDIF
IF NOT LOWER(RIGHTC(lcProjectFile,4))==THIS.PARENT.cExt
	lcProjectFile=lcProjectFile+THIS.PARENT.cExt
ENDIF
this.parent.txtProjectFile.Value=lcDirectory+lcProjectFile

ENDPROC
PROCEDURE Refresh
this.Enabled=(NOT EMPTY(this.parent.txtProjectName.Value))

ENDPROC


************************************************************
OBJETO: chkCreateProjDir
************************************************************
*** PROPIEDADES ***
Top = 98
Left = 10
Height = 21
Width = 218
FontName = "MS Sans Serif"
FontSize = 8
Caption = "\<Create project directory structure"
Value = .T.
TabIndex = 6
Name = "chkCreateProjDir"

*** METODOS ***


************************************************************
OBJETO: _folder
************************************************************
*** PROPIEDADES ***
MS Sans Serif, 0, 8, 5, 13, 11, 11, 2, 0

*** METODOS ***


