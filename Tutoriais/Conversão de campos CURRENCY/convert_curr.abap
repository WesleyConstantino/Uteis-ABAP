"Para converter um campo CURR, fazemos como no exemplo abaixo:

*&---------------------------------------------------------------------*
*&      Form  TRATA_REC
*&---------------------------------------------------------------------*
"FORM trata_rec USING p_wa_arquivo TYPE ty_arquivo.
*-------* Vaariáveis para conversão dos campos CURR
  DATA: lv_zvlor_dmbtr TYPE dmbtr,
        lv_zvljr_dmbtr TYPE dmbtr,
        lv_zvlmt_dmbtr TYPE dmbtr,
        lv_zvlab_dmbtr TYPE dmbtr,
        lv_zvlde_dmbtr TYPE dmbtr,
        lv_zvlfi_dmbtr TYPE dmbtr.

  "wa_rec-zdtge  = p_wa_arquivo-registro+155(8).
  "wa_rec-znusq  = p_wa_arquivo-registro+731(10).
  wa_rec-ztprg  = p_wa_arquivo-registro+0(1).
  "wa_rec-BUKRS = p_wa_arquivo-registro+36(4).
  "wa_rec-HBKID = p_wa_arquivo-registro+54(5).
  "wa_rec-HKTID = p_wa_arquivo-registro+54(5).
  wa_rec-ztxid  = p_wa_arquivo-registro+1(35).
  "wa_rec-zispb  = p_wa_arquivo-registro+36(1).
  "wa_rec-ztpps  = p_wa_arquivo-registro+44(2).
  "wa_rec-zcnpj  = p_wa_arquivo-registro+46(16).
  "wa_rec-zagen  = p_wa_arquivo-registro+60(4).
  "wa_rec-zconc  = p_wa_arquivo-registro+64(20).
  "wa_rec-ztpco  = p_wa_arquivo-registro+84(4).
  "wa_rec-zcpix  = p_wa_arquivo-registro+88(77).
  "wa_rec-ztpcr  = p_wa_arquivo-registro+165(1).
  "wa_rec-zcodm  = p_wa_arquivo-registro+166(2).
  "wa_rec-zdtmv  = p_wa_arquivo-registro+168(8).
  "wa_rec-zdtvc  = p_wa_arquivo-registro+176(8).
  "wa_rec-ztime  = p_wa_arquivo-registro+184(14).
  DATA(lv_zvlor)  = p_wa_arquivo-registro+198(17). "CURR de 15 pos e 2 dec.
  DATA(lv_zvljr)  = p_wa_arquivo-registro+215(17). "CURR de 15 pos e 2 dec.
  DATA(lv_zvlmt)  = p_wa_arquivo-registro+232(17). "CURR de 15 pos e 2 dec.
  DATA(lv_zvlab)  = p_wa_arquivo-registro+249(17). "CURR de 15 pos e 2 dec.
  DATA(lv_zvlde)  = p_wa_arquivo-registro+266(17). "CURR de 15 pos e 2 dec.
  DATA(lv_zvlfi)  = p_wa_arquivo-registro+283(17). "CURR de 15 pos e 2 dec.
  DATA(lv_zvlpg)  = p_wa_arquivo-registro+300(17). "CURR de 15 pos e 2 dec.
  "wa_rec-ztpdv  = p_wa_arquivo-registro+317(2).
  "wa_rec-zcnpd  = p_wa_arquivo-registro+319(14).
  "wa_rec-ztppf  = p_wa_arquivo-registro+333(2).
  "wa_rec-zcnpf  = p_wa_arquivo-registro+335(14).
  "wa_rec-znpgf  = p_wa_arquivo-registro+349(140).
  "wa_rec-zmsgp  = p_wa_arquivo-registro+489(140).
  "wa_rec-zendt  = p_wa_arquivo-registro+631(32).
  "wa_rec-zrevs  = p_wa_arquivo-registro+663(4).
  "wa_rec-zexre  = p_wa_arquivo-registro+667(60).
  "wa_rec-ztarf  = p_wa_arquivo-registro+727(17).
  "wa_rec-znseq  = p_wa_arquivo-registro+744(6).

*-------* Conversão dos campos CURR:
  CONDENSE: lv_zvlor,
            lv_zvljr,
            lv_zvlmt,
            lv_zvlab,
            lv_zvlde,
            lv_zvlfi.

  MOVE lv_zvlor TO lv_zvlor_dmbtr.
  MOVE lv_zvljr TO lv_zvljr_dmbtr.
  MOVE lv_zvlmt TO lv_zvlmt_dmbtr.
  MOVE lv_zvlab TO lv_zvlab_dmbtr.
  MOVE lv_zvlde TO lv_zvlde_dmbtr.
  MOVE lv_zvlfi TO lv_zvlfi_dmbtr.

  wa_rec-zvlor = lv_zvlor_dmbtr.
  wa_rec-zvljr = lv_zvljr_dmbtr.
  wa_rec-zvlmt = lv_zvlmt_dmbtr.
  wa_rec-zvlab = lv_zvlab_dmbtr.
  wa_rec-zvlde = lv_zvlde_dmbtr.
  wa_rec-zvlfi = lv_zvlfi_dmbtr.


  "APPEND wa_rec TO ti_rec.
  "INSERT zfipixt_retrec FROM wa_rec.
  "PERFORM zf_commit_e_rollback.
  "CLEAR  wa_rec.
"ENDFORM.
