*Polimorfismo

"O polimorfismo permite que objetos de diferentes classes possam se tratados 
"de forma uniforme, através do uso de métodos com o mesmo nome e assinatura, 
"mas com comportamentos diferentes em cada classe.

"Programa completo:
REPORT ZR_POLIMORFISMO.

****Definição de classes****
*lcl_pai
CLASS lcl_pai DEFINITION.
  PUBLIC SECTION.
    METHODS:
      cumprimentar.
ENDCLASS.

*lcl_filho
CLASS lcl_filho DEFINITION INHERITING FROM lcl_pai.
  PUBLIC SECTION.
    METHODS:
      cumprimentar REDEFINITION. "O comando REDEFINITION, nos permite redefinir um método de uma classe pai
ENDCLASS.

*lcl_filha
CLASS lcl_filha DEFINITION INHERITING FROM lcl_pai.
  "A classe lcl_filha, quero que seja exatamente igual a classe pai, por isso,
  "não precisso fazer nenhum implementação ou escrever códigos dentro dela.
ENDCLASS.

****Implementação de classe****
*lcl_pai
CLASS lcl_pai IMPLEMENTATION.
  METHOD cumprimentar.
   WRITE:/ 'Olá, pessoal!'.
  ENDMETHOD.
ENDCLASS.

*lcl_filho
CLASS lcl_filho IMPLEMENTATION.
  METHOD cumprimentar.
   WRITE:/ 'Salve, galera!'.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
"Referencio somente a classe pai:
DATA ol_classes TYPE REF TO lcl_pai.

"Crio o objto ol_classes referenciando classe pai:
ol_classes = NEW lcl_pai( ).
ol_classes->cumprimentar( ). "Resultado na execusão: Olá, pessoal!

"Crio o objto ol_classes referenciando classe filho:
ol_classes = NEW lcl_filho( ).
ol_classes->cumprimentar( ). "Resultado na execusão: Salve, galera!

"Crio o objto ol_classes referenciando classe filha:
ol_classes = NEW lcl_filha( ).
ol_classes->cumprimentar( ). "Resultado na execusão: Olá, pessoal!

**RESULTADO DA EXECUSÃO DO PROGRAMA:
""    Olá, pessoal!
"     Salve, galera!
"     Olá, pessoal!

*Conclusão: com um único objeto (ol_classes), referenciamos classes diferentes. No momento que referenciávamos uma, a outra deixava de existir.
