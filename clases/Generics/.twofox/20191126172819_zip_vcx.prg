************************************************************
OBJETO: interface
************************************************************
*** PROPIEDADES ***
Height = 400
Width = 536
Desktop = .T.
DoCreate = .T.
ShowTips = .T.
AutoCenter = .T.
Caption = "Gestor de respaldo en Zip"
MinHeight = 400
MinWidth = 500
WindowType = 1
AllowOutput = .F.
_memberdata =       85<VFPData><memberdata name="comprimir" type="method" display="Comprimir"/></VFPData>

Name = "interface"

*** METODOS ***
PROCEDURE comprimir
*!* Variables locales
LOCAL lnContador as Number
lnContador=0

*!* Limpiando lista de archivos
thisform.zip1.ArchivosExcluir=''
thisform.zip1.ArchivosIncluir=''


WITH thisform.pgfZip.pagCompresion.pgfArchivos

	*!* Agregando archivos al zip
	WITH .pagIncluir.lstIncluir
		FOR lnContador=1 TO .ListCount
			thisform.zip1.Agregar(.List(lnContador),'+')
		ENDFOR
	ENDWITH
	
	*!* Agregando archivos a excluir en el zip
	WITH .pagExcluir.lstExcluir
		FOR lnContador=1 TO .ListCount
			thisform.zip1.Agregar(.List(lnContador),'-')
		ENDFOR
	ENDWITH
ENDWITH

*!* Procesar a ZIP
RETURN thisform.zip1.Comprimir()

ENDPROC
PROCEDURE descomprimir
*!* Procesar a ZIP
RETURN thisform.zip1.Descomprimir()

ENDPROC
PROCEDURE Init
this.Icon= _screen.Icon

ENDPROC


************************************************************
OBJETO: Zip1
************************************************************
*** PROPIEDADES ***
Top = 372
Left = 22
Height = 19
Width = 21
Name = "Zip1"

*** METODOS ***


************************************************************
OBJETO: Commandgroup1
************************************************************
*** PROPIEDADES ***
AutoSize = .F.
ButtonCount = 3
Anchor = 12
BorderStyle = 1
Value = 1
Height = 34
Left = 278
Top = 360
Width = 251
TabIndex = 2
Name = "Commandgroup1"
Command1.Top = 4
Command1.Left = 4
Command1.Height = 25
Command1.Width = 81
Command1.FontSize = 8
Command1.Caption = "Comprimir"
Command1.Name = "cmdComprimir"
Command2.Top = 4
Command2.Left = 85
Command2.Height = 25
Command2.Width = 81
Command2.FontSize = 8
Command2.Caption = "Descomprimir"
Command2.Name = "cmdDescomprimir"
Command3.Top = 4
Command3.Left = 166
Command3.Height = 25
Command3.Width = 81
Command3.FontSize = 8
Command3.Caption = "Cerrar"
Command3.Name = "cmdCerrar"

*** METODOS ***
PROCEDURE cmdComprimir.Click
LOCAL lnArchivosProcesador as Number 

IF EMPTY(thisform.zip1.ArchivoZip)=.f.

	* Informando del inicio del proceso
	thisform.SetAll('Enabled',.f.)
	=MESSAGEBOX('A continuación se inicia el proceso de respando, esta tarea puede tardar varios minutos',0+64+0,'Inicio')
	
	* Comprimir
	lnArchivosProcesador=thisform.comprimir()
	
	* Informando resultados
	=MESSAGEBOX('TERMINADO '+TRANSFORM(DATETIME())+CHR(13);
				+'Procesados '+TRANSFORM(lnArchivosProcesador)+' archivos',0+64+0,'Terminado')
	thisform.SetAll('Enabled',.t.)
	
ELSE
	=MESSAGEBOX('No ha definido un nombre de archivo para el Zip',0+16+0,'Nombre?',3600)
ENDIF

ENDPROC
PROCEDURE cmdDescomprimir.Click
LOCAL lnArchivosProcesados as Number 

IF EMPTY(thisform.zip1.ArchivoZip)=.f.

	* Informando del inicio del proceso
	thisform.SetAll('Enabled',.f.)
	=MESSAGEBOX('A continuación se inicia el proceso de descompresión, esta tarea puede tardar varios minutos',0+64+0,'Inicio')
	
	* Descomprimir
	lnArchivosProcesados=thisform.descomprimir()
	
	* Informando resultados
	=MESSAGEBOX('TERMINADO '+TRANSFORM(DATETIME())+CHR(13);
				+'Procesados '+TRANSFORM(lnArchivosProcesados)+' archivos',0+64+0,'Terminado')
	thisform.SetAll('Enabled',.t.)
	
ELSE
	=MESSAGEBOX('No ha definido ningun archivo Zip',0+16+0,'Archivo?',3600)
ENDIF


ENDPROC
PROCEDURE cmdCerrar.Click
thisform.Release

ENDPROC


************************************************************
OBJETO: pgfZip
************************************************************
*** PROPIEDADES ***
ErasePage = .T.
PageCount = 3
Anchor = 15
TabStyle = 1
Top = 5
Left = 6
Width = 523
Height = 352
TabIndex = 1
Name = "pgfZip"
Page1.FontSize = 8
Page1.Caption = "\<Compresión"
Page1.Name = "pagCompresion"
Page2.FontSize = 8
Page2.Caption = "\<Descompresión"
Page2.Name = "pagDescompresion"
Page3.FontSize = 8
Page3.Caption = "\<Opciones"
Page3.Name = "pagOpciones"

