************************************************************
OBJETO: _stopwatch
************************************************************
*** PROPIEDADES ***
Width = 92
Height = 27
BackStyle = 0
BorderWidth = 0
nsec = 0
nmin = 0
nhour = 0
elapsedseconds = 0
Name = "_stopwatch"

*** METODOS ***
PROCEDURE start
This.tmrSWatch.enabled = .T.
ENDPROC
PROCEDURE stop
This.tmrSWatch.enabled = .f.
ENDPROC
PROCEDURE reset
This.nSec = 0
This.nMin = 0
This.nHour = 0
This.UpdateDisplay
ENDPROC
PROCEDURE updatedisplay
LOCAL cSecDisplay , cMinDisplay, cHourDisplay  

cSecDisplay = ALLTRIM(STR(This.nSec))
cMinDisplay = ALLTRIM(STR(This.nMin))
cHourDisplay = ALLTRIM(STR(This.nHour))

This.lblSeconds.Caption = IIF(This.nSec < 10, "0" + m.cSecDisplay , m.cSecDisplay)
This.lblMinutes.Caption = IIF(This.nMin < 10, "0" + m.cMinDisplay , m.cMinDisplay)
This.lblHours.Caption = IIF(This.nHour < 10, "0" + m.cHourDisplay , m.cHourDisplay)

ENDPROC
PROCEDURE increment
THIS.nSec = THIS.nSec + 1

IF THIS.nSec = 60
	THIS.nSec = 0
	THIS.nMin = THIS.nMin + 1
ENDIF

IF THIS.nMin = 60
	THIS.nMin = 0
	THIS.nHour = THIS.nHour + 1
ENDIF
THIS.UpdateDisplay
THIS.ElapsedSeconds = (THIS.nHour * 3600) + ;
                               (THIS.nMin * 60) + ;
                                (This.nSec)

ENDPROC
PROCEDURE Init
#DEFINE SEPARATOR_LOC ':'

This.lblSeparator1.Caption = SEPARATOR_LOC
This.lblSeparator2.Caption = SEPARATOR_LOC

ENDPROC


************************************************************
OBJETO: tmrSWatch
************************************************************
*** PROPIEDADES ***
Top = 2
Left = 52
Height = 25
Width = 25
Interval = 1000
Name = "tmrSWatch"

*** METODOS ***
PROCEDURE Timer
THIS.Parent.Increment

ENDPROC


************************************************************
OBJETO: lblSeparator1
************************************************************
*** PROPIEDADES ***
AutoSize = .T.
FontBold = .T.
FontName = "Arial"
FontSize = 13
BackStyle = 0
Caption = ":"
Height = 22
Left = 26
Top = 4
Width = 8
Name = "lblSeparator1"

*** METODOS ***


************************************************************
OBJETO: lblSeparator2
************************************************************
*** PROPIEDADES ***
FontBold = .T.
FontName = "Arial"
FontSize = 13
Alignment = 0
BackStyle = 0
Caption = ":"
Height = 19
Left = 58
Top = 4
Width = 11
Name = "lblSeparator2"

*** METODOS ***


************************************************************
OBJETO: lblhours
************************************************************
*** PROPIEDADES ***
AutoSize = .T.
FontBold = .T.
FontName = "Arial"
FontSize = 13
BackStyle = 0
Caption = "00"
Height = 22
Left = 6
Top = 5
Width = 20
Name = "lblhours"

*** METODOS ***


************************************************************
OBJETO: lblMinutes
************************************************************
*** PROPIEDADES ***
AutoSize = .T.
FontBold = .T.
FontName = "Arial"
FontSize = 13
BackStyle = 0
Caption = "00"
Height = 22
Left = 37
Top = 5
Width = 20
Name = "lblMinutes"

*** METODOS ***


************************************************************
OBJETO: lblSeconds
************************************************************
*** PROPIEDADES ***
AutoSize = .T.
FontBold = .T.
FontName = "Arial"
FontSize = 13
BackStyle = 0
Caption = "00"
Height = 22
Left = 68
Top = 5
Width = 20
Name = "lblSeconds"

*** METODOS ***


************************************************************
OBJETO: _clock
************************************************************
*** PROPIEDADES ***
Width = 263
Height = 28
BackStyle = 0
BorderWidth = 0
timeformat = 0
Name = "_clock"

*** METODOS ***
PROCEDURE DblClick
THIS.TimeFormat = ABS(THIS.TimeFormat - 1)
THIS.txtDate.DateFormat = IIF(THIS.TimeFormat=0,13,14)

ENDPROC


************************************************************
OBJETO: txtDate
************************************************************
*** PROPIEDADES ***
DateFormat = 13
Alignment = 2
BackStyle = 0
BorderStyle = 0
Enabled = .F.
Height = 21
Left = 3
Top = 5
Width = 256
BackColor = 255,255,0
DisabledBackColor = 255,255,255
DisabledForeColor = 0,0,0
Name = "txtDate"

*** METODOS ***


************************************************************
OBJETO: Timer1
************************************************************
*** PROPIEDADES ***
Top = 3
Left = 8
Height = 12
Width = 14
Interval = 1000
Name = "Timer1"

*** METODOS ***
PROCEDURE Timer
This.Parent.txtDate.Value = DATETIME()

ENDPROC


************************************************************
OBJETO: _clock
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 21, 3, 0

*** METODOS ***


************************************************************
OBJETO: _olecalendar
************************************************************
*** PROPIEDADES ***
Height = 180
Width = 198
builder = 
builderx = (HOME()+"Wizards\BuilderD,BuilderDForm")
date_column = 
Name = "_olecalendar"

*** METODOS ***
PROCEDURE refreshdisplay
LOCAL cColumn
cColumn = this.date_column

IF !EMPTY(m.cColumn) THEN
	THIS.Month = MONTH(&cColumn)
	THIS.Day = DAY(&cColumn)
	THIS.Year = YEAR(&cColumn)
ENDIF

ENDPROC
PROCEDURE SelChange
*** ActiveX Control Event ***
LPARAMETERS startdate, enddate, cancel

nYear = YEAR(startdate)
nDay = DAY(startdate)
nMonth = MONTH(startdate)

dValue = DATE(m.nYear, m.nMonth, m.nDay)

cColumn = THIS.date_column

IF !EMPTY(m.cColumn)
	REPLACE &cColumn WITH m.dValue
ENDIF

IF TYPE("THISFORM")="O"
	THISFORM.Refresh
ENDIF

ENDPROC


