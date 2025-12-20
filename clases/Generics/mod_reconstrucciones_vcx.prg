************************************************************
OBJETO: cls_abm_estados
************************************************************
*** PROPIEDADES ***
DoCreate = .T.
Caption = "ABM Estados de reconstrucciones"
cnombretabla = rcn_estado
listctrlsource = id_estado,descripcio
listwidthcols = 100,300
titulos_cabeceras = Número,Descripción
pk_fieldname = id_estado
Name = "cls_abm_estados"
HERRAMIENTAS.CMDNUEVO.Name = "CMDNUEVO"
HERRAMIENTAS.CMDEDITAR.Name = "CMDEDITAR"
HERRAMIENTAS.CMDELIMINAR.Name = "CMDELIMINAR"
HERRAMIENTAS.CMDCERRAR.Name = "CMDCERRAR"
HERRAMIENTAS.CMDGRABAR.Name = "CMDGRABAR"
HERRAMIENTAS.CMDCANCELAR.Name = "CMDCANCELAR"
HERRAMIENTAS.CMDEXCEL.Name = "CMDEXCEL"
HERRAMIENTAS.Name = "HERRAMIENTAS"
PGF.ErasePage = .T.
PGF.PAGE1.GRDDATOS.COLUMN1.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN1.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN1.Name = "COLUMN1"
PGF.PAGE1.GRDDATOS.COLUMN2.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN2.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN2.Name = "COLUMN2"
PGF.PAGE1.GRDDATOS.COLUMN3.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN3.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN3.Name = "COLUMN3"
PGF.PAGE1.GRDDATOS.COLUMN4.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN4.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN4.Name = "COLUMN4"
PGF.PAGE1.GRDDATOS.COLUMN5.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN5.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN5.Name = "COLUMN5"
PGF.PAGE1.GRDDATOS.COLUMN6.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN6.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN6.Name = "COLUMN6"
PGF.PAGE1.GRDDATOS.COLUMN7.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN7.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN7.Name = "COLUMN7"
PGF.PAGE1.GRDDATOS.COLUMN8.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN8.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN8.Name = "COLUMN8"
PGF.PAGE1.GRDDATOS.COLUMN9.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN9.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN9.Name = "COLUMN9"
PGF.PAGE1.GRDDATOS.COLUMN10.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN10.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN10.Name = "COLUMN10"
PGF.PAGE1.GRDDATOS.COLUMN11.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN11.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN11.Name = "COLUMN11"
PGF.PAGE1.GRDDATOS.COLUMN12.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN12.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN12.Name = "COLUMN12"
PGF.PAGE1.GRDDATOS.COLUMN13.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN13.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN13.Name = "COLUMN13"
PGF.PAGE1.GRDDATOS.COLUMN14.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN14.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN14.Name = "COLUMN14"
PGF.PAGE1.GRDDATOS.COLUMN15.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN15.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN15.Name = "COLUMN15"
PGF.PAGE1.GRDDATOS.COLUMN16.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN16.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN16.Name = "COLUMN16"
PGF.PAGE1.GRDDATOS.COLUMN17.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN17.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN17.Name = "COLUMN17"
PGF.PAGE1.GRDDATOS.COLUMN18.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN18.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN18.Name = "COLUMN18"
PGF.PAGE1.GRDDATOS.COLUMN19.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN19.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN19.Name = "COLUMN19"
PGF.PAGE1.GRDDATOS.COLUMN20.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN20.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN20.Name = "COLUMN20"
PGF.PAGE1.GRDDATOS.Name = "GRDDATOS"
PGF.PAGE1.Name = "PAGE1"
PGF.PAGE2.CNT_FIELDS.Name = "CNT_FIELDS"
PGF.PAGE2.Name = "PAGE2"
PGF.Name = "PGF"

*** METODOS ***


************************************************************
OBJETO: CLSETIQUETA1
************************************************************
*** PROPIEDADES ***
Caption = "Descripción:"
Left = 29
Top = 26
Name = "CLSETIQUETA1"

*** METODOS ***


************************************************************
OBJETO: txtDescripcion
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 123
MaxLength = 30
Top = 23
Width = 542
cfieldname = descripcio
ischaracter = .T.
Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: cls_abm_estados
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_abm_tiporemito
************************************************************
*** PROPIEDADES ***
DoCreate = .T.
Caption = "ABM Tipos de remitos"
cnombretabla = rcn_tiporto
pk_fieldname = id_tiporto
titulos_cabeceras = Nombre,Descripción
listctrlsource = id_tiporto,descripcio
listwidthcols = 100,300
Name = "cls_abm_tiporemito"
HERRAMIENTAS.CMDNUEVO.Name = "CMDNUEVO"
HERRAMIENTAS.CMDEDITAR.Name = "CMDEDITAR"
HERRAMIENTAS.CMDELIMINAR.Name = "CMDELIMINAR"
HERRAMIENTAS.CMDCERRAR.Name = "CMDCERRAR"
HERRAMIENTAS.CMDGRABAR.Name = "CMDGRABAR"
HERRAMIENTAS.CMDCANCELAR.Name = "CMDCANCELAR"
HERRAMIENTAS.CMDEXCEL.Name = "CMDEXCEL"
HERRAMIENTAS.Name = "HERRAMIENTAS"
PGF.ErasePage = .T.
PGF.PAGE1.GRDDATOS.COLUMN1.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN1.Text1.Name = "Text1"
PGF.PAGE1.GRDDATOS.COLUMN1.Name = "COLUMN1"
PGF.PAGE1.GRDDATOS.COLUMN2.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN2.Text1.Name = "Text1"
PGF.PAGE1.GRDDATOS.COLUMN2.Name = "COLUMN2"
PGF.PAGE1.GRDDATOS.COLUMN3.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN3.Text1.Name = "Text1"
PGF.PAGE1.GRDDATOS.COLUMN3.Name = "COLUMN3"
PGF.PAGE1.GRDDATOS.COLUMN4.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN4.Text1.Name = "Text1"
PGF.PAGE1.GRDDATOS.COLUMN4.Name = "COLUMN4"
PGF.PAGE1.GRDDATOS.COLUMN5.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN5.Text1.Name = "Text1"
PGF.PAGE1.GRDDATOS.COLUMN5.Name = "COLUMN5"
PGF.PAGE1.GRDDATOS.COLUMN6.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN6.Text1.Name = "Text1"
PGF.PAGE1.GRDDATOS.COLUMN6.Name = "COLUMN6"
PGF.PAGE1.GRDDATOS.COLUMN7.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN7.Text1.Name = "Text1"
PGF.PAGE1.GRDDATOS.COLUMN7.Name = "COLUMN7"
PGF.PAGE1.GRDDATOS.COLUMN8.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN8.Text1.Name = "Text1"
PGF.PAGE1.GRDDATOS.COLUMN8.Name = "COLUMN8"
PGF.PAGE1.GRDDATOS.COLUMN9.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN9.Text1.Name = "Text1"
PGF.PAGE1.GRDDATOS.COLUMN9.Name = "COLUMN9"
PGF.PAGE1.GRDDATOS.COLUMN10.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN10.Text1.Name = "Text1"
PGF.PAGE1.GRDDATOS.COLUMN10.Name = "COLUMN10"
PGF.PAGE1.GRDDATOS.COLUMN11.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN11.Text1.Name = "Text1"
PGF.PAGE1.GRDDATOS.COLUMN11.Name = "COLUMN11"
PGF.PAGE1.GRDDATOS.COLUMN12.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN12.Text1.Name = "Text1"
PGF.PAGE1.GRDDATOS.COLUMN12.Name = "COLUMN12"
PGF.PAGE1.GRDDATOS.COLUMN13.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN13.Text1.Name = "Text1"
PGF.PAGE1.GRDDATOS.COLUMN13.Name = "COLUMN13"
PGF.PAGE1.GRDDATOS.COLUMN14.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN14.Text1.Name = "Text1"
PGF.PAGE1.GRDDATOS.COLUMN14.Name = "COLUMN14"
PGF.PAGE1.GRDDATOS.COLUMN15.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN15.Text1.Name = "Text1"
PGF.PAGE1.GRDDATOS.COLUMN15.Name = "COLUMN15"
PGF.PAGE1.GRDDATOS.COLUMN16.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN16.Text1.Name = "Text1"
PGF.PAGE1.GRDDATOS.COLUMN16.Name = "COLUMN16"
PGF.PAGE1.GRDDATOS.COLUMN17.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN17.Text1.Name = "Text1"
PGF.PAGE1.GRDDATOS.COLUMN17.Name = "COLUMN17"
PGF.PAGE1.GRDDATOS.COLUMN18.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN18.Text1.Name = "Text1"
PGF.PAGE1.GRDDATOS.COLUMN18.Name = "COLUMN18"
PGF.PAGE1.GRDDATOS.COLUMN19.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN19.Text1.Name = "Text1"
PGF.PAGE1.GRDDATOS.COLUMN19.Name = "COLUMN19"
PGF.PAGE1.GRDDATOS.COLUMN20.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN20.Text1.Name = "Text1"
PGF.PAGE1.GRDDATOS.COLUMN20.Name = "COLUMN20"
PGF.PAGE1.GRDDATOS.Name = "GRDDATOS"
PGF.PAGE1.Name = "PAGE1"
PGF.PAGE2.CNT_FIELDS.Name = "CNT_FIELDS"
PGF.PAGE2.Name = "PAGE2"
PGF.Name = "PGF"

*** METODOS ***


************************************************************
OBJETO: cls_abm_tiporemito
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_abm_estcra
************************************************************
*** PROPIEDADES ***
DoCreate = .T.
cnombretabla = rcn_estcra
listctrlsource = id_estcra,descripcio
pk_fieldname = id_estcra
titulos_cabeceras = Número,Descripción
listwidthcols = 100,300
Name = "cls_abm_estcra"
HERRAMIENTAS.CMDNUEVO.Name = "CMDNUEVO"
HERRAMIENTAS.CMDEDITAR.Name = "CMDEDITAR"
HERRAMIENTAS.CMDELIMINAR.Name = "CMDELIMINAR"
HERRAMIENTAS.CMDCERRAR.Name = "CMDCERRAR"
HERRAMIENTAS.CMDGRABAR.Name = "CMDGRABAR"
HERRAMIENTAS.CMDCANCELAR.Name = "CMDCANCELAR"
HERRAMIENTAS.CMDEXCEL.Name = "CMDEXCEL"
HERRAMIENTAS.Name = "HERRAMIENTAS"
PGF.ErasePage = .T.
PGF.PAGE1.GRDDATOS.COLUMN1.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN1.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN1.Name = "COLUMN1"
PGF.PAGE1.GRDDATOS.COLUMN2.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN2.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN2.Name = "COLUMN2"
PGF.PAGE1.GRDDATOS.COLUMN3.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN3.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN3.Name = "COLUMN3"
PGF.PAGE1.GRDDATOS.COLUMN4.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN4.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN4.Name = "COLUMN4"
PGF.PAGE1.GRDDATOS.COLUMN5.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN5.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN5.Name = "COLUMN5"
PGF.PAGE1.GRDDATOS.COLUMN6.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN6.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN6.Name = "COLUMN6"
PGF.PAGE1.GRDDATOS.COLUMN7.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN7.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN7.Name = "COLUMN7"
PGF.PAGE1.GRDDATOS.COLUMN8.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN8.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN8.Name = "COLUMN8"
PGF.PAGE1.GRDDATOS.COLUMN9.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN9.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN9.Name = "COLUMN9"
PGF.PAGE1.GRDDATOS.COLUMN10.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN10.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN10.Name = "COLUMN10"
PGF.PAGE1.GRDDATOS.COLUMN11.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN11.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN11.Name = "COLUMN11"
PGF.PAGE1.GRDDATOS.COLUMN12.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN12.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN12.Name = "COLUMN12"
PGF.PAGE1.GRDDATOS.COLUMN13.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN13.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN13.Name = "COLUMN13"
PGF.PAGE1.GRDDATOS.COLUMN14.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN14.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN14.Name = "COLUMN14"
PGF.PAGE1.GRDDATOS.COLUMN15.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN15.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN15.Name = "COLUMN15"
PGF.PAGE1.GRDDATOS.COLUMN16.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN16.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN16.Name = "COLUMN16"
PGF.PAGE1.GRDDATOS.COLUMN17.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN17.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN17.Name = "COLUMN17"
PGF.PAGE1.GRDDATOS.COLUMN18.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN18.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN18.Name = "COLUMN18"
PGF.PAGE1.GRDDATOS.COLUMN19.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN19.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN19.Name = "COLUMN19"
PGF.PAGE1.GRDDATOS.COLUMN20.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN20.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN20.Name = "COLUMN20"
PGF.PAGE1.GRDDATOS.Name = "GRDDATOS"
PGF.PAGE1.Name = "PAGE1"
PGF.PAGE2.CNT_FIELDS.Name = "CNT_FIELDS"
PGF.PAGE2.Name = "PAGE2"
PGF.Name = "PGF"

*** METODOS ***


************************************************************
OBJETO: cls_abm_estcra
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_abm_operadores
************************************************************
*** PROPIEDADES ***
DoCreate = .T.
pk_fieldname = id_operad
titulos_cabeceras = Número,Operador
listctrlsource = id_operad,apelnom
listwidthcols = 100,300
cnombretabla = rcn_operad
Name = "cls_abm_operadores"
HERRAMIENTAS.CMDNUEVO.Name = "CMDNUEVO"
HERRAMIENTAS.CMDEDITAR.Name = "CMDEDITAR"
HERRAMIENTAS.CMDELIMINAR.Name = "CMDELIMINAR"
HERRAMIENTAS.CMDCERRAR.Name = "CMDCERRAR"
HERRAMIENTAS.CMDGRABAR.Name = "CMDGRABAR"
HERRAMIENTAS.CMDCANCELAR.Name = "CMDCANCELAR"
HERRAMIENTAS.CMDEXCEL.Name = "CMDEXCEL"
HERRAMIENTAS.Name = "HERRAMIENTAS"
PGF.ErasePage = .T.
PGF.PAGE1.GRDDATOS.COLUMN1.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN1.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN1.Name = "COLUMN1"
PGF.PAGE1.GRDDATOS.COLUMN2.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN2.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN2.Name = "COLUMN2"
PGF.PAGE1.GRDDATOS.COLUMN3.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN3.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN3.Name = "COLUMN3"
PGF.PAGE1.GRDDATOS.COLUMN4.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN4.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN4.Name = "COLUMN4"
PGF.PAGE1.GRDDATOS.COLUMN5.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN5.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN5.Name = "COLUMN5"
PGF.PAGE1.GRDDATOS.COLUMN6.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN6.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN6.Name = "COLUMN6"
PGF.PAGE1.GRDDATOS.COLUMN7.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN7.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN7.Name = "COLUMN7"
PGF.PAGE1.GRDDATOS.COLUMN8.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN8.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN8.Name = "COLUMN8"
PGF.PAGE1.GRDDATOS.COLUMN9.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN9.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN9.Name = "COLUMN9"
PGF.PAGE1.GRDDATOS.COLUMN10.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN10.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN10.Name = "COLUMN10"
PGF.PAGE1.GRDDATOS.COLUMN11.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN11.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN11.Name = "COLUMN11"
PGF.PAGE1.GRDDATOS.COLUMN12.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN12.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN12.Name = "COLUMN12"
PGF.PAGE1.GRDDATOS.COLUMN13.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN13.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN13.Name = "COLUMN13"
PGF.PAGE1.GRDDATOS.COLUMN14.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN14.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN14.Name = "COLUMN14"
PGF.PAGE1.GRDDATOS.COLUMN15.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN15.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN15.Name = "COLUMN15"
PGF.PAGE1.GRDDATOS.COLUMN16.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN16.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN16.Name = "COLUMN16"
PGF.PAGE1.GRDDATOS.COLUMN17.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN17.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN17.Name = "COLUMN17"
PGF.PAGE1.GRDDATOS.COLUMN18.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN18.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN18.Name = "COLUMN18"
PGF.PAGE1.GRDDATOS.COLUMN19.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN19.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN19.Name = "COLUMN19"
PGF.PAGE1.GRDDATOS.COLUMN20.HEADER1.Name = "HEADER1"
PGF.PAGE1.GRDDATOS.COLUMN20.TEXT1.Name = "TEXT1"
PGF.PAGE1.GRDDATOS.COLUMN20.Name = "COLUMN20"
PGF.PAGE1.GRDDATOS.Name = "GRDDATOS"
PGF.PAGE1.Name = "PAGE1"
PGF.PAGE2.CNT_FIELDS.Name = "CNT_FIELDS"
PGF.PAGE2.Name = "PAGE2"
PGF.Name = "PGF"

*** METODOS ***


************************************************************
OBJETO: cls_abm_operadores
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_remitos_data
************************************************************
*** PROPIEDADES ***
id_tiporto = 0
id_cliente = 0
numero = 
destino = 
observaciones = 
usuario = 
host = 
active_connection = 
mensaje_error = 
Name = "cls_remitos_data"

*** METODOS ***
PROCEDURE crear_cursor
***************************************************************************
* Permite crear el cursor para los datos del remito.
* Fecha: 19/05/2023
***************************************************************************
CREATE CURSOR cur_items (;
	id int not null,;
	idmarca int not null,;
	descripcio varchar(100),;
	medida numeric(20, 2),;
	nro_serie varchar(20),;
	trabajo varchar(100),;
	usuario varchar(5),;
	host varchar(50))
ENDPROC
PROCEDURE agregar_item
************************************************************
* Permite agregar un nuevo ítem al remito.
* fecha: 19/05/2023
************************************************************
LPARAMETERS tnIdMarca, tcDescripcio, tnMedida, tcNroSerie, tcTrabajo

LOCAL lnId

lnId = 0

SELECT cur_items
IF RECCOUNT("cur_items") > 0 THEN
	lnId = cur_items.id
ENDIF

* Asigno el usuario y el host donde se está generando el
* remito para guardar en los ítems.
this.usuario = ALLTRIM(gcCodUsu)
this.host = ALLTRIM(SYS(0))

APPEND BLANK
REPLACE cur_items.id WITH lnId + 1
REPLACE cur_items.idmarca WITH tnIdMarca ADDITIVE
REPLACE cur_items.descripcio WITH ALLTRIM(tcDescripcio) ADDITIVE
REPLACE cur_items.medida WITH tnMedida ADDITIVE
REPLACE cur_items.nro_serie WITH ALLTRIM(tcNroSerie) ADDITIVE
REPLACE cur_items.trabajo WITH ALLTRIM(tcTrabajo) ADDITIVE
REPLACE cur_items.usuario WITH ALLTRIM(this.usuario) ADDITIVE
REPLACE cur_items.host WITH ALLTRIM(this.host) ADDITIVE
ENDPROC
PROCEDURE eliminar_item
********************************************************
* Permite eliminar un ítem.
* Fecha: 19/05/2023
********************************************************
SELECT cur_items
DELETE
ENDPROC
PROCEDURE limpiar_items
*********************************************************
* Permite limpiar el cursor de ítems.
* Fecha: 19/05/2023
*********************************************************
SELECT cur_items
ZAP
ENDPROC
PROCEDURE grabar
***************************************************************
* Graba un remito en la base de datos
* Fecha: 19/05/2023
***************************************************************
LOCAL loRes
LOCAL loCmd
LOCAL lcSql

loRes = CREATEOBJECT("odbc_result")
loCmd = CREATEOBJECT("odbc_command")

this.limpiar_tabla_temporal_items()

* Establezco las conexiones.
loRes.ActiveConnection = this.active_connection
loCmd.ActiveConnection = this.active_connection

