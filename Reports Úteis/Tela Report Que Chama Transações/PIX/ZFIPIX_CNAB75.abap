*&---------------------------------------------------------------------*
*& Report  ZFIPIX_CNAB75
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT zfipix_cnab75 MESSAGE-ID 00.


*----------------------------------------------------------------------*
* Tabelas                                                              *
*----------------------------------------------------------------------*
TABLES:
  zfipixt_retrec,
  zfipixt_retreg.

*----------------------------------------------------------------------*
* Tipos                                                                *
*----------------------------------------------------------------------*
* Arquivo
TYPES:
  BEGIN OF ty_arquivo,
    registro(750) TYPE c,
  END OF ty_arquivo.

*----------------------------------------------------------------------*
* Constantes                                                           *
*----------------------------------------------------------------------*
CONSTANTS:
  c_dir_in      TYPE string                   VALUE '/interfac/FI/extrato/Cnab750/pendente/',
  c_dirout      TYPE string                   VALUE '/interfac/FI/extrato/Cnab750/processado/',
  c_e           TYPE char01                   VALUE 'E',
  c_i           TYPE char01                   VALUE 'I',
  c_o           TYPE char01                   VALUE 'O',
  c_filter_unix TYPE epsf-epsfilnam           VALUE 'CNAB750*.*'.


*----------------------------------------------------------------------*
* Variáveis
*----------------------------------------------------------------------*
DATA:
  gv_extension  TYPE string,
  gv_filter     TYPE string,
  gv_filter_loc TYPE string  VALUE 'CNAB750*.txt',
  gv_path       TYPE localfile,
  gv_zdtge(8),
  gv_znusq(10),
  gv_paval(8),
  gv_bankn(20),
  gv_bukrs(4),
  gv_hbkid(5),
  gv_hktid(5).


*----------------------------------------------------------------------*
* Tabelas                                                              *
*----------------------------------------------------------------------*
DATA:
  ti_lista   TYPE TABLE OF epsfili,
  ti_arquivo TYPE TABLE OF ty_arquivo,
  ti_rec     TYPE TABLE OF zfipixt_retrec,
  ti_reg     TYPE TABLE OF zfipixt_retreg.


*----------------------------------------------------------------------*
* Workareas                                                            *
*----------------------------------------------------------------------*
DATA:
  wa_lista   TYPE epsfili,
  wa_arquivo TYPE ty_arquivo,
  wa_rec     TYPE zfipixt_retrec,
  wa_reg     TYPE zfipixt_retreg.


*----------------------------------------------------------------------*
* SELECTION-SCREEN                                                     *
*----------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-t01.

PARAMETERS:
  p_dir_in TYPE rlgrap-filename,   "Diretorio de Entrada
  p_dirout TYPE rlgrap-filename,   "Diretorio de Processados

  p_unix   RADIOBUTTON GROUP grp1 USER-COMMAND arq DEFAULT 'X',
  p_local  RADIOBUTTON GROUP grp1.

SELECTION-SCREEN END OF BLOCK b1.


*----------------------------------------------------------------------*
* AT SELECTION-SCREEN ON VALUE-REQUEST                                 *
*----------------------------------------------------------------------*
AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_dir_in .
  PERFORM busca_diretorio USING c_i CHANGING p_dir_in.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_dirout .
  PERFORM busca_diretorio USING c_o CHANGING p_dirout.


*----------------------------------------------------------------------*
* AT SELECTION-SCREEN                                                  *
*----------------------------------------------------------------------*
AT SELECTION-SCREEN.

  PERFORM limpa_diretorio.


*----------------------------------------------------------------------*
* INITIALIZATION.                                                      *
*----------------------------------------------------------------------*
INITIALIZATION.

  PERFORM inicia_valores.

*----------------------------------------------------------------------*
* START-OF-SELECTION                                                   *
*----------------------------------------------------------------------*
START-OF-SELECTION.

  PERFORM:
    validar_tela,
    buscar_arquivo,
    processar_arquivo.

*&---------------------------------------------------------------------*
*&      Form  VALIDAR_TELA
*&---------------------------------------------------------------------*
* Checar os dados informados na tela seleção
*----------------------------------------------------------------------*
FORM validar_tela .
  DATA:
    lv_path     TYPE localfile,
    lv_filename TYPE localfile.

  IF p_dir_in IS INITIAL.
    MESSAGE s208 WITH text-e01 DISPLAY LIKE c_e.
    STOP.
  ELSEIF p_dirout IS INITIAL.
    MESSAGE s208 WITH text-e02 DISPLAY LIKE c_e.
    STOP.
  ENDIF.