*** METODOS ***


************************************************************
OBJETO: lblDestino
************************************************************
*** PROPIEDADES ***
FontSize = 8
BackStyle = 0
Caption = "Destino"
Height = 16
Left = 4
Top = 9
Width = 38
TabIndex = 1
Name = "lblDestino"

*** METODOS ***


************************************************************
OBJETO: txtDestinoZip
************************************************************
*** PROPIEDADES ***
FontSize = 8
Anchor = 10
ControlSource = "thisform.Zip1.ArchivoZip"
Height = 22
Left = 69
StatusBarText = "Ruta y nombre del archivo Zip"
TabIndex = 2
ToolTipText = (this.statusbartext)
Top = 6
Width = 417
Name = "txtDestinoZip"

*** METODOS ***
PROCEDURE Valid
this.Value=FULLPATH(this.Value)
ENDPROC


************************************************************
OBJETO: cmdDestino
************************************************************
*** PROPIEDADES ***
Top = 6
Left = 491
Height = 22
Width = 22
Anchor = 8
Caption = "..."
StatusBarText = "Crear archivo zip"
TabIndex = 3
ToolTipText = (this.statusbartext)
Name = "cmdDestino"

*** METODOS ***
PROCEDURE Click
this.Parent.txtDestinoZip.Value=ALLTRIM(LOWER(PUTFILE('Destino','','zip')))
ENDPROC


************************************************************
OBJETO: edtComentario
************************************************************
*** PROPIEDADES ***
Anchor = 14
Height = 46
Left = 4
StatusBarText = "Comentarios"
TabIndex = 9
ToolTipText = (this.statusbartext)
Top = 271
Width = 482
ControlSource = "thisform.zip1.comentario"
Name = "edtComentario"

*** METODOS ***


************************************************************
OBJETO: lblOpciones
************************************************************
*** PROPIEDADES ***
FontSize = 8
Anchor = 4
BackStyle = 0
Caption = "Comentario"
Height = 16
Left = 4
Top = 252
Width = 56
TabIndex = 8
Style = 3
Name = "lblOpciones"

*** METODOS ***


************************************************************
OBJETO: pgfArchivos
************************************************************
*** PROPIEDADES ***
ErasePage = .T.
PageCount = 2
Anchor = 15
TabStyle = 1
Top = 56
Left = 4
Width = 509
Height = 195
TabIndex = 7
Name = "pgfArchivos"
Page1.FontSize = 8
Page1.Caption = "Archivos a \<Incluir"
Page1.Name = "pagIncluir"
Page2.FontSize = 8
Page2.Caption = "Archivos a \<Excluir"
Page2.Name = "pagExcluir"

*** METODOS ***


************************************************************
OBJETO: lstIncluir
************************************************************
*** PROPIEDADES ***
FontSize = 8
Anchor = 15
Height = 149
Left = 4
MultiSelect = .T.
TabIndex = 1
Top = 9
Width = 436
Name = "lstIncluir"

*** METODOS ***


************************************************************
OBJETO: cmdAgregarIncluirArchivo
************************************************************
*** PROPIEDADES ***
Top = 8
Left = 445
Height = 41
Width = 56
FontSize = 8
Anchor = 8
WordWrap = .T.
Caption = "Agregar \<Archivo"
TabIndex = 2
SpecialEffect = 2
Name = "cmdAgregarIncluirArchivo"

*** METODOS ***
PROCEDURE Click
LOCAL lcArchivo as String 

lcArchivo=GETFILE()
IF EMPTY(lcArchivo)=.f.
	this.Parent.lstIncluir.AddListItem(lcArchivo)
ENDIF

ENDPROC


************************************************************
OBJETO: cmdQuitarIncluir
************************************************************
*** PROPIEDADES ***
Top = 107
Left = 445
Height = 25
Width = 56
FontSize = 8
Anchor = 12
Caption = "\<Quitar"
TabIndex = 4
SpecialEffect = 2
Name = "cmdQuitarIncluir"

*** METODOS ***
PROCEDURE Click
LOCAL lnContador as Number


FOR lnContador=1 TO this.Parent.lstIncluir.ListCount
	IF this.Parent.lstIncluir.SelectedID(lnContador)=.t.
		this.Parent.lstIncluir.RemoveListItem(lnContador)
	ENDIF
ENDFOR

ENDPROC


************************************************************
OBJETO: cmdAgregarIncluirCarpeta
************************************************************
*** PROPIEDADES ***
Top = 50
Left = 445
Height = 41
Width = 56
FontSize = 8
Anchor = 8
WordWrap = .T.
Caption = "Agregar Car\<peta"
TabIndex = 3
SpecialEffect = 2
Name = "cmdAgregarIncluirCarpeta"

*** METODOS ***
PROCEDURE Click
LOCAL lcCarpeta as String 

lcCarpeta=GETDIR()

IF EMPTY(lcCarpeta)=.f.
	lcCarpeta=INPUTBOX('Agregar archivos que contengan','Filtro de archivos',lcCarpeta+'*.*',0,lcCarpeta,'')
	IF EMPTY(lcCarpeta)=.f.
		this.Parent.lstIncluir.AddListItem(lcCarpeta)
	ENDIF
ENDIF

ENDPROC


