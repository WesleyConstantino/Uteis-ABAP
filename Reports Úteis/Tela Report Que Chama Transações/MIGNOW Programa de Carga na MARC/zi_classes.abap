*&---------------------------------------------------------------------*
*& Include          ZI_CLASSES
*&---------------------------------------------------------------------*
*Definições:
*lcl_rfc
CLASS lcl_rfc DEFINITION.
  PUBLIC SECTION.
    METHODS:
      chamar_rfc
        IMPORTING
          i_werks TYPE  werks
          i_matnr TYPE  matnr,
      display_pop_up.

  PROTECTED SECTION.
    METHODS:
      popula_it_options,
      popula_it_fields,
      append_tabela_z,
      show_log,
      atualiza_marc.

    TYPES:
      BEGIN OF ty_log,
        mensagem TYPE char50,
        matnr    TYPE matnr,
        werks    TYPE werks,
      END OF ty_log,

      BEGIN OF ty_log_tab_z,
        mensagem(50) TYPE c,
        num_loop(20) TYPE c,
      END OF ty_log_tab_z.

    DATA: r_marc       TYPE TABLE OF marc,
          it_options   TYPE TABLE OF rfc_db_opt,
          it_log       TYPE TABLE OF ty_log,
          it_log_tab_z TYPE TABLE OF ty_log_tab_z,
          it_fields    TYPE TABLE OF rfc_db_fld,
          wa_fields    TYPE rfc_db_fld,
          matnr      TYPE bukrs,
          werks      TYPE gjahr,
          v_count      TYPE c VALUE 200,
          v_skip       TYPE c VALUE 0,
          v_total      TYPE c,
          v_num_loop   TYPE c,
          v_show_log_z TYPE c VALUE 'X'.
ENDCLASS.

*lcl_tela
CLASS lcl_tela DEFINITION.
  PUBLIC SECTION.
    METHODS: modifica_tela
      IMPORTING
        i_rfc TYPE c
        i_upd TYPE c.
ENDCLASS.

*lcl_upload
CLASS lcl_upload DEFINITION.
  PUBLIC SECTION.
    METHODS: seleciona_arquivo
           CHANGING
             i_upld TYPE rlgrap-filename,
             get_it_options.

   PRIVATE SECTION.
      METHODS: carrega_dados,
               popula_it_options.

      TYPES: BEGIN OF ty_arq,
              linha(2000) TYPE c,
             END   OF ty_arq.

      DATA: v_arqv     TYPE rlgrap-filename,
            v_filename TYPE string,
            it_arq     TYPE TABLE OF ty_arq,
            it_options TYPE TABLE OF rfc_db_opt.
ENDCLASS.


*Implementações:
*lcl_upload
CLASS lcl_upload IMPLEMENTATION.
   "Seleciona de arquivo do upload
    METHOD seleciona_arquivo.

    CALL FUNCTION 'KD_GET_FILENAME_ON_F4'
     EXPORTING
       mask          = 'Text Files (*.TXT;*.CSV;*.XLSX)|*.TXT;*.CSV;*.XLSX|'
       fileoperation = 'R'
     CHANGING
       file_name     = v_arqv
     EXCEPTIONS
       mask_too_long = 1
       OTHERS        = 2.

     IF sy-subrc IS INITIAL.
      i_upld = v_arqv.
       me->carrega_dados( ).
     ENDIF.
    ENDMETHOD.

    "Carrega os dados do arquivo de upload para uma tabela interna
    METHOD carrega_dados.
    v_filename = v_arqv.

    CALL FUNCTION 'GUI_UPLOAD'
      EXPORTING
        filename                = v_filename
        filetype                = 'ASC'
      TABLES
        data_tab                = it_arq
      EXCEPTIONS
         file_open_error         = 1
         file_read_error         = 2
         no_batch                = 3
         gui_refuse_filetransfer = 4
         invalid_type            = 5
         no_authority            = 6
         unknown_error           = 7
         bad_data_format         = 8
         header_not_allowed      = 9
         separator_not_allowed   = 10
         header_too_long         = 11
         unknown_dp_error        = 12
         access_denied           = 13
         dp_out_of_memory        = 14
         disk_full               = 15
         dp_timeout              = 16
         OTHERS                  = 17.
     IF sy-subrc <> 0.
       MESSAGE 'Erro no upload do arquivo!' TYPE 'E'.
       EXIT.
     ELSE.
       me->popula_it_options( ).
     ENDIF.
    ENDMETHOD.

     "Popula it_options
    METHOD popula_it_options.
      DATA wa_options TYPE rfc_db_opt.

      LOOP AT it_arq INTO DATA(wa_arq).
        IF sy-tabix EQ '1'.
          CONTINUE.
        ELSE.
         CONCATENATE 'MATNR =' wa_arq-linha+0(18) 'AND WERKS =' wa_arq-linha+19(22)  INTO wa_options SEPARATED BY space.
         APPEND wa_options TO me->it_options.
         CLEAR wa_options.
        ENDIF.
      ENDLOOP.
    ENDMETHOD.

    "Retorna it_options
    METHOD get_it_options.

    ENDMETHOD.
