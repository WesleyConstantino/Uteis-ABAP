"Este loop serve para transportar os dados de um campo auxiliar, declarado nos TYPES, para o campo principal da nossa estrutura no TYPES.
Como fazer:

  LOOP AT <Tabela Interna> INTO <Workarea>. 
      <Workarea-Campo_aux> = <Workarea-Campo>.
      MODIFY <Tabela Interna> FROM <Workarea> TRANSPORTING <Campo_aux>.
    ENDLOOP.
    
    
    
  "Exemplo de código real: 
  "-FORMA 1-
    LOOP AT t_vbrp INTO wa_vbrp.  
      wa_vbrp-vbeln_aux = wa_vbrp-vbeln.
      MODIFY t_vbrp FROM wa_vbrp TRANSPORTING vbeln_aux.
    ENDLOOP.


   "-FORMA 2-
*&---------------------------------------------------------------------*
*&      Form  ZF_SELECT
*&---------------------------------------------------------------------*
    SELECT aubel
           vgbel
           vbeln
           vbeln "Passando dados para o campo aux em vez de fazer o loop comentado abaixo
      FROM vbrp
      INTO TABLE t_vbrp
      FOR ALL ENTRIES IN t_vbak
      WHERE aubel = t_vbak-vbeln AND
            vgbel IN s_vgbel AND
            vbeln IN s_vbeln2.
