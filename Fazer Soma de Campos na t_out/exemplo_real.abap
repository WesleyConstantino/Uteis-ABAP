*----------------------------------------------------------------------*
*                         TREINAMENTO                                  *
*----------------------------------------------------------------------*
* Autor....: Wesley Constantino dos Santos                             *
* Data.....: 05.01.2023                                                *
* Módulo...: TR                                                        *
* Descrição: Testes                                                    *
*----------------------------------------------------------------------*
*                    Histórico das Alterações                          *
*----------------------------------------------------------------------*
* DATA      | AUTOR             | Request    | DESCRIÇÃO               *
*----------------------------------------------------------------------*
*           |                   |            |                         *
*----------------------------------------------------------------------*
REPORT ztrrwes_pp7468.

*&---------------------------------------------------------------------*
*                                TABLES                                *
*&---------------------------------------------------------------------*
TABLES: vbap,
        vbak,
        kna1,
        vbrp,
        j_1bnfdoc,
        j_1bnflin,
        vbrk.

*&---------------------------------------------------------------------*
*                                 TYPES                                *
*&---------------------------------------------------------------------*
TYPES: BEGIN OF ty_vbak,
         vbeln TYPE vbak-vbeln,
         erdat TYPE vbak-erdat,
         auart TYPE vbak-auart,
         vkorg TYPE vbak-vkorg,
         vtweg TYPE vbak-vtweg,
         spart TYPE vbak-spart,
         vkbur TYPE vbak-vkbur,
         waerk TYPE vbak-waerk,
         kunnr TYPE vbak-kunnr,
         bstnk TYPE vbak-bstnk,
         lifsk TYPE vbak-lifsk,
         knumv TYPE vbak-knumv,
         netwr TYPE vbak-netwr,
       END OF ty_vbak,

       BEGIN OF ty_vbap,
         vbeln TYPE vbap-vbeln,
         aufnr TYPE vbap-aufnr,
         werks TYPE vbap-werks,
         lgort TYPE vbap-lgort,
         netwr TYPE vbap-netwr,
         posnr TYPE vbap-posnr,
         matnr TYPE vbap-matnr,
         arktx TYPE vbap-arktx,
       END OF ty_vbap,

       BEGIN OF ty_vbrp,
         aubel         TYPE vbrp-aubel,
         vgbel         TYPE vbrp-vgbel,
         vbeln         TYPE vbrp-vbeln,
         vbeln_aux(35) TYPE c,
       END OF ty_vbrp,

       BEGIN OF ty_kna1,
         kunnr TYPE kna1-kunnr,
         name1 TYPE kna1-name1,
         txjcd TYPE kna1-txjcd,
         ort01 TYPE kna1-ort01,
         pstlz TYPE kna1-pstlz,
         regio TYPE kna1-regio,
         stras TYPE kna1-stras,
         ort02 TYPE kna1-ort02,
         stcd1 TYPE kna1-stcd1,
         stcd2 TYPE kna1-stcd2,
         stcd3 TYPE kna1-stcd3,
       END OF ty_kna1,

       BEGIN OF ty_j_1bnfdoc,
         docnum   TYPE j_1bnfdoc-docnum,
         nfenum   TYPE j_1bnfdoc-nfenum,
         nftot    TYPE j_1bnfdoc-nftot,
         authdate TYPE j_1bnfdoc-authdate,
       END OF ty_j_1bnfdoc,

       BEGIN OF ty_j_1bnflin,
         refkey TYPE j_1bnflin-refkey,
         docnum TYPE j_1bnflin-docnum,
         netwr  TYPE j_1bnflin-netwr,
       END OF ty_j_1bnflin,

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
         soma_netwr      TYPE vbap-netwr, "VBAK-VBELN = VBAP-VBELN somar VBAP-NETWR de todos os itens encontrados "1
         soma_kbetr      TYPE konv-kbetr, "de cada item (KONV-KPOSN), sendo KONV-KSCHL = #VPRS#. Onde (VBAK-NUMV = KONV-KNUMV) "2
         lifsk           TYPE vbak-lifsk,
         vgbel           TYPE vbrp-vgbel,
         vbeln2          TYPE vbrp-vbeln,
         nfenum          TYPE j_1bnfdoc-nfenum,
         docnum          TYPE j_1bnflin-docnum,
         nftot           TYPE j_1bnfdoc-nftot,
         netwr_j_1bnflin TYPE j_1bnflin-netwr,
         authdate        TYPE j_1bnfdoc-authdate,
       END OF ty_out,

       BEGIN OF ty_vbrk,
         vbeln TYPE vbrk-vbeln,
         sfakn TYPE vbrk-sfakn,
         fksto TYPE vbrk-fksto,
       END OF ty_vbrk,

       BEGIN OF ty_colect,
         vbeln TYPE vbap-vbeln,
         netwr TYPE vbak-netwr,
       END OF ty_colect,

       BEGIN OF ty_colect_2,
         kbetr TYPE konv-kbetr, "soma
         kposn TYPE konv-kposn, "de cada item
         knumv TYPE konv-knumv,
       END OF ty_colect_2,

       BEGIN OF ty_konv,
         kbetr TYPE konv-kbetr,
         kposn TYPE konv-kposn,
         knumv TYPE konv-knumv,
         kschl TYPE konv-kschl,  "= 'VPRS'
       END OF ty_konv.

