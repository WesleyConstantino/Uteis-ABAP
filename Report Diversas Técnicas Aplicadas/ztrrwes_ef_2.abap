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
REPORT ztrrwes_ef_2.

*&---------------------------------------------------------------------*
*                                TABLES                                *
*&---------------------------------------------------------------------*
TABLES: vbak,
        vbap.

*&---------------------------------------------------------------------*
*                                 TYPES                                *
*&---------------------------------------------------------------------*
TYPES:
*------* t001w
  BEGIN OF ty_t001w,
    regio TYPE t001w-regio,
    werks TYPE t001w-werks,
  END OF ty_t001w,

*------* ztcrpin_hist
  BEGIN OF ty_ztcrpin_hist,
    mblnr   TYPE ztcrpin_hist-mblnr,
    zeile   TYPE ztcrpin_hist-zeile,
    lotechk TYPE ztcrpin_hist-lotechk,
  END OF ty_ztcrpin_hist,

*------* ztcrblister_hist
  BEGIN OF ty_ztcrblister_hist,
    mblnr TYPE ztcrblister_hist-mblnr,
    zeile TYPE ztcrblister_hist-zeile,
    lotei TYPE ztcrblister_hist-lotei,
    lotef TYPE ztcrblister_hist-lotef,
  END OF ty_ztcrblister_hist,

*------* objk
  BEGIN OF ty_objk,
    obknr TYPE objk-obknr,
    sernr TYPE objk-sernr,
  END OF ty_objk,

*------* ser01
  BEGIN OF ty_ser01,
    lief_nr TYPE ser01-lief_nr,
    posnr   TYPE ser01-posnr,
    obknr   TYPE ser01-obknr,
  END OF ty_ser01,

*------* j_1bnfstx
  BEGIN OF ty_j_1bnfstx,
    docnum TYPE j_1bnfstx-docnum,
    itmnum TYPE j_1bnfstx-itmnum,
    taxval TYPE j_1bnfstx-taxval,
    taxgrp TYPE j_1bnfstx-taxgrp,
    taxtyp TYPE j_1bnfstx-taxtyp,
  END OF ty_j_1bnfstx,

*------* mseg
  BEGIN OF ty_mseg,
    matnr    TYPE mseg-matnr,
    werks    TYPE mseg-werks,
    lgort    TYPE mseg-lgort,
    bwart    TYPE mseg-bwart,
    vbeln_im TYPE mseg-vbeln_im,
    dmbtr    TYPE mseg-dmbtr,
    vbelp_im TYPE mseg-vbelp_im,
  END OF ty_mseg,

*------* lips
  BEGIN OF ty_lips,
    vgbel TYPE lips-vgbel,
    vgpos TYPE lips-vgpos,
    matnr TYPE lips-matnr,
    werks TYPE lips-werks,
    lgort TYPE lips-lgort,
    bwart TYPE lips-bwart,
    vbeln TYPE lips-vbeln,
    posnr TYPE lips-posnr,
  END OF ty_lips,

*------* kna1
  BEGIN OF ty_kna1,
    regio TYPE kna1-regio,
    kunnr TYPE kna1-kunnr,
    name1 TYPE kna1-name1,
  END OF ty_kna1,

*------* vbak
  BEGIN OF ty_vbak,
    vkorg      TYPE vbak-vkorg,
    vtweg      TYPE vbak-vtweg,
    spart      TYPE vbak-spart,
    erdat      TYPE vbak-erdat,
    auart      TYPE vbak-auart,
    vbeln      TYPE vbak-vbeln,
    ernam      TYPE vbak-ernam,
    kunnr      TYPE vbak-kunnr,
    ztipo_oper TYPE vbak-ztipo_oper,
  END OF ty_vbak,

*------* bkpf
  BEGIN OF ty_bkpf,
    awkey TYPE bkpf-awkey,
    belnr TYPE bkpf-belnr,
  END OF ty_bkpf,

*------* j_1bnfdoc
  BEGIN OF ty_j_1bnfdoc,
    docnum TYPE j_1bnfdoc-docnum,
    code   TYPE j_1bnfdoc-code,
    nftot  TYPE j_1bnfdoc-nftot,
    vdesc  TYPE j_1bnfdoc-vdesc,
    nfenum TYPE j_1bnfdoc-nfenum,
  END OF ty_j_1bnfdoc,

*------* zsdt161
  BEGIN OF ty_zsdt161,
    werks TYPE zsdt161-werks,
    vbeln TYPE zsdt161-vbeln,
    atend TYPE zsdt161-atend,
  END OF ty_zsdt161,

*------* vbap
  BEGIN OF ty_vbap,
    vbeln  TYPE vbap-vbeln,
    posnr  TYPE vbap-posnr,
    vrkme  TYPE vbap-vrkme,
    matnr  TYPE vbap-matnr,
    arktx  TYPE vbap-arktx,
    werks  TYPE vbap-werks,
    netwr  TYPE vbap-netwr,
    mwsbp  TYPE vbap-mwsbp,
    kwmeng TYPE vbap-kwmeng,
  END OF ty_vbap,

*------* vbrp
  BEGIN OF ty_vbrp,
    vbeln            TYPE vbrp-vbeln,
    aubel            TYPE vbrp-aubel,
    aupos            TYPE vbrp-aupos,
    vgbel            TYPE vbrp-vgbel,
    vgpos            TYPE vbrp-vgpos,
    vbeln_aux_refkey TYPE j_1bnflin-refkey,
    vbeln_aux_awkey  TYPE bkpf-awkey,
    posnr            TYPE vbrp-posnr,
    erdat            TYPE vbrp-erdat,
    erzet            TYPE vbrp-erzet,
  END OF ty_vbrp,

*------* j_1bnflin
  BEGIN OF ty_j_1bnflin,
    cfop   TYPE j_1bnflin-cfop,
    nbm    TYPE j_1bnflin-nbm,
    matorg TYPE j_1bnflin-matorg,
    taxsit TYPE j_1bnflin-taxsit,
    refkey TYPE j_1bnflin-refkey,
    refitm TYPE j_1bnflin-refitm,
    docnum TYPE j_1bnflin-docnum,
    itmnum TYPE j_1bnflin-itmnum,
    netwr  TYPE j_1bnflin-netwr,
    menge  TYPE j_1bnflin-menge,
    netdis TYPE  j_1bnflin-netdis,
  END OF ty_j_1bnflin,

*------* zmmt101
  BEGIN OF ty_zmmt101,
    belnr         TYPE zmmt101-belnr,
    vbeln         TYPE zmmt101-vbeln,
    posnr         TYPE zmmt101-posnr,
    val_icms_prop TYPE zmmt101-val_icms_prop,
    icms_st       TYPE zmmt101-icms_st,
  END OF ty_zmmt101,