************************************************************
OBJETO: cmdLimpiarIncluir
************************************************************
*** PROPIEDADES ***
Top = 133
Left = 445
Height = 25
Width = 56
FontSize = 8
Anchor = 12
Caption = "\<Limpiar"
TabIndex = 5
SpecialEffect = 2
Name = "cmdLimpiarIncluir"

*** METODOS ***
PROCEDURE Click
this.Parent.lstIncluir.Clear

ENDPROC


************************************************************
OBJETO: lstExcluir
************************************************************
*** PROPIEDADES ***
FontSize = 8
Anchor = 15
Height = 149
Left = 4
MultiSelect = .T.
TabIndex = 1
Top = 9
Width = 436
Name = "lstExcluir"

*** METODOS ***


************************************************************
OBJETO: cmdAgregarExcluirArchivo
************************************************************
*** PROPIEDADES ***
Top = 8
Left = 445
Height = 41
Width = 56
FontSize = 8
Anchor = 8
WordWrap = .T.
Caption = "Agregar \<Archivo"
TabIndex = 2
SpecialEffect = 2
Name = "cmdAgregarExcluirArchivo"

*** METODOS ***
PROCEDURE Click
LOCAL lcArchivo as String 

lcArchivo=GETFILE()
IF EMPTY(lcArchivo)=.f.
	this.Parent.lstExcluir.AddListItem(lcArchivo)
ENDIF

ENDPROC


************************************************************
OBJETO: cmdQuitarExcluir
************************************************************
*** PROPIEDADES ***
Top = 107
Left = 445
Height = 25
Width = 56
FontSize = 8
Anchor = 12
Caption = "\<Quitar"
TabIndex = 4
SpecialEffect = 2
Name = "cmdQuitarExcluir"

*** METODOS ***
PROCEDURE Click
LOCAL lnContador as Number


FOR lnContador=1 TO this.Parent.lstExcluir.ListCount
	IF this.Parent.lstExcluir.SelectedID(lnContador)=.t.
		this.Parent.lstExcluir.RemoveListItem(lnContador)
	ENDIF
ENDFOR

ENDPROC


************************************************************
OBJETO: cmdAgregarExcluirCarpeta
************************************************************
*** PROPIEDADES ***
Top = 50
Left = 445
Height = 41
Width = 56
FontSize = 8
Anchor = 8
WordWrap = .T.
Caption = "Agregar Car\<peta"
TabIndex = 3
SpecialEffect = 2
Name = "cmdAgregarExcluirCarpeta"

*** METODOS ***
PROCEDURE Click
LOCAL lcCarpeta as String 

lcCarpeta=GETDIR()

IF EMPTY(lcCarpeta)=.f.
	lcCarpeta=INPUTBOX('Agregar archivos que contengan','Filtro de archivos',lcCarpeta+'*.*',0,lcCarpeta,'')
	IF EMPTY(lcCarpeta)=.f.
		this.Parent.lstExcluir.AddListItem(lcCarpeta)
	ENDIF
ENDIF

ENDPROC


************************************************************
OBJETO: cmdLimpiarExcluir
************************************************************
*** PROPIEDADES ***
Top = 133
Left = 445
Height = 25
Width = 56
FontSize = 8
Anchor = 12
Caption = "\<Limpiar"
TabIndex = 5
SpecialEffect = 2
Name = "cmdLimpiarExcluir"

*** METODOS ***
PROCEDURE Click
this.Parent.lstExcluir.Clear

ENDPROC


************************************************************
OBJETO: cmdComentarioCargar
************************************************************
*** PROPIEDADES ***
Top = 295
Left = 491
Height = 22
Width = 22
Anchor = 12
Caption = "..."
StatusBarText = "Cragar comentario desde archivo de texto"
TabIndex = 10
ToolTipText = (this.statusbartext)
Name = "cmdComentarioCargar"

*** METODOS ***
PROCEDURE Click
LOCAL loHandleArchivo as Object, lnTamañoArchivo as Number, lcTexto as String, lcArchivo as String 
lcArchivo=GETFILE('txt')
lcTexto=''

IF EMPTY(lcArchivo)=.f. AND FILE(lcArchivo)=.t. && Si el archivo no existe o no se ha cargado
	loHandleArchivo = FOPEN(lcArchivo)	&&Abrir el archivo y retornar handle
	lnTamañoArchivo =  FSEEK(loHandleArchivo, 0, 2)     &&Mueve el puntero al final y retorna el tamaño
	IF lnTamañoArchivo > 0
		= FSEEK(loHandleArchivo, 0, 0)      && Mueve el puntero al inicio
		lcTexto = FREAD(loHandleArchivo, lnTamañoArchivo)
	ELSE
		=MESSAGEBOX('El archivo esta en vacio',0+64+0,'Archivo vacio',3600)
	ENDIF
	= FCLOSE(loHandleArchivo)   
ELSE
	=MESSAGEBOX('No se puede cargar el archivo',0+16+0,'Error al cargar',3600)
ENDIF

this.Parent.edtComentario.Value=ALLTRIM(LOWER(lcTexto))
ENDPROC


************************************************************
OBJETO: txtContraseña
************************************************************
*** PROPIEDADES ***
FontBold = .T.
FontSize = 13
Height = 22
Left = 69
StatusBarText = "Contraseña para proteger el contenido del ZIP"
TabIndex = 5
ToolTipText = (this.statusbartext)
Top = 31
Width = 135
PasswordChar = (chr(149))
Name = "txtContraseña"

