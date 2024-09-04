  METHOD delete_marc_single BY DATABASE PROCEDURE
                            FOR HDB
                            LANGUAGE SQLSCRIPT
                            USING marc.

    DELETE FROM marc WHERE MANDT = iv_MANDT AND MATNR = IV_MATNR and WERKS = iv_WERKS;

  ENDMETHOD.
