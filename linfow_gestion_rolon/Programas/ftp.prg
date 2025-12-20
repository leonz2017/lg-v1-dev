 EXTERNAL ARRAY lnflag
ENDPROC
**
DEFINE CLASS FTP_SERVICE AS custom
 HIDDEN ldll_loaded, nresult_code, nextended_result, cextended_message, ninet_handle, nconnect_handle, luseproxy, cipaddress, cusername, cpassword, cport, ncachingtype, olistpe
 cipaddress = ""
 cusername = ""
 cpassword = ""
 cport = "21"
 ninet_handle = 0
 nconnect_handle = 0
 ldll_loaded = .F.
 nresult_code = 0
 nextended_result = 0
 cextended_message = ""
 ccurrentdir = ""
 ncachingtype = 67108864
 cagent = "Visual FoxPro"+CHR(0)
 nflags = 134217728
 lmultioperations = .T.
 cstartupfolder = ""
 cproxyprotocol = ""
 cproxyhost = ""
 cproxyport = ""
 luseproxy = .F.
 olistpe = .NULL.
 DIMENSION aioptions(50)
 ftpopen = .F.
**
   PROTECTED FUNCTION Init
    IF _DOS .OR. _UNIX .OR. _MAC
       RETURN .F.
    ENDIF
   ENDFUNC
**
   PROTECTED FUNCTION LoadAPIFuncs
    IF this.ldll_loaded
       RETURN 0
    ENDIF
    DECLARE INTEGER GetLastError IN Kernel32
    DECLARE INTEGER FileTimeToSystemTime IN Kernel32 STRING @, STRING @
    DECLARE INTEGER InternetAutodial IN WinInet INTEGER, INTEGER
    DECLARE INTEGER InternetAutodialHangup IN WinInet INTEGER
    DECLARE INTEGER InternetDial IN WinInet INTEGER, STRING @, INTEGER, INTEGER @, INTEGER
    DECLARE INTEGER InternetHangUp IN WinInet INTEGER, INTEGER
    DECLARE INTEGER InternetGetConnectedState IN WinInet INTEGER @, INTEGER
    DECLARE INTEGER InternetGoOnline IN WinInet STRING @, INTEGER, INTEGER
    DECLARE INTEGER InternetOpen IN WinInet STRING @, INTEGER, STRING @, STRING @, INTEGER
    DECLARE InternetQueryOption IN WinInet INTEGER, INTEGER, INTEGER @, INTEGER @
    DECLARE INTEGER InternetSetOption IN WININET.DLL INTEGER, INTEGER, INTEGER @, INTEGER
    DECLARE INTEGER InternetConnect IN WinInet INTEGER, STRING @, SHORT, STRING @, STRING @, INTEGER, INTEGER, INTEGER
    DECLARE INTEGER InternetCloseHandle IN WinInet INTEGER
    DECLARE INTEGER FtpCreateDirectory IN WinInet INTEGER, STRING @
    DECLARE INTEGER FtpDeleteFile IN WinInet INTEGER, STRING @
    DECLARE INTEGER FtpFindFirstFile IN WinInet INTEGER, STRING @, STRING @, INTEGER, INTEGER
    DECLARE INTEGER InternetFindNextFile IN WinInet INTEGER, STRING @
    DECLARE INTEGER FtpGetCurrentDirectory IN WinInet INTEGER, STRING @, INTEGER @
    DECLARE INTEGER FtpGetFile IN WinInet INTEGER, STRING @, STRING @, INTEGER, INTEGER, INTEGER, INTEGER
    DECLARE INTEGER FtpOpenFile IN WinInet INTEGER, STRING @, INTEGER, INTEGER, INTEGER
    DECLARE INTEGER FtpPutFile IN WinInet INTEGER, STRING @, STRING @, INTEGER, INTEGER
    DECLARE INTEGER FtpRemoveDirectory IN WinInet INTEGER, STRING @
    DECLARE INTEGER FtpRenameFile IN WinInet INTEGER, STRING @, STRING @
    DECLARE INTEGER FtpSetCurrentDirectory IN WinInet INTEGER, STRING @
    DECLARE INTEGER FtpCommand IN WinInet INTEGER, INTEGER, INTEGER, STRING @, INTEGER, INTEGER @
    DECLARE INTEGER InternetGetLastResponseInfo IN WinInet INTEGER @, STRING @, INTEGER @
    DECLARE INTEGER InternetWriteFile IN WinInet INTEGER, STRING @, INTEGER, INTEGER @
    DECLARE INTEGER InternetReadFile IN WinInet INTEGER, STRING @, INTEGER, INTEGER @
    this.ldll_loaded = .T.
    this.aioptions(2) = 3600000
    this.aioptions(8) = 3600000
    this.aioptions(7) = 3600000
    this.aioptions(3) = 5
    this.aioptions(6) = 3600000
    this.aioptions(5) = 3600000
    RETURN 0
   ENDFUNC
**
   FUNCTION IsGlobalOffline
    LOCAL listate
    listate = 0
    lnsize = 4
    IF this.loadapifuncs()<>0
       RETURN -1
    ENDIF
    IF internetqueryoption(0, 50, @m.listate, @m.lnsize)
       RETURN IIF(BITTEST(m.listate, 4) .OR. BITTEST(m.listate, 1), 1, 0)
    ENDIF
    RETURN -1
   ENDFUNC
**
   FUNCTION AutoDialInternet
    LPARAMETERS lntype
    LOCAL lnhwndhandle, fresult
    IF this.loadapifuncs()<>0
       RETURN .F.
    ENDIF
    IF TYPE(m.lntype)<>"N"
       RETURN .F.
    ENDIF
    = this.beforeautodialinternet(m.lntype)
    lnhwndhandle = 0
    fresult = internetautodial(m.lntype, m.lnhwndhandle)
    = this.getextendederror()
    = this.afterautodialinternet(m.lntype, m.fresult)
    RETURN m.fresult<>0
   ENDFUNC
**
   PROCEDURE BeforeAutoDialInternet
    LPARAMETERS lntype
**
** ReFox - este procedimiento es vacío **
**
   ENDPROC
**
   PROCEDURE AfterAutoDialInternet
    LPARAMETERS lntype, fresult
**
** ReFox - este procedimiento es vacío **
**
   ENDPROC
**
   FUNCTION AutoDialHangUp
    LOCAL fresult
    IF this.loadapifuncs()<>0
       RETURN .F.
    ENDIF
    = this.beforeautodialhangup()
    fresult = internetautodialhangup(0)
    this.getextendederror()
    = this.afterautodialhangup(m.fresult)
    RETURN m.fresult<>0
   ENDFUNC
**
   PROCEDURE BeforeAutoDialHangUp
**
** ReFox - este procedimiento es vacío **
**
   ENDPROC
**
   PROCEDURE AfterAutoDialHangUp
    LPARAMETERS fresult
**
** ReFox - este procedimiento es vacío **
**
   ENDPROC
**
   FUNCTION DialInternet
    LPARAMETERS lcdialupname, lnflag
    LOCAL fresult, lnconnectionid, lnhwndhandle
    IF this.loadapifuncs()<>0
       RETURN -1
    ENDIF
    STORE 0 TO lnconnectionid, lnhwndhandle
    IF TYPE("m.lcDialUpName")<>"C" .OR. TYPE("m.lnFlag")<>"N"
       RETURN -1
    ENDIF
    IF LEN(ALLTRIM(m.lcdialupname))=0
       RETURN -1
    ENDIF
    lcdialupname = m.lcdialupname+CHR(0)
    = this.beforedialinternet(m.lcdialupname, m.lnflag)
    fresult = internetdial(m.lnhwndhandle, @m.lcdialupname, m.lnflag, @m.lnconnectionid, 0)
    = this.getextendederror()
    = this.afterdialinternet(@m.lcdialupname, m.lnflag, m.lnconnectionid, m.fresult)
    RETURN m.lnconnectionid
   ENDFUNC
**
   PROCEDURE BeforeDialInternet
    LPARAMETERS lcdialupname, lnflag
**
** ReFox - este procedimiento es vacío **
**
   ENDPROC
**
   PROCEDURE AfterDialInternet
    LPARAMETERS lcdialupname, lnflag, lnconnectionid, fresult
**
** ReFox - este procedimiento es vacío **
**
   ENDPROC
**
   FUNCTION DialHangUp
    LPARAMETERS lnconnectionid
    LOCAL fresult
    IF this.loadapifuncs()<>0
       RETURN .F.
    ENDIF
    IF TYPE("m.lnConnectionID")<>"N"
       RETURN .F.
    ENDIF
    = this.beforedialhangup(m.lnconnectionid)
    fresult = internethangup(m.lnconnectionid, 0)
    this.getextendederror()
    = this.afterdialhangup(m.lnconnectionid, m.fresult)
    RETURN m.fresult<>0
   ENDFUNC
**
   PROCEDURE BeforeDialHangUp
    LPARAMETERS lnconnectionid
**
** ReFox - este procedimiento es vacío **
**
   ENDPROC
**
   PROCEDURE AfterDialHangUp
    LPARAMETERS lnconnectionid, fresult
**
** ReFox - este procedimiento es vacío **
**
   ENDPROC
**
   FUNCTION GetConnectedState
    LOCAL fresult, lnconnectionstate
    IF this.loadapifuncs()<>0
       RETURN -1
    ENDIF
    lnconnectionstate = 0
    = this.beforegetconnectedstate()
    fresult = internetgetconnectedstate(@m.lnconnectionstate, 0)
    = this.getextendederror()
    = this.aftergetconnectedstate(m.fresult, m.lnconnectionstate)
    RETURN IIF(m.fresult=0, -1, m.lnconnectionstate)
   ENDFUNC
**
   PROCEDURE BeforeGetConnectedState
**
** ReFox - este procedimiento es vacío **
**
   ENDPROC
**
   PROCEDURE AfterGetConnectedState
    LPARAMETERS fresult, lnconnectionstate
**
** ReFox - este procedimiento es vacío **
**
   ENDPROC
**
   FUNCTION GoOnline
    LPARAMETERS lcurl
    LOCAL lnhwndhandle, fresult
    IF this.loadapifuncs()<>0
       RETURN .F.
    ENDIF
    IF TYPE("m.lcURL")<>"C"
       RETURN .F.
    ENDIF
    lcurl = m.lcurl+CHR(0)
    lnhwndhandle = 0
    = this.beforegoonline(@m.lcurl)
    fresult = internetgoonline(@m.lcurl, m.lnhwndhandle, 0)
    = this.getextendederror()
    = this.aftergoonline(@m.lcurl, m.fresult)
    RETURN m.fresult<>0
   ENDFUNC
