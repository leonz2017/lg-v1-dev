************************************************************
OBJETO: _cbofontname
************************************************************
*** PROPIEDADES ***
FontBold = .F.
Height = 25
Style = 2
Width = 217
Name = "_cbofontname"

*** METODOS ***
PROCEDURE Init
LOCAL aFontNames,i
DIMENSION aFontNames[1]
=afont(aFontNames)
FOR i = 1 TO ALEN(aFontNames)
	THIS.AddItem(aFontNames[m.i])
ENDFOR
THIS.Value = THIS.FontName
ENDPROC


************************************************************
OBJETO: _cbofontname
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 21, 3, 0

*** METODOS ***


************************************************************
OBJETO: _rtfcontrols
************************************************************
*** PROPIEDADES ***
Width = 311
Height = 32
BorderWidth = 0
Name = "_rtfcontrols"

*** METODOS ***


************************************************************
OBJETO: Cbofontnames
************************************************************
*** PROPIEDADES ***
Height = 25
Left = 4
Top = 4
Width = 157
Name = "Cbofontnames"

*** METODOS ***
PROCEDURE InteractiveChange
THIS.Parent.cboFontSizes.FillList(THIS.Value)

ENDPROC


************************************************************
OBJETO: Cbofontsizes
************************************************************
*** PROPIEDADES ***
Left = 172
Top = 4
Name = "Cbofontsizes"

*** METODOS ***


************************************************************
OBJETO: cmdBold
************************************************************
*** PROPIEDADES ***
Top = 4
Left = 227
Height = 23
Width = 25
FontBold = .T.
FontName = "Courier New"
Caption = "B"
ToolTipText = "Bold"
Name = "cmdBold"

*** METODOS ***


************************************************************
OBJETO: cmdItalic
************************************************************
*** PROPIEDADES ***
Top = 4
Left = 255
Height = 23
Width = 25
FontBold = .T.
FontItalic = .T.
FontName = "Courier New"
FontSize = 9
Caption = "I"
ToolTipText = "Italic"
Name = "cmdItalic"

*** METODOS ***


************************************************************
OBJETO: cmdColor
************************************************************
*** PROPIEDADES ***
Top = 4
Left = 283
Height = 23
Width = 25
Caption = "C"
ToolTipText = "Color"
ForeColor = 255,0,0
Name = "cmdColor"

*** METODOS ***


************************************************************
OBJETO: _rtfcontrols
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 21, 3, 0
Courier New, 1, 9, 7, 16, 12, 9, 4, 0
Courier New, 3, 9, 7, 16, 12, 11, 4, 0

*** METODOS ***


************************************************************
OBJETO: _cbofontsize
************************************************************
*** PROPIEDADES ***
FontBold = .F.
Height = 25
Style = 2
ToolTipText = "FontSize"
Width = 44
nsmallestfont = 8
nlargestfont = 48
Name = "_cbofontsize"

*** METODOS ***
PROCEDURE filllist
LPARAMETERS cFontName,lAutoReset

LOCAL aSizes,lScalable,nLen,nStart,i,lfoundfont,cSaveValue,cFontSize 
lfoundfont = .F.

IF EMPTY(THIS.Value)
	THIS.Value  = ""
ENDIF
cSaveValue = THIS.Value

THIS.Clear

DIMENSION aSizes[1]
=AFONT(aSizes, cFontname)
IF aSizes[1] = -1  && The font is scalable
	lScalable = .T.
	nLen = THIS.nLargestFont
	nStart = THIS.nSmallestFont
ELSE
	nLen = ALEN(aSizes)
	nStart = 1
	lScalable = .F.
ENDIF

FOR i = m.nStart TO m.nLen
	cFontSize = IIF(m.lScalable,TRANS(m.i),TRANS(aSizes[m.i]))
	THIS.AddItem(m.cFontSize)
	IF m.cFontSize == m.cSaveValue
		m.lfoundfont = .T.
	ENDIF
ENDFOR

IF VARTYPE(m.lAutoReset)="L" AND m.lAutoReset
	THIS.Value = THIS.List[1]
ELSE
	* Check if font already set
	THIS.Value = IIF(m.lFoundFont,m.cSaveValue,THIS.List[1])
ENDIF

ENDPROC
PROCEDURE Init
THIS.filllist(THIS.FontName,.T.)

ENDPROC


************************************************************
OBJETO: _cbofontsize
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 21, 3, 0

*** METODOS ***


************************************************************
OBJETO: _tbrediting
************************************************************
*** PROPIEDADES ***
Caption = "Editing"
Height = 31
Left = 0
Top = 0
Width = 339
nappliesto = 1
Name = "_tbrediting"

