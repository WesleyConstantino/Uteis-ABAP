DATA lr_matnr TYPE RANGE OF mara-matnr.
DATA ln_matnr LIKE LINE OF lr_matnr.
ln_matnr-sign = 'E'.
ln_matnr-option = 'CP'.
ln_matnr-low = '*10*'.
APPEND ln_matnr TO lr_matnr.
CLEAR ln_matnr.
IF lr_matnr IS NOT INITIAL.
  SELECT *
    FROM mara
    INTO TABLE @DATA(lt_mara)
    WHERE matnr in @lr_matnr.
    DATA(lv_check) = abap_true.
ENDIF.

