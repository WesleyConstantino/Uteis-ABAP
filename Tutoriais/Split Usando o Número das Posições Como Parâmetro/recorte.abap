Explicação:
<Local que Armazenaremos os Dados>  = <Workarea>-<Campo>+<Posição de Partida>(<Número de Posições a Pegar, Partindo da Posição informada Anteriormente>).

 wa_rec-ztprg  = p_wa_arquivo-registro+0(1).
 wa_rec-ztpps  = wa_arquivo-registro+44(2).

"Obs: Zero equivale a primeira posição na contagem doa campos.
"--------------------------------------------------------------------------------------------------------------------------------------------------------

"Suponhamos que fizemos o upload de um arquivo e jogamos dentro de uma tabela com um unico campo, como o mostrado abaixo

* Arquivo
"TYPES:
"  BEGIN OF ty_arquivo,
"    registro(750) TYPE c,
"  END OF ty_arquivo.

*----------------------------------------------------------------------*
* Tabelas                                                              *
*----------------------------------------------------------------------*
"DATA:  ti_rec     TYPE TABLE OF zfipixt_retrec,
"        ti_arquivo TYPE TABLE OF ty_arquivo.

*----------------------------------------------------------------------*
* Workareas                                                            *
*----------------------------------------------------------------------*
"DATA: wa_rec     TYPE zfipixt_retrec,

*&---------------------------------------------------------------------*
*&      Form  PROCESSAR_ARQUIVO
*&---------------------------------------------------------------------*
"FORM processar_arquivo .
"  LOOP AT ti_arquivo INTO DATA(wa_arquivo).

    wa_rec-ztpps  = wa_arquivo-registro+44(2). "Faço o split partindo da posição 44 da linha até a posição 45.

"  ENDLOOP.
"ENDFORM.
