************************************************************
OBJETO: _splash
************************************************************
*** PROPIEDADES ***
Height = 250
Width = 375
DoCreate = .T.
AutoCenter = .T.
BorderStyle = 2
Caption = ""
ControlBox = .F.
Closable = .F.
MaxButton = .F.
MinButton = .F.
Movable = .F.
nduration = 3
Name = "_splash"

*** METODOS ***
PROCEDURE Activate
THIS.PICTURE = THIS.PICTURE
LOCAL t1
t1 = SECONDS()
DO WHILE (SECONDS()- m.t1)<this.nDuration
ENDDO
THISFORM.RELEASE

ENDPROC


************************************************************
OBJETO: Label1
************************************************************
*** PROPIEDADES ***
FontBold = .T.
FontSize = 24
BackStyle = 0
Caption = "Splash Screen"
Height = 40
Left = 132
Top = 192
Width = 223
Name = "Label1"

*** METODOS ***


************************************************************
OBJETO: _splash
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 21, 3, 0

*** METODOS ***


************************************************************
OBJETO: _login
************************************************************
*** PROPIEDADES ***
DataSession = 2
ScaleMode = 3
Height = 131
Width = 224
DoCreate = .T.
AutoCenter = .T.
Caption = "Login"
HelpContextID = 10
cpassword = 
ctable = 
ctagname = 
cfieldname = 
opassword = 
Name = "_login"

*** METODOS ***
PROCEDURE setup
IF !USED(THIS.cTable)
	IF FILE(THIS.cDBFName)
	  USE (THIS.cDBFName) IN 0 AGAIN SHARED ALIAS (THIS.cTable)
	  IF EMPTY(ALIAS())
	  	* Could not open password table
	  	MESSAGEBOX(NOOPENTABLE_LOC,MB_ICONEXCLAMATION)
	  	RETURN .F.
	  ENDIF
	ENDIF
	SELECT (THIS.cTable)
ENDIF

THIS.cboName.RowSource = "SELECT " + ;
  THIS.cFieldName + ;
  " FROM " + THIS.cTable + ;
  " ORDER BY " + THIS.cFieldName + ;
  " INTO CURSOR cNames"

THIS.cboName.Requery()
GO TOP
IF _TALLY > 0
	THIS.cboName.ListIndex = 1
ELSE
	MESSAGEBOX(NOUSERS_LOC,MB_ICONEXCLAMATION)
	RETURN .F.
ENDIF

ENDPROC
PROCEDURE checkpassword
*-- Now check the password
LOCAL lcField,lcPassField

* If not Password specified, allow password thru
IF EMPTY(THIS.cPassword)
	RETURN .T.
ENDIF

SELECT (THIS.cTable)

lcPassField = ALLTRIM(EVAL(THIS.cPassword))
lcField = ALLTRIM(THIS.txtPassword.Value)
lcField = THIS.ProcessPassword(lcField)

DO CASE
CASE THIS.lCaseSensitive AND lcPassField  == lcField 
	RETURN .T.
CASE UPPER(lcPassField)  == UPPER(lcField)
	RETURN .T.
ENDCASE

RETURN .F.

ENDPROC
PROCEDURE processpassword
* This is a stub routine if you wish to add some 
* sort of encryption routine to process the password.
LPARAMETER tcPassword
RETURN tcPassword

ENDPROC
PROCEDURE QueryUnload
IF !DODEFAULT()
	RETURN .F.
ENDIF
THIS.Release()

ENDPROC
PROCEDURE Refresh
*-- Set up our workareas
LOCAL lcFieldValue
IF EMPTY(this.cTable)
	RETURN
ENDIF
SELECT (THIS.cTable)
lcFieldValue = UPPER(ALLTRIM(THIS.cboName.DisplayValue))
LOCATE FOR UPPER(ALLTRIM(EVAL(THIS.cFieldName))) == lcFieldValue

ENDPROC
PROCEDURE Unload
IF USED("cNames")
  USE IN cNames
ENDIF

IF !EMPTY(this.cTable) AND USED(this.cTable)
  USE IN (this.cTable)
ENDIF

ENDPROC
PROCEDURE Init
*-- (c) Microsoft Corporation 1995

IF EMPTY(this.cFieldName) OR EMPTY(this.cTable)
	RETURN
ENDIF

RETURN THIS.Setup()

ENDPROC
PROCEDURE Release
* If user provided a password object, let's set 
DODEFAULT()
IF VARTYPE(THIS.oPassword)="O"
	THIS.oPassword.AddProperty("lValidPassword",THIS.lValidPassword)
ENDIF

ENDPROC