*&---------------------------------------------------------------------*
*                        Tabelas Internas                              *
*&---------------------------------------------------------------------*
DATA: t_vbak      TYPE TABLE OF ty_vbak,
      t_vbap      TYPE TABLE OF ty_vbap,
      t_vbrp      TYPE TABLE OF ty_vbrp,
      t_kna1      TYPE TABLE OF ty_kna1,
      t_j_1bnfdoc TYPE TABLE OF ty_j_1bnfdoc,
      t_j_1bnflin TYPE TABLE OF ty_j_1bnflin,
      t_out       TYPE TABLE OF ty_out,
      t_vbrk      TYPE TABLE OF ty_vbrk,
      t_colect    TYPE TABLE OF ty_colect,
      t_colect_2  TYPE TABLE OF ty_colect_2,
      t_konv      TYPE TABLE OF ty_konv.

*&---------------------------------------------------------------------*
*                            Workareas                                 *
*&---------------------------------------------------------------------*
DATA: wa_vbak      LIKE LINE OF t_vbak,
      wa_vbap      LIKE LINE OF t_vbap,
      wa_vbrp      LIKE LINE OF t_vbrp,
      wa_kna1      LIKE LINE OF t_kna1,
      wa_j_1bnfdoc LIKE LINE OF t_j_1bnfdoc,
      wa_j_1bnflin LIKE LINE OF t_j_1bnflin,
      wa_out       LIKE LINE OF t_out,
      wa_vbrk      LIKE LINE OF t_vbrk,
      wa_colect    LIKE LINE OF t_colect,
      wa_colect_2  LIKE LINE OF t_colect_2,
      wa_konv      LIKE LINE OF  t_konv.

*&---------------------------------------------------------------------*
*                              Variãveis                               *
*&---------------------------------------------------------------------*
*Para os campos da tela de seleção
DATA: v_aufnr      TYPE vbap-aufnr,
      v_vbak_vbeln TYPE vbak-vbeln,
      v_erdat      TYPE vbak-erdat,
      v_auart      TYPE vbak-auart,
      v_werks      TYPE vbap-werks,
      v_lgort      TYPE vbap-lgort,
      v_vkorg      TYPE vbak-vkorg,
      v_vtweg      TYPE vbak-vtweg,
      v_spart      TYPE vbak-spart,
      v_vkbur      TYPE vbak-vkbur,
      v_kunnr      TYPE vbak-kunnr,
      v_bstnk      TYPE vbak-bstnk,
      v_stcd1      TYPE kna1-stcd1,
      v_stcd2      TYPE kna1-stcd2,
      v_vgbel      TYPE vbrp-vgbel,
      v_vbrp_vbeln TYPE vbrp-vbeln,
      v_nfenum     TYPE j_1bnfdoc-nfenum, "9 Dígitos
      v_docnum     TYPE j_1bnflin-docnum.

