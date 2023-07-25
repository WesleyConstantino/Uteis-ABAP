"Sim! É possivel colocar uma condição WHERE em um LOOP AT.
Ex:

 LOOP AT vim_wheretab INTO ls_wheretab WHERE line CS 'BUKRS'.
  "  v_bukrs =  ls_wheretab-line+12(4). 
  "  IF sy-subrc EQ 0.
  "    EXIT.
  "  ENDIF.
  ENDLOOP.

*******************************************************************
Outras formas:

*1:
LOOP AT itab where field1(1) EQ '5'. 
  "SELECT 
       --- 
   "FROM 
       ---
   "INTO CORRESPONDING FIELDS OF itab2
   "WHERE 
       ---
    "APPEND: itab2.
    "CLEAR: itab2.
  "ENDSELECT.
ENDLOOP.