************************************************************
OBJETO: cmdOk
************************************************************
*** PROPIEDADES ***
Top = 90
Left = 50
Height = 26
Width = 56
Caption = "OK"
Default = .T.
TabIndex = 3
Name = "cmdOk"

*** METODOS ***
PROCEDURE Click
IF THISFORM.CheckPassword()
	THISFORM.lValidPassword = .T.
	THISFORM.Release()
ELSE
  MESSAGEBOX(BADPASSWORD_LOC, MB_ICONEXCLAMATION)
  THISFORM.txtPassword.Value = ""
  THISFORM.txtPassword.SetFocus()
ENDIF

ENDPROC


************************************************************
OBJETO: cmdCancel
************************************************************
*** PROPIEDADES ***
Top = 90
Left = 130
Height = 26
Width = 56
Cancel = .T.
Caption = "Cancel"
Enabled = .T.
TabIndex = 4
Name = "cmdCancel"

*** METODOS ***
PROCEDURE Click
THISFORM.Release()

ENDPROC


************************************************************
OBJETO: lblName
************************************************************
*** PROPIEDADES ***
Alignment = 1
Caption = "Name"
Height = 17
Left = 9
Top = 18
Width = 87
TabIndex = 5
Name = "lblName"

*** METODOS ***


************************************************************
OBJETO: lblPswd
************************************************************
*** PROPIEDADES ***
FontSize = 9
Alignment = 1
Caption = "Password"
Height = 17
Left = 9
Top = 50
Width = 87
TabIndex = 6
Name = "lblPswd"

*** METODOS ***


************************************************************
OBJETO: txtPassword
************************************************************
*** PROPIEDADES ***
Format = "K"
Height = 24
Left = 99
TabIndex = 2
Top = 46
Width = 104
PasswordChar = "*"
Name = "txtPassword"

*** METODOS ***


************************************************************
OBJETO: cboName
************************************************************
*** PROPIEDADES ***
BoundColumn = 2
RowSourceType = 3
RowSource = ""
Height = 21
Left = 100
Style = 2
TabIndex = 1
Top = 15
Width = 106
Name = "cboName"

*** METODOS ***
PROCEDURE InteractiveChange
THISFORM.Refresh()

ENDPROC


************************************************************
OBJETO: _login
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 21, 3, 0

*** METODOS ***


************************************************************
OBJETO: _dialog
************************************************************
*** PROPIEDADES ***
DataSession = 2
Height = 172
Width = 358
DoCreate = .T.
ShowTips = .T.
AutoCenter = .T.
BorderStyle = 2
Caption = "Dialog"
FontName = "MS Sans Serif"
FontSize = 8
MaxButton = .F.
MinButton = .F.
KeyPreview = .T.
WindowType = 1
AlwaysOnTop = .T.
Name = "_dialog"

*** METODOS ***
PROCEDURE setfont
IF FONTMETRIC(1,"MS Sans Serif",8,"")#13 OR ;
		FONTMETRIC(4,"MS Sans Serif",8,"")#2 OR ;
		FONTMETRIC(6,"MS Sans Serif",8,"")#5 OR ;
		FONTMETRIC(7,"MS Sans Serif",8,"")#11
	this.lLargeFont=.T.
	this.SetAll("FontName","Arial")
	RETURN
ENDIF

ENDPROC
PROCEDURE Deactivate
ACTIVATE SCREEN
SET MESSAGE TO

ENDPROC
PROCEDURE Activate
ACTIVATE SCREEN
SET MESSAGE TO

ENDPROC
PROCEDURE QueryUnload
this.Enabled=.F.
this.Visible=.F.

ENDPROC
PROCEDURE Release
this.QueryUnload

ENDPROC
PROCEDURE KeyPress
LPARAMETERS nKeyCode, nShiftAltCtrl

IF nKeyCode=27
	this.Release
ENDIF

ENDPROC
PROCEDURE Init
SET TALK OFF
SET COMPATIBLE OFF
SET CONFIRM ON
SET EXACT OFF
SET EXCLUSIVE OFF
SET MEMOWIDTH TO 1024
SET MULTILOCKS ON
SET SAFETY OFF
WAIT CLEAR
this.SetFont

ENDPROC


************************************************************
OBJETO: _dialog
************************************************************
*** PROPIEDADES ***
MS Sans Serif, 0, 8, 5, 13, 11, 11, 2, 0

*** METODOS ***


************************************************************
OBJETO: _locateitem
************************************************************
*** PROPIEDADES ***
Height = 94
Width = 334
DoCreate = .T.
Caption = "Locate Item"
HelpContextID = 189582662
cdefaultfilename = .NULL.
cfilename = .NULL.
Name = "_locateitem"

*** METODOS ***
PROCEDURE QueryUnload
IF !DODEFAULT()
	RETURN .F.