*&---------------------------------------------------------------------*
*                         Tela de seleção                              *
*&---------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK b0 WITH FRAME TITLE text-000.
*Radio Buttons
PARAMETERS: rb_sinte RADIOBUTTON GROUP g1 DEFAULT 'X' USER-COMMAND cmd,
            rb_anali RADIOBUTTON GROUP g1.
SELECTION-SCREEN END OF BLOCK b0.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-001.
SELECT-OPTIONS: s_aufnr  FOR v_aufnr,
               s_vbeln1 FOR v_vbak_vbeln,
               s_erdat  FOR v_erdat OBLIGATORY,
               s_auart  FOR v_auart,
               s_werks  FOR v_werks,
               s_lgort  FOR v_lgort,
               s_vkorg  FOR v_vkorg,
               s_vtweg  FOR v_vtweg,
               s_spart  FOR v_spart,
               s_vkbur  FOR v_vkbur,
               s_kunnr  FOR v_kunnr,
               s_bstnk  FOR v_bstnk,
               s_stcd1  FOR v_stcd1,
               s_stcd2  FOR v_stcd2,
               s_vgbel  FOR v_vgbel,
               s_vbeln2 FOR v_vbrp_vbeln,
               s_nfenum FOR v_nfenum,  "9 Dígitos
               s_docnum FOR v_docnum.
*Check Boxes
PARAMETERS:
  p_bloque AS CHECKBOX DEFAULT 'X',
  p_desblo AS CHECKBOX DEFAULT 'X'.
SELECTION-SCREEN END OF BLOCK b1.

*Início da execusão
START-OF-SELECTION.
  IF rb_sinte  = 'X'.
    PERFORM: zf_select_sintetico,
             zf_monta_t_out_sintetico,
             zf_exibe_alv_poo.
  ELSE.
    PERFORM: zf_select_analitico,
             zf_monta_t_out_analitico,
             zf_exibe_alv_poo.
  ENDIF.


*&---------------------------------------------------------------------*
*&      Form  ZF_SELECT_SINTETICO
*&---------------------------------------------------------------------*
FORM zf_select_sintetico.

  SELECT vbeln
         erdat
         auart
         vkorg
         vtweg
         spart
         vkbur
         waerk
         kunnr
         bstnk
         lifsk
         knumv
         netwr
    FROM vbak
    INTO TABLE t_vbak
    WHERE vbeln IN s_vbeln1 AND
          erdat IN s_erdat AND
          auart IN s_auart AND
          vkorg IN s_vkorg AND
          vtweg IN s_vtweg AND
          spart IN s_spart AND
          vkbur IN s_vkbur AND
          kunnr IN s_kunnr AND
          bstnk IN s_bstnk.
  " lifsk = p_bloque AND     "VBAK-LIFSK = Ordem de venda bloqueada? informado na tela de seleção
  " lifsk = p_desblo.

  "Condional para tratar os checkboxes:
  IF p_bloque = 'X' AND p_desblo = ''.
    DELETE t_vbak WHERE lifsk IS NOT INITIAL.
  ELSEIF p_bloque = ' ' AND p_desblo = 'X'.
    DELETE t_vbak WHERE lifsk IS INITIAL.
  ENDIF.

* Delete para ganho de performance no meu SELECT
  DELETE t_vbak WHERE ( auart <> 'ZA01' )
                  AND ( auart <> 'ZMCX' ).

  IF t_vbak IS NOT INITIAL.

    SELECT  vbeln
            aufnr
            werks
            lgort
            netwr
            posnr
            matnr
            arktx
      FROM vbap
      INTO TABLE t_vbap
      FOR ALL ENTRIES IN t_vbak
      WHERE vbeln = t_vbak-vbeln AND
            aufnr IN s_aufnr AND
            "aufnr <> '' AND
            werks IN s_werks AND
            lgort IN s_lgort.

* Delete para ganho de performance no meu SELECT
    DELETE t_vbap WHERE aufnr = ''.

    SELECT aubel
           vgbel
           vbeln
           vbeln "Repetir o vbeln para alimentar o campo aux
      FROM vbrp
      INTO TABLE t_vbrp
      FOR ALL ENTRIES IN t_vbak
      WHERE aubel = t_vbak-vbeln AND
            vgbel IN s_vgbel AND
            vbeln IN s_vbeln2.

    SELECT vbeln
           sfakn
           fksto
      FROM vbrk
      INTO TABLE t_vbrk
      FOR ALL ENTRIES IN t_vbrp
      WHERE vbeln = t_vbrp-vbeln.
    " sfakn = ' ' AND "Performance   "Posso fazer assim, mas fiz com o DELETE  a baixo para ganho de performance
    " fksto = ' '.

* delete para ganho de performance no meu select
    DELETE t_vbrk WHERE ( sfakn <> '' )
                   AND ( fksto <> '' ).

    IF t_vbrk IS NOT INITIAL.

      SELECT kunnr
             name1
             txjcd
             ort01
             pstlz
             regio
             stras
             ort02
             stcd1
             stcd2
             stcd3
        FROM kna1
        INTO TABLE t_kna1
        FOR ALL ENTRIES IN t_vbak
        WHERE kunnr = t_vbak-kunnr AND
              stcd1 IN s_stcd1 AND
              stcd2 IN s_stcd2.
    ENDIF.

    SELECT refkey
           docnum
           netwr
      FROM j_1bnflin
      INTO TABLE t_j_1bnflin
      FOR ALL ENTRIES IN t_vbrp
      WHERE refkey = t_vbrp-vbeln_aux AND
            docnum IN s_docnum.

    SELECT docnum
           nfenum
           nftot
           authdate
      FROM j_1bnfdoc
      INTO TABLE t_j_1bnfdoc
      FOR ALL ENTRIES IN t_j_1bnflin
      WHERE docnum = t_j_1bnflin-docnum AND
            nfenum IN s_nfenum.

  ELSE.
    MESSAGE s398(00) WITH 'Não há registros!' DISPLAY LIKE 'E'.
    STOP.
  ENDIF.


ENDFORM.


*&---------------------------------------------------------------------*
*&      Form  ZF_SELECT_ANALITICO
*&---------------------------------------------------------------------*
FORM  zf_select_analitico.

  SELECT vbeln
         erdat
         auart
         vkorg
         vtweg
         spart
         vkbur
         waerk
         kunnr
         bstnk
         lifsk
         knumv
         netwr
    FROM vbak
    INTO TABLE t_vbak
    WHERE vbeln IN s_vbeln1 AND
          erdat IN s_erdat AND
          auart IN s_auart AND
          vkorg IN s_vkorg AND
          vtweg IN s_vtweg AND
          spart IN s_spart AND
          vkbur IN s_vkbur AND
          kunnr IN s_kunnr AND
          bstnk IN s_bstnk.

  "Condional para tratar os checkboxes:
  IF p_bloque = 'X' AND p_desblo = ''.
    DELETE t_vbak WHERE lifsk IS NOT INITIAL.
  ELSEIF p_bloque = ' ' AND p_desblo = 'X'.
    DELETE t_vbak WHERE lifsk IS INITIAL.
  ENDIF.

  IF t_vbak IS NOT INITIAL.

    SELECT vbeln
           aufnr
           werks
           lgort
           netwr
           posnr
           matnr
           arktx
      FROM vbap
      INTO TABLE t_vbap
      FOR ALL ENTRIES IN t_vbak
      WHERE vbeln = t_vbak-vbeln AND
            aufnr IN s_aufnr AND
            werks IN s_werks AND
            lgort IN s_lgort.

* Delete para ganho de performance no meu SELECT
    DELETE t_vbap WHERE aufnr = ''.

    SELECT kunnr
           name1
           txjcd
           ort01
           pstlz
           regio
           stras
           ort02
           stcd1
           stcd2
           stcd3
      FROM kna1
      INTO TABLE t_kna1
      FOR ALL ENTRIES IN t_vbak
      WHERE kunnr = t_vbak-kunnr AND
            stcd1 IN s_stcd1 AND
            stcd2 IN s_stcd2.

    SELECT aubel
           vgbel
           vbeln
           vbeln "Passando dados para o campo aux em vez de fazer o loop comentado abaixo
      FROM vbrp
      INTO TABLE t_vbrp
      FOR ALL ENTRIES IN t_vbak
      WHERE aubel = t_vbak-vbeln AND
            vgbel IN s_vgbel AND
            vbeln IN s_vbeln2.

    "LOOP AT t_vbrp INTO wa_vbrp.  "Loop para fazer a modificação no meu campo auxiliar
    " wa_vbrp-vbeln_aux = wa_vbrp-vbeln.
    "MODIFY t_vbrp FROM wa_vbrp TRANSPORTING vbeln_aux.
    "ENDLOOP.

    SELECT vbeln
           sfakn
           fksto
      FROM vbrk
     INTO TABLE t_vbrk
     FOR ALL ENTRIES IN t_vbrp
     WHERE vbeln = t_vbrp-vbeln.

    DELETE t_vbrk WHERE ( sfakn <> '' )
                   AND ( fksto <> '' ).


    SELECT refkey
           docnum
           netwr
      FROM j_1bnflin
      INTO TABLE t_j_1bnflin
      FOR ALL ENTRIES IN t_vbrp
      WHERE refkey = t_vbrp-vbeln_aux AND """aux
            docnum IN s_docnum.

    SELECT docnum
           nfenum
           nftot
           authdate
      FROM j_1bnfdoc
      INTO TABLE t_j_1bnfdoc
      FOR ALL ENTRIES IN t_j_1bnflin
      WHERE docnum = t_j_1bnflin-docnum AND
            nfenum IN s_nfenum.

    SELECT kbetr
           kposn
           knumv
           kschl
      FROM konv
      INTO TABLE t_konv
       FOR ALL ENTRIES IN t_vbak
       WHERE knumv = t_vbak-knumv AND
             kschl = 'VPRS'.

  ELSE.
    MESSAGE s398(00) WITH 'Não há registros!' DISPLAY LIKE 'E'.
    STOP.
  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  ZF_exibe_alv_poo
*&---------------------------------------------------------------------*
FORM zf_exibe_alv_poo.

  DATA: lo_table   TYPE REF TO cl_salv_table,  "Acessar a classe "cl_salv_table"
        lo_header  TYPE REF TO cl_salv_form_layout_grid,   "Para criação do header
        lo_columns TYPE REF TO cl_salv_columns_table.  "Ajustar tamanho dos subtítulos

  TRY.
      cl_salv_table=>factory( IMPORTING r_salv_table = lo_table "Tabela local
                             CHANGING t_table = t_out ).

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

*&---------------------------------------------------------------------*
*&      Form  zf_monta_t_out_sintetico
*&---------------------------------------------------------------------*
FORM zf_monta_t_out_sintetico .

  PERFORM z_soma_sintetico.

  LOOP AT t_vbak INTO wa_vbak. "Loop na tabela mestre #Principal #Do primeiro SELECT
    "No READ a chave deve ser a mesma da condicional do SELECT

    wa_out-vbeln = wa_vbak-vbeln.
    wa_out-posnr = wa_vbap-posnr.
    wa_out-erdat = wa_vbak-erdat.
    wa_out-auart = wa_vbak-auart.
    wa_out-vkorg = wa_vbak-vkorg.
    wa_out-vtweg = wa_vbak-vtweg.
    wa_out-spart = wa_vbak-spart.
    wa_out-vkbur = wa_vbak-vkbur.
    wa_out-netwr_vbak = wa_vbak-netwr.
    wa_out-waerk = wa_vbak-waerk.
    wa_out-kunnr = wa_vbak-kunnr.
    wa_out-bstnk = wa_vbak-bstnk.
    wa_out-lifsk = wa_vbak-lifsk.



    READ TABLE t_vbap INTO wa_vbap WITH KEY vbeln = wa_vbak-vbeln.

    IF sy-subrc IS INITIAL.
      wa_out-aufnr = wa_vbap-aufnr.
      wa_out-posnr = wa_vbap-posnr.
      wa_out-matnr = wa_vbap-matnr.
      wa_out-arktx = wa_vbap-arktx.
      wa_out-werks = wa_vbap-werks.
      wa_out-lgort = wa_vbap-lgort.
      wa_out-netwr_vbap = wa_vbap-netwr.

      READ TABLE t_colect INTO wa_colect WITH KEY vbeln = wa_vbak-vbeln.
      IF sy-subrc IS INITIAL.
        wa_out-soma_netwr = wa_colect-netwr.
      ENDIF.
    ENDIF.


    READ TABLE t_vbrp INTO wa_vbrp WITH KEY aubel = wa_vbak-vbeln.

    IF sy-subrc IS INITIAL.
      wa_out-vgbel = wa_vbrp-vgbel.
      wa_out-vbeln2 = wa_vbrp-vbeln.

      READ TABLE t_j_1bnflin INTO wa_j_1bnflin WITH KEY refkey = wa_vbrp-vbeln_aux.
      IF sy-subrc IS INITIAL.
        wa_out-nfenum = wa_j_1bnfdoc-nfenum.
        wa_out-nftot = wa_j_1bnfdoc-nftot.
        wa_out-authdate = wa_j_1bnfdoc-authdate.

        READ TABLE t_j_1bnfdoc INTO wa_j_1bnfdoc WITH KEY docnum = wa_j_1bnflin-docnum.
        IF sy-subrc IS INITIAL.
          wa_out-docnum = wa_j_1bnflin-docnum.
          wa_out-netwr_j_1bnflin = wa_j_1bnflin-netwr.
        ENDIF.

      ENDIF.

    ENDIF.

    READ TABLE t_kna1 INTO wa_kna1 WITH KEY kunnr = wa_vbak-kunnr.
    IF sy-subrc IS INITIAL.
      wa_out-name1 = wa_kna1-name1.
      wa_out-txjcd = wa_kna1-txjcd.
      wa_out-ort01 = wa_kna1-ort01.
      wa_out-pstlz = wa_kna1-pstlz.
      wa_out-regio = wa_kna1-regio.
      wa_out-stras = wa_kna1-stras.
      wa_out-ort02 = wa_kna1-ort02.
      wa_out-stcd1 = wa_kna1-stcd1.
      wa_out-stcd2 = wa_kna1-stcd2.
      wa_out-stcd3 = wa_kna1-stcd3.
      "WRITE wa_kna1-stcd1 USING EDIT MASK '__.___.___/____-__' TO wa_out-stcd1.  "Máscara para o campo do cnpj
    ENDIF.

    APPEND wa_out TO t_out.
    CLEAR: wa_out,
           wa_vbak,
           wa_vbap,
           wa_vbrp,
           wa_kna1,
           wa_j_1bnfdoc,
           wa_j_1bnflin,
           wa_colect,
           wa_colect_2.

  ENDLOOP.

ENDFORM.


*&---------------------------------------------------------------------*
*&      Form  ZF_MONTA_T_OUT_ANALITICO
*&---------------------------------------------------------------------*
FORM zf_monta_t_out_analitico .
  PERFORM z_soma_sintetico_analitico.

  LOOP AT t_vbap INTO wa_vbap.

    " READ TABLE t_vbap INTO wa_vbap WITH KEY vbeln = wa_vbak-vbeln.  "Problema aqui, os dados estão em branco
    " IF sy-subrc IS INITIAL.
    wa_out-aufnr = wa_vbap-aufnr.
    wa_out-posnr = wa_vbap-posnr.
    wa_out-matnr = wa_vbap-matnr.
    wa_out-arktx = wa_vbap-arktx.
    wa_out-werks = wa_vbap-werks.
    wa_out-lgort = wa_vbap-lgort.
    wa_out-netwr_vbap = wa_vbap-netwr.
    " ENDIF.

    READ TABLE t_vbak INTO wa_vbak WITH KEY vbeln = wa_vbap-vbeln. """""""""""""""""""""""""""""""""""""""""""""""'
    IF sy-subrc IS INITIAL.
      wa_out-vbeln = wa_vbak-vbeln.
      wa_out-posnr = wa_vbap-posnr.
      wa_out-erdat = wa_vbak-erdat.
      wa_out-auart = wa_vbak-auart.
      wa_out-vkorg = wa_vbak-vkorg.
      wa_out-vtweg = wa_vbak-vtweg.
      wa_out-spart = wa_vbak-spart.
      wa_out-vkbur = wa_vbak-vkbur.
      wa_out-netwr_vbak = wa_vbak-netwr.
      wa_out-waerk = wa_vbak-waerk.
      wa_out-kunnr = wa_vbak-kunnr.
      wa_out-bstnk = wa_vbak-bstnk.
      wa_out-lifsk = wa_vbak-lifsk.
    ENDIF.

    READ TABLE t_kna1 INTO wa_kna1 WITH KEY kunnr = wa_vbak-kunnr.
    IF sy-subrc IS INITIAL.
      wa_out-name1 = wa_kna1-name1.
      wa_out-txjcd = wa_kna1-txjcd.
      wa_out-ort01 = wa_kna1-ort01.
      wa_out-pstlz = wa_kna1-pstlz.
      wa_out-regio = wa_kna1-regio.
      wa_out-stras = wa_kna1-stras.
      wa_out-ort02 = wa_kna1-ort02.
      wa_out-stcd1 = wa_kna1-stcd1.
      wa_out-stcd2 = wa_kna1-stcd2.
      wa_out-stcd3 = wa_kna1-stcd3.
    ENDIF.

    READ TABLE t_vbrp INTO wa_vbrp WITH KEY aubel = wa_vbak-vbeln.
    IF sy-subrc IS INITIAL.
      wa_out-vgbel = wa_vbrp-vgbel.
      wa_out-vbeln2 = wa_vbrp-vbeln.
    ENDIF.

    READ TABLE t_vbrk INTO wa_vbrk WITH KEY vbeln = wa_vbrp-vbeln.
    IF sy-subrc IS INITIAL.

    ENDIF.

    READ TABLE t_j_1bnflin INTO wa_j_1bnflin WITH KEY refkey = wa_vbrp-vbeln_aux.
    IF sy-subrc IS INITIAL.
      wa_out-nfenum = wa_j_1bnfdoc-nfenum.
      wa_out-nftot = wa_j_1bnfdoc-nftot.
      wa_out-authdate = wa_j_1bnfdoc-authdate.

      READ TABLE t_j_1bnfdoc INTO wa_j_1bnfdoc WITH KEY docnum = wa_j_1bnflin-docnum.
      IF sy-subrc IS INITIAL.
        wa_out-docnum = wa_j_1bnflin-docnum.
        wa_out-netwr_j_1bnflin = wa_j_1bnflin-netwr.
      ENDIF.

      READ TABLE t_colect_2 INTO wa_colect_2 WITH KEY knumv = wa_vbak-knumv.
      IF sy-subrc IS INITIAL.
        wa_out-soma_kbetr = wa_colect_2-kbetr.
      ENDIF.

    ENDIF.
    APPEND wa_out TO t_out.
    CLEAR: wa_out,
           wa_vbak,
           wa_vbap,
           wa_vbrp,
           wa_kna1,
           wa_j_1bnfdoc,
           wa_j_1bnflin,
           wa_colect_2.
  ENDLOOP.
ENDFORM.


*&---------------------------------------------------------------------*
*&      Form  z_soma_sintetico
*&---------------------------------------------------------------------*
FORM z_soma_sintetico .

  LOOP AT t_vbap INTO wa_vbap.
    wa_colect-vbeln = wa_vbap-vbeln.
    wa_colect-netwr = wa_vbap-netwr.

    COLLECT wa_colect INTO t_colect.
    CLEAR wa_colect.
  ENDLOOP.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  z_soma_sintetico_analitico
*&---------------------------------------------------------------------*
FORM z_soma_sintetico_analitico .

  LOOP AT t_konv INTO wa_konv.
    wa_colect_2-kbetr = wa_konv-kbetr.
    wa_colect_2-kposn = wa_konv-kposn.
    wa_colect_2-knumv = wa_konv-knumv.

    COLLECT wa_colect_2 INTO t_colect_2.
    CLEAR wa_colect_2.
  ENDLOOP.

ENDFORM.
