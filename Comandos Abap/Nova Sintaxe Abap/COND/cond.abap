"Esse código atribui a ls_text_line-itmnum o valor do campo itmnum da tabela interna wnfref quando existir 
"uma entrada com seqnum igual a ls_wnfftx-seqnum. Se não existir, atribui diretamente o valor de ls_wnfftx-seqnum.

    ls_text_line-itmnum = COND #( WHEN VALUE #( wnfref[ seqnum = ls_wnfftx-seqnum ] OPTIONAL ) IS NOT INITIAL  "Essa linha equivale a condição.
                                  THEN VALUE #( wnfref[ seqnum = ls_wnfftx-seqnum ]-itmnum OPTIONAL )          "Essa linha passa valor caso a condição acima seja atendida.
                                  ELSE ls_wnfftx-seqnum ).                                                     "Essa linha passa valor caso a condição não seja atendida.
