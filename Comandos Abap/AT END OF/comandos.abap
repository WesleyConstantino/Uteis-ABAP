*O comando AT END OF em ABAP é usado dentro de loops (LOOP AT ... ENDLOOP) para detectar a última linha de um grupo de registros baseado em um campo específico.

*Ele executa o bloco de código apenas quando ocorre a última ocorrência de um determinado valor em um grupo.

*Um grupo é definido pelo valor do campo especificado na cláusula AT END OF <campo>.

*Pode ser usado para cálculos, totais, resumos ou qualquer processamento que precise ser feito ao final de um grupo de registros.

*Exemplo genérico:
AT END OF grupo.
   " Código executado quando um grupo específico termina
ENDAT.

*Exemplo real:
      LOOP AT it_xmseg INTO wa_mseg WHERE bwart = '411'.
        AT NEW mblnr.
          READ TABLE it_xmseg INTO wa_mseg INDEX sy-tabix.
          PERFORM estorna_pela_bapi TABLES return goodsmvt_headret
                                    USING wa_mseg
                                          pstng_date.
        ENDAT.
      ENDLOOP.
