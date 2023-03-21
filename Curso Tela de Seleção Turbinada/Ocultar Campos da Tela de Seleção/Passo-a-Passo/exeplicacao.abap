*Explicação: para ocultar os campos de uma tela de seleção precisaremos seguir alguns passos.

*---------*PASSO 1: Devemos modificor o ID dos campos que queremos eventualmente ocultar com "MODIF ID".
            "Exemplo do PASSO 1:
             PARAMETERS: p_vbeln TYPE vbak-vbeln MODIF ID prm.                           
             SELECT-OPTIONS: s_erdat FOR vbak-erdat MODIF ID slc.             
             
*---------*PASSO 2: Devemos criar os Radio Buttons para fazerem o filtro dos campos que desejamos ocultar.
            "Exemplo do PASSO 2:
             SELECTION-SCREEN BEGIN OF LINE.
             PARAMETERS: rb_todos RADIOBUTTON GROUP g1 DEFAULT 'X' USER-COMMAND comando.
             SELECTION-SCREEN COMMENT 5(5) text-003 FOR FIELD rb_todos.
             PARAMETERS: rb_param RADIOBUTTON GROUP g1.
             SELECTION-SCREEN COMMENT 15(10) text-004 FOR FIELD rb_param.
             PARAMETERS: rb_sl_op RADIOBUTTON GROUP g1.
             SELECTION-SCREEN COMMENT 30(14) text-005 FOR FIELD rb_sl_op.
             SELECTION-SCREEN END OF LINE.
             
*---------*PASSO 3: Devemos adicionar o evento AT SELECTION-SCREEN OUTPUT, esse evento reconhecerá as mudanças de cliques dos Radio Buttons em tempo real.
                   "Esee comando deverá ser adicionado após a tela de seleção.
            "Exemplo do PASSO 3:
             AT SELECTION-SCREEN OUTPUT.
             
*---------*PASSO 4: Criar um form para mudar a visibilidades dos campos conforme o Radio Button flegado.
            "Exemplo do PASSO 4:
             FORM modifica_tela .
             
             ENDFORM.
             
*---------*PASSO 5: Escrever a lógica do form, para que ele possa mudar a visibilidade dos campos. Primeiro faço um LOOP AT na tela "SCREEN".
            "Exemplo do PASSO 5:
             FORM modifica_tela .
              LOOP AT SCREEN.                       "<<<< ADICIONADO NESTE PASSO
              
              ENDLOOP.                              "<<<< ADICIONADO NESTE PASSO
             ENDFORM.
              
*---------*PASSO 6: Adiciono uma condicional para verificar qual RADIOBUTTON está flegado.
            "Exemplo do PASSO 6:
             FORM modifica_tela .
              LOOP AT SCREEN.  
              
              "Todos
              IF rb_todos EQ 'X'.                 "<<<< ADICIONADO NESTE PASSO

              ENDIF.                              "<<<< ADICIONADO NESTE PASSO

             "PARAMETERS
             IF rb_param EQ 'X'.                  "<<<< ADICIONADO NESTE PASSO

             ENDIF.                               "<<<< ADICIONADO NESTE PASSO 

            "SELECT-OPTIONS
            IF rb_sl_op EQ 'X'.                   "<<<< ADICIONADO NESTE PASSO

            ENDIF.                                "<<<< ADICIONADO NESTE PASSO
              
            ENDLOOP.
            ENDFORM.
            
*---------*PASSO 7: Digo que para onde meu screen-group1 for igual aos IDs modificados no PASSO 1, quero o screen-invisible = 0, ou seja, a invisibilidade desativada.
                    "Obs: screen, possuí vários campos, onde passarmos como valor o 0, ficará desativado e onde passarmos o 1, ficará ativado.
            "Exemplo do PASSO 7: 
             FORM modifica_tela .
              LOOP AT SCREEN.  
              
              "Todos
              IF rb_todos EQ 'X'.
              IF screen-group1 EQ 'PRM' OR screen-group1 EQ 'SLC'.   "<<<< ADICIONADO NESTE PASSO
               screen-invisible = 0.                                 "<<<< ADICIONADO NESTE PASSO
              ENDIF.                                                 "<<<< ADICIONADO NESTE PASSO
              ENDIF.

             "PARAMETERS
             IF rb_param EQ 'X'.

             ENDIF.

            "SELECT-OPTIONS
            IF rb_sl_op EQ 'X'.

            ENDIF.
              
            ENDLOOP.
            ENDFORM.
            
