Exibindo uma imagem numa tela do Module Pool/

"Passo 1: acesse a transação SMW0, flegue a opção "Dados binários para aplicações Web RFC e execute. Em seguida, excute a tela que irá aparecer (em branco) e na próxima tela, crie um objeto com o nome Z_CHAT_PLUS e escolha uma imagem da sua máquina (esse é o nosso logo).


"...


"Passo 2: função chamando a tela:
FUNCTION /PWS/ZYCI_CHAT_IA.
*"----------------------------------------------------------------------
*"*"Interface local:
*"----------------------------------------------------------------------

  call screen 0100 starting at 15 3
                   ending   at 122 15.

ENDFUNCTION.


"...


"Passo 3: tela 0100:
*Obs: no layout da tela 0100, crie um Custom Control com o nome CC_IMAGE (ele será usado para exibir a imagem).

PROCESS BEFORE OUTPUT.
  MODULE status_0100.
*
PROCESS AFTER INPUT.
  MODULE user_command_0100.


"...


"Passo 4:
*----------------------------------------------------------------------*
***INCLUDE /PWS/LZYCIGF46O01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0100 OUTPUT.

  "Cria conteiner para exibir o logo do Chat Plus (imagem que exibiremos):
  CREATE OBJECT l_custom_cont
    EXPORTING
      container_name = 'CC_IMAGE'
    EXCEPTIONS
      others         = 1.

  IF sy-subrc <> 0.
    EXIT.
  ENDIF.

  l_container = l_custom_cont.

  "Exibe o logo do Chat Plus:
  PERFORM exibe_logo_tela USING l_container.

  SET PF-STATUS 'STATUS_0100' EXCLUDING gt_exclude_bt.
  SET TITLEBAR 'TITLE_0100'.

ENDMODULE.                 " STATUS_0100  OUTPUT


"...


"Passo 5: no include de FORMS, declarei o form que irá exibir nossa imagem:
*&---------------------------------------------------------------------*
*&      Form  EXIBE_LOGO_TELA
*&---------------------------------------------------------------------*
FORM exibe_logo_tela  USING l_image_cont type ref to cl_gui_container.

 DATA: description TYPE string.

  "Exixição do logo Z_CHAT_PLUS da tcode SMW0:
  CALL FUNCTION 'WB_BITMAP_SHOW'
    EXPORTING
      image_name      = 'Z_CHAT_PLUS'
      parent          = l_image_cont
      stretch_picture = 'X'
    IMPORTING
      image_control    = image_control
      custom_container = custom_container.

  IF image_control IS BOUND.
    description = 'Imagem exibida'(001).

    image_control->set_accdescription(
      EXPORTING accdescription = description
      EXCEPTIONS others = 0 ).

    image_control->set_tooltip(
      EXPORTING text = description
      EXCEPTIONS others = 0 ).
  ENDIF.

ENDFORM.                    " EXIBE_LOGO_TELA


"...


"Passo 6: declarações do include TOP:
  DATA: l_custom_cont TYPE REF TO cl_gui_custom_container,
        l_container   TYPE REF TO cl_gui_container.

  DATA: image_control     TYPE REF TO cl_gui_picture,
        custom_container  TYPE REF TO cl_gui_custom_container.



