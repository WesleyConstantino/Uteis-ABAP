*O comando ORDER BY serve para fazer uma ordenação a partir de um campo, ele faz a mesma coisa que o SORT BY.

              SELECT remessa
                    , source_tcode
                    , doc_devolucao
                    , flag_saida
                    , flg_mvt
                    , qtd_previa
                  FROM ys4mm_rsvprd_mov
                  INTO TABLE @DATA(vl_saida)
                  WHERE material  EQ @<fs_xlips>-matnr
                    AND centro    EQ @<fs_xlips>-werks
                    AND lote      EQ @<fs_xlips>-charg
                    AND deposito  EQ @<fs_xlips>-lgort
                    AND remessa   EQ @<fs_xlips>-vbeln
                    AND flg_mvt   <> 'A'                 
*<---21/11/2024 - Migração S4 - WS                  
                  ORDER BY remessa.
*<---21/11/2024 - Migração S4 - WS

"Explicação do exemplo acima: no SELECT acima, o "ORDER BY" remessa irá ordenar a tabela interna "vl_saida" a partir do campo "remessa".