* NÃO Permitir nome arquivo no diretorio de Processados.
  PERFORM busca_pasta USING p_dirout CHANGING lv_path lv_filename.
  IF lv_filename IS NOT INITIAL.
* MSG: Não é permitido informar arquivo em PROCESSADOS.
    MESSAGE s208 WITH text-e12 DISPLAY LIKE c_e.
    STOP.
  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  BUSCAR_ARQUIVO
*&---------------------------------------------------------------------*
* Buscar os dados do(s) Arquivo(s) a ser(em) processado(s).
*----------------------------------------------------------------------*
FORM buscar_arquivo .

  DATA:
    lv_filename TYPE localfile,
    lv_dir_name TYPE epsf-epsdirnam,
    lv_dir      TYPE string,
    lv_count    TYPE i,
    ti_arq_tmp  TYPE TABLE OF file_info,
    lv_length   TYPE i,
    lv_ext      TYPE char4.

  PERFORM busca_pasta USING p_dir_in CHANGING gv_path lv_filename.

  IF lv_filename IS INITIAL.
    IF p_unix EQ abap_true.

      lv_dir_name = p_dir_in.
      CALL FUNCTION 'EPS_GET_DIRECTORY_LISTING'
        EXPORTING
          dir_name               = lv_dir_name
          file_mask              = c_filter_unix
        TABLES
          dir_list               = ti_lista
        EXCEPTIONS
          invalid_eps_subdir     = 1
          sapgparam_failed       = 2
          build_directory_failed = 3
          no_authorization       = 4
          read_directory_failed  = 5
          too_many_read_errors   = 6
          empty_directory_list   = 7
          OTHERS                 = 8.

      IF sy-subrc EQ 0.
        LOOP AT ti_lista ASSIGNING FIELD-SYMBOL(<fs_lista>).
          lv_length = strlen( <fs_lista>-name ).
          lv_length = lv_length - 4.
          lv_ext    = <fs_lista>-name+lv_length(4).
          TRANSLATE lv_ext TO UPPER CASE.

* Desconsiderar os arquivos que a Extensão seja <> '.TXT'.
          IF ( lv_ext <> '.TXT' ).
            DELETE ti_lista WHERE name = <fs_lista>-name.
          ENDIF.
        ENDLOOP.
      ENDIF.


      IF ti_lista[] IS INITIAL.
        MESSAGE s208 WITH text-e03 DISPLAY LIKE c_e.
      ENDIF.

    ELSE.

*      IF NOT p_repro IS INITIAL.
*        vl_dir = p_direrr.
*        v_filter_loc = 'PAS*.ERR'.
*      ELSE.
*        vl_dir = p_dir.
*        v_filter_loc = 'PAS*.txt'.
*      ENDIF.

      lv_dir = gv_path.
      CALL METHOD cl_gui_frontend_services=>directory_list_files
        EXPORTING
          directory                   = lv_dir
          filter                      = gv_filter_loc
          files_only                  = 'X'
        CHANGING
          file_table                  = ti_arq_tmp
          count                       = lv_count
        EXCEPTIONS
          cntl_error                  = 1
          directory_list_files_failed = 2
          wrong_parameter             = 3
          error_no_gui                = 4
          not_supported_by_gui        = 5
          OTHERS                      = 6.

      IF sy-subrc <> 0.
        MESSAGE s208 WITH text-e04  DISPLAY LIKE c_e.
        STOP.
      ELSE.
        LOOP AT ti_arq_tmp INTO DATA(wa_arq_tmp).
          wa_lista-name = wa_arq_tmp-filename.
          APPEND wa_lista TO ti_lista.
        ENDLOOP.
      ENDIF.
    ENDIF.
  ELSE.
    wa_lista-name = lv_filename.
    APPEND wa_lista TO ti_lista.
  ENDIF.

  IF lines( ti_lista ) LE 0.
    MESSAGE s208 WITH text-e05 DISPLAY LIKE c_e.
    STOP.
  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  BUSCA_PASTA
