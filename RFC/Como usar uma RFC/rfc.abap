*Como usar uma RFC:
"Passo 1: Faça a chamada da função RFC em seu programa informando o destination desejado (o que você criou na SM59), "CALL FUNCTION 'RFC_READ_TABLE' DESTINATION 'Z_ECC_PRD'".
"Exemplo de código:

      CALL FUNCTION 'RFC_READ_TABLE' DESTINATION 'Z_ECC_PRD'
        EXPORTING
          query_table          = 'BSEG'
          rowskips             = v_skip
          rowcount             = v_count
          get_sorted           = 'X'
        TABLES
          options              = it_options
          fields               = it_fields
          data                 = r_bseg
        EXCEPTIONS
          table_not_available  = 1
          table_without_data   = 2
          option_not_valid     = 3
          field_not_valid      = 4
          not_authorized       = 5
          data_buffer_exceeded = 6
          OTHERS               = 7.

"Importante: a função RFC será executada no ambiente de destino, não no ambiente chamador, sendo assim, obrigatóriamente a função RFC precisa existir e conter código no ambiente de destino.
