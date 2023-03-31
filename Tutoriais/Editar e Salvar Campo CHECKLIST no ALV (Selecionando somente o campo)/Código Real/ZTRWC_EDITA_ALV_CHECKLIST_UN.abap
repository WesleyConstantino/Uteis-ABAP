REPORT ZTRWC_EDITA_ALV_CHECKLIST_UN.

*&---------------------------------------------------------------------*
*                            Tabelas                                   *
*&---------------------------------------------------------------------*
TABLES: ztaula_curso.

*&---------------------------------------------------------------------*
*                        Tabelas  Internas                             *
*&---------------------------------------------------------------------*
DATA: t_ztaula_curso TYPE TABLE OF ztaula_curso.

*&---------------------------------------------------------------------*
*                            Workareas                                 *
*&---------------------------------------------------------------------*
DATA: wa_ztaula_curso LIKE LINE OF t_ztaula_curso.

*&---------------------------------------------------------------------*
*                           Estruturas                                 *
*&---------------------------------------------------------------------*
DATA:
  og_grid_9000      TYPE REF TO cl_gui_alv_grid, "Grid
  vg_okcode_9000    TYPE sy-ucomm,   "Ok Code do Module Pool
  tg_fieldcat       TYPE lvc_t_fcat, "Fieldcat
  wa_layout         TYPE lvc_s_layo, "Layout
  wa_variant        TYPE disvariant, "Variant
  og_container_9000 TYPE REF TO cl_gui_custom_container. "Container do Module Pool

*&---------------------------------------------------------------------*
*                         Tela de seleção                              *
*&---------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK b0 WITH FRAME TITLE text-000.
SELECT-OPTIONS: s_curso FOR ztaula_curso-nome_curso NO INTERVALS.
SELECTION-SCREEN END OF BLOCK b0.

*Início da execusão
START-OF-SELECTION.
  CALL SCREEN 9000.

*&---------------------------------------------------------------------*
*&      Module  STATUS_9000  OUTPUT
*&---------------------------------------------------------------------**
MODULE status_9000 OUTPUT.
  SET PF-STATUS 'STATUS900'.
  SET TITLEBAR 'TITLE9000'.

    PERFORM: zf_select,
           zf_show_grid_9000.
ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_9000  INPUT
*&---------------------------------------------------------------------*
MODULE user_command_9000 INPUT.
   og_grid_9000->check_changed_data( ). "Método para pegar a alteração do checklist em tampo real

    CASE vg_okcode_9000.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0. "Volta para a tela chamadora
    WHEN 'EXIT'.
      LEAVE PROGRAM. "Sai do programa
    WHEN 'SAVE'.
      MODIFY ztaula_curso FROM TABLE t_ztaula_curso.
      PERFORM z_commit_e_rollback.
  ENDCASE.

ENDMODULE.

*&---------------------------------------------------------------------*
*&      Form  ZF_SELECT
*&---------------------------------------------------------------------*
FORM zf_select .

  SELECT *
  FROM ztaula_curso
  INTO TABLE t_ztaula_curso[]
  WHERE nome_curso IN s_curso[].

  IF sy-subrc NE 0.
    MESSAGE s398(00) WITH 'Não há registros!' DISPLAY LIKE 'E'.
    LEAVE TO SCREEN 0.
  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  zf_build_grida
*&---------------------------------------------------------------------*
FORM zf_show_grid_9000.

  FREE: tg_fieldcat[],
        wa_layout,
        wa_variant.

  wa_layout-cwidth_opt = 'X'. "Ajustar largura das colunas (Layout otimizado).
  wa_layout-zebra      = 'X'. "Layout em Zebra.
  wa_variant-report    = sy-repid. "Variante (Não usá-la quando o tipo foi pop-up).

  PERFORM zf_build_fieldcat USING:
            'NOME_CURSO' 'NOME_CURSO' 'ZTAULA_CURSO' 'Curso'      ' '  ' ' 'C710' ' ' CHANGING tg_fieldcat[],
            'DT_INICIO'  'DT_INICIO'  'ZTAULA_CURSO' 'Dt. Início' ' '  ' ' ' '    ' ' CHANGING tg_fieldcat[],
            'DT_FIM'     'DT_FIM'     'ZTAULA_CURSO' 'Dt. Fim'    ' '  ' ' ' '    ' ' CHANGING tg_fieldcat[],
            'ATIVO'      'ATIVO'      'ZTAULA_CURSO' 'Ativo'      'X'  ' ' ' '    'X' CHANGING tg_fieldcat[].

  IF og_grid_9000 IS INITIAL.
    "Cria objeto do container do Module Pool
    "og_container_9000 = NEW cl_gui_custom_container( container_name = 'CONTAINER_9000' ).
    "Instância o objeto do ALV
    og_grid_9000 = NEW cl_gui_alv_grid( i_parent = cl_gui_custom_container=>default_screen )."Caso haja uso de container ( i_parent = lo_container_9000 ).

    "Permite fazer seleção múltipla de linhas no ALV
    og_grid_9000->set_ready_for_input( 1 ).

    "Chama o ALV pela primeira vez
    og_grid_9000->set_table_for_first_display(
    EXPORTING
      is_variant  = wa_variant "Variant para seleção múltipla do alv
      is_layout   = wa_layout
      i_save      = 'A'
    CHANGING
      it_fieldcatalog = tg_fieldcat[]
      it_outtab       = t_ztaula_curso[]  "Tabela de saída
    ).

    "Define título do ALV
    og_grid_9000->set_gridtitle( 'Lista de Cursos' ).
  ELSE.
    "Atualiza tela, caso haja alteração nos dados da tabela interna
    og_grid_9000->refresh_table_display( ).
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
                             VALUE(p_icon)      TYPE c
                             VALUE(p_emphasize) TYPE c
                             VALUE(p_edit)      TYPE c
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

  "ícones
  ls_fieldcat-icon = p_icon.

  "Cor das Colunas
  ls_fieldcat-emphasize = p_emphasize.

  "Habilitar edição de colunas no ALV
  ls_fieldcat-edit = p_edit.

  APPEND ls_fieldcat TO t_fieldcat[].

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  Z_COMMIT_E_ROLLBACK
*&---------------------------------------------------------------------*
FORM z_commit_e_rollback.

  IF sy-subrc IS INITIAL.
    COMMIT WORK AND WAIT.
    MESSAGE s398(00) WITH 'Alteração salva com sucesso!'.
  ELSE.
    ROLLBACK WORK.
    MESSAGE s208(00) WITH 'Erro ao Tentar Gravar as Alterações!' DISPLAY LIKE 'E'.
  ENDIF.

ENDFORM.
