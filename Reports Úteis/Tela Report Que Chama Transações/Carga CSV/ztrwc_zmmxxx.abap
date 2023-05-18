*----------------------------------------------------------------------*
* Autor....: Wesley Constantino dos Santos                             *
* Data.....: 05/04/2023                                                *
* Módulo...:                                                           *
* Descrição:                                                           *
*----------------------------------------------------------------------*
*                   Histórico das Alterações                           *
*----------------------------------------------------------------------*
* DATA      | AUTOR         | Request    | DESCRIÇÃO                   *
*----------------------------------------------------------------------*
*           | ABI-WCONSTANTINO    |            | Codificação Inicial   *
*----------------------------------------------------------------------*
REPORT ztrwc_zmmxxx.

*&---------------------------------------------------------------------*
*                              Types                                   *
*&---------------------------------------------------------------------*

*------* ty_arquivo
TYPES:BEGIN OF ty_arquivo,
        linha(2000) TYPE c,
      END OF ty_arquivo,

*------* ty_out
      BEGIN OF ty_out,
        ebeln TYPE ekko-ebeln, "Contrato (Contrato informado na tela de seleção)
        ematn TYPE ekpo-ematn, "Material (Material informado no arquivo)
        maktx TYPE makt-maktx, "Texto Breve (Com EKPO-EMATN, buscar o texto do material na tabela MAKT-MAKTX)
        netpr TYPE ekpo-netpr, "Preço líquido (Preço informado no arquivo)
        mwskz TYPE ekpo-mwskz, "IVA (IVA informado no arquivo)
        labnr TYPE ekpo-labnr, "Número do processo (Numero informado no arquivo)
      END OF ty_out,

*------* ty_makt
      BEGIN OF ty_makt,
        maktx TYPE makt-maktx,
        matnr TYPE makt-matnr,
      END OF ty_makt,

*------* ty_out_bapi
      BEGIN OF ty_out_bapi,
        ebeln    TYPE ekko-ebeln,
        item     TYPE bapimeoutitem-item_no,
        ematn    TYPE ekpo-ematn,
        maktx    TYPE makt-maktx,
        labnr    TYPE ekpo-labnr,
        msgerror TYPE string,
      END OF ty_out_bapi.

*&---------------------------------------------------------------------*
*                        Tabelas  Internas                             *
*&---------------------------------------------------------------------*
DATA: it_arquivo TYPE TABLE OF ty_arquivo,
      it_out     TYPE TABLE OF ty_out,
      it_makt    TYPE TABLE OF ty_makt,
      it_item    TYPE STANDARD TABLE OF bapimeoutitem,
      it_itemx   TYPE STANDARD TABLE OF bapimeoutitemx,
      it_return  TYPE STANDARD TABLE OF bapiret2,
      it_log     TYPE TABLE OF ty_out_bapi.

*&---------------------------------------------------------------------*
*                            Workareas                                 *
*&---------------------------------------------------------------------*
DATA: wa_arquivo TYPE ty_arquivo,
      wa_out     TYPE ty_out,
      wa_makt    TYPE ty_makt,
      wa_item    TYPE bapimeoutitem,
      wa_itemx   TYPE bapimeoutitemx.

*&---------------------------------------------------------------------*
*                        Estruturas do ALV                             *
*&---------------------------------------------------------------------*
DATA: og_container_9000 TYPE REF TO cl_gui_custom_container,
      og_grid_9000      TYPE REF TO cl_gui_alv_grid,
      vg_okcode_9000    TYPE sy-ucomm,
      tg_fieldcat       TYPE lvc_t_fcat,
      wa_layout         TYPE lvc_s_layo,
      wa_variant        TYPE disvariant.

*&---------------------------------------------------------------------*
*                            Variaveis                                 *
*&---------------------------------------------------------------------*
*------* VARIÁVEIS PARA O POPUP DE SELEÇÃO DE ARQUIVOS
DATA: it_files TYPE filetable,
      wa_files TYPE file_table,
      vg_rc    TYPE i.
