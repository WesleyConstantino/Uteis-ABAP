"Editar e Atualizar Checklist no ALV selecionando apenas o campo de checklist e não toda a linha:


***********************************************************************************************************************************
"Passo 1: No form zf_build_fieldcat, criar o edit para habilitar a edição direta do checklist.

*&---------------------------------------------------------------------*
*&      Form  zf_build_fieldcat
*&---------------------------------------------------------------------*
"FORM zf_build_fieldcat USING VALUE(p_fieldname) TYPE c
"                             VALUE(p_field)     TYPE c
"                             VALUE(p_table)     TYPE c
"                             VALUE(p_coltext)   TYPE c
"                             VALUE(p_checkbox)  TYPE c
"                             VALUE(p_icon)      TYPE c
"                             VALUE(p_emphasize) TYPE c
                             VALUE(p_edit)      TYPE c
"                          CHANGING t_fieldcat   TYPE lvc_t_fcat.

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


***********************************************************************************************************************************
"Passo 2: No form zf_show_grid_9000, marcar como 'X' a posição do edit no campo que quero que seja um checklist editável.

*&---------------------------------------------------------------------*
*&      Form  zf_build_grida
*&---------------------------------------------------------------------*
"FORM zf_show_grid_9000.

"  FREE: tg_fieldcat[],
"        wa_layout,
"        wa_variant.

"  wa_layout-cwidth_opt = 'X'. "Ajustar largura das colunas (Layout otimizado).
"  wa_layout-zebra      = 'X'. "Layout em Zebra.
"  wa_variant-report    = sy-repid. "Variante (Não usá-la quando o tipo foi pop-up).

"  PERFORM zf_build_fieldcat USING:
"            'NOME_CURSO' 'NOME_CURSO' 'ZTAULA_CURSO' 'Curso'      ' '  ' ' 'C710' ' ' CHANGING tg_fieldcat[],
"            'DT_INICIO'  'DT_INICIO'  'ZTAULA_CURSO' 'Dt. Início' ' '  ' ' ' '    ' ' CHANGING tg_fieldcat[],
"            'DT_FIM'     'DT_FIM'     'ZTAULA_CURSO' 'Dt. Fim'    ' '  ' ' ' '    ' ' CHANGING tg_fieldcat[],
            'ATIVO'      'ATIVO'      'ZTAULA_CURSO' 'Ativo'      'X'  ' ' ' '    'X' CHANGING tg_fieldcat[].
  
  
***********************************************************************************************************************************
"Passo 3:
