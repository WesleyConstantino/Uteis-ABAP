"Este loop serve para transportar os dados de um campo auxiliar, declarado nos TYPES, para o campo principal da nossa estrutura no TYPES

  LOOP AT <Tabela Interna> INTO <Workarea>. 
      <Workarea-Campo_aux> = <Workarea-Campo>.
      MODIFY <Tabela Interna> FROM <Workarea> TRANSPORTING <Campo_aux>.
    ENDLOOP.
    
  "Exemplo de código real:  
    LOOP AT t_vbrp INTO wa_vbrp.  
      wa_vbrp-vbeln_aux = wa_vbrp-vbeln.
      MODIFY t_vbrp FROM wa_vbrp TRANSPORTING vbeln_aux.
    ENDLOOP.
