*&---------------------------------------------------------------------*
*& Include          ZI_CLASSES_TXT
*&---------------------------------------------------------------------*

*Definições:
*lcl_upload
CLASS lcl_upload DEFINITION.
  PUBLIC SECTION.
    METHODS: seleciona_arquivo
      CHANGING
        i_upld TYPE rlgrap-filename.

  PRIVATE SECTION.
    METHODS: carrega_dados,
      popula_it_marc,
      modify_marc.

    TYPES: BEGIN OF ty_arq,
             linha(2000) TYPE c,
           END   OF ty_arq.

    DATA: v_arqv     TYPE rlgrap-filename,
          v_filename TYPE string,
          it_arq     TYPE TABLE OF ty_arq,
          it_marc    TYPE TABLE OF marc.
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
      me->popula_it_marc( ).
    ENDIF.
  ENDMETHOD.

  "Popula it_marc
  METHOD popula_it_marc.
    DATA: wa_marc              TYPE marc,
          v_plifz(40)          TYPE c,
          v_perkz(40)          TYPE c,
          v_ausss(40)          TYPE c,
          v_webaz(40)          TYPE c,
          v_minbe(40)          TYPE c,
          v_eisbe(40)          TYPE c,
          v_bstmi(40)          TYPE c,
          v_bstma(40)          TYPE c,
          v_bstfe(40)          TYPE c,
          v_bstrf(40)          TYPE c,
          v_losfx(40)          TYPE c,
          v_mabst(40)          TYPE c,
          v_bearz(40)          TYPE c,
          v_ruezt(40)          TYPE c,
          v_tranz(40)          TYPE c,
          v_basmg(40)          TYPE c,
          v_dzeit(40)          TYPE c,
          v_maxlz(40)          TYPE c,
          v_lzeih(40)          TYPE c,
          v_kzpro(40)          TYPE c,
          v_gpmkz(40)          TYPE c,
          v_ueeto(40)          TYPE c,
          v_ueetk(40)          TYPE c,
          v_uneto(40)          TYPE c,
          v_wzeit(40)          TYPE c,
          v_atpkz(40)          TYPE c,
          v_vzusl(40)          TYPE c,
          v_herbl(40)          TYPE c,
          v_insmk(40)          TYPE c,
          v_sproz(40)          TYPE c,
          v_quazt(40)          TYPE c,
          v_ssqss(40)          TYPE c,
          v_mpdau(40)          TYPE c,
          v_kzppv(40)          TYPE c,
          v_kzdkz(40)          TYPE c,
          v_wstgh(40)          TYPE c,
          v_prfrq(40)          TYPE c,
          v_nkmpr(40)          TYPE c,
          v_umlmc(40)          TYPE c,
          v_ladgr(40)          TYPE c,
          v_xchpf(40)          TYPE c,
          v_usequ(40)          TYPE c,
          v_lgrad(40)          TYPE c,
          v_auftl(40)          TYPE c,
          v_plvar(40)          TYPE c,
          v_otype(40)          TYPE c,
          v_objid(40)          TYPE c,
          v_mtvfp(40)          TYPE c,
          v_periv(40)          TYPE c,
          v_kzkfk(40)          TYPE c,
          v_vrvez(40)          TYPE c,
          v_vbamg(40)          TYPE c,
          v_vbeaz(40)          TYPE c,
          v_lizyk(40)          TYPE c,
          v_bwscl(40)          TYPE c,
          v_kautb(40)          TYPE c,
          v_kordb(40)          TYPE c,
          v_stawn(40)          TYPE c,
          v_herkl(40)          TYPE c,
          v_herkr(40)          TYPE c,
          v_expme(40)          TYPE c,
          v_mtver(40)          TYPE c,
          v_prctr(40)          TYPE c,
          v_trame(40)          TYPE c,
          v_mrppp(40)          TYPE c,
          v_sauft(40)          TYPE c,
          v_fxhor(40)          TYPE c,
          v_vrmod(40)          TYPE c,
          v_vint1(40)          TYPE c,
          v_vint2(40)          TYPE c,
          v_verkz(40)          TYPE c,
          v_stlal(40)          TYPE c,
          v_stlan(40)          TYPE c,
          v_plnnr(40)          TYPE c,
          v_aplal(40)          TYPE c,
          v_losgr(40)          TYPE c,
          v_sobsk(40)          TYPE c,
          v_frtme(40)          TYPE c,
          v_lgpro(40)          TYPE c,
          v_disgr(40)          TYPE c,
          v_kausf(40)          TYPE c,
          v_qzgtp(40)          TYPE c,
          v_qmatv(40)          TYPE c,
          v_takzt(40)          TYPE c,
          v_rwpro(40)          TYPE c,
          v_copam(40)          TYPE c,
          v_abcin(40)          TYPE c,
          v_awsls(40)          TYPE c,
          v_sernp(40)          TYPE c,
          v_cuobj(40)          TYPE c,
          v_stdpd(40)          TYPE c,
          v_sfepr(40)          TYPE c,
          v_xmcng(40)          TYPE c,
          v_qssys(40)          TYPE c,
          v_lfrhy(40)          TYPE c,
          v_rdprf(40)          TYPE c,
          v_vrbmt(40)          TYPE c,
          v_vrbwk(40)          TYPE c,
          v_vrbdt(40)          TYPE c,
          v_vrbfk(40)          TYPE c,
          v_autru(40)          TYPE c,
          v_prefe(40)          TYPE c,
          v_prenc(40)          TYPE c,
          v_preno(40)          TYPE c,
          v_prend(40)          TYPE c,
          v_prene(40)          TYPE c,
          v_preng(40)          TYPE c,
          v_itark(40)          TYPE c,
          v_servg(40)          TYPE c,
          v_kzkup(40)          TYPE c,
          v_strgr(40)          TYPE c,
          v_cuobv(40)          TYPE c,
          v_lgfsb(40)          TYPE c,
          v_schgt(40)          TYPE c,
          v_ccfix(40)          TYPE c,
          v_eprio(40)          TYPE c,
          v_qmata(40)          TYPE c,
          v_resvp(40)          TYPE c,
          v_plnty(40)          TYPE c,
          v_uomgr(40)          TYPE c,
          v_umrsl(40)          TYPE c,
          v_abfac(40)          TYPE c,
          v_sfcpf(40)          TYPE c,
          v_shflg(40)          TYPE c,
          v_shzet(40)          TYPE c,
          v_mdach(40)          TYPE c,
          v_kzech(40)          TYPE c,
          v_megru(40)          TYPE c,
          v_mfrgr(40)          TYPE c,
          v_vkumc(40)          TYPE c,
          v_vktrw(40)          TYPE c,
          v_kzagl(40)          TYPE c,
          v_fvidk(40)          TYPE c,
          v_fxpru(40)          TYPE c,
          v_loggr(40)          TYPE c,
          v_fprfm(40)          TYPE c,
          v_glgmg(40)          TYPE c,
          v_vkglg(40)          TYPE c,
          v_indus(40)          TYPE c,
          v_mownr(40)          TYPE c,
          v_mogru(40)          TYPE c,
          v_casnr(40)          TYPE c,
          v_gpnum(40)          TYPE c,
          v_steuc(40)          TYPE c,
          v_fabkz(40)          TYPE c,
          v_matgr(40)          TYPE c,
          v_vspvb(40)          TYPE c,
          v_dplfs(40)          TYPE c,
          v_dplpu(40)          TYPE c,
          v_dplho(40)          TYPE c,
          v_minls(40)          TYPE c,
          v_maxls(40)          TYPE c,
          v_fixls(40)          TYPE c,
          v_ltinc(40)          TYPE c,
          v_compl(40)          TYPE c,
          v_convt(40)          TYPE c,
          v_shpro(40)          TYPE c,
          v_ahdis(40)          TYPE c,
          v_diber(40)          TYPE c,
          v_kzpsp(40)          TYPE c,
          v_ocmpf(40)          TYPE c,
          v_mcrue(40)          TYPE c,
          v_lfmon(40)          TYPE c,
          v_lfgja(40)          TYPE c,
          v_eislo(40)          TYPE c,
          v_bwesb(40)          TYPE c,
          v_ncost(40)          TYPE c,
          v_apokz(40)          TYPE c,
          v_cmdmb_eires(40)    TYPE c,
          v_cmdmb_lftag(40)    TYPE c,
          v_cmdmb_sitag(40)    TYPE c,
          v_cmdmb_gestg(40)    TYPE c,
          v_cmdmb_maxlg(40)    TYPE c,
          v_cmdmb_faker(40)    TYPE c,
          v_cmdmb_aschl(40)    TYPE c,
          v_sapmptolprpl(40)   TYPE c,
          v_sapmptolprmi(40)   TYPE c,
          v_vsor_pkgrp(40)     TYPE c,
          v_vsor_lane_num(40)  TYPE c,
          v_vsor_pal_vend(40)  TYPE c,
          v_vsor_fork_dir(40)  TYPE c,
          v_gi_pr_time(40)     TYPE c,
          v_multiple_ekgrp(40) TYPE c,
          v_ref_schema(40)     TYPE c,
          v_min_troc(40)       TYPE c,
          v_max_troc(40)       TYPE c,
          v_target_stock(40)   TYPE c,
          v_zzeires(40)        TYPE c,
          v_zzlftag(40)        TYPE c,
          v_zzsitag(40)        TYPE c,
          v_zzgestg(40)        TYPE c,
          v_zzmaxlg(40)        TYPE c,
          v_zzfaker(40)        TYPE c,
          v_zzaschl(40)        TYPE c,
          v_zzlfspme(40)       TYPE c,
          v_zzaltmn(40)        TYPE c,
          v_zzgema(40)         TYPE c,
          v_zzuhg(40)          TYPE c,
          v_zzek1(40)          TYPE c,
          v_zzek2(40)          TYPE c,
          v_zzek5(40)          TYPE c,
          v_zzek6(40)          TYPE c,
          v_zzstcode_i(40)     TYPE c,
          v_zzstcode_e(40)     TYPE c,
          v_zzek5_aufschlag(1) TYPE c,
          v_zzek1_aufschlag(1) TYPE c,
          v_zzek5_abschlag(1)  TYPE c,
          v_zzpreis_b(1)       TYPE c,
          v_mmstd(10)           TYPE c,
          v_zzmhd(1)           TYPE c.


    LOOP AT it_arq INTO DATA(wa_arq).
      IF sy-tabix EQ '1'.
        CONTINUE.
      ELSE.
        "Substituir todas as vírgulas por ponto
        REPLACE ALL OCCURRENCES OF ',' IN wa_arq-linha WITH '.'.
        "SPLIT
        SPLIT wa_arq-linha AT ';' INTO
          wa_marc-matnr
          wa_marc-werks
          wa_marc-pstat
          wa_marc-lvorm
          wa_marc-bwtty
          wa_marc-xchar
          wa_marc-mmsta
          v_mmstd
          wa_marc-maabc
          wa_marc-kzkri
          wa_marc-ekgrp
          wa_marc-ausme
          wa_marc-dispr
          wa_marc-dismm
          wa_marc-dispo
          wa_marc-kzdie
          v_plifz
          v_webaz
          v_perkz
          v_ausss
          wa_marc-disls
          wa_marc-beskz
          wa_marc-sobsl
          v_minbe
          v_eisbe
          v_bstmi
          v_bstma
          v_bstfe
          v_bstrf
          v_mabst
          v_losfx
          wa_marc-sbdkz
          wa_marc-lagpr
          wa_marc-altsl
          wa_marc-kzaus
          wa_marc-ausdt
          wa_marc-nfmat
          wa_marc-kzbed
          wa_marc-miskz
          wa_marc-fhori
          wa_marc-pfrei
          wa_marc-ffrei
          wa_marc-rgekz
          wa_marc-fevor
          v_bearz
          v_ruezt
          v_tranz
          v_basmg
          v_dzeit
          v_maxlz
          v_lzeih
          v_kzpro
          v_gpmkz
          v_ueeto
          v_ueetk
          v_uneto
          v_wzeit
          v_atpkz
          v_vzusl
          v_herbl
          v_insmk
          v_sproz
          v_quazt
          v_ssqss
          v_mpdau
          v_kzppv
          v_kzdkz
          v_wstgh
          v_prfrq
          v_nkmpr
          v_umlmc
          v_ladgr
          v_xchpf
          v_usequ
          v_lgrad
          v_auftl
          v_plvar
          v_otype
          v_objid
          v_mtvfp
          v_periv
          v_kzkfk
          v_vrvez
          v_vbamg
          v_vbeaz
          v_lizyk
          v_bwscl
          v_kautb
          v_kordb
          v_stawn
          v_herkl
          v_herkr
          v_expme
          v_mtver
          v_prctr
          v_trame
          v_mrppp
          v_sauft
          v_fxhor
          v_vrmod
          v_vint1
          v_vint2
          v_verkz
          v_stlal
          v_stlan
          v_plnnr
          v_aplal
          v_losgr
          v_sobsk
          v_frtme
          v_lgpro
          v_disgr
          v_kausf
          v_qzgtp
          v_qmatv
          v_takzt
          v_rwpro
          v_copam
          v_abcin
          v_awsls
          v_sernp
          v_cuobj
          v_stdpd
          v_sfepr
          v_xmcng
          v_qssys
          v_lfrhy
          v_rdprf
          v_vrbmt
          v_vrbwk
          v_vrbdt
          v_vrbfk
          v_autru
          v_prefe
          v_prenc
          v_preno
          v_prend
          v_prene
          v_preng
          v_itark
          v_servg
          v_kzkup
          v_strgr
          v_cuobv
          v_lgfsb
          v_schgt
          v_ccfix
          v_eprio
          v_qmata
          v_resvp
          v_plnty
          v_uomgr
          v_umrsl
          v_abfac
          v_sfcpf
          v_shflg
          v_shzet
          v_mdach
          v_kzech
          v_megru
          v_mfrgr
          v_vkumc
          v_vktrw
          v_kzagl
          v_fvidk
          v_fxpru
          v_loggr
          v_fprfm
          v_glgmg
          v_vkglg
          v_indus
          v_mownr
          v_mogru
          v_casnr
          v_gpnum
          v_steuc
          v_fabkz
          v_matgr
          v_vspvb
          v_dplfs
          v_dplpu
          v_dplho
          v_minls
          v_maxls
          v_fixls
          v_ltinc
          v_compl
          v_convt
          v_shpro
          v_ahdis
          v_diber
          v_kzpsp
          v_ocmpf
          v_apokz
          v_mcrue
          v_lfmon
          v_lfgja
          v_eislo
          v_ncost
          wa_marc-rotation_date
          wa_marc-uchkz
          wa_marc-ucmat
          v_bwesb
          v_cmdmb_eires
          v_cmdmb_lftag
          v_cmdmb_sitag
          v_cmdmb_gestg
          v_cmdmb_maxlg
          v_cmdmb_faker
          v_cmdmb_aschl
          v_sapmptolprpl
          v_sapmptolprmi
          v_vsor_pkgrp
          v_vsor_lane_num
          v_vsor_pal_vend
          v_vsor_fork_dir
          wa_marc-iuid_relevant
          wa_marc-iuid_type
          wa_marc-uid_iea
          wa_marc-cons_procg
          v_gi_pr_time
          v_multiple_ekgrp
          v_ref_schema
          v_min_troc
          v_max_troc
          v_target_stock
          v_zzeires
          v_zzlftag
          v_zzsitag
          v_zzgestg
          v_zzmaxlg
          v_zzfaker
          v_zzaschl
          v_zzlfspme
          v_zzaltmn
          v_zzgema
          v_zzuhg
          v_zzek1
          v_zzek2
          v_zzek5
          v_zzek6
          v_zzstcode_i
          v_zzstcode_e
          v_zzek5_aufschlag
          v_zzek1_aufschlag
          v_zzek5_abschlag
          v_zzpreis_b
          v_zzmhd.

        "Tratamentos:
        wa_marc-/cmd/mb_eires = v_cmdmb_eires.
        wa_marc-plifz = v_plifz.
        wa_marc-apokz = v_apokz.
        wa_marc-webaz = v_webaz.
        wa_marc-perkz = v_perkz.
        wa_marc-ausss = v_ausss.
        wa_marc-minbe = v_minbe.
        wa_marc-eisbe = v_eisbe.
        wa_marc-bstmi = v_bstmi.
        wa_marc-bstma = v_bstma.
        wa_marc-bstfe = v_bstfe.
        wa_marc-bstrf = v_bstrf.
        wa_marc-mabst = v_mabst.
        wa_marc-losfx = v_losfx.
        wa_marc-bearz = v_bearz.
        wa_marc-ruezt = v_ruezt.
        wa_marc-tranz = v_tranz.
        wa_marc-basmg = v_basmg.
        wa_marc-dzeit = v_dzeit.
        wa_marc-maxlz = v_maxlz.
        wa_marc-lzeih = v_lzeih.
        wa_marc-kzpro = v_kzpro.
        wa_marc-gpmkz = v_gpmkz.
        wa_marc-ueeto = v_ueeto.
        wa_marc-ueetk = v_ueetk.
        wa_marc-uneto = v_uneto.
        wa_marc-wzeit = v_wzeit.
        wa_marc-atpkz = v_atpkz.
        wa_marc-vzusl = v_vzusl.
        wa_marc-herbl = v_herbl.
        wa_marc-insmk = v_insmk.
        wa_marc-sproz = v_sproz.
        wa_marc-quazt = v_quazt.
        wa_marc-ssqss = v_ssqss.
        wa_marc-mpdau = v_mpdau.
        wa_marc-kzppv = v_kzppv.
        wa_marc-kzdkz = v_kzdkz.
        wa_marc-wstgh = v_wstgh.
        wa_marc-prfrq = v_prfrq.
        wa_marc-nkmpr = v_nkmpr.
        wa_marc-umlmc = v_umlmc.
        wa_marc-ladgr = v_ladgr.
        wa_marc-xchpf = v_xchpf.
        wa_marc-usequ = v_usequ.
        wa_marc-lgrad = v_lgrad.
        wa_marc-auftl = v_auftl.
        wa_marc-plvar = v_plvar.
        wa_marc-otype = v_otype.
        wa_marc-objid = v_objid.
        wa_marc-mtvfp = v_mtvfp.
        wa_marc-periv = v_periv.
        wa_marc-kzkfk = v_kzkfk.
        wa_marc-vrvez = v_vrvez.
        wa_marc-vbamg = v_vbamg.
        wa_marc-vbeaz = v_vbeaz.
        wa_marc-lizyk = v_lizyk.
        wa_marc-bwscl = v_bwscl.
        wa_marc-kautb = v_kautb.
        wa_marc-kordb = v_kordb.
        wa_marc-stawn = v_stawn.
        wa_marc-herkl = v_herkl.
        wa_marc-herkr = v_herkr.
        wa_marc-expme = v_expme.
        wa_marc-mtver = v_mtver.
        wa_marc-prctr = v_prctr.
        wa_marc-trame = v_trame.
        wa_marc-mrppp = v_mrppp.
        wa_marc-sauft = v_sauft.
        wa_marc-fxhor = v_fxhor.
        wa_marc-vrmod = v_vrmod.
        wa_marc-vint1 = v_vint1.
        wa_marc-vint2 = v_vint2.
        wa_marc-verkz = v_verkz.
        wa_marc-stlal = v_stlal.
        wa_marc-stlan = v_stlan.
        wa_marc-plnnr = v_plnnr.
        wa_marc-aplal = v_aplal.
        wa_marc-losgr = v_losgr.
        wa_marc-sobsk = v_sobsk.
        wa_marc-frtme = v_frtme.
        wa_marc-lgpro = v_lgpro.
        wa_marc-disgr = v_disgr.
        wa_marc-kausf = v_kausf.
        wa_marc-qzgtp = v_qzgtp.
        wa_marc-qmatv = v_qmatv.
        wa_marc-takzt = v_takzt.
        wa_marc-rwpro = v_rwpro.
        wa_marc-copam = v_copam.
        wa_marc-abcin = v_abcin.
        wa_marc-awsls = v_awsls.
        wa_marc-sernp = v_sernp.
        wa_marc-cuobj = v_cuobj.
        wa_marc-stdpd = v_stdpd.
        wa_marc-sfepr = v_sfepr.
        wa_marc-xmcng = v_xmcng.
        wa_marc-qssys = v_qssys.
        wa_marc-lfrhy = v_lfrhy.
        wa_marc-rdprf = v_rdprf.
        wa_marc-vrbmt = v_vrbmt.
        wa_marc-vrbwk = v_vrbwk.
        wa_marc-vrbdt = v_vrbdt.
        wa_marc-vrbfk = v_vrbfk.
        wa_marc-autru = v_autru.
        wa_marc-prefe = v_prefe.
        wa_marc-prenc = v_prenc.
        wa_marc-preno = v_preno.
        wa_marc-prend = v_prend.
        wa_marc-prene = v_prene.
        wa_marc-preng = v_preng.
        wa_marc-itark = v_itark.
        wa_marc-servg = v_servg.
        wa_marc-kzkup = v_kzkup.
        wa_marc-strgr = v_strgr.
        wa_marc-cuobv = v_cuobv.
        wa_marc-lgfsb = v_lgfsb.
        wa_marc-schgt = v_schgt.
        wa_marc-ccfix = v_ccfix.
        wa_marc-eprio = v_eprio.
        wa_marc-qmata = v_qmata.
        wa_marc-resvp = v_resvp.
        wa_marc-plnty = v_plnty.
        wa_marc-uomgr = v_uomgr.
        wa_marc-umrsl = v_umrsl.
        wa_marc-abfac = v_abfac.
        wa_marc-sfcpf = v_sfcpf.
        wa_marc-shflg = v_shflg.
        wa_marc-shzet = v_shzet.
        wa_marc-mdach = v_mdach.
        wa_marc-kzech = v_kzech.
        wa_marc-megru = v_megru.
        wa_marc-mfrgr = v_mfrgr.
        wa_marc-vkumc = v_vkumc.
        wa_marc-vktrw = v_vktrw.
        wa_marc-kzagl = v_kzagl.
        wa_marc-fvidk = v_fvidk.
        wa_marc-fxpru = v_fxpru.
        wa_marc-loggr = v_loggr.
        wa_marc-fprfm = v_fprfm.
        wa_marc-glgmg = v_glgmg.
        wa_marc-vkglg = v_vkglg.
        wa_marc-indus = v_indus.
        wa_marc-mownr = v_mownr.
        wa_marc-mogru = v_mogru.
        wa_marc-casnr = v_casnr.
        wa_marc-gpnum = v_gpnum.
        wa_marc-steuc = v_steuc.
        wa_marc-fabkz = v_fabkz.
        wa_marc-matgr = v_matgr.
        wa_marc-vspvb = v_vspvb.
        wa_marc-dplfs = v_dplfs.
        wa_marc-dplpu = v_dplpu.
        wa_marc-dplho = v_dplho.
        wa_marc-minls = v_minls.
        wa_marc-maxls = v_maxls.
        wa_marc-fixls = v_fixls.
        wa_marc-ltinc = v_ltinc.
        wa_marc-compl = v_compl.
        wa_marc-convt = v_convt.
        wa_marc-shpro = v_shpro.
        wa_marc-ahdis = v_ahdis.
        wa_marc-diber = v_diber.
        wa_marc-kzpsp = v_kzpsp.
        wa_marc-ocmpf = v_ocmpf.
        wa_marc-mcrue = v_mcrue.
        wa_marc-lfmon = v_lfmon.
        wa_marc-lfgja = v_lfgja.
        wa_marc-eislo = v_eislo.
        wa_marc-ncost = v_ncost.
        wa_marc-bwesb = v_bwesb.
        wa_marc-/cmd/mb_lftag   = v_cmdmb_lftag.
        wa_marc-/cmd/mb_sitag   = v_cmdmb_sitag.
        wa_marc-/cmd/mb_gestg   = v_cmdmb_gestg.
        wa_marc-/cmd/mb_maxlg   = v_cmdmb_maxlg.
        wa_marc-/cmd/mb_faker   = v_cmdmb_faker.
        wa_marc-/cmd/mb_aschl   = v_cmdmb_aschl.
        wa_marc-/sapmp/tolprpl  = v_sapmptolprpl.
        wa_marc-/sapmp/tolprmi  = v_sapmptolprmi.
        wa_marc-/vso/r_pkgrp    = v_vsor_pkgrp.
        wa_marc-/vso/r_lane_num = v_vsor_lane_num.
        wa_marc-/vso/r_pal_vend = v_vsor_pal_vend.
        wa_marc-/vso/r_fork_dir = v_vsor_fork_dir.
        wa_marc-gi_pr_time = v_gi_pr_time.
        wa_marc-multiple_ekgrp = v_multiple_ekgrp.
        wa_marc-ref_schema = v_ref_schema.
        wa_marc-min_troc = v_min_troc.
        wa_marc-max_troc = v_max_troc.
        wa_marc-target_stock = v_target_stock.
        wa_marc-zzeires = v_zzeires.
        wa_marc-zzlftag = v_zzlftag.
        wa_marc-zzsitag = v_zzsitag.
        wa_marc-zzgestg = v_zzgestg.
        wa_marc-zzmaxlg = v_zzmaxlg.
        wa_marc-zzfaker = v_zzfaker.
        wa_marc-zzaschl = v_zzaschl.
        wa_marc-zzlfspme = v_zzlfspme.
        wa_marc-zzaltmn = v_zzaltmn.
        wa_marc-zzgema = v_zzgema.
        wa_marc-zzuhg = v_zzuhg .
        wa_marc-zzek1 = v_zzek1.
        wa_marc-zzek2 = v_zzek2.
        wa_marc-zzek5 = v_zzek5.
        wa_marc-zzek6 = v_zzek6.
        wa_marc-zzstcode_i = v_zzstcode_i.
        wa_marc-zzstcode_e = v_zzstcode_e.
        wa_marc-zzek5_aufschlag = v_zzek5_aufschlag.
        wa_marc-zzek1_aufschlag = v_zzek1_aufschlag.
        wa_marc-zzek5_abschlag = v_zzek5_abschlag.
        wa_marc-zzpreis_b = v_zzpreis_b.
        wa_marc-zzmhd = v_zzmhd.
        wa_marc-mandt = sy-mandt.
        wa_marc-mmstd = v_mmstd+6(4) && v_mmstd+3(2) && v_mmstd+0(2).

        "Converte o campo MATNR e adiciona zeros, conforme o tamanho do MATNR no ambiente
        CALL FUNCTION 'CONVERSION_EXIT_MATN1_INPUT'
          EXPORTING
            input        = wa_marc-matnr
          IMPORTING
            output       = wa_marc-matnr
          EXCEPTIONS
            length_error = 1
            OTHERS       = 2.

        APPEND wa_marc TO me->it_marc.
        CLEAR wa_marc.
      ENDIF.
    ENDLOOP.
    me->modify_marc( ).
  ENDMETHOD.

  "Faz modify na tabela MARC
  METHOD modify_marc.

    DATA: o_cl_mig_marc_util TYPE REF TO zcl_mig_marc_util.

    CREATE OBJECT o_cl_mig_marc_util.

    LOOP AT it_marc INTO DATA(wa_marc).
