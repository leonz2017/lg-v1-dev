************************************************************
OBJETO: _cmdcancel
************************************************************
*** PROPIEDADES ***
Caption = "Cancel"
Name = "_cmdcancel"

*** METODOS ***


************************************************************
OBJETO: _cmdcancel
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 21, 3, 0

*** METODOS ***


************************************************************
OBJETO: _cmdlaunch
************************************************************
*** PROPIEDADES ***
Height = 32
Width = 63
Caption = "\<Launch"
cfilename = 
Name = "_cmdlaunch"

*** METODOS ***
PROCEDURE Click
LOCAL cAPP
IF EMPTY(this.cFileName) OR !FILE(this.cFileName)
	RETURN .F.
ENDIF

IF UPPER(JUSTEXT(THIS.cFileName)) = "APP"
	DO (THIS.cFileName)
ELSE
	cApp = this.cFileName
	RUN /N &cApp
ENDIF

ENDPROC


************************************************************
OBJETO: _cmdlaunch
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 21, 3, 0

*** METODOS ***


************************************************************
OBJETO: _cmdrunform
************************************************************
*** PROPIEDADES ***
Caption = "\<Display"
cfilename = 
lsetcaption = .T.
Name = "_cmdrunform"

*** METODOS ***
PROCEDURE Init
#DEFINE CAPTION_LOC	"\<Display"

IF THIS.lSetCaption AND UPPER(THIS.Caption)=UPPER(CAPTION_LOC) AND !EMPTY(THIS.cFileName)
	THIS.Caption = PROPER(JUSTSTEM(THIS.cFileName))
	THIS.AutoSize = .T.
	THIS.AutoSize = .F.
ENDIF

ENDPROC
PROCEDURE Click
IF FILE(THIS.cFileName)
	DO FORM (THIS.cFileName)
ENDIF

ENDPROC


************************************************************
OBJETO: _cmdrunform
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 21, 3, 0

*** METODOS ***


************************************************************
OBJETO: _cmdhelp
************************************************************
*** PROPIEDADES ***
Height = 30
Width = 94
Caption = "\<Help"
HelpContextID = 0
Name = "_cmdhelp"

*** METODOS ***
PROCEDURE Error
LPARAMETERS nerror,cmethod,nline

ENDPROC
PROCEDURE Click
HELP ID This.HelpContextID


ENDPROC


************************************************************
OBJETO: _cmdhelp
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 21, 3, 0

*** METODOS ***