*** METODOS ***


************************************************************
OBJETO: lblContraseña
************************************************************
*** PROPIEDADES ***
FontSize = 8
BackStyle = 0
Caption = "Contraseña"
Height = 16
Left = 5
Top = 34
Width = 58
TabIndex = 4
Name = "lblContraseña"

*** METODOS ***


************************************************************
OBJETO: chkMostrarContraseña
************************************************************
*** PROPIEDADES ***
Top = 33
Left = 210
Height = 16
Width = 113
FontSize = 8
Alignment = 0
BackStyle = 0
Caption = "Mostrar contrase\<ña"
Value = .F.
StatusBarText = "Muestra la contraseña"
TabIndex = 6
ToolTipText = (this.statusbartext)
Name = "chkMostrarContraseña"

*** METODOS ***
PROCEDURE Valid
IF this.Value=.t.
	this.Parent.txtContraseña.PasswordChar=''
	this.Parent.txtContraseña.FontBold= .F.
	this.Parent.txtContraseña.FontSize=8
ELSE
	this.Parent.txtContraseña.PasswordChar=chr(149)
	this.Parent.txtContraseña.FontBold= .T.
	this.Parent.txtContraseña.FontSize=13
ENDIF

	
ENDPROC


************************************************************
OBJETO: lblOrigen
************************************************************
*** PROPIEDADES ***
FontSize = 8
BackStyle = 0
Caption = "Origen"
Height = 16
Left = 4
Top = 9
Width = 38
TabIndex = 1
Name = "lblOrigen"

*** METODOS ***


************************************************************
OBJETO: txtOrigenZip
************************************************************
*** PROPIEDADES ***
FontSize = 8
Anchor = 10
ControlSource = "thisform.Zip1.ArchivoZip"
Height = 22
Left = 69
StatusBarText = "Ruta y nombre del archivo Zip"
TabIndex = 2
ToolTipText = (this.statusbartext)
Top = 6
Width = 417
Name = "txtOrigenZip"

*** METODOS ***
PROCEDURE Valid
this.Value=FULLPATH(this.Value)
ENDPROC


************************************************************
OBJETO: cmdOrigen
************************************************************
*** PROPIEDADES ***
Top = 6
Left = 491
Height = 22
Width = 22
Anchor = 8
Caption = "..."
StatusBarText = "Crear archivo zip"
TabIndex = 3
ToolTipText = (this.statusbartext)
Name = "cmdOrigen"

*** METODOS ***
PROCEDURE Click
this.Parent.txtOrigenZip.Value=ALLTRIM(LOWER(GETFILE('zip')))
ENDPROC


************************************************************
OBJETO: Label1
************************************************************
*** PROPIEDADES ***
FontSize = 8
BackStyle = 0
Caption = "Destino"
Height = 16
Left = 5
Top = 34
Width = 38
TabIndex = 4
Name = "Label1"

*** METODOS ***


************************************************************
OBJETO: txtDirectorioDestino
************************************************************
*** PROPIEDADES ***
FontSize = 8
Anchor = 10
BackStyle = 0
ControlSource = "thisform.Zip1.DirectorioDestino"
Enabled = .F.
Height = 22
Left = 69
ReadOnly = .T.
StatusBarText = "Ruta y nombre del archivo Zip"
TabIndex = 5
ToolTipText = (this.statusbartext)
Top = 31
Width = 417
DisabledForeColor = 0,0,0
Name = "txtDirectorioDestino"

*** METODOS ***
PROCEDURE Valid
this.Value=FULLPATH(this.Value)
ENDPROC
PROCEDURE Init
this.Value=ALLTRIM(FULLPATH(thisform.zip1.DirectorioDestino))
ENDPROC


************************************************************
OBJETO: Command1
************************************************************
*** PROPIEDADES ***
Top = 31
Left = 491
Height = 22
Width = 22
Anchor = 8
Caption = "..."
StatusBarText = "Crear archivo zip"
TabIndex = 6
ToolTipText = (this.statusbartext)
Name = "Command1"

*** METODOS ***
PROCEDURE Click
this.Parent.txtDirectorioDestino.Value=ALLTRIM(LOWER(GETDIR()))
ENDPROC


************************************************************
OBJETO: txtContraseña
************************************************************
*** PROPIEDADES ***
FontBold = .T.
FontSize = 13
Height = 22
Left = 69
StatusBarText = "Contraseña para proteger el contenido del ZIP"
TabIndex = 8
ToolTipText = (this.statusbartext)
Top = 56
Width = 135
PasswordChar = (chr(149))
Name = "txtContraseña"

*** METODOS ***


************************************************************
OBJETO: lblContraseña
************************************************************
*** PROPIEDADES ***
FontSize = 8
BackStyle = 0
Caption = "Contraseña"
Height = 16
Left = 5
Top = 59
Width = 58
TabIndex = 7
Name = "lblContraseña"

*** METODOS ***


************************************************************
OBJETO: chkMostrarContraseña
************************************************************
*** PROPIEDADES ***
Top = 59
Left = 209
Height = 16
Width = 113
FontSize = 8
Alignment = 0
BackStyle = 0
Caption = "Mostrar contrase\<ña"
Value = .F.
StatusBarText = "Muestra la contraseña"
TabIndex = 9
ToolTipText = (this.statusbartext)
Name = "chkMostrarContraseña"

