*&---------------------------------------------------------------------*
*&      Form  zf_popup_to_confirm
*&---------------------------------------------------------------------*
FORM zf_popup_to_confirm.

   DATA: vl_resposta TYPE c. "variável que receberá o parâmetro de saída do clique. Sim(001) ou Não(002).

  CALL FUNCTION 'POPUP_TO_CONFIRM'
  EXPORTING
   TITLEBAR                    = 'Informação'  "Título
   text_question               = 'Tem certeza que deseja fazer esta soma?'   "Texto da pergunta do pupup
   TEXT_BUTTON_1               = 'Sim'(001)  "Texto do botão 1
*   ICON_BUTTON_1               = ' '   "Ícone do botão 1
   TEXT_BUTTON_2               = 'Não'(002) "Texto do botão 2
*   ICON_BUTTON_2               = ' '  "Ícone do botão 2
   DISPLAY_CANCEL_BUTTON       = 'X'
 IMPORTING
   ANSWER                      = vl_resposta.   "Parâmetro de saída

*Lógica para validar a escolha do usuário:
    IF vl_resposta EQ '1'.
      PERFORM zf_soma.

    ELSEIF vl_resposta EQ '2'.
       "Instrução (Caso deixe aqui sem intrução, o popup fecha automaticamente após o clique e volta para a tela de seleção)
    ENDIF.

ENDFORM.
