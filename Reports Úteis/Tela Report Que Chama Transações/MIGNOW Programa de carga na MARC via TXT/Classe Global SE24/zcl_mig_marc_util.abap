*Obs: essa classe acessa o banco de dados direto via SQL Script, sendo assim, só podemos ativá-la pelo Eclipse.
CLASS zcl_mig_marc_util DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.

    DATA: t_marc TYPE TABLE OF marc.

    "Essa interface nos permite fazer operações no banco de dados via linguagem SQL nativa
    INTERFACES: if_amdp_marker_hdb.


    "Update na MARC
    CLASS-METHODS update_marc_valifrom_single
      IMPORTING
        VALUE(iv_mandt)                  TYPE mandt
        VALUE(iv_matnr)                  TYPE matnr
        VALUE(iv_werks)                  TYPE werks_d
        VALUE(iv_mmstd)                  TYPE mmstd.

    *Delete na MARC
    CLASS-METHODS delete_marc_single
      IMPORTING
        VALUE(iv_mandt)                  TYPE mandt
        VALUE(iv_matnr)                  TYPE matnr
        VALUE(iv_werks)                  TYPE werks_d.

    "Insert na MARC
    CLASS-METHODS insert_marc_single
      IMPORTING
        VALUE(iv_mandt)                  TYPE mandt
        VALUE(iv_matnr)                  TYPE matnr
        VALUE(iv_werks)                  TYPE werks_d
        VALUE(iv_pstat)                  TYPE pstat_d
        VALUE(iv_lvorm)                  TYPE lvowk
        VALUE(iv_bwtty)                  TYPE bwtty_d
        VALUE(iv_xchar)                  TYPE xchar
        VALUE(iv_mmsta)                  TYPE mmsta
        VALUE(iv_mmstd)                  TYPE mmstd
        VALUE(iv_maabc)                  TYPE maabc
        VALUE(iv_kzkri)                  TYPE kzkri
        VALUE(iv_ekgrp)                  TYPE ekgrp
        VALUE(iv_ausme)                  TYPE ausme
        VALUE(iv_dispr)                  TYPE dispr
        VALUE(iv_dismm)                  TYPE dismm
        VALUE(iv_dispo)                  TYPE dispo
        VALUE(iv_kzdie)                  TYPE kzdie
        VALUE(iv_plifz)                  TYPE plifz
        VALUE(iv_webaz)                  TYPE webaz
        VALUE(iv_perkz)                  TYPE perkz
        VALUE(iv_ausss)                  TYPE ausss
        VALUE(iv_disls)                  TYPE disls
        VALUE(iv_beskz)                  TYPE beskz
        VALUE(iv_sobsl)                  TYPE sobsl
        VALUE(iv_minbe)                  TYPE minbe
        VALUE(iv_eisbe)                  TYPE eisbe
        VALUE(iv_bstmi)                  TYPE bstmi
        VALUE(iv_bstma)                  TYPE bstma
        VALUE(iv_bstfe)                  TYPE bstfe
        VALUE(iv_bstrf)                  TYPE bstrf
        VALUE(iv_mabst)                  TYPE mabst
        VALUE(iv_losfx)                  TYPE losfx
        VALUE(iv_sbdkz)                  TYPE sbdkz
        VALUE(iv_lagpr)                  TYPE lagpr
        VALUE(iv_altsl)                  TYPE altsl
        VALUE(iv_kzaus)                  TYPE kzaus
        VALUE(iv_ausdt)                  TYPE ausdt
        VALUE(iv_nfmat)                  TYPE nfmat
        VALUE(iv_kzbed)                  TYPE kzbed
        VALUE(iv_miskz)                  TYPE miskz
        VALUE(iv_fhori)                  TYPE fhori
        VALUE(iv_pfrei)                  TYPE pfrei
        VALUE(iv_ffrei)                  TYPE ffrei
        VALUE(iv_rgekz)                  TYPE rgekm
        VALUE(iv_fevor)                  TYPE fevor
        VALUE(iv_bearz)                  TYPE bearz
        VALUE(iv_ruezt)                  TYPE ruezt
        VALUE(iv_tranz)                  TYPE tranz
        VALUE(iv_basmg)                  TYPE basmg
        VALUE(iv_dzeit)                  TYPE dzeit
        VALUE(iv_maxlz)                  TYPE maxlz
        VALUE(iv_lzeih)                  TYPE lzeih
        VALUE(iv_kzpro)                  TYPE kzpro
        VALUE(iv_gpmkz)                  TYPE gpmkz
        VALUE(iv_ueeto)                  TYPE ueeto
        VALUE(iv_ueetk)                  TYPE ueetk
        VALUE(iv_uneto)                  TYPE uneto
        VALUE(iv_wzeit)                  TYPE wzeit
        VALUE(iv_atpkz)                  TYPE atpkz
        VALUE(iv_vzusl)                  TYPE vzusl
        VALUE(iv_herbl)                  TYPE herbl
        VALUE(iv_insmk)                  TYPE insmk_mat
        VALUE(iv_sproz)                  TYPE sproz
        VALUE(iv_quazt)                  TYPE quazt
        VALUE(iv_ssqss)                  TYPE qsspur
        VALUE(iv_mpdau)                  TYPE mpdau
        VALUE(iv_kzppv)                  TYPE kzppv
        VALUE(iv_kzdkz)                  TYPE kzdkz
        VALUE(iv_wstgh)                  TYPE wstgh
        VALUE(iv_prfrq)                  TYPE prfrq
        VALUE(iv_nkmpr)                  TYPE nkmpr
        VALUE(iv_umlmc)                  TYPE umlme
        VALUE(iv_ladgr)                  TYPE ladgr
        VALUE(iv_xchpf)                  TYPE xchpf_werks
        VALUE(iv_usequ)                  TYPE usequ
        VALUE(iv_lgrad)                  TYPE lgrad
        VALUE(iv_auftl)                  TYPE auftl
        VALUE(iv_plvar)                  TYPE plvar
        VALUE(iv_otype)                  TYPE otype
        VALUE(iv_objid)                  TYPE objektid
        VALUE(iv_mtvfp)                  TYPE mtvfp
        VALUE(iv_periv)                  TYPE periv
        VALUE(iv_kzkfk)                  TYPE kzkfk
        VALUE(iv_vrvez)                  TYPE vrvez
        VALUE(iv_vbamg)                  TYPE vbamg
        VALUE(iv_vbeaz)                  TYPE vbeaz
        VALUE(iv_lizyk)                  TYPE dummylizyk
        VALUE(iv_bwscl)                  TYPE bwscl
        VALUE(iv_kautb)                  TYPE kautb
        VALUE(iv_kordb)                  TYPE kordb
        VALUE(iv_stawn)                  TYPE stawn
        VALUE(iv_herkl)                  TYPE herkl
        VALUE(iv_herkr)                  TYPE herkr
        VALUE(iv_expme)                  TYPE expme
        VALUE(iv_mtver)                  TYPE mtver
        VALUE(iv_prctr)                  TYPE prctr
        VALUE(iv_trame)                  TYPE trame
        VALUE(iv_mrppp)                  TYPE mrppp
        VALUE(iv_sauft)                  TYPE sa_sauft
        VALUE(iv_fxhor)                  TYPE fxhor
        VALUE(iv_vrmod)                  TYPE vrmod
        VALUE(iv_vint1)                  TYPE vint1
        VALUE(iv_vint2)                  TYPE vint2
        VALUE(iv_verkz)                  TYPE ck_verk1
        VALUE(iv_stlal)                  TYPE stalt
        VALUE(iv_stlan)                  TYPE stlan
        VALUE(iv_plnnr)                  TYPE plnnr
        VALUE(iv_aplal)                  TYPE plnal
        VALUE(iv_losgr)                  TYPE ck_losgr
        VALUE(iv_sobsk)                  TYPE ck_sobsl
        VALUE(iv_frtme)                  TYPE frtme
        VALUE(iv_lgpro)                  TYPE lgpro
        VALUE(iv_disgr)                  TYPE disgr
        VALUE(iv_kausf)                  TYPE kausf
        VALUE(iv_qzgtp)                  TYPE qzgtyp
        VALUE(iv_qmatv)                  TYPE qmatv
        VALUE(iv_takzt)                  TYPE takzt
        VALUE(iv_rwpro)                  TYPE rwpro
        VALUE(iv_copam)                  TYPE copam
        VALUE(iv_abcin)                  TYPE abcin
        VALUE(iv_awsls)                  TYPE awsls
        VALUE(iv_sernp)                  TYPE serail
        VALUE(iv_cuobj)                  TYPE cuobm
        VALUE(iv_stdpd)                  TYPE stdpd
        VALUE(iv_sfepr)                  TYPE sfepr
        VALUE(iv_xmcng)                  TYPE xmcng
        VALUE(iv_qssys)                  TYPE qssys_soll
        VALUE(iv_lfrhy)                  TYPE lfrhy
        VALUE(iv_rdprf)                  TYPE rdprf
        VALUE(iv_vrbmt)                  TYPE vrbmt
        VALUE(iv_vrbwk)                  TYPE vrbwk
        VALUE(iv_vrbdt)                  TYPE vrbdt
        VALUE(iv_vrbfk)                  TYPE vrbfk
        VALUE(iv_autru)                  TYPE autru
        VALUE(iv_prefe)                  TYPE prefe
        VALUE(iv_prenc)                  TYPE prenc
        VALUE(iv_preno)                  TYPE prenn
        VALUE(iv_prend)                  TYPE prend
        VALUE(iv_prene)                  TYPE prene
        VALUE(iv_preng)                  TYPE preng
        VALUE(iv_itark)                  TYPE itark
        VALUE(iv_servg)                  TYPE w_servgrd
        VALUE(iv_kzkup)                  TYPE kzkupmat
        VALUE(iv_strgr)                  TYPE strgr
        VALUE(iv_cuobv)                  TYPE cuobv
        VALUE(iv_lgfsb)                  TYPE lgfsb
        VALUE(iv_schgt)                  TYPE schgt
        VALUE(iv_ccfix)                  TYPE ccfix
        VALUE(iv_eprio)                  TYPE bf_group
        VALUE(iv_qmata)                  TYPE qmatauth
        VALUE(iv_resvp)                  TYPE resvp
        VALUE(iv_plnty)                  TYPE plnty
        VALUE(iv_uomgr)                  TYPE oib_uomgr
        VALUE(iv_umrsl)                  TYPE oib_umrsl
        VALUE(iv_abfac)                  TYPE oil_abfac
        VALUE(iv_sfcpf)                  TYPE co_prodprf
        VALUE(iv_shflg)                  TYPE shflg
        VALUE(iv_shzet)                  TYPE shzet
        VALUE(iv_mdach)                  TYPE mdach
        VALUE(iv_kzech)                  TYPE kzech
        VALUE(iv_megru)                  TYPE megru
        VALUE(iv_mfrgr)                  TYPE mfrgr
        VALUE(iv_sfty_stk_meth)          TYPE mrp_sstock_method
        VALUE(iv_profil)                 TYPE ppc_profile_name
        VALUE(iv_vkumc)                  TYPE vkumc
        VALUE(iv_vktrw)                  TYPE vktrw
        VALUE(iv_kzagl)                  TYPE kzagl
        VALUE(iv_fvidk)                  TYPE ck_verid
        VALUE(iv_fxpru)                  TYPE ck_fixprku
        VALUE(iv_loggr)                  TYPE loggr
        VALUE(iv_fprfm)                  TYPE fprfm
        VALUE(iv_glgmg)                  TYPE glgmg
        VALUE(iv_vkglg)                  TYPE vkglg
        VALUE(iv_indus)                  TYPE j_1bindus3
        VALUE(iv_mownr)                  TYPE mownr
        VALUE(iv_mogru)                  TYPE mogru
        VALUE(iv_casnr)                  TYPE casnr
        VALUE(iv_gpnum)                  TYPE gpnum
        VALUE(iv_steuc)                  TYPE steuc
        VALUE(iv_fabkz)                  TYPE fabkz
        VALUE(iv_matgr)                  TYPE matnrgroup
        VALUE(iv_vspvb)                  TYPE vspvb
        VALUE(iv_dplfs)                  TYPE dplfs
        VALUE(iv_dplpu)                  TYPE dplpu
        VALUE(iv_dplho)                  TYPE dplho
        VALUE(iv_minls)                  TYPE cscp_minlotsize
        VALUE(iv_maxls)                  TYPE cscp_maxlotsize
        VALUE(iv_fixls)                  TYPE cscp_fixlotsize
        VALUE(iv_ltinc)                  TYPE cscp_lotincrement
        VALUE(iv_compl)                  TYPE cscp_dummy
        VALUE(iv_convt)                  TYPE cscp_conv_type
        VALUE(iv_shpro)                  TYPE shpro
        VALUE(iv_ahdis)                  TYPE ahdis
        VALUE(iv_diber)                  TYPE diber
        VALUE(iv_kzpsp)                  TYPE kzpsp
        VALUE(iv_ocmpf)                  TYPE ocm_gprofile
        VALUE(iv_apokz)                  TYPE apokz
        VALUE(iv_mcrue)                  TYPE mcrue
        VALUE(iv_lfmon)                  TYPE lfmon
        VALUE(iv_lfgja)                  TYPE lfgja
        VALUE(iv_eislo)                  TYPE eislo
        VALUE(iv_ncost)                  TYPE ck_no_costing
        VALUE(iv_rotation_date)          TYPE rotation_date
        VALUE(iv_uchkz)                  TYPE uchkz
        VALUE(iv_ucmat)                  TYPE vbob_ob_rfmat
        VALUE(iv_excise_tax_rlvnce)      TYPE cmd_prd_excise_tax_rlvnce
        VALUE(iv_temp_ctrl_max)          TYPE /scmtms/temp_control_max
        VALUE(iv_temp_ctrl_min)          TYPE /scmtms/temp_control_min
        VALUE(iv_temp_uom)               TYPE /scmtms/temp_uom
        VALUE(iv_jitprodnconfprofile)    TYPE njit_prodn_conf_profile
        VALUE(iv_bwesb)                  TYPE bwesb
        VALUE(iv_sgt_covs)               TYPE sgt_covs
        VALUE(iv_sgt_statc)              TYPE sgt_statc
        VALUE(iv_sgt_scope)              TYPE sgt_scope
        VALUE(iv_sgt_mrpsi)              TYPE sgt_srt_stk
        VALUE(iv_sgt_prcm)               TYPE sgt_prcm
        VALUE(iv_sgt_chint)              TYPE sgt_chint
        VALUE(iv_sgt_stk_prt)            TYPE sgt_stk_prt
        VALUE(iv_sgt_defsc)              TYPE sgt_defsc
        VALUE(iv_sgt_mrp_atp_status)     TYPE sgt_mrp_atp_status
        VALUE(iv_sgt_mmstd)              TYPE sgt_mmstd
        VALUE(iv_fsh_mg_arun_req)        TYPE fsh_mg_arun_req
        VALUE(iv_fsh_seaim)              TYPE fsh_seaim
        VALUE(iv_fsh_var_group)          TYPE fsh_var_group
        VALUE(iv_fsh_kzech)              TYPE fsh_kzech
        VALUE(iv_fsh_calendar_group)     TYPE fsh_calendar_group
        VALUE(iv_arun_fix_batch)         TYPE arun_fix_batch
        VALUE(iv_ppskz)                  TYPE ppskz
        VALUE(iv_cons_procg)             TYPE wrf_cons_procg
        VALUE(iv_gi_pr_time)             TYPE wrf_pscd_wabaz
        VALUE(iv_multiple_ekgrp)         TYPE wrf_pohf_other_ekgrp_allow
        VALUE(iv_ref_schema)             TYPE wrf_ref_schema
        VALUE(iv_min_troc)               TYPE wrf_fre_troc_min
        VALUE(iv_max_troc)               TYPE wrf_fre_troc_max
        VALUE(iv_target_stock)           TYPE wrf_fre_target_stock
        VALUE(iv_nf_flag)                TYPE /nfm/nfmat
        VALUE(iv_cwm_umlmc)              TYPE umlme
        VALUE(iv_cwm_trame)              TYPE trame
        VALUE(iv_cwm_bwesb)              TYPE bwesb
        VALUE(iv_scm_matlocid_guid16)    TYPE /scmb/mdl_matid
        VALUE(iv_scm_matlocid_guid22)    TYPE /sapapo/matlocid
        VALUE(iv_scm_grprt)              TYPE /sapapo/grprt
        VALUE(iv_scm_giprt)              TYPE /sapapo/giprt
        VALUE(iv_scm_scost)              TYPE /sapapo/scost
        VALUE(iv_scm_reldt)              TYPE /sapapo/reldt
        VALUE(iv_scm_rrp_type)           TYPE /sapapo/pps_planning_type
        VALUE(iv_scm_heur_id)            TYPE /sapapo/prod_heur_id
        VALUE(iv_scm_package_id)         TYPE /sapapo/prod_heur_packid
        VALUE(iv_scm_sspen)              TYPE /sapapo/sspen
        VALUE(iv_scm_get_alerts)         TYPE /sapapo/get_alerts_for_prod
        VALUE(iv_scm_res_net_name)       TYPE /sapapo/resnet_netname
        VALUE(iv_scm_conhap)             TYPE /sapapo/snpconhap
        VALUE(iv_scm_hunit)              TYPE /sapapo/hunit
        VALUE(iv_scm_conhap_out)         TYPE /sapapo/snpconhap_out
        VALUE(iv_scm_hunit_out)          TYPE /sapapo/hunit_out
        VALUE(iv_scm_shelf_life_loc)     TYPE /sapapo/shelf_life_loc_flag
        VALUE(iv_scm_shelf_life_dur)     TYPE /sapapo/shelf_life_dur_l
        VALUE(iv_scm_maturity_dur)       TYPE /sapapo/maturity_dur_l
        VALUE(iv_scm_shlf_lfe_req_min)   TYPE /sapapo/shelf_life_req_min_l
        VALUE(iv_scm_shlf_lfe_req_max)   TYPE /sapapo/shelf_life_req_max_l
        VALUE(iv_scm_lsuom)              TYPE /sapapo/lsuom
        VALUE(iv_scm_reord_dur)          TYPE /sapapo/reord_dur
        VALUE(iv_scm_target_dur)         TYPE /sapapo/target_dur
        VALUE(iv_scm_tstrid)             TYPE /sapapo/lot_tstrid
        VALUE(iv_scm_stra1)              TYPE /sapapo/stra1
        VALUE(iv_scm_peg_past_alert)     TYPE /sapapo/dm_pegging_past_alert
        VALUE(iv_scm_peg_future_alert)   TYPE /sapapo/dm_pegging_futur_alert
        VALUE(iv_scm_peg_strategy)       TYPE /sapapo/peg_strategy
        VALUE(iv_scm_peg_wo_alert_fst)   TYPE /sapapo/peg_wo_alert_first
        VALUE(iv_scm_fixpeg_prod_set)    TYPE /sapapo/dm_fixpeg_prod_setting
        VALUE(iv_scm_whatbom)            TYPE /sapapo/whatbom
        VALUE(iv_scm_rrp_sel_group)      TYPE /sapapo/rrp_sel_group
        VALUE(iv_scm_intsrc_prof)        TYPE /sapapo/cdps_intsrc_prof
        VALUE(iv_scm_prio)               TYPE /sapapo/prio
        VALUE(iv_scm_min_pass_amount)    TYPE /sapapo/min_pass_amount
        VALUE(iv_scm_profid)             TYPE /sapapo/prof_exec_check_p
        VALUE(iv_scm_ges_mng_use)        TYPE /sapapo/ges_mng_use
        VALUE(iv_scm_ges_bst_use)        TYPE /sapapo/ges_bst_use
        VALUE(iv_esppflg)                TYPE esppflg
        VALUE(iv_scm_thruput_time)       TYPE /sapapo/thruput_time
        VALUE(iv_scm_tpop)               TYPE /sapapo/tpop
        VALUE(iv_scm_safty_v)            TYPE saftyv
        VALUE(iv_scm_ppsaftystk)         TYPE ppsaftystk
        VALUE(iv_scm_ppsaftystk_v)       TYPE ppsaftystkv
        VALUE(iv_scm_repsafty)           TYPE repsafty
        VALUE(iv_scm_repsafty_v)         TYPE repsaftyv
        VALUE(iv_scm_reord_v)            TYPE reord_v
        VALUE(iv_scm_maxstock_v)         TYPE maxstock_v
        VALUE(iv_scm_scost_prcnt)        TYPE /sapapo/percent_scost
        VALUE(iv_scm_proc_cost)          TYPE /sapapo/proc_cost
        VALUE(iv_scm_ndcostwe)           TYPE ndcostwe
        VALUE(iv_scm_ndcostwa)           TYPE ndcostwa
        VALUE(iv_scm_coninp)             TYPE /sapapo/snpconinp
        VALUE(iv_conf_gmsync)            TYPE /sapapo/ppc_gmsync
        VALUE(iv_scm_iunit)              TYPE /sapapo/unit
        VALUE(iv_scm_sft_lock)           TYPE /sapapo/sft_ovrride
        VALUE(iv_dummy_plnt_incl_eew_ps) TYPE plnt_incl_eew
        VALUE(iv_cmd_mb_eires)           TYPE /cmd/mb_l_eires
        VALUE(iv_cmd_mb_lftag)           TYPE /cmd/mb_l_lftag
        VALUE(iv_cmd_mb_sitag)           TYPE /cmd/mb_l_sitag
        VALUE(iv_cmd_mb_gestg)           TYPE /cmd/mb_l_gestg
        VALUE(iv_cmd_mb_maxlg)           TYPE /cmd/mb_l_maxlg
        VALUE(iv_cmd_mb_faker)           TYPE /cmd/mb_l_faker
        VALUE(iv_cmd_mb_aschl)           TYPE /cmd/mb_l_aschl
        VALUE(iv_sapmp_tolprpl)          TYPE /sapmp/tolprpl
        VALUE(iv_sapmp_tolprmi)          TYPE /sapmp/tolprmi
        VALUE(iv_sttpec_servalid)        TYPE /sttpec/e_servalid
        VALUE(iv_vso_r_pkgrp)            TYPE /vso/m_pkgrp
        VALUE(iv_vso_r_lane_num)         TYPE /vso/m_lane_num
        VALUE(iv_vso_r_pal_vend)         TYPE /vso/r_matnr_pal_vend
        VALUE(iv_vso_r_fork_dir)         TYPE /vso/m_fork_dir
        VALUE(iv_iuid_relevant)          TYPE iuid_relevant
        VALUE(iv_iuid_type)              TYPE iuid_type
        VALUE(iv_uid_iea)                TYPE uid_iea
        VALUE(iv_dpcbt)                  TYPE mill_dpcbt
        VALUE(iv_zzeires)                TYPE zmm_l_eires
        VALUE(iv_zzlftag)                TYPE zmm_l_lftag
        VALUE(iv_zzsitag)                TYPE zmm_l_sitag
        VALUE(iv_zzgestg)                TYPE zmm_l_gestg
        VALUE(iv_zzmaxlg)                TYPE zmm_l_maxlg
        VALUE(iv_zzfaker)                TYPE zmm_l_faker
        VALUE(iv_zzaschl)                TYPE zmm_l_aschl
        VALUE(iv_zzlfspme)               TYPE zmm_l_lfspme
        VALUE(iv_zzaltmn)                TYPE zmm_l_altmn
        VALUE(iv_zzgema)                 TYPE zmm_l_gema
        VALUE(iv_zzuhg)                  TYPE zmm_l_uhg
        VALUE(iv_zzek1)                  TYPE zmm_l_zek1
        VALUE(iv_zzek2)                  TYPE zmm_l_zek2
        VALUE(iv_zzek5)                  TYPE zmm_l_zek5
        VALUE(iv_zzek6)                  TYPE zmm_l_zek6
        VALUE(iv_zzstcode_i)             TYPE zmm_l_status_i
        VALUE(iv_zzstcode_e)             TYPE zmm_l_status_e
        VALUE(iv_zzek5_aufschlag)        TYPE zmm_l_ek5_auf
        VALUE(iv_zzek1_aufschlag)        TYPE zmm_l_ek1_auf
        VALUE(iv_zzek5_abschlag)         TYPE zmm_l_ek5_ab
        VALUE(iv_zzpreis_b)              TYPE zmm_l_preis_basis
        VALUE(iv_zzmhd)                  TYPE zmm_l_mhd
      EXPORTING
        VALUE(e_success)                 TYPE char1.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_MIG_MARC_UTIL IMPLEMENTATION.
* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_MIG_MARC_UTIL=>INSERT_MARC_SINGLE
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_MANDT                       TYPE        MANDT
* | [--->] IV_MATNR                       TYPE        MATNR
* | [--->] IV_WERKS                       TYPE        WERKS_D
* | [--->] IV_PSTAT                       TYPE        PSTAT_D
* | [--->] IV_LVORM                       TYPE        LVOWK
* | [--->] IV_BWTTY                       TYPE        BWTTY_D
* | [--->] IV_XCHAR                       TYPE        XCHAR
* | [--->] IV_MMSTA                       TYPE        MMSTA
* | [--->] IV_MMSTD                       TYPE        MMSTD
* | [--->] IV_MAABC                       TYPE        MAABC
* | [--->] IV_KZKRI                       TYPE        KZKRI
* | [--->] IV_EKGRP                       TYPE        EKGRP
* | [--->] IV_AUSME                       TYPE        AUSME
* | [--->] IV_DISPR                       TYPE        DISPR
* | [--->] IV_DISMM                       TYPE        DISMM
* | [--->] IV_DISPO                       TYPE        DISPO
* | [--->] IV_KZDIE                       TYPE        KZDIE
* | [--->] IV_PLIFZ                       TYPE        PLIFZ
* | [--->] IV_WEBAZ                       TYPE        WEBAZ
* | [--->] IV_PERKZ                       TYPE        PERKZ
* | [--->] IV_AUSSS                       TYPE        AUSSS
* | [--->] IV_DISLS                       TYPE        DISLS
* | [--->] IV_BESKZ                       TYPE        BESKZ
* | [--->] IV_SOBSL                       TYPE        SOBSL
* | [--->] IV_MINBE                       TYPE        MINBE
* | [--->] IV_EISBE                       TYPE        EISBE
* | [--->] IV_BSTMI                       TYPE        BSTMI
* | [--->] IV_BSTMA                       TYPE        BSTMA
* | [--->] IV_BSTFE                       TYPE        BSTFE
* | [--->] IV_BSTRF                       TYPE        BSTRF
* | [--->] IV_MABST                       TYPE        MABST
* | [--->] IV_LOSFX                       TYPE        LOSFX
* | [--->] IV_SBDKZ                       TYPE        SBDKZ
* | [--->] IV_LAGPR                       TYPE        LAGPR
* | [--->] IV_ALTSL                       TYPE        ALTSL
* | [--->] IV_KZAUS                       TYPE        KZAUS
* | [--->] IV_AUSDT                       TYPE        AUSDT
* | [--->] IV_NFMAT                       TYPE        NFMAT
* | [--->] IV_KZBED                       TYPE        KZBED
* | [--->] IV_MISKZ                       TYPE        MISKZ
* | [--->] IV_FHORI                       TYPE        FHORI
* | [--->] IV_PFREI                       TYPE        PFREI
* | [--->] IV_FFREI                       TYPE        FFREI
* | [--->] IV_RGEKZ                       TYPE        RGEKM
* | [--->] IV_FEVOR                       TYPE        FEVOR
* | [--->] IV_BEARZ                       TYPE        BEARZ
* | [--->] IV_RUEZT                       TYPE        RUEZT
* | [--->] IV_TRANZ                       TYPE        TRANZ
* | [--->] IV_BASMG                       TYPE        BASMG
* | [--->] IV_DZEIT                       TYPE        DZEIT
* | [--->] IV_MAXLZ                       TYPE        MAXLZ
* | [--->] IV_LZEIH                       TYPE        LZEIH
* | [--->] IV_KZPRO                       TYPE        KZPRO
* | [--->] IV_GPMKZ                       TYPE        GPMKZ
* | [--->] IV_UEETO                       TYPE        UEETO
* | [--->] IV_UEETK                       TYPE        UEETK
* | [--->] IV_UNETO                       TYPE        UNETO
* | [--->] IV_WZEIT                       TYPE        WZEIT
* | [--->] IV_ATPKZ                       TYPE        ATPKZ
* | [--->] IV_VZUSL                       TYPE        VZUSL
* | [--->] IV_HERBL                       TYPE        HERBL
* | [--->] IV_INSMK                       TYPE        INSMK_MAT
* | [--->] IV_SPROZ                       TYPE        SPROZ
* | [--->] IV_QUAZT                       TYPE        QUAZT
* | [--->] IV_SSQSS                       TYPE        QSSPUR
* | [--->] IV_MPDAU                       TYPE        MPDAU
* | [--->] IV_KZPPV                       TYPE        KZPPV
* | [--->] IV_KZDKZ                       TYPE        KZDKZ
* | [--->] IV_WSTGH                       TYPE        WSTGH
* | [--->] IV_PRFRQ                       TYPE        PRFRQ
* | [--->] IV_NKMPR                       TYPE        NKMPR
* | [--->] IV_UMLMC                       TYPE        UMLME
* | [--->] IV_LADGR                       TYPE        LADGR
* | [--->] IV_XCHPF                       TYPE        XCHPF_WERKS
* | [--->] IV_USEQU                       TYPE        USEQU
* | [--->] IV_LGRAD                       TYPE        LGRAD
* | [--->] IV_AUFTL                       TYPE        AUFTL
* | [--->] IV_PLVAR                       TYPE        PLVAR
* | [--->] IV_OTYPE                       TYPE        OTYPE
* | [--->] IV_OBJID                       TYPE        OBJEKTID
* | [--->] IV_MTVFP                       TYPE        MTVFP
* | [--->] IV_PERIV                       TYPE        PERIV
* | [--->] IV_KZKFK                       TYPE        KZKFK
* | [--->] IV_VRVEZ                       TYPE        VRVEZ
* | [--->] IV_VBAMG                       TYPE        VBAMG
* | [--->] IV_VBEAZ                       TYPE        VBEAZ
* | [--->] IV_LIZYK                       TYPE        DUMMYLIZYK
* | [--->] IV_BWSCL                       TYPE        BWSCL
* | [--->] IV_KAUTB                       TYPE        KAUTB
* | [--->] IV_KORDB                       TYPE        KORDB
* | [--->] IV_STAWN                       TYPE        STAWN
* | [--->] IV_HERKL                       TYPE        HERKL
* | [--->] IV_HERKR                       TYPE        HERKR
* | [--->] IV_EXPME                       TYPE        EXPME
* | [--->] IV_MTVER                       TYPE        MTVER
* | [--->] IV_PRCTR                       TYPE        PRCTR
* | [--->] IV_TRAME                       TYPE        TRAME
* | [--->] IV_MRPPP                       TYPE        MRPPP
* | [--->] IV_SAUFT                       TYPE        SA_SAUFT
* | [--->] IV_FXHOR                       TYPE        FXHOR
* | [--->] IV_VRMOD                       TYPE        VRMOD
* | [--->] IV_VINT1                       TYPE        VINT1
* | [--->] IV_VINT2                       TYPE        VINT2
* | [--->] IV_VERKZ                       TYPE        CK_VERK1
* | [--->] IV_STLAL                       TYPE        STALT
* | [--->] IV_STLAN                       TYPE        STLAN
* | [--->] IV_PLNNR                       TYPE        PLNNR
* | [--->] IV_APLAL                       TYPE        PLNAL
* | [--->] IV_LOSGR                       TYPE        CK_LOSGR
* | [--->] IV_SOBSK                       TYPE        CK_SOBSL
* | [--->] IV_FRTME                       TYPE        FRTME
* | [--->] IV_LGPRO                       TYPE        LGPRO
* | [--->] IV_DISGR                       TYPE        DISGR
* | [--->] IV_KAUSF                       TYPE        KAUSF
* | [--->] IV_QZGTP                       TYPE        QZGTYP
* | [--->] IV_QMATV                       TYPE        QMATV
* | [--->] IV_TAKZT                       TYPE        TAKZT
* | [--->] IV_RWPRO                       TYPE        RWPRO
* | [--->] IV_COPAM                       TYPE        COPAM
* | [--->] IV_ABCIN                       TYPE        ABCIN
* | [--->] IV_AWSLS                       TYPE        AWSLS
* | [--->] IV_SERNP                       TYPE        SERAIL
* | [--->] IV_CUOBJ                       TYPE        CUOBM
* | [--->] IV_STDPD                       TYPE        STDPD
* | [--->] IV_SFEPR                       TYPE        SFEPR
* | [--->] IV_XMCNG                       TYPE        XMCNG
* | [--->] IV_QSSYS                       TYPE        QSSYS_SOLL
* | [--->] IV_LFRHY                       TYPE        LFRHY
* | [--->] IV_RDPRF                       TYPE        RDPRF
* | [--->] IV_VRBMT                       TYPE        VRBMT
* | [--->] IV_VRBWK                       TYPE        VRBWK
* | [--->] IV_VRBDT                       TYPE        VRBDT
* | [--->] IV_VRBFK                       TYPE        VRBFK
* | [--->] IV_AUTRU                       TYPE        AUTRU
* | [--->] IV_PREFE                       TYPE        PREFE
* | [--->] IV_PRENC                       TYPE        PRENC
* | [--->] IV_PRENO                       TYPE        PRENN
* | [--->] IV_PREND                       TYPE        PREND
* | [--->] IV_PRENE                       TYPE        PRENE
* | [--->] IV_PRENG                       TYPE        PRENG
* | [--->] IV_ITARK                       TYPE        ITARK
* | [--->] IV_SERVG                       TYPE        W_SERVGRD
* | [--->] IV_KZKUP                       TYPE        KZKUPMAT
* | [--->] IV_STRGR                       TYPE        STRGR
* | [--->] IV_CUOBV                       TYPE        CUOBV
* | [--->] IV_LGFSB                       TYPE        LGFSB
* | [--->] IV_SCHGT                       TYPE        SCHGT
* | [--->] IV_CCFIX                       TYPE        CCFIX
* | [--->] IV_EPRIO                       TYPE        BF_GROUP
* | [--->] IV_QMATA                       TYPE        QMATAUTH
* | [--->] IV_RESVP                       TYPE        RESVP
* | [--->] IV_PLNTY                       TYPE        PLNTY
* | [--->] IV_UOMGR                       TYPE        OIB_UOMGR
* | [--->] IV_UMRSL                       TYPE        OIB_UMRSL
* | [--->] IV_ABFAC                       TYPE        OIL_ABFAC
* | [--->] IV_SFCPF                       TYPE        CO_PRODPRF
* | [--->] IV_SHFLG                       TYPE        SHFLG
* | [--->] IV_SHZET                       TYPE        SHZET
* | [--->] IV_MDACH                       TYPE        MDACH
* | [--->] IV_KZECH                       TYPE        KZECH
* | [--->] IV_MEGRU                       TYPE        MEGRU
* | [--->] IV_MFRGR                       TYPE        MFRGR
* | [--->] IV_SFTY_STK_METH               TYPE        MRP_SSTOCK_METHOD
* | [--->] IV_PROFIL                      TYPE        PPC_PROFILE_NAME
* | [--->] IV_VKUMC                       TYPE        VKUMC
* | [--->] IV_VKTRW                       TYPE        VKTRW
* | [--->] IV_KZAGL                       TYPE        KZAGL
* | [--->] IV_FVIDK                       TYPE        CK_VERID
* | [--->] IV_FXPRU                       TYPE        CK_FIXPRKU
* | [--->] IV_LOGGR                       TYPE        LOGGR
* | [--->] IV_FPRFM                       TYPE        FPRFM
* | [--->] IV_GLGMG                       TYPE        GLGMG
* | [--->] IV_VKGLG                       TYPE        VKGLG
* | [--->] IV_INDUS                       TYPE        J_1BINDUS3
* | [--->] IV_MOWNR                       TYPE        MOWNR
* | [--->] IV_MOGRU                       TYPE        MOGRU
* | [--->] IV_CASNR                       TYPE        CASNR
* | [--->] IV_GPNUM                       TYPE        GPNUM
* | [--->] IV_STEUC                       TYPE        STEUC
* | [--->] IV_FABKZ                       TYPE        FABKZ
* | [--->] IV_MATGR                       TYPE        MATNRGROUP
* | [--->] IV_VSPVB                       TYPE        VSPVB
* | [--->] IV_DPLFS                       TYPE        DPLFS
* | [--->] IV_DPLPU                       TYPE        DPLPU
* | [--->] IV_DPLHO                       TYPE        DPLHO
* | [--->] IV_MINLS                       TYPE        CSCP_MINLOTSIZE
* | [--->] IV_MAXLS                       TYPE        CSCP_MAXLOTSIZE
* | [--->] IV_FIXLS                       TYPE        CSCP_FIXLOTSIZE
* | [--->] IV_LTINC                       TYPE        CSCP_LOTINCREMENT
* | [--->] IV_COMPL                       TYPE        CSCP_DUMMY
* | [--->] IV_CONVT                       TYPE        CSCP_CONV_TYPE
* | [--->] IV_SHPRO                       TYPE        SHPRO
* | [--->] IV_AHDIS                       TYPE        AHDIS
* | [--->] IV_DIBER                       TYPE        DIBER
* | [--->] IV_KZPSP                       TYPE        KZPSP
* | [--->] IV_OCMPF                       TYPE        OCM_GPROFILE
* | [--->] IV_APOKZ                       TYPE        APOKZ
* | [--->] IV_MCRUE                       TYPE        MCRUE
* | [--->] IV_LFMON                       TYPE        LFMON
* | [--->] IV_LFGJA                       TYPE        LFGJA
* | [--->] IV_EISLO                       TYPE        EISLO
* | [--->] IV_NCOST                       TYPE        CK_NO_COSTING
* | [--->] IV_ROTATION_DATE               TYPE        ROTATION_DATE
* | [--->] IV_UCHKZ                       TYPE        UCHKZ
* | [--->] IV_UCMAT                       TYPE        VBOB_OB_RFMAT
* | [--->] IV_EXCISE_TAX_RLVNCE           TYPE        CMD_PRD_EXCISE_TAX_RLVNCE
* | [--->] IV_TEMP_CTRL_MAX               TYPE        /SCMTMS/TEMP_CONTROL_MAX
* | [--->] IV_TEMP_CTRL_MIN               TYPE        /SCMTMS/TEMP_CONTROL_MIN
* | [--->] IV_TEMP_UOM                    TYPE        /SCMTMS/TEMP_UOM
* | [--->] IV_JITPRODNCONFPROFILE         TYPE        NJIT_PRODN_CONF_PROFILE
* | [--->] IV_BWESB                       TYPE        BWESB
* | [--->] IV_SGT_COVS                    TYPE        SGT_COVS
* | [--->] IV_SGT_STATC                   TYPE        SGT_STATC
* | [--->] IV_SGT_SCOPE                   TYPE        SGT_SCOPE
* | [--->] IV_SGT_MRPSI                   TYPE        SGT_SRT_STK
* | [--->] IV_SGT_PRCM                    TYPE        SGT_PRCM
* | [--->] IV_SGT_CHINT                   TYPE        SGT_CHINT
* | [--->] IV_SGT_STK_PRT                 TYPE        SGT_STK_PRT
* | [--->] IV_SGT_DEFSC                   TYPE        SGT_DEFSC
* | [--->] IV_SGT_MRP_ATP_STATUS          TYPE        SGT_MRP_ATP_STATUS
* | [--->] IV_SGT_MMSTD                   TYPE        SGT_MMSTD
* | [--->] IV_FSH_MG_ARUN_REQ             TYPE        FSH_MG_ARUN_REQ
* | [--->] IV_FSH_SEAIM                   TYPE        FSH_SEAIM
* | [--->] IV_FSH_VAR_GROUP               TYPE        FSH_VAR_GROUP
* | [--->] IV_FSH_KZECH                   TYPE        FSH_KZECH
* | [--->] IV_FSH_CALENDAR_GROUP          TYPE        FSH_CALENDAR_GROUP
* | [--->] IV_ARUN_FIX_BATCH              TYPE        ARUN_FIX_BATCH
* | [--->] IV_PPSKZ                       TYPE        PPSKZ
* | [--->] IV_CONS_PROCG                  TYPE        WRF_CONS_PROCG
* | [--->] IV_GI_PR_TIME                  TYPE        WRF_PSCD_WABAZ
* | [--->] IV_MULTIPLE_EKGRP              TYPE        WRF_POHF_OTHER_EKGRP_ALLOW
* | [--->] IV_REF_SCHEMA                  TYPE        WRF_REF_SCHEMA
* | [--->] IV_MIN_TROC                    TYPE        WRF_FRE_TROC_MIN
* | [--->] IV_MAX_TROC                    TYPE        WRF_FRE_TROC_MAX
* | [--->] IV_TARGET_STOCK                TYPE        WRF_FRE_TARGET_STOCK
* | [--->] IV_NF_FLAG                     TYPE        /NFM/NFMAT
* | [--->] IV_CWM_UMLMC                   TYPE        UMLME
* | [--->] IV_CWM_TRAME                   TYPE        TRAME
* | [--->] IV_CWM_BWESB                   TYPE        BWESB
* | [--->] IV_SCM_MATLOCID_GUID16         TYPE        /SCMB/MDL_MATID
* | [--->] IV_SCM_MATLOCID_GUID22         TYPE        /SAPAPO/MATLOCID
* | [--->] IV_SCM_GRPRT                   TYPE        /SAPAPO/GRPRT
* | [--->] IV_SCM_GIPRT                   TYPE        /SAPAPO/GIPRT
* | [--->] IV_SCM_SCOST                   TYPE        /SAPAPO/SCOST
* | [--->] IV_SCM_RELDT                   TYPE        /SAPAPO/RELDT
* | [--->] IV_SCM_RRP_TYPE                TYPE        /SAPAPO/PPS_PLANNING_TYPE
* | [--->] IV_SCM_HEUR_ID                 TYPE        /SAPAPO/PROD_HEUR_ID
* | [--->] IV_SCM_PACKAGE_ID              TYPE        /SAPAPO/PROD_HEUR_PACKID
* | [--->] IV_SCM_SSPEN                   TYPE        /SAPAPO/SSPEN
* | [--->] IV_SCM_GET_ALERTS              TYPE        /SAPAPO/GET_ALERTS_FOR_PROD
* | [--->] IV_SCM_RES_NET_NAME            TYPE        /SAPAPO/RESNET_NETNAME
* | [--->] IV_SCM_CONHAP                  TYPE        /SAPAPO/SNPCONHAP
* | [--->] IV_SCM_HUNIT                   TYPE        /SAPAPO/HUNIT
* | [--->] IV_SCM_CONHAP_OUT              TYPE        /SAPAPO/SNPCONHAP_OUT
* | [--->] IV_SCM_HUNIT_OUT               TYPE        /SAPAPO/HUNIT_OUT
* | [--->] IV_SCM_SHELF_LIFE_LOC          TYPE        /SAPAPO/SHELF_LIFE_LOC_FLAG
* | [--->] IV_SCM_SHELF_LIFE_DUR          TYPE        /SAPAPO/SHELF_LIFE_DUR_L
* | [--->] IV_SCM_MATURITY_DUR            TYPE        /SAPAPO/MATURITY_DUR_L
* | [--->] IV_SCM_SHLF_LFE_REQ_MIN        TYPE        /SAPAPO/SHELF_LIFE_REQ_MIN_L
* | [--->] IV_SCM_SHLF_LFE_REQ_MAX        TYPE        /SAPAPO/SHELF_LIFE_REQ_MAX_L
* | [--->] IV_SCM_LSUOM                   TYPE        /SAPAPO/LSUOM
* | [--->] IV_SCM_REORD_DUR               TYPE        /SAPAPO/REORD_DUR
* | [--->] IV_SCM_TARGET_DUR              TYPE        /SAPAPO/TARGET_DUR
* | [--->] IV_SCM_TSTRID                  TYPE        /SAPAPO/LOT_TSTRID
* | [--->] IV_SCM_STRA1                   TYPE        /SAPAPO/STRA1
* | [--->] IV_SCM_PEG_PAST_ALERT          TYPE        /SAPAPO/DM_PEGGING_PAST_ALERT
* | [--->] IV_SCM_PEG_FUTURE_ALERT        TYPE        /SAPAPO/DM_PEGGING_FUTUR_ALERT
* | [--->] IV_SCM_PEG_STRATEGY            TYPE        /SAPAPO/PEG_STRATEGY
* | [--->] IV_SCM_PEG_WO_ALERT_FST        TYPE        /SAPAPO/PEG_WO_ALERT_FIRST
* | [--->] IV_SCM_FIXPEG_PROD_SET         TYPE        /SAPAPO/DM_FIXPEG_PROD_SETTING
* | [--->] IV_SCM_WHATBOM                 TYPE        /SAPAPO/WHATBOM
* | [--->] IV_SCM_RRP_SEL_GROUP           TYPE        /SAPAPO/RRP_SEL_GROUP
* | [--->] IV_SCM_INTSRC_PROF             TYPE        /SAPAPO/CDPS_INTSRC_PROF
* | [--->] IV_SCM_PRIO                    TYPE        /SAPAPO/PRIO
* | [--->] IV_SCM_MIN_PASS_AMOUNT         TYPE        /SAPAPO/MIN_PASS_AMOUNT
* | [--->] IV_SCM_PROFID                  TYPE        /SAPAPO/PROF_EXEC_CHECK_P
* | [--->] IV_SCM_GES_MNG_USE             TYPE        /SAPAPO/GES_MNG_USE
* | [--->] IV_SCM_GES_BST_USE             TYPE        /SAPAPO/GES_BST_USE
* | [--->] IV_ESPPFLG                     TYPE        ESPPFLG
* | [--->] IV_SCM_THRUPUT_TIME            TYPE        /SAPAPO/THRUPUT_TIME
* | [--->] IV_SCM_TPOP                    TYPE        /SAPAPO/TPOP
* | [--->] IV_SCM_SAFTY_V                 TYPE        SAFTYV
* | [--->] IV_SCM_PPSAFTYSTK              TYPE        PPSAFTYSTK
* | [--->] IV_SCM_PPSAFTYSTK_V            TYPE        PPSAFTYSTKV
* | [--->] IV_SCM_REPSAFTY                TYPE        REPSAFTY
* | [--->] IV_SCM_REPSAFTY_V              TYPE        REPSAFTYV
* | [--->] IV_SCM_REORD_V                 TYPE        REORD_V
* | [--->] IV_SCM_MAXSTOCK_V              TYPE        MAXSTOCK_V
* | [--->] IV_SCM_SCOST_PRCNT             TYPE        /SAPAPO/PERCENT_SCOST
* | [--->] IV_SCM_PROC_COST               TYPE        /SAPAPO/PROC_COST
* | [--->] IV_SCM_NDCOSTWE                TYPE        NDCOSTWE
* | [--->] IV_SCM_NDCOSTWA                TYPE        NDCOSTWA
* | [--->] IV_SCM_CONINP                  TYPE        /SAPAPO/SNPCONINP
* | [--->] IV_CONF_GMSYNC                 TYPE        /SAPAPO/PPC_GMSYNC
* | [--->] IV_SCM_IUNIT                   TYPE        /SAPAPO/UNIT
* | [--->] IV_SCM_SFT_LOCK                TYPE        /SAPAPO/SFT_OVRRIDE
* | [--->] IV_DUMMY_PLNT_INCL_EEW_PS      TYPE        PLNT_INCL_EEW
* | [--->] IV_CMD_MB_EIRES                TYPE        /CMD/MB_L_EIRES
* | [--->] IV_CMD_MB_LFTAG                TYPE        /CMD/MB_L_LFTAG
* | [--->] IV_CMD_MB_SITAG                TYPE        /CMD/MB_L_SITAG
* | [--->] IV_CMD_MB_GESTG                TYPE        /CMD/MB_L_GESTG
* | [--->] IV_CMD_MB_MAXLG                TYPE        /CMD/MB_L_MAXLG
* | [--->] IV_CMD_MB_FAKER                TYPE        /CMD/MB_L_FAKER
* | [--->] IV_CMD_MB_ASCHL                TYPE        /CMD/MB_L_ASCHL
* | [--->] IV_SAPMP_TOLPRPL               TYPE        /SAPMP/TOLPRPL
* | [--->] IV_SAPMP_TOLPRMI               TYPE        /SAPMP/TOLPRMI
* | [--->] IV_STTPEC_SERVALID             TYPE        /STTPEC/E_SERVALID
* | [--->] IV_VSO_R_PKGRP                 TYPE        /VSO/M_PKGRP
* | [--->] IV_VSO_R_LANE_NUM              TYPE        /VSO/M_LANE_NUM
* | [--->] IV_VSO_R_PAL_VEND              TYPE        /VSO/R_MATNR_PAL_VEND
* | [--->] IV_VSO_R_FORK_DIR              TYPE        /VSO/M_FORK_DIR
* | [--->] IV_IUID_RELEVANT               TYPE        IUID_RELEVANT
* | [--->] IV_IUID_TYPE                   TYPE        IUID_TYPE
* | [--->] IV_UID_IEA                     TYPE        UID_IEA
* | [--->] IV_DPCBT                       TYPE        MILL_DPCBT
* | [--->] IV_ZZEIRES                     TYPE        ZMM_L_EIRES
* | [--->] IV_ZZLFTAG                     TYPE        ZMM_L_LFTAG
* | [--->] IV_ZZSITAG                     TYPE        ZMM_L_SITAG
* | [--->] IV_ZZGESTG                     TYPE        ZMM_L_GESTG
* | [--->] IV_ZZMAXLG                     TYPE        ZMM_L_MAXLG
* | [--->] IV_ZZFAKER                     TYPE        ZMM_L_FAKER
* | [--->] IV_ZZASCHL                     TYPE        ZMM_L_ASCHL
* | [--->] IV_ZZLFSPME                    TYPE        ZMM_L_LFSPME
* | [--->] IV_ZZALTMN                     TYPE        ZMM_L_ALTMN
* | [--->] IV_ZZGEMA                      TYPE        ZMM_L_GEMA
* | [--->] IV_ZZUHG                       TYPE        ZMM_L_UHG
* | [--->] IV_ZZEK1                       TYPE        ZMM_L_ZEK1
* | [--->] IV_ZZEK2                       TYPE        ZMM_L_ZEK2
* | [--->] IV_ZZEK5                       TYPE        ZMM_L_ZEK5
* | [--->] IV_ZZEK6                       TYPE        ZMM_L_ZEK6
* | [--->] IV_ZZSTCODE_I                  TYPE        ZMM_L_STATUS_I
* | [--->] IV_ZZSTCODE_E                  TYPE        ZMM_L_STATUS_E
* | [--->] IV_ZZEK5_AUFSCHLAG             TYPE        ZMM_L_EK5_AUF
* | [--->] IV_ZZEK1_AUFSCHLAG             TYPE        ZMM_L_EK1_AUF
* | [--->] IV_ZZEK5_ABSCHLAG              TYPE        ZMM_L_EK5_AB
* | [--->] IV_ZZPREIS_B                   TYPE        ZMM_L_PREIS_BASIS
* | [--->] IV_ZZMHD                       TYPE        ZMM_L_MHD
* | [<---] E_SUCCESS                      TYPE        CHAR1
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD insert_marc_single BY DATABASE PROCEDURE
                            FOR HDB
                            LANGUAGE SQLSCRIPT
                            USING marc.

