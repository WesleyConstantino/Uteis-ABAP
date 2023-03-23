"Salvar os Dados Editados do Grid

"Passo 1: Criar o botão "save" no module pool nas Teclas de Função.
          "Caminho: Estrutura do programa no module pool -> Pasta telas -> 0100 -> MODULE STATUS_0100 -> 
           "-> SET PF-STATUS 'STATUS100' -> Teclas de função -> Digitar "SAVE" no campo do botão salvar.
*------------------------------------------------------------------------------------------------------------------*

"Passo 2: Criar o outro botão "salvar" no module pool na Barra de Ferramentas.
          "Caminho: Estrutura do programa no module pool -> Pasta telas -> 0100 -> MODULE STATUS_0100 -> 
           "-> SET PF-STATUS 'STATUS100' -> Barra de ferramentas -> No campo "Itens 1-  7" digitar o nome do botão 
           "Salvar" -> Dar enter -> Deixar como texto estático e dar ok -> Preencher: Texto de função = Salvar,
           "Nome do ícone = escolher no match code, Texto de informação = Salvar -> Escolher uma tecla do teclado para chamá-lo 
           "aqui F8 -> Clicar 2 vezes sobre o ícone do botão e colocar "Texto ícone" e "Texto Informação" como Salvar
           " -> Ativar.
*------------------------------------------------------------------------------------------------------------------*

"Passo 3: Ir no MODULE USER_COMMAND_0100 da nossa tela 100 e adicionar nosso botão "SAVE" e 'SALVAR' na logica do 
         "case comando o perform zf_salvar_alteracoes, que criaremos no passo seginte.

"MODULE user_command_0100 INPUT.

"  CASE lv_okcode_100.
"    WHEN 'BACK'.
"      LEAVE TO SCREEN 0. "Volta para a tela chamadora
"    WHEN 'EXIT'.
"      LEAVE PROGRAM. "Sai do programa
    WHEN 'SAVE' OR 'SALVAR'..
     PERFORM zf_salvar_alteracoes.
"  ENDCASE.

"ENDMODULE.
*------------------------------------------------------------------------------------------------------------------*

"Passo 4: Criar um form para salvar as alterações.

FORM zf_salvar_alteracoes.

ENDFORM.
*------------------------------------------------------------------------------------------------------------------*

"Passo 5: Criar uma variável global TYPE char1.

DATA: lv_salvou_item TYPE char1.
*------------------------------------------------------------------------------------------------------------------*

"Passo 6: Modidico a tabela que tem o campo editável com a tabela interna dela, se der tudo certo faço um commit,
          marco a variável lv_salvou_item como 'X' e chamo o perform zf_obtem_dados para carregar os dados atualizados
          "em tela, senão, dou rollback e apresente mensagem de erro.

"FORM zf_salvar_alteracoes.
  MODIFY ztaula_curs_alun FROM TABLE it_ztaula_curs_alun[].

  IF sy-subrc EQ 0.
   COMMIT WORK.
   lv_salvou_item = 'X'.
   PERFORM zf_obtem_dados.
   MESSAGE 'Dados salvos com sucesso!' TYPE 'S'.
  ELSE.
   ROLLBACK WORK.
   MESSAGE 'Erro ao salvar dados' TYPE 'S' DISPLAY LIKE 'E'.
  ENDIF.
"ENDFORM
*------------------------------------------------------------------------------------------------------------------*

"Passo 7: No form zf_visualiza_alv_completo, implementaremos uma condição, caso a nossa variável lv_salvou_item
         "esteja flegada como 'X' chamaremos o método de refresh da tela.

"FORM zf_visualiza_alv_completo.

"  IF it_ztaula_curso[] IS NOT INITIAL OR it_ztaula_curs_alun[] IS NOT INITIAL.
   IF lv_salvou_item EQ 'X'.
     lo_grid_100->refresh_table_display( ). 
     lo_grid_100b->refresh_table_display( ). 
   ELSE.
"    CALL SCREEN 100. "Chama a tela principal.
   ENDIF.

"  ELSE.
"    MESSAGE 'Dados não localizados!' TYPE 'S' DISPLAY LIKE 'W'.
"  ENDIF.

"ENDFORM.

*------------------------------------------------------------------------------------------------------------------*

"Passo 8: No MODULE user_command_0100, adiciono um clear na variável lv_salvou_item, para que ela não fique eternamente 
         "suja, caso o usuário saia da tela a variável deve ficar limpa.

"MODULE user_command_0100 INPUT.

"  CASE lv_okcode_100.
"    WHEN 'BACK'.
"      LEAVE TO SCREEN 0. "Volta para a tela chamadora
       CLEAR: lv_salvou_item.
"    WHEN 'EXIT'.
"      LEAVE PROGRAM. "Sai do programa
       CLEAR: lv_salvou_item.
"    WHEN 'SAVE' OR 'SALVAR'..
"      PERFORM zf_salvar_alteracoes.
"  ENDCASE.

"ENDMODULE.
*------------------------------------------------------------------------------------------------------------------*

"Passo 9: No form zf_obtem_dados, preciso dar um FREE nas minhas tabelas para que elas não sejam duplicadas em tela 
         "quando eu apertar o botão para salvar.

