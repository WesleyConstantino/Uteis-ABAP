REPORT ZR_ENCAPSULAMENTO.

*Definição da classe pai
CLASS lcl_pai DEFINITION.
  PUBLIC SECTION.
  "Todos os métodos públicos podem ser acessados fora da classe e serão herdados pela classe filha.
    METHODS:
      set_cores
        IMPORTING
         id_cor_calca  TYPE CHAR10
         id_cor_cabelo TYPE CHAR10.

    METHODS:
      get_cores
        RETURNING
         VALUE(r_cor_calca)  TYPE CHAR10.

  PROTECTED SECTION.
  "Todos os atributos protegidos não podem ser acessados diretamente fora da classe, esses atributos serão herdados pela classe filha.
   DATA md_cor_calca   TYPE CHAR10.
   DATA md_cor_cabelo  TYPE CHAR10.

  PRIVATE SECTION.
  "Todos os atributos privados só poderão ser acessados pela classe pai, esse atributo não será herdado pela classe filha.
    DATA md_cor_gravata  TYPE CHAR10.
ENDCLASS.

*Definição da classe filho
CLASS lcl_filho DEFINITION INHERITING FROM lcl_pai.
  PUBLIC SECTION.
   "md_cor_bone pode ter o valor passado fora da classe, pois é público.
   DATA md_cor_bone  TYPE CHAR20.

    METHODS:
      get_cor_bone
        RETURNING
        VALUE(r_cor_bone) TYPE CHAR20.
ENDCLASS.

*Implementação da classe pai
CLASS lcl_pai IMPLEMENTATION.
  METHOD set_cores     .
   me->md_cor_calca = id_cor_calca.
   me->md_cor_cabelo = id_cor_cabelo.
  ENDMETHOD.

  METHOD get_cores.
   r_cor_calca = md_cor_calca.
  ENDMETHOD.
ENDCLASS.

*Implementação da classe filho
CLASS lcl_filho IMPLEMENTATION.
  METHOD get_cor_bone .
   r_cor_bone = md_cor_bone.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

DATA: ol_filho TYPE REF TO lcl_filho,
      ol_pai   TYPE REF TO lcl_pai.

  CREATE OBJECT ol_filho.
  ol_pai = NEW lcl_pai( ).

**DICA: Ctrl + espaço dá um auto complete no método e puxa seus atributos e toda a estrutura.**

"O método abaixo possuí dois atributos, obrigatóriamente tenho que passar os dois, quando chamo o método:
  ol_pai->set_cores(
    EXPORTING
      id_cor_calca  = 'Azul'
      id_cor_cabelo = 'Castanho'
  ).

  ol_filho->md_cor_bone = 'Verde e branco'.

  "A classe filho herda o método set_cores da classse pai:
  ol_filho->set_cores(
    EXPORTING
      id_cor_calca  = 'Branca'
      id_cor_cabelo = 'Preto'
  ).


WRITE:/ 'Cor calça pai:', ol_pai->get_cores( ),
     "A classe filho herda o método get_cores da classe pai:
     / 'Cor calça filho:', ol_filho->get_cores( ), 'Cor boné filho:', ol_filho->get_cor_bone( ).
