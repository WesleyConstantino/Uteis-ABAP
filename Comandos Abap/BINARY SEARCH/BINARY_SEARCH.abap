*Explicação: O BINARY SEARCH serve para ganho de performance; ele faz uma busca binária dentro se uma tabela, em vez de trazer todos os 
             "registros de uma só vez. Para usar o BINARY SEARCH, primeito temos que ordenar com SORT os campos da tabela que serão
             "usador para fazer o READ no WITH KEY, como mostrado no trecho de código abaixo.
           

***************************************************************************************************************************************
"Exemplo real:
SORT it_rseg BY belnr gjahr.

READ TABLE it_rseg INTO DATA(wa_rseg) WITH KEY belnr = lv_belnr
                                               gjahr = lv_gjahr BINARY SEARCH.
