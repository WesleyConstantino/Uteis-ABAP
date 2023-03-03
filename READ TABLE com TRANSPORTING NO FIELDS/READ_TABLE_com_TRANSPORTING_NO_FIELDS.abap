*Explicação: O READ TABLE com TRANSPORTING NO FIELDS é usado quando não desejo transportar
           "os dados da minha tabela interna para uma workarea. Ou seja, quando desejo
           "apenas verificar uma condição para tomar determinada ação; como o exemplo abaixo.
           

*********************************************************************************************
"Exemplo real:
    READ TABLE gt_vbap TRANSPORTING NO FIELDS WITH KEY vbeln = ls_vbak_aux-vbeln.
    IF sy-subrc NE 0.
      DELETE gt_vbak.
    ENDIF.