*&---------------------------------------------------------------------*
* Separar conteudo do path (entre diretorio e nome arquivo)
*----------------------------------------------------------------------*
FORM busca_pasta  USING    p_lv_dir
                  CHANGING p_lv_path p_lv_filename.

  DATA: lw_split     TYPE string,
        lt_split     LIKE TABLE OF lw_split,
        lv_delimiter TYPE c,
        lv_strlen    TYPE i,
        lv_lines     TYPE i.

  IF p_unix = abap_true.
    lv_delimiter = '/'.
  ELSE.
    lv_delimiter = '\'.
  ENDIF.

  lv_strlen = strlen( p_lv_dir ) - 1.
  CHECK lv_strlen  GE 0.
  IF p_lv_dir+lv_strlen  EQ lv_delimiter
    OR lv_delimiter  IS INITIAL.
    MOVE p_lv_dir TO p_lv_path.
    RETURN.
  ENDIF.

  SPLIT p_lv_dir AT lv_delimiter INTO TABLE lt_split.
  DESCRIBE TABLE lt_split LINES lv_lines.
  LOOP AT lt_split INTO lw_split.
    IF sy-tabix < lv_lines.
      CONCATENATE p_lv_path lw_split lv_delimiter INTO p_lv_path.
    ELSE.
      p_lv_filename = lw_split.
    ENDIF.
  ENDLOOP.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  PROCESSAR_ARQUIVO
*&---------------------------------------------------------------------*
* Processar arquivo carregado para atualizar as tabelas
*----------------------------------------------------------------------*
FORM processar_arquivo .
  DATA:
    lv_ignore_file.

* Preparar os dados de cada arquivo a serem executados
  LOOP AT ti_lista INTO DATA(wa_lista).

    PERFORM carregar_arquivo USING wa_lista-name.
* Limpar todas variáveis para processar este arquivo.
    CLEAR:
      lv_ignore_file,
      gv_zdtge,
      gv_znusq,
      gv_paval,
      gv_bankn,
      gv_bukrs,
      gv_hbkid,
      gv_hktid.

* Processar cada linha arquivo
    LOOP AT ti_arquivo INTO DATA(wa_arquivo).

* Validar formato do arquivo
      IF strlen( wa_arquivo-registro ) NE 750.
* MSG:  Formato do arquivo & inválido
        MESSAGE s398 WITH text-e09 wa_lista-name text-e10 space DISPLAY LIKE c_e.
        EXIT. "Ignorar arquivo !
        lv_ignore_file = abap_true.
      ENDIF.

* Identifica se registro é cabeçalho
      IF wa_arquivo-registro+0(1) = '0' AND
         wa_arquivo-registro+1(1) = '2' AND
         wa_arquivo-registro+9(2) = '02'.
        PERFORM trata_cabecalho USING wa_arquivo wa_lista-name CHANGING lv_ignore_file.

* Se não tiver Header na 1ª linha (msg erro)
* Se não tiver Header  (msg erro)
* Se tiver +1 Header (msg erro)

      ELSEIF wa_arquivo-registro+0(1) = '5'.
* Identifica se registro é item Recebimento (5)
        PERFORM trata_rec USING wa_arquivo.

      ELSEIF wa_arquivo-registro+0(1) = '1'.
* Identifica se registro é item Retorno Registro (1)
        PERFORM trata_reg USING wa_arquivo.
      ENDIF.
    ENDLOOP.

    IF lv_ignore_file IS INITIAL.
* Inserir
      MODIFY:
        zfipixt_retrec FROM TABLE ti_rec,
        zfipixt_retreg FROM TABLE ti_reg.
* Arquivo com sucesso, então Commit nas tabelas
      IF sy-subrc EQ 0.
        COMMIT WORK.
      ENDIF.
* Mover arquivo para diretorio PROCESSADOS
      PERFORM move_arq_processados USING wa_lista-name.
    ENDIF.
  ENDLOOP.
ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  CARREGAR_ARQUIVO
*&---------------------------------------------------------------------*
* Buscar os dados de cada arquivo
*----------------------------------------------------------------------*
FORM carregar_arquivo USING lv_file_name.

  CONCATENATE gv_path lv_file_name INTO DATA(lv_path_file).

* Exibir Status ao usuario
  PERFORM mostra_progresso USING: text-t02 lv_path_file space space.

* Se for LOCAL (Windows)
  IF p_local = abap_true.