ENDIF
THIS.RELEASE()

ENDPROC
PROCEDURE Release
DODEFAULT()
IF VARTYPE(THIS.oLocateItem)="O"
	THIS.oLocateItem.AddProperty("cFileName",THIS.cFileName)
ENDIF

ENDPROC
PROCEDURE Unload
RETURN thisform.cFileName

ENDPROC
PROCEDURE Init
#DEFINE ERR_OPENINGFILE_LOC 	[Error opening "]
#DEFINE ERR_FILENOTFOUND_LOC	[".  File not found.]
LPARAMETERS oSource,tcFileName,tlGetPicture

IF VARTYPE(oSource)="O"
	this.oLocateItem = oSource
ENDIF
IF VARTYPE(tcFileName)#"C" OR EMPTY(tcFileName)
	RETURN .F.
ENDIF
this.cDefaultFileName=LOWER(ALLTRIM(tcFileName))
this.lGetPicture=tlGetPicture
this.edtMessage.Value=ERR_OPENINGFILE_LOC + this.cDefaultFileName + ERR_FILENOTFOUND_LOC

RETURN DODEFAULT()

ENDPROC


************************************************************
OBJETO: cmdLocate
************************************************************
*** PROPIEDADES ***
Top = 63
Left = 8
Height = 23
Width = 75
FontName = "MS Sans Serif"
FontSize = 8
Caption = "\<Locate..."
Default = .T.
TabIndex = 2
Name = "cmdLocate"

*** METODOS ***
PROCEDURE Click
LOCAL lcFileName,lcFileExt

thisform.Enabled=.F.
thisform.Visible=.F.
lcFileExt=JUSTEXT(thisform.cDefaultFileName)
IF thisform.lGetPicture OR INLIST(LOWER(lcFileExt),"bmp","ico","gif","jpg","cur","msk")
	lcFileName=LOWER(GETPICT(lcFileExt))
ELSE
	lcFileName=LOWER(GETFILE(lcFileExt))
ENDIF
IF EMPTY(lcFileName)
	thisform.cFileName=thisform.cDefaultFileName
ELSE
	thisform.cFileName=lcFileName
ENDIF
thisform.Release

ENDPROC


************************************************************
OBJETO: cmdCancel
************************************************************
*** PROPIEDADES ***
Top = 63
Left = 170
Height = 23
Width = 75
FontName = "MS Sans Serif"
FontSize = 8
Cancel = .T.
Caption = "Cancel"
TabIndex = 4
Name = "cmdCancel"

*** METODOS ***
PROCEDURE Click
thisform.cFileName=.NULL.
thisform.Release

ENDPROC


************************************************************
OBJETO: cmdIgnore
************************************************************
*** PROPIEDADES ***
Top = 63
Left = 89
Height = 23
Width = 75
FontName = "MS Sans Serif"
FontSize = 8
Cancel = .T.
Caption = "\<Ignore"
TabIndex = 3
Name = "cmdIgnore"

*** METODOS ***
PROCEDURE Click
thisform.cFileName=thisform.cDefaultFileName
thisform.Release

ENDPROC


************************************************************
OBJETO: cmdHelp
************************************************************
*** PROPIEDADES ***
Top = 63
Left = 251
Height = 23
Width = 75
FontName = "MS Sans Serif"
FontSize = 8
Cancel = .T.
Caption = "\<Help"
TabIndex = 5
Name = "cmdHelp"

*** METODOS ***
PROCEDURE Click
HELP ID (thisform.HelpContextID) NOWAIT

ENDPROC


************************************************************
OBJETO: edtMessage
************************************************************
*** PROPIEDADES ***
FontName = "MS Sans Serif"
FontSize = 8
BackStyle = 0
BorderStyle = 0
Height = 45
Left = 8
ReadOnly = .T.
ScrollBars = 0
SpecialEffect = 1
TabIndex = 1
TabStop = .F.
Top = 8
Width = 317
BackColor = (thisform.BackColor)
BorderColor = (thisform.BackColor)
Name = "edtMessage"

*** METODOS ***


************************************************************
OBJETO: _locateitem
************************************************************
*** PROPIEDADES ***
MS Sans Serif, 0, 8, 5, 13, 11, 11, 2, 0

*** METODOS ***


************************************************************
OBJETO: _keywords
************************************************************
*** PROPIEDADES ***
Height = 223
Width = 403
DoCreate = .T.
Caption = "Keywords"
HelpContextID = 189582656
ckeywords = 
clastvalue = 
cdbfname = (HOME()+"Gallery\KEYWORDS.DBF")
Name = "_keywords"

*** METODOS ***
PROCEDURE apply
LOCAL lnKeywordCount,lnCount,lcKeyword,lcKeywords
LOCAL ARRAY laKeywords[1]

