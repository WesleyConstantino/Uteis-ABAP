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
            
