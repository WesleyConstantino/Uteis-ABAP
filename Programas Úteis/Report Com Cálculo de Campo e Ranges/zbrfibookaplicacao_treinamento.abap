*----------------------------------------------------------------------*
* Autor....: Wesley Constantino dos Santos                             *
* Data.....: 23/02/2023                                                *
* Módulo...:                                                           *
* Descrição:                                                           *
*----------------------------------------------------------------------*
*                   Histórico das Alterações                           *
*----------------------------------------------------------------------*
* DATA      | AUTOR         | Request    | DESCRIÇÃO                   *
*----------------------------------------------------------------------*
*           | ABI-WCONSTANTINO    |            | Codificação Inicial   *
*----------------------------------------------------------------------*
REPORT  zbrfibookaplicacao_treinamento.

*&---------------------------------------------------------------------*
*                                TABLES                                *
*&---------------------------------------------------------------------*
TABLES: t001,
        bkpf.

*&---------------------------------------------------------------------*
*                                 TYPES                                *
*&---------------------------------------------------------------------*
TYPES:
*------* ty_OUT
      BEGIN OF ty_out,
         bukrs             TYPE bkpf-bukrs,
         belnr             TYPE bkpf-belnr,
         gjahr             TYPE bkpf-gjahr,
         budat             TYPE bkpf-budat,
         montan            TYPE bseg-dmbtr,
         montan_b          TYPE bseg-dmbtr,
         irrf              TYPE bseg-dmbtr,
         iof               TYPE bseg-dmbtr,
         hkont             TYPE bseg-hkont,
       END OF ty_out,
*------* ty_ZBRFIRENDIMENTO
      BEGIN OF ty_zbrfirendimento,
         saknr_3 TYPE zbrfirendimento-saknr_3,
         saknr_4 TYPE zbrfirendimento-saknr_4,
         saknr_1 TYPE zbrfirendimento-saknr_1,
         blart   TYPE zbrfirendimento-blart,
         bukrs   TYPE zbrfirendimento-bukrs,
       END OF ty_zbrfirendimento,
*------* ty_BKPF
      BEGIN OF ty_bkpf,
         bukrs TYPE bkpf-bukrs,
         belnr TYPE bkpf-belnr,
         gjahr TYPE bkpf-gjahr,
         blart TYPE bkpf-blart,
         budat TYPE bkpf-budat,
       END OF ty_bkpf,
*------* ty_BSEG
      BEGIN OF ty_bseg,
         dmbtr TYPE bseg-dmbtr,
         bukrs TYPE bseg-bukrs,
         gjahr TYPE bseg-gjahr,
         hkont TYPE bseg-hkont,
         bschl TYPE bseg-bschl,
         belnr TYPE bseg-belnr,
       END OF ty_bseg.

*&---------------------------------------------------------------------*
*                              Ranges                                  *
*&---------------------------------------------------------------------*
DATA gr_hkont TYPE RANGE OF bseg-hkont.

*&---------------------------------------------------------------------*
*                        Tabelas Internas                              *
*&---------------------------------------------------------------------*
DATA: t_out                  TYPE TABLE OF ty_out,
      t_zbrfirendimento      TYPE TABLE OF ty_zbrfirendimento,
      t_bkpf                 TYPE TABLE OF ty_bkpf,
      t_bseg                 TYPE TABLE OF ty_bseg.

*&---------------------------------------------------------------------*
*                            Workareas                                 *
*&---------------------------------------------------------------------*
DATA: wa_out                  LIKE LINE OF t_out,
      wa_zbrfirendimento      LIKE LINE OF t_zbrfirendimento,
      wa_bkpf                 LIKE LINE OF t_bkpf,
      wa_bseg                 LIKE LINE OF t_bseg,
      wa_hkont                LIKE LINE OF gr_hkont.

*&---------------------------------------------------------------------*
*                         Tela de seleção                              *
*&---------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK b0 WITH FRAME TITLE text-000.

SELECT-OPTIONS: s_belnr  FOR bkpf-belnr NO-EXTENSION NO INTERVALS,
                s_budat  FOR bkpf-budat NO-EXTENSION NO INTERVALS,
                s_bukrs  FOR t001-bukrs NO-EXTENSION NO INTERVALS,
                s_gjahr  FOR bkpf-gjahr NO-EXTENSION NO INTERVALS.

SELECTION-SCREEN END OF BLOCK b0.

*Início da execusão
START-OF-SELECTION.
  PERFORM: zf_select,
           zf_monta_t_out,
           zf_exibe_alv_poo.

*&---------------------------------------------------------------------*
*                            FORM zf_select                            *
*&---------------------------------------------------------------------*
FORM zf_select.

*------* zbrfirendimento
  SELECT saknr_3
         saknr_4
         saknr_1
         blart
         bukrs
  FROM zbrfirendimento
  INTO TABLE t_zbrfirendimento
  WHERE bukrs IN s_bukrs.

  IF t_zbrfirendimento IS NOT INITIAL.

*------* bkpf
    SELECT bukrs
           belnr
           gjahr
           blart
           budat
    FROM bkpf
    INTO TABLE t_bkpf
    FOR ALL ENTRIES IN t_zbrfirendimento
    WHERE bukrs = t_zbrfirendimento-bukrs AND
          blart = t_zbrfirendimento-blart AND
          budat IN s_budat.

    IF t_bkpf IS NOT INITIAL.

      PERFORM zf_range_estrutura.

