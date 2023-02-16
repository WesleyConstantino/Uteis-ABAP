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
