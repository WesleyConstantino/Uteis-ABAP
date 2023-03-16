REPORT ztrwc_botao_tela.

*&---------------------------------------------------------------------*
*                            Tabelas                                   *
*&---------------------------------------------------------------------*
TABLES: zpficat_pinsumos,
        sscrfields.
*&---------------------------------------------------------------------*
*                           Includes                                   *
*&---------------------------------------------------------------------*
TYPE-POOLS: icon.

*&---------------------------------------------------------------------*
*                         Tela de seleção                              *
*&---------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK b0 WITH FRAME TITLE text-000.
SELECT-OPTIONS: s_hkont FOR zpficat_pinsumos-hkont OBLIGATORY,
                s_belnr FOR zpficat_pinsumos-belnr,
                s_blart FOR zpficat_pinsumos-blart,
                s_lifnr FOR zpficat_pinsumos-lifnr,
                s_gsber FOR zpficat_pinsumos-gsber.
SELECTION-SCREEN END OF BLOCK b0.

*Buttons
SELECTION-SCREEN: FUNCTION KEY 1. "Declaração do botão
SELECTION-SCREEN: FUNCTION KEY 2.

*Inicialização do Programa
INITIALIZATION.
  PERFORM: zf_criar_botoes.

*&---------------------------------------------------------------------*
*&      Form  ZF_CRIAR_BOTOES
*&---------------------------------------------------------------------*
FORM zf_criar_botoes .
  DATA: ls_button TYPE smp_dyntxt. "Estrutura

  "Botão 1: Exclusão de Registros
  ls_button-text        = 'Exclusão de Registros'.  "Título do botão.
  ls_button-icon_id     = icon_booking_stop.        "Icone (Posso verificar os códigos dos ícones na tabela ICON com a tansação SE16).
  ls_button-quickinfo   = 'Excluir registro'.       "Texto que aparecerá ao passar o cursor em cima do botão.
  sscrfields-functxt_01 = ls_button.                "Adicionamosn osso botaão 1 na estrutura de botóes (sscrfields).

  "Botão 2: Inclusão de Registros
  ls_button-text         = 'Inclusão de Registros'.
  ls_button-icon_id      = icon_booking_ok.
  ls_button-quickinfo    = 'Incluir registro'.
  sscrfields-functxt_02 = ls_button.
ENDFORM.
