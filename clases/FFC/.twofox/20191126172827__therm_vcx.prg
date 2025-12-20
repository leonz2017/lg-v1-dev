************************************************************
OBJETO: _thermometer
************************************************************
*** PROPIEDADES ***
ScaleMode = 3
Height = 88
Width = 356
DoCreate = .T.
AutoCenter = .T.
BorderStyle = 0
Caption = ""
ControlBox = .F.
Closable = .F.
MaxButton = .F.
MinButton = .F.
Movable = .F.
AlwaysOnTop = .F.
ipercentage = (0)
ibasis = (0)
ccurrenttask = ('')
iprogress = (0)
shpthermbarmaxwidth = 322
cthermref = ('')
Name = "_thermometer"

*** METODOS ***
PROCEDURE complete
* This is the default complete message
Lparameters m.cTask

#define THERMCOMPLETE_LOC	"Complete."

LOCAL iSeconds,cThermRef

if PCOUNT() = 0
	m.cTask = THERMCOMPLETE_LOC
endif

this.Update(iif(this.iBasis <> 0, this.iBasis, 100), m.cTask)
m.iSeconds=seconds() + 1
do while seconds() < m.iSeconds
	*- wait a sec
enddo

if !empty(this.cThermRef)
	m.cThermRef = this.cThermRef
	&cThermRef = .NULL.
	release this
endif

ENDPROC
PROCEDURE update
* m.iProgress is the percentage complete, or, if Init() was passed
* an m.iBasis value, is used to calculate the percentage
* m.cTask is displayed on the second line of the window

Lparameters m.iProgress, m.cTask
LOCAL iPercentage,iAvgCharWidth 

if parameters()<>0 .and. type('m.iProgress') = 'N'
	this.iProgress = max(0, m.iProgress)
endif
if PCOUNT() >= 2 .and. type('m.cTask') = 'C'
	* If we're specifically passed a null string, clear the current task,
	* otherwise leave it alone
	this.cCurrentTask = m.cTask
endif

if !empty(this.iBasis)
	m.iPercentage = int(this.iProgress/this.iBasis*100)
else
	m.iPercentage = this.iProgress
endif
m.iPercentage = min(100,max(0,m.iPercentage))
if m.iPercentage <> this.iPercentage
	if len(alltrim(str(m.iPercentage,3)))<>len(alltrim(str(this.iPercentage,3)))
		iAvgCharWidth=fontmetric(6,this.lblPercentage.FontName, ;
			this.lblPercentage.FontSize, ;
			iif(this.lblPercentage.FontBold,'B','')+ ;
			iif(this.lblPercentage.FontItalic,'I',''))
		this.lblPercentage.Width=txtwidth(alltrim(str(m.iPercentage,3)) + '%', ;
			this.lblPercentage.FontName,this.lblPercentage.FontSize, ;
			iif(this.lblPercentage.FontBold,'B','')+ ;
			iif(this.lblPercentage.FontItalic,'I','')) * iAvgCharWidth
		this.lblPercentage.Left=int((this.shpThermBarMaxWidth- ;
			this.lblPercentage.Width) / 2)+this.shpThermBar.Left-1
		this.lblPercentage2.Left=this.lblPercentage.Left
	endif
	this.iPercentage = m.iPercentage
	this.shpThermBar.Width = int((this.shpThermBarMaxWidth)*this.iPercentage/100)
	this.lblPercentage.Caption = alltrim(str(m.iPercentage,3)) + '%'
	this.lblPercentage2.Caption = this.lblPercentage.Caption
	if this.shpThermBar.Left + this.shpThermBar.Width -1 >= ;
		this.lblPercentage2.Left
		if this.shpThermBar.Left + this.shpThermBar.Width - 1 >= ;
			this.lblPercentage2.Left + this.lblPercentage.Width - 1
			this.lblPercentage2.Width = this.lblPercentage.Width
		else
			this.lblPercentage2.Width = ;
				this.shpThermBar.Left + this.shpThermBar.Width - ;
				this.lblPercentage2.Left - 1
		endif
	else
		this.lblPercentage2.Width = 0
	endif