*** METODOS ***
PROCEDURE Destroy
This.Visible = .F.

ENDPROC
PROCEDURE Refresh
LPARAMETERS oSource

LOCAL i

DO CASE
	CASE THIS.nAppliesTo = 2 && text and edit boxes
		IF TYPE("_SCREEN.ActiveForm") = 'O'
			oForm = _SCREEN.ActiveForm
		ELSE
			RETURN
		ENDIF
		FOR i = 1 to oForm.ControlCount
			IF oForm.Controls(i).BaseClass$"Textbox Editbox"
				THIS.cboFonts.Value = oForm.Controls(m.i).FontName
				THIS.cboSizes.FillList(THIS.cboFonts.Value)
				THIS.cboSizes.Value = STR(oForm.Controls(m.i).FontSize)
				THIS.chkBold.Value = oForm.Controls(m.i).FontBold
				THIS.chkItalic.Value = oForm.Controls(m.i).FontItalic
				THIS.chkUnderline.Value = oForm.Controls(m.i).FontUnderline
				EXIT
			ENDIF
		ENDFOR
	OTHERWISE
		IF TYPE("oSource") != 'O'
			RETURN
		ENDIF
		IF TYPE("oSource.FontName") #"U"
			THIS.cboFonts.Value = oSource.FontName
			THIS.cboSizes.FillList(THIS.cboFonts.Value)
			THIS.cboSizes.Value = STR(oSource.FontSize)
			THIS.chkBold.Value = oSource.FontBold
			THIS.chkItalic.Value = oSource.FontItalic
			THIS.chkUnderline.Value = oSource.FontUnderline
		ENDIF
ENDCASE
ENDPROC


************************************************************
OBJETO: cboFonts
************************************************************
*** PROPIEDADES ***
FontName = "MS Sans Serif"
FontSize = 8
Height = 22
Left = 5
Top = 5
Width = 125
Name = "cboFonts"

*** METODOS ***
PROCEDURE InteractiveChange
LOCAL oForm, oControl
IF TYPE("_SCREEN.ActiveForm") = "O" AND TYPE("_SCREEN.ActiveForm.ActiveControl") = "O"
	oForm = _SCREEN.ActiveForm
	oControl = oForm.ActiveControl
ELSE
	RETURN
ENDIF

DO CASE
	CASE THIS.Parent.nAppliesTo = 1	&& Current Control
		IF PEMSTATUS(oControl,'Fontname',5)
			oControl.FontName = This.Value
		ENDIF
		
	CASE THIS.Parent.nAppliesTo = 2	&& All textboxes and editboxes
		oForm.SetAll('FontName', This.Value, 'TEXTBOX')
		oForm.SetAll('FontName', This.Value, 'EDITBOX')
	
	*==================================================================
	* comment out the previous 2 lines and uncomment the following lines
	* if you want to affect all controls with a baseclass of textbox 
	* or editbox.
	*------------------------------------------------------------------
	*FOR i = 1 to oForm.ControlCount
	*  <find out what the baseclass property is to avoid having to UPPER>
	*	IF UPPER(oForm.Controls(i).BaseClass) = 'TEXTBOX' OR ;
	*		UPPER(oForm.Controls(i).BaseClass) = 'EDITBOX'
	*		oForm.Controls(i).FontName = THIS.Value
	*	ENDIF
	*ENDFOR
	*==================================================================

	CASE THIS.Parent.nAppliesTo = 3	&& All Controls
		oForm.SetAll('FontName', This.Value)

ENDCASE

THIS.Parent.cboSizes.FillList(THIS.Value)
THIS.Parent.Refresh(oControl)

ENDPROC


************************************************************
OBJETO: Separator3
************************************************************
*** PROPIEDADES ***
Top = 5
Left = 135
Height = 22
Width = 0
Name = "Separator3"

*** METODOS ***


************************************************************
OBJETO: cboSizes
************************************************************
*** PROPIEDADES ***
FontName = "MS Sans Serif"
FontSize = 8
Height = 22
Left = 135
Top = 5
Name = "cboSizes"

*** METODOS ***
PROCEDURE Error
LPARAMETERS nError, cMethod, nLine

#define NUM_LOC "Error Number: "
#define PROG_LOC "Procedure: "
#define MSG_LOC "Error Message: "
#define CR_LOC CHR(13)
#define BADSIZE_LOC "The control doesn't support the selected fontsize."

