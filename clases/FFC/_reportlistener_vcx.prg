************************************************************
OBJETO: utilityreportlistener
************************************************************
*** PROPIEDADES ***
FRXDataSession = -1
readconfiguration = (0)
targetfileext = ("TXT")
targetfilename = (FORCEPATH(SYS(2015),SYS(2023)))
targethandle = -1
configurationobjtype = 1000
frxcursor = (NULL)
configurationtable = ("")
_memberdata =     1586<VFPData> <memberdata name="closetargetfile" type="method" display="closeTargetFile" favorites="False" /> <memberdata name="configurationobjtype" type="property" display="configurationObjtype" favorites="True" /> <memberdata name="configurationtable" type="property" display="configurationTable" favorites="False" /> <memberdata name="createconfigtable" type="method" display="createConfigTable" favorites="True" /> <memberdata name="frxcursor" type="property" display="frxCursor" favorites="True" /> <memberdata name="getconfigtable" type="method" display="getConfigTable" favorites="True" /> <memberdata name="getpathforexternals" type="method" display="getPathForExternals" favorites="True" /> <memberdata name="loadfrxcursor" type="property" display="loadFrxCursor" favorites="True" /> <memberdata name="opentargetfile" type="method" display="openTargetFile" favorites="False" /> <memberdata name="readconfiguration" type="property" display="readConfiguration" favorites="True" /> <memberdata name="setconfiguration" type="method" display="setConfiguration" favorites="True" /> <memberdata name="targetfileext" type="property" display="targetFileExt" favorites="True" /> <memberdata name="targetfilename" type="property" display="targetFileName" favorites="True" /> <memberdata name="targethandle" type="property" display="targetHandle" favorites="True" /> <memberdata name="verifyconfigtable" type="property" display="verifyConfigTable" favorites="True" /> <memberdata name="verifytargetfile" type="method" display="verifyTargetFile" favorites="True" /></VFPData>
Name = "utilityreportlistener"

*** METODOS ***
PROCEDURE readconfiguration_assign
LPARAMETERS vNewVal
IF VARTYPE(m.vNewVal) = "N" AND NOT THIS.IsRunning
   THIS.ReadConfiguration = m.vNewVal
ENDIF   

ENDPROC
PROCEDURE setconfiguration
LPARAMETERS tlCalledFromInit

IF NOT THIS.IsRunning 
   * do some config work, don't change sessions --
   * at this point we don't have our private session
   * if we're being called in the Init

   LOCAL liSelect, lcPEM, llOpened, lcOrder, liType, llQuiet
  
   liSelect = SELECT()

   IF NOT USED("OutputConfig")
      * if called from Init, 
      * do this in quietmode
      * because the caller has no
      * opportunity to 
      * turn off the message
      llQuiet = (tlCalledFromInit AND NOT THIS.QuietMode)
      IF llQuiet
         THIS.QuietMode = .T.
      ENDIF
      THIS.GetConfigTable()
      IF llQuiet
         THIS.QuietMode = .F.
      ENDIF
      USE (THIS.ConfigurationTable) ALIAS "OutputConfig" IN 0 AGAIN NOUPDATE SHARED
      llOpened = .T.
   ELSE 
      lcOrder = ORDER("OutputConfig")
      SET ORDER TO ObjCode
   ENDIF

   IF (NOT THIS.HadError) AND THIS.VerifyConfigTable("OutputConfig")

      SELECT OutputConfig
      liType = THIS.ConfigurationObjtype

      SCAN FOR ObjType = liType AND ;
            NOT(DELETED() OR ;
                ObjName == "" OR ;
                ObjValue =="" )
          
         IF PEMSTATUS(THIS,ObjName,5) 
            lcPEM = UPPER(PEMSTATUS(THIS,ObjName,3))
            DO CASE
            CASE lcPEM == "PROPERTY"
               STORE EVAL(ObjValue) TO ("THIS."+ObjName)
            CASE INLIST("|"+lcPEM+"|","|METHOD|","|EVENT|")
               EVAL("THIS."+ObjName+"("+ObjValue+")")
            OTHERWISE
            ENDCASE
          ENDIF

      ENDSCAN

      IF llOpened
         USE IN OutputConfig
      ELSE
         SET ORDER TO (lcOrder) IN OutputConfig   
      ENDIF   

   ENDIF   

   SELECT (liSelect)

ENDIF   

ENDPROC
PROCEDURE getconfigtable
LPARAMETERS tlForceExternal

LOCAL lcDBF, lcPath

lcDBF = ""

IF tlForceExternal OR FILE(FULLPATH(FORCEEXT(OUTPUTCLASS_EXTERNALDBF,"DBF")))
   lcDBF = FULLPATH(FORCEEXT(OUTPUTCLASS_EXTERNALDBF,"DBF"))
ELSE
   lcDBF = FORCEEXT(OUTPUTCLASS_INTERNALDBF,"DBF")
ENDIF
   
IF NOT (FILE(lcDBF) OR THIS.IsRunning)

      lcPath = THIS.GetPathForExternals()
      * this may be the internal *or* external dbf name;
      * we could be testing and not yet built into an app,
      * so accept either, before the next test:
      lcDBF = FORCEPATH(lcDBF,lcPath) 
      
      IF NOT FILE(lcDBF)
         * now force to the external name:
         lcDBF = FORCEEXT(FORCEPATH(OUTPUTCLASS_EXTERNALDBF,lcPath),"DBF")
         * now check again
         IF NOT FILE(lcDBF)
            THIS.CreateConfigTable(lcDBF)
            IF FILE(lcDBF)
               THIS.DoMessage(OUTPUTCLASS_CONFIGTABLECREATED_LOC)
            ENDIF
         ENDIF
      ENDIF

ENDIF 

IF NOT FILE(lcDBF)
   lcDBF = ""
ENDIF  

THIS.ConfigurationTable = lcDBF

RETURN lcDBF
ENDPROC
PROCEDURE createconfigtable
LPARAMETERS tcDBF, tlOverWrite
LOCAL liSelect, lcFile

lcFile = FORCEEXT(tcDBF,"DBF")

IF FILE(lcFile) AND tlOverWrite
   ERASE (lcFile) RECYCLE
   ERASE (FORCEEXT(lcFile,"FPT")) RECYCLE
   ERASE (FORCEEXT(lcFile,"CDX")) RECYCLE   
ENDIF   

liSelect = SELECT()

SELECT 0

CREATE TABLE (lcFile) FREE ;
   (objtype i, ;
    objcode i, ;
    objname v(60), ;
    objvalue v(60), ;
    objinfo m)

IF NOT EMPTY(ALIAS()) && can happen if SAFETY ON and they decide not to overwrite    

   INDEX ON Objtype TAG ObjType
   INDEX ON ObjCode TAG ObjCode
   INDEX ON ObjName TAG ObjName
   INDEX ON ObjValue TAG ObjValue
   INDEX ON DELETED() TAG OnDeleted    
   
   INSERT INTO (ALIAS()) VALUES ;
      (OUTPUTCLASS_OBJTYPE_CONFIG,0,'DoMessage','"Welcome to the demo run!",64','Sample initialization/config method call')
   DELETE NEXT 1

   INSERT INTO (ALIAS()) VALUES ;
     (OUTPUTCLASS_OBJTYPE_CONFIG,0,'TargetFileName','"xxx"','Sample initialization/config property')
   DELETE NEXT 1
   USE
   
ENDIF   

SELECT (liSelect)   
ENDPROC
PROCEDURE opentargetfile
   THIS.VerifyTargetFile() 

   THIS.TargetHandle = FCREATE(THIS.TargetFileName)
 
   IF THIS.TargetHandle < 0 OR THIS.HadError
      THIS.HadError = .T.
      THIS.DoMessage(OUTPUTCLASS_NOFILECREATE_LOC,MB_ICONSTOP )
   ENDIF

RETURN (NOT THIS.HadError)
     
ENDPROC
PROCEDURE verifytargetfile
LOCAL lcFile

lcFile =  ALLTR(CHRTRAN(THIS.TargetFileName,;
                       OUTPUTCLASS_FILENAME_CHARS_DISALLOWED,"_"))

IF NOT DIRECTORY(JUSTPATH(lcFile))
   lcFile = FULLPATH(ALLTR(lcFile))
ENDIF   

IF DIRECTORY(lcFile)
   * we have to generate a filename
   lcFile = FORCEPATH(SYS(2015), lcFile)
ENDIF

THIS.TargetFileName = lcFile   

IF JUSTEXT(THIS.TargetFileName) == "" AND ;
   RIGHT(THIS.TargetFileName,1) # "."      

   THIS.TargetFileExt = CHRTRAN(THIS.TargetFileExt,;
                        OUTPUTCLASS_FILENAME_CHARS_DISALLOWED,"_")

   THIS.TargetFileName = FORCEEXT(THIS.TargetFileName, ;
                                    THIS.TargetFileExt)
ENDIF                                 
 
IF FILE(THIS.TargetFileName)
   ERASE (THIS.TargetFileName) NORECYCLE
ENDIF

ENDPROC
PROCEDURE targetfileext_assign
LPARAMETERS vNewVal
IF VARTYPE(vNewVal) = "C" AND NOT THIS.IsRunning
   THIS.targetfileext = m.vNewVal
ENDIF   

ENDPROC
PROCEDURE targetfilename_assign
LPARAMETERS vNewVal
IF VARTYPE(m.vNewVal) = "C" AND NOT THIS.IsRunning
   THIS.targetfilename = m.vNewVal
ENDIF   

ENDPROC
PROCEDURE targethandle_assign
LPARAMETERS vNewVal
* Readonly during report run
IF VARTYPE(m.vNewVal) = "N" AND NOT THIS.IsRunning
   THIS.targethandle = m.vNewVal
ENDIF   

ENDPROC
PROCEDURE closetargetfile
   LOCAL laDummy[1]
     
   IF THIS.TargetHandle > -1    

      =FCLOSE(THIS.TargetHandle)
      THIS.TargetHandle = -1
     
      IF ADIR(laDummy,THIS.TargetFileName) = 1 AND ;
         laDummy[1,2] > 0
         * NB: have to check this as well as
         * error because some COM errors may not
         * end up in THIS.HadError.
          * if continuation, update status rather than
          * modal message
         IF THIS.HadError
            THIS.DoMessage(OUTPUTCLASS_CREATEERRORS_LOC,MB_ICONEXCLAMATION  )
        ELSE
            IF THIS.DoMessage( OUTPUTCLASS_SUCCESS_LOC + ;
                            IIF(SYS(2024)="Y",CHR(13)+OUTPUTCLASS_REPORT_INCOMPLETE_LOC,""),;
                            MB_ICONINFORMATION + MB_YESNO ) = IDYES
               _CLIPTEXT = THIS.TargetFileName
            ENDIF
         ENDIF
      ELSE
         THIS.DoMessage(OUTPUTCLASS_NOCREATE_LOC,MB_ICONSTOP )
       
      ENDIF                 
     
   ENDIF

ENDPROC
PROCEDURE verifyconfigtable
LPARAMETERS tcAlias, tcFailureMsgTable, tcFailureMsgIndexes

IF EMPTY(tcAlias) OR VARTYPE(tcAlias) # "C"
   RETURN .F.
ENDIF
LOCAL lcTable, lcMessage, lcAlias, liSelect, ;
      llReturn, liTagCount ,laRequired[1], laKeys[1], ;
      liFound, llExactOff, llSafetyOn

llReturn = ;
       TYPE(tcAlias+".OBJTYPE") = "N" AND ;
       TYPE(tcAlias+".OBJCODE") = "N" AND ;  
       TYPE(tcAlias+".OBJNAME") = "C" AND ;
       TYPE(tcAlias+".OBJVALUE") = "C" AND ;
       TYPE(tcAlias+".OBJINFO") = "M" 
       
* additional fields may be included and order
* is not significant
       
IF NOT llReturn
   
   lcMessage = IIF(EMPTY(tcFailureMsgTable),;
                         OUTPUTCLASS_CONFIGTABLEWRONG_LOC, ;
                         tcFailureMsgTable)  + ;
               CHR(13)+CHR(13)+ ;
               DBF(tcAlias)
ENDIF   


IF llReturn

   IF (SET("EXACT") = "OFF")
      SET EXACT ON
      llExactOff = .T.
   ENDIF
   
   liSelect = SELECT()
   SELECT (tcAlias)

   * check for required keys...

   DIME laRequired[5]
   laRequired[1] = "OBJTYPE"
   laRequired[2] = "OBJCODE"
   laRequired[3] = "OBJNAME"
   laRequired[4] = "OBJVALUE"
   laRequired[5] = "DELETED()"   

   IF TAGCOUNT() > 0
      DIME laKeys[TAGCOUNT()]

      FOR liTagCount = 1 TO TAGCOUNT()
          laKeys[liTagCount] = UPPER(KEY(liTagCount))
      ENDFOR
   
      FOR liTagCount = 1 TO ALEN(laRequired)
         liFound = ASCAN(laKeys,UPPER(laRequired[liTagCount]))
         IF liFound = 0
            llReturn = .F.
            EXIT
         ENDIF
      ENDFOR
   ELSE
      llReturn = .F.
   ENDIF      
   
   IF NOT llReturn
   
     llSafetyOn = (SET("SAFETY") = "ON")
     SET SAFETY OFF
   
     TRY
         USE (DBF(tcAlias)) EXCLU ALIAS (tcAlias)
         INDEX ON Objtype TAG ObjType
         INDEX ON ObjCode TAG ObjCode
         INDEX ON ObjName TAG ObjName
         INDEX ON ObjValue TAG ObjValue
         INDEX ON DELETED() TAG OnDeleted    
         llReturn = .T.
      CATCH
      ENDTRY   
      
      IF llSafetyOn
         SET SAFETY OFF
      ENDIF
      
      IF llReturn
         DIME laKeys[TAGCOUNT()]

         FOR liTagCount = 1 TO TAGCOUNT()
             laKeys[liTagCount] = UPPER(KEY(liTagCount))
         ENDFOR
   
         FOR liTagCount = 1 TO ALEN(laRequired)
            liFound = ASCAN(laKeys,UPPER(laRequired[liTagCount]))
            IF liFound = 0
               llReturn = .F.
               EXIT
            ENDIF
         ENDFOR
      ENDIF

      USE (DBF(tcAlias)) SHARED ALIAS (tcAlias)
   
   ENDIF
   
   IF NOT llReturn
      lcMessage =  IIF(EMPTY(tcFailureMsgIndexes),;
                         OUTPUTCLASS_CONFIGINDEXMISSING_LOC, ;
                         tcFailureMsgTable) + CHR(13) 
      FOR liTagCount = 1 TO ALEN(laRequired)
          lcMessage = lcMessage +  CHR(13) + ;
                      laRequired[liTagCount] 
      ENDFOR
   ENDIF
   
   IF llExactOff
      SET EXACT OFF
   ENDIF
   SELECT (liSelect) 

ENDIF

IF NOT(llReturn)
   THIS.DoMessage(lcMessage,MB_ICONSTOP )
ENDIF   

RETURN llReturn       

   
ENDPROC
PROCEDURE loadfrxcursor_assign
LPARAMETERS vNewVal
IF VARTYPE(m.vNewVal) = "L" AND NOT THIS.IsRunning
   THIS.loadfrxcursor = m.vNewVal
ENDIF   

ENDPROC
PROCEDURE frxcursor_access
IF (NOT THIS.IsRunning) AND ;
   ISNULL(THIS.FRXCursor) AND THIS.LoadFRXCursor
   LOCAL loError
   DO CASE
   CASE FILE("_FRXCURSOR.VCX") OR ATC("_FRXCURSOR.VCX",SET("CLASSLIB")) > 0      
  
      TRY 
        THIS.FRXCursor = NEWOBJECT("FRXCursor","_frxcursor.vcx")
      CATCH TO loError
         THIS.FRXCursor = NULL
      ENDTRY   

   CASE FILE(_REPORTOUTPUT)
   
      TRY 
        THIS.FRXCursor = NEWOBJECT("FRXCursor","_frxcursor.vcx", _REPORTOUTPUT)
      CATCH TO loError
         THIS.FRXCursor = NULL
      ENDTRY   

   
*!*	   CASE FILE(_REPORTBUILDER)
*!*	      omit in case of untested version changes
*!*	      TRY 
*!*	        THIS.FRXCursor = NEWOBJECT("FRXCursor","frxcursor.vcx", _REPORTBUILDER)
*!*	      CATCH TO loError
*!*	         THIS.FRXCursor = NULL
*!*	      ENDTRY   

   OTHERWISE   
     * not found
   ENDCASE

   IF ISNULL(THIS.FRXCursor)
      THIS.DoMessage(OUTPUTXML_FRXCURSOR_MISSING_LOC,MB_ICONEXCLAMATION )         
   ENDIF

ENDIF   
RETURN THIS.frxcursor

ENDPROC
PROCEDURE frxcursor_assign
LPARAMETERS vNewVal
IF (NOT THIS.IsRunning)
   THIS.frxcursor = m.vNewVal
ENDIF   

ENDPROC
PROCEDURE getpathforexternals
* this is  mostly for standalone use
* first figure out where to put it
* with the idea of not littering
* the disk too much based on CURDIR().
   
* For app pieces, look for a container module
* and put it there.
* if there isn't one,
* put it with the VCX


      
LOCAL liLevel, lcSys16, lcPath
      
FOR liLevel = PROGRAM(-1) TO 1 STEP -1
   lcSys16 = UPPER(SYS(16,liLevel))
   IF INLIST(RIGHT(lcSys16,3),"APP","EXE","DLL")
      lcPath = JUSTPATH(lcSys16)
      EXIT
   ENDIF
ENDFOR
      
IF EMPTY(lcPath)
   lcPath = JUSTPATH(THIS.ClassLibrary)
ENDIF
IF NOT DIRECTORY(lcPath)
   lcPath = ""
ENDIF

RETURN lcPath
ENDPROC
PROCEDURE configurationobjtype_access
* readonly property
   
RETURN OUTPUTCLASS_OBJTYPE_CONFIG

ENDPROC
PROCEDURE Init
IF DODEFAULT()

   IF INLIST(THIS.ReadConfiguration,;
                  OUTPUTCLASS_READCONFIG_INIT,;
                  OUTPUTCLASS_READCONFIG_BOTH)
     THIS.SetConfiguration(.T.)
   ENDIF   

ELSE

   RETURN .F.   

ENDIF

RETURN NOT THIS.HadError
ENDPROC
PROCEDURE Destroy
THIS.CloseTargetFile()
STORE NULL TO THIS.FRXCursor
DODEFAULT()
ENDPROC
PROCEDURE setfrxdatasessionenvironment
DODEFAULT()
SET DELETED ON
SET EXCLUSIVE OFF
SET TALK OFF

ENDPROC
PROCEDURE BeforeReport
DODEFAULT()

 IF INLIST(THIS.ReadConfiguration,;
                  OUTPUTCLASS_READCONFIG_REPORT,;
                  OUTPUTCLASS_READCONFIG_BOTH)
     THIS.SetConfiguration()
ENDIF   
ENDPROC


************************************************************
OBJETO: updatelistener
************************************************************
*** PROPIEDADES ***
FRXDataSession = -1
thermform = .NULL.
thermformheight = 40
thermformwidth = 356
thermmargin = 5
thermformcaption = ("")
reportstartrundatetime = (DTOT({}))
reportstoprundatetime = (DTOT({}))
includeseconds = .T.
secondstext = ("secs")
escapereference = ("")
onescapecommand = ("")
thermcaption = ([cMessage+ " "+ TRANSFORM(INT(THIS.PercentDone*100)) + "%" + IIF(NOT THIS.IncludeSeconds, "" , " "+TRANSFORM(IIF(THIS.IsRunning,DATETIME(), THIS.ReportStopRunDateTime)-THIS.ReportStartRunDateTime)+" " + THIS.SecondsText)])
initstatustext = ("")
prepassstatustext = ("")
runstatustext = ("")
percentdone = (0)
currentrecord = (0)
drivingaliascurrentrecno = (0)
frxbandrecno = (0)
designateddriver = ("")
successorsys2024 = ("N")
_memberdata =     2824<VFPData><memberdata name="percentdone" type="property" display="percentDone" favorites="False" /> <memberdata name="createtherm" type="method" display="createTherm" favorites="False" /> <memberdata name="currentrecord" type="property" display="currentRecord" favorites="False" /><memberdata name="designateddriver" type="property" display="designatedDriver" favorites="False" /> <memberdata name="drivingaliascurrentrecno" type="property" display="drivingAliasCurrentRecno" favorites="False" /> <memberdata name="escapereference" type="property" display="escapeReference" favorites="False" /> <memberdata name="frxbandrecno" type="property" display="frxBandRecno" favorites="False" /> <memberdata name="getparentwindowref" type="method" display="getParentWindowRef" favorites="False" /> <memberdata name="getreportscopedriver" type="method" display="getReportScopeDriver" favorites="False"/><memberdata name="includeseconds" type="property" display="includeSeconds" favorites="True" /> <memberdata name="initstatustext" type="property" display="initStatusText" favorites="True" /> <memberdata name="onescapecommand" type="property" display="onEscapeCommand" favorites="False" /> <memberdata name="prepassstatustext" type="property" display="prepassStatusText" favorites="True" /> <memberdata name="reportstartrundatetime" type="property" display="reportStartRunDatetime" favorites="True" /> <memberdata name="reportstoprundatetime" type="property" display="reportStopRunDatetime" favorites="True" /> <memberdata name="resetuserfeedback" type="method" display="resetUserFeedback" favorites="False" /> <memberdata name="runstatustext" type="property" display="runStatusText" favorites="True" /> <memberdata name="secondstext" type="property" display="secondsText" favorites="True" /> <memberdata name="setescape" type="property" display="setEscape" favorites="False" /> <memberdata name="setnotifycursor" type="property" display="setNotifyCursor" favorites="False" /> <memberdata name="setthermformcaption" type="method" display="setThermformCaption" favorites="False" /> <memberdata name="thermcaption" type="property" display="thermCaption" favorites="True" /> <memberdata name="thermform" type="property" display="thermForm" favorites="False" /> <memberdata name="thermformcaption" type="property" display="thermFormCaption" favorites="True" /> <memberdata name="thermformheight" type="property" display="thermFormHeight" favorites="True" /> <memberdata name="thermformwidth" type="property" display="thermFormwidth" favorites="True" /> <memberdata name="thermmargin" type="property" display="thermMargin" favorites="True" /> <memberdata name="synchstatus" type="method" display="synchStatus" favorites="False" /><memberdata name="successorsys2024" type="property" display="successorSys2024" favorites="False" /></VFPData>
Name = "updatelistener"

*** METODOS ***
PROCEDURE createtherm
#define CTLCOLOR_MSGBOX             0
#define CTLCOLOR_EDIT               1
#define CTLCOLOR_LISTBOX            2
#define CTLCOLOR_BTN                3
#define CTLCOLOR_DLG                4
#define CTLCOLOR_SCROLLBAR          5
#define CTLCOLOR_STATIC             6
#define CTLCOLOR_MAX                7
#define COLOR_SCROLLBAR             0
#define COLOR_BACKGROUND            1
#define COLOR_ACTIVECAPTION         2
#define COLOR_INACTIVECAPTION       3
#define COLOR_MENU                  4
#define COLOR_WINDOW                5
#define COLOR_WINDOWFRAME           6
#define COLOR_MENUTEXT              7
#define COLOR_WINDOWTEXT            8
#define COLOR_CAPTIONTEXT           9
#define COLOR_ACTIVEBORDER         10
#define COLOR_INACTIVEBORDER       11
#define COLOR_APPWORKSPACE         12
#define COLOR_HIGHLIGHT            13
#define COLOR_HIGHLIGHTTEXT        14
#define COLOR_BTNFACE              15
#define COLOR_BTNSHADOW            16
#define COLOR_GRAYTEXT             17
#define COLOR_BTNTEXT              18
#define COLOR_INACTIVECAPTIONTEXT  19
#define COLOR_BTNHIGHLIGHT         20
#if("4" $ OS())
#define COLOR_3DDKSHADOW           21
#define COLOR_3DLIGHT              22
#define COLOR_INFOTEXT             23
#define COLOR_INFOBK               24
#define COLOR_DESKTOP           COLOR_BACKGROUND
#define COLOR_3DFACE            COLOR_BTNFACE
#define COLOR_3DSHADOW          COLOR_BTNSHADOW
#define COLOR_3DHIGHLIGHT       COLOR_BTNHIGHLIGHT
#define COLOR_3DHILIGHT         COLOR_BTNHIGHLIGHT
#define COLOR_BTNHILIGHT        COLOR_BTNHIGHLIGHT
#endif

IF ISNULL(THIS.ThermForm)

  DECLARE INTEGER GetSysColor IN Win32API INTEGER  

  LOCAL liThermTop, liThermLeft, liThermWidth, liThermHeight, liSession
  IF TYPE("THIS.CommandClauses.StartDataSession") = "N"
     liSession = SET("DATASESSION")
     TRY
        SET DATASESSION TO (THIS.CommandClauses.StartDataSession)
     CATCH WHEN .T.
        THIS.resetDataSession()
     ENDTRY
  ENDIF

  THIS.ThermForm = CREATEOBJECT("FORM")
  
  
  WITH THIS.ThermForm
  
     .ScaleMode = SCALEMODE_PIXELS   
     .Height = THIS.ThermFormHeight
     .HalfHeightCaption = .T.
     .Width = THIS.ThermFormWidth
     .AutoCenter = .T.
     .BorderStyle = BORDER_DOUBLE  && fixed dialog
     .ControlBox = .F.
     .Closable = (NOT THIS.IsRunning)
     .MaxButton = .F.
     .MinButton = .F.
     .Movable = (NOT THIS.IsRunning)
     .AlwaysOnTop = .T.
     .AllowOutput = .F.
     .AddObject("ThermBack","shape")
     .AddObject("ThermLabel","label")
     .AddObject("ThermShape","shape")
     liThermHeight = .Height - (THIS.ThermMargin* 2)
     liThermWidth =  .Width - (THIS.ThermMargin*2)
  ENDWITH
  
  THIS.SetThermFormCaption()    
  
  liThermTop = THIS.ThermMargin
  liThermLeft = THIS.ThermMargin  

  WITH THIS.ThermForm.ThermBack
     .Top = liThermTop     
     .Left = liThermLeft
     .Height = liThermHeight
     .Width = liThermWidth
     .Visible = .T.
     .BorderStyle = BORDER_SINGLE
     .BackStyle = 0     
  ENDWITH
  
  WITH THIS.ThermForm.ThermLabel
     .Top = (.Parent.Height - .Height) /2
     .Autosize = .T.
     .BackStyle = FILLSTYLE_SOLID      
     .Caption = ""
     .Visible = .T.
     .ForeColor = GetSysColor( COLOR_MENUTEXT )
  ENDWITH
  
  WITH THIS.ThermForm.ThermShape
     .Top = liThermTop +1    
     .Left = liThermLeft+1
     .Height = liThermHeight -2
     .Width = 0
     .Visible = .T.
     .BorderStyle = BORDER_NONE
     .BackStyle = FILLSTYLE_SOLID         
     .FillStyle = FILLSTYLE_SOLID    
     .BackColor = .Parent.BackColor
     .FillColor = GetSysColor(COLOR_HIGHLIGHT)
     .DrawMode = DRAWMODE_MERGE_PEN_NOT 
  ENDWITH
  
  IF NOT EMPTY(liSession)
     SET DATASESSION TO (liSession)
  ENDIF
  
 
ENDIF

RETURN NOT ISNULL(THIS.ThermForm)
ENDPROC
PROCEDURE secondstext_assign
LPARAMETERS vNewVal
IF VARTYPE(vNewVal) = "C"
   THIS.SecondsText = m.vNewVal
ENDIF   

ENDPROC
PROCEDURE thermformcaption_assign
LPARAMETERS vNewVal
IF VARTYPE(vNewVal) = "C"
   THIS.ThermFormCaption = m.vNewVal
   THIS.SetThermFormCaption()
ENDIF   

ENDPROC
PROCEDURE thermformheight_assign
LPARAMETERS vNewVal
IF (NOT THIS.IsRunning) AND VARTYPE(vNewVal) = "N" AND ;
   BETWEEN(vNewVal,30,SYSMETRIC(SYSMETRIC_SCREENHEIGHT )-30)  AND ;
   INT(vNewVal) # THIS.ThermFormHeight
   THIS.thermformheight = INT(m.vNewVal)
   IF THIS.ThermMargin > THIS.ThermFormHeight/4
      THIS.ThermMargin = THIS.ThermFormHeight/4
   ENDIF   
   THIS.thermForm = NULL
