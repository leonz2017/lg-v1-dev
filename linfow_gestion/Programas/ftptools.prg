***********************************************************************
* Este script contiene funciones para subir archivos a un hosting
* mediante el protocolo FTP
***********************************************************************

#DEFINE GENERIC_READ    2147483648   && &H80000000 
#DEFINE GENERIC_WRITE   1073741824   && &H40000000 


**-------------------------------------------- 
** Establecemos la conexión 
**-------------------------------------------- 
FUNCTION  connect2ftp (strHost, strUser, strPwd)  
   ** Abrimos el acceso.   
    hOpen = InternetOpen ("vfp", 1, 0, 0, 0)   

    IF hOpen = 0   
        MESSAGEBOX("No tiene acceso a WinInet.Dll", 0+16, "FTP Services")
        RETURN .F.  
   ENDIF  

    ** Conectando al FTP. 
    hFtpSession = InternetConnect (hOpen, strHost, 0, strUser, strPwd, 1, 0, 0)   
 
    IF hFtpSession = 0   
        ** Cerrando acceso y saliendo.   
        = InternetCloseHandle (hOpen)   
        MESSAGEBOX("FTP " + strHost + " no está disponible", 0+16, "FTP Services")
        RETURN .F.  
     ELSE   
         WAIT WINDOW "Conectado a " + strHost + " como: [" + strUser + ", *****]" NOWAIT
   ENDIF   
RETURN .T.  


**-------------------------------------------- 
** Copia del/los archivos 
**-------------------------------------------- 
FUNCTION local2ftp (hConnect, lcSource, lcTarget) 
    ** Copiando el archivo local al directorio remoto ftp. 
    hSource = FOPEN (lcSource) 
    IF (hSource = -1)  
        RETURN -1 
    ENDIF 

    ** Creamos el nuevo archivo 
    hTarget = FtpOpenFile(hConnect, lcTarget, GENERIC_WRITE, 2, 0) 
    IF hTarget = 0 
       = FCLOSE (hSource) 
       RETURN -2 
    ENDIF 
    lnBytesWritten = 0 
    lnChunkSize = 256    && 128, 512 
    DO WHILE Not FEOF(hSource) 
        lcBuffer = FREAD (hSource, lnChunkSize) 
        lnLength = Len(lcBuffer) 
        IF lnLength > 0 
           IF InternetWriteFile (hTarget, @lcBuffer, lnLength, @lnLength) = 1 
                lnBytesWritten = lnBytesWritten + lnLength 
				lnKB = (lnBytesWritten / 1024) / 1024
				WAIT WINDOW "Enviado Archivo: " + ALLTRIM(STR(lnKB, 10, 2)) + " MB. procesados..." NOWAIT
           ELSE 
                EXIT 
           ENDIF 
        ELSE 
            EXIT 
        ENDIF 
   ENDDO 

   = InternetCloseHandle (hTarget) 
   = FCLOSE (hSource) 

RETURN  lnBytesWritten