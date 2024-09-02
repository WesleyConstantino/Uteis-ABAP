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
      DATA: wa_marc TYPE marc,
            v_plifz(40) TYPE c,
            v_perkz(40) TYPE c,
            v_ausss(40) TYPE c,
            v_webaz(40) TYPE c,
            v_minbe(40) TYPE c,
            v_eisbe(40) TYPE c,
            v_bstmi(40) TYPE c,
            v_bstma(40) TYPE c,
            v_bstfe(40) TYPE c,
            v_bstrf(40) TYPE c,
            v_losfx(40) TYPE c,
            v_mabst(40) TYPE c,
            v_bearz(40) TYPE c,
            v_ruezt(40) TYPE c,
            v_tranz(40) TYPE c,
            v_basmg(40) TYPE c,
            v_dzeit(40) TYPE c,
            v_maxlz(40) TYPE c,
            v_lzeih(40) TYPE c,
            v_kzpro(40) TYPE c,
            v_gpmkz(40) TYPE c,
            v_ueeto(40) TYPE c,
            v_ueetk(40) TYPE c,
            v_uneto(40) TYPE c,
            v_wzeit(40) TYPE c,
            v_atpkz(40) TYPE c,
            v_vzusl(40) TYPE c,
            v_herbl(40) TYPE c,
            v_insmk(40) TYPE c,
            v_sproz(40) TYPE c,
            v_quazt(40) TYPE c,
            v_ssqss(40) TYPE c,
            v_mpdau(40) TYPE c,
            v_kzppv(40) TYPE c,
            v_kzdkz(40) TYPE c,
            v_wstgh(40) TYPE c,
            v_prfrq(40) TYPE c,
            v_nkmpr(40) TYPE c,
            v_umlmc(40) TYPE c,
            v_ladgr(40) TYPE c,
            v_xchpf(40) TYPE c,
            v_usequ(40) TYPE c,
            v_lgrad(40) TYPE c,
            v_auftl(40) TYPE c,
            v_plvar(40) TYPE c,
            v_otype(40) TYPE c,
            v_objid(40) TYPE c,
            v_mtvfp(40) TYPE c,
            v_periv(40) TYPE c,
            v_kzkfk(40) TYPE c,
            v_vrvez(40) TYPE c,
            v_vbamg(40) TYPE c,
            v_vbeaz(40) TYPE c,
            v_lizyk(40) TYPE c,
            v_bwscl(40) TYPE c,
            v_kautb(40) TYPE c,
            v_kordb(40) TYPE c,
            v_stawn(40) TYPE c,
            v_herkl(40) TYPE c,
            v_herkr(40) TYPE c,
            v_expme(40) TYPE c,
            v_mtver(40) TYPE c,
            v_prctr(40) TYPE c,
            v_trame(40) TYPE c,
            v_mrppp(40) TYPE c,
            v_sauft(40) TYPE c,
            v_fxhor(40) TYPE c,
            v_vrmod(40) TYPE c,
            v_vint1(40) TYPE c,
            v_vint2(40) TYPE c,
            v_verkz(40) TYPE c,
            v_stlal(40) TYPE c,
            v_stlan(40) TYPE c,
            v_plnnr(40) TYPE c,
            v_aplal(40) TYPE c,
            v_losgr(40) TYPE c,
            v_sobsk(40) TYPE c,
            v_frtme(40) TYPE c,
            v_lgpro(40) TYPE c,
            v_disgr(40) TYPE c,
            v_kausf(40) TYPE c,
            v_qzgtp(40) TYPE c,
            v_qmatv(40) TYPE c,
            v_takzt(40) TYPE c,
            v_rwpro(40) TYPE c,
            v_copam(40) TYPE c,
            v_abcin(40) TYPE c,
            v_awsls(40) TYPE c,
            v_sernp(40) TYPE c,
            v_cuobj(40) TYPE c,
            v_stdpd(40) TYPE c,
            v_sfepr(40) TYPE c,
            v_xmcng(40) TYPE c,
            v_qssys(40) TYPE c,
            v_lfrhy(40) TYPE c,
            v_rdprf(40) TYPE c,
            v_vrbmt(40) TYPE c,
            v_vrbwk(40) TYPE c,
            v_vrbdt(40) TYPE c,
            v_vrbfk(40) TYPE c,
            v_autru(40) TYPE c,
            v_prefe(40) TYPE c,
            v_prenc(40) TYPE c,
            v_preno(40) TYPE c,
            v_prend(40) TYPE c,
            v_prene(40) TYPE c,
            v_preng(40) TYPE c,
            v_itark(40) TYPE c,
            v_servg(40) TYPE c,
            v_kzkup(40) TYPE c,
            v_strgr(40) TYPE c,
            v_cuobv(40) TYPE c,
            v_lgfsb(40) TYPE c,
            v_schgt(40) TYPE c,
            v_ccfix(40) TYPE c,
            v_eprio(40) TYPE c,
            v_qmata(40) TYPE c,
            v_resvp(40) TYPE c,
            v_plnty(40) TYPE c,
            v_uomgr(40) TYPE c,
            v_umrsl(40) TYPE c,
            v_abfac(40) TYPE c,
            v_sfcpf(40) TYPE c,
            v_shflg(40) TYPE c,
            v_shzet(40) TYPE c,
            v_mdach(40) TYPE c,
            v_kzech(40) TYPE c,
            v_megru(40) TYPE c,
            v_mfrgr(40) TYPE c,
            v_vkumc(40) TYPE c,
            v_vktrw(40) TYPE c,
            v_kzagl(40) TYPE c,
            v_fvidk(40) TYPE c,
            v_fxpru(40) TYPE c,
            v_loggr(40) TYPE c,
            v_fprfm(40) TYPE c,
            v_glgmg(40) TYPE c,
            v_vkglg(40) TYPE c,
            v_indus(40) TYPE c,
            v_mownr(40) TYPE c,
            v_mogru(40) TYPE c,
            v_casnr(40) TYPE c,
            v_gpnum(40) TYPE c,
            v_steuc(40) TYPE c,
            v_fabkz(40) TYPE c,
            v_matgr(40) TYPE c,
            v_vspvb(40) TYPE c,
            v_dplfs(40) TYPE c,
            v_dplpu(40) TYPE c,
            v_dplho(40) TYPE c,
            v_minls(40) TYPE c,
            v_maxls(40) TYPE c,
            v_fixls(40) TYPE c,
            v_ltinc(40) TYPE c,
            v_compl(40) TYPE c,
            v_convt(40) TYPE c,
            v_shpro(40) TYPE c,
            v_ahdis(40) TYPE c,
            v_diber(40) TYPE c,
            v_kzpsp(40) TYPE c,
            v_ocmpf(40) TYPE c,
            v_mcrue(40) TYPE c,
            v_lfmon(40) TYPE c,
            v_lfgja(40) TYPE c,
            v_eislo(40) TYPE c,
            v_bwesb(40) TYPE c,
            v_ncost(40) TYPE c,
            v_apokz(40) TYPE c,
            v_cmdmb_eires(40)   TYPE c,
            v_cmdmb_lftag(40)   TYPE c,
            v_cmdmb_sitag(40)   TYPE c,
            v_cmdmb_gestg(40)  TYPE c,
            v_cmdmb_maxlg(40)   TYPE c,
            v_cmdmb_faker(40)   TYPE c,
            v_cmdmb_aschl(40)   TYPE c,
            v_sapmptolprpl(40)  TYPE c,
            v_sapmptolprmi(40)  TYPE c,
            v_vsor_pkgrp(40)    TYPE c,
            v_vsor_lane_num(40) TYPE c,
            v_vsor_pal_vend(40) TYPE c,
            v_vsor_fork_dir(40) TYPE c,
            v_gi_pr_time(40)      TYPE c,
            v_multiple_ekgrp(40)  TYPE c,
            v_ref_schema(40)      TYPE c,
            v_min_troc(40)        TYPE c,
            v_max_troc(40)        TYPE c,
            v_target_stock(40)    TYPE c,
            v_zzeires(40)         TYPE c,
            v_zzlftag(40)         TYPE c,
            v_zzsitag(40)         TYPE c,
            v_zzgestg(40)         TYPE c,
            v_zzmaxlg(40)         TYPE c,
            v_zzfaker(40)         TYPE c,
            v_zzaschl(40)         TYPE c,
            v_zzlfspme(40)        TYPE c,
            v_zzaltmn(40)         TYPE c,
            v_zzgema(40)          TYPE c,
            v_zzuhg(40)           TYPE c,
            v_zzek1(40)           TYPE c,
            v_zzek2(40)           TYPE c,
            v_zzek5(40)           TYPE c,
            v_zzek6(40)           TYPE c,
            v_zzstcode_i(40)      TYPE c,
            v_zzstcode_e(40)      TYPE c,
            v_zzek5_aufschlag(1) TYPE c,
            v_zzek1_aufschlag(1) TYPE c,
            v_zzek5_abschlag(1)  TYPE c,
            v_zzpreis_b(1)       TYPE c,
            v_mmstd(5)       TYPE c,
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
         wa_marc-mmstd = v_mmstd.
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

         APPEND wa_marc TO me->it_marc.
         CLEAR wa_marc.
        ENDIF.
      ENDLOOP.
      me->modify_marc( ).
    ENDMETHOD.

    "Faz modify na tabela MARC
    METHOD modify_marc.
      LOOP AT it_marc INTO DATA(wa_marc).
*        MODIFY marc FROM wa_marc.

         INSERT zmarc FROM wa_marc.

          IF sy-subrc = 0.
            COMMIT WORK.
          ELSE.
            ROLLBACK WORK.
          ENDIF.

     ENDLOOP.
    ENDMETHOD.

ENDCLASS.