*------* VARIÁVEIS PARA O DOWLOAD
DATA: vg_arqv     LIKE rlgrap-filename,
      vg_filename TYPE string.

DATA: gv_ebelp TYPE ekpo-ebelp.

*&---------------------------------------------------------------------*
*                         Tela de seleção                              *
*&---------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK b0 WITH FRAME TITLE text-000.
PARAMETERS: p_ebeln TYPE ekko-ebeln. "Contrato: Nº do documento de compras
SELECTION-SCREEN END OF BLOCK b0.
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-001.
PARAMETERS: p_file(1024) TYPE c. "OBLIGATORY. "Caminho do Arquivo
SELECTION-SCREEN END OF BLOCK b1.
SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE text-002.
*Radio Buttons
PARAMETERS: rb_sim RADIOBUTTON GROUP g1 DEFAULT 'X' USER-COMMAND comando.
PARAMETERS: rb_nao RADIOBUTTON GROUP g1.

PARAMETERS: p_dwld LIKE rlgrap-filename MODIF ID dwl. "Caminho
SELECTION-SCREEN END OF BLOCK b2.

*Evento validar o tipo do documento
AT SELECTION-SCREEN ON p_ebeln.
  PERFORM: zf_valida_documento.

*Evento caminho de upload
AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_file.
  PERFORM zf_exibe_popup_caminho_upload.

*Evento radiobuttons
AT SELECTION-SCREEN OUTPUT.
  PERFORM modifica_tela.

*Início da execusão
START-OF-SELECTION.
  IF  p_file IS INITIAL.
    MESSAGE 'Insira o caminho do upload do arquivo!' TYPE 'S' DISPLAY LIKE 'E'.
  ELSE.
    PERFORM: zf_gui_upload,
             zf_split_upload.
    CALL SCREEN 9000.
  ENDIF.

*&---------------------------------------------------------------------*
*                        FORM zf_valida_documento                      *
*&---------------------------------------------------------------------*
FORM zf_valida_documento.

  SELECT SINGLE bsart
    FROM ekko
    INTO @DATA(vl_bsart)
    WHERE ebeln EQ @p_ebeln
      AND bsart EQ 'ZIPK'.

  IF sy-subrc IS NOT INITIAL.
    MESSAGE s000(zsdlpu) DISPLAY LIKE 'E'.
    STOP.
  ENDIF.

ENDFORM.


*&---------------------------------------------------------------------*
*&      Form  MODIFICA_TELA
*&---------------------------------------------------------------------*
FORM modifica_tela .
  LOOP AT SCREEN.
*------* SIM
    IF rb_sim EQ 'X'.
      IF screen-group1 EQ 'DWL'.
        screen-invisible = 0.
        screen-input     = 1.
        screen-active    = 1.
      ENDIF.
    ENDIF.

*------* NÃO
    IF rb_nao EQ 'X'.
      IF screen-group1 EQ 'DWL'.
        screen-invisible = 1.
        screen-input     = 0.
        screen-active    = 0.
      ENDIF.
    ENDIF.
    MODIFY SCREEN.
  ENDLOOP.
ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  ZF_EXIBE_POPUP_CAMINHO_UPLOAD
*&---------------------------------------------------------------------*
FORM zf_exibe_popup_caminho_upload .

  CALL METHOD cl_gui_frontend_services=>file_open_dialog
    CHANGING
      file_table              = it_files
      rc                      = vg_rc
    EXCEPTIONS
      file_open_dialog_failed = 1
      cntl_error              = 2
      error_no_gui            = 3
      not_supported_by_gui    = 4
      OTHERS                  = 5.

  IF sy-subrc NE 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
    WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ELSE.
    READ TABLE it_files INTO wa_files INDEX 1.
    p_file = wa_files-filename.
  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*&      Module  STATUS_9000  OUTPUT
