"Sim! É possivel colocar uma condição WHERE em um LOOP AT.
Ex:

 LOOP AT vim_wheretab INTO ls_wheretab WHERE line CS 'BUKRS'.
  "  v_bukrs =  ls_wheretab-line+12(4). 
  "  IF sy-subrc EQ 0.
  "    EXIT.
  "  ENDIF.
  ENDLOOP.

*******************************************************************
*Outras formas:

*Forma 1:
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

*----------------------------------------------*

*Forma 2: (com Range)
data: it_itab1 type standard table of selopt,
          s_itab1 type selopt.

s_itab1-sign = 'I'.
s_itab1-options = 'BT'.
s_itab1-low = '5*'. " later if your requirement changes its, just another append away to do that...
append w_itab1 to it_itab1.
clear w_itab1.

LOOP AT itab where field1 in it_itab1.
  ...
ENDLOOP.
