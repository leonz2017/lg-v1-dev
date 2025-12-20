************************************************************
OBJETO: _soundplayer
************************************************************
*** PROPIEDADES ***
Width = 33
Height = 36
BorderWidth = 0
Visible = .F.
BackColor = 0,128,255
mcierror = 0
mcierrorstring = 
autoopen = .T.
mcialias = 
autoplay = .T.
autorepeat = .T.
controlsource = 
cfilename = 
Name = "_soundplayer"

*** METODOS ***
PROCEDURE domci
LPARAMETERS cMCIcmd
LOCAL cRetString,nRetValue,cErr 
*!* This method takes a MCI command string and executes it using
*!* the Windows API function mciSendString

*!* If the function executes successfully, the result is returned.
*!* Otherwise, the error string is returned.
cRetString = space(80)
nRetValue = mciSendString(cMCIcmd,@cRetString,len(cRetString),0)

cErr = THIS.getMCIerror(nRetValue)
IF nRetValue > 0
	RETURN CeRR
ENDIF
   
RETURN TRIM(STRTRAN(cRetString,chr(0),""))

ENDPROC
PROCEDURE getmcierror
LPARAMETERS cError
LOCAL nError,cErrorString

*!* This method is called from the doMCI to retrieve the last
*!* MCI error string.
*!* This function also saves the last error number and string
*!* into properties associated with the form.

nError=0
IF TYPE("cError")="C"
   IF LEFT(cError,7)="*ERROR*"
      nError=val(substr(cError,8))
   ENDIF
ENDIF   

IF TYPE("cError")="N"
  nError=cError
ENDIF

cErrorString=SPACE(256)  
=mciGetErrorString(nError,@cErrorString,len(cErrorString))

THIS.MCIerror = nError
THIS.MCIerrorString = cErrorString

RETURN TRIM(CHRTRAN(cErrorString,CHR(0),""))

ENDPROC
PROCEDURE showmcierror
MESSAGEBOX(STR(THIS.MCIerror) + ": " + THIS.MCIerrorString)

ENDPROC
PROCEDURE setposition
PARAMETERS cPosition

LOCAL cAlias,nPosition,cPosCmd,nMediaLength,cCmd   
cAlias = THIS.MCIalias

IF UPPER(cPosition) = "START" or UPPER(cPosition) = "END" THEN
	cPosCmd = "to " + cPosition
ELSE
	nPosition = VAL(cPosition)
	IF EMPTY(nPosition) THEN
		RETURN
	ELSE
		*!* Check to make sure position is not greater than the length
		
		nMediaLength = VAL(THIS.doMCI("STATUS " + cAlias + " length"))
		IF nMediaLength < nPosition THEN
			RETURN
		ELSE
			cPosCmd = "to " + STR(nPosition)
		ENDIF
	ENDIF
ENDIF

*!* Make sure video is loaded
cCmd = ("STATUS " + cAlias + " READY")
IF THIS.doMCI(cCmd) = "true" THEN
	cCmd = "SEEK " + cAlias + " " + cPosCmd
	THIS.doMCI(cCmd)
ENDIF
ENDPROC
PROCEDURE opensound
#DEFINE C_NOFILENAME_LOC "No filename or control source specified!"

LOCAL cFileName,cAlias,cCmd

*!* Get needed properties into variables
IF EMPTY(THIS.controlSource) THEN
	cFileName = THIS.cFileName
	IF EMPTY(cFileName) THEN
		MESSAGEBOX(C_NOFILENAME_LOC)
		RETURN
	ENDIF
ELSE
	cFileName = ALLTRIM(&controlSource)
	IF EMPTY(cFileName) THEN
		RETURN
	ENDIF
ENDIF
	
cAlias = THIS.MCIalias
IF EMPTY(cAlias) THEN
	cAlias = THIS.name
	THIS.MCIalias = cAlias
ENDIF

_SCREEN.MousePointer = 11