endif

if ! this.lblTask.Caption == this.cCurrentTask
	this.lblTask.Caption = this.cCurrentTask
endif

ENDPROC
PROCEDURE Init
* m.cTitle is displayed on the first line of the window
* m.iBasis is used to calculate the percentage complete
* m.iInterval is the frequency used for updating the thermometer

Lparameters cTitle, iBasis, iInterval

this.shape5.fillcolor = this.backcolor  && for Win95 compat
this.lblTitle.Caption = iif(empty(m.cTitle),'',m.cTitle)
this.iBasis = iif(empty(m.iBasis),0,m.iBasis)

this.shpThermBar.FillColor = rgb(0,64,128)

ENDPROC


************************************************************
OBJETO: Shape10
************************************************************
*** PROPIEDADES ***
Top = 3
Left = 3
Height = 81
Width = 1
BorderColor = 128,128,128
Name = "Shape10"

*** METODOS ***


************************************************************
OBJETO: Shape9
************************************************************
*** PROPIEDADES ***
Top = 3
Left = 3
Height = 1
Width = 349
BorderColor = 128,128,128
Name = "Shape9"

*** METODOS ***


************************************************************
OBJETO: Shape8
************************************************************
*** PROPIEDADES ***
Top = 3
Left = 352
Height = 82
Width = 1
BorderColor = 255,255,255
Name = "Shape8"

*** METODOS ***


************************************************************
OBJETO: Shape7
************************************************************
*** PROPIEDADES ***
Top = 84
Left = 3
Height = 1
Width = 350
BorderColor = 255,255,255
Name = "Shape7"

*** METODOS ***


************************************************************
OBJETO: Shape6
************************************************************
*** PROPIEDADES ***
Top = 1
Left = 354
Height = 86
Width = 1
BorderColor = 128,128,128
Name = "Shape6"

*** METODOS ***


************************************************************
OBJETO: Shape4
************************************************************
*** PROPIEDADES ***
Top = 86
Left = 1
Height = 1
Width = 354
BorderColor = 128,128,128
Name = "Shape4"

*** METODOS ***


************************************************************
OBJETO: Shape3
************************************************************
*** PROPIEDADES ***
Top = 1
Left = 1
Height = 85
Width = 1
BorderColor = 255,255,255
Name = "Shape3"

*** METODOS ***


************************************************************
OBJETO: Shape2
************************************************************
*** PROPIEDADES ***
Top = 1
Left = 1
Height = 1
Width = 353
BorderColor = 255,255,255
Name = "Shape2"

*** METODOS ***


************************************************************
OBJETO: Shape1
************************************************************
*** PROPIEDADES ***
Top = 0
Left = 0
Height = 88
Width = 356
BackStyle = 0
Name = "Shape1"

*** METODOS ***


************************************************************
OBJETO: Shape5
************************************************************
*** PROPIEDADES ***
Top = 47
Left = 17
Height = 15
Width = 322
BorderStyle = 0
FillStyle = 0
BackColor = 0,64,128
FillColor = 192,192,192
Name = "Shape5"

*** METODOS ***


************************************************************
OBJETO: lblTitle
************************************************************
*** PROPIEDADES ***
FontName = "MS Sans Serif"
FontSize = 8
WordWrap = .F.
BackStyle = 0
Caption = ""
Height = 16
Left = 18
Top = 14
Width = 319
BackColor = 192,192,192
Name = "lblTitle"

*** METODOS ***


************************************************************
OBJETO: lblTask
************************************************************
*** PROPIEDADES ***
FontName = "MS Sans Serif"
FontSize = 8
WordWrap = .F.
BackStyle = 0
Caption = ""
Height = 16
Left = 18
Top = 27
Width = 319
BackColor = 192,192,192
Name = "lblTask"

*** METODOS ***


