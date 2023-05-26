"O comando strlen verifica o número de posições da linha de um campo, para isto é necesário fazer um loop na tabela ou estrutura, após isso, basta verificar.
"Ex:

LOOP AT ti_arquivo INTO DATA(wa_arquivo).
* Verifica se o número de posições do campo "linha" é diferente de 750.
      IF strlen( wa_arquivo-linha ) NE 750.
        " MSG:  Formato do arquivo & inválido
        MESSAGE s398 WITH text-e09 wa_lista-name text-e10 space DISPLAY LIKE c_e.
        EXIT. "Ignorar arquivo !
      ENDIF.
ENDLOOP.