*&---------------------------------------------------------------------*
MODULE status_9000 OUTPUT.
  SET PF-STATUS 'STATUS_9000'.
  SET TITLEBAR 'TITLE_9000'.

  PERFORM: zf_show_grid_9000.
ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_9000  INPUT
*&---------------------------------------------------------------------*
MODULE user_command_9000 INPUT.

  CASE vg_okcode_9000.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0. "Volta para a tela chamadora
    WHEN 'EXIT'.
      LEAVE PROGRAM. "Sai do programa
    WHEN 'EXECUTAR'.
      PERFORM : zf_preenche_tabelas_bapi,
                zf_bapi_contract_change.

      DATA(wa_return) = VALUE #( it_return[ type = 'S' ] OPTIONAL ).
      IF it_log[]  IS INITIAL AND
       ( wa_return IS NOT INITIAL OR
         it_return IS INITIAL ).

        APPEND INITIAL LINE TO it_log ASSIGNING FIELD-SYMBOL(<fs_log>).
        <fs_log>-ebeln    = p_ebeln.
        <fs_log>-ematn    = 'ALL'.
        <fs_log>-item     = 'ALL'.
        <fs_log>-labnr    = 'ALL'.
        <fs_log>-maktx    = 'ALL'.
        <fs_log>-msgerror = |Todos os Itens para Contrato { p_ebeln } Foram Processados com Sucesso!|.
        UNASSIGN <fs_log>.

      ELSE.
        PERFORM: zf_relatorio_alv_erros_bapi.
      ENDIF.
  ENDCASE.
ENDMODULE.

*&---------------------------------------------------------------------*
*                          zf_gui_upload                               *
*&---------------------------------------------------------------------*
FORM  zf_gui_upload.

  DATA vl_file  TYPE string.

  vl_file = p_file.

  CALL FUNCTION 'GUI_UPLOAD'
    EXPORTING
      filename                = vl_file
      filetype                = 'ASC'
    TABLES
      data_tab                = it_arquivo
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
    MESSAGE 'Erro no upload!' TYPE 'S' DISPLAY LIKE 'E'.
  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  zf_split_upload
*&---------------------------------------------------------------------*
FORM zf_split_upload.
  DATA: vl_netpr(11) TYPE c.

  IF it_arquivo[] IS NOT INITIAL.
    LOOP AT it_arquivo INTO wa_arquivo.
*--* Início *--* Ignora a primeira linha do arquivo CSV do upload.
      IF sy-tabix EQ '1'.
        CONTINUE.
      ENDIF.
*--* Fim *--*
      SPLIT wa_arquivo-linha AT ';' INTO
                                    wa_out-ematn
                                    vl_netpr
                                    wa_out-mwskz
                                    wa_out-labnr.
      wa_out-netpr = vl_netpr.
      wa_out-ebeln = p_ebeln.



      APPEND wa_out TO it_out.
      CLEAR  wa_out.
    ENDLOOP.
  ENDIF.

  PERFORM zf_seleciona_texto_breve.

ENDFORM.

*&---------------------------------------------------------------------*
*                     FORM zf_seleciona_texto_breve                    *
*&---------------------------------------------------------------------*
FORM zf_seleciona_texto_breve.

  SELECT maktx
         matnr
    FROM makt
    INTO TABLE it_makt
    FOR ALL ENTRIES IN it_out
    WHERE matnr EQ it_out-ematn.

  LOOP AT it_out INTO wa_out.

    READ TABLE it_makt INTO wa_makt WITH KEY matnr = wa_out-ematn.
    IF wa_makt IS NOT INITIAL.
      wa_out-maktx = wa_makt-maktx.
    ENDIF.

  ENDLOOP.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  zf_build_9000
