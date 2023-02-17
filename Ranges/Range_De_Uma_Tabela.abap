*Explicação: Aqui criei um range global do tipo de uma campo da tabela mara, e no *-----*Preenche Range, crio uma estrutura ls_mara, que funciona como 
            "uma workarea.
            
*----------------*Exemplo:
"No techo abaixo, lr_matnr é o range que já foi declarado, do tipo da tabela mara "anteriormente no código"
"ls_mara é uma linha do range que está sendo criada in line.
"Este trecho "( FOR ls_mara IN lt_mara(...)", pode ser traduzido assim: "PARA <cada linha> DE <Tabela Interna> (Passe os valore, como o resto da senteça)"
  lr_matnr = VALUE #( FOR ls_mara IN lt_mara ( sign = 'I'
                                               option = 'EQ'
                                               low = ls_mara-matnr  ) ).
                                               
 " 


********************************************************************************************************************************************************

*&---------------------------------------------------------------------*
*                              Ranges                                  *
*&---------------------------------------------------------------------*
DATA lr_matnr TYPE RANGE OF mara-matnr.

*&---------------------------------------------------------------------*
*&      Form  ZF_SELECT
*&---------------------------------------------------------------------*
FORM zf_select.
*-----*Select
SELECT *
  FROM mara
  INTO TABLE @DATA(lt_mara).
  
*-----*Preenche Range
  lr_matnr = VALUE #( FOR ls_mara IN lt_mara ( sign = 'I'
                                               option = 'EQ'
                                               low = ls_mara-matnr  ) ).
                                               
ENDFORM.   
