    LOOP AT <Tabela Interna> INTO <Workarea>. 
      <workarea-campo_aux> = <workarea-campo>.
      MODIFY <tabela interna> FROM <workarea> TRANSPORTING <campo_aux>.
    ENDLOOP.
    
    

