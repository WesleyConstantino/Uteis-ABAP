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
