*&---------------------------------------------------------------------*
*& Report Z_CARGA_MARC
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_CARGA_MARC.

*Includes:
INCLUDE zi_top.
INCLUDE zi_classes.
INCLUDE zi_tela.

"Evento de cliques
AT SELECTION-SCREEN OUTPUT.

  DATA ol_tela TYPE REF TO lcl_tela.
  CREATE OBJECT ol_tela.
  ol_tela->modifica_tela( i_rfc = rb_rfc i_upd = rb_upd ).

*Evento para trazer o caminho do download
AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_upld.
  DATA ol_upload TYPE REF TO lcl_upload.
  CREATE OBJECT ol_upload.

  "Seleciona o arquivo de upload
  ol_upload->seleciona_arquivo(
    CHANGING
      i_upld = p_upld
  ).

*Início da execução
START-OF-SELECTION.
  DATA ol_rfc TYPE REF TO lcl_rfc.
  CREATE OBJECT ol_rfc.

  CASE rb_rfc.
    WHEN 'X'.
      IF p_werks IS INITIAL OR p_matnr IS INITIAL.
        MESSAGE s398(00) WITH 'Preencha todos os parâmetros!' DISPLAY LIKE 'E'.
      ELSE.
        "Chama RFC e faz seleção na MARC
        ol_rfc->chamar_rfc( i_matnr = p_matnr i_werks = p_werks ).
      ENDIF.
    WHEN ' '.
      "Atualiza a MARC
      ol_rfc->display_pop_up( ).
  ENDCASE.
