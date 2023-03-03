*Exemplo simples de como funciona a orientação a objetos no Abap

"Definição da classe
CLASS lcl_ola_mundo DEFINITION.
  PUBLIC SECTION.
    METHODS:
      dizer_ola_mundo.
ENDCLASS.

***********************************************

START-OF-SELECTION.
  DATA: lo_ola_mundo TYPE REF TO lcl_ola_mundo.

  CREATE OBJECT lo_ola_mundo.
  lo_ola_mundo->dizer_ola_mundo( ).

***********************************************

"Implementação da classe
CLASS lcl_ola_mundo IMPLEMENTATION.
  METHOD dizer_ola_mundo.
   WRITE:/ 'Olá mundo!'.
ENDCLASS.