************************************************************
OBJETO: _cmdrunreport
************************************************************
*** PROPIEDADES ***
Caption = "\<Preview"
TabIndex = 1
lsetcaption = .T.
cfilename = 
luseoutputdialog = .T.
coutputdialogalias = 
lpromptforreport = .T.
cdialogclass = _outputdialog
cdialogclasslib = (IIF(VERSION(2)=0,"",HOME()+"FFC\")+"_REPORTS.VCX")
Name = "_cmdrunreport"

*** METODOS ***
PROCEDURE showoutputdialog
LOCAL loForm
loForm = NewObject(THIS.cDialogClass,THIS.cDialogClassLib)

IF VARTYPE(loForm) # "O"
	RETURN
ENDIF

WITH loForm
	.cReport=THIS.cFileName
	.cAlias=THIS.cOutputDialogAlias
	.lPreventScopeChanges=THIS.lOutputDialogPreventScope
	.lPreventSourceChanges=THIS.lOutputDialogPreventSource
	.cusOutput.cboDestinations.Value = .cusOutput.aDestinations[2,2]
ENDWITH

loForm.Show(1)

ENDPROC
PROCEDURE Init
#DEFINE CAPTION_LOC	"\<Preview"

IF THIS.lSetCaption AND UPPER(THIS.Caption) = UPPER(CAPTION_LOC) AND !EMPTY(THIS.cFileName)
	THIS.Caption = PROPER(JUSTSTEM(THIS.cFileName))
	THIS.AutoSize = .T.
	THIS.AutoSize = .F.
ENDIF

ENDPROC
PROCEDURE Click
#DEFINE C_SELECTFRX_LOC		"Select Report to Run"

IF THIS.lPromptForReport AND EMPTY(THIS.cFileName)
	THIS.cFileName = GETFILE("FRX",'','',0,C_SELECTFRX_LOC)
ENDIF

IF THIS.lUseOutputDialog
	THIS.ShowOutputDialog()
ELSE
	IF FILE(THIS.cFileName)
		REPORT FORM (THIS.cFileName) PREVIEW
	ENDIF
ENDIF

ENDPROC


************************************************************
OBJETO: _cmdrunreport
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 21, 3, 0

*** METODOS ***


************************************************************
OBJETO: _mailbtn
************************************************************
*** PROPIEDADES ***
Width = 25
Height = 25
BorderWidth = 0
TabIndex = 1
BackColor = 192,192,192
Name = "_mailbtn"

*** METODOS ***
PROCEDURE addtabs
parameters tcString, tnMaxLength
#DEFINE TABSPACES	8 	&& Number of characters that will equal 1 TAB
local i, lnAdd, lnMaxTabs
lnMaxTabs=int(tnMaxLength/TABSPACES)+1
lnAdd = lnMaxTabs - INT(len(tcString)/TABSPACES)
for i = 1 to lnAdd
	tcString = tcString + chr(9)
endfor
return tcString
ENDPROC
PROCEDURE signon
#DEFINE ERR_NOMAPI_LOC	"It does not appear that you have MAPI installed. Mail could not be run."

this.logsession = .T.

IF !FILE(GETENV("WINDIR")+"\SYSTEM32\MAPI32.DLL");
	AND !FILE(GETENV("WINDIR")+"\SYSTEM\MAPI32.DLL")
	MESSAGEBOX(ERR_NOMAPI_LOC)
	RETURN .F.
ENDIF

this.OLEMSess.signon

ENDPROC
PROCEDURE Init
this.logsession = .F.
ENDPROC
PROCEDURE Error
LPARAMETERS nError, cMethod, nLine
LOCAL aErrs
DIMENSION aErrs[1]
AERROR(aErrs)
IF BETWEEN(aErrs[1,1],1420,1450)
	MESSAGEBOX(aErrs[1,3],48)
ELSE
	MESSAGEBOX(message(),48)
ENDIF
this.logsession = .F.
ENDPROC


************************************************************
OBJETO: cmdMail
************************************************************
*** PROPIEDADES ***
Top = 0
Left = 0
Height = 25
Width = 25
Picture = graphics\smmail.bmp
Caption = ""
TabIndex = 1
Name = "cmdMail"

*** METODOS ***
PROCEDURE Click
*:*********************************************************************
*:
*: 	   Class file: \samples\ole\mapibtn.vcx
*:
*:         System: OLE
*:         Author: Microsoft Corporation
*:		  Created: 01/04/95
*:	Last modified: 04/13/95
*:
*:
*:*********************************************************************
* This is sample class which demonstrates how to use the MAPI controls. 
*
* It starts a new Mail session, collects data from the current record, 
* and brings up the Send Mail dialog with the data inserted as the 
* message text.
*
* To use this example, add this class to a form. You will need to open a
* table before pressing the Send Mail button. This will work with any 
* Visual FoxPro table. 
*
* This class includes a custom method addtabs for formatting the 
* information gathered from the table and inserted in the mail message.
*
* This class also takes advantage of another custom method called "signon" 
* as well as a custom property called logsession. This method and property
* are necessary for proper error handling of the MAPI server (i.e. MSMail,
* Exchange, etc.)
*
* This class also uses the smmail.bmp and next.bmp as the icons of the button
* controls.
*
* In order for this button to function properly MSMAPI32.OCX must be 
* correctly registered in the registration database and a mail 
* application supported by the MAPI controls must be installed. The 
* MAPI controls do not work with Windows for Workgroups or Windows 3.1.
*
***********************************************************************

local j, lnMaxLength, i, lcMessageText, lvFieldValue
** j & i are counters

private array paDBFields

*** Localizable Strings
#DEFINE DBF_NOT_FOUND_LOC	"No table is open in the current work area."
#DEFINE GEN_UNSUPPORT_LOC	"General fields are not supported in this example and will be skipped."
#DEFINE _FALSE_LOC			"FALSE"
#DEFINE _TRUE_LOC			"TRUE"
#DEFINE _NULL_LOC			"NULL"
#DEFINE _DOLLARSIGN_LOC		"$"
#DEFINE FLD_NO_PRINT_LOC	"Field could not be printed."
#DEFINE RECORDNUM_LOC		"Record #"

* Verify that a table is open in the current work area
if empty(dbf())
	=messagebox(DBF_NOT_FOUND_LOC,48)
	return
else
	IF !this.parent.signon()			&& Use the custom method
		RETURN
	ENDIF
	IF this.parent.LogSession	&& Check if the user was able to login
		this.parent.OleMMess.sessionid=this.parent.OleMSess.sessionid
	
		* Get the number of fields in the current table
		=afields(paDBFields)

		**** find the longest field string for approximate formatting purposes
		lnMaxLength = 0
		for j = 1 to alen(paDBFields,1)
			if len(paDBFields(j,1))+2 > lnMaxLength
				lnMaxLength = len(paDBFields(j,1))+2
			endif
		endfor
	
		* Start a new mail message and build the text
		this.parent.OleMMess.compose
		lcMessageText=""
		for i = 1 to alen(paDBFields,1)
			lvFieldValue=alltrim(upper(paDBFields(i,1)))
			lcMessageText=lcMessageText+this.parent.addtabs((lvFieldValue+": "),lnMaxLength)
			if !isnull(&lvFieldValue)
				do case
					case paDBFields(i,2)= "N" or paDBFields(i,2)= "B" or paDBFields(i,2)= "F"
						lcMessageText = lcMessageText + alltrim(str(&lvFieldValue))+chr(13)
					case paDBFields(i,2) = "Y"
						lcMessageText = lcMessageText+_DOLLARSIGN_LOC+alltrim(str(&lvFieldValue,10,2))+chr(13)
					case paDBFields(i,2)= "C" or paDBFields(i,2) = "M"
						lcMessageText=lcMessageText + alltrim(&lvFieldValue)+chr(13)
					case paDBFields(i,2)= "G"
						lcMessageText=lcMessageText+GEN_UNSUPPORT_LOC+chr(13)
					case paDBFields(i,2) = "D"
						lcMessageText=lcMessageText + alltrim(DTOC(&lvFieldValue))+chr(13)	
					case paDBFields(i,2) = "T"
						lcMessageText = lcMessageText + alltrim(TTOC(&lvFieldValue))+chr(13)
					case paDBFields(i,2) = "L"
						if &lvFieldValue
							lcMessageText = lcMessageText+_TRUE_LOC+chr(13)
						else
							lcMessageText = lcMessageText+_FALSE_LOC+chr(13)
						endif
					otherwise
						lcMessageText = lcMessageText+FLD_NO_PRINT_LOC+chr(13)				
				endcase
			else
				lcMessageText=lcMessageText+_NULL_LOC
			endif
		endfor
		this.parent.OleMMess.msgnotetext=lcMessageText
		this.parent.OleMMess.msgsubject=justfname(dbf())+": "+RECORDNUM_LOC+alltrim(str(recno()))
		this.parent.OleMMess.send(1)
		IF this.parent.logsession
			this.parent.OleMSess.signoff
		ENDIF	&& Session Handle test
	ENDIF 		&& Login Test
endif			&& DBF Test
	
ENDPROC
PROCEDURE Error
LPARAMETERS nError, cMethod, nLine
=messageb(message(),48)
IF this.parent.logsession 
	this.parent.OLEMSess.signoff
ENDIF
this.parent.logsession = .F.

ENDPROC


************************************************************
OBJETO: oleMmess
************************************************************
*** PROPIEDADES ***
Top = -1000
Left = -1000
Height = 100
Width = 100
Name = "oleMmess"

*** METODOS ***


************************************************************
OBJETO: olemSess
************************************************************
*** PROPIEDADES ***
Top = -1000
Left = -1000
Height = 100
Width = 100
Name = "olemSess"

*** METODOS ***


************************************************************
OBJETO: _mailbtn
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 16, 3, 0

*** METODOS ***


************************************************************
OBJETO: _cmdok
************************************************************
*** PROPIEDADES ***
Height = 30
Width = 94
Caption = "OK"
Default = .F.
Name = "_cmdok"

*** METODOS ***
PROCEDURE Click
IF TYPE("THISFORM.PARENT") = 'O'
	THISFORMSET.Release
ELSE
	THISFORM.Release
ENDIF

ENDPROC
PROCEDURE Error
LPARAMETERS nError, cMethod, nLine

#DEFINE MSG_DATAIN_LOC		"Data in "
#DEFINE MSG_CHANGED_LOC		" was changed by another user."
#DEFINE MSG_SAVE_LOC		"Do you want to save your changes anyway?"
#DEFINE MSG_CONFLICT_LOC	"Data Conflict"
#DEFINE CR_LOC 				CHR(13)

LOCAL nField,cField,nChoice,nRec

DO CASE
	CASE nError = 1585 && Update conflict
	  DO CASE
	    CASE INLIST(CURSORGETPROP('Buffering'), 2,3) && Row Buffering
			FOR nField = 1 to FCOUNT(ALIAS())
			cField = FIELD(m.nField)
			  IF OLDVAL(m.cField) != CURVAL(m.cField)
				nChoice = MESSAGEBOX(MSG_DATAIN_LOC + cField + MSG_CHANGED_LOC + ;
					CR_LOC + MSG_SAVE_LOC, 4+48, MSG_CONFLICT_LOC)
				IF m.nChoice = 6 && yes
					=TABLEUPDATE(.F., .T.)
				ELSE
					=TABLEREVERT(.F.)
				ENDIF
			  ENDIF
			ENDFOR
		CASE INLIST(CURSORGETPROP('Buffering'), 4,5)
		nRec = GETNEXTMODIFIED(0)
		DO WHILE m.nRec > 0
			FOR nField = 1 to FCOUNT(ALIAS())
				cField = FIELD(m.nField)
				IF OLDVAL(cField) != CURVAL(m.cField)
					nChoice = MESSAGEBOX(MSG_DATAIN_LOC + cField + MSG_CHANGED_LOC + ;
					CR_LOC + MSG_SAVE_LOC, 4+48, MSG_CONFLICT_LOC)
					IF m.nChoice = 6 && yes
						=TABLEUPDATE(.F., .T.)
					ELSE
						=TABLEREVERT(.F.)
					ENDIF
				ENDIF
			ENDFOR
			nRec = GETNEXTMODIFIED(m.nRec)	
		ENDDO
		ENDCASE
ENDCASE		

ENDPROC


************************************************************
OBJETO: _cmdok
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


