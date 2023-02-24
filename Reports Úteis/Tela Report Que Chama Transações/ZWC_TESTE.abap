*------* Descrição do Programa:
"Neste programa criamos uma tela com dois botões que ao serem clicados, chamam cada um uma transação.

*------* Comandos Usados:
"SELECTION-SCREEN PUSHBUTTON: cria um botão.
"SELECTION-SCREEN SKIP: Precisa ser usado para o programa rodar.
"CALL TRANSACTION: Chama transação.

*------* Posicionamento e tamanho dos botões:
"No trecho do código, "SELECTION-SCREEN PUSHBUTTON /20(40)", a barra "/" pula uma linha,
"20" diz respeito a margem da esquerda, bem como o tamanho do botão para a esquerda 
"e "(40)" iz respeito a margem da direita, bem como o tamanho do botão para a direita. 

*------* Tabelas obrigatórias:
"TABLES: sscrfields. Esta tabela é obrigatória para que tudo funcione.

REPORT  ZWC_TESTE.

TABLES: sscrfields.

SELECTION-SCREEN PUSHBUTTON /20(40) btt01 USER-COMMAND btt01. "A barra "/" pula uma linha
SELECTION-SCREEN SKIP.
SELECTION-SCREEN PUSHBUTTON 20(40) btt02 USER-COMMAND btt02.

INITIALIZATION.
  btt01 = 'BOTÃO EM BLOCO 1'.
  btt02 = 'BOTÃO EM BLOCO 2'.
AT SELECTION-SCREEN.
  CASE sscrfields-ucomm.
    WHEN 'BTT01'.
      CALL TRANSACTION 'SE38'.
    WHEN 'BTT02'.
      CALL TRANSACTION 'SE80'.
  ENDCASE.