*------* t_out
  BEGIN OF ty_out,
    "Sintético:
    ztipo_oper_sint            TYPE  vbak-ztipo_oper,      "Novo Campo da VBAK
    regio_t001w_sint           TYPE t001w-regio,
    werks_sint                 TYPE t001w-werks,
    regio_kna1_sint            TYPE kna1-regio,
    zsdt161_werks              TYPE zsdt161-werks,         "Primeiro registro ZSDT161-WERKS
    kunnr_sint                 TYPE kna1-kunnr,
    name1_sint                 TYPE kna1-name1,
    vkorg_sint                 TYPE vbak-vkorg,
    vtweg_sint                 TYPE vbak-vtweg,
    spart_sint                 TYPE vbak-spart,
    erdat_sint                 TYPE vbak-erdat,
    auart_sint                 TYPE vbak-auart,
    vbeln_sint                 TYPE vbak-vbeln,
    vbeln_lips                 TYPE lips-vbeln,             "Primeiro registro de LIPS-VBELN
    vbeln_vbrp                 TYPE vbrp-vbeln,             "Primeiro registro de VBRP-VBELN
    soma_mseg_dmbtr            TYPE mseg-dmbtr,             "Somatório MSEG-DMBTR
    belnr_sint                 TYPE bkpf-belnr,
    docnum_sint                TYPE j_1bnfdoc-docnum,
    soma_vbap_netwr_mwsbp      TYPE vbap-netwr,             "Somatório de todos VBAP-NETWR e VBAPMWSBP
    nfenum_sint                TYPE  j_1bnfdoc-nfenum,
    code_sint                  TYPE j_1bnfdoc-code,
    nftot_sint                 TYPE j_1bnfdoc-nftot,
    vdesc_sint                 TYPE j_1bnfdoc-vdesc,
    taxval_pis_sint            TYPE j_1bnfstx-taxval,        "Somatório J_1BNFSTX-TAXVAL, cujo TAXGRP = 'PIS'
    taxval_cofi_sint           TYPE j_1bnfstx-taxval,        "Somatório J_1BNFSTX-TAXVAL, cujo TAXGRP = 'COFI'
    taxval_icm_sint            TYPE j_1bnfstx-taxval,        "Somatório J_1BNFSTX-TAXVAL, cujo TAXTYP = 'ICM*'
    taxval_icst_sint           TYPE j_1bnfstx-taxval,        "Somatório J_1BNFSTX-TAXVAL, cujo TAXGRP = 'ICST'
    taxval_icap_sint           TYPE j_1bnfstx-taxval,        "Somatório J_1BNFSTX-TAXVAL, cujo TAXTYP = 'ICAP'
    taxval_icsp_sint           TYPE j_1bnfstx-taxval,        "Somatório J_1BNFSTX-TAXVAL, cujo TAXTYP = 'ICSP'
    belnr_zmmt101              TYPE zmmt101-belnr,           "Primeiro registro de ZMMT101-BELNR     *Dúvida
    soma_zmmt101_val_icms_prop TYPE zmmt101-val_icms_prop,   "Somatório ZMMT101-VAL_ICMS_PROP
    soma_zmmt101_icms_st       TYPE zmmt101-icms_st,         "Somatório ZMMT101-ICMS_ST

    "Analítico:
    ztipo_oper_anali           TYPE vbak-ztipo_oper,         "Novo Campo da VBAK
    regio_t001w_anali          TYPE t001w-regio,
    werks_t001w_anali          TYPE t001w-werks,
    regio_kna1_anali           TYPE kna1-regio,
    werks_zsdt161_anali        TYPE zsdt161-werks,
    kunnr_anali                TYPE kna1-kunnr,
    name1_anali                TYPE kna1-name1,
    vkorg_anali                TYPE vbak-vkorg,
    vtweg_anali                TYPE vbak-vtweg,
    spart_anali                TYPE vbak-spart,
    erdat_anali                TYPE vbak-erdat,
    auart_anali                TYPE vbak-auart,
    vbeln_vbap_anali           TYPE vbap-vbeln,
    posnr_anali                TYPE vbap-posnr,
    quantidade_anali           TYPE  i,                     "Se encontrar serial = 1, senão encontrar = VBAP-KWMENG
    vrkme_anali                TYPE vbap-vrkme,
    matnr_anali                TYPE vbap-matnr,
    arktx_anali                TYPE vbap-arktx,
    serial_anali               TYPE  string,                "Um dos 3 a seguir, sendo o primeiro que encontrar, na ordem: OBJK-SERNR, ZTCRBLISTER_HIST-LOTEI&# # #&LOTEF, ZTCRPIN_HIST-LOTECHK. Se não encontrar nada, deixar vazio
    vbeln_lips_anali           TYPE lips-vbeln,
    vbeln_vbrp_anali           TYPE vbrp-vbeln,
    preco                      TYPE  p DECIMALS 2,          "Se Quantidade <> 1 ;MSEG-DMBTR ; senão, MSEG-DMBTR / VBAP-KWMENG
    belnr_bkpf_anali           TYPE bkpf-belnr,
    docnum_anali               TYPE j_1bnfdoc-docnum,
    nfenum_anali               TYPE  j_1bnfdoc-nfenum,      "nfenum_anali        TYPE j_1bnfodc-nfenum,      #Compo Desconhecido
    code_anali                 TYPE j_1bnfdoc-code,
    cfop_anali                 TYPE j_1bnflin-cfop,
    nbm_anali                  TYPE j_1bnflin-nbm,
    matorg_anali               TYPE j_1bnflin-matorg,
    taxsit_anali               TYPE j_1bnflin-taxsit,
    vl_bruto                   TYPE  p DECIMALS 2,          "Se Quantidade <>1 ; (VBAP-NETWR + VBAP-MWSBP); senão, (VBAP-NETWR + VBAP-MWSBP)/VBAP-KWMENG
    vl_total                   TYPE  p,                     "Se Quantidade <>1 ; J_1BNFLIN-NETWR; senão; J_1BNFLIN- NETWR/J_1BNFLIN-MENGE
    vl_desconto                TYPE  p,                     "Se Quantidade <>1 ; J_1BNFLIN-NETDIS; senão; J_1BNFLIN-NETDIS/J_1BNFLIN-MENGE
    pis_anali                  TYPE  j_1bnfstx-taxval,      "Se Quantidade <>1 ; J_1BNFSTX-TAXVAL cujo TAXGRP = 'PIS';senão; J_1BNFSTX-TAXVAL cujo TAXGRP = 'PIS'/ J_1BNFLIN-MENGE
    confins_anali              TYPE  j_1bnfstx-taxval,      "Lógica igual acima para J_1BNFSTX-TAXVAL, cujo TAXGRP = 'COFI'
    icms_anali                 TYPE  j_1bnfstx-taxval,      "Lógica igual acima para J_1BNFSTX-TAXVAL, cujo TAXTYP = 'ICM*'
    icms_st_j_1bnfstx_anali    TYPE  j_1bnfstx-taxval,      "Lógica igual acima para J_1BNFSTX-TAXVAL, cujo TAXGRP = 'ICST'
    icms_di_anali              TYPE  j_1bnfstx-taxval,      "Lógica igual acima para J_1BNFSTX-TAXVAL, cujo TAXTYP = 'ICAP'
    fcp_anali                  TYPE  j_1bnfstx-taxval,      "Lógica igual acima para J_1BNFSTX-TAXVAL, cujo TAXTYP = 'ICSP'
    belnr_zmmt101_anali        TYPE zmmt101-belnr,
    val_icms_prop_anali        TYPE  zmmt101-val_icms_prop, "Se Quantidade <>1 ; ZMMT101-VAL_ICMS_PROP;senão; ZMMT101- VAL_ICMS_PROP / J_1BNFLIN-MENGE
    icms_st_zmmt101_anali      TYPE  zmmt101-icms_st,       "Se Quantidade <>1 ; ZMMT101-ICMS_ST;senão; ZMMT101-ICMS_ST/ J_1BNFLIN-MENGE
    vl_icms_entrada_anali      TYPE  p,
    vl_icms_st_entrada_anali   TYPE  p,
  END OF ty_out,

