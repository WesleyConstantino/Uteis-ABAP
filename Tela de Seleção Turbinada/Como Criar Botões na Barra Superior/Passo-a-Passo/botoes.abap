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
            