this.Hide
WITH this.cntSuperMover
	IF this.lUpdated
		SET MESSAGE TO M_UPDATING_KEYWORDS_LOC+" ..."
		lnKeywordCount=ALEN(.aChoices)
		DIMENSION laKeywords[lnKeywordCount]
		laKeywords=""
		ACOPY(.aChoices,laKeywords)
		FOR lnCount = 1 TO ALEN(.aSelections,1)
			lcKeyword=.aSelections[lnCount,1]
			IF EMPTY(lcKeyword)
				LOOP
			ENDIF
			lnKeywordCount=lnKeywordCount+1
			DIMENSION laKeywords[lnKeywordCount]
			laKeywords[lnKeywordCount]=ALLTRIM(lcKeyword)
		ENDFOR
		ASORT(laKeywords)
		SELECT keywords
		REPLACE ALL Keyword WITH ""
		DELETE ALL
		LOCATE
		FOR lnCount = 1 TO ALEN(laKeywords)
			lcKeyword=ALLTRIM(laKeywords[lnCount])
			IF lnCount>RECCOUNT()
				APPEND BLANK
			ELSE
				GO lnCount
			ENDIF
			REPLACE Keyword WITH lcKeyword
			RECALL
		ENDFOR
		SELECT 0
		SET MESSAGE TO
	ENDIF
	lnKeywordCount=ALEN(.aSelections,1)
	IF lnKeywordCount=0 OR EMPTY(.aSelections[1,1])
		this.Release
		RETURN
	ENDIF
	lcKeywords=""
	FOR lnCount = 1 TO lnKeywordCount
		lcKeywords=ALLTRIM(lcKeywords+" "+ALLTRIM(.aSelections[lnCount,1]))
	ENDFOR
ENDWITH
this.cKeywords=lcKeywords
this.Release

ENDPROC
PROCEDURE initialize
LOCAL lnCount
LOCAL laKeywords[1]

IF EMPTY(THIS.cDBFName) OR !FILE(THIS.cDBFName)
	RETURN .F.
ENDIF
USE (THIS.cDBFName) AGAIN SHARED ALIAS "keywords"
IF EMPTY(ALIAS())
	RETURN .F.
ENDIF
DIMENSION laKeywords[1]
laKeywords=""
SELECT keywords
lnCount=0
SCAN ALL FOR NOT DELETED()
	lnCount=lnCount+1
	DIMENSION laKeywords[lnCount]
	laKeywords[lnCount]=ALLTRIM(Keyword)
ENDSCAN
this.cntSuperMover.InitChoices(@laKeywords)

ENDPROC
PROCEDURE Release
DODEFAULT()
IF VARTYPE(THIS.oKeywords)="O"
	THIS.oKeywords.AddProperty("cKeywords",THIS.cKeywords)
ENDIF

ENDPROC
PROCEDURE QueryUnload
IF !DODEFAULT()
	RETURN .F.
ENDIF
THIS.Release()
ENDPROC
PROCEDURE Init
IF !DODEFAULT() OR !THIS.Initialize()
	RETURN .F.
ENDIF

ENDPROC
PROCEDURE Unload
RETURN this.cKeywords

ENDPROC


************************************************************
OBJETO: cmdOK
************************************************************
*** PROPIEDADES ***
Top = 188
Left = 240
Height = 23
Width = 75
FontName = "MS Sans Serif"
FontSize = 8
Caption = "OK"
Default = .T.
TabIndex = 7
Name = "cmdOK"

*** METODOS ***
PROCEDURE Click
thisform.Apply

ENDPROC


************************************************************
OBJETO: cmdCancel
************************************************************
*** PROPIEDADES ***
Top = 188
Left = 320
Height = 23
Width = 75
FontName = "MS Sans Serif"
FontSize = 8
Cancel = .T.
Caption = "Cancel"
TabIndex = 8
Name = "cmdCancel"

*** METODOS ***
PROCEDURE Click
thisform.Release

ENDPROC


************************************************************
OBJETO: txtKeyword
************************************************************
*** PROPIEDADES ***
FontName = "MS Sans Serif"
FontSize = 8
Enabled = .F.
Format = "K"
Height = 23
InputMask = (REPLICATE("X",30))
Left = 227
TabIndex = 6
Top = 157
Width = 168
Name = "txtKeyword"

*** METODOS ***
PROCEDURE InteractiveChange
IF this.parent.cmdAdd.Enabled
	this.parent.cmdAdd.Enabled=.F.
ENDIF
IF this.parent.cmdRemove.Enabled
	this.parent.cmdRemove.Enabled=.F.
ENDIF
IF NOT this.parent.cmdScratch.Enabled
	this.parent.cmdScratch.Enabled=.T.