*------* Collects:

*------* Para o somatório de mseg-dmbtr
  BEGIN OF ty_collect_mseg,
    dmbtr    TYPE mseg-dmbtr,
    vbeln_im TYPE lips-vbeln,
  END OF ty_collect_mseg,

*------* Para o somatório de VBAP-NETWR e de VBAP-MWSBP
  BEGIN OF ty_collect_vbap,
    netwr TYPE vbap-netwr,
    mwsbp TYPE vbap-mwsbp,
    vbeln TYPE vbap-vbeln,
  END OF ty_collect_vbap,

*------* Para o somatório de ZMMT101-VAL_ICMS_PROP  e de ZMMT101-ICMS_ST
  BEGIN OF ty_collect_zmmt101,
    val_icms_prop TYPE zmmt101-val_icms_prop,
    vbeln         TYPE zmmt101-vbeln,
    icms_st       TYPE zmmt101-icms_st,
  END OF ty_collect_zmmt101.

*&---------------------------------------------------------------------*
*                        Tabelas Internas                              *
*&---------------------------------------------------------------------*
DATA: t_t001w            TYPE TABLE OF ty_t001w,
      t_ztcrpin_hist     TYPE TABLE OF ty_ztcrpin_hist,
      t_ztcrblister_hist TYPE TABLE OF ty_ztcrblister_hist,
      t_objk             TYPE TABLE OF ty_objk,
      t_ser01            TYPE TABLE OF ty_ser01,
      t_j_1bnfstx        TYPE TABLE OF ty_j_1bnfstx,
      t_mseg             TYPE TABLE OF ty_mseg,
      t_lips             TYPE TABLE OF ty_lips,
      t_kna1             TYPE TABLE OF ty_kna1,
      t_vbak             TYPE TABLE OF ty_vbak,
      t_bkpf             TYPE TABLE OF ty_bkpf,
      t_j_1bnfdoc        TYPE TABLE OF ty_j_1bnfdoc,
      t_zsdt161          TYPE TABLE OF ty_zsdt161,
      t_vbap             TYPE TABLE OF ty_vbap,
      t_vbrp             TYPE TABLE OF ty_vbrp,
      t_j_1bnflin        TYPE TABLE OF ty_j_1bnflin,
      t_zmmt101          TYPE TABLE OF ty_zmmt101,
      t_out              TYPE TABLE OF ty_out,
      t_collect_mseg     TYPE TABLE OF ty_collect_mseg,
      t_collect_vbap     TYPE TABLE OF ty_collect_vbap,
      t_collect_zmmt101  TYPE TABLE OF ty_collect_zmmt101.

*&---------------------------------------------------------------------*
*                            Workareas                                 *
*&---------------------------------------------------------------------*
DATA: wa_t001w            LIKE LINE OF t_t001w,
      wa_ztcrpin_hist     LIKE LINE OF t_ztcrpin_hist,
      wa_ztcrblister_hist LIKE LINE OF t_ztcrblister_hist,
      wa_objk             LIKE LINE OF t_objk,
      wa_ser01            LIKE LINE OF t_ser01,
      wa_j_1bnfstx        LIKE LINE OF t_j_1bnfstx,
      wa_mseg             LIKE LINE OF t_mseg,
      wa_lips             LIKE LINE OF t_lips,
      wa_kna1             LIKE LINE OF t_kna1,
      wa_vbak             LIKE LINE OF t_vbak,
      wa_bkpf             LIKE LINE OF t_bkpf,
      wa_j_1bnfdoc        LIKE LINE OF t_j_1bnfdoc,
      wa_zsdt161          LIKE LINE OF t_zsdt161,
      wa_vbap             LIKE LINE OF t_vbap,
      wa_vbrp             LIKE LINE OF t_vbrp,
      wa_j_1bnflin        LIKE LINE OF t_j_1bnflin,
      wa_zmmt101          LIKE LINE OF t_zmmt101,
      wa_out              LIKE LINE OF t_out,
      wa_collect_mseg     LIKE LINE OF t_collect_mseg,
      wa_collect_vbap     LIKE LINE OF t_collect_vbap,
      wa_collect_zmmt101  LIKE LINE OF t_collect_zmmt101.

*&---------------------------------------------------------------------*
*                              Variãveis                               *
*&---------------------------------------------------------------------*


*&---------------------------------------------------------------------*
*                         Tela de seleção                              *
*&---------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-000.
SELECTION-SCREEN BEGIN OF BLOCK b0 WITH FRAME TITLE text-001.
*Radio Buttons
PARAMETERS: rb_sinte RADIOBUTTON GROUP g1 DEFAULT 'X' USER-COMMAND cmd,
            rb_anali RADIOBUTTON GROUP g1.
SELECTION-SCREEN END OF BLOCK b0.

SELECT-OPTIONS: s_erdat FOR vbak-erdat OBLIGATORY,
                s_vbeln FOR vbak-vbeln,
                s_auart FOR vbak-auart,
                s_vkorg FOR vbak-vkorg,
                s_vtweg FOR vbak-vtweg,
                s_spart FOR vbak-spart,
                s_werks FOR vbap-werks,
                s_oper  FOR vbak-ztipo_oper.
SELECTION-SCREEN END OF BLOCK b1.

