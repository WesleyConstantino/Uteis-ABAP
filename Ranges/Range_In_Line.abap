*Explicação: Aqui criei um range global e faço o preenchimento dos campos dele de forma in line. Tudo funciona exatamente da mesma forma que fiz em 
            "outros exemplos de range nesse mesmo diretório.


********************************************************************************************************************************************************

*&---------------------------------------------------------------------*
*                              Ranges                                  *
*&---------------------------------------------------------------------*
DATA lr_matnr TYPE RANGE OF mara-matnr.

*&---------------------------------------------------------------------*
*&      Form  ZF_PREENCHE_RANGE
*&---------------------------------------------------------------------*
FORM zf_preenche_range.

  lr_matnr = VALUE #( sign = 'I'     "quero o que sign e option tenham os mesmos valores para todas as linhas do range, por isso os deixo dentro de apenas um
                      option = 'EQ'  "parêntesis, e não dois como em low. 
                      ( low = '10' )
                      ( low = '20' )
                      ( low = '30' )
                      ( low = '9995' )
                      ( low = 'abcde' )
                      ( low = '20g58' ) ).
                      
ENDFORM.                      
