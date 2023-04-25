*&---------------------------------------------------------------------*
*& Report  ZTRWC_TESTE_UPLOAD
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT ztrwc_teste_upload.

*&---------------------------------------------------------------------*
*                              Types                                   *
*&---------------------------------------------------------------------*

*------* ty_arquivo
TYPES:BEGIN OF ty_arquivo,
        linha(2000) TYPE c,
      END OF ty_arquivo,

*------* ty_out
      BEGIN OF ty_out,
        ebeln TYPE ekko-ebeln, "Contrato (Contrato informado na tela de seleção)
        ematn TYPE ekpo-ematn, "Material (Material informado no arquivo)
        netpr TYPE ekpo-netpr, "Preço líquido (Preço informado no arquivo)
        mwskz TYPE ekpo-mwskz, "IVA (IVA informado no arquivo)
        labnr TYPE ekpo-labnr, "Número do processo (Numero informado no arquivo)
      END OF ty_out.

*&---------------------------------------------------------------------*
*                        Tabelas  Internas                             *
*&---------------------------------------------------------------------*
DATA: it_arquivo TYPE TABLE OF ty_arquivo,
      it_out     TYPE TABLE OF ty_out.

*&---------------------------------------------------------------------*
*                            Workareas                                 *
*&---------------------------------------------------------------------*
DATA: wa_arquivo TYPE ty_arquivo,
      wa_out     TYPE ty_out.

*&---------------------------------------------------------------------*
*                            Variaveis                                 *
*&---------------------------------------------------------------------*
*------* VARIÁVEIS PARA O POPUP DE SELEÇÃO DE ARQUIVOS
DATA: it_files TYPE filetable,
      wa_files TYPE file_table,
      vg_rc    TYPE i.

*&---------------------------------------------------------------------*
*                         Tela de seleção                              *
*&---------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK b0 WITH FRAME TITLE text-000.
PARAMETERS: p_ebeln TYPE ekko-ebeln. "Contrato: Nº do documento de compras
SELECTION-SCREEN END OF BLOCK b0.
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-001.
PARAMETERS: p_file(1024) TYPE c. "OBLIGATORY. "Caminho do Arquivo para Upload
SELECTION-SCREEN END OF BLOCK b1.

*Evento caminho de upload
AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_file.
  PERFORM zf_exibe_popup_caminho_upload.

*Início da execusão
START-OF-SELECTION.
  IF  p_file IS INITIAL.
    MESSAGE 'Insira o caminho do upload do arquivo!' TYPE 'S' DISPLAY LIKE 'E'.
  ELSE.
    PERFORM: zf_gui_upload,
             zf_split_upload.
  ENDIF.

*&---------------------------------------------------------------------*
*&      Form  ZF_EXIBE_POPUP_CAMINHO_UPLOAD
*&---------------------------------------------------------------------*
FORM zf_exibe_popup_caminho_upload .

  CALL METHOD cl_gui_frontend_services=>file_open_dialog
    CHANGING
      file_table              = it_files
      rc                      = vg_rc
    EXCEPTIONS
      file_open_dialog_failed = 1
      cntl_error              = 2
      error_no_gui            = 3
      not_supported_by_gui    = 4
      OTHERS                  = 5.

  IF sy-subrc NE 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
    WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ELSE.
    READ TABLE it_files INTO wa_files INDEX 1.
    p_file = wa_files-filename.
  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*                          zf_gui_upload                               *
*&---------------------------------------------------------------------*
FORM  zf_gui_upload.

  DATA vl_file  TYPE string.

  vl_file = p_file.

  CALL FUNCTION 'GUI_UPLOAD'
    EXPORTING
      filename                = vl_file
      filetype                = 'ASC'
    TABLES
      data_tab                = it_arquivo
    EXCEPTIONS
      file_open_error         = 1
      file_read_error         = 2
      no_batch                = 3
      gui_refuse_filetransfer = 4
      invalid_type            = 5
      no_authority            = 6
      unknown_error           = 7
      bad_data_format         = 8
      header_not_allowed      = 9
      separator_not_allowed   = 10
      header_too_long         = 11
      unknown_dp_error        = 12
      access_denied           = 13
      dp_out_of_memory        = 14
      disk_full               = 15
      dp_timeout              = 16
      OTHERS                  = 17.

  IF sy-subrc <> 0.
    MESSAGE 'Erro no upload!' TYPE 'S' DISPLAY LIKE 'E'.
  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  zf_split_upload
*&---------------------------------------------------------------------*
FORM zf_split_upload.
  DATA: vl_netpr(11) TYPE c.

  IF it_arquivo[] IS NOT INITIAL.
    LOOP AT it_arquivo INTO wa_arquivo.
*--* Início *--* Ignora a primeira linha do arquivo CSV do upload.
      IF sy-tabix EQ '1'.
        CONTINUE.
      ENDIF.
*--* Fim *--*
      SPLIT wa_arquivo-linha AT ';' INTO
                                    wa_out-ematn
                                    vl_netpr
                                    wa_out-mwskz
                                    wa_out-labnr.
      wa_out-netpr = vl_netpr.
      wa_out-ebeln = p_ebeln.

      APPEND wa_out TO it_out.
      CLEAR  wa_out.
    ENDLOOP.
  ENDIF.

ENDFORM.
