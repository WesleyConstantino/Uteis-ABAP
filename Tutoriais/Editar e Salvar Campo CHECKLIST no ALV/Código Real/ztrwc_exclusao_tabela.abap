REPORT ztrwc_exclusao_tabela.

*&---------------------------------------------------------------------*
*                            Tabelas                                   *
*&---------------------------------------------------------------------*
TABLES: zpficat_pinsumos.

*&---------------------------------------------------------------------*
*                                 TYPES                                *
*&---------------------------------------------------------------------*
TYPES:
*-------*ty_zpficat_pinsumos
  BEGIN OF ty_zpficat_pinsumos,
    bukrs    TYPE zpficat_pinsumos-bukrs,
    hkont    TYPE zpficat_pinsumos-hkont,
    period   TYPE zpficat_pinsumos-period,
    belnr    TYPE zpficat_pinsumos-belnr,
    buzei    TYPE zpficat_pinsumos-buzei,
    blart    TYPE zpficat_pinsumos-blart,
    lifnr    TYPE zpficat_pinsumos-lifnr,
    gsber    TYPE zpficat_pinsumos-gsber,
    shkzg    TYPE zpficat_pinsumos-shkzg,
    dmbtr    TYPE zpficat_pinsumos-dmbtr,
    fkber    TYPE zpficat_pinsumos-fkber,
    exclusao TYPE zpficat_pinsumos-exclusao,
  END OF ty_zpficat_pinsumos.

*&---------------------------------------------------------------------*
*                        Tabelas Internas                              *
*&---------------------------------------------------------------------*
DATA: t_zpficat_pinsumos TYPE TABLE OF ty_zpficat_pinsumos.

*&---------------------------------------------------------------------*
*                           Workareas                                  *
*&---------------------------------------------------------------------*
DATA: wa_zpficat_pinsumos LIKE LINE OF t_zpficat_pinsumos.

*&---------------------------------------------------------------------*
*                           Estruturas                                 *
*&---------------------------------------------------------------------*
DATA:
  lo_grid_100       TYPE REF TO cl_gui_alv_grid, "Grid
  lv_okcode_100     TYPE sy-ucomm, "ok code do module pool
  lt_fieldcat       TYPE lvc_t_fcat, "fieldcat
  ls_layout         TYPE lvc_s_layo, "layout
  ls_variant        TYPE disvariant, "variant
  go_container_9000 TYPE REF TO cl_gui_custom_container. "Container

*&---------------------------------------------------------------------*
*                         Tela de seleção                              *
*&---------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK b0 WITH FRAME TITLE text-000.
SELECT-OPTIONS: s_hkont FOR zpficat_pinsumos-hkont, "OBLIGATORY,
                s_belnr FOR zpficat_pinsumos-belnr,
                s_blart FOR zpficat_pinsumos-blart,
                s_lifnr FOR zpficat_pinsumos-lifnr,
                s_gsber FOR zpficat_pinsumos-gsber.
SELECTION-SCREEN END OF BLOCK b0.

*Início da execusão
START-OF-SELECTION.
  CALL SCREEN 100.

*&---------------------------------------------------------------------*
*                          FORM zf_select                              *
*&---------------------------------------------------------------------*
FORM zf_select.
  SELECT bukrs
         hkont
         period
         belnr
         buzei
         blart
         lifnr
         gsber
         shkzg
         dmbtr
         fkber
         exclusao
    FROM zpficat_pinsumos
    INTO TABLE t_zpficat_pinsumos
    WHERE hkont IN s_hkont AND
          belnr IN s_belnr AND
          blart IN s_blart AND
          lifnr IN s_lifnr AND
          gsber IN s_gsber.

  IF sy-subrc <> 0.
    MESSAGE s398(00) WITH text-m01 DISPLAY LIKE 'E'.
    STOP.
  ENDIF.

ENDFORM.


*&---------------------------------------------------------------------*
*&      Module  M_SHOW_GRID_100  OUTPUT
*&---------------------------------------------------------------------*
FORM zf_show_grid_100.

  FREE: lt_fieldcat[],
        ls_layout,
        ls_variant.

  ls_layout-cwidth_opt = 'X'. "Ajustar largura das colunas (Layout otimizado).
  ls_layout-zebra      = 'X'. "Layout em Zebra.
  ls_variant-report    = sy-repid. "Variante (Não usá-la quando o tipo foi pop-up).

  PERFORM zf_build_fieldcat USING:
          'BUKRS'    'BUKRS'    'T_OUT' 'Bukers'    ' '   CHANGING lt_fieldcat[],
          'HKONT'    'HKONT'    'T_OUT' 'Hkont'     ' '   CHANGING lt_fieldcat[],
          'PERIOD'   'PERIOD'   'T_OUT' 'Period'    ' '   CHANGING lt_fieldcat[],
          'BELNR'    'BELNR'    'T_OUT' 'Belnr'     ' '   CHANGING lt_fieldcat[],
          'BUZEI'    'BUZEI'    'T_OUT' 'Buzei'     ' '   CHANGING lt_fieldcat[],
          'BLART'    'BLART'    'T_OUT' 'Blart'     ' '   CHANGING lt_fieldcat[],
          'LIFNR'    'LIFNR'    'T_OUT' 'Lifnr'     ' '   CHANGING lt_fieldcat[],
          'GSBER'    'GSBER'    'T_OUT' 'Gsber'     ' '   CHANGING lt_fieldcat[],
          'SHKZG'    'SHKZG'    'T_OUT' 'Shkzg'     ' '   CHANGING lt_fieldcat[],
          'DMBTR'    'DMBTR'    'T_OUT' 'Dmbtr'     ' '   CHANGING lt_fieldcat[],
          'FKBER'    'FKBER'    'T_OUT' 'Fkber'     ' '   CHANGING lt_fieldcat[],
          'EXCLUSAO' 'EXCLUSAO' 'T_OUT' 'Exclusao'  'X'   CHANGING lt_fieldcat[].


  IF lo_grid_100 IS INITIAL.
    "CREATE OBJECT go_container_9000
     " EXPORTING
      "  container_name = 'CONTAINER_9000'.
    go_container_9000 = NEW cl_gui_custom_container( container_name = 'CONTAINER_9000' ).
    "Instância o objeto do ALV
    lo_grid_100 = NEW cl_gui_alv_grid( i_parent = go_container_9000 ).

    "Permite fazer seleção múltipla de linhas no ALV
    lo_grid_100->set_ready_for_input( 1 ).

    "Chama o ALV pela primeira vez
    lo_grid_100->set_table_for_first_display(
    EXPORTING
      is_variant  = ls_variant
      is_layout   = ls_layout
      i_save      = 'A'
    CHANGING
      it_fieldcatalog = lt_fieldcat[]
      it_outtab       = t_zpficat_pinsumos[]
    ).

    "Define título do ALV
    lo_grid_100->set_gridtitle( 'ALV' ).
    "SET HANDLER lo_event_grid->data_changed FOR lo_grid_100.
  ELSE.
    lo_grid_100->refresh_table_display( ).
  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  zf_build_fieldcat
