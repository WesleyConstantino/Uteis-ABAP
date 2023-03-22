"Adicionando Negrito a Células do ALV

"Passo 1: Criar um Type da estrutura da tabela zaula_curso declarando o campo
          "celltab TYPE lvc_t_styl (que é uma tabela).

BEGIN OF ty_zaula_curso.
 INCLUDE TYPE zaula_curso.
 TYPES: celltab TYPE lvc_t_styl, "lvc_t_styl é uma tabela
END OF ty_zaula_curso.
*------------------------------------------------------------------------------------------*

"Passo 2: Criar a tabela interna do tipo ty_zaula_curso.

DATA: lt_zaula_curso_negr TYPE TABLE OF ty_zaula_curso.
*------------------------------------------------------------------------------------------*

"Passo 3: No form zf_obtem_dados, crio as workareas de lt_zaula_curso_negr e de lt_zaula_curso_negr-celltab.

DATA: ls_zaula_curso_negr LIKE LINE OF lt_zaula_curso_negr[],
      ls_celltab          LIKE LINE OF ls_zaula_curso_negr-celltab[]. 
*------------------------------------------------------------------------------------------*

"Passo 4: No form zf_obtem_dados, crio um field-symbol, faço um loop para percorrer a minha
         "lt_zaula_curso, passar os valores dela para o field-symbol e mover os valores 
         "correspondentes do field-symbol, agora populado, para a minha workarea ls_zaula_curso_negr.

LOOP AT lt_zaula_curso_negr[] ASSIGNING FIELD-SYMBOL(<fs_aula_curso>). 
    MOVE-CORRESPONDING <fs_aula_curso> TO ls_zaula_curso_negr.
ENDLOOP.
*------------------------------------------------------------------------------------------*

"Passo 5: Ainda no form form zf_obtem_dados, crio uma validação para se o campo "ativo" estiver
          "flegado, preencherei os campos "style" e "fieldname" da workarea ls_celltab.
          "Após isso faço um insert da workarea para a tabela interna. Faço isso para cada campo
          "que quiser deixar como Negrito. 
          "Por ultimo dou uma APPEND da ls_zaula_curso_negr para lt_zaula_curso_negr[].
          
          "OBS: Não esquecer de limpar a ls_zaula_curso_negr-celltab[].

"LOOP AT lt_zaula_curso_negr[] ASSIGNING FIELD-SYMBOL(<fs_aula_curso>). 
  FREE: ls_zaula_curso_negr-celltab[]. 
" MOVE-CORRESPONDINGG <fs_aula_curso> TO ls_zaula_curso_negr.
  IF ls_zaula_curso_negr-ativo EQ 'X'.
    ls_celltab-fieldname = 'DT_INICIO'. "Nome do campo que quero deixar em Negrito.
    ls_celltab-style     = '00000121'.  "Código da fonte em Negrito.
    INSERT ls_celltab INTO TABLE ls_zaula_curso_negr-celltab[].
    
    ls_celltab-fieldname = 'DT_FIM'. "Nome do campo que quero deixar em Negrito.
    ls_celltab-style     = '00000121'.  "Código da fonte em Negrito.
    INSERT ls_celltab INTO TABLE ls_zaula_curso_negr-celltab[].
  ENDIF.

    APPEND ls_zaula_curso_negr TO lt_zaula_curso_negr[].
"ENDLOOP.
*------------------------------------------------------------------------------------------*

"Passo 6: Agora pego a minha tabela it_zaula_curso_negr[] e passo como tabela de saída no form
         "lo_grid_100a.

"FORM zf_build_grida.

"  PERFORM zf_build_fieldcat USING:
 "           'NOME_CURSO' 'NOME_CURSO' 'ZTAULA_CURSO' 'Curso'      ' '  ' ' 'C710' CHANGING lt_fieldcat[],
 "           'DT_INICIO'  'DT_INICIO'  'ZTAULA_CURSO' 'Dt. Início' ' '  ' ' ' '    CHANGING lt_fieldcat[],
 "           'DT_FIM'     'DT_FIM'     'ZTAULA_CURSO' 'Dt. Fim'    ' '  ' ' ' '    CHANGING lt_fieldcat[],
 "           'ATIVO'      'ATIVO'      'ZTAULA_CURSO' 'Ativo'      'X'  ' ' ' '    CHANGING lt_fieldcat[].

"  IF lo_grid_100 IS INITIAL.
    "Containera, criado no layout da tela 100
"    lo_container_100 = NEW cl_gui_custom_container( container_name = 'CONTAINERA' ).
"    "Instância o objeto do ALV
"    lo_grid_100 = NEW cl_gui_alv_grid( i_parent = lo_container_100 )."Caso não precise de 2 containers, uso : "( i_parent = cl_gui_custom_container=>default_screen )."

    "Permite fazer seleção múltipla de linhas no ALV
 "   lo_grid_100->set_ready_for_input( 1 ).

    "Chama o ALV pela primeira vez
 "   lo_grid_100->set_table_for_first_display(
 "   EXPORTING
 "     it_toolbar_excluding = it_tool_bar[] "Remoção de botões do grid
 "     is_variant  = ls_variant "Variant para seleção múltiplas do alv
 "     is_layout   = ls_layout
 "     i_save      = 'A'
 "   CHANGING
 "     it_fieldcatalog = lt_fieldcat[]
      it_outtab       = lt_zaula_curso_negr[]  "Tabela de saída
 "   ).

    "Define título do ALV
 "   lo_grid_100->set_gridtitle( 'Lista de Cursos' ).
 " ELSE.
    "Atualiza tela, caso haja alteração nos dados da tabela interna
 "   lo_grid_100->refresh_table_display( ).
 " ENDIF.

"ENDFORM.
*------------------------------------------------------------------------------------------*

"Passo 7: No module m_show_grid_100, passo o atributo ls_layout-stylefname = 'CELLTAB'.

"MODULE m_show_grid_100 OUTPUT.
  "FREE: lt_fieldcat[].

  "ls_layout-cwidth_opt = 'X'. "Ajustar largura das colunas (Layout otimizado).
  "ls_layout-zebra      = 'X'. "Layout em Zebra.
  "ls_layout-info_fname = 'COLOR'. "Cor das linhas
   ls_layout-stylefname = 'CELLTAB'. "Texto em Negrito
  "ls_variant-report    = sy-repid. "Variante (Não usá-la quando o tipo foi pop-up).

  "PERFORM zf_remove_alv_buttons. "Remover botões do grid
  "PERFORM zf_build_grida.
  "PERFORM zf_build_gridb.

"ENDMODULE.
