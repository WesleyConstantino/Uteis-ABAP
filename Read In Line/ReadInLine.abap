"Declaração de um Read In Line:

"Exemplo de código real:
DATA(ls_cdhdr) = VALUE #( lt_cdhdr[ objectid = ls_ekko_ekpo-ebeln ] OPTIONAL ).

"Exemplo explicativo:
<Workarea já existente> ou <DATA(Variável in line )> = VALUE #( <Tabela Interna>[ <Campo da Workarea> = <Outra Workarea>-<Campo> ] OPTIONAL ).

"Obs:
# - Logo após a palavra VALUE, faz a conversão dos dados altomáticamente.
OPTIONAL - É necessario declarar no final do código para não dar dump.