*        MODIFY marc FROM wa_marc.

*         INSERT zmarc FROM wa_marc.

*          IF sy-subrc = 0.
*            COMMIT WORK.
*          ELSE.
*            ROLLBACK WORK.
*          ENDIF.

    TRY .
      "Método que faz o insert na MARC
      CALL METHOD zcl_mig_marc_util=>insert_marc_single
        EXPORTING
          iv_mandt                  = wa_marc-mandt
          iv_matnr                  = wa_marc-matnr
          iv_werks                  = wa_marc-werks
          iv_pstat                  = wa_marc-pstat
          iv_lvorm                  = wa_marc-lvorm
          iv_bwtty                  = wa_marc-bwtty
          iv_xchar                  = wa_marc-xchar
          iv_mmsta                  = wa_marc-mmsta
          iv_mmstd                  = wa_marc-mmstd
          iv_maabc                  = wa_marc-maabc
          iv_kzkri                  = wa_marc-kzkri
          iv_ekgrp                  = wa_marc-ekgrp
          iv_ausme                  = wa_marc-ausme
          iv_dispr                  = wa_marc-dispr
          iv_dismm                  = wa_marc-dismm
          iv_dispo                  = wa_marc-dispo
          iv_kzdie                  = wa_marc-kzdie
          iv_plifz                  = wa_marc-plifz
          iv_webaz                  = wa_marc-webaz
          iv_perkz                  = wa_marc-perkz
          iv_ausss                  = wa_marc-ausss
          iv_disls                  = wa_marc-disls
          iv_beskz                  = wa_marc-beskz
          iv_sobsl                  = wa_marc-sobsl
          iv_minbe                  = wa_marc-minbe
          iv_eisbe                  = wa_marc-eisbe
          iv_bstmi                  = wa_marc-bstmi
          iv_bstma                  = wa_marc-bstma
          iv_bstfe                  = wa_marc-bstfe
          iv_bstrf                  = wa_marc-bstrf
          iv_mabst                  = wa_marc-mabst
          iv_losfx                  = wa_marc-losfx
          iv_sbdkz                  = wa_marc-sbdkz
          iv_lagpr                  = wa_marc-lagpr
          iv_altsl                  = wa_marc-altsl
          iv_kzaus                  = wa_marc-kzaus
          iv_ausdt                  = wa_marc-ausdt
          iv_nfmat                  = wa_marc-nfmat
          iv_kzbed                  = wa_marc-kzbed
          iv_miskz                  = wa_marc-miskz
          iv_fhori                  = wa_marc-fhori
          iv_pfrei                  = wa_marc-pfrei
          iv_ffrei                  = wa_marc-ffrei
          iv_rgekz                  = wa_marc-rgekz
          iv_fevor                  = wa_marc-fevor
          iv_bearz                  = wa_marc-bearz
          iv_ruezt                  = wa_marc-ruezt
          iv_tranz                  = wa_marc-tranz
          iv_basmg                  = wa_marc-basmg
          iv_dzeit                  = wa_marc-dzeit
          iv_maxlz                  = wa_marc-maxlz
          iv_lzeih                  = wa_marc-lzeih
          iv_kzpro                  = wa_marc-kzpro
          iv_gpmkz                  = wa_marc-gpmkz
          iv_ueeto                  = wa_marc-ueeto
          iv_ueetk                  = wa_marc-ueetk
          iv_uneto                  = wa_marc-uneto
          iv_wzeit                  = wa_marc-wzeit
          iv_atpkz                  = wa_marc-atpkz
          iv_vzusl                  = wa_marc-vzusl
          iv_herbl                  = wa_marc-herbl
          iv_insmk                  = wa_marc-insmk
          iv_sproz                  = wa_marc-sproz
          iv_quazt                  = wa_marc-quazt
          iv_ssqss                  = wa_marc-ssqss
          iv_mpdau                  = wa_marc-mpdau
          iv_kzppv                  = wa_marc-kzppv
          iv_kzdkz                  = wa_marc-kzdkz
          iv_wstgh                  = wa_marc-wstgh
          iv_prfrq                  = wa_marc-prfrq
          iv_nkmpr                  = wa_marc-nkmpr
          iv_umlmc                  = wa_marc-umlmc
          iv_ladgr                  = wa_marc-ladgr
          iv_xchpf                  = wa_marc-xchpf
          iv_usequ                  = wa_marc-usequ
          iv_lgrad                  = wa_marc-lgrad
          iv_auftl                  = wa_marc-auftl
          iv_plvar                  = wa_marc-plvar
          iv_otype                  = wa_marc-otype
          iv_objid                  = wa_marc-objid
          iv_mtvfp                  = wa_marc-mtvfp
          iv_periv                  = wa_marc-periv
          iv_kzkfk                  = wa_marc-kzkfk
          iv_vrvez                  = wa_marc-vrvez
          iv_vbamg                  = wa_marc-vbamg
          iv_vbeaz                  = wa_marc-vbeaz
          iv_lizyk                  = wa_marc-lizyk
          iv_bwscl                  = wa_marc-bwscl
          iv_kautb                  = wa_marc-kautb
          iv_kordb                  = wa_marc-kordb
          iv_stawn                  = wa_marc-stawn
          iv_herkl                  = wa_marc-herkl
          iv_herkr                  = wa_marc-herkr
          iv_expme                  = wa_marc-expme
          iv_mtver                  = wa_marc-mtver
          iv_prctr                  = wa_marc-prctr
          iv_trame                  = wa_marc-trame
          iv_mrppp                  = wa_marc-mrppp
          iv_sauft                  = wa_marc-sauft
          iv_fxhor                  = wa_marc-fxhor
          iv_vrmod                  = wa_marc-vrmod
          iv_vint1                  = wa_marc-vint1
          iv_vint2                  = wa_marc-vint2
          iv_verkz                  = wa_marc-verkz
          iv_stlal                  = wa_marc-stlal
          iv_stlan                  = wa_marc-stlan
          iv_plnnr                  = wa_marc-plnnr
          iv_aplal                  = wa_marc-aplal
          iv_losgr                  = wa_marc-losgr
          iv_sobsk                  = wa_marc-sobsk
          iv_frtme                  = wa_marc-frtme
          iv_lgpro                  = wa_marc-lgpro
          iv_disgr                  = wa_marc-disgr
          iv_kausf                  = wa_marc-kausf
          iv_qzgtp                  = wa_marc-qzgtp
          iv_qmatv                  = wa_marc-qmatv
          iv_takzt                  = wa_marc-takzt
          iv_rwpro                  = wa_marc-rwpro
          iv_copam                  = wa_marc-copam
          iv_abcin                  = wa_marc-abcin
          iv_awsls                  = wa_marc-awsls
          iv_sernp                  = wa_marc-sernp
          iv_cuobj                  = wa_marc-cuobj
          iv_stdpd                  = wa_marc-stdpd
          iv_sfepr                  = wa_marc-sfepr
          iv_xmcng                  = wa_marc-xmcng
          iv_qssys                  = wa_marc-qssys
          iv_lfrhy                  = wa_marc-lfrhy
          iv_rdprf                  = wa_marc-rdprf
          iv_vrbmt                  = wa_marc-vrbmt
          iv_vrbwk                  = wa_marc-vrbwk
          iv_vrbdt                  = wa_marc-vrbdt
          iv_vrbfk                  = wa_marc-vrbfk
          iv_autru                  = wa_marc-autru
          iv_prefe                  = wa_marc-prefe
          iv_prenc                  = wa_marc-prenc
          iv_preno                  = wa_marc-preno
          iv_prend                  = wa_marc-prend
          iv_prene                  = wa_marc-prene
          iv_preng                  = wa_marc-preng
          iv_itark                  = wa_marc-itark
          iv_servg                  = wa_marc-servg
          iv_kzkup                  = wa_marc-kzkup
          iv_strgr                  = wa_marc-strgr
          iv_cuobv                  = wa_marc-cuobv
          iv_lgfsb                  = wa_marc-lgfsb
          iv_schgt                  = wa_marc-schgt
          iv_ccfix                  = wa_marc-ccfix
          iv_eprio                  = wa_marc-eprio
          iv_qmata                  = wa_marc-qmata
          iv_resvp                  = wa_marc-resvp
          iv_plnty                  = wa_marc-plnty
          iv_uomgr                  = wa_marc-uomgr
          iv_umrsl                  = wa_marc-umrsl
          iv_abfac                  = wa_marc-abfac
          iv_sfcpf                  = wa_marc-sfcpf
          iv_shflg                  = wa_marc-shflg
          iv_shzet                  = wa_marc-shzet
          iv_mdach                  = wa_marc-mdach
          iv_kzech                  = wa_marc-kzech
          iv_megru                  = wa_marc-megru
          iv_mfrgr                  = wa_marc-mfrgr
          iv_sfty_stk_meth          = wa_marc-sfty_stk_meth
          iv_profil                 = wa_marc-profil
          iv_vkumc                  = wa_marc-vkumc
          iv_vktrw                  = wa_marc-vktrw
          iv_kzagl                  = wa_marc-kzagl
          iv_fvidk                  = wa_marc-fvidk
          iv_fxpru                  = wa_marc-fxpru
          iv_loggr                  = wa_marc-loggr
          iv_fprfm                  = wa_marc-fprfm
          iv_glgmg                  = wa_marc-glgmg
          iv_vkglg                  = wa_marc-vkglg
          iv_indus                  = wa_marc-indus
          iv_mownr                  = wa_marc-mownr
          iv_mogru                  = wa_marc-mogru
          iv_casnr                  = wa_marc-casnr
          iv_gpnum                  = wa_marc-gpnum
          iv_steuc                  = wa_marc-steuc
          iv_fabkz                  = wa_marc-fabkz
          iv_matgr                  = wa_marc-matgr
          iv_vspvb                  = wa_marc-vspvb
          iv_dplfs                  = wa_marc-dplfs
          iv_dplpu                  = wa_marc-dplpu
          iv_dplho                  = wa_marc-dplho
          iv_minls                  = wa_marc-minls
          iv_maxls                  = wa_marc-maxls
          iv_fixls                  = wa_marc-fixls
          iv_ltinc                  = wa_marc-ltinc
          iv_compl                  = wa_marc-compl
          iv_convt                  = wa_marc-convt
          iv_shpro                  = wa_marc-shpro
          iv_ahdis                  = wa_marc-ahdis
          iv_diber                  = wa_marc-diber
          iv_kzpsp                  = wa_marc-kzpsp
          iv_ocmpf                  = wa_marc-ocmpf
          iv_apokz                  = wa_marc-apokz
          iv_mcrue                  = wa_marc-mcrue
          iv_lfmon                  = wa_marc-lfmon
          iv_lfgja                  = wa_marc-lfgja
          iv_eislo                  = wa_marc-eislo
          iv_ncost                  = wa_marc-ncost
          iv_rotation_date          = wa_marc-rotation_date
          iv_uchkz                  = wa_marc-uchkz
          iv_ucmat                  = wa_marc-ucmat
          iv_excise_tax_rlvnce      = wa_marc-excise_tax_rlvnce
          iv_temp_ctrl_max          = wa_marc-temp_ctrl_max
          iv_temp_ctrl_min          = wa_marc-temp_ctrl_min
          iv_temp_uom               = wa_marc-temp_uom
          iv_jitprodnconfprofile    = wa_marc-jitprodnconfprofile
          iv_bwesb                  = wa_marc-bwesb
          iv_sgt_covs               = wa_marc-sgt_covs
          iv_sgt_statc              = wa_marc-sgt_statc
          iv_sgt_scope              = wa_marc-sgt_scope
          iv_sgt_mrpsi              = wa_marc-sgt_mrpsi
          iv_sgt_prcm               = wa_marc-sgt_prcm
          iv_sgt_chint              = wa_marc-sgt_chint
          iv_sgt_stk_prt            = wa_marc-sgt_stk_prt
          iv_sgt_defsc              = wa_marc-sgt_defsc
          iv_sgt_mrp_atp_status     = wa_marc-sgt_mrp_atp_status
          iv_sgt_mmstd              = wa_marc-sgt_mmstd
          iv_fsh_mg_arun_req        = wa_marc-fsh_mg_arun_req
          iv_fsh_seaim              = wa_marc-fsh_seaim
          iv_fsh_var_group          = wa_marc-fsh_var_group
          iv_fsh_kzech              = wa_marc-fsh_kzech
          iv_fsh_calendar_group     = wa_marc-fsh_calendar_group
          iv_arun_fix_batch         = wa_marc-arun_fix_batch
          iv_ppskz                  = wa_marc-ppskz
          iv_cons_procg             = wa_marc-cons_procg
          iv_gi_pr_time             = wa_marc-gi_pr_time
          iv_multiple_ekgrp         = wa_marc-multiple_ekgrp
          iv_ref_schema             = wa_marc-ref_schema
          iv_min_troc               = wa_marc-min_troc
          iv_max_troc               = wa_marc-max_troc
          iv_target_stock           = wa_marc-target_stock
          iv_nf_flag                = wa_marc-nf_flag
          iv_cwm_umlmc              = wa_marc-/cwm/umlmc
          iv_cwm_trame              = wa_marc-/cwm/trame
          iv_cwm_bwesb              = wa_marc-/cwm/bwesb
          iv_scm_matlocid_guid16    = wa_marc-scm_matlocid_guid16
          iv_scm_matlocid_guid22    = wa_marc-scm_matlocid_guid22
          iv_scm_grprt              = wa_marc-scm_grprt
          iv_scm_giprt              = wa_marc-scm_giprt
          iv_scm_scost              = wa_marc-scm_scost
          iv_scm_reldt              = wa_marc-scm_reldt
          iv_scm_rrp_type           = wa_marc-scm_rrp_type
          iv_scm_heur_id            = wa_marc-scm_heur_id
          iv_scm_package_id         = wa_marc-scm_package_id
          iv_scm_sspen              = wa_marc-scm_sspen
          iv_scm_get_alerts         = wa_marc-scm_get_alerts
          iv_scm_res_net_name       = wa_marc-scm_res_net_name
          iv_scm_conhap             = wa_marc-scm_conhap
          iv_scm_hunit              = wa_marc-scm_hunit
          iv_scm_conhap_out         = wa_marc-scm_conhap_out
          iv_scm_hunit_out          = wa_marc-scm_hunit_out
          iv_scm_shelf_life_loc     = wa_marc-scm_shelf_life_loc
          iv_scm_shelf_life_dur     = wa_marc-scm_shelf_life_dur
          iv_scm_maturity_dur       = wa_marc-scm_maturity_dur
          iv_scm_shlf_lfe_req_min   = wa_marc-scm_shlf_lfe_req_min
          iv_scm_shlf_lfe_req_max   = wa_marc-scm_shlf_lfe_req_max
          iv_scm_lsuom              = wa_marc-scm_lsuom
          iv_scm_reord_dur          = wa_marc-scm_reord_dur
          iv_scm_target_dur         = wa_marc-scm_target_dur
          iv_scm_tstrid             = wa_marc-scm_tstrid
          iv_scm_stra1              = wa_marc-scm_stra1
          iv_scm_peg_past_alert     = wa_marc-scm_peg_past_alert
          iv_scm_peg_future_alert   = wa_marc-scm_peg_future_alert
          iv_scm_peg_strategy       = wa_marc-scm_peg_strategy
          iv_scm_peg_wo_alert_fst   = wa_marc-scm_peg_wo_alert_fst
          iv_scm_fixpeg_prod_set    = wa_marc-scm_fixpeg_prod_set
          iv_scm_whatbom            = wa_marc-scm_whatbom
          iv_scm_rrp_sel_group      = wa_marc-scm_rrp_sel_group
          iv_scm_intsrc_prof        = wa_marc-scm_intsrc_prof
          iv_scm_prio               = wa_marc-scm_prio
          iv_scm_min_pass_amount    = wa_marc-scm_min_pass_amount
          iv_scm_profid             = wa_marc-scm_profid
          iv_scm_ges_mng_use        = wa_marc-scm_ges_mng_use
          iv_scm_ges_bst_use        = wa_marc-scm_ges_bst_use
          iv_esppflg                = wa_marc-esppflg
          iv_scm_thruput_time       = wa_marc-scm_thruput_time
          iv_scm_tpop               = wa_marc-scm_tpop
          iv_scm_safty_v            = wa_marc-scm_safty_v
          iv_scm_ppsaftystk         = wa_marc-scm_ppsaftystk
          iv_scm_ppsaftystk_v       = wa_marc-scm_ppsaftystk_v
          iv_scm_repsafty           = wa_marc-scm_repsafty
          iv_scm_repsafty_v         = wa_marc-scm_repsafty_v
          iv_scm_reord_v            = wa_marc-scm_reord_v
          iv_scm_maxstock_v         = wa_marc-scm_maxstock_v
          iv_scm_scost_prcnt        = wa_marc-scm_scost_prcnt
          iv_scm_proc_cost          = wa_marc-scm_proc_cost
          iv_scm_ndcostwe           = wa_marc-scm_ndcostwe
          iv_scm_ndcostwa           = wa_marc-scm_ndcostwa
          iv_scm_coninp             = wa_marc-scm_coninp
          iv_conf_gmsync            = wa_marc-conf_gmsync
          iv_scm_iunit              = wa_marc-scm_iunit
          iv_scm_sft_lock           = wa_marc-scm_sft_lock
          iv_dummy_plnt_incl_eew_ps = wa_marc-dummy_plnt_incl_eew_ps
          iv_cmd_mb_eires           = wa_marc-/cmd/mb_eires
          iv_cmd_mb_lftag           = wa_marc-/cmd/mb_lftag
          iv_cmd_mb_sitag           = wa_marc-/cmd/mb_sitag
          iv_cmd_mb_gestg           = wa_marc-/cmd/mb_gestg
          iv_cmd_mb_maxlg           = wa_marc-/cmd/mb_maxlg
          iv_cmd_mb_faker           = wa_marc-/cmd/mb_faker
          iv_cmd_mb_aschl           = wa_marc-/cmd/mb_aschl
          iv_sapmp_tolprpl          = wa_marc-/sapmp/tolprpl
          iv_sapmp_tolprmi          = wa_marc-/sapmp/tolprmi
          iv_sttpec_servalid        = wa_marc-/sttpec/servalid
          iv_vso_r_pkgrp            = wa_marc-/vso/r_pkgrp
          iv_vso_r_lane_num         = wa_marc-/vso/r_lane_num
          iv_vso_r_pal_vend         = wa_marc-/vso/r_pal_vend
          iv_vso_r_fork_dir         = wa_marc-/vso/r_fork_dir
          iv_iuid_relevant          = wa_marc-iuid_relevant
          iv_iuid_type              = wa_marc-iuid_type
          iv_uid_iea                = wa_marc-uid_iea
          iv_dpcbt                  = wa_marc-dpcbt
          iv_zzeires                = wa_marc-zzeires
          iv_zzlftag                = wa_marc-zzlftag
          iv_zzsitag                = wa_marc-zzsitag
          iv_zzgestg                = wa_marc-zzgestg
          iv_zzmaxlg                = wa_marc-zzmaxlg
          iv_zzfaker                = wa_marc-zzfaker
          iv_zzaschl                = wa_marc-zzaschl
          iv_zzlfspme               = wa_marc-zzlfspme
          iv_zzaltmn                = wa_marc-zzaltmn
          iv_zzgema                 = wa_marc-zzgema
          iv_zzuhg                  = wa_marc-zzuhg
          iv_zzek1                  = wa_marc-zzek1
          iv_zzek2                  = wa_marc-zzek2
          iv_zzek5                  = wa_marc-zzek5
          iv_zzek6                  = wa_marc-zzek6
          iv_zzstcode_i             = wa_marc-zzstcode_i
          iv_zzstcode_e             = wa_marc-zzstcode_e
          iv_zzek5_aufschlag        = wa_marc-zzek5_aufschlag
          iv_zzek1_aufschlag        = wa_marc-zzek1_aufschlag
          iv_zzek5_abschlag         = wa_marc-zzek5_abschlag
          iv_zzpreis_b              = wa_marc-zzpreis_b
          iv_zzmhd                  = wa_marc-zzmhd.

          WRITE:/ wa_marc-mandt ,',', wa_marc-matnr ,',', wa_marc-werks, ',Sucesso!'.
    CATCH cx_root.
          WRITE:/ wa_marc-mandt ,',', wa_marc-matnr ,',', wa_marc-werks, ',Erro!'.
    ENDTRY.

    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
