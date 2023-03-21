"Adicionando Cores nas Colunas do ALV


Passo 1: No form zf_build_fieldcat, adicionar o "emphasize".

"FORM zf_build_fieldcat USING VALUE(p_fieldname) TYPE c
                        "     VALUE(p_field)     TYPE c
                        "     VALUE(p_table)     TYPE c
                        "     VALUE(p_coltext)   TYPE c
                        "     VALUE(p_checkbox)  TYPE c
                        "     VALUE(p_icon)      TYPE c
                              VALUE(p_emphasize) TYPE c
                        "  CHANGING t_fieldcat   TYPE lvc_t_fcat.

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
   ls_fieldcat-emphasize = p_emphasize.

"  APPEND ls_fieldcat TO t_fieldcat[].

"ENDFORM.
*-------------------------------------------------------------------------------------*


Passo 3: Adiciono mais um campo de parâmetro nos forms zf_build_grida e zf_build_gridb 
         "para definir onde será emphasize.
         "OBS: Passo o código da cor no campo da coluna que desejo que seja alterada.
         "Para o campo NOME_CURSO, passei o código da cor C300.
"Antes de implementar:
FORM zf_build_grida.

  PERFORM zf_build_fieldcat USING:
            'NOME_CURSO' 'NOME_CURSO' 'ZTAULA_CURSO' 'Curso'      ' '  ' ' CHANGING lt_fieldcat[],
            'DT_INICIO'  'DT_INICIO'  'ZTAULA_CURSO' 'Dt. Início' ' '  ' ' CHANGING lt_fieldcat[],
            'DT_FIM'     'DT_FIM'     'ZTAULA_CURSO' 'Dt. Fim'    ' '  ' ' CHANGING lt_fieldcat[],
            'ATIVO'      'ATIVO'      'ZTAULA_CURSO' 'Ativo'      'X'  ' ' CHANGING lt_fieldcat[].

"Após implementar:
FORM zf_build_grida.

  PERFORM zf_build_fieldcat USING:
            'NOME_CURSO' 'NOME_CURSO' 'ZTAULA_CURSO' 'Curso'      ' '  ' ' 'C300' CHANGING lt_fieldcat[],
            'DT_INICIO'  'DT_INICIO'  'ZTAULA_CURSO' 'Dt. Início' ' '  ' ' ' '    CHANGING lt_fieldcat[],
            'DT_FIM'     'DT_FIM'     'ZTAULA_CURSO' 'Dt. Fim'    ' '  ' ' ' '    CHANGING lt_fieldcat[],
            'ATIVO'      'ATIVO'      'ZTAULA_CURSO' 'Ativo'      'X'  ' ' ' '    CHANGING lt_fieldcat[].

"OBS: Não posso esquecer de adicionar o parâmetro do novo campo também no form zf_build_gridb.
*-------------------------------------------------------------------------------------*