* Lê arquivo de textos adicionais para execução on-line do programa
    CALL FUNCTION 'GUI_UPLOAD'
      EXPORTING
        filename                = lv_path_file
      TABLES
        data_tab                = ti_arquivo
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

* Se não conseguiu abrir o arquivo, exibe mensagem de erro.
    IF sy-subrc IS NOT INITIAL.
* MSG:  arquivo & não encontrado
      MESSAGE s398 WITH text-e06 lv_file_name text-e07 space DISPLAY LIKE c_e.
      STOP.
    ENDIF.

  ELSE.
    OPEN DATASET lv_path_file IN TEXT MODE FOR INPUT ENCODING NON-UNICODE.

* Se não conseguiu abrir o arquivo, exibe mensagem de erro.
    IF sy-subrc <> 0.
* MSG:  arquivo & não encontrado
      MESSAGE s398 WITH text-e06 lv_file_name text-e07 space DISPLAY LIKE c_e.
      RETURN.
    ELSE.

* Lê registro do arquivo
      DO.
        READ DATASET lv_path_file INTO wa_arquivo.
        IF sy-subrc IS INITIAL.
          APPEND wa_arquivo TO ti_arquivo.
        ELSE.
          EXIT.
        ENDIF.
      ENDDO.

      CLOSE DATASET lv_path_file.
    ENDIF.
  ENDIF.


  IF ti_arquivo[] IS INITIAL.
* Não existem dados no arquivo.
    MESSAGE s208 WITH text-e08 DISPLAY LIKE c_e.
    RETURN.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  MOSTRA_PROGRESSO
*&---------------------------------------------------------------------*
* Exibe dados de progresso para usuário
*----------------------------------------------------------------------*
FORM mostra_progresso USING p_msg1 p_msg2 p_msg3 p_msg4.

  DATA: lv_text TYPE char250.

  IF p_local = abap_true.
    MESSAGE i398 WITH p_msg1 p_msg2 p_msg3 p_msg4 INTO lv_text.
    CALL FUNCTION 'SAPGUI_PROGRESS_INDICATOR'
      EXPORTING
        text = lv_text.
  ELSE.
    MESSAGE i398 WITH p_msg1 p_msg2 p_msg3 p_msg4.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  TRATA_CABECALHO
*&---------------------------------------------------------------------*
* Consistir todos os campos da linha Header utilizados
*----------------------------------------------------------------------*
FORM trata_cabecalho USING p_wa_arquivo TYPE ty_arquivo p_arq_name CHANGING p_ignore_file.

* Validar se arquivo já processado anteriormente
  DATA(lv_process) = p_wa_arquivo-registro+731(10).

  SELECT znusq UP TO 1 ROWS
    INTO @DATA(lv_znusq)
    FROM zfipixt_retrec
    WHERE znusq = @lv_process.
  ENDSELECT.
  IF sy-subrc NE 0.
    SELECT znusq UP TO 1 ROWS
      INTO lv_znusq
      FROM zfipixt_retreg
      WHERE znusq = lv_process.
    ENDSELECT.
  ENDIF.
  IF sy-subrc EQ 0 AND lv_znusq IS NOT INITIAL.
* MSG:  arquivo & já processado anteriormente
    MESSAGE s398 WITH text-e06 p_arq_name text-e11 space DISPLAY LIKE c_e.
    RETURN.
    p_ignore_file = abap_true.
  ENDIF.

* Armazenar os valores dos campos que serão utilizados nos registros subsequentes
  gv_zdtge = p_wa_arquivo-registro+155(8).    "DATA DE GERAÇÃO DO ARQUIVO
  gv_znusq = p_wa_arquivo-registro+731(10).   "NÚMERO SEQUENCIAL DO RETORNO
  gv_paval = p_wa_arquivo-registro+36(8).     "Buscar PAVAL para ir na T001Z e capturar BUKRS
  gv_bankn = p_wa_arquivo-registro+54(20).    "Buscar BANKN para ir na T012K e capturar HBKID e HKTID  *******

* Buscar valor Empresa
  PERFORM:
    get_bukrs,
    get_hbkid_hktid.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  TRATA_REC
*&---------------------------------------------------------------------*
* Tratar todos os registros a serem inseridos na Tab Interna Recebimento
*----------------------------------------------------------------------*
FORM trata_rec USING p_wa_arquivo TYPE ty_arquivo.

