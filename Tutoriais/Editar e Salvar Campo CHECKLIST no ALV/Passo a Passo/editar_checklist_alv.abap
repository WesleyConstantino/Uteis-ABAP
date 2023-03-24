"Editar e Atualizar Checklist no ALV:

*Explicação: Esse trecho de código flega como 'X' ou desflega um campo checkbox de um ALV e salva essa alteração no banco de dados. 
***********************************************************************************************************************************

"Passo 1: Criar as estruturas variáveis:

*&---------------------------------------------------------------------*
*                           Estruturas                                 *
*&---------------------------------------------------------------------*
DATA:
  og_grid_9000      TYPE REF TO cl_gui_alv_grid, "Grid
  vg_okcode_9000    TYPE sy-ucomm,   "Ok Code do Module Pool
  tg_fieldcat       TYPE lvc_t_fcat, "Fieldcat
  wa_layout         TYPE lvc_s_layo, "Layout
  wa_variant        TYPE disvariant, "Variant
  og_container_9000 TYPE REF TO cl_gui_custom_container. "Container do Module Pool
*--------------------------------------------------------------------------------------------------------------*


"Passo 2: Já no início da execusão do programa chamo a minha tela do module pool, no meu caso a tela 9000.

START-OF-SELECTION.
  CALL SCREEN 9000.
*--------------------------------------------------------------------------------------------------------------*


"Psso 3: No form zf_show_grid_9000 (onde montei o fieldcat e crio os objetos do grid), crios os seguintes
         "objetos:

*-------*Quando estiver usando container do module pool:
    "Criação do objeto do container
    og_container_9000 = NEW cl_gui_custom_container( container_name = 'CONTAINER_9000' ).
    "Instância o objeto do ALV
    og_grid_9000 = NEW cl_gui_alv_grid( i_parent = og_container_9000 ).

    "Permite fazer seleção múltipla de linhas no ALV
    og_grid_9000->set_ready_for_input( 1 ).

*-------*Sem o uso de container:
     og_grid_9000 = NEW cl_gui_alv_grid( i_parent = cl_gui_custom_container=>default_screen ).

    "Permite fazer seleção múltipla de linhas no ALV
    og_grid_9000->set_ready_for_input( 1 ).
*--------------------------------------------------------------------------------------------------------------*


"Passo 4: No MODULE STATUS_9000 do PROCESS BEFORE OUTPUT faço a chamada dos performs zf_select e zf_show_grid_9000.

*&---------------------------------------------------------------------*
*&      Module  STATUS_9000  OUTPUT
*&---------------------------------------------------------------------*
MODULE status_9000 OUTPUT.
  SET PF-STATUS 'STATUS_9000'.
  SET TITLEBAR 'TITULE_9000'.

  PERFORM: zf_select,
           zf_show_grid_9000.
ENDMODULE.
*--------------------------------------------------------------------------------------------------------------*


"Passo 5: No MODULE USER_COMMAND_9000 do PROCESS AFTER INPUT, implemento a lógica dos botões.

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_9000  INPUT
*&---------------------------------------------------------------------*
MODULE user_command_9000 INPUT.

  CASE vg_okcode_9000.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0. "Volta para a tela chamadora
    WHEN 'EXIT'.
      LEAVE PROGRAM. "Sai do programa
    WHEN 'FLEGAR' OR 'DESFLEGAR'.
      PERFORM: zf_flegar_e_desflegar USING vg_okcode_9000.
  ENDCASE.

ENDMODULE.
*--------------------------------------------------------------------------------------------------------------*


"Passo 6: Crio um form para marcar ou desmarcar o campo do checklist e atualizar a tabela transpareste com
         "essa alteração. No final, chamo o form que faz meu select para que a tela seja atualizada.

*&---------------------------------------------------------------------*
*&      Form  ZF_FLEGAR_E_DESFLEGAR
*&---------------------------------------------------------------------*
FORM zf_flegar_e_desflegar  USING    p_vg_okcode_9000.

  DATA: tl_selected_rows    TYPE lvc_t_row,
        wa_ztaula_curso_aux TYPE ztaula_curso.

  og_grid_9000->get_selected_rows(
    IMPORTING
      et_index_rows = tl_selected_rows ).

  LOOP AT tl_selected_rows INTO DATA(wa_selected_rows).

    READ TABLE t_ztaula_curso
     INTO DATA(wa_ztaula_curso)
         INDEX wa_selected_rows-index.

    IF sy-subrc IS INITIAL   AND
     (  p_vg_okcode_9000 EQ 'FLEGAR' OR
        p_vg_okcode_9000 EQ 'DESFLEGAR' ).


      IF  p_vg_okcode_9000 EQ 'FLEGAR'.
        wa_ztaula_curso-ativo = 'X'.
      ELSEIF  p_vg_okcode_9000 EQ 'DESFLEGAR'.
        wa_ztaula_curso-ativo = ' '.
      ENDIF.

      MOVE-CORRESPONDING wa_ztaula_curso TO wa_ztaula_curso_aux.
      MODIFY ztaula_curso FROM wa_ztaula_curso_aux.

      PERFORM z_commit_e_rollback.

      CLEAR: wa_ztaula_curso_aux.
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
