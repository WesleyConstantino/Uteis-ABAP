"CONCATENATE faz uma concatenação
"Ex:

"Estamos concatenando os conteúdos da variáveis "gv_path" e "lv_file_name" dentro de outra variável criada in line "lv_path_file".
  CONCATENATE gv_path lv_file_name INTO DATA(lv_path_file).


"Agora estamos concatenando os sinais de "%" com a variável "gv_path" dentro de outra variável criada in line "lv_path_file".
 CONCATENATE '%' gv_path '%'  INTO DATA(lv_path_file).
