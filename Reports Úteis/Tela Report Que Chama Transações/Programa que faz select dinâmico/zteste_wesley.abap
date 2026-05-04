REPORT zteste_wesley.

*Declarações de tabelas internas, variáveis, constantes estruturas...:
DATA: itab_mara TYPE TABLE OF mara.

*Tela de seleção:
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-001.

PARAMETERS: p_table TYPE c LENGTH 12.

SELECTION-SCREEN END OF BLOCK b1.

*Eventos:
 START-OF-SELECTION.

  "Chamada de FORM:
  IF p_table IS NOT INITIAL.

    PERFORM seleciona_dados.

  ENDIF.

  IF itab_mara IS NOT INITIAL.
    WRITE 'Dados encontrados!'.
  ELSE.
    WRITE 'Dados não encontrados!'.
  ENDIF.

*FORM:
FORM seleciona_dados.

  CONSTANTS lc_matnr TYPE matnr VALUE '010'.

  TRY.
      SELECT *
      FROM (p_table)
      INTO TABLE itab_mara
       WHERE  matnr = lc_matnr.

    CATCH cx_sy_dynamic_osql_semantics.
      WRITE 'A tabela informada não existe!'.
  ENDTRY.

ENDFORM.                    "seleciona_dados
