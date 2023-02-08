"Declaração de um Read In Line:

"Exemplo de código real:
*Read In Line------------------------------------------------------------------
DATA(ls_cdhdr) = VALUE #( lt_cdhdr[ objectid = ls_ekko_ekpo-ebeln ] OPTIONAL ).

*Read Tradicional--------------------------------------------------------------
READ TABLE lt_cdhdr INTO ls_cdhdr WITH KEY objectid = ls_ekko_ekpo-ebeln. 

----------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------

"Exemplo explicativo:
<Workarea já existente> ou <DATA(Variável in line )> = VALUE #( <Tabela Interna>[ <Campo da Tabela Interna> = <Outra Workarea>-<Campo> ] OPTIONAL ).

"Obs:
# - Logo após a palavra VALUE, faz a conversão dos dados altomáticamente.
OPTIONAL - É necessario declarar no final do código para não dar dump.