*&---------------------------------------------------------------------*
FORM zf_show_grid_9000.

  FREE: tg_fieldcat[],
        wa_layout,
        wa_variant.

  wa_layout-cwidth_opt = 'X'. "Ajustar largura das colunas (Layout otimizado).
  wa_layout-zebra      = 'X'. "Layout em Zebra.
  wa_variant-report    = sy-repid. "Variante (Não usá-la quando o tipo foi pop-up).

  PERFORM zf_build_fieldcat USING:
            'EBELN' 'EBELN' 'Contrato'               CHANGING tg_fieldcat[],
            'EMATN' 'EMATN' 'Material'               CHANGING tg_fieldcat[],
            'MAKTX' 'MAKTX' 'Texto Breve'            CHANGING tg_fieldcat[],
            'NETPR' 'NETPR' 'Preço Líquido Unitário' CHANGING tg_fieldcat[],
            'MWSKZ' 'MWSKZ' 'IVA'                    CHANGING tg_fieldcat[],
            'LABNR' 'LABNR' 'Número Processo'        CHANGING tg_fieldcat[].

  IF og_grid_9000 IS INITIAL.
    "Cria objeto do container do Module Pool
    "og_container_9000 = NEW cl_gui_custom_container( container_name = 'CONTAINER_9000' ).
    "Instância o objeto do ALV
    og_grid_9000 = NEW cl_gui_alv_grid( i_parent = cl_gui_custom_container=>default_screen )."Caso haja uso de container ( i_parent = lo_container_9000 ).

    "Permite fazer seleção múltipla de linhas no ALV
    og_grid_9000->set_ready_for_input( 1 ).

    "Chama o ALV pela primeira vez
    og_grid_9000->set_table_for_first_display(
    EXPORTING
      is_variant  = wa_variant "Variant para seleção múltipla do alv
      is_layout   = wa_layout
      i_save      = 'A'
    CHANGING
      it_fieldcatalog = tg_fieldcat[]
      it_outtab       = it_out[]  "Tabela de saída
    ).

    "Define título do ALV
    og_grid_9000->set_gridtitle( 'Tabela' ).
  ELSE.
    "Atualiza tela, caso haja alteração nos dados da tabela interna
    og_grid_9000->refresh_table_display( ).
  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  zf_build_fieldcat
*&---------------------------------------------------------------------*
FORM zf_build_fieldcat USING VALUE(p_fieldname) TYPE c
                             VALUE(p_field)     TYPE c
                             VALUE(p_coltext)   TYPE c
                          CHANGING t_fieldcat   TYPE lvc_t_fcat.

  DATA: ls_fieldcat LIKE LINE OF t_fieldcat[].

  "Nome do campo dado na tabela interna
  ls_fieldcat-fieldname = p_fieldname.

  "Nome do campo na tabela transparente
  ls_fieldcat-ref_field = p_field.

  "Descrição que daremos para o campo no ALV.
  ls_fieldcat-coltext   = p_coltext.


  APPEND ls_fieldcat TO t_fieldcat[].

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  zf_preenche_tabelas_bapi
*&---------------------------------------------------------------------*
FORM zf_preenche_tabelas_bapi.

  SELECT MAX( ebelp )
  FROM ekpo
  INTO gv_ebelp
  WHERE ebeln EQ p_ebeln.

  gv_ebelp = gv_ebelp + 10.

  SELECT SINGLE werks
  FROM ekpo
  INTO @DATA(lv_werks)
  WHERE ebeln = @p_ebeln.

  SELECT matnr,
       steuc
  FROM marc
  INTO TABLE @DATA(lt_marc)
  FOR ALL ENTRIES IN @it_out
  WHERE werks EQ @lv_werks
    AND matnr EQ @it_out-ematn.

  LOOP AT it_out INTO wa_out.
