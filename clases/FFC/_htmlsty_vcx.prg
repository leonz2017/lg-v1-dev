************************************************************
OBJETO: _datasource
************************************************************
*** PROPIEDADES ***
Height = 220
Width = 171
DoCreate = .T.
AutoCenter = .T.
BorderStyle = 2
Caption = "Pick Datasource"
MaxButton = .F.
MinButton = .F.
WindowType = 1
Name = "_datasource"

*** METODOS ***
PROCEDURE savesettings
THIS._TableMover.lstTables.InteractiveChange()	&& ensure data is updated
THIS.oSettings.cAlias=THIS._tablemover.CurrentAlias
THIS.oSettings.cDatabase=THIS._tablemover.CurrentDBC
THIS.oSettings.cDbcTable=THIS._tablemover.dbctable

ENDPROC
PROCEDURE Init
IF fontmetric(1, 'MS Sans Serif', 8, '') <> 13 .or. ;
	fontmetric(4, 'MS Sans Serif', 8, '') <> 2 .or. ;
	fontmetric(6, 'MS Sans Serif', 8, '') <> 5 .or. ;
	fontmetric(7, 'MS Sans Serif', 8, '') <> 11
	THIS.SetAll('FontName', 'Arial')
ENDIF

ENDPROC


************************************************************
OBJETO: _tablemover
************************************************************
*** PROPIEDADES ***
Top = 36
Left = 12
Width = 150
Height = 140
TabIndex = 2
excldbf = ((HOME()+"genhtml.dbf"))
allowviews = (.F.)
Name = "_tablemover"
lstLeft.FontName = "MS Sans Serif"
lstLeft.FontSize = 8
lstLeft.Enabled = .F.
lstLeft.Height = 20
lstLeft.Left = 192
lstLeft.Top = 48
lstLeft.Visible = .F.
lstLeft.Width = 24
lstLeft.Name = "lstLeft"
cmdAdd.Top = 24
cmdAdd.Left = 216
cmdAdd.FontName = "MS Sans Serif"
cmdAdd.FontSize = 8
cmdAdd.Enabled = .F.
cmdAdd.Visible = .F.
cmdAdd.Name = "cmdAdd"
cmdRemove.Top = 72
cmdRemove.Left = 216
cmdRemove.FontName = "MS Sans Serif"
cmdRemove.FontSize = 8
cmdRemove.Enabled = .F.
cmdRemove.Visible = .F.
cmdRemove.Name = "cmdRemove"
lstRight.FontName = "MS Sans Serif"
lstRight.FontSize = 8
lstRight.Enabled = .F.
lstRight.Height = 24
lstRight.Left = 192
lstRight.Top = 72
lstRight.Visible = .F.
lstRight.Width = 24
lstRight.Name = "lstRight"
Label1.FontName = "MS Sans Serif"
Label1.FontSize = 8
Label1.Enabled = .F.
Label1.Height = 14
Label1.Left = 192
Label1.Top = 12
Label1.Visible = .F.
Label1.Width = 24
Label1.Name = "Label1"
Label2.FontName = "MS Sans Serif"
Label2.FontSize = 8
Label2.Enabled = .F.
Label2.Height = 14
Label2.Left = 192
Label2.Top = 24
Label2.Visible = .F.
Label2.Width = 24
Label2.Name = "Label2"
cmdAddAll.Top = 48
cmdAddAll.Left = 216
cmdAddAll.FontName = "MS Sans Serif"
cmdAddAll.FontSize = 8
cmdAddAll.Enabled = .F.
cmdAddAll.Visible = .F.
cmdAddAll.Name = "cmdAddAll"
cmdRemoveAll.Top = 96
cmdRemoveAll.Left = 216
cmdRemoveAll.FontName = "MS Sans Serif"
cmdRemoveAll.FontSize = 8
cmdRemoveAll.Enabled = .F.
cmdRemoveAll.Visible = .F.
cmdRemoveAll.Name = "cmdRemoveAll"
cboData.FontName = "MS Sans Serif"
cboData.FontSize = 8
cboData.Name = "cboData"
lstTables.FontName = "MS Sans Serif"
lstTables.FontSize = 8
lstTables.Width = 148
lstTables.Name = "lstTables"
Label3.FontName = "MS Sans Serif"
Label3.FontSize = 8
Label3.Name = "Label3"
cmdOpen.Top = 17
cmdOpen.Left = 125
cmdOpen.FontName = "MS Sans Serif"
cmdOpen.FontSize = 8
cmdOpen.Name = "cmdOpen"

*** METODOS ***


************************************************************
OBJETO: Label1
************************************************************
*** PROPIEDADES ***
AutoSize = .T.
FontName = "MS Sans Serif"
FontSize = 8
WordWrap = .T.
Caption = "Select a datasource."
Height = 15
Left = 12
Top = 12
Width = 98
TabIndex = 1
Name = "Label1"

*** METODOS ***


************************************************************
OBJETO: cmdOK
************************************************************
*** PROPIEDADES ***
Top = 186
Left = 12
Height = 23
Width = 72
FontName = "MS Sans Serif"
FontSize = 8
Caption = "OK"
Default = .F.
TabIndex = 3
Name = "cmdOK"

*** METODOS ***
PROCEDURE Click
THISFORM.SaveSettings()
THISFORM.Release()

ENDPROC


************************************************************
OBJETO: cmdCancel
************************************************************
*** PROPIEDADES ***
Top = 186
Left = 90
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
THISFORM.Release()

ENDPROC


************************************************************
OBJETO: _datasource
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 21, 3, 0
MS Sans Serif, 0, 8, 5, 13, 11, 11, 2, 0

*** METODOS ***


************************************************************
OBJETO: _tabdetailoptions
************************************************************
*** PROPIEDADES ***
DoCreate = .T.
Name = "_tabdetailoptions"
cmdOK.ZOrderSet = 2
cmdOK.Name = "cmdOK"
cmdCancel.ZOrderSet = 3
cmdCancel.Name = "cmdCancel"
cmdReset.Name = "cmdReset"
Label1.Left = 14
Label1.Top = 12
Label1.ZOrderSet = 4
Label1.Name = "Label1"
pf1.ErasePage = .T.
pf1.pg1.cboBorderColor.Name = "cboBorderColor"
pf1.pg1.Label2.Name = "Label2"
pf1.pg1.cboBackColor.Name = "cboBackColor"
pf1.pg1.Label3.Name = "Label3"
pf1.pg1.Label4.Name = "Label4"
pf1.pg1.Label5.Name = "Label5"
pf1.pg1.spnBorder.Name = "spnBorder"
pf1.pg1.txtImage.Name = "txtImage"
pf1.pg1.cmdImage.Name = "cmdImage"
pf1.pg1.Enabled = .F.
pf1.pg1.PageOrder = 3
pf1.pg1.Name = "pg1"
pf1.pg2.Label5.Name = "Label5"
pf1.pg2.txtFont.Name = "txtFont"
pf1.pg2.cmdFont.Name = "cmdFont"
pf1.pg2.label22.Name = "label22"
pf1.pg2.CboForecolor.Name = "CboForecolor"
pf1.pg2.Label13.Name = "Label13"
pf1.pg2.spnFontSize.Name = "spnFontSize"
pf1.pg2.PageOrder = 1
pf1.pg2.Name = "pg2"
pf1.pg3.Label5.Name = "Label5"
pf1.pg3.txtClass.Name = "txtClass"
pf1.pg3.PageOrder = 2
pf1.pg3.Name = "pg3"
pf1.ZOrderSet = 0
pf1.Name = "pf1"

*** METODOS ***
PROCEDURE Init
DoDefault()
THIS.Pf1.Pg1.Enabled = .F.
ENDPROC


************************************************************
OBJETO: _tabdetailoptions
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 21, 3, 0
MS Sans Serif, 0, 8, 5, 13, 11, 11, 2, 0

*** METODOS ***


************************************************************
OBJETO: getfontname
************************************************************
*** PROPIEDADES ***
Height = 83
Width = 346
DoCreate = .T.
AutoCenter = .T.
BorderStyle = 2
Caption = "Pick Font"
MaxButton = .F.
MinButton = .F.
WindowType = 1
cfontnamevar = 
Name = "getfontname"

*** METODOS ***
PROCEDURE savesettings
LOCAL lcFontVar
IF !EMPTY(THIS.cFontNameVar)
	lcFontVar=THIS.cFontNameVar
	&lcFontVar. = THIS.cboFonts.value
ENDIF

ENDPROC
PROCEDURE Init
LPARAMETERS tcFontNameVar
LOCAL aGetFonts,i

IF VARTYPE(tcFontNameVar)="C"
	THIS.cFontNameVar=tcFontNameVar
ENDIF

if fontmetric(1, 'MS Sans Serif', 8, '') <> 13 .or. ;
	fontmetric(4, 'MS Sans Serif', 8, '') <> 2 .or. ;
	fontmetric(6, 'MS Sans Serif', 8, '') <> 5 .or. ;
	fontmetric(7, 'MS Sans Serif', 8, '') <> 11
	this.SetAll('FontName', 'Arial')
endif

DIMENSION agetfonts[1]
AFONT(agetfonts)
FOR i = 1 TO ALEN(agetfonts)
	THIS.cboFonts.AddItem(agetfonts[m.i])
ENDFOR
THIS.cboFonts.Value = THIS.cboFonts.List[1]
THIS.txtSample.DisabledForeColor = THIS.cboFonts.ForeColor
THIS.txtSample.FontName = THIS.cboFonts.List[1]