*Início da execusão
START-OF-SELECTION.
  IF rb_sinte  = 'X'.
    PERFORM: zf_select,
             zf_monta_t_out_sintetico,
             zf_show_alv_poo.
  ELSE.
    PERFORM: zf_select,
             zf_monta_t_out_analitico,
             zf_show_alv_poo.
  ENDIF.

*&---------------------------------------------------------------------*
*&      Form  ZF_SELECT
*&---------------------------------------------------------------------*
FORM zf_select.

*------* vbak
  SELECT vkorg
         vtweg
         spart
         erdat
         auart
         vbeln
         ernam
         kunnr
         ztipo_oper
  FROM vbak
  INTO TABLE t_vbak
  WHERE erdat IN s_erdat AND
        vbeln IN s_vbeln AND
        auart IN s_auart AND
        vkorg IN s_vkorg AND
        vtweg IN s_vtweg AND
        spart IN s_spart AND
        ztipo_oper IN s_oper .

  DELETE t_vbak WHERE ernam <> 'COMPRAS_RFC'.

  IF t_vbak IS NOT INITIAL.

*------* vbap
    SELECT vbeln
           posnr
           vrkme
           matnr
           arktx
           werks
           netwr
           mwsbp
           kwmeng
      FROM vbap
      INTO TABLE t_vbap
      FOR ALL ENTRIES IN t_vbak
      WHERE vbeln = t_vbak-vbeln AND
            werks IN s_werks.

    IF t_vbap IS NOT INITIAL.

*------* t001w
      SELECT regio
             werks
        FROM t001w
        INTO TABLE t_t001w
        FOR ALL ENTRIES IN t_vbap
        WHERE werks = t_vbap-werks.

*------* zsdt161
      SELECT werks
             vbeln
             atend
       FROM zsdt161
       INTO TABLE t_zsdt161
       FOR ALL ENTRIES IN t_vbap
       WHERE vbeln = t_vbap-vbeln AND
             atend = vbap-posnr.  "suprimindo um zero à direita e completando com zeros à esquerda até o total de caracteres ficar 4.   #Dúvida

*------* lips
      SELECT vgbel
             vgpos
             matnr
             werks
             lgort
             bwart
             vbeln
             posnr
      FROM lips
      INTO TABLE t_lips
      FOR ALL ENTRIES IN t_vbap
      WHERE vgbel = t_vbap-vbeln AND
            vgpos = t_vbap-posnr.

      IF t_lips IS NOT INITIAL.

*------* mseg
        SELECT matnr
               werks
               lgort
               bwart
               vbeln_im
               dmbtr
               vbelp_im
        FROM mseg
        INTO TABLE t_mseg
        FOR ALL ENTRIES IN t_lips
        WHERE matnr = t_lips-matnr AND
              werks = t_lips-werks AND
              lgort = t_lips-lgort AND
              bwart = t_lips-bwart AND
           vbeln_im = t_lips-vbeln AND
           vbelp_im = t_lips-posnr.

*------* vbrp
        SELECT  vbeln
                aubel
                aupos
                vgbel
                vgpos
                vbeln
                vbeln
                posnr
                erdat
                erzet
          FROM vbrp
          INTO TABLE t_vbrp
          FOR ALL ENTRIES IN t_lips
          WHERE vgbel = t_lips-vbeln AND
                vgpos = t_lips-posnr.

*------* ser01
        SELECT lief_nr
                posnr
                obknr
        FROM ser01
        INTO TABLE t_ser01
        FOR ALL ENTRIES IN t_lips
        WHERE lief_nr = t_lips-vbeln AND
              posnr = t_lips-posnr.

*------* ztcrpin_hist
        SELECT mblnr
               zeile
               lotechk
         FROM ztcrpin_hist
         INTO TABLE t_ztcrpin_hist
         FOR ALL ENTRIES IN t_lips
         WHERE mblnr = t_lips-vbeln AND
               zeile = t_lips-posnr.

      ENDIF.
    ENDIF.

*------* kna1
    SELECT regio
           kunnr
           name1
    FROM kna1
    INTO TABLE t_kna1
    FOR ALL ENTRIES IN t_vbak
    WHERE kunnr = t_vbak-kunnr.


    IF t_vbrp IS NOT INITIAL.

*------* bkpf
      SELECT awkey
             belnr
        FROM bkpf
        INTO TABLE t_bkpf
        FOR ALL ENTRIES IN t_vbrp
        WHERE awkey = t_vbrp-vbeln_aux_awkey.

*------* zmmt101
      SELECT belnr
             vbeln
             posnr
             val_icms_prop
             icms_st
        FROM zmmt101
        INTO TABLE t_zmmt101
        FOR ALL ENTRIES IN t_vbrp
        WHERE vbeln = t_vbrp-vbeln AND
              posnr = t_vbrp-posnr.

*------* j_1bnflin
      SELECT cfop
             nbm
             matorg
             taxsit
             refkey
             refitm
             docnum
             itmnum
             netwr
             menge
             netdis
        FROM j_1bnflin
        INTO TABLE t_j_1bnflin
        FOR ALL ENTRIES IN t_vbrp
        WHERE refkey = t_vbrp-vbeln_aux_refkey AND
              refitm = t_vbrp-posnr.

      IF t_j_1bnflin IS NOT INITIAL.

*------* j_1bnfdoc
        SELECT docnum
               code
               nftot
               vdesc
               nfenum
       FROM j_1bnfdoc
       INTO TABLE t_j_1bnfdoc
       FOR ALL ENTRIES IN t_j_1bnflin
       WHERE docnum = t_j_1bnflin-docnum.

*------* j_1bnfstx
        SELECT docnum
               itmnum
               taxval
               taxgrp
               taxtyp
        FROM j_1bnfstx
        INTO TABLE t_j_1bnfstx
        FOR ALL ENTRIES IN t_j_1bnflin
        WHERE docnum = t_j_1bnflin-docnum AND
              itmnum = t_j_1bnflin-itmnum.
      ENDIF.
    ENDIF.

*------* objk
    SELECT obknr
           sernr
       FROM objk
       INTO TABLE t_objk
       FOR ALL ENTRIES IN t_ser01
       WHERE obknr = t_ser01-obknr.

*------* ztcrblister_hist
    SELECT mblnr
           zeile
           lotei
           lotef
    FROM ztcrblister_hist
    INTO TABLE t_ztcrblister_hist
    FOR ALL ENTRIES IN t_lips
    WHERE mblnr = t_lips-vbeln AND
          zeile = t_lips-posnr.

  ELSE.
    MESSAGE s398(00) WITH 'Não há registros!' DISPLAY LIKE 'E'.
    STOP.
  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  ZF_show_alv_poo