* Paso todos los ítems a la tabla temporal.
SELECT cur_items
GO TOP
DO WHILE !EOF("cur_items")
	TEXT TO loCmd.CommandText NOSHOW
		CALL rcn_insertar_items_temporal (
			?xiditem,
			?xidmarca,
			?xmedida,
			?xnro_serie,
			?xtrabajo,
			?xusuario,
			?xhost
		)
	ENDTEXT
	loCmd.AddParameter("xiditem", ALLTRIM(STR(cur_items.id)), .f., .f.)
	loCmd.AddParameter("xidmarca", ALLTRIM(STR(cur_items.idmarca)), .f., .f.)
	loCmd.AddParameter("xmedida", ALLTRIM(STR(cur_items.medida, 20, 2)), .f., .f.)
	loCmd.AddParameter("xnro_serie", ALLTRIM(cur_items.nro_serie), .t., .f.)
	loCmd.AddParameter("xtrabajo", ALLTRIM(cur_items.trabajo), .t., .f.)
	loCmd.AddParameter("xusuario", ALLTRIM(cur_items.usuario), .t., .f.)
	loCmd.AddParameter("xhost", ALLTRIM(cur_items.host), .t., .f.)

	IF !loCmd.Execute() THEN
		this.mensaje_error = loCmd.ErrorMessage
		RETURN .F.
	ENDIF

	SELECT cur_items
	SKIP
ENDDO

* Grabo el remito
TEXT TO lcSql NOSHOW
	CALL rcn_agregar_remito (
		?xidtiporto,
		?xidCliente,
		?xnumero,
		?xdestino,
		?xobservaciones,
		?xusuario,
		?xhostname)
