*Explicação: para criar um RADIOBUTTON, basta declará-lo seguido da instrução RADIOBUTTON GROUP e declarar o grupo a qual ele pertencerá.
            "Em uma tela podem existir mais de um grupo de RADIOBUTTONs, tendo que coter no mínimo 2 RADIOBUTTONs por grupo.
            
 
 *-------------------* Trecho de código real:
"Declaração:
PARAMETERS: rb_todos RADIOBUTTON GROUP gr1 DEFAULT 'X',
            rb_matnr RADIOBUTTON GROUP gr1,
            rb_item  RADIOBUTTON GROUP gr1.

"Declaração de um outro grupo na mesma tela: 
PARAMETERS: rb_num1 RADIOBUTTON GROUP gr2 DEFAULT 'X',
            rb_num2 RADIOBUTTON GROUP gr2.

"Checar se um RADIOBUTTON está flegado:
IF rb_todos EQ 'X'.
  "Passo a intrução desejada.
ENDIF.