ENDIF
IF NOT this.parent.cmdEnter.Enabled
	this.parent.cmdEnter.Enabled=.T.
ENDIF

ENDPROC
PROCEDURE LostFocus
this.parent.cmdAdd.Enabled=.T.
this.parent.cmdRemove.Enabled=.T.

ENDPROC


************************************************************
OBJETO: cmdRemove
************************************************************
*** PROPIEDADES ***
Top = 157
Left = 89
Height = 23
Width = 75
FontName = "MS Sans Serif"
FontSize = 8
Caption = "\<Remove"
TabIndex = 3
Name = "cmdRemove"

*** METODOS ***
PROCEDURE Click
LOCAL lcValue,lnListIndex,lnItemID,lnKeywordCount

lnListIndex=this.parent.cntSuperMover.lstLeft.ListIndex
IF lnListIndex<1
	RETURN
ENDIF
lcValue=this.parent.cntSuperMover.lstLeft.Value
IF MESSAGEBOX(M_REMOVE_KEYWORD_LOC+[ "]+lcValue+["?],292,thisform.Caption)#6
	RETURN
ENDIF
thisform.lUpdated=.T.
WITH this.parent.cntSuperMover
	lnItemID=.lstLeft.IndexToItemID(lnListIndex)
	lnKeywordCount=ALEN(.aChoices)
	IF lnKeywordCount>=2
		ADEL(.aChoices,lnItemID)
		DIMENSION .aChoices[lnKeywordCount-1]
	ELSE
		DIMENSION .aChoices[1]
		.aChoices=""
	ENDIF
	.lstLeft.Refresh
	.lstLeft.SetFocus
ENDWITH

ENDPROC


************************************************************
OBJETO: cmdAdd
************************************************************
*** PROPIEDADES ***
Top = 157
Left = 8
Height = 23
Width = 75
FontName = "MS Sans Serif"
FontSize = 8
Caption = "\<Add"
TabIndex = 2
Name = "cmdAdd"

*** METODOS ***
PROCEDURE Click
thisform.lAddMode=.T.
thisform.cLastValue=""
WITH this.parent.txtKeyword
	.Value=""
	.Enabled=.T.
	.Refresh
	.InteractiveChange
	.SetFocus
ENDWITH

ENDPROC


************************************************************
OBJETO: cmdScratch
************************************************************
*** PROPIEDADES ***
Top = 157
Left = 180
Height = 23
Width = 22
FontName = "MS Sans Serif"
FontSize = 8
Picture = graphics\_cancel.bmp
Caption = ""
Enabled = .F.
TabIndex = 4
ForeColor = 128,0,0
Name = "cmdScratch"

*** METODOS ***
PROCEDURE Click
this.parent.cmdEnter.Enabled=.F.
this.Enabled=.F.
thisform.lAddMode=.F.
this.parent.cmdAdd.Enabled=.T.
this.parent.cmdRemove.Enabled=.T.
WITH this.parent.cntSuperMover.lstLeft
	.Refresh
	.SetFocus
ENDWITH

ENDPROC


************************************************************
OBJETO: cmdEnter
************************************************************
*** PROPIEDADES ***
Top = 157
Left = 202
Height = 23
Width = 22
FontName = "MS Sans Serif"
FontSize = 8
Picture = graphics\_save.bmp
Caption = ""
Enabled = .F.
TabIndex = 5
ForeColor = 0,128,0
Name = "cmdEnter"

*** METODOS ***
PROCEDURE Click
LOCAL lcValue,llAddMode,lnListIndex,lnItemID,lnCount,lnMatchCount

lcValue=ALLTRIM(this.parent.txtKeyword.Value)
llAddMode=thisform.lAddMode
this.parent.cmdAdd.Enabled=.T.
this.parent.cmdRemove.Enabled=.T.
IF EMPTY(lcValue) OR (NOT llAddMode AND LOWER(lcValue)==LOWER(thisform.cLastValue))
	this.parent.cmdScratch.Enabled=.F.
	thisform.lAddMode=.F.
	thisform.lUpdated=.T.
	this.Enabled=.F.
	WITH this.parent.cntSuperMover.lstLeft
		.Refresh
		.SetFocus
	ENDWITH
	RETURN
ENDIF
IF NOT EMPTY(lcValue)
	IF " "$lcValue
		MESSAGEBOX(M_KEYWORDS_NO_SPACES_LOC+".",16,thisform.Caption)
		this.parent.txtKeyword.SetFocus
		RETURN .F.
	ENDIF
	lnMatchCount=0
	WITH this.parent.cntSuperMover
		FOR lnCount = 1 TO ALEN(.aChoices)
			IF LOWER(.aChoices[lnCount])==LOWER(lcValue)
				lnMatchCount=lnMatchCount+1
			ENDIF
		ENDFOR
	ENDWITH