**
   PROCEDURE BeforeGoOnline
    LPARAMETERS lcurl
**
** ReFox - este procedimiento es vacío **
**
   ENDPROC
**
   PROCEDURE AfterGoOnline
    LPARAMETERS lcurl, fresult
**
** ReFox - este procedimiento es vacío **
**
   ENDPROC
**
   FUNCTION OpenInternet
    LPARAMETERS lcusername, lcpassword, lcipaddress, lcport, lnflag
    LOCAL lnpcount, fresult, lnconnecthandle, liaccesstype, lcproxybypass, lcproxyname
    this.ftpopen = .F.
    lnpcount = PCOUNT()
    IF m.lnpcount<4
       this.nresult_code = 012010
       RETURN .F.
    ENDIF
    lnflag = IIF(m.lnpcount<5, 0, m.lnflag)
    IF (TYPE("m.lcUserName")<>"C") .OR. (TYPE("m.lcPassword")<>"C") .OR. (TYPE("m.lcIPAddress")<>"C") .OR. (TYPE("m.lcPort")<>"C")
       this.nresult_code = 87
       RETURN .F.
    ENDIF
    IF EMPTY(m.lcusername) .OR. EMPTY(m.lcpassword) .OR. EMPTY(m.lcipaddress)
       this.nresult_code = 87
       RETURN .F.
    ENDIF
    IF this.loadapifuncs()<>0
       RETURN .F.
    ENDIF
    this.cusername = m.lcusername+CHR(0)
    this.cpassword = m.lcpassword+CHR(0)
    this.cipaddress = m.lcipaddress+CHR(0)
    this.cport = m.lcport
    IF EMPTY(this.cproxyhost) .OR. ISNULL(this.cproxyhost)
       lcproxyname = .NULL.
       lcproxybypass = .NULL.
       liaccesstype = IIF(TYPE("m.lnFlag("+LTRIM(STR(2, 11))+")")="N", m.lnflag(2), 1)
       this.luseproxy = .F.
    ELSE
       lcproxyname = this.cproxyprotocol+"="+this.cproxyhost+":"+ALLTRIM(this.cproxyport)+CHR(0)
       lcproxybypass = this.cipaddress
       liaccesstype = 3
       this.luseproxy = .T.
    ENDIF
    this.ninet_handle = internetopen((this.cagent), m.liaccesstype, @m.lcproxyname, @m.lcproxybypass, m.lnflag)
    this.getextendederror()
    IF this.ninet_handle=0
       this.closeftpconnection()
       RETURN .F.
    ENDIF
    this.wininetsetoptions()
    fresult = this.openftpconnection(this.cstartupfolder)
    = IIF(this.lmultioperations, .T., this.closeftpconnection())
    this.ftpopen = m.fresult
    RETURN m.fresult
   ENDFUNC
**
   FUNCTION WinInetSetOptions
    LPARAMETERS laflags
    EXTERNAL ARRAY laflags
    LOCAL llretval, lii, luval
    LOCAL m.laflagsx(50)
    IF TYPE("m.laFlags")="N"
       = ACOPY(m.laflags, m.laflagsx)
    ELSE
       = ACOPY(this.aioptions, m.laflagsx)
    ENDIF
    FOR lii = 1 TO ALEN(m.laflagsx)
       luval = m.laflagsx(m.lii)
       IF TYPE("m.luVal")="N"
          llretval = internetsetoption(this.ninet_handle, m.lii, @m.luval, 4)
       ENDIF
    ENDFOR
    RETURN .T.
   ENDFUNC
**
   PROCEDURE CloseInternet
    this.ftpopen = .F.
    IF this.ninet_handle<>0
       this.closeftpconnection()
       internetclosehandle(this.ninet_handle)
       this.ninet_handle = 0
       this.ccurrentdir = ""
    ENDIF
   ENDPROC
**
   FUNCTION OpenFTPConnection
    LPARAMETERS lccurrentfolder
    LOCAL nhandle, lnconnect_handle
    IF this.nconnect_handle>0
       RETURN .T.
    ENDIF
    lnconnect_handle = internetconnect(this.ninet_handle, (this.cipaddress), VAL(this.cport), (this.cusername), (this.cpassword), 1, this.nflags, 0)
    this.getextendederror()
    IF lnconnect_handle=0
       RETURN .F.
    ENDIF
    IF PCOUNT()=0 .OR. EMPTY(m.lccurrentfolder)
       lccurrentfolder = SPACE(260)
       fresult = ftpgetcurrentdirectory(m.lnconnect_handle, @m.lccurrentfolder, 260)
       this.getextendederror()
    ELSE
       fresult = ftpsetcurrentdirectory(m.lnconnect_handle, @m.lccurrentfolder)
    ENDIF
    IF m.fresult=1
       this.ccurrentdir = LEFT(m.lccurrentfolder, AT(CHR(0), m.lccurrentfolder)-1)
       this.nconnect_handle = m.lnconnect_handle
       RETURN .T.
    ELSE
       this.getextendederror()
       RETURN .F.
    ENDIF
   ENDFUNC
**
   PROCEDURE CloseFTPConnection
    IF this.nconnect_handle<>0
       = this._ftpcommand("QUIT", 2, 0, .NULL.)
       = internetclosehandle(this.nconnect_handle)
    ENDIF
    this.nconnect_handle = 0
    RETURN
   ENDPROC
**
   FUNCTION SetCachingMethod
    LPARAMETERS ncachingtype
    IF m.ncachingtype=67108864 .OR. m.ncachingtype=1024 .OR. m.ncachingtype=16 .OR. m.ncachingtype=0000000016 .OR. m.ncachingtype=67108864 .OR. m.ncachingtype=0000000016 .OR. m.ncachingtype=2147483648  .OR. m.ncachingtype=2048
       this.ncachingtype = BITOR(this.ncachingtype, m.ncachingtype)
       RETURN .T.
    ENDIF
    RETURN .F.
   ENDFUNC
**
   FUNCTION GetCachingMethod
    RETURN this.ncachingtype
   ENDFUNC
**
   PROCEDURE ResetCachingMethod
    this.ncachingtype = 0
   ENDPROC
**
   FUNCTION GetFTPFile
    LPARAMETERS lcremotefile, lclocalfile, llfailifexists, lnflag
    LOCAL fresult, lnfail
    IF EMPTY(m.lcremotefile)
       this.setextendederror(-50001, "lcRemoteFile")
       RETURN .F.
    ENDIF
    IF EMPTY(m.lclocalfile)
       this.setextendederror(-50001, "lcLocalFile")
       RETURN .F.
    ENDIF
    lnflag = IIF(PCOUNT()<4, 0, m.lnflag)
    IF this.openftpconnection(this.ccurrentdir)
       lnfail = IIF(m.llfailifexists, 1, 0)
       lclocalfile = m.lclocalfile+CHR(0)
       lcremotefile = m.lcremotefile+CHR(0)
       = this.beforegetftpfile(@m.lcremotefile, @m.lclocalfile, m.llfailifexists, m.lnflag)
       fresult = ftpgetfile(this.nconnect_handle, @m.lcremotefile, @m.lclocalfile, m.lnfail, 128, BITOR(this.ncachingtype, m.lnflag), 0)
       = this.getextendederror()
       = this.aftergetftpfile(@m.lcremotefile, @m.lclocalfile, m.llfailifexists, m.lnflag, m.fresult)
       = IIF(this.lmultioperations, .T., this.closeftpconnection())
       RETURN m.fresult=1
    ENDIF
    RETURN .F.
   ENDFUNC
**
   PROCEDURE BeforeGetFTPFile
    LPARAMETERS lcremotefile, lclocalfile, llfailifexists, lnflag
**
** ReFox - este procedimiento es vacío **
**
   ENDPROC
**
   PROCEDURE AfterGetFTPFile
    LPARAMETERS lcremotefile, lclocalfile, llfailifexists, lnflag, fresult
**
** ReFox - este procedimiento es vacío **
**
   ENDPROC
**
   FUNCTION PutFTPFile
    LPARAMETERS lcremotefile, lclocalfile, lnflag
    LOCAL fresult
    IF EMPTY(m.lcremotefile)
       this.setextendederror(-50001, "lcRemoteFile")
       RETURN .F.
    ENDIF
    IF EMPTY(m.lclocalfile)
       this.setextendederror(-50001, "lcLocalFile")
       RETURN .F.
    ENDIF
    lnflag = IIF(PCOUNT()<3, 0, m.lnflag)
    IF this.openftpconnection(this.ccurrentdir)
       lcremotefile = m.lcremotefile+CHR(0)
       lclocalfile = m.lclocalfile+CHR(0)
       = this.beforeputftpfile(@m.lcremotefile, @m.lclocalfile, m.lnflag)
       fresult = ftpputfile(this.nconnect_handle, @m.lclocalfile, @m.lcremotefile, BITOR(this.ncachingtype, m.lnflag), 0)
       = this.getextendederror()
       = this.afterputftpfile(@m.lcremotefile, @m.lclocalfile, m.lnflag, m.fresult)
       = IIF(this.lmultioperations, .T., this.closeftpconnection())
       RETURN m.fresult=1
    ENDIF
    RETURN .F.
   ENDFUNC
**
   PROCEDURE BeforePutFTPFile
    LPARAMETERS lcremotefile, lclocalfile, lnflag
**
** ReFox - este procedimiento es vacío **
**
   ENDPROC
**
   PROCEDURE AfterPutFTPFile
    LPARAMETERS lcremotefile, lclocalfile, lnflag, fresult
**
** ReFox - este procedimiento es vacío **
**
   ENDPROC