************************************************************
OBJETO: shpThermBar
************************************************************
*** PROPIEDADES ***
Top = 46
Left = 17
Height = 16
Width = 0
BorderStyle = 0
FillStyle = 0
FillColor = 128,128,128
Name = "shpThermBar"

*** METODOS ***


************************************************************
OBJETO: lblPercentage
************************************************************
*** PROPIEDADES ***
FontBold = .T.
FontName = "MS Sans Serif"
FontSize = 8
BackStyle = 0
Caption = "0%"
Height = 13
Left = 170
Top = 47
Width = 16
ForeColor = 255,255,255
Name = "lblPercentage"

*** METODOS ***


************************************************************
OBJETO: lblPercentage2
************************************************************
*** PROPIEDADES ***
FontName = "MS Sans Serif"
FontSize = 8
BackStyle = 0
Caption = "Label1"
Height = 13
Left = 170
Top = 47
Width = 0
ForeColor = 255,255,255
BackColor = 0,0,255
Name = "lblPercentage2"

*** METODOS ***


************************************************************
OBJETO: Shape11
************************************************************
*** PROPIEDADES ***
Top = 45
Left = 16
Height = 1
Width = 322
BorderColor = 128,128,128
Name = "Shape11"

*** METODOS ***


************************************************************
OBJETO: Shape12
************************************************************
*** PROPIEDADES ***
Top = 61
Left = 16
Height = 1
Width = 323
BorderColor = 255,255,255
Name = "Shape12"

*** METODOS ***


************************************************************
OBJETO: Shape13
************************************************************
*** PROPIEDADES ***
Top = 45
Left = 16
Height = 16
Width = 1
BorderColor = 128,128,128
Name = "Shape13"

*** METODOS ***


************************************************************
OBJETO: Shape14
************************************************************
*** PROPIEDADES ***
Top = 45
Left = 338
Height = 17
Width = 1
BorderColor = 255,255,255
Name = "Shape14"

*** METODOS ***


************************************************************
OBJETO: lblEscapeMessage
************************************************************
*** PROPIEDADES ***
FontBold = .F.
FontName = "MS Sans Serif"
FontSize = 8
WordWrap = .F.
Alignment = 2
BackStyle = 0
Caption = ""
Height = 14
Left = 17
Top = 68
Width = 322
BackColor = 192,192,192
Name = "lblEscapeMessage"

*** METODOS ***


************************************************************
OBJETO: _thermometer
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: _progressbar
************************************************************
*** PROPIEDADES ***
Width = 333
Height = 17
iprogress = 0
ipercentage = 0
ibasis = 0
Name = "_progressbar"

*** METODOS ***
PROCEDURE complete
local iSeconds
this.Update(iif(this.iBasis <> 0, this.iBasis, 100))
m.iSeconds=seconds() + .5
do while seconds() < m.iSeconds
	&& wait half a sec
enddo

ENDPROC
PROCEDURE update
* m.iProgress is the percentage complete, or, if this.iBasis
* is non-zero, is used to calculate the percentage complete.

Lparameters m.iProgress

LOCAL iPercentage,iAvgCharWidth 
this.iProgress = max(0, m.iProgress)

if !empty(this.iBasis)
	m.iPercentage = int(this.iProgress/this.iBasis*100)
else
	m.iPercentage = this.iProgress
