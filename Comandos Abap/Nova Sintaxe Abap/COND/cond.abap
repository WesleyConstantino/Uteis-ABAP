    ls_text_line-itmnum = COND #( WHEN VALUE #( wnfref[ seqnum = ls_wnfftx-seqnum ] OPTIONAL ) IS NOT INITIAL
                                  THEN VALUE #( wnfref[ seqnum = ls_wnfftx-seqnum ]-itmnum OPTIONAL )
                                  ELSE ls_wnfftx-seqnum ).
