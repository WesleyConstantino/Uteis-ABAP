*Explicação: para criar botões na barra superior da tela de nosso report precisaremos seguir alguns passos.

*---------*PASSO 1: Declarar a tabela de campos "sscrfields".
            "Exemplo do PASSO 1:
            TABLES: sscrfields.
            
*---------*PASSO 2: Declarar o "include" que possuí todos os icones de botões "ICON" como "TYPE-POOLS:".
            "Exemplo do PASSO 2:
            TYPE-POOLS: icon.
            
*---------*PASSO 3: Fazer a declaração dos botões (Fora da tela de seleção). Lembrando que a estrutura da tabela "sscrfields" me permite criar até 5 botões somente.
            "Exemplo do PASSO 3: 
            SELECTION-SCREEN: FUNCTION KEY 1. "Declaração do botão 1
            SELECTION-SCREEN: FUNCTION KEY 2. "Declaração do botão 2
            
*---------*PASSO 4: Criar um form para fazer a criar cada um dos nossos botões. 
            "Exemplo do PASSO 4: 
            FORM zf_criar_botoes.
            
            ENDFORM.
            
*---------*PASSO 5: A primeira coisa a fazer no nosso form "zf_criar_botoes" será declarar uma estrutura do tipo smp_dyntxt; isso nos permitirá personalizar nosso botão
                   "com título, icone e texto ao passar o cursor do mouse.
            "Exemplo do PASSO 5: 
            FORM zf_criar_botoes.
             DATA: ls_button TYPE smp_dyntxt.
             
            ENDFORM.
            
*---------*PASSO 6: Agora personalizaremos nossos botões utilizando os campos "text (para dar título), icon_id (para passar o código do ícone) e quickinfo (para definir
                   "o texto que aparecerá ao passar o cursor do mouse em cima do botão)". Após isso, passaremos nossa esturtura local, "ls_button" para os campos "functxt_01"
                   "e "functxt_02" da tabela "sscrfields"; lembrando que posso criar até 5 botões. Ou seja, posso passar até "functxt_05".
            "Exemplo do PASSO 6: 
            FORM zf_criar_botoes.
             DATA: ls_button TYPE smp_dyntxt.
             
               "Botão 1: Exclusão de Registros
                ls_button-text        = 'Exclusão de Registros'.  "Título do botão.
                ls_button-icon_id     = icon_booking_stop.        "Icone (Posso verificar os códigos dos ícones na tabela ICON com a tansação SE16).
                ls_button-quickinfo   = 'Excluir registro'.       "Texto que aparecerá ao passar o cursor em cima do botão.
                sscrfields-functxt_01 = ls_button.                "Adicionamosn osso botaão 1 na estrutura de botóes (sscrfields).

               "Botão 2: Inclusão de Registros
                ls_button-text         = 'Inclusão de Registros'.
                ls_button-icon_id      = icon_booking_ok.
                ls_button-quickinfo    = 'Incluir registro'.
                sscrfields-functxt_02 = ls_button.
            ENDFORM.         
            
*---------*PASSO 7: Chamaremos o perform do "zf_criar_botoes". Posso chamá-lo abaixo do evento "INITIALIZATION" quando quiser que antes de execultar o
                    "programa, ou abaixo do evento "START-OF-SELECTION" quando quiser que apareça apenas após a execusão.
            "Exemplo do PASSO 7:
            INITIALIZATION.
            PERFORM: zf_criar_botoes.
            
*---------*PASSO 8: Agora precisaremos criar um form para reconhecer o evento de click dos botões.
            "Exemplo do PASSO 8:
            FORM zf_evento_botao.

            CASE sy-ucomm.
               WHEN 'FC01'.  "FC01 corresponde ao botão 1: Exclusão de Registros. (É possível descobrir isso no debbug através do "sy-ucomm").
                  "Instrução desejada
               WHEN 'FC02'.  "FC02 corresponde ao botão 2: Inclusão de Registros.
                  "Instrução desejada
            ENDCASE.
            ENDFORM.
            
*---------*PASSO 9: Por último, chamo o meu perform "zf_evento_botao" embaixo do evento "AT SELECTION-SCREEN" e está pronto. 
            "Exemplo do PASSO 9:  
            AT SELECTION-SCREEN.
            PERFORM: zf_evento_botao.
            
            
