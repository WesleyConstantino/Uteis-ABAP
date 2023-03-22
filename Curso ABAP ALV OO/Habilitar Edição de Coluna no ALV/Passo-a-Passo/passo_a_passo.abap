"Habilitar Edição de Coluna no ALV

"Passo 1: Adicionar no form zf_build_fieldcat a propriedade edit.

"FORM zf_build_fieldcat USING VALUE(p_fieldname) TYPE c
                             "VALUE(p_field)     TYPE c
                             "VALUE(p_table)     TYPE c
                             "VALUE(p_coltext)   TYPE c
                             "VALUE(p_checkbox)  TYPE c
                             "VALUE(p_icon)      TYPE c
                             "VALUE(p_emphasize) TYPE c
                              VALUE(p_edit)      TYPE c
                          "CHANGING t_fieldcat   TYPE lvc_t_fcat.

"  DATA: ls_fieldcat LIKE LINE OF t_fieldcat[].

  "Nome do campo dado na tabela interna
"  ls_fieldcat-fieldname = p_fieldname.

  "Nome do campo na tabela transparente
"  ls_fieldcat-ref_field = p_field.

  "Tabela transparente
"  ls_fieldcat-ref_table = p_table.

  "Descrição que daremos para o campo no ALV.
"  ls_fieldcat-coltext   = p_coltext.

  "Checkbox (Campos que quero que sejam checkbox, marco como 'X' no m_show_grid_100)
"  ls_fieldcat-checkbox = p_checkbox.

  "ícones
"  ls_fieldcat-icon = p_icon.

  "Cor das Colunas
"  ls_fieldcat-emphasize = p_emphasize.

  "Habilitar edição de colunas no ALV
  ls_fieldcat-edit = p_edit.

"  APPEND ls_fieldcat TO t_fieldcat[].

"ENDFORM.
*------------------------------------------------------------------------------------------*


"Passo 2: Adicionar mais uma coluna referente ao "edit" nos forms zf_build_grida e zf_build_gridb
         "Feito isso é só marcar com um X o campo que desejo que seja editavel, nesse caso o campo VALOR.
         
FORM zf_build_gridb.

  PERFORM zf_build_fieldcat USING:
          'ID'               'ID'               'ICON'             'Status'          ' '  'X' ' ' ' ' CHANGING lt_fieldcatb[],
          'NOME_ALUNO'       'NOME_ALUNO'       'ZTAULA_CURS_ALUN' 'Nome'            ' '  ' ' ' ' ' ' CHANGING lt_fieldcatb[],
          'NOME_CURSO'       'NOME_CURSO'       'ZTAULA_CURS_ALUN' 'Curso'           ' '  ' ' ' ' ' ' CHANGING lt_fieldcatb[],
          'DT_NASCIMENTO'    'DT_NASCIMENTO'    'ZTAULA_CURS_ALUN' 'Dt.Nascimento'   ' '  ' ' ' ' ' ' CHANGING lt_fieldcatb[],
          'INSCR_CONFIRMADA' 'INSCR_CONFIRMADA' 'ZTAULA_CURS_ALUN' 'Insc.Confirmada' 'X'  ' ' ' ' ' ' CHANGING lt_fieldcatb[],
          'PGTO_CONFIRMADO'  'PGTO_CONFIRMADO'  'ZTAULA_CURS_ALUN' 'Pag.Confirmado'  'X'  ' ' ' ' ' ' CHANGING lt_fieldcatb[],
          'VALOR'            'VALOR'  'ZTAULA_CURS_ALUN'           'Valor'           ' '  ' ' ' ' 'X' CHANGING lt_fieldcatb[].
"(...)

FORM zf_build_grida.

  PERFORM zf_build_fieldcat USING:
            'NOME_CURSO' 'NOME_CURSO' 'ZTAULA_CURSO' 'Curso'      ' '  ' ' 'C710' ' ' CHANGING lt_fieldcat[],
            'DT_INICIO'  'DT_INICIO'  'ZTAULA_CURSO' 'Dt. Início' ' '  ' ' ' '    ' ' CHANGING lt_fieldcat[],
            'DT_FIM'     'DT_FIM'     'ZTAULA_CURSO' 'Dt. Fim'    ' '  ' ' ' '    ' ' CHANGING lt_fieldcat[],
            'ATIVO'      'ATIVO'      'ZTAULA_CURSO' 'Ativo'      'X'  ' ' ' '    ' ' CHANGING lt_fieldcat[].
"(...)
*------------------------------------------------------------------------------------------*


