*Explicação: para coloca os RADIOBUTTONs na horizontal, preciso inicialmente colocá-lo dentro de um SELECTION-SCREEN BEGIN OF LINE. Isso fará com que ele fique em linha 
             "horizontal, porém sem os textos.
           " para adicionar os textos, primeiro preciso fazer um "PARAMETERS:" para cada um dos radiobuttons; após isso, 
            
 
 *-------------------* Trecho de código real:
SELECTION-SCREEN BEGIN OF LINE.
PARAMETERS: rb_all RADIOBUTTON GROUP gr1 DEFAULT 'X'.
SELECTION-SCREEN COMMENT 5(5) text-004 FOR FIELD rb_all.

PARAMETERS: rb_opened  RADIOBUTTON GROUP gr1.
SELECTION-SCREEN COMMENT 14(6) text-005 FOR FIELD rb_opened.

PARAMETERS: rb_closed  RADIOBUTTON GROUP gr1.
SELECTION-SCREEN COMMENT 22(7) text-006 FOR FIELD rb_closed.
SELECTION-SCREEN END OF LINE.