*-------* Início - Wesley
*-------* Vaariáveis para conversão dos campos CURR
  DATA: lv_zvlor_dmbtr TYPE dmbtr,
        lv_zvljr_dmbtr TYPE dmbtr,
        lv_zvlmt_dmbtr TYPE dmbtr,
        lv_zvlab_dmbtr TYPE dmbtr,
        lv_zvlde_dmbtr TYPE dmbtr,
        lv_zvlfi_dmbtr TYPE dmbtr.

  wa_rec-zdtge  = gv_zdtge.
  wa_rec-znusq  = gv_znusq.
  wa_rec-ztprg  = p_wa_arquivo-registro+0(1).
  wa_rec-bukrs  = gv_bukrs.
  wa_rec-hbkid  = gv_hbkid.
  wa_rec-hktid  = gv_hktid.
  wa_rec-ztxid  = p_wa_arquivo-registro+1(35).
  wa_rec-zispb  = p_wa_arquivo-registro+36(8).
  wa_rec-ztpps  = p_wa_arquivo-registro+44(2).
  wa_rec-zcnpj  = p_wa_arquivo-registro+46(16).
  wa_rec-zagen  = p_wa_arquivo-registro+60(4).
  wa_rec-zconc  = p_wa_arquivo-registro+64(20).
  wa_rec-ztpco  = p_wa_arquivo-registro+84(4).
  wa_rec-zcpix  = p_wa_arquivo-registro+88(77).
  wa_rec-ztpcr  = p_wa_arquivo-registro+165(1).
  wa_rec-zcodm  = p_wa_arquivo-registro+166(2).
  wa_rec-zdtmv  = p_wa_arquivo-registro+168(8).
  wa_rec-zdtvc  = p_wa_arquivo-registro+176(8).
  wa_rec-ztime  = p_wa_arquivo-registro+184(14).
  DATA(lv_zvlor)  = p_wa_arquivo-registro+198(17). "CURR de 15 pos e 2 dec.
  DATA(lv_zvljr)  = p_wa_arquivo-registro+215(17). "CURR de 15 pos e 2 dec.
  DATA(lv_zvlmt)  = p_wa_arquivo-registro+232(17). "CURR de 15 pos e 2 dec.
  DATA(lv_zvlab)  = p_wa_arquivo-registro+249(17). "CURR de 15 pos e 2 dec.
  DATA(lv_zvlde)  = p_wa_arquivo-registro+266(17). "CURR de 15 pos e 2 dec.
  DATA(lv_zvlfi)  = p_wa_arquivo-registro+283(17). "CURR de 15 pos e 2 dec.
  DATA(lv_zvlpg)  = p_wa_arquivo-registro+300(17). "CURR de 15 pos e 2 dec.
  wa_rec-ztpdv  = p_wa_arquivo-registro+317(2).
  wa_rec-zcnpd  = p_wa_arquivo-registro+319(14).
  wa_rec-ztppf  = p_wa_arquivo-registro+333(2).
  wa_rec-zcnpf  = p_wa_arquivo-registro+335(14).
  wa_rec-znpgf  = p_wa_arquivo-registro+349(140).
  wa_rec-zmsgp  = p_wa_arquivo-registro+489(140).
  wa_rec-zendt  = p_wa_arquivo-registro+631(32).
  wa_rec-zrevs  = p_wa_arquivo-registro+663(4).
  wa_rec-zexre  = p_wa_arquivo-registro+667(60).
  wa_rec-ztarf  = p_wa_arquivo-registro+727(17).
  wa_rec-znseq  = p_wa_arquivo-registro+744(6).

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

*-------* Início - Fim

  APPEND wa_rec TO ti_rec.
  CLEAR  wa_rec.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  TRATA_REG
*&---------------------------------------------------------------------*
* Tratar todos os registros a serem inseridos na Tab I. Retorno Registro
*----------------------------------------------------------------------*
FORM trata_reg USING p_wa_arquivo TYPE ty_arquivo.

