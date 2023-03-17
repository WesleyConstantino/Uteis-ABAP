REPORT ztrwc_curso_alv_oo.

*&---------------------------------------------------------------------*
*                            Tabelas                                   *
*&---------------------------------------------------------------------*
TABLES: ztaula_curso.

*&---------------------------------------------------------------------*
*                        Tabelas  Internas                             *
*&---------------------------------------------------------------------*
DATA: it_ztaula_curso     TYPE TABLE OF ztaula_curso,
      it_ztaula_curs_alun TYPE TABLE OF ztaula_curs_alun.

*&---------------------------------------------------------------------*
*                       Declaração de Tipos                            *
*&---------------------------------------------------------------------*
TYPE-POOLS: slis.

*&---------------------------------------------------------------------*
*                        Estruturas do ALV                             *
*&---------------------------------------------------------------------*
DATA: lo_container_100 TYPE REF TO cl_gui_custom_container,
      lo_grid_100      TYPE REF TO cl_gui_alv_grid,
      lv_okcode_100    TYPE sy-ucomm,
      lt_fieldcat      TYPE lvc_t_fcat,
      ls_layout        TYPE lvc_s_layo,
      ls_variant       TYPE disvariant.


*&---------------------------------------------------------------------*
*                         Tela de seleção                              *
*&---------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK b0 WITH FRAME TITLE text-000.
SELECT-OPTIONS: s_curso FOR ztaula_curso-nome_curso NO INTERVALS.
*Radio Buttons
PARAMETERS: r_basic TYPE char1 RADIOBUTTON GROUP g1,
            r_compl TYPE char1 RADIOBUTTON GROUP g1 DEFAULT 'X'.
SELECTION-SCREEN END OF BLOCK b0.

*Início da execusão
START-OF-SELECTION.
  PERFORM: zf_obtem_dados.

*&---------------------------------------------------------------------*
*&      Form  zf_obtem_dados
*&---------------------------------------------------------------------*
FORM zf_obtem_dados.

  SELECT *
  FROM ztaula_curso
  INTO TABLE it_ztaula_curso[]
  WHERE nome_curso IN s_curso[].

  SELECT *
  FROM ztaula_curs_alun
  INTO TABLE it_ztaula_curs_alun[]
  WHERE nome_curso IN s_curso[].

  CASE r_basic.
    WHEN 'X'.
      PERFORM: zf_visualiza_alv_basico.
    WHEN ' '.
      PERFORM: zf_visualiza_alv_completo.
  ENDCASE.
ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  f_visualiza_alv_completo
*&---------------------------------------------------------------------*
FORM zf_visualiza_alv_completo.

  IF it_ztaula_curso[] IS NOT INITIAL OR it_ztaula_curs_alun[] IS NOT INITIAL.
    CALL SCREEN 100.
  ELSE.
    MESSAGE 'Dados não localizados!' TYPE 'S' DISPLAY LIKE 'W'.
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

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  CASE lv_okcode_100.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0. "Volta para a tela chamadora
    WHEN 'EXIT'.
      LEAVE PROGRAM. "Sai do programa
  ENDCASE.

ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'STATUS100'. "Botões da tela 100
  SET TITLEBAR 'TITULE100'.  "Código do título da Tela 100
ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  M_SHOW_GRID_100  OUTPUT
*&---------------------------------------------------------------------*
MODULE m_show_grid_100 OUTPUT.
  FREE: lt_fieldcat[].

  ls_layout-cwidth_opt = 'X'. "Ajustar largura das colunas (Layout otimizado).
  ls_layout-zebra      = 'X'. "Layout em Zebra.
  ls_variant-report    = sy-repid. "Variante (Não usá-la quando o tipo foi pop-up).

  PERFORM zf_build_fieldcat USING:
          'NOME_CURSO' 'NOME_CURSO' 'ZTAULA_CURSO' 'Curso'      ' ' CHANGING lt_fieldcat[],
          'DT_INICIO'  'DT_INICIO'  'ZTAULA_CURSO' 'Dt. Início' ' ' CHANGING lt_fieldcat[],
          'DT_FIM'     'DT_FIM'     'ZTAULA_CURSO' 'Dt. Fim'    ' ' CHANGING lt_fieldcat[],
          'ATIVO'      'ATIVO'      'ZTAULA_CURSO' 'Ativo'      'X' CHANGING lt_fieldcat[].

  IF lo_grid_100 IS INITIAL.
    lo_grid_100 = NEW cl_gui_alv_grid( i_parent = cl_gui_custom_container=>default_screen ).

    lo_grid_100->set_table_for_first_display(
    EXPORTING
      is_variant  = ls_variant
      is_layout   = ls_layout
      i_save      = 'A'
    CHANGING
      it_fieldcatalog = lt_fieldcat[]
      it_outtab       = it_ztaula_curso[]
    ).
  ELSE.
    lo_grid_100->refresh_table_display( ).
  ENDIF.

ENDMODULE.


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
