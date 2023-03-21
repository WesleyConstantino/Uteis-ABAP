REPORT ztrwc_curso_alv_oo.

*&---------------------------------------------------------------------*
*                           Includes                                   *
*&---------------------------------------------------------------------*
INCLUDE <icon>.

*&---------------------------------------------------------------------*
*                            Tabelas                                   *
*&---------------------------------------------------------------------*
TABLES: ztaula_curso.

*&---------------------------------------------------------------------*
*                             Types                                    *
*&---------------------------------------------------------------------*
TYPES:
  BEGIN OF ty_curso_aluno.
    INCLUDE   TYPE ztaula_curs_alun.
    TYPES: id    TYPE icon-id,
    color TYPE char4,
  END OF ty_curso_aluno.

*&---------------------------------------------------------------------*
*                        Tabelas  Internas                             *
*&---------------------------------------------------------------------*
DATA: it_ztaula_curso     TYPE TABLE OF ztaula_curso,
      it_ztaula_curs_alun TYPE TABLE OF ty_curso_aluno.

*&---------------------------------------------------------------------*
*                       Declaração de Tipos                            *
*&---------------------------------------------------------------------*
TYPE-POOLS: slis.

*&---------------------------------------------------------------------*
*                        Estruturas do ALV                             *
*&---------------------------------------------------------------------*
DATA: lo_container_100  TYPE REF TO cl_gui_custom_container,
      lo_container_100b TYPE REF TO cl_gui_custom_container,
      lo_grid_100       TYPE REF TO cl_gui_alv_grid,
      lo_grid_100b      TYPE REF TO cl_gui_alv_grid,
      lv_okcode_100     TYPE sy-ucomm,
      lt_fieldcat       TYPE lvc_t_fcat,
      lt_fieldcatb      TYPE lvc_t_fcat,
      ls_layout         TYPE lvc_s_layo,
      ls_variant        TYPE disvariant,
      it_tool_bar       TYPE ui_functions. "Variável para remover botões inúteis do grid.


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

  LOOP AT it_ztaula_curs_alun[] ASSIGNING FIELD-SYMBOL(<fs_curso_alun>).
    IF <fs_curso_alun>-inscr_confirmada EQ 'X' AND <fs_curso_alun>-pgto_confirmado EQ 'X'.
      <fs_curso_alun>-id    = icon_green_light.
      <fs_curso_alun>-color = 'C500'.
    ELSEIF <fs_curso_alun>-inscr_confirmada EQ 'X' AND <fs_curso_alun>-pgto_confirmado IS INITIAL.
      <fs_curso_alun>-id    = icon_yellow_light.
      <fs_curso_alun>-color = 'C300'.
    ELSE.
      <fs_curso_alun>-id    = icon_red_light.
      <fs_curso_alun>-color = 'C600'.
    ENDIF.
  ENDLOOP.

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
  ls_layout-info_fname = 'COLOR'. "Cor das linhas
  ls_variant-report    = sy-repid. "Variante (Não usá-la quando o tipo foi pop-up).

  PERFORM zf_remove_alv_buttons. "Remover botões do grid
  PERFORM zf_build_grida.
  PERFORM zf_build_gridb.

ENDMODULE.

*&---------------------------------------------------------------------*
*&      Form  zf_build_grida
*&---------------------------------------------------------------------*
FORM zf_build_grida.

  PERFORM zf_build_fieldcat USING:
            'NOME_CURSO' 'NOME_CURSO' 'ZTAULA_CURSO' 'Curso'      ' '  ' ' CHANGING lt_fieldcat[],
            'DT_INICIO'  'DT_INICIO'  'ZTAULA_CURSO' 'Dt. Início' ' '  ' ' CHANGING lt_fieldcat[],
            'DT_FIM'     'DT_FIM'     'ZTAULA_CURSO' 'Dt. Fim'    ' '  ' ' CHANGING lt_fieldcat[],
            'ATIVO'      'ATIVO'      'ZTAULA_CURSO' 'Ativo'      'X'  ' ' CHANGING lt_fieldcat[].

  IF lo_grid_100 IS INITIAL.
    "Containera, criado no layout da tela 100
    lo_container_100 = NEW cl_gui_custom_container( container_name = 'CONTAINERA' ).
    "Instância o objeto do ALV
    lo_grid_100 = NEW cl_gui_alv_grid( i_parent = lo_container_100 )."Caso não precise de 2 containers, uso : "( i_parent = cl_gui_custom_container=>default_screen )."

    "Permite fazer seleção múltipla de linhas no ALV
    lo_grid_100->set_ready_for_input( 1 ).

    "Chama o ALV pela primeira vez
    lo_grid_100->set_table_for_first_display(
    EXPORTING
      it_toolbar_excluding = it_tool_bar[] "Remoção de botões do grid
      is_variant  = ls_variant "Variant para seleção múltiplas do alv
      is_layout   = ls_layout
      i_save      = 'A'
    CHANGING
      it_fieldcatalog = lt_fieldcat[]
      it_outtab       = it_ztaula_curso[]
    ).

    "Define título do ALV
    lo_grid_100->set_gridtitle( 'Lista de Cursos' ).
  ELSE.
    "Atualiza tela, caso haja alteração nos dados da tabela interna
    lo_grid_100->refresh_table_display( ).
  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  zf_build_gridb