*** METODOS ***
PROCEDURE Valid
IF this.Value=.t.
	this.Parent.txtContraseña.PasswordChar=''
	this.Parent.txtContraseña.FontBold= .F.
	this.Parent.txtContraseña.FontSize=8
ELSE
	this.Parent.txtContraseña.PasswordChar=chr(149)
	this.Parent.txtContraseña.FontBold= .T.
	this.Parent.txtContraseña.FontSize=13
ENDIF

	
ENDPROC


************************************************************
OBJETO: lblMetodo
************************************************************
*** PROPIEDADES ***
FontSize = 8
BackStyle = 0
Caption = "Método de Compresión"
Height = 16
Left = 8
Top = 101
Width = 112
TabIndex = 8
Name = "lblMetodo"

*** METODOS ***


************************************************************
OBJETO: cboMetodo
************************************************************
*** PROPIEDADES ***
FontSize = 8
ColumnCount = 0
ColumnWidths = ""
RowSourceType = 1
RowSource = "La mejor,Normal,Minima,Ninguna"
FirstElement = 1
Height = 22
Left = 8
NumberOfElements = 0
StatusBarText = "Nivel de compresión del archivo, Método"
Style = 2
TabIndex = 9
ToolTipText = (this.statusbartext)
Top = 116
Width = 176
BoundTo = .T.
Name = "cboMetodo"

*** METODOS ***
PROCEDURE Valid
LOCAL lnNivelCompresion as Number
DO CASE 
	CASE ALLTRIM(UPPER(this.Value))='LA MEJOR'
		lnNivelCompresion=3
	CASE ALLTRIM(UPPER(this.Value))='NORMAL'
		lnNivelCompresion=2
	CASE ALLTRIM(UPPER(this.Value))='MINIMA'
		lnNivelCompresion=1
	CASE ALLTRIM(UPPER(this.Value))='NINGUNA'
		lnNivelCompresion=0
	OTHERWISE 
		lnNivelCompresion=2
ENDCASE 
thisform.zip1.Compresion=lnNivelCompresion

ENDPROC
PROCEDURE InteractiveChange
this.Valid


ENDPROC
PROCEDURE Init
this.ListItemId=2
ENDPROC


************************************************************
OBJETO: chkSubdirectorios
************************************************************
*** PROPIEDADES ***
Top = 7
Left = 8
Height = 16
Width = 112
FontSize = 8
Alignment = 0
BackStyle = 0
Caption = "Incluir \<subdirectorio"
Value = .T.
ControlSource = "thisform.zip1.Subdirectorios"
StatusBarText = "Incluir subdirectorio"
TabIndex = 1
ToolTipText = (this.statusbartext)
Name = "chkSubdirectorios"

*** METODOS ***


************************************************************
OBJETO: Line1
************************************************************
*** PROPIEDADES ***
Anchor = 10
Height = 0
Left = 8
Top = 95
Width = 500
BorderColor = 0,128,255
Name = "Line1"

*** METODOS ***


************************************************************
OBJETO: chkEntrarDirectorio
************************************************************
*** PROPIEDADES ***
Top = 27
Left = 8
Height = 16
Width = 112
FontSize = 8
Alignment = 0
BackStyle = 0
Caption = "Incluir direct\<orios"
Value = .F.
ControlSource = "thisform.zip1.EntrarDirectorio"
StatusBarText = "No habilitado"
TabIndex = 2
ToolTipText = (this.statusbartext)
ReadOnly = .T.
Name = "chkEntrarDirectorio"

*** METODOS ***


************************************************************
OBJETO: chkEntrarDirectorioVacio
************************************************************
*** PROPIEDADES ***
Top = 47
Left = 8
Height = 16
Width = 135
FontSize = 8
Alignment = 0
BackStyle = 0
Caption = "Incluir directorios \<vacios"
Value = .F.
ControlSource = "thisform.zip1.EntrarDirectorioVacio"
StatusBarText = "No habilitado"
TabIndex = 3
ToolTipText = (this.statusbartext)
ReadOnly = .T.
Name = "chkEntrarDirectorioVacio"

*** METODOS ***


************************************************************
OBJETO: chkRestaurarEstructura
************************************************************
*** PROPIEDADES ***
Top = 67
Left = 8
Height = 16
Width = 119
FontSize = 8
Alignment = 0
BackStyle = 0
Caption = "Restaurar estructura"
ControlSource = "thisform.zip1.RestaurarEstructura"
StatusBarText = "Incluir subdirectorio"
TabIndex = 4
ToolTipText = (this.statusbartext)
Name = "chkRestaurarEstructura"

*** METODOS ***


************************************************************
OBJETO: lblSobrescribir
************************************************************
*** PROPIEDADES ***
FontSize = 8
BackStyle = 0
Caption = "Sobrescribir archivos"
Height = 16
Left = 197
Top = 101
Width = 112
TabIndex = 10
Name = "lblSobrescribir"

*** METODOS ***


************************************************************
OBJETO: cboSobrescribir
************************************************************
*** PROPIEDADES ***
FontSize = 8
ColumnCount = 0
ColumnWidths = ""
RowSourceType = 1
RowSource = "Preguntar antes,Siempre sobrescribir,Nunca sobrescribir"
FirstElement = 1
Height = 22
Left = 197
NumberOfElements = 0
StatusBarText = "Nivel de compresión del archivo, Método"
Style = 2
TabIndex = 11
ToolTipText = (this.statusbartext)
Top = 116
Width = 176
BoundTo = .T.
Name = "cboSobrescribir"

