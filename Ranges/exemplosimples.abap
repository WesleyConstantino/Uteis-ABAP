"O Range é um intervalo "de até"


DATA lr_matnr TYPE RANGE OF mara-matnr.
DATA ln_matnr LIKE LINE OF lr_matnr.
ln_matnr-sign = 'I'. "pode ser I ou E
ln_matnr-option = 'BT'. "EQ, BT, CP
ln_matnr-low = '10'.
ln_matnr-high = '50'.
APPEND ln_matnr TO lr_matnr.
CLEAR ln_matnr.
IF lr_matnr IS NOT INITIAL.
  SELECT *
    FROM mara
    INTO TABLE @DATA(lt_mara)
    WHERE matnr in @lr_matnr.
ENDIF.



 
