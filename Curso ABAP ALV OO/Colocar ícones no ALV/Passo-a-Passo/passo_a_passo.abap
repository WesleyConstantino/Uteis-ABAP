
*-----------------------------------------------------------------------------------------------------------*
"Passo 1: Declarar o iclude da tabela icon.
INCLUDE <icon>.

*-----------------------------------------------------------------------------------------------------------*
"Passo 2: Declarar um Type com os campos da minha tabela transparente e o campo 
          "icon-id" da tabela "icon".
TYPES:
 BEGIN OF ty_curso_aluno.
   INCLUDE   TYPE ztaula_curs_alun.
TYPES: id TYPE icon-id,
 END OF ty_curso_aluno.

*-----------------------------------------------------------------------------------------------------------*
"Passo 3: Criar a lógica no select de quais icones aparecerão, de acordo com as condições.
  "SELECT *
  "FROM ztaula_curs_alun
  "INTO TABLE it_ztaula_curs_alun[]
  "WHERE nome_curso IN s_curso[].

LOOP AT it_ztaula_curs_alun[] ASSIGNING FIELD-SYMBOL(<fs_curso_alun>).
 IF <fs_curso_alun>-inscr_confirmada EQ 'X' AND <fs_curso_alun>-pgtp_confirmado EQ 'X'.
  <fs_curso_alun>-id = icon_green_light.
 ELSEIF <fs_curso_alun>-inscr_confirmada EQ 'X' AND <fs_curso_alun>-pgtp_confirmado IS INITIAL.
  <fs_curso_alun>-id = icon_yellow_light.
 ELSE.
  <fs_curso_alun>-id = icon_red_light.
 ENDIF.
ENDLOOP.

*-----------------------------------------------------------------------------------------------------------*
"Passo 4: Adiciono o campo de icones na montagem do meu fieldcat.
  "PERFORM zf_build_fieldcat USING:
             'ID'         'ID'         'ICON'         'Status'      ' ' CHANGING lt_fieldcat[],
         "   'NOME_CURSO' 'NOME_CURSO' 'ZTAULA_CURSO' 'Curso'       ' ' CHANGING lt_fieldcat[],
         "   'DT_INICIO'  'DT_INICIO'  'ZTAULA_CURSO' 'Dt. Início'  ' ' CHANGING lt_fieldcat[],
         "   'DT_FIM'     'DT_FIM'     'ZTAULA_CURSO' 'Dt. Fim'     ' ' CHANGING lt_fieldcat[],
         "   'ATIVO'      'ATIVO'      'ZTAULA_CURSO' 'Ativo'       'X' CHANGING lt_fieldcat[].

*-----------------------------------------------------------------------------------------------------------*
"Passo 5: No meu form zf_build_fieldcat, passo o campo ID como um ícone, para que fique centralizado.
"FORM zf_build_fieldcat USING VALUE(p_fieldname) TYPE c
 "                            VALUE(p_field)     TYPE c
 "                            VALUE(p_table)     TYPE c
 "                            VALUE(p_coltext)   TYPE c
 "                            VALUE(p_checkbox)  TYPE c
                              VALUE(p_icon)      TYPE c
 "                         CHANGING t_fieldcat   TYPE lvc_t_fcat.

"  DATA: ls_fieldcat LIKE LINE OF t_fieldcat[].
   ls_fieldcat-icon = p_icon.

*-----------------------------------------------------------------------------------------------------------*
"Passo 6: Adiciono no meu monta fieldcat mais uma coluna, quem estiver flegado como 'X' será reconhecido
        "como um ícone.
  "PERFORM zf_build_fieldcat USING:
             'ID'         'ID'         'ICON'         'Status'      ' '  'X' CHANGING lt_fieldcat[],
         "   'NOME_CURSO' 'NOME_CURSO' 'ZTAULA_CURSO' 'Curso'       ' '  ' '  CHANGING lt_fieldcat[],
         "   'DT_INICIO'  'DT_INICIO'  'ZTAULA_CURSO' 'Dt. Início'  ' '  ' ' CHANGING lt_fieldcat[],
         "   'DT_FIM'     'DT_FIM'     'ZTAULA_CURSO' 'Dt. Fim'     ' '  ' ' CHANGING lt_fieldcat[],
         "   'ATIVO'      'ATIVO'      'ZTAULA_CURSO' 'Ativo'       'X'  ' ' CHANGING lt_fieldcat[].
