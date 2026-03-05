REPORT zteste_wesley.

DATA: lv_matnr TYPE matnr.

START-OF-SELECTION.

  TRY.

      SELECT matnr
      FROM ('WESLEY_CONSTANTINO')
      INTO lv_j_1bbranch
       WHERE  situacao = 'Wesley'.
      ENDSELECT.

      WRITE lv_matnr.

    CATCH cx_sy_dynamic_osql_semantics.

      WRITE 'A tabela informada não existe!'.

  ENDTRY.
