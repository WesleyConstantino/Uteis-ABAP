  METHOD update_marc_valifrom_single BY DATABASE PROCEDURE
                                     FOR HDB
                                     LANGUAGE SQLSCRIPT
                                     USING marc.
    UPDATE marc SET mmstd = iv_mmstd WHERE MANDT = iv_MANDT AND MATNR = IV_MATNR and WERKS = iv_WERKS;
  ENDMETHOD.