*&---------------------------------------------------------------------*
FORM zf_build_fieldcat USING VALUE(p_fieldname) TYPE c
                             VALUE(p_field)     TYPE c
                             VALUE(p_table)     TYPE c
                             VALUE(p_coltext)   TYPE c
                             VALUE(p_checkbox)  TYPE c
                          CHANGING t_fieldcat   TYPE lvc_t_fcat.

  DATA: ls_fieldcat LIKE LINE OF t_fieldcat[].

  "Nome do campo dado na tabela interna
  ls_fieldcat-fieldname = p_fieldname.

  "Nome do campo na tabela transparente
  ls_fieldcat-ref_field = p_field.

  "Tabela transparente
  ls_fieldcat-ref_table = p_table.

  "Descrição que daremos para o campo no ALV.
  ls_fieldcat-coltext   = p_coltext.

  "Checkbox (Campos que quero que sejam checkbox, marco como 'X' no m_show_grid_100)
  ls_fieldcat-checkbox = p_checkbox.

  APPEND ls_fieldcat TO t_fieldcat[].

ENDFORM.

*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'STATUS100'. "Botões da tela 100
  SET TITLEBAR 'TITULE100'.  "Código do título da Tela 100

  PERFORM: zf_select,
           zf_show_grid_100.
ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  CASE lv_okcode_100.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0. "Volta para a tela chamadora
      "CLEAR: lv_salvou_item.
    WHEN 'EXIT'.
      LEAVE PROGRAM. "Sai do programa
      "CLEAR: lv_salvou_item.
    WHEN 'EXCLUSAO' OR 'INCLUSAO'.
      PERFORM: z_exl_e_inc_insumos USING lv_okcode_100.
  ENDCASE.

ENDMODULE.

*&---------------------------------------------------------------------*
*&      Form  Z_EXL_E_INC_INSUMOS
*&---------------------------------------------------------------------*
FORM z_exl_e_inc_insumos  USING    p_lv_okcode_100.

  DATA: lt_selected_rows        TYPE lvc_t_row,
        wa_zpficat_pinsumos_aux TYPE zpficat_pinsumos.

  lo_grid_100->get_selected_rows(
    IMPORTING
      et_index_rows = lt_selected_rows ).

  LOOP AT lt_selected_rows INTO DATA(wa_selected_rows).

    READ TABLE t_zpficat_pinsumos
     INTO DATA(wa_zpficat_pinsumos)
         INDEX wa_selected_rows-index.

    IF sy-subrc IS INITIAL   AND
     (  p_lv_okcode_100 EQ 'EXCLUSAO' OR
        p_lv_okcode_100 EQ 'INCLUSAO' ).


      IF  p_lv_okcode_100 EQ 'EXCLUSAO'.
        wa_zpficat_pinsumos-exclusao = 'X'.
      ELSEIF  p_lv_okcode_100 EQ 'INCLUSAO'.
        wa_zpficat_pinsumos-exclusao = ' '.
      ENDIF.

      MOVE-CORRESPONDING wa_zpficat_pinsumos TO wa_zpficat_pinsumos_aux.
      MODIFY zpficat_pinsumos FROM wa_zpficat_pinsumos_aux.

      PERFORM z_commit_e_rollback.

      CLEAR: wa_zpficat_pinsumos_aux.
    ENDIF.
  ENDLOOP.
  PERFORM: zf_select.
ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  Z_COMMIT_E_ROLLBACK
*&---------------------------------------------------------------------*
FORM z_commit_e_rollback.

  IF sy-subrc IS INITIAL.
    COMMIT WORK AND WAIT.
    MESSAGE s208(00) WITH text-m02. "Alterações Realizadas com Sucesso!

  ELSE.
    ROLLBACK WORK.
    MESSAGE s208(00) WITH text-m03 DISPLAY LIKE 'E'. "Erro ao Tentar Gravar as Alterações!

  ENDIF.
ENDFORM.
