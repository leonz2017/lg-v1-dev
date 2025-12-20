************************************************************
OBJETO: _poolmanager
************************************************************
*** PROPIEDADES ***
cclass = 
cclasslibrary = 
ocollection = .NULL.
lraiseevent = .T.
nobjectscreated = 0
Name = "_poolmanager"

*** METODOS ***
PROCEDURE get
*========================================================================================
* Returns an object for exclusive use of the caller. If the object doesn't exist, a new
* one is created. 
*========================================================================================
LParameter tu01, tu02, tu03, tu04, tu05, tu06, tu07, tu08, tu09, tu10, tu11, tu12, ;
	tu13, tu14, tu15, tu16, tu17, tu18, tu19, tu20, tu21, tu22

	*--------------------------------------------------------------------------------------
	* Parameter string
	*--------------------------------------------------------------------------------------
	Local lcParam
	lcParam = Left( ;
		",tu01,tu02,tu03,tu04,tu05,tu06,tu07,tu08,tu09,tu10,tu11,tu12,"+;
		"tu13,tu14,tu15,tu16,tu17,tu18,tu19,tu20,tu21,tu22", ;
		Pcount()*5 ;
	)

	*--------------------------------------------------------------------------------------
	* obtain an object or create a new one
	*--------------------------------------------------------------------------------------
	Local loObject
	If This.oCollection.Count == 0
		Assert Vartype(This.cClass) == "C"
		Assert not Empty(This.cClass)
		Assert Vartype(This.cClassLibrary) == "C"
		Private THISPOOLMANAGER
		THISPOOLMANAGER = This
		This.nObjectsCreated = This.nObjectsCreated + 1
		If Pcount() == 0
			loObject = NewObject( This.cClass, This.cClassLibrary )
		Else
			loObject = NewObject( This.cClass, This.cClassLibrary, "" &lcParam )
		EndIf 
		Release THISPOOLMANAGER
		Assert Vartype(m.loObject) == "O"
		If not Vartype(m.loObject) == "O"
			Error 1736
		EndIf 
	Else
		loObject = This.oCollection.Item(1)
		This.oCollection.Remove(1)
	EndIf 
	
	*--------------------------------------------------------------------------------------
	* Raise the ObjectRequested event
	*--------------------------------------------------------------------------------------
	Assert Vartype(This.lRaiseEvent) == "L"
	If This.lRaiseEvent
		If Pcount() == 0
			RaiseEvent( This, "ObjectRequested", m.loObject )
		Else
			RaiseEvent( This, "ObjectRequested", m.loObject &lcParam )
		EndIf 
	EndIf 

Return m.loObject
ENDPROC
PROCEDURE objectrequested
*========================================================================================
* Event fires when an object has been requested
*========================================================================================
LParameter toObject, tu01, tu02, tu03, tu04, tu05, tu06, tu07, tu08, tu09, tu10, ;
	tu11, tu12, tu13, tu14, tu15, tu16, tu17, tu18, tu19, tu20, tu21, tu22
ENDPROC
PROCEDURE free
*========================================================================================
* Returns an object back to the pool. Sets the reference to NULL if successful.
*========================================================================================
LParameter roObject

	Assert Vartype(m.roObject) == "O"
	If not Vartype(m.roObject) == "O"
		Error 11
	EndIf 

	This.oCollection.Add(m.roObject)

	Assert Vartype(This.lRaiseEvent) == "L"
	If This.lRaiseEvent
		RaiseEvent( This, "ObjectReturned", m.roObject)
	EndIf 

	roObject = NULL
	
ENDPROC
PROCEDURE objectreturned
*========================================================================================
* Event fires when an object has been returned
*========================================================================================
LParameter toObject

ENDPROC
PROCEDURE Init
*========================================================================================
* When used with CREATEOBJECT(), you can pass the class and library of the pooled object
* as parameters.
*========================================================================================
LParameter tcClass, tcClassLibrary

	Assert InList(Vartype(m.tcClass),"L","C")
	Assert Iif( Vartype(m.tcClass)=="C", not Empty(m.tcClass), .T. )
	Assert InList(Vartype(m.tcClassLibrary),"L","C")
	
	If Vartype(m.tcClass) == "C"
		This.cClass = m.tcClass
	EndIf 
	If Vartype(m.tcClassLibrary) == "C"
		This.cClassLibrary = m.tcClassLibrary
	EndIf 
	
	This.oCollection = CreateObject("Collection")
	Assert Vartype(This.oCollection) == "O"
	If not Vartype(This.oCollection) == "O"
		Error 1736
	EndIf 
	
ENDPROC