*** METODOS ***
PROCEDURE Valid
LOCAL lnNivelCompresion as Number
DO CASE 
	CASE ALLTRIM(UPPER(this.Value))='PREGUNTAR ANTES'
		lnSobrescribir=10
	CASE ALLTRIM(UPPER(this.Value))='SIEMPRE SOBRESCRIBIR'
		lnSobrescribir=11
	CASE ALLTRIM(UPPER(this.Value))='NUNCA SOBRESCRIBIR'
		lnSobrescribir=12
	OTHERWISE 
		lnSobrescribir=10
ENDCASE 
thisform.zip1.Sobrescribir=lnSobrescribir
ENDPROC
PROCEDURE InteractiveChange
this.Valid


ENDPROC
PROCEDURE Init
this.ListItemId=1
ENDPROC


************************************************************
OBJETO: chkIncluirArchivosOcultos
************************************************************
*** PROPIEDADES ***
Top = 7
Left = 200
Height = 16
Width = 134
FontSize = 8
Alignment = 0
BackStyle = 0
Caption = "Incluir Archivos ocultos "
Value = 1
ControlSource = "thisform.zip1.IncluirArchivosOcultos"
StatusBarText = "Incluir subdirectorio"
TabIndex = 5
ToolTipText = (this.statusbartext)
Name = "chkIncluirArchivosOcultos"

*** METODOS ***
PROCEDURE Click


ENDPROC


************************************************************
OBJETO: chkIncluirSoloLectura
************************************************************
*** PROPIEDADES ***
Top = 27
Left = 200
Height = 16
Width = 158
FontSize = 8
Alignment = 0
BackStyle = 0
Caption = "Incluir Archivos Solo-Lectura"
Value = 1
ControlSource = "thisform.zip1.IncluirArchivosSoloLectura"
StatusBarText = "No habilitado"
TabIndex = 6
ToolTipText = (this.statusbartext)
Name = "chkIncluirSoloLectura"

*** METODOS ***


************************************************************
OBJETO: chkIncluirArchivoDelSistema
************************************************************
*** PROPIEDADES ***
Top = 47
Left = 200
Height = 16
Width = 150
FontSize = 8
Alignment = 0
BackStyle = 0
Caption = "Incluir Archivos del sistema"
Value = 1
ControlSource = "thisform.zip1.IncluirArchivosDelSistema"
StatusBarText = "No habilitado"
TabIndex = 7
ToolTipText = (this.statusbartext)
Name = "chkIncluirArchivoDelSistema"

*** METODOS ***


************************************************************
OBJETO: interface
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 13, 8, 20, 15, 45, 4, 1

*** METODOS ***


************************************************************
OBJETO: zip
************************************************************
*** PROPIEDADES ***
Height = 28
Width = 73
_memberdata =     1945<VFPData><memberdata name="comprimir" type="method" display="Comprimir"/><memberdata name="registronombre" type="property" display="RegistroNombre"/><memberdata name="subdirectorios" type="property" display="Subdirectorios"/><memberdata name="entrardirectorio" type="property" display="EntrarDirectorio"/><memberdata name="entrardirectoriovacio" type="property" display="EntrarDirectorioVacio"/><memberdata name="compresion" type="property" display="Compresion"/><memberdata name="archivozip" type="property" display="ArchivoZip"/><memberdata name="archivosexcluir" type="property" display="ArchivosExcluir"/><memberdata name="archivosincluir" type="property" display="ArchivosIncluir"/><memberdata name="contraseña" type="property" display="Contraseña"/><memberdata name="agregar" type="method" display="Agregar"/><memberdata name="comentario" type="property" display="Comentario"/><memberdata name="guardarestructura" type="property" display="GuardarEstructura"/><memberdata name="multivolumenes" type="property" display="MultiVolumenes"/><memberdata name="registrollave" type="property" display="RegistroLlave"/><memberdata name="registrousuario" type="property" display="RegistroUsuario"/><memberdata name="descomprimir" type="method" display="Descomprimir"/><memberdata name="directoriodestino" type="property" display="DirectorioDestino"/><memberdata name="restaurarestructura" type="property" display="RestaurarEstructura"/><memberdata name="freshen" type="property" display="Freshen"/><memberdata name="sobrescribir" type="property" display="Sobrescribir"/><memberdata name="archivosextraer" type="property" display="ArchivosExtraer"/><memberdata name="incluirarchivosdelsistema" type="property" display="IncluirArchivosDelSistema"/><memberdata name="incluirarchivosocultos" type="property" display="IncluirArchivosOcultos"/><memberdata name="incluirarchivossololectura" type="property" display="IncluirArchivosSoloLectura"/></VFPData>

subdirectorios = .T.
entrardirectorio = .F.
entrardirectoriovacio = .F.
compresion = 2
archivozip = 
archivosincluir = 
archivosexcluir = 
contraseña = 
comentario = 
guardarestructura = 1
multivolumenes = 0
registrousuario = UBS, INC.
registrollave = 600365060
directoriodestino = 
restaurarestructura = 1
freshen = 1
sobrescribir = 11
archivosextraer = 
incluirarchivosocultos = 0
incluirarchivossololectura = 0
incluirarchivosdelsistema = 0
Name = "zip"

