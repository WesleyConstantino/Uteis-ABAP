REPORT z_selects_type.

* Declarações
DATA :
  it_spfli   TYPE TABLE OF spfli,
  it_sflight TYPE TABLE OF sflight,
  st_spfli   TYPE spfli,
  st_sflight TYPE sflight
  .

* Select simples.
PERFORM f_simples.

* select com condição.
PERFORM f_condicao.

* Seleciona somente uma linha
PERFORM f_single.

* Seleciona somente uma linha, com UP TO 1 ROWS
PERFORM f_up_to_1_rows.

*  Seleciona somente as informações de um ou mais campos alimenta
* uma ou mais variáveis conforme condições.
PERFORM f_variavel.

*  Selecionando campos especificos e alimentando os respectivo
* campos da tabela/ estrutura.
PERFORM f_corresponding_fields.

*  Seleciona conforme informações específicas ( MAX, MIN, AVG, SUM, COUNT )
PERFORM f_agregados.


*&---------------------------------------------------------------------*
*&      Form  f_simples
*&---------------------------------------------------------------------*
FORM f_simples .

* Selecionou tudo da tabela SPFLI e colocou tudo numa tabela interna.
  SELECT *
    FROM spfli
    INTO TABLE it_spfli.

  BREAK-POINT.

  FREE it_spfli.

ENDFORM.                    " f_simples

*&---------------------------------------------------------------------*
*&      Form  f_condicao
*&---------------------------------------------------------------------*
FORM f_condicao .

* Selecionou somente os registros que se adequam a condição ( Carrid = AA e
* connid = '0064') da tabela transaparente SPFLI e colocou os registros
* dentro da tabela interna IT_SPFLI.
  SELECT *
    FROM spfli
    INTO TABLE it_spfli
    WHERE carrid = 'AA'
      AND connid = '0064'.

  BREAK-POINT.

  FREE it_spfli.


ENDFORM.                    " f_condicao

*&---------------------------------------------------------------------*
*&      Form  f_single
*&---------------------------------------------------------------------*
FORM f_single .

* Selecionou somente um registro (conforme condição)e jogou para uma
* estrutura.
  SELECT SINGLE *
    FROM spfli
    INTO st_spfli
    WHERE carrid = 'AA'
    .

  "  Obs. Caso todas as condições sejam chave da tabela, não será necessário
  " o uso do comando 'SINGLE' pois sempre retornará um registro.
  BREAK-POINT.

  CLEAR st_spfli.


ENDFORM.                    " f_single

*&---------------------------------------------------------------------*
*&      Form  f_up_to_1_rows
*&---------------------------------------------------------------------*  
FORM f_up_to_1_rows.  

* Com UP TO 1 ROWS; é semelhante ao SELECT SINGLE pois pega somente o primeiro registro, porém neste caso não há necessidade de passar todos os campos chaves na condição WHERE.
    SELECT znusq UP TO 1 ROWS
      INTO lv_znusq
      FROM zfipixt_retreg
      WHERE znusq = lv_process.
    ENDSELECT.
    
ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  f_variavel
*&---------------------------------------------------------------------*
FORM f_variavel .

  DATA :
    vl_cityfrom TYPE spfli-cityfrom,
    vl_cityto   TYPE spfli-cityto.

* Com uma variável
  SELECT SINGLE cityfrom
    FROM spfli
    INTO vl_cityfrom
    WHERE carrid = 'AA'.

  BREAK-POINT.

  CLEAR vl_cityfrom.

* Com mais variáveis
  SELECT SINGLE cityfrom cityto
    FROM spfli
    INTO (vl_cityfrom, vl_cityto)
    WHERE carrid = 'AA'.

  BREAK-POINT.

  CLEAR : vl_cityfrom , vl_cityto.


ENDFORM.                    " f_variavel

*&---------------------------------------------------------------------*
*&      Form  f_corresponding_fields
*&---------------------------------------------------------------------*
FORM f_corresponding_fields .

* Alimentando tabela
  SELECT carrid connid cityfrom cityto
    FROM spfli
    INTO CORRESPONDING FIELDS OF TABLE it_spfli
    .
  BREAK-POINT.
  FREE it_spfli.

* Alimentando estrutura
  SELECT SINGLE carrid connid cityfrom cityto
    FROM spfli
    INTO CORRESPONDING FIELDS OF st_spfli
    .
  BREAK-POINT.
  CLEAR st_spfli.


ENDFORM.                    " f_corresponding_fields

*&---------------------------------------------------------------------*
*&      Form  f_agregados
*&---------------------------------------------------------------------*
FORM f_agregados .

  DATA :
    vl_value TYPE i.

* Valor máximo para o campos determinado
  SELECT MAX( fltime )
    FROM spfli
    INTO vl_value.
  BREAK-POINT.
  CLEAR st_spfli.

* Valor Minimo para o campos determinado
  SELECT MIN( fltime )
    FROM spfli
    INTO vl_value.
  BREAK-POINT.
  CLEAR st_spfli.

*  Valor medio entre todos os registro ( com condição ) para
* campo determinado
  SELECT AVG( fltime )
    FROM spfli
    INTO vl_value
    WHERE carrid = 'AA'.
  BREAK-POINT.
  CLEAR st_spfli.

*  Soma entre todos os registro ( com condição ) para o campo
* determinado
  SELECT SUM( fltime )
    FROM spfli
    INTO vl_value
    WHERE carrid = 'JL'.
  BREAK-POINT.
  CLEAR st_spfli.

* Informa a quantidade de registro existentes
  SELECT COUNT( * )
    FROM spfli
    INTO vl_value.
  BREAK-POINT.
  CLEAR st_spfli.

ENDFORM.                    " f_agregados