ENDTEXT
lcSql = loRes.AddParameter(lcSql, "xidtiporto", ALLTRIM(STR(this.id_tiporto)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "xidCliente", ALLTRIM(STR(this.id_cliente)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "xnumero", ALLTRIM(this.numero), .t., .f.)
lcSql = loRes.AddParameter(lcSql, "xdestino", ALLTRIM(this.destino), .t., .f.)
lcSql = loRes.AddParameter(lcSql, "xobservaciones", ALLTRIM(this.observaciones), .t., .f.)
lcSql = loRes.AddParameter(lcSql, "xusuario", ALLTRIM(this.usuario), .t., .f.)
lcSql = loRes.AddParameter(lcSql, "xhostname", ALLTRIM(this.host), .t., .f.)

loRes.cursor_name = "cur_result"
loRes.OpenQuery(lcSql)

SELECT cur_result
IF ALLTRIM(cur_result.result) == "BD_ERROR" THEN
	this.mensaje_error = cur_result.mensaje
	RETURN .F.
ENDIF

loRes.Close_Query()

RETURN .T.
ENDPROC
PROCEDURE limpiar_tabla_temporal_items
******************************************************************************
* Limpia la tabla temporal donde se guardan los ítems del remito a generar
* Fecha: 19/05/2023
******************************************************************************
LOCAL loCmd

loCmd = CREATEOBJECT("odbc_command")
TEXT TO loCmd.CommandText NOSHOW
	CALL rcn_limpiar_temporal_items (
		?xusuario,
		?xhost)
ENDTEXT

loCmd.AddParameter("xusuario", ALLTRIM(this.usuario), .t., .f.)
loCmd.AddParameter("xhost", ALLTRIM(this.host), .t., .f.)

loCmd.ActiveConnection = this.active_connection
IF !loCmd.Execute() THEN
	this.mensaje_error = loCmd.Error_Message
	RETURN .F.
ENDIF

RETURN .T.
ENDPROC


************************************************************
OBJETO: cls_abm_motivo_rechazo
************************************************************
*** PROPIEDADES ***
DoCreate = .T.
Caption = "Motivos de rechazo"
cnombretabla = rcn_motrec
listctrlsource = id_motrec,descripcio
listwidthcols = 70,300
titulos_cabeceras = #,Descripción
pk_fieldname = id_motrec
Name = "cls_abm_motivo_rechazo"
HERRAMIENTAS.CMDNUEVO.Name = "CMDNUEVO"
HERRAMIENTAS.CMDEDITAR.Name = "CMDEDITAR"
HERRAMIENTAS.CMDELIMINAR.Name = "CMDELIMINAR"
HERRAMIENTAS.CMDCERRAR.Name = "CMDCERRAR"
HERRAMIENTAS.CMDGRABAR.Name = "CMDGRABAR"
HERRAMIENTAS.CMDCANCELAR.Name = "CMDCANCELAR"
HERRAMIENTAS.CMDEXCEL.Name = "CMDEXCEL"
HERRAMIENTAS.Name = "HERRAMIENTAS"
PGF.ErasePage = .T.
PGF.PAGE1.GRDDATOS.COLUMN1.Header1.Name = "Header1"
PGF.PAGE1.GRDDATOS.COLUMN1.Text1.Name = "Text1"
PGF.PAGE1.GRDDATOS.COLUMN1.Name = "COLUMN1"
PGF.PAGE1.GRDDATOS.COLUMN2.Header1.Name = "Header1"
PGF.PAGE1.GRDDATOS.COLUMN2.Text1.Name = "Text1"
PGF.PAGE1.GRDDATOS.COLUMN2.Name = "COLUMN2"
PGF.PAGE1.GRDDATOS.COLUMN3.Header1.Name = "Header1"
PGF.PAGE1.GRDDATOS.COLUMN3.Text1.Name = "Text1"
PGF.PAGE1.GRDDATOS.COLUMN3.Name = "COLUMN3"
PGF.PAGE1.GRDDATOS.COLUMN4.Header1.Name = "Header1"
PGF.PAGE1.GRDDATOS.COLUMN4.Text1.Name = "Text1"
PGF.PAGE1.GRDDATOS.COLUMN4.Name = "COLUMN4"
PGF.PAGE1.GRDDATOS.COLUMN5.Header1.Name = "Header1"
PGF.PAGE1.GRDDATOS.COLUMN5.Text1.Name = "Text1"
PGF.PAGE1.GRDDATOS.COLUMN5.Name = "COLUMN5"
PGF.PAGE1.GRDDATOS.COLUMN6.Header1.Name = "Header1"
PGF.PAGE1.GRDDATOS.COLUMN6.Text1.Name = "Text1"
PGF.PAGE1.GRDDATOS.COLUMN6.Name = "COLUMN6"
PGF.PAGE1.GRDDATOS.COLUMN7.Header1.Name = "Header1"
PGF.PAGE1.GRDDATOS.COLUMN7.Text1.Name = "Text1"
PGF.PAGE1.GRDDATOS.COLUMN7.Name = "COLUMN7"
PGF.PAGE1.GRDDATOS.COLUMN8.Header1.Name = "Header1"
PGF.PAGE1.GRDDATOS.COLUMN8.Text1.Name = "Text1"
PGF.PAGE1.GRDDATOS.COLUMN8.Name = "COLUMN8"
PGF.PAGE1.GRDDATOS.COLUMN9.Header1.Name = "Header1"
PGF.PAGE1.GRDDATOS.COLUMN9.Text1.Name = "Text1"
PGF.PAGE1.GRDDATOS.COLUMN9.Name = "COLUMN9"
PGF.PAGE1.GRDDATOS.COLUMN10.Header1.Name = "Header1"
PGF.PAGE1.GRDDATOS.COLUMN10.Text1.Name = "Text1"
PGF.PAGE1.GRDDATOS.COLUMN10.Name = "COLUMN10"
PGF.PAGE1.GRDDATOS.COLUMN11.Header1.Name = "Header1"
PGF.PAGE1.GRDDATOS.COLUMN11.Text1.Name = "Text1"
PGF.PAGE1.GRDDATOS.COLUMN11.Name = "COLUMN11"
PGF.PAGE1.GRDDATOS.COLUMN12.Header1.Name = "Header1"
PGF.PAGE1.GRDDATOS.COLUMN12.Text1.Name = "Text1"
PGF.PAGE1.GRDDATOS.COLUMN12.Name = "COLUMN12"
PGF.PAGE1.GRDDATOS.COLUMN13.Header1.Name = "Header1"
PGF.PAGE1.GRDDATOS.COLUMN13.Text1.Name = "Text1"
PGF.PAGE1.GRDDATOS.COLUMN13.Name = "COLUMN13"
PGF.PAGE1.GRDDATOS.COLUMN14.Header1.Name = "Header1"
PGF.PAGE1.GRDDATOS.COLUMN14.Text1.Name = "Text1"
PGF.PAGE1.GRDDATOS.COLUMN14.Name = "COLUMN14"
PGF.PAGE1.GRDDATOS.COLUMN15.Header1.Name = "Header1"
PGF.PAGE1.GRDDATOS.COLUMN15.Text1.Name = "Text1"
PGF.PAGE1.GRDDATOS.COLUMN15.Name = "COLUMN15"
PGF.PAGE1.GRDDATOS.COLUMN16.Header1.Name = "Header1"
PGF.PAGE1.GRDDATOS.COLUMN16.Text1.Name = "Text1"
PGF.PAGE1.GRDDATOS.COLUMN16.Name = "COLUMN16"
PGF.PAGE1.GRDDATOS.COLUMN17.Header1.Name = "Header1"
PGF.PAGE1.GRDDATOS.COLUMN17.Text1.Name = "Text1"
PGF.PAGE1.GRDDATOS.COLUMN17.Name = "COLUMN17"
PGF.PAGE1.GRDDATOS.COLUMN18.Header1.Name = "Header1"
PGF.PAGE1.GRDDATOS.COLUMN18.Text1.Name = "Text1"
PGF.PAGE1.GRDDATOS.COLUMN18.Name = "COLUMN18"
PGF.PAGE1.GRDDATOS.COLUMN19.Header1.Name = "Header1"
PGF.PAGE1.GRDDATOS.COLUMN19.Text1.Name = "Text1"
PGF.PAGE1.GRDDATOS.COLUMN19.Name = "COLUMN19"
PGF.PAGE1.GRDDATOS.COLUMN20.Header1.Name = "Header1"
PGF.PAGE1.GRDDATOS.COLUMN20.Text1.Name = "Text1"
PGF.PAGE1.GRDDATOS.COLUMN20.Name = "COLUMN20"
PGF.PAGE1.GRDDATOS.Name = "GRDDATOS"
PGF.PAGE1.Name = "PAGE1"
PGF.PAGE2.CNT_FIELDS.Name = "CNT_FIELDS"
PGF.PAGE2.Name = "PAGE2"
PGF.Name = "PGF"

*** METODOS ***


************************************************************
OBJETO: CLSETIQUETA1
************************************************************
*** PROPIEDADES ***
Caption = "Descripción:"
Left = 36
Top = 39
Name = "CLSETIQUETA1"

*** METODOS ***


************************************************************
OBJETO: txtDescripcion
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 132
MaxLength = 30
Top = 37
Width = 384
cfieldname = descripcio
msgerror = Debe ingresar la descripción
ischaracter = .T.
Name = "txtDescripcion"

*** METODOS ***


************************************************************
OBJETO: cls_abm_motivo_rechazo
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_form_remitos
************************************************************
*** PROPIEDADES ***
BorderStyle = 2
Height = 574
Width = 946
DoCreate = .T.
Caption = "Ingreso de remitos de entrada"
Name = "cls_form_remitos"
CONTENIDO.Top = -1
CONTENIDO.Left = -1
CONTENIDO.Width = 947
CONTENIDO.Height = 575
CONTENIDO.Name = "CONTENIDO"

*** METODOS ***
PROCEDURE validar_cabecera
**********************************************
* Valido los datos de cabecera
**********************************************

IF Thisform.contenido.cnt_cabecera.sel_cliente.valcpoid = 0 THEN
	MESSAGEBOX("Debe seleccionar un cliente", 0+48, Thisform.Caption)
	Thisform.contenido.cnt_cabecera.sel_cliente.txtCodigo.SetFocus()
	RETURN .f.
ENDIF

IF ALLTRIM(Thisform.contenido.cnt_cabecera.txt_numero_remito.Value) == "" THEN
	MESSAGEBOX("Debe ingresar el número de remito", 0+48, Thisform.Caption)
	Thisform.contenido.cnt_cabecera.txt_numero_remito.SetFocus()
	RETURN .f.
ENDIF

IF ALLTRIM(Thisform.contenido.cnt_cabecera.txt_destino.Value) == "" THEN
	MESSAGEBOX("Debe ingresar el chofer de destino", 0+48, Thisform.Caption)
	RETURN .f.
ENDIF

RETURN .t.
ENDPROC
PROCEDURE cambiar_estado
********************************************************
* Cambia el estado de los controles de usuario
********************************************************
LPARAMETERS tlEstado

Thisform.contenido.cnt_cabecera.sel_cliente.txtCodigo.Enabled = tlEstado
Thisform.contenido.cnt_cabecera.txt_numero_remito.Enabled = tlEstado
Thisform.contenido.cnt_cabecera.txt_destino.Enabled = tlEstado
Thisform.contenido.cnt_cabecera.btnAceptar.Enabled = tlEstado
Thisform.contenido.cnt_cabecera.btnCancelar.Enabled = tlEstado

Thisform.contenido.cnt_items.sel_marcas.txtCodigo.Enabled = !tlEstado
Thisform.contenido.cnt_items.txt_nro_serie.Enabled = !tlEstado
Thisform.contenido.cnt_items.txt_medida.Enabled = !tlEstado
Thisform.contenido.cnt_items.txt_trabajo_a_realizar.Enabled = !tlEstado
Thisform.contenido.cnt_items.btnAgregar.Enabled = !tlEstado
Thisform.contenido.cnt_items.btnEliminar.Enabled = !tlEstado
Thisform.contenido.btn_grabar.Enabled = !tlEstado

ENDPROC
PROCEDURE blancquear_cabecera
This.contenido.cnt_cabecera.sel_cliente.blanquear()
This.contenido.cnt_cabecera.txt_numero_remito.Value = ""
This.contenido.cnt_cabecera.txt_destino.Value = ""

ENDPROC
PROCEDURE blanquear_detalle
thisform.contenido.cnt_items.sel_marcas.blanquear()
thisform.contenido.cnt_items.txt_medida.value = 0.00
thisform.contenido.cnt_items.txt_nro_serie.Value = ""
thisform.contenido.cnt_items.txt_trabajo_a_realizar.Value = ""
ENDPROC
PROCEDURE Init
Thisform.oRemitosDal.crear_cursor()

* Configuro la grilla
Thisform.contenido.cnt_items.grd_items.permitir_busqueda = .f.
Thisform.contenido.cnt_items.grd_items.permitir_ordenamiento = .f.

SELECT cur_items
Thisform.contenido.cnt_items.grd_items.alias_name = "cur_items"
Thisform.contenido.cnt_items.grd_items.RecordSource = "cur_items"
Thisform.contenido.cnt_items.grd_items.list_controlsource = "id,descripcio,medida,nro_serie,trabajo"
Thisform.contenido.cnt_items.grd_items.lista_ancho_cols = "70,200,100,200,200"
Thisform.contenido.cnt_items.grd_items.titulos_cabeceras = "Renglón,Descripción,Medida,N° Serie,Trabajo"
Thisform.contenido.cnt_items.grd_items.generar_grid()

* Establezco estado inicial de los controles
Thisform.cambiar_estado(.t.)

* Configuración de conexión a la base de datos
Thisform.oRemitosDal.active_connection = goConn.ActiveConnection
ENDPROC
PROCEDURE validardetalle
***********************************************
* Valido que se ingresen los datos solicitado
* en el detalle
***********************************************

IF thisform.contenido.cnt_items.sel_marcas.valcpoid = 0 THEN
	MESSAGEBOX("Debe ingresar la marca", 0+48, thisform.Caption)
	thisform.contenido.cnt_items.sel_marcas.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

IF Thisform.contenido.cnt_items.txt_medida.Value = 0 THEN
	MESSAGEBOX("Debe ingresar la medida", 0+48, Thisform.Caption)
	Thisform.contenido.cnt_items.txt_medida.SetFocus()
	RETURN .F.
ENDIF

IF ALLTRIM(Thisform.contenido.cnt_items.txt_nro_serie.Value) == "" THEN
	MESSAGEBOX("Debe ingresar el número de serie", 0+48, Thisform.Caption)
	Thisform.contenido.cnt_items.txt_nro_serie.SetFocus()
	RETURN .F.
ENDIF

IF ALLTRIM(Thisform.contenido.cnt_items.txt_trabajo_a_realizar.Value) == "" THEN
	MESSAGEBOX("Debe ingresar el trabajo a realizar", 0+48, Thisform.Caption)
	Thisform.contenido.cnt_items.txt_trabajo_a_realizar.SetFocus()
	RETURN .F.
ENDIF

RETURN .T.


ENDPROC
PROCEDURE validarcampos
***********************************************
* Valido que haya al menos un ítem cargado
* antes de grabar el remito.
***********************************************

LOCAL loRes
LOCAL lcSql

SELECT cur_items
IF RECCOUNT("cur_items") = 0 THEN
	MESSAGEBOX("No hay cargado ningún ítem", 0+48, Thisform.Caption)
	RETURN .F.
ENDIF

loRes = CREATEOBJECT("odbc_result")
TEXT TO lcsql NOSHOW
	SELECT COUNT(*) AS 'cantidad' FROM rcn_tiporto WHERE fecBaja IS NULL
ENDTEXT
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"
loRes.OpenQuery(lcSql)

SELECT cur_x
IF RECCOUNT("cur_x") = 0 THEN
	MESSAGEBOX("No hay tipo de remitos cargados", 0+48, Thisform.Caption)
	loRes.Close_Query()
	RETURN .F.
ENDIF

loRes.Close_Query()

RETURN .T.
ENDPROC


************************************************************
OBJETO: oRemitosDal
************************************************************
*** PROPIEDADES ***
Top = 516
Left = 312
Height = 17
Width = 24
Name = "oRemitosDal"

*** METODOS ***


************************************************************
OBJETO: cnt_cabecera
************************************************************
*** PROPIEDADES ***
Top = 13
Left = 9
Width = 929
Height = 120
Name = "cnt_cabecera"

*** METODOS ***


************************************************************
OBJETO: sel_cliente
************************************************************
*** PROPIEDADES ***
Top = 21
Left = 97
nombre_tabla = clientes
nombre_campo_codigo = idCliente
nombre_campo_desc = razSoc
pkfield = idCliente
title_cols = idCliente,razSoc
anchos_cols = 70,400
autocompletar_ceros = .F.
esnumerico = .T.
Name = "sel_cliente"
TXTCODIGO.Name = "TXTCODIGO"
TXTDESCRIPCION.Name = "TXTDESCRIPCION"

*** METODOS ***


************************************************************
OBJETO: CLSETIQUETA1
************************************************************
*** PROPIEDADES ***
Caption = "Cliente:"
Height = 15
Left = 28
Top = 26
Width = 69
Name = "CLSETIQUETA1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Número Remito:"
Height = 15
Left = 583
Top = 26
Width = 95
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: txt_numero_remito
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 682
MaxLength = 8
Top = 24
Width = 204
ischaracter = .T.
autocompleta = .T.
Name = "txt_numero_remito"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Destino:"
Height = 15
Left = 28
Top = 48
Width = 69
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: txt_destino
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 100
Top = 46
Width = 786
Name = "txt_destino"

*** METODOS ***


************************************************************
OBJETO: btnAceptar
************************************************************
*** PROPIEDADES ***
Top = 72
Left = 793
Name = "btnAceptar"

*** METODOS ***
PROCEDURE Click
IF Thisform.validar_cabecera() THEN
	Thisform.cambiar_estado(.f.)
ENDIF
ENDPROC


************************************************************
OBJETO: btnCancelar
************************************************************
*** PROPIEDADES ***
Top = 72
Left = 843
Height = 44
Width = 45
Name = "btnCancelar"

*** METODOS ***
PROCEDURE Click
thisform.blancquear_cabecera()
Thisform.cambiar_estado(.t.)
thisform.contenido.cnt_cabecera.sel_cliente.txtCodigo.SetFocus()
ENDPROC


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Datos del remito"
Height = 15
Left = 11
Top = 5
Width = 173
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: cnt_items
************************************************************
*** PROPIEDADES ***
Top = 136
Left = 10
Width = 927
Height = 305
Name = "cnt_items"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Detalles"
Height = 15
Left = 11
Top = 4
Width = 64
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Marca:"
Height = 15
Left = 30
Top = 23
Width = 64
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: sel_marcas
************************************************************
*** PROPIEDADES ***
Top = 16
Left = 97
nombre_tabla = marcas
nombre_campo_codigo = idmarca
nombre_campo_desc = descripcio
pkfield = idmarca
Name = "sel_marcas"
TXTCODIGO.Name = "TXTCODIGO"
TXTDESCRIPCION.Name = "TXTDESCRIPCION"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Medida:"
Height = 15
Left = 585
Top = 22
Width = 64
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: txt_medida
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 650
Top = 18
Width = 151
isnumeric = .T.
Name = "txt_medida"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Nro. Serie:"
Height = 15
Left = 31
Top = 46
Width = 64
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: txt_nro_serie
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 100
MaxLength = 20
Top = 43
Width = 164
Name = "txt_nro_serie"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Trabajo a realizar:"
Height = 15
Left = 275
Top = 46
Width = 104
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: txt_trabajo_a_realizar
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 379
MaxLength = 20
Top = 43
Width = 422
Name = "txt_trabajo_a_realizar"

*** METODOS ***


************************************************************
OBJETO: btnAgregar
************************************************************
*** PROPIEDADES ***
Top = 18
Left = 807
Name = "btnAgregar"

*** METODOS ***
PROCEDURE Click
*******************************************************
* Agrego un ítem al detalle
*******************************************************

IF Thisform.validardetalle() THEN
	Thisform.oRemitosDal.agregar_item(This.Parent.sel_marcas.valcpoid, ;
		this.Parent.sel_marcas.txtDescripcion.Value, this.Parent.txt_medida.Value,;
		this.Parent.txt_nro_serie.Value, this.Parent.txt_trabajo_a_realizar.Value)
	SELECT cur_items
	Thisform.contenido.cnt_items.grd_items.Refresh()
	thisform.blanquear_detalle()
	this.Parent.sel_marcas.txtCodigo.SetFocus()
ENDIF
ENDPROC


************************************************************
OBJETO: btnEliminar
************************************************************
*** PROPIEDADES ***
Top = 18
Left = 859
Picture = ..\imagen\iconos bajados\eliminar-cancelar-icono-4935 (1).ico
Name = "btnEliminar"

*** METODOS ***
PROCEDURE Click
*************************************************
* Elimino el ítem seleccionado
*************************************************
LOCAL lnResp

lnResp = MESSAGEBOX("¿Está seguro que desea eliminar un ítem?", 4+32, Thisform.Caption)
IF lnResp = 6 THEN
	SELECT cur_items
	DELETE
ENDIF
ENDPROC


************************************************************
OBJETO: grd_items
************************************************************
*** PROPIEDADES ***
Height = 225
Left = 7
Top = 72
Width = 913
Name = "grd_items"
COLUMN1.HEADER1.Name = "HEADER1"
COLUMN1.TEXT1.Name = "TEXT1"
COLUMN1.Name = "COLUMN1"
COLUMN2.HEADER1.Name = "HEADER1"
COLUMN2.TEXT1.Name = "TEXT1"
COLUMN2.Name = "COLUMN2"
COLUMN3.HEADER1.Name = "HEADER1"
COLUMN3.TEXT1.Name = "TEXT1"
COLUMN3.Name = "COLUMN3"
COLUMN4.HEADER1.Name = "HEADER1"
COLUMN4.TEXT1.Name = "TEXT1"
COLUMN4.Name = "COLUMN4"
COLUMN5.HEADER1.Name = "HEADER1"
COLUMN5.TEXT1.Name = "TEXT1"
COLUMN5.Name = "COLUMN5"
COLUMN6.HEADER1.Name = "HEADER1"
COLUMN6.TEXT1.Name = "TEXT1"
COLUMN6.Name = "COLUMN6"
COLUMN7.HEADER1.Name = "HEADER1"
COLUMN7.TEXT1.Name = "TEXT1"
COLUMN7.Name = "COLUMN7"
COLUMN8.HEADER1.Name = "HEADER1"
COLUMN8.TEXT1.Name = "TEXT1"
COLUMN8.Name = "COLUMN8"
COLUMN9.HEADER1.Name = "HEADER1"
COLUMN9.TEXT1.Name = "TEXT1"
COLUMN9.Name = "COLUMN9"
COLUMN10.HEADER1.Name = "HEADER1"
COLUMN10.TEXT1.Name = "TEXT1"
COLUMN10.Name = "COLUMN10"
COLUMN11.HEADER1.Name = "HEADER1"
COLUMN11.TEXT1.Name = "TEXT1"
COLUMN11.Name = "COLUMN11"
COLUMN12.HEADER1.Name = "HEADER1"
COLUMN12.TEXT1.Name = "TEXT1"
COLUMN12.Name = "COLUMN12"
COLUMN13.HEADER1.Name = "HEADER1"
COLUMN13.TEXT1.Name = "TEXT1"
COLUMN13.Name = "COLUMN13"
COLUMN14.HEADER1.Name = "HEADER1"
COLUMN14.TEXT1.Name = "TEXT1"
COLUMN14.Name = "COLUMN14"
COLUMN15.HEADER1.Name = "HEADER1"
COLUMN15.TEXT1.Name = "TEXT1"
COLUMN15.Name = "COLUMN15"
COLUMN16.HEADER1.Name = "HEADER1"
COLUMN16.TEXT1.Name = "TEXT1"
COLUMN16.Name = "COLUMN16"
COLUMN17.HEADER1.Name = "HEADER1"
COLUMN17.TEXT1.Name = "TEXT1"
COLUMN17.Name = "COLUMN17"
COLUMN18.HEADER1.Name = "HEADER1"
COLUMN18.TEXT1.Name = "TEXT1"
COLUMN18.Name = "COLUMN18"
COLUMN19.HEADER1.Name = "HEADER1"
COLUMN19.TEXT1.Name = "TEXT1"
COLUMN19.Name = "COLUMN19"
COLUMN20.HEADER1.Name = "HEADER1"
COLUMN20.TEXT1.Name = "TEXT1"
COLUMN20.Name = "COLUMN20"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Observaciones:"
Height = 15
Left = 13
Top = 445
Width = 94
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: txt_observaciones
************************************************************
*** PROPIEDADES ***
Height = 47
Left = 11
Top = 460
Width = 926
Name = "txt_observaciones"

*** METODOS ***


************************************************************
OBJETO: btn_nuevo
************************************************************
*** PROPIEDADES ***
Top = 517
Left = 793
Name = "btn_nuevo"

*** METODOS ***
PROCEDURE Click
Thisform.blancquear_cabecera()
Thisform.blanquear_detalle()
SELECT cur_items
ZAP
Thisform.contenido.cnt_items.grd_items.Refresh()
Thisform.cambiar_estado(.t.)
Thisform.contenido.cnt_cabecera.sel_cliente.txtCodigo.SetFocus()
ENDPROC


************************************************************
OBJETO: btn_grabar
************************************************************
*** PROPIEDADES ***
Top = 517
Left = 844
Name = "btn_grabar"

*** METODOS ***
PROCEDURE Click
If Thisform.validarcampos() Then
	Thisform.oRemitosDal.id_cliente = Thisform.contenido.cnt_cabecera.sel_cliente.valcpoid
	Thisform.oRemitosDal.id_tiporto = 1
	Thisform.oRemitosDal.numero = Thisform.contenido.cnt_cabecera.txt_numero_remito.Value
	Thisform.oRemitosDal.destino = Thisform.contenido.cnt_cabecera.txt_destino.Value
	Thisform.oRemitosDal.observaciones = Thisform.contenido.txt_observaciones.Value
	Thisform.oRemitosDal.usuario = gcCodUsu
	Thisform.oRemitosDal.Host = Alltrim(Sys(0))

	If Thisform.oRemitosDal.grabar() Then
		Messagebox("El remito se grabó con éxito", 0+64, Thisform.Caption)
		Thisform.blancquear_cabecera()
		Thisform.blanquear_detalle()
		Thisform.oRemitosDal.limpiar_items()
		Thisform.contenido.cnt_items.grd_items.Refresh()
		Thisform.cambiar_estado(.t.)
		Thisform.contenido.cnt_cabecera.sel_cliente.txtCodigo.SetFocus()
	Else
		Messagebox(Thisform.oRemitosDal.mensaje_error, 0+48, Thisform.Caption)
	Endif
Endif

ENDPROC


************************************************************
OBJETO: CLSCERRAR1
************************************************************
*** PROPIEDADES ***
Top = 517
Left = 895
Name = "CLSCERRAR1"

*** METODOS ***


************************************************************
OBJETO: cls_form_remitos
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_form_cantcub_by_estado
************************************************************
*** PROPIEDADES ***
BorderStyle = 2
Height = 455
Width = 778
DoCreate = .T.
Caption = "Cantidad de cubiertas por estado"
Name = "cls_form_cantcub_by_estado"

*** METODOS ***
PROCEDURE Init
Thisform.oFichaData.crear_cursores()
Thisform.oFichaData.active_connection = goConn.ActiveConnection
Thisform.oFichaData.get_cant_cubieras_by_estado()

SELECT cur_cantcub
GO TOP
Thisform.grdReporte.RecordSource = "cur_cantcub"
Thisform.grdReporte.alias_name = "cur_cantcub"
Thisform.grdReporte.list_controlsource = "idcliente,razsoc,pendiente,en_proceso,finalizado,entregado,totalizado"
Thisform.grdReporte.lista_ancho_cols = "70,200,70,70,70,70,70"
Thisform.grdReporte.titulos_cabeceras = "Nº Cliente,Razón Social,Pendiente,En Proceso,Finalizado,Entregado,Total"
Thisform.grdReporte.permitir_busqueda = .f.
Thisform.grdReporte.permitir_ordenamiento = .f.
Thisform.grdReporte.generar_grid()

ENDPROC


************************************************************
OBJETO: grdReporte
************************************************************
*** PROPIEDADES ***
Height = 394
Left = 0
Top = 0
Width = 780
Name = "grdReporte"
COLUMN1.Header1.Name = "Header1"
COLUMN1.Text1.Name = "Text1"
COLUMN1.Name = "COLUMN1"
COLUMN2.Header1.Name = "Header1"
COLUMN2.Text1.Name = "Text1"
COLUMN2.Name = "COLUMN2"
COLUMN3.Header1.Name = "Header1"
COLUMN3.Text1.Name = "Text1"
COLUMN3.Name = "COLUMN3"
COLUMN4.Header1.Name = "Header1"
COLUMN4.Text1.Name = "Text1"
COLUMN4.Name = "COLUMN4"
COLUMN5.Header1.Name = "Header1"
COLUMN5.Text1.Name = "Text1"
COLUMN5.Name = "COLUMN5"
COLUMN6.Header1.Name = "Header1"
COLUMN6.Text1.Name = "Text1"
COLUMN6.Name = "COLUMN6"
COLUMN7.Header1.Name = "Header1"
COLUMN7.Text1.Name = "Text1"
COLUMN7.Name = "COLUMN7"
COLUMN8.Header1.Name = "Header1"
COLUMN8.Text1.Name = "Text1"
COLUMN8.Name = "COLUMN8"
COLUMN9.Header1.Name = "Header1"
COLUMN9.Text1.Name = "Text1"
COLUMN9.Name = "COLUMN9"
COLUMN10.Header1.Name = "Header1"
COLUMN10.Text1.Name = "Text1"
COLUMN10.Name = "COLUMN10"
COLUMN11.Header1.Name = "Header1"
COLUMN11.Text1.Name = "Text1"
COLUMN11.Name = "COLUMN11"
COLUMN12.Header1.Name = "Header1"
COLUMN12.Text1.Name = "Text1"
COLUMN12.Name = "COLUMN12"
COLUMN13.Header1.Name = "Header1"
COLUMN13.Text1.Name = "Text1"
COLUMN13.Name = "COLUMN13"
COLUMN14.Header1.Name = "Header1"
COLUMN14.Text1.Name = "Text1"
COLUMN14.Name = "COLUMN14"
COLUMN15.Header1.Name = "Header1"
COLUMN15.Text1.Name = "Text1"
COLUMN15.Name = "COLUMN15"
COLUMN16.Header1.Name = "Header1"
COLUMN16.Text1.Name = "Text1"
COLUMN16.Name = "COLUMN16"
COLUMN17.Header1.Name = "Header1"
COLUMN17.Text1.Name = "Text1"
COLUMN17.Name = "COLUMN17"
COLUMN18.Header1.Name = "Header1"
COLUMN18.Text1.Name = "Text1"
COLUMN18.Name = "COLUMN18"
COLUMN19.Header1.Name = "Header1"
COLUMN19.Text1.Name = "Text1"
COLUMN19.Name = "COLUMN19"
COLUMN20.Header1.Name = "Header1"
COLUMN20.Text1.Name = "Text1"
COLUMN20.Name = "COLUMN20"

*** METODOS ***


************************************************************
OBJETO: btnCerrar
************************************************************
*** PROPIEDADES ***
Top = 401
Left = 725
Name = "btnCerrar"

*** METODOS ***


************************************************************
OBJETO: oFichaData
************************************************************
*** PROPIEDADES ***
Top = 420
Left = 52
Height = 17
Width = 32
Name = "oFichaData"

*** METODOS ***


************************************************************
OBJETO: btnExportarExcel
************************************************************
*** PROPIEDADES ***
Top = 401
Left = 673
Name = "btnExportarExcel"

*** METODOS ***
PROCEDURE Click
LOCAL lcFile

lcFile = GETFILE("Guardar archivo de Excel", "C:\", "Guardar|*.xls", 1)

IF !EMPTY(lcFile)
	lcFile = FORCEEXT(lcFile, "xls")  && Agregar la extensión .xls al nombre del archivo
    SELECT cur_cantcub
    COPY TO (lcFile) TYPE XL5
ENDIF

ENDPROC


************************************************************
OBJETO: cls_form_cantcub_by_estado
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_form_seleccion_factura
************************************************************
*** PROPIEDADES ***
BorderStyle = 1
Height = 363
Width = 689
DoCreate = .T.
Caption = "Seleccionar factura"
Closable = .F.
id_ventasc = 0
id_cliente = 0
numero_completo = 
press_aceptar = .F.
Name = "cls_form_seleccion_factura"

*** METODOS ***
PROCEDURE leer_datos
**********************************************************************}
* Ejecuto la consulta y lleno la grilla
**********************************************************************
Thisform.obj_datos.get_ventas_by_cliente(thisform.id_cliente)
Thisform.grd_ventas.Refresh()
Thisform.grd_ventas.SetFocus()
ENDPROC
PROCEDURE Init
*****************************************************************
* Se configura la grilla con el cursor de selección de comprobantes
*****************************************************************

Thisform.obj_datos.crear_cursores()

SELECT curSelFactura
Thisform.grd_ventas.alias_name = "curSelFactura"
Thisform.grd_ventas.RecordSource = "curSelFactura"
Thisform.grd_ventas.list_controlsource = "fecEmision,cbte,ptoVta,numero"
Thisform.grd_ventas.lista_ancho_cols = "100,70, 100, 100"
Thisform.grd_ventas.titulos_cabeceras = "Fecha,Comprob.,Pto. Vta.,Número"
Thisform.grd_ventas.generar_grid()
ENDPROC


************************************************************
OBJETO: grd_ventas
************************************************************
*** PROPIEDADES ***
Height = 309
Left = 1
TabIndex = 1
Top = 0
Width = 687
Name = "grd_ventas"
COLUMN1.Header1.Name = "Header1"
COLUMN1.Text1.Name = "Text1"
COLUMN1.Name = "COLUMN1"
COLUMN2.Header1.Name = "Header1"
COLUMN2.Text1.Name = "Text1"
COLUMN2.Name = "COLUMN2"
COLUMN3.Header1.Name = "Header1"
COLUMN3.Text1.Name = "Text1"
COLUMN3.Name = "COLUMN3"
COLUMN4.Header1.Name = "Header1"
COLUMN4.Text1.Name = "Text1"
COLUMN4.Name = "COLUMN4"
COLUMN5.Header1.Name = "Header1"
COLUMN5.Text1.Name = "Text1"
COLUMN5.Name = "COLUMN5"
COLUMN6.Header1.Name = "Header1"
COLUMN6.Text1.Name = "Text1"
COLUMN6.Name = "COLUMN6"
COLUMN7.Header1.Name = "Header1"
COLUMN7.Text1.Name = "Text1"
COLUMN7.Name = "COLUMN7"
COLUMN8.Header1.Name = "Header1"
COLUMN8.Text1.Name = "Text1"
COLUMN8.Name = "COLUMN8"
COLUMN9.Header1.Name = "Header1"
COLUMN9.Text1.Name = "Text1"
COLUMN9.Name = "COLUMN9"
COLUMN10.Header1.Name = "Header1"
COLUMN10.Text1.Name = "Text1"
COLUMN10.Name = "COLUMN10"
COLUMN11.Header1.Name = "Header1"
COLUMN11.Text1.Name = "Text1"
COLUMN11.Name = "COLUMN11"
COLUMN12.Header1.Name = "Header1"
COLUMN12.Text1.Name = "Text1"
COLUMN12.Name = "COLUMN12"
COLUMN13.Header1.Name = "Header1"
COLUMN13.Text1.Name = "Text1"
COLUMN13.Name = "COLUMN13"
COLUMN14.Header1.Name = "Header1"
COLUMN14.Text1.Name = "Text1"
COLUMN14.Name = "COLUMN14"
COLUMN15.Header1.Name = "Header1"
COLUMN15.Text1.Name = "Text1"
COLUMN15.Name = "COLUMN15"
COLUMN16.Header1.Name = "Header1"
COLUMN16.Text1.Name = "Text1"
COLUMN16.Name = "COLUMN16"
COLUMN17.Header1.Name = "Header1"
COLUMN17.Text1.Name = "Text1"
COLUMN17.Name = "COLUMN17"
COLUMN18.Header1.Name = "Header1"
COLUMN18.Text1.Name = "Text1"
COLUMN18.Name = "COLUMN18"
COLUMN19.Header1.Name = "Header1"
COLUMN19.Text1.Name = "Text1"
COLUMN19.Name = "COLUMN19"
COLUMN20.Header1.Name = "Header1"
COLUMN20.Text1.Name = "Text1"
COLUMN20.Name = "COLUMN20"

*** METODOS ***


************************************************************
OBJETO: btn_aceptar
************************************************************
*** PROPIEDADES ***
Top = 314
Left = 584
TabIndex = 2
Name = "btn_aceptar"

*** METODOS ***
PROCEDURE Click
***********************************************
* Aceptar
***********************************************
Thisform.id_ventasc = curSelFactura.idVentasC
Thisform.numero_completo = curSelFactura.cbte + " " + curSelFactura.tipoDoc ;
	+ " " + curSelFactura.ptoVta + "-" + curSelFactura.numero
	
Thisform.press_aceptar = .t.
Thisform.Hide()
ENDPROC


************************************************************
OBJETO: obj_datos
************************************************************
*** PROPIEDADES ***
Top = 318
Left = 34
Height = 17
Width = 26
Name = "obj_datos"

*** METODOS ***


************************************************************
OBJETO: btnCancelar
************************************************************
*** PROPIEDADES ***
Top = 314
Left = 634
TabIndex = 3
Name = "btnCancelar"

*** METODOS ***
PROCEDURE Click
Thisform.press_aceptar = .f.
Thisform.Hide()
ENDPROC


************************************************************
OBJETO: cls_form_seleccion_factura
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_form_remito_salida
************************************************************
*** PROPIEDADES ***
Height = 467
Width = 862
DoCreate = .T.
BorderStyle = 2
Caption = "Generar remito de salida"
Name = "cls_form_remito_salida"

*** METODOS ***
PROCEDURE grabar_remito_salida
***********************************************************************
* Graba el remito de salida.
* Fecha: 24/03/2023
***********************************************************************
LOCAL lnIdCliente
LOCAL lcObservaciones
LOCAL lnIdRemito

lnIdCliente = Thisform.pgf.page2.txt_id_cliente.Value
IF EMPTY(Thisform.pgf.page2.txt_observaciones.Value) THEN
	lcObservaciones = ""
ELSE
	lcObservaciones = Thisform.pgf.page2.txt_observaciones.Value
ENDIF

lnIdRemito = Thisform.oFichaData.generar_remito_salida(lnIdCliente, cur_clientes.id_rtoent, lcObservaciones, gcCodUsu, SYS(0))

IF lnIdRemito <> -1 THEN
	Thisform.imprimir(lnIdRemito)
ENDIF

MESSAGEBOX(Thisform.ofichaData.mensaje, 0+64, Thisform.Caption)
Thisform.Release()
ENDPROC
PROCEDURE imprimir
**************************************************************
* Imprime el remito de salida
**************************************************************
LPARAMETERS tnIdRemito

LOCAL ld_rep_fecha
LOCAL lc_rep_nroremito 
LOCAL ln_nro_cliente 
LOCAL lc_razsoc 
LOCAL lc_rep_destino
LOCAL lc_rep_nroremitosalida

ln_nro_cliente = Thisform.pgf.page2.txt_id_cliente.Value
lc_razsoc = Thisform.pgf.page2.txt_razon_social.Value
ld_rep_fecha = DATE()

Thisform.oFichaData.get_fichas_rto_sal(ln_nro_cliente, tnIdRemito)
SELECT cur_repsal
lc_rep_destino = cur_repsal.destino
lc_rep_nroremitosalida = cur_repsal.numero

SELECT cur_fichas

* Agrego los numeros de remito de las fichas seleccionadas
SELECT 			    ;
    cr.*,           ;
    cf.numero_remito ;
FROM                ;
    cur_repsal cr   ;
INNER JOIN          ;
    cur_fichas cf   ;
ON                  ;
    cr.id_ficha = cf.id_ficha ;
ORDER BY            ;
    cr.id_ficha ASC ;
INTO CURSOR cur_rep

SELECT cur_rep
GO TOP
REPORT FORM rep_rcn_remito_salida TO PRINTER PROMPT PREVIEW
ENDPROC
PROCEDURE Init
****************************************************************
* Inicialización de controles.
* Fecha: 24/06/2023
****************************************************************
Thisform.oFichaData.active_connection = goConn.ActiveConnection
Thisform.oFichaData.crear_cursores()
Thisform.oFichaData.crear_cursores_remitos_salidas()
Thisform.oFichaData.get_clientes_rsalida()

* Configuro grilla para selección de clientes.
SELECT cur_clientes
Thisform.pgf.page1.grd_clientes.RecordSource = "cur_clientes"
Thisform.pgf.page1.grd_clientes.alias_name = "cur_clientes"
Thisform.pgf.page1.grd_clientes.list_controlsource = "idCliente,razSoc,cant_cubie"
Thisform.pgf.page1.grd_clientes.lista_ancho_cols = "70,300,100,100"
Thisform.pgf.page1.grd_clientes.titulos_cabeceras = "Cliente Nº,Razón Social,Remito Nº,Cant. Cubiertas"
Thisform.pgf.page1.grd_clientes.permitir_busqueda = .t.
Thisform.pgf.page1.grd_clientes.permitir_ordenamiento = .t.
Thisform.pgf.page1.grd_clientes.generar_grid()
Thisform.pgf.page2.Enabled = .F.

* Configuro grilla para mostrar fichas a emitir.
SELECT cur_fichas
Thisform.pgf.page2.grd_fichas.RecordSource = "cur_fichas"
Thisform.pgf.page2.grd_fichas.alias_name = "cur_fichas"
Thisform.pgf.page2.grd_fichas.list_controlsource ="sel,id_ficha,numero_remito,marca,medida,nro_serie,estado,destino"
Thisform.pgf.page2.grd_fichas.lista_ancho_cols = "30,70,150,100,100,80,100,200"
Thisform.pgf.page2.grd_fichas.titulos_cabeceras = "Sel.,Ficha Nº,Remito Nº,Marca,Medida,D.O.T.,Estado,Destino"
Thisform.pgf.page2.grd_fichas.permitir_busqueda = .f.
Thisform.pgf.page2.grd_fichas.permitir_ordenamiento = .f.
Thisform.pgf.page2.grd_fichas.generar_grid()

Thisform.pgf.page2.grd_fichas.Columns[1].ReadOnly = .f.
ENDPROC


************************************************************
OBJETO: CLSCERRAR1
************************************************************
*** PROPIEDADES ***
Top = 414
Left = 807
Picture = ..\imagen\iconos bajados\salir-de-mi-perfil-icono-3964.ico
Name = "CLSCERRAR1"

*** METODOS ***


************************************************************
OBJETO: oFichaData
************************************************************
*** PROPIEDADES ***
Top = 420
Left = 36
Height = 17
Width = 24
Name = "oFichaData"

*** METODOS ***


************************************************************
OBJETO: pgf
************************************************************
*** PROPIEDADES ***
ErasePage = .T.
Top = 1
Left = 2
Width = 858
Height = 407
Name = "pgf"
Page1.Caption = "Seleccionar cliente"
Page1.Name = "Page1"
Page2.Caption = "Remito de salida"
Page2.Name = "Page2"

*** METODOS ***


************************************************************
OBJETO: CLSETIQUETA1
************************************************************
*** PROPIEDADES ***
Caption = "Seleccionar el cliente a generar el remito de salida"
Height = 15
Left = 4
Top = 2
Width = 300
TabIndex = 3
Name = "CLSETIQUETA1"

*** METODOS ***


************************************************************
OBJETO: grd_clientes
************************************************************
*** PROPIEDADES ***
Height = 311
Left = 3
TabIndex = 1
Top = 20
Width = 849
Name = "grd_clientes"
COLUMN1.Header1.Name = "Header1"
COLUMN1.Text1.Name = "Text1"
COLUMN1.Name = "COLUMN1"
COLUMN2.Header1.Name = "Header1"
COLUMN2.Text1.Name = "Text1"
COLUMN2.Name = "COLUMN2"
COLUMN3.Header1.Name = "Header1"
COLUMN3.Text1.Name = "Text1"
COLUMN3.Name = "COLUMN3"
COLUMN4.Header1.Name = "Header1"
COLUMN4.Text1.Name = "Text1"
COLUMN4.Name = "COLUMN4"
COLUMN5.Header1.Name = "Header1"
COLUMN5.Text1.Name = "Text1"
COLUMN5.Name = "COLUMN5"
COLUMN6.Header1.Name = "Header1"
COLUMN6.Text1.Name = "Text1"
COLUMN6.Name = "COLUMN6"
COLUMN7.Header1.Name = "Header1"
COLUMN7.Text1.Name = "Text1"
COLUMN7.Name = "COLUMN7"
COLUMN8.Header1.Name = "Header1"
COLUMN8.Text1.Name = "Text1"
COLUMN8.Name = "COLUMN8"
COLUMN9.Header1.Name = "Header1"
COLUMN9.Text1.Name = "Text1"
COLUMN9.Name = "COLUMN9"
COLUMN10.Header1.Name = "Header1"
COLUMN10.Text1.Name = "Text1"
COLUMN10.Name = "COLUMN10"
COLUMN11.Header1.Name = "Header1"
COLUMN11.Text1.Name = "Text1"
COLUMN11.Name = "COLUMN11"
COLUMN12.Header1.Name = "Header1"
COLUMN12.Text1.Name = "Text1"
COLUMN12.Name = "COLUMN12"
COLUMN13.Header1.Name = "Header1"
COLUMN13.Text1.Name = "Text1"
COLUMN13.Name = "COLUMN13"
COLUMN14.Header1.Name = "Header1"
COLUMN14.Text1.Name = "Text1"
COLUMN14.Name = "COLUMN14"
COLUMN15.Header1.Name = "Header1"
COLUMN15.Text1.Name = "Text1"
COLUMN15.Name = "COLUMN15"
COLUMN16.Header1.Name = "Header1"
COLUMN16.Text1.Name = "Text1"
COLUMN16.Name = "COLUMN16"
COLUMN17.Header1.Name = "Header1"
COLUMN17.Text1.Name = "Text1"
COLUMN17.Name = "COLUMN17"
COLUMN18.Header1.Name = "Header1"
COLUMN18.Text1.Name = "Text1"
COLUMN18.Name = "COLUMN18"
COLUMN19.Header1.Name = "Header1"
COLUMN19.Text1.Name = "Text1"
COLUMN19.Name = "COLUMN19"
COLUMN20.Header1.Name = "Header1"
COLUMN20.Text1.Name = "Text1"
COLUMN20.Name = "COLUMN20"

*** METODOS ***


************************************************************
OBJETO: btn_siguiente
************************************************************
*** PROPIEDADES ***
Top = 335
Left = 803
Picture = ..\imagen\arrow-left.ico
TabIndex = 2
Name = "btn_siguiente"

*** METODOS ***
PROCEDURE Click
**********************************************
* Recupero los datos del remito y cambio de
* solapa.
* Fecha: 24/06/2023
**********************************************
LOCAL lcFiltro

SELECT cur_fichas
Thisform.pgf.page2.txt_id_cliente.Value = cur_clientes.idCliente
Thisform.pgf.page2.txt_razon_social.Value = cur_clientes.razSoc

* Armo el filtro para levantar las fichas.
lcFiltro = "rem.idCliente = " + ALLTRIM(STR(Thisform.pgf.page2.txt_id_cliente.Value)) + " AND "
lcFiltro = lcFiltro + "ficha.id_estado = 3 "

Thisform.oFichaData.get(lcFiltro)
SELECT cur_fichas
GO TOP
Thisform.pgf.page2.grd_fichas.Refresh()

Thisform.pgf.page1.Enabled = .F.
Thisform.pgf.page2.Enabled = .T.

Thisform.pgf.page2.SetFocus()

ENDPROC


************************************************************
OBJETO: CLSETIQUETA1
************************************************************
*** PROPIEDADES ***
Caption = "Cliente seleccioando:"
Height = 15
Left = 21
Top = 11
Width = 127
TabIndex = 6
Name = "CLSETIQUETA1"

*** METODOS ***


************************************************************
OBJETO: txt_id_cliente
************************************************************
*** PROPIEDADES ***
Left = 153
ReadOnly = .T.
TabIndex = 7
Top = 8
isinteger = .T.
Name = "txt_id_cliente"

*** METODOS ***


************************************************************
OBJETO: txt_razon_social
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 259
ReadOnly = .T.
TabIndex = 8
Top = 8
Width = 566
ischaracter = .T.
Name = "txt_razon_social"

*** METODOS ***


************************************************************
OBJETO: grd_fichas
************************************************************
*** PROPIEDADES ***
Height = 224
Left = 5
TabIndex = 1
Top = 47
Width = 842
Name = "grd_fichas"
COLUMN1.Header1.Name = "Header1"
COLUMN1.Text1.ReadOnly = .F.
COLUMN1.Text1.Name = "Text1"
COLUMN1.CurrentControl = "chk_selector"
COLUMN1.ReadOnly = .F.
COLUMN1.Sparse = .F.
COLUMN1.Name = "COLUMN1"
COLUMN2.Header1.Name = "Header1"
COLUMN2.Text1.Name = "Text1"
COLUMN2.Name = "COLUMN2"
COLUMN3.Header1.Name = "Header1"
COLUMN3.Text1.Name = "Text1"
COLUMN3.Name = "COLUMN3"
COLUMN4.Header1.Name = "Header1"
COLUMN4.Text1.Name = "Text1"
COLUMN4.Name = "COLUMN4"
COLUMN5.Header1.Name = "Header1"
COLUMN5.Text1.Name = "Text1"
COLUMN5.Name = "COLUMN5"
COLUMN6.Header1.Name = "Header1"
COLUMN6.Text1.Name = "Text1"
COLUMN6.Name = "COLUMN6"
COLUMN7.Header1.Name = "Header1"
COLUMN7.Text1.Name = "Text1"
COLUMN7.Name = "COLUMN7"
COLUMN8.Header1.Name = "Header1"
COLUMN8.Text1.Name = "Text1"
COLUMN8.Name = "COLUMN8"
COLUMN9.Header1.Name = "Header1"
COLUMN9.Text1.Name = "Text1"
COLUMN9.Name = "COLUMN9"
COLUMN10.Header1.Name = "Header1"
COLUMN10.Text1.Name = "Text1"
COLUMN10.Name = "COLUMN10"
COLUMN11.Header1.Name = "Header1"
COLUMN11.Text1.Name = "Text1"
COLUMN11.Name = "COLUMN11"
COLUMN12.Header1.Name = "Header1"
COLUMN12.Text1.Name = "Text1"
COLUMN12.Name = "COLUMN12"
COLUMN13.Header1.Name = "Header1"
COLUMN13.Text1.Name = "Text1"
COLUMN13.Name = "COLUMN13"
COLUMN14.Header1.Name = "Header1"
COLUMN14.Text1.Name = "Text1"
COLUMN14.Name = "COLUMN14"
COLUMN15.Header1.Name = "Header1"
COLUMN15.Text1.Name = "Text1"
COLUMN15.Name = "COLUMN15"
COLUMN16.Header1.Name = "Header1"
COLUMN16.Text1.Name = "Text1"
COLUMN16.Name = "COLUMN16"
COLUMN17.Header1.Name = "Header1"
COLUMN17.Text1.Name = "Text1"
COLUMN17.Name = "COLUMN17"
COLUMN18.Header1.Name = "Header1"
COLUMN18.Text1.Name = "Text1"
COLUMN18.Name = "COLUMN18"
COLUMN19.Header1.Name = "Header1"
COLUMN19.Text1.Name = "Text1"
COLUMN19.Name = "COLUMN19"
COLUMN20.Header1.Name = "Header1"
COLUMN20.Text1.Name = "Text1"
COLUMN20.Name = "COLUMN20"

*** METODOS ***


************************************************************
OBJETO: chk_selector
************************************************************
*** PROPIEDADES ***
Top = 23
Left = 17
Alignment = 0
Caption = ""
ReadOnly = .F.
Name = "chk_selector"

*** METODOS ***


************************************************************
OBJETO: btn_ver_detalles
************************************************************
*** PROPIEDADES ***
Top = 327
Left = 754
TabIndex = 3
ToolTipText = "Ver detalle de la ficha seleccionada"
Name = "btn_ver_detalles"

*** METODOS ***
PROCEDURE Click
*******************************************************
* Permite ver el detalle de la ficha seleccionada en
* el grid
* Fecha: 24/06/2023
*******************************************************

LOCAL loFormDetalleFicha

loFormDetalleFicha = CREATEOBJECT("cls_form_editar_ficha")
SELECT cur_fichas
loFormDetalleFicha.id_ficha = cur_fichas.id_ficha
loFormDetalleFicha.solo_correccion = .T.
loFormDetalleFicha.inicializar_datos()
loFormDetalleFicha.show(1)
ENDPROC


************************************************************
OBJETO: btn_grabar_remito
************************************************************
*** PROPIEDADES ***
Top = 327
Left = 803
TabIndex = 4
ToolTipText = "Emitir remito de salida"
Name = "btn_grabar_remito"

*** METODOS ***
PROCEDURE Click
Thisform.grabar_remito_salida()

ENDPROC


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Observaciones:"
Height = 15
Left = 7
Top = 279
Width = 98
TabIndex = 5
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: txt_observaciones
************************************************************
*** PROPIEDADES ***
Height = 36
Left = 117
MaxLength = 200
TabIndex = 2
Top = 280
Width = 730
Name = "txt_observaciones"

*** METODOS ***


************************************************************
OBJETO: cls_form_remito_salida
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_form_editar_ficha
************************************************************
*** PROPIEDADES ***
BorderStyle = 2
Height = 526
Width = 1038
DoCreate = .T.
Caption = "Ficha"
id_ficha = 0
solo_correccion = .F.
id_ventasc = 0
id_estado_actual = 0
Name = "cls_form_editar_ficha"

*** METODOS ***
PROCEDURE recuperar_datos
**********************************************************
* Permite recuperar los datos de la ficha.
* Fecha: 29/05/2023
**********************************************************


SELECT cur_fichas
Thisform.oFichaData.get("ficha.id_ficha = " + ALLTRIM(STR(This.id_ficha)))

* Recupero los datos de la solapa datos generales
Thisform.id_estado_actual = cur_fichas.id_estado
Thisform.pgf.page1.txt_numero_remito.Value = cur_fichas.numero_remito
Thisform.pgf.page1.sel_cliente.txtCodigo.Value = cur_fichas.idCliente
Thisform.pgf.page1.sel_cliente.txtDescripcion.Value = cur_fichas.razSoc
Thisform.pgf.page1.sel_cliente.valcpoid = cur_fichas.idCliente
Thisform.pgf.page1.sel_marca.txtCodigo.Value = cur_fichas.idmarca
Thisform.pgf.page1.sel_marca.txtDescripcion.Value = cur_fichas.marca
Thisform.pgf.page1.sel_marca.valcpoid = cur_fichas.idmarca
Thisform.pgf.page1.sel_motivo_rechazo.valcpoid = cur_fichas.id_motrec

Thisform.pgf.page1.txt_chofer.Value = cur_fichas.destino
Thisform.pgf.page1.txt_fecha_entrada.Value = cur_fichas.fecAlta
Thisform.pgf.page1.txt_medida.Value = cur_fichas.medida
Thisform.pgf.page1.txt_nro_serie.Value = cur_fichas.nro_serie
Thisform.pgf.page1.txt_trabajo.Value = cur_fichas.trabajo
Thisform.pgf.page1.opt_grupo.option1.Value = cur_fichas.vulcaniza
Thisform.pgf.page1.opt_grupo.option2.Value = cur_fichas.aprobado
Thisform.pgf.page1.opt_grupo.option3.Value = cur_fichas.aprob_sg
Thisform.pgf.page1.opt_grupo.option4.Value = cur_fichas.rechazado

IF cur_fichas.id_motrec <> 0 THEN
	Thisform.pgf.page1.sel_motivo_rechazo.txtCodigo.Value = cur_fichas.id_motrec
	Thisform.pgf.page1.sel_motivo_rechazo.txtDescripcion.Value = cur_fichas.motiv_rech
ENDIF

* Recupero los datos solapa recepción
Thisform.pgf.page2.txt_camara_sec_grados.Value = cur_fichas.camsecgdo
Thisform.pgf.page2.chk_parches_ant.Value = cur_fichas.parch_ant
Thisform.pgf.page2.sel_operador.valcpoid = cur_fichas.idop_recep
IF cur_fichas.idop_recep <> 0 THEN
	Thisform.pgf.page2.sel_operador.txtCodigo.Value = cur_fichas.idop_recep
	Thisform.pgf.page2.sel_operador.txtDescripcion.Value = cur_fichas.op_recep
ENDIF
Thisform.pgf.page2.txt_observaciones.Value = ALLTRIM(cur_fichas.observ)

* Recupero los datos solapa raspado
Thisform.pgf.page3.txt_perimetro.Value = cur_fichas.perimetro
Thisform.pgf.page3.txt_radio.Value = cur_fichas.radio
Thisform.pgf.page3.txt_ancho.Value = cur_fichas.ancho
IF cur_fichas.idop_rasp <> 0 THEN
	Thisform.pgf.page3.sel_operador.valcpoid = cur_fichas.idop_rasp
	Thisform.pgf.page3.sel_operador.txtCodigo.Value = cur_fichas.idop_rasp
	Thisform.pgf.page3.sel_operador.txtDescripcion.Value = cur_fichas.op_rasp
ENDIF

* Recupero los datos de la solapa escareacion.
IF cur_fichas.id_estcra = 0 THEN
	Thisform.pgf.page4.cbo_escare.ListIndex = 1
ELSE
	Thisform.pgf.page4.cbo_escare.ListIndex = cur_fichas.id_estcra
ENDIF

IF cur_fichas.idop_esca <> 0 THEN
	Thisform.pgf.page4.sel_operador_escareacion.valcpoid = cur_fichas.idop_esca
	Thisform.pgf.page4.sel_operador_escareacion.txtCodigo.Value = cur_fichas.idop_esca
	Thisform.pgf.page4.sel_operador_escareacion.txtDescripcion.Value = cur_fichas.op_esca
ENDIF

* Recupero los datos de la solapa aplicación de parches
IF cur_fichas.idop_appar <> 0 THEN
	Thisform.pgf.page5.sel_operador.valcpoid = cur_fichas.idop_appar
	Thisform.pgf.page5.sel_operador.txtCodigo.Value = cur_fichas.idop_appar
	Thisform.pgf.page5.sel_operador.txtDescripcion.Value = cur_fichas.op_appar
ENDIF

Thisform.pgf.page1.cntVincularFactura.txt_numero_factura.Value = cur_fichas.numero_completo
thisform.id_ventasc = cur_fichas.idVentasC

Thisform.oFichaData.get_ficha_detalle(This.id_ficha)
Thisform.pgf.page5.grd_parches.Refresh()

ENDPROC
PROCEDURE llenar_estados_cracteres
************************************************************
* Permite llenar el combobox de estados.
* Fecha: 24/05/2023
************************************************************
Thisform.oFichaData.get_estados_cracter()
SELECT cur_estcra
GO TOP
DO WHILE !EOF("cur_estcra")
	Thisform.pgf.page4.cbo_escare.AddItem(cur_estcra.descripcio, cur_estcra.id_estcra)

	SELECT cur_estcra
	SKIP
ENDDO

SELECT cur_estcra
GO TOP
Thisform.pgf.page4.cbo_escare.ListIndex = 1
ENDPROC
PROCEDURE imprimir_ficha_completar
************************************************************************
* Imprime la ficha a completar
* Fecha: 14/06/2023
************************************************************************
LOCAL lnIdFicha
LOCAL lnIdCliente
LOCAL lcRazonSocial
LOCAL lcNumeroRemito
LOCAL lcDestino
LOCAL lcDireccion
LOCAL ldFechaEntrada
LOCAL lcMarca
LOCAL lnMedida
LOCAL lcNroSerie
LOCAL lcTrabajo

lnIdFicha = Thisform.id_ficha
lnIdCliente = Thisform.pgf.page1.sel_cliente.txtCodigo.Value
lcRazonSocial = Thisform.pgf.page1.sel_cliente.txtDescripcion.Value
lcNumeroRemito = Thisform.pgf.page1.txt_numero_remito.Value
lcDestino = Thisform.pgf.page1.txt_chofer.Value
lcDireccion = ""
ldFechaEntrada = Thisform.pgf.page1.txt_fecha_entrada.Value
lcMarca = Thisform.pgf.page1.sel_marca.txtDescripcion.Value
lnMedida = Thisform.pgf.page1.txt_medida.Value
lcNroSerie = Thisform.pgf.page1.txt_nro_serie.Value
lcTrabajo = Thisform.pgf.page1.txt_trabajo.Value

* Cambio el estado a "EN PROCESO".
IF !This.oFichaData.cambiar_estado(THisform.id_ficha, 2) THEN
	MESSAGEBOX(this.oFichaData.mensaje, 0+48, Thisform.Caption)
ELSE
	REPORT FORM rep_rcn_ficha TO PRINTER PROMPT PREVIEW
	MESSAGEBOX("La ficha se cambió al estado 'EN PROCESO'", 0+64, Thisform.Caption)
ENDIF


ENDPROC
PROCEDURE validar_detalle
******************************************************************************
* Valida de que los datos del detalle estén cargados correctamente.
* Fecha: 21/06/2023
******************************************************************************

IF Thisform.pgf.page5.sel_articulo.valcpoid = 0 THEN
	MESSAGEBOX("Debe seleccionar un artículo", 0+48, Thisform.Caption)
	Thisform.pgf.page5.sel_articulo.txtCodigo.SetFocus()
	RETURN .F.
ENDIF

IF Thisform.pgf.page5.txtCantidad.Value = 0 THEN
	MESSAGEBOX("Debe ingresar la cantidad", 0+48, Thisform.Caption)
	Thisform.pgf.page5.txtCantidad.SetFocus()
	RETURN .F.
ENDIF

* Si el módulo de stock está habilitado, entonces, aviso
* cuando queda poco stock del artículo.
IF getGlobalCFG("STK_MODULE") THEN
	IF !Thisform.validar_stock() THEN
		* Lo dejo seguir de todas formas
		RETURN .T.
	ENDIF
ENDIF


RETURN .T.
ENDPROC
PROCEDURE inicializar_datos
* Recupero datos e inicializo estado de botones.
Thisform.recuperar_datos()

** Verifico si el estado es pendiente que no habilite el grabar
IF cur_fichas.id_estado = 1 THEN
	Thisform.btnGrabar.Enabled = .F.
ENDIF

** Verifico si el estado está en finalizado, deshabilito la emisión de ficha.
IF cur_fichas.id_estado = 2 .OR. cur_fichas.id_estado = 3 .OR. cur_fichas.id_estado = 4 THEN
	Thisform.btn_imprimir_ficha.Enabled = .F.
ENDIF
ENDPROC
PROCEDURE validar_stock
*******************************************************
* Permite validar si hay stock.
* Fecha: 03/08/2023
*******************************************************
LOCAL lnExistencia

lnExistencia = thisform.o_stock.get_exist_byart(Thisform.pgf.page5.sel_articulo.valcpoid)
IF lnExistencia <= 10 THEN
	MESSAGEBOX("Quedan " + ALLTRIM(STR(lnExistencia, 20, 2)) + " de stock evaluar compra", 0+64, Thisform.Caption)
	RETURN .F.
ENDIF

RETURN .T.
ENDPROC
PROCEDURE Init
**************************************************************
* Inicializo los componentes
**************************************************************

Thisform.oFichaData.active_connection = goConn.ActiveConnection
Thisform.oFichaData.crear_cursores()

SELECT curFichaDet
Thisform.pgf.page5.grd_parches.alias_name = "curFichaDet"
Thisform.pgf.page5.grd_parches.RecordSource = "curFichaDet"
Thisform.pgf.page5.grd_parches.list_controlsource = "id_fichadet,codArt,descripcio,cantidad"
Thisform.pgf.page5.grd_parches.lista_ancho_cols = "70,100,250,100"		
Thisform.pgf.page5.grd_parches.titulos_cabeceras = "Renglón N°,Código,Descripción,Cantidad"
Thisform.pgf.page5.grd_parches.permitir_busqueda = .f.
Thisform.pgf.page5.grd_parches.permitir_ordenamiento = .f.
Thisform.pgf.page5.grd_parches.generar_grid()

Thisform.llenar_estados_cracteres()
ENDPROC


************************************************************
OBJETO: pgf
************************************************************
*** PROPIEDADES ***
ErasePage = .T.
PageCount = 5
Top = 3
Left = 6
Width = 1029
Height = 469
TabIndex = 1
Name = "pgf"
Page1.Caption = "Datos generales"
Page1.Name = "Page1"
Page2.Caption = "Recepción"
Page2.Name = "Page2"
Page3.FontBold = .T.
Page3.FontItalic = .T.
Page3.FontSize = 8
Page3.Caption = "Raspado"
Page3.ForeColor = 128,64,64
Page3.Name = "Page3"
Page4.FontBold = .T.
Page4.FontItalic = .T.
Page4.FontSize = 8
Page4.Caption = "Escareación"
Page4.ForeColor = 128,64,64
Page4.Name = "Page4"
Page5.FontBold = .T.
Page5.FontItalic = .T.
Page5.FontSize = 8
Page5.Caption = "Aplicación de parches"
Page5.ForeColor = 128,64,64
Page5.Name = "Page5"

*** METODOS ***


************************************************************
OBJETO: CLSETIQUETA1
************************************************************
*** PROPIEDADES ***
Caption = "Cliente:"
Height = 15
Left = 41
Top = 32
Width = 60
TabIndex = 7
Name = "CLSETIQUETA1"

*** METODOS ***


************************************************************
OBJETO: sel_cliente
************************************************************
*** PROPIEDADES ***
Top = 27
Left = 105
TabIndex = 8
esnumerico = .T.
nombre_tabla = clientes
nombre_campo_codigo = idCliente
nombre_campo_desc = razSoc
pkfield = idCliente
title_cols = Razón Social
Name = "sel_cliente"
TXTCODIGO.ReadOnly = .T.
TXTCODIGO.Name = "TXTCODIGO"
TXTDESCRIPCION.Name = "TXTDESCRIPCION"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Marca:"
Height = 15
Left = 41
Top = 58
Width = 60
TabIndex = 9
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: sel_marca
************************************************************
*** PROPIEDADES ***
Top = 53
Left = 105
TabIndex = 10
esnumerico = .T.
nombre_tabla = marcas
nombre_campo_codigo = idmarca
nombre_campo_desc = descripcio
pkfield = idmarca
title_cols = Descripción
Name = "sel_marca"
TXTCODIGO.ReadOnly = .F.
TXTCODIGO.Name = "TXTCODIGO"
TXTDESCRIPCION.Name = "TXTDESCRIPCION"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Medida:"
Height = 15
Left = 41
Top = 85
Width = 60
TabIndex = 11
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Nro. Serie (DOT):"
Height = 15
Left = 212
Top = 85
Width = 94
TabIndex = 12
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta5
************************************************************
*** PROPIEDADES ***
Caption = "Trabajo a realizar:"
Height = 15
Left = 41
Top = 110
Width = 101
TabIndex = 13
Name = "Clsetiqueta5"

*** METODOS ***


************************************************************
OBJETO: txt_medida
************************************************************
*** PROPIEDADES ***
Left = 107
ReadOnly = .F.
TabIndex = 14
Top = 81
isnumeric = .T.
Name = "txt_medida"

*** METODOS ***


************************************************************
OBJETO: txt_nro_serie
************************************************************
*** PROPIEDADES ***
Alignment = 0
Height = 21
Left = 310
ReadOnly = .F.
TabIndex = 15
Top = 81
Width = 173
ischaracter = .T.
Name = "txt_nro_serie"

*** METODOS ***


************************************************************
OBJETO: txt_trabajo
************************************************************
*** PROPIEDADES ***
Alignment = 0
Height = 21
Left = 148
ReadOnly = .F.
TabIndex = 16
Top = 106
Width = 437
Name = "txt_trabajo"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta6
************************************************************
*** PROPIEDADES ***
Caption = "Chofer o viajante:"
Height = 15
Left = 593
Top = 32
Width = 103
TabIndex = 17
Name = "Clsetiqueta6"

*** METODOS ***


************************************************************
OBJETO: txt_chofer
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 696
ReadOnly = .T.
TabIndex = 1
Top = 29
Width = 312
Name = "txt_chofer"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta7
************************************************************
*** PROPIEDADES ***
Caption = "Fecha de Entrada:"
Height = 15
Left = 594
Top = 58
Width = 103
TabIndex = 18
Name = "Clsetiqueta7"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta8
************************************************************
*** PROPIEDADES ***
Caption = "Fecha de Salida:"
Height = 15
Left = 813
Top = 58
Width = 96
TabIndex = 19
Name = "Clsetiqueta8"

*** METODOS ***


************************************************************
OBJETO: txt_fecha_entrada
************************************************************
*** PROPIEDADES ***
Left = 696
ReadOnly = .T.
TabIndex = 2
Top = 54
isdatetime = .T.
Name = "txt_fecha_entrada"

*** METODOS ***


************************************************************
OBJETO: txt_fecha_salida
************************************************************
*** PROPIEDADES ***
Left = 908
TabIndex = 3
Top = 54
isdatetime = .T.
Name = "txt_fecha_salida"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta9
************************************************************
*** PROPIEDADES ***
Caption = "Matricula:"
Height = 15
Left = 594
Top = 85
Width = 96
TabIndex = 20
Name = "Clsetiqueta9"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta10
************************************************************
*** PROPIEDADES ***
Caption = "N° referencia:"
Height = 15
Left = 814
Top = 85
Width = 90
TabIndex = 21
Name = "Clsetiqueta10"

*** METODOS ***


************************************************************
OBJETO: txt_matricula
************************************************************
*** PROPIEDADES ***
Left = 696
TabIndex = 4
Top = 81
Name = "txt_matricula"

*** METODOS ***


************************************************************
OBJETO: txt_referencia
************************************************************
*** PROPIEDADES ***
Left = 909
TabIndex = 5
Top = 81
isinteger = .T.
Name = "txt_referencia"

*** METODOS ***


************************************************************
OBJETO: opt_grupo
************************************************************
*** PROPIEDADES ***
ButtonCount = 4
Height = 37
Left = 42
Top = 139
Width = 441
TabIndex = 22
Name = "opt_grupo"
OPTION1.FontSize = 8
OPTION1.Caption = "Vulcanización"
OPTION1.Value = 0
OPTION1.Height = 15
OPTION1.Left = 5
OPTION1.Top = 10
OPTION1.Width = 102
OPTION1.Name = "OPTION1"
OPTION2.FontSize = 8
OPTION2.Caption = "Aprobado"
OPTION2.Value = 0
OPTION2.Left = 113
OPTION2.Top = 10
OPTION2.Name = "OPTION2"
Option3.FontBold = .T.
Option3.FontSize = 8
Option3.Caption = "Aprobado s/garan."
Option3.Value = 0
Option3.Height = 17
Option3.Left = 201
Option3.Top = 9
Option3.Width = 124
Option3.Name = "Option3"
Option4.FontBold = .T.
Option4.FontSize = 8
Option4.Caption = "Rechazado"
Option4.Value = 0
Option4.Height = 17
Option4.Left = 335
Option4.Top = 9
Option4.Width = 92
Option4.Name = "Option4"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta11
************************************************************
*** PROPIEDADES ***
Caption = "Motivo de rechazo:"
Height = 15
Left = 40
Top = 184
Width = 107
TabIndex = 23
Name = "Clsetiqueta11"

*** METODOS ***


************************************************************
OBJETO: sel_motivo_rechazo
************************************************************
*** PROPIEDADES ***
Top = 179
Left = 148
TabIndex = 6
esnumerico = .T.
nombre_campo_codigo = id_motrec
nombre_campo_desc = descripcio
nombre_tabla = rcn_motrec
pkfield = id_motrec
Name = "sel_motivo_rechazo"
TXTCODIGO.Name = "TXTCODIGO"
TXTDESCRIPCION.Name = "TXTDESCRIPCION"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta12
************************************************************
*** PROPIEDADES ***
Caption = "Número de remito:"
Height = 15
Left = 41
Top = 7
Width = 120
TabIndex = 7
Name = "Clsetiqueta12"

*** METODOS ***


************************************************************
OBJETO: txt_numero_remito
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 167
ReadOnly = .T.
Top = 4
Width = 186
Name = "txt_numero_remito"

*** METODOS ***


************************************************************
OBJETO: cntVincularFactura
************************************************************
*** PROPIEDADES ***
Top = 118
Left = 641
Width = 367
Height = 84
Name = "cntVincularFactura"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta9
************************************************************
*** PROPIEDADES ***
Caption = "Vincular factura"
Height = 15
Left = 7
Top = 7
Width = 96
TabIndex = 20
Name = "Clsetiqueta9"

*** METODOS ***


************************************************************
OBJETO: txt_numero_factura
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 10
ReadOnly = .T.
Top = 23
Width = 349
Name = "txt_numero_factura"

*** METODOS ***


************************************************************
OBJETO: btnVincularFactura
************************************************************
*** PROPIEDADES ***
Top = 47
Left = 321
Height = 33
Width = 40
Picture = ..\imagen\iconos_chicos\buscar.png
ToolTipText = "Buscar factura"
Name = "btnVincularFactura"

*** METODOS ***
PROCEDURE Click
**********************************************************
* Permite buscar una factura para asociarla a esta
* ficha.
**********************************************************
LOCAL loForm

loForm = CREATEOBJECT("cls_form_seleccion_factura")
loForm.id_cliente = Thisform.pgf.page1.sel_cliente.txtCodigo.Value
loForm.leer_datos()
loForm.Show()

IF loForm.press_aceptar THEN
	Thisform.pgf.page1.cntVincularFactura.txt_numero_factura.Value = loForm.numero_completo
	Thisform.id_ventasc = loForm.id_VentasC
ELSE
	Thisform.id_ventasc = 0
ENDIF

loForm.Release()

ENDPROC


************************************************************
OBJETO: CLSETIQUETA1
************************************************************
*** PROPIEDADES ***
Caption = "Cámara de secado grados:"
Height = 15
Left = 41
Top = 21
Width = 160
TabIndex = 4
Name = "CLSETIQUETA1"

*** METODOS ***


************************************************************
OBJETO: txt_camara_sec_grados
************************************************************
*** PROPIEDADES ***
Height = 21
Left = 213
TabIndex = 1
Top = 18
Width = 128
isnumeric = .T.
Name = "txt_camara_sec_grados"

*** METODOS ***


************************************************************
OBJETO: chk_parches_ant
************************************************************
*** PROPIEDADES ***
Top = 19
Left = 392
Height = 18
Width = 137
Alignment = 0
Caption = "Parches anteriores"
TabIndex = 5
Name = "chk_parches_ant"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Observaciones:"
Height = 15
Left = 42
Top = 80
Width = 160
TabIndex = 6
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: txt_observaciones
************************************************************
*** PROPIEDADES ***
Height = 314
Left = 41
TabIndex = 3
Top = 107
Width = 960
Name = "txt_observaciones"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Operador:"
Height = 15
Left = 42
Top = 45
Width = 67
TabIndex = 7
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: sel_operador
************************************************************
*** PROPIEDADES ***
Top = 41
Left = 212
TabIndex = 2
nombre_tabla = rcn_operad
nombre_campo_codigo = id_operad
nombre_campo_desc = apelnom
pkfield = id_operad
title_cols = Apellido y Nombre(s)
Name = "sel_operador"
TXTCODIGO.Name = "TXTCODIGO"
TXTDESCRIPCION.Name = "TXTDESCRIPCION"

*** METODOS ***


************************************************************
OBJETO: CLSETIQUETA1
************************************************************
*** PROPIEDADES ***
Caption = "Perímetro:"
Left = 41
Top = 21
TabIndex = 5
Name = "CLSETIQUETA1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Radio:"
Left = 234
Top = 21
TabIndex = 6
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Ancho:"
Height = 15
Left = 415
Top = 21
Width = 46
TabIndex = 7
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: txt_perimetro
************************************************************
*** PROPIEDADES ***
Left = 113
TabIndex = 1
Top = 17
isnumeric = .T.
Name = "txt_perimetro"

*** METODOS ***


************************************************************
OBJETO: txt_radio
************************************************************
*** PROPIEDADES ***
Left = 275
TabIndex = 2
Top = 17
isnumeric = .T.
Name = "txt_radio"

*** METODOS ***


************************************************************
OBJETO: txt_ancho
************************************************************
*** PROPIEDADES ***
Left = 462
TabIndex = 3
Top = 17
isnumeric = .T.
Name = "txt_ancho"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Operador:"
Height = 15
Left = 42
Top = 43
Width = 67
TabIndex = 8
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: sel_operador
************************************************************
*** PROPIEDADES ***
Top = 39
Left = 111
TabIndex = 4
nombre_tabla = rcn_operad
nombre_campo_codigo = id_operad
nombre_campo_desc = apelnom
pkfield = id_operad
title_cols = Apellido y Nombre(s)
Name = "sel_operador"
TXTCODIGO.Name = "TXTCODIGO"
TXTDESCRIPCION.Name = "TXTDESCRIPCION"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta4
************************************************************
*** PROPIEDADES ***
Caption = "Escareación:"
Height = 15
Left = 38
Top = 22
Width = 76
TabIndex = 3
Name = "Clsetiqueta4"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta1
************************************************************
*** PROPIEDADES ***
Caption = "Operador:"
Height = 15
Left = 38
Top = 48
Width = 67
TabIndex = 4
Name = "Clsetiqueta1"

*** METODOS ***


************************************************************
OBJETO: sel_operador_escareacion
************************************************************
*** PROPIEDADES ***
Top = 44
Left = 118
TabIndex = 2
nombre_tabla = rcn_operad
nombre_campo_codigo = id_operad
nombre_campo_desc = apelnom
pkfield = id_operad
title_cols = Apellido y Nombre(s)
Name = "sel_operador_escareacion"
TXTCODIGO.Name = "TXTCODIGO"
TXTDESCRIPCION.Name = "TXTDESCRIPCION"

*** METODOS ***


************************************************************
OBJETO: cbo_escare
************************************************************
*** PROPIEDADES ***
Height = 22
Left = 120
TabIndex = 1
Top = 18
Width = 198
Name = "cbo_escare"

*** METODOS ***


************************************************************
OBJETO: CLSETIQUETA1
************************************************************
*** PROPIEDADES ***
Caption = "Parches:"
Height = 15
Left = 29
Top = 21
Width = 72
TabIndex = 7
Name = "CLSETIQUETA1"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Caption = "Cantidad:"
Height = 15
Left = 578
Top = 21
Width = 72
TabIndex = 8
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: sel_articulo
************************************************************
*** PROPIEDADES ***
Top = 16
Left = 86
TabIndex = 1
nombre_campo_codigo = codArt
nombre_campo_desc = descripcio
nombre_tabla = articulos
pkfield = idArticulo
Name = "sel_articulo"
TXTCODIGO.Name = "TXTCODIGO"
TXTDESCRIPCION.Name = "TXTDESCRIPCION"

*** METODOS ***


************************************************************
OBJETO: txtCantidad
************************************************************
*** PROPIEDADES ***
Left = 638
TabIndex = 2
Top = 18
isnumeric = .T.
Name = "txtCantidad"

*** METODOS ***


************************************************************
OBJETO: btn_agregar
************************************************************
*** PROPIEDADES ***
Top = 12
Left = 918
TabIndex = 3
Name = "btn_agregar"

*** METODOS ***
PROCEDURE Click
****************************
* Agrego detalle de ficha
****************************

IF Thisform.validar_detalle() THEN
	Thisform.oFichaData.agregar_fichadet(Thisform.id_ficha, This.Parent.txtCantidad.Value, This.Parent.sel_articulo.valcpoid, ;
		This.Parent.sel_articulo.txtCodigo.Value, this.Parent.sel_articulo.txtDescripcion.Value, gcCodUsu, SYS(0))
	SELECT curFichaDet
	This.Parent.grd_parches.Refresh()
	
	* Blanqueo los controles
	This.Parent.sel_articulo.blanquear()
	This.Parent.txtCantidad.Value = 0.00
	This.Parent.sel_articulo.txtCodigo.SetFocus()
ENDIF
ENDPROC


************************************************************
OBJETO: btn_eliminar
************************************************************
*** PROPIEDADES ***
Top = 12
Left = 965
TabIndex = 4
Name = "btn_eliminar"

*** METODOS ***


************************************************************
OBJETO: grd_parches
************************************************************
*** PROPIEDADES ***
Height = 327
Left = 23
TabIndex = 5
Top = 59
Width = 986
Name = "grd_parches"
COLUMN1.HEADER1.Name = "HEADER1"
COLUMN1.TEXT1.Name = "TEXT1"
COLUMN1.Name = "COLUMN1"
COLUMN2.HEADER1.Name = "HEADER1"
COLUMN2.TEXT1.Name = "TEXT1"
COLUMN2.Name = "COLUMN2"
COLUMN3.HEADER1.Name = "HEADER1"
COLUMN3.TEXT1.Name = "TEXT1"
COLUMN3.Name = "COLUMN3"
COLUMN4.HEADER1.Name = "HEADER1"
COLUMN4.TEXT1.Name = "TEXT1"
COLUMN4.Name = "COLUMN4"
COLUMN5.HEADER1.Name = "HEADER1"
COLUMN5.TEXT1.Name = "TEXT1"
COLUMN5.Name = "COLUMN5"
COLUMN6.HEADER1.Name = "HEADER1"
COLUMN6.TEXT1.Name = "TEXT1"
COLUMN6.Name = "COLUMN6"
COLUMN7.HEADER1.Name = "HEADER1"
COLUMN7.TEXT1.Name = "TEXT1"
COLUMN7.Name = "COLUMN7"
COLUMN8.HEADER1.Name = "HEADER1"
COLUMN8.TEXT1.Name = "TEXT1"
COLUMN8.Name = "COLUMN8"
COLUMN9.HEADER1.Name = "HEADER1"
COLUMN9.TEXT1.Name = "TEXT1"
COLUMN9.Name = "COLUMN9"
COLUMN10.HEADER1.Name = "HEADER1"
COLUMN10.TEXT1.Name = "TEXT1"
COLUMN10.Name = "COLUMN10"
COLUMN11.HEADER1.Name = "HEADER1"
COLUMN11.TEXT1.Name = "TEXT1"
COLUMN11.Name = "COLUMN11"
COLUMN12.HEADER1.Name = "HEADER1"
COLUMN12.TEXT1.Name = "TEXT1"
COLUMN12.Name = "COLUMN12"
COLUMN13.HEADER1.Name = "HEADER1"
COLUMN13.TEXT1.Name = "TEXT1"
COLUMN13.Name = "COLUMN13"
COLUMN14.HEADER1.Name = "HEADER1"
COLUMN14.TEXT1.Name = "TEXT1"
COLUMN14.Name = "COLUMN14"
COLUMN15.HEADER1.Name = "HEADER1"
COLUMN15.TEXT1.Name = "TEXT1"
COLUMN15.Name = "COLUMN15"
COLUMN16.HEADER1.Name = "HEADER1"
COLUMN16.TEXT1.Name = "TEXT1"
COLUMN16.Name = "COLUMN16"
COLUMN17.HEADER1.Name = "HEADER1"
COLUMN17.TEXT1.Name = "TEXT1"
COLUMN17.Name = "COLUMN17"
COLUMN18.HEADER1.Name = "HEADER1"
COLUMN18.TEXT1.Name = "TEXT1"
COLUMN18.Name = "COLUMN18"
COLUMN19.HEADER1.Name = "HEADER1"
COLUMN19.TEXT1.Name = "TEXT1"
COLUMN19.Name = "COLUMN19"
COLUMN20.HEADER1.Name = "HEADER1"
COLUMN20.TEXT1.Name = "TEXT1"
COLUMN20.Name = "COLUMN20"

*** METODOS ***


************************************************************
OBJETO: Clsetiqueta3
************************************************************
*** PROPIEDADES ***
Caption = "Operador:"
Height = 15
Left = 27
Top = 400
Width = 67
TabIndex = 9
Name = "Clsetiqueta3"

*** METODOS ***


************************************************************
OBJETO: sel_operador
************************************************************
*** PROPIEDADES ***
Top = 396
Left = 107
TabIndex = 6
nombre_tabla = rcn_operad
nombre_campo_codigo = id_operad
nombre_campo_desc = apelnom
pkfield = id_operad
title_cols = Apellido y Nombre(s)
Name = "sel_operador"
TXTCODIGO.Name = "TXTCODIGO"
TXTDESCRIPCION.Name = "TXTDESCRIPCION"

*** METODOS ***


************************************************************
OBJETO: btnGrabar
************************************************************
*** PROPIEDADES ***
Top = 477
Left = 480
Picture = ..\imagen\iconos bajados\disquetes-excepto-icono-7120-32.png
TabIndex = 3
ToolTipText = "Finalizar carga de datos de fichas"
Name = "btnGrabar"

*** METODOS ***
PROCEDURE Click
******************************************************************
* Grabo los datos de la ficha
******************************************************************
Local llOk
Local lnIdEstCra
Local lnIdEstado
Local lnResp

lnIdEstado = 0
lnResp = 0

* Pregunto al usuario si quiere cambiar el estado de la ficha a "finalizado".
IF !Thisform.id_estado_actual = 4 THEN
	lnResp = Messagebox("¿Pasar esta ficha al estado finalizado?", 32+4, Thisform.Caption)
	If lnResp = 6 Then
		lnIdEstado = 3
	ENDIF
ENDIF

Select cur_estcra
Go Thisform.pgf.page4.cbo_escare.ListIndex
lnIdEstCra = cur_estcra.id_estcra
Thisform.oFichaData.id_ventac = Thisform.id_ventasc

llOk = Thisform.oFichaData.actualizar_ficha(Thisform.id_ficha, ;
	Thisform.pgf.page1.sel_motivo_rechazo.valcpoid, ;
	Thisform.pgf.page1.sel_marca.valcpoid, ;
	Thisform.pgf.page1.txt_medida.Value, ;
	Thisform.pgf.page1.txt_nro_serie.Value, ;
	Thisform.pgf.page1.txt_trabajo.Value, ;
	lnIdEstado, ;
	Thisform.pgf.page2.txt_camara_sec_grados.Value, ;
	Thisform.pgf.page1.txt_matricula.Value, ;
	Thisform.pgf.page1.txt_referencia.Value, ;
	estandarizar_checkbox_value(Thisform.pgf.page1.opt_grupo.option1.Value), ;
	estandarizar_checkbox_value(Thisform.pgf.page1.opt_grupo.option2.Value), ;
	estandarizar_checkbox_value(Thisform.pgf.page1.opt_grupo.option3.Value), ;
	estandarizar_checkbox_value(Thisform.pgf.page1.opt_grupo.option4.Value), ;
	Thisform.pgf.page3.txt_radio.Value, ;
	THISFORM.pgf.page3.txt_perimetro.Value, ;
	THISFORM.pgf.page3.txt_ancho.Value, ;
	IIF(Isnull(Thisform.pgf.page2.txt_observaciones.Value), "", Thisform.pgf.page2.txt_observaciones.Value), ;
	estandarizar_checkbox_value(Thisform.pgf.page2.chk_parches_ant.Value), ;
	lnIdEstCra, ;
	THISFORM.pgf.page2.sel_operador.valcpoid, ;
	THISFORM.pgf.page3.sel_operador.valcpoid, ;
	THISFORM.pgf.page3.sel_operador.valcpoid, ;
	THISFORM.pgf.page4.sel_operador_escareacion.valcpoid, ;
	THISFORM.pgf.page5.sel_operador.valcpoid, ;
	ALLTRIM(gcCodUsu), ;
	ALLTRIM(Sys(0)))

If !llOk Then
	Messagebox(Thisform.oFichaData.mensaje, 0+48, Thisform.Caption)
Else
	Messagebox(Thisform.oFichaData.mensaje, 0+64, Thisform.Caption)
Endif

ENDPROC


************************************************************
OBJETO: CLSCERRAR1
************************************************************
*** PROPIEDADES ***
Top = 478
Left = 988
TabIndex = 5
Name = "CLSCERRAR1"

*** METODOS ***


************************************************************
OBJETO: btn_imprimir_ficha
************************************************************
*** PROPIEDADES ***
Top = 477
Left = 432
Picture = ..\imagen\iconos bajados\parametros-icono-6232.ico
TabIndex = 2
ToolTipText = "Imprimir ficha para enviar al taller"
BackColor = 240,240,240
Name = "btn_imprimir_ficha"

*** METODOS ***
PROCEDURE Click
Thisform.imprimir_ficha_completar()
ENDPROC


************************************************************
OBJETO: o_stock
************************************************************
*** PROPIEDADES ***
Top = 480
Left = 108
Height = 17
Width = 23
Name = "o_stock"

*** METODOS ***


************************************************************
OBJETO: btn_reimprimir_ficha
************************************************************
*** PROPIEDADES ***
Top = 477
Left = 545
Picture = ..\imagen\iconos bajados\aha-soft-large-business-printer.ico
TabIndex = 2
ToolTipText = "Reimprimir"
BackColor = 240,240,240
Name = "btn_reimprimir_ficha"

*** METODOS ***
PROCEDURE Click
************************************************************************
* Imprime la ficha a completar
* Fecha: 14/06/2023
************************************************************************
LOCAL lnIdFicha
LOCAL lnIdCliente
LOCAL lcRazonSocial
LOCAL lcNumeroRemito
LOCAL lcDestino
LOCAL lcDireccion
LOCAL ldFechaEntrada
LOCAL lcMarca
LOCAL lnMedida
LOCAL lcNroSerie
LOCAL lcTrabajo

lnIdFicha = Thisform.id_ficha
lnIdCliente = Thisform.pgf.page1.sel_cliente.txtCodigo.Value
lcRazonSocial = Thisform.pgf.page1.sel_cliente.txtDescripcion.Value
lcNumeroRemito = Thisform.pgf.page1.txt_numero_remito.Value
lcDestino = Thisform.pgf.page1.txt_chofer.Value
lcDireccion = ""
ldFechaEntrada = Thisform.pgf.page1.txt_fecha_entrada.Value
lcMarca = Thisform.pgf.page1.sel_marca.txtDescripcion.Value
lnMedida = Thisform.pgf.page1.txt_medida.Value
lcNroSerie = Thisform.pgf.page1.txt_nro_serie.Value
lcTrabajo = Thisform.pgf.page1.txt_trabajo.Value

REPORT FORM rep_rcn_ficha TO PRINTER PROMPT PREVIEW



ENDPROC


************************************************************
OBJETO: oFichaData
************************************************************
*** PROPIEDADES ***
Top = 480
Left = 60
Height = 17
Width = 27
Name = "oFichaData"

*** METODOS ***


************************************************************
OBJETO: cls_form_editar_ficha
************************************************************
*** PROPIEDADES ***
Arial, 0, 8, 5, 14, 11, 29, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0
Arial, 0, 9, 5, 15, 12, 32, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_form_fichas
************************************************************
*** PROPIEDADES ***
Height = 501
Width = 946
DoCreate = .T.
Caption = "Fichas"
MaxButton = .T.
MinButton = .T.
WindowState = 2
Name = "cls_form_fichas"
contenido.Top = -1
contenido.Left = -1
contenido.Name = "contenido"

*** METODOS ***
PROCEDURE llenar_cbo_estados
************************************************************
* Permite llenar el combobox de estados.
* Fecha: 24/05/2023
************************************************************
Thisform.contenido.cboEstados.AddItem("TODOS", 1)

Thisform.oFichaDatos.get_estados()
SELECT cur_estados
GO TOP
DO WHILE !EOF("cur_estados")
	Thisform.contenido.cboEstados.AddItem(cur_estados.descripcio, (cur_estados.id_estado + 1))

	SELECT cur_estados
	SKIP
ENDDO

SELECT cur_estados
GO TOP
Thisform.contenido.cboEstados.ListIndex = 1
ENDPROC
PROCEDURE filtrar_fichas
***********************************************************************
* Permite filtrar las fichas según el estado seleccionado.
* Fecha: 24/05/2023
***********************************************************************
LOCAL lcCriterio

IF Thisform.contenido.cboEstados.ListIndex = 1 THEN
	* Si está seleccionado TODOS, entonces muestro todas las fichas
	* independientemente de su estado.
	lcCriterio = ""
	** Thisform.oFichaDatos.get("")
ELSE
	* Aplico el filtro por el estado de la ficha seleccionada
	SELECT cur_estados
	GO (Thisform.contenido.cboEstados.ListIndex - 1)
	lcCriterio = "est.id_estado = " + ALLTRIM(STR(cur_estados.id_estado)) + " "
	*Thisform.oFichaDatos.get("est.id_estado = " + ALLTRIM(STR(cur_estados.id_estado)))
ENDIF

IF Thisform.contenido.sel_cliente.valcpoid <> 0 THEN
	IF ALLTRIM(lcCriterio) == "" THEN
		lcCriterio = "cli.idCliente = " + ALLTRIM(STR(Thisform.contenido.sel_cliente.valcpoid)) + " "
	ELSE
		lcCriterio = lcCriterio + "AND cli.idCliente = " + ALLTRIM(STR(Thisform.contenido.sel_cliente.valcpoid)) + " "
	ENDIF
ENDIF

Thisform.oFichaDatos.get(lcCriterio)

* Me posiciono en el último registro seleccionado y
* refresco la grilla.
SELECT cur_fichas
IF RECCOUNT("cur_fichas") > 0 THEN
	GO TOP
	Thisform.Contenido.grd_fichas.Refresh()
ENDIF
ENDPROC
PROCEDURE editar_ficha
*************************************************************************
* Permite editar la ficha seleccionada.
* Fecha: 29/05/2023
*************************************************************************
LOCAL loForm

loForm = CREATEOBJECT("cls_form_editar_ficha")
SELECT cur_fichas

If Reccount("cur_fichas") = 0 THEN
	MessageBox("No hay fichas para editar", 0+64, Thisform.Caption)
	Return
EndIf

loForm.id_ficha = cur_fichas.id_ficha
loForm.solo_correccion = .F.
loForm.inicializar_datos()
loForm.show(1)
Thisform.filtrar_fichas()
ENDPROC
PROCEDURE Activate
* Ejecuto el filtrar ficha para que se refresque la grilla
Thisform.filtrar_fichas()
ENDPROC
PROCEDURE Init
************************************************
* Inicializo los componentes del formulario
* Fecha: 24/05/2023
************************************************

Thisform.oFichaDatos.active_connection = goConn.ActiveConnection
Thisform.oFichaDatos.crear_cursores()
Thisform.llenar_cbo_estados()

* Levanto las fichas
Thisform.oFichaDatos.get("")
SELECT cur_fichas
Thisform.Contenido.grd_fichas.alias_name = "cur_fichas"
Thisform.Contenido.grd_fichas.RecordSource = "cur_fichas"
Thisform.Contenido.grd_fichas.list_controlsource = "id_ficha,idCliente,razSoc,fecAlta,destino,numero_remito,estado,marca,medida,nro_serie,trabajo"
Thisform.Contenido.grd_fichas.lista_ancho_cols = "50,50,200,120,120,100,120,120,70,100,200"
Thisform.Contenido.grd_fichas.titulos_cabeceras = "N° Ficha,Cliente,Razón Social,Fecha,Destino,Rto. N°,Estado,Marca,Medida,N° Serie,Trabajo a realizar"
Thisform.Contenido.grd_fichas.permitir_busqueda = .f.
Thisform.Contenido.grd_fichas.permitir_ordenamiento = .f.
Thisform.Contenido.grd_fichas.generar_grid()

ENDPROC


************************************************************
OBJETO: oFichaDatos
************************************************************
*** PROPIEDADES ***
Top = 468
Left = 60
Height = 17
Width = 24
Name = "oFichaDatos"

*** METODOS ***


************************************************************
OBJETO: grd_fichas
************************************************************
*** PROPIEDADES ***
Anchor = 15
Height = 395
Left = 1
TabIndex = 5
Top = 45
Width = 944
Name = "grd_fichas"
COLUMN1.Header1.Name = "Header1"
COLUMN1.Text1.Name = "Text1"
COLUMN1.Name = "COLUMN1"
COLUMN2.Header1.Name = "Header1"
COLUMN2.Text1.Name = "Text1"
COLUMN2.Name = "COLUMN2"
COLUMN3.Header1.Name = "Header1"
COLUMN3.Text1.Name = "Text1"
COLUMN3.Name = "COLUMN3"
COLUMN4.Header1.Name = "Header1"
COLUMN4.Text1.Name = "Text1"
COLUMN4.Name = "COLUMN4"
COLUMN5.Header1.Name = "Header1"
COLUMN5.Text1.Name = "Text1"
COLUMN5.Name = "COLUMN5"
COLUMN6.Header1.Name = "Header1"
COLUMN6.Text1.Name = "Text1"
COLUMN6.Name = "COLUMN6"
COLUMN7.Header1.Name = "Header1"
COLUMN7.Text1.Name = "Text1"
COLUMN7.Name = "COLUMN7"
COLUMN8.Header1.Name = "Header1"
COLUMN8.Text1.Name = "Text1"
COLUMN8.Name = "COLUMN8"
COLUMN9.Header1.Name = "Header1"
COLUMN9.Text1.Name = "Text1"
COLUMN9.Name = "COLUMN9"
COLUMN10.Header1.Name = "Header1"
COLUMN10.Text1.Name = "Text1"
COLUMN10.Name = "COLUMN10"
COLUMN11.Header1.Name = "Header1"
COLUMN11.Text1.Name = "Text1"
COLUMN11.Name = "COLUMN11"
COLUMN12.Header1.Name = "Header1"
COLUMN12.Text1.Name = "Text1"
COLUMN12.Name = "COLUMN12"
COLUMN13.Header1.Name = "Header1"
COLUMN13.Text1.Name = "Text1"
COLUMN13.Name = "COLUMN13"
COLUMN14.Header1.Name = "Header1"
COLUMN14.Text1.Name = "Text1"
COLUMN14.Name = "COLUMN14"
COLUMN15.Header1.Name = "Header1"
COLUMN15.Text1.Name = "Text1"
COLUMN15.Name = "COLUMN15"
COLUMN16.Header1.Name = "Header1"
COLUMN16.Text1.Name = "Text1"
COLUMN16.Name = "COLUMN16"
COLUMN17.Header1.Name = "Header1"
COLUMN17.Text1.Name = "Text1"
COLUMN17.Name = "COLUMN17"
COLUMN18.Header1.Name = "Header1"
COLUMN18.Text1.Name = "Text1"
COLUMN18.Name = "COLUMN18"
COLUMN19.Header1.Name = "Header1"
COLUMN19.Text1.Name = "Text1"
COLUMN19.Name = "COLUMN19"
COLUMN20.Header1.Name = "Header1"
COLUMN20.Text1.Name = "Text1"
COLUMN20.Name = "COLUMN20"

*** METODOS ***


************************************************************
OBJETO: btn_editar
************************************************************
*** PROPIEDADES ***
Top = 446
Left = 745
Anchor = 12
Picture = ..\imagen\edit.ico
TabIndex = 7
Name = "btn_editar"

*** METODOS ***
PROCEDURE Click
Thisform.editar_ficha()
ENDPROC


************************************************************
OBJETO: btn_cerrar
************************************************************
*** PROPIEDADES ***
Top = 446
Left = 899
Anchor = 12
TabIndex = 9
Name = "btn_cerrar"

*** METODOS ***


************************************************************
OBJETO: CLSETIQUETA1
************************************************************
*** PROPIEDADES ***
Anchor = 3
Caption = "Estados:"
Height = 15
Left = 17
Top = 14
Width = 56
TabIndex = 10
Name = "CLSETIQUETA1"

*** METODOS ***


************************************************************
OBJETO: cboEstados
************************************************************
*** PROPIEDADES ***
Anchor = 3
Height = 24
Left = 77
TabIndex = 1
Top = 9
Width = 148
Name = "cboEstados"

*** METODOS ***


************************************************************
OBJETO: btn_generar_rto_entrada
************************************************************
*** PROPIEDADES ***
Top = 446
Left = 696
Anchor = 12
Picture = ..\imagen\iconos bajados\papel-con-contenido-icono-5235.ico
TabIndex = 6
ToolTipText = "Permite generar un remito de entrada"
Name = "btn_generar_rto_entrada"

*** METODOS ***
PROCEDURE Click
**************************************************
* Accede a la pantalla para ingresar remitos
* de entrada.
* Fecha: 22/06/2023
**************************************************
DO FORM frm_rcn_ingreso_remitos

ENDPROC


************************************************************
OBJETO: btn_generar_rto_salida
************************************************************
*** PROPIEDADES ***
Top = 446
Left = 794
Anchor = 12
Picture = ..\imagen\iconos bajados\descargar-caja-de-madera-icono-5941.ico
TabIndex = 8
ToolTipText = "Permite generar el remito de salida"
Name = "btn_generar_rto_salida"

*** METODOS ***
PROCEDURE Click
***************************************************************
* Permite generar el remito de salida.
* Fecha: 24/06/2023
***************************************************************
LOCAL loFormRemitoSalida

loFormRemitoSalida = CREATEOBJECT("cls_form_remito_salida")
loFormRemitoSalida.Show(1)
ENDPROC


************************************************************
OBJETO: btnContarCubiertasPorEstado
************************************************************
*** PROPIEDADES ***
Top = 448
Left = 10
Anchor = 6
Picture = ..\imagen\folder_blue.ico
TabIndex = 11
ToolTipText = "Ver cantidad de cubiertas por estado"
Name = "btnContarCubiertasPorEstado"

*** METODOS ***
PROCEDURE Click
*************************************************************
* Abre el formulario para ver la cantidad de cubiertas
* por estado.
* Fecha: 03/07/2023
*************************************************************
LOCAL loForm

loForm = CREATEOBJECT("cls_form_cantcub_by_estado")
loForm.Show(1)
ENDPROC


************************************************************
OBJETO: Clsetiqueta2
************************************************************
*** PROPIEDADES ***
Anchor = 3
Caption = "Cliente:"
Height = 15
Left = 246
Top = 15
Width = 55
TabIndex = 12
Name = "Clsetiqueta2"

*** METODOS ***


************************************************************
OBJETO: btn_buscar
************************************************************
*** PROPIEDADES ***
Top = 5
Left = 858
Height = 39
Width = 43
Anchor = 9
TabIndex = 3
Name = "btn_buscar"

*** METODOS ***
PROCEDURE Click
************************************************************
* Filtro los registros de la grilla en base a lo seleccionado
* en el combo.
************************************************************
Thisform.filtrar_fichas()
ENDPROC


************************************************************
OBJETO: sel_cliente
************************************************************
*** PROPIEDADES ***
Top = 10
Left = 299
TabIndex = 2
nombre_tabla = clientes
pkfield = idCliente
nombre_campo_codigo = idCliente
nombre_campo_desc = razSoc
title_cols = Razón Social
esnumerico = .T.
Name = "sel_cliente"
TXTCODIGO.Name = "TXTCODIGO"
TXTDESCRIPCION.Name = "TXTDESCRIPCION"

*** METODOS ***


************************************************************
OBJETO: btn_cancelar
************************************************************
*** PROPIEDADES ***
Top = 5
Left = 901
Height = 39
Width = 43
Anchor = 9
TabIndex = 4
ToolTipText = "Cancelar búsqueda"
Name = "btn_cancelar"

*** METODOS ***
PROCEDURE Click
Thisform.Contenido.cboEstados.ListIndex = 1
Thisform.Contenido.sel_cliente.blanquear()
Thisform.Contenido.sel_cliente.valcpoid = 0
THisform.filtrar_fichas()
ENDPROC


************************************************************
OBJETO: cls_form_fichas
************************************************************
*** PROPIEDADES ***
Arial, 0, 9, 5, 15, 12, 32, 3, 0
Arial, 1, 8, 5, 14, 11, 29, 3, 0

*** METODOS ***


************************************************************
OBJETO: cls_fichas_data
************************************************************
*** PROPIEDADES ***
active_connection = 
mensaje = 
id_fichadet = 0
id_ventac = 0
Name = "cls_fichas_data"

*** METODOS ***
PROCEDURE get
*************************************************************
* Permite obtener las fichas cargadas en el sistema.
* Fecha: 24/05/2023
*************************************************************
LPARAMETERS tcFilter

LOCAL lcSql
LOCAL loRes

lcSql = ""

loRes = CREATEOBJECT("odbc_result")
TEXT TO lcSql NOSHOW
	SELECT
	    ficha.id_ficha,
	    rem.id_rtoent,
	    rem.idCliente,
	    cli.razSoc,
	    rem.fecAlta,
	    rem.destino,
	    rem.numero AS 'numero_remito',
	    est.id_estado,
	    est.descripcio AS 'estado',
	    ficha.idmarca,
	    marcas.descripcio AS 'marca',
	    ficha.medida,
	    ficha.nro_serie,
	    ficha.trabajo,
		IFNULL(ficha.camsecgdo, 0) AS 'camsecgdo',
		IFNULL(ficha.matricula, 0) AS 'matricula',
		IFNULL(ficha.referencia, 0) AS 'referencia',
		ficha.vulcaniza,
		ficha.aprobado,
		ficha.aprob_sg,
		ficha.rechazado,
		IFNULL(ficha.id_motrec, 0) AS 'id_motrec',
		motrec.descripcio AS 'motiv_rech',
		IFNULL(ficha.radio, 0) AS 'radio',
		IFNULL(ficha.perimetro, 0) AS 'perimetro',
		IFNULL(ficha.ancho, 0) AS 'ancho',
		ficha.observ,
		ficha.parch_ant,
		IFNULL(ficha.id_estcra, 0) AS 'id_estcra',
		IFNULL(ficha.idop_recep, 0) AS 'idop_recep',
		op_recep.apelnom AS 'op_recep',
		IFNULL(ficha.idop_exapr, 0) AS 'idop_exapr',
		op_exapr.apelnom AS 'op_exapre',
		IFNULL(ficha.idop_rasp, 0) AS 'idop_rasp',
		op_rasp.apelnom AS 'op_rasp',
		IFNULL(ficha.idop_esca, 0) AS 'idop_esca',
		op_esca.apelnom AS 'op_esca',
		IFNULL(ficha.idop_appar, 0) AS 'idop_appar',
		op_appar.apelnom AS 'op_appar',
		CASE WHEN ventascab.idVentasC IS NULL THEN 0 ELSE ventascab.idVentasC END idVentasC,
		CASE WHEN ventascab.idVentasC IS NULL THEN 0 ELSE CONCAT(ventascab.cbte, ' ', ventascab.tipodoc, ' ', REPEAT('0', 5 - LENGTH(ventascab.ptoVta)), ventascab.ptoVta,
			'-', REPEAT('0', 8 - LENGTH(ventascab.numCbte)), ventascab.numCbte) END numero_completo		
	FROM
	    rcn_ficha ficha
			INNER JOIN marcas ON marcas.idmarca = ficha.idmarca
			INNER JOIN rcn_remito rem ON rem.id_rtoent = ficha.id_rtoent
			INNER JOIN rcn_estado est ON est.id_estado = ficha.id_estado
			INNER JOIN clientes cli ON cli.idCliente = rem.idCliente
			LEFT JOIN rcn_motrec motrec ON motrec.id_motrec = ficha.id_motrec
			LEFT JOIN rcn_operad op_recep ON op_recep.id_operad = ficha.idop_recep
			LEFT JOIN rcn_operad op_exapr ON op_exapr.id_operad = ficha.idop_exapr
			LEFT JOIN rcn_operad op_rasp ON op_rasp.id_operad = ficha.idop_rasp
			LEFT JOIN rcn_operad op_esca ON op_esca.id_operad = ficha.idop_esca
			LEFT JOIN rcn_operad op_appar ON op_appar.id_operad = ficha.idop_appar
			LEFT JOIN ventascab ON ventascab.idVentasC = ficha.idVentasC
	WHERE
	    ficha.fecBaja IS NULL
ENDTEXT

* Si viene filtro, lo concateno a la consulta
IF !(ALLTRIM(tcFilter) == "") THEN
	lcSql = lcSql + " AND " + tcFilter
ENDIF

* Establezco el orden de las fichas
lcSql = lcSql + " ORDER BY est.id_estado, rem.idCliente"

loRes.ActiveConnection = this.active_connection
loRes.Cursor_Name = "cur_x"
loRes.OpenQuery(lcSql)

* Verifico si el cursor existe en memoria
If !Used("cur_x") Then
	loRes.close_query()
	Return
EndIF

SELECT cur_fichas
ZAP
APPEND FROM DBF("cur_x")

loRes.close_query()

SELECT cur_fichas
GO TOP
ENDPROC
PROCEDURE crear_cursores
*************************************************************************
* Permite crear los cursores donde se gestionarán los datos en memoria
*************************************************************************

* Armo el cursor que permitirá gestionar las fichas.
CREATE CURSOR cur_fichas ( ;
	id_ficha 		int,;
	id_rtoent 		int,;
	idCliente 		int,;
	razSoc 			varchar(60),;
	fecAlta 		datetime,;
	destino 		varchar(200),;
	numero_remito 	varchar(20),;
	id_estado 		int,;
	estado 			varchar(30),;
	idmarca 		int,;
	marca 			varchar(60),;
	medida 			N(20, 2),;
	nro_serie 		varchar(20),;
	trabajo 		varchar(100),;
	camsecgdo 		N(20, 2) DEFAULT 0.00,;
	matricula		varchar(100) DEFAULT "",;
	referencia		L DEFAULT .F.,;
	vulcaniza		L DEFAULT .F.,;
	aprobado		L DEFAULT .F.,;
	aprob_sg		L DEFAULT .F.,;
	rechazado		L DEFAULT .F.,;
	id_motrec		int DEFAULT 0,;
	motiv_rech		varchar(30) NULL,;
	radio			N(20,2) DEFAULT 0.00,;
	perimetro		N(20,2) DEFAULT 0.00,;
	ancho			N(20,2) DEFAULT 0.00,;
	observ			M NULL,;
	parch_ant		L DEFAULT .F.,;
	id_estcra		int DEFAULT 0,;
	idop_recep		int DEFAULT 0,;
	op_recep		varchar(60) NULL,;
	idop_exapr		int DEFAULT 0,;
	op_exapre		varchar(60) NULL,;
	idop_rasp		int DEFAULT 0,;
	op_rasp			varchar(60) NULL,;
	idop_esca		int DEFAULT 0,;
	op_esca			varchar(60) NULL,;
	idop_appar		int DEFAULT 0,;
	op_appar		varchar(60) NULL,;
	idVentasC		int,;
	numero_completo	varchar(20),;
	sel				L NOT NULL DEFAULT .F.)
	
* Creo el cursor para mostrar los estados en el desplegable.
CREATE CURSOR cur_estados ( ;
	id_estado int,;
	descripcio varchar(60))
	
	
* Creo el cursor para almacenar datos a grabar en rcn_fichasdet
CREATE CURSOR curFichaDet ( ;
	id_fichadet int,;
	id_ficha int,;
	cantidad N(20, 2),;
	idArticulo int,;
	codArt varchar(20),;
	descripcio varchar(200),;
	usuario varchar(5),;
	idHost varchar(50))

* Estados de crácteres
CREATE CURSOR cur_estcra ( ;
	id_estcra int,;
	descripcio varchar(30))
	
* Cursor para cantidad de cubiertas por estado
CREATE CURSOR cur_cantcub (	;
    idcliente N(10, 0),		;
    razsoc C(50),			;
    pendiente N(10, 0),		;
    en_proceso N(10, 0),	;
    finalizado N(10, 0),	;
    entregado N(10, 0),		;
    totalizado N(10, 0))
       
* Cursor para guardar las ventas
CREATE CURSOR curSelFactura ( ;
	idVentasC int ,;
	fecEmision date,;
	cbte varchar(3),;
	tipoDoc varchar(1),;
	ptoVta varchar(5),;
	numero varchar(98))
ENDPROC
PROCEDURE get_estados
******************************************************
* Permite recuperar los estados.
* Fecha: 24/05/2023
******************************************************
LOCAL lcSql
LOCAL loRes

loRes = CREATEOBJECT("odbc_result")
lcSql = ""

TEXT TO lcSql NOSHOW
	SELECT
		id_estado,
		descripcio
	FROM
		rcn_estado
	WHERE
		rcn_estado.fecBaja IS NULL
ENDTEXT

loRes.ActiveConnection = this.active_connection
loRes.Cursor_Name = "cur_x"
loRes.OpenQuery(lcSql)
SELECT cur_estados
APPEND FROM DBF("cur_x")
loRes.Close_Query()

SELECT cur_estados
GO TOP
ENDPROC
PROCEDURE actualizar_ficha
************************************************************
* Permite actualizar los datos de una ficha.
************************************************************
LPARAMETERS tnidFicha, tnid_motrec, tnidMarca, tnMedida, tcNroSerie, tcTrabajo, ;
	tnid_estado, tncamsecgdo, tcMatricula, tnReferencia, tlVuncaniza, tlAprobado, ; 
	tlAprovSG, tlRechazado, tnRadio, tnPerimetro, tnAncho, tcObserv,;
	tnParchAnt, tnId_EstCra, tnIdOp_Repec, tnIdOp_ExaPr,;
	tnIdOp_Rasp, tnIdOp_esca, tnIdOp_Appar, tcUsuario, ;
	tcHost
	
LOCAL loRes
LOCAL loCmd
LOCAL lcSql

* Paso los ítems del cursor a temporal

* Paso 1: Limpio la tabla temporal
loCmd = CREATEOBJECT("odbc_command")
loCmd.ActiveConnection = this.active_connection
TEXT TO loCmd.CommandText NOSHOW
	CALL rcn_limpiar_aux_fichadet(?xusuario, ?xhost)
ENDTEXT
loCmd.AddParameter("xusuario", ALLTRIM(tcUsuario), .t., .f.)
loCmd.AddParameter("xhost", ALLTRIM(tcHost), .t., .f.)
IF !loCmd.Execute() THEN
	This.mensaje = "Error al limpiar la tabla auxiliar rcn_aux_fichadet"
	RETURN .F.
ENDIF

* Paso 2: Cargo los registros del cursor en la tabla tempora rcn_aux_fichadet
SELECT curFichaDet
GO TOP
DO WHILE !EOF("curFichaDet")
	TEXT TO loCmd.CommandText NOSHOW
		CALL rcn_insert_aux_fichadet (
			?xidFicha, ?xcantidad, ?xidArticulo, ?xcodArt, 
			?xdescripcion, ?xusuario, ?xhost)
	ENDTEXT
	loCmd.AddParameter("xidFicha", ALLTRIM(STR(curFichaDet.id_ficha)), .f., .f.)
	loCmd.AddParameter("xcantidad", ALLTRIM(STR(curFichaDet.cantidad, 20, 2)), .f., .f.)
	loCmd.AddParameter("xidArticulo", ALLTRIM(STR(curFichaDet.idArticulo)), .f., .f.)
	loCmd.AddParameter("xcodArt", ALLTRIM(curFichaDet.codArt), .t., .f.)
	loCmd.AddParameter("xdescripcion", ALLTRIM(curFichaDet.descripcio), .t., .f.)
	loCmd.AddParameter("xusuario", ALLTRIM(curFichaDet.usuario), .t., .f.)
	loCmd.AddParameter("xhost", ALLTRIM(curFichaDet.idHost), .t., .f.)
	IF !loCmd.Execute() THEN
		This.mensaje = "Error al insertar detalle en temporal rcn_aux_fichadet"
		RETURN .F.
	ENDIF
	
	SELECT curFichaDet
	SKIP
ENDDO

SELECT curFichaDet
GO TOP

* Paso 3: Grabo los datos de la ficha
loRes = CREATEOBJECT("odbc_result")
TEXT TO lcSql NOSHOW
	CALL rcn_update_ficha (
    ?xidFicha, ?xid_motrec, ?xidmarca, ?xmedida, ?xnroserie, ?xtrabajo, ?xidestado, ?xcamsecgdo,
    ?xmatricula, ?xreferencia, ?xvulcaniza, ?xaprobado,
    ?xaprob_sg, ?xrechazado, ?xradio, ?xperimetro,
    ?xancho, ?xobserv, ?xparch_ant, ?xidestcra,
    ?xidop_recep, ?xidop_exapr, ?xidop_rasp, ?xidop_esca,
    ?xidop_appar, ?xusuario, ?xidHost, ?xidVentasC)
ENDTEXT

lcSql = loRes.AddParameter(lcSql, 'xidFicha', ALLTRIM(STR(tnIdFicha)), .F., .F.)
lcSql = loRes.AddParameter(lcSql, 'xid_motrec', ALLTRIM(STR(tnid_motrec)), .F., .F.)
lcSql = loRes.AddParameter(lcSql, "xidmarca", ALLTRIM(STR(tnidMarca)), .F., .F.)
lcSql = loRes.AddParameter(lcSql, "xmedida", ALLTRIM(STR(tnMedida, 20, 2)), .F., .F.)
lcSql = loRes.AddParameter(lcSql, "xnroserie", ALLTRIM(tcNroSerie), .T., .F.)
lcSql = loRes.AddParameter(lcSql, "xtrabajo", ALLTRIM(tcTrabajo), .T., .F.)
lcSql = loRes.AddParameter(lcSql, 'xidestado', ALLTRIM(STR(tnid_estado)), .F., .F.)
lcSql = loRes.AddParameter(lcSql, 'xcamsecgdo', ALLTRIM(STR(tncamsecgdo)), .F., .F.)
lcSql = loRes.AddParameter(lcSql, 'xmatricula', ALLTRIM(tcMatricula), .T., .F.)
lcSql = loRes.AddParameter(lcSql, 'xreferencia', ALLTRIM(STR(tnReferencia)), .F., .F.)
lcSql = loRes.AddParameter(lcSql, 'xvulcaniza', ALLTRIM(STR(tlVuncaniza)), .F., .F.)
lcSql = loRes.AddParameter(lcSql, 'xaprobado', ALLTRIM(STR(tlAprobado)), .F., .F.)
lcSql = loRes.AddParameter(lcSql, 'xaprob_sg', ALLTRIM(STR(tlAprovSG)), .F., .F.)
lcSql = loRes.AddParameter(lcSql, 'xrechazado', ALLTRIM(STR(tlRechazado)), .F., .F.)
lcSql = loRes.AddParameter(lcSql, 'xradio', ALLTRIM(STR(tnRadio)), .F., .F.)
lcSql = loRes.AddParameter(lcSql, 'xperimetro', ALLTRIM(STR(tnPerimetro)), .F., .F.)
lcSql = loRes.AddParameter(lcSql, 'xancho', ALLTRIM(STR(tnAncho)), .F., .F.)
lcSql = loRes.AddParameter(lcSql, 'xobserv', ALLTRIM(tcObserv), .T., .F.)
lcSql = loRes.AddParameter(lcSql, 'xparch_ant', ALLTRIM(STR(tnParchAnt)), .F., .F.)
lcSql = loRes.AddParameter(lcSql, 'xidestcra', ALLTRIM(STR(tnId_EstCra)), .F., .F.)
lcSql = loRes.AddParameter(lcSql, 'xidop_recep', ALLTRIM(STR(tnIdOp_Repec)), .F., .F.)
lcSql = loRes.AddParameter(lcSql, 'xidop_exapr', ALLTRIM(STR(tnIdOp_ExaPr)), .F., .F.)
lcSql = loRes.AddParameter(lcSql, 'xidop_rasp', ALLTRIM(STR(tnIdOp_Rasp)), .F., .F.)
lcSql = loRes.AddParameter(lcSql, 'xidop_esca', ALLTRIM(STR(tnIdOp_esca)), .F., .F.)
lcSql = loRes.AddParameter(lcSql, 'xidop_appar', ALLTRIM(STR(tnIdOp_Appar)), .F., .F.)
lcSql = loRes.AddParameter(lcSql, 'xusuario', ALLTRIM(tcUsuario), .T., .F.)
lcSql = loRes.AddParameter(lcSql, 'xidHost', ALLTRIM(tcHost), .T., .F.)
lcSql = loRes.AddParameter(lcSql, 'xidVentasC', ALLTRIM(STR(this.id_ventac)), .F., .F.)

loRes.ActiveConnection = this.active_connection
loRes.Cursor_Name = "curResult"

loRes.OpenQuery(lcSql)

SELECT curResult
This.mensaje = curResult.mensaje
IF curResult.result = 0 THEN
	RETURN .F.
ENDIF

loRes.Close_Query()

RETURN .T.
ENDPROC
PROCEDURE get_estados_cracter
******************************************************************
* Permite obtener los estados de crácteres
******************************************************************

LOCAL loRes
LOCAL lcSql

loRes = CREATEOBJECT("odbc_result")

TEXT TO lcSql NOSHOW
	SELECT 
		id_estcra,
		descripcio
	FROM 
		rcn_estcra
	WHERE
		rcn_estcra.fecBaja IS NULL
ENDTEXT

loRes.ActiveConnection = this.active_connection
loRes.Cursor_Name = "cur_x"
loRes.OpenQuery(lcSql)
SELECT cur_estcra
APPEND FROM DBF("cur_x")
loRes.Close_Query()
ENDPROC
PROCEDURE cambiar_estado
*************************************************************
* Permite cambiar el estado de una ficha
* Fecha: 19/06/2023
*************************************************************
LPARAMETERS tnIdFicha, tnIdEstado

LOCAL loCmd

loCmd = CREATEOBJECT("odbc_command")
TEXT TO loCmd.CommandText NOSHOW
	UPDATE
		rcn_ficha
	SET
		rcn_ficha.id_estado = ?xidEstado
	WHERE
		rcn_ficha.id_ficha = ?xidFicha
ENDTEXT

loCmd.AddParameter("xidEstado", ALLTRIM(STR(tnIdEstado)), .f., .f.)
loCmd.AddParameter("xidFicha", ALLTRIM(STR(tnIdFicha)), .f., .f.)
loCmd.ActiveConnection = goConn.ActiveConnection
IF !loCmd.Execute() THEN
	This.mensaje = loCmd.ErrorMessage
	RETURN .F.
ENDIF

RETURN .T.


ENDPROC
PROCEDURE agregar_fichadet
******************************************************************
* Permite agregar el detalle de la ficha al cursor con los
* artículos cargados.
* Fecha: 21/06/2023
******************************************************************
LPARAMETERS tnIdFicha, tnCantidad, tnIdArticulo, tcCodArt, tcDescripcio, tcUsuario, tcHost

LOCAL lcSql

This.id_fichadet = This.id_fichadet + 1

SELECT curFichaDet
INSERT INTO curFichaDet (	;
	id_fichadet, id_ficha, cantidad, idArticulo, ;
	codArt, descripcio, usuario, idHost) ;
VALUES ( ;
	This.id_fichadet, tnIdFicha, tnCantidad, tnIdArticulo, ;
	ALLTRIM(tcCodArt), ALLTRIM(tcDescripcio), ALLTRIM(tcUsuario), ALLTRIM(tcHost))



ENDPROC
PROCEDURE get_ficha_detalle
******************************************************
* Permite recuperar el detalle de una ficha.
* Fecha: 21/06/2023
******************************************************
LPARAMETERS tnIdFicha

LOCAL loRes
LOCAL lcSql

loRes = CREATEOBJECT("odbc_result")
loRes.ActiveConnection = goConn.ActiveConnection

TEXT TO lcSql NOSHOW
	SELECT
		id_fichadet, id_ficha, cantidad, idArticulo,
		codArt, descripcio, usuAlta AS 'usuario', idHostAlta AS 'idHost'
	FROM
		rcn_fichadet rfd
	WHERE
		rfd.id_ficha = ?xidFicha
ENDTEXT

lcSql = loRes.AddParameter(lcsql, "xidFicha", ALLTRIM(STR(tnIdFicha)), .f., .f.)
loRes.Cursor_Name = "cur_x"
loRes.OpenQuery(lcSql)

SELECT curFichaDet
APPEND FROM DBF("cur_x")

loRes.Close_Query()

SELECT curFichaDet
GO TOP

This.id_fichadet = RECCOUNT("curFichaDet")

ENDPROC
PROCEDURE get_clientes_rsalida
*******************************************************************
* Obtiene los clientes con remitos de salidas pendientes
* de entregar
* Fecha: 22/06/2023
*******************************************************************
LOCAL loRes
LOCAL lcSql

loRes = CREATEOBJECT("odbc_result")
TEXT TO lcSql NOSHOW
	SELECT
	 c.idCliente,
	 MAX(rr.id_rtoent) AS id_rtoent,
	 c.razSoc,
	 COUNT(*) AS 'cant_cubie'
	FROM
	 rcn_ficha rf
	   INNER JOIN rcn_remito rr ON rf.id_rtoent = rr.id_rtoent
	   INNER JOIN clientes c ON rr.idCliente = c.idCliente
	WHERE
	 rf.id_estado = 3 AND
	 rr.id_tiporto = 1
	GROUP BY
	 c.idCliente
	ORDER BY
	 c.idCliente
ENDTEXT
loRes.ActiveConnection = this.active_connection
loRes.Cursor_Name = "cur_x"
loRes.OpenQuery(lcSql)
SELECT cur_clientes
APPEND FROM DBF("cur_x")
loRes.Close_Query()

SELECT cur_clientes
GO TOP
ENDPROC
PROCEDURE crear_cursores_remitos_salidas
***************************************************
* Crea los cursores que necesito para el remito
* de salida.
* Fecha: 22/06/2023
***************************************************

CREATE CURSOR cur_clientes ( ;
	idCliente int NOT NULL,;
	id_rtoent int NOT NULL,;
	razSoc varchar(60) NOT NULL,;
	cant_cubie N(20) NOT NULL)

SELECT cur_clientes
INDEX ON cur_clientes.razSoc TAG razSoc ASCENDING
INDEX ON cur_clientes.cant_cubie TAG cant_cubie ASCENDING
INDEX ON cur_clientes.idCliente TAG idCliente ASCENDING
	
CREATE CURSOR cur_repsal ( ;
	id_ficha N(20),;
	numero varchar(20),;
	destino varchar(200),;
	medida N(20, 2),;
	marca varchar(60),;
	motrec varchar(30),;
	nro_serie varchar(20) NULL,;
	trabajo varchar(100) NULL)
	
SELECT cur_repsal
INDEX ON cur_repsal.id_ficha TAG id_ficha ASCENDING
ENDPROC
PROCEDURE generar_remito_salida
*******************************************************
* Permite generar el remito de salida.
* Fecha: 22/06/2023
*******************************************************
LPARAMETERS tnIdCliente, tnIdRto, tcObservaciones, tcUsuario, tcHost

LOCAL loCmd
LOCAL loRes
LOCAL lcSql
LOCAL lnIdremito

loCmd = CREATEOBJECT("odbc_command")

* Limpio la tabla temporal
loCmd.CommandText = "DELETE FROM rcn_aux_fichas_rtosal WHERE host = ?xhost AND usuario = ?xusuario"
loCmd.AddParameter("xhost", ALLTRIM(tcHost), .t., .f.)
loCmd.AddParameter("xusuario", ALLTRIM(tcUsuario), .t., .f.)
loCmd.ActiveConnection = goConn.ActiveConnection
IF !loCmd.Execute() THEN
	This.Mensaje = loCmd.ErrorMessage
	RETURN -1
ENDIF

* Paso las fichas seleccionadas a la tabla temporal
* para generar los remitos de salidas
SELECT cur_fichas
GO TOP
DO WHILE !EOF("cur_fichas")
	IF cur_fichas.sel THEN
		TEXT TO loCmd.CommandText NOSHOW
			INSERT INTO rcn_aux_fichas_rtosal (
				id_ficha, usuario, host)
			VALUE (
				?xidFicha, ?xusuario, ?xhost)
		ENDTEXT
		loCmd.AddParameter("xidFicha", ALLTRIM(STR(cur_fichas.id_ficha)), .f., .f.)
		loCmd.AddParameter("xusuario", ALLTRIM(tcUsuario), .T., .F.)
		loCmd.AddParameter("xhost", ALLTRIM(tcHost), .T., .F.)
		
		loCmd.ActiveConnection = goConn.ActiveConnection
		
		IF !loCmd.Execute() THEN
			This.Mensaje = loCmd.ErrorMessage
			RETURN -1
		ENDIF
	ENDIF

	SELECT cur_fichas
	SKIP
ENDDO

loRes = CREATEOBJECT("odbc_result")
TEXT TO lcSql NOSHOW
	CALL rcn_generar_remito_salida (
		?xidCliente,
		?xid_rtoent,
		?xobservaciones,
		?xusuario,
		?xhost)
ENDTEXT

lcSql = loRes.AddParameter(lcSql, "xidCliente", ALLTRIM(STR(tnIdCliente)), .F., .F.)
lcSql = loRes.AddParameter(lcSql, "xid_rtoent", ALLTRIM(STR(tnIdRto)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "xobservaciones", ALLTRIM(tcObservaciones), .T., .F.)
lcSql = loRes.AddParameter(lcSql, "xusuario", ALLTRIM(tcUsuario), .T., .F.)
lcSql = loRes.AddParameter(lcSql, "xhost", ALLTRIM(tcHost), .T., .F.)

* Continuar desarrollando la ejecución.
loRes.ActiveConnection = This.active_connection
loRes.Cursor_Name = "cur_result"
loRes.OpenQuery(lcSql)

SELECT cur_result
this.mensaje = cur_result.mensaje
lnIdRemito = cur_result.id_rtosal
loRes.Close_Query()

RETURN lnIdRemito


ENDPROC
PROCEDURE get_fichas_rto_sal
************************************************************************************
* Obtiene los datos del remito de salida para imprimir en el informe.
* Fecha: 03/07/2023
************************************************************************************
LPARAMETERS tnIdCliente, tnIdRemito

LOCAL lcSql
LOCAL loRes

loRes = CREATEOBJECT("odbc_result")
TEXT TO lcSql NOSHOW
	SELECT
	  	c.idCliente,
	  	c.razSoc,
	  	rr.numero,
	  	rr.destino,
	  	rr.fecAlta,
	  	rf.*,
	  	m.descripcio AS 'marca',
		IFNULL(rm.descripcio, '') AS 'motrec'
	FROM
	  rcn_remito rr
	    INNER JOIN clientes c ON rr.idCliente = c.idCliente
	    INNER JOIN rcn_ficha rf ON rr.id_rtoent = rf.id_rtosal
	    INNER JOIN marcas m ON rf.idmarca = m.idmarca
	    LEFT JOIN rcn_motrec rm ON rf.id_motrec = rm.id_motrec
	WHERE
	  rf.id_estado = 4 AND
	  rr.idCliente = ?xidCliente AND
	  rr.id_rtoent = ?xidRemito
	ORDER BY
		rf.id_ficha
ENDTEXT

lcSql = loRes.AddParameter(lcSql, "xidCliente", ALLTRIM(STR(tnIdCliente)), .f., .f.)
lcSql = loRes.AddParameter(lcSql, "xidRemito", ALLTRIM(STR(tnIdRemito)), .f., .f.)
loRes.ActiveConnection = this.active_connection
loRes.Cursor_Name = "cur_x"
loRes.OpenQuery(lcSql)
SELECT cur_x
GO TOP
DO WHILE !EOF("cur_x")
	SELECT cur_repsal
	APPEND BLANK
	REPLACE cur_repsal.id_ficha WITH INT(VAL(cur_x.id_ficha))
	REPLACE cur_repsal.numero WITH ALLTRIM(cur_x.numero)
	REPLACE cur_repsal.destino WITH ALLTRIM(cur_x.destino) ADDITIVE
	REPLACE cur_repsal.medida WITH cur_x.medida ADDITIVE
	REPLACE cur_repsal.marca WITH ALLTRIM(cur_x.marca) ADDITIVE
	REPLACE cur_repsal.motrec WITH ALLTRIM(cur_x.motrec) ADDITIVE
	REPLACE cur_repsal.nro_serie WITH cur_x.nro_serie ADDITIVE
	REPLACE cur_repsal.trabajo WITH cur_x.trabajo ADDITIVE
	
	SELECT cur_x
	SKIP
ENDDO

loRes.Close_Query()

SELECT cur_repsal
GO TOP
ENDPROC
PROCEDURE get_cant_cubieras_by_estado
******************************************************************
* Obtiene la cantidad de cubiertas por estado.
* Fecha: 03/07/2023
******************************************************************
LOCAL lcSql
LOCAL loRes

loRes = CREATEOBJECT("odbc_result")
TEXT TO lcSql NOSHOW
	SELECT
	  idcliente,
	  razsoc,
	  IFNULL(MAX(CASE WHEN estado = 'PENDIENTE' THEN cantidad END), 0) AS pendiente,
	  IFNULL(MAX(CASE WHEN estado = 'EN PROCESO' THEN cantidad END), 0) AS en_proceso,
	  IFNULL(MAX(CASE WHEN estado = 'FINALIZADO' THEN cantidad END), 0) AS finalizado,
	  IFNULL(MAX(CASE WHEN estado = 'ENTREGADO' THEN cantidad END), 0) AS entregado,
	  (IFNULL(MAX(CASE WHEN estado = 'PENDIENTE' THEN cantidad END), 0) +
	   IFNULL(MAX(CASE WHEN estado = 'EN PROCESO' THEN cantidad END), 0) +
	   IFNULL(MAX(CASE WHEN estado = 'FINALIZADO' THEN cantidad END), 0)) AS totalizado
	FROM
	  (
	    SELECT
	      rr.idCliente,
	      c.razSoc,
	      re.descripcio AS estado,
	      COUNT(*) AS cantidad
	    FROM
	      rcn_ficha rf
	      INNER JOIN rcn_estado re ON rf.id_estado = re.id_estado
	      INNER JOIN rcn_remito rr ON rf.id_rtoent = rr.id_rtoent
	      INNER JOIN clientes c ON rr.idCliente = c.idCliente
	    GROUP BY
	      rr.idCliente,
	      c.razSoc,
	      re.descripcio
	  ) AS subquery
	GROUP BY
	  idcliente, razsoc
	ORDER BY
	  CASE estado
	    WHEN 'PENDIENTE' THEN 1
	    WHEN 'EN PROCESO' THEN 2
	    WHEN 'FINALIZADO' THEN 3
	    ELSE 4
	  END,
	  idcliente;
ENDTEXT
loRes.ActiveConnection = this.active_connection
loRes.Cursor_Name = "cur_x"
loRes.OpenQuery(lcSql)

SELECT cur_cantcub
ZAP
APPEND FROM DBF("cur_x")

loRes.Close_Query()
ENDPROC
PROCEDURE get_ventas_by_cliente
**********************************************************
* Permite recuperar las facturas por cliente.
**********************************************************
LPARAMETERS lnIdCliente

LOCAL loRes
LOCAL lcSql

loRes = CREATEOBJECT("odbc_result")
TEXT TO lcSql NOSHOW
	CALL ventascab_getFacturasByCliente (?xidCliente)
ENDTEXT
lcSql = loRes.AddParameter(lcSql, "xidCliente", ALLTRIM(STR(lnIdCliente)), .f., .f.)
loRes.ActiveConnection = goConn.ActiveConnection
loRes.Cursor_Name = "cur_x"
loRes.OpenQuery(lcSql)

SELECT curSelFactura
ZAP
APPEND FROM DBF("cur_x")

loRes.Close_Query()

SELECT curSelFactura
GO TOP
ENDPROC