ENDIF   

ENDPROC
PROCEDURE thermformwidth_assign
LPARAMETERS vNewVal
IF (NOT THIS.IsRunning) AND VARTYPE(vNewVal) = "N" AND ;
   BETWEEN(vNewVal,100,SYSMETRIC( SYSMETRIC_SCREENWIDTH  )-100) AND ;
   INT(vNewVal) # THIS.ThermFormWidth 
   THIS.thermformwidth = INT(m.vNewVal)
   IF THIS.ThermMargin > THIS.ThermFormWidth/4
      THIS.ThermMargin = THIS.ThermFormWidth/4
   ENDIF   
   THIS.ThermForm = NULL
ENDIF   

ENDPROC
PROCEDURE thermmargin_assign
LPARAMETERS vNewVal
IF (NOT THIS.IsRunning) AND VARTYPE(vNewVal) = "N" AND ;
   BETWEEN(vNewVal,1,MIN(THIS.ThermFormHeight/4,THIS.ThermFormWidth/4)) AND ;
   INT(vNewVal) # THIS.ThermMargin
   THIS.thermmargin = INT(m.vNewVal)
   THIS.thermForm = NULL
ENDIF   

ENDPROC
PROCEDURE includeseconds_assign
LPARAMETERS vNewVal
IF VARTYPE(vNewVal) = "L"
   THIS.includeseconds = m.vNewVal
ENDIF   

ENDPROC
PROCEDURE getparentwindowref
LOCAL loForm, loTopForm, lcInWindow

* first top form in the list
* will be the current top form.

ASSERT TYPE("_SCREEN.ActiveForm") # "O"  OR ;
       INLIST(_SCREEN.ActiveForm.ShowWindow, 0,1,2)

loTopForm = NULL

IF TYPE("THIS.CommandClauses.InWindow") = "C"
   lcInWindow = UPPER(ALLTRIM(THIS.CommandClauses.InWindow))
ENDIF   

IF EMPTY(lcInWindow) AND TYPE("THIS.CommandClauses.Window") = "C"
   lcInWindow = UPPER(ALLTRIM(THIS.CommandClauses.Window))
ENDIF   


IF NOT EMPTY(lcInWindow) 

     FOR EACH loForm IN _SCREEN.Forms  FOXOBJECT
        IF loForm.ShowWindow = 2  AND ;
           UPPER(loForm.Name) == lcInWindow
           loTopForm = loForm
           EXIT
        ENDIF
     ENDFOR
     
ENDIF

DO CASE

CASE VARTYPE(loTopForm) = "O"
    * already found
CASE _SCREEN.FormCount = 0 OR ;
     (TYPE("_SCREEN.ActiveForm") = "O" AND ;
     _SCREEN.ActiveForm.ShowWindow = 0 )     && ShowWindow In Screen
		     
     loTopForm = _SCREEN

CASE (TYPE("_SCREEN.ActiveForm") = "O" AND ;
      _SCREEN.ActiveForm.ShowWindow = 2 )    && ShowWindow As Top Form

     loTopForm = _SCREEN.ActiveForm
		     
OTHERWISE 
		                                       
     FOR EACH loForm IN _SCREEN.Forms  FOXOBJECT
        IF loForm.ShowWindow = 2 
           loTopForm = loForm
           EXIT
        ENDIF
     ENDFOR
		     
     IF VARTYPE(loTopForm) # "O"
        loTopForm = _SCREEN
     ENDIF
		          
ENDCASE

IF VARTYPE(loTopForm) # "O" OR ;
   EMPTY(loTopForm.Name)
   loTopForm = NULL
ENDIF

RETURN loTopForm     

ENDPROC
PROCEDURE setthermformcaption
IF NOT ISNULL(THIS.ThermForm)
   IF EMPTY(THIS.ThermFormCaption)
      
      IF TYPE("THIS.CommandClauses.File") = "C"
         LOCAL cName
         IF EMPTY(THIS.PrintJobName)
            cName = PROPER(JUSTFNAME(THIS.CommandClauses.File))
         ELSE
            cName = THIS.PrintJobName
         ENDIF   
         THIS.ThermForm.Caption = ;
            cName + ": " + OUTPUTCLASS_CANCEL_INSTRUCTIONS_LOC
      ELSE
         THIS.ThermForm.Caption = ""
      ENDIF
   ELSE   
      THIS.ThermForm.Caption = THIS.ThermFormCaption
   ENDIF
ENDIF   





ENDPROC
PROCEDURE thermcaption_assign
LPARAMETERS vNewVal
IF VARTYPE(vNewVal) = "C"
   LOCAL lcType, cMessage
   cMessage = ""
   TRY 
    lcType = VARTYPE(EVALUATE(vNewVal))
      IF lcType = "C"
        THIS.ThermCaption = m.vNewVal
    ENDIF
   CATCH 
   ENDTRY     
ENDIF   

ENDPROC
PROCEDURE initstatustext_assign
LPARAMETERS vNewVal
IF VARTYPE(m.vNewVal) = "C"
   THIS.InitStatusText = m.vNewVal
ENDIF   
ENDPROC
PROCEDURE prepassstatustext_assign
LPARAMETERS vNewVal
IF VARTYPE(m.vNewVal) = "C"
   THIS.PrepassStatusText = m.vNewVal
ENDIF   

ENDPROC
PROCEDURE runstatustext_assign
LPARAMETERS vNewVal
IF VARTYPE(m.vNewVal) = "C"
   THIS.RunStatusText = m.vNewVal
ENDIF   


ENDPROC
PROCEDURE resetuserfeedback
LPARAMETERS tlResetTimes
THIS.CurrentRecord = 0
THIS.PercentDone = 0
IF tlResetTimes
   THIS.ReportStartRunDateTime= DATETIME()
   THIS.ReportStopRunDateTime= DTOT({})
ENDIF   

ENDPROC
PROCEDURE getreportscopedriver
LOCAL liSelect, lcAlias, ;
      liSkips,  laSkips[1]

THIS.designatedDriver = THIS.drivingAlias
* used later if we have to cancel report as
* a Successor

THIS.setFRXDataSession()

IF USED("frx")

   liSelect = SELECT()

   SELECT FRX
   LOCATE FOR ObjType = FRX_OBJTYP_BAND AND ;
           Objcode = FRX_OBJCOD_DETAIL AND ;
           TYPE(Expr) = "C" AND ;
           UPPER(EVALUATE(ALLTRIM(Expr))) == UPPER(THIS.DrivingAlias)
   IF FOUND()
      SELECT (liSelect)
      * if the driver is also a target alias,
      * don't touch.
     * otherwise:
   ELSE 

      LOCATE FOR ObjType = FRX_OBJTYP_BAND AND ;
              Objcode = FRX_OBJCOD_DETAIL AND ;
              NOT EMPTY(Expr)
      IF FOUND()
         * use the first detail band, on the theory
         * that people are going to put pre-processing 
         * calculations before other bands, 
         * so an early band has the best chance to be
         * the right driver.
         THIS.drivingAlias = UPPER(EVALUATE(ALLTRIM(Expr)))

         SELECT (liSelect)

      ELSE   
   
         * adjust the driver based on any
         * one to many relationships we can find.
  
         SELECT (liSelect)
   
         THIS.setCurrentDataSession()

         lcAlias = THIS.drivingAlias

         liSelect = SELECT()

         DO WHILE NOT EMPTY(lcAlias)

            SELECT (lcAlias)
            liSkips = ALINES(laSkips,SET("SKIP"),",")
            IF liSkips = 0 OR EMPTY(laSkips[1])
               THIS.drivingAlias = lcAlias
               lcAlias = ""
            ELSE
               lcAlias = laSkips[1]
               * it doesn't really matter how many lines there
               * are in the array; this is not going to be perfect
               * but we can't predict which child 
               * has the most records.
            ENDIF
         ENDDO

         SELECT (liSelect)
   
      ENDIF   
    
   ENDIF  
ELSE
   RETURN .F.    
ENDIF
ENDPROC
PROCEDURE synchstatus
LPARAMETERS nBandObjCode, nFRXRecNo
IF THIS.isRunning AND (NOT THIS.hadError) AND ;
   THIS.frxBandRecno = nFRXRecNo
   THIS.setCurrentDataSession() 
   IF THIS.drivingAliasCurrentRecno  # RECNO(THIS.drivingAlias)
      THIS.currentRecord = THIS.CurrentRecord + 1
      THIS.drivingAliasCurrentRecno = RECNO(THIS.drivingAlias)
   ENDIF   
   IF THIS.currentRecord >= THIS.CommandClauses.RecordTotal
      IF THIS.CurrentPass = 0 AND THIS.TwoPassProcess
         THIS.resetUserFeedback() 
      ELSE
         THIS.currentRecord = THIS.CommandClauses.RecordTotal
      ENDIF
   ENDIF
   THIS.UpdateStatus()
   THIS.resetDataSession()
ENDIF  


ENDPROC
PROCEDURE setfrxrunstartupconditions
DODEFAULT()
IF TYPE("THIS.CommandClauses.Summary") # "L"
   ADDPROPERTY(THIS.CommandClauses,"Summary",.F.)
ENDIF   
IF TYPE("THIS.CommandClauses.RecordTotal") # "N"
   ADDPROPERTY(THIS.CommandClauses,"RecordTotal",0)
ENDIF   

ENDPROC
PROCEDURE BeforeBand
LPARAMETERS nBandObjCode, nFRXRecNo
DODEFAULT(nBandObjCode, nFRXRecNo)
IF THIS.successorSys2024 = "Y" AND ;
   THIS.CurrentPass = LISTENER_FULLPASS
   * user cancelled during the prepass,
   * we need to re-cancel.
   THIS.setCurrentDataSession()
   IF USED(THIS.designatedDriver)
      GO BOTTOM IN (THIS.designatedDriver)
   ENDIF   
ENDIF   

THIS.synchStatus(nBandObjCode,nFRXRecNo)
THIS.resetDataSession()
ENDPROC
PROCEDURE UnloadReport
IF THIS.IsRunning
   THIS.IsRunning = .F.
   THIS.PopGlobalSets()
ENDIF   

THIS.ReportStopRunDateTime = DATETIME()
THIS.ClearStatus() 
THIS.ThermForm = NULL  

DODEFAULT()

THIS.resetDataSession()

ENDPROC
PROCEDURE DoStatus
LPARAMETERS cMessage
LOCAL loParentForm, lcCaption, lcParentFormName
NODEFAULT

IF (NOT (THIS.QuietMode or ;
   (THIS.IsRunning AND THIS.CommandClauses.NoDialog)))

   IF EMPTY(cMessage) OR ISNULL(cMessage)
      cMessage = ""
   ENDIF

   lcCaption = EVALUATE(THIS.ThermCaption)
   IF ((NOT ISNULL(THIS.ThermForm)) OR (THIS.CreateTherm()) )

      WITH THIS.ThermForm
      
         IF THIS.IsRunning
            .Closable = .F.
            .Movable = .F.
         ENDIF
      
        .ThermShape.Width = MAX( (((THIS.PercentDone* .ThermBack.Width))-2) ,0)
        .ThermLabel.Caption = lcCaption
        .ThermLabel.Left = (.Width - .ThermLabel.Width) /2
      
        IF NOT .Visible
        
           loParentForm = THIS.GetParentWindowRef()
           
           DO CASE
           CASE VARTYPE(loParentForm) # "O" AND (NOT _SCREEN.Visible)
              lcParentFormName = "MACDESKTOP"
           CASE VARTYPE(loParentForm) # "O"
              lcParentFormName = "SCREEN"              
           CASE (NOT loParentForm.Visible) AND ;
              (loParentForm.DeskTop OR NOT EMPTY(loParentForm.MacDesktop) OR ;
              loParentForm.ShowWindow = 2 OR (NOT _SCREEN.Visible))
              * in many cases, 
              * they've probably made a programming error,
              * the parent should be visible according to
              * the requirements of REPORT FORM ... IN WINDOW
              * if it's a WINDOW clause they
              * have no need to show it, might not be an error
              * Either way, they should see the therm
              * to know that the report is progressing                
              lcParentFormName = "MACDESKTOP"
           CASE (NOT loParentForm.Visible) 
              * same comment as above
              lcParentFormName = "SCREEN"
           OTHERWISE
              lcParentFormName = loParentForm.Name
           ENDCASE
           
           SHOW WINDOW (.Name) IN WINDOW (lcParentFormName) 
           .AlwaysOnTop = .T.
           .AutoCenter = .T.
           .Visible = .T.
        
        ENDIF
      
      ENDWITH
   
   ENDIF
  
ENDIF   



ENDPROC
PROCEDURE ClearStatus
NODEFAULT
IF NOT ISNULL(THIS.ThermForm) 
   IF THIS.ThermForm.Visible
      THIS.ThermForm.Visible = .F.
   ENDIF
ENDIF

IF NOT ISNULL(THIS.Successor)
   THIS.Successor.ClearStatus()
ENDIF
ENDPROC
PROCEDURE BeforeReport
DODEFAULT()
* THIS.ResetUserFeedback(.T.)
THIS.DrivingAliasCurrentRecno = 0
THIS.IsRunning = .T.
THIS.resetDataSession()



ENDPROC
PROCEDURE Init
IF DODEFAULT() 
   THIS.InitStatusText = OUTPUTCLASS_INITSTATUS_LOC
   THIS.PrepassStatusText = OUTPUTCLASS_PREPSTATUS_LOC
   THIS.RunStatusText =  OUTPUTCLASS_RUNSTATUS_LOC
   THIS.SecondsText = OUTPUTCLASS_TIME_SECONDS_LOC
   THIS.thermCaption = OUTPUTCLASS_THERMCAPTION_LOC 
   RETURN (NOT THIS.HadError)
ELSE
   RETURN .F.
ENDIF
   
ENDPROC
PROCEDURE AfterReport
IF SYS(2024) # "Y" 
   IF THIS.IsRunning OR TYPE("THIS.CommandClauses.RecordTotal") = "N"
      THIS.CurrentRecord = THIS.CommandClauses.RecordTotal
   ENDIF   
   THIS.UpdateStatus() 
ENDIF
THIS.IsRunning = .F.
THIS.ClearStatus() 
THIS.designatedDriver = ""
THIS.successorSys2024 = "N"
THIS.ThermForm = NULL  
THIS.ReportStopRunDateTime = DATETIME()
THIS.PopGlobalSets()
DODEFAULT()



ENDPROC
PROCEDURE CancelReport
IF THIS.IsRunning AND ;
   (THIS.QuietMode OR ;
    (NOT THIS.AllowModalMessages) OR ;
    THIS.DoMessage(OUTPUTCLASS_REPORT_CANCELQUERY_LOC,;
                   MB_ICONQUESTION+MB_YESNO) =  IDYES )

   IF THIS.isSuccessor AND NOT EMPTY(THIS.designatedDriver)
      * make an exception for this Listener
      * to the rule that Successors don't 
      * handle cancelling the report, because
      * this guy's job is to handle user intervention:
      THIS.successorSys2024 = "Y"
      THIS.setCurrentDataSession()
      IF USED(THIS.designatedDriver)
         GO BOTTOM IN (THIS.designatedDriver)
      ENDIF   
      THIS.resetDataSession()
   ENDIF
      
   DODEFAULT() 
   IF SYS(2024) = "Y"  OR THIS.IsSuccessor
      THIS.ThermForm = NULL
      THIS.DoMessage(OUTPUTCLASS_REPORT_INCOMPLETE_LOC, ;
                     MB_ICONEXCLAMATION)
   ENDIF
ELSE
   NODEFAULT   
ENDIF

ENDPROC
PROCEDURE pushglobalsets
DODEFAULT()
IF (NOT INLIST(_VFP.StartMode,2,3,5))
   PUSH KEY CLEAR
   LOCAL lcRef
   SET MESSAGE TO ""
   THIS.SetNotifyCursor = (SET("Notify",2) = "ON")
   IF THIS.SetNotifyCursor
      SET NOTIFY CURSOR OFF
   ENDIF   
   THIS.OnEscapeCommand = ON("ESCAPE")   
   lcRef = SYS(2015)   
   PUBLIC &lcRef.   
   STORE THIS TO (lcRef)
   ON ESCAPE &lcRef..CancelReport()      
   THIS.EscapeReference = lcRef   
   THIS.SetEscape = (SET("ESCAPE")="OFF") 
   IF THIS.SetEscape
      SET ESCAPE ON
   ENDIF   
ENDIF   
   
   
ENDPROC
PROCEDURE popglobalsets
DODEFAULT()
IF (NOT INLIST(_VFP.StartMode,2,3,5))
   LOCAL lcRef
   lcRef = THIS.EscapeReference
   IF (NOT EMPTY(lcRef)) AND ;
       TYPE(lcRef) = "O"
      * push occurred earlier
      STORE NULL TO (lcRef)
      RELEASE &lcRef.
      THIS.escapeReference = ""
      lcRef = THIS.OnEscapeCommand
      ON ESCAPE &lcRef
      POP KEY
      IF THIS.SetNotifyCursor
         SET NOTIFY CURSOR ON
      ENDIF   
      IF THIS.SetEscape 
         SET ESCAPE OFF
      ENDIF   
   ENDIF   
ENDIF   
   
   
ENDPROC
PROCEDURE getfrxstartupinfo
DODEFAULT()

LOCAL llFRXAvailable

llFRXAvailable = THIS.getReportScopeDriver() 

IF llFRXAvailable
   THIS.SetFRXDataSession()
   THIS.FRXBandRecno = 0

   SELECT FRX
   
   IF THIS.CommandClauses.Summary
      * don't use groups unless
      * we're forced to by Summary.
      * Group usage will not work if
      * there's a group on .T. or some
      * other nonsensical expression that
      * doesn't change.
    
      LOCATE FOR ObjType = FRX_OBJTYP_BAND AND ;
          Objcode = FRX_OBJCOD_GROUPHEADER
      DO WHILE NOT EOF()
         * find the innermost group
         THIS.FRXBandRecno = RECNO()
         CONTINUE
      ENDDO        
      
      IF THIS.frxBandRecno = 0
         * no groups in a Summary report
         * doesn't make a lot of sense, but
         * can happen.
          LOCATE FOR ObjType = FRX_OBJTYP_BAND AND ;
             Objcode = FRX_OBJCOD_PAGEHEADER
          IF NOT EOF()
             THIS.FRXBandRecno = RECNO()
          ENDIF     
      ENDIF
   
   ENDIF
      
   IF THIS.FRXBandRecno = 0
      * not a Summary report.
      * look for the appropriate detail
      * using the report driver
      LOCATE FOR ObjType = FRX_OBJTYP_BAND AND ;
                 Objcode = FRX_OBJCOD_DETAIL AND ;
                 TYPE(Expr) = "C" AND ;
                 UPPER(EVALUATE(ALLTRIM(Expr))) == UPPER(THIS.DrivingAlias)
      DO WHILE NOT EOF()
         THIS.FRXBandRecno = RECNO()
         CONTINUE && try not to use the first detail band
      ENDDO
   
   ENDIF   
   
   IF THIS.frxBandRecno = 0
      * couldn't match up a band with
      * the known driver
      LOCATE FOR ObjType = FRX_OBJTYP_BAND AND ;
           Objcode = FRX_OBJCOD_DETAIL AND ;
           EMPTY(Expr)
      IF NOT EOF()
         THIS.FRXBandRecno = RECNO()      
      ELSE
         IF THIS.FRXBandRecno = 0 
            LOCATE FOR ObjType = FRX_OBJTYP_BAND AND ;
                 Objcode = FRX_OBJCOD_DETAIL
            IF NOT EOF()
               THIS.FRXBandRecno = RECNO()
            ENDIF  
         ENDIF               
      ENDIF        
   ENDIF   

ENDIF

THIS.setCurrentDataSession()

ENDPROC
PROCEDURE UpdateStatus
NODEFAULT
* the THIS.IsRunning check here
* make sure that this code doesn't
* run if the Engine calls UpdateStatus
* after we're through

IF THIS.IsRunning
   IF THIS.CommandClauses.RecordTotal  > 0
      THIS.PercentDone = (THIS.CurrentRecord/THIS.CommandClauses.RecordTotal)
 
      #IF OUTPUTCLASS_DEBUGGING 
          ? THIS.PercentDone, THIS.CurrentRecord, THIS.CommandClauses.RecordTotal, THIS.PageTotal
          ? REPL(OUTPUTCLASS_STATUSCHAR_PCT_DONE,INT(THIS.PercentDone* OUTPUTCLASS_ONE_HUNDRED_PCT_MARK))+ ;
            REPL(OUTPUTCLASS_STATUSCHAR_PCT_NOT_DONE,MAX(FLOOR(OUTPUTCLASS_ONE_HUNDRED_PCT_MARK - ;
                                                           (OUTPUTCLASS_ONE_HUNDRED_PCT_MARK *THIS.PercentDone)),0) ) 
       #ENDIF                

   ENDIF   
   THIS.DoStatus(;
             IIF(THIS.CurrentPass = LISTENER_PREPASS  AND THIS.TwoPassProcess,;
                 THIS.PrepassStatusText, ;
                 THIS.RunStatusText) )
ENDIF   




ENDPROC
PROCEDURE LoadReport
IF DODEFAULT()
   THIS.ResetUserFeedback(.T.)
   IF NOT (THIS.QuietMode OR ;
           (TYPE("THIS.CommandClauses.NoDialog") = "L" AND ;
           THIS.CommandClauses.NoDialog) )
      THIS.DoStatus(THIS.initStatusText) 
      * NB: a user can call LoadReport manually,
      * hence the need for a TYPE() check here.
   ENDIF   
   THIS.PushGlobalSets()
ELSE
   THIS.ClearStatus()
   RETURN .F.
ENDIF
ENDPROC
PROCEDURE AfterBand
LPARAMETERS nBandObjCode, nFRXRecNo
DODEFAULT(nBandObjCode, nFRXRecNo)
THIS.synchStatus(nBandObjCode,nFRXRecNo)
THIS.resetDataSession()

ENDPROC
PROCEDURE Destroy
STORE NULL TO THIS.thermForm 

DODEFAULT()
ENDPROC


************************************************************
OBJETO: xmllistener
************************************************************
*** PROPIEDADES ***
Height = 23
Width = 23
FRXDataSession = -1
xmlmode = 2
includebreaksindata = 0
pagenodes = (NULL)
currentband = (NULL)
currentdocument = (NULL)
currentpage = (NULL)
columnnodes = (NULL)
currentcolumn = (NULL)
idattribute = ("id")
idrefattribute = ("idref")
xsltprocessorrdl = (NULL)
xsltprocessoruser = (NULL)
datanodes = (NULL)
nopageeject = .F.
topattr = ("t")
leftattr = ("l")
heightattr = ("h")
widthattr = ("w")
contattr = ("c")
xsltparameters = (NULL)
includepage = .T.
targetfileext = ("XML")
_memberdata =     4159<VFPData><memberdata name="applyusertransform" type="property" display="applyUserTransform" favorites="True"/><memberdata name="applyusertransformtooutput" type="method" display="applyUserTransformToOutput"/><memberdata name="applyxslt" type="method" display="applyXslt" favorites="True"/><memberdata name="columnnodes" type="property" display="columnNodes"/><memberdata name="contattr" type="property" display="contAttr" favorites="True"/><memberdata name="currentband" type="property" display="currentBand"/><memberdata name="currentcolumn" type="property" display="currentColumn"/><memberdata name="includepage" type="property" display="includePage"/><memberdata name="currentdocument" type="property" display="currentDocument" favorites="True"/><memberdata name="currentpage" type="property" display="currentPage"/><memberdata name="datanodes" type="property" display="dataNodes"/><memberdata name="getdefaultuserxslt" type="method" display="getDefaultUserXslt"/><memberdata name="preparefrxcopy" type="method" display="prepareFrxCopy"/><memberdata name="removefrxcopy" type="method" display="removeFrxCopy"/><memberdata name="getpathedimageinfo" type="method" display="getPathedImageInfo"/><memberdata name="getpathforexternals" type="method" display="getPathForExternals" favorites="True"/><memberdata name="getrawformattinginfo" type="method" display="getRawFormattingInfo"/><memberdata name="getvfprdlcontents" type="method" display="getVFPRdlContents"/><memberdata name="getfrxlayoutobjectfieldlist" type="method" display="getFrxLayoutObjectFieldlist"/><memberdata name="heightattr" type="property" display="heightAttr" favorites="True"/><memberdata name="idattribute" type="property" display="idAttribute" favorites="True"/><memberdata name="idrefattribute" type="property" display="idrefAttribute" favorites="True"/><memberdata name="includebandswithnoobjects" type="property" display="includeBandsWithNoObjects" favorites="True"/><memberdata name="includebreaksindata" type="property" display="includeBreaksInData" favorites="True"/><memberdata name="includedatasourcesinvfprdl" type="property" display="includeDataSourcesInVfpRdl" favorites="True"/><memberdata name="includeformattinginlayoutobjects" type="property" display="includeFormattingInLayoutObjects" favorites="True"/><memberdata name="insertxmlconfigrecords" type="method" display="insertXmlConfigRecords"/><memberdata name="leftattr" type="property" display="leftAttr" favorites="True"/><memberdata name="loadprocessorobject" type="method" display="loadProcessorObject"/><memberdata name="nopageeject" type="property" display="noPageEject" favorites="True"/><memberdata name="pagenodes" type="property" display="pageNodes"/><memberdata name="resetdocument" type="method" display="resetDocument" favorites="True"/><memberdata name="resetreport" display="resetReport" type="method"/><memberdata name="setdomformattinginfo" type="method" display="setDOMFormattingInfo"/><memberdata name="setfrxdatasession" type="method" display="setFRXDataSession"/><memberdata name="synchxsltprocessoruser" type="method" display="synchXsltProcessorUser"/><memberdata name="topattr" type="property" display="topAttr" favorites="True"/><memberdata name="verifyattributenames" type="method" display="verifyAttributeNames"/><memberdata name="verifyncname" type="method" display="verifyNCName" favorites="True"/><memberdata name="verifynodenames" type="method" display="verifyNodeNames"/><memberdata name="widthattr" type="property" display="widthAttr" favorites="True"/><memberdata name="writeraw" type="method" display="writeRaw"/><memberdata name="xmlmode" type="property" display="xmlMode" favorites="True"/><memberdata name="xmlrawconv" type="method" display="xmlRawConv"/><memberdata name="xmlrawnode" type="method" display="xmlRawNode"/><memberdata name="xmlrawtag" type="method" display="xmlRawTag"/><memberdata name="xsltparameters" type="property" display="xsltParameters" favorites="True"/><memberdata name="xsltprocessorrdl" type="property" display="xsltProcessorRdl" favorites="True"/><memberdata name="xsltprocessoruser" type="property" display="xsltProcessorUser" favorites="True"/></VFPData>
Name = "xmllistener"

*** METODOS ***
PROCEDURE xmlrawtag
LPARAMETERS tcNode, tlOpen, tcID, tcIDRef, tvFormatting
LOCAL lcNode

IF ISNULL(tlOpen) OR tlOpen
   lcNode = "<" + tcNode 
   IF NOT EMPTY(tcID)
      lcNode = lcNode + " "+THIS.idAttribute+"='"+tcID+"'"
   ENDIF
   IF NOT EMPTY(tcIDRef)
      lcNode = lcNode + " "+THIS.idRefAttribute+"='"+tcIDRef+"'"
   ENDIF
   IF NOT EMPTY(tvFormatting)
      lcNode = lcNode + " " + tvFormatting
   ENDIF
   IF ISNULL(tlOpen)
      lcNode = lcNode +  "/"
   ENDIF
   lcNode = lcNode + ">"
ELSE
   lcNode = "</"+ tcNode + ">"   
ENDIF

RETURN lcNode
ENDPROC
PROCEDURE xmlrawnode
LPARAMETERS tcNode,tcValue, tvID, tvIDRef, tvFormatting
LOCAL lcValue, lcNode
IF PARAMETERS() < 2
   lcValue = ""
ELSE
   lcValue = THIS.XMLRawConv(tcValue)
ENDIF
IF EMPTY(lcValue) 
  lcNode = THIS.XMLRawTag(tcNode,NULL, tvID, tvIDRef, tvFormatting)
ELSE
  lcNode = THIS.XMLRawTag(tcNode, .T., tvID, tvIDRef, tvFormatting)+lcValue+THIS.XMLRawTag(tcNode)
