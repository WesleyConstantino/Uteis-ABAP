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

IF lr_matnr IS NOT INITIAL.
  SELECT *
    FROM mara
    INTO TABLE @DATA(lt_mara)
    WHERE matnr in @lr_matnr. "Aqui meu SELECT puxará o matnr entre 10 e 50. Valores que foram declarados na estrutura do Range
ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  ZF_RANGE_ESTRUTURA
*&---------------------------------------------------------------------*
FORM zf_range_estrutura.

ln_matnr-sign = 'I'. 
ln_matnr-option = 'BT'. 
ln_matnr-low = '10'.
ln_matnr-high = '50'.

APPEND ln_matnr TO lr_matnr. "Sempre que quiser criar uma linha no Range, dou uma Append, caso contrário ele fica vazio.
CLEAR ln_matnr.

ENDFORM.


 
