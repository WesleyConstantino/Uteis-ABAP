*&---------------------------------------------------------------------*
*& Include          ZI_TELA
*&---------------------------------------------------------------------*
*Tela de seleção
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.
    PARAMETERS: rb_rfc RADIOBUTTON GROUP gr1 DEFAULT 'X' USER-COMMAND comando,
                rb_upd RADIOBUTTON GROUP gr1.

  SELECTION-SCREEN END OF BLOCK b2.
*Imput do arquivo de upload
  PARAMETERS: p_upld LIKE rlgrap-filename MODIF ID rfc.

  PARAMETERS: p_matnr TYPE matnr MODIF ID rfc,
              p_werks TYPE werks MODIF ID rfc.
SELECTION-SCREEN END OF BLOCK b1.
