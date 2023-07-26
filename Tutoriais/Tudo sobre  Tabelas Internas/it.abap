
"Declaração de tipos:
TIPES: BEGIN OF ty_cliente,
          nome TYPE string,
       END OF ty_cliente.

"Declaração da tabela interna:
DATA: it_cliente TYPE TABLE OF ty_cliente.

"Declaração da workarea:
DATA: wa_cliente TYPE ty_cliente.
