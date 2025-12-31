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
  DATA connection TYPE REF TO lcl_connection.
  DATA connections TYPE TABLE OF REF TO lcl_connection.


  CREATE OBJECT connection.

  connection->carrier_id    = 'LH'.
  connection->connection_id = '0400'.
  APPEND connection TO connections.

  connection->carrier_id    = 'AA'.
  connection->connection_id = '0017'.
  APPEND connection TO connections.

  CREATE OBJECT connection.

  connection->carrier_id    = 'SQ'.
  connection->connection_id = '0001'.
  lcl_connection=>conn_counter = 1.
  APPEND connection TO connections.

 ENDMETHOD.

ENDCLASS.