*!* If sound is already loaded, then close it
cCmd = ("STATUS " + cAlias + " READY")
IF THIS.doMCI(cCmd) = "true" THEN
	*!* If one is, close it
	cCMD = ("CLOSE " + cAlias + " WAIT")
	THIS.doMCI(cCmd)
ENDIF

*!* Set up open MCI command into string variable
cCmd = ('OPEN "' + cFileName + '" alias ' + cAlias + ' WAIT')

THIS.doMCI(cCmd)

*!* Check to see if MCI command succeeded
IF THIS.MCIerror > 0 THEN
	messagebox(THIS.MCIerrorString)
	_SCREEN.MousePointer = 0
	RETURN
ENDIF

*!* Set the device to use milliseconds when setting/getting position
THIS.doMCI("SET " + cAlias + " time format milliseconds")

IF THIS.autoPlay = .T. THEN
	THIS.playSound
ENDIF

_SCREEN.MousePointer = 0

ENDPROC
PROCEDURE pausesound
LOCAL cAlias
cAlias = THIS.MCIalias

*!* Check to see if there is media acutally playing
IF THIS.doMCI("STATUS " + cAlias + " mode") = "playing" THEN
	*!* Yes there is, so execute the PAUSE MCI command
	THIS.doMCI("PAUSE " + cAlias)
	IF THIS.MCIerror > 0 THEN
		THIS.showMCIerror
	ENDIF
	IF THIS.autoRepeat = .T. THEN
		THIS.tmrCheckMode.INTERVAL = 0
	ENDIF
ENDIF
ENDPROC
PROCEDURE playsound
LOCAL cAlias,nMediaLength,nMediaPosition  
cAlias = THIS.MCIalias

*!* First need to see if the media is at the end 
*!* by comparing the total length with the current position
nMediaLength = VAL(THIS.doMCI("STATUS " + cAlias + " length"))
nMediaPosition = VAL(THIS.doMCI("STATUS " + cAlias + " position"))

IF nMediaPosition >= nMediaLength THEN
	*!* The media is at the end, so we need to seek back to the start
	*!* of the clip before playing
	THIS.doMCI("SEEK " + cAlias + " to start WAIT")
ENDIF

*!* Now we can play the media
THIS.doMCI("PLAY " + cAlias)
IF THIS.MCIerror > 0 THEN
	THIS.showMCIerror
ENDIF

IF THIS.autoRepeat = .T. THEN
	THIS.tmrCheckMode.INTERVAL = 300
ENDIF
ENDPROC
PROCEDURE closesound
*!* If sound is not already closed, then close it
LOCAL cCmd
cCmd = ("STATUS " + THIS.MCIalias + " READY")
IF THIS.doMCI(cCmd) = "true" THEN
	*!* If one is, close it
	cCMD = ("CLOSE " + THIS.MCIalias + " WAIT")
	THIS.doMCI(cCmd)
	IF THIS.MCIerror > 0 THEN
		THIS.showMCIerror
	ENDIF
	IF THIS.autoRepeat = .T. THEN
		THIS.tmrCheckMode.INTERVAL = 0
	ENDIF
ENDIF

ENDPROC
PROCEDURE Error
#DEFINE INVALID_CONTROLSOURCE_LOC "Invalid controlSource specified."
LPARAMETERS nError, cMethod, nLine

DO CASE
	CASE nError=12 AND cMethod="opensound"
		messageBox(INVALID_CONTROLSOURCE_LOC)
	OTHERWISE
		ERROR (nError)
ENDCASE

ENDPROC
PROCEDURE Refresh
IF THIS.autoOpen = .T. THEN
	THIS.openSound
ENDIF

ENDPROC
PROCEDURE Init
THIS.Visible = .F.

*!* This is the primary Windows API function that is used to 
*!* send MCI commands
DECLARE INTEGER mciSendString ;
   IN WinMM.DLL ;
   STRING cMCIString,;
   STRING @cRetString,;
   INTEGER nRetLength,;
   INTEGER hInstance