ENDPROC


************************************************************
OBJETO: cmdDone
************************************************************
*** PROPIEDADES ***
Top = 12
Left = 264
Height = 23
Width = 72
Caption = "OK"
Default = .T.
TabIndex = 2
Name = "cmdDone"

*** METODOS ***
PROCEDURE Click
THISFORM.SaveSettings()
THISFORM.Release()

ENDPROC


************************************************************
OBJETO: cmdCancel
************************************************************
*** PROPIEDADES ***
Top = 38
Left = 264
Height = 23
Width = 72
Cancel = .T.
Caption = "Cancel"
TabIndex = 3
Name = "cmdCancel"

*** METODOS ***
PROCEDURE Click
THISFORM.Release()

ENDPROC


************************************************************
OBJETO: txtSample
************************************************************
*** PROPIEDADES ***
FontName = "MS Sans Serif"
FontSize = 10
Value = AaBbYyZz
Enabled = .F.
Height = 24
Left = 12
TabIndex = 4
Top = 48
Width = 240
Name = "txtSample"

*** METODOS ***


************************************************************
OBJETO: cboFonts
************************************************************
*** PROPIEDADES ***
FontName = "MS Sans Serif"
FontSize = 8
Height = 24
Left = 12
Style = 2
TabIndex = 1
Top = 12
Width = 240
Name = "cboFonts"

*** METODOS ***
PROCEDURE InteractiveChange
THIS.Parent.txtSample.FontName = THIS.Value

ENDPROC


************************************************************
OBJETO: getfontname
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 21, 3, 0
MS Sans Serif, 0, 8, 5, 13, 11, 11, 2, 0
MS Sans Serif, 0, 10, 7, 16, 13, 14, 3, 0

*** METODOS ***


************************************************************
OBJETO: _cbocolors
************************************************************
*** PROPIEDADES ***
Height = 24
Margin = 2
Style = 2
Width = 150
ItemTips = .T.
Name = "_cbocolors"

*** METODOS ***
PROCEDURE color_access
IF THIS.ListIndex < 2
	RETURN ""
ELSE
	RETURN THIS.aColors[THIS.ListIndex-1,2]
ENDIF

ENDPROC
PROCEDURE color_assign
LPARAMETERS vNewVal
LOCAL i
IF EMPTY(vNewVal)
	THIS.Value = THIS.List[1]
ELSE
	FOR i = 1 TO ALEN(THIS.aColors,1)
		IF UPPER(vNewVal)==UPPER(THIS.aColors[m.i,2])
			THIS.Value = THIS.aColors[m.i,1]
		ENDIF
	ENDFOR
ENDIF
ENDPROC
PROCEDURE Init
LOCAL lcBMPPath

* Colors
#DEFINE DEFCOLOR	"Default"
#DEFINE BLACK	"Black"
#DEFINE MAROOM	"Maroon"
#DEFINE GREEN	"Green"
#DEFINE OLIVE	"Olive"
#DEFINE NAVY	"Navy"
#DEFINE PURPLE	"Purple"
#DEFINE TEAL	"Teal"
#DEFINE GRAY	"Gray"
#DEFINE SILVER	"Silver"
#DEFINE RED		"Red"
#DEFINE LIME	"Lime"
#DEFINE YELLOW	"Yellow"
#DEFINE BLUE	"Blue"
#DEFINE FUCHSIA	"Fuchsia"
#DEFINE AQUA	"Aqua"
#DEFINE WHITE	"White"

* Used for localization.
#DEFINE DEFCOLOR_LOC	"Default"
#DEFINE BLACK_LOC	"Black"
#DEFINE MAROOM_LOC	"Maroon"
#DEFINE GREEN_LOC	"Green"
#DEFINE OLIVE_LOC	"Olive"
#DEFINE NAVY_LOC	"Navy"
#DEFINE PURPLE_LOC	"Purple"
#DEFINE TEAL_LOC	"Teal"
#DEFINE GRAY_LOC	"Gray"
#DEFINE SILVER_LOC	"Silver"
#DEFINE RED_LOC		"Red"
#DEFINE LIME_LOC	"Lime"
#DEFINE YELLOW_LOC	"Yellow"
#DEFINE BLUE_LOC	"Blue"
#DEFINE FUCHSIA_LOC	"Fuchsia"
#DEFINE AQUA_LOC	"Aqua"
#DEFINE WHITE_LOC	"White"

LOCAL i
DIMENSION THIS.aColors[16,2]
THIS.aColors[1,1] = BLACK_LOC
THIS.aColors[1,2] = BLACK
THIS.aColors[2,1] = MAROOM_LOC
THIS.aColors[2,2] = MAROOM
THIS.aColors[3,1] = GREEN_LOC
THIS.aColors[3,2] = GREEN
THIS.aColors[4,1] = OLIVE_LOC
THIS.aColors[4,2] = OLIVE
THIS.aColors[5,1] = NAVY_LOC
THIS.aColors[5,2] = NAVY
THIS.aColors[6,1] = PURPLE_LOC
THIS.aColors[6,2] = PURPLE
THIS.aColors[7,1] = TEAL_LOC
THIS.aColors[7,2] = TEAL
THIS.aColors[8,1] = GRAY_LOC
THIS.aColors[8,2] = GRAY
THIS.aColors[9,1] = SILVER_LOC
THIS.aColors[9,2] = SILVER
THIS.aColors[10,1] = RED_LOC
THIS.aColors[10,2] = RED
THIS.aColors[11,1] = LIME_LOC
THIS.aColors[11,2] = LIME
THIS.aColors[12,1] = YELLOW_LOC
THIS.aColors[12,2] = YELLOW
THIS.aColors[13,1] = BLUE_LOC
THIS.aColors[13,2] = BLUE
THIS.aColors[14,1] = FUCHSIA_LOC
THIS.aColors[14,2] = FUCHSIA
THIS.aColors[15,1] = AQUA_LOC
THIS.aColors[15,2] = AQUA
THIS.aColors[16,1] = WHITE_LOC
THIS.aColors[16,2] = WHITE

THIS.AddItem(DEFCOLOR_LOC)

