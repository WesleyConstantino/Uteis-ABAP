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
*                     Declaração de Tipos ALV                          *
*&---------------------------------------------------------------------*
TYPE-POOLS: slis.  "Preciso declarar essa estrutura para fucionar o ALV

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

  PERFORM: zf_visualiza_alv_basico.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  ZF_VISUALIZA_ALV_BASICO
*&---------------------------------------------------------------------*
FORM zf_visualiza_alv_basico .

  DATA: lt_fieldcat_basico TYPE slis_t_fieldcat_alv,
        ls_layout_basico   TYPE slis_layout_alv.

  "Cria o lt_fieldcat[] com base em uma estrutura de dados criada na SE11.
  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name = 'ZTAULA_CURSO' "Tabela da SE11
    CHANGING
      ct_fieldcat      = lt_fieldcat_basico[].


  ls_layout_basico-colwidth_optimize = 'X'. "Ajusta o tamanho das colunas.
  ls_layout_basico-zebra = 'X'. "Layout zebrado


  "Chamada da função que exibe o ALV em tela
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      is_layout     = ls_layout_basico
      it_fieldcat   = lt_fieldcat_basico[]
    TABLES
      t_outtab      = it_ztaula_curso[]  "Tabela interna de saída. (Sua tabela de dados)
    EXCEPTIONS
      program_error = 1
      OTHERS        = 2.

ENDFORM.
