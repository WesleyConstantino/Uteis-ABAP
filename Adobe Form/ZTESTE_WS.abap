*&---------------------------------------------------------------------*
*& Report ZTESTE_WS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZTESTE_WS.

*Declaração dos parâmetros do seu formulário:
DATA: t_zidcn_s_cf_header  TYPE TABLE OF zidcn_s_cf_header WITH HEADER LINE,
      t_zidcn_t_cf_item_f  TYPE TABLE OF zidcn_s_cf_item_f,
      wa_zidcn_t_cf_item_f TYPE zidcn_s_cf_item_f.

*Declarações padrão do Adobe Forms:
DATA: fm_name         TYPE fpname,
      fp_docparams    TYPE sfpdocparams,
      fp_outputparams TYPE sfpoutputparams,
      fp_formoutput   TYPE fpformoutput.

START-OF-SELECTION.
PERFORM: z_preenche_header,
         z_preenche_item,
         z_confg_form,
         z_open_form,
         z_form_name,
         z_set_form,
         z_close_form.

*********************************************************
*Prenche o cabeçalho do formulário
*********************************************************
FORM z_preenche_header.

t_zidcn_s_cf_header-butxt   = 'Compania Wesley'.
WRITE sy-datum TO t_zidcn_s_cf_header-repdate DD/MM/YY.

APPEND t_zidcn_s_cf_header.

ENDFORM.

*********************************************************
*Prenche os dados de item do formulário
*********************************************************
FORM z_preenche_item.

wa_zidcn_t_cf_item_f-itemtext    = 'Kimono'.
wa_zidcn_t_cf_item_f-linenumber  = '1'.
wa_zidcn_t_cf_item_f-amount      = 'A2'.
wa_zidcn_t_cf_item_f-amount_prev = '600.00'.

APPEND wa_zidcn_t_cf_item_f TO t_zidcn_t_cf_item_f.

ENDFORM.

*********************************************************
*Configurações padrão do formulário
*********************************************************
FORM z_confg_form.

fp_docparams-langu = sy-langu.        " Idioma do sistema
fp_outputparams-nodialog = abap_true. " Sem diálogo de impressão
fp_outputparams-preview = abap_true.  " Modo visualização
fp_outputparams-dest    = 'LP01'.     " Dispositivo de saída

ENDFORM.

*********************************************************
*Abre o Job do Adobe Form
*********************************************************
FORM z_open_form.

CALL FUNCTION 'FP_JOB_OPEN'
  CHANGING
    ie_outputparams = fp_outputparams
  EXCEPTIONS
    cancel          = 1
    usage_error     = 2
    system_error    = 3
    internal_error  = 4
    OTHERS          = 5.

IF sy-subrc <> 0.
  MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
          WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
ENDIF.

ENDFORM.

*********************************************************
*Gera o formulário
*********************************************************
FORM z_form_name.

CALL FUNCTION 'FP_FUNCTION_MODULE_NAME'
  EXPORTING
    i_name     = 'ZIDCN_CASHFLOW'
  IMPORTING
    e_funcname = fm_name.

ENDFORM.

*********************************************************
*Passa os parâmetros para o formulário
*********************************************************
FORM z_set_form.

CALL FUNCTION fm_name
  EXPORTING
    /1bcdwb/docparams  = fp_docparams
    header             = t_zidcn_s_cf_header
    item               = t_zidcn_t_cf_item_f
  IMPORTING
    /1bcdwb/formoutput = fp_formoutput
  EXCEPTIONS
    usage_error        = 1
    system_error       = 2
    internal_error     = 3
    OTHERS             = 4.

ENDFORM.

*********************************************************
*Fecha o formulário
*********************************************************
FORM z_close_form.

CALL FUNCTION 'FP_JOB_CLOSE'
  EXCEPTIONS
    usage_error    = 1
    system_error   = 2
    internal_error = 3
    OTHERS         = 4.

ENDFORM.
