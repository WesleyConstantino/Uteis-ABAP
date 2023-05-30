"CONV serve para converter um dado antes de passar para uma variável.
"Ex: 

DATA text TYPE c LENGTH 255.

"DATA(xstr) = cl_abap_codepage=>convert_to(
  source = CONV string( text )
" codepage = `UTF-8` ).

"Explicação: Na instrução "source = CONV string( text )", convertemos os dados vindos da variável "text" para o tipo "string" antes de passá-lo para "source".
*-------------------------------------------------------------------------------------------------------------------------------------------------------------*

"Outras formas: Posso usar CONV para converter também para campos de tabelas.
"Ex:

DATA: ID_KUNNR TYPE I.

KUNNR_007 = CONV BDCDATA-FVAL(ID_KUNNR).