*&---------------------------------------------------------------------*
FORM zf_show_alv_poo.

  DATA: lo_table   TYPE REF TO cl_salv_table,              "Acessar a classe "cl_salv_table"
        lo_header  TYPE REF TO cl_salv_form_layout_grid,   "Para criação do header
        lo_columns TYPE REF TO cl_salv_columns_table.      "Ajustar tamanho dos subtítulos

  TRY.
      cl_salv_table=>factory( IMPORTING r_salv_table = lo_table "Tabela local
                             CHANGING t_table = t_out ).

      lo_table->get_functions( )->set_all( abap_true ). "Ativar met codes

*Campos que serão ocultados da t_out de acordo com RADIOBUTTON selecionado:
      IF rb_anali = 'X'.
        lo_table->get_columns( )->get_column( 'REGIO_T001W_SINT' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'WERKS_SINT' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'REGIO_KNA1_SINT' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'KUNNR_SINT' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'NAME1_SINT' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'VKORG_SINT' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'VTWEG_SINT' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'SPART_SINT' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'ERDAT_SINT' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'AUART_SINT' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'VBELN_SINT' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'BELNR_SINT' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'DOCNUM_SINT' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'CODE_SINT' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'NFTOT_SINT' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'VDESC_SINT' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'SOMA_MSEG_DMBTR' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'SOMA_VBAP_NETWR_MWSBP' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'SOMA_ZMMT101_VAL_ICMS_PROP' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'SOMA_ZMMT101_ICMS_ST' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'ZTIPO_OPER_SINT' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'ZSDT161_WERKS' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'VBELN_LIPS' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'VBELN_VBRP' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'SOMA_MSEG_DMBTR' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'SOMA_VBAP_NETWR_MWSBP' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'TAXVAL_PIS_SINT' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'TAXVAL_COFI_SINT' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'TAXVAL_ICM_SINT' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'TAXVAL_ICST_SINT' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'TAXVAL_ICAP_SINT' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'TAXVAL_ICSP_SINT' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'BELNR_ZMMT101' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'SOMA_ZMMT101_VAL_ICMS_PROP' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'SOMA_ZMMT101_ICMS_ST' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'NFENUM_SINT' )->set_visible( abap_false ).

      ELSE.
        lo_table->get_columns( )->get_column( 'REGIO_T001W_ANALI' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'WERKS_T001W_ANALI ' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'BELNR_ZMMT101_ANALI' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'TAXSIT_ANALI ' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'MATORG_ANALI' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'NBM_ANALI' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'CFOP_ANALI' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'CODE_ANALI' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'DOCNUM_ANALI' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'BELNR_BKPF_ANALI' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'VBELN_VBRP_ANALI' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'VBELN_LIPS_ANALI' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'ARKTX_ANALI' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'MATNR_ANALI' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'VRKME_ANALI' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'POSNR_ANALI' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'VBELN_VBAP_ANALI' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'AUART_ANALI' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'ERDAT_ANALI' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'SPART_ANALI' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'VTWEG_ANALI' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'VKORG_ANALI' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'NAME1_ANALI' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'KUNNR_ANALI' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'WERKS_ZSDT161_ANALI' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'REGIO_KNA1_ANALI' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'ZTIPO_OPER_ANALI' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'QUANTIDADE_ANALI' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'SERIAL_ANALI' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'PRECO' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'NFENUM_ANALI' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'VL_BRUTO' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'VL_TOTAL' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'VL_DESCONTO' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'PIS_ANALI' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'CONFINS_ANALI' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'ICMS_ANALI' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'ICMS_ST_J_1BNFSTX_ANALI' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'ICMS_DI_ANALI' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'FCP_ANALI' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'VAL_ICMS_PROP_ANALI' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'ICMS_ST_ZMMT101_ANALI' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'VL_ICMS_ENTRADA_ANALI' )->set_visible( abap_false ).
        lo_table->get_columns( )->get_column( 'VL_ICMS_ST_ENTRADA_ANALI' )->set_visible( abap_false ).

      ENDIF.

*Mudar nome das colunas do ALV
      lo_table->get_columns( )->get_column( 'SOMA_MSEG_DMBTR' )->set_short_text( 'Pre.Móvel' ).
      lo_table->get_columns( )->get_column( 'SOMA_MSEG_DMBTR' )->set_medium_text( 'Preço médio móvel' ).
      lo_table->get_columns( )->get_column( 'SOMA_MSEG_DMBTR' )->set_long_text( 'Preço médio móvel' ).

      lo_table->get_columns( )->get_column( 'SOMA_VBAP_NETWR_MWSBP' )->set_long_text( 'NF-e' ).
      lo_table->get_columns( )->get_column( 'SOMA_VBAP_NETWR_MWSBP' )->set_medium_text( 'NF-e' ).
      lo_table->get_columns( )->get_column( 'SOMA_VBAP_NETWR_MWSBP' )->set_short_text( 'NF-e' ).

      lo_table->get_columns( )->get_column( 'SOMA_ZMMT101_VAL_ICMS_PROP' )->set_long_text( 'Val.ICMS.e' ).
      lo_table->get_columns( )->get_column( 'SOMA_ZMMT101_VAL_ICMS_PROP' )->set_medium_text( 'Valor ICMS entrada' ).
      lo_table->get_columns( )->get_column( 'SOMA_ZMMT101_VAL_ICMS_PROP' )->set_short_text( 'Val.ICMS.e' ).

      lo_table->get_columns( )->get_column( 'VL_ICMS_ENTRADA_ANALI' )->set_short_text( 'Ent.Icms' ).
      lo_table->get_columns( )->get_column( 'VL_ICMS_ENTRADA_ANALI' )->set_medium_text( 'Ent.Icms' ).
      lo_table->get_columns( )->get_column( 'VL_ICMS_ENTRADA_ANALI' )->set_long_text( 'Ent.Icms' ).

      lo_table->get_columns( )->get_column( 'VL_ICMS_ST_ENTRADA_ANALI' )->set_short_text( 'En.Icms.St' ).
      lo_table->get_columns( )->get_column( 'VL_ICMS_ST_ENTRADA_ANALI' )->set_medium_text( 'Ent.Icms.St' ).
      lo_table->get_columns( )->get_column( 'VL_ICMS_ST_ENTRADA_ANALI' )->set_long_text( 'Ent.Icms.St' ).

      lo_table->get_columns( )->get_column( 'VL_BRUTO' )->set_short_text( 'Vl.Bruto' ).
      lo_table->get_columns( )->get_column( 'VL_BRUTO' )->set_medium_text( 'Vl.Bruto' ).
      lo_table->get_columns( )->get_column( 'VL_BRUTO' )->set_long_text( 'Vl.Bruto' ).

      lo_table->get_columns( )->get_column( 'VL_TOTAL' )->set_long_text( 'Vl.Total' ).
      lo_table->get_columns( )->get_column( 'VL_TOTAL' )->set_medium_text( 'Vl.Total' ).
      lo_table->get_columns( )->get_column( 'VL_TOTAL' )->set_short_text( 'Vl.Total' ).

      lo_table->get_columns( )->get_column( 'VL_DESCONTO' )->set_long_text( 'Vl.Desc' ).
      lo_table->get_columns( )->get_column( 'VL_DESCONTO' )->set_medium_text( 'Vl.Desc' ).
      lo_table->get_columns( )->get_column( 'VL_DESCONTO' )->set_short_text( 'Vl.Desc' ).

      CREATE OBJECT lo_header. "É necessário que criemos o objeto header