**
   FUNCTION WriteFTPFile
    LPARAMETERS lcremotefile, lcdata, lidata, listart, liflags, lnflag
    LOCAL fresult, lihftp, lcbuffer, lidata, liwrite, lihfile, lcall, lcalias, lisele, llerr, lcerror
    LOCAL lafile(1)
    lihfile = 0
    lidata = IIF(PCOUNT()<3, 512, m.lidata)
    lidata = IIF(lidata<=0, 512, m.lidata)
    listart = IIF(PCOUNT()<4, 0, m.listart)
    liflags = IIF(PCOUNT()<5, 0, m.liflags)
    lnflag = IIF(PCOUNT()<6, 0, m.lnflag)
    lisele = SELECT()
    lcalias = SYS(2015)
    IF  .NOT. BITTEST(m.liflags, 0)
       IF ADIR(m.lafile, lcdata, "RSHA")=0
          this.setextendederror(-50002, m.lcdata)
          RETURN .F.
       ENDIF
       CREATE CURSOR (m.lcalias) (xx000 M NOCPTRANS)
       APPEND BLANK
       lcerror = ON("ERROR")
       ON ERROR llerr=.T.
       APPEND MEMO xx000 FROM (m.lcdata)
       IF llerr
          this.setextendederror(-50003, lcdata)
          RETURN .F.
       ENDIF
    ELSE
       IF TYPE("m.lcData")<>"C"
          this.setextendederror(11, "Function argument value, type, or count is invalid.")
          RETURN .F.
       ENDIF
    ENDIF
    IF this.openftpconnection(this.ccurrentdir)
       lcremotefile = m.lcremotefile+CHR(0)
       = this.beforewriteftpfile(@m.lcremotefile, @m.lcdata, m.lidata, m.listart, m.liflags, m.lnflag)
       IF m.listart>0
          = this._ftpcommand("REST "+LTRIM(STR(m.listart, 11)), m.lnflag, 0, .NULL.)
          fresult = IIF(this._ftpcommand("APPE "+m.lcremotefile, m.lnflag, 0, @m.lihftp), 1, 0)
       ENDIF
       STORE ftpopenfile(this.nconnect_handle, @m.lcremotefile, 1073741824, BITOR(this.ncachingtype, m.lnflag), 0) TO fresult, lihftp
       = this.getextendederror()
       IF m.fresult<>0
          DO CASE
             CASE  .NOT. BITTEST(m.liflags, 0) .AND. m.listart>=LEN(xx000) .OR. BITTEST(m.liflags, 0) .AND. LEN(m.lcdata)=0
                lcbuffer = ""
                lidata = LEN(m.lcbuffer)
                liwrite = 0
                fresult = internetwritefile(m.lihftp, @m.lcbuffer, m.lidata, @m.liwrite)
                = this.getextendederror()
                = this.atwriteftpfile(@m.lcremotefile, @m.lcdata, m.lidata, m.listart, m.liflags, m.lnflag, 0, m.liwrite, m.fresult)
             CASE  .NOT. BITTEST(m.liflags, 0)
                lii = m.listart+1
                DO WHILE m.lii<LEN(xx000)
                   lcbuffer = SUBSTR(xx000, m.lii, m.lidata)
                   lidata = LEN(m.lcbuffer)
                   liwrite = 0
                   fresult = internetwritefile(m.lihftp, @m.lcbuffer, m.lidata, @m.liwrite)
                   = this.getextendederror()
                   = this.atwriteftpfile(@m.lcremotefile, @m.lcdata, m.lidata, m.listart, m.liflags, m.lnflag, m.lii, m.liwrite, m.fresult)
                   IF m.fresult<>1
                      EXIT
                   ENDIF
                   lii = m.lii+m.lidata
                ENDDO
             CASE BITTEST(m.liflags, 0)
                lii = m.listart+1
                DO WHILE m.lii<LEN(m.lcdata)
                   lcbuffer = SUBSTR(m.lcdata, m.lii, m.lidata)
                   lidata = LEN(m.lcbuffer)
                   liwrite = 0
                   fresult = internetwritefile(m.lihftp, @m.lcbuffer, m.lidata, @m.liwrite)
                   = this.getextendederror()
                   = this.atwriteftpfile(@m.lcremotefile, @m.lcdata, m.lidata, m.listart, m.liflags, m.lnflag, m.lii, m.liwrite, m.fresult)
                   IF m.fresult<>1
                      EXIT
                   ENDIF
                   lii = m.lii+m.lidata
                ENDDO
          ENDCASE
          = IIF(m.listart>0, this._ftpcommand("NOOP", 2, 0, .NULL.), .T.)
          = internetclosehandle(m.lihftp)
       ENDIF
       IF USED(m.lcalias)
          USE IN (m.lcalias)
       ENDIF
       SELECT (m.lisele)
       = this.afterwriteftpfile(@m.lcremotefile, @m.lcdata, m.lidata, m.listart, m.liflags, m.lnflag, m.fresult)
       = IIF(this.lmultioperations, .T., this.closeftpconnection())
       RETURN m.fresult=1
    ENDIF
    RETURN .F.
   ENDFUNC
**
   PROCEDURE BeforeWriteFTPFile
    LPARAMETERS lcremotefile, lcdata, lidata, listart, liflags, lnflag
**
** ReFox - este procedimiento es vacío **
**
   ENDPROC
**
   PROCEDURE AfterWriteFTPFile
    LPARAMETERS lcremotefile, lcdata, lidata, listart, liflags, lnflag, fresult
**
** ReFox - este procedimiento es vacío **
**
   ENDPROC
**
   PROCEDURE AtWriteFTPFile
    LPARAMETERS lcremotefile, lcdata, lidata, listart, liflags, lnflag, lii, liwrite, fresult
**
** ReFox - este procedimiento es vacío **
**
   ENDPROC
**
   FUNCTION ReadFTPFile
    LPARAMETERS lcremotefile, lcdata, lidata, lirstart, lilstart, liflags, lnflag
    LOCAL fresult, lihftp, lcbuffer, lidata, liread, lihfile, llfast, lcall, llappend, lifsize, limodefile, llerr
    lihfile = 0
    lidata = IIF(PCOUNT()<3, 512, m.lidata)
    lidata = IIF(lidata<=0, 512, m.lidata)
    lirstart = IIF(PCOUNT()<4, 0, m.lirstart)
    lilstart = IIF(PCOUNT()<5, 0, m.lilstart)
    liflags = IIF(PCOUNT()<6, 00, m.liflags)
    lnflag = IIF(PCOUNT()<7, 0, m.lnflag)
    limodefile = IIF(TYPE("m.lnFlag("+LTRIM(STR(3, 11))+")")="N", m.lnflag(3), 0)
    IF  .NOT. BITTEST(m.liflags, 0)
       llfast = VAL(STRTRAN(SUBSTR(VERSION(), LEN("Visual FoxPro ")+1, 2), "0", ""))>6
       IF  .NOT. m.llfast
          lihfile = FOPEN(m.lcdata, 0)
          IF m.lihfile<=0
             IF m.limodefile=2
                this.setextendederror(-50002, m.lcdata)
                RETURN .F.
             ENDIF
             lihfile = FCREATE(m.lcdata, 0)
             DO CASE
                CASE m.limodefile=0 .OR. IIF(BITTEST(m.liflags, 1), m.lilstart, m.lirstart)=0
                CASE m.lihfile<=0
                   this.setextendederror(-50004, m.lcdata)
                   RETURN .F.
                CASE m.limodefile=1
                   IF BITTEST(m.liflags, 1)
                      = FCHSIZE(m.lihfile, m.lilstart+1)
                      = FSEEK(m.lihfile, m.lilstart, 0)
                   ELSE
                      = FCHSIZE(m.lihfile, m.lirstart+1)
                      = FSEEK(m.lihfile, m.lirstart, 0)
                   ENDIF
             ENDCASE
          ELSE
             IF m.lihfile<=0
                this.setextendederror(-50005, m.lcdata)
                RETURN .F.
             ENDIF
             = IIF(BITTEST(m.liflags, 1), FSEEK(m.lihfile, m.lilstart, 0), FSEEK(m.lihfile, m.lirstart, 0))
          ENDIF
       ELSE
          IF LEN(SYS(2000, m.lcdata))=0
             DO CASE
                CASE m.limodefile=0 .OR. IIF(BITTEST(m.liflags, 1), m.lilstart, m.lirstart)=0
                   lcall = ""
                CASE m.limodefile=2
                   this.setextendederror(-50002, m.lcdata)
                   RETURN .F.
                CASE m.limodefile=1
                   lcall = IIF(BITTEST(m.liflags, 1), REPLICATE(CHR(0), m.lilstart), REPLICATE(CHR(0), m.lirstart))
                OTHERWISE
             ENDCASE
          ELSE
             lcall = FILETOSTR(m.lcdata)
             lcall = IIF(BITTEST(m.liflags, 1), LEFT(m.lcall, m.lilstart), LEFT(m.lcall, m.lirstart))
          ENDIF
       ENDIF
    ELSE
       IF TYPE("m.lcData")<>"C"
          this.setextendederror(11, "Function argument value, type, or count is invalid.")
          RETURN .F.
       ENDIF
       lcdata = IIF(BITTEST(m.liflags, 1), LEFT(m.lcdata, m.lilstart), LEFT(m.lcdata, m.lirstart))
       llfast = .T.
    ENDIF
    IF this.openftpconnection(this.ccurrentdir)
       lcremotefile = m.lcremotefile+CHR(0)
       = this.beforereadftpfile(@m.lcremotefile, @m.lcdata, m.lidata, m.lirstart, m.lilstart, m.liflags, m.lnflag)
       IF m.lirstart>0
          = this._ftpcommand("REST "+LTRIM(STR(m.lirstart, 11)), 2, 0, .NULL.)
       ENDIF
       STORE ftpopenfile(this.nconnect_handle, @m.lcremotefile, 2147483648 , BITOR(this.ncachingtype, m.lnflag), 0) TO fresult, lihftp
       = this.getextendederror()
       IF m.fresult<>0
          lii = 0
          STORE 1 TO fresult, liread
          DO WHILE m.liread>0
             liread = 0
             lcbuffer = SPACE(m.lidata)
             fresult = internetreadfile(m.lihftp, @m.lcbuffer, m.lidata, @m.liread)
             = this.getextendederror()
             = this.atreadftpfile(@m.lcremotefile, @m.lcdata, m.lidata, m.lirstart, m.lilstart, m.liflags, m.lnflag, @m.lcbuffer, m.fresult)
             IF  .NOT. BITTEST(m.liflags, 0)
                IF m.llfast .AND. m.liread>0
                   IF LEN(m.lcall)+m.liread>15000000
                      IF STRTOFILE(m.lcall, m.lcdata, m.llappend)=0
                         this.setextendederror(-50006, "")
                         fresult = 0
                         EXIT
                      ENDIF
                      llappend = .T.
                      lcall = ""
                   ENDIF
                   lcall = m.lcall+LEFT(m.lcbuffer, m.liread)
                ELSE
                   IF m.liread>0
                      IF FWRITE(m.lihfile, LEFT(m.lcbuffer, m.liread), m.liread)=0
                         this.setextendederror(-50006, STR(FERROR()))
                         fresult = 0
                         EXIT
                      ENDIF
                   ENDIF
                ENDIF
             ELSE
                lcdata = m.lcdata+LEFT(m.lcbuffer, m.liread)
             ENDIF
             lii = m.lii+m.liread
          ENDDO
          IF  .NOT. BITTEST(m.liflags, 0)
             = IIF(m.llfast .AND. LEN(m.lcall)>0, STRTOFILE(m.lcall, m.lcdata, m.llappend), .T.)
             = IIF(m.lihfile>0 .AND.  .NOT. m.llfast, FCLOSE(m.lihfile), .T.)
          ENDIF
          = internetclosehandle(m.lihftp)
          = IIF(m.lirstart>0, this._ftpcommand("NOOP", 2, 0, .NULL.), .T.)
       ENDIF
       = this.afterreadftpfile(@m.lcremotefile, @m.lcdata, m.lidata, m.lirstart, m.lilstart, m.liflags, m.lnflag, m.fresult)
       = IIF(this.lmultioperations, .T., this.closeftpconnection())
       RETURN m.fresult=1
    ENDIF
    RETURN .F.
   ENDFUNC