ENDIF
IF lnMatchCount>0
	MESSAGEBOX(M_KEYWORD_LOC+[ "]+lcValue+[" ]+M_ALREADY_EXISTS_LOC+".", ;
			16,thisform.Caption)
	this.parent.txtKeyword.SetFocus
	RETURN .F.
ENDIF
WITH this.parent.cntSuperMover
	lnListIndex=.lstLeft.ListIndex
	IF llAddMode
		lnListIndex=ALEN(.aChoices)+1
		lnItemID=lnListIndex
		DIMENSION .aChoices[lnListIndex]
		.aChoices[lnItemID]=lcValue
	ELSE
		lnItemID=.lstLeft.IndexToItemID(lnListIndex)
		.aChoices[lnItemID]=lcValue
	ENDIF
	ASORT(.aChoices)
	.lstLeft.Refresh
	lnListIndex=-1
	FOR lnCount = 1 TO ALEN(.aChoices)
		IF LOWER(.aChoices[lnCount])==LOWER(lcValue)
			lnListIndex=lnCount
			EXIT
		ENDIF
	ENDFOR
	.lstLeft.ListIndex=lnListIndex
	.lstLeft.TopIndex=lnListIndex
	.lstLeft.SetFocus
ENDWITH
thisform.lAddMode=.F.
thisform.lUpdated=.T.
this.parent.cmdScratch.Enabled=.F.
this.Enabled=.F.
WITH this.parent.cntSuperMover.lstLeft
	.Refresh
	.SetFocus
ENDWITH

ENDPROC


************************************************************
OBJETO: cntSuperMover
************************************************************
*** PROPIEDADES ***
Top = 12
Left = 8
Width = 387
Height = 125
TabIndex = 1
Name = "cntSuperMover"
lstLeft.FontName = "MS Sans Serif"
lstLeft.FontSize = 8
lstLeft.Height = 109
lstLeft.Left = 0
lstLeft.Top = 15
lstLeft.Width = 168
lstLeft.Name = "lstLeft"
cmdAdd.Top = 24
cmdAdd.Left = 182
cmdAdd.FontName = "MS Sans Serif"
cmdAdd.FontSize = 8
cmdAdd.Name = "cmdAdd"
cmdRemove.Top = 70
cmdRemove.Left = 182
cmdRemove.FontName = "MS Sans Serif"
cmdRemove.FontSize = 8
cmdRemove.Name = "cmdRemove"
lstRight.FontName = "MS Sans Serif"
lstRight.FontSize = 8
lstRight.Height = 109
lstRight.Left = 219
lstRight.Top = 15
lstRight.Width = 168
lstRight.Name = "lstRight"
LABEL1.AutoSize = .T.
LABEL1.FontName = "MS Sans Serif"
LABEL1.FontSize = 8
LABEL1.Caption = "A\<vailable keywords:"
LABEL1.Left = 0
LABEL1.Top = 0
LABEL1.Name = "LABEL1"
LABEL2.AutoSize = .T.
LABEL2.FontName = "MS Sans Serif"
LABEL2.FontSize = 8
LABEL2.Caption = "\<Selected keywords:"
LABEL2.Left = 219
LABEL2.Top = 0
LABEL2.Name = "LABEL2"
cmdAddAll.Top = 47
cmdAddAll.Left = 182
cmdAddAll.FontName = "MS Sans Serif"
cmdAddAll.FontSize = 8
cmdAddAll.Name = "cmdAddAll"
cmdRemoveAll.Top = 93
cmdRemoveAll.Left = 182
cmdRemoveAll.FontName = "MS Sans Serif"
cmdRemoveAll.FontSize = 8
cmdRemoveAll.Name = "cmdRemoveAll"

*** METODOS ***
PROCEDURE lstLeft.InteractiveChange
DODEFAULT()
this.Refresh

ENDPROC
PROCEDURE lstLeft.Refresh
LOCAL lcValue

DODEFAULT()
thisform.lAddMode=.F.
lcValue=IIF(this.ListIndex>=1,ALLTRIM(this.Value),"")
IF this.ListCount<1 OR EMPTY(lcValue)
	this.ListIndex=-1
ENDIF
thisform.cLastValue=lcValue
WITH this.parent.parent.txtKeyword
	.Value=lcValue
	.Enabled=(NOT EMPTY(lcValue))
ENDWITH

ENDPROC


************************************************************
OBJETO: linRule1
************************************************************
*** PROPIEDADES ***
Height = 0
Left = 8
Top = 146
Width = 388
Name = "linRule1"

