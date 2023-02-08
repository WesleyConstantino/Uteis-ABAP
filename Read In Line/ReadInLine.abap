"Declaração de um Read In Line:

"Exemplo de código real:
DATA(ls_cdhdr) = VALUE #( lt_cdhdr[ objectid = ls_ekko_ekpo-ebeln ] OPTIONAL ).

"Exemplo explicativo:
<Tabela interna já existente> ou <DATA(Variável in line )> = VALUE #( <Tabela Transparente>[ <Campo da Tabela Transparente> = <Outra Tabela>-<Campo> ] OPTIONAL ).

"Obs:
# - Logo após a palavra VALUE, faz a conversão dos dados altomáticamente.
OPTIONAL - É necessario declarar no final do código para não dar dump.