**
   PROCEDURE BeforeReadFTPFile
    LPARAMETERS lcremotefile, lcdata, lidata, lirstart, lilstart, liflags, lnflag
**
** ReFox - este procedimiento es vacío **
**
   ENDPROC
**
   PROCEDURE AfterReadFTPFile
    LPARAMETERS lcremotefile, lcdata, lidata, lirstart, lilstart, liflags, lnflag, fresult
**
** ReFox - este procedimiento es vacío **
**
   ENDPROC
**
   PROCEDURE AtReadFTPFile
    LPARAMETERS lcremotefile, lcdata, lidata, lirstart, lilstart, liflags, lnflag, lcbuffer, fresult
**
** ReFox - este procedimiento es vacío **
**
   ENDPROC
**
   PROTECTED FUNCTION _FTPCommand
    LPARAMETERS lccommand, liflags, licontext, lihftp
    LOCAL fresult
    liflags = IIF(PCOUNT()<2, 2, m.liflags)
    licontext = IIF(PCOUNT()<3, 0, m.licontext)
    lihftp = IIF(ISNULL(m.lihftp), -1, 0)
    lccommand = m.lccommand+CHR(0)
    fresult = ftpcommand(this.nconnect_handle, IIF(m.lihftp=-1, 0, 1), m.liflags, @m.lccommand, m.licontext, @m.lihftp)
    = this.getextendederror()
    RETURN m.fresult=1
   ENDFUNC
**
   FUNCTION FTPCommand
    LPARAMETERS lccommand, liflags, licontext, lihftp
    LOCAL fresult
    liflags = IIF(PCOUNT()<2, 2, m.liflags)
    licontext = IIF(PCOUNT()<3, 0, m.licontext)
    lihftp = IIF(ISNULL(m.lihftp), -1, 0)
    lccommand = m.lccommand+CHR(0)
    = this.beforeftpcommand(@m.lccommand, m.liflags, m.licontext, m.lihftp)
    fresult = ftpcommand(this.nconnect_handle, IIF(m.lihftp=-1, 0, 1), m.liflags, @m.lccommand, m.licontext, @m.lihftp)
    = this.getextendederror()
    = this.afterftpcommand(@m.lccommand, m.liflags, m.licontext, m.lihftp, m.fresult)
    = IIF(this.lmultioperations, .T., this.closeftpconnection())
    RETURN m.fresult=1
   ENDFUNC
**
   PROCEDURE BeforeFTPCommand
    LPARAMETERS lccommand, liflags, licontext, lihftp
**
** ReFox - este procedimiento es vacío **
**
   ENDPROC
**
   PROCEDURE AfterFTPCommand
    LPARAMETERS lccommand, liflags, licontext, lihftp, fresult
**
** ReFox - este procedimiento es vacío **
**
   ENDPROC
**
   FUNCTION DeleteFTPFile
    LPARAMETERS lcremotefile
    LOCAL fresult
    IF this.openftpconnection(this.ccurrentdir)
       lcremotefile = m.lcremotefile+CHR(0)
       = this.beforedeleteftpfile(@m.lcremotefile)
       fresult = ftpdeletefile(this.nconnect_handle, @m.lcremotefile)
       this.getextendederror()
       = this.afterdeleteftpfile(@m.lcremotefile, m.fresult)
       = IIF(this.lmultioperations, .T., this.closeftpconnection())
       RETURN m.fresult=1
    ENDIF
    RETURN .F.
   ENDFUNC
**
   PROCEDURE BeforeDeleteFTPFile
    LPARAMETERS lcremotefile
**
** ReFox - este procedimiento es vacío **
**
   ENDPROC
**
   PROCEDURE AfterDeleteFTPFile
    LPARAMETERS lcremotefile, fresult
**
** ReFox - este procedimiento es vacío **
**
   ENDPROC
**
   FUNCTION RenameFTPFile
    LPARAMETERS lcoldfile, lcnewfile
    LOCAL fresult
    IF this.openftpconnection(this.ccurrentdir)
       lcoldfile = m.lcoldfile+CHR(0)
       lcnewfile = m.lcnewfile+CHR(0)
       = this.beforerenameftpfile(@m.lcoldfile, @m.lcnewfile)
       fresult = ftprenamefile(this.nconnect_handle, @m.lcoldfile, @m.lcnewfile)
       = this.getextendederror()
       = this.afterrenameftpfile(@m.lcoldfile, @m.lcnewfile, m.fresult)
       = IIF(this.lmultioperations, .T., this.closeftpconnection())
       RETURN m.fresult=1
    ENDIF
    RETURN .F.
   ENDFUNC
**
   PROCEDURE BeforeRenameFTPFile
    LPARAMETERS lcoldfile, lcnewfile
**
** ReFox - este procedimiento es vacío **
**
   ENDPROC
**
   PROCEDURE AfterRenameFTPFile
    LPARAMETERS lcoldfile, lcnewfile, fresult
**
** ReFox - este procedimiento es vacío **
**
   ENDPROC
**
   FUNCTION GetFileSize
    LPARAMETERS lcfile, lnsize
    LOCAL lcpom, llret
    IF this.openftpconnection(this.ccurrentdir)
       lcfile = ALLTRIM(m.lcfile)+CHR(0)
       = this.beforegetfilesize(@m.lcfile, m.lnsize)
       llret = this._ftpcommand("SIZE "+m.lcfile, 2, 0, .NULL.)
       IF llret
          lcpom = this.getextendederrormsg()
          lnsize = VAL(SUBSTR(m.lcpom, AT(" ", m.lcpom)+1))
       ENDIF
       = this.aftergetfilesize(@m.lcfile, m.lnsize, m.llret)
       = IIF(this.lmultioperations, .T., this.closeftpconnection())
       RETURN m.llret
    ENDIF
    RETURN .F.
   ENDFUNC
**
   PROCEDURE BeforeGetFileSize
    LPARAMETERS lcfile, lnsize
**
** ReFox - este procedimiento es vacío **
**
   ENDPROC
**
   PROCEDURE AfterGetFileSize
    LPARAMETERS lcfile, lnsize, llret
**
** ReFox - este procedimiento es vacío **
**
   ENDPROC
**
   FUNCTION CreateFTPDirectory
    LPARAMETERS lcnewdir
    LOCAL fresult
    IF this.openftpconnection(this.ccurrentdir)
       lcnewdir = m.lcnewdir+CHR(0)
       = this.beforecreateftpdirectory(@m.lcnewdir)
       fresult = ftpcreatedirectory(this.nconnect_handle, @m.lcnewdir)
       = this.getextendederror()
       = this.aftercreateftpdirectory(@m.lcnewdir, m.fresult)
       = IIF(this.lmultioperations, .T., this.closeftpconnection())
       RETURN m.fresult=1
    ENDIF
    RETURN .F.
   ENDFUNC
**
   PROCEDURE BeforeCreateFTPDirectory
    LPARAMETERS lcnewdir
**
** ReFox - este procedimiento es vacío **
**
   ENDPROC
**
   PROCEDURE AfterCreateFTPDirectory
    LPARAMETERS lcnewdir, fresult
**
** ReFox - este procedimiento es vacío **
**
   ENDPROC
**
   FUNCTION RemoveFTPDirectory
    LPARAMETERS lcdir
    LOCAL fresult
    IF this.openftpconnection(this.ccurrentdir)
       lcdir = m.lcdir+CHR(0)
       = this.beforeremoveftpdirectory(@m.lcdir)
       fresult = ftpremovedirectory(this.nconnect_handle, @m.lcdir)
       = this.getextendederror()
       = this.afterremoveftpdirectory(@m.lcdir, m.fresult)
       = IIF(this.lmultioperations, .T., this.closeftpconnection())
       RETURN m.fresult=1
    ENDIF
    RETURN .F.
   ENDFUNC
**
   PROCEDURE BeforeRemoveFTPDirectory
    LPARAMETERS lcdir
**
** ReFox - este procedimiento es vacío **
**
   ENDPROC
**
   PROCEDURE AfterRemoveFTPDirectory
    LPARAMETERS lcdir, fresult
**
** ReFox - este procedimiento es vacío **
**
   ENDPROC
**
   FUNCTION ChangeFTPDirectory
    LPARAMETERS lcnewdir
    LOCAL fresult, lctempdir, llresult
    IF this.openftpconnection(this.ccurrentdir)
       llresult = .F.
       lctempdir = SPACE(260)
       = this.beforechangeftpdirectory(@m.lcnewdir)
       fresult = ftpsetcurrentdirectory(this.nconnect_handle, @m.lcnewdir)
       = this.getextendederror()
       IF m.fresult=1
          fresult = ftpgetcurrentdirectory(this.nconnect_handle, @m.lctempdir, 260)
          = this.getextendederror()
          IF m.fresult=1
             this.ccurrentdir = LEFT(m.lctempdir, AT(CHR(0), m.lctempdir)-1)
             llresult = .T.
          ENDIF
       ENDIF
       = this.afterchangeftpdirectory(@m.lcnewdir, m.fresult)
       = IIF(this.lmultioperations, .T., this.closeftpconnection())
       RETURN m.llresult
    ENDIF
    RETURN .F.
   ENDFUNC
**
   PROCEDURE BeforeChangeFTPDirectory
    LPARAMETERS lcnewdir
**
** ReFox - este procedimiento es vacío **
**
   ENDPROC
**
   PROCEDURE AfterChangeFTPDirectory
    LPARAMETERS lcnewdir, fresult
