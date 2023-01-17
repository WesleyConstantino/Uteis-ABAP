*&---------------------------------------------------------------------*
*&      Form  ZF_exibe_alv_poo
*&---------------------------------------------------------------------*
FORM zf_exibe_alv_poo.

  DATA: lo_table   TYPE REF TO cl_salv_table,  "Acessar a classe "cl_salv_table"
        lo_header  TYPE REF TO cl_salv_form_layout_grid,   "Para criação do header
        lo_columns TYPE REF TO cl_salv_columns_table.  "Ajustar tamanho dos subtítulos

  TRY.
      cl_salv_table=>factory( IMPORTING r_salv_table = lo_table "Tabela local
                             CHANGING t_table = t_out ). "Passar a tabela de saída, aqui é a t_out

      lo_table->get_functions( )->set_all( abap_true ). "Ativar met codes

*Campos que serão ocultados da t_out de acordo com RADIOBUTTON selecionado:
      IF rb_anali = 'X'. "2
        lo_table->get_columns( )->get_column( 'NETWR_VBAK' )->set_visible( abap_false ). "Ocultar campos da t_out
        lo_table->get_columns( )->get_column( 'NFTOT' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'SOMA_NETWR' )->set_visible( abap_false ).
      ELSE. "1
        lo_table->get_columns( )->get_column( 'POSNR' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'MATNR' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'ARKTX' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'NETWR_VBAP' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'NETWR_J_1BNFLIN' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'SOMA_KBETR' )->set_visible( abap_false ).
      ENDIF.

*Mudar nome das colunas do ALV
      lo_table->get_columns( )->get_column( 'SOMA_NETWR' )->set_short_text( 'Soma' ). "Mudar o texto curto da tabela
      lo_table->get_columns( )->get_column( 'SOMA_NETWR' )->set_medium_text( 'Soma' ).
      lo_table->get_columns( )->get_column( 'SOMA_NETWR' )->set_long_text( 'Soma' ).

      CREATE OBJECT lo_header. "É necessário que criemos o objeto header

      IF rb_anali = 'X'.
        lo_header->create_header_information( row = 1 column = 1 text = 'Relatório Analítico' ). "Texto grande do header
      ELSE.
        lo_header->create_header_information( row = 1 column = 1 text = 'Relatório Sintético' ).
      ENDIF.

      lo_header->add_row( ).


      lo_table->get_display_settings( )->set_striped_pattern( abap_true ).

      lo_table->set_top_of_list( lo_header ).

      lo_columns = lo_table->get_columns( ). "Ajustar tamanho dos subtítulos
      lo_columns->set_optimize( abap_true ). "Ajustar tamanho dos subtítulos

      lo_table->display( ) . "O dispay é fundamental para a exibição do ALV

    CATCH cx_salv_msg
          cx_root.

      MESSAGE s398(00) WITH 'Erro ao exibir tabela' DISPLAY LIKE 'E'.

  ENDTRY.

ENDFORM.
