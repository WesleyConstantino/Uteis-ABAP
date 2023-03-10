*Explicação: para ocultar os campos de uma tela de seleção precisaremos seguir alguns passos.

           "PASSO 1: Devemos modificor o ID dos campos que queremos eventualmente ocultar com "MODIF ID".
            "Exemplo do PASSO 1:
             PARAMETERS: p_vbeln TYPE vbak-vbeln MODIF ID prm.
             
           "PASSO 2: Devemos criar os Radio Buttons para fazerem o filtro dos campos que desejamos ocultar.
            "Exemplo do PASSO 2:
             SELECTION-SCREEN BEGIN OF LINE.
             PARAMETERS: rb_todos RADIOBUTTON GROUP g1 DEFAULT 'X' USER-COMMAND comando.
             SELECTION-SCREEN COMMENT 5(5) text-003 FOR FIELD rb_todos.
             PARAMETERS: rb_param RADIOBUTTON GROUP g1.
             SELECTION-SCREEN COMMENT 15(10) text-004 FOR FIELD rb_param.
             PARAMETERS: rb_sl_op RADIOBUTTON GROUP g1.
             SELECTION-SCREEN COMMENT 30(14) text-005 FOR FIELD rb_sl_op.
             SELECTION-SCREEN END OF LINE.
             
           "PASSO 3: Devemos adicionar o evento AT SELECTION-SCREEN OUTPUT, esse evento reconhecerá as mudanças de cliques dos Radio Buttons em tempo real.
            "Exemplo do PASSO 3:
             AT SELECTION-SCREEN OUTPUT.
             
           "PASSO 4: Criar um form para mudar a visibilidades dos campos conforme o Radio Button flegado.
            "Exemplo do PASSO 4:
             FORM modifica_tela .
             
             ENDFORM.
             
           "PASSO 5: Escrever a lógica do form, para que ele possa mudar a visibilidade dos campos. Primeiro faço um LOOP AT na tela "SCREEN".
            "Exemplo do PASSO 5:
             FORM modifica_tela .
              LOOP AT SCREEN.  
              
              ENDLOOP.
             ENDFORM.
              
           "PASSO 6: Adiciono uma condicional para verificar qual RADIOBUTTON está flegado.
            "Exemplo do PASSO 6:
             FORM modifica_tela .
              LOOP AT SCREEN.  
              
              "Todos
              IF rb_todos EQ 'X'.

              ENDIF.

             "PARAMETERS
             IF rb_param EQ 'X'.

             ENDIF.

            "SELECT-OPTIONS
            IF rb_sl_op EQ 'X'.

            ENDIF.
              
            ENDLOOP.
            ENDFORM.

