"A função 'CONVERSION_EXIT_MATN1_OUTPUT' converte o campo MATNR no S/4 hana.


*&---------------------------------------------------------------------*
*& Report ZWESTESTE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZWESTESTE.

DATA v_matnr(80) TYPE C VALUE '000272783'.

INITIALIZATION.

"Função nova que converte o campo de material no S/4
        CALL FUNCTION 'CONVERSION_EXIT_MATN1_OUTPUT'
          EXPORTING
            input  = v_matnr
          IMPORTING
            output = v_matnr.

"O resultado apresentado do whrite será 272783, pois a função remove os zeros à esquerda.
WRITE:/ v_matnr.