*-------* Início - Wesley
*-------* Vaariáveis para conversão dos campos CURR
  DATA: lv_zvlor_dmbtr TYPE dmbtr.

  wa_rec-zdtge  = gv_zdtge.
  wa_rec-znusq  = gv_znusq.
  wa_reg-ztprg  = p_wa_arquivo-registro+0(1).
  wa_reg-bukrs  = gv_bukrs.
  wa_reg-hbkid  = gv_hbkid.
  wa_reg-hktid  = gv_hktid.
  wa_reg-ztxid  = p_wa_arquivo-registro+1(36).
  wa_reg-ztpps  = p_wa_arquivo-registro+36(2).
  wa_reg-zcnpj  = p_wa_arquivo-registro+38(16).
  wa_reg-zagen  = p_wa_arquivo-registro+52(4).
  wa_reg-zconc  = p_wa_arquivo-registro+56(20).
  wa_reg-ztpco  = p_wa_arquivo-registro+76(4).
  wa_reg-zcpix  = p_wa_arquivo-registro+80(77).
  wa_reg-ztpcr  = p_wa_arquivo-registro+157(1).
  wa_reg-zcodm  = p_wa_arquivo-registro+158(2).
  wa_reg-zdtmv  = p_wa_arquivo-registro+559(8).
  wa_reg-zerro  = p_wa_arquivo-registro+567(30).
  wa_reg-zdtvl  = p_wa_arquivo-registro+182(8).
  wa_reg-ztime  = p_wa_arquivo-registro+160(14).
  wa_reg-zdtvc  = p_wa_arquivo-registro+174(8).
  DATA(lv_zvlor)  = p_wa_arquivo-registro+186(17). "CURR
  wa_reg-ztpdv  = p_wa_arquivo-registro+203(2).
  wa_reg-zcnpd  = p_wa_arquivo-registro+205(14).
  wa_reg-zndev  = p_wa_arquivo-registro+219(140).
  wa_reg-zrevs  = p_wa_arquivo-registro+597(4).
  wa_reg-zexre  = p_wa_arquivo-registro+499(60).
  wa_reg-znseq  = p_wa_arquivo-registro+744(6).

*-------* Conversão dos campos CURR:
  CONDENSE: lv_zvlor.
  MOVE lv_zvlor TO lv_zvlor_dmbtr.
  wa_reg-zvlor = lv_zvlor_dmbtr.

  APPEND wa_reg TO ti_reg.
  CLEAR  wa_reg.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  GET_BUKRS
*&---------------------------------------------------------------------*
* Buscar valor Empresa
*----------------------------------------------------------------------*
FORM get_bukrs .

  SELECT bukrs UP TO 1 ROWS
    INTO gv_bukrs
    FROM t001z
    WHERE paval EQ gv_paval
      AND party EQ 'J_1BCG'.
  ENDSELECT.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  GET_HBKID_HKTID
*&---------------------------------------------------------------------*
* Buscar o Banco Empresa e o ID da conta
*----------------------------------------------------------------------*
FORM get_hbkid_hktid .

* Limpando zeros a esquerda
  CONDENSE gv_bankn NO-GAPS.

  SELECT hbkid hktid UP TO 1 ROWS
    INTO ( gv_hbkid, gv_hktid )
    FROM t012k
    WHERE bankn EQ gv_bankn.
  ENDSELECT.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  MOVE_ARQ_PROCESSADOS
*&---------------------------------------------------------------------*
* Mover arquivo para Diretorio de Processados
*----------------------------------------------------------------------*
FORM move_arq_processados USING p_name_arq.

* Monta diretorio + arquivo.

  CONCATENATE:
    p_dir_in p_name_arq INTO DATA(lv_path_name),
    p_dirout p_name_arq INTO DATA(lv_path_name_p).

  IF p_unix = abap_true.

    OPEN DATASET lv_path_name IN TEXT MODE FOR INPUT ENCODING NON-UNICODE.
    IF sy-subrc EQ 0.
      OPEN DATASET lv_path_name_p IN TEXT MODE FOR OUTPUT ENCODING NON-UNICODE.
      IF sy-subrc EQ 0.
        LOOP AT ti_arquivo INTO DATA(wa_arquivo).
          TRANSFER wa_arquivo TO lv_path_name_p.
        ENDLOOP.
      ENDIF.
      CLOSE  DATASET lv_path_name_p.
      DELETE DATASET lv_path_name.
    ENDIF.

  ELSE.
    CALL METHOD cl_gui_frontend_services=>file_copy
      EXPORTING
        source               = lv_path_name
        destination          = lv_path_name_p
        overwrite            = 'X'
      EXCEPTIONS
        cntl_error           = 1
        error_no_gui         = 2
        wrong_parameter      = 3
        disk_full            = 4
        access_denied        = 5
        file_not_found       = 6
        destination_exists   = 7
        unknown_error        = 8
        path_not_found       = 9
        disk_write_protect   = 10
        drive_not_ready      = 11
        not_supported_by_gui = 12
        OTHERS               = 13.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  BUSCA_DIRETORIO
