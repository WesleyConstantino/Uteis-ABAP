*&---------------------------------------------------------------------*
*& Report  ZTESTE_WY
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT zteste_wy.
"Referênciando o objeto:
DATA obj TYPE REF TO zcl_teste_wy.

START-OF-SELECTION.
"Criação do objeto:
CREATE OBJECT obj.

"Chamada de método:
obj->main( ).
