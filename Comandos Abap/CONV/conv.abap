"CONV serve para converter um dado antes de passar para uma variável.
"Ex: 

DATA text TYPE c LENGTH 255.

"DATA(xstr) = cl_abap_codepage=>convert_to(
  source = CONV string( text )
" codepage = `UTF-8` ).

"Explicação: Na instrução "source = CONV string( text )", convertemos os dados vindos de "source" para o tipo "string" antes de passá-lo para a variável "text".