*** METODOS ***


************************************************************
OBJETO: linRule2
************************************************************
*** PROPIEDADES ***
Height = 0
Left = 8
Top = 147
Width = 388
BorderColor = 255,255,255
Name = "linRule2"

*** METODOS ***


************************************************************
OBJETO: _keywords
************************************************************
*** PROPIEDADES ***
MS Sans Serif, 0, 8, 5, 13, 11, 11, 2, 0

*** METODOS ***


************************************************************
OBJETO: _msgbox
************************************************************
*** PROPIEDADES ***
Height = 23
Width = 24
cmessage = 
ntype = 48
ctitle = (_screen.Caption)
builderx = (HOME()+"Wizards\BuilderD,BuilderDForm")
Name = "_msgbox"

*** METODOS ***
PROCEDURE show
LPARAMETERS tcMessage,tnType,tcTitle,tlBeep

this.Set(tcMessage,tnType,tcTitle,tlBeep,PCOUNT())
IF this.lBeep
	?? CHR(7)
ENDIF
RETURN this.Display()

ENDPROC
PROCEDURE set
LPARAMETERS tcMessage,tnType,tcTitle,tlBeep,tnParameters
LOCAL lnParameters

lnParameters=IIF(TYPE("tnParameters")=="N",tnParameters,PCOUNT())
IF lnParameters<1
	RETURN
ENDIF
IF TYPE("tcMessage")=="C"
	this.cMessage=tcMessage
ENDIF
IF lnParameters<2
	RETURN
ENDIF
IF TYPE("tnType")=="N"
	this.nType=tnType
ENDIF
IF lnParameters<3
	RETURN
ENDIF
IF TYPE("tcTitle")=="C"
	this.cTitle=tcTitle
ENDIF
IF lnParameters<4
	RETURN
ENDIF
IF TYPE("tlBeep")=="L"
	this.lBeep=tlBeep
ENDIF

ENDPROC
PROCEDURE display
RETURN MESSAGEBOX(this.cMessage,this.nType,this.cTitle)

ENDPROC
PROCEDURE Init
LPARAMETERS tcMessage,tnType,tcTitle,tlBeep

this.Set(tcMessage,tnType,tcTitle,tlBeep,PCOUNT())

ENDPROC


************************************************************
OBJETO: _aboutbox
************************************************************
*** PROPIEDADES ***
Height = 319
Width = 374
DoCreate = .T.
AutoCenter = .T.
BorderStyle = 2
Caption = "About Custom Application"
FontSize = 8
MaxButton = .F.
MinButton = .F.
MinWidth = 1
WindowType = 1
AlwaysOnTop = .T.
cmsinfodir = 
Name = "_aboutbox"

*** METODOS ***
PROCEDURE getregisteredowner
* This is a stub for your routine to obtain registered user name.
RETURN thisform.lblUserName.Caption
ENDPROC
PROCEDURE getregisteredcompany
* This is a stub for your routine to obtain registered corporation name.
RETURN thisform.lblUserCorp.Caption
ENDPROC
PROCEDURE Unload
SET MESSAGE TO
ENDPROC
PROCEDURE Init
*-- (c) Microsoft Corporation 1995
LPARAMETERS tcAppName, tcVersion, tcCopyright, tcTrademark, tcLogoBMP

LOCAL lnError,lcMSINFO

*-- Set new property values if parameters do not contain .F.
IF TYPE("tcAppName") = "C"
  thisform.Caption = ABOUT_LOC + ALLTRIM(tcAppName)
  thisform.lblAppName.Caption = ALLTRIM(tcAppName)
ENDIF    

IF TYPE("tcVersion") = "C"
  thisform.lblVersion.Caption = VERSIONLABEL_LOC + ALLTRIM(tcVersion)
ENDIF  

IF TYPE("tcCopyright") = "C"    
  thisform.lblCopyright.Caption = ALLTRIM(tcCopyright)
ENDIF  

IF TYPE("tcTrademark") = "C"    
  thisform.lblTrademark.Caption = tcTrademark
  thisform.lblTrademark.WordWrap = 1
ENDIF  

IF TYPE("tcLogoBMP") = "C"
  thisform.imgLogo.Picture = tcLogoBMP
ENDIF

thisform.lblUserName.Caption = THIS.GetRegisteredOwner()
thisform.lblUserCorp.Caption = THIS.GetRegisteredCompany()

lcMSINFO = ""
lnError = THIS.Registry.GetRegKey("Path",@lcMSINFO,KEY_WIN4_MSINFO,HKEY_LOCAL_MACHINE)
IF lnError = 0
	thisform.cMSInfoDir=lcMSINFO
ENDIF