INSERT INTO marc ( MANDT, MATNR, WERKS, PSTAT, LVORM, BWTTY, XCHAR, MMSTA, MMSTD, MAABC, KZKRI, EKGRP, AUSME, DISPR, DISMM, DISPO, KZDIE, PLIFZ, WEBAZ, PERKZ, AUSSS, DISLS,
                  BESKZ, SOBSL, MINBE, EISBE, BSTMI, BSTMA, BSTFE, BSTRF, MABST, LOSFX, SBDKZ, LAGPR, ALTSL, KZAUS, AUSDT, NFMAT, KZBED, MISKZ, FHORI, PFREI, FFREI, RGEKZ,
                  FEVOR, BEARZ, RUEZT, TRANZ, BASMG, DZEIT, MAXLZ, LZEIH, KZPRO, GPMKZ, UEETO, UEETK, UNETO, WZEIT, ATPKZ, VZUSL, HERBL, INSMK, SPROZ, QUAZT, SSQSS, MPDAU,
                  KZPPV, KZDKZ, WSTGH, PRFRQ, NKMPR, UMLMC, LADGR, XCHPF, USEQU, LGRAD, AUFTL, PLVAR, OTYPE, OBJID, MTVFP, PERIV, KZKFK, VRVEZ, VBAMG, VBEAZ, LIZYK, BWSCL,
                  KAUTB, KORDB, STAWN, HERKL, HERKR, EXPME, MTVER, PRCTR, TRAME, MRPPP, SAUFT, FXHOR, VRMOD, VINT1, VINT2, VERKZ, STLAL, STLAN, PLNNR, APLAL, LOSGR, SOBSK,
                  FRTME, LGPRO, DISGR, KAUSF, QZGTP, QMATV, TAKZT, RWPRO, COPAM, ABCIN, AWSLS, SERNP, CUOBJ, STDPD, SFEPR, XMCNG, QSSYS, LFRHY, RDPRF, VRBMT, VRBWK, VRBDT,
                  VRBFK, AUTRU, PREFE, PRENC, PRENO, PREND, PRENE, PRENG, ITARK, SERVG, KZKUP, STRGR, CUOBV, LGFSB, SCHGT, CCFIX, EPRIO, QMATA, RESVP, PLNTY, UOMGR, UMRSL,
                  ABFAC, SFCPF, SHFLG, SHZET, MDACH, KZECH, MEGRU, MFRGR, SFTY_STK_METH, PROFIL, VKUMC, VKTRW, KZAGL, FVIDK, FXPRU, LOGGR, FPRFM, GLGMG, VKGLG, INDUS, MOWNR,
                  MOGRU, CASNR, GPNUM, STEUC, FABKZ, MATGR, VSPVB, DPLFS, DPLPU, DPLHO, MINLS, MAXLS, FIXLS, LTINC, COMPL, CONVT, SHPRO, AHDIS, DIBER, KZPSP, OCMPF, APOKZ,
                  MCRUE, LFMON, LFGJA, EISLO, NCOST, ROTATION_DATE, UCHKZ, UCMAT, EXCISE_TAX_RLVNCE, TEMP_CTRL_MAX, TEMP_CTRL_MIN, TEMP_UOM, JITPRODNCONFPROFILE, BWESB,
                  SGT_COVS, SGT_STATC, SGT_SCOPE, SGT_MRPSI, SGT_PRCM, SGT_CHINT, SGT_STK_PRT, SGT_DEFSC, SGT_MRP_ATP_STATUS, SGT_MMSTD, FSH_MG_ARUN_REQ, FSH_SEAIM, FSH_VAR_GROUP,
                  FSH_KZECH, FSH_CALENDAR_GROUP, ARUN_FIX_BATCH, PPSKZ, CONS_PROCG, GI_PR_TIME, MULTIPLE_EKGRP, REF_SCHEMA, MIN_TROC, MAX_TROC, TARGET_STOCK, NF_FLAG, "/CWM/UMLMC",
                  "/CWM/TRAME", "/CWM/BWESB", SCM_MATLOCID_GUID16, SCM_MATLOCID_GUID22, SCM_GRPRT, SCM_GIPRT, SCM_SCOST, SCM_RELDT, SCM_RRP_TYPE, SCM_HEUR_ID, SCM_PACKAGE_ID,
                  SCM_SSPEN, SCM_GET_ALERTS, SCM_RES_NET_NAME, SCM_CONHAP, SCM_HUNIT, SCM_CONHAP_OUT, SCM_HUNIT_OUT, SCM_SHELF_LIFE_LOC, SCM_SHELF_LIFE_DUR, SCM_MATURITY_DUR,
                  SCM_SHLF_LFE_REQ_MIN, SCM_SHLF_LFE_REQ_MAX, SCM_LSUOM, SCM_REORD_DUR, SCM_TARGET_DUR, SCM_TSTRID, SCM_STRA1, SCM_PEG_PAST_ALERT, SCM_PEG_FUTURE_ALERT, SCM_PEG_STRATEGY,
                  SCM_PEG_WO_ALERT_FST, SCM_FIXPEG_PROD_SET, SCM_WHATBOM, SCM_RRP_SEL_GROUP, SCM_INTSRC_PROF, SCM_PRIO, SCM_MIN_PASS_AMOUNT, SCM_PROFID, SCM_GES_MNG_USE, SCM_GES_BST_USE,
                  ESPPFLG, SCM_THRUPUT_TIME, SCM_TPOP, SCM_SAFTY_V, SCM_PPSAFTYSTK, SCM_PPSAFTYSTK_V, SCM_REPSAFTY, SCM_REPSAFTY_V, SCM_REORD_V, SCM_MAXSTOCK_V, SCM_SCOST_PRCNT,
                  SCM_PROC_COST, SCM_NDCOSTWE, SCM_NDCOSTWA, SCM_CONINP, CONF_GMSYNC, SCM_IUNIT, SCM_SFT_LOCK, DUMMY_PLNT_INCL_EEW_PS, "/CMD/MB_EIRES", "/CMD/MB_LFTAG", "/CMD/MB_SITAG",
                  "/CMD/MB_GESTG", "/CMD/MB_MAXLG", "/CMD/MB_FAKER", "/CMD/MB_ASCHL", "/SAPMP/TOLPRPL", "/SAPMP/TOLPRMI", "/STTPEC/SERVALID", "/VSO/R_PKGRP", "/VSO/R_LANE_NUM",
                  "/VSO/R_PAL_VEND", "/VSO/R_FORK_DIR", IUID_RELEVANT, IUID_TYPE, UID_IEA, DPCBT, ZZEIRES, ZZLFTAG, ZZSITAG, ZZGESTG, ZZMAXLG, ZZFAKER, ZZASCHL, ZZLFSPME, ZZALTMN,
                  ZZGEMA, ZZUHG, ZZEK1, ZZEK2, ZZEK5, ZZEK6, ZZSTCODE_I, ZZSTCODE_E, ZZEK5_AUFSCHLAG, ZZEK1_AUFSCHLAG, ZZEK5_ABSCHLAG, ZZPREIS_B, ZZMHD )
