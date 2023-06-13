REPORT zformulario02.

*&---------------------------------------------------------------------*
*                            Variáveis                                 *
*&---------------------------------------------------------------------*
DATA v_name TYPE rs38l_fnam.

*&---------------------------------------------------------------------*
*                            Workareas                                 *
*&---------------------------------------------------------------------*
DATA: w_output type  ssfcompop,
      w_ctro   type  ssfctrlop.

*&---------------------------------------------------------------------*
*                         Tela de seleção                              *
*&---------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK b0 WITH FRAME TITLE TEXT-000.

SELECTION-SCREEN BEGIN OF LINE.
PARAMETERS: rb_sim RADIOBUTTON GROUP gr1 DEFAULT 'X'.
SELECTION-SCREEN COMMENT 5(5) TEXT-004 FOR FIELD rb_sim.

PARAMETERS: rb_nao  RADIOBUTTON GROUP gr1.
SELECTION-SCREEN COMMENT 14(6) TEXT-005 FOR FIELD rb_nao.

SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK b0.

*Início da execusão
START-OF-SELECTION.
  PERFORM f_get_name_function.

*&---------------------------------------------------------------------*
*& Form F_SMARTFORMS
*&---------------------------------------------------------------------*
FORM f_get_name_function .
*A função 'SSF_FUNCTION_MODULE_NAME' pega o nome do meu formulário do Smartforms e retorna o nome da função dele em cada ambiente:

  CALL FUNCTION 'SSF_FUNCTION_MODULE_NAME'
    EXPORTING
      formname = 'ZFORM002' "Nome do formulário do Smartforms.
    IMPORTING
      fm_name  = v_name.    "Variável que recebe o o nome da função.

    PERFORM f_smartforms.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form F_SMARTFORMS
*&---------------------------------------------------------------------*
FORM f_smartforms .

  IF NOT v_name IS INITIAL.

*Não pré-visualizar:
    IF rb_sim EQ 'X'.
     w_ctro-no_dialog = 'X'.  "Não abre caixa de dialogo apresentada antes da impressão
     w_output-tdnoprev = 'X'. "Desativa a opção de pré-visualizar
     w_output-tdimmed = 'X'.
    ELSE.
*Pré-visualizar:
     w_ctro-no_dialog = ' '.
     w_output-tdnoprev = ' '.
     w_output-tdimmed = ' '.
    ENDIF.

    CALL FUNCTION v_name
     EXPORTING
*       ARCHIVE_INDEX              =
*       ARCHIVE_INDEX_TAB          =
*       ARCHIVE_PARAMETERS         =
*       CONTROL_PARAMETERS         =
*       MAIL_APPL_OBJ              =
*       MAIL_RECIPIENT             =
*       MAIL_SENDER                =
*       OUTPUT_OPTIONS             =
*       USER_SETTINGS              = 'X'
      control_parameters = w_ctro
      output_options     = w_output
*     IMPORTING
*       DOCUMENT_OUTPUT_INFO       =
*       JOB_OUTPUT_INFO            =
*       JOB_OUTPUT_OPTIONS         =
*     EXCEPTIONS
*       FORMATTING_ERROR           = 1
*       INTERNAL_ERROR             = 2
*       SEND_ERROR                 = 3
*       USER_CANCELED              = 4
*       OTHERS                     = 5
              .
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.
    ENDIF.

ENDFORM
