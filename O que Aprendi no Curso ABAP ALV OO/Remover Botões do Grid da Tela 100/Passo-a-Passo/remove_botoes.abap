"Passo 1: Declarar essa variável abaixo.
it_tool_bar TYPE ui_functions, "Variável para remover botões inúteis do grid
*----------------------------------------------------------------------------------------------------------------------*

"Passo 2: Adicionar a linha abaixo no form que monta o grid. no nosso caso os "zf_build_grida" e "zf_build_gridb".
it_toolbar_excluding = it_tool_bar[] "Remoção de botões do grid
*----------------------------------------------------------------------------------------------------------------------*

"Passo 3: Criaar um form passando todos os botões que desejo remover. Basta descomentar o que quero que seja removido.
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
*----------------------------------------------------------------------------------------------------------------------*

"Passo 4: Chamo o PERFORM zf_remove_alv_buttons no form zf_show_grid_100.