VALUES ( iv_mandt,iv_matnr,iv_werks,iv_pstat,iv_lvorm,iv_bwtty,iv_xchar,iv_mmsta,iv_mmstd,iv_maabc,iv_kzkri,iv_ekgrp,iv_ausme,iv_dispr,iv_dismm,iv_dispo,iv_kzdie,iv_plifz,iv_webaz,
         iv_perkz,iv_ausss,iv_disls,iv_beskz,iv_sobsl,iv_minbe,iv_eisbe,iv_bstmi,iv_bstma,iv_bstfe,iv_bstrf,iv_mabst,iv_losfx,iv_sbdkz,iv_lagpr,iv_altsl,iv_kzaus,iv_ausdt,iv_nfmat,
         iv_kzbed,iv_miskz,iv_fhori,iv_pfrei,iv_ffrei,iv_rgekz,iv_fevor,iv_bearz,iv_ruezt,iv_tranz,iv_basmg,iv_dzeit,iv_maxlz,iv_lzeih,iv_kzpro,iv_gpmkz,iv_ueeto,iv_ueetk,iv_uneto,
         iv_wzeit,iv_atpkz,iv_vzusl,iv_herbl,iv_insmk,iv_sproz,iv_quazt,iv_ssqss,iv_mpdau,iv_kzppv,iv_kzdkz,iv_wstgh,iv_prfrq,iv_nkmpr,iv_umlmc,iv_ladgr,iv_xchpf,iv_usequ,iv_lgrad,
         iv_auftl,iv_plvar,iv_otype,iv_objid,iv_mtvfp,iv_periv,iv_kzkfk,iv_vrvez,iv_vbamg,iv_vbeaz,iv_lizyk,iv_bwscl,iv_kautb,iv_kordb,iv_stawn,iv_herkl,iv_herkr,iv_expme,iv_mtver,
         iv_prctr,iv_trame,iv_mrppp,iv_sauft,iv_fxhor,iv_vrmod,iv_vint1,iv_vint2,iv_verkz,iv_stlal,iv_stlan,iv_plnnr,iv_aplal,iv_losgr,iv_sobsk,iv_frtme,iv_lgpro,iv_disgr,iv_kausf,
         iv_qzgtp,iv_qmatv,iv_takzt,iv_rwpro,iv_copam,iv_abcin,iv_awsls,iv_sernp,iv_cuobj,iv_stdpd,iv_sfepr,iv_xmcng,iv_qssys,iv_lfrhy,iv_rdprf,iv_vrbmt,iv_vrbwk,iv_vrbdt,iv_vrbfk,
         iv_autru,iv_prefe,iv_prenc,iv_preno,iv_prend,iv_prene,iv_preng,iv_itark,iv_servg,iv_kzkup,iv_strgr,iv_cuobv,iv_lgfsb,iv_schgt,iv_ccfix,iv_eprio,iv_qmata,iv_resvp,iv_plnty,
         iv_uomgr,iv_umrsl,iv_abfac,iv_sfcpf,iv_shflg,iv_shzet,iv_mdach,iv_kzech,iv_megru,iv_mfrgr,iv_sfty_stk_meth,iv_profil,iv_vkumc,iv_vktrw,iv_kzagl,iv_fvidk,iv_fxpru,iv_loggr,
         iv_fprfm,iv_glgmg,iv_vkglg,iv_indus,iv_mownr,iv_mogru,iv_casnr,iv_gpnum,iv_steuc,iv_fabkz,iv_matgr,iv_vspvb,iv_dplfs,iv_dplpu,iv_dplho,iv_minls,iv_maxls,iv_fixls,iv_ltinc,
         iv_compl,iv_convt,iv_shpro,iv_ahdis,iv_diber,iv_kzpsp,iv_ocmpf,iv_apokz,iv_mcrue,iv_lfmon,iv_lfgja,iv_eislo,iv_ncost,iv_rotation_date,iv_uchkz,iv_ucmat,iv_excise_tax_rlvnce,
         iv_temp_ctrl_max,iv_temp_ctrl_min,iv_temp_uom,iv_jitprodnconfprofile,iv_bwesb,iv_sgt_covs,iv_sgt_statc,iv_sgt_scope,iv_sgt_mrpsi,iv_sgt_prcm,iv_sgt_chint,iv_sgt_stk_prt,
         iv_sgt_defsc,iv_sgt_mrp_atp_status,iv_sgt_mmstd,iv_fsh_mg_arun_req,iv_fsh_seaim,iv_fsh_var_group,iv_fsh_kzech,iv_fsh_calendar_group,iv_arun_fix_batch,iv_ppskz,iv_cons_procg,
         iv_gi_pr_time,iv_multiple_ekgrp,iv_ref_schema,iv_min_troc,iv_max_troc,iv_target_stock,iv_nf_flag,iv_cwm_umlmc,iv_cwm_trame,iv_cwm_bwesb,iv_scm_matlocid_guid16,iv_scm_matlocid_guid22,
         iv_scm_grprt,iv_scm_giprt,iv_scm_scost,iv_scm_reldt,iv_scm_rrp_type,iv_scm_heur_id,iv_scm_package_id,iv_scm_sspen,iv_scm_get_alerts,iv_scm_res_net_name,iv_scm_conhap,iv_scm_hunit,
         iv_scm_conhap_out,iv_scm_hunit_out,iv_scm_shelf_life_loc,iv_scm_shelf_life_dur,iv_scm_maturity_dur,iv_scm_shlf_lfe_req_min,iv_scm_shlf_lfe_req_max,iv_scm_lsuom,iv_scm_reord_dur,
         iv_scm_target_dur,iv_scm_tstrid,iv_scm_stra1,iv_scm_peg_past_alert,iv_scm_peg_future_alert,iv_scm_peg_strategy,iv_scm_peg_wo_alert_fst,iv_scm_fixpeg_prod_set,iv_scm_whatbom,
         iv_scm_rrp_sel_group,iv_scm_intsrc_prof,iv_scm_prio,iv_scm_min_pass_amount,iv_scm_profid,iv_scm_ges_mng_use,iv_scm_ges_bst_use,iv_esppflg,iv_scm_thruput_time,iv_scm_tpop,
         iv_scm_safty_v,iv_scm_ppsaftystk,iv_scm_ppsaftystk_v,iv_scm_repsafty,iv_scm_repsafty_v,iv_scm_reord_v,iv_scm_maxstock_v,iv_scm_scost_prcnt,iv_scm_proc_cost,iv_scm_ndcostwe,
         iv_scm_ndcostwa,iv_scm_coninp,iv_conf_gmsync,iv_scm_iunit,iv_scm_sft_lock,iv_dummy_plnt_incl_eew_ps,iv_cmd_mb_eires,iv_cmd_mb_lftag,iv_cmd_mb_sitag,iv_cmd_mb_gestg,iv_cmd_mb_maxlg,
         iv_cmd_mb_faker,iv_cmd_mb_aschl,iv_sapmp_tolprpl,iv_sapmp_tolprmi,iv_sttpec_servalid,iv_vso_r_pkgrp,iv_vso_r_lane_num,iv_vso_r_pal_vend,iv_vso_r_fork_dir,iv_iuid_relevant,
         iv_iuid_type,iv_uid_iea,iv_dpcbt,iv_zzeires,iv_zzlftag,iv_zzsitag,iv_zzgestg,iv_zzmaxlg,iv_zzfaker,iv_zzaschl,iv_zzlfspme,iv_zzaltmn,iv_zzgema,iv_zzuhg,iv_zzek1,iv_zzek2,
         iv_zzek5,iv_zzek6,iv_zzstcode_i,iv_zzstcode_e,iv_zzek5_aufschlag,iv_zzek1_aufschlag,iv_zzek5_abschlag,iv_zzpreis_b,iv_zzmhd);
    e_success = 'X';

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_MIG_MARC_UTIL=>DELETE_MARC_SINGLE
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_MANDT                       TYPE        MANDT
* | [--->] IV_MATNR                       TYPE        MATNR
* | [--->] IV_WERKS                       TYPE        WERKS_D
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD delete_marc_single BY DATABASE PROCEDURE
                            FOR HDB
                            LANGUAGE SQLSCRIPT
                            USING marc.

    DELETE FROM marc WHERE MANDT = iv_MANDT AND MATNR = IV_MATNR and WERKS = iv_WERKS;

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_MIG_MARC_UTIL=>UPDATE_MARC_VALIFROM_SINGLE
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_MANDT                       TYPE        MANDT
* | [--->] IV_MATNR                       TYPE        MATNR
* | [--->] IV_WERKS                       TYPE        WERKS_D
* | [--->] IV_MMSTD                       TYPE        MMSTD
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD update_marc_valifrom_single BY DATABASE PROCEDURE
                                     FOR HDB
                                     LANGUAGE SQLSCRIPT
                                     USING marc.
    UPDATE marc SET mmstd = iv_mmstd WHERE MANDT = iv_MANDT AND MATNR = IV_MATNR and WERKS = iv_WERKS;
  ENDMETHOD.
ENDCLASS.
