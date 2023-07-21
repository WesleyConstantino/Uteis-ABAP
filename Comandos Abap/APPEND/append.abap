"O APPEND adiciona uma nova linha no final da sua tabela interna.

"– Para tabelas do tipo STANDARD, ele simplesmente adiciona a nova linha no final da tabela.
"– Para tabelas do tipo SORTED ele vai apendar contato que a nova linha siga a sequência da ordenação da tabela interna, e se a nova linha não criar uma linha duplicada.
"– Para tabelas do tipo HASHED, desencane porque não dá para appendar.

*************************************************************************************************************************************************************************
"Ex:
"Vamos ver o código do APPEND e algumas terminologias:

REPORT  zombie_append.

* Tabela principal e tabela para cópia.
DATA: t_mara  TYPE TABLE OF mara,
      t_mara2 TYPE TABLE OF mara INITIAL SIZE 10.
*      t_mara2 TYPE TABLE OF mara INITIAL SIZE 2.

* Work area genérica
DATA: wa_mara LIKE LINE OF t_mara.

* APPEND simples
wa_mara-matnr = '1'.
APPEND wa_mara TO t_mara.

* APPEND linha vazia
APPEND INITIAL LINE TO t_mara.

BREAK-POINT.

* APPEND seguido de SORT
wa_mara-matnr = '3'.
APPEND wa_mara TO t_mara2 SORTED BY matnr.

wa_mara-matnr = '1'.
APPEND wa_mara TO t_mara2 SORTED BY matnr.

wa_mara-matnr = '2'.
APPEND wa_mara TO t_mara2 SORTED BY matnr.

BREAK-POINT.

* APPEND de dados de uma tabela em outra tabela
APPEND LINES OF t_mara TO t_mara2.

BREAK-POINT.

***********************************************************************************************************************************************
"Explicação para cada um dos casos vistos acima:

"– O APPEND INITIAL LINE appenda uma linha vazia na tabela interna;
"– O APPEND LINES OF tab1 TO tab2 adiciona linhas de uma tabela em outra tabela.;
"– O APPEND wa1 TO tab1 SORTED BY faz o APPEND e na sequência já ordena a tabela do maior para o menor valor. Vale dizer que esse comando fica
"preso no tamanho máximo da área de memória da tabela (“INITIAL SIZE”), e se você ultrapassar o tamanho, o APPEND com SORTED BY apaga registros
"sem dó nem piedade. Comente a linha com INITIAL SIZE 10, e descomente a linha com INITIAL SIZE 2 para ver isso acontecendo.
