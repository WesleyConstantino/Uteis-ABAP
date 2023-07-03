        SELECT bukrs
               belnr
               gjahr
               buzei
               zuonr
               hkont
               dmbtr
               bschl
               werks
               bupla
               lifnr
          INTO TABLE itab_sap_bseg
          FROM bseg
         WHERE bukrs  = itab_sap_bkpf-bukrs
           AND belnr  = itab_sap_bkpf-belnr
           AND gjahr  = itab_sap_bkpf-gjahr
           AND hkont IN itab_conta
           AND bschl IN ('40', '50').

        IF sy-subrc = 0 AND lines( itab_sap_bseg ) > 0.
          WHITE:/ 'Essa tabela não está vazia!'.
        ENDIF.
