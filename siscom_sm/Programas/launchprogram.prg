PROCEDURE launchProgram(pcProgramLocation,cNameFile,iWindowsStyle,bWaitOnReturn) 
  
 LOCAL cCurrentFolder,cProgramFolder 
 cCurrentFolder = SYS(5) + SYS(2003)
 
 SET DEFAULT TO HOME()
 
 cProgramFolder = SYS(5) + SYS(2003) + pcProgramLocation 

TRY 
 LOCAL oWSH 
 oWSH = CREATEOBJECT("WScript.Shell") 
 SET DEFAULT TO (cProgramFolder) 
 &&oWSH.Run(pcProgramLocation,0,.T.) 
 oWSH.Run(cNameFile,iWindowsStyle,bWaitOnReturn) 
 
 SET DEFAULT TO (cCurrentFolder) 
 * 
 CATCH TO xEcepcion
 		SET DEFAULT TO (cCurrentFolder) 
        lsErrorEcepcion = "No se pudo ejecutar el programa. " + ;
		"RS: "+TRANSFORM(xEcepcion.ErrorNo) + " Mensaje: " + xEcepcion.Message 
 FINALLY 
ENDTRY 

ENDPROC 

***************************************************************************************
*!*	Syntax 
*!*	      objShell.Run (strCommand, [intWindowStyle], [bWaitOnReturn]) 

*!*	Key
*!*	   objShell    :  A WScript.Shell object

*!*	   strCommand  :  The Command to be executed

*!*	   intWindowStyle
*!*	   (Optional)  :  Int value indicating the appearance of 
*!*	                  the program's window. 
*!*	                  Not all programs make use of this. 

*!*	   bWaitOnReturn : Wait for the command to complete before
*!*	                   continuing execution of the wsh script.
*!*	If bWaitOnReturn is set to TRUE, the Run method returns any error code returned by the application.

*!*	If bWaitOnReturn is not specified or FALSE, this method immediately returns to script execution rather than waiting on the process termination (and returns an error code of 0)

*!*	Specifying the bWaitOnReturn parameter allows you to run programs synchronously (one at a time). 

*!*	Environment variables within the argument strCommand are automatically expanded. 

*!*	If a file type has been properly registered to a particular program, calling run on a file of that type executes the program. For example, if Word is installed on your computer system, calling Run on a *.doc file starts Word, and loads the document. 

*!*	Settings for intWindowStyle:

*!*	 0 Hide the window (and activate another window.)
*!*	 1 Activate and display the window. (restore size and position) Specify this flag when displaying a window for the first time. 
*!*	 2 Activate & minimize. 
*!*	 3 Activate & maximize. 
*!*	 4 Restore. The active window remains active. 
*!*	 5 Activate & Restore. 
*!*	 6 Minimize & activate the next top-level window in the Z order. 
*!*	 7 Minimize. The active window remains active. 
*!*	 8 Display the window in its current state. The active window remains active. 
*!*	 9 Restore & Activate. Specify this flag when restoring a minimized window. 
*!*	10 Sets the show-state based on the state of the program that started the application.
***************************************************************************************