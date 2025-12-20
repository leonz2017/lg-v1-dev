************************************************************
OBJETO: _webform
************************************************************
*** PROPIEDADES ***
Top = 0
Left = 0
Height = 289
Width = 398
DoCreate = .T.
Caption = "Web Form"
Name = "_webform"

*** METODOS ***
PROCEDURE Init
LPARAMETER cURL
IF !EMPTY(cURL)
	THIS.olewebbrowser.navigate(cURL)
ENDIF
ENDPROC
PROCEDURE Resize
THIS._resizable.adjustcontrols()
ENDPROC


************************************************************
OBJETO: oleWebBrowser
************************************************************
*** PROPIEDADES ***
Top = 12
Left = 12
Height = 264
Width = 372
Name = "oleWebBrowser"

*** METODOS ***


************************************************************
OBJETO: _resizable
************************************************************
*** PROPIEDADES ***
Top = 12
Left = 372
Name = "_resizable"

*** METODOS ***


************************************************************
OBJETO: _webform
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 13, 3, 0

*** METODOS ***


************************************************************
OBJETO: _webbrowser3
************************************************************
*** PROPIEDADES ***
Height = 100
Width = 100
TabStop = .F.
csourcehtml = 
csourcefile = 
curl = 
clasturl = 
cbeforeurl = 
ctempfilename = 
ohost = .NULL.
uvalue = .T.
cnewurl = 
csourceurl = 
csourcefilename = 
cvfpscripttable = 
cvfpscript = 
csourcefilepath = 
cparsefileext = htm;html;asp
nscriptcount = 0
osource = .NULL.
uresult = .T.
oaction = .NULL.
cvfpsprotocol = vfps:
ctempfileprefix = _temp
ureturn = .T.
cblankhtmlfile = Blank.htm
cprogrampath = 
cparam = 
cfilename = 
calias = 
cparamdelimiter = &
cfilepath = 
nrecno = 0
ndatasessionid = 0
cdbf = 
ouser = .NULL.
nhistorycount = 0
cversion = Web Browser 03.01.0016
cdbfpath = 
nuserlevel = 0
cuserid = 
cusername = 
Name = "_webbrowser3"

*** METODOS ***
PROCEDURE refreshsource
LOCAL lcFileName,lcFileName2,lnLastSelect,lcSource,lcAlias

IF this.lRelease
	RETURN .F.
ENDIF
this.cSourceFile=""
this.cSourceHTML=""
IF EMPTY(this.cFileName)
	RETURN .F.
ENDIF
lcFileName=this.cFileName
IF EMPTY(SYS(2000,lcFileName))
	RETURN .F.
ENDIF
lcFileName2=this.TrimPath(lcFileName)
IF WEXIST(lcFileName2)
	RELEASE WINDOW (lcFileName2)
ENDIF
lnLastSelect=SELECT()
lcAlias=LOWER(SYS(2015))
CREATE CURSOR (lcAlias) (Source M)
APPEND BLANK
APPEND MEMO Source FROM (lcFileName) OVERWRITE
lcSource=Source
USE
SELECT (lnLastSelect)
this.cSourceFile=lcFileName
this.cSourceHTML=lcSource

ENDPROC
PROCEDURE viewsource
LPARAMETERS tlNoWait,tlNoEdit
LOCAL lcFileName

#DEFINE HTML_SOURCE_NOT_AVAILABLE_LOC	"HTML source not available"

IF this.lRelease
	RETURN .F.
ENDIF
this.lViewSourceMode=.F.
this.GetSourceHTML()
lcFileName=this.GetSourceFile()
IF EMPTY(lcFileName) OR EMPTY(SYS(2000,lcFileName))
	this.WaitWindow(HTML_SOURCE_NOT_AVAILABLE_LOC)
	RETURN .F.
ENDIF
IF tlNoWait
	IF tlNoEdit
		MODIFY FILE (lcFileName) NOEDIT NOWAIT
	ELSE
		MODIFY FILE (lcFileName) NOWAIT
	ENDIF
	RETURN
ENDIF
this.lViewSourceMode=.T.
IF tlNoEdit
	MODIFY FILE (lcFileName) NOEDIT
ELSE
	MODIFY FILE (lcFileName)
	IF LASTKEY()#27
		this.lHistoryEnabled=.F.
		this.Navigate(lcFileName)
	ENDIF
ENDIF
this.lViewSourceMode=.F.

ENDPROC
PROCEDURE beforeretrieval
PARAMETERS url, flags, targetframename, postdata, headers, cancel
LOCAL lcURL,lcLowerURL,lcNewURL,lnAtPos,lnLastSelect

IF TYPE("this.oHost")#"O" OR ISNULL(this.oHost)
	RETURN .F.
ENDIF
SET DATASESSION TO (this.oHost.DataSessionID)
lcURL=ALLTRIM(url)
this.uResult=.T.
IF this.lRelease OR NOT this.Enabled
	cancel=.T.
	RETURN .F.
ENDIF
lnAtPos=AT("?",lcURL)
IF lnAtPos>0
	lcURL=ALLTRIM(LEFT(lcURL,lnAtPos-1))
ENDIF
this.cLastURL=this.cURL
lcLowerURL=LOWER(lcURL)
IF LOWER(LEFT(lcLowerURL,LEN(this.cVFPSProtocol)))==LOWER(this.cVFPSProtocol)
	cancel=.T.
	this.VFPS(lcURL)
	RETURN .F.
ENDIF
lnLastSelect=SELECT()
IF NOT this.lVFPScript OR NOT this.OpenVFPScript()
	IF USED("vfpscript")
		USE IN vfpscript
	ENDIF
	SELECT (lnLastSelect)
	RETURN