**
** ReFox - este procedimiento es vacío **
**
   ENDPROC
**
   FUNCTION GetFTPDirectory
    LPARAMETERS lcdirectory
    LOCAL fresult, lctempdir
    IF this.openftpconnection(this.ccurrentdir)
       lctempdir = SPACE(260)
       = this.beforegetftpdirectory(@m.lcdirectory)
       fresult = ftpgetcurrentdirectory(this.nconnect_handle, @m.lctempdir, 260)
       = this.getextendederror()
       lcdirectory = LEFT(m.lctempdir, AT(CHR(0), m.lctempdir)-1)
       = this.aftergetftpdirectory(@m.lcdirectory, m.fresult)
       = IIF(this.lmultioperations, .T., this.closeftpconnection())
       RETURN m.fresult=1
    ENDIF
    RETURN .F.
   ENDFUNC
**
   PROCEDURE BeforeGetFTPDirectory
    LPARAMETERS lcdirectory
**
** ReFox - este procedimiento es vacío **
**
   ENDPROC
**
   PROCEDURE AfterGetFTPDirectory
    LPARAMETERS lcdirectory, fresult
**
** ReFox - este procedimiento es vacío **
**
   ENDPROC
**
   FUNCTION GetFTPDirectoryArray
    LPARAMETERS ladirectory, lcmask, lnflag, licount
    LOCAL cstruct, liresult, fresult, lffhandle, lii, lnsize
    IF this.openftpconnection(this.ccurrentdir)
       lcmask = m.lcmask+CHR(0)
       DIMENSION m.ladirectory[1, 7]
       ladirectory[1, 1] = .F.
       lnflag = BITOR(2147483648 , IIF(PCOUNT()<=3, 0, m.lnflag))
       licount = 0
       lcstruct = REPLICATE(CHR(0), 319)+CHR(0)
       = this.beforegetftpdirectoryarray(@m.ladirectory, @m.lcmask, m.lnflag)
       lffhandle = ftpfindfirstfile(this.nconnect_handle, @m.lcmask, @m.lcstruct, m.lnflag, 0)
       this.getextendederror()
       IF m.lffhandle=0 .AND. this.nresult_code<>18
          RETURN .F.
       ENDIF
       IF m.lffhandle=0 .AND. this.nresult_code=18
          RETURN .T.
       ENDIF
       = this.crackfile(m.lcstruct, @m.ladirectory)
       licount = 1
       llresult = 1
       DO WHILE this.nresult_code<>18 .AND. m.llresult<>0
          lcstruct = SPACE(319)
          liresult = internetfindnextfile(m.lffhandle, @m.lcstruct)
          = this.getextendederror()
          IF this.nresult_code<>18 .AND. m.llresult<>0
             licount = m.licount+1
             = this.crackfile(m.lcstruct, @m.ladirectory)
          ENDIF
       ENDDO
       = this.aftergetftpdirectoryarray(@m.ladirectory, @m.lcmask, m.lnflag, m.liresult)
       = internetclosehandle(m.lffhandle)
       FOR lii = 1 TO ALEN(m.ladirectory, 1)
          IF ATC(m.ladirectory(m.lii, 7), "D")=0 .AND. this.getfilesize(m.ladirectory(m.lii, 1), @m.lnsize)
             ladirectory(m.lii, 3) = m.lnsize
          ENDIF
       ENDFOR
       = IIF(this.lmultioperations, .T., this.closeftpconnection())
       RETURN .T.
    ELSE
       RETURN .F.
    ENDIF
   ENDFUNC
**
   PROCEDURE BeforeGetFTPDirectoryArray
    LPARAMETERS ladirectory, lcmask, lnflag
**
** ReFox - este procedimiento es vacío **
**
   ENDPROC
**
   PROCEDURE AfterGetFTPDirectoryArray
    LPARAMETERS ladirectory, lcmask, lnflag, liresult
**
** ReFox - este procedimiento es vacío **
**
   ENDPROC
**
   FUNCTION List
    LPARAMETERS ludata, lcmask, liflags, lnflag
    EXTERNAL ARRAY ludata
    LOCAL liresult, lihftp, lii, lcbuffer, lcdata, lidata, liend, licount, llret
    liflags = IIF(PCOUNT()<3, 0, m.liflags)
    lnflag = IIF(PCOUNT()<4, 1, m.lnflag)
    IF this.openftpconnection(this.ccurrentdir)
       IF BITTEST(m.liflags, 2)
          DIMENSION m.ludata[1, 1]
          ludata[1, 1] = .NULL.
       ENDIF
       lihftp = 0
       this.beforelist(@m.ludata, @m.lcmask, m.liflags, m.lnflag)
       liresult = IIF(this._ftpcommand("LIST "+m.lcmask, 1, 0, @m.lihftp), 1, 0)
       IF m.liresult<>0
          llret = .T.
          lii = 0
          lidata = 500
          STORE 1 TO fresult, liread
          lcdata = ""
          DO WHILE m.liread>0
             liread = 0
             lcbuffer = SPACE(m.lidata)
             liresult = internetreadfile(m.lihftp, @m.lcbuffer, m.lidata, @m.liread)
             = this.getextendederror()
             this.atlist(@m.ludata, @m.lcmask, m.liflags, m.lnflag, @m.lcbuffer, m.liresult)
             lcdata = m.lcdata+LEFT(m.lcbuffer, m.liread)
             lii = m.lii+m.liread
          ENDDO
          = internetclosehandle(m.lihftp)
          = this.afterlist(m.ludata, m.lcmask, m.liflags, m.lnflag, m.liresult)
          DO CASE
             CASE m.liresult=0
             CASE  .NOT. BITTEST(m.liflags, 0) .AND.  .NOT. BITTEST(m.liflags, 2)
                IF STRTOFILE(m.lcdata, m.ludata)=0
                   this.setextendederror(-50006, "")
                   llret = .F.
                ENDIF
             CASE BITTEST(m.liflags, 0)
                ludata = m.lcdata
             CASE BITTEST(m.liflags, 2)
                IF ISNULL(this.olistpe)
                   this.olistpe = CREATEOBJECT("_LIST_PARSER_ENGINE")
                ENDIF
                this.olistpe.oftp = this
                llret = this.olistpe.parse(@m.ludata, @m.lcdata)
                this.olistpe.oftp = .NULL.
          ENDCASE
       ENDIF
       = IIF(this.lmultioperations, .T., this.closeftpconnection())
       RETURN m.llret
    ELSE
       = IIF(this.lmultioperations, .T., this.closeftpconnection())
       RETURN .F.
    ENDIF
   ENDFUNC
**
   PROCEDURE BeforeList
    LPARAMETERS ludata, lcmask, liflags, lnflag
**
** ReFox - este procedimiento es vacío **
**
   ENDPROC
**
   PROCEDURE AfterList
    LPARAMETERS ludata, lcmask, liflags, lnflag, liresult
**
** ReFox - este procedimiento es vacío **
**
   ENDPROC
**
   PROCEDURE AtList
    LPARAMETERS ludata, lcmask, liflags, lnflag, lcbuffer, liresult
**
** ReFox - este procedimiento es vacío **
**
   ENDPROC
**
   FUNCTION NLST
    LPARAMETERS ludata, lcmask, liflags, lnflag
    EXTERNAL ARRAY ludata
    LOCAL liresult, lihftp, lii, lcbuffer, lcdata, lidata, liend, licount, llret
    liflags = IIF(PCOUNT()<3, 0, m.liflags)
    lnflag = IIF(PCOUNT()<4, 1, m.lnflag)
    IF this.openftpconnection(this.ccurrentdir)
       IF BITTEST(m.liflags, 2)
          DIMENSION m.ludata[1, 1]
          ludata[1, 1] = .NULL.
       ENDIF
       lihftp = 0
       this.beforenlst(@m.ludata, @m.lcmask, m.liflags, m.lnflag)
       liresult = IIF(this._ftpcommand("NLST "+m.lcmask, 1, 0, @m.lihftp), 1, 0)
       IF m.liresult<>0
          llret = .T.
          lii = 0
          lidata = 500
          STORE 1 TO fresult, liread
          lcdata = ""
          DO WHILE m.liread>0
             liread = 0
             lcbuffer = SPACE(m.lidata)
             liresult = internetreadfile(m.lihftp, @m.lcbuffer, m.lidata, @m.liread)
             = this.getextendederror()
             this.atnlst(@m.ludata, @m.lcmask, m.liflags, m.lnflag, @m.lcbuffer, m.liresult)
             lcdata = m.lcdata+LEFT(m.lcbuffer, m.liread)
             lii = m.lii+m.liread
          ENDDO
          = internetclosehandle(m.lihftp)
          DO CASE
             CASE m.liresult=0
             CASE  .NOT. BITTEST(m.liflags, 0) .AND.  .NOT. BITTEST(m.liflags, 2)
                IF STRTOFILE(m.lcdata, m.ludata)=0
                   this.setextendederror(-50006, "")
                   llret = .F.
                ENDIF
             CASE BITTEST(m.liflags, 0)
                ludata = m.lcdata
             CASE BITTEST(m.liflags, 2)
                IF AT("\015\012", m.lcdata)>0
                   lcdata = STRTRAN(m.lcdata, "\015\012", CHR(13)+CHR(10))
                ENDIF
                IF VAL(STRTRAN(SUBSTR(VERSION(), LEN("Visual FoxPro ")+1, 2), "0", ""))>=6
                   licount = ALINES(m.ludata, m.lcdata)
                ELSE
                   licount = OCCURS(CHR(13)+CHR(10), m.lcdata)
                   IF m.licount>0
                      DIMENSION ludata[m.licount, 1]
                      lii = 1
                      liend = AT(CHR(13)+CHR(10), m.lcdata, 1)
                      DO WHILE m.liend>0
                         ludata[m.lii, 1] = LEFT(m.lcdata, m.liend-1)
                         lcdata = SUBSTR(m.lcdata, m.liend+2)
                         liend = AT(CHR(13)+CHR(10), m.lcdata, 1)
                         lii = m.lii+1
                      ENDDO
                   ENDIF
                ENDIF
          ENDCASE
       ENDIF
       this.afternlst(m.ludata, m.lcmask, m.liflags, m.lnflag, m.liresult)
       = IIF(this.lmultioperations, .T., this.closeftpconnection())
       RETURN m.llret
    ELSE
       = IIF(this.lmultioperations, .T., this.closeftpconnection())
       RETURN .F.
    ENDIF
   ENDFUNC
**
   PROCEDURE BeforeNLST
    LPARAMETERS ludata, lcmask, liflags, lnflag
