*&---------------------------------------------------------------------*
*& Report  ZTRWC_TESTE_BATCH_INPUT
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT ZTRWC_TESTE_BATCH_INPUT.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-001.
PARAMETERS p_cat TYPE c LENGTH 20.
SELECTION-SCREEN END OF BLOCK b1.

*&---------------------------------------------------------------------*
*                    Estruturas do Batch Input                         *
*&---------------------------------------------------------------------*
*-------* Tabelas  Internas
DATA it_bdcdata TYPE TABLE OF bdcdata.  "Tabela para Fazer o Bach Input.
*-------* Workareas
DATA wa_bdcdata TYPE bdcdata.

DATA opt TYPE ctu_params. "Estrutura para fazer sumir o popup de confirmação.


CLEAR wa_bdcdata.
wa_bdcdata-program  = 'SAPLSD_ENTRY'. "Nome do Programa. Neste caso usei o caminho: SE11 -> Sistema -> Status -> Ptrograma(tela) = SAPLSD_ENTRY.
wa_bdcdata-dynpro   = '1000'.         "Númrto da tela. Mesmo caminho de cima. (...)Status -> Nº tela = 1000.
wa_bdcdata-dynbegin = 'X'.            "Deve sempre estar flegado com 'X'. Tona a tela editável.
APPEND wa_bdcdata TO it_bdcdata.


CLEAR wa_bdcdata.
*Flega Um RadioButton:
wa_bdcdata-fnam  = 'RSRD1-DDTYPE'. "Nome do campo. Caminho: SE11 -> Aperto F1 encima do campo "Categoria de Dados" -> Denominação p/campo batch input: Área da Tela = RSRD1-DDTYPE.
wa_bdcdata-fval   = 'X'.           "Valor do campo.
APPEND wa_bdcdata TO it_bdcdata.


CLEAR wa_bdcdata.
wa_bdcdata-fnam  = 'RSRD1-DDTYPE_VAL'. "Campo de imput de "Categoria de Dados" na SE11.
wa_bdcdata-fval   = p_cat.             "Vai receber o valor passado no parameter.
APPEND wa_bdcdata TO it_bdcdata.
*
CLEAR wa_bdcdata.
wa_bdcdata-fnam  = 'BDC_OKCODE'.  "SIGINIFICA 'ENTER' OU CLIQUE DE SELEÇÃO
wa_bdcdata-fval   = 'WB_DISPLAY'. "Nome do botão que quero apertar. Caminho: SE11 -> F1 encima do botão "Exibir" -> Infirmações Técnicas: Função = WB_DISPLAY.
APPEND wa_bdcdata TO it_bdcdata.


opt-dismode = 'E'. "Mostra o popup de confirmação apenas em caso de Erro 'E'.


CALL TRANSACTION 'SE11' USING it_bdcdata OPTIONS FROM opt. "Chame a transação SE11 usando a minha tabela interna it_bdcdata usando as opções do opt.