lcBMPPath=IIF(VERSION(2)=0,"",HOME()+"FFC\Graphics\")

FOR i = 1 TO ALEN(THIS.aColors,1)
	THIS.AddItem(" "+THIS.aColors[m.i,1])
	THIS.Picture[m.i+1] = lcBMPPath+"_"+FORCEEXT(THIS.aColors[m.i,2],"BMP")
ENDFOR

THIS.Value = THIS.List[1]
ENDPROC


************************************************************
OBJETO: _cbocolors
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 21, 3, 0

*** METODOS ***


************************************************************
OBJETO: _options
************************************************************
*** PROPIEDADES ***
Height = 250
Width = 375
DoCreate = .T.
AutoCenter = .T.
BorderStyle = 2
Caption = "Layout Options - "
MaxButton = .F.
MinButton = .F.
WindowType = 1
HelpContextID = 1895828906
Name = "_options"

*** METODOS ***
PROCEDURE savesettings
LOCAL i,lnAlen,lnAlen2,lnPos,lcValue,lcControlProperty,lcQuoteDelim,lcQuoteDelim2
LOCAL lSaveEmpty,lSkipQuotes 

lnAlen=ALEN(THIS.aProps,1)
DIMENSION THIS.oSettings.aSettings[1]
DIMENSION THIS.oSettings.aSaveOptions[1,5]
STORE "" TO THIS.oSettings.aSettings
STORE "" TO THIS.oSettings.aSaveOptions

FOR i = 1 TO lnAlen
	THIS.GetPropFlags(THIS.aProps[m.i,7])
	lcControlProperty = THIS.aProps[m.i,2]
	lcValue = &lcControlProperty.	
	IF VARTYPE(lcValue)="C"
		lcValue = ALLTRIM(lcValue)
	ENDIF
	IF EMPTY(lcValue) AND !THIS.lSaveEmpty
		LOOP
	ENDIF
	IF !EMPTY(THIS.oSettings.aSettings[1])
		lnAlen2=ALEN(THIS.oSettings.aSettings,1)
		DIMENSION THIS.oSettings.aSettings[lnAlen2+1]
		DIMENSION THIS.oSettings.aSaveOptions[lnAlen2+1,5]
	ENDIF
	lnAlen2=ALEN(THIS.oSettings.aSettings,1)
	DO CASE
	CASE THIS.lSkipQuotes
		lcQuoteDelim=[]
		lcQuoteDelim2=[]
	CASE ATC(["],TRANS(lcValue))#0
		lcQuoteDelim="["
		lcQuoteDelim2="]"
	OTHERWISE
		lcQuoteDelim=["]
		lcQuoteDelim2=["]
	ENDCASE
	THIS.oSettings.aSettings[lnAlen2] = THIS.aProps[m.i,3]+"="+lcQuoteDelim+TRANS(lcValue)+lcQuoteDelim2
	THIS.oSettings.aSaveOptions[lnAlen2,1] = THIS.aProps[m.i,1]	&&property name
	THIS.oSettings.aSaveOptions[lnAlen2,2] = lcValue			&&property setting
	THIS.oSettings.aSaveOptions[lnAlen2,3] = THIS.aProps[m.i,5]	&&generate before
	THIS.oSettings.aSaveOptions[lnAlen2,4] = THIS.aProps[m.i,4]	&&style property
	THIS.oSettings.aSaveOptions[lnAlen2,5] = THIS.aProps[m.i,6]	&&wizard flags
ENDFOR

ENDPROC
PROCEDURE restoresettings
LOCAL i,lnAlen,lnPos,lcSaveExact,lcProperty,lcControlProperty
lnAlen=ALEN(THIS.aProps,1)
lcSaveExact = SET("EXACT")
SET EXACT ON

FOR i = 1 TO lnAlen
	lcProperty = THIS.aProps[m.i,1]
	lcControlProperty =  THIS.aProps[m.i,2]
	IF EMPTY(lcProperty) OR EMPTY(lcControlProperty)
		LOOP
	ENDIF
	lnPos=ASCAN(THIS.oSettings.aSaveOptions,lcProperty)
	IF lnPos#0
		&lcControlProperty. = THIS.oSettings.aSaveOptions[lnPos+1]
	ENDIF
ENDFOR

SET EXACT &lcSaveExact

ENDPROC
PROCEDURE registersetting
LPARAMETER tcProp,tcControl,tcHTMLProp,tcStyleProperty,tlGenBefore,tnWizardFlags,tnPropertyFlags

* tlSkipQuotes,,tlSaveEmpty

* tcProp 			name of property being customized (ex. "bgcolor")
* tcControl 		name of control and property to bind (ex. "THIS.cboColor.Value")
* tcHTMLProp 		HTML property that is being set (ex. "oGenTag.bgColor")
* tcStyleProperty 	name of property for Style (e.g., Font-Family)
* tlGenBefore		whether property is set before or after _oHTML.Generate
*   				is called where HTML table is generated
* tnWizardFlags		flags returned to the Wizard for processing (reserved for Wizards)
* -- ImageFile		1	whether property references image file for lCopyImages in Wizard
* tnPropertyFlags	flags used by Options dialogs to process properties
* -- SkipQuotes		1	whether expression created has quotes around value	-- BITTEST(THIS.aProps[m.i,7],0)
* -- SaveEmpty		2	whetber to write out property if value is EMPTY()	-- BITTEST(THIS.aProps[m.i,7],1)

LOCAL lnAlen,i
lnAlen=0
IF VARTYPE(tlGenBefore)#"L"
	tlGenBefore=.F.
ENDIF
IF VARTYPE(tnWizardFlags)#"N"
	tnWizardFlags=0
ENDIF
IF VARTYPE(tnPropertyFlags)#"N"
	tnPropertyFlags=0
ENDIF

IF EMPTY(THIS.aProps[1])
	DIMENSION THIS.aProps[1,7]
ELSE
	* Check if Property already exists and overwrite
	FOR i = 1 TO ALEN(THIS.aProps,1)
		IF UPPER(THIS.aProps[m.i,1]) == UPPER(tcProp)
			lnAlen = m.i
			EXIT
		ENDIF
	ENDFOR
	IF lnAlen=0
		DIMENSION THIS.aProps[ALEN(THIS.aProps,1)+1,7]
	ENDIF
ENDIF

lnAlen = IIF(lnAlen=0,ALEN(THIS.aProps,1),lnAlen)

THIS.aProps[lnAlen,1] = tcProp
THIS.aProps[lnAlen,2] = tcControl
THIS.aProps[lnAlen,3] = IIF(EMPTY(tcHTMLProp),tcProp,tcHTMLProp)
THIS.aProps[lnAlen,4] = tcStyleProperty
THIS.aProps[lnAlen,5] = tlGenBefore
THIS.aProps[lnAlen,6] = tnWizardFlags
THIS.aProps[lnAlen,7] = tnPropertyFlags

ENDPROC
PROCEDURE resetsettings
DIMENSION THIS.oSettings.aSettings[1]
DIMENSION THIS.oSettings.aSaveOptions[1,5]
STORE "" TO THIS.oSettings.aSettings
STORE "" TO THIS.oSettings.aSaveOptions

ENDPROC
PROCEDURE delarow
* Generic routine to delete an array element. If the array is
* multi-dimensional, then a whole row is deleted.
*
* aArray- array to scan
* wziRow - row to delete
LPARAMETERS aArray,wziRow

LOCAL nColumns
IF ALEN(aArray,1)<m.wziRow OR m.wziRow<0
	RETURN
ENDIF
IF ALEN(aArray,1)=1
	STORE ""  TO aArray
ELSE
	nColumns = ALEN(aArray,2)
	ADEL(aArray,m.wziRow)
	IF nColumns=0
		DIMENSION aArray[ALEN(aArray)-1]
	ELSE
		DIMENSION aArray[ALEN(aArray,1)-1,nColumns]
	ENDIF
ENDIF

ENDPROC
PROCEDURE unregistersetting
LPARAMETER tcProp

LOCAL aTmpProps,i
IF EMPTY(tcProp)
	RETURN
ENDIF

FOR i = 1 TO ALEN(THIS.aProps,1)
	IF UPPER(tcProp) == UPPER(THIS.aProps[m.i,1])
		DIMENSION aTmpProps[1]
		ACOPY(THIS.aProps,aTmpProps)
		THIS.DelARow(@aTmpProps,m.i)
		DIMENSION THIS.aProps[1]
		ACOPY(aTmpProps,THIS.aProps)
		RETURN
	ENDIF
ENDFOR

ENDPROC
PROCEDURE getpropflags
LPARAMETERS tnFlag
THIS.lSkipQuotes = BITTEST(tnFlag,0)
THIS.lSaveEmpty = BITTEST(tnFlag,1)	

ENDPROC
PROCEDURE Show
LPARAMETERS nStyle
THIS.RestoreSettings()

ENDPROC
PROCEDURE Init
IF fontmetric(1, 'MS Sans Serif', 8, '') <> 13 .or. ;
	fontmetric(4, 'MS Sans Serif', 8, '') <> 2 .or. ;
	fontmetric(6, 'MS Sans Serif', 8, '') <> 5 .or. ;
	fontmetric(7, 'MS Sans Serif', 8, '') <> 11
	THIS.SetAll('FontName', 'Arial')
ENDIF

ENDPROC


************************************************************
OBJETO: cmdOK
************************************************************
*** PROPIEDADES ***
Top = 216
Left = 216
Height = 23
Width = 72
FontName = "MS Sans Serif"
FontSize = 8
Caption = "OK"
Default = .F.
TabIndex = 1
Name = "cmdOK"

*** METODOS ***
PROCEDURE Click
THISFORM.SaveSettings()
THISFORM.Release()

ENDPROC


************************************************************
OBJETO: cmdCancel
************************************************************
*** PROPIEDADES ***
Top = 216
Left = 294
Height = 23
Width = 72
FontName = "MS Sans Serif"
FontSize = 8
Cancel = .T.
Caption = "Cancel"
TabIndex = 2
Name = "cmdCancel"

*** METODOS ***
PROCEDURE Click
THISFORM.Release()

ENDPROC


************************************************************
OBJETO: cmdReset
************************************************************
*** PROPIEDADES ***
AutoSize = .T.
Top = 216
Left = 12
Height = 23
Width = 88
FontName = "MS Sans Serif"
FontSize = 8
Caption = "\<Reset Defaults"
TabIndex = 1
Name = "cmdReset"

*** METODOS ***
PROCEDURE Click
THISFORM.ResetSettings()
THISFORM.Release()

ENDPROC


************************************************************
OBJETO: _options
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 21, 3, 0
MS Sans Serif, 0, 8, 5, 13, 11, 11, 2, 0

*** METODOS ***


************************************************************
OBJETO: _tabdatacontrol
************************************************************
*** PROPIEDADES ***
ccsvfile = 
cdatasrc = vfpData
ctableid = tblvfpData
chighlightcolor = green
nlinkfield = 0
ndatapagesize = 10
coutfile_frame1 = 
coutfile_frame2 = 
crepeattablestyle = 
cdisplayfield = 
nframepercent = 20
ccsvfile2 = 
clinkfield = 
coutfile_frame0 = 
cchildalias = 
ntablestyle = 102
Name = "_tabdatacontrol"

*** METODOS ***
PROCEDURE generatetabdata
LOCAL laTmpFields,lnSaveArea,lcPath,lcDisplayfield,i,laTmpFields2
LOCAL lcSaveColor,lcSaveImage,lcSaveTitle
DIMENSION laTmpFields[1]
DIMENSION laTmpFields2[1]
DIMENSION THIS.aGeneratedFiles[1]
STORE "" TO THIS.aGeneratedFiles[1]
THIS.nLinkField=0	&&reset

* Let's first cleanup field list
ACOPY(this.aFieldList,laTmpFields)
IF !THIS.CleanFields(@laTmpFields)	&&no valid fields (GENERAL or MEMO only)
	RETURN .F.
ENDIF
ACOPY(laTmpFields,this.aFieldList)
this.nFieldCount = ALEN(laTmpFields,1)

THIS.cCSVFile = FORCEEXT(THIS.cOutFile,"CSV")
THIS.cCSVFile2=""
COPY TO (THIS.cCSVFile) TYPE CSV

THIS.UpdateGenFiles(THIS.cCSVFile)
THIS.UpdateGenFiles(THIS.cOutFile)

this.Body.AddItem([<p>])

DO CASE
CASE THIS.nTableStyle = 100		&& List view
	IF RECCOUNT()>THIS.nDataPageSize
		THIS.Add_PageButtons()
	ENDIF
	THIS.Add_DataItem()
	THIS.Add_RepeatTable(@laTmpFields)
	THIS.Add_Frame_Script(.T.)
	THIS.Body.AddGenHTMLField("HTML",,"DataPaging")
	THIS.Add_RepeatTable_Script()

CASE THIS.nTableStyle = 101		&& Detail view
	THIS.Add_NavButtons()
	THIS.Add_DataItem()
	THIS.Add_Fields(@laTmpFields)
	THIS.Add_NavButton_Script()

CASE THIS.nTableStyle = 102		&& Hierarchical view

	ACOPY(laTmpFields,laTmpFields2)
	lcPath = JUSTPATH(THIS.cOutFile)
	IF EMPTY(lcPath)
		lcPath = JUSTPATH(FULL(THIS.cOutFile))
	ENDIF
	THIS.cOutFile_Frame0 = lcPath+"\"+JUSTSTEM(THIS.cOutFile)+"_0.HTM"
	THIS.cOutFile_Frame1 = lcPath+"\"+JUSTSTEM(THIS.cOutFile)+"_1.HTM"
	THIS.cOutFile_Frame2 = lcPath+"\"+JUSTSTEM(THIS.cOutFile)+"_2.HTM"
	THIS.UpdateGenFiles(THIS.cOutFile_Frame0)
	THIS.UpdateGenFiles(THIS.cOutFile_Frame1)
	THIS.UpdateGenFiles(THIS.cOutFile_Frame2)

	* Check for different parent table
	* To use 1-Many, must have both cParentSource and cDisplayField
	THIS.cCSVFile2=""
	IF !EMPTY(THIS.cParentSource) AND !EMPTY(THIS.cDisplayField)
		IF !FILE(THIS.cParentSource)
			IF EMPTY(THIS.cParentDBC)
				RETURN .F.
			ENDIF
			OPEN DATABASE (THIS.cParentDBC)		&&set current database			
		ENDIF
		lnSaveArea = SELECT()
		SELECT 0
		lcDisplayfield=THIS.cDisplayField
		SELECT &lcDisplayfield.,0 FROM (THIS.cParentSource);
		  INTO CURSOR SYS(2015)
		IF !USED()
			SELECT (lnSaveArea)
			RETURN .F.
		ENDIF
		THIS.cCSVFile2 = lcPath +"\"+JUSTSTEM(THIS.cOutFile)+"_2.CSV"
		COPY TO (THIS.cCSVFile2) TYPE CSV
		THIS.UpdateGenFiles(THIS.cCSVFile2)
		DIMENSION laTmpFields[1,2]
		laTmpFields[1,1] = THIS.cDisplayField
		SELECT (lnSaveArea)
	ENDIF

	* Frame 1 with List View
	THIS.Add_DataItem(THIS.cCSVFile2)
	THIS.Add_Caption(JUSTSTEM(IIF(EMPTY(THIS.cParentSource),THIS.cChildAlias,THIS.cParentSource)))
	THIS.Add_RepeatTable(@laTmpFields,.T.)
	IF RECCOUNT()>THIS.nDataPageSize
		THIS.Add_PageButtons(.T.)
		THIS.Body.AddGenHTMLField("HTML",,"DataPaging")
	ENDIF
	THIS.Add_RepeatTable_Script()
	THIS.Add_Frame_Script()
	THIS.SaveFile(THIS.cOutFile_Frame1)
	lcSaveColor=THIS.Body.BgColor
	lcSaveImage=THIS.Body.background
	lcSaveTitle=THIS.Head.Title.Item
	
	* Get link field
	IF !EMPTY(THIS.cCSVFile2)	&&1Many -- need to figure out link field
		IF EMPTY(THIS.cLinkField)	&&assume same name used for link fields
			THIS.cLinkField = THIS.cDisplayField
		ENDIF
		FOR i = 1 TO ALEN(laTmpFields2,1)
			IF UPPER(laTmpFields2[m.i,1]) == UPPER(ALLTRIM(THIS.cLinkField))
				THIS.nLinkField = m.i-1  &&need to -1 since ADO collections are zero-based
				EXIT
			ENDIF
		ENDFOR
	ENDIF
	
	* Frame 2 with Detail View/List View
	THIS.ReleaseItems()
	THIS.SetItems
	THIS.Add_DataItem()
	IF !EMPTY(THIS.cParentSource)
		THIS.Add_Caption(JUSTSTEM(THIS.cChildAlias))
	ENDIF
	IF THIS.lOneToMany AND !EMPTY(THIS.cCSVFile2)
		THIS.Add_RepeatTable(@laTmpFields2)
		THIS.Add_RepeatTable_Script()
		THIS.Add_Frame_Script(.T.)
	ELSE
		THIS.Add_Fields(@laTmpFields2)
	ENDIF
	THIS.Add_Filter_Script()
	THIS.Body.BgColor=lcSaveColor
	THIS.Body.background=lcSaveImage
	THIS.Head.Title.AddText(lcSaveTitle)
	THIS.SaveFile(THIS.cOutFile_Frame2)

	* Create Frame0
	THIS.ReleaseItems()
	THIS.SetItems
	THIS.Body.BgColor=lcSaveColor
	THIS.Body.background=lcSaveImage
	THIS.Head.Title.AddText(lcSaveTitle)
	THIS.SaveFile(THIS.cOutFile_Frame0)
	
	* Create Frameset
	THIS.lBodyTag = .F.
	THIS.ReleaseItems()
	THIS.SetItems
	THIS.MakeFrameset()
	THIS.Head.Title.AddText(lcSaveTitle)
	THIS.SaveFile(THIS.cOutFile)
ENDCASE

* if run from Wizard, reset to original values
IF VARTYPE(oWizard)="O"
	THIS.ResetDefaults()
ENDIF
ENDPROC
PROCEDURE makeframeset
LOCAL lnFramePercent
lnFramePercent = THIS.nFramePercent
IF VARTYPE(lnFramePercent)#"N" OR !BETWEEN(lnFramePercent,0,100)
	lnFramePercent = 20
ENDIF

this.AddItem([<frameset rows="80,*">])
this.AddItem([	<frame name="frame0" id="frame0" frameborder=0 src=]+JUSTFNAME(THIS.cOutFile_Frame0)+[>])
this.AddItem([	<frameset cols="]+TRANS(lnFramePercent)+[%,*">])
this.AddItem([		<frame name="frame1" id="frame1" frameborder=0 src=]+JUSTFNAME(THIS.cOutFile_Frame1)+[>])
this.AddItem([		<frame name="frame2" id="frame2" frameborder=0 src=]+JUSTFNAME(THIS.cOutFile_Frame2)+[>])
this.AddItem([	</frameset>])
this.AddItem([</frameset>])

ENDPROC
PROCEDURE add_repeattable
LPARAMETER taFields,tlHierView
LOCAL lnCount,lcField,lcStr,lnFieldCount,oTag,lcCaption,lnPos,lcExact
EXTERNAL ARRAY taFields

* Add table tag
this.oGenTag = this.Body.AddTag("table")
this.oGenTag.ID = THIS.cTableID
this.oGenTag.datasrc = "#"+THIS.cDataSrc
this.oGenTag.datapagesize = TRANS(THIS.nDataPageSize)

IF !EMPTY(THIS.cRepeatTableStyle)
	* ex. "color: maroon; font-size: 10pt; font-family: Arial"
	this.oGenTag.style = THIS.cRepeatTableStyle
ENDIF

* Add table header tag
oTag = this.oGenTag.AddTag("thead")
oTag.ID =  "tblvfpdataheader"
oTag = oTag.AddTag("tr")

* Add table header fields
lnFieldCount = IIF(tlHierView,1,ALEN(taFields,1))

IF tlHierView AND EMPTY(THIS.cDisplayField)
	THIS.cDisplayField=taFields[1,1]
ENDIF

FOR lnCount = 1 TO lnFieldCount
	IF tlHierView
		* Need ASCAN here
		lcCaption = THIS.cDisplayField
		lcExact = SET("EXACT")
		SET EXACT ON
		lnPos = ASCAN(taFields,UPPER(THIS.cDisplayField))	
		IF lnPos>0 AND (lnPos+4)<=ALEN(taFields)
			lcCaption = taFields[lnPos+4]
		ENDIF
		SET EXACT &lcExact
	ELSE
		lcCaption = taFields[lnCount,5]
	ENDIF
	lcField = IIF(tlHierView,THIS.cDisplayField,taFields[lnCount,1])
	  oTag.AddItem([	<td><b><u><div id=]+;
	   LOWER(lcField)+">"+PROPER(lcCaption)+;
	   [</div></u></b></td>])
ENDFOR

* Add table body tag
oTag = this.oGenTag.AddTag("tbody")
oTag=oTag.AddTag("tr")
oTag.onclick = "selectrecord(this)"

* Add table body fields
FOR lnCount = 1 TO lnFieldCount
	lcField = IIF(tlHierView,THIS.cDisplayField,taFields[lnCount ,1])
	oTag.AddItem([	<td align=left><span datafld="]+;
	  LOWER(lcField)+["></span></td>])
ENDFOR

this.Body.AddTag("p")

ENDPROC
PROCEDURE add_repeattable_script
this.Body.AddGenHTMLField("HTML",,"SortTableColumn")

ENDPROC
PROCEDURE add_fields
LPARAMETER taFields
LOCAL lnCount,lcField,llFirstField,lcFieldcaption
EXTERNAL ARRAY taFields

llFirstField=.T.
this.oGenTag = this.Body.AddTag("Div")

IF !EMPTY(THIS.cRepeatTableStyle)
	this.oGenTag.style = THIS.cRepeatTableStyle
ENDIF

FOR lnCount = 1 TO ALEN(taFields,1)
	IF !llFirstField
		this.oGenTag.AddItem([<br>])
	ENDIF
	llFirstField=.F.
	lcField = taFields[lnCount,1]
	lcFieldcaption = PROPER(taFields[lnCount,5])
	this.oGenTag.AddItem([<strong>]+lcFieldcaption +[: </strong>])
	this.oGenTag.AddItem([<label datasrc=#]+THIS.cDataSrc+[ datafld=]+lcField+[></label>])
ENDFOR

ENDPROC
PROCEDURE add_dataitem
LPARAMETER tcCSVFile
LOCAL lcStr

IF VARTYPE(tcCSVFile)#"C" OR !FILE(tcCSVFile)
	tcCSVFile = THIS.cCSVFile
ENDIF

tcCSVFile = JUSTFNAME(tcCSVFile)

* add data control object id tag
lcStr = CR_LF+;
[<object id="] + THIS.cDataSrc + ["] + CR_LF +;
[classid="clsid:333C7BC4-460F-11D0-BC04-0080C7055A83"] + CR_LF +;
[align="baseline" border="0" width="0" height="0"><param] + CR_LF +;
[name="DataURL" value="] + tcCSVFile + ["><param name="UseHeader"] + CR_LF +;
[value="True"></object>] + CR_LF+CR_LF

this.body.AddItem(lcStr)

ENDPROC
PROCEDURE add_pagebuttons
* Add navigation buttons
LPARAMETER tlSkipFrame
THIS.lSkipFrame = tlSkipFrame
this.Body.AddGenHTMLField("HTML",,"PageButtons")

ENDPROC
PROCEDURE add_navbuttons
this.Body.AddGenHTMLField("HTML",,"NavButtons")

ENDPROC
PROCEDURE add_frame_script
* Add navigation button script
LPARAMETER tlSkipFrame
THIS.lSkipFrame = tlSkipFrame
this.Body.AddGenHTMLField("HTML",,"FrameScript")

ENDPROC
PROCEDURE add_filter_script
this.Body.AddGenHTMLField("HTML",,"FilterScript")

ENDPROC
PROCEDURE add_navbutton_script
this.Body.AddGenHTMLField("HTML",,"NavButtonsCode")

ENDPROC
PROCEDURE cleanfields
LPARAMETER taFields
EXTERNAL ARRAY taFields

* This routine checks fields array and removes any "M" or "G" which are not support by 
* the Tabular Data Control. We assume array is 2D as follows
*	1 - field name
*	2 - field type
LOCAL i

FOR i = ALEN(taFields,1) TO 1 STEP -1
	IF INLIST(taFields[m.i,2],"G","M","U")
		THIS.DelARow(@taFields,i)
	ENDIF
ENDFOR
RETURN !EMPTY(taFields[1])	&&any valid fields left
ENDPROC
PROCEDURE updategenfiles
LPARAMETER tcFileName
IF EMPTY(tcFileName)
	RETURN
ENDIF
IF !EMPTY(THIS.aGeneratedFiles[1])
	DIMENSION THIS.aGeneratedFiles[ALEN(THIS.aGeneratedFiles)+1]
ENDIF
THIS.aGeneratedFiles[ALEN(THIS.aGeneratedFiles)]=tcFileName

ENDPROC
PROCEDURE delarow
* Generic routine to delete an array element. If the array is
* multi-dimensional, then a whole row is deleted.
*
* aArray- array to scan
* wziRow - row to delete
LPARAMETERS aArray,wziRow

LOCAL nColumns
IF ALEN(aArray,1)<m.wziRow OR m.wziRow<0
	RETURN
ENDIF
IF ALEN(aArray,1)=1
	STORE ""  TO aArray
ELSE
	nColumns = ALEN(aArray,2)
	ADEL(aArray,m.wziRow)
	IF nColumns=0
		DIMENSION aArray[ALEN(aArray)-1]
	ELSE
		DIMENSION aArray[ALEN(aArray,1)-1,nColumns]
	ENDIF
ENDIF

ENDPROC
PROCEDURE add_caption
LPARAMETER tcCaption

IF EMPTY(tcCaption) OR !THIS.lCaption
	RETURN
ENDIF

this.oGenTag = this.Body.AddTag("Div")
this.oGenTag.style = THIS.cRepeatTableStyle
this.oGenTag = this.oGenTag.AddTag("B")
this.oGenTag.AddText(ALLTRIM(PROPER(tcCaption)))

ENDPROC
PROCEDURE resetdefaults
THIS.nDataPageSize = 10
THIS.cParentSource = ""
THIS.cDisplayField = ""
THIS.cParentDBC = ""
THIS.cChildAlias = ""
THIS.cLinkField  = ""
THIS.lOneToMany = .F.
ENDPROC
PROCEDURE generatetable
RETURN this.GenerateTabData()
ENDPROC


************************************************************
OBJETO: _dynamiclist
************************************************************
*** PROPIEDADES ***
Width = 217
Height = 97
BorderWidth = 0
cexpression = 
Name = "_dynamiclist"

*** METODOS ***
PROCEDURE cexpression_access
LOCAL lcColor1,lcColor2,lnRows
lcColor1 = ALLTRIM(THIS.cboColors1.Color)
lcColor2 = ALLTRIM(THIS.cboColors2.Color)
lnRows = THIS.spnRows.Value
DO CASE
CASE EMPTY(lcColor1) AND EMPTY(lcColor2) AND lnRows=1
	 THIS.cexpression = ""
OTHERWISE
	THIS.cexpression = [bgcolor="{{IIF(MOD(INT((RECNO()-1)/] + TRANS(lnRows) + [),2)=0,']+;
	lcColor1 + [','] + lcColor2 + [')}}"]
ENDCASE
RETURN THIS.cexpression

ENDPROC
PROCEDURE cexpression_assign
LPARAMETERS vNewVal
LOCAL lnCharPos,lcStr,lcCharStr
THIS.cExpression = vNewVal
IF EMPTY(vNewVal)
	RETURN
ENDIF

* Get row value
lcCharStr = ""
lcStr = ""
lnCharPos = RAT("/",vNewVal)
IF lnCharPos > 0
	lcStr=""
	DO WHILE .T.
		lnCharPos = lnCharPos + 1
		lcCharStr = SUBSTR(vNewVal,lnCharPos,1)
		IF VAL(lcCharStr)=0
			lcStr=VAL(lcStr)
			lcStr = IIF(lcStr=0,1,lcStr)
			THIS.spnRows.Value = lcStr 
			EXIT		
		ENDIF
		lcStr = lcStr + lcCharStr
	ENDDO
ENDIF

* Get first row color
lcCharStr = ""
lcStr = ""
lnCharPos = RAT(",",vNewVal,2)
IF lnCharPos > 0
	lcStr=""
	lnCharPos = lnCharPos + 1
	DO WHILE .T.
		lnCharPos = lnCharPos + 1
		lcCharStr = SUBSTR(vNewVal,lnCharPos,1)
		IF lcCharStr="'"
			lcStr = IIF(EMPTY(lcStr),"",lcStr)
			THIS.cboColors1.Color = lcStr
			EXIT		
		ENDIF
		lcStr = lcStr + lcCharStr
	ENDDO
ENDIF

* Get next row color
lcCharStr = ""
lcStr = ""
lnCharPos = RAT(",",vNewVal)
IF lnCharPos > 0
	lcStr=""
	lnCharPos = lnCharPos + 1
	DO WHILE .T.
		lnCharPos = lnCharPos + 1
		lcCharStr = SUBSTR(vNewVal,lnCharPos,1)
		IF lcCharStr="'"
			lcStr = IIF(EMPTY(lcStr),"",lcStr)
			THIS.cboColors2.Color = lcStr
			EXIT		
		ENDIF
		lcStr = lcStr + lcCharStr
	ENDDO
ENDIF

ENDPROC


************************************************************
OBJETO: cbocolors1
************************************************************
*** PROPIEDADES ***
FontName = "MS Sans Serif"
FontSize = 8
Height = 24
Left = 85
TabIndex = 2
Top = 1
Visible = .T.
Width = 132
Name = "cbocolors1"

*** METODOS ***


************************************************************
OBJETO: cbocolors2
************************************************************
*** PROPIEDADES ***
FontName = "MS Sans Serif"
FontSize = 8
Height = 24
Left = 85
TabIndex = 4
Top = 37
Visible = .T.
Width = 132
Name = "cbocolors2"

*** METODOS ***


************************************************************
OBJETO: Label1
************************************************************
*** PROPIEDADES ***
FontName = "MS Sans Serif"
FontSize = 8
Caption = "\<First row color"
Height = 15
Left = 1
Top = 7
Width = 75
TabIndex = 1
Name = "Label1"

*** METODOS ***


************************************************************
OBJETO: Label2
************************************************************
*** PROPIEDADES ***
FontName = "MS Sans Serif"
FontSize = 8
Caption = "\<Next row color"
Height = 15
Left = 1
Top = 43
Width = 78
TabIndex = 3
Name = "Label2"

*** METODOS ***


************************************************************
OBJETO: Label3
************************************************************
*** PROPIEDADES ***
FontName = "MS Sans Serif"
FontSize = 8
Caption = "Ro\<w offset"
Height = 15
Left = 1
Top = 79
Width = 61
TabIndex = 5
Name = "Label3"

*** METODOS ***


************************************************************
OBJETO: spnRows
************************************************************
*** PROPIEDADES ***
FontName = "MS Sans Serif"
FontSize = 8
Height = 24
KeyboardLowValue = 1
Left = 85
SpinnerLowValue =   1.00
TabIndex = 6
Top = 73
Width = 60
Value = 1
Name = "spnRows"

*** METODOS ***


************************************************************
OBJETO: _dynamiclist
************************************************************
*** PROPIEDADES ***
MS Sans Serif, 0, 8, 7, 16, 13, 14, 3, 0

*** METODOS ***


************************************************************
OBJETO: _listoptions
************************************************************
*** PROPIEDADES ***
DoCreate = .T.
Visible = .T.
Name = "_listoptions"
cmdOK.Name = "cmdOK"
cmdCancel.Name = "cmdCancel"
cmdReset.Name = "cmdReset"
Label1.Name = "Label1"
pf1.ErasePage = .T.
pf1.pg1.cboBorderColor.Name = "cboBorderColor"
pf1.pg1.Label2.BackStyle = 0
pf1.pg1.Label2.Name = "Label2"
pf1.pg1.cboBackColor.Name = "cboBackColor"
pf1.pg1.Label3.BackStyle = 0
pf1.pg1.Label3.Name = "Label3"
pf1.pg1.Label4.BackStyle = 0
pf1.pg1.Label4.Name = "Label4"
pf1.pg1.Label5.BackStyle = 0
pf1.pg1.Label5.Name = "Label5"
pf1.pg1.spnBorder.Name = "spnBorder"
pf1.pg1.txtImage.Name = "txtImage"
pf1.pg1.cmdImage.Name = "cmdImage"
pf1.pg1.Name = "pg1"
pf1.pg2.Label5.Name = "Label5"
pf1.pg2.txtFont.Name = "txtFont"
pf1.pg2.cmdFont.Name = "cmdFont"
pf1.pg2.label22.Name = "label22"
pf1.pg2.cboForecolor.Name = "cboForecolor"
pf1.pg2.Label13.Name = "Label13"
pf1.pg2.spnFontSize.Name = "spnFontSize"
pf1.pg2.Name = "pg2"
pf1.pg3.Label5.Name = "Label5"
pf1.pg3.txtClass.Left = 96
pf1.pg3.txtClass.Top = 12
pf1.pg3.txtClass.Name = "txtClass"
pf1.pg3.Name = "pg3"
pf1.Name = "pf1"

*** METODOS ***
PROCEDURE Load
DoDefault()
THIS.RegisterSetting("dynamiclist","THIS.pf1.pg3.dynamiclist.cExpression","cTDAttributes",,.T.)

ENDPROC


************************************************************
OBJETO: dynamiclist
************************************************************
*** PROPIEDADES ***
Top = 45
Left = 11
BackStyle = 0
Visible = .T.
Name = "dynamiclist"
cbocolors1.Name = "cbocolors1"
cbocolors2.Name = "cbocolors2"
Label1.BackStyle = 0
Label1.Name = "Label1"
Label2.BackStyle = 0
Label2.Name = "Label2"
Label3.BackStyle = 0
Label3.Name = "Label3"
spnRows.Name = "spnRows"

*** METODOS ***


************************************************************
OBJETO: _listoptions
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
MS Sans Serif, 0, 8, 5, 13, 11, 11, 2, 0

*** METODOS ***


************************************************************
OBJETO: _staticoptions
************************************************************
*** PROPIEDADES ***
Height = 271
Width = 395
DoCreate = .T.
Name = "_staticoptions"
cmdOK.Top = 240
cmdOK.Left = 236
cmdOK.TabIndex = 4
cmdOK.Name = "cmdOK"
cmdCancel.Top = 240
cmdCancel.Left = 312
cmdCancel.TabIndex = 5
cmdCancel.Name = "cmdCancel"
cmdReset.Top = 240
cmdReset.Left = 12
cmdReset.TabIndex = 3
cmdReset.Name = "cmdReset"

*** METODOS ***
PROCEDURE Load
THIS.RegisterSetting("bordercolor","THIS.pf1.pg1.cboBorderColor.Color","oGenTag.bordercolor")
THIS.RegisterSetting("bgcolor","THIS.pf1.pg1.cboBackColor.Color","oGenTag.bgcolor")
THIS.RegisterSetting("background","THIS.pf1.pg1.txtImage.Value","oGenTag.background",,,1)
THIS.RegisterSetting("border","THIS.pf1.pg1.spnBorder.Value","oGenTag.border",,,,2)
THIS.RegisterSetting("fontface","THIS.pf1.pg2.txtFont.Value","oGenTag.Style","font-family",,,1)
THIS.RegisterSetting("fontsize","THIS.pf1.pg2.spnFontSize.Value","oGenTag.Style","font-size",,,1)
THIS.RegisterSetting("forecolor","THIS.pf1.pg2.cboForeColor.Color","oGenTag.Style","color",,,1)
THIS.RegisterSetting("class","THIS.pf1.pg3.txtClass.Value","oGenTag._Class")

ENDPROC


************************************************************
OBJETO: Label1
************************************************************
*** PROPIEDADES ***
FontName = "MS Sans Serif"
FontSize = 8
WordWrap = .T.
Caption = "You can specify additional settings for the data table generated."
Height = 29
Left = 12
Top = 12
Width = 372
TabIndex = 1
Name = "Label1"

*** METODOS ***


************************************************************
OBJETO: pf1
************************************************************
*** PROPIEDADES ***
ErasePage = .T.
PageCount = 3
TabStyle = 1
BorderWidth = 0
Top = 48
Left = 12
Width = 372
Height = 180
TabIndex = 2
Name = "pf1"
Page1.FontName = "MS Sans Serif"
Page1.FontSize = 8
Page1.Caption = "Border"
Page1.Name = "pg1"
Page2.FontName = "MS Sans Serif"
Page2.FontSize = 8
Page2.Caption = "Font"
Page2.Name = "pg2"
Page3.FontName = "MS Sans Serif"
Page3.FontSize = 8
Page3.Caption = "Other"
Page3.Name = "pg3"

*** METODOS ***


************************************************************
OBJETO: cboBorderColor
************************************************************
*** PROPIEDADES ***
FontName = "MS Sans Serif"
FontSize = 8
Height = 24
Left = 119
TabIndex = 2
Top = 12
Width = 120
Name = "cboBorderColor"

*** METODOS ***


************************************************************
OBJETO: Label2
************************************************************
*** PROPIEDADES ***
FontName = "MS Sans Serif"
FontSize = 8
BackStyle = 0
Caption = "Border \<color"
Height = 17
Left = 11
Top = 17
Width = 84
TabIndex = 1
Name = "Label2"

*** METODOS ***


************************************************************
OBJETO: cboBackColor
************************************************************
*** PROPIEDADES ***
FontName = "MS Sans Serif"
FontSize = 8
Height = 24
Left = 119
TabIndex = 4
Top = 48
Width = 120
Name = "cboBackColor"

*** METODOS ***


************************************************************
OBJETO: Label3
************************************************************
*** PROPIEDADES ***
FontName = "MS Sans Serif"
FontSize = 8
BackStyle = 0
Caption = "Bac\<kground color"
Height = 17
Left = 11
Top = 53
Width = 96
TabIndex = 3
Name = "Label3"

*** METODOS ***


************************************************************
OBJETO: Label4
************************************************************
*** PROPIEDADES ***
FontName = "MS Sans Serif"
FontSize = 8
BackStyle = 0
Caption = "Background \<image"
Height = 17
Left = 11
Top = 88
Width = 104
TabIndex = 5
Name = "Label4"

*** METODOS ***


************************************************************
OBJETO: Label5
************************************************************
*** PROPIEDADES ***
FontName = "MS Sans Serif"
FontSize = 8
BackStyle = 0
Caption = "Border \<width"
Height = 17
Left = 11
Top = 125
Width = 84
TabIndex = 8
Name = "Label5"

*** METODOS ***


************************************************************
OBJETO: spnBorder
************************************************************
*** PROPIEDADES ***
FontName = "MS Sans Serif"
FontSize = 8
Height = 23
KeyboardLowValue = 0
Left = 119
SpinnerLowValue =   0.00
TabIndex = 9
Top = 120
Width = 48
Value = 0
Name = "spnBorder"

*** METODOS ***


************************************************************
OBJETO: txtImage
************************************************************
*** PROPIEDADES ***
FontName = "MS Sans Serif"
FontSize = 8
Height = 22
Left = 119
TabIndex = 6
Top = 84
Width = 204
Name = "txtImage"

*** METODOS ***


************************************************************
OBJETO: cmdImage
************************************************************
*** PROPIEDADES ***
Top = 84
Left = 335
Height = 22
Width = 21
Caption = "..."
TabIndex = 7
Name = "cmdImage"

*** METODOS ***
PROCEDURE Click
#DEFINE GETFILE_GRAPHICSPROMPT_LOC	"Images:JPG,GIF"
LOCAL lcFileName
lcFileName = GETPICT(GETFILE_GRAPHICSPROMPT_LOC)
IF EMPTY(lcFileName) OR !FILE(lcFileName)
	RETURN ""
ENDIF
THIS.Parent.txtImage.Value = lcFileName

ENDPROC


************************************************************
OBJETO: Label5
************************************************************
*** PROPIEDADES ***
AutoSize = .T.
FontName = "MS Sans Serif"
FontSize = 8
BackStyle = 0
Caption = "\<Font name(s)"
Height = 15
Left = 11
Top = 16
Width = 63
TabIndex = 1
Name = "Label5"

*** METODOS ***


************************************************************
OBJETO: txtFont
************************************************************
*** PROPIEDADES ***
FontName = "MS Sans Serif"
FontSize = 8
Height = 22
Left = 83
TabIndex = 2
Top = 12
Width = 240
Name = "txtFont"

*** METODOS ***


************************************************************
OBJETO: cmdFont
************************************************************
*** PROPIEDADES ***
Top = 12
Left = 335
Height = 22
Width = 21
Caption = "..."
TabIndex = 3
Name = "cmdFont"

*** METODOS ***
PROCEDURE Click
PRIVATE cFont
LOCAL lcTxtFont,loGetFont,lcFont
cFont=""
loGetFont=NewObject("getfontname",THISFORM.ClassLibrary,"","cFont")
loGetFont.Show()
lcFont = ALLTRIM(m.cFont)
IF !EMPTY(lcFont)
	lcTxtFont = ALLTRIM(THIS.Parent.txtFont.Value)
	IF ATC(lcFont+",",lcTxtFont)=0 AND ;
	   !lcFont==ALLTRIM(SUBSTR(lcTxtFont,RAT(",",lcTxtFont)+1))
		IF !EMPTY(THIS.Parent.txtFont.Value)
			lcFont = ALLTRIM(THIS.Parent.txtFont.Value)+", "+lcFont
		ENDIF
		THIS.Parent.txtFont.Value = lcFont
	ENDIF
ENDIF

ENDPROC


************************************************************
OBJETO: label22
************************************************************
*** PROPIEDADES ***
AutoSize = .T.
FontName = "MS Sans Serif"
FontSize = 8
BackStyle = 0
Caption = "Font si\<ze"
Height = 15
Left = 11
Top = 53
Width = 44
TabIndex = 4
Name = "label22"

*** METODOS ***


************************************************************
OBJETO: cboForecolor
************************************************************
*** PROPIEDADES ***
FontName = "MS Sans Serif"
FontSize = 8
Height = 24
Left = 83
TabIndex = 7
Top = 84
Width = 120
Name = "cboForecolor"

*** METODOS ***


************************************************************
OBJETO: Label13
************************************************************
*** PROPIEDADES ***
FontName = "MS Sans Serif"
FontSize = 8
BackStyle = 0
Caption = "Fore\<color"
Height = 15
Left = 11
Top = 89
Width = 46
TabIndex = 6
Name = "Label13"

*** METODOS ***


************************************************************
OBJETO: spnFontSize
************************************************************
*** PROPIEDADES ***
FontName = "MS Sans Serif"
FontSize = 8
Height = 23
KeyboardLowValue = 0
Left = 83
SpinnerLowValue =   0.00
TabIndex = 5
Top = 48
Width = 48
Name = "spnFontSize"

*** METODOS ***


************************************************************
OBJETO: Label5
************************************************************
*** PROPIEDADES ***
AutoSize = .T.
FontName = "MS Sans Serif"
FontSize = 8
BackStyle = 0
Caption = "\<Style class"
Height = 15
Left = 11
Top = 16
Width = 52
TabIndex = 1
Name = "Label5"

*** METODOS ***


************************************************************
OBJETO: txtClass
************************************************************
*** PROPIEDADES ***
FontName = "MS Sans Serif"
FontSize = 8
Height = 22
Left = 83
TabIndex = 2
Top = 12
Width = 240
Name = "txtClass"

*** METODOS ***


************************************************************
OBJETO: _staticoptions
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
MS Sans Serif, 0, 8, 5, 13, 11, 11, 2, 0

*** METODOS ***


************************************************************
OBJETO: _tabhieroptions
************************************************************
*** PROPIEDADES ***
DoCreate = .T.
cparentalias = 
cparentdbc = 
cparentsource = 
cchildalias = 
Name = "_tabhieroptions"
cmdOK.Name = "cmdOK"
cmdCancel.Name = "cmdCancel"
cmdReset.Name = "cmdReset"
Label1.Height = 24
Label1.Left = 12
Label1.Top = 12
Label1.Width = 372
Label1.Name = "Label1"
pf1.ErasePage = .T.
pf1.PageCount = 4
pf1.pg1.cboBorderColor.Name = "cboBorderColor"
pf1.pg1.Label2.Name = "Label2"
pf1.pg1.cboBackColor.Name = "cboBackColor"
pf1.pg1.Label3.Name = "Label3"
pf1.pg1.Label4.Name = "Label4"
pf1.pg1.Label5.Name = "Label5"
pf1.pg1.spnBorder.Name = "spnBorder"
pf1.pg1.txtImage.Name = "txtImage"
pf1.pg1.cmdImage.Name = "cmdImage"
pf1.pg1.Enabled = .F.
pf1.pg1.PageOrder = 4
pf1.pg1.Name = "pg1"
pf1.pg2.Label5.Name = "Label5"
pf1.pg2.txtFont.Name = "txtFont"
pf1.pg2.cmdFont.Name = "cmdFont"
pf1.pg2.label22.Name = "label22"
pf1.pg2.CboForecolor.Name = "CboForecolor"
pf1.pg2.Label13.Name = "Label13"
pf1.pg2.spnFontSize.Name = "spnFontSize"
pf1.pg2.PageOrder = 1
pf1.pg2.Name = "pg2"
pf1.pg3.Label5.Name = "Label5"
pf1.pg3.txtClass.Name = "txtClass"
pf1.pg3.cboHighlightColor.Name = "cboHighlightColor"
pf1.pg3.Label6.BackStyle = 0
pf1.pg3.Label6.Name = "Label6"
pf1.pg3.Label7.BackStyle = 0
pf1.pg3.Label7.Name = "Label7"
pf1.pg3.spnPageSize.Name = "spnPageSize"
pf1.pg3.PageOrder = 2
pf1.pg3.Name = "pg3"
pf1.Page4.FontName = "MS Sans Serif"
pf1.Page4.FontSize = 8
pf1.Page4.Caption = "Relations"
pf1.Page4.PageOrder = 3
pf1.Page4.Name = "pg4"
pf1.Name = "pf1"

*** METODOS ***
PROCEDURE refreshcontrols
LOCAL i
THIS.pf1.pg4.txtTable.Value = THIS.cParentAlias
THIS.pf1.pg4.cboDisplayField.Clear
IF EMPTY(THISFORM.cParentAlias)
	FOR i = 1 TO THIS.pf1.pg4.cboChildField.ListCount
		THIS.pf1.pg4.cboDisplayField.AddItem(THIS.pf1.pg4.cboChildField.List[m.i])
	ENDFOR
	THIS.pf1.pg4.cboDisplayField.Value = THIS.pf1.pg4.cboChildField.Value
	THIS.pf1.pg4.cboChildField.Enabled = .F.
	THIS.pf1.pg4.chkOneMany.Enabled = .F.
ELSE
	SELECT (THIS.cParentAlias)
	FOR i = 1 TO FCOUNT()
		IF INLIST(VARTYPE(FIELD(m.i)),"M","G","U")
			LOOP
		ENDIF
		THIS.pf1.pg4.cboDisplayField.AddItem(PROPER(FIELD(m.i)))
	ENDFOR
	IF THIS.pf1.pg4.cboDisplayField.ListCount>0
		THIS.pf1.pg4.cboDisplayField.Value = THIS.pf1.pg4.cboDisplayField.List[1]
	ENDIF
	THIS.pf1.pg4.cboChildField.Enabled = .T.
	THIS.pf1.pg4.chkOneMany.Enabled = .T.
ENDIF

ENDPROC
PROCEDURE Destroy
SELECT (THIS.oEngine.cWizAlias)
DoDefault()

ENDPROC
PROCEDURE Load
DoDefault()
THIS.RegisterSetting("cDisplayField","THIS.pf1.pg4.cboDisplayField.Value","cDisplayField",,.T.)
THIS.RegisterSetting("lOneToMany","THIS.pf1.pg4.chkOneMany.Value","lOneToMany",,.T.,,1)
THIS.RegisterSetting("cParentDBC","THIS.cParentDBC","cParentDBC",,.T.)
THIS.RegisterSetting("cParentSource","THIS.cParentSource","cParentSource",,.T.)
THIS.RegisterSetting("cLinkField","THIS.pf1.pg4.cboChildField.Value","cLinkField",,.T.)
THIS.RegisterSetting("cParentAlias","THIS.cParentAlias","cParentAlias")
THIS.RegisterSetting("cChildAlias","THIS.cChildAlias","cChildAlias",,.T.)
THIS.RegisterSetting("lCaption","THIS.pf1.pg3.chkCaptions.Value","lCaption",,.T.,,1)

ENDPROC
PROCEDURE Show
LPARAMETERS nstyle
LOCAL i,lcValue
DoDefault()

FOR i = 1 TO ALEN(THIS.oEngine.aWizFields)
	* Need to skip for Memo,General types
	THIS.pf1.pg4.cboChildField.AddItem(THIS.oEngine.aWizFields[m.i])
ENDFOR

IF THIS.pf1.pg4.cboChildField.ListCount>0 AND EMPTY(THIS.pf1.pg4.cboChildField.Value)
	THIS.pf1.pg4.cboChildField.Value = THIS.pf1.pg4.cboChildField.List[1]
ELSE
	* Since values are set in Init before combo filled, we need to reset value here.
	THIS.pf1.pg4.cboChildField.Value = THIS.pf1.pg4.cboChildField.Value
ENDIF
lcValue=THIS.pf1.pg4.cboDisplayField.Value
THIS.RefreshControls()
THIS.pf1.pg4.cboDisplayField.Value=lcValue

ENDPROC
PROCEDURE Init
DoDefault()
THIS.Pf1.Pg1.Enabled = .F.
THIS.UnRegisterSetting("bordercolor")
THIS.UnRegisterSetting("bgcolor")
THIS.UnRegisterSetting("background")
THIS.UnRegisterSetting("border")
IF USED()
	THIS.cChildAlias = JUSTSTEM(CURSORGETPROP("SourceName"))
ENDIF

ENDPROC


************************************************************
OBJETO: chkCaptions
************************************************************
*** PROPIEDADES ***
Top = 120
Left = 11
Height = 15
Width = 138
FontName = "MS Sans Serif"
FontSize = 8
BackStyle = 0
Caption = "Show \<captions"
Value = .F.
Name = "chkCaptions"

*** METODOS ***


************************************************************
OBJETO: cboDisplayField
************************************************************
*** PROPIEDADES ***
FontName = "MS Sans Serif"
FontSize = 8
Height = 24
Left = 119
Style = 2
Top = 48
Width = 192
Name = "cboDisplayField"

*** METODOS ***


************************************************************
OBJETO: txtTable
************************************************************
*** PROPIEDADES ***
FontName = "MS Sans Serif"
FontSize = 8
Enabled = .F.
Height = 23
Left = 119
Top = 12
Width = 192
Name = "txtTable"

*** METODOS ***


************************************************************
OBJETO: cmdTable
************************************************************
*** PROPIEDADES ***
Top = 12
Left = 323
Height = 23
Width = 27
FontName = "MS Sans Serif"
FontSize = 8
Caption = "..."
Name = "cmdTable"

*** METODOS ***
PROCEDURE Click
LOCAL oDataForm
PRIVATE oCust

oDataForm=NewObject("_datasource",THISFORM.Classlibrary)
oCust = CREATE("Custom")

oCust.AddProperty('cAlias',THISFORM.cParentAlias)
oCust.AddProperty('cDatabase',"")
oCust.AddProperty('cDbcTable',"")

oDataForm.oSettings = oCust
oDataForm.Show()

IF !THISFORM.cParentAlias==oCust.cAlias AND ;
  !UPPER(oCust.cAlias)==UPPER(THISFORM.oEngine.cWizAlias)
	THISFORM.cParentAlias = oCust.cAlias
	THISFORM.cParentDBC = oCust.cDatabase
	THISFORM.cParentSource = oCust.cDbcTable
	THISFORM.RefreshControls()
ENDIF

ENDPROC


************************************************************
OBJETO: Label1
************************************************************
*** PROPIEDADES ***
FontName = "MS Sans Serif"
FontSize = 8
BackStyle = 0
Caption = "\<Parent datasource"
Height = 15
Left = 11
Top = 17
Width = 89
Name = "Label1"

*** METODOS ***


************************************************************
OBJETO: Label2
************************************************************
*** PROPIEDADES ***
FontName = "MS Sans Serif"
FontSize = 8
BackStyle = 0
Caption = "\<Display field"
Height = 15
Left = 11
Top = 53
Width = 89
Name = "Label2"

*** METODOS ***


************************************************************
OBJETO: cboChildField
************************************************************
*** PROPIEDADES ***
FontName = "MS Sans Serif"
FontSize = 8
Enabled = .F.
Height = 24
Left = 119
Style = 2
Top = 84
Width = 192
Name = "cboChildField"

*** METODOS ***


************************************************************
OBJETO: Label3
************************************************************
*** PROPIEDADES ***
FontName = "MS Sans Serif"
FontSize = 8
BackStyle = 0
Caption = "\<Link field"
Height = 15
Left = 11
Top = 89
Width = 89
Name = "Label3"

*** METODOS ***


************************************************************
OBJETO: chkOneMany
************************************************************
*** PROPIEDADES ***
Top = 120
Left = 11
Height = 15
Width = 138
FontName = "MS Sans Serif"
FontSize = 8
BackStyle = 0
Caption = "Display one to many \<view"
Value = .F.
Enabled = .F.
Name = "chkOneMany"

*** METODOS ***


************************************************************
OBJETO: cmdResetData
************************************************************
*** PROPIEDADES ***
Top = 120
Left = 251
Height = 23
Width = 104
FontName = "MS Sans Serif"
FontSize = 8
Caption = "Re\<set Datasource"
Name = "cmdResetData"

*** METODOS ***
PROCEDURE Click
THISFORM.cParentAlias = ""
THISFORM.cParentDBC = ""
THISFORM.cParentSource = ""
THIS.Parent.TxtTable.Value = ""
THISFORM.RefreshControls()

ENDPROC


************************************************************
OBJETO: _tabhieroptions
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
MS Sans Serif, 0, 8, 5, 13, 11, 11, 2, 0

*** METODOS ***


************************************************************
OBJETO: _tablistoptions
************************************************************
*** PROPIEDADES ***
Width = 395
DoCreate = .T.
Name = "_tablistoptions"
cmdOK.TabIndex = 15
cmdOK.Name = "cmdOK"
cmdCancel.TabIndex = 16
cmdCancel.Name = "cmdCancel"
cmdReset.Name = "cmdReset"
Label1.TabIndex = 1
Label1.Name = "Label1"
pf1.ErasePage = .T.
pf1.PageCount = 3
pf1.pg1.cboBorderColor.Name = "cboBorderColor"
pf1.pg1.Label2.Name = "Label2"
pf1.pg1.cboBackColor.Name = "cboBackColor"
pf1.pg1.Label3.Name = "Label3"
pf1.pg1.Label4.Name = "Label4"
pf1.pg1.Label5.Name = "Label5"
pf1.pg1.spnBorder.Name = "spnBorder"
pf1.pg1.txtImage.Name = "txtImage"
pf1.pg1.cmdImage.Name = "cmdImage"
pf1.pg1.Name = "pg1"
pf1.pg2.Label5.Name = "Label5"
pf1.pg2.txtFont.Name = "txtFont"
pf1.pg2.cmdFont.Name = "cmdFont"
pf1.pg2.label22.Name = "label22"
pf1.pg2.CboForecolor.Name = "CboForecolor"
pf1.pg2.Label13.Name = "Label13"
pf1.pg2.spnFontSize.Name = "spnFontSize"
pf1.pg2.Name = "pg2"
pf1.pg3.Label5.Name = "Label5"
pf1.pg3.txtClass.Left = 107
pf1.pg3.txtClass.Top = 12
pf1.pg3.txtClass.Name = "txtClass"
pf1.pg3.Name = "pg3"
pf1.Top = 48
pf1.Left = 12
pf1.Width = 372
pf1.Height = 180
pf1.Name = "pf1"

*** METODOS ***
PROCEDURE Load
DoDefault()
THIS.RegisterSetting("cHighLightColor","THIS.pf1.pg3.cboHighLightColor.Color","cHighLightColor",,.T.)
THIS.RegisterSetting("nDataPageSize","THIS.pf1.pg3.spnPageSize.Value","nDataPageSize",,.T.,,1)
THIS.RegisterSetting("fontface","THIS.pf1.pg2.txtFont.Value","cRepeatTableStyle","font-family",.T.,,1)
THIS.RegisterSetting("fontsize","THIS.pf1.pg2.spnFontSize.Value","cRepeatTableStyle","font-size",.T.,,1)
THIS.RegisterSetting("forecolor","THIS.pf1.pg2.cboForeColor.Color","cRepeatTableStyle","color",.T.,,1)

ENDPROC


************************************************************
OBJETO: cboHighlightColor
************************************************************
*** PROPIEDADES ***
FontName = "MS Sans Serif"
FontSize = 8
Height = 24
Left = 107
TabIndex = 12
Top = 48
Width = 120
Name = "cboHighlightColor"

*** METODOS ***


************************************************************
OBJETO: Label6
************************************************************
*** PROPIEDADES ***
FontName = "MS Sans Serif"
FontSize = 8
BackStyle = 0
Caption = "\<Highlight color"
Height = 17
Left = 11
Top = 54
Width = 96
TabIndex = 11
Name = "Label6"

*** METODOS ***


************************************************************
OBJETO: Label7
************************************************************
*** PROPIEDADES ***
FontName = "MS Sans Serif"
FontSize = 8
BackStyle = 0
Caption = "\<Data page size"
Height = 17
Left = 11
Top = 90
Width = 96
TabIndex = 13
Name = "Label7"

*** METODOS ***


************************************************************
OBJETO: spnPageSize
************************************************************
*** PROPIEDADES ***
FontName = "MS Sans Serif"
FontSize = 8
Height = 24
KeyboardLowValue = 1
Left = 107
SpinnerLowValue =   1.00
TabIndex = 14
Top = 84
Width = 48
Value = 10
Name = "spnPageSize"

*** METODOS ***


************************************************************
OBJETO: _tablistoptions
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
MS Sans Serif, 0, 8, 5, 13, 11, 11, 2, 0

*** METODOS ***