"Passo 3: No passo 2 a edição de campos já está ativa, contudo, para torná-la real também na 
         "nossa tabela transparente, precisaremos fazer mais algumas coisas.
         "Iniciaremos chamando o método register_edit_event e preenchendo-o, faremos isso no 
         "form zf_build_gridb (o que monta o fieldcat da tabela que terá campos editaveis).

"FORM zf_build_gridb.

"  PERFORM zf_build_fieldcat USING:
"          'ID'               'ID'               'ICON'             'Status'          ' '  'X' ' ' ' ' CHANGING lt_fieldcatb[],
"          'NOME_ALUNO'       'NOME_ALUNO'       'ZTAULA_CURS_ALUN' 'Nome'            ' '  ' ' ' ' ' ' CHANGING lt_fieldcatb[],
"          'NOME_CURSO'       'NOME_CURSO'       'ZTAULA_CURS_ALUN' 'Curso'           ' '  ' ' ' ' ' ' CHANGING lt_fieldcatb[],
"          'DT_NASCIMENTO'    'DT_NASCIMENTO'    'ZTAULA_CURS_ALUN' 'Dt.Nascimento'   ' '  ' ' ' ' ' ' CHANGING lt_fieldcatb[],
"          'INSCR_CONFIRMADA' 'INSCR_CONFIRMADA' 'ZTAULA_CURS_ALUN' 'Insc.Confirmada' 'X'  ' ' ' ' ' ' CHANGING lt_fieldcatb[],
"          'PGTO_CONFIRMADO'  'PGTO_CONFIRMADO'  'ZTAULA_CURS_ALUN' 'Pag.Confirmado'  'X'  ' ' ' ' ' ' CHANGING lt_fieldcatb[],
"          'VALOR'            'VALOR'  'ZTAULA_CURS_ALUN'           'Valor'           ' '  ' ' ' ' 'X' CHANGING lt_fieldcatb[].

"  IF lo_grid_100b IS INITIAL.
    "Containerb, criado no layout da tela 100
"    lo_container_100b = NEW cl_gui_custom_container( container_name = 'CONTAINERB' ).
    "Instância o objeto do ALV
"    lo_grid_100b = NEW cl_gui_alv_grid( i_parent = lo_container_100b )."Caso não precise de 2 containers, uso : "( i_parent = cl_gui_custom_container=>default_screen )."

    "Permite fazer seleção múltipla de linhas no ALV
"    lo_grid_100b->set_ready_for_input( 1 ).

    "Permitir capturar evento de campo editavel do ALV e fazer a modificação da célula
     lo_grid_100b->register_edit_event(
      i_event_id = cl_gui_alv_grid=>mc_evt_modified
     ).

    "Chama o ALV pela primeira vez
"    lo_grid_100b->set_table_for_first_display(
"    EXPORTING
"      it_toolbar_excluding = it_tool_bar[] "Remoção de botões do grid
"      is_variant  = ls_variant
"      is_layout   = ls_layout
"      i_save      = 'A'
"    CHANGING
"      it_fieldcatalog = lt_fieldcatb[]
"      it_outtab       = it_ztaula_curs_alun[]
"    ).

    "Define título do ALV
"    lo_grid_100b->set_gridtitle( 'Lista de Alunos' ).
"  ELSE.
    "Atualiza tela, caso haja alteração nos dados da tabela interna
"    lo_grid_100b->refresh_table_display( ).
"  ENDIF.

"ENDFORM.
*------------------------------------------------------------------------------------------*

"Passo 4: Criar a definição da classe de edição (evento).

CLASS lcl_event_grid DEFINITION.
  PUBLIC SECTION.
    METHODS:
     data_changed "Nome qualquer
      FOR EVENT data_changed "Nome do evento da classe abaixo
      OF cl_gui_alv_grid IMPORTING er_data_changed  "Nome da classe e importação dos parâmetros dela
                                   e_onf4
                                   e_onf4_before
                                   e_onf4_after
                                   e_ucomm.
ENDCLASS.
*------------------------------------------------------------------------------------------*

"Passo 5: Criar a implementação da classe de edição (evento). Posso colocá-la logo abaixo da definição.

CLASS lcl_event_grid IMPLEMENTATION.
 
 METHOD data_changed.

 ENDMETHOD.
ENDCLASS.
*------------------------------------------------------------------------------------------*

"Passo 6: Declaro uma variável para usar.
         "OBS: Deve ser declarada após a classe para não dar dump.

DATA: lo_event_grid TYPE REF TO lcl_event_grid.
*------------------------------------------------------------------------------------------*

