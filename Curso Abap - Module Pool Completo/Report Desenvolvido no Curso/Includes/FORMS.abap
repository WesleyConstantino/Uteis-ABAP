*&---------------------------------------------------------------------*
*&      Form  F_SELECINAR_VOOS
*&---------------------------------------------------------------------*
FORM f_selecinar_voos .

  SELECT *
    INTO TABLE lt_sflight[]
    FROM sflight.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  F_MONTAR_GRID_100
*&---------------------------------------------------------------------*
FORM f_montar_grid_100 .

  FREE: it_fieldcat[].

  CLEAR: ls_layout,
         ls_variant.

*-----* Função para montar o fieldcat:
  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'SFLIGHT' "Tabela de referência (Cadastrada na SE11).
    CHANGING
      ct_fieldcat            = it_fieldcat[] "Tabela interna do fieldcat.
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.
  IF lo_grid_100 IS INITIAL.
    lo_container_100 = NEW cl_gui_custom_container( container_name = 'CONTAINER' ). "CONTAINER é o nome do meu container no layout.
    lo_grid_100      = NEW cl_gui_alv_grid( i_parent = lo_container_100 ).
    lo_event_grid    = NEW zcl_event_grid( ).  "Para evento do pop-up.

    "Chama o ALV pela primeira vez
    lo_grid_100->set_table_for_first_display(
    EXPORTING
      is_variant  = ls_variant "Variant para seleção múltipla do alv
      is_layout   = ls_layout
      i_save      = 'A'
    CHANGING
      it_fieldcatalog = it_fieldcat[]
      it_outtab       = lt_sflight[]  "Tabela de saída
    ).

    "Seta o evento do pop-up:
    SET HANDLER lo_event_grid->double_click FOR lo_grid_100. "SET HANDLER "Objeto da Clasee"->"Método" FOR "Tela que desejo vincular o evento".
  ELSE.
    lo_grid_100->refresh_table_display( ). "Limpa a tela para que não crie uma tella sobre a outra.
  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  F_MONTAR_CABECALHO
*&---------------------------------------------------------------------*
FORM f_montar_cabecalho .

  DATA: lv_alias TYPE bapialias.

  "Função que busca dados adicionais do usuário:
  CALL FUNCTION 'SUSR_USER_READ'
    EXPORTING
      user_name = sy-uname
    IMPORTING
      alias     = lv_alias.

  iv_uname = sy-uname.
  iv_uname_nome = lv_alias.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  Z_DOUBLE_CLICK
*&---------------------------------------------------------------------*
FORM z_double_click  USING uv_e_row     TYPE lvc_s_row
                           uv_e_column  TYPE lvc_s_col
                           uv_es_row_no TYPE lvc_s_roid.

  READ TABLE lt_sflight[] ASSIGNING FIELD-SYMBOL(<fs_sflight>) INDEX uv_es_row_no-row_id. "Identifica qual linha foi clicada.

  IF sy-subrc EQ 0.
    SELECT *
      INTO TABLE lt_sflights[]
      FROM sflights
      WHERE carrid EQ <fs_sflight>-carrid AND
            connid EQ <fs_sflight>-connid AND
            fldate EQ <fs_sflight>-fldate.

    IF sy-subrc EQ 0.
      CALL SCREEN 200 STARTING AT 40 1 ENDING AT 160 15. "Tamanho da tela "STARTING AT <início da largura> <início da altura> ENDING AT <fim da largura> <fim da altura>."
    ELSE.
      MESSAGE 'Não existe conexão para esse vôo' TYPE 'S' DISPLAY LIKE 'W'.
    ENDIF.
  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  F_MONTAR_GRID_200
*&---------------------------------------------------------------------*
FORM f_montar_grid_200 .

  FREE: it_fieldcat[].

  CLEAR: ls_layout,
         ls_variant.

*-----* Função para montar o fieldcat:
  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'SFLIGHTS' "Tabela de referência (Cadastrada na SE11).
    CHANGING
      ct_fieldcat            = it_fieldcat[] "Tabela interna do fieldcat.
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.
  IF lo_grid_200 IS INITIAL.
    lo_container_200 = NEW cl_gui_custom_container( container_name = 'CONTAINER' ). "CONTAINER é o nome do meu container no layout.
    lo_grid_200      = NEW cl_gui_alv_grid( i_parent = lo_container_200 ).

    "Chama o ALV pela primeira vez
    lo_grid_200->set_table_for_first_display(
    EXPORTING
      is_variant  = ls_variant "Variant para seleção múltipla do alv
      is_layout   = ls_layout
      i_save      = 'A'
    CHANGING
      it_fieldcatalog = it_fieldcat[]
      it_outtab       = lt_sflights[]  "Tabela de saída
    ).
  ELSE.
    lo_grid_200->refresh_table_display( ). "Limpa a tela para que não crie uma tella sobre a outra.
  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  F_DETALHE_DO_VOO
*&---------------------------------------------------------------------*
FORM f_detalhe_do_voo .

  DATA: lt_index_rows TYPE lvc_t_row,
        lt_row_no     TYPE lvc_t_roid.

  lo_grid_100->get_selected_rows(   "Método para selecionar linha
   IMPORTING
    et_index_rows = lt_index_rows[]
    et_row_no     = lt_row_no[]
).

  IF lt_row_no[] IS INITIAL.
    MESSAGE 'Nenhuma linha foi selecionada!' TYPE 'S' DISPLAY LIKE 'W'.
  ELSE.
    READ TABLE lt_row_no[] ASSIGNING FIELD-SYMBOL(<fs_row_no>) INDEX 1.
    READ TABLE lt_sflight[] ASSIGNING FIELD-SYMBOL(<fs_sflight>) INDEX <fs_row_no>-row_id.

    IF sy-subrc EQ 0.
      SELECT *
        INTO TABLE lt_sflights2[]
        FROM sflights2
        WHERE carrid EQ <fs_sflight>-carrid AND
              connid EQ <fs_sflight>-connid AND
              fldate EQ <fs_sflight>-fldate.

      IF sy-subrc EQ 0.
        CALL SCREEN 300.
      ELSE.
        MESSAGE 'Não existe detalhe para esse vôo!' TYPE 'S' DISPLAY LIKE 'W'.
      ENDIF.
    ENDIF.
  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  F_MONTAR_TELA_300
*&---------------------------------------------------------------------*
FORM f_montar_tela_300 .

  FREE: it_fieldcat[].

  CLEAR: ls_layout,
         ls_variant.

*-----* Função para montar o fieldcat:
  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'SFLIGHTS2' "Tabela de referência (Cadastrada na SE11).
    CHANGING
      ct_fieldcat            = it_fieldcat[] "Tabela interna do fieldcat.
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.
  IF lo_grid_300 IS INITIAL.
    lo_container_300 = NEW cl_gui_custom_container( container_name = 'CONTAINER' ). "CONTAINER é o nome do meu container no layout.
    lo_grid_300      = NEW cl_gui_alv_grid( i_parent = lo_container_300 ).

    "Chama o ALV pela primeira vez
    lo_grid_300->set_table_for_first_display(
    EXPORTING
      is_variant  = ls_variant "Variant para seleção múltipla do alv
      is_layout   = ls_layout
      i_save      = 'A'
    CHANGING
      it_fieldcatalog = it_fieldcat[]
      it_outtab       = lt_sflights2[]  "Tabela de saída
    ).
  ELSE.
    lo_grid_300->refresh_table_display( ). "Limpa a tela para que não crie uma tella sobre a outra.
  ENDIF.

ENDFORM.
