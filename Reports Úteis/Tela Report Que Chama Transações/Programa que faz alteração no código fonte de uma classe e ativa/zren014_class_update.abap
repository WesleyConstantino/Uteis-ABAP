report zren014_class_update.

* Altera o CORPO de um método de classe existente e o deixa efetivo,
* replicando a lógica do zren14_abapgit.abap (abapGit single-file):
*
*   SEO_BUFFER_INIT / SEO_BUFFER_REFRESH (versão inativa)
*   -> INSERT REPORT no include do método (versão ATIVA, sem STATE)
*   -> regenera o include completo (.CS) e atualiza SEO_CS_CACHE
*   -> SEO_CLASS_GENERATE_CLASSPOOL (gera/regenera o class pool)
*   -> COMMIT WORK AND WAIT
*   -> where-used via CL_WB_CROSSREFERENCE
*
* Assim como o abapGit, a classe NÃO é enviada para a
* RS_WORKING_OBJECTS_ACTIVATE: o fonte é gravado direto na versão ativa e a
* geração do class pool é feita por SEO_CLASS_GENERATE_CLASSPOOL.

parameters: p_clsn type seoclsname obligatory,
            p_mtdn type seocpdname obligatory,
            p_file    type rlgrap-filename obligatory,
            p_wher as checkbox default abap_true.

data: gt_new     type string_table,
      gt_old     type string_table,
      gt_cs      type string_table,
      gt_cs_new  type string_table,
      gv_include type syrepid.

start-of-selection.

  perform run.

*&---------------------------------------------------------------------*
*&      Form  run
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
form run.

  data: ls_mtdkey type seocpdkey,
        ls_clskey type seoclskey.

  ls_mtdkey-clsname = p_clsn.
  ls_mtdkey-cpdname = p_mtdn.
  ls_clskey-clsname = p_clsn.

* 1) resolve o include de implementação do método
*    (replica zren14_abapgit linha 122012)
  perform get_method_include using ls_mtdkey.

* 2) limpa e recarrega o buffer SEO na versão INATIVA
*    (replica 122516-122520 - sem isso o CLIF_SOURCE reordena métodos
*    alfabeticamente)
  call function 'SEO_BUFFER_INIT'.
  call function 'SEO_BUFFER_REFRESH'
    exporting
      cifkey  = ls_clskey
      version = seoc_version_inactive.

* 3) lê o corpo atual do método (versão ativa, para comparação)
  read report gv_include into gt_old.
  if sy-subrc <> 0.
    message e001(00) with 'Erro ao ler' gv_include 'do método' p_mtdn.
  endif.

* 4) carrega e valida o novo corpo a partir do arquivo
  perform upload_source changing gt_new.
  perform validate_source using p_mtdn changing gt_new.

* 5) compara e grava (replica update_report 120770-120792)
  if gt_new = gt_old.
    message s001(00) with 'Corpo do método já é o informado; nada gravado'.
    return.
  endif.

*    INSERT REPORT sem STATE = grava na versão ATIVA (replica 120649)
  insert report gv_include from gt_new program type 'I'.
  if sy-subrc <> 0.
    message e001(00) with 'Erro no INSERT REPORT' gv_include.
  endif.

* 6) regenera o include completo (.CS) e atualiza SEO_CS_CACHE
*    (replica update_full_class_include + update_cs_number_of_methods
*     122255-122271)
  perform update_full_class_include.

* 7) regenera o class pool (replica generate_classpool 122047)
*    antes, recarrega o buffer na versão ATIVA - igual ao abapGit faz em
*    update_meta (122282) antes de chamar SEO_CLASS_GENERATE_CLASSPOOL
  call function 'SEO_BUFFER_REFRESH'
    exporting
      cifkey  = ls_clskey
      version = seoc_version_active.
  perform generate_classpool using ls_clskey.

* 8) persiste tudo antes de considerar a classe ativa (replica 128435)
  commit work and wait.

* 9) refaz o índice where-used (replica update_where_used 128867)
  if p_wher = abap_true.
    perform refresh_where_used using p_clsn.
  endif.

  message s001(00) with 'Método' p_mtdn 'atualizado no include' gv_include.

endform.                    "run

*&---------------------------------------------------------------------*
*&      Form  get_method_include
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->IV_MTDKEY  text
*----------------------------------------------------------------------*
form get_method_include using iv_mtdkey type seocpdkey.

  data: lx_ex type ref to cx_root.

  try.
      cl_oo_classname_service=>get_method_include(
        exporting
          mtdkey              = iv_mtdkey
        receiving
          result              = gv_include
        exceptions
          method_not_existing = 1 ).
      if sy-subrc <> 0.
        message e001(00) with 'Método' iv_mtdkey-cpdname
                          'não existe na classe' iv_mtdkey-clsname.
      endif.
    catch cx_root into lx_ex.
      message e001(00) with 'Erro'. "lx_ex->get_text( ).
  endtry.

