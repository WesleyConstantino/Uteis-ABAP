*&---------------------------------------------------------------------*
*& Report  /PWS/ZYCIR1002
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

report /pws/zycir1002.

*TOP:
"Types:
types: begin of ty_batch_input,
        nrseq    type alsmex_tabline-value, "/PWS/ZYCIE003-NRSEQ,
        nrfat    type alsmex_tabline-value, "/pws/zycie006-nrfat,
        dtincl   type alsmex_tabline-value, "/pws/zycie006-dtincl,
        dtlanc   type alsmex_tabline-value, "/PWS/ZYCIE006-DTLANC,
        frpagto  type alsmex_tabline-value, "/pws/zycie006-frpagto,
        waers    type alsmex_tabline-value, "/pws/zycie006-waers,
*        tpfatura TYPE alsmex_tabline-value, "/pws/zycie006-tpfatura,
"campo fechado
        vlfre    type alsmex_tabline-value, "/pws/zycie006-vlfre,
        lifnr    type alsmex_tabline-value, "/pws/zycie006-lifnr,
       end of ty_batch_input,

       begin of ty_message,
         line type c length 200,
       end of   ty_message.

"Tabelas internas:
data: itab_arquivo     type standard table of alsmex_tabline,
      itab_batch_input type table of          ty_batch_input,
      itab_bdcdata     type standard table of bdcdata,
      itab_message     type table of          ty_message.

"Workareas:
data: wa_arquivo     like line of itab_arquivo,
      wa_batch_input like line of itab_batch_input,
      wa_bdcdata     like line of itab_bdcdata,
      wa_message     like line of itab_message.

"Variáveis:

*TELA:
selection-screen begin of block b01 with frame title text-b01.
parameters: p_file type rlgrap-filename obligatory.
selection-screen end of block b01.

selection-screen begin of block b02 with frame title text-b02.
selection-screen comment /1(71) comm1.
selection-screen comment /1(50) comm2.
selection-screen end of block b02.

selection-screen begin of block b03 with frame title text-b03.
selection-screen comment /1(50) comm3.
selection-screen end of block b03.

*Eventos:
at selection-screen output.
  comm1 = 'Nº Seq, Referência/Nr.Seq, Data da Fatura, Data Lançamento,'.
  comm2 = 'Forma de Pagamento, Moeda, Vl. Frete, Fornecedor.'.
  comm3 = '"I" - Importação - /PWS/ZYCI003_F'(c01).

at selection-screen on value-request for p_file.
  perform busca_arquivo_local.

start-of-selection.
  if  p_file is initial.
    message 'Insira o caminho do upload do arquivo!' type 'S' display
like 'E'.
  else.
    perform: le_arquivo_excel.
*             exibe_alv.
  endif.

*Forms:
*&---------------------------------------------------------------------*
*&      Form  BUSCA_ARQUIVO_LOCAL
*&---------------------------------------------------------------------
form busca_arquivo_local.

  data: itab_files  type filetable,
        wa_files  like line of itab_files,
        vl_rcode  type int4,
        vl_action type int4.

  call method cl_gui_frontend_services=>file_open_dialog
    exporting
      default_extension       = '*.xlsx'
      file_filter             = '(*.xls*)|*.xls*'
    changing
      file_table              = itab_files
      rc                      = vl_rcode
      user_action             = vl_action
    exceptions
      file_open_dialog_failed = 1
      cntl_error              = 2
      error_no_gui            = 3
      not_supported_by_gui    = 4
      others                  = 5.

  if sy-subrc ne 0.
    return.
  else.
    read table itab_files into wa_files index 1.
    p_file = wa_files-filename.
  endif.

endform.                    "busca_arquivo_local

*&---------------------------------------------------------------------*
*&      Form  LE_ARQUIVO_EXCEL
*&---------------------------------------------------------------------*
form le_arquivo_excel.

  call function 'ALSM_EXCEL_TO_INTERNAL_TABLE'
    exporting
      filename                = p_file
      i_begin_col             = 1
      i_begin_row             = 2
      i_end_col               = 18
      i_end_row               = 99999
    tables
      intern                  = itab_arquivo
    exceptions
      inconsistent_parameters = 1
      upload_ole              = 2
      others                  = 3.

  if sy-subrc <> 0 or itab_arquivo is initial.
    message 'Falha ao abrir o arquivo!' type 'S' display like 'E'.
  else.
    perform trata_dados_excel.
  endif.

endform.                    " LE_ARQUIVO_EXCEL

*&---------------------------------------------------------------------*
*&      Form  TRATA_DADOS_EXCEL