*Mudar título do header
      IF rb_anali = 'X'.
        lo_header->create_header_information( row = 1 column = 1 text = 'Relatório Analítico' ).
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
*&      Form  zf_monta_t_out_analitico
*&---------------------------------------------------------------------*
FORM zf_monta_t_out_analitico .

***------*** Variáveis locais ***------***
  DATA: vl_serial TYPE string,
        vl_taxgrp TYPE j_1bnfstx-taxgrp.

*------* t_vbap
  LOOP AT t_vbap INTO wa_vbap.

    wa_out-vbeln_vbap_anali = wa_vbap-vbeln.
    wa_out-posnr_anali = wa_vbap-posnr.
    wa_out-vrkme_anali = wa_vbap-vrkme.
    wa_out-matnr_anali = wa_vbap-matnr.
    wa_out-arktx_anali = wa_vbap-arktx.

*------* t_vbak
    READ TABLE t_vbak INTO wa_vbak WITH KEY vbeln = wa_vbap-vbeln.

    IF sy-subrc IS INITIAL.

      wa_out-vkorg_anali = wa_vbak-vkorg.
      wa_out-vtweg_anali = wa_vbak-vtweg.
      wa_out-spart_anali = wa_vbak-spart.
      wa_out-erdat_anali = wa_vbak-erdat.
      wa_out-auart_anali = wa_vbak-auart.
      wa_out-ztipo_oper_anali = wa_vbak-ztipo_oper.

*------* t_kna1
      READ TABLE t_kna1 INTO wa_kna1 WITH KEY kunnr = wa_vbak-kunnr.

      IF sy-subrc IS INITIAL.
        wa_out-regio_kna1_anali = wa_kna1-regio.
        wa_out-kunnr_anali = wa_kna1-kunnr.
        wa_out-name1_anali = wa_kna1-name1.

      ENDIF.
    ENDIF.

*------* t_zsdt161
    READ TABLE t_zsdt161 INTO wa_zsdt161 WITH KEY vbeln = wa_vbap-vbeln.

    IF sy-subrc IS INITIAL.
      wa_out-werks_zsdt161_anali = wa_zsdt161-werks.
    ENDIF.

*------* t_lips
    READ TABLE t_lips INTO wa_lips WITH KEY vgbel = wa_vbap-vbeln
                                            vgpos = wa_vbap-posnr.
    IF sy-subrc IS INITIAL.
      wa_out-vbeln_lips_anali = wa_lips-vbeln.

*------* t_ser01
      READ TABLE t_ser01 INTO wa_ser01 WITH KEY lief_nr = wa_lips-vbeln
                                                posnr   = wa_lips-posnr.

      IF sy-subrc IS INITIAL.

*------* t_objk
        READ TABLE t_objk INTO wa_objk WITH KEY obknr = wa_ser01-obknr.

        IF sy-subrc IS INITIAL.
          wa_out-serial_anali = wa_objk-sernr.
        ENDIF.

      ELSE.

*------* t_ztcrblister_hist
        READ TABLE t_ztcrblister_hist INTO wa_ztcrblister_hist WITH KEY mblnr = wa_lips-vbeln
                                                                        zeile = wa_lips-posnr.
        IF sy-subrc IS INITIAL AND wa_out-serial_anali IS INITIAL.

          CONCATENATE wa_ztcrblister_hist-lotei wa_ztcrblister_hist-lotef INTO vl_serial.

          wa_out-serial_anali = vl_serial.

        ELSE.

*------* t_ztcrpin_hist
          READ TABLE t_ztcrpin_hist INTO wa_ztcrpin_hist WITH KEY mblnr = wa_lips-vbeln
                                                                  zeile = wa_lips-posnr.

          IF sy-subrc IS INITIAL AND wa_out-serial_anali IS INITIAL.
            wa_out-serial_anali = wa_ztcrpin_hist-lotechk.
          ENDIF.

        ENDIF.
      ENDIF.
    ENDIF.

*------* t_vbrp
    READ TABLE t_vbrp INTO wa_vbrp WITH KEY aubel = wa_vbap-vbeln
                                            aupos = wa_vbap-posnr.
    IF sy-subrc IS INITIAL.
      wa_out-vbeln_vbrp_anali = wa_vbrp-vbeln.

*------* t_bkpf
      READ TABLE t_bkpf INTO wa_bkpf WITH KEY awkey = wa_vbrp-vbeln_aux_awkey.
      IF sy-subrc IS INITIAL.
        wa_out-belnr_bkpf_anali = wa_bkpf-belnr.
      ENDIF.
    ENDIF.

*------* t_zmmt101
    READ TABLE t_zmmt101 INTO wa_zmmt101 WITH KEY vbeln = wa_vbrp-vbeln
                                                  posnr = wa_vbrp-posnr.

    IF sy-subrc IS INITIAL.
      wa_out-belnr_zmmt101_anali = wa_zmmt101-belnr.
    ENDIF.

*------* t_j_1bnflin
    READ TABLE  t_j_1bnflin INTO wa_j_1bnflin WITH KEY refkey = wa_vbrp-vbeln_aux_refkey
                                                       refitm = wa_vbrp-posnr.

    IF sy-subrc IS INITIAL.
      wa_out-cfop_anali = wa_j_1bnflin-cfop.
      wa_out-nbm_anali = wa_j_1bnflin-nbm.
      wa_out-matorg_anali = wa_j_1bnflin-matorg.
      wa_out-taxsit_anali = wa_j_1bnflin-taxsit.

      IF wa_out-serial_anali IS NOT INITIAL.
        wa_out-quantidade_anali = 1.
      ELSE.
        wa_out-quantidade_anali = wa_vbap-kwmeng.
      ENDIF.

      CASE wa_out-quantidade_anali.
        WHEN 1.
          wa_out-vl_bruto                 = ( wa_vbap-netwr + wa_vbap-mwsbp ) / wa_vbap-kwmeng.
          wa_out-vl_total                 = wa_j_1bnflin-netwr / wa_j_1bnflin-menge.
          wa_out-vl_desconto              = wa_j_1bnflin-netdis / wa_j_1bnflin-menge.
          wa_out-vl_icms_entrada_anali    = wa_zmmt101-val_icms_prop / wa_j_1bnflin-menge.
          wa_out-vl_icms_st_entrada_anali = wa_zmmt101-icms_st / wa_j_1bnflin-menge.
          wa_out-preco                    = wa_mseg-dmbtr / wa_vbap-kwmeng.
        WHEN OTHERS.
          wa_out-vl_bruto                 = wa_vbap-netwr + wa_vbap-mwsbp.
          wa_out-vl_total                 = wa_j_1bnflin-netwr.
          wa_out-vl_desconto              = wa_j_1bnflin-netdis.
          wa_out-vl_icms_entrada_anali    = wa_zmmt101-val_icms_prop.
          wa_out-vl_icms_st_entrada_anali = wa_zmmt101-icms_st.
          wa_out-preco                    = wa_mseg-dmbtr.
      ENDCASE.