endform.                    "get_method_include

*&---------------------------------------------------------------------*
*&      Form  upload_source
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      <--CT_SOURCE  text
*----------------------------------------------------------------------*
form upload_source changing ct_source type string_table.

  field-symbols <ls_line> like line of ct_source.

  data: ls_file type string.

  ls_file = p_file.

  cl_gui_frontend_services=>gui_upload(
    exporting
      filename                = ls_file
      filetype                = 'ASC'
      codepage                = '4110'
    changing
      data_tab                = ct_source
    exceptions
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
      not_supported_by_gui    = 17
      error_no_gui            = 18
      others                  = 19 ).
  if sy-subrc <> 0.
    message e001(00) with 'Erro ao carregar arquivo' p_file 'subrc' sy-subrc.
  endif.

  if ct_source is initial.
    message e001(00) with 'Arquivo' p_file 'está vazio'.
  endif.

* linhas de fonte ABAP não guardam espaços ao final; normaliza para
* permitir uma comparação justa com o que está gravado no sistema
  loop at ct_source assigning <ls_line>.
    shift <ls_line> right deleting trailing space.
  endloop.

endform.                    "upload_source

*&---------------------------------------------------------------------*
*&      Form  validate_source
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->IV_METHOD  text
*      <--CT_SOURCE  text
*----------------------------------------------------------------------*
form validate_source using iv_method type seocpdname
                     changing ct_source type string_table.

  data: lv_first type string,
        lv_last  type string,
        lv_count type i,
        ls_regex type string.

  read table ct_source index 1 into lv_first.
  read table ct_source index lines( ct_source ) into lv_last.

  concatenate '^\s*METHOD\s+' iv_method  '\s*\.' into ls_regex.

  find regex ls_regex in lv_first ignoring case.
  if sy-subrc <> 0.
    message e001(00) with 'Primeira linha não é METHOD' iv_method '.'.
  endif.
  ls_regex = '^\s*ENDMETHOD\.\s*$' .


  find regex ls_regex in lv_last ignoring case.
  if sy-subrc <> 0.
    message e001(00) with 'Última linha não é ENDMETHOD.'.
  endif.

  describe table ct_source lines lv_count.
  if lv_count < 3.
    message e001(00) with 'Corpo do método muito pequeno (mínimo 3 linhas)'.
  endif.

endform.                    "validate_source

*&---------------------------------------------------------------------*
*&      Form  update_full_class_include
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
form update_full_class_include.

  data: lv_cs       type syrepid,
        lv_replaced type abap_bool.

  lv_cs = cl_oo_classname_service=>get_cs_name( p_clsn ).

* o include .CS é gerado "on the fly" em alguns sistemas; se não existir,
* não é bloqueante - o que importa para o runtime é o include do método
* + a regeneração do class pool
  read report lv_cs into gt_cs.
  if sy-subrc <> 0.
    message s001(00) with 'Include completo (.CS) não existe; pulando regeneração'.
    perform update_cs_number_of_methods using p_clsn.
    return.
  endif.

  gt_cs_new = gt_cs.

  perform replace_method_in_source
    using    p_mtdn gt_new
    changing gt_cs_new lv_replaced.

  if lv_replaced = abap_false.
    message s001(00) with 'Método não encontrado no include .CS; pulando regeneração'.
    perform update_cs_number_of_methods using p_clsn.
    return.
  endif.

*   replica create_report (122260-122265): estado ativo, extensão CS, tipo I
  insert report lv_cs from gt_cs_new state 'A'
    extension type 'CS' program type 'I'.
  if sy-subrc <> 0.
    message e001(00) with 'Erro no INSERT REPORT' lv_cs.
  endif.

  perform update_cs_number_of_methods using p_clsn.

endform.                    "update_full_class_include

*&---------------------------------------------------------------------*
*&      Form  replace_method_in_source
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->IV_METHOD    text
*      -->IT_NEW       text
*      <--CT_SOURCE    text
*      <--CV_REPLACED  text
*----------------------------------------------------------------------*
form replace_method_in_source using iv_method type seocpdname
                                     it_new    type string_table
                               changing ct_source type string_table
                                        cv_replaced type abap_bool.

  data: lv_start type i,
        lv_end   type i,
        ls_regex type string.

  field-symbols <ls_line> like line of ct_source.

  cv_replaced = abap_false.

  concatenate '^\s*METHOD\s+' iv_method '\s*\.' into ls_regex.
  loop at ct_source assigning <ls_line>.
    find regex ls_regex in <ls_line> ignoring case.
    if sy-subrc = 0.
      lv_start = sy-tabix.
      exit.
    endif.
  endloop.
  if lv_start = 0.
    return.
  endif.

