*Explicação: aqui crio uma variável de objeto local referenciando a classe que quero usar; logo depois, crio o objeto e faço a chamada encadeada abaixo.
"Usamos esse jeito para acessar classes com o tipo Instance Method. Quando a classe é do tipo Static Method, podemos fazer a chamada de classe da forma 1.


*&---------------------------------------------------------------------*
*& Report  ZTRWC_TESTA_POO
*&---------------------------------------------------------------------*
REPORT ztrwc_testa_poo.

PERFORM zf_chama_olamundo.

*&---------------------------------------------------------------------*
*&      Form  ZF_chama_olamundo
*&---------------------------------------------------------------------*
FORM zf_chama_olamundo .
  DATA: ol_olamundo TYPE REF TO zcl_olamundo.

  CREATE OBJECT ol_olamundo.

  ol_olamundo->ola_mundo( ).

ENDFORM.
