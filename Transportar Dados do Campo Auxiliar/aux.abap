"Este loop serve para transportar os dados de um campo auxiliar, declarado nos TYPES, para o campo principal da nossa estrutura no TYPES.
Como fazer:

  LOOP AT <Tabela Interna> INTO <Workarea>. 
      <Workarea-Campo_aux> = <Workarea-Campo>.
      MODIFY <Tabela Interna> FROM <Workarea> TRANSPORTING <Campo_aux>.
    ENDLOOP.
    
    
    
  "Exemplo de código real: 
  
  "Esta é a estrutura do meu TYPES:
TYPES: BEGIN OF ty_vbrp,
         aubel         TYPE vbrp-aubel,
         vgbel         TYPE vbrp-vgbel,
         vbeln         TYPE vbrp-vbeln,
         vbeln_aux(35) TYPE c,
       END OF ty_vbrp.
  
  
*------------FORMA 1--------------
*          (Com Loop)
*&---------------------------------------------------------------------*
*&      Form  ZF_SELECT
*&---------------------------------------------------------------------*
    SELECT aubel
           vgbel
           vbeln
      FROM vbrp
      INTO TABLE t_vbrp
      FOR ALL ENTRIES IN t_vbak
      WHERE aubel = t_vbak-vbeln AND
            vgbel IN s_vgbel AND
            vbeln IN s_vbeln2.
            
    LOOP AT t_vbrp INTO wa_vbrp.   "Faço este loop para passar os dados para o campo aux.
      wa_vbrp-vbeln_aux = wa_vbrp-vbeln.
      MODIFY t_vbrp FROM wa_vbrp TRANSPORTING vbeln_aux.
    ENDLOOP.


*------------FORMA 2--------------
*          (Sem Loop)
*&---------------------------------------------------------------------*
*&      Form  ZF_SELECT
*&---------------------------------------------------------------------*
    SELECT aubel
           vgbel
           vbeln
           vbeln "Já passo os dados para o campo aux diretamente aqui, repetindo o vbeln, sendo que o campos aux é do tipo vbeln. 
      FROM vbrp
      INTO TABLE t_vbrp
      FOR ALL ENTRIES IN t_vbak
      WHERE aubel = t_vbak-vbeln AND
            vgbel IN s_vgbel AND
            vbeln IN s_vbeln2.
