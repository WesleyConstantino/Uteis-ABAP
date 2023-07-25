"Sim! É possivel colocar uma condição WHERE em um LOOP AT.
Ex:

 LOOP AT vim_wheretab INTO ls_wheretab WHERE line CS 'BUKRS'.
  "  v_bukrs =  ls_wheretab-line+12(4).
  "  IF sy-subrc EQ 0.
  "    EXIT.
  "  ENDIF.
  ENDLOOP.
