************************************************************
OBJETO: Dataenvironment
************************************************************
*** PROPIEDADES ***
Top = 0
Left = 0
Width = 0
Height = 0
DataSource = .NULL.
Name = "Dataenvironment"

*** METODOS ***


************************************************************
OBJETO: frm_updxls_ghio
************************************************************
*** PROPIEDADES ***
DoCreate = .T.
Caption = "Generar planilla para vendedores"
Name = "frm_updxls_ghio"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Para crear la planilla para los vendedores hacé clic en aceptar"
Height = 12
Left = 84
Top = 24
Width = 384
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: btnAceptar
************************************************************
*** PROPIEDADES ***
Top = 72
Left = 220
Width = 45
Name = "btnAceptar"

*** METODOS ***
PROCEDURE Click
************************************************************
* Evento..........: btnAceptar.Click()
* Descripción.....: Ejecuta el proceso de exportación a Excel
* Desarrollado por: LINFOW - Leonardo D. Zulli
* Fecha...........: 15/09/2021
************************************************************
LOCAL loPlanillaPrecios

loPlanillaPrecios = CREATEOBJECT("PlanillaPrecios")
loPlanillaPrecios.Iniciar()
loPlanillaPrecios.Procesar()
MESSAGEBOX("Proceso finalizado", 0+64, Thisform.Caption)
ENDPROC


************************************************************
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 72
Left = 268
Width = 45
Name = "btnCerrar"

*** METODOS ***


************************************************************
OBJETO: 
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


