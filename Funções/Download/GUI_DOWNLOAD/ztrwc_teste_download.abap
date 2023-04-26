REPORT ztrwc_teste_download.

*&---------------------------------------------------------------------*
*                                 TYPES                                *
*&---------------------------------------------------------------------*
TYPES: BEGIN OF ty_download,
         linha(2000) TYPE c,
       END   OF ty_download.

*&---------------------------------------------------------------------*
*                            Tabelas                                   *
*&---------------------------------------------------------------------*
TABLES: ztaula_curso.

*&---------------------------------------------------------------------*
*                        Tabelas  Internas                             *
*&---------------------------------------------------------------------*
DATA: it_ztaula_curso TYPE TABLE OF ztaula_curso,
      t_download      TYPE TABLE OF ty_download.

*&---------------------------------------------------------------------*
*                            Workareas                                 *
*&---------------------------------------------------------------------*
DATA: wa_ztaula_curso LIKE LINE OF it_ztaula_curso,
      wa_download     TYPE ty_download.

*&---------------------------------------------------------------------*
*                     Declaração de Tipos ALV                          *
*&---------------------------------------------------------------------*
TYPE-POOLS: slis.  "Preciso declarar essa estrutura para fucionar o ALV

*&---------------------------------------------------------------------*
*                            Variaveis                                 *
*&---------------------------------------------------------------------*
*------* VARIÁVEIS PARA O DOWLOAD
DATA: vg_arqv     LIKE rlgrap-filename,
      vg_filename TYPE string.


*&---------------------------------------------------------------------*
*                         Tela de seleção                              *
*&---------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK b0 WITH FRAME TITLE text-000.
SELECT-OPTIONS: s_curso FOR ztaula_curso-nome_curso NO INTERVALS.

PARAMETERS: rb_alv  RADIOBUTTON GROUP g2 DEFAULT 'X' USER-COMMAND cmd,
            rb_dwld RADIOBUTTON GROUP g2.

PARAMETERS: p_dwld LIKE rlgrap-filename.
SELECTION-SCREEN END OF BLOCK b0.

*Para trazer o caminho do download
AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_dwld.
  PERFORM zf_seleciona_diretorio.

*Início da execusão
START-OF-SELECTION.
  PERFORM: zf_select.

*&---------------------------------------------------------------------*
*&      Form  ZF_SELECT
*&---------------------------------------------------------------------*
FORM zf_select.

  SELECT *
  FROM ztaula_curso
  INTO TABLE it_ztaula_curso[]
  WHERE nome_curso IN s_curso[].

  IF sy-subrc NE 0.
    MESSAGE s398(00) WITH 'Não há registros!' DISPLAY LIKE 'E'.
    LEAVE TO SCREEN 0.
  ENDIF.

  IF rb_alv = 'X'.
    PERFORM zf_visualiza_alv_basico.
  ELSE.
    PERFORM zf_prepara_download.
  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  zf_seleciona_diretorio
*&---------------------------------------------------------------------*
FORM zf_seleciona_diretorio.

*Search help para selecionar um directorio.
  DATA: path_str TYPE string.

  CALL METHOD cl_gui_frontend_services=>directory_browse
    EXPORTING
      window_title    = 'Selecione Diretório'
    CHANGING
      selected_folder = path_str
    EXCEPTIONS
      cntl_error      = 1.

  p_dwld = path_str.

ENDFORM.

FORM zf_prepara_download.
  DATA: vl_dt_inicio(8) TYPE c, "Crio variáveis do tipo string para receber dados numéricos
        vl_dt_fim(8)    TYPE c.

  LOOP AT it_ztaula_curso INTO wa_ztaula_curso.

    vl_dt_inicio = wa_ztaula_curso-dt_inicio.  "As variáveis que eram numéricas se tornam strings
    vl_dt_fim    = wa_ztaula_curso-dt_fim.

*--* Início *--* Cria cabeçalho.
    IF sy-tabix EQ '1'.
      CONCATENATE 'Nome do Curso'
                  'Data de Início'
                  'Data Fim'
                  'Ativo'
                  INTO  wa_download-linha SEPARATED BY ';'.

      APPEND wa_download TO t_download.
      CLEAR  wa_download.
    ENDIF.
*--* Fim *--*

    CONCATENATE wa_ztaula_curso-nome_curso "Concatenate só aceita strings
                vl_dt_inicio
                vl_dt_fim
                wa_ztaula_curso-ativo
                INTO  wa_download-linha SEPARATED BY ';'.

    APPEND wa_download TO t_download.
    CLEAR  wa_download.

  ENDLOOP.

  IF NOT t_download[] IS INITIAL.
    PERFORM zf_seleciona_diretorio_saida.
  ELSE.
    MESSAGE 'Erro ao preparar o download!' TYPE 'S' DISPLAY LIKE 'E'.
  ENDIF.


ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  ZF_DOWNLOAD_LOG_EXECUCAO
*&---------------------------------------------------------------------*
FORM zf_seleciona_diretorio_saida.

  CONCATENATE p_dwld '\' 'Tabela ' '.csv' INTO  vg_filename. "Dando um nome ao arquivo

  CALL FUNCTION 'GUI_DOWNLOAD'
    EXPORTING
      bin_filesize            = ''
      filename                = vg_filename
      filetype                = 'ASC'
    TABLES
      data_tab                = t_download[] "Tabela para download.
    EXCEPTIONS
      file_write_error        = 1
      no_batch                = 2
      gui_refuse_filetransfer = 3
      invalid_type            = 4
      no_authority            = 5
      unknown_error           = 6
      header_not_allowed      = 7
      separator_not_allowed   = 8
      filesize_not_allowed    = 9
      header_too_long         = 10
      dp_error_create         = 11
      dp_error_send           = 12
      dp_error_write          = 13
      unknown_dp_error        = 14
      access_denied           = 15
      dp_out_of_memory        = 16
      disk_full               = 17
      dp_timeout              = 18
      file_not_found          = 19
      dataprovider_exception  = 20
      control_flush_error     = 21
      OTHERS                  = 22.

  IF sy-subrc IS INITIAL.
    MESSAGE 'Download Efetuado com Sucesso!' TYPE 'S'.
  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  ZF_VISUALIZA_ALV_BASICO
*&---------------------------------------------------------------------*
FORM zf_visualiza_alv_basico.

  DATA: lt_fieldcat_basico TYPE slis_t_fieldcat_alv,
        ls_layout_basico   TYPE slis_layout_alv.

  "Cria o lt_fieldcat[] com base em uma estrutura de dados criada na SE11.
  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name = 'ZTAULA_CURSO' "Tabela da SE11
    CHANGING
      ct_fieldcat      = lt_fieldcat_basico[].


  ls_layout_basico-colwidth_optimize = 'X'. "Ajusta o tamanho das colunas.
  ls_layout_basico-zebra = 'X'. "Layout zebrado


  "Chamada da função que exibe o ALV em tela
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      is_layout     = ls_layout_basico
      it_fieldcat   = lt_fieldcat_basico[]
    TABLES
      t_outtab      = it_ztaula_curso[]  "Tabela interna de saída. (Sua tabela de dados)
    EXCEPTIONS
      program_error = 1
      OTHERS        = 2.

ENDFORM.
