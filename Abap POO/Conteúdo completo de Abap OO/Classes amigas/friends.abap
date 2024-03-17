"O conceito de classes amigas nos permite declarar uma outra classe como friend, dentro da nossa classe, e essa outra classe que declaramos, 
"poderá acessar todos os métodos e atributos privados dentro dela. 

class ZCL_CLASS_1 definition
  public
  create public

  global friends ZCL_CLASS_2 . "Declaramos uma classe amiga com o comando "global friend".

public section.
protected section.
private section.

  methods DIZER_OLA .
ENDCLASS.

"Efeito: a classe ZCL_CLASS_2 poderá acessar o método privado da nossa classe.