*------* bseg
      SELECT dmbtr
             bukrs
             gjahr
             hkont
             bschl
             belnr
      INTO TABLE t_bseg
      FROM bseg
      FOR ALL ENTRIES IN t_bkpf
      WHERE bukrs = t_bkpf-bukrs AND
            gjahr = t_bkpf-gjahr AND
            belnr = t_bkpf-belnr AND
            hkont IN gr_hkont.

      DELETE t_bseg WHERE bschl <> '40'.

    ENDIF. "t_bkpf
  ENDIF.   "t_zbrfirendimento

  IF sy-subrc IS NOT INITIAL.
    MESSAGE s398(00) WITH 'Não há registros!' DISPLAY LIKE 'E'.
    STOP.
  ENDIF.
ENDFORM.                    "zf_select

*&---------------------------------------------------------------------*
*&      Form  ZF_MONTA_T_OUT
*&---------------------------------------------------------------------*
FORM zf_monta_t_out .

  LOOP AT t_bkpf INTO wa_bkpf.

    wa_out-bukrs = wa_bkpf-bukrs.
    wa_out-belnr = wa_bkpf-belnr.
    wa_out-gjahr = wa_bkpf-gjahr.
    wa_out-budat = wa_bkpf-budat.


    READ TABLE t_bseg INTO wa_bseg WITH KEY bukrs = wa_bkpf-bukrs
                                            belnr = wa_bkpf-belnr
                                            gjahr = wa_bkpf-gjahr.

    IF sy-subrc IS INITIAL.
      wa_out-hkont = wa_bseg-hkont.

      READ TABLE t_zbrfirendimento INTO wa_zbrfirendimento WITH KEY bukrs = wa_bseg-bukrs
                                                                    saknr_1 = wa_bseg-hkont.

      IF sy-subrc IS INITIAL.

        LOOP AT t_bseg INTO wa_bseg.
          IF wa_bseg-belnr EQ wa_bkpf-belnr.

            IF wa_bseg-hkont EQ wa_zbrfirendimento-saknr_1.
              wa_out-montan   = wa_bseg-dmbtr.
            ENDIF.

            IF wa_bseg-hkont EQ wa_zbrfirendimento-saknr_3.
              wa_out-irrf = wa_bseg-dmbtr.
            ENDIF.

            IF wa_bseg-hkont EQ wa_zbrfirendimento-saknr_4.
              wa_out-iof = wa_bseg-dmbtr.
            ENDIF.
          ENDIF.
        ENDLOOP.
        wa_out-montan_b = wa_out-montan - wa_out-iof.
      ENDIF. "t_bseg
    ENDIF. "t_zbrfirendimento

    APPEND wa_out TO t_out.
    CLEAR: wa_out,
           wa_bkpf,
           wa_bseg.
  ENDLOOP.
ENDFORM.                    "zf_monta_t_out

*&---------------------------------------------------------------------*
*&      Form  ZF_RANGE_ESTRUTURA
*&---------------------------------------------------------------------*
FORM zf_range_estrutura.

  wa_hkont-sign = 'I'.
  wa_hkont-option = 'EQ'.

  LOOP AT t_zbrfirendimento INTO wa_zbrfirendimento.

    wa_hkont-low = wa_zbrfirendimento-saknr_3.
    APPEND wa_hkont TO gr_hkont.

    wa_hkont-low = wa_zbrfirendimento-saknr_4.
    APPEND wa_hkont TO gr_hkont.

    wa_hkont-low = wa_zbrfirendimento-saknr_1.
    APPEND wa_hkont TO gr_hkont.

    CLEAR wa_hkont-low.

  ENDLOOP.

  SORT gr_hkont BY low.
  DELETE ADJACENT DUPLICATES FROM gr_hkont.

ENDFORM.                    "zf_range_estrutura

*&---------------------------------------------------------------------*
*&      Form  ZF_exibe_alv_poo
*&---------------------------------------------------------------------*
FORM zf_exibe_alv_poo.

  DATA: lo_table     TYPE REF TO cl_salv_table,  "Acessar a classe "cl_salv_table"
        lo_header    TYPE REF TO cl_salv_form_layout_grid,   "Para criação do header
        lo_columns   TYPE REF TO cl_salv_columns_table,  "Ajustar tamanho dos subtítulos
        lo_functions TYPE REF TO cl_salv_functions,
        lo_display   TYPE REF TO cl_salv_display_settings,
        lo_column    TYPE REF TO cl_salv_column.


  TRY.
      cl_salv_table=>factory( IMPORTING r_salv_table = lo_table "Tabela local
                             CHANGING t_table = t_out ).

      lo_functions = lo_table->get_functions( ). "Ativar met codes
      lo_functions->set_all( abap_true ).

      CREATE OBJECT lo_header. "É necessário que criemos o objeto header

      lo_header->add_row( ).


      lo_display = lo_table->get_display_settings( ).
      lo_display->set_striped_pattern( abap_true ).

      lo_table->set_top_of_list( lo_header ).

      lo_columns = lo_table->get_columns( ). "Ajustar tamanho dos subtítulos
      lo_columns->set_optimize( abap_true ). "Ajustar tamanho dos subtítulos

*--------* Mudar nomes
      lo_column ?= lo_columns->get_column( 'BUKRS' ). "?= Down Casting: Converte o que estiver vindo do lado direito para o esquerdo.
      lo_column->set_short_text( 'Empresa' ).
      lo_column->set_medium_text( 'Empresa' ).
      lo_column->set_long_text( 'Empresa' ).



      lo_table->display( ) . "O dispay é fundamental para a exibição do ALV

    CATCH cx_salv_msg
          cx_root.

      MESSAGE s398(00) WITH 'Erro ao exibir tabela' DISPLAY LIKE 'E'.

  ENDTRY.

ENDFORM.                    "zf_exibe_alv_poo