*&---------------------------------------------------------------------*
FORM zf_build_gridb.

  PERFORM zf_build_fieldcat USING:
          'ID'               'ID'               'ICON'             'Status'          ' '  'X' CHANGING lt_fieldcatb[],
          'NOME_ALUNO'       'NOME_ALUNO'       'ZTAULA_CURS_ALUN' 'Nome'            ' '  ' ' CHANGING lt_fieldcatb[],
          'NOME_CURSO'       'NOME_CURSO'       'ZTAULA_CURS_ALUN' 'Curso'           ' '  ' ' CHANGING lt_fieldcatb[],
          'DT_NASCIMENTO'    'DT_NASCIMENTO'    'ZTAULA_CURS_ALUN' 'Dt.Nascimento'   ' '  ' ' CHANGING lt_fieldcatb[],
          'INSCR_CONFIRMADA' 'INSCR_CONFIRMADA' 'ZTAULA_CURS_ALUN' 'Insc.Confirmada' 'X'  ' ' CHANGING lt_fieldcatb[],
          'PGTO_CONFIRMADO'  'PGTO_CONFIRMADO'  'ZTAULA_CURS_ALUN' 'Pag.Confirmado'  'X'  ' ' CHANGING lt_fieldcatb[].

  IF lo_grid_100b IS INITIAL.
    "Containerb, criado no layout da tela 100
    lo_container_100b = NEW cl_gui_custom_container( container_name = 'CONTAINERB' ).
    "Instância o objeto do ALV
    lo_grid_100b = NEW cl_gui_alv_grid( i_parent = lo_container_100b )."Caso não precise de 2 containers, uso : "( i_parent = cl_gui_custom_container=>default_screen )."

    "Permite fazer seleção múltipla de linhas no ALV
    lo_grid_100b->set_ready_for_input( 1 ).

    "Chama o ALV pela primeira vez
    lo_grid_100b->set_table_for_first_display(
    EXPORTING
      it_toolbar_excluding = it_tool_bar[] "Remoção de botões do grid
      is_variant  = ls_variant
      is_layout   = ls_layout
      i_save      = 'A'
    CHANGING
      it_fieldcatalog = lt_fieldcatb[]
      it_outtab       = it_ztaula_curs_alun[]
    ).

    "Define título do ALV
    lo_grid_100b->set_gridtitle( 'Lista de Alunos' ).
  ELSE.
    "Atualiza tela, caso haja alteração nos dados da tabela interna
    lo_grid_100b->refresh_table_display( ).
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


  APPEND ls_fieldcat TO t_fieldcat[].

ENDFORM.

