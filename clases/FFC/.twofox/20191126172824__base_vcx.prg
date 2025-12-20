************************************************************
OBJETO: _checkbox
************************************************************
*** PROPIEDADES ***
Height = 17
Width = 60
Caption = "Check1"
Name = "_checkbox"
cversion = 
builder = 
builderx = (HOME()+"Wizards\BuilderD,BuilderDForm")
nobjectrefcount = 0
ninstances = 0
ohost = .NULL.
vresult = .T.
csetobjrefprogram = (IIF(VERSION(2)=0,"",HOME()+"FFC\")+"SetObjRf.prg")

*** METODOS ***
PROCEDURE release
LOCAL lcBaseClass

IF this.lRelease
	NODEFAULT
	RETURN .F.
ENDIF
this.lRelease=.T.
lcBaseClass=LOWER(this.BaseClass)
this.oHost=.NULL.
this.ReleaseObjRefs
IF NOT INLIST(lcBaseClass+" ","form ","formset ","toolbar ")
	RELEASE this
ENDIF

ENDPROC
PROCEDURE setobjectref
LPARAMETERS tcName,tvClass,tvClassLibrary
LOCAL lvResult

this.vResult=.T.
DO (this.cSetObjRefProgram) WITH (this),(tcName),(tvClass),(tvClassLibrary)
lvResult=this.vResult
this.vResult=.T.
RETURN lvResult

ENDPROC
PROCEDURE setobjectrefs
LPARAMETERS toObject

RETURN

ENDPROC
PROCEDURE releaseobjrefs
LOCAL lcName,oObject,lnCount

IF this.nObjectRefCount=0
	RETURN
ENDIF
FOR lnCount = this.nObjectRefCount TO 1 STEP -1
	lcName=this.aObjectRefs[lnCount,1]
	IF EMPTY(lcName) OR NOT PEMSTATUS(this,lcName,5) OR TYPE("this."+lcName)#"O"
		LOOP
	ENDIF
	oObject=this.&lcName
	IF ISNULL(oObject)
		LOOP
	ENDIF
	IF TYPE("oObject")=="O" AND NOT ISNULL(oObject) AND PEMSTATUS(oObject,"Release",5)
		oObject.Release
	ENDIF
	IF NOT ISNULL(oObject) AND PEMSTATUS(oObject,"oHost",5)
		oObject.oHost=.NULL.
	ENDIF
	this.&lcName=.NULL.
	oObject=.NULL.
ENDFOR
DIMENSION this.aObjectRefs[1,3]
this.aObjectRefs=""

ENDPROC
PROCEDURE nobjectrefcount_access
LOCAL lnObjectRefCount

lnObjectRefCount=ALEN(this.aObjectRefs,1)
IF lnObjectRefCount=1 AND EMPTY(this.aObjectRefs[1])
	lnObjectRefCount=0
ENDIF
RETURN lnObjectRefCount

ENDPROC
PROCEDURE nobjectrefcount_assign
LPARAMETERS m.vNewVal

ERROR 1743

ENDPROC
PROCEDURE sethost
this.oHost=IIF(TYPE("thisform")=="O",thisform,.NULL.)

ENDPROC
PROCEDURE newinstance
LPARAMETERS tnDataSessionID
LOCAL oNewObject,lnLastDataSessionID

lnLastDataSessionID=SET("DATASESSION")
IF TYPE("tnDataSessionID")=="N" AND tnDataSessionID>=1
	SET DATASESSION TO tnDataSessionID
ENDIF
oNewObject=NEWOBJECT(this.Class,this.ClassLibrary)
SET DATASESSION TO (lnLastDataSessionID)
RETURN oNewObject

ENDPROC
PROCEDURE addtoproject
*-- Dummy code for adding files to project.
RETURN

DO SetObjRf.prg

ENDPROC
PROCEDURE ninstances_access
LOCAL laInstances[1]
	
RETURN AINSTANCE(laInstances,this.Class)

ENDPROC
PROCEDURE ninstances_assign
LPARAMETERS vNewVal

ERROR 1743

ENDPROC
PROCEDURE Error
LPARAMETERS nError, cMethod, nLine
LOCAL lcOnError,lcErrorMsg,lcCodeLineMsg

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
lcErrorMsg=MESSAGE()+CHR(13)+CHR(13)+this.Name+CHR(13)+ ;
		"Error:           "+ALLTRIM(STR(nError))+CHR(13)+ ;
		"Method:       "+LOWER(ALLTRIM(cMethod))
lcCodeLineMsg=MESSAGE(1)
IF BETWEEN(nLine,1,100000) AND NOT lcCodeLineMsg="..."
	lcErrorMsg=lcErrorMsg+CHR(13)+"Line:            "+ALLTRIM(STR(nLine))
	IF NOT EMPTY(lcCodeLineMsg)
		lcErrorMsg=lcErrorMsg+CHR(13)+CHR(13)+lcCodeLineMsg
	ENDIF
ENDIF
WAIT CLEAR
MESSAGEBOX(lcErrorMsg,16,_screen.Caption)
ERROR nError

ENDPROC
PROCEDURE Init
IF this.lSetHost
	this.SetHost
ENDIF
IF this.lAutoSetObjectRefs AND NOT this.SetObjectRefs(this)
	RETURN .F.
ENDIF

ENDPROC
PROCEDURE Destroy
IF this.lRelease
	RETURN .F.
ENDIF
this.lRelease=.T.
this.ReleaseObjRefs
this.oHost=.NULL.

ENDPROC


************************************************************
OBJETO: _checkbox
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 13, 3, 0

*** METODOS ***


************************************************************
OBJETO: _combobox
************************************************************
*** PROPIEDADES ***
Height = 24
Width = 100
Name = "_combobox"
cversion = 
builder = 
builderx = (HOME()+"Wizards\BuilderD,BuilderDForm")
nobjectrefcount = 0
ninstances = 0
ohost = .NULL.
vresult = .T.
csetobjrefprogram = (IIF(VERSION(2)=0,"",HOME()+"FFC\")+"SetObjRf.prg")

*** METODOS ***
PROCEDURE release
LOCAL lcBaseClass

IF this.lRelease
	NODEFAULT
	RETURN .F.
ENDIF
this.lRelease=.T.
lcBaseClass=LOWER(this.BaseClass)
this.oHost=.NULL.
this.ReleaseObjRefs
IF NOT INLIST(lcBaseClass+" ","form ","formset ","toolbar ")
	RELEASE this
ENDIF

ENDPROC
PROCEDURE setobjectref
LPARAMETERS tcName,tvClass,tvClassLibrary
LOCAL lvResult

this.vResult=.T.
DO (this.cSetObjRefProgram) WITH (this),(tcName),(tvClass),(tvClassLibrary)
lvResult=this.vResult
this.vResult=.T.
RETURN lvResult

ENDPROC
PROCEDURE setobjectrefs
LPARAMETERS toObject

RETURN

ENDPROC
PROCEDURE releaseobjrefs
LOCAL lcName,oObject,lnCount

IF this.nObjectRefCount=0
	RETURN
ENDIF
FOR lnCount = this.nObjectRefCount TO 1 STEP -1
	lcName=this.aObjectRefs[lnCount,1]
	IF EMPTY(lcName) OR NOT PEMSTATUS(this,lcName,5) OR TYPE("this."+lcName)#"O"
		LOOP
	ENDIF
	oObject=this.&lcName
	IF ISNULL(oObject)
		LOOP
	ENDIF
	IF TYPE("oObject")=="O" AND NOT ISNULL(oObject) AND PEMSTATUS(oObject,"Release",5)
		oObject.Release
	ENDIF
	IF NOT ISNULL(oObject) AND PEMSTATUS(oObject,"oHost",5)
		oObject.oHost=.NULL.
	ENDIF
	this.&lcName=.NULL.
	oObject=.NULL.
ENDFOR
DIMENSION this.aObjectRefs[1,3]
this.aObjectRefs=""

ENDPROC
PROCEDURE nobjectrefcount_access
LOCAL lnObjectRefCount

lnObjectRefCount=ALEN(this.aObjectRefs,1)
IF lnObjectRefCount=1 AND EMPTY(this.aObjectRefs[1])
	lnObjectRefCount=0
ENDIF
RETURN lnObjectRefCount

ENDPROC
PROCEDURE nobjectrefcount_assign
LPARAMETERS m.vNewVal

ERROR 1743

ENDPROC
PROCEDURE sethost
this.oHost=IIF(TYPE("thisform")=="O",thisform,.NULL.)

ENDPROC
PROCEDURE newinstance
LPARAMETERS tnDataSessionID
LOCAL oNewObject,lnLastDataSessionID

lnLastDataSessionID=SET("DATASESSION")
IF TYPE("tnDataSessionID")=="N" AND tnDataSessionID>=1
	SET DATASESSION TO tnDataSessionID
ENDIF
oNewObject=NEWOBJECT(this.Class,this.ClassLibrary)
SET DATASESSION TO (lnLastDataSessionID)
RETURN oNewObject

ENDPROC
PROCEDURE addtoproject
*-- Dummy code for adding files to project.
RETURN

DO SetObjRf.prg

ENDPROC
PROCEDURE ninstances_access
LOCAL laInstances[1]
	
RETURN AINSTANCE(laInstances,this.Class)

ENDPROC
PROCEDURE ninstances_assign
LPARAMETERS vNewVal

ERROR 1743

ENDPROC
PROCEDURE Error
LPARAMETERS nError, cMethod, nLine
LOCAL lcOnError,lcErrorMsg,lcCodeLineMsg

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
lcErrorMsg=MESSAGE()+CHR(13)+CHR(13)+this.Name+CHR(13)+ ;
		"Error:           "+ALLTRIM(STR(nError))+CHR(13)+ ;
		"Method:       "+LOWER(ALLTRIM(cMethod))
lcCodeLineMsg=MESSAGE(1)
IF BETWEEN(nLine,1,100000) AND NOT lcCodeLineMsg="..."
	lcErrorMsg=lcErrorMsg+CHR(13)+"Line:            "+ALLTRIM(STR(nLine))
	IF NOT EMPTY(lcCodeLineMsg)
		lcErrorMsg=lcErrorMsg+CHR(13)+CHR(13)+lcCodeLineMsg
	ENDIF
ENDIF
WAIT CLEAR
MESSAGEBOX(lcErrorMsg,16,_screen.Caption)
ERROR nError

ENDPROC
PROCEDURE Init
IF this.lSetHost
	this.SetHost
ENDIF
IF this.lAutoSetObjectRefs AND NOT this.SetObjectRefs(this)
	RETURN .F.
ENDIF

ENDPROC
PROCEDURE Destroy
IF this.lRelease
	RETURN .F.
ENDIF
this.lRelease=.T.
this.ReleaseObjRefs
this.oHost=.NULL.

ENDPROC


************************************************************
OBJETO: _combobox
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 13, 3, 0

*** METODOS ***


************************************************************
OBJETO: _commandbutton
************************************************************
*** PROPIEDADES ***
Height = 27
Width = 84
Caption = "Command1"
Name = "_commandbutton"
cversion = 
builder = 
builderx = (HOME()+"Wizards\BuilderD,BuilderDForm")
nobjectrefcount = 0
ninstances = 0
ohost = .NULL.
vresult = .T.
csetobjrefprogram = (IIF(VERSION(2)=0,"",HOME()+"FFC\")+"SetObjRf.prg")

*** METODOS ***
PROCEDURE release
LOCAL lcBaseClass

IF this.lRelease
	NODEFAULT
	RETURN .F.
ENDIF
this.lRelease=.T.
lcBaseClass=LOWER(this.BaseClass)
this.oHost=.NULL.
this.ReleaseObjRefs
IF NOT INLIST(lcBaseClass+" ","form ","formset ","toolbar ")
	RELEASE this
ENDIF

ENDPROC
PROCEDURE setobjectref
LPARAMETERS tcName,tvClass,tvClassLibrary
LOCAL lvResult

this.vResult=.T.
DO (this.cSetObjRefProgram) WITH (this),(tcName),(tvClass),(tvClassLibrary)
lvResult=this.vResult
this.vResult=.T.
RETURN lvResult

ENDPROC
PROCEDURE setobjectrefs
LPARAMETERS toObject

RETURN

ENDPROC
PROCEDURE releaseobjrefs
LOCAL lcName,oObject,lnCount

IF this.nObjectRefCount=0
	RETURN
ENDIF
FOR lnCount = this.nObjectRefCount TO 1 STEP -1
	lcName=this.aObjectRefs[lnCount,1]
	IF EMPTY(lcName) OR NOT PEMSTATUS(this,lcName,5) OR TYPE("this."+lcName)#"O"
		LOOP
	ENDIF
	oObject=this.&lcName
	IF ISNULL(oObject)
		LOOP
	ENDIF
	IF TYPE("oObject")=="O" AND NOT ISNULL(oObject) AND PEMSTATUS(oObject,"Release",5)
		oObject.Release
	ENDIF
	IF NOT ISNULL(oObject) AND PEMSTATUS(oObject,"oHost",5)
		oObject.oHost=.NULL.
	ENDIF
	this.&lcName=.NULL.
	oObject=.NULL.
ENDFOR
DIMENSION this.aObjectRefs[1,3]
this.aObjectRefs=""

ENDPROC
PROCEDURE nobjectrefcount_access
LOCAL lnObjectRefCount

lnObjectRefCount=ALEN(this.aObjectRefs,1)
IF lnObjectRefCount=1 AND EMPTY(this.aObjectRefs[1])
	lnObjectRefCount=0
ENDIF
RETURN lnObjectRefCount

ENDPROC
PROCEDURE nobjectrefcount_assign
LPARAMETERS m.vNewVal

ERROR 1743

ENDPROC
PROCEDURE sethost
this.oHost=IIF(TYPE("thisform")=="O",thisform,.NULL.)

ENDPROC
PROCEDURE newinstance
LPARAMETERS tnDataSessionID
LOCAL oNewObject,lnLastDataSessionID

lnLastDataSessionID=SET("DATASESSION")
IF TYPE("tnDataSessionID")=="N" AND tnDataSessionID>=1
	SET DATASESSION TO tnDataSessionID
ENDIF
oNewObject=NEWOBJECT(this.Class,this.ClassLibrary)
SET DATASESSION TO (lnLastDataSessionID)
RETURN oNewObject

ENDPROC
PROCEDURE addtoproject
*-- Dummy code for adding files to project.
RETURN

DO SetObjRf.prg

ENDPROC
PROCEDURE ninstances_access
LOCAL laInstances[1]
	
RETURN AINSTANCE(laInstances,this.Class)

ENDPROC
PROCEDURE ninstances_assign
LPARAMETERS vNewVal

ERROR 1743

ENDPROC
PROCEDURE Error
LPARAMETERS nError, cMethod, nLine
LOCAL lcOnError,lcErrorMsg,lcCodeLineMsg

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
lcErrorMsg=MESSAGE()+CHR(13)+CHR(13)+this.Name+CHR(13)+ ;
		"Error:           "+ALLTRIM(STR(nError))+CHR(13)+ ;
		"Method:       "+LOWER(ALLTRIM(cMethod))
lcCodeLineMsg=MESSAGE(1)
IF BETWEEN(nLine,1,100000) AND NOT lcCodeLineMsg="..."
	lcErrorMsg=lcErrorMsg+CHR(13)+"Line:            "+ALLTRIM(STR(nLine))
	IF NOT EMPTY(lcCodeLineMsg)
		lcErrorMsg=lcErrorMsg+CHR(13)+CHR(13)+lcCodeLineMsg
	ENDIF
ENDIF
WAIT CLEAR
MESSAGEBOX(lcErrorMsg,16,_screen.Caption)
ERROR nError

ENDPROC
PROCEDURE Init
IF this.lSetHost
	this.SetHost
ENDIF
IF this.lAutoSetObjectRefs AND NOT this.SetObjectRefs(this)
	RETURN .F.
ENDIF

ENDPROC
PROCEDURE Destroy
IF this.lRelease
	RETURN .F.
ENDIF
this.lRelease=.T.
this.ReleaseObjRefs
this.oHost=.NULL.

ENDPROC


************************************************************
OBJETO: _commandbutton
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 13, 3, 0

*** METODOS ***


************************************************************
OBJETO: _commandgroup
************************************************************
*** PROPIEDADES ***
ButtonCount = 2
Value = 1
Height = 66
Width = 94
Name = "_commandgroup"
Command1.Top = 5
Command1.Left = 5
Command1.Height = 27
Command1.Width = 84
Command1.Caption = "Command1"
Command1.Name = "Command1"
Command2.Top = 34
Command2.Left = 5
Command2.Height = 27
Command2.Width = 84
Comm
and2.Caption = "Command2"
Command2.Name = "Command2"
cversion = 
builder = 
builderx = (HOME()+"Wizards\BuilderD,BuilderDForm")
nobjectrefcount = 0
ninstances = 0
ohost = .NULL.
vresult = .T.
csetobjrefprogram = (IIF(VERSION(2)=0,"",HOME()+"FFC\")+"SetObjRf.prg")

*** METODOS ***
PROCEDURE release
LOCAL lcBaseClass

IF this.lRelease
	NODEFAULT
	RETURN .F.
ENDIF
this.lRelease=.T.
lcBaseClass=LOWER(this.BaseClass)
this.oHost=.NULL.
this.ReleaseObjRefs
IF NOT INLIST(lcBaseClass+" ","form ","formset ","toolbar ")
	RELEASE this
ENDIF

ENDPROC
PROCEDURE setobjectref
LPARAMETERS tcName,tvClass,tvClassLibrary
LOCAL lvResult

this.vResult=.T.
DO (this.cSetObjRefProgram) WITH (this),(tcName),(tvClass),(tvClassLibrary)
lvResult=this.vResult
this.vResult=.T.
RETURN lvResult

ENDPROC
PROCEDURE setobjectrefs
LPARAMETERS toObject

RETURN

ENDPROC
PROCEDURE releaseobjrefs
LOCAL lcName,oObject,lnCount

IF this.nObjectRefCount=0
	RETURN
ENDIF
FOR lnCount = this.nObjectRefCount TO 1 STEP -1
	lcName=this.aObjectRefs[lnCount,1]
	IF EMPTY(lcName) OR NOT PEMSTATUS(this,lcName,5) OR TYPE("this."+lcName)#"O"
		LOOP
	ENDIF
	oObject=this.&lcName
	IF ISNULL(oObject)
		LOOP
	ENDIF
	IF TYPE("oObject")=="O" AND NOT ISNULL(oObject) AND PEMSTATUS(oObject,"Release",5)
		oObject.Release
	ENDIF
	IF NOT ISNULL(oObject) AND PEMSTATUS(oObject,"oHost",5)
		oObject.oHost=.NULL.
	ENDIF
	this.&lcName=.NULL.
	oObject=.NULL.
ENDFOR
DIMENSION this.aObjectRefs[1,3]
this.aObjectRefs=""

ENDPROC
PROCEDURE nobjectrefcount_access
LOCAL lnObjectRefCount

lnObjectRefCount=ALEN(this.aObjectRefs,1)
IF lnObjectRefCount=1 AND EMPTY(this.aObjectRefs[1])
	lnObjectRefCount=0
ENDIF
RETURN lnObjectRefCount

ENDPROC
PROCEDURE nobjectrefcount_assign
LPARAMETERS m.vNewVal

ERROR 1743

ENDPROC
PROCEDURE sethost
this.oHost=IIF(TYPE("thisform")=="O",thisform,.NULL.)

ENDPROC
PROCEDURE newinstance
LPARAMETERS tnDataSessionID
LOCAL oNewObject,lnLastDataSessionID

lnLastDataSessionID=SET("DATASESSION")
IF TYPE("tnDataSessionID")=="N" AND tnDataSessionID>=1
	SET DATASESSION TO tnDataSessionID
ENDIF
oNewObject=NEWOBJECT(this.Class,this.ClassLibrary)
SET DATASESSION TO (lnLastDataSessionID)
RETURN oNewObject

ENDPROC
PROCEDURE addtoproject
*-- Dummy code for adding files to project.
RETURN

DO SetObjRf.prg

ENDPROC
PROCEDURE ninstances_access
LOCAL laInstances[1]
	
RETURN AINSTANCE(laInstances,this.Class)

ENDPROC
PROCEDURE ninstances_assign
LPARAMETERS vNewVal

ERROR 1743

ENDPROC
PROCEDURE Error
LPARAMETERS nError, cMethod, nLine
LOCAL lcOnError,lcErrorMsg,lcCodeLineMsg

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
lcErrorMsg=MESSAGE()+CHR(13)+CHR(13)+this.Name+CHR(13)+ ;
		"Error:           "+ALLTRIM(STR(nError))+CHR(13)+ ;
		"Method:       "+LOWER(ALLTRIM(cMethod))
lcCodeLineMsg=MESSAGE(1)
IF BETWEEN(nLine,1,100000) AND NOT lcCodeLineMsg="..."
	lcErrorMsg=lcErrorMsg+CHR(13)+"Line:            "+ALLTRIM(STR(nLine))
	IF NOT EMPTY(lcCodeLineMsg)
		lcErrorMsg=lcErrorMsg+CHR(13)+CHR(13)+lcCodeLineMsg
	ENDIF
ENDIF
WAIT CLEAR
MESSAGEBOX(lcErrorMsg,16,_screen.Caption)
ERROR nError

ENDPROC
PROCEDURE Init
IF this.lSetHost
	this.SetHost
ENDIF
IF this.lAutoSetObjectRefs AND NOT this.SetObjectRefs(this)
	RETURN .F.
ENDIF

ENDPROC
PROCEDURE Destroy
IF this.lRelease
	RETURN .F.
ENDIF
this.lRelease=.T.
this.ReleaseObjRefs
this.oHost=.NULL.

ENDPROC


************************************************************
OBJETO: _commandgroup
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 13, 3, 0

*** METODOS ***


************************************************************
OBJETO: _container
************************************************************
*** PROPIEDADES ***
Width = 200
Height = 200
Name = "_container"
cversion = 
builder = 
builderx = (HOME()+"Wizards\BuilderD,BuilderDForm")
nobjectrefcount = 0
ninstances = 0
ohost = .NULL.
vresult = .T.
csetobjrefprogram = (IIF(VERSION(2)=0,"",HOME()+"FFC\")+"SetObjRf.prg")

*** METODOS ***
PROCEDURE release
LOCAL lcBaseClass

IF this.lRelease
	NODEFAULT
	RETURN .F.
ENDIF
this.lRelease=.T.
lcBaseClass=LOWER(this.BaseClass)
this.oHost=.NULL.
this.ReleaseObjRefs
IF NOT INLIST(lcBaseClass+" ","form ","formset ","toolbar ")
	RELEASE this
ENDIF

ENDPROC
PROCEDURE setobjectref
LPARAMETERS tcName,tvClass,tvClassLibrary
LOCAL lvResult

this.vResult=.T.
DO (this.cSetObjRefProgram) WITH (this),(tcName),(tvClass),(tvClassLibrary)
lvResult=this.vResult
this.vResult=.T.
RETURN lvResult

ENDPROC
PROCEDURE setobjectrefs
LPARAMETERS toObject

RETURN

ENDPROC
PROCEDURE releaseobjrefs
LOCAL lcName,oObject,lnCount

IF this.nObjectRefCount=0
	RETURN
ENDIF
FOR lnCount = this.nObjectRefCount TO 1 STEP -1
	lcName=this.aObjectRefs[lnCount,1]
	IF EMPTY(lcName) OR NOT PEMSTATUS(this,lcName,5) OR TYPE("this."+lcName)#"O"
		LOOP
	ENDIF
	oObject=this.&lcName
	IF ISNULL(oObject)
		LOOP
	ENDIF
	IF TYPE("oObject")=="O" AND NOT ISNULL(oObject) AND PEMSTATUS(oObject,"Release",5)
		oObject.Release
	ENDIF
	IF NOT ISNULL(oObject) AND PEMSTATUS(oObject,"oHost",5)
		oObject.oHost=.NULL.
	ENDIF
	this.&lcName=.NULL.
	oObject=.NULL.
ENDFOR
DIMENSION this.aObjectRefs[1,3]
this.aObjectRefs=""

ENDPROC
PROCEDURE nobjectrefcount_access
LOCAL lnObjectRefCount

lnObjectRefCount=ALEN(this.aObjectRefs,1)
IF lnObjectRefCount=1 AND EMPTY(this.aObjectRefs[1])
	lnObjectRefCount=0
ENDIF
RETURN lnObjectRefCount

ENDPROC
PROCEDURE nobjectrefcount_assign
LPARAMETERS m.vNewVal

ERROR 1743

ENDPROC
PROCEDURE sethost
this.oHost=IIF(TYPE("thisform")=="O",thisform,.NULL.)

ENDPROC
PROCEDURE newinstance
LPARAMETERS tnDataSessionID
LOCAL oNewObject,lnLastDataSessionID

lnLastDataSessionID=SET("DATASESSION")
IF TYPE("tnDataSessionID")=="N" AND tnDataSessionID>=1
	SET DATASESSION TO tnDataSessionID
ENDIF
oNewObject=NEWOBJECT(this.Class,this.ClassLibrary)
SET DATASESSION TO (lnLastDataSessionID)
RETURN oNewObject

ENDPROC
PROCEDURE addtoproject
*-- Dummy code for adding files to project.
RETURN

DO SetObjRf.prg

ENDPROC
PROCEDURE ninstances_access
LOCAL laInstances[1]
	
RETURN AINSTANCE(laInstances,this.Class)

ENDPROC
PROCEDURE ninstances_assign
LPARAMETERS vNewVal

ERROR 1743

ENDPROC
PROCEDURE Error
LPARAMETERS nError, cMethod, nLine
LOCAL lcOnError,lcErrorMsg,lcCodeLineMsg

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
lcErrorMsg=MESSAGE()+CHR(13)+CHR(13)+this.Name+CHR(13)+ ;
		"Error:           "+ALLTRIM(STR(nError))+CHR(13)+ ;
		"Method:       "+LOWER(ALLTRIM(cMethod))
lcCodeLineMsg=MESSAGE(1)
IF BETWEEN(nLine,1,100000) AND NOT lcCodeLineMsg="..."
	lcErrorMsg=lcErrorMsg+CHR(13)+"Line:            "+ALLTRIM(STR(nLine))
	IF NOT EMPTY(lcCodeLineMsg)
		lcErrorMsg=lcErrorMsg+CHR(13)+CHR(13)+lcCodeLineMsg
	ENDIF
ENDIF
WAIT CLEAR
MESSAGEBOX(lcErrorMsg,16,_screen.Caption)
ERROR nError

ENDPROC
PROCEDURE Init
IF this.lSetHost
	this.SetHost
ENDIF
IF this.lAutoSetObjectRefs AND NOT this.SetObjectRefs(this)
	RETURN .F.
ENDIF

ENDPROC
PROCEDURE Destroy
IF this.lRelease
	RETURN .F.
ENDIF
this.lRelease=.T.
this.ReleaseObjRefs
this.oHost=.NULL.

ENDPROC


************************************************************
OBJETO: _editbox
************************************************************
*** PROPIEDADES ***
Height = 53
Width = 100
Name = "_editbox"
cversion = 
builder = 
builderx = (HOME()+"Wizards\BuilderD,BuilderDForm")
nobjectrefcount = 0
ninstances = 0
ohost = .NULL.
vresult = .T.
csetobjrefprogram = (IIF(VERSION(2)=0,"",HOME()+"FFC\")+"SetObjRf.prg")

*** METODOS ***
PROCEDURE release
LOCAL lcBaseClass

IF this.lRelease
	NODEFAULT
	RETURN .F.
ENDIF
this.lRelease=.T.
lcBaseClass=LOWER(this.BaseClass)
this.oHost=.NULL.
this.ReleaseObjRefs
IF NOT INLIST(lcBaseClass+" ","form ","formset ","toolbar ")
	RELEASE this
ENDIF

ENDPROC
PROCEDURE setobjectref
LPARAMETERS tcName,tvClass,tvClassLibrary
LOCAL lvResult

this.vResult=.T.
DO (this.cSetObjRefProgram) WITH (this),(tcName),(tvClass),(tvClassLibrary)
lvResult=this.vResult
this.vResult=.T.
RETURN lvResult

ENDPROC
PROCEDURE setobjectrefs
LPARAMETERS toObject

RETURN

ENDPROC
PROCEDURE releaseobjrefs
LOCAL lcName,oObject,lnCount

IF this.nObjectRefCount=0
	RETURN
ENDIF
FOR lnCount = this.nObjectRefCount TO 1 STEP -1
	lcName=this.aObjectRefs[lnCount,1]
	IF EMPTY(lcName) OR NOT PEMSTATUS(this,lcName,5) OR TYPE("this."+lcName)#"O"
		LOOP
	ENDIF
	oObject=this.&lcName
	IF ISNULL(oObject)
		LOOP
	ENDIF
	IF TYPE("oObject")=="O" AND NOT ISNULL(oObject) AND PEMSTATUS(oObject,"Release",5)
		oObject.Release
	ENDIF
	IF NOT ISNULL(oObject) AND PEMSTATUS(oObject,"oHost",5)
		oObject.oHost=.NULL.
	ENDIF
	this.&lcName=.NULL.
	oObject=.NULL.
ENDFOR
DIMENSION this.aObjectRefs[1,3]
this.aObjectRefs=""

ENDPROC
PROCEDURE nobjectrefcount_access
LOCAL lnObjectRefCount

lnObjectRefCount=ALEN(this.aObjectRefs,1)
IF lnObjectRefCount=1 AND EMPTY(this.aObjectRefs[1])
	lnObjectRefCount=0
ENDIF
RETURN lnObjectRefCount

ENDPROC
PROCEDURE nobjectrefcount_assign
LPARAMETERS m.vNewVal

ERROR 1743

ENDPROC
PROCEDURE sethost
this.oHost=IIF(TYPE("thisform")=="O",thisform,.NULL.)

ENDPROC
PROCEDURE newinstance
LPARAMETERS tnDataSessionID
LOCAL oNewObject,lnLastDataSessionID

lnLastDataSessionID=SET("DATASESSION")
IF TYPE("tnDataSessionID")=="N" AND tnDataSessionID>=1
	SET DATASESSION TO tnDataSessionID
ENDIF
oNewObject=NEWOBJECT(this.Class,this.ClassLibrary)
SET DATASESSION TO (lnLastDataSessionID)
RETURN oNewObject

ENDPROC
PROCEDURE addtoproject
*-- Dummy code for adding files to project.
RETURN

DO SetObjRf.prg

ENDPROC
PROCEDURE ninstances_access
LOCAL laInstances[1]
	
RETURN AINSTANCE(laInstances,this.Class)

ENDPROC
PROCEDURE ninstances_assign
LPARAMETERS vNewVal

ERROR 1743

ENDPROC
PROCEDURE Error
LPARAMETERS nError, cMethod, nLine
LOCAL lcOnError,lcErrorMsg,lcCodeLineMsg

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
lcErrorMsg=MESSAGE()+CHR(13)+CHR(13)+this.Name+CHR(13)+ ;
		"Error:           "+ALLTRIM(STR(nError))+CHR(13)+ ;
		"Method:       "+LOWER(ALLTRIM(cMethod))
lcCodeLineMsg=MESSAGE(1)
IF BETWEEN(nLine,1,100000) AND NOT lcCodeLineMsg="..."
	lcErrorMsg=lcErrorMsg+CHR(13)+"Line:            "+ALLTRIM(STR(nLine))
	IF NOT EMPTY(lcCodeLineMsg)
		lcErrorMsg=lcErrorMsg+CHR(13)+CHR(13)+lcCodeLineMsg
	ENDIF
ENDIF
WAIT CLEAR
MESSAGEBOX(lcErrorMsg,16,_screen.Caption)
ERROR nError

ENDPROC
PROCEDURE Init
IF this.lSetHost
	this.SetHost
ENDIF
IF this.lAutoSetObjectRefs AND NOT this.SetObjectRefs(this)
	RETURN .F.
ENDIF

ENDPROC
PROCEDURE Destroy
IF this.lRelease
	RETURN .F.
ENDIF
this.lRelease=.T.
this.ReleaseObjRefs
this.oHost=.NULL.

ENDPROC


************************************************************
OBJETO: _editbox
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 13, 3, 0

*** METODOS ***


************************************************************
OBJETO: _grid
************************************************************
*** PROPIEDADES ***
Height = 200
Width = 320
Name = "_grid"
cversion = 
builder = 
builderx = (HOME()+"Wizards\BuilderD,BuilderDForm")
nobjectrefcount = 0
ninstances = 0
ohost = .NULL.
vresult = .T.
csetobjrefprogram = (IIF(VERSION(2)=0,"",HOME()+"FFC\")+"SetObjRf.prg")

*** METODOS ***
PROCEDURE release
LOCAL lcBaseClass

IF this.lRelease
	NODEFAULT
	RETURN .F.
ENDIF
this.lRelease=.T.
lcBaseClass=LOWER(this.BaseClass)
this.oHost=.NULL.
this.ReleaseObjRefs
IF NOT INLIST(lcBaseClass+" ","form ","formset ","toolbar ")
	RELEASE this
ENDIF

ENDPROC
PROCEDURE setobjectref
LPARAMETERS tcName,tvClass,tvClassLibrary
LOCAL lvResult

this.vResult=.T.
DO (this.cSetObjRefProgram) WITH (this),(tcName),(tvClass),(tvClassLibrary)
lvResult=this.vResult
this.vResult=.T.
RETURN lvResult

ENDPROC
PROCEDURE setobjectrefs
LPARAMETERS toObject

RETURN

ENDPROC
PROCEDURE releaseobjrefs
LOCAL lcName,oObject,lnCount

IF this.nObjectRefCount=0
	RETURN
ENDIF
FOR lnCount = this.nObjectRefCount TO 1 STEP -1
	lcName=this.aObjectRefs[lnCount,1]
	IF EMPTY(lcName) OR NOT PEMSTATUS(this,lcName,5) OR TYPE("this."+lcName)#"O"
		LOOP
	ENDIF
	oObject=this.&lcName
	IF ISNULL(oObject)
		LOOP
	ENDIF
	IF TYPE("oObject")=="O" AND NOT ISNULL(oObject) AND PEMSTATUS(oObject,"Release",5)
		oObject.Release
	ENDIF
	IF NOT ISNULL(oObject) AND PEMSTATUS(oObject,"oHost",5)
		oObject.oHost=.NULL.
	ENDIF
	this.&lcName=.NULL.
	oObject=.NULL.
ENDFOR
DIMENSION this.aObjectRefs[1,3]
this.aObjectRefs=""

ENDPROC
PROCEDURE nobjectrefcount_access
LOCAL lnObjectRefCount

lnObjectRefCount=ALEN(this.aObjectRefs,1)
IF lnObjectRefCount=1 AND EMPTY(this.aObjectRefs[1])
	lnObjectRefCount=0
ENDIF
RETURN lnObjectRefCount

ENDPROC
PROCEDURE nobjectrefcount_assign
LPARAMETERS m.vNewVal

ERROR 1743

ENDPROC
PROCEDURE sethost
this.oHost=IIF(TYPE("thisform")=="O",thisform,.NULL.)

ENDPROC
PROCEDURE newinstance
LPARAMETERS tnDataSessionID
LOCAL oNewObject,lnLastDataSessionID

lnLastDataSessionID=SET("DATASESSION")
IF TYPE("tnDataSessionID")=="N" AND tnDataSessionID>=1
	SET DATASESSION TO tnDataSessionID
ENDIF
oNewObject=NEWOBJECT(this.Class,this.ClassLibrary)
SET DATASESSION TO (lnLastDataSessionID)
RETURN oNewObject

ENDPROC
PROCEDURE addtoproject
*-- Dummy code for adding files to project.
RETURN

DO SetObjRf.prg

ENDPROC
PROCEDURE ninstances_access
LOCAL laInstances[1]
	
RETURN AINSTANCE(laInstances,this.Class)

ENDPROC
PROCEDURE ninstances_assign
LPARAMETERS vNewVal

ERROR 1743

ENDPROC
PROCEDURE Error
LPARAMETERS nError, cMethod, nLine
LOCAL lcOnError,lcErrorMsg,lcCodeLineMsg

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
lcErrorMsg=MESSAGE()+CHR(13)+CHR(13)+this.Name+CHR(13)+ ;
		"Error:           "+ALLTRIM(STR(nError))+CHR(13)+ ;
		"Method:       "+LOWER(ALLTRIM(cMethod))
lcCodeLineMsg=MESSAGE(1)
IF BETWEEN(nLine,1,100000) AND NOT lcCodeLineMsg="..."
	lcErrorMsg=lcErrorMsg+CHR(13)+"Line:            "+ALLTRIM(STR(nLine))
	IF NOT EMPTY(lcCodeLineMsg)
		lcErrorMsg=lcErrorMsg+CHR(13)+CHR(13)+lcCodeLineMsg
	ENDIF
ENDIF
WAIT CLEAR
MESSAGEBOX(lcErrorMsg,16,_screen.Caption)
ERROR nError

ENDPROC
PROCEDURE Init
IF this.lSetHost
	this.SetHost
ENDIF
IF this.lAutoSetObjectRefs AND NOT this.SetObjectRefs(this)
	RETURN .F.
ENDIF

ENDPROC
PROCEDURE Destroy
IF this.lRelease
	RETURN .F.
ENDIF
this.lRelease=.T.
this.ReleaseObjRefs
this.oHost=.NULL.

ENDPROC


************************************************************
OBJETO: _grid
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 13, 3, 0

*** METODOS ***


************************************************************
OBJETO: _line
************************************************************
*** PROPIEDADES ***
Height = 68
Width = 68
Name = "_line"
cversion = 
builder = 
builderx = (HOME()+"Wizards\BuilderD,BuilderDForm")
nobjectrefcount = 0
ninstances = 0
ohost = .NULL.
vresult = .T.
csetobjrefprogram = (IIF(VERSION(2)=0,"",HOME()+"FFC\")+"SetObjRf.prg")

*** METODOS ***
PROCEDURE release
LOCAL lcBaseClass

IF this.lRelease
	NODEFAULT
	RETURN .F.
ENDIF
this.lRelease=.T.
lcBaseClass=LOWER(this.BaseClass)
this.oHost=.NULL.
this.ReleaseObjRefs
IF NOT INLIST(lcBaseClass+" ","form ","formset ","toolbar ")
	RELEASE this
ENDIF

ENDPROC
PROCEDURE setobjectref
LPARAMETERS tcName,tvClass,tvClassLibrary
LOCAL lvResult

this.vResult=.T.
DO (this.cSetObjRefProgram) WITH (this),(tcName),(tvClass),(tvClassLibrary)
lvResult=this.vResult
this.vResult=.T.
RETURN lvResult

ENDPROC
PROCEDURE setobjectrefs
LPARAMETERS toObject

RETURN

ENDPROC
PROCEDURE releaseobjrefs
LOCAL lcName,oObject,lnCount

IF this.nObjectRefCount=0
	RETURN
ENDIF
FOR lnCount = this.nObjectRefCount TO 1 STEP -1
	lcName=this.aObjectRefs[lnCount,1]
	IF EMPTY(lcName) OR NOT PEMSTATUS(this,lcName,5) OR TYPE("this."+lcName)#"O"
		LOOP
	ENDIF
	oObject=this.&lcName
	IF ISNULL(oObject)
		LOOP
	ENDIF
	IF TYPE("oObject")=="O" AND NOT ISNULL(oObject) AND PEMSTATUS(oObject,"Release",5)
		oObject.Release
	ENDIF
	IF NOT ISNULL(oObject) AND PEMSTATUS(oObject,"oHost",5)
		oObject.oHost=.NULL.
	ENDIF
	this.&lcName=.NULL.
	oObject=.NULL.
ENDFOR
DIMENSION this.aObjectRefs[1,3]
this.aObjectRefs=""

ENDPROC
PROCEDURE nobjectrefcount_access
LOCAL lnObjectRefCount

lnObjectRefCount=ALEN(this.aObjectRefs,1)
IF lnObjectRefCount=1 AND EMPTY(this.aObjectRefs[1])
	lnObjectRefCount=0
ENDIF
RETURN lnObjectRefCount

ENDPROC
PROCEDURE nobjectrefcount_assign
LPARAMETERS m.vNewVal

ERROR 1743

ENDPROC
PROCEDURE sethost
this.oHost=IIF(TYPE("thisform")=="O",thisform,.NULL.)

ENDPROC
PROCEDURE newinstance
LPARAMETERS tnDataSessionID
LOCAL oNewObject,lnLastDataSessionID

lnLastDataSessionID=SET("DATASESSION")
IF TYPE("tnDataSessionID")=="N" AND tnDataSessionID>=1
	SET DATASESSION TO tnDataSessionID
ENDIF
oNewObject=NEWOBJECT(this.Class,this.ClassLibrary)
SET DATASESSION TO (lnLastDataSessionID)
RETURN oNewObject

ENDPROC
PROCEDURE addtoproject
*-- Dummy code for adding files to project.
RETURN

DO SetObjRf.prg

ENDPROC
PROCEDURE ninstances_access
LOCAL laInstances[1]
	
RETURN AINSTANCE(laInstances,this.Class)

ENDPROC
PROCEDURE ninstances_assign
LPARAMETERS vNewVal

ERROR 1743

ENDPROC
PROCEDURE Error
LPARAMETERS nError, cMethod, nLine
LOCAL lcOnError,lcErrorMsg,lcCodeLineMsg

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
lcErrorMsg=MESSAGE()+CHR(13)+CHR(13)+this.Name+CHR(13)+ ;
		"Error:           "+ALLTRIM(STR(nError))+CHR(13)+ ;
		"Method:       "+LOWER(ALLTRIM(cMethod))
lcCodeLineMsg=MESSAGE(1)
IF BETWEEN(nLine,1,100000) AND NOT lcCodeLineMsg="..."
	lcErrorMsg=lcErrorMsg+CHR(13)+"Line:            "+ALLTRIM(STR(nLine))
	IF NOT EMPTY(lcCodeLineMsg)
		lcErrorMsg=lcErrorMsg+CHR(13)+CHR(13)+lcCodeLineMsg
	ENDIF
ENDIF
WAIT CLEAR
MESSAGEBOX(lcErrorMsg,16,_screen.Caption)
ERROR nError

ENDPROC
PROCEDURE Init
IF this.lSetHost
	this.SetHost
ENDIF
IF this.lAutoSetObjectRefs AND NOT this.SetObjectRefs(this)
	RETURN .F.
ENDIF

ENDPROC
PROCEDURE Destroy
IF this.lRelease
	RETURN .F.
ENDIF
this.lRelease=.T.
this.ReleaseObjRefs
this.oHost=.NULL.

ENDPROC


************************************************************
OBJETO: _listbox
************************************************************
*** PROPIEDADES ***
Height = 170
Width = 100
Name = "_listbox"
cversion = 
builder = 
builderx = (HOME()+"Wizards\BuilderD,BuilderDForm")
nobjectrefcount = 0
ninstances = 0
ohost = .NULL.
vresult = .T.
csetobjrefprogram = (IIF(VERSION(2)=0,"",HOME()+"FFC\")+"SetObjRf.prg")

*** METODOS ***
PROCEDURE release
LOCAL lcBaseClass

IF this.lRelease
	NODEFAULT
	RETURN .F.
ENDIF
this.lRelease=.T.
lcBaseClass=LOWER(this.BaseClass)
this.oHost=.NULL.
this.ReleaseObjRefs
IF NOT INLIST(lcBaseClass+" ","form ","formset ","toolbar ")
	RELEASE this
ENDIF

ENDPROC
PROCEDURE setobjectref
LPARAMETERS tcName,tvClass,tvClassLibrary
LOCAL lvResult

this.vResult=.T.
DO (this.cSetObjRefProgram) WITH (this),(tcName),(tvClass),(tvClassLibrary)
lvResult=this.vResult
this.vResult=.T.
RETURN lvResult

ENDPROC
PROCEDURE setobjectrefs
LPARAMETERS toObject

RETURN

ENDPROC
PROCEDURE releaseobjrefs
LOCAL lcName,oObject,lnCount

IF this.nObjectRefCount=0
	RETURN
ENDIF
FOR lnCount = this.nObjectRefCount TO 1 STEP -1
	lcName=this.aObjectRefs[lnCount,1]
	IF EMPTY(lcName) OR NOT PEMSTATUS(this,lcName,5) OR TYPE("this."+lcName)#"O"
		LOOP
	ENDIF
	oObject=this.&lcName
	IF ISNULL(oObject)
		LOOP
	ENDIF
	IF TYPE("oObject")=="O" AND NOT ISNULL(oObject) AND PEMSTATUS(oObject,"Release",5)
		oObject.Release
	ENDIF
	IF NOT ISNULL(oObject) AND PEMSTATUS(oObject,"oHost",5)
		oObject.oHost=.NULL.
	ENDIF
	this.&lcName=.NULL.
	oObject=.NULL.
ENDFOR
DIMENSION this.aObjectRefs[1,3]
this.aObjectRefs=""

ENDPROC
PROCEDURE nobjectrefcount_access
LOCAL lnObjectRefCount

lnObjectRefCount=ALEN(this.aObjectRefs,1)
IF lnObjectRefCount=1 AND EMPTY(this.aObjectRefs[1])
	lnObjectRefCount=0
ENDIF
RETURN lnObjectRefCount

ENDPROC
PROCEDURE nobjectrefcount_assign
LPARAMETERS m.vNewVal

ERROR 1743

ENDPROC
PROCEDURE sethost
this.oHost=IIF(TYPE("thisform")=="O",thisform,.NULL.)

ENDPROC
PROCEDURE newinstance
LPARAMETERS tnDataSessionID
LOCAL oNewObject,lnLastDataSessionID

lnLastDataSessionID=SET("DATASESSION")
IF TYPE("tnDataSessionID")=="N" AND tnDataSessionID>=1
	SET DATASESSION TO tnDataSessionID
ENDIF
oNewObject=NEWOBJECT(this.Class,this.ClassLibrary)
SET DATASESSION TO (lnLastDataSessionID)
RETURN oNewObject

ENDPROC
PROCEDURE addtoproject
*-- Dummy code for adding files to project.
RETURN

DO SetObjRf.prg

ENDPROC
PROCEDURE ninstances_access
LOCAL laInstances[1]
	
RETURN AINSTANCE(laInstances,this.Class)

ENDPROC
PROCEDURE ninstances_assign
LPARAMETERS vNewVal

ERROR 1743

ENDPROC
PROCEDURE Error
LPARAMETERS nError, cMethod, nLine
LOCAL lcOnError,lcErrorMsg,lcCodeLineMsg

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
lcErrorMsg=MESSAGE()+CHR(13)+CHR(13)+this.Name+CHR(13)+ ;
		"Error:           "+ALLTRIM(STR(nError))+CHR(13)+ ;
		"Method:       "+LOWER(ALLTRIM(cMethod))
lcCodeLineMsg=MESSAGE(1)
IF BETWEEN(nLine,1,100000) AND NOT lcCodeLineMsg="..."
	lcErrorMsg=lcErrorMsg+CHR(13)+"Line:            "+ALLTRIM(STR(nLine))
	IF NOT EMPTY(lcCodeLineMsg)
		lcErrorMsg=lcErrorMsg+CHR(13)+CHR(13)+lcCodeLineMsg
	ENDIF
ENDIF
WAIT CLEAR
MESSAGEBOX(lcErrorMsg,16,_screen.Caption)
ERROR nError

ENDPROC
PROCEDURE Init
IF this.lSetHost
	this.SetHost
ENDIF
IF this.lAutoSetObjectRefs AND NOT this.SetObjectRefs(this)
	RETURN .F.
ENDIF

ENDPROC
PROCEDURE Destroy
IF this.lRelease
	RETURN .F.
ENDIF
this.lRelease=.T.
this.ReleaseObjRefs
this.oHost=.NULL.

ENDPROC


************************************************************
OBJETO: _listbox
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 13, 3, 0

*** METODOS ***


************************************************************
OBJETO: _optiongroup
************************************************************
*** PROPIEDADES ***
ButtonCount = 2
Value = 1
Height = 46
Width = 71
Name = "_optiongroup"
Option1.Caption = "Option1"
Option1.Value = 1
Option1.Height = 17
Option1.Left = 5
Option1.Top = 5
Option1.Width = 61
Option1.Name = "Option1"
Option2.Caption = "Option2"
Option2.Height = 17
Option2.Left = 5
Option2.Top = 24
Option2.Width = 61
Option2.Name = "Option2"
cversion = 
builder = 
builderx = (HOME()+"Wizards\BuilderD,BuilderDForm")
nobjectrefcount = 0
ninstances = 0
ohost = .NULL.
vresult = .T.
csetobjrefprogram = (IIF(VERSION(2)=0,"",HOME()+"FFC\")+"SetObjRf.prg")

*** METODOS ***
PROCEDURE release
LOCAL lcBaseClass

IF this.lRelease
	NODEFAULT
	RETURN .F.
ENDIF
this.lRelease=.T.
lcBaseClass=LOWER(this.BaseClass)
this.oHost=.NULL.
this.ReleaseObjRefs
IF NOT INLIST(lcBaseClass+" ","form ","formset ","toolbar ")
	RELEASE this
ENDIF

ENDPROC
PROCEDURE setobjectref
LPARAMETERS tcName,tvClass,tvClassLibrary
LOCAL lvResult

this.vResult=.T.
DO (this.cSetObjRefProgram) WITH (this),(tcName),(tvClass),(tvClassLibrary)
lvResult=this.vResult
this.vResult=.T.
RETURN lvResult

ENDPROC
PROCEDURE setobjectrefs
LPARAMETERS toObject

RETURN

ENDPROC
PROCEDURE releaseobjrefs
LOCAL lcName,oObject,lnCount

IF this.nObjectRefCount=0
	RETURN
ENDIF
FOR lnCount = this.nObjectRefCount TO 1 STEP -1
	lcName=this.aObjectRefs[lnCount,1]
	IF EMPTY(lcName) OR NOT PEMSTATUS(this,lcName,5) OR TYPE("this."+lcName)#"O"
		LOOP
	ENDIF
	oObject=this.&lcName
	IF ISNULL(oObject)
		LOOP
	ENDIF
	IF TYPE("oObject")=="O" AND NOT ISNULL(oObject) AND PEMSTATUS(oObject,"Release",5)
		oObject.Release
	ENDIF
	IF NOT ISNULL(oObject) AND PEMSTATUS(oObject,"oHost",5)
		oObject.oHost=.NULL.
	ENDIF
	this.&lcName=.NULL.
	oObject=.NULL.
ENDFOR
DIMENSION this.aObjectRefs[1,3]
this.aObjectRefs=""

ENDPROC
PROCEDURE nobjectrefcount_access
LOCAL lnObjectRefCount

lnObjectRefCount=ALEN(this.aObjectRefs,1)
IF lnObjectRefCount=1 AND EMPTY(this.aObjectRefs[1])
	lnObjectRefCount=0
ENDIF
RETURN lnObjectRefCount

ENDPROC
PROCEDURE nobjectrefcount_assign
LPARAMETERS m.vNewVal

ERROR 1743

ENDPROC
PROCEDURE sethost
this.oHost=IIF(TYPE("thisform")=="O",thisform,.NULL.)

ENDPROC
PROCEDURE newinstance
LPARAMETERS tnDataSessionID
LOCAL oNewObject,lnLastDataSessionID

lnLastDataSessionID=SET("DATASESSION")
IF TYPE("tnDataSessionID")=="N" AND tnDataSessionID>=1
	SET DATASESSION TO tnDataSessionID
ENDIF
oNewObject=NEWOBJECT(this.Class,this.ClassLibrary)
SET DATASESSION TO (lnLastDataSessionID)
RETURN oNewObject

ENDPROC
PROCEDURE addtoproject
*-- Dummy code for adding files to project.
RETURN

DO SetObjRf.prg

ENDPROC
PROCEDURE ninstances_access
LOCAL laInstances[1]
	
RETURN AINSTANCE(laInstances,this.Class)

ENDPROC
PROCEDURE ninstances_assign
LPARAMETERS vNewVal

ERROR 1743

ENDPROC
PROCEDURE Error
LPARAMETERS nError, cMethod, nLine
LOCAL lcOnError,lcErrorMsg,lcCodeLineMsg

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
lcErrorMsg=MESSAGE()+CHR(13)+CHR(13)+this.Name+CHR(13)+ ;
		"Error:           "+ALLTRIM(STR(nError))+CHR(13)+ ;
		"Method:       "+LOWER(ALLTRIM(cMethod))
lcCodeLineMsg=MESSAGE(1)
IF BETWEEN(nLine,1,100000) AND NOT lcCodeLineMsg="..."
	lcErrorMsg=lcErrorMsg+CHR(13)+"Line:            "+ALLTRIM(STR(nLine))
	IF NOT EMPTY(lcCodeLineMsg)
		lcErrorMsg=lcErrorMsg+CHR(13)+CHR(13)+lcCodeLineMsg
	ENDIF
ENDIF
WAIT CLEAR
MESSAGEBOX(lcErrorMsg,16,_screen.Caption)
ERROR nError

ENDPROC
PROCEDURE Init
IF this.lSetHost
	this.SetHost
ENDIF
IF this.lAutoSetObjectRefs AND NOT this.SetObjectRefs(this)
	RETURN .F.
ENDIF

ENDPROC
PROCEDURE Destroy
IF this.lRelease
	RETURN .F.
ENDIF
this.lRelease=.T.
this.ReleaseObjRefs
this.oHost=.NULL.

ENDPROC


************************************************************
OBJETO: _optiongroup
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 13, 3, 0

*** METODOS ***


************************************************************
OBJETO: _pageframe
************************************************************
*** PROPIEDADES ***
ErasePage = .T.
PageCount = 2
Width = 241
Height = 169
Name = "_pageframe"
Page1.Caption = "Page1"
Page1.Name = "Page1"
Page2.Caption = "Page2"
Page2.Name = "Page2"
cversion = 
builder = 
builderx = (HOME()+"Wizards\BuilderD,BuilderDForm")
nobjectrefcount = 0
ninstances = 0
ohost = .NULL.
vresult = .T.
csetobjrefprogram = (IIF(VERSION(2)=0,"",HOME()+"FFC\")+"SetObjRf.prg")

*** METODOS ***
PROCEDURE release
LOCAL lcBaseClass

IF this.lRelease
	NODEFAULT
	RETURN .F.
ENDIF
this.lRelease=.T.
lcBaseClass=LOWER(this.BaseClass)
this.oHost=.NULL.
this.ReleaseObjRefs
IF NOT INLIST(lcBaseClass+" ","form ","formset ","toolbar ")
	RELEASE this
ENDIF

ENDPROC
PROCEDURE setobjectref
LPARAMETERS tcName,tvClass,tvClassLibrary
LOCAL lvResult

this.vResult=.T.
DO (this.cSetObjRefProgram) WITH (this),(tcName),(tvClass),(tvClassLibrary)
lvResult=this.vResult
this.vResult=.T.
RETURN lvResult

ENDPROC
PROCEDURE setobjectrefs
LPARAMETERS toObject

RETURN

ENDPROC
PROCEDURE releaseobjrefs
LOCAL lcName,oObject,lnCount

IF this.nObjectRefCount=0
	RETURN
ENDIF
FOR lnCount = this.nObjectRefCount TO 1 STEP -1
	lcName=this.aObjectRefs[lnCount,1]
	IF EMPTY(lcName) OR NOT PEMSTATUS(this,lcName,5) OR TYPE("this."+lcName)#"O"
		LOOP
	ENDIF
	oObject=this.&lcName
	IF ISNULL(oObject)
		LOOP
	ENDIF
	IF TYPE("oObject")=="O" AND NOT ISNULL(oObject) AND PEMSTATUS(oObject,"Release",5)
		oObject.Release
	ENDIF
	IF NOT ISNULL(oObject) AND PEMSTATUS(oObject,"oHost",5)
		oObject.oHost=.NULL.
	ENDIF
	this.&lcName=.NULL.
	oObject=.NULL.
ENDFOR
DIMENSION this.aObjectRefs[1,3]
this.aObjectRefs=""

ENDPROC
PROCEDURE nobjectrefcount_access
LOCAL lnObjectRefCount

lnObjectRefCount=ALEN(this.aObjectRefs,1)
IF lnObjectRefCount=1 AND EMPTY(this.aObjectRefs[1])
	lnObjectRefCount=0
ENDIF
RETURN lnObjectRefCount

ENDPROC
PROCEDURE nobjectrefcount_assign
LPARAMETERS m.vNewVal

ERROR 1743

ENDPROC
PROCEDURE sethost
this.oHost=IIF(TYPE("thisform")=="O",thisform,.NULL.)

ENDPROC
PROCEDURE newinstance
LPARAMETERS tnDataSessionID
LOCAL oNewObject,lnLastDataSessionID

lnLastDataSessionID=SET("DATASESSION")
IF TYPE("tnDataSessionID")=="N" AND tnDataSessionID>=1
	SET DATASESSION TO tnDataSessionID
ENDIF
oNewObject=NEWOBJECT(this.Class,this.ClassLibrary)
SET DATASESSION TO (lnLastDataSessionID)
RETURN oNewObject

ENDPROC
PROCEDURE addtoproject
*-- Dummy code for adding files to project.
RETURN

DO SetObjRf.prg

ENDPROC
PROCEDURE ninstances_access
LOCAL laInstances[1]
	
RETURN AINSTANCE(laInstances,this.Class)

ENDPROC
PROCEDURE ninstances_assign
LPARAMETERS vNewVal

ERROR 1743

ENDPROC
PROCEDURE Error
LPARAMETERS nError, cMethod, nLine
LOCAL lcOnError,lcErrorMsg,lcCodeLineMsg

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
lcErrorMsg=MESSAGE()+CHR(13)+CHR(13)+this.Name+CHR(13)+ ;
		"Error:           "+ALLTRIM(STR(nError))+CHR(13)+ ;
		"Method:       "+LOWER(ALLTRIM(cMethod))
lcCodeLineMsg=MESSAGE(1)
IF BETWEEN(nLine,1,100000) AND NOT lcCodeLineMsg="..."
	lcErrorMsg=lcErrorMsg+CHR(13)+"Line:            "+ALLTRIM(STR(nLine))
	IF NOT EMPTY(lcCodeLineMsg)
		lcErrorMsg=lcErrorMsg+CHR(13)+CHR(13)+lcCodeLineMsg
	ENDIF
ENDIF
WAIT CLEAR
MESSAGEBOX(lcErrorMsg,16,_screen.Caption)
ERROR nError

ENDPROC
PROCEDURE Init
IF this.lSetHost
	this.SetHost
ENDIF
IF this.lAutoSetObjectRefs AND NOT this.SetObjectRefs(this)
	RETURN .F.
ENDIF

ENDPROC
PROCEDURE Destroy
IF this.lRelease
	RETURN .F.
ENDIF
this.lRelease=.T.
this.ReleaseObjRefs
this.oHost=.NULL.

ENDPROC


************************************************************
OBJETO: _separator
************************************************************
*** PROPIEDADES ***
Height = 0
Width = 0
Name = "_separator"
cversion = 
builder = 
builderx = (HOME()+"Wizards\BuilderD,BuilderDForm")
nobjectrefcount = 0
ninstances = 0
ohost = .NULL.
vresult = .T.
csetobjrefprogram = (IIF(VERSION(2)=0,"",HOME()+"FFC\")+"SetObjRf.prg")

*** METODOS ***
PROCEDURE release
LOCAL lcBaseClass

IF this.lRelease
	NODEFAULT
	RETURN .F.
ENDIF
this.lRelease=.T.
lcBaseClass=LOWER(this.BaseClass)
this.oHost=.NULL.
this.ReleaseObjRefs
IF NOT INLIST(lcBaseClass+" ","form ","formset ","toolbar ")
	RELEASE this
ENDIF

ENDPROC
PROCEDURE setobjectref
LPARAMETERS tcName,tvClass,tvClassLibrary
LOCAL lvResult

this.vResult=.T.
DO (this.cSetObjRefProgram) WITH (this),(tcName),(tvClass),(tvClassLibrary)
lvResult=this.vResult
this.vResult=.T.
RETURN lvResult

ENDPROC
PROCEDURE setobjectrefs
LPARAMETERS toObject

RETURN

ENDPROC
PROCEDURE releaseobjrefs
LOCAL lcName,oObject,lnCount

IF this.nObjectRefCount=0
	RETURN
ENDIF
FOR lnCount = this.nObjectRefCount TO 1 STEP -1
	lcName=this.aObjectRefs[lnCount,1]
	IF EMPTY(lcName) OR NOT PEMSTATUS(this,lcName,5) OR TYPE("this."+lcName)#"O"
		LOOP
	ENDIF
	oObject=this.&lcName
	IF ISNULL(oObject)
		LOOP
	ENDIF
	IF TYPE("oObject")=="O" AND NOT ISNULL(oObject) AND PEMSTATUS(oObject,"Release",5)
		oObject.Release
	ENDIF
	IF NOT ISNULL(oObject) AND PEMSTATUS(oObject,"oHost",5)
		oObject.oHost=.NULL.
	ENDIF
	this.&lcName=.NULL.
	oObject=.NULL.
ENDFOR
DIMENSION this.aObjectRefs[1,3]
this.aObjectRefs=""

ENDPROC
PROCEDURE nobjectrefcount_access
LOCAL lnObjectRefCount

lnObjectRefCount=ALEN(this.aObjectRefs,1)
IF lnObjectRefCount=1 AND EMPTY(this.aObjectRefs[1])
	lnObjectRefCount=0
ENDIF
RETURN lnObjectRefCount

ENDPROC
PROCEDURE nobjectrefcount_assign
LPARAMETERS m.vNewVal

ERROR 1743

ENDPROC
PROCEDURE sethost
this.oHost=IIF(TYPE("thisform")=="O",thisform,.NULL.)

ENDPROC
PROCEDURE newinstance
LPARAMETERS tnDataSessionID
LOCAL oNewObject,lnLastDataSessionID

lnLastDataSessionID=SET("DATASESSION")
IF TYPE("tnDataSessionID")=="N" AND tnDataSessionID>=1
	SET DATASESSION TO tnDataSessionID
ENDIF
oNewObject=NEWOBJECT(this.Class,this.ClassLibrary)
SET DATASESSION TO (lnLastDataSessionID)
RETURN oNewObject

ENDPROC
PROCEDURE addtoproject
*-- Dummy code for adding files to project.
RETURN

DO SetObjRf.prg

ENDPROC
PROCEDURE ninstances_access
LOCAL laInstances[1]
	
RETURN AINSTANCE(laInstances,this.Class)

ENDPROC
PROCEDURE ninstances_assign
LPARAMETERS vNewVal

ERROR 1743

ENDPROC
PROCEDURE Error
LPARAMETERS nError, cMethod, nLine
LOCAL lcOnError,lcErrorMsg,lcCodeLineMsg

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
lcErrorMsg=MESSAGE()+CHR(13)+CHR(13)+this.Name+CHR(13)+ ;
		"Error:           "+ALLTRIM(STR(nError))+CHR(13)+ ;
		"Method:       "+LOWER(ALLTRIM(cMethod))
lcCodeLineMsg=MESSAGE(1)
IF BETWEEN(nLine,1,100000) AND NOT lcCodeLineMsg="..."
	lcErrorMsg=lcErrorMsg+CHR(13)+"Line:            "+ALLTRIM(STR(nLine))
	IF NOT EMPTY(lcCodeLineMsg)
		lcErrorMsg=lcErrorMsg+CHR(13)+CHR(13)+lcCodeLineMsg
	ENDIF
ENDIF
WAIT CLEAR
MESSAGEBOX(lcErrorMsg,16,_screen.Caption)
ERROR nError

ENDPROC
PROCEDURE Init
IF this.lSetHost
	this.SetHost
ENDIF
IF this.lAutoSetObjectRefs AND NOT this.SetObjectRefs(this)
	RETURN .F.
ENDIF

ENDPROC
PROCEDURE Destroy
IF this.lRelease
	RETURN .F.
ENDIF
this.lRelease=.T.
this.ReleaseObjRefs
this.oHost=.NULL.

ENDPROC


************************************************************
OBJETO: _shape
************************************************************
*** PROPIEDADES ***
Height = 68
Width = 68
Name = "_shape"
cversion = 
builder = 
builderx = (HOME()+"Wizards\BuilderD,BuilderDForm")
nobjectrefcount = 0
ninstances = 0
ohost = .NULL.
vresult = .T.
csetobjrefprogram = (IIF(VERSION(2)=0,"",HOME()+"FFC\")+"SetObjRf.prg")

*** METODOS ***
PROCEDURE release
LOCAL lcBaseClass

IF this.lRelease
	NODEFAULT
	RETURN .F.
ENDIF
this.lRelease=.T.
lcBaseClass=LOWER(this.BaseClass)
this.oHost=.NULL.
this.ReleaseObjRefs
IF NOT INLIST(lcBaseClass+" ","form ","formset ","toolbar ")
	RELEASE this
ENDIF

ENDPROC
PROCEDURE setobjectref
LPARAMETERS tcName,tvClass,tvClassLibrary
LOCAL lvResult

this.vResult=.T.
DO (this.cSetObjRefProgram) WITH (this),(tcName),(tvClass),(tvClassLibrary)
lvResult=this.vResult
this.vResult=.T.
RETURN lvResult

ENDPROC
PROCEDURE setobjectrefs
LPARAMETERS toObject

RETURN

ENDPROC
PROCEDURE releaseobjrefs
LOCAL lcName,oObject,lnCount

IF this.nObjectRefCount=0
	RETURN
ENDIF
FOR lnCount = this.nObjectRefCount TO 1 STEP -1
	lcName=this.aObjectRefs[lnCount,1]
	IF EMPTY(lcName) OR NOT PEMSTATUS(this,lcName,5) OR TYPE("this."+lcName)#"O"
		LOOP
	ENDIF
	oObject=this.&lcName
	IF ISNULL(oObject)
		LOOP
	ENDIF
	IF TYPE("oObject")=="O" AND NOT ISNULL(oObject) AND PEMSTATUS(oObject,"Release",5)
		oObject.Release
	ENDIF
	IF NOT ISNULL(oObject) AND PEMSTATUS(oObject,"oHost",5)
		oObject.oHost=.NULL.
	ENDIF
	this.&lcName=.NULL.
	oObject=.NULL.
ENDFOR
DIMENSION this.aObjectRefs[1,3]
this.aObjectRefs=""

ENDPROC
PROCEDURE nobjectrefcount_access
LOCAL lnObjectRefCount

lnObjectRefCount=ALEN(this.aObjectRefs,1)
IF lnObjectRefCount=1 AND EMPTY(this.aObjectRefs[1])
	lnObjectRefCount=0
ENDIF
RETURN lnObjectRefCount

ENDPROC
PROCEDURE nobjectrefcount_assign
LPARAMETERS m.vNewVal

ERROR 1743

ENDPROC
PROCEDURE sethost
this.oHost=IIF(TYPE("thisform")=="O",thisform,.NULL.)

ENDPROC
PROCEDURE newinstance
LPARAMETERS tnDataSessionID
LOCAL oNewObject,lnLastDataSessionID

lnLastDataSessionID=SET("DATASESSION")
IF TYPE("tnDataSessionID")=="N" AND tnDataSessionID>=1
	SET DATASESSION TO tnDataSessionID
ENDIF
oNewObject=NEWOBJECT(this.Class,this.ClassLibrary)
SET DATASESSION TO (lnLastDataSessionID)
RETURN oNewObject

ENDPROC
PROCEDURE addtoproject
*-- Dummy code for adding files to project.
RETURN

DO SetObjRf.prg

ENDPROC
PROCEDURE ninstances_access
LOCAL laInstances[1]
	
RETURN AINSTANCE(laInstances,this.Class)

ENDPROC
PROCEDURE ninstances_assign
LPARAMETERS vNewVal

ERROR 1743

ENDPROC
PROCEDURE Error
LPARAMETERS nError, cMethod, nLine
LOCAL lcOnError,lcErrorMsg,lcCodeLineMsg

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
lcErrorMsg=MESSAGE()+CHR(13)+CHR(13)+this.Name+CHR(13)+ ;
		"Error:           "+ALLTRIM(STR(nError))+CHR(13)+ ;
		"Method:       "+LOWER(ALLTRIM(cMethod))
lcCodeLineMsg=MESSAGE(1)
IF BETWEEN(nLine,1,100000) AND NOT lcCodeLineMsg="..."
	lcErrorMsg=lcErrorMsg+CHR(13)+"Line:            "+ALLTRIM(STR(nLine))
	IF NOT EMPTY(lcCodeLineMsg)
		lcErrorMsg=lcErrorMsg+CHR(13)+CHR(13)+lcCodeLineMsg
	ENDIF
ENDIF
WAIT CLEAR
MESSAGEBOX(lcErrorMsg,16,_screen.Caption)
ERROR nError

ENDPROC
PROCEDURE Init
IF this.lSetHost
	this.SetHost
ENDIF
IF this.lAutoSetObjectRefs AND NOT this.SetObjectRefs(this)
	RETURN .F.
ENDIF

ENDPROC
PROCEDURE Destroy
IF this.lRelease
	RETURN .F.
ENDIF
this.lRelease=.T.
this.ReleaseObjRefs
this.oHost=.NULL.

ENDPROC


************************************************************
OBJETO: _spinner
************************************************************
*** PROPIEDADES ***
Height = 24
Width = 120
Name = "_spinner"
cversion = 
builder = 
builderx = (HOME()+"Wizards\BuilderD,BuilderDForm")
nobjectrefcount = 0
ninstances = 0
ohost = .NULL.
vresult = .T.
csetobjrefprogram = (IIF(VERSION(2)=0,"",HOME()+"FFC\")+"SetObjRf.prg")

*** METODOS ***
PROCEDURE release
LOCAL lcBaseClass

IF this.lRelease
	NODEFAULT
	RETURN .F.
ENDIF
this.lRelease=.T.
lcBaseClass=LOWER(this.BaseClass)
this.oHost=.NULL.
this.ReleaseObjRefs
IF NOT INLIST(lcBaseClass+" ","form ","formset ","toolbar ")
	RELEASE this
ENDIF

ENDPROC
PROCEDURE setobjectref
LPARAMETERS tcName,tvClass,tvClassLibrary
LOCAL lvResult

this.vResult=.T.
DO (this.cSetObjRefProgram) WITH (this),(tcName),(tvClass),(tvClassLibrary)
lvResult=this.vResult
this.vResult=.T.
RETURN lvResult

ENDPROC
PROCEDURE setobjectrefs
LPARAMETERS toObject

RETURN

ENDPROC
PROCEDURE releaseobjrefs
LOCAL lcName,oObject,lnCount

IF this.nObjectRefCount=0
	RETURN
ENDIF
FOR lnCount = this.nObjectRefCount TO 1 STEP -1
	lcName=this.aObjectRefs[lnCount,1]
	IF EMPTY(lcName) OR NOT PEMSTATUS(this,lcName,5) OR TYPE("this."+lcName)#"O"
		LOOP
	ENDIF
	oObject=this.&lcName
	IF ISNULL(oObject)
		LOOP
	ENDIF
	IF TYPE("oObject")=="O" AND NOT ISNULL(oObject) AND PEMSTATUS(oObject,"Release",5)
		oObject.Release
	ENDIF
	IF NOT ISNULL(oObject) AND PEMSTATUS(oObject,"oHost",5)
		oObject.oHost=.NULL.
	ENDIF
	this.&lcName=.NULL.
	oObject=.NULL.
ENDFOR
DIMENSION this.aObjectRefs[1,3]
this.aObjectRefs=""

ENDPROC
PROCEDURE nobjectrefcount_access
LOCAL lnObjectRefCount

lnObjectRefCount=ALEN(this.aObjectRefs,1)
IF lnObjectRefCount=1 AND EMPTY(this.aObjectRefs[1])
	lnObjectRefCount=0
ENDIF
RETURN lnObjectRefCount

ENDPROC
PROCEDURE nobjectrefcount_assign
LPARAMETERS m.vNewVal

ERROR 1743

ENDPROC
PROCEDURE sethost
this.oHost=IIF(TYPE("thisform")=="O",thisform,.NULL.)

ENDPROC
PROCEDURE newinstance
LPARAMETERS tnDataSessionID
LOCAL oNewObject,lnLastDataSessionID

lnLastDataSessionID=SET("DATASESSION")
IF TYPE("tnDataSessionID")=="N" AND tnDataSessionID>=1
	SET DATASESSION TO tnDataSessionID
ENDIF
oNewObject=NEWOBJECT(this.Class,this.ClassLibrary)
SET DATASESSION TO (lnLastDataSessionID)
RETURN oNewObject

ENDPROC
PROCEDURE addtoproject
*-- Dummy code for adding files to project.
RETURN

DO SetObjRf.prg

ENDPROC
PROCEDURE ninstances_access
LOCAL laInstances[1]
	
RETURN AINSTANCE(laInstances,this.Class)

ENDPROC
PROCEDURE ninstances_assign
LPARAMETERS vNewVal

ERROR 1743

ENDPROC
PROCEDURE Error
LPARAMETERS nError, cMethod, nLine
LOCAL lcOnError,lcErrorMsg,lcCodeLineMsg

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
lcErrorMsg=MESSAGE()+CHR(13)+CHR(13)+this.Name+CHR(13)+ ;
		"Error:           "+ALLTRIM(STR(nError))+CHR(13)+ ;
		"Method:       "+LOWER(ALLTRIM(cMethod))
lcCodeLineMsg=MESSAGE(1)
IF BETWEEN(nLine,1,100000) AND NOT lcCodeLineMsg="..."
	lcErrorMsg=lcErrorMsg+CHR(13)+"Line:            "+ALLTRIM(STR(nLine))
	IF NOT EMPTY(lcCodeLineMsg)
		lcErrorMsg=lcErrorMsg+CHR(13)+CHR(13)+lcCodeLineMsg
	ENDIF
ENDIF
WAIT CLEAR
MESSAGEBOX(lcErrorMsg,16,_screen.Caption)
ERROR nError

ENDPROC
PROCEDURE Init
IF this.lSetHost
	this.SetHost
ENDIF
IF this.lAutoSetObjectRefs AND NOT this.SetObjectRefs(this)
	RETURN .F.
ENDIF

ENDPROC
PROCEDURE Destroy
IF this.lRelease
	RETURN .F.
ENDIF
this.lRelease=.T.
this.ReleaseObjRefs
this.oHost=.NULL.

ENDPROC


************************************************************
OBJETO: _spinner
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 13, 3, 0

*** METODOS ***


************************************************************
OBJETO: _textbox
************************************************************
*** PROPIEDADES ***
Height = 23
Width = 100
Name = "_textbox"
cversion = 
builder = 
builderx = (HOME()+"Wizards\BuilderD,BuilderDForm")
nobjectrefcount = 0
ninstances = 0
ohost = .NULL.
vresult = .T.
csetobjrefprogram = (IIF(VERSION(2)=0,"",HOME()+"FFC\")+"SetObjRf.prg")

*** METODOS ***
PROCEDURE release
LOCAL lcBaseClass

IF this.lRelease
	NODEFAULT
	RETURN .F.
ENDIF
this.lRelease=.T.
lcBaseClass=LOWER(this.BaseClass)
this.oHost=.NULL.
this.ReleaseObjRefs
IF NOT INLIST(lcBaseClass+" ","form ","formset ","toolbar ")
	RELEASE this
ENDIF

ENDPROC
PROCEDURE setobjectref
LPARAMETERS tcName,tvClass,tvClassLibrary
LOCAL lvResult

this.vResult=.T.
DO (this.cSetObjRefProgram) WITH (this),(tcName),(tvClass),(tvClassLibrary)
lvResult=this.vResult
this.vResult=.T.
RETURN lvResult

ENDPROC
PROCEDURE setobjectrefs
LPARAMETERS toObject

RETURN

ENDPROC
PROCEDURE releaseobjrefs
LOCAL lcName,oObject,lnCount

IF this.nObjectRefCount=0
	RETURN
ENDIF
FOR lnCount = this.nObjectRefCount TO 1 STEP -1
	lcName=this.aObjectRefs[lnCount,1]
	IF EMPTY(lcName) OR NOT PEMSTATUS(this,lcName,5) OR TYPE("this."+lcName)#"O"
		LOOP
	ENDIF
	oObject=this.&lcName
	IF ISNULL(oObject)
		LOOP
	ENDIF
	IF TYPE("oObject")=="O" AND NOT ISNULL(oObject) AND PEMSTATUS(oObject,"Release",5)
		oObject.Release
	ENDIF
	IF NOT ISNULL(oObject) AND PEMSTATUS(oObject,"oHost",5)
		oObject.oHost=.NULL.
	ENDIF
	this.&lcName=.NULL.
	oObject=.NULL.
ENDFOR
DIMENSION this.aObjectRefs[1,3]
this.aObjectRefs=""

ENDPROC
PROCEDURE nobjectrefcount_access
LOCAL lnObjectRefCount

lnObjectRefCount=ALEN(this.aObjectRefs,1)
IF lnObjectRefCount=1 AND EMPTY(this.aObjectRefs[1])
	lnObjectRefCount=0
ENDIF
RETURN lnObjectRefCount

ENDPROC
PROCEDURE nobjectrefcount_assign
LPARAMETERS m.vNewVal

ERROR 1743

ENDPROC
PROCEDURE sethost
this.oHost=IIF(TYPE("thisform")=="O",thisform,.NULL.)

ENDPROC
PROCEDURE newinstance
LPARAMETERS tnDataSessionID
LOCAL oNewObject,lnLastDataSessionID

lnLastDataSessionID=SET("DATASESSION")
IF TYPE("tnDataSessionID")=="N" AND tnDataSessionID>=1
	SET DATASESSION TO tnDataSessionID
ENDIF
oNewObject=NEWOBJECT(this.Class,this.ClassLibrary)
SET DATASESSION TO (lnLastDataSessionID)
RETURN oNewObject

ENDPROC
PROCEDURE addtoproject
*-- Dummy code for adding files to project.
RETURN

DO SetObjRf.prg

ENDPROC
PROCEDURE ninstances_access
LOCAL laInstances[1]
	
RETURN AINSTANCE(laInstances,this.Class)

ENDPROC
PROCEDURE ninstances_assign
LPARAMETERS vNewVal

ERROR 1743

ENDPROC
PROCEDURE Error
LPARAMETERS nError, cMethod, nLine
LOCAL lcOnError,lcErrorMsg,lcCodeLineMsg

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
lcErrorMsg=MESSAGE()+CHR(13)+CHR(13)+this.Name+CHR(13)+ ;
		"Error:           "+ALLTRIM(STR(nError))+CHR(13)+ ;
		"Method:       "+LOWER(ALLTRIM(cMethod))
lcCodeLineMsg=MESSAGE(1)
IF BETWEEN(nLine,1,100000) AND NOT lcCodeLineMsg="..."
	lcErrorMsg=lcErrorMsg+CHR(13)+"Line:            "+ALLTRIM(STR(nLine))
	IF NOT EMPTY(lcCodeLineMsg)
		lcErrorMsg=lcErrorMsg+CHR(13)+CHR(13)+lcCodeLineMsg
	ENDIF
ENDIF
WAIT CLEAR
MESSAGEBOX(lcErrorMsg,16,_screen.Caption)
ERROR nError

ENDPROC
PROCEDURE Init
IF this.lSetHost
	this.SetHost
ENDIF
IF this.lAutoSetObjectRefs AND NOT this.SetObjectRefs(this)
	RETURN .F.
ENDIF

ENDPROC
PROCEDURE Destroy
IF this.lRelease
	RETURN .F.
ENDIF
this.lRelease=.T.
this.ReleaseObjRefs
this.oHost=.NULL.

ENDPROC


************************************************************
OBJETO: _textbox
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 13, 3, 0

*** METODOS ***


************************************************************
OBJETO: _timer
************************************************************
*** PROPIEDADES ***
Height = 23
Width = 23
Name = "_timer"
cversion = 
builder = 
builderx = (HOME()+"Wizards\BuilderD,BuilderDForm")
nobjectrefcount = 0
ninstances = 0
ohost = .NULL.
vresult = .T.
csetobjrefprogram = (IIF(VERSION(2)=0,"",HOME()+"FFC\")+"SetObjRf.prg")

*** METODOS ***
PROCEDURE release
LOCAL lcBaseClass

IF this.lRelease
	NODEFAULT
	RETURN .F.
ENDIF
this.lRelease=.T.
lcBaseClass=LOWER(this.BaseClass)
this.oHost=.NULL.
this.ReleaseObjRefs
IF NOT INLIST(lcBaseClass+" ","form ","formset ","toolbar ")
	RELEASE this
ENDIF

ENDPROC
PROCEDURE setobjectref
LPARAMETERS tcName,tvClass,tvClassLibrary
LOCAL lvResult

this.vResult=.T.
DO (this.cSetObjRefProgram) WITH (this),(tcName),(tvClass),(tvClassLibrary)
lvResult=this.vResult
this.vResult=.T.
RETURN lvResult

ENDPROC
PROCEDURE setobjectrefs
LPARAMETERS toObject

RETURN

ENDPROC
PROCEDURE releaseobjrefs
LOCAL lcName,oObject,lnCount

IF this.nObjectRefCount=0
	RETURN
ENDIF
FOR lnCount = this.nObjectRefCount TO 1 STEP -1
	lcName=this.aObjectRefs[lnCount,1]
	IF EMPTY(lcName) OR NOT PEMSTATUS(this,lcName,5) OR TYPE("this."+lcName)#"O"
		LOOP
	ENDIF
	oObject=this.&lcName
	IF ISNULL(oObject)
		LOOP
	ENDIF
	IF TYPE("oObject")=="O" AND NOT ISNULL(oObject) AND PEMSTATUS(oObject,"Release",5)
		oObject.Release
	ENDIF
	IF NOT ISNULL(oObject) AND PEMSTATUS(oObject,"oHost",5)
		oObject.oHost=.NULL.
	ENDIF
	this.&lcName=.NULL.
	oObject=.NULL.
ENDFOR
DIMENSION this.aObjectRefs[1,3]
this.aObjectRefs=""

ENDPROC
PROCEDURE nobjectrefcount_access
LOCAL lnObjectRefCount

lnObjectRefCount=ALEN(this.aObjectRefs,1)
IF lnObjectRefCount=1 AND EMPTY(this.aObjectRefs[1])
	lnObjectRefCount=0
ENDIF
RETURN lnObjectRefCount

ENDPROC
PROCEDURE nobjectrefcount_assign
LPARAMETERS m.vNewVal

ERROR 1743

ENDPROC
PROCEDURE sethost
this.oHost=IIF(TYPE("thisform")=="O",thisform,.NULL.)

ENDPROC
PROCEDURE newinstance
LPARAMETERS tnDataSessionID
LOCAL oNewObject,lnLastDataSessionID

lnLastDataSessionID=SET("DATASESSION")
IF TYPE("tnDataSessionID")=="N" AND tnDataSessionID>=1
	SET DATASESSION TO tnDataSessionID
ENDIF
oNewObject=NEWOBJECT(this.Class,this.ClassLibrary)
SET DATASESSION TO (lnLastDataSessionID)
RETURN oNewObject

ENDPROC
PROCEDURE addtoproject
*-- Dummy code for adding files to project.
RETURN

DO SetObjRf.prg

ENDPROC
PROCEDURE ninstances_access
LOCAL laInstances[1]
	
RETURN AINSTANCE(laInstances,this.Class)

ENDPROC
PROCEDURE ninstances_assign
LPARAMETERS vNewVal

ERROR 1743

ENDPROC
PROCEDURE Error
LPARAMETERS nError, cMethod, nLine
LOCAL lcOnError,lcErrorMsg,lcCodeLineMsg

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
lcErrorMsg=MESSAGE()+CHR(13)+CHR(13)+this.Name+CHR(13)+ ;
		"Error:           "+ALLTRIM(STR(nError))+CHR(13)+ ;
		"Method:       "+LOWER(ALLTRIM(cMethod))
lcCodeLineMsg=MESSAGE(1)
IF BETWEEN(nLine,1,100000) AND NOT lcCodeLineMsg="..."
	lcErrorMsg=lcErrorMsg+CHR(13)+"Line:            "+ALLTRIM(STR(nLine))
	IF NOT EMPTY(lcCodeLineMsg)
		lcErrorMsg=lcErrorMsg+CHR(13)+CHR(13)+lcCodeLineMsg
	ENDIF
ENDIF
WAIT CLEAR
MESSAGEBOX(lcErrorMsg,16,_screen.Caption)
ERROR nError

ENDPROC
PROCEDURE Init
IF this.lSetHost
	this.SetHost
ENDIF
IF this.lAutoSetObjectRefs AND NOT this.SetObjectRefs(this)
	RETURN .F.
ENDIF

ENDPROC
PROCEDURE Destroy
IF this.lRelease
	RETURN .F.
ENDIF
this.lRelease=.T.
this.ReleaseObjRefs
this.oHost=.NULL.

ENDPROC


************************************************************
OBJETO: _formset
************************************************************
*** PROPIEDADES ***
Name = "_formset"
cversion = 
builder = 
builderx = (HOME()+"Wizards\BuilderD,BuilderDForm")
nobjectrefcount = 0
ninstances = 0
ohost = .NULL.
vresult = .T.
csetobjrefprogram = (IIF(VERSION(2)=0,"",HOME()+"FFC\")+"SetObjRf.prg")

*** METODOS ***
PROCEDURE release
LOCAL lcBaseClass

IF this.lRelease
	NODEFAULT
	RETURN .F.
ENDIF
this.lRelease=.T.
lcBaseClass=LOWER(this.BaseClass)
this.oHost=.NULL.
this.ReleaseObjRefs
IF NOT INLIST(lcBaseClass+" ","form ","formset ","toolbar ")
	RELEASE this
ENDIF

ENDPROC
PROCEDURE setobjectref
LPARAMETERS tcName,tvClass,tvClassLibrary
LOCAL lvResult

this.vResult=.T.
DO (this.cSetObjRefProgram) WITH (this),(tcName),(tvClass),(tvClassLibrary)
lvResult=this.vResult
this.vResult=.T.
RETURN lvResult

ENDPROC
PROCEDURE setobjectrefs
LPARAMETERS toObject

RETURN

ENDPROC
PROCEDURE releaseobjrefs
LOCAL lcName,oObject,lnCount

IF this.nObjectRefCount=0
	RETURN
ENDIF
FOR lnCount = this.nObjectRefCount TO 1 STEP -1
	lcName=this.aObjectRefs[lnCount,1]
	IF EMPTY(lcName) OR NOT PEMSTATUS(this,lcName,5) OR TYPE("this."+lcName)#"O"
		LOOP
	ENDIF
	oObject=this.&lcName
	IF ISNULL(oObject)
		LOOP
	ENDIF
	IF TYPE("oObject")=="O" AND NOT ISNULL(oObject) AND PEMSTATUS(oObject,"Release",5)
		oObject.Release
	ENDIF
	IF NOT ISNULL(oObject) AND PEMSTATUS(oObject,"oHost",5)
		oObject.oHost=.NULL.
	ENDIF
	this.&lcName=.NULL.
	oObject=.NULL.
ENDFOR
DIMENSION this.aObjectRefs[1,3]
this.aObjectRefs=""

ENDPROC
PROCEDURE nobjectrefcount_access
LOCAL lnObjectRefCount

lnObjectRefCount=ALEN(this.aObjectRefs,1)
IF lnObjectRefCount=1 AND EMPTY(this.aObjectRefs[1])
	lnObjectRefCount=0
ENDIF
RETURN lnObjectRefCount

ENDPROC
PROCEDURE nobjectrefcount_assign
LPARAMETERS m.vNewVal

ERROR 1743

ENDPROC
PROCEDURE sethost
this.oHost=IIF(TYPE("thisform")=="O",thisform,.NULL.)

ENDPROC
PROCEDURE newinstance
LPARAMETERS tnDataSessionID
LOCAL oNewObject,lnLastDataSessionID

lnLastDataSessionID=SET("DATASESSION")
IF TYPE("tnDataSessionID")=="N" AND tnDataSessionID>=1
	SET DATASESSION TO tnDataSessionID
ENDIF
oNewObject=NEWOBJECT(this.Class,this.ClassLibrary)
SET DATASESSION TO (lnLastDataSessionID)
RETURN oNewObject

ENDPROC
PROCEDURE addtoproject
*-- Dummy code for adding files to project.
RETURN

DO SetObjRf.prg

ENDPROC
PROCEDURE ninstances_access
LOCAL laInstances[1]
	
RETURN AINSTANCE(laInstances,this.Class)

ENDPROC
PROCEDURE ninstances_assign
LPARAMETERS vNewVal

ERROR 1743

ENDPROC
PROCEDURE Error
LPARAMETERS nError, cMethod, nLine
LOCAL lcOnError,lcErrorMsg,lcCodeLineMsg

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
lcErrorMsg=MESSAGE()+CHR(13)+CHR(13)+this.Name+CHR(13)+ ;
		"Error:           "+ALLTRIM(STR(nError))+CHR(13)+ ;
		"Method:       "+LOWER(ALLTRIM(cMethod))
lcCodeLineMsg=MESSAGE(1)
IF BETWEEN(nLine,1,100000) AND NOT lcCodeLineMsg="..."
	lcErrorMsg=lcErrorMsg+CHR(13)+"Line:            "+ALLTRIM(STR(nLine))
	IF NOT EMPTY(lcCodeLineMsg)
		lcErrorMsg=lcErrorMsg+CHR(13)+CHR(13)+lcCodeLineMsg
	ENDIF
ENDIF
WAIT CLEAR
MESSAGEBOX(lcErrorMsg,16,_screen.Caption)
ERROR nError

ENDPROC
PROCEDURE Init
IF this.lSetHost
	this.SetHost
ENDIF
IF this.lAutoSetObjectRefs AND NOT this.SetObjectRefs(this)
	RETURN .F.
ENDIF

ENDPROC
PROCEDURE Destroy
IF this.lRelease
	RETURN .F.
ENDIF
this.lRelease=.T.
this.ReleaseObjRefs
this.oHost=.NULL.

ENDPROC


************************************************************
OBJETO: Form1
************************************************************
*** PROPIEDADES ***
DoCreate = .T.
Caption = "Form1"
Name = "Form1"
cversion = 
builder = 
builderx = (HOME()+"Wizards\BuilderD,BuilderDForm")
nobjectrefcount = 0
ninstances = 0
ohost = .NULL.
vresult = .T.
csetobjrefprogram = (IIF(VERSION(2)=0,"",HOME()+"FFC\")+"SetObjRf.prg")

*** METODOS ***
PROCEDURE release
LOCAL lcBaseClass

IF this.lRelease
	NODEFAULT
	RETURN .F.
ENDIF
this.lRelease=.T.
lcBaseClass=LOWER(this.BaseClass)
this.oHost=.NULL.
this.ReleaseObjRefs
IF NOT INLIST(lcBaseClass+" ","form ","formset ","toolbar ")
	RELEASE this
ENDIF

ENDPROC
PROCEDURE setobjectref
LPARAMETERS tcName,tvClass,tvClassLibrary
LOCAL lvResult

this.vResult=.T.
DO (this.cSetObjRefProgram) WITH (this),(tcName),(tvClass),(tvClassLibrary)
lvResult=this.vResult
this.vResult=.T.
RETURN lvResult

ENDPROC
PROCEDURE setobjectrefs
LPARAMETERS toObject

RETURN

ENDPROC
PROCEDURE releaseobjrefs
LOCAL lcName,oObject,lnCount

IF this.nObjectRefCount=0
	RETURN
ENDIF
FOR lnCount = this.nObjectRefCount TO 1 STEP -1
	lcName=this.aObjectRefs[lnCount,1]
	IF EMPTY(lcName) OR NOT PEMSTATUS(this,lcName,5) OR TYPE("this."+lcName)#"O"
		LOOP
	ENDIF
	oObject=this.&lcName
	IF ISNULL(oObject)
		LOOP
	ENDIF
	IF TYPE("oObject")=="O" AND NOT ISNULL(oObject) AND PEMSTATUS(oObject,"Release",5)
		oObject.Release
	ENDIF
	IF NOT ISNULL(oObject) AND PEMSTATUS(oObject,"oHost",5)
		oObject.oHost=.NULL.
	ENDIF
	this.&lcName=.NULL.
	oObject=.NULL.
ENDFOR
DIMENSION this.aObjectRefs[1,3]
this.aObjectRefs=""

ENDPROC
PROCEDURE nobjectrefcount_access
LOCAL lnObjectRefCount

lnObjectRefCount=ALEN(this.aObjectRefs,1)
IF lnObjectRefCount=1 AND EMPTY(this.aObjectRefs[1])
	lnObjectRefCount=0
ENDIF
RETURN lnObjectRefCount

ENDPROC
PROCEDURE nobjectrefcount_assign
LPARAMETERS m.vNewVal

ERROR 1743

ENDPROC
PROCEDURE sethost
this.oHost=IIF(TYPE("thisform")=="O",thisform,.NULL.)

ENDPROC
PROCEDURE newinstance
LPARAMETERS tnDataSessionID
LOCAL oNewObject,lnLastDataSessionID

lnLastDataSessionID=SET("DATASESSION")
IF TYPE("tnDataSessionID")=="N" AND tnDataSessionID>=1
	SET DATASESSION TO tnDataSessionID
ENDIF
oNewObject=NEWOBJECT(this.Class,this.ClassLibrary)
SET DATASESSION TO (lnLastDataSessionID)
RETURN oNewObject

ENDPROC
PROCEDURE addtoproject
*-- Dummy code for adding files to project.
RETURN

DO SetObjRf.prg

ENDPROC
PROCEDURE ninstances_access
LOCAL laInstances[1]
	
RETURN AINSTANCE(laInstances,this.Class)

ENDPROC
PROCEDURE ninstances_assign
LPARAMETERS vNewVal

ERROR 1743

ENDPROC
PROCEDURE Error
LPARAMETERS nError, cMethod, nLine
LOCAL lcOnError,lcErrorMsg,lcCodeLineMsg

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
lcErrorMsg=MESSAGE()+CHR(13)+CHR(13)+this.Name+CHR(13)+ ;
		"Error:           "+ALLTRIM(STR(nError))+CHR(13)+ ;
		"Method:       "+LOWER(ALLTRIM(cMethod))
lcCodeLineMsg=MESSAGE(1)
IF BETWEEN(nLine,1,100000) AND NOT lcCodeLineMsg="..."
	lcErrorMsg=lcErrorMsg+CHR(13)+"Line:            "+ALLTRIM(STR(nLine))
	IF NOT EMPTY(lcCodeLineMsg)
		lcErrorMsg=lcErrorMsg+CHR(13)+CHR(13)+lcCodeLineMsg
	ENDIF
ENDIF
WAIT CLEAR
MESSAGEBOX(lcErrorMsg,16,_screen.Caption)
ERROR nError

ENDPROC
PROCEDURE Init
IF this.lSetHost
	this.SetHost
ENDIF
IF this.lAutoSetObjectRefs AND NOT this.SetObjectRefs(this)
	RETURN .F.
ENDIF

ENDPROC
PROCEDURE Destroy
IF this.lRelease
	RETURN .F.
ENDIF
this.lRelease=.T.
this.ReleaseObjRefs
this.oHost=.NULL.

ENDPROC


************************************************************
OBJETO: _formset
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 13, 3, 0

*** METODOS ***


************************************************************
OBJETO: _activedoc
************************************************************
*** PROPIEDADES ***
Height = 68
Width = 68
Name = "_activedoc"
cversion = 
builder = 
builderx = (HOME()+"Wizards\BuilderD,BuilderDForm")
nobjectrefcount = 0
ninstances = 0
ohost = .NULL.
vresult = .T.
csetobjrefprogram = (IIF(VERSION(2)=0,"",HOME()+"FFC\")+"SetObjRf.prg")

*** METODOS ***
PROCEDURE release
LOCAL lcBaseClass

IF this.lRelease
	NODEFAULT
	RETURN .F.
ENDIF
this.lRelease=.T.
lcBaseClass=LOWER(this.BaseClass)
this.oHost=.NULL.
this.ReleaseObjRefs
IF NOT INLIST(lcBaseClass+" ","form ","formset ","toolbar ")
	RELEASE this
ENDIF

ENDPROC
PROCEDURE setobjectref
LPARAMETERS tcName,tvClass,tvClassLibrary
LOCAL lvResult

this.vResult=.T.
DO (this.cSetObjRefProgram) WITH (this),(tcName),(tvClass),(tvClassLibrary)
lvResult=this.vResult
this.vResult=.T.
RETURN lvResult

ENDPROC
PROCEDURE setobjectrefs
LPARAMETERS toObject

RETURN

ENDPROC
PROCEDURE releaseobjrefs
LOCAL lcName,oObject,lnCount

IF this.nObjectRefCount=0
	RETURN
ENDIF
FOR lnCount = this.nObjectRefCount TO 1 STEP -1
	lcName=this.aObjectRefs[lnCount,1]
	IF EMPTY(lcName) OR NOT PEMSTATUS(this,lcName,5) OR TYPE("this."+lcName)#"O"
		LOOP
	ENDIF
	oObject=this.&lcName
	IF ISNULL(oObject)
		LOOP
	ENDIF
	IF TYPE("oObject")=="O" AND NOT ISNULL(oObject) AND PEMSTATUS(oObject,"Release",5)
		oObject.Release
	ENDIF
	IF NOT ISNULL(oObject) AND PEMSTATUS(oObject,"oHost",5)
		oObject.oHost=.NULL.
	ENDIF
	this.&lcName=.NULL.
	oObject=.NULL.
ENDFOR
DIMENSION this.aObjectRefs[1,3]
this.aObjectRefs=""

ENDPROC
PROCEDURE nobjectrefcount_access
LOCAL lnObjectRefCount

lnObjectRefCount=ALEN(this.aObjectRefs,1)
IF lnObjectRefCount=1 AND EMPTY(this.aObjectRefs[1])
	lnObjectRefCount=0
ENDIF
RETURN lnObjectRefCount

ENDPROC
PROCEDURE nobjectrefcount_assign
LPARAMETERS m.vNewVal

ERROR 1743

ENDPROC
PROCEDURE sethost
this.oHost=IIF(TYPE("thisform")=="O",thisform,.NULL.)

ENDPROC
PROCEDURE newinstance
LPARAMETERS tnDataSessionID
LOCAL oNewObject,lnLastDataSessionID

lnLastDataSessionID=SET("DATASESSION")
IF TYPE("tnDataSessionID")=="N" AND tnDataSessionID>=1
	SET DATASESSION TO tnDataSessionID
ENDIF
oNewObject=NEWOBJECT(this.Class,this.ClassLibrary)
SET DATASESSION TO (lnLastDataSessionID)
RETURN oNewObject

ENDPROC
PROCEDURE addtoproject
*-- Dummy code for adding files to project.
RETURN

DO SetObjRf.prg

ENDPROC
PROCEDURE ninstances_access
LOCAL laInstances[1]
	
RETURN AINSTANCE(laInstances,this.Class)

ENDPROC
PROCEDURE ninstances_assign
LPARAMETERS vNewVal

ERROR 1743

ENDPROC
PROCEDURE Error
LPARAMETERS nError, cMethod, nLine
LOCAL lcOnError,lcErrorMsg,lcCodeLineMsg

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
lcErrorMsg=MESSAGE()+CHR(13)+CHR(13)+this.Name+CHR(13)+ ;
		"Error:           "+ALLTRIM(STR(nError))+CHR(13)+ ;
		"Method:       "+LOWER(ALLTRIM(cMethod))
lcCodeLineMsg=MESSAGE(1)
IF BETWEEN(nLine,1,100000) AND NOT lcCodeLineMsg="..."
	lcErrorMsg=lcErrorMsg+CHR(13)+"Line:            "+ALLTRIM(STR(nLine))
	IF NOT EMPTY(lcCodeLineMsg)
		lcErrorMsg=lcErrorMsg+CHR(13)+CHR(13)+lcCodeLineMsg
	ENDIF
ENDIF
WAIT CLEAR
MESSAGEBOX(lcErrorMsg,16,_screen.Caption)
ERROR nError

ENDPROC
PROCEDURE Init
IF this.lSetHost
	this.SetHost
ENDIF
IF this.lAutoSetObjectRefs AND NOT this.SetObjectRefs(this)
	RETURN .F.
ENDIF

ENDPROC
PROCEDURE Destroy
IF this.lRelease
	RETURN .F.
ENDIF
this.lRelease=.T.
this.ReleaseObjRefs
this.oHost=.NULL.

ENDPROC


************************************************************
OBJETO: _hyperlink
************************************************************
*** PROPIEDADES ***
Height = 23
Width = 23
Name = "_hyperlink"
cversion = 
builder = 
builderx = (HOME()+"Wizards\BuilderD,BuilderDForm")
nobjectrefcount = 0
ninstances = 0
ohost = .NULL.
vresult = .T.
csetobjrefprogram = (IIF(VERSION(2)=0,"",HOME()+"FFC\")+"SetObjRf.prg")

*** METODOS ***
PROCEDURE release
LOCAL lcBaseClass

IF this.lRelease
	NODEFAULT
	RETURN .F.
ENDIF
this.lRelease=.T.
lcBaseClass=LOWER(this.BaseClass)
this.oHost=.NULL.
this.ReleaseObjRefs
IF NOT INLIST(lcBaseClass+" ","form ","formset ","toolbar ")
	RELEASE this
ENDIF

ENDPROC
PROCEDURE setobjectref
LPARAMETERS tcName,tvClass,tvClassLibrary
LOCAL lvResult

this.vResult=.T.
DO (this.cSetObjRefProgram) WITH (this),(tcName),(tvClass),(tvClassLibrary)
lvResult=this.vResult
this.vResult=.T.
RETURN lvResult

ENDPROC
PROCEDURE setobjectrefs
LPARAMETERS toObject

RETURN

ENDPROC
PROCEDURE releaseobjrefs
LOCAL lcName,oObject,lnCount

IF this.nObjectRefCount=0
	RETURN
ENDIF
FOR lnCount = this.nObjectRefCount TO 1 STEP -1
	lcName=this.aObjectRefs[lnCount,1]
	IF EMPTY(lcName) OR NOT PEMSTATUS(this,lcName,5) OR TYPE("this."+lcName)#"O"
		LOOP
	ENDIF
	oObject=this.&lcName
	IF ISNULL(oObject)
		LOOP
	ENDIF
	IF TYPE("oObject")=="O" AND NOT ISNULL(oObject) AND PEMSTATUS(oObject,"Release",5)
		oObject.Release
	ENDIF
	IF NOT ISNULL(oObject) AND PEMSTATUS(oObject,"oHost",5)
		oObject.oHost=.NULL.
	ENDIF
	this.&lcName=.NULL.
	oObject=.NULL.
ENDFOR
DIMENSION this.aObjectRefs[1,3]
this.aObjectRefs=""

ENDPROC
PROCEDURE nobjectrefcount_access
LOCAL lnObjectRefCount

lnObjectRefCount=ALEN(this.aObjectRefs,1)
IF lnObjectRefCount=1 AND EMPTY(this.aObjectRefs[1])
	lnObjectRefCount=0
ENDIF
RETURN lnObjectRefCount

ENDPROC
PROCEDURE nobjectrefcount_assign
LPARAMETERS m.vNewVal

ERROR 1743

ENDPROC
PROCEDURE sethost
this.oHost=IIF(TYPE("thisform")=="O",thisform,.NULL.)

ENDPROC
PROCEDURE newinstance
LPARAMETERS tnDataSessionID
LOCAL oNewObject,lnLastDataSessionID

lnLastDataSessionID=SET("DATASESSION")
IF TYPE("tnDataSessionID")=="N" AND tnDataSessionID>=1
	SET DATASESSION TO tnDataSessionID
ENDIF
oNewObject=NEWOBJECT(this.Class,this.ClassLibrary)
SET DATASESSION TO (lnLastDataSessionID)
RETURN oNewObject

ENDPROC
PROCEDURE addtoproject
*-- Dummy code for adding files to project.
RETURN

DO SetObjRf.prg

ENDPROC
PROCEDURE ninstances_access
LOCAL laInstances[1]
	
RETURN AINSTANCE(laInstances,this.Class)

ENDPROC
PROCEDURE ninstances_assign
LPARAMETERS vNewVal

ERROR 1743

ENDPROC
PROCEDURE Error
LPARAMETERS nError, cMethod, nLine
LOCAL lcOnError,lcErrorMsg,lcCodeLineMsg

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
lcErrorMsg=MESSAGE()+CHR(13)+CHR(13)+this.Name+CHR(13)+ ;
		"Error:           "+ALLTRIM(STR(nError))+CHR(13)+ ;
		"Method:       "+LOWER(ALLTRIM(cMethod))
lcCodeLineMsg=MESSAGE(1)
IF BETWEEN(nLine,1,100000) AND NOT lcCodeLineMsg="..."
	lcErrorMsg=lcErrorMsg+CHR(13)+"Line:            "+ALLTRIM(STR(nLine))
	IF NOT EMPTY(lcCodeLineMsg)
		lcErrorMsg=lcErrorMsg+CHR(13)+CHR(13)+lcCodeLineMsg
	ENDIF
ENDIF
WAIT CLEAR
MESSAGEBOX(lcErrorMsg,16,_screen.Caption)
ERROR nError

ENDPROC
PROCEDURE Init
IF this.lSetHost
	this.SetHost
ENDIF
IF this.lAutoSetObjectRefs AND NOT this.SetObjectRefs(this)
	RETURN .F.
ENDIF

ENDPROC
PROCEDURE Destroy
IF this.lRelease
	RETURN .F.
ENDIF
this.lRelease=.T.
this.ReleaseObjRefs
this.oHost=.NULL.

ENDPROC


************************************************************
OBJETO: _label
************************************************************
*** PROPIEDADES ***
Caption = "Label1"
Height = 16
Width = 40
Name = "_label"
cversion = 
builder = 
builderx = (HOME()+"Wizards\BuilderD,BuilderDForm")
nobjectrefcount = 0
ninstances = 0
ohost = .NULL.
vresult = .T.
csetobjrefprogram = (IIF(VERSION(2)=0,"",HOME()+"FFC\")+"SetObjRf.prg")

*** METODOS ***
PROCEDURE release
LOCAL lcBaseClass

IF this.lRelease
	NODEFAULT
	RETURN .F.
ENDIF
this.lRelease=.T.
lcBaseClass=LOWER(this.BaseClass)
this.oHost=.NULL.
this.ReleaseObjRefs
IF NOT INLIST(lcBaseClass+" ","form ","formset ","toolbar ")
	RELEASE this
ENDIF

ENDPROC
PROCEDURE setobjectref
LPARAMETERS tcName,tvClass,tvClassLibrary
LOCAL lvResult

this.vResult=.T.
DO (this.cSetObjRefProgram) WITH (this),(tcName),(tvClass),(tvClassLibrary)
lvResult=this.vResult
this.vResult=.T.
RETURN lvResult

ENDPROC
PROCEDURE setobjectrefs
LPARAMETERS toObject

RETURN

ENDPROC
PROCEDURE releaseobjrefs
LOCAL lcName,oObject,lnCount

IF this.nObjectRefCount=0
	RETURN
ENDIF
FOR lnCount = this.nObjectRefCount TO 1 STEP -1
	lcName=this.aObjectRefs[lnCount,1]
	IF EMPTY(lcName) OR NOT PEMSTATUS(this,lcName,5) OR TYPE("this."+lcName)#"O"
		LOOP
	ENDIF
	oObject=this.&lcName
	IF ISNULL(oObject)
		LOOP
	ENDIF
	IF TYPE("oObject")=="O" AND NOT ISNULL(oObject) AND PEMSTATUS(oObject,"Release",5)
		oObject.Release
	ENDIF
	IF NOT ISNULL(oObject) AND PEMSTATUS(oObject,"oHost",5)
		oObject.oHost=.NULL.
	ENDIF
	this.&lcName=.NULL.
	oObject=.NULL.
ENDFOR
DIMENSION this.aObjectRefs[1,3]
this.aObjectRefs=""

ENDPROC
PROCEDURE nobjectrefcount_access
LOCAL lnObjectRefCount

lnObjectRefCount=ALEN(this.aObjectRefs,1)
IF lnObjectRefCount=1 AND EMPTY(this.aObjectRefs[1])
	lnObjectRefCount=0
ENDIF
RETURN lnObjectRefCount

ENDPROC
PROCEDURE nobjectrefcount_assign
LPARAMETERS m.vNewVal

ERROR 1743

ENDPROC
PROCEDURE sethost
this.oHost=IIF(TYPE("thisform")=="O",thisform,.NULL.)

ENDPROC
PROCEDURE newinstance
LPARAMETERS tnDataSessionID
LOCAL oNewObject,lnLastDataSessionID

lnLastDataSessionID=SET("DATASESSION")
IF TYPE("tnDataSessionID")=="N" AND tnDataSessionID>=1
	SET DATASESSION TO tnDataSessionID
ENDIF
oNewObject=NEWOBJECT(this.Class,this.ClassLibrary)
SET DATASESSION TO (lnLastDataSessionID)
RETURN oNewObject

ENDPROC
PROCEDURE addtoproject
*-- Dummy code for adding files to project.
RETURN

DO SetObjRf.prg

ENDPROC
PROCEDURE ninstances_access
LOCAL laInstances[1]
	
RETURN AINSTANCE(laInstances,this.Class)

ENDPROC
PROCEDURE ninstances_assign
LPARAMETERS vNewVal

ERROR 1743

ENDPROC
PROCEDURE Error
LPARAMETERS nError, cMethod, nLine
LOCAL lcOnError,lcErrorMsg,lcCodeLineMsg

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
lcErrorMsg=MESSAGE()+CHR(13)+CHR(13)+this.Name+CHR(13)+ ;
		"Error:           "+ALLTRIM(STR(nError))+CHR(13)+ ;
		"Method:       "+LOWER(ALLTRIM(cMethod))
lcCodeLineMsg=MESSAGE(1)
IF BETWEEN(nLine,1,100000) AND NOT lcCodeLineMsg="..."
	lcErrorMsg=lcErrorMsg+CHR(13)+"Line:            "+ALLTRIM(STR(nLine))
	IF NOT EMPTY(lcCodeLineMsg)
		lcErrorMsg=lcErrorMsg+CHR(13)+CHR(13)+lcCodeLineMsg
	ENDIF
ENDIF
WAIT CLEAR
MESSAGEBOX(lcErrorMsg,16,_screen.Caption)
ERROR nError

ENDPROC
PROCEDURE Init
IF this.lSetHost
	this.SetHost
ENDIF
IF this.lAutoSetObjectRefs AND NOT this.SetObjectRefs(this)
	RETURN .F.
ENDIF

ENDPROC
PROCEDURE Destroy
IF this.lRelease
	RETURN .F.
ENDIF
this.lRelease=.T.
this.ReleaseObjRefs
this.oHost=.NULL.

ENDPROC


************************************************************
OBJETO: _projecthook
************************************************************
*** PROPIEDADES ***
Height = 68
Width = 68
Name = "_projecthook"
cversion = 
builder = 
builderx = (HOME()+"Wizards\BuilderD,BuilderDForm")
nobjectrefcount = 0
ninstances = 0
ohost = .NULL.
vresult = .T.
csetobjrefprogram = (IIF(VERSION(2)=0,"",HOME()+"FFC\")+"SetObjRf.prg")

*** METODOS ***
PROCEDURE release
LOCAL lcBaseClass

IF this.lRelease
	NODEFAULT
	RETURN .F.
ENDIF
this.lRelease=.T.
lcBaseClass=LOWER(this.BaseClass)
this.oHost=.NULL.
this.ReleaseObjRefs
IF NOT INLIST(lcBaseClass+" ","form ","formset ","toolbar ")
	RELEASE this
ENDIF

ENDPROC
PROCEDURE setobjectref
LPARAMETERS tcName,tvClass,tvClassLibrary
LOCAL lvResult

this.vResult=.T.
DO (this.cSetObjRefProgram) WITH (this),(tcName),(tvClass),(tvClassLibrary)
lvResult=this.vResult
this.vResult=.T.
RETURN lvResult

ENDPROC
PROCEDURE setobjectrefs
LPARAMETERS toObject

RETURN

ENDPROC
PROCEDURE releaseobjrefs
LOCAL lcName,oObject,lnCount

IF this.nObjectRefCount=0
	RETURN
ENDIF
FOR lnCount = this.nObjectRefCount TO 1 STEP -1
	lcName=this.aObjectRefs[lnCount,1]
	IF EMPTY(lcName) OR NOT PEMSTATUS(this,lcName,5) OR TYPE("this."+lcName)#"O"
		LOOP
	ENDIF
	oObject=this.&lcName
	IF ISNULL(oObject)
		LOOP
	ENDIF
	IF TYPE("oObject")=="O" AND NOT ISNULL(oObject) AND PEMSTATUS(oObject,"Release",5)
		oObject.Release
	ENDIF
	IF NOT ISNULL(oObject) AND PEMSTATUS(oObject,"oHost",5)
		oObject.oHost=.NULL.
	ENDIF
	this.&lcName=.NULL.
	oObject=.NULL.
ENDFOR
DIMENSION this.aObjectRefs[1,3]
this.aObjectRefs=""

ENDPROC
PROCEDURE nobjectrefcount_access
LOCAL lnObjectRefCount

lnObjectRefCount=ALEN(this.aObjectRefs,1)
IF lnObjectRefCount=1 AND EMPTY(this.aObjectRefs[1])
	lnObjectRefCount=0
ENDIF
RETURN lnObjectRefCount

ENDPROC
PROCEDURE nobjectrefcount_assign
LPARAMETERS m.vNewVal

ERROR 1743

ENDPROC
PROCEDURE sethost
this.oHost=IIF(TYPE("thisform")=="O",thisform,.NULL.)

ENDPROC
PROCEDURE newinstance
LPARAMETERS tnDataSessionID
LOCAL oNewObject,lnLastDataSessionID

lnLastDataSessionID=SET("DATASESSION")
IF TYPE("tnDataSessionID")=="N" AND tnDataSessionID>=1
	SET DATASESSION TO tnDataSessionID
ENDIF
oNewObject=NEWOBJECT(this.Class,this.ClassLibrary)
SET DATASESSION TO (lnLastDataSessionID)
RETURN oNewObject

ENDPROC
PROCEDURE addtoproject
*-- Dummy code for adding files to project.
RETURN

DO SetObjRf.prg

ENDPROC
PROCEDURE ninstances_access
LOCAL laInstances[1]
	
RETURN AINSTANCE(laInstances,this.Class)

ENDPROC
PROCEDURE ninstances_assign
LPARAMETERS vNewVal

ERROR 1743

ENDPROC
PROCEDURE Error
LPARAMETERS nError, cMethod, nLine
LOCAL lcOnError,lcErrorMsg,lcCodeLineMsg

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
lcErrorMsg=MESSAGE()+CHR(13)+CHR(13)+this.Name+CHR(13)+ ;
		"Error:           "+ALLTRIM(STR(nError))+CHR(13)+ ;
		"Method:       "+LOWER(ALLTRIM(cMethod))
lcCodeLineMsg=MESSAGE(1)
IF BETWEEN(nLine,1,100000) AND NOT lcCodeLineMsg="..."
	lcErrorMsg=lcErrorMsg+CHR(13)+"Line:            "+ALLTRIM(STR(nLine))
	IF NOT EMPTY(lcCodeLineMsg)
		lcErrorMsg=lcErrorMsg+CHR(13)+CHR(13)+lcCodeLineMsg
	ENDIF
ENDIF
WAIT CLEAR
MESSAGEBOX(lcErrorMsg,16,_screen.Caption)
ERROR nError

ENDPROC
PROCEDURE Init
IF this.lSetHost
	this.SetHost
ENDIF
IF this.lAutoSetObjectRefs AND NOT this.SetObjectRefs(this)
	RETURN .F.
ENDIF

ENDPROC
PROCEDURE Destroy
IF this.lRelease
	RETURN .F.
ENDIF
this.lRelease=.T.
this.ReleaseObjRefs
this.oHost=.NULL.

ENDPROC


************************************************************
OBJETO: _image
************************************************************
*** PROPIEDADES ***
Height = 68
Width = 68
cversion = 
builder = 
builderx = (HOME()+"Wizards\BuilderD,BuilderDForm")
nobjectrefcount = 0
ninstances = 0
ohost = .NULL.
vresult = .T.
csetobjrefprogram = (IIF(VERSION(2)=0,"",HOME()+"FFC\")+"SetObjRf.prg")
Name = "_image"

*** METODOS ***
PROCEDURE release
LOCAL lcBaseClass

IF this.lRelease
	NODEFAULT
	RETURN .F.
ENDIF
this.lRelease=.T.
lcBaseClass=LOWER(this.BaseClass)
this.oHost=.NULL.
this.ReleaseObjRefs
IF NOT INLIST(lcBaseClass+" ","form ","formset ","toolbar ")
	RELEASE this
ENDIF

ENDPROC
PROCEDURE setobjectref
LPARAMETERS tcName,tvClass,tvClassLibrary
LOCAL lvResult

this.vResult=.T.
DO (this.cSetObjRefProgram) WITH (this),(tcName),(tvClass),(tvClassLibrary)
lvResult=this.vResult
this.vResult=.T.
RETURN lvResult

ENDPROC
PROCEDURE setobjectrefs
LPARAMETERS toObject

RETURN

ENDPROC
PROCEDURE releaseobjrefs
LOCAL lcName,oObject,lnCount

IF this.nObjectRefCount=0
	RETURN
ENDIF
FOR lnCount = this.nObjectRefCount TO 1 STEP -1
	lcName=this.aObjectRefs[lnCount,1]
	IF EMPTY(lcName) OR NOT PEMSTATUS(this,lcName,5) OR TYPE("this."+lcName)#"O"
		LOOP
	ENDIF
	oObject=this.&lcName
	IF ISNULL(oObject)
		LOOP
	ENDIF
	IF TYPE("oObject")=="O" AND NOT ISNULL(oObject) AND PEMSTATUS(oObject,"Release",5)
		oObject.Release
	ENDIF
	IF NOT ISNULL(oObject) AND PEMSTATUS(oObject,"oHost",5)
		oObject.oHost=.NULL.
	ENDIF
	this.&lcName=.NULL.
	oObject=.NULL.
ENDFOR
DIMENSION this.aObjectRefs[1,3]
this.aObjectRefs=""

ENDPROC
PROCEDURE nobjectrefcount_access
LOCAL lnObjectRefCount

lnObjectRefCount=ALEN(this.aObjectRefs,1)
IF lnObjectRefCount=1 AND EMPTY(this.aObjectRefs[1])
	lnObjectRefCount=0
ENDIF
RETURN lnObjectRefCount

ENDPROC
PROCEDURE nobjectrefcount_assign
LPARAMETERS m.vNewVal

ERROR 1743

ENDPROC
PROCEDURE sethost
this.oHost=IIF(TYPE("thisform")=="O",thisform,.NULL.)

ENDPROC
PROCEDURE newinstance
LPARAMETERS tnDataSessionID
LOCAL oNewObject,lnLastDataSessionID

lnLastDataSessionID=SET("DATASESSION")
IF TYPE("tnDataSessionID")=="N" AND tnDataSessionID>=1
	SET DATASESSION TO tnDataSessionID
ENDIF
oNewObject=NEWOBJECT(this.Class,this.ClassLibrary)
SET DATASESSION TO (lnLastDataSessionID)
RETURN oNewObject

ENDPROC
PROCEDURE addtoproject
*-- Dummy code for adding files to project.
RETURN

DO SetObjRf.prg

ENDPROC
PROCEDURE ninstances_access
LOCAL laInstances[1]
	
RETURN AINSTANCE(laInstances,this.Class)

ENDPROC
PROCEDURE ninstances_assign
LPARAMETERS vNewVal

ERROR 1743

ENDPROC
PROCEDURE Error
LPARAMETERS nError, cMethod, nLine
LOCAL lcOnError,lcErrorMsg,lcCodeLineMsg

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
lcErrorMsg=MESSAGE()+CHR(13)+CHR(13)+this.Name+CHR(13)+ ;
		"Error:           "+ALLTRIM(STR(nError))+CHR(13)+ ;
		"Method:       "+LOWER(ALLTRIM(cMethod))
lcCodeLineMsg=MESSAGE(1)
IF BETWEEN(nLine,1,100000) AND NOT lcCodeLineMsg="..."
	lcErrorMsg=lcErrorMsg+CHR(13)+"Line:            "+ALLTRIM(STR(nLine))
	IF NOT EMPTY(lcCodeLineMsg)
		lcErrorMsg=lcErrorMsg+CHR(13)+CHR(13)+lcCodeLineMsg
	ENDIF
ENDIF
WAIT CLEAR
MESSAGEBOX(lcErrorMsg,16,_screen.Caption)
ERROR nError

ENDPROC
PROCEDURE Init
IF this.lSetHost
	this.SetHost
ENDIF
IF this.lAutoSetObjectRefs AND NOT this.SetObjectRefs(this)
	RETURN .F.
ENDIF

ENDPROC
PROCEDURE Destroy
IF this.lRelease
	RETURN .F.
ENDIF
this.lRelease=.T.
this.ReleaseObjRefs
this.oHost=.NULL.

ENDPROC


************************************************************
OBJETO: _control
************************************************************
*** PROPIEDADES ***
Height = 22
Width = 24
cversion = 
builder = 
builderx = (HOME()+"Wizards\BuilderD,BuilderDForm")
nobjectrefcount = 0
ninstances = 0
ohost = .NULL.
vresult = .T.
csetobjrefprogram = (IIF(VERSION(2)=0,"",HOME()+"FFC\")+"SetObjRf.prg")
Name = "_control"

*** METODOS ***
PROCEDURE release
LOCAL lcBaseClass

IF this.lRelease
	NODEFAULT
	RETURN .F.
ENDIF
this.lRelease=.T.
lcBaseClass=LOWER(this.BaseClass)
this.oHost=.NULL.
this.ReleaseObjRefs
IF NOT INLIST(lcBaseClass+" ","form ","formset ","toolbar ")
	RELEASE this
ENDIF

ENDPROC
PROCEDURE setobjectref
LPARAMETERS tcName,tvClass,tvClassLibrary
LOCAL lvResult

this.vResult=.T.
DO (this.cSetObjRefProgram) WITH (this),(tcName),(tvClass),(tvClassLibrary)
lvResult=this.vResult
this.vResult=.T.
RETURN lvResult

ENDPROC
PROCEDURE setobjectrefs
LPARAMETERS toObject

RETURN

ENDPROC
PROCEDURE releaseobjrefs
LOCAL lcName,oObject,lnCount

IF this.nObjectRefCount=0
	RETURN
ENDIF
FOR lnCount = this.nObjectRefCount TO 1 STEP -1
	lcName=this.aObjectRefs[lnCount,1]
	IF EMPTY(lcName) OR NOT PEMSTATUS(this,lcName,5) OR TYPE("this."+lcName)#"O"
		LOOP
	ENDIF
	oObject=this.&lcName
	IF ISNULL(oObject)
		LOOP
	ENDIF
	IF TYPE("oObject")=="O" AND NOT ISNULL(oObject) AND PEMSTATUS(oObject,"Release",5)
		oObject.Release
	ENDIF
	IF NOT ISNULL(oObject) AND PEMSTATUS(oObject,"oHost",5)
		oObject.oHost=.NULL.
	ENDIF
	this.&lcName=.NULL.
	oObject=.NULL.
ENDFOR
DIMENSION this.aObjectRefs[1,3]
this.aObjectRefs=""

ENDPROC
PROCEDURE nobjectrefcount_access
LOCAL lnObjectRefCount

lnObjectRefCount=ALEN(this.aObjectRefs,1)
IF lnObjectRefCount=1 AND EMPTY(this.aObjectRefs[1])
	lnObjectRefCount=0
ENDIF
RETURN lnObjectRefCount

ENDPROC
PROCEDURE nobjectrefcount_assign
LPARAMETERS m.vNewVal

ERROR 1743

ENDPROC
PROCEDURE sethost
this.oHost=IIF(TYPE("thisform")=="O",thisform,.NULL.)

ENDPROC
PROCEDURE newinstance
LPARAMETERS tnDataSessionID
LOCAL oNewObject,lnLastDataSessionID

lnLastDataSessionID=SET("DATASESSION")
IF TYPE("tnDataSessionID")=="N" AND tnDataSessionID>=1
	SET DATASESSION TO tnDataSessionID
ENDIF
oNewObject=NEWOBJECT(this.Class,this.ClassLibrary)
SET DATASESSION TO (lnLastDataSessionID)
RETURN oNewObject

ENDPROC
PROCEDURE addtoproject
*-- Dummy code for adding files to project.
RETURN

DO SetObjRf.prg

ENDPROC
PROCEDURE ninstances_access
LOCAL laInstances[1]
	
RETURN AINSTANCE(laInstances,this.Class)

ENDPROC
PROCEDURE ninstances_assign
LPARAMETERS vNewVal

ERROR 1743

ENDPROC
PROCEDURE Error
LPARAMETERS nError, cMethod, nLine
LOCAL lcOnError,lcErrorMsg,lcCodeLineMsg

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
lcErrorMsg=MESSAGE()+CHR(13)+CHR(13)+this.Name+CHR(13)+ ;
		"Error:           "+ALLTRIM(STR(nError))+CHR(13)+ ;
		"Method:       "+LOWER(ALLTRIM(cMethod))
lcCodeLineMsg=MESSAGE(1)
IF BETWEEN(nLine,1,100000) AND NOT lcCodeLineMsg="..."
	lcErrorMsg=lcErrorMsg+CHR(13)+"Line:            "+ALLTRIM(STR(nLine))
	IF NOT EMPTY(lcCodeLineMsg)
		lcErrorMsg=lcErrorMsg+CHR(13)+CHR(13)+lcCodeLineMsg
	ENDIF
ENDIF
WAIT CLEAR
MESSAGEBOX(lcErrorMsg,16,_screen.Caption)
ERROR nError

ENDPROC
PROCEDURE Init
IF this.lSetHost
	this.SetHost
ENDIF
IF this.lAutoSetObjectRefs AND NOT this.SetObjectRefs(this)
	RETURN .F.
ENDIF

ENDPROC
PROCEDURE Destroy
IF this.lRelease
	RETURN .F.
ENDIF
this.lRelease=.T.
this.ReleaseObjRefs
this.oHost=.NULL.

ENDPROC


************************************************************
OBJETO: _form
************************************************************
*** PROPIEDADES ***
ShowWindow = 1
DoCreate = .T.
Caption = "Form1"
cversion = 
builder = 
builderx = (HOME()+"Wizards\BuilderD,BuilderDForm")
nobjectrefcount = 0
ninstances = 0
ohost = .NULL.
vresult = .T.
csetobjrefprogram = (IIF(VERSION(2)=0,"",HOME()+"FFC\")+"SetObjRf.prg")
Name = "_form"

*** METODOS ***
PROCEDURE release
LOCAL lcBaseClass

IF this.lRelease
	NODEFAULT
	RETURN .F.
ENDIF
this.lRelease=.T.
lcBaseClass=LOWER(this.BaseClass)
this.oHost=.NULL.
this.ReleaseObjRefs
IF NOT INLIST(lcBaseClass+" ","form ","formset ","toolbar ")
	RELEASE this
ENDIF

ENDPROC
PROCEDURE setobjectref
LPARAMETERS tcName,tvClass,tvClassLibrary
LOCAL lvResult

this.vResult=.T.
DO (this.cSetObjRefProgram) WITH (this),(tcName),(tvClass),(tvClassLibrary)
lvResult=this.vResult
this.vResult=.T.
RETURN lvResult

ENDPROC
PROCEDURE setobjectrefs
LPARAMETERS toObject

RETURN

ENDPROC
PROCEDURE releaseobjrefs
LOCAL lcName,oObject,lnCount

IF this.nObjectRefCount=0
	RETURN
ENDIF
FOR lnCount = this.nObjectRefCount TO 1 STEP -1
	lcName=this.aObjectRefs[lnCount,1]
	IF EMPTY(lcName) OR NOT PEMSTATUS(this,lcName,5) OR TYPE("this."+lcName)#"O"
		LOOP
	ENDIF
	oObject=this.&lcName
	IF ISNULL(oObject)
		LOOP
	ENDIF
	IF TYPE("oObject")=="O" AND NOT ISNULL(oObject) AND PEMSTATUS(oObject,"Release",5)
		oObject.Release
	ENDIF
	IF NOT ISNULL(oObject) AND PEMSTATUS(oObject,"oHost",5)
		oObject.oHost=.NULL.
	ENDIF
	this.&lcName=.NULL.
	oObject=.NULL.
ENDFOR
DIMENSION this.aObjectRefs[1,3]
this.aObjectRefs=""

ENDPROC
PROCEDURE nobjectrefcount_access
LOCAL lnObjectRefCount

lnObjectRefCount=ALEN(this.aObjectRefs,1)
IF lnObjectRefCount=1 AND EMPTY(this.aObjectRefs[1])
	lnObjectRefCount=0
ENDIF
RETURN lnObjectRefCount

ENDPROC
PROCEDURE nobjectrefcount_assign
LPARAMETERS m.vNewVal

ERROR 1743

ENDPROC
PROCEDURE sethost
this.oHost=IIF(TYPE("thisform")=="O",thisform,.NULL.)

ENDPROC
PROCEDURE newinstance
LPARAMETERS tnDataSessionID
LOCAL oNewObject,lnLastDataSessionID

lnLastDataSessionID=SET("DATASESSION")
IF TYPE("tnDataSessionID")=="N" AND tnDataSessionID>=1
	SET DATASESSION TO tnDataSessionID
ENDIF
oNewObject=NEWOBJECT(this.Class,this.ClassLibrary)
SET DATASESSION TO (lnLastDataSessionID)
RETURN oNewObject

ENDPROC
PROCEDURE addtoproject
*-- Dummy code for adding files to project.
RETURN

DO SetObjRf.prg

ENDPROC
PROCEDURE ninstances_access
LOCAL laInstances[1]
	
RETURN AINSTANCE(laInstances,this.Class)

ENDPROC
PROCEDURE ninstances_assign
LPARAMETERS vNewVal

ERROR 1743

ENDPROC
PROCEDURE Error
LPARAMETERS nError, cMethod, nLine
LOCAL lcOnError,lcErrorMsg,lcCodeLineMsg

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
lcErrorMsg=MESSAGE()+CHR(13)+CHR(13)+this.Name+CHR(13)+ ;
		"Error:           "+ALLTRIM(STR(nError))+CHR(13)+ ;
		"Method:       "+LOWER(ALLTRIM(cMethod))
lcCodeLineMsg=MESSAGE(1)
IF BETWEEN(nLine,1,100000) AND NOT lcCodeLineMsg="..."
	lcErrorMsg=lcErrorMsg+CHR(13)+"Line:            "+ALLTRIM(STR(nLine))
	IF NOT EMPTY(lcCodeLineMsg)
		lcErrorMsg=lcErrorMsg+CHR(13)+CHR(13)+lcCodeLineMsg
	ENDIF
ENDIF
WAIT CLEAR
MESSAGEBOX(lcErrorMsg,16,_screen.Caption)
ERROR nError

ENDPROC
PROCEDURE Init
IF this.lSetHost
	this.SetHost
ENDIF
IF this.lAutoSetObjectRefs AND NOT this.SetObjectRefs(this)
	RETURN .F.
ENDIF

ENDPROC
PROCEDURE Destroy
IF this.lRelease
	RETURN .F.
ENDIF
this.lRelease=.T.
this.ReleaseObjRefs
this.oHost=.NULL.

ENDPROC


************************************************************
OBJETO: _form
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 13, 3, 0

*** METODOS ***


************************************************************
OBJETO: _toolbar
************************************************************
*** PROPIEDADES ***
Caption = "Toolbar1"
ShowWindow = 1
cversion = 
builder = 
builderx = (HOME()+"Wizards\BuilderD,BuilderDForm")
nobjectrefcount = 0
ninstances = 0
ohost = .NULL.
vresult = .T.
csetobjrefprogram = (IIF(VERSION(2)=0,"",HOME()+"FFC\")+"SetObjRf.prg")
Name = "_toolbar"

*** METODOS ***
PROCEDURE release
LOCAL lcBaseClass

IF this.lRelease
	NODEFAULT
	RETURN .F.
ENDIF
this.lRelease=.T.
lcBaseClass=LOWER(this.BaseClass)
this.oHost=.NULL.
this.ReleaseObjRefs
IF NOT INLIST(lcBaseClass+" ","form ","formset ","toolbar ")
	RELEASE this
ENDIF

ENDPROC
PROCEDURE setobjectref
LPARAMETERS tcName,tvClass,tvClassLibrary
LOCAL lvResult

this.vResult=.T.
DO (this.cSetObjRefProgram) WITH (this),(tcName),(tvClass),(tvClassLibrary)
lvResult=this.vResult
this.vResult=.T.
RETURN lvResult

ENDPROC
PROCEDURE setobjectrefs
LPARAMETERS toObject

RETURN

ENDPROC
PROCEDURE releaseobjrefs
LOCAL lcName,oObject,lnCount

IF this.nObjectRefCount=0
	RETURN
ENDIF
FOR lnCount = this.nObjectRefCount TO 1 STEP -1
	lcName=this.aObjectRefs[lnCount,1]
	IF EMPTY(lcName) OR NOT PEMSTATUS(this,lcName,5) OR TYPE("this."+lcName)#"O"
		LOOP
	ENDIF
	oObject=this.&lcName
	IF ISNULL(oObject)
		LOOP
	ENDIF
	IF TYPE("oObject")=="O" AND NOT ISNULL(oObject) AND PEMSTATUS(oObject,"Release",5)
		oObject.Release
	ENDIF
	IF NOT ISNULL(oObject) AND PEMSTATUS(oObject,"oHost",5)
		oObject.oHost=.NULL.
	ENDIF
	this.&lcName=.NULL.
	oObject=.NULL.
ENDFOR
DIMENSION this.aObjectRefs[1,3]
this.aObjectRefs=""

ENDPROC
PROCEDURE nobjectrefcount_access
LOCAL lnObjectRefCount

lnObjectRefCount=ALEN(this.aObjectRefs,1)
IF lnObjectRefCount=1 AND EMPTY(this.aObjectRefs[1])
	lnObjectRefCount=0
ENDIF
RETURN lnObjectRefCount

ENDPROC
PROCEDURE nobjectrefcount_assign
LPARAMETERS m.vNewVal

ERROR 1743

ENDPROC
PROCEDURE sethost
this.oHost=IIF(TYPE("thisform")=="O",thisform,.NULL.)

ENDPROC
PROCEDURE newinstance
LPARAMETERS tnDataSessionID
LOCAL oNewObject,lnLastDataSessionID

lnLastDataSessionID=SET("DATASESSION")
IF TYPE("tnDataSessionID")=="N" AND tnDataSessionID>=1
	SET DATASESSION TO tnDataSessionID
ENDIF
oNewObject=NEWOBJECT(this.Class,this.ClassLibrary)
SET DATASESSION TO (lnLastDataSessionID)
RETURN oNewObject

ENDPROC
PROCEDURE addtoproject
*-- Dummy code for adding files to project.
RETURN

DO SetObjRf.prg

ENDPROC
PROCEDURE ninstances_access
LOCAL laInstances[1]
	
RETURN AINSTANCE(laInstances,this.Class)

ENDPROC
PROCEDURE ninstances_assign
LPARAMETERS vNewVal

ERROR 1743

ENDPROC
PROCEDURE Error
LPARAMETERS nError, cMethod, nLine
LOCAL lcOnError,lcErrorMsg,lcCodeLineMsg

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
lcErrorMsg=MESSAGE()+CHR(13)+CHR(13)+this.Name+CHR(13)+ ;
		"Error:           "+ALLTRIM(STR(nError))+CHR(13)+ ;
		"Method:       "+LOWER(ALLTRIM(cMethod))
lcCodeLineMsg=MESSAGE(1)
IF BETWEEN(nLine,1,100000) AND NOT lcCodeLineMsg="..."
	lcErrorMsg=lcErrorMsg+CHR(13)+"Line:            "+ALLTRIM(STR(nLine))
	IF NOT EMPTY(lcCodeLineMsg)
		lcErrorMsg=lcErrorMsg+CHR(13)+CHR(13)+lcCodeLineMsg
	ENDIF
ENDIF
WAIT CLEAR
MESSAGEBOX(lcErrorMsg,16,_screen.Caption)
ERROR nError

ENDPROC
PROCEDURE Init
IF this.lSetHost
	this.SetHost
ENDIF
IF this.lAutoSetObjectRefs AND NOT this.SetObjectRefs(this)
	RETURN .F.
ENDIF

ENDPROC
PROCEDURE Destroy
IF this.lRelease
	RETURN .F.
ENDIF
this.lRelease=.T.
this.ReleaseObjRefs
this.oHost=.NULL.

ENDPROC


************************************************************
OBJETO: _custom
************************************************************
*** PROPIEDADES ***
Height = 22
Width = 24
cversion = 
builder = 
builderx = (HOME()+"Wizards\BuilderD,BuilderDForm")
nobjectrefcount = 0
ohost = .NULL.
vresult = .T.
csetobjrefprogram = (IIF(VERSION(2)=0,"",HOME()+"FFC\")+"SetObjRf.prg")
ninstances = 0
Name = "_custom"

*** METODOS ***
PROCEDURE release
LOCAL lcBaseClass

IF this.lRelease
	NODEFAULT
	RETURN .F.
ENDIF
this.lRelease=.T.
lcBaseClass=LOWER(this.BaseClass)
this.oHost=.NULL.
this.ReleaseObjRefs
IF NOT INLIST(lcBaseClass+" ","form ","formset ","toolbar ")
	RELEASE this
ENDIF

ENDPROC
PROCEDURE setobjectref
LPARAMETERS tcName,tvClass,tvClassLibrary
LOCAL lvResult

this.vResult=.T.
DO (this.cSetObjRefProgram) WITH (this),(tcName),(tvClass),(tvClassLibrary)
lvResult=this.vResult
this.vResult=.T.
RETURN lvResult

ENDPROC
PROCEDURE setobjectrefs
LPARAMETERS toObject

RETURN

ENDPROC
PROCEDURE releaseobjrefs
LOCAL lcName,oObject,lnCount

IF this.nObjectRefCount=0
	RETURN
ENDIF
FOR lnCount = this.nObjectRefCount TO 1 STEP -1
	lcName=this.aObjectRefs[lnCount,1]
	IF EMPTY(lcName) OR NOT PEMSTATUS(this,lcName,5) OR TYPE("this."+lcName)#"O"
		LOOP
	ENDIF
	oObject=this.&lcName
	IF ISNULL(oObject)
		LOOP
	ENDIF
	IF TYPE("oObject")=="O" AND NOT ISNULL(oObject) AND PEMSTATUS(oObject,"Release",5)
		oObject.Release
	ENDIF
	IF NOT ISNULL(oObject) AND PEMSTATUS(oObject,"oHost",5)
		oObject.oHost=.NULL.
	ENDIF
	this.&lcName=.NULL.
	oObject=.NULL.
ENDFOR
DIMENSION this.aObjectRefs[1,3]
this.aObjectRefs=""

ENDPROC
PROCEDURE nobjectrefcount_access
LOCAL lnObjectRefCount

lnObjectRefCount=ALEN(this.aObjectRefs,1)
IF lnObjectRefCount=1 AND EMPTY(this.aObjectRefs[1])
	lnObjectRefCount=0
ENDIF
RETURN lnObjectRefCount

ENDPROC
PROCEDURE nobjectrefcount_assign
LPARAMETERS m.vNewVal

ERROR 1743

ENDPROC
PROCEDURE sethost
this.oHost=IIF(TYPE("thisform")=="O",thisform,.NULL.)

ENDPROC
PROCEDURE newinstance
LPARAMETERS tnDataSessionID
LOCAL oNewObject,lnLastDataSessionID

lnLastDataSessionID=SET("DATASESSION")
IF TYPE("tnDataSessionID")=="N" AND tnDataSessionID>=1
	SET DATASESSION TO tnDataSessionID
ENDIF
oNewObject=NEWOBJECT(this.Class,this.ClassLibrary)
SET DATASESSION TO (lnLastDataSessionID)
RETURN oNewObject

ENDPROC
PROCEDURE addtoproject
*-- Dummy code for adding files to project.
RETURN

DO SetObjRf.prg

ENDPROC
PROCEDURE ninstances_access
LOCAL laInstances[1]
	
RETURN AINSTANCE(laInstances,this.Class)

ENDPROC
PROCEDURE ninstances_assign
LPARAMETERS vNewVal

ERROR 1743

ENDPROC
PROCEDURE Error
LPARAMETERS nError, cMethod, nLine
LOCAL lcOnError,lcErrorMsg,lcCodeLineMsg

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
lcErrorMsg=MESSAGE()+CHR(13)+CHR(13)+this.Name+CHR(13)+ ;
		"Error:           "+ALLTRIM(STR(nError))+CHR(13)+ ;
		"Method:       "+LOWER(ALLTRIM(cMethod))
lcCodeLineMsg=MESSAGE(1)
IF BETWEEN(nLine,1,100000) AND NOT lcCodeLineMsg="..."
	lcErrorMsg=lcErrorMsg+CHR(13)+"Line:            "+ALLTRIM(STR(nLine))
	IF NOT EMPTY(lcCodeLineMsg)
		lcErrorMsg=lcErrorMsg+CHR(13)+CHR(13)+lcCodeLineMsg
	ENDIF
ENDIF
WAIT CLEAR
MESSAGEBOX(lcErrorMsg,16,_screen.Caption)
ERROR nError

ENDPROC
PROCEDURE Init
IF this.lSetHost
	this.SetHost
ENDIF
IF this.lAutoSetObjectRefs AND NOT this.SetObjectRefs(this)
	RETURN .F.
ENDIF

ENDPROC
PROCEDURE Destroy
IF this.lRelease
	RETURN .F.
ENDIF
this.lRelease=.T.
this.ReleaseObjRefs
this.oHost=.NULL.

ENDPROC


************************************************************
OBJETO: _collection
************************************************************
*** PROPIEDADES ***
Height = 23
Width = 23
cversion = 
builder = 
builderx = (HOME()+"Wizards\BuilderD,BuilderDForm")
nobjectrefcount = 0
ohost = .NULL.
vresult = .T.
csetobjrefprogram = (IIF(VERSION(2)=0,"",HOME()+"FFC\")+"SetObjRf.prg")
ninstances = 0
Name = "_collection"

*** METODOS ***
PROCEDURE release
LOCAL lcBaseClass

IF this.lRelease
	NODEFAULT
	RETURN .F.
ENDIF
this.lRelease=.T.
lcBaseClass=LOWER(this.BaseClass)
this.oHost=.NULL.
this.ReleaseObjRefs
IF NOT INLIST(lcBaseClass+" ","form ","formset ","toolbar ")
	RELEASE this
ENDIF

ENDPROC
PROCEDURE setobjectref
LPARAMETERS tcName,tvClass,tvClassLibrary
LOCAL lvResult

this.vResult=.T.
DO (this.cSetObjRefProgram) WITH (this),(tcName),(tvClass),(tvClassLibrary)
lvResult=this.vResult
this.vResult=.T.
RETURN lvResult

ENDPROC
PROCEDURE setobjectrefs
LPARAMETERS toObject

RETURN

ENDPROC
PROCEDURE releaseobjrefs
LOCAL lcName,oObject,lnCount

IF this.nObjectRefCount=0
	RETURN
ENDIF
FOR lnCount = this.nObjectRefCount TO 1 STEP -1
	lcName=this.aObjectRefs[lnCount,1]
	IF EMPTY(lcName) OR NOT PEMSTATUS(this,lcName,5) OR TYPE("this."+lcName)#"O"
		LOOP
	ENDIF
	oObject=this.&lcName
	IF ISNULL(oObject)
		LOOP
	ENDIF
	IF TYPE("oObject")=="O" AND NOT ISNULL(oObject) AND PEMSTATUS(oObject,"Release",5)
		oObject.Release
	ENDIF
	IF NOT ISNULL(oObject) AND PEMSTATUS(oObject,"oHost",5)
		oObject.oHost=.NULL.
	ENDIF
	this.&lcName=.NULL.
	oObject=.NULL.
ENDFOR
DIMENSION this.aObjectRefs[1,3]
this.aObjectRefs=""

ENDPROC
PROCEDURE nobjectrefcount_access
LOCAL lnObjectRefCount

lnObjectRefCount=ALEN(this.aObjectRefs,1)
IF lnObjectRefCount=1 AND EMPTY(this.aObjectRefs[1])
	lnObjectRefCount=0
ENDIF
RETURN lnObjectRefCount

ENDPROC
PROCEDURE nobjectrefcount_assign
LPARAMETERS m.vNewVal

ERROR 1743

ENDPROC
PROCEDURE sethost
this.oHost=IIF(TYPE("thisform")=="O",thisform,.NULL.)

ENDPROC
PROCEDURE newinstance
LPARAMETERS tnDataSessionID
LOCAL oNewObject,lnLastDataSessionID

lnLastDataSessionID=SET("DATASESSION")
IF TYPE("tnDataSessionID")=="N" AND tnDataSessionID>=1
	SET DATASESSION TO tnDataSessionID
ENDIF
oNewObject=NEWOBJECT(this.Class,this.ClassLibrary)
SET DATASESSION TO (lnLastDataSessionID)
RETURN oNewObject

ENDPROC
PROCEDURE addtoproject
*-- Dummy code for adding files to project.
RETURN

DO SetObjRf.prg

ENDPROC
PROCEDURE ninstances_access
LOCAL laInstances[1]
	
RETURN AINSTANCE(laInstances,this.Class)

ENDPROC
PROCEDURE ninstances_assign
LPARAMETERS vNewVal

ERROR 1743

ENDPROC
PROCEDURE Error
LPARAMETERS nError, cMethod, nLine
LOCAL lcOnError,lcErrorMsg,lcCodeLineMsg

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
lcErrorMsg=MESSAGE()+CHR(13)+CHR(13)+this.Name+CHR(13)+ ;
		"Error:           "+ALLTRIM(STR(nError))+CHR(13)+ ;
		"Method:       "+LOWER(ALLTRIM(cMethod))
lcCodeLineMsg=MESSAGE(1)
IF BETWEEN(nLine,1,100000) AND NOT lcCodeLineMsg="..."
	lcErrorMsg=lcErrorMsg+CHR(13)+"Line:            "+ALLTRIM(STR(nLine))
	IF NOT EMPTY(lcCodeLineMsg)
		lcErrorMsg=lcErrorMsg+CHR(13)+CHR(13)+lcCodeLineMsg
	ENDIF
ENDIF
WAIT CLEAR
MESSAGEBOX(lcErrorMsg,16,_screen.Caption)
ERROR nError

ENDPROC
PROCEDURE Init
IF this.lSetHost
	this.SetHost
ENDIF
IF this.lAutoSetObjectRefs AND NOT this.SetObjectRefs(this)
	RETURN .F.
ENDIF

ENDPROC
PROCEDURE Destroy
IF this.lRelease
	RETURN .F.
ENDIF
this.lRelease=.T.
this.ReleaseObjRefs
this.oHost=.NULL.

ENDPROC


************************************************************
OBJETO: _cursor2
************************************************************
*** PROPIEDADES ***
Height = 23
Width = 23
cversion = 
builder = 
builderx = (HOME()+"Wizards\BuilderD,BuilderDForm")
nobjectrefcount = 0
ohost = .NULL.
vresult = .T.
csetobjrefprogram = (IIF(VERSION(2)=0,"",HOME()+"FFC\")+"SetObjRf.prg")
ninstances = 0
Name = "_cursor2"

*** METODOS ***
PROCEDURE release
LOCAL lcBaseClass

IF this.lRelease
	NODEFAULT
	RETURN .F.
ENDIF
this.lRelease=.T.
lcBaseClass=LOWER(this.BaseClass)
this.oHost=.NULL.
this.ReleaseObjRefs
IF NOT INLIST(lcBaseClass+" ","form ","formset ","toolbar ")
	RELEASE this
ENDIF

ENDPROC
PROCEDURE setobjectref
LPARAMETERS tcName,tvClass,tvClassLibrary
LOCAL lvResult

this.vResult=.T.
DO (this.cSetObjRefProgram) WITH (this),(tcName),(tvClass),(tvClassLibrary)
lvResult=this.vResult
this.vResult=.T.
RETURN lvResult

ENDPROC
PROCEDURE setobjectrefs
LPARAMETERS toObject

RETURN

ENDPROC
PROCEDURE releaseobjrefs
LOCAL lcName,oObject,lnCount

IF this.nObjectRefCount=0
	RETURN
ENDIF
FOR lnCount = this.nObjectRefCount TO 1 STEP -1
	lcName=this.aObjectRefs[lnCount,1]
	IF EMPTY(lcName) OR NOT PEMSTATUS(this,lcName,5) OR TYPE("this."+lcName)#"O"
		LOOP
	ENDIF
	oObject=this.&lcName
	IF ISNULL(oObject)
		LOOP
	ENDIF
	IF TYPE("oObject")=="O" AND NOT ISNULL(oObject) AND PEMSTATUS(oObject,"Release",5)
		oObject.Release
	ENDIF
	IF NOT ISNULL(oObject) AND PEMSTATUS(oObject,"oHost",5)
		oObject.oHost=.NULL.
	ENDIF
	this.&lcName=.NULL.
	oObject=.NULL.
ENDFOR
DIMENSION this.aObjectRefs[1,3]
this.aObjectRefs=""

ENDPROC
PROCEDURE nobjectrefcount_access
LOCAL lnObjectRefCount

lnObjectRefCount=ALEN(this.aObjectRefs,1)
IF lnObjectRefCount=1 AND EMPTY(this.aObjectRefs[1])
	lnObjectRefCount=0
ENDIF
RETURN lnObjectRefCount

ENDPROC
PROCEDURE nobjectrefcount_assign
LPARAMETERS m.vNewVal

ERROR 1743

ENDPROC
PROCEDURE sethost
this.oHost=IIF(TYPE("thisform")=="O",thisform,.NULL.)

ENDPROC
PROCEDURE newinstance
LPARAMETERS tnDataSessionID
LOCAL oNewObject,lnLastDataSessionID

lnLastDataSessionID=SET("DATASESSION")
IF TYPE("tnDataSessionID")=="N" AND tnDataSessionID>=1
	SET DATASESSION TO tnDataSessionID
ENDIF
oNewObject=NEWOBJECT(this.Class,this.ClassLibrary)
SET DATASESSION TO (lnLastDataSessionID)
RETURN oNewObject

ENDPROC
PROCEDURE addtoproject
*-- Dummy code for adding files to project.
RETURN

DO SetObjRf.prg

ENDPROC
PROCEDURE ninstances_access
LOCAL laInstances[1]
	
RETURN AINSTANCE(laInstances,this.Class)

ENDPROC
PROCEDURE ninstances_assign
LPARAMETERS vNewVal

ERROR 1743

ENDPROC
PROCEDURE Error
LPARAMETERS nError, cMethod, nLine
LOCAL lcOnError,lcErrorMsg,lcCodeLineMsg

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
lcErrorMsg=MESSAGE()+CHR(13)+CHR(13)+this.Name+CHR(13)+ ;
		"Error:           "+ALLTRIM(STR(nError))+CHR(13)+ ;
		"Method:       "+LOWER(ALLTRIM(cMethod))
lcCodeLineMsg=MESSAGE(1)
IF BETWEEN(nLine,1,100000) AND NOT lcCodeLineMsg="..."
	lcErrorMsg=lcErrorMsg+CHR(13)+"Line:            "+ALLTRIM(STR(nLine))
	IF NOT EMPTY(lcCodeLineMsg)
		lcErrorMsg=lcErrorMsg+CHR(13)+CHR(13)+lcCodeLineMsg
	ENDIF
ENDIF
WAIT CLEAR
MESSAGEBOX(lcErrorMsg,16,_screen.Caption)
ERROR nError

ENDPROC
PROCEDURE Init
IF this.lSetHost
	this.SetHost
ENDIF
IF this.lAutoSetObjectRefs AND NOT this.SetObjectRefs(this)
	RETURN .F.
ENDIF

ENDPROC
PROCEDURE Destroy
IF this.lRelease
	RETURN .F.
ENDIF
this.lRelease=.T.
this.ReleaseObjRefs
this.oHost=.NULL.

ENDPROC


************************************************************
OBJETO: _cursoradapter
************************************************************
*** PROPIEDADES ***
Height = 22
Width = 23
cversion = 
builder = 
builderx = (HOME()+"Wizards\BuilderD,BuilderDForm")
nobjectrefcount = 0
ohost = .NULL.
vresult = .T.
csetobjrefprogram = (IIF(VERSION(2)=0,"",HOME()+"FFC\")+"SetObjRf.prg")
ninstances = 0
Name = "_cursoradapter"

*** METODOS ***
PROCEDURE release
LOCAL lcBaseClass

IF this.lRelease
	NODEFAULT
	RETURN .F.
ENDIF
this.lRelease=.T.
lcBaseClass=LOWER(this.BaseClass)
this.oHost=.NULL.
this.ReleaseObjRefs
IF NOT INLIST(lcBaseClass+" ","form ","formset ","toolbar ")
	RELEASE this
ENDIF

ENDPROC
PROCEDURE setobjectref
LPARAMETERS tcName,tvClass,tvClassLibrary
LOCAL lvResult

this.vResult=.T.
DO (this.cSetObjRefProgram) WITH (this),(tcName),(tvClass),(tvClassLibrary)
lvResult=this.vResult
this.vResult=.T.
RETURN lvResult

ENDPROC
PROCEDURE setobjectrefs
LPARAMETERS toObject

RETURN

ENDPROC
PROCEDURE releaseobjrefs
LOCAL lcName,oObject,lnCount

IF this.nObjectRefCount=0
	RETURN
ENDIF
FOR lnCount = this.nObjectRefCount TO 1 STEP -1
	lcName=this.aObjectRefs[lnCount,1]
	IF EMPTY(lcName) OR NOT PEMSTATUS(this,lcName,5) OR TYPE("this."+lcName)#"O"
		LOOP
	ENDIF
	oObject=this.&lcName
	IF ISNULL(oObject)
		LOOP
	ENDIF
	IF TYPE("oObject")=="O" AND NOT ISNULL(oObject) AND PEMSTATUS(oObject,"Release",5)
		oObject.Release
	ENDIF
	IF NOT ISNULL(oObject) AND PEMSTATUS(oObject,"oHost",5)
		oObject.oHost=.NULL.
	ENDIF
	this.&lcName=.NULL.
	oObject=.NULL.
ENDFOR
DIMENSION this.aObjectRefs[1,3]
this.aObjectRefs=""

ENDPROC
PROCEDURE nobjectrefcount_access
LOCAL lnObjectRefCount

lnObjectRefCount=ALEN(this.aObjectRefs,1)
IF lnObjectRefCount=1 AND EMPTY(this.aObjectRefs[1])
	lnObjectRefCount=0
ENDIF
RETURN lnObjectRefCount

ENDPROC
PROCEDURE nobjectrefcount_assign
LPARAMETERS m.vNewVal

ERROR 1743

ENDPROC
PROCEDURE sethost
this.oHost=IIF(TYPE("thisform")=="O",thisform,.NULL.)

ENDPROC
PROCEDURE newinstance
LPARAMETERS tnDataSessionID
LOCAL oNewObject,lnLastDataSessionID

lnLastDataSessionID=SET("DATASESSION")
IF TYPE("tnDataSessionID")=="N" AND tnDataSessionID>=1
	SET DATASESSION TO tnDataSessionID
ENDIF
oNewObject=NEWOBJECT(this.Class,this.ClassLibrary)
SET DATASESSION TO (lnLastDataSessionID)
RETURN oNewObject

ENDPROC
PROCEDURE addtoproject
*-- Dummy code for adding files to project.
RETURN

DO SetObjRf.prg

ENDPROC
PROCEDURE ninstances_access
LOCAL laInstances[1]
	
RETURN AINSTANCE(laInstances,this.Class)

ENDPROC
PROCEDURE ninstances_assign
LPARAMETERS vNewVal

ERROR 1743

ENDPROC
PROCEDURE Error
LPARAMETERS nError, cMethod, nLine
LOCAL lcOnError,lcErrorMsg,lcCodeLineMsg

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
lcErrorMsg=MESSAGE()+CHR(13)+CHR(13)+this.Name+CHR(13)+ ;
		"Error:           "+ALLTRIM(STR(nError))+CHR(13)+ ;
		"Method:       "+LOWER(ALLTRIM(cMethod))
lcCodeLineMsg=MESSAGE(1)
IF BETWEEN(nLine,1,100000) AND NOT lcCodeLineMsg="..."
	lcErrorMsg=lcErrorMsg+CHR(13)+"Line:            "+ALLTRIM(STR(nLine))
	IF NOT EMPTY(lcCodeLineMsg)
		lcErrorMsg=lcErrorMsg+CHR(13)+CHR(13)+lcCodeLineMsg
	ENDIF
ENDIF
WAIT CLEAR
MESSAGEBOX(lcErrorMsg,16,_screen.Caption)
ERROR nError

ENDPROC
PROCEDURE Init
IF this.lSetHost
	this.SetHost
ENDIF
IF this.lAutoSetObjectRefs AND NOT this.SetObjectRefs(this)
	RETURN .F.
ENDIF

ENDPROC
PROCEDURE Destroy
IF this.lRelease
	RETURN .F.
ENDIF
this.lRelease=.T.
this.ReleaseObjRefs
this.oHost=.NULL.

ENDPROC


************************************************************
OBJETO: _dataenvironment2
************************************************************
*** PROPIEDADES ***
Width = 24
Height = 22
DataSource = .NULL.
cversion = 
builder = 
builderx = (HOME()+"Wizards\BuilderD,BuilderDForm")
nobjectrefcount = 0
ohost = .NULL.
vresult = .T.
csetobjrefprogram = (IIF(VERSION(2)=0,"",HOME()+"FFC\")+"SetObjRf.prg")
ninstances = 0
Name = "_dataenvironment2"

*** METODOS ***
PROCEDURE release
LOCAL lcBaseClass

IF this.lRelease
	NODEFAULT
	RETURN .F.
ENDIF
this.lRelease=.T.
lcBaseClass=LOWER(this.BaseClass)
this.oHost=.NULL.
this.ReleaseObjRefs
IF NOT INLIST(lcBaseClass+" ","form ","formset ","toolbar ")
	RELEASE this
ENDIF

ENDPROC
PROCEDURE setobjectref
LPARAMETERS tcName,tvClass,tvClassLibrary
LOCAL lvResult

this.vResult=.T.
DO (this.cSetObjRefProgram) WITH (this),(tcName),(tvClass),(tvClassLibrary)
lvResult=this.vResult
this.vResult=.T.
RETURN lvResult

ENDPROC
PROCEDURE setobjectrefs
LPARAMETERS toObject

RETURN

ENDPROC
PROCEDURE releaseobjrefs
LOCAL lcName,oObject,lnCount

IF this.nObjectRefCount=0
	RETURN
ENDIF
FOR lnCount = this.nObjectRefCount TO 1 STEP -1
	lcName=this.aObjectRefs[lnCount,1]
	IF EMPTY(lcName) OR NOT PEMSTATUS(this,lcName,5) OR TYPE("this."+lcName)#"O"
		LOOP
	ENDIF
	oObject=this.&lcName
	IF ISNULL(oObject)
		LOOP
	ENDIF
	IF TYPE("oObject")=="O" AND NOT ISNULL(oObject) AND PEMSTATUS(oObject,"Release",5)
		oObject.Release
	ENDIF
	IF NOT ISNULL(oObject) AND PEMSTATUS(oObject,"oHost",5)
		oObject.oHost=.NULL.
	ENDIF
	this.&lcName=.NULL.
	oObject=.NULL.
ENDFOR
DIMENSION this.aObjectRefs[1,3]
this.aObjectRefs=""

ENDPROC
PROCEDURE nobjectrefcount_access
LOCAL lnObjectRefCount

lnObjectRefCount=ALEN(this.aObjectRefs,1)
IF lnObjectRefCount=1 AND EMPTY(this.aObjectRefs[1])
	lnObjectRefCount=0
ENDIF
RETURN lnObjectRefCount

ENDPROC
PROCEDURE nobjectrefcount_assign
LPARAMETERS m.vNewVal

ERROR 1743

ENDPROC
PROCEDURE sethost
this.oHost=IIF(TYPE("thisform")=="O",thisform,.NULL.)

ENDPROC
PROCEDURE newinstance
LPARAMETERS tnDataSessionID
LOCAL oNewObject,lnLastDataSessionID

lnLastDataSessionID=SET("DATASESSION")
IF TYPE("tnDataSessionID")=="N" AND tnDataSessionID>=1
	SET DATASESSION TO tnDataSessionID
ENDIF
oNewObject=NEWOBJECT(this.Class,this.ClassLibrary)
SET DATASESSION TO (lnLastDataSessionID)
RETURN oNewObject

ENDPROC
PROCEDURE addtoproject
*-- Dummy code for adding files to project.
RETURN

DO SetObjRf.prg

ENDPROC
PROCEDURE ninstances_access
LOCAL laInstances[1]
	
RETURN AINSTANCE(laInstances,this.Class)

ENDPROC
PROCEDURE ninstances_assign
LPARAMETERS vNewVal

ERROR 1743

ENDPROC
PROCEDURE Destroy
IF this.lRelease
	RETURN .F.
ENDIF
this.lRelease=.T.
this.ReleaseObjRefs
this.oHost=.NULL.

ENDPROC
PROCEDURE Init
IF this.lSetHost
	this.SetHost
ENDIF
IF this.lAutoSetObjectRefs AND NOT this.SetObjectRefs(this)
	RETURN .F.
ENDIF

ENDPROC
PROCEDURE Error
LPARAMETERS nError, cMethod, nLine
LOCAL lcOnError,lcErrorMsg,lcCodeLineMsg

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
lcErrorMsg=MESSAGE()+CHR(13)+CHR(13)+this.Name+CHR(13)+ ;
		"Error:           "+ALLTRIM(STR(nError))+CHR(13)+ ;
		"Method:       "+LOWER(ALLTRIM(cMethod))
lcCodeLineMsg=MESSAGE(1)
IF BETWEEN(nLine,1,100000) AND NOT lcCodeLineMsg="..."
	lcErrorMsg=lcErrorMsg+CHR(13)+"Line:            "+ALLTRIM(STR(nLine))
	IF NOT EMPTY(lcCodeLineMsg)
		lcErrorMsg=lcErrorMsg+CHR(13)+CHR(13)+lcCodeLineMsg
	ENDIF
ENDIF
WAIT CLEAR
MESSAGEBOX(lcErrorMsg,16,_screen.Caption)
ERROR nError

ENDPROC


************************************************************
OBJETO: _relation2
************************************************************
*** PROPIEDADES ***
Height = 23
Width = 23
cversion = 
builder = 
builderx = (HOME()+"Wizards\BuilderD,BuilderDForm")
nobjectrefcount = 0
ohost = .NULL.
vresult = .T.
csetobjrefprogram = (IIF(VERSION(2)=0,"",HOME()+"FFC\")+"SetObjRf.prg")
ninstances = 0
Name = "_relation2"

*** METODOS ***
PROCEDURE release
LOCAL lcBaseClass

IF this.lRelease
	NODEFAULT
	RETURN .F.
ENDIF
this.lRelease=.T.
lcBaseClass=LOWER(this.BaseClass)
this.oHost=.NULL.
this.ReleaseObjRefs
IF NOT INLIST(lcBaseClass+" ","form ","formset ","toolbar ")
	RELEASE this
ENDIF

ENDPROC
PROCEDURE setobjectref
LPARAMETERS tcName,tvClass,tvClassLibrary
LOCAL lvResult

this.vResult=.T.
DO (this.cSetObjRefProgram) WITH (this),(tcName),(tvClass),(tvClassLibrary)
lvResult=this.vResult
this.vResult=.T.
RETURN lvResult

ENDPROC
PROCEDURE setobjectrefs
LPARAMETERS toObject

RETURN

ENDPROC
PROCEDURE releaseobjrefs
LOCAL lcName,oObject,lnCount

IF this.nObjectRefCount=0
	RETURN
ENDIF
FOR lnCount = this.nObjectRefCount TO 1 STEP -1
	lcName=this.aObjectRefs[lnCount,1]
	IF EMPTY(lcName) OR NOT PEMSTATUS(this,lcName,5) OR TYPE("this."+lcName)#"O"
		LOOP
	ENDIF
	oObject=this.&lcName
	IF ISNULL(oObject)
		LOOP
	ENDIF
	IF TYPE("oObject")=="O" AND NOT ISNULL(oObject) AND PEMSTATUS(oObject,"Release",5)
		oObject.Release
	ENDIF
	IF NOT ISNULL(oObject) AND PEMSTATUS(oObject,"oHost",5)
		oObject.oHost=.NULL.
	ENDIF
	this.&lcName=.NULL.
	oObject=.NULL.
ENDFOR
DIMENSION this.aObjectRefs[1,3]
this.aObjectRefs=""

ENDPROC
PROCEDURE nobjectrefcount_access
LOCAL lnObjectRefCount

lnObjectRefCount=ALEN(this.aObjectRefs,1)
IF lnObjectRefCount=1 AND EMPTY(this.aObjectRefs[1])
	lnObjectRefCount=0
ENDIF
RETURN lnObjectRefCount

ENDPROC
PROCEDURE nobjectrefcount_assign
LPARAMETERS m.vNewVal

ERROR 1743

ENDPROC
PROCEDURE sethost
this.oHost=IIF(TYPE("thisform")=="O",thisform,.NULL.)

ENDPROC
PROCEDURE newinstance
LPARAMETERS tnDataSessionID
LOCAL oNewObject,lnLastDataSessionID

lnLastDataSessionID=SET("DATASESSION")
IF TYPE("tnDataSessionID")=="N" AND tnDataSessionID>=1
	SET DATASESSION TO tnDataSessionID
ENDIF
oNewObject=NEWOBJECT(this.Class,this.ClassLibrary)
SET DATASESSION TO (lnLastDataSessionID)
RETURN oNewObject

ENDPROC
PROCEDURE addtoproject
*-- Dummy code for adding files to project.
RETURN

DO SetObjRf.prg

ENDPROC
PROCEDURE ninstances_access
LOCAL laInstances[1]
	
RETURN AINSTANCE(laInstances,this.Class)

ENDPROC
PROCEDURE ninstances_assign
LPARAMETERS vNewVal

ERROR 1743

ENDPROC
PROCEDURE Error
LPARAMETERS nError, cMethod, nLine
LOCAL lcOnError,lcErrorMsg,lcCodeLineMsg

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
lcErrorMsg=MESSAGE()+CHR(13)+CHR(13)+this.Name+CHR(13)+ ;
		"Error:           "+ALLTRIM(STR(nError))+CHR(13)+ ;
		"Method:       "+LOWER(ALLTRIM(cMethod))
lcCodeLineMsg=MESSAGE(1)
IF BETWEEN(nLine,1,100000) AND NOT lcCodeLineMsg="..."
	lcErrorMsg=lcErrorMsg+CHR(13)+"Line:            "+ALLTRIM(STR(nLine))
	IF NOT EMPTY(lcCodeLineMsg)
		lcErrorMsg=lcErrorMsg+CHR(13)+CHR(13)+lcCodeLineMsg
	ENDIF
ENDIF
WAIT CLEAR
MESSAGEBOX(lcErrorMsg,16,_screen.Caption)
ERROR nError

ENDPROC
PROCEDURE Init
IF this.lSetHost
	this.SetHost
ENDIF
IF this.lAutoSetObjectRefs AND NOT this.SetObjectRefs(this)
	RETURN .F.
ENDIF

ENDPROC
PROCEDURE Destroy
IF this.lRelease
	RETURN .F.
ENDIF
this.lRelease=.T.
this.ReleaseObjRefs
this.oHost=.NULL.

ENDPROC


************************************************************
OBJETO: _xmladapter
************************************************************
*** PROPIEDADES ***
Height = 56
Width = 56
cversion = 
builder = 
builderx = (HOME()+"Wizards\BuilderD,BuilderDForm")
nobjectrefcount = 0
ohost = .NULL.
vresult = .T.
csetobjrefprogram = (IIF(VERSION(2)=0,"",HOME()+"FFC\")+"SetObjRf.prg")
ninstances = 0
Name = "_xmladapter"

*** METODOS ***
PROCEDURE release
LOCAL lcBaseClass

IF this.lRelease
	NODEFAULT
	RETURN .F.
ENDIF
this.lRelease=.T.
lcBaseClass=LOWER(this.BaseClass)
this.oHost=.NULL.
this.ReleaseObjRefs
IF NOT INLIST(lcBaseClass+" ","form ","formset ","toolbar ")
	RELEASE this
ENDIF

ENDPROC
PROCEDURE setobjectref
LPARAMETERS tcName,tvClass,tvClassLibrary
LOCAL lvResult

this.vResult=.T.
DO (this.cSetObjRefProgram) WITH (this),(tcName),(tvClass),(tvClassLibrary)
lvResult=this.vResult
this.vResult=.T.
RETURN lvResult

ENDPROC
PROCEDURE setobjectrefs
LPARAMETERS toObject

RETURN

ENDPROC
PROCEDURE releaseobjrefs
LOCAL lcName,oObject,lnCount

IF this.nObjectRefCount=0
	RETURN
ENDIF
FOR lnCount = this.nObjectRefCount TO 1 STEP -1
	lcName=this.aObjectRefs[lnCount,1]
	IF EMPTY(lcName) OR NOT PEMSTATUS(this,lcName,5) OR TYPE("this."+lcName)#"O"
		LOOP
	ENDIF
	oObject=this.&lcName
	IF ISNULL(oObject)
		LOOP
	ENDIF
	IF TYPE("oObject")=="O" AND NOT ISNULL(oObject) AND PEMSTATUS(oObject,"Release",5)
		oObject.Release
	ENDIF
	IF NOT ISNULL(oObject) AND PEMSTATUS(oObject,"oHost",5)
		oObject.oHost=.NULL.
	ENDIF
	this.&lcName=.NULL.
	oObject=.NULL.
ENDFOR
DIMENSION this.aObjectRefs[1,3]
this.aObjectRefs=""

ENDPROC
PROCEDURE nobjectrefcount_access
LOCAL lnObjectRefCount

lnObjectRefCount=ALEN(this.aObjectRefs,1)
IF lnObjectRefCount=1 AND EMPTY(this.aObjectRefs[1])
	lnObjectRefCount=0
ENDIF
RETURN lnObjectRefCount

ENDPROC
PROCEDURE nobjectrefcount_assign
LPARAMETERS m.vNewVal

ERROR 1743

ENDPROC
PROCEDURE sethost
this.oHost=IIF(TYPE("thisform")=="O",thisform,.NULL.)

ENDPROC
PROCEDURE newinstance
LPARAMETERS tnDataSessionID
LOCAL oNewObject,lnLastDataSessionID

lnLastDataSessionID=SET("DATASESSION")
IF TYPE("tnDataSessionID")=="N" AND tnDataSessionID>=1
	SET DATASESSION TO tnDataSessionID
ENDIF
oNewObject=NEWOBJECT(this.Class,this.ClassLibrary)
SET DATASESSION TO (lnLastDataSessionID)
RETURN oNewObject

ENDPROC
PROCEDURE addtoproject
*-- Dummy code for adding files to project.
RETURN

DO SetObjRf.prg

ENDPROC
PROCEDURE ninstances_access
LOCAL laInstances[1]
	
RETURN AINSTANCE(laInstances,this.Class)

ENDPROC
PROCEDURE ninstances_assign
LPARAMETERS vNewVal

ERROR 1743

ENDPROC
PROCEDURE Error
LPARAMETERS nError, cMethod, nLine
LOCAL lcOnError,lcErrorMsg,lcCodeLineMsg

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
lcErrorMsg=MESSAGE()+CHR(13)+CHR(13)+this.Name+CHR(13)+ ;
		"Error:           "+ALLTRIM(STR(nError))+CHR(13)+ ;
		"Method:       "+LOWER(ALLTRIM(cMethod))
lcCodeLineMsg=MESSAGE(1)
IF BETWEEN(nLine,1,100000) AND NOT lcCodeLineMsg="..."
	lcErrorMsg=lcErrorMsg+CHR(13)+"Line:            "+ALLTRIM(STR(nLine))
	IF NOT EMPTY(lcCodeLineMsg)
		lcErrorMsg=lcErrorMsg+CHR(13)+CHR(13)+lcCodeLineMsg
	ENDIF
ENDIF
WAIT CLEAR
MESSAGEBOX(lcErrorMsg,16,_screen.Caption)
ERROR nError

ENDPROC
PROCEDURE Init
IF this.lSetHost
	this.SetHost
ENDIF
IF this.lAutoSetObjectRefs AND NOT this.SetObjectRefs(this)
	RETURN .F.
ENDIF

ENDPROC
PROCEDURE Destroy
IF this.lRelease
	RETURN .F.
ENDIF
this.lRelease=.T.
this.ReleaseObjRefs
this.oHost=.NULL.

ENDPROC


************************************************************
OBJETO: Tables
************************************************************
*** PROPIEDADES ***
Top = 23
Left = 23
Height = 23
Width = 23
Name = "Tables"

*** METODOS ***


************************************************************
OBJETO: _xmlfield
************************************************************
*** PROPIEDADES ***
Height = 23
Width = 23
cversion = 
builder = 
builderx = (HOME()+"Wizards\BuilderD,BuilderDForm")
nobjectrefcount = 0
ohost = .NULL.
vresult = .T.
csetobjrefprogram = (IIF(VERSION(2)=0,"",HOME()+"FFC\")+"SetObjRf.prg")
ninstances = 0
Name = "_xmlfield"

*** METODOS ***
PROCEDURE release
LOCAL lcBaseClass

IF this.lRelease
	NODEFAULT
	RETURN .F.
ENDIF
this.lRelease=.T.
lcBaseClass=LOWER(this.BaseClass)
this.oHost=.NULL.
this.ReleaseObjRefs
IF NOT INLIST(lcBaseClass+" ","form ","formset ","toolbar ")
	RELEASE this
ENDIF

ENDPROC
PROCEDURE setobjectref
LPARAMETERS tcName,tvClass,tvClassLibrary
LOCAL lvResult

this.vResult=.T.
DO (this.cSetObjRefProgram) WITH (this),(tcName),(tvClass),(tvClassLibrary)
lvResult=this.vResult
this.vResult=.T.
RETURN lvResult

ENDPROC
PROCEDURE setobjectrefs
LPARAMETERS toObject

RETURN

ENDPROC
PROCEDURE releaseobjrefs
LOCAL lcName,oObject,lnCount

IF this.nObjectRefCount=0
	RETURN
ENDIF
FOR lnCount = this.nObjectRefCount TO 1 STEP -1
	lcName=this.aObjectRefs[lnCount,1]
	IF EMPTY(lcName) OR NOT PEMSTATUS(this,lcName,5) OR TYPE("this."+lcName)#"O"
		LOOP
	ENDIF
	oObject=this.&lcName
	IF ISNULL(oObject)
		LOOP
	ENDIF
	IF TYPE("oObject")=="O" AND NOT ISNULL(oObject) AND PEMSTATUS(oObject,"Release",5)
		oObject.Release
	ENDIF
	IF NOT ISNULL(oObject) AND PEMSTATUS(oObject,"oHost",5)
		oObject.oHost=.NULL.
	ENDIF
	this.&lcName=.NULL.
	oObject=.NULL.
ENDFOR
DIMENSION this.aObjectRefs[1,3]
this.aObjectRefs=""

ENDPROC
PROCEDURE nobjectrefcount_access
LOCAL lnObjectRefCount

lnObjectRefCount=ALEN(this.aObjectRefs,1)
IF lnObjectRefCount=1 AND EMPTY(this.aObjectRefs[1])
	lnObjectRefCount=0
ENDIF
RETURN lnObjectRefCount

ENDPROC
PROCEDURE nobjectrefcount_assign
LPARAMETERS m.vNewVal

ERROR 1743

ENDPROC
PROCEDURE sethost
this.oHost=IIF(TYPE("thisform")=="O",thisform,.NULL.)

ENDPROC
PROCEDURE newinstance
LPARAMETERS tnDataSessionID
LOCAL oNewObject,lnLastDataSessionID

lnLastDataSessionID=SET("DATASESSION")
IF TYPE("tnDataSessionID")=="N" AND tnDataSessionID>=1
	SET DATASESSION TO tnDataSessionID
ENDIF
oNewObject=NEWOBJECT(this.Class,this.ClassLibrary)
SET DATASESSION TO (lnLastDataSessionID)
RETURN oNewObject

ENDPROC
PROCEDURE addtoproject
*-- Dummy code for adding files to project.
RETURN

DO SetObjRf.prg

ENDPROC
PROCEDURE ninstances_access
LOCAL laInstances[1]
	
RETURN AINSTANCE(laInstances,this.Class)

ENDPROC
PROCEDURE ninstances_assign
LPARAMETERS vNewVal

ERROR 1743

ENDPROC
PROCEDURE Error
LPARAMETERS nError, cMethod, nLine
LOCAL lcOnError,lcErrorMsg,lcCodeLineMsg

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
lcErrorMsg=MESSAGE()+CHR(13)+CHR(13)+this.Name+CHR(13)+ ;
		"Error:           "+ALLTRIM(STR(nError))+CHR(13)+ ;
		"Method:       "+LOWER(ALLTRIM(cMethod))
lcCodeLineMsg=MESSAGE(1)
IF BETWEEN(nLine,1,100000) AND NOT lcCodeLineMsg="..."
	lcErrorMsg=lcErrorMsg+CHR(13)+"Line:            "+ALLTRIM(STR(nLine))
	IF NOT EMPTY(lcCodeLineMsg)
		lcErrorMsg=lcErrorMsg+CHR(13)+CHR(13)+lcCodeLineMsg
	ENDIF
ENDIF
WAIT CLEAR
MESSAGEBOX(lcErrorMsg,16,_screen.Caption)
ERROR nError

ENDPROC
PROCEDURE Init
IF this.lSetHost
	this.SetHost
ENDIF
IF this.lAutoSetObjectRefs AND NOT this.SetObjectRefs(this)
	RETURN .F.
ENDIF

ENDPROC
PROCEDURE Destroy
IF this.lRelease
	RETURN .F.
ENDIF
this.lRelease=.T.
this.ReleaseObjRefs
this.oHost=.NULL.

ENDPROC


************************************************************
OBJETO: _xmltable
************************************************************
*** PROPIEDADES ***
Height = 56
Width = 56
cversion = 
builder = 
builderx = (HOME()+"Wizards\BuilderD,BuilderDForm")
nobjectrefcount = 0
ohost = .NULL.
vresult = .T.
csetobjrefprogram = (IIF(VERSION(2)=0,"",HOME()+"FFC\")+"SetObjRf.prg")
ninstances = 0
Name = "_xmltable"

*** METODOS ***
PROCEDURE release
LOCAL lcBaseClass

IF this.lRelease
	NODEFAULT
	RETURN .F.
ENDIF
this.lRelease=.T.
lcBaseClass=LOWER(this.BaseClass)
this.oHost=.NULL.
this.ReleaseObjRefs
IF NOT INLIST(lcBaseClass+" ","form ","formset ","toolbar ")
	RELEASE this
ENDIF

ENDPROC
PROCEDURE setobjectref
LPARAMETERS tcName,tvClass,tvClassLibrary
LOCAL lvResult

this.vResult=.T.
DO (this.cSetObjRefProgram) WITH (this),(tcName),(tvClass),(tvClassLibrary)
lvResult=this.vResult
this.vResult=.T.
RETURN lvResult

ENDPROC
PROCEDURE setobjectrefs
LPARAMETERS toObject

RETURN

ENDPROC
PROCEDURE releaseobjrefs
LOCAL lcName,oObject,lnCount

IF this.nObjectRefCount=0
	RETURN
ENDIF
FOR lnCount = this.nObjectRefCount TO 1 STEP -1
	lcName=this.aObjectRefs[lnCount,1]
	IF EMPTY(lcName) OR NOT PEMSTATUS(this,lcName,5) OR TYPE("this."+lcName)#"O"
		LOOP
	ENDIF
	oObject=this.&lcName
	IF ISNULL(oObject)
		LOOP
	ENDIF
	IF TYPE("oObject")=="O" AND NOT ISNULL(oObject) AND PEMSTATUS(oObject,"Release",5)
		oObject.Release
	ENDIF
	IF NOT ISNULL(oObject) AND PEMSTATUS(oObject,"oHost",5)
		oObject.oHost=.NULL.
	ENDIF
	this.&lcName=.NULL.
	oObject=.NULL.
ENDFOR
DIMENSION this.aObjectRefs[1,3]
this.aObjectRefs=""

ENDPROC
PROCEDURE nobjectrefcount_access
LOCAL lnObjectRefCount

lnObjectRefCount=ALEN(this.aObjectRefs,1)
IF lnObjectRefCount=1 AND EMPTY(this.aObjectRefs[1])
	lnObjectRefCount=0
ENDIF
RETURN lnObjectRefCount

ENDPROC
PROCEDURE nobjectrefcount_assign
LPARAMETERS m.vNewVal

ERROR 1743

ENDPROC
PROCEDURE sethost
this.oHost=IIF(TYPE("thisform")=="O",thisform,.NULL.)

ENDPROC
PROCEDURE newinstance
LPARAMETERS tnDataSessionID
LOCAL oNewObject,lnLastDataSessionID

lnLastDataSessionID=SET("DATASESSION")
IF TYPE("tnDataSessionID")=="N" AND tnDataSessionID>=1
	SET DATASESSION TO tnDataSessionID
ENDIF
oNewObject=NEWOBJECT(this.Class,this.ClassLibrary)
SET DATASESSION TO (lnLastDataSessionID)
RETURN oNewObject

ENDPROC
PROCEDURE addtoproject
*-- Dummy code for adding files to project.
RETURN

DO SetObjRf.prg

ENDPROC
PROCEDURE ninstances_access
LOCAL laInstances[1]
	
RETURN AINSTANCE(laInstances,this.Class)

ENDPROC
PROCEDURE ninstances_assign
LPARAMETERS vNewVal

ERROR 1743

ENDPROC
PROCEDURE Error
LPARAMETERS nError, cMethod, nLine
LOCAL lcOnError,lcErrorMsg,lcCodeLineMsg

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
lcErrorMsg=MESSAGE()+CHR(13)+CHR(13)+this.Name+CHR(13)+ ;
		"Error:           "+ALLTRIM(STR(nError))+CHR(13)+ ;
		"Method:       "+LOWER(ALLTRIM(cMethod))
lcCodeLineMsg=MESSAGE(1)
IF BETWEEN(nLine,1,100000) AND NOT lcCodeLineMsg="..."
	lcErrorMsg=lcErrorMsg+CHR(13)+"Line:            "+ALLTRIM(STR(nLine))
	IF NOT EMPTY(lcCodeLineMsg)
		lcErrorMsg=lcErrorMsg+CHR(13)+CHR(13)+lcCodeLineMsg
	ENDIF
ENDIF
WAIT CLEAR
MESSAGEBOX(lcErrorMsg,16,_screen.Caption)
ERROR nError

ENDPROC
PROCEDURE Init
IF this.lSetHost
	this.SetHost
ENDIF
IF this.lAutoSetObjectRefs AND NOT this.SetObjectRefs(this)
	RETURN .F.
ENDIF

ENDPROC
PROCEDURE Destroy
IF this.lRelease
	RETURN .F.
ENDIF
this.lRelease=.T.
this.ReleaseObjRefs
this.oHost=.NULL.

ENDPROC


************************************************************
OBJETO: Fields
************************************************************
*** PROPIEDADES ***
Top = 23
Left = 23
Height = 23
Width = 23
Name = "Fields"

*** METODOS ***


************************************************************
OBJETO: _optionbutton2
************************************************************
*** PROPIEDADES ***
Caption = "Option1"
Height = 17
Width = 61
cversion = 
builder = 
builderx = (HOME()+"Wizards\BuilderD,BuilderDForm")
nobjectrefcount = 0
ohost = .NULL.
vresult = .T.
csetobjrefprogram = (IIF(VERSION(2)=0,"",HOME()+"FFC\")+"SetObjRf.prg")
ninstances = 0
Name = "_optionbutton2"

*** METODOS ***
PROCEDURE release
LOCAL lcBaseClass

IF this.lRelease
	NODEFAULT
	RETURN .F.
ENDIF
this.lRelease=.T.
lcBaseClass=LOWER(this.BaseClass)
this.oHost=.NULL.
this.ReleaseObjRefs
IF NOT INLIST(lcBaseClass+" ","form ","formset ","toolbar ")
	RELEASE this
ENDIF

ENDPROC
PROCEDURE setobjectref
LPARAMETERS tcName,tvClass,tvClassLibrary
LOCAL lvResult

this.vResult=.T.
DO (this.cSetObjRefProgram) WITH (this),(tcName),(tvClass),(tvClassLibrary)
lvResult=this.vResult
this.vResult=.T.
RETURN lvResult

ENDPROC
PROCEDURE setobjectrefs
LPARAMETERS toObject

RETURN

ENDPROC
PROCEDURE releaseobjrefs
LOCAL lcName,oObject,lnCount

IF this.nObjectRefCount=0
	RETURN
ENDIF
FOR lnCount = this.nObjectRefCount TO 1 STEP -1
	lcName=this.aObjectRefs[lnCount,1]
	IF EMPTY(lcName) OR NOT PEMSTATUS(this,lcName,5) OR TYPE("this."+lcName)#"O"
		LOOP
	ENDIF
	oObject=this.&lcName
	IF ISNULL(oObject)
		LOOP
	ENDIF
	IF TYPE("oObject")=="O" AND NOT ISNULL(oObject) AND PEMSTATUS(oObject,"Release",5)
		oObject.Release
	ENDIF
	IF NOT ISNULL(oObject) AND PEMSTATUS(oObject,"oHost",5)
		oObject.oHost=.NULL.
	ENDIF
	this.&lcName=.NULL.
	oObject=.NULL.
ENDFOR
DIMENSION this.aObjectRefs[1,3]
this.aObjectRefs=""

ENDPROC
PROCEDURE nobjectrefcount_access
LOCAL lnObjectRefCount

lnObjectRefCount=ALEN(this.aObjectRefs,1)
IF lnObjectRefCount=1 AND EMPTY(this.aObjectRefs[1])
	lnObjectRefCount=0
ENDIF
RETURN lnObjectRefCount

ENDPROC
PROCEDURE nobjectrefcount_assign
LPARAMETERS m.vNewVal

ERROR 1743

ENDPROC
PROCEDURE sethost
this.oHost=IIF(TYPE("thisform")=="O",thisform,.NULL.)

ENDPROC
PROCEDURE newinstance
LPARAMETERS tnDataSessionID
LOCAL oNewObject,lnLastDataSessionID

lnLastDataSessionID=SET("DATASESSION")
IF TYPE("tnDataSessionID")=="N" AND tnDataSessionID>=1
	SET DATASESSION TO tnDataSessionID
ENDIF
oNewObject=NEWOBJECT(this.Class,this.ClassLibrary)
SET DATASESSION TO (lnLastDataSessionID)
RETURN oNewObject

ENDPROC
PROCEDURE addtoproject
*-- Dummy code for adding files to project.
RETURN

DO SetObjRf.prg

ENDPROC
PROCEDURE ninstances_access
LOCAL laInstances[1]
	
RETURN AINSTANCE(laInstances,this.Class)

ENDPROC
PROCEDURE ninstances_assign
LPARAMETERS vNewVal

ERROR 1743

ENDPROC
PROCEDURE Destroy
IF this.lRelease
	RETURN .F.
ENDIF
this.lRelease=.T.
this.ReleaseObjRefs
this.oHost=.NULL.

ENDPROC
PROCEDURE Init
IF this.lSetHost
	this.SetHost
ENDIF
IF this.lAutoSetObjectRefs AND NOT this.SetObjectRefs(this)
	RETURN .F.
ENDIF

ENDPROC
PROCEDURE Error
LPARAMETERS nError, cMethod, nLine
LOCAL lcOnError,lcErrorMsg,lcCodeLineMsg

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
lcErrorMsg=MESSAGE()+CHR(13)+CHR(13)+this.Name+CHR(13)+ ;
		"Error:           "+ALLTRIM(STR(nError))+CHR(13)+ ;
		"Method:       "+LOWER(ALLTRIM(cMethod))
lcCodeLineMsg=MESSAGE(1)
IF BETWEEN(nLine,1,100000) AND NOT lcCodeLineMsg="..."
	lcErrorMsg=lcErrorMsg+CHR(13)+"Line:            "+ALLTRIM(STR(nLine))
	IF NOT EMPTY(lcCodeLineMsg)
		lcErrorMsg=lcErrorMsg+CHR(13)+CHR(13)+lcCodeLineMsg
	ENDIF
ENDIF
WAIT CLEAR
MESSAGEBOX(lcErrorMsg,16,_screen.Caption)
ERROR nError

ENDPROC


************************************************************
OBJETO: _optionbutton2
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: _page2
************************************************************
*** PROPIEDADES ***
Caption = "Page1"
Height = 16
Width = 60
cversion = 
builder = 
builderx = (HOME()+"Wizards\BuilderD,BuilderDForm")
nobjectrefcount = 0
ohost = .NULL.
vresult = .T.
csetobjrefprogram = (IIF(VERSION(2)=0,"",HOME()+"FFC\")+"SetObjRf.prg")
ninstances = 0
Name = "_page2"

*** METODOS ***
PROCEDURE release
LOCAL lcBaseClass

IF this.lRelease
	NODEFAULT
	RETURN .F.
ENDIF
this.lRelease=.T.
lcBaseClass=LOWER(this.BaseClass)
this.oHost=.NULL.
this.ReleaseObjRefs
IF NOT INLIST(lcBaseClass+" ","form ","formset ","toolbar ")
	RELEASE this
ENDIF

ENDPROC
PROCEDURE setobjectref
LPARAMETERS tcName,tvClass,tvClassLibrary
LOCAL lvResult

this.vResult=.T.
DO (this.cSetObjRefProgram) WITH (this),(tcName),(tvClass),(tvClassLibrary)
lvResult=this.vResult
this.vResult=.T.
RETURN lvResult

ENDPROC
PROCEDURE setobjectrefs
LPARAMETERS toObject

RETURN

ENDPROC
PROCEDURE releaseobjrefs
LOCAL lcName,oObject,lnCount

IF this.nObjectRefCount=0
	RETURN
ENDIF
FOR lnCount = this.nObjectRefCount TO 1 STEP -1
	lcName=this.aObjectRefs[lnCount,1]
	IF EMPTY(lcName) OR NOT PEMSTATUS(this,lcName,5) OR TYPE("this."+lcName)#"O"
		LOOP
	ENDIF
	oObject=this.&lcName
	IF ISNULL(oObject)
		LOOP
	ENDIF
	IF TYPE("oObject")=="O" AND NOT ISNULL(oObject) AND PEMSTATUS(oObject,"Release",5)
		oObject.Release
	ENDIF
	IF NOT ISNULL(oObject) AND PEMSTATUS(oObject,"oHost",5)
		oObject.oHost=.NULL.
	ENDIF
	this.&lcName=.NULL.
	oObject=.NULL.
ENDFOR
DIMENSION this.aObjectRefs[1,3]
this.aObjectRefs=""

ENDPROC
PROCEDURE nobjectrefcount_access
LOCAL lnObjectRefCount

lnObjectRefCount=ALEN(this.aObjectRefs,1)
IF lnObjectRefCount=1 AND EMPTY(this.aObjectRefs[1])
	lnObjectRefCount=0
ENDIF
RETURN lnObjectRefCount

ENDPROC
PROCEDURE nobjectrefcount_assign
LPARAMETERS m.vNewVal

ERROR 1743

ENDPROC
PROCEDURE sethost
this.oHost=IIF(TYPE("thisform")=="O",thisform,.NULL.)

ENDPROC
PROCEDURE newinstance
LPARAMETERS tnDataSessionID
LOCAL oNewObject,lnLastDataSessionID

lnLastDataSessionID=SET("DATASESSION")
IF TYPE("tnDataSessionID")=="N" AND tnDataSessionID>=1
	SET DATASESSION TO tnDataSessionID
ENDIF
oNewObject=NEWOBJECT(this.Class,this.ClassLibrary)
SET DATASESSION TO (lnLastDataSessionID)
RETURN oNewObject

ENDPROC
PROCEDURE addtoproject
*-- Dummy code for adding files to project.
RETURN

DO SetObjRf.prg

ENDPROC
PROCEDURE ninstances_access
LOCAL laInstances[1]
	
RETURN AINSTANCE(laInstances,this.Class)

ENDPROC
PROCEDURE ninstances_assign
LPARAMETERS vNewVal

ERROR 1743

ENDPROC
PROCEDURE Error
LPARAMETERS nError, cMethod, nLine
LOCAL lcOnError,lcErrorMsg,lcCodeLineMsg

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
lcErrorMsg=MESSAGE()+CHR(13)+CHR(13)+this.Name+CHR(13)+ ;
		"Error:           "+ALLTRIM(STR(nError))+CHR(13)+ ;
		"Method:       "+LOWER(ALLTRIM(cMethod))
lcCodeLineMsg=MESSAGE(1)
IF BETWEEN(nLine,1,100000) AND NOT lcCodeLineMsg="..."
	lcErrorMsg=lcErrorMsg+CHR(13)+"Line:            "+ALLTRIM(STR(nLine))
	IF NOT EMPTY(lcCodeLineMsg)
		lcErrorMsg=lcErrorMsg+CHR(13)+CHR(13)+lcCodeLineMsg
	ENDIF
ENDIF
WAIT CLEAR
MESSAGEBOX(lcErrorMsg,16,_screen.Caption)
ERROR nError

ENDPROC
PROCEDURE Init
IF this.lSetHost
	this.SetHost
ENDIF
IF this.lAutoSetObjectRefs AND NOT this.SetObjectRefs(this)
	RETURN .F.
ENDIF

ENDPROC
PROCEDURE Destroy
IF this.lRelease
	RETURN .F.
ENDIF
this.lRelease=.T.
this.ReleaseObjRefs
this.oHost=.NULL.

ENDPROC


