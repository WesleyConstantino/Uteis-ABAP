*...............................................................*
"Forma 1:
METHODS constructor
      IMPORTING
        i_connection_id TYPE /dmo/connection_id
        i_carrier_id    TYPE /dmo/carrier_id
        "Tratamento com RAISE EXCEPTION TYPE (declaração da exceção):
      RAISING
        cx_ABAP_INVALID_VALUE.

...

METHOD constructor.
 
    IF i_carrier_id IS INITIAL OR i_connection_id IS INITIAL.
     "Tratamento com RAISE EXCEPTION TYPE:
      RAISE EXCEPTION TYPE cx_abap_invalid_value.
    ENDIF.

    me->connection_id = i_connection_id.
    me->carrier_id    = i_carrier_id.

  ENDMETHOD.

...

*...............................................................*
"Forma 2:
METHOD if_oo_adt_classrun~main.

    DATA connection TYPE REF TO lcl_connection.
    DATA connections TYPE TABLE OF REF TO lcl_connection.

    connection = NEW #(  ).
    "Tratamento com TRY CATCH:
    TRY.
        connection->set_attributes(
          EXPORTING
            i_carrier_id    = 'LH'
            i_connection_id = '0400'
        ).

        APPEND connection TO connections.

      CATCH cx_abap_invalid_value.
        out->write( `Method call failed` ).
    ENDTRY.

  ENDMETHOD.
