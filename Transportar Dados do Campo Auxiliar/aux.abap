    LOOP AT <Tabela Interna>t_vbrp INTO <Workarea>wa_vbrp.  "Loop para fazer a modificação no meu campo auxiliar
      wa_vbrp-vbeln_aux = wa_vbrp-vbeln.
      MODIFY t_vbrp FROM wa_vbrp TRANSPORTING vbeln_aux.
    ENDLOOP.
