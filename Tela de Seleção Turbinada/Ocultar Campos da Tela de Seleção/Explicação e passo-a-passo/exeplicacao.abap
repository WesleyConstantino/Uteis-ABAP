*Explicação: para ocultar os campos de uma tela de seleção precisaremos seguir alguns passos.

           "PASSO 1: Devemos modificor o ID dos campos que queremos eventualmente ocultar com "MODIF ID".
            "Exemplo do PASSO 1:
             PARAMETERS: p_vbeln TYPE vbak-vbeln MODIF ID prm.
             
           "PASSO 2: Devemos criar os Radio Buttons para fazerem o filtro dos campos que desejamos ocultar.
            "Exemplo do PASSO 2:
             SELECTION-SCREEN BEGIN OF LINE.
             PARAMETERS: rb_todos RADIOBUTTON GROUP g1 DEFAULT 'X' USER-COMMAND comando.
             SELECTION-SCREEN COMMENT 5(5) text-003 FOR FIELD rb_todos.
             PARAMETERS: rb_param RADIOBUTTON GROUP g1.
             SELECTION-SCREEN COMMENT 15(10) text-004 FOR FIELD rb_param.
             PARAMETERS: rb_sl_op RADIOBUTTON GROUP g1.
             SELECTION-SCREEN COMMENT 30(14) text-005 FOR FIELD rb_sl_op.
             SELECTION-SCREEN END OF LINE.
             
           "PASSO 3: Devemos criar os Radio Buttons para fazerem o filtro dos campos que desejamos ocultar.
            "Exemplo do PASSO 3:
