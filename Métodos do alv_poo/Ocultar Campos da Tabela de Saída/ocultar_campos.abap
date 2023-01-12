"Ocultar campos da t_out na exibição:

lo_table->get_columns( )->get_column( 'NOME DO CAMPO A SER OCULTADO DA T_OUT' )->set_visible( abap_false ). 

*Obs: #Chamar o método apenas depois de declarar a lo_table.
*     #O NOME DO CAMPO A SER OCULTADO DA T_OUT passado dentro dos parêntesis em aspas simples deve estar sempre em MAIUSCÚLO.


*****************************************************************************************************************************
Exemplo real:

*&---------------------------------------------------------------------*
*                                 TYPES                                *
*&---------------------------------------------------------------------*
       BEGIN OF ty_out, 
         aufnr           TYPE vbap-aufnr, 
         vbeln           TYPE vbak-vbeln, 
         posnr           TYPE vbap-posnr, 
         erdat           TYPE vbak-erdat, 
         matnr           TYPE vbap-matnr, 
         arktx           TYPE vbap-arktx, 
         auart           TYPE vbak-auart, 
         werks           TYPE vbap-werks, 
         lgort           TYPE vbap-lgort, 
         vkorg           TYPE vbak-vkorg, 
         vtweg           TYPE vbak-vtweg, 
         spart           TYPE vbak-spart, 
         vkbur           TYPE vbak-vkbur, 
         netwr_vbak      TYPE vbak-netwr, 
         netwr_vbap      TYPE vbap-netwr, 
         waerk           TYPE vbak-waerk, 
         kunnr           TYPE vbak-kunnr, 
         name1           TYPE kna1-name1, 
         txjcd           TYPE kna1-txjcd, 
         ort01           TYPE kna1-ort01,
         pstlz           TYPE kna1-pstlz,
         regio           TYPE kna1-regio, 
         stras           TYPE kna1-stras, 
         ort02           TYPE kna1-ort02, 
         stcd1           TYPE kna1-stcd1, 
         stcd2           TYPE kna1-stcd2, 
         stcd3           TYPE kna1-stcd3, 
         bstnk           TYPE vbak-bstnk, 
         lifsk           TYPE vbak-lifsk, 
         vgbel           TYPE vbrp-vgbel, 
         vbeln2          TYPE vbrp-vbeln, 
         nfenum          TYPE j_1bnfdoc-nfenum, 
         docnum          TYPE j_1bnflin-docnum, 
         nftot           TYPE j_1bnfdoc-nftot,
         netwr_j_1bnflin TYPE j_1bnflin-netwr, 
         authdate        TYPE j_1bnfdoc-authdate, 
       END OF ty_out,


*&---------------------------------------------------------------------*
*                         Tela de seleção                              *
*&---------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK b0 WITH FRAME TITLE text-000.
*Radio Buttons
PARAMETERS: rb_sinte RADIOBUTTON GROUP g1 DEFAULT 'X' USER-COMMAND cmd,
            rb_anali RADIOBUTTON GROUP g1.
SELECTION-SCREEN END OF BLOCK b0.


*&---------------------------------------------------------------------*
*&      Form  ZF_exibe_alv_poo
*&---------------------------------------------------------------------*
FORM zf_exibe_alv_poo.

  DATA: lo_table  TYPE REF TO cl_salv_table,  "Acessar a classe "cl_salv_table"
        lo_header TYPE REF TO cl_salv_form_layout_grid.   "Para criação do header

  TRY.
      cl_salv_table=>factory( IMPORTING r_salv_table = lo_table "Tabela local
                             CHANGING t_table = t_out ).

      lo_table->get_functions( )->set_all( abap_true ). "Ativar met codes

*Campos que serão ocultados da t_out de acordo com RADIOBUTTON selecionado:
IF rb_anali = 'X'. "2
      lo_table->get_columns( )->get_column( 'NETWR_VBAK' )->set_visible( abap_false ). "Ocultar campos da t_out
      lo_table->get_columns( )->get_column( 'NFTOT' )->set_visible( abap_false ).
ELSE. "1
      lo_table->get_columns( )->get_column( 'POSNR' )->set_visible( abap_false ).
      lo_table->get_columns( )->get_column( 'MATNR' )->set_visible( abap_false ).
      lo_table->get_columns( )->get_column( 'ARKTX' )->set_visible( abap_false ).
      lo_table->get_columns( )->get_column( 'NETWR_VBAP' )->set_visible( abap_false ).
      lo_table->get_columns( )->get_column( 'NETWR_J_1BNFLIN' )->set_visible( abap_false ).
ENDIF.



      CREATE OBJECT lo_header. "É necessário que criemos o objeto header

      lo_header->create_header_information( row = 1 column = 1 text = 'Relatório ALV' ). "Texto grande do header
      lo_header->add_row( ).


      lo_table->get_display_settings( )->set_striped_pattern( abap_true ).

      lo_table->set_top_of_list( lo_header ).

      lo_table->display( ) . "O dispay é fundamental para a exibição do ALV

    CATCH cx_salv_msg
          cx_root.

      MESSAGE s398(00) WITH 'Erro ao exibir tabela' DISPLAY LIKE 'E'.

  ENDTRY.

ENDFORM.