**
** ReFox - este procedimiento es vacío **
**
   ENDPROC
**
   PROCEDURE AfterNLST
    LPARAMETERS ludata, lcmask, liflags, lnflag, liresult
**
** ReFox - este procedimiento es vacío **
**
   ENDPROC
**
   PROCEDURE AtNLST
    LPARAMETERS ludata, lcmask, liflags, lnflag, lcbuffer, liresult
**
** ReFox - este procedimiento es vacío **
**
   ENDPROC
**
   PROCEDURE BeforeReadTree
    LPARAMETERS lcfolder, llchild, lcalias
**
** ReFox - este procedimiento es vacío **
**
   ENDPROC
**
   PROCEDURE AfterReadTree
    LPARAMETERS lcfolder, llchild, lcalias, llnext
**
** ReFox - este procedimiento es vacío **
**
   ENDPROC
**
   FUNCTION ReadTree
    LPARAMETERS lcfolder, llchild, lcalias
    LOCAL llnext, lirecno, lii, licount, lccurfolder
    LOCAL lafiles(1)
    IF this.openftpconnection()
       = this.beforereadtree(m.lcfolder, m.llchild, m.lcalias)
       IF USED(m.lcalias)
          USE IN (m.lcalias)
       ENDIF
       CREATE CURSOR (m.lcalias) (folder M, name M, altername M, size I, cd T, lat T, lwt T, attrib M)
       lccurfolder = this.ccurrentdir
       llnext = IIF( .NOT. EMPTY(m.lcfolder), this.changeftpdirectory(m.lcfolder), .T.)
       licount = 0
       llnext = m.llnext .AND. this.getftpdirectoryarray(@m.lafiles, "*.*", 0, @m.licount)
       IF m.licount>0
          FOR lii = 1 TO ALEN(m.lafiles, 1)
             INSERT INTO (m.lcalias) (folder, name, altername, size, cd, lat, lwt, attrib) VALUES (this.ccurrentdir, m.lafiles(m.lii, 1), m.lafiles(m.lii, 2), m.lafiles(m.lii, 3), m.lafiles(m.lii, 4), m.lafiles(m.lii, 5), m.lafiles(m.lii, 6), m.lafiles(m.lii, 7))
          ENDFOR
          SELECT (m.lcalias)
          GOTO TOP
          SCAN WHILE m.llnext .AND. m.llchild
             IF  .NOT. attrib=="D"
                LOOP
             ENDIF
             lirecno = RECNO()
             llnext = this.changeftpdirectory(folder+"/"+name)
             llnext = m.llnext .AND. this.getftpdirectoryarray(@m.lafiles, "*.*", 0, @m.licount)
             IF m.licount>0
                FOR lii = 1 TO ALEN(m.lafiles, 1)
                   INSERT INTO (m.lcalias) (folder, name, altername, size, cd, lat, lwt, attrib) VALUES (this.ccurrentdir, m.lafiles(m.lii, 1), m.lafiles(m.lii, 2), m.lafiles(m.lii, 3), m.lafiles(m.lii, 4), m.lafiles(m.lii, 5), m.lafiles(m.lii, 6), m.lafiles(m.lii, 7))
                ENDFOR
             ENDIF
             SELECT (m.lcalias)
             GOTO (m.lirecno)
          ENDSCAN
       ENDIF
       = this.changeftpdirectory(m.lccurfolder)
       = this.afterreadtree(m.lcfolder, m.llchild, m.lcalias, m.llnext)
       = IIF(this.lmultioperations, .T., this.closeftpconnection())
       RETURN m.llnext
    ENDIF
    RETURN .F.
   ENDFUNC
**
   PROTECTED PROCEDURE CrackFile
    LPARAMETERS lcstring, ladirectory
    LOCAL lcfilename, lcaltername, lnsizehigh, lnsizelow, lnfilesize, lcattributes, lnarraylen, lctimebuff, ldcreatedate, ldaccessdate, ldwritedate, lanewarray, lnresult, lcpom
    IF TYPE('m.laDirectory[1, 1]')='L'
       DIMENSION m.ladirectory[1, 7]
    ELSE
       DIMENSION m.ladirectory[ALEN(m.ladirectory, 1)+1, 7]
    ENDIF
    lnarraylen = ALEN(m.ladirectory, 1)
    lcfilename = SUBSTR(m.lcstring, 45, 260)
    lcaltername = RIGHT(m.lcstring, 14)
    lcfilename = LEFT(m.lcfilename, AT(CHR(0), m.lcfilename)-1)
    lcaltername = LEFT(m.lcaltername, AT(CHR(0), m.lcaltername)-1)
    lnsizehigh = (ASC(SUBSTR(m.lcstring, 29, 1))*1)+(ASC(SUBSTR(m.lcstring, 30, 1))*256)+(ASC(SUBSTR(m.lcstring, 31, 1))*65536)+(ASC(SUBSTR(m.lcstring, 32, 1))*16777216)
    lnsizelow = (ASC(SUBSTR(m.lcstring, 33, 1))*1)+(ASC(SUBSTR(m.lcstring, 34, 1))*256)+(ASC(SUBSTR(m.lcstring, 35, 1))*65536)+(ASC(SUBSTR(m.lcstring, 36, 1))*16777216)
    lnfilesize = (m.lnsizehigh*4294967295 )+m.lnsizelow
    lctimebuff = SUBSTR(m.lcstring, 5, 8)
    ldcreatedate = this.crackdate(m.lctimebuff)
    lctimebuff = SUBSTR(m.lcstring, 13, 8)
    ldaccessdate = this.crackdate(m.lctimebuff)
    lctimebuff = SUBSTR(m.lcstring, 21, 8)
    ldwritedate = this.crackdate(m.lctimebuff)
    lcattributes = this.crackattributes(LEFT(m.lcstring, 4))
    ladirectory[m.lnarraylen, 1] = ALLTRIM(m.lcfilename)
    ladirectory[m.lnarraylen, 2] = ALLTRIM(m.lcaltername)
    ladirectory[m.lnarraylen, 3] = m.lnfilesize
    ladirectory[m.lnarraylen, 4] = m.ldcreatedate
    ladirectory[m.lnarraylen, 5] = m.ldaccessdate
    ladirectory[m.lnarraylen, 6] = m.ldwritedate
    ladirectory[m.lnarraylen, 7] = m.lcattributes
    RETURN
   ENDPROC
**
   PROTECTED FUNCTION CrackDate
    LPARAMETERS lcoutbuffer
    LOCAL lcinbuffer, fresult, lcbuild, lnday, lnmonth, lnyear, lnhour, lnminute, lnsecond
    lcinbuffer = SPACE(16)
    fresult = filetimetosystemtime(@m.lcoutbuffer, @m.lcinbuffer)
    this.getextendederror()
    IF m.fresult=0
       RETURN {^1901-01-01 00:00:01}
    ENDIF
    lnyear = ASC(SUBSTR(m.lcinbuffer, 1, 1))+(ASC(SUBSTR(m.lcinbuffer, 2, 1))*256)
    lnmonth = ASC(SUBSTR(m.lcinbuffer, 3, 1))+(ASC(SUBSTR(m.lcinbuffer, 4, 1))*256)
    lnday = ASC(SUBSTR(m.lcinbuffer, 7, 1))+(ASC(SUBSTR(m.lcinbuffer, 8, 1))*256)
    lnhour = ASC(SUBSTR(m.lcinbuffer, 9, 1))+(ASC(SUBSTR(m.lcinbuffer, 10, 1))*256)
    lnminute = ASC(SUBSTR(m.lcinbuffer, 11, 1))+(ASC(SUBSTR(m.lcinbuffer, 12, 1))*256)
    lnsecond = ASC(SUBSTR(m.lcinbuffer, 13, 1))+(ASC(SUBSTR(m.lcinbuffer, 13, 1))*256)
    lcbuild = "^"+ALLTRIM(STR(m.lnyear))+'-'+ALLTRIM(STR(m.lnmonth))+'-'+ALLTRIM(STR(m.lnday))+' '+ALLTRIM(STR(m.lnhour))+':'+ALLTRIM(STR(m.lnminute))+':'+ALLTRIM(STR(m.lnsecond))
    RETURN CTOT(m.lcbuild)
   ENDFUNC
**
   PROTECTED FUNCTION CrackAttributes
    LPARAMETERS lcbuffer
    LOCAL lcattributes, lnvalue
    lcattributes = ''
    lnvalue = (ASC(SUBSTR(m.lcbuffer, 1, 1))*1)+(ASC(SUBSTR(m.lcbuffer, 2, 1))*256)+(ASC(SUBSTR(m.lcbuffer, 3, 1))*65536)+(ASC(SUBSTR(m.lcbuffer, 4, 1))*16777216)
    DO CASE
       CASE BITTEST(m.lnvalue, 0)
          lcattributes = m.lcattributes+'R'
       CASE BITTEST(m.lnvalue, 1)
          lcattributes = m.lcattributes+'H'
       CASE BITTEST(m.lnvalue, 2)
          lcattributes = m.lcattributes+'S'
       CASE BITTEST(m.lnvalue, 4)
          lcattributes = m.lcattributes+'D'
       CASE BITTEST(m.lnvalue, 5)
          lcattributes = m.lcattributes+'A'
       CASE BITTEST(m.lnvalue, 7)
          lcattributes = m.lcattributes+'N'
       CASE BITTEST(m.lnvalue, 8)
          lcattributes = m.lcattributes+'T'
       CASE BITTEST(m.lnvalue, 11)
          lcattributes = m.lcattributes+'C'
       CASE BITTEST(m.lnvalue, 12)
          lcattributes = m.lcattributes+'O'
    ENDCASE
    RETURN m.lcattributes
   ENDFUNC
**
   FUNCTION GetErrorCode
    LPARAMETERS llshowmessage
    LOCAL lcmessage
    IF m.llshowmessage
       lcmessage = "Error ("+ALLTRIM(STR(this.nresult_code))+")  -  "+this.geterrortext(this.nresult_code)
       IF  .NOT. EMPTY(this.cextended_message)
          lcmessage = m.lcmessage+CHR(13)+CHR(13)+"Extended Error Info - ("+ALLTRIM(STR(this.nextended_result))+") - "+this.cextended_message
       ENDIF
       = MESSAGEBOX(m.lcmessage, 48, "FTP Error Message")
    ENDIF
    RETURN this.nresult_code
   ENDFUNC
**
   FUNCTION GetExtendedErrorCode
    RETURN this.nextended_result
   ENDFUNC