*!* This function allows us to retrieve the last MCI error that occured
DECLARE INTEGER mciGetErrorString ;
   IN WINMM.DLL ;
   INTEGER nErrorno, ;
   STRING @cBuffer, ;
   INTEGER nBufSize
   
*!* When MCI plays a video, it creates its own Window.  By using
*!* this Windows API function we can position this Window to be
*!* in the same position as our Player rectangle on the form
DECLARE integer SetWindowPos ;
	IN User32 ;
	integer, integer, integer, integer, integer, integer, integer

ENDPROC
PROCEDURE Destroy
THIS.closeSound
ENDPROC


************************************************************
OBJETO: tmrCheckMode
************************************************************
*** PROPIEDADES ***
Name = "tmrCheckMode"

*** METODOS ***
PROCEDURE Timer
LOCAL cCmd
cCmd = ("STATUS " + THIS.PARENT.MCIalias + " MODE")
IF THIS.PARENT.doMCI(cCmd) = "stopped" THEN
	THIS.PARENT.playSound
ENDIF
ENDPROC


************************************************************
OBJETO: _videoplayer
************************************************************
*** PROPIEDADES ***
Width = 201
Height = 133
BorderWidth = 0
Visible = .F.
BackColor = 0,128,192
mcierror = 0
mcierrorstring = 
autoopen = .T.
mcialias = 
autoplay = .T.
autorepeat = .T.
controlsource = 
cfilename = 
Name = "_videoplayer"

*** METODOS ***
PROCEDURE domci
LPARAMETERS cMCIcmd
LOCAL cRetString,cErr,nRetValue

*!* This method takes a MCI command string and executes it using
*!* the Windows API function mciSendString

*!* If the function executes successfully, the result is returned.
*!* Otherwise, the error string is returned.
cRetString = space(80)
nRetValue = mciSendString(cMCIcmd,@cRetString,len(cRetString),0)

cErr = THIS.getMCIerror(nRetValue)
IF nRetValue > 0
	RETURN CeRR
ENDIF
   
RETURN TRIM(STRTRAN(cRetString,chr(0),""))

ENDPROC
PROCEDURE getmcierror
LPARAMETERS cError
LOCAL nError,cErrorString

*!* This method is called from the doMCI to retrieve the last
*!* MCI error string.
*!* This function also saves the last error number and string
*!* into properties associated with the form.

nError=0
IF TYPE("cError")="C"
   IF LEFT(cError,7)="*ERROR*"
      nError=val(substr(cError,8))
   ENDIF
ENDIF   

IF TYPE("cError")="N"
  nError=cError
ENDIF

cErrorString=SPACE(256)  
=mciGetErrorString(nError,@cErrorString,len(cErrorString))

THIS.MCIerror = nError
THIS.MCIerrorString = cErrorString

RETURN TRIM(CHRTRAN(cErrorString,CHR(0),""))

ENDPROC
PROCEDURE openvideo
#DEFINE C_NOFILENAME_LOC "No filename specified or control source specified!"
LOCAL cControlSource,cFileName,cAlias,cCmd,hWin,Main_hWnd,cur_window 
LOCAL x1Pos,x2Pos,y1Pos,y2Pos,NullPointer     
*!* Get needed properties into variables
cControlSource = THIS.controlSource
IF EMPTY(cControlSource) THEN
	cFileName = THIS.cFileName
	IF EMPTY(cFileName) THEN
		MESSAGEBOX(C_NOFILENAME_LOC)
		RETURN
	ENDIF
ELSE
	cFileName = ALLTRIM(&cControlSource)
	IF EMPTY(cFileName) THEN
		RETURN
	ENDIF
ENDIF

	
cAlias = THIS.MCIalias
IF EMPTY(cAlias) THEN
	cAlias = THIS.name
	THIS.MCIalias = cAlias
ENDIF

_SCREEN.MousePointer = 11

