*Exemplo 1:
"Move os dados da tabela T_SAIDA para a T_SAIDA_AUX. Esse caso com o comando CORRESPONDING #( ) são para as tabelas que não são totalmente iguais.
T_SAIDA_AUX = CORRESPONDING #( T_SAIDA ).

*Exemplo 2:
"Este segundo exeplo faz a mesma coisa que o primeiro, porém não há necessidade de usar o comando CORRESPONDING #( ), pois as tabelas são extamente iguais
"isso torna o comando abaixo mais performatico que o primeiro.
T_SAIDA_AUX[] = T_SAIDA[].

*Exemplo 3:
"Este terceiro exemplo faz a mesma coisa que o exemplo 2, porém é menos performatico.
MOVE T_SAIDA_AUX[] TO T_SAIDA[].

*Exemplo 4:
"Este terceiro exemplo faz a mesma coisa que o exemplo 3.
APPEND LINES OF T_SAIDA_AUX TO T_SAIDA.

*Exemplo 5:
"Este terceiro exemplo faz a mesma coisa que o exemplo 1, porém é menos performatico.
MOVE T_SAIDA_AUX[] CORRESPONDING TO T_SAIDA[].
