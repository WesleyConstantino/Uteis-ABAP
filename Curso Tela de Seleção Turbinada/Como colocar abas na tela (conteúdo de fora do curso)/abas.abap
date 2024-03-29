REPORT ZR_ABANATALA.

*TABLES kna1.

* Criação da Subtela - Aba 1
SELECTION-SCREEN BEGIN OF SCREEN 110 AS SUBSCREEN.
*  Criação do Bloco de Tela
  SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-001.
*    SELECT-OPTIONS: kunnr FOR kna1-kunnr.
*    PARAMETERS: land1 TYPE kna1-land1.
  SELECTION-SCREEN END OF BLOCK b1.
SELECTION-SCREEN END OF SCREEN 110.

* Criação da Subtela - Aba 2
SELECTION-SCREEN BEGIN OF SCREEN 120 AS SUBSCREEN.
*  Criação do Bloco de Tela
  SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE text-002.
*    PARAMETERS: name1 TYPE kna1-name1.
  SELECTION-SCREEN END OF BLOCK b2.
SELECTION-SCREEN END OF SCREEN 120.

* Tela Principal
SELECTION-SCREEN BEGIN OF TABBED BLOCK tab FOR 13 LINES. "13 LINES é a quantidade de linhas que a tela principal vai ocupar (define o tamanho em cumprimento).
  SELECTION-SCREEN TAB (8) tab1 USER-COMMAND comm1 DEFAULT SCREEN 110. "8 é o tamanho do texto da subtela. Aqui ela recebe o nome de tab1
  SELECTION-SCREEN TAB (4) tab2 USER-COMMAND comm2 DEFAULT SCREEN 120.
SELECTION-SCREEN END OF BLOCK tab.

"O evento INITIALIZATION é necessário para que funcione as abas
INITIALIZATION.
  " Títulos das Abas
  tab1 = 'Customer'.
  tab2 = 'Name'.

  " Opção de Vir Selecionado!
  tab-activetab = 'COMM2'.  "User comand da subtela que ficará com default
  tab-dynnr     = 120.  "Número da subtela que ficará com default
