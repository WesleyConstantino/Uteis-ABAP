*READ REPORT é um comando ABAP usado para ler o código fonte de um programa.

"No exemplo abaixo, a variável l_prog_tab_local contém o nome de um programa (report, classe, função...). O comando READ REPORT fará uma leitura
"de todas as linhas de código do programa e jogará dentro da variável l_abap_source.
READ REPORT l_prog_tab_local INTO l_abap_source.
