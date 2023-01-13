

*&---------------------------------------------------------------------*
*&      Form  zf_monta_t_out
*&---------------------------------------------------------------------*
FORM zf_monta_t_out .

  LOOP AT t_vbak INTO wa_vbak.    "Loop na tabela mestre. "Principal, do primeiro SELECT"
    
    READ TABLE t_vbap INTO wa_vbap WITH KEY vbeln = wa_vbak-vbeln.   "No READ a chave "WITH KEY" deve ser a mesma da condicional do SELECT. Não colocamos as condicionais 
                                                                      "com a tela de seleção, somente das tabelas.
                                                                      
    IF sy-subrc IS INITIAL. 
      wa_out-aufnr = wa_vbap-aufnr.  "Aqui passo os campos das workareas das tabelas para as minhas workareas da tabela de saída, um a um.
      wa_out-posnr = wa_vbap-posnr.
      wa_out-matnr = wa_vbap-matnr.
      wa_out-arktx = wa_vbap-arktx.
      wa_out-werks = wa_vbap-werks.
      wa_out-lgort = wa_vbap-lgort.
    ENDIF.


    APPEND wa_out TO t_out. "Apendo a workarea para a tabela interna da tabela de saída.
    CLEAR: wa_out,  "Limpo todas as workareas que forem usadas.
           wa_vbap.

  ENDLOOP.   "Encerro o loop

ENDFORM.
