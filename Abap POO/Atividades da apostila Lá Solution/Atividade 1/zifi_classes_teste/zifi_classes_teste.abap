*&---------------------------------------------------------------------*
*& Report ZIFI_CLASSES_TESTE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zifi_classes_teste.

INCLUDE zifi_classes_lcl_conta.

START-OF-SELECTION.

  DATA ol_conta TYPE REF TO lcl_conta.
  CREATE OBJECT ol_conta.

  ol_conta->define_atributos( im_titular = 'Wesley' im_saldo = '50.00' ).
  ol_conta->imprime_atributos( ).
  ol_conta->retorna_saldo( ).
  ol_conta->retorna_num_contas( ).


  DATA ol_conta_2 TYPE REF TO lcl_conta.
  CREATE OBJECT ol_conta_2.

  ol_conta->define_atributos( im_titular = 'Natália' im_saldo = '100.00' ).
  ol_conta->imprime_atributos( ).
  ol_conta->retorna_saldo( ).
  ol_conta->retorna_num_contas( ).