form trata_dados_excel.

  data lv_tabix type sy-tabix.

  sort itab_arquivo by row col.

  loop at itab_arquivo into wa_arquivo.

    lv_tabix = lv_tabix + 1.

    if lv_tabix is initial or lv_tabix gt 8.
      lv_tabix = 1.
    endif.

    case lv_tabix.
      when 1.
        wa_batch_input-nrseq    = wa_arquivo-value.
      when 2.
        wa_batch_input-nrfat   = wa_arquivo-value.
      when 3.
        replace all occurrences of '/' in wa_arquivo-value with ''. "
        wa_batch_input-dtincl = wa_arquivo-value.
      when 4.
        replace all occurrences of '/' in wa_arquivo-value with ''. "
        wa_batch_input-dtlanc  = wa_arquivo-value.
      when 5.
        wa_batch_input-frpagto    = wa_arquivo-value.
      when 6.
        wa_batch_input-waers    = wa_arquivo-value.
      when 7.
        wa_batch_input-vlfre    = wa_arquivo-value.
      when 8.
        wa_batch_input-lifnr    = wa_arquivo-value.
        append wa_batch_input to itab_batch_input.
    endcase.

  endloop.
  clear wa_batch_input.

  if itab_batch_input is not initial.
    perform monta_bdc.
  endif.

endform.                    " TRATA_DADOS_EXCEL

*---------------------------------------------------------------------*
*      Form  MONTA_BDC
*---------------------------------------------------------------------*
form monta_bdc.
  data lv_tabix type c length 4.

  loop at itab_batch_input into wa_batch_input.
    lv_tabix = sy-tabix.

   perform monta_tela_bdc using '/PWS/SAPMZYCI003' '0004'.
   perform monta_dados using '/PWS/ZYCIE003-NRSEQ' wa_batch_input-nrseq.
   perform monta_dados using 'BDC_OKCODE' '=ENTER'.

   perform monta_tela_bdc using '/PWS/SAPMZYCI003' '0100'.
   perform monta_dados using '/PWS/ZYCIE006-NRFAT' wa_batch_input-nrfat.
   perform monta_dados using '/PWS/ZYCIE006-DTINCL'
         wa_batch_input-dtincl.
   perform monta_dados using '/PWS/ZYCIE006-DTLANC'
         wa_batch_input-dtlanc.
   perform monta_dados using '/PWS/ZYCIE006-LIFNR'
         wa_batch_input-lifnr.
   perform monta_dados using '/PWS/ZYCIE006-FRPAGTO'
         wa_batch_input-frpagto.
   perform monta_dados using '/PWS/ZYCIE006-WAERS'
         wa_batch_input-waers.
*   PERFORM monta_dados USING '/PWS/ZYCIE006-DTBASE'
*         wa_batch_input-dtbase.
   perform monta_dados using '/PWS/ZYCIE006-VLFRE'
         wa_batch_input-vlfre.
   perform monta_dados using 'BDC_OKCODE' 'ENTE'.

   perform monta_tela_bdc using '/PWS/SAPMZYCI003' '0100'.
   perform monta_dados using '/PWS/ZYCIE006-NRFAT'
    wa_batch_input-nrfat.
   perform monta_dados using '/PWS/ZYCIE006-DTINCL'
   wa_batch_input-dtincl.
   perform monta_dados using '/PWS/ZYCIE006-DTLANC'
   wa_batch_input-dtlanc.
   perform monta_dados using '/PWS/ZYCIE006-LIFNR' wa_batch_input-lifnr.
   perform monta_dados using '/PWS/ZYCIE006-FRPAGTO'
   wa_batch_input-frpagto.
   perform monta_dados using '/PWS/ZYCIE006-WAERS' wa_batch_input-waers.