LOCAL lcMsg,lnAnswer  
DO CASE
	CASE nError = 1881 && Fontsize invalid for the control
		WAIT WINDOW BADSIZE_LOC TIMEOUT 2
		IF TYPE("Application.ActiveForm.ActiveControl") = "O"
			THIS.Parent.Refresh(Application.ActiveForm.ActiveControl)
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
			CASE m.lnAnswer = 3 &&Abort
				CANCEL
			CASE m.lnAnswer = 4 &&Retry
				RETRY
			OTHERWISE
				RETURN
		ENDCASE
ENDCASE

ENDPROC
PROCEDURE InteractiveChange
LOCAL oForm
IF TYPE("_SCREEN.ActiveForm") = "O"
	oForm = _SCREEN.ActiveForm
ELSE
	RETURN
ENDIF

DO CASE
	CASE THIS.Parent.nAppliesTo = 1	&& Current Control
		IF TYPE("oForm.ActiveControl.Fontsize") # "U"
			oForm.ActiveControl.FontSize = VAL(THIS.Value)
		ENDIF

	CASE THIS.Parent.nAppliesTo = 2	&& All textboxes and editboxes
		oForm.SetAll('FontSize', VAL(THIS.Value), 'TEXTBOX')		
		oForm.SetAll('FontSize', VAL(THIS.Value), 'EDITBOX')		
	
	CASE THIS.Parent.nAppliesTo = 3	&& All Controls
		oForm.SetAll('FontSize', VAL(THIS.Value))

ENDCASE

ENDPROC


************************************************************
OBJETO: Separator1
************************************************************
*** PROPIEDADES ***
Top = 5
Left = 184
Height = 22
Width = 0
Name = "Separator1"

*** METODOS ***


************************************************************
OBJETO: chkBold
************************************************************
*** PROPIEDADES ***
Top = 5
Left = 184
Height = 22
Width = 26
FontBold = .T.
FontName = "MS Sans Serif"
FontSize = 8
Caption = "B"
Value = .F.
Style = 1
ToolTipText = "Bold"
Name = "chkBold"

*** METODOS ***
PROCEDURE InteractiveChange
LOCAL oForm

IF TYPE("_SCREEN.ActiveForm") = 'O'
	oForm = _SCREEN.ActiveForm
ELSE
	RETURN
ENDIF

DO CASE
	CASE THIS.Parent.nAppliesTo = 1	&& Current Control
		IF TYPE("oForm.ActiveControl.FontBold")#"U"
			oForm.ActiveControl.FontBold = THIS.Value
		ENDIF
		
	CASE THIS.Parent.nAppliesTo = 2	&& All textboxes and editboxes
		oForm.SetAll('FontBold', THIS.Value, 'TEXTBOX')		
		oForm.SetAll('FontBold', THIS.Value, 'EDITBOX')		
	
	CASE THIS.Parent.nAppliesTo = 3	&& All Controls
		oForm.SetAll('FontBold', THIS.Value)
ENDCASE

ENDPROC


************************************************************
OBJETO: chkItalic
************************************************************
*** PROPIEDADES ***
Top = 5
Left = 209
Height = 22
Width = 26
FontItalic = .T.
FontName = "MS Sans Serif"
FontSize = 8
Caption = "I"
Value = .F.
Style = 1
ToolTipText = "Italic"
Name = "chkItalic"

*** METODOS ***
PROCEDURE InteractiveChange
LOCAL oForm

IF TYPE("_SCREEN.ActiveForm") = 'O'
	oForm = _SCREEN.ActiveForm
ELSE
	RETURN
ENDIF

DO CASE
	CASE THIS.Parent.nAppliesTo = 1	&& Current Control
		IF TYPE("oForm.ActiveControl.FontItalic")#"U"
			oForm.ActiveControl.FontItalic = THIS.Value
		ENDIF	
	CASE THIS.Parent.nAppliesTo = 2	&& All textboxes and editboxes
		oForm.SetAll('FontItalic', THIS.Value, 'TEXTBOX')		
		oForm.SetAll('FontItalic', THIS.Value, 'EDITBOX')		
	
	CASE THIS.Parent.nAppliesTo = 3	&& All Controls
		oForm.SetAll('FontItalic', THIS.Value)

ENDCASE

ENDPROC


************************************************************
OBJETO: chkUnderline
************************************************************
*** PROPIEDADES ***
Top = 5
Left = 234
Height = 22
Width = 26
FontName = "MS Sans Serif"
FontSize = 8
FontUnderline = .T.
Caption = "U"
Value = .F.
Style = 1
ToolTipText = "Underline"
Name = "chkUnderline"

*** METODOS ***
PROCEDURE InteractiveChange
LOCAL oForm

