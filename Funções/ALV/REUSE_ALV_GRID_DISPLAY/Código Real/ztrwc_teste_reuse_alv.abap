REPORT ztrwc_teste_reuse_alv.

*&---------------------------------------------------------------------*
*                                Types                                 *
*&---------------------------------------------------------------------*
*------* ty_out
TYPES: BEGIN OF ty_out,
         ebeln TYPE ekko-ebeln, "Contrato (Contrato informado na tela de seleção)
         bukrs TYPE ekko-bukrs,
         waers TYPE ekko-waers,
       END OF ty_out.

*&---------------------------------------------------------------------*
*                        Tabelas  Internas                             *
*&---------------------------------------------------------------------*
DATA: it_ekko TYPE TABLE OF ekko,
      it_out  TYPE TABLE OF ty_out.

*&---------------------------------------------------------------------*
*                        Estruturas do ALV                             *
*&---------------------------------------------------------------------*
* Types Pools
TYPE-POOLS:
   slis.
* Types
TYPES:
  ty_fieldcat TYPE slis_fieldcat_alv,
  ty_events   TYPE slis_alv_event,
  ty_layout   TYPE slis_layout_alv.
* Workareas
DATA:
  wa_fieldcat TYPE ty_fieldcat,
  wa_events   TYPE ty_events,
  wa_layout   TYPE ty_layout.
* Internal Tables
DATA:
  it_fieldcat TYPE STANDARD TABLE OF ty_fieldcat,
  it_events   TYPE STANDARD TABLE OF ty_events.

*&---------------------------------------------------------------------*
*                         Tela de seleção                              *
*&---------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK b0 WITH FRAME TITLE text-000.
PARAMETERS: p_ebeln TYPE ekko-ebeln. "Contrato: Nº do documento de compras
SELECTION-SCREEN END OF BLOCK b0.

*Início da execusão
START-OF-SELECTION.
  IF  p_ebeln IS INITIAL.
    MESSAGE 'Insira o Nº do documento de Compras!' TYPE 'S' DISPLAY LIKE 'E'.
  ELSE.
    PERFORM: zf_select.

    PERFORM build_fieldcatlog.
    PERFORM build_layout.
    PERFORM list_display.
  ENDIF.

*&---------------------------------------------------------------------*
*&      Form  ZF_SELECT
*&---------------------------------------------------------------------*
FORM zf_select.

  SELECT ebeln
         bukrs
         waers
    FROM ekko
    INTO TABLE it_out
    WHERE ebeln EQ p_ebeln AND                              "4100000000
          bukrs EQ 'VIVO'.

  IF sy-subrc NE 0.
    MESSAGE s398(00) WITH 'Erro ao selecionar os dados!' DISPLAY LIKE 'E'.
  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  build_fieldcatlog
*&---------------------------------------------------------------------*
FORM build_fieldcatlog .
  CLEAR:wa_fieldcat,it_fieldcat[].

  PERFORM build_fcatalog USING:
          'EBELN'  'IT_OUT' 'EBELN',
          'BUKERS' 'IT_OUT' 'BUKERS',
          'WAERS'  'IT_OUT' 'WAERS'.

ENDFORM.                    "BUILD_FIELDCATLOG


*&---------------------------------------------------------------------*
*&      Form  BUILD_FCATALOG
*&---------------------------------------------------------------------*
FORM build_fcatalog USING l_field l_tab l_text.

  wa_fieldcat-fieldname      = l_field.
  wa_fieldcat-tabname        = l_tab.
  wa_fieldcat-seltext_m      = l_text.

  APPEND wa_fieldcat TO it_fieldcat.
  CLEAR wa_fieldcat.

ENDFORM.


*&---------------------------------------------------------------------*
*&      Form  build_layout
*&---------------------------------------------------------------------*
FORM build_layout .

  wa_layout-colwidth_optimize = 'X'.
  wa_layout-zebra             = 'X'.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  list_display
*&---------------------------------------------------------------------*
FORM list_display .
  DATA: l_program TYPE sy-repid.
  l_program = sy-repid.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program = l_program
      is_layout          = wa_layout
      it_fieldcat        = it_fieldcat
    TABLES
      t_outtab           = it_out
    EXCEPTIONS
      program_error      = 1
      OTHERS             = 2.
  IF sy-subrc <> 0.
    MESSAGE s398(00) WITH 'Erro ao exibir tabela' DISPLAY LIKE 'E'.
  ENDIF.
ENDFORM.                    " list_display
