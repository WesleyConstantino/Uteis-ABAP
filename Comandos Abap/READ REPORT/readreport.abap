*READ REPORT é um comando ABAP usado para ler o código fonte de um programa.

"Declaraçõs que foram usadas no report que encontrei o comando:
TYPES: BEGIN OF t_abapsource_long,  
         line TYPE char255,
       END OF   t_abapsource_long.

TYPES: t_tab_long_lines TYPE STANDARD TABLE OF t_abapsource_long.

DATA l_rep_name TYPE sobj_name. "sobj_name = elemento de dados CHAR de 40.

"No exemplo abaixo, a variável l_prog_tab_local contém o nome de um programa (report, classe, função...). O comando READ REPORT fará uma leitura
"de todas as linhas de código do programa e jogará dentro da variável l_abap_source.
READ REPORT l_prog_tab_local INTO l_abap_source.