ENDIF
this.Enabled=.F.
SELECT vfpscript
SCAN ALL FOR BeforeNav
	IF NOT EMPTY(URLMatch) AND NOT this.WildCardMatch(ALLTRIM(MLINE(URLMatch,1)),lcURL)
		LOOP
	ENDIF
	IF NOT EMPTY(URLEval) AND (TYPE(URLEval)#"L" OR NOT EVALUATE(URLEval))
		LOOP
	ENDIF
	IF URLCancel
		cancel=.T.
	ENDIF
	IF NOT EMPTY(Script)
		this.RunScript(ALLTRIM(Name))
	ENDIF
	IF NOT USED("vfpscript")
		EXIT
	ENDIF
	SELECT vfpscript
	IF NOT EMPTY(URLJump)
		lcNewURL=ALLTRIM(URLJump)
		this.cURL=LOWER(this.ValidURL(lcNewURL))
		cancel=.T.
		this.Navigate(lcNewURL,@flags,@targetframename,@postdata,@headers)
	ENDIF
	IF NOT Continue
		EXIT
	ENDIF
ENDSCAN
SELECT (lnLastSelect)
this.Enabled=.T.

ENDPROC
PROCEDURE trimext
LPARAMETERS tcFileName,tlPlatformType
LOCAL lcFileName,lnAtPos,lnAtPos2

lcFileName=tcFileName
lnAtPos=RAT(".",lcFileName)
IF lnAtPos>0
	lnAtPos2=RAT(":",lcFileName)
	IF lnAtPos>lnAtPos2
		lcFileName=LEFT(lcFileName,lnAtPos-1)
	ENDIF
ENDIF
IF tlPlatformType
	lcFileName=IIF(_dos OR _unix,UPPER(lcFileName),LOWER(lcFileName))
ENDIF
RETURN ALLTRIM(lcFileName)

ENDPROC
PROCEDURE trimpath
LPARAMETERS tcFileName,tlTrimExt,tlPlatformType
LOCAL lcFileName,lnAtPos

IF EMPTY(tcFileName)
	RETURN ""
ENDIF
lcFileName=tcFileName
lnAtPos=AT(":",lcFileName)
IF lnAtPos>0
	lcFileName=SUBSTR(lcFileName,lnAtPos+1)
ENDIF
IF tlTrimExt
	lcFileName=this.TrimExt(lcFileName)
ENDIF
IF tlPlatformType
	lcFileName=IIF(_dos OR _unix,UPPER(lcFileName),LOWER(lcFileName))
ENDIF
lcFileName=ALLTRIM(SUBSTR(lcFileName,AT("\",lcFileName,;
		MAX(OCCURS("\",lcFileName),1))+1))
DO WHILE LEFT(lcFileName,1)=="."
	lcFileName=ALLTRIM(SUBSTR(lcFileName,2))
ENDDO
DO WHILE RIGHT(lcFileName,1)=="."
	lcFileName=ALLTRIM(LEFT(lcFileName,LEN(lcFileName)-1))
ENDDO
RETURN lcFileName

ENDPROC
PROCEDURE trimfile
LPARAMETERS tcFileName,lPlatType
LOCAL lcFileName,lnAtPos

lnAtPos=RAT("\",tcFileName)
lcFileName=ALLTRIM(IIF(lnAtPos=0,tcFileName,LEFT(tcFileName,lnAtPos)))
IF lPlatType
	lcFileName=IIF(_dos OR _unix,UPPER(lcFileName),LOWER(lcFileName))
ENDIF
RETURN lcFileName

ENDPROC
PROCEDURE erasetempfile
IF NOT EMPTY(this.cTempFileName)
	ERASE (this.cTempFileName)
	this.cTempFileName=""
ENDIF

ENDPROC
PROCEDURE getsourcefile
IF this.lRelease
	RETURN .F.
ENDIF
IF EMPTY(this.cSourceFile)
	this.RefreshSource
ENDIF
RETURN this.cSourceFile

ENDPROC
PROCEDURE getsourcehtml
IF this.lRelease
	RETURN .F.
ENDIF
IF EMPTY(this.cSourceHTML)
	this.RefreshSource
ENDIF
RETURN this.cSourceHTML

ENDPROC
PROCEDURE parsesource
*** OLE Control Event ***
PARAMETERS url, flags, targetframename, postdata, headers, cancel
PRIVATE oTHIS
LOCAL lcURL,lcSource,lcNewURL,lcFileName,lnAtPos,llHTMLFile,llBusy
EXTERNAL ARRAY VFPScrpt

IF this.lRelease OR NOT this.lParseSource OR TYPE("url")#"C" OR EMPTY(url)
	RETURN .F.
ENDIF
lcURL=ALLTRIM(url)
lcFileName=STRTRAN(lcURL,"/","\")
lnAtPos=RAT("\",lcFileName)
IF lnAtPos>0 AND LOWER(SUBSTR(lcFileName,lnAtPos+1, ;
		LEN(this.cTempFilePrefix)))==this.cTempFilePrefix
	RETURN .F.
ENDIF
this.cFileName=""
this.cFilePath=""
this.cSourceURL=""
this.cSourceFileName=""
llHTMLFile=.F.
lnAtPos=RAT(".",lcURL)
llHTMLFile=(lnAtPos>0 AND INLIST(LOWER(ALLTRIM(SUBSTR(lcURL,lnAtPos+1))), ;
		"htm","html","asp"))
IF NOT llHTMLFile OR LOWER(lcFileName)==LOWER(this.cTempFileName) OR ;
		LOWER(ALLTRIM(lcFileName))==LOWER(ALLTRIM(this.cBlankHTMLFile))
	this.cFileName=lcFileName
	this.cFilePath=this.TrimFile(this.cFileName)
	RETURN .F.
ENDIF
lnAtPos=RAT(":",lcFileName)
IF lnAtPos#2 
	RETURN .F.
ENDIF
IF lnAtPos>2
	lcFileName=ALLTRIM(SUBSTR(lcFileName,lnAtPos-1))
ENDIF
IF EMPTY(SYS(2000,lcFileName))
	RETURN .F.
ENDIF
IF this.lDebug
	ACTIVATE SCREEN
	? PROGRAM()
	? "URL: "+lcURL
ENDIF
llBusy=this.lBusy
this.SetBusyState(.T.)
IF NOT ":"$lcURL OR AT(":",lcURL)=2
	lcURL="file://"+STRTRAN(STRTRAN(STRTRAN(lcURL,"\","/"),"///","//"),"//","/")
ENDIF
lcNewURL=""
oTHIS=this
this.cSourceURL=lcURL
this.cFileName=LOWER(lcFileName)
this.cFilePath=this.TrimFile(this.cFileName)
this.cSourceFileName=this.cFileName
this.cSourceFilePath=this.TrimFile(this.cFileName)
IF VFPScrpt(this)
	lcNewURL=this.cTempFileName
ELSE
	this.cSourceURL=""
	this.cSourceFileName=""
	this.cSourceFilePath=""
ENDIF
oTHIS=.NULL.
this.SetBusyState(llBusy)
IF TYPE("this.oHost.lRelease")=="L" AND this.oHost.lRelease
	this.Visible=.F.
	RETURN .F.
ENDIF
this.cURL=LOWER(this.ValidURL(lcURL))
this.cNewURL=lcNewURL

ENDPROC
PROCEDURE runcode
LPARAMETERS tcCode
PRIVATE oTHIS
LOCAL lnDataSessionID,lnLastSelect,llBusy

IF this.lRelease OR EMPTY(tcCode) OR TYPE("tcCode")#"C" OR ISNULL(tcCode)
	RETURN .F.
ENDIF
IF this.lDebug
	ACTIVATE SCREEN
	? PROGRAM()
ENDIF
llBusy=this.lBusy
this.SetBusyState(.T.)
lnLastSelect=SELECT()
lnDataSessionID=this.oHost.DataSessionID
SET DATASESSION TO (lnDataSessionID)
ACTIVATE SCREEN
oTHIS=this
this.lRunCodeMode=.T.
DO RunCode WITH (tcCode)
this.lRunCodeMode=.F.
oTHIS=.NULL.
SET DATASESSION TO (lnDataSessionID)
SELECT (lnLastSelect)
this.SetBusyState(llBusy)

ENDPROC
PROCEDURE runscript
LPARAMETERS tcScript,tcAlias
LOCAL llResult

IF this.lRelease OR EMPTY(tcScript)
	RETURN .F.
ENDIF
IF this.lDebug
	ACTIVATE SCREEN
	? PROGRAM()
	? "Script: "+tcScript
ENDIF
llResult=this.VFPScript(tcScript,tcAlias,0)
IF this.lDebug AND NOT llResult
	ACTIVATE SCREEN
	? "Script: "+tcScript+"  (not found)"
ENDIF
RETURN llResult

ENDPROC
PROCEDURE validurl
LPARAMETERS tcURL
LOCAL lcURL

IF EMPTY(tcURL)
	RETURN ""
ENDIF
lcURL=ALLTRIM(tcURL)
IF NOT ":"$lcURL AND NOT LOWER(LEFT(lcURL,4))=="http" AND ;
		NOT LOWER(LEFT(lcURL,5))=="file:" AND (LOWER(LEFT(lcURL,4))=="www." OR ;
		INLIST(LOWER(RIGHT(lcURL,4)),".com",".gov",".net") OR ;
		(NOT SUBSTR(lcURL,2,1)==":" AND NOT LEFT(lcURL,2)=="\\"))
	lcURL="http://"+lcURL
ENDIF
IF SUBSTR(PADR(lcURL,5),5,1)==":"
	lcURL=STRTRAN(STRTRAN(lcURl,"\","/"),"///","//")
ELSE
	IF NOT ":"$lcURL OR AT(":",lcURL)=2
		lcURL="file://"+STRTRAN(STRTRAN(STRTRAN(lcURL,"\","/"),"///","//"),"//","/")
	ENDIF
ENDIF
RETURN lcURL

ENDPROC
PROCEDURE wildcardmatch
LPARAMETERS tcMatchExpList,tcExpressionSearched,tlMatchAsIs
LOCAL lcMatchExpList,lcExpressionSearched,llMatchAsIs,lcMatchExpList2
LOCAL lnMatchLen,lnExpressionLen,lnMatchCount,lnCount,lnCount2,lnSpaceCount
LOCAL lcMatchExp,lcMatchType,lnMatchType,lnAtPos,lnAtPos2
LOCAL llMatch,llMatch2

IF EMPTY(tcExpressionSearched)
	IF EMPTY(tcMatchExpList) OR ALLTRIM(tcMatchExpList)=="*"
		RETURN
	ENDIF
	RETURN .F.
ENDIF
lcMatchExpList=LOWER(ALLTRIM(STRTRAN(tcMatchExpList,TAB," ")))
lcExpressionSearched=LOWER(ALLTRIM(STRTRAN(tcExpressionSearched,TAB," ")))
lnExpressionLen=LEN(lcExpressionSearched)
IF lcExpressionSearched==lcMatchExpList
	RETURN
ENDIF
llMatchAsIs=tlMatchAsIs
IF LEFT(lcMatchExpList,1)==["] AND RIGHT(lcMatchExpList,1)==["]
	llMatchAsIs=.T.
	lcMatchExpList=ALLTRIM(SUBSTR(lcMatchExpList,2,LEN(lcMatchExpList)-2))
ENDIF
IF NOT llMatchAsIs AND " "$lcMatchExpList
	llMatch=.F.
	lnSpaceCount=OCCURS(" ",lcMatchExpList)
	lcMatchExpList2=lcMatchExpList
	lnCount=0
	DO WHILE .T.
		lnAtPos=AT(" ",lcMatchExpList2)
		IF lnAtPos=0
			lcMatchExp=ALLTRIM(lcMatchExpList2)
			lcMatchExpList2=""
		ELSE
			lnAtPos2=AT(["],lcMatchExpList2)
			IF lnAtPos2<lnAtPos
				lnAtPos2=AT(["],lcMatchExpList2,2)
				IF lnAtPos2>lnAtPos
					lnAtPos=lnAtPos2
				ENDIF
			ENDIF
			lcMatchExp=ALLTRIM(LEFT(lcMatchExpList2,lnAtPos))
			lcMatchExpList2=ALLTRIM(SUBSTR(lcMatchExpList2,lnAtPos+1))
		ENDIF
		IF EMPTY(lcMatchExp)
			EXIT
		ENDIF
		lcMatchType=LEFT(lcMatchExp,1)
		DO CASE
			CASE lcMatchType=="+"
				lnMatchType=1
			CASE lcMatchType=="-"
				lnMatchType=-1
			OTHERWISE
				lnMatchType=0
		ENDCASE
		IF lnMatchType#0
			lcMatchExp=ALLTRIM(SUBSTR(lcMatchExp,2))
		ENDIF
		llMatch2=this.WildCardMatch(lcMatchExp,lcExpressionSearched,.T.)
		IF (lnMatchType=1 AND NOT llMatch2) OR (lnMatchType=-1 AND llMatch2)
			RETURN .F.
		ENDIF
		llMatch=(llMatch OR llMatch2)
		IF lnAtPos=0
			EXIT
		ENDIF
	ENDDO
	RETURN llMatch
ELSE
	IF LEFT(lcMatchExpList,1)=="~"
		RETURN (DIFFERENCE(ALLTRIM(SUBSTR(lcMatchExpList,2)),lcExpressionSearched)>=3)
	ENDIF
ENDIF
lnMatchCount=OCCURS(",",lcMatchExpList)+1
IF lnMatchCount>1
	lcMatchExpList=","+ALLTRIM(lcMatchExpList)+","
ENDIF
FOR lnCount = 1 TO lnMatchCount
	IF lnMatchCount=1
		lcMatchExp=LOWER(ALLTRIM(lcMatchExpList))
		lnMatchLen=LEN(lcMatchExp)
	ELSE
		lnAtPos=AT(",",lcMatchExpList,lnCount)
		lnMatchLen=AT(",",lcMatchExpList,lnCount+1)-lnAtPos-1
		lcMatchExp=LOWER(ALLTRIM(SUBSTR(lcMatchExpList,lnAtPos+1,lnMatchLen)))
	ENDIF
	FOR lnCount2 = 1 TO OCCURS("?",lcMatchExp)
		lnAtPos=AT("?",lcMatchExp)
		IF lnAtPos>lnExpressionLen
			IF (lnAtPos-1)=lnExpressionLen
				lcExpressionSearched=lcExpressionSearched+"?"
			ENDIF
			EXIT
		ENDIF
		lcMatchExp=STUFF(lcMatchExp,lnAtPos,1,SUBSTR(lcExpressionSearched,lnAtPos,1))
	ENDFOR
	IF EMPTY(lcMatchExp) OR lcExpressionSearched==lcMatchExp OR ;
			lcMatchExp=="*" OR lcMatchExp=="?" OR lcMatchExp=="%%"
		RETURN
	ENDIF
	IF LEFT(lcMatchExp,1)=="*"
		RETURN (SUBSTR(lcMatchExp,2)==RIGHT(lcExpressionSearched,LEN(lcMatchExp)-1))
	ENDIF
	IF LEFT(lcMatchExp,1)=="%" AND RIGHT(lcMatchExp,1)=="%" AND ;
			SUBSTR(lcMatchExp,2,lnMatchLen-2)$lcExpressionSearched
		RETURN
	ENDIF
	lnAtPos=AT("*",lcMatchExp)
	IF lnAtPos>0 AND (lnAtPos-1)<=lnExpressionLen AND ;
			LEFT(lcExpressionSearched,lnAtPos-1)==LEFT(lcMatchExp,lnAtPos-1)
		RETURN
	ENDIF
ENDFOR
RETURN .F.

ENDPROC
PROCEDURE refreshmode
LOCAL llBusy

IF this.lRelease OR EMPTY(this.cSourceFileName)
	this.lRefreshMode=.F.
	RETURN .F.
ENDIF
llBusy=this.lBusy
this.SetBusyState(.T.)
this.lRefreshMode=.T.
this.lHistoryEnabled=.F.
this.Navigate(this.cSourceFileName)
this.SetBusyState(llBusy)

ENDPROC
PROCEDURE openvfpscript
LOCAL lcFileName,lnLastSelect,lcLastSetSafety

SET DATASESSION TO (this.oHost.DataSessionID)
IF USED("vfpscript")
	RETURN
ENDIF
IF this.lRelease OR NOT this.lVFPScript OR EMPTY(this.cVFPScript)
	RETURN .F.
ENDIF
lcLastSetSafety=SET("SAFETY")
SET SAFETY OFF
lnLastSelect=SELECT()
lcFileName=this.cVFPScript
IF NOT EMPTY(SYS(2000,lcFileName))
	SELECT 0
	USE (lcFileName) SHARED ALIAS vfpscript AGAIN
	IF NOT USED()
		SELECT (lnLastSelect)
		IF lcLastSetSafety=="ON"
			SET SAFETY ON
		ELSE
			SET SAFETY OFF
		ENDIF
		RETURN .F.
	ENDIF
	IF FCOUNT()<9
		USE
		ERASE (lcFileName)
	ENDIF
ENDIF
IF EMPTY(SYS(2000,lcFileName)) OR TYPE("BeforeNav")#"L"
	IF USED("vfpscript")
		USE IN vfpscript
	ENDIF
	ERASE (lcFileName)
	SELECT 0
	CREATE TABLE (lcFileName) ;
			(IndexValue C(10), Name C(24), HTML M, Script M, BeforeNav L, URLMatch M, ;
			URLEval M, URLJump M, URLCancel L, ;
			Continue L, Comment M, LastAccess T, ExecCount N(8))
	USE (lcFileName) SHARED ALIAS vfpscript AGAIN
ENDIF
IF TYPE("LastAccess")#"T" OR TYPE("ExecCount")#"N"
	IF USED("vfpscript")
		USE IN vfpscript
	ENDIF
	SELECT 0
	USE (lcFileName) EXCLUSIVE ALIAS vfpscript
	IF NOT USED()
		SELECT (lnLastSelect)
		IF lcLastSetSafety=="ON"
			SET SAFETY ON
		ELSE
			SET SAFETY OFF
		ENDIF
		RETURN .F.
	ENDIF
	IF TYPE("LastAccess")#"T"
		ALTER TABLE (lcFileName) ADD COLUMN LastAccess T NULL
	ENDIF
	IF TYPE("ExecCount")#"N"
		ALTER TABLE (lcFileName) ADD COLUMN ExecCount N(8) NULL
	ENDIF
	USE (lcFileName) SHARED ALIAS vfpscript AGAIN
ENDIF
IF NOT USED("vfpscript")
	SELECT (lnLastSelect)
	IF lcLastSetSafety=="ON"
		SET SAFETY ON
	ELSE
		SET SAFETY OFF
	ENDIF
	RETURN .F.
ENDIF
SELECT vfpscript
IF KEY(1)=="INDEXVALUE"
	SET ORDER TO IndexValue
ELSE
	INDEX ON IndexValue TAG IndexValue ASCENDING ADDITIVE
ENDIF
SET FILTER TO NOT DELETED()
LOCATE
SELECT 0

ENDPROC
PROCEDURE refreshdeactivate
IF this.lRelease OR NOT this.Visible
	RETURN
ENDIF
IF this.lRefreshDeactivate
	this.Visible=.F.
	this.Visible=.T.
	RETURN
ENDIF

ENDPROC
PROCEDURE releasehost
IF this.lRelease
	RETURN .F.
ENDIF
IF TYPE("this.oHost.tmrHost")#"O"
	RETURN .F.
ENDIF
this.oHost.tmrHost.RunCode("oTHIS.oHost.Release")

ENDPROC
PROCEDURE vfps
LPARAMETERS tcCommand
LOCAL lcCommand,lcParam1,lcParameter,lcAlias,lcVFPSProtocol,lnVFPSProtocolLen
LOCAL lcVariable,lcCode,lnCount,lnAtPos,llEnabled,luResult,llBusy

IF this.lRelease OR EMPTY(tcCommand) OR TYPE("this.oHost")#"O" OR ISNULL(this.oHost)
	RETURN .F.
ENDIF
llBusy=this.lBusy
this.SetBusyState(.T.)
llEnabled=this.Enabled
IF this.oHost.Visible
	this.Enabled=.F.
ENDIF
lcCommand=LOWER(ALLTRIM(tcCommand))
lcVFPSProtocol=LOWER(this.cVFPSProtocol)
lnVFPSProtocolLen=LEN(lcVFPSProtocol)
IF LEFT(lcCommand,lnVFPSProtocolLen)==lcVFPSProtocol
	lcCommand=ALLTRIM(SUBSTR(lcCommand,lnVFPSProtocolLen+1))
ENDIF
DO WHILE LEFT(lcCommand,1)=="/"
	lcCommand=ALLTRIM(SUBSTR(lcCommand,2))
ENDDO
DO WHILE RIGHT(lcCommand,1)=="/"
	lcCommand=ALLTRIM(LEFT(lcCommand,LEN(lcCommand)-1))
ENDDO
lnAtPos=AT("?",lcCommand)
IF lnAtPos>0
	this.SetParam(lcCommand)
	lcCommand=ALLTRIM(LEFT(lcCommand,lnAtPos-1))
ENDIF
FOR lnCount = 1 TO this.nParamCount
	lcParameter=this.aParam[lnCount]
	lnAtPos=AT("=",lcParameter)
	IF lnAtPos=0
		lcVariable=""
	ELSE
		lcVariable=ALLTRIM(LEFT(lcParameter,lnAtPos-1))
		lcParameter=ALLTRIM(SUBSTR(lcParameter,lnAtPos+1))
	ENDIF
	IF LEFT(lcParameter,1)=="(" AND RIGHT(lcParameter,1)==")"
		IF STRTRAN(STRTRAN(lcParameter,CHR(9),"")," ","")=="()"
			this.aParam[lnCount]=""
		ELSE
			this.aParam[lnCount]=EVALUATE(lcParameter)
		ENDIF
	ELSE
		this.aParam[lnCount]=lcParameter
	ENDIF
	IF NOT EMPTY(lcVariable) AND NOT LEFT(lcVariable,1)==";"
		lcParameter=this.aParam[lnCount]
		IF NOT "."$lcVariable
			PRIVATE (lcVariable)
		ENDIF
		lcCode=lcVariable+"=lcParameter"
		&lcCode
	ENDIF
ENDFOR
lcParam1=this.aParam[1]
IF this.lDebug
	ACTIVATE SCREEN
	? PROGRAM()
	? "Command: "+lcCommand+"  Param: "+this.cParam
ENDIF
DO CASE
	CASE lcCommand=="refresh"
		luResult=this.Refresh2()
	CASE lcCommand=="releasehost"
		luResult=this.ReleaseHost()
	CASE lcCommand=="runaction"
		luResult=this.RunAction(lcParam1)
	CASE lcCommand=="runmethod"
		lcParam1=this.cParam
		IF NOT RIGHT(lcParam1,1)==")"
			lcParam1=lcParam1+"()"
		ENDIF
		luResult=this.&lcParam1
	CASE lcCommand=="runcode"
		luResult=this.RunCode(lcParam1)
	CASE lcCommand=="runscript"
		lcAlias=""
		lnAtPos=AT("::",lcParam1)
		IF lnAtPos>0
			lcAlias=ALLTRIM(LEFT(lcParam1,lnAtPos-1))
			lcParam1=ALLTRIM(SUBSTR(lcParam1,lnAtPos+2))
		ENDIF
		luResult=this.RunScript(lcParam1,lcAlias)
	CASE lcCommand=="viewsource"
		luResult=this.ViewSource()
	OTHERWISE
		luResult=.F.
ENDCASE
this.Enabled=llEnabled
this.SetBusyState(llBusy)
RETURN luResult

ENDPROC
PROCEDURE runaction
LPARAMETERS tcMethod
LOCAL lcMethod,llResult,llBusy

this.uResult=.T.
IF this.lRelease OR EMPTY(tcMethod) OR TYPE("this.oAction")#"O" OR ISNULL(this.oAction)
	RETURN .F.
ENDIF
lcMethod=LOWER(ALLTRIM(tcMethod))
IF EMPTY(lcMethod) OR NOT PEMSTATUS(this.oAction,lcMethod,5) OR ;
		PEMSTATUS(this.oAction,lcMethod,2) OR ;
		NOT PEMSTATUS(this.oAction,lcMethod,3)=="Method"
	RETURN .F.
ENDIF
llBusy=this.lBusy
this.SetBusyState(.T.)
llResult=EVALUATE("this.oAction."+lcMethod+"()")
llBusy=this.lBusy
this.SetBusyState(llBusy)
RETURN llResult

ENDPROC
PROCEDURE filetostring
LPARAMETERS tcFileName
LOCAL lcFileName,lnLastSelect,lcAlias,lcText

IF PARAMETERS()#1  OR TYPE("tcFileName")#"C" OR EMPTY(tcFileName)
	RETURN ""
ENDIF
lcFileName=ALLTRIM(tcFileName)
IF NOT "."$lcFileName
	lcFileName=lcFileName+".txt"
ENDIF
lnLastSelect=SELECT()
lcAlias=LOWER(SYS(2015))
CREATE CURSOR (lcAlias) (Text M)
APPEND BLANK
APPEND MEMO Text FROM (tcFileName) OVERWRITE
lcText=Text
USE IN (lcAlias)
SELECT (lnLastSelect)
RETURN lcText

ENDPROC
PROCEDURE stringtofile
LPARAMETERS tcText,tcFileName
LOCAL lcFileName,lnLastSelect,lcAlias

IF PARAMETERS()#2 OR TYPE("tcText")#"C" OR TYPE("tcFileName")#"C" OR EMPTY(tcFileName)
	RETURN .F.
ENDIF
lcFileName=ALLTRIM(tcFileName)
IF NOT "."$lcFileName
	lcFileName=lcFileName+".txt"
ENDIF
lnLastSelect=SELECT()
lcAlias=LOWER(SYS(2015))
CREATE CURSOR (lcAlias) (Text M)
INSERT INTO (lcAlias) (Text) VALUES (tcText)
COPY MEMO Text TO (tcFileName)
USE IN (lcAlias)
SELECT (lnLastSelect)

ENDPROC
PROCEDURE setparam
LPARAMETERS tcParam
LOCAL lcParam,lcParameter,lcParamDelimiter,lnParamTotal,lnCount,lnAtPos

lcParam=IIF(EMPTY(tcParam),"",ALLTRIM(tcParam))
lnAtPos=AT("?",lcParam)
IF lnAtPos=0
	lcParam=""
ELSE
	lcParam=ALLTRIM(SUBSTR(lcParam,lnAtPos+1))
ENDIF
this.nParamCount=0
DIMENSION this.aParam[128]
this.aParam=.F.
IF EMPTY(lcParam)
	this.cParam=""
	RETURN
ENDIF
IF RIGHT(lcParam,1)=="/"
	lcParam=ALLTRIM(LEFT(lcParam,LEN(lcParam)-1))
ENDIF
this.cParam=lcParam
lcParamDelimiter=this.cParamDelimiter
lnParamTotal=MIN(OCCURS(lcParamDelimiter,lcParam)+1,128)
FOR lnCount = 1 TO lnParamTotal
	this.nParamCount=this.nParamCount+1
	lnAtPos=AT(lcParamDelimiter,lcParam)
	IF lnAtPos=0
		lcParameter=ALLTRIM(lcParam)
	ELSE
		lcParameter=ALLTRIM(LEFT(lcParam,lnAtPos-1))
		lcParam=ALLTRIM(SUBSTR(lcParam,lnAtPos+1))
	ENDIF
	this.aParam[lnCount]=lcParameter
ENDFOR

ENDPROC
PROCEDURE gethtml
LPARAMETERS tcName,tcAlias
LOCAL lcHTML,llResult

IF this.lDebug
	ACTIVATE SCREEN
	? PROGRAM()
	? "Name: "+tcName
ENDIF
lcHTML=this.VFPScript(tcName,tcAlias,1)
llResult=(TYPE("lcHTML")=="C")
IF NOT llResult
	lcHTML=""
ENDIF
IF this.lDebug AND NOT llResult
	ACTIVATE SCREEN
	? "Name: "+tcName+"  (not found)"
ENDIF
RETURN lcHTML

ENDPROC
PROCEDURE vfpscript
LPARAMETERS tcName,tcAlias,tnCode
LOCAL lcName,lcAlias,lnLastSelect,lnRecNo,ltDateTime,llMatch
LOCAL llMatch,lcScriptCode,lcHTML

IF TYPE("this.oHost")#"O" OR ISNULL(this.oHost)
	RETURN .F.
ENDIF
SET DATASESSION TO (this.oHost.DataSessionID)
this.uResult=.T.
IF this.lRelease OR EMPTY(tcName) OR TYPE("tnCode")#"N"
	RETURN .F.
ENDIF
ltDateTime=DATETIME()
lcName=LOWER(ALLTRIM(tcName))
lcAlias=IIF(EMPTY(tcAlias),"vfpscript",LOWER(ALLTRIM(tcAlias)))
lnLastSelect=SELECT()
llMatch=.F.
lcScriptCode=""
lcHTML=""
FOR lnCount = 1 TO this.nScriptCount
	IF NOT LOWER(this.aScripts[lnCount,1])==lcName
		LOOP
	ENDIF
	llMatch=.T.
	lcScriptCode=this.aScripts[lnCount,2]
	lcHTML=lcScriptCode
ENDFOR
IF NOT llMatch
	IF EMPTY(tcAlias) AND NOT this.OpenVFPScript()
		SELECT (lnLastSelect)
		RETURN .F.
	ENDIF
	IF NOT USED(lcAlias)
		SELECT (lnLastSelect)
		RETURN .F.
	ENDIF
	SELECT (lcAlias)
	lnRecNo=IIF(EOF() OR RECNO()>RECCOUNT(),0,RECNO())
	IF NOT LOWER(ALLTRIM(Name))==lcName
		LOCATE FOR LOWER(ALLTRIM(Name))==lcName
	ENDIF
	llMatch=(NOT EMPTY(Name))
	IF llMatch
		IF TYPE("LastAccess")=="T"
			REPLACE LastAccess WITH ltDateTime, ExecCount WITH ExecCount+1
		ENDIF
		lcScriptCode=Script
		lcHTML=HTML
	ENDIF
	IF lnRecNo=0
		GO BOTTOM
	ELSE
		GO lnRecNo
	ENDIF
ENDIF
SELECT (lnLastSelect)
DO CASE
	CASE tnCode=0
		IF this.lDesign
			this.EditScript(lcName)
			RETURN
		ENDIF
		RETURN this.RunCode(lcScriptCode)
	CASE tnCode=1
		RETURN lcHTML
ENDCASE
RETURN .F.

ENDPROC
PROCEDURE msgbox
LPARAMETERS tcMessage,tnType,tcTitle
LOCAL lcMessage,lnType,lcTitle,lnResult

lcMessage=IIF(TYPE("tcMessage")#"C","",tcMessage)
lnType=IIF(TYPE("tnType")#"N",48,tnType)
lcTitle=IIF(TYPE("tcTitle")#"C",thisform.Caption,tcTitle)
ACTIVATE SCREEN
lnResult=MESSAGEBOX(lcMessage,lnType,lcTitle)
RETURN lnResult

ENDPROC
PROCEDURE editstring
LPARAMETERS tcString,tcTitle,tlNoEdit
LOCAL lcString,lcTitle,lcTempFileName

lcString=IIF(TYPE("tcString")=="C",tcString,"")
lcTitle=IIF(TYPE("tcTitle")=="C",ALLTRIM(tcTitle),LOWER(SYS(2015)))
lcTempFileName=SYS(2023)+"\"+"~_  "+lcTitle+".htm"
IF NOT this.StringToFile(lcString,lcTempFileName)
	RETURN .F.
ENDIF
ACTIVATE SCREEN
IF tlNoEdit
	MODIFY FILE (lcTempFileName) NOEDIT RANGE 1,1
ELSE
	MODIFY FILE (lcTempFileName) RANGE 1,1
	lcString=this.FileToString(lcTempFileName)
ENDIF
ERASE (lcTempFileName)
RETURN lcString

ENDPROC
PROCEDURE editscript
LPARAMETERS tcScriptName
LOCAL lcScriptName,lcOldScriptCode,lcNewScriptCode,lnScriptNum,lcScriptNameSearch
LOCAL lcFileName,lcOldHTML,lcNewHTML,llResult,llMatch,llNoEdit,lcCR_LF

#DEFINE SCRIPT_LOC					"Script"
#DEFINE NOT_FOUND_IN_FILE_LOC		"not found in file"
#DEFINE IN_FILE_LOC					"in file"
#DEFINE UPDATED_LOC					"updated"
#DEFINE	UNABLE_TO_UPDATE_SCRIPT_LOC	"Unable to update script"

IF EMPTY(tcScriptName)
	RETURN .F.
ENDIF
lcCR_LF=CHR(13)+CHR(10)
lcScriptName=ALLTRIM(tcScriptName)
lcFileName=this.cFileName
llMatch=.F.
FOR lnScriptNum = 1 TO this.nScriptCount
	IF LOWER(lcScriptName)==LOWER(this.aScripts[lnScriptNum,1])
		lcScriptName=this.aScripts[lnScriptNum,1]
		lcOldScriptCode=this.aScripts[lnScriptNum,3]
		llMatch=.T.
		EXIT
	ENDIF
ENDFOR
IF NOT llMatch
	this.MsgBox(SCRIPT_LOC+[ (]+lcScriptName+[) ]+NOT_FOUND_IN_FILE_LOC+[ "]+lcFileName+[".],16)
	RETURN .F.
ENDIF
lcScriptNameSearch=" "+lcScriptName+lcCR_LF
lcOldHTML=this.FileToString(lcFileName)
llNoEdit=(NOT lcScriptNameSearch$lcOldHTML)
lcNewScriptCode=this.EditString(lcOldScriptCode,lcScriptName,llNoEdit)
IF llNoEdit OR lcOldScriptCode==lcNewScriptCode
	RETURN
ENDIF
IF NOT RIGHT(lcNewScriptCode,2)==lcCR_LF
	lcNewScriptCode=lcNewScriptCode+lcCR_LF
ENDIF
this.aScripts[lnScriptNum,3]=lcNewScriptCode
lcNewHTML=STRTRAN(lcOldHTML,lcScriptNameSearch+lcOldScriptCode, ;
		lcScriptNameSearch+lcNewScriptCode)
IF lcOldHTML==lcNewHTML
	llResult=.F.
ELSE
	llResult=this.StringToFile(lcNewHTML,lcFileName)
ENDIF
IF NOT llResult
	this.MsgBox(UNABLE_TO_UPDATE_SCRIPT_LOC+[ (]+lcScriptName+[) ]+IN_FILE_LOC+[ "]+lcFileName+[".],16)
	RETURN .F.
ENDIF
this.WaitWindow(SCRIPT_LOC+[ (]+lcScriptName+[) ]+IN_FILE_LOC+[ "]+lcFileName+[" ]+UPDATED_LOC+[.])

ENDPROC
PROCEDURE opentable
LPARAMETERS tcFileName,tcAlias,tlExclusive,tcFilter
LOCAL lcFileName,lcAlias,lnLastSelect

this.nRecNo=0
this.cAlias=""
this.cDBF=""
this.cDBFPath=""
IF EMPTY(tcFileName)
	RETURN .F.
ENDIF
lcFileName=ALLTRIM(tcFileName)
IF NOT "."$lcFileName
	lcFileName=lcFileName+".dbf"
ENDIF
IF NOT FILE(lcFileName)
	RETURN .F.
ENDIF
SET DATASESSION TO (this.nDataSessionID)
lcAlias=STRTRAN(IIF(EMPTY(tcAlias),this.TrimPath(lcFileName,.T.),ALLTRIM(tcAlias))," ","_")
this.cAlias=lcAlias
IF USED(lcAlias)
	this.nRecNo=RECNO(lcAlias)
	this.cDBF=LOWER(DBF(lcAlias))
	this.cDBFPath=this.TrimFile(this.cDBF)
	SET DATASESSION TO (this.oHost.DataSessionID)
	RETURN
ENDIF
lnLastSelect=SELECT()
SELECT 0
IF tlExclusive
	USE (lcFileName) EXCLUSIVE ALIAS (lcAlias)
ELSE
	USE (lcFileName) AGAIN SHARED ALIAS (lcAlias)
ENDIF
IF NOT USED(lcAlias)
	this.nRecNo=0
	this.cAlias=""
	this.cDBF=""
	this.cDBFPath=""
	SELECT (lnLastSelect)
	RETURN .F.
ENDIF
this.cDBF=LOWER(DBF(lcAlias))
this.cDBFPath=this.TrimFile(this.cDBF)
IF NOT EMPTY(tcFilter)
	SET FILTER TO &tcFilter
ENDIF
LOCATE
SELECT (lnLastSelect)
SET DATASESSION TO (this.oHost.DataSessionID)

ENDPROC
PROCEDURE browsetable
LPARAMETERS tcAlias,tcClauses
LOCAL lcAlias,lnLastSelect,lcCommand

lcAlias=IIF(EMPTY(tcAlias),this.cAlias,ALLTRIM(tcAlias))
IF EMPTY(lcAlias) OR NOT USED(lcAlias)
	RETURN .F.
ENDIF
lnLastSelect=SELECT()
SELECT (lcAlias)
IF BETWEEN(this.nRecNo,1,RECCOUNT())
	GO this.nRecNo
ELSE
	LOCATE
ENDIF
ACTIVATE SCREEN
lcCommand="BROWSE"
IF NOT EMPTY(tcClauses)
	lcCommand=lcCommand+" "+tcClauses
ENDIF
&lcCommand
SELECT (lnLastSelect)

ENDPROC
PROCEDURE waitwindow
LPARAMETERS tcText,tlWait
LOCAL lcText

WAIT CLEAR
IF EMPTY(tcText)
	RETURN
ENDIF
lcText=LEFT(tcText,254)
DO CASE
	CASE TYPE("tlWait")=="L"
		IF tlWait
			WAIT WINDOW tcText
		ELSE
			WAIT WINDOW tcText NOWAIT
		ENDIF
	CASE TYPE("tlWait")=="N"
		WAIT WINDOW tcText TIMEOUT (tlWait)
	OTHERWISE
		RETURN .F.
ENDCASE

ENDPROC
PROCEDURE setbusystate
LPARAMETERS tlBusy

IF this.lBusy=tlBusy
	RETURN
ENDIF
this.lBusy=tlBusy

ENDPROC
PROCEDURE closetable
LPARAMETERS tcAlias
LOCAL lcAlias

SET DATASESSION TO (this.nDataSessionID)
lcAlias=IIF(EMPTY(tcAlias),this.cAlias,ALLTRIM(tcAlias))
IF NOT EMPTY(lcAlias) AND USED(lcAlias)
	USE IN (lcAlias)
ENDIF
SET DATASESSION TO (this.oHost.DataSessionID)

ENDPROC
PROCEDURE skiprecord
LPARAMETERS tnRecords
LOCAL lnRecords,lcAlias,lnRecNo,lnLastSelect,lnLastRecNo

SET DATASESSION TO (this.nDataSessionID)
lcAlias=this.cAlias
IF EMPTY(lcAlias) OR NOT USED(lcAlias)
	SET DATASESSION TO (this.oHost.DataSessionID)
	RETURN .F.
ENDIF
lnRecords=IIF(EMPTY(tnRecords),0,tnRecords)
lnLastSelect=SELECT()
SELECT (lcAlias)
IF EOF()
	GO BOTTOM
ENDIF
lnLastRecNo=RECNO()
lnRecNo=IIF(this.nRecNo>0,this.nRecNo,RECNO())
GO lnRecNo
SKIP lnRecords
IF BOF()
	GO TOP
ENDIF
IF EOF()
	GO BOTTOM
ENDIF
this.nRecNo=RECNO()
GO lnLastRecNo
SELECT (lnLastSelect)
SET DATASESSION TO (this.oHost.DataSessionID)
this.RunScript("RefreshData")

ENDPROC
PROCEDURE addprop
LPARAMETERS toObject,tcProperty,tuValue
LOCAL lcFileName,llAddPropLibSet,lvResult

lcFileName=this.cProgramPath+"AddProp5.fll"
IF NOT FILE(lcFileName)
	RETURN .F.
ENDIF
llAddPropLibSet=(ATC(lcFileName,SET("LIBRARY"))>0)
IF NOT llAddPropLibSet
	SET LIBRARY TO (lcFileName) ADDITIVE
ENDIF
lvResult=AddProp(toObject,tcProperty,tuValue)
IF NOT llAddPropLibSet
	RELEASE LIBRARY (lcFileName)
ENDIF
RETURN lvResult

ENDPROC
PROCEDURE goback
*** OLE Control Method ***
LOCAL lcURL,lcSourceFileName

IF this.nHistoryCount<2
	NODEFAULT
	RETURN .F.
ENDIF
lcURL=this.aHistory[this.nHistoryCount-1,1]
lcSourceFileName=this.aHistory[this.nHistoryCount-1,2]
this.nHistoryCount=this.nHistoryCount-1
IF this.nHistoryCount>0
	DIMENSION this.aHistory[this.nHistoryCount,2]
ELSE
	this.aHistory=""
ENDIF
this.lHistoryEnabled=.F.
IF NOT EMPTY(lcSourceFileName)
	NODEFAULT
	this.Navigate(lcSourceFileName)
	RETURN .F.
ENDIF
IF NOT EMPTY(lcURL) AND NOT EMPTY(this.cSourceFileName) AND	NOT lcURL==lcSourceFileName
	NODEFAULT
	this.Navigate(lcURL)
	RETURN .F.
ENDIF

ENDPROC
PROCEDURE newwindow
*** OLE Control Event ***
LPARAMETERS url, flags, targetframename, postdata, headers, processed

IF TYPE("url")#"C"
	RETURN
ENDIF
IF this.lDebug
	ACTIVATE SCREEN
	? PROGRAM()
	? "URL: "+url
	IF NOT EMPTY(targetframename)
		?? "  Frame: "+targetframename
	ENDIF
ENDIF
processed=.T.
this.Navigate(@url,@flags,@targetframename,@postdata,@headers)

ENDPROC
PROCEDURE navigate
*** OLE Control Method ***
LPARAMETERS url, flags, targetframename, postdata, headers
LOCAL lcURL,lcNewURL

IF TYPE("url")#"C"
	RETURN
ENDIF
IF this.lRelease
	NODEFAULT
	url=""
	RETURN .F.
ENDIF
IF this.lDebug
	ACTIVATE SCREEN
	? PROGRAM()
	? "URL: "+url
	IF NOT EMPTY(targetframename)
		?? "  Frame: "+targetframename
	ENDIF
ENDIF
lcURL=ALLTRIM(url)
IF LEFT(lcURL,LEN(this.cVFPSProtocol))==LOWER(this.cVFPSProtocol)
	NODEFAULT
	RETURN this.BeforeNavigate(@url,@flags,@targetframename,@postdata,@headers)
ENDIF
IF RIGHT(url,16)==SPACE(16)
	this.cBeforeURL=ALLTRIM(lcURL)
	this.cSourceFile=""
	this.cSourceHTML=""
	RETURN
ENDIF
IF NOT this.ParseSource(lcURL) OR EMPTY(this.cNewURL)
	RETURN
ENDIF
NODEFAULT
url=""
RETURN this.Navigate(this.cNewURL+SPACE(16),@flags,@targetframename)

ENDPROC
PROCEDURE beforenavigate
*** OLE Control Event ***
PARAMETERS url, flags, targetframename, postdata, headers, cancel
LOCAL lcURL,lcNewURL,lcSource,llJump,llMailTo,lcFileExt,lnAtPos,lnHistory

IF this.lRelease OR this.lBusy
	cancel=.T.
	RETURN .F.
ENDIF
this.SetBusyState(.T.)
IF this.lDebug
	ACTIVATE SCREEN
	? PROGRAM()
	? "URL: "+url
	IF NOT EMPTY(targetframename)
		?? "  Frame: "+targetframename
	ENDIF
ENDIF
lcURL=ALLTRIM(url)
this.SetParam(lcURL)
llVisible=this.Visible
llMailTo=(LOWER(LEFT(lcURL,7))=="mailto:")
IF NOT llMailTo
	this.cBeforeURL=lcURL
ENDIF
lnAtPos=RAT(".",lcURL)
lcFileExt=IIF(lnAtPos=0,CHR(0),ALLTRIM(SUBSTR(lcURL,lnAtPos+1)))
IF NOT this.lParseSource OR ATC(";"+lcFileExt+";",";"+this.cParseFileExt+";")=0 OR ;
		NOT FILE(lcURL)
	IF NOT this.lParseSource
		this.cFileName=""
	ENDIF
	this.cSourceURL=""
	this.BeforeRetrieval(@url,@flags,@targetframename,@postdata, ;
			@headers,@cancel)
	IF NOT cancel
		this.cFileName=""
		this.cSourceFile=""
		this.cSourceFileName=""
		this.cSourceHTML=""
	ENDIF
	this.SetBusyState(.F.)
	RETURN
ENDIF
IF NOT this.BeforeRetrieval(@url,@flags,@targetframename,@postdata, ;
		@headers,@cancel) OR cancel
	IF NOT cancel
		this.cSourceURL=""
		this.cSourceFile=""
		this.cSourceHTML=""
	ENDIF
	this.SetBusyState(.F.)
	RETURN .F.
ENDIF
IF llMailTo OR (NOT EMPTY(this.cTempFileName) AND LOWER(url)==LOWER(this.cTempFileName))
	this.SetBusyState(.F.)
	RETURN .F.
ENDIF
IF NOT cancel
	this.cSourceFile=""
	this.cSourceHTML=""
ENDIF
IF NOT this.ParseSource(lcURL) OR EMPTY(this.cNewURL)
	this.SetBusyState(.F.)
	RETURN
ENDIF
cancel=.T.
this.cSourceFile=""
this.cSourceHTML=""
this.Navigate(this.cNewURL+SPACE(16),@flags,@targetframename)
this.SetBusyState(.F.)

ENDPROC
PROCEDURE navigatecomplete
*** OLE Control Event ***
LPARAMETERS url
LOCAL lcURL,lcLocationURL,lcSourceFileName

IF TYPE("url")#"C"
	RETURN
ENDIF
lcSourceFileName=this.cSourceFileName
IF this.lDebug
	ACTIVATE SCREEN
	? PROGRAM()
	? "URL: "+url
	? "Location URL: "+this.LocationURL
	? "Source file name: "+lcSourceFileName
ENDIF
IF EMPTY(lcSourceFileName)
	lcURL=LOWER(ALLTRIM(url))
ELSE
	lcURL=lcSourceFileName
ENDIF
IF EMPTY(lcURL) OR (SUBSTR(lcURL,5,1)==":" AND NOT LEFT(lcURL,5)=="file:" AND ;
		NOT LEFT(lcURL,4)=="http") OR RIGHT(lcURL,11)=="about:blank"
	RETURN
ENDIF
this.cLastURL=this.cURL
this.cURL=LOWER(this.ValidURL(lcURL))
lcLocationURL=LOWER(this.ValidURL(this.LocationURL))
IF this.lRefreshMode
	this.lRefreshMode=.F.
	this.lHistoryEnabled=.T.
	RETURN
ENDIF
IF NOT this.lHistoryEnabled
	this.lHistoryEnabled=.T.
	RETURN
ENDIF
lcURL=lcLocationURL
IF this.nHistoryCount>0 AND (this.aHistory[this.nHistoryCount,1]==lcURL OR ;
		(NOT EMPTY(lcSourceFileName) AND this.aHistory[this.nHistoryCount,2]==lcSourceFileName))
	RETURN
ENDIF
this.nHistoryCount=this.nHistoryCount+1
DIMENSION this.aHistory[this.nHistoryCount,2]
this.aHistory[this.nHistoryCount,1]=lcURL
this.aHistory[this.nHistoryCount,2]=lcSourceFileName

ENDPROC
PROCEDURE statustextchange
*** OLE Control Event ***
LPARAMETERS text

IF this.lRelease OR this.lBusy OR NOT this.oHost.Visible
	RETURN .F.
ENDIF
IF TYPE("text")=="C" AND NOT EMPTY(text)
	SET MESSAGE TO LEFT(text,254)
ELSE
	SET MESSAGE TO
ENDIF

ENDPROC
PROCEDURE downloadcomplete
*** OLE Control Event ***

IF this.lDebug
	ACTIVATE SCREEN
	? PROGRAM()
ENDIF
IF TYPE("this.LocationURL")=="C"
	this.cURL=LOWER(this.ValidURL(this.LocationURL))
ENDIF
this.NavigateComplete(this.cURL)
this.RunScript("OnLoad")

ENDPROC
PROCEDURE commandstatechange
*** OLE Control Event ***
LPARAMETERS command, enable
LOCAL llEnabled

IF this.lRelease
	RETURN .F.
ENDIF
IF this.lDebug
	ACTIVATE SCREEN
	? PROGRAM()
	? "Command: "+ALLTRIM(STR(command))
	? "Enable: "+IIF(enable,"ON","OFF")
ENDIF
llEnable=enable
DO CASE
	CASE command=1
		IF TYPE("thisform.cmdGoForward")=="O"
			thisform.cmdGoForward.Enabled=llEnable
		ENDIF
	CASE command=2
		IF this.nHistoryCount=0
			llEnable=.F.
		ENDIF
		IF TYPE("thisform.cmdGoBack")=="O"
			thisform.cmdGoBack.Enabled=llEnable
		ENDIF
ENDCASE

ENDPROC
PROCEDURE refresh2
*** OLE Control Method ***
LPARAMETERS level

IF this.lRelease OR NOT this.lRefresh
	NODEFAULT
	RETURN .F.
ENDIF
IF NOT EMPTY(this.cSourceFileName)
	RETURN this.RefreshMode()
ENDIF

ENDPROC
PROCEDURE framebeforenavigate
*** OLE Control Event ***
LPARAMETERS url, flags, targetframename, postdata, headers, cancel

IF TYPE("url")#"C"
	RETURN
ENDIF
IF this.lDebug
	ACTIVATE SCREEN
	? PROGRAM()
	? "URL: "+url
	IF NOT EMPTY(targetframename)
		?? "  Frame: "+targetframename
	ENDIF
ENDIF
this.BeforeNavigate(@url,flags,@targetframename,@postdata,@headers,@cancel)

ENDPROC
PROCEDURE goforward
*** OLE Control Method ***

DOEVENTS

ENDPROC
PROCEDURE gohome
*** OLE Control Method ***

DOEVENTS

ENDPROC
PROCEDURE gosearch
*** OLE Control Method ***

DOEVENTS

ENDPROC
PROCEDURE validateurl
LPARAMETERS tcURL
LOCAL lcURL,lnLastSelect

lcURL=ALLTRIM(tcURL)
IF this.lRelease OR lcURL==this.cLastURL OR ;
		LOWER(lcURL)==LOWER(ALLTRIM(this.cBlankHTMLFile))
	RETURN
ENDIF
SET DATASESSION TO (this.oHost.DataSessionID)
lnLastSelect=SELECT()
IF NOT this.OpenVFPScript()
	SELECT (lnLastSelect)
	RETURN
ENDIF
SELECT vfpscript
SCAN ALL FOR BeforeNav AND URLCancel
	IF NOT EMPTY(URLMatch) AND NOT this.WildCardMatch(ALLTRIM(MLINE(URLMatch,1)),lcURL)
		LOOP
	ENDIF
	IF NOT EMPTY(URLEval) AND (TYPE(URLEval)#"L" OR NOT EVALUATE(URLEval))
		LOOP
	ENDIF
	this.cURL=this.this.cLastURL
	SELECT (lnLastSelect)
	RETURN .F.
ENDSCAN
SELECT (lnLastSelect)

ENDPROC
PROCEDURE Error
LPARAMETERS nError, cMethod, nLine
LOCAL lcMessage,lcMethod,lcErrorMsg,lcCodeLineMsg

#DEFINE	RUNCODE_RUNTIME_ERROR_LOC	"RunCode Runtime Error"
#DEFINE	TAB		CHR(9)
#DEFINE	LF		CHR(10)
#DEFINE	CR		CHR(13)
#DEFINE CR_LF	CR+LF

IF this.lIgnoreErrors OR INLIST(nError,1113,1426,1429,2012)
	RETURN
ENDIF
IF NOT EMPTY(GETPEM(thisform,"Error"))
	RETURN thisform.Error(nError,cMethod,nLine)
ENDIF
lcMethod=LOWER(ALLTRIM(cMethod))
IF INLIST(LOWER(lcMethod),"goback","gofoward") OR RIGHT(lcMethod,9)==".navigate"
	RETURN
ENDIF
lcErrorMsg=MESSAGE()+CR+CR+thisform.Caption+":  "+this.Name+CR+ ;
		"Object:        "+this.Name+CR+ ;
		"Error:           "+ALLTRIM(STR(nError))+CR+ ;
		"Method:       "+lcMethod
lcCodeLineMsg=MESSAGE(1)
IF BETWEEN(nLine,1,10000) AND NOT lcCodeLineMsg="..."
	lcErrorMsg=lcErrorMsg+CR+"Line:            "+ALLTRIM(STR(nLine))
	IF NOT EMPTY(lcCodeLineMsg)
		lcErrorMsg=lcErrorMsg+CR+CR+lcCodeLineMsg
	ENDIF
ENDIF
IF this.Msgbox(lcErrorMsg,17)#1
	this.ReleaseHost
ENDIF

ENDPROC
PROCEDURE Init
LPARAMETERS tcVFPScript

DIMENSION this.aHistory[1,2]
this.aHistory=""
this.oHost=thisform
this.oUser=CREATEOBJECT("Custom")
this.oUser.Name="oCustom"
this.nDataSessionID=thisform.DataSessionID
this.cProgramPath=IIF(TYPE("this.oHost.cProgramPath")=="C",this.oHost.cProgramPath, ;
		this.ClassLibrary)
IF NOT "\"$this.cBlankHTMLFile AND NOT ":"$this.cBlankHTMLFile
	this.cBlankHTMLFile=LOWER(this.cProgramPath+this.cBlankHTMLFile)
ENDIF
DO CASE
	CASE ISNULL(tcVFPScript)
		this.cVFPScript=""
	CASE EMPTY(tcVFPScript) OR TYPE("tcVFPScript")#"C"
		this.cVFPScript=LOWER(FULLPATH(this.cVFPScriptTable,this.cProgramPath))
	OTHERWISE
		this.cVFPScript=LOWER(ALLTRIM(tcVFPScript))
ENDCASE
IF EMPTY(this.cVFPScript)
	this.lVFPScript=.F.
ENDIF
this.OpenVFPScript
SELECT 0
IF this.lBlankHTMLStartup AND NOT EMPTY(this.cBlankHTMLFile) AND FILE(this.cBlankHTMLFile)
	this.Navigate(this.cBlankHTMLFile)
ENDIF
SELECT 0

ENDPROC
PROCEDURE Refresh
*** OLE Control Method ***

IF this.lDebug
	ACTIVATE SCREEN
	? PROGRAM()
ENDIF
IF this.lRefresh AND NOT this.lDesign
	this.RunScript("OnRefresh")
ENDIF
this.lRefresh=.T.
NODEFAULT

ENDPROC
PROCEDURE Destroy
this.EraseTempFile
this.lRelease=.T.
this.cSourceFile=""
this.cSourceHTML=""
this.oAction=.NULL.
this.oSource=.NULL.
this.oUser=.NULL.
this.oHost=.NULL.
IF USED("vfpscript")
	USE IN vfpscript
ENDIF

ENDPROC
PROCEDURE LostFocus
IF this.lDebug
	ACTIVATE SCREEN
	? PROGRAM()
ENDIF
this.RefreshDeactivate

ENDPROC


************************************************************
OBJETO: _webbrowser4
************************************************************
*** PROPIEDADES ***
Height = 100
Width = 100
TabStop = .F.
csourcehtml = 
csourcefile = 
curl = 
clasturl = 
cbeforeurl = 
ctempfilename = 
ohost = .NULL.
uvalue = .T.
cnewurl = 
csourceurl = 
csourcefilename = 
cvfpscripttable = 
cvfpscript = 
csourcefilepath = 
cparsefileext = htm;html;asp
nscriptcount = 0
osource = .NULL.
uresult = .T.
oaction = .NULL.
cvfpsprotocol = vfps:
ctempfileprefix = _temp
ureturn = .T.
cblankhtmlfile = Blank.htm
cprogrampath = 
cparam = 
cfilename = 
calias = 
cparamdelimiter = &
cfilepath = 
nrecno = 0
ndatasessionid = 0
cdbf = 
ouser = .NULL.
nhistorycount = 0
cversion = Web Browser 04.01.0016
cdbfpath = 
nuserlevel = 0
cuserid = 
cusername = 
ldhtml = .T.
Name = "_webbrowser4"

*** METODOS ***
PROCEDURE refreshsource
LOCAL lcFileName,lcFileName2,lnLastSelect,lcSource,lcAlias

IF this.lRelease
	RETURN .F.
ENDIF
this.cSourceFile=""
this.cSourceHTML=""
IF EMPTY(this.cFileName)
	RETURN .F.
ENDIF
lcFileName=this.cFileName
IF EMPTY(SYS(2000,lcFileName))
	RETURN .F.
ENDIF
lcFileName2=this.TrimPath(lcFileName)
IF WEXIST(lcFileName2)
	RELEASE WINDOW (lcFileName2)
ENDIF
lnLastSelect=SELECT()
lcAlias=LOWER(SYS(2015))
CREATE CURSOR (lcAlias) (Source M)
APPEND BLANK
APPEND MEMO Source FROM (lcFileName) OVERWRITE
lcSource=Source
USE
SELECT (lnLastSelect)
this.cSourceFile=lcFileName
this.cSourceHTML=lcSource

ENDPROC
PROCEDURE viewsource
LPARAMETERS tlNoWait,tlNoEdit
LOCAL lcFileName

#DEFINE HTML_SOURCE_NOT_AVAILABLE_LOC	"HTML source not available"

IF this.lRelease
	RETURN .F.
ENDIF
this.lViewSourceMode=.F.
this.GetSourceHTML()
lcFileName=this.GetSourceFile()
IF EMPTY(lcFileName) OR EMPTY(SYS(2000,lcFileName))
	this.WaitWindow(HTML_SOURCE_NOT_AVAILABLE_LOC)
	RETURN .F.
ENDIF
IF tlNoWait
	IF tlNoEdit
		MODIFY FILE (lcFileName) NOEDIT NOWAIT
	ELSE
		MODIFY FILE (lcFileName) NOWAIT
	ENDIF
	RETURN
ENDIF
this.lViewSourceMode=.T.
IF tlNoEdit
	MODIFY FILE (lcFileName) NOEDIT
ELSE
	MODIFY FILE (lcFileName)
	IF LASTKEY()#27
		this.lHistoryEnabled=.F.
		this.Navigate(lcFileName)
	ENDIF
ENDIF
this.lViewSourceMode=.F.

ENDPROC
PROCEDURE beforeretrieval
PARAMETERS url, flags, targetframename, postdata, headers, cancel
LOCAL lcURL,lcLowerURL,lcNewURL,lnAtPos,lnLastSelect

IF TYPE("this.oHost")#"O" OR ISNULL(this.oHost)
	RETURN .F.
ENDIF
SET DATASESSION TO (this.oHost.DataSessionID)
lcURL=ALLTRIM(url)
this.uResult=.T.
IF this.lRelease OR NOT this.Enabled
	cancel=.T.
	RETURN .F.
ENDIF
lnAtPos=AT("?",lcURL)
IF lnAtPos>0
	lcURL=ALLTRIM(LEFT(lcURL,lnAtPos-1))
ENDIF
this.cLastURL=this.cURL
lcLowerURL=LOWER(lcURL)
IF LOWER(LEFT(lcLowerURL,LEN(this.cVFPSProtocol)))==LOWER(this.cVFPSProtocol)
	cancel=.T.
	this.VFPS(lcURL)
	RETURN .F.
ENDIF
lnLastSelect=SELECT()
IF NOT this.lVFPScript OR NOT this.OpenVFPScript()
	IF USED("vfpscript")
		USE IN vfpscript
	ENDIF
	SELECT (lnLastSelect)
	RETURN
ENDIF
this.Enabled=.F.
SELECT vfpscript
SCAN ALL FOR BeforeNav
	IF NOT EMPTY(URLMatch) AND NOT this.WildCardMatch(ALLTRIM(MLINE(URLMatch,1)),lcURL)
		LOOP
	ENDIF
	IF NOT EMPTY(URLEval) AND (TYPE(URLEval)#"L" OR NOT EVALUATE(URLEval))
		LOOP
	ENDIF
	IF URLCancel
		cancel=.T.
	ENDIF
	IF NOT EMPTY(Script)
		this.RunScript(ALLTRIM(Name))
	ENDIF
	IF NOT USED("vfpscript")
		EXIT
	ENDIF
	SELECT vfpscript
	IF NOT EMPTY(URLJump)
		lcNewURL=ALLTRIM(URLJump)
		this.cURL=LOWER(this.ValidURL(lcNewURL))
		cancel=.T.
		this.Navigate(lcNewURL,@flags,@targetframename,@postdata,@headers)
	ENDIF
	IF NOT Continue
		EXIT
	ENDIF
ENDSCAN
SELECT (lnLastSelect)
this.Enabled=.T.

ENDPROC
PROCEDURE trimext
LPARAMETERS tcFileName,tlPlatformType
LOCAL lcFileName,lnAtPos,lnAtPos2

lcFileName=tcFileName
lnAtPos=RAT(".",lcFileName)
IF lnAtPos>0
	lnAtPos2=RAT(":",lcFileName)
	IF lnAtPos>lnAtPos2
		lcFileName=LEFT(lcFileName,lnAtPos-1)
	ENDIF
ENDIF
IF tlPlatformType
	lcFileName=IIF(_dos OR _unix,UPPER(lcFileName),LOWER(lcFileName))
ENDIF
RETURN ALLTRIM(lcFileName)

ENDPROC
PROCEDURE trimpath
LPARAMETERS tcFileName,tlTrimExt,tlPlatformType
LOCAL lcFileName,lnAtPos

IF EMPTY(tcFileName)
	RETURN ""
ENDIF
lcFileName=tcFileName
lnAtPos=AT(":",lcFileName)
IF lnAtPos>0
	lcFileName=SUBSTR(lcFileName,lnAtPos+1)
ENDIF
IF tlTrimExt
	lcFileName=this.TrimExt(lcFileName)
ENDIF
IF tlPlatformType
	lcFileName=IIF(_dos OR _unix,UPPER(lcFileName),LOWER(lcFileName))
ENDIF
lcFileName=ALLTRIM(SUBSTR(lcFileName,AT("\",lcFileName,;
		MAX(OCCURS("\",lcFileName),1))+1))
DO WHILE LEFT(lcFileName,1)=="."
	lcFileName=ALLTRIM(SUBSTR(lcFileName,2))
ENDDO
DO WHILE RIGHT(lcFileName,1)=="."
	lcFileName=ALLTRIM(LEFT(lcFileName,LEN(lcFileName)-1))
ENDDO
RETURN lcFileName

ENDPROC
PROCEDURE trimfile
LPARAMETERS tcFileName,lPlatType
LOCAL lcFileName,lnAtPos

lnAtPos=RAT("\",tcFileName)
lcFileName=ALLTRIM(IIF(lnAtPos=0,tcFileName,LEFT(tcFileName,lnAtPos)))
IF lPlatType
	lcFileName=IIF(_dos OR _unix,UPPER(lcFileName),LOWER(lcFileName))
ENDIF
RETURN lcFileName

ENDPROC
PROCEDURE erasetempfile
IF NOT EMPTY(this.cTempFileName)
	ERASE (this.cTempFileName)
	this.cTempFileName=""
ENDIF

ENDPROC
PROCEDURE getsourcefile
IF this.lRelease
	RETURN .F.
ENDIF
IF EMPTY(this.cSourceFile)
	this.RefreshSource
ENDIF
RETURN this.cSourceFile

ENDPROC
PROCEDURE getsourcehtml
IF this.lRelease
	RETURN .F.
ENDIF
IF EMPTY(this.cSourceHTML)
	this.RefreshSource
ENDIF
RETURN this.cSourceHTML

ENDPROC
PROCEDURE parsesource
*** OLE Control Event ***
PARAMETERS url, flags, targetframename, postdata, headers, cancel
PRIVATE oTHIS
LOCAL lcURL,lcSource,lcNewURL,lcFileName,lnAtPos,llHTMLFile,llBusy
EXTERNAL ARRAY VFPScrpt

IF this.lRelease OR NOT this.lParseSource OR TYPE("url")#"C" OR EMPTY(url)
	RETURN .F.
ENDIF
lcURL=ALLTRIM(url)
lcFileName=STRTRAN(lcURL,"/","\")
lnAtPos=RAT("\",lcFileName)
IF lnAtPos>0 AND LOWER(SUBSTR(lcFileName,lnAtPos+1, ;
		LEN(this.cTempFilePrefix)))==this.cTempFilePrefix
	RETURN .F.
ENDIF
this.cFileName=""
this.cFilePath=""
this.cSourceURL=""
this.cSourceFileName=""
llHTMLFile=.F.
lnAtPos=RAT(".",lcURL)
llHTMLFile=(lnAtPos>0 AND INLIST(LOWER(ALLTRIM(SUBSTR(lcURL,lnAtPos+1))), ;
		"htm","html","asp"))
IF NOT llHTMLFile OR LOWER(lcFileName)==LOWER(this.cTempFileName) OR ;
		LOWER(ALLTRIM(lcFileName))==LOWER(ALLTRIM(this.cBlankHTMLFile))
	this.cFileName=lcFileName
	this.cFilePath=this.TrimFile(this.cFileName)
	RETURN .F.
ENDIF
lnAtPos=RAT(":",lcFileName)
IF lnAtPos#2
	RETURN .F.
ENDIF
IF lnAtPos>2
	lcFileName=ALLTRIM(SUBSTR(lcFileName,lnAtPos-1))
ENDIF
IF EMPTY(SYS(2000,lcFileName))
	RETURN .F.
ENDIF
IF this.lDebug
	ACTIVATE SCREEN
	? PROGRAM()
	? "URL: "+lcURL
ENDIF
llBusy=this.lBusy
this.SetBusyState(.T.)
IF NOT ":"$lcURL OR AT(":",lcURL)=2
	lcURL="file://"+STRTRAN(STRTRAN(STRTRAN(lcURL,"\","/"),"///","//"),"//","/")
ENDIF
lcNewURL=""
oTHIS=this
this.cSourceURL=lcURL
this.cFileName=LOWER(lcFileName)
this.cFilePath=this.TrimFile(this.cFileName)
this.cSourceFileName=this.cFileName
this.cSourceFilePath=this.TrimFile(this.cFileName)
IF VFPScrpt(this)
	lcNewURL=this.cTempFileName
ELSE
	this.cSourceURL=""
	this.cSourceFileName=""
	this.cSourceFilePath=""
ENDIF
oTHIS=.NULL.
this.SetBusyState(llBusy)
IF TYPE("this.oHost.lRelease")=="L" AND this.oHost.lRelease
	this.Visible=.F.
	RETURN .F.
ENDIF
this.cURL=LOWER(this.ValidURL(lcURL))
this.cNewURL=lcNewURL

ENDPROC
PROCEDURE runcode
LPARAMETERS tcCode
PRIVATE oTHIS
LOCAL lnDataSessionID,lnLastSelect,llBusy

IF this.lRelease OR EMPTY(tcCode) OR TYPE("tcCode")#"C" OR ISNULL(tcCode)
	RETURN .F.
ENDIF
IF this.lDebug
	ACTIVATE SCREEN
	? PROGRAM()
ENDIF
llBusy=this.lBusy
this.SetBusyState(.T.)
lnLastSelect=SELECT()
lnDataSessionID=this.oHost.DataSessionID
SET DATASESSION TO (lnDataSessionID)
ACTIVATE SCREEN
oTHIS=this
this.lRunCodeMode=.T.
DO RunCode WITH (tcCode)
this.lRunCodeMode=.F.
oTHIS=.NULL.
SET DATASESSION TO (lnDataSessionID)
SELECT (lnLastSelect)
this.SetBusyState(llBusy)

ENDPROC
PROCEDURE runscript
LPARAMETERS tcScript,tcAlias
LOCAL llResult

IF this.lRelease OR EMPTY(tcScript)
	RETURN .F.
ENDIF
IF this.lDebug
	ACTIVATE SCREEN
	? PROGRAM()
	? "Script: "+tcScript
ENDIF
llResult=this.VFPScript(tcScript,tcAlias,0)
IF this.lDebug AND NOT llResult
	ACTIVATE SCREEN
	? "Script: "+tcScript+"  (not found)"
ENDIF
RETURN llResult

ENDPROC
PROCEDURE validurl
LPARAMETERS tcURL
LOCAL lcURL

IF EMPTY(tcURL)
	RETURN ""
ENDIF
lcURL=ALLTRIM(tcURL)
IF NOT ":"$lcURL AND NOT LOWER(LEFT(lcURL,4))=="http" AND ;
		NOT LOWER(LEFT(lcURL,5))=="file:" AND (LOWER(LEFT(lcURL,4))=="www." OR ;
		INLIST(LOWER(RIGHT(lcURL,4)),".com",".gov",".net") OR ;
		(NOT SUBSTR(lcURL,2,1)==":" AND NOT LEFT(lcURL,2)=="\\"))
	lcURL="http://"+lcURL
ENDIF
IF SUBSTR(PADR(lcURL,5),5,1)==":"
	lcURL=STRTRAN(STRTRAN(lcURl,"\","/"),"///","//")
ELSE
	IF NOT ":"$lcURL OR AT(":",lcURL)=2
		lcURL="file://"+STRTRAN(STRTRAN(STRTRAN(lcURL,"\","/"),"///","//"),"//","/")
	ENDIF
ENDIF
RETURN lcURL

ENDPROC
PROCEDURE wildcardmatch
LPARAMETERS tcMatchExpList,tcExpressionSearched,tlMatchAsIs
LOCAL lcMatchExpList,lcExpressionSearched,llMatchAsIs,lcMatchExpList2
LOCAL lnMatchLen,lnExpressionLen,lnMatchCount,lnCount,lnCount2,lnSpaceCount
LOCAL lcMatchExp,lcMatchType,lnMatchType,lnAtPos,lnAtPos2
LOCAL llMatch,llMatch2

IF EMPTY(tcExpressionSearched)
	IF EMPTY(tcMatchExpList) OR ALLTRIM(tcMatchExpList)=="*"
		RETURN
	ENDIF
	RETURN .F.
ENDIF
lcMatchExpList=LOWER(ALLTRIM(STRTRAN(tcMatchExpList,TAB," ")))
lcExpressionSearched=LOWER(ALLTRIM(STRTRAN(tcExpressionSearched,TAB," ")))
lnExpressionLen=LEN(lcExpressionSearched)
IF lcExpressionSearched==lcMatchExpList
	RETURN
ENDIF
llMatchAsIs=tlMatchAsIs
IF LEFT(lcMatchExpList,1)==["] AND RIGHT(lcMatchExpList,1)==["]
	llMatchAsIs=.T.
	lcMatchExpList=ALLTRIM(SUBSTR(lcMatchExpList,2,LEN(lcMatchExpList)-2))
ENDIF
IF NOT llMatchAsIs AND " "$lcMatchExpList
	llMatch=.F.
	lnSpaceCount=OCCURS(" ",lcMatchExpList)
	lcMatchExpList2=lcMatchExpList
	lnCount=0
	DO WHILE .T.
		lnAtPos=AT(" ",lcMatchExpList2)
		IF lnAtPos=0
			lcMatchExp=ALLTRIM(lcMatchExpList2)
			lcMatchExpList2=""
		ELSE
			lnAtPos2=AT(["],lcMatchExpList2)
			IF lnAtPos2<lnAtPos
				lnAtPos2=AT(["],lcMatchExpList2,2)
				IF lnAtPos2>lnAtPos
					lnAtPos=lnAtPos2
				ENDIF
			ENDIF
			lcMatchExp=ALLTRIM(LEFT(lcMatchExpList2,lnAtPos))
			lcMatchExpList2=ALLTRIM(SUBSTR(lcMatchExpList2,lnAtPos+1))
		ENDIF
		IF EMPTY(lcMatchExp)
			EXIT
		ENDIF
		lcMatchType=LEFT(lcMatchExp,1)
		DO CASE
			CASE lcMatchType=="+"
				lnMatchType=1
			CASE lcMatchType=="-"
				lnMatchType=-1
			OTHERWISE
				lnMatchType=0
		ENDCASE
		IF lnMatchType#0
			lcMatchExp=ALLTRIM(SUBSTR(lcMatchExp,2))
		ENDIF
		llMatch2=this.WildCardMatch(lcMatchExp,lcExpressionSearched,.T.)
		IF (lnMatchType=1 AND NOT llMatch2) OR (lnMatchType=-1 AND llMatch2)
			RETURN .F.
		ENDIF
		llMatch=(llMatch OR llMatch2)
		IF lnAtPos=0
			EXIT
		ENDIF
	ENDDO
	RETURN llMatch
ELSE
	IF LEFT(lcMatchExpList,1)=="~"
		RETURN (DIFFERENCE(ALLTRIM(SUBSTR(lcMatchExpList,2)),lcExpressionSearched)>=3)
	ENDIF
ENDIF
lnMatchCount=OCCURS(",",lcMatchExpList)+1
IF lnMatchCount>1
	lcMatchExpList=","+ALLTRIM(lcMatchExpList)+","
ENDIF
FOR lnCount = 1 TO lnMatchCount
	IF lnMatchCount=1
		lcMatchExp=LOWER(ALLTRIM(lcMatchExpList))
		lnMatchLen=LEN(lcMatchExp)
	ELSE
		lnAtPos=AT(",",lcMatchExpList,lnCount)
		lnMatchLen=AT(",",lcMatchExpList,lnCount+1)-lnAtPos-1
		lcMatchExp=LOWER(ALLTRIM(SUBSTR(lcMatchExpList,lnAtPos+1,lnMatchLen)))
	ENDIF
	FOR lnCount2 = 1 TO OCCURS("?",lcMatchExp)
		lnAtPos=AT("?",lcMatchExp)
		IF lnAtPos>lnExpressionLen
			IF (lnAtPos-1)=lnExpressionLen
				lcExpressionSearched=lcExpressionSearched+"?"
			ENDIF
			EXIT
		ENDIF
		lcMatchExp=STUFF(lcMatchExp,lnAtPos,1,SUBSTR(lcExpressionSearched,lnAtPos,1))
	ENDFOR
	IF EMPTY(lcMatchExp) OR lcExpressionSearched==lcMatchExp OR ;
			lcMatchExp=="*" OR lcMatchExp=="?" OR lcMatchExp=="%%"
		RETURN
	ENDIF
	IF LEFT(lcMatchExp,1)=="*"
		RETURN (SUBSTR(lcMatchExp,2)==RIGHT(lcExpressionSearched,LEN(lcMatchExp)-1))
	ENDIF
	IF LEFT(lcMatchExp,1)=="%" AND RIGHT(lcMatchExp,1)=="%" AND ;
			SUBSTR(lcMatchExp,2,lnMatchLen-2)$lcExpressionSearched
		RETURN
	ENDIF
	lnAtPos=AT("*",lcMatchExp)
	IF lnAtPos>0 AND (lnAtPos-1)<=lnExpressionLen AND ;
			LEFT(lcExpressionSearched,lnAtPos-1)==LEFT(lcMatchExp,lnAtPos-1)
		RETURN
	ENDIF
ENDFOR
RETURN .F.

ENDPROC
PROCEDURE refreshmode
LOCAL llBusy

IF this.lRelease OR EMPTY(this.cSourceFileName)
	this.lRefreshMode=.F.
	RETURN .F.
ENDIF
llBusy=this.lBusy
this.SetBusyState(.T.)
this.lRefreshMode=.T.
this.lHistoryEnabled=.F.
this.Navigate(this.cSourceFileName)
this.SetBusyState(llBusy)

ENDPROC
PROCEDURE openvfpscript
LOCAL lcFileName,lnLastSelect,lcLastSetSafety

SET DATASESSION TO (this.oHost.DataSessionID)
IF USED("vfpscript")
	RETURN
ENDIF
IF this.lRelease OR NOT this.lVFPScript OR EMPTY(this.cVFPScript)
	RETURN .F.
ENDIF
lcLastSetSafety=SET("SAFETY")
SET SAFETY OFF
lnLastSelect=SELECT()
lcFileName=this.cVFPScript
IF NOT EMPTY(SYS(2000,lcFileName))
	SELECT 0
	USE (lcFileName) SHARED ALIAS vfpscript AGAIN
	IF NOT USED()
		SELECT (lnLastSelect)
		IF lcLastSetSafety=="ON"
			SET SAFETY ON
		ELSE
			SET SAFETY OFF
		ENDIF
		RETURN .F.
	ENDIF
	IF FCOUNT()<9
		USE
		ERASE (lcFileName)
	ENDIF
ENDIF
IF EMPTY(SYS(2000,lcFileName)) OR TYPE("BeforeNav")#"L"
	IF USED("vfpscript")
		USE IN vfpscript
	ENDIF
	ERASE (lcFileName)
	SELECT 0
	CREATE TABLE (lcFileName) ;
			(IndexValue C(10), Name C(24), HTML M, Script M, BeforeNav L, URLMatch M, ;
			URLEval M, URLJump M, URLCancel L, ;
			Continue L, Comment M, LastAccess T, ExecCount N(8))
	USE (lcFileName) SHARED ALIAS vfpscript AGAIN
ENDIF
IF TYPE("LastAccess")#"T" OR TYPE("ExecCount")#"N"
	IF USED("vfpscript")
		USE IN vfpscript
	ENDIF
	SELECT 0
	USE (lcFileName) EXCLUSIVE ALIAS vfpscript
	IF NOT USED()
		SELECT (lnLastSelect)
		IF lcLastSetSafety=="ON"
			SET SAFETY ON
		ELSE
			SET SAFETY OFF
		ENDIF
		RETURN .F.
	ENDIF
	IF TYPE("LastAccess")#"T"
		ALTER TABLE (lcFileName) ADD COLUMN LastAccess T NULL
	ENDIF
	IF TYPE("ExecCount")#"N"
		ALTER TABLE (lcFileName) ADD COLUMN ExecCount N(8) NULL
	ENDIF
	USE (lcFileName) SHARED ALIAS vfpscript AGAIN
ENDIF
IF NOT USED("vfpscript")
	SELECT (lnLastSelect)
	IF lcLastSetSafety=="ON"
		SET SAFETY ON
	ELSE
		SET SAFETY OFF
	ENDIF
	RETURN .F.
ENDIF
SELECT vfpscript
IF KEY(1)=="INDEXVALUE"
	SET ORDER TO IndexValue
ELSE
	INDEX ON IndexValue TAG IndexValue ASCENDING ADDITIVE
ENDIF
SET FILTER TO NOT DELETED()
LOCATE
SELECT 0

ENDPROC
PROCEDURE refreshdeactivate
IF this.lRelease OR NOT this.Visible
	RETURN
ENDIF
IF this.lRefreshDeactivate
	this.Visible=.F.
	this.Visible=.T.
	RETURN
ENDIF

ENDPROC
PROCEDURE releasehost
IF this.lRelease
	RETURN .F.
ENDIF
IF TYPE("this.oHost.tmrHost")#"O"
	RETURN .F.
ENDIF
this.oHost.tmrHost.RunCode("oTHIS.oHost.Release")

ENDPROC
PROCEDURE vfps
LPARAMETERS tcCommand
LOCAL lcCommand,lcParam1,lcParameter,lcAlias,lcVFPSProtocol,lnVFPSProtocolLen
LOCAL lcVariable,lcCode,lnCount,lnAtPos,llEnabled,luResult,llBusy

IF this.lRelease OR EMPTY(tcCommand) OR TYPE("this.oHost")#"O" OR ISNULL(this.oHost)
	RETURN .F.
ENDIF
llBusy=this.lBusy
this.SetBusyState(.T.)
llEnabled=this.Enabled
IF this.oHost.Visible
	this.Enabled=.F.
ENDIF
lcCommand=LOWER(ALLTRIM(tcCommand))
lcVFPSProtocol=LOWER(this.cVFPSProtocol)
lnVFPSProtocolLen=LEN(lcVFPSProtocol)
IF LEFT(lcCommand,lnVFPSProtocolLen)==lcVFPSProtocol
	lcCommand=ALLTRIM(SUBSTR(lcCommand,lnVFPSProtocolLen+1))
ENDIF
DO WHILE LEFT(lcCommand,1)=="/"
	lcCommand=ALLTRIM(SUBSTR(lcCommand,2))
ENDDO
DO WHILE RIGHT(lcCommand,1)=="/"
	lcCommand=ALLTRIM(LEFT(lcCommand,LEN(lcCommand)-1))
ENDDO
lnAtPos=AT("?",lcCommand)
IF lnAtPos>0
	this.SetParam(lcCommand)
	lcCommand=ALLTRIM(LEFT(lcCommand,lnAtPos-1))
ENDIF
lcCommand=STRTRAN(lcCommand,"%20"," ")
FOR lnCount = 1 TO this.nParamCount
	lcParameter=this.aParam[lnCount]
	lnAtPos=AT("=",lcParameter)
	IF lnAtPos=0
		lcVariable=""
	ELSE
		lcVariable=ALLTRIM(LEFT(lcParameter,lnAtPos-1))
		lcParameter=ALLTRIM(SUBSTR(lcParameter,lnAtPos+1))
	ENDIF
	IF LEFT(lcParameter,1)=="(" AND RIGHT(lcParameter,1)==")"
		IF STRTRAN(STRTRAN(lcParameter,CHR(9),"")," ","")=="()"
			this.aParam[lnCount]=""
		ELSE
			this.aParam[lnCount]=EVALUATE(lcParameter)
		ENDIF
	ELSE
		this.aParam[lnCount]=lcParameter
	ENDIF
	IF NOT EMPTY(lcVariable) AND NOT LEFT(lcVariable,1)==";"
		lcParameter=this.aParam[lnCount]
		IF NOT "."$lcVariable
			PRIVATE (lcVariable)
		ENDIF
		lcCode=lcVariable+"=lcParameter"
		&lcCode
	ENDIF
ENDFOR
lcParam1=this.aParam[1]
IF this.lDebug
	ACTIVATE SCREEN
	? PROGRAM()
	? "Command: "+lcCommand+"  Param: "+this.cParam
ENDIF
DO CASE
	CASE lcCommand=="refresh"
		luResult=this.Refresh2()
	CASE lcCommand=="releasehost"
		luResult=this.ReleaseHost()
	CASE lcCommand=="runaction"
		luResult=this.RunAction(lcParam1)
	CASE lcCommand=="runmethod"
		lcParam1=this.cParam
		IF NOT RIGHT(lcParam1,1)==")"
			lcParam1=lcParam1+"()"
		ENDIF
		luResult=this.&lcParam1
	CASE lcCommand=="runcode"
		luResult=this.RunCode(lcParam1)
	CASE lcCommand=="runscript"
		lcAlias=""
		lnAtPos=AT("::",lcParam1)
		IF lnAtPos>0
			lcAlias=ALLTRIM(LEFT(lcParam1,lnAtPos-1))
			lcParam1=ALLTRIM(SUBSTR(lcParam1,lnAtPos+2))
		ENDIF
		luResult=this.RunScript(lcParam1,lcAlias)
	CASE lcCommand=="viewsource"
		luResult=this.ViewSource()
	OTHERWISE
		luResult=.F.
ENDCASE
this.Enabled=llEnabled
this.SetBusyState(llBusy)
RETURN luResult

ENDPROC
PROCEDURE runaction
LPARAMETERS tcMethod
LOCAL lcMethod,llResult,llBusy

this.uResult=.T.
IF this.lRelease OR EMPTY(tcMethod) OR TYPE("this.oAction")#"O" OR ISNULL(this.oAction)
	RETURN .F.
ENDIF
lcMethod=LOWER(ALLTRIM(tcMethod))
IF EMPTY(lcMethod) OR NOT PEMSTATUS(this.oAction,lcMethod,5) OR ;
		PEMSTATUS(this.oAction,lcMethod,2) OR ;
		NOT PEMSTATUS(this.oAction,lcMethod,3)=="Method"
	RETURN .F.
ENDIF
llBusy=this.lBusy
this.SetBusyState(.T.)
llResult=EVALUATE("this.oAction."+lcMethod+"()")
llBusy=this.lBusy
this.SetBusyState(llBusy)
RETURN llResult

ENDPROC
PROCEDURE filetostring
LPARAMETERS tcFileName
LOCAL lcFileName,lnLastSelect,lcAlias,lcText

IF PARAMETERS()#1  OR TYPE("tcFileName")#"C" OR EMPTY(tcFileName)
	RETURN ""
ENDIF
lcFileName=ALLTRIM(tcFileName)
IF NOT "."$lcFileName
	lcFileName=lcFileName+".txt"
ENDIF
lnLastSelect=SELECT()
lcAlias=LOWER(SYS(2015))
CREATE CURSOR (lcAlias) (Text M)
APPEND BLANK
APPEND MEMO Text FROM (tcFileName) OVERWRITE
lcText=Text
USE IN (lcAlias)
SELECT (lnLastSelect)
RETURN lcText

ENDPROC
PROCEDURE stringtofile
LPARAMETERS tcText,tcFileName
LOCAL lcFileName,lnLastSelect,lcAlias

IF PARAMETERS()#2 OR TYPE("tcText")#"C" OR TYPE("tcFileName")#"C" OR EMPTY(tcFileName)
	RETURN .F.
ENDIF
lcFileName=ALLTRIM(tcFileName)
IF NOT "."$lcFileName
	lcFileName=lcFileName+".txt"
ENDIF
lnLastSelect=SELECT()
lcAlias=LOWER(SYS(2015))
CREATE CURSOR (lcAlias) (Text M)
INSERT INTO (lcAlias) (Text) VALUES (tcText)
COPY MEMO Text TO (tcFileName)
USE IN (lcAlias)
SELECT (lnLastSelect)

ENDPROC
PROCEDURE setparam
LPARAMETERS tcParam
LOCAL lcParam,lcParameter,lcParamDelimiter,lnParamTotal,lnCount,lnAtPos

lcParam=IIF(EMPTY(tcParam),"",ALLTRIM(tcParam))
lnAtPos=AT("?",lcParam)
IF lnAtPos=0
	lcParam=""
ELSE
	lcParam=ALLTRIM(SUBSTR(lcParam,lnAtPos+1))
ENDIF
this.nParamCount=0
DIMENSION this.aParam[128]
this.aParam=.F.
IF EMPTY(lcParam)
	this.cParam=""
	RETURN
ENDIF
IF RIGHT(lcParam,1)=="/"
	lcParam=ALLTRIM(LEFT(lcParam,LEN(lcParam)-1))
ENDIF
lcParam=STRTRAN(lcParam,"%20"," ")
this.cParam=lcParam
lcParamDelimiter=this.cParamDelimiter
lnParamTotal=MIN(OCCURS(lcParamDelimiter,lcParam)+1,128)
FOR lnCount = 1 TO lnParamTotal
	this.nParamCount=this.nParamCount+1
	lnAtPos=AT(lcParamDelimiter,lcParam)
	IF lnAtPos=0
		lcParameter=ALLTRIM(lcParam)
	ELSE
		lcParameter=ALLTRIM(LEFT(lcParam,lnAtPos-1))
		lcParam=ALLTRIM(SUBSTR(lcParam,lnAtPos+1))
	ENDIF
	this.aParam[lnCount]=lcParameter
ENDFOR

ENDPROC
PROCEDURE gethtml
LPARAMETERS tcName,tcAlias
LOCAL lcHTML,llResult

IF this.lDebug
	ACTIVATE SCREEN
	? PROGRAM()
	? "Name: "+tcName
ENDIF
lcHTML=this.VFPScript(tcName,tcAlias,1)
llResult=(TYPE("lcHTML")=="C")
IF NOT llResult
	lcHTML=""
ENDIF
IF this.lDebug AND NOT llResult
	ACTIVATE SCREEN
	? "Name: "+tcName+"  (not found)"
ENDIF
RETURN lcHTML

ENDPROC
PROCEDURE vfpscript
LPARAMETERS tcName,tcAlias,tnCode
LOCAL lcName,lcAlias,lnLastSelect,lnRecNo,ltDateTime,llMatch
LOCAL llMatch,lcScriptCode,lcHTML

IF TYPE("this.oHost")#"O" OR ISNULL(this.oHost)
	RETURN .F.
ENDIF
SET DATASESSION TO (this.oHost.DataSessionID)
this.uResult=.T.
IF this.lRelease OR EMPTY(tcName) OR TYPE("tnCode")#"N"
	RETURN .F.
ENDIF
ltDateTime=DATETIME()
lcName=LOWER(ALLTRIM(tcName))
lcAlias=IIF(EMPTY(tcAlias),"vfpscript",LOWER(ALLTRIM(tcAlias)))
lnLastSelect=SELECT()
llMatch=.F.
lcScriptCode=""
lcHTML=""
FOR lnCount = 1 TO this.nScriptCount
	IF NOT LOWER(this.aScripts[lnCount,1])==lcName
		LOOP
	ENDIF
	llMatch=.T.
	lcScriptCode=this.aScripts[lnCount,2]
	lcHTML=lcScriptCode
ENDFOR
IF NOT llMatch
	IF EMPTY(tcAlias) AND NOT this.OpenVFPScript()
		SELECT (lnLastSelect)
		RETURN .F.
	ENDIF
	IF NOT USED(lcAlias)
		SELECT (lnLastSelect)
		RETURN .F.
	ENDIF
	SELECT (lcAlias)
	lnRecNo=IIF(EOF() OR RECNO()>RECCOUNT(),0,RECNO())
	IF NOT LOWER(ALLTRIM(Name))==lcName
		LOCATE FOR LOWER(ALLTRIM(Name))==lcName
	ENDIF
	llMatch=(NOT EMPTY(Name))
	IF llMatch
		IF TYPE("LastAccess")=="T"
			REPLACE LastAccess WITH ltDateTime, ExecCount WITH ExecCount+1
		ENDIF
		lcScriptCode=Script
		lcHTML=HTML
	ENDIF
	IF lnRecNo=0
		GO BOTTOM
	ELSE
		GO lnRecNo
	ENDIF
ENDIF
SELECT (lnLastSelect)
DO CASE
	CASE tnCode=0
		IF this.lDesign
			this.EditScript(lcName)
			RETURN
		ENDIF
		RETURN this.RunCode(lcScriptCode)
	CASE tnCode=1
		RETURN lcHTML
ENDCASE
RETURN .F.

ENDPROC
PROCEDURE msgbox
LPARAMETERS tcMessage,tnType,tcTitle
LOCAL lcMessage,lnType,lcTitle,lnResult

lcMessage=IIF(TYPE("tcMessage")#"C","",tcMessage)
lnType=IIF(TYPE("tnType")#"N",48,tnType)
lcTitle=IIF(TYPE("tcTitle")#"C",thisform.Caption,tcTitle)
ACTIVATE SCREEN
lnResult=MESSAGEBOX(lcMessage,lnType,lcTitle)
RETURN lnResult

ENDPROC
PROCEDURE editstring
LPARAMETERS tcString,tcTitle,tlNoEdit
LOCAL lcString,lcTitle,lcTempFileName

lcString=IIF(TYPE("tcString")=="C",tcString,"")
lcTitle=IIF(TYPE("tcTitle")=="C",ALLTRIM(tcTitle),LOWER(SYS(2015)))
lcTempFileName=SYS(2023)+"\"+"~_  "+lcTitle+".htm"
IF NOT this.StringToFile(lcString,lcTempFileName)
	RETURN .F.
ENDIF
ACTIVATE SCREEN
IF tlNoEdit
	MODIFY FILE (lcTempFileName) NOEDIT RANGE 1,1
ELSE
	MODIFY FILE (lcTempFileName) RANGE 1,1
	lcString=this.FileToString(lcTempFileName)
ENDIF
ERASE (lcTempFileName)
RETURN lcString

ENDPROC
PROCEDURE editscript
LPARAMETERS tcScriptName
LOCAL lcScriptName,lcOldScriptCode,lcNewScriptCode,lnScriptNum,lcScriptNameSearch
LOCAL lcFileName,lcOldHTML,lcNewHTML,llResult,llMatch,llNoEdit,lcCR_LF

#DEFINE SCRIPT_LOC					"Script"
#DEFINE NOT_FOUND_IN_FILE_LOC		"not found in file"
#DEFINE IN_FILE_LOC					"in file"
#DEFINE UPDATED_LOC					"updated"
#DEFINE	UNABLE_TO_UPDATE_SCRIPT_LOC	"Unable to update script"

IF EMPTY(tcScriptName)
	RETURN .F.
ENDIF
lcCR_LF=CHR(13)+CHR(10)
lcScriptName=ALLTRIM(tcScriptName)
lcFileName=this.cFileName
llMatch=.F.
FOR lnScriptNum = 1 TO this.nScriptCount
	IF LOWER(lcScriptName)==LOWER(this.aScripts[lnScriptNum,1])
		lcScriptName=this.aScripts[lnScriptNum,1]
		lcOldScriptCode=this.aScripts[lnScriptNum,3]
		llMatch=.T.
		EXIT
	ENDIF
ENDFOR
IF NOT llMatch
	this.MsgBox(SCRIPT_LOC+[ (]+lcScriptName+[) ]+NOT_FOUND_IN_FILE_LOC+[ "]+lcFileName+[".],16)
	RETURN .F.
ENDIF
lcScriptNameSearch=" "+lcScriptName+lcCR_LF
lcOldHTML=this.FileToString(lcFileName)
llNoEdit=(NOT lcScriptNameSearch$lcOldHTML)
lcNewScriptCode=this.EditString(lcOldScriptCode,lcScriptName,llNoEdit)
IF llNoEdit OR lcOldScriptCode==lcNewScriptCode
	RETURN
ENDIF
IF NOT RIGHT(lcNewScriptCode,2)==lcCR_LF
	lcNewScriptCode=lcNewScriptCode+lcCR_LF
ENDIF
this.aScripts[lnScriptNum,3]=lcNewScriptCode
lcNewHTML=STRTRAN(lcOldHTML,lcScriptNameSearch+lcOldScriptCode, ;
		lcScriptNameSearch+lcNewScriptCode)
IF lcOldHTML==lcNewHTML
	llResult=.F.
ELSE
	llResult=this.StringToFile(lcNewHTML,lcFileName)
ENDIF
IF NOT llResult
	this.MsgBox(UNABLE_TO_UPDATE_SCRIPT_LOC+[ (]+lcScriptName+[) ]+IN_FILE_LOC+[ "]+lcFileName+[".],16)
	RETURN .F.
ENDIF
this.WaitWindow(SCRIPT_LOC+[ (]+lcScriptName+[) ]+IN_FILE_LOC+[ "]+lcFileName+[" ]+UPDATED_LOC+[.])

ENDPROC
PROCEDURE opentable
LPARAMETERS tcFileName,tcAlias,tlExclusive,tcFilter
LOCAL lcFileName,lcAlias,lnLastSelect

this.nRecNo=0
this.cAlias=""
this.cDBF=""
this.cDBFPath=""
IF EMPTY(tcFileName)
	RETURN .F.
ENDIF
lcFileName=ALLTRIM(tcFileName)
IF NOT "."$lcFileName
	lcFileName=lcFileName+".dbf"
ENDIF
IF NOT FILE(lcFileName)
	RETURN .F.
ENDIF
SET DATASESSION TO (this.nDataSessionID)
lcAlias=STRTRAN(IIF(EMPTY(tcAlias),this.TrimPath(lcFileName,.T.),ALLTRIM(tcAlias))," ","_")
this.cAlias=lcAlias
IF USED(lcAlias)
	this.nRecNo=RECNO(lcAlias)
	this.cDBF=LOWER(DBF(lcAlias))
	this.cDBFPath=this.TrimFile(this.cDBF)
	SET DATASESSION TO (this.oHost.DataSessionID)
	RETURN
ENDIF
lnLastSelect=SELECT()
SELECT 0
IF tlExclusive
	USE (lcFileName) EXCLUSIVE ALIAS (lcAlias)
ELSE
	USE (lcFileName) AGAIN SHARED ALIAS (lcAlias)
ENDIF
IF NOT USED(lcAlias)
	this.nRecNo=0
	this.cAlias=""
	this.cDBF=""
	this.cDBFPath=""
	SELECT (lnLastSelect)
	RETURN .F.
ENDIF
this.cDBF=LOWER(DBF(lcAlias))
this.cDBFPath=this.TrimFile(this.cDBF)
IF NOT EMPTY(tcFilter)
	SET FILTER TO &tcFilter
ENDIF
LOCATE
SELECT (lnLastSelect)
SET DATASESSION TO (this.oHost.DataSessionID)

ENDPROC
PROCEDURE browsetable
LPARAMETERS tcAlias,tcClauses
LOCAL lcAlias,lnLastSelect,lcCommand

lcAlias=IIF(EMPTY(tcAlias),this.cAlias,ALLTRIM(tcAlias))
IF EMPTY(lcAlias) OR NOT USED(lcAlias)
	RETURN .F.
ENDIF
lnLastSelect=SELECT()
SELECT (lcAlias)
IF BETWEEN(this.nRecNo,1,RECCOUNT())
	GO this.nRecNo
ELSE
	LOCATE
ENDIF
ACTIVATE SCREEN
lcCommand="BROWSE"
IF NOT EMPTY(tcClauses)
	lcCommand=lcCommand+" "+tcClauses
ENDIF
&lcCommand
SELECT (lnLastSelect)

ENDPROC
PROCEDURE waitwindow
LPARAMETERS tcText,tlWait
LOCAL lcText

WAIT CLEAR
IF EMPTY(tcText)
	RETURN
ENDIF
lcText=LEFT(tcText,254)
DO CASE
	CASE TYPE("tlWait")=="L"
		IF tlWait
			WAIT WINDOW tcText
		ELSE
			WAIT WINDOW tcText NOWAIT
		ENDIF
	CASE TYPE("tlWait")=="N"
		WAIT WINDOW tcText TIMEOUT (tlWait)
	OTHERWISE
		RETURN .F.
ENDCASE

ENDPROC
PROCEDURE setbusystate
LPARAMETERS tlBusy

IF this.lBusy=tlBusy
	RETURN
ENDIF
this.lBusy=tlBusy

ENDPROC
PROCEDURE closetable
LPARAMETERS tcAlias
LOCAL lcAlias

SET DATASESSION TO (this.nDataSessionID)
lcAlias=IIF(EMPTY(tcAlias),this.cAlias,ALLTRIM(tcAlias))
IF NOT EMPTY(lcAlias) AND USED(lcAlias)
	USE IN (lcAlias)
ENDIF
SET DATASESSION TO (this.oHost.DataSessionID)

ENDPROC
PROCEDURE skiprecord
LPARAMETERS tnRecords
LOCAL lnRecords,lcAlias,lnRecNo,lnLastSelect,lnLastRecNo

SET DATASESSION TO (this.nDataSessionID)
lcAlias=this.cAlias
IF EMPTY(lcAlias) OR NOT USED(lcAlias)
	SET DATASESSION TO (this.oHost.DataSessionID)
	RETURN .F.
ENDIF
lnRecords=IIF(EMPTY(tnRecords),0,tnRecords)
lnLastSelect=SELECT()
SELECT (lcAlias)
IF EOF()
	GO BOTTOM
ENDIF
lnLastRecNo=RECNO()
lnRecNo=IIF(this.nRecNo>0,this.nRecNo,RECNO())
GO lnRecNo
SKIP lnRecords
IF BOF()
	GO TOP
ENDIF
IF EOF()
	GO BOTTOM
ENDIF
this.nRecNo=RECNO()
GO lnLastRecNo
SELECT (lnLastSelect)
SET DATASESSION TO (this.oHost.DataSessionID)
this.RunScript("RefreshData")

ENDPROC
PROCEDURE addprop
LPARAMETERS toObject,tcProperty,tuValue
LOCAL lcFileName,llAddPropLibSet,lvResult

lcFileName=this.cProgramPath+"AddProp5.fll"
IF NOT FILE(lcFileName)
	RETURN .F.
ENDIF
llAddPropLibSet=(ATC(lcFileName,SET("LIBRARY"))>0)
IF NOT llAddPropLibSet
	SET LIBRARY TO (lcFileName) ADDITIVE
ENDIF
lvResult=AddProp(toObject,tcProperty,tuValue)
IF NOT llAddPropLibSet
	RELEASE LIBRARY (lcFileName)
ENDIF
RETURN lvResult

ENDPROC
PROCEDURE newwindow
*** OLE Control Event ***
LPARAMETERS url, flags, targetframename, postdata, headers, processed

IF TYPE("url")#"C"
	RETURN
ENDIF
IF this.lDebug
	ACTIVATE SCREEN
	? PROGRAM()
	? "URL: "+url
	IF NOT EMPTY(targetframename)
		?? "  Frame: "+targetframename
	ENDIF
ENDIF
processed=.T.
this.Navigate(@url,@flags,@targetframename,@postdata,@headers)

ENDPROC
PROCEDURE beforenavigate
*** OLE Control Event ***
PARAMETERS url, flags, targetframename, postdata, headers, cancel
LOCAL lcURL,lcNewURL,lcSource,llJump,llMailTo,lcFileExt,lnAtPos,lnHistory

IF this.lRelease OR this.lBusy
	ACTIVATE SCREEN
	? PROGRAM()
	? "Busy"
	? "URL: "+url
	IF NOT EMPTY(targetframename)
		?? "  Frame: "+targetframename
	ENDIF
	cancel=.T.
	RETURN .F.
ENDIF
this.SetBusyState(.T.)
IF this.lDebug
	ACTIVATE SCREEN
	? PROGRAM()
	? "URL: "+url
	IF NOT EMPTY(targetframename)
		?? "  Frame: "+targetframename
	ENDIF
ENDIF
lcURL=ALLTRIM(url)
this.SetParam(lcURL)
llVisible=this.Visible
llMailTo=(LOWER(LEFT(lcURL,7))=="mailto:")
IF NOT llMailTo
	this.cBeforeURL=lcURL
ENDIF
lnAtPos=RAT(".",lcURL)
lcFileExt=IIF(lnAtPos=0,CHR(0),ALLTRIM(SUBSTR(lcURL,lnAtPos+1)))
IF NOT this.lParseSource OR ATC(";"+lcFileExt+";",";"+this.cParseFileExt+";")=0 OR ;
		CHR(1)$lcURL OR NOT FILE(lcURL)
	IF NOT this.lParseSource
		this.cFileName=""
	ENDIF
	this.cSourceURL=""
	this.BeforeRetrieval(@url,@flags,@targetframename,@postdata, ;
			@headers,@cancel)
	IF NOT cancel
		this.cFileName=""
		this.cSourceFile=""
		this.cSourceFileName=""
		this.cSourceHTML=""
	ENDIF
	this.SetBusyState(.F.)
	RETURN
ENDIF
IF NOT this.BeforeRetrieval(@url,@flags,@targetframename,@postdata, ;
		@headers,@cancel) OR cancel
	IF NOT cancel
		this.cSourceURL=""
		this.cSourceFile=""
		this.cSourceHTML=""
	ENDIF
	this.SetBusyState(.F.)
	RETURN .F.
ENDIF
IF llMailTo OR (NOT EMPTY(this.cTempFileName) AND LOWER(url)==LOWER(this.cTempFileName))
	this.SetBusyState(.F.)
	RETURN .F.
ENDIF
IF NOT cancel
	this.cSourceFile=""
	this.cSourceHTML=""
ENDIF
IF NOT this.ParseSource(lcURL) OR EMPTY(this.cNewURL)
	this.SetBusyState(.F.)
	RETURN
ENDIF
cancel=.T.
this.cSourceFile=""
this.cSourceHTML=""
this.Navigate(this.cNewURL,12,@targetframename)
this.SetBusyState(.F.)

ENDPROC
PROCEDURE navigatecomplete
*** OLE Control Event ***
LPARAMETERS url
LOCAL lcURL,lcLocationURL,lcSourceFileName

IF TYPE("url")#"C"
	RETURN
ENDIF
lcSourceFileName=this.cSourceFileName
IF this.lDebug
	ACTIVATE SCREEN
	? PROGRAM()
	? "URL: "+url
	? "Location URL: "+this.LocationURL
	? "Source file name: "+lcSourceFileName
ENDIF
IF EMPTY(lcSourceFileName)
	lcURL=LOWER(ALLTRIM(url))
ELSE
	lcURL=lcSourceFileName
ENDIF
IF EMPTY(lcURL) OR (SUBSTR(lcURL,5,1)==":" AND NOT LEFT(lcURL,5)=="file:" AND ;
		NOT LEFT(lcURL,4)=="http") OR RIGHT(lcURL,11)=="about:blank"
	RETURN
ENDIF
this.cLastURL=this.cURL
this.cURL=LOWER(this.ValidURL(lcURL))
lcLocationURL=LOWER(this.ValidURL(this.LocationURL))
IF this.lRefreshMode
	this.lRefreshMode=.F.
	this.lHistoryEnabled=.T.
	RETURN
ENDIF
IF NOT this.lHistoryEnabled
	this.lHistoryEnabled=.T.
	RETURN
ENDIF
lcURL=lcLocationURL
IF this.nHistoryCount>0 AND (this.aHistory[this.nHistoryCount,1]==lcURL OR ;
		(NOT EMPTY(lcSourceFileName) AND this.aHistory[this.nHistoryCount,2]==lcSourceFileName))
	RETURN
ENDIF
this.nHistoryCount=this.nHistoryCount+1
DIMENSION this.aHistory[this.nHistoryCount,2]
this.aHistory[this.nHistoryCount,1]=lcURL
this.aHistory[this.nHistoryCount,2]=lcSourceFileName

ENDPROC
PROCEDURE framebeforenavigate
*** OLE Control Event ***
LPARAMETERS url, flags, targetframename, postdata, headers, cancel

IF TYPE("url")#"C"
	RETURN
ENDIF
IF this.lDebug
	ACTIVATE SCREEN
	? PROGRAM()
	? "URL: "+url
	IF NOT EMPTY(targetframename)
		?? "  Frame: "+targetframename
	ENDIF
ENDIF
this.BeforeNavigate(@url,flags,@targetframename,@postdata,@headers,@cancel)

ENDPROC
PROCEDURE validateurl
LPARAMETERS tcURL
LOCAL lcURL,lnLastSelect

lcURL=ALLTRIM(tcURL)
IF this.lRelease OR lcURL==this.cLastURL OR ;
		LOWER(lcURL)==LOWER(ALLTRIM(this.cBlankHTMLFile))
	RETURN
ENDIF
SET DATASESSION TO (this.oHost.DataSessionID)
lnLastSelect=SELECT()
IF NOT this.OpenVFPScript()
	SELECT (lnLastSelect)
	RETURN
ENDIF
SELECT vfpscript
SCAN ALL FOR BeforeNav AND URLCancel
	IF NOT EMPTY(URLMatch) AND NOT this.WildCardMatch(ALLTRIM(MLINE(URLMatch,1)),lcURL)
		LOOP
	ENDIF
	IF NOT EMPTY(URLEval) AND (TYPE(URLEval)#"L" OR NOT EVALUATE(URLEval))
		LOOP
	ENDIF
	this.cURL=LOWER(this.ValidURL(this.cLastURL))
	SELECT (lnLastSelect)
	RETURN .F.
ENDSCAN
SELECT (lnLastSelect)

ENDPROC
PROCEDURE NavigateComplete2
*** OLE Control Event ***
LPARAMETERS pdisp, url

RETURN this.NavigateComplete(url)

ENDPROC
PROCEDURE NewWindow2
*** OLE Control Event ***
LPARAMETERS ppdisp, cancel

RETURN this.NewWindow(@cancel)

ENDPROC
PROCEDURE GoBack
*** OLE Control Method ***
LOCAL lcURL,lcSourceFileName

IF this.nHistoryCount<2
	NODEFAULT
	RETURN .F.
ENDIF
lcURL=this.aHistory[this.nHistoryCount-1,1]
lcSourceFileName=this.aHistory[this.nHistoryCount-1,2]
this.nHistoryCount=this.nHistoryCount-1
IF this.nHistoryCount>0
	DIMENSION this.aHistory[this.nHistoryCount,2]
ELSE
	this.aHistory=""
ENDIF
this.lHistoryEnabled=.F.
IF NOT EMPTY(lcSourceFileName)
	NODEFAULT
	this.Navigate(lcSourceFileName)
	RETURN .F.
ENDIF
IF NOT EMPTY(lcURL) AND NOT EMPTY(this.cSourceFileName) AND	NOT lcURL==lcSourceFileName
	NODEFAULT
	this.Navigate(lcURL)
	RETURN .F.
ENDIF

ENDPROC
PROCEDURE LostFocus
IF this.lDebug
	ACTIVATE SCREEN
	? PROGRAM()
ENDIF
this.RefreshDeactivate

ENDPROC
PROCEDURE Destroy
this.EraseTempFile
this.lRelease=.T.
this.cSourceFile=""
this.cSourceHTML=""
this.oAction=.NULL.
this.oSource=.NULL.
this.oUser=.NULL.
this.oHost=.NULL.
IF USED("vfpscript")
	USE IN vfpscript
ENDIF

ENDPROC
PROCEDURE Navigate
*** OLE Control Method ***
LPARAMETERS url, flags, targetframename, postdata, headers
LOCAL lcURL,lcNewURL

IF this.lRelease
	NODEFAULT
	url=""
	RETURN .F.
ENDIF
IF TYPE("url")#"C"
	RETURN
ENDIF
IF this.lDebug
	ACTIVATE SCREEN
	? PROGRAM()
	? "URL: "+url
	IF NOT EMPTY(targetframename)
		?? "  Frame: "+targetframename
	ENDIF
ENDIF
lcURL=ALLTRIM(url)
IF LEFT(lcURL,LEN(this.cVFPSProtocol))==LOWER(this.cVFPSProtocol)
	NODEFAULT
	RETURN this.BeforeNavigate(@url,@flags,@targetframename,@postdata,@headers)
ENDIF
IF RIGHT(url,16)==SPACE(16)
	this.cBeforeURL=ALLTRIM(lcURL)
	this.cSourceFile=""
	this.cSourceHTML=""
	RETURN
ENDIF
IF NOT this.ParseSource(lcURL) OR EMPTY(this.cNewURL)
	RETURN
ENDIF
NODEFAULT
url=""
RETURN this.Navigate(this.cNewURL,12,@targetframename)

ENDPROC
PROCEDURE Refresh
*** OLE Control Method ***

IF this.lDebug
	ACTIVATE SCREEN
	? PROGRAM()
ENDIF
IF this.lRefresh AND NOT this.lDesign
	this.RunScript("OnRefresh")
ENDIF
this.lRefresh=.T.
NODEFAULT

ENDPROC
PROCEDURE Statustextchange
*** OLE Control Event ***
LPARAMETERS text

IF this.lRelease OR this.lBusy OR NOT this.oHost.Visible
	RETURN .F.
ENDIF
IF TYPE("text")=="C" AND NOT EMPTY(text)
	SET MESSAGE TO LEFT(text,254)
ELSE
	SET MESSAGE TO
ENDIF

ENDPROC
PROCEDURE Downloadcomplete
*** OLE Control Event ***

IF this.lDebug
	ACTIVATE SCREEN
	? PROGRAM()
ENDIF
IF TYPE("this.LocationURL")=="C"
	this.cURL=LOWER(this.ValidURL(this.LocationURL))
ENDIF
this.NavigateComplete(this.cURL)
this.RunScript("OnLoad")

ENDPROC
PROCEDURE Commandstatechange
*** OLE Control Event ***
LPARAMETERS command, enable
LOCAL llEnabled

IF this.lRelease
	RETURN .F.
ENDIF
IF this.lDebug
	ACTIVATE SCREEN
	? PROGRAM()
	? "Command: "+ALLTRIM(STR(command))
	? "Enable: "+IIF(enable,"ON","OFF")
ENDIF
llEnable=enable
DO CASE
	CASE command=1
		IF TYPE("thisform.cmdGoForward")=="O"
			thisform.cmdGoForward.Enabled=llEnable
		ENDIF
	CASE command=2
		IF this.nHistoryCount=0
			llEnable=.F.
		ENDIF
		IF TYPE("thisform.cmdGoBack")=="O"
			thisform.cmdGoBack.Enabled=llEnable
		ENDIF
ENDCASE

ENDPROC
PROCEDURE Init
LPARAMETERS tcVFPScript

DIMENSION this.aHistory[1,2]
this.aHistory=""
this.oHost=thisform
this.oUser=CREATEOBJECT("Custom")
this.oUser.Name="oCustom"
this.nDataSessionID=thisform.DataSessionID
this.cProgramPath=IIF(TYPE("this.oHost.cProgramPath")=="C",this.oHost.cProgramPath, ;
		this.ClassLibrary)
IF NOT "\"$this.cBlankHTMLFile AND NOT ":"$this.cBlankHTMLFile
	this.cBlankHTMLFile=LOWER(this.cProgramPath+this.cBlankHTMLFile)
ENDIF
DO CASE
	CASE ISNULL(tcVFPScript)
		this.cVFPScript=""
	CASE EMPTY(tcVFPScript) OR TYPE("tcVFPScript")#"C"
		this.cVFPScript=LOWER(FULLPATH(this.cVFPScriptTable,this.cProgramPath))
	OTHERWISE
		this.cVFPScript=LOWER(ALLTRIM(tcVFPScript))
ENDCASE
IF EMPTY(this.cVFPScript)
	this.lVFPScript=.F.
ENDIF
this.OpenVFPScript
SELECT 0
IF this.lBlankHTMLStartup AND NOT EMPTY(this.cBlankHTMLFile) AND FILE(this.cBlankHTMLFile)
	this.Navigate(this.cBlankHTMLFile)
ENDIF
SELECT 0

ENDPROC
PROCEDURE Refresh2
*** OLE Control Method ***
LPARAMETERS level

IF this.lRelease OR NOT this.lRefresh
	NODEFAULT
	RETURN .F.
ENDIF
IF NOT EMPTY(this.cSourceFileName)
	RETURN this.RefreshMode()
ENDIF

ENDPROC
PROCEDURE Error
LPARAMETERS nError, cMethod, nLine
LOCAL lcMessage,lcMethod,lcErrorMsg,lcCodeLineMsg

#DEFINE	RUNCODE_RUNTIME_ERROR_LOC	"RunCode Runtime Error"
#DEFINE	TAB		CHR(9)
#DEFINE	LF		CHR(10)
#DEFINE	CR		CHR(13)
#DEFINE CR_LF	CR+LF

IF this.lIgnoreErrors OR INLIST(nError,1113,1426,1429,2012)
	RETURN
ENDIF
IF NOT EMPTY(GETPEM(thisform,"Error"))
	RETURN thisform.Error(nError,cMethod,nLine)
ENDIF
lcMethod=LOWER(ALLTRIM(cMethod))
IF INLIST(LOWER(lcMethod),"goback","gofoward") OR RIGHT(lcMethod,9)==".navigate"
	RETURN
ENDIF
lcErrorMsg=MESSAGE()+CR+CR+thisform.Caption+":  "+this.Name+CR+ ;
		"Object:        "+this.Name+CR+ ;
		"Error:           "+ALLTRIM(STR(nError))+CR+ ;
		"Method:       "+lcMethod
lcCodeLineMsg=MESSAGE(1)
IF BETWEEN(nLine,1,10000) AND NOT lcCodeLineMsg="..."
	lcErrorMsg=lcErrorMsg+CR+"Line:            "+ALLTRIM(STR(nLine))
	IF NOT EMPTY(lcCodeLineMsg)
		lcErrorMsg=lcErrorMsg+CR+CR+lcCodeLineMsg
	ENDIF
ENDIF
IF this.Msgbox(lcErrorMsg,17)#1
	this.ReleaseHost
ENDIF

ENDPROC
PROCEDURE GoForward
*** OLE Control Method ***

DOEVENTS

ENDPROC
PROCEDURE GOHOME
*** OLE Control Method ***

DOEVENTS

ENDPROC
PROCEDURE Gosearch
*** OLE Control Method ***

DOEVENTS

ENDPROC
PROCEDURE BeforeNavigate2
*** OLE Control Event ***
LPARAMETERS pdisp, url, flags, targetframename, postdata, headers, cancel

RETURN this.BeforeNavigate(@url,@flags,@targetframename,@postdata,@headers,@cancel)

ENDPROC
PROCEDURE Navigate2
*** OLE Control Method ***
LPARAMETERS url, flags, targetframename, postdata, headers

NODEFAULT
RETURN this.Navigate(@url,@flags,@targetframename,@postdata,@headers)

ENDPROC


