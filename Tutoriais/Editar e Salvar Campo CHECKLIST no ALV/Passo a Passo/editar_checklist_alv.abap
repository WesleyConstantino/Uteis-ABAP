"Editar e Atualizar Checklist no ALV:

"Passo 1: Criar as estruturas variáveis:

DATA:
  lo_grid_100       TYPE REF TO cl_gui_alv_grid, "Grid
  lv_okcode_100     TYPE sy-ucomm,               "Ok code do module pool
  lt_fieldcat       TYPE lvc_t_fcat,             "Fieldcat
  ls_layout         TYPE lvc_s_layo,             "Layout
  ls_variant        TYPE disvariant,             "Variant
  go_container_9000 TYPE REF TO cl_gui_custom_container. "Container
*--------------------------------------------------------------------------------------------------------------*


"Passo 2: Já no início da execusão do programa chamo a minha tela do module pool, no meu caso a tela 100.

START-OF-SELECTION.
  CALL SCREEN 100.
*--------------------------------------------------------------------------------------------------------------*


"Psso 3: No form zf_show_grid_100 (onde montei o fieldcat e crio os objetos do grid), crios os seguintes
         "objetos:

*-------*Quando estiver usando container do module pool:
    "Criação do objeto do container
    go_container_9000 = NEW cl_gui_custom_container( container_name = 'CONTAINER_9000' ).
    "Instância o objeto do ALV
    lo_grid_100 = NEW cl_gui_alv_grid( i_parent = go_container_9000 ).

    "Permite fazer seleção múltipla de linhas no ALV
    lo_grid_100->set_ready_for_input( 1 ).

*-------*Sem o uso de container:
     lo_grid_100 = NEW cl_gui_alv_grid( i_parent = cl_gui_custom_container=>default_screen ).

    "Permite fazer seleção múltipla de linhas no ALV
    lo_grid_100->set_ready_for_input( 1 ).
*--------------------------------------------------------------------------------------------------------------*


"Passo 4: No MODULE STATUS_0100 do PROCESS BEFORE OUTPUT faço a chamada dos performs zf_select e zf_show_grid_100.

MODULE status_0100 OUTPUT.
  SET PF-STATUS 'STATUS100'. "Botões da tela 100
  SET TITLEBAR 'TITULE100'.  "Código do título da Tela 100

  PERFORM: zf_select,
           zf_show_grid_100.
ENDMODULE.
*--------------------------------------------------------------------------------------------------------------*


"Passo 5: No MODULE USER_COMMAND_0100 do PROCESS AFTER INPUT, implemento a lógica dos botões.

MODULE user_command_0100 INPUT.

  CASE lv_okcode_100.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0. "Volta para a tela chamadora
      "CLEAR: lv_salvou_item.
    WHEN 'EXIT'.
      LEAVE PROGRAM. "Sai do programa
      "CLEAR: lv_salvou_item.
    WHEN 'EXCLUSAO' OR 'INCLUSAO'.
      PERFORM: z_exl_e_inc_insumos USING lv_okcode_100.
  ENDCASE.

ENDMODULE.
*--------------------------------------------------------------------------------------------------------------*


"Passo 6: Crio um form para marcar ou desmarcar o campo do checklist com 'X' e atualizar a tabela transpareste com
         "essa alteração. No final, chamo o form que faz meu select para que a tela seja atualizada.

FORM z_exl_e_inc_insumos  USING    p_lv_okcode_100.

  DATA: lt_selected_rows        TYPE lvc_t_row,
        wa_zpficat_pinsumos_aux TYPE zpficat_pinsumos.

  lo_grid_100->get_selected_rows(
    IMPORTING
      et_index_rows = lt_selected_rows ).

  LOOP AT lt_selected_rows INTO DATA(wa_selected_rows).

    READ TABLE t_zpficat_pinsumos
     INTO DATA(wa_zpficat_pinsumos)
         INDEX wa_selected_rows-index.

    IF sy-subrc IS INITIAL   AND
     (  p_lv_okcode_100 EQ 'EXCLUSAO' OR
        p_lv_okcode_100 EQ 'INCLUSAO' ).


      IF  p_lv_okcode_100 EQ 'EXCLUSAO'.
        wa_zpficat_pinsumos-exclusao = 'X'.
      ELSEIF  p_lv_okcode_100 EQ 'INCLUSAO'.
        wa_zpficat_pinsumos-exclusao = ' '.
      ENDIF.

      MOVE-CORRESPONDING wa_zpficat_pinsumos TO wa_zpficat_pinsumos_aux.
      MODIFY zpficat_pinsumos FROM wa_zpficat_pinsumos_aux.

      PERFORM z_commit_e_rollback.

      CLEAR: wa_zpficat_pinsumos_aux.
    ENDIF.
  ENDLOOP.
  PERFORM: zf_select.
ENDFORM.
*--------------------------------------------------------------------------------------------------------------*


"Passo 7: For fim, crio um form para se resposabilazar pelo commit e rollback 

FORM z_commit_e_rollback.

  IF sy-subrc IS INITIAL.
    COMMIT WORK AND WAIT.
    MESSAGE s208(00) WITH text-m02. "Alterações Realizadas com Sucesso!

  ELSE.
    ROLLBACK WORK.
    MESSAGE s208(00) WITH text-m03 DISPLAY LIKE 'E'. "Erro ao Tentar Gravar as Alterações!

  ENDIF.
ENDFORM.
