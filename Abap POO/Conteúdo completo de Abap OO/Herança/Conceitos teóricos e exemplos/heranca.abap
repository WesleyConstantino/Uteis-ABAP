"Herança

*******Definição da classe pai**********
CLASS lcl_pai DEFINITION.
  PUBLIC SECTION.
  "Todos os métodos públicos podem ser acessados fora da classe e serão herdados pela classe filha.
    METHODS:
      set_cores
        IMPORTING
         id_cor_calca  TYPE CHAR10

    METHODS:
      get_cores
        RETURNING
         VALUE(r_cor_calca)  TYPE CHAR10.

  PROTECTED SECTION.
  "Todos os atributos protegidos não podem ser acessados diretamente fora da classe, esses atributos serão herdados pela classe filha.
   DATA md_cor_calca   TYPE CHAR10.

  PRIVATE SECTION.
  "Todos os atributos privados só poderão ser acessados pela classe pai, esse atributo não será herdado pela classe filha.
    DATA md_cor_gravata  TYPE CHAR10.
ENDCLASS.

*****Definição da classe filho******
CLASS lcl_filho DEFINITION INHERITING FROM lcl_pai.
  PUBLIC SECTION.
   DATA md_cor_bone  TYPE CHAR20.

    METHODS:
      get_cor_bone
        RETURNING
        VALUE(r_cor_bone) TYPE CHAR20.
ENDCLASS.
