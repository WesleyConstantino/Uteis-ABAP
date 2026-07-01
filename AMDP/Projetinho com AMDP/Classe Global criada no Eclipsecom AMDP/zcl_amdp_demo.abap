CLASS zcl_amdp_demo DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb.

TYPES tt_mara TYPE STANDARD TABLE OF mara WITH EMPTY KEY.

CLASS-METHODS get_materials
  IMPORTING
    VALUE(iv_matnr) TYPE matnr
  EXPORTING
    VALUE(et_mara) TYPE tt_mara.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_amdp_demo IMPLEMENTATION.

 METHOD get_materials
  BY DATABASE PROCEDURE
  FOR HDB
  LANGUAGE SQLSCRIPT
  OPTIONS READ-ONLY
  USING mara.

  et_mara =
    SELECT *
      FROM mara
      WHERE matnr = :iv_matnr AND
            mandt = '500';

ENDMETHOD.

ENDCLASS.
