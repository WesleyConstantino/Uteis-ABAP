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
         VALUE(r_cpf) TYPE CHAR11.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA md_cpf  TYPE CHAR11. "Atributo
    DATA md_nome TYPE CHAR50. "Atributo
ENDCLASS.

"Implementação da classe
CLASS lcl_cliente IMPLEMENTATION.
  METHOD set_cpf.
   IF strlen( id_cpf ) NE 11.
     MESSAGE 'Insira um número de CPF com 11 carácteres!' TYPE 'S' DISPLAY LIKE 'E'.
     RETURN. "Return sai do método
   ENDIF.
   me->md_cpf = id_cpf.  "Atriguto md_cpf receberá o valor do parâmetro de entrada id_cpf
  ENDMETHOD.

  METHOD get_cpf.
   r_cpf = md_cpf.
  ENDMETHOD.
ENDCLASS.

"Chamada da classe e utilização do método no programa
START-OF-SELECTION.
  DATA: lo_cliente TYPE REF TO lcl_cliente. "Declaração do objeto

"Duas formas de criar o objeto da classe:
   lo_cliente = NEW lcl_cliente( ).
*  CREATE OBJECT lo_cliente.

"Acessando os métodos:
  lo_cliente->set_cpf( id_cpf = '55133866882' ). "Ctrl + espaço puxa os atributos do método.

  WRITE:/ lo_cliente->get_cpf( ). "Escreve o conteúdo da variável de retorno r_cpf
