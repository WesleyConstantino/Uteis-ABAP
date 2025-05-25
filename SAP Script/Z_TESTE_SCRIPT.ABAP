*&---------------------------------------------------------------------*
*& Report Z_TESTE_SCRIPT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_TESTE_SCRIPT.

DATA: LS_ZTESTE2 TYPE ZTESTE2.

START-OF-SELECTION.
PERFORM PREENCHE_DADOS.
PERFORM SAP_SCRIPT.

FORM PREENCHE_DADOS.
"No SAP Script os elementos devem ter os mesmos nomes que os campos abaixo:
LS_ZTESTE2-ID     = '1'.
LS_ZTESTE2-CHAR10 = 'Wesley'.
ENDFORM.


FORM SAP_SCRIPT.
*Abre o SAP Script:
CALL FUNCTION 'OPEN_FORM'
  EXPORTING
    device   = 'PRINTER'      " Pode ser 'PRINTER' ou 'SCREEN'
    form     = 'ZTRE_TESTE'   " Nome do SAP Script
    language = sy-langu.      " Idioma do formulário

*Starta o SAP Script:
CALL FUNCTION 'START_FORM'
  EXPORTING
    form     = 'ZTRE_TESTE'
    language = sy-langu.

*Escreve o SAP Script:
CALL FUNCTION 'WRITE_FORM'
  EXPORTING
    element = 'ITEM_MAIN'      " Nome do elemento dentro da janela
    window  = 'MAIN'.         " Nome da janela definida no SAP Script

*Finaliza o formulário
CALL FUNCTION 'END_FORM'.

*Fecha o formulário
CALL FUNCTION 'CLOSE_FORM'.

ENDFORM.