"FORM zf_obtem_dados.
"  DATA: ls_zaula_curso_negr LIKE LINE OF lt_zaula_curso_negr[],
"        ls_celltab          LIKE LINE OF ls_zaula_curso_negr-celltab[].

FREE: it_ztaula_curso[],
      lt_zaula_curso_negr[].      

"  SELECT *
"  FROM ztaula_curso
"  INTO TABLE it_ztaula_curso[]
"  WHERE nome_curso IN s_curso[].

"  SELECT *
"  FROM ztaula_curs_alun
"  INTO TABLE it_ztaula_curs_alun[]
"  WHERE nome_curso IN s_curso[].

"  LOOP AT it_ztaula_curso[] ASSIGNING FIELD-SYMBOL(<fs_aula_curso>).
"    FREE: ls_zaula_curso_negr-celltab[].
"    MOVE-CORRESPONDING <fs_aula_curso> TO ls_zaula_curso_negr.

"    IF ls_zaula_curso_negr-ativo EQ 'X'.
"      ls_celltab-fieldname = 'DT_INICIO'. "Nome do campo que quero deixar em Negrito.
"      ls_celltab-style     = '00000121'.  "Código da fonte em Negrito.
"      INSERT ls_celltab INTO TABLE ls_zaula_curso_negr-celltab[].

"      ls_celltab-fieldname = 'DT_FIM'. "Nome do campo que quero deixar em Negrito.
"      ls_celltab-style     = '00000121'.  "Código da fonte em Negrito.
"      INSERT ls_celltab INTO TABLE ls_zaula_curso_negr-celltab[].
"    ENDIF.

"    APPEND ls_zaula_curso_negr TO lt_zaula_curso_negr[].
"  ENDLOOP.

"  LOOP AT it_ztaula_curs_alun[] ASSIGNING FIELD-SYMBOL(<fs_curso_alun>).
"    IF <fs_curso_alun>-inscr_confirmada EQ 'X' AND <fs_curso_alun>-pgto_confirmado EQ 'X'.
"      <fs_curso_alun>-id    = icon_green_light.
"      <fs_curso_alun>-color = 'C500'.
"    ELSEIF <fs_curso_alun>-inscr_confirmada EQ 'X' AND <fs_curso_alun>-pgto_confirmado IS INITIAL.
"      <fs_curso_alun>-id    = icon_yellow_light.
"      <fs_curso_alun>-color = 'C300'.
"    ELSE.
"      <fs_curso_alun>-id    = icon_red_light.
"      <fs_curso_alun>-color = 'C600'.
"    ENDIF.
"  ENDLOOP.

"  CASE r_basic.
"    WHEN 'X'.
"      PERFORM: zf_visualiza_alv_basico.
"    WHEN ' '.
"      PERFORM: zf_visualiza_alv_completo.
"  ENDCASE.
"ENDFORM.


*-----------* Passo diferente para checkbox editável

"Passo 10: No form zf_build_grida ou zf_build_gridb, adicionar método que atualiza a tela do fieldcat, caso haja 
          "alteração nos dados.


"FORM zf_build_grida.
"  PERFORM zf_build_fieldcat USING:
"            'NOME_CURSO' 'NOME_CURSO' 'ZTAULA_CURSO' 'Curso'      ' '  ' ' 'C710' ' ' CHANGING lt_fieldcat[],
"            'DT_INICIO'  'DT_INICIO'  'ZTAULA_CURSO' 'Dt. Início' ' '  ' ' ' '    ' ' CHANGING lt_fieldcat[],
"            'DT_FIM'     'DT_FIM'     'ZTAULA_CURSO' 'Dt. Fim'    ' '  ' ' ' '    ' ' CHANGING lt_fieldcat[],
"            'ATIVO'      'ATIVO'      'ZTAULA_CURSO' 'Ativo'      'X'  ' ' ' '    ' ' CHANGING lt_fieldcat[].

"  IF lo_grid_100 IS INITIAL.
    "Containera, criado no layout da tela 100
"    lo_container_100 = NEW cl_gui_custom_container( container_name = 'CONTAINERA' ).
    "Instância o objeto do ALV
"    lo_grid_100 = NEW cl_gui_alv_grid( i_parent = lo_container_100 )."Caso não precise de 2 containers, uso : "( i_parent = cl_gui_custom_container=>default_screen )."

    "Permite fazer seleção múltipla de linhas no ALV
"    lo_grid_100->set_ready_for_input( 1 ).

    "Chama o ALV pela primeira vez
"    lo_grid_100->set_table_for_first_display(
"    EXPORTING
"      it_toolbar_excluding = it_tool_bar[] "Remoção de botões do grid
"      is_variant  = ls_variant "Variant para seleção múltiplas do alv
"      is_layout   = ls_layout
"      i_save      = 'A'
"    CHANGING
"      it_fieldcatalog = lt_fieldcat[]
"      it_outtab       = lt_zaula_curso_negr[]  "Tabela de saída
"    ).

    "Define título do ALV
"    lo_grid_100->set_gridtitle( 'Lista de Cursos' ).
"  ELSE.
   "Força a atualização do fieldcat
   lo_grid_100a->set_frontend_fieldcatalog(
    EXPORTING
     it_fieldcatlog = lt_fieldcata[].
    ).
    "Atualiza tela, caso haja alteração nos dados da tabela interna
"    lo_grid_100->refresh_table_display( ).
"  ENDIF.

"ENDFORM.