*    Monta tabela item
    wa_item-item_no    = gv_ebelp.
    wa_item-material   = wa_out-ematn.
    wa_item-net_price  = wa_out-netpr.
    wa_item-tax_code   = wa_out-mwskz.
    wa_item-acknowl_no = wa_out-labnr.

    DATA(wa_marc) = VALUE #( lt_marc[ matnr = wa_out-ematn ] OPTIONAL ).
    IF lt_marc IS NOT INITIAL.
      wa_item-bras_nbm = wa_marc-steuc.
    ENDIF.

    APPEND: wa_item TO it_item.

*    Monta tabela itemx
    wa_itemx-item_no    = wa_item-item_no.
    wa_itemx-material   = 'X'.
    wa_itemx-net_price  = 'X'.
    wa_itemx-tax_code   = 'X'.
    wa_itemx-bras_nbm   = 'X'.
    wa_itemx-acknowl_no = 'X'.

    APPEND: wa_itemx TO it_itemx.

    CLEAR: wa_out, wa_item, wa_itemx.

  ENDLOOP.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  zf_bapi_contract_change
*&---------------------------------------------------------------------*
FORM zf_bapi_contract_change.

  CALL FUNCTION 'BAPI_CONTRACT_CHANGE'
    EXPORTING
      purchasingdocument = p_ebeln
    TABLES
      item               = it_item
      itemx              = it_itemx
      return             = it_return.

  READ TABLE it_return INTO DATA(wa_return) WITH KEY type = 'E'.
  IF wa_return IS INITIAL.
    CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
      EXPORTING
        wait = 'X'.
  ELSE.
    CALL FUNCTION 'BAPI_TRANSACTION_ROLLBACK'.
    PERFORM: zf_trata_erros_bapi.
  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  ZF_TRATA_ERROS_BAPI
*&---------------------------------------------------------------------*
FORM zf_trata_erros_bapi .

  LOOP AT it_return INTO DATA(wa_return) WHERE type = 'E'.
    PERFORM zf_build_log USING wa_return-message.
    CLEAR: wa_out, gv_ebelp.
  ENDLOOP.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  ZF_BUILD_LOG
*&---------------------------------------------------------------------*
FORM zf_build_log  USING    p_message.

  APPEND INITIAL LINE TO it_log ASSIGNING FIELD-SYMBOL(<fs_log>).
  <fs_log>-ebeln    = wa_out-ebeln.
  <fs_log>-ematn    = wa_out-ematn.
  <fs_log>-item     = gv_ebelp.
  <fs_log>-labnr    = wa_out-labnr.
  <fs_log>-maktx    = wa_out-maktx.
  <fs_log>-msgerror = p_message.
  UNASSIGN <fs_log>.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  ZF_RELATORIO_ALV_ERROS_BAPI
