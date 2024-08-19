*&---------------------------------------------------------------------*
*& Include          ZIFI_CLASSES_LCL_CONTA
*&---------------------------------------------------------------------*
CLASS lcl_conta DEFINITION.
  PUBLIC SECTION.
"Métodos públicos:
    METHODS: constructor,
             define_atributos
             IMPORTING
               im_titular TYPE string
               im_saldo   TYPE p,
             retorna_saldo,
             imprime_atributos.
"Métodos estáticos:
             CLASS-METHODS retorna_num_contas.

   PROTECTED SECTION.
"Atributos protegidos:
    DATA: titular    TYPE string, "string
          saldo      TYPE p LENGTH 16 DECIMALS 2. "decimal
"Atributos estáticos:
    CLASS-DATA num_contas TYPE i. "inteiro
ENDCLASS.

CLASS lcl_conta IMPLEMENTATION.
 METHOD constructor.
   ADD 1 TO num_contas.
 ENDMETHOD.

 METHOD define_atributos.
  titular =  im_titular.
  saldo   =  im_saldo.
 ENDMETHOD.

 METHOD retorna_saldo.
   WRITE:/ 'Saldo:',saldo.
 ENDMETHOD.

 METHOD imprime_atributos.
   WRITE:/ 'Titular:',titular.
   WRITE:/ 'Saldo:',saldo.
   WRITE:/ 'Número de contas:',num_contas.
 ENDMETHOD.

 METHOD retorna_num_contas.
   WRITE:/ 'Número de contas:',num_contas.
 ENDMETHOD.
ENDCLASS.
