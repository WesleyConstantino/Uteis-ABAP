"O que era pedido na EF:
"VBAK-VBELN = VBAP-VBELN somar VBAP-NETWR de todos os itens encontrados.

"Solução:

*&---------------------------------------------------------------------*
*                                 TYPES                                *
*&---------------------------------------------------------------------*
TYPES: BEGIN OF ty_colect,
         vbeln TYPE vbap-vbeln,
         netwr TYPE vbak-netwr,
       END OF ty_colect,

       BEGIN OF ty_out,
           soma_netwr TYPE vbak-netwr,  ¨Campo que vai receber o valor da soma e apresentar em tela.
       END OF ty_out.

*&---------------------------------------------------------------------*
*                        Tabelas Internas                              *
*&---------------------------------------------------------------------*
DATA:  t_colect    TYPE TABLE OF ty_colect.


*&---------------------------------------------------------------------*
*                            Workareas                                 *
*&---------------------------------------------------------------------*
DATA:  wa_colect    LIKE LINE OF t_colect.


*&---------------------------------------------------------------------*
*&      Form  zf_monta_t_out
*&---------------------------------------------------------------------*
FORM zf_monta_t_out .

  PERFORM: z_soma. "Tenho que chamar o perform

  READ TABLE t_colect INTO wa_colect WITH KEY vbeln = wa_vbak-vbeln. "Faço um read em t_colect conforme a condição pedida. 
  IF sy-subrc IS INITIAL.
  wa_out-soma_netwr = wa_colect-netwr. "Passo campo com o resultado da soma para o campo da t_out que irá o apresentar em tela.
  ENDIF.   

  CLEAR:  wa_colect.

ENDFORM.


*&---------------------------------------------------------------------*
*&      Form  Z_SOMA
*&---------------------------------------------------------------------*
FORM z_soma .

  LOOP AT t_vbap INTO wa_vbap.  "Loop na tabela que quero pegar os ítens para fazer a soma
    wa_colect-vbeln = wa_vbap-vbeln. "Passo os valores das workareas da tabela para a do meu TYPES do collect
    wa_colect-netwr = wa_vbap-netwr.

    COLLECT wa_colect INTO t_colect.  "O comando COLLECT vai efetuar a soma automaticamente
    CLEAR wa_colect.
  ENDLOOP.

ENDFORM.