*!* If video is already loaded, then close it
cCmd = ("STATUS " + cAlias + " READY")
IF THIS.doMCI(cCmd) = "true" THEN
	*!* If one is, close it
	cCMD = ("CLOSE " + cAlias + " WAIT")
	THIS.doMCI(cCmd)
ENDIF

*!* Need to use window handle functions in FoxTools
SET LIBRARY TO HOME() + ".\FOXTOOLS.FLL"
EXTERNAL PROCEDURE MainHWND
EXTERNAL PROCEDURE _WhToHwnd
EXTERNAL PROCEDURE _WOnTop

* Returns Handle of Main VFP Window
* Main_hWnd = MainHWND()	
Main_hWnd = _VFP.hWnd

* Get Handle of the form with FOXTOOLS.FLL
IF TYPE("THISFORM")="O"
	cur_window = THISFORM.HWnd
ELSE
	cur_window = _WhToHwnd(_WonTop())
ENDIF

NullPointer = 0

*!* Set up open MCI command into string variable
cCmd = ('OPEN "' + cFileName + '" alias ' + cAlias + ;
  ' style child parent ' + ALLTRIM(STR(cur_window)) + ' WAIT')

THIS.doMCI(cCmd)

*!* Check to see if MCI command succeeded
IF THIS.MCIerror > 0 THEN
	messagebox(THIS.MCIerrorString)
	_SCREEN.MousePointer = 0
	RETURN
ELSE
	*!* It does have visual media, so we need to set up the window
	*!* it will play in.
	
	*!* Get the window handle of the window playing the video
	cCmd = "status " + cAlias + " window handle wait"
	hWin = INT(VAL(THIS.doMCI(cCmd)))

	*!* Once we have the window handle, we need to position
	*!* the video window to be the same position and size
	*!* as our player rectangle on the form
	x1Pos = THIS.LEFT
	y1Pos = THIS.TOP
	x2Pos = THIS.WIDTH
	y2Pos = THIS.HEIGHT

	*!* Use the SetWindowPos Windows function to set position and size
	setWindowPos(hWin,0,x1Pos,y1Pos,x2Pos,y2Pos,0)

	*!* Everything's done, let's show the video
	cCmd = ("WINDOW " + cAlias + " state show")
	THIS.doMCI(cCmd)

ENDIF

*!* Set the device to use milliseconds when setting/getting position
THIS.doMCI("SET " + cAlias + " time format milliseconds")

IF THIS.autoPlay = .T. THEN
	THIS.playVideo
ENDIF

_SCREEN.MousePointer = 0

ENDPROC
PROCEDURE playvideo
LOCAL cAlias,nMediaLength,nMediaPosition  
cAlias = THIS.MCIalias

*!* First need to see if the media is at the end 
*!* by comparing the total length with the current position
nMediaLength = VAL(THIS.doMCI("STATUS " + cAlias + " length"))
nMediaPosition = VAL(THIS.doMCI("STATUS " + cAlias + " position"))

IF nMediaPosition >= nMediaLength THEN
	*!* The media is at the end, so we need to seek back to the start
	*!* of the clip before playing
	THIS.doMCI("SEEK " + cAlias + " to start WAIT")
ENDIF

*!* Now we can play the media
THIS.doMCI("PLAY " + cAlias)
IF THIS.MCIerror > 0 THEN
	THIS.showMCIerror
ENDIF

IF THIS.autoRepeat = .T. THEN
	THIS.tmrCheckMode.INTERVAL = 100
ENDIF
ENDPROC
PROCEDURE pausevideo
LOCAL cAlias
cAlias = THIS.MCIalias

*!* Check to see if there is media acutally playing
IF THIS.doMCI("STATUS " + cAlias + " mode") = "playing" THEN
	*!* Yes there is, so execute the PAUSE MCI command
	THIS.doMCI("PAUSE " + cAlias)
	IF THIS.MCIerror > 0 THEN
		THIS.showMCIerror
	ENDIF
	IF THIS.autoRepeat = .T. THEN
		THIS.tmrCheckMode.INTERVAL = 0
	ENDIF
