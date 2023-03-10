REPORT ztrwc_tela_de_selecao.

*&---------------------------------------------------------------------*
*                              Tables                                  *
*&---------------------------------------------------------------------*
TABLES: vbak.

*&---------------------------------------------------------------------*
*                         Tela de seleção                              *
*&---------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK b0 WITH FRAME TITLE text-000.
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-001.
*PARAMETERS
PARAMETERS: p_vbeln TYPE vbak-vbeln MODIF ID prm.  "Modifico o ID dos campos que quero eventualmente ocultar com "MODIF ID".
SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE text-002.
*SELECT-OPTIONS
SELECT-OPTIONS: s_erdat FOR vbak-erdat MODIF ID slc.
SELECTION-SCREEN END OF BLOCK b2.

*Radio Buttons
SELECTION-SCREEN BEGIN OF LINE.
PARAMETERS: rb_todos RADIOBUTTON GROUP g1 DEFAULT 'X' USER-COMMAND comando.
SELECTION-SCREEN COMMENT 5(5) text-003 FOR FIELD rb_todos.
PARAMETERS: rb_param RADIOBUTTON GROUP g1.
SELECTION-SCREEN COMMENT 15(10) text-004 FOR FIELD rb_param.
PARAMETERS: rb_sl_op RADIOBUTTON GROUP g1.
SELECTION-SCREEN COMMENT 30(14) text-005 FOR FIELD rb_sl_op.
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK b0.

"Evento para reconhecer os ciques do radiobutton e mudar as telas

AT SELECTION-SCREEN OUTPUT.
  PERFORM modifica_tela.

*&---------------------------------------------------------------------*
*&      Form  MODIFICA_TELA
*&---------------------------------------------------------------------*
FORM modifica_tela .
  LOOP AT SCREEN.  "Faço um LOOP AT na tela "SCREEN"
*Todos
    IF rb_todos EQ 'X'.
      IF screen-group1 EQ 'PRM' OR screen-group1 EQ 'SLC'.
        screen-invisible = 0.
      ENDIF.
    ENDIF.

*PARAMETERS
    IF rb_param EQ 'X'.

      IF screen-group1 EQ 'PRM'.
        screen-invisible = 0.
        screen-input     = 1.
        screen-active    = 1.
      ENDIF.

      IF screen-group1 EQ 'SLC'.
        screen-invisible = 1.
        screen-input     = 0.
        screen-active    = 0.
      ENDIF.
    ENDIF.

*SELECT-OPTIONS
    IF rb_sl_op EQ 'X'.
      IF screen-group1 EQ 'SLC'.
        screen-invisible = 0.
        screen-input     = 1.
        screen-active    = 1.
      ENDIF.

      IF screen-group1 EQ 'PRM'.
        screen-invisible = 1.
        screen-input     = 0.
        screen-active    = 0.
      ENDIF.
    ENDIF.
    MODIFY SCREEN. "Preciso dar um MODIFY SCREEN para que funcione.
  ENDLOOP.
ENDFORM.
