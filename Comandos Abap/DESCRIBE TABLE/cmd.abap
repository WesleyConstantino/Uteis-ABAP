"O comando DESCRIBE TABLE serve para contar quantas linhas existem numa tabela.

"Conta quantas linhas existem na tabela t_out e joga na variável lv_lines
DESCRIBE TABLE t_out LINES lv_lines.

"Outra forma de fazer a mesma coisa é atraves de lines()
lv_lines = lines( t_out ).
