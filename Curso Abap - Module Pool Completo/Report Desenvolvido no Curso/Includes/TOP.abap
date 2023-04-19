*&---------------------------------------------------------------------*
*& Include MZAULATOP                                         PoolMóds.        SAPMZAULA
*&
*&---------------------------------------------------------------------*
PROGRAM sapmzaula.

CLASS zcl_event_grid DEFINITION DEFERRED. "Informo que a classe vai ser referênciada depois, para o lo_event_grid não dar dump.

*----* Variáveis do programa:
DATA:
  lo_grid_100      TYPE REF TO cl_gui_alv_grid, "Grid 100
  lo_grid_200      TYPE REF TO cl_gui_alv_grid, "Grid 200
  lo_grid_300      TYPE REF TO cl_gui_alv_grid,
  lo_container_100 TYPE REF TO cl_gui_custom_container, "Container do Module Pool 100
  lo_container_200 TYPE REF TO cl_gui_custom_container, "Container do Module Pool 200
  lo_container_300 TYPE REF TO cl_gui_custom_container,
  lv_okcode_100    TYPE sy-ucomm,   "Ok Code do Module Pool 100
  lv_okcode_200    TYPE sy-ucomm,   "Ok Code do Module Pool 200
  lv_okcode_300    TYPE sy-ucomm,   "Ok Code do Module Pool 300
  it_fieldcat      TYPE lvc_t_fcat, "Fieldcat
  ls_layout        TYPE lvc_s_layo, "Layout
  ls_variant       TYPE disvariant, "Variant
  lt_sflight       TYPE TABLE OF sflight,
  lt_sflights      TYPE TABLE OF sflights, "Tabela de conexão.
  lt_sflights2     TYPE TABLE OF sflights2,
  lo_event_grid    TYPE REF TO zcl_event_grid.

*----* Variáveis de tela:
DATA: iv_uname      TYPE sy-uname,  "Label do layout
      iv_uname_nome TYPE bapialias. "Label do layout

*-----* Classes:
*Definições:
CLASS zcl_event_grid DEFINITION.

  PUBLIC SECTION.
    METHODS:
      double_click FOR EVENT double_click OF cl_gui_alv_grid
        IMPORTING e_row e_column es_row_no. "Parâmetros do método double_click da classe cl_gui_alv_grid.
ENDCLASS.

*Implementações:
CLASS zcl_event_grid IMPLEMENTATION.

  METHOD double_click.
    PERFORM z_double_click USING e_row e_column es_row_no.
  ENDMETHOD.
ENDCLASS.
