*Explicação: Aqui criei um range global e faço o preenchimento dos campos dele de forma in line. Tudo funciona exatamente da mesma forma que fiz em 
            "outros exemplos de range nesse mesmo diretório.


********************************************************************************************************************************************************

*&---------------------------------------------------------------------*
*                              Ranges                                  *
*&---------------------------------------------------------------------*
DATA lr_matnr TYPE RANGE OF mara-matnr.

*&---------------------------------------------------------------------*
*&      Form  ZF_SELECT
*&---------------------------------------------------------------------*
FORM zf_select.
PERFORM zf_preenche_range.

SELECT *
  FROM mara
  INTO TABLE @DATA(lt_mara).
  
ENDFORM.  

*&---------------------------------------------------------------------*
*&      Form  ZF_PREENCHE_RANGE
*&---------------------------------------------------------------------*
FORM zf_preenche_range.
  lr_matnr = VALUE #( FOR ls_mara IN lt_mara ( sign = 'I'
                                               option = 'EQ'
                                               low = ls_mara-matnr  ) ).
                                               
ENDFORM.   
