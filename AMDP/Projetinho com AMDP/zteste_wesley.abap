"Pragraminha ABAP classico que chama a classe AMDP:
REPORT zteste_wesley.

DATA gv_matnr TYPE matnr VALUE 'SDBOMLUMFIT02'.
DATA go_amdp TYPE REF TO zcl_amdp_demo.

START-OF-SELECTION.

go_amdp = NEW zcl_amdp_demo( ).

go_amdp->get_materials(
  EXPORTING
    iv_matnr = gv_matnr
  IMPORTING
    et_mara  = DATA(it_mara)
).

LOOP AT it_mara INTO DATA(wa_mara).
  WRITE: / wa_mara-matnr,
           wa_mara-mtart.
ENDLOOP.