*** METODOS ***
PROCEDURE comprimir
WITH this
	*!* Validando propiedades antes de Iniciar
	DO CASE 
		CASE EMPTY(.ArchivoZip)=.t.
			=MESSAGEBOX('No ha definido el archivo zip de destino',0+48+0,'Zip destino')
			RETURN 0
		CASE EMPTY(.ArchivosIncluir)=.t.
			=MESSAGEBOX('No ha incluido archivos para comprimir',0+48+0,'Archivos a incluir')
			RETURN 0
		CASE FILE('aZip32.dll')=.f.
			=MESSAGEBOX('No se ha encontrado el archivo aZip32.dll',0+16+0,'Falta archivo')
			RETURN 0
		OTHERWISE 
			*!* Declarando metodos de la API de Windows
			PRIVATE HWND
			DECLARE INTEGER GetActiveWindow IN win32api
			HWND = GetActiveWindow()

			*!* Declarando metodos y propiedades de la API aZIP32.dll
			DECLARE addZIP_Initialise IN AZIP32
			DECLARE SHORT addZIP_SetParentWindowHandle IN AZIP32 SHORT HWindow
			DECLARE SHORT addZIP_ArchiveName IN AZIP32 STRING @ sArchName
			DECLARE SHORT addZIP_Include IN AZIP32 STRING @ sFileName
			DECLARE SHORT addZIP_Exclude IN AZIP32 STRING @ seFileName
			DECLARE SHORT addZIP_Recurse IN AZIP32 SHORT nRecurse
			DECLARE SHORT addZIP_SetCompressionLevel IN AZIP32 SHORT nComprLvl
			DECLARE SHORT addZIP_IncludeDirectoryEntries IN AZIP32 SHORT nInclDir
			DECLARE SHORT addZIP_IncludeEmptyDirectoryEntries IN AZIP32 SHORT nInclEDir
			DECLARE SHORT addZIP_Update IN AZIP32 SHORT nUpdate
			DECLARE SHORT addZIP_SpanSizes IN AZIP32 LONG @ ulFirst, LONG @ ulOther
			DECLARE SHORT addZIP_Span IN AZIP32 SHORT nSpan
			DECLARE SHORT addZIP_Register IN AZIP32 STRING @ RegName, LONG RegNum
			DECLARE SHORT addZIP_Encrypt IN AZIP32 STRING @ sPassw
			DECLARE INTEGER addZIP IN AZIP32
			DECLARE INTEGER addZIP_Comment IN AZIP32 STRING @ lpStr
			DECLARE INTEGER addZIP_SaveStructure IN AZIP32 INTEGER Int16 
			DECLARE INTEGER addZIP_BuildSFX IN AZIP32 INTEGER iFlag 
			DECLARE INTEGER addZIP_IncludeHidden IN AZIP32 INTEGER iFlag 
			DECLARE INTEGER addZIP_IncludeSystem IN AZIP32 INTEGER iFlag 
			DECLARE INTEGER addZIP_IncludeReadOnly IN AZIP32 INTEGER iFlag 
			

			*!* Iniciando proceso
			addZIP_Initialise()	&& Iniciando proceso
			addZIP_IncludeHidden(IIF(.IncluirArchivosOcultos>1,1,.IncluirArchivosOcultos))			&& Incluir en el Zip Archivos Ocultos
			addZIP_IncludeSystem(IIF(.IncluirArchivosSoloLectura>1,1,.IncluirArchivosSoloLectura))	&& Incluir en el Zip Archivos del sistema
			addZIP_IncludeReadOnly(IIF(.IncluirArchivosSoloLectura>1,1,.IncluirArchivosSoloLectura))&& Incluir en el Zip Archivos de solo lectura
			addZIP_SetParentWindowHandle(_screen.HWnd)	&& Handle
			addZIP_Register(.RegistroUsuario,.RegistroLlave) && Registrando
			addZIP_Recurse(IIF(.Subdirectorios=.t.,1,0)) &&Almacenar informacion de subdirectorios
			addZIP_IncludeDirectoryEntries(IIF(.EntrarDirectorio=.t.,1,0))	&&
			addZIP_IncludeEmptyDirectoryEntries(IIF(.EntrarDirectorioVacio=.t.,1,0))	&&
			addZIP_SetCompressionLevel(ICASE(.Compresion<0,2,.Compresion>3,2,.Compresion))
			addZIP_SaveStructure(ICASE(.GuardarEstructura<0,0,.Compresion>2,2,.GuardarEstructura))
			addZIP_ArchiveName(.ArchivoZip) && Archivo de destino ZIP
			addZIP_Include(.ArchivosIncluir) && Archivos a Incluir, separador por |
			addZIP_Exclude(.ArchivosExcluir) && Archivos a excluir, separados por |
			addZIP_Encrypt(.Contraseña)	&& Contraseña de acceso
			addZIP_Comment(.Comentario)	&& Comenatorio en el archivo
			addZIP_Span(.MultiVolumenes) && Multiples volumenes
			RETURN addZIP() && Comprime y retorna los archivos procesados
	ENDCASE 
ENDWITH

ENDPROC
PROCEDURE agregar
LPARAMETERS tcArchivo as String, tcOpcion as String 

*!* Dando formato a los parametros
tcArchivo=ALLTRIM(UPPER(TRANSFORM(tcArchivo)))
tcOpcion=ALLTRIM(UPPER(TRANSFORM(tcOpcion)))