*------* t_j_1bnfdoc
      READ TABLE t_j_1bnfdoc INTO wa_j_1bnfdoc WITH KEY docnum = wa_j_1bnflin-docnum.

      IF sy-subrc IS INITIAL.
        wa_out-docnum_anali = wa_j_1bnfdoc-docnum.
        wa_out-nfenum_anali = wa_j_1bnfdoc-nfenum.
        wa_out-code_anali   = wa_j_1bnfdoc-code.
      ENDIF.

*------*  t_j_1bnfstx
      READ TABLE t_j_1bnfstx INTO wa_j_1bnfstx WITH KEY docnum = wa_j_1bnflin-docnum
                                                        itmnum = wa_j_1bnflin-itmnum.

      IF sy-subrc IS INITIAL.

        LOOP AT t_j_1bnfstx INTO wa_j_1bnfstx WHERE docnum = wa_j_1bnflin-docnum.

          "Verificação do campo taxgrp para saber se possui no valor da string o início ICM
          IF wa_j_1bnfstx-taxgrp CP 'ICM*'.
            vl_taxgrp = wa_j_1bnfstx-taxgrp.
          ENDIF.

          "Atribuição dos campos na tabela de saída conforme valor do campo taxgrp
          CASE wa_j_1bnfstx-taxgrp.
            WHEN 'PIS'.
              IF wa_out-quantidade_anali = 1.
                wa_out-pis_anali = wa_out-pis_anali + wa_j_1bnfstx-taxval / wa_j_1bnflin-menge.
              ELSE.
                wa_out-pis_anali = wa_out-pis_anali + wa_j_1bnfstx-taxval.
              ENDIF.
            WHEN 'COFI'.
              wa_out-confins_anali = wa_out-confins_anali + wa_j_1bnfstx-taxval.
            WHEN vl_taxgrp.
              wa_out-icms_anali = wa_out-icms_anali + wa_j_1bnfstx-taxval.
            WHEN 'ICST'.
              wa_out-icms_st_j_1bnfstx_anali = wa_out-icms_st_j_1bnfstx_anali + wa_j_1bnfstx-taxval.
            WHEN 'ICAP'.
              wa_out-icms_di_anali = wa_out-icms_di_anali + wa_j_1bnfstx-taxval.
            WHEN 'ICSP'.
              wa_out-fcp_anali = wa_out-fcp_anali + wa_j_1bnfstx-taxval.
            WHEN OTHERS.
          ENDCASE.

          CLEAR: wa_j_1bnfstx.

        ENDLOOP.
      ENDIF.
    ENDIF.

*------* t_t001w
    READ TABLE  t_t001w INTO wa_t001w WITH KEY werks = wa_vbap-werks.
    IF sy-subrc IS INITIAL.
      wa_out-regio_t001w_anali = wa_t001w-regio.
      wa_out-werks_t001w_anali = wa_t001w-werks.
    ENDIF.

    APPEND wa_out TO t_out.
    CLEAR: wa_out,
           wa_vbak,
           wa_vbap,
           wa_zsdt161,
           wa_vbrp,
           wa_lips,
           wa_bkpf,
           wa_zmmt101,
           wa_j_1bnflin,
           wa_j_1bnfdoc.

  ENDLOOP.
ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  zf_monta_t_out_sintetico
*&---------------------------------------------------------------------*
FORM zf_monta_t_out_sintetico .

  PERFORM z_soma_sintetico.

*------* t_vbak
  LOOP AT t_vbak INTO wa_vbak.

    wa_out-vkorg_sint = wa_vbak-vkorg.
    wa_out-vtweg_sint = wa_vbak-vtweg.
    wa_out-spart_sint = wa_vbak-spart.
    wa_out-erdat_sint = wa_vbak-erdat.
    wa_out-auart_sint = wa_vbak-auart.
    wa_out-vbeln_sint = wa_vbak-vbeln.
    wa_out-ztipo_oper_sint = wa_vbak-ztipo_oper.

*------* t_collect_vbap
    "                  Somatório VBAP-NETWR e VBAP-MWSBP
    READ TABLE t_collect_vbap INTO wa_collect_vbap WITH KEY vbeln = wa_vbak-vbeln.
    IF sy-subrc IS INITIAL.
      wa_out-soma_vbap_netwr_mwsbp = wa_collect_vbap-netwr + wa_collect_vbap-mwsbp.
    ENDIF.

*------* t_kna1
    READ TABLE t_kna1 INTO wa_kna1 WITH KEY kunnr = wa_vbak-kunnr.
    IF sy-subrc IS INITIAL.
      wa_out-regio_kna1_sint = wa_kna1-regio.
      wa_out-kunnr_sint = wa_kna1-kunnr.
      wa_out-name1_sint = wa_kna1-name1.
    ENDIF.

*------* t_vbap
    READ TABLE t_vbap INTO wa_vbap WITH KEY vbeln = wa_vbak-vbeln.
    IF sy-subrc IS INITIAL.

*------* t_zsdt161
      READ TABLE t_zsdt161 INTO wa_zsdt161 WITH KEY vbeln = wa_vbap-vbeln.
      IF sy-subrc IS INITIAL.
        wa_out-zsdt161_werks = wa_zsdt161-werks.
      ENDIF.

*------* t_lips
      READ TABLE t_lips INTO wa_lips WITH KEY vgbel = wa_vbap-vbeln.
      IF sy-subrc IS INITIAL.
        wa_out-vbeln_lips = wa_lips-vbeln.
      ENDIF.

*------* t_t001w
      READ TABLE  t_t001w INTO wa_t001w WITH KEY werks = wa_vbap-werks.
      IF sy-subrc IS INITIAL.
        wa_out-regio_t001w_sint  = wa_t001w-regio.
        wa_out-werks_sint        = wa_t001w-werks.
      ENDIF.

*------* t_lips
      READ TABLE t_lips INTO wa_lips WITH KEY vgbel = wa_vbap-vbeln
                                              vgpos = wa_vbap-posnr.
      IF sy-subrc IS INITIAL.