*-- Check if MSINFO.EXE exists, otherwise remove the System Info command button and
*-- shorten the form
IF EMPTY(thisform.cMSInfoDir)
    thisform.cMSInfoDir = " "
    thisform.cmdSysInfo.Enabled = .F.
    thisform.Height = 282
ENDIF

ENDPROC
PROCEDURE Activate
SET MESSAGE TO thisform.Caption
ENDPROC


************************************************************
OBJETO: imgLogo
************************************************************
*** PROPIEDADES ***
Stretch = 1
BackStyle = 0
Height = 111
Left = 10
Top = 11
Width = 100
Name = "imgLogo"

*** METODOS ***


************************************************************
OBJETO: lblAppName
************************************************************
*** PROPIEDADES ***
FontSize = 8
BackStyle = 0
Caption = "Your application name"
Height = 14
Left = 120
Top = 17
Width = 233
TabIndex = 1
Name = "lblAppName"

*** METODOS ***


************************************************************
OBJETO: lblVersion
************************************************************
*** PROPIEDADES ***
FontSize = 8
BackStyle = 0
Caption = "Version #"
Height = 16
Left = 120
Top = 35
Width = 233
TabIndex = 2
Name = "lblVersion"

*** METODOS ***


************************************************************
OBJETO: lblTrademark
************************************************************
*** PROPIEDADES ***
FontBold = .F.
FontSize = 8
BackStyle = 0
Caption = "Trademark Information"
Height = 19
Left = 120
Top = 75
Width = 233
TabIndex = 3
Name = "lblTrademark"

*** METODOS ***


************************************************************
OBJETO: lblLicense
************************************************************
*** PROPIEDADES ***
FontSize = 8
BackStyle = 0
Caption = "This product is licensed to:"
Height = 16
Left = 120
Top = 152
Width = 234
TabIndex = 4
Name = "lblLicense"

*** METODOS ***


************************************************************
OBJETO: shpRectangle
************************************************************
*** PROPIEDADES ***
Top = 169
Left = 119
Height = 60
Width = 252
SpecialEffect = 0
Name = "shpRectangle"

*** METODOS ***


************************************************************
OBJETO: lblUserName
************************************************************
*** PROPIEDADES ***
FontBold = .F.
FontSize = 8
BackStyle = 0
Caption = "Registered Owner"
Height = 25
Left = 130
Top = 181
Width = 205
TabIndex = 5
Name = "lblUserName"

*** METODOS ***


************************************************************
OBJETO: lblUserCorp
************************************************************
*** PROPIEDADES ***
FontBold = .F.
FontSize = 8
BackStyle = 0
Caption = "Registered Company "
Height = 25
Left = 130
Top = 202
Width = 205
TabIndex = 6
Name = "lblUserCorp"

*** METODOS ***


************************************************************
OBJETO: cmdOK
************************************************************
*** PROPIEDADES ***
Top = 252
Left = 269
Height = 25
Width = 100
FontSize = 8
Caption = "OK"
Default = .T.
TabIndex = 1
Name = "cmdOK"

*** METODOS ***
PROCEDURE Click
RELEASE thisform


ENDPROC


************************************************************
OBJETO: cmdSysInfo
************************************************************
*** PROPIEDADES ***
Top = 283
Left = 269
Height = 25
Width = 100
FontSize = 8
Caption = "\<System Info..."
TabIndex = 2
Name = "cmdSysInfo"

*** METODOS ***
PROCEDURE Click
LOCAL lcMSInfoWinDir
lcMSInfoWinDir= thisform.cMSInfoDir
RUN/N1 &lcMSInfoWinDir


ENDPROC


************************************************************
OBJETO: lblCopyright
************************************************************
*** PROPIEDADES ***
FontSize = 8
BackStyle = 0
Caption = "Copyright Information"
Height = 16
Left = 120
Top = 55
Width = 233
TabIndex = 3
Name = "lblCopyright"

*** METODOS ***


************************************************************
OBJETO: linWhiteShadow
************************************************************
*** PROPIEDADES ***
BorderStyle = 1
BorderWidth = 2
Height = 1
Left = 1
Top = 241
Width = 375
BorderColor = 255,255,255
Name = "linWhiteShadow"

*** METODOS ***


************************************************************
OBJETO: linBlackVertical
************************************************************
*** PROPIEDADES ***
Height = 0
Left = 0
Top = 240
Width = 376
BorderColor = 0,0,0
Name = "linBlackVertical"

*** METODOS ***


************************************************************
OBJETO: Registry
************************************************************
*** PROPIEDADES ***
Top = 276
Left = 24
Height = 17
Width = 36
Name = "Registry"

*** METODOS ***


************************************************************
OBJETO: _aboutbox
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 30, 3, 0

*** METODOS ***


