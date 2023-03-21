"Adicionando Cores nas Colunas do ALV

"Passo 1: Adicionar no types mais uma linha "color TYPE char4".

"TYPES:
  "BEGIN OF ty_curso_aluno.
    "INCLUDE   TYPE ztaula_curs_alun.
    "TYPES: id    TYPE icon-id,
           color TYPE char4,
  "END OF ty_curso_aluno.
*-------------------------------------------------------------------------------------*

"Passo 2: Passar o código de cor para o campo color de acordo com a condicional.  
         "OBS: As cores no Abap tem códigos, como é o caso do C500, C300 e C600.

  "LOOP AT it_ztaula_curs_alun[] ASSIGNING FIELD-SYMBOL(<fs_curso_alun>).
    "IF <fs_curso_alun>-inscr_confirmada EQ 'X' AND <fs_curso_alun>-pgto_confirmado EQ 'X'.
      "<fs_curso_alun>-id    = icon_green_light.
       <fs_curso_alun>-color = 'C500'.
    "ELSEIF <fs_curso_alun>-inscr_confirmada EQ 'X' AND <fs_curso_alun>-pgto_confirmado IS INITIAL.
      "<fs_curso_alun>-id    = icon_yellow_light.
       <fs_curso_alun>-color = 'C300'.
    "ELSE.
      "<fs_curso_alun>-id    = icon_red_light.
       <fs_curso_alun>-color = 'C600'.
    "ENDIF.
  "ENDLOOP.
*-------------------------------------------------------------------------------------*


"Passo 3: Definir a propriedade ls_layout-info_fname = 'COLOR', no layout do module 
         "m_show_grid_100.

"MODULE m_show_grid_100 OUTPUT.
  "FREE: lt_fieldcat[].

  "ls_layout-cwidth_opt = 'X'. "Ajustar largura das colunas (Layout otimizado).
  "ls_layout-zebra      = 'X'. "Layout em Zebra.
   ls_layout-info_fname = 'COLOR'. "Cor das linhas
  "ls_variant-report    = sy-repid. "Variante (Não usá-la quando o tipo foi pop-up).

  "PERFORM zf_remove_alv_buttons. "Remover botões do grid
  "PERFORM zf_build_grida.
  "PERFORM zf_build_gridb.

"ENDMODULE.
