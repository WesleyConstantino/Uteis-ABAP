*Para apresentar um ALV em um pop-up,  basta definir os parâmetros IMPORT abaixo de REUSE_ALV_GRID_DISPLAY.

*     Parâmetro                                      Descrição
*I_SCREEN_START_COLUMN      Coordenada X do canto superior esquerdo da caixa de diálogo
*I_SCREEN_START_LINE        Coordenada Y do canto superior esquerdo da caixa de diálogo
*I_SCREEN_END_COLUMN        Coordenada X do canto inferior direito da caixa de diálogo
*I_SCREEN_END_LINE          Coordenada Y do canto inferior direito da caixa de diálogo
************************************************************************************************************


REPORT ZR_POP_UP.

*&---------------------------------------------------------------------*
*                        Tabelas  Internas                             *
*&---------------------------------------------------------------------*
DATA: gt_table TYPE TABLE OF spfli.

*&---------------------------------------------------------------------*
*                     Declaração de Tipos ALV                          *
*&---------------------------------------------------------------------*
TYPE-POOLS: slis.  "Preciso declarar essa estrutura para fucionar o ALV

*Início da execusão
START-OF-SELECTION.
  PERFORM: zf_obtem_dados.

*&---------------------------------------------------------------------*
*&      Form  zf_obtem_dados
*&---------------------------------------------------------------------*
FORM zf_obtem_dados.

  SELECT * FROM spfli INTO TABLE gt_table.

  PERFORM: zf_visualiza_alv_basico.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  ZF_VISUALIZA_ALV_BASICO
*&---------------------------------------------------------------------*
FORM zf_visualiza_alv_basico .

  DATA: lt_fieldcat TYPE slis_t_fieldcat_alv,
        ls_layout_basico   TYPE slis_layout_alv.

  "Cria o lt_fieldcat[] com base em uma estrutura de dados criada na SE11.
  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name = 'SPFLI' "Tabela da SE11
    CHANGING
      ct_fieldcat      = lt_fieldcat[].


  ls_layout_basico-colwidth_optimize = 'X'. "Ajusta o tamanho das colunas.
  ls_layout_basico-zebra = 'X'. "Layout zebrado


  "Chamada da função que exibe o ALV em tela
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      is_layout     = ls_layout_basico
      it_fieldcat   = lt_fieldcat[]
*WS - Faz ALV viarar pou-up - início
      i_screen_start_column = 10
      i_screen_start_line   = 20
      i_screen_end_column   = 100
      i_screen_end_line     = 40
*WS - fim
    TABLES
      t_outtab      = gt_table[]  "Tabela interna de saída. (Sua tabela de dados)
    EXCEPTIONS
      program_error = 1
      OTHERS        = 2.

ENDFORM.
