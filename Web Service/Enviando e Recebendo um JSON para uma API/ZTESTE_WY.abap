"Este programa um JSON para a API http://postman-echo.com/post e ela retorna o JSON que enviei (espelho):

*&---------------------------------------------------------------------*
*& Report  ZTESTE_WY
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

report zteste_wy.

data: lv_status type i,
      lv_reason type string,
      lv_body   type string,
      lv_json   type string.

start-of-selection.

lv_json = '{"message":"Teste POST via FORM"}'.

perform call_webservice_post_json.


form call_webservice_post_json.

  data: lo_http        type ref to if_http_client,
        lv_url         type string,
        lv_json        type string,
        lv_response    type string,
        lv_xjson       type xstring,
        lt_resp_header type tihttpnvp,
        ls_resp_header type ihttpnvp,
        lv_status      type i,
        lv_reason      type string.

  " ==========================================================
  " URL do serviço
  " ==========================================================
  lv_url = 'http://postman-echo.com/post'.

  " JSON de exemplo (ajuste para o seu caso)
  lv_json = '{"message":"Teste ABAP POST JSON"}'.

  " ==========================================================
  " Invalida cache (igual à sua classe)
  " ==========================================================
  cl_http_server=>server_cache_invalidate(
    id    = |{ lv_url }*|
    type  = 0
    scope = 0
  ).

  " ==========================================================
  " Cria o HTTP client
  " ==========================================================
  cl_http_client=>create_by_url(
    exporting
      url    = lv_url
    importing
      client = lo_http
  ).

  if lo_http is not bound.
    message 'Erro ao criar HTTP client' type 'E'.
    return.
  endif.

  " ==========================================================
  " Método HTTP
  " ==========================================================
  lo_http->request->set_method(
    if_http_request=>co_request_method_post
  ).

  " ==========================================================
  " Headers (JSON + UTF-8)
  " ==========================================================
  lo_http->request->set_header_field(
    name  = 'Content-Type'
    value = 'application/json; charset=UTF-8'
  ).

  lo_http->request->set_header_field(
    name  = 'Accept'
    value = 'application/json'
  ).

  " ==========================================================
  " Converte STRING -> XSTRING UTF-8 (PONTO CRÍTICO)
  " ==========================================================
  lv_xjson = cl_abap_codepage=>convert_to(
               source   = lv_json
               codepage = 'UTF-8'
             ).

  " ==========================================================
  " Envia BODY como binário (igual REST moderno)
  " ==========================================================
  lo_http->request->append_data(
    data = lv_xjson
  ).

  " ==========================================================
  " SEND / RECEIVE
  " ==========================================================
  lo_http->send( ).
  lo_http->receive( ).

  " ==========================================================
  " Corpo da resposta
  " ==========================================================
  lv_response = lo_http->response->get_cdata( ).

  " ==========================================================
  " Headers da resposta (status code / reason)
  " ==========================================================
  lo_http->response->get_header_fields(
    changing
      fields = lt_resp_header
  ).

  read table lt_resp_header into ls_resp_header
       with key name = '~status_code'.
  if sy-subrc = 0.
    lv_status = ls_resp_header-value.
  endif.

  read table lt_resp_header into ls_resp_header
       with key name = '~status_reason'.
  if sy-subrc = 0.
    lv_reason = ls_resp_header-value.
  endif.

  " ==========================================================
  " Fecha conexão
  " ==========================================================
  lo_http->close( ).

  " ==========================================================
  " Resultado (debug / teste)
  " ==========================================================
  write: / 'HTTP Status:', lv_status,
         / 'Reason.....:', lv_reason,
         / 'Response...:', lv_response.

endform.