ENDCLASS.

*lcl_tela
CLASS lcl_tela IMPLEMENTATION.
  "Modifica tela de seleção de acordo com os raiobuttons
  METHOD modifica_tela.
    LOOP AT SCREEN.
      "RFC
      IF i_rfc EQ 'X'.
        IF screen-group1 EQ 'RFC'.
          screen-invisible = 0.
          screen-input     = 1.
          screen-active    = 1.
        ENDIF.
      ENDIF.

      "UPD
      IF i_upd EQ 'X'.
        IF screen-group1 EQ 'RFC'.
          screen-invisible = 1.
          screen-input     = 0.
          screen-active    = 0.
        ENDIF.
      ENDIF.
      MODIFY SCREEN.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.

*lcl_rfc
CLASS lcl_rfc IMPLEMENTATION.
  "Faz o select da marc via RFC
  METHOD chamar_rfc.

    me->matnr = i_matnr.
    me->werks = i_werks.

    me->popula_it_options( ).
    me->popula_it_fields( ).

    DO.
      CLEAR r_marc.
      v_num_loop = v_num_loop + 1.

      CALL FUNCTION 'RFC_READ_TABLE' DESTINATION 'Z_ECC_PRD'
        EXPORTING
          query_table          = 'marc'
          rowskips             = v_skip
          rowcount             = v_count
          get_sorted           = 'X'
        TABLES
          options              = it_options
          fields               = it_fields
          data                 = r_marc
        EXCEPTIONS
          table_not_available  = 1
          table_without_data   = 2
          option_not_valid     = 3
          field_not_valid      = 4
          not_authorized       = 5
          data_buffer_exceeded = 6
          OTHERS               = 7.
      IF sy-subrc <> 0.
        MESSAGE 'Não foi possível acessar os dados pela RFC.' TYPE 'E'.
        EXIT.
      ENDIF.

      IF r_marc IS NOT INITIAL.
        me->append_tabela_z( ).
      ENDIF.

      "Sai do loop se o número de registros retornados for menor que 200 (último lote)
      DESCRIBE TABLE r_marc LINES v_total.
      IF v_total < v_count.
        EXIT.
      ENDIF.

    ENDDO.

    me->show_log( ).

  ENDMETHOD.

  "Passa as os filtros da cláusula WHERE para it_options
  METHOD popula_it_options.
    DATA wa_options TYPE rfc_db_opt.

    CONCATENATE 'MATNR =' matnr 'AND WERKS =' werks  INTO wa_options SEPARATED BY space.
    APPEND wa_options TO me->it_options.
    CLEAR wa_options.

  ENDMETHOD.

  "Passa os campos da marc que deverão ser trazidos na hora da seleção
  METHOD popula_it_fields.
    DATA it_fields_bseg  TYPE TABLE OF dfies.

    "Recupera todos os campos da marc
    CALL FUNCTION 'DDIF_FIELDINFO_GET'
      EXPORTING
        tabname        = 'MARC'
      TABLES
        dfies_tab      = it_fields_bseg
      EXCEPTIONS
        not_found      = 1
        internal_error = 2
        OTHERS         = 3.

    IF sy-subrc EQ 0.
      "Appenda o nome de todos os campos na it_fields
      LOOP AT it_fields_bseg INTO DATA(wa_fields_bseg).
        wa_fields-fieldname = wa_fields_bseg-fieldname.
        APPEND wa_fields TO it_fields.
        CLEAR: wa_fields,
               wa_fields_bseg.
      ENDLOOP.
    ENDIF.

  ENDMETHOD.

  "Appenda os campos Z da marc numa tabela Z
  METHOD append_tabela_z.
    DATA wa_log_tab_z LIKE LINE OF it_log_tab_z.

    INSERT zmarc FROM TABLE r_marc.

    IF sy-subrc = 0.
      "Incrementa o número de registros a pular
      ADD v_count TO v_skip.

      COMMIT WORK.
      wa_log_tab_z-mensagem = 'Dados inseridos com sucesso na tabela zmarc!'.
      wa_log_tab_z-num_loop = v_num_loop.
      APPEND wa_log_tab_z TO it_log_tab_z.
      CLEAR wa_log_tab_z.
    ELSE.
      ROLLBACK WORK.
      wa_log_tab_z-mensagem = 'Erro ao inserir dados na tabela zmarc!'.
      wa_log_tab_z-num_loop = v_num_loop.
      APPEND wa_log_tab_z TO it_log_tab_z.
      CLEAR wa_log_tab_z.
    ENDIF.

  ENDMETHOD.

  "Chama pop up de confirmação
  METHOD display_pop_up.
    DATA: lv_resposta TYPE c.

    "Mostra pop up de confirmação
    CALL FUNCTION 'POPUP_TO_CONFIRM'
      EXPORTING
        titlebar              = 'Confirmação'
        text_question         = 'Essa ação poderá modificar dados da tabela marc, tem certeza que deseja continuar?'
        text_button_1         = 'Sim'
        text_button_2         = 'Não'
        default_button        = '1'
        display_cancel_button = 'X'
      IMPORTING
        answer                = lv_resposta.

    IF lv_resposta = '1'.
      "Sim
      me->atualiza_marc( ).
    ELSE.
      " Não
      EXIT.
    ENDIF.
  ENDMETHOD.

  "Insere os dados dos campos g na marc
  METHOD atualiza_marc.
    DATA wa_log LIKE LINE OF it_log.
    v_show_log_z = ' '.

    "Seleciona todos os registros da zmarc
    SELECT * FROM zmarc
      INTO TABLE @DATA(it_zmarc).

    IF it_zmarc IS NOT INITIAL AND sy-subrc EQ 0.
      "Seleciona todos os registros da marc
      SELECT * FROM marc
       INTO TABLE @DATA(it_marc).

      LOOP AT it_zmarc INTO DATA(wa_zmarc).
        "Verifica se o registro da linha atual de zmarc existe na marc
        READ TABLE it_marc WITH KEY matnr = wa_zmarc-matnr
                                    werks = wa_zmarc-werks
                    TRANSPORTING NO FIELDS.
        IF sy-subrc EQ 0.
          "Modifica a linha da marc onde as chaves forem iguais as de wa_zmarc
          MODIFY marc FROM wa_zmarc.

          IF sy-subrc = 0.
            COMMIT WORK.
            wa_log-mensagem = 'Linha atualizada com sucesso na tabela marc!'.
            wa_log-matnr = wa_zmarc-matnr.
            wa_log-werks = wa_zmarc-werks.
            APPEND wa_log TO it_log.
            CLEAR wa_log.
          ELSE.
            ROLLBACK WORK.
            wa_log-mensagem = 'Erro ao tentar atualizar linha na tabela marc!'.
            wa_log-matnr = wa_zmarc-matnr.
            wa_log-werks = wa_zmarc-werks.
            APPEND wa_log TO it_log.
            CLEAR wa_log.
          ENDIF.

        ELSE.
          CONTINUE.
        ENDIF.

      ENDLOOP.
      me->show_log( ).
    ELSE.
      MESSAGE 'Não é possível fazer a carga na MARC, pois nenhum registro foi encontrado na ZMARC!.' TYPE 'E'.
    ENDIF.

  ENDMETHOD.

  "Mostra log com registros que foram alterados
  METHOD show_log.
    DATA: lo_table   TYPE REF TO cl_salv_table,
          lo_header  TYPE REF TO cl_salv_form_layout_grid,
          lo_columns TYPE REF TO cl_salv_columns_table.

    TRY.
        IF v_show_log_z IS NOT INITIAL.
          cl_salv_table=>factory( IMPORTING r_salv_table = lo_table
                                  CHANGING t_table = it_log_tab_z ).
        ELSE.
          cl_salv_table=>factory( IMPORTING r_salv_table = lo_table
                                  CHANGING t_table = it_log ).
        ENDIF.

        "Ativa os met codes
        lo_table->get_functions( )->set_all( abap_true ).

        "Mudar nome das colunas do ALV
        lo_table->get_columns( )->get_column( 'MENSAGEM' )->set_short_text( 'Msg.' ).
        lo_table->get_columns( )->get_column( 'MENSAGEM' )->set_medium_text( 'Mensagem' ).
        lo_table->get_columns( )->get_column( 'MENSAGEM' )->set_long_text( 'Mensagem' ).

        IF v_show_log_z IS NOT INITIAL.
          "Mudar nome das colunas do ALV
          lo_table->get_columns( )->get_column( 'NUM_LOOP' )->set_short_text( 'Núm. Loop' ).
          lo_table->get_columns( )->get_column( 'NUM_LOOP' )->set_medium_text( 'Número do loop' ).
          lo_table->get_columns( )->get_column( 'NUM_LOOP' )->set_long_text( 'Número do loop' ).
        ENDIF.

        CREATE OBJECT lo_header.

        "título do header
        lo_header->create_header_information( row = 1 column = 1 text = 'Log' ).

        lo_header->add_row( ).

        lo_table->get_display_settings( )->set_striped_pattern( abap_true ).

        lo_table->set_top_of_list( lo_header ).

        lo_columns = lo_table->get_columns( ). "Ajusta tamanho dos subtítulos
        lo_columns->set_optimize( abap_true ). "Ajusta tamanho dos subtítulos

        "Exibe o ALV
        lo_table->display( ) .

      CATCH cx_salv_msg
            cx_root.
        MESSAGE s398(00) WITH 'Erro ao exibir tabela de log!' DISPLAY LIKE 'E'.
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