"Passo 7: Crio o objeto de lcl_event_grid( ) e faço um SET HANDLER no form zf_build_gridb.
          "Criação do objeto
          "lo_event_grid = NEW lcl_event_grid( ).  
          "SET HANDLER
          "SET HANDLER lo_event_grid->data_changed FOR lo_grid_100b

"FORM zf_build_gridb.

"  PERFORM zf_build_fieldcat USING:
"          'ID'               'ID'               'ICON'             'Status'          ' '  'X' ' ' ' ' CHANGING lt_fieldcatb[],
"          'NOME_ALUNO'       'NOME_ALUNO'       'ZTAULA_CURS_ALUN' 'Nome'            ' '  ' ' ' ' ' ' CHANGING lt_fieldcatb[],
"          'NOME_CURSO'       'NOME_CURSO'       'ZTAULA_CURS_ALUN' 'Curso'           ' '  ' ' ' ' ' ' CHANGING lt_fieldcatb[],
"          'DT_NASCIMENTO'    'DT_NASCIMENTO'    'ZTAULA_CURS_ALUN' 'Dt.Nascimento'   ' '  ' ' ' ' ' ' CHANGING lt_fieldcatb[],
"          'INSCR_CONFIRMADA' 'INSCR_CONFIRMADA' 'ZTAULA_CURS_ALUN' 'Insc.Confirmada' 'X'  ' ' ' ' ' ' CHANGING lt_fieldcatb[],
"          'PGTO_CONFIRMADO'  'PGTO_CONFIRMADO'  'ZTAULA_CURS_ALUN' 'Pag.Confirmado'  'X'  ' ' ' ' ' ' CHANGING lt_fieldcatb[],
"          'VALOR'            'VALOR'  'ZTAULA_CURS_ALUN'           'Valor'           ' '  ' ' ' ' 'X' CHANGING lt_fieldcatb[].

"  IF lo_grid_100b IS INITIAL.
    "Containerb, criado no layout da tela 100
"    lo_container_100b = NEW cl_gui_custom_container( container_name = 'CONTAINERB' ).
    "Instância o objeto do ALV
"    lo_grid_100b = NEW cl_gui_alv_grid( i_parent = lo_container_100b )."Caso não precise de 2 containers, uso : "( i_parent = cl_gui_custom_container=>default_screen )."
    "Objeto criado para evento de edição do grid
    lo_event_grid = NEW lcl_event_grid( ).

    "Permite fazer seleção múltipla de linhas no ALV
"    lo_grid_100b->set_ready_for_input( 1 ).

    "Permitir capturar evento de campo editavel do ALV e fazer a modificação de grid
"    lo_grid_100b->register_edit_event(
"     i_event_id = cl_gui_alv_grid=>mc_evt_modified
"    ).

    "Chama o ALV pela primeira vez
"    lo_grid_100b->set_table_for_first_display(
"    EXPORTING
"      it_toolbar_excluding = it_tool_bar[] "Remoção de botões do grid
"      is_variant  = ls_variant
"      is_layout   = ls_layout
"      i_save      = 'A'
"    CHANGING
"      it_fieldcatalog = lt_fieldcatb[]
"      it_outtab       = it_ztaula_curs_alun[]
"    ).

    "Define título do ALV
"    lo_grid_100b->set_gridtitle( 'Lista de Alunos' ).

    SET HANDLER lo_event_grid->data_changed FOR lo_grid_100b. 
"  ELSE.
    "Atualiza tela, caso haja alteração nos dados da tabela interna
"    lo_grid_100b->refresh_table_display( ).
"  ENDIF.

"ENDFORM.
*------------------------------------------------------------------------------------------*

"Passo 8: Criar a lógica da implementação da classe de edição (evento). 
         "OBS: Devo passar essa implementação para depois das minhas variáveis, para não dar dump.

"CLASS lcl_event_grid IMPLEMENTATION.
 
" METHOD data_changed.
   LOOP AT er_data_changed->mt_good_cells[] ASSIGNING FIELD-SYMBOL(<fs_good_cells>).
    READ TABLE it_ztaula_curs_alun[] ASSIGNING FIELD-SYMBOL(<fs_zaula_curso_alun>) INDEX <fs_good_cells>-row_id.  "it_ztaula_curs_alun[] é a tabela de saida do form zf_build_gridb.
     CASE <fs_good_cells>-fieldname.
      WHEN 'VALOR'. "Nome do campo a ser modificado
        <fs_zaula_curso_alun>-valor = <fs_good_cells>-value. "Passo o valor editado em tala para o field-symbol.
     ENDCASE.
   ENDLOOP.  
" ENDMETHOD.
"ENDCLASS.
