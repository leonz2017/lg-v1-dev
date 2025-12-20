************************************************************
OBJETO: _agent
************************************************************
*** PROPIEDADES ***
Height = 42
Width = 42
errorstate = LOAD
Name = "_agent"

*** METODOS ***
PROCEDURE load
LParameters tcAgentName, tcAgentLocation

*-- Make sure it inited ok
If Type("this.agentControl") = "O"
	*-- Only load a character once
	If Type('this.agentControl.characters("' + tcAgentName + '")' ) <> "O" And ;
		!Empty(tcAgentLocation)
		
  		this.errorState = "LOAD"
		this.agentControl.characters.load(tcAgentName, tcAgentLocation)
		If !this.errorOccurred
			this.agentControl.characters(tcAgentName).get("state", "Showing, Speaking")
  		Else
  			this.errorOccurred = .F.
  			Return .F.
  		Endif
	Endif
Endif


ENDPROC
PROCEDURE show
LParameters tnX, tnY, tnCoords, toObj

If Type("tnCoords") <> "N"
	tnCoords = COORDS_WORLD
Endif

If tnCoords = COORDS_LOCAL
	tnX = this.localToWorld(AXIS_X, tnX, toObj)
	tnY = this.localToWorld(AXIS_Y, tnY, toObj)
Endif

If Type("tnCoords") <> "N"
	tnCoords = this.defaultCoords
Endif

If Type("this.activeAgent") = "O"
	If Vartype(tnX) <> "N"
		tnX = this.activeAgent.Left
	Endif

	If Vartype(tnY) <> "N"
		tnY = this.activeAgent.Top
	Endif

	this.activeAgent.moveTo(tnX, tnY)
	this.activeAgent.show()
Else
	Return .F.
Endif


ENDPROC
PROCEDURE hide
If Type("this.activeAgent") = "O"
	this.activeAgent.hide()
Else
	Return .F.
Endif


ENDPROC
PROCEDURE moveto
LParameters tnX, tnY, tnCoords, toObj

If Type("tnCoords") <> "N"
	tnCoords = COORDS_WORLD
Endif

If tnCoords = COORDS_LOCAL
	tnX = this.localToWorld(AXIS_X, tnX, toObj)
	tnY = this.localToWorld(AXIS_Y, tnY, toObj)
Endif

If Type("this.activeAgent") = "O"
	this.activeAgent.moveTo(tnX, tnY)
Else
	Return .F.
Endif
ENDPROC
PROCEDURE play
LParameters tcAnimation

Local llRetVal

If Type("this.activeAgent") = "O"
	this.activeAgent.get("state", tcAnimation)
	llRetVal = this.activeAgent.play(tcAnimation)
Else
	llRetVal = .F.
Endif

Return llRetVal
ENDPROC
PROCEDURE gestureat
LParameters tnX, tnY, tnCoords, toObj

If Type("tnCoords") <> "N"
	tnCoords = COORDS_WORLD
Endif

If tnCoords = COORDS_LOCAL
	tnX = this.localToWorld(AXIS_X, tnX, toObj)
	tnY = this.localToWorld(AXIS_Y, tnY, toObj)
Endif

If Type("this.activeAgent") = "O"
	this.activeAgent.gestureAt(tnX, tnY)
Else
	Return .F.
Endif
ENDPROC
PROCEDURE speak
LParameters tcText

Local llRetVal

If Type("this.activeAgent") = "O"
	llRetVal = this.activeAgent.Speak(tcText)
Else
	llRetVal = .F.
Endif

Return llRetVal
ENDPROC
PROCEDURE moveby
LParameters tnX, tnY, tnCoords, toObj

If Type("tnCoords") <> "N"
	tnCoords = COORDS_WORLD
Endif

*-- Don't need to convert because we're only moving the relative position 
*!*	If tnCoords = COORDS_LOCAL
*!*		tnX = this.localToWorld(AXIS_X, tnX, toObj)
*!*		tnY = this.localToWorld(AXIS_Y, tnY, toObj)
*!*	Endif

If Type("this.activeAgent") = "O"
	this.moveTo( this.activeAgent.left + tnX, this.activeAgent.top + tnY )
Else
	Return .F.
Endif

ENDPROC
PROCEDURE localtoworld
LParameters tnAxis, tnPos, toObj

LOCAL lcAxis, loObj

*-- Select the Axis we are converting
lcAxis = Iif(tnAxis = 0, "Left", "Top")

*-- Calculate offset of all parent containers
loObj = toObj

Do While Type("loObj.Class") = "C"

	*-- Pages in PageFrames don't have Left or Top
	If Type("loObj." + lcAxis) = "N"
		tnPos = tnPos + loObj.&lcAxis
	Endif

	*-- If loObj is a form, we should determine if it's a top level
	*-- form. If so, we've already calculated the world offset. If not
	*-- we need the screen offset.
	If Type("loObj.Class") = "C" And Upper(loObj.Class) = "FORM"
		If loObj.ShowWindow <> 2 && Top-Level Form
			tnPos = tnPos + _Screen.&lcAxis.
		EndIf
	Endif

	If Type("loObj.Tabs") = "L" And tnAxis = 1
		If loObj.Tabs
			tnPos = tnPos + 28 && This may be a sysmetric call
		Else
			tnPos = tnPos + loObj.BorderWidth * 2
		Endif
	Endif
	
	If Type("loObj.Parent") <> "U"
	  	loObj = loObj.Parent
  	Else
  		loObj = .F.
  	Endif
EndDo

Return tnPos
ENDPROC
PROCEDURE stop
If Type("this.activeAgent") = "O"
	this.activeAgent.stop()
Else
	Return .f.
Endif
ENDPROC
PROCEDURE setactiveagent
LParameters tcAgentName

Local llRetVal

*-- Make sure it inited ok
If Type("this.agentControl") = "O"
	*-- Test to make sure this is a valid character
	If Type('this.agentControl.characters("' + tcAgentName + '")' ) = "O"
		this.activeAgent = this.agentControl.characters(tcAgentName)
		this.activeAgent.Activate()
		llRetVal = .T.
	EndIf
Endif

Return llRetVal
ENDPROC
PROCEDURE interrupt
LParameters toRequest

If Type("this.activeAgent") = "O"
	this.activeAgent.interrupt(toRequest)
Else
	Return .F.
Endif


ENDPROC
PROCEDURE wait
LParameters toRequest

Local llRetVal

If Type("this.activeAgent") = "O"
	llRetVal = this.activeAgent.wait(toRequest)
Else
	llRetVal = .F.
Endif

Return llRetVal
ENDPROC
PROCEDURE Init
*-- Create the Agent control
this.agentControl = CreateObject("Agent.Control.2")
this.agentControl.connected = .T.

RETURN DoDefault()
ENDPROC
PROCEDURE Error
LParameters nError, cMethod, nLine

Do Case
Case this.errorState == "LOAD"
	this.errorOccurred = .T.
	RETURN
EndCase

DoDefault(nError, cMethod, nLine)
ENDPROC