*&---------------------------------------------------------------------*
* Qual tipo sistema para abrir diretorio arquivos ?
*----------------------------------------------------------------------*
FORM busca_diretorio USING p_tipo CHANGING p_file.

  CASE abap_true.
    WHEN p_unix.
      PERFORM busca_unix           CHANGING p_file.
    WHEN p_local.
      IF p_tipo = c_i.
        PERFORM busca_local_abrir  CHANGING p_file.
      ELSE.
        PERFORM busca_local_salvar CHANGING p_file.
      ENDIF.
  ENDCASE.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  BUSCA_UNIX
*&---------------------------------------------------------------------*
* Mostrar diretorio para abrir/salvar arquivo.
*----------------------------------------------------------------------*
FORM busca_unix  CHANGING p_dir.

  CALL FUNCTION 'ZMF_GE_UNIX_DIR_TREE'
    EXPORTING
      input          = p_dir
      show_files     = space
    IMPORTING
      output         = p_dir
    EXCEPTIONS
      internal_error = 1
      wrong_path     = 2
      OTHERS         = 3.

  IF sy-subrc <> 0.
    MESSAGE e208 WITH text-e13.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  BUSCA_LOCAL_ABRIR
*&---------------------------------------------------------------------*
* Mostrar diretorio para abrir arquivo.
*----------------------------------------------------------------------*
FORM busca_local_abrir CHANGING p_arq.

  DATA: lt_table TYPE filetable,
        lv_title TYPE string,
        lw_table TYPE file_table,
        l_rc     TYPE i.

  lv_title      = text-003.

  CALL METHOD cl_gui_frontend_services=>file_open_dialog
    EXPORTING
      window_title            = lv_title
      default_extension       = gv_extension
      file_filter             = gv_filter
    CHANGING
      file_table              = lt_table
      rc                      = l_rc
    EXCEPTIONS
      file_open_dialog_failed = 1
      cntl_error              = 2
      error_no_gui            = 3
      not_supported_by_gui    = 4
      OTHERS                  = 5.

  IF sy-subrc <> 0.
    MESSAGE e208 WITH text-e13.
  ELSE.
    READ TABLE lt_table INTO lw_table INDEX 1.
    IF sy-subrc EQ 0.
      p_arq = lw_table-filename.
    ENDIF.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  BUSCA_LOCAL_SALVAR
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      <--P_P_FILE  text
*----------------------------------------------------------------------*
FORM busca_local_salvar CHANGING p_file.

  DATA: lv_path TYPE string,
        lv_nada TYPE string,
        lv_nda  TYPE string,
        lv_act  TYPE int4.

  CALL METHOD cl_gui_frontend_services=>file_save_dialog
    EXPORTING
      default_extension = gv_extension
      file_filter       = gv_filter
    CHANGING
      filename          = lv_nada
      path              = lv_path
      fullpath          = lv_nda
      user_action       = lv_act
    EXCEPTIONS
      cntl_error        = 1
      error_no_gui      = 2
      OTHERS            = 3.

  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
               WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

  IF lv_act EQ cl_gui_frontend_services=>action_ok.
    MOVE lv_path TO p_file.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  INICIA_VALORES
*&---------------------------------------------------------------------*
* Inicia variaveis
*----------------------------------------------------------------------*
FORM inicia_valores .

  p_dir_in     = c_dir_in.
  p_dirout     = c_dirout.
  gv_extension = text-001.
  gv_filter    = text-002.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  LIMPA_DIRETORIO
*&---------------------------------------------------------------------*
* Limpa os campos onde estão informados os caminhos dos arquivos
*----------------------------------------------------------------------*
FORM limpa_diretorio .

  IF sy-ucomm EQ 'ARQ'.
    IF p_local EQ abap_true.
      CLEAR: p_dir_in, p_dirout.
    ELSE.
      p_dir_in = c_dir_in.
      p_dirout = c_dirout.
    ENDIF.
  ENDIF.

ENDFORM.
