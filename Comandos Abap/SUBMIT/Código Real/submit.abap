DATA: s_docnum    TYPE RANGE OF j_1bnfdoc-docnum,
      s_perio-low TYPE RANGE OF sy-datum.
     
SUBMIT zavtsdr_envio_nf_sfdc WITH s_docnum-low = i_active-docnum
                             WITH s_perio-low  = sy-datum.