ENDIF
ENDPROC
PROCEDURE showmcierror
MESSAGEBOX(STR(THIS.MCIerror) + ": " + THIS.MCIerrorString)

ENDPROC
PROCEDURE closevideo
LOCAL cCmd 
*!* If video is not already closed, then close it
cCmd = ("STATUS " + THIS.MCIalias + " READY")
IF THIS.doMCI(cCmd) = "true" THEN
	*!* If one is, close it
	cCMD = ("CLOSE " + THIS.MCIalias + " WAIT")
	THIS.doMCI(cCmd)
	IF THIS.MCIerror > 0 THEN
		THIS.showMCIerror
	ENDIF
	IF THIS.autoRepeat = .T. THEN
		THIS.tmrCheckMode.INTERVAL = 0
	ENDIF
ENDIF

ENDPROC
PROCEDURE setposition
PARAMETERS cPosition
LOCAL cAlias,cPosCmd,nPosition,nMediaLength 
cAlias = THIS.MCIalias

IF UPPER(cPosition) = "START" or UPPER(cPosition) = "END" THEN
	cPosCmd = "to " + cPosition
ELSE
	nPosition = VAL(cPosition)
	IF EMPTY(nPosition) THEN
		RETURN
	ELSE
		*!* Check to make sure position is not greater than the length
		
		nMediaLength = VAL(THIS.doMCI("STATUS " + cAlias + " length"))
		IF nMediaLength < nPosition THEN
			RETURN
		ELSE
			cPosCmd = "to " + STR(nPosition)
		ENDIF
	ENDIF
ENDIF

*!* Make sure video is loaded
cCmd = ("STATUS " + cAlias + " READY")
IF THIS.doMCI(cCmd) = "true" THEN
	cCmd = "SEEK " + cAlias + " " + cPosCmd
	THIS.doMCI(cCmd)
ENDIF
ENDPROC
PROCEDURE Destroy
THIS.closeVideo
ENDPROC
PROCEDURE Init
THIS.Visible = .F. 

*!* This is the primary Windows API function that is used to 
*!* send MCI commands
DECLARE INTEGER mciSendString ;
   IN WinMM.DLL ;
   STRING cMCIString,;
   STRING @cRetString,;
   INTEGER nRetLength,;
   INTEGER hInstance

*!* This function allows us to retrieve the last MCI error that occured
DECLARE INTEGER mciGetErrorString ;
   IN WINMM.DLL ;
   INTEGER nErrorno, ;
   STRING @cBuffer, ;
   INTEGER nBufSize
   
*!* When MCI plays a video, it creates its own Window.  By using
*!* this Windows API function we can position this Window to be
*!* in the same position as our Player rectangle on the form
DECLARE integer SetWindowPos ;
	IN User32 ;
	integer, integer, integer, integer, integer, integer, integer

ENDPROC
PROCEDURE Refresh

IF THIS.autoOpen = .T. THEN
	THIS.openVideo
ENDIF

ENDPROC
PROCEDURE Error
#DEFINE INVALID_CONTROLSOURCE_LOC "Invalid controlSource specified."

LPARAMETERS nError, cMethod, nLine

DO CASE
	CASE nError = 12 and cMethod = "openvideo"
		messageBox(INVALID_CONTROLSOURCE_LOC)
	OTHERWISE
		ERROR (nError)
ENDCASE

ENDPROC


************************************************************
OBJETO: tmrCheckMode
************************************************************
*** PROPIEDADES ***
Top = 96
Left = 120
Height = 23
Width = 23
Name = "tmrCheckMode"

*** METODOS ***
PROCEDURE Timer
LOCAL cCmd
cCmd = ("STATUS " + THIS.PARENT.MCIalias + " MODE")
IF THIS.PARENT.doMCI(cCmd) = "stopped" THEN
	THIS.PARENT.playVideo
ENDIF
ENDPROC


