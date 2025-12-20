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
OBJETO: frm_test_mail
************************************************************
*** PROPIEDADES ***
DoCreate = .T.
Caption = "Testeador de mails"
Name = "frm_test_mail"

*** METODOS ***


************************************************************
OBJETO: lbl_resultado
************************************************************
*** PROPIEDADES ***
Caption = ""
Height = 24
Left = 48
Top = 24
Width = 408
ForeColor = 0,128,0
Name = "lbl_resultado"

*** METODOS ***


************************************************************
OBJETO: btnProbarMail
************************************************************
*** PROPIEDADES ***
Top = 108
Left = 168
Height = 36
Width = 168
Caption = "Enviar mail"
Name = "btnProbarMail"

*** METODOS ***
PROCEDURE Click
LOCAL lcMailMsg 

TEXT TO lcMailMsg NOSHOW
MENSAJE DE PRUEBA

--
Mail generado por sistema LINFOW Gestión.

ENDTEXT

&& Procedo a hacer el envío de mail
DO LOCFILE("FoxyPreviewer.App")
WITH _screen.oFoxyPreviewer	
	.cEmailType = "PDF"
	.nEmailMode = 2
	.cEMailTo = "info@linfow.com.ar"
	.cEmailCC = ALLTRIM(getGlobalCFG("EMAILCC"))
	.cSMTPServer = getGlobalCFG("EMAILSMTP")
	.cEmailFrom = getGlobalCFG("EMAILEMP") + "<" + getGlobalCFG("EMAILADDR") + ">"
	.cEMailSubject = "Mensaje de prueba "
	.nSMTPPort = getGlobalCFG("EMAILPORT")
	.lSMTPUseSSL = getGlobalCFG("EMAILSSL")
	.cSMTPUserName = getGlobalCFG("EMAILUSR")
	.cSMTPPassword = getGlobalCFG("EMAILPWD")
	.lReadReceipt  = .F.
	.lPriority = .F.
	.cEmailBody = lcMailMsg
	.SendEmailUsingCDO()
ENDWITH
DO LOCFILE("FoxyPreviewer.App") WITH "Release"
ENDPROC


************************************************************
OBJETO: 
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


