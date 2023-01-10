    LOOP AT <Tabela Interna> INTO <Workarea>. 
      <Workarea-Campo_aux> = <Workarea-Campo>.
      MODIFY <Tabela Interna> FROM <Workarea> TRANSPORTING <Campo_aux>.
    ENDLOOP.
    
    

