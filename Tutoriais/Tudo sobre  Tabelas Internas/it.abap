DECLARANDO UMA TABELA INTERNA:

"Declaração de tipos:
TIPES: BEGIN OF ty_cliente,
          nome TYPE string,
       END OF ty_cliente.

"Declaração da tabela interna:
DATA: it_cliente TYPE TABLE OF ty_cliente.

"Declaração da workarea:
DATA: wa_cliente TYPE ty_cliente.

*ADICIONANDO DADOS NA TABELA INTERNA:
"No APPEND, os novos dados serão adicionados sempre no final da tabela (última linha).
 wa_cliente = 'Wesley'.
APPEND wa_cliente TO it_cliente.

 wa_cliente = 'Natalia'.
APPEND wa_cliente TO it_cliente.

 wa_cliente = 'Rosival'.
APPEND wa_cliente TO it_cliente.

"ACESSANDO OS DADOS DA TABELA INTERNA:
LOOP AT it_cliente INTO DATA(v_cliente).
  WRITE: / 'Cliente: ', v_cliente.
ENDLOOP.

****************************************
"O resultado da execusão do report será:

"Cliente: Wesley
"Cliente: Natalia
"Cliente: Rosival
