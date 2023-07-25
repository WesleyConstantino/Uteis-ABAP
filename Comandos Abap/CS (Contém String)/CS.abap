"No exemplo abaixo, se dentro da variável v_var existir a string BUKRS, entraremos dentro do IF. Como existe, sim, entraremos dentro do IF.

"Ex:
DATA(v_var) = '123 BUKRS ABC'.

IF v_var CS 'BUKRS'.
   ...
ENDIF.