IF TYPE("_SCREEN.ActiveForm") = 'O'
	oForm = _SCREEN.ActiveForm
ELSE
	RETURN
ENDIF

DO CASE
	CASE THIS.Parent.nAppliesTo = 1	&& Current Control
		IF TYPE("oForm.ActiveControl.FontUnderline") #"U"
			oForm.ActiveControl.FontUnderline = THIS.Value
		ENDIF
	CASE THIS.Parent.nAppliesTo = 2	&& All textboxes and editboxes
		oForm.SetAll('FontUnderline', THIS.Value, 'TEXTBOX')		
		oForm.SetAll('FontUnderline', THIS.Value, 'EDITBOX')		
	
	CASE THIS.Parent.nAppliesTo = 3	&& All Controls
		oForm.SetAll('FontUnderline', THIS.Value)
ENDCASE

ENDPROC


************************************************************
OBJETO: Separator2
************************************************************
*** PROPIEDADES ***
Top = 5
Left = 265
Height = 22
Width = 0
Name = "Separator2"

*** METODOS ***


************************************************************
OBJETO: cboColor
************************************************************
*** PROPIEDADES ***
FontBold = .F.
FontName = "MS Sans Serif"
FontSize = 8
Value = 0
Height = 22
Left = 265
Style = 2
ToolTipText = "ForeColor and BackColor"
Top = 5
Width = 69
Name = "cboColor"

*** METODOS ***
PROCEDURE Init
#DEFINE ITEM_COLORS_LOC	"Colors"
#DEFINE ITEM_FCOLOR_LOC	"Set ForeColor..."
#DEFINE ITEM_BCOLOR_LOC	"Set BackColor..."

THIS.AddItem(ITEM_COLORS_LOC)
THIS.AddItem(ITEM_FCOLOR_LOC)
THIS.AddItem(ITEM_BCOLOR_LOC)
THIS.ListIndex = 1

ENDPROC
PROCEDURE InteractiveChange
LOCAL oForm,oControl,nBackColor,nForeColor 

IF TYPE("_SCREEN.ActiveForm") = 'O'
	oForm = _SCREEN.ActiveForm
	oControl = oForm.ActiveControl
ELSE
	RETURN
ENDIF
DO CASE 
	CASE This.Value = 1
		RETURN
	CASE This.Value = 2 && Get ForeColor
		nForeColor = GETCOLOR()
		IF m.nForeColor > -1
		DO CASE
			CASE THISFORM.nAppliesTo = 1 && current control
				IF TYPE("oControl.ForeColor") = "N"
					oControl.ForeColor = m.nForeColor
				ELSE
					IF TYPE("oControl.ItemForeColor") = "N"
						oControl.ItemForeColor = m.nForeColor
					ENDIF
				ENDIF
			CASE THISFORM.nAppliesTo = 2 && text and edit boxes
				oForm.SetAll('ForeColor', m.nForeColor, 'TEXTBOX')
				oForm.SetAll('ForeColor', m.nForeColor, 'EDITBOX')
			
			CASE THISFORM.nAppliesTo = 3 && All controls
				oForm.SetAll('ForeColor', m.nForeColor)
		ENDCASE
		ENDIF

	CASE This.Value = 3 && Get BackColor
		nBackColor = GETCOLOR()
		IF m.nBackColor > -1
		DO CASE
			CASE THISFORM.nAppliesTo = 1 && current control
				IF TYPE("oForm.ActiveControl.BackColor") = "N"
					oForm.ActiveControl.BackColor = m.nBackColor
				ELSE
					IF TYPE("oForm.ActiveControl.ItemBackColor") = "N"
						oForm.ActiveControl.ItemBackColor = m.nBackColor
					ENDIF
				ENDIF
			CASE THISFORM.nAppliesTo = 2 && text and edit boxes
				oForm.SetAll('BackColor', m.nBackColor, 'TEXTBOX')
				oForm.SetAll('BackColor', m.nBackColor, 'EDITBOX')
			
			CASE THISFORM.nAppliesTo = 3 && All controls
				oForm.SetAll('BackColor', m.nBackColor)
		ENDCASE
		ENDIF		
ENDCASE
THIS.Value = 1


ENDPROC


************************************************************
OBJETO: _tbrediting
************************************************************
*** PROPIEDADES ***
MS Sans Serif, 0, 8, 5, 13, 11, 11, 2, 0
MS Sans Serif, 1, 8, 6, 13, 11, 12, 2, 0
MS Sans Serif, 2, 8, 5, 13, 11, 11, 2, 0
MS Sans Serif, 4, 8, 5, 13, 11, 11, 2, 0

*** METODOS ***


