*Classes Finais

"São classes que não podem ter herdeiros.

REPORT ZR_CLASSES_FINAIS.

*IMPLEMENTAÇÃO:
CLASS zcl_final DEFINITION FINAL. "Indicamos uma classe final com o comando FINAL.
 PUBLIC SECTION.
 METHODS metodo_final.
ENDCLASS.

*DEFINIÇÃO:
CLASS zcl_final IMPLEMENTATION.
 METHOD metodo_final.
  WRITE:/ 'I´m final method!'.
 ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
 DATA ol_final TYPE REF TO zcl_final.

 CREATE OBJECT ol_final.

 ol_final->metodo_final( ).