**
   FUNCTION GetExtendedErrorMsg
    RETURN this.cextended_message
   ENDFUNC
**
   PROTECTED PROCEDURE GetExtendedError
    LOCAL lcmessage, lnerror, lcbuffer
    this.nresult_code = getlasterror()
    lnerror = 0
    lcbuffer = SPACE(260)
    = internetgetlastresponseinfo(m.lnerror, @m.lcbuffer, 260)
    this.nextended_result = m.lnerror
    this.cextended_message = LEFT(m.lcbuffer, AT(CHR(0), m.lcbuffer)-1)
    RETURN
   ENDPROC
**
   PROTECTED PROCEDURE SetExtendedError
    LPARAMETERS lierror, lcerror
    this.nresult_code = 0
    this.nextended_result = m.lierror
    this.cextended_message = m.lcerror
    RETURN
   ENDPROC
**
   FUNCTION GetErrorText
    LPARAMETERS lnerror
    LOCAL lcmessage
    DO CASE
       CASE lnerror=012001
          lcmessage = "ERROR_INTERNET_OUT_OF_HANDLES"
       CASE lnerror=012002
          lcmessage = "ERROR_INTERNET_TIMEOUT"
       CASE lnerror=012003
          lcmessage = "ERROR_INTERNET_EXTENDED_ERROR"
       CASE lnerror=012004
          lcmessage = "ERROR_INTERNET_INTERNAL_ERROR"
       CASE lnerror=012005
          lcmessage = "ERROR_INTERNET_INVALID_URL"
       CASE lnerror=012006
          lcmessage = "ERROR_INTERNET_UNRECOGNIZED_SCHEME"
       CASE lnerror=012007
          lcmessage = "ERROR_INTERNET_NAME_NOT_RESOLVED"
       CASE lnerror=012008
          lcmessage = "ERROR_INTERNET_PROTOCOL_NOT_FOUND"
       CASE lnerror=012009
          lcmessage = "ERROR_INTERNET_INVALID_OPTION"
       CASE lnerror=012010
          lcmessage = "ERROR_INTERNET_BAD_OPTION_LENGTH"
       CASE lnerror=012011
          lcmessage = "ERROR_INTERNET_OPTION_NOT_SETTABLE"
       CASE lnerror=012012
          lcmessage = "ERROR_INTERNET_SHUTDOWN"
       CASE lnerror=012013
          lcmessage = "ERROR_INTERNET_INCORRECT_USER_NAME"
       CASE lnerror=012014
          lcmessage = "ERROR_INTERNET_INCORRECT_PASSWORD"
       CASE lnerror=012015
          lcmessage = "ERROR_INTERNET_LOGIN_FAILURE"
       CASE lnerror=012016
          lcmessage = "ERROR_INTERNET_INVALID_OPERATION"
       CASE lnerror=012017
          lcmessage = "ERROR_INTERNET_OPERATION_CANCELLED"
       CASE lnerror=012018
          lcmessage = "ERROR_INTERNET_INCORRECT_HANDLE_TYPE"
       CASE lnerror=012019
          lcmessage = "ERROR_INTERNET_INCORRECT_HANDLE_STATE"
       CASE lnerror=012020
          lcmessage = "ERROR_INTERNET_NOT_PROXY_REQUEST"
       CASE lnerror=012021
          lcmessage = "ERROR_INTERNET_REGISTRY_VALUE_NOT_FOUND"
       CASE lnerror=012022
          lcmessage = "ERROR_INTERNET_BAD_REGISTRY_PARAMETER"
       CASE lnerror=012023
          lcmessage = "ERROR_INTERNET_NO_DIRECT_ACCESS"
       CASE lnerror=012024
          lcmessage = "ERROR_INTERNET_NO_CONTEXT"
       CASE lnerror=012025
          lcmessage = "ERROR_INTERNET_NO_CALLBACK"
       CASE lnerror=012026
          lcmessage = "ERROR_INTERNET_REQUEST_PENDING"
       CASE lnerror=012027
          lcmessage = "ERROR_INTERNET_INCORRECT_FORMAT"
       CASE lnerror=012028
          lcmessage = "ERROR_INTERNET_ITEM_NOT_FOUND"
       CASE lnerror=012029
          lcmessage = "ERROR_INTERNET_CANNOT_CONNECT"
       CASE lnerror=012030
          lcmessage = "ERROR_INTERNET_CONNECTION_ABORTED"
       CASE lnerror=012031
          lcmessage = "ERROR_INTERNET_CONNECTION_RESET"
       CASE lnerror=012032
          lcmessage = "ERROR_INTERNET_FORCE_RETRY"
       CASE lnerror=012033
          lcmessage = "ERROR_INTERNET_INVALID_PROXY_REQUEST"
       CASE lnerror=012034
          lcmessage = "ERROR_INTERNET_NEED_UI"
       CASE lnerror=012036
          lcmessage = "ERROR_INTERNET_HANDLE_EXISTS"
       CASE lnerror=012037
          lcmessage = "ERROR_INTERNET_SEC_CERT_DATE_INVALID"
       CASE lnerror=012038
          lcmessage = "ERROR_INTERNET_SEC_CERT_CN_INVALID"
       CASE lnerror=012039
          lcmessage = "ERROR_INTERNET_HTTP_TO_HTTPS_ON_REDIR"
       CASE lnerror=012040
          lcmessage = "ERROR_INTERNET_HTTPS_TO_HTTP_ON_REDIR"
       CASE lnerror=012041
          lcmessage = "ERROR_INTERNET_MIXED_SECURITY"
       CASE lnerror=012042
          lcmessage = "ERROR_INTERNET_CHG_POST_IS_NON_SECURE"
       CASE lnerror=012043
          lcmessage = "ERROR_INTERNET_POST_IS_NON_SECURE"
       CASE lnerror=012044
          lcmessage = "ERROR_INTERNET_CLIENT_AUTH_CERT_NEEDED"
       CASE lnerror=012045
          lcmessage = "ERROR_INTERNET_INVALID_CA"
       CASE lnerror=012046
          lcmessage = "ERROR_INTERNET_CLIENT_AUTH_NOT_SETUP"
       CASE lnerror=012047
          lcmessage = "ERROR_INTERNET_ASYNC_THREAD_FAILED"
       CASE lnerror=012048
          lcmessage = "ERROR_INTERNET_REDIRECT_SCHEME_CHANGE"
       CASE lnerror=012049
          lcmessage = "ERROR_INTERNET_DIALOG_PENDING"
       CASE lnerror=012050
          lcmessage = "ERROR_INTERNET_RETRY_DIALOG"
       CASE lnerror=012052
          lcmessage = "ERROR_INTERNET_HTTPS_HTTP_SUBMIT_REDIR"
       CASE lnerror=012053
          lcmessage = "ERROR_INTERNET_INSERT_CDROM"
       CASE lnerror=012110
          lcmessage = "FTP_TRANSFER_IN_PROGRESS"
       CASE lnerror=012111
          lcmessage = "FTP_DROPPED"
       CASE lnerror=012112
          lcmessage = "FTP_NO_PASSIVE_MODE"
       CASE lnerror=012157
          lcmessage = "ERROR_INTERNET_SECURITY_CHANNEL_ERROR"
       CASE lnerror=012158
          lcmessage = "ERROR_INTERNET_UNABLE_TO_CACHE_FILE"
       CASE lnerror=012159
          lcmessage = "ERROR_INTERNET_TCPIP_NOT_INSTALLED"
       CASE lnerror=012163
          lcmessage = "ERROR_INTERNET_DISCONNECTED"
       CASE lnerror=012164
          lcmessage = "ERROR_INTERNET_SERVER_UNREACHABLE"
       CASE lnerror=012165
          lcmessage = "ERROR_INTERNET_PROXY_SERVER_UNREACHABLE"
       CASE lnerror=012166
          lcmessage = "ERROR_INTERNET_BAD_AUTO_PROXY_SCRIPT"
       CASE lnerror=012167
          lcmessage = "ERROR_INTERNET_UNABLE_TO_DOWNLOAD_SCRIPT"
       CASE lnerror=012169
          lcmessage = "ERROR_INTERNET_SEC_INVALID_CERT"
       CASE lnerror=012170
          lcmessage = "ERROR_INTERNET_SEC_CERT_REVOKED"
       CASE lnerror=18
          lcmessage = "ERROR_NO_MORE_FILES"
       CASE lnerror=6
          lcmessage = "ERROR_INVALID_HANDLE"
       CASE lnerror=2
          lcmessage = "ERROR_FILE_NOT_FOUND"
       CASE lnerror=3
          lcmessage = "ERROR_PATH_NOT_FOUND"
       CASE lnerror=5
          lcmessage = "ERROR_ACCESS_DENIED"
       CASE lnerror=80
          lcmessage = "ERROR_FILE_EXISTS"
       CASE lnerror=87
          lcmessage = "ERROR_INVALID_PARAMETER"
       OTHERWISE
          lcmessage = "Unknown Error Message"
    ENDCASE
    RETURN m.lcmessage
   ENDFUNC
**
   PROTECTED FUNCTION GetSystemOption
    LPARAMETERS lioption
    DO CASE
       CASE m.lioption=1
          RETURN this.ccurrentdir
       CASE m.lioption=2
          RETURN this.ldll_loaded
       CASE m.lioption=3
          RETURN this.ninet_handle
       CASE m.lioption=4
          RETURN this.nconnect_handle
       CASE m.lioption=5
          RETURN this.cipaddress
       CASE m.lioption=6
          RETURN this.cusername
       CASE m.lioption=7
          RETURN this.cpassword
       CASE m.lioption=8
          RETURN this.cport
       CASE m.lioption=9
          RETURN this.luseproxy
       OTHERWISE
          RETURN .NULL.
    ENDCASE
   ENDFUNC
**
ENDDEFINE
**
DEFINE CLASS _LIST_PARSER AS CUSTOM
 oftp = .NULL.
 cmonths = ",jan,feb,mar,apr,may,jun,jul,aug,sep,oct,nov,dec,"
