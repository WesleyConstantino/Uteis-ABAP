*Explicação: Sempre que usar "CP" no campo "option" de um Range, estarei pedindo que ele verifique se existe aquele determinado padrão.

"Exemplo:  
ln_matnr-sign = 'E'.
ln_matnr-option = 'CP'.
ln_matnr-low = '*10*'. "Aqui no low, passo o padrão que quero que seja verificado, neste caso, que contenha a sequência de "10", podendo 
                       "ser em quanter posição. Para auternar a posição que quero ter meu padrão, uso o "*". Caso passe o valor low = '10*',
                       "estou dizendo que meu intervalo tem que iniciar com "10", sem importar o que vem depois; caso passe o valor low = '*10',
                       estarei dizendo que quero um intervalo que apenas termine em "10", sem importar o que tem no começo.

********************************************************************************************************************************************************
********************************************************************************************************************************************************

*-----------* CÓDIGO:

*&---------------------------------------------------------------------*
*                              Ranges                                  *
*&---------------------------------------------------------------------*
DATA lr_matnr TYPE RANGE OF mara-matnr.

*&---------------------------------------------------------------------*
*                            Workareas                                 *
*&---------------------------------------------------------------------*
DATA ln_matnr LIKE LINE OF lr_matnr.

*&---------------------------------------------------------------------*
*&      Form  ZF_SELECT
*&---------------------------------------------------------------------*
FORM zf_selecto.
PERFORM zf_range_estrutura.

IF lr_matnr IS NOT INITIAL.
  SELECT *
    FROM mara
    INTO TABLE @DATA(lt_mara)
    WHERE matnr in @lr_matnr. 
ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  ZF_RANGE_ESTRUTURA
*&---------------------------------------------------------------------*
FORM zf_range_estrutura.

ln_matnr-sign = 'E'.
ln_matnr-option = 'CP'.
ln_matnr-low = '*10*'.

APPEND ln_matnr TO lr_matnr.
CLEAR ln_matnr.

ENDFORM.
