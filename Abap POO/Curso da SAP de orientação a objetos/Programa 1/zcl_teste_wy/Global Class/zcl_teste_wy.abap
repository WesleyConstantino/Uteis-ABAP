CLASS zcl_teste_wy DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS: main.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_teste_wy IMPLEMENTATION.

 METHOD main.
  "Funciona como uma workarea de classes (contém todos os atributos de uma classe em forma de estrutura):
  DATA connection TYPE REF TO lcl_connection.
  "Funciona como uma tabela interna de classes (contém todos os atributos de uma classe em forma de tabela):
  DATA connections TYPE TABLE OF REF TO lcl_connection.

  "a "workarea de classes" precisa ser criada, como abaixo. Já a "tabela interna de classes" não precisa!
  CREATE OBJECT connection.

  "Veja que trabalhamos com connection econnections exatamente como trabalhamos com workareas e tabelas internas tradicionais: 
  connection->carrier_id    = 'LH'.
  connection->connection_id = '0400'.
  APPEND connection TO connections.

  connection->carrier_id    = 'AA'.
  connection->connection_id = '0017'.
  APPEND connection TO connections.

  "Ao criar connection novamente, o garbage colector entra em ação! Ele apaga o connection antigo e cria um novo com os registros zerados. Funciona como se fosse um CLEAR:
  CREATE OBJECT connection.

  connection->carrier_id    = 'SQ'.
  connection->connection_id = '0001'.
  "Acessamos componentes estácticos como abaixo. Quando conn_counter recebe valor, esse valor imediatamente é setado para todas as linhas da "tabela de classes" tabmbém! Pois é estático:
  lcl_connection=>conn_counter = 1.
  APPEND connection TO connections.

 ENDMETHOD.

ENDCLASS.
