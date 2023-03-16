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