* métodos não podem ser aninhados, então o primeiro ENDMETHOD. após o
* METHOD é o fim do bloco
  ls_regex =  '^\s*ENDMETHOD\.\s*$'.
  loop at ct_source assigning <ls_line> from lv_start + 1.
    find regex ls_regex in <ls_line> ignoring case.
    if sy-subrc = 0.
      lv_end = sy-tabix.
      exit.
    endif.
  endloop.
  if lv_end = 0.
    return.
  endif.

  delete ct_source from lv_start to lv_end.
  insert lines of it_new into ct_source index lv_start.
  cv_replaced = abap_true.

endform.                    "replace_method_in_source

*&---------------------------------------------------------------------*
*&      Form  update_cs_number_of_methods
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->IV_CLASSNAME  text
*----------------------------------------------------------------------*
form update_cs_number_of_methods using iv_classname type seoclsname.

* acesso indireto ao SEO_CS_CACHE para compatibilidade
* (replica 122225-122252)
  data: lr_cache   type ref to data,
        lt_methods type seop_methods_w_include.
  field-symbols: <lg_cache> type any,
                 <lg_field> type any.

  try.
      create data lr_cache type ('SEO_CS_CACHE').
    catch cx_sy_create_data_error.
      return. " tabela não existe neste sistema
  endtry.

  try.
      cl_oo_classname_service=>get_all_method_includes(
        exporting
          clsname            = iv_classname
        receiving
          result             = lt_methods
        exceptions
          class_not_existing = 1 ).
    catch cx_root.
      return.
  endtry.
  if sy-subrc <> 0.
    return.
  endif.

  assign lr_cache->* to <lg_cache>.
  assert sy-subrc = 0.

  assign component 'CLSNAME' of structure <lg_cache> to <lg_field>.
  assert sy-subrc = 0.
  <lg_field> = iv_classname.

  assign component 'NO_OF_METHOD_IMPLS' of structure <lg_cache> to <lg_field>.
  assert sy-subrc = 0.
  <lg_field> = lines( lt_methods ).

  modify ('SEO_CS_CACHE') from <lg_cache>.

endform.                    "update_cs_number_of_methods

*&---------------------------------------------------------------------*
*&      Form  generate_classpool
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->IS_CLSKEY  text
*----------------------------------------------------------------------*
form generate_classpool using is_clskey type seoclskey.

* replica 122047-122081
  call function 'SEO_CLASS_GENERATE_CLASSPOOL'
    exporting
      clskey                        = is_clskey
      suppress_corr                 = abap_true
    exceptions
      not_existing                  = 1
      model_only                    = 2
      class_pool_not_generated      = 3
      class_stment_not_generated    = 4
      locals_not_generated          = 5
      macros_not_generated          = 6
      public_sec_not_generated      = 7
      protected_sec_not_generated   = 8
      private_sec_not_generated     = 9
      typeref_not_generated         = 10
      class_pool_not_initialised    = 11
      class_stment_not_initialised  = 12
      locals_not_initialised        = 13
      macros_not_initialised        = 14
      public_sec_not_initialised    = 15
      protected_sec_not_initialised = 16
      private_sec_not_initialised   = 17
      typeref_not_initialised       = 18
      _internal_class_overflow      = 19
      others                        = 20.
  if sy-subrc <> 0.
    message e001(00) with 'Erro ao gerar class pool da classe'
                      is_clskey-clsname 'subrc' sy-subrc.
  endif.

endform.                    "generate_classpool

*&---------------------------------------------------------------------*
*&      Form  refresh_where_used
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->IV_CLASSNAME  text
*----------------------------------------------------------------------*
form refresh_where_used using iv_classname type seoclsname.

* replica update_where_used 128867-128901
  data: lo_cross type ref to cl_wb_crossreference,
        lv_cp    type syrepid,
        lv_error type c length 1.

  lv_cp = cl_oo_classname_service=>get_classpool_name( iv_classname ).

  create object lo_cross
    exporting
      p_name    = lv_cp
      p_include = lv_cp.

  lo_cross->index_actualize( importing p_error = lv_error ).

  if lv_error = abap_true.
    message s001(00) with 'Erro ao atualizar where-used da classe'
                      iv_classname '; verifique sintaxe'.
  endif.

endform.                    "refresh_where_used
