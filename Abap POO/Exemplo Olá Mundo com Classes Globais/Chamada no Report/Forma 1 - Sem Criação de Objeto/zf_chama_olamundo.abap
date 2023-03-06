"Para chamar uma classe do tipo Static Method e acessar seus métodos, basta escrever o nome da classe + o sinal => seguido do nome do método + o sinal ( ).
"Ex:  zcl_olamundo=>ola_mundo( ).

*------------*Report:
REPORT ztrwc_testa_poo.

PERFORM zf_chama_olamundo.

*&---------------------------------------------------------------------*
*&      Form  ZF_chama_olamundo
*&---------------------------------------------------------------------*
FORM zf_chama_olamundo .

  zcl_olamundo=>ola_mundo( ).

ENDFORM.