**
   FUNCTION FindDT
    LPARAMETERS lcdata
    LOCAL liat, liy, liz, lcpom, licnt, lcrow
    lcrow = LOWER(m.lcdata)
    licnt = OCCURS(",", this.cmonths)-1
    liat = 0
    FOR liy = 1 TO m.licnt
       liz = AT(",", this.cmonths, m.liy)
       lcmonth = SUBSTR(this.cmonths, m.liz+1, AT(",", this.cmonths, m.liy+1)-m.liz-1)
       FOR liz = 1 TO OCCURS(m.lcmonth, m.lcrow)
          liat = RAT(m.lcmonth, m.lcrow, m.liz)
          IF m.liat=0
             LOOP
          ENDIF
          lcpom = SUBSTR(m.lcdata, m.liat)
          IF (SUBSTR(m.lcpom, 4, 1)=" " .AND. SUBSTR(m.lcpom, 7, 1)=" " .AND. VAL(SUBSTR(m.lcpom, 5, 2))>0 .AND. VAL(SUBSTR(m.lcpom, 8, 2))>0 .AND. SUBSTR(m.lcpom, 10, 1)=":" .AND. VAL(SUBSTR(m.lcpom, 11, 2))>0) .OR. (SUBSTR(m.lcpom, 4, 1)=" " .AND. SUBSTR(m.lcpom, 7, 2)=" " .AND. VAL(SUBSTR(m.lcpom, 5, 2))>0 .AND. VAL(SUBSTR(m.lcpom, 9, 4))>0)
             EXIT
          ENDIF
          liat = 0
       ENDFOR
       IF m.liat>0
          EXIT
       ENDIF
    ENDFOR
    RETURN m.liat
   ENDFUNC
**
   FUNCTION FormatDT
    LPARAMETERS lcdt
    LOCAL limonth, lcret
    limonth = ATC(","+LEFT(m.lcdt, 3)+",", this.cmonths)
    limonth = OCCURS(",", LEFT(this.cmonths, m.limonth))
    IF AT(":", m.lcdt)>0
       lcret = EVALUATE("{^"+STR(YEAR(DATE()))+"-"+LTRIM(STR(m.limonth, 2))+"-"+LTRIM(SUBSTR(m.lcdt, 5, 2))+" "+SUBSTR(m.lcdt, 8, 5)+":00}")
    ELSE
       lcret = EVALUATE("{^"+SUBSTR(m.lcdt, 9, 4)+"-"+LTRIM(STR(m.limonth, 2))+"-"+LTRIM(SUBSTR(m.lcdt, 5, 2))+" 00:00:00}")
    ENDIF
    RETURN m.lcret
   ENDFUNC
**
ENDDEFINE
**
DEFINE CLASS _LIST_PARSER_1 AS _LIST_PARSER
**
   FUNCTION Parse
    LPARAMETERS lafiles, loengine
    EXTERNAL ARRAY lafiles
    LOCAL liend, lcdata, lii, liat, liy, liz, lcpom, lnfilesize
    DIMENSION m.lafiles(100, 7)
    liend = AT(CHR(13)+CHR(10), m.loengine.cdata, 1)
    lii = 0
    DO WHILE m.liend>0
       lcdata = LEFT(m.loengine.cdata, m.liend-1)
       loengine.cdata = SUBSTR(m.loengine.cdata, m.liend+2)
       liend = AT(CHR(13)+CHR(10), m.loengine.cdata, 1)
       lii = m.lii+1
       IF m.lii>ALEN(m.lafiles, 1)
          DIMENSION m.lafiles(m.lii+100, 7)
       ENDIF
       lafiles(m.lii, 1) = SUBSTR(m.lcdata, 1, 10)
       lafiles(m.lii, 2) = VAL(SUBSTR(m.lcdata, 12, 3))
       liat = this.finddt(@m.lcdata)
       IF m.liat=0
          this.oftp.setextendederror(-50007, m.lcrow)
          RETURN .F.
       ENDIF
       lafiles(m.lii, 6) = this.formatdt(SUBSTR(m.lcdata, m.liat, 12))
       lafiles(m.lii, 7) = SUBSTR(m.lcdata, m.liat+13)
       lcpom = ALLTRIM(SUBSTR(m.lcdata, 16, m.liat-16-1))
       liy = AT(" ", m.lcpom)
       liz = RAT(" ", m.lcpom)
       lafiles(m.lii, 3) = ALLTRIM(LEFT(m.lcpom, m.liy-1))
       lafiles(m.lii, 4) = ALLTRIM(SUBSTR(m.lcpom, m.liy+1, m.liz-1-m.liy))
       IF this.oftp.getfilesize(m.lafiles(m.lii, 7), @m.lnfilesize)
          lafiles(m.lii, 5) = m.lnfilesize
       ENDIF
    ENDDO
    IF m.lii>0 .AND. m.lii<>ALEN(m.lafiles, 1)
       DIMENSION lafiles(m.lii, 7)
    ENDIF
    RETURN .T.
   ENDFUNC
**
ENDDEFINE
**
DEFINE CLASS _LIST_PARSER_2 AS _LIST_PARSER_1
ENDDEFINE
**
DEFINE CLASS _LIST_PARSER_3 AS _LIST_PARSER_1
ENDDEFINE
**
DEFINE CLASS _LIST_PARSER_5 AS _LIST_PARSER_1
ENDDEFINE
**
DEFINE CLASS _LIST_PARSER_4 AS _LIST_PARSER
**
   FUNCTION Parse
    LPARAMETERS lafiles, loengine
    EXTERNAL ARRAY lafiles
    LOCAL liend, lcdata, lii, liat, liy, liz, lcpom, lnfilesize
    DIMENSION m.lafiles(100, 7)
    liend = AT(CHR(13)+CHR(10), m.loengine.cdata, 1)
    lii = 0
    DO WHILE m.liend>0
       lcdata = LEFT(m.loengine.cdata, m.liend-1)
       loengine.cdata = SUBSTR(m.loengine.cdata, m.liend+2)
       liend = AT(CHR(13)+CHR(10), m.loengine.cdata, 1)
       lii = m.lii+1
       IF m.lii>ALEN(m.lafiles, 1)
          DIMENSION m.lafiles(m.lii+100, 7)
       ENDIF
       lafiles(m.lii, 1) = LEFT(m.lcdata, 1)+SUBSTR(m.lcdata, 4, 8)
       lafiles(m.lii, 2) = 0
       liat = this.finddt(@m.lcdata)
       IF m.liat=0
          this.oftp.setextendederror(-50007, m.lcrow)
          RETURN .F.
       ENDIF
       lafiles(m.lii, 6) = this.formatdt(SUBSTR(m.lcdata, m.liat, 12))
       lafiles(m.lii, 7) = RTRIM(SUBSTR(m.lcdata, m.liat+13))
       lcpom = ALLTRIM(SUBSTR(m.lcdata, 14, m.liat-14-1))
       liy = AT(" ", m.lcpom)
       lafiles(m.lii, 3) = ALLTRIM(LEFT(m.lcpom, m.liy-1))
       lafiles(m.lii, 4) = ""
       IF this.oftp.getfilesize(m.lafiles(m.lii, 7), @m.lnfilesize)
          lafiles(m.lii, 5) = m.lnfilesize
       ENDIF
    ENDDO
    IF m.lii>0 .AND. m.lii<>ALEN(m.lafiles, 1)
       DIMENSION m.lafiles(m.lii, 7)
    ENDIF
    RETURN .T.
   ENDFUNC
**
ENDDEFINE
**
DEFINE CLASS _LIST_PARSER_0 AS _LIST_PARSER
**
   FUNCTION Parse
    LPARAMETERS lafiles, loengine
    EXTERNAL ARRAY lafiles
    LOCAL liend, lcdata, lii, liy, liz, lcpom, lnfilesize, liat, liate
    DIMENSION m.lafiles(100, 7)
    liend = AT("\015\012", m.loengine.cdata, 1)
    lii = 0
    DO WHILE m.liend>0
       lcdata = SUBSTR(m.loengine.cdata, 2, m.liend-2)
       loengine.cdata = SUBSTR(m.loengine.cdata, m.liend+2)
       liend = AT("\015\012", m.loengine.cdata, 1)
       lii = m.lii+1
       IF m.lii>ALEN(m.lafiles, 1)
          DIMENSION m.lafiles(m.lii+100, 7)
       ENDIF
       liy = OCCURS(",", m.lcdata)+1
       FOR liz = 1 TO m.liy
          liat = IIF(m.liz=1, 1, AT(",", m.lcdata, m.liz-1)+1)
          liate = IIF(m.liz<m.liy-1, AT(",", m.lcdata, m.liz)-1, LEN(m.lcdata))
          lcpom = SUBSTR(m.lcdata, m.liat, m.liate-m.liat)
          DO CASE
             CASE LEFT(m.lcpom, 1)='i'
             CASE LEFT(m.lcpom, 1)='m'
                lafiles(m.lii, 6) = {^1970-01-01 00:00:00}+VAL(SUBSTR(m.lcpom, 2))
             CASE LEFT(m.lcpom, 1)='r' .OR. LEFT(m.lcpom, 1)='/'
                lafiles(m.lii, 1) = m.lcpom
             CASE LEFT(m.lcpom, 1)='s'
                lafiles(m.lii, 5) = VAL(ALLTRIM(SUBSTR(m.lcpom, 2)))
             OTHERWISE
                lafiles(m.lii, 7) = STRTRAN(m.lcpom, "\t", "")
          ENDCASE
       ENDFOR
       lafiles(m.lii, 2) = 0
    ENDDO
    IF m.lii>0 .AND. m.lii<>ALEN(m.lafiles, 1)
       DIMENSION m.lafiles(m.lii, 7)
    ENDIF
    RETURN .T.
   ENDFUNC
**
ENDDEFINE
**
DEFINE CLASS _LIST_PARSER_ENGINE AS _LIST_PARSER
 cdata = ""
**
   FUNCTION Parse
    LPARAMETERS lafiles, lcdata
    LOCAL liformat, loparser, llret
    this.cdata = m.lcdata
    lcdata = ""
    liformat = this.checkformat()
    IF  .NOT. PEMSTATUS(this, "PL"+STR(m.liformat, 1), 5)
       this.addobject("PL"+STR(m.liformat, 1), "_LIST_PARSER_"+STR(m.liformat, 1))
    ENDIF
    loparser = EVALUATE("This.PL"+STR(m.liformat, 1))
    loparser.oftp = this.oftp
    llret = loparser.parse(@m.lafiles, this)
    loparser.oftp = .NULL.
    RETURN m.llret
   ENDFUNC
**
   FUNCTION CheckFormat
    IF AT("\015\012", this.cdata)>0 .OR. LEFT(this.cdata, 1)="+"
       RETURN 0
    ENDIF
    IF SUBSTR(this.cdata, 2, 1)=" "
       RETURN 4
    ENDIF
    RETURN 1
   ENDFUNC
**
ENDDEFINE
**