*---------*PASSO 8: Implemento a lógica dos outros RADIOBUTTONS, sempre desativando o screen-invisible dele e ativando o do outro. Além disso, para ocutar compos 
                    "precisaremos usar mais dois campos do screen, o screen-input e screen-active; para os dois, devo passar o valor 1(ATIVAR) quando quiser que o
                    "campo da tela de selecão seja mostrado e o valor 0(DESATIVADO) quando quiser que seja ocultado.
            "Exemplo do PASSO 8: 
             FORM modifica_tela .
              LOOP AT SCREEN.  
              
              "Todos
              IF rb_todos EQ 'X'.
              IF screen-group1 EQ 'PRM' OR screen-group1 EQ 'SLC'.   
               screen-invisible = 0.                                 
              ENDIF.                         
              ENDIF.

             "PARAMETERS
             IF rb_param EQ 'X'.
             
             IF screen-group1 EQ 'PRM'.                    "<<<< ADICIONADO NESTE PASSO
               screen-invisible = 0.                       "<<<< ADICIONADO NESTE PASSO
               screen-input     = 1.                       "<<<< ADICIONADO NESTE PASSO
               screen-active    = 1.                       "<<<< ADICIONADO NESTE PASSO
              ENDIF.                                       "<<<< ADICIONADO NESTE PASSO

             IF screen-group1 EQ 'SLC'.                    "<<<< ADICIONADO NESTE PASSO
                screen-invisible = 1.                      "<<<< ADICIONADO NESTE PASSO
                screen-input     = 0.                      "<<<< ADICIONADO NESTE PASSO
                screen-active    = 0.                      "<<<< ADICIONADO NESTE PASSO
             ENDIF.                                        "<<<< ADICIONADO NESTE PASSO
             
             ENDIF.

            "SELECT-OPTIONS
            IF rb_sl_op EQ 'X'.

             IF screen-group1 EQ 'SLC'.                    "<<<< ADICIONADO NESTE PASSO
               screen-invisible = 0.                       "<<<< ADICIONADO NESTE PASSO
               screen-input     = 1.                       "<<<< ADICIONADO NESTE PASSO
               screen-active    = 1.                       "<<<< ADICIONADO NESTE PASSO
              ENDIF.                                       "<<<< ADICIONADO NESTE PASSO

             IF screen-group1 EQ 'PRM'.                    "<<<< ADICIONADO NESTE PASSO
                screen-invisible = 1.                      "<<<< ADICIONADO NESTE PASSO
                screen-input     = 0.                      "<<<< ADICIONADO NESTE PASSO
                screen-active    = 0.                      "<<<< ADICIONADO NESTE PASSO
             ENDIF.                                        "<<<< ADICIONADO NESTE PASSO
             
             ENDIF.

            ENDIF.
              
            ENDLOOP.
            ENDFORM.                      
            
*---------*PASSO 9: Antes de fechar o meu LOOP AT, preciso dar um MODIFY SCREEN para que as atualizações de visibilidade funcione nos campos.
            "Exemplo do PASSO 9: 
             FORM modifica_tela .
              LOOP AT SCREEN.  
              
              "Todos
              IF rb_todos EQ 'X'.
              IF screen-group1 EQ 'PRM' OR screen-group1 EQ 'SLC'.   
               screen-invisible = 0.                                 
              ENDIF.                         
              ENDIF.

             "PARAMETERS
             IF rb_param EQ 'X'.
             
             IF screen-group1 EQ 'PRM'.                   
               screen-invisible = 0.                       
               screen-input     = 1.                     
               screen-active    = 1.                       
              ENDIF.                                       

             IF screen-group1 EQ 'SLC'.                    
                screen-invisible = 1.                      
                screen-input     = 0.                      
                screen-active    = 0.                      
             ENDIF.                                        
             
             ENDIF.

            "SELECT-OPTIONS
            IF rb_sl_op EQ 'X'.

             IF screen-group1 EQ 'SLC'.               
               screen-invisible = 0.                    
               screen-input     = 1.                    
               screen-active    = 1.                    
              ENDIF.                         

             IF screen-group1 EQ 'PRM'.              
                screen-invisible = 1.                
                screen-input     = 0.                   
                screen-active    = 0.                      
             ENDIF.                                        
             
             ENDIF.

            ENDIF.
            MODIFY SCREEN.                                 "<<<< ADICIONADO NESTE PASSO
            ENDLOOP.
            ENDFORM.

*---------*PASSO 10: Para finalizar, preciso chamar o PERFORM modifica_tela embaixo do comando AT SELECTION-SCREEN OUTPUT, comando que adicionamos no PASSO 3. Agora está pronto!
            "Exemplo do PASSO 10:
            AT SELECTION-SCREEN OUTPUT.
            PERFORM modifica_tela.                       "<<<< ADICIONADO NESTE PASSO