WITH this
	*!* Valida parametros
	DO CASE 
		CASE tcArchivo$.ArchivosIncluir
			=MESSAGEBOX('El archivo '+tcArchivo+' Ya se ha agregado con anterioridad',0+48+0,'Archivo',3200)
		OTHERWISE 
			*!* Segun opcion agrega a la lista de Inlcuir o de escluir
			DO CASE 
				CASE tcOpcion='+'
					.ArchivosIncluir=.ArchivosIncluir+IIF(EMPTY(.ArchivosIncluir)=.f.,'|','')+tcArchivo
				CASE tcOpcion='-'
					.ArchivosExcluir=.ArchivosExcluir+IIF(EMPTY(.ArchivosExcluir)=.f.,'|','')+tcArchivo
				OTHERWISE 
					=MESSAGEBOX('Error de parametro, A:Inlcuir en zip, E:Excluir en zip',0+16+0,'Parametro',6400)
			ENDCASE 
	ENDCASE 
ENDWITH 

ENDPROC
PROCEDURE descomprimir
WITH this
	*!* Validando propiedades antes de Iniciar
	DO CASE 
		CASE EMPTY(.ArchivoZip)=.t. OR FILE(.ArchivoZip)=.f. 
			=MESSAGEBOX('No ha definido el archivo zip de origen o no exite',0+48+0,'Zip origen')
			RETURN 0
		CASE FILE('aUnZip32.dll')=.f.
			=MESSAGEBOX('No se ha encontrado el archivo aUnZip32.dll',0+16+0,'Falta archivo')
			RETURN 0
		OTHERWISE 
			*!* Declarando metodos de la API de Windows
			PRIVATE HWND
			DECLARE INTEGER GetActiveWindow IN win32api
			HWND = GetActiveWindow()

			*!* Declarando metodos y propiedades de la API aUnZIP32.dll			
			DECLARE LONG addUNZIP IN aunzip32.DLL
			DECLARE INTEGER addUNZIP_Abort IN aunzip32.DLL INTEGER iFlag
			DECLARE INTEGER addUNZIP_ArchiveName IN aunzip32.DLL STRING filename
			DECLARE INTEGER addUNZIP_Decrypt IN aunzip32.DLL STRING cPassword
			DECLARE INTEGER addUNZIP_DisplayComment IN aunzip32.DLL INTEGER bFlag
			DECLARE INTEGER addUNZIP_Exclude IN aunzip32.DLL STRING FILES
			DECLARE INTEGER addUNZIP_ExcludeListFile IN aunzip32.DLL STRING cFile
			DECLARE INTEGER addUNZIP_ExtractTo IN aunzip32.DLL STRING cPath
			DECLARE INTEGER addUNZIP_Freshen IN aunzip32.DLL INTEGER iFlag
			DECLARE INTEGER addUNZIP_GetLastError IN aunzip32.DLL
			DECLARE INTEGER addUNZIP_GetLastWarning IN aunzip32.DLL
			DECLARE INTEGER addUNZIP_Include IN aunzip32.DLL STRING FILES
			DECLARE INTEGER addUNZIP_IncludeListFile IN aunzip32.DLL STRING cFile
			DECLARE addUNZIP_Initialise IN aunzip32.DLL
			DECLARE INTEGER addUNZIP_InstallCallback IN aunzip32.DLL STRING funnc
			DECLARE INTEGER addUNZIP_Overwrite IN aunzip32.DLL INTEGER iFlag
			DECLARE INTEGER addUNZIP_Register IN aunzip32.DLL STRING cName, LONG lNumber
			DECLARE INTEGER addUNZIP_ResetDefaults IN aunzip32.DLL
			DECLARE INTEGER addUNZIP_RestoreAttributes IN aunzip32.DLL INTEGER iFlag
			DECLARE INTEGER addUNZIP_RestoreStructure IN aunzip32.DLL INTEGER iFlag
			DECLARE INTEGER addUNZIP_SetParentWindowHandle IN aunzip32.DLL LONG HWND
			DECLARE INTEGER addUNZIP_SetWindowHandle IN aunzip32.DLL LONG HWND
			DECLARE INTEGER addUNZIP_Test IN aunzip32.DLL INTEGER iFlag
			DECLARE INTEGER addUNZIP_ToMemory IN aunzip32.DLL STRING lpStr, LONG Uint32
			DECLARE INTEGER addUNZIP_Update IN aunzip32.DLL INTEGER iFlag
			DECLARE INTEGER addUNZIP_View IN aunzip32.DLL INTEGER bFlag
			
			*!* Iniciando proceso
			addUNZIP_Initialise()
			addUNZIP_SetParentWindowHandle(_screen.HWnd)
			addUNZIP_Register(ALLTRIM(.RegistroUsuario),.RegistroLlave)
			addUNZIP_Decrypt(.Contraseña)
			addUNZIP_RestoreStructure(.RestaurarEstructura)
			addUNZIP_Freshen(.Freshen)
			addUNZIP_ArchiveName(.ArchivoZip)
			addUNZIP_ExtractTo(ALLTRIM(FULLPATH(.DirectorioDestino)))
			addUNZIP_Include(IIF(EMPTY(.ArchivosExtraer)=.t.,'*.*',.ArchivosExtraer))
			addUNZIP_Overwrite(ICASE(.Sobrescribir>12,12,.Sobrescribir<10,10,.Sobrescribir))
			RETURN addUNZIP()
	ENDCASE 
ENDWITH


		
ENDPROC


