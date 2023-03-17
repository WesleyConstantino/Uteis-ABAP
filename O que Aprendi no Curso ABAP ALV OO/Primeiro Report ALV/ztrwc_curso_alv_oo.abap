REPORT ztrwc_curso_alv_oo.

*&---------------------------------------------------------------------*
*                            Tabelas                                   *
*&---------------------------------------------------------------------*
TABLES: ztaula_curso.

*&---------------------------------------------------------------------*
*                        Tabelas  Internas                             *
*&---------------------------------------------------------------------*
DATA: it_ztaula_curso     TYPE TABLE OF ztaula_curso,
      it_ztaula_curs_alun TYPE TABLE OF ztaula_curs_alun.

*&---------------------------------------------------------------------*
*                        Estruturas do ALV                             *
*&---------------------------------------------------------------------*
DATA: lo_container_100 TYPE REF TO cl_gui_custom_container,
      lo_grid_100      TYPE REF TO cl_gui_alv_grid,
      lv_okcode_100    TYPE sy-ucomm,
      lt_fieldcat      TYPE lvc_t_fcat,
      ls_layout        TYPE lvc_s_layo,
      ls_variant       TYPE disvariant.

*&---------------------------------------------------------------------*
*                         Tela de seleção                              *
*&---------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK b0 WITH FRAME TITLE text-000.
SELECT-OPTIONS: s_curso FOR ztaula_curso-nome_curso NO INTERVALS.
SELECTION-SCREEN END OF BLOCK b0.

*Início da execusão
START-OF-SELECTION.
  PERFORM: zf_obtem_dados.

*&---------------------------------------------------------------------*
*&      Form  zf_obtem_dados
*&---------------------------------------------------------------------*
FORM zf_obtem_dados.

  SELECT *
  FROM ztaula_curso
  INTO TABLE it_ztaula_curso[]
  WHERE nome_curso IN s_curso[].

  SELECT *
  FROM ztaula_curs_alun
  INTO TABLE it_ztaula_curs_alun[]
  WHERE nome_curso IN s_curso[].

ENDFORM.
