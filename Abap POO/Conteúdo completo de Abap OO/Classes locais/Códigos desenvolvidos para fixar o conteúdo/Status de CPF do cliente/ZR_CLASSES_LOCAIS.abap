REPORT ZR_CLASSES_LOCAIS.

"Definição da classe
CLASS lcl_cliente DEFINITION.
  PUBLIC SECTION. "Pode ser acessada livremente
    METHODS:
      set_cpf       "Método
        IMPORTING   "Parâmetros que o método irá receber
         id_cpf TYPE CHAR11.  "Parâmetro de entrada

    METHODS:
      get_cpf
        RETURNING "Retorna um valor para o programa chamador
         VALUE(r_cpf) TYPE CHAR14.

    METHODS:
      set_nome
        IMPORTING
         id_nome TYPE CHAR50.

    METHODS:
      get_nome
        RETURNING
         VALUE(r_nome) TYPE CHAR50.
  PROTECTED SECTION.
    DATA md_cpf  TYPE CHAR11. "Atributo
    DATA md_nome TYPE CHAR50. "Atributo
ENDCLASS.

CLASS lcl_status DEFINITION.
  PUBLIC SECTION.
    METHODS:
      informa_cliente
        IMPORTING
           id_cpf  TYPE CHAR14.

    METHODS:
      get_status
        RETURNING "Retorna um valor para o programa chamador
         VALUE(r_status) TYPE CHAR14.

  PRIVATE SECTION.
      METHODS:
      valida_status
        IMPORTING
         id_cpf  TYPE CHAR11.

    DATA md_cpf    TYPE CHAR11. "Atributo
    DATA md_nome   TYPE CHAR50. "Atributo
    DATA md_status TYPE CHAR1. "Atributo
ENDCLASS.

"Implementação da classe
CLASS lcl_status IMPLEMENTATION.

  METHOD informa_cliente.

   me->md_cpf = id_cpf.

   me->valida_status(  id_cpf =  md_cpf ).
  ENDMETHOD.

  METHOD valida_status.

   CASE md_cpf+10(1).
     WHEN '1'.
       me->md_status = '1'.
     WHEN '2'.
       me->md_status = '2'.
     WHEN '3'.
       me->md_status = '3'.
    ENDCASE.

  ENDMETHOD.

  METHOD get_status.

   CASE md_status.
    WHEN '1'.
     r_status = 'Ativo!'.
    WHEN '2'.
     r_status = 'Inativado!'.
    WHEN '3'.
     r_status = 'Ainda não cadastrado!'.
    ENDCASE.

  ENDMETHOD.

ENDCLASS.

CLASS lcl_cliente IMPLEMENTATION.
  METHOD set_cpf.
   IF strlen( id_cpf ) NE 11.
     MESSAGE 'Insira um número de CPF com 11 carácteres!' TYPE 'S' DISPLAY LIKE 'E'.
     RETURN. "Return sai do método
   ENDIF.
   me->md_cpf = id_cpf.  "Atriguto md_cpf receberá o valor do parâmetro de entrada id_cpf
  ENDMETHOD.

  METHOD get_cpf.
   CONCATENATE md_cpf+0(3) '.' md_cpf+3(3) '.' md_cpf+6(3) '-' md_cpf+9(2) INTO r_cpf.
*   r_cpf = md_cpf.
  ENDMETHOD.

   METHOD set_nome.
   me->md_nome = id_nome.
  ENDMETHOD.

  METHOD get_nome.
   IF md_cpf IS INITIAL.
     RETURN.
   ENDIF.
   r_nome = md_nome.
  ENDMETHOD.
ENDCLASS.

"Chamada da classe e utilização do método no programa
START-OF-SELECTION.
  DATA: lo_cliente TYPE REF TO lcl_cliente. "Declaração do objeto
  CREATE OBJECT lo_cliente.

"Acessando os métodos:
  lo_cliente->set_cpf( id_cpf = '55133866881' ). "Ctrl + espaço puxa os atributos do método.
  lo_cliente->set_nome( id_nome = 'Wesley Constantino').

  DATA: lo_status TYPE REF TO lcl_status.
  CREATE OBJECT lo_status.

   lo_status->informa_cliente( id_cpf = '55133866881'  ).

  WRITE:/ 'O CPF', lo_cliente->get_cpf( ), 'Pretence ao cliente', lo_cliente->get_nome( ),
        / 'que está com o status', lo_status->get_status( ).
