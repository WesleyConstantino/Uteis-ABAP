   LOOP AT it_log_cli INTO DATA(ls_log_cli).
   DELETE it_ztbcliente WHERE rg = ls_log_cli-rg AND
                              cpf = ls_log_cli-cpf.
   ENDLOOP.