FORM zf_remove_alv_buttons.
* INICIO: Botões EXTRAS -----------------------------------------------*
*  APPEND cl_gui_alv_grid=>mc_fc_auf                   TO gt_toolbar[]. "Nível de Totais Detalhados
*  APPEND cl_gui_alv_grid=>mc_fc_average               TO gt_toolbar[]. "Valor Médio (Calcular Média)
*  APPEND cl_gui_alv_grid=>mc_fc_back_classic          TO gt_toolbar[].
*  APPEND cl_gui_alv_grid=>mc_fc_call_abc              TO gt_toolbar[]. "Análise ABC
*  APPEND cl_gui_alv_grid=>mc_fc_call_chain            TO gt_toolbar[]. "Sequência de Chamada
*  APPEND cl_gui_alv_grid=>mc_fc_call_crbatch          TO gt_toolbar[]. "Processamento em Lote de Informações da Seagate
*  APPEND cl_gui_alv_grid=>mc_fc_call_crweb            TO gt_toolbar[]. "Processamento de informações da Web da Seagate
*  APPEND cl_gui_alv_grid=>mc_fc_call_lineitems        TO gt_toolbar[]. "Itens de Linha
*  APPEND cl_gui_alv_grid=>mc_fc_call_master_data      TO gt_toolbar[]. "Dados Mestre
*  APPEND cl_gui_alv_grid=>mc_fc_call_more             TO gt_toolbar[]. "Mais Chamadas
*  APPEND cl_gui_alv_grid=>mc_fc_call_report           TO gt_toolbar[]. "Relatório de Chamada
*  APPEND cl_gui_alv_grid=>mc_fc_call_xint             TO gt_toolbar[]. "Funções Adicionais do SAPQuery
*  APPEND cl_gui_alv_grid=>mc_fc_call_xml_export       TO gt_toolbar[]. "Star Office
*  APPEND cl_gui_alv_grid=>mc_fc_call_xxl              TO gt_toolbar[]. "XXG
*  APPEND cl_gui_alv_grid=>mc_fc_check                 TO gt_toolbar[]. "Verificar Entradas
*  APPEND cl_gui_alv_grid=>mc_fc_col_invisible         TO gt_toolbar[]. "Colunas Invisíveis
*  APPEND cl_gui_alv_grid=>mc_fc_col_optimize          TO gt_toolbar[]. "Otimizar Colunas
*  APPEND cl_gui_alv_grid=>mc_fc_count                 TO gt_toolbar[].
*  APPEND cl_gui_alv_grid=>mc_fc_current_variant       TO gt_toolbar[]. "Variante atual
*  APPEND cl_gui_alv_grid=>mc_fc_data_save             TO gt_toolbar[]. "Guardar dados
*  APPEND cl_gui_alv_grid=>mc_fc_delete_filter         TO gt_toolbar[]. "Excluir Filtro
*  APPEND cl_gui_alv_grid=>mc_fc_deselect_all          TO gt_toolbar[]. "Desmarcar Todas as Linhas
*  APPEND cl_gui_alv_grid=>mc_fc_detail                TO gt_toolbar[]. "Escolha o Detalhe
**  APPEND cl_gui_alv_grid=>mc_fc_excl_all              TO gt_toolbar[]. "Exclui todos os Botões
*  APPEND cl_gui_alv_grid=>mc_fc_expcrdata             TO gt_toolbar[]. "CrystalReportsTM (Exportar com dados)
*  APPEND cl_gui_alv_grid=>mc_fc_expcrdesig            TO gt_toolbar[]. "Crystal Reports (TM) (Start Designer)
*  APPEND cl_gui_alv_grid=>mc_fc_expcrtempl            TO gt_toolbar[]. "Cristal (Templo).
*  APPEND cl_gui_alv_grid=>mc_fc_expmdb                TO gt_toolbar[]. "Arquivo de banco de dados MicrosoftTM
*  APPEND cl_gui_alv_grid=>mc_fc_extend                TO gt_toolbar[]. "Funções de Consulta Adicionais
*  APPEND cl_gui_alv_grid=>mc_fc_f4                    TO gt_toolbar[]. "F4
*  APPEND cl_gui_alv_grid=>mc_fc_filter                TO gt_toolbar[]. "Filtros
*  APPEND cl_gui_alv_grid=>mc_fc_find                  TO gt_toolbar[]. "Achar
*  APPEND cl_gui_alv_grid=>mc_fc_find_more             TO gt_toolbar[]. "Procurar
*  APPEND cl_gui_alv_grid=>mc_fc_fix_columns           TO gt_toolbar[]. "Congelar Para Coluna
*  APPEND cl_gui_alv_grid=>mc_fc_graph                 TO gt_toolbar[]. "Gráfico
*  APPEND cl_gui_alv_grid=>mc_fc_help                  TO gt_toolbar[]. "Ajuda
*  APPEND cl_gui_alv_grid=>mc_fc_html                  TO gt_toolbar[]. "Baixar HTML
*  APPEND cl_gui_alv_grid=>mc_fc_info                  TO gt_toolbar[]. "Em Formação
*  APPEND cl_gui_alv_grid=>mc_fc_load_variant          TO gt_toolbar[]. "Variante de Leitura
*  APPEND cl_gui_alv_grid=>mc_fc_loc_append_row        TO gt_toolbar[]. "Local: Acrescentar Linha
*  APPEND cl_gui_alv_grid=>mc_fc_loc_copy              TO gt_toolbar[]. "Local: Copiar
*  APPEND cl_gui_alv_grid=>mc_fc_loc_copy_row          TO gt_toolbar[]. "Local: Copiar Linha
*  APPEND cl_gui_alv_grid=>mc_fc_loc_cut               TO gt_toolbar[]. "Local: Corte
*  APPEND cl_gui_alv_grid=>mc_fc_loc_delete_row        TO gt_toolbar[]. "Local: Excluir linha
*  APPEND cl_gui_alv_grid=>mc_fc_loc_insert_row        TO gt_toolbar[]. "Local: Inserir linha
*  APPEND cl_gui_alv_grid=>mc_fc_loc_move_row          TO gt_toolbar[]. "Local: mover linha
*  APPEND cl_gui_alv_grid=>mc_fc_loc_paste             TO gt_toolbar[]. "Local: Colar
*  APPEND cl_gui_alv_grid=>mc_fc_loc_paste_new_row     TO gt_toolbar[]. "Localmente: colar nova linha
*  APPEND cl_gui_alv_grid=>mc_fc_loc_undo              TO gt_toolbar[]. "Desfazer
*  APPEND cl_gui_alv_grid=>mc_fc_maintain_variant      TO gt_toolbar[]. "Gerenciar Variantes
*  APPEND cl_gui_alv_grid=>mc_fc_maximum               TO gt_toolbar[]. "Máximo
*  APPEND cl_gui_alv_grid=>mc_fc_minimum               TO gt_toolbar[]. "Mínimo
*  APPEND cl_gui_alv_grid=>mc_fc_pc_file               TO gt_toolbar[]. "Back-end de Impressão
*  APPEND cl_gui_alv_grid=>mc_fc_print                 TO gt_toolbar[]. "Visualizar impressão
*  APPEND cl_gui_alv_grid=>mc_fc_print_back            TO gt_toolbar[]. "Gravação para registro
*  APPEND cl_gui_alv_grid=>mc_fc_print_prev            TO gt_toolbar[]. "Gravação para registro
*  APPEND cl_gui_alv_grid=>mc_fc_refresh               TO gt_toolbar[]. "Atualizar
** FIM: Botões EXTRAS --------------------------------------------------*
*
** INICIO: Botões DEFUALT ----------------------------------------------*
*  APPEND cl_gui_alv_grid=>mc_fc_reprep                TO gt_toolbar[]. "Interface de Relatório/Relatório
*  APPEND cl_gui_alv_grid=>mc_fc_save_variant          TO gt_toolbar[]. "Salvar variante
*  APPEND cl_gui_alv_grid=>mc_fc_select_all            TO gt_toolbar[]. "Selecione todas as linhas
*  APPEND cl_gui_alv_grid=>mc_fc_send                  TO gt_toolbar[]. "Mandar
*  APPEND cl_gui_alv_grid=>mc_fc_separator             TO gt_toolbar[]. "Separador
*  APPEND cl_gui_alv_grid=>mc_fc_sort                  TO gt_toolbar[]. "Ordenar
*  APPEND cl_gui_alv_grid=>mc_fc_sort_asc              TO gt_toolbar[]. "Classificar em Ordem Crescente
*  APPEND cl_gui_alv_grid=>mc_fc_sort_dsc              TO gt_toolbar[]. "Classificar em Ordem Decrescente
*  APPEND cl_gui_alv_grid=>mc_fc_subtot                TO gt_toolbar[]. "Subtotais
*  APPEND cl_gui_alv_grid=>mc_fc_sum                   TO gt_toolbar[]. "Total
*  APPEND cl_gui_alv_grid=>mc_fc_to_office             TO gt_toolbar[]. "Escritório de Exportação
*  APPEND cl_gui_alv_grid=>mc_fc_to_rep_tree           TO gt_toolbar[]. "Exportar Árvore de Relatórios
*  APPEND cl_gui_alv_grid=>mc_fc_unfix_columns         TO gt_toolbar[]. "Descongelar Colunas
*  APPEND cl_gui_alv_grid=>mc_fc_url_copy_to_clipboard TO gt_toolbar[]. "Gerar URL para Chamada RFC
*  APPEND cl_gui_alv_grid=>mc_fc_variant_admin         TO gt_toolbar[]. "Código de Função
*  APPEND cl_gui_alv_grid=>mc_fc_views                 TO gt_toolbar[]. "Ver Alteração
*  APPEND cl_gui_alv_grid=>mc_fc_view_crystal          TO gt_toolbar[]. "Crystal Preview no local
*  APPEND cl_gui_alv_grid=>mc_fc_view_excel            TO gt_toolbar[]. "Excel no local
*  APPEND cl_gui_alv_grid=>mc_fc_view_grid             TO gt_toolbar[]. "Controle de rede
*  APPEND cl_gui_alv_grid=>mc_fc_view_lotus            TO gt_toolbar[]. "Lotus Inplace
*  APPEND cl_gui_alv_grid=>mc_fc_word_processor        TO gt_toolbar[]. "Processador de Texto
* FIM: Botões DEFUALT -------------------------------------------------*
ENDFORM.
