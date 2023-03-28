REPORT ztrwc_teste_01.

*&---------------------------------------------------------------------*
*                            Variáveis                                 *
*&---------------------------------------------------------------------*
DATA: vg_result TYPE i.

*&---------------------------------------------------------------------*
*                         Tela de seleção                              *
*&---------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK b0 WITH FRAME TITLE text-000.
PARAMETERS: p_num1 TYPE i,
            p_num2 TYPE i.
SELECTION-SCREEN END OF BLOCK b0.

*Eventos
START-OF-SELECTION.
  IF p_num1 IS INITIAL OR p_num2 IS INITIAL.
    MESSAGE s398(00) WITH 'Digite os números que deseja somar!' DISPLAY LIKE 'E'.
  ELSE.
    PERFORM: zf_popup_to_confirm.
  ENDIF.

*&---------------------------------------------------------------------*
*&      Form  zf_popup_to_confirm
*&---------------------------------------------------------------------*
FORM zf_soma.

  vg_result = p_num1 + p_num2.

  WRITE:/ vg_result.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  zf_popup_to_confirm
*&---------------------------------------------------------------------*
FORM zf_popup_to_confirm.

  DATA: vl_resposta TYPE c. "variável que receberá o parâmetro de saída do clique. Sim(001) ou Não(002).

  CALL FUNCTION 'POPUP_TO_CONFIRM'
    EXPORTING
      titlebar              = 'Informação'  "Título
      text_question         = 'Tem certeza que deseja fazer esta soma?'   "Texto da pergunta do pupup
      text_button_1         = 'Sim'(001)  "Texto do botão 1
*     ICON_BUTTON_1         = ' '   "Ícone do botão 1
      text_button_2         = 'Não'(002) "Texto do botão 2
*     ICON_BUTTON_2         = ' '  "Ícone do botão 2
      display_cancel_button = 'X'
    IMPORTING
      answer                = vl_resposta.   "Parâmetro de saída

*Lógica para validar a escolha do usuário:
  IF vl_resposta EQ '1'.
    PERFORM zf_soma.

  ELSEIF vl_resposta EQ '2'.
    "Instrução (Caso deixe aqui sem intrução, o popup fecha automaticamente após o clique e volta para a tela de seleção)
  ENDIF.

ENDFORM.