ENDIF

RETURN lcNode
   
ENDPROC
PROCEDURE xmlrawconv
LPARAMETERS tcValue
LOCAL lcValue, liChar
* must have ampersand as the first STRTRAN()      
lcValue = STRTRAN(tcValue, '&', '&amp;' )      
lcValue = STRTRAN(lcValue, '<', '&lt;' )
lcValue = STRTRAN(lcValue, '>', '&gt;' )
lcValue = STRTRAN(lcValue, '"', '&quot;' )
lcValue = STRTRAN(lcValue, ['], '&apos;' )
lcValue = CHRTRAN(lcValue, CHR(0)+CHR(4), "  ")
RETURN lcValue
* TBD: make any adjustments 
* and, if needed, for different element types if needed

ENDPROC
PROCEDURE writeraw
LPARAMETERS tcContents

 FWRITE(THIS.TargetHandle, tcContents) 

ENDPROC
PROCEDURE includebreaksindata_assign
LPARAMETERS vNewVal
* Readonly during report run

IF VARTYPE(vNewVal) = "N" AND ;
   INLIST(vNewVal, ;
          OUTPUTXML_BREAKS_INDATA,;
          OUTPUTXML_BREAKS_NONE, ;
          OUTPUTXML_BREAKS_COLLECTION) AND ;
   NOT THIS.IsRunning 
   THIS.IncludeBreaksInData = m.vNewVal
ENDIF   

ENDPROC
PROCEDURE xmlmode_assign
LPARAMETERS vNewVal
* Readonly during report run
IF NOT THIS.IsRunning
   IF VARTYPE(vNewVal) = "N" AND ;
      INLIST(vNewVal,;
             OUTPUTXML_DATA_ONLY,;
             OUTPUTXML_RDL_ONLY, ;
             OUTPUTXML_DATA_RDL)
      THIS.xmlmode = m.vNewVal
   ENDIF
ENDIF   

ENDPROC
PROCEDURE resetreport
THIS.IncludePage = .T.
THIS.IsRunning = .F.
THIS.DataNodes = NULL
THIS.PageNodes = NULL
THIS.ColumnNodes = NULL
THIS.CurrentBand = NULL
THIS.CurrentPage = NULL
THIS.CurrentColumn = NULL
THIS.FRXCursor = NULL && have to force this,
                      && because FRXCursor can't be used
                      && between report runs -- it has
                      && no notion of switching datasessions
                      && and won't be able to "find" FRX in
                      && the next private session for the next run

THIS.ClearStatus()   


   

ENDPROC
PROCEDURE applyxslt
LPARAMETERS tvSource, tvProcessor, tvParamCollection

LOCAL loSource, loProcessor, lvReturn, llSuccess, liParam

lvReturn = ""

STORE NULL TO loSource, loProcessor

IF VARTYPE(tvSource) = "C" 

   * first param can be filename, string, or object
   * if filename or string, test existance
   * and try to load as a dom object
   DO CASE
   CASE FILE(tvSource)
      loSource = CREATEOBJECT(OUTPUTXML_DOMDOCUMENTOBJECT)
      loSource.Load(tvSource)
   CASE LEN(tvSource) > 0
      loSource = CREATEOBJECT(OUTPUTXML_DOMDOCUMENTOBJECT)
      loSource.LoadXML(tvSource)
   ENDCASE
  
   IF NOT ISNULL(loSource) AND ;
      LEN(loSource.XML) > 0 AND ;
      EMPTY(loSource.parseError.reason)
      llSuccess = .T.
   ELSE
      loSource = NULL
*      IF NOT ISNULL(loSource)
*         THIS.LastErrorMessage = loSource.parseError.reason
*      ENDIF   
   ENDIF
ELSE
   * if object, test nodetypestring availability
   * and then for document/tree shape.
   IF VARTYPE(tvSource) = "O"
      TRY 
         IF INLIST("|"+UPPER(tvSource.nodeTypeString)+"|", ;
                       "|DOCUMENT|","|ELEMENT|") && quick and dirty test for tree shape
            loSource = tvSource           
            llSuccess = .T.
         ENDIF
      ENDTRY
   ENDIF   

ENDIF

IF llSuccess 

   * for failed transformations, return source XML
   lvReturn = loSource.XML
   
   * as above
   * second param can be filename or object
 
   * if filename, as above
   *  if object, test for appropriate interface
   * figure out if it's a processor factory
   * or an instance (either dom or stylesheet)
   *  and error out if we can't figure it out
   llSuccess = .F.
   IF VARTYPE(tvProcessor) = "C"    
      loProcessor = THIS.LoadProcessorObject(tvProcessor)
      IF NOT ISNULL(loProcessor)
         loProcessor = loProcessor.createProcessor()      
      ENDIF
   ELSE
      IF VARTYPE(tvProcessor) = "O" 
         TRY
            IF VARTYPE(tvProcessor.styleSheet) = "O"
               loProcessor = tvProcessor
               * if the object was a processor object
               * get a stylesheet instance
               loProcessor = loProcessor.createProcessor()
            ENDIF   
         CATCH
            * just want to swallow the errors here because
            * of the primitive tests being used
         ENDTRY
      ENDIF
   ENDIF
  
   IF NOT ISNULL(loProcessor) 
      llSuccess = .T.
   ENDIF
ENDIF

IF llSuccess

   * param collection should be added to the 
   * instance at this point
   
   WITH loProcessor
      IF VARTYPE(tvParamCollection) = "O" AND ;
         UPPER(tvParamCollection.BaseClass) == "COLLECTION" AND ;
         tvParamCollection.Count > 0

         FOR liParam = 1 TO tvParamCollection.Count
            .AddParameter(tvParamCollection.GetKey(liParam), ;
                         tvParamCollection.Item(liParam))
         ENDFOR
      ENDIF   
      .input = loSource
      .transform()
      lvReturn = .output
   ENDWITH

ENDIF


RETURN lvReturn
ENDPROC
PROCEDURE currentdocument_assign
LPARAMETERS vNewVal
* TBD: evaluate for readonly status during the life of the report run
THIS.currentdocument = m.vNewVal

ENDPROC
PROCEDURE idattribute_assign
LPARAMETERS vNewVal
IF (NOT THIS.IsRunning) AND THIS.VerifyNCName(vNewVal)
   THIS.idattribute = m.vNewVal
ENDIF   

ENDPROC
PROCEDURE idrefattribute_assign
LPARAMETERS vNewVal
IF (NOT THIS.IsRunning) AND THIS.VerifyNCName(vNewVal)
   THIS.idrefattribute = m.vNewVal
ENDIF   

ENDPROC
PROCEDURE xsltprocessorrdl_assign
LPARAMETERS vNewVal
DO CASE
CASE VARTYPE(vNewVal) = "X"
   THIS.XSLTProcessorRDL = NULL
CASE VARTYPE(vNewVal) = "O" 
   TRY
     IF VARTYPE(vNewVal.stylesheet) = "O"
       THIS.XSLTProcessorRDL = m.vNewVal
     ENDIF
   CATCH 
   ENDTRY
CASE VARTYPE(vNewVal) = "C" 
   LOCAL loProcessor
   loProcessor = THIS.LoadProcessorObject(vNewVal)
   IF NOT ISNULL(loProcessor)
      THIS.XSLTProcessorRDL = loProcessor
   ENDIF
ENDCASE



ENDPROC
PROCEDURE xsltprocessoruser_assign
LPARAMETERS vNewVal
DO CASE
CASE VARTYPE(vNewVal) = "X"
   THIS.XSLTProcessorUser = NULL
CASE VARTYPE(vNewVal) = "O" 
   TRY
     IF VARTYPE(vNewVal.stylesheet) = "O"
       THIS.XSLTProcessorUser = m.vNewVal
     ENDIF
   CATCH 
   ENDTRY
CASE VARTYPE(vNewVal) = "C" 
   LOCAL loProcessor
   loProcessor = THIS.LoadProcessorObject(vNewVal)
   IF NOT ISNULL(loProcessor)
      THIS.XSLTProcessorUser = loProcessor
   ENDIF
ENDCASE



ENDPROC
PROCEDURE resetdocument
* Do *not* reset 
* page number/total
THIS.ResetReport()   
THIS.CloseTargetFile()
THIS.NoPageEject = .F.
IF THIS.HadError
   THIS.ResetToDefault("QuietMode")
ENDIF   
THIS.CurrentDocument = NULL




ENDPROC
PROCEDURE verifyncname
LPARAMETERS tcName

LOCAL llValid, liChar, lcChar

DO CASE 

CASE VARTYPE(tcName) # "C" OR EMPTY(tcName)
  * invalid
CASE LEFT(tcName,1) # "_" AND NOT ISALPHA(LEFT(tcName,1))
  * invalid
CASE LEFT(UPPER(tcName),3) = "XML"
  * invalid
OTHERWISE
  llValid = .T.  
  FOR liChar = 2 TO LEN(tcName)
     lcChar = SUBSTR(tcName,liChar,1)
     IF NOT (ISALPHA(lcChar) OR ;
             ISDIGIT(lcChar) OR ;
             INLIST(lcChar,".","-","_"))
        llValid = .F.
        EXIT
     ENDIF
  ENDFOR
ENDCASE

RETURN llValid 
ENDPROC
PROCEDURE includeformattinginlayoutobjects_assign
LPARAMETERS vNewVal
*TBD: evaluate whether
* it's okay to do this during a run?

IF VARTYPE(vNewVal) = "L"
   THIS.IncludeFormattingInLayoutObjects = m.vNewVal
ENDIF   

ENDPROC
PROCEDURE includebandswithnoobjects_assign
LPARAMETERS vNewVal
IF VARTYPE(vNewVal) = "L" AND NOT THIS.IsRunning 
   THIS.IncludeBandsWithNoObjects = m.vNewVal
ENDIF   

ENDPROC
PROCEDURE verifynodenames
IF NOT USED("Nodes")
   RETURN .F.
ENDIF
IF ISREADONLY("Nodes")
   RETURN .T.
ENDIF   
   
LOCAL liSelect, llSuccess
liSelect = SELECT()
llSuccess = .T.
SELECT Nodes
SCAN FOR BETWEEN(ObjType,OUTPUTXML_OBJTYPE_NODES,OUTPUTXML_OBJTYPE_NODES+99)
   IF NOT THIS.VerifyNCName(ObjValue)
      DELETE
      llSuccess = .F.
   ENDIF
ENDSCAN
                    
SELECT (liSelect)
RETURN llSuccess                    
ENDPROC
PROCEDURE verifyattributenames
* abstract
ENDPROC
PROCEDURE nopageeject_assign
LPARAMETERS vNewVal
IF VARTYPE(vNewVal) = "L" AND NOT THIS.IsRunning
   THIS.NoPageEject = m.vNewVal
ENDIF   

ENDPROC
PROCEDURE loadprocessorobject
LPARAMETERS tcVal

LOCAL loReturn
loReturn = NULL

IF VARTYPE(tcVal) = "C" AND NOT EMPTY(tcVal)
  LOCAL loProcessor, loStylesheet
  loProcessor  = CREATEOBJECT(OUTPUTXML_XSLT_PROCESSOROBJECT)
  loStyleSheet = CREATEOBJECT(OUTPUTXML_DOMFREETHREADED_DOCUMENTOBJECT)
  IF FILE(tcVal)
    loStyleSheet.Load(tcVal)
  ELSE
    * try to load it as a string
    loStyleSheet.LoadXML(tcVal)
  ENDIF
  IF LEN(loStyleSheet.XML) > 0 AND ;
     EMPTY(loStyleSheet.parseError.reason)
     loProcessor.styleSheet = loStyleSheet
     loReturn = loProcessor
*  ELSE     
*     THIS.LastErrorMessage = loSStyleSheet.parseError.reason
  ENDIF   
ENDIF

RETURN loReturn
ENDPROC
PROCEDURE getrawformattinginfo
LPARAMETERS tnLeft, tnTop, tnWidth, tnHeight, tnObjectContinuationType
LOCAL lcInfo

lcInfo = ""

lcInfo = lcInfo + " "+THIS.contAttr+"='"+TRANSFORM(tnObjectContinuationType)+"'"

IF THIS.IncludeFormattingInLayoutObjects
   lcInfo = lcInfo + " "+THIS.leftAttr+"='"+ TRANSFORM(tnLeft)+"'"
   lcInfo = lcInfo + " "+THIS.topAttr+"='"+TRANSFORM(tnTop)+"'"
   lcInfo = lcInfo + " "+THIS.widthAttr+"='"+TRANSFORM(tnWidth)+"'"      
   lcInfo = lcInfo + " "+THIS.heightAttr+"='"+TRANSFORM(tnHeight)+"'"     
ENDIF
RETURN lcInfo
ENDPROC
PROCEDURE topattr_assign
LPARAMETERS vNewVal
IF (NOT THIS.IsRunning) AND THIS.VerifyNCName(vNewVal)
   THIS.topAttr = m.vNewVal
ENDIF   

ENDPROC
PROCEDURE leftattr_assign
LPARAMETERS vNewVal
IF (NOT THIS.IsRunning) AND THIS.VerifyNCName(vNewVal)
   THIS.leftAttr = m.vNewVal
ENDIF   


ENDPROC
PROCEDURE heightattr_assign
LPARAMETERS vNewVal
IF (NOT THIS.IsRunning) AND THIS.VerifyNCName(vNewVal)
   THIS.heightAttr = m.vNewVal
ENDIF   



ENDPROC
PROCEDURE widthattr_assign
LPARAMETERS vNewVal
IF (NOT THIS.IsRunning) AND THIS.VerifyNCName(vNewVal)
   THIS.widthAttr = m.vNewVal
ENDIF   

ENDPROC
PROCEDURE contattr_assign
LPARAMETERS vNewVal
IF (NOT THIS.IsRunning) AND THIS.VerifyNCName(vNewVal)
   THIS.contAttr = m.vNewVal
ENDIF   



ENDPROC
PROCEDURE getvfprdlcontents
LPARAMETERS tcNodeName, tlAsString
* NB: no push/pop session here, don't bother
* because we're switching back and forth
* rapidly and not changing anything important
LOCAL liSelectCurrent, liSelectFRX, liSession, ;
      liFlds, liDBFS, liIndex1, liIndex2, laFlds[1], ;
      laDBFS[1], laRels[1], lcAlias, lcKey, llDesc, ;
      lcFilter, lcRel, liRels, lcSkip, lcResult, llWholePage
LOCAL oXA, oXT1, oXT2, oXT3, oXT4, oXT5, oXML, oNode, oCommand
liSession = SET("DATASESSION")
SET DATASESSION TO THIS.FRXDataSession
liSelectFRX = SELECT()
IF THIS.IncludeDataSourcesInVFPRDL
   CREATE CURSOR VFPDataSource (the_alias c(200), rpt_driver l, the_dbf m, the_order m, order_desc l, the_filter m, the_skip m )
   CREATE CURSOR flds (the_alias c(200), the_field m, the_type c(1))
   CREATE CURSOR rels (the_parent c(200), the_target c(200), the_expr m)
   SELECT flds
   INDEX ON the_alias TAG the_alias
   SELECT rels
   INDEX ON the_parent TAG the_alias
   SELECT VFPDataSource
   SET RELATION TO the_alias INTO flds, the_alias INTO rels
   SET DATASESSION TO THIS.CurrentDataSession
   liSelectCurrent = SELECT()
   liDBFS = AUSED(laDBFS) 
   FOR liIndex = 1 TO liDBFS
      SET DATASESSION TO THIS.CurrentDataSession
      lcAlias = laDBFs[liIndex,1]
      SELECT (lcAlias)
      lcDBF = DBF()
      liFlds = AFIELDS(laFlds)
      lcKey = SET("ORDER")
      llDesc =  (" DESC" $ UPPER(lcKey))   
      lcFilter = SET("FILTER")
      lcSkip = SET("SKIP")
      IF NOT EMPTY(lcKey)
         lcKey = STRTRAN(UPPER(lcKey),"TAG","")
         liIndex2 = ATC(" OF",lcKey)
         IF liIndex2 > 0
            lcKey = LEFT(lcKey,liIndex2)
         ENDIF
         lcKey = ALLTR(lcKey)
         liTag = TAGNO(lcKey)
         IF liTag > 0
            lcKey = KEY(liTag)
         ELSE
            lcKey = ""
         ENDIF
      ENDIF    
      liRels = 0
      STORE "" TO laRels
      DO WHILE .T.
         lcRel = RELATION(liRels + 1)
         IF EMPTY(lcRel)
            EXIT
         ELSE
            liRels = liRels + 1
            DIME laRels[liRels,3]
            laRels[liRels,1] = TARGET(liRels)
            laRels[liRels,2] = lcRel
         ENDIF
      ENDDO
      SET DATASESSION TO THIS.FRXDataSession
      INSERT INTO VFPDataSource VALUES (lcAlias, (UPPER(lcAlias)==UPPER(THIS.Drivingalias)), lcDBF, lcKey, llDesc, lcFilter, lcSkip)
      FOR liIndex2 = 1 TO liFlds
         INSERT INTO flds VALUES (lcAlias, laFlds[liIndex2,1], laFlds[liIndex2,2])
      ENDFOR
      FOR liIndex2 = 1 TO liRels
         INSERT INTO rels VALUES (lcAlias, laRels[liIndex2,1], laRels[liIndex2,2])   
      ENDFOR
   ENDFOR
   SET DATASESSION TO THIS.CurrentDataSession
   SELECT (liSelectCurrent)
ENDIF
SET DATASESSION TO THIS.FRXdataSession
lcAlias = THIS.prepareFrxCopy()
lcResult = THIS.getFRXLayoutObjectFieldList(lcAlias)
SELECT &lcResult ;
   FROM (lcAlias) ;
   LEFT JOIN Bands ON &lcAlias..UniqueID = Bands.UniqueID ;
   LEFT JOIN Objects ON &lcAlias..UniqueID = Objects.UniqueID ;
   WHERE NOT DELETED() ;
   INTO CURSOR VFPFRXLayoutObject READWRITE
THIS.removeFRXCopy(lcAlias)   
SELECT VFPFRXLayoutObject
* get rid of compiled data:
IF TYPE("VFPFRXLayoutObject.Tag") # "U"
   REPLACE Tag WITH "" ALL FOR NOT INLIST(ObjType,FRX_OBJTYP_VARIABLE,FRX_OBJTYP_BAND,FRX_OBJTYP_DATAENV ,FRX_OBJTYP_DATAOBJ)
ENDIF
IF TYPE("VFPFRXLayoutObject.Tag2") # "U"
   REPLACE Tag2 WITH "" ALL FOR INLIST(ObjType,FRX_OBJTYP_REPORTHEADER,FRX_OBJTYP_DATAENV,FRX_OBJTYP_DATAOBJ)
ENDIF
IF TYPE("VFPFRXLayoutObject.Fontface") # "U"
   REPLACE Fontface WITH ""  ALL FOR INLIST(ObjType,FRX_OBJTYP_DATAENV,FRX_OBJTYP_DATAOBJ)
ENDIF   
GO TOP IN VFPFRXLayoutObject
llWholePage = VFPFRXLayoutObject.Top 
SELECT Nodes.ObjValue AS Name, ;
       Nodes.ObjType-OUTPUTXML_OBJTYPE_NODES AS Type, ;
       Nodes.ObjCode AS Code, ;
       Nodes.ObjInfo AS Info ;
    FROM Nodes ;   
    WHERE BETWEEN(ObjType,OUTPUTXML_OBJTYPE_NODES, OUTPUTXML_OBJTYPE_NODES+100) ;
    AND NOT DELETED() ;
    INTO CURSOR VFPFRXLayoutNode READWRITE
liFlds = AMEMBERS(laFlds, THIS,0)
FOR liIndex1 = 1 TO liFlds
   IF ATC("attr",laFlds[liIndex1]) > 1
      INSERT INTO VFPFRXLayoutNode VALUES ;
        (TRANSFORM(EVALUATE("THIS."+laFlds[liIndex1])),;
         0, ;
         OUTPUTXML_OBJCODE_ATTRIBMEMBER,;
         laFlds[liIndex1]+ " attribute nodename")
   ENDIF
ENDFOR   
oXA=CREATEOBJECT("XMLAdapter")
oXA.RespectCursorCP = .T.
oXT4 = oXA.AddTableSchema("VFPFRXLayoutObject")
oXT5 = oXA.AddTableSchema("VFPFRXLayoutNode")
oXA.RespectNesting=.T.
IF THIS.IncludeDataSourcesInVFPRDL
   oXT1=oXA.AddTableSchema("VFPDataSource")
   oXT2=oXA.AddTableSchema("flds")
   oXT3=oXA.AddTableSchema("rels")
   oXT1.Nest(oXT2)
   oXT1.Nest(oXT3)
ENDIF

oXA.XMLSchemaLocation = ""
oXA.ToXML("lcResult")
#IF OUTPUTXML = OUTPUTXML_DOM
   oXML = CREATEOBJECT(OUTPUTXML_DOMFREETHREADED_DOCUMENTOBJECT)
#ELSE
   oXML = CREATEOBJECT("Microsoft.XMLDOM")
#ENDIF      
oXML.LoadXML(lcResult)
oNode = oXML.SelectSingleNode("/./*")
IF NOT ISNULL(THIS.CommandClauses)
   oCommand = oXML.createElement("VFPFRXCommand")
   liFlds = AMEMBERS(laFlds, THIS.CommandClauses)   
   FOR liIndex1 = 1 TO liFlds
       lcKey = EVAL("THIS.CommandClauses."+laFlds[liIndex1]) 
       IF VARTYPE(lcKey) = "L"
          IF lcKey
             lcKey = "true"
          ELSE
             lcKey = "false"
          ENDIF
       ENDIF
       oCommand.SetAttribute(laFlds[liIndex1], TRANSFORM(lcKey))
   ENDFOR
   oCommand.SetAttribute("OutputType",TRANSFORM(THIS.OutputType))
   oCommand.SetAttribute("appName",THIS.appName)
   oCommand.SetAttribute("targetFileName",THIS.targetFileName)
   oNode.appendChild(oCommand)
ENDIF   
oCommand =  oXML.createElement("VFPFRXPrintJob")
oCommand.SetAttribute("pagewidth", THIS.SharedPageWidth)
oCommand.SetAttribute("pageheight", THIS.SharedPageHeight)
oCommand.SetAttribute("name",THIS.PrintJobName)
oCommand.SetAttribute("pagedesign",IIF(llWholePage,"whole","printable"))
TRY
   * if PROMPT was used this will probably work
   oCommand.SetAttribute("printresolution",TRANSFORM(PRTINFO(PRT_YRESOLUTION ,SET("PRINTER",3))))
   #IF .F. 
      * OUTPUTXML_RESOLUTIONFIX
      * try to reset based on current printer FRX information
      GO TOP IN FRX
      SELECT FRX
      liIndex = IIF(ALINES(laFlds,Picture,.T.) > 0, ASCAN(laFlds,"YRESOLUTION"),0) 
      IF liIndex = 0
         liIndex = IIF(ALINES(laFlds,Expr,.T.) > 0, ASCAN(laFlds,"YRESOLUTION"),0) 
      ENDIF
      IF liIndex > 0
         liIndex = VAL(ALLTRIM(SUBSTR(laFlds[liIndex],AT("=",laFlds[liIndex])+1)))
         IF liIndex > 0
            oCommand.SetAttribute("printresolution",TRANSFORM(liIndex))         
         ELSE
            oCommand.SetAttribute("printresolution","-1")                  
         ENDIF
      ENDIF
      IF USED("SetPrinter")
         USE IN SetPrinter
      ENDIF
   #ENDIF    
CATCH WHEN .T.
   * this can happen when there is no printer
   oCommand.SetAttribute("printresolution","-1") 
ENDTRY   
oNode.appendChild(oCommand)
IF THIS.IncludeDataSourcesInVFPRDL
   USE IN VFPDataSource
   USE IN flds
   USE IN rels
ENDIF   
USE IN VFPFRXLayoutObject
USE IN VFPFRXLayoutNode
STORE NULL TO oXA, oXT1, oXT2, oXT3, oXT4, oXT5, oXML, oCommand
SELECT (liSelectFRX)
SET DATASESSION TO (liSession)
IF tlAsString
   RETURN oNode.XML
ELSE
   RETURN oNode
ENDIF
ENDPROC
PROCEDURE includedatasourcesinvfprdl_assign
LPARAMETERS vNewVal

IF VARTYPE(vNewVal) = "L" 
   THIS.IncludeDataSourcesinVFPRDL = m.vNewVal
ENDIF   

ENDPROC
PROCEDURE getpathedimageinfo
LPARAMETERS tObjType, tName, tPicture, tOffset, tPathed
LOCAL lcReturn, lcFile
lcReturn = ""
IF tObjType =  FRX_OBJTYP_PICTURE  
   DO CASE
   CASE tOffset = 0 && literal filename
      lcReturn = STRTRAN(tPicture,["],[])
      IF tPathed
         lcReturn = FULLPATH(tPicture,THIS.CommandClauses.File)      
      ELSE
         lcReturn = JUSTFNAME(tPicture)
      ENDIF
   CASE tOffset = 1 && general field
      lcReturn = "["+tName+"]"
   CASE tOffset = 2 AND TYPE(tName)= "O" && imagecontrol
      lcReturn = "["+tName+"]"   
   CASE tOffset = 2 AND TYPE(tName) = "C" && expression
      lcFile = EVALUATE(tName)
      IF NOT FILE(lcFile)
         lcFile = EVALUATE(STRTRAN(tName,"()","")) && indirect
      ENDIF
      IF FILE(lcFile)
         IF tPathed
            lcReturn = FULLPATH(EVALUATE(tName))
         ELSE
            lcReturn = JUSTFNAME(EVALUATE(tName))
         ENDIF
      ELSE
         lcReturn =  "["+tName+"]" 
      ENDIF
   OTHERWISE
      lcReturn = "["+tName+"]"
   ENDCASE
ENDIF
lcReturn = PADR(CHRTRAN(lcReturn,"\","/"), OUTPUTXML_CHARFIELD_LIMIT)

RETURN lcReturn


ENDPROC
PROCEDURE applyusertransformtooutput
DO CASE
CASE THIS.ApplyUserTransform AND NOT ;
   (ISNULL(THIS.XSLTProcessorUser))

   LOCAL lcResult

   *  THIS.SaveTargetFileName is real
   * THIS.TargetFileName is TMP
   lcResult = THIS.ApplyXSLT(FILETOSTR(THIS.TargetFileName),THIS.XSLTProcessorUser, THIS.XSLTParameters)
   IF FILE(THIS.SaveTargetFileName)
      ERASE (THIS.SaveTargetFileName) NORECYCLE
   ENDIF
   STRTOFILE(lcResult,THIS.SaveTargetFileName)
   ERASE (THIS.TargetFileName) NORECYCLE
   THIS.TargetFileName = THIS.SaveTargetFileName
   RETURN .T.
CASE THIS.ApplyUserTransform && no processor
   IF FILE(THIS.SaveTargetFileName)
      ERASE (THIS.SaveTargetFileName) NORECYCLE
   ENDIF
   COPY FILE (THIS.TargetFileName) TO (THIS.SaveTargetFileName)
   ERASE (THIS.TargetFileName) NORECYCLE
   THIS.TargetFileName = THIS.SaveTargetFileName
   RETURN .F.  
OTHERWISE
   RETURN .F. 
ENDCASE



ENDPROC
PROCEDURE applyusertransform_assign
LPARAMETERS vNewVal
IF VARTYPE(vNewVal) = "L" AND NOT THIS.IsRunning
   THIS.ApplyUserTransform = m.vNewVal
   IF THIS.ApplyUserTransform AND ;
      (ISNULL(THIS.XSLTProcessorUser))
      THIS.GetDefaultUserXSLT()
   ENDIF   
ENDIF   

ENDPROC
PROCEDURE getdefaultuserxslt
** this is an abstract method for use by subclasses
ENDPROC
PROCEDURE setdomformattinginfo
LPARAMETERS toNode, tnLeft, tnTop, tnWidth,tnHeight, tnObjectContinuationType

toNode.SetAttribute(THIS.ContAttr,TRANSFORM(tnObjectContinuationType))                  
IF THIS.IncludeFormattingInLayoutObjects
   toNode.SetAttribute(THIS.LeftAttr,TRANSFORM(tnLeft))
   toNode.SetAttribute(THIS.TopAttr,TRANSFORM(tnTop))
   toNode.SetAttribute(THIS.WidthAttr,TRANSFORM(tnWidth))             
   toNode.SetAttribute(THIS.HeightAttr,TRANSFORM(tnHeight))
ENDIF

ENDPROC
PROCEDURE synchxsltprocessoruser
IF THIS.ApplyUserTransform AND NOT ISNULL(THIS.XSLTProcessorUser)
   THIS.XSLTProcessorUser = NULL
   THIS.ApplyUserTransform = .T. && kickstart
ENDIF 
ENDPROC
PROCEDURE insertxmlconfigrecords
* protected,
* assumes it is being called with config
* table already SELECTed.

   DELETE FOR ;
      BETWEEN(OBJTYPE,OUTPUTXML_OBJTYPE_NODES, OUTPUTXML_OBJTYPE_NODES + 100)

   INSERT INTO (ALIAS()) VALUES ;
    (OUTPUTXML_OBJTYPE_NODES+ FRX_OBJTYP_BAND, ;
      FRX_OBJCOD_TITLE,'','Title','Title Band nodename')
   INSERT INTO (ALIAS()) VALUES ;
    (OUTPUTXML_OBJTYPE_NODES+ FRX_OBJTYP_BAND,;
      FRX_OBJCOD_PAGEHEADER,'','PH','Page Header Band nodename')
   INSERT INTO (ALIAS()) VALUES ;
    (OUTPUTXML_OBJTYPE_NODES+ FRX_OBJTYP_BAND,;
      FRX_OBJCOD_COLHEADER,'','CH','Column Header Band nodename')
   INSERT INTO (ALIAS()) VALUES ;
    (OUTPUTXML_OBJTYPE_NODES+ FRX_OBJTYP_BAND,;
      FRX_OBJCOD_GROUPHEADER,'','GH','Group Header Band nodename')
   INSERT INTO (ALIAS()) VALUES ;
    (OUTPUTXML_OBJTYPE_NODES+ FRX_OBJTYP_BAND, ;
      FRX_OBJCOD_DETAIL,'','D','Detail Band nodename')
   INSERT INTO (ALIAS()) VALUES ;
    (OUTPUTXML_OBJTYPE_NODES+FRX_OBJTYP_BAND, ;
      FRX_OBJCOD_GROUPFOOTER,'','GF','Group Footer Band nodename')
   INSERT INTO (ALIAS()) VALUES ;
    (OUTPUTXML_OBJTYPE_NODES+ FRX_OBJTYP_BAND, ;
      FRX_OBJCOD_COLFOOTER,'','CF','Column Footer Band nodename')
   INSERT INTO (ALIAS()) VALUES ;
    (OUTPUTXML_OBJTYPE_NODES+ FRX_OBJTYP_BAND, ;
      FRX_OBJCOD_PAGEFOOTER,'','PF','Page Footer Band nodename')
   INSERT INTO (ALIAS()) VALUES ;
    (OUTPUTXML_OBJTYPE_NODES+ FRX_OBJTYP_BAND, ;
      FRX_OBJCOD_SUMMARY,'','Summary','Summary Band nodename')
   INSERT INTO (ALIAS()) VALUES ;
    (OUTPUTXML_OBJTYPE_NODES+ FRX_OBJTYP_BAND, ;
      FRX_OBJCOD_DETAILHEADER,'','DH','Detail Header Band nodename')
   INSERT INTO (ALIAS()) VALUES ;
    (OUTPUTXML_OBJTYPE_NODES+ FRX_OBJTYP_BAND, ;
      FRX_OBJCOD_DETAILFOOTER,'','DF','Detail Footer Band nodename')
   INSERT INTO (ALIAS()) VALUES ;
    (OUTPUTXML_OBJTYPE_NODES+ FRX_OBJTYP_REPORTHEADER,;
      FRX_OBJCOD_REPORTHEADER ,'','VFP-Report','Report root nodename')
   INSERT INTO (ALIAS()) VALUES ;
    (OUTPUTXML_OBJTYPE_NODES+ FRX_OBJTYP_LABEL, ;
      FRX_OBJCOD_OTHER,'','T','Text object nodename')
   INSERT INTO (ALIAS()) VALUES ;
    (OUTPUTXML_OBJTYPE_NODES+ FRX_OBJTYP_FIELD, ;
      FRX_OBJCOD_OTHER,'','E','Expression object nodename')
   INSERT INTO (ALIAS()) VALUES ;
    (OUTPUTXML_OBJTYPE_NODES+ FRX_OBJTYP_PICTURE,;
      FRX_OBJCOD_OTHER,'','P','Picture object nodename')
   INSERT INTO (ALIAS()) VALUES ;
    (OUTPUTXML_OBJTYPE_NODES+ FRX_OBJTYP_RECTANGLE,;
      FRX_OBJCOD_RECTANGLE,'','S','Shape object nodename')
   INSERT INTO (ALIAS()) VALUES ;
    (OUTPUTXML_OBJTYPE_NODES+ FRX_OBJTYP_LINE, ;
      FRX_OBJCOD_OTHER,'','L','Line object nodename')
   INSERT INTO (ALIAS()) VALUES ;
    (OUTPUTXML_OBJTYPE_NODES+ FRX_OBJTYP_VARIABLE,;
      FRX_OBJCOD_OTHER,'','V','Variable nodename')
   INSERT INTO (ALIAS()) VALUES ;
    (OUTPUTXML_OBJTYPE_NODES+ FRX_OBJTYP_FONTRES,;
      FRX_OBJCOD_OTHER,'','FontRes','FontResource nodename')
   INSERT INTO (ALIAS()) VALUES ;
    (OUTPUTXML_OBJTYPE_NODES+ FRX_OBJTYP_DATAENV,;
      FRX_OBJCOD_OTHER,'','DataEnv','DataEnvironment nodename')
   INSERT INTO (ALIAS()) VALUES ;
    (OUTPUTXML_OBJTYPE_NODES+ FRX_OBJTYP_DATAOBJ,;
      FRX_OBJCOD_OTHER,'','DE-Cursor','DE-Cursor nodename')
   INSERT INTO (ALIAS()) VALUES ;
    (OUTPUTXML_OBJTYPE_NODES+ FRX_OBJTYP_DATAOBJ, ;
      FRX_OBJCOD_OTHER+1,'','DE-Relation','DE-Relation nodename')
     * offset the DE Relation because
     * this information isn't in ObjType or ObjCode
     * as distinct from DE-Cursor other than in the Name field
   INSERT INTO (ALIAS()) VALUES ;
    (OUTPUTXML_OBJTYPE_NODES+ FRX_OBJTYP_GROUP, ;
      FRX_OBJCOD_OTHER,'','Group','Group selector nodename')
   INSERT INTO (ALIAS()) VALUES ;
    (OUTPUTXML_OBJTYPE_NODES, ;
     OUTPUTXML_OBJCODE_DOC,'','Reports','XML Document root nodename')
   INSERT INTO (ALIAS()) VALUES ;
    (OUTPUTXML_OBJTYPE_NODES,;
     OUTPUTXML_OBJCODE_DATA,'','Data','Report scope data root nodename')
   INSERT INTO (ALIAS()) VALUES ;
    (OUTPUTXML_OBJTYPE_NODES, ;
     OUTPUTXML_OBJCODE_RDL,'','VFP-RDL','RDL layout description root nodename')
   INSERT INTO (ALIAS()) VALUES ;
    (OUTPUTXML_OBJTYPE_NODES, ;
     OUTPUTXML_OBJCODE_PAGES,'','Pages','Pages collection root nodename')
   INSERT INTO (ALIAS()) VALUES ;
    (OUTPUTXML_OBJTYPE_NODES, ;
     OUTPUTXML_OBJCODE_COLS,'','Columns','Column collection root nodename')

ENDPROC
PROCEDURE xsltparameters_assign
LPARAMETERS vNewVal
DO CASE
CASE VARTYPE(vNewVal) = "X"
  THIS.XSLTParameters= NULL
CASE VARTYPE(vNewVal) = "O" 
   TRY
     IF UPPER(vNewVal.BaseClass) == "COLLECTION" 
       THIS.XSLTParameters = m.vNewVal
     ENDIF
   CATCH 
   ENDTRY
OTHERWISE
  *
ENDCASE






ENDPROC
PROCEDURE getfrxlayoutobjectfieldlist
LPARAMETERS tcAlias
* frx
* PLATFORM,UNIQUEID,TIMESTAMP,OBJTYPE,OBJCODE,NAME,EXPR,VPOS,HPOS,HEIGHT,WIDTH,STYLE,
* PICTURE,ORDER,UNIQUE,COMMENT,ENVIRON,BOXCHAR,FILLCHAR,TAG,TAG2,PENRED,PENGREEN,PENBLUE,
* FILLRED,FILLGREEN,FILLBLUE,PENSIZE,PENPAT,FILLPAT,FONTFACE,FONTSTYLE,FONTSIZE,MODE,RULER,
* RULERLINES,GRID,GRIDV,GRIDH,FLOAT,STRETCH,STRETCHTOP,TOP,BOTTOM,SUPTYPE,SUPREST,NOREPEAT,RESETRPT,PAGEBREAK,COLBREAK,RESETPAGE,GENERAL,SPACING,DOUBLE,SWAPHEADER,SWAPFOOTER,EJECTBEFOR,EJECTAFTER,PLAIN,SUMMARY,ADDALIAS,OFFSET,TOPMARGIN,BOTMARGIN,TOTALTYPE,RESETTOTAL,RESOID,CURPOS,SUPALWAYS,SUPOVFLOW,SUPRPCOL,SUPGROUP,SUPVALCHNG,SUPEXPR,USER
* objects
* UNIQUEID,OBJTYPE,OBJCODE,EXPR,VPOS,HPOS,HEIGHT,WIDTH,OBJNAME,LOCALE_ID,START_BAND_ID,BAND_OFFSET,END_BAND_ID,BANDLABEL,SELECTED,OBJ_PICT,BAND_SEQ
* bands
* UNIQUEID,OBJTYPE,OBJCODE,EXPR,BANDLABEL,START,STOP,HEIGHT,P_START,P_STOP,P_HEIGHT,RESETTOTAL,BAND_SEQ,REL_BAND_ID



RETURN ;
       "RECNO() AS FrxRecno, "+tcAlias+".PLATFORM, "+tcAlias+".NAME,"+tcAlias+".EXPR,"+tcAlias+".OFFSET,"+tcAlias+".VPOS,"+tcAlias+".HPOS,"+tcAlias+".HEIGHT,"+;
       ""+tcAlias+".OBJTYPE, "+tcAlias+".TAG, "+tcAlias+".TAG2,"+tcAlias+".PENSIZE,"+tcAlias+".PENPAT,"+tcAlias+".FILLPAT,"+;
       ""+tcAlias+".WIDTH,"+tcAlias+".STYLE,"+tcAlias+".PICTURE,"+tcAlias+".ORDER,"+tcAlias+".COMMENT,"+tcAlias+".FILLCHAR,"+;       
       ""+tcAlias+".PENRED,"+tcAlias+".PENGREEN,"+tcAlias+".PENBLUE,"+tcAlias+".FILLRED,"+tcAlias+".FILLGREEN,"+tcAlias+".FILLBLUE,"+;
       ""+tcAlias+".FONTFACE, "+tcAlias+".FONTSTYLE,"+tcAlias+".FONTSIZE,"+tcAlias+".MODE,"+tcAlias+".FLOAT,"+tcAlias+".STRETCH,"+tcAlias+".STRETCHTOP,"+; 
       "BITTEST( "+tcAlias+".FONTSTYLE, 0 ) AS FontBold,"+ ;
       "BITTEST( "+tcAlias+".FONTSTYLE, 1 ) AS FontItalic,"+ ;
       "BITTEST( "+tcAlias+".FONTSTYLE, 3 ) AS FontUnderline,"+ ;
       "BITTEST( "+tcAlias+".FONTSTYLE, 7 ) AS FontStrikeThrough,"+ ;
       "THIS.GetPathedImageInfo("+tcAlias+".ObjType, "+tcAlias+".Name, "+tcAlias+".Picture, "+tcAlias+".Offset) AS UnpathedImg,"+ ;       
       "THIS.GetPathedImageInfo("+tcAlias+".ObjType, "+tcAlias+".Name, "+tcAlias+".Picture, "+tcAlias+".Offset, .T.) AS PathedImg,"+ ;
       ""+tcAlias+".TOP,"+tcAlias+".BOTTOM,"+tcAlias+".NOREPEAT,"+tcAlias+".PAGEBREAK,"+tcAlias+".COLBREAK,"+tcAlias+".RESETPAGE,"+tcAlias+".GENERAL,"+tcAlias+".SPACING,"+ ;
       ""+tcAlias+".SWAPHEADER,"+tcAlias+".SWAPFOOTER,"+tcAlias+".EJECTBEFOR,"+tcAlias+".EJECTAFTER,"+tcAlias+".TOTALTYPE,"+tcAlias+".RESETTOTAL,"+ ;
       "IIF("+tcAlias+".DOUBLE,"+tcAlias+".RESOID,1) AS FONTCHARSET,"+tcAlias+".SUPALWAYS,"+tcAlias+".SUPOVFLOW,"+tcAlias+".SUPRPCOL,"+tcAlias+".SUPGROUP,"+tcAlias+".SUPVALCHNG,"+tcAlias+".SUPEXPR,"+tcAlias+".USER,"+ ;
       "OBJECTS.UniqueID AS ObjID, OBJECTS.ObjName, Objects.Locale_ID,"+ ;
       "OBJECTS.START_BAND_ID,OBJECTS.BAND_OFFSET,OBJECTS.END_BAND_ID,"+ ;
       "BANDS.UNIQUEID AS BandID,BANDS.OBJCODE AS BandType,Bands.BANDLABEL,Bands.START,"+;
       "Bands.STOP,Bands.BAND_SEQ,Bands.REL_BAND_ID, ("+tcAlias+".ObjType=9 AND (NOT "+tcAlias+".Plain)) AS BandStretch"
ENDPROC
PROCEDURE preparefrxcopy
LOCAL lcAlias, lcFile
lcAlias = "FRX"
IF EMPTY(SYS(2000,THIS.CommandClauses.File)) AND ;
   USED("FRX")
   lcFile = FORCEEXT(FORCEPATH("F"+SYS(2015), JUSTPATH(THIS.targetFileName)),"FRX")
   SELECT 0
   CREATE CURSOR x (onefield l)
   CREATE REPORT (lcFile) FROM (DBF("x"))
   USE IN x
   SELECT 0
   USE (lcFile) EXCLUSIVE ALIAS (JUSTSTEM(lcFile))
   lcAlias = ALIAS()
   ZAP
   SELECT FRX
   SCAN
     SCATTER MEMVAR MEMO
     INSERT INTO (lcAlias) FROM MEMVAR
   ENDSCAN
ENDIF
RETURN lcAlias
ENDPROC
PROCEDURE removefrxcopy
LPARAMETERS tcAlias
LOCAL lcFile
IF tcAlias # "FRX"
   lcFile = DBF(tcAlias)
   USE IN (tcAlias)
   ERASE (lcFile)
   ERASE (FORCEEXT(lcFile,"FRT"))   
ENDIF      

ENDPROC
PROCEDURE setfrxrunstartupconditions
DODEFAULT()
IF TYPE("THIS.CommandClauses.File") # "C"
   ADDPROPERTY(THIS.CommandClauses,"File","")
ENDIF      
IF TYPE("THIS.CommandClauses.NoPageEject") # "L"
   ADDPROPERTY(THIS.CommandClauses,"NoPageEject",.F.)
ENDIF      

ENDPROC
PROCEDURE targetfileext_assign
LPARAMETERS vNewVal
IF VARTYPE(vNewVal) = "C" AND ;
   NOT UPPER(ALLTRIM(STRTRAN(vNewVal,".",""))) == "TMP"
   DODEFAULT(vNewVal)
   * this class reserves the extension
   * TMP for swapping in and out when 
   * using temporary files and XLSTs transforms
ENDIF   
ENDPROC
PROCEDURE frxcursor_access
DODEFAULT()
IF (NOT THIS.IsRunning) AND ;
    ISNULL(THIS.FRXCursor) AND THIS.LoadFRXCursor
    * don't attempt to load later
    THIS.LoadFRXCursor = .F.               
ENDIF
RETURN THIS.FRXCursor    
ENDPROC
PROCEDURE verifyconfigtable
LPARAMETERS tcAlias

LOCAL llReturn, laRequired[1], liIndex, liSelect, liTag, lcTag, lcIndex

llReturn = DODEFAULT(tcAlias)

IF llReturn
   * check for required tagnames (used in SEEKs)
   
   liSelect = SELECT()
   SELECT (tcAlias)
   
   DIME laRequired[2,2]
   laRequired[1,1] = "OBJTYPE"
   laRequired[1,2] = "OBJTYPE"
   laRequired[2,1] = "FRXNODES"
   laRequired[2,2] = NORMALIZE("OBJTYPE+OBJCODE+IIF(OBJTYPE="+ ;
                      TRANSFORM(FRX_OBJTYP_BAND+OUTPUTXML_OBJTYPE_NODES)+"," + ;
                      TRANSFORM(OUTPUTXML_OBJTYPE_BANDOFFSET)+",0)")
   
   FOR liIndex = 1 TO ALEN(laRequired,1)
       liTag = TAGNO(laRequired[liIndex,1])
       IF liTag = 0 OR NOT NORMALIZE(KEY(liTag)) == ;
          laRequired[liIndex,2]
          llReturn = .F.
       ENDIF
   ENDFOR
   
   IF NOT llReturn
   
      TRY
         USE (DBF(tcAlias)) EXCLU ALIAS (tcAlias)
         FOR liIndex = 1 TO ALEN(laRequired,1)
            lcTag = laRequired[liIndex,1]
            lcIndex = laRequired[liIndex,2]
            INDEX ON &lcIndex TAG &lcTag
         ENDFOR
      
         llReturn = .T.
      CATCH
      ENDTRY   
      
      
      IF llReturn
         FOR liIndex = 1 TO ALEN(laRequired,1)
             liTag = TAGNO(laRequired[liIndex,1])
             IF liTag = 0 OR NOT NORMALIZE(KEY(liTag)) == ;
                laRequired[liIndex,2]
                llReturn = .F.
             ENDIF
         ENDFOR
      ENDIF
      
      USE (DBF(tcAlias)) SHARED ALIAS (tcAlias)
 
   
   ENDIF
  
   IF NOT llReturn
      lcMessage =  OUTPUTXML_CONFIGTAGMISSING_LOC + CHR(13) 
      FOR liIndex = 1 TO ALEN(laRequired,1)
          lcMessage = lcMessage + ;
                     CHR(13) + laRequired[liIndex,1] + ;
                     "=" + laRequired[liIndex,2]
      ENDFOR               
      THIS.DoMessage(lcMessage,MB_ICONSTOP )      
   ENDIF
   
   IF llReturn 
                                  
     * just do one check, this is in case
     * a different listener created the config file.
     * the XML will run just fine without these records,
     * it will just use its gooftag instead of regular
     * nodenames if all or any are missing

     IF NOT SEEK( OUTPUTXML_OBJTYPE_NODES+ FRX_OBJTYP_REPORTHEADER, ;
                               ALIAS(),"ObjType")
        TRY
           IF IsReadOnly()
              USE (DBF(tcAlias)) SHARED ALIAS (tcAlias)
           ENDIF
           THIS.InsertXMLConfigRecords()
        CATCH
        ENDTRY   
                               
     ENDIF                          
   
   ENDIF
   
   SELECT (liSelect)
   
ENDIF

RETURN llReturn       

   
ENDPROC
PROCEDURE invokeoncurrentpass
RETURN (THIS.includePage) AND ;
       (NOT THIS.XMLMode = OUTPUTXML_RDL_ONLY ) AND ;
       ((NOT THIS.TwoPassProcess) OR THIS.CurrentPass = LISTENER_FULLPASS)
        


ENDPROC
PROCEDURE BeforeReport
DODEFAULT()

IF (NOT THIS.HadError) 
   THIS.SetFRXDataSession()
   IF USED("FRX")
      LOCAL liSelect, lcDocument, lcReport, ;
            lcRDL, lcPage, lcCol, lcData, loNode, loParent
      liSelect = SELECT()
      SELECT FRX

      IF THIS.TargetHandle = -1 AND THIS.ApplyUserTransform
         IF EMPTY(JUSTEXT(THIS.TargetFileName))
            THIS.TargetFileName = FORCEEXT(THIS.TargetFileName,THIS.TargetFileExt)
         ENDIF   
         THIS.verifyTargetFile()
         THIS.AddProperty("SaveTargetFileName",THIS.TargetFileName)
         THIS.TargetFileName = FORCEEXT(THIS.TargetFileName,"TMP")
      ENDIF
         
      IF (THIS.TargetHandle > -1 OR THIS.OpenTargetFile())  
         IF NOT USED("Nodes")
            IF  UPPER(FULLPATH(THIS.ConfigurationTable)) == ;
                UPPER(FULLPATH(FORCEEXT(OUTPUTCLASS_INTERNALDBF,"DBF")))
                USE (THIS.ConfigurationTable) AGAIN IN 0  ;
                   NOUPDATE ALIAS Nodes SHARED
            ELSE       
                USE (THIS.ConfigurationTable) AGAIN IN 0  ;
                   ALIAS Nodes SHARED
                THIS.VerifyNodeNames()
                THIs.VerifyAttributeNames()
            ENDIF
         ENDIF
            
         * create helper object
         * create band and object cursors   
         * we may want to evaluate raw mode
         * as well as THIS.XMLMode to see if these are needed:
         IF (NOT (THIS.IncludeBandsWithNoObjects AND  ;
            THIS.XMLMode = OUTPUTXML_DATA_ONLY) ) && OR OUTPUTXML_PERFORMLOCALECONVERSION 
            THIS.LoadFRXCursor = .T.               
            IF ISNULL(THIS.FRXCursor) OR ;
               (NOT THIS.FRXCursor.CreateObjectCursor("FRX", "OBJECTS", .F., .T.)) && force the load and make sure
                                                         && we have access to runtime
                                                         && version of the cursor
               THIS.IncludeBandsWithNoObjects = .T.
            ELSE
               SELECT Bands                  
               IF TAGNO("UniqueID") = 0
                  INDEX ON UniqueID TAG UniqueID
               ENDIF
               SET ORDER TO 0                  
               SELECT Objects
               IF TAGNO("UniqueID") = 0
                  INDEX ON UniqueID TAG UniqueID
               ENDIF
               SET ORDER TO 0
            ENDIF   
         ENDIF   
         
         THIS.IsRunning = .T.               
         SET ORDER TO 0 IN FRX            
         lcDocument =  IIF(SEEK(OUTPUTXML_OBJTYPE_NODES+ ;
                              OUTPUTXML_OBJCODE_DOC,;
                              "Nodes","FrxNodes"), ;
                              Nodes.ObjValue, ;
                            OUTPUTXML_GOOFTAG)
         lcReport =  IIF(SEEK( OUTPUTXML_OBJTYPE_NODES+ FRX_OBJTYP_REPORTHEADER, ;
                            "Nodes","ObjType"), ;
                             Nodes.ObjValue, ;
                             OUTPUTXML_GOOFTAG)               
  
         IF NOT THIS.XMLMode = OUTPUTXML_RDL_ONLY 
            lcData =  IIF(SEEK( OUTPUTXML_OBJTYPE_NODES+ ;
                                 OUTPUTXML_OBJCODE_DATA, ;
                                "Nodes","FrxNodes"), ;
                                 Nodes.ObjValue, ;
                                 OUTPUTXML_GOOFTAG)
         ENDIF
         IF NOT THIS.XMLMode = OUTPUTXML_DATA_ONLY 
            lcRDL = IIF(SEEK( OUTPUTXML_OBJTYPE_NODES+ ;
                             OUTPUTXML_OBJCODE_RDL, ;
                             "Nodes","FrxNodes"), ;
                             Nodes.ObjValue, ;
                             OUTPUTXML_GOOFTAG)
         ENDIF
         IF THIS.IncludeBreaksInData = OUTPUTXML_BREAKS_COLLECTION   
            lcPage =  IIF(SEEK( OUTPUTXML_OBJTYPE_NODES+ ;
                                OUTPUTXML_OBJCODE_PAGES, ;
                                "Nodes","FrxNodes"), ;
                                Nodes.ObjValue, ;
                                OUTPUTXML_GOOFTAG)
   *        GO TOP IN FRX
   *        IF FRX.VPos > 1
            lcCol = IIF(SEEK( OUTPUTXML_OBJTYPE_NODES+;
                              OUTPUTXML_OBJCODE_COLS,;
                              "Nodes","FrxNodes"), ;
                               Nodes.ObjValue, ;
                              OUTPUTXML_GOOFTAG)
   
    *       ENDIF
         ENDIF                    
         #IF OUTPUTXML = OUTPUTXML_RAW
             IF EMPTY(THIS.CurrentDocument) OR ISNULL(THIS.CurrentDocument)
                THIS.CurrentDocument = lcDocument
                THIS.WriteRaw( ;
                     THIS.XMLRawTag( THIS.CurrentDocument,.T.) )   
             ENDIF
             THIS.WriteRaw( ;
                  THIS.XMLRawTag( lcReport,.T.) )   
             * could add FRXname as ID here                
             IF NOT THIS.XMLMode = OUTPUTXML_DATA_ONLY    
                * write RDL here
                THIS.WriteRaw( ;
                     THIS.XMLRawTag( lcRDL,.T.,THIS.xmlRawConv( THIS.CommandClauses.FILE)) )  
                THIS.WriteRaw( STRCONV(THIS.GetVFPRDLContents(lcRDL, .T.),STRCONV_DBCS_UTF8)  )
                THIS.WriteRaw( ;
                     THIS.XMLRawTag( lcRDL) )   
             ENDIF
             IF NOT THIS.XMLMode = OUTPUTXML_RDL_ONLY           
                THIS.WriteRaw( ;
                 THIS.XMLRawTag( lcData,.T.) )   
                      
                IF THIS.IncludeBreaksInData = OUTPUTXML_BREAKS_COLLECTION   
                   THIS.PageNodes =  THIS.XMLRawTag( lcPage,.T.)  
 *                 IF NOT EMPTY(lcCol)
                      THIS.ColumnNodes = THIS.XMLRawTag(lcCol,.T.)
 *                 ENDIF
                ENDIF
              ENDIF
                     
         #ELIF OUTPUTXML = OUTPUTXML_DOTNET
             * XMLTextWriter work  
         #ELSE
             IF VARTYPE(THIS.CurrentDocument) # "O"
                THIS.CurrentDocument = CREATEOBJECT(OUTPUTXML_DOMFREETHREADED_DOCUMENTOBJECT)
                * COMPROP(THIS.CurrentDocument,"UTF8",1)                                
                THIS.CurrentDocument.DocumentElement = THIS.CurrentDocument.CreateElement(lcDocument)
             ENDIF
             loNode = THIS.CurrentDocument.CreateElement(lcReport)                  
             * setattribute id using FRXName here                
             * idref?
             THIS.CurrentDocument.DocumentElement.AppendChild(loNode)
             loParent = loNode             
             IF NOT THIS.XMLMode = OUTPUTXML_DATA_ONLY    
                loNode = THIS.CurrentDocument.CreateElement(lcRDL)
                loNode.SetAttribute(THIS.idAttribute,THIS.CommandClauses.FILE)
                loNode.AppendChild(THIS.GetVFPRDLContents(lcRDL))
                loParent.AppendChild(loNode)
             ENDIF
             IF NOT THIS.XMLMode = OUTPUTXML_RDL_ONLY                        
                loNode = THIS.CurrentDocument.CreateElement(lcData)
                * possibly add DE stuff here                
                loParent.AppendChild(loNode)
                THIS.DataNodes = loNode
                IF THIS.IncludeBreaksInData = OUTPUTXML_BREAKS_COLLECTION   
                   THIS.PageNodes = THIS.CurrentDocument.CreateElement(lcPage)
                   THIS.DataNodes.AppendChild(THIS.PageNodes)
                   THIS.ColumnNodes = THIS.CurrentDocument.CreateElement(lcCol)
                   THIS.DataNodes.AppendChild(THIS.ColumnNodes)                   
                ENDIF
             ENDIF
         #ENDIF
         IF THIS.XMLMode = OUTPUTXML_RDL_ONLY
            THIS.AfterReport()
         ENDIF
      ENDIF
          
      STORE NULL TO loNode, loParent
      SELECT (liSelect)
   ELSE
      THIS.DoMessage(OUTPUTXML_FRXMISSING_LOC,MB_ICONSTOP )
   ENDIF   
   THIS.resetDataSession()
ENDIF

RETURN 
ENDPROC
PROCEDURE BeforeBand
LPARAMETERS nBandObjCode, nFRXRecNo, tlContinuedBand

DODEFAULT(nBandObjCode, nFRXRecNo)

IF INLIST(nBandObjCode,FRX_OBJCOD_PAGEHEADER, FRX_OBJCOD_TITLE,FRX_OBJCOD_SUMMARY) 
   THIS.includePage =  THIS.IncludePageInOutput(_PAGENO)
   *(THIS.PageNo >= THIS.CommandClauses.RangeFrom) AND ;
   *    ((THIS.CommandClauses.RangeTo = -1) OR (THIS.PageNo <= THIS.CommandClauses.RangeTo))
   * possibly to be adapted later:
   * regardless of whether IncludePageInOutput() is used
   * or the manual evaluation above (commented) is used,
   * _PAGENO will work for continued reports only if NORESET is not used.
   * THIS.PageNo/THIS.SharedPageNo will not work whether NORESET is used or not,
   * for continued reports, 
   * unless you maintain a private offset.  RANGE is
   * sensitive to the current REPORT FORM command, not the full
   * NOPAGEEJECT (chained) run
   
ENDIF


IF THIS.InvokeOnCurrentPass() AND ;
  THIS.Targethandle > -1 
  
   LOCAL lcBand, loNode, lcID, lcIDRef, ;
         llFormatBreakBand, lcInterruptedBand,;
         llOmitBand, loObjects

   THIS.SetFRXDataSession()   

   GO nFRXRecNo IN FRX   

   IF NOT THIS.IncludeBandsWithNoObjects 
      loObjects = THIS.FRXCursor.GetObjectsInBand(FRX.UniqueID)
      IF loObjects.Count = 0
          llOmitBand = .T.
      ENDIF
      loObjects = NULL
   ENDIF   
      
   lcBand =  IIF(SEEK(OUTPUTXML_OBJTYPE_NODES+ FRX_OBJTYP_BAND+ ;
                    OUTPUTXML_OBJTYPE_BANDOFFSET+nBandObjCode,;
                    "Nodes","FrxNodes"),;
                    Nodes.ObjValue, ;
                    OUTPUTXML_GOOFTAG)
   THIS.SetCurrentDataSession()
                    
   llFormatBreakBand = INLIST(nBandObjCode,;
                    FRX_OBJCOD_PAGEHEADER, ;
                    FRX_OBJCOD_PAGEFOOTER, ;
                    FRX_OBJCOD_COLHEADER, ;
                    FRX_OBJCOD_COLFOOTER)                 
                    
   
   IF llFormatBreakBand

      lcIDRef =  TRANSFORM(nFRXRecNo) && TRANSFORM(IIF(EMPTY(FRX.UniqueID),"",FRX.UniqueID))
      lcID = TRANSFORM(IIF(THIS.sharedPageNo = 0, THIS.PageNo, THIS.sharedPageNo))
         
   ELSE

      lcID =  TRANSFORM(nFRXRecNo) && TRANSFORM(IIF(EMPTY(FRX.UniqueID),"",FRX.UniqueID) )
      IF tlContinuedBand
         lcID = lcID + "+"
      ENDIF
      lcIDRef = TRANSFORM(IIF(THIS.sharedPageNo = 0, THIS.PageNo, THIS.sharedPageNo))
      
   ENDIF

   * first evaluate THIS.IncludeBreaksInData 
   DO CASE
   CASE llOmitBand
      * do nothing -- TBD checked later.
   CASE THIS.IncludeBreaksInData = OUTPUTXML_BREAKS_INDATA OR ;
        NOT llFormatBreakBand   

      #IF OUTPUTXML = OUTPUTXML_RAW
         IF NOT (ISNULL(THIS.CurrentBand) OR EMPTY(THIS.CurrentBand))
             * a data band has spanned
             * formatting breaks (pages or columns)
             * and we haven't otherwise caught it.
             * This should not happen.
             lcInterruptedBand = SUBSTR(ALLTR(THIS.CurrentBand),2,AT(" ", THIS.CurrentBand)-2)
             * write a closing tag
             THIS.WriteRaw(THIS.CurrentBand + THIS.XMLRawTag(lcInterruptedBand))
         ENDIF
         
      
        THIS.CurrentBand =  THIS.XMLRawTag( lcBand,.T., lcID, lcIDRef ) 
               
      
      #ELIF OUTPUTXML = OUTPUTXML_DOTNET                       
  
      #ELSE

          loNode = THIS.CurrentDocument.CreateElement(lcBand)
          loNode.SetAttribute(THIS.idAttribute,lcID)
          loNode.SetAttribute(THIS.idrefAttribute,lcIDRef)
          THIS.DataNodes.AppendChild(loNode)
          THIS.CurrentBand = loNode                                    
          loNull = NULL
      #ENDIF

   CASE THIS.IncludeBreaksInData = OUTPUTXML_BREAKS_COLLECTION
      * build the collection which will be inserted into the
      * data before finishing.
      * but the band output at this point is .F.
      #IF OUTPUTXML = OUTPUTXML_RAW
          IF INLIST( nBandObjCode, ;
                 FRX_OBJCOD_PAGEHEADER, ;
                 FRX_OBJCOD_PAGEFOOTER) 
             THIS.CurrentPage = NVL(THIS.CurrentPage,"")
             THIS.CurrentPage = THIS.CurrentPage + ;
                                THIS.XMLRawTag( lcBand, .T.,lcID, lcIDRef ) 
          ELSE
             THIS.CurrentColumn = NVL(THIS.CurrentColumn,"")
             THIS.CurrentColumn = THIS.CurrentColumn + ;
                                  THIS.XMLRawTag( lcBand, .T., lcID, lcIDRef ) 
          ENDIF
          
         
      #ELIF OUTPUTXML = OUTPUTXML_DOTNET 
      
      #ELSE
      
          * we leave THIS.CurrentBand alone in this case,
          * to use after the band has finished.
          IF INLIST( nBandObjCode, ;
                 FRX_OBJCOD_PAGEHEADER, ;
                 FRX_OBJCOD_PAGEFOOTER) 
             THIS.CurrentPage = THIS.CurrentDocument.CreateElement(lcBand)
             THIS.CurrentPage.SetAttribute(THIS.idAttribute,lcID)
             THIS.CurrentPage.SetAttribute(THIS.idrefAttribute,lcIDRef)
             THIS.PageNodes.AppendChild(THIS.CurrentPage)
          ELSE
             THIS.CurrentColumn = THIS.CurrentDocument.CreateElement(lcBand)
             THIS.CurrentColumn.SetAttribute(THIS.idAttribute,lcID)
             THIS.CurrentColumn.SetAttribute(THIS.idrefAttribute,lcIDRef)
             THIS.ColumnNodes.AppendChild(THIS.CurrentColumn)
          ENDIF
          
      #ENDIF
   CASE INLIST( nBandObjCode, ;
                 FRX_OBJCOD_COLHEADER, ;
                 FRX_OBJCOD_COLFOOTER)   && XMLBREAKS_NONE and column band
   
      THIS.CurrentColumn = "X"

   OTHERWISE  && XMLBREAKS_NONE and page band

      THIS.CurrentPage = "X"
   
   ENDCASE
   
   THIS.resetDataSession()
   
ENDIF



ENDPROC
PROCEDURE Render
LPARAMETERS nFRXRecNo, nLeft,nTop,nWidth,nHeight, nObjectContinuationType, cContentsToBeRendered, GDIPlusImage

DODEFAULT(nFRXRecNo, nLeft,nTop,nWidth,nHeight, nObjectContinuationType, cContentsToBeRendered, GDIPlusImage)

IF THIS.InvokeOnCurrentPass() AND ;
   THIS.Targethandle > -1 

   * also evaluate THIS.IncludeBreaksInData and 
   * the band for the object in question.

   * If the stars align, create the node for the object here.  For now:
   
   LOCAL lcNode, loNode, lcFormattingInfo, lcContents,  ;
         llTextType, loBandRef, liBandRecno, lcID
  
   THIS.SetFRXDataSession()
   
   GO nFRXRecNo IN FRX
   

   lcContents = cContentsToBeRendered
   llTextType = INLIST(FRX.ObjType,  FRX_OBJTYP_LABEL, FRX_OBJTYP_FIELD)
   lcID = TRANSFORM(nFRXRecNo)
   IF INLIST(nObjectContinuationType, ;
             LISTENER_CONTINUATION_MIDDLE, ;
             LISTENER_CONTINUATION_END)
      lcID = lcID + "+"
   ENDIF

      
   IF THIS.IncludeBreaksInData = OUTPUTXML_BREAKS_COLLECTION ;
      OR (ISNULL(THIS.CurrentPage) AND ISNULL(THIS.CurrentColumn))
      lcNode =   IIF(SEEK(OUTPUTXML_OBJTYPE_NODES+FRX.ObjType,"Nodes","ObjType"), ;
                     Nodes.ObjValue,;
                     OUTPUTXML_GOOFTAG)
                  
      #IF OUTPUTXML = OUTPUTXML_RAW
          lcFormattingInfo = THIS.GetRawFormattingInfo( nLeft, nTop, nWidth,nHeight, nObjectContinuationType)
          IF llTextType
             * build 1515: render gets unicode
             lcContents = STRCONV(TRANSFORM(lcContents),STRCONV_UNICODE_UTF8)
          ELSE
             lcContents = TRANSFORM(lcContents)  
          ENDIF
          DO CASE
          CASE NOT ISNULL(THIS.CurrentPage)
             THIS.CurrentPage = THIS.CurrentPage +  ;
                 THIS.XMLRawNode( ;
                 lcNode, ;
                 lcContents, ;
                 lcID,.F.,lcFormattingInfo) && FRX.UniqueID
          CASE NOT ISNULL(THIS.CurrentColumn)
             THIS.CurrentColumn = THIS.CurrentColumn +  ;
                 THIS.XMLRawNode( ;
                 lcNode, ;
                 lcContents, ;
                 lcID,.F.,lcFormattingInfo) 
          OTHERWISE 
             * write directly to the stream
             
             * First, take care of continuation.
             IF EMPTY(NVL(THIS.CurrentBand,""))
                * first object in a continued band
                 IF ISNULL(THIS.FRXCursor)
                    liBandRecno = 0
                 ELSE
                    loBandRef =  THIS.FRXCursor.GetBandFor(FRX.UniqueID, .T.)
                    SELECT FRX
                    LOCATE FOR UniqueID == loBandRef.UniqueID
                    IF EOF()
                       liBandRecno = 0
                    ELSE
                       liBandRecno = RECNO()
                    ENDIF
                 ENDIF
                 IF liBandRecno = 0
                    THIS.CurrentBand = THIS.XMLRawTag(OUTPUTXML_GOOFTAG, .T.,;
                                  "0",TRANSFORM(IIF(THIS.sharedPageNo = 0, THIS.PageNo, THIS.sharedPageNo)) )
                 ELSE
                    THIS.SetCurrentDataSession()
                    THIS.BeforeBand(FRX_OBJCOD_DETAIL,liBandRecno, .T.)
                    THIS.SetFRXDataSession()
                 ENDIF                 
                 THIS.CurrentBand = THIS.CurrentBand + ;
                      THIS.XMLRawNode( ;
                       lcNode, ;
                       lcContents, ;
                      lcID,.F.,lcFormattingInfo) 
                IF EOF()      
                   THIS.WriteRaw(THIS.CurrentBand + ;
                                THIS.XMLRawTag(OUTPUTXML_GOOFTAG))
                   THIS.CurrentBand = ""               
                ENDIF
                GO nFRXRecNo IN FRX
             ELSE      
                THIS.CurrentBand = THIS.CurrentBand + ;
                     THIS.XMLRawNode( ;
                      lcNode, ;
                      lcContents, ;
                      lcID,.F., lcFormattingInfo) 
             ENDIF
             
          ENDCASE
     
      #ELIF OUTPUTXML =  OUTPUTXML_DOTNET
          * XMLTextWriter work
      #ELSE      
          * if continuation type is of type 2 or 3
          * and we're in a text type object
          * we have to create a new
          * continued band node as if a BeforeBand event has occurred.         
          IF ISNULL(THIS.CurrentBand)
             * first object in a continued band
             IF ISNULL(THIS.FRXcursor)
                liBandRecno = 0
             ELSE
                loBandRef =  THIS.FRXCursor.GetBandFor(FRX.UniqueID, .T.)
                SELECT FRX
                LOCATE FOR UniqueID == loBandRef.UniqueID
                liBandRecno = RECNO()
             ENDIF
             THIS.SetCurrentDataSession()
             IF EOF()
                 THIS.BeforeBand(FRX_OBJCOD_DETAIL,1, .T.)
             ELSE
                 THIS.BeforeBand(FRX_OBJCOD_DETAIL,liBandRecno, .T.)
             ENDIF
             THIS.SetFRXDataSession()
             GO nFRXRecNo IN FRX
          ENDIF
 * build 1515: render gets unicode, and is already regionally transformed          
          lcContents = TRANSFORM(lcContents)  
          loNode = THIS.CurrentDocument.CreateElement(lcNode)
          loNode.Text = CREATEBINARY(lcContents)
          loNode.SetAttribute(THIS.IdAttribute,lcID)
          THIS.SetDOMFormattingInfo( loNode, nLeft, nTop, nWidth,nHeight, nObjectContinuationType)
          DO CASE
          CASE NOT ISNULL(THIS.CurrentPage)
             THIS.CurrentPage.AppendChild(loNode)          
          CASE NOT ISNULL(THIS.CurrentColumn)
             THIS.CurrentColumn.AppendChild(loNode)          
          OTHERWISE
             THIS.CurrentBand.AppendChild(loNode)                     
          ENDCASE
          loNode = NULL
       #ENDIF
   ELSE
      * otherwise object belongs to a formatting header or footer
      * and we're not processing them (XMLBREAKS_NONE)
   ENDIF                   
   
   THIS.resetDataSession()
   
ENDIF

RETURN  
ENDPROC
PROCEDURE Error
LPARAMETERS nError, cMethod, nLine

   DODEFAULT(nError,cMethod,nLine)
   * we could evaluate errors first, but generally,
   THIS.CloseTargetFile()
   THIS.QuietMode = .T.
   THIS.CancelReport()


ENDPROC
PROCEDURE AfterReport

   THIS.SetFRXDataSession()


   IF THIS.TargetHandle > -1 AND NOT (THIS.HadError )
   
      #IF OUTPUTXML = OUTPUTXML_RAW
      
          LOCAL lcNode
          IF NOT THIS.XMLMode = OUTPUTXML_RDL_ONLY 
          
             IF  NOT EMPTY(NVL(THIS.CurrentBand,""))
                lcNode = SUBSTR(THIS.CurrentBand,2,AT(" ", THIS.CurrentBand)-2)
                THIS.CurrentBand = THIS.CurrentBand + THIS.XMLRawTag(lcNode)
                * write a closing tag
                THIS.WriteRaw(THIS.CurrentBand)
             ENDIF

             IF THIS.IncludeBreaksInData = OUTPUTXML_BREAKS_COLLECTION 
                IF NOT ISNULL(THIS.PageNodes)
                    lcNode =  IIF(SEEK( OUTPUTXML_OBJTYPE_NODES+OUTPUTXML_OBJCODE_PAGES,;
                                "Nodes","FrxNodes"), ;
                              Nodes.ObjValue, ;
                              OUTPUTXML_GOOFTAG)
                    THIS.WriteRaw(THIS.PageNodes) 
                    THIS.WriteRaw(THIS.XMLRawTag(lcNode))                  
                ENDIF
                IF NOT ISNULL(THIS.ColumnNodes)
                   lcNode =  IIF(SEEK( OUTPUTXML_OBJTYPE_NODES+OUTPUTXML_OBJCODE_COLS,;
                                "Nodes","FrxNodes"), ;
                              Nodes.ObjValue, ;
                              OUTPUTXML_GOOFTAG)
                    THIS.WriteRaw(THIS.ColumnNodes) 
                    THIS.WriteRaw(THIS.XMLRawTag(lcNode))                                   
                ENDIF
             ENDIF          
          
             lcNode =  IIF(SEEK( OUTPUTXML_OBJTYPE_NODES+OUTPUTXML_OBJCODE_DATA,;
                           "Nodes","FrxNodes"), ;
                         Nodes.ObjValue, ;
                         OUTPUTXML_GOOFTAG)
          
             THIS.WriteRaw( THIS.XMLRawTag(lcNode))
          ENDIF

          lcNode =  IIF(SEEK( OUTPUTXML_OBJTYPE_NODES+ FRX_OBJTYP_REPORTHEADER, ;
                              "Nodes","ObjType"), ;
                               Nodes.ObjValue, ;
                               OUTPUTXML_GOOFTAG)               
          THIS.WriteRaw( THIS.XMLRawTag(lcNode))    

          * check to see if continuation... 
          IF NOT OUTPUTXML_CONTINUATION
             THIS.WriteRaw( THIS.XMLRawTag(THIS.CurrentDocument))          
          ENDIF
   
      #ELIF OUTPUTXML = OUTPUTXML_DOTNET     
         * XMLTextWriter work
      #ELSE
          * domwork here        
          IF THIS.IncludeBreaksInData = OUTPUTXML_BREAKS_COLLECTION
             * currently all this is done on entry, but
             * if not:
             * append the pages collection
             * into the report data node --
             * that's where we should be right now
             * THIS.DataNodes.AppendChild(THIS.PageNodes)
             ** IF NOT ISNULL(THIS.ColumnNodes)
             * THIS.DataNodes.AppendChild(THIS.ColumnNodes)             
             ** ENDIF
          ENDIF
          
          IF NOT OUTPUTXML_CONTINUATION
             THIS.CurrentDocument.Save(THIS.TargetFileName)
          ENDIF

       #ENDIF
   ENDIF
   
   IF OUTPUTXML_CONTINUATION
      THIS.ResetReport()   
   ELSE
      THIS.ResetDocument()         
      THIS.ApplyUserTransformToOutput()
      IF THIS.ApplyUserTransform AND (NOT THIS.HadError)
         * we suppressed this message earlier
            IF THIS.DoMessage( OUTPUTCLASS_SUCCESS_LOC + ;
                            IIF(SYS(2024)="Y",CHR(13)+OUTPUTCLASS_REPORT_INCOMPLETE_LOC,""),;
                            MB_ICONINFORMATION + MB_YESNO ) = IDYES
               _CLIPTEXT = THIS.TargetFileName
            ENDIF
      ENDIF   
   ENDIF

   THIS.resetDataSession()   

DODEFAULT()
ENDPROC
PROCEDURE Init
THIS.ReadConfiguration = OUTPUTCLASS_READCONFIG_INIT

IF DODEFAULT()
   THIS.AppName = OUTPUTXML_APPNAME_LOC
   THIS.ResetDocument()
ELSE
   RETURN .F.   
ENDIF

IF THIS.ApplyUserTransform
   THIS.GetDefaultUserXSLT()
ENDIF   
RETURN NOT THIS.HadError
ENDPROC
PROCEDURE createconfigtable
LPARAMETERS tcDBF, tlOverWrite
* table is being created from scratch,
* may be in a VCX in an unknown environment
* (definitely not in REPORTOUTPUT.APP!)

DODEFAULT(tcDBF, tlOverWrite)

IF NOT THIS.HadError
   LOCAL liSelect, llSafetyOn
   llSafetyOn = (SET("SAFETY") = "ON")
   SET SAFETY OFF
   liSelect = SELECT()
   SELECT 0
   USE (tcDBF) EXCLU  
   INDEX ON ObjType+ObjCode+ ;
      IIF(ObjType=FRX_OBJTYP_BAND+OUTPUTXML_OBJTYPE_NODES, ;
          OUTPUTXML_OBJTYPE_BANDOFFSET,0) ;
      TAG FRXNodes  
   IF llSafetyOn
      SET SAFETY OFF
   ENDIF   
   THIS.InsertXMLConfigRecords()   
   USE
   SELECT (liSelect)
ENDIF   

ENDPROC
PROCEDURE Destroy
THIS.ResetDocument()
STORE NULL TO ;
   THIS.ColumnNodes, ;
   THIS.CurrentBand, ;
   THIS.CurrentColumn, ;
   THIS.CurrentDocument, ;
   THIS.CurrentPage, ;
   THIS.DataNodes, ;
   THIS.pageNodes, ;
   THIS.XSLTProcessorRDL, ;
   THIS.XSLTProcessorUser, ;
   THIS.xsltParameters 
   
DODEFAULT()
ENDPROC
PROCEDURE AfterBand
LPARAMETERS nBandObjCode, nFRXRecNo

DODEFAULT(nBandObjCode, nFRXRecNo)


IF THIS.InvokeOnCurrentPass() AND ;
   THIS.Targethandle > -1 
  
   LOCAL lcBand, loNode, lcID, lcIDRef, ;
         llFormatBreakBand, loObjects, llOmitBand


   THIS.SetFRXDataSession()   
   lcBand =  IIF(SEEK(OUTPUTXML_OBJTYPE_NODES+FRX_OBJTYP_BAND+ ;
                    OUTPUTXML_OBJTYPE_BANDOFFSET+nBandObjCode,;
                    "Nodes","FrxNodes"),;
                    Nodes.ObjValue, ;
                    OUTPUTXML_GOOFTAG)
                    
   GO nFRXRecNo IN FRX
   IF NOT THIS.IncludeBandsWithNoObjects 
      loObjects = THIS.FRXCursor.GetObjectsInBand(FRX.UniqueID)
      IF loObjects.Count = 0
          llOmitBand = .T.
      ENDIF
      loObjects = NULL
   ENDIF   
   
   THIS.SetCurrentDataSession()
      
   llFormatBreakBand = INLIST(nBandObjCode,;
                    FRX_OBJCOD_PAGEHEADER, ;
                    FRX_OBJCOD_PAGEFOOTER, ;
                    FRX_OBJCOD_COLHEADER, ;
                    FRX_OBJCOD_COLFOOTER)                 
                    
   * first evaluate THIS.IncludeBreaksInData 
   DO CASE
   CASE llOmitBand = .T.
      * nothing
   CASE THIS.IncludeBreaksInData = OUTPUTXML_BREAKS_INDATA OR ;
        NOT llFormatBreakBand   

      #IF OUTPUTXML = OUTPUTXML_RAW
         
         IF EMPTY(NVL(THIS.CurrentBand,"")) 
           * see continuation discussion in Render.
           * our fix there may have left us with
           * no band here
           * do nothing
         ELSE
         
            THIS.CurrentBand = NVL(THIS.CurrentBand,"") + ;
               THIS.XMLRawTag( lcBand, .F., lcID, lcIDRef ) 
  
            IF NOT (ISNULL(THIS.CurrentBand) OR EMPTY(THIS.CurrentBand))
               THIS.WriteRaw(THIS.CurrentBand)
               THIS.CurrentBand = ""
            ENDIF

         ENDIF    
               
      #ELIF OUTPUTXML = OUTPUTXML_DOTNET                       
  
      #ELSE
         * nothing to do here when using the DOM
         THIS.CurrentBand = NULL
      #ENDIF

   CASE THIS.IncludeBreaksInData = OUTPUTXML_BREAKS_COLLECTION
      * build the collection which will be inserted into the
      * data before finishing.
      * but the band output at this point is .F.
      #IF OUTPUTXML = OUTPUTXML_RAW
          IF INLIST( nBandObjCode, ;
                 FRX_OBJCOD_PAGEHEADER, ;
                 FRX_OBJCOD_PAGEFOOTER) 
             THIS.CurrentPage = NVL(THIS.CurrentPage,"")
             THIS.CurrentPage = THIS.CurrentPage +  ;
                               THIS.XMLRawTag( lcBand, .F., lcID, lcIDRef ) 
             THIS.PageNodes = THIS.PageNodes + THIS.CurrentPage
             THIS.CurrentPage = NULL
          ELSE
             THIS.CurrentColumn = NVL(THIS.CurrentColumn,"")
             THIS.CurrentColumn = THIS.CurrentColumn + ;
                                THIS.XMLRawTag( lcBand, .F., lcID, lcIDRef ) 
             THIS.ColumnNodes = THIS.ColumnNodes + THIS.CurrentColumn
             THIS.CurrentColumn = NULL
          ENDIF
          
      #ELIF OUTPUTXML = OUTPUTXML_DOTNET 
      
      #ELSE
      
          * we leave THIS.CurrentBand alone in this case,
          * to use after the band has finished.
          IF INLIST( nBandObjCode, ;
                 FRX_OBJCOD_PAGEHEADER, ;
                 FRX_OBJCOD_PAGEFOOTER) 
             THIS.CurrentPage = NULL
          ELSE
             THIS.CurrentColumn = NULL
          ENDIF
          
      #ENDIF
   CASE INLIST( nBandObjCode, ;
                 FRX_OBJCOD_COLHEADER, ;
                 FRX_OBJCOD_COLFOOTER)   && XMLBREAKS_NONE and column band
   
       THIS.CurrentColumn = NULL
   OTHERWISE  && XMLBREAKS_NONE and page band

       THIS.CurrentPage = NULL
   
   ENDCASE
   
   THIS.resetDataSession()
   
ENDIF


IF INLIST(nBandObjCode,FRX_OBJCOD_PAGEFOOTER, FRX_OBJCOD_TITLE) 
   THIS.includePage = .F.
ENDIF

ENDPROC
PROCEDURE opentargetfile
#IF OUTPUTXML = OUTPUTXML_DOM
   THIS.VerifyTargetFile() 
   THIS.TargetHandle = 0
   RETURN (NOT THIS.HadError)
#ELSE
   RETURN DODEFAULT()   
#ENDIF

ENDPROC
PROCEDURE setfrxdatasessionenvironment
DODEFAULT()
SET EXACT ON
SET SYSFORMATS ON
SET CENTURY ON
SET SAFETY OFF
ENDPROC
PROCEDURE closetargetfile
LOCAL llResetQuietMode
llResetQuietMode = ((NOT THIS.HadError) AND (NOT THIS.QuietMode) AND (THIS.ApplyUserTransform))
IF llResetQuietMode
   THIS.QuietMode = .T.
ENDIF
DODEFAULT()
IF llResetQuietMode
   THIS.QuietMode = .F.
ENDIF      
ENDPROC


************************************************************
OBJETO: debuglistener
************************************************************
*** PROPIEDADES ***
Height = 23
Width = 23
FRXDataSession = -1
includeloadandunload = .T.
targetalias = ("")
_memberdata =      461<VFPData><memberdata name="verbose" type="property" display="verbose" favorites="True" /><memberdata name="dodebug" type="method" display="doDebug" favorites="True" /><memberdata name="dodebugcommandclauses" type="method" display="doDebugCommandClauses" favorites="False" /><memberdata name="targetalias" type="property" display="targetAlias" /><memberdata name="includeloadandunload" type="property" display="includeLoadAndUnload" favorites="True" /></VFPData>
Name = "debuglistener"

*** METODOS ***
PROCEDURE dodebug
LPARAMETERS p0, pcount, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12

IF THIS.TargetHandle > 0 

   LOCAL liIndex, loObj, lvParam, liObjIndex, liMembers, laMembers[1]

   FWRITE( THIS.TargetHandle, p0 )
   
   FOR liIndex = 1 TO pcount
   
      lvParam = EVAL("p"+TRANS(liIndex))
   
      IF THIS.Verbose AND VARTYPE(lvParam) = "O"

         liMembers = AMEMBERS(laMembers, lvParam) && ,0,"G"
 
         FOR liIndex = 1 TO liMembers
   
            IF TYPE("lvParam."+laMembers[liIndex]) # "U"
               FWRITE(THIS.TargetHandle, ;
                  ",Obj."+laMembers[liIndex]+"="+TRANSFORM(EVAL("lvParam."+laMembers[liIndex])) )
            ENDIF
     
         ENDFOR

      ELSE
  
         FWRITE(THIS.TargetHandle, ","+TRANSF(lvParam))

      ENDIF

   ENDFOR

   FPUTS(THIS.TargetHandle, "")

   IF THIS.Verbose
      THIS.setCurrentDataSession()
   
      FWRITE(THIS.TargetHandle, ;
          "Listener.PageNo=" + IIF(THIS.sharedPageNo=0,;
                                   TRANSFORM(THIS.PageNo),  ;
                                   TRANSFORM(THIS.sharedPageNo))+ ", " + ;
          "_PAGENO="+TRANSFORM(_PAGENO))

      IF (NOT EMPTY(THIS.DrivingAlias)) AND USED(THIS.DrivingAlias)
         FWRITE(THIS.TargetHandle, ", " + THIS.DrivingAlias + " recno=" + TRANSFORM(RECNO(THIS.Drivingalias)))   
      ENDIF   
      
      IF NOT EMPTY(THIS.TargetAlias)
      
         FWRITE(THIS.TargetHandle, ", TargetAlias=" + THIS.TargetAlias + ", targetRecno=" + TRANSFORM(RECNO(THIS.TargetAlias)))         
      
      ENDIF
   
      FPUTS(THIS.TargetHandle, "")   
      THIS.resetDataSession()
   ENDIF
   
   FFLUSH(THIS.targetHandle)
   
ENDIF   




ENDPROC
PROCEDURE dodebugcommandclauses
LPARAMETERS tvCommand, tcHeader

IF VARTYPE(tvCommand) = "O" AND THIS.TargetHandle > 0 
   LOCAL liIndex, laMembers[1], liMembers

   FPUTS( THIS.TargetHandle, REPL("-",30) )   
   FPUTS( THIS.TargetHandle, "MEMBERS:" )
   liMembers = AMEMBERS(laMembers, THIS) && ,0,"G"
 
   FOR liIndex = 1 TO liMembers
   
      IF TYPE("THIS."+laMembers[liIndex]) # "U"
  
         FPUTS(THIS.TargetHandle, "."+laMembers[liIndex]+"="+TRANSFORM(EVAL("THIS."+laMembers[liIndex])) )
      ENDIF

   ENDFOR

   FPUTS( THIS.TargetHandle, REPL("-",30) )   
   FPUTS( THIS.TargetHandle, tcHeader )
      
   liMembers = AMEMBERS(laMembers, tvCommand)   
   IF liMembers = 0
      FPUTS(THIS.TargetHandle, "... NO MEMBERS")
   ELSE

      FOR liIndex = 1 TO liMembers
  
        FPUTS(THIS.TargetHandle, "."+laMembers[liIndex]+"="+TRANSFORM(EVAL("tvCommand."+laMembers[liIndex])) )

      ENDFOR
     
   ENDIF   
   FPUTS( THIS.TargetHandle, REPL("-",30) )      
   FFLUSH(THIS.targetHandle)

ENDIF
ENDPROC
PROCEDURE verbose_assign
LPARAMETERS vNewVal
IF VARTYPE(vNewVal) = "L"
   THIS.Verbose = m.vNewVal
ENDIF   

ENDPROC
PROCEDURE opentargetfile
IF WEXIST(JUSTSTEM(THIS.targetFileName))
   * because of the MODI FILE NOWAIT,
   * generate a new filename:
   THIS.targetFileName = SYS(2015)
ENDIF
DODEFAULT()   
ENDPROC
PROCEDURE BeforeReport
LPARAMETERS p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12

   LOCAL lcProgram
   lcProgram = PROGRAM()
   
   DODEFAULT()
   
   IF THIS.Verbose
   
      THIS.setCurrentDataSession()

   ENDIF
   
  
   IF THIS.TargetHandle = -1 
      THIS.OpenTargetFile()
   ENDIF

  THIS.DoDebug(PROGRAM(), PCOUNT(), p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12)
   
  THIS.DoDebugCommandClauses(THIS.CommandClauses,lcProgram+ " received CommandClauses")


   IF THIS.verbose
      THIS.resetDataSession()
   ENDIF      
   

ENDPROC
PROCEDURE AfterReport
LPARAMETERS  p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12

LOCAL lcProgram
lcProgram = PROGRAM()
THIS.DoDebug(lcProgram, PCOUNT(), p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12)
THIS.DoDebugCommandClauses(THIS.CommandClauses,lcProgram+ " current CommandClauses")

IF NOT (THIS.IncludeLoadAndUnload OR THIS.CommandClauses.NoPageEject)
   THIS.CloseTargetFile()
   IF NOT THIS.QuietMode
      MODI COMM (THIS.TargetFileName) NOWAIT
   ENDIF   
ENDIF   

DODEFAULT()

ENDPROC
PROCEDURE AddProperty
LPARAMETERS  p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12
THIS.DoDebug(PROGRAM(), PCOUNT(), p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12)

ENDPROC
PROCEDURE AdjustObjectSize
LPARAMETERS  p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12
THIS.DoDebug(PROGRAM(), PCOUNT(), p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12)

ENDPROC
PROCEDURE AfterBand
LPARAMETERS  p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12
THIS.DoDebug(PROGRAM(), PCOUNT(), p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12)
DODEFAULT(p1, p2)
ENDPROC
PROCEDURE BeforeBand
LPARAMETERS  p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12
THIS.DoDebug(PROGRAM(), PCOUNT(), p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12)
DODEFAULT(p1, p2)
IF THIS.Verbose
   THIS.TargetAlias = ""
   IF p1 = FRX_OBJCOD_DETAIL
      THIS.SetFRXDataSession()
      GO p2 IN FRX
      IF NOT EMPTY(FRX.Expr)
         THIS.TargetAlias = UPPER(EVALUATE(FRX.Expr))
      ENDIF
      THIS.resetDataSession()
   ENDIF
ENDIF   
ENDPROC
PROCEDURE DoStatus
LPARAMETERS  p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12
THIS.DoDebug(PROGRAM(), PCOUNT(), p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12)
DODEFAULT(p1)

ENDPROC
PROCEDURE Render
LPARAMETERS  p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12
THIS.DoDebug(PROGRAM(), PCOUNT(), p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12)
DODEFAULT( p1, p2, p3, p4, p5, p6, p7, p8)

ENDPROC
PROCEDURE ClearStatus
LPARAMETERS  p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12
THIS.DoDebug(PROGRAM(), PCOUNT(), p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12)
DODEFAULT()

ENDPROC
PROCEDURE OnPreviewClose
LPARAMETERS  p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12
THIS.DoDebug(PROGRAM(), PCOUNT(), p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12)

ENDPROC
PROCEDURE ReadExpression
LPARAMETERS  p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12
THIS.DoDebug(PROGRAM(), PCOUNT(), p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12)

ENDPROC
PROCEDURE ReadMethod
LPARAMETERS  p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12
THIS.DoDebug(PROGRAM(), PCOUNT(), p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12)

ENDPROC
PROCEDURE ResetToDefault
LPARAMETERS  p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12
THIS.DoDebug(PROGRAM(), PCOUNT(), p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12)

ENDPROC
PROCEDURE SaveAsClass
LPARAMETERS  p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12
THIS.DoDebug(PROGRAM(), PCOUNT(), p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12)

ENDPROC
PROCEDURE SupportsListenerType
LPARAMETERS  p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12
THIS.DoDebug(PROGRAM(), PCOUNT(), p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12)

ENDPROC
PROCEDURE UpdateStatus
LPARAMETERS  p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12
THIS.DoDebug(PROGRAM(), PCOUNT(), p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12)
DODEFAULT()

ENDPROC
PROCEDURE WriteExpression
LPARAMETERS  p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12
THIS.DoDebug(PROGRAM(), PCOUNT(), p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12)

ENDPROC
PROCEDURE WriteMethod
LPARAMETERS  p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12
THIS.DoDebug(PROGRAM(), PCOUNT(), p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12)

ENDPROC
PROCEDURE LoadReport
LPARAMETERS  p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12

DODEFAULT()

IF THIS.IncludeLoadandUnload 

  IF THIS.TargetHandle = -1
     THIS.OpenTargetFile()
  ENDIF
  
  THIS.DoDebug(PROGRAM(), PCOUNT(), p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12)
  THIS.DoDebugCommandClauses(THIS.CommandClauses,PROGRAM()+ " received CommandClauses")
  
ENDIF  

ENDPROC
PROCEDURE UnloadReport
LPARAMETERS  p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12

IF THIS.includeLoadAndUnload 
   LOCAL lcProgram
   lcProgram = PROGRAM()
   THIS.DoDebug(lcProgram, PCOUNT(), p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12)
   THIS.DoDebugCommandClauses(THIS.CommandClauses,lcProgram+ " current CommandClauses")
ENDIF   

IF THIS.TargetHandle > 0 AND (NOT THIS.CommandClauses.NoPageEject)
   THIS.CloseTargetFile()
   IF NOT THIS.QuietMode
      MODI FILE (THIS.Targetfilename) NOWAIT
   ENDIF
ENDIF   

DODEFAULT()

ENDPROC
PROCEDURE CancelReport
LPARAMETERS  p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12
THIS.DoDebug(PROGRAM(), PCOUNT(), p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12)
DODEFAULT()

ENDPROC
PROCEDURE EvaluateContents
LPARAMETERS  p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12
THIS.DoDebug(PROGRAM(), PCOUNT(), p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12)

ENDPROC
PROCEDURE IncludePageInOutput
LPARAMETERS  p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12
THIS.DoDebug(PROGRAM(), PCOUNT(), p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12)
RETURN DODEFAULT(p1)

ENDPROC
PROCEDURE OutputPage
LPARAMETERS  p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12
THIS.DoDebug(PROGRAM(), PCOUNT(), p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12)


ENDPROC


************************************************************
OBJETO: xmldisplaylistener
************************************************************
*** PROPIEDADES ***
FRXDataSession = -1
externalfilelocation = ("")
jpgclsid = (.NULL.)
oldsendgdiplusimage = 0
oldexternalfilelocation = ("")
imagefieldinstance = 0
imagefieldtofile = ("")
imagesrcattr = ("img")
imagefilebasename = ("")
formattingchanges = (.NULL.)
includeformattinginlayoutobjects = .T.
includebandswithnoobjects = .T.
_memberdata =     1300<VFPData> <memberdata name="copyimagefilestoexternalfilelocation" type="property" display="copyImageFilesToExternalFileLocation" favorites="True" /> <memberdata name="externalfilelocation" type="property" display="externalFileLocation" favorites="True" /><memberdata name="formattingchanges" type="property" display="formattingChanges" favorites="True"/> <memberdata name="imagefieldinstance" type="property" display="imageFieldInstance" favorites="False" /> <memberdata name="imagefieldtofile" type="property" display="imageFieldToFile" favorites="False" /> <memberdata name="imagefilebasename" type="property" display="imageFileBaseName" favorites="True" /> <memberdata name="imagesrcattr" type="property" display="imageSrcAttr" favorites="True" /> <memberdata name="jpgclsid" type="property" display="JPGclsid" favorites="False" /> <memberdata name="oldexternalfilelocation" type="property" display="oldExternalFileLocation" favorites="False" /> <memberdata name="oldsendgdiplusimage" type="property" display="oldSendGDIPlusImage" favorites="False" /> <memberdata name="checkreportforgeneralfields" type="method" display="checkReportForGeneralFields" favorites="False" /><memberdata name="initializefilecopysettings" type="method" display="initializeFileCopySettings" favorites="False"/></VFPData>
Name = "xmldisplaylistener"

*** METODOS ***
PROCEDURE externalfilelocation_assign
LPARAMETERS vNewVal
IF THIS.isRunning AND NOT EMPTY(THIS.externalFileLocation)
   RETURN
ENDIF   
IF VARTYPE(vNewVal) = "C"
   
   IF NOT (ALLTRIM(m.vNewVal) == THIS.externalFileLocation)
      LOCAL liIndex, llRemove
   
      THIS.externalFileLocation = ALLTRIM(m.vNewVal)
      IF EMPTY(THIS.externalFileLocation)
         llRemove = .T.
      ELSE
         THIS.externalFileLocation = ADDBS(THIS.externalFileLocation)
      ENDIF

      IF ISNULL(THIS.XSLTParameters) AND NOT llRemove
         THIS.XSLTParameters = CREATEOBJECT("Collection")
      ENDIF

      IF NOT ISNULL(THIS.XSLTParameters)
         WITH THIS.XSLTParameters
            FOR liIndex = 1 TO .COUNT
               IF .GETKEY(liIndex) == "externalFileLocation"
                  .REMOVE(liIndex)
                  EXIT
               ENDIF
            NEXT
            IF NOT (llRemove)
               .ADD(THIS.externalFileLocation,"externalFileLocation")
            ENDIF
         ENDWITH   
      ENDIF

   ENDIF   
   
   
ENDIF   

ENDPROC
PROCEDURE checkreportforgeneralfields
LOCAL liGeneralFields, lcID, llOpened

liGeneralFields = 0

IF TYPE("THIS.CommandClauses.File") = "C" AND ;
   (NOT EMPTY(THIS.CommandClauses.File)) AND ;
   (FILE(THIS.CommandClauses.File)) && NB this is done before setting up dummy CommandClauses
   
   THIS.SetFRXDataSession()

   IF USED("FRX") 
      * this will be true
      * if we call in BeforeReport,
      * but that seems to cause a problem,
      * when we re-assign SendGDIPlusImage
      * so we're likely to call earlier,
      * in the LoadReport method
      SELECT FRX
   ELSE
      USE (THIS.CommandClauses.File) SHARED NOUPDATE ALIAS FRX IN 0
      SELECT FRX
      llOpened = .T.
   ENDIF   

   COUNT FOR ObjType = FRX_OBJTYP_PICTURE  AND  ;
           Offset =  FRX_PICTURE_SOURCE_GENERAL TO ;
             liGeneralFields

   IF llOpened
      USE IN FRX         
   ENDIF

   THIS.ResetDataSession()
ENDIF  

RETURN ( liGeneralFields > 0 )



ENDPROC
PROCEDURE imagesrcattr_assign
LPARAMETERS vNewVal
IF (NOT THIS.IsRunning) AND THIS.VerifyNCName(m.vNewVal) AND ;
   (NOT m.vNewVal == THIS.imageSrcAttr)
   THIS.imageSrcAttr = m.vNewVal
   THIS.SynchXSLTProcessorUser()
ENDIF      

ENDPROC
PROCEDURE imagefilebasename_assign
LPARAMETERS vNewVal
THIS.ImageFileBaseName = ALLTR(CHRTRAN(JUSTSTEM(TRANSFORM(m.vNewVal)),;
                         OUTPUTCLASS_FILENAME_CHARS_DISALLOWED,"_"))
ENDPROC
PROCEDURE copyimagefilestoexternalfilelocation_assign
LPARAMETERS vNewVal
IF NOT THIS.IsRunning and VARTYPE(vNewVal) = "L"
   IF NOT (m.vNewVal = THIS.CopyImageFilesToExternalFileLocation)
      LOCAL liIndex
      THIS.CopyImageFilesToExternalFileLocation = m.vNewVal
      IF ISNULL(THIS.XSLTParameters) 
         THIS.XSLTParameters = CREATEOBJECT("Collection")
      ENDIF
      IF NOT ISNULL(THIS.XSLTParameters)
         WITH THIS.XSLTParameters
            FOR liIndex = 1 TO .COUNT
               IF .GETKEY(liIndex) == "copyImageFiles"
                  .REMOVE(liIndex)
                  EXIT
               ENDIF
            NEXT
            .ADD(IIF(m.vNewVal,"1","0"),"copyImageFiles")
         ENDWITH   
      ENDIF
      
      IF THIS.CopyImageFilesToExternalFileLocation 
         IF EMPTY(THIS.ExternalFileLocation) OR ;
            NOT DIRECTORY(FULLPATH(JUSTPATH(THIS.TargetFileName),THIS.ExternalFileLocation))
            THIS.ExternalFileLocation = "."
         ENDIF
      ENDIF

   ENDIF   
   
ENDIF   

ENDPROC
PROCEDURE initializefilecopysettings
#define CLSID_JPG 	"{557CF401-1A04-11D3-9A73-0000F81EF32E}"


DECLARE INTEGER GdipSaveImageToFile in GDIPLUS.DLL  ;
       integer image,string filename,string @ CLSID_clsidEncoder,integer encoderParams        

IF ISNULL(THIS.Jpgclsid) OR EMPTY(THIS.Jpgclsid)
   DECLARE integer CLSIDFromString IN ole32 string,string @
   lcId = SPACE(20)
   CLSIDFromString(STRCONV(CLSID_JPG ,STRCONV_DBCS_UNICODE),@lcID)      
   THIS.Jpgclsid = lcID
   lcID = ""
ENDIF

IF THIS.SendGDIPlusImage < LISTENER_SEND_GDI_IMAGE_HANDLE 
   THIS.SendGDIPlusImage =   LISTENER_SEND_GDI_IMAGE_HANDLE
ENDIF   

IF EMPTY(THIS.ExternalFileLocation) OR ;
   NOT DIRECTORY(FULLPATH(JUSTPATH(THIS.TargetFileName),THIS.ExternalFileLocation))
   THIS.ExternalFileLocation = "."
ENDIF


ENDPROC
PROCEDURE Destroy
STORE NULL TO ;
   THIS.JPGclsid, ;
   THIS.FormattingChanges

DODEFAULT()


ENDPROC
PROCEDURE contattr_assign
LPARAMETERS vNewVal
LOCAL lcVal
lcVal = THIS.ContAttr
DODEFAULT(vNewVal)
IF NOT (lcVal == THIS.ContAttr)
   THIS.SynchXSLTProcessorUser()
ENDIF   
ENDPROC
PROCEDURE widthattr_assign
LPARAMETERS vNewVal
LOCAL lcVal
lcVal = THIS.WidthAttr
DODEFAULT(vNewVal)
IF NOT (lcVal == THIS.WidthAttr)
   THIS.SynchXSLTProcessorUser()
ENDIF   
ENDPROC
PROCEDURE heightattr_assign
LPARAMETERS vNewVal
LOCAL lcVal
lcVal = THIS.HeightAttr
DODEFAULT(vNewVal)
IF NOT (lcVal == THIS.HeightAttr)
   THIS.SynchXSLTProcessorUser()
ENDIF   
ENDPROC
PROCEDURE leftattr_assign
LPARAMETERS vNewVal
LOCAL lcVal
lcVal = THIS.LeftAttr
DODEFAULT(vNewVal)
IF NOT (lcVal == THIS.LeftAttr)
   THIS.SynchXSLTProcessorUser()
ENDIF   
ENDPROC
PROCEDURE topattr_assign
LPARAMETERS vNewVal
LOCAL lcVal
lcVal = THIS.TopAttr
DODEFAULT(vNewVal)
IF NOT (lcVal == THIS.TopAttr)
   THIS.SynchXSLTProcessorUser()
ENDIF   
ENDPROC
PROCEDURE idattribute_assign
LPARAMETERS vNewVal
LOCAL lcVal
lcVal = THIS.IdAttribute
DODEFAULT(vNewVal)
IF NOT (lcVal == THIS.IdAttribute)
   THIS.SynchXSLTProcessorUser()
ENDIF   
ENDPROC
PROCEDURE idrefattribute_assign
LPARAMETERS vNewVal
LOCAL lcVal
lcVal = THIS.IdRefAttribute
DODEFAULT(vNewVal)
IF NOT (lcVal == THIS.IdRefAttribute)
   THIS.SynchXSLTProcessorUser()
ENDIF   
ENDPROC
PROCEDURE Init
IF DODEFAULT()
   THIS.AppName = OUTPUTXMLDISPLAY_APPNAME_LOC
ELSE
   RETURN .F.   
ENDIF

RETURN NOT THIS.HadError
ENDPROC
PROCEDURE getrawformattinginfo
LPARAMETERS tnLeft, tnTop, tnWidth, tnHeight, tnObjectContinuationType
LOCAL lcInfo

lcInfo = DODEFAULT(tnLeft, tnTop, tnWidth, tnHeight, tnObjectContinuationType)
IF NOT EMPTY(THIS.ImageFieldtoFile) 
   lcInfo = lcInfo + " "+THIS.ImageSrcAttr+"='"+THIS.ImageFieldtoFile+"'"
ENDIF   

RETURN lcInfo
ENDPROC
PROCEDURE setdomformattinginfo
LPARAMETERS toNode, tnLeft, tnTop, tnWidth,tnHeight, tnObjectContinuationType

DODEFAULT( toNode, tnLeft, tnTop, tnWidth,tnHeight, tnObjectContinuationType)

IF NOT EMPTY(THIS.ImageFieldtoFile) 
   toNode.SetAttribute(THIS.ImageSrcAttr,THIS.ImageFieldtoFile )                  
ENDIF   

ENDPROC
PROCEDURE Render
LPARAMETERS nFRXRecNo, nLeft,nTop,nWidth,nHeight, nObjectContinuationType, cContentsToBeRendered, GDIPlusImage

LOCAL llCopyImage, lcFile

IF GDIPlusImage > 0 AND ;
  (ISNULL(THIS.Jpgclsid) OR EMPTY(THIS.Jpgclsid))
   * we didn't have any general fields but we do have
   * an image control, referenced as an expression,
   * they have explicitly turned on SendGDIPlusImage, and
   * this is the first time we're hitting an image control:
   THIS.initializeFileCopySettings()
ENDIF    


IF THIS.CopyImageFilesToExternalFileLocation 
   THIS.SetFRXDataSession()
   GO nFRXRecNo IN FRX

   IF (FRX.ObjType = FRX_OBJTYP_PICTURE) AND ;
      FRX.Offset # FRX_PICTURE_SOURCE_GENERAL AND ;
      FILE(cContentsToBeRendered)
      * use FILE() function here,
      * need to find if it is
      * built into an app
      llCopyImage = .T.
   ENDIF
ENDIF   

THIS.SetCurrentDataSession()   

DO CASE

CASE llCopyImage

   lcFile = FORCEPATH(cContentsToBeRendered, ;
            FULLPATH(THIS.ExternalFileLocation,ADDBS(JUSTPATH(THIS.TargetFileName))))
            
   IF EMPTY(SYS(2000,lcFile))
   
      * used to be:
      * COPY FILE (cContentsToBeRendered) TO (lcFile)
      * to handle files built into an app
      
      STRTOFILE(FILETOSTR(cContentsToBeRendered),lcFile)
    
   ENDIF   
   
   IF EMPTY(SYS(2000,lcFile))
      THIS.ImageFieldToFile = ""
   ELSE
      THIS.ImageFieldToFile = JUSTFNAME(lcFile)
   ENDIF
   
CASE THIS.SendGDIPlusImage > LISTENER_SEND_GDI_IMAGE_NONE  AND ;
   GDIPlusImage > 0  AND ;
   GdipSaveImageToFile(GDIPlusImage,;
       STRCONV(FORCEPATH(THIS.ImageFileBaseName + "_"+ ;
                         TRANSFORM(THIS.ImageFieldInstance+1)+".jpg",;
                         FULLPATH(THIS.ExternalFileLocation,ADDBS(JUSTPATH(THIS.TargetFileName))))+CHR(0), ;
               STRCONV_DBCS_UNICODE) ,THIS.JPGCLSID,0) = 0

   THIS.ImageFieldInstance = THIS.ImageFieldInstance + 1       

   THIS.ImageFieldToFile = THIS.ImageFileBaseName +"_"+ ;
                           TRANSFORM(THIS.ImageFieldInstance)+".jpg"

OTHERWISE

   THIS.ImageFieldToFile = ""

ENDCASE

DODEFAULT(nFRXRecNo, nLeft,nTop,nWidth,nHeight, ;
          nObjectContinuationType, cContentsToBeRendered, GDIPlusImage)
            
THIS.ImageFieldToFile = ""
ENDPROC
PROCEDURE UnloadReport
DODEFAULT()
IF NOT (THIS.noPageEject OR ;
 ((TYPE("THIS.CommandClauses.NoPageEject") = "L") AND ;
   THIS.CommandClauses.NoPageEject))
   IF NOT ISNULL(THIS.OldExternalFileLocation)
      * even if empty
      THIS.ExternalFileLocation = THIS.OldExternalFileLocation
      THIS.OldExternalFileLocation = NULL    
   ENDIF      
   IF NOT (THIS.OldSendGDIPlusImage = THIS.SendGDIPlusImage)
      THIS.SendGDIPlusImage = THIS.OldSendGDIPlusImage
   ENDIF   
ENDIF   
THIS.resetDataSession()


ENDPROC
PROCEDURE resetdocument
THIS.ResetToDefault("ImageFieldInstance")
THIS.ResetToDefault("ImageFieldToFile")
DODEFAULT()


ENDPROC
PROCEDURE BeforeReport
THIS.oldSendGDIPlusImage = THIS.SendGDIPlusImage     
THIS.oldExternalFileLocation =  THIS.ExternalFileLocation    
IF THIS.checkReportForGeneralFields() 
   THIS.initializeFileCopySettings()
ENDIF    
DODEFAULT()
THIS.resetDataSession()

ENDPROC
PROCEDURE getvfprdlcontents
LPARAMETERS tcNodeName, tlAsString

IF VARTYPE(THIS.CommandClauses) = "O"

   ADDPROPERTY(THIS.CommandClauses,;
             "externalFileLocation", ;
             THIS.externalFileLocation)
             
   ADDPROPERTY(THIS.CommandClauses, ;
            "copyImageFilesToExternalFileLocation", ;
            THIS.copyImageFilesToExternalFileLocation) 
            
   ADDPROPERTY(THIS.CommandClauses, ;
            "imageFileBaseName", ;
            THIS.imageFileBaseName)             
ENDIF            
            
RETURN DODEFAULT(tcNodeName, tlAsString)                         
ENDPROC


************************************************************
OBJETO: _reportlistener
************************************************************
*** PROPIEDADES ***
Height = 23
Width = 23
FRXDataSession = -1
AllowModalMessages = (INLIST(_VFP.Startmode, 0, 4))
QuietMode = (NOT INLIST(_VFP.Startmode, 0, 4))
appname = ("VFP Report Listener")
lasterrormessage = ("")
reportfilenames = .NULL.
reportclauses = .NULL.
listeners = .NULL.
listenerdatasession = 1
successor = (.NULL.)
sharedgdiplusgraphics = 0
sharedpageheight = 0
sharedpagewidth = 0
drivingalias = ("")
_memberdata =     3583<VFPData><memberdata name="addreport" type="method" display="addReport" favorites="True" /><memberdata name="appname" type="property" display="appName" favorites="True" /><memberdata name="clearerrors" type="method" display="clearErrors" favorites="True" /><memberdata name="drivingalias" type="property" display="drivingAlias" favorites="False" /><memberdata name="getfrxstartupinfo" type="method" display="getFRXStartupInfo" favorites="False" /><memberdata name="getlasterrormessage" type="method" display="getLastErrorMessage" favorites="True" /><memberdata name="haderror" type="property" display="hadError" favorites="False" /><memberdata name="invokeoncurrentpass" type="method" display="invokeOnCurrentPass" favorites="True" /><memberdata name="isrunning" type="property" display="isRunning" favorites="False" /><memberdata name="isrunningreports" type="property" display="isRunningReports" favorites="False" /><memberdata name="issuccessor" type="property" display="isSuccessor" favorites="True" /><memberdata name="lasterrormessage" type="property" display="lastErrorMessage" favorites="False" /><memberdata name="lignoreerrors" type="property" display="lIgnoreErrors" favorites="False" /><memberdata name="listeners" type="property" display="listeners" favorites="False" /><memberdata name="popglobalsets" type="method" display="popGlobalSets" favorites="False" /><memberdata name="prepareerrormessage" type="method" display="prepareErrorMessage" favorites="True" /><memberdata name="pushglobalsets" type="method" display="pushGlobalSets" favorites="False" /><memberdata name="removereports" type="method" display="removeReports" favorites="True" /><memberdata name="reportclauses" type="property" display="reportClauses" favorites="False" /><memberdata name="reportfilenames" type="property" display="reportFilenames" favorites="False" /><memberdata name="reportpages" type="property" display="reportPages" favorites="False" /><memberdata name="reportusesprivatedatasession" type="property" display="reportUsesPrivateDataSession" favorites="True" /><memberdata name="resetdatasession" type="method" display="resetDataSession" favorites="False" /><memberdata name="runreports" type="method" display="runReports" favorites="True" /><memberdata name="setcurrentdatasession" type="method" display="setCurrentDataSession" favorites="False" /><memberdata name="setfrxdatasession" type="method" display="setFRXDataSession" favorites="False" /><memberdata name="setfrxdatasessionenvironment" type="method" display="setFRXDataSessionEnvironment" favorites="False" /><memberdata name="setsuccessordynamicproperties" type="method" display="setSuccessorDynamicProperties" favorites="True" /><memberdata name="sharedgdiplusgraphics" type="property" display="sharedGdiplusGraphics" favorites="True" /><memberdata name="sharedpagetotal" type="property" display="sharedPageTotal" favorites="True" /><memberdata name="sharedoutputpagecount" type="property" display="sharedOutputPageCount" favorites="True" /><memberdata name="sharedpageno" type="property" display="sharedPageNo" favorites="True" /><memberdata name="sharedpageheight" type="property" display="sharedPageHeight" favorites="True" /><memberdata name="sharedpagewidth" type="property" display="sharedPageWidth" favorites="True" /><memberdata name="listenerdatasession" type="property" display="listenerDataSession" favorites="False" /><memberdata name="successor" type="property" display="successor" favorites="True" /><memberdata name="setfrxrunstartupconditions" type="method" display="setFRXRunStartupConditions"/></VFPData>
sharedoutputpagecount = 0
sharedpageno = 0
sharedpagetotal = 0
Name = "_reportlistener"

*** METODOS ***
PROCEDURE allowmodalmessages_assign
LPARAMETERS vNewVal
IF VARTYPE(m.vNewVal) = "L"
   THIS.AllowModalMessages = m.vNewVal
ENDIF   


ENDPROC
PROCEDURE lignoreerrors_assign
LPARAMETERS vNewVal
IF VARTYPE(m.vNewVal) = "L"
   THIS.lIgnoreErrors = m.vNewVal
ENDIf   


ENDPROC
PROCEDURE prepareerrormessage
LPARAMETERS nError, cMethod, nLine, cName, cMessage, cCodeLine

LOCAL lcErrorMessage, lcCodeLineMsg

IF VARTYPE(cMessage) = "C"
   lcErrorMessage = cMessage
ELSE
   lcErrorMessage = MESSAGE()
ENDIF

lcErrorMessage = lcErrorMessage + CHR(13) + CHR(13)

IF VARTYPE(cName) = "C"
   lcErrorMessage = lcErrorMessage + cName
ELSE
   lcErrorMessage = lcErrorMessage + this.Name
ENDIF

lcErrorMessage = lcErrorMessage + CHR(13)+ ;
 		 OUTPUTCLASS_ERRNOLABEL_LOC +ALLTRIM(STR(nError))+CHR(13)+ ;
		 OUTPUTCLASS_ERRPROCLABEL_LOC +LOWER(ALLTRIM(cMethod))
		
IF VARTYPE(cCodeLine) = "C"
   lcCodeLineMsg = cCodeLine
ELSE
   lcCodeLineMsg = MESSAGE(1)
ENDIF		

IF BETWEEN(nLine,1,100000) AND NOT lcCodeLineMsg="..."
	lcErrorMessage= ;
       lcErrorMessage+CHR(13)+ OUTPUTCLASS_ERRLINELABEL_LOC+ ;
	    ALLTRIM(STR(nLine))
	IF NOT EMPTY(lcCodeLineMsg)
       lcErrorMessage= ;
		   lcErrorMessage+CHR(13)+CHR(13)+lcCodeLineMsg
	ENDIF
ENDIF

RETURN lcErrorMessage
ENDPROC
PROCEDURE pushglobalsets
  * abstract: set any globals here that aren't session-bound

ENDPROC
PROCEDURE popglobalsets
* abstract: restore any globals here that aren't session-bound      


ENDPROC
PROCEDURE clearerrors
THIS.HadError = .F.
THIS.LastErrorMessage = ""
ENDPROC
PROCEDURE getlasterrormessage
RETURN THIS.LastErrorMessage
ENDPROC
PROCEDURE addreport
LPARAMETERS tcFRXName, tcClauses, toListener

* can this one be done while report is running?
* Possibly yes because we're always adding to the end.

IF VARTYPE(tcFrxName) = "C" AND ;
   (FILE(tcFRXName) OR FILE(FORCEEXT(tcFRXName,"FRX")) OR FILE(FORCEEXT(tcFRXName,"LBX")))

   * If any is null, create all collections
   * always add to all three collections
   * to keep them in synch
   
   IF ISNULL(THIS.ReportFileNames) OR ;
      ISNULL(THIS.ReportClauses) OR ;
      ISNULL(THIS.Listeners) 
      * start fresh
      THIS.ReportFileNames = CREATEOBJECT("Collection")
      THIS.ReportClauses = CREATEOBJECT("Collection")
      THIS.Listeners = CREATEOBJECT("Collection")
      DIME THIS.ReportPages[1]
   ENDIF
   
   THIS.ReportFileNames.Add(tcFRXName)
   
   DIME THIS.ReportPages[THIS.ReportFileNames.Count]
   THIS.ReportPages[THIS.ReportFileNames.Count] = 0

   IF VARTYPE(tcClauses) = "C"
      THIS.ReportClauses.Add(tcClauses)
   ELSE
      THIS.ReportClauses.Add("")   
   ENDIF

   IF TYPE("toListener.BaseClass") = "C" AND ;
      UPPER(toListener.BaseClass) == "REPORTLISTENER"
      THIS.Listeners.Add(toListener)
   ELSE
      THIS.Listeners.Add(NULL)      
   ENDIF
   
ELSE

   * TBD: should we error here?   
   
ENDIF   


ENDPROC
PROCEDURE removereports
IF NOT (THIS.IsRunningReports)
   THIS.ReportFileNames = NULL
   THIS.ReportClauses = NULL
   THIS.Listeners = NULL
   DIME THIS.ReportPages[1]
   THIS.ReportPages[1] = 0
   
ENDIF   
ENDPROC
PROCEDURE runreports
LPARAMETERS tlRemoveReportsAfterRun, tlOmitListenerReferences

IF NOT ;
 (THIS.IsRunningReports OR ;
  ISNULL(THIS.ReportFileNames) OR ;
  THIS.ReportFileNames.Count = 0)

  LOCAL oError, liIndex, lcClauses, loListener
  oError = NULL

  THIS.IsRunningReports = .T.

  TRY 
  
    FOR liIndex = 1 TO THIS.ReportFileNames.Count
       * these collections are 
       * protected properties, we're
       * taking care of how they match up, 
       * that FRXs exist, etc.
       lcClauses = UPPER(THIS.ReportClauses[liIndex])
       loListener = THIS.Listeners[liIndex]
       DO CASE 
       CASE " OBJE " $ STRTRAN(" "+lcClauses,"CT", " ") OR ;
            " OBJEC " $ " "+lcClauses OR ;
            tlOmitListenerReferences
          REPORT FORM (THIS.ReportFileNames[liIndex]) &lcClauses  
       CASE ISNULL(loListener)
          REPORT FORM (THIS.ReportFileNames[liIndex]) &lcClauses  OBJECT THIS
       OTHERWISE
          REPORT FORM (THIS.ReportFileNames[liIndex]) &lcClauses  OBJECT loListener
       ENDCASE
       IF NOT (" NOWA " $ STRTRAN(" "+lcClauses,"IT"," ") OR ;
               " NOWAI " $ " " + lcClauses) 
          THIS.ReportPages[liIndex] = THIS.SharedPageTotal
          * TBD: make this a two-column array with 
          * output pages (responsive to RANGE clause)
          * represented as well?
       ENDIF
    ENDFOR
    
         
  CATCH TO oError
     IF NOT (ISNULL(oError))
         THIS.DoMessage(;
               THIS.PrepareErrorMessage(;
               oError.ErrorNo, ;
               oError.PROCEDURE, ;
               oError.LINENO, ;
               THIS.AppName, ;
               oError.MESSAGE, ;
               oError.LineContents), ;
               MB_ICONSTOP )
        #IF OUTPUTCLASS_DEBUGGING
         SUSPEND
        #ENDIF                   
         EXIT  
      ENDIF
  FINALLY
  
     THIS.IsRunningReports = .F.  
     IF tlRemoveReportsAfterRun
       THIS.RemoveReports()
     ENDIF  
     STORE NULL TO loListener, oError

  ENDTRY
  
  
ENDIF   





ENDPROC
PROCEDURE setfrxdatasessionenvironment
THIS.setFRXDataSession()
SET TALK OFF 
ENDPROC
PROCEDURE invokeoncurrentpass
RETURN .T.
ENDPROC
PROCEDURE resetdatasession
IF (THIS.listenerDataSession > -1) 
   TRY
      SET DATASESSION TO (THIS.listenerDataSession)
   CATCH WHEN .T.
      THIS.ResetToDefault("listenerDataSession")
      SET DATASESSION TO (THIS.listenerDataSession)      
   ENDTRY
ENDIF   

ENDPROC
PROCEDURE setfrxdatasession
IF (THIS.FRXDataSession > -1) AND (THIS.FRXDataSession # SET("DATASESSION"))

   TRY
      SET DATASESSION TO (THIS.FRXDataSession)
   CATCH WHEN .T.
      THIS.ResetToDefault("FRXDataSession")
      THIS.resetDataSession()
   ENDTRY
   
ENDIF   

ENDPROC
PROCEDURE setcurrentdatasession
IF (THIS.CurrentDataSession # SET("DATASESSION"))  
   TRY
      SET DATASESSION TO (THIS.CurrentDataSession)
   CATCH WHEN .T.
      THIS.ResetToDefault("CurrentDataSession")
      THIS.resetDataSession()
   ENDTRY
ENDIF   


ENDPROC
PROCEDURE quietmode_assign
LPARAMETERS vNewVal
IF VARTYPE(m.vNewVal) = "L"
   THIS.quietmode = m.vNewVal
ENDIF 
ENDPROC
PROCEDURE issuccessor_assign
LPARAMETERS vNewVal
IF VARTYPE(vNewVal) = "L"
   THIS.isSuccessor = m.vNewVal
ENDIF   

ENDPROC
PROCEDURE successor_assign
LPARAMETERS vNewVal
IF (NOT THIS.IsRunning) AND ;
   (ISNULL(vNewVal) OR ;
   (VARTYPE(vNewVal) = "O" AND UPPER(vNewVal.BaseClass) == "REPORTLISTENER"))
   THIS.Successor = m.vNewVal
ENDIF   


ENDPROC
PROCEDURE getfrxstartupinfo
THIS.SetFRXDataSession()
IF USED("FRX")
   SELECT FRX
   LOCATE FOR ObjType = FRX_OBJTYP_DATAENV 
   THIS.ReportUsesPrivateDataSession = Frx.Environ
   * could also use 
   * THIS.CommandClauses.StartDataSession # THIS.CurrentDataSession
ELSE
   THIS.ReportUsesPrivateDataSession = .F.   
ENDIF   
THIS.SetCurrentDataSession()
IF THIS.reportUsesPrivateDataSession
   SET TALK OFF
ENDIF
THIS.DrivingAlias = UPPER(ALIAS())
ENDPROC
PROCEDURE setsuccessordynamicproperties
IF NOT THIS.isSuccessor
   THIS.sharedOutputPageCount = THIS.OutputPageCount
   THIS.sharedPageTotal = THIS.PageTotal
   THIS.sharedPageNo = THIS.PageNo
   THIS.sharedGdiplusGraphics = THIS.GDIPlusGraphics 
ENDIF
WITH THIS.Successor
   .CurrentPass = THIS.CurrentPass
   .TwoPassProcess = THIS.TwoPassProcess   
   .sharedOutputPageCount = THIS.sharedOutputPageCount
   .sharedPageTotal = THIS.sharedPageTotal   
   .sharedPageNo = THIS.sharedPageNo
   .sharedGdiplusGraphics  = THIS.sharedGdiplusGraphics
ENDWITH   

ENDPROC
PROCEDURE appname_assign
LPARAMETERS vNewVal
IF VARTYPE(vNewVal) = "C"
   THIS.appname = m.vNewVal
ENDIF   

ENDPROC
PROCEDURE sharedgdiplusgraphics_assign
LPARAMETERS vNewVal
IF VARTYPE(vNewVal) = "N"
   THIS.SharedGDIplusGraphics = m.vNewVal
ENDIF   

ENDPROC
PROCEDURE sharedpageheight_assign
LPARAMETERS vNewVal
IF VARTYPE(vNewVal) = "N"
   THIS.sharedPageHeight = m.vNewVal
ENDIF   

ENDPROC
PROCEDURE sharedpagewidth_assign
LPARAMETERS vNewVal
IF VARTYPE(vNewVal) = "N"
   THIS.sharedPageWidth = m.vNewVal
ENDIF   

ENDPROC
PROCEDURE listenertype_assign
LPARAMETERS vNewVal
IF THIS.SupportsListenerType(vNewVal) AND ;
   NOT THIS.IsRunning
   THIS.ListenerType = m.vNewVal
ENDIF

ENDPROC
PROCEDURE outputtype_assign
LPARAMETERS vNewVal
IF VARTYPE(vNewVal) = "N" AND NOT THIS.IsRunning
   THIS.OutputType = INT(m.vNewVal)
   IF THIS.SupportsListenerType(THIS.OutputType) 
      THIS.ListenerType = THIS.OutputType
   ENDIF    
ENDIF

ENDPROC
PROCEDURE sharedoutputpagecount_assign
LPARAMETERS vNewVal
IF VARTYPE(vNewVal) = "N"
   THIS.sharedOutputPageCount = m.vNewVal
ENDIF   

ENDPROC
PROCEDURE sharedpageno_assign
LPARAMETERS vNewVal
IF VARTYPE(vNewVal) = "N"
   THIS.sharedPageNo = m.vNewVal
ENDIF   

ENDPROC
PROCEDURE sharedpagetotal_assign
LPARAMETERS vNewVal
IF VARTYPE(vNewVal) = "N"
   THIS.sharedPageTotal = m.vNewVal
ENDIF   

ENDPROC
PROCEDURE setfrxrunstartupconditions
IF ISNULL(THIS.CommandClauses)
   THIS.CommandClauses = CREATEOBJECT("Empty")
ENDIF
IF TYPE("THIS.CommandClauses.NoDialog") # "L"
   ADDPROPERTY(THIS.CommandClauses,"NoDialog",.F.)
ENDIF      


* add anything critical during a run
* that might not be available, whether
* because this is a custom attribute
* or because public methods of ReportListener
* might be called outside a normal report run.
ENDPROC
PROCEDURE DoStatus
LPARAMETERS cMessage
NODEFAULT
IF NOT (THIS.QuietMode OR (THIS.IsRunning AND THIS.CommandClauses.Nodialog))
   IF THIS.TwoPassProcess AND THIS.CurrentPass = 0
      WAIT WINDOW NOWAIT OUTPUTCLASS_PREPSTATUS_LOC 
   ELSE
      IF VARTYPE(cMessage) = "C"
         DODEFAULT(cMessage)      
      ENDIF
   ENDIF
ENDIF
ENDPROC
PROCEDURE LoadReport
THIS.clearErrors()

THIS.setFRXDataSessionEnvironment()

THIS.resetDataSession()
   
IF NOT ISNULL(THIS.Successor)
   WITH THIS.Successor
      .AddProperty("IsSuccessor",.T.)
      .OutputType = THIS.OutputType
      .PrintJobName = THIS.PrintJobName 
      .CommandClauses = THIS.CommandClauses
      .LoadReport()
   ENDWITH
ENDIF
   
ENDPROC
PROCEDURE ClearStatus
DODEFAULT()
IF NOT ISNULL(THIS.Successor)
   THIS.SetSuccessorDynamicProperties()
   THIS.Successor.ClearStatus()
ENDIF   
ENDPROC
PROCEDURE UpdateStatus
DODEFAULT()
IF NOT ISNULL(THIS.Successor)
   THIS.SetSuccessorDynamicProperties()
   THIS.Successor.UpdateStatus()
ENDIF   
ENDPROC
PROCEDURE UnloadReport
IF NOT THIS.IsSuccessor
   THIS.SharedPageWidth = THIS.GetPageWidth()
   THIS.SharedPageHeight = THIS.GetPageHeight()
ENDIF

THIS.resetDataSession()

IF NOT ISNULL(THIS.Successor)

   WITH THIS.Successor
      .FRXDataSession = THIS.FRXDataSession
      .CurrentDataSession = THIS.CurrentDataSession
      .TwoPassProcess = THIS.TwoPassProcess
      .CommandClauses = THIS.CommandClauses
      .SharedPageHeight = THIS.SharedPageHeight
      .SharedPageWidth = THIS.SharedPageWidth
      THIS.SetSuccessorDynamicProperties()      
      .UnloadReport()
      .IsSuccessor = .F.
   ENDWITH
   
ENDIF

   
ENDPROC
PROCEDURE CancelReport
IF NOT THIS.IsSuccessor
   DODEFAULT()
   NODEFAULT
ENDIF   
IF NOT ISNULL(THIS.Successor)
   THIS.SetSuccessorDynamicProperties()
   THIS.Successor.CancelReport()
ENDIF

ENDPROC
PROCEDURE AfterReport
IF NOT THIS.IsSuccessor
   THIS.SharedPageWidth = THIS.GetPageWidth()
   THIS.SharedPageHeight = THIS.GetPageHeight()
ENDIF

IF NOT ISNULL(THIS.Successor)
   WITH THIS.Successor
      .FRXDataSession = THIS.FRXDataSession
      .CurrentDataSession = THIS.CurrentDataSession
      .TwoPassProcess = THIS.TwoPassProcess
      .CommandClauses = THIS.CommandClauses
      .SharedPageHeight = THIS.SharedPageHeight
      .SharedPageWidth = THIS.SharedPageWidth
      THIS.SetSuccessorDynamicProperties()
      .AfterReport()
   ENDWITH
ENDIF
IF NOT THIS.IsSuccessor
   NODEFAULT
   DODEFAULT()
ENDIF   


ENDPROC
PROCEDURE Init
THIS.listenerDataSession = SET("DATASESSION")  

IF DODEFAULT() 
   THIS.AppName = OUTPUTCLASS_APPNAME_LOC
ELSE
   RETURN .F.
ENDIF      

RETURN NOT THIS.HadError
ENDPROC
PROCEDURE BeforeBand
LPARAMETERS nBandObjCode, nFRXRecNo

IF NOT ISNULL(THIS.Successor)
   THIS.SetSuccessorDynamicProperties()
   THIS.Successor.BeforeBand(nBandObjCode, nFRXRecNo)
ENDIF

ENDPROC
PROCEDURE DoMessage
LPARAMETERS cMessage,iParams,cTitle
NODEFAULT
IF THIS.QuietMode OR ;
  (THIS.IsRunning AND THIS.CommandClauses.NoDialog)
   * to emulate the base class behavior, do both checks,
   * in case the call to DoMessage() occurs
   * before the baseclass sets QuietMode .T. in response
   * to NoDialog at the beginning of the report run,
   * or after the baseclass re-sets Quietmode to .F.
   * at the end of the report run.
   RETURN 0
ELSE
   IF THIS.AllowModalMessages
      IF VARTYPE(cTitle) = "C"
         RETURN MESSAGEBOX(TRANS(cMessage),VAL(TRANS(iParams)),cTitle)
      ELSE
         RETURN MESSAGEBOX(TRANS(cMessage),VAL(TRANS(iParams)),THIS.AppName)
      ENDIF
   ELSE
      THIS.DoStatus(cMessage)
      RETURN 0
   ENDIF
ENDIF   
ENDPROC
PROCEDURE Error
LPARAMETERS nError, cMethod, nLine
LOCAL lcOnError,lcErrorMsg,lcCodeLineMsg
THIS.HadError = .T.
IF this.lIgnoreErrors OR _vfp.StartMode>0
	RETURN .F.
ENDIF
lcOnError=UPPER(ALLTRIM(ON("ERROR")))
IF NOT EMPTY(lcOnError)
	lcOnError=STRTRAN(STRTRAN(STRTRAN(lcOnError,"ERROR()","nError"), ;
			"PROGRAM()","cMethod"),"LINENO()","nLine")
	&lcOnError
	RETURN
ENDIF
lcErrorMsg = THIS.PrepareErrorMessage(nError,cMethod, nLine)
THIS.LastErrorMessage = lcErrorMsg

THIS.DoMessage(lcErrorMsg, MB_ICONSTOP )

#IF OUTPUTCLASS_DEBUGGING
    ERROR nError
#ENDIF    
ENDPROC
PROCEDURE BeforeReport
THIS.setFRXRunStartupConditions()

THIS.getFRXStartupInfo()

THIS.resetDataSession()

IF NOT THIS.IsSuccessor
   THIS.sharedPageHeight = THIS.GetPageHeight()
   THIS.sharedPageWidth = THIS.GetPageWidth()
ENDIF

IF NOT ISNULL(THIS.Successor)
   WITH THIS.Successor
      .AddProperty("sharedGDIPlusGraphics", THIS.sharedGDIPlusGraphics)      
      .AddProperty("sharedPageHeight", THIS.sharedPageHeight)
      .AddProperty("sharedPageWidth", THIS.sharedPageWidth)      
      .AddProperty("sharedOutputPageCount", THIS.sharedOutputPageCount)
      .AddProperty("sharedPageNo", THIS.sharedPageNo)      
      .AddProperty("sharedPageTotal", THIS.sharedPageTotal)    
       THIS.setSuccessorDynamicProperties()        
      .FRXDataSession = THIS.FRXDataSession
      .CurrentDataSession = THIS.CurrentDataSession
      .TwoPassProcess = THIS.TwoPassProcess
      .CommandClauses = THIS.CommandClauses
      .BeforeReport()
   ENDWITH
ENDIF


ENDPROC
PROCEDURE Destroy
STORE NULL TO ;
  THIS.Successor, ;
  THIS.Listeners, ;
  THIS.ReportClauses, ;
  THIS.ReportFileNames, ;
  THIS.PreviewContainer, ;
  THIS.CommandClauses

ENDPROC
PROCEDURE AfterBand
LPARAMETERS nBandObjCode, nFRXRecno
IF NOT ISNULL(THIS.Successor)
   THIS.SetSuccessorDynamicProperties()
   THIS.Successor.AfterBand(nBandObjCode, nFRXRecNo)
ENDIF

ENDPROC
PROCEDURE Render
LPARAMETERS nFRXRecno, nLeft, nTop, nWidth, nHeight, nObjectContinuationType, cContentsToBeRendered, GDIPlusImage
IF NOT ISNULL(THIS.Successor)
   THIS.SetSuccessorDynamicProperties()
   THIS.Successor.Render(nFRXRecno, nLeft, nTop, nWidth, nHeight, nObjectContinuationType, cContentsToBeRendered, GDIPlusImage)
ENDIF


ENDPROC


************************************************************
OBJETO: htmllistener
************************************************************
*** PROPIEDADES ***
FRXDataSession = -1
applyusertransform = .T.
targetfileext = ("HTM")
_memberdata =     1318<VFPData> <memberdata name="copyimagefilestoexternalfilelocation" type="property" display="copyImageFilesToExternalFileLocation" favorites="True" /> <memberdata name="externalfilelocation" type="property" display="externalFileLocation" favorites="True" /> <memberdata name="imagefieldinstance" type="property" display="imageFieldInstance" favorites="False" /> <memberdata name="imagefieldtofile" type="property" display="imageFieldToFile" favorites="False" /> <memberdata name="imagefilebasename" type="property" display="imageFileBaseName" favorites="True" /> <memberdata name="imagesrcattr" type="property" display="imageSrcAttr" favorites="True" /> <memberdata name="jpgclsid" type="property" display="JPGclsid" favorites="False" /> <memberdata name="oldexternalfilelocation" type="property" display="oldExternalFileLocation" favorites="False" /> <memberdata name="oldsendgdiplusimage" type="property" display="oldSendGDIPlusImage" favorites="False" /> <memberdata name="checkreportforgeneralfields" type="method" display="checkReportForGeneralFields" favorites="False" /><memberdata name="getdefaultuserxsltasstring" type="method" display="getDefaultUserXsltAsString" favorites="False" /><memberdata name="initializefilecopysettings" type="method" display="initializeFileCopySettings" favorites="False"/></VFPData>
Name = "htmllistener"

*** METODOS ***
PROCEDURE getdefaultuserxsltasstring
LOCAL lcResult
SET TEXTMERGE TO MEMVAR lcResult NOSHOW
SET TEXTMERGE ON 
TEXT
<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
   <xsl:output method="html" version="1.0" encoding="UTF-8" indent="no" doctype-public="-//W3C//DTD HTML 4.0//EN" doctype-system="http://www.w3.org/TR/REC-html40/strict.dtd"/>
   <xsl:param name="externalFileLocation"/>
   <!--select="'./whatever/'" or 'http://something/myimages/' or "'./'" or... -->
   <xsl:param name="copyImageFiles" select="0"/>
   <xsl:param name="generalFieldDPI" select="96"/>
   <xsl:param name="fillPatternShade" select="180*3"/>
   <xsl:param name="fillPatternOffset" select="128"/>
   <xsl:param name="numberPrecision" select="5"/>
   <xsl:param name="useTextAreaForStretchingText" select="1"/>
   <xsl:param name="PageTitlePrefix_LOC" select="''"/>
    
    <xsl:variable name="FRUs" select="10000"/>
   <xsl:variable name="printDPI" select="960"/>
   <xsl:variable name="FRUsInPixelsat96DPI" select="104.167"/>
   <xsl:variable name="imagePixelRatio" select="$generalFieldDPI div $printDPI"/>
   <xsl:variable name="zeros" select="substring('0000000000000000000000000',1,$numberPrecision)"/>
   <xsl:variable name="thisPageHeight">
      <xsl:value-of select="number(/Reports/VFP-Report/VFP-RDL/VFPDataSet/VFPFRXPrintJob/@pageheight  div $printDPI)"/>
   </xsl:variable>
   <xsl:variable name="lineNodeName" select="/Reports/VFP-Report/VFP-RDL/VFPDataSet/VFPFRXLayoutNode[type=6]/name"/>
   <xsl:variable name="labelNodeName" select="/Reports/VFP-Report/VFP-RDL/VFPDataSet/VFPFRXLayoutNode[type=5]/name"/>
   <xsl:variable name="fieldNodeName" select="/Reports/VFP-Report/VFP-RDL/VFPDataSet/VFPFRXLayoutNode[type=8]/name"/>
   <xsl:variable name="shapeNodeName" select="/Reports/VFP-Report/VFP-RDL/VFPDataSet/VFPFRXLayoutNode[type=7]/name"/>
   <xsl:variable name="pictureNodeName" select="/Reports/VFP-Report/VFP-RDL/VFPDataSet/VFPFRXLayoutNode[type=17]/name"/>
   <xsl:variable name="detailNodeName" select="/Reports/VFP-Report/VFP-RDL/VFPDataSet/VFPFRXLayoutNode[code=4]/name"/>
   <xsl:variable name="detailHeaderNodeName" select="/Reports/VFP-Report/VFP-RDL/VFPDataSet/VFPFRXLayoutNode[code=9]/name"/>
   <xsl:variable name="detailFooterNodeName" select="/Reports/VFP-Report/VFP-RDL/VFPDataSet/VFPFRXLayoutNode[code=10]/name"/>
   <xsl:variable name="pageHeaderNodeName" select="/Reports/VFP-Report/VFP-RDL/VFPDataSet/VFPFRXLayoutNode[code=1]/name"/>
   <xsl:variable name="pageFooterNodeName" select="/Reports/VFP-Report/VFP-RDL/VFPDataSet/VFPFRXLayoutNode[code=7]/name"/>
   <xsl:variable name="columnHeaderNodeName" select="/Reports/VFP-Report/VFP-RDL/VFPDataSet/VFPFRXLayoutNode[code=2]/name"/>
   <xsl:variable name="columnFooterNodeName" select="/Reports/VFP-Report/VFP-RDL/VFPDataSet/VFPFRXLayoutNode[code=6]/name"/>
   <xsl:variable name="groupHeaderNodeName" select="/Reports/VFP-Report/VFP-RDL/VFPDataSet/VFPFRXLayoutNode[code=3]/name"/>
   <xsl:variable name="groupFooterNodeName" select="/Reports/VFP-Report/VFP-RDL/VFPDataSet/VFPFRXLayoutNode[code=5]/name"/>
   <xsl:variable name="titleNodeName" select="/Reports/VFP-Report/VFP-RDL/VFPDataSet/VFPFRXLayoutNode[code=0]/name"/>
   <xsl:variable name="summaryNodeName" select="/Reports/VFP-Report/VFP-RDL/VFPDataSet/VFPFRXLayoutNode[code=8]/name"/>
   <xsl:key name="Layout" match="/Reports/VFP-Report/VFP-RDL/VFPDataSet/VFPFRXLayoutObject[platform='WINDOWS']" use="concat(frxrecno,../../@id)"/>


   <xsl:template match="/">
      <html>
         <head>
            <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8"/>
            <!-- necessary because some versions of MSXML xslt processing don't include the charset as required by the XSLT standard when method="html".  Explicitly including the META creates a doubled meta tag, but we do need the encoding to be specified properly. -->

            <xsl:for-each select="/Reports/VFP-Report">
               <xsl:call-template name="Styles">
                  <xsl:with-param name="thisReport" select="position()"/>
                  <xsl:with-param name="thisReportID" select="./VFP-RDL/@id"/>
               </xsl:call-template>
            </xsl:for-each>
            <!--        <xsl:call-template name="Script"/> avoid security problems: no script -->
            <title><xsl:value-of select="$PageTitlePrefix_LOC"/><xsl:if test="string-length(/Reports/VFP-Report[1]/VFP-RDL/VFPDataSet/VFPFRXPrintJob/@name) = 0">
                  <xsl:value-of select="/Reports/VFP-Report[1]/VFP-RDL/@id"/>
               </xsl:if>
               <xsl:value-of select="/Reports/VFP-Report[1]/VFP-RDL/VFPDataSet/VFPFRXPrintJob/@name"/>
            </title>
         </head>
         <body>
            <xsl:for-each select="/Reports/VFP-Report">
               <xsl:variable name="thisReport" select="position()"/>
               <xsl:variable name="thisReportID" select="./VFP-RDL/@id"/>
               <xsl:variable name="thisReportRangeFrom" select="number(./VFP-RDL/VFPDataSet/VFPFRXCommand/@RANGEFROM)"/>
               <xsl:if test="./Data/*[name()=$titleNodeName] and ./VFP-RDL/VFPDataSet/VFPFRXLayoutObject[bandtype='0' and pagebreak='true']">
                  <xsl:apply-templates select="./Data/*[name()=$titleNodeName]" mode="titlesummarypage">
                     <xsl:with-param name="thisReport" select="$thisReport"/>
                     <xsl:with-param name="thisReportID" select="$thisReportID"/>
                  </xsl:apply-templates>
               </xsl:if>
               <xsl:apply-templates select="./Data/*[name()=$pageHeaderNodeName]" mode="page">
                  <xsl:with-param name="thisReport" select="$thisReport"/>
                  <xsl:with-param name="thisReportID" select="$thisReportID"/>
                  <xsl:with-param name="thisReportRangeFrom" select="$thisReportRangeFrom"/>
               </xsl:apply-templates>
               <xsl:if test="./Data/*[name()=$summaryNodeName] and ./VFP-RDL/VFPDataSet/VFPFRXLayoutObject[bandtype='8' and pagebreak='true' and ejectbefor='false']">
                  <xsl:apply-templates select="./Data/*[name()=$summaryNodeName]" mode="titlesummarypage">
                     <xsl:with-param name="thisReport" select="$thisReport"/>
                     <xsl:with-param name="thisReportID" select="$thisReportID"/>
                  </xsl:apply-templates>
               </xsl:if>
            </xsl:for-each>
         </body>
      </html>
   </xsl:template>
   <xsl:template match="/Reports/VFP-Report/Data/*" mode="titlesummarypage">
      <xsl:param name="thisReport" select="1"/>
      <xsl:param name="thisReportID"/>
      <xsl:param name="thisReportRangeFrom" select="1"/>
      <xsl:variable name="thisBand" select="@id"/>
      <div>
         <xsl:attribute name="style"> width:100%;top:<xsl:value-of select="$thisPageHeight * (number( ./@idref) -$thisReportRangeFrom)"/>in;page-break-after:always;page-break-inside:avoid; position:absolute; </xsl:attribute>
         <xsl:apply-templates select="." mode="band">
            <xsl:with-param name="thisReport" select="$thisReport"/>
            <xsl:with-param name="thisReportID" select="$thisReportID"/>
         </xsl:apply-templates>
         <xsl:if test="/Reports/VFP-Report[$thisReport]/VFP-RDL/VFPDataSet/VFPFRXLayoutObject[frxrecno=$thisBand and ejectafter='true']">
            <!-- page footer for this summary page -->
            <xsl:apply-templates select="/Reports/VFP-Report[$thisReport]/Data/*[name()=$pageFooterNodeName][position()=last()]" mode="band">
               <xsl:with-param name="thisReport" select="$thisReport"/>
               <xsl:with-param name="thisReportID" select="$thisReportID"/>
            </xsl:apply-templates>
         </xsl:if>
      </div>
   </xsl:template>
   <xsl:template match="/Reports/VFP-Report/Data/*" mode="page">
      <xsl:param name="thisReport" select="1"/>
      <xsl:param name="thisReportID"/>
      <xsl:param name="thisReportRangeFrom" select="1"/>
      <xsl:variable name="thisPage" select="@id"/>
      <div>
         <xsl:attribute name="style"> width:100%;top:<xsl:value-of select="$thisPageHeight * ($thisPage -$thisReportRangeFrom)"/>in;page-break-after:always;page-break-inside:avoid; position:absolute; </xsl:attribute>
         <xsl:apply-templates select="." mode="band">
            <xsl:with-param name="thisReport" select="$thisReport"/>
            <xsl:with-param name="thisReportID" select="$thisReportID"/>
         </xsl:apply-templates>
         <xsl:if test="$thisPage = 1 and /Reports/VFP-Report[$thisReport]/Data/*[name()=$titleNodeName] and /Reports/VFP-Report[$thisReport]/VFP-RDL/VFPDataSet/VFPFRXLayoutObject[bandtype='0' and pagebreak='false']">
            <xsl:apply-templates select="/Reports/VFP-Report[$thisReport]/Data/*[name()=$titleNodeName]" mode="band">
               <xsl:with-param name="thisReport" select="$thisReport"/>
               <xsl:with-param name="thisReportID" select="$thisReportID"/>
            </xsl:apply-templates>
         </xsl:if>
         <xsl:apply-templates select="/Reports/VFP-Report/Data/*[( (@id=$thisPage and contains(concat('|',$pageFooterNodeName,'|',$columnHeaderNodeName,'|',$columnFooterNodeName,'|'),concat('|',name(),'|'))) or (@idref=$thisPage and contains(concat('|',$detailHeaderNodeName,'|',$detailFooterNodeName,'|',$detailNodeName,'|',$groupHeaderNodeName,'|',$groupFooterNodeName,'|',$summaryNodeName,'|'),concat('|',name(),'|'))) )]" mode="band">
            <xsl:with-param name="thisReport" select="$thisReport"/>
            <xsl:with-param name="thisReportID" select="$thisReportID"/>
         </xsl:apply-templates>
      </div>
   </xsl:template>
   <xsl:template match="/Reports/VFP-Report/Data/*" mode="band">
      <xsl:param name="thisReport" select="1"/>
      <xsl:param name="thisReportID"/>
      <xsl:for-each select="./*">
         <xsl:variable name="thisID" select="translate(@id,'+','')"/>
         <!--        <xsl:if test="key('Layout',concat($thisID, $thisReportID))/vpos &gt; key('Layout',preceding-sibling::*/concat(@id,$thisReportID))/vpos"><div style="position=absolute;"/></xsl:if>  -->
         <xsl:call-template name="Render">
            <xsl:with-param name="thisID" select="$thisID"/>
            <xsl:with-param name="thisZ" select="position()"/>
            <xsl:with-param name="thisPage" select="../@idref"/>
            <xsl:with-param name="thisReport" select="$thisReport"/>
            <xsl:with-param name="thisReportID" select="$thisReportID"/>
         </xsl:call-template>
      </xsl:for-each>
   </xsl:template>
   <xsl:template name="Render">
      <xsl:param name="thisID"/>
      <xsl:param name="thisZ"/>
      <xsl:param name="thisPage"/>
      <xsl:param name="thisReport" select="1"/>
      <xsl:param name="thisReportID"/>
      <xsl:choose>
         <xsl:when test="name()=$lineNodeName and key('Layout',concat($thisID, $thisReportID))/height &lt;  key('Layout',concat($thisID, $thisReportID))/width">
            <hr>
               <xsl:attribute name="class"><xsl:value-of select="concat('FRX',$thisReport,'_',$thisID)"/></xsl:attribute>
               <xsl:attribute name="style">top:<xsl:call-template name="setPrecision"><xsl:with-param name="theNumber" select="@t  div $printDPI"/></xsl:call-template>in;left:<xsl:call-template name="setPrecision"><xsl:with-param name="theNumber" select="@l div $printDPI"/></xsl:call-template>in;height:<xsl:call-template name="setPrecision"><xsl:with-param name="theNumber" select="@h div $printDPI"/></xsl:call-template>in;z-Index:<xsl:value-of select="$thisZ"/>;</xsl:attribute>
            </hr>
         </xsl:when>
         <xsl:when test="name()=$lineNodeName">
            <!-- vertical line -->
            <span>
               <xsl:attribute name="class"><xsl:value-of select="concat('FRX',$thisReport,'_',$thisID)"/></xsl:attribute>
               <xsl:attribute name="style">top:<xsl:call-template name="setPrecision"><xsl:with-param name="theNumber" select="@t  div $printDPI"/></xsl:call-template>in;left:<xsl:call-template name="setPrecision"><xsl:with-param name="theNumber" select="@l div $printDPI"/></xsl:call-template>in;height:<xsl:call-template name="setPrecision"><xsl:with-param name="theNumber" select="@h div $printDPI"/></xsl:call-template>in;z-Index:<xsl:value-of select="$thisZ"/>;width:0in;</xsl:attribute>
            </span>
         </xsl:when>
         <xsl:when test="$useTextAreaForStretchingText=1  and name()=$fieldNodeName and key('Layout',concat($thisID, $thisReportID))[stretch='true']">
            <textarea readonly="readonly" rows="0" cols="0">
               <xsl:attribute name="style">height:<xsl:call-template name="setPrecision"><xsl:with-param name="theNumber" select="@h div $printDPI"/></xsl:call-template>in;top:<xsl:call-template name="setPrecision"><xsl:with-param name="theNumber" select="(@t  div $printDPI) - .1"/></xsl:call-template>in;left:<xsl:call-template name="setPrecision"><xsl:with-param name="theNumber" select="@l div $printDPI"/></xsl:call-template>in;
width:<xsl:call-template name="setPrecision"><xsl:with-param name="theNumber" select="@w div $printDPI"/></xsl:call-template>in;z-Index:<xsl:value-of select="$thisZ"/>;</xsl:attribute>
               <xsl:attribute name="class"><xsl:value-of select="concat('FRX',$thisReport,'_',$thisID)"/></xsl:attribute>
               <xsl:value-of select="."/>
            </textarea>
         </xsl:when>
         <xsl:otherwise>
            <div>
               <xsl:attribute name="style">position: absolute;z-Index:<xsl:value-of select="$thisZ"/>;top:<xsl:call-template name="setPrecision"><xsl:with-param name="theNumber" select="@t  div $printDPI"/></xsl:call-template>in;left:<xsl:call-template name="setPrecision"><xsl:with-param name="theNumber" select="@l div $printDPI"/></xsl:call-template>in;<xsl:choose><xsl:when test="key('Layout',concat($thisID, $thisReportID))[objtype=5 or objtype=8]">width:<xsl:call-template name="setPrecision"><xsl:with-param name="theNumber" select="@w div $printDPI"/></xsl:call-template>in;height:<xsl:call-template name="setPrecision"><xsl:with-param name="theNumber" select="@h div $printDPI"/></xsl:call-template>in;</xsl:when><xsl:when test="name()=$pictureNodeName">
 width:<xsl:call-template name="setPrecision"><xsl:with-param name="theNumber" select="@w div $printDPI"/></xsl:call-template>in;height:<xsl:call-template name="setPrecision"><xsl:with-param name="theNumber" select="@h div $printDPI"/></xsl:call-template>in; 
</xsl:when><xsl:otherwise>
height:<xsl:call-template name="setPrecision"><xsl:with-param name="theNumber" select="@h div $printDPI"/></xsl:call-template>in;
</xsl:otherwise></xsl:choose></xsl:attribute>
               <xsl:attribute name="class"><xsl:value-of select="concat('FRX',$thisReport,'_',$thisID)"/></xsl:attribute>
               <xsl:choose>
                  <xsl:when test="name()=$shapeNodeName or name()=$lineNodeName">
                     <!-- nothing -->
                  </xsl:when>
                  <xsl:when test="name()=$pictureNodeName">
                     <img alt="{key('Layout',concat($thisID, $thisReportID))/unpathedimg}">
                        <xsl:variable name="srcImage">
                           <xsl:choose>
                              <xsl:when test="@img and $externalFileLocation">
                                 <xsl:value-of select="translate(concat($externalFileLocation,@img),'\','/')"/>
                              </xsl:when>
                              <xsl:when test="@img">
                                 <xsl:value-of select="concat('file://',translate(@img,'\','/'))"/>
                              </xsl:when>
                              <xsl:when test="$copyImageFiles = '1'">
                                 <xsl:value-of select="translate(concat($externalFileLocation,key('Layout',concat($thisID, $thisReportID))/unpathedimg),'\','/')"/>
                              </xsl:when>
                              <xsl:when test="string-length(./text()) &gt; 0">
                                 <xsl:value-of select="concat('file://',translate(./text(),'\','/'))"/>
                              </xsl:when>
                              <xsl:otherwise>
                                 <xsl:value-of select="concat('file://',translate(key('Layout',concat($thisID, $thisReportID))/pathedimg,'\','/'))"/>
                              </xsl:otherwise>
                           </xsl:choose>
                        </xsl:variable>
                        <xsl:attribute name="src"><xsl:value-of select="$srcImage"/></xsl:attribute>
                        <xsl:attribute name="style"><xsl:variable name="imgGeneral" select="key('Layout',concat($thisID, $thisReportID))"/><xsl:choose><xsl:when test="$imgGeneral/general='0' "><!-- clip top, right, bottom, left -->
 clip: rect(0in,<xsl:call-template name="setPrecision"><xsl:with-param name="theNumber" select="@w div $printDPI"/></xsl:call-template> in,<xsl:value-of select="@h div $printDPI"/>in,0in);
 </xsl:when><xsl:when test="$imgGeneral/general='1'"><!-- scale and retain --><xsl:choose><xsl:when test="@h &gt; @w">
 width:100%;
 </xsl:when><xsl:otherwise>
 height:100%;
 </xsl:otherwise></xsl:choose></xsl:when><xsl:otherwise><!-- stretch to fill frame -->
 height: <xsl:call-template name="setPrecision"><xsl:with-param name="theNumber" select="@h div $printDPI"/></xsl:call-template>in;    
width: <xsl:call-template name="setPrecision"><xsl:with-param name="theNumber" select="@w div $printDPI"/></xsl:call-template>in;    
 </xsl:otherwise></xsl:choose></xsl:attribute>
                     </img>
                  </xsl:when>
                  <xsl:when test="string-length(@href) &gt; 0">
                     <A href="{@href}">
                     <xsl:call-template name="replaceText"/>
                     </A>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:call-template name="replaceText"/>
                  </xsl:otherwise>
               </xsl:choose>
            </div>
         </xsl:otherwise>
      </xsl:choose>
      <!-- /xsl:if -->
   </xsl:template>
   <xsl:template match="VFPFRXLayoutObject" mode="imagestyles">
      <xsl:param name="thisReport" select="1"/>
      <xsl:value-of select="concat('.FRX',$thisReport,'_',frxrecno)"/>{
  position: absolute;
  overflow: hidden;
  width: <xsl:call-template name="setPrecision">
         <xsl:with-param name="theNumber" select="width div $FRUs"/>
      </xsl:call-template>in;
  height: <xsl:call-template name="setPrecision">
         <xsl:with-param name="theNumber" select="height div $FRUs"/>
      </xsl:call-template>in;
<!-- <xsl:if test="offset=0">
left: <xsl:value-of select="hpos div $FRUs"/>in; 
</xsl:if>
<xsl:if test="offset=2">
left: <xsl:value-of select="hpos div $FRUs"/>in; 
</xsl:if> -->
  }
 </xsl:template>
   <xsl:template match="VFPFRXLayoutObject" mode="shapestyles">
      <xsl:param name="thisReport" select="1"/>
      <xsl:value-of select="concat('.FRX',$thisReport,'_',frxrecno)"/>{
   position: absolute ;   font-size:1pt;
    border: <xsl:value-of select="pensize"/>px <xsl:call-template name="pattern"/>
      <xsl:call-template name="pencolor"/>;
    <xsl:if test="(mode=0 and not(fillpat=0)) or (mode=1 and fillpat=1)">
background-color:<xsl:call-template name="fillcolor"/>;
</xsl:if>
width: <xsl:call-template name="setPrecision">
         <xsl:with-param name="theNumber" select="width div $FRUs"/>
      </xsl:call-template>in;
left: <xsl:call-template name="setPrecision">
         <xsl:with-param name="theNumber" select="hpos div $FRUs"/>
      </xsl:call-template>in;
<!--    <xsl:if test="stretch='true'">
overflow: auto;
   </xsl:if> -->
      }
  </xsl:template>
   <xsl:template match="VFPFRXLayoutObject" mode="textstyles">
      <xsl:param name="thisReport" select="1"/>
      <xsl:value-of select="concat('.FRX',$thisReport,'_',frxrecno)"/>{
  <xsl:call-template name="getTextAlignment"/>
      <!-- tbd, make vertical-align more dynamic -->  
   vertical-align: top;
   font-family: <xsl:value-of select="fontface"/>;
   font-size: <xsl:value-of select="fontsize"/>pt;
   border: 0px none;
  padding: 0px;
  margin: 0px;
  <xsl:call-template name="getFontAttributes"/>
   color:<xsl:call-template name="pencolor"/>;
<xsl:choose>
         <xsl:when test="mode=1">
  background-color:transparent;
  </xsl:when>
         <xsl:otherwise>
  background-color: <xsl:call-template name="fillcolor"/>;
    </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="stretch='true' and objtype=8 and $useTextAreaForStretchingText=1">
     overflow: auto;
     margin-top:4px;
    </xsl:when>
         <xsl:otherwise>
     overflow:hidden;
    </xsl:otherwise>
      </xsl:choose>
   position: absolute;
   }
  </xsl:template>
   <xsl:template match="VFPFRXLayoutObject" mode="linestyles">
      <xsl:param name="thisReport" select="1"/>
      <xsl:value-of select="concat('.FRX',$thisReport,'_',frxrecno)"/>{
   position:absolute;font-size:1pt;
  border: <xsl:value-of select="pensize"/>px <xsl:call-template name="pattern"/>
      <xsl:call-template name="pencolor"/>;
   left: <xsl:value-of select="hpos div $FRUs"/>in;
      <xsl:choose>
   <xsl:when test="height &lt; width"> width: <xsl:value-of select="width div $FRUs"/>in;
  height: <xsl:value-of select="floor(height div $FRUsInPixelsat96DPI)"/>px; margin: 0px;</xsl:when>
<xsl:otherwise>  height: <xsl:value-of select="height div $FRUs"/>in;
  width: <xsl:value-of select="floor(width div $FRUsInPixelsat96DPI)"/>px;  </xsl:otherwise>
</xsl:choose>
   }
  </xsl:template>
   <xsl:template name="pattern">
      <xsl:choose>
         <xsl:when test="penpat=0"> none </xsl:when>
         <xsl:when test="penpat=1"> dotted </xsl:when>
         <xsl:when test="penpat=2"> dashed </xsl:when>
         <xsl:otherwise> solid </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template name="pencolor">
 #<xsl:call-template name="getHexColorValue">
         <xsl:with-param name="theNumber" select="penred"/>
      </xsl:call-template>
      <xsl:call-template name="getHexColorValue">
         <xsl:with-param name="theNumber" select="pengreen"/>
      </xsl:call-template>
      <xsl:call-template name="getHexColorValue">
         <xsl:with-param name="theNumber" select="penblue"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="fillcolor">
    #<xsl:call-template name="getHexColorValue">
         <xsl:with-param name="theNumber" select="fillred"/>
         <xsl:with-param name="fill" select="1"/>
      </xsl:call-template>
      <xsl:call-template name="getHexColorValue">
         <xsl:with-param name="theNumber" select="fillgreen"/>
         <xsl:with-param name="fill" select="1"/>
      </xsl:call-template>
      <xsl:call-template name="getHexColorValue">
         <xsl:with-param name="theNumber" select="fillblue"/>
         <xsl:with-param name="fill" select="1"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="getFontAttributes">
      <xsl:param name="theStyles" select="0"/>
      <xsl:choose>
         <xsl:when test="fontbold='true'">font-weight: bold;</xsl:when>
         <xsl:otherwise>font-weight: normal;</xsl:otherwise>
      </xsl:choose>
      <xsl:if test="fontstrikethrough='true' or fontunderline='true'">text-decoration: <xsl:if test="fontstrikethrough='true'">line-through </xsl:if>
         <xsl:if test="fontunderline='true'">underline</xsl:if>;</xsl:if>
      <xsl:if test="fontitalic='true'">font-style: italic;</xsl:if>
   </xsl:template>
   <xsl:template name="getHexColorValue">
      <xsl:param name="theNumber" select="-1"/>
      <xsl:param name="fill" select="0"/>
      <xsl:variable name="useNumber">
         <xsl:choose>
            <xsl:when test="$fill=1 and fillpat &gt; 1 and ((fillred+fillblue+fillgreen) &lt; $fillPatternShade)">
               <xsl:choose>
                  <xsl:when test="($fillPatternOffset + $theNumber) &gt; 254">255</xsl:when>
                  <xsl:otherwise>
                     <xsl:value-of select="$fillPatternOffset + $theNumber"/>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="$theNumber"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="$useNumber=-1 and $fill=1">FF</xsl:when>
         <xsl:when test="$useNumber=-1">00</xsl:when>
         <xsl:otherwise>
            <xsl:call-template name="getHexForNumber">
               <xsl:with-param name="theNumber" select="floor($useNumber div 16)"/>
            </xsl:call-template>
            <xsl:call-template name="getHexForNumber">
               <xsl:with-param name="theNumber" select="round($useNumber mod 16)"/>
            </xsl:call-template>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template name="setPrecision">
      <xsl:param name="theNumber" select="-1"/>
      <xsl:choose>
         <xsl:when test="$numberPrecision = -1 or not(contains(string($theNumber),'.'))">
            <xsl:value-of select="$theNumber"/>
         </xsl:when>
         <xsl:when test="$numberPrecision &gt; 0">
            <!--        <xsl:value-of select="concat(string(floor($theNumber)),'.',substring(substring-after(string($theNumber),'.'),1,$numberPrecision))"/>  -->
            <xsl:value-of select="format-number($theNumber,concat('##0.',$zeros))"/>
         </xsl:when>
         <xsl:when test="$numberPrecision=0">
            <xsl:value-of select="round($theNumber)"/>
         </xsl:when>
         <xsl:otherwise>
            <!-- shouldn't happen-->
            <xsl:value-of select="$theNumber"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template name="getHexForNumber">
      <xsl:param name="theNumber" select="-1"/>
      <xsl:choose>
         <xsl:when test="$theNumber=-1">00</xsl:when>
         <xsl:when test="$theNumber &lt; 10">
            <xsl:value-of select="$theNumber"/>
         </xsl:when>
         <xsl:when test="$theNumber = 10">A</xsl:when>
         <xsl:when test="$theNumber = 11">B</xsl:when>
         <xsl:when test="$theNumber = 12">C</xsl:when>
         <xsl:when test="$theNumber = 13">D</xsl:when>
         <xsl:when test="$theNumber = 14">E</xsl:when>
         <xsl:when test="$theNumber = 15">F</xsl:when>
      </xsl:choose>
   </xsl:template>
   <xsl:template name="getTextAlignment">
  text-align:<xsl:choose>
         <xsl:when test="objtype=5">
            <!-- picture field empty for left (default), @I for centered and @J right -->
            <xsl:choose>
               <xsl:when test="string-length(picture) = 0">left;</xsl:when>
               <xsl:when test="contains(picture,'@J')">right;</xsl:when>
               <xsl:otherwise>center;</xsl:otherwise>
            </xsl:choose>
         </xsl:when>
         <xsl:otherwise>
            <xsl:choose>
               <xsl:when test="offset=0">left;</xsl:when>
               <xsl:when test="offset=1">right;</xsl:when>
               <xsl:otherwise>center;</xsl:otherwise>
            </xsl:choose>
         </xsl:otherwise>
      </xsl:choose>
      <!-- don't include direction at all if you want context -->
      <xsl:if test="mode &lt; 4">
    direction:<xsl:choose>
            <xsl:when test="mode &gt; 1">rtl;</xsl:when>
            <xsl:otherwise>ltr;</xsl:otherwise>
         </xsl:choose>
      </xsl:if>
   </xsl:template>
   <xsl:template name="Styles">
      <xsl:param name="thisReport" select="1"/>
      <xsl:param name="thisReportID"/>
      <xsl:comment>

    Styles for report # <xsl:value-of select="$thisReport"/>  in this run, 
    <xsl:value-of select="$thisReportID"/>
      </xsl:comment>
      <style type="text/css">
         <xsl:comment>
            <xsl:apply-templates select="./VFP-RDL/VFPDataSet/VFPFRXLayoutObject[objtype=6]" mode="linestyles">
               <xsl:with-param name="thisReport" select="$thisReport"/>
            </xsl:apply-templates>
            <xsl:apply-templates select="./VFP-RDL/VFPDataSet/VFPFRXLayoutObject[objtype=7]" mode="shapestyles">
               <xsl:with-param name="thisReport" select="$thisReport"/>
            </xsl:apply-templates>
            <xsl:apply-templates select="./VFP-RDL/VFPDataSet/VFPFRXLayoutObject[contains('|5|8|',concat('|',./objtype,'|'))]" mode="textstyles">
               <xsl:with-param name="thisReport" select="$thisReport"/>
            </xsl:apply-templates>
            <xsl:apply-templates select="./VFP-RDL/VFPDataSet/VFPFRXLayoutObject[objtype=17]" mode="imagestyles">
               <xsl:with-param name="thisReport" select="$thisReport"/>
            </xsl:apply-templates>
         </xsl:comment>
      </style>
   </xsl:template>
   <xsl:template name="replaceText">
   <xsl:choose>
  <xsl:when test="$useTextAreaForStretchingText=1">
  <xsl:value-of select="."/>
  </xsl:when>
  <xsl:otherwise>
  <xsl:call-template name="replaceWhiteSpace">
  <xsl:with-param name="string" select="."/>
  </xsl:call-template>
  </xsl:otherwise>
</xsl:choose>
   </xsl:template>

   <xsl:template name="replaceWhiteSpace">
   <xsl:param name="string" select="."/>
   <xsl:choose>
  <xsl:when test="contains($string,'&#xD;')">
  <xsl:call-template name="replaceWhiteSpace">
   <xsl:with-param name="string" select="substring-before($string, '&#xD;')"/>
  </xsl:call-template>   
  <br />
  <xsl:call-template name="replaceWhiteSpace">
   <xsl:with-param name="string" select="substring-after($string, '&#xD;')"/>
  </xsl:call-template>   
  </xsl:when>
  <xsl:otherwise>
  <xsl:value-of select="$string"/>
  </xsl:otherwise> 
</xsl:choose>
   </xsl:template>
   
   <xsl:template name="Script">
      <script language="JavaScript">
         <xsl:comment>
     //TBD
      </xsl:comment>
      </script>
   </xsl:template>
</xsl:stylesheet>

ENDTEXT
SET TEXTMERGE OFF
SET TEXTMERGE TO

RETURN lcResult
ENDPROC
PROCEDURE getdefaultuserxslt
LOCAL lcResult
lcResult = THIS.getDefaultUserXSLTAsString()
lcResult = STRTRAN(lcResult,"@h","@"+ THIS.HeightAttr)
lcResult = STRTRAN(lcResult,"@w","@"+ THIS.WidthAttr)
lcResult = STRTRAN(lcResult,"@l","@"+ THIS.LeftAttr)
lcResult = STRTRAN(lcResult,"@t","@"+ THIS.TopAttr)
lcResult = STRTRAN(lcResult,"@c","@"+ THIS.ContAttr)
lcResult = STRTRAN(lcResult,"@idref","@"+ THIS.IdRefAttribute)
lcResult = STRTRAN(lcResult,"@id","@"+THIS.IdAttribute)
lcResult = STRTRAN(lcResult,"@img","@"+THIS.imageSrcAttr )
THIS.XSLTProcessorUser = lcResult



ENDPROC
PROCEDURE Init
IF DODEFAULT()
   THIS.AppName = OUTPUTHTML_APPNAME_LOC
ELSE
   RETURN .F.   
ENDIF

RETURN NOT THIS.HadError
ENDPROC


