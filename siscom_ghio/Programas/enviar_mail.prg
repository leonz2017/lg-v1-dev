* ***********************************************
* Este programa permite enviar mails utilizando
* CDO
* Actualmentese usa en control físico y en
* la consulta de recibos
* ***********************************************

PARAMETERS tcAddress, ;
	tcAsunto, ;
	tcMensaje, ;
	tcFileName

LOCAL loCfg
LOCAL loMensaje

loCfg = CREATEOBJECT("CDO.Configuration")
loCfg.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "smtp.gmail.com"
loCfg.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 465
&&loCfg.Fields.Item("http://schemas.microsfot.com/cdo/configuration/smtpauthenticate") = .T.
loCfg.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = .t.
loCfg.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
loCfg.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendusername") = "noreply.lpsoft@gmail.com"
loCfg.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendpassword") = "LP2523eo"
loCfg.Fields.Update()

loMensaje = CREATEOBJECT("CDO.Message")
loMensaje.Configuration = loCfg
loMensaje.From = "noreply.lpsoft@gmail.com"
loMensaje.To = tcAddress
loMensaje.Subject = tcAsunto
loMensaje.TextBody = tcMensaje
IF !(ALLTRIM(tcFileName) == "") THEN
	loMensaje.AddAttachment(tcFileName)
ENDIF
loMensaje.Send()