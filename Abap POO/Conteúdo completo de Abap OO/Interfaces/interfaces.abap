*Interfaces

"Define um conjunto de métodos (assinaturas de métodos) que uma classe deve implentar.
"Esses métodos definem o comportamento que a classe deve ter e como deve 
"interagir com outras classes e objetos.

REPORT ZR_INTERFACES.

*DEFINIÇÃO DA INTERFACE:
INTERFACE if_cumprimentar.
  METHODS cumprimentar.
ENDINTERFACE.

"DEFINIÇÕES DE CLASSES:
*zcl_pai
CLASS zcl_pai DEFINITION.
 PUBLIC SECTION.
 INTERFACES if_cumprimentar. "Aqui, declaro que implementarei essa interface. A partir de agora, essa classe é obrigada a implementar todos os métodos da classe em questão.
ENDCLASS.

*zcl_filho
CLASS zcl_filho DEFINITION.
 PUBLIC SECTION.
 INTERFACES if_cumprimentar.
ENDCLASS.

"IMPLEMENTAÇÕES DE CLASSES
*zcl_pai
CLASS zcl_pai IMPLEMENTATION.
 METHOD if_cumprimentar~cumprimentar. "Para indicar a implementação de uma interface faça o seguinte: Nome_da_interface~Nome_do_método.
  WRITE:/ 'Olá, pessoal!'.
 ENDMETHOD.
ENDCLASS.

*zcl_filho
CLASS zcl_filho IMPLEMENTATION.
 METHOD if_cumprimentar~cumprimentar.
  WRITE:/ 'Salve, galera!'.
 ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
"Temos duas formas de declarar/criar um objeto que usa interfaces.

*Forma 1:
DATA ol_pai TYPE REF TO if_cumprimentar. "Passo a interface como referência para a variável que será usada para criar o objeto.
     ol_pai = new zcl_pai( ).

     ol_pai->cumprimentar( ).

*Forma 2:
DATA ol_filho TYPE REF TO zcl_filho. "Passo a própria classe como referência para a variável que será usada para criar o objeto.
     ol_filho = new zcl_filho( ).

     ol_filho->if_cumprimentar~cumprimentar( ). "Na Forma 2, para acessar um método da interface, faça o seguinte: Nome_da_interface~Nome_do_método_da_interface( ).