endif
m.iPercentage = min(100,max(0,m.iPercentage))
if m.iPercentage <> this.iPercentage
	if len(alltrim(str(m.iPercentage,3)))<>len(alltrim(str(this.iPercentage,3)))
		iAvgCharWidth=fontmetric(6,this.lblPercentage.FontName, ;
			this.lblPercentage.FontSize, ;
			iif(this.lblPercentage.FontBold,'B','')+ ;
			iif(this.lblPercentage.FontItalic,'I',''))
		this.lblPercentage.Width=txtwidth(alltrim(str(m.iPercentage,3)) + '%', ;
			this.lblPercentage.FontName,this.lblPercentage.FontSize, ;
			iif(this.lblPercentage.FontBold,'B','')+ ;
			iif(this.lblPercentage.FontItalic,'I','')) * iAvgCharWidth
			
		this.lblPercentage.Left=int((this.Shape5.Width - ;
			this.lblPercentage.Width) / 2)+this.shpThermBar.Left-1
		this.lblPercentage2.Left=this.lblPercentage.Left
	endif
	this.iPercentage = m.iPercentage

	this.shpThermBar.Width = int((this.Shape5.Width)*this.iPercentage/100)

	this.lblPercentage.Caption = alltrim(str(m.iPercentage,3)) + '%'
	this.lblPercentage2.Caption = this.lblPercentage.Caption
	if this.shpThermBar.Left + this.shpThermBar.Width -1 >= ;
		this.lblPercentage2.Left
		if this.shpThermBar.Left + this.shpThermBar.Width - 1 >= ;
			this.lblPercentage2.Left + this.lblPercentage.Width - 1
			this.lblPercentage2.Width = this.lblPercentage.Width
		else
			this.lblPercentage2.Width = ;
				this.shpThermBar.Left + this.shpThermBar.Width - ;
				this.lblPercentage2.Left - 1
		endif
	else
		this.lblPercentage2.Width = 0
	endif
endif

ENDPROC
PROCEDURE reset
Lparameters iBasis
this.iBasis = iif(type('m.iBasis') = 'N', m.iBasis, 0)
this.Update(0)

ENDPROC
PROCEDURE Init
DECLARE INTEGER GetSysColor IN Win32API INTEGER
this.shpThermBar.FillColor = GetSysColor(13)  &&COLOR HIGHLIGHT
this.shape5.FillColor = this.parent.backcolor

ENDPROC


************************************************************
OBJETO: Shape5
************************************************************
*** PROPIEDADES ***
Top = 1
Left = 1
Height = 16
Width = 332
BackStyle = 0
BorderWidth = 0
FillStyle = 0
FillColor = 192,192,192
Name = "Shape5"

*** METODOS ***


************************************************************
OBJETO: shpThermBar
************************************************************
*** PROPIEDADES ***
Top = 1
Left = 1
Height = 17
Width = 0
BorderStyle = 0
FillStyle = 0
BackColor = 0,64,128
FillColor = 128,128,128
Name = "shpThermBar"

*** METODOS ***


************************************************************
OBJETO: lblPercentage
************************************************************
*** PROPIEDADES ***
FontBold = .T.
FontName = "MS Sans Serif"
FontSize = 8
BackStyle = 0
Caption = "0%"
Height = 13
Left = 159
Top = 2
Width = 16
ForeColor = 0,0,0
DisabledForeColor = 128,128,128
Name = "lblPercentage"

*** METODOS ***


************************************************************
OBJETO: lblPercentage2
************************************************************
*** PROPIEDADES ***
FontName = "MS Sans Serif"
FontSize = 8
BackStyle = 0
Caption = "Label1"
Height = 13
Left = 159
Top = 2
Width = 0
ForeColor = 255,255,255
BackColor = 0,0,255
Name = "lblPercentage2"

*** METODOS ***


************************************************************
OBJETO: shape1
************************************************************
*** PROPIEDADES ***
Top = 0
Left = 0
Height = 16
Width = 1
BorderColor = 128,128,128
Name = "shape1"

*** METODOS ***


************************************************************
OBJETO: shape2
************************************************************
*** PROPIEDADES ***
Top = 0
Left = 0
Height = 1
Width = 332
BorderColor = 128,128,128
Name = "shape2"

*** METODOS ***


************************************************************
OBJETO: Shape3
************************************************************
*** PROPIEDADES ***
Top = 16
Left = 0
Height = 1
Width = 333
BorderColor = 255,255,255
Name = "Shape3"

*** METODOS ***


************************************************************
OBJETO: Shape4
************************************************************
*** PROPIEDADES ***
Top = 0
Left = 332
Height = 17
Width = 1
BorderColor = 255,255,255
Name = "Shape4"

*** METODOS ***


