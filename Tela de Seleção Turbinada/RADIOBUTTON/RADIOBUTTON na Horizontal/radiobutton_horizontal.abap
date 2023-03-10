*Explicação:  
             "PASSO 1: preciso inicialmente colocá-lo dentro de um "SELECTION-SCREEN BEGIN OF LINE". Isso fará com que ele fique em linha horizontal, porém sem os textos.
             
             "PASSO 2: para adicionar os textos, primeiro preciso fazer um "PARAMETERS:" para cada um dos radiobuttons.
            
             "PASSO 3: Abaixo de cada PARAMETERS dos meus RADIOBUTTONS preciso declarar um "SELECTION-SCREEN COMMENT" seguido de "14(6)", que representa (o primeiro número,
             "14, representa onde o radiobutton e o texto vão começar na linha da tela; já o segundo número, "(6)" representa a quantidade de caracteres do meu text-005,
             "declarados nos elementos de texto, a palavra declarada lá foi "aberto").
            
             "Trecho usado como exemplo no PASSO-A-PASSO: 
            SELECTION-SCREEN COMMENT 14(6) text-005 FOR FIELD rb_opened.
            
             "PASSO 4: Após a intrução "FOR FIELD" passo o nome do radiobutton que desejo fazer essas alterações, como no trecho de código acima. E pronto!
   
 
*-------------------* Trecho de código real:
SELECTION-SCREEN BEGIN OF LINE.
PARAMETERS: rb_all RADIOBUTTON GROUP gr1 DEFAULT 'X'.
SELECTION-SCREEN COMMENT 5(5) text-004 FOR FIELD rb_all.

PARAMETERS: rb_opened  RADIOBUTTON GROUP gr1.
SELECTION-SCREEN COMMENT 14(6) text-005 FOR FIELD rb_opened.

PARAMETERS: rb_closed  RADIOBUTTON GROUP gr1.
SELECTION-SCREEN COMMENT 22(7) text-006 FOR FIELD rb_closed.
SELECTION-SCREEN END OF LINE.