*   PERFORM monta_dados USING '/PWS/ZYCIE006-DTBASE'
*  wa_batch_input-DTBASE.
   perform monta_dados using '/PWS/ZYCIE006-VLFRE' wa_batch_input-vlfre.
   perform monta_dados using 'BDC_OKCODE' '=SAVE'.

   perform monta_tela_bdc using '/PWS/SAPMZYCI003' '0100'.
   perform monta_dados using 'BDC_OKCODE' '=ENTE'.
   perform monta_dados using '/PWS/ZYCIE006-NRFAT'
    wa_batch_input-nrfat.
   perform monta_dados using '/PWS/ZYCIE006-DTINCL'
   wa_batch_input-dtincl.
   perform monta_dados using '/PWS/ZYCIE006-DTLANC'
   wa_batch_input-dtlanc.
   perform monta_dados using '/PWS/ZYCIE006-LIFNR' wa_batch_input-lifnr.
   perform monta_dados using '/PWS/ZYCIE006-FRPAGTO'
   wa_batch_input-frpagto.
   perform monta_dados using '/PWS/ZYCIE006-WAERS' wa_batch_input-waers.
   perform monta_dados using '/PWS/ZYCIE006-VLFRE' wa_batch_input-vlfre.

   perform monta_tela_bdc using '/PWS/SAPMZYCI003' '0100'.
   perform monta_dados using '/PWS/ZYCIE006-NRFAT'
    wa_batch_input-nrfat.
   perform monta_dados using '/PWS/ZYCIE006-DTINCL'
   wa_batch_input-dtincl.
   perform monta_dados using '/PWS/ZYCIE006-DTLANC'
   wa_batch_input-dtlanc.
   perform monta_dados using '/PWS/ZYCIE006-LIFNR' wa_batch_input-lifnr.
   perform monta_dados using '/PWS/ZYCIE006-FRPAGTO'
   wa_batch_input-frpagto.
   perform monta_dados using '/PWS/ZYCIE006-WAERS' wa_batch_input-waers.
*   PERFORM monta_dados USING '/PWS/ZYCIE006-DTBASE'
*  wa_batch_input-DTBASE.
   perform monta_dados using '/PWS/ZYCIE006-VLFRE' wa_batch_input-vlfre.
   perform monta_dados using 'BDC_OKCODE' '=SAVE'.


   perform monta_tela_bdc using '/PWS/SAPMZYCI003' '0004'.
   perform monta_dados using 'BDC_OKCODE' '/ESAIR'.
   perform monta_dados using '/PWS/ZYCIE003-NRSEQ' wa_batch_input-nrseq.

   if wa_batch_input-nrseq is not initial.
     concatenate 'Linha' lv_tabix ':' wa_batch_input-nrseq
     wa_batch_input-nrfat wa_batch_input-dtincl wa_batch_input-dtlanc
     wa_batch_input-frpagto wa_batch_input-waers
     wa_batch_input-vlfre wa_batch_input-lifnr
     into wa_message separated by space.
     append wa_message to itab_message.

    perform call_transaction.
    clear itab_bdcdata.
   endif.
  endloop.

  if itab_message is not initial.
   perform show_alv_messages.
  endif.

endform.                    " MONTA_BDC

*---------------------------------------------------------------------*
*      Form  MONTA_TELA
*---------------------------------------------------------------------*
form monta_tela_bdc using
      p_program
      p_screen.

  clear wa_bdcdata.
  wa_bdcdata-program  = p_program.
  wa_bdcdata-dynpro   = p_screen.
  wa_bdcdata-dynbegin = 'X'.
  append wa_bdcdata to itab_bdcdata.

endform.                    " MONTA_TELA

*---------------------------------------------------------------------*
*      Form  F_MONTA_DADOS
*---------------------------------------------------------------------**
form monta_dados using
      p_name
      p_value.

  clear wa_bdcdata.
  wa_bdcdata-fnam = p_name.
  wa_bdcdata-fval = p_value.
  append wa_bdcdata to itab_bdcdata.

endform.                    " F_MONTA_DADOS

*&---------------------------------------------------------------------*
*&      Form  CALL_TRANSACTION
*&---------------------------------------------------------------------*
form call_transaction.
   data lv_mode type c value 'N'.

   call transaction '/PWS/ZYCI003_F' using itab_bdcdata
                                     mode  lv_mode
                                     messages into itab_message.

endform.                    " CALL_TRANSACTION

*&---------------------------------------------------------------------*
*&      Form  SHOW_ALV_MESSAGES
*&---------------------------------------------------------------------*
form show_alv_messages .

  data: lo_table   type ref to cl_salv_table,
        lo_header  type ref to cl_salv_form_layout_grid,
        lo_columns type ref to cl_salv_columns_table.

  try.
    cl_salv_table=>factory( importing r_salv_table = lo_table
                             changing t_table = itab_message ).

    lo_table->get_functions( )->set_all( abap_true ).

    create object lo_header.
    lo_header->create_header_information(
    row = 1 column = 1 text = 'Log de mensagens do Batch input' ).
    lo_header->add_row( ).

    lo_table->get_display_settings( )->set_striped_pattern( abap_true ).
    lo_table->set_top_of_list( lo_header ).
    lo_columns = lo_table->get_columns( ).
    lo_columns->set_optimize( abap_true ).

    lo_table->display( ) .

    catch cx_salv_msg
          cx_root.

      message s398(00) with 'Erro ao exibir tabela' display like 'E'.

  endtry.

endform.                    " SHOW_ALV_MESSAGES