*&---------------------------------------------------------------------*
FORM zf_relatorio_alv_erros_bapi .

  IF it_log IS NOT INITIAL.

    DATA: lo_table     TYPE REF TO cl_salv_table,
          lo_functions TYPE REF TO cl_salv_functions_list.

    TRY.
        cl_salv_table=>factory(
          IMPORTING
            r_salv_table = lo_table
          CHANGING
            t_table      = it_log[] ).

      CATCH cx_salv_msg.
    ENDTRY.


    lo_functions = lo_table->get_functions( ).
    lo_functions->set_all( 'X' ).

    IF lo_table IS BOUND.

      lo_table->set_screen_popup(
        start_column = 10
        end_column   = 170
        start_line   = 2
        end_line     = 20  ).

      TRY.
          lo_table->get_columns( )->get_column( 'EBELN' )->set_output_length( 15 ).
          lo_table->get_columns( )->get_column( 'EBELN' )->set_alignment( if_salv_c_alignment=>centered ).
          lo_table->get_columns( )->get_column( 'EBELN' )->set_short_text( 'Contrato' ).
          lo_table->get_columns( )->get_column( 'EBELN' )->set_medium_text( 'Contrato' ).

          lo_table->get_columns( )->get_column( 'ITEM' )->set_output_length( 4 ).
          lo_table->get_columns( )->get_column( 'ITEM' )->set_alignment( if_salv_c_alignment=>centered ).
          lo_table->get_columns( )->get_column( 'ITEM' )->set_short_text( 'Item' ).

          lo_table->get_columns( )->get_column( 'EMATN' )->set_output_length( 18 ).
          lo_table->get_columns( )->get_column( 'EMATN' )->set_alignment( if_salv_c_alignment=>centered ).
          lo_table->get_columns( )->get_column( 'EMATN' )->set_medium_text( 'Material ' ).

          lo_table->get_columns( )->get_column( 'MAKTX' )->set_output_length( 45 ).
          lo_table->get_columns( )->get_column( 'MAKTX' )->set_long_text( 'Texto Breve' ).
          lo_table->get_columns( )->get_column( 'MAKTX' )->set_medium_text( 'Texto Breve' ).

          lo_table->get_columns( )->get_column( 'LABNR' )->set_output_length( 18 ).
          lo_table->get_columns( )->get_column( 'LABNR' )->set_alignment( if_salv_c_alignment=>centered ).
          lo_table->get_columns( )->get_column( 'LABNR' )->set_long_text( 'Número de Processo' ).

          lo_table->get_columns( )->get_column( 'MSGERROR' )->set_output_length( 60 ).
          lo_table->get_columns( )->get_column( 'MSGERROR' )->set_long_text( 'Mensagem de Erro' ).

        CATCH cx_salv_not_found.
      ENDTRY.

      lo_table->display( ).

      IF rb_sim IS NOT INITIAL.
        PERFORM zf_download_log_execucao.
      ENDIF.

    ENDIF.
  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  ZF_DOWNLOAD_LOG_EXECUCAO
*&---------------------------------------------------------------------*
FORM zf_download_log_execucao .

  DATA: lt_log_txt     TYPE truxs_t_text_data,
        wa_log_txt     LIKE LINE OF lt_log_txt,
        lt_log_txt_aux TYPE truxs_t_text_data.

  DATA: lv_fname TYPE string.

  CALL FUNCTION 'SAP_CONVERT_TO_CSV_FORMAT'
    EXPORTING
      i_field_seperator    = ';'
      i_line_header        = 'X'
    TABLES
      i_tab_sap_data       = it_log
    CHANGING
      i_tab_converted_data = lt_log_txt
    EXCEPTIONS
      conversion_failed    = 1
      OTHERS               = 2.


  wa_log_txt = |Contrato;Item;Material;Texto Breve;Numero de Processo;Mensagem de Erro;|.
  APPEND wa_log_txt TO lt_log_txt_aux.

  LOOP AT lt_log_txt INTO wa_log_txt.
    APPEND wa_log_txt TO lt_log_txt_aux.
  ENDLOOP.

  lv_fname = p_dwld.

  CALL FUNCTION 'GUI_DOWNLOAD'
    EXPORTING
      bin_filesize            = ''
      filename                = lv_fname
      filetype                = 'ASC'
    TABLES
      data_tab                = lt_log_txt_aux
    EXCEPTIONS
      file_write_error        = 1
      no_batch                = 2
      gui_refuse_filetransfer = 3
      invalid_type            = 4
      no_authority            = 5
      unknown_error           = 6
      header_not_allowed      = 7
      separator_not_allowed   = 8
      filesize_not_allowed    = 9
      header_too_long         = 10
      dp_error_create         = 11
      dp_error_send           = 12
      dp_error_write          = 13
      unknown_dp_error        = 14
      access_denied           = 15
      dp_out_of_memory        = 16
      disk_full               = 17
      dp_timeout              = 18
      file_not_found          = 19
      dataprovider_exception  = 20
      control_flush_error     = 21
      OTHERS                  = 22.

  IF sy-subrc IS INITIAL.
    MESSAGE 'Download Efetuado com Sucesso!' TYPE 'S'.
  ENDIF.

  CLEAR: it_log.
ENDFORM.
