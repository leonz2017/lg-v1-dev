LOCAL lo_SoapClient, loSoapClientURL, lnResult

loSoapClient = CREATEOBJECT("MSSOAP.SoapClient30")
*loSoapClientURL = "http://siscom.hol.es/ws_siscom/pedidos_siscom.php?wsdl"
loSoapClientURL = "http://siscom.hol.es/ws_siscom/pedidos_siscli.php?wsdl"
loSoapClient.MSSoapInit(loSoapClientURL)

*lnResult = loSoapClient.insertCliente(1, "LALA", "X")
*lnResult = loSoapClient.clienteDuplicado(1)

*lnResult = loSoapClient.insertarPedido(1, 'fileName', 'HOLA', 1)
*MESSAGEBOX(lnResult)
*lnResult = loSoapClient.insertItemPedido(lnResult, 'XX', 1)
lnResult = loSoapClient.clienteDuplicado(23)
MESSAGEBOX(lnResult)

RELEASE loSoapClient