*------* t_vbrp
        READ TABLE t_vbrp INTO wa_vbrp WITH KEY vgbel = wa_lips-vbeln
                                        vgpos = wa_lips-posnr.

        IF sy-subrc IS INITIAL.

*------* t_bkpf
          READ TABLE t_bkpf INTO wa_bkpf WITH KEY awkey = wa_vbrp-vbeln_aux_awkey.
          IF sy-subrc IS INITIAL.
            wa_out-belnr_sint = wa_bkpf-belnr.
          ENDIF.

*------* t_j_1bnflin
          READ TABLE  t_j_1bnflin INTO wa_j_1bnflin WITH KEY refkey = wa_vbrp-vbeln_aux_refkey
                                                             refitm = wa_vbrp-posnr.
          IF sy-subrc IS INITIAL.

*------* t_j_1bnfdoc
            READ TABLE t_j_1bnfdoc INTO wa_j_1bnfdoc WITH KEY docnum = wa_j_1bnflin-docnum.
            IF sy-subrc IS INITIAL.
              wa_out-docnum_sint = wa_j_1bnfdoc-docnum.
              wa_out-code_sint   = wa_j_1bnfdoc-code.
              wa_out-nftot_sint  = wa_j_1bnfdoc-nftot.
              wa_out-vdesc_sint  = wa_j_1bnfdoc-vdesc.
            ENDIF.

*------* t_j_1bnfstx
            READ TABLE t_j_1bnfstx INTO wa_j_1bnfstx WITH KEY docnum = wa_j_1bnflin-docnum
                                                              itmnum = wa_j_1bnflin-itmnum.

            IF sy-subrc IS INITIAL.

              LOOP AT t_j_1bnfstx INTO wa_j_1bnfstx WHERE docnum = wa_j_1bnflin-docnum.
                CASE wa_j_1bnfstx-taxgrp.
                  WHEN 'PIS'.
                    wa_out-taxval_pis_sint = wa_out-taxval_pis_sint + wa_j_1bnfstx-taxval.
                  WHEN 'COFI'.
                    wa_out-taxval_cofi_sint = wa_out-taxval_cofi_sint + wa_j_1bnfstx-taxval.
                  WHEN 'ICST'.
                    wa_out-taxval_icst_sint = wa_out-taxval_icst_sint + wa_j_1bnfstx-taxval.
                ENDCASE.

                IF wa_j_1bnfstx-taxtyp = 'ICM+'.
                  wa_out-taxval_icm_sint = wa_out-taxval_icm_sint + wa_j_1bnfstx-taxval.
                ENDIF.

                CASE wa_j_1bnfstx-taxtyp.
                  WHEN 'ICAP'.
                    wa_out-taxval_icap_sint = wa_out-taxval_icap_sint + wa_j_1bnfstx-taxval.
                  WHEN 'ICSP'.
                    wa_out-taxval_icsp_sint = wa_out-taxval_icsp_sint + wa_j_1bnfstx-taxval.
                ENDCASE.
                CLEAR: wa_j_1bnfstx.
              ENDLOOP.

            ENDIF.
          ENDIF.
        ENDIF.

*------* t_collect_msegt
        "                                Somatório mseg-dmbtr
        READ TABLE t_collect_mseg INTO wa_collect_mseg WITH KEY vbeln_im = wa_lips-vbeln.
        IF sy-subrc IS INITIAL.
          wa_out-soma_mseg_dmbtr = wa_collect_mseg-dmbtr.
        ENDIF.

*------*  t_vbrp
        READ TABLE t_vbrp INTO wa_vbrp WITH KEY aubel = wa_lips-vbeln
                                                aupos = wa_lips-posnr
                                                vgbel = wa_lips-vbeln
                                                vgpos = wa_lips-posnr.
        IF sy-subrc IS INITIAL.

          wa_out-vbeln_vbrp = wa_vbrp-vbeln.

*------* t_lips
          READ TABLE t_lips INTO wa_lips WITH KEY vbeln = wa_vbrp-vbeln
                                                  posnr = wa_vbrp-posnr.
          IF sy-subrc IS INITIAL.
            wa_out-belnr_zmmt101 = wa_zmmt101-belnr.
          ENDIF.

*------* t_collect_zmmt101
*             Somatório ZMMT101-VAL_ICMS_PROP  e  Somatório ZMMT101-ICMS_ST
          READ TABLE t_collect_zmmt101 INTO wa_collect_zmmt101 WITH KEY vbeln = wa_vbrp-vbeln.
          IF sy-subrc IS INITIAL.
            wa_out-soma_zmmt101_val_icms_prop = wa_collect_zmmt101-val_icms_prop.
            wa_out-soma_zmmt101_icms_st = wa_collect_zmmt101-icms_st.
          ENDIF.
        ENDIF.
      ENDIF.
    ENDIF.

    APPEND wa_out TO t_out.
    CLEAR: wa_out,
           wa_vbak,
           wa_vbap,
           wa_zsdt161,
           wa_vbrp,
           wa_lips,
           wa_bkpf,
           wa_zmmt101,
           wa_j_1bnflin,
           wa_j_1bnfdoc,
           wa_collect_mseg,
           wa_j_1bnfstx.

  ENDLOOP.
ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  z_soma_sintetico
*&---------------------------------------------------------------------*
FORM z_soma_sintetico .

*Somatório mseg-dmbtr
  LOOP AT t_mseg INTO wa_mseg.
    wa_collect_mseg-dmbtr = wa_mseg-dmbtr.
    wa_collect_mseg-vbeln_im = wa_mseg-vbeln_im.

    COLLECT wa_collect_mseg INTO t_collect_mseg.
    CLEAR wa_collect_mseg.
  ENDLOOP.

*Somatório VBAP-NETWR e VBAP-MWSBP
  LOOP AT t_vbap INTO wa_vbap.
    wa_collect_vbap-netwr   = wa_vbap-netwr.
    wa_collect_vbap-mwsbp = wa_vbap-mwsbp.
    wa_collect_vbap-vbeln = wa_vbap-vbeln.

    COLLECT wa_collect_vbap INTO t_collect_vbap.
    CLEAR wa_collect_vbap.
  ENDLOOP.

*Somatório ZMMT101-VAL_ICMS_PROP  e  *Somatório ZMMT101-ICMS_ST
  LOOP AT t_zmmt101 INTO wa_zmmt101.
    wa_collect_zmmt101-val_icms_prop   = wa_zmmt101-val_icms_prop.
    wa_collect_zmmt101-vbeln = wa_zmmt101-vbeln.
    wa_collect_zmmt101-icms_st = wa_zmmt101-icms_st.

    COLLECT wa_collect_zmmt101 INTO t_collect_zmmt101.
    CLEAR wa_collect_zmmt101.
  ENDLOOP.


ENDFORM.